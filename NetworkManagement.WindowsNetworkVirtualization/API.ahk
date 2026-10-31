#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}

WnvOpen()
  => DllCall("wnvapi.dll\WnvOpen", HANDLE)
WnvRequestNotification(WnvHandle, NotificationParam, Overlapped, BytesTransferred)
  => DllCall("wnvapi.dll\WnvRequestNotification", HANDLE, WnvHandle, WNV_NOTIFICATION_PARAM.Ptr, NotificationParam, OVERLAPPED.Ptr, Overlapped, UInt32.Ptr, BytesTransferred, UInt32)
