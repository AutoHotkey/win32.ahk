#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PSTR}

struct PFNCHECKCONNECTIONWIZARD extends FunctionPointer {
    static Types := [UInt32, UInt32.Ptr, UInt32]
}
struct PFNSETSHELLNEXT extends FunctionPointer {
    static Types := [PSTR, UInt32]
}
