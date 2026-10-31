#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

GetExtensionVersion(pVer)
  => DllCall("RpcProxy.dll\GetExtensionVersion", HSE_VERSION_INFO.Ptr, pVer, BOOL)
GetFilterVersion(pVer)
  => DllCall("RpcProxy.dll\GetFilterVersion", HTTP_FILTER_VERSION.Ptr, pVer, BOOL)
HttpExtensionProc(pECB)
  => DllCall("RpcProxy.dll\HttpExtensionProc", EXTENSION_CONTROL_BLOCK.Ptr, pECB, UInt32)
HttpFilterProc(pfc, NotificationType, pvNotification)
  => DllCall("RpcProxy.dll\HttpFilterProc", HTTP_FILTER_CONTEXT.Ptr, pfc, UInt32, NotificationType, Struct.Ptr, pvNotification, UInt32)
