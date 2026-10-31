#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

OfflineFilesEnable(bEnable, pbRebootRequired)
  => DllCall("CSCAPI.dll\OfflineFilesEnable", BOOL, bEnable, BOOL.Ptr, pbRebootRequired, UInt32)
OfflineFilesQueryStatus(pbActive?, pbEnabled?)
  => DllCall("CSCAPI.dll\OfflineFilesQueryStatus", BOOL.Ptr, pbActive?, BOOL.Ptr, pbEnabled?, UInt32)
OfflineFilesQueryStatusEx(pbActive?, pbEnabled?, pbAvailable?)
  => DllCall("CSCAPI.dll\OfflineFilesQueryStatusEx", BOOL.Ptr, pbActive?, BOOL.Ptr, pbEnabled?, BOOL.Ptr, pbAvailable?, UInt32)
OfflineFilesStart()
  => DllCall("CSCAPI.dll\OfflineFilesStart", UInt32)
