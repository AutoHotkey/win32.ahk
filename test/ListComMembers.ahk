; Lists the members of a COM object.
#Requires AutoHotkey v2.1-alpha.37

MsgBox ListComMembers(ComObject("Scripting.Dictionary"))

ListComMembers(comObj) {
    #import "Win32\System.Com\Types" {ARRAYDESC}
    #import "Win32\System.Ole\Types" {ITypeInfo, IUnknown, IDispatch, IProvideClassInfo}
    #import "Win32\Foundation\API" {SysFreeString}
    
    (ARRAYDESC) ; FIXME: This is a workaround for initialization ordering issues.
    
    static InvKind := Map(1,"method", 2,"get", 4,"put", 8,"putref")
    GetTypeInfo(comObj) {
        if IsSet(pci := IUnknown(comObj).as(IProvideClassInfo))
            pci.GetClassInfo(&pti)
        else if ComObjType(comObj) = 9
            IDispatch(comObj).GetTypeInfo(0, 0, &pti)
        return pti
    }
    pti := comObj is ITypeInfo ? comObj : GetTypeInfo(comObj)
    
    pti.GetTypeAttr(&typeAttr)
    typeAttr_ := {t: typeAttr, __delete: _ => pti.ReleaseTypeAttr(_.t)}
    
    ; Get inherited or implemented interfaces.
    Loop typeAttr.cImplTypes {
        pti.GetRefTypeOfImplType(A_Index-1, &uRefType := -1)
        pti.GetRefTypeInfo(uRefType, &pti2)
        pti2.GetDocumentation(-1, &bsName,, 0)  ; pdwHelpContext isn't marked as [Optional].
        ; FIXME: BSTR has no custom projection yet.
        if StrGet(bsName.value.ptr) != "IDispatch"
            t .= ListComMembers(pti2) "`n"
        SysFreeString(bsName), bsName := unset
    }
    
    ; Get Member IDs.
    Loop typeAttr.cFuncs {
        pti.GetFuncDesc(A_Index-1, &funcDesc)
        funcDesc_ := {f: funcDesc, __delete: _ => pti.ReleaseFuncDesc(_.f)}
        
        pti.GetDocumentation(funcDesc.memid, &bsName,, 0)
        psName := bsName.value?.ptr ?? 0
        if psName { ; Exclude Members that didn't return a Name
            t .= InvKind[funcDesc.invkind] "`t"
                . funcDesc.cParams "`t"
                . StrGet(psName) "`n"
            SysFreeString(bsName), bsName := unset
        }
    }
    
    return Sort(SubStr(t,1,-1), "UD`n")
}
