#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct NAMED_PIPE_MODE extends UInt32 {
    static PIPE_WAIT := 0
    static PIPE_NOWAIT := 1
    static PIPE_READMODE_BYTE := 0
    static PIPE_READMODE_MESSAGE := 2
    static PIPE_CLIENT_END := 0
    static PIPE_SERVER_END := 1
    static PIPE_TYPE_BYTE := 0
    static PIPE_TYPE_MESSAGE := 4
    static PIPE_ACCEPT_REMOTE_CLIENTS := 0
    static PIPE_REJECT_REMOTE_CLIENTS := 8
}
