#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct PERCEPTION_PAYLOAD_FIELD {
    FieldId : GUID
    OffsetInBytes : UInt32
    SizeInBytes : UInt32
}
struct PERCEPTION_STATE_STREAM_TIMESTAMPS {
    InputTimestampInQpcCounts : Int64
    AvailableTimestampInQpcCounts : Int64
}
