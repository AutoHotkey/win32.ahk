#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

CeipIsOptedIn()
  => DllCall("KERNEL32.dll\CeipIsOptedIn", BOOL)
