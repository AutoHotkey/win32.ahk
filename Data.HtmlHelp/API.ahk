#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HWND, PWSTR}

HtmlHelp(hwndCaller?, pszFile, uCommand, dwData)
  => DllCall("hhctrl.ocx\HtmlHelpW", HWND, hwndCaller?, "Str", pszFile, UInt32, uCommand, IntPtr, dwData, HWND)
