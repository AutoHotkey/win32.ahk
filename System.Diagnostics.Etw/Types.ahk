#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, HANDLE, HRESULT, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Time\Types.ahk" {TIME_ZONE_INFORMATION}

struct TRACE_MESSAGE_FLAGS extends UInt32 {
    static TRACE_MESSAGE_COMPONENTID := 4
    static TRACE_MESSAGE_GUID := 2
    static TRACE_MESSAGE_SEQUENCE := 1
    static TRACE_MESSAGE_SYSTEMINFO := 32
    static TRACE_MESSAGE_TIMESTAMP := 8
}
struct ENABLECALLBACK_ENABLED_STATE extends UInt32 {
    static EVENT_CONTROL_CODE_DISABLE_PROVIDER := 0
    static EVENT_CONTROL_CODE_ENABLE_PROVIDER := 1
    static EVENT_CONTROL_CODE_CAPTURE_STATE := 2
}
struct EVENT_TRACE_CONTROL extends UInt32 {
    static EVENT_TRACE_CONTROL_FLUSH := 3
    static EVENT_TRACE_CONTROL_QUERY := 0
    static EVENT_TRACE_CONTROL_STOP := 1
    static EVENT_TRACE_CONTROL_UPDATE := 2
}
struct EVENT_TRACE_FLAG extends UInt32 {
    static EVENT_TRACE_FLAG_ALPC := 1048576
    static EVENT_TRACE_FLAG_CSWITCH := 16
    static EVENT_TRACE_FLAG_DBGPRINT := 262144
    static EVENT_TRACE_FLAG_DISK_FILE_IO := 512
    static EVENT_TRACE_FLAG_DISK_IO := 256
    static EVENT_TRACE_FLAG_DISK_IO_INIT := 1024
    static EVENT_TRACE_FLAG_DISPATCHER := 2048
    static EVENT_TRACE_FLAG_DPC := 32
    static EVENT_TRACE_FLAG_DRIVER := 8388608
    static EVENT_TRACE_FLAG_FILE_IO := 33554432
    static EVENT_TRACE_FLAG_FILE_IO_INIT := 67108864
    static EVENT_TRACE_FLAG_IMAGE_LOAD := 4
    static EVENT_TRACE_FLAG_INTERRUPT := 64
    static EVENT_TRACE_FLAG_JOB := 524288
    static EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS := 8192
    static EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS := 4096
    static EVENT_TRACE_FLAG_NETWORK_TCPIP := 65536
    static EVENT_TRACE_FLAG_NO_SYSCONFIG := 268435456
    static EVENT_TRACE_FLAG_PROCESS := 1
    static EVENT_TRACE_FLAG_PROCESS_COUNTERS := 8
    static EVENT_TRACE_FLAG_PROFILE := 16777216
    static EVENT_TRACE_FLAG_REGISTRY := 131072
    static EVENT_TRACE_FLAG_SPLIT_IO := 2097152
    static EVENT_TRACE_FLAG_SYSTEMCALL := 128
    static EVENT_TRACE_FLAG_THREAD := 2
    static EVENT_TRACE_FLAG_VAMAP := 32768
    static EVENT_TRACE_FLAG_VIRTUAL_ALLOC := 16384
}
struct TDH_HANDLE {
    Value : IntPtr
}
struct PROCESSTRACE_HANDLE {
    Value : Int64
}
struct REGHANDLE {
    Value : Int64
}
struct CONTROLTRACE_HANDLE {
    Value : Int64
}
struct RELOGSTREAM_HANDLE {
    Value : Int64
}
struct WNODE_HEADER {
    BufferSize : UInt32
    ProviderId : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Guid : GUID
    ClientContext : UInt32
    Flags : UInt32
    struct _Anonymous1_e__Union {
        union {
            HistoricalContext : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Version : UInt32
            Linkage : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            CountLost : UInt32
            KernelHandle : HANDLE
            TimeStamp : Int64
        }
    }
}
struct OFFSETINSTANCEDATAANDLENGTH {
    OffsetInstanceData : UInt32
    LengthInstanceData : UInt32
}
struct WNODE_ALL_DATA {
    WnodeHeader : WNODE_HEADER
    DataBlockOffset : UInt32
    InstanceCount : UInt32
    OffsetInstanceNameOffsets : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FixedInstanceSize : UInt32
            OffsetInstanceDataAndLength : OFFSETINSTANCEDATAANDLENGTH[1]
        }
    }
}
struct WNODE_SINGLE_INSTANCE {
    WnodeHeader : WNODE_HEADER
    OffsetInstanceName : UInt32
    InstanceIndex : UInt32
    DataBlockOffset : UInt32
    SizeDataBlock : UInt32
    VariableData : UInt8[1]
}
struct WNODE_SINGLE_ITEM {
    WnodeHeader : WNODE_HEADER
    OffsetInstanceName : UInt32
    InstanceIndex : UInt32
    ItemId : UInt32
    DataBlockOffset : UInt32
    SizeDataItem : UInt32
    VariableData : UInt8[1]
}
struct WNODE_METHOD_ITEM {
    WnodeHeader : WNODE_HEADER
    OffsetInstanceName : UInt32
    InstanceIndex : UInt32
    MethodId : UInt32
    DataBlockOffset : UInt32
    SizeDataBlock : UInt32
    VariableData : UInt8[1]
}
struct WNODE_EVENT_ITEM {
    WnodeHeader : WNODE_HEADER
}
struct WNODE_EVENT_REFERENCE {
    WnodeHeader : WNODE_HEADER
    TargetGuid : GUID
    TargetDataBlockSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            TargetInstanceIndex : UInt32
            TargetInstanceName : UInt16[1]
        }
    }
}
struct WNODE_TOO_SMALL {
    WnodeHeader : WNODE_HEADER
    SizeNeeded : UInt32
}
struct WMIREGGUIDW {
    Guid : GUID
    Flags : UInt32
    InstanceCount : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            InstanceNameList : UInt32
            BaseNameOffset : UInt32
            Pdo : IntPtr
            InstanceInfo : IntPtr
        }
    }
}
struct WMIREGINFOW {
    BufferSize : UInt32
    NextWmiRegInfo : UInt32
    RegistryPath : UInt32
    MofResourceName : UInt32
    GuidCount : UInt32
    WmiRegGuid : WMIREGGUIDW[1]
}
struct WMIDPREQUESTCODE extends Int32 {
    static WMI_GET_ALL_DATA := 0
    static WMI_GET_SINGLE_INSTANCE := 1
    static WMI_SET_SINGLE_INSTANCE := 2
    static WMI_SET_SINGLE_ITEM := 3
    static WMI_ENABLE_EVENTS := 4
    static WMI_DISABLE_EVENTS := 5
    static WMI_ENABLE_COLLECTION := 6
    static WMI_DISABLE_COLLECTION := 7
    static WMI_REGINFO := 8
    static WMI_EXECUTE_METHOD := 9
    static WMI_CAPTURE_STATE := 10
}
struct ETW_COMPRESSION_RESUMPTION_MODE extends Int32 {
    static EtwCompressionModeRestart := 0
    static EtwCompressionModeNoDisable := 1
    static EtwCompressionModeNoRestart := 2
}
struct EVENT_TRACE_HEADER {
    Size : UInt16
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    ThreadId : UInt32
    ProcessId : UInt32
    TimeStamp : Int64
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    struct _Anonymous1_e__Union {
        union {
            FieldTypeFlags : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            HeaderType : UInt8
            MarkerFlags : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Version : UInt32
            Class : this._Class_e__Struct
        }
        struct _Class_e__Struct {
            Type : UInt8
            Level : UInt8
            Version : UInt16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            Guid : GUID
            GuidPtr : Int64
        }
    }
    struct _Anonymous4_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            ProcessorTime : Int64
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            KernelTime : UInt32
            UserTime : UInt32
        }
        struct _Anonymous2_e__Struct {
            ClientContext : UInt32
            Flags : UInt32
        }
    }
}
struct EVENT_INSTANCE_HEADER {
    Size : UInt16
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    ThreadId : UInt32
    ProcessId : UInt32
    TimeStamp : Int64
    RegHandle : Int64
    InstanceId : UInt32
    ParentInstanceId : UInt32
    Anonymous3 : this._Anonymous3_e__Union
    ParentRegHandle : Int64
    struct _Anonymous1_e__Union {
        union {
            FieldTypeFlags : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            HeaderType : UInt8
            MarkerFlags : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Version : UInt32
            Class : this._Class_e__Struct
        }
        struct _Class_e__Struct {
            Type : UInt8
            Level : UInt8
            Version : UInt16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            ProcessorTime : Int64
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            KernelTime : UInt32
            UserTime : UInt32
        }
        struct _Anonymous2_e__Struct {
            EventId : UInt32
            Flags : UInt32
        }
    }
}
struct MOF_FIELD {
    DataPtr : Int64
    Length : UInt32
    DataType : UInt32
}
struct TRACE_LOGFILE_HEADER {
    BufferSize : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    ProviderVersion : UInt32
    NumberOfProcessors : UInt32
    EndTime : Int64
    TimerResolution : UInt32
    MaximumFileSize : UInt32
    LogFileMode : UInt32
    BuffersWritten : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    LoggerName : PWSTR
    LogFileName : PWSTR
    TimeZone : TIME_ZONE_INFORMATION
    BootTime : Int64
    PerfFreq : Int64
    StartTime : Int64
    ReservedFlags : UInt32
    BuffersLost : UInt32
    struct _Anonymous1_e__Union {
        union {
            Version : UInt32
            VersionDetail : this._VersionDetail_e__Struct
        }
        struct _VersionDetail_e__Struct {
            MajorVersion : UInt8
            MinorVersion : UInt8
            SubVersion : UInt8
            SubMinorVersion : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            LogInstanceGuid : GUID
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            StartBuffers : UInt32
            PointerSize : UInt32
            EventsLost : UInt32
            CpuSpeedInMHz : UInt32
        }
    }
}
struct TRACE_LOGFILE_HEADER32 {
    BufferSize : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    ProviderVersion : UInt32
    NumberOfProcessors : UInt32
    EndTime : Int64
    TimerResolution : UInt32
    MaximumFileSize : UInt32
    LogFileMode : UInt32
    BuffersWritten : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    LoggerName : UInt32
    LogFileName : UInt32
    TimeZone : TIME_ZONE_INFORMATION
    BootTime : Int64
    PerfFreq : Int64
    StartTime : Int64
    ReservedFlags : UInt32
    BuffersLost : UInt32
    struct _Anonymous1_e__Union {
        union {
            Version : UInt32
            VersionDetail : this._VersionDetail_e__Struct
        }
        struct _VersionDetail_e__Struct {
            MajorVersion : UInt8
            MinorVersion : UInt8
            SubVersion : UInt8
            SubMinorVersion : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            LogInstanceGuid : GUID
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            StartBuffers : UInt32
            PointerSize : UInt32
            EventsLost : UInt32
            CpuSpeedInMHz : UInt32
        }
    }
}
struct TRACE_LOGFILE_HEADER64 {
    BufferSize : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    ProviderVersion : UInt32
    NumberOfProcessors : UInt32
    EndTime : Int64
    TimerResolution : UInt32
    MaximumFileSize : UInt32
    LogFileMode : UInt32
    BuffersWritten : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    LoggerName : Int64
    LogFileName : Int64
    TimeZone : TIME_ZONE_INFORMATION
    BootTime : Int64
    PerfFreq : Int64
    StartTime : Int64
    ReservedFlags : UInt32
    BuffersLost : UInt32
    struct _Anonymous1_e__Union {
        union {
            Version : UInt32
            VersionDetail : this._VersionDetail_e__Struct
        }
        struct _VersionDetail_e__Struct {
            MajorVersion : UInt8
            MinorVersion : UInt8
            SubVersion : UInt8
            SubMinorVersion : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            LogInstanceGuid : GUID
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            StartBuffers : UInt32
            PointerSize : UInt32
            EventsLost : UInt32
            CpuSpeedInMHz : UInt32
        }
    }
}
struct EVENT_INSTANCE_INFO {
    RegHandle : HANDLE
    InstanceId : UInt32
}
struct EVENT_TRACE_PROPERTIES {
    Wnode : WNODE_HEADER
    BufferSize : UInt32
    MinimumBuffers : UInt32
    MaximumBuffers : UInt32
    MaximumFileSize : UInt32
    LogFileMode : UInt32
    FlushTimer : UInt32
    EnableFlags : EVENT_TRACE_FLAG
    Anonymous : this._Anonymous_e__Union
    NumberOfBuffers : UInt32
    FreeBuffers : UInt32
    EventsLost : UInt32
    BuffersWritten : UInt32
    LogBuffersLost : UInt32
    RealTimeBuffersLost : UInt32
    LoggerThreadId : HANDLE
    LogFileNameOffset : UInt32
    LoggerNameOffset : UInt32
    struct _Anonymous_e__Union {
        union {
            AgeLimit : Int32
            FlushThreshold : Int32
        }
    }
}
struct EVENT_TRACE_PROPERTIES_V2 {
    Wnode : WNODE_HEADER
    BufferSize : UInt32
    MinimumBuffers : UInt32
    MaximumBuffers : UInt32
    MaximumFileSize : UInt32
    LogFileMode : UInt32
    FlushTimer : UInt32
    EnableFlags : EVENT_TRACE_FLAG
    Anonymous1 : this._Anonymous1_e__Union
    NumberOfBuffers : UInt32
    FreeBuffers : UInt32
    EventsLost : UInt32
    BuffersWritten : UInt32
    LogBuffersLost : UInt32
    RealTimeBuffersLost : UInt32
    LoggerThreadId : HANDLE
    LogFileNameOffset : UInt32
    LoggerNameOffset : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    FilterDescCount : UInt32
    FilterDesc : EVENT_FILTER_DESCRIPTOR.Ptr
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            AgeLimit : Int32
            FlushThreshold : Int32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            V2Control : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            V2Options : Int64
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct TRACE_GUID_REGISTRATION {
    Guid : GUID.Ptr
    RegHandle : HANDLE
}
struct TRACE_GUID_PROPERTIES {
    Guid : GUID
    GuidType : UInt32
    LoggerId : UInt32
    EnableLevel : UInt32
    EnableFlags : UInt32
    IsEnable : BOOLEAN
}
struct ETW_BUFFER_CONTEXT {
    Anonymous : this._Anonymous_e__Union
    LoggerId : UInt16
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ProcessorIndex : UInt16
        }
        struct _Anonymous_e__Struct {
            ProcessorNumber : UInt8
            Alignment : UInt8
        }
    }
}
struct TRACE_ENABLE_INFO {
    IsEnabled : UInt32
    Level : UInt8
    Reserved1 : UInt8
    LoggerId : UInt16
    EnableProperty : UInt32
    Reserved2 : UInt32
    MatchAnyKeyword : Int64
    MatchAllKeyword : Int64
}
struct TRACE_PROVIDER_INSTANCE_INFO {
    NextOffset : UInt32
    EnableCount : UInt32
    Pid : UInt32
    Flags : UInt32
}
struct TRACE_GUID_INFO {
    InstanceCount : UInt32
    Reserved : UInt32
}
struct PROFILE_SOURCE_INFO {
    NextEntryOffset : UInt32
    Source : UInt32
    MinInterval : UInt32
    MaxInterval : UInt32
    Reserved : Int64
    Description : UInt16[1]
}
struct ETW_PMC_COUNTER_OWNER_TYPE extends Int32 {
    static EtwPmcOwnerFree := 0
    static EtwPmcOwnerUntagged := 1
    static EtwPmcOwnerTagged := 2
    static EtwPmcOwnerTaggedWithSource := 3
}
struct ETW_PMC_COUNTER_OWNER {
    OwnerType : ETW_PMC_COUNTER_OWNER_TYPE
    ProfileSource : UInt32
    OwnerTag : UInt32
}
struct ETW_PMC_COUNTER_OWNERSHIP_STATUS {
    ProcessorNumber : UInt32
    NumberOfCounters : UInt32
    CounterOwners : ETW_PMC_COUNTER_OWNER[1]
}
struct ETW_PMC_SESSION_INFO {
    NextEntryOffset : UInt32
    LoggerId : UInt16
    Reserved : UInt16
    ProfileSourceCount : UInt32
    HookIdCount : UInt32
}
struct ETW_CONTEXT_REGISTER_TYPES extends Int32 {
    static EtwContextRegisterTypeNone := 0
    static EtwContextRegisterTypeControl := 1
    static EtwContextRegisterTypeInteger := 2
}
struct TRACE_LBR_CONFIGURATION extends Int32 {
    static TRACE_LBR_CONFIGURATION_NONE := 0
    static TRACE_LBR_CONFIGURATION_EXCLUDE_KERNEL := 1
    static TRACE_LBR_CONFIGURATION_EXCLUDE_USER := 2
    static TRACE_LBR_CONFIGURATION_EXCLUDE_JCC := 4
    static TRACE_LBR_CONFIGURATION_EXCLUDE_NEAR_REL_CALL := 8
    static TRACE_LBR_CONFIGURATION_EXCLUDE_NEAR_IND_CALL := 16
    static TRACE_LBR_CONFIGURATION_EXCLUDE_NEAR_RET := 32
    static TRACE_LBR_CONFIGURATION_EXCLUDE_NEAR_IND_JMP := 64
    static TRACE_LBR_CONFIGURATION_EXCLUDE_NEAR_REL_JMP := 128
    static TRACE_LBR_CONFIGURATION_EXCLUDE_FAR_BRANCH := 256
    static TRACE_LBR_CONFIGURATION_CALLSTACK_ENABLE := 512
    static TRACE_LBR_CONFIGURATION_SAMPLED := 1024
}
struct EVENT_TRACE {
    Header : EVENT_TRACE_HEADER
    InstanceId : UInt32
    ParentInstanceId : UInt32
    ParentGuid : GUID
    MofData : Struct.Ptr
    MofLength : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ClientContext : UInt32
            BufferContext : ETW_BUFFER_CONTEXT
        }
    }
}
struct PEVENT_TRACE_BUFFER_CALLBACKW extends FunctionPointer {
    static Types := [EVENT_TRACE_LOGFILEW.Ptr, UInt32]
}
struct PEVENT_TRACE_BUFFER_CALLBACKA extends FunctionPointer {
    static Types := [EVENT_TRACE_LOGFILEA.Ptr, UInt32]
}
struct PEVENT_CALLBACK extends FunctionPointer {
    static Types := [EVENT_TRACE.Ptr, "Void"]
}
struct PEVENT_RECORD_CALLBACK extends FunctionPointer {
    static Types := [EVENT_RECORD.Ptr, "Void"]
}
struct ETW_BUFFER_HEADER {
    Reserved1 : UInt32[4]
    TimeStamp : Int64
    Reserved2 : UInt32[4]
    ClientContext : ETW_BUFFER_CONTEXT
    Reserved3 : UInt32
    FilledBytes : UInt32
    Reserved4 : UInt32[5]
}
struct ETW_BUFFER_CALLBACK_INFORMATION {
    TraceHandle : PROCESSTRACE_HANDLE
    LogfileHeader : TRACE_LOGFILE_HEADER.Ptr
    BuffersRead : UInt32
}
struct PETW_BUFFER_CALLBACK extends FunctionPointer {
    static Types := [ETW_BUFFER_HEADER.Ptr, UInt32, ETW_BUFFER_CALLBACK_INFORMATION.Ptr, Struct.Ptr, BOOL]
}
struct ETW_PROCESS_TRACE_MODES extends Int32 {
    static ETW_PROCESS_TRACE_MODE_NONE := 0
    static ETW_PROCESS_TRACE_MODE_RAW_TIMESTAMP := 1
}
struct ETW_OPEN_TRACE_OPTIONS {
    ProcessTraceModes : ETW_PROCESS_TRACE_MODES
    EventCallback : PEVENT_RECORD_CALLBACK
    EventCallbackContext : Struct.Ptr
    BufferCallback : PETW_BUFFER_CALLBACK
    BufferCallbackContext : Struct.Ptr
}
struct PETW_BUFFER_COMPLETION_CALLBACK extends FunctionPointer {
    static Types := [ETW_BUFFER_HEADER.Ptr, Struct.Ptr, "Void"]
}
struct WMIDPREQUEST extends FunctionPointer {
    static Types := [WMIDPREQUESTCODE, Struct.Ptr, UInt32.Ptr, Struct.Ptr, UInt32]
}
struct EVENT_TRACE_LOGFILEW {
    LogFileName : PWSTR
    LoggerName : PWSTR
    CurrentTime : Int64
    BuffersRead : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    CurrentEvent : EVENT_TRACE
    LogfileHeader : TRACE_LOGFILE_HEADER
    BufferCallback : PEVENT_TRACE_BUFFER_CALLBACKW
    BufferSize : UInt32
    Filled : UInt32
    EventsLost : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    IsKernelTrace : UInt32
    Context : Struct.Ptr
    struct _Anonymous1_e__Union {
        union {
            LogFileMode : UInt32
            ProcessTraceMode : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            EventCallback : PEVENT_CALLBACK
            EventRecordCallback : PEVENT_RECORD_CALLBACK
        }
    }
}
struct EVENT_TRACE_LOGFILEA {
    LogFileName : PSTR
    LoggerName : PSTR
    CurrentTime : Int64
    BuffersRead : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    CurrentEvent : EVENT_TRACE
    LogfileHeader : TRACE_LOGFILE_HEADER
    BufferCallback : PEVENT_TRACE_BUFFER_CALLBACKA
    BufferSize : UInt32
    Filled : UInt32
    EventsLost : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    IsKernelTrace : UInt32
    Context : Struct.Ptr
    struct _Anonymous1_e__Union {
        union {
            LogFileMode : UInt32
            ProcessTraceMode : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            EventCallback : PEVENT_CALLBACK
            EventRecordCallback : PEVENT_RECORD_CALLBACK
        }
    }
}
struct ENABLE_TRACE_PARAMETERS_V1 {
    Version : UInt32
    EnableProperty : UInt32
    ControlFlags : UInt32
    SourceId : GUID
    EnableFilterDesc : EVENT_FILTER_DESCRIPTOR.Ptr
}
struct ENABLE_TRACE_PARAMETERS {
    Version : UInt32
    EnableProperty : UInt32
    ControlFlags : UInt32
    SourceId : GUID
    EnableFilterDesc : EVENT_FILTER_DESCRIPTOR.Ptr
    FilterDescCount : UInt32
}
struct TRACE_QUERY_INFO_CLASS extends Int32 {
    static TraceGuidQueryList := 0
    static TraceGuidQueryInfo := 1
    static TraceGuidQueryProcess := 2
    static TraceStackTracingInfo := 3
    static TraceSystemTraceEnableFlagsInfo := 4
    static TraceSampledProfileIntervalInfo := 5
    static TraceProfileSourceConfigInfo := 6
    static TraceProfileSourceListInfo := 7
    static TracePmcEventListInfo := 8
    static TracePmcCounterListInfo := 9
    static TraceSetDisallowList := 10
    static TraceVersionInfo := 11
    static TraceGroupQueryList := 12
    static TraceGroupQueryInfo := 13
    static TraceDisallowListQuery := 14
    static TraceInfoReserved15 := 15
    static TracePeriodicCaptureStateListInfo := 16
    static TracePeriodicCaptureStateInfo := 17
    static TraceProviderBinaryTracking := 18
    static TraceMaxLoggersQuery := 19
    static TraceLbrConfigurationInfo := 20
    static TraceLbrEventListInfo := 21
    static TraceMaxPmcCounterQuery := 22
    static TraceStreamCount := 23
    static TraceStackCachingInfo := 24
    static TracePmcCounterOwners := 25
    static TraceUnifiedStackCachingInfo := 26
    static TracePmcSessionInformation := 27
    static TraceContextRegisterInfo := 28
    static MaxTraceSetInfoClass := 29
}
struct CLASSIC_EVENT_ID {
    EventGuid : GUID
    Type : UInt8
    Reserved : UInt8[7]
}
struct TRACE_STACK_CACHING_INFO {
    Enabled : BOOLEAN
    CacheSize : UInt32
    BucketCount : UInt32
}
struct TRACE_PROFILE_INTERVAL {
    Source : UInt32
    Interval : UInt32
}
struct TRACE_VERSION_INFO {
    EtwTraceProcessingVersion : UInt32
    Reserved : UInt32
}
struct TRACE_PERIODIC_CAPTURE_STATE_INFO {
    CaptureStateFrequencyInSeconds : UInt32
    ProviderCount : UInt16
    Reserved : UInt16
}
struct TRACE_CONTEXT_REGISTER_INFO {
    RegisterTypes : ETW_CONTEXT_REGISTER_TYPES
    Reserved : UInt32
}
struct ETW_PROCESS_HANDLE_INFO_TYPE extends Int32 {
    static EtwQueryPartitionInformation := 1
    static EtwQueryPartitionInformationV2 := 2
    static EtwQueryLastDroppedTimes := 3
    static EtwQueryLogFileHeader := 4
    static EtwQueryProcessHandleInfoMax := 5
}
struct ETW_TRACE_PARTITION_INFORMATION {
    PartitionId : GUID
    ParentId : GUID
    QpcOffsetFromRoot : Int64
    PartitionType : UInt32
}
struct ETW_TRACE_PARTITION_INFORMATION_V2 {
    QpcOffsetFromRoot : Int64
    PartitionType : UInt32
    PartitionId : PWSTR
    ParentId : PWSTR
}
struct EVENT_DATA_DESCRIPTOR {
    Ptr : Int64
    Size : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Reserved : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Type : UInt8
            Reserved1 : UInt8
            Reserved2 : UInt16
        }
    }
}
struct EVENT_DESCRIPTOR {
    Id : UInt16
    Version : UInt8
    Channel : UInt8
    Level : UInt8
    Opcode : UInt8
    Task : UInt16
    Keyword : Int64
}
struct EVENT_FILTER_DESCRIPTOR {
    Ptr : Int64
    Size : UInt32
    Type : UInt32
}
struct EVENT_FILTER_HEADER {
    Id : UInt16
    Version : UInt8
    Reserved : UInt8[5]
    InstanceId : Int64
    Size : UInt32
    NextOffset : UInt32
}
struct EVENT_FILTER_EVENT_ID {
    FilterIn : BOOLEAN
    Reserved : UInt8
    Count : UInt16
    Events : UInt16[1]
}
struct EVENT_FILTER_EVENT_NAME {
    MatchAnyKeyword : Int64
    MatchAllKeyword : Int64
    Level : UInt8
    FilterIn : BOOLEAN
    NameCount : UInt16
    Names : UInt8[1]
}
struct EVENT_FILTER_LEVEL_KW {
    MatchAnyKeyword : Int64
    MatchAllKeyword : Int64
    Level : UInt8
    FilterIn : BOOLEAN
}
struct EVENT_INFO_CLASS extends Int32 {
    static EventProviderBinaryTrackInfo := 0
    static EventProviderSetReserved1 := 1
    static EventProviderSetTraits := 2
    static EventProviderUseDescriptorType := 3
    static EventProviderSetReserved2 := 4
    static MaxEventInfo := 5
}
struct PENABLECALLBACK extends FunctionPointer {
    static Types := [GUID.Ptr, ENABLECALLBACK_ENABLED_STATE, UInt8, Int64, Int64, EVENT_FILTER_DESCRIPTOR.Ptr, Struct.Ptr, "Void"]
}
struct EVENT_HEADER_EXTENDED_DATA_ITEM {
    Reserved1 : UInt16
    ExtType : UInt16
    Anonymous : this._Anonymous_e__Struct
    DataSize : UInt16
    DataPtr : Int64
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct EVENT_EXTENDED_ITEM_INSTANCE {
    InstanceId : UInt32
    ParentInstanceId : UInt32
    ParentGuid : GUID
}
struct EVENT_EXTENDED_ITEM_RELATED_ACTIVITYID {
    RelatedActivityId : GUID
}
struct EVENT_EXTENDED_ITEM_TS_ID {
    SessionId : UInt32
}
struct EVENT_EXTENDED_ITEM_STACK_TRACE32 {
    MatchId : Int64
    Address : UInt32[1]
}
struct EVENT_EXTENDED_ITEM_STACK_TRACE64 {
    MatchId : Int64
    Address : Int64[1]
}
struct EVENT_EXTENDED_ITEM_STACK_KEY32 {
    MatchId : Int64
    StackKey : UInt32
    Padding : UInt32
}
struct EVENT_EXTENDED_ITEM_STACK_KEY64 {
    MatchId : Int64
    StackKey : Int64
}
struct EVENT_EXTENDED_ITEM_PEBS_INDEX {
    PebsIndex : Int64
}
struct EVENT_EXTENDED_ITEM_PMC_COUNTERS {
    Counter : Int64[1]
}
struct EVENT_EXTENDED_ITEM_PROCESS_START_KEY {
    ProcessStartKey : Int64
}
struct EVENT_EXTENDED_ITEM_EVENT_KEY {
    Key : Int64
}
struct EVENT_HEADER {
    Size : UInt16
    HeaderType : UInt16
    Flags : UInt16
    EventProperty : UInt16
    ThreadId : UInt32
    ProcessId : UInt32
    TimeStamp : Int64
    ProviderId : GUID
    EventDescriptor : EVENT_DESCRIPTOR
    Anonymous : this._Anonymous_e__Union
    ActivityId : GUID
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ProcessorTime : Int64
        }
        struct _Anonymous_e__Struct {
            KernelTime : UInt32
            UserTime : UInt32
        }
    }
}
struct EVENT_RECORD {
    EventHeader : EVENT_HEADER
    BufferContext : ETW_BUFFER_CONTEXT
    ExtendedDataCount : UInt16
    UserDataLength : UInt16
    ExtendedData : EVENT_HEADER_EXTENDED_DATA_ITEM.Ptr
    UserData : Struct.Ptr
    UserContext : Struct.Ptr
}
struct ETW_PROVIDER_TRAIT_TYPE extends Int32 {
    static EtwProviderTraitTypeGroup := 1
    static EtwProviderTraitDecodeGuid := 2
    static EtwProviderTraitTypeMax := 3
}
struct EVENTSECURITYOPERATION extends Int32 {
    static EventSecuritySetDACL := 0
    static EventSecuritySetSACL := 1
    static EventSecurityAddDACL := 2
    static EventSecurityAddSACL := 3
    static EventSecurityMax := 4
}
struct EVENT_MAP_ENTRY {
    OutputOffset : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Value : UInt32
            InputOffset : UInt32
        }
    }
}
struct MAP_FLAGS extends Int32 {
    static EVENTMAP_INFO_FLAG_MANIFEST_VALUEMAP := 1
    static EVENTMAP_INFO_FLAG_MANIFEST_BITMAP := 2
    static EVENTMAP_INFO_FLAG_MANIFEST_PATTERNMAP := 4
    static EVENTMAP_INFO_FLAG_WBEM_VALUEMAP := 8
    static EVENTMAP_INFO_FLAG_WBEM_BITMAP := 16
    static EVENTMAP_INFO_FLAG_WBEM_FLAG := 32
    static EVENTMAP_INFO_FLAG_WBEM_NO_MAP := 64
}
struct MAP_VALUETYPE extends Int32 {
    static EVENTMAP_ENTRY_VALUETYPE_ULONG := 0
    static EVENTMAP_ENTRY_VALUETYPE_STRING := 1
}
struct EVENT_MAP_INFO {
    NameOffset : UInt32
    Flag : MAP_FLAGS
    EntryCount : UInt32
    Anonymous : this._Anonymous_e__Union
    MapEntryArray : EVENT_MAP_ENTRY[1]
    struct _Anonymous_e__Union {
        union {
            MapEntryValueType : MAP_VALUETYPE
            FormatStringOffset : UInt32
        }
    }
}
struct TDH_IN_TYPE extends Int32 {
    static TDH_INTYPE_NULL := 0
    static TDH_INTYPE_UNICODESTRING := 1
    static TDH_INTYPE_ANSISTRING := 2
    static TDH_INTYPE_INT8 := 3
    static TDH_INTYPE_UINT8 := 4
    static TDH_INTYPE_INT16 := 5
    static TDH_INTYPE_UINT16 := 6
    static TDH_INTYPE_INT32 := 7
    static TDH_INTYPE_UINT32 := 8
    static TDH_INTYPE_INT64 := 9
    static TDH_INTYPE_UINT64 := 10
    static TDH_INTYPE_FLOAT := 11
    static TDH_INTYPE_DOUBLE := 12
    static TDH_INTYPE_BOOLEAN := 13
    static TDH_INTYPE_BINARY := 14
    static TDH_INTYPE_GUID := 15
    static TDH_INTYPE_POINTER := 16
    static TDH_INTYPE_FILETIME := 17
    static TDH_INTYPE_SYSTEMTIME := 18
    static TDH_INTYPE_SID := 19
    static TDH_INTYPE_HEXINT32 := 20
    static TDH_INTYPE_HEXINT64 := 21
    static TDH_INTYPE_MANIFEST_COUNTEDSTRING := 22
    static TDH_INTYPE_MANIFEST_COUNTEDANSISTRING := 23
    static TDH_INTYPE_RESERVED24 := 24
    static TDH_INTYPE_MANIFEST_COUNTEDBINARY := 25
    static TDH_INTYPE_COUNTEDSTRING := 300
    static TDH_INTYPE_COUNTEDANSISTRING := 301
    static TDH_INTYPE_REVERSEDCOUNTEDSTRING := 302
    static TDH_INTYPE_REVERSEDCOUNTEDANSISTRING := 303
    static TDH_INTYPE_NONNULLTERMINATEDSTRING := 304
    static TDH_INTYPE_NONNULLTERMINATEDANSISTRING := 305
    static TDH_INTYPE_UNICODECHAR := 306
    static TDH_INTYPE_ANSICHAR := 307
    static TDH_INTYPE_SIZET := 308
    static TDH_INTYPE_HEXDUMP := 309
    static TDH_INTYPE_WBEMSID := 310
}
struct TDH_OUT_TYPE extends Int32 {
    static TDH_OUTTYPE_NULL := 0
    static TDH_OUTTYPE_STRING := 1
    static TDH_OUTTYPE_DATETIME := 2
    static TDH_OUTTYPE_BYTE := 3
    static TDH_OUTTYPE_UNSIGNEDBYTE := 4
    static TDH_OUTTYPE_SHORT := 5
    static TDH_OUTTYPE_UNSIGNEDSHORT := 6
    static TDH_OUTTYPE_INT := 7
    static TDH_OUTTYPE_UNSIGNEDINT := 8
    static TDH_OUTTYPE_LONG := 9
    static TDH_OUTTYPE_UNSIGNEDLONG := 10
    static TDH_OUTTYPE_FLOAT := 11
    static TDH_OUTTYPE_DOUBLE := 12
    static TDH_OUTTYPE_BOOLEAN := 13
    static TDH_OUTTYPE_GUID := 14
    static TDH_OUTTYPE_HEXBINARY := 15
    static TDH_OUTTYPE_HEXINT8 := 16
    static TDH_OUTTYPE_HEXINT16 := 17
    static TDH_OUTTYPE_HEXINT32 := 18
    static TDH_OUTTYPE_HEXINT64 := 19
    static TDH_OUTTYPE_PID := 20
    static TDH_OUTTYPE_TID := 21
    static TDH_OUTTYPE_PORT := 22
    static TDH_OUTTYPE_IPV4 := 23
    static TDH_OUTTYPE_IPV6 := 24
    static TDH_OUTTYPE_SOCKETADDRESS := 25
    static TDH_OUTTYPE_CIMDATETIME := 26
    static TDH_OUTTYPE_ETWTIME := 27
    static TDH_OUTTYPE_XML := 28
    static TDH_OUTTYPE_ERRORCODE := 29
    static TDH_OUTTYPE_WIN32ERROR := 30
    static TDH_OUTTYPE_NTSTATUS := 31
    static TDH_OUTTYPE_HRESULT := 32
    static TDH_OUTTYPE_CULTURE_INSENSITIVE_DATETIME := 33
    static TDH_OUTTYPE_JSON := 34
    static TDH_OUTTYPE_UTF8 := 35
    static TDH_OUTTYPE_PKCS7_WITH_TYPE_INFO := 36
    static TDH_OUTTYPE_CODE_POINTER := 37
    static TDH_OUTTYPE_DATETIME_UTC := 38
    static TDH_OUTTYPE_REDUCEDSTRING := 300
    static TDH_OUTTYPE_NOPRINT := 301
}
struct PROPERTY_FLAGS extends Int32 {
    static PropertyStruct := 1
    static PropertyParamLength := 2
    static PropertyParamCount := 4
    static PropertyWBEMXmlFragment := 8
    static PropertyParamFixedLength := 16
    static PropertyParamFixedCount := 32
    static PropertyHasTags := 64
    static PropertyHasCustomSchema := 128
}
struct EVENT_PROPERTY_INFO {
    Flags : PROPERTY_FLAGS
    NameOffset : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    struct _Anonymous1_e__Union {
        union {
            nonStructType : this._nonStructType
            structType : this._structType
            customSchemaType : this._customSchemaType
        }
        struct _nonStructType {
            InType : UInt16
            OutType : UInt16
            MapNameOffset : UInt32
        }
        struct _structType {
            StructStartIndex : UInt16
            NumOfStructMembers : UInt16
            padding : UInt32
        }
        struct _customSchemaType {
            InType : UInt16
            OutType : UInt16
            CustomSchemaOffset : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            count : UInt16
            countPropertyIndex : UInt16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            length : UInt16
            lengthPropertyIndex : UInt16
        }
    }
    struct _Anonymous4_e__Union {
        union {
            Reserved : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DECODING_SOURCE extends Int32 {
    static DecodingSourceXMLFile := 0
    static DecodingSourceWbem := 1
    static DecodingSourceWPP := 2
    static DecodingSourceTlg := 3
    static DecodingSourceMax := 4
}
struct TEMPLATE_FLAGS extends Int32 {
    static TEMPLATE_EVENT_DATA := 1
    static TEMPLATE_USER_DATA := 2
    static TEMPLATE_CONTROL_GUID := 4
}
struct TRACE_EVENT_INFO {
    ProviderGuid : GUID
    EventGuid : GUID
    EventDescriptor : EVENT_DESCRIPTOR
    DecodingSource : DECODING_SOURCE
    ProviderNameOffset : UInt32
    LevelNameOffset : UInt32
    ChannelNameOffset : UInt32
    KeywordsNameOffset : UInt32
    TaskNameOffset : UInt32
    OpcodeNameOffset : UInt32
    EventMessageOffset : UInt32
    ProviderMessageOffset : UInt32
    BinaryXMLOffset : UInt32
    BinaryXMLSize : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    PropertyCount : UInt32
    TopLevelPropertyCount : UInt32
    Anonymous3 : this._Anonymous3_e__Union
    EventPropertyInfoArray : EVENT_PROPERTY_INFO[1]
    struct _Anonymous1_e__Union {
        union {
            EventNameOffset : UInt32
            ActivityIDNameOffset : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            EventAttributesOffset : UInt32
            RelatedActivityIDNameOffset : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            Flags : TEMPLATE_FLAGS
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROPERTY_DATA_DESCRIPTOR {
    PropertyName : Int64
    ArrayIndex : UInt32
    Reserved : UInt32
}
struct PAYLOAD_OPERATOR extends Int32 {
    static PAYLOADFIELD_EQ := 0
    static PAYLOADFIELD_NE := 1
    static PAYLOADFIELD_LE := 2
    static PAYLOADFIELD_GT := 3
    static PAYLOADFIELD_LT := 4
    static PAYLOADFIELD_GE := 5
    static PAYLOADFIELD_BETWEEN := 6
    static PAYLOADFIELD_NOTBETWEEN := 7
    static PAYLOADFIELD_MODULO := 8
    static PAYLOADFIELD_CONTAINS := 20
    static PAYLOADFIELD_DOESNTCONTAIN := 21
    static PAYLOADFIELD_IS := 30
    static PAYLOADFIELD_ISNOT := 31
    static PAYLOADFIELD_INVALID := 32
}
struct PAYLOAD_FILTER_PREDICATE {
    FieldName : PWSTR
    CompareOp : UInt16
    Value : PWSTR
}
struct PROVIDER_FILTER_INFO {
    Id : UInt8
    Version : UInt8
    MessageOffset : UInt32
    Reserved : UInt32
    PropertyCount : UInt32
    EventPropertyInfoArray : EVENT_PROPERTY_INFO[1]
}
struct EVENT_FIELD_TYPE extends Int32 {
    static EventKeywordInformation := 0
    static EventLevelInformation := 1
    static EventChannelInformation := 2
    static EventTaskInformation := 3
    static EventOpcodeInformation := 4
    static EventInformationMax := 5
}
struct PROVIDER_FIELD_INFO {
    NameOffset : UInt32
    DescriptionOffset : UInt32
    Value : Int64
}
struct PROVIDER_FIELD_INFOARRAY {
    NumberOfElements : UInt32
    FieldType : EVENT_FIELD_TYPE
    FieldInfoArray : PROVIDER_FIELD_INFO[1]
}
struct TRACE_PROVIDER_INFO {
    ProviderGuid : GUID
    SchemaSource : UInt32
    ProviderNameOffset : UInt32
}
struct PROVIDER_ENUMERATION_INFO {
    NumberOfProviders : UInt32
    Reserved : UInt32
    TraceProviderInfoArray : TRACE_PROVIDER_INFO[1]
}
struct PROVIDER_EVENT_INFO {
    NumberOfEvents : UInt32
    Reserved : UInt32
    EventDescriptorsArray : EVENT_DESCRIPTOR[1]
}
struct TDH_CONTEXT_TYPE extends Int32 {
    static TDH_CONTEXT_WPP_TMFFILE := 0
    static TDH_CONTEXT_WPP_TMFSEARCHPATH := 1
    static TDH_CONTEXT_WPP_GMT := 2
    static TDH_CONTEXT_POINTERSIZE := 3
    static TDH_CONTEXT_PDB_PATH := 4
    static TDH_CONTEXT_MAXIMUM := 5
}
struct TDH_CONTEXT {
    ParameterValue : Int64
    ParameterType : TDH_CONTEXT_TYPE
    ParameterSize : UInt32
}
struct ITraceEvent extends IUnknown {
    static IID := "{8CC97F40-9028-4FF3-9B62-7D1F79CA7BCB}"
    Clone(NewEvent)
      => ComCall(3, this.p, ITraceEvent.Ptr, NewEvent)
    GetUserContext(UserContext)
      => ComCall(4, this.p, Struct.Ptr.Ptr, UserContext)
    GetEventRecord(EventRecord)
      => ComCall(5, this.p, EVENT_RECORD.Ptr.Ptr, EventRecord)
    SetPayload(Payload)
      => ComCall(6, this.p, UInt8.Ptr, Payload, UInt32, Payload.Length)
    SetEventDescriptor(EventDescriptor)
      => ComCall(7, this.p, EVENT_DESCRIPTOR.Ptr, EventDescriptor)
    SetProcessId(ProcessId)
      => ComCall(8, this.p, UInt32, ProcessId)
    SetProcessorIndex(ProcessorIndex)
      => ComCall(9, this.p, UInt32, ProcessorIndex)
    SetThreadId(ThreadId)
      => ComCall(10, this.p, UInt32, ThreadId)
    SetThreadTimes(KernelTime, UserTime)
      => ComCall(11, this.p, UInt32, KernelTime, UInt32, UserTime)
    SetActivityId(ActivityId)
      => ComCall(12, this.p, GUID.Ptr, ActivityId)
    SetTimeStamp(TimeStamp)
      => ComCall(13, this.p, Int64.Ptr, TimeStamp)
    SetProviderId(ProviderId)
      => ComCall(14, this.p, GUID.Ptr, ProviderId)
}
struct ITraceEventCallback extends IUnknown {
    static IID := "{3ED25501-593F-43E9-8F38-3AB46F5A4A52}"
    OnBeginProcessTrace(HeaderEvent, Relogger)
      => ComCall(3, this.p, ITraceEvent, HeaderEvent, ITraceRelogger, Relogger)
    OnFinalizeProcessTrace(Relogger)
      => ComCall(4, this.p, ITraceRelogger, Relogger)
    OnEvent(Event, Relogger)
      => ComCall(5, this.p, ITraceEvent, Event, ITraceRelogger, Relogger)
}
struct ITraceRelogger extends IUnknown {
    static IID := "{F754AD43-3BCC-4286-8009-9C5DA214E84E}"
    AddLogfileTraceStream(LogfileName, UserContext, TraceStreamId)
      => ComCall(3, this.p, BSTR, LogfileName, Struct.Ptr, UserContext, Int64.Ptr, TraceStreamId)
    AddRealtimeTraceStream(LoggerName, UserContext, TraceStreamId)
      => ComCall(4, this.p, BSTR, LoggerName, Struct.Ptr, UserContext, Int64.Ptr, TraceStreamId)
    RegisterCallback(Callback)
      => ComCall(5, this.p, ITraceEventCallback, Callback)
    Inject(Event)
      => ComCall(6, this.p, ITraceEvent, Event)
    CreateEventInstance(TraceStreamId, Flags, Event)
      => ComCall(7, this.p, Int64, TraceStreamId, UInt32, Flags, ITraceEvent.Ptr, Event)
    ProcessTrace()
      => ComCall(8, this.p)
    SetOutputFilename(LogfileName)
      => ComCall(9, this.p, BSTR, LogfileName)
    SetCompressionMode(CompressionMode)
      => ComCall(10, this.p, BOOLEAN, CompressionMode)
    Cancel()
      => ComCall(11, this.p)
}
