#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR}

ldap_open(HostName, PortNumber)
  => DllCall("WLDAP32.dll\ldap_openW", "Str", HostName, UInt32, PortNumber, LDAP.Ptr)
