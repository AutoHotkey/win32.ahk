#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

WTSStartRemoteControlSession(pTargetServerName, TargetLogonId, HotkeyVk, HotkeyModifiers)
  => DllCall("WTSAPI32.dll\WTSStartRemoteControlSessionW", "Str", pTargetServerName, UInt32, TargetLogonId, UInt8, HotkeyVk, UInt16, HotkeyModifiers, BOOL)
WTSStopRemoteControlSession(LogonId)
  => DllCall("WTSAPI32.dll\WTSStopRemoteControlSession", UInt32, LogonId, BOOL)
