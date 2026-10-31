#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct VERIFIER_ENUM_RESOURCE_FLAGS extends UInt32 {
    static AVRF_ENUM_RESOURCES_FLAGS_DONT_RESOLVE_TRACES := 2
    static AVRF_ENUM_RESOURCES_FLAGS_SUSPEND := 1
}
struct AVRF_BACKTRACE_INFORMATION {
    Depth : UInt32
    Index : UInt32
    ReturnAddresses : Int64[32]
}
struct eUserAllocationState extends Int32 {
    static AllocationStateUnknown := 0
    static AllocationStateBusy := 1
    static AllocationStateFree := 2
}
struct eHeapAllocationState extends Int32 {
    static HeapFullPageHeap := 1073741824
    static HeapMetadata := -2147483648
    static HeapStateMask := -65536
}
struct eHeapEnumerationLevel extends Int32 {
    static HeapEnumerationEverything := 0
    static HeapEnumerationStop := -1
}
struct AVRF_HEAP_ALLOCATION {
    HeapHandle : Int64
    UserAllocation : Int64
    UserAllocationSize : Int64
    Allocation : Int64
    AllocationSize : Int64
    UserAllocationState : UInt32
    HeapState : UInt32
    HeapContext : Int64
    BackTraceInformation : AVRF_BACKTRACE_INFORMATION.Ptr
}
struct eHANDLE_TRACE_OPERATIONS extends Int32 {
    static OperationDbUnused := 0
    static OperationDbOPEN := 1
    static OperationDbCLOSE := 2
    static OperationDbBADREF := 3
}
struct AVRF_HANDLE_OPERATION {
    Handle : Int64
    ProcessId : UInt32
    ThreadId : UInt32
    OperationType : UInt32
    Spare0 : UInt32
    BackTraceInformation : AVRF_BACKTRACE_INFORMATION
}
struct eAvrfResourceTypes extends Int32 {
    static AvrfResourceHeapAllocation := 0
    static AvrfResourceHandleTrace := 1
    static AvrfResourceMax := 2
}
struct AVRF_RESOURCE_ENUMERATE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct AVRF_HEAPALLOCATION_ENUMERATE_CALLBACK extends FunctionPointer {
    static Types := [AVRF_HEAP_ALLOCATION.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct AVRF_HANDLEOPERATION_ENUMERATE_CALLBACK extends FunctionPointer {
    static Types := [AVRF_HANDLE_OPERATION.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
