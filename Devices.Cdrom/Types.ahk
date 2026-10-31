#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN}

struct CDROM_READ_TOC_EX {
    _bitfield : UInt8
    SessionTrack : UInt8
    Reserved2 : UInt8
    Reserved3 : UInt8
}
struct TRACK_DATA {
    Reserved : UInt8
    _bitfield : UInt8
    TrackNumber : UInt8
    Reserved1 : UInt8
    Address : UInt8[4]
}
struct CDROM_TOC {
    Length : UInt8[2]
    FirstTrack : UInt8
    LastTrack : UInt8
    TrackData : TRACK_DATA[100]
}
struct CDROM_TOC_SESSION_DATA {
    Length : UInt8[2]
    FirstCompleteSession : UInt8
    LastCompleteSession : UInt8
    TrackData : TRACK_DATA[1]
}
struct CDROM_TOC_FULL_TOC_DATA_BLOCK {
    SessionNumber : UInt8
    _bitfield : UInt8
    Reserved1 : UInt8
    Point : UInt8
    MsfExtra : UInt8[3]
    Zero : UInt8
    Msf : UInt8[3]
}
struct CDROM_TOC_FULL_TOC_DATA {
    Length : UInt8[2]
    FirstCompleteSession : UInt8
    LastCompleteSession : UInt8
    Descriptors : CDROM_TOC_FULL_TOC_DATA_BLOCK[1]
}
struct CDROM_TOC_PMA_DATA {
    Length : UInt8[2]
    Reserved1 : UInt8
    Reserved2 : UInt8
    Descriptors : CDROM_TOC_FULL_TOC_DATA_BLOCK[1]
}
struct CDROM_TOC_ATIP_DATA_BLOCK {
    _bitfield1 : UInt8
    _bitfield2 : UInt8
    _bitfield3 : UInt8
    Reserved7 : UInt8
    LeadInMsf : UInt8[3]
    Reserved8 : UInt8
    LeadOutMsf : UInt8[3]
    Reserved9 : UInt8
    A1Values : UInt8[3]
    Reserved10 : UInt8
    A2Values : UInt8[3]
    Reserved11 : UInt8
    A3Values : UInt8[3]
    Reserved12 : UInt8
}
struct CDROM_TOC_ATIP_DATA {
    Length : UInt8[2]
    Reserved1 : UInt8
    Reserved2 : UInt8
    Descriptors : CDROM_TOC_ATIP_DATA_BLOCK[1]
}
struct CDROM_TOC_CD_TEXT_DATA_BLOCK {
    PackType : UInt8
    _bitfield1 : UInt8
    SequenceNumber : UInt8
    _bitfield2 : UInt8
    Anonymous : this._Anonymous_e__Union
    CRC : UInt8[2]
    struct _Anonymous_e__Union {
        union {
            Text : UInt8[12]
            WText : UInt16[6]
        }
    }
}
struct CDROM_TOC_CD_TEXT_DATA {
    Length : UInt8[2]
    Reserved1 : UInt8
    Reserved2 : UInt8
    Descriptors : CDROM_TOC_CD_TEXT_DATA_BLOCK[1]
}
struct CDROM_PLAY_AUDIO_MSF {
    StartingM : UInt8
    StartingS : UInt8
    StartingF : UInt8
    EndingM : UInt8
    EndingS : UInt8
    EndingF : UInt8
}
struct CDROM_SEEK_AUDIO_MSF {
    M : UInt8
    S : UInt8
    F : UInt8
}
struct CDROM_DISK_DATA {
    DiskData : UInt32
}
struct CDROM_SUB_Q_DATA_FORMAT {
    Format : UInt8
    Track : UInt8
}
struct SUB_Q_HEADER {
    Reserved : UInt8
    AudioStatus : UInt8
    DataLength : UInt8[2]
}
struct SUB_Q_CURRENT_POSITION {
    Header : SUB_Q_HEADER
    FormatCode : UInt8
    _bitfield : UInt8
    TrackNumber : UInt8
    IndexNumber : UInt8
    AbsoluteAddress : UInt8[4]
    TrackRelativeAddress : UInt8[4]
}
struct SUB_Q_MEDIA_CATALOG_NUMBER {
    Header : SUB_Q_HEADER
    FormatCode : UInt8
    Reserved : UInt8[3]
    _bitfield : UInt8
    MediaCatalog : UInt8[15]
}
struct SUB_Q_TRACK_ISRC {
    Header : SUB_Q_HEADER
    FormatCode : UInt8
    Reserved0 : UInt8
    Track : UInt8
    Reserved1 : UInt8
    _bitfield : UInt8
    TrackIsrc : UInt8[15]
}
struct SUB_Q_CHANNEL_DATA {
    union {
        CurrentPosition : SUB_Q_CURRENT_POSITION
        MediaCatalog : SUB_Q_MEDIA_CATALOG_NUMBER
        TrackIsrc : SUB_Q_TRACK_ISRC
    }
}
struct VOLUME_CONTROL {
    PortVolume : UInt8[4]
}
struct TRACK_MODE_TYPE extends Int32 {
    static YellowMode2 := 0
    static XAForm2 := 1
    static CDDA := 2
    static RawWithC2AndSubCode := 3
    static RawWithC2 := 4
    static RawWithSubCode := 5
}
struct RAW_READ_INFO {
    DiskOffset : Int64
    SectorCount : UInt32
    TrackMode : TRACK_MODE_TYPE
}
struct MEDIA_BLANK_TYPE extends Int32 {
    static MediaBlankTypeFull := 0
    static MediaBlankTypeMinimal := 1
    static MediaBlankTypeIncompleteTrack := 2
    static MediaBlankTypeUnreserveLastTrack := 3
    static MediaBlankTypeTrackTail := 4
    static MediaBlankTypeUncloseLastSession := 5
    static MediaBlankTypeEraseLastSession := 6
}
struct EXCLUSIVE_ACCESS_REQUEST_TYPE extends Int32 {
    static ExclusiveAccessQueryState := 0
    static ExclusiveAccessLockDevice := 1
    static ExclusiveAccessUnlockDevice := 2
}
struct CDROM_EXCLUSIVE_ACCESS {
    RequestType : EXCLUSIVE_ACCESS_REQUEST_TYPE
    Flags : UInt32
}
struct CDROM_EXCLUSIVE_LOCK {
    Access : CDROM_EXCLUSIVE_ACCESS
    CallerName : UInt8[64]
}
struct CDROM_EXCLUSIVE_LOCK_STATE {
    LockState : BOOLEAN
    CallerName : UInt8[64]
}
struct CDROM_SPEED_REQUEST extends Int32 {
    static CdromSetSpeed := 0
    static CdromSetStreaming := 1
}
struct WRITE_ROTATION extends Int32 {
    static CdromDefaultRotation := 0
    static CdromCAVRotation := 1
}
struct CDROM_SET_SPEED {
    RequestType : CDROM_SPEED_REQUEST
    ReadSpeed : UInt16
    WriteSpeed : UInt16
    RotationControl : WRITE_ROTATION
}
struct CDROM_SET_STREAMING {
    RequestType : CDROM_SPEED_REQUEST
    ReadSize : UInt32
    ReadTime : UInt32
    WriteSize : UInt32
    WriteTime : UInt32
    StartLba : UInt32
    EndLba : UInt32
    RotationControl : WRITE_ROTATION
    RestoreDefaults : BOOLEAN
    SetExact : BOOLEAN
    RandomAccess : BOOLEAN
    Persistent : BOOLEAN
}
struct STREAMING_CONTROL_REQUEST_TYPE extends Int32 {
    static CdromStreamingDisable := 1
    static CdromStreamingEnableForReadOnly := 2
    static CdromStreamingEnableForWriteOnly := 3
    static CdromStreamingEnableForReadWrite := 4
}
struct CDROM_STREAMING_CONTROL {
    RequestType : STREAMING_CONTROL_REQUEST_TYPE
}
struct CDROM_OPC_INFO_TYPE extends Int32 {
    static SimpleOpcInfo := 1
}
struct CDROM_SIMPLE_OPC_INFO {
    RequestType : CDROM_OPC_INFO_TYPE
    Exclude0 : BOOLEAN
    Exclude1 : BOOLEAN
}
struct CDROM_PERFORMANCE_REQUEST_TYPE extends Int32 {
    static CdromPerformanceRequest := 1
    static CdromWriteSpeedRequest := 2
}
struct CDROM_PERFORMANCE_TYPE extends Int32 {
    static CdromReadPerformance := 1
    static CdromWritePerformance := 2
}
struct CDROM_PERFORMANCE_EXCEPTION_TYPE extends Int32 {
    static CdromNominalPerformance := 1
    static CdromEntirePerformanceList := 2
    static CdromPerformanceExceptionsOnly := 3
}
struct CDROM_PERFORMANCE_TOLERANCE_TYPE extends Int32 {
    static Cdrom10Nominal20Exceptions := 1
}
struct CDROM_PERFORMANCE_REQUEST {
    RequestType : CDROM_PERFORMANCE_REQUEST_TYPE
    PerformanceType : CDROM_PERFORMANCE_TYPE
    Exceptions : CDROM_PERFORMANCE_EXCEPTION_TYPE
    Tolerance : CDROM_PERFORMANCE_TOLERANCE_TYPE
    StaringLba : UInt32
}
struct CDROM_WRITE_SPEED_REQUEST {
    RequestType : CDROM_PERFORMANCE_REQUEST_TYPE
}
struct CDROM_PERFORMANCE_HEADER {
    DataLength : UInt8[4]
    _bitfield : UInt8
    Reserved2 : UInt8[3]
    Data : UInt8[1]
}
struct CDROM_NOMINAL_PERFORMANCE_DESCRIPTOR {
    StartLba : UInt8[4]
    StartPerformance : UInt8[4]
    EndLba : UInt8[4]
    EndPerformance : UInt8[4]
}
struct CDROM_EXCEPTION_PERFORMANCE_DESCRIPTOR {
    Lba : UInt8[4]
    Time : UInt8[2]
}
struct CDROM_WRITE_SPEED_DESCRIPTOR {
    _bitfield : UInt8
    Reserved3 : UInt8[3]
    EndLba : UInt8[4]
    ReadSpeed : UInt8[4]
    WriteSpeed : UInt8[4]
}
