#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, SYSTEMTIME}

struct TIME_ZONE_INFORMATION {
    Bias : Int32
    StandardName : UInt16[32]
    StandardDate : SYSTEMTIME
    StandardBias : Int32
    DaylightName : UInt16[32]
    DaylightDate : SYSTEMTIME
    DaylightBias : Int32
}
struct DYNAMIC_TIME_ZONE_INFORMATION {
    Bias : Int32
    StandardName : UInt16[32]
    StandardDate : SYSTEMTIME
    StandardBias : Int32
    DaylightName : UInt16[32]
    DaylightDate : SYSTEMTIME
    DaylightBias : Int32
    TimeZoneKeyName : UInt16[128]
    DynamicDaylightTimeDisabled : BOOLEAN
}
