#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HINSTANCE, HRESULT, HWND, LPARAM, PSTR, PWSTR, WPARAM}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CHAIN_CONTEXT, CERT_CONTEXT, CRL_CONTEXT, CRYPT_ATTRIBUTES, CRYPT_INTEGER_BLOB, CRYPT_KEY_FLAGS, CRYPT_KEY_PROV_INFO, CTL_CONTEXT, HCERTSTORE}
#Import "..\Security.WinTrust\Types.ahk" {CRYPT_PROVIDER_DATA}
#Import "..\UI.Controls\Types.ahk" {PROPSHEETPAGEA, PROPSHEETPAGEW}

struct CRYPTUI_WIZ_FLAGS extends UInt32 {
    static CRYPTUI_WIZ_NO_UI := 1
    static CRYPTUI_WIZ_IGNORE_NO_UI_FLAG_FOR_CSPS := 2
    static CRYPTUI_WIZ_NO_UI_EXCEPT_CSP := 3
    static CRYPTUI_WIZ_IMPORT_ALLOW_CERT := 131072
    static CRYPTUI_WIZ_IMPORT_ALLOW_CRL := 262144
    static CRYPTUI_WIZ_IMPORT_ALLOW_CTL := 524288
    static CRYPTUI_WIZ_IMPORT_NO_CHANGE_DEST_STORE := 65536
    static CRYPTUI_WIZ_IMPORT_TO_LOCALMACHINE := 1048576
    static CRYPTUI_WIZ_IMPORT_TO_CURRENTUSER := 2097152
    static CRYPTUI_WIZ_IMPORT_REMOTE_DEST_STORE := 4194304
    static CRYPTUI_WIZ_EXPORT_PRIVATE_KEY := 256
    static CRYPTUI_WIZ_EXPORT_NO_DELETE_PRIVATE_KEY := 512
}
struct CRYPTUI_VIEWCERTIFICATE_FLAGS extends UInt32 {
    static CRYPTUI_HIDE_HIERARCHYPAGE := 1
    static CRYPTUI_HIDE_DETAILPAGE := 2
    static CRYPTUI_DISABLE_EDITPROPERTIES := 4
    static CRYPTUI_ENABLE_EDITPROPERTIES := 8
    static CRYPTUI_DISABLE_ADDTOSTORE := 16
    static CRYPTUI_ENABLE_ADDTOSTORE := 32
    static CRYPTUI_ACCEPT_DECLINE_STYLE := 64
    static CRYPTUI_IGNORE_UNTRUSTED_ROOT := 128
    static CRYPTUI_DONT_OPEN_STORES := 256
    static CRYPTUI_ONLY_OPEN_ROOT_STORE := 512
    static CRYPTUI_WARN_UNTRUSTED_ROOT := 1024
    static CRYPTUI_ENABLE_REVOCATION_CHECKING := 2048
    static CRYPTUI_WARN_REMOTE_TRUST := 4096
    static CRYPTUI_DISABLE_EXPORT := 8192
    static CRYPTUI_ENABLE_REVOCATION_CHECK_END_CERT := 16384
    static CRYPTUI_ENABLE_REVOCATION_CHECK_CHAIN := 32768
    static CRYPTUI_ENABLE_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT := 2048
    static CRYPTUI_DISABLE_HTMLLINK := 65536
    static CRYPTUI_DISABLE_ISSUERSTATEMENT := 131072
    static CRYPTUI_CACHE_ONLY_URL_RETRIEVAL := 262144
}
struct CERT_SELECT_STRUCT_FLAGS extends UInt32 {
    static CSS_HIDE_PROPERTIES := 1
    static CSS_ENABLEHOOK := 2
    static CSS_ALLOWMULTISELECT := 4
    static CSS_SHOW_HELP := 16
    static CSS_ENABLETEMPLATE := 32
    static CSS_ENABLETEMPLATEHANDLE := 64
}
struct CRYPTUI_WIZ_IMPORT_SUBJECT_OPTION extends UInt32 {
    static CRYPTUI_WIZ_IMPORT_SUBJECT_FILE := 1
    static CRYPTUI_WIZ_IMPORT_SUBJECT_CERT_CONTEXT := 2
    static CRYPTUI_WIZ_IMPORT_SUBJECT_CTL_CONTEXT := 3
    static CRYPTUI_WIZ_IMPORT_SUBJECT_CRL_CONTEXT := 4
    static CRYPTUI_WIZ_IMPORT_SUBJECT_CERT_STORE := 5
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT extends UInt32 {
    static CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_BLOB := 2
    static CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_FILE := 1
    static CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_NONE := 0
}
struct CRYPTUI_WIZ_DIGITAL_SIGN extends UInt32 {
    static CRYPTUI_WIZ_DIGITAL_SIGN_CERT := 1
    static CRYPTUI_WIZ_DIGITAL_SIGN_STORE := 2
    static CRYPTUI_WIZ_DIGITAL_SIGN_PVK := 3
    static CRYPTUI_WIZ_DIGITAL_SIGN_NONE := 0
}
struct CRYPTUI_WIZ_EXPORT_SUBJECT extends UInt32 {
    static CRYPTUI_WIZ_EXPORT_CERT_CONTEXT := 1
    static CRYPTUI_WIZ_EXPORT_CTL_CONTEXT := 2
    static CRYPTUI_WIZ_EXPORT_CRL_CONTEXT := 3
    static CRYPTUI_WIZ_EXPORT_CERT_STORE := 4
    static CRYPTUI_WIZ_EXPORT_CERT_STORE_CERTIFICATES_ONLY := 5
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_SIG_TYPE extends UInt32 {
    static CRYPTUI_WIZ_DIGITAL_SIGN_COMMERCIAL := 1
    static CRYPTUI_WIZ_DIGITAL_SIGN_INDIVIDUAL := 2
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_PVK_OPTION extends UInt32 {
    static CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE := 1
    static CRYPTUI_WIZ_DIGITAL_SIGN_PVK_PROV := 2
}
struct CERT_VIEWPROPERTIES_STRUCT_FLAGS extends UInt32 {
    static CM_ENABLEHOOK := 1
    static CM_SHOW_HELP := 2
    static CM_SHOW_HELPICON := 4
    static CM_ENABLETEMPLATE := 8
    static CM_HIDE_ADVANCEPAGE := 16
    static CM_HIDE_TRUSTPAGE := 32
    static CM_NO_NAMECHANGE := 64
    static CM_NO_EDITTRUST := 128
    static CM_HIDE_DETAILPAGE := 256
    static CM_ADD_CERT_STORES := 512
}
struct CRYPTUI_WIZ_EXPORT_FORMAT extends UInt32 {
    static CRYPTUI_WIZ_EXPORT_FORMAT_DER := 1
    static CRYPTUI_WIZ_EXPORT_FORMAT_PFX := 2
    static CRYPTUI_WIZ_EXPORT_FORMAT_PKCS7 := 3
    static CRYPTUI_WIZ_EXPORT_FORMAT_BASE64 := 4
    static CRYPTUI_WIZ_EXPORT_FORMAT_CRL := 6
    static CRYPTUI_WIZ_EXPORT_FORMAT_CTL := 7
}
struct CRYPTUI_WIZ_DIGITAL_ADDITIONAL_CERT_CHOICE extends UInt32 {
    static CRYPTUI_WIZ_DIGITAL_SIGN_ADD_CHAIN := 1
    static CRYPTUI_WIZ_DIGITAL_SIGN_ADD_CHAIN_NO_ROOT := 2
    static CRYPTUI_WIZ_DIGITAL_SIGN_ADD_NONE := 0
}
struct CTL_MODIFY_REQUEST_OPERATION extends UInt32 {
    static CTL_MODIFY_REQUEST_ADD_TRUSTED := 3
    static CTL_MODIFY_REQUEST_ADD_NOT_TRUSTED := 1
    static CTL_MODIFY_REQUEST_REMOVE := 2
}
struct PFNCMFILTERPROC extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, LPARAM, UInt32, UInt32, BOOL]
}
struct PFNCMHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct CERT_SELECT_STRUCT_A {
    dwSize : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    pTemplateName : PSTR
    dwFlags : CERT_SELECT_STRUCT_FLAGS
    szTitle : PSTR
    cCertStore : UInt32
    arrayCertStore : HCERTSTORE.Ptr
    szPurposeOid : PSTR
    cCertContext : UInt32
    arrayCertContext : CERT_CONTEXT.Ptr.Ptr
    lCustData : LPARAM
    pfnHook : PFNCMHOOKPROC
    pfnFilter : PFNCMFILTERPROC
    szHelpFileName : PSTR
    dwHelpId : UInt32
    hprov : IntPtr
}
struct CERT_SELECT_STRUCT_W {
    dwSize : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    pTemplateName : PWSTR
    dwFlags : CERT_SELECT_STRUCT_FLAGS
    szTitle : PWSTR
    cCertStore : UInt32
    arrayCertStore : HCERTSTORE.Ptr
    szPurposeOid : PSTR
    cCertContext : UInt32
    arrayCertContext : CERT_CONTEXT.Ptr.Ptr
    lCustData : LPARAM
    pfnHook : PFNCMHOOKPROC
    pfnFilter : PFNCMFILTERPROC
    szHelpFileName : PWSTR
    dwHelpId : UInt32
    hprov : IntPtr
}
struct CERT_VIEWPROPERTIES_STRUCT_A {
    dwSize : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    dwFlags : CERT_VIEWPROPERTIES_STRUCT_FLAGS
    szTitle : PSTR
    pCertContext : CERT_CONTEXT.Ptr
    arrayPurposes : PSTR.Ptr
    cArrayPurposes : UInt32
    cRootStores : UInt32
    rghstoreRoots : HCERTSTORE.Ptr
    cStores : UInt32
    rghstoreCAs : HCERTSTORE.Ptr
    cTrustStores : UInt32
    rghstoreTrust : HCERTSTORE.Ptr
    hprov : IntPtr
    lCustData : LPARAM
    dwPad : UInt32
    szHelpFileName : PSTR
    dwHelpId : UInt32
    nStartPage : UInt32
    cArrayPropSheetPages : UInt32
    arrayPropSheetPages : PROPSHEETPAGEA.Ptr
}
struct CERT_VIEWPROPERTIES_STRUCT_W {
    dwSize : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    dwFlags : CERT_VIEWPROPERTIES_STRUCT_FLAGS
    szTitle : PWSTR
    pCertContext : CERT_CONTEXT.Ptr
    arrayPurposes : PSTR.Ptr
    cArrayPurposes : UInt32
    cRootStores : UInt32
    rghstoreRoots : HCERTSTORE.Ptr
    cStores : UInt32
    rghstoreCAs : HCERTSTORE.Ptr
    cTrustStores : UInt32
    rghstoreTrust : HCERTSTORE.Ptr
    hprov : IntPtr
    lCustData : LPARAM
    dwPad : UInt32
    szHelpFileName : PWSTR
    dwHelpId : UInt32
    nStartPage : UInt32
    cArrayPropSheetPages : UInt32
    arrayPropSheetPages : PROPSHEETPAGEA.Ptr
}
struct CERT_FILTER_EXTENSION_MATCH {
    szExtensionOID : PSTR
    dwTestOperation : UInt32
    pbTestData : UInt8.Ptr
    cbTestData : UInt32
}
struct CERT_FILTER_DATA {
    dwSize : UInt32
    cExtensionChecks : UInt32
    arrayExtensionChecks : CERT_FILTER_EXTENSION_MATCH.Ptr
    dwCheckingFlags : UInt32
}
struct PFNTRUSTHELPER extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, LPARAM, BOOL, UInt8.Ptr, HRESULT]
}
struct CERT_VERIFY_CERTIFICATE_TRUST {
    cbSize : UInt32 := this.Size
    pccert : CERT_CONTEXT.Ptr
    dwFlags : UInt32
    dwIgnoreErr : UInt32
    pdwErrors : UInt32.Ptr
    pszUsageOid : PSTR
    hprov : IntPtr
    cRootStores : UInt32
    rghstoreRoots : HCERTSTORE.Ptr
    cStores : UInt32
    rghstoreCAs : HCERTSTORE.Ptr
    cTrustStores : UInt32
    rghstoreTrust : HCERTSTORE.Ptr
    lCustData : LPARAM
    pfnTrustHelper : PFNTRUSTHELPER
    pcChain : UInt32.Ptr
    prgChain : CERT_CONTEXT.Ptr.Ptr.Ptr
    prgdwErrors : UInt32.Ptr.Ptr
    prgpbTrustInfo : CRYPT_INTEGER_BLOB.Ptr.Ptr
}
struct CTL_MODIFY_REQUEST {
    pccert : CERT_CONTEXT.Ptr
    dwOperation : CTL_MODIFY_REQUEST_OPERATION
    dwError : UInt32
}
struct PFNCFILTERPROC extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, BOOL.Ptr, Struct.Ptr, BOOL]
}
struct CERT_SELECTUI_INPUT {
    hStore : HCERTSTORE
    prgpChain : CERT_CHAIN_CONTEXT.Ptr.Ptr
    cChain : UInt32
}
struct CRYPTUI_CERT_MGR_STRUCT {
    dwSize : UInt32
    hwndParent : HWND
    dwFlags : UInt32
    pwszTitle : PWSTR
    pszInitUsageOID : PSTR
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO {
    dwSize : UInt32
    pGuidSubject : GUID.Ptr
    cbBlob : UInt32
    pbBlob : UInt8.Ptr
    pwszDisplayName : PWSTR
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO {
    dwSize : UInt32
    cCertStore : UInt32
    rghCertStore : HCERTSTORE.Ptr
    pFilterCallback : PFNCFILTERPROC
    pvCallbackData : Struct.Ptr
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO {
    dwSize : UInt32
    pwszPvkFileName : PWSTR
    pwszProvName : PWSTR
    dwProvType : UInt32
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO {
    dwSize : UInt32
    pwszSigningCertFileName : PWSTR
    dwPvkChoice : CRYPTUI_WIZ_DIGITAL_SIGN_PVK_OPTION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pPvkFileInfo : CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO.Ptr
            pPvkProvInfo : CRYPT_KEY_PROV_INFO.Ptr
        }
    }
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO {
    dwSize : UInt32
    dwAttrFlags : CRYPTUI_WIZ_DIGITAL_SIGN_SIG_TYPE
    pwszDescription : PWSTR
    pwszMoreInfoLocation : PWSTR
    pszHashAlg : PSTR
    pwszSigningCertDisplayString : PWSTR
    hAdditionalCertStore : HCERTSTORE
    psAuthenticated : CRYPT_ATTRIBUTES.Ptr
    psUnauthenticated : CRYPT_ATTRIBUTES.Ptr
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_INFO {
    dwSize : UInt32
    dwSubjectChoice : CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT
    Anonymous1 : this._Anonymous1_e__Union
    dwSigningCertChoice : CRYPTUI_WIZ_DIGITAL_SIGN
    Anonymous2 : this._Anonymous2_e__Union
    pwszTimestampURL : PWSTR
    dwAdditionalCertChoice : CRYPTUI_WIZ_DIGITAL_ADDITIONAL_CERT_CHOICE
    pSignExtInfo : CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO.Ptr
    struct _Anonymous1_e__Union {
        union {
            pwszFileName : PWSTR
            pSignBlobInfo : CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pSigningCertContext : CERT_CONTEXT.Ptr
            pSigningCertStore : CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO.Ptr
            pSigningCertPvkInfo : CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO.Ptr
        }
    }
}
struct CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT {
    dwSize : UInt32
    cbBlob : UInt32
    pbBlob : UInt8.Ptr
}
struct CRYPTUI_INITDIALOG_STRUCT {
    lParam : LPARAM
    pCertContext : CERT_CONTEXT.Ptr
}
struct CRYPTUI_VIEWCERTIFICATE_STRUCTW {
    dwSize : UInt32
    hwndParent : HWND
    dwFlags : CRYPTUI_VIEWCERTIFICATE_FLAGS
    szTitle : PWSTR
    pCertContext : CERT_CONTEXT.Ptr
    rgszPurposes : PSTR.Ptr
    cPurposes : UInt32
    Anonymous : this._Anonymous_e__Union
    fpCryptProviderDataTrustedUsage : BOOL
    idxSigner : UInt32
    idxCert : UInt32
    fCounterSigner : BOOL
    idxCounterSigner : UInt32
    cStores : UInt32
    rghStores : HCERTSTORE.Ptr
    cPropSheetPages : UInt32
    rgPropSheetPages : PROPSHEETPAGEW.Ptr
    nStartPage : UInt32
    struct _Anonymous_e__Union {
        union {
            pCryptProviderData : CRYPT_PROVIDER_DATA.Ptr
            hWVTStateData : HANDLE
        }
    }
}
struct CRYPTUI_VIEWCERTIFICATE_STRUCTA {
    dwSize : UInt32
    hwndParent : HWND
    dwFlags : CRYPTUI_VIEWCERTIFICATE_FLAGS
    szTitle : PSTR
    pCertContext : CERT_CONTEXT.Ptr
    rgszPurposes : PSTR.Ptr
    cPurposes : UInt32
    Anonymous : this._Anonymous_e__Union
    fpCryptProviderDataTrustedUsage : BOOL
    idxSigner : UInt32
    idxCert : UInt32
    fCounterSigner : BOOL
    idxCounterSigner : UInt32
    cStores : UInt32
    rghStores : HCERTSTORE.Ptr
    cPropSheetPages : UInt32
    rgPropSheetPages : PROPSHEETPAGEA.Ptr
    nStartPage : UInt32
    struct _Anonymous_e__Union {
        union {
            pCryptProviderData : CRYPT_PROVIDER_DATA.Ptr
            hWVTStateData : HANDLE
        }
    }
}
struct CRYPTUI_WIZ_EXPORT_INFO {
    dwSize : UInt32
    pwszExportFileName : PWSTR
    dwSubjectChoice : CRYPTUI_WIZ_EXPORT_SUBJECT
    Anonymous : this._Anonymous_e__Union
    cStores : UInt32
    rghStores : HCERTSTORE.Ptr
    struct _Anonymous_e__Union {
        union {
            pCertContext : CERT_CONTEXT.Ptr
            pCTLContext : CTL_CONTEXT.Ptr
            pCRLContext : CRL_CONTEXT.Ptr
            hCertStore : HCERTSTORE
        }
    }
}
struct CRYPTUI_WIZ_EXPORT_CERTCONTEXT_INFO {
    dwSize : UInt32
    dwExportFormat : CRYPTUI_WIZ_EXPORT_FORMAT
    fExportChain : BOOL
    fExportPrivateKeys : BOOL
    pwszPassword : PWSTR
    fStrongEncryption : BOOL
}
struct CRYPTUI_WIZ_IMPORT_SRC_INFO {
    dwSize : UInt32
    dwSubjectChoice : CRYPTUI_WIZ_IMPORT_SUBJECT_OPTION
    Anonymous : this._Anonymous_e__Union
    dwFlags : CRYPT_KEY_FLAGS
    pwszPassword : PWSTR
    struct _Anonymous_e__Union {
        union {
            pwszFileName : PWSTR
            pCertContext : CERT_CONTEXT.Ptr
            pCTLContext : CTL_CONTEXT.Ptr
            pCRLContext : CRL_CONTEXT.Ptr
            hCertStore : HCERTSTORE
        }
    }
}
