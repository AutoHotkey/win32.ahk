#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct REGISTER_APPLICATION_RESTART_FLAGS extends UInt32 {
    static RESTART_NO_CRASH := 1
    static RESTART_NO_HANG := 2
    static RESTART_NO_PATCH := 4
    static RESTART_NO_REBOOT := 8
}
