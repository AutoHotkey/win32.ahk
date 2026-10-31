#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, PWSTR}
#Import "..\System.Threading\Types.ahk" {LPTHREAD_START_ROUTINE}

WscGetAntiMalwareUri(ppszUri)
  => DllCall("WSCAPI.dll\WscGetAntiMalwareUri", PWSTR.Ptr, ppszUri, "HRESULT")
WscGetSecurityProviderHealth(Providers, pHealth)
  => DllCall("WSCAPI.dll\WscGetSecurityProviderHealth", UInt32, Providers, WSC_SECURITY_PROVIDER_HEALTH.Ptr, pHealth, "HRESULT")
WscQueryAntiMalwareUri()
  => DllCall("WSCAPI.dll\WscQueryAntiMalwareUri", "HRESULT")
WscRegisterForChanges(Reserved, phCallbackRegistration, lpCallbackAddress, pContext)
  => DllCall("WSCAPI.dll\WscRegisterForChanges", Struct.Ptr, Reserved, HANDLE.Ptr, phCallbackRegistration, LPTHREAD_START_ROUTINE, lpCallbackAddress, Struct.Ptr, pContext, "HRESULT")
WscRegisterForUserNotifications()
  => DllCall("WSCAPI.dll\WscRegisterForUserNotifications", "HRESULT")
WscUnRegisterChanges(hRegistrationHandle)
  => DllCall("WSCAPI.dll\WscUnRegisterChanges", HANDLE, hRegistrationHandle, "HRESULT")
