#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

Netbios(pncb)
  => DllCall("NETAPI32.dll\Netbios", NCB.Ptr, pncb, UInt8)
