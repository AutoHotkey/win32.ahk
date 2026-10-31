#Requires AutoHotkey v2.1-alpha.37
OutputRequires := "v2.1-alpha.37"
OutputDirectory := "test\Win32"
FileEncoding 'UTF-8'

mdm := mdModule.Open("Windows.Win32.winmd")

Namespaces := Map() ; [name] -> GatheredNamespace

AliasMap := Map(
    'Boolean', 'Boolean8',
    'Double', 'Float64',
    'Single', 'Float32',
    'Char16', 'UInt16',
    'System.Guid', 'GUID',
    'UIntPtr', 'IntPtr', ; Due to lack of UInt64 support in AutoHotkey.
    'UInt64', 'Int64',
)

DefinitionMap := Map(
    'PWSTR', '#Import Export "..\PWSTR.ahk" {PWSTR}`n',
    'IUnknown', '#Import Export "..\IUnknown.ahk" {IUnknown}`n',
)

(ReservedWordMap := Map()).CaseSense := false
loop parse 'and as contains false in is isset not or unset super true '
    . 'static global local if else loop for while until break continue '
    . 'goto return try catch finally switch case', ' '
    ReservedWordMap[A_LoopField] := true

; Parse all metadata and build the full Win32 projection.
Main()
Main() {
    beganAt := A_TickCount
    CollectMetadata
    for , ns in Namespaces
        BuildModuleForNamespace ns
    OutputDebug "Took " (A_TickCount - beganAt) " ms`n"
    
    ; Copy hand-coded files into the output directory.
    FileCopy "source\*", OutputDirectory "\", true
    FileCopy "winrt\guid.ahk", OutputDirectory "\", true
}


;@region Collect Metadata

#include "winrt\winmd.ahk"

/**
 * Functions for parsing metadata and packaging it into more usable objects.
 * These are specific to Win32metadata and our global mdModule instance (mdm).
 */

CollectMetadata() {
    typeDefs := Map() ; [TypeDef row number] -> GatheredType
    for td in mdm.EnumTypeDefs() {
        tdp := mdm.GetTypeDefProps(td)
        
        ; Get the namespace or class which contains this type
        if (tdp.flags & 7) >= 2 { ; tdNested...
            name := tdp.name
            scope := mdm.GetNestedClassProps(td)
            outer := typeDefs[scope.Row]
        } else {
            SplitName tdp.name, &name, &scope
            outer := Namespaces[scope] ??= GatheredNamespace(scope)
        }
        
        def := GatheredType(td, name)
        
        ; Map it even if it will be dropped below
        typeDefs[td.Row] := def
        
        def.attr := GetAttributes(td)
        
        arch := (def.attr['SupportedArchitecture']?)[1] ?? 7
        if arch == 4 || arch == 0 || !(arch & 2) ; FIXME: Dropping X86-specific definitions to avoid duplicates.
            continue ; Drop unsupported types (generally duplicates).
        
        ; Fields: structs, enum (underlying value), typedef (target type), Apis (constants)
        for fd in mdm.EnumFields(td) {
            fp := FieldInfo(fd)
            if fp.flags & 0x10 { ; fdStatic
                ; Win32metadata-specific: constants which aren't numbers or strings are encoded with
                ; either [Guid] or [Constant], with the latter being a struct initializer expression
                ; encoded as a string.
                fp.value ??= fp.attr['Guid'] ?? fp.attr['Constant'][1]
                ; TODO: Parse Constant initializer string and build code to construct a proper instance.
                def.constants.Push(fp)
            } else
                def.fields.Push(fp)
        }
        
        ; Methods: Apis (functions), interfaces, delegates
        for md in mdm.EnumMethods(td)
            def.methods.Push(MethodInfo(md))
        
        ; Implemented interfaces: interface base type
        for t in mdm.EnumInterfaceImpls(td) {
            if !(tdp.flags & 0x20) ; tdInterface
                unexpected "Type {} implements interfaces", tdp.name
            if A_Index != 1
                unexpected "Interface {} implements more than 1 other interface", tdp.name
            def.baseFullName := mdm.GetTypeRefProps(mdm.GetInterfaceImplProps(t).iface).name
        }
        
        basicType := tdp.extends.IsNull() ? "" : mdm.GetTypeRefProps(tdp.extends).name
        switch basicType, true {
            case 'System.ValueType':
                if def.attr.Has('NativeTypedef') {
                    def.kind := 'typedef'
                    if def.fields.Length != 1
                        unexpected "Typedef {} has {} fields", tdp.name, def.fields.Length
                } else if def.fields.Length + def.constants.Length == 0 && (clsid := def.attr['Guid'] ?? 0) {
                    ; Per https://github.com/microsoft/win32metadata/issues/271, some of these are what
                    ; we have in place of CLSID_* constants, but not all are CLSIDs.  windows-rs handles
                    ; this by just defining a GUID constant with the exact metadata name.
                    outer.constants[def.name] := {name: def.name, value: clsid}
                    continue
                } else {
                    def.kind := 'struct'
                }
                
            case 'System.Enum':
                def.kind := 'enum'
                if def.fields.Length != 1
                    unexpected "Enum {} has {} fields", tdp.name, def.fields.Length
                
            case 'System.MulticastDelegate':
                def.kind := 'delegate'
                ; A constructor exists for metadata consistency, but isn't real.
                if (def.methods[1].flags & 0x140) == 0 && def.methods[1].name == '.ctor' ; mdNewSlot | mdVirtual
                    def.methods.RemoveAt(1)
                ; Delegate should have exactly one virtual method, named Invoke.
                if def.methods.Length != 1 || def.methods[1].name !== 'Invoke'
                    unexpected "Delegate {} has unexpected methods", tdp.name
                
            case 'System.Object':
                if name !== 'Apis'
                    unexpected "Class is not API container or struct", tdp.name
                if (tdp.flags & 0x180) != 0x180 ; tdAbstract | tdSealed
                    unexpected "API class is not static", tdp.name
                if outer is GatheredType
                    unexpected "API class is nested", tdp.name
                ; Global functions and constants are contained within `static class Apis`.
                CollectApis(def, outer)
                continue
                
            case '':
                if !(tdp.flags & 0x20) ; tdInterface
                    unexpected "Type has null base but is not an interface", name
                def.kind := 'interface'
                
            case 'System.Attribute':
                ; Attribute classes are defined only for metadata purposes.
                continue
                
            default:
                ; Win32metadata doesn't define any classes with a superclass.
                unexpected "Base type not handled", basicType
        }
        
        ; Store CorTypeAttr flags (other tdp props are already handled).
        def.flags := tdp.flags
        
        if outer.typeMap.Has(name)
            unexpected "Duplicate type", name
            
        ; Map types by name but also retain sequence
        outer.typeMap[name] := def
        outer.typeList.Push(def)
    }
}

CollectApis(def, outer) {
    for mp in def.methods {
        if (mp.pinvoke.flags & 0x0700) > 0x0300
            unexpected "Fastcall or Thiscall API found", mp.name
        
        if av := mp.attr['SupportedArchitecture'] ?? 0 {
            arch := av[1]
            if !(arch & 3)
                continue ; Likely ARM64-specific.
            ; FIXME: Some APIs have separate x86 and x64 implementations; we only keep the last.
        }
        
        ; FIXME: A/W handling should be in the translation phase.
        if mp.attr.Has('Ansi') {
            name := mp.name
            if SubStr(name, -1) == 'A'
                name := SubStr(name, 1, -1)
            f := outer.functions.Delete(name 'W') ?? 0
            if f {
                outer.functions[name] := f
                f.name := name
                return
            }
        } else if mp.attr.Has('Unicode') {
            name := mp.name
            if SubStr(name, -1) == 'W'
                name := SubStr(name, 1, -1)
            f := outer.functions.Delete(name 'A') ?? outer.functions.Delete(name) ?? 0
            if f
                mp.name := name
        }
        
        outer.functions[mp.name] := mp
    }
    
    ; Copy constants from the Apis class into the module.
    outer.constants.Capacity := def.constants.Length
    for c in def.constants
        outer.constants[c.name] := c
}

MethodInfo(md) {
    mp := mdm.GetMethodProps(md)
    mp.attr := GetAttributes(md)
    if mp.flags & 0x2000 ; mdPInvokeImpl
        mp.pinvoke := mdm.GetPinvokeMap(mp.t) ; This corresponds to [DllImport].
    types := mdSignatureDecoder(mp.sig).Decode()
    args := []
    args.Length := types.Length ; includes return value at index 1
    for pd in mdm.EnumParams(md) {
        pp := mdm.GetParamProps(pd)
        pp.attr := GetAttributes(pd)
        args[pp.index + 1] := pp ; pp.index is 0 for return value
    }
    ret := args.RemoveAt(1) ?? {}
    ret.type := types.RemoveAt(1)
    for a in types
        (args[A_Index] ??= {index: A_Index}).type := a
    mp.args := args
    mp.ret := ret
    return mp
}

FieldInfo(fd) {
    fp := mdm.GetFieldProps(fd)
    if (fp.flags & 7) != 6
        unexpected "Field is not public", fp.name
    fp.attr := GetAttributes(fd)
    if fp.flags & 0x8000 ; hasDefault
        fp.value := mdGetFieldConstant(mdm, fd)
    fp.type := mdSignatureDecoder(fp.sig).Decode()
    return fp
}

AttributeInfo(tkAttr) {
    ap := mdm.GetCustomAttributeProps(tkAttr)
    mrp := mdm.GetMemberRefProps(ap.ctor)
    name := RegExReplace(mdm.GetTypeRefProps(mrp.parent).name, '^.*\.|Attribute$')
    return {
        name: name,
        data: name == 'Guid' ? GUID(ap.data.ptr + 2) : mdDecodeAttribData(ap.data, mrp.sig)
    }
}

GetAttributes(tk) {
    ats := Map()
    for at in mdm.EnumCustomAttributes(tk) {
        at := AttributeInfo(at)
        ats[at.name] := at.data
    }
    return ats
}

;@endregion

;@region Translate Metadata

/**
 * Functions which interpret metadata and partially translate to AutoHotkey types.
 */

TranslateType(t, def?, module) {
    if t is mdModifier {
        elementType := TranslateType(t.t, def?, module)
        if t is mdModifier.Ptr
            return elementType == 'Void' ? 'Struct.Ptr' : elementType '.Ptr'
        if t is mdModifier.Array {
            if t.ArraySize.Length != 1
                unexpected "Array type does not have 1 dimension", String(t)
            return elementType '[' t.ArraySize[1] ']'
        }
        unexpected "mdModifier type not handled", Type(t)
    }
    if t is String ; Name of primitive type
        return AliasMap[t] ?? t
    if !(t is mdToken)
        unexpected "Bad type", Type(t)
    if t.type == 'TypeRef'
        tp := mdm.GetTypeRefProps(t)
    else if t.type == 'TypeDef'
        tp := mdm.GetTypeDefProps(t)
    else
        unexpected "Bad token type", t.Type
    if a := AliasMap.Get(tp.name, false)
        return a ; Guid?
    if tp.scope?.t != 1 ?? false {
        if tp.scope.type !== 'TypeRef' {
            if SubStr(tp.name, 1, 8) == 'Windows.'
                return 'UnsupportedType("' tp.name '")'
            unexpected 'Unhandled scope type {} for type "{}"', tp.scope.type, tp.name
        }
        ; These checks are to ensure that we don't unknowingly reference the wrong type.
        ; Compare each scope by name (could be a struct in a union in a struct, etc.).
        ; mdm.FindTypeDefByName() == def.td won't work as a shortcut because of the
        ; presence of duplicate type names with different [SupportedArchitecture(n)].
        referencedTRP := mdm.GetTypeRefProps(tp.scope)
        if !IsSet(def)
            unexpected "Type {} in {} was referenced in an unknown scope", tp.name, referencedTRP.name
        thisTD := def.td
        loop {
            thisTDP := mdm.GetTypeDefProps(thisTD)
            thisIsNested := (thisTDP.flags & 7) >= 2 ; tdNested..
            if thisTDP.name !== referencedTRP.name || thisIsNested != (referencedTRP.scope.t != 1)
                unexpected "TypeRef to nested class outside current class"
            if !thisIsNested
                break
            referencedTRP := mdm.GetTypeRefProps(referencedTRP.scope)
            thisTD := mdm.GetNestedClassProps(thisTD)
        }
        return 'this.' tp.name
    }
    SplitName tp.name, &origName, &moduleName
    ourName := Namespaces[moduleName].typeMap[origName]?.name
    if !IsSet(ourName)
        return 'UnsupportedType("' tp.name '")'
    if moduleName == module.name
        return ourName
    return module.Import(moduleName, ourName)
}

PrepareType(def, module) {
    if def.flags & 0x20
        PrepareInterface(def, module)
    for mp in def.methods
        PrepareMethod(mp, def, module)
    for subdef in def.typeList
        PrepareType(subdef, module)
    
    words := Map()
    words.CaseSense := false
    words.Default := 0
    for fp in def.fields ?? [] {
        ; Detect name conflicts
        if fp1 := words[name := fp.name] ?? 0 {
            if words.Has(name '_1') || words.Has(name '_2') || fp1 == 1
                unexpected "More complex renaming is needed"
            OutputDebug "renaming " fp.name " in " module.name "." def.name "`n"
            fp1.name .= '_1'
            fp.name := name .= '_2'
            words[fp1.name] := 1
        }
        words[name] := fp
        ; Translate type
        fp.ctype := TranslateType(fp.type, def, module)
    }
}

PrepareInterface(def, module) {
    ; Recurse to handle base interfaces which haven't been prepared yet.
    static recurse(def, module) {
        if !HasProp(def,'baseFullName') ; No base (it's either IUnknown itself or not a COM interface).
            return 0
        ; Resolve Win32 name to GatheredType.
        SplitName def.baseFullName, &baseName, &refScope
        baseNS := Namespaces[refScope]
        baseType := baseNS.typeMap[baseName]
        ; Determine base's variable name, importing if needed.
        def.baseName := refScope == module.name
            ? baseType.name : module.Import(refScope, baseType.name)
        ; Calculate vtOffsets.
        return baseType.methods.Length
            + (baseType.vtOffset ??= recurse(baseType, baseNS.typeModule))
    }
    
    def.vtOffset ??= recurse(def, module)
    
    ; Find any method overloads which would cause naming conflicts, and rename them.
    ; TODO: Support method overloads without renaming (by combining them into one script method).
    names := Map()
    names.CaseSense := false
    names.Default := 0
    for mp in def.methods {
        n := names[mp.name] += 1
        if n > 1
            mp.name .= '_' n
    }
}

PrepareMethod(mp, tscope?, module) {
    ; Resolve type references
    for a in mp.args
        a.ctype := TranslateType(a.type, tscope?, module)
    mp.ret.ctype := TranslateType(mp.ret.type, tscope?, module)
    
    ; Fix naming conflicts between parameters and types/reserved words
    words := ReservedWordMap.Clone()
    for a in mp.args {
        words[a.ctype] := 1
    }
    for a in mp.args {
        name := a.name
        while words.Has(name)
            name := a.name A_Index
        words[a.name := name] := 2
    }
    
    ; Handle parameter attributes
    for a in mp.args {
        i := unset
        for at_name, at_data in a.attr {
            switch at_name {
                case 'NativeArrayInfo':
                    if !IsSet(i := at_data.CountParamIndex?) {
                        ; i := at_data.CountConst ?? at_data.CountFieldName
                        ; notes .= Format('arg #{} ({}) is a fixed-size array of [{}]`n', a.index, a.name, i)
                    } else {
                        ++i
                        mp.args[i].argPass := mp.args[i].ctype ', '
                            . a.name ((a.flags & 0x10) ? '?.Length ?? 0' : '.Length')
                        mp.args[i].argDef := ''
                        ; TODO: Verify whether this is correct for different in/out combinations (as per MemorySize).
                    }
                case 'MemorySize':
                    i := at_data.BytesParamIndex + 1
                    switch mp.args[i].flags & 0x13 {
                        case 1, 0x11:   ; [In], [In][Optional]
                            mp.args[i].argPass := mp.args[i].ctype ', '
                                . a.name ((a.flags & 0x10) ? '?.Size ?? 0' : '.Size')
                            mp.args[i].argDef := ''
                        case 2, 0x12:   ; [Out], [Out][Optional]
                            ; TODO: Probably project the two args as one Bufferlike.
                        case 3:         ; [In][Out]
                            ; Define and pass as separate parameters, same as default.
                        case 0x13:      ; [In][Out][Optional]
                            mp.args[i].argDef := mp.args[i].name ' := ' a.name '.Size'
                        default:
                            unexpected "Unhandled parameter flags"
                    }
                case 'Const':
                    ;pass
                case 'Reserved':
                    a.argPass := '"Ptr", 0'
                    a.argDef := ''
                default:
                    ; notes .= Format('arg #{} ({}) has [{}]`n', a.index, a.name, at_name)
            }
        }
        
        a.argDef ??= a.name ((a.flags & 0x10) ? '?' : '')
        if !IsSet(a.argPass) {
            ctype := a.ctype
            if ctype == 'PWSTR' && (a.flags & 3) == 1
                ctype := '"Str"'
            a.argPass := ctype ', ' a.name ((a.flags & 0x10) ? '?' : '')
        }
    }
    ; TODO: Check for attributes on mp.ret, such as RAIIFree, DoNotRelease
    switch mp.retType := mp.ret.ctype, true {
        case 'Void':
            mp.retType := '"void"'
        case 'HRESULT':
            if !mp.attr.Has('CanReturnErrorsAsSuccess')
                mp.retType := '"HRESULT"'
    }
}

;@endregion

;@region Build Projection

/**
 * Functions which build the projection source code and write to file.
 */

BuildModuleForNamespace(ns) {
    OutputDebug '# ' ns.name '`n'
    
    ; Collect names for detection of conflicts between modules, such as Rect vs. RECT.
    ; Conflicts within the same module are very rare, so we just append '_2' in that case.
    ; We also strip leading underscores for #Import {*}, unless that would cause a conflict.
    vars := ns.typeModule.vars
    for def in ns.typeList {
        if SubStr(def.name,1,1) == '_' && !ns.typeMap.Has(LTrim(def.name, '_'))
            def.name := LTrim(def.name, '_')
        if conflict := vars[def.name] ?? 0 {
            if vars.Has(def.name '_1') || vars.Has(def.name '_2')
                unexpected "More complex renaming needed"
            OutputDebug "renaming " def.name " in " ns.name "`n"
            conflict.name .= '_1'
            vars[conflict.name] := conflict
            def.name .= '_2'
        }
        vars[def.name] := def
    }
    
    for def in ns.typeList
        PrepareType(def, ns.typeModule)
    
    for , mp in ns.functions
        PrepareMethod(mp, unset, ns.apiModule)
    
    DirCreate dir := OutputDirectory "\" ns.name
    FileOpen(dir "\__Init.ahk", 'w`n').WriteLine("
    (
        #Import Export "Constants.ahk" {*}
        #Import Export "Types.ahk" {*}
        #Import Export "API.ahk" {*}
    )")
    fApis := FileOpen(dir "\API.ahk", 'w`n')
    fConst := FileOpen(dir "\Constants.ahk", 'w`n')
    fTypes := FileOpen(dir "\Types.ahk", 'w`n')
    requires := '#Requires AutoHotkey ' OutputRequires '`n'
    fTypes.WriteLine requires '#Include "..\_header.ahk"'
    fApis.WriteLine requires '#Include "..\_header.ahk"'
    fApis.WriteLine '#Import "Types.ahk" {*}'
    
    writeImports(f, m) {
        local imps := ''
        for modName, namesMap in m.imports {
            imps .= '#Import "..\' modName '\Types.ahk" {'
            for impName, impAlias in namesMap
                imps .= (A_Index > 1 ? ', ' : '') impName (impAlias != '' ? ' as ' impAlias : '')
            imps .= '}`n'
        }
        f.WriteLine imps
    }
    writeImports fApis, ns.apiModule
    writeImports fTypes, ns.typeModule
    
    static buildMap := Map(
        'delegate',     BuildDelegate,
        'enum',         BuildEnum,
        'interface',    BuildInterface,
        'struct',       BuildStruct,
        'typedef',      BuildTypedef,
    )
    for def in ns.typeList
        fTypes.Write DefinitionMap[def.name] ?? buildMap[def.kind](def)
    
    for , def in ns.constants
        if !ReservedWordMap.Has(def.name)
            fConst.Write BuildConstant(def)
    
    for , def in ns.functions
        fApis.Write BuildFunction(def)
}

BuildStruct(def) {
    comment := ''
    decls := ''
    
    ; FIXME: Take [StructLayout(Pack = 2)] into account.
    for fp in def.fields {
        decls .= fp.name ' : ' fp.ctype
            . ((def.attr['StructSizeField']?)[1] = fp.name ? ' := this.Size' : '' ?? '')
            . '`n'
    }
    
    ; tdExplicitLayout (0x10): Win32metadata uses this for unions. For other modules we might have
    ; needed to look up FieldOffset in the FieldLayout table, but for Win32metadata it's always 0.
    if def.flags & 0x10
        decls := 'union {`n' indent(decls) '}`n'
    
    for t in def.typeList {
        if t.kind !== 'struct'
            unexpected "{} inside struct", t.kind
        decls .= BuildStruct(t)
    }
    
    return comment
        . 'struct ' def.name ' {`n'
        . indent(decls)
        . '}`n'
}

BuildTypedef(def) {
    tt := def.fields[1].ctype
    if tt = 'Struct.Ptr' && SubStr(def.name,1,1) == 'H'
        tt := 'IntPtr'
    return 'struct ' def.name ' {`n'
        . indent('Value : ' tt '`n')
        . '}`n'
}

BuildDelegate(def) {
    ; Calling convention for function pointers is specified via this attribute.
    cconv := def.attr['UnmanagedFunctionPointer'][1]
    if cconv > 3
        return '; Function pointer type ' def.name ' was omitted due to calling convention (' cconv ').`n'
    
    invoke := def.methods[1]
    types := ''
    for a in invoke.args {
        ; TODO: Consider attributes such as MemorySize and NativeArrayInfo.
        types .= a.ctype ', '
    }
    rt := invoke.ret.ctype ; not retType (don't transform HRESULT)
    if rt == 'Void'
        rt := '"Void"'
    types .= rt
    
    body := 'static Types := [' types ']`n'
        . (cconv == 2 ? 'static Options := "C"`n' : '')
    return 'struct ' def.name ' extends FunctionPointer {`n'
        . indent(body)
        . '}`n'
}

BuildEnum(def) {
    uType := def.fields[1].ctype
    decls := ""
    for c in def.constants
        decls .= 'static ' c.name ' := ' c.value '`n'
    return 'struct ' def.name ' extends ' uType ' {`n'
        . indent(decls)
        . '}`n'
}

BuildConstant(def) {
    ; FIXME: Some numeric constants are supposed to have type PWSTR, e.g. TD_ERROR_ICON.
    return def.name ' := ' (def.value is Number ? def.value
        : '"' Escape(String(def.value)) '"') '`n'
}

BuildInterface(def) {
    body := ''
    if def.attr.Has('Guid')
        body .= 'static IID := "' String(def.attr['Guid']) '"`n'
    ; else
        ; OutputDebug "Missing IID: " def.name " (" ns.name ")`n"
    for mp in def.methods {
        ; TODO: Implement property getter/setter (handle flag SpecialName := 0x800)
        ; TODO: Consider attributes: Ansi, Unicode, Obsolete
        defArgs := ''
        callArgs := ''
        for a in mp.args {
            if a.argDef != ''
                defArgs .= (defArgs != '' ? ', ' : '') a.argDef
            if a.argPass != ''
                callArgs .= ', ' a.argPass
        }
        if mp.retType != '"hresult"'
            callArgs .= ', ' mp.retType
        body .= mp.name '(' defArgs ')`n' 
            . '  => ComCall(' (def.vtOffset + A_Index - 1) ', this.p' callArgs ')`n'
    }
    return 'struct ' def.name ' extends ' (def.baseName ?? 'InterfacePointer') ' {`n'
        . indent(body)
        . '}`n'
}

BuildFunction(def) {
    s := ''
    for a in def.args
        if a.argDef != ''
            s .= (s != '' ? ', ' : '') . a.argDef
    s := def.name '(' s ')`n  => DllCall("' def.pinvoke.dll '\' def.pinvoke.name '"'
    for a in def.args {
        s .= ', ' a.argPass
    }
    s .= ', ' def.retType ')`n'
    return s
}

;@endregion

;@region Classes

; Holds all gathered type metadata for a given namespace, sorted by basic type.
class GatheredNamespace {
    constants := Map() ; [name] -> ConstInfo
    functions := Map() ; [name] -> MethodInfo
    typeMap := Map() ; [name] -> GatheredType
    typeList := [] ; GatheredType[]
    typeModule := ProjectedModule()
    apiModule := ProjectedModule()
    __new(name) {
        this.name := name
        this.apiModule.name := name
        this.typeModule.name := name
    }
}

; Holds all gathered metadata for a given type (struct, enum, typedef, delegate or interface).
class GatheredType {
    constants := []
    fields := []
    methods := []
    typeMap := Map()
    typeList := []
    __new(td, name) {
        this.td := td
        this.name := name
    }
}

; This is currently just used to track dependencies for import.
class ProjectedModule {
    name := unset
    vars := Map()
    vars.CaseSense := false
    imports := Map()
    Import(module, name) {
        impmap := this.imports[module] ??= Map()
        if IsSet(alias := impmap[name]?)
            return alias || name
        if this.vars.Has(name) {
            alias := '_' RegExReplace(module, '[a-z\.]') '_' name
            if this.vars.Has(alias)
                unexpected "Unlikely alias {} already in use in module {}", alias, this.name
        }
        impmap[name] := alias ?? ''
        return alias ?? name
    }
}

;@endregion

;@region Utility

/**
 * Utility functions for this script, without much general reuse value.
 */

SplitName(fullname, &name, &nsname) {
    i := InStr(fullname, '.',, -1)
    nsname := i ? SubStr(fullname, 1, i - 1) : ""
    if i && SubStr(nsname, 1, 14) !== 'Windows.Win32.'
        unexpected "Namespace is not Windows.Win32.*", nsname
    nsname := SubStr(nsname, 15)
    name := SubStr(fullname, i + 1)
}

unexpected(message, values*) {
    if InStr(message, "{")
        message := Format(message, values*)
    else if values.Length
        extra := values[-1]
    ;@Debug-Breakpoint
    throw Error(message, -1, extra?)
}

indent(s) => RegExReplace(s, 'm)^(?=.)', "    ")

Escape(s) {
    static esc := Map("`n", "n", "`r", "r", "`b", "b", "`t", "t", "`v", "v", "`a", "a", "`f", "f")
    return RegExReplace(s, "[`n`r`b`t`v`a`f``'`"]", m => '``' (esc[m[0]] ?? m[0]))
}

;@endregion