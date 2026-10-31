#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Networking.WinSock\Types.ahk" {SOCKADDR_STORAGE}

struct UAL_DATA_BLOB {
    Size : UInt32
    RoleGuid : GUID
    TenantId : GUID
    Address : SOCKADDR_STORAGE
    UserName : UInt16[260]
}
