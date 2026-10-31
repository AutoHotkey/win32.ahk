#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

IsDestinationReachable(lpszDestination, lpQOCInfo)
  => DllCall("SensApi.dll\IsDestinationReachableW", "Str", lpszDestination, QOCINFO.Ptr, lpQOCInfo, BOOL)
IsNetworkAlive(lpdwFlags)
  => DllCall("SensApi.dll\IsNetworkAlive", UInt32.Ptr, lpdwFlags, BOOL)
