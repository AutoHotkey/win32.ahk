#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, CHAR, PSTR, PWSTR}
#Import "..\System.Ioctl\Types.ahk" {STORAGE_DEVICE_NUMBER}

struct ADAPTER_OBJECT {
    Value : IntPtr
}
struct SCSI_PASS_THROUGH32 {
    Length : UInt16
    ScsiStatus : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    CdbLength : UInt8
    SenseInfoLength : UInt8
    DataIn : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    DataBufferOffset : UInt32
    SenseInfoOffset : UInt32
    Cdb : UInt8[16]
}
struct SCSI_PASS_THROUGH_DIRECT32 {
    Length : UInt16
    ScsiStatus : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    CdbLength : UInt8
    SenseInfoLength : UInt8
    DataIn : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    DataBuffer : Struct.Ptr
    SenseInfoOffset : UInt32
    Cdb : UInt8[16]
}
struct SCSI_PASS_THROUGH32_EX {
    Version : UInt32
    Length : UInt32
    CdbLength : UInt32
    StorAddressLength : UInt32
    ScsiStatus : UInt8
    SenseInfoLength : UInt8
    DataDirection : UInt8
    Reserved : UInt8
    TimeOutValue : UInt32
    StorAddressOffset : UInt32
    SenseInfoOffset : UInt32
    DataOutTransferLength : UInt32
    DataInTransferLength : UInt32
    DataOutBufferOffset : UInt32
    DataInBufferOffset : UInt32
    Cdb : UInt8[1]
}
struct SCSI_PASS_THROUGH_DIRECT32_EX {
    Version : UInt32
    Length : UInt32
    CdbLength : UInt32
    StorAddressLength : UInt32
    ScsiStatus : UInt8
    SenseInfoLength : UInt8
    DataDirection : UInt8
    Reserved : UInt8
    TimeOutValue : UInt32
    StorAddressOffset : UInt32
    SenseInfoOffset : UInt32
    DataOutTransferLength : UInt32
    DataInTransferLength : UInt32
    DataOutBuffer : Struct.Ptr
    DataInBuffer : Struct.Ptr
    Cdb : UInt8[1]
}
struct ATA_PASS_THROUGH_EX32 {
    Length : UInt16
    AtaFlags : UInt16
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    ReservedAsUchar : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    ReservedAsUlong : UInt32
    DataBufferOffset : UInt32
    PreviousTaskFile : UInt8[8]
    CurrentTaskFile : UInt8[8]
}
struct ATA_PASS_THROUGH_DIRECT32 {
    Length : UInt16
    AtaFlags : UInt16
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    ReservedAsUchar : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    ReservedAsUlong : UInt32
    DataBuffer : Struct.Ptr
    PreviousTaskFile : UInt8[8]
    CurrentTaskFile : UInt8[8]
}
struct MPIO_PASS_THROUGH_PATH32 {
    PassThrough : SCSI_PASS_THROUGH32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH_DIRECT32 {
    PassThrough : SCSI_PASS_THROUGH_DIRECT32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH32_EX {
    PassThroughOffset : UInt32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH_DIRECT32_EX {
    PassThroughOffset : UInt32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct SCSI_PASS_THROUGH {
    Length : UInt16
    ScsiStatus : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    CdbLength : UInt8
    SenseInfoLength : UInt8
    DataIn : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    DataBufferOffset : IntPtr
    SenseInfoOffset : UInt32
    Cdb : UInt8[16]
}
struct SCSI_PASS_THROUGH_DIRECT {
    Length : UInt16
    ScsiStatus : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    CdbLength : UInt8
    SenseInfoLength : UInt8
    DataIn : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    DataBuffer : Struct.Ptr
    SenseInfoOffset : UInt32
    Cdb : UInt8[16]
}
struct SCSI_PASS_THROUGH_EX {
    Version : UInt32
    Length : UInt32
    CdbLength : UInt32
    StorAddressLength : UInt32
    ScsiStatus : UInt8
    SenseInfoLength : UInt8
    DataDirection : UInt8
    Reserved : UInt8
    TimeOutValue : UInt32
    StorAddressOffset : UInt32
    SenseInfoOffset : UInt32
    DataOutTransferLength : UInt32
    DataInTransferLength : UInt32
    DataOutBufferOffset : IntPtr
    DataInBufferOffset : IntPtr
    Cdb : UInt8[1]
}
struct SCSI_PASS_THROUGH_DIRECT_EX {
    Version : UInt32
    Length : UInt32
    CdbLength : UInt32
    StorAddressLength : UInt32
    ScsiStatus : UInt8
    SenseInfoLength : UInt8
    DataDirection : UInt8
    Reserved : UInt8
    TimeOutValue : UInt32
    StorAddressOffset : UInt32
    SenseInfoOffset : UInt32
    DataOutTransferLength : UInt32
    DataInTransferLength : UInt32
    DataOutBuffer : Struct.Ptr
    DataInBuffer : Struct.Ptr
    Cdb : UInt8[1]
}
struct ATA_PASS_THROUGH_EX {
    Length : UInt16
    AtaFlags : UInt16
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    ReservedAsUchar : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    ReservedAsUlong : UInt32
    DataBufferOffset : IntPtr
    PreviousTaskFile : UInt8[8]
    CurrentTaskFile : UInt8[8]
}
struct ATA_PASS_THROUGH_DIRECT {
    Length : UInt16
    AtaFlags : UInt16
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    ReservedAsUchar : UInt8
    DataTransferLength : UInt32
    TimeOutValue : UInt32
    ReservedAsUlong : UInt32
    DataBuffer : Struct.Ptr
    PreviousTaskFile : UInt8[8]
    CurrentTaskFile : UInt8[8]
}
struct IDE_IO_CONTROL {
    HeaderLength : UInt32
    Signature : UInt8[8]
    Timeout : UInt32
    ControlCode : UInt32
    ReturnStatus : UInt32
    DataLength : UInt32
}
struct MPIO_PASS_THROUGH_PATH {
    PassThrough : SCSI_PASS_THROUGH
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH_DIRECT {
    PassThrough : SCSI_PASS_THROUGH_DIRECT
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH_EX {
    PassThroughOffset : UInt32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct MPIO_PASS_THROUGH_PATH_DIRECT_EX {
    PassThroughOffset : UInt32
    Version : UInt32
    Length : UInt16
    Flags : UInt8
    PortNumber : UInt8
    MpioPathId : Int64
}
struct SCSI_BUS_DATA {
    NumberOfLogicalUnits : UInt8
    InitiatorBusId : UInt8
    InquiryDataOffset : UInt32
}
struct SCSI_ADAPTER_BUS_INFO {
    NumberOfBuses : UInt8
    BusData : SCSI_BUS_DATA[1]
}
struct SCSI_INQUIRY_DATA {
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
    DeviceClaimed : BOOLEAN
    InquiryDataLength : UInt32
    NextInquiryDataOffset : UInt32
    InquiryData : UInt8[1]
}
struct SRB_IO_CONTROL {
    HeaderLength : UInt32
    Signature : UInt8[8]
    Timeout : UInt32
    ControlCode : UInt32
    ReturnCode : UInt32
    Length : UInt32
}
struct NVCACHE_REQUEST_BLOCK {
    NRBSize : UInt32
    Function : UInt16
    NRBFlags : UInt32
    NRBStatus : UInt32
    Count : UInt32
    LBA : Int64
    DataBufSize : UInt32
    NVCacheStatus : UInt32
    NVCacheSubStatus : UInt32
}
struct NV_FEATURE_PARAMETER {
    NVPowerModeEnabled : UInt16
    NVParameterReserv1 : UInt16
    NVCmdEnabled : UInt16
    NVParameterReserv2 : UInt16
    NVPowerModeVer : UInt16
    NVCmdVer : UInt16
    NVSize : UInt32
    NVReadSpeed : UInt16
    NVWrtSpeed : UInt16
    DeviceSpinUpTime : UInt32
}
struct NVCACHE_HINT_PAYLOAD {
    Command : UInt8
    Feature7_0 : UInt8
    Feature15_8 : UInt8
    Count15_8 : UInt8
    LBA7_0 : UInt8
    LBA15_8 : UInt8
    LBA23_16 : UInt8
    LBA31_24 : UInt8
    LBA39_32 : UInt8
    LBA47_40 : UInt8
    Auxiliary7_0 : UInt8
    Auxiliary23_16 : UInt8
    Reserved : UInt8[4]
}
struct NV_SEP_CACHE_PARAMETER {
    Version : UInt32
    Size : UInt32
    Flags : this._Flags_e__Union
    WriteCacheType : UInt8
    WriteCacheTypeEffective : UInt8
    ParameterReserve1 : UInt8[3]
    struct _Flags_e__Union {
        union {
            CacheFlags : this._CacheFlags_e__Struct
            CacheFlagsSet : UInt8
        }
        struct _CacheFlags_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct NV_SEP_WRITE_CACHE_TYPE extends Int32 {
    static NVSEPWriteCacheTypeUnknown := 0
    static NVSEPWriteCacheTypeNone := 1
    static NVSEPWriteCacheTypeWriteBack := 2
    static NVSEPWriteCacheTypeWriteThrough := 3
}
struct MP_STORAGE_DIAGNOSTIC_LEVEL extends Int32 {
    static MpStorageDiagnosticLevelDefault := 0
    static MpStorageDiagnosticLevelMax := 1
}
struct MP_STORAGE_DIAGNOSTIC_TARGET_TYPE extends Int32 {
    static MpStorageDiagnosticTargetTypeUndefined := 0
    static MpStorageDiagnosticTargetTypeMiniport := 2
    static MpStorageDiagnosticTargetTypeHbaFirmware := 3
    static MpStorageDiagnosticTargetTypeMax := 4
}
struct STORAGE_DIAGNOSTIC_MP_REQUEST {
    Version : UInt32
    Size : UInt32
    TargetType : MP_STORAGE_DIAGNOSTIC_TARGET_TYPE
    Level : MP_STORAGE_DIAGNOSTIC_LEVEL
    ProviderId : GUID
    BufferSize : UInt32
    Reserved : UInt32
    DataBuffer : UInt8[1]
}
struct MP_DEVICE_DATA_SET_RANGE {
    StartingOffset : Int64
    LengthInBytes : Int64
}
struct DSM_NOTIFICATION_REQUEST_BLOCK {
    Size : UInt32
    Version : UInt32
    NotifyFlags : UInt32
    DataSetProfile : UInt32
    Reserved : UInt32[3]
    DataSetRangesCount : UInt32
    DataSetRanges : MP_DEVICE_DATA_SET_RANGE[1]
}
struct HYBRID_REQUEST_BLOCK {
    Version : UInt32
    Size : UInt32
    Function : UInt32
    Flags : UInt32
    DataBufferOffset : UInt32
    DataBufferLength : UInt32
}
struct NVCACHE_TYPE extends Int32 {
    static NvCacheTypeUnknown := 0
    static NvCacheTypeNone := 1
    static NvCacheTypeWriteBack := 2
    static NvCacheTypeWriteThrough := 3
}
struct NVCACHE_STATUS extends Int32 {
    static NvCacheStatusUnknown := 0
    static NvCacheStatusDisabling := 1
    static NvCacheStatusDisabled := 2
    static NvCacheStatusEnabled := 3
}
struct NVCACHE_PRIORITY_LEVEL_DESCRIPTOR {
    PriorityLevel : UInt8
    Reserved0 : UInt8[3]
    ConsumedNVMSizeFraction : UInt32
    ConsumedMappingResourcesFraction : UInt32
    ConsumedNVMSizeForDirtyDataFraction : UInt32
    ConsumedMappingResourcesForDirtyDataFraction : UInt32
    Reserved1 : UInt32
}
struct HYBRID_INFORMATION {
    Version : UInt32
    Size : UInt32
    HybridSupported : BOOLEAN
    Status : NVCACHE_STATUS
    CacheTypeEffective : NVCACHE_TYPE
    CacheTypeDefault : NVCACHE_TYPE
    FractionBase : UInt32
    CacheSize : Int64
    Attributes : this._Attributes_e__Struct
    Priorities : this._Priorities_e__Struct
    struct _Attributes_e__Struct {
        _bitfield : UInt32
    }
    struct _Priorities_e__Struct {
        PriorityLevelCount : UInt8
        MaxPriorityBehavior : BOOLEAN
        OptimalWriteGranularity : UInt8
        Reserved : UInt8
        DirtyThresholdLow : UInt32
        DirtyThresholdHigh : UInt32
        SupportedCommands : this._SupportedCommands_e__Struct
        Priority : NVCACHE_PRIORITY_LEVEL_DESCRIPTOR[1]
        struct _SupportedCommands_e__Struct {
            _bitfield : UInt32
            MaxEvictCommands : UInt32
            MaxLbaRangeCountForEvict : UInt32
            MaxLbaRangeCountForChangeLba : UInt32
        }
    }
}
struct HYBRID_DIRTY_THRESHOLDS {
    Version : UInt32
    Size : UInt32
    DirtyLowThreshold : UInt32
    DirtyHighThreshold : UInt32
}
struct HYBRID_DEMOTE_BY_SIZE {
    Version : UInt32
    Size : UInt32
    SourcePriority : UInt8
    TargetPriority : UInt8
    Reserved0 : UInt16
    Reserved1 : UInt32
    LbaCount : Int64
}
struct FIRMWARE_REQUEST_BLOCK {
    Version : UInt32
    Size : UInt32
    Function : UInt32
    Flags : UInt32
    DataBufferOffset : UInt32
    DataBufferLength : UInt32
}
struct STORAGE_FIRMWARE_SLOT_INFO {
    SlotNumber : UInt8
    ReadOnly : BOOLEAN
    Reserved : UInt8[6]
    Revision : this._Revision_e__Union
    struct _Revision_e__Union {
        union {
            Info : UInt8[8]
            AsUlonglong : Int64
        }
    }
}
struct STORAGE_FIRMWARE_SLOT_INFO_V2 {
    SlotNumber : UInt8
    ReadOnly : BOOLEAN
    Reserved : UInt8[6]
    Revision : UInt8[16]
}
struct STORAGE_FIRMWARE_INFO {
    Version : UInt32
    Size : UInt32
    UpgradeSupport : BOOLEAN
    SlotCount : UInt8
    ActiveSlot : UInt8
    PendingActivateSlot : UInt8
    Reserved : UInt32
    Slot : STORAGE_FIRMWARE_SLOT_INFO[1]
}
struct STORAGE_FIRMWARE_INFO_V2 {
    Version : UInt32
    Size : UInt32
    UpgradeSupport : BOOLEAN
    SlotCount : UInt8
    ActiveSlot : UInt8
    PendingActivateSlot : UInt8
    FirmwareShared : BOOLEAN
    Reserved : UInt8[3]
    ImagePayloadAlignment : UInt32
    ImagePayloadMaxSize : UInt32
    Slot : STORAGE_FIRMWARE_SLOT_INFO_V2[1]
}
struct STORAGE_FIRMWARE_DOWNLOAD {
    Version : UInt32
    Size : UInt32
    Offset : Int64
    BufferSize : Int64
    ImageBuffer : UInt8[1]
}
struct STORAGE_FIRMWARE_DOWNLOAD_V2 {
    Version : UInt32
    Size : UInt32
    Offset : Int64
    BufferSize : Int64
    Slot : UInt8
    Reserved : UInt8[3]
    ImageSize : UInt32
    ImageBuffer : UInt8[1]
}
struct STORAGE_FIRMWARE_ACTIVATE {
    Version : UInt32
    Size : UInt32
    SlotToActivate : UInt8
    Reserved0 : UInt8[3]
}
struct STORAGE_BOOT_PARTITION_INFO {
    Version : UInt32
    Size : UInt32
    BPSZ : Int64
    ImagePayloadAlignment : UInt32
    ImagePayloadMaxSize : UInt32
    SlotCount : UInt8
    ABPID : UInt8
}
struct STORAGE_BOOT_PARTITION_DOWNLOAD {
    Version : UInt32
    Size : UInt32
    BPID : UInt8
    Offset : Int64
    BufferSize : Int64
    ImageBuffer : UInt8[1]
}
struct STORAGE_BOOT_PARTITION_ACTIVATE {
    Version : UInt32
    Size : UInt32
    BPID : UInt8
    Reserved0 : UInt8[3]
}
struct BOOT_PARTITION_REQUEST_BLOCK {
    Version : UInt32
    Size : UInt32
    Function : UInt32
    Flags : UInt32
    DataBufferOffset : UInt32
    DataBufferLength : UInt32
}
struct IO_SCSI_CAPABILITIES {
    Length : UInt32
    MaximumTransferLength : UInt32
    MaximumPhysicalPages : UInt32
    SupportedAsynchronousEvents : UInt32
    AlignmentMask : UInt32
    TaggedQueuing : BOOLEAN
    AdapterScansDown : BOOLEAN
    AdapterUsesPio : BOOLEAN
}
struct SCSI_ADDRESS {
    Length : UInt32
    PortNumber : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
}
struct PDUMP_DEVICE_POWERON_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, Int32]
}
struct DUMP_POINTERS_VERSION {
    Version : UInt32
    Size : UInt32
}
struct DUMP_POINTERS {
    AdapterObject : ADAPTER_OBJECT.Ptr
    MappedRegisterBase : Struct.Ptr
    DumpData : Struct.Ptr
    CommonBufferVa : Struct.Ptr
    CommonBufferPa : Int64
    CommonBufferSize : UInt32
    AllocateCommonBuffers : BOOLEAN
    UseDiskDump : BOOLEAN
    Spare1 : UInt8[2]
    DeviceObject : Struct.Ptr
}
struct DUMP_POINTERS_EX {
    Header : DUMP_POINTERS_VERSION
    DumpData : Struct.Ptr
    CommonBufferVa : Struct.Ptr
    CommonBufferSize : UInt32
    AllocateCommonBuffers : BOOLEAN
    DeviceObject : Struct.Ptr
    DriverList : Struct.Ptr
    dwPortFlags : UInt32
    MaxDeviceDumpSectionSize : UInt32
    MaxDeviceDumpLevel : UInt32
    MaxTransferSize : UInt32
    AdapterObject : Struct.Ptr
    MappedRegisterBase : Struct.Ptr
    DeviceReady : BOOLEAN.Ptr
    DumpDevicePowerOn : PDUMP_DEVICE_POWERON_ROUTINE
    DumpDevicePowerOnContext : Struct.Ptr
}
struct DUMP_DRIVER {
    DumpDriverList : Struct.Ptr
    DriverName : UInt16[15]
    BaseName : UInt16[15]
}
struct NTSCSI_UNICODE_STRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : PWSTR
}
struct DUMP_DRIVER_EX {
    DumpDriverList : Struct.Ptr
    DriverName : UInt16[15]
    BaseName : UInt16[15]
    DriverFullPath : NTSCSI_UNICODE_STRING
}
struct STORAGE_ENDURANCE_INFO {
    ValidFields : UInt32
    GroupId : UInt32
    Flags : this._Flags_e__Struct
    LifePercentage : UInt32
    BytesReadCount : UInt8[16]
    ByteWriteCount : UInt8[16]
    struct _Flags_e__Struct {
        _bitfield : UInt32
    }
}
struct STORAGE_ENDURANCE_DATA_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    EnduranceInfo : STORAGE_ENDURANCE_INFO
}
struct ISCSI_DIGEST_TYPES extends Int32 {
    static ISCSI_DIGEST_TYPE_NONE := 0
    static ISCSI_DIGEST_TYPE_CRC32C := 1
}
struct ISCSI_AUTH_TYPES extends Int32 {
    static ISCSI_NO_AUTH_TYPE := 0
    static ISCSI_CHAP_AUTH_TYPE := 1
    static ISCSI_MUTUAL_CHAP_AUTH_TYPE := 2
}
struct ISCSI_LOGIN_OPTIONS {
    Version : UInt32
    InformationSpecified : UInt32
    LoginFlags : UInt32
    AuthType : ISCSI_AUTH_TYPES
    HeaderDigest : ISCSI_DIGEST_TYPES
    DataDigest : ISCSI_DIGEST_TYPES
    MaximumConnections : UInt32
    DefaultTime2Wait : UInt32
    DefaultTime2Retain : UInt32
    UsernameLength : UInt32
    PasswordLength : UInt32
    Username : UInt8.Ptr
    Password : UInt8.Ptr
}
struct IKE_AUTHENTICATION_METHOD extends Int32 {
    static IKE_AUTHENTICATION_PRESHARED_KEY_METHOD := 1
}
struct IKE_AUTHENTICATION_PRESHARED_KEY {
    SecurityFlags : Int64
    IdType : UInt8
    IdLengthInBytes : UInt32
    Id : UInt8.Ptr
    KeyLengthInBytes : UInt32
    Key : UInt8.Ptr
}
struct IKE_AUTHENTICATION_INFORMATION {
    AuthMethod : IKE_AUTHENTICATION_METHOD
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            PsKey : IKE_AUTHENTICATION_PRESHARED_KEY
        }
    }
}
struct ISCSI_UNIQUE_SESSION_ID {
    AdapterUnique : Int64
    AdapterSpecific : Int64
}
struct SCSI_LUN_LIST {
    OSLUN : UInt32
    TargetLUN : Int64
}
struct ISCSI_TARGET_MAPPINGW {
    InitiatorName : UInt16[256]
    TargetName : UInt16[224]
    OSDeviceName : UInt16[260]
    SessionId : ISCSI_UNIQUE_SESSION_ID
    OSBusNumber : UInt32
    OSTargetNumber : UInt32
    LUNCount : UInt32
    LUNList : SCSI_LUN_LIST.Ptr
}
struct ISCSI_TARGET_MAPPINGA {
    InitiatorName : CHAR[256]
    TargetName : CHAR[224]
    OSDeviceName : CHAR[260]
    SessionId : ISCSI_UNIQUE_SESSION_ID
    OSBusNumber : UInt32
    OSTargetNumber : UInt32
    LUNCount : UInt32
    LUNList : SCSI_LUN_LIST.Ptr
}
struct ISCSI_TARGET_PORTALW {
    SymbolicName : UInt16[256]
    Address : UInt16[256]
    Socket : UInt16
}
struct ISCSI_TARGET_PORTALA {
    SymbolicName : CHAR[256]
    Address : CHAR[256]
    Socket : UInt16
}
struct ISCSI_TARGET_PORTAL_INFOW {
    InitiatorName : UInt16[256]
    InitiatorPortNumber : UInt32
    SymbolicName : UInt16[256]
    Address : UInt16[256]
    Socket : UInt16
}
struct ISCSI_TARGET_PORTAL_INFOA {
    InitiatorName : CHAR[256]
    InitiatorPortNumber : UInt32
    SymbolicName : CHAR[256]
    Address : CHAR[256]
    Socket : UInt16
}
struct ISCSI_TARGET_PORTAL_INFO_EXW {
    InitiatorName : UInt16[256]
    InitiatorPortNumber : UInt32
    SymbolicName : UInt16[256]
    Address : UInt16[256]
    Socket : UInt16
    SecurityFlags : Int64
    LoginOptions : ISCSI_LOGIN_OPTIONS
}
struct ISCSI_TARGET_PORTAL_INFO_EXA {
    InitiatorName : CHAR[256]
    InitiatorPortNumber : UInt32
    SymbolicName : CHAR[256]
    Address : CHAR[256]
    Socket : UInt16
    SecurityFlags : Int64
    LoginOptions : ISCSI_LOGIN_OPTIONS
}
struct ISCSI_TARGET_PORTAL_GROUPW {
    Count : UInt32
    Portals : ISCSI_TARGET_PORTALW[1]
}
struct ISCSI_TARGET_PORTAL_GROUPA {
    Count : UInt32
    Portals : ISCSI_TARGET_PORTALA[1]
}
struct ISCSI_CONNECTION_INFOW {
    ConnectionId : ISCSI_UNIQUE_SESSION_ID
    InitiatorAddress : PWSTR
    TargetAddress : PWSTR
    InitiatorSocket : UInt16
    TargetSocket : UInt16
    CID : UInt8[2]
}
struct ISCSI_SESSION_INFOW {
    SessionId : ISCSI_UNIQUE_SESSION_ID
    InitiatorName : PWSTR
    TargetNodeName : PWSTR
    TargetName : PWSTR
    ISID : UInt8[6]
    TSID : UInt8[2]
    ConnectionCount : UInt32
    Connections : ISCSI_CONNECTION_INFOW.Ptr
}
struct ISCSI_CONNECTION_INFOA {
    ConnectionId : ISCSI_UNIQUE_SESSION_ID
    InitiatorAddress : PSTR
    TargetAddress : PSTR
    InitiatorSocket : UInt16
    TargetSocket : UInt16
    CID : UInt8[2]
}
struct ISCSI_SESSION_INFOA {
    SessionId : ISCSI_UNIQUE_SESSION_ID
    InitiatorName : PSTR
    TargetNodeName : PSTR
    TargetName : PSTR
    ISID : UInt8[6]
    TSID : UInt8[2]
    ConnectionCount : UInt32
    Connections : ISCSI_CONNECTION_INFOA.Ptr
}
struct ISCSI_CONNECTION_INFO_EX {
    ConnectionId : ISCSI_UNIQUE_SESSION_ID
    State : UInt8
    Protocol : UInt8
    HeaderDigest : UInt8
    DataDigest : UInt8
    MaxRecvDataSegmentLength : UInt32
    AuthType : ISCSI_AUTH_TYPES
    EstimatedThroughput : Int64
    MaxDatagramSize : UInt32
}
struct ISCSI_SESSION_INFO_EX {
    SessionId : ISCSI_UNIQUE_SESSION_ID
    InitialR2t : BOOLEAN
    ImmediateData : BOOLEAN
    Type : UInt8
    DataSequenceInOrder : BOOLEAN
    DataPduInOrder : BOOLEAN
    ErrorRecoveryLevel : UInt8
    MaxOutstandingR2t : UInt32
    FirstBurstLength : UInt32
    MaxBurstLength : UInt32
    MaximumConnections : UInt32
    ConnectionCount : UInt32
    Connections : ISCSI_CONNECTION_INFO_EX.Ptr
}
struct ISCSI_DEVICE_ON_SESSIONW {
    InitiatorName : UInt16[256]
    TargetName : UInt16[224]
    ScsiAddress : SCSI_ADDRESS
    DeviceInterfaceType : GUID
    DeviceInterfaceName : UInt16[260]
    LegacyName : UInt16[260]
    StorageDeviceNumber : STORAGE_DEVICE_NUMBER
    DeviceInstance : UInt32
}
struct ISCSI_DEVICE_ON_SESSIONA {
    InitiatorName : CHAR[256]
    TargetName : CHAR[224]
    ScsiAddress : SCSI_ADDRESS
    DeviceInterfaceType : GUID
    DeviceInterfaceName : CHAR[260]
    LegacyName : CHAR[260]
    StorageDeviceNumber : STORAGE_DEVICE_NUMBER
    DeviceInstance : UInt32
}
struct PERSISTENT_ISCSI_LOGIN_INFOW {
    TargetName : UInt16[224]
    IsInformationalSession : BOOLEAN
    InitiatorInstance : UInt16[256]
    InitiatorPortNumber : UInt32
    TargetPortal : ISCSI_TARGET_PORTALW
    SecurityFlags : Int64
    Mappings : ISCSI_TARGET_MAPPINGW.Ptr
    LoginOptions : ISCSI_LOGIN_OPTIONS
}
struct PERSISTENT_ISCSI_LOGIN_INFOA {
    TargetName : CHAR[224]
    IsInformationalSession : BOOLEAN
    InitiatorInstance : CHAR[256]
    InitiatorPortNumber : UInt32
    TargetPortal : ISCSI_TARGET_PORTALA
    SecurityFlags : Int64
    Mappings : ISCSI_TARGET_MAPPINGA.Ptr
    LoginOptions : ISCSI_LOGIN_OPTIONS
}
struct TARGETPROTOCOLTYPE extends Int32 {
    static ISCSI_TCP_PROTOCOL_TYPE := 0
}
struct TARGET_INFORMATION_CLASS extends Int32 {
    static ProtocolType := 0
    static TargetAlias := 1
    static DiscoveryMechanisms := 2
    static PortalGroups := 3
    static PersistentTargetMappings := 4
    static InitiatorName := 5
    static TargetFlags := 6
    static LoginOptions := 7
}
struct ISCSI_VERSION_INFO {
    MajorVersion : UInt32
    MinorVersion : UInt32
    BuildNumber : UInt32
}
