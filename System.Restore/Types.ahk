#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {CHAR, FILETIME, WIN32_ERROR}

struct RESTOREPOINTINFO_TYPE extends UInt32 {
    static APPLICATION_INSTALL := 0
    static APPLICATION_UNINSTALL := 1
    static DEVICE_DRIVER_INSTALL := 10
    static MODIFY_SETTINGS := 12
    static CANCELLED_OPERATION := 13
}
struct RESTOREPOINTINFO_EVENT_TYPE extends UInt32 {
    static BEGIN_NESTED_SYSTEM_CHANGE := 102
    static BEGIN_SYSTEM_CHANGE := 100
    static END_NESTED_SYSTEM_CHANGE := 103
    static END_SYSTEM_CHANGE := 101
}
struct RESTOREPOINTINFOA {
    dwEventType : RESTOREPOINTINFO_EVENT_TYPE
    dwRestorePtType : RESTOREPOINTINFO_TYPE
    llSequenceNumber : Int64
    szDescription : CHAR[64]
}
struct RESTOREPOINTINFOW {
    dwEventType : RESTOREPOINTINFO_EVENT_TYPE
    dwRestorePtType : RESTOREPOINTINFO_TYPE
    llSequenceNumber : Int64
    szDescription : UInt16[256]
}
struct RESTOREPOINTINFOEX {
    ftCreation : FILETIME
    dwEventType : UInt32
    dwRestorePtType : UInt32
    dwRPNum : UInt32
    szDescription : UInt16[256]
}
struct STATEMGRSTATUS {
    nStatus : WIN32_ERROR
    llSequenceNumber : Int64
}
