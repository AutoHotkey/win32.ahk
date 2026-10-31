#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {NTSTATUS}

struct HFILTER {
    Value : IntPtr
}
struct HFILTER_INSTANCE {
    Value : IntPtr
}
struct FLT_FILESYSTEM_TYPE extends Int32 {
    static FLT_FSTYPE_UNKNOWN := 0
    static FLT_FSTYPE_RAW := 1
    static FLT_FSTYPE_NTFS := 2
    static FLT_FSTYPE_FAT := 3
    static FLT_FSTYPE_CDFS := 4
    static FLT_FSTYPE_UDFS := 5
    static FLT_FSTYPE_LANMAN := 6
    static FLT_FSTYPE_WEBDAV := 7
    static FLT_FSTYPE_RDPDR := 8
    static FLT_FSTYPE_NFS := 9
    static FLT_FSTYPE_MS_NETWARE := 10
    static FLT_FSTYPE_NETWARE := 11
    static FLT_FSTYPE_BSUDF := 12
    static FLT_FSTYPE_MUP := 13
    static FLT_FSTYPE_RSFX := 14
    static FLT_FSTYPE_ROXIO_UDF1 := 15
    static FLT_FSTYPE_ROXIO_UDF2 := 16
    static FLT_FSTYPE_ROXIO_UDF3 := 17
    static FLT_FSTYPE_TACIT := 18
    static FLT_FSTYPE_FS_REC := 19
    static FLT_FSTYPE_INCD := 20
    static FLT_FSTYPE_INCD_FAT := 21
    static FLT_FSTYPE_EXFAT := 22
    static FLT_FSTYPE_PSFS := 23
    static FLT_FSTYPE_GPFS := 24
    static FLT_FSTYPE_NPFS := 25
    static FLT_FSTYPE_MSFS := 26
    static FLT_FSTYPE_CSVFS := 27
    static FLT_FSTYPE_REFS := 28
    static FLT_FSTYPE_OPENAFS := 29
    static FLT_FSTYPE_CIMFS := 30
}
struct FILTER_INFORMATION_CLASS extends Int32 {
    static FilterFullInformation := 0
    static FilterAggregateBasicInformation := 1
    static FilterAggregateStandardInformation := 2
}
struct FILTER_FULL_INFORMATION {
    NextEntryOffset : UInt32
    FrameID : UInt32
    NumberOfInstances : UInt32
    FilterNameLength : UInt16
    FilterNameBuffer : UInt16[1]
}
struct FILTER_AGGREGATE_BASIC_INFORMATION {
    NextEntryOffset : UInt32
    Flags : UInt32
    Type : this._Type_e__Union
    struct _Type_e__Union {
        union {
            MiniFilter : this._MiniFilter_e__Struct
            LegacyFilter : this._LegacyFilter_e__Struct
        }
        struct _MiniFilter_e__Struct {
            FrameID : UInt32
            NumberOfInstances : UInt32
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
            FilterAltitudeLength : UInt16
            FilterAltitudeBufferOffset : UInt16
        }
        struct _LegacyFilter_e__Struct {
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
        }
    }
}
struct FILTER_AGGREGATE_STANDARD_INFORMATION {
    NextEntryOffset : UInt32
    Flags : UInt32
    Type : this._Type_e__Union
    struct _Type_e__Union {
        union {
            MiniFilter : this._MiniFilter_e__Struct
            LegacyFilter : this._LegacyFilter_e__Struct
        }
        struct _MiniFilter_e__Struct {
            Flags : UInt32
            FrameID : UInt32
            NumberOfInstances : UInt32
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
            FilterAltitudeLength : UInt16
            FilterAltitudeBufferOffset : UInt16
        }
        struct _LegacyFilter_e__Struct {
            Flags : UInt32
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
            FilterAltitudeLength : UInt16
            FilterAltitudeBufferOffset : UInt16
        }
    }
}
struct FILTER_VOLUME_INFORMATION_CLASS extends Int32 {
    static FilterVolumeBasicInformation := 0
    static FilterVolumeStandardInformation := 1
}
struct FILTER_VOLUME_BASIC_INFORMATION {
    FilterVolumeNameLength : UInt16
    FilterVolumeName : UInt16[1]
}
struct FILTER_VOLUME_STANDARD_INFORMATION {
    NextEntryOffset : UInt32
    Flags : UInt32
    FrameID : UInt32
    FileSystemType : FLT_FILESYSTEM_TYPE
    FilterVolumeNameLength : UInt16
    FilterVolumeName : UInt16[1]
}
struct INSTANCE_INFORMATION_CLASS extends Int32 {
    static InstanceBasicInformation := 0
    static InstancePartialInformation := 1
    static InstanceFullInformation := 2
    static InstanceAggregateStandardInformation := 3
}
struct INSTANCE_BASIC_INFORMATION {
    NextEntryOffset : UInt32
    InstanceNameLength : UInt16
    InstanceNameBufferOffset : UInt16
}
struct INSTANCE_PARTIAL_INFORMATION {
    NextEntryOffset : UInt32
    InstanceNameLength : UInt16
    InstanceNameBufferOffset : UInt16
    AltitudeLength : UInt16
    AltitudeBufferOffset : UInt16
}
struct INSTANCE_FULL_INFORMATION {
    NextEntryOffset : UInt32
    InstanceNameLength : UInt16
    InstanceNameBufferOffset : UInt16
    AltitudeLength : UInt16
    AltitudeBufferOffset : UInt16
    VolumeNameLength : UInt16
    VolumeNameBufferOffset : UInt16
    FilterNameLength : UInt16
    FilterNameBufferOffset : UInt16
}
struct INSTANCE_AGGREGATE_STANDARD_INFORMATION {
    NextEntryOffset : UInt32
    Flags : UInt32
    Type : this._Type_e__Union
    struct _Type_e__Union {
        union {
            MiniFilter : this._MiniFilter_e__Struct
            LegacyFilter : this._LegacyFilter_e__Struct
        }
        struct _MiniFilter_e__Struct {
            Flags : UInt32
            FrameID : UInt32
            VolumeFileSystemType : FLT_FILESYSTEM_TYPE
            InstanceNameLength : UInt16
            InstanceNameBufferOffset : UInt16
            AltitudeLength : UInt16
            AltitudeBufferOffset : UInt16
            VolumeNameLength : UInt16
            VolumeNameBufferOffset : UInt16
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
            SupportedFeatures : UInt32
        }
        struct _LegacyFilter_e__Struct {
            Flags : UInt32
            AltitudeLength : UInt16
            AltitudeBufferOffset : UInt16
            VolumeNameLength : UInt16
            VolumeNameBufferOffset : UInt16
            FilterNameLength : UInt16
            FilterNameBufferOffset : UInt16
            SupportedFeatures : UInt32
        }
    }
}
struct FILTER_MESSAGE_HEADER {
    ReplyLength : UInt32
    MessageId : Int64
}
struct FILTER_REPLY_HEADER {
    Status : NTSTATUS
    MessageId : Int64
}
