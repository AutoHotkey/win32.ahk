#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

MAPIFreeBuffer(pv)
  => DllCall("MAPI32.dll\MAPIFreeBuffer", Struct.Ptr, pv, UInt32)
