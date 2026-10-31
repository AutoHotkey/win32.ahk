#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HANDLE, HRESULT, HWND, LUID, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\Security\Types.ahk" {ACE_FLAGS, ACE_HEADER, OBJECT_TYPE_LIST, PSID, SID, SID_AND_ATTRIBUTES, SYSTEM_AUDIT_OBJECT_ACE_FLAGS}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct AUTHZ_RESOURCE_MANAGER_FLAGS extends UInt32 {
    static AUTHZ_RM_FLAG_NO_AUDIT := 1
    static AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION := 2
    static AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES := 4
}
struct AUTHZ_ACCESS_CHECK_FLAGS extends UInt32 {
    static AUTHZ_ACCESS_CHECK_NO_DEEP_COPY_SD := 1
}
struct AUTHZ_INITIALIZE_OBJECT_ACCESS_AUDIT_EVENT_FLAGS extends UInt32 {
    static AUTHZ_NO_SUCCESS_AUDIT := 1
    static AUTHZ_NO_FAILURE_AUDIT := 2
    static AUTHZ_NO_ALLOC_STRINGS := 4
}
struct TREE_SEC_INFO extends UInt32 {
    static TREE_SEC_INFO_SET := 1
    static TREE_SEC_INFO_RESET := 2
    static TREE_SEC_INFO_RESET_KEEP_EXPLICIT := 3
}
struct AUTHZ_GENERATE_RESULTS extends UInt32 {
    static AUTHZ_GENERATE_SUCCESS_AUDIT := 1
    static AUTHZ_GENERATE_FAILURE_AUDIT := 2
}
struct ACTRL_ACCESS_ENTRY_ACCESS_FLAGS extends UInt32 {
    static ACTRL_ACCESS_ALLOWED := 1
    static ACTRL_ACCESS_DENIED := 2
    static ACTRL_AUDIT_SUCCESS := 4
    static ACTRL_AUDIT_FAILURE := 8
}
struct AUTHZ_SECURITY_ATTRIBUTE_FLAGS extends UInt32 {
    static AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE := 1
    static AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE := 2
}
struct SE_OBJECT_TYPE extends Int32 {
    static SE_UNKNOWN_OBJECT_TYPE := 0
    static SE_FILE_OBJECT := 1
    static SE_SERVICE := 2
    static SE_PRINTER := 3
    static SE_REGISTRY_KEY := 4
    static SE_LMSHARE := 5
    static SE_KERNEL_OBJECT := 6
    static SE_WINDOW_OBJECT := 7
    static SE_DS_OBJECT := 8
    static SE_DS_OBJECT_ALL := 9
    static SE_PROVIDER_DEFINED_OBJECT := 10
    static SE_WMIGUID_OBJECT := 11
    static SE_REGISTRY_WOW64_32KEY := 12
    static SE_REGISTRY_WOW64_64KEY := 13
}
struct TRUSTEE_TYPE extends Int32 {
    static TRUSTEE_IS_UNKNOWN := 0
    static TRUSTEE_IS_USER := 1
    static TRUSTEE_IS_GROUP := 2
    static TRUSTEE_IS_DOMAIN := 3
    static TRUSTEE_IS_ALIAS := 4
    static TRUSTEE_IS_WELL_KNOWN_GROUP := 5
    static TRUSTEE_IS_DELETED := 6
    static TRUSTEE_IS_INVALID := 7
    static TRUSTEE_IS_COMPUTER := 8
}
struct TRUSTEE_FORM extends Int32 {
    static TRUSTEE_IS_SID := 0
    static TRUSTEE_IS_NAME := 1
    static TRUSTEE_BAD_FORM := 2
    static TRUSTEE_IS_OBJECTS_AND_SID := 3
    static TRUSTEE_IS_OBJECTS_AND_NAME := 4
}
struct MULTIPLE_TRUSTEE_OPERATION extends Int32 {
    static NO_MULTIPLE_TRUSTEE := 0
    static TRUSTEE_IS_IMPERSONATE := 1
}
struct OBJECTS_AND_SID {
    ObjectsPresent : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectTypeGuid : GUID
    InheritedObjectTypeGuid : GUID
    pSid : SID.Ptr
}
struct OBJECTS_AND_NAME_A {
    ObjectsPresent : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : SE_OBJECT_TYPE
    ObjectTypeName : PSTR
    InheritedObjectTypeName : PSTR
    ptstrName : PSTR
}
struct OBJECTS_AND_NAME_W {
    ObjectsPresent : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : SE_OBJECT_TYPE
    ObjectTypeName : PWSTR
    InheritedObjectTypeName : PWSTR
    ptstrName : PWSTR
}
struct TRUSTEE_A {
    pMultipleTrustee : TRUSTEE_A.Ptr
    MultipleTrusteeOperation : MULTIPLE_TRUSTEE_OPERATION
    TrusteeForm : TRUSTEE_FORM
    TrusteeType : TRUSTEE_TYPE
    ptstrName : PSTR
}
struct TRUSTEE_W {
    pMultipleTrustee : TRUSTEE_W.Ptr
    MultipleTrusteeOperation : MULTIPLE_TRUSTEE_OPERATION
    TrusteeForm : TRUSTEE_FORM
    TrusteeType : TRUSTEE_TYPE
    ptstrName : PWSTR
}
struct ACCESS_MODE extends Int32 {
    static NOT_USED_ACCESS := 0
    static GRANT_ACCESS := 1
    static SET_ACCESS := 2
    static DENY_ACCESS := 3
    static REVOKE_ACCESS := 4
    static SET_AUDIT_SUCCESS := 5
    static SET_AUDIT_FAILURE := 6
}
struct EXPLICIT_ACCESS_A {
    grfAccessPermissions : UInt32
    grfAccessMode : ACCESS_MODE
    grfInheritance : ACE_FLAGS
    Trustee : TRUSTEE_A
}
struct EXPLICIT_ACCESS_W {
    grfAccessPermissions : UInt32
    grfAccessMode : ACCESS_MODE
    grfInheritance : ACE_FLAGS
    Trustee : TRUSTEE_W
}
struct ACTRL_ACCESS_ENTRYA {
    Trustee : TRUSTEE_A
    fAccessFlags : ACTRL_ACCESS_ENTRY_ACCESS_FLAGS
    Access : UInt32
    ProvSpecificAccess : UInt32
    Inheritance : ACE_FLAGS
    lpInheritProperty : PSTR
}
struct ACTRL_ACCESS_ENTRYW {
    Trustee : TRUSTEE_W
    fAccessFlags : ACTRL_ACCESS_ENTRY_ACCESS_FLAGS
    Access : UInt32
    ProvSpecificAccess : UInt32
    Inheritance : ACE_FLAGS
    lpInheritProperty : PWSTR
}
struct ACTRL_ACCESS_ENTRY_LISTA {
    cEntries : UInt32
    pAccessList : ACTRL_ACCESS_ENTRYA.Ptr
}
struct ACTRL_ACCESS_ENTRY_LISTW {
    cEntries : UInt32
    pAccessList : ACTRL_ACCESS_ENTRYW.Ptr
}
struct ACTRL_PROPERTY_ENTRYA {
    lpProperty : PSTR
    pAccessEntryList : ACTRL_ACCESS_ENTRY_LISTA.Ptr
    fListFlags : UInt32
}
struct ACTRL_PROPERTY_ENTRYW {
    lpProperty : PWSTR
    pAccessEntryList : ACTRL_ACCESS_ENTRY_LISTW.Ptr
    fListFlags : UInt32
}
struct ACTRL_ACCESSA {
    cEntries : UInt32
    pPropertyAccessList : ACTRL_PROPERTY_ENTRYA.Ptr
}
struct ACTRL_ACCESSW {
    cEntries : UInt32
    pPropertyAccessList : ACTRL_PROPERTY_ENTRYW.Ptr
}
struct TRUSTEE_ACCESSA {
    lpProperty : PSTR
    Access : UInt32
    fAccessFlags : UInt32
    fReturnedAccess : UInt32
}
struct TRUSTEE_ACCESSW {
    lpProperty : PWSTR
    Access : UInt32
    fAccessFlags : UInt32
    fReturnedAccess : UInt32
}
struct ACTRL_OVERLAPPED {
    Anonymous : this._Anonymous_e__Union
    Reserved2 : UInt32
    hEvent : HANDLE
    struct _Anonymous_e__Union {
        union {
            Provider : Struct.Ptr
            Reserved1 : UInt32
        }
    }
}
struct ACTRL_ACCESS_INFOA {
    fAccessPermission : UInt32
    lpAccessPermissionName : PSTR
}
struct ACTRL_ACCESS_INFOW {
    fAccessPermission : UInt32
    lpAccessPermissionName : PWSTR
}
struct ACTRL_CONTROL_INFOA {
    lpControlId : PSTR
    lpControlName : PSTR
}
struct ACTRL_CONTROL_INFOW {
    lpControlId : PWSTR
    lpControlName : PWSTR
}
struct PROG_INVOKE_SETTING extends Int32 {
    static ProgressInvokeNever := 1
    static ProgressInvokeEveryObject := 2
    static ProgressInvokeOnError := 3
    static ProgressCancelOperation := 4
    static ProgressRetryOperation := 5
    static ProgressInvokePrePostError := 6
}
struct FN_OBJECT_MGR_FUNCTS {
    Placeholder : UInt32
}
struct INHERITED_FROMA {
    GenerationGap : Int32
    AncestorName : PSTR
}
struct INHERITED_FROMW {
    GenerationGap : Int32
    AncestorName : PWSTR
}
struct AUDIT_PARAM_TYPE extends Int32 {
    static APT_None := 1
    static APT_String := 2
    static APT_Ulong := 3
    static APT_Pointer := 4
    static APT_Sid := 5
    static APT_LogonId := 6
    static APT_ObjectTypeList := 7
    static APT_Luid := 8
    static APT_Guid := 9
    static APT_Time := 10
    static APT_Int64 := 11
    static APT_IpAddress := 12
    static APT_LogonIdWithSid := 13
}
struct AUDIT_OBJECT_TYPE {
    ObjectType : GUID
    Flags : UInt16
    Level : UInt16
    AccessMask : UInt32
}
struct AUDIT_OBJECT_TYPES {
    Count : UInt16
    Flags : UInt16
    pObjectTypes : AUDIT_OBJECT_TYPE.Ptr
}
struct AUDIT_IP_ADDRESS {
    pIpAddress : UInt8[128]
}
struct AUDIT_PARAM {
    Type : AUDIT_PARAM_TYPE
    Length : UInt32
    Flags : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            Data0 : IntPtr
            String : PWSTR
            u : IntPtr
            psid : SID.Ptr
            pguid : GUID.Ptr
            LogonId_LowPart : UInt32
            pObjectTypes : AUDIT_OBJECT_TYPES.Ptr
            pIpAddress : AUDIT_IP_ADDRESS.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Data1 : IntPtr
            LogonId_HighPart : Int32
        }
    }
}
struct AUDIT_PARAMS {
    Length : UInt32
    Flags : UInt32
    Count : UInt16
    Parameters : AUDIT_PARAM.Ptr
}
struct AUTHZ_AUDIT_EVENT_TYPE_LEGACY {
    CategoryId : UInt16
    AuditId : UInt16
    ParameterCount : UInt16
}
struct AUTHZ_AUDIT_EVENT_TYPE_UNION {
    union {
        Legacy : AUTHZ_AUDIT_EVENT_TYPE_LEGACY
    }
}
struct AUTHZ_AUDIT_EVENT_TYPE_OLD {
    Version : UInt32
    dwFlags : UInt32
    RefCount : Int32
    hAudit : IntPtr
    LinkId : LUID
    u : AUTHZ_AUDIT_EVENT_TYPE_UNION
}
struct AUTHZ_ACCESS_REQUEST {
    DesiredAccess : UInt32
    PrincipalSelfSid : PSID
    ObjectTypeList : OBJECT_TYPE_LIST.Ptr
    ObjectTypeListLength : UInt32
    OptionalArguments : Struct.Ptr
}
struct AUTHZ_ACCESS_REPLY {
    ResultListLength : UInt32
    GrantedAccessMask : UInt32.Ptr
    SaclEvaluationResults : AUTHZ_GENERATE_RESULTS.Ptr
    Error : UInt32.Ptr
}
struct PFN_AUTHZ_DYNAMIC_ACCESS_CHECK extends FunctionPointer {
    static Types := [AUTHZ_CLIENT_CONTEXT_HANDLE, ACE_HEADER.Ptr, Struct.Ptr, BOOL.Ptr, BOOL]
}
struct PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS extends FunctionPointer {
    static Types := [AUTHZ_CLIENT_CONTEXT_HANDLE, Struct.Ptr, SID_AND_ATTRIBUTES.Ptr.Ptr, UInt32.Ptr, SID_AND_ATTRIBUTES.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_AUTHZ_FREE_DYNAMIC_GROUPS extends FunctionPointer {
    static Types := [SID_AND_ATTRIBUTES.Ptr, "Void"]
}
struct PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY extends FunctionPointer {
    static Types := [AUTHZ_CLIENT_CONTEXT_HANDLE, PSID, Struct.Ptr, BOOL.Ptr, Struct.Ptr.Ptr, BOOL]
}
struct PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE {
    Version : Int64
    pName : PWSTR
}
struct AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE {
    pValue : Struct.Ptr
    ValueLength : UInt32
}
struct AUTHZ_SECURITY_ATTRIBUTE_OPERATION extends Int32 {
    static AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE := 0
    static AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL := 1
    static AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD := 2
    static AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE := 3
    static AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE := 4
}
struct AUTHZ_SID_OPERATION extends Int32 {
    static AUTHZ_SID_OPERATION_NONE := 0
    static AUTHZ_SID_OPERATION_REPLACE_ALL := 1
    static AUTHZ_SID_OPERATION_ADD := 2
    static AUTHZ_SID_OPERATION_DELETE := 3
    static AUTHZ_SID_OPERATION_REPLACE := 4
}
struct AUTHZ_SECURITY_ATTRIBUTE_V1 {
    pName : PWSTR
    ValueType : UInt16
    Reserved : UInt16
    Flags : AUTHZ_SECURITY_ATTRIBUTE_FLAGS
    ValueCount : UInt32
    Values : this._Values_e__Union
    struct _Values_e__Union {
        union {
            pInt64 : Int64.Ptr
            pUint64 : Int64.Ptr
            ppString : PWSTR.Ptr
            pFqbn : AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE.Ptr
            pOctetString : AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE.Ptr
        }
    }
}
struct AUTHZ_SECURITY_ATTRIBUTES_INFORMATION {
    Version : UInt16
    Reserved : UInt16
    AttributeCount : UInt32
    Attribute : this._Attribute_e__Union
    struct _Attribute_e__Union {
        union {
            pAttributeV1 : AUTHZ_SECURITY_ATTRIBUTE_V1.Ptr
        }
    }
}
struct AUTHZ_RPC_INIT_INFO_CLIENT {
    version : UInt16
    ObjectUuid : PWSTR
    ProtSeq : PWSTR
    NetworkAddr : PWSTR
    Endpoint : PWSTR
    Options : PWSTR
    ServerSpn : PWSTR
}
struct AUTHZ_INIT_INFO {
    version : UInt16
    szResourceManagerName : PWSTR
    pfnDynamicAccessCheck : PFN_AUTHZ_DYNAMIC_ACCESS_CHECK
    pfnComputeDynamicGroups : PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS
    pfnFreeDynamicGroups : PFN_AUTHZ_FREE_DYNAMIC_GROUPS
    pfnGetCentralAccessPolicy : PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY
    pfnFreeCentralAccessPolicy : PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY
}
struct AUTHZ_CONTEXT_INFORMATION_CLASS extends Int32 {
    static AuthzContextInfoUserSid := 1
    static AuthzContextInfoGroupsSids := 2
    static AuthzContextInfoRestrictedSids := 3
    static AuthzContextInfoPrivileges := 4
    static AuthzContextInfoExpirationTime := 5
    static AuthzContextInfoServerContext := 6
    static AuthzContextInfoIdentifier := 7
    static AuthzContextInfoSource := 8
    static AuthzContextInfoAll := 9
    static AuthzContextInfoAuthenticationId := 10
    static AuthzContextInfoSecurityAttributes := 11
    static AuthzContextInfoDeviceSids := 12
    static AuthzContextInfoUserClaims := 13
    static AuthzContextInfoDeviceClaims := 14
    static AuthzContextInfoAppContainerSid := 15
    static AuthzContextInfoCapabilitySids := 16
}
struct AUTHZ_AUDIT_EVENT_INFORMATION_CLASS extends Int32 {
    static AuthzAuditEventInfoFlags := 1
    static AuthzAuditEventInfoOperationType := 2
    static AuthzAuditEventInfoObjectType := 3
    static AuthzAuditEventInfoObjectName := 4
    static AuthzAuditEventInfoAdditionalInfo := 5
}
struct AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET {
    szObjectTypeName : PWSTR
    dwOffset : UInt32
}
struct AUTHZ_SOURCE_SCHEMA_REGISTRATION {
    dwFlags : UInt32
    szEventSourceName : PWSTR
    szEventMessageFile : PWSTR
    szEventSourceXmlSchemaFile : PWSTR
    szEventAccessStringsFile : PWSTR
    szExecutableImagePath : PWSTR
    Anonymous : this._Anonymous_e__Union
    dwObjectTypeNameCount : UInt32
    ObjectTypeNames : AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET[1]
    struct _Anonymous_e__Union {
        union {
            pReserved : Struct.Ptr
            pProviderGuid : GUID.Ptr
        }
    }
}
struct IAzAuthorizationStore extends IDispatch {
    static IID := "{EDBD9CA9-9B82-4F6A-9E8B-98301E450F14}"
    get_Description(pbstrDescription)
      => ComCall(7, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(8, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(9, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(10, this.p, BSTR, bstrApplicationData)
    get_DomainTimeout(plProp)
      => ComCall(11, this.p, Int32.Ptr, plProp)
    put_DomainTimeout(lProp)
      => ComCall(12, this.p, Int32, lProp)
    get_ScriptEngineTimeout(plProp)
      => ComCall(13, this.p, Int32.Ptr, plProp)
    put_ScriptEngineTimeout(lProp)
      => ComCall(14, this.p, Int32, lProp)
    get_MaxScriptEngines(plProp)
      => ComCall(15, this.p, Int32.Ptr, plProp)
    put_MaxScriptEngines(lProp)
      => ComCall(16, this.p, Int32, lProp)
    get_GenerateAudits(pbProp)
      => ComCall(17, this.p, BOOL.Ptr, pbProp)
    put_GenerateAudits(bProp)
      => ComCall(18, this.p, BOOL, bProp)
    get_Writable(pfProp)
      => ComCall(19, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(20, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(21, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(22, this.p, AZ_PROP_CONSTANTS, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(23, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    get_PolicyAdministrators(pvarAdmins)
      => ComCall(24, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReaders(pvarReaders)
      => ComCall(25, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(26, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(27, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReader(bstrReader, varReserved)
      => ComCall(28, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReader(bstrReader, varReserved)
      => ComCall(29, this.p, BSTR, bstrReader, VARIANT, varReserved)
    Initialize(lFlags, bstrPolicyURL, varReserved)
      => ComCall(30, this.p, AZ_PROP_CONSTANTS, lFlags, BSTR, bstrPolicyURL, VARIANT, varReserved)
    UpdateCache(varReserved)
      => ComCall(31, this.p, VARIANT, varReserved)
    Delete(varReserved)
      => ComCall(32, this.p, VARIANT, varReserved)
    get_Applications(ppAppCollection)
      => ComCall(33, this.p, IAzApplications.Ptr, ppAppCollection)
    OpenApplication(bstrApplicationName, varReserved, ppApplication)
      => ComCall(34, this.p, BSTR, bstrApplicationName, VARIANT, varReserved, IAzApplication.Ptr, ppApplication)
    CreateApplication(bstrApplicationName, varReserved, ppApplication)
      => ComCall(35, this.p, BSTR, bstrApplicationName, VARIANT, varReserved, IAzApplication.Ptr, ppApplication)
    DeleteApplication(bstrApplicationName, varReserved)
      => ComCall(36, this.p, BSTR, bstrApplicationName, VARIANT, varReserved)
    get_ApplicationGroups(ppGroupCollection)
      => ComCall(37, this.p, IAzApplicationGroups.Ptr, ppGroupCollection)
    CreateApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(38, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    OpenApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(39, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    DeleteApplicationGroup(bstrGroupName, varReserved)
      => ComCall(40, this.p, BSTR, bstrGroupName, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(41, this.p, Int32, lFlags, VARIANT, varReserved)
    get_DelegatedPolicyUsers(pvarDelegatedPolicyUsers)
      => ComCall(42, this.p, VARIANT.Ptr, pvarDelegatedPolicyUsers)
    AddDelegatedPolicyUser(bstrDelegatedPolicyUser, varReserved)
      => ComCall(43, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    DeleteDelegatedPolicyUser(bstrDelegatedPolicyUser, varReserved)
      => ComCall(44, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    get_TargetMachine(pbstrTargetMachine)
      => ComCall(45, this.p, BSTR.Ptr, pbstrTargetMachine)
    get_ApplyStoreSacl(pbApplyStoreSacl)
      => ComCall(46, this.p, BOOL.Ptr, pbApplyStoreSacl)
    put_ApplyStoreSacl(bApplyStoreSacl)
      => ComCall(47, this.p, BOOL, bApplyStoreSacl)
    get_PolicyAdministratorsName(pvarAdmins)
      => ComCall(48, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReadersName(pvarReaders)
      => ComCall(49, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(50, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(51, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReaderName(bstrReader, varReserved)
      => ComCall(52, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReaderName(bstrReader, varReserved)
      => ComCall(53, this.p, BSTR, bstrReader, VARIANT, varReserved)
    get_DelegatedPolicyUsersName(pvarDelegatedPolicyUsers)
      => ComCall(54, this.p, VARIANT.Ptr, pvarDelegatedPolicyUsers)
    AddDelegatedPolicyUserName(bstrDelegatedPolicyUser, varReserved)
      => ComCall(55, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    DeleteDelegatedPolicyUserName(bstrDelegatedPolicyUser, varReserved)
      => ComCall(56, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    CloseApplication(bstrApplicationName, lFlag)
      => ComCall(57, this.p, BSTR, bstrApplicationName, Int32, lFlag)
}
struct IAzAuthorizationStore2 extends IAzAuthorizationStore {
    static IID := "{B11E5584-D577-4273-B6C5-0973E0F8E80D}"
    OpenApplication2(bstrApplicationName, varReserved, ppApplication)
      => ComCall(58, this.p, BSTR, bstrApplicationName, VARIANT, varReserved, IAzApplication2.Ptr, ppApplication)
    CreateApplication2(bstrApplicationName, varReserved, ppApplication)
      => ComCall(59, this.p, BSTR, bstrApplicationName, VARIANT, varReserved, IAzApplication2.Ptr, ppApplication)
}
struct IAzAuthorizationStore3 extends IAzAuthorizationStore2 {
    static IID := "{ABC08425-0C86-4FA0-9BE3-7189956C926E}"
    IsUpdateNeeded(pbIsUpdateNeeded)
      => ComCall(60, this.p, VARIANT_BOOL.Ptr, pbIsUpdateNeeded)
    BizruleGroupSupported(pbSupported)
      => ComCall(61, this.p, VARIANT_BOOL.Ptr, pbSupported)
    UpgradeStoresFunctionalLevel(lFunctionalLevel)
      => ComCall(62, this.p, Int32, lFunctionalLevel)
    IsFunctionalLevelUpgradeSupported(lFunctionalLevel, pbSupported)
      => ComCall(63, this.p, Int32, lFunctionalLevel, VARIANT_BOOL.Ptr, pbSupported)
    GetSchemaVersion(plMajorVersion, plMinorVersion)
      => ComCall(64, this.p, Int32.Ptr, plMajorVersion, Int32.Ptr, plMinorVersion)
}
struct IAzApplication extends IDispatch {
    static IID := "{987BC7C7-B813-4D27-BEDE-6BA5AE867E95}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(10, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(12, this.p, BSTR, bstrApplicationData)
    get_AuthzInterfaceClsid(pbstrProp)
      => ComCall(13, this.p, BSTR.Ptr, pbstrProp)
    put_AuthzInterfaceClsid(bstrProp)
      => ComCall(14, this.p, BSTR, bstrProp)
    get_Version(pbstrProp)
      => ComCall(15, this.p, BSTR.Ptr, pbstrProp)
    put_Version(bstrProp)
      => ComCall(16, this.p, BSTR, bstrProp)
    get_GenerateAudits(pbProp)
      => ComCall(17, this.p, BOOL.Ptr, pbProp)
    put_GenerateAudits(bProp)
      => ComCall(18, this.p, BOOL, bProp)
    get_ApplyStoreSacl(pbProp)
      => ComCall(19, this.p, BOOL.Ptr, pbProp)
    put_ApplyStoreSacl(bProp)
      => ComCall(20, this.p, BOOL, bProp)
    get_Writable(pfProp)
      => ComCall(21, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(22, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(23, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    get_PolicyAdministrators(pvarAdmins)
      => ComCall(24, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReaders(pvarReaders)
      => ComCall(25, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(26, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(27, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReader(bstrReader, varReserved)
      => ComCall(28, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReader(bstrReader, varReserved)
      => ComCall(29, this.p, BSTR, bstrReader, VARIANT, varReserved)
    get_Scopes(ppScopeCollection)
      => ComCall(30, this.p, IAzScopes.Ptr, ppScopeCollection)
    OpenScope(bstrScopeName, varReserved, ppScope)
      => ComCall(31, this.p, BSTR, bstrScopeName, VARIANT, varReserved, IAzScope.Ptr, ppScope)
    CreateScope(bstrScopeName, varReserved, ppScope)
      => ComCall(32, this.p, BSTR, bstrScopeName, VARIANT, varReserved, IAzScope.Ptr, ppScope)
    DeleteScope(bstrScopeName, varReserved)
      => ComCall(33, this.p, BSTR, bstrScopeName, VARIANT, varReserved)
    get_Operations(ppOperationCollection)
      => ComCall(34, this.p, IAzOperations.Ptr, ppOperationCollection)
    OpenOperation(bstrOperationName, varReserved, ppOperation)
      => ComCall(35, this.p, BSTR, bstrOperationName, VARIANT, varReserved, IAzOperation.Ptr, ppOperation)
    CreateOperation(bstrOperationName, varReserved, ppOperation)
      => ComCall(36, this.p, BSTR, bstrOperationName, VARIANT, varReserved, IAzOperation.Ptr, ppOperation)
    DeleteOperation(bstrOperationName, varReserved)
      => ComCall(37, this.p, BSTR, bstrOperationName, VARIANT, varReserved)
    get_Tasks(ppTaskCollection)
      => ComCall(38, this.p, IAzTasks.Ptr, ppTaskCollection)
    OpenTask(bstrTaskName, varReserved, ppTask)
      => ComCall(39, this.p, BSTR, bstrTaskName, VARIANT, varReserved, IAzTask.Ptr, ppTask)
    CreateTask(bstrTaskName, varReserved, ppTask)
      => ComCall(40, this.p, BSTR, bstrTaskName, VARIANT, varReserved, IAzTask.Ptr, ppTask)
    DeleteTask(bstrTaskName, varReserved)
      => ComCall(41, this.p, BSTR, bstrTaskName, VARIANT, varReserved)
    get_ApplicationGroups(ppGroupCollection)
      => ComCall(42, this.p, IAzApplicationGroups.Ptr, ppGroupCollection)
    OpenApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(43, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    CreateApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(44, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    DeleteApplicationGroup(bstrGroupName, varReserved)
      => ComCall(45, this.p, BSTR, bstrGroupName, VARIANT, varReserved)
    get_Roles(ppRoleCollection)
      => ComCall(46, this.p, IAzRoles.Ptr, ppRoleCollection)
    OpenRole(bstrRoleName, varReserved, ppRole)
      => ComCall(47, this.p, BSTR, bstrRoleName, VARIANT, varReserved, IAzRole.Ptr, ppRole)
    CreateRole(bstrRoleName, varReserved, ppRole)
      => ComCall(48, this.p, BSTR, bstrRoleName, VARIANT, varReserved, IAzRole.Ptr, ppRole)
    DeleteRole(bstrRoleName, varReserved)
      => ComCall(49, this.p, BSTR, bstrRoleName, VARIANT, varReserved)
    InitializeClientContextFromToken(ullTokenHandle, varReserved, ppClientContext)
      => ComCall(50, this.p, Int64, ullTokenHandle, VARIANT, varReserved, IAzClientContext.Ptr, ppClientContext)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(51, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(52, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(53, this.p, Int32, lFlags, VARIANT, varReserved)
    InitializeClientContextFromName(ClientName, DomainName, varReserved, ppClientContext)
      => ComCall(54, this.p, BSTR, ClientName, BSTR, DomainName, VARIANT, varReserved, IAzClientContext.Ptr, ppClientContext)
    get_DelegatedPolicyUsers(pvarDelegatedPolicyUsers)
      => ComCall(55, this.p, VARIANT.Ptr, pvarDelegatedPolicyUsers)
    AddDelegatedPolicyUser(bstrDelegatedPolicyUser, varReserved)
      => ComCall(56, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    DeleteDelegatedPolicyUser(bstrDelegatedPolicyUser, varReserved)
      => ComCall(57, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    InitializeClientContextFromStringSid(SidString, lOptions, varReserved, ppClientContext)
      => ComCall(58, this.p, BSTR, SidString, Int32, lOptions, VARIANT, varReserved, IAzClientContext.Ptr, ppClientContext)
    get_PolicyAdministratorsName(pvarAdmins)
      => ComCall(59, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReadersName(pvarReaders)
      => ComCall(60, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(61, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(62, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReaderName(bstrReader, varReserved)
      => ComCall(63, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReaderName(bstrReader, varReserved)
      => ComCall(64, this.p, BSTR, bstrReader, VARIANT, varReserved)
    get_DelegatedPolicyUsersName(pvarDelegatedPolicyUsers)
      => ComCall(65, this.p, VARIANT.Ptr, pvarDelegatedPolicyUsers)
    AddDelegatedPolicyUserName(bstrDelegatedPolicyUser, varReserved)
      => ComCall(66, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
    DeleteDelegatedPolicyUserName(bstrDelegatedPolicyUser, varReserved)
      => ComCall(67, this.p, BSTR, bstrDelegatedPolicyUser, VARIANT, varReserved)
}
struct IAzApplication2 extends IAzApplication {
    static IID := "{086A68AF-A249-437C-B18D-D4D86D6A9660}"
    InitializeClientContextFromToken2(ulTokenHandleLowPart, ulTokenHandleHighPart, varReserved, ppClientContext)
      => ComCall(68, this.p, UInt32, ulTokenHandleLowPart, UInt32, ulTokenHandleHighPart, VARIANT, varReserved, IAzClientContext2.Ptr, ppClientContext)
    InitializeClientContext2(IdentifyingString, varReserved, ppClientContext)
      => ComCall(69, this.p, BSTR, IdentifyingString, VARIANT, varReserved, IAzClientContext2.Ptr, ppClientContext)
}
struct IAzApplications extends IDispatch {
    static IID := "{929B11A9-95C5-4A84-A29A-20AD42C2F16C}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzOperation extends IDispatch {
    static IID := "{5E56B24F-EA01-4D61-BE44-C49B5E4EAF74}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(10, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(12, this.p, BSTR, bstrApplicationData)
    get_OperationID(plProp)
      => ComCall(13, this.p, Int32.Ptr, plProp)
    put_OperationID(lProp)
      => ComCall(14, this.p, Int32, lProp)
    get_Writable(pfProp)
      => ComCall(15, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(16, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(17, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(18, this.p, Int32, lFlags, VARIANT, varReserved)
}
struct IAzOperations extends IDispatch {
    static IID := "{90EF9C07-9706-49D9-AF80-0438A5F3EC35}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzTask extends IDispatch {
    static IID := "{CB94E592-2E0E-4A6C-A336-B89A6DC1E388}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(10, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(12, this.p, BSTR, bstrApplicationData)
    get_BizRule(pbstrProp)
      => ComCall(13, this.p, BSTR.Ptr, pbstrProp)
    put_BizRule(bstrProp)
      => ComCall(14, this.p, BSTR, bstrProp)
    get_BizRuleLanguage(pbstrProp)
      => ComCall(15, this.p, BSTR.Ptr, pbstrProp)
    put_BizRuleLanguage(bstrProp)
      => ComCall(16, this.p, BSTR, bstrProp)
    get_BizRuleImportedPath(pbstrProp)
      => ComCall(17, this.p, BSTR.Ptr, pbstrProp)
    put_BizRuleImportedPath(bstrProp)
      => ComCall(18, this.p, BSTR, bstrProp)
    get_IsRoleDefinition(pfProp)
      => ComCall(19, this.p, BOOL.Ptr, pfProp)
    put_IsRoleDefinition(fProp)
      => ComCall(20, this.p, BOOL, fProp)
    get_Operations(pvarProp)
      => ComCall(21, this.p, VARIANT.Ptr, pvarProp)
    get_Tasks(pvarProp)
      => ComCall(22, this.p, VARIANT.Ptr, pvarProp)
    AddOperation(bstrOp, varReserved)
      => ComCall(23, this.p, BSTR, bstrOp, VARIANT, varReserved)
    DeleteOperation(bstrOp, varReserved)
      => ComCall(24, this.p, BSTR, bstrOp, VARIANT, varReserved)
    AddTask(bstrTask, varReserved)
      => ComCall(25, this.p, BSTR, bstrTask, VARIANT, varReserved)
    DeleteTask(bstrTask, varReserved)
      => ComCall(26, this.p, BSTR, bstrTask, VARIANT, varReserved)
    get_Writable(pfProp)
      => ComCall(27, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(28, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(29, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(30, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(31, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(32, this.p, Int32, lFlags, VARIANT, varReserved)
}
struct IAzTasks extends IDispatch {
    static IID := "{B338CCAB-4C85-4388-8C0A-C58592BAD398}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzScope extends IDispatch {
    static IID := "{00E52487-E08D-4514-B62E-877D5645F5AB}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(10, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(12, this.p, BSTR, bstrApplicationData)
    get_Writable(pfProp)
      => ComCall(13, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(14, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(15, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(16, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(17, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    get_PolicyAdministrators(pvarAdmins)
      => ComCall(18, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReaders(pvarReaders)
      => ComCall(19, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(20, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministrator(bstrAdmin, varReserved)
      => ComCall(21, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReader(bstrReader, varReserved)
      => ComCall(22, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReader(bstrReader, varReserved)
      => ComCall(23, this.p, BSTR, bstrReader, VARIANT, varReserved)
    get_ApplicationGroups(ppGroupCollection)
      => ComCall(24, this.p, IAzApplicationGroups.Ptr, ppGroupCollection)
    OpenApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(25, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    CreateApplicationGroup(bstrGroupName, varReserved, ppGroup)
      => ComCall(26, this.p, BSTR, bstrGroupName, VARIANT, varReserved, IAzApplicationGroup.Ptr, ppGroup)
    DeleteApplicationGroup(bstrGroupName, varReserved)
      => ComCall(27, this.p, BSTR, bstrGroupName, VARIANT, varReserved)
    get_Roles(ppRoleCollection)
      => ComCall(28, this.p, IAzRoles.Ptr, ppRoleCollection)
    OpenRole(bstrRoleName, varReserved, ppRole)
      => ComCall(29, this.p, BSTR, bstrRoleName, VARIANT, varReserved, IAzRole.Ptr, ppRole)
    CreateRole(bstrRoleName, varReserved, ppRole)
      => ComCall(30, this.p, BSTR, bstrRoleName, VARIANT, varReserved, IAzRole.Ptr, ppRole)
    DeleteRole(bstrRoleName, varReserved)
      => ComCall(31, this.p, BSTR, bstrRoleName, VARIANT, varReserved)
    get_Tasks(ppTaskCollection)
      => ComCall(32, this.p, IAzTasks.Ptr, ppTaskCollection)
    OpenTask(bstrTaskName, varReserved, ppTask)
      => ComCall(33, this.p, BSTR, bstrTaskName, VARIANT, varReserved, IAzTask.Ptr, ppTask)
    CreateTask(bstrTaskName, varReserved, ppTask)
      => ComCall(34, this.p, BSTR, bstrTaskName, VARIANT, varReserved, IAzTask.Ptr, ppTask)
    DeleteTask(bstrTaskName, varReserved)
      => ComCall(35, this.p, BSTR, bstrTaskName, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(36, this.p, Int32, lFlags, VARIANT, varReserved)
    get_CanBeDelegated(pfProp)
      => ComCall(37, this.p, BOOL.Ptr, pfProp)
    get_BizrulesWritable(pfProp)
      => ComCall(38, this.p, BOOL.Ptr, pfProp)
    get_PolicyAdministratorsName(pvarAdmins)
      => ComCall(39, this.p, VARIANT.Ptr, pvarAdmins)
    get_PolicyReadersName(pvarReaders)
      => ComCall(40, this.p, VARIANT.Ptr, pvarReaders)
    AddPolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(41, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    DeletePolicyAdministratorName(bstrAdmin, varReserved)
      => ComCall(42, this.p, BSTR, bstrAdmin, VARIANT, varReserved)
    AddPolicyReaderName(bstrReader, varReserved)
      => ComCall(43, this.p, BSTR, bstrReader, VARIANT, varReserved)
    DeletePolicyReaderName(bstrReader, varReserved)
      => ComCall(44, this.p, BSTR, bstrReader, VARIANT, varReserved)
}
struct IAzScopes extends IDispatch {
    static IID := "{78E14853-9F5E-406D-9B91-6BDBA6973510}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzApplicationGroup extends IDispatch {
    static IID := "{F1B744CD-58A6-4E06-9FBF-36F6D779E21E}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Type(plProp)
      => ComCall(9, this.p, Int32.Ptr, plProp)
    put_Type(lProp)
      => ComCall(10, this.p, Int32, lProp)
    get_LdapQuery(pbstrProp)
      => ComCall(11, this.p, BSTR.Ptr, pbstrProp)
    put_LdapQuery(bstrProp)
      => ComCall(12, this.p, BSTR, bstrProp)
    get_AppMembers(pvarProp)
      => ComCall(13, this.p, VARIANT.Ptr, pvarProp)
    get_AppNonMembers(pvarProp)
      => ComCall(14, this.p, VARIANT.Ptr, pvarProp)
    get_Members(pvarProp)
      => ComCall(15, this.p, VARIANT.Ptr, pvarProp)
    get_NonMembers(pvarProp)
      => ComCall(16, this.p, VARIANT.Ptr, pvarProp)
    get_Description(pbstrDescription)
      => ComCall(17, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(18, this.p, BSTR, bstrDescription)
    AddAppMember(bstrProp, varReserved)
      => ComCall(19, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteAppMember(bstrProp, varReserved)
      => ComCall(20, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddAppNonMember(bstrProp, varReserved)
      => ComCall(21, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteAppNonMember(bstrProp, varReserved)
      => ComCall(22, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddMember(bstrProp, varReserved)
      => ComCall(23, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteMember(bstrProp, varReserved)
      => ComCall(24, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddNonMember(bstrProp, varReserved)
      => ComCall(25, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteNonMember(bstrProp, varReserved)
      => ComCall(26, this.p, BSTR, bstrProp, VARIANT, varReserved)
    get_Writable(pfProp)
      => ComCall(27, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(28, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(29, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(30, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(31, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(32, this.p, Int32, lFlags, VARIANT, varReserved)
    AddMemberName(bstrProp, varReserved)
      => ComCall(33, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteMemberName(bstrProp, varReserved)
      => ComCall(34, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddNonMemberName(bstrProp, varReserved)
      => ComCall(35, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteNonMemberName(bstrProp, varReserved)
      => ComCall(36, this.p, BSTR, bstrProp, VARIANT, varReserved)
    get_MembersName(pvarProp)
      => ComCall(37, this.p, VARIANT.Ptr, pvarProp)
    get_NonMembersName(pvarProp)
      => ComCall(38, this.p, VARIANT.Ptr, pvarProp)
}
struct IAzApplicationGroups extends IDispatch {
    static IID := "{4CE66AD5-9F3C-469D-A911-B99887A7E685}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzRole extends IDispatch {
    static IID := "{859E0D8D-62D7-41D8-A034-C0CD5D43FDFA}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(8, this.p, BSTR, bstrName)
    get_Description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(10, this.p, BSTR, bstrDescription)
    get_ApplicationData(pbstrApplicationData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrApplicationData)
    put_ApplicationData(bstrApplicationData)
      => ComCall(12, this.p, BSTR, bstrApplicationData)
    AddAppMember(bstrProp, varReserved)
      => ComCall(13, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteAppMember(bstrProp, varReserved)
      => ComCall(14, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddTask(bstrProp, varReserved)
      => ComCall(15, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteTask(bstrProp, varReserved)
      => ComCall(16, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddOperation(bstrProp, varReserved)
      => ComCall(17, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteOperation(bstrProp, varReserved)
      => ComCall(18, this.p, BSTR, bstrProp, VARIANT, varReserved)
    AddMember(bstrProp, varReserved)
      => ComCall(19, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteMember(bstrProp, varReserved)
      => ComCall(20, this.p, BSTR, bstrProp, VARIANT, varReserved)
    get_Writable(pfProp)
      => ComCall(21, this.p, BOOL.Ptr, pfProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(22, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    SetProperty(lPropId, varProp, varReserved)
      => ComCall(23, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    get_AppMembers(pvarProp)
      => ComCall(24, this.p, VARIANT.Ptr, pvarProp)
    get_Members(pvarProp)
      => ComCall(25, this.p, VARIANT.Ptr, pvarProp)
    get_Operations(pvarProp)
      => ComCall(26, this.p, VARIANT.Ptr, pvarProp)
    get_Tasks(pvarProp)
      => ComCall(27, this.p, VARIANT.Ptr, pvarProp)
    AddPropertyItem(lPropId, varProp, varReserved)
      => ComCall(28, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    DeletePropertyItem(lPropId, varProp, varReserved)
      => ComCall(29, this.p, Int32, lPropId, VARIANT, varProp, VARIANT, varReserved)
    Submit(lFlags, varReserved)
      => ComCall(30, this.p, Int32, lFlags, VARIANT, varReserved)
    AddMemberName(bstrProp, varReserved)
      => ComCall(31, this.p, BSTR, bstrProp, VARIANT, varReserved)
    DeleteMemberName(bstrProp, varReserved)
      => ComCall(32, this.p, BSTR, bstrProp, VARIANT, varReserved)
    get_MembersName(pvarProp)
      => ComCall(33, this.p, VARIANT.Ptr, pvarProp)
}
struct IAzRoles extends IDispatch {
    static IID := "{95E0F119-13B4-4DAE-B65F-2F7D60D822E4}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzClientContext extends IDispatch {
    static IID := "{EFF1F00B-488A-466D-AFD9-A401C5F9EEF5}"
    AccessCheck(bstrObjectName, varScopeNames, varOperations, varParameterNames, varParameterValues, varInterfaceNames, varInterfaceFlags, varInterfaces, pvarResults)
      => ComCall(7, this.p, BSTR, bstrObjectName, VARIANT, varScopeNames, VARIANT, varOperations, VARIANT, varParameterNames, VARIANT, varParameterValues, VARIANT, varInterfaceNames, VARIANT, varInterfaceFlags, VARIANT, varInterfaces, VARIANT.Ptr, pvarResults)
    GetBusinessRuleString(pbstrBusinessRuleString)
      => ComCall(8, this.p, BSTR.Ptr, pbstrBusinessRuleString)
    get_UserDn(pbstrProp)
      => ComCall(9, this.p, BSTR.Ptr, pbstrProp)
    get_UserSamCompat(pbstrProp)
      => ComCall(10, this.p, BSTR.Ptr, pbstrProp)
    get_UserDisplay(pbstrProp)
      => ComCall(11, this.p, BSTR.Ptr, pbstrProp)
    get_UserGuid(pbstrProp)
      => ComCall(12, this.p, BSTR.Ptr, pbstrProp)
    get_UserCanonical(pbstrProp)
      => ComCall(13, this.p, BSTR.Ptr, pbstrProp)
    get_UserUpn(pbstrProp)
      => ComCall(14, this.p, BSTR.Ptr, pbstrProp)
    get_UserDnsSamCompat(pbstrProp)
      => ComCall(15, this.p, BSTR.Ptr, pbstrProp)
    GetProperty(lPropId, varReserved, pvarProp)
      => ComCall(16, this.p, Int32, lPropId, VARIANT, varReserved, VARIANT.Ptr, pvarProp)
    GetRoles(bstrScopeName, pvarRoleNames)
      => ComCall(17, this.p, BSTR, bstrScopeName, VARIANT.Ptr, pvarRoleNames)
    get_RoleForAccessCheck(pbstrProp)
      => ComCall(18, this.p, BSTR.Ptr, pbstrProp)
    put_RoleForAccessCheck(bstrProp)
      => ComCall(19, this.p, BSTR, bstrProp)
}
struct IAzClientContext2 extends IAzClientContext {
    static IID := "{2B0C92B8-208A-488A-8F81-E4EDB22111CD}"
    GetAssignedScopesPage(lOptions, PageSize, pvarCursor, pvarScopeNames)
      => ComCall(20, this.p, Int32, lOptions, Int32, PageSize, VARIANT.Ptr, pvarCursor, VARIANT.Ptr, pvarScopeNames)
    AddRoles(varRoles, bstrScopeName)
      => ComCall(21, this.p, VARIANT, varRoles, BSTR, bstrScopeName)
    AddApplicationGroups(varApplicationGroups)
      => ComCall(22, this.p, VARIANT, varApplicationGroups)
    AddStringSids(varStringSids)
      => ComCall(23, this.p, VARIANT, varStringSids)
    put_LDAPQueryDN(bstrLDAPQueryDN)
      => ComCall(24, this.p, BSTR, bstrLDAPQueryDN)
    get_LDAPQueryDN(pbstrLDAPQueryDN)
      => ComCall(25, this.p, BSTR.Ptr, pbstrLDAPQueryDN)
}
struct IAzBizRuleContext extends IDispatch {
    static IID := "{E192F17D-D59F-455E-A152-940316CD77B2}"
    put_BusinessRuleResult(bResult)
      => ComCall(7, this.p, BOOL, bResult)
    put_BusinessRuleString(bstrBusinessRuleString)
      => ComCall(8, this.p, BSTR, bstrBusinessRuleString)
    get_BusinessRuleString(pbstrBusinessRuleString)
      => ComCall(9, this.p, BSTR.Ptr, pbstrBusinessRuleString)
    GetParameter(bstrParameterName, pvarParameterValue)
      => ComCall(10, this.p, BSTR, bstrParameterName, VARIANT.Ptr, pvarParameterValue)
}
struct IAzBizRuleParameters extends IDispatch {
    static IID := "{FC17685F-E25D-4DCD-BAE1-276EC9533CB5}"
    AddParameter(bstrParameterName, varParameterValue)
      => ComCall(7, this.p, BSTR, bstrParameterName, VARIANT, varParameterValue)
    AddParameters(varParameterNames, varParameterValues)
      => ComCall(8, this.p, VARIANT, varParameterNames, VARIANT, varParameterValues)
    GetParameterValue(bstrParameterName, pvarParameterValue)
      => ComCall(9, this.p, BSTR, bstrParameterName, VARIANT.Ptr, pvarParameterValue)
    Remove(varParameterName)
      => ComCall(10, this.p, BSTR, varParameterName)
    RemoveAll()
      => ComCall(11, this.p)
    get_Count(plCount)
      => ComCall(12, this.p, UInt32.Ptr, plCount)
}
struct IAzBizRuleInterfaces extends IDispatch {
    static IID := "{E94128C7-E9DA-44CC-B0BD-53036F3AAB3D}"
    AddInterface(bstrInterfaceName, lInterfaceFlag, varInterface)
      => ComCall(7, this.p, BSTR, bstrInterfaceName, Int32, lInterfaceFlag, VARIANT, varInterface)
    AddInterfaces(varInterfaceNames, varInterfaceFlags, varInterfaces)
      => ComCall(8, this.p, VARIANT, varInterfaceNames, VARIANT, varInterfaceFlags, VARIANT, varInterfaces)
    GetInterfaceValue(bstrInterfaceName, lInterfaceFlag, varInterface)
      => ComCall(9, this.p, BSTR, bstrInterfaceName, Int32.Ptr, lInterfaceFlag, VARIANT.Ptr, varInterface)
    Remove(bstrInterfaceName)
      => ComCall(10, this.p, BSTR, bstrInterfaceName)
    RemoveAll()
      => ComCall(11, this.p)
    get_Count(plCount)
      => ComCall(12, this.p, UInt32.Ptr, plCount)
}
struct IAzClientContext3 extends IAzClientContext2 {
    static IID := "{11894FDE-1DEB-4B4B-8907-6D1CDA1F5D4F}"
    AccessCheck2(bstrObjectName, bstrScopeName, lOperation, plResult)
      => ComCall(26, this.p, BSTR, bstrObjectName, BSTR, bstrScopeName, Int32, lOperation, UInt32.Ptr, plResult)
    IsInRoleAssignment(bstrScopeName, bstrRoleName, pbIsInRole)
      => ComCall(27, this.p, BSTR, bstrScopeName, BSTR, bstrRoleName, VARIANT_BOOL.Ptr, pbIsInRole)
    GetOperations(bstrScopeName, ppOperationCollection)
      => ComCall(28, this.p, BSTR, bstrScopeName, IAzOperations.Ptr, ppOperationCollection)
    GetTasks(bstrScopeName, ppTaskCollection)
      => ComCall(29, this.p, BSTR, bstrScopeName, IAzTasks.Ptr, ppTaskCollection)
    get_BizRuleParameters(ppBizRuleParam)
      => ComCall(30, this.p, IAzBizRuleParameters.Ptr, ppBizRuleParam)
    get_BizRuleInterfaces(ppBizRuleInterfaces)
      => ComCall(31, this.p, IAzBizRuleInterfaces.Ptr, ppBizRuleInterfaces)
    GetGroups(bstrScopeName, ulOptions, pGroupArray)
      => ComCall(32, this.p, BSTR, bstrScopeName, UInt32, ulOptions, VARIANT.Ptr, pGroupArray)
    get_Sids(pStringSidArray)
      => ComCall(33, this.p, VARIANT.Ptr, pStringSidArray)
}
struct IAzScope2 extends IAzScope {
    static IID := "{EE9FE8C9-C9F3-40E2-AA12-D1D8599727FD}"
    get_RoleDefinitions(ppRoleDefinitions)
      => ComCall(45, this.p, IAzRoleDefinitions.Ptr, ppRoleDefinitions)
    CreateRoleDefinition(bstrRoleDefinitionName, ppRoleDefinitions)
      => ComCall(46, this.p, BSTR, bstrRoleDefinitionName, IAzRoleDefinition.Ptr, ppRoleDefinitions)
    OpenRoleDefinition(bstrRoleDefinitionName, ppRoleDefinitions)
      => ComCall(47, this.p, BSTR, bstrRoleDefinitionName, IAzRoleDefinition.Ptr, ppRoleDefinitions)
    DeleteRoleDefinition(bstrRoleDefinitionName)
      => ComCall(48, this.p, BSTR, bstrRoleDefinitionName)
    get_RoleAssignments(ppRoleAssignments)
      => ComCall(49, this.p, IAzRoleAssignments.Ptr, ppRoleAssignments)
    CreateRoleAssignment(bstrRoleAssignmentName, ppRoleAssignment)
      => ComCall(50, this.p, BSTR, bstrRoleAssignmentName, IAzRoleAssignment.Ptr, ppRoleAssignment)
    OpenRoleAssignment(bstrRoleAssignmentName, ppRoleAssignment)
      => ComCall(51, this.p, BSTR, bstrRoleAssignmentName, IAzRoleAssignment.Ptr, ppRoleAssignment)
    DeleteRoleAssignment(bstrRoleAssignmentName)
      => ComCall(52, this.p, BSTR, bstrRoleAssignmentName)
}
struct IAzApplication3 extends IAzApplication2 {
    static IID := "{181C845E-7196-4A7D-AC2E-020C0BB7A303}"
    ScopeExists(bstrScopeName, pbExist)
      => ComCall(70, this.p, BSTR, bstrScopeName, VARIANT_BOOL.Ptr, pbExist)
    OpenScope2(bstrScopeName, ppScope2)
      => ComCall(71, this.p, BSTR, bstrScopeName, IAzScope2.Ptr, ppScope2)
    CreateScope2(bstrScopeName, ppScope2)
      => ComCall(72, this.p, BSTR, bstrScopeName, IAzScope2.Ptr, ppScope2)
    DeleteScope2(bstrScopeName)
      => ComCall(73, this.p, BSTR, bstrScopeName)
    get_RoleDefinitions(ppRoleDefinitions)
      => ComCall(74, this.p, IAzRoleDefinitions.Ptr, ppRoleDefinitions)
    CreateRoleDefinition(bstrRoleDefinitionName, ppRoleDefinitions)
      => ComCall(75, this.p, BSTR, bstrRoleDefinitionName, IAzRoleDefinition.Ptr, ppRoleDefinitions)
    OpenRoleDefinition(bstrRoleDefinitionName, ppRoleDefinitions)
      => ComCall(76, this.p, BSTR, bstrRoleDefinitionName, IAzRoleDefinition.Ptr, ppRoleDefinitions)
    DeleteRoleDefinition(bstrRoleDefinitionName)
      => ComCall(77, this.p, BSTR, bstrRoleDefinitionName)
    get_RoleAssignments(ppRoleAssignments)
      => ComCall(78, this.p, IAzRoleAssignments.Ptr, ppRoleAssignments)
    CreateRoleAssignment(bstrRoleAssignmentName, ppRoleAssignment)
      => ComCall(79, this.p, BSTR, bstrRoleAssignmentName, IAzRoleAssignment.Ptr, ppRoleAssignment)
    OpenRoleAssignment(bstrRoleAssignmentName, ppRoleAssignment)
      => ComCall(80, this.p, BSTR, bstrRoleAssignmentName, IAzRoleAssignment.Ptr, ppRoleAssignment)
    DeleteRoleAssignment(bstrRoleAssignmentName)
      => ComCall(81, this.p, BSTR, bstrRoleAssignmentName)
    get_BizRulesEnabled(pbEnabled)
      => ComCall(82, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_BizRulesEnabled(bEnabled)
      => ComCall(83, this.p, VARIANT_BOOL, bEnabled)
}
struct IAzOperation2 extends IAzOperation {
    static IID := "{1F5EA01F-44A2-4184-9C48-A75B4DCC8CCC}"
    RoleAssignments(bstrScopeName, bRecursive, ppRoleAssignments)
      => ComCall(19, this.p, BSTR, bstrScopeName, VARIANT_BOOL, bRecursive, IAzRoleAssignments.Ptr, ppRoleAssignments)
}
struct IAzRoleDefinitions extends IDispatch {
    static IID := "{881F25A5-D755-4550-957A-D503A3B34001}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzRoleDefinition extends IAzTask {
    static IID := "{D97FCEA1-2599-44F1-9FC3-58E9FBE09466}"
    RoleAssignments(bstrScopeName, bRecursive, ppRoleAssignments)
      => ComCall(33, this.p, BSTR, bstrScopeName, VARIANT_BOOL, bRecursive, IAzRoleAssignments.Ptr, ppRoleAssignments)
    AddRoleDefinition(bstrRoleDefinition)
      => ComCall(34, this.p, BSTR, bstrRoleDefinition)
    DeleteRoleDefinition(bstrRoleDefinition)
      => ComCall(35, this.p, BSTR, bstrRoleDefinition)
    get_RoleDefinitions(ppRoleDefinitions)
      => ComCall(36, this.p, IAzRoleDefinitions.Ptr, ppRoleDefinitions)
}
struct IAzRoleAssignment extends IAzRole {
    static IID := "{55647D31-0D5A-4FA3-B4AC-2B5F9AD5AB76}"
    AddRoleDefinition(bstrRoleDefinition)
      => ComCall(34, this.p, BSTR, bstrRoleDefinition)
    DeleteRoleDefinition(bstrRoleDefinition)
      => ComCall(35, this.p, BSTR, bstrRoleDefinition)
    get_RoleDefinitions(ppRoleDefinitions)
      => ComCall(36, this.p, IAzRoleDefinitions.Ptr, ppRoleDefinitions)
    get_Scope(ppScope)
      => ComCall(37, this.p, IAzScope.Ptr, ppScope)
}
struct IAzRoleAssignments extends IDispatch {
    static IID := "{9C80B900-FCEB-4D73-A0F4-C83B0BBF2481}"
    get_Item(Index, pvarObtPtr)
      => ComCall(7, this.p, Int32, Index, VARIANT.Ptr, pvarObtPtr)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumPtr)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumPtr)
}
struct IAzPrincipalLocator extends IDispatch {
    static IID := "{E5C3507D-AD6A-4992-9C7F-74AB480B44CC}"
    get_NameResolver(ppNameResolver)
      => ComCall(7, this.p, IAzNameResolver.Ptr, ppNameResolver)
    get_ObjectPicker(ppObjectPicker)
      => ComCall(8, this.p, IAzObjectPicker.Ptr, ppObjectPicker)
}
struct IAzNameResolver extends IDispatch {
    static IID := "{504D0F15-73E2-43DF-A870-A64F40714F53}"
    NameFromSid(bstrSid, pSidType, pbstrName)
      => ComCall(7, this.p, BSTR, bstrSid, Int32.Ptr, pSidType, BSTR.Ptr, pbstrName)
    NamesFromSids(vSids, pvSidTypes, pvNames)
      => ComCall(8, this.p, VARIANT, vSids, VARIANT.Ptr, pvSidTypes, VARIANT.Ptr, pvNames)
}
struct IAzObjectPicker extends IDispatch {
    static IID := "{63130A48-699A-42D8-BF01-C62AC3FB79F9}"
    GetPrincipals(hParentWnd, bstrTitle, pvSidTypes, pvNames, pvSids)
      => ComCall(7, this.p, HWND, hParentWnd, BSTR, bstrTitle, VARIANT.Ptr, pvSidTypes, VARIANT.Ptr, pvNames, VARIANT.Ptr, pvSids)
    get_Name(pbstrName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrName)
}
struct IAzApplicationGroup2 extends IAzApplicationGroup {
    static IID := "{3F0613FC-B71A-464E-A11D-5B881A56CEFA}"
    get_BizRule(pbstrProp)
      => ComCall(39, this.p, BSTR.Ptr, pbstrProp)
    put_BizRule(bstrProp)
      => ComCall(40, this.p, BSTR, bstrProp)
    get_BizRuleLanguage(pbstrProp)
      => ComCall(41, this.p, BSTR.Ptr, pbstrProp)
    put_BizRuleLanguage(bstrProp)
      => ComCall(42, this.p, BSTR, bstrProp)
    get_BizRuleImportedPath(pbstrProp)
      => ComCall(43, this.p, BSTR.Ptr, pbstrProp)
    put_BizRuleImportedPath(bstrProp)
      => ComCall(44, this.p, BSTR, bstrProp)
    RoleAssignments(bstrScopeName, bRecursive, ppRoleAssignments)
      => ComCall(45, this.p, BSTR, bstrScopeName, VARIANT_BOOL, bRecursive, IAzRoleAssignments.Ptr, ppRoleAssignments)
}
struct IAzTask2 extends IAzTask {
    static IID := "{03A9A5EE-48C8-4832-9025-AAD503C46526}"
    RoleAssignments(bstrScopeName, bRecursive, ppRoleAssignments)
      => ComCall(33, this.p, BSTR, bstrScopeName, VARIANT_BOOL, bRecursive, IAzRoleAssignments.Ptr, ppRoleAssignments)
}
struct AZ_PROP_CONSTANTS extends Int32 {
    static AZ_PROP_NAME := 1
    static AZ_PROP_DESCRIPTION := 2
    static AZ_PROP_WRITABLE := 3
    static AZ_PROP_APPLICATION_DATA := 4
    static AZ_PROP_CHILD_CREATE := 5
    static AZ_MAX_APPLICATION_NAME_LENGTH := 512
    static AZ_MAX_OPERATION_NAME_LENGTH := 64
    static AZ_MAX_TASK_NAME_LENGTH := 64
    static AZ_MAX_SCOPE_NAME_LENGTH := 65536
    static AZ_MAX_GROUP_NAME_LENGTH := 64
    static AZ_MAX_ROLE_NAME_LENGTH := 64
    static AZ_MAX_NAME_LENGTH := 65536
    static AZ_MAX_DESCRIPTION_LENGTH := 1024
    static AZ_MAX_APPLICATION_DATA_LENGTH := 4096
    static AZ_SUBMIT_FLAG_ABORT := 1
    static AZ_SUBMIT_FLAG_FLUSH := 2
    static AZ_MAX_POLICY_URL_LENGTH := 65536
    static AZ_AZSTORE_FLAG_CREATE := 1
    static AZ_AZSTORE_FLAG_MANAGE_STORE_ONLY := 2
    static AZ_AZSTORE_FLAG_BATCH_UPDATE := 4
    static AZ_AZSTORE_FLAG_AUDIT_IS_CRITICAL := 8
    static AZ_AZSTORE_FORCE_APPLICATION_CLOSE := 16
    static AZ_AZSTORE_NT6_FUNCTION_LEVEL := 32
    static AZ_AZSTORE_FLAG_MANAGE_ONLY_PASSIVE_SUBMIT := 32768
    static AZ_PROP_AZSTORE_DOMAIN_TIMEOUT := 100
    static AZ_AZSTORE_DEFAULT_DOMAIN_TIMEOUT := 15000
    static AZ_PROP_AZSTORE_SCRIPT_ENGINE_TIMEOUT := 101
    static AZ_AZSTORE_MIN_DOMAIN_TIMEOUT := 500
    static AZ_AZSTORE_MIN_SCRIPT_ENGINE_TIMEOUT := 5000
    static AZ_AZSTORE_DEFAULT_SCRIPT_ENGINE_TIMEOUT := 45000
    static AZ_PROP_AZSTORE_MAX_SCRIPT_ENGINES := 102
    static AZ_AZSTORE_DEFAULT_MAX_SCRIPT_ENGINES := 120
    static AZ_PROP_AZSTORE_MAJOR_VERSION := 103
    static AZ_PROP_AZSTORE_MINOR_VERSION := 104
    static AZ_PROP_AZSTORE_TARGET_MACHINE := 105
    static AZ_PROP_AZTORE_IS_ADAM_INSTANCE := 106
    static AZ_PROP_OPERATION_ID := 200
    static AZ_PROP_TASK_OPERATIONS := 300
    static AZ_PROP_TASK_BIZRULE := 301
    static AZ_PROP_TASK_BIZRULE_LANGUAGE := 302
    static AZ_PROP_TASK_TASKS := 303
    static AZ_PROP_TASK_BIZRULE_IMPORTED_PATH := 304
    static AZ_PROP_TASK_IS_ROLE_DEFINITION := 305
    static AZ_MAX_TASK_BIZRULE_LENGTH := 65536
    static AZ_MAX_TASK_BIZRULE_LANGUAGE_LENGTH := 64
    static AZ_MAX_TASK_BIZRULE_IMPORTED_PATH_LENGTH := 512
    static AZ_MAX_BIZRULE_STRING := 65536
    static AZ_PROP_GROUP_TYPE := 400
    static AZ_GROUPTYPE_LDAP_QUERY := 1
    static AZ_GROUPTYPE_BASIC := 2
    static AZ_GROUPTYPE_BIZRULE := 3
    static AZ_PROP_GROUP_APP_MEMBERS := 401
    static AZ_PROP_GROUP_APP_NON_MEMBERS := 402
    static AZ_PROP_GROUP_LDAP_QUERY := 403
    static AZ_MAX_GROUP_LDAP_QUERY_LENGTH := 4096
    static AZ_PROP_GROUP_MEMBERS := 404
    static AZ_PROP_GROUP_NON_MEMBERS := 405
    static AZ_PROP_GROUP_MEMBERS_NAME := 406
    static AZ_PROP_GROUP_NON_MEMBERS_NAME := 407
    static AZ_PROP_GROUP_BIZRULE := 408
    static AZ_PROP_GROUP_BIZRULE_LANGUAGE := 409
    static AZ_PROP_GROUP_BIZRULE_IMPORTED_PATH := 410
    static AZ_MAX_GROUP_BIZRULE_LENGTH := 65536
    static AZ_MAX_GROUP_BIZRULE_LANGUAGE_LENGTH := 64
    static AZ_MAX_GROUP_BIZRULE_IMPORTED_PATH_LENGTH := 512
    static AZ_PROP_ROLE_APP_MEMBERS := 500
    static AZ_PROP_ROLE_MEMBERS := 501
    static AZ_PROP_ROLE_OPERATIONS := 502
    static AZ_PROP_ROLE_TASKS := 504
    static AZ_PROP_ROLE_MEMBERS_NAME := 505
    static AZ_PROP_SCOPE_BIZRULES_WRITABLE := 600
    static AZ_PROP_SCOPE_CAN_BE_DELEGATED := 601
    static AZ_PROP_CLIENT_CONTEXT_USER_DN := 700
    static AZ_PROP_CLIENT_CONTEXT_USER_SAM_COMPAT := 701
    static AZ_PROP_CLIENT_CONTEXT_USER_DISPLAY := 702
    static AZ_PROP_CLIENT_CONTEXT_USER_GUID := 703
    static AZ_PROP_CLIENT_CONTEXT_USER_CANONICAL := 704
    static AZ_PROP_CLIENT_CONTEXT_USER_UPN := 705
    static AZ_PROP_CLIENT_CONTEXT_USER_DNS_SAM_COMPAT := 707
    static AZ_PROP_CLIENT_CONTEXT_ROLE_FOR_ACCESS_CHECK := 708
    static AZ_PROP_CLIENT_CONTEXT_LDAP_QUERY_DN := 709
    static AZ_PROP_APPLICATION_AUTHZ_INTERFACE_CLSID := 800
    static AZ_PROP_APPLICATION_VERSION := 801
    static AZ_MAX_APPLICATION_VERSION_LENGTH := 512
    static AZ_PROP_APPLICATION_NAME := 802
    static AZ_PROP_APPLICATION_BIZRULE_ENABLED := 803
    static AZ_PROP_APPLY_STORE_SACL := 900
    static AZ_PROP_GENERATE_AUDITS := 901
    static AZ_PROP_POLICY_ADMINS := 902
    static AZ_PROP_POLICY_READERS := 903
    static AZ_PROP_DELEGATED_POLICY_USERS := 904
    static AZ_PROP_POLICY_ADMINS_NAME := 905
    static AZ_PROP_POLICY_READERS_NAME := 906
    static AZ_PROP_DELEGATED_POLICY_USERS_NAME := 907
    static AZ_CLIENT_CONTEXT_SKIP_GROUP := 1
    static AZ_CLIENT_CONTEXT_SKIP_LDAP_QUERY := 1
    static AZ_CLIENT_CONTEXT_GET_GROUP_RECURSIVE := 2
    static AZ_CLIENT_CONTEXT_GET_GROUPS_STORE_LEVEL_ONLY := 2
}
struct FN_PROGRESS extends FunctionPointer {
    static Types := [PWSTR, UInt32, PROG_INVOKE_SETTING.Ptr, Struct.Ptr, BOOL, "Void"]
}
struct AUTHZ_ACCESS_CHECK_RESULTS_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_CLIENT_CONTEXT_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_RESOURCE_MANAGER_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_AUDIT_EVENT_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_AUDIT_EVENT_TYPE_HANDLE {
    Value : Struct.Ptr
}
struct AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE {
    Value : Struct.Ptr
}
