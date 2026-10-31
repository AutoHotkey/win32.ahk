#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}

FreeInterfaceContextTable(InterfaceContextTable)
  => DllCall("OnDemandConnRouteHelper.dll\FreeInterfaceContextTable", NET_INTERFACE_CONTEXT_TABLE.Ptr, InterfaceContextTable, "void")
GetInterfaceContextTableForHostName(HostName?, ProxyName?, Flags, ConnectionProfileFilterRawData?, InterfaceContextTable)
  => DllCall("OnDemandConnRouteHelper.dll\GetInterfaceContextTableForHostName", "Str", HostName?, "Str", ProxyName?, UInt32, Flags, UInt8.Ptr, ConnectionProfileFilterRawData?, UInt32, ConnectionProfileFilterRawData?.Size ?? 0, NET_INTERFACE_CONTEXT_TABLE.Ptr.Ptr, InterfaceContextTable, "HRESULT")
OnDemandGetRoutingHint(destinationHostName, interfaceIndex)
  => DllCall("OnDemandConnRouteHelper.dll\OnDemandGetRoutingHint", "Str", destinationHostName, UInt32.Ptr, interfaceIndex, "HRESULT")
OnDemandRegisterNotification(callback, callbackContext?, registrationHandle)
  => DllCall("OnDemandConnRouteHelper.dll\OnDemandRegisterNotification", ONDEMAND_NOTIFICATION_CALLBACK, callback, Struct.Ptr, callbackContext?, HANDLE.Ptr, registrationHandle, "HRESULT")
OnDemandUnRegisterNotification(registrationHandle)
  => DllCall("OnDemandConnRouteHelper.dll\OnDemandUnRegisterNotification", HANDLE, registrationHandle, "HRESULT")
WcmFreeMemory(pMemory)
  => DllCall("wcmapi.dll\WcmFreeMemory", Struct.Ptr, pMemory, "void")
WcmGetProfileList(ppProfileList)
  => DllCall("wcmapi.dll\WcmGetProfileList", "Ptr", 0, WCM_PROFILE_INFO_LIST.Ptr.Ptr, ppProfileList, UInt32)
WcmQueryProperty(pInterface?, strProfileName?, Property, pdwDataSize, ppData)
  => DllCall("wcmapi.dll\WcmQueryProperty", GUID.Ptr, pInterface?, "Str", strProfileName?, WCM_PROPERTY, Property, "Ptr", 0, UInt32.Ptr, pdwDataSize, UInt8.Ptr.Ptr, ppData, UInt32)
WcmSetProfileList(pProfileList, dwPosition, fIgnoreUnknownProfiles)
  => DllCall("wcmapi.dll\WcmSetProfileList", WCM_PROFILE_INFO_LIST.Ptr, pProfileList, UInt32, dwPosition, BOOL, fIgnoreUnknownProfiles, "Ptr", 0, UInt32)
WcmSetProperty(pInterface?, strProfileName?, Property, pbData?)
  => DllCall("wcmapi.dll\WcmSetProperty", GUID.Ptr, pInterface?, "Str", strProfileName?, WCM_PROPERTY, Property, "Ptr", 0, UInt32, pbData?.Length ?? 0, UInt8.Ptr, pbData?, UInt32)
