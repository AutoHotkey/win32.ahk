#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

DirectDrawEnumerate(lpCallback, lpContext)
  => DllCall("DDRAW.dll\DirectDrawEnumerateW", LPDDENUMCALLBACKW, lpCallback, Struct.Ptr, lpContext, "HRESULT")
