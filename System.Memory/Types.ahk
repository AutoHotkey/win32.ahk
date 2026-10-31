#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HANDLE}

struct SECTION_FLAGS extends UInt32 {
    static SECTION_ALL_ACCESS := 983071
    static SECTION_QUERY := 1
    static SECTION_MAP_WRITE := 2
    static SECTION_MAP_READ := 4
    static SECTION_MAP_EXECUTE := 8
    static SECTION_EXTEND_SIZE := 16
    static SECTION_MAP_EXECUTE_EXPLICIT := 32
}
struct FILE_MAP extends UInt32 {
    static FILE_MAP_WRITE := 2
    static FILE_MAP_READ := 4
    static FILE_MAP_ALL_ACCESS := 983071
    static FILE_MAP_EXECUTE := 32
    static FILE_MAP_COPY := 1
    static FILE_MAP_RESERVE := 2147483648
    static FILE_MAP_TARGETS_INVALID := 1073741824
    static FILE_MAP_LARGE_PAGES := 536870912
}
struct HEAP_FLAGS extends UInt32 {
    static HEAP_NONE := 0
    static HEAP_NO_SERIALIZE := 1
    static HEAP_GROWABLE := 2
    static HEAP_GENERATE_EXCEPTIONS := 4
    static HEAP_ZERO_MEMORY := 8
    static HEAP_REALLOC_IN_PLACE_ONLY := 16
    static HEAP_TAIL_CHECKING_ENABLED := 32
    static HEAP_FREE_CHECKING_ENABLED := 64
    static HEAP_DISABLE_COALESCE_ON_FREE := 128
    static HEAP_CREATE_ALIGN_16 := 65536
    static HEAP_CREATE_ENABLE_TRACING := 131072
    static HEAP_CREATE_ENABLE_EXECUTE := 262144
    static HEAP_MAXIMUM_TAG := 4095
    static HEAP_PSEUDO_TAG_FLAG := 32768
    static HEAP_TAG_SHIFT := 18
    static HEAP_CREATE_SEGMENT_HEAP := 256
    static HEAP_CREATE_HARDENED := 512
}
struct PAGE_PROTECTION_FLAGS extends UInt32 {
    static PAGE_NOACCESS := 1
    static PAGE_READONLY := 2
    static PAGE_READWRITE := 4
    static PAGE_WRITECOPY := 8
    static PAGE_EXECUTE := 16
    static PAGE_EXECUTE_READ := 32
    static PAGE_EXECUTE_READWRITE := 64
    static PAGE_EXECUTE_WRITECOPY := 128
    static PAGE_GUARD := 256
    static PAGE_NOCACHE := 512
    static PAGE_WRITECOMBINE := 1024
    static PAGE_GRAPHICS_NOACCESS := 2048
    static PAGE_GRAPHICS_READONLY := 4096
    static PAGE_GRAPHICS_READWRITE := 8192
    static PAGE_GRAPHICS_EXECUTE := 16384
    static PAGE_GRAPHICS_EXECUTE_READ := 32768
    static PAGE_GRAPHICS_EXECUTE_READWRITE := 65536
    static PAGE_GRAPHICS_COHERENT := 131072
    static PAGE_GRAPHICS_NOCACHE := 262144
    static PAGE_ENCLAVE_THREAD_CONTROL := 2147483648
    static PAGE_REVERT_TO_FILE_MAP := 2147483648
    static PAGE_TARGETS_NO_UPDATE := 1073741824
    static PAGE_TARGETS_INVALID := 1073741824
    static PAGE_ENCLAVE_UNVALIDATED := 536870912
    static PAGE_ENCLAVE_MASK := 268435456
    static PAGE_ENCLAVE_DECOMMIT := 268435456
    static PAGE_ENCLAVE_SS_FIRST := 268435457
    static PAGE_ENCLAVE_SS_REST := 268435458
    static SEC_PARTITION_OWNER_HANDLE := 262144
    static SEC_64K_PAGES := 524288
    static SEC_FILE := 8388608
    static SEC_IMAGE := 16777216
    static SEC_PROTECTED_IMAGE := 33554432
    static SEC_RESERVE := 67108864
    static SEC_COMMIT := 134217728
    static SEC_NOCACHE := 268435456
    static SEC_WRITECOMBINE := 1073741824
    static SEC_LARGE_PAGES := 2147483648
    static SEC_IMAGE_NO_EXECUTE := 285212672
}
struct UNMAP_VIEW_OF_FILE_FLAGS extends UInt32 {
    static MEM_UNMAP_NONE := 0
    static MEM_UNMAP_WITH_TRANSIENT_BOOST := 1
    static MEM_PRESERVE_PLACEHOLDER := 2
}
struct VIRTUAL_FREE_TYPE extends UInt32 {
    static MEM_DECOMMIT := 16384
    static MEM_RELEASE := 32768
}
struct VIRTUAL_ALLOCATION_TYPE extends UInt32 {
    static MEM_COMMIT := 4096
    static MEM_RESERVE := 8192
    static MEM_RESET := 524288
    static MEM_RESET_UNDO := 16777216
    static MEM_REPLACE_PLACEHOLDER := 16384
    static MEM_LARGE_PAGES := 536870912
    static MEM_RESERVE_PLACEHOLDER := 262144
    static MEM_FREE := 65536
}
struct LOCAL_ALLOC_FLAGS extends UInt32 {
    static LHND := 66
    static LMEM_FIXED := 0
    static LMEM_MOVEABLE := 2
    static LMEM_ZEROINIT := 64
    static LPTR := 64
    static NONZEROLHND := 2
    static NONZEROLPTR := 0
}
struct GLOBAL_ALLOC_FLAGS extends UInt32 {
    static GHND := 66
    static GMEM_FIXED := 0
    static GMEM_MOVEABLE := 2
    static GMEM_ZEROINIT := 64
    static GPTR := 64
}
struct PAGE_TYPE extends UInt32 {
    static MEM_PRIVATE := 131072
    static MEM_MAPPED := 262144
    static MEM_IMAGE := 16777216
}
struct SETPROCESSWORKINGSETSIZEEX_FLAGS extends UInt32 {
    static QUOTA_LIMITS_HARDWS_MIN_ENABLE := 1
    static QUOTA_LIMITS_HARDWS_MIN_DISABLE := 2
    static QUOTA_LIMITS_HARDWS_MAX_ENABLE := 4
    static QUOTA_LIMITS_HARDWS_MAX_DISABLE := 8
}
struct MEMORY_MAPPED_VIEW_ADDRESS {
    Value : Struct.Ptr
}
struct AtlThunkData_t {
    Value : IntPtr
}
struct PROCESS_HEAP_ENTRY {
    lpData : Struct.Ptr
    cbData : UInt32
    cbOverhead : UInt8
    iRegionIndex : UInt8
    wFlags : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Block : this._Block_e__Struct
            Region : this._Region_e__Struct
        }
        struct _Block_e__Struct {
            hMem : HANDLE
            dwReserved : UInt32[3]
        }
        struct _Region_e__Struct {
            dwCommittedSize : UInt32
            dwUnCommittedSize : UInt32
            lpFirstBlock : Struct.Ptr
            lpLastBlock : Struct.Ptr
        }
    }
}
struct HEAP_SUMMARY {
    cb : UInt32
    cbAllocated : IntPtr
    cbCommitted : IntPtr
    cbReserved : IntPtr
    cbMaxReserve : IntPtr
}
struct MEMORY_RESOURCE_NOTIFICATION_TYPE extends Int32 {
    static LowMemoryResourceNotification := 0
    static HighMemoryResourceNotification := 1
}
struct WIN32_MEMORY_RANGE_ENTRY {
    VirtualAddress : Struct.Ptr
    NumberOfBytes : IntPtr
}
struct PBAD_MEMORY_CALLBACK_ROUTINE extends FunctionPointer {
    static Types := ["Void"]
}
struct OFFER_PRIORITY extends Int32 {
    static VmOfferPriorityVeryLow := 1
    static VmOfferPriorityLow := 2
    static VmOfferPriorityBelowNormal := 3
    static VmOfferPriorityNormal := 4
}
struct WIN32_MEMORY_INFORMATION_CLASS extends Int32 {
    static MemoryRegionInfo := 0
}
struct WIN32_MEMORY_REGION_INFORMATION {
    AllocationBase : Struct.Ptr
    AllocationProtect : UInt32
    Anonymous : this._Anonymous_e__Union
    RegionSize : IntPtr
    CommitSize : IntPtr
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct WIN32_MEMORY_PARTITION_INFORMATION_CLASS extends Int32 {
    static MemoryPartitionInfo := 0
    static MemoryPartitionDedicatedMemoryInfo := 1
}
struct WIN32_MEMORY_PARTITION_INFORMATION {
    Flags : UInt32
    NumaNode : UInt32
    Channel : UInt32
    NumberOfNumaNodes : UInt32
    ResidentAvailablePages : Int64
    CommittedPages : Int64
    CommitLimit : Int64
    PeakCommitment : Int64
    TotalNumberOfPages : Int64
    AvailablePages : Int64
    ZeroPages : Int64
    FreePages : Int64
    StandbyPages : Int64
    Reserved : Int64[16]
    MaximumCommitLimit : Int64
    Reserved2 : Int64
    PartitionId : UInt32
}
struct NUMA_NODE_MEMORY_PERFORMANCE_MEASUREMENT_CONDITION {
    Flags : this._Flags_e__Struct
    MinTransferSizeInBytes : Int64
    struct _Flags_e__Struct {
        _bitfield : UInt8
    }
}
struct NUMA_NODE_MEMORY_PERFORMANCE_LATENCY {
    Condition : NUMA_NODE_MEMORY_PERFORMANCE_MEASUREMENT_CONDITION
    Latency : Int64
}
struct NUMA_NODE_MEMORY_PERFORMANCE_BANDWIDTH {
    Condition : NUMA_NODE_MEMORY_PERFORMANCE_MEASUREMENT_CONDITION
    Bandwidth : Int64
}
struct MEMORY_BASIC_INFORMATION {
    BaseAddress : Struct.Ptr
    AllocationBase : Struct.Ptr
    AllocationProtect : PAGE_PROTECTION_FLAGS
    PartitionId : UInt16
    RegionSize : IntPtr
    State : VIRTUAL_ALLOCATION_TYPE
    Protect : PAGE_PROTECTION_FLAGS
    Type : PAGE_TYPE
}
struct MEMORY_BASIC_INFORMATION32 {
    BaseAddress : UInt32
    AllocationBase : UInt32
    AllocationProtect : PAGE_PROTECTION_FLAGS
    RegionSize : UInt32
    State : VIRTUAL_ALLOCATION_TYPE
    Protect : PAGE_PROTECTION_FLAGS
    Type : PAGE_TYPE
}
struct MEMORY_BASIC_INFORMATION64 {
    BaseAddress : Int64
    AllocationBase : Int64
    AllocationProtect : PAGE_PROTECTION_FLAGS
    __alignment1 : UInt32
    RegionSize : Int64
    State : VIRTUAL_ALLOCATION_TYPE
    Protect : PAGE_PROTECTION_FLAGS
    Type : PAGE_TYPE
    __alignment2 : UInt32
}
struct CFG_CALL_TARGET_INFO {
    Offset : IntPtr
    Flags : IntPtr
}
struct MEM_EXTENDED_PARAMETER_TYPE extends Int32 {
    static MemExtendedParameterInvalidType := 0
    static MemExtendedParameterAddressRequirements := 1
    static MemExtendedParameterNumaNode := 2
    static MemExtendedParameterPartitionHandle := 3
    static MemExtendedParameterUserPhysicalHandle := 4
    static MemExtendedParameterAttributeFlags := 5
    static MemExtendedParameterImageMachine := 6
    static MemExtendedParameterMax := 7
}
struct MEM_EXTENDED_PARAMETER {
    Anonymous1 : this._Anonymous1_e__Struct
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Struct {
        _bitfield : Int64
    }
    struct _Anonymous2_e__Union {
        union {
            ULong64 : Int64
            Pointer : Struct.Ptr
            Size : IntPtr
            Handle : HANDLE
            ULong : UInt32
        }
    }
}
struct MEM_ADDRESS_REQUIREMENTS {
    LowestStartingAddress : Struct.Ptr
    HighestEndingAddress : Struct.Ptr
    Alignment : IntPtr
}
struct MEM_DEDICATED_ATTRIBUTE_TYPE extends Int32 {
    static MemDedicatedAttributeReadBandwidth := 0
    static MemDedicatedAttributeReadLatency := 1
    static MemDedicatedAttributeWriteBandwidth := 2
    static MemDedicatedAttributeWriteLatency := 3
    static MemDedicatedAttributeMax := 4
}
struct MEM_SECTION_EXTENDED_PARAMETER_TYPE extends Int32 {
    static MemSectionExtendedParameterInvalidType := 0
    static MemSectionExtendedParameterUserPhysicalFlags := 1
    static MemSectionExtendedParameterNumaNode := 2
    static MemSectionExtendedParameterSigningLevel := 3
    static MemSectionExtendedParameterAttributeFlags := 4
    static MemSectionExtendedParameterMax := 5
}
struct MEMORY_PARTITION_DEDICATED_MEMORY_ATTRIBUTE {
    Type : MEM_DEDICATED_ATTRIBUTE_TYPE
    Reserved : UInt32
    Value : Int64
}
struct MEMORY_PARTITION_DEDICATED_MEMORY_INFORMATION {
    NextEntryOffset : UInt32
    SizeOfInformation : UInt32
    Flags : UInt32
    AttributesOffset : UInt32
    AttributeCount : UInt32
    Reserved : UInt32
    TypeId : Int64
}
struct HEAP_INFORMATION_CLASS extends Int32 {
    static HeapCompatibilityInformation := 0
    static HeapEnableTerminationOnCorruption := 1
    static HeapOptimizeResources := 3
    static HeapTag := 7
    static HeapMemoryUsageInformation := 8
}
struct PSECURE_MEMORY_CACHE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, BOOLEAN]
}
