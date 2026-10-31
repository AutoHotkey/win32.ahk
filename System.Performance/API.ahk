#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

InstallPerfDll(szComputerName?, lpIniFile, dwFlags)
  => DllCall("loadperf.dll\InstallPerfDllW", "Str", szComputerName?, "Str", lpIniFile, IntPtr, dwFlags, UInt32)
QueryPerformanceCounter(lpPerformanceCount)
  => DllCall("KERNEL32.dll\QueryPerformanceCounter", Int64.Ptr, lpPerformanceCount, BOOL)
QueryPerformanceFrequency(lpFrequency)
  => DllCall("KERNEL32.dll\QueryPerformanceFrequency", Int64.Ptr, lpFrequency, BOOL)
