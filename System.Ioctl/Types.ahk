#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, CHAR, HANDLE}
#Import "..\Security\Types.ahk" {SID}
#Import "..\Storage.FileSystem\Types.ahk" {FILE_ID_128, STORAGE_BUS_TYPE}
#Import "..\Storage.Vhd\Types.ahk" {VIRTUAL_STORAGE_TYPE}

struct GPT_ATTRIBUTES extends Int64 {
    static GPT_ATTRIBUTE_PLATFORM_REQUIRED := 1
    static GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER := -9223372036854775808
    static GPT_BASIC_DATA_ATTRIBUTE_HIDDEN := 4611686018427387904
    static GPT_BASIC_DATA_ATTRIBUTE_SHADOW_COPY := 2305843009213693952
    static GPT_BASIC_DATA_ATTRIBUTE_READ_ONLY := 1152921504606846976
}
struct USN_DELETE_FLAGS extends UInt32 {
    static USN_DELETE_FLAG_DELETE := 1
    static USN_DELETE_FLAG_NOTIFY := 2
}
struct CHANGER_FEATURES extends UInt32 {
    static CHANGER_BAR_CODE_SCANNER_INSTALLED := 1
    static CHANGER_CARTRIDGE_MAGAZINE := 256
    static CHANGER_CLEANER_ACCESS_NOT_VALID := 262144
    static CHANGER_CLEANER_SLOT := 64
    static CHANGER_CLOSE_IEPORT := 4
    static CHANGER_DEVICE_REINITIALIZE_CAPABLE := 134217728
    static CHANGER_DRIVE_CLEANING_REQUIRED := 65536
    static CHANGER_DRIVE_EMPTY_ON_DOOR_ACCESS := 536870912
    static CHANGER_EXCHANGE_MEDIA := 32
    static CHANGER_INIT_ELEM_STAT_WITH_RANGE := 2
    static CHANGER_KEYPAD_ENABLE_DISABLE := 268435456
    static CHANGER_LOCK_UNLOCK := 128
    static CHANGER_MEDIUM_FLIP := 512
    static CHANGER_OPEN_IEPORT := 8
    static CHANGER_POSITION_TO_ELEMENT := 1024
    static CHANGER_PREDISMOUNT_EJECT_REQUIRED := 131072
    static CHANGER_PREMOUNT_EJECT_REQUIRED := 524288
    static CHANGER_REPORT_IEPORT_STATE := 2048
    static CHANGER_SERIAL_NUMBER_VALID := 67108864
    static CHANGER_STATUS_NON_VOLATILE := 16
    static CHANGER_STORAGE_DRIVE := 4096
    static CHANGER_STORAGE_IEPORT := 8192
    static CHANGER_STORAGE_SLOT := 16384
    static CHANGER_STORAGE_TRANSPORT := 32768
    static CHANGER_VOLUME_ASSERT := 4194304
    static CHANGER_VOLUME_IDENTIFICATION := 1048576
    static CHANGER_VOLUME_REPLACE := 8388608
    static CHANGER_VOLUME_SEARCH := 2097152
    static CHANGER_VOLUME_UNDEFINE := 16777216
}
struct TXFS_RMF_LAGS extends UInt32 {
    static TXFS_RM_FLAG_LOGGING_MODE := 1
    static TXFS_RM_FLAG_RENAME_RM := 2
    static TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MAX := 4
    static TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MIN := 8
    static TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS := 16
    static TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT := 32
    static TXFS_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE := 64
    static TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX := 128
    static TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN := 256
    static TXFS_RM_FLAG_GROW_LOG := 1024
    static TXFS_RM_FLAG_SHRINK_LOG := 2048
    static TXFS_RM_FLAG_ENFORCE_MINIMUM_SIZE := 4096
    static TXFS_RM_FLAG_PRESERVE_CHANGES := 8192
    static TXFS_RM_FLAG_RESET_RM_AT_NEXT_START := 16384
    static TXFS_RM_FLAG_DO_NOT_RESET_RM_AT_NEXT_START := 32768
    static TXFS_RM_FLAG_PREFER_CONSISTENCY := 65536
    static TXFS_RM_FLAG_PREFER_AVAILABILITY := 131072
}
struct FILESYSTEM_STATISTICS_TYPE extends UInt16 {
    static FILESYSTEM_STATISTICS_TYPE_EXFAT := 3
    static FILESYSTEM_STATISTICS_TYPE_FAT := 2
    static FILESYSTEM_STATISTICS_TYPE_NTFS := 1
}
struct USN_SOURCE_INFO_ID extends UInt32 {
    static USN_SOURCE_AUXILIARY_DATA := 2
    static USN_SOURCE_DATA_MANAGEMENT := 1
    static USN_SOURCE_REPLICATION_MANAGEMENT := 4
    static USN_SOURCE_CLIENT_REPLICATION_MANAGEMENT := 8
}
struct FILE_STORAGE_TIER_FLAGS extends UInt32 {
    static FILE_STORAGE_TIER_FLAG_NO_SEEK_PENALTY := 131072
}
struct CHANGER_ELEMENT_STATUS_FLAGS extends UInt32 {
    static ELEMENT_STATUS_ACCESS := 8
    static ELEMENT_STATUS_AVOLTAG := 536870912
    static ELEMENT_STATUS_EXCEPT := 4
    static ELEMENT_STATUS_EXENAB := 16
    static ELEMENT_STATUS_FULL := 1
    static ELEMENT_STATUS_ID_VALID := 8192
    static ELEMENT_STATUS_IMPEXP := 2
    static ELEMENT_STATUS_INENAB := 32
    static ELEMENT_STATUS_INVERT := 4194304
    static ELEMENT_STATUS_LUN_VALID := 4096
    static ELEMENT_STATUS_NOT_BUS := 32768
    static ELEMENT_STATUS_PVOLTAG := 268435456
    static ELEMENT_STATUS_SVALID := 8388608
    static ELEMENT_STATUS_PRODUCT_DATA := 64
}
struct GET_CHANGER_PARAMETERS_FEATURES1 extends UInt32 {
    static CHANGER_CLEANER_AUTODISMOUNT := 2147483652
    static CHANGER_CLEANER_OPS_NOT_SUPPORTED := 2147483712
    static CHANGER_IEPORT_USER_CONTROL_CLOSE := 2147483904
    static CHANGER_IEPORT_USER_CONTROL_OPEN := 2147483776
    static CHANGER_MOVE_EXTENDS_IEPORT := 2147484160
    static CHANGER_MOVE_RETRACTS_IEPORT := 2147484672
    static CHANGER_PREDISMOUNT_ALIGN_TO_DRIVE := 2147483650
    static CHANGER_PREDISMOUNT_ALIGN_TO_SLOT := 2147483649
    static CHANGER_RTN_MEDIA_TO_ORIGINAL_ADDR := 2147483680
    static CHANGER_SLOTS_USE_TRAYS := 2147483664
    static CHANGER_TRUE_EXCHANGE_CAPABLE := 2147483656
}
struct MOVE_FILE_DATA32 {
    FileHandle : UInt32
    StartingVcn : Int64
    StartingLcn : Int64
    ClusterCount : UInt32
}
struct MARK_HANDLE_INFO32 {
    Anonymous : this._Anonymous_e__Union
    VolumeHandle : UInt32
    HandleInfo : UInt32
    struct _Anonymous_e__Union {
        union {
            UsnSourceInfo : UInt32
            CopyNumber : UInt32
        }
    }
}
struct DUPLICATE_EXTENTS_DATA32 {
    FileHandle : UInt32
    SourceFileOffset : Int64
    TargetFileOffset : Int64
    ByteCount : Int64
}
struct DUPLICATE_EXTENTS_DATA_EX32 {
    Size : UInt32
    FileHandle : UInt32
    SourceFileOffset : Int64
    TargetFileOffset : Int64
    ByteCount : Int64
    Flags : UInt32
}
struct STORAGE_HOTPLUG_INFO {
    Size : UInt32
    MediaRemovable : BOOLEAN
    MediaHotplug : BOOLEAN
    DeviceHotplug : BOOLEAN
    WriteCacheEnableOverride : BOOLEAN
}
struct STORAGE_FEATURE_SUPPORT {
    Size : UInt32
    Version : UInt32
    Flags : this._Flags_e__Union
    Reserved : Int64[6]
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUlonglong : Int64
        }
        struct _Anonymous_e__Struct {
            _bitfield : Int64
        }
    }
}
struct STORAGE_DEVICE_NUMBER {
    DeviceType : UInt32
    DeviceNumber : UInt32
    PartitionNumber : UInt32
}
struct STORAGE_DEVICE_NUMBERS {
    Version : UInt32
    Size : UInt32
    NumberOfDevices : UInt32
    Devices : STORAGE_DEVICE_NUMBER[1]
}
struct STORAGE_DEVICE_NUMBER_EX {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    DeviceType : UInt32
    DeviceNumber : UInt32
    DeviceGuid : GUID
    PartitionNumber : UInt32
}
struct STORAGE_BUS_RESET_REQUEST {
    PathId : UInt8
}
struct STORAGE_BREAK_RESERVATION_REQUEST {
    Length : UInt32
    _unused : UInt8
    PathId : UInt8
    TargetId : UInt8
    Lun : UInt8
}
struct PREVENT_MEDIA_REMOVAL {
    PreventMediaRemoval : BOOLEAN
}
struct CLASS_MEDIA_CHANGE_CONTEXT {
    MediaChangeCount : UInt32
    NewState : UInt32
}
struct TAPE_STATISTICS {
    Version : UInt32
    Flags : UInt32
    RecoveredWrites : Int64
    UnrecoveredWrites : Int64
    RecoveredReads : Int64
    UnrecoveredReads : Int64
    CompressionRatioReads : UInt8
    CompressionRatioWrites : UInt8
}
struct TAPE_GET_STATISTICS {
    Operation : UInt32
}
struct STORAGE_MEDIA_TYPE extends Int32 {
    static DDS_4mm := 32
    static MiniQic := 33
    static Travan := 34
    static QIC := 35
    static MP_8mm := 36
    static AME_8mm := 37
    static AIT1_8mm := 38
    static DLT := 39
    static NCTP := 40
    static IBM_3480 := 41
    static IBM_3490E := 42
    static IBM_Magstar_3590 := 43
    static IBM_Magstar_MP := 44
    static STK_DATA_D3 := 45
    static SONY_DTF := 46
    static DV_6mm := 47
    static DMI := 48
    static SONY_D2 := 49
    static CLEANER_CARTRIDGE := 50
    static CD_ROM := 51
    static CD_R := 52
    static CD_RW := 53
    static DVD_ROM := 54
    static DVD_R := 55
    static DVD_RW := 56
    static MO_3_RW := 57
    static MO_5_WO := 58
    static MO_5_RW := 59
    static MO_5_LIMDOW := 60
    static PC_5_WO := 61
    static PC_5_RW := 62
    static PD_5_RW := 63
    static ABL_5_WO := 64
    static PINNACLE_APEX_5_RW := 65
    static SONY_12_WO := 66
    static PHILIPS_12_WO := 67
    static HITACHI_12_WO := 68
    static CYGNET_12_WO := 69
    static KODAK_14_WO := 70
    static MO_NFR_525 := 71
    static NIKON_12_RW := 72
    static IOMEGA_ZIP := 73
    static IOMEGA_JAZ := 74
    static SYQUEST_EZ135 := 75
    static SYQUEST_EZFLYER := 76
    static SYQUEST_SYJET := 77
    static AVATAR_F2 := 78
    static MP2_8mm := 79
    static DST_S := 80
    static DST_M := 81
    static DST_L := 82
    static VXATape_1 := 83
    static VXATape_2 := 84
    static STK_9840 := 85
    static LTO_Ultrium := 86
    static LTO_Accelis := 87
    static DVD_RAM := 88
    static AIT_8mm := 89
    static ADR_1 := 90
    static ADR_2 := 91
    static STK_9940 := 92
    static SAIT := 93
    static VXATape := 94
}
struct DEVICE_MEDIA_INFO {
    DeviceSpecific : this._DeviceSpecific_e__Union
    struct _DeviceSpecific_e__Union {
        union {
            DiskInfo : this._DiskInfo_e__Struct
            RemovableDiskInfo : this._RemovableDiskInfo_e__Struct
            TapeInfo : this._TapeInfo_e__Struct
        }
        struct _DiskInfo_e__Struct {
            Cylinders : Int64
            MediaType : STORAGE_MEDIA_TYPE
            TracksPerCylinder : UInt32
            SectorsPerTrack : UInt32
            BytesPerSector : UInt32
            NumberMediaSides : UInt32
            MediaCharacteristics : UInt32
        }
        struct _RemovableDiskInfo_e__Struct {
            Cylinders : Int64
            MediaType : STORAGE_MEDIA_TYPE
            TracksPerCylinder : UInt32
            SectorsPerTrack : UInt32
            BytesPerSector : UInt32
            NumberMediaSides : UInt32
            MediaCharacteristics : UInt32
        }
        struct _TapeInfo_e__Struct {
            MediaType : STORAGE_MEDIA_TYPE
            MediaCharacteristics : UInt32
            CurrentBlockSize : UInt32
            BusType : STORAGE_BUS_TYPE
            BusSpecificData : this._BusSpecificData_e__Union
            struct _BusSpecificData_e__Union {
                union {
                    ScsiInformation : this._ScsiInformation_e__Struct
                }
                struct _ScsiInformation_e__Struct {
                    MediumType : UInt8
                    DensityCode : UInt8
                }
            }
        }
    }
}
struct GET_MEDIA_TYPES {
    DeviceType : UInt32
    MediaInfoCount : UInt32
    MediaInfo : DEVICE_MEDIA_INFO[1]
}
struct STORAGE_PREDICT_FAILURE {
    PredictFailure : UInt32
    VendorSpecific : UInt8[512]
}
struct STORAGE_FAILURE_PREDICTION_CONFIG {
    Version : UInt32
    Size : UInt32
    Set : BOOLEAN
    Enabled : BOOLEAN
    Reserved : UInt16
}
struct STORAGE_QUERY_TYPE extends Int32 {
    static PropertyStandardQuery := 0
    static PropertyExistsQuery := 1
    static PropertyMaskQuery := 2
    static PropertyQueryMaxDefined := 3
}
struct STORAGE_SET_TYPE extends Int32 {
    static PropertyStandardSet := 0
    static PropertyExistsSet := 1
    static PropertySetMaxDefined := 2
}
struct STORAGE_PROPERTY_ID extends Int32 {
    static StorageDeviceProperty := 0
    static StorageAdapterProperty := 1
    static StorageDeviceIdProperty := 2
    static StorageDeviceUniqueIdProperty := 3
    static StorageDeviceWriteCacheProperty := 4
    static StorageMiniportProperty := 5
    static StorageAccessAlignmentProperty := 6
    static StorageDeviceSeekPenaltyProperty := 7
    static StorageDeviceTrimProperty := 8
    static StorageDeviceWriteAggregationProperty := 9
    static StorageDeviceDeviceTelemetryProperty := 10
    static StorageDeviceLBProvisioningProperty := 11
    static StorageDevicePowerProperty := 12
    static StorageDeviceCopyOffloadProperty := 13
    static StorageDeviceResiliencyProperty := 14
    static StorageDeviceMediumProductType := 15
    static StorageAdapterRpmbProperty := 16
    static StorageAdapterCryptoProperty := 17
    static StorageDeviceIoCapabilityProperty := 48
    static StorageAdapterProtocolSpecificProperty := 49
    static StorageDeviceProtocolSpecificProperty := 50
    static StorageAdapterTemperatureProperty := 51
    static StorageDeviceTemperatureProperty := 52
    static StorageAdapterPhysicalTopologyProperty := 53
    static StorageDevicePhysicalTopologyProperty := 54
    static StorageDeviceAttributesProperty := 55
    static StorageDeviceManagementStatus := 56
    static StorageAdapterSerialNumberProperty := 57
    static StorageDeviceLocationProperty := 58
    static StorageDeviceNumaProperty := 59
    static StorageDeviceZonedDeviceProperty := 60
    static StorageDeviceUnsafeShutdownCount := 61
    static StorageDeviceEnduranceProperty := 62
    static StorageDeviceLedStateProperty := 63
    static StorageDeviceSelfEncryptionProperty := 64
    static StorageFruIdProperty := 65
    static StorageStackProperty := 66
    static StorageAdapterProtocolSpecificPropertyEx := 67
    static StorageDeviceProtocolSpecificPropertyEx := 68
    static StorageHwCryptoProperty := 69
}
struct STORAGE_PROPERTY_QUERY {
    PropertyId : STORAGE_PROPERTY_ID
    QueryType : STORAGE_QUERY_TYPE
    AdditionalParameters : UInt8[1]
}
struct STORAGE_PROPERTY_SET {
    PropertyId : STORAGE_PROPERTY_ID
    SetType : STORAGE_SET_TYPE
    AdditionalParameters : UInt8[1]
}
struct STORAGE_DESCRIPTOR_HEADER {
    Version : UInt32
    Size : UInt32
}
struct STORAGE_DEVICE_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    DeviceType : UInt8
    DeviceTypeModifier : UInt8
    RemovableMedia : BOOLEAN
    CommandQueueing : BOOLEAN
    VendorIdOffset : UInt32
    ProductIdOffset : UInt32
    ProductRevisionOffset : UInt32
    SerialNumberOffset : UInt32
    BusType : STORAGE_BUS_TYPE
    RawPropertiesLength : UInt32
    RawDeviceProperties : UInt8[1]
}
struct STORAGE_ADAPTER_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    MaximumTransferLength : UInt32
    MaximumPhysicalPages : UInt32
    AlignmentMask : UInt32
    AdapterUsesPio : BOOLEAN
    AdapterScansDown : BOOLEAN
    CommandQueueing : BOOLEAN
    AcceleratedTransfer : BOOLEAN
    BusType : UInt8
    BusMajorVersion : UInt16
    BusMinorVersion : UInt16
    SrbType : UInt8
    AddressType : UInt8
}
struct STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    BytesPerCacheLine : UInt32
    BytesOffsetForCacheAlignment : UInt32
    BytesPerLogicalSector : UInt32
    BytesPerPhysicalSector : UInt32
    BytesOffsetForSectorAlignment : UInt32
}
struct STORAGE_MEDIUM_PRODUCT_TYPE_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    MediumProductType : UInt32
}
struct STORAGE_PORT_CODE_SET extends Int32 {
    static StoragePortCodeSetReserved := 0
    static StoragePortCodeSetStorport := 1
    static StoragePortCodeSetSCSIport := 2
    static StoragePortCodeSetSpaceport := 3
    static StoragePortCodeSetATAport := 4
    static StoragePortCodeSetUSBport := 5
    static StoragePortCodeSetSBP2port := 6
    static StoragePortCodeSetSDport := 7
}
struct STORAGE_MINIPORT_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    Portdriver : STORAGE_PORT_CODE_SET
    LUNResetSupported : BOOLEAN
    TargetResetSupported : BOOLEAN
    IoTimeoutValue : UInt16
    ExtraIoInfoSupported : BOOLEAN
    Flags : this._Flags_e__Union
    Reserved0 : UInt8[2]
    Reserved1 : UInt32
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsBYTE : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct STORAGE_IDENTIFIER_CODE_SET extends Int32 {
    static StorageIdCodeSetReserved := 0
    static StorageIdCodeSetBinary := 1
    static StorageIdCodeSetAscii := 2
    static StorageIdCodeSetUtf8 := 3
}
struct STORAGE_IDENTIFIER_TYPE extends Int32 {
    static StorageIdTypeVendorSpecific := 0
    static StorageIdTypeVendorId := 1
    static StorageIdTypeEUI64 := 2
    static StorageIdTypeFCPHName := 3
    static StorageIdTypePortRelative := 4
    static StorageIdTypeTargetPortGroup := 5
    static StorageIdTypeLogicalUnitGroup := 6
    static StorageIdTypeMD5LogicalUnitIdentifier := 7
    static StorageIdTypeScsiNameString := 8
}
struct STORAGE_ID_NAA_FORMAT extends Int32 {
    static StorageIdNAAFormatIEEEExtended := 2
    static StorageIdNAAFormatIEEERegistered := 3
    static StorageIdNAAFormatIEEEERegisteredExtended := 5
}
struct STORAGE_ASSOCIATION_TYPE extends Int32 {
    static StorageIdAssocDevice := 0
    static StorageIdAssocPort := 1
    static StorageIdAssocTarget := 2
}
struct STORAGE_IDENTIFIER {
    CodeSet : STORAGE_IDENTIFIER_CODE_SET
    Type : STORAGE_IDENTIFIER_TYPE
    IdentifierSize : UInt16
    NextOffset : UInt16
    Association : STORAGE_ASSOCIATION_TYPE
    Identifier : UInt8[1]
}
struct STORAGE_DEVICE_ID_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    NumberOfIdentifiers : UInt32
    Identifiers : UInt8[1]
}
struct DEVICE_SEEK_PENALTY_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    IncursSeekPenalty : BOOLEAN
}
struct DEVICE_WRITE_AGGREGATION_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    BenefitsFromWriteAggregation : BOOLEAN
}
struct DEVICE_TRIM_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    TrimEnabled : BOOLEAN
}
struct DEVICE_LB_PROVISIONING_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    _bitfield : UInt8
    Reserved1 : UInt8[7]
    OptimalUnmapGranularity : Int64
    UnmapGranularityAlignment : Int64
    MaxUnmapLbaCount : UInt32
    MaxUnmapBlockDescriptorCount : UInt32
}
struct STORAGE_LB_PROVISIONING_MAP_RESOURCES {
    Size : UInt32
    Version : UInt32
    _bitfield1 : UInt8
    Reserved1 : UInt8[3]
    _bitfield2 : UInt8
    Reserved3 : UInt8[3]
    AvailableMappingResources : Int64
    UsedMappingResources : Int64
}
struct DEVICE_POWER_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    DeviceAttentionSupported : BOOLEAN
    AsynchronousNotificationSupported : BOOLEAN
    IdlePowerManagementEnabled : BOOLEAN
    D3ColdEnabled : BOOLEAN
    D3ColdSupported : BOOLEAN
    NoVerifyDuringIdlePower : BOOLEAN
    Reserved : UInt8[2]
    IdleTimeoutInMS : UInt32
}
struct DEVICE_COPY_OFFLOAD_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    MaximumTokenLifetime : UInt32
    DefaultTokenLifetime : UInt32
    MaximumTransferSize : Int64
    OptimalTransferCount : Int64
    MaximumDataDescriptors : UInt32
    MaximumTransferLengthPerDescriptor : UInt32
    OptimalTransferLengthPerDescriptor : UInt32
    OptimalTransferLengthGranularity : UInt16
    Reserved : UInt8[2]
}
struct STORAGE_DEVICE_RESILIENCY_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    NameOffset : UInt32
    NumberOfLogicalCopies : UInt32
    NumberOfPhysicalCopies : UInt32
    PhysicalDiskRedundancy : UInt32
    NumberOfColumns : UInt32
    Interleave : UInt32
}
struct STORAGE_RPMB_FRAME_TYPE extends Int32 {
    static StorageRpmbFrameTypeUnknown := 0
    static StorageRpmbFrameTypeStandard := 1
    static StorageRpmbFrameTypeMax := 2
}
struct STORAGE_RPMB_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    SizeInBytes : UInt32
    MaxReliableWriteSizeInBytes : UInt32
    FrameFormat : STORAGE_RPMB_FRAME_TYPE
}
struct STORAGE_CRYPTO_ALGORITHM_ID extends Int32 {
    static StorageCryptoAlgorithmUnknown := 0
    static StorageCryptoAlgorithmXTSAES := 1
    static StorageCryptoAlgorithmBitlockerAESCBC := 2
    static StorageCryptoAlgorithmAESECB := 3
    static StorageCryptoAlgorithmESSIVAESCBC := 4
    static StorageCryptoAlgorithmMax := 5
    static StorCryptoAlgorithmUnknown := 0
    static StorCryptoAlgorithmXTSAES := 1
    static StorCryptoAlgorithmBitlockerAESCBC := 2
    static StorCryptoAlgorithmAESECB := 3
    static StorCryptoAlgorithmESSIVAESCBC := 4
}
struct STORAGE_CRYPTO_KEY_SIZE extends Int32 {
    static StorageCryptoKeySizeUnknown := 0
    static StorageCryptoKeySize128Bits := 1
    static StorageCryptoKeySize192Bits := 2
    static StorageCryptoKeySize256Bits := 3
    static StorageCryptoKeySize512Bits := 4
    static StorageCryptoKeySizeMax := 5
    static StorCryptoKeySizeUnknown := 0
    static StorCryptoKeySize128Bits := 1
    static StorCryptoKeySize192Bits := 2
    static StorCryptoKeySize256Bits := 3
    static StorCryptoKeySize512Bits := 4
}
struct STORAGE_CRYPTO_CAPABILITY {
    Version : UInt32
    Size : UInt32
    CryptoCapabilityIndex : UInt32
    AlgorithmId : STORAGE_CRYPTO_ALGORITHM_ID
    KeySize : STORAGE_CRYPTO_KEY_SIZE
    DataUnitSizeBitmask : UInt32
}
struct STORAGE_SECURITY_COMPLIANCE_BITMASK {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUchar : UInt8
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct STORAGE_CRYPTO_KEY_TYPE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUchar : UInt8
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct STORAGE_CRYPTO_CAPABILITY_V2 {
    Version : UInt32
    Size : UInt32
    CryptoCapabilityIndex : UInt32
    AlgorithmId : STORAGE_CRYPTO_ALGORITHM_ID
    KeySize : STORAGE_CRYPTO_KEY_SIZE
    DataUnitSizeBitmask : UInt32
    MaxIVBitSize : UInt16
    Reserved : UInt16
    SecurityComplianceBitmask : STORAGE_SECURITY_COMPLIANCE_BITMASK
}
struct STORAGE_CRYPTO_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    NumKeysSupported : UInt32
    NumCryptoCapabilities : UInt32
    CryptoCapabilities : STORAGE_CRYPTO_CAPABILITY[1]
}
struct STORAGE_ICE_TYPE extends Int32 {
    static StorageIceTypeUnknown := 0
    static StorageIceTypeUfs := 1
    static StorageIceTypeNvme := 2
}
struct STORAGE_CRYPTO_DESCRIPTOR_V2 {
    Version : UInt32
    Size : UInt32
    NumKeysSupported : UInt32
    NumCryptoCapabilities : UInt32
    IceType : STORAGE_ICE_TYPE
    SecurityComplianceBitmask : STORAGE_SECURITY_COMPLIANCE_BITMASK
    KeyTypeBitmask : STORAGE_CRYPTO_KEY_TYPE
    CryptoCapabilities : STORAGE_CRYPTO_CAPABILITY_V2[1]
}
struct STORAGE_HW_CRYPTO_CAPABILITY {
    Version : UInt32
    Size : UInt32
    CryptoCapabilityIndex : UInt32
    AlgorithmId : STORAGE_CRYPTO_ALGORITHM_ID
    KeySize : STORAGE_CRYPTO_KEY_SIZE
    DataUnitSizeBitmask : UInt32
    MaxIVBitSize : UInt16
    Reserved : UInt16
    SecurityComplianceBitmask : STORAGE_SECURITY_COMPLIANCE_BITMASK
}
struct STORAGE_HW_CRYPTO_DESCRIPTOR {
    Header : STORAGE_DESCRIPTOR_HEADER
    NumKeysSupported : UInt32
    NumCryptoCapabilities : UInt32
    OffsetToCryptoCapabilities : UInt32
    SizeOfCryptoCapability : UInt32
    IceType : STORAGE_ICE_TYPE
    SecurityComplianceBitmask : STORAGE_SECURITY_COMPLIANCE_BITMASK
    KeyTypeBitmask : STORAGE_CRYPTO_KEY_TYPE
}
struct STORAGE_TIER_MEDIA_TYPE extends Int32 {
    static StorageTierMediaTypeUnspecified := 0
    static StorageTierMediaTypeDisk := 1
    static StorageTierMediaTypeSsd := 2
    static StorageTierMediaTypeScm := 4
    static StorageTierMediaTypeMax := 5
}
struct STORAGE_TIER_CLASS extends Int32 {
    static StorageTierClassUnspecified := 0
    static StorageTierClassCapacity := 1
    static StorageTierClassPerformance := 2
    static StorageTierClassMax := 3
}
struct STORAGE_TIER {
    Id : GUID
    Name : UInt16[256]
    Description : UInt16[256]
    Flags : Int64
    ProvisionedCapacity : Int64
    MediaType : STORAGE_TIER_MEDIA_TYPE
    Class : STORAGE_TIER_CLASS
}
struct STORAGE_DEVICE_TIERING_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    TotalNumberOfTiers : UInt32
    NumberOfTiersReturned : UInt32
    Tiers : STORAGE_TIER[1]
}
struct STORAGE_DEVICE_FAULT_DOMAIN_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    NumberOfFaultDomains : UInt32
    FaultDomainIds : GUID[1]
}
struct STORAGE_PROTOCOL_TYPE extends Int32 {
    static ProtocolTypeUnknown := 0
    static ProtocolTypeScsi := 1
    static ProtocolTypeAta := 2
    static ProtocolTypeNvme := 3
    static ProtocolTypeSd := 4
    static ProtocolTypeUfs := 5
    static ProtocolTypeProprietary := 126
    static ProtocolTypeMaxReserved := 127
}
struct STORAGE_PROTOCOL_NVME_DATA_TYPE extends Int32 {
    static NVMeDataTypeUnknown := 0
    static NVMeDataTypeIdentify := 1
    static NVMeDataTypeLogPage := 2
    static NVMeDataTypeFeature := 3
    static NVMeDataTypeLogPageEx := 4
    static NVMeDataTypeFeatureEx := 5
}
struct STORAGE_PROTOCOL_ATA_DATA_TYPE extends Int32 {
    static AtaDataTypeUnknown := 0
    static AtaDataTypeIdentify := 1
    static AtaDataTypeLogPage := 2
}
struct STORAGE_PROTOCOL_UFS_DATA_TYPE extends Int32 {
    static UfsDataTypeUnknown := 0
    static UfsDataTypeQueryDescriptor := 1
    static UfsDataTypeQueryAttribute := 2
    static UfsDataTypeQueryFlag := 3
    static UfsDataTypeQueryDmeAttribute := 4
    static UfsDataTypeQueryDmePeerAttribute := 5
    static UfsDataTypeMax := 6
}
struct STORAGE_PROTOCOL_DATA_SUBVALUE_GET_LOG_PAGE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct STORAGE_PROTOCOL_SPECIFIC_DATA {
    ProtocolType : STORAGE_PROTOCOL_TYPE
    DataType : UInt32
    ProtocolDataRequestValue : UInt32
    ProtocolDataRequestSubValue : UInt32
    ProtocolDataOffset : UInt32
    ProtocolDataLength : UInt32
    FixedProtocolReturnData : UInt32
    ProtocolDataRequestSubValue2 : UInt32
    ProtocolDataRequestSubValue3 : UInt32
    ProtocolDataRequestSubValue4 : UInt32
}
struct STORAGE_PROTOCOL_SPECIFIC_DATA_EXT {
    ProtocolType : STORAGE_PROTOCOL_TYPE
    DataType : UInt32
    ProtocolDataValue : UInt32
    ProtocolDataSubValue : UInt32
    ProtocolDataOffset : UInt32
    ProtocolDataLength : UInt32
    FixedProtocolReturnData : UInt32
    ProtocolDataSubValue2 : UInt32
    ProtocolDataSubValue3 : UInt32
    ProtocolDataSubValue4 : UInt32
    ProtocolDataSubValue5 : UInt32
    ProtocolDataSubValue6 : UInt32
    Reserved : UInt32[4]
}
struct STORAGE_PROTOCOL_DATA_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    ProtocolSpecificData : STORAGE_PROTOCOL_SPECIFIC_DATA
}
struct STORAGE_PROTOCOL_DATA_DESCRIPTOR_EXT {
    Version : UInt32
    Size : UInt32
    ProtocolSpecificData : STORAGE_PROTOCOL_SPECIFIC_DATA_EXT
}
struct STORAGE_TEMPERATURE_INFO {
    Index : UInt16
    Temperature : Int16
    OverThreshold : Int16
    UnderThreshold : Int16
    OverThresholdChangable : BOOLEAN
    UnderThresholdChangable : BOOLEAN
    EventGenerated : BOOLEAN
    Reserved0 : UInt8
    Reserved1 : UInt32
}
struct STORAGE_TEMPERATURE_DATA_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    CriticalTemperature : Int16
    WarningTemperature : Int16
    InfoCount : UInt16
    Reserved0 : UInt8[2]
    Reserved1 : UInt32[2]
    TemperatureInfo : STORAGE_TEMPERATURE_INFO[1]
}
struct STORAGE_TEMPERATURE_THRESHOLD {
    Version : UInt32
    Size : UInt32
    Flags : UInt16
    Index : UInt16
    Threshold : Int16
    OverThreshold : BOOLEAN
    Reserved : UInt8
}
struct STORAGE_DEVICE_FORM_FACTOR extends Int32 {
    static FormFactorUnknown := 0
    static FormFactor3_5 := 1
    static FormFactor2_5 := 2
    static FormFactor1_8 := 3
    static FormFactor1_8Less := 4
    static FormFactorEmbedded := 5
    static FormFactorMemoryCard := 6
    static FormFactormSata := 7
    static FormFactorM_2 := 8
    static FormFactorPCIeBoard := 9
    static FormFactorDimm := 10
}
struct STORAGE_COMPONENT_HEALTH_STATUS extends Int32 {
    static HealthStatusUnknown := 0
    static HealthStatusNormal := 1
    static HealthStatusThrottled := 2
    static HealthStatusWarning := 3
    static HealthStatusDisabled := 4
    static HealthStatusFailed := 5
}
struct STORAGE_SPEC_VERSION {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        MinorVersion : this._MinorVersion_e__Union
        MajorVersion : UInt16
        struct _MinorVersion_e__Union {
            union {
                Anonymous : this._Anonymous_e__Struct
                AsUshort : UInt16
            }
            struct _Anonymous_e__Struct {
                SubMinor : UInt8
                Minor : UInt8
            }
        }
    }
}
struct STORAGE_PHYSICAL_DEVICE_DATA {
    DeviceId : UInt32
    Role : UInt32
    HealthStatus : STORAGE_COMPONENT_HEALTH_STATUS
    CommandProtocol : STORAGE_PROTOCOL_TYPE
    SpecVersion : STORAGE_SPEC_VERSION
    FormFactor : STORAGE_DEVICE_FORM_FACTOR
    Vendor : UInt8[8]
    Model : UInt8[40]
    FirmwareRevision : UInt8[16]
    Capacity : Int64
    PhysicalLocation : UInt8[32]
    Reserved : UInt32[2]
}
struct STORAGE_PHYSICAL_ADAPTER_DATA {
    AdapterId : UInt32
    HealthStatus : STORAGE_COMPONENT_HEALTH_STATUS
    CommandProtocol : STORAGE_PROTOCOL_TYPE
    SpecVersion : STORAGE_SPEC_VERSION
    Vendor : UInt8[8]
    Model : UInt8[40]
    FirmwareRevision : UInt8[16]
    PhysicalLocation : UInt8[32]
    ExpanderConnected : BOOLEAN
    Reserved0 : UInt8[3]
    Reserved1 : UInt32[3]
}
struct STORAGE_PHYSICAL_NODE_DATA {
    NodeId : UInt32
    AdapterCount : UInt32
    AdapterDataLength : UInt32
    AdapterDataOffset : UInt32
    DeviceCount : UInt32
    DeviceDataLength : UInt32
    DeviceDataOffset : UInt32
    Reserved : UInt32[3]
}
struct STORAGE_PHYSICAL_TOPOLOGY_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    NodeCount : UInt32
    Reserved : UInt32
    Node : STORAGE_PHYSICAL_NODE_DATA[1]
}
struct STORAGE_DEVICE_IO_CAPABILITY_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    LunMaxIoCount : UInt32
    AdapterMaxIoCount : UInt32
}
struct STORAGE_DEVICE_ATTRIBUTES_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    Attributes : Int64
}
struct STORAGE_DISK_HEALTH_STATUS extends Int32 {
    static DiskHealthUnknown := 0
    static DiskHealthUnhealthy := 1
    static DiskHealthWarning := 2
    static DiskHealthHealthy := 3
    static DiskHealthMax := 4
}
struct STORAGE_DISK_OPERATIONAL_STATUS extends Int32 {
    static DiskOpStatusNone := 0
    static DiskOpStatusUnknown := 1
    static DiskOpStatusOk := 2
    static DiskOpStatusPredictingFailure := 3
    static DiskOpStatusInService := 4
    static DiskOpStatusHardwareError := 5
    static DiskOpStatusNotUsable := 6
    static DiskOpStatusTransientError := 7
    static DiskOpStatusMissing := 8
}
struct STORAGE_OPERATIONAL_STATUS_REASON extends Int32 {
    static DiskOpReasonUnknown := 0
    static DiskOpReasonScsiSenseCode := 1
    static DiskOpReasonMedia := 2
    static DiskOpReasonIo := 3
    static DiskOpReasonThresholdExceeded := 4
    static DiskOpReasonLostData := 5
    static DiskOpReasonEnergySource := 6
    static DiskOpReasonConfiguration := 7
    static DiskOpReasonDeviceController := 8
    static DiskOpReasonMediaController := 9
    static DiskOpReasonComponent := 10
    static DiskOpReasonNVDIMM_N := 11
    static DiskOpReasonBackgroundOperation := 12
    static DiskOpReasonInvalidFirmware := 13
    static DiskOpReasonHealthCheck := 14
    static DiskOpReasonLostDataPersistence := 15
    static DiskOpReasonDisabledByPlatform := 16
    static DiskOpReasonLostWritePersistence := 17
    static DiskOpReasonDataPersistenceLossImminent := 18
    static DiskOpReasonWritePersistenceLossImminent := 19
    static DiskOpReasonMax := 20
}
struct STORAGE_OPERATIONAL_REASON {
    Version : UInt32
    Size : UInt32
    Reason : STORAGE_OPERATIONAL_STATUS_REASON
    RawBytes : this._RawBytes_e__Union
    struct _RawBytes_e__Union {
        union {
            ScsiSenseKey : this._ScsiSenseKey_e__Struct
            NVDIMM_N : this._NVDIMM_N_e__Struct
            AsUlong : UInt32
        }
        struct _ScsiSenseKey_e__Struct {
            SenseKey : UInt8
            ASC : UInt8
            ASCQ : UInt8
            Reserved : UInt8
        }
        struct _NVDIMM_N_e__Struct {
            CriticalHealth : UInt8
            ModuleHealth : UInt8[2]
            ErrorThresholdStatus : UInt8
        }
    }
}
struct STORAGE_DEVICE_MANAGEMENT_STATUS {
    Version : UInt32
    Size : UInt32
    Health : STORAGE_DISK_HEALTH_STATUS
    NumberOfOperationalStatus : UInt32
    NumberOfAdditionalReasons : UInt32
    OperationalStatus : STORAGE_DISK_OPERATIONAL_STATUS[16]
    AdditionalReasons : STORAGE_OPERATIONAL_REASON[1]
}
struct STORAGE_ADAPTER_SERIAL_NUMBER {
    Version : UInt32
    Size : UInt32
    SerialNumber : UInt16[128]
}
struct STORAGE_ZONED_DEVICE_TYPES extends Int32 {
    static ZonedDeviceTypeUnknown := 0
    static ZonedDeviceTypeHostManaged := 1
    static ZonedDeviceTypeHostAware := 2
    static ZonedDeviceTypeDeviceManaged := 3
}
struct STORAGE_ZONE_TYPES extends Int32 {
    static ZoneTypeUnknown := 0
    static ZoneTypeConventional := 1
    static ZoneTypeSequentialWriteRequired := 2
    static ZoneTypeSequentialWritePreferred := 3
    static ZoneTypeMax := 4
}
struct STORAGE_ZONE_GROUP {
    ZoneCount : UInt32
    ZoneType : STORAGE_ZONE_TYPES
    ZoneSize : Int64
}
struct STORAGE_ZONED_DEVICE_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    DeviceType : STORAGE_ZONED_DEVICE_TYPES
    ZoneCount : UInt32
    ZoneAttributes : this._ZoneAttributes_e__Union
    ZoneGroupCount : UInt32
    ZoneGroup : STORAGE_ZONE_GROUP[1]
    struct _ZoneAttributes_e__Union {
        union {
            SequentialRequiredZone : this._SequentialRequiredZone_e__Struct
            SequentialPreferredZone : this._SequentialPreferredZone_e__Struct
        }
        struct _SequentialRequiredZone_e__Struct {
            MaxOpenZoneCount : UInt32
            UnrestrictedRead : BOOLEAN
            Reserved : UInt8[3]
        }
        struct _SequentialPreferredZone_e__Struct {
            OptimalOpenZoneCount : UInt32
            Reserved : UInt32
        }
    }
}
struct DEVICE_LOCATION {
    Socket : UInt32
    Slot : UInt32
    Adapter : UInt32
    Port : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            Channel : UInt32
            Device : UInt32
        }
        struct _Anonymous2_e__Struct {
            Target : UInt32
            Lun : UInt32
        }
    }
}
struct STORAGE_DEVICE_LOCATION_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    Location : DEVICE_LOCATION
    StringOffset : UInt32
}
struct STORAGE_DEVICE_NUMA_PROPERTY {
    Version : UInt32
    Size : UInt32
    NumaNode : UInt32
}
struct STORAGE_DEVICE_UNSAFE_SHUTDOWN_COUNT {
    Version : UInt32
    Size : UInt32
    UnsafeShutdownCount : UInt32
}
struct STORAGE_HW_ENDURANCE_INFO {
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
struct STORAGE_HW_ENDURANCE_DATA_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    EnduranceInfo : STORAGE_HW_ENDURANCE_INFO
}
struct STORAGE_STACK_TYPE extends Int32 {
    static StorageStackTypeUnknown := 0
    static StorageStackTypeScsi := 1
    static StorageStackTypeNVMe := 2
}
struct STORAGE_STACK_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    StorageStackType : STORAGE_STACK_TYPE
}
struct STORAGE_DEVICE_LED_STATE_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    State : Int64
}
struct STORAGE_DEVICE_SELF_ENCRYPTION_PROPERTY {
    Version : UInt32
    Size : UInt32
    SupportsSelfEncryption : BOOLEAN
}
struct STORAGE_ENCRYPTION_TYPE extends Int32 {
    static StorageEncryptionTypeUnknown := 0
    static StorageEncryptionTypeEDrive := 1
    static StorageEncryptionTypeTcgOpal := 2
}
struct STORAGE_DEVICE_SELF_ENCRYPTION_PROPERTY_V2 {
    Version : UInt32
    Size : UInt32
    SupportsSelfEncryption : BOOLEAN
    EncryptionType : STORAGE_ENCRYPTION_TYPE
}
struct STORAGE_FRU_ID_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    IdentifierSize : UInt32
    Identifier : UInt8[1]
}
struct DEVICE_DATA_SET_RANGE {
    StartingOffset : Int64
    LengthInBytes : Int64
}
struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES {
    Size : UInt32
    Action : UInt32
    Flags : UInt32
    ParameterBlockOffset : UInt32
    ParameterBlockLength : UInt32
    DataSetRangesOffset : UInt32
    DataSetRangesLength : UInt32
}
struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES_OUTPUT {
    Size : UInt32
    Action : UInt32
    Flags : UInt32
    OperationStatus : UInt32
    ExtendedError : UInt32
    TargetDetailedError : UInt32
    ReservedStatus : UInt32
    OutputBlockOffset : UInt32
    OutputBlockLength : UInt32
}
struct DEVICE_DSM_DEFINITION {
    Action : UInt32
    SingleRange : BOOLEAN
    ParameterBlockAlignment : UInt32
    ParameterBlockLength : UInt32
    HasOutput : BOOLEAN
    OutputBlockAlignment : UInt32
    OutputBlockLength : UInt32
}
struct DEVICE_DSM_NOTIFICATION_PARAMETERS {
    Size : UInt32
    Flags : UInt32
    NumFileTypeIDs : UInt32
    FileTypeID : GUID[1]
}
struct STORAGE_OFFLOAD_TOKEN {
    TokenType : UInt8[4]
    Reserved : UInt8[2]
    TokenIdLength : UInt8[2]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            StorageOffloadZeroDataToken : this._StorageOffloadZeroDataToken_e__Struct
            Token : UInt8[504]
        }
        struct _StorageOffloadZeroDataToken_e__Struct {
            Reserved2 : UInt8[504]
        }
    }
}
struct DEVICE_DSM_OFFLOAD_READ_PARAMETERS {
    Flags : UInt32
    TimeToLive : UInt32
    Reserved : UInt32[2]
}
struct STORAGE_OFFLOAD_READ_OUTPUT {
    OffloadReadFlags : UInt32
    Reserved : UInt32
    LengthProtected : Int64
    TokenLength : UInt32
    Token : STORAGE_OFFLOAD_TOKEN
}
struct DEVICE_DSM_OFFLOAD_WRITE_PARAMETERS {
    Flags : UInt32
    Reserved : UInt32
    TokenOffset : Int64
    Token : STORAGE_OFFLOAD_TOKEN
}
struct STORAGE_OFFLOAD_WRITE_OUTPUT {
    OffloadWriteFlags : UInt32
    Reserved : UInt32
    LengthCopied : Int64
}
struct DEVICE_DATA_SET_LBP_STATE_PARAMETERS {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    OutputVersion : UInt32
}
struct DEVICE_DATA_SET_LB_PROVISIONING_STATE {
    Size : UInt32
    Version : UInt32
    SlabSizeInBytes : Int64
    SlabOffsetDeltaInBytes : UInt32
    SlabAllocationBitMapBitCount : UInt32
    SlabAllocationBitMapLength : UInt32
    SlabAllocationBitMap : UInt32[1]
}
struct DEVICE_DATA_SET_LB_PROVISIONING_STATE_V2 {
    Size : UInt32
    Version : UInt32
    SlabSizeInBytes : Int64
    SlabOffsetDeltaInBytes : Int64
    SlabAllocationBitMapBitCount : UInt32
    SlabAllocationBitMapLength : UInt32
    SlabAllocationBitMap : UInt32[1]
}
struct DEVICE_DATA_SET_REPAIR_PARAMETERS {
    NumberOfRepairCopies : UInt32
    SourceCopy : UInt32
    RepairCopies : UInt32[1]
}
struct DEVICE_DATA_SET_REPAIR_OUTPUT {
    ParityExtent : DEVICE_DATA_SET_RANGE
}
struct DEVICE_DSM_QUERY_PREFER_LOCAL_REPAIR_OUTPUT {
    Version : UInt32
    PreferLocalRepair : BOOLEAN
}
struct DEVICE_DATA_SET_SCRUB_OUTPUT {
    BytesProcessed : Int64
    BytesRepaired : Int64
    BytesFailed : Int64
}
struct DEVICE_DATA_SET_SCRUB_EX_OUTPUT {
    BytesProcessed : Int64
    BytesRepaired : Int64
    BytesFailed : Int64
    ParityExtent : DEVICE_DATA_SET_RANGE
    BytesScrubbed : Int64
}
struct DEVICE_DSM_TIERING_QUERY_INPUT {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    NumberOfTierIds : UInt32
    TierIds : GUID[1]
}
struct STORAGE_TIER_REGION {
    TierId : GUID
    Offset : Int64
    Length : Int64
}
struct DEVICE_DSM_TIERING_QUERY_OUTPUT {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Reserved : UInt32
    Alignment : Int64
    TotalNumberOfRegions : UInt32
    NumberOfRegionsReturned : UInt32
    Regions : STORAGE_TIER_REGION[1]
}
struct DEVICE_DSM_NVCACHE_CHANGE_PRIORITY_PARAMETERS {
    Size : UInt32
    TargetPriority : UInt8
    Reserved : UInt8[3]
}
struct DEVICE_DATA_SET_TOPOLOGY_ID_QUERY_OUTPUT {
    TopologyRangeBytes : Int64
    TopologyId : UInt8[16]
}
struct DEVICE_STORAGE_ADDRESS_RANGE {
    StartAddress : Int64
    LengthInBytes : Int64
}
struct DEVICE_DSM_PHYSICAL_ADDRESSES_OUTPUT {
    Version : UInt32
    Flags : UInt32
    TotalNumberOfRanges : UInt32
    NumberOfRangesReturned : UInt32
    Ranges : DEVICE_STORAGE_ADDRESS_RANGE[1]
}
struct DEVICE_DSM_REPORT_ZONES_PARAMETERS {
    Size : UInt32
    ReportOption : UInt8
    Partial : UInt8
    Reserved : UInt8[2]
}
struct STORAGE_ZONES_ATTRIBUTES extends Int32 {
    static ZonesAttributeTypeAndLengthMayDifferent := 0
    static ZonesAttributeTypeSameLengthSame := 1
    static ZonesAttributeTypeSameLastZoneLengthDifferent := 2
    static ZonesAttributeTypeMayDifferentLengthSame := 3
}
struct STORAGE_ZONE_CONDITION extends Int32 {
    static ZoneConditionConventional := 0
    static ZoneConditionEmpty := 1
    static ZoneConditionImplicitlyOpened := 2
    static ZoneConditionExplicitlyOpened := 3
    static ZoneConditionClosed := 4
    static ZoneConditionReadOnly := 13
    static ZoneConditionFull := 14
    static ZoneConditionOffline := 15
}
struct STORAGE_ZONE_DESCRIPTOR {
    Size : UInt32
    ZoneType : STORAGE_ZONE_TYPES
    ZoneCondition : STORAGE_ZONE_CONDITION
    ResetWritePointerRecommend : BOOLEAN
    Reserved0 : UInt8[3]
    ZoneSize : Int64
    WritePointerOffset : Int64
}
struct DEVICE_DSM_REPORT_ZONES_DATA {
    Size : UInt32
    ZoneCount : UInt32
    Attributes : STORAGE_ZONES_ATTRIBUTES
    Reserved0 : UInt32
    ZoneDescriptors : STORAGE_ZONE_DESCRIPTOR[1]
}
struct DEVICE_STORAGE_RANGE_ATTRIBUTES {
    LengthInBytes : Int64
    Anonymous : this._Anonymous_e__Union
    Reserved : UInt32
    struct _Anonymous_e__Union {
        union {
            AllFlags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DEVICE_DSM_RANGE_ERROR_INFO {
    Version : UInt32
    Flags : UInt32
    TotalNumberOfRanges : UInt32
    NumberOfRangesReturned : UInt32
    Ranges : DEVICE_STORAGE_RANGE_ATTRIBUTES[1]
}
struct DEVICE_DSM_LOST_QUERY_PARAMETERS {
    Version : UInt32
    Granularity : Int64
}
struct DEVICE_DSM_LOST_QUERY_OUTPUT {
    Version : UInt32
    Size : UInt32
    Alignment : Int64
    NumberOfBits : UInt32
    BitMap : UInt32[1]
}
struct DEVICE_DSM_FREE_SPACE_OUTPUT {
    Version : UInt32
    FreeSpace : Int64
}
struct DEVICE_DSM_CONVERSION_OUTPUT {
    Version : UInt32
    Source : GUID
}
struct STORAGE_GET_BC_PROPERTIES_OUTPUT {
    MaximumRequestsPerPeriod : UInt32
    MinimumPeriod : UInt32
    MaximumRequestSize : Int64
    EstimatedTimePerRequest : UInt32
    NumOutStandingRequests : UInt32
    RequestSize : Int64
}
struct STORAGE_ALLOCATE_BC_STREAM_INPUT {
    Version : UInt32
    RequestsPerPeriod : UInt32
    Period : UInt32
    RetryFailures : BOOLEAN
    Discardable : BOOLEAN
    Reserved1 : BOOLEAN[2]
    AccessType : UInt32
    AccessMode : UInt32
}
struct STORAGE_ALLOCATE_BC_STREAM_OUTPUT {
    RequestSize : Int64
    NumOutStandingRequests : UInt32
}
struct STORAGE_PRIORITY_HINT_SUPPORT {
    SupportFlags : UInt32
}
struct STORAGE_DIAGNOSTIC_LEVEL extends Int32 {
    static StorageDiagnosticLevelDefault := 0
    static StorageDiagnosticLevelMax := 1
}
struct STORAGE_DIAGNOSTIC_TARGET_TYPE extends Int32 {
    static StorageDiagnosticTargetTypeUndefined := 0
    static StorageDiagnosticTargetTypePort := 1
    static StorageDiagnosticTargetTypeMiniport := 2
    static StorageDiagnosticTargetTypeHbaFirmware := 3
    static StorageDiagnosticTargetTypeMax := 4
}
struct STORAGE_DIAGNOSTIC_REQUEST {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    TargetType : STORAGE_DIAGNOSTIC_TARGET_TYPE
    Level : STORAGE_DIAGNOSTIC_LEVEL
}
struct STORAGE_DIAGNOSTIC_DATA {
    Version : UInt32
    Size : UInt32
    ProviderId : GUID
    BufferSize : UInt32
    Reserved : UInt32
    DiagnosticDataBuffer : UInt8[1]
}
struct PHYSICAL_ELEMENT_STATUS_REQUEST {
    Version : UInt32
    Size : UInt32
    StartingElement : UInt32
    Filter : UInt8
    ReportType : UInt8
    Reserved : UInt8[2]
}
struct PHYSICAL_ELEMENT_STATUS_DESCRIPTOR {
    Version : UInt32
    Size : UInt32
    ElementIdentifier : UInt32
    PhysicalElementType : UInt8
    PhysicalElementHealth : UInt8
    Reserved1 : UInt8[2]
    AssociatedCapacity : Int64
    Reserved2 : UInt32[4]
}
struct PHYSICAL_ELEMENT_STATUS {
    Version : UInt32
    Size : UInt32
    DescriptorCount : UInt32
    ReturnedDescriptorCount : UInt32
    ElementIdentifierBeingDepoped : UInt32
    Reserved : UInt32
    Descriptors : PHYSICAL_ELEMENT_STATUS_DESCRIPTOR[1]
}
struct REMOVE_ELEMENT_AND_TRUNCATE_REQUEST {
    Version : UInt32
    Size : UInt32
    RequestCapacity : Int64
    ElementIdentifier : UInt32
    Reserved : UInt32
}
struct DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE extends Int32 {
    static DeviceInternalStatusDataRequestTypeUndefined := 0
    static DeviceCurrentInternalStatusDataHeader := 1
    static DeviceCurrentInternalStatusData := 2
    static DeviceSavedInternalStatusDataHeader := 3
    static DeviceSavedInternalStatusData := 4
}
struct DEVICE_INTERNAL_STATUS_DATA_SET extends Int32 {
    static DeviceStatusDataSetUndefined := 0
    static DeviceStatusDataSet1 := 1
    static DeviceStatusDataSet2 := 2
    static DeviceStatusDataSet3 := 3
    static DeviceStatusDataSet4 := 4
    static DeviceStatusDataSetMax := 5
}
struct GET_DEVICE_INTERNAL_STATUS_DATA_REQUEST {
    Version : UInt32
    Size : UInt32
    RequestDataType : DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE
    RequestDataSet : DEVICE_INTERNAL_STATUS_DATA_SET
}
struct DEVICE_INTERNAL_STATUS_DATA {
    Version : UInt32
    Size : UInt32
    T10VendorId : Int64
    DataSet1Length : UInt32
    DataSet2Length : UInt32
    DataSet3Length : UInt32
    DataSet4Length : UInt32
    StatusDataVersion : UInt8
    Reserved : UInt8[3]
    ReasonIdentifier : UInt8[128]
    StatusDataLength : UInt32
    StatusData : UInt8[1]
}
struct STORAGE_SANITIZE_METHOD extends Int32 {
    static StorageSanitizeMethodDefault := 0
    static StorageSanitizeMethodBlockErase := 1
    static StorageSanitizeMethodCryptoErase := 2
}
struct STORAGE_REINITIALIZE_MEDIA {
    Version : UInt32
    Size : UInt32
    TimeoutInSeconds : UInt32
    SanitizeOption : this._SanitizeOption_e__Struct
    struct _SanitizeOption_e__Struct {
        _bitfield : UInt32
    }
}
struct STORAGE_MEDIA_SERIAL_NUMBER_DATA {
    Reserved : UInt16
    SerialNumberLength : UInt16
    SerialNumber : UInt8[1]
}
struct STORAGE_READ_CAPACITY {
    Version : UInt32
    Size : UInt32
    BlockLength : UInt32
    NumberOfBlocks : Int64
    DiskLength : Int64
}
struct WRITE_CACHE_TYPE extends Int32 {
    static WriteCacheTypeUnknown := 0
    static WriteCacheTypeNone := 1
    static WriteCacheTypeWriteBack := 2
    static WriteCacheTypeWriteThrough := 3
}
struct WRITE_CACHE_ENABLE extends Int32 {
    static WriteCacheEnableUnknown := 0
    static WriteCacheDisabled := 1
    static WriteCacheEnabled := 2
}
struct WRITE_CACHE_CHANGE extends Int32 {
    static WriteCacheChangeUnknown := 0
    static WriteCacheNotChangeable := 1
    static WriteCacheChangeable := 2
}
struct WRITE_THROUGH extends Int32 {
    static WriteThroughUnknown := 0
    static WriteThroughNotSupported := 1
    static WriteThroughSupported := 2
}
struct STORAGE_WRITE_CACHE_PROPERTY {
    Version : UInt32
    Size : UInt32
    WriteCacheType : WRITE_CACHE_TYPE
    WriteCacheEnabled : WRITE_CACHE_ENABLE
    WriteCacheChangeable : WRITE_CACHE_CHANGE
    WriteThroughSupported : WRITE_THROUGH
    FlushCacheSupported : BOOLEAN
    UserDefinedPowerProtection : BOOLEAN
    NVCacheEnabled : BOOLEAN
}
struct PERSISTENT_RESERVE_COMMAND {
    Version : UInt32
    Size : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            PR_IN : this._PR_IN_e__Struct
            PR_OUT : this._PR_OUT_e__Struct
        }
        struct _PR_IN_e__Struct {
            _bitfield : UInt8
            AllocationLength : UInt16
        }
        struct _PR_OUT_e__Struct {
            _bitfield1 : UInt8
            _bitfield2 : UInt8
            ParameterList : UInt8[1]
        }
    }
}
struct DEVICEDUMP_COLLECTION_TYPEIDE_NOTIFICATION_TYPE extends Int32 {
    static TCCollectionBugCheck := 1
    static TCCollectionApplicationRequested := 2
    static TCCollectionDeviceRequested := 3
}
struct DEVICEDUMP_SUBSECTION_POINTER {
    dwSize : UInt32
    dwFlags : UInt32
    dwOffset : UInt32
}
struct DEVICEDUMP_STRUCTURE_VERSION {
    dwSignature : UInt32
    dwVersion : UInt32
    dwSize : UInt32
}
struct DEVICEDUMP_SECTION_HEADER {
    guidDeviceDataId : GUID
    sOrganizationID : UInt8[16]
    dwFirmwareRevision : UInt32
    sModelNumber : UInt8[32]
    szDeviceManufacturingID : UInt8[32]
    dwFlags : UInt32
    bRestrictedPrivateDataVersion : UInt32
    dwFirmwareIssueId : UInt32
    szIssueDescriptionString : UInt8[132]
}
struct GP_LOG_PAGE_DESCRIPTOR {
    LogAddress : UInt16
    LogSectors : UInt16
}
struct DEVICEDUMP_PUBLIC_SUBSECTION {
    dwFlags : UInt32
    GPLogTable : GP_LOG_PAGE_DESCRIPTOR[16]
    szDescription : CHAR[16]
    bData : UInt8[1]
}
struct DEVICEDUMP_RESTRICTED_SUBSECTION {
    bData : UInt8[1]
}
struct DEVICEDUMP_PRIVATE_SUBSECTION {
    dwFlags : UInt32
    GPLogId : GP_LOG_PAGE_DESCRIPTOR
    bData : UInt8[1]
}
struct DEVICEDUMP_STORAGEDEVICE_DATA {
    Descriptor : DEVICEDUMP_STRUCTURE_VERSION
    SectionHeader : DEVICEDUMP_SECTION_HEADER
    dwBufferSize : UInt32
    dwReasonForCollection : UInt32
    PublicData : DEVICEDUMP_SUBSECTION_POINTER
    RestrictedData : DEVICEDUMP_SUBSECTION_POINTER
    PrivateData : DEVICEDUMP_SUBSECTION_POINTER
}
struct DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD {
    Cdb : UInt8[16]
    Command : UInt8[16]
    StartTime : Int64
    EndTime : Int64
    OperationStatus : UInt32
    OperationError : UInt32
    StackSpecific : this._StackSpecific_e__Union
    struct _StackSpecific_e__Union {
        union {
            ExternalStack : this._ExternalStack_e__Struct
            AtaPort : this._AtaPort_e__Struct
            StorPort : this._StorPort_e__Struct
        }
        struct _ExternalStack_e__Struct {
            dwReserved : UInt32
        }
        struct _AtaPort_e__Struct {
            dwAtaPortSpecific : UInt32
        }
        struct _StorPort_e__Struct {
            SrbTag : UInt32
        }
    }
}
struct DEVICEDUMP_STORAGESTACK_PUBLIC_DUMP {
    Descriptor : DEVICEDUMP_STRUCTURE_VERSION
    dwReasonForCollection : UInt32
    cDriverName : UInt8[16]
    uiNumRecords : UInt32
    RecordArray : DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD[1]
}
struct STOR_PAGING_DEVICE_DUMP_ENTRY {
    MiniportName : CHAR[33]
    ModelName : CHAR[65]
    FirmwareRevision : CHAR[17]
    PagingPathCount : UInt16
    Flags : this._Flags_e__Union
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
struct STOR_PAGING_DEVICE_DUMP_DATA {
    Descriptor : DEVICEDUMP_STRUCTURE_VERSION
    EntryCount : UInt32
    EntrySize : UInt32
    Entries : STOR_PAGING_DEVICE_DUMP_ENTRY[1]
}
struct STORAGE_IDLE_POWER {
    Version : UInt32
    Size : UInt32
    _bitfield : UInt32
    D3IdleTimeout : UInt32
}
struct STORAGE_POWERUP_REASON_TYPE extends Int32 {
    static StoragePowerupUnknown := 0
    static StoragePowerupIO := 1
    static StoragePowerupDeviceAttention := 2
}
struct STORAGE_IDLE_POWERUP_REASON {
    Version : UInt32
    Size : UInt32
    PowerupReason : STORAGE_POWERUP_REASON_TYPE
}
struct STORAGE_DEVICE_POWER_CAP_UNITS extends Int32 {
    static StorageDevicePowerCapUnitsPercent := 0
    static StorageDevicePowerCapUnitsMilliwatts := 1
}
struct STORAGE_DEVICE_POWER_CAP {
    Version : UInt32
    Size : UInt32
    Units : STORAGE_DEVICE_POWER_CAP_UNITS
    MaxPower : Int64
}
struct STORAGE_RPMB_DATA_FRAME {
    Stuff : UInt8[196]
    KeyOrMAC : UInt8[32]
    Data : UInt8[256]
    Nonce : UInt8[16]
    WriteCounter : UInt8[4]
    Address : UInt8[2]
    BlockCount : UInt8[2]
    OperationResult : UInt8[2]
    RequestOrResponseType : UInt8[2]
}
struct STORAGE_RPMB_COMMAND_TYPE extends Int32 {
    static StorRpmbProgramAuthKey := 1
    static StorRpmbQueryWriteCounter := 2
    static StorRpmbAuthenticatedWrite := 3
    static StorRpmbAuthenticatedRead := 4
    static StorRpmbReadResultRequest := 5
    static StorRpmbAuthenticatedDeviceConfigWrite := 6
    static StorRpmbAuthenticatedDeviceConfigRead := 7
}
struct STORAGE_EVENT_NOTIFICATION {
    Version : UInt32
    Size : UInt32
    Events : Int64
}
struct STORAGE_COUNTER_TYPE extends Int32 {
    static StorageCounterTypeUnknown := 0
    static StorageCounterTypeTemperatureCelsius := 1
    static StorageCounterTypeTemperatureCelsiusMax := 2
    static StorageCounterTypeReadErrorsTotal := 3
    static StorageCounterTypeReadErrorsCorrected := 4
    static StorageCounterTypeReadErrorsUncorrected := 5
    static StorageCounterTypeWriteErrorsTotal := 6
    static StorageCounterTypeWriteErrorsCorrected := 7
    static StorageCounterTypeWriteErrorsUncorrected := 8
    static StorageCounterTypeManufactureDate := 9
    static StorageCounterTypeStartStopCycleCount := 10
    static StorageCounterTypeStartStopCycleCountMax := 11
    static StorageCounterTypeLoadUnloadCycleCount := 12
    static StorageCounterTypeLoadUnloadCycleCountMax := 13
    static StorageCounterTypeWearPercentage := 14
    static StorageCounterTypeWearPercentageWarning := 15
    static StorageCounterTypeWearPercentageMax := 16
    static StorageCounterTypePowerOnHours := 17
    static StorageCounterTypeReadLatency100NSMax := 18
    static StorageCounterTypeWriteLatency100NSMax := 19
    static StorageCounterTypeFlushLatency100NSMax := 20
    static StorageCounterTypeMax := 21
}
struct STORAGE_COUNTER {
    Type : STORAGE_COUNTER_TYPE
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            ManufactureDate : this._ManufactureDate_e__Struct
            AsUlonglong : Int64
        }
        struct _ManufactureDate_e__Struct {
            Week : UInt32
            Year : UInt32
        }
    }
}
struct STORAGE_COUNTERS {
    Version : UInt32
    Size : UInt32
    NumberOfCounters : UInt32
    Counters : STORAGE_COUNTER[1]
}
struct STORAGE_HW_FIRMWARE_INFO_QUERY {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Reserved : UInt32
}
struct STORAGE_HW_FIRMWARE_SLOT_INFO {
    Version : UInt32
    Size : UInt32
    SlotNumber : UInt8
    _bitfield : UInt8
    Reserved1 : UInt8[6]
    Revision : UInt8[16]
}
struct STORAGE_HW_FIRMWARE_INFO {
    Version : UInt32
    Size : UInt32
    _bitfield : UInt8
    SlotCount : UInt8
    ActiveSlot : UInt8
    PendingActivateSlot : UInt8
    FirmwareShared : BOOLEAN
    Reserved : UInt8[3]
    ImagePayloadAlignment : UInt32
    ImagePayloadMaxSize : UInt32
    Slot : STORAGE_HW_FIRMWARE_SLOT_INFO[1]
}
struct STORAGE_HW_FIRMWARE_DOWNLOAD {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Slot : UInt8
    Reserved : UInt8[3]
    Offset : Int64
    BufferSize : Int64
    ImageBuffer : UInt8[1]
}
struct STORAGE_HW_FIRMWARE_DOWNLOAD_V2 {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Slot : UInt8
    Reserved : UInt8[3]
    Offset : Int64
    BufferSize : Int64
    ImageSize : UInt32
    Reserved2 : UInt32
    ImageBuffer : UInt8[1]
}
struct STORAGE_HW_FIRMWARE_ACTIVATE {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Slot : UInt8
    Reserved0 : UInt8[3]
}
struct STORAGE_HW_BOOT_PARTITION_ACTIVATE {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    BPID : UInt8
    Reserved : UInt8[3]
}
struct STORAGE_HW_BOOT_PARTITION_DOWNLOAD {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    BPID : UInt8
    Reserved : UInt8[3]
    Offset : Int64
    BufferSize : Int64
    ImageBuffer : UInt8[1]
}
struct STORAGE_HW_BOOT_PARTITION_INFO {
    Version : UInt32
    Size : UInt32
    BPSZ : Int64
    Flags : UInt32
    ImagePayloadAlignment : UInt32
    ImagePayloadMaxSize : UInt32
    SlotCount : UInt8
    ABPID : UInt8
}
struct STORAGE_PROTOCOL_COMMAND {
    Version : UInt32
    Length : UInt32
    ProtocolType : STORAGE_PROTOCOL_TYPE
    Flags : UInt32
    ReturnStatus : UInt32
    ErrorCode : UInt32
    CommandLength : UInt32
    ErrorInfoLength : UInt32
    DataToDeviceTransferLength : UInt32
    DataFromDeviceTransferLength : UInt32
    TimeOutValue : UInt32
    ErrorInfoOffset : UInt32
    DataToDeviceBufferOffset : UInt32
    DataFromDeviceBufferOffset : UInt32
    CommandSpecific : UInt32
    Reserved0 : UInt32
    FixedProtocolReturnData : UInt32
    FixedProtocolReturnData2 : UInt32
    Reserved1 : UInt32[2]
    Command : UInt8[1]
}
struct STORAGE_ATTRIBUTE_MGMT_ACTION extends Int32 {
    static StorAttributeMgmt_ClearAttribute := 0
    static StorAttributeMgmt_SetAttribute := 1
    static StorAttributeMgmt_ResetAttribute := 2
}
struct STORAGE_ATTRIBUTE_MGMT {
    Version : UInt32
    Size : UInt32
    Action : STORAGE_ATTRIBUTE_MGMT_ACTION
    Attribute : UInt32
}
struct SCM_PD_HEALTH_NOTIFICATION_DATA {
    DeviceGuid : GUID
}
struct SCM_LOGICAL_DEVICE_INSTANCE {
    Version : UInt32
    Size : UInt32
    DeviceGuid : GUID
    SymbolicLink : UInt16[256]
}
struct SCM_LOGICAL_DEVICES {
    Version : UInt32
    Size : UInt32
    DeviceCount : UInt32
    Devices : SCM_LOGICAL_DEVICE_INSTANCE[1]
}
struct SCM_PHYSICAL_DEVICE_INSTANCE {
    Version : UInt32
    Size : UInt32
    NfitHandle : UInt32
    SymbolicLink : UInt16[256]
}
struct SCM_PHYSICAL_DEVICES {
    Version : UInt32
    Size : UInt32
    DeviceCount : UInt32
    Devices : SCM_PHYSICAL_DEVICE_INSTANCE[1]
}
struct SCM_REGION_FLAG extends Int32 {
    static ScmRegionFlagNone := 0
    static ScmRegionFlagLabel := 1
}
struct SCM_REGION {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    NfitHandle : UInt32
    LogicalDeviceGuid : GUID
    AddressRangeType : GUID
    AssociatedId : UInt32
    Length : Int64
    StartingDPA : Int64
    BaseSPA : Int64
    SPAOffset : Int64
    RegionOffset : Int64
}
struct SCM_REGIONS {
    Version : UInt32
    Size : UInt32
    RegionCount : UInt32
    Regions : SCM_REGION[1]
}
struct SCM_BUS_QUERY_TYPE extends Int32 {
    static ScmBusQuery_Descriptor := 0
    static ScmBusQuery_IsSupported := 1
    static ScmBusQuery_Max := 2
}
struct SCM_BUS_SET_TYPE extends Int32 {
    static ScmBusSet_Descriptor := 0
    static ScmBusSet_IsSupported := 1
    static ScmBusSet_Max := 2
}
struct SCM_BUS_PROPERTY_ID extends Int32 {
    static ScmBusProperty_RuntimeFwActivationInfo := 0
    static ScmBusProperty_DedicatedMemoryInfo := 1
    static ScmBusProperty_DedicatedMemoryState := 2
    static ScmBusProperty_Max := 3
}
struct SCM_BUS_PROPERTY_QUERY {
    Version : UInt32
    Size : UInt32
    PropertyId : SCM_BUS_PROPERTY_ID
    QueryType : SCM_BUS_QUERY_TYPE
    AdditionalParameters : UInt8[1]
}
struct SCM_BUS_FIRMWARE_ACTIVATION_STATE extends Int32 {
    static ScmBusFirmwareActivationState_Idle := 0
    static ScmBusFirmwareActivationState_Armed := 1
    static ScmBusFirmwareActivationState_Busy := 2
}
struct SCM_BUS_RUNTIME_FW_ACTIVATION_INFO {
    Version : UInt32
    Size : UInt32
    RuntimeFwActivationSupported : BOOLEAN
    FirmwareActivationState : SCM_BUS_FIRMWARE_ACTIVATION_STATE
    FirmwareActivationCapability : this._FirmwareActivationCapability_e__Struct
    EstimatedFirmwareActivationTimeInUSecs : Int64
    EstimatedProcessorAccessQuiesceTimeInUSecs : Int64
    EstimatedIOAccessQuiesceTimeInUSecs : Int64
    PlatformSupportedMaxIOAccessQuiesceTimeInUSecs : Int64
    struct _FirmwareActivationCapability_e__Struct {
        _bitfield : UInt32
    }
}
struct SCM_BUS_DEDICATED_MEMORY_DEVICE_INFO {
    DeviceGuid : GUID
    DeviceNumber : UInt32
    Flags : this._Flags_e__Struct
    DeviceSize : Int64
    struct _Flags_e__Struct {
        _bitfield : UInt32
    }
}
struct SCM_BUS_DEDICATED_MEMORY_DEVICES_INFO {
    Version : UInt32
    Size : UInt32
    DeviceCount : UInt32
    Devices : SCM_BUS_DEDICATED_MEMORY_DEVICE_INFO[1]
}
struct SCM_BUS_PROPERTY_SET {
    Version : UInt32
    Size : UInt32
    PropertyId : SCM_BUS_PROPERTY_ID
    SetType : SCM_BUS_SET_TYPE
    AdditionalParameters : UInt8[1]
}
struct SCM_BUS_DEDICATED_MEMORY_STATE {
    ActivateState : BOOLEAN
}
struct SCM_INTERLEAVED_PD_INFO {
    DeviceHandle : UInt32
    DeviceGuid : GUID
}
struct SCM_LD_INTERLEAVE_SET_INFO {
    Version : UInt32
    Size : UInt32
    InterleaveSetSize : UInt32
    InterleaveSet : SCM_INTERLEAVED_PD_INFO[1]
}
struct SCM_PD_QUERY_TYPE extends Int32 {
    static ScmPhysicalDeviceQuery_Descriptor := 0
    static ScmPhysicalDeviceQuery_IsSupported := 1
    static ScmPhysicalDeviceQuery_Max := 2
}
struct SCM_PD_SET_TYPE extends Int32 {
    static ScmPhysicalDeviceSet_Descriptor := 0
    static ScmPhysicalDeviceSet_IsSupported := 1
    static ScmPhysicalDeviceSet_Max := 2
}
struct SCM_PD_PROPERTY_ID extends Int32 {
    static ScmPhysicalDeviceProperty_DeviceInfo := 0
    static ScmPhysicalDeviceProperty_ManagementStatus := 1
    static ScmPhysicalDeviceProperty_FirmwareInfo := 2
    static ScmPhysicalDeviceProperty_LocationString := 3
    static ScmPhysicalDeviceProperty_DeviceSpecificInfo := 4
    static ScmPhysicalDeviceProperty_DeviceHandle := 5
    static ScmPhysicalDeviceProperty_FruIdString := 6
    static ScmPhysicalDeviceProperty_RuntimeFwActivationInfo := 7
    static ScmPhysicalDeviceProperty_RuntimeFwActivationArmState := 8
    static ScmPhysicalDeviceProperty_Max := 9
}
struct SCM_PD_PROPERTY_QUERY {
    Version : UInt32
    Size : UInt32
    PropertyId : SCM_PD_PROPERTY_ID
    QueryType : SCM_PD_QUERY_TYPE
    AdditionalParameters : UInt8[1]
}
struct SCM_PD_PROPERTY_SET {
    Version : UInt32
    Size : UInt32
    PropertyId : SCM_PD_PROPERTY_ID
    SetType : SCM_PD_SET_TYPE
    AdditionalParameters : UInt8[1]
}
struct SCM_PD_RUNTIME_FW_ACTIVATION_ARM_STATE {
    ArmState : BOOLEAN
}
struct SCM_PD_DESCRIPTOR_HEADER {
    Version : UInt32
    Size : UInt32
}
struct SCM_PD_DEVICE_HANDLE {
    Version : UInt32
    Size : UInt32
    DeviceGuid : GUID
    DeviceHandle : UInt32
}
struct SCM_PD_DEVICE_INFO {
    Version : UInt32
    Size : UInt32
    DeviceGuid : GUID
    UnsafeShutdownCount : UInt32
    PersistentMemorySizeInBytes : Int64
    VolatileMemorySizeInBytes : Int64
    TotalMemorySizeInBytes : Int64
    SlotNumber : UInt32
    DeviceHandle : UInt32
    PhysicalId : UInt16
    NumberOfFormatInterfaceCodes : UInt8
    FormatInterfaceCodes : UInt16[8]
    VendorId : UInt32
    ProductId : UInt32
    SubsystemDeviceId : UInt32
    SubsystemVendorId : UInt32
    ManufacturingLocation : UInt8
    ManufacturingWeek : UInt8
    ManufacturingYear : UInt8
    SerialNumber4Byte : UInt32
    SerialNumberLengthInChars : UInt32
    SerialNumber : CHAR[1]
}
struct SCM_PD_DEVICE_SPECIFIC_PROPERTY {
    Name : UInt16[128]
    Value : Int64
}
struct SCM_PD_DEVICE_SPECIFIC_INFO {
    Version : UInt32
    Size : UInt32
    NumberOfProperties : UInt32
    DeviceSpecificProperties : SCM_PD_DEVICE_SPECIFIC_PROPERTY[1]
}
struct SCM_PD_FIRMWARE_SLOT_INFO {
    Version : UInt32
    Size : UInt32
    SlotNumber : UInt8
    _bitfield : UInt8
    Reserved1 : UInt8[6]
    Revision : UInt8[32]
}
struct SCM_PD_FIRMWARE_INFO {
    Version : UInt32
    Size : UInt32
    ActiveSlot : UInt8
    NextActiveSlot : UInt8
    SlotCount : UInt8
    Slots : SCM_PD_FIRMWARE_SLOT_INFO[1]
}
struct SCM_PD_HEALTH_STATUS extends Int32 {
    static ScmPhysicalDeviceHealth_Unknown := 0
    static ScmPhysicalDeviceHealth_Unhealthy := 1
    static ScmPhysicalDeviceHealth_Warning := 2
    static ScmPhysicalDeviceHealth_Healthy := 3
    static ScmPhysicalDeviceHealth_Max := 4
}
struct SCM_PD_OPERATIONAL_STATUS extends Int32 {
    static ScmPhysicalDeviceOpStatus_Unknown := 0
    static ScmPhysicalDeviceOpStatus_Ok := 1
    static ScmPhysicalDeviceOpStatus_PredictingFailure := 2
    static ScmPhysicalDeviceOpStatus_InService := 3
    static ScmPhysicalDeviceOpStatus_HardwareError := 4
    static ScmPhysicalDeviceOpStatus_NotUsable := 5
    static ScmPhysicalDeviceOpStatus_TransientError := 6
    static ScmPhysicalDeviceOpStatus_Missing := 7
    static ScmPhysicalDeviceOpStatus_Max := 8
}
struct SCM_PD_OPERATIONAL_STATUS_REASON extends Int32 {
    static ScmPhysicalDeviceOpReason_Unknown := 0
    static ScmPhysicalDeviceOpReason_Media := 1
    static ScmPhysicalDeviceOpReason_ThresholdExceeded := 2
    static ScmPhysicalDeviceOpReason_LostData := 3
    static ScmPhysicalDeviceOpReason_EnergySource := 4
    static ScmPhysicalDeviceOpReason_Configuration := 5
    static ScmPhysicalDeviceOpReason_DeviceController := 6
    static ScmPhysicalDeviceOpReason_MediaController := 7
    static ScmPhysicalDeviceOpReason_Component := 8
    static ScmPhysicalDeviceOpReason_BackgroundOperation := 9
    static ScmPhysicalDeviceOpReason_InvalidFirmware := 10
    static ScmPhysicalDeviceOpReason_HealthCheck := 11
    static ScmPhysicalDeviceOpReason_LostDataPersistence := 12
    static ScmPhysicalDeviceOpReason_DisabledByPlatform := 13
    static ScmPhysicalDeviceOpReason_PermanentError := 14
    static ScmPhysicalDeviceOpReason_LostWritePersistence := 15
    static ScmPhysicalDeviceOpReason_FatalError := 16
    static ScmPhysicalDeviceOpReason_DataPersistenceLossImminent := 17
    static ScmPhysicalDeviceOpReason_WritePersistenceLossImminent := 18
    static ScmPhysicalDeviceOpReason_MediaRemainingSpareBlock := 19
    static ScmPhysicalDeviceOpReason_PerformanceDegradation := 20
    static ScmPhysicalDeviceOpReason_ExcessiveTemperature := 21
    static ScmPhysicalDeviceOpReason_InternalFailure := 22
    static ScmPhysicalDeviceOpReason_Max := 23
}
struct SCM_PD_MANAGEMENT_STATUS {
    Version : UInt32
    Size : UInt32
    Health : SCM_PD_HEALTH_STATUS
    NumberOfOperationalStatus : UInt32
    NumberOfAdditionalReasons : UInt32
    OperationalStatus : SCM_PD_OPERATIONAL_STATUS[16]
    AdditionalReasons : SCM_PD_OPERATIONAL_STATUS_REASON[1]
}
struct SCM_PD_LOCATION_STRING {
    Version : UInt32
    Size : UInt32
    Location : UInt16[1]
}
struct SCM_PD_FRU_ID_STRING {
    Version : UInt32
    Size : UInt32
    IdentifierSize : UInt32
    Identifier : UInt8[1]
}
struct SCM_PD_FIRMWARE_DOWNLOAD {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Slot : UInt8
    Reserved : UInt8[3]
    Offset : Int64
    FirmwareImageSizeInBytes : UInt32
    FirmwareImage : UInt8[1]
}
struct SCM_PD_FIRMWARE_ACTIVATE {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Slot : UInt8
}
struct SCM_PD_LAST_FW_ACTIVATION_STATUS extends Int32 {
    static ScmPdLastFwActivationStatus_None := 0
    static ScmPdLastFwActivationStatus_Success := 1
    static ScmPdLastFwActivationStatus_FwNotFound := 2
    static ScmPdLastFwActivationStatus_ColdRebootRequired := 3
    static ScmPdLastFwActivaitonStatus_ActivationInProgress := 4
    static ScmPdLastFwActivaitonStatus_Retry := 5
    static ScmPdLastFwActivaitonStatus_FwUnsupported := 6
    static ScmPdLastFwActivaitonStatus_UnknownError := 7
}
struct SCM_PD_FIRMWARE_ACTIVATION_STATE extends Int32 {
    static ScmPdFirmwareActivationState_Idle := 0
    static ScmPdFirmwareActivationState_Armed := 1
    static ScmPdFirmwareActivationState_Busy := 2
}
struct SCM_PD_RUNTIME_FW_ACTIVATION_INFO {
    Version : UInt32
    Size : UInt32
    LastFirmwareActivationStatus : SCM_PD_LAST_FW_ACTIVATION_STATUS
    FirmwareActivationState : SCM_PD_FIRMWARE_ACTIVATION_STATE
}
struct SCM_PD_PASSTHROUGH_INPUT {
    Version : UInt32
    Size : UInt32
    ProtocolGuid : GUID
    DataSize : UInt32
    Data : UInt8[1]
}
struct SCM_PD_PASSTHROUGH_OUTPUT {
    Version : UInt32
    Size : UInt32
    ProtocolGuid : GUID
    DataSize : UInt32
    Data : UInt8[1]
}
struct SCM_PD_PASSTHROUGH_INVDIMM_INPUT {
    Opcode : UInt32
    OpcodeParametersLength : UInt32
    OpcodeParameters : UInt8[1]
}
struct SCM_PD_PASSTHROUGH_INVDIMM_OUTPUT {
    GeneralStatus : UInt16
    ExtendedStatus : UInt16
    OutputDataLength : UInt32
    OutputData : UInt8[1]
}
struct SCM_PD_REINITIALIZE_MEDIA_INPUT {
    Version : UInt32
    Size : UInt32
    Options : this._Options_e__Struct
    struct _Options_e__Struct {
        _bitfield : UInt32
    }
}
struct SCM_PD_MEDIA_REINITIALIZATION_STATUS extends Int32 {
    static ScmPhysicalDeviceReinit_Success := 0
    static ScmPhysicalDeviceReinit_RebootNeeded := 1
    static ScmPhysicalDeviceReinit_ColdBootNeeded := 2
    static ScmPhysicalDeviceReinit_Max := 3
}
struct SCM_PD_REINITIALIZE_MEDIA_OUTPUT {
    Version : UInt32
    Size : UInt32
    Status : SCM_PD_MEDIA_REINITIALIZATION_STATUS
}
struct MEDIA_TYPE extends Int32 {
    static Unknown := 0
    static F5_1Pt2_512 := 1
    static F3_1Pt44_512 := 2
    static F3_2Pt88_512 := 3
    static F3_20Pt8_512 := 4
    static F3_720_512 := 5
    static F5_360_512 := 6
    static F5_320_512 := 7
    static F5_320_1024 := 8
    static F5_180_512 := 9
    static F5_160_512 := 10
    static RemovableMedia := 11
    static FixedMedia := 12
    static F3_120M_512 := 13
    static F3_640_512 := 14
    static F5_640_512 := 15
    static F5_720_512 := 16
    static F3_1Pt2_512 := 17
    static F3_1Pt23_1024 := 18
    static F5_1Pt23_1024 := 19
    static F3_128Mb_512 := 20
    static F3_230Mb_512 := 21
    static F8_256_128 := 22
    static F3_200Mb_512 := 23
    static F3_240M_512 := 24
    static F3_32M_512 := 25
}
struct FORMAT_PARAMETERS {
    MediaType : MEDIA_TYPE
    StartCylinderNumber : UInt32
    EndCylinderNumber : UInt32
    StartHeadNumber : UInt32
    EndHeadNumber : UInt32
}
struct FORMAT_EX_PARAMETERS {
    MediaType : MEDIA_TYPE
    StartCylinderNumber : UInt32
    EndCylinderNumber : UInt32
    StartHeadNumber : UInt32
    EndHeadNumber : UInt32
    FormatGapLength : UInt16
    SectorsPerTrack : UInt16
    SectorNumber : UInt16[1]
}
struct DISK_GEOMETRY {
    Cylinders : Int64
    MediaType : MEDIA_TYPE
    TracksPerCylinder : UInt32
    SectorsPerTrack : UInt32
    BytesPerSector : UInt32
}
struct PARTITION_INFORMATION {
    StartingOffset : Int64
    PartitionLength : Int64
    HiddenSectors : UInt32
    PartitionNumber : UInt32
    PartitionType : UInt8
    BootIndicator : BOOLEAN
    RecognizedPartition : BOOLEAN
    RewritePartition : BOOLEAN
}
struct SET_PARTITION_INFORMATION {
    PartitionType : UInt8
}
struct DRIVE_LAYOUT_INFORMATION {
    PartitionCount : UInt32
    Signature : UInt32
    PartitionEntry : PARTITION_INFORMATION[1]
}
struct VERIFY_INFORMATION {
    StartingOffset : Int64
    Length : UInt32
}
struct REASSIGN_BLOCKS {
    Reserved : UInt16
    Count : UInt16
    BlockNumber : UInt32[1]
}
struct REASSIGN_BLOCKS_EX {
    Reserved : UInt16
    Count : UInt16
    BlockNumber : Int64[1]
}
struct PARTITION_STYLE extends Int32 {
    static PARTITION_STYLE_MBR := 0
    static PARTITION_STYLE_GPT := 1
    static PARTITION_STYLE_RAW := 2
}
struct PARTITION_INFORMATION_GPT {
    PartitionType : GUID
    PartitionId : GUID
    Attributes : GPT_ATTRIBUTES
    Name : UInt16[36]
}
struct PARTITION_INFORMATION_MBR {
    PartitionType : UInt8
    BootIndicator : BOOLEAN
    RecognizedPartition : BOOLEAN
    HiddenSectors : UInt32
    PartitionId : GUID
}
struct SET_PARTITION_INFORMATION_EX {
    PartitionStyle : PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : SET_PARTITION_INFORMATION
            Gpt : PARTITION_INFORMATION_GPT
        }
    }
}
struct CREATE_DISK_GPT {
    DiskId : GUID
    MaxPartitionCount : UInt32
}
struct CREATE_DISK_MBR {
    Signature : UInt32
}
struct CREATE_DISK {
    PartitionStyle : PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : CREATE_DISK_MBR
            Gpt : CREATE_DISK_GPT
        }
    }
}
struct GET_LENGTH_INFORMATION {
    Length : Int64
}
struct PARTITION_INFORMATION_EX {
    PartitionStyle : PARTITION_STYLE
    PartitionOrdinal : UInt16
    StartingOffset : Int64
    PartitionLength : Int64
    PartitionNumber : UInt32
    RewritePartition : BOOLEAN
    IsServicePartition : BOOLEAN
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : PARTITION_INFORMATION_MBR
            Gpt : PARTITION_INFORMATION_GPT
        }
    }
}
struct DRIVE_LAYOUT_INFORMATION_GPT {
    DiskId : GUID
    StartingUsableOffset : Int64
    UsableLength : Int64
    MaxPartitionCount : UInt32
}
struct DRIVE_LAYOUT_INFORMATION_MBR {
    Signature : UInt32
    CheckSum : UInt32
}
struct DRIVE_LAYOUT_INFORMATION_EX {
    PartitionStyle : UInt32
    PartitionCount : UInt32
    Anonymous : this._Anonymous_e__Union
    PartitionEntry : PARTITION_INFORMATION_EX[1]
    struct _Anonymous_e__Union {
        union {
            Mbr : DRIVE_LAYOUT_INFORMATION_MBR
            Gpt : DRIVE_LAYOUT_INFORMATION_GPT
        }
    }
}
struct DETECTION_TYPE extends Int32 {
    static DetectNone := 0
    static DetectInt13 := 1
    static DetectExInt13 := 2
}
struct DISK_INT13_INFO {
    DriveSelect : UInt16
    MaxCylinders : UInt32
    SectorsPerTrack : UInt16
    MaxHeads : UInt16
    NumberDrives : UInt16
}
struct DISK_EX_INT13_INFO {
    ExBufferSize : UInt16
    ExFlags : UInt16
    ExCylinders : UInt32
    ExHeads : UInt32
    ExSectorsPerTrack : UInt32
    ExSectorsPerDrive : Int64
    ExSectorSize : UInt16
    ExReserved : UInt16
}
struct DISK_DETECTION_INFO {
    SizeOfDetectInfo : UInt32
    DetectionType : DETECTION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Int13 : DISK_INT13_INFO
            ExInt13 : DISK_EX_INT13_INFO
        }
    }
}
struct DISK_PARTITION_INFO {
    SizeOfPartitionInfo : UInt32
    PartitionStyle : PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : this._Mbr_e__Struct
            Gpt : this._Gpt_e__Struct
        }
        struct _Mbr_e__Struct {
            Signature : UInt32
            CheckSum : UInt32
        }
        struct _Gpt_e__Struct {
            DiskId : GUID
        }
    }
}
struct DISK_GEOMETRY_EX {
    Geometry : DISK_GEOMETRY
    DiskSize : Int64
    Data : UInt8[1]
}
struct DISK_CONTROLLER_NUMBER {
    ControllerNumber : UInt32
    DiskNumber : UInt32
}
struct DISK_CACHE_RETENTION_PRIORITY extends Int32 {
    static EqualPriority := 0
    static KeepPrefetchedData := 1
    static KeepReadData := 2
}
struct DISK_CACHE_INFORMATION {
    ParametersSavable : BOOLEAN
    ReadCacheEnabled : BOOLEAN
    WriteCacheEnabled : BOOLEAN
    ReadRetentionPriority : DISK_CACHE_RETENTION_PRIORITY
    WriteRetentionPriority : DISK_CACHE_RETENTION_PRIORITY
    DisablePrefetchTransferLength : UInt16
    PrefetchScalar : BOOLEAN
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ScalarPrefetch : this._ScalarPrefetch_e__Struct
            BlockPrefetch : this._BlockPrefetch_e__Struct
        }
        struct _ScalarPrefetch_e__Struct {
            Minimum : UInt16
            Maximum : UInt16
            MaximumBlocks : UInt16
        }
        struct _BlockPrefetch_e__Struct {
            Minimum : UInt16
            Maximum : UInt16
        }
    }
}
struct DISK_GROW_PARTITION {
    PartitionNumber : UInt32
    BytesToGrow : Int64
}
struct HISTOGRAM_BUCKET {
    Reads : UInt32
    Writes : UInt32
}
struct DISK_HISTOGRAM {
    DiskSize : Int64
    Start : Int64
    End : Int64
    Average : Int64
    AverageRead : Int64
    AverageWrite : Int64
    Granularity : UInt32
    Size : UInt32
    ReadCount : UInt32
    WriteCount : UInt32
    Histogram : HISTOGRAM_BUCKET.Ptr
}
struct DISK_PERFORMANCE {
    BytesRead : Int64
    BytesWritten : Int64
    ReadTime : Int64
    WriteTime : Int64
    IdleTime : Int64
    ReadCount : UInt32
    WriteCount : UInt32
    QueueDepth : UInt32
    SplitCount : UInt32
    QueryTime : Int64
    StorageDeviceNumber : UInt32
    StorageManagerName : UInt16[8]
}
struct DISK_RECORD {
    ByteOffset : Int64
    StartTime : Int64
    EndTime : Int64
    VirtualAddress : Struct.Ptr
    NumberOfBytes : UInt32
    DeviceNumber : UInt8
    ReadRequest : BOOLEAN
}
struct DISK_LOGGING {
    Function : UInt8
    BufferAddress : Struct.Ptr
    BufferSize : UInt32
}
struct BIN_TYPES extends Int32 {
    static RequestSize := 0
    static RequestLocation := 1
}
struct BIN_RANGE {
    StartValue : Int64
    Length : Int64
}
struct PERF_BIN {
    NumberOfBins : UInt32
    TypeOfBin : UInt32
    BinsRanges : BIN_RANGE[1]
}
struct BIN_COUNT {
    BinRange : BIN_RANGE
    BinCount : UInt32
}
struct BIN_RESULTS {
    NumberOfBins : UInt32
    BinCounts : BIN_COUNT[1]
}
struct GETVERSIONINPARAMS {
    bVersion : UInt8
    bRevision : UInt8
    bReserved : UInt8
    bIDEDeviceMap : UInt8
    fCapabilities : UInt32
    dwReserved : UInt32[4]
}
struct IDEREGS {
    bFeaturesReg : UInt8
    bSectorCountReg : UInt8
    bSectorNumberReg : UInt8
    bCylLowReg : UInt8
    bCylHighReg : UInt8
    bDriveHeadReg : UInt8
    bCommandReg : UInt8
    bReserved : UInt8
}
struct SENDCMDINPARAMS {
    cBufferSize : UInt32
    irDriveRegs : IDEREGS
    bDriveNumber : UInt8
    bReserved : UInt8[3]
    dwReserved : UInt32[4]
    bBuffer : UInt8[1]
}
struct DRIVERSTATUS {
    bDriverError : UInt8
    bIDEError : UInt8
    bReserved : UInt8[2]
    dwReserved : UInt32[2]
}
struct SENDCMDOUTPARAMS {
    cBufferSize : UInt32
    DriverStatus : DRIVERSTATUS
    bBuffer : UInt8[1]
}
struct GET_DISK_ATTRIBUTES {
    Version : UInt32
    Reserved1 : UInt32
    Attributes : Int64
}
struct SET_DISK_ATTRIBUTES {
    Version : UInt32
    Persist : BOOLEAN
    Reserved1 : UInt8[3]
    Attributes : Int64
    AttributesMask : Int64
    Reserved2 : UInt32[4]
}
struct ELEMENT_TYPE extends Int32 {
    static AllElements := 0
    static ChangerTransport := 1
    static ChangerSlot := 2
    static ChangerIEPort := 3
    static ChangerDrive := 4
    static ChangerDoor := 5
    static ChangerKeypad := 6
    static ChangerMaxElement := 7
}
struct CHANGER_ELEMENT {
    ElementType : ELEMENT_TYPE
    ElementAddress : UInt32
}
struct CHANGER_ELEMENT_LIST {
    Element : CHANGER_ELEMENT
    NumberOfElements : UInt32
}
struct GET_CHANGER_PARAMETERS {
    Size : UInt32
    NumberTransportElements : UInt16
    NumberStorageElements : UInt16
    NumberCleanerSlots : UInt16
    NumberIEElements : UInt16
    NumberDataTransferElements : UInt16
    NumberOfDoors : UInt16
    FirstSlotNumber : UInt16
    FirstDriveNumber : UInt16
    FirstTransportNumber : UInt16
    FirstIEPortNumber : UInt16
    FirstCleanerSlotAddress : UInt16
    MagazineSize : UInt16
    DriveCleanTimeout : UInt32
    Features0 : CHANGER_FEATURES
    Features1 : GET_CHANGER_PARAMETERS_FEATURES1
    MoveFromTransport : UInt8
    MoveFromSlot : UInt8
    MoveFromIePort : UInt8
    MoveFromDrive : UInt8
    ExchangeFromTransport : UInt8
    ExchangeFromSlot : UInt8
    ExchangeFromIePort : UInt8
    ExchangeFromDrive : UInt8
    LockUnlockCapabilities : UInt8
    PositionCapabilities : UInt8
    Reserved1 : UInt8[2]
    Reserved2 : UInt32[2]
}
struct CHANGER_PRODUCT_DATA {
    VendorId : UInt8[8]
    ProductId : UInt8[16]
    Revision : UInt8[4]
    SerialNumber : UInt8[32]
    DeviceType : UInt8
}
struct CHANGER_SET_ACCESS {
    Element : CHANGER_ELEMENT
    Control : UInt32
}
struct CHANGER_READ_ELEMENT_STATUS {
    ElementList : CHANGER_ELEMENT_LIST
    VolumeTagInfo : BOOLEAN
}
struct CHANGER_ELEMENT_STATUS {
    Element : CHANGER_ELEMENT
    SrcElementAddress : CHANGER_ELEMENT
    Flags : CHANGER_ELEMENT_STATUS_FLAGS
    ExceptionCode : UInt32
    TargetId : UInt8
    Lun : UInt8
    Reserved : UInt16
    PrimaryVolumeID : UInt8[36]
    AlternateVolumeID : UInt8[36]
}
struct CHANGER_ELEMENT_STATUS_EX {
    Element : CHANGER_ELEMENT
    SrcElementAddress : CHANGER_ELEMENT
    Flags : CHANGER_ELEMENT_STATUS_FLAGS
    ExceptionCode : UInt32
    TargetId : UInt8
    Lun : UInt8
    Reserved : UInt16
    PrimaryVolumeID : UInt8[36]
    AlternateVolumeID : UInt8[36]
    VendorIdentification : UInt8[8]
    ProductIdentification : UInt8[16]
    SerialNumber : UInt8[32]
}
struct CHANGER_INITIALIZE_ELEMENT_STATUS {
    ElementList : CHANGER_ELEMENT_LIST
    BarCodeScan : BOOLEAN
}
struct CHANGER_SET_POSITION {
    Transport : CHANGER_ELEMENT
    Destination : CHANGER_ELEMENT
    Flip : BOOLEAN
}
struct CHANGER_EXCHANGE_MEDIUM {
    Transport : CHANGER_ELEMENT
    Source : CHANGER_ELEMENT
    Destination1 : CHANGER_ELEMENT
    Destination2 : CHANGER_ELEMENT
    Flip1 : BOOLEAN
    Flip2 : BOOLEAN
}
struct CHANGER_MOVE_MEDIUM {
    Transport : CHANGER_ELEMENT
    Source : CHANGER_ELEMENT
    Destination : CHANGER_ELEMENT
    Flip : BOOLEAN
}
struct CHANGER_SEND_VOLUME_TAG_INFORMATION {
    StartingElement : CHANGER_ELEMENT
    ActionCode : UInt32
    VolumeIDTemplate : UInt8[40]
}
struct READ_ELEMENT_ADDRESS_INFO {
    NumberOfElements : UInt32
    ElementStatus : CHANGER_ELEMENT_STATUS[1]
}
struct CHANGER_DEVICE_PROBLEM_TYPE extends Int32 {
    static DeviceProblemNone := 0
    static DeviceProblemHardware := 1
    static DeviceProblemCHMError := 2
    static DeviceProblemDoorOpen := 3
    static DeviceProblemCalibrationError := 4
    static DeviceProblemTargetFailure := 5
    static DeviceProblemCHMMoveError := 6
    static DeviceProblemCHMZeroError := 7
    static DeviceProblemCartridgeInsertError := 8
    static DeviceProblemPositionError := 9
    static DeviceProblemSensorError := 10
    static DeviceProblemCartridgeEjectError := 11
    static DeviceProblemGripperError := 12
    static DeviceProblemDriveError := 13
}
struct PATHNAME_BUFFER {
    PathNameLength : UInt32
    Name : UInt16[1]
}
struct FSCTL_QUERY_FAT_BPB_BUFFER {
    First0x24BytesOfBootSector : UInt8[36]
}
struct NTFS_VOLUME_DATA_BUFFER {
    VolumeSerialNumber : Int64
    NumberSectors : Int64
    TotalClusters : Int64
    FreeClusters : Int64
    TotalReserved : Int64
    BytesPerSector : UInt32
    BytesPerCluster : UInt32
    BytesPerFileRecordSegment : UInt32
    ClustersPerFileRecordSegment : UInt32
    MftValidDataLength : Int64
    MftStartLcn : Int64
    Mft2StartLcn : Int64
    MftZoneStart : Int64
    MftZoneEnd : Int64
}
struct NTFS_EXTENDED_VOLUME_DATA {
    ByteCount : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    BytesPerPhysicalSector : UInt32
    LfsMajorVersion : UInt16
    LfsMinorVersion : UInt16
    MaxDeviceTrimExtentCount : UInt32
    MaxDeviceTrimByteCount : UInt32
    MaxVolumeTrimExtentCount : UInt32
    MaxVolumeTrimByteCount : UInt32
}
struct REFS_VOLUME_DATA_BUFFER {
    ByteCount : UInt32
    MajorVersion : UInt32
    MinorVersion : UInt32
    BytesPerPhysicalSector : UInt32
    VolumeSerialNumber : Int64
    NumberSectors : Int64
    TotalClusters : Int64
    FreeClusters : Int64
    TotalReserved : Int64
    BytesPerSector : UInt32
    BytesPerCluster : UInt32
    MaximumSizeOfResidentFile : Int64
    FastTierDataFillRatio : UInt16
    SlowTierDataFillRatio : UInt16
    DestagesFastTierToSlowTierRate : UInt32
    MetadataChecksumType : UInt16
    Reserved0 : UInt8[6]
    DriverMajorVersion : UInt32
    DriverMinorVersion : UInt32
    Reserved : Int64[7]
}
struct STARTING_LCN_INPUT_BUFFER {
    StartingLcn : Int64
}
struct STARTING_LCN_INPUT_BUFFER_EX {
    StartingLcn : Int64
    Flags : UInt32
}
struct VOLUME_BITMAP_BUFFER {
    StartingLcn : Int64
    BitmapSize : Int64
    Buffer : UInt8[1]
}
struct STARTING_VCN_INPUT_BUFFER {
    StartingVcn : Int64
}
struct RETRIEVAL_POINTERS_BUFFER {
    ExtentCount : UInt32
    StartingVcn : Int64
    Extents : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        NextVcn : Int64
        Lcn : Int64
    }
}
struct RETRIEVAL_POINTERS_AND_REFCOUNT_BUFFER {
    ExtentCount : UInt32
    StartingVcn : Int64
    Extents : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        NextVcn : Int64
        Lcn : Int64
        ReferenceCount : UInt32
    }
}
struct RETRIEVAL_POINTER_COUNT {
    ExtentCount : UInt32
}
struct NTFS_FILE_RECORD_INPUT_BUFFER {
    FileReferenceNumber : Int64
}
struct NTFS_FILE_RECORD_OUTPUT_BUFFER {
    FileReferenceNumber : Int64
    FileRecordLength : UInt32
    FileRecordBuffer : UInt8[1]
}
struct MOVE_FILE_DATA {
    FileHandle : HANDLE
    StartingVcn : Int64
    StartingLcn : Int64
    ClusterCount : UInt32
}
struct MOVE_FILE_RECORD_DATA {
    FileHandle : HANDLE
    SourceFileRecord : Int64
    TargetFileRecord : Int64
}
struct FIND_BY_SID_DATA {
    Restart : UInt32
    Sid : SID
}
struct FIND_BY_SID_OUTPUT {
    NextEntryOffset : UInt32
    FileIndex : UInt32
    FileNameLength : UInt32
    FileName : UInt16[1]
}
struct MFT_ENUM_DATA_V0 {
    StartFileReferenceNumber : Int64
    LowUsn : Int64
    HighUsn : Int64
}
struct MFT_ENUM_DATA_V1 {
    StartFileReferenceNumber : Int64
    LowUsn : Int64
    HighUsn : Int64
    MinMajorVersion : UInt16
    MaxMajorVersion : UInt16
}
struct CREATE_USN_JOURNAL_DATA {
    MaximumSize : Int64
    AllocationDelta : Int64
}
struct READ_FILE_USN_DATA {
    MinMajorVersion : UInt16
    MaxMajorVersion : UInt16
}
struct READ_USN_JOURNAL_DATA_V0 {
    StartUsn : Int64
    ReasonMask : UInt32
    ReturnOnlyOnClose : UInt32
    Timeout : Int64
    BytesToWaitFor : Int64
    UsnJournalID : Int64
}
struct READ_USN_JOURNAL_DATA_V1 {
    StartUsn : Int64
    ReasonMask : UInt32
    ReturnOnlyOnClose : UInt32
    Timeout : Int64
    BytesToWaitFor : Int64
    UsnJournalID : Int64
    MinMajorVersion : UInt16
    MaxMajorVersion : UInt16
}
struct USN_TRACK_MODIFIED_RANGES {
    Flags : UInt32
    Unused : UInt32
    ChunkSize : Int64
    FileSizeThreshold : Int64
}
struct USN_RANGE_TRACK_OUTPUT {
    Usn : Int64
}
struct USN_RECORD_V2 {
    RecordLength : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    FileReferenceNumber : Int64
    ParentFileReferenceNumber : Int64
    Usn : Int64
    TimeStamp : Int64
    Reason : UInt32
    SourceInfo : UInt32
    SecurityId : UInt32
    FileAttributes : UInt32
    FileNameLength : UInt16
    FileNameOffset : UInt16
    FileName : UInt16[1]
}
struct USN_RECORD_V3 {
    RecordLength : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    FileReferenceNumber : FILE_ID_128
    ParentFileReferenceNumber : FILE_ID_128
    Usn : Int64
    TimeStamp : Int64
    Reason : UInt32
    SourceInfo : UInt32
    SecurityId : UInt32
    FileAttributes : UInt32
    FileNameLength : UInt16
    FileNameOffset : UInt16
    FileName : UInt16[1]
}
struct USN_RECORD_COMMON_HEADER {
    RecordLength : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct USN_RECORD_EXTENT {
    Offset : Int64
    Length : Int64
}
struct USN_RECORD_V4 {
    Header : USN_RECORD_COMMON_HEADER
    FileReferenceNumber : FILE_ID_128
    ParentFileReferenceNumber : FILE_ID_128
    Usn : Int64
    Reason : UInt32
    SourceInfo : USN_SOURCE_INFO_ID
    RemainingExtents : UInt32
    NumberOfExtents : UInt16
    ExtentSize : UInt16
    Extents : USN_RECORD_EXTENT[1]
}
struct USN_RECORD_UNION {
    union {
        Header : USN_RECORD_COMMON_HEADER
        V2 : USN_RECORD_V2
        V3 : USN_RECORD_V3
        V4 : USN_RECORD_V4
    }
}
struct USN_JOURNAL_DATA_V0 {
    UsnJournalID : Int64
    FirstUsn : Int64
    NextUsn : Int64
    LowestValidUsn : Int64
    MaxUsn : Int64
    MaximumSize : Int64
    AllocationDelta : Int64
}
struct USN_JOURNAL_DATA_V1 {
    UsnJournalID : Int64
    FirstUsn : Int64
    NextUsn : Int64
    LowestValidUsn : Int64
    MaxUsn : Int64
    MaximumSize : Int64
    AllocationDelta : Int64
    MinSupportedMajorVersion : UInt16
    MaxSupportedMajorVersion : UInt16
}
struct USN_JOURNAL_DATA_V2 {
    UsnJournalID : Int64
    FirstUsn : Int64
    NextUsn : Int64
    LowestValidUsn : Int64
    MaxUsn : Int64
    MaximumSize : Int64
    AllocationDelta : Int64
    MinSupportedMajorVersion : UInt16
    MaxSupportedMajorVersion : UInt16
    Flags : UInt32
    RangeTrackChunkSize : Int64
    RangeTrackFileSizeThreshold : Int64
}
struct DELETE_USN_JOURNAL_DATA {
    UsnJournalID : Int64
    DeleteFlags : USN_DELETE_FLAGS
}
struct MARK_HANDLE_INFO {
    Anonymous : this._Anonymous_e__Union
    VolumeHandle : HANDLE
    HandleInfo : UInt32
    struct _Anonymous_e__Union {
        union {
            UsnSourceInfo : UInt32
            CopyNumber : UInt32
        }
    }
}
struct BULK_SECURITY_TEST_DATA {
    DesiredAccess : UInt32
    SecurityIds : UInt32[1]
}
struct FILE_PREFETCH {
    Type : UInt32
    Count : UInt32
    Prefetch : Int64[1]
}
struct FILE_PREFETCH_EX {
    Type : UInt32
    Count : UInt32
    Context : Struct.Ptr
    Prefetch : Int64[1]
}
struct FILESYSTEM_STATISTICS {
    FileSystemType : FILESYSTEM_STATISTICS_TYPE
    Version : UInt16
    SizeOfCompleteStructure : UInt32
    UserFileReads : UInt32
    UserFileReadBytes : UInt32
    UserDiskReads : UInt32
    UserFileWrites : UInt32
    UserFileWriteBytes : UInt32
    UserDiskWrites : UInt32
    MetaDataReads : UInt32
    MetaDataReadBytes : UInt32
    MetaDataDiskReads : UInt32
    MetaDataWrites : UInt32
    MetaDataWriteBytes : UInt32
    MetaDataDiskWrites : UInt32
}
struct FAT_STATISTICS {
    CreateHits : UInt32
    SuccessfulCreates : UInt32
    FailedCreates : UInt32
    NonCachedReads : UInt32
    NonCachedReadBytes : UInt32
    NonCachedWrites : UInt32
    NonCachedWriteBytes : UInt32
    NonCachedDiskReads : UInt32
    NonCachedDiskWrites : UInt32
}
struct EXFAT_STATISTICS {
    CreateHits : UInt32
    SuccessfulCreates : UInt32
    FailedCreates : UInt32
    NonCachedReads : UInt32
    NonCachedReadBytes : UInt32
    NonCachedWrites : UInt32
    NonCachedWriteBytes : UInt32
    NonCachedDiskReads : UInt32
    NonCachedDiskWrites : UInt32
}
struct NTFS_STATISTICS {
    LogFileFullExceptions : UInt32
    OtherExceptions : UInt32
    MftReads : UInt32
    MftReadBytes : UInt32
    MftWrites : UInt32
    MftWriteBytes : UInt32
    MftWritesUserLevel : this._MftWritesUserLevel_e__Struct
    MftWritesFlushForLogFileFull : UInt16
    MftWritesLazyWriter : UInt16
    MftWritesUserRequest : UInt16
    Mft2Writes : UInt32
    Mft2WriteBytes : UInt32
    Mft2WritesUserLevel : this._Mft2WritesUserLevel_e__Struct
    Mft2WritesFlushForLogFileFull : UInt16
    Mft2WritesLazyWriter : UInt16
    Mft2WritesUserRequest : UInt16
    RootIndexReads : UInt32
    RootIndexReadBytes : UInt32
    RootIndexWrites : UInt32
    RootIndexWriteBytes : UInt32
    BitmapReads : UInt32
    BitmapReadBytes : UInt32
    BitmapWrites : UInt32
    BitmapWriteBytes : UInt32
    BitmapWritesFlushForLogFileFull : UInt16
    BitmapWritesLazyWriter : UInt16
    BitmapWritesUserRequest : UInt16
    BitmapWritesUserLevel : this._BitmapWritesUserLevel_e__Struct
    MftBitmapReads : UInt32
    MftBitmapReadBytes : UInt32
    MftBitmapWrites : UInt32
    MftBitmapWriteBytes : UInt32
    MftBitmapWritesFlushForLogFileFull : UInt16
    MftBitmapWritesLazyWriter : UInt16
    MftBitmapWritesUserRequest : UInt16
    MftBitmapWritesUserLevel : this._MftBitmapWritesUserLevel_e__Struct
    UserIndexReads : UInt32
    UserIndexReadBytes : UInt32
    UserIndexWrites : UInt32
    UserIndexWriteBytes : UInt32
    LogFileReads : UInt32
    LogFileReadBytes : UInt32
    LogFileWrites : UInt32
    LogFileWriteBytes : UInt32
    Allocate : this._Allocate_e__Struct
    DiskResourcesExhausted : UInt32
    struct _MftWritesUserLevel_e__Struct {
        Write : UInt16
        Create : UInt16
        SetInfo : UInt16
        Flush : UInt16
    }
    struct _Mft2WritesUserLevel_e__Struct {
        Write : UInt16
        Create : UInt16
        SetInfo : UInt16
        Flush : UInt16
    }
    struct _BitmapWritesUserLevel_e__Struct {
        Write : UInt16
        Create : UInt16
        SetInfo : UInt16
    }
    struct _MftBitmapWritesUserLevel_e__Struct {
        Write : UInt16
        Create : UInt16
        SetInfo : UInt16
        Flush : UInt16
    }
    struct _Allocate_e__Struct {
        Calls : UInt32
        Clusters : UInt32
        Hints : UInt32
        RunsReturned : UInt32
        HintsHonored : UInt32
        HintsClusters : UInt32
        Cache : UInt32
        CacheClusters : UInt32
        CacheMiss : UInt32
        CacheMissClusters : UInt32
    }
}
struct FILESYSTEM_STATISTICS_EX {
    FileSystemType : FILESYSTEM_STATISTICS_TYPE
    Version : UInt16
    SizeOfCompleteStructure : UInt32
    UserFileReads : Int64
    UserFileReadBytes : Int64
    UserDiskReads : Int64
    UserFileWrites : Int64
    UserFileWriteBytes : Int64
    UserDiskWrites : Int64
    MetaDataReads : Int64
    MetaDataReadBytes : Int64
    MetaDataDiskReads : Int64
    MetaDataWrites : Int64
    MetaDataWriteBytes : Int64
    MetaDataDiskWrites : Int64
}
struct NTFS_STATISTICS_EX {
    LogFileFullExceptions : UInt32
    OtherExceptions : UInt32
    MftReads : Int64
    MftReadBytes : Int64
    MftWrites : Int64
    MftWriteBytes : Int64
    MftWritesUserLevel : this._MftWritesUserLevel_e__Struct
    MftWritesFlushForLogFileFull : UInt32
    MftWritesLazyWriter : UInt32
    MftWritesUserRequest : UInt32
    Mft2Writes : Int64
    Mft2WriteBytes : Int64
    Mft2WritesUserLevel : this._Mft2WritesUserLevel_e__Struct
    Mft2WritesFlushForLogFileFull : UInt32
    Mft2WritesLazyWriter : UInt32
    Mft2WritesUserRequest : UInt32
    RootIndexReads : Int64
    RootIndexReadBytes : Int64
    RootIndexWrites : Int64
    RootIndexWriteBytes : Int64
    BitmapReads : Int64
    BitmapReadBytes : Int64
    BitmapWrites : Int64
    BitmapWriteBytes : Int64
    BitmapWritesFlushForLogFileFull : UInt32
    BitmapWritesLazyWriter : UInt32
    BitmapWritesUserRequest : UInt32
    BitmapWritesUserLevel : this._BitmapWritesUserLevel_e__Struct
    MftBitmapReads : Int64
    MftBitmapReadBytes : Int64
    MftBitmapWrites : Int64
    MftBitmapWriteBytes : Int64
    MftBitmapWritesFlushForLogFileFull : UInt32
    MftBitmapWritesLazyWriter : UInt32
    MftBitmapWritesUserRequest : UInt32
    MftBitmapWritesUserLevel : this._MftBitmapWritesUserLevel_e__Struct
    UserIndexReads : Int64
    UserIndexReadBytes : Int64
    UserIndexWrites : Int64
    UserIndexWriteBytes : Int64
    LogFileReads : Int64
    LogFileReadBytes : Int64
    LogFileWrites : Int64
    LogFileWriteBytes : Int64
    Allocate : this._Allocate_e__Struct
    DiskResourcesExhausted : UInt32
    VolumeTrimCount : Int64
    VolumeTrimTime : Int64
    VolumeTrimByteCount : Int64
    FileLevelTrimCount : Int64
    FileLevelTrimTime : Int64
    FileLevelTrimByteCount : Int64
    VolumeTrimSkippedCount : Int64
    VolumeTrimSkippedByteCount : Int64
    NtfsFillStatInfoFromMftRecordCalledCount : Int64
    NtfsFillStatInfoFromMftRecordBailedBecauseOfAttributeListCount : Int64
    NtfsFillStatInfoFromMftRecordBailedBecauseOfNonResReparsePointCount : Int64
    struct _MftWritesUserLevel_e__Struct {
        Write : UInt32
        Create : UInt32
        SetInfo : UInt32
        Flush : UInt32
    }
    struct _Mft2WritesUserLevel_e__Struct {
        Write : UInt32
        Create : UInt32
        SetInfo : UInt32
        Flush : UInt32
    }
    struct _BitmapWritesUserLevel_e__Struct {
        Write : UInt32
        Create : UInt32
        SetInfo : UInt32
        Flush : UInt32
    }
    struct _MftBitmapWritesUserLevel_e__Struct {
        Write : UInt32
        Create : UInt32
        SetInfo : UInt32
        Flush : UInt32
    }
    struct _Allocate_e__Struct {
        Calls : UInt32
        RunsReturned : UInt32
        Hints : UInt32
        HintsHonored : UInt32
        Cache : UInt32
        CacheMiss : UInt32
        Clusters : Int64
        HintsClusters : Int64
        CacheClusters : Int64
        CacheMissClusters : Int64
    }
}
struct FILE_OBJECTID_BUFFER {
    ObjectId : UInt8[16]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ExtendedInfo : UInt8[48]
        }
        struct _Anonymous_e__Struct {
            BirthVolumeId : UInt8[16]
            BirthObjectId : UInt8[16]
            DomainId : UInt8[16]
        }
    }
}
struct FILE_SET_SPARSE_BUFFER {
    SetSparse : BOOLEAN
}
struct FILE_ZERO_DATA_INFORMATION {
    FileOffset : Int64
    BeyondFinalZero : Int64
}
struct FILE_ZERO_DATA_INFORMATION_EX {
    FileOffset : Int64
    BeyondFinalZero : Int64
    Flags : UInt32
}
struct FILE_ALLOCATED_RANGE_BUFFER {
    FileOffset : Int64
    Length : Int64
}
struct ENCRYPTION_BUFFER {
    EncryptionOperation : UInt32
    Private : UInt8[1]
}
struct DECRYPTION_STATUS_BUFFER {
    NoEncryptedStreams : BOOLEAN
}
struct REQUEST_RAW_ENCRYPTED_DATA {
    FileOffset : Int64
    Length : UInt32
}
struct ENCRYPTED_DATA_INFO {
    StartingFileOffset : Int64
    OutputBufferOffset : UInt32
    BytesWithinFileSize : UInt32
    BytesWithinValidDataLength : UInt32
    CompressionFormat : UInt16
    DataUnitShift : UInt8
    ChunkShift : UInt8
    ClusterShift : UInt8
    EncryptionFormat : UInt8
    NumberOfDataBlocks : UInt16
    DataBlockSize : UInt32[1]
}
struct EXTENDED_ENCRYPTED_DATA_INFO {
    ExtendedCode : UInt32
    Length : UInt32
    Flags : UInt32
    Reserved : UInt32
}
struct PLEX_READ_DATA_REQUEST {
    ByteOffset : Int64
    ByteLength : UInt32
    PlexNumber : UInt32
}
struct SI_COPYFILE {
    SourceFileNameLength : UInt32
    DestinationFileNameLength : UInt32
    Flags : UInt32
    FileNameBuffer : UInt16[1]
}
struct FILE_MAKE_COMPATIBLE_BUFFER {
    CloseDisc : BOOLEAN
}
struct FILE_SET_DEFECT_MGMT_BUFFER {
    Disable : BOOLEAN
}
struct FILE_QUERY_SPARING_BUFFER {
    SparingUnitBytes : UInt32
    SoftwareSparing : BOOLEAN
    TotalSpareBlocks : UInt32
    FreeSpareBlocks : UInt32
}
struct FILE_QUERY_ON_DISK_VOL_INFO_BUFFER {
    DirectoryCount : Int64
    FileCount : Int64
    FsFormatMajVersion : UInt16
    FsFormatMinVersion : UInt16
    FsFormatName : UInt16[12]
    FormatTime : Int64
    LastUpdateTime : Int64
    CopyrightInfo : UInt16[34]
    AbstractInfo : UInt16[34]
    FormattingImplementationInfo : UInt16[34]
    LastModifyingImplementationInfo : UInt16[34]
}
struct FILE_INITIATE_REPAIR_OUTPUT_BUFFER {
    Hint1 : Int64
    Hint2 : Int64
    Clsn : Int64
    Status : UInt32
}
struct SHRINK_VOLUME_REQUEST_TYPES extends Int32 {
    static ShrinkPrepare := 1
    static ShrinkCommit := 2
    static ShrinkAbort := 3
}
struct SHRINK_VOLUME_INFORMATION {
    ShrinkRequestType : SHRINK_VOLUME_REQUEST_TYPES
    Flags : Int64
    NewNumberOfSectors : Int64
}
struct TXFS_MODIFY_RM {
    Flags : TXFS_RMF_LAGS
    LogContainerCountMax : UInt32
    LogContainerCountMin : UInt32
    LogContainerCount : UInt32
    LogGrowthIncrement : UInt32
    LogAutoShrinkPercentage : UInt32
    Reserved : Int64
    LoggingMode : UInt16
}
struct TXFS_QUERY_RM_INFORMATION {
    BytesRequired : UInt32
    TailLsn : Int64
    CurrentLsn : Int64
    ArchiveTailLsn : Int64
    LogContainerSize : Int64
    HighestVirtualClock : Int64
    LogContainerCount : UInt32
    LogContainerCountMax : UInt32
    LogContainerCountMin : UInt32
    LogGrowthIncrement : UInt32
    LogAutoShrinkPercentage : UInt32
    Flags : TXFS_RMF_LAGS
    LoggingMode : UInt16
    Reserved : UInt16
    RmState : UInt32
    LogCapacity : Int64
    LogFree : Int64
    TopsSize : Int64
    TopsUsed : Int64
    TransactionCount : Int64
    OnePCCount : Int64
    TwoPCCount : Int64
    NumberLogFileFull : Int64
    OldestTransactionAge : Int64
    RMName : GUID
    TmLogPathOffset : UInt32
}
struct TXFS_ROLLFORWARD_REDO_INFORMATION {
    LastVirtualClock : Int64
    LastRedoLsn : Int64
    HighestRecoveryLsn : Int64
    Flags : UInt32
}
struct TXFS_START_RM_INFORMATION {
    Flags : UInt32
    LogContainerSize : Int64
    LogContainerCountMin : UInt32
    LogContainerCountMax : UInt32
    LogGrowthIncrement : UInt32
    LogAutoShrinkPercentage : UInt32
    TmLogPathOffset : UInt32
    TmLogPathLength : UInt16
    LoggingMode : UInt16
    LogPathLength : UInt16
    Reserved : UInt16
    LogPath : UInt16[1]
}
struct TXFS_GET_METADATA_INFO_OUT {
    TxfFileId : this._TxfFileId_e__Struct
    LockingTransaction : GUID
    LastLsn : Int64
    TransactionState : UInt32
    struct _TxfFileId_e__Struct {
        LowPart : Int64
        HighPart : Int64
    }
}
struct TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY {
    Offset : Int64
    NameFlags : UInt32
    FileId : Int64
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : Int64
    FileName : UInt16[1]
}
struct TXFS_LIST_TRANSACTION_LOCKED_FILES {
    KtmTransaction : GUID
    NumberOfFiles : Int64
    BufferSizeRequired : Int64
    Offset : Int64
}
struct TXFS_LIST_TRANSACTIONS_ENTRY {
    TransactionId : GUID
    TransactionState : UInt32
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : Int64
}
struct TXFS_LIST_TRANSACTIONS {
    NumberOfTransactions : Int64
    BufferSizeRequired : Int64
}
struct TXFS_READ_BACKUP_INFORMATION_OUT {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            BufferLength : UInt32
            Buffer : UInt8[1]
        }
    }
}
struct TXFS_WRITE_BACKUP_INFORMATION {
    Buffer : UInt8[1]
}
struct TXFS_GET_TRANSACTED_VERSION {
    ThisBaseVersion : UInt32
    LatestVersion : UInt32
    ThisMiniVersion : UInt16
    FirstMiniVersion : UInt16
    LatestMiniVersion : UInt16
}
struct TXFS_SAVEPOINT_INFORMATION {
    KtmTransaction : HANDLE
    ActionCode : UInt32
    SavepointId : UInt32
}
struct TXFS_CREATE_MINIVERSION_INFO {
    StructureVersion : UInt16
    StructureLength : UInt16
    BaseVersion : UInt32
    MiniVersion : UInt16
}
struct TXFS_TRANSACTION_ACTIVE_INFO {
    TransactionsActiveAtSnapshot : BOOLEAN
}
struct BOOT_AREA_INFO {
    BootSectorCount : UInt32
    BootSectors : this._Anonymous_e__Struct[2]
    struct _Anonymous_e__Struct {
        Offset : Int64
    }
}
struct RETRIEVAL_POINTER_BASE {
    FileAreaOffset : Int64
}
struct FILE_FS_PERSISTENT_VOLUME_INFORMATION {
    VolumeFlags : UInt32
    FlagMask : UInt32
    Version : UInt32
    Reserved : UInt32
}
struct FILE_SYSTEM_RECOGNITION_INFORMATION {
    FileSystem : CHAR[9]
}
struct REQUEST_OPLOCK_INPUT_BUFFER {
    StructureVersion : UInt16
    StructureLength : UInt16
    RequestedOplockLevel : UInt32
    Flags : UInt32
}
struct REQUEST_OPLOCK_OUTPUT_BUFFER {
    StructureVersion : UInt16
    StructureLength : UInt16
    OriginalOplockLevel : UInt32
    NewOplockLevel : UInt32
    Flags : UInt32
    AccessMode : UInt32
    ShareMode : UInt16
}
struct STORAGE_QUERY_DEPENDENT_VOLUME_REQUEST {
    RequestLevel : UInt32
    RequestFlags : UInt32
}
struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY {
    EntryLength : UInt32
    DependencyTypeFlags : UInt32
    ProviderSpecificFlags : UInt32
    VirtualStorageType : VIRTUAL_STORAGE_TYPE
}
struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY {
    EntryLength : UInt32
    DependencyTypeFlags : UInt32
    ProviderSpecificFlags : UInt32
    VirtualStorageType : VIRTUAL_STORAGE_TYPE
    AncestorLevel : UInt32
    HostVolumeNameOffset : UInt32
    HostVolumeNameSize : UInt32
    DependentVolumeNameOffset : UInt32
    DependentVolumeNameSize : UInt32
    RelativePathOffset : UInt32
    RelativePathSize : UInt32
    DependentDeviceNameOffset : UInt32
    DependentDeviceNameSize : UInt32
}
struct STORAGE_QUERY_DEPENDENT_VOLUME_RESPONSE {
    ResponseLevel : UInt32
    NumberEntries : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Lev1Depends : STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY[1]
            Lev2Depends : STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY[1]
        }
    }
}
struct SD_CHANGE_MACHINE_SID_INPUT {
    CurrentMachineSIDOffset : UInt16
    CurrentMachineSIDLength : UInt16
    NewMachineSIDOffset : UInt16
    NewMachineSIDLength : UInt16
}
struct SD_CHANGE_MACHINE_SID_OUTPUT {
    NumSDChangedSuccess : Int64
    NumSDChangedFail : Int64
    NumSDUnused : Int64
    NumSDTotal : Int64
    NumMftSDChangedSuccess : Int64
    NumMftSDChangedFail : Int64
    NumMftSDTotal : Int64
}
struct SD_QUERY_STATS_INPUT {
    Reserved : UInt32
}
struct SD_QUERY_STATS_OUTPUT {
    SdsStreamSize : Int64
    SdsAllocationSize : Int64
    SiiStreamSize : Int64
    SiiAllocationSize : Int64
    SdhStreamSize : Int64
    SdhAllocationSize : Int64
    NumSDTotal : Int64
    NumSDUnused : Int64
}
struct SD_ENUM_SDS_INPUT {
    StartingOffset : Int64
    MaxSDEntriesToReturn : Int64
}
struct SD_ENUM_SDS_ENTRY {
    Hash : UInt32
    SecurityId : UInt32
    Offset : Int64
    Length : UInt32
    Descriptor : UInt8[1]
}
struct SD_ENUM_SDS_OUTPUT {
    NextOffset : Int64
    NumSDEntriesReturned : Int64
    NumSDBytesReturned : Int64
    SDEntry : SD_ENUM_SDS_ENTRY[1]
}
struct SD_GLOBAL_CHANGE_INPUT {
    Flags : UInt32
    ChangeType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            SdChange : SD_CHANGE_MACHINE_SID_INPUT
            SdQueryStats : SD_QUERY_STATS_INPUT
            SdEnumSds : SD_ENUM_SDS_INPUT
        }
    }
}
struct SD_GLOBAL_CHANGE_OUTPUT {
    Flags : UInt32
    ChangeType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            SdChange : SD_CHANGE_MACHINE_SID_OUTPUT
            SdQueryStats : SD_QUERY_STATS_OUTPUT
            SdEnumSds : SD_ENUM_SDS_OUTPUT
        }
    }
}
struct LOOKUP_STREAM_FROM_CLUSTER_INPUT {
    Flags : UInt32
    NumberOfClusters : UInt32
    Cluster : Int64[1]
}
struct LOOKUP_STREAM_FROM_CLUSTER_OUTPUT {
    Offset : UInt32
    NumberOfMatches : UInt32
    BufferSizeRequired : UInt32
}
struct LOOKUP_STREAM_FROM_CLUSTER_ENTRY {
    OffsetToNext : UInt32
    Flags : UInt32
    Reserved : Int64
    Cluster : Int64
    FileName : UInt16[1]
}
struct FILE_TYPE_NOTIFICATION_INPUT {
    Flags : UInt32
    NumFileTypeIDs : UInt32
    FileTypeID : GUID[1]
}
struct CSV_MGMT_LOCK {
    Flags : UInt32
}
struct CSV_NAMESPACE_INFO {
    Version : UInt32
    DeviceNumber : UInt32
    StartingOffset : Int64
    SectorSize : UInt32
}
struct CSV_CONTROL_OP extends Int32 {
    static CsvControlStartRedirectFile := 2
    static CsvControlStopRedirectFile := 3
    static CsvControlQueryRedirectState := 4
    static CsvControlQueryFileRevision := 6
    static CsvControlQueryMdsPath := 8
    static CsvControlQueryFileRevisionFileId128 := 9
    static CsvControlQueryVolumeRedirectState := 10
    static CsvControlEnableUSNRangeModificationTracking := 13
    static CsvControlMarkHandleLocalVolumeMount := 14
    static CsvControlUnmarkHandleLocalVolumeMount := 15
    static CsvControlGetCsvFsMdsPathV2 := 18
    static CsvControlDisableCaching := 19
    static CsvControlEnableCaching := 20
    static CsvControlStartForceDFO := 21
    static CsvControlStopForceDFO := 22
    static CsvControlQueryMdsPathNoPause := 23
    static CsvControlSetVolumeId := 24
    static CsvControlQueryVolumeId := 25
}
struct CSV_CONTROL_PARAM {
    Operation : CSV_CONTROL_OP
    Unused : Int64
}
struct CSV_QUERY_REDIRECT_STATE {
    MdsNodeId : UInt32
    DsNodeId : UInt32
    FileRedirected : BOOLEAN
}
struct CSV_QUERY_FILE_REVISION {
    FileId : Int64
    FileRevision : Int64[3]
}
struct CSV_QUERY_FILE_REVISION_FILE_ID_128 {
    FileId : FILE_ID_128
    FileRevision : Int64[3]
}
struct CSV_QUERY_MDS_PATH {
    MdsNodeId : UInt32
    DsNodeId : UInt32
    PathLength : UInt32
    Path : UInt16[1]
}
struct CSVFS_DISK_CONNECTIVITY extends Int32 {
    static CsvFsDiskConnectivityNone := 0
    static CsvFsDiskConnectivityMdsNodeOnly := 1
    static CsvFsDiskConnectivitySubsetOfNodes := 2
    static CsvFsDiskConnectivityAllNodes := 3
}
struct CSV_QUERY_VOLUME_REDIRECT_STATE {
    MdsNodeId : UInt32
    DsNodeId : UInt32
    IsDiskConnected : BOOLEAN
    ClusterEnableDirectIo : BOOLEAN
    DiskConnectivity : CSVFS_DISK_CONNECTIVITY
}
struct CSV_QUERY_MDS_PATH_V2 {
    Version : Int64
    RequiredSize : UInt32
    MdsNodeId : UInt32
    DsNodeId : UInt32
    Flags : UInt32
    DiskConnectivity : CSVFS_DISK_CONNECTIVITY
    VolumeId : GUID
    IpAddressOffset : UInt32
    IpAddressLength : UInt32
    PathOffset : UInt32
    PathLength : UInt32
}
struct CSV_SET_VOLUME_ID {
    VolumeId : GUID
}
struct CSV_QUERY_VOLUME_ID {
    VolumeId : GUID
}
struct LMR_QUERY_INFO_CLASS extends Int32 {
    static LMRQuerySessionInfo := 1
}
struct LMR_QUERY_INFO_PARAM {
    Operation : LMR_QUERY_INFO_CLASS
}
struct LMR_QUERY_SESSION_INFO {
    SessionId : Int64
}
struct CSV_QUERY_VETO_FILE_DIRECT_IO_OUTPUT {
    VetoedFromAltitudeIntegral : Int64
    VetoedFromAltitudeDecimal : Int64
    Reason : UInt16[256]
}
struct STORAGE_RESERVE_ID extends Int32 {
    static StorageReserveIdNone := 0
    static StorageReserveIdHard := 1
    static StorageReserveIdSoft := 2
    static StorageReserveIdUpdateScratch := 3
    static StorageReserveIdMax := 4
}
struct CSV_IS_OWNED_BY_CSVFS {
    OwnedByCSVFS : BOOLEAN
}
struct FILE_LEVEL_TRIM_RANGE {
    Offset : Int64
    Length : Int64
}
struct FILE_LEVEL_TRIM {
    Key : UInt32
    NumRanges : UInt32
    Ranges : FILE_LEVEL_TRIM_RANGE[1]
}
struct FILE_LEVEL_TRIM_OUTPUT {
    NumRangesProcessed : UInt32
}
struct QUERY_FILE_LAYOUT_FILTER_TYPE extends Int32 {
    static QUERY_FILE_LAYOUT_FILTER_TYPE_NONE := 0
    static QUERY_FILE_LAYOUT_FILTER_TYPE_CLUSTERS := 1
    static QUERY_FILE_LAYOUT_FILTER_TYPE_FILEID := 2
    static QUERY_FILE_LAYOUT_FILTER_TYPE_STORAGE_RESERVE_ID := 3
    static QUERY_FILE_LAYOUT_NUM_FILTER_TYPES := 4
}
struct CLUSTER_RANGE {
    StartingCluster : Int64
    ClusterCount : Int64
}
struct FILE_REFERENCE_RANGE {
    StartingFileReferenceNumber : Int64
    EndingFileReferenceNumber : Int64
}
struct QUERY_FILE_LAYOUT_INPUT {
    Anonymous : this._Anonymous_e__Union
    Flags : UInt32
    FilterType : QUERY_FILE_LAYOUT_FILTER_TYPE
    Reserved : UInt32
    Filter : this._Filter_e__Union
    struct _Anonymous_e__Union {
        union {
            FilterEntryCount : UInt32
            NumberOfPairs : UInt32
        }
    }
    struct _Filter_e__Union {
        union {
            ClusterRanges : CLUSTER_RANGE[1]
            FileReferenceRanges : FILE_REFERENCE_RANGE[1]
            StorageReserveIds : STORAGE_RESERVE_ID[1]
        }
    }
}
struct QUERY_FILE_LAYOUT_OUTPUT {
    FileEntryCount : UInt32
    FirstFileOffset : UInt32
    Flags : UInt32
    Reserved : UInt32
}
struct FILE_LAYOUT_ENTRY {
    Version : UInt32
    NextFileOffset : UInt32
    Flags : UInt32
    FileAttributes : UInt32
    FileReferenceNumber : Int64
    FirstNameOffset : UInt32
    FirstStreamOffset : UInt32
    ExtraInfoOffset : UInt32
    ExtraInfoLength : UInt32
}
struct FILE_LAYOUT_NAME_ENTRY {
    NextNameOffset : UInt32
    Flags : UInt32
    ParentFileReferenceNumber : Int64
    FileNameLength : UInt32
    Reserved : UInt32
    FileName : UInt16[1]
}
struct FILE_LAYOUT_INFO_ENTRY {
    BasicInformation : this._BasicInformation_e__Struct
    OwnerId : UInt32
    SecurityId : UInt32
    Usn : Int64
    StorageReserveId : STORAGE_RESERVE_ID
    struct _BasicInformation_e__Struct {
        CreationTime : Int64
        LastAccessTime : Int64
        LastWriteTime : Int64
        ChangeTime : Int64
        FileAttributes : UInt32
    }
}
struct STREAM_LAYOUT_ENTRY {
    Version : UInt32
    NextStreamOffset : UInt32
    Flags : UInt32
    ExtentInformationOffset : UInt32
    AllocationSize : Int64
    EndOfFile : Int64
    StreamInformationOffset : UInt32
    AttributeTypeCode : UInt32
    AttributeFlags : UInt32
    StreamIdentifierLength : UInt32
    StreamIdentifier : UInt16[1]
}
struct STREAM_EXTENT_ENTRY {
    Flags : UInt32
    ExtentInformation : this._ExtentInformation_e__Union
    struct _ExtentInformation_e__Union {
        union {
            RetrievalPointers : RETRIEVAL_POINTERS_BUFFER
        }
    }
}
struct FSCTL_GET_INTEGRITY_INFORMATION_BUFFER {
    ChecksumAlgorithm : UInt16
    Reserved : UInt16
    Flags : UInt32
    ChecksumChunkSizeInBytes : UInt32
    ClusterSizeInBytes : UInt32
}
struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER {
    ChecksumAlgorithm : UInt16
    Reserved : UInt16
    Flags : UInt32
}
struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER_EX {
    EnableIntegrity : UInt8
    KeepIntegrityStateUnchanged : UInt8
    Reserved : UInt16
    Flags : UInt32
    Version : UInt8
    Reserved2 : UInt8[7]
}
struct FSCTL_OFFLOAD_READ_INPUT {
    Size : UInt32
    Flags : UInt32
    TokenTimeToLive : UInt32
    Reserved : UInt32
    FileOffset : Int64
    CopyLength : Int64
}
struct FSCTL_OFFLOAD_READ_OUTPUT {
    Size : UInt32
    Flags : UInt32
    TransferLength : Int64
    Token : UInt8[512]
}
struct FSCTL_OFFLOAD_WRITE_INPUT {
    Size : UInt32
    Flags : UInt32
    FileOffset : Int64
    CopyLength : Int64
    TransferOffset : Int64
    Token : UInt8[512]
}
struct FSCTL_OFFLOAD_WRITE_OUTPUT {
    Size : UInt32
    Flags : UInt32
    LengthWritten : Int64
}
struct SET_PURGE_FAILURE_MODE_INPUT {
    Flags : UInt32
}
struct REPAIR_COPIES_INPUT {
    Size : UInt32
    Flags : UInt32
    FileOffset : Int64
    Length : UInt32
    SourceCopy : UInt32
    NumberOfRepairCopies : UInt32
    RepairCopies : UInt32[1]
}
struct REPAIR_COPIES_OUTPUT {
    Size : UInt32
    Status : UInt32
    ResumeFileOffset : Int64
}
struct FILE_REGION_INFO {
    FileOffset : Int64
    Length : Int64
    Usage : UInt32
    Reserved : UInt32
}
struct FILE_REGION_OUTPUT {
    Flags : UInt32
    TotalRegionEntryCount : UInt32
    RegionEntryCount : UInt32
    Reserved : UInt32
    Region : FILE_REGION_INFO[1]
}
struct FILE_REGION_INPUT {
    FileOffset : Int64
    Length : Int64
    DesiredUsage : UInt32
}
struct WRITE_USN_REASON_INPUT {
    Flags : UInt32
    UsnReasonToWrite : UInt32
}
struct FILE_STORAGE_TIER_MEDIA_TYPE extends Int32 {
    static FileStorageTierMediaTypeUnspecified := 0
    static FileStorageTierMediaTypeDisk := 1
    static FileStorageTierMediaTypeSsd := 2
    static FileStorageTierMediaTypeScm := 4
    static FileStorageTierMediaTypeMax := 5
}
struct FILE_STORAGE_TIER_CLASS extends Int32 {
    static FileStorageTierClassUnspecified := 0
    static FileStorageTierClassCapacity := 1
    static FileStorageTierClassPerformance := 2
    static FileStorageTierClassMax := 3
}
struct FILE_STORAGE_TIER {
    Id : GUID
    Name : UInt16[256]
    Description : UInt16[256]
    Flags : Int64
    ProvisionedCapacity : Int64
    MediaType : FILE_STORAGE_TIER_MEDIA_TYPE
    Class : FILE_STORAGE_TIER_CLASS
}
struct FSCTL_QUERY_STORAGE_CLASSES_OUTPUT {
    Version : UInt32
    Size : UInt32
    Flags : FILE_STORAGE_TIER_FLAGS
    TotalNumberOfTiers : UInt32
    NumberOfTiersReturned : UInt32
    Tiers : FILE_STORAGE_TIER[1]
}
struct STREAM_INFORMATION_ENTRY {
    Version : UInt32
    Flags : UInt32
    StreamInformation : this._StreamInformation
    struct _StreamInformation {
        union {
            DesiredStorageClass : this._DesiredStorageClass
            DataStream : this._DataStream
            Reparse : this._Reparse
            Ea : this._Ea
        }
        struct _DesiredStorageClass {
            Class : FILE_STORAGE_TIER_CLASS
            Flags : UInt32
        }
        struct _DataStream {
            Length : UInt16
            Flags : UInt16
            Reserved : UInt32
            Vdl : Int64
        }
        struct _Reparse {
            Length : UInt16
            Flags : UInt16
            ReparseDataSize : UInt32
            ReparseDataOffset : UInt32
        }
        struct _Ea {
            Length : UInt16
            Flags : UInt16
            EaSize : UInt32
            EaInformationOffset : UInt32
        }
    }
}
struct FSCTL_QUERY_REGION_INFO_INPUT {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    NumberOfTierIds : UInt32
    TierIds : GUID[1]
}
struct FILE_STORAGE_TIER_REGION {
    TierId : GUID
    Offset : Int64
    Length : Int64
}
struct FSCTL_QUERY_REGION_INFO_OUTPUT {
    Version : UInt32
    Size : UInt32
    Flags : UInt32
    Reserved : UInt32
    Alignment : Int64
    TotalNumberOfRegions : UInt32
    NumberOfRegionsReturned : UInt32
    Regions : FILE_STORAGE_TIER_REGION[1]
}
struct FILE_DESIRED_STORAGE_CLASS_INFORMATION {
    Class : FILE_STORAGE_TIER_CLASS
    Flags : UInt32
}
struct DUPLICATE_EXTENTS_DATA {
    FileHandle : HANDLE
    SourceFileOffset : Int64
    TargetFileOffset : Int64
    ByteCount : Int64
}
struct DUPLICATE_EXTENTS_DATA_EX {
    Size : IntPtr
    FileHandle : HANDLE
    SourceFileOffset : Int64
    TargetFileOffset : Int64
    ByteCount : Int64
    Flags : UInt32
}
struct DUPLICATE_EXTENTS_STATE extends Int32 {
    static FileSnapStateInactive := 0
    static FileSnapStateSource := 1
    static FileSnapStateTarget := 2
}
struct ASYNC_DUPLICATE_EXTENTS_STATUS {
    Version : UInt32
    State : DUPLICATE_EXTENTS_STATE
    SourceFileOffset : Int64
    TargetFileOffset : Int64
    ByteCount : Int64
    BytesDuplicated : Int64
}
struct REFS_SMR_VOLUME_GC_STATE extends Int32 {
    static SmrGcStateInactive := 0
    static SmrGcStatePaused := 1
    static SmrGcStateActive := 2
    static SmrGcStateActiveFullSpeed := 3
}
struct REFS_SMR_VOLUME_INFO_OUTPUT {
    Version : UInt32
    Flags : UInt32
    SizeOfRandomlyWritableTier : Int64
    FreeSpaceInRandomlyWritableTier : Int64
    SizeofSMRTier : Int64
    FreeSpaceInSMRTier : Int64
    UsableFreeSpaceInSMRTier : Int64
    VolumeGcState : REFS_SMR_VOLUME_GC_STATE
    VolumeGcLastStatus : UInt32
    CurrentGcBandFillPercentage : UInt32
    Unused : Int64[6]
}
struct REFS_SMR_VOLUME_GC_ACTION extends Int32 {
    static SmrGcActionStart := 1
    static SmrGcActionStartFullSpeed := 2
    static SmrGcActionPause := 3
    static SmrGcActionStop := 4
}
struct REFS_SMR_VOLUME_GC_METHOD extends Int32 {
    static SmrGcMethodCompaction := 1
    static SmrGcMethodCompression := 2
    static SmrGcMethodRotation := 3
}
struct REFS_SMR_VOLUME_GC_PARAMETERS {
    Version : UInt32
    Flags : UInt32
    Action : REFS_SMR_VOLUME_GC_ACTION
    Method : REFS_SMR_VOLUME_GC_METHOD
    IoGranularity : UInt32
    CompressionFormat : UInt32
    Unused : Int64[8]
}
struct STREAMS_QUERY_PARAMETERS_OUTPUT_BUFFER {
    OptimalWriteSize : UInt32
    StreamGranularitySize : UInt32
    StreamIdMin : UInt32
    StreamIdMax : UInt32
}
struct STREAMS_ASSOCIATE_ID_INPUT_BUFFER {
    Flags : UInt32
    StreamId : UInt32
}
struct STREAMS_QUERY_ID_OUTPUT_BUFFER {
    StreamId : UInt32
}
struct QUERY_BAD_RANGES_INPUT_RANGE {
    StartOffset : Int64
    LengthInBytes : Int64
}
struct QUERY_BAD_RANGES_INPUT {
    Flags : UInt32
    NumRanges : UInt32
    Ranges : QUERY_BAD_RANGES_INPUT_RANGE[1]
}
struct QUERY_BAD_RANGES_OUTPUT_RANGE {
    Flags : UInt32
    Reserved : UInt32
    StartOffset : Int64
    LengthInBytes : Int64
}
struct QUERY_BAD_RANGES_OUTPUT {
    Flags : UInt32
    NumBadRanges : UInt32
    NextOffsetToLookUp : Int64
    BadRanges : QUERY_BAD_RANGES_OUTPUT_RANGE[1]
}
struct SET_DAX_ALLOC_ALIGNMENT_HINT_INPUT {
    Flags : UInt32
    AlignmentShift : UInt32
    FileOffsetToAlign : Int64
    FallbackAlignmentShift : UInt32
}
struct VIRTUAL_STORAGE_BEHAVIOR_CODE extends Int32 {
    static VirtualStorageBehaviorUndefined := 0
    static VirtualStorageBehaviorCacheWriteThrough := 1
    static VirtualStorageBehaviorCacheWriteBack := 2
    static VirtualStorageBehaviorStopIoProcessing := 3
    static VirtualStorageBehaviorRestartIoProcessing := 4
}
struct VIRTUAL_STORAGE_SET_BEHAVIOR_INPUT {
    Size : UInt32
    BehaviorCode : VIRTUAL_STORAGE_BEHAVIOR_CODE
}
struct ENCRYPTION_KEY_CTRL_INPUT {
    HeaderSize : UInt32
    StructureSize : UInt32
    KeyOffset : UInt16
    KeySize : UInt16
    DplLock : UInt32
    DplUserId : Int64
    DplCredentialId : Int64
}
struct WOF_EXTERNAL_INFO {
    Version : UInt32
    Provider : UInt32
}
struct WOF_EXTERNAL_FILE_ID {
    FileId : FILE_ID_128
}
struct WOF_VERSION_INFO {
    WofVersion : UInt32
}
struct WIM_PROVIDER_EXTERNAL_INFO {
    Version : UInt32
    Flags : UInt32
    DataSourceId : Int64
    ResourceHash : UInt8[20]
}
struct WIM_PROVIDER_ADD_OVERLAY_INPUT {
    WimType : UInt32
    WimIndex : UInt32
    WimFileNameOffset : UInt32
    WimFileNameLength : UInt32
}
struct WIM_PROVIDER_UPDATE_OVERLAY_INPUT {
    DataSourceId : Int64
    WimFileNameOffset : UInt32
    WimFileNameLength : UInt32
}
struct WIM_PROVIDER_REMOVE_OVERLAY_INPUT {
    DataSourceId : Int64
}
struct WIM_PROVIDER_SUSPEND_OVERLAY_INPUT {
    DataSourceId : Int64
}
struct WIM_PROVIDER_OVERLAY_ENTRY {
    NextEntryOffset : UInt32
    DataSourceId : Int64
    WimGuid : GUID
    WimFileNameOffset : UInt32
    WimType : UInt32
    WimIndex : UInt32
    Flags : UInt32
}
struct FILE_PROVIDER_EXTERNAL_INFO_V0 {
    Version : UInt32
    Algorithm : UInt32
}
struct FILE_PROVIDER_EXTERNAL_INFO_V1 {
    Version : UInt32
    Algorithm : UInt32
    Flags : UInt32
}
struct CONTAINER_VOLUME_STATE {
    Flags : UInt32
}
struct CONTAINER_ROOT_INFO_INPUT {
    Flags : UInt32
}
struct CONTAINER_ROOT_INFO_OUTPUT {
    ContainerRootIdLength : UInt16
    ContainerRootId : UInt8[1]
}
struct VIRTUALIZATION_INSTANCE_INFO_INPUT {
    NumberOfWorkerThreads : UInt32
    Flags : UInt32
}
struct VIRTUALIZATION_INSTANCE_INFO_INPUT_EX {
    HeaderSize : UInt16
    Flags : UInt32
    NotificationInfoSize : UInt32
    NotificationInfoOffset : UInt16
    ProviderMajorVersion : UInt16
}
struct VIRTUALIZATION_INSTANCE_INFO_OUTPUT {
    VirtualizationInstanceID : GUID
}
struct GET_FILTER_FILE_IDENTIFIER_INPUT {
    AltitudeLength : UInt16
    Altitude : UInt16[1]
}
struct GET_FILTER_FILE_IDENTIFIER_OUTPUT {
    FilterFileIdentifierLength : UInt16
    FilterFileIdentifier : UInt8[1]
}
struct FS_BPIO_OPERATIONS extends Int32 {
    static FS_BPIO_OP_ENABLE := 1
    static FS_BPIO_OP_DISABLE := 2
    static FS_BPIO_OP_QUERY := 3
    static FS_BPIO_OP_VOLUME_STACK_PAUSE := 4
    static FS_BPIO_OP_VOLUME_STACK_RESUME := 5
    static FS_BPIO_OP_STREAM_PAUSE := 6
    static FS_BPIO_OP_STREAM_RESUME := 7
    static FS_BPIO_OP_GET_INFO := 8
    static FS_BPIO_OP_MAX_OPERATION := 9
}
struct FS_BPIO_INFLAGS extends Int32 {
    static FSBPIO_INFL_None := 0
    static FSBPIO_INFL_SKIP_STORAGE_STACK_QUERY := 1
}
struct FS_BPIO_INPUT {
    Operation : FS_BPIO_OPERATIONS
    InFlags : FS_BPIO_INFLAGS
    Reserved1 : Int64
    Reserved2 : Int64
}
struct FS_BPIO_OUTFLAGS extends Int32 {
    static FSBPIO_OUTFL_None := 0
    static FSBPIO_OUTFL_VOLUME_STACK_BYPASS_PAUSED := 1
    static FSBPIO_OUTFL_STREAM_BYPASS_PAUSED := 2
    static FSBPIO_OUTFL_FILTER_ATTACH_BLOCKED := 4
    static FSBPIO_OUTFL_COMPATIBLE_STORAGE_DRIVER := 8
}
struct FS_BPIO_RESULTS {
    OpStatus : UInt32
    FailingDriverNameLen : UInt16
    FailingDriverName : UInt16[32]
    FailureReasonLen : UInt16
    FailureReason : UInt16[128]
}
struct FS_BPIO_INFO {
    ActiveBypassIoCount : UInt32
    StorageDriverNameLen : UInt16
    StorageDriverName : UInt16[32]
}
struct FS_BPIO_OUTPUT {
    Operation : FS_BPIO_OPERATIONS
    OutFlags : FS_BPIO_OUTFLAGS
    Reserved1 : Int64
    Reserved2 : Int64
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Enable : FS_BPIO_RESULTS
            Query : FS_BPIO_RESULTS
            VolumeStackResume : FS_BPIO_RESULTS
            StreamResume : FS_BPIO_RESULTS
            GetInfo : FS_BPIO_INFO
        }
    }
}
struct SMB_SHARE_FLUSH_AND_PURGE_INPUT {
    Version : UInt16
}
struct SMB_SHARE_FLUSH_AND_PURGE_OUTPUT {
    cEntriesPurged : UInt32
}
struct DISK_EXTENT {
    DiskNumber : UInt32
    StartingOffset : Int64
    ExtentLength : Int64
}
struct VOLUME_DISK_EXTENTS {
    NumberOfDiskExtents : UInt32
    Extents : DISK_EXTENT[1]
}
struct VOLUME_GET_GPT_ATTRIBUTES_INFORMATION {
    GptAttributes : Int64
}
struct PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK extends FunctionPointer {
    static Types := [IO_IRP_EXT_TRACK_OFFSET_HEADER.Ptr, IO_IRP_EXT_TRACK_OFFSET_HEADER.Ptr, Int64, "Void"]
}
struct IO_IRP_EXT_TRACK_OFFSET_HEADER {
    Validation : UInt16
    Flags : UInt16
    TrackedOffsetCallback : PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK
}
struct CXL_CACHEMEM_CAPABILITY_ID extends Int32 {
    static CxlCacheMemCapabilityID_NullCapability := 0
    static CxlCacheMemCapabilityID_Capability := 1
    static CxlCacheMemCapabilityID_RASCapability := 2
    static CxlCacheMemCapabilityID_SecurityCapability := 3
    static CxlCacheMemCapabilityID_LinkCapability := 4
    static CxlCacheMemCapabilityID_HDMDecoderCapability := 5
    static CxlCacheMemCapabilityID_ExtendedSecurityCapability := 6
    static CxlCacheMemCapabilityID_IDECapability := 7
    static CxlCacheMemCapabilityID_SnoopFilterCapability := 8
    static CxlCacheMemCapabilityID_TimeoutAndIsolationCapability := 9
    static CxlCacheMemCapabilityID_ExtendedRegisterCapability := 10
    static CxlCacheMemCapabilityID_BIRouteTableCapability := 11
    static CxlCacheMemCapabilityID_BIDecoderCapability := 12
    static CxlCacheMemCapabilityID_CacheIDRouteTableCapability := 13
    static CxlCacheMemCapabilityID_CacheIDDecoderCapability := 14
    static CxlCacheMemCapabilityID_ExtendedHDMDecoderCapability := 15
    static CxlCacheMemCapabilityID_ExtendedMetadataCapability := 16
}
struct CXL_CAPABILITY_HEADER_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_CACHEMEM_CAPABILITY_HEADER_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_CACHEMEM_REGISTERS {
    CapabilityHeaderRegister : CXL_CAPABILITY_HEADER_REGISTER
    CacheMemCapabilityHeaderRegister : CXL_CACHEMEM_CAPABILITY_HEADER_REGISTER[1]
}
struct CXL_HDM_DECODER_COUNT extends Int32 {
    static CxlHdmDecoderCount_1 := 0
    static CxlHdmDecoderCount_2 := 1
    static CxlHdmDecoderCount_4 := 2
    static CxlHdmDecoderCount_6 := 3
    static CxlHdmDecoderCount_8 := 4
    static CxlHdmDecoderCount_10 := 5
    static CxlHdmDecoderCount_12 := 6
    static CxlHdmDecoderCount_14 := 7
    static CxlHdmDecoderCount_16 := 8
    static CxlHdmDecoderCount_20 := 9
    static CxlHdmDecoderCount_24 := 10
    static CxlHdmDecoderCount_28 := 11
    static CxlHdmDecoderCount_32 := 12
    static CxlHdmDecoderCount_Max := 13
}
struct CXL_HDM_DECODER_CAPABILITY_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_DECODER_GLOBAL_CONTROL_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_MEMORY_BASE_LOW {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_MEMORY_SIZE_LOW {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_INTERLEAVE_WAYS extends Int32 {
    static CxlInterleaveWays_1Way := 0
    static CxlInterleaveWays_2Way := 1
    static CxlInterleaveWays_4Way := 2
    static CxlInterleaveWays_8Way := 3
    static CxlInterleaveWays_16Way := 4
    static CxlInterleaveWays_3Way := 8
    static CxlInterleaveWays_6Way := 9
    static CxlInterleaveWays_12Way := 10
    static CxlInterleaveWays_Max := 11
}
struct CXL_INTERLEAVE_GRANULARITY extends Int32 {
    static CxlInterleaveGranularity_256 := 0
    static CxlInterleaveGranularity_512 := 1
    static CxlInterleaveGranularity_1024 := 2
    static CxlInterleaveGranularity_2048 := 3
    static CxlInterleaveGranularity_4096 := 4
    static CxlInterleaveGranularity_8192 := 5
    static CxlInterleaveGranularity_16384 := 6
    static CxlInterleaveGranularity_Max := 7
}
struct CXL_HDM_DECODER_CONTROL_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_DECODER_DPA_SKIP_LOW_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_DECODER_TARGET_LIST_LOW_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_DECODER_TARGET_LIST_HIGH_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_HDM_DECODER_REGISTERS {
    MemoryBaseLow : CXL_HDM_MEMORY_BASE_LOW
    MemoryBaseHigh : UInt32
    MemorySizeLow : CXL_HDM_MEMORY_SIZE_LOW
    MemorySizeHigh : UInt32
    Control : CXL_HDM_DECODER_CONTROL_REGISTER
    u1 : this._u1_e__Union
    u2 : this._u2_e__Union
    Reserved : UInt32
    struct _u1_e__Union {
        union {
            TargetListLow : CXL_HDM_DECODER_TARGET_LIST_LOW_REGISTER
            DpaSkipLow : CXL_HDM_DECODER_DPA_SKIP_LOW_REGISTER
        }
    }
    struct _u2_e__Union {
        union {
            TargetListHigh : CXL_HDM_DECODER_TARGET_LIST_HIGH_REGISTER
            DpaSkipHigh : UInt32
        }
    }
}
struct CXL_HDM_DECODER_CAPABILITY_STRUCTURE {
    CapabilityRegister : CXL_HDM_DECODER_CAPABILITY_REGISTER
    GlobalControlRegister : CXL_HDM_DECODER_GLOBAL_CONTROL_REGISTER
    Reserved : UInt32[2]
    Decoders : CXL_HDM_DECODER_REGISTERS[1]
}
struct CXL_RAS_UNCORRECTABLE_ERROR_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_UNCORRECTABLE_ERROR_MASK_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_UNCORRECTABLE_ERROR_SEVERITY_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_CORRECTABLE_ERROR_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_CORRECTABLE_ERROR_MASK_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_ERROR_CAPABILITY_AND_CONTROL_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_RAS_HEADER_LOG_REGISTERS {
    HeaderLogArray : UInt32[16]
}
struct CXL_RAS_CAPABILITY_STRUCTURE {
    UncorrectableErrorStatusRegister : CXL_RAS_UNCORRECTABLE_ERROR_STATUS_REGISTER
    UncorrectableErrorMaskRegister : CXL_RAS_UNCORRECTABLE_ERROR_MASK_REGISTER
    UncorrectableErrorSeverityRegister : CXL_RAS_UNCORRECTABLE_ERROR_SEVERITY_REGISTER
    CorrectableErrorStatusRegister : CXL_RAS_CORRECTABLE_ERROR_STATUS_REGISTER
    CorrectableErrorMaskRegister : CXL_RAS_CORRECTABLE_ERROR_MASK_REGISTER
    ErrorCapabilityAndControlRegister : CXL_RAS_ERROR_CAPABILITY_AND_CONTROL_REGISTER
    HeaderLogRegisters : CXL_RAS_HEADER_LOG_REGISTERS
}
struct CXL_DEVICE_CAPABILITY_ARRAY_TYPE extends Int32 {
    static CxlDeviceCapabilityArrayType_InferredFromPciClassCode := 0
    static CxlDeviceCapabilityArrayType_MemoryDeviceCapabilities := 1
    static CxlDeviceCapabilityArrayType_SwitchMailboxCCICapabilities := 2
    static CxlDeviceCapabilityArrayType_Max := 3
}
struct CXL_DEVICE_CAPABILITY_ID extends Int32 {
    static CxlDeviceCapabilityID_CapabilityArray := 0
    static CxlDeviceCapabilityID_DeviceStatusRegisters := 1
    static CxlDeviceCapabilityID_PrimaryMailboxRegisters := 2
    static CxlDeviceCapabilityID_SecondaryMailboxRegisters := 3
    static CxlDeviceCapabilityID_MemoryDeviceStatusRegisters := 16384
}
struct CXL_DEVICE_CAPABILITIES_ARRAY_REGISTER_HEADER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_DEVICE_CAPABILITIES_ARRAY_REGISTER {
    Header : CXL_DEVICE_CAPABILITIES_ARRAY_REGISTER_HEADER
    CapabilitiesCount : UInt16
    Reserved : UInt16
    Reserved1 : UInt32[2]
}
struct CXL_DEVICE_CAPABILITY_HEADER_REGISTER_HEADER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_DEVICE_CAPABILITY_HEADER_REGISTER {
    Header : CXL_DEVICE_CAPABILITY_HEADER_REGISTER_HEADER
    Offset : UInt32
    Length : UInt32
    Reserved : UInt32
}
struct CXL_DEVICE_REGISTERS {
    CapabilityArrayRegister : CXL_DEVICE_CAPABILITIES_ARRAY_REGISTER
    CapabilityHeaderRegister : CXL_DEVICE_CAPABILITY_HEADER_REGISTER[1]
}
struct CXL_EVENT_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct CXL_DEVICE_STATUS_REGISTERS {
    EventStatusRegister : CXL_EVENT_STATUS_REGISTER
}
struct CXL_MAILBOX_CAPABILITY_TYPE extends Int32 {
    static CxlMailboxCapabilityType_InferredFromPciClassCode := 0
    static CxlMailboxCapabilityType_MemoryDeviceCommands := 1
    static CxlMailboxCapabilityType_FMApiCommands := 2
    static CxlMailboxCapabilityType_Max := 3
}
struct CXL_MAILBOX_CAPABILITY_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_MAILBOX_CONTROL_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlong : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct CXL_COMMAND_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct CXL_COMMAND_RETURN_CODE extends Int32 {
    static CxlCommandReturnCode_Success := 0
    static CxlCommandReturnCode_BackgroundCommandStarted := 1
    static CxlCommandReturnCode_InvalidInput := 2
    static CxlCommandReturnCode_Unsupported := 3
    static CxlCommandReturnCode_InternalError := 4
    static CxlCommandReturnCode_RetryRequired := 5
    static CxlCommandReturnCode_Busy := 6
    static CxlCommandReturnCode_MediaDisabled := 7
    static CxlCommandReturnCode_FWTransferInProgress := 8
    static CxlCommandReturnCode_FWTransferOutOfOrder := 9
    static CxlCommandReturnCode_FWVerificationFailed := 10
    static CxlCommandReturnCode_InvalidSlot := 11
    static CxlCommandReturnCode_ActivationFailed_FWRolledBack := 12
    static CxlCommandReturnCode_ActivationFailed_ColdResetRequired := 13
    static CxlCommandReturnCode_InvalidHandle := 14
    static CxlCommandReturnCode_InvalidPhysicalAddress := 15
    static CxlCommandReturnCode_InjectPoisonLimitReached := 16
    static CxlCommandReturnCode_PermanentMediaFailure := 17
    static CxlCommandReturnCode_Aborted := 18
    static CxlCommandReturnCode_InvalidSecurityState := 19
    static CxlCommandReturnCode_IncorrectPassphrase := 20
    static CxlCommandReturnCode_UnsupportedMailboxOrCCI := 21
    static CxlCommandReturnCode_InvalidPayloadLength := 22
    static CxlCommandReturnCode_InvalidLog := 23
    static CxlCommandReturnCode_Interrupted := 24
    static CxlCommandReturnCode_UnsupportedFeatureVersion := 25
    static CxlCommandReturnCode_UnsupportedFeatureSelectionValue := 26
    static CxlCommandReturnCode_FeatureTransferInProgress := 27
    static CxlCommandReturnCode_FeatureTransferOutOfOrder := 28
    static CxlCommandReturnCode_ResourcesExhausted := 29
    static CxlCommandReturnCode_InvalidExtentList := 30
    static CxlCommandReturnCode_TransferOutOfOrder := 31
    static CxlCommandReturnCode_RequestAbortNotSupportedByBackgroundOperation := 32
    static CxlCommandReturnCode_Max := 33
}
struct CXL_MAILBOX_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct CXL_BACKGROUND_COMMAND_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct CXL_COMMAND_PAYLOAD_REGISTERS {
    Payload : UInt32[1]
}
struct CXL_MAILBOX_REGISTERS {
    CapabilityRegister : CXL_MAILBOX_CAPABILITY_REGISTER
    ControlRegister : CXL_MAILBOX_CONTROL_REGISTER
    CommandRegister : CXL_COMMAND_REGISTER
    StatusRegister : CXL_MAILBOX_STATUS_REGISTER
    BackgroundCommandStatusRegister : CXL_BACKGROUND_COMMAND_STATUS_REGISTER
    PayloadRegisters : CXL_COMMAND_PAYLOAD_REGISTERS
}
struct CXL_MEMORY_DEVICE_MEDIA_STATUS extends Int32 {
    static CxlMemoryDeviceMediaStatus_NotReady := 0
    static CxlMemoryDeviceMediaStatus_Ready := 1
    static CxlMemoryDeviceMediaStatus_Error := 2
    static CxlMemoryDeviceMediaStatus_Disabled := 3
    static CxlMemoryDeviceMediaStatus_Max := 4
}
struct CXL_MEMORY_DEVICE_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUlonglong : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct CXL_MEMORY_DEVICE_STATUS_REGISTERS {
    MemoryDeviceStatusRegister : CXL_MEMORY_DEVICE_STATUS_REGISTER
}
struct CXL_MAILBOX_COMMAND extends Int32 {
    static CxlMailboxCommand_Identify := 1
    static CxlMailboxCommand_BackgroundOperationStatus := 2
    static CxlMailboxCommand_GetResponseMessageLimit := 3
    static CxlMailboxCommand_SetResponseMessageLimit := 4
    static CxlMailboxCommand_RequestAbortBackgroundOperation := 5
    static CxlMailboxCommand_GetEventRecords := 256
    static CxlMailboxCommand_ClearEventRecords := 257
    static CxlMailboxCommand_GetEventInterruptPolicy := 258
    static CxlMailboxCommand_SetEventInterruptPolicy := 259
    static CxlMailboxCommand_GetMCTPEventInterruptPolicy := 260
    static CxlMailboxCommand_SetMCTPEventInterruptPolicy := 261
    static CxlMailboxCommand_EventNotification := 262
    static CxlMailboxCommand_GFDEnhancedEventNotification := 263
    static CxlMailboxCommand_GFDtoGAEEnhancedEventNotification := 264
    static CxlMailboxCommand_GetGAMBuffer := 265
    static CxlMailboxCommand_SetGAMBuffer := 266
    static CxlMailboxCommand_GetFWInfo := 512
    static CxlMailboxCommand_TransferFW := 513
    static CxlMailboxCommand_ActivateFW := 514
    static CxlMailboxCommand_GetTimestamp := 768
    static CxlMailboxCommand_SetTimestamp := 769
    static CxlMailboxCommand_GetSupportedLogs := 1024
    static CxlMailboxCommand_GetLog := 1025
    static CxlMailboxCommand_GetLogCapabilities := 1026
    static CxlMailboxCommand_ClearLog := 1027
    static CxlMailboxCommand_PopulateLog := 1028
    static CxlMailboxCommand_GetSupportedLogSubList := 1029
    static CxlMailboxCommand_GetSupportedFeatures := 1280
    static CxlMailboxCommand_GetFeature := 1281
    static CxlMailboxCommand_SetFeature := 1282
    static CxlMailboxCommand_PerformMaintenance := 1536
    static CxlMailboxCommand_IdentifyPBRComponent := 1792
    static CxlMailboxCommand_ClaimOwnership := 1793
    static CxlMailboxCommand_ReadCDAT := 1794
    static CxlMailboxCommand_IdentifyMemoryDevice := 16384
    static CxlMailboxCommand_GetPartitionInfo := 16640
    static CxlMailboxCommand_SetPartitionInfo := 16641
    static CxlMailboxCommand_GetLSA := 16642
    static CxlMailboxCommand_SetLSA := 16643
    static CxlMailboxCommand_GetHealthInfo := 16896
    static CxlMailboxCommand_GetAlertConfiguration := 16897
    static CxlMailboxCommand_SetAlertConfiguration := 16898
    static CxlMailboxCommand_GetShutdownState := 16899
    static CxlMailboxCommand_SetShutdownState := 16900
    static CxlMailboxCommand_GetPoisonList := 17152
    static CxlMailboxCommand_InjectPoison := 17153
    static CxlMailboxCommand_ClearPoison := 17154
    static CxlMailboxCommand_GetScanMediaCapabilities := 17155
    static CxlMailboxCommand_ScanMedia := 17156
    static CxlMailboxCommand_GetScanMediaResults := 17157
    static CxlMailboxCommand_Sanitize := 17408
    static CxlMailboxCommand_SecureErase := 17409
    static CxlMailboxCommand_MediaOperations := 17410
    static CxlMailboxCommand_GetSecurityState := 17664
    static CxlMailboxCommand_SetPassphrase := 17665
    static CxlMailboxCommand_DisablePassphrase := 17666
    static CxlMailboxCommand_Unlock := 17667
    static CxlMailboxCommand_FreezeSecurityState := 17668
    static CxlMailboxCommand_passphraseSecureErase := 17669
    static CxlMailboxCommand_SecuritySend := 17920
    static CxlMailboxCommand_SecurityReceive := 17921
    static CxlMailboxCommand_GetSLDQoSControl := 18176
    static CxlMailboxCommand_SetSLDQoSControl := 18177
    static CxlMailboxCommand_GetSLDQoSStatus := 18178
    static CxlMailboxCommand_GetDynamicCapacityConfiguration := 18432
    static CxlMailboxCommand_GetDynamicCapacityExtentList := 18433
    static CxlMailboxCommand_AddDynamicCapacityResponse := 18434
    static CxlMailboxCommand_ReleaseDynamicCapacity := 18435
    static CxlMailboxCommand_IdentifyGFD := 18688
    static CxlMailboxCommand_GetGFDStatus := 18689
    static CxlMailboxCommand_GetGFDDcRegionConfiguration := 18690
    static CxlMailboxCommand_SetGFDDcRegionConfiguration := 18691
    static CxlMailboxCommand_GetGFDDcRegionExtentLists := 18692
    static CxlMailboxCommand_GetGFDDmpConfiguration := 18693
    static CxlMailboxCommand_SetGFDDmpConfiguration := 18694
    static CxlMailboxCommand_GFDDynamicCapacityAdd := 18695
    static CxlMailboxCommand_GFDDynamicCapacityRelease := 18696
    static CxlMailboxCommand_GFDDynamicCapacityAddReference := 18697
    static CxlMailboxCommand_GFDDynamicCapacityRemoveReference := 18698
    static CxlMailboxCommand_GFDDynamicCapacityListTags := 18699
    static CxlMailboxCommand_GetGFDSatEntry := 18700
    static CxlMailboxCommand_SetGFDSatEntry := 18701
    static CxlMailboxCommand_GetGFDQoSControl := 18702
    static CxlMailboxCommand_SetGFDQoSControl := 18703
    static CxlMailboxCommand_GetGFDQoSStatus := 18704
    static CxlMailboxCommand_GetGFDQoSBWLimit := 18705
    static CxlMailboxCommand_SetGFDQoSBWLimit := 18706
    static CxlMailboxCommand_GetGDTConfiguration := 18707
    static CxlMailboxCommand_SetGDTConfiguration := 18708
}
struct CXL_MAILBOX_MEMORY_DEVICE_IDENTIFY_INFO {
    FWRevision : CHAR[16]
    TotalCapacity : UInt8[8]
    VolatileOnlyCapacity : UInt8[8]
    PersistentOnlyCapacity : UInt8[8]
    PartitionAlignment : UInt8[8]
    InformationEventLogSize : UInt8[2]
    WarningEventLogSize : UInt8[2]
    FailureEventLogSize : UInt8[2]
    FatalEventLogSize : UInt8[2]
    LSASize : UInt8[4]
    PoisonListMaximumMediaErrorRecords : UInt8[3]
    InjectPoisonLimit : UInt8[2]
    PoisonHandlingCapabilities : this._PoisonHandlingCapabilities_e__Struct
    QoSTelemetryCapabilities : this._QoSTelemetryCapabilities_e__Struct
    DynamicCapacityEventLogSize : UInt8[2]
    Reserved : UInt8[3]
    struct _PoisonHandlingCapabilities_e__Struct {
        _bitfield : UInt8
    }
    struct _QoSTelemetryCapabilities_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_MAILBOX_FIRMWARE_INFO {
    FWSlotsSupported : UInt8
    FWSlotInfo : this._FWSlotInfo_e__Struct
    FWActivationCapabilities : this._FWActivationCapabilities_e__Struct
    Reserved3 : UInt8[13]
    SlotFWRevisions : CHAR[64]
    struct _FWSlotInfo_e__Struct {
        _bitfield : UInt8
    }
    struct _FWActivationCapabilities_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_MAILBOX_TRANSFER_FIRMWARE_ACTION extends Int32 {
    static CxlMailboxTransferFWAction_FullFWTransfer := 0
    static CxlMailboxTransferFWAction_InitiateFWTransfer := 1
    static CxlMailboxTransferFWAction_ContinueFWTransfer := 2
    static CxlMailboxTransferFWAction_EndTransfer := 3
    static CxlMailboxTransferFWAction_AbortTransfer := 4
    static CxlMailboxTransferFWAction_Max := 5
}
struct CXL_MAILBOX_TRANSFER_FIRMWARE {
    Action : UInt8
    Slot : UInt8
    Reserved : UInt16
    Offset : UInt32
    Reserved2 : UInt8[120]
    Data : UInt8[1]
}
struct CXL_MAILBOX_ACTIVATE_FIRMWARE_ACTION extends Int32 {
    static CxlMailboxActivateFWAction_Online := 0
    static CxlMailboxActivateFWAction_OnNextReset := 1
    static CxlMailboxActivateFWAction_Max := 2
}
struct CXL_MAILBOX_ACTIVATE_FIRMWARE {
    Action : UInt8
    Slot : UInt8
}
struct CXL_MAILBOX_SUPPORTED_LOG_ENTRY {
    LogIdentifier : GUID
    LogSize : UInt32
}
struct CXL_MAILBOX_GET_SUPPORTED_LOGS {
    NumberOfSupportedLogsEntries : UInt16
    Reserved : UInt8[6]
    SupportedLogEntries : CXL_MAILBOX_SUPPORTED_LOG_ENTRY[1]
}
struct CXL_MAILBOX_GET_LOG_CAPABILITIES_INPUT {
    LogIdentifier : GUID
}
struct CXL_MAILBOX_GET_LOG_CAPABILITIES_OUTPUT {
    _bitfield : UInt32
}
struct CXL_MAILBOX_GET_LOG_INPUT {
    LogIdentifier : GUID
    Offset : UInt32
    Length : UInt32
}
struct CXL_MAILBOX_CEL_ENTRY {
    Opcode : UInt16
    CommandEffect : this._CommandEffect_e__Struct
    struct _CommandEffect_e__Struct {
        _bitfield : UInt16
    }
}
struct CXL_MAILBOX_CEL_LOG {
    LogEntry : CXL_MAILBOX_CEL_ENTRY[1]
}
struct CXL_EVENT_RECORD_SEVERITY extends Int32 {
    static CxlEventRecordSeverity_Informational := 0
    static CxlEventRecordSeverity_Warning := 1
    static CxlEventRecordSeverity_Failure := 2
    static CxlEventRecordSeverity_Fatal := 3
    static CxlEventRecordSeverity_Max := 4
}
struct CXL_MAILBOX_INTERRUPT_POLICY_MODE extends Int32 {
    static CxlMailboxInterruptPolicyMode_NoInterrupts := 0
    static CxlMailboxInterruptPolicyMode_MsiMsiX := 1
    static CxlMailboxInterruptPolicyMode_FwInterrupt := 2
    static CxlMailboxInterruptPolicyMode_Reserved := 3
}
struct CXL_INTERRUPT_POLICY {
    _bitfield : UInt8
}
struct CXL_MAILBOX_INTERRUPT_POLICY {
    InformationalEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    WarningEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    FailureEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    FatalEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    DynamicCapacityEventLogInterruptSettings : CXL_INTERRUPT_POLICY
}
struct CXL_MAILBOX_INTERRUPT_POLICY_2_0 {
    InformationalEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    WarningEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    FailureEventLogInterruptSettings : CXL_INTERRUPT_POLICY
    FatalEventLogInterruptSettings : CXL_INTERRUPT_POLICY
}
struct CXL_MAILBOX_INJECT_POISON_INPUT {
    InjectPoisonPhysicalAddress : Int64
}
struct CXL_MAILBOX_CLEAR_POISON_INPUT {
    ClearPoisonPhysicalAddress : Int64
    ClearPoisonWriteData : UInt8[64]
}
struct CXL_MAILBOX_GET_POISON_LIST_INPUT {
    _bitfield : Int64
    PhysicalAddressLength : Int64
}
struct CXL_MAILBOX_MEDIA_ERROR_RECORD_SOURCE extends Int32 {
    static CxlMailboxErrorRecordSource_Unknown := 0
    static CxlMailboxErrorRecordSource_External := 1
    static CxlMailboxErrorRecordSource_Internal := 2
    static CxlMailboxErrorRecordSource_Injected := 3
    static CxlMailboxErrorRecordSource_VendorSpecific := 4
    static CxlMailboxErrorRecordSource_Max := 5
}
struct CXL_MAILBOX_MEDIA_ERROR_RECORD {
    _bitfield : Int64
    MediaErrorLength : UInt32
    Reserved1 : UInt8[4]
}
struct CXL_MAILBOX_GET_POISON_LIST_OUTPUT {
    PoisonListFlags : this._PoisonListFlags_e__Struct
    Reserved : UInt8
    OverflowTimestamp : Int64
    MediaErrorRecordCount : UInt16
    Reserved1 : UInt8[20]
    MediaErrorRecords : CXL_MAILBOX_MEDIA_ERROR_RECORD[1]
    struct _PoisonListFlags_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_COMMON_EVENT_RECORD_HEADER {
    EventRecordIdentifier : GUID
    EventRecordLength : UInt8
    EventRecordFlags : this._EventRecordFlags_e__Union
    Reserved : UInt8
    EventRecordHandle : UInt16
    RelatedEventRecordHandle : UInt16
    EventRecordTimestamp : Int64
    MaintenanceOperationClass : UInt8
    MaintenanceOperationSubclass : UInt8
    LdId : UInt16
    HeadId : UInt8
    Reserved1 : UInt8[11]
    struct _EventRecordFlags_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUshort : UInt16
        }
        struct _bits_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct CXL_COMMON_EVENT_RECORD {
    Header : CXL_COMMON_EVENT_RECORD_HEADER
    EventRecordData : UInt8[80]
}
struct CXL_TRANSACTION_TYPE extends Int32 {
    static CxlTransactionType_Unknown := 0
    static CxlTransactionType_HostRead := 1
    static CxlTransactionType_HostWrite := 2
    static CxlTransactionType_HostScanMedia := 3
    static CxlTransactionType_HostInjectPoison := 4
    static CxlTransactionType_MediaPatrolScrub := 5
    static CxlTransactionType_MediaManagement := 6
    static CxlTransactionType_InternalMediaCheckScrub := 7
    static CxlTransactionType_MediaInitialization := 8
}
struct CXL_MEMORY_EVENT_SUBTYPE extends Int32 {
    static CxlMemoryEventSubtype_NotReported := 0
    static CxlMemoryEventSubtype_InternalDatapathError := 1
    static CxlMemoryEventSubtype_MediaLinkCommandTrainingError := 2
    static CxlMemoryEventSubtype_MediaLinkDataTrainingError := 3
    static CxlMemoryEventSubtype_MediaLinkCrcError := 4
}
struct CXL_GENERAL_MEDIA_EVENT_TYPE extends Int32 {
    static CxlGeneralMediaEventType_MediaEccError := 0
    static CxlGeneralMediaEventType_InvAddress := 1
    static CxlGeneralMediaEventType_DataPathError := 2
    static CxlGeneralMediaEventType_TeStateViolation := 3
    static CxlGeneralMediaEventType_ScrubMediaEccError := 4
    static CxlGeneralMediaEventType_AdvProgCorrMemErrCounterExp := 5
    static CxlGeneralMediaEventType_CkidViolation := 6
}
struct CXL_GENERAL_MEDIA_EVENT_RECORD {
    Header : CXL_COMMON_EVENT_RECORD_HEADER
    PhysicalAddress : this._PhysicalAddress_e__Struct
    MemoryEventDescriptor : this._MemoryEventDescriptor_e__Struct
    MemoryEventType : UInt8
    TransactionType : UInt8
    ValidityFlags : this._ValidityFlags_e__Struct
    Channel : UInt8
    Rank : UInt8
    Device : UInt8[3]
    ComponentIdentifier : UInt8[16]
    AdvProgCorrMemErrThresholdEventFlags : this._AdvProgCorrMemErrThresholdEventFlags_e__Struct
    CorrectedMemoryCountAtEvent : UInt8[3]
    MemoryEventSubType : UInt8
    Reserved : UInt8[41]
    struct _PhysicalAddress_e__Struct {
        _bitfield : Int64
    }
    struct _MemoryEventDescriptor_e__Struct {
        _bitfield : UInt8
    }
    struct _ValidityFlags_e__Struct {
        _bitfield : UInt16
    }
    struct _AdvProgCorrMemErrThresholdEventFlags_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_DRAM_EVENT_TYPE extends Int32 {
    static CxlDRAMEventType_MediaEccError := 0
    static CxlDRAMEventType_ScrubMediaEccError := 1
    static CxlDRAMEventType_InvAddress := 2
    static CxlDRAMEventType_DataPathError := 3
    static CxlDRAMEventType_TeStateViolation := 4
    static CxlDRAMEventType_AdvProgCorrMemErrCounterExp := 5
    static CxlDRAMEventType_CkidViolation := 6
}
struct CXL_DRAM_EVENT_RECORD {
    Header : CXL_COMMON_EVENT_RECORD_HEADER
    PhysicalAddress : this._PhysicalAddress_e__Struct
    MemoryEventDescriptor : this._MemoryEventDescriptor_e__Struct
    MemoryEventType : UInt8
    TransactionType : UInt8
    ValidityFlags : this._ValidityFlags_e__Struct
    Channel : UInt8
    Rank : UInt8
    NibbleMask : UInt8[3]
    BankGroup : UInt8
    Bank : UInt8
    Row : UInt8[3]
    Column : UInt8[2]
    CorrectionMask : UInt8[32]
    ComponentIdentifier : UInt8[16]
    SubChannel : UInt8
    AdvProgCorrMemErrThresholdEventFlags : this._AdvProgCorrMemErrThresholdEventFlags_e__Struct
    CVMECountAtEvent : UInt8[3]
    MemoryEventSubType : UInt8
    Reserved : UInt8
    struct _PhysicalAddress_e__Struct {
        _bitfield : Int64
    }
    struct _MemoryEventDescriptor_e__Struct {
        _bitfield : UInt8
    }
    struct _ValidityFlags_e__Struct {
        _bitfield : UInt16
    }
    struct _AdvProgCorrMemErrThresholdEventFlags_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_MEDIA_STATUS extends Int32 {
    static CxlMediaStatus_Normal := 0
    static CxlMediaStatus_NotReady := 1
    static CxlMediaStatus_WritePersistencyLost := 2
    static CxlMediaStatus_AllDataLost := 3
    static CxlMediaStatus_WritePersistencyLossPowerLoss := 4
    static CxlMediaStatus_WritePersistencyLossShutdown := 5
    static CxlMediaStatus_WritePersistencyLossImminent := 6
    static CxlMediaStatus_AllDataLossPowerLoss := 7
    static CxlMediaStatus_AllDataLossShutdown := 8
    static CxlMediaStatus_AllDataLossImminent := 9
}
struct CXL_ADDITIONAL_HEALTH_STATUS extends Int32 {
    static CxlAdditionalHealthStatus_Normal := 0
    static CxlAdditionalHealthStatus_Warning := 1
    static CxlAdditionalHealthStatus_Critical := 2
}
struct CXL_DEVICE_HEALTH_INFO {
    HealthStatus : this._HealthStatus_e__Union
    MediaStatus : UInt8
    AdditionalStatus : this._AdditionalStatus_e__Union
    LifeUsed : UInt8
    DeviceTemperature : UInt16
    DirtyShutdownCount : UInt32
    CorrectedVolatileErrorCount : UInt32
    CorrectedPersistentErrorCount : UInt32
    struct _HealthStatus_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _AdditionalStatus_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct CXL_DEVICE_EVENT_TYPE extends Int32 {
    static CxlDeviceEventType_HealthStatusChange := 0
    static CxlDeviceEventType_MediaStatusChange := 1
    static CxlDeviceEventType_LifeUsedChange := 2
    static CxlDeviceEventType_TemperatureChange := 3
    static CxlDeviceEventType_DataPathError := 4
    static CxlDeviceEventType_LsaError := 5
    static CxlDeviceEventType_UnrecorverableInternalSideBandBusError := 6
    static CxlDeviceEventType_MemoryMediaFruError := 7
    static CxlDeviceEventType_PowerManagementFault := 8
}
struct CXL_DEVICE_EVENT_SUBTYPE extends Int32 {
    static CxlDeviceEventSubtype_NotReported := 0
    static CxlDeviceEventSubtype_InvalidConfigurationData := 1
    static CxlDeviceEventSubtype_UnsupportedConfigurationData := 2
    static CxlDeviceEventSubtype_UnsuportedMemoryMediaFru := 3
}
struct CXL_MEMORY_MODULE_EVENT_RECORD {
    Header : CXL_COMMON_EVENT_RECORD_HEADER
    DeviceEventType : UInt8
    DeviceHealthInfo : CXL_DEVICE_HEALTH_INFO
    ValidityFlags : this._ValidityFlags_e__Struct
    ComponentIdentifier : UInt8[16]
    DeviceEventSubtype : UInt8
    Reserved : UInt8[42]
    struct _ValidityFlags_e__Struct {
        _bitfield : UInt16
    }
}
struct CXL_SPARING_RESULT extends Int32 {
    static CxlSparingResult_Success := 0
    static CxlSparingResult_ResourcesExhausted := 1
    static CxlSparingResult_GeneralFailure := 255
}
struct CXL_SPARE_RESOURCES extends Int32 {
    static CxlSpareResources_NoneAvailable := 0
    static CxlSpareResources_OneAvailable := 1
    static CxlSpareResources_TwoAvailable := 2
    static CxlSpareResources_ThreeOrMoreAvailable := 3
}
struct CXL_MEMORY_SPARING_EVENT_RECORD {
    Header : CXL_COMMON_EVENT_RECORD_HEADER
    MaintenanceOperationClass : UInt8
    MaintenanceOperationSubclass : UInt8
    Flags : this._Flags_e__Struct
    Result : UInt8
    ValidityFlags : this._ValidityFlags_e__Struct
    Reserved : UInt8[6]
    SpareResourceAvailable : UInt16
    Channel : UInt8
    Rank : UInt8
    NibbleMask : UInt8[3]
    BankGroup : UInt8
    Bank : UInt8
    Row : UInt8[3]
    Column : UInt8[2]
    ComponentIdentifier : UInt8[16]
    SubChannel : UInt8
    Reserved3 : UInt8[37]
    struct _Flags_e__Struct {
        _bitfield : UInt8
    }
    struct _ValidityFlags_e__Struct {
        _bitfield : UInt16
    }
}
struct CXL_MAILBOX_EVENT_LOG extends Int32 {
    static CxlMailboxEventRecords_InformationalEventLog := 0
    static CxlMailboxEventRecords_WarningEventLog := 1
    static CxlMailboxEventRecords_FailureEventLog := 2
    static CxlMailboxEventRecords_FatalEventLog := 3
    static CxlMailboxEventRecords_DynamicCapacityEventLog := 4
}
struct CXL_MAILBOX_GET_EVENT_RECORDS_INPUT {
    EventLog : UInt8
}
struct CXL_MAILBOX_GET_EVENT_RECORDS_OUTPUT {
    Flags : this._Flags_e__Struct
    Reserved : UInt8
    OverflowErrorCount : UInt16
    FirstOverflowEventTimestamp : Int64
    LastOverflowEventTimestamp : Int64
    EventRecordCount : UInt16
    Reserved1 : UInt8[10]
    EventRecords : CXL_COMMON_EVENT_RECORD[1]
    struct _Flags_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_MAILBOX_CLEAR_EVENT_RECORDS_INPUT {
    EventLog : UInt8
    ClearEventFlags : this._ClearEventFlags_e__Struct
    NumberOfEventRecordHandles : UInt8
    Reserved : UInt8[3]
    EventRecordHandles : UInt16[1]
    struct _ClearEventFlags_e__Struct {
        _bitfield : UInt8
    }
}
struct CXL_MAILBOX_GET_ALERT_CONFIG_OUTPUT {
    ValidAlerts : this._ValidAlerts_e__Union
    ProgrammableAlerts : this._ProgrammableAlerts_e__Union
    LifeUsedCriticalThreshold : UInt8
    LifeUsedProgrammableWarningThreshold : UInt8
    DeviceOverTemperatureCriticalThreshold : UInt16
    DeviceUnderTemperatureCriticalThreshold : UInt16
    DeviceOverTemperatureProgrammableWarningThreshold : UInt16
    DeviceUnderTemperatureProgrammableWarningThreshold : UInt16
    CorrectedVolatileMemoryProgrammableWarningThreshold : UInt16
    CorrectedPersistentMemoryProgrammableWarningThreshold : UInt16
    struct _ValidAlerts_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _ProgrammableAlerts_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct CXL_MAILBOX_SET_ALERT_CONFIG_INPUT {
    ValidAlertActions : this._ValidAlertActions_e__Union
    EnableAlertActions : this._EnableAlertActions_e__Union
    LifeUsedProgrammableWarningThreshold : UInt8
    Reserved : UInt8
    DeviceOverTemperatureProgrammableWarningThreshold : UInt16
    DeviceUnderTemperatureProgrammableWarningThreshold : UInt16
    CorrectedVolatileMemoryProgrammableWarningThreshold : UInt16
    CorrectedPersistentMemoryProgrammableWarningThreshold : UInt16
    struct _ValidAlertActions_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _EnableAlertActions_e__Union {
        union {
            bits : this._bits_e__Struct
            AsUchar : UInt8
        }
        struct _bits_e__Struct {
            _bitfield : UInt8
        }
    }
}
