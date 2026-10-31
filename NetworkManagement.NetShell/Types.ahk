#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

struct NS_CMD_FLAGS extends Int32 {
    static CMD_FLAG_PRIVATE := 1
    static CMD_FLAG_INTERACTIVE := 2
    static CMD_FLAG_LOCAL := 8
    static CMD_FLAG_ONLINE := 16
    static CMD_FLAG_HIDDEN := 32
    static CMD_FLAG_LIMIT_MASK := 65535
    static CMD_FLAG_PRIORITY := -2147483648
}
struct NS_REQS extends Int32 {
    static NS_REQ_ZERO := 0
    static NS_REQ_PRESENT := 1
    static NS_REQ_ALLOW_MULTIPLE := 2
    static NS_REQ_ONE_OR_MORE := 3
}
struct NS_EVENTS extends Int32 {
    static NS_EVENT_LOOP := 65536
    static NS_EVENT_LAST_N := 1
    static NS_EVENT_LAST_SECS := 2
    static NS_EVENT_FROM_N := 4
    static NS_EVENT_FROM_START := 8
}
struct NS_MODE_CHANGE extends Int32 {
    static NETSH_COMMIT := 0
    static NETSH_UNCOMMIT := 1
    static NETSH_FLUSH := 2
    static NETSH_COMMIT_STATE := 3
    static NETSH_SAVE := 4
}
struct TOKEN_VALUE {
    pwszToken : PWSTR
    dwValue : UInt32
}
struct PGET_RESOURCE_STRING_FN extends FunctionPointer {
    static Types := [UInt32, PWSTR, UInt32, UInt32]
}
struct PNS_CONTEXT_COMMIT_FN extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct PNS_CONTEXT_CONNECT_FN extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PNS_CONTEXT_DUMP_FN extends FunctionPointer {
    static Types := [PWSTR, PWSTR.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct PNS_DLL_STOP_FN extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct PNS_HELPER_START_FN extends FunctionPointer {
    static Types := [GUID.Ptr, UInt32, UInt32]
}
struct PNS_HELPER_STOP_FN extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct PFN_HANDLE_CMD extends FunctionPointer {
    static Types := [PWSTR, PWSTR.Ptr, UInt32, UInt32, UInt32, Struct.Ptr, BOOL.Ptr, UInt32]
}
struct PNS_OSVERSIONCHECK extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, PWSTR, PWSTR, PWSTR, UInt32, UInt32, BOOL]
}
struct NS_HELPER_ATTRIBUTES {
    Anonymous : this._Anonymous_e__Union
    guidHelper : GUID
    pfnStart : PNS_HELPER_START_FN
    pfnStop : PNS_HELPER_STOP_FN
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            _ullAlign : Int64
        }
        struct _Anonymous_e__Struct {
            dwVersion : UInt32
            dwReserved : UInt32
        }
    }
}
struct CMD_ENTRY {
    pwszCmdToken : PWSTR
    pfnCmdHandler : PFN_HANDLE_CMD
    dwShortCmdHelpToken : UInt32
    dwCmdHlpToken : UInt32
    dwFlags : UInt32
    pOsVersionCheck : PNS_OSVERSIONCHECK
}
struct CMD_GROUP_ENTRY {
    pwszCmdGroupToken : PWSTR
    dwShortCmdHelpToken : UInt32
    ulCmdGroupSize : UInt32
    dwFlags : UInt32
    pCmdGroup : CMD_ENTRY.Ptr
    pOsVersionCheck : PNS_OSVERSIONCHECK
}
struct NS_CONTEXT_ATTRIBUTES {
    Anonymous : this._Anonymous_e__Union
    pwszContext : PWSTR
    guidHelper : GUID
    dwFlags : UInt32
    ulPriority : UInt32
    ulNumTopCmds : UInt32
    pTopCmds : CMD_ENTRY.Ptr
    ulNumGroups : UInt32
    pCmdGroups : CMD_GROUP_ENTRY.Ptr
    pfnCommitFn : PNS_CONTEXT_COMMIT_FN
    pfnDumpFn : PNS_CONTEXT_DUMP_FN
    pfnConnectFn : PNS_CONTEXT_CONNECT_FN
    pReserved : Struct.Ptr
    pfnOsVersionCheck : PNS_OSVERSIONCHECK
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            _ullAlign : Int64
        }
        struct _Anonymous_e__Struct {
            dwVersion : UInt32
            dwReserved : UInt32
        }
    }
}
struct TAG_TYPE {
    pwszTag : PWSTR
    dwRequired : UInt32
    bPresent : BOOL
}
struct PNS_DLL_INIT_FN extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32]
}
