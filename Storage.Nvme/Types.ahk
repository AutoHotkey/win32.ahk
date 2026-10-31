#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {CHAR}

struct NVME_CONTROLLER_TYPE extends Int32 {
    static NvmeCtrlNotReported := 0
    static NvmeCtrlIO := 1
    static NvmeCtrlDiscovery := 2
    static NvmeCtrlAdmin := 3
    static NvmeCtrlReservedMin := 4
    static NvmeCtrlReservedMax := 255
}
struct NVME_PROPERTY_OFFSET extends Int32 {
    static NvmePropCAP := 0
    static NvmePropVS := 8
    static NvmePropINTMS := 12
    static NvmePropINTMC := 16
    static NvmePropCC := 20
    static NvmePropCSTS := 28
    static NvmePropNSSR := 32
    static NvmePropAQA := 36
    static NvmePropASQ := 40
    static NvmePropACQ := 48
    static NvmePropCMBLOC := 56
    static NvmePropCMBSZ := 60
    static NvmePropBPINFO := 64
    static NvmePropBPRSEL := 68
    static NvmePropBPMBL := 72
    static NvmePropCMBMSC := 80
    static NvmePropCMBSTS := 88
    static NvmePropCMBEBS := 92
    static NvmePropCMBSWTP := 96
    static NvmePropNSSD := 100
    static NvmePropCRTO := 104
    static NvmePropPMRCAP := 3584
    static NvmePropPMRCTL := 3588
    static NvmePropPMRSTS := 3592
    static NvmePropPMREBS := 3596
    static NvmePropPMRSWTP := 3600
    static NvmePropPMRMSCL := 3604
    static NvmePropPMRMSCU := 3608
}
struct NVME_AMS_OPTION extends Int32 {
    static NVME_AMS_ROUND_ROBIN := 0
    static NVME_AMS_WEIGHTED_ROUND_ROBIN_URGENT := 1
}
struct NVME_CPS_VALUE extends Int32 {
    static NVME_CPS_NOT_REPORTED := 0
    static NVME_CPS_CONTROLLER_SCOPE := 1
    static NVME_CPS_DOMAIN_SCOPE := 2
    static NVME_CPS_SUBSYSTEM_SCOPE := 3
}
struct NVME_CONTROLLER_CAPABILITIES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct NVME_VERSION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CC_SHN_SHUTDOWN_NOTIFICATIONS extends Int32 {
    static NVME_CC_SHN_NO_NOTIFICATION := 0
    static NVME_CC_SHN_NORMAL_SHUTDOWN := 1
    static NVME_CC_SHN_ABRUPT_SHUTDOWN := 2
}
struct NVME_CSS_COMMAND_SETS extends Int32 {
    static NVME_CSS_NVM_COMMAND_SET := 0
    static NVME_CSS_ALL_SUPPORTED_IO_COMMAND_SET := 6
    static NVME_CSS_ADMIN_COMMAND_SET_ONLY := 7
}
struct NVME_CONTROLLER_CONFIGURATION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CSTS_SHST_SHUTDOWN_STATUS extends Int32 {
    static NVME_CSTS_SHST_NO_SHUTDOWN := 0
    static NVME_CSTS_SHST_SHUTDOWN_IN_PROCESS := 1
    static NVME_CSTS_SHST_SHUTDOWN_COMPLETED := 2
}
struct NVME_CONTROLLER_STATUS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_NVM_SUBSYSTEM_RESET {
    NSSRC : UInt32
}
struct NVME_ADMIN_QUEUE_ATTRIBUTES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_ADMIN_SUBMISSION_QUEUE_BASE_ADDRESS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct NVME_ADMIN_COMPLETION_QUEUE_BASE_ADDRESS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct NVME_CONTROLLER_MEMORY_BUFFER_LOCATION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CMBSZ_SIZE_UNITS extends Int32 {
    static NVME_CMBSZ_SIZE_UNITS_4KB := 0
    static NVME_CMBSZ_SIZE_UNITS_64KB := 1
    static NVME_CMBSZ_SIZE_UNITS_1MB := 2
    static NVME_CMBSZ_SIZE_UNITS_16MB := 3
    static NVME_CMBSZ_SIZE_UNITS_256MB := 4
    static NVME_CMBSZ_SIZE_UNITS_4GB := 5
    static NVME_CMBSZ_SIZE_UNITS_64GB := 6
}
struct NVME_BOOT_PARTITION_INFORMATION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CONTROLLER_MEMORY_BUFFER_SIZE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_NVM_SUBSYSTEM_SHUTDOWN {
    NSSC : UInt32
}
struct NVME_CONTROLLER_READY_TIMEOUTS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        CRWMT : UInt16
        CRIMT : UInt16
    }
}
struct NVME_SUBMISSION_QUEUE_TAIL_DOORBELL {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_COMPLETION_QUEUE_HEAD_DOORBELL {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CONTROLLER_REGISTERS {
    CAP : NVME_CONTROLLER_CAPABILITIES
    VS : NVME_VERSION
    INTMS : UInt32
    INTMC : UInt32
    CC : NVME_CONTROLLER_CONFIGURATION
    Reserved0 : UInt32
    CSTS : NVME_CONTROLLER_STATUS
    NSSR : NVME_NVM_SUBSYSTEM_RESET
    AQA : NVME_ADMIN_QUEUE_ATTRIBUTES
    ASQ : NVME_ADMIN_SUBMISSION_QUEUE_BASE_ADDRESS
    ACQ : NVME_ADMIN_COMPLETION_QUEUE_BASE_ADDRESS
    CMBLOC : NVME_CONTROLLER_MEMORY_BUFFER_LOCATION
    CMBSZ : NVME_CONTROLLER_MEMORY_BUFFER_SIZE
    BPINFO : NVME_BOOT_PARTITION_INFORMATION
    Reserved1 : UInt32[8]
    NSSD : NVME_NVM_SUBSYSTEM_SHUTDOWN
    CRTO : NVME_CONTROLLER_READY_TIMEOUTS
    Reserved2 : UInt32[933]
    Reserved3 : UInt32[64]
    Doorbells : UInt32[1]
}
struct NVME_COMMAND_STATUS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUshort : UInt16
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct NVME_COMPLETION_ENTRY {
    DW0 : UInt32
    DW1 : UInt32
    DW2 : this._DW2_e__Union
    DW3 : this._DW3_e__Union
    struct _DW2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUlong : UInt32
        }
        struct _Anonymous_e__Struct {
            SQHD : UInt16
            SQID : UInt16
        }
    }
    struct _DW3_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUlong : UInt32
        }
        struct _Anonymous_e__Struct {
            CID : UInt16
            Status : NVME_COMMAND_STATUS
        }
    }
}
struct NVME_ASYNC_EVENT_TYPES extends Int32 {
    static NVME_ASYNC_EVENT_TYPE_ERROR_STATUS := 0
    static NVME_ASYNC_EVENT_TYPE_HEALTH_STATUS := 1
    static NVME_ASYNC_EVENT_TYPE_NOTICE := 2
    static NVME_ASYNC_EVENT_TYPE_IMMEDIATE := 3
    static NVME_ASYNC_EVENT_TYPE_IO_COMMAND_SET_STATUS := 6
    static NVME_ASYNC_EVENT_TYPE_VENDOR_SPECIFIC := 7
}
struct NVME_ASYNC_EVENT_ERROR_STATUS_CODES extends Int32 {
    static NVME_ASYNC_ERROR_WRITE_TO_INVALID_DOORBELL_REGISTER := 0
    static NVME_ASYNC_ERROR_INVALID_DOORBELL_WRITE_VALUE := 1
    static NVME_ASYNC_ERROR_DIAG_FAILURE := 2
    static NVME_ASYNC_ERROR_PERSISTENT_INTERNAL_DEVICE_ERROR := 3
    static NVME_ASYNC_ERROR_TRANSIENT_INTERNAL_DEVICE_ERROR := 4
    static NVME_ASYNC_ERROR_FIRMWARE_IMAGE_LOAD_ERROR := 5
}
struct NVME_ASYNC_EVENT_HEALTH_STATUS_CODES extends Int32 {
    static NVME_ASYNC_HEALTH_NVM_SUBSYSTEM_RELIABILITY := 0
    static NVME_ASYNC_HEALTH_TEMPERATURE_THRESHOLD := 1
    static NVME_ASYNC_HEALTH_SPARE_BELOW_THRESHOLD := 2
}
struct NVME_ASYNC_EVENT_NOTICE_CODES extends Int32 {
    static NVME_ASYNC_NOTICE_NAMESPACE_ATTRIBUTE_CHANGED := 0
    static NVME_ASYNC_NOTICE_FIRMWARE_ACTIVATION_STARTING := 1
    static NVME_ASYNC_NOTICE_TELEMETRY_LOG_CHANGED := 2
    static NVME_ASYNC_NOTICE_ASYMMETRIC_ACCESS_CHANGE := 3
    static NVME_ASYNC_NOTICE_PREDICTABLE_LATENCY_EVENT_AGGREGATE_LOG_CHANGE := 4
    static NVME_ASYNC_NOTICE_LBA_STATUS_INFORMATION_ALERT := 5
    static NVME_ASYNC_NOTICE_ENDURANCE_GROUP_EVENT_AGGREGATE_LOG_CHANGE := 6
    static NVME_ASYNC_NOTICE_ZONE_DESCRIPTOR_CHANGED := 239
    static NVME_ASYNC_NOTICE_DISCOVERY_LOG_PAGE_CHANGED := 240
}
struct NVME_ASYNC_EVENT_IMMEDIATE_STATUS_CODES extends Int32 {
    static NVME_ASYNC_IMMEDIATE_NVM_SUBSYSTEM_NORMAL_SHUTDOWN := 0
}
struct NVME_ASYNC_EVENT_IO_COMMAND_SET_STATUS_CODES extends Int32 {
    static NVME_ASYNC_IO_CMD_SET_RESERVATION_LOG_PAGE_AVAILABLE := 0
    static NVME_ASYNC_IO_CMD_SANITIZE_OPERATION_COMPLETED := 1
    static NVME_ASYNC_IO_CMD_SANITIZE_OPERATION_COMPLETED_WITH_UNEXPECTED_DEALLOCATION := 2
}
struct NVME_COMPLETION_DW0_ASYNC_EVENT_REQUEST {
    _bitfield : UInt32
}
struct NVME_STATUS_TYPES extends Int32 {
    static NVME_STATUS_TYPE_GENERIC_COMMAND := 0
    static NVME_STATUS_TYPE_COMMAND_SPECIFIC := 1
    static NVME_STATUS_TYPE_MEDIA_ERROR := 2
    static NVME_STATUS_TYPE_PATH_RELATED := 3
    static NVME_STATUS_TYPE_VENDOR_SPECIFIC := 7
}
struct NVME_STATUS_GENERIC_COMMAND_CODES extends Int32 {
    static NVME_STATUS_SUCCESS_COMPLETION := 0
    static NVME_STATUS_INVALID_COMMAND_OPCODE := 1
    static NVME_STATUS_INVALID_FIELD_IN_COMMAND := 2
    static NVME_STATUS_COMMAND_ID_CONFLICT := 3
    static NVME_STATUS_DATA_TRANSFER_ERROR := 4
    static NVME_STATUS_COMMAND_ABORTED_DUE_TO_POWER_LOSS_NOTIFICATION := 5
    static NVME_STATUS_INTERNAL_DEVICE_ERROR := 6
    static NVME_STATUS_COMMAND_ABORT_REQUESTED := 7
    static NVME_STATUS_COMMAND_ABORTED_DUE_TO_SQ_DELETION := 8
    static NVME_STATUS_COMMAND_ABORTED_DUE_TO_FAILED_FUSED_COMMAND := 9
    static NVME_STATUS_COMMAND_ABORTED_DUE_TO_FAILED_MISSING_COMMAND := 10
    static NVME_STATUS_INVALID_NAMESPACE_OR_FORMAT := 11
    static NVME_STATUS_COMMAND_SEQUENCE_ERROR := 12
    static NVME_STATUS_INVALID_SGL_LAST_SEGMENT_DESCR := 13
    static NVME_STATUS_INVALID_NUMBER_OF_SGL_DESCR := 14
    static NVME_STATUS_DATA_SGL_LENGTH_INVALID := 15
    static NVME_STATUS_METADATA_SGL_LENGTH_INVALID := 16
    static NVME_STATUS_SGL_DESCR_TYPE_INVALID := 17
    static NVME_STATUS_INVALID_USE_OF_CONTROLLER_MEMORY_BUFFER := 18
    static NVME_STATUS_PRP_OFFSET_INVALID := 19
    static NVME_STATUS_ATOMIC_WRITE_UNIT_EXCEEDED := 20
    static NVME_STATUS_OPERATION_DENIED := 21
    static NVME_STATUS_SGL_OFFSET_INVALID := 22
    static NVME_STATUS_RESERVED := 23
    static NVME_STATUS_HOST_IDENTIFIER_INCONSISTENT_FORMAT := 24
    static NVME_STATUS_KEEP_ALIVE_TIMEOUT_EXPIRED := 25
    static NVME_STATUS_KEEP_ALIVE_TIMEOUT_INVALID := 26
    static NVME_STATUS_COMMAND_ABORTED_DUE_TO_PREEMPT_ABORT := 27
    static NVME_STATUS_SANITIZE_FAILED := 28
    static NVME_STATUS_SANITIZE_IN_PROGRESS := 29
    static NVME_STATUS_SGL_DATA_BLOCK_GRANULARITY_INVALID := 30
    static NVME_STATUS_COMMAND_NOT_SUPPORTED_FOR_QUEUE_IN_CMB := 31
    static NVME_STATUS_NAMESPACE_IS_WRITE_PROTECTED := 32
    static NVME_STATUS_COMMAND_INTERRUPTED := 33
    static NVME_STATUS_TRANSIENT_TRANSPORT_ERROR := 34
    static NVME_STATUS_COMMAND_PROHIBITED_BY_LOCKDOWN := 35
    static NVME_STATUS_ADMIN_COMMAND_MEDIA_NOT_READY := 36
    static NVME_STATUS_DIRECTIVE_TYPE_INVALID := 112
    static NVME_STATUS_DIRECTIVE_ID_INVALID := 113
    static NVME_STATUS_NVM_LBA_OUT_OF_RANGE := 128
    static NVME_STATUS_NVM_CAPACITY_EXCEEDED := 129
    static NVME_STATUS_NVM_NAMESPACE_NOT_READY := 130
    static NVME_STATUS_NVM_RESERVATION_CONFLICT := 131
    static NVME_STATUS_FORMAT_IN_PROGRESS := 132
}
struct NVME_STATUS_COMMAND_SPECIFIC_CODES extends Int32 {
    static NVME_STATUS_COMPLETION_QUEUE_INVALID := 0
    static NVME_STATUS_INVALID_QUEUE_IDENTIFIER := 1
    static NVME_STATUS_MAX_QUEUE_SIZE_EXCEEDED := 2
    static NVME_STATUS_ABORT_COMMAND_LIMIT_EXCEEDED := 3
    static NVME_STATUS_ASYNC_EVENT_REQUEST_LIMIT_EXCEEDED := 5
    static NVME_STATUS_INVALID_FIRMWARE_SLOT := 6
    static NVME_STATUS_INVALID_FIRMWARE_IMAGE := 7
    static NVME_STATUS_INVALID_INTERRUPT_VECTOR := 8
    static NVME_STATUS_INVALID_LOG_PAGE := 9
    static NVME_STATUS_INVALID_FORMAT := 10
    static NVME_STATUS_FIRMWARE_ACTIVATION_REQUIRES_CONVENTIONAL_RESET := 11
    static NVME_STATUS_INVALID_QUEUE_DELETION := 12
    static NVME_STATUS_FEATURE_ID_NOT_SAVEABLE := 13
    static NVME_STATUS_FEATURE_NOT_CHANGEABLE := 14
    static NVME_STATUS_FEATURE_NOT_NAMESPACE_SPECIFIC := 15
    static NVME_STATUS_FIRMWARE_ACTIVATION_REQUIRES_NVM_SUBSYSTEM_RESET := 16
    static NVME_STATUS_FIRMWARE_ACTIVATION_REQUIRES_RESET := 17
    static NVME_STATUS_FIRMWARE_ACTIVATION_REQUIRES_MAX_TIME_VIOLATION := 18
    static NVME_STATUS_FIRMWARE_ACTIVATION_PROHIBITED := 19
    static NVME_STATUS_OVERLAPPING_RANGE := 20
    static NVME_STATUS_NAMESPACE_INSUFFICIENT_CAPACITY := 21
    static NVME_STATUS_NAMESPACE_IDENTIFIER_UNAVAILABLE := 22
    static NVME_STATUS_NAMESPACE_ALREADY_ATTACHED := 24
    static NVME_STATUS_NAMESPACE_IS_PRIVATE := 25
    static NVME_STATUS_NAMESPACE_NOT_ATTACHED := 26
    static NVME_STATUS_NAMESPACE_THIN_PROVISIONING_NOT_SUPPORTED := 27
    static NVME_STATUS_CONTROLLER_LIST_INVALID := 28
    static NVME_STATUS_DEVICE_SELF_TEST_IN_PROGRESS := 29
    static NVME_STATUS_BOOT_PARTITION_WRITE_PROHIBITED := 30
    static NVME_STATUS_INVALID_CONTROLLER_IDENTIFIER := 31
    static NVME_STATUS_INVALID_SECONDARY_CONTROLLER_STATE := 32
    static NVME_STATUS_INVALID_NUMBER_OF_CONTROLLER_RESOURCES := 33
    static NVME_STATUS_INVALID_RESOURCE_IDENTIFIER := 34
    static NVME_STATUS_SANITIZE_PROHIBITED_ON_PERSISTENT_MEMORY := 35
    static NVME_STATUS_INVALID_ANA_GROUP_IDENTIFIER := 36
    static NVME_STATUS_ANA_ATTACH_FAILED := 37
    static NVME_STATUS_INSUFFICIENT_CAPACITY := 38
    static NVME_STATUS_NAMESPACE_ATTACHMENT_LIMIT_EXCEEDED := 39
    static NVME_STATUS_PROHIBITION_NOT_SUPPORTED := 40
    static NVME_IO_COMMAND_SET_NOT_SUPPORTED := 41
    static NVME_IO_COMMAND_SET_NOT_ENABLED := 42
    static NVME_IO_COMMAND_SET_COMBINATION_REJECTED := 43
    static NVME_IO_COMMAND_SET_INVALID := 44
    static NVME_STATUS_INVALID_DISCOVERY_INFORMATION := 47
    static NVME_STATUS_INSUFFICIENT_DISCOVERY_RESOURCES := 50
    static NVME_STATUS_STREAM_RESOURCE_ALLOCATION_FAILED := 127
    static NVME_STATUS_ZONE_INVALID_FORMAT := 127
    static NVME_STATUS_NVM_CONFLICTING_ATTRIBUTES := 128
    static NVME_STATUS_NVM_INVALID_PROTECTION_INFORMATION := 129
    static NVME_STATUS_NVM_ATTEMPTED_WRITE_TO_READ_ONLY_RANGE := 130
    static NVME_STATUS_NVM_COMMAND_SIZE_LIMIT_EXCEEDED := 131
    static NVME_STATUS_ZONE_BOUNDARY_ERROR := 184
    static NVME_STATUS_ZONE_FULL := 185
    static NVME_STATUS_ZONE_READ_ONLY := 186
    static NVME_STATUS_ZONE_OFFLINE := 187
    static NVME_STATUS_ZONE_INVALID_WRITE := 188
    static NVME_STATUS_ZONE_TOO_MANY_ACTIVE := 189
    static NVME_STATUS_ZONE_TOO_MANY_OPEN := 190
    static NVME_STATUS_ZONE_INVALID_STATE_TRANSITION := 191
}
struct NVME_STATUS_FABRIC_COMMAND_CODES extends Int32 {
    static NVME_STATUS_INCOMPATIBLE_FORMAT := 128
    static NVME_STATUS_CONTROLLER_BUSY := 129
    static NVME_STATUS_CONNECT_INVALID_PARAMETERS := 130
    static NVME_STATUS_CONNECT_RESTART_DISCOVERY := 131
    static NVME_STATUS_CONNECT_INVALID_HOST := 132
    static NVME_STATUS_INVALID_QUEUE_TYPE := 133
    static NVME_STATUS_DISCOVER_RESTART := 144
    static NVME_STATUS_AUTHENTICATION_REQUIRED := 145
}
struct NVME_STATUS_PATH_ERROR_CODES extends Int32 {
    static NVME_STATUS_INTERNAL_PATH_ERROR := 0
    static NVME_STATUS_ASYMMETRIC_ACCESS_PERSISTENT_LOSS := 1
    static NVME_STATUS_ASYMMETRIC_ACCESS_INACCESSIBLE := 2
    static NVME_STATUS_ASYMMETRIC_ACCESS_TRANSITION := 3
    static NVME_STATUS_CONTROLLER_PATHING_ERROR := 96
    static NVME_STATUS_HOST_PATHING_ERROR := 112
    static NVME_STATUS_COMMAND_ABORTED_BY_HOST := 113
}
struct NVME_STATUS_MEDIA_ERROR_CODES extends Int32 {
    static NVME_STATUS_NVM_WRITE_FAULT := 128
    static NVME_STATUS_NVM_UNRECOVERED_READ_ERROR := 129
    static NVME_STATUS_NVM_END_TO_END_GUARD_CHECK_ERROR := 130
    static NVME_STATUS_NVM_END_TO_END_APPLICATION_TAG_CHECK_ERROR := 131
    static NVME_STATUS_NVM_END_TO_END_REFERENCE_TAG_CHECK_ERROR := 132
    static NVME_STATUS_NVM_COMPARE_FAILURE := 133
    static NVME_STATUS_NVM_ACCESS_DENIED := 134
    static NVME_STATUS_NVM_DEALLOCATED_OR_UNWRITTEN_LOGICAL_BLOCK := 135
}
struct NVME_ADMIN_COMMANDS extends Int32 {
    static NVME_ADMIN_COMMAND_DELETE_IO_SQ := 0
    static NVME_ADMIN_COMMAND_CREATE_IO_SQ := 1
    static NVME_ADMIN_COMMAND_GET_LOG_PAGE := 2
    static NVME_ADMIN_COMMAND_DELETE_IO_CQ := 4
    static NVME_ADMIN_COMMAND_CREATE_IO_CQ := 5
    static NVME_ADMIN_COMMAND_IDENTIFY := 6
    static NVME_ADMIN_COMMAND_ABORT := 8
    static NVME_ADMIN_COMMAND_SET_FEATURES := 9
    static NVME_ADMIN_COMMAND_GET_FEATURES := 10
    static NVME_ADMIN_COMMAND_ASYNC_EVENT_REQUEST := 12
    static NVME_ADMIN_COMMAND_NAMESPACE_MANAGEMENT := 13
    static NVME_ADMIN_COMMAND_FIRMWARE_ACTIVATE := 16
    static NVME_ADMIN_COMMAND_FIRMWARE_COMMIT := 16
    static NVME_ADMIN_COMMAND_FIRMWARE_IMAGE_DOWNLOAD := 17
    static NVME_ADMIN_COMMAND_DEVICE_SELF_TEST := 20
    static NVME_ADMIN_COMMAND_NAMESPACE_ATTACHMENT := 21
    static NVME_ADMIN_COMMAND_KEEP_ALIVE := 24
    static NVME_ADMIN_COMMAND_DIRECTIVE_SEND := 25
    static NVME_ADMIN_COMMAND_DIRECTIVE_RECEIVE := 26
    static NVME_ADMIN_COMMAND_VIRTUALIZATION_MANAGEMENT := 28
    static NVME_ADMIN_COMMAND_NVME_MI_SEND := 29
    static NVME_ADMIN_COMMAND_NVME_MI_RECEIVE := 30
    static NVME_ADMIN_COMMAND_DISCOVERY_INFO_MGMT := 33
    static NVME_ADMIN_COMMAND_DOORBELL_BUFFER_CONFIG := 124
    static NVME_ADMIN_COMMAND_FABRICS := 127
    static NVME_ADMIN_COMMAND_FORMAT_NVM := 128
    static NVME_ADMIN_COMMAND_SECURITY_SEND := 129
    static NVME_ADMIN_COMMAND_SECURITY_RECEIVE := 130
    static NVME_ADMIN_COMMAND_SANITIZE := 132
    static NVME_ADMIN_COMMAND_GET_LBA_STATUS := 134
}
struct NVME_FEATURES extends Int32 {
    static NVME_FEATURE_ARBITRATION := 1
    static NVME_FEATURE_POWER_MANAGEMENT := 2
    static NVME_FEATURE_LBA_RANGE_TYPE := 3
    static NVME_FEATURE_TEMPERATURE_THRESHOLD := 4
    static NVME_FEATURE_ERROR_RECOVERY := 5
    static NVME_FEATURE_VOLATILE_WRITE_CACHE := 6
    static NVME_FEATURE_NUMBER_OF_QUEUES := 7
    static NVME_FEATURE_INTERRUPT_COALESCING := 8
    static NVME_FEATURE_INTERRUPT_VECTOR_CONFIG := 9
    static NVME_FEATURE_WRITE_ATOMICITY := 10
    static NVME_FEATURE_ASYNC_EVENT_CONFIG := 11
    static NVME_FEATURE_AUTONOMOUS_POWER_STATE_TRANSITION := 12
    static NVME_FEATURE_HOST_MEMORY_BUFFER := 13
    static NVME_FEATURE_TIMESTAMP := 14
    static NVME_FEATURE_KEEP_ALIVE := 15
    static NVME_FEATURE_HOST_CONTROLLED_THERMAL_MANAGEMENT := 16
    static NVME_FEATURE_NONOPERATIONAL_POWER_STATE := 17
    static NVME_FEATURE_READ_RECOVERY_LEVEL_CONFIG := 18
    static NVME_FEATURE_PREDICTABLE_LATENCY_MODE_CONFIG := 19
    static NVME_FEATURE_PREDICTABLE_LATENCY_MODE_WINDOW := 20
    static NVME_FEATURE_LBA_STATUS_INFORMATION_REPORT_INTERVAL := 21
    static NVME_FEATURE_HOST_BEHAVIOR_SUPPORT := 22
    static NVME_FEATURE_SANITIZE_CONFIG := 23
    static NVME_FEATURE_ENDURANCE_GROUP_EVENT_CONFIG := 24
    static NVME_FEATURE_IO_COMMAND_SET_PROFILE := 25
    static NVME_FEATURE_ENHANCED_CONTROLLER_METADATA := 125
    static NVME_FEATURE_CONTROLLER_METADATA := 126
    static NVME_FEATURE_NAMESPACE_METADATA := 127
    static NVME_FEATURE_NVM_SOFTWARE_PROGRESS_MARKER := 128
    static NVME_FEATURE_NVM_HOST_IDENTIFIER := 129
    static NVME_FEATURE_NVM_RESERVATION_NOTIFICATION_MASK := 130
    static NVME_FEATURE_NVM_RESERVATION_PERSISTANCE := 131
    static NVME_FEATURE_NVM_NAMESPACE_WRITE_PROTECTION_CONFIG := 132
    static NVME_FEATURE_ERROR_INJECTION := 192
    static NVME_FEATURE_CLEAR_FW_UPDATE_HISTORY := 193
    static NVME_FEATURE_READONLY_WRITETHROUGH_MODE := 194
    static NVME_FEATURE_CLEAR_PCIE_CORRECTABLE_ERROR_COUNTERS := 195
    static NVME_FEATURE_ENABLE_IEEE1667_SILO := 196
    static NVME_FEATURE_LATENCY_MONITOR := 197
    static NVME_FEATURE_PLP_HEALTH_CHECK_INTERVAL := 198
    static NVME_FEATURE_DSSD_POWER_STATE := 199
}
struct NVME_CDW10_ABORT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_IDENTIFY_CNS_CODES extends Int32 {
    static NVME_IDENTIFY_CNS_SPECIFIC_NAMESPACE := 0
    static NVME_IDENTIFY_CNS_CONTROLLER := 1
    static NVME_IDENTIFY_CNS_ACTIVE_NAMESPACES := 2
    static NVME_IDENTIFY_CNS_DESCRIPTOR_NAMESPACE := 3
    static NVME_IDENTIFY_CNS_NVM_SET := 4
    static NVME_IDENTIFY_CNS_SPECIFIC_NAMESPACE_IO_COMMAND_SET := 5
    static NVME_IDENTIFY_CNS_SPECIFIC_CONTROLLER_IO_COMMAND_SET := 6
    static NVME_IDENTIFY_CNS_ACTIVE_NAMESPACE_LIST_IO_COMMAND_SET := 7
    static NVME_IDENTIFY_CNS_ALLOCATED_NAMESPACE_LIST := 16
    static NVME_IDENTIFY_CNS_ALLOCATED_NAMESPACE := 17
    static NVME_IDENTIFY_CNS_CONTROLLER_LIST_OF_NSID := 18
    static NVME_IDENTIFY_CNS_CONTROLLER_LIST_OF_NVM_SUBSYSTEM := 19
    static NVME_IDENTIFY_CNS_PRIMARY_CONTROLLER_CAPABILITIES := 20
    static NVME_IDENTIFY_CNS_SECONDARY_CONTROLLER_LIST := 21
    static NVME_IDENTIFY_CNS_NAMESPACE_GRANULARITY_LIST := 22
    static NVME_IDENTIFY_CNS_UUID_LIST := 23
    static NVME_IDENTIFY_CNS_DOMAIN_LIST := 24
    static NVME_IDENTIFY_CNS_ENDURANCE_GROUP_LIST := 25
    static NVME_IDENTIFY_CNS_ALLOCATED_NAMSPACE_LIST_IO_COMMAND_SET := 26
    static NVME_IDENTIFY_CNS_ALLOCATED_NAMESPACE_IO_COMMAND_SET := 27
    static NVME_IDENTIFY_CNS_IO_COMMAND_SET := 28
}
struct NVME_COMMAND_SET_IDENTIFIERS extends Int32 {
    static NVME_COMMAND_SET_NVM := 0
    static NVME_COMMAND_SET_KEY_VALUE := 1
    static NVME_COMMAND_SET_ZONED_NAMESPACE := 2
}
struct NVME_CDW10_IDENTIFY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_IDENTIFY {
    union {
        Anonymous1 : this._Anonymous1_e__Struct
        Anonymous2 : this._Anonymous2_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous1_e__Struct {
        NVMSETID : UInt16
        Reserved : UInt16
    }
    struct _Anonymous2_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW14_IDENTIFY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_DEALLOCATE_READ_BEHAVIOR extends Int32 {
    static NVME_READ_BEHAVIOR_NOT_REPORTED := 0
    static NVME_READ_BEHAVIOR_RETURN_ZERO := 1
    static NVME_READ_BEHAVIOR_RETURN_ONES := 2
}
struct NVME_LBA_FORMAT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        MS : UInt16
        LBADS : UInt8
        _bitfield : UInt8
    }
}
struct NVM_RESERVATION_CAPABILITIES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUchar : UInt8
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_IDENTIFY_NAMESPACE_DATA {
    NSZE : Int64
    NCAP : Int64
    NUSE : Int64
    NSFEAT : this._NSFEAT_e__Struct
    NLBAF : UInt8
    FLBAS : this._FLBAS_e__Struct
    MC : this._MC_e__Struct
    DPC : this._DPC_e__Struct
    DPS : this._DPS_e__Struct
    NMIC : this._NMIC_e__Struct
    RESCAP : NVM_RESERVATION_CAPABILITIES
    FPI : this._FPI_e__Struct
    DLFEAT : this._DLFEAT_e__Struct
    NAWUN : UInt16
    NAWUPF : UInt16
    NACWU : UInt16
    NABSN : UInt16
    NABO : UInt16
    NABSPF : UInt16
    NOIOB : UInt16
    NVMCAP : UInt8[16]
    NPWG : UInt16
    NPWA : UInt16
    NPDG : UInt16
    NPDA : UInt16
    NOWS : UInt16
    MSSRL : UInt16
    MCL : UInt32
    MSRC : UInt8
    Reserved2 : UInt8[11]
    ANAGRPID : UInt32
    Reserved3 : UInt8[3]
    NSATTR : this._NSATTR_e__Struct
    NVMSETID : UInt16
    ENDGID : UInt16
    NGUID : UInt8[16]
    EUI64 : UInt8[8]
    LBAF : NVME_LBA_FORMAT[64]
    VS : UInt8[3712]
    struct _NSFEAT_e__Struct {
        _bitfield : UInt8
    }
    struct _FLBAS_e__Struct {
        _bitfield : UInt8
    }
    struct _MC_e__Struct {
        _bitfield : UInt8
    }
    struct _DPC_e__Struct {
        _bitfield : UInt8
    }
    struct _DPS_e__Struct {
        _bitfield : UInt8
    }
    struct _NMIC_e__Struct {
        _bitfield : UInt8
    }
    struct _FPI_e__Struct {
        _bitfield : UInt8
    }
    struct _DLFEAT_e__Struct {
        _bitfield : UInt8
    }
    struct _NSATTR_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_DISC_CTRL_TYPE extends Int32 {
    static NvmeDiscCtrlTypeUnspecified := 0
    static NvmeDiscCtrlTypeDDC := 1
    static NvmeDiscCtrlTypeCDC := 2
    static NvmeDiscCtrlTypeReserved1 := 3
    static NvmeDiscCtrlTypeReservedMax := 255
}
struct NVME_POWER_STATE_DESC {
    MP : UInt16
    Reserved0 : UInt8
    _bitfield1 : UInt8
    ENLAT : UInt32
    EXLAT : UInt32
    _bitfield2 : UInt8
    _bitfield3 : UInt8
    _bitfield4 : UInt8
    _bitfield5 : UInt8
    IDLP : UInt16
    _bitfield6 : UInt8
    Reserved7 : UInt8
    ACTP : UInt16
    _bitfield7 : UInt8
    Reserved9 : UInt8[9]
}
struct NVME_IDENTIFY_CONTROLLER_DATA {
    VID : UInt16
    SSVID : UInt16
    SN : UInt8[20]
    MN : UInt8[40]
    FR : UInt8[8]
    RAB : UInt8
    IEEE : UInt8[3]
    CMIC : this._CMIC_e__Struct
    MDTS : UInt8
    CNTLID : UInt16
    VER : UInt32
    RTD3R : UInt32
    RTD3E : UInt32
    OAES : this._OAES_e__Struct
    CTRATT : this._CTRATT_e__Struct
    RRLS : this._RRLS_e__Struct
    Reserved0 : UInt8[9]
    CNTRLTYPE : UInt8
    FGUID : UInt8[16]
    CRDT1 : UInt16
    CRDT2 : UInt16
    CRDT3 : UInt16
    Reserved1 : UInt8[106]
    ReservedForManagement : UInt8[13]
    NVMSR : UInt8
    VWCI : UInt8
    MEC : UInt8
    OACS : this._OACS_e__Struct
    ACL : UInt8
    AERL : UInt8
    FRMW : this._FRMW_e__Struct
    LPA : this._LPA_e__Struct
    ELPE : UInt8
    NPSS : UInt8
    AVSCC : this._AVSCC_e__Struct
    APSTA : this._APSTA_e__Struct
    WCTEMP : UInt16
    CCTEMP : UInt16
    MTFA : UInt16
    HMPRE : UInt32
    HMMIN : UInt32
    TNVMCAP : UInt8[16]
    UNVMCAP : UInt8[16]
    RPMBS : this._RPMBS_e__Struct
    EDSTT : UInt16
    DSTO : UInt8
    FWUG : UInt8
    KAS : UInt16
    HCTMA : this._HCTMA_e__Struct
    MNTMT : UInt16
    MXTMT : UInt16
    SANICAP : this._SANICAP_e__Struct
    HMMINDS : UInt32
    HMMAXD : UInt16
    NSETIDMAX : UInt16
    ENDGIDMAX : UInt16
    ANATT : UInt8
    ANACAP : this._ANACAP_e__Struct
    ANAGRPMAX : UInt32
    NANAGRPID : UInt32
    PELS : UInt32
    DomainId : UInt16
    Reserved2 : UInt8[10]
    MEGCAP : UInt8[16]
    TMPTHHA : UInt8
    Reserved3 : UInt8
    CQT : UInt16
    Reserved4 : UInt8[124]
    SQES : this._SQES_e__Struct
    CQES : this._CQES_e__Struct
    MAXCMD : UInt16
    NN : UInt32
    ONCS : this._ONCS_e__Struct
    FUSES : this._FUSES_e__Struct
    FNA : this._FNA_e__Struct
    VWC : this._VWC_e__Struct
    AWUN : UInt16
    AWUPF : UInt16
    NVSCC : this._NVSCC_e__Struct
    NWPC : this._NWPC_e__Struct
    ACWU : UInt16
    CopyDescFormats : UInt16
    SGLS : this._SGLS_e__Struct
    MNAN : UInt32
    MAXDNA : UInt8[16]
    MAXCNA : UInt32
    Reserved6 : UInt8[204]
    SUBNQN : UInt8[256]
    Reserved7 : UInt8[768]
    IOCCSZ : UInt32
    IORCSZ : UInt32
    ICDOFF : UInt16
    FCATT : this._FCATT_e__Struct
    MSDBD : UInt8
    OFCS : this._OFCS_e__Struct
    DCTYPE : UInt8
    Reserved8 : UInt8[241]
    PDS : NVME_POWER_STATE_DESC[32]
    VS : UInt8[1024]
    struct _CMIC_e__Struct {
        _bitfield : UInt8
    }
    struct _OAES_e__Struct {
        _bitfield : UInt32
    }
    struct _CTRATT_e__Struct {
        _bitfield : UInt32
    }
    struct _RRLS_e__Struct {
        _bitfield : UInt16
    }
    struct _OACS_e__Struct {
        _bitfield : UInt16
    }
    struct _FRMW_e__Struct {
        _bitfield : UInt8
    }
    struct _LPA_e__Struct {
        _bitfield : UInt8
    }
    struct _AVSCC_e__Struct {
        _bitfield : UInt8
    }
    struct _APSTA_e__Struct {
        _bitfield : UInt8
    }
    struct _RPMBS_e__Struct {
        _bitfield : UInt32
    }
    struct _HCTMA_e__Struct {
        _bitfield : UInt16
    }
    struct _SANICAP_e__Struct {
        _bitfield : UInt32
    }
    struct _ANACAP_e__Struct {
        _bitfield : UInt8
    }
    struct _SQES_e__Struct {
        _bitfield : UInt8
    }
    struct _CQES_e__Struct {
        _bitfield : UInt8
    }
    struct _ONCS_e__Struct {
        _bitfield : UInt16
    }
    struct _FUSES_e__Struct {
        _bitfield : UInt16
    }
    struct _FNA_e__Struct {
        _bitfield : UInt8
    }
    struct _VWC_e__Struct {
        _bitfield : UInt8
    }
    struct _NVSCC_e__Struct {
        _bitfield : UInt8
    }
    struct _NWPC_e__Struct {
        _bitfield : UInt8
    }
    struct _SGLS_e__Struct {
        _bitfield : UInt32
    }
    struct _FCATT_e__Struct {
        _bitfield : UInt8
    }
    struct _OFCS_e__Struct {
        _bitfield : UInt16
    }
}
struct NVME_IDENTIFIER_TYPE extends Int32 {
    static NVME_IDENTIFIER_TYPE_EUI64 := 1
    static NVME_IDENTIFIER_TYPE_NGUID := 2
    static NVME_IDENTIFIER_TYPE_UUID := 3
    static NVME_IDENTIFIER_TYPE_CSI := 4
}
struct NVME_IDENTIFIER_TYPE_LENGTH extends Int32 {
    static NVME_IDENTIFIER_TYPE_EUI64_LENGTH := 8
    static NVME_IDENTIFIER_TYPE_NGUID_LENGTH := 16
    static NVME_IDENTIFIER_TYPE_UUID_LENGTH := 16
    static NVME_IDENTIFIER_TYPE_CSI_LENGTH := 1
}
struct NVME_ACTIVE_NAMESPACE_ID_LIST {
    NSID : UInt32[1024]
}
struct NVME_IDENTIFY_NAMESPACE_DESCRIPTOR {
    NIDT : UInt8
    NIDL : UInt8
    Reserved : UInt8[2]
    NID : UInt8[1]
}
struct NVME_SET_ATTRIBUTES_ENTRY {
    Identifier : UInt16
    ENDGID : UInt16
    Reserved1 : UInt32
    Random4KBReadTypical : UInt32
    OptimalWriteSize : UInt32
    TotalCapacity : UInt8[16]
    UnallocatedCapacity : UInt8[16]
    Reserved2 : UInt8[80]
}
struct NVM_SET_LIST {
    IdentifierCount : UInt8
    Reserved : UInt8[127]
    Entry : NVME_SET_ATTRIBUTES_ENTRY[1]
}
struct NVME_LBA_ZONE_FORMAT {
    ZoneSize : Int64
    ZDES : UInt8
    Reserved : UInt8[7]
}
struct NVME_IDENTIFY_SPECIFIC_NAMESPACE_IO_COMMAND_SET {
    ZOC : this._ZOC_e__Struct
    OZCS : this._OZCS_e__Struct
    MAR : UInt32
    MOR : UInt32
    RRL : UInt32
    FRL : UInt32
    Reserved0 : UInt8[2796]
    LBAEF : NVME_LBA_ZONE_FORMAT[16]
    Reserved1 : UInt8[768]
    VS : UInt8[256]
    struct _ZOC_e__Struct {
        _bitfield : UInt16
    }
    struct _OZCS_e__Struct {
        _bitfield : UInt16
    }
}
struct NVME_IDENTIFY_NVM_SPECIFIC_CONTROLLER_IO_COMMAND_SET {
    VSL : UInt8
    WZSL : UInt8
    WUSL : UInt8
    DMRL : UInt8
    DMRSL : UInt32
    DMSL : Int64
    Reserved : UInt8[4080]
}
struct NVME_IDENTIFY_ZNS_SPECIFIC_CONTROLLER_IO_COMMAND_SET {
    ZASL : UInt8
    Reserved : UInt8[4095]
}
struct NVME_CONTROLLER_LIST {
    NumberOfIdentifiers : UInt16
    ControllerID : UInt16[2047]
}
struct NVME_UUID_LIST_ENTRY {
    _bitfield : UInt8
    Reserved1 : UInt8[15]
    UUID : UInt8[16]
}
struct NVME_UUID_LIST {
    UUID : NVME_UUID_LIST_ENTRY[128]
}
struct IO_COMMAND_SET_VECTOR {
    _bitfield : Int64
}
struct NVME_IDENTIFY_IO_COMMAND_SET {
    IOCommandSetVector : IO_COMMAND_SET_VECTOR[512]
}
struct NVME_LBA_RANGE_TYPES extends Int32 {
    static NVME_LBA_RANGE_TYPE_RESERVED := 0
    static NVME_LBA_RANGE_TYPE_FILESYSTEM := 1
    static NVME_LBA_RANGE_TYPE_RAID := 2
    static NVME_LBA_RANGE_TYPE_CACHE := 3
    static NVME_LBA_RANGE_TYPE_PAGE_SWAP_FILE := 4
}
struct NVME_LBA_RANGET_TYPE_ENTRY {
    Type : UInt8
    Attributes : this._Attributes_e__Struct
    Reserved0 : UInt8[14]
    SLBA : Int64
    NLB : Int64
    GUID : UInt8[16]
    Reserved1 : UInt8[16]
    struct _Attributes_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_VENDOR_LOG_PAGES extends Int32 {
    static NVME_LOG_PAGE_OCP_DEVICE_SMART_INFORMATION := 192
    static NVME_LOG_PAGE_OCP_DEVICE_ERROR_RECOVERY := 193
    static NVME_LOG_PAGE_OCP_FIRMWARE_ACTIVATION_HISTORY := 194
    static NVME_LOG_PAGE_OCP_LATENCY_MONITOR := 195
    static NVME_LOG_PAGE_OCP_DEVICE_CAPABILITIES := 196
    static NVME_LOG_PAGE_OCP_UNSUPPORTED_REQUIREMENTS := 197
    static NVME_LOG_PAGE_OCP_TCG_CONFIGURATION := 200
    static NVME_LOG_PAGE_OCP_TCG_HISTORY := 201
}
struct NVME_ASYNC_EVENT_TYPE_VENDOR_SPECIFIC_CODES extends Int32 {
    static NVME_ASYNC_EVENT_TYPE_VENDOR_SPECIFIC_RESERVED := 0
    static NVME_ASYNC_EVENT_TYPE_VENDOR_SPECIFIC_DEVICE_PANIC := 1
}
struct NVME_WCS_DEVICE_RESET_ACTION {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUCHAR : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_WCS_DEVICE_CAPABILITIES {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsULONG : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct NVME_WCS_DEVICE_RECOVERY_ACTION1 extends Int32 {
    static NVMeDeviceRecoveryNoAction := 0
    static NVMeDeviceRecoveryFormatNVM := 1
    static NVMeDeviceRecoveryVendorSpecificCommand := 2
    static NVMeDeviceRecoveryVendorAnalysis := 3
    static NVMeDeviceRecoveryDeviceReplacement := 4
    static NVMeDeviceRecoverySanitize := 5
    static NVMeDeviceRecovery1Max := 15
}
struct NVME_WCS_DEVICE_RECOVERY_ACTION2 extends Int32 {
    static NVMeDeviceRecoveryControllerReset := 0
    static NVMeDeviceRecoverySubsystemReset := 1
    static NVMeDeviceRecoveryPcieFunctionReset := 2
    static NVMeDeviceRecoveryPERST := 3
    static NVMeDeviceRecoveryPowerCycle := 4
    static NVMeDeviceRecoveryPcieHotReset := 5
    static NVMeDeviceRecovery2Max := 15
}
struct NVME_WCS_DEVICE_SMART_ATTRIBUTES_LOG {
    VersionSpecificData : UInt8[494]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct NVME_WCS_DEVICE_SMART_ATTRIBUTES_LOG_V2 {
    MediaUnitsWritten : UInt8[16]
    MediaUnitsRead : UInt8[16]
    BadUserNANDBlockCount : this._BadUserNANDBlockCount_e__Struct
    BadSystemNANDBlockCount : this._BadSystemNANDBlockCount_e__Struct
    XORRecoveryCount : Int64
    UnrecoverableReadErrorCount : Int64
    SoftECCErrorCount : Int64
    EndToEndCorrectionCounts : this._EndToEndCorrectionCounts_e__Struct
    PercentageSystemDataUsed : UInt8
    RefreshCount : UInt8[7]
    UserDataEraseCounts : this._UserDataEraseCounts_e__Struct
    ThermalThrottling : this._ThermalThrottling_e__Struct
    Reserved0 : UInt8[6]
    PCIeCorrectableErrorCount : Int64
    IncompleteShutdownCount : UInt32
    Reserved1 : UInt32
    PercentageFreeBlocks : UInt8
    Reserved2 : UInt8[7]
    CapacitorHealth : UInt16
    Reserved3 : UInt8[6]
    UnalignedIOCount : Int64
    SecurityVersionNumber : Int64
    NUSE : Int64
    PLPStartCount : UInt8[16]
    EnduranceEstimate : UInt8[16]
    Reserved4 : UInt8[302]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
    struct _BadUserNANDBlockCount_e__Struct {
        RawCount : UInt8[6]
        Normalized : UInt8[2]
    }
    struct _BadSystemNANDBlockCount_e__Struct {
        RawCount : UInt8[6]
        Normalized : UInt8[2]
    }
    struct _EndToEndCorrectionCounts_e__Struct {
        DetectedCounts : UInt32
        CorrectedCounts : UInt32
    }
    struct _UserDataEraseCounts_e__Struct {
        MaximumCount : UInt32
        MinimumCount : UInt32
    }
    struct _ThermalThrottling_e__Struct {
        EventCount : UInt8
        Status : UInt8
    }
}
struct NVME_OCP_DEVICE_SMART_INFORMATION_LOG_V3 {
    MediaUnitsWritten : UInt8[16]
    MediaUnitsRead : UInt8[16]
    BadUserNANDBlockCount : this._BadUserNANDBlockCount_e__Struct
    BadSystemNANDBlockCount : this._BadSystemNANDBlockCount_e__Struct
    XORRecoveryCount : Int64
    UnrecoverableReadErrorCount : Int64
    SoftECCErrorCount : Int64
    EndToEndCorrectionCounts : this._EndToEndCorrectionCounts_e__Struct
    PercentageSystemDataUsed : UInt8
    RefreshCount : UInt8[7]
    UserDataEraseCounts : this._UserDataEraseCounts_e__Struct
    ThermalThrottling : this._ThermalThrottling_e__Struct
    DSSDSpecVersion : this._DSSDSpecVersion_e__Struct
    PCIeCorrectableErrorCount : Int64
    IncompleteShutdownCount : UInt32
    Reserved1 : UInt32
    PercentageFreeBlocks : UInt8
    Reserved2 : UInt8[7]
    CapacitorHealth : UInt16
    NvmeErrata : UInt8
    Reserved3 : UInt8[5]
    UnalignedIOCount : Int64
    SecurityVersionNumber : Int64
    NUSE : Int64
    PLPStartCount : UInt8[16]
    EnduranceEstimate : UInt8[16]
    PCIeLinkRetrainingCount : Int64
    PowerStateChangeCount : Int64
    Reserved4 : UInt8[286]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
    struct _BadUserNANDBlockCount_e__Struct {
        RawCount : UInt8[6]
        Normalized : UInt8[2]
    }
    struct _BadSystemNANDBlockCount_e__Struct {
        RawCount : UInt8[6]
        Normalized : UInt8[2]
    }
    struct _EndToEndCorrectionCounts_e__Struct {
        DetectedCounts : UInt32
        CorrectedCounts : UInt32
    }
    struct _UserDataEraseCounts_e__Struct {
        MaximumCount : UInt32
        MinimumCount : UInt32
    }
    struct _ThermalThrottling_e__Struct {
        EventCount : UInt8
        Status : UInt8
    }
    struct _DSSDSpecVersion_e__Struct {
        Errata : UInt8
        PointVersion : UInt16
        MinorVersion : UInt16
        MajorVersion : UInt8
    }
}
struct NVME_WCS_DEVICE_ERROR_RECOVERY_LOG {
    PanicResetWaitTime : UInt16
    PanicResetAction : NVME_WCS_DEVICE_RESET_ACTION
    DriveRecoveryAction : UInt8
    PanicId : Int64
    DeviceCapabilitiesA : NVME_WCS_DEVICE_CAPABILITIES
    VendorSpecificRecoveryCode : UInt8
    Reserved0 : UInt8[3]
    VendorSpecificCommandCDW12 : UInt32
    VendorSpecificCommandCDW13 : UInt32
    Reserved1 : UInt8[466]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct NVME_OCP_DEVICE_ERROR_RECOVERY_LOG_V2 {
    PanicResetWaitTime : UInt16
    PanicResetAction : NVME_WCS_DEVICE_RESET_ACTION
    DeviceRecoveryAction1 : UInt8
    PanicId : Int64
    DeviceCapabilitiesA : NVME_WCS_DEVICE_CAPABILITIES
    VendorSpecificRecoveryCode : UInt8
    Reserved0 : UInt8[3]
    VendorSpecificCommandCDW12 : UInt32
    VendorSpecificCommandCDW13 : UInt32
    VendorSpecificCommandTimeout : UInt8
    DeviceRecoveryAction2 : UInt8
    DeviceRecoveryAction2Timeout : UInt8
    Reserved1 : UInt8[463]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct FIRMWARE_ACTIVATION_HISTORY_ENTRY {
    VersionNumber : UInt8
    Length : UInt8
    Reserved0 : UInt16
    ActivationCount : UInt16
    Timestamp : Int64
    Reserved1 : Int64
    PowerCycleCount : Int64
    PreviousFirmware : Int64
    NewFirmware : Int64
    SlotNumber : UInt8
    CommitActionType : UInt8
    Result : UInt16
    Reserved2 : UInt8[14]
}
struct NVME_OCP_DEVICE_FIRMWARE_ACTIVATION_HISTORY_LOG {
    LID : UInt8
    Reserved0 : UInt8[3]
    ValidNumberOfEntries : UInt32
    Entries : FIRMWARE_ACTIVATION_HISTORY_ENTRY[20]
    Reserved1 : UInt8[2790]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct LATENCY_MONITOR_FEATURE_STATUS {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct ACTIVE_LATENCY_CONFIGURATION {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct BUCKET_COUNTER {
    Reserved : UInt32
    Trim : UInt32
    Write : UInt32
    Read : UInt32
}
struct LATENCY_STAMP {
    Trim3 : Int64
    Write3 : Int64
    Read3 : Int64
    Trim2 : Int64
    Write2 : Int64
    Read2 : Int64
    Trim1 : Int64
    Write1 : Int64
    Read1 : Int64
    Trim0 : Int64
    Write0 : Int64
    Read0 : Int64
}
struct MEASURED_LATENCY {
    Trim3 : UInt16
    Write3 : UInt16
    Read3 : UInt16
    Trim2 : UInt16
    Write2 : UInt16
    Read2 : UInt16
    Trim1 : UInt16
    Write1 : UInt16
    Read1 : UInt16
    Trim0 : UInt16
    Write0 : UInt16
    Read0 : UInt16
}
struct LATENCY_STAMP_UNITS {
    _bitfield : UInt16
}
struct DEBUG_BIT_FIELD {
    _bitfield : UInt16
}
struct NVME_OCP_DEVICE_LATENCY_MONITOR_LOG {
    FeatureStatus : LATENCY_MONITOR_FEATURE_STATUS
    Reserved0 : UInt8
    ActiveBucketTimer : UInt16
    ActiveBucketTimerThreshold : UInt16
    ActiveThresholdA : UInt8
    ActiveThresholdB : UInt8
    ActiveThresholdC : UInt8
    ActiveThresholdD : UInt8
    ActiveLatencyConfig : ACTIVE_LATENCY_CONFIGURATION
    ActiveLatencyMinimumWindow : UInt8
    Reserved1 : UInt8[19]
    ActiveBucketCounter0 : BUCKET_COUNTER
    ActiveBucketCounter1 : BUCKET_COUNTER
    ActiveBucketCounter2 : BUCKET_COUNTER
    ActiveBucketCounter3 : BUCKET_COUNTER
    ActiveLatencyStamp : LATENCY_STAMP
    ActiveMeasuredLatency : MEASURED_LATENCY
    ActiveLatencyStampUnits : LATENCY_STAMP_UNITS
    Reserved2 : UInt8[22]
    StaticBucketCounter0 : BUCKET_COUNTER
    StaticBucketCounter1 : BUCKET_COUNTER
    StaticBucketCounter2 : BUCKET_COUNTER
    StaticBucketCounter3 : BUCKET_COUNTER
    StaticLatencyStamp : LATENCY_STAMP
    StaticMeasuredLatency : MEASURED_LATENCY
    StaticLatencyStampUnits : LATENCY_STAMP_UNITS
    Reserved3 : UInt8[22]
    DebugLogTriggerEnable : DEBUG_BIT_FIELD
    DebugLogMeasuredLatency : UInt16
    DebugLogLatencyStamp : Int64
    DebugLogPointer : UInt16
    DebugCounterTriggerSource : DEBUG_BIT_FIELD
    DebugLogStampUnits : this._DebugLogStampUnits_e__Union
    Reserved4 : UInt8[29]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
    struct _DebugLogStampUnits_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct DSSD_POWER_STATE_DESCRIPTOR {
    _bitfield : UInt8
}
struct NVME_OCP_DEVICE_CAPABILITIES_LOG {
    PciePorts : UInt16
    OobMgmtSupport : this._OobMgmtSupport_e__Union
    WriteZeroesCommand : this._WriteZeroesCommand_e__Union
    SanitizeCommand : this._SanitizeCommand_e__Union
    DatasetMgmtCommand : this._DatasetMgmtCommand_e__Union
    WriteUncorrectableCommand : this._WriteUncorrectableCommand_e__Union
    FusedCommand : this._FusedCommand_e__Union
    MinimumValidDSSDPowerState : UInt16
    Reserved0 : UInt8
    DssdDescriptors : DSSD_POWER_STATE_DESCRIPTOR[127]
    Reserved1 : UInt8[3934]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
    struct _OobMgmtSupport_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _WriteZeroesCommand_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _SanitizeCommand_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _DatasetMgmtCommand_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _WriteUncorrectableCommand_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _FusedCommand_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct UNSUPPORTED_REQUIREMENT {
    ReqId : UInt8[16]
}
struct NVME_OCP_DEVICE_UNSUPPORTED_REQUIREMENTS_LOG {
    UnsupportedCount : UInt16
    Reserved0 : UInt8[14]
    UnsupportedReqList : UNSUPPORTED_REQUIREMENT[253]
    Reserved1 : UInt8[14]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct NVME_OCP_DEVICE_TCG_CONFIGURATION_LOG {
    State : this._State_e__Union
    Reserved0 : UInt8[3]
    LSPActivationCount : UInt8
    TPRevertCount : UInt8
    LSPRevertCount : UInt8
    LOCount : UInt8
    SUMLOCount : UInt8
    RPLOCount : UInt8
    NPLOCount : UInt8
    RLLOCount : UInt8
    WLLOCount : UInt8
    RULOCount : UInt8
    WULOCount : UInt8
    Reserved1 : UInt8
    SIDAuthTryCount : UInt32
    SIDAuthTryLimit : UInt32
    ResetCount : UInt32
    ResetLockCount : UInt32
    Reserved2 : UInt8[462]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
    struct _State_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct TCG_HISTORY_ENTRY {
    VersionNumber : UInt8
    EntryLength : UInt8
    PowerCycleCount : UInt16
    TcgCommandCount : UInt32
    TcgCommandCompletionTS : Int64
    InvokingId : Int64
    MethodId : Int64
    ComId : UInt16
    ProtocolId : UInt8
    TcgStatus : UInt8
    ProcessTime : UInt16
    CommandSpecific : UInt8[10]
}
struct TCG_AUTH_METHOD_SPECIFIC {
    AuthorityId : Int64
    TriesCount : UInt8
}
struct TCG_ACTIVATE_METHOD_SPECIFIC {
    RangeStartLengthPolicy : UInt8
}
struct TCG_REACTIVATE_METHOD_SPECIFIC {
    RangeStartLengthPolicy : UInt8
}
struct TCG_ASSIGN_METHOD_SPECIFIC {
    NamespaceId : UInt32
}
struct TCG_BLOCKSID_METHOD_SPECIFIC {
    ClearEvents : UInt8
}
struct NVME_OCP_DEVICE_TCG_HISTORY_LOG {
    LID : UInt8
    Reserved0 : UInt8[3]
    HistoryEntryCount : UInt32
    HistoryEntries : TCG_HISTORY_ENTRY[84]
    Reserved1 : UInt8[38]
    LogPageVersionNumber : UInt16
    LogPageGUID : GUID
}
struct NVME_CDW10_CREATE_IO_QUEUE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_CREATE_IO_CQ {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_DELETE_IO_QUEUE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_NVM_QUEUE_PRIORITIES extends Int32 {
    static NVME_NVM_QUEUE_PRIORITY_URGENT := 0
    static NVME_NVM_QUEUE_PRIORITY_HIGH := 1
    static NVME_NVM_QUEUE_PRIORITY_MEDIUM := 2
    static NVME_NVM_QUEUE_PRIORITY_LOW := 3
}
struct NVME_CDW11_CREATE_IO_SQ {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_FEATURE_VALUE_CODES extends Int32 {
    static NVME_FEATURE_VALUE_CURRENT := 0
    static NVME_FEATURE_VALUE_DEFAULT := 1
    static NVME_FEATURE_VALUE_SAVED := 2
    static NVME_FEATURE_VALUE_SUPPORTED_CAPABILITIES := 3
}
struct NVME_CDW10_GET_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_SET_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_GET_FEATURE_TIMESTAMP {
    Anonymous : this._Anonymous_e__Struct
    AsUlonglong : Int64
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct NVME_CDW11_FEATURE_NUMBER_OF_QUEUES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_INTERRUPT_COALESCING {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_INTERRUPT_VECTOR_CONFIG {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_WRITE_ATOMICITY_NORMAL {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_NON_OPERATIONAL_POWER_STATE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_LBA_RANGE_TYPE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_ARBITRATION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_VOLATILE_WRITE_CACHE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_SUPPORTED_CAPABILITY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_ASYNC_EVENT_CONFIG {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_POWER_MANAGEMENT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_AUTO_POWER_STATE_TRANSITION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_AUTO_POWER_STATE_TRANSITION_ENTRY {
    _bitfield : UInt32
    Reserved1 : UInt32
}
struct NVME_TEMPERATURE_THRESHOLD_TYPES extends Int32 {
    static NVME_TEMPERATURE_OVER_THRESHOLD := 0
    static NVME_TEMPERATURE_UNDER_THRESHOLD := 1
}
struct NVME_CDW11_FEATURE_TEMPERATURE_THRESHOLD {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_ERROR_RECOVERY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_HOST_MEMORY_BUFFER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW12_FEATURE_HOST_MEMORY_BUFFER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        HSIZE : UInt32
    }
}
struct NVME_CDW13_FEATURE_HOST_MEMORY_BUFFER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW14_FEATURE_HOST_MEMORY_BUFFER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        HMDLUA : UInt32
    }
}
struct NVME_CDW15_FEATURE_HOST_MEMORY_BUFFER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        HMDLEC : UInt32
    }
}
struct NVME_HOST_MEMORY_BUFFER_DESCRIPTOR_ENTRY {
    BADD : Int64
    BSIZE : UInt32
    Reserved : UInt32
}
struct NVME_HOST_BEHAVIOR_SUPPORT_DATA {
    ACRE : UInt8
    ETDAS : UInt8
    LBAFEE : UInt8
    Reserved : UInt8[509]
}
struct NVME_CDW11_FEATURE_IO_COMMAND_SET_PROFILE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_GET_HOST_METADATA {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_HOST_METADATA_ELEMENT_ACTIONS extends Int32 {
    static NVME_HOST_METADATA_ADD_REPLACE_ENTRY := 0
    static NVME_HOST_METADATA_DELETE_ENTRY_MULTIPLE := 1
    static NVME_HOST_METADATA_ADD_ENTRY_MULTIPLE := 2
}
struct NVME_CDW11_FEATURE_SET_HOST_METADATA {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CONTROLLER_METADATA_ELEMENT_TYPES extends Int32 {
    static NVME_CONTROLLER_METADATA_OPERATING_SYSTEM_CONTROLLER_NAME := 1
    static NVME_CONTROLLER_METADATA_OPERATING_SYSTEM_DRIVER_NAME := 2
    static NVME_CONTROLLER_METADATA_OPERATING_SYSTEM_DRIVER_VERSION := 3
    static NVME_CONTROLLER_METADATA_PREBOOT_CONTROLLER_NAME := 4
    static NVME_CONTROLLER_METADATA_PREBOOT_DRIVER_NAME := 5
    static NVME_CONTROLLER_METADATA_PREBOOT_DRIVER_VERSION := 6
    static NVME_CONTROLLER_METADATA_SYSTEM_PROCESSOR_MODEL := 7
    static NVME_CONTROLLER_METADATA_CHIPSET_DRIVER_NAME := 8
    static NVME_CONTROLLER_METADATA_CHIPSET_DRIVER_VERSION := 9
    static NVME_CONTROLLER_METADATA_OPERATING_SYSTEM_NAME_AND_BUILD := 10
    static NVME_CONTROLLER_METADATA_SYSTEM_PRODUCT_NAME := 11
    static NVME_CONTROLLER_METADATA_FIRMWARE_VERSION := 12
    static NVME_CONTROLLER_METADATA_OPERATING_SYSTEM_DRIVER_FILENAME := 13
    static NVME_CONTROLLER_METADATA_DISPLAY_DRIVER_NAME := 14
    static NVME_CONTROLLER_METADATA_DISPLAY_DRIVER_VERSION := 15
    static NVME_CONTROLLER_METADATA_HOST_DETERMINED_FAILURE_RECORD := 16
}
struct NVME_NAMESPACE_METADATA_ELEMENT_TYPES extends Int32 {
    static NVME_NAMESPACE_METADATA_OPERATING_SYSTEM_NAMESPACE_NAME := 1
    static NVME_NAMESPACE_METADATA_PREBOOT_NAMESPACE_NAME := 2
    static NVME_NAMESPACE_METADATA_OPERATING_SYSTEM_NAMESPACE_NAME_QUALIFIER_1 := 3
    static NVME_NAMESPACE_METADATA_OPERATING_SYSTEM_NAMESPACE_NAME_QUALIFIER_2 := 4
}
struct NVME_HOST_METADATA_ELEMENT_DESCRIPTOR {
    _bitfield : UInt32
    EVAL : UInt8[1]
}
struct NVME_FEATURE_HOST_METADATA_DATA {
    NumberOfMetadataElementDescriptors : UInt8
    Reserved0 : UInt8
    MetadataElementDescriptors : UInt8[4094]
}
struct NVME_CDW0_FEATURE_ERROR_INJECTION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_ERROR_INJECTION_ENTRY {
    Flags : this._Flags_e__Union
    Reserved1 : UInt8
    ErrorInjectionType : UInt16
    ErrorInjectionTypeSpecific : UInt8[28]
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_ERROR_INJECTION_TYPES extends Int32 {
    static NVME_ERROR_INJECTION_TYPE_RESERVED0 := 0
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_CPU_CONTROLLER_HANG := 1
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_NAND_HANG := 2
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_PLP_DEFECT := 3
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_LOGICAL_FW_ERROR := 4
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_DRAM_CORRUPTION_CRITICAL := 5
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_DRAM_CORRUPTION_NONCRITICAL := 6
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_NAND_CORRUPTION := 7
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_SRAM_CORRUPTION := 8
    static NVME_ERROR_INJECTION_TYPE_DEVICE_PANIC_HW_MALFUNCTION := 9
    static NVME_ERROR_INJECTION_TYPE_RESERVED1 := 10
    static NVME_ERROR_INJECTION_TYPE_MAX := 65535
}
struct NVME_CDW11_FEATURE_CLEAR_FW_UPDATE_HISTORY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_READONLY_WRITETHROUGH_MODE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW0_FEATURE_READONLY_WRITETHROUGH_MODE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_CLEAR_PCIE_CORRECTABLE_ERROR_COUNTERS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_ENABLE_IEEE1667_SILO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW0_FEATURE_ENABLE_IEEE1667_SILO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_LATENCY_MONITORING_ENTRY {
    ActiveBucketTimerThreshold : UInt16
    ActiveThresholdA : UInt8
    ActiveThresholdB : UInt8
    ActiveThresholdC : UInt8
    ActiveThresholdD : UInt8
    ActiveLatencyConfig : UInt16
    ActiveLatencyMinimumWindow : UInt8
    DebugLogTriggerEnable : UInt16
    DiscardDebugLog : UInt8
    LatencyMonitorFeatureEnable : UInt8
    Reserved0 : UInt8[4083]
}
struct NVME_CDW0_FEATURE_DSSD_POWER_STATE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_FEATURE_HOST_IDENTIFIER {
    _bitfield : UInt32
}
struct NVME_FEATURE_HOST_IDENTIFIER_DATA {
    HOSTID : UInt8[16]
}
struct NVME_CDW11_FEATURE_RESERVATION_PERSISTENCE {
    _bitfield : UInt32
}
struct NVME_CDW11_FEATURE_RESERVATION_NOTIFICATION_MASK {
    _bitfield : UInt32
}
struct NVME_CDW11_FEATURES {
    union {
        NumberOfQueues : NVME_CDW11_FEATURE_NUMBER_OF_QUEUES
        InterruptCoalescing : NVME_CDW11_FEATURE_INTERRUPT_COALESCING
        InterruptVectorConfig : NVME_CDW11_FEATURE_INTERRUPT_VECTOR_CONFIG
        LbaRangeType : NVME_CDW11_FEATURE_LBA_RANGE_TYPE
        Arbitration : NVME_CDW11_FEATURE_ARBITRATION
        VolatileWriteCache : NVME_CDW11_FEATURE_VOLATILE_WRITE_CACHE
        AsyncEventConfig : NVME_CDW11_FEATURE_ASYNC_EVENT_CONFIG
        PowerManagement : NVME_CDW11_FEATURE_POWER_MANAGEMENT
        AutoPowerStateTransition : NVME_CDW11_FEATURE_AUTO_POWER_STATE_TRANSITION
        TemperatureThreshold : NVME_CDW11_FEATURE_TEMPERATURE_THRESHOLD
        ErrorRecovery : NVME_CDW11_FEATURE_ERROR_RECOVERY
        HostMemoryBuffer : NVME_CDW11_FEATURE_HOST_MEMORY_BUFFER
        WriteAtomicityNormal : NVME_CDW11_FEATURE_WRITE_ATOMICITY_NORMAL
        NonOperationalPowerState : NVME_CDW11_FEATURE_NON_OPERATIONAL_POWER_STATE
        IoCommandSetProfile : NVME_CDW11_FEATURE_IO_COMMAND_SET_PROFILE
        ErrorInjection : NVME_CDW0_FEATURE_ERROR_INJECTION
        HostIdentifier : NVME_CDW11_FEATURE_HOST_IDENTIFIER
        ReservationPersistence : NVME_CDW11_FEATURE_RESERVATION_PERSISTENCE
        ReservationNotificationMask : NVME_CDW11_FEATURE_RESERVATION_NOTIFICATION_MASK
        GetHostMetadata : NVME_CDW11_FEATURE_GET_HOST_METADATA
        SetHostMetadata : NVME_CDW11_FEATURE_SET_HOST_METADATA
        AsUlong : UInt32
    }
}
struct NVME_CDW12_FEATURES {
    union {
        HostMemoryBuffer : NVME_CDW12_FEATURE_HOST_MEMORY_BUFFER
        AsUlong : UInt32
    }
}
struct NVME_CDW13_FEATURES {
    union {
        HostMemoryBuffer : NVME_CDW13_FEATURE_HOST_MEMORY_BUFFER
        AsUlong : UInt32
    }
}
struct NVME_CDW14_FEATURES {
    union {
        HostMemoryBuffer : NVME_CDW14_FEATURE_HOST_MEMORY_BUFFER
        AsUlong : UInt32
    }
}
struct NVME_CDW15_FEATURES {
    union {
        HostMemoryBuffer : NVME_CDW15_FEATURE_HOST_MEMORY_BUFFER
        AsUlong : UInt32
    }
}
struct NVME_LOG_PAGES extends Int32 {
    static NVME_LOG_PAGE_SUPPORTED_LOG_PAGES := 0
    static NVME_LOG_PAGE_ERROR_INFO := 1
    static NVME_LOG_PAGE_HEALTH_INFO := 2
    static NVME_LOG_PAGE_FIRMWARE_SLOT_INFO := 3
    static NVME_LOG_PAGE_CHANGED_NAMESPACE_LIST := 4
    static NVME_LOG_PAGE_COMMAND_EFFECTS := 5
    static NVME_LOG_PAGE_DEVICE_SELF_TEST := 6
    static NVME_LOG_PAGE_TELEMETRY_HOST_INITIATED := 7
    static NVME_LOG_PAGE_TELEMETRY_CTLR_INITIATED := 8
    static NVME_LOG_PAGE_ENDURANCE_GROUP_INFORMATION := 9
    static NVME_LOG_PAGE_PREDICTABLE_LATENCY_NVM_SET := 10
    static NVME_LOG_PAGE_PREDICTABLE_LATENCY_EVENT_AGGREGATE := 11
    static NVME_LOG_PAGE_ASYMMETRIC_NAMESPACE_ACCESS := 12
    static NVME_LOG_PAGE_PERSISTENT_EVENT_LOG := 13
    static NVME_LOG_PAGE_LBA_STATUS_INFORMATION := 14
    static NVME_LOG_PAGE_ENDURANCE_GROUP_EVENT_AGGREGATE := 15
    static NVME_LOG_PAGE_MEDIA_UNIT_STATUS := 16
    static NVME_LOG_PAGE_SUPPORTED_CAPACITY_CONFIGURATION_LIST := 17
    static NVME_LOG_PAGE_FEATURE_IDENTIFIERS_SUPPORTED_AND_EFFECTS := 18
    static NVME_LOG_PAGE_NVME_MI_COMMANDS_SUPPORTED_AND_EFFECTS := 19
    static NVME_LOG_PAGE_COMMAND_AND_FEATURE_LOCKDOWN := 20
    static NVME_LOG_PAGE_BOOT_PARTITION := 21
    static NVME_LOG_PAGE_ROTATIONAL_MEDIA_INFORMATION := 22
    static NVME_LOG_PAGE_DISCOVERY := 112
    static NVME_LOG_PAGE_RESERVATION_NOTIFICATION := 128
    static NVME_LOG_PAGE_SANITIZE_STATUS := 129
    static NVME_LOG_PAGE_CHANGED_ZONE_LIST := 191
}
struct NVME_CDW10_GET_LOG_PAGE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_GET_LOG_PAGE_V121 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_GET_LOG_PAGE_V13 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_GET_LOG_PAGE_V20 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_GET_LOG_PAGE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW12_GET_LOG_PAGE {
    union {
        LPOL : UInt32
        AsUlong : UInt32
    }
}
struct NVME_CDW13_GET_LOG_PAGE {
    union {
        LPOU : UInt32
        AsUlong : UInt32
    }
}
struct NVME_CDW14_GET_LOG_PAGE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW14_GET_LOG_PAGE_V20 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_LID_SPECIFIC_PERSISTENT_EVENT_LOG {
    _bitfield : UInt16
}
struct NVME_LID_SUPPORTED_AND_EFFECTS {
    _bitfield : UInt32
}
struct NVME_SUPPORTED_LOG_PAGES_LOG {
    LogPageIdentifierSupported : NVME_LID_SUPPORTED_AND_EFFECTS[256]
}
struct NVME_ERROR_INFO_LOG {
    ErrorCount : Int64
    SQID : UInt16
    CMDID : UInt16
    Status : NVME_COMMAND_STATUS
    ParameterErrorLocation : this._ParameterErrorLocation_e__Struct
    Lba : Int64
    NameSpace : UInt32
    VendorInfoAvailable : UInt8
    TRTYPE : UInt8
    Reserved0 : UInt8[2]
    CommandSpecificInfo : Int64
    TransportTypeSpecificInfo : UInt16
    Reserved1 : UInt8[22]
    struct _ParameterErrorLocation_e__Struct {
        _bitfield : UInt16
    }
}
struct NVME_HEALTH_INFO_LOG {
    CriticalWarning : this._CriticalWarning_e__Union
    Temperature : UInt8[2]
    AvailableSpare : UInt8
    AvailableSpareThreshold : UInt8
    PercentageUsed : UInt8
    Reserved0 : UInt8[26]
    DataUnitRead : UInt8[16]
    DataUnitWritten : UInt8[16]
    HostReadCommands : UInt8[16]
    HostWrittenCommands : UInt8[16]
    ControllerBusyTime : UInt8[16]
    PowerCycle : UInt8[16]
    PowerOnHours : UInt8[16]
    UnsafeShutdowns : UInt8[16]
    MediaErrors : UInt8[16]
    ErrorInfoLogEntryCount : UInt8[16]
    WarningCompositeTemperatureTime : UInt32
    CriticalCompositeTemperatureTime : UInt32
    TemperatureSensor1 : UInt16
    TemperatureSensor2 : UInt16
    TemperatureSensor3 : UInt16
    TemperatureSensor4 : UInt16
    TemperatureSensor5 : UInt16
    TemperatureSensor6 : UInt16
    TemperatureSensor7 : UInt16
    TemperatureSensor8 : UInt16
    Reserved1 : UInt8[296]
    struct _CriticalWarning_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_TELEMETRY_HOST_INITIATED_LOG {
    LogIdentifier : UInt8
    Reserved0 : UInt8[4]
    OrganizationID : UInt8[3]
    Area1LastBlock : UInt16
    Area2LastBlock : UInt16
    Area3LastBlock : UInt16
    Reserved1 : UInt8[2]
    Area4LastBlock : UInt32
    Reserved2 : UInt8[361]
    HostInitiatedDataGenerationNumber : UInt8
    ControllerInitiatedDataAvailable : UInt8
    ControllerInitiatedDataGenerationNumber : UInt8
    ReasonIdentifier : UInt8[128]
}
struct NVME_TELEMETRY_CONTROLLER_INITIATED_LOG {
    LogIdentifier : UInt8
    Reserved0 : UInt8[4]
    OrganizationID : UInt8[3]
    Area1LastBlock : UInt16
    Area2LastBlock : UInt16
    Area3LastBlock : UInt16
    Reserved1 : UInt8[2]
    Area4LastBlock : UInt32
    Reserved2 : UInt8[362]
    ControllerInitiatedDataAvailable : UInt8
    ControllerInitiatedDataGenerationNumber : UInt8
    ReasonIdentifier : UInt8[128]
}
struct NVME_FIRMWARE_SLOT_INFO_LOG {
    AFI : this._AFI_e__Struct
    Reserved0 : UInt8[7]
    FRS : Int64[7]
    Reserved1 : UInt8[448]
    struct _AFI_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_BOOT_PARTITION_LOG {
    LogIdentifier : UInt8
    Reserved0 : UInt8[3]
    BpInfo : NVME_BOOT_PARTITION_INFORMATION
    Reserved1 : UInt8[8]
    BootPartitionData : UInt8[1]
}
struct NVME_CHANGED_NAMESPACE_LIST_LOG {
    NSID : UInt32[1024]
}
struct NVME_CHANGED_ZONE_LIST_LOG {
    ZoneIdentifiersCount : UInt16
    Reserved : UInt8[6]
    ZoneIdentifier : Int64[511]
}
struct NVME_COMMAND_EFFECT_SBUMISSION_EXECUTION_LIMITS extends Int32 {
    static NVME_COMMAND_EFFECT_SBUMISSION_EXECUTION_LIMIT_NONE := 0
    static NVME_COMMAND_EFFECT_SBUMISSION_EXECUTION_LIMIT_SINGLE_PER_NAMESPACE := 1
    static NVME_COMMAND_EFFECT_SBUMISSION_EXECUTION_LIMIT_SINGLE_PER_CONTROLLER := 2
}
struct NVME_COMMAND_EFFECTS_DATA {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_COMMAND_EFFECTS_LOG {
    ACS : NVME_COMMAND_EFFECTS_DATA[256]
    IOCS : NVME_COMMAND_EFFECTS_DATA[256]
    Reserved : UInt8[2048]
}
struct NVME_DEVICE_SELF_TEST_RESULT_DATA {
    Status : this._Status_e__Struct
    SegmentNumber : UInt8
    ValidDiagnostics : this._ValidDiagnostics_e__Struct
    Reserved : UInt8
    POH : Int64
    NSID : UInt32
    FailingLBA : Int64
    StatusCodeType : this._StatusCodeType_e__Struct
    StatusCode : UInt8
    VendorSpecific : UInt16
    struct _Status_e__Struct {
        _bitfield : UInt8
    }
    struct _ValidDiagnostics_e__Struct {
        _bitfield : UInt8
    }
    struct _StatusCodeType_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_DEVICE_SELF_TEST_LOG {
    CurrentOperation : this._CurrentOperation_e__Struct
    CurrentCompletion : this._CurrentCompletion_e__Struct
    Reserved : UInt8[2]
    ResultData : NVME_DEVICE_SELF_TEST_RESULT_DATA[20]
    struct _CurrentOperation_e__Struct {
        _bitfield : UInt8
    }
    struct _CurrentCompletion_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_ENDURANCE_GROUP_LOG {
    Reserved0 : UInt32
    AvailableSpareThreshold : UInt8
    PercentageUsed : UInt8
    Reserved1 : UInt8[26]
    EnduranceEstimate : UInt8[16]
    DataUnitsRead : UInt8[16]
    DataUnitsWritten : UInt8[16]
    MediaUnitsWritten : UInt8[16]
    Reserved2 : UInt8[416]
}
struct NVME_PERSISTENT_EVENT_LOG_HEADER {
    LogIdentifier : UInt8
    Reserved0 : UInt8[3]
    TotalNumberOfEvents : UInt32
    TotalLogLength : Int64
    LogRevision : UInt8
    Reserved1 : UInt8
    LogHeaderLength : UInt16
    Timestamp : Int64
    PowerOnHours : UInt8[16]
    PowerCycleCount : Int64
    PciVendorId : UInt16
    PciSubsystemVendorId : UInt16
    SerialNumber : UInt8[20]
    ModelNumber : UInt8[40]
    NVMSubsystemNVMeQualifiedName : UInt8[256]
    Reserved : UInt8[108]
    SupportedEventsBitmap : UInt8[32]
}
struct NVME_PERSISTENT_EVENT_LOG_EVENT_HEADER {
    EventType : UInt8
    EventTypeRevision : UInt8
    EventHeaderLength : UInt8
    Reserved0 : UInt8
    ControllerIdentifier : UInt16
    EventTimestamp : Int64
    Reserved1 : UInt8[6]
    VendorSpecificInformationLength : UInt16
    EventLength : UInt16
}
struct NVME_PERSISTENT_EVENT_LOG_EVENT_TYPES extends Int32 {
    static NVME_PERSISTENT_EVENT_TYPE_RESERVED0 := 0
    static NVME_PERSISTENT_EVENT_TYPE_SMART_HEALTH_LOG_SNAPSHOT := 1
    static NVME_PERSISTENT_EVENT_TYPE_FIRMWARE_COMMIT := 2
    static NVME_PERSISTENT_EVENT_TYPE_TIMESTAMP_CHANGE := 3
    static NVME_PERSISTENT_EVENT_TYPE_POWER_ON_OR_RESET := 4
    static NVME_PERSISTENT_EVENT_TYPE_NVM_SUBSYSTEM_HARDWARE_ERROR := 5
    static NVME_PERSISTENT_EVENT_TYPE_CHANGE_NAMESPACE := 6
    static NVME_PERSISTENT_EVENT_TYPE_FORMAT_NVM_START := 7
    static NVME_PERSISTENT_EVENT_TYPE_FORMAT_NVM_COMPLETION := 8
    static NVME_PERSISTENT_EVENT_TYPE_SANITIZE_START := 9
    static NVME_PERSISTENT_EVENT_TYPE_SANITIZE_COMPLETION := 10
    static NVME_PERSISTENT_EVENT_TYPE_SET_FEATURE := 11
    static NVME_PERSISTENT_EVENT_TYPE_TELEMETRY_LOG_CREATED := 12
    static NVME_PERSISTENT_EVENT_TYPE_THERMAL_EXCURSION := 13
    static NVME_PERSISTENT_EVENT_TYPE_RESERVED1_BEGIN := 14
    static NVME_PERSISTENT_EVENT_TYPE_RESERVED1_END := 221
    static NVME_PERSISTENT_EVENT_TYPE_VENDOR_SPECIFIC_EVENT := 222
    static NVME_PERSISTENT_EVENT_TYPE_TCG_DEFINED := 223
    static NVME_PERSISTENT_EVENT_TYPE_RESERVED2_BEGIN := 224
    static NVME_PERSISTENT_EVENT_TYPE_RESERVED2_END := 255
    static NVME_PERSISTENT_EVENT_TYPE_MAX := 255
}
struct NVME_FID_SUPPORTED_AND_EFFECTS {
    _bitfield : UInt32
}
struct NVME_FEATURE_IDENTIFIERS_EFFECTS_LOG {
    FeatureIdentifierSupported : NVME_FID_SUPPORTED_AND_EFFECTS[256]
}
struct NVME_NVME_MI_COMMANDS_SUPPORTED_AND_EFFECTS {
    _bitfield : UInt32
}
struct NVME_NVME_MI_COMMANDS_SUPPORTED_AND_EFFECTS_LOG {
    ManagementInterfaceCommandSupported : NVME_NVME_MI_COMMANDS_SUPPORTED_AND_EFFECTS[256]
    Reserved : UInt8[3072]
}
struct NVME_RESERVATION_NOTIFICATION_TYPES extends Int32 {
    static NVME_RESERVATION_NOTIFICATION_TYPE_EMPTY_LOG_PAGE := 0
    static NVME_RESERVATION_NOTIFICATION_TYPE_REGISTRATION_PREEMPTED := 1
    static NVME_RESERVATION_NOTIFICATION_TYPE_REGISTRATION_RELEASED := 2
    static NVME_RESERVATION_NOTIFICATION_TYPE_RESERVATION_PREEPMPTED := 3
}
struct NVME_RESERVATION_NOTIFICATION_LOG {
    LogPageCount : Int64
    LogPageType : UInt8
    AvailableLogPageCount : UInt8
    Reserved0 : UInt8[2]
    NameSpaceId : UInt32
    Reserved1 : UInt8[48]
}
struct NVME_SANITIZE_OPERATION_STATUS extends Int32 {
    static NVME_SANITIZE_OPERATION_NONE := 0
    static NVME_SANITIZE_OPERATION_SUCCEEDED := 1
    static NVME_SANITIZE_OPERATION_IN_PROGRESS := 2
    static NVME_SANITIZE_OPERATION_FAILED := 3
    static NVME_SANITIZE_OPERATION_SUCCEEDED_WITH_FORCED_DEALLOCATION := 4
}
struct NVME_SANITIZE_STATUS {
    _bitfield : UInt16
}
struct NVME_SANITIZE_STATUS_LOG {
    SPROG : UInt16
    SSTAT : NVME_SANITIZE_STATUS
    SCDW10 : UInt32
    EstimatedTimeForOverwrite : UInt32
    EstimatedTimeForBlockErase : UInt32
    EstimatedTimeForCryptoErase : UInt32
    EstimatedTimeForOverwriteWithNoDeallocateMediaModification : UInt32
    EstimatedTimeForBlockEraseWithNoDeallocateMediaModification : UInt32
    EstimatedTimeForCryptoEraseWithNoDeallocateMediaModification : UInt32
    Reserved : UInt8[480]
}
struct NVME_CDW10_FIRMWARE_DOWNLOAD {
    NUMD : UInt32
}
struct NVME_CDW11_FIRMWARE_DOWNLOAD {
    OFST : UInt32
}
struct NVME_FIRMWARE_ACTIVATE_ACTIONS extends Int32 {
    static NVME_FIRMWARE_ACTIVATE_ACTION_DOWNLOAD_TO_SLOT := 0
    static NVME_FIRMWARE_ACTIVATE_ACTION_DOWNLOAD_TO_SLOT_AND_ACTIVATE := 1
    static NVME_FIRMWARE_ACTIVATE_ACTION_ACTIVATE := 2
    static NVME_FIRMWARE_ACTIVATE_ACTION_DOWNLOAD_TO_SLOT_AND_ACTIVATE_IMMEDIATE := 3
    static NVME_FIRMWARE_ACTIVATE_ACTION_REPLACE_BOOT_PARTITION := 6
    static NVME_FIRMWARE_ACTIVATE_ACTION_ACTIVATE_BOOT_PARTITION := 7
}
struct NVME_CDW10_FIRMWARE_ACTIVATE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_PROTECTION_INFORMATION_TYPES extends Int32 {
    static NVME_PROTECTION_INFORMATION_NOT_ENABLED := 0
    static NVME_PROTECTION_INFORMATION_TYPE1 := 1
    static NVME_PROTECTION_INFORMATION_TYPE2 := 2
    static NVME_PROTECTION_INFORMATION_TYPE3 := 3
}
struct NVME_SECURE_ERASE_SETTINGS extends Int32 {
    static NVME_SECURE_ERASE_NONE := 0
    static NVME_SECURE_ERASE_USER_DATA := 1
    static NVME_SECURE_ERASE_CRYPTOGRAPHIC := 2
}
struct NVME_CDW10_FORMAT_NVM {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_NO_DEALLOCATE_MODIFIES_MEDIA_AFTER_SANITIZE extends Int32 {
    static NVME_MEDIA_ADDITIONALLY_MODIFIED_AFTER_SANITIZE_NOT_DEFINED := 0
    static NVME_MEDIA_NOT_ADDITIONALLY_MODIFIED_AFTER_SANITIZE := 1
    static NVME_MEDIA_ADDITIONALLY_MOFIDIED_AFTER_SANITIZE := 2
}
struct NVME_SANITIZE_ACTION extends Int32 {
    static NVME_SANITIZE_ACTION_RESERVED := 0
    static NVME_SANITIZE_ACTION_EXIT_FAILURE_MODE := 1
    static NVME_SANITIZE_ACTION_START_BLOCK_ERASE_SANITIZE := 2
    static NVME_SANITIZE_ACTION_START_OVERWRITE_SANITIZE := 3
    static NVME_SANITIZE_ACTION_START_CRYPTO_ERASE_SANITIZE := 4
}
struct NVME_CDW10_SANITIZE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_SANITIZE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        OVRPAT : UInt32
    }
}
struct NVME_RESERVATION_TYPES extends Int32 {
    static NVME_RESERVATION_TYPE_RESERVED := 0
    static NVME_RESERVATION_TYPE_WRITE_EXCLUSIVE := 1
    static NVME_RESERVATION_TYPE_EXCLUSIVE_ACCESS := 2
    static NVME_RESERVATION_TYPE_WRITE_EXCLUSIVE_REGISTRANTS_ONLY := 3
    static NVME_RESERVATION_TYPE_EXCLUSIVE_ACCESS_REGISTRANTS_ONLY := 4
    static NVME_RESERVATION_TYPE_WRITE_EXCLUSIVE_ALL_REGISTRANTS := 5
    static NVME_RESERVATION_TYPE_EXCLUSIVE_ACCESS_ALL_REGISTRANTS := 6
}
struct NVME_RESERVATION_ACQUIRE_ACTIONS extends Int32 {
    static NVME_RESERVATION_ACQUIRE_ACTION_ACQUIRE := 0
    static NVME_RESERVATION_ACQUIRE_ACTION_PREEMPT := 1
    static NVME_RESERVATION_ACQUIRE_ACTION_PREEMPT_AND_ABORT := 2
}
struct NVME_CDW0_RESERVATION_PERSISTENCE {
    _bitfield : UInt32
}
struct NVME_CDW10_RESERVATION_ACQUIRE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_RESERVATION_ACQUIRE_DATA_STRUCTURE {
    CRKEY : Int64
    PRKEY : Int64
}
struct NVME_RESERVATION_REGISTER_ACTIONS extends Int32 {
    static NVME_RESERVATION_REGISTER_ACTION_REGISTER := 0
    static NVME_RESERVATION_REGISTER_ACTION_UNREGISTER := 1
    static NVME_RESERVATION_REGISTER_ACTION_REPLACE := 2
}
struct NVME_RESERVATION_REGISTER_PTPL_STATE_CHANGES extends Int32 {
    static NVME_RESERVATION_REGISTER_PTPL_STATE_NO_CHANGE := 0
    static NVME_RESERVATION_REGISTER_PTPL_STATE_RESERVED := 1
    static NVME_RESERVATION_REGISTER_PTPL_STATE_SET_TO_0 := 2
    static NVME_RESERVATION_REGISTER_PTPL_STATE_SET_TO_1 := 3
}
struct NVME_CDW10_RESERVATION_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_RESERVATION_REGISTER_DATA_STRUCTURE {
    CRKEY : Int64
    NRKEY : Int64
}
struct NVME_RESERVATION_RELEASE_ACTIONS extends Int32 {
    static NVME_RESERVATION_RELEASE_ACTION_RELEASE := 0
    static NVME_RESERVATION_RELEASE_ACTION_CLEAR := 1
}
struct NVME_CDW10_RESERVATION_RELEASE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_RESERVATION_RELEASE_DATA_STRUCTURE {
    CRKEY : Int64
}
struct NVME_CDW10_RESERVATION_REPORT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        NUMD : UInt32
    }
}
struct NVME_CDW11_RESERVATION_REPORT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_RESERVATION_REPORT_STATUS_HEADER {
    GEN : UInt32
    RTYPE : UInt8
    REGCTL : UInt16
    Reserved : UInt8[2]
    PTPLS : UInt8
    Reserved1 : UInt8[14]
}
struct NVME_REGISTERED_CONTROLLER_DATA {
    CNTLID : UInt16
    RCSTS : this._RCSTS_e__Struct
    Reserved : UInt8[5]
    HOSTID : UInt8[8]
    RKEY : Int64
    struct _RCSTS_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_RESERVATION_REPORT_STATUS_DATA_STRUCTURE {
    Header : NVME_RESERVATION_REPORT_STATUS_HEADER
    RegisteredControllersData : NVME_REGISTERED_CONTROLLER_DATA[1]
}
struct NVME_REGISTERED_CONTROLLER_EXTENDED_DATA {
    CNTLID : UInt16
    RCSTS : this._RCSTS_e__Struct
    Reserved : UInt8[5]
    RKEY : Int64
    HOSTID : UInt8[16]
    Reserved1 : UInt8[32]
    struct _RCSTS_e__Struct {
        _bitfield : UInt8
    }
}
struct NVME_RESERVATION_REPORT_STATUS_EXTENDED_DATA_STRUCTURE {
    Header : NVME_RESERVATION_REPORT_STATUS_HEADER
    Reserved1 : UInt8[40]
    RegisteredControllersExtendedData : NVME_REGISTERED_CONTROLLER_EXTENDED_DATA[1]
}
struct NVME_DIRECTIVE_TYPES extends Int32 {
    static NVME_DIRECTIVE_TYPE_IDENTIFY := 0
    static NVME_DIRECTIVE_TYPE_STREAMS := 1
}
struct NVME_CDW10_DIRECTIVE_RECEIVE {
    NUMD : UInt32
}
struct NVME_CDW11_DIRECTIVE_RECEIVE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_DIRECTIVE_SEND {
    NUMD : UInt32
}
struct NVME_CDW11_DIRECTIVE_SEND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_DIRECTIVE_RECEIVE_IDENTIFY_OPERATIONS extends Int32 {
    static NVME_DIRECTIVE_RECEIVE_IDENTIFY_OPERATION_RETURN_PARAMETERS := 1
}
struct NVME_DIRECTIVE_SEND_IDENTIFY_OPERATIONS extends Int32 {
    static NVME_DIRECTIVE_SEND_IDENTIFY_OPERATION_ENABLE_DIRECTIVE := 1
}
struct NVME_DIRECTIVE_IDENTIFY_RETURN_PARAMETERS_DESCRIPTOR {
    _bitfield : UInt8
    Reserved1 : UInt8[31]
}
struct NVME_DIRECTIVE_IDENTIFY_RETURN_PARAMETERS {
    DirectivesSupported : NVME_DIRECTIVE_IDENTIFY_RETURN_PARAMETERS_DESCRIPTOR
    DirectivesEnabled : NVME_DIRECTIVE_IDENTIFY_RETURN_PARAMETERS_DESCRIPTOR
}
struct NVME_CDW12_DIRECTIVE_SEND_IDENTIFY_ENABLE_DIRECTIVE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_DIRECTIVE_RECEIVE_STREAMS_OPERATIONS extends Int32 {
    static NVME_DIRECTIVE_RECEIVE_STREAMS_OPERATION_RETURN_PARAMETERS := 1
    static NVME_DIRECTIVE_RECEIVE_STREAMS_OPERATION_GET_STATUS := 2
    static NVME_DIRECTIVE_RECEIVE_STREAMS_OPERATION_ALLOCATE_RESOURCES := 3
}
struct NVME_DIRECTIVE_SEND_STREAMS_OPERATIONS extends Int32 {
    static NVME_DIRECTIVE_SEND_STREAMS_OPERATION_RELEASE_IDENTIFIER := 1
    static NVME_DIRECTIVE_SEND_STREAMS_OPERATION_RELEASE_RESOURCES := 2
}
struct NVME_DIRECTIVE_STREAMS_RETURN_PARAMETERS {
    MSL : UInt16
    NSSA : UInt16
    NSSO : UInt16
    Reserved0 : UInt8[10]
    SWS : UInt32
    SGS : UInt16
    NSA : UInt16
    NSO : UInt16
    Reserved1 : UInt8[6]
}
struct NVME_DIRECTIVE_STREAMS_GET_STATUS_DATA {
    OpenStreamCount : UInt16
    StreamIdentifiers : UInt16[65535]
}
struct NVME_CDW12_DIRECTIVE_RECEIVE_STREAMS_ALLOCATE_RESOURCES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_COMPLETION_DW0_DIRECTIVE_RECEIVE_STREAMS_ALLOCATE_RESOURCES {
    Anonymous : this._Anonymous_e__Struct
    AsUlong : UInt32
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW12_DIRECTIVE_SEND {
    union {
        EnableDirective : NVME_CDW12_DIRECTIVE_SEND_IDENTIFY_ENABLE_DIRECTIVE
        AsUlong : UInt32
    }
}
struct NVME_CDW12_DIRECTIVE_RECEIVE {
    union {
        AllocateResources : NVME_CDW12_DIRECTIVE_RECEIVE_STREAMS_ALLOCATE_RESOURCES
        AsUlong : UInt32
    }
}
struct NVME_CDW10_SECURITY_SEND_RECEIVE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_SECURITY_SEND {
    TL : UInt32
}
struct NVME_CDW11_SECURITY_RECEIVE {
    AL : UInt32
}
struct NVME_NVM_COMMANDS extends Int32 {
    static NVME_NVM_COMMAND_FLUSH := 0
    static NVME_NVM_COMMAND_WRITE := 1
    static NVME_NVM_COMMAND_READ := 2
    static NVME_NVM_COMMAND_WRITE_UNCORRECTABLE := 4
    static NVME_NVM_COMMAND_COMPARE := 5
    static NVME_NVM_COMMAND_WRITE_ZEROES := 8
    static NVME_NVM_COMMAND_DATASET_MANAGEMENT := 9
    static NVME_NVM_COMMAND_VERIFY := 12
    static NVME_NVM_COMMAND_RESERVATION_REGISTER := 13
    static NVME_NVM_COMMAND_RESERVATION_REPORT := 14
    static NVME_NVM_COMMAND_RESERVATION_ACQUIRE := 17
    static NVME_NVM_COMMAND_RESERVATION_RELEASE := 21
    static NVME_NVM_COMMAND_COPY := 25
    static NVME_NVM_COMMAND_ZONE_MANAGEMENT_SEND := 121
    static NVME_NVM_COMMAND_ZONE_MANAGEMENT_RECEIVE := 122
    static NVME_NVM_COMMAND_ZONE_APPEND := 125
}
struct NVME_CDW12_READ_WRITE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_ACCESS_FREQUENCIES extends Int32 {
    static NVME_ACCESS_FREQUENCY_NONE := 0
    static NVME_ACCESS_FREQUENCY_TYPICAL := 1
    static NVME_ACCESS_FREQUENCY_INFR_WRITE_INFR_READ := 2
    static NVME_ACCESS_FREQUENCY_INFR_WRITE_FR_READ := 3
    static NVME_ACCESS_FREQUENCY_FR_WRITE_INFR_READ := 4
    static NVME_ACCESS_FREQUENCY_FR_WRITE_FR_READ := 5
    static NVME_ACCESS_FREQUENCY_ONE_TIME_READ := 6
    static NVME_ACCESS_FREQUENCY_SPECULATIVE_READ := 7
    static NVME_ACCESS_FREQUENCY_WILL_BE_OVERWRITTEN := 8
}
struct NVME_ACCESS_LATENCIES extends Int32 {
    static NVME_ACCESS_LATENCY_NONE := 0
    static NVME_ACCESS_LATENCY_IDLE := 1
    static NVME_ACCESS_LATENCY_NORMAL := 2
    static NVME_ACCESS_LATENCY_LOW := 3
}
struct NVME_CDW13_READ_WRITE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        DSM : this._DSM_e__Struct
        Reserved : UInt8
        DSPEC : UInt16
        struct _DSM_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_CDW15_READ_WRITE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CONTEXT_ATTRIBUTES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_LBA_RANGE {
    Attributes : NVME_CONTEXT_ATTRIBUTES
    LogicalBlockCount : UInt32
    StartingLBA : Int64
}
struct NVME_CDW10_DATASET_MANAGEMENT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW11_DATASET_MANAGEMENT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW12_VERIFYCOMMAND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW15_VERIFY_COMMAND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_ZONE_DESCRIPTOR {
    Anonymous1 : this._Anonymous1_e__Struct
    Anonymous2 : this._Anonymous2_e__Struct
    ZA : this._ZA_e__Struct
    Reserved3 : UInt8[5]
    ZCAP : Int64
    ZSLBA : Int64
    WritePointer : Int64
    Reserved4 : UInt8[32]
    struct _Anonymous1_e__Struct {
        _bitfield : UInt8
    }
    struct _Anonymous2_e__Struct {
        _bitfield : UInt8
    }
    struct _ZA_e__Struct {
        _bitfield : UInt8
    }
}
struct ZONE_STATE extends Int32 {
    static NVME_STATE_ZSE := 1
    static NVME_STATE_ZSIO := 2
    static NVME_STATE_ZSEO := 3
    static NVME_STATE_ZSC := 4
    static NVME_STATE_ZSRO := 13
    static NVME_STATE_ZSF := 14
    static NVME_STATE_ZSO := 15
}
struct NVME_ZONE_SEND_ACTION extends Int32 {
    static NVME_ZONE_SEND_CLOSE := 1
    static NVME_ZONE_SEND_FINISH := 2
    static NVME_ZONE_SEND_OPEN := 3
    static NVME_ZONE_SEND_RESET := 4
    static NVME_ZONE_SEND_OFFLINE := 5
    static NVME_ZONE_SEND_SET_ZONE_DESCRIPTOR := 16
}
struct NVME_CDW10_ZONE_MANAGEMENT_SEND {
    SLBA : Int64
}
struct NVME_CDW13_ZONE_MANAGEMENT_SEND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_REPORT_ZONE_INFO {
    ZoneCount : Int64
    Reserved : Int64[7]
    ZoneDescriptor : NVME_ZONE_DESCRIPTOR[1]
}
struct NVME_ZONE_DESCRIPTOR_EXTENSION {
    ZoneDescriptorExtensionInfo : UInt8[64]
}
struct NVME_ZONE_EXTENDED_REPORT_ZONE_DESC {
    ZoneDescriptor : NVME_ZONE_DESCRIPTOR
    ZoneDescriptorExtension : NVME_ZONE_DESCRIPTOR_EXTENSION[1]
}
struct NVME_EXTENDED_REPORT_ZONE_INFO {
    ZoneCount : Int64
    Reserved : Int64[7]
    Desc : NVME_ZONE_EXTENDED_REPORT_ZONE_DESC[1]
}
struct NVME_ZONE_RECEIVE_ACTION extends Int32 {
    static NVME_ZONE_RECEIVE_REPORT_ZONES := 0
    static NVME_ZONE_RECEIVE_EXTENDED_REPORT_ZONES := 1
}
struct NVME_ZONE_RECEIVE_ACTION_SPECIFIC extends Int32 {
    static NVME_ZRA_ALL_ZONES := 0
    static NVME_ZRA_EMPTY_STATE_ZONES := 1
    static NVME_ZRA_IO_STATE_ZONES := 2
    static NVME_ZRA_EO_STATE_ZONES := 3
    static NVME_ZRA_CLOSED_STATE_ZONES := 4
    static NVME_ZRA_FULL_STATE_ZONES := 5
    static NVME_ZRA_RO_STATE_ZONES := 6
    static NVME_ZRA_OFFLINE_STATE_ZONES := 7
}
struct NVME_CDW10_ZONE_MANAGEMENT_RECEIVE {
    SLBA : Int64
}
struct NVME_CDW13_ZONE_MANAGEMENT_RECEIVE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_ZONE_APPEND {
    SLBA : Int64
}
struct NVME_CDW12_ZONE_APPEND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW15_ZONE_APPEND {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_CDW10_DEVICE_SELF_TEST {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_DISCOVERY_INFO_MGMT_TASK extends Int32 {
    static NVME_DISCOVERY_INFO_MGMT_TASK_REGISTER := 0
    static NVME_DISCOVERY_INFO_MGMT_TASK_DEREGISTER := 1
    static NVME_DISCOVERY_INFO_MGMT_TASK_UPDATE := 2
}
struct NVME_CDW10_DISCOVERY_INFO_MGMT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_COMMAND_DWORD0 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct NVME_FUSED_OPERATION_CODES extends Int32 {
    static NVME_FUSED_OPERATION_NORMAL := 0
    static NVME_FUSED_OPERATION_FIRST_CMD := 1
    static NVME_FUSED_OPERATION_SECOND_CMD := 2
}
struct NVME_PRP_ENTRY {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct NVME_COMMAND {
    CDW0 : NVME_COMMAND_DWORD0
    NSID : UInt32
    Reserved0 : UInt32[2]
    MPTR : Int64
    Anonymous : this._Anonymous_e__Union
    u : this._u_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            SGL1 : Int64[2]
        }
        struct _Anonymous_e__Struct {
            PRP1 : Int64
            PRP2 : Int64
        }
    }
    struct _u_e__Union {
        union {
            GENERAL : this._GENERAL_e__Struct
            IDENTIFY : this._IDENTIFY_e__Struct
            ABORT : this._ABORT_e__Struct
            GETFEATURES : this._GETFEATURES_e__Struct
            SETFEATURES : this._SETFEATURES_e__Struct
            GETLOGPAGE : this._GETLOGPAGE_e__Struct
            CREATEIOCQ : this._CREATEIOCQ_e__Struct
            CREATEIOSQ : this._CREATEIOSQ_e__Struct
            DELETEIOQUEUE : this._DELETEIOQUEUE_e__Struct
            DATASETMANAGEMENT : this._DATASETMANAGEMENT_e__Struct
            SECURITYSEND : this._SECURITYSEND_e__Struct
            SECURITYRECEIVE : this._SECURITYRECEIVE_e__Struct
            FIRMWAREDOWNLOAD : this._FIRMWAREDOWNLOAD_e__Struct
            FIRMWAREACTIVATE : this._FIRMWAREACTIVATE_e__Struct
            FORMATNVM : this._FORMATNVM_e__Struct
            DIRECTIVERECEIVE : this._DIRECTIVERECEIVE_e__Struct
            DIRECTIVESEND : this._DIRECTIVESEND_e__Struct
            SANITIZE : this._SANITIZE_e__Struct
            READWRITE : this._READWRITE_e__Struct
            RESERVATIONACQUIRE : this._RESERVATIONACQUIRE_e__Struct
            RESERVATIONREGISTER : this._RESERVATIONREGISTER_e__Struct
            RESERVATIONRELEASE : this._RESERVATIONRELEASE_e__Struct
            RESERVATIONREPORT : this._RESERVATIONREPORT_e__Struct
            ZONEMANAGEMENTSEND : this._ZONEMANAGEMENTSEND_e__Struct
            ZONEMANAGEMENTRECEIVE : this._ZONEMANAGEMENTRECEIVE_e__Struct
            ZONEAPPEND : this._ZONEAPPEND_e__Struct
            DEVICESELFTEST : this._DEVICESELFTEST_e__Struct
            DISCOVERYINFOMGMT : this._DISCOVERYINFOMGMT_e__Struct
            VENDORSPECIFIC : this._VENDORSPECIFIC_e__Struct
            VERIFYCOMMAND : this._VERIFYCOMMAND_e__Struct
        }
        struct _GENERAL_e__Struct {
            CDW10 : UInt32
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _IDENTIFY_e__Struct {
            CDW10 : NVME_CDW10_IDENTIFY
            CDW11 : NVME_CDW11_IDENTIFY
            CDW12 : UInt32
            CDW13 : UInt32
            Anonymous : this._Anonymous_e__Union
            CDW15 : UInt32
            struct _Anonymous_e__Union {
                union {
                    CDW14 : UInt32
                    CDW14_V20 : NVME_CDW14_IDENTIFY
                }
            }
        }
        struct _ABORT_e__Struct {
            CDW10 : NVME_CDW10_ABORT
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _GETFEATURES_e__Struct {
            CDW10 : NVME_CDW10_GET_FEATURES
            CDW11 : NVME_CDW11_FEATURES
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _SETFEATURES_e__Struct {
            CDW10 : NVME_CDW10_SET_FEATURES
            CDW11 : NVME_CDW11_FEATURES
            CDW12 : NVME_CDW12_FEATURES
            CDW13 : NVME_CDW13_FEATURES
            CDW14 : NVME_CDW14_FEATURES
            CDW15 : NVME_CDW15_FEATURES
        }
        struct _GETLOGPAGE_e__Struct {
            Anonymous1 : this._Anonymous1_e__Union
            CDW11 : NVME_CDW11_GET_LOG_PAGE
            CDW12 : NVME_CDW12_GET_LOG_PAGE
            CDW13 : NVME_CDW13_GET_LOG_PAGE
            Anonymous2 : this._Anonymous2_e__Union
            CDW15 : UInt32
            struct _Anonymous1_e__Union {
                union {
                    CDW10 : NVME_CDW10_GET_LOG_PAGE
                    CDW10_V121 : NVME_CDW10_GET_LOG_PAGE_V121
                    CDW10_V13 : NVME_CDW10_GET_LOG_PAGE_V13
                    CDW10_V20 : NVME_CDW10_GET_LOG_PAGE_V20
                }
            }
            struct _Anonymous2_e__Union {
                union {
                    CDW14 : NVME_CDW14_GET_LOG_PAGE
                    CDW14_V20 : NVME_CDW14_GET_LOG_PAGE_V20
                }
            }
        }
        struct _CREATEIOCQ_e__Struct {
            CDW10 : NVME_CDW10_CREATE_IO_QUEUE
            CDW11 : NVME_CDW11_CREATE_IO_CQ
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _CREATEIOSQ_e__Struct {
            CDW10 : NVME_CDW10_CREATE_IO_QUEUE
            CDW11 : NVME_CDW11_CREATE_IO_SQ
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _DELETEIOQUEUE_e__Struct {
            CDW10 : NVME_CDW10_DELETE_IO_QUEUE
        }
        struct _DATASETMANAGEMENT_e__Struct {
            CDW10 : NVME_CDW10_DATASET_MANAGEMENT
            CDW11 : NVME_CDW11_DATASET_MANAGEMENT
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _SECURITYSEND_e__Struct {
            CDW10 : NVME_CDW10_SECURITY_SEND_RECEIVE
            CDW11 : NVME_CDW11_SECURITY_SEND
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _SECURITYRECEIVE_e__Struct {
            CDW10 : NVME_CDW10_SECURITY_SEND_RECEIVE
            CDW11 : NVME_CDW11_SECURITY_RECEIVE
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _FIRMWAREDOWNLOAD_e__Struct {
            CDW10 : NVME_CDW10_FIRMWARE_DOWNLOAD
            CDW11 : NVME_CDW11_FIRMWARE_DOWNLOAD
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _FIRMWAREACTIVATE_e__Struct {
            CDW10 : NVME_CDW10_FIRMWARE_ACTIVATE
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _FORMATNVM_e__Struct {
            CDW10 : NVME_CDW10_FORMAT_NVM
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _DIRECTIVERECEIVE_e__Struct {
            CDW10 : NVME_CDW10_DIRECTIVE_RECEIVE
            CDW11 : NVME_CDW11_DIRECTIVE_RECEIVE
            CDW12 : NVME_CDW12_DIRECTIVE_RECEIVE
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _DIRECTIVESEND_e__Struct {
            CDW10 : NVME_CDW10_DIRECTIVE_SEND
            CDW11 : NVME_CDW11_DIRECTIVE_SEND
            CDW12 : NVME_CDW12_DIRECTIVE_SEND
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _SANITIZE_e__Struct {
            CDW10 : NVME_CDW10_SANITIZE
            CDW11 : NVME_CDW11_SANITIZE
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _READWRITE_e__Struct {
            LBALOW : UInt32
            LBAHIGH : UInt32
            CDW12 : NVME_CDW12_READ_WRITE
            CDW13 : NVME_CDW13_READ_WRITE
            CDW14 : UInt32
            CDW15 : NVME_CDW15_READ_WRITE
        }
        struct _RESERVATIONACQUIRE_e__Struct {
            CDW10 : NVME_CDW10_RESERVATION_ACQUIRE
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _RESERVATIONREGISTER_e__Struct {
            CDW10 : NVME_CDW10_RESERVATION_REGISTER
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _RESERVATIONRELEASE_e__Struct {
            CDW10 : NVME_CDW10_RESERVATION_RELEASE
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _RESERVATIONREPORT_e__Struct {
            CDW10 : NVME_CDW10_RESERVATION_REPORT
            CDW11 : NVME_CDW11_RESERVATION_REPORT
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _ZONEMANAGEMENTSEND_e__Struct {
            CDW1011 : NVME_CDW10_ZONE_MANAGEMENT_SEND
            CDW12 : UInt32
            CDW13 : NVME_CDW13_ZONE_MANAGEMENT_SEND
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _ZONEMANAGEMENTRECEIVE_e__Struct {
            CDW1011 : NVME_CDW10_ZONE_MANAGEMENT_RECEIVE
            DWORDCOUNT : UInt32
            CDW13 : NVME_CDW13_ZONE_MANAGEMENT_RECEIVE
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _ZONEAPPEND_e__Struct {
            CDW1011 : NVME_CDW10_ZONE_APPEND
            CDW12 : NVME_CDW12_ZONE_APPEND
            CDW13 : UInt32
            ILBRT : UInt32
            CDW15 : NVME_CDW15_ZONE_APPEND
        }
        struct _DEVICESELFTEST_e__Struct {
            CDW10 : NVME_CDW10_DEVICE_SELF_TEST
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _DISCOVERYINFOMGMT_e__Struct {
            CDW10 : NVME_CDW10_DISCOVERY_INFO_MGMT
            CDW11 : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _VENDORSPECIFIC_e__Struct {
            NDT : UInt32
            NDM : UInt32
            CDW12 : UInt32
            CDW13 : UInt32
            CDW14 : UInt32
            CDW15 : UInt32
        }
        struct _VERIFYCOMMAND_e__Struct {
            LBALOW : UInt32
            LBAHIGH : UInt32
            CDW12 : NVME_CDW12_VERIFYCOMMAND
            CDW13 : UInt32
            EILBRT : UInt32
            CDW15 : NVME_CDW15_VERIFY_COMMAND
        }
    }
}
struct NVME_SCSI_NAME_STRING {
    PCIVendorID : CHAR[4]
    ModelNumber : CHAR[40]
    NamespaceID : CHAR[4]
    SerialNumber : CHAR[20]
}
struct NVME_SGL_DESC_TYPE extends Int32 {
    static NvmeSglDescTypeDataBlock := 0
    static NvmeSglDescTypeBitBucket := 1
    static NvmeSglDescTypeSegment := 2
    static NvmeSglDescTypeLastSegment := 3
    static NvmeSglDescTypeKeyedDataBlock := 4
    static NvmeSglDescTypeTransportDataBlock := 5
    static NvmeSglDescTypeMax := 15
}
struct NVME_SGL_DESC_SUBTYPE extends Int32 {
    static NvmeSglDescSubtypeAddress := 0
    static NvmeSglDescSubtypeOffset := 1
    static NvmeSglDescSubtypeTransportA := 10
    static NvmeSglDescSubtypeTransportB := 11
    static NvmeSglDescSubtypeTransportC := 12
    static NvmeSglDescSubtypeTransportD := 13
    static NvmeSglDescSubtypeTransportE := 14
    static NvmeSglDescSubtypeTransportF := 15
}
struct NVME_SGL_DESC {
    Reserved0 : UInt8[15]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_SGL_DATABLOCK_DESC {
    Address : Int64
    Length : UInt32
    Reserved0 : UInt8[3]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_SGL_BITBUCKET_DESC {
    Reserved0 : Int64
    Length : UInt32
    Reserved1 : UInt8[3]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_SGL_SEGMENT_DESC {
    Address : Int64
    Length : UInt32
    Reserved0 : UInt8[3]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_SGL_LASTSEG_DESC {
    Address : Int64
    Length : UInt32
    Reserved0 : UInt8[3]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_RDMA_KEYED_SGL_DESC_SUBTYPE extends Int32 {
    static NvmeRdmaKeyedSglDescSubtypeInvalidate := 15
}
struct NVME_SGL_KEYDATABLOCK_DESC {
    Address : Int64
    Length : UInt8[3]
    Key : UInt8[4]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_SGL_TRANSPORTDATA_DESC {
    Reserved0 : Int64
    Length : UInt32
    Reserved1 : UInt8[3]
    Identifier : this._Identifier_e__Union
    struct _Identifier_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_FABRICS_COMMAND_TYPE extends Int32 {
    static NVME_FABRICS_COMMAND_PROPERTY_SET := 0
    static NVME_FABRICS_COMMAND_CONNECT := 1
    static NVME_FABRICS_COMMAND_PROPERTY_GET := 4
    static NVME_FABRICS_COMMAND_AUTH_SEND := 5
    static NVME_FABRICS_COMMAND_AUTH_RECV := 6
    static NVME_FABRICS_COMMAND_DISCONNECT := 8
}
struct NVMEOF_TRANSPORT_TYPE extends Int32 {
    static NvmeofTransportUnknown := 0
    static NvmeofTransportRdma := 1
    static NvmeofTransportFC := 2
    static NvmeofTransportTcp := 3
    static NvmeofTransportLoopback := 254
    static NvmeofTransportMax := 255
}
struct NVMEOF_ADDRESS_FAMILY extends Int32 {
    static NvmeofAddressUnknown := 0
    static NvmeofAddressIPv4 := 1
    static NvmeofAddressIPv6 := 2
    static NvmeofAddressIB := 3
    static NvmeofAddressFC := 4
    static NvmeofAddressLoopback := 254
    static NvmeofAddressMax := 255
}
struct NVMEOF_SUBSYSTEM_TYPE extends Int32 {
    static NvmeofSubsysTypeUnknown := 0
    static NvmeofSubsysTypeDiscReferral := 1
    static NvmeofSubsysTypeIo := 2
    static NvmeofSubsysTypeDiscCurrent := 3
    static NvmeofSubsysTypeMax := 255
}
struct NVMEOF_SECURE_CHANNEL extends Int32 {
    static NvmeofSCUnspecified := 0
    static NvmeofSCRequired := 1
    static NvmeofSCNotRequired := 2
    static NvmeofSCReserved := 3
}
struct NVMEOF_AUTH_SECURE_CHANNEL extends Int32 {
    static NvmeofAuthSCUnspecified := 0
    static NvmeofAuthSCAuthRequired := 1
    static NvmeofAuthSCAuthConcatSCRequired := 2
    static NvmeofAuthSCReserved := 3
}
struct NVMEOF_FABRICS_COMMAND {
    OPC : UInt8
    PSDT : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved : UInt8[35]
    Specific : UInt8[24]
}
struct NVMEOF_FABRICS_RESPONSE {
    Specific : UInt8[8]
    SQHD : UInt16
    Reserved : UInt16
    CID : UInt16
    STS : UInt16
}
struct NVMEOF_CONNECT_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[19]
    SGL1 : NVME_SGL_DESC
    RECFMT : UInt16
    QID : UInt16
    SQSIZE : UInt16
    CATTR : this._CATTR_e__Union
    Reserved2 : UInt8
    KATO : UInt32
    Reserved3 : UInt8[12]
    struct _CATTR_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVMEOF_CONNECT_DATA {
    HOSTID : UInt8[16]
    CNTLID : UInt16
    Reserved0 : UInt8[238]
    SUBNQN : UInt8[256]
    HOSTNQN : UInt8[256]
    Reserved1 : UInt8[256]
}
struct NVMEOF_CONNECT_RESPONSE {
    SCSpecific : this._SCSpecific_e__Union
    Reserved0 : UInt32
    SQHD : UInt16
    Reserved1 : UInt16
    CID : UInt16
    STS : UInt16
    struct _SCSpecific_e__Union {
        union {
            Success : this._Success_e__Struct
            AsUlong : UInt32
        }
        struct _Success_e__Struct {
            CNTLID : UInt16
            AUTHREQ : this._AUTHREQ_e__Union
            struct _AUTHREQ_e__Union {
                union {
                    Anonymous : this._Anonymous_e__Struct
                    AsUshort : UInt16
                }
                struct _Anonymous_e__Struct {
                    _bitfield : UInt16
                }
            }
        }
    }
}
struct NVMEOF_DISCONNECT_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[19]
    SGL1 : NVME_SGL_DATABLOCK_DESC
    RECFMT : UInt16
    Reserved2 : UInt8[22]
}
struct NVMEOF_DISCONNECT_RESPONSE {
    Reserved0 : Int64
    SQHD : UInt16
    Reserved1 : UInt16
    CID : UInt16
    STS : UInt16
}
struct NVMEOF_PROPERTY_GET_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[35]
    ATTRIB : this._ATTRIB_e__Struct
    Reserved2 : UInt8[3]
    OFST : UInt32
    Reserved3 : UInt8[16]
    struct _ATTRIB_e__Struct {
        _bitfield : UInt8
    }
}
struct NVMEOF_PROPERTY_GET_RESPONSE {
    VALUE : this._VALUE_e__Union
    SQHD : UInt16
    Reserved0 : UInt16
    CID : UInt16
    STS : UInt16
    struct _VALUE_e__Union {
        union {
            FourBytes : this._FourBytes_e__Struct
            EightBytes : Int64
        }
        struct _FourBytes_e__Struct {
            Value : UInt32
            Reserved : UInt32
        }
    }
}
struct NVMEOF_PROPERTY_SET_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[35]
    ATTRIB : this._ATTRIB_e__Struct
    Reserved2 : UInt8[3]
    OFST : UInt32
    VALUE : this._VALUE_e__Union
    Reserved3 : UInt8[8]
    struct _ATTRIB_e__Struct {
        _bitfield : UInt8
    }
    struct _VALUE_e__Union {
        union {
            FourBytes : this._FourBytes_e__Struct
            EightBytes : Int64
        }
        struct _FourBytes_e__Struct {
            Value : UInt32
            Reserved : UInt32
        }
    }
}
struct NVMEOF_PROPERTY_SET_RESPONSE {
    Reserved0 : Int64
    SQHD : UInt16
    Reserved1 : UInt16
    CID : UInt16
    STS : UInt16
}
struct NVMEOF_AUTH_RECEIVE_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[19]
    SGL1 : NVME_SGL_DESC
    Reserved2 : UInt8
    SPSP0 : UInt8
    SPSP1 : UInt8
    SECP : UInt8
    AL : UInt32
    Reserved3 : UInt8[16]
}
struct NVMEOF_AUTH_RECEIVE_RESPONSE {
    Reserved0 : Int64
    SQHD : UInt16
    Reserved1 : UInt16
    CID : UInt16
    STS : UInt16
}
struct NVMEOF_AUTH_SEND_COMMAND {
    OPC : UInt8
    Reserved0 : UInt8
    CID : UInt16
    FCTYPE : UInt8
    Reserved1 : UInt8[19]
    SGL1 : NVME_SGL_DESC
    Reserved2 : UInt8
    SPSP0 : UInt8
    SPSP1 : UInt8
    SECP : UInt8
    TL : UInt32
    Reserved3 : UInt8[16]
}
struct NVMEOF_AUTH_SEND_RESPONSE {
    Reserved0 : Int64
    SQHD : UInt16
    Reserved1 : UInt16
    CID : UInt16
    STS : UInt16
}
struct NVME_DISCOVERY_ENTRY {
    TRTYPE : UInt8
    ADRFAM : UInt8
    SUBTYPE : UInt8
    TREQ : this._TREQ_e__Union
    PORTID : UInt16
    CNTLID : UInt16
    ASQSZ : UInt16
    EFLAGS : this._EFLAGS_e__Union
    Reserved0 : UInt8[20]
    TRSVCID : UInt8[32]
    Reserved1 : UInt8[192]
    NQN : UInt8[256]
    TRADDR : UInt8[256]
    TSAS : UInt8[256]
    struct _TREQ_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _EFLAGS_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct NVME_EXTENDED_DISCOVERY_ENTRY {
    TRTYPE : UInt8
    ADRFAM : UInt8
    SUBTYPE : UInt8
    TREQ : this._TREQ_e__Union
    PORTID : UInt16
    CNTLID : UInt16
    ASQSZ : UInt16
    EFLAGS : this._EFLAGS_e__Union
    Reserved0 : UInt8[20]
    TRSVCID : UInt8[32]
    Reserved1 : UInt8[192]
    NQN : UInt8[256]
    TRADDR : UInt8[256]
    TSAS : UInt8[256]
    TEL : UInt32
    NUMEXAT : UInt16
    Reserved2 : UInt16
    struct _TREQ_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _EFLAGS_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct NVME_EXTENDED_ATTR_TYPE extends Int32 {
    static NvmeExtAttrReserved0 := 0
    static NvmeExtAttrHostId := 1
    static NvmeExtAttrAdminLabelAscii := 2
    static NvmeExtAttrAdminLabelUtf8 := 3
    static NvmeExtAttrReservedStart := 4
    static NvmeExtAttrReservedEnd := 65279
    static NvmeExtAttrVendorStart := 65280
    static NvmeExtAttrVendorEnd := 65535
}
struct NVME_EXTENDED_ATTR {
    EXATTYPE : UInt16
    EXATLEN : UInt16
    EXATVAL : UInt8[1]
}
struct NVME_DISCOVERY_HEADER {
    GENCTR : Int64
    NUMREC : Int64
    RECFMT : UInt16
    DLPF : this._DLPF_e__Union
    Reserved0 : UInt8
    TDLPL : UInt32
    Reserved1 : UInt8[1000]
    struct _DLPF_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUchar : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NVME_DISCOVERY_INFO_ENTRY_FORMATS extends Int32 {
    static NVME_DISCOVERY_INFO_ENTRY_FORMAT_RESERVED := 0
    static NVME_DISCOVERY_INFO_ENTRY_FORMAT_BASIC := 1
    static NVME_DISCOVERY_INFO_ENTRY_FORMAT_EXTENDED := 2
}
struct NVME_DISCOVERY_INFO_ENTITY_TYPES extends Int32 {
    static NVME_DISCOVERY_INFO_ENTITY_TYPE_RESERVED := 0
    static NVME_DISCOVERY_INFO_ENTITY_TYPE_HOST := 1
    static NVME_DISCOVERY_INFO_ENTITY_TYPE_DDC := 2
    static NVME_DISCOVERY_INFO_ENTITY_TYPE_CDC := 3
}
struct NVME_DISCOVERY_INFO_MGMT_HEADER {
    TDL : UInt32
    Reserved0 : UInt32
    NUMENT : Int64
    ENTFMT : UInt16
    ETYPE : UInt16
    PORTLCL : UInt8
    Reserved1 : UInt8
    EKTYPE : this._EKTYPE_e__Union
    EID : UInt8[256]
    ENAME : UInt8[256]
    EVER : UInt8[64]
    Reserved2 : UInt8[424]
    struct _EKTYPE_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUshort : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct NVMEOF_AUTH_PROTOCOL extends Int32 {
    static NvmeofAuthProtocolDHCHAP := 233
}
struct NVMEOF_AUTH_TYPE extends Int32 {
    static NvmeofAuthTypeCommonMessages := 0
    static NvmeofAuthTypeDHCHAPMessages := 1
}
struct NVMEOF_AUTH_ID extends Int32 {
    static NvmeofAuthIdNegotiate := 0
    static NvmeofAuthIdChallenge := 1
    static NvmeofAuthIdReply := 2
    static NvmeofAuthIdSuccess1 := 3
    static NvmeofAuthIdSuccess2 := 4
    static NvmeofAuthIdFailure2 := 240
    static NvmeofAuthIdFailure1 := 241
}
struct NVMEOF_SECURE_CHANNEL_PROTOCOL extends Int32 {
    static NvmeofSecureChannelConcatNone := 0
    static NvmeofSecureChannelConcatWithTLS := 1
    static NvmeofSecureChannelNewTLSPSK := 2
    static NvmeofSecureChannelReplaceTLSPSK := 2
}
struct NVMEOF_AUTH_FAIL_REASON_CODE extends Int32 {
    static NvmeofAuthFailureReasonFailed := 1
}
struct NVMEOF_AUTH_FAIL_REASON_EXPLANATION extends Int32 {
    static NvmeofAuthFailed := 1
    static NvmeofAuthProtocolNotUsable := 2
    static NvmeofAuthSecureChannelConcatMismatch := 3
    static NvmeofAuthHashFunctionNotUsable := 4
    static NvmeofAuthDHGroupNotUsable := 5
    static NvmeofAuthIncorrectPayload := 6
    static NvmeofAuthIncorrectProtocolMessage := 7
}
struct NVMEOF_AUTH_NEGOTIATE {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    SC_C : UInt8
    NAPD : UInt8
}
struct NVMEOF_AUTH_FAILURE {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    ReasonCode : UInt8
    ReasonExplanation : UInt8
}
struct NVMEOF_AUTH_DHCHAP_HASH_ID extends Int32 {
    static NvmeofAuthDHCHAPHashReserved := 0
    static NvmeofAuthDHCHAPHashSha256 := 1
    static NvmeofAuthDHCHAPHashSha384 := 2
    static NvmeofAuthDHCHAPHashSha512 := 3
    static NvmeofAuthDHCHAPHashMax := 255
}
struct NVMEOF_AUTH_DHCHAP_GROUP_ID extends Int32 {
    static NvmeofAuthDHCHAPGroupNull := 0
    static NvmeofAuthDHCHAPGroup2048 := 1
    static NvmeofAuthDHCHAPGroup3072 := 2
    static NvmeofAuthDHCHAPGroup4096 := 3
    static NvmeofAuthDHCHAPGroup6144 := 4
    static NvmeofAuthDHCHAPGroup8192 := 5
    static NvmeofAuthDHCHAPGroupMax := 255
}
struct NVMEOF_AUTH_DHCHAP_DESCRIPTOR {
    AuthId : UInt8
    Reserved0 : UInt8
    HALEN : UInt8
    DHLEN : UInt8
    IdList : UInt8[60]
}
struct NVMEOF_AUTH_DHCHAP_CHALLENGE {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    HL : UInt8
    Reserved1 : UInt8
    HashID : UInt8
    DHgID : UInt8
    DHVLEN : UInt16
    SEQNUM : UInt32
}
struct NVMEOF_AUTH_DHCHAP_REPLY {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    HL : UInt8
    Reserved1 : UInt8
    CVALID : UInt8
    Reserved2 : UInt8
    DHVLEN : UInt16
    SEQNUM : UInt32
}
struct NVMEOF_AUTH_DHCHAP_SUCCESS1 {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    HL : UInt8
    Reserved1 : UInt8
    RVALID : UInt8
    Reserved2 : UInt8[7]
}
struct NVMEOF_AUTH_DHCHAP_SUCCESS2 {
    AUTH_TYPE : UInt8
    AUTH_ID : UInt8
    Reserved0 : UInt16
    T_ID : UInt16
    Reserved1 : UInt8[10]
}
