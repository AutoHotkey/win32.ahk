#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct WEBAUTHN_RP_ENTITY_INFORMATION {
    dwVersion : UInt32
    pwszId : PWSTR
    pwszName : PWSTR
    pwszIcon : PWSTR
}
struct WEBAUTHN_USER_ENTITY_INFORMATION {
    dwVersion : UInt32
    cbId : UInt32
    pbId : UInt8.Ptr
    pwszName : PWSTR
    pwszIcon : PWSTR
    pwszDisplayName : PWSTR
}
struct WEBAUTHN_CLIENT_DATA {
    dwVersion : UInt32
    cbClientDataJSON : UInt32
    pbClientDataJSON : UInt8.Ptr
    pwszHashAlgId : PWSTR
}
struct WEBAUTHN_COSE_CREDENTIAL_PARAMETER {
    dwVersion : UInt32
    pwszCredentialType : PWSTR
    lAlg : Int32
}
struct WEBAUTHN_COSE_CREDENTIAL_PARAMETERS {
    cCredentialParameters : UInt32
    pCredentialParameters : WEBAUTHN_COSE_CREDENTIAL_PARAMETER.Ptr
}
struct WEBAUTHN_CREDENTIAL {
    dwVersion : UInt32
    cbId : UInt32
    pbId : UInt8.Ptr
    pwszCredentialType : PWSTR
}
struct WEBAUTHN_CREDENTIALS {
    cCredentials : UInt32
    pCredentials : WEBAUTHN_CREDENTIAL.Ptr
}
struct WEBAUTHN_CREDENTIAL_EX {
    dwVersion : UInt32
    cbId : UInt32
    pbId : UInt8.Ptr
    pwszCredentialType : PWSTR
    dwTransports : UInt32
}
struct WEBAUTHN_CREDENTIAL_LIST {
    cCredentials : UInt32
    ppCredentials : WEBAUTHN_CREDENTIAL_EX.Ptr.Ptr
}
struct CTAPCBOR_HYBRID_STORAGE_LINKED_DATA {
    dwVersion : UInt32
    cbContactId : UInt32
    pbContactId : UInt8.Ptr
    cbLinkId : UInt32
    pbLinkId : UInt8.Ptr
    cbLinkSecret : UInt32
    pbLinkSecret : UInt8.Ptr
    cbPublicKey : UInt32
    pbPublicKey : UInt8.Ptr
    pwszAuthenticatorName : PWSTR
    wEncodedTunnelServerDomain : UInt16
}
struct WEBAUTHN_AUTHENTICATOR_DETAILS_OPTIONS {
    dwVersion : UInt32
}
struct WEBAUTHN_AUTHENTICATOR_DETAILS {
    dwVersion : UInt32
    cbAuthenticatorId : UInt32
    pbAuthenticatorId : UInt8.Ptr
    pwszAuthenticatorName : PWSTR
    cbAuthenticatorLogo : UInt32
    pbAuthenticatorLogo : UInt8.Ptr
    bLocked : BOOL
}
struct WEBAUTHN_AUTHENTICATOR_DETAILS_LIST {
    cAuthenticatorDetails : UInt32
    ppAuthenticatorDetails : WEBAUTHN_AUTHENTICATOR_DETAILS.Ptr.Ptr
}
struct WEBAUTHN_CREDENTIAL_DETAILS {
    dwVersion : UInt32
    cbCredentialID : UInt32
    pbCredentialID : UInt8.Ptr
    pRpInformation : WEBAUTHN_RP_ENTITY_INFORMATION.Ptr
    pUserInformation : WEBAUTHN_USER_ENTITY_INFORMATION.Ptr
    bRemovable : BOOL
    bBackedUp : BOOL
    pwszAuthenticatorName : PWSTR
    cbAuthenticatorLogo : UInt32
    pbAuthenticatorLogo : UInt8.Ptr
    bThirdPartyPayment : BOOL
    dwTransports : UInt32
}
struct WEBAUTHN_CREDENTIAL_DETAILS_LIST {
    cCredentialDetails : UInt32
    ppCredentialDetails : WEBAUTHN_CREDENTIAL_DETAILS.Ptr.Ptr
}
struct WEBAUTHN_GET_CREDENTIALS_OPTIONS {
    dwVersion : UInt32
    pwszRpId : PWSTR
    bBrowserInPrivateMode : BOOL
}
struct WEBAUTHN_HMAC_SECRET_SALT {
    cbFirst : UInt32
    pbFirst : UInt8.Ptr
    cbSecond : UInt32
    pbSecond : UInt8.Ptr
}
struct WEBAUTHN_CRED_WITH_HMAC_SECRET_SALT {
    cbCredID : UInt32
    pbCredID : UInt8.Ptr
    pHmacSecretSalt : WEBAUTHN_HMAC_SECRET_SALT.Ptr
}
struct WEBAUTHN_HMAC_SECRET_SALT_VALUES {
    pGlobalHmacSalt : WEBAUTHN_HMAC_SECRET_SALT.Ptr
    cCredWithHmacSecretSaltList : UInt32
    pCredWithHmacSecretSaltList : WEBAUTHN_CRED_WITH_HMAC_SECRET_SALT.Ptr
}
struct WEBAUTHN_CRED_PROTECT_EXTENSION_IN {
    dwCredProtect : UInt32
    bRequireCredProtect : BOOL
}
struct WEBAUTHN_CRED_BLOB_EXTENSION {
    cbCredBlob : UInt32
    pbCredBlob : UInt8.Ptr
}
struct WEBAUTHN_EXTENSION {
    pwszExtensionIdentifier : PWSTR
    cbExtension : UInt32
    pvExtension : Struct.Ptr
}
struct WEBAUTHN_EXTENSIONS {
    cExtensions : UInt32
    pExtensions : WEBAUTHN_EXTENSION.Ptr
}
struct WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS {
    dwVersion : UInt32
    dwTimeoutMilliseconds : UInt32
    CredentialList : WEBAUTHN_CREDENTIALS
    Extensions : WEBAUTHN_EXTENSIONS
    dwAuthenticatorAttachment : UInt32
    bRequireResidentKey : BOOL
    dwUserVerificationRequirement : UInt32
    dwAttestationConveyancePreference : UInt32
    dwFlags : UInt32
    pCancellationId : GUID.Ptr
    pExcludeCredentialList : WEBAUTHN_CREDENTIAL_LIST.Ptr
    dwEnterpriseAttestation : UInt32
    dwLargeBlobSupport : UInt32
    bPreferResidentKey : BOOL
    bBrowserInPrivateMode : BOOL
    bEnablePrf : BOOL
    pLinkedDevice : CTAPCBOR_HYBRID_STORAGE_LINKED_DATA.Ptr
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
    pPRFGlobalEval : WEBAUTHN_HMAC_SECRET_SALT.Ptr
    cCredentialHints : UInt32
    ppwszCredentialHints : PWSTR.Ptr
    bThirdPartyPayment : BOOL
    pwszRemoteWebOrigin : PWSTR
    cbPublicKeyCredentialCreationOptionsJSON : UInt32
    pbPublicKeyCredentialCreationOptionsJSON : UInt8.Ptr
    cbAuthenticatorId : UInt32
    pbAuthenticatorId : UInt8.Ptr
}
struct WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS {
    dwVersion : UInt32
    dwTimeoutMilliseconds : UInt32
    CredentialList : WEBAUTHN_CREDENTIALS
    Extensions : WEBAUTHN_EXTENSIONS
    dwAuthenticatorAttachment : UInt32
    dwUserVerificationRequirement : UInt32
    dwFlags : UInt32
    pwszU2fAppId : PWSTR
    pbU2fAppId : BOOL.Ptr
    pCancellationId : GUID.Ptr
    pAllowCredentialList : WEBAUTHN_CREDENTIAL_LIST.Ptr
    dwCredLargeBlobOperation : UInt32
    cbCredLargeBlob : UInt32
    pbCredLargeBlob : UInt8.Ptr
    pHmacSecretSaltValues : WEBAUTHN_HMAC_SECRET_SALT_VALUES.Ptr
    bBrowserInPrivateMode : BOOL
    pLinkedDevice : CTAPCBOR_HYBRID_STORAGE_LINKED_DATA.Ptr
    bAutoFill : BOOL
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
    cCredentialHints : UInt32
    ppwszCredentialHints : PWSTR.Ptr
    pwszRemoteWebOrigin : PWSTR
    cbPublicKeyCredentialRequestOptionsJSON : UInt32
    pbPublicKeyCredentialRequestOptionsJSON : UInt8.Ptr
    cbAuthenticatorId : UInt32
    pbAuthenticatorId : UInt8.Ptr
}
struct WEBAUTHN_X5C {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct WEBAUTHN_COMMON_ATTESTATION {
    dwVersion : UInt32
    pwszAlg : PWSTR
    lAlg : Int32
    cbSignature : UInt32
    pbSignature : UInt8.Ptr
    cX5c : UInt32
    pX5c : WEBAUTHN_X5C.Ptr
    pwszVer : PWSTR
    cbCertInfo : UInt32
    pbCertInfo : UInt8.Ptr
    cbPubArea : UInt32
    pbPubArea : UInt8.Ptr
}
struct WEBAUTHN_CREDENTIAL_ATTESTATION {
    dwVersion : UInt32
    pwszFormatType : PWSTR
    cbAuthenticatorData : UInt32
    pbAuthenticatorData : UInt8.Ptr
    cbAttestation : UInt32
    pbAttestation : UInt8.Ptr
    dwAttestationDecodeType : UInt32
    pvAttestationDecode : Struct.Ptr
    cbAttestationObject : UInt32
    pbAttestationObject : UInt8.Ptr
    cbCredentialId : UInt32
    pbCredentialId : UInt8.Ptr
    Extensions : WEBAUTHN_EXTENSIONS
    dwUsedTransport : UInt32
    bEpAtt : BOOL
    bLargeBlobSupported : BOOL
    bResidentKey : BOOL
    bPrfEnabled : BOOL
    cbUnsignedExtensionOutputs : UInt32
    pbUnsignedExtensionOutputs : UInt8.Ptr
    pHmacSecret : WEBAUTHN_HMAC_SECRET_SALT.Ptr
    bThirdPartyPayment : BOOL
    dwTransports : UInt32
    cbClientDataJSON : UInt32
    pbClientDataJSON : UInt8.Ptr
    cbRegistrationResponseJSON : UInt32
    pbRegistrationResponseJSON : UInt8.Ptr
}
struct WEBAUTHN_ASSERTION {
    dwVersion : UInt32
    cbAuthenticatorData : UInt32
    pbAuthenticatorData : UInt8.Ptr
    cbSignature : UInt32
    pbSignature : UInt8.Ptr
    Credential : WEBAUTHN_CREDENTIAL
    cbUserId : UInt32
    pbUserId : UInt8.Ptr
    Extensions : WEBAUTHN_EXTENSIONS
    cbCredLargeBlob : UInt32
    pbCredLargeBlob : UInt8.Ptr
    dwCredLargeBlobStatus : UInt32
    pHmacSecret : WEBAUTHN_HMAC_SECRET_SALT.Ptr
    dwUsedTransport : UInt32
    cbUnsignedExtensionOutputs : UInt32
    pbUnsignedExtensionOutputs : UInt8.Ptr
    cbClientDataJSON : UInt32
    pbClientDataJSON : UInt8.Ptr
    cbAuthenticationResponseJSON : UInt32
    pbAuthenticationResponseJSON : UInt8.Ptr
}
struct EXPERIMENTAL_PLUGIN_AUTHENTICATOR_STATE extends Int32 {
    static PluginAuthenticatorState_Unknown := 0
    static PluginAuthenticatorState_Disabled := 1
    static PluginAuthenticatorState_Enabled := 2
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS {
    pwszAuthenticatorName : PWSTR
    pwszPluginClsId : PWSTR
    pwszPluginRpId : PWSTR
    pwszLightThemeLogo : PWSTR
    pwszDarkThemeLogo : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_RESPONSE {
    cbOpSignPubKey : UInt32
    pbOpSignPubKey : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS {
    pwszAuthenticatorName : PWSTR
    pwszPluginClsId : PWSTR
    pwszNewPluginClsId : PWSTR
    pwszLightThemeLogo : PWSTR
    pwszDarkThemeLogo : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS {
    cbCredentialId : UInt32
    pbCredentialId : UInt8.Ptr
    pwszRpId : PWSTR
    pwszRpName : PWSTR
    cbUserId : UInt32
    pbUserId : UInt8.Ptr
    pwszUserName : PWSTR
    pwszUserDisplayName : PWSTR
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS_LIST {
    pwszPluginClsId : PWSTR
    cCredentialDetails : UInt32
    pCredentialDetails : EXPERIMENTAL_WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS.Ptr.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE extends Int32 {
    static PerformUv := 1
    static GetUvCount := 2
    static GetPubKey := 3
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV {
    hwnd : HWND
    transactionId : GUID.Ptr
    type : EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE
    pwszUsername : PWSTR
    pwszContext : PWSTR
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_PERFORM_UV_RESPONSE {
    cbResponse : UInt32
    pbResponse : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS {
    dwVersion : UInt32
    lUp : Int32
    lUv : Int32
    lRequireResidentKey : Int32
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY {
    dwVersion : UInt32
    lKty : Int32
    lAlg : Int32
    lCrv : Int32
    cbX : UInt32
    pbX : UInt8.Ptr
    cbY : UInt32
    pbY : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION {
    dwVersion : UInt32
    pKeyAgreement : EXPERIMENTAL_WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY.Ptr
    cbEncryptedSalt : UInt32
    pbEncryptedSalt : UInt8.Ptr
    cbSaltAuth : UInt32
    pbSaltAuth : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST {
    dwVersion : UInt32
    cbRpId : UInt32
    pbRpId : UInt8.Ptr
    cbClientDataHash : UInt32
    pbClientDataHash : UInt8.Ptr
    pRpInformation : WEBAUTHN_RP_ENTITY_INFORMATION.Ptr
    pUserInformation : WEBAUTHN_USER_ENTITY_INFORMATION.Ptr
    WebAuthNCredentialParameters : WEBAUTHN_COSE_CREDENTIAL_PARAMETERS
    CredentialList : WEBAUTHN_CREDENTIAL_LIST
    cbCborExtensionsMap : UInt32
    pbCborExtensionsMap : UInt8.Ptr
    pAuthenticatorOptions : EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS.Ptr
    fEmptyPinAuth : BOOL
    cbPinAuth : UInt32
    pbPinAuth : UInt8.Ptr
    lHmacSecretExt : Int32
    pHmacSecretMcExtension : EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION.Ptr
    lPrfExt : Int32
    cbHmacSecretSaltValues : UInt32
    pbHmacSecretSaltValues : UInt8.Ptr
    dwCredProtect : UInt32
    dwPinProtocol : UInt32
    dwEnterpriseAttestation : UInt32
    cbCredBlobExt : UInt32
    pbCredBlobExt : UInt8.Ptr
    lLargeBlobKeyExt : Int32
    dwLargeBlobSupport : UInt32
    lMinPinLengthExt : Int32
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST {
    dwVersion : UInt32
    pwszRpId : PWSTR
    cbRpId : UInt32
    pbRpId : UInt8.Ptr
    cbClientDataHash : UInt32
    pbClientDataHash : UInt8.Ptr
    CredentialList : WEBAUTHN_CREDENTIAL_LIST
    cbCborExtensionsMap : UInt32
    pbCborExtensionsMap : UInt8.Ptr
    pAuthenticatorOptions : EXPERIMENTAL_WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS.Ptr
    fEmptyPinAuth : BOOL
    cbPinAuth : UInt32
    pbPinAuth : UInt8.Ptr
    pHmacSaltExtension : EXPERIMENTAL_WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION.Ptr
    cbHmacSecretSaltValues : UInt32
    pbHmacSecretSaltValues : UInt8.Ptr
    dwPinProtocol : UInt32
    lCredBlobExt : Int32
    lLargeBlobKeyExt : Int32
    dwCredLargeBlobOperation : UInt32
    cbCredLargeBlobCompressed : UInt32
    pbCredLargeBlobCompressed : UInt8.Ptr
    dwCredLargeBlobOriginalSize : UInt32
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_CTAPCBOR_GET_ASSERTION_RESPONSE {
    WebAuthNAssertion : WEBAUTHN_ASSERTION
    pUserInformation : WEBAUTHN_USER_ENTITY_INFORMATION.Ptr
    dwNumberOfCredentials : UInt32
    lUserSelected : Int32
    cbLargeBlobKey : UInt32
    pbLargeBlobKey : UInt8.Ptr
    cbUnsignedExtensionOutputs : UInt32
    pbUnsignedExtensionOutputs : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_STATUS_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct AUTHENTICATOR_STATE extends Int32 {
    static AuthenticatorState_Disabled := 0
    static AuthenticatorState_Enabled := 1
}
struct WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS {
    pwszAuthenticatorName : PWSTR
    rclsid : GUID.Ptr
    pwszPluginRpId : PWSTR
    pwszLightThemeLogoSvg : PWSTR
    pwszDarkThemeLogoSvg : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
    cSupportedRpIds : UInt32
    ppwszSupportedRpIds : PWSTR.Ptr
}
struct WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_OPTIONS_2 {
    pwszAuthenticatorName : PWSTR
    pClsid : GUID.Ptr
    pwszPluginRpId : PWSTR
    pwszLightThemeLogoSvg : PWSTR
    pwszDarkThemeLogoSvg : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
    cSupportedRpIds : UInt32
    ppwszSupportedRpIds : PWSTR.Ptr
    pwszUserVerificationKeyName : PWSTR
}
struct WEBAUTHN_PLUGIN_ADD_AUTHENTICATOR_RESPONSE {
    cbOpSignPubKey : UInt32
    pbOpSignPubKey : UInt8.Ptr
}
struct WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS {
    pwszAuthenticatorName : PWSTR
    rclsid : GUID.Ptr
    rclsidNew : GUID.Ptr
    pwszLightThemeLogoSvg : PWSTR
    pwszDarkThemeLogoSvg : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
    cSupportedRpIds : UInt32
    ppwszSupportedRpIds : PWSTR.Ptr
}
struct WEBAUTHN_PLUGIN_UPDATE_AUTHENTICATOR_DETAILS_2 {
    pwszAuthenticatorName : PWSTR
    pClsid : GUID.Ptr
    pClsidNew : GUID.Ptr
    pwszLightThemeLogoSvg : PWSTR
    pwszDarkThemeLogoSvg : PWSTR
    cbAuthenticatorInfo : UInt32
    pbAuthenticatorInfo : UInt8.Ptr
    cSupportedRpIds : UInt32
    ppwszSupportedRpIds : PWSTR.Ptr
    pwszUserVerificationKeyName : PWSTR
}
struct WEBAUTHN_PLUGIN_CREDENTIAL_DETAILS {
    cbCredentialId : UInt32
    pbCredentialId : UInt8.Ptr
    pwszRpId : PWSTR
    pwszRpName : PWSTR
    cbUserId : UInt32
    pbUserId : UInt8.Ptr
    pwszUserName : PWSTR
    pwszUserDisplayName : PWSTR
}
struct WEBAUTHN_PLUGIN_PERFORM_UV_OPERATION_TYPE extends Int32 {
    static PerformUserVerification := 1
    static GetUserVerificationCount := 2
    static GetPublicKey := 3
}
struct WEBAUTHN_PLUGIN_USER_VERIFICATION_REQUEST {
    hwnd : HWND
    rguidTransactionId : GUID.Ptr
    pwszUsername : PWSTR
    pwszDisplayHint : PWSTR
}
struct WEBAUTHN_PLUGIN_USER_VERIFICATION_REQUEST_2 {
    hwnd : HWND
    pGuidTransactionId : GUID.Ptr
    pwszUsername : PWSTR
    pwszDisplayHint : PWSTR
    cbBufferToSign : UInt32
    pbBufferToSign : UInt8.Ptr
}
struct WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS {
    dwVersion : UInt32
    lUp : Int32
    lUv : Int32
    lRequireResidentKey : Int32
}
struct WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY {
    dwVersion : UInt32
    lKty : Int32
    lAlg : Int32
    lCrv : Int32
    cbX : UInt32
    pbX : UInt8.Ptr
    cbY : UInt32
    pbY : UInt8.Ptr
}
struct WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION {
    dwVersion : UInt32
    pKeyAgreement : WEBAUTHN_CTAPCBOR_ECC_PUBLIC_KEY.Ptr
    cbEncryptedSalt : UInt32
    pbEncryptedSalt : UInt8.Ptr
    cbSaltAuth : UInt32
    pbSaltAuth : UInt8.Ptr
}
struct WEBAUTHN_CTAPCBOR_MAKE_CREDENTIAL_REQUEST {
    dwVersion : UInt32
    cbRpId : UInt32
    pbRpId : UInt8.Ptr
    cbClientDataHash : UInt32
    pbClientDataHash : UInt8.Ptr
    pRpInformation : WEBAUTHN_RP_ENTITY_INFORMATION.Ptr
    pUserInformation : WEBAUTHN_USER_ENTITY_INFORMATION.Ptr
    WebAuthNCredentialParameters : WEBAUTHN_COSE_CREDENTIAL_PARAMETERS
    CredentialList : WEBAUTHN_CREDENTIAL_LIST
    cbCborExtensionsMap : UInt32
    pbCborExtensionsMap : UInt8.Ptr
    pAuthenticatorOptions : WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS.Ptr
    fEmptyPinAuth : BOOL
    cbPinAuth : UInt32
    pbPinAuth : UInt8.Ptr
    lHmacSecretExt : Int32
    pHmacSecretMcExtension : WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION.Ptr
    lPrfExt : Int32
    cbHmacSecretSaltValues : UInt32
    pbHmacSecretSaltValues : UInt8.Ptr
    dwCredProtect : UInt32
    dwPinProtocol : UInt32
    dwEnterpriseAttestation : UInt32
    cbCredBlobExt : UInt32
    pbCredBlobExt : UInt8.Ptr
    lLargeBlobKeyExt : Int32
    dwLargeBlobSupport : UInt32
    lMinPinLengthExt : Int32
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
}
struct WEBAUTHN_CTAPCBOR_GET_ASSERTION_REQUEST {
    dwVersion : UInt32
    pwszRpId : PWSTR
    cbRpId : UInt32
    pbRpId : UInt8.Ptr
    cbClientDataHash : UInt32
    pbClientDataHash : UInt8.Ptr
    CredentialList : WEBAUTHN_CREDENTIAL_LIST
    cbCborExtensionsMap : UInt32
    pbCborExtensionsMap : UInt8.Ptr
    pAuthenticatorOptions : WEBAUTHN_CTAPCBOR_AUTHENTICATOR_OPTIONS.Ptr
    fEmptyPinAuth : BOOL
    cbPinAuth : UInt32
    pbPinAuth : UInt8.Ptr
    pHmacSaltExtension : WEBAUTHN_CTAPCBOR_HMAC_SALT_EXTENSION.Ptr
    cbHmacSecretSaltValues : UInt32
    pbHmacSecretSaltValues : UInt8.Ptr
    dwPinProtocol : UInt32
    lCredBlobExt : Int32
    lLargeBlobKeyExt : Int32
    dwCredLargeBlobOperation : UInt32
    cbCredLargeBlobCompressed : UInt32
    pbCredLargeBlobCompressed : UInt8.Ptr
    dwCredLargeBlobOriginalSize : UInt32
    cbJsonExt : UInt32
    pbJsonExt : UInt8.Ptr
}
struct WEBAUTHN_CTAPCBOR_GET_ASSERTION_RESPONSE {
    WebAuthNAssertion : WEBAUTHN_ASSERTION
    pUserInformation : WEBAUTHN_USER_ENTITY_INFORMATION.Ptr
    dwNumberOfCredentials : UInt32
    lUserSelected : Int32
    cbLargeBlobKey : UInt32
    pbLargeBlobKey : UInt8.Ptr
    cbUnsignedExtensionOutputs : UInt32
    pbUnsignedExtensionOutputs : UInt8.Ptr
}
struct WEBAUTHN_PLUGIN_STATUS_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct WEBAUTHN_PLUGIN_REQUEST_TYPE extends Int32 {
    static WEBAUTHN_PLUGIN_REQUEST_TYPE_CTAP2_CBOR := 1
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST {
    hWnd : HWND
    transactionId : GUID
    cbRequestSignature : UInt32
    pbRequestSignature : UInt8.Ptr
    cbEncodedRequest : UInt32
    pbEncodedRequest : UInt8.Ptr
}
struct WEBAUTHN_PLUGIN_OPERATION_REQUEST {
    hWnd : HWND
    transactionId : GUID
    cbRequestSignature : UInt32
    pbRequestSignature : UInt8.Ptr
    requestType : WEBAUTHN_PLUGIN_REQUEST_TYPE
    cbEncodedRequest : UInt32
    pbEncodedRequest : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE {
    cbEncodedResponse : UInt32
    pbEncodedResponse : UInt8.Ptr
}
struct WEBAUTHN_PLUGIN_OPERATION_RESPONSE {
    cbEncodedResponse : UInt32
    pbEncodedResponse : UInt8.Ptr
}
struct EXPERIMENTAL_WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST {
    transactionId : GUID
    cbRequestSignature : UInt32
    pbRequestSignature : UInt8.Ptr
}
struct WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST {
    transactionId : GUID
    cbRequestSignature : UInt32
    pbRequestSignature : UInt8.Ptr
}
struct PLUGIN_LOCK_STATUS extends Int32 {
    static PluginLocked := 0
    static PluginUnlocked := 1
}
struct EXPERIMENTAL_IPluginAuthenticator extends IUnknown {
    static IID := "{E6466E9A-B2F3-47C5-B88D-89BC14A8D998}"
    EXPERIMENTAL_PluginMakeCredential(request, response)
      => ComCall(3, this.p, EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST.Ptr, request, EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE.Ptr.Ptr, response)
    EXPERIMENTAL_PluginGetAssertion(request, response)
      => ComCall(4, this.p, EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_REQUEST.Ptr, request, EXPERIMENTAL_WEBAUTHN_PLUGIN_OPERATION_RESPONSE.Ptr.Ptr, response)
    EXPERIMENTAL_PluginCancelOperation(request)
      => ComCall(5, this.p, EXPERIMENTAL_WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST.Ptr, request)
}
struct IPluginAuthenticator extends IUnknown {
    static IID := "{D26BCF6F-B54C-43FF-9F06-D5BF148625F7}"
    MakeCredential(request, response)
      => ComCall(3, this.p, WEBAUTHN_PLUGIN_OPERATION_REQUEST.Ptr, request, WEBAUTHN_PLUGIN_OPERATION_RESPONSE.Ptr, response)
    GetAssertion(request, response)
      => ComCall(4, this.p, WEBAUTHN_PLUGIN_OPERATION_REQUEST.Ptr, request, WEBAUTHN_PLUGIN_OPERATION_RESPONSE.Ptr, response)
    CancelOperation(request)
      => ComCall(5, this.p, WEBAUTHN_PLUGIN_CANCEL_OPERATION_REQUEST.Ptr, request)
    GetLockStatus(lockStatus)
      => ComCall(6, this.p, PLUGIN_LOCK_STATUS.Ptr, lockStatus)
}
