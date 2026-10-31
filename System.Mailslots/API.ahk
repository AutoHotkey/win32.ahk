#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}

CreateMailslot(lpName, nMaxMessageSize, lReadTimeout, lpSecurityAttributes?)
  => DllCall("KERNEL32.dll\CreateMailslotW", "Str", lpName, UInt32, nMaxMessageSize, UInt32, lReadTimeout, SECURITY_ATTRIBUTES.Ptr, lpSecurityAttributes?, HANDLE)
GetMailslotInfo(hMailslot, lpMaxMessageSize?, lpNextSize?, lpMessageCount?, lpReadTimeout?)
  => DllCall("KERNEL32.dll\GetMailslotInfo", HANDLE, hMailslot, UInt32.Ptr, lpMaxMessageSize?, UInt32.Ptr, lpNextSize?, UInt32.Ptr, lpMessageCount?, UInt32.Ptr, lpReadTimeout?, BOOL)
SetMailslotInfo(hMailslot, lReadTimeout)
  => DllCall("KERNEL32.dll\SetMailslotInfo", HANDLE, hMailslot, UInt32, lReadTimeout, BOOL)
