#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, FILETIME, HANDLE, HRESULT, HWND, PSTR, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CHAIN_CONTEXT, CERT_CHAIN_ELEMENT, CERT_CHAIN_PARA, CERT_CONTEXT, CERT_STRONG_SIGN_PARA, CERT_USAGE_MATCH, CMSG_SIGNER_INFO, CRYPT_ALGORITHM_IDENTIFIER, CRYPT_ATTRIBUTE_TYPE_VALUE, CRYPT_BIT_BLOB, CRYPT_INTEGER_BLOB, CTL_CONTEXT, HCERTCHAINENGINE, HCERTSTORE}
#Import "..\Security.Cryptography.Sip\Types.ahk" {SIP_DISPATCH_INFO, SIP_INDIRECT_DATA, SIP_SUBJECTINFO}

struct WINTRUST_GET_DEFAULT_FOR_USAGE_ACTION extends UInt32 {
    static DWACTION_ALLOCANDFILL := 1
    static DWACTION_FREE := 2
}
struct WINTRUST_POLICY_FLAGS extends UInt32 {
    static WTPF_TRUSTTEST := 32
    static WTPF_TESTCANBEVALID := 128
    static WTPF_IGNOREEXPIRATION := 256
    static WTPF_IGNOREREVOKATION := 512
    static WTPF_OFFLINEOK_IND := 1024
    static WTPF_OFFLINEOK_COM := 2048
    static WTPF_OFFLINEOKNBU_IND := 4096
    static WTPF_OFFLINEOKNBU_COM := 8192
    static WTPF_VERIFY_V1_OFF := 65536
    static WTPF_IGNOREREVOCATIONONTS := 131072
    static WTPF_ALLOWONLYPERTRUST := 262144
}
struct WINTRUST_DATA_PROVIDER_FLAGS extends UInt32 {
    static WTD_USE_IE4_TRUST_FLAG := 1
    static WTD_NO_IE4_CHAIN_FLAG := 2
    static WTD_NO_POLICY_USAGE_FLAG := 4
    static WTD_REVOCATION_CHECK_NONE := 16
    static WTD_REVOCATION_CHECK_END_CERT := 32
    static WTD_REVOCATION_CHECK_CHAIN := 64
    static WTD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT := 128
    static WTD_SAFER_FLAG := 256
    static WTD_HASH_ONLY_FLAG := 512
    static WTD_USE_DEFAULT_OSVER_CHECK := 1024
    static WTD_LIFETIME_SIGNING_FLAG := 2048
    static WTD_CACHE_ONLY_URL_RETRIEVAL := 4096
    static WTD_DISABLE_MD2_MD4 := 8192
    static WTD_MOTW := 16384
}
struct WINTRUST_DATA_UICHOICE extends UInt32 {
    static WTD_UI_ALL := 1
    static WTD_UI_NONE := 2
    static WTD_UI_NOBAD := 3
    static WTD_UI_NOGOOD := 4
}
struct WINTRUST_SIGNATURE_SETTINGS_FLAGS extends UInt32 {
    static WSS_VERIFY_SPECIFIC := 1
    static WSS_GET_SECONDARY_SIG_COUNT := 2
}
struct WINTRUST_DATA_STATE_ACTION extends UInt32 {
    static WTD_STATEACTION_IGNORE := 0
    static WTD_STATEACTION_VERIFY := 1
    static WTD_STATEACTION_CLOSE := 2
    static WTD_STATEACTION_AUTO_CACHE := 3
    static WTD_STATEACTION_AUTO_CACHE_FLUSH := 4
}
struct WINTRUST_DATA_UNION_CHOICE extends UInt32 {
    static WTD_CHOICE_FILE := 1
    static WTD_CHOICE_CATALOG := 2
    static WTD_CHOICE_BLOB := 3
    static WTD_CHOICE_SIGNER := 4
    static WTD_CHOICE_CERT := 5
}
struct WINTRUST_DATA_REVOCATION_CHECKS extends UInt32 {
    static WTD_REVOKE_NONE := 0
    static WTD_REVOKE_WHOLECHAIN := 1
}
struct WINTRUST_DATA_UICONTEXT extends UInt32 {
    static WTD_UICONTEXT_EXECUTE := 0
    static WTD_UICONTEXT_INSTALL := 1
}
struct WINTRUST_DATA {
    cbStruct : UInt32
    pPolicyCallbackData : Struct.Ptr
    pSIPClientData : Struct.Ptr
    dwUIChoice : WINTRUST_DATA_UICHOICE
    fdwRevocationChecks : WINTRUST_DATA_REVOCATION_CHECKS
    dwUnionChoice : WINTRUST_DATA_UNION_CHOICE
    Anonymous : this._Anonymous_e__Union
    dwStateAction : WINTRUST_DATA_STATE_ACTION
    hWVTStateData : HANDLE
    pwszURLReference : PWSTR
    dwProvFlags : WINTRUST_DATA_PROVIDER_FLAGS
    dwUIContext : WINTRUST_DATA_UICONTEXT
    pSignatureSettings : WINTRUST_SIGNATURE_SETTINGS.Ptr
    struct _Anonymous_e__Union {
        union {
            pFile : WINTRUST_FILE_INFO.Ptr
            pCatalog : WINTRUST_CATALOG_INFO.Ptr
            pBlob : WINTRUST_BLOB_INFO.Ptr
            pSgnr : WINTRUST_SGNR_INFO.Ptr
            pCert : WINTRUST_CERT_INFO.Ptr
            pDetachedSig : WINTRUST_DETACHED_SIG_INFO.Ptr
        }
    }
}
struct WINTRUST_SIGNATURE_SETTINGS {
    cbStruct : UInt32
    dwIndex : UInt32
    dwFlags : WINTRUST_SIGNATURE_SETTINGS_FLAGS
    cSecondarySigs : UInt32
    dwVerifiedSigIndex : UInt32
    pCryptoPolicy : CERT_STRONG_SIGN_PARA.Ptr
}
struct WINTRUST_FILE_INFO {
    cbStruct : UInt32
    pcwszFilePath : PWSTR
    hFile : HANDLE
    pgKnownSubject : GUID.Ptr
}
struct WINTRUST_DETACHED_SIG_FILE_HANDLES {
    hContentFile : HANDLE
    hSignatureFile : HANDLE
}
struct WINTRUST_DETACHED_SIG_BLOBS {
    cbContentObject : Int64
    pbContentObject : UInt8.Ptr
    cbSignatureObject : UInt32
    pbSignatureObject : UInt8.Ptr
}
struct WINTRUST_DETACHED_SIG_INFO {
    cbStruct : UInt32
    dwUnionChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pDetachedSigHandles : WINTRUST_DETACHED_SIG_FILE_HANDLES.Ptr
            pDetachedSigBlobs : WINTRUST_DETACHED_SIG_BLOBS.Ptr
        }
    }
}
struct WINTRUST_CATALOG_INFO {
    cbStruct : UInt32
    dwCatalogVersion : UInt32
    pcwszCatalogFilePath : PWSTR
    pcwszMemberTag : PWSTR
    pcwszMemberFilePath : PWSTR
    hMemberFile : HANDLE
    pbCalculatedFileHash : UInt8.Ptr
    cbCalculatedFileHash : UInt32
    pcCatalogContext : CTL_CONTEXT.Ptr
    hCatAdmin : IntPtr
}
struct WINTRUST_BLOB_INFO {
    cbStruct : UInt32
    gSubject : GUID
    pcwszDisplayName : PWSTR
    cbMemObject : UInt32
    pbMemObject : UInt8.Ptr
    cbMemSignedMsg : UInt32
    pbMemSignedMsg : UInt8.Ptr
}
struct WINTRUST_SGNR_INFO {
    cbStruct : UInt32
    pcwszDisplayName : PWSTR
    psSignerInfo : CMSG_SIGNER_INFO.Ptr
    chStores : UInt32
    pahStores : HCERTSTORE.Ptr
}
struct WINTRUST_CERT_INFO {
    cbStruct : UInt32
    pcwszDisplayName : PWSTR
    psCertContext : CERT_CONTEXT.Ptr
    chStores : UInt32
    pahStores : HCERTSTORE.Ptr
    dwFlags : UInt32
    psftVerifyAsOf : FILETIME.Ptr
}
struct PFN_CPD_MEM_ALLOC extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
}
struct PFN_CPD_MEM_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PFN_CPD_ADD_STORE extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HCERTSTORE, BOOL]
}
struct PFN_CPD_ADD_SGNR extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, BOOL, UInt32, CRYPT_PROVIDER_SGNR.Ptr, BOOL]
}
struct PFN_CPD_ADD_CERT extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, UInt32, BOOL, UInt32, CERT_CONTEXT.Ptr, BOOL]
}
struct PFN_CPD_ADD_PRIVDATA extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, CRYPT_PROVIDER_PRIVDATA.Ptr, BOOL]
}
struct PFN_PROVIDER_INIT_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_OBJTRUST_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_SIGTRUST_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_CERTTRUST_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_FINALPOLICY_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_TESTFINALPOLICY_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_CLEANUP_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, HRESULT]
}
struct PFN_PROVIDER_CERTCHKPOLICY_CALL extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, UInt32, BOOL, UInt32, BOOL]
}
struct CRYPT_PROVIDER_DATA {
    cbStruct : UInt32
    pWintrustData : WINTRUST_DATA.Ptr
    fOpenedFile : BOOL
    hWndParent : HWND
    pgActionID : GUID.Ptr
    hProv : IntPtr
    dwError : UInt32
    dwRegSecuritySettings : UInt32
    dwRegPolicySettings : UInt32
    psPfns : CRYPT_PROVIDER_FUNCTIONS.Ptr
    cdwTrustStepErrors : UInt32
    padwTrustStepErrors : UInt32.Ptr
    chStores : UInt32
    pahStores : HCERTSTORE.Ptr
    dwEncoding : UInt32
    hMsg : Struct.Ptr
    csSigners : UInt32
    pasSigners : CRYPT_PROVIDER_SGNR.Ptr
    csProvPrivData : UInt32
    pasProvPrivData : CRYPT_PROVIDER_PRIVDATA.Ptr
    dwSubjectChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    pszUsageOID : PSTR
    fRecallWithState : BOOL
    sftSystemTime : FILETIME
    pszCTLSignerUsageOID : PSTR
    dwProvFlags : UInt32
    dwFinalError : UInt32
    pRequestUsage : CERT_USAGE_MATCH.Ptr
    dwTrustPubSettings : UInt32
    dwUIStateFlags : UInt32
    pSigState : CRYPT_PROVIDER_SIGSTATE.Ptr
    pSigSettings : WINTRUST_SIGNATURE_SETTINGS.Ptr
    struct _Anonymous_e__Union {
        union {
            pPDSip : PROVDATA_SIP.Ptr
        }
    }
}
struct CRYPT_PROVIDER_SIGSTATE {
    cbStruct : UInt32
    rhSecondarySigs : Struct.Ptr.Ptr
    hPrimarySig : Struct.Ptr
    fFirstAttemptMade : BOOL
    fNoMoreSigs : BOOL
    cSecondarySigs : UInt32
    dwCurrentIndex : UInt32
    fSupportMultiSig : BOOL
    dwCryptoPolicySupport : UInt32
    iAttemptCount : UInt32
    fCheckedSealing : BOOL
    pSealingSignature : SEALING_SIGNATURE_ATTRIBUTE.Ptr
}
struct CRYPT_PROVIDER_FUNCTIONS {
    cbStruct : UInt32
    pfnAlloc : PFN_CPD_MEM_ALLOC
    pfnFree : PFN_CPD_MEM_FREE
    pfnAddStore2Chain : PFN_CPD_ADD_STORE
    pfnAddSgnr2Chain : PFN_CPD_ADD_SGNR
    pfnAddCert2Chain : PFN_CPD_ADD_CERT
    pfnAddPrivData2Chain : PFN_CPD_ADD_PRIVDATA
    pfnInitialize : PFN_PROVIDER_INIT_CALL
    pfnObjectTrust : PFN_PROVIDER_OBJTRUST_CALL
    pfnSignatureTrust : PFN_PROVIDER_SIGTRUST_CALL
    pfnCertificateTrust : PFN_PROVIDER_CERTTRUST_CALL
    pfnFinalPolicy : PFN_PROVIDER_FINALPOLICY_CALL
    pfnCertCheckPolicy : PFN_PROVIDER_CERTCHKPOLICY_CALL
    pfnTestFinalPolicy : PFN_PROVIDER_TESTFINALPOLICY_CALL
    psUIpfns : CRYPT_PROVUI_FUNCS.Ptr
    pfnCleanupPolicy : PFN_PROVIDER_CLEANUP_CALL
}
struct PFN_PROVUI_CALL extends FunctionPointer {
    static Types := [HWND, CRYPT_PROVIDER_DATA.Ptr, BOOL]
}
struct CRYPT_PROVUI_FUNCS {
    cbStruct : UInt32
    psUIData : CRYPT_PROVUI_DATA.Ptr
    pfnOnMoreInfoClick : PFN_PROVUI_CALL
    pfnOnMoreInfoClickDefault : PFN_PROVUI_CALL
    pfnOnAdvancedClick : PFN_PROVUI_CALL
    pfnOnAdvancedClickDefault : PFN_PROVUI_CALL
}
struct CRYPT_PROVUI_DATA {
    cbStruct : UInt32
    dwFinalError : UInt32
    pYesButtonText : PWSTR
    pNoButtonText : PWSTR
    pMoreInfoButtonText : PWSTR
    pAdvancedLinkText : PWSTR
    pCopyActionText : PWSTR
    pCopyActionTextNoTS : PWSTR
    pCopyActionTextNotSigned : PWSTR
}
struct CRYPT_PROVIDER_SGNR {
    cbStruct : UInt32
    sftVerifyAsOf : FILETIME
    csCertChain : UInt32
    pasCertChain : CRYPT_PROVIDER_CERT.Ptr
    dwSignerType : UInt32
    psSigner : CMSG_SIGNER_INFO.Ptr
    dwError : UInt32
    csCounterSigners : UInt32
    pasCounterSigners : CRYPT_PROVIDER_SGNR.Ptr
    pChainContext : CERT_CHAIN_CONTEXT.Ptr
}
struct CRYPT_PROVIDER_CERT {
    cbStruct : UInt32
    pCert : CERT_CONTEXT.Ptr
    fCommercial : BOOL
    fTrustedRoot : BOOL
    fSelfSigned : BOOL
    fTestCert : BOOL
    dwRevokedReason : UInt32
    dwConfidence : UInt32
    dwError : UInt32
    pTrustListContext : CTL_CONTEXT.Ptr
    fTrustListSignerCert : BOOL
    pCtlContext : CTL_CONTEXT.Ptr
    dwCtlError : UInt32
    fIsCyclic : BOOL
    pChainElement : CERT_CHAIN_ELEMENT.Ptr
}
struct CRYPT_PROVIDER_PRIVDATA {
    cbStruct : UInt32
    gProviderID : GUID
    cbProvData : UInt32
    pvProvData : Struct.Ptr
}
struct PROVDATA_SIP {
    cbStruct : UInt32
    gSubject : GUID
    pSip : SIP_DISPATCH_INFO.Ptr
    pCATSip : SIP_DISPATCH_INFO.Ptr
    psSipSubjectInfo : SIP_SUBJECTINFO.Ptr
    psSipCATSubjectInfo : SIP_SUBJECTINFO.Ptr
    psIndirectData : SIP_INDIRECT_DATA.Ptr
}
struct CRYPT_TRUST_REG_ENTRY {
    cbStruct : UInt32
    pwszDLLName : PWSTR
    pwszFunctionName : PWSTR
}
struct CRYPT_REGISTER_ACTIONID {
    cbStruct : UInt32
    sInitProvider : CRYPT_TRUST_REG_ENTRY
    sObjectProvider : CRYPT_TRUST_REG_ENTRY
    sSignatureProvider : CRYPT_TRUST_REG_ENTRY
    sCertificateProvider : CRYPT_TRUST_REG_ENTRY
    sCertificatePolicyProvider : CRYPT_TRUST_REG_ENTRY
    sFinalPolicyProvider : CRYPT_TRUST_REG_ENTRY
    sTestPolicyProvider : CRYPT_TRUST_REG_ENTRY
    sCleanupProvider : CRYPT_TRUST_REG_ENTRY
}
struct PFN_ALLOCANDFILLDEFUSAGE extends FunctionPointer {
    static Types := [PSTR, CRYPT_PROVIDER_DEFUSAGE.Ptr, BOOL]
}
struct PFN_FREEDEFUSAGE extends FunctionPointer {
    static Types := [PSTR, CRYPT_PROVIDER_DEFUSAGE.Ptr, BOOL]
}
struct CRYPT_PROVIDER_REGDEFUSAGE {
    cbStruct : UInt32
    pgActionID : GUID.Ptr
    pwszDllName : PWSTR
    pwszLoadCallbackDataFunctionName : PSTR
    pwszFreeCallbackDataFunctionName : PSTR
}
struct CRYPT_PROVIDER_DEFUSAGE {
    cbStruct : UInt32
    gActionID : GUID
    pDefPolicyCallbackData : Struct.Ptr
    pDefSIPClientData : Struct.Ptr
}
struct SPC_SERIALIZED_OBJECT {
    ClassId : UInt8[16]
    SerializedData : CRYPT_INTEGER_BLOB
}
struct SPC_SIGINFO {
    dwSipVersion : UInt32
    gSIPGuid : GUID
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwReserved4 : UInt32
    dwReserved5 : UInt32
}
struct SPC_LINK {
    dwLinkChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pwszUrl : PWSTR
            Moniker : SPC_SERIALIZED_OBJECT
            pwszFile : PWSTR
        }
    }
}
struct SPC_PE_IMAGE_DATA {
    Flags : CRYPT_BIT_BLOB
    pFile : SPC_LINK.Ptr
}
struct SPC_INDIRECT_DATA_CONTENT {
    Data : CRYPT_ATTRIBUTE_TYPE_VALUE
    DigestAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Digest : CRYPT_INTEGER_BLOB
}
struct SPC_FINANCIAL_CRITERIA {
    fFinancialInfoAvailable : BOOL
    fMeetsCriteria : BOOL
}
struct SPC_IMAGE {
    pImageLink : SPC_LINK.Ptr
    Bitmap : CRYPT_INTEGER_BLOB
    Metafile : CRYPT_INTEGER_BLOB
    EnhancedMetafile : CRYPT_INTEGER_BLOB
    GifFile : CRYPT_INTEGER_BLOB
}
struct SPC_SP_AGENCY_INFO {
    pPolicyInformation : SPC_LINK.Ptr
    pwszPolicyDisplayText : PWSTR
    pLogoImage : SPC_IMAGE.Ptr
    pLogoLink : SPC_LINK.Ptr
}
struct SPC_STATEMENT_TYPE {
    cKeyPurposeId : UInt32
    rgpszKeyPurposeId : PSTR.Ptr
}
struct SPC_SP_OPUS_INFO {
    pwszProgramName : PWSTR
    pMoreInfo : SPC_LINK.Ptr
    pPublisherInfo : SPC_LINK.Ptr
}
struct CAT_NAMEVALUE {
    pwszTag : PWSTR
    fdwFlags : UInt32
    Value : CRYPT_INTEGER_BLOB
}
struct CAT_MEMBERINFO {
    pwszSubjGuid : PWSTR
    dwCertVersion : UInt32
}
struct CAT_MEMBERINFO2 {
    SubjectGuid : GUID
    dwCertVersion : UInt32
}
struct INTENT_TO_SEAL_ATTRIBUTE {
    version : UInt32
    seal : BOOLEAN
}
struct SEALING_SIGNATURE_ATTRIBUTE {
    version : UInt32
    signerIndex : UInt32
    signatureAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    encryptedDigest : CRYPT_INTEGER_BLOB
}
struct SEALING_TIMESTAMP_ATTRIBUTE {
    version : UInt32
    signerIndex : UInt32
    sealTimeStampToken : CRYPT_INTEGER_BLOB
}
struct WIN_CERTIFICATE {
    dwLength : UInt32
    wRevision : UInt16
    wCertificateType : UInt16
    bCertificate : UInt8[1]
}
struct WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT {
    hClientToken : HANDLE
    SubjectType : GUID.Ptr
    Subject : Struct.Ptr
}
struct WIN_TRUST_ACTDATA_SUBJECT_ONLY {
    SubjectType : GUID.Ptr
    Subject : Struct.Ptr
}
struct WIN_TRUST_SUBJECT_FILE {
    hFile : HANDLE
    lpPath : PWSTR
}
struct WIN_TRUST_SUBJECT_FILE_AND_DISPLAY {
    hFile : HANDLE
    lpPath : PWSTR
    lpDisplayName : PWSTR
}
struct WIN_SPUB_TRUSTED_PUBLISHER_DATA {
    hClientToken : HANDLE
    lpCertificate : WIN_CERTIFICATE.Ptr
}
struct WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO {
    Anonymous : this._Anonymous_e__Union
    pChainContext : CERT_CHAIN_CONTEXT.Ptr
    dwSignerType : UInt32
    pMsgSignerInfo : CMSG_SIGNER_INFO.Ptr
    dwError : UInt32
    cCounterSigner : UInt32
    rgpCounterSigner : WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO.Ptr.Ptr
    struct _Anonymous_e__Union {
        union {
            cbStruct : UInt32
            cbSize : UInt32 := this.Size
        }
    }
}
struct PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK extends FunctionPointer {
    static Types := [CRYPT_PROVIDER_DATA.Ptr, UInt32, UInt32, UInt32, WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO.Ptr.Ptr, Struct.Ptr, HRESULT]
}
struct WTD_GENERIC_CHAIN_POLICY_CREATE_INFO {
    Anonymous : this._Anonymous_e__Union
    hChainEngine : HCERTCHAINENGINE
    pChainPara : CERT_CHAIN_PARA.Ptr
    dwFlags : UInt32
    pvReserved : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            cbStruct : UInt32
            cbSize : UInt32 := this.Size
        }
    }
}
struct WTD_GENERIC_CHAIN_POLICY_DATA {
    Anonymous : this._Anonymous_e__Union
    pSignerChainInfo : WTD_GENERIC_CHAIN_POLICY_CREATE_INFO.Ptr
    pCounterSignerChainInfo : WTD_GENERIC_CHAIN_POLICY_CREATE_INFO.Ptr
    pfnPolicyCallback : PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK
    pvPolicyArg : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            cbStruct : UInt32
            cbSize : UInt32 := this.Size
        }
    }
}
struct DRIVER_VER_MAJORMINOR {
    dwMajor : UInt32
    dwMinor : UInt32
}
struct DRIVER_VER_INFO {
    cbStruct : UInt32
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
    dwPlatform : UInt32
    dwVersion : UInt32
    wszVersion : UInt16[260]
    wszSignedBy : UInt16[260]
    pcSignerCertContext : CERT_CONTEXT.Ptr
    sOSVersionLow : DRIVER_VER_MAJORMINOR
    sOSVersionHigh : DRIVER_VER_MAJORMINOR
    dwBuildNumberLow : UInt32
    dwBuildNumberHigh : UInt32
}
struct CONFIG_CI_PROV_INFO_RESULT {
    hr : HRESULT
    dwResult : UInt32
    dwPolicyIndex : UInt32
    fIsExplicitDeny : BOOLEAN
}
struct CONFIG_CI_PROV_INFO_RESULT2 {
    cbSize : UInt32 := this.Size
    hr : HRESULT
    dwResult : UInt32
    dwPolicyIndex : UInt32
    fIsExplicitDeny : BOOLEAN
    cbCalculatedFileHash : UInt32
    pbCalculatedFileHash : UInt8.Ptr
}
struct CONFIG_CI_PROV_INFO {
    cbSize : UInt32 := this.Size
    dwPolicies : UInt32
    pPolicies : CRYPT_INTEGER_BLOB.Ptr
    result : CONFIG_CI_PROV_INFO_RESULT
    dwScenario : UInt32
    result2 : CONFIG_CI_PROV_INFO_RESULT2.Ptr
}
