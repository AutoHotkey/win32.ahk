#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {IStream, ITypeInfo, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct ROPARAMIIDHANDLE {
    Value : Struct.Ptr
}
struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL {
    _bitfield1 : UInt32
    _bitfield2 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ClassToken : UInt32
            FilterOffset : UInt32
        }
    }
}
struct COINITICOR extends Int32 {
    static COINITCOR_DEFAULT := 0
}
struct COINITIEE extends Int32 {
    static COINITEE_DEFAULT := 0
    static COINITEE_DLL := 1
    static COINITEE_MAIN := 2
}
struct COUNINITIEE extends Int32 {
    static COUNINITEE_DEFAULT := 0
    static COUNINITEE_DLL := 1
}
struct ReplacesGeneralNumericDefines extends Int32 {
    static IMAGE_DIRECTORY_ENTRY_COMHEADER := 14
}
struct CorTypeAttr extends Int32 {
    static tdVisibilityMask := 7
    static tdNotPublic := 0
    static tdPublic := 1
    static tdNestedPublic := 2
    static tdNestedPrivate := 3
    static tdNestedFamily := 4
    static tdNestedAssembly := 5
    static tdNestedFamANDAssem := 6
    static tdNestedFamORAssem := 7
    static tdLayoutMask := 24
    static tdAutoLayout := 0
    static tdSequentialLayout := 8
    static tdExplicitLayout := 16
    static tdClassSemanticsMask := 32
    static tdClass := 0
    static tdInterface := 32
    static tdAbstract := 128
    static tdSealed := 256
    static tdSpecialName := 1024
    static tdImport := 4096
    static tdSerializable := 8192
    static tdWindowsRuntime := 16384
    static tdStringFormatMask := 196608
    static tdAnsiClass := 0
    static tdUnicodeClass := 65536
    static tdAutoClass := 131072
    static tdCustomFormatClass := 196608
    static tdCustomFormatMask := 12582912
    static tdBeforeFieldInit := 1048576
    static tdForwarder := 2097152
    static tdReservedMask := 264192
    static tdRTSpecialName := 2048
    static tdHasSecurity := 262144
}
struct CorMethodAttr extends Int32 {
    static mdMemberAccessMask := 7
    static mdPrivateScope := 0
    static mdPrivate := 1
    static mdFamANDAssem := 2
    static mdAssem := 3
    static mdFamily := 4
    static mdFamORAssem := 5
    static mdPublic := 6
    static mdStatic := 16
    static mdFinal := 32
    static mdVirtual := 64
    static mdHideBySig := 128
    static mdVtableLayoutMask := 256
    static mdReuseSlot := 0
    static mdNewSlot := 256
    static mdCheckAccessOnOverride := 512
    static mdAbstract := 1024
    static mdSpecialName := 2048
    static mdPinvokeImpl := 8192
    static mdUnmanagedExport := 8
    static mdReservedMask := 53248
    static mdRTSpecialName := 4096
    static mdHasSecurity := 16384
    static mdRequireSecObject := 32768
}
struct CorFieldAttr extends Int32 {
    static fdFieldAccessMask := 7
    static fdPrivateScope := 0
    static fdPrivate := 1
    static fdFamANDAssem := 2
    static fdAssembly := 3
    static fdFamily := 4
    static fdFamORAssem := 5
    static fdPublic := 6
    static fdStatic := 16
    static fdInitOnly := 32
    static fdLiteral := 64
    static fdNotSerialized := 128
    static fdSpecialName := 512
    static fdPinvokeImpl := 8192
    static fdReservedMask := 38144
    static fdRTSpecialName := 1024
    static fdHasFieldMarshal := 4096
    static fdHasDefault := 32768
    static fdHasFieldRVA := 256
}
struct CorParamAttr extends Int32 {
    static pdIn := 1
    static pdOut := 2
    static pdOptional := 16
    static pdReservedMask := 61440
    static pdHasDefault := 4096
    static pdHasFieldMarshal := 8192
    static pdUnused := 53216
}
struct CorPropertyAttr extends Int32 {
    static prSpecialName := 512
    static prReservedMask := 62464
    static prRTSpecialName := 1024
    static prHasDefault := 4096
    static prUnused := 59903
}
struct CorEventAttr extends Int32 {
    static evSpecialName := 512
    static evReservedMask := 1024
    static evRTSpecialName := 1024
}
struct CorMethodSemanticsAttr extends Int32 {
    static msSetter := 1
    static msGetter := 2
    static msOther := 4
    static msAddOn := 8
    static msRemoveOn := 16
    static msFire := 32
}
struct CorDeclSecurity extends Int32 {
    static dclActionMask := 31
    static dclActionNil := 0
    static dclRequest := 1
    static dclDemand := 2
    static dclAssert := 3
    static dclDeny := 4
    static dclPermitOnly := 5
    static dclLinktimeCheck := 6
    static dclInheritanceCheck := 7
    static dclRequestMinimum := 8
    static dclRequestOptional := 9
    static dclRequestRefuse := 10
    static dclPrejitGrant := 11
    static dclPrejitDenied := 12
    static dclNonCasDemand := 13
    static dclNonCasLinkDemand := 14
    static dclNonCasInheritance := 15
    static dclMaximumValue := 15
}
struct CorMethodImpl extends Int32 {
    static miCodeTypeMask := 3
    static miIL := 0
    static miNative := 1
    static miOPTIL := 2
    static miRuntime := 3
    static miManagedMask := 4
    static miUnmanaged := 4
    static miManaged := 0
    static miForwardRef := 16
    static miPreserveSig := 128
    static miInternalCall := 4096
    static miSynchronized := 32
    static miNoInlining := 8
    static miAggressiveInlining := 256
    static miNoOptimization := 64
    static miSecurityMitigations := 1024
    static miUserMask := 5628
    static miMaxMethodImplVal := 65535
}
struct CorPinvokeMap extends Int32 {
    static pmNoMangle := 1
    static pmCharSetMask := 6
    static pmCharSetNotSpec := 0
    static pmCharSetAnsi := 2
    static pmCharSetUnicode := 4
    static pmCharSetAuto := 6
    static pmBestFitUseAssem := 0
    static pmBestFitEnabled := 16
    static pmBestFitDisabled := 32
    static pmBestFitMask := 48
    static pmThrowOnUnmappableCharUseAssem := 0
    static pmThrowOnUnmappableCharEnabled := 4096
    static pmThrowOnUnmappableCharDisabled := 8192
    static pmThrowOnUnmappableCharMask := 12288
    static pmSupportsLastError := 64
    static pmCallConvMask := 1792
    static pmCallConvWinapi := 256
    static pmCallConvCdecl := 512
    static pmCallConvStdcall := 768
    static pmCallConvThiscall := 1024
    static pmCallConvFastcall := 1280
    static pmMaxValue := 65535
}
struct CorAssemblyFlags extends Int32 {
    static afPublicKey := 1
    static afPA_None := 0
    static afPA_MSIL := 16
    static afPA_x86 := 32
    static afPA_IA64 := 48
    static afPA_AMD64 := 64
    static afPA_ARM := 80
    static afPA_NoPlatform := 112
    static afPA_Specified := 128
    static afPA_Mask := 112
    static afPA_FullMask := 240
    static afPA_Shift := 4
    static afEnableJITcompileTracking := 32768
    static afDisableJITcompileOptimizer := 16384
    static afRetargetable := 256
    static afContentType_Default := 0
    static afContentType_WindowsRuntime := 512
    static afContentType_Mask := 3584
}
struct CorManifestResourceFlags extends Int32 {
    static mrVisibilityMask := 7
    static mrPublic := 1
    static mrPrivate := 2
}
struct CorFileFlags extends Int32 {
    static ffContainsMetaData := 0
    static ffContainsNoMetaData := 1
}
struct CorPEKind extends Int32 {
    static peNot := 0
    static peILonly := 1
    static pe32BitRequired := 2
    static pe32Plus := 4
    static pe32Unmanaged := 8
    static pe32BitPreferred := 16
}
struct CorGenericParamAttr extends Int32 {
    static gpVarianceMask := 3
    static gpNonVariant := 0
    static gpCovariant := 1
    static gpContravariant := 2
    static gpSpecialConstraintMask := 28
    static gpNoSpecialConstraint := 0
    static gpReferenceTypeConstraint := 4
    static gpNotNullableValueTypeConstraint := 8
    static gpDefaultConstructorConstraint := 16
}
struct CorElementType extends UInt8 {
    static ELEMENT_TYPE_END := 0
    static ELEMENT_TYPE_VOID := 1
    static ELEMENT_TYPE_BOOLEAN := 2
    static ELEMENT_TYPE_CHAR := 3
    static ELEMENT_TYPE_I1 := 4
    static ELEMENT_TYPE_U1 := 5
    static ELEMENT_TYPE_I2 := 6
    static ELEMENT_TYPE_U2 := 7
    static ELEMENT_TYPE_I4 := 8
    static ELEMENT_TYPE_U4 := 9
    static ELEMENT_TYPE_I8 := 10
    static ELEMENT_TYPE_U8 := 11
    static ELEMENT_TYPE_R4 := 12
    static ELEMENT_TYPE_R8 := 13
    static ELEMENT_TYPE_STRING := 14
    static ELEMENT_TYPE_PTR := 15
    static ELEMENT_TYPE_BYREF := 16
    static ELEMENT_TYPE_VALUETYPE := 17
    static ELEMENT_TYPE_CLASS := 18
    static ELEMENT_TYPE_VAR := 19
    static ELEMENT_TYPE_ARRAY := 20
    static ELEMENT_TYPE_GENERICINST := 21
    static ELEMENT_TYPE_TYPEDBYREF := 22
    static ELEMENT_TYPE_I := 24
    static ELEMENT_TYPE_U := 25
    static ELEMENT_TYPE_FNPTR := 27
    static ELEMENT_TYPE_OBJECT := 28
    static ELEMENT_TYPE_SZARRAY := 29
    static ELEMENT_TYPE_MVAR := 30
    static ELEMENT_TYPE_CMOD_REQD := 31
    static ELEMENT_TYPE_CMOD_OPT := 32
    static ELEMENT_TYPE_INTERNAL := 33
    static ELEMENT_TYPE_MAX := 34
    static ELEMENT_TYPE_MODIFIER := 64
    static ELEMENT_TYPE_SENTINEL := 65
    static ELEMENT_TYPE_PINNED := 69
}
struct CorSerializationType extends Int32 {
    static SERIALIZATION_TYPE_UNDEFINED := 0
    static SERIALIZATION_TYPE_BOOLEAN := 2
    static SERIALIZATION_TYPE_CHAR := 3
    static SERIALIZATION_TYPE_I1 := 4
    static SERIALIZATION_TYPE_U1 := 5
    static SERIALIZATION_TYPE_I2 := 6
    static SERIALIZATION_TYPE_U2 := 7
    static SERIALIZATION_TYPE_I4 := 8
    static SERIALIZATION_TYPE_U4 := 9
    static SERIALIZATION_TYPE_I8 := 10
    static SERIALIZATION_TYPE_U8 := 11
    static SERIALIZATION_TYPE_R4 := 12
    static SERIALIZATION_TYPE_R8 := 13
    static SERIALIZATION_TYPE_STRING := 14
    static SERIALIZATION_TYPE_SZARRAY := 29
    static SERIALIZATION_TYPE_TYPE := 80
    static SERIALIZATION_TYPE_TAGGED_OBJECT := 81
    static SERIALIZATION_TYPE_FIELD := 83
    static SERIALIZATION_TYPE_PROPERTY := 84
    static SERIALIZATION_TYPE_ENUM := 85
}
struct CorCallingConvention extends Int32 {
    static IMAGE_CEE_CS_CALLCONV_DEFAULT := 0
    static IMAGE_CEE_CS_CALLCONV_VARARG := 5
    static IMAGE_CEE_CS_CALLCONV_FIELD := 6
    static IMAGE_CEE_CS_CALLCONV_LOCAL_SIG := 7
    static IMAGE_CEE_CS_CALLCONV_PROPERTY := 8
    static IMAGE_CEE_CS_CALLCONV_UNMGD := 9
    static IMAGE_CEE_CS_CALLCONV_GENERICINST := 10
    static IMAGE_CEE_CS_CALLCONV_NATIVEVARARG := 11
    static IMAGE_CEE_CS_CALLCONV_MAX := 12
    static IMAGE_CEE_CS_CALLCONV_MASK := 15
    static IMAGE_CEE_CS_CALLCONV_HASTHIS := 32
    static IMAGE_CEE_CS_CALLCONV_EXPLICITTHIS := 64
    static IMAGE_CEE_CS_CALLCONV_GENERIC := 16
}
struct CorUnmanagedCallingConvention extends Int32 {
    static IMAGE_CEE_UNMANAGED_CALLCONV_C := 1
    static IMAGE_CEE_UNMANAGED_CALLCONV_STDCALL := 2
    static IMAGE_CEE_UNMANAGED_CALLCONV_THISCALL := 3
    static IMAGE_CEE_UNMANAGED_CALLCONV_FASTCALL := 4
    static IMAGE_CEE_CS_CALLCONV_C := 1
    static IMAGE_CEE_CS_CALLCONV_STDCALL := 2
    static IMAGE_CEE_CS_CALLCONV_THISCALL := 3
    static IMAGE_CEE_CS_CALLCONV_FASTCALL := 4
}
struct CorArgType extends Int32 {
    static IMAGE_CEE_CS_END := 0
    static IMAGE_CEE_CS_VOID := 1
    static IMAGE_CEE_CS_I4 := 2
    static IMAGE_CEE_CS_I8 := 3
    static IMAGE_CEE_CS_R4 := 4
    static IMAGE_CEE_CS_R8 := 5
    static IMAGE_CEE_CS_PTR := 6
    static IMAGE_CEE_CS_OBJECT := 7
    static IMAGE_CEE_CS_STRUCT4 := 8
    static IMAGE_CEE_CS_STRUCT32 := 9
    static IMAGE_CEE_CS_BYVALUE := 10
}
struct CorNativeType extends Int32 {
    static NATIVE_TYPE_END := 0
    static NATIVE_TYPE_VOID := 1
    static NATIVE_TYPE_BOOLEAN := 2
    static NATIVE_TYPE_I1 := 3
    static NATIVE_TYPE_U1 := 4
    static NATIVE_TYPE_I2 := 5
    static NATIVE_TYPE_U2 := 6
    static NATIVE_TYPE_I4 := 7
    static NATIVE_TYPE_U4 := 8
    static NATIVE_TYPE_I8 := 9
    static NATIVE_TYPE_U8 := 10
    static NATIVE_TYPE_R4 := 11
    static NATIVE_TYPE_R8 := 12
    static NATIVE_TYPE_SYSCHAR := 13
    static NATIVE_TYPE_VARIANT := 14
    static NATIVE_TYPE_CURRENCY := 15
    static NATIVE_TYPE_PTR := 16
    static NATIVE_TYPE_DECIMAL := 17
    static NATIVE_TYPE_DATE := 18
    static NATIVE_TYPE_BSTR := 19
    static NATIVE_TYPE_LPSTR := 20
    static NATIVE_TYPE_LPWSTR := 21
    static NATIVE_TYPE_LPTSTR := 22
    static NATIVE_TYPE_FIXEDSYSSTRING := 23
    static NATIVE_TYPE_OBJECTREF := 24
    static NATIVE_TYPE_IUNKNOWN := 25
    static NATIVE_TYPE_IDISPATCH := 26
    static NATIVE_TYPE_STRUCT := 27
    static NATIVE_TYPE_INTF := 28
    static NATIVE_TYPE_SAFEARRAY := 29
    static NATIVE_TYPE_FIXEDARRAY := 30
    static NATIVE_TYPE_INT := 31
    static NATIVE_TYPE_UINT := 32
    static NATIVE_TYPE_NESTEDSTRUCT := 33
    static NATIVE_TYPE_BYVALSTR := 34
    static NATIVE_TYPE_ANSIBSTR := 35
    static NATIVE_TYPE_TBSTR := 36
    static NATIVE_TYPE_VARIANTBOOL := 37
    static NATIVE_TYPE_FUNC := 38
    static NATIVE_TYPE_ASANY := 40
    static NATIVE_TYPE_ARRAY := 42
    static NATIVE_TYPE_LPSTRUCT := 43
    static NATIVE_TYPE_CUSTOMMARSHALER := 44
    static NATIVE_TYPE_ERROR := 45
    static NATIVE_TYPE_IINSPECTABLE := 46
    static NATIVE_TYPE_HSTRING := 47
    static NATIVE_TYPE_LPUTF8STR := 48
    static NATIVE_TYPE_MAX := 80
}
struct CorILMethodSect extends Int32 {
    static CorILMethod_Sect_Reserved := 0
    static CorILMethod_Sect_EHTable := 1
    static CorILMethod_Sect_OptILTable := 2
    static CorILMethod_Sect_KindMask := 63
    static CorILMethod_Sect_FatFormat := 64
    static CorILMethod_Sect_MoreSects := 128
}
struct IMAGE_COR_ILMETHOD_SECT_SMALL {
    Kind : UInt8
    DataSize : UInt8
}
struct IMAGE_COR_ILMETHOD_SECT_FAT {
    _bitfield : UInt32
}
struct CorExceptionFlag extends Int32 {
    static COR_ILEXCEPTION_CLAUSE_NONE := 0
    static COR_ILEXCEPTION_CLAUSE_OFFSETLEN := 0
    static COR_ILEXCEPTION_CLAUSE_DEPRECATED := 0
    static COR_ILEXCEPTION_CLAUSE_FILTER := 1
    static COR_ILEXCEPTION_CLAUSE_FINALLY := 2
    static COR_ILEXCEPTION_CLAUSE_FAULT := 4
    static COR_ILEXCEPTION_CLAUSE_DUPLICATED := 8
}
struct IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT {
    Flags : CorExceptionFlag
    TryOffset : UInt32
    TryLength : UInt32
    HandlerOffset : UInt32
    HandlerLength : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ClassToken : UInt32
            FilterOffset : UInt32
        }
    }
}
struct IMAGE_COR_ILMETHOD_SECT_EH_FAT {
    SectFat : IMAGE_COR_ILMETHOD_SECT_FAT
    Clauses : IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_FAT[1]
}
struct IMAGE_COR_ILMETHOD_SECT_EH_SMALL {
    SectSmall : IMAGE_COR_ILMETHOD_SECT_SMALL
    Reserved : UInt16
    Clauses : IMAGE_COR_ILMETHOD_SECT_EH_CLAUSE_SMALL[1]
}
struct IMAGE_COR_ILMETHOD_SECT_EH {
    union {
        Small : IMAGE_COR_ILMETHOD_SECT_EH_SMALL
        Fat : IMAGE_COR_ILMETHOD_SECT_EH_FAT
    }
}
struct CorILMethodFlags extends Int32 {
    static CorILMethod_InitLocals := 16
    static CorILMethod_MoreSects := 8
    static CorILMethod_CompressedIL := 64
    static CorILMethod_FormatShift := 3
    static CorILMethod_FormatMask := 7
    static CorILMethod_TinyFormat := 2
    static CorILMethod_SmallFormat := 0
    static CorILMethod_FatFormat := 3
    static CorILMethod_TinyFormat1 := 6
}
struct IMAGE_COR_ILMETHOD_TINY {
    Flags_CodeSize : UInt8
}
struct IMAGE_COR_ILMETHOD_FAT {
    _bitfield : UInt32
    CodeSize : UInt32
    LocalVarSigTok : UInt32
}
struct IMAGE_COR_ILMETHOD {
    union {
        Tiny : IMAGE_COR_ILMETHOD_TINY
        Fat : IMAGE_COR_ILMETHOD_FAT
    }
}
struct IMAGE_COR_VTABLEFIXUP {
    RVA : UInt32
    Count : UInt16
    Type : UInt16
}
struct CorCheckDuplicatesFor extends Int32 {
    static MDDupAll := -1
    static MDDupENC := -1
    static MDNoDupChecks := 0
    static MDDupTypeDef := 1
    static MDDupInterfaceImpl := 2
    static MDDupMethodDef := 4
    static MDDupTypeRef := 8
    static MDDupMemberRef := 16
    static MDDupCustomAttribute := 32
    static MDDupParamDef := 64
    static MDDupPermission := 128
    static MDDupProperty := 256
    static MDDupEvent := 512
    static MDDupFieldDef := 1024
    static MDDupSignature := 2048
    static MDDupModuleRef := 4096
    static MDDupTypeSpec := 8192
    static MDDupImplMap := 16384
    static MDDupAssemblyRef := 32768
    static MDDupFile := 65536
    static MDDupExportedType := 131072
    static MDDupManifestResource := 262144
    static MDDupGenericParam := 524288
    static MDDupMethodSpec := 1048576
    static MDDupGenericParamConstraint := 2097152
    static MDDupAssembly := 268435456
    static MDDupDefault := 1058840
}
struct CorRefToDefCheck extends Int32 {
    static MDRefToDefDefault := 3
    static MDRefToDefAll := -1
    static MDRefToDefNone := 0
    static MDTypeRefToDef := 1
    static MDMemberRefToDef := 2
}
struct CorNotificationForTokenMovement extends Int32 {
    static MDNotifyDefault := 15
    static MDNotifyAll := -1
    static MDNotifyNone := 0
    static MDNotifyMethodDef := 1
    static MDNotifyMemberRef := 2
    static MDNotifyFieldDef := 4
    static MDNotifyTypeRef := 8
    static MDNotifyTypeDef := 16
    static MDNotifyParamDef := 32
    static MDNotifyInterfaceImpl := 64
    static MDNotifyProperty := 128
    static MDNotifyEvent := 256
    static MDNotifySignature := 512
    static MDNotifyTypeSpec := 1024
    static MDNotifyCustomAttribute := 2048
    static MDNotifySecurityValue := 4096
    static MDNotifyPermission := 8192
    static MDNotifyModuleRef := 16384
    static MDNotifyNameSpace := 32768
    static MDNotifyAssemblyRef := 16777216
    static MDNotifyFile := 33554432
    static MDNotifyExportedType := 67108864
    static MDNotifyResource := 134217728
}
struct CorSetENC extends Int32 {
    static MDSetENCOn := 1
    static MDSetENCOff := 2
    static MDUpdateENC := 1
    static MDUpdateFull := 2
    static MDUpdateExtension := 3
    static MDUpdateIncremental := 4
    static MDUpdateDelta := 5
    static MDUpdateMask := 7
}
struct CorErrorIfEmitOutOfOrder extends Int32 {
    static MDErrorOutOfOrderDefault := 0
    static MDErrorOutOfOrderNone := 0
    static MDErrorOutOfOrderAll := -1
    static MDMethodOutOfOrder := 1
    static MDFieldOutOfOrder := 2
    static MDParamOutOfOrder := 4
    static MDPropertyOutOfOrder := 8
    static MDEventOutOfOrder := 16
}
struct CorImportOptions extends Int32 {
    static MDImportOptionDefault := 0
    static MDImportOptionAll := -1
    static MDImportOptionAllTypeDefs := 1
    static MDImportOptionAllMethodDefs := 2
    static MDImportOptionAllFieldDefs := 4
    static MDImportOptionAllProperties := 8
    static MDImportOptionAllEvents := 16
    static MDImportOptionAllCustomAttributes := 32
    static MDImportOptionAllExportedTypes := 64
}
struct CorThreadSafetyOptions extends Int32 {
    static MDThreadSafetyDefault := 0
    static MDThreadSafetyOff := 0
    static MDThreadSafetyOn := 1
}
struct CorLinkerOptions extends Int32 {
    static MDAssembly := 0
    static MDNetModule := 1
}
struct MergeFlags extends Int32 {
    static MergeFlagsNone := 0
    static MergeManifest := 1
    static DropMemberRefCAs := 2
    static NoDupCheck := 4
    static MergeExportedTypes := 8
}
struct CorLocalRefPreservation extends Int32 {
    static MDPreserveLocalRefsNone := 0
    static MDPreserveLocalTypeRef := 1
    static MDPreserveLocalMemberRef := 2
}
struct COR_FIELD_OFFSET {
    ridOfField : UInt32
    ulOffset : UInt32
}
struct CorTokenType extends Int32 {
    static mdtModule := 0
    static mdtTypeRef := 16777216
    static mdtTypeDef := 33554432
    static mdtFieldDef := 67108864
    static mdtMethodDef := 100663296
    static mdtParamDef := 134217728
    static mdtInterfaceImpl := 150994944
    static mdtMemberRef := 167772160
    static mdtCustomAttribute := 201326592
    static mdtPermission := 234881024
    static mdtSignature := 285212672
    static mdtEvent := 335544320
    static mdtProperty := 385875968
    static mdtMethodImpl := 419430400
    static mdtModuleRef := 436207616
    static mdtTypeSpec := 452984832
    static mdtAssembly := 536870912
    static mdtAssemblyRef := 587202560
    static mdtFile := 637534208
    static mdtExportedType := 654311424
    static mdtManifestResource := 671088640
    static mdtGenericParam := 704643072
    static mdtMethodSpec := 721420288
    static mdtGenericParamConstraint := 738197504
    static mdtString := 1879048192
    static mdtName := 1895825408
    static mdtBaseType := 1912602624
}
struct CorOpenFlags extends Int32 {
    static ofRead := 0
    static ofWrite := 1
    static ofReadWriteMask := 1
    static ofCopyMemory := 2
    static ofReadOnly := 16
    static ofTakeOwnership := 32
    static ofNoTypeLib := 128
    static ofNoTransform := 4096
    static ofCheckIntegrity := 2048
    static ofReserved1 := 256
    static ofReserved2 := 512
    static ofReserved3 := 1024
    static ofReserved := -6336
}
struct CorFileMapping extends Int32 {
    static fmFlat := 0
    static fmExecutableImage := 1
}
struct CorAttributeTargets extends Int32 {
    static catAssembly := 1
    static catModule := 2
    static catClass := 4
    static catStruct := 8
    static catEnum := 16
    static catConstructor := 32
    static catMethod := 64
    static catProperty := 128
    static catField := 256
    static catEvent := 512
    static catInterface := 1024
    static catParameter := 2048
    static catDelegate := 4096
    static catGenericParameter := 16384
    static catAll := 24575
    static catClassMembers := 6140
}
struct CompilationRelaxationsEnum extends Int32 {
    static CompilationRelaxations_NoStringInterning := 8
}
struct NGenHintEnum extends Int32 {
    static NGenDefault := 0
    static NGenEager := 1
    static NGenLazy := 2
    static NGenNever := 3
}
struct LoadHintEnum extends Int32 {
    static LoadDefault := 0
    static LoadAlways := 1
    static LoadSometimes := 2
    static LoadNever := 3
}
struct CorSaveSize extends Int32 {
    static cssAccurate := 0
    static cssQuick := 1
    static cssDiscardTransientCAs := 2
}
struct NativeTypeArrayFlags extends Int32 {
    static ntaSizeParamIndexSpecified := 1
    static ntaReserved := 65534
}
struct COR_SECATTR {
    tkCtor : UInt32
    pCustomAttribute : Struct.Ptr
    cbCustomAttribute : UInt32
}
struct IMetaDataError extends IUnknown {
    static IID := "{B81FF171-20F3-11D2-8DCC-00A0C9B09C19}"
    OnError(hrError, token)
      => ComCall(3, this.p, HRESULT, hrError, UInt32, token)
}
struct IMapToken extends IUnknown {
    static IID := "{06A3EA8B-0225-11D1-BF72-00C04FC31E12}"
    Map(tkImp, tkEmit)
      => ComCall(3, this.p, UInt32, tkImp, UInt32, tkEmit)
}
struct IMetaDataDispenser extends IUnknown {
    static IID := "{809C652E-7396-11D2-9771-00A0C9B4D50C}"
    DefineScope(rclsid, dwCreateFlags, riid, ppIUnk)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt32, dwCreateFlags, GUID.Ptr, riid, IUnknown.Ptr, ppIUnk)
    OpenScope(szScope, dwOpenFlags, riid, ppIUnk)
      => ComCall(4, this.p, "Str", szScope, UInt32, dwOpenFlags, GUID.Ptr, riid, IUnknown.Ptr, ppIUnk)
    OpenScopeOnMemory(pData, cbData, dwOpenFlags, riid, ppIUnk)
      => ComCall(5, this.p, Struct.Ptr, pData, UInt32, cbData, UInt32, dwOpenFlags, GUID.Ptr, riid, IUnknown.Ptr, ppIUnk)
}
struct IMetaDataEmit extends IUnknown {
    static IID := "{BA3FEE4C-ECB9-4E41-83B7-183FA41CD859}"
    SetModuleProps(szName)
      => ComCall(3, this.p, "Str", szName)
    Save(szFile, dwSaveFlags)
      => ComCall(4, this.p, "Str", szFile, UInt32, dwSaveFlags)
    SaveToStream(pIStream, dwSaveFlags)
      => ComCall(5, this.p, IStream, pIStream, UInt32, dwSaveFlags)
    GetSaveSize(fSave, pdwSaveSize)
      => ComCall(6, this.p, CorSaveSize, fSave, UInt32.Ptr, pdwSaveSize)
    DefineTypeDef(szTypeDef, dwTypeDefFlags, tkExtends, rtkImplements, ptd)
      => ComCall(7, this.p, "Str", szTypeDef, UInt32, dwTypeDefFlags, UInt32, tkExtends, UInt32.Ptr, rtkImplements, UInt32.Ptr, ptd)
    DefineNestedType(szTypeDef, dwTypeDefFlags, tkExtends, rtkImplements, tdEncloser, ptd)
      => ComCall(8, this.p, "Str", szTypeDef, UInt32, dwTypeDefFlags, UInt32, tkExtends, UInt32.Ptr, rtkImplements, UInt32, tdEncloser, UInt32.Ptr, ptd)
    SetHandler(pUnk)
      => ComCall(9, this.p, IUnknown, pUnk)
    DefineMethod(td, szName, dwMethodFlags, pvSigBlob, cbSigBlob, ulCodeRVA, dwImplFlags, pmd)
      => ComCall(10, this.p, UInt32, td, "Str", szName, UInt32, dwMethodFlags, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32, ulCodeRVA, UInt32, dwImplFlags, UInt32.Ptr, pmd)
    DefineMethodImpl(td, tkBody, tkDecl)
      => ComCall(11, this.p, UInt32, td, UInt32, tkBody, UInt32, tkDecl)
    DefineTypeRefByName(tkResolutionScope, szName, ptr)
      => ComCall(12, this.p, UInt32, tkResolutionScope, "Str", szName, UInt32.Ptr, ptr)
    DefineImportType(pAssemImport, pbHashValue, cbHashValue, pImport, tdImport, pAssemEmit, ptr)
      => ComCall(13, this.p, IMetaDataAssemblyImport, pAssemImport, Struct.Ptr, pbHashValue, UInt32, cbHashValue, IMetaDataImport, pImport, UInt32, tdImport, IMetaDataAssemblyEmit, pAssemEmit, UInt32.Ptr, ptr)
    DefineMemberRef(tkImport, szName, pvSigBlob, cbSigBlob, pmr)
      => ComCall(14, this.p, UInt32, tkImport, "Str", szName, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmr)
    DefineImportMember(pAssemImport, pbHashValue, cbHashValue, pImport, mbMember, pAssemEmit, tkParent, pmr)
      => ComCall(15, this.p, IMetaDataAssemblyImport, pAssemImport, Struct.Ptr, pbHashValue, UInt32, cbHashValue, IMetaDataImport, pImport, UInt32, mbMember, IMetaDataAssemblyEmit, pAssemEmit, UInt32, tkParent, UInt32.Ptr, pmr)
    DefineEvent(td, szEvent, dwEventFlags, tkEventType, mdAddOn, mdRemoveOn, mdFire, rmdOtherMethods, pmdEvent)
      => ComCall(16, this.p, UInt32, td, "Str", szEvent, UInt32, dwEventFlags, UInt32, tkEventType, UInt32, mdAddOn, UInt32, mdRemoveOn, UInt32, mdFire, UInt32.Ptr, rmdOtherMethods, UInt32.Ptr, pmdEvent)
    SetClassLayout(td, dwPackSize, rFieldOffsets, ulClassSize)
      => ComCall(17, this.p, UInt32, td, UInt32, dwPackSize, COR_FIELD_OFFSET.Ptr, rFieldOffsets, UInt32, ulClassSize)
    DeleteClassLayout(td)
      => ComCall(18, this.p, UInt32, td)
    SetFieldMarshal(tk, pvNativeType, cbNativeType)
      => ComCall(19, this.p, UInt32, tk, UInt8.Ptr, pvNativeType, UInt32, cbNativeType)
    DeleteFieldMarshal(tk)
      => ComCall(20, this.p, UInt32, tk)
    DefinePermissionSet(tk, dwAction, pvPermission, cbPermission, ppm)
      => ComCall(21, this.p, UInt32, tk, UInt32, dwAction, Struct.Ptr, pvPermission, UInt32, cbPermission, UInt32.Ptr, ppm)
    SetRVA(md, ulRVA)
      => ComCall(22, this.p, UInt32, md, UInt32, ulRVA)
    GetTokenFromSig(pvSig, cbSig, pmsig)
      => ComCall(23, this.p, UInt8.Ptr, pvSig, UInt32, cbSig, UInt32.Ptr, pmsig)
    DefineModuleRef(szName, pmur)
      => ComCall(24, this.p, "Str", szName, UInt32.Ptr, pmur)
    SetParent(mr, tk)
      => ComCall(25, this.p, UInt32, mr, UInt32, tk)
    GetTokenFromTypeSpec(pvSig, cbSig, ptypespec)
      => ComCall(26, this.p, UInt8.Ptr, pvSig, UInt32, cbSig, UInt32.Ptr, ptypespec)
    SaveToMemory(pbData, cbData)
      => ComCall(27, this.p, Struct.Ptr, pbData, UInt32, cbData)
    DefineUserString(szString, cchString, pstk)
      => ComCall(28, this.p, "Str", szString, UInt32, cchString, UInt32.Ptr, pstk)
    DeleteToken(tkObj)
      => ComCall(29, this.p, UInt32, tkObj)
    SetMethodProps(md, dwMethodFlags, ulCodeRVA, dwImplFlags)
      => ComCall(30, this.p, UInt32, md, UInt32, dwMethodFlags, UInt32, ulCodeRVA, UInt32, dwImplFlags)
    SetTypeDefProps(td, dwTypeDefFlags, tkExtends, rtkImplements)
      => ComCall(31, this.p, UInt32, td, UInt32, dwTypeDefFlags, UInt32, tkExtends, UInt32.Ptr, rtkImplements)
    SetEventProps(ev, dwEventFlags, tkEventType, mdAddOn, mdRemoveOn, mdFire, rmdOtherMethods)
      => ComCall(32, this.p, UInt32, ev, UInt32, dwEventFlags, UInt32, tkEventType, UInt32, mdAddOn, UInt32, mdRemoveOn, UInt32, mdFire, UInt32.Ptr, rmdOtherMethods)
    SetPermissionSetProps(tk, dwAction, pvPermission, cbPermission, ppm)
      => ComCall(33, this.p, UInt32, tk, UInt32, dwAction, Struct.Ptr, pvPermission, UInt32, cbPermission, UInt32.Ptr, ppm)
    DefinePinvokeMap(tk, dwMappingFlags, szImportName, mrImportDLL)
      => ComCall(34, this.p, UInt32, tk, UInt32, dwMappingFlags, "Str", szImportName, UInt32, mrImportDLL)
    SetPinvokeMap(tk, dwMappingFlags, szImportName, mrImportDLL)
      => ComCall(35, this.p, UInt32, tk, UInt32, dwMappingFlags, "Str", szImportName, UInt32, mrImportDLL)
    DeletePinvokeMap(tk)
      => ComCall(36, this.p, UInt32, tk)
    DefineCustomAttribute(tkOwner, tkCtor, pCustomAttribute, cbCustomAttribute, pcv)
      => ComCall(37, this.p, UInt32, tkOwner, UInt32, tkCtor, Struct.Ptr, pCustomAttribute, UInt32, cbCustomAttribute, UInt32.Ptr, pcv)
    SetCustomAttributeValue(pcv, pCustomAttribute, cbCustomAttribute)
      => ComCall(38, this.p, UInt32, pcv, Struct.Ptr, pCustomAttribute, UInt32, cbCustomAttribute)
    DefineField(td, szName, dwFieldFlags, pvSigBlob, cbSigBlob, dwCPlusTypeFlag, pValue, cchValue, pmd)
      => ComCall(39, this.p, UInt32, td, "Str", szName, UInt32, dwFieldFlags, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue, UInt32.Ptr, pmd)
    DefineProperty(td, szProperty, dwPropFlags, pvSig, cbSig, dwCPlusTypeFlag, pValue, cchValue, mdSetter, mdGetter, rmdOtherMethods, pmdProp)
      => ComCall(40, this.p, UInt32, td, "Str", szProperty, UInt32, dwPropFlags, UInt8.Ptr, pvSig, UInt32, cbSig, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue, UInt32, mdSetter, UInt32, mdGetter, UInt32.Ptr, rmdOtherMethods, UInt32.Ptr, pmdProp)
    DefineParam(md, ulParamSeq, szName, dwParamFlags, dwCPlusTypeFlag, pValue, cchValue, ppd)
      => ComCall(41, this.p, UInt32, md, UInt32, ulParamSeq, "Str", szName, UInt32, dwParamFlags, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue, UInt32.Ptr, ppd)
    SetFieldProps(fd, dwFieldFlags, dwCPlusTypeFlag, pValue, cchValue)
      => ComCall(42, this.p, UInt32, fd, UInt32, dwFieldFlags, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue)
    SetPropertyProps(pr, dwPropFlags, dwCPlusTypeFlag, pValue, cchValue, mdSetter, mdGetter, rmdOtherMethods)
      => ComCall(43, this.p, UInt32, pr, UInt32, dwPropFlags, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue, UInt32, mdSetter, UInt32, mdGetter, UInt32.Ptr, rmdOtherMethods)
    SetParamProps(pd, szName, dwParamFlags, dwCPlusTypeFlag, pValue, cchValue)
      => ComCall(44, this.p, UInt32, pd, "Str", szName, UInt32, dwParamFlags, UInt32, dwCPlusTypeFlag, Struct.Ptr, pValue, UInt32, cchValue)
    DefineSecurityAttributeSet(tkObj, rSecAttrs, cSecAttrs, pulErrorAttr)
      => ComCall(45, this.p, UInt32, tkObj, COR_SECATTR.Ptr, rSecAttrs, UInt32, cSecAttrs, UInt32.Ptr, pulErrorAttr)
    ApplyEditAndContinue(pImport)
      => ComCall(46, this.p, IUnknown, pImport)
    TranslateSigWithScope(pAssemImport, pbHashValue, cbHashValue, import, pbSigBlob, cbSigBlob, pAssemEmit, emit, pvTranslatedSig, cbTranslatedSigMax, pcbTranslatedSig)
      => ComCall(47, this.p, IMetaDataAssemblyImport, pAssemImport, Struct.Ptr, pbHashValue, UInt32, cbHashValue, IMetaDataImport, import, UInt8.Ptr, pbSigBlob, UInt32, cbSigBlob, IMetaDataAssemblyEmit, pAssemEmit, IMetaDataEmit, emit, UInt8.Ptr, pvTranslatedSig, UInt32, cbTranslatedSigMax, UInt32.Ptr, pcbTranslatedSig)
    SetMethodImplFlags(md, dwImplFlags)
      => ComCall(48, this.p, UInt32, md, UInt32, dwImplFlags)
    SetFieldRVA(fd, ulRVA)
      => ComCall(49, this.p, UInt32, fd, UInt32, ulRVA)
    Merge(pImport, pHostMapToken, pHandler)
      => ComCall(50, this.p, IMetaDataImport, pImport, IMapToken, pHostMapToken, IUnknown, pHandler)
    MergeEnd()
      => ComCall(51, this.p)
}
struct IMetaDataEmit2 extends IMetaDataEmit {
    static IID := "{F5DD9950-F693-42E6-830E-7B833E8146A9}"
    DefineMethodSpec(tkParent, pvSigBlob, cbSigBlob, pmi)
      => ComCall(52, this.p, UInt32, tkParent, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmi)
    GetDeltaSaveSize(fSave, pdwSaveSize)
      => ComCall(53, this.p, CorSaveSize, fSave, UInt32.Ptr, pdwSaveSize)
    SaveDelta(szFile, dwSaveFlags)
      => ComCall(54, this.p, "Str", szFile, UInt32, dwSaveFlags)
    SaveDeltaToStream(pIStream, dwSaveFlags)
      => ComCall(55, this.p, IStream, pIStream, UInt32, dwSaveFlags)
    SaveDeltaToMemory(pbData, cbData)
      => ComCall(56, this.p, Struct.Ptr, pbData, UInt32, cbData)
    DefineGenericParam(tk, ulParamSeq, dwParamFlags, szname, reserved, rtkConstraints, pgp)
      => ComCall(57, this.p, UInt32, tk, UInt32, ulParamSeq, UInt32, dwParamFlags, "Str", szname, UInt32, reserved, UInt32.Ptr, rtkConstraints, UInt32.Ptr, pgp)
    SetGenericParamProps(gp, dwParamFlags, szName, reserved, rtkConstraints)
      => ComCall(58, this.p, UInt32, gp, UInt32, dwParamFlags, "Str", szName, UInt32, reserved, UInt32.Ptr, rtkConstraints)
    ResetENCLog()
      => ComCall(59, this.p)
}
struct IMetaDataImport extends IUnknown {
    static IID := "{7DAC8207-D3AE-4C75-9B67-92801A497D44}"
    CloseEnum(hEnum)
      => ComCall(3, this.p, Struct.Ptr, hEnum, "void")
    CountEnum(hEnum, pulCount)
      => ComCall(4, this.p, Struct.Ptr, hEnum, UInt32.Ptr, pulCount)
    ResetEnum(hEnum, ulPos)
      => ComCall(5, this.p, Struct.Ptr, hEnum, UInt32, ulPos)
    EnumTypeDefs(phEnum, rTypeDefs, cMax, pcTypeDefs)
      => ComCall(6, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rTypeDefs, UInt32, cMax, UInt32.Ptr, pcTypeDefs)
    EnumInterfaceImpls(phEnum, td, rImpls, cMax, pcImpls)
      => ComCall(7, this.p, Struct.Ptr.Ptr, phEnum, UInt32, td, UInt32.Ptr, rImpls, UInt32, cMax, UInt32.Ptr, pcImpls)
    EnumTypeRefs(phEnum, rTypeRefs, cMax, pcTypeRefs)
      => ComCall(8, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rTypeRefs, UInt32, cMax, UInt32.Ptr, pcTypeRefs)
    FindTypeDefByName(szTypeDef, tkEnclosingClass, ptd)
      => ComCall(9, this.p, "Str", szTypeDef, UInt32, tkEnclosingClass, UInt32.Ptr, ptd)
    GetScopeProps(szName?, pchName, pmvid)
      => ComCall(10, this.p, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, GUID.Ptr, pmvid)
    GetModuleFromScope(pmd)
      => ComCall(11, this.p, UInt32.Ptr, pmd)
    GetTypeDefProps(td, szTypeDef?, pchTypeDef, pdwTypeDefFlags, ptkExtends)
      => ComCall(12, this.p, UInt32, td, PWSTR, szTypeDef?, UInt32, szTypeDef?.Length ?? 0, UInt32.Ptr, pchTypeDef, UInt32.Ptr, pdwTypeDefFlags, UInt32.Ptr, ptkExtends)
    GetInterfaceImplProps(iiImpl, pClass, ptkIface)
      => ComCall(13, this.p, UInt32, iiImpl, UInt32.Ptr, pClass, UInt32.Ptr, ptkIface)
    GetTypeRefProps(tr, ptkResolutionScope, szName?, pchName)
      => ComCall(14, this.p, UInt32, tr, UInt32.Ptr, ptkResolutionScope, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName)
    ResolveTypeRef(tr, riid, ppIScope, ptd)
      => ComCall(15, this.p, UInt32, tr, GUID.Ptr, riid, IUnknown.Ptr, ppIScope, UInt32.Ptr, ptd)
    EnumMembers(phEnum, cl, rMembers, cMax, pcTokens)
      => ComCall(16, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, UInt32.Ptr, rMembers, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumMembersWithName(phEnum, cl, szName, rMembers, cMax, pcTokens)
      => ComCall(17, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, "Str", szName, UInt32.Ptr, rMembers, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumMethods(phEnum, cl, rMethods, cMax, pcTokens)
      => ComCall(18, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, UInt32.Ptr, rMethods, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumMethodsWithName(phEnum, cl, szName, rMethods, cMax, pcTokens)
      => ComCall(19, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, "Str", szName, UInt32.Ptr, rMethods, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumFields(phEnum, cl, rFields, cMax, pcTokens)
      => ComCall(20, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, UInt32.Ptr, rFields, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumFieldsWithName(phEnum, cl, szName, rFields, cMax, pcTokens)
      => ComCall(21, this.p, Struct.Ptr.Ptr, phEnum, UInt32, cl, "Str", szName, UInt32.Ptr, rFields, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumParams(phEnum, mb, rParams, cMax, pcTokens)
      => ComCall(22, this.p, Struct.Ptr.Ptr, phEnum, UInt32, mb, UInt32.Ptr, rParams, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumMemberRefs(phEnum, tkParent, rMemberRefs, cMax, pcTokens)
      => ComCall(23, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tkParent, UInt32.Ptr, rMemberRefs, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumMethodImpls(phEnum, td, rMethodBody, rMethodDecl, cMax, pcTokens)
      => ComCall(24, this.p, Struct.Ptr.Ptr, phEnum, UInt32, td, UInt32.Ptr, rMethodBody, UInt32.Ptr, rMethodDecl, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumPermissionSets(phEnum, tk, dwActions, rPermission, cMax, pcTokens)
      => ComCall(25, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tk, UInt32, dwActions, UInt32.Ptr, rPermission, UInt32, cMax, UInt32.Ptr, pcTokens)
    FindMember(td, szName, pvSigBlob, cbSigBlob, pmb)
      => ComCall(26, this.p, UInt32, td, "Str", szName, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmb)
    FindMethod(td, szName, pvSigBlob, cbSigBlob, pmb)
      => ComCall(27, this.p, UInt32, td, "Str", szName, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmb)
    FindField(td, szName, pvSigBlob, cbSigBlob, pmb)
      => ComCall(28, this.p, UInt32, td, "Str", szName, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmb)
    FindMemberRef(td, szName, pvSigBlob, cbSigBlob, pmr)
      => ComCall(29, this.p, UInt32, td, "Str", szName, UInt8.Ptr, pvSigBlob, UInt32, cbSigBlob, UInt32.Ptr, pmr)
    GetMethodProps(mb, pClass, szMethod?, pchMethod, pdwAttr, ppvSigBlob, pcbSigBlob, pulCodeRVA, pdwImplFlags)
      => ComCall(30, this.p, UInt32, mb, UInt32.Ptr, pClass, PWSTR, szMethod?, UInt32, szMethod?.Length ?? 0, UInt32.Ptr, pchMethod, UInt32.Ptr, pdwAttr, UInt8.Ptr.Ptr, ppvSigBlob, UInt32.Ptr, pcbSigBlob, UInt32.Ptr, pulCodeRVA, UInt32.Ptr, pdwImplFlags)
    GetMemberRefProps(mr, ptk, szMember?, pchMember, ppvSigBlob, pbSig)
      => ComCall(31, this.p, UInt32, mr, UInt32.Ptr, ptk, PWSTR, szMember?, UInt32, szMember?.Length ?? 0, UInt32.Ptr, pchMember, UInt8.Ptr.Ptr, ppvSigBlob, UInt32.Ptr, pbSig)
    EnumProperties(phEnum, td, rProperties, cMax, pcProperties)
      => ComCall(32, this.p, Struct.Ptr.Ptr, phEnum, UInt32, td, UInt32.Ptr, rProperties, UInt32, cMax, UInt32.Ptr, pcProperties)
    EnumEvents(phEnum, td, rEvents, cMax, pcEvents)
      => ComCall(33, this.p, Struct.Ptr.Ptr, phEnum, UInt32, td, UInt32.Ptr, rEvents, UInt32, cMax, UInt32.Ptr, pcEvents)
    GetEventProps(ev, pClass, szEvent, cchEvent, pchEvent, pdwEventFlags, ptkEventType, pmdAddOn, pmdRemoveOn, pmdFire, rmdOtherMethod, cMax, pcOtherMethod)
      => ComCall(34, this.p, UInt32, ev, UInt32.Ptr, pClass, "Str", szEvent, UInt32, cchEvent, UInt32.Ptr, pchEvent, UInt32.Ptr, pdwEventFlags, UInt32.Ptr, ptkEventType, UInt32.Ptr, pmdAddOn, UInt32.Ptr, pmdRemoveOn, UInt32.Ptr, pmdFire, UInt32.Ptr, rmdOtherMethod, UInt32, cMax, UInt32.Ptr, pcOtherMethod)
    EnumMethodSemantics(phEnum, mb, rEventProp, cMax, pcEventProp)
      => ComCall(35, this.p, Struct.Ptr.Ptr, phEnum, UInt32, mb, UInt32.Ptr, rEventProp, UInt32, cMax, UInt32.Ptr, pcEventProp)
    GetMethodSemantics(mb, tkEventProp, pdwSemanticsFlags)
      => ComCall(36, this.p, UInt32, mb, UInt32, tkEventProp, UInt32.Ptr, pdwSemanticsFlags)
    GetClassLayout(td, pdwPackSize, rFieldOffset, cMax, pcFieldOffset, pulClassSize)
      => ComCall(37, this.p, UInt32, td, UInt32.Ptr, pdwPackSize, COR_FIELD_OFFSET.Ptr, rFieldOffset, UInt32, cMax, UInt32.Ptr, pcFieldOffset, UInt32.Ptr, pulClassSize)
    GetFieldMarshal(tk, ppvNativeType, pcbNativeType)
      => ComCall(38, this.p, UInt32, tk, UInt8.Ptr.Ptr, ppvNativeType, UInt32.Ptr, pcbNativeType)
    GetRVA(tk, pulCodeRVA, pdwImplFlags)
      => ComCall(39, this.p, UInt32, tk, UInt32.Ptr, pulCodeRVA, UInt32.Ptr, pdwImplFlags)
    GetPermissionSetProps(pm, pdwAction, ppvPermission, pcbPermission)
      => ComCall(40, this.p, UInt32, pm, UInt32.Ptr, pdwAction, Struct.Ptr.Ptr, ppvPermission, UInt32.Ptr, pcbPermission)
    GetSigFromToken(mdSig, ppvSig, pcbSig)
      => ComCall(41, this.p, UInt32, mdSig, UInt8.Ptr.Ptr, ppvSig, UInt32.Ptr, pcbSig)
    GetModuleRefProps(mur, szName?, pchName)
      => ComCall(42, this.p, UInt32, mur, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName)
    EnumModuleRefs(phEnum, rModuleRefs, cmax, pcModuleRefs)
      => ComCall(43, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rModuleRefs, UInt32, cmax, UInt32.Ptr, pcModuleRefs)
    GetTypeSpecFromToken(typespec, ppvSig, pcbSig)
      => ComCall(44, this.p, UInt32, typespec, UInt8.Ptr.Ptr, ppvSig, UInt32.Ptr, pcbSig)
    GetNameFromToken(tk, pszUtf8NamePtr)
      => ComCall(45, this.p, UInt32, tk, Int8.Ptr.Ptr, pszUtf8NamePtr)
    EnumUnresolvedMethods(phEnum, rMethods, cMax, pcTokens)
      => ComCall(46, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rMethods, UInt32, cMax, UInt32.Ptr, pcTokens)
    GetUserString(stk, szString?, pchString)
      => ComCall(47, this.p, UInt32, stk, PWSTR, szString?, UInt32, szString?.Length ?? 0, UInt32.Ptr, pchString)
    GetPinvokeMap(tk, pdwMappingFlags, szImportName?, pchImportName, pmrImportDLL)
      => ComCall(48, this.p, UInt32, tk, UInt32.Ptr, pdwMappingFlags, PWSTR, szImportName?, UInt32, szImportName?.Length ?? 0, UInt32.Ptr, pchImportName, UInt32.Ptr, pmrImportDLL)
    EnumSignatures(phEnum, rSignatures, cmax, pcSignatures)
      => ComCall(49, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rSignatures, UInt32, cmax, UInt32.Ptr, pcSignatures)
    EnumTypeSpecs(phEnum, rTypeSpecs, cmax, pcTypeSpecs)
      => ComCall(50, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rTypeSpecs, UInt32, cmax, UInt32.Ptr, pcTypeSpecs)
    EnumUserStrings(phEnum, rStrings, cmax, pcStrings)
      => ComCall(51, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rStrings, UInt32, cmax, UInt32.Ptr, pcStrings)
    GetParamForMethodIndex(md, ulParamSeq, ppd)
      => ComCall(52, this.p, UInt32, md, UInt32, ulParamSeq, UInt32.Ptr, ppd)
    EnumCustomAttributes(phEnum, tk, tkType, rCustomAttributes, cMax, pcCustomAttributes)
      => ComCall(53, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tk, UInt32, tkType, UInt32.Ptr, rCustomAttributes, UInt32, cMax, UInt32.Ptr, pcCustomAttributes)
    GetCustomAttributeProps(cv, ptkObj, ptkType, ppBlob, pcbSize)
      => ComCall(54, this.p, UInt32, cv, UInt32.Ptr, ptkObj, UInt32.Ptr, ptkType, Struct.Ptr.Ptr, ppBlob, UInt32.Ptr, pcbSize)
    FindTypeRef(tkResolutionScope, szName, ptr)
      => ComCall(55, this.p, UInt32, tkResolutionScope, "Str", szName, UInt32.Ptr, ptr)
    GetMemberProps(mb, pClass, szMember?, pchMember, pdwAttr, ppvSigBlob, pcbSigBlob, pulCodeRVA, pdwImplFlags, pdwCPlusTypeFlag, ppValue, pcchValue)
      => ComCall(56, this.p, UInt32, mb, UInt32.Ptr, pClass, PWSTR, szMember?, UInt32, szMember?.Length ?? 0, UInt32.Ptr, pchMember, UInt32.Ptr, pdwAttr, UInt8.Ptr.Ptr, ppvSigBlob, UInt32.Ptr, pcbSigBlob, UInt32.Ptr, pulCodeRVA, UInt32.Ptr, pdwImplFlags, UInt32.Ptr, pdwCPlusTypeFlag, Struct.Ptr.Ptr, ppValue, UInt32.Ptr, pcchValue)
    GetFieldProps(mb, pClass, szField?, pchField, pdwAttr, ppvSigBlob, pcbSigBlob, pdwCPlusTypeFlag, ppValue, pcchValue)
      => ComCall(57, this.p, UInt32, mb, UInt32.Ptr, pClass, PWSTR, szField?, UInt32, szField?.Length ?? 0, UInt32.Ptr, pchField, UInt32.Ptr, pdwAttr, UInt8.Ptr.Ptr, ppvSigBlob, UInt32.Ptr, pcbSigBlob, UInt32.Ptr, pdwCPlusTypeFlag, Struct.Ptr.Ptr, ppValue, UInt32.Ptr, pcchValue)
    GetPropertyProps(prop, pClass, szProperty, cchProperty, pchProperty, pdwPropFlags, ppvSig, pbSig, pdwCPlusTypeFlag, ppDefaultValue, pcchDefaultValue, pmdSetter, pmdGetter, rmdOtherMethod, cMax, pcOtherMethod)
      => ComCall(58, this.p, UInt32, prop, UInt32.Ptr, pClass, "Str", szProperty, UInt32, cchProperty, UInt32.Ptr, pchProperty, UInt32.Ptr, pdwPropFlags, UInt8.Ptr.Ptr, ppvSig, UInt32.Ptr, pbSig, UInt32.Ptr, pdwCPlusTypeFlag, Struct.Ptr.Ptr, ppDefaultValue, UInt32.Ptr, pcchDefaultValue, UInt32.Ptr, pmdSetter, UInt32.Ptr, pmdGetter, UInt32.Ptr, rmdOtherMethod, UInt32, cMax, UInt32.Ptr, pcOtherMethod)
    GetParamProps(tk, pmd, pulSequence, szName?, pchName, pdwAttr, pdwCPlusTypeFlag, ppValue, pcchValue)
      => ComCall(59, this.p, UInt32, tk, UInt32.Ptr, pmd, UInt32.Ptr, pulSequence, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, UInt32.Ptr, pdwAttr, UInt32.Ptr, pdwCPlusTypeFlag, Struct.Ptr.Ptr, ppValue, UInt32.Ptr, pcchValue)
    GetCustomAttributeByName(tkObj, szName, ppData, pcbData)
      => ComCall(60, this.p, UInt32, tkObj, "Str", szName, Struct.Ptr.Ptr, ppData, UInt32.Ptr, pcbData)
    IsValidToken(tk)
      => ComCall(61, this.p, UInt32, tk, BOOL)
    GetNestedClassProps(tdNestedClass, ptdEnclosingClass)
      => ComCall(62, this.p, UInt32, tdNestedClass, UInt32.Ptr, ptdEnclosingClass)
    GetNativeCallConvFromSig(pvSig, cbSig, pCallConv)
      => ComCall(63, this.p, Struct.Ptr, pvSig, UInt32, cbSig, UInt32.Ptr, pCallConv)
    IsGlobal(pd, pbGlobal)
      => ComCall(64, this.p, UInt32, pd, Int32.Ptr, pbGlobal)
}
struct IMetaDataImport2 extends IMetaDataImport {
    static IID := "{FCE5EFA0-8BBA-4F8E-A036-8F2022B08466}"
    EnumGenericParams(phEnum, tk, rGenericParams, cMax, pcGenericParams)
      => ComCall(65, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tk, UInt32.Ptr, rGenericParams, UInt32, cMax, UInt32.Ptr, pcGenericParams)
    GetGenericParamProps(gp, pulParamSeq, pdwParamFlags, ptOwner, reserved, wzname?, pchName)
      => ComCall(66, this.p, UInt32, gp, UInt32.Ptr, pulParamSeq, UInt32.Ptr, pdwParamFlags, UInt32.Ptr, ptOwner, UInt32.Ptr, reserved, PWSTR, wzname?, UInt32, wzname?.Length ?? 0, UInt32.Ptr, pchName)
    GetMethodSpecProps(mi, tkParent, ppvSigBlob, pcbSigBlob)
      => ComCall(67, this.p, UInt32, mi, UInt32.Ptr, tkParent, UInt8.Ptr.Ptr, ppvSigBlob, UInt32.Ptr, pcbSigBlob)
    EnumGenericParamConstraints(phEnum, tk, rGenericParamConstraints, cMax, pcGenericParamConstraints)
      => ComCall(68, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tk, UInt32.Ptr, rGenericParamConstraints, UInt32, cMax, UInt32.Ptr, pcGenericParamConstraints)
    GetGenericParamConstraintProps(gpc, ptGenericParam, ptkConstraintType)
      => ComCall(69, this.p, UInt32, gpc, UInt32.Ptr, ptGenericParam, UInt32.Ptr, ptkConstraintType)
    GetPEKind(pdwPEKind, pdwMAchine)
      => ComCall(70, this.p, UInt32.Ptr, pdwPEKind, UInt32.Ptr, pdwMAchine)
    GetVersionString(pwzBuf?, pccBufSize)
      => ComCall(71, this.p, PWSTR, pwzBuf?, UInt32, pwzBuf?.Length ?? 0, UInt32.Ptr, pccBufSize)
    EnumMethodSpecs(phEnum, tk, rMethodSpecs, cMax, pcMethodSpecs)
      => ComCall(72, this.p, Struct.Ptr.Ptr, phEnum, UInt32, tk, UInt32.Ptr, rMethodSpecs, UInt32, cMax, UInt32.Ptr, pcMethodSpecs)
}
struct IMetaDataFilter extends IUnknown {
    static IID := "{D0E80DD1-12D4-11D3-B39D-00C04FF81795}"
    UnmarkAll()
      => ComCall(3, this.p)
    MarkToken(tk)
      => ComCall(4, this.p, UInt32, tk)
    IsTokenMarked(tk, pIsMarked)
      => ComCall(5, this.p, UInt32, tk, BOOL.Ptr, pIsMarked)
}
struct IHostFilter extends IUnknown {
    static IID := "{D0E80DD3-12D4-11D3-B39D-00C04FF81795}"
    MarkToken(tk)
      => ComCall(3, this.p, UInt32, tk)
}
struct OSINFO {
    dwOSPlatformId : UInt32
    dwOSMajorVersion : UInt32
    dwOSMinorVersion : UInt32
}
struct ASSEMBLYMETADATA {
    usMajorVersion : UInt16
    usMinorVersion : UInt16
    usBuildNumber : UInt16
    usRevisionNumber : UInt16
    szLocale : PWSTR
    cbLocale : UInt32
    rProcessor : UInt32.Ptr
    ulProcessor : UInt32
    rOS : OSINFO.Ptr
    ulOS : UInt32
}
struct IMetaDataAssemblyEmit extends IUnknown {
    static IID := "{211EF15B-5317-4438-B196-DEC87B887693}"
    DefineAssembly(pbPublicKey, cbPublicKey, ulHashAlgId, szName, pMetaData, dwAssemblyFlags, pma)
      => ComCall(3, this.p, Struct.Ptr, pbPublicKey, UInt32, cbPublicKey, UInt32, ulHashAlgId, "Str", szName, ASSEMBLYMETADATA.Ptr, pMetaData, UInt32, dwAssemblyFlags, UInt32.Ptr, pma)
    DefineAssemblyRef(pbPublicKeyOrToken, cbPublicKeyOrToken, szName, pMetaData, pbHashValue, cbHashValue, dwAssemblyRefFlags, pmdar)
      => ComCall(4, this.p, Struct.Ptr, pbPublicKeyOrToken, UInt32, cbPublicKeyOrToken, "Str", szName, ASSEMBLYMETADATA.Ptr, pMetaData, Struct.Ptr, pbHashValue, UInt32, cbHashValue, UInt32, dwAssemblyRefFlags, UInt32.Ptr, pmdar)
    DefineFile(szName, pbHashValue, cbHashValue, dwFileFlags, pmdf)
      => ComCall(5, this.p, "Str", szName, Struct.Ptr, pbHashValue, UInt32, cbHashValue, UInt32, dwFileFlags, UInt32.Ptr, pmdf)
    DefineExportedType(szName, tkImplementation, tkTypeDef, dwExportedTypeFlags, pmdct)
      => ComCall(6, this.p, "Str", szName, UInt32, tkImplementation, UInt32, tkTypeDef, UInt32, dwExportedTypeFlags, UInt32.Ptr, pmdct)
    DefineManifestResource(szName, tkImplementation, dwOffset, dwResourceFlags, pmdmr)
      => ComCall(7, this.p, "Str", szName, UInt32, tkImplementation, UInt32, dwOffset, UInt32, dwResourceFlags, UInt32.Ptr, pmdmr)
    SetAssemblyProps(pma, pbPublicKey, cbPublicKey, ulHashAlgId, szName, pMetaData, dwAssemblyFlags)
      => ComCall(8, this.p, UInt32, pma, Struct.Ptr, pbPublicKey, UInt32, cbPublicKey, UInt32, ulHashAlgId, "Str", szName, ASSEMBLYMETADATA.Ptr, pMetaData, UInt32, dwAssemblyFlags)
    SetAssemblyRefProps(ar, pbPublicKeyOrToken, cbPublicKeyOrToken, szName, pMetaData, pbHashValue, cbHashValue, dwAssemblyRefFlags)
      => ComCall(9, this.p, UInt32, ar, Struct.Ptr, pbPublicKeyOrToken, UInt32, cbPublicKeyOrToken, "Str", szName, ASSEMBLYMETADATA.Ptr, pMetaData, Struct.Ptr, pbHashValue, UInt32, cbHashValue, UInt32, dwAssemblyRefFlags)
    SetFileProps(file, pbHashValue, cbHashValue, dwFileFlags)
      => ComCall(10, this.p, UInt32, file, Struct.Ptr, pbHashValue, UInt32, cbHashValue, UInt32, dwFileFlags)
    SetExportedTypeProps(ct, tkImplementation, tkTypeDef, dwExportedTypeFlags)
      => ComCall(11, this.p, UInt32, ct, UInt32, tkImplementation, UInt32, tkTypeDef, UInt32, dwExportedTypeFlags)
    SetManifestResourceProps(mr, tkImplementation, dwOffset, dwResourceFlags)
      => ComCall(12, this.p, UInt32, mr, UInt32, tkImplementation, UInt32, dwOffset, UInt32, dwResourceFlags)
}
struct IMetaDataAssemblyImport extends IUnknown {
    static IID := "{EE62470B-E94B-424E-9B7C-2F00C9249F93}"
    GetAssemblyProps(mda, ppbPublicKey, pcbPublicKey, pulHashAlgId, szName?, pchName, pMetaData, pdwAssemblyFlags)
      => ComCall(3, this.p, UInt32, mda, Struct.Ptr.Ptr, ppbPublicKey, UInt32.Ptr, pcbPublicKey, UInt32.Ptr, pulHashAlgId, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, ASSEMBLYMETADATA.Ptr, pMetaData, UInt32.Ptr, pdwAssemblyFlags)
    GetAssemblyRefProps(mdar, ppbPublicKeyOrToken, pcbPublicKeyOrToken, szName?, pchName, pMetaData, ppbHashValue, pcbHashValue, pdwAssemblyRefFlags)
      => ComCall(4, this.p, UInt32, mdar, Struct.Ptr.Ptr, ppbPublicKeyOrToken, UInt32.Ptr, pcbPublicKeyOrToken, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, ASSEMBLYMETADATA.Ptr, pMetaData, Struct.Ptr.Ptr, ppbHashValue, UInt32.Ptr, pcbHashValue, UInt32.Ptr, pdwAssemblyRefFlags)
    GetFileProps(mdf, szName?, pchName, ppbHashValue, pcbHashValue, pdwFileFlags)
      => ComCall(5, this.p, UInt32, mdf, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, Struct.Ptr.Ptr, ppbHashValue, UInt32.Ptr, pcbHashValue, UInt32.Ptr, pdwFileFlags)
    GetExportedTypeProps(mdct, szName?, pchName, ptkImplementation, ptkTypeDef, pdwExportedTypeFlags)
      => ComCall(6, this.p, UInt32, mdct, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, UInt32.Ptr, ptkImplementation, UInt32.Ptr, ptkTypeDef, UInt32.Ptr, pdwExportedTypeFlags)
    GetManifestResourceProps(mdmr, szName?, pchName, ptkImplementation, pdwOffset, pdwResourceFlags)
      => ComCall(7, this.p, UInt32, mdmr, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName, UInt32.Ptr, ptkImplementation, UInt32.Ptr, pdwOffset, UInt32.Ptr, pdwResourceFlags)
    EnumAssemblyRefs(phEnum, rAssemblyRefs, cMax, pcTokens)
      => ComCall(8, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rAssemblyRefs, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumFiles(phEnum, rFiles, cMax, pcTokens)
      => ComCall(9, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rFiles, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumExportedTypes(phEnum, rExportedTypes, cMax, pcTokens)
      => ComCall(10, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rExportedTypes, UInt32, cMax, UInt32.Ptr, pcTokens)
    EnumManifestResources(phEnum, rManifestResources, cMax, pcTokens)
      => ComCall(11, this.p, Struct.Ptr.Ptr, phEnum, UInt32.Ptr, rManifestResources, UInt32, cMax, UInt32.Ptr, pcTokens)
    GetAssemblyFromScope(ptkAssembly)
      => ComCall(12, this.p, UInt32.Ptr, ptkAssembly)
    FindExportedTypeByName(szName, mdtExportedType, ptkExportedType)
      => ComCall(13, this.p, "Str", szName, UInt32, mdtExportedType, UInt32.Ptr, ptkExportedType)
    FindManifestResourceByName(szName, ptkManifestResource)
      => ComCall(14, this.p, "Str", szName, UInt32.Ptr, ptkManifestResource)
    CloseEnum(hEnum)
      => ComCall(15, this.p, Struct.Ptr, hEnum, "void")
    FindAssembliesByName(szAppBase, szPrivateBin, szAssemblyName, ppIUnk, cMax, pcAssemblies)
      => ComCall(16, this.p, "Str", szAppBase, "Str", szPrivateBin, "Str", szAssemblyName, IUnknown.Ptr, ppIUnk, UInt32, cMax, UInt32.Ptr, pcAssemblies)
}
struct CorValidatorModuleType extends Int32 {
    static ValidatorModuleTypeInvalid := 0
    static ValidatorModuleTypeMin := 1
    static ValidatorModuleTypePE := 1
    static ValidatorModuleTypeObj := 2
    static ValidatorModuleTypeEnc := 3
    static ValidatorModuleTypeIncr := 4
    static ValidatorModuleTypeMax := 4
}
struct IMetaDataValidate extends IUnknown {
    static IID := "{4709C9C6-81FF-11D3-9FC7-00C04F79A0A3}"
    ValidatorInit(dwModuleType, pUnk)
      => ComCall(3, this.p, UInt32, dwModuleType, IUnknown, pUnk)
    ValidateMetaData()
      => ComCall(4, this.p)
}
struct IMetaDataDispenserEx extends IMetaDataDispenser {
    static IID := "{31BCFCE2-DAFB-11D2-9F81-00C04F79A0A3}"
    SetOption(optionid, value)
      => ComCall(6, this.p, GUID.Ptr, optionid, VARIANT.Ptr, value)
    GetOption(optionid, pvalue)
      => ComCall(7, this.p, GUID.Ptr, optionid, VARIANT.Ptr, pvalue)
    OpenScopeOnITypeInfo(pITI, dwOpenFlags, riid, ppIUnk)
      => ComCall(8, this.p, ITypeInfo, pITI, UInt32, dwOpenFlags, GUID.Ptr, riid, IUnknown.Ptr, ppIUnk)
    GetCORSystemDirectory(szBuffer?, pchBuffer)
      => ComCall(9, this.p, PWSTR, szBuffer?, UInt32, szBuffer?.Length ?? 0, UInt32.Ptr, pchBuffer)
    FindAssembly(szAppBase, szPrivateBin, szGlobalBin, szAssemblyName, szName, cchName, pcName)
      => ComCall(10, this.p, "Str", szAppBase, "Str", szPrivateBin, "Str", szGlobalBin, "Str", szAssemblyName, "Str", szName, UInt32, cchName, UInt32.Ptr, pcName)
    FindAssemblyModule(szAppBase, szPrivateBin, szGlobalBin, szAssemblyName, szModuleName, szName?, pcName)
      => ComCall(11, this.p, "Str", szAppBase, "Str", szPrivateBin, "Str", szGlobalBin, "Str", szAssemblyName, "Str", szModuleName, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pcName)
}
struct CorRegFlags extends Int32 {
    static regNoCopy := 1
    static regConfig := 2
    static regHasRefs := 4
}
struct CVStruct {
    Major : Int16
    Minor : Int16
    Sub : Int16
    Build : Int16
}
struct CeeSectionAttr extends Int64 {
    static sdNone := 0
    static sdReadOnly := 1073741888
    static sdReadWrite := 3221225536
    static sdExecute := 1610612768
}
struct CeeSectionRelocType extends Int32 {
    static srRelocAbsolute := 0
    static srRelocHighLow := 3
    static srRelocHighAdj := 4
    static srRelocMapToken := 5
    static srRelocRelative := 6
    static srRelocFilePos := 7
    static srRelocCodeRelative := 8
    static srRelocIA64Imm64 := 9
    static srRelocDir64 := 10
    static srRelocIA64PcRel25 := 11
    static srRelocIA64PcRel64 := 12
    static srRelocAbsoluteTagged := 13
    static srRelocSentinel := 14
    static srNoBaseReloc := 16384
    static srRelocPtr := 32768
    static srRelocAbsolutePtr := 32768
    static srRelocHighLowPtr := 32771
    static srRelocRelativePtr := 32774
    static srRelocIA64Imm64Ptr := 32777
    static srRelocDir64Ptr := 32778
}
struct CeeSectionRelocExtra {
    union {
        highAdj : UInt16
    }
}
struct ICeeGen extends IUnknown {
    static IID := "{7ED1BDFF-8E36-11D2-9C56-00A0C9B7CC45}"
    EmitString(lpString, RVA)
      => ComCall(3, this.p, "Str", lpString, UInt32.Ptr, RVA)
    GetString(RVA, lpString?)
      => ComCall(4, this.p, UInt32, RVA, PWSTR.Ptr, lpString?)
    AllocateMethodBuffer(cchBuffer, lpBuffer, RVA)
      => ComCall(5, this.p, UInt32, cchBuffer, UInt8.Ptr.Ptr, lpBuffer, UInt32.Ptr, RVA)
    GetMethodBuffer(RVA, lpBuffer)
      => ComCall(6, this.p, UInt32, RVA, UInt8.Ptr.Ptr, lpBuffer)
    GetIMapTokenIface(pIMapToken)
      => ComCall(7, this.p, IUnknown.Ptr, pIMapToken)
    GenerateCeeFile()
      => ComCall(8, this.p)
    GetIlSection(section)
      => ComCall(9, this.p, Struct.Ptr.Ptr, section)
    GetStringSection(section)
      => ComCall(10, this.p, Struct.Ptr.Ptr, section)
    AddSectionReloc(section, offset, relativeTo, relocType)
      => ComCall(11, this.p, Struct.Ptr, section, UInt32, offset, Struct.Ptr, relativeTo, CeeSectionRelocType, relocType)
    GetSectionCreate(name, flags, section)
      => ComCall(12, this.p, PSTR, name, UInt32, flags, Struct.Ptr.Ptr, section)
    GetSectionDataLen(section, dataLen)
      => ComCall(13, this.p, Struct.Ptr, section, UInt32.Ptr, dataLen)
    GetSectionBlock(section, len, align, ppBytes)
      => ComCall(14, this.p, Struct.Ptr, section, UInt32, len, UInt32, align, Struct.Ptr.Ptr, ppBytes)
    TruncateSection(section, len)
      => ComCall(15, this.p, Struct.Ptr, section, UInt32, len)
    GenerateCeeMemoryImage(ppImage)
      => ComCall(16, this.p, Struct.Ptr.Ptr, ppImage)
    ComputePointer(section, RVA, lpBuffer)
      => ComCall(17, this.p, Struct.Ptr, section, UInt32, RVA, UInt8.Ptr.Ptr, lpBuffer)
}
struct IMetaDataTables extends IUnknown {
    static IID := "{D8F579AB-402D-4B8E-82D9-5D63B1065C68}"
    GetStringHeapSize(pcbStrings)
      => ComCall(3, this.p, UInt32.Ptr, pcbStrings)
    GetBlobHeapSize(pcbBlobs)
      => ComCall(4, this.p, UInt32.Ptr, pcbBlobs)
    GetGuidHeapSize(pcbGuids)
      => ComCall(5, this.p, UInt32.Ptr, pcbGuids)
    GetUserStringHeapSize(pcbBlobs)
      => ComCall(6, this.p, UInt32.Ptr, pcbBlobs)
    GetNumTables(pcTables)
      => ComCall(7, this.p, UInt32.Ptr, pcTables)
    GetTableIndex(token, pixTbl)
      => ComCall(8, this.p, UInt32, token, UInt32.Ptr, pixTbl)
    GetTableInfo(ixTbl, pcbRow, pcRows, pcCols, piKey, ppName)
      => ComCall(9, this.p, UInt32, ixTbl, UInt32.Ptr, pcbRow, UInt32.Ptr, pcRows, UInt32.Ptr, pcCols, UInt32.Ptr, piKey, Int8.Ptr.Ptr, ppName)
    GetColumnInfo(ixTbl, ixCol, poCol, pcbCol, pType, ppName)
      => ComCall(10, this.p, UInt32, ixTbl, UInt32, ixCol, UInt32.Ptr, poCol, UInt32.Ptr, pcbCol, UInt32.Ptr, pType, Int8.Ptr.Ptr, ppName)
    GetCodedTokenInfo(ixCdTkn, pcTokens, ppTokens, ppName)
      => ComCall(11, this.p, UInt32, ixCdTkn, UInt32.Ptr, pcTokens, UInt32.Ptr.Ptr, ppTokens, Int8.Ptr.Ptr, ppName)
    GetRow(ixTbl, rid, ppRow)
      => ComCall(12, this.p, UInt32, ixTbl, UInt32, rid, Struct.Ptr.Ptr, ppRow)
    GetColumn(ixTbl, ixCol, rid, pVal)
      => ComCall(13, this.p, UInt32, ixTbl, UInt32, ixCol, UInt32, rid, UInt32.Ptr, pVal)
    GetString(ixString, ppString)
      => ComCall(14, this.p, UInt32, ixString, Int8.Ptr.Ptr, ppString)
    GetBlob(ixBlob, pcbData, ppData)
      => ComCall(15, this.p, UInt32, ixBlob, UInt32.Ptr, pcbData, Struct.Ptr.Ptr, ppData)
    GetGuid(ixGuid, ppGUID)
      => ComCall(16, this.p, UInt32, ixGuid, GUID.Ptr.Ptr, ppGUID)
    GetUserString(ixUserString, pcbData, ppData)
      => ComCall(17, this.p, UInt32, ixUserString, UInt32.Ptr, pcbData, Struct.Ptr.Ptr, ppData)
    GetNextString(ixString, pNext)
      => ComCall(18, this.p, UInt32, ixString, UInt32.Ptr, pNext)
    GetNextBlob(ixBlob, pNext)
      => ComCall(19, this.p, UInt32, ixBlob, UInt32.Ptr, pNext)
    GetNextGuid(ixGuid, pNext)
      => ComCall(20, this.p, UInt32, ixGuid, UInt32.Ptr, pNext)
    GetNextUserString(ixUserString, pNext)
      => ComCall(21, this.p, UInt32, ixUserString, UInt32.Ptr, pNext)
}
struct IMetaDataTables2 extends IMetaDataTables {
    static IID := "{BADB5F70-58DA-43A9-A1C6-D74819F19B15}"
    GetMetaDataStorage(ppvMd, pcbMd)
      => ComCall(22, this.p, Struct.Ptr.Ptr, ppvMd, UInt32.Ptr, pcbMd)
    GetMetaDataStreamInfo(ix, ppchName, ppv, pcb)
      => ComCall(23, this.p, UInt32, ix, Int8.Ptr.Ptr, ppchName, Struct.Ptr.Ptr, ppv, UInt32.Ptr, pcb)
}
struct IMetaDataInfo extends IUnknown {
    static IID := "{7998EA64-7F95-48B8-86FC-17CAF48BF5CB}"
    GetFileMapping(ppvData, pcbData, pdwMappingType)
      => ComCall(3, this.p, Struct.Ptr.Ptr, ppvData, Int64.Ptr, pcbData, UInt32.Ptr, pdwMappingType)
}
struct IMetaDataWinMDImport extends IUnknown {
    static IID := "{969EA0C5-964E-411B-A807-B0F3C2DFCBD4}"
    GetUntransformedTypeRefProps(tr, ptkResolutionScope, szName?, pchName)
      => ComCall(3, this.p, UInt32, tr, UInt32.Ptr, ptkResolutionScope, PWSTR, szName?, UInt32, szName?.Length ?? 0, UInt32.Ptr, pchName)
}
struct COR_NATIVE_LINK {
    m_linkType : UInt8
    m_flags : UInt8
    m_entryPoint : UInt32
}
struct CorNativeLinkType extends Int32 {
    static nltNone := 1
    static nltAnsi := 2
    static nltUnicode := 3
    static nltAuto := 4
    static nltOle := 5
    static nltMaxValue := 7
}
struct CorNativeLinkFlags extends Int32 {
    static nlfNone := 0
    static nlfLastError := 1
    static nlfNoMangle := 2
    static nlfMaxValue := 3
}
struct IRoSimpleMetaDataBuilder extends InterfacePointer {
    SetWinRtInterface(iid)
      => ComCall(0, this.p, GUID, iid)
    SetDelegate(iid)
      => ComCall(1, this.p, GUID, iid)
    SetInterfaceGroupSimpleDefault(name, defaultInterfaceName, defaultInterfaceIID?)
      => ComCall(2, this.p, "Str", name, "Str", defaultInterfaceName, GUID.Ptr, defaultInterfaceIID?)
    SetInterfaceGroupParameterizedDefault(name, defaultInterfaceNameElements)
      => ComCall(3, this.p, "Str", name, UInt32, defaultInterfaceNameElements.Length, PWSTR.Ptr, defaultInterfaceNameElements)
    SetRuntimeClassSimpleDefault(name, defaultInterfaceName, defaultInterfaceIID?)
      => ComCall(4, this.p, "Str", name, "Str", defaultInterfaceName, GUID.Ptr, defaultInterfaceIID?)
    SetRuntimeClassParameterizedDefault(name, defaultInterfaceNameElements)
      => ComCall(5, this.p, "Str", name, UInt32, defaultInterfaceNameElements.Length, PWSTR.Ptr, defaultInterfaceNameElements)
    SetStruct(name, fieldTypeNames)
      => ComCall(6, this.p, "Str", name, UInt32, fieldTypeNames.Length, PWSTR.Ptr, fieldTypeNames)
    SetEnum(name, baseType)
      => ComCall(7, this.p, "Str", name, "Str", baseType)
    SetParameterizedInterface(piid, numArgs)
      => ComCall(8, this.p, GUID, piid, UInt32, numArgs)
    SetParameterizedDelegate(piid, numArgs)
      => ComCall(9, this.p, GUID, piid, UInt32, numArgs)
}
struct IRoMetaDataLocator extends InterfacePointer {
    Locate(nameElement, metaDataDestination)
      => ComCall(0, this.p, "Str", nameElement, IRoSimpleMetaDataBuilder, metaDataDestination)
}
