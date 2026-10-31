#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct OOBE_COMPLETED_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
