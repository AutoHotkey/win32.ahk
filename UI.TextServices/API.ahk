#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT}

DoMsCtfMonitor(dwFlags, hEventForServiceStop)
  => DllCall("MsCtfMonitor.dll\DoMsCtfMonitor", UInt32, dwFlags, HANDLE, hEventForServiceStop, BOOL)
InitLocalMsCtfMonitor(dwFlags)
  => DllCall("MsCtfMonitor.dll\InitLocalMsCtfMonitor", UInt32, dwFlags, "HRESULT")
UninitLocalMsCtfMonitor()
  => DllCall("MsCtfMonitor.dll\UninitLocalMsCtfMonitor", "HRESULT")
