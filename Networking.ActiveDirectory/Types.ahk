#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HANDLE, HINSTANCE, HRESULT, HWND, LPARAM, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL, WPARAM}
#Import "..\Security\Types.ahk" {PSID}
#Import "..\System.Com\Types.ahk" {DISPPARAMS, EXCEPINFO, IDataObject, IDispatch, IPersist, ITypeInfo, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {LPFNSVADDPROPSHEETPAGE}
#Import "..\UI.Shell\Types.ahk" {BFFCALLBACK}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {DLGPROC, HICON}

struct CQFORM {
    cbStruct : UInt32
    dwFlags : UInt32
    clsid : GUID
    hIcon : HICON
    pszTitle : PWSTR
}
struct LPCQADDFORMSPROC extends FunctionPointer {
    static Types := [LPARAM, CQFORM.Ptr, HRESULT]
}
struct LPCQADDPAGESPROC extends FunctionPointer {
    static Types := [LPARAM, GUID.Ptr, CQPAGE.Ptr, HRESULT]
}
struct LPCQPAGEPROC extends FunctionPointer {
    static Types := [CQPAGE.Ptr, HWND, UInt32, WPARAM, LPARAM, HRESULT]
}
struct CQPAGE {
    cbStruct : UInt32
    dwFlags : UInt32
    pPageProc : LPCQPAGEPROC
    hInstance : HINSTANCE
    idPageName : Int32
    idPageTemplate : Int32
    pDlgProc : DLGPROC
    lParam : LPARAM
}
struct IQueryForm extends IUnknown {
    static IID := "{8CFCEE30-39BD-11D0-B8D1-00A024AB2DBB}"
    Initialize(hkForm)
      => ComCall(3, this.p, HKEY, hkForm)
    AddForms(pAddFormsProc, lParam1)
      => ComCall(4, this.p, LPCQADDFORMSPROC, pAddFormsProc, LPARAM, lParam1)
    AddPages(pAddPagesProc, lParam1)
      => ComCall(5, this.p, LPCQADDPAGESPROC, pAddPagesProc, LPARAM, lParam1)
}
struct IPersistQuery extends IPersist {
    static IID := "{1A3114B8-A62E-11D0-A6C5-00A0C906AF45}"
    WriteString(pSection, pValueName, pValue)
      => ComCall(4, this.p, "Str", pSection, "Str", pValueName, "Str", pValue)
    ReadString(pSection, pValueName, pBuffer, cchBuffer)
      => ComCall(5, this.p, "Str", pSection, "Str", pValueName, PWSTR, pBuffer, Int32, cchBuffer)
    WriteInt(pSection, pValueName, value)
      => ComCall(6, this.p, "Str", pSection, "Str", pValueName, Int32, value)
    ReadInt(pSection, pValueName, pValue)
      => ComCall(7, this.p, "Str", pSection, "Str", pValueName, Int32.Ptr, pValue)
    WriteStruct(pSection, pValueName, pStruct, cbStruct)
      => ComCall(8, this.p, "Str", pSection, "Str", pValueName, Struct.Ptr, pStruct, UInt32, cbStruct)
    ReadStruct(pSection, pValueName, pStruct, cbStruct)
      => ComCall(9, this.p, "Str", pSection, "Str", pValueName, Struct.Ptr, pStruct, UInt32, cbStruct)
    Clear()
      => ComCall(10, this.p)
}
struct OPENQUERYWINDOW {
    cbStruct : UInt32
    dwFlags : UInt32
    clsidHandler : GUID
    pHandlerParameters : Struct.Ptr
    clsidDefaultForm : GUID
    pPersistQuery : IPersistQuery
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pFormParameters : Struct.Ptr
            ppbFormParameters : IPropertyBag
        }
    }
}
struct ICommonQuery extends IUnknown {
    static IID := "{AB50DEC0-6F1D-11D0-A1C4-00AA00C16E65}"
    OpenQueryWindow(hwndParent, pQueryWnd, ppDataObject)
      => ComCall(3, this.p, HWND, hwndParent, OPENQUERYWINDOW.Ptr, pQueryWnd, IDataObject.Ptr, ppDataObject)
}
struct ADSTYPE extends Int32 {
    static ADSTYPE_INVALID := 0
    static ADSTYPE_DN_STRING := 1
    static ADSTYPE_CASE_EXACT_STRING := 2
    static ADSTYPE_CASE_IGNORE_STRING := 3
    static ADSTYPE_PRINTABLE_STRING := 4
    static ADSTYPE_NUMERIC_STRING := 5
    static ADSTYPE_BOOLEAN := 6
    static ADSTYPE_INTEGER := 7
    static ADSTYPE_OCTET_STRING := 8
    static ADSTYPE_UTC_TIME := 9
    static ADSTYPE_LARGE_INTEGER := 10
    static ADSTYPE_PROV_SPECIFIC := 11
    static ADSTYPE_OBJECT_CLASS := 12
    static ADSTYPE_CASEIGNORE_LIST := 13
    static ADSTYPE_OCTET_LIST := 14
    static ADSTYPE_PATH := 15
    static ADSTYPE_POSTALADDRESS := 16
    static ADSTYPE_TIMESTAMP := 17
    static ADSTYPE_BACKLINK := 18
    static ADSTYPE_TYPEDNAME := 19
    static ADSTYPE_HOLD := 20
    static ADSTYPE_NETADDRESS := 21
    static ADSTYPE_REPLICAPOINTER := 22
    static ADSTYPE_FAXNUMBER := 23
    static ADSTYPE_EMAIL := 24
    static ADSTYPE_NT_SECURITY_DESCRIPTOR := 25
    static ADSTYPE_UNKNOWN := 26
    static ADSTYPE_DN_WITH_BINARY := 27
    static ADSTYPE_DN_WITH_STRING := 28
}
struct ADS_OCTET_STRING {
    dwLength : UInt32
    lpValue : UInt8.Ptr
}
struct ADS_NT_SECURITY_DESCRIPTOR {
    dwLength : UInt32
    lpValue : UInt8.Ptr
}
struct ADS_PROV_SPECIFIC {
    dwLength : UInt32
    lpValue : UInt8.Ptr
}
struct ADS_CASEIGNORE_LIST {
    Next : ADS_CASEIGNORE_LIST.Ptr
    String : PWSTR
}
struct ADS_OCTET_LIST {
    Next : ADS_OCTET_LIST.Ptr
    Length : UInt32
    Data : UInt8.Ptr
}
struct ADS_PATH {
    Type : UInt32
    VolumeName : PWSTR
    Path : PWSTR
}
struct ADS_POSTALADDRESS {
    PostalAddress : PWSTR[6]
}
struct ADS_TIMESTAMP {
    WholeSeconds : UInt32
    EventID : UInt32
}
struct ADS_BACKLINK {
    RemoteID : UInt32
    ObjectName : PWSTR
}
struct ADS_TYPEDNAME {
    ObjectName : PWSTR
    Level : UInt32
    Interval : UInt32
}
struct ADS_HOLD {
    ObjectName : PWSTR
    Amount : UInt32
}
struct ADS_NETADDRESS {
    AddressType : UInt32
    AddressLength : UInt32
    Address : UInt8.Ptr
}
struct ADS_REPLICAPOINTER {
    ServerName : PWSTR
    ReplicaType : UInt32
    ReplicaNumber : UInt32
    Count : UInt32
    ReplicaAddressHints : ADS_NETADDRESS.Ptr
}
struct ADS_FAXNUMBER {
    TelephoneNumber : PWSTR
    NumberOfBits : UInt32
    Parameters : UInt8.Ptr
}
struct ADS_EMAIL {
    Address : PWSTR
    Type : UInt32
}
struct ADS_DN_WITH_BINARY {
    dwLength : UInt32
    lpBinaryValue : UInt8.Ptr
    pszDNString : PWSTR
}
struct ADS_DN_WITH_STRING {
    pszStringValue : PWSTR
    pszDNString : PWSTR
}
struct ADSVALUE {
    dwType : ADSTYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            DNString : UInt16.Ptr
            CaseExactString : UInt16.Ptr
            CaseIgnoreString : UInt16.Ptr
            PrintableString : UInt16.Ptr
            NumericString : UInt16.Ptr
            Boolean : UInt32
            Integer : UInt32
            OctetString : ADS_OCTET_STRING
            UTCTime : SYSTEMTIME
            LargeInteger : Int64
            ClassName : UInt16.Ptr
            ProviderSpecific : ADS_PROV_SPECIFIC
            pCaseIgnoreList : ADS_CASEIGNORE_LIST.Ptr
            pOctetList : ADS_OCTET_LIST.Ptr
            pPath : ADS_PATH.Ptr
            pPostalAddress : ADS_POSTALADDRESS.Ptr
            Timestamp : ADS_TIMESTAMP
            BackLink : ADS_BACKLINK
            pTypedName : ADS_TYPEDNAME.Ptr
            Hold : ADS_HOLD
            pNetAddress : ADS_NETADDRESS.Ptr
            pReplicaPointer : ADS_REPLICAPOINTER.Ptr
            pFaxNumber : ADS_FAXNUMBER.Ptr
            Email : ADS_EMAIL
            SecurityDescriptor : ADS_NT_SECURITY_DESCRIPTOR
            pDNWithBinary : ADS_DN_WITH_BINARY.Ptr
            pDNWithString : ADS_DN_WITH_STRING.Ptr
        }
    }
}
struct ADS_ATTR_INFO {
    pszAttrName : PWSTR
    dwControlCode : UInt32
    dwADsType : ADSTYPE
    pADsValues : ADSVALUE.Ptr
    dwNumValues : UInt32
}
struct ADS_AUTHENTICATION_ENUM extends UInt32 {
    static ADS_SECURE_AUTHENTICATION := 1
    static ADS_USE_ENCRYPTION := 2
    static ADS_USE_SSL := 2
    static ADS_READONLY_SERVER := 4
    static ADS_PROMPT_CREDENTIALS := 8
    static ADS_NO_AUTHENTICATION := 16
    static ADS_FAST_BIND := 32
    static ADS_USE_SIGNING := 64
    static ADS_USE_SEALING := 128
    static ADS_USE_DELEGATION := 256
    static ADS_SERVER_BIND := 512
    static ADS_NO_REFERRAL_CHASING := 1024
    static ADS_AUTH_RESERVED := 2147483648
}
struct ADS_OBJECT_INFO {
    pszRDN : PWSTR
    pszObjectDN : PWSTR
    pszParentDN : PWSTR
    pszSchemaDN : PWSTR
    pszClassName : PWSTR
}
struct ADS_STATUSENUM extends Int32 {
    static ADS_STATUS_S_OK := 0
    static ADS_STATUS_INVALID_SEARCHPREF := 1
    static ADS_STATUS_INVALID_SEARCHPREFVALUE := 2
}
struct ADS_DEREFENUM extends Int32 {
    static ADS_DEREF_NEVER := 0
    static ADS_DEREF_SEARCHING := 1
    static ADS_DEREF_FINDING := 2
    static ADS_DEREF_ALWAYS := 3
}
struct ADS_SCOPEENUM extends Int32 {
    static ADS_SCOPE_BASE := 0
    static ADS_SCOPE_ONELEVEL := 1
    static ADS_SCOPE_SUBTREE := 2
}
struct ADS_PREFERENCES_ENUM extends Int32 {
    static ADSIPROP_ASYNCHRONOUS := 0
    static ADSIPROP_DEREF_ALIASES := 1
    static ADSIPROP_SIZE_LIMIT := 2
    static ADSIPROP_TIME_LIMIT := 3
    static ADSIPROP_ATTRIBTYPES_ONLY := 4
    static ADSIPROP_SEARCH_SCOPE := 5
    static ADSIPROP_TIMEOUT := 6
    static ADSIPROP_PAGESIZE := 7
    static ADSIPROP_PAGED_TIME_LIMIT := 8
    static ADSIPROP_CHASE_REFERRALS := 9
    static ADSIPROP_SORT_ON := 10
    static ADSIPROP_CACHE_RESULTS := 11
    static ADSIPROP_ADSIFLAG := 12
}
struct ADSI_DIALECT_ENUM extends Int32 {
    static ADSI_DIALECT_LDAP := 0
    static ADSI_DIALECT_SQL := 1
}
struct ADS_CHASE_REFERRALS_ENUM extends Int32 {
    static ADS_CHASE_REFERRALS_NEVER := 0
    static ADS_CHASE_REFERRALS_SUBORDINATE := 32
    static ADS_CHASE_REFERRALS_EXTERNAL := 64
    static ADS_CHASE_REFERRALS_ALWAYS := 96
}
struct ADS_SEARCHPREF_ENUM extends Int32 {
    static ADS_SEARCHPREF_ASYNCHRONOUS := 0
    static ADS_SEARCHPREF_DEREF_ALIASES := 1
    static ADS_SEARCHPREF_SIZE_LIMIT := 2
    static ADS_SEARCHPREF_TIME_LIMIT := 3
    static ADS_SEARCHPREF_ATTRIBTYPES_ONLY := 4
    static ADS_SEARCHPREF_SEARCH_SCOPE := 5
    static ADS_SEARCHPREF_TIMEOUT := 6
    static ADS_SEARCHPREF_PAGESIZE := 7
    static ADS_SEARCHPREF_PAGED_TIME_LIMIT := 8
    static ADS_SEARCHPREF_CHASE_REFERRALS := 9
    static ADS_SEARCHPREF_SORT_ON := 10
    static ADS_SEARCHPREF_CACHE_RESULTS := 11
    static ADS_SEARCHPREF_DIRSYNC := 12
    static ADS_SEARCHPREF_TOMBSTONE := 13
    static ADS_SEARCHPREF_VLV := 14
    static ADS_SEARCHPREF_ATTRIBUTE_QUERY := 15
    static ADS_SEARCHPREF_SECURITY_MASK := 16
    static ADS_SEARCHPREF_DIRSYNC_FLAG := 17
    static ADS_SEARCHPREF_EXTENDED_DN := 18
}
struct ADS_PASSWORD_ENCODING_ENUM extends Int32 {
    static ADS_PASSWORD_ENCODE_REQUIRE_SSL := 0
    static ADS_PASSWORD_ENCODE_CLEAR := 1
}
struct ADS_SEARCHPREF_INFO {
    dwSearchPref : ADS_SEARCHPREF_ENUM
    vValue : ADSVALUE
    dwStatus : ADS_STATUSENUM
}
struct ADS_SEARCH_COLUMN {
    pszAttrName : PWSTR
    dwADsType : ADSTYPE
    pADsValues : ADSVALUE.Ptr
    dwNumValues : UInt32
    hReserved : HANDLE
}
struct ADS_ATTR_DEF {
    pszAttrName : PWSTR
    dwADsType : ADSTYPE
    dwMinRange : UInt32
    dwMaxRange : UInt32
    fMultiValued : BOOL
}
struct ADS_CLASS_DEF {
    pszClassName : PWSTR
    dwMandatoryAttrs : UInt32
    ppszMandatoryAttrs : PWSTR.Ptr
    optionalAttrs : UInt32
    ppszOptionalAttrs : PWSTR.Ptr.Ptr
    dwNamingAttrs : UInt32
    ppszNamingAttrs : PWSTR.Ptr.Ptr
    dwSuperClasses : UInt32
    ppszSuperClasses : PWSTR.Ptr.Ptr
    fIsContainer : BOOL
}
struct ADS_SORTKEY {
    pszAttrType : PWSTR
    pszReserved : PWSTR
    fReverseorder : BOOLEAN
}
struct ADS_VLV {
    dwBeforeCount : UInt32
    dwAfterCount : UInt32
    dwOffset : UInt32
    dwContentCount : UInt32
    pszTarget : PWSTR
    dwContextIDLength : UInt32
    lpContextID : UInt8.Ptr
}
struct ADS_PROPERTY_OPERATION_ENUM extends Int32 {
    static ADS_PROPERTY_CLEAR := 1
    static ADS_PROPERTY_UPDATE := 2
    static ADS_PROPERTY_APPEND := 3
    static ADS_PROPERTY_DELETE := 4
}
struct ADS_SYSTEMFLAG_ENUM extends Int32 {
    static ADS_SYSTEMFLAG_DISALLOW_DELETE := -2147483648
    static ADS_SYSTEMFLAG_CONFIG_ALLOW_RENAME := 1073741824
    static ADS_SYSTEMFLAG_CONFIG_ALLOW_MOVE := 536870912
    static ADS_SYSTEMFLAG_CONFIG_ALLOW_LIMITED_MOVE := 268435456
    static ADS_SYSTEMFLAG_DOMAIN_DISALLOW_RENAME := 134217728
    static ADS_SYSTEMFLAG_DOMAIN_DISALLOW_MOVE := 67108864
    static ADS_SYSTEMFLAG_CR_NTDS_NC := 1
    static ADS_SYSTEMFLAG_CR_NTDS_DOMAIN := 2
    static ADS_SYSTEMFLAG_ATTR_NOT_REPLICATED := 1
    static ADS_SYSTEMFLAG_ATTR_IS_CONSTRUCTED := 4
}
struct ADS_GROUP_TYPE_ENUM extends Int32 {
    static ADS_GROUP_TYPE_GLOBAL_GROUP := 2
    static ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP := 4
    static ADS_GROUP_TYPE_LOCAL_GROUP := 4
    static ADS_GROUP_TYPE_UNIVERSAL_GROUP := 8
    static ADS_GROUP_TYPE_SECURITY_ENABLED := -2147483648
}
struct ADS_USER_FLAG_ENUM extends Int32 {
    static ADS_UF_SCRIPT := 1
    static ADS_UF_ACCOUNTDISABLE := 2
    static ADS_UF_HOMEDIR_REQUIRED := 8
    static ADS_UF_LOCKOUT := 16
    static ADS_UF_PASSWD_NOTREQD := 32
    static ADS_UF_PASSWD_CANT_CHANGE := 64
    static ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED := 128
    static ADS_UF_TEMP_DUPLICATE_ACCOUNT := 256
    static ADS_UF_NORMAL_ACCOUNT := 512
    static ADS_UF_INTERDOMAIN_TRUST_ACCOUNT := 2048
    static ADS_UF_WORKSTATION_TRUST_ACCOUNT := 4096
    static ADS_UF_SERVER_TRUST_ACCOUNT := 8192
    static ADS_UF_DONT_EXPIRE_PASSWD := 65536
    static ADS_UF_MNS_LOGON_ACCOUNT := 131072
    static ADS_UF_SMARTCARD_REQUIRED := 262144
    static ADS_UF_TRUSTED_FOR_DELEGATION := 524288
    static ADS_UF_NOT_DELEGATED := 1048576
    static ADS_UF_USE_DES_KEY_ONLY := 2097152
    static ADS_UF_DONT_REQUIRE_PREAUTH := 4194304
    static ADS_UF_PASSWORD_EXPIRED := 8388608
    static ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION := 16777216
}
struct ADS_RIGHTS_ENUM extends Int32 {
    static ADS_RIGHT_DELETE := 65536
    static ADS_RIGHT_READ_CONTROL := 131072
    static ADS_RIGHT_WRITE_DAC := 262144
    static ADS_RIGHT_WRITE_OWNER := 524288
    static ADS_RIGHT_SYNCHRONIZE := 1048576
    static ADS_RIGHT_ACCESS_SYSTEM_SECURITY := 16777216
    static ADS_RIGHT_GENERIC_READ := -2147483648
    static ADS_RIGHT_GENERIC_WRITE := 1073741824
    static ADS_RIGHT_GENERIC_EXECUTE := 536870912
    static ADS_RIGHT_GENERIC_ALL := 268435456
    static ADS_RIGHT_DS_CREATE_CHILD := 1
    static ADS_RIGHT_DS_DELETE_CHILD := 2
    static ADS_RIGHT_ACTRL_DS_LIST := 4
    static ADS_RIGHT_DS_SELF := 8
    static ADS_RIGHT_DS_READ_PROP := 16
    static ADS_RIGHT_DS_WRITE_PROP := 32
    static ADS_RIGHT_DS_DELETE_TREE := 64
    static ADS_RIGHT_DS_LIST_OBJECT := 128
    static ADS_RIGHT_DS_CONTROL_ACCESS := 256
}
struct ADS_ACETYPE_ENUM extends Int32 {
    static ADS_ACETYPE_ACCESS_ALLOWED := 0
    static ADS_ACETYPE_ACCESS_DENIED := 1
    static ADS_ACETYPE_SYSTEM_AUDIT := 2
    static ADS_ACETYPE_ACCESS_ALLOWED_OBJECT := 5
    static ADS_ACETYPE_ACCESS_DENIED_OBJECT := 6
    static ADS_ACETYPE_SYSTEM_AUDIT_OBJECT := 7
    static ADS_ACETYPE_SYSTEM_ALARM_OBJECT := 8
    static ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK := 9
    static ADS_ACETYPE_ACCESS_DENIED_CALLBACK := 10
    static ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK_OBJECT := 11
    static ADS_ACETYPE_ACCESS_DENIED_CALLBACK_OBJECT := 12
    static ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK := 13
    static ADS_ACETYPE_SYSTEM_ALARM_CALLBACK := 14
    static ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK_OBJECT := 15
    static ADS_ACETYPE_SYSTEM_ALARM_CALLBACK_OBJECT := 16
}
struct ADS_ACEFLAG_ENUM extends Int32 {
    static ADS_ACEFLAG_INHERIT_ACE := 2
    static ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE := 4
    static ADS_ACEFLAG_INHERIT_ONLY_ACE := 8
    static ADS_ACEFLAG_INHERITED_ACE := 16
    static ADS_ACEFLAG_VALID_INHERIT_FLAGS := 31
    static ADS_ACEFLAG_SUCCESSFUL_ACCESS := 64
    static ADS_ACEFLAG_FAILED_ACCESS := 128
}
struct ADS_FLAGTYPE_ENUM extends Int32 {
    static ADS_FLAG_OBJECT_TYPE_PRESENT := 1
    static ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT := 2
}
struct ADS_SD_CONTROL_ENUM extends Int32 {
    static ADS_SD_CONTROL_SE_OWNER_DEFAULTED := 1
    static ADS_SD_CONTROL_SE_GROUP_DEFAULTED := 2
    static ADS_SD_CONTROL_SE_DACL_PRESENT := 4
    static ADS_SD_CONTROL_SE_DACL_DEFAULTED := 8
    static ADS_SD_CONTROL_SE_SACL_PRESENT := 16
    static ADS_SD_CONTROL_SE_SACL_DEFAULTED := 32
    static ADS_SD_CONTROL_SE_DACL_AUTO_INHERIT_REQ := 256
    static ADS_SD_CONTROL_SE_SACL_AUTO_INHERIT_REQ := 512
    static ADS_SD_CONTROL_SE_DACL_AUTO_INHERITED := 1024
    static ADS_SD_CONTROL_SE_SACL_AUTO_INHERITED := 2048
    static ADS_SD_CONTROL_SE_DACL_PROTECTED := 4096
    static ADS_SD_CONTROL_SE_SACL_PROTECTED := 8192
    static ADS_SD_CONTROL_SE_SELF_RELATIVE := 32768
}
struct ADS_SD_REVISION_ENUM extends Int32 {
    static ADS_SD_REVISION_DS := 4
}
struct ADS_NAME_TYPE_ENUM extends Int32 {
    static ADS_NAME_TYPE_1779 := 1
    static ADS_NAME_TYPE_CANONICAL := 2
    static ADS_NAME_TYPE_NT4 := 3
    static ADS_NAME_TYPE_DISPLAY := 4
    static ADS_NAME_TYPE_DOMAIN_SIMPLE := 5
    static ADS_NAME_TYPE_ENTERPRISE_SIMPLE := 6
    static ADS_NAME_TYPE_GUID := 7
    static ADS_NAME_TYPE_UNKNOWN := 8
    static ADS_NAME_TYPE_USER_PRINCIPAL_NAME := 9
    static ADS_NAME_TYPE_CANONICAL_EX := 10
    static ADS_NAME_TYPE_SERVICE_PRINCIPAL_NAME := 11
    static ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME := 12
}
struct ADS_NAME_INITTYPE_ENUM extends Int32 {
    static ADS_NAME_INITTYPE_DOMAIN := 1
    static ADS_NAME_INITTYPE_SERVER := 2
    static ADS_NAME_INITTYPE_GC := 3
}
struct ADS_OPTION_ENUM extends Int32 {
    static ADS_OPTION_SERVERNAME := 0
    static ADS_OPTION_REFERRALS := 1
    static ADS_OPTION_PAGE_SIZE := 2
    static ADS_OPTION_SECURITY_MASK := 3
    static ADS_OPTION_MUTUAL_AUTH_STATUS := 4
    static ADS_OPTION_QUOTA := 5
    static ADS_OPTION_PASSWORD_PORTNUMBER := 6
    static ADS_OPTION_PASSWORD_METHOD := 7
    static ADS_OPTION_ACCUMULATIVE_MODIFICATION := 8
    static ADS_OPTION_SKIP_SID_LOOKUP := 9
}
struct ADS_SECURITY_INFO_ENUM extends Int32 {
    static ADS_SECURITY_INFO_OWNER := 1
    static ADS_SECURITY_INFO_GROUP := 2
    static ADS_SECURITY_INFO_DACL := 4
    static ADS_SECURITY_INFO_SACL := 8
}
struct ADS_SETTYPE_ENUM extends Int32 {
    static ADS_SETTYPE_FULL := 1
    static ADS_SETTYPE_PROVIDER := 2
    static ADS_SETTYPE_SERVER := 3
    static ADS_SETTYPE_DN := 4
}
struct ADS_FORMAT_ENUM extends Int32 {
    static ADS_FORMAT_WINDOWS := 1
    static ADS_FORMAT_WINDOWS_NO_SERVER := 2
    static ADS_FORMAT_WINDOWS_DN := 3
    static ADS_FORMAT_WINDOWS_PARENT := 4
    static ADS_FORMAT_X500 := 5
    static ADS_FORMAT_X500_NO_SERVER := 6
    static ADS_FORMAT_X500_DN := 7
    static ADS_FORMAT_X500_PARENT := 8
    static ADS_FORMAT_SERVER := 9
    static ADS_FORMAT_PROVIDER := 10
    static ADS_FORMAT_LEAF := 11
}
struct ADS_DISPLAY_ENUM extends Int32 {
    static ADS_DISPLAY_FULL := 1
    static ADS_DISPLAY_VALUE_ONLY := 2
}
struct ADS_ESCAPE_MODE_ENUM extends Int32 {
    static ADS_ESCAPEDMODE_DEFAULT := 1
    static ADS_ESCAPEDMODE_ON := 2
    static ADS_ESCAPEDMODE_OFF := 3
    static ADS_ESCAPEDMODE_OFF_EX := 4
}
struct ADS_PATHTYPE_ENUM extends Int32 {
    static ADS_PATH_FILE := 1
    static ADS_PATH_FILESHARE := 2
    static ADS_PATH_REGISTRY := 3
}
struct ADS_SD_FORMAT_ENUM extends Int32 {
    static ADS_SD_FORMAT_IID := 1
    static ADS_SD_FORMAT_RAW := 2
    static ADS_SD_FORMAT_HEXSTRING := 3
}
struct IADs extends IDispatch {
    static IID := "{FD8256D0-FD15-11CE-ABC4-02608C9E7553}"
    get_Name(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_Class(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_GUID(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    get_ADsPath(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
    get_Parent(retval)
      => ComCall(11, this.p, BSTR.Ptr, retval)
    get_Schema(retval)
      => ComCall(12, this.p, BSTR.Ptr, retval)
    GetInfo()
      => ComCall(13, this.p)
    SetInfo()
      => ComCall(14, this.p)
    Get(bstrName, pvProp)
      => ComCall(15, this.p, BSTR, bstrName, VARIANT.Ptr, pvProp)
    Put(bstrName, vProp)
      => ComCall(16, this.p, BSTR, bstrName, VARIANT, vProp)
    GetEx(bstrName, pvProp)
      => ComCall(17, this.p, BSTR, bstrName, VARIANT.Ptr, pvProp)
    PutEx(lnControlCode, bstrName, vProp)
      => ComCall(18, this.p, Int32, lnControlCode, BSTR, bstrName, VARIANT, vProp)
    GetInfoEx(vProperties, lnReserved)
      => ComCall(19, this.p, VARIANT, vProperties, Int32, lnReserved)
}
struct IADsContainer extends IDispatch {
    static IID := "{001677D0-FD16-11CE-ABC4-02608C9E7553}"
    get_Count(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Filter(pVar)
      => ComCall(9, this.p, VARIANT.Ptr, pVar)
    put_Filter(Var)
      => ComCall(10, this.p, VARIANT, Var)
    get_Hints(pvFilter)
      => ComCall(11, this.p, VARIANT.Ptr, pvFilter)
    put_Hints(vHints)
      => ComCall(12, this.p, VARIANT, vHints)
    GetObject(ClassName, RelativeName, ppObject)
      => ComCall(13, this.p, BSTR, ClassName, BSTR, RelativeName, IDispatch.Ptr, ppObject)
    Create(ClassName, RelativeName, ppObject)
      => ComCall(14, this.p, BSTR, ClassName, BSTR, RelativeName, IDispatch.Ptr, ppObject)
    Delete(bstrClassName, bstrRelativeName)
      => ComCall(15, this.p, BSTR, bstrClassName, BSTR, bstrRelativeName)
    CopyHere(SourceName, NewName, ppObject)
      => ComCall(16, this.p, BSTR, SourceName, BSTR, NewName, IDispatch.Ptr, ppObject)
    MoveHere(SourceName, NewName, ppObject)
      => ComCall(17, this.p, BSTR, SourceName, BSTR, NewName, IDispatch.Ptr, ppObject)
}
struct IADsCollection extends IDispatch {
    static IID := "{72B945E0-253B-11CF-A988-00AA006BC149}"
    get__NewEnum(ppEnumerator)
      => ComCall(7, this.p, IUnknown.Ptr, ppEnumerator)
    Add(bstrName, vItem)
      => ComCall(8, this.p, BSTR, bstrName, VARIANT, vItem)
    Remove(bstrItemToBeRemoved)
      => ComCall(9, this.p, BSTR, bstrItemToBeRemoved)
    GetObject(bstrName, pvItem)
      => ComCall(10, this.p, BSTR, bstrName, VARIANT.Ptr, pvItem)
}
struct IADsMembers extends IDispatch {
    static IID := "{451A0030-72EC-11CF-B03B-00AA006E0975}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppEnumerator)
      => ComCall(8, this.p, IUnknown.Ptr, ppEnumerator)
    get_Filter(pvFilter)
      => ComCall(9, this.p, VARIANT.Ptr, pvFilter)
    put_Filter(pvFilter)
      => ComCall(10, this.p, VARIANT, pvFilter)
}
struct IADsPropertyList extends IDispatch {
    static IID := "{C6F602B6-8F69-11D0-8528-00C04FD8D503}"
    get_PropertyCount(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    Next(pVariant)
      => ComCall(8, this.p, VARIANT.Ptr, pVariant)
    Skip(cElements)
      => ComCall(9, this.p, Int32, cElements)
    Reset()
      => ComCall(10, this.p)
    Item(varIndex, pVariant)
      => ComCall(11, this.p, VARIANT, varIndex, VARIANT.Ptr, pVariant)
    GetPropertyItem(bstrName, lnADsType, pVariant)
      => ComCall(12, this.p, BSTR, bstrName, Int32, lnADsType, VARIANT.Ptr, pVariant)
    PutPropertyItem(varData)
      => ComCall(13, this.p, VARIANT, varData)
    ResetPropertyItem(varEntry)
      => ComCall(14, this.p, VARIANT, varEntry)
    PurgePropertyList()
      => ComCall(15, this.p)
}
struct IADsPropertyEntry extends IDispatch {
    static IID := "{05792C8E-941F-11D0-8529-00C04FD8D503}"
    Clear()
      => ComCall(7, this.p)
    get_Name(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    put_Name(bstrName)
      => ComCall(9, this.p, BSTR, bstrName)
    get_ADsType(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
    put_ADsType(lnADsType)
      => ComCall(11, this.p, Int32, lnADsType)
    get_ControlCode(retval)
      => ComCall(12, this.p, Int32.Ptr, retval)
    put_ControlCode(lnControlCode)
      => ComCall(13, this.p, Int32, lnControlCode)
    get_Values(retval)
      => ComCall(14, this.p, VARIANT.Ptr, retval)
    put_Values(vValues)
      => ComCall(15, this.p, VARIANT, vValues)
}
struct IADsPropertyValue extends IDispatch {
    static IID := "{79FA9AD0-A97C-11D0-8534-00C04FD8D503}"
    Clear()
      => ComCall(7, this.p)
    get_ADsType(retval)
      => ComCall(8, this.p, Int32.Ptr, retval)
    put_ADsType(lnADsType)
      => ComCall(9, this.p, Int32, lnADsType)
    get_DNString(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
    put_DNString(bstrDNString)
      => ComCall(11, this.p, BSTR, bstrDNString)
    get_CaseExactString(retval)
      => ComCall(12, this.p, BSTR.Ptr, retval)
    put_CaseExactString(bstrCaseExactString)
      => ComCall(13, this.p, BSTR, bstrCaseExactString)
    get_CaseIgnoreString(retval)
      => ComCall(14, this.p, BSTR.Ptr, retval)
    put_CaseIgnoreString(bstrCaseIgnoreString)
      => ComCall(15, this.p, BSTR, bstrCaseIgnoreString)
    get_PrintableString(retval)
      => ComCall(16, this.p, BSTR.Ptr, retval)
    put_PrintableString(bstrPrintableString)
      => ComCall(17, this.p, BSTR, bstrPrintableString)
    get_NumericString(retval)
      => ComCall(18, this.p, BSTR.Ptr, retval)
    put_NumericString(bstrNumericString)
      => ComCall(19, this.p, BSTR, bstrNumericString)
    get_Boolean(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    put_Boolean(lnBoolean)
      => ComCall(21, this.p, Int32, lnBoolean)
    get_Integer(retval)
      => ComCall(22, this.p, Int32.Ptr, retval)
    put_Integer(lnInteger)
      => ComCall(23, this.p, Int32, lnInteger)
    get_OctetString(retval)
      => ComCall(24, this.p, VARIANT.Ptr, retval)
    put_OctetString(vOctetString)
      => ComCall(25, this.p, VARIANT, vOctetString)
    get_SecurityDescriptor(retval)
      => ComCall(26, this.p, IDispatch.Ptr, retval)
    put_SecurityDescriptor(pSecurityDescriptor?)
      => ComCall(27, this.p, IDispatch, pSecurityDescriptor?)
    get_LargeInteger(retval)
      => ComCall(28, this.p, IDispatch.Ptr, retval)
    put_LargeInteger(pLargeInteger?)
      => ComCall(29, this.p, IDispatch, pLargeInteger?)
    get_UTCTime(retval)
      => ComCall(30, this.p, Float64.Ptr, retval)
    put_UTCTime(daUTCTime)
      => ComCall(31, this.p, Float64, daUTCTime)
}
struct IADsPropertyValue2 extends IDispatch {
    static IID := "{306E831C-5BC7-11D1-A3B8-00C04FB950DC}"
    GetObjectProperty(lnADsType, pvProp)
      => ComCall(7, this.p, Int32.Ptr, lnADsType, VARIANT.Ptr, pvProp)
    PutObjectProperty(lnADsType, vProp)
      => ComCall(8, this.p, Int32, lnADsType, VARIANT, vProp)
}
struct IPrivateDispatch extends IUnknown {
    static IID := "{86AB4BBE-65F6-11D1-8C13-00C04FD8D503}"
    ADSIInitializeDispatchManager(dwExtensionId)
      => ComCall(3, this.p, Int32, dwExtensionId)
    ADSIGetTypeInfoCount(pctinfo)
      => ComCall(4, this.p, UInt32.Ptr, pctinfo)
    ADSIGetTypeInfo(itinfo, lcid, pptinfo)
      => ComCall(5, this.p, UInt32, itinfo, UInt32, lcid, ITypeInfo.Ptr, pptinfo)
    ADSIGetIDsOfNames(riid, rgszNames, cNames, lcid, rgdispid)
      => ComCall(6, this.p, GUID.Ptr, riid, UInt16.Ptr.Ptr, rgszNames, UInt32, cNames, UInt32, lcid, Int32.Ptr, rgdispid)
    ADSIInvoke(dispidMember, riid, lcid, wFlags, pdispparams, pvarResult, pexcepinfo, puArgErr)
      => ComCall(7, this.p, Int32, dispidMember, GUID.Ptr, riid, UInt32, lcid, UInt16, wFlags, DISPPARAMS.Ptr, pdispparams, VARIANT.Ptr, pvarResult, EXCEPINFO.Ptr, pexcepinfo, UInt32.Ptr, puArgErr)
}
struct IPrivateUnknown extends IUnknown {
    static IID := "{89126BAB-6EAD-11D1-8C18-00C04FD8D503}"
    ADSIInitializeObject(lpszUserName, lpszPassword, lnReserved)
      => ComCall(3, this.p, BSTR, lpszUserName, BSTR, lpszPassword, Int32, lnReserved)
    ADSIReleaseObject()
      => ComCall(4, this.p)
}
struct IADsExtension extends IUnknown {
    static IID := "{3D35553C-D2B0-11D1-B17B-0000F87593A0}"
    Operate(dwCode, varData1, varData2, varData3)
      => ComCall(3, this.p, UInt32, dwCode, VARIANT, varData1, VARIANT, varData2, VARIANT, varData3)
    PrivateGetIDsOfNames(riid, rgszNames, cNames, lcid, rgDispid)
      => ComCall(4, this.p, GUID.Ptr, riid, UInt16.Ptr.Ptr, rgszNames, UInt32, cNames, UInt32, lcid, Int32.Ptr, rgDispid)
    PrivateInvoke(dispidMember, riid, lcid, wFlags, pdispparams, pvarResult, pexcepinfo, puArgErr)
      => ComCall(5, this.p, Int32, dispidMember, GUID.Ptr, riid, UInt32, lcid, UInt16, wFlags, DISPPARAMS.Ptr, pdispparams, VARIANT.Ptr, pvarResult, EXCEPINFO.Ptr, pexcepinfo, UInt32.Ptr, puArgErr)
}
struct IADsDeleteOps extends IDispatch {
    static IID := "{B2BD0902-8878-11D1-8C21-00C04FD8D503}"
    DeleteObject(lnFlags)
      => ComCall(7, this.p, Int32, lnFlags)
}
struct IADsNamespaces extends IADs {
    static IID := "{28B96BA0-B330-11CF-A9AD-00AA006BC149}"
    get_DefaultContainer(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_DefaultContainer(bstrDefaultContainer)
      => ComCall(21, this.p, BSTR, bstrDefaultContainer)
}
struct IADsClass extends IADs {
    static IID := "{C8F93DD0-4AE0-11CF-9E73-00AA004A5691}"
    get_PrimaryInterface(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_CLSID(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    put_CLSID(bstrCLSID)
      => ComCall(22, this.p, BSTR, bstrCLSID)
    get_OID(retval)
      => ComCall(23, this.p, BSTR.Ptr, retval)
    put_OID(bstrOID)
      => ComCall(24, this.p, BSTR, bstrOID)
    get_Abstract(retval)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, retval)
    put_Abstract(fAbstract)
      => ComCall(26, this.p, VARIANT_BOOL, fAbstract)
    get_Auxiliary(retval)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, retval)
    put_Auxiliary(fAuxiliary)
      => ComCall(28, this.p, VARIANT_BOOL, fAuxiliary)
    get_MandatoryProperties(retval)
      => ComCall(29, this.p, VARIANT.Ptr, retval)
    put_MandatoryProperties(vMandatoryProperties)
      => ComCall(30, this.p, VARIANT, vMandatoryProperties)
    get_OptionalProperties(retval)
      => ComCall(31, this.p, VARIANT.Ptr, retval)
    put_OptionalProperties(vOptionalProperties)
      => ComCall(32, this.p, VARIANT, vOptionalProperties)
    get_NamingProperties(retval)
      => ComCall(33, this.p, VARIANT.Ptr, retval)
    put_NamingProperties(vNamingProperties)
      => ComCall(34, this.p, VARIANT, vNamingProperties)
    get_DerivedFrom(retval)
      => ComCall(35, this.p, VARIANT.Ptr, retval)
    put_DerivedFrom(vDerivedFrom)
      => ComCall(36, this.p, VARIANT, vDerivedFrom)
    get_AuxDerivedFrom(retval)
      => ComCall(37, this.p, VARIANT.Ptr, retval)
    put_AuxDerivedFrom(vAuxDerivedFrom)
      => ComCall(38, this.p, VARIANT, vAuxDerivedFrom)
    get_PossibleSuperiors(retval)
      => ComCall(39, this.p, VARIANT.Ptr, retval)
    put_PossibleSuperiors(vPossibleSuperiors)
      => ComCall(40, this.p, VARIANT, vPossibleSuperiors)
    get_Containment(retval)
      => ComCall(41, this.p, VARIANT.Ptr, retval)
    put_Containment(vContainment)
      => ComCall(42, this.p, VARIANT, vContainment)
    get_Container(retval)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, retval)
    put_Container(fContainer)
      => ComCall(44, this.p, VARIANT_BOOL, fContainer)
    get_HelpFileName(retval)
      => ComCall(45, this.p, BSTR.Ptr, retval)
    put_HelpFileName(bstrHelpFileName)
      => ComCall(46, this.p, BSTR, bstrHelpFileName)
    get_HelpFileContext(retval)
      => ComCall(47, this.p, Int32.Ptr, retval)
    put_HelpFileContext(lnHelpFileContext)
      => ComCall(48, this.p, Int32, lnHelpFileContext)
    Qualifiers(ppQualifiers)
      => ComCall(49, this.p, IADsCollection.Ptr, ppQualifiers)
}
struct IADsProperty extends IADs {
    static IID := "{C8F93DD3-4AE0-11CF-9E73-00AA004A5691}"
    get_OID(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_OID(bstrOID)
      => ComCall(21, this.p, BSTR, bstrOID)
    get_Syntax(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_Syntax(bstrSyntax)
      => ComCall(23, this.p, BSTR, bstrSyntax)
    get_MaxRange(retval)
      => ComCall(24, this.p, Int32.Ptr, retval)
    put_MaxRange(lnMaxRange)
      => ComCall(25, this.p, Int32, lnMaxRange)
    get_MinRange(retval)
      => ComCall(26, this.p, Int32.Ptr, retval)
    put_MinRange(lnMinRange)
      => ComCall(27, this.p, Int32, lnMinRange)
    get_MultiValued(retval)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, retval)
    put_MultiValued(fMultiValued)
      => ComCall(29, this.p, VARIANT_BOOL, fMultiValued)
    Qualifiers(ppQualifiers)
      => ComCall(30, this.p, IADsCollection.Ptr, ppQualifiers)
}
struct IADsSyntax extends IADs {
    static IID := "{C8F93DD2-4AE0-11CF-9E73-00AA004A5691}"
    get_OleAutoDataType(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    put_OleAutoDataType(lnOleAutoDataType)
      => ComCall(21, this.p, Int32, lnOleAutoDataType)
}
struct IADsLocality extends IADs {
    static IID := "{A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}"
    get_Description(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(21, this.p, BSTR, bstrDescription)
    get_LocalityName(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_LocalityName(bstrLocalityName)
      => ComCall(23, this.p, BSTR, bstrLocalityName)
    get_PostalAddress(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_PostalAddress(bstrPostalAddress)
      => ComCall(25, this.p, BSTR, bstrPostalAddress)
    get_SeeAlso(retval)
      => ComCall(26, this.p, VARIANT.Ptr, retval)
    put_SeeAlso(vSeeAlso)
      => ComCall(27, this.p, VARIANT, vSeeAlso)
}
struct IADsO extends IADs {
    static IID := "{A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}"
    get_Description(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(21, this.p, BSTR, bstrDescription)
    get_LocalityName(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_LocalityName(bstrLocalityName)
      => ComCall(23, this.p, BSTR, bstrLocalityName)
    get_PostalAddress(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_PostalAddress(bstrPostalAddress)
      => ComCall(25, this.p, BSTR, bstrPostalAddress)
    get_TelephoneNumber(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_TelephoneNumber(bstrTelephoneNumber)
      => ComCall(27, this.p, BSTR, bstrTelephoneNumber)
    get_FaxNumber(retval)
      => ComCall(28, this.p, BSTR.Ptr, retval)
    put_FaxNumber(bstrFaxNumber)
      => ComCall(29, this.p, BSTR, bstrFaxNumber)
    get_SeeAlso(retval)
      => ComCall(30, this.p, VARIANT.Ptr, retval)
    put_SeeAlso(vSeeAlso)
      => ComCall(31, this.p, VARIANT, vSeeAlso)
}
struct IADsOU extends IADs {
    static IID := "{A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}"
    get_Description(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(21, this.p, BSTR, bstrDescription)
    get_LocalityName(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_LocalityName(bstrLocalityName)
      => ComCall(23, this.p, BSTR, bstrLocalityName)
    get_PostalAddress(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_PostalAddress(bstrPostalAddress)
      => ComCall(25, this.p, BSTR, bstrPostalAddress)
    get_TelephoneNumber(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_TelephoneNumber(bstrTelephoneNumber)
      => ComCall(27, this.p, BSTR, bstrTelephoneNumber)
    get_FaxNumber(retval)
      => ComCall(28, this.p, BSTR.Ptr, retval)
    put_FaxNumber(bstrFaxNumber)
      => ComCall(29, this.p, BSTR, bstrFaxNumber)
    get_SeeAlso(retval)
      => ComCall(30, this.p, VARIANT.Ptr, retval)
    put_SeeAlso(vSeeAlso)
      => ComCall(31, this.p, VARIANT, vSeeAlso)
    get_BusinessCategory(retval)
      => ComCall(32, this.p, BSTR.Ptr, retval)
    put_BusinessCategory(bstrBusinessCategory)
      => ComCall(33, this.p, BSTR, bstrBusinessCategory)
}
struct IADsDomain extends IADs {
    static IID := "{00E4C220-FD16-11CE-ABC4-02608C9E7553}"
    get_IsWorkgroup(retval)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, retval)
    get_MinPasswordLength(retval)
      => ComCall(21, this.p, Int32.Ptr, retval)
    put_MinPasswordLength(lnMinPasswordLength)
      => ComCall(22, this.p, Int32, lnMinPasswordLength)
    get_MinPasswordAge(retval)
      => ComCall(23, this.p, Int32.Ptr, retval)
    put_MinPasswordAge(lnMinPasswordAge)
      => ComCall(24, this.p, Int32, lnMinPasswordAge)
    get_MaxPasswordAge(retval)
      => ComCall(25, this.p, Int32.Ptr, retval)
    put_MaxPasswordAge(lnMaxPasswordAge)
      => ComCall(26, this.p, Int32, lnMaxPasswordAge)
    get_MaxBadPasswordsAllowed(retval)
      => ComCall(27, this.p, Int32.Ptr, retval)
    put_MaxBadPasswordsAllowed(lnMaxBadPasswordsAllowed)
      => ComCall(28, this.p, Int32, lnMaxBadPasswordsAllowed)
    get_PasswordHistoryLength(retval)
      => ComCall(29, this.p, Int32.Ptr, retval)
    put_PasswordHistoryLength(lnPasswordHistoryLength)
      => ComCall(30, this.p, Int32, lnPasswordHistoryLength)
    get_PasswordAttributes(retval)
      => ComCall(31, this.p, Int32.Ptr, retval)
    put_PasswordAttributes(lnPasswordAttributes)
      => ComCall(32, this.p, Int32, lnPasswordAttributes)
    get_AutoUnlockInterval(retval)
      => ComCall(33, this.p, Int32.Ptr, retval)
    put_AutoUnlockInterval(lnAutoUnlockInterval)
      => ComCall(34, this.p, Int32, lnAutoUnlockInterval)
    get_LockoutObservationInterval(retval)
      => ComCall(35, this.p, Int32.Ptr, retval)
    put_LockoutObservationInterval(lnLockoutObservationInterval)
      => ComCall(36, this.p, Int32, lnLockoutObservationInterval)
}
struct IADsComputer extends IADs {
    static IID := "{EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}"
    get_ComputerID(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_Site(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    get_Description(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(23, this.p, BSTR, bstrDescription)
    get_Location(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_Location(bstrLocation)
      => ComCall(25, this.p, BSTR, bstrLocation)
    get_PrimaryUser(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_PrimaryUser(bstrPrimaryUser)
      => ComCall(27, this.p, BSTR, bstrPrimaryUser)
    get_Owner(retval)
      => ComCall(28, this.p, BSTR.Ptr, retval)
    put_Owner(bstrOwner)
      => ComCall(29, this.p, BSTR, bstrOwner)
    get_Division(retval)
      => ComCall(30, this.p, BSTR.Ptr, retval)
    put_Division(bstrDivision)
      => ComCall(31, this.p, BSTR, bstrDivision)
    get_Department(retval)
      => ComCall(32, this.p, BSTR.Ptr, retval)
    put_Department(bstrDepartment)
      => ComCall(33, this.p, BSTR, bstrDepartment)
    get_Role(retval)
      => ComCall(34, this.p, BSTR.Ptr, retval)
    put_Role(bstrRole)
      => ComCall(35, this.p, BSTR, bstrRole)
    get_OperatingSystem(retval)
      => ComCall(36, this.p, BSTR.Ptr, retval)
    put_OperatingSystem(bstrOperatingSystem)
      => ComCall(37, this.p, BSTR, bstrOperatingSystem)
    get_OperatingSystemVersion(retval)
      => ComCall(38, this.p, BSTR.Ptr, retval)
    put_OperatingSystemVersion(bstrOperatingSystemVersion)
      => ComCall(39, this.p, BSTR, bstrOperatingSystemVersion)
    get_Model(retval)
      => ComCall(40, this.p, BSTR.Ptr, retval)
    put_Model(bstrModel)
      => ComCall(41, this.p, BSTR, bstrModel)
    get_Processor(retval)
      => ComCall(42, this.p, BSTR.Ptr, retval)
    put_Processor(bstrProcessor)
      => ComCall(43, this.p, BSTR, bstrProcessor)
    get_ProcessorCount(retval)
      => ComCall(44, this.p, BSTR.Ptr, retval)
    put_ProcessorCount(bstrProcessorCount)
      => ComCall(45, this.p, BSTR, bstrProcessorCount)
    get_MemorySize(retval)
      => ComCall(46, this.p, BSTR.Ptr, retval)
    put_MemorySize(bstrMemorySize)
      => ComCall(47, this.p, BSTR, bstrMemorySize)
    get_StorageCapacity(retval)
      => ComCall(48, this.p, BSTR.Ptr, retval)
    put_StorageCapacity(bstrStorageCapacity)
      => ComCall(49, this.p, BSTR, bstrStorageCapacity)
    get_NetAddresses(retval)
      => ComCall(50, this.p, VARIANT.Ptr, retval)
    put_NetAddresses(vNetAddresses)
      => ComCall(51, this.p, VARIANT, vNetAddresses)
}
struct IADsComputerOperations extends IADs {
    static IID := "{EF497680-1D9F-11CF-B1F3-02608C9E7553}"
    Status(ppObject)
      => ComCall(20, this.p, IDispatch.Ptr, ppObject)
    Shutdown(bReboot)
      => ComCall(21, this.p, VARIANT_BOOL, bReboot)
}
struct IADsGroup extends IADs {
    static IID := "{27636B00-410F-11CF-B1FF-02608C9E7553}"
    get_Description(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(21, this.p, BSTR, bstrDescription)
    Members(ppMembers)
      => ComCall(22, this.p, IADsMembers.Ptr, ppMembers)
    IsMember(bstrMember, bMember)
      => ComCall(23, this.p, BSTR, bstrMember, VARIANT_BOOL.Ptr, bMember)
    Add(bstrNewItem)
      => ComCall(24, this.p, BSTR, bstrNewItem)
    Remove(bstrItemToBeRemoved)
      => ComCall(25, this.p, BSTR, bstrItemToBeRemoved)
}
struct IADsUser extends IADs {
    static IID := "{3E37E320-17E2-11CF-ABC4-02608C9E7553}"
    get_BadLoginAddress(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_BadLoginCount(retval)
      => ComCall(21, this.p, Int32.Ptr, retval)
    get_LastLogin(retval)
      => ComCall(22, this.p, Float64.Ptr, retval)
    get_LastLogoff(retval)
      => ComCall(23, this.p, Float64.Ptr, retval)
    get_LastFailedLogin(retval)
      => ComCall(24, this.p, Float64.Ptr, retval)
    get_PasswordLastChanged(retval)
      => ComCall(25, this.p, Float64.Ptr, retval)
    get_Description(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(27, this.p, BSTR, bstrDescription)
    get_Division(retval)
      => ComCall(28, this.p, BSTR.Ptr, retval)
    put_Division(bstrDivision)
      => ComCall(29, this.p, BSTR, bstrDivision)
    get_Department(retval)
      => ComCall(30, this.p, BSTR.Ptr, retval)
    put_Department(bstrDepartment)
      => ComCall(31, this.p, BSTR, bstrDepartment)
    get_EmployeeID(retval)
      => ComCall(32, this.p, BSTR.Ptr, retval)
    put_EmployeeID(bstrEmployeeID)
      => ComCall(33, this.p, BSTR, bstrEmployeeID)
    get_FullName(retval)
      => ComCall(34, this.p, BSTR.Ptr, retval)
    put_FullName(bstrFullName)
      => ComCall(35, this.p, BSTR, bstrFullName)
    get_FirstName(retval)
      => ComCall(36, this.p, BSTR.Ptr, retval)
    put_FirstName(bstrFirstName)
      => ComCall(37, this.p, BSTR, bstrFirstName)
    get_LastName(retval)
      => ComCall(38, this.p, BSTR.Ptr, retval)
    put_LastName(bstrLastName)
      => ComCall(39, this.p, BSTR, bstrLastName)
    get_OtherName(retval)
      => ComCall(40, this.p, BSTR.Ptr, retval)
    put_OtherName(bstrOtherName)
      => ComCall(41, this.p, BSTR, bstrOtherName)
    get_NamePrefix(retval)
      => ComCall(42, this.p, BSTR.Ptr, retval)
    put_NamePrefix(bstrNamePrefix)
      => ComCall(43, this.p, BSTR, bstrNamePrefix)
    get_NameSuffix(retval)
      => ComCall(44, this.p, BSTR.Ptr, retval)
    put_NameSuffix(bstrNameSuffix)
      => ComCall(45, this.p, BSTR, bstrNameSuffix)
    get_Title(retval)
      => ComCall(46, this.p, BSTR.Ptr, retval)
    put_Title(bstrTitle)
      => ComCall(47, this.p, BSTR, bstrTitle)
    get_Manager(retval)
      => ComCall(48, this.p, BSTR.Ptr, retval)
    put_Manager(bstrManager)
      => ComCall(49, this.p, BSTR, bstrManager)
    get_TelephoneHome(retval)
      => ComCall(50, this.p, VARIANT.Ptr, retval)
    put_TelephoneHome(vTelephoneHome)
      => ComCall(51, this.p, VARIANT, vTelephoneHome)
    get_TelephoneMobile(retval)
      => ComCall(52, this.p, VARIANT.Ptr, retval)
    put_TelephoneMobile(vTelephoneMobile)
      => ComCall(53, this.p, VARIANT, vTelephoneMobile)
    get_TelephoneNumber(retval)
      => ComCall(54, this.p, VARIANT.Ptr, retval)
    put_TelephoneNumber(vTelephoneNumber)
      => ComCall(55, this.p, VARIANT, vTelephoneNumber)
    get_TelephonePager(retval)
      => ComCall(56, this.p, VARIANT.Ptr, retval)
    put_TelephonePager(vTelephonePager)
      => ComCall(57, this.p, VARIANT, vTelephonePager)
    get_FaxNumber(retval)
      => ComCall(58, this.p, VARIANT.Ptr, retval)
    put_FaxNumber(vFaxNumber)
      => ComCall(59, this.p, VARIANT, vFaxNumber)
    get_OfficeLocations(retval)
      => ComCall(60, this.p, VARIANT.Ptr, retval)
    put_OfficeLocations(vOfficeLocations)
      => ComCall(61, this.p, VARIANT, vOfficeLocations)
    get_PostalAddresses(retval)
      => ComCall(62, this.p, VARIANT.Ptr, retval)
    put_PostalAddresses(vPostalAddresses)
      => ComCall(63, this.p, VARIANT, vPostalAddresses)
    get_PostalCodes(retval)
      => ComCall(64, this.p, VARIANT.Ptr, retval)
    put_PostalCodes(vPostalCodes)
      => ComCall(65, this.p, VARIANT, vPostalCodes)
    get_SeeAlso(retval)
      => ComCall(66, this.p, VARIANT.Ptr, retval)
    put_SeeAlso(vSeeAlso)
      => ComCall(67, this.p, VARIANT, vSeeAlso)
    get_AccountDisabled(retval)
      => ComCall(68, this.p, VARIANT_BOOL.Ptr, retval)
    put_AccountDisabled(fAccountDisabled)
      => ComCall(69, this.p, VARIANT_BOOL, fAccountDisabled)
    get_AccountExpirationDate(retval)
      => ComCall(70, this.p, Float64.Ptr, retval)
    put_AccountExpirationDate(daAccountExpirationDate)
      => ComCall(71, this.p, Float64, daAccountExpirationDate)
    get_GraceLoginsAllowed(retval)
      => ComCall(72, this.p, Int32.Ptr, retval)
    put_GraceLoginsAllowed(lnGraceLoginsAllowed)
      => ComCall(73, this.p, Int32, lnGraceLoginsAllowed)
    get_GraceLoginsRemaining(retval)
      => ComCall(74, this.p, Int32.Ptr, retval)
    put_GraceLoginsRemaining(lnGraceLoginsRemaining)
      => ComCall(75, this.p, Int32, lnGraceLoginsRemaining)
    get_IsAccountLocked(retval)
      => ComCall(76, this.p, VARIANT_BOOL.Ptr, retval)
    put_IsAccountLocked(fIsAccountLocked)
      => ComCall(77, this.p, VARIANT_BOOL, fIsAccountLocked)
    get_LoginHours(retval)
      => ComCall(78, this.p, VARIANT.Ptr, retval)
    put_LoginHours(vLoginHours)
      => ComCall(79, this.p, VARIANT, vLoginHours)
    get_LoginWorkstations(retval)
      => ComCall(80, this.p, VARIANT.Ptr, retval)
    put_LoginWorkstations(vLoginWorkstations)
      => ComCall(81, this.p, VARIANT, vLoginWorkstations)
    get_MaxLogins(retval)
      => ComCall(82, this.p, Int32.Ptr, retval)
    put_MaxLogins(lnMaxLogins)
      => ComCall(83, this.p, Int32, lnMaxLogins)
    get_MaxStorage(retval)
      => ComCall(84, this.p, Int32.Ptr, retval)
    put_MaxStorage(lnMaxStorage)
      => ComCall(85, this.p, Int32, lnMaxStorage)
    get_PasswordExpirationDate(retval)
      => ComCall(86, this.p, Float64.Ptr, retval)
    put_PasswordExpirationDate(daPasswordExpirationDate)
      => ComCall(87, this.p, Float64, daPasswordExpirationDate)
    get_PasswordMinimumLength(retval)
      => ComCall(88, this.p, Int32.Ptr, retval)
    put_PasswordMinimumLength(lnPasswordMinimumLength)
      => ComCall(89, this.p, Int32, lnPasswordMinimumLength)
    get_PasswordRequired(retval)
      => ComCall(90, this.p, VARIANT_BOOL.Ptr, retval)
    put_PasswordRequired(fPasswordRequired)
      => ComCall(91, this.p, VARIANT_BOOL, fPasswordRequired)
    get_RequireUniquePassword(retval)
      => ComCall(92, this.p, VARIANT_BOOL.Ptr, retval)
    put_RequireUniquePassword(fRequireUniquePassword)
      => ComCall(93, this.p, VARIANT_BOOL, fRequireUniquePassword)
    get_EmailAddress(retval)
      => ComCall(94, this.p, BSTR.Ptr, retval)
    put_EmailAddress(bstrEmailAddress)
      => ComCall(95, this.p, BSTR, bstrEmailAddress)
    get_HomeDirectory(retval)
      => ComCall(96, this.p, BSTR.Ptr, retval)
    put_HomeDirectory(bstrHomeDirectory)
      => ComCall(97, this.p, BSTR, bstrHomeDirectory)
    get_Languages(retval)
      => ComCall(98, this.p, VARIANT.Ptr, retval)
    put_Languages(vLanguages)
      => ComCall(99, this.p, VARIANT, vLanguages)
    get_Profile(retval)
      => ComCall(100, this.p, BSTR.Ptr, retval)
    put_Profile(bstrProfile)
      => ComCall(101, this.p, BSTR, bstrProfile)
    get_LoginScript(retval)
      => ComCall(102, this.p, BSTR.Ptr, retval)
    put_LoginScript(bstrLoginScript)
      => ComCall(103, this.p, BSTR, bstrLoginScript)
    get_Picture(retval)
      => ComCall(104, this.p, VARIANT.Ptr, retval)
    put_Picture(vPicture)
      => ComCall(105, this.p, VARIANT, vPicture)
    get_HomePage(retval)
      => ComCall(106, this.p, BSTR.Ptr, retval)
    put_HomePage(bstrHomePage)
      => ComCall(107, this.p, BSTR, bstrHomePage)
    Groups(ppGroups)
      => ComCall(108, this.p, IADsMembers.Ptr, ppGroups)
    SetPassword(NewPassword)
      => ComCall(109, this.p, BSTR, NewPassword)
    ChangePassword(bstrOldPassword, bstrNewPassword)
      => ComCall(110, this.p, BSTR, bstrOldPassword, BSTR, bstrNewPassword)
}
struct IADsPrintQueue extends IADs {
    static IID := "{B15160D0-1226-11CF-A985-00AA006BC149}"
    get_PrinterPath(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_PrinterPath(bstrPrinterPath)
      => ComCall(21, this.p, BSTR, bstrPrinterPath)
    get_Model(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_Model(bstrModel)
      => ComCall(23, this.p, BSTR, bstrModel)
    get_Datatype(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_Datatype(bstrDatatype)
      => ComCall(25, this.p, BSTR, bstrDatatype)
    get_PrintProcessor(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_PrintProcessor(bstrPrintProcessor)
      => ComCall(27, this.p, BSTR, bstrPrintProcessor)
    get_Description(retval)
      => ComCall(28, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(29, this.p, BSTR, bstrDescription)
    get_Location(retval)
      => ComCall(30, this.p, BSTR.Ptr, retval)
    put_Location(bstrLocation)
      => ComCall(31, this.p, BSTR, bstrLocation)
    get_StartTime(retval)
      => ComCall(32, this.p, Float64.Ptr, retval)
    put_StartTime(daStartTime)
      => ComCall(33, this.p, Float64, daStartTime)
    get_UntilTime(retval)
      => ComCall(34, this.p, Float64.Ptr, retval)
    put_UntilTime(daUntilTime)
      => ComCall(35, this.p, Float64, daUntilTime)
    get_DefaultJobPriority(retval)
      => ComCall(36, this.p, Int32.Ptr, retval)
    put_DefaultJobPriority(lnDefaultJobPriority)
      => ComCall(37, this.p, Int32, lnDefaultJobPriority)
    get_Priority(retval)
      => ComCall(38, this.p, Int32.Ptr, retval)
    put_Priority(lnPriority)
      => ComCall(39, this.p, Int32, lnPriority)
    get_BannerPage(retval)
      => ComCall(40, this.p, BSTR.Ptr, retval)
    put_BannerPage(bstrBannerPage)
      => ComCall(41, this.p, BSTR, bstrBannerPage)
    get_PrintDevices(retval)
      => ComCall(42, this.p, VARIANT.Ptr, retval)
    put_PrintDevices(vPrintDevices)
      => ComCall(43, this.p, VARIANT, vPrintDevices)
    get_NetAddresses(retval)
      => ComCall(44, this.p, VARIANT.Ptr, retval)
    put_NetAddresses(vNetAddresses)
      => ComCall(45, this.p, VARIANT, vNetAddresses)
}
struct IADsPrintQueueOperations extends IADs {
    static IID := "{124BE5C0-156E-11CF-A986-00AA006BC149}"
    get_Status(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    PrintJobs(pObject)
      => ComCall(21, this.p, IADsCollection.Ptr, pObject)
    Pause()
      => ComCall(22, this.p)
    Resume()
      => ComCall(23, this.p)
    Purge()
      => ComCall(24, this.p)
}
struct IADsPrintJob extends IADs {
    static IID := "{32FB6780-1ED0-11CF-A988-00AA006BC149}"
    get_HostPrintQueue(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_User(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    get_UserPath(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    get_TimeSubmitted(retval)
      => ComCall(23, this.p, Float64.Ptr, retval)
    get_TotalPages(retval)
      => ComCall(24, this.p, Int32.Ptr, retval)
    get_Size(retval)
      => ComCall(25, this.p, Int32.Ptr, retval)
    get_Description(retval)
      => ComCall(26, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(27, this.p, BSTR, bstrDescription)
    get_Priority(retval)
      => ComCall(28, this.p, Int32.Ptr, retval)
    put_Priority(lnPriority)
      => ComCall(29, this.p, Int32, lnPriority)
    get_StartTime(retval)
      => ComCall(30, this.p, Float64.Ptr, retval)
    put_StartTime(daStartTime)
      => ComCall(31, this.p, Float64, daStartTime)
    get_UntilTime(retval)
      => ComCall(32, this.p, Float64.Ptr, retval)
    put_UntilTime(daUntilTime)
      => ComCall(33, this.p, Float64, daUntilTime)
    get_Notify(retval)
      => ComCall(34, this.p, BSTR.Ptr, retval)
    put_Notify(bstrNotify)
      => ComCall(35, this.p, BSTR, bstrNotify)
    get_NotifyPath(retval)
      => ComCall(36, this.p, BSTR.Ptr, retval)
    put_NotifyPath(bstrNotifyPath)
      => ComCall(37, this.p, BSTR, bstrNotifyPath)
}
struct IADsPrintJobOperations extends IADs {
    static IID := "{9A52DB30-1ECF-11CF-A988-00AA006BC149}"
    get_Status(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    get_TimeElapsed(retval)
      => ComCall(21, this.p, Int32.Ptr, retval)
    get_PagesPrinted(retval)
      => ComCall(22, this.p, Int32.Ptr, retval)
    get_Position(retval)
      => ComCall(23, this.p, Int32.Ptr, retval)
    put_Position(lnPosition)
      => ComCall(24, this.p, Int32, lnPosition)
    Pause()
      => ComCall(25, this.p)
    Resume()
      => ComCall(26, this.p)
}
struct IADsService extends IADs {
    static IID := "{68AF66E0-31CA-11CF-A98A-00AA006BC149}"
    get_HostComputer(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    put_HostComputer(bstrHostComputer)
      => ComCall(21, this.p, BSTR, bstrHostComputer)
    get_DisplayName(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    put_DisplayName(bstrDisplayName)
      => ComCall(23, this.p, BSTR, bstrDisplayName)
    get_Version(retval)
      => ComCall(24, this.p, BSTR.Ptr, retval)
    put_Version(bstrVersion)
      => ComCall(25, this.p, BSTR, bstrVersion)
    get_ServiceType(retval)
      => ComCall(26, this.p, Int32.Ptr, retval)
    put_ServiceType(lnServiceType)
      => ComCall(27, this.p, Int32, lnServiceType)
    get_StartType(retval)
      => ComCall(28, this.p, Int32.Ptr, retval)
    put_StartType(lnStartType)
      => ComCall(29, this.p, Int32, lnStartType)
    get_Path(retval)
      => ComCall(30, this.p, BSTR.Ptr, retval)
    put_Path(bstrPath)
      => ComCall(31, this.p, BSTR, bstrPath)
    get_StartupParameters(retval)
      => ComCall(32, this.p, BSTR.Ptr, retval)
    put_StartupParameters(bstrStartupParameters)
      => ComCall(33, this.p, BSTR, bstrStartupParameters)
    get_ErrorControl(retval)
      => ComCall(34, this.p, Int32.Ptr, retval)
    put_ErrorControl(lnErrorControl)
      => ComCall(35, this.p, Int32, lnErrorControl)
    get_LoadOrderGroup(retval)
      => ComCall(36, this.p, BSTR.Ptr, retval)
    put_LoadOrderGroup(bstrLoadOrderGroup)
      => ComCall(37, this.p, BSTR, bstrLoadOrderGroup)
    get_ServiceAccountName(retval)
      => ComCall(38, this.p, BSTR.Ptr, retval)
    put_ServiceAccountName(bstrServiceAccountName)
      => ComCall(39, this.p, BSTR, bstrServiceAccountName)
    get_ServiceAccountPath(retval)
      => ComCall(40, this.p, BSTR.Ptr, retval)
    put_ServiceAccountPath(bstrServiceAccountPath)
      => ComCall(41, this.p, BSTR, bstrServiceAccountPath)
    get_Dependencies(retval)
      => ComCall(42, this.p, VARIANT.Ptr, retval)
    put_Dependencies(vDependencies)
      => ComCall(43, this.p, VARIANT, vDependencies)
}
struct IADsServiceOperations extends IADs {
    static IID := "{5D7B33F0-31CA-11CF-A98A-00AA006BC149}"
    get_Status(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    Start()
      => ComCall(21, this.p)
    Stop()
      => ComCall(22, this.p)
    Pause()
      => ComCall(23, this.p)
    Continue()
      => ComCall(24, this.p)
    SetPassword(bstrNewPassword)
      => ComCall(25, this.p, BSTR, bstrNewPassword)
}
struct IADsFileService extends IADsService {
    static IID := "{A89D1900-31CA-11CF-A98A-00AA006BC149}"
    get_Description(retval)
      => ComCall(44, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(45, this.p, BSTR, bstrDescription)
    get_MaxUserCount(retval)
      => ComCall(46, this.p, Int32.Ptr, retval)
    put_MaxUserCount(lnMaxUserCount)
      => ComCall(47, this.p, Int32, lnMaxUserCount)
}
struct IADsFileServiceOperations extends IADsServiceOperations {
    static IID := "{A02DED10-31CA-11CF-A98A-00AA006BC149}"
    Sessions(ppSessions)
      => ComCall(26, this.p, IADsCollection.Ptr, ppSessions)
    Resources(ppResources)
      => ComCall(27, this.p, IADsCollection.Ptr, ppResources)
}
struct IADsFileShare extends IADs {
    static IID := "{EB6DCAF0-4B83-11CF-A995-00AA006BC149}"
    get_CurrentUserCount(retval)
      => ComCall(20, this.p, Int32.Ptr, retval)
    get_Description(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    put_Description(bstrDescription)
      => ComCall(22, this.p, BSTR, bstrDescription)
    get_HostComputer(retval)
      => ComCall(23, this.p, BSTR.Ptr, retval)
    put_HostComputer(bstrHostComputer)
      => ComCall(24, this.p, BSTR, bstrHostComputer)
    get_Path(retval)
      => ComCall(25, this.p, BSTR.Ptr, retval)
    put_Path(bstrPath)
      => ComCall(26, this.p, BSTR, bstrPath)
    get_MaxUserCount(retval)
      => ComCall(27, this.p, Int32.Ptr, retval)
    put_MaxUserCount(lnMaxUserCount)
      => ComCall(28, this.p, Int32, lnMaxUserCount)
}
struct IADsSession extends IADs {
    static IID := "{398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}"
    get_User(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_UserPath(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    get_Computer(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    get_ComputerPath(retval)
      => ComCall(23, this.p, BSTR.Ptr, retval)
    get_ConnectTime(retval)
      => ComCall(24, this.p, Int32.Ptr, retval)
    get_IdleTime(retval)
      => ComCall(25, this.p, Int32.Ptr, retval)
}
struct IADsResource extends IADs {
    static IID := "{34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}"
    get_User(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
    get_UserPath(retval)
      => ComCall(21, this.p, BSTR.Ptr, retval)
    get_Path(retval)
      => ComCall(22, this.p, BSTR.Ptr, retval)
    get_LockCount(retval)
      => ComCall(23, this.p, Int32.Ptr, retval)
}
struct IADsOpenDSObject extends IDispatch {
    static IID := "{DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}"
    OpenDSObject(lpszDNName, lpszUserName, lpszPassword, lnReserved, ppOleDsObj)
      => ComCall(7, this.p, BSTR, lpszDNName, BSTR, lpszUserName, BSTR, lpszPassword, Int32, lnReserved, IDispatch.Ptr, ppOleDsObj)
}
struct IDirectoryObject extends IUnknown {
    static IID := "{E798DE2C-22E4-11D0-84FE-00C04FD8D503}"
    GetObjectInformation(ppObjInfo)
      => ComCall(3, this.p, ADS_OBJECT_INFO.Ptr.Ptr, ppObjInfo)
    GetObjectAttributes(pAttributeNames, dwNumberAttributes, ppAttributeEntries, pdwNumAttributesReturned)
      => ComCall(4, this.p, PWSTR.Ptr, pAttributeNames, UInt32, dwNumberAttributes, ADS_ATTR_INFO.Ptr.Ptr, ppAttributeEntries, UInt32.Ptr, pdwNumAttributesReturned)
    SetObjectAttributes(pAttributeEntries, dwNumAttributes, pdwNumAttributesModified)
      => ComCall(5, this.p, ADS_ATTR_INFO.Ptr, pAttributeEntries, UInt32, dwNumAttributes, UInt32.Ptr, pdwNumAttributesModified)
    CreateDSObject(pszRDNName, pAttributeEntries, dwNumAttributes, ppObject)
      => ComCall(6, this.p, "Str", pszRDNName, ADS_ATTR_INFO.Ptr, pAttributeEntries, UInt32, dwNumAttributes, IDispatch.Ptr, ppObject)
    DeleteDSObject(pszRDNName)
      => ComCall(7, this.p, "Str", pszRDNName)
}
struct IDirectorySearch extends IUnknown {
    static IID := "{109BA8EC-92F0-11D0-A790-00C04FD8D5A8}"
    SetSearchPreference(pSearchPrefs, dwNumPrefs)
      => ComCall(3, this.p, ADS_SEARCHPREF_INFO.Ptr, pSearchPrefs, UInt32, dwNumPrefs)
    ExecuteSearch(pszSearchFilter, pAttributeNames, dwNumberAttributes, phSearchResult)
      => ComCall(4, this.p, "Str", pszSearchFilter, PWSTR.Ptr, pAttributeNames, UInt32, dwNumberAttributes, ADS_SEARCH_HANDLE.Ptr, phSearchResult)
    AbandonSearch(phSearchResult)
      => ComCall(5, this.p, ADS_SEARCH_HANDLE, phSearchResult)
    GetFirstRow(hSearchResult)
      => ComCall(6, this.p, ADS_SEARCH_HANDLE, hSearchResult)
    GetNextRow(hSearchResult)
      => ComCall(7, this.p, ADS_SEARCH_HANDLE, hSearchResult)
    GetPreviousRow(hSearchResult)
      => ComCall(8, this.p, ADS_SEARCH_HANDLE, hSearchResult)
    GetNextColumnName(hSearchHandle, ppszColumnName)
      => ComCall(9, this.p, ADS_SEARCH_HANDLE, hSearchHandle, PWSTR.Ptr, ppszColumnName)
    GetColumn(hSearchResult, szColumnName, pSearchColumn)
      => ComCall(10, this.p, ADS_SEARCH_HANDLE, hSearchResult, "Str", szColumnName, ADS_SEARCH_COLUMN.Ptr, pSearchColumn)
    FreeColumn(pSearchColumn)
      => ComCall(11, this.p, ADS_SEARCH_COLUMN.Ptr, pSearchColumn)
    CloseSearchHandle(hSearchResult)
      => ComCall(12, this.p, ADS_SEARCH_HANDLE, hSearchResult)
}
struct IDirectorySchemaMgmt extends IUnknown {
    static IID := "{75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8}"
    EnumAttributes(ppszAttrNames, dwNumAttributes, ppAttrDefinition, pdwNumAttributes)
      => ComCall(3, this.p, PWSTR.Ptr, ppszAttrNames, UInt32, dwNumAttributes, ADS_ATTR_DEF.Ptr.Ptr, ppAttrDefinition, UInt32.Ptr, pdwNumAttributes)
    CreateAttributeDefinition(pszAttributeName, pAttributeDefinition)
      => ComCall(4, this.p, "Str", pszAttributeName, ADS_ATTR_DEF.Ptr, pAttributeDefinition)
    WriteAttributeDefinition(pszAttributeName, pAttributeDefinition)
      => ComCall(5, this.p, "Str", pszAttributeName, ADS_ATTR_DEF.Ptr, pAttributeDefinition)
    DeleteAttributeDefinition(pszAttributeName)
      => ComCall(6, this.p, "Str", pszAttributeName)
    EnumClasses(ppszClassNames, dwNumClasses, ppClassDefinition, pdwNumClasses)
      => ComCall(7, this.p, PWSTR.Ptr, ppszClassNames, UInt32, dwNumClasses, ADS_CLASS_DEF.Ptr.Ptr, ppClassDefinition, UInt32.Ptr, pdwNumClasses)
    WriteClassDefinition(pszClassName, pClassDefinition)
      => ComCall(8, this.p, "Str", pszClassName, ADS_CLASS_DEF.Ptr, pClassDefinition)
    CreateClassDefinition(pszClassName, pClassDefinition)
      => ComCall(9, this.p, "Str", pszClassName, ADS_CLASS_DEF.Ptr, pClassDefinition)
    DeleteClassDefinition(pszClassName)
      => ComCall(10, this.p, "Str", pszClassName)
}
struct IADsAggregatee extends IUnknown {
    static IID := "{1346CE8C-9039-11D0-8528-00C04FD8D503}"
    ConnectAsAggregatee(pOuterUnknown?)
      => ComCall(3, this.p, IUnknown, pOuterUnknown?)
    DisconnectAsAggregatee()
      => ComCall(4, this.p)
    RelinquishInterface(riid)
      => ComCall(5, this.p, GUID.Ptr, riid)
    RestoreInterface(riid)
      => ComCall(6, this.p, GUID.Ptr, riid)
}
struct IADsAggregator extends IUnknown {
    static IID := "{52DB5FB0-941F-11D0-8529-00C04FD8D503}"
    ConnectAsAggregator(pAggregatee?)
      => ComCall(3, this.p, IUnknown, pAggregatee?)
    DisconnectAsAggregator()
      => ComCall(4, this.p)
}
struct IADsAccessControlEntry extends IDispatch {
    static IID := "{B4F3A14C-9BDD-11D0-852C-00C04FD8D503}"
    get_AccessMask(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_AccessMask(lnAccessMask)
      => ComCall(8, this.p, Int32, lnAccessMask)
    get_AceType(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_AceType(lnAceType)
      => ComCall(10, this.p, Int32, lnAceType)
    get_AceFlags(retval)
      => ComCall(11, this.p, Int32.Ptr, retval)
    put_AceFlags(lnAceFlags)
      => ComCall(12, this.p, Int32, lnAceFlags)
    get_Flags(retval)
      => ComCall(13, this.p, Int32.Ptr, retval)
    put_Flags(lnFlags)
      => ComCall(14, this.p, Int32, lnFlags)
    get_ObjectType(retval)
      => ComCall(15, this.p, BSTR.Ptr, retval)
    put_ObjectType(bstrObjectType)
      => ComCall(16, this.p, BSTR, bstrObjectType)
    get_InheritedObjectType(retval)
      => ComCall(17, this.p, BSTR.Ptr, retval)
    put_InheritedObjectType(bstrInheritedObjectType)
      => ComCall(18, this.p, BSTR, bstrInheritedObjectType)
    get_Trustee(retval)
      => ComCall(19, this.p, BSTR.Ptr, retval)
    put_Trustee(bstrTrustee)
      => ComCall(20, this.p, BSTR, bstrTrustee)
}
struct IADsAccessControlList extends IDispatch {
    static IID := "{B7EE91CC-9BDD-11D0-852C-00C04FD8D503}"
    get_AclRevision(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_AclRevision(lnAclRevision)
      => ComCall(8, this.p, Int32, lnAclRevision)
    get_AceCount(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_AceCount(lnAceCount)
      => ComCall(10, this.p, Int32, lnAceCount)
    AddAce(pAccessControlEntry?)
      => ComCall(11, this.p, IDispatch, pAccessControlEntry?)
    RemoveAce(pAccessControlEntry?)
      => ComCall(12, this.p, IDispatch, pAccessControlEntry?)
    CopyAccessList(ppAccessControlList)
      => ComCall(13, this.p, IDispatch.Ptr, ppAccessControlList)
    get__NewEnum(retval)
      => ComCall(14, this.p, IUnknown.Ptr, retval)
}
struct IADsSecurityDescriptor extends IDispatch {
    static IID := "{B8C787CA-9BDD-11D0-852C-00C04FD8D503}"
    get_Revision(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_Revision(lnRevision)
      => ComCall(8, this.p, Int32, lnRevision)
    get_Control(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_Control(lnControl)
      => ComCall(10, this.p, Int32, lnControl)
    get_Owner(retval)
      => ComCall(11, this.p, BSTR.Ptr, retval)
    put_Owner(bstrOwner)
      => ComCall(12, this.p, BSTR, bstrOwner)
    get_OwnerDefaulted(retval)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, retval)
    put_OwnerDefaulted(fOwnerDefaulted)
      => ComCall(14, this.p, VARIANT_BOOL, fOwnerDefaulted)
    get_Group(retval)
      => ComCall(15, this.p, BSTR.Ptr, retval)
    put_Group(bstrGroup)
      => ComCall(16, this.p, BSTR, bstrGroup)
    get_GroupDefaulted(retval)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, retval)
    put_GroupDefaulted(fGroupDefaulted)
      => ComCall(18, this.p, VARIANT_BOOL, fGroupDefaulted)
    get_DiscretionaryAcl(retval)
      => ComCall(19, this.p, IDispatch.Ptr, retval)
    put_DiscretionaryAcl(pDiscretionaryAcl?)
      => ComCall(20, this.p, IDispatch, pDiscretionaryAcl?)
    get_DaclDefaulted(retval)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, retval)
    put_DaclDefaulted(fDaclDefaulted)
      => ComCall(22, this.p, VARIANT_BOOL, fDaclDefaulted)
    get_SystemAcl(retval)
      => ComCall(23, this.p, IDispatch.Ptr, retval)
    put_SystemAcl(pSystemAcl?)
      => ComCall(24, this.p, IDispatch, pSystemAcl?)
    get_SaclDefaulted(retval)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, retval)
    put_SaclDefaulted(fSaclDefaulted)
      => ComCall(26, this.p, VARIANT_BOOL, fSaclDefaulted)
    CopySecurityDescriptor(ppSecurityDescriptor)
      => ComCall(27, this.p, IDispatch.Ptr, ppSecurityDescriptor)
}
struct IADsLargeInteger extends IDispatch {
    static IID := "{9068270B-0939-11D1-8BE1-00C04FD8D503}"
    get_HighPart(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_HighPart(lnHighPart)
      => ComCall(8, this.p, Int32, lnHighPart)
    get_LowPart(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_LowPart(lnLowPart)
      => ComCall(10, this.p, Int32, lnLowPart)
}
struct IADsNameTranslate extends IDispatch {
    static IID := "{B1B272A3-3625-11D1-A3A4-00C04FB950DC}"
    put_ChaseReferral(lnChaseReferral)
      => ComCall(7, this.p, Int32, lnChaseReferral)
    Init(lnSetType, bstrADsPath)
      => ComCall(8, this.p, Int32, lnSetType, BSTR, bstrADsPath)
    InitEx(lnSetType, bstrADsPath, bstrUserID, bstrDomain, bstrPassword)
      => ComCall(9, this.p, Int32, lnSetType, BSTR, bstrADsPath, BSTR, bstrUserID, BSTR, bstrDomain, BSTR, bstrPassword)
    Set(lnSetType, bstrADsPath)
      => ComCall(10, this.p, Int32, lnSetType, BSTR, bstrADsPath)
    Get(lnFormatType, pbstrADsPath)
      => ComCall(11, this.p, Int32, lnFormatType, BSTR.Ptr, pbstrADsPath)
    SetEx(lnFormatType, pvar)
      => ComCall(12, this.p, Int32, lnFormatType, VARIANT, pvar)
    GetEx(lnFormatType, pvar)
      => ComCall(13, this.p, Int32, lnFormatType, VARIANT.Ptr, pvar)
}
struct IADsCaseIgnoreList extends IDispatch {
    static IID := "{7B66B533-4680-11D1-A3B4-00C04FB950DC}"
    get_CaseIgnoreList(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    put_CaseIgnoreList(vCaseIgnoreList)
      => ComCall(8, this.p, VARIANT, vCaseIgnoreList)
}
struct IADsFaxNumber extends IDispatch {
    static IID := "{A910DEA9-4680-11D1-A3B4-00C04FB950DC}"
    get_TelephoneNumber(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_TelephoneNumber(bstrTelephoneNumber)
      => ComCall(8, this.p, BSTR, bstrTelephoneNumber)
    get_Parameters(retval)
      => ComCall(9, this.p, VARIANT.Ptr, retval)
    put_Parameters(vParameters)
      => ComCall(10, this.p, VARIANT, vParameters)
}
struct IADsNetAddress extends IDispatch {
    static IID := "{B21A50A9-4080-11D1-A3AC-00C04FB950DC}"
    get_AddressType(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_AddressType(lnAddressType)
      => ComCall(8, this.p, Int32, lnAddressType)
    get_Address(retval)
      => ComCall(9, this.p, VARIANT.Ptr, retval)
    put_Address(vAddress)
      => ComCall(10, this.p, VARIANT, vAddress)
}
struct IADsOctetList extends IDispatch {
    static IID := "{7B28B80F-4680-11D1-A3B4-00C04FB950DC}"
    get_OctetList(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    put_OctetList(vOctetList)
      => ComCall(8, this.p, VARIANT, vOctetList)
}
struct IADsEmail extends IDispatch {
    static IID := "{97AF011A-478E-11D1-A3B4-00C04FB950DC}"
    get_Type(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_Type(lnType)
      => ComCall(8, this.p, Int32, lnType)
    get_Address(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_Address(bstrAddress)
      => ComCall(10, this.p, BSTR, bstrAddress)
}
struct IADsPath extends IDispatch {
    static IID := "{B287FCD5-4080-11D1-A3AC-00C04FB950DC}"
    get_Type(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_Type(lnType)
      => ComCall(8, this.p, Int32, lnType)
    get_VolumeName(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_VolumeName(bstrVolumeName)
      => ComCall(10, this.p, BSTR, bstrVolumeName)
    get_Path(retval)
      => ComCall(11, this.p, BSTR.Ptr, retval)
    put_Path(bstrPath)
      => ComCall(12, this.p, BSTR, bstrPath)
}
struct IADsReplicaPointer extends IDispatch {
    static IID := "{F60FB803-4080-11D1-A3AC-00C04FB950DC}"
    get_ServerName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ServerName(bstrServerName)
      => ComCall(8, this.p, BSTR, bstrServerName)
    get_ReplicaType(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_ReplicaType(lnReplicaType)
      => ComCall(10, this.p, Int32, lnReplicaType)
    get_ReplicaNumber(retval)
      => ComCall(11, this.p, Int32.Ptr, retval)
    put_ReplicaNumber(lnReplicaNumber)
      => ComCall(12, this.p, Int32, lnReplicaNumber)
    get_Count(retval)
      => ComCall(13, this.p, Int32.Ptr, retval)
    put_Count(lnCount)
      => ComCall(14, this.p, Int32, lnCount)
    get_ReplicaAddressHints(retval)
      => ComCall(15, this.p, VARIANT.Ptr, retval)
    put_ReplicaAddressHints(vReplicaAddressHints)
      => ComCall(16, this.p, VARIANT, vReplicaAddressHints)
}
struct IADsAcl extends IDispatch {
    static IID := "{8452D3AB-0869-11D1-A377-00C04FB950DC}"
    get_ProtectedAttrName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ProtectedAttrName(bstrProtectedAttrName)
      => ComCall(8, this.p, BSTR, bstrProtectedAttrName)
    get_SubjectName(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_SubjectName(bstrSubjectName)
      => ComCall(10, this.p, BSTR, bstrSubjectName)
    get_Privileges(retval)
      => ComCall(11, this.p, Int32.Ptr, retval)
    put_Privileges(lnPrivileges)
      => ComCall(12, this.p, Int32, lnPrivileges)
    CopyAcl(ppAcl)
      => ComCall(13, this.p, IDispatch.Ptr, ppAcl)
}
struct IADsTimestamp extends IDispatch {
    static IID := "{B2F5A901-4080-11D1-A3AC-00C04FB950DC}"
    get_WholeSeconds(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_WholeSeconds(lnWholeSeconds)
      => ComCall(8, this.p, Int32, lnWholeSeconds)
    get_EventID(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_EventID(lnEventID)
      => ComCall(10, this.p, Int32, lnEventID)
}
struct IADsPostalAddress extends IDispatch {
    static IID := "{7ADECF29-4680-11D1-A3B4-00C04FB950DC}"
    get_PostalAddress(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    put_PostalAddress(vPostalAddress)
      => ComCall(8, this.p, VARIANT, vPostalAddress)
}
struct IADsBackLink extends IDispatch {
    static IID := "{FD1302BD-4080-11D1-A3AC-00C04FB950DC}"
    get_RemoteID(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    put_RemoteID(lnRemoteID)
      => ComCall(8, this.p, Int32, lnRemoteID)
    get_ObjectName(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_ObjectName(bstrObjectName)
      => ComCall(10, this.p, BSTR, bstrObjectName)
}
struct IADsTypedName extends IDispatch {
    static IID := "{B371A349-4080-11D1-A3AC-00C04FB950DC}"
    get_ObjectName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ObjectName(bstrObjectName)
      => ComCall(8, this.p, BSTR, bstrObjectName)
    get_Level(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_Level(lnLevel)
      => ComCall(10, this.p, Int32, lnLevel)
    get_Interval(retval)
      => ComCall(11, this.p, Int32.Ptr, retval)
    put_Interval(lnInterval)
      => ComCall(12, this.p, Int32, lnInterval)
}
struct IADsHold extends IDispatch {
    static IID := "{B3EB3B37-4080-11D1-A3AC-00C04FB950DC}"
    get_ObjectName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ObjectName(bstrObjectName)
      => ComCall(8, this.p, BSTR, bstrObjectName)
    get_Amount(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    put_Amount(lnAmount)
      => ComCall(10, this.p, Int32, lnAmount)
}
struct IADsObjectOptions extends IDispatch {
    static IID := "{46F14FDA-232B-11D1-A808-00C04FD8D5A8}"
    GetOption(lnOption, pvValue)
      => ComCall(7, this.p, Int32, lnOption, VARIANT.Ptr, pvValue)
    SetOption(lnOption, vValue)
      => ComCall(8, this.p, Int32, lnOption, VARIANT, vValue)
}
struct IADsPathname extends IDispatch {
    static IID := "{D592AED4-F420-11D0-A36E-00C04FB950DC}"
    Set(bstrADsPath, lnSetType)
      => ComCall(7, this.p, BSTR, bstrADsPath, Int32, lnSetType)
    SetDisplayType(lnDisplayType)
      => ComCall(8, this.p, Int32, lnDisplayType)
    Retrieve(lnFormatType, pbstrADsPath)
      => ComCall(9, this.p, Int32, lnFormatType, BSTR.Ptr, pbstrADsPath)
    GetNumElements(plnNumPathElements)
      => ComCall(10, this.p, Int32.Ptr, plnNumPathElements)
    GetElement(lnElementIndex, pbstrElement)
      => ComCall(11, this.p, Int32, lnElementIndex, BSTR.Ptr, pbstrElement)
    AddLeafElement(bstrLeafElement)
      => ComCall(12, this.p, BSTR, bstrLeafElement)
    RemoveLeafElement()
      => ComCall(13, this.p)
    CopyPath(ppAdsPath)
      => ComCall(14, this.p, IDispatch.Ptr, ppAdsPath)
    GetEscapedElement(lnReserved, bstrInStr, pbstrOutStr)
      => ComCall(15, this.p, Int32, lnReserved, BSTR, bstrInStr, BSTR.Ptr, pbstrOutStr)
    get_EscapedMode(retval)
      => ComCall(16, this.p, Int32.Ptr, retval)
    put_EscapedMode(lnEscapedMode)
      => ComCall(17, this.p, Int32, lnEscapedMode)
}
struct IADsADSystemInfo extends IDispatch {
    static IID := "{5BB11929-AFD1-11D2-9CB9-0000F87A369E}"
    get_UserName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_ComputerName(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_SiteName(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    get_DomainShortName(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
    get_DomainDNSName(retval)
      => ComCall(11, this.p, BSTR.Ptr, retval)
    get_ForestDNSName(retval)
      => ComCall(12, this.p, BSTR.Ptr, retval)
    get_PDCRoleOwner(retval)
      => ComCall(13, this.p, BSTR.Ptr, retval)
    get_SchemaRoleOwner(retval)
      => ComCall(14, this.p, BSTR.Ptr, retval)
    get_IsNativeMode(retval)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, retval)
    GetAnyDCName(pszDCName)
      => ComCall(16, this.p, BSTR.Ptr, pszDCName)
    GetDCSiteName(szServer, pszSiteName)
      => ComCall(17, this.p, BSTR, szServer, BSTR.Ptr, pszSiteName)
    RefreshSchemaCache()
      => ComCall(18, this.p)
    GetTrees(pvTrees)
      => ComCall(19, this.p, VARIANT.Ptr, pvTrees)
}
struct IADsWinNTSystemInfo extends IDispatch {
    static IID := "{6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}"
    get_UserName(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_ComputerName(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_DomainName(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    get_PDC(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
}
struct IADsDNWithBinary extends IDispatch {
    static IID := "{7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}"
    get_BinaryValue(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    put_BinaryValue(vBinaryValue)
      => ComCall(8, this.p, VARIANT, vBinaryValue)
    get_DNString(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_DNString(bstrDNString)
      => ComCall(10, this.p, BSTR, bstrDNString)
}
struct IADsDNWithString extends IDispatch {
    static IID := "{370DF02E-F934-11D2-BA96-00C04FB6D0D1}"
    get_StringValue(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_StringValue(bstrStringValue)
      => ComCall(8, this.p, BSTR, bstrStringValue)
    get_DNString(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_DNString(bstrDNString)
      => ComCall(10, this.p, BSTR, bstrDNString)
}
struct IADsSecurityUtility extends IDispatch {
    static IID := "{A63251B2-5F21-474B-AB52-4A8EFAD10895}"
    GetSecurityDescriptor(varPath, lPathFormat, lFormat, pVariant)
      => ComCall(7, this.p, VARIANT, varPath, Int32, lPathFormat, Int32, lFormat, VARIANT.Ptr, pVariant)
    SetSecurityDescriptor(varPath, lPathFormat, varData, lDataFormat)
      => ComCall(8, this.p, VARIANT, varPath, Int32, lPathFormat, VARIANT, varData, Int32, lDataFormat)
    ConvertSecurityDescriptor(varSD, lDataFormat, lOutFormat, pResult)
      => ComCall(9, this.p, VARIANT, varSD, Int32, lDataFormat, Int32, lOutFormat, VARIANT.Ptr, pResult)
    get_SecurityMask(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
    put_SecurityMask(lnSecurityMask)
      => ComCall(11, this.p, Int32, lnSecurityMask)
}
struct DSOBJECT {
    dwFlags : UInt32
    dwProviderFlags : UInt32
    offsetName : UInt32
    offsetClass : UInt32
}
struct DSOBJECTNAMES {
    clsidNamespace : GUID
    cItems : UInt32
    aObjects : DSOBJECT[1]
}
struct DSDISPLAYSPECOPTIONS {
    dwSize : UInt32
    dwFlags : UInt32
    offsetAttribPrefix : UInt32
    offsetUserName : UInt32
    offsetPassword : UInt32
    offsetServer : UInt32
    offsetServerConfigPath : UInt32
}
struct DSPROPERTYPAGEINFO {
    offsetString : UInt32
}
struct DOMAINDESC {
    pszName : PWSTR
    pszPath : PWSTR
    pszNCName : PWSTR
    pszTrustParent : PWSTR
    pszObjectClass : PWSTR
    ulFlags : UInt32
    fDownLevel : BOOL
    pdChildList : DOMAINDESC.Ptr
    pdNextSibling : DOMAINDESC.Ptr
}
struct DOMAIN_TREE {
    dsSize : UInt32
    dwCount : UInt32
    aDomains : DOMAINDESC[1]
}
struct IDsBrowseDomainTree extends IUnknown {
    static IID := "{7CABCF1E-78F5-11D2-960C-00C04FA31A86}"
    BrowseTo(hwndParent, ppszTargetPath, dwFlags)
      => ComCall(3, this.p, HWND, hwndParent, PWSTR.Ptr, ppszTargetPath, UInt32, dwFlags)
    GetDomains(ppDomainTree, dwFlags)
      => ComCall(4, this.p, DOMAIN_TREE.Ptr.Ptr, ppDomainTree, UInt32, dwFlags)
    FreeDomains(ppDomainTree)
      => ComCall(5, this.p, DOMAIN_TREE.Ptr.Ptr, ppDomainTree)
    FlushCachedDomains()
      => ComCall(6, this.p)
    SetComputer(pszComputerName, pszUserName, pszPassword)
      => ComCall(7, this.p, "Str", pszComputerName, "Str", pszUserName, "Str", pszPassword)
}
struct LPDSENUMATTRIBUTES extends FunctionPointer {
    static Types := [LPARAM, PWSTR, PWSTR, UInt32, HRESULT]
}
struct DSCLASSCREATIONINFO {
    dwFlags : UInt32
    clsidWizardDialog : GUID
    clsidWizardPrimaryPage : GUID
    cWizardExtensions : UInt32
    aWizardExtensions : GUID[1]
}
struct IDsDisplaySpecifier extends IUnknown {
    static IID := "{1AB4A8C0-6A0B-11D2-AD49-00C04FA31A86}"
    SetServer(pszServer, pszUserName, pszPassword, dwFlags)
      => ComCall(3, this.p, "Str", pszServer, "Str", pszUserName, "Str", pszPassword, UInt32, dwFlags)
    SetLanguageID(langid)
      => ComCall(4, this.p, UInt16, langid)
    GetDisplaySpecifier(pszObjectClass, riid, ppv)
      => ComCall(5, this.p, "Str", pszObjectClass, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetIconLocation(pszObjectClass, dwFlags, pszBuffer, presid)
      => ComCall(6, this.p, "Str", pszObjectClass, UInt32, dwFlags, PWSTR, pszBuffer, Int32, pszBuffer.Length, Int32.Ptr, presid)
    GetIcon(pszObjectClass, dwFlags, cxIcon, cyIcon)
      => ComCall(7, this.p, "Str", pszObjectClass, UInt32, dwFlags, Int32, cxIcon, Int32, cyIcon, HICON)
    GetFriendlyClassName(pszObjectClass, pszBuffer)
      => ComCall(8, this.p, "Str", pszObjectClass, PWSTR, pszBuffer, Int32, pszBuffer.Length)
    GetFriendlyAttributeName(pszObjectClass, pszAttributeName, pszBuffer)
      => ComCall(9, this.p, "Str", pszObjectClass, "Str", pszAttributeName, PWSTR, pszBuffer, UInt32, pszBuffer.Length)
    IsClassContainer(pszObjectClass, pszADsPath, dwFlags)
      => ComCall(10, this.p, "Str", pszObjectClass, "Str", pszADsPath, UInt32, dwFlags, BOOL)
    GetClassCreationInfo(pszObjectClass, ppdscci)
      => ComCall(11, this.p, "Str", pszObjectClass, DSCLASSCREATIONINFO.Ptr.Ptr, ppdscci)
    EnumClassAttributes(pszObjectClass, pcbEnum, lParam1)
      => ComCall(12, this.p, "Str", pszObjectClass, LPDSENUMATTRIBUTES, pcbEnum, LPARAM, lParam1)
    GetAttributeADsType(pszAttributeName)
      => ComCall(13, this.p, "Str", pszAttributeName, ADSTYPE)
}
struct DSBROWSEINFOW {
    cbStruct : UInt32
    hwndOwner : HWND
    pszCaption : PWSTR
    pszTitle : PWSTR
    pszRoot : PWSTR
    pszPath : PWSTR
    cchPath : UInt32
    dwFlags : UInt32
    pfnCallback : BFFCALLBACK
    lParam : LPARAM
    dwReturnFormat : UInt32
    pUserName : PWSTR
    pPassword : PWSTR
    pszObjectClass : PWSTR
    cchObjectClass : UInt32
}
struct DSBROWSEINFOA {
    cbStruct : UInt32
    hwndOwner : HWND
    pszCaption : PSTR
    pszTitle : PSTR
    pszRoot : PWSTR
    pszPath : PWSTR
    cchPath : UInt32
    dwFlags : UInt32
    pfnCallback : BFFCALLBACK
    lParam : LPARAM
    dwReturnFormat : UInt32
    pUserName : PWSTR
    pPassword : PWSTR
    pszObjectClass : PWSTR
    cchObjectClass : UInt32
}
struct DSBITEMW {
    cbStruct : UInt32
    pszADsPath : PWSTR
    pszClass : PWSTR
    dwMask : UInt32
    dwState : UInt32
    dwStateMask : UInt32
    szDisplayName : UInt16[64]
    szIconLocation : UInt16[260]
    iIconResID : Int32
}
struct DSBITEMA {
    cbStruct : UInt32
    pszADsPath : PWSTR
    pszClass : PWSTR
    dwMask : UInt32
    dwState : UInt32
    dwStateMask : UInt32
    szDisplayName : CHAR[64]
    szIconLocation : CHAR[260]
    iIconResID : Int32
}
struct DSOP_UPLEVEL_FILTER_FLAGS {
    flBothModes : UInt32
    flMixedModeOnly : UInt32
    flNativeModeOnly : UInt32
}
struct DSOP_FILTER_FLAGS {
    Uplevel : DSOP_UPLEVEL_FILTER_FLAGS
    flDownlevel : UInt32
}
struct DSOP_SCOPE_INIT_INFO {
    cbSize : UInt32 := this.Size
    flType : UInt32
    flScope : UInt32
    FilterFlags : DSOP_FILTER_FLAGS
    pwzDcName : PWSTR
    pwzADsPath : PWSTR
    hr : HRESULT
}
struct DSOP_INIT_INFO {
    cbSize : UInt32 := this.Size
    pwzTargetComputer : PWSTR
    cDsScopeInfos : UInt32
    aDsScopeInfos : DSOP_SCOPE_INIT_INFO.Ptr
    flOptions : UInt32
    cAttributesToFetch : UInt32
    apwzAttributeNames : PWSTR.Ptr
}
struct DS_SELECTION {
    pwzName : PWSTR
    pwzADsPath : PWSTR
    pwzClass : PWSTR
    pwzUPN : PWSTR
    pvarFetchedAttributes : VARIANT.Ptr
    flScopeType : UInt32
}
struct DS_SELECTION_LIST {
    cItems : UInt32
    cFetchedAttributes : UInt32
    aDsSelection : DS_SELECTION[1]
}
struct IDsObjectPicker extends IUnknown {
    static IID := "{0C87E64E-3B7A-11D2-B9E0-00C04FD8DBF7}"
    Initialize(pInitInfo)
      => ComCall(3, this.p, DSOP_INIT_INFO.Ptr, pInitInfo)
    InvokeDialog(hwndParent, ppdoSelections)
      => ComCall(4, this.p, HWND, hwndParent, IDataObject.Ptr, ppdoSelections)
}
struct IDsObjectPickerCredentials extends IDsObjectPicker {
    static IID := "{E2D3EC9B-D041-445A-8F16-4748DE8FB1CF}"
    SetCredentials(szUserName, szPassword)
      => ComCall(5, this.p, "Str", szUserName, "Str", szPassword)
}
struct DSQUERYINITPARAMS {
    cbStruct : UInt32
    dwFlags : UInt32
    pDefaultScope : PWSTR
    pDefaultSaveLocation : PWSTR
    pUserName : PWSTR
    pPassword : PWSTR
    pServer : PWSTR
}
struct DSCOLUMN {
    dwFlags : UInt32
    fmt : Int32
    cx : Int32
    idsName : Int32
    offsetProperty : Int32
    dwReserved : UInt32
}
struct DSQUERYPARAMS {
    cbStruct : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    offsetQuery : Int32
    iColumns : Int32
    dwReserved : UInt32
    aColumns : DSCOLUMN[1]
}
struct DSQUERYCLASSLIST {
    cbStruct : UInt32
    cClasses : Int32
    offsetClass : UInt32[1]
}
struct IDsAdminCreateObj extends IUnknown {
    static IID := "{53554A38-F902-11D2-82B9-00C04F68928B}"
    Initialize(pADsContainerObj, pADsCopySource, lpszClassName)
      => ComCall(3, this.p, IADsContainer, pADsContainerObj, IADs, pADsCopySource, "Str", lpszClassName)
    CreateModal(hwndParent, ppADsObj)
      => ComCall(4, this.p, HWND, hwndParent, IADs.Ptr, ppADsObj)
}
struct IDsAdminNewObj extends IUnknown {
    static IID := "{F2573587-E6FC-11D2-82AF-00C04F68928B}"
    SetButtons(nCurrIndex, bValid)
      => ComCall(3, this.p, UInt32, nCurrIndex, BOOL, bValid)
    GetPageCounts(pnTotal, pnStartIndex)
      => ComCall(4, this.p, Int32.Ptr, pnTotal, Int32.Ptr, pnStartIndex)
}
struct IDsAdminNewObjPrimarySite extends IUnknown {
    static IID := "{BE2B487E-F904-11D2-82B9-00C04F68928B}"
    CreateNew(pszName)
      => ComCall(3, this.p, "Str", pszName)
    Commit()
      => ComCall(4, this.p)
}
struct DSA_NEWOBJ_DISPINFO {
    dwSize : UInt32
    hObjClassIcon : HICON
    lpszWizTitle : PWSTR
    lpszContDisplayName : PWSTR
}
struct IDsAdminNewObjExt extends IUnknown {
    static IID := "{6088EAE2-E7BF-11D2-82AF-00C04F68928B}"
    Initialize(pADsContainerObj, pADsCopySource, lpszClassName, pDsAdminNewObj, pDispInfo)
      => ComCall(3, this.p, IADsContainer, pADsContainerObj, IADs, pADsCopySource, "Str", lpszClassName, IDsAdminNewObj, pDsAdminNewObj, DSA_NEWOBJ_DISPINFO.Ptr, pDispInfo)
    AddPages(lpfnAddPage, lParam1)
      => ComCall(4, this.p, LPFNSVADDPROPSHEETPAGE, lpfnAddPage, LPARAM, lParam1)
    SetObject(pADsObj)
      => ComCall(5, this.p, IADs, pADsObj)
    WriteData(hWnd1, uContext)
      => ComCall(6, this.p, HWND, hWnd1, UInt32, uContext)
    OnError(hWnd1, hr, uContext)
      => ComCall(7, this.p, HWND, hWnd1, HRESULT, hr, UInt32, uContext)
    GetSummaryInfo(pBstrText)
      => ComCall(8, this.p, BSTR.Ptr, pBstrText)
}
struct IDsAdminNotifyHandler extends IUnknown {
    static IID := "{E4A2B8B3-5A18-11D2-97C1-00A0C9A06D2D}"
    Initialize(pExtraInfo, puEventFlags)
      => ComCall(3, this.p, IDataObject, pExtraInfo, UInt32.Ptr, puEventFlags)
    Begin(uEvent, pArg1, pArg2, puFlags, pBstr)
      => ComCall(4, this.p, UInt32, uEvent, IDataObject, pArg1, IDataObject, pArg2, UInt32.Ptr, puFlags, BSTR.Ptr, pBstr)
    Notify(nItem, uFlags)
      => ComCall(5, this.p, UInt32, nItem, UInt32, uFlags)
    End()
      => ComCall(6, this.p)
}
struct ADSPROPINITPARAMS {
    dwSize : UInt32
    dwFlags : UInt32
    hr : HRESULT
    pDsObj : IDirectoryObject
    pwzCN : PWSTR
    pWritableAttrs : ADS_ATTR_INFO.Ptr
}
struct ADSPROPERROR {
    hwndPage : HWND
    pszPageTitle : PWSTR
    pszObjPath : PWSTR
    pszObjClass : PWSTR
    hr : HRESULT
    pszError : PWSTR
}
struct SCHEDULE_HEADER {
    Type : UInt32
    Offset : UInt32
}
struct SCHEDULE {
    Size : UInt32
    Bandwidth : UInt32
    NumberOfSchedules : UInt32
    Schedules : SCHEDULE_HEADER[1]
}
struct DS_MANGLE_FOR extends Int32 {
    static DS_MANGLE_UNKNOWN := 0
    static DS_MANGLE_OBJECT_RDN_FOR_DELETION := 1
    static DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT := 2
}
struct DS_NAME_FORMAT extends Int32 {
    static DS_UNKNOWN_NAME := 0
    static DS_FQDN_1779_NAME := 1
    static DS_NT4_ACCOUNT_NAME := 2
    static DS_DISPLAY_NAME := 3
    static DS_UNIQUE_ID_NAME := 6
    static DS_CANONICAL_NAME := 7
    static DS_USER_PRINCIPAL_NAME := 8
    static DS_CANONICAL_NAME_EX := 9
    static DS_SERVICE_PRINCIPAL_NAME := 10
    static DS_SID_OR_SID_HISTORY_NAME := 11
    static DS_DNS_DOMAIN_NAME := 12
}
struct DS_NAME_FLAGS extends Int32 {
    static DS_NAME_NO_FLAGS := 0
    static DS_NAME_FLAG_SYNTACTICAL_ONLY := 1
    static DS_NAME_FLAG_EVAL_AT_DC := 2
    static DS_NAME_FLAG_GCVERIFY := 4
    static DS_NAME_FLAG_TRUST_REFERRAL := 8
}
struct DS_NAME_ERROR extends Int32 {
    static DS_NAME_NO_ERROR := 0
    static DS_NAME_ERROR_RESOLVING := 1
    static DS_NAME_ERROR_NOT_FOUND := 2
    static DS_NAME_ERROR_NOT_UNIQUE := 3
    static DS_NAME_ERROR_NO_MAPPING := 4
    static DS_NAME_ERROR_DOMAIN_ONLY := 5
    static DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING := 6
    static DS_NAME_ERROR_TRUST_REFERRAL := 7
}
struct DS_SPN_NAME_TYPE extends Int32 {
    static DS_SPN_DNS_HOST := 0
    static DS_SPN_DN_HOST := 1
    static DS_SPN_NB_HOST := 2
    static DS_SPN_DOMAIN := 3
    static DS_SPN_NB_DOMAIN := 4
    static DS_SPN_SERVICE := 5
}
struct DS_SPN_WRITE_OP extends Int32 {
    static DS_SPN_ADD_SPN_OP := 0
    static DS_SPN_REPLACE_SPN_OP := 1
    static DS_SPN_DELETE_SPN_OP := 2
}
struct DS_NAME_RESULT_ITEMA {
    status : UInt32
    pDomain : PSTR
    pName : PSTR
}
struct DS_NAME_RESULTA {
    cItems : UInt32
    rItems : DS_NAME_RESULT_ITEMA.Ptr
}
struct DS_NAME_RESULT_ITEMW {
    status : UInt32
    pDomain : PWSTR
    pName : PWSTR
}
struct DS_NAME_RESULTW {
    cItems : UInt32
    rItems : DS_NAME_RESULT_ITEMW.Ptr
}
struct DS_REPSYNCALL_ERROR extends Int32 {
    static DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER := 0
    static DS_REPSYNCALL_WIN32_ERROR_REPLICATING := 1
    static DS_REPSYNCALL_SERVER_UNREACHABLE := 2
}
struct DS_REPSYNCALL_EVENT extends Int32 {
    static DS_REPSYNCALL_EVENT_ERROR := 0
    static DS_REPSYNCALL_EVENT_SYNC_STARTED := 1
    static DS_REPSYNCALL_EVENT_SYNC_COMPLETED := 2
    static DS_REPSYNCALL_EVENT_FINISHED := 3
}
struct DS_REPSYNCALL_SYNCA {
    pszSrcId : PSTR
    pszDstId : PSTR
    pszNC : PSTR
    pguidSrc : GUID.Ptr
    pguidDst : GUID.Ptr
}
struct DS_REPSYNCALL_SYNCW {
    pszSrcId : PWSTR
    pszDstId : PWSTR
    pszNC : PWSTR
    pguidSrc : GUID.Ptr
    pguidDst : GUID.Ptr
}
struct DS_REPSYNCALL_ERRINFOA {
    pszSvrId : PSTR
    error : DS_REPSYNCALL_ERROR
    dwWin32Err : UInt32
    pszSrcId : PSTR
}
struct DS_REPSYNCALL_ERRINFOW {
    pszSvrId : PWSTR
    error : DS_REPSYNCALL_ERROR
    dwWin32Err : UInt32
    pszSrcId : PWSTR
}
struct DS_REPSYNCALL_UPDATEA {
    event : DS_REPSYNCALL_EVENT
    pErrInfo : DS_REPSYNCALL_ERRINFOA.Ptr
    pSync : DS_REPSYNCALL_SYNCA.Ptr
}
struct DS_REPSYNCALL_UPDATEW {
    event : DS_REPSYNCALL_EVENT
    pErrInfo : DS_REPSYNCALL_ERRINFOW.Ptr
    pSync : DS_REPSYNCALL_SYNCW.Ptr
}
struct DS_SITE_COST_INFO {
    errorCode : UInt32
    cost : UInt32
}
struct DS_SCHEMA_GUID_MAPA {
    guid : GUID
    guidType : UInt32
    pName : PSTR
}
struct DS_SCHEMA_GUID_MAPW {
    guid : GUID
    guidType : UInt32
    pName : PWSTR
}
struct DS_DOMAIN_CONTROLLER_INFO_1A {
    NetbiosName : PSTR
    DnsHostName : PSTR
    SiteName : PSTR
    ComputerObjectName : PSTR
    ServerObjectName : PSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
}
struct DS_DOMAIN_CONTROLLER_INFO_1W {
    NetbiosName : PWSTR
    DnsHostName : PWSTR
    SiteName : PWSTR
    ComputerObjectName : PWSTR
    ServerObjectName : PWSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
}
struct DS_DOMAIN_CONTROLLER_INFO_2A {
    NetbiosName : PSTR
    DnsHostName : PSTR
    SiteName : PSTR
    SiteObjectName : PSTR
    ComputerObjectName : PSTR
    ServerObjectName : PSTR
    NtdsDsaObjectName : PSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
    fIsGc : BOOL
    SiteObjectGuid : GUID
    ComputerObjectGuid : GUID
    ServerObjectGuid : GUID
    NtdsDsaObjectGuid : GUID
}
struct DS_DOMAIN_CONTROLLER_INFO_2W {
    NetbiosName : PWSTR
    DnsHostName : PWSTR
    SiteName : PWSTR
    SiteObjectName : PWSTR
    ComputerObjectName : PWSTR
    ServerObjectName : PWSTR
    NtdsDsaObjectName : PWSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
    fIsGc : BOOL
    SiteObjectGuid : GUID
    ComputerObjectGuid : GUID
    ServerObjectGuid : GUID
    NtdsDsaObjectGuid : GUID
}
struct DS_DOMAIN_CONTROLLER_INFO_3A {
    NetbiosName : PSTR
    DnsHostName : PSTR
    SiteName : PSTR
    SiteObjectName : PSTR
    ComputerObjectName : PSTR
    ServerObjectName : PSTR
    NtdsDsaObjectName : PSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
    fIsGc : BOOL
    fIsRodc : BOOL
    SiteObjectGuid : GUID
    ComputerObjectGuid : GUID
    ServerObjectGuid : GUID
    NtdsDsaObjectGuid : GUID
}
struct DS_DOMAIN_CONTROLLER_INFO_3W {
    NetbiosName : PWSTR
    DnsHostName : PWSTR
    SiteName : PWSTR
    SiteObjectName : PWSTR
    ComputerObjectName : PWSTR
    ServerObjectName : PWSTR
    NtdsDsaObjectName : PWSTR
    fIsPdc : BOOL
    fDsEnabled : BOOL
    fIsGc : BOOL
    fIsRodc : BOOL
    SiteObjectGuid : GUID
    ComputerObjectGuid : GUID
    ServerObjectGuid : GUID
    NtdsDsaObjectGuid : GUID
}
struct DS_KCC_TASKID extends Int32 {
    static DS_KCC_TASKID_UPDATE_TOPOLOGY := 0
}
struct DS_REPL_INFO_TYPE extends Int32 {
    static DS_REPL_INFO_NEIGHBORS := 0
    static DS_REPL_INFO_CURSORS_FOR_NC := 1
    static DS_REPL_INFO_METADATA_FOR_OBJ := 2
    static DS_REPL_INFO_KCC_DSA_CONNECT_FAILURES := 3
    static DS_REPL_INFO_KCC_DSA_LINK_FAILURES := 4
    static DS_REPL_INFO_PENDING_OPS := 5
    static DS_REPL_INFO_METADATA_FOR_ATTR_VALUE := 6
    static DS_REPL_INFO_CURSORS_2_FOR_NC := 7
    static DS_REPL_INFO_CURSORS_3_FOR_NC := 8
    static DS_REPL_INFO_METADATA_2_FOR_OBJ := 9
    static DS_REPL_INFO_METADATA_2_FOR_ATTR_VALUE := 10
    static DS_REPL_INFO_METADATA_EXT_FOR_ATTR_VALUE := 11
    static DS_REPL_INFO_TYPE_MAX := 12
}
struct DS_REPL_NEIGHBORW {
    pszNamingContext : PWSTR
    pszSourceDsaDN : PWSTR
    pszSourceDsaAddress : PWSTR
    pszAsyncIntersiteTransportDN : PWSTR
    dwReplicaFlags : UInt32
    dwReserved : UInt32
    uuidNamingContextObjGuid : GUID
    uuidSourceDsaObjGuid : GUID
    uuidSourceDsaInvocationID : GUID
    uuidAsyncIntersiteTransportObjGuid : GUID
    usnLastObjChangeSynced : Int64
    usnAttributeFilter : Int64
    ftimeLastSyncSuccess : FILETIME
    ftimeLastSyncAttempt : FILETIME
    dwLastSyncResult : UInt32
    cNumConsecutiveSyncFailures : UInt32
}
struct DS_REPL_NEIGHBORW_BLOB {
    oszNamingContext : UInt32
    oszSourceDsaDN : UInt32
    oszSourceDsaAddress : UInt32
    oszAsyncIntersiteTransportDN : UInt32
    dwReplicaFlags : UInt32
    dwReserved : UInt32
    uuidNamingContextObjGuid : GUID
    uuidSourceDsaObjGuid : GUID
    uuidSourceDsaInvocationID : GUID
    uuidAsyncIntersiteTransportObjGuid : GUID
    usnLastObjChangeSynced : Int64
    usnAttributeFilter : Int64
    ftimeLastSyncSuccess : FILETIME
    ftimeLastSyncAttempt : FILETIME
    dwLastSyncResult : UInt32
    cNumConsecutiveSyncFailures : UInt32
}
struct DS_REPL_NEIGHBORSW {
    cNumNeighbors : UInt32
    dwReserved : UInt32
    rgNeighbor : DS_REPL_NEIGHBORW[1]
}
struct DS_REPL_CURSOR {
    uuidSourceDsaInvocationID : GUID
    usnAttributeFilter : Int64
}
struct DS_REPL_CURSOR_2 {
    uuidSourceDsaInvocationID : GUID
    usnAttributeFilter : Int64
    ftimeLastSyncSuccess : FILETIME
}
struct DS_REPL_CURSOR_3W {
    uuidSourceDsaInvocationID : GUID
    usnAttributeFilter : Int64
    ftimeLastSyncSuccess : FILETIME
    pszSourceDsaDN : PWSTR
}
struct DS_REPL_CURSOR_BLOB {
    uuidSourceDsaInvocationID : GUID
    usnAttributeFilter : Int64
    ftimeLastSyncSuccess : FILETIME
    oszSourceDsaDN : UInt32
}
struct DS_REPL_CURSORS {
    cNumCursors : UInt32
    dwReserved : UInt32
    rgCursor : DS_REPL_CURSOR[1]
}
struct DS_REPL_CURSORS_2 {
    cNumCursors : UInt32
    dwEnumerationContext : UInt32
    rgCursor : DS_REPL_CURSOR_2[1]
}
struct DS_REPL_CURSORS_3W {
    cNumCursors : UInt32
    dwEnumerationContext : UInt32
    rgCursor : DS_REPL_CURSOR_3W[1]
}
struct DS_REPL_ATTR_META_DATA {
    pszAttributeName : PWSTR
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
}
struct DS_REPL_ATTR_META_DATA_2 {
    pszAttributeName : PWSTR
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    pszLastOriginatingDsaDN : PWSTR
}
struct DS_REPL_ATTR_META_DATA_BLOB {
    oszAttributeName : UInt32
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    oszLastOriginatingDsaDN : UInt32
}
struct DS_REPL_OBJ_META_DATA {
    cNumEntries : UInt32
    dwReserved : UInt32
    rgMetaData : DS_REPL_ATTR_META_DATA[1]
}
struct DS_REPL_OBJ_META_DATA_2 {
    cNumEntries : UInt32
    dwReserved : UInt32
    rgMetaData : DS_REPL_ATTR_META_DATA_2[1]
}
struct DS_REPL_KCC_DSA_FAILUREW {
    pszDsaDN : PWSTR
    uuidDsaObjGuid : GUID
    ftimeFirstFailure : FILETIME
    cNumFailures : UInt32
    dwLastResult : UInt32
}
struct DS_REPL_KCC_DSA_FAILUREW_BLOB {
    oszDsaDN : UInt32
    uuidDsaObjGuid : GUID
    ftimeFirstFailure : FILETIME
    cNumFailures : UInt32
    dwLastResult : UInt32
}
struct DS_REPL_KCC_DSA_FAILURESW {
    cNumEntries : UInt32
    dwReserved : UInt32
    rgDsaFailure : DS_REPL_KCC_DSA_FAILUREW[1]
}
struct DS_REPL_OP_TYPE extends Int32 {
    static DS_REPL_OP_TYPE_SYNC := 0
    static DS_REPL_OP_TYPE_ADD := 1
    static DS_REPL_OP_TYPE_DELETE := 2
    static DS_REPL_OP_TYPE_MODIFY := 3
    static DS_REPL_OP_TYPE_UPDATE_REFS := 4
}
struct DS_REPL_OPW {
    ftimeEnqueued : FILETIME
    ulSerialNumber : UInt32
    ulPriority : UInt32
    OpType : DS_REPL_OP_TYPE
    ulOptions : UInt32
    pszNamingContext : PWSTR
    pszDsaDN : PWSTR
    pszDsaAddress : PWSTR
    uuidNamingContextObjGuid : GUID
    uuidDsaObjGuid : GUID
}
struct DS_REPL_OPW_BLOB {
    ftimeEnqueued : FILETIME
    ulSerialNumber : UInt32
    ulPriority : UInt32
    OpType : DS_REPL_OP_TYPE
    ulOptions : UInt32
    oszNamingContext : UInt32
    oszDsaDN : UInt32
    oszDsaAddress : UInt32
    uuidNamingContextObjGuid : GUID
    uuidDsaObjGuid : GUID
}
struct DS_REPL_PENDING_OPSW {
    ftimeCurrentOpStarted : FILETIME
    cNumPendingOps : UInt32
    rgPendingOp : DS_REPL_OPW[1]
}
struct DS_REPL_VALUE_META_DATA {
    pszAttributeName : PWSTR
    pszObjectDn : PWSTR
    cbData : UInt32
    pbData : UInt8.Ptr
    ftimeDeleted : FILETIME
    ftimeCreated : FILETIME
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
}
struct DS_REPL_VALUE_META_DATA_2 {
    pszAttributeName : PWSTR
    pszObjectDn : PWSTR
    cbData : UInt32
    pbData : UInt8.Ptr
    ftimeDeleted : FILETIME
    ftimeCreated : FILETIME
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    pszLastOriginatingDsaDN : PWSTR
}
struct DS_REPL_VALUE_META_DATA_EXT {
    pszAttributeName : PWSTR
    pszObjectDn : PWSTR
    cbData : UInt32
    pbData : UInt8.Ptr
    ftimeDeleted : FILETIME
    ftimeCreated : FILETIME
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    pszLastOriginatingDsaDN : PWSTR
    dwUserIdentifier : UInt32
    dwPriorLinkState : UInt32
    dwCurrentLinkState : UInt32
}
struct DS_REPL_VALUE_META_DATA_BLOB {
    oszAttributeName : UInt32
    oszObjectDn : UInt32
    cbData : UInt32
    obData : UInt32
    ftimeDeleted : FILETIME
    ftimeCreated : FILETIME
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    oszLastOriginatingDsaDN : UInt32
}
struct DS_REPL_VALUE_META_DATA_BLOB_EXT {
    oszAttributeName : UInt32
    oszObjectDn : UInt32
    cbData : UInt32
    obData : UInt32
    ftimeDeleted : FILETIME
    ftimeCreated : FILETIME
    dwVersion : UInt32
    ftimeLastOriginatingChange : FILETIME
    uuidLastOriginatingDsaInvocationID : GUID
    usnOriginatingChange : Int64
    usnLocalChange : Int64
    oszLastOriginatingDsaDN : UInt32
    dwUserIdentifier : UInt32
    dwPriorLinkState : UInt32
    dwCurrentLinkState : UInt32
}
struct DS_REPL_ATTR_VALUE_META_DATA {
    cNumEntries : UInt32
    dwEnumerationContext : UInt32
    rgMetaData : DS_REPL_VALUE_META_DATA[1]
}
struct DS_REPL_ATTR_VALUE_META_DATA_2 {
    cNumEntries : UInt32
    dwEnumerationContext : UInt32
    rgMetaData : DS_REPL_VALUE_META_DATA_2[1]
}
struct DS_REPL_ATTR_VALUE_META_DATA_EXT {
    cNumEntries : UInt32
    dwEnumerationContext : UInt32
    rgMetaData : DS_REPL_VALUE_META_DATA_EXT[1]
}
struct DS_REPL_QUEUE_STATISTICSW {
    ftimeCurrentOpStarted : FILETIME
    cNumPendingOps : UInt32
    ftimeOldestSync : FILETIME
    ftimeOldestAdd : FILETIME
    ftimeOldestMod : FILETIME
    ftimeOldestDel : FILETIME
    ftimeOldestUpdRefs : FILETIME
}
struct DSROLE_MACHINE_ROLE extends Int32 {
    static DsRole_RoleStandaloneWorkstation := 0
    static DsRole_RoleMemberWorkstation := 1
    static DsRole_RoleStandaloneServer := 2
    static DsRole_RoleMemberServer := 3
    static DsRole_RoleBackupDomainController := 4
    static DsRole_RolePrimaryDomainController := 5
}
struct DSROLE_SERVER_STATE extends Int32 {
    static DsRoleServerUnknown := 0
    static DsRoleServerPrimary := 1
    static DsRoleServerBackup := 2
}
struct DSROLE_PRIMARY_DOMAIN_INFO_LEVEL extends Int32 {
    static DsRolePrimaryDomainInfoBasic := 1
    static DsRoleUpgradeStatus := 2
    static DsRoleOperationState := 3
}
struct DSROLE_PRIMARY_DOMAIN_INFO_BASIC {
    MachineRole : DSROLE_MACHINE_ROLE
    Flags : UInt32
    DomainNameFlat : PWSTR
    DomainNameDns : PWSTR
    DomainForestName : PWSTR
    DomainGuid : GUID
}
struct DSROLE_UPGRADE_STATUS_INFO {
    OperationState : UInt32
    PreviousServerState : DSROLE_SERVER_STATE
}
struct DSROLE_OPERATION_STATE extends Int32 {
    static DsRoleOperationIdle := 0
    static DsRoleOperationActive := 1
    static DsRoleOperationNeedReboot := 2
}
struct DSROLE_OPERATION_STATE_INFO {
    OperationState : DSROLE_OPERATION_STATE
}
struct DOMAIN_CONTROLLER_INFOA {
    DomainControllerName : PSTR
    DomainControllerAddress : PSTR
    DomainControllerAddressType : UInt32
    DomainGuid : GUID
    DomainName : PSTR
    DnsForestName : PSTR
    Flags : UInt32
    DcSiteName : PSTR
    ClientSiteName : PSTR
}
struct DOMAIN_CONTROLLER_INFOW {
    DomainControllerName : PWSTR
    DomainControllerAddress : PWSTR
    DomainControllerAddressType : UInt32
    DomainGuid : GUID
    DomainName : PWSTR
    DnsForestName : PWSTR
    Flags : UInt32
    DcSiteName : PWSTR
    ClientSiteName : PWSTR
}
struct DS_DOMAIN_TRUSTSW {
    NetbiosDomainName : PWSTR
    DnsDomainName : PWSTR
    Flags : UInt32
    ParentIndex : UInt32
    TrustType : UInt32
    TrustAttributes : UInt32
    DomainSid : PSID
    DomainGuid : GUID
}
struct DS_DOMAIN_TRUSTSA {
    NetbiosDomainName : PSTR
    DnsDomainName : PSTR
    Flags : UInt32
    ParentIndex : UInt32
    TrustType : UInt32
    TrustAttributes : UInt32
    DomainSid : PSID
    DomainGuid : GUID
}
struct ADS_SEARCH_HANDLE {
    Value : IntPtr
}
