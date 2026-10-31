#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct DPI_AWARENESS_CONTEXT {
    Value : Struct.Ptr
}
struct DPI_AWARENESS extends Int32 {
    static DPI_AWARENESS_INVALID := -1
    static DPI_AWARENESS_UNAWARE := 0
    static DPI_AWARENESS_SYSTEM_AWARE := 1
    static DPI_AWARENESS_PER_MONITOR_AWARE := 2
}
struct DPI_HOSTING_BEHAVIOR extends Int32 {
    static DPI_HOSTING_BEHAVIOR_INVALID := -1
    static DPI_HOSTING_BEHAVIOR_DEFAULT := 0
    static DPI_HOSTING_BEHAVIOR_MIXED := 1
}
struct DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS extends Int32 {
    static DCDC_DEFAULT := 0
    static DCDC_DISABLE_FONT_UPDATE := 1
    static DCDC_DISABLE_RELAYOUT := 2
}
struct DIALOG_DPI_CHANGE_BEHAVIORS extends Int32 {
    static DDC_DEFAULT := 0
    static DDC_DISABLE_ALL := 1
    static DDC_DISABLE_RESIZE := 2
    static DDC_DISABLE_CONTROL_RELAYOUT := 4
}
struct PROCESS_DPI_AWARENESS extends Int32 {
    static PROCESS_DPI_UNAWARE := 0
    static PROCESS_SYSTEM_DPI_AWARE := 1
    static PROCESS_PER_MONITOR_DPI_AWARE := 2
}
struct MONITOR_DPI_TYPE extends Int32 {
    static MDT_EFFECTIVE_DPI := 0
    static MDT_ANGULAR_DPI := 1
    static MDT_RAW_DPI := 2
    static MDT_DEFAULT := 0
}
