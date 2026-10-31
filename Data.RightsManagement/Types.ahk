#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

struct DRMID {
    uVersion : UInt32
    wszIDType : PWSTR
    wszID : PWSTR
}
struct DRMTIMETYPE extends Int32 {
    static DRMTIMETYPE_SYSTEMUTC := 0
    static DRMTIMETYPE_SYSTEMLOCAL := 1
}
struct DRMENCODINGTYPE extends Int32 {
    static DRMENCODINGTYPE_BASE64 := 0
    static DRMENCODINGTYPE_STRING := 1
    static DRMENCODINGTYPE_LONG := 2
    static DRMENCODINGTYPE_TIME := 3
    static DRMENCODINGTYPE_UINT := 4
    static DRMENCODINGTYPE_RAW := 5
}
struct DRMATTESTTYPE extends Int32 {
    static DRMATTESTTYPE_FULLENVIRONMENT := 0
    static DRMATTESTTYPE_HASHONLY := 1
}
struct DRMSPECTYPE extends Int32 {
    static DRMSPECTYPE_UNKNOWN := 0
    static DRMSPECTYPE_FILENAME := 1
}
struct DRMSECURITYPROVIDERTYPE extends Int32 {
    static DRMSECURITYPROVIDERTYPE_SOFTWARESECREP := 0
}
struct DRMGLOBALOPTIONS extends Int32 {
    static DRMGLOBALOPTIONS_USE_WINHTTP := 0
    static DRMGLOBALOPTIONS_USE_SERVERSECURITYPROCESSOR := 1
}
struct DRMBOUNDLICENSEPARAMS {
    uVersion : UInt32
    hEnablingPrincipal : UInt32
    hSecureStore : UInt32
    wszRightsRequested : PWSTR
    wszRightsGroup : PWSTR
    idResource : DRMID
    cAuthenticatorCount : UInt32
    rghAuthenticators : UInt32.Ptr
    wszDefaultEnablingPrincipalCredentials : PWSTR
    dwFlags : UInt32
}
struct DRM_LICENSE_ACQ_DATA {
    uVersion : UInt32
    wszURL : PWSTR
    wszLocalFilename : PWSTR
    pbPostData : UInt8.Ptr
    dwPostDataSize : UInt32
    wszFriendlyName : PWSTR
}
struct DRM_ACTSERV_INFO {
    uVersion : UInt32
    wszPubKey : PWSTR
    wszURL : PWSTR
}
struct DRM_CLIENT_VERSION_INFO {
    uStructVersion : UInt32
    dwVersion : UInt32[4]
    wszHierarchy : UInt16[256]
    wszProductId : UInt16[256]
    wszProductDescription : UInt16[256]
}
struct DRM_STATUS_MSG extends Int32 {
    static DRM_MSG_ACTIVATE_MACHINE := 0
    static DRM_MSG_ACTIVATE_GROUPIDENTITY := 1
    static DRM_MSG_ACQUIRE_LICENSE := 2
    static DRM_MSG_ACQUIRE_ADVISORY := 3
    static DRM_MSG_SIGN_ISSUANCE_LICENSE := 4
    static DRM_MSG_ACQUIRE_CLIENTLICENSOR := 5
    static DRM_MSG_ACQUIRE_ISSUANCE_LICENSE_TEMPLATE := 6
}
struct DRM_USAGEPOLICY_TYPE extends Int32 {
    static DRM_USAGEPOLICY_TYPE_BYNAME := 0
    static DRM_USAGEPOLICY_TYPE_BYPUBLICKEY := 1
    static DRM_USAGEPOLICY_TYPE_BYDIGEST := 2
    static DRM_USAGEPOLICY_TYPE_OSEXCLUSION := 3
}
struct DRM_DISTRIBUTION_POINT_INFO extends Int32 {
    static DRM_DISTRIBUTION_POINT_LICENSE_ACQUISITION := 0
    static DRM_DISTRIBUTION_POINT_PUBLISHING := 1
    static DRM_DISTRIBUTION_POINT_REFERRAL_INFO := 2
}
struct DRMCALLBACK extends FunctionPointer {
    static Types := [DRM_STATUS_MSG, HRESULT, Struct.Ptr, Struct.Ptr, HRESULT]
}
