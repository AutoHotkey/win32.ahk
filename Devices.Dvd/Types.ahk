#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE}

struct DVD_KEY_TYPE extends Int32 {
    static DvdChallengeKey := 1
    static DvdBusKey1 := 2
    static DvdBusKey2 := 3
    static DvdTitleKey := 4
    static DvdAsf := 5
    static DvdSetRpcKey := 6
    static DvdGetRpcKey := 8
    static DvdDiskKey := 128
    static DvdInvalidateAGID := 63
}
struct DVD_COPY_PROTECT_KEY {
    KeyLength : UInt32
    SessionId : UInt32
    KeyType : DVD_KEY_TYPE
    KeyFlags : UInt32
    Parameters : this._Parameters_e__Union
    KeyData : UInt8[1]
    struct _Parameters_e__Union {
        union {
            FileHandle : HANDLE
            TitleOffset : Int64
        }
    }
}
struct STORAGE_SET_READ_AHEAD {
    TriggerAddress : Int64
    TargetAddress : Int64
}
struct DVD_STRUCTURE_FORMAT extends Int32 {
    static DvdPhysicalDescriptor := 0
    static DvdCopyrightDescriptor := 1
    static DvdDiskKeyDescriptor := 2
    static DvdBCADescriptor := 3
    static DvdManufacturerDescriptor := 4
    static DvdMaxDescriptor := 5
}
struct DVD_READ_STRUCTURE {
    BlockByteOffset : Int64
    Format : DVD_STRUCTURE_FORMAT
    SessionId : UInt32
    LayerNumber : UInt8
}
struct DVD_DESCRIPTOR_HEADER {
    Length : UInt16
    Reserved : UInt8[2]
    Data : UInt8[1]
}
struct DVD_LAYER_DESCRIPTOR {
    _bitfield1 : UInt8
    _bitfield2 : UInt8
    _bitfield3 : UInt8
    _bitfield4 : UInt8
    StartingDataSector : UInt32
    EndDataSector : UInt32
    EndLayerZeroSector : UInt32
    _bitfield5 : UInt8
}
struct DVD_FULL_LAYER_DESCRIPTOR {
    commonHeader : DVD_LAYER_DESCRIPTOR
    MediaSpecific : UInt8[2031]
}
struct DVD_COPYRIGHT_DESCRIPTOR {
    CopyrightProtectionType : UInt8
    RegionManagementInformation : UInt8
    Reserved : UInt16
}
struct DVD_DISK_KEY_DESCRIPTOR {
    DiskKeyData : UInt8[2048]
}
struct DVD_BCA_DESCRIPTOR {
    BCAInformation : UInt8[1]
}
struct DVD_MANUFACTURER_DESCRIPTOR {
    ManufacturingInformation : UInt8[2048]
}
struct DVD_COPYRIGHT_MANAGEMENT_DESCRIPTOR {
    Anonymous : this._Anonymous_e__Union
    Reserved0 : UInt8[3]
    struct _Anonymous_e__Union {
        union {
            Dvdrom : this._Dvdrom_e__Struct
            DvdRecordable_Version1 : this._DvdRecordable_Version1_e__Struct
            Dvdram : this._Dvdram_e__Struct
            DvdRecordable : this._DvdRecordable_e__Struct
            CPR_MAI : UInt8
        }
        struct _Dvdrom_e__Struct {
            _bitfield : UInt8
        }
        struct _DvdRecordable_Version1_e__Struct {
            _bitfield : UInt8
        }
        struct _Dvdram_e__Struct {
            Reserved0003 : UInt8
        }
        struct _DvdRecordable_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct DVD_RAM_MEDIUM_STATUS {
    _bitfield : UInt8
    DiscTypeIdentification : UInt8
    Reserved2 : UInt8
    MediaSpecificWriteInhibitInformation : UInt8
}
struct DVD_RAM_SPARE_AREA_INFORMATION {
    FreePrimarySpareSectors : UInt8[4]
    FreeSupplementalSpareSectors : UInt8[4]
    AllocatedSupplementalSpareSectors : UInt8[4]
}
struct DVD_RAM_RECORDING_TYPE {
    _bitfield : UInt8
    Reserved2 : UInt8[3]
}
struct DVD_RECORDING_MANAGEMENT_AREA_DATA {
    LastRecordedRMASectorNumber : UInt8[4]
    RMDBytes : UInt8[1]
}
struct DVD_PRERECORDED_INFORMATION {
    FieldID_1 : UInt8
    DiscApplicationCode : UInt8
    DiscPhysicalCode : UInt8
    LastAddressOfDataRecordableArea : UInt8[3]
    _bitfield : UInt8
    Reserved0 : UInt8
    FieldID_2 : UInt8
    OpcSuggestedCode : UInt8
    WavelengthCode : UInt8
    WriteStrategyCode : UInt8[4]
    Reserved2 : UInt8
    FieldID_3 : UInt8
    ManufacturerId_3 : UInt8[6]
    Reserved3 : UInt8
    FieldID_4 : UInt8
    ManufacturerId_4 : UInt8[6]
    Reserved4 : UInt8
    FieldID_5 : UInt8
    ManufacturerId_5 : UInt8[6]
    Reserved5 : UInt8
    Reserved99 : UInt8[24]
}
struct DVD_UNIQUE_DISC_IDENTIFIER {
    Reserved0 : UInt8[2]
    RandomNumber : UInt8[2]
    Year : UInt8[4]
    Month : UInt8[2]
    Day : UInt8[2]
    Hour : UInt8[2]
    Minute : UInt8[2]
    Second : UInt8[2]
}
struct HD_DVD_R_MEDIUM_STATUS {
    _bitfield : UInt8
    NumberOfRemainingRMDsInRDZ : UInt8
    NumberOfRemainingRMDsInCurrentRMZ : UInt8[2]
}
struct DVD_DUAL_LAYER_RECORDING_INFORMATION {
    _bitfield : UInt8
    Reserved1 : UInt8[3]
    Layer0Sectors : UInt8[4]
}
struct DVD_DUAL_LAYER_MIDDLE_ZONE_START_ADDRESS {
    _bitfield : UInt8
    Reserved1 : UInt8[3]
    ShiftedMiddleAreaStartAddress : UInt8[4]
}
struct DVD_DUAL_LAYER_JUMP_INTERVAL_SIZE {
    Reserved1 : UInt8[4]
    JumpIntervalSize : UInt8[4]
}
struct DVD_DUAL_LAYER_MANUAL_LAYER_JUMP {
    Reserved1 : UInt8[4]
    ManualJumpLayerAddress : UInt8[4]
}
struct DVD_DUAL_LAYER_REMAPPING_INFORMATION {
    Reserved1 : UInt8[4]
    RemappingAddress : UInt8[4]
}
struct DVD_DISC_CONTROL_BLOCK_HEADER {
    ContentDescriptor : UInt8[4]
    ProhibitedActions : this._ProhibitedActions_e__Union
    VendorId : UInt8[32]
    struct _ProhibitedActions_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsByte : UInt8[4]
        }
        struct _Anonymous_e__Struct {
            ReservedDoNotUse_UseAsByteInstead_0 : UInt8[3]
            _bitfield : UInt8
        }
    }
}
struct DISC_CONTROL_BLOCK_TYPE extends Int32 {
    static FormattingDiscControlBlock := 1178878720
    static WriteInhibitDiscControlBlock := 1464091392
    static SessionInfoDiscControlBlock := 1396982528
    static DiscControlBlockList := -1
}
struct DVD_DISC_CONTROL_BLOCK_WRITE_INHIBIT {
    header : DVD_DISC_CONTROL_BLOCK_HEADER
    UpdateCount : UInt8[4]
    WriteProtectActions : this._WriteProtectActions_e__Union
    Reserved0 : UInt8[16]
    UpdatePassword : UInt8[32]
    Reserved1 : UInt8[32672]
    struct _WriteProtectActions_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsByte : UInt8[4]
        }
        struct _Anonymous_e__Struct {
            ReservedDoNotUse_UseAsByteInstead_0 : UInt8[3]
            _bitfield : UInt8
        }
    }
}
struct DVD_DISC_CONTROL_BLOCK_SESSION_ITEM {
    AsByte : UInt8[16]
}
struct DVD_DISC_CONTROL_BLOCK_SESSION {
    header : DVD_DISC_CONTROL_BLOCK_HEADER
    SessionNumber : UInt8[2]
    Reserved0 : UInt8[22]
    DiscID : UInt8[32]
    Reserved1 : UInt8[32]
    SessionItem : DVD_DISC_CONTROL_BLOCK_SESSION_ITEM[504]
    Reserved2 : UInt8[24576]
}
struct DVD_DISC_CONTROL_BLOCK_LIST_DCB {
    DcbIdentifier : UInt8[4]
}
struct DVD_DISC_CONTROL_BLOCK_LIST {
    header : DVD_DISC_CONTROL_BLOCK_HEADER
    Reserved0 : UInt8
    ReadabldDCBs : UInt8
    Reserved1 : UInt8
    WritableDCBs : UInt8
    Dcbs : DVD_DISC_CONTROL_BLOCK_LIST_DCB[1]
}
struct DVD_WRITE_PROTECTION_STATUS {
    _bitfield : UInt8
    Reserved1 : UInt8[3]
}
struct DVD_LIST_OF_RECOGNIZED_FORMAT_LAYERS {
    TypeCodeOfFormatLayer : UInt8[2]
}
struct DVD_LIST_OF_RECOGNIZED_FORMAT_LAYERS_TYPE_CODE {
    NumberOfRecognizedFormatLayers : UInt8
    _bitfield : UInt8
}
struct DVD_STRUCTURE_LIST_ENTRY {
    FormatCode : UInt8
    _bitfield : UInt8
    FormatLength : UInt8[2]
}
struct DVD_BD_SPARE_AREA_INFORMATION {
    Reserved1 : UInt8[4]
    NumberOfFreeSpareBlocks : UInt8[4]
    NumberOfAllocatedSpareBlocks : UInt8[4]
}
struct BD_PAC_HEADER {
    PACId : UInt8[3]
    PACFormatNumber : UInt8
    PACUpdateCount : UInt8[4]
    UnknownPACRules : UInt8[4]
    UnkownPACEntireDiscFlag : UInt8
    Reserved1 : UInt8[2]
    NumberOfSegments : UInt8
    Segments : UInt8[256]
    Reserved2 : UInt8[112]
}
struct BD_DISC_WRITE_PROTECT_PAC {
    Header : BD_PAC_HEADER
    KnownPACEntireDiscFlags : UInt8
    Reserved1 : UInt8[3]
    WriteProtectControlByte : UInt8
    Reserved2 : UInt8[7]
    WriteProtectPassword : UInt8[32]
}
struct DVD_RPC_KEY {
    _bitfield : UInt8
    RegionMask : UInt8
    RpcScheme : UInt8
    Reserved02 : UInt8
}
struct DVD_SET_RPC_KEY {
    PreferredDriveRegionCode : UInt8
    Reserved : UInt8[3]
}
struct DVD_ASF {
    Reserved0 : UInt8[3]
    _bitfield : UInt8
}
struct DVD_REGION {
    CopySystem : UInt8
    RegionData : UInt8
    SystemRegion : UInt8
    ResetCount : UInt8
}
struct AACS_CERTIFICATE {
    Nonce : UInt8[20]
    Certificate : UInt8[92]
}
struct AACS_CHALLENGE_KEY {
    EllipticCurvePoint : UInt8[40]
    Signature : UInt8[40]
}
struct AACS_VOLUME_ID {
    VolumeID : UInt8[16]
    MAC : UInt8[16]
}
struct AACS_SERIAL_NUMBER {
    PrerecordedSerialNumber : UInt8[16]
    MAC : UInt8[16]
}
struct AACS_MEDIA_ID {
    MediaID : UInt8[16]
    MAC : UInt8[16]
}
struct AACS_SEND_CERTIFICATE {
    SessionId : UInt32
    Certificate : AACS_CERTIFICATE
}
struct AACS_SEND_CHALLENGE_KEY {
    SessionId : UInt32
    ChallengeKey : AACS_CHALLENGE_KEY
}
struct AACS_BINDING_NONCE {
    BindingNonce : UInt8[16]
    MAC : UInt8[16]
}
struct AACS_READ_BINDING_NONCE {
    SessionId : UInt32
    NumberOfSectors : UInt32
    StartLba : Int64
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Handle : HANDLE
            ForceStructureLengthToMatch64bit : Int64
        }
    }
}
