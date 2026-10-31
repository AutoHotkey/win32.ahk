#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct WindowsMediaLibrarySharingDeviceAuthorizationStatus extends Int32 {
    static DEVICE_AUTHORIZATION_UNKNOWN := 0
    static DEVICE_AUTHORIZATION_ALLOWED := 1
    static DEVICE_AUTHORIZATION_DENIED := 2
}
struct IWindowsMediaLibrarySharingDeviceProperty extends IDispatch {
    static IID := "{81E26927-7A7D-40A7-81D4-BDDC02960E3E}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_Value(value)
      => ComCall(8, this.p, VARIANT.Ptr, value)
}
struct IWindowsMediaLibrarySharingDeviceProperties extends IDispatch {
    static IID := "{C4623214-6B06-40C5-A623-B2FF4C076BFD}"
    get_Item(index, property)
      => ComCall(7, this.p, Int32, index, IWindowsMediaLibrarySharingDeviceProperty.Ptr, property)
    get_Count(count)
      => ComCall(8, this.p, Int32.Ptr, count)
    GetProperty(name, property)
      => ComCall(9, this.p, BSTR, name, IWindowsMediaLibrarySharingDeviceProperty.Ptr, property)
}
struct IWindowsMediaLibrarySharingDevice extends IDispatch {
    static IID := "{3DCCC293-4FD9-4191-A25B-8E57C5D27BD4}"
    get_DeviceID(deviceID)
      => ComCall(7, this.p, BSTR.Ptr, deviceID)
    get_Authorization(authorization)
      => ComCall(8, this.p, WindowsMediaLibrarySharingDeviceAuthorizationStatus.Ptr, authorization)
    put_Authorization(authorization)
      => ComCall(9, this.p, WindowsMediaLibrarySharingDeviceAuthorizationStatus, authorization)
    get_Properties(deviceProperties)
      => ComCall(10, this.p, IWindowsMediaLibrarySharingDeviceProperties.Ptr, deviceProperties)
}
struct IWindowsMediaLibrarySharingDevices extends IDispatch {
    static IID := "{1803F9D6-FE6D-4546-BF5B-992FE8EC12D1}"
    get_Item(index, device)
      => ComCall(7, this.p, Int32, index, IWindowsMediaLibrarySharingDevice.Ptr, device)
    get_Count(count)
      => ComCall(8, this.p, Int32.Ptr, count)
    GetDevice(deviceID, device)
      => ComCall(9, this.p, BSTR, deviceID, IWindowsMediaLibrarySharingDevice.Ptr, device)
}
struct IWindowsMediaLibrarySharingServices extends IDispatch {
    static IID := "{01F5F85E-0A81-40DA-A7C8-21EF3AF8440C}"
    showShareMediaCPL(device)
      => ComCall(7, this.p, BSTR, device)
    get_userHomeMediaSharingState(sharingEnabled)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, sharingEnabled)
    put_userHomeMediaSharingState(sharingEnabled)
      => ComCall(9, this.p, VARIANT_BOOL, sharingEnabled)
    get_userHomeMediaSharingLibraryName(libraryName)
      => ComCall(10, this.p, BSTR.Ptr, libraryName)
    put_userHomeMediaSharingLibraryName(libraryName)
      => ComCall(11, this.p, BSTR, libraryName)
    get_computerHomeMediaSharingAllowedState(sharingAllowed)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, sharingAllowed)
    put_computerHomeMediaSharingAllowedState(sharingAllowed)
      => ComCall(13, this.p, VARIANT_BOOL, sharingAllowed)
    get_userInternetMediaSharingState(sharingEnabled)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, sharingEnabled)
    put_userInternetMediaSharingState(sharingEnabled)
      => ComCall(15, this.p, VARIANT_BOOL, sharingEnabled)
    get_computerInternetMediaSharingAllowedState(sharingAllowed)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, sharingAllowed)
    put_computerInternetMediaSharingAllowedState(sharingAllowed)
      => ComCall(17, this.p, VARIANT_BOOL, sharingAllowed)
    get_internetMediaSharingSecurityGroup(securityGroup)
      => ComCall(18, this.p, BSTR.Ptr, securityGroup)
    put_internetMediaSharingSecurityGroup(securityGroup)
      => ComCall(19, this.p, BSTR, securityGroup)
    get_allowSharingToAllDevices(sharingEnabled)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, sharingEnabled)
    put_allowSharingToAllDevices(sharingEnabled)
      => ComCall(21, this.p, VARIANT_BOOL, sharingEnabled)
    setDefaultAuthorization(MACAddresses, friendlyName, authorization)
      => ComCall(22, this.p, BSTR, MACAddresses, BSTR, friendlyName, VARIANT_BOOL, authorization)
    setAuthorizationState(MACAddress, authorizationState)
      => ComCall(23, this.p, BSTR, MACAddress, VARIANT_BOOL, authorizationState)
    getAllDevices(devices)
      => ComCall(24, this.p, IWindowsMediaLibrarySharingDevices.Ptr, devices)
    get_customSettingsApplied(customSettingsApplied)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, customSettingsApplied)
}
