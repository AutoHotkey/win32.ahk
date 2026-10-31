#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.PortableDevices\Types.ahk" {IPortableDevice}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct ENHANCED_STORAGE_PASSWORD_SILO_INFORMATION {
    CurrentAdminFailures : UInt8
    CurrentUserFailures : UInt8
    TotalUserAuthenticationCount : UInt32
    TotalAdminAuthenticationCount : UInt32
    FipsCompliant : BOOL
    SecurityIDAvailable : BOOL
    InitializeInProgress : BOOL
    ITMSArmed : BOOL
    ITMSArmable : BOOL
    UserCreated : BOOL
    ResetOnPORDefault : BOOL
    ResetOnPORCurrent : BOOL
    MaxAdminFailures : UInt8
    MaxUserFailures : UInt8
    TimeToCompleteInitialization : UInt32
    TimeRemainingToCompleteInitialization : UInt32
    MinTimeToAuthenticate : UInt32
    MaxAdminPasswordSize : UInt8
    MinAdminPasswordSize : UInt8
    MaxAdminHintSize : UInt8
    MaxUserPasswordSize : UInt8
    MinUserPasswordSize : UInt8
    MaxUserHintSize : UInt8
    MaxUserNameSize : UInt8
    MaxSiloNameSize : UInt8
    MaxChallengeSize : UInt16
}
struct ACT_AUTHORIZATION_STATE {
    ulState : UInt32
}
struct SILO_INFO {
    ulSTID : UInt32
    SpecificationMajor : UInt8
    SpecificationMinor : UInt8
    ImplementationMajor : UInt8
    ImplementationMinor : UInt8
    type : UInt8
    capabilities : UInt8
}
struct ACT_AUTHORIZATION_STATE_VALUE extends Int32 {
    static ACT_UNAUTHORIZED := 0
    static ACT_AUTHORIZED := 1
}
struct IEnumEnhancedStorageACT extends IUnknown {
    static IID := "{09B224BD-1335-4631-A7FF-CFD3A92646D7}"
    GetACTs(pppIEnhancedStorageACTs)
      => ComCall(3, this.p, IEnhancedStorageACT.Ptr.Ptr, pppIEnhancedStorageACTs, UInt32.Ptr, pppIEnhancedStorageACTs.Length)
    GetMatchingACT(szVolume, ppIEnhancedStorageACT)
      => ComCall(4, this.p, "Str", szVolume, IEnhancedStorageACT.Ptr, ppIEnhancedStorageACT)
}
struct IEnhancedStorageACT extends IUnknown {
    static IID := "{6E7781F4-E0F2-4239-B976-A01ABAB52930}"
    Authorize(hwndParent, dwFlags)
      => ComCall(3, this.p, UInt32, hwndParent, UInt32, dwFlags)
    Unauthorize()
      => ComCall(4, this.p)
    GetAuthorizationState(pState)
      => ComCall(5, this.p, ACT_AUTHORIZATION_STATE.Ptr, pState)
    GetMatchingVolume(ppwszVolume)
      => ComCall(6, this.p, PWSTR.Ptr, ppwszVolume)
    GetUniqueIdentity(ppwszIdentity)
      => ComCall(7, this.p, PWSTR.Ptr, ppwszIdentity)
    GetSilos(pppIEnhancedStorageSilos)
      => ComCall(8, this.p, IEnhancedStorageSilo.Ptr.Ptr, pppIEnhancedStorageSilos, UInt32.Ptr, pppIEnhancedStorageSilos.Length)
}
struct IEnhancedStorageACT2 extends IEnhancedStorageACT {
    static IID := "{4DA57D2E-8EB3-41F6-A07E-98B52B88242B}"
    GetDeviceName(ppwszDeviceName)
      => ComCall(9, this.p, PWSTR.Ptr, ppwszDeviceName)
    IsDeviceRemovable(pIsDeviceRemovable)
      => ComCall(10, this.p, BOOL.Ptr, pIsDeviceRemovable)
}
struct IEnhancedStorageACT3 extends IEnhancedStorageACT2 {
    static IID := "{022150A1-113D-11DF-BB61-001AA01BBC58}"
    UnauthorizeEx(dwFlags)
      => ComCall(11, this.p, UInt32, dwFlags)
    IsQueueFrozen(pIsQueueFrozen)
      => ComCall(12, this.p, BOOL.Ptr, pIsQueueFrozen)
    GetShellExtSupport(pShellExtSupport)
      => ComCall(13, this.p, BOOL.Ptr, pShellExtSupport)
}
struct IEnhancedStorageSilo extends IUnknown {
    static IID := "{5AEF78C6-2242-4703-BF49-44B29357A359}"
    GetInfo(pSiloInfo)
      => ComCall(3, this.p, SILO_INFO.Ptr, pSiloInfo)
    GetActions(pppIEnhancedStorageSiloActions)
      => ComCall(4, this.p, IEnhancedStorageSiloAction.Ptr.Ptr, pppIEnhancedStorageSiloActions, UInt32.Ptr, pppIEnhancedStorageSiloActions.Length)
    SendCommand(Command, pbCommandBuffer, pbResponseBuffer)
      => ComCall(5, this.p, UInt8, Command, UInt8.Ptr, pbCommandBuffer, UInt32, pbCommandBuffer.Length, UInt8.Ptr, pbResponseBuffer, UInt32.Ptr, pbResponseBuffer.Length)
    GetPortableDevice(ppIPortableDevice)
      => ComCall(6, this.p, IPortableDevice.Ptr, ppIPortableDevice)
    GetDevicePath(ppwszSiloDevicePath)
      => ComCall(7, this.p, PWSTR.Ptr, ppwszSiloDevicePath)
}
struct IEnhancedStorageSiloAction extends IUnknown {
    static IID := "{B6F7F311-206F-4FF8-9C4B-27EFEE77A86F}"
    GetName(ppwszActionName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszActionName)
    GetDescription(ppwszActionDescription)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszActionDescription)
    Invoke()
      => ComCall(5, this.p)
}
