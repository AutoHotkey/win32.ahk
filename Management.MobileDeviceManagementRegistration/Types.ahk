#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

struct MANAGEMENT_SERVICE_INFO {
    pszMDMServiceUri : PWSTR
    pszAuthenticationUri : PWSTR
}
struct MANAGEMENT_REGISTRATION_INFO {
    fDeviceRegisteredWithManagement : BOOL
    dwDeviceRegistionKind : UInt32
    pszUPN : PWSTR
    pszMDMServiceUri : PWSTR
}
struct REGISTRATION_INFORMATION_CLASS extends Int32 {
    static DeviceRegistrationBasicInfo := 1
    static MaxDeviceInfoClass := 2
}
