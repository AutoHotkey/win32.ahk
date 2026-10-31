#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct SUBSCRIBED_MESSAGE {
    cbPayloadHint : UInt32
    payload : UInt8[1]
}
