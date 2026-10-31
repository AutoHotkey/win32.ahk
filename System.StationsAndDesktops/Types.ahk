#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HWND, LPARAM, LUID, PSTR, PWSTR}

struct BROADCAST_SYSTEM_MESSAGE_FLAGS extends UInt32 {
    static BSF_ALLOWSFW := 128
    static BSF_FLUSHDISK := 4
    static BSF_FORCEIFHUNG := 32
    static BSF_IGNORECURRENTTASK := 2
    static BSF_NOHANG := 8
    static BSF_NOTIMEOUTIFNOTHUNG := 64
    static BSF_POSTMESSAGE := 16
    static BSF_QUERY := 1
    static BSF_SENDNOTIFYMESSAGE := 256
    static BSF_LUID := 1024
    static BSF_RETURNHDESK := 512
}
struct BROADCAST_SYSTEM_MESSAGE_INFO extends UInt32 {
    static BSM_ALLCOMPONENTS := 0
    static BSM_ALLDESKTOPS := 16
    static BSM_APPLICATIONS := 8
}
struct USER_OBJECT_INFORMATION_INDEX extends Int32 {
    static UOI_FLAGS := 1
    static UOI_HEAPSIZE := 5
    static UOI_IO := 6
    static UOI_NAME := 2
    static UOI_TYPE := 3
    static UOI_USER_SID := 4
}
struct DESKTOP_CONTROL_FLAGS extends UInt32 {
    static DF_ALLOWOTHERACCOUNTHOOK := 1
}
struct DESKTOP_ACCESS_FLAGS extends UInt32 {
    static DESKTOP_DELETE := 65536
    static DESKTOP_READ_CONTROL := 131072
    static DESKTOP_WRITE_DAC := 262144
    static DESKTOP_WRITE_OWNER := 524288
    static DESKTOP_SYNCHRONIZE := 1048576
    static DESKTOP_READOBJECTS := 1
    static DESKTOP_CREATEWINDOW := 2
    static DESKTOP_CREATEMENU := 4
    static DESKTOP_HOOKCONTROL := 8
    static DESKTOP_JOURNALRECORD := 16
    static DESKTOP_JOURNALPLAYBACK := 32
    static DESKTOP_ENUMERATE := 64
    static DESKTOP_WRITEOBJECTS := 128
    static DESKTOP_SWITCHDESKTOP := 256
}
struct WINSTAENUMPROCA extends FunctionPointer {
    static Types := [PSTR, LPARAM, BOOL]
}
struct WINSTAENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, LPARAM, BOOL]
}
struct DESKTOPENUMPROCA extends FunctionPointer {
    static Types := [PSTR, LPARAM, BOOL]
}
struct DESKTOPENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, LPARAM, BOOL]
}
struct HWINSTA {
    Value : IntPtr
}
struct HDESK {
    Value : IntPtr
}
struct USEROBJECTFLAGS {
    fInherit : BOOL
    fReserved : BOOL
    dwFlags : UInt32
}
struct BSMINFO {
    cbSize : UInt32 := this.Size
    hdesk : HDESK
    hwnd : HWND
    luid : LUID
}
