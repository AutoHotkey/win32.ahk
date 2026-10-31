#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

AMGetErrorText(hr, pbuffer)
  => DllCall("QUARTZ.dll\AMGetErrorTextW", HRESULT, hr, PWSTR, pbuffer, UInt32, pbuffer.Length, UInt32)
