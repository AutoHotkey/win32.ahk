#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PSTR, PWSTR}

struct ENUM_PROCESS_MODULES_EX_FLAGS extends UInt32 {
    static LIST_MODULES_ALL := 3
    static LIST_MODULES_DEFAULT := 0
    static LIST_MODULES_32BIT := 1
    static LIST_MODULES_64BIT := 2
}
struct MODULEINFO {
    lpBaseOfDll : Struct.Ptr
    SizeOfImage : UInt32
    EntryPoint : Struct.Ptr
}
struct PSAPI_WS_WATCH_INFORMATION {
    FaultingPc : Struct.Ptr
    FaultingVa : Struct.Ptr
}
struct PSAPI_WS_WATCH_INFORMATION_EX {
    BasicInfo : PSAPI_WS_WATCH_INFORMATION
    FaultingThreadId : IntPtr
    Flags : IntPtr
}
struct PSAPI_WORKING_SET_BLOCK {
    union {
        Flags : IntPtr
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : IntPtr
    }
}
struct PSAPI_WORKING_SET_INFORMATION {
    NumberOfEntries : IntPtr
    WorkingSetInfo : PSAPI_WORKING_SET_BLOCK[1]
}
struct PSAPI_WORKING_SET_EX_BLOCK {
    union {
        Flags : IntPtr
        Anonymous : this._Anonymous_e__Union
    }
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Invalid : this._Invalid_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : IntPtr
        }
        struct _Invalid_e__Struct {
            _bitfield : IntPtr
        }
    }
}
struct PSAPI_WORKING_SET_EX_INFORMATION {
    VirtualAddress : Struct.Ptr
    VirtualAttributes : PSAPI_WORKING_SET_EX_BLOCK
}
struct PROCESS_MEMORY_COUNTERS {
    cb : UInt32
    PageFaultCount : UInt32
    PeakWorkingSetSize : IntPtr
    WorkingSetSize : IntPtr
    QuotaPeakPagedPoolUsage : IntPtr
    QuotaPagedPoolUsage : IntPtr
    QuotaPeakNonPagedPoolUsage : IntPtr
    QuotaNonPagedPoolUsage : IntPtr
    PagefileUsage : IntPtr
    PeakPagefileUsage : IntPtr
}
struct PROCESS_MEMORY_COUNTERS_EX {
    cb : UInt32
    PageFaultCount : UInt32
    PeakWorkingSetSize : IntPtr
    WorkingSetSize : IntPtr
    QuotaPeakPagedPoolUsage : IntPtr
    QuotaPagedPoolUsage : IntPtr
    QuotaPeakNonPagedPoolUsage : IntPtr
    QuotaNonPagedPoolUsage : IntPtr
    PagefileUsage : IntPtr
    PeakPagefileUsage : IntPtr
    PrivateUsage : IntPtr
}
struct PROCESS_MEMORY_COUNTERS_EX2 {
    cb : UInt32
    PageFaultCount : UInt32
    PeakWorkingSetSize : IntPtr
    WorkingSetSize : IntPtr
    QuotaPeakPagedPoolUsage : IntPtr
    QuotaPagedPoolUsage : IntPtr
    QuotaPeakNonPagedPoolUsage : IntPtr
    QuotaNonPagedPoolUsage : IntPtr
    PagefileUsage : IntPtr
    PeakPagefileUsage : IntPtr
    PrivateUsage : IntPtr
    PrivateWorkingSetSize : IntPtr
    SharedCommitUsage : Int64
}
struct PERFORMANCE_INFORMATION {
    cb : UInt32
    CommitTotal : IntPtr
    CommitLimit : IntPtr
    CommitPeak : IntPtr
    PhysicalTotal : IntPtr
    PhysicalAvailable : IntPtr
    SystemCache : IntPtr
    KernelTotal : IntPtr
    KernelPaged : IntPtr
    KernelNonpaged : IntPtr
    PageSize : IntPtr
    HandleCount : UInt32
    ProcessCount : UInt32
    ThreadCount : UInt32
}
struct ENUM_PAGE_FILE_INFORMATION {
    cb : UInt32
    Reserved : UInt32
    TotalSize : IntPtr
    TotalInUse : IntPtr
    PeakUsage : IntPtr
}
struct PENUM_PAGE_FILE_CALLBACKW extends FunctionPointer {
    static Types := [Struct.Ptr, ENUM_PAGE_FILE_INFORMATION.Ptr, PWSTR, BOOL]
}
struct PENUM_PAGE_FILE_CALLBACKA extends FunctionPointer {
    static Types := [Struct.Ptr, ENUM_PAGE_FILE_INFORMATION.Ptr, PSTR, BOOL]
}
