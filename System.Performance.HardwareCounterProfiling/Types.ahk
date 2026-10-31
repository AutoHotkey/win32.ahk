#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct HARDWARE_COUNTER_TYPE extends Int32 {
    static PMCCounter := 0
    static MaxHardwareCounterType := 1
}
struct HARDWARE_COUNTER_DATA {
    Type : HARDWARE_COUNTER_TYPE
    Reserved : UInt32
    Value : Int64
}
struct PERFORMANCE_DATA {
    Size : UInt16
    Version : UInt8
    HwCountersCount : UInt8
    ContextSwitchCount : UInt32
    WaitReasonBitMap : Int64
    CycleTime : Int64
    RetryCount : UInt32
    Reserved : UInt32
    HwCounters : HARDWARE_COUNTER_DATA[16]
}
