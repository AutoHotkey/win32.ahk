#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct Architecture extends Int32 {
    static None := 0
    static X86 := 1
    static X64 := 2
    static Arm64 := 4
    static All := 7
}
