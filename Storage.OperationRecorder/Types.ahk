#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct OPERATION_START_FLAGS extends UInt32 {
    static OPERATION_START_TRACE_CURRENT_THREAD := 1
}
struct OPERATION_END_PARAMETERS_FLAGS extends UInt32 {
    static OPERATION_END_DISCARD := 1
}
struct OPERATION_START_PARAMETERS {
    Version : UInt32
    OperationId : UInt32
    Flags : OPERATION_START_FLAGS
}
struct OPERATION_END_PARAMETERS {
    Version : UInt32
    OperationId : UInt32
    Flags : OPERATION_END_PARAMETERS_FLAGS
}
