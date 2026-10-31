#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HANDLE, PWSTR}
#Import "..\System.Diagnostics.Debug\Types.ahk" {CONTEXT}
#Import "..\System.Memory\Types.ahk" {MEMORY_BASIC_INFORMATION}

struct HPSS {
    Value : IntPtr
}
struct HPSSWALK {
    Value : IntPtr
}
struct PSS_HANDLE_FLAGS extends Int32 {
    static PSS_HANDLE_NONE := 0
    static PSS_HANDLE_HAVE_TYPE := 1
    static PSS_HANDLE_HAVE_NAME := 2
    static PSS_HANDLE_HAVE_BASIC_INFORMATION := 4
    static PSS_HANDLE_HAVE_TYPE_SPECIFIC_INFORMATION := 8
}
struct PSS_OBJECT_TYPE extends Int32 {
    static PSS_OBJECT_TYPE_UNKNOWN := 0
    static PSS_OBJECT_TYPE_PROCESS := 1
    static PSS_OBJECT_TYPE_THREAD := 2
    static PSS_OBJECT_TYPE_MUTANT := 3
    static PSS_OBJECT_TYPE_EVENT := 4
    static PSS_OBJECT_TYPE_SECTION := 5
    static PSS_OBJECT_TYPE_SEMAPHORE := 6
}
struct PSS_CAPTURE_FLAGS extends UInt32 {
    static PSS_CAPTURE_NONE := 0
    static PSS_CAPTURE_VA_CLONE := 1
    static PSS_CAPTURE_RESERVED_00000002 := 2
    static PSS_CAPTURE_HANDLES := 4
    static PSS_CAPTURE_HANDLE_NAME_INFORMATION := 8
    static PSS_CAPTURE_HANDLE_BASIC_INFORMATION := 16
    static PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION := 32
    static PSS_CAPTURE_HANDLE_TRACE := 64
    static PSS_CAPTURE_THREADS := 128
    static PSS_CAPTURE_THREAD_CONTEXT := 256
    static PSS_CAPTURE_THREAD_CONTEXT_EXTENDED := 512
    static PSS_CAPTURE_RESERVED_00000400 := 1024
    static PSS_CAPTURE_VA_SPACE := 2048
    static PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION := 4096
    static PSS_CAPTURE_IPT_TRACE := 8192
    static PSS_CAPTURE_RESERVED_00004000 := 16384
    static PSS_CREATE_BREAKAWAY_OPTIONAL := 67108864
    static PSS_CREATE_BREAKAWAY := 134217728
    static PSS_CREATE_FORCE_BREAKAWAY := 268435456
    static PSS_CREATE_USE_VM_ALLOCATIONS := 536870912
    static PSS_CREATE_MEASURE_PERFORMANCE := 1073741824
    static PSS_CREATE_RELEASE_SECTION := 2147483648
}
struct PSS_QUERY_INFORMATION_CLASS extends Int32 {
    static PSS_QUERY_PROCESS_INFORMATION := 0
    static PSS_QUERY_VA_CLONE_INFORMATION := 1
    static PSS_QUERY_AUXILIARY_PAGES_INFORMATION := 2
    static PSS_QUERY_VA_SPACE_INFORMATION := 3
    static PSS_QUERY_HANDLE_INFORMATION := 4
    static PSS_QUERY_THREAD_INFORMATION := 5
    static PSS_QUERY_HANDLE_TRACE_INFORMATION := 6
    static PSS_QUERY_PERFORMANCE_COUNTERS := 7
}
struct PSS_WALK_INFORMATION_CLASS extends Int32 {
    static PSS_WALK_AUXILIARY_PAGES := 0
    static PSS_WALK_VA_SPACE := 1
    static PSS_WALK_HANDLES := 2
    static PSS_WALK_THREADS := 3
    static PSS_WALK_THREAD_NAME := 4
}
struct PSS_DUPLICATE_FLAGS extends Int32 {
    static PSS_DUPLICATE_NONE := 0
    static PSS_DUPLICATE_CLOSE_SOURCE := 1
}
struct PSS_PROCESS_FLAGS extends Int32 {
    static PSS_PROCESS_FLAGS_NONE := 0
    static PSS_PROCESS_FLAGS_PROTECTED := 1
    static PSS_PROCESS_FLAGS_WOW64 := 2
    static PSS_PROCESS_FLAGS_RESERVED_03 := 4
    static PSS_PROCESS_FLAGS_RESERVED_04 := 8
    static PSS_PROCESS_FLAGS_FROZEN := 16
}
struct PSS_PROCESS_INFORMATION {
    ExitStatus : UInt32
    PebBaseAddress : Struct.Ptr
    AffinityMask : IntPtr
    BasePriority : Int32
    ProcessId : UInt32
    ParentProcessId : UInt32
    Flags : PSS_PROCESS_FLAGS
    CreateTime : FILETIME
    ExitTime : FILETIME
    KernelTime : FILETIME
    UserTime : FILETIME
    PriorityClass : UInt32
    PeakVirtualSize : IntPtr
    VirtualSize : IntPtr
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
    ExecuteFlags : UInt32
    ImageFileName : UInt16[260]
}
struct PSS_VA_CLONE_INFORMATION {
    VaCloneHandle : HANDLE
}
struct PSS_AUXILIARY_PAGES_INFORMATION {
    AuxPagesCaptured : UInt32
}
struct PSS_VA_SPACE_INFORMATION {
    RegionCount : UInt32
}
struct PSS_HANDLE_INFORMATION {
    HandlesCaptured : UInt32
}
struct PSS_THREAD_INFORMATION {
    ThreadsCaptured : UInt32
    ContextLength : UInt32
}
struct PSS_HANDLE_TRACE_INFORMATION {
    SectionHandle : HANDLE
    Size : UInt32
}
struct PSS_PERFORMANCE_COUNTERS {
    TotalCycleCount : Int64
    TotalWallClockPeriod : Int64
    VaCloneCycleCount : Int64
    VaCloneWallClockPeriod : Int64
    VaSpaceCycleCount : Int64
    VaSpaceWallClockPeriod : Int64
    AuxPagesCycleCount : Int64
    AuxPagesWallClockPeriod : Int64
    HandlesCycleCount : Int64
    HandlesWallClockPeriod : Int64
    ThreadsCycleCount : Int64
    ThreadsWallClockPeriod : Int64
}
struct PSS_AUXILIARY_PAGE_ENTRY {
    Address : Struct.Ptr
    BasicInformation : MEMORY_BASIC_INFORMATION
    CaptureTime : FILETIME
    PageContents : Struct.Ptr
    PageSize : UInt32
}
struct PSS_VA_SPACE_ENTRY {
    BaseAddress : Struct.Ptr
    AllocationBase : Struct.Ptr
    AllocationProtect : UInt32
    RegionSize : IntPtr
    State : UInt32
    Protect : UInt32
    Type : UInt32
    TimeDateStamp : UInt32
    SizeOfImage : UInt32
    ImageBase : Struct.Ptr
    CheckSum : UInt32
    MappedFileNameLength : UInt16
    MappedFileName : PWSTR
}
struct PSS_HANDLE_ENTRY {
    Handle : HANDLE
    Flags : PSS_HANDLE_FLAGS
    ObjectType : PSS_OBJECT_TYPE
    CaptureTime : FILETIME
    Attributes : UInt32
    GrantedAccess : UInt32
    HandleCount : UInt32
    PointerCount : UInt32
    PagedPoolCharge : UInt32
    NonPagedPoolCharge : UInt32
    CreationTime : FILETIME
    TypeNameLength : UInt16
    TypeName : PWSTR
    ObjectNameLength : UInt16
    ObjectName : PWSTR
    TypeSpecificInformation : this._TypeSpecificInformation_e__Union
    struct _TypeSpecificInformation_e__Union {
        union {
            Process : this._Process_e__Struct
            Thread : this._Thread_e__Struct
            Mutant : this._Mutant_e__Struct
            Event : this._Event_e__Struct
            Section : this._Section_e__Struct
            Semaphore : this._Semaphore_e__Struct
        }
        struct _Process_e__Struct {
            ExitStatus : UInt32
            PebBaseAddress : Struct.Ptr
            AffinityMask : IntPtr
            BasePriority : Int32
            ProcessId : UInt32
            ParentProcessId : UInt32
            Flags : UInt32
        }
        struct _Thread_e__Struct {
            ExitStatus : UInt32
            TebBaseAddress : Struct.Ptr
            ProcessId : UInt32
            ThreadId : UInt32
            AffinityMask : IntPtr
            Priority : Int32
            BasePriority : Int32
            Win32StartAddress : Struct.Ptr
        }
        struct _Mutant_e__Struct {
            CurrentCount : Int32
            Abandoned : BOOL
            OwnerProcessId : UInt32
            OwnerThreadId : UInt32
        }
        struct _Event_e__Struct {
            ManualReset : BOOL
            Signaled : BOOL
        }
        struct _Section_e__Struct {
            BaseAddress : Struct.Ptr
            AllocationAttributes : UInt32
            MaximumSize : Int64
        }
        struct _Semaphore_e__Struct {
            CurrentCount : Int32
            MaximumCount : Int32
        }
    }
}
struct PSS_THREAD_FLAGS extends Int32 {
    static PSS_THREAD_FLAGS_NONE := 0
    static PSS_THREAD_FLAGS_TERMINATED := 1
}
struct PSS_THREAD_ENTRY {
    ExitStatus : UInt32
    TebBaseAddress : Struct.Ptr
    ProcessId : UInt32
    ThreadId : UInt32
    AffinityMask : IntPtr
    Priority : Int32
    BasePriority : Int32
    LastSyscallFirstArgument : Struct.Ptr
    LastSyscallNumber : UInt16
    CreateTime : FILETIME
    ExitTime : FILETIME
    KernelTime : FILETIME
    UserTime : FILETIME
    Win32StartAddress : Struct.Ptr
    CaptureTime : FILETIME
    Flags : PSS_THREAD_FLAGS
    SuspendCount : UInt16
    SizeOfContextRecord : UInt16
    ContextRecord : CONTEXT.Ptr
}
struct PSS_THREAD_NAME {
    ThreadNameSize : UInt16
    ThreadName : PWSTR
}
struct PSS_ALLOCATOR {
    Context : Struct.Ptr
    AllocRoutine : IntPtr
    FreeRoutine : IntPtr
}
