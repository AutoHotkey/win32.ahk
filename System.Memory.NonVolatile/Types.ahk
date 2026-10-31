#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct NV_MEMORY_RANGE {
    BaseAddress : Struct.Ptr
    Length : IntPtr
}
