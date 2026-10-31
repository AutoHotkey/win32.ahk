#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HANDLE, HWND, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {ALG_ID}

struct SAFER_COMPUTE_TOKEN_FROM_LEVEL_FLAGS extends UInt32 {
    static SAFER_TOKEN_NULL_IF_EQUAL := 1
    static SAFER_TOKEN_COMPARE_ONLY := 2
    static SAFER_TOKEN_MAKE_INERT := 4
    static SAFER_TOKEN_WANT_FLAGS := 8
}
struct SAFER_CODE_PROPERTIES_V1 {
    cbSize : UInt32 := this.Size
    dwCheckFlags : UInt32
    ImagePath : PWSTR
    hImageFileHandle : HANDLE
    UrlZoneId : UInt32
    ImageHash : UInt8[64]
    dwImageHashSize : UInt32
    ImageSize : Int64
    HashAlgorithm : ALG_ID
    pByteBlock : UInt8.Ptr
    hWndParent : HWND
    dwWVTUIChoice : UInt32
}
struct SAFER_CODE_PROPERTIES_V2 {
    cbSize : UInt32 := this.Size
    dwCheckFlags : UInt32
    ImagePath : PWSTR
    hImageFileHandle : HANDLE
    UrlZoneId : UInt32
    ImageHash : UInt8[64]
    dwImageHashSize : UInt32
    ImageSize : Int64
    HashAlgorithm : ALG_ID
    pByteBlock : UInt8.Ptr
    hWndParent : HWND
    dwWVTUIChoice : UInt32
    PackageMoniker : PWSTR
    PackagePublisher : PWSTR
    PackageName : PWSTR
    PackageVersion : Int64
    PackageIsFramework : BOOL
}
struct SAFER_POLICY_INFO_CLASS extends Int32 {
    static SaferPolicyLevelList := 1
    static SaferPolicyEnableTransparentEnforcement := 2
    static SaferPolicyDefaultLevel := 3
    static SaferPolicyEvaluateUserScope := 4
    static SaferPolicyScopeFlags := 5
    static SaferPolicyDefaultLevelFlags := 6
    static SaferPolicyAuthenticodeEnabled := 7
}
struct SAFER_OBJECT_INFO_CLASS extends Int32 {
    static SaferObjectLevelId := 1
    static SaferObjectScopeId := 2
    static SaferObjectFriendlyName := 3
    static SaferObjectDescription := 4
    static SaferObjectBuiltin := 5
    static SaferObjectDisallowed := 6
    static SaferObjectDisableMaxPrivilege := 7
    static SaferObjectInvertDeletedPrivileges := 8
    static SaferObjectDeletedPrivileges := 9
    static SaferObjectDefaultOwner := 10
    static SaferObjectSidsToDisable := 11
    static SaferObjectRestrictedSidsInverted := 12
    static SaferObjectRestrictedSidsAdded := 13
    static SaferObjectAllIdentificationGuids := 14
    static SaferObjectSingleIdentification := 15
    static SaferObjectExtendedError := 16
}
struct SAFER_IDENTIFICATION_TYPES extends Int32 {
    static SaferIdentityDefault := 0
    static SaferIdentityTypeImageName := 1
    static SaferIdentityTypeImageHash := 2
    static SaferIdentityTypeUrlZone := 3
    static SaferIdentityTypeCertificate := 4
}
struct SAFER_IDENTIFICATION_HEADER {
    dwIdentificationType : SAFER_IDENTIFICATION_TYPES
    cbStructSize : UInt32
    IdentificationGuid : GUID
    lastModified : FILETIME
}
struct SAFER_PATHNAME_IDENTIFICATION {
    header : SAFER_IDENTIFICATION_HEADER
    Description : UInt16[256]
    ImageName : PWSTR
    dwSaferFlags : UInt32
}
struct SAFER_HASH_IDENTIFICATION {
    header : SAFER_IDENTIFICATION_HEADER
    Description : UInt16[256]
    FriendlyName : UInt16[256]
    HashSize : UInt32
    ImageHash : UInt8[64]
    HashAlgorithm : ALG_ID
    ImageSize : Int64
    dwSaferFlags : UInt32
}
struct SAFER_HASH_IDENTIFICATION2 {
    hashIdentification : SAFER_HASH_IDENTIFICATION
    HashSize : UInt32
    ImageHash : UInt8[64]
    HashAlgorithm : ALG_ID
}
struct SAFER_URLZONE_IDENTIFICATION {
    header : SAFER_IDENTIFICATION_HEADER
    UrlZoneId : UInt32
    dwSaferFlags : UInt32
}
