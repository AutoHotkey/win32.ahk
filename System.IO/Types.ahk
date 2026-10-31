#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, NTSTATUS}

struct OVERLAPPED {
    Internal : IntPtr
    InternalHigh : IntPtr
    Anonymous : this._Anonymous_e__Union
    hEvent : HANDLE
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Pointer : Struct.Ptr
        }
        struct _Anonymous_e__Struct {
            Offset : UInt32
            OffsetHigh : UInt32
        }
    }
}
struct OVERLAPPED_ENTRY {
    lpCompletionKey : IntPtr
    lpOverlapped : OVERLAPPED.Ptr
    Internal : IntPtr
    dwNumberOfBytesTransferred : UInt32
}
struct LPOVERLAPPED_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [UInt32, UInt32, OVERLAPPED.Ptr, "Void"]
}
struct IO_STATUS_BLOCK {
    Anonymous : this._Anonymous_e__Union
    Information : IntPtr
    struct _Anonymous_e__Union {
        union {
            Status : NTSTATUS
            Pointer : Struct.Ptr
        }
    }
}
struct PIO_APC_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, IO_STATUS_BLOCK.Ptr, UInt32, "Void"]
}
