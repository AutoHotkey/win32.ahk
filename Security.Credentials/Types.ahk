#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HWND, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct CRED_FLAGS extends UInt32 {
    static CRED_FLAGS_PASSWORD_FOR_CERT := 1
    static CRED_FLAGS_PROMPT_NOW := 2
    static CRED_FLAGS_USERNAME_TARGET := 4
    static CRED_FLAGS_OWF_CRED_BLOB := 8
    static CRED_FLAGS_REQUIRE_CONFIRMATION := 16
    static CRED_FLAGS_WILDCARD_MATCH := 32
    static CRED_FLAGS_VSM_PROTECTED := 64
    static CRED_FLAGS_NGC_CERT := 128
    static CRED_FLAGS_VALID_FLAGS := 61695
    static CRED_FLAGS_VALID_INPUT_FLAGS := 61599
}
struct CRED_TYPE extends UInt32 {
    static CRED_TYPE_GENERIC := 1
    static CRED_TYPE_DOMAIN_PASSWORD := 2
    static CRED_TYPE_DOMAIN_CERTIFICATE := 3
    static CRED_TYPE_DOMAIN_VISIBLE_PASSWORD := 4
    static CRED_TYPE_GENERIC_CERTIFICATE := 5
    static CRED_TYPE_DOMAIN_EXTENDED := 6
    static CRED_TYPE_MAXIMUM := 7
    static CRED_TYPE_MAXIMUM_EX := 1007
}
struct CRED_PERSIST extends UInt32 {
    static CRED_PERSIST_NONE := 0
    static CRED_PERSIST_SESSION := 1
    static CRED_PERSIST_LOCAL_MACHINE := 2
    static CRED_PERSIST_ENTERPRISE := 3
}
struct CREDUI_FLAGS extends UInt32 {
    static CREDUI_FLAGS_ALWAYS_SHOW_UI := 128
    static CREDUI_FLAGS_COMPLETE_USERNAME := 2048
    static CREDUI_FLAGS_DO_NOT_PERSIST := 2
    static CREDUI_FLAGS_EXCLUDE_CERTIFICATES := 8
    static CREDUI_FLAGS_EXPECT_CONFIRMATION := 131072
    static CREDUI_FLAGS_GENERIC_CREDENTIALS := 262144
    static CREDUI_FLAGS_INCORRECT_PASSWORD := 1
    static CREDUI_FLAGS_KEEP_USERNAME := 1048576
    static CREDUI_FLAGS_PASSWORD_ONLY_OK := 512
    static CREDUI_FLAGS_PERSIST := 4096
    static CREDUI_FLAGS_REQUEST_ADMINISTRATOR := 4
    static CREDUI_FLAGS_REQUIRE_CERTIFICATE := 16
    static CREDUI_FLAGS_REQUIRE_SMARTCARD := 256
    static CREDUI_FLAGS_SERVER_CREDENTIAL := 16384
    static CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX := 64
    static CREDUI_FLAGS_USERNAME_TARGET_CREDENTIALS := 524288
    static CREDUI_FLAGS_VALIDATE_USERNAME := 1024
}
struct SCARD_SCOPE extends UInt32 {
    static SCARD_SCOPE_USER := 0
    static SCARD_SCOPE_SYSTEM := 2
}
struct CRED_ENUMERATE_FLAGS extends UInt32 {
    static CRED_ENUMERATE_ALL_CREDENTIALS := 1
}
struct CREDUIWIN_FLAGS extends UInt32 {
    static CREDUIWIN_GENERIC := 1
    static CREDUIWIN_CHECKBOX := 2
    static CREDUIWIN_AUTHPACKAGE_ONLY := 16
    static CREDUIWIN_IN_CRED_ONLY := 32
    static CREDUIWIN_ENUMERATE_ADMINS := 256
    static CREDUIWIN_ENUMERATE_CURRENT_USER := 512
    static CREDUIWIN_SECURE_PROMPT := 4096
    static CREDUIWIN_PREPROMPTING := 8192
    static CREDUIWIN_PACK_32_WOW := 268435456
}
struct SCARD_STATE extends UInt32 {
    static SCARD_STATE_UNAWARE := 0
    static SCARD_STATE_IGNORE := 1
    static SCARD_STATE_UNAVAILABLE := 8
    static SCARD_STATE_EMPTY := 16
    static SCARD_STATE_PRESENT := 32
    static SCARD_STATE_ATRMATCH := 64
    static SCARD_STATE_EXCLUSIVE := 128
    static SCARD_STATE_INUSE := 256
    static SCARD_STATE_MUTE := 512
    static SCARD_STATE_CHANGED := 2
    static SCARD_STATE_UNKNOWN := 4
}
struct CRED_PACK_FLAGS extends UInt32 {
    static CRED_PACK_PROTECTED_CREDENTIALS := 1
    static CRED_PACK_WOW_BUFFER := 2
    static CRED_PACK_GENERIC_CREDENTIALS := 4
    static CRED_PACK_ID_PROVIDER_CREDENTIALS := 8
}
struct KeyCredentialManagerOperationErrorStates extends Int32 {
    static KeyCredentialManagerOperationErrorStateNone := 0
    static KeyCredentialManagerOperationErrorStateDeviceJoinFailure := 1
    static KeyCredentialManagerOperationErrorStateTokenFailure := 2
    static KeyCredentialManagerOperationErrorStateCertificateFailure := 4
    static KeyCredentialManagerOperationErrorStateRemoteSessionFailure := 8
    static KeyCredentialManagerOperationErrorStatePolicyFailure := 16
    static KeyCredentialManagerOperationErrorStateHardwareFailure := 32
    static KeyCredentialManagerOperationErrorStatePinExistsFailure := 64
}
struct KeyCredentialManagerOperationType extends Int32 {
    static KeyCredentialManagerProvisioning := 0
    static KeyCredentialManagerPinChange := 1
    static KeyCredentialManagerPinReset := 2
}
struct KeyCredentialManagerInfo {
    containerId : GUID
}
struct SecHandle {
    dwLower : IntPtr
    dwUpper : IntPtr
}
struct CREDENTIAL_ATTRIBUTEA {
    Keyword : PSTR
    Flags : UInt32
    ValueSize : UInt32
    Value : UInt8.Ptr
}
struct CREDENTIAL_ATTRIBUTEW {
    Keyword : PWSTR
    Flags : UInt32
    ValueSize : UInt32
    Value : UInt8.Ptr
}
struct CREDENTIALA {
    Flags : CRED_FLAGS
    Type : CRED_TYPE
    TargetName : PSTR
    Comment : PSTR
    LastWritten : FILETIME
    CredentialBlobSize : UInt32
    CredentialBlob : UInt8.Ptr
    Persist : CRED_PERSIST
    AttributeCount : UInt32
    Attributes : CREDENTIAL_ATTRIBUTEA.Ptr
    TargetAlias : PSTR
    UserName : PSTR
}
struct CREDENTIALW {
    Flags : CRED_FLAGS
    Type : CRED_TYPE
    TargetName : PWSTR
    Comment : PWSTR
    LastWritten : FILETIME
    CredentialBlobSize : UInt32
    CredentialBlob : UInt8.Ptr
    Persist : CRED_PERSIST
    AttributeCount : UInt32
    Attributes : CREDENTIAL_ATTRIBUTEW.Ptr
    TargetAlias : PWSTR
    UserName : PWSTR
}
struct CREDENTIAL_TARGET_INFORMATIONA {
    TargetName : PSTR
    NetbiosServerName : PSTR
    DnsServerName : PSTR
    NetbiosDomainName : PSTR
    DnsDomainName : PSTR
    DnsTreeName : PSTR
    PackageName : PSTR
    Flags : UInt32
    CredTypeCount : UInt32
    CredTypes : UInt32.Ptr
}
struct CREDENTIAL_TARGET_INFORMATIONW {
    TargetName : PWSTR
    NetbiosServerName : PWSTR
    DnsServerName : PWSTR
    NetbiosDomainName : PWSTR
    DnsDomainName : PWSTR
    DnsTreeName : PWSTR
    PackageName : PWSTR
    Flags : UInt32
    CredTypeCount : UInt32
    CredTypes : UInt32.Ptr
}
struct CERT_CREDENTIAL_INFO {
    cbSize : UInt32 := this.Size
    rgbHashOfCert : UInt8[20]
}
struct USERNAME_TARGET_CREDENTIAL_INFO {
    UserName : PWSTR
}
struct BINARY_BLOB_CREDENTIAL_INFO {
    cbBlob : UInt32
    pbBlob : UInt8.Ptr
}
struct CRED_MARSHAL_TYPE extends Int32 {
    static CertCredential := 1
    static UsernameTargetCredential := 2
    static BinaryBlobCredential := 3
    static UsernameForPackedCredentials := 4
    static BinaryBlobForSystem := 5
}
struct CRED_PROTECTION_TYPE extends Int32 {
    static CredUnprotected := 0
    static CredUserProtection := 1
    static CredTrustedProtection := 2
    static CredForSystemProtection := 3
}
struct CREDUI_INFOA {
    cbSize : UInt32 := this.Size
    hwndParent : HWND
    pszMessageText : PSTR
    pszCaptionText : PSTR
    hbmBanner : HBITMAP
}
struct CREDUI_INFOW {
    cbSize : UInt32 := this.Size
    hwndParent : HWND
    pszMessageText : PWSTR
    pszCaptionText : PWSTR
    hbmBanner : HBITMAP
}
struct SCARD_IO_REQUEST {
    dwProtocol : UInt32
    cbPciLength : UInt32
}
struct SCARD_T0_COMMAND {
    bCla : UInt8
    bIns : UInt8
    bP1 : UInt8
    bP2 : UInt8
    bP3 : UInt8
}
struct SCARD_T0_REQUEST {
    ioRequest : SCARD_IO_REQUEST
    bSw1 : UInt8
    bSw2 : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            CmdBytes : SCARD_T0_COMMAND
            rgbHeader : UInt8[5]
        }
    }
}
struct SCARD_T1_REQUEST {
    ioRequest : SCARD_IO_REQUEST
}
struct SCARD_READERSTATEA {
    szReader : PSTR
    pvUserData : Struct.Ptr
    dwCurrentState : SCARD_STATE
    dwEventState : SCARD_STATE
    cbAtr : UInt32
    rgbAtr : UInt8[36]
}
struct SCARD_READERSTATEW {
    szReader : PWSTR
    pvUserData : Struct.Ptr
    dwCurrentState : SCARD_STATE
    dwEventState : SCARD_STATE
    cbAtr : UInt32
    rgbAtr : UInt8[36]
}
struct SCARD_ATRMASK {
    cbAtr : UInt32
    rgbAtr : UInt8[36]
    rgbMask : UInt8[36]
}
struct LPOCNCONNPROCA extends FunctionPointer {
    static Types := [IntPtr, PSTR, PSTR, Struct.Ptr, IntPtr]
}
struct LPOCNCONNPROCW extends FunctionPointer {
    static Types := [IntPtr, PWSTR, PWSTR, Struct.Ptr, IntPtr]
}
struct LPOCNCHKPROC extends FunctionPointer {
    static Types := [IntPtr, IntPtr, Struct.Ptr, BOOL]
}
struct LPOCNDSCPROC extends FunctionPointer {
    static Types := [IntPtr, IntPtr, Struct.Ptr, "Void"]
}
struct OPENCARD_SEARCH_CRITERIAA {
    dwStructSize : UInt32
    lpstrGroupNames : PSTR
    nMaxGroupNames : UInt32
    rgguidInterfaces : GUID.Ptr
    cguidInterfaces : UInt32
    lpstrCardNames : PSTR
    nMaxCardNames : UInt32
    lpfnCheck : LPOCNCHKPROC
    lpfnConnect : LPOCNCONNPROCA
    lpfnDisconnect : LPOCNDSCPROC
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
}
struct OPENCARD_SEARCH_CRITERIAW {
    dwStructSize : UInt32
    lpstrGroupNames : PWSTR
    nMaxGroupNames : UInt32
    rgguidInterfaces : GUID.Ptr
    cguidInterfaces : UInt32
    lpstrCardNames : PWSTR
    nMaxCardNames : UInt32
    lpfnCheck : LPOCNCHKPROC
    lpfnConnect : LPOCNCONNPROCW
    lpfnDisconnect : LPOCNDSCPROC
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
}
struct OPENCARDNAME_EXA {
    dwStructSize : UInt32
    hSCardContext : IntPtr
    hwndOwner : HWND
    dwFlags : UInt32
    lpstrTitle : PSTR
    lpstrSearchDesc : PSTR
    hIcon : HICON
    pOpenCardSearchCriteria : OPENCARD_SEARCH_CRITERIAA.Ptr
    lpfnConnect : LPOCNCONNPROCA
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
    lpstrRdr : PSTR
    nMaxRdr : UInt32
    lpstrCard : PSTR
    nMaxCard : UInt32
    dwActiveProtocol : UInt32
    hCardHandle : IntPtr
}
struct OPENCARDNAME_EXW {
    dwStructSize : UInt32
    hSCardContext : IntPtr
    hwndOwner : HWND
    dwFlags : UInt32
    lpstrTitle : PWSTR
    lpstrSearchDesc : PWSTR
    hIcon : HICON
    pOpenCardSearchCriteria : OPENCARD_SEARCH_CRITERIAW.Ptr
    lpfnConnect : LPOCNCONNPROCW
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
    lpstrRdr : PWSTR
    nMaxRdr : UInt32
    lpstrCard : PWSTR
    nMaxCard : UInt32
    dwActiveProtocol : UInt32
    hCardHandle : IntPtr
}
struct READER_SEL_REQUEST_MATCH_TYPE extends Int32 {
    static RSR_MATCH_TYPE_READER_AND_CONTAINER := 1
    static RSR_MATCH_TYPE_SERIAL_NUMBER := 2
    static RSR_MATCH_TYPE_ALL_CARDS := 3
}
struct READER_SEL_REQUEST {
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
    MatchType : READER_SEL_REQUEST_MATCH_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ReaderAndContainerParameter : this._ReaderAndContainerParameter_e__Struct
            SerialNumberParameter : this._SerialNumberParameter_e__Struct
        }
        struct _ReaderAndContainerParameter_e__Struct {
            cbReaderNameOffset : UInt32
            cchReaderNameLength : UInt32
            cbContainerNameOffset : UInt32
            cchContainerNameLength : UInt32
            dwDesiredCardModuleVersion : UInt32
            dwCspFlags : UInt32
        }
        struct _SerialNumberParameter_e__Struct {
            cbSerialNumberOffset : UInt32
            cbSerialNumberLength : UInt32
            dwDesiredCardModuleVersion : UInt32
        }
    }
}
struct READER_SEL_RESPONSE {
    cbReaderNameOffset : UInt32
    cchReaderNameLength : UInt32
    cbCardNameOffset : UInt32
    cchCardNameLength : UInt32
}
struct OPENCARDNAMEA {
    dwStructSize : UInt32
    hwndOwner : HWND
    hSCardContext : IntPtr
    lpstrGroupNames : PSTR
    nMaxGroupNames : UInt32
    lpstrCardNames : PSTR
    nMaxCardNames : UInt32
    rgguidInterfaces : GUID.Ptr
    cguidInterfaces : UInt32
    lpstrRdr : PSTR
    nMaxRdr : UInt32
    lpstrCard : PSTR
    nMaxCard : UInt32
    lpstrTitle : PSTR
    dwFlags : UInt32
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
    dwActiveProtocol : UInt32
    lpfnConnect : LPOCNCONNPROCA
    lpfnCheck : LPOCNCHKPROC
    lpfnDisconnect : LPOCNDSCPROC
    hCardHandle : IntPtr
}
struct OPENCARDNAMEW {
    dwStructSize : UInt32
    hwndOwner : HWND
    hSCardContext : IntPtr
    lpstrGroupNames : PWSTR
    nMaxGroupNames : UInt32
    lpstrCardNames : PWSTR
    nMaxCardNames : UInt32
    rgguidInterfaces : GUID.Ptr
    cguidInterfaces : UInt32
    lpstrRdr : PWSTR
    nMaxRdr : UInt32
    lpstrCard : PWSTR
    nMaxCard : UInt32
    lpstrTitle : PWSTR
    dwFlags : UInt32
    pvUserData : Struct.Ptr
    dwShareMode : UInt32
    dwPreferredProtocols : UInt32
    dwActiveProtocol : UInt32
    lpfnConnect : LPOCNCONNPROCW
    lpfnCheck : LPOCNCHKPROC
    lpfnDisconnect : LPOCNDSCPROC
    hCardHandle : IntPtr
}
struct SecPkgContext_ClientCreds {
    AuthBufferLen : UInt32
    AuthBuffer : UInt8.Ptr
}
struct CREDSPP_SUBMIT_TYPE extends Int32 {
    static CredsspPasswordCreds := 2
    static CredsspSchannelCreds := 4
    static CredsspCertificateCreds := 13
    static CredsspSubmitBufferBoth := 50
    static CredsspSubmitBufferBothOld := 51
    static CredsspCredEx := 100
}
struct CREDSSP_CRED {
    Type : CREDSPP_SUBMIT_TYPE
    pSchannelCred : Struct.Ptr
    pSpnegoCred : Struct.Ptr
}
struct CREDSSP_CRED_EX {
    Type : CREDSPP_SUBMIT_TYPE
    Version : UInt32
    Flags : UInt32
    Reserved : UInt32
    Cred : CREDSSP_CRED
}
