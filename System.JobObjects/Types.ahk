#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, PWSTR}
#Import "..\Security\Types.ahk" {TOKEN_GROUPS, TOKEN_PRIVILEGES}
#Import "..\System.Threading\Types.ahk" {IO_COUNTERS}

struct JOB_OBJECT_LIMIT extends UInt32 {
    static JOB_OBJECT_LIMIT_WORKINGSET := 1
    static JOB_OBJECT_LIMIT_PROCESS_TIME := 2
    static JOB_OBJECT_LIMIT_JOB_TIME := 4
    static JOB_OBJECT_LIMIT_ACTIVE_PROCESS := 8
    static JOB_OBJECT_LIMIT_AFFINITY := 16
    static JOB_OBJECT_LIMIT_PRIORITY_CLASS := 32
    static JOB_OBJECT_LIMIT_PRESERVE_JOB_TIME := 64
    static JOB_OBJECT_LIMIT_SCHEDULING_CLASS := 128
    static JOB_OBJECT_LIMIT_PROCESS_MEMORY := 256
    static JOB_OBJECT_LIMIT_JOB_MEMORY := 512
    static JOB_OBJECT_LIMIT_JOB_MEMORY_HIGH := 512
    static JOB_OBJECT_LIMIT_DIE_ON_UNHANDLED_EXCEPTION := 1024
    static JOB_OBJECT_LIMIT_BREAKAWAY_OK := 2048
    static JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK := 4096
    static JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE := 8192
    static JOB_OBJECT_LIMIT_SUBSET_AFFINITY := 16384
    static JOB_OBJECT_LIMIT_JOB_MEMORY_LOW := 32768
    static JOB_OBJECT_LIMIT_JOB_READ_BYTES := 65536
    static JOB_OBJECT_LIMIT_JOB_WRITE_BYTES := 131072
    static JOB_OBJECT_LIMIT_RATE_CONTROL := 262144
    static JOB_OBJECT_LIMIT_CPU_RATE_CONTROL := 262144
    static JOB_OBJECT_LIMIT_IO_RATE_CONTROL := 524288
    static JOB_OBJECT_LIMIT_NET_RATE_CONTROL := 1048576
    static JOB_OBJECT_LIMIT_VALID_FLAGS := 524287
    static JOB_OBJECT_BASIC_LIMIT_VALID_FLAGS := 255
    static JOB_OBJECT_EXTENDED_LIMIT_VALID_FLAGS := 32767
    static JOB_OBJECT_NOTIFICATION_LIMIT_VALID_FLAGS := 2064900
}
struct JOB_OBJECT_UILIMIT extends UInt32 {
    static JOB_OBJECT_UILIMIT_NONE := 0
    static JOB_OBJECT_UILIMIT_HANDLES := 1
    static JOB_OBJECT_UILIMIT_READCLIPBOARD := 2
    static JOB_OBJECT_UILIMIT_WRITECLIPBOARD := 4
    static JOB_OBJECT_UILIMIT_SYSTEMPARAMETERS := 8
    static JOB_OBJECT_UILIMIT_DISPLAYSETTINGS := 16
    static JOB_OBJECT_UILIMIT_GLOBALATOMS := 32
    static JOB_OBJECT_UILIMIT_DESKTOP := 64
    static JOB_OBJECT_UILIMIT_EXITWINDOWS := 128
}
struct JOB_OBJECT_SECURITY extends UInt32 {
    static JOB_OBJECT_SECURITY_NO_ADMIN := 1
    static JOB_OBJECT_SECURITY_RESTRICTED_TOKEN := 2
    static JOB_OBJECT_SECURITY_ONLY_TOKEN := 4
    static JOB_OBJECT_SECURITY_FILTER_TOKENS := 8
    static JOB_OBJECT_SECURITY_VALID_FLAGS := 15
}
struct JOB_OBJECT_CPU_RATE_CONTROL extends UInt32 {
    static JOB_OBJECT_CPU_RATE_CONTROL_ENABLE := 1
    static JOB_OBJECT_CPU_RATE_CONTROL_WEIGHT_BASED := 2
    static JOB_OBJECT_CPU_RATE_CONTROL_HARD_CAP := 4
    static JOB_OBJECT_CPU_RATE_CONTROL_NOTIFY := 8
    static JOB_OBJECT_CPU_RATE_CONTROL_MIN_MAX_RATE := 16
    static JOB_OBJECT_CPU_RATE_CONTROL_VALID_FLAGS := 63
}
struct JOB_OBJECT_TERMINATE_AT_END_ACTION extends UInt32 {
    static JOB_OBJECT_TERMINATE_AT_END_OF_JOB := 0
    static JOB_OBJECT_POST_AT_END_OF_JOB := 1
}
struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION {
    MaxIops : Int64
    MaxBandwidth : Int64
    ReservationIops : Int64
    VolumeName : PWSTR
    BaseIoSize : UInt32
    ControlFlags : UInt32
}
struct JOB_SET_ARRAY {
    JobHandle : HANDLE
    MemberLevel : UInt32
    Flags : UInt32
}
struct JOBOBJECT_BASIC_ACCOUNTING_INFORMATION {
    TotalUserTime : Int64
    TotalKernelTime : Int64
    ThisPeriodTotalUserTime : Int64
    ThisPeriodTotalKernelTime : Int64
    TotalPageFaultCount : UInt32
    TotalProcesses : UInt32
    ActiveProcesses : UInt32
    TotalTerminatedProcesses : UInt32
}
struct JOBOBJECT_BASIC_LIMIT_INFORMATION {
    PerProcessUserTimeLimit : Int64
    PerJobUserTimeLimit : Int64
    LimitFlags : JOB_OBJECT_LIMIT
    MinimumWorkingSetSize : IntPtr
    MaximumWorkingSetSize : IntPtr
    ActiveProcessLimit : UInt32
    Affinity : IntPtr
    PriorityClass : UInt32
    SchedulingClass : UInt32
}
struct JOBOBJECT_EXTENDED_LIMIT_INFORMATION {
    BasicLimitInformation : JOBOBJECT_BASIC_LIMIT_INFORMATION
    IoInfo : IO_COUNTERS
    ProcessMemoryLimit : IntPtr
    JobMemoryLimit : IntPtr
    PeakProcessMemoryUsed : IntPtr
    PeakJobMemoryUsed : IntPtr
}
struct JOBOBJECT_BASIC_PROCESS_ID_LIST {
    NumberOfAssignedProcesses : UInt32
    NumberOfProcessIdsInList : UInt32
    ProcessIdList : IntPtr[1]
}
struct JOBOBJECT_BASIC_UI_RESTRICTIONS {
    UIRestrictionsClass : JOB_OBJECT_UILIMIT
}
struct JOBOBJECT_SECURITY_LIMIT_INFORMATION {
    SecurityLimitFlags : JOB_OBJECT_SECURITY
    JobToken : HANDLE
    SidsToDisable : TOKEN_GROUPS.Ptr
    PrivilegesToDelete : TOKEN_PRIVILEGES.Ptr
    RestrictedSids : TOKEN_GROUPS.Ptr
}
struct JOBOBJECT_END_OF_JOB_TIME_INFORMATION {
    EndOfJobTimeAction : JOB_OBJECT_TERMINATE_AT_END_ACTION
}
struct JOBOBJECT_ASSOCIATE_COMPLETION_PORT {
    CompletionKey : Struct.Ptr
    CompletionPort : HANDLE
}
struct JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION {
    BasicInfo : JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
    IoInfo : IO_COUNTERS
}
struct JOBOBJECT_JOBSET_INFORMATION {
    MemberLevel : UInt32
}
struct JOBOBJECT_RATE_CONTROL_TOLERANCE extends Int32 {
    static ToleranceLow := 1
    static ToleranceMedium := 2
    static ToleranceHigh := 3
}
struct JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL extends Int32 {
    static ToleranceIntervalShort := 1
    static ToleranceIntervalMedium := 2
    static ToleranceIntervalLong := 3
}
struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION {
    IoReadBytesLimit : Int64
    IoWriteBytesLimit : Int64
    PerJobUserTimeLimit : Int64
    JobMemoryLimit : Int64
    RateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    RateControlToleranceInterval : JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
    LimitFlags : JOB_OBJECT_LIMIT
}
struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION_2 {
    IoReadBytesLimit : Int64
    IoWriteBytesLimit : Int64
    PerJobUserTimeLimit : Int64
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    LimitFlags : JOB_OBJECT_LIMIT
    IoRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    JobLowMemoryLimit : Int64
    IoRateControlToleranceInterval : JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
    NetRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    NetRateControlToleranceInterval : JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
    struct _Anonymous1_e__Union {
        union {
            JobHighMemoryLimit : Int64
            JobMemoryLimit : Int64
        }
    }
    struct _Anonymous2_e__Union {
        union {
            RateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
            CpuRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
        }
    }
    struct _Anonymous3_e__Union {
        union {
            RateControlToleranceInterval : JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
            CpuRateControlToleranceInterval : JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL
        }
    }
}
struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION {
    LimitFlags : JOB_OBJECT_LIMIT
    ViolationLimitFlags : JOB_OBJECT_LIMIT
    IoReadBytes : Int64
    IoReadBytesLimit : Int64
    IoWriteBytes : Int64
    IoWriteBytesLimit : Int64
    PerJobUserTime : Int64
    PerJobUserTimeLimit : Int64
    JobMemory : Int64
    JobMemoryLimit : Int64
    RateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    RateControlToleranceLimit : JOBOBJECT_RATE_CONTROL_TOLERANCE
}
struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION_2 {
    LimitFlags : JOB_OBJECT_LIMIT
    ViolationLimitFlags : JOB_OBJECT_LIMIT
    IoReadBytes : Int64
    IoReadBytesLimit : Int64
    IoWriteBytes : Int64
    IoWriteBytesLimit : Int64
    PerJobUserTime : Int64
    PerJobUserTimeLimit : Int64
    JobMemory : Int64
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    JobLowMemoryLimit : Int64
    IoRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    IoRateControlToleranceLimit : JOBOBJECT_RATE_CONTROL_TOLERANCE
    NetRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
    NetRateControlToleranceLimit : JOBOBJECT_RATE_CONTROL_TOLERANCE
    struct _Anonymous1_e__Union {
        union {
            JobHighMemoryLimit : Int64
            JobMemoryLimit : Int64
        }
    }
    struct _Anonymous2_e__Union {
        union {
            RateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
            CpuRateControlTolerance : JOBOBJECT_RATE_CONTROL_TOLERANCE
        }
    }
    struct _Anonymous3_e__Union {
        union {
            RateControlToleranceLimit : JOBOBJECT_RATE_CONTROL_TOLERANCE
            CpuRateControlToleranceLimit : JOBOBJECT_RATE_CONTROL_TOLERANCE
        }
    }
}
struct JOBOBJECT_CPU_RATE_CONTROL_INFORMATION {
    ControlFlags : JOB_OBJECT_CPU_RATE_CONTROL
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            CpuRate : UInt32
            Weight : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            MinRate : UInt16
            MaxRate : UInt16
        }
    }
}
struct JOB_OBJECT_NET_RATE_CONTROL_FLAGS extends Int32 {
    static JOB_OBJECT_NET_RATE_CONTROL_ENABLE := 1
    static JOB_OBJECT_NET_RATE_CONTROL_MAX_BANDWIDTH := 2
    static JOB_OBJECT_NET_RATE_CONTROL_DSCP_TAG := 4
    static JOB_OBJECT_NET_RATE_CONTROL_VALID_FLAGS := 7
}
struct JOBOBJECT_NET_RATE_CONTROL_INFORMATION {
    MaxBandwidth : Int64
    ControlFlags : JOB_OBJECT_NET_RATE_CONTROL_FLAGS
    DscpTag : UInt8
}
struct JOB_OBJECT_IO_RATE_CONTROL_FLAGS extends Int32 {
    static JOB_OBJECT_IO_RATE_CONTROL_ENABLE := 1
    static JOB_OBJECT_IO_RATE_CONTROL_STANDALONE_VOLUME := 2
    static JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ALL := 4
    static JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ON_SOFT_CAP := 8
    static JOB_OBJECT_IO_RATE_CONTROL_VALID_FLAGS := 15
}
struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V1 {
    MaxIops : Int64
    MaxBandwidth : Int64
    ReservationIops : Int64
    VolumeName : PWSTR
    BaseIoSize : UInt32
    ControlFlags : JOB_OBJECT_IO_RATE_CONTROL_FLAGS
    VolumeNameLength : UInt16
}
struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V2 {
    MaxIops : Int64
    MaxBandwidth : Int64
    ReservationIops : Int64
    VolumeName : PWSTR
    BaseIoSize : UInt32
    ControlFlags : JOB_OBJECT_IO_RATE_CONTROL_FLAGS
    VolumeNameLength : UInt16
    CriticalReservationIops : Int64
    ReservationBandwidth : Int64
    CriticalReservationBandwidth : Int64
    MaxTimePercent : Int64
    ReservationTimePercent : Int64
    CriticalReservationTimePercent : Int64
}
struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V3 {
    MaxIops : Int64
    MaxBandwidth : Int64
    ReservationIops : Int64
    VolumeName : PWSTR
    BaseIoSize : UInt32
    ControlFlags : JOB_OBJECT_IO_RATE_CONTROL_FLAGS
    VolumeNameLength : UInt16
    CriticalReservationIops : Int64
    ReservationBandwidth : Int64
    CriticalReservationBandwidth : Int64
    MaxTimePercent : Int64
    ReservationTimePercent : Int64
    CriticalReservationTimePercent : Int64
    SoftMaxIops : Int64
    SoftMaxBandwidth : Int64
    SoftMaxTimePercent : Int64
    LimitExcessNotifyIops : Int64
    LimitExcessNotifyBandwidth : Int64
    LimitExcessNotifyTimePercent : Int64
}
struct JOBOBJECT_IO_ATTRIBUTION_CONTROL_FLAGS extends Int32 {
    static JOBOBJECT_IO_ATTRIBUTION_CONTROL_ENABLE := 1
    static JOBOBJECT_IO_ATTRIBUTION_CONTROL_DISABLE := 2
    static JOBOBJECT_IO_ATTRIBUTION_CONTROL_VALID_FLAGS := 3
}
struct JOBOBJECT_IO_ATTRIBUTION_STATS {
    IoCount : IntPtr
    TotalNonOverlappedQueueTime : Int64
    TotalNonOverlappedServiceTime : Int64
    TotalSize : Int64
}
struct JOBOBJECT_IO_ATTRIBUTION_INFORMATION {
    ControlFlags : UInt32
    ReadStats : JOBOBJECT_IO_ATTRIBUTION_STATS
    WriteStats : JOBOBJECT_IO_ATTRIBUTION_STATS
}
struct JOBOBJECTINFOCLASS extends Int32 {
    static JobObjectBasicAccountingInformation := 1
    static JobObjectBasicLimitInformation := 2
    static JobObjectBasicProcessIdList := 3
    static JobObjectBasicUIRestrictions := 4
    static JobObjectSecurityLimitInformation := 5
    static JobObjectEndOfJobTimeInformation := 6
    static JobObjectAssociateCompletionPortInformation := 7
    static JobObjectBasicAndIoAccountingInformation := 8
    static JobObjectExtendedLimitInformation := 9
    static JobObjectJobSetInformation := 10
    static JobObjectGroupInformation := 11
    static JobObjectNotificationLimitInformation := 12
    static JobObjectLimitViolationInformation := 13
    static JobObjectGroupInformationEx := 14
    static JobObjectCpuRateControlInformation := 15
    static JobObjectCompletionFilter := 16
    static JobObjectCompletionCounter := 17
    static JobObjectReserved1Information := 18
    static JobObjectReserved2Information := 19
    static JobObjectReserved3Information := 20
    static JobObjectReserved4Information := 21
    static JobObjectReserved5Information := 22
    static JobObjectReserved6Information := 23
    static JobObjectReserved7Information := 24
    static JobObjectReserved8Information := 25
    static JobObjectReserved9Information := 26
    static JobObjectReserved10Information := 27
    static JobObjectReserved11Information := 28
    static JobObjectReserved12Information := 29
    static JobObjectReserved13Information := 30
    static JobObjectReserved14Information := 31
    static JobObjectNetRateControlInformation := 32
    static JobObjectNotificationLimitInformation2 := 33
    static JobObjectLimitViolationInformation2 := 34
    static JobObjectCreateSilo := 35
    static JobObjectSiloBasicInformation := 36
    static JobObjectReserved15Information := 37
    static JobObjectReserved16Information := 38
    static JobObjectReserved17Information := 39
    static JobObjectReserved18Information := 40
    static JobObjectReserved19Information := 41
    static JobObjectReserved20Information := 42
    static JobObjectReserved21Information := 43
    static JobObjectReserved22Information := 44
    static JobObjectReserved23Information := 45
    static JobObjectReserved24Information := 46
    static JobObjectReserved25Information := 47
    static JobObjectReserved26Information := 48
    static JobObjectReserved27Information := 49
    static JobObjectReserved28Information := 50
    static JobObjectNetworkAccountingInformation := 51
    static JobObjectCpuPartition := 52
    static MaxJobObjectInfoClass := 53
}
