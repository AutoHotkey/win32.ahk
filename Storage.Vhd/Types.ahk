#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

struct VIRTUAL_STORAGE_TYPE {
    DeviceId : UInt32
    VendorId : GUID
}
struct OPEN_VIRTUAL_DISK_VERSION extends Int32 {
    static OPEN_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static OPEN_VIRTUAL_DISK_VERSION_1 := 1
    static OPEN_VIRTUAL_DISK_VERSION_2 := 2
    static OPEN_VIRTUAL_DISK_VERSION_3 := 3
}
struct OPEN_VIRTUAL_DISK_PARAMETERS {
    Version : OPEN_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
            Version2 : this._Version2_e__Struct
            Version3 : this._Version3_e__Struct
        }
        struct _Version1_e__Struct {
            RWDepth : UInt32
        }
        struct _Version2_e__Struct {
            GetInfoOnly : BOOL
            ReadOnly : BOOL
            ResiliencyGuid : GUID
        }
        struct _Version3_e__Struct {
            GetInfoOnly : BOOL
            ReadOnly : BOOL
            ResiliencyGuid : GUID
            SnapshotId : GUID
        }
    }
}
struct VIRTUAL_DISK_ACCESS_MASK extends Int32 {
    static VIRTUAL_DISK_ACCESS_NONE := 0
    static VIRTUAL_DISK_ACCESS_ATTACH_RO := 65536
    static VIRTUAL_DISK_ACCESS_ATTACH_RW := 131072
    static VIRTUAL_DISK_ACCESS_DETACH := 262144
    static VIRTUAL_DISK_ACCESS_GET_INFO := 524288
    static VIRTUAL_DISK_ACCESS_CREATE := 1048576
    static VIRTUAL_DISK_ACCESS_METAOPS := 2097152
    static VIRTUAL_DISK_ACCESS_READ := 851968
    static VIRTUAL_DISK_ACCESS_ALL := 4128768
    static VIRTUAL_DISK_ACCESS_WRITABLE := 3276800
}
struct OPEN_VIRTUAL_DISK_FLAG extends Int32 {
    static OPEN_VIRTUAL_DISK_FLAG_NONE := 0
    static OPEN_VIRTUAL_DISK_FLAG_NO_PARENTS := 1
    static OPEN_VIRTUAL_DISK_FLAG_BLANK_FILE := 2
    static OPEN_VIRTUAL_DISK_FLAG_BOOT_DRIVE := 4
    static OPEN_VIRTUAL_DISK_FLAG_CACHED_IO := 8
    static OPEN_VIRTUAL_DISK_FLAG_CUSTOM_DIFF_CHAIN := 16
    static OPEN_VIRTUAL_DISK_FLAG_PARENT_CACHED_IO := 32
    static OPEN_VIRTUAL_DISK_FLAG_VHDSET_FILE_ONLY := 64
    static OPEN_VIRTUAL_DISK_FLAG_IGNORE_RELATIVE_PARENT_LOCATOR := 128
    static OPEN_VIRTUAL_DISK_FLAG_NO_WRITE_HARDENING := 256
    static OPEN_VIRTUAL_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES := 512
    static OPEN_VIRTUAL_DISK_FLAG_SUPPORT_SPARSE_FILES_ANY_FS := 1024
    static OPEN_VIRTUAL_DISK_FLAG_SUPPORT_ENCRYPTED_FILES := 2048
}
struct CREATE_VIRTUAL_DISK_VERSION extends Int32 {
    static CREATE_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static CREATE_VIRTUAL_DISK_VERSION_1 := 1
    static CREATE_VIRTUAL_DISK_VERSION_2 := 2
    static CREATE_VIRTUAL_DISK_VERSION_3 := 3
    static CREATE_VIRTUAL_DISK_VERSION_4 := 4
}
struct CREATE_VIRTUAL_DISK_PARAMETERS {
    Version : CREATE_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
            Version2 : this._Version2_e__Struct
            Version3 : this._Version3_e__Struct
            Version4 : this._Version4_e__Struct
        }
        struct _Version1_e__Struct {
            UniqueId : GUID
            MaximumSize : Int64
            BlockSizeInBytes : UInt32
            SectorSizeInBytes : UInt32
            ParentPath : PWSTR
            SourcePath : PWSTR
        }
        struct _Version2_e__Struct {
            UniqueId : GUID
            MaximumSize : Int64
            BlockSizeInBytes : UInt32
            SectorSizeInBytes : UInt32
            PhysicalSectorSizeInBytes : UInt32
            ParentPath : PWSTR
            SourcePath : PWSTR
            OpenFlags : OPEN_VIRTUAL_DISK_FLAG
            ParentVirtualStorageType : VIRTUAL_STORAGE_TYPE
            SourceVirtualStorageType : VIRTUAL_STORAGE_TYPE
            ResiliencyGuid : GUID
        }
        struct _Version3_e__Struct {
            UniqueId : GUID
            MaximumSize : Int64
            BlockSizeInBytes : UInt32
            SectorSizeInBytes : UInt32
            PhysicalSectorSizeInBytes : UInt32
            ParentPath : PWSTR
            SourcePath : PWSTR
            OpenFlags : OPEN_VIRTUAL_DISK_FLAG
            ParentVirtualStorageType : VIRTUAL_STORAGE_TYPE
            SourceVirtualStorageType : VIRTUAL_STORAGE_TYPE
            ResiliencyGuid : GUID
            SourceLimitPath : PWSTR
            BackingStorageType : VIRTUAL_STORAGE_TYPE
        }
        struct _Version4_e__Struct {
            UniqueId : GUID
            MaximumSize : Int64
            BlockSizeInBytes : UInt32
            SectorSizeInBytes : UInt32
            PhysicalSectorSizeInBytes : UInt32
            ParentPath : PWSTR
            SourcePath : PWSTR
            OpenFlags : OPEN_VIRTUAL_DISK_FLAG
            ParentVirtualStorageType : VIRTUAL_STORAGE_TYPE
            SourceVirtualStorageType : VIRTUAL_STORAGE_TYPE
            ResiliencyGuid : GUID
            SourceLimitPath : PWSTR
            BackingStorageType : VIRTUAL_STORAGE_TYPE
            PmemAddressAbstractionType : GUID
            DataAlignment : Int64
        }
    }
}
struct CREATE_VIRTUAL_DISK_FLAG extends Int32 {
    static CREATE_VIRTUAL_DISK_FLAG_NONE := 0
    static CREATE_VIRTUAL_DISK_FLAG_FULL_PHYSICAL_ALLOCATION := 1
    static CREATE_VIRTUAL_DISK_FLAG_PREVENT_WRITES_TO_SOURCE_DISK := 2
    static CREATE_VIRTUAL_DISK_FLAG_DO_NOT_COPY_METADATA_FROM_PARENT := 4
    static CREATE_VIRTUAL_DISK_FLAG_CREATE_BACKING_STORAGE := 8
    static CREATE_VIRTUAL_DISK_FLAG_USE_CHANGE_TRACKING_SOURCE_LIMIT := 16
    static CREATE_VIRTUAL_DISK_FLAG_PRESERVE_PARENT_CHANGE_TRACKING_STATE := 32
    static CREATE_VIRTUAL_DISK_FLAG_VHD_SET_USE_ORIGINAL_BACKING_STORAGE := 64
    static CREATE_VIRTUAL_DISK_FLAG_SPARSE_FILE := 128
    static CREATE_VIRTUAL_DISK_FLAG_PMEM_COMPATIBLE := 256
    static CREATE_VIRTUAL_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES := 512
    static CREATE_VIRTUAL_DISK_FLAG_SUPPORT_SPARSE_FILES_ANY_FS := 1024
}
struct ATTACH_VIRTUAL_DISK_VERSION extends Int32 {
    static ATTACH_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static ATTACH_VIRTUAL_DISK_VERSION_1 := 1
    static ATTACH_VIRTUAL_DISK_VERSION_2 := 2
}
struct ATTACH_VIRTUAL_DISK_PARAMETERS {
    Version : ATTACH_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
            Version2 : this._Version2_e__Struct
        }
        struct _Version1_e__Struct {
            Reserved : UInt32
        }
        struct _Version2_e__Struct {
            RestrictedOffset : Int64
            RestrictedLength : Int64
        }
    }
}
struct ATTACH_VIRTUAL_DISK_FLAG extends Int32 {
    static ATTACH_VIRTUAL_DISK_FLAG_NONE := 0
    static ATTACH_VIRTUAL_DISK_FLAG_READ_ONLY := 1
    static ATTACH_VIRTUAL_DISK_FLAG_NO_DRIVE_LETTER := 2
    static ATTACH_VIRTUAL_DISK_FLAG_PERMANENT_LIFETIME := 4
    static ATTACH_VIRTUAL_DISK_FLAG_NO_LOCAL_HOST := 8
    static ATTACH_VIRTUAL_DISK_FLAG_NO_SECURITY_DESCRIPTOR := 16
    static ATTACH_VIRTUAL_DISK_FLAG_BYPASS_DEFAULT_ENCRYPTION_POLICY := 32
    static ATTACH_VIRTUAL_DISK_FLAG_NON_PNP := 64
    static ATTACH_VIRTUAL_DISK_FLAG_RESTRICTED_RANGE := 128
    static ATTACH_VIRTUAL_DISK_FLAG_SINGLE_PARTITION := 256
    static ATTACH_VIRTUAL_DISK_FLAG_REGISTER_VOLUME := 512
    static ATTACH_VIRTUAL_DISK_FLAG_AT_BOOT := 1024
}
struct DETACH_VIRTUAL_DISK_FLAG extends Int32 {
    static DETACH_VIRTUAL_DISK_FLAG_NONE := 0
}
struct DEPENDENT_DISK_FLAG extends Int32 {
    static DEPENDENT_DISK_FLAG_NONE := 0
    static DEPENDENT_DISK_FLAG_MULT_BACKING_FILES := 1
    static DEPENDENT_DISK_FLAG_FULLY_ALLOCATED := 2
    static DEPENDENT_DISK_FLAG_READ_ONLY := 4
    static DEPENDENT_DISK_FLAG_REMOTE := 8
    static DEPENDENT_DISK_FLAG_SYSTEM_VOLUME := 16
    static DEPENDENT_DISK_FLAG_SYSTEM_VOLUME_PARENT := 32
    static DEPENDENT_DISK_FLAG_REMOVABLE := 64
    static DEPENDENT_DISK_FLAG_NO_DRIVE_LETTER := 128
    static DEPENDENT_DISK_FLAG_PARENT := 256
    static DEPENDENT_DISK_FLAG_NO_HOST_DISK := 512
    static DEPENDENT_DISK_FLAG_PERMANENT_LIFETIME := 1024
    static DEPENDENT_DISK_FLAG_SUPPORT_COMPRESSED_VOLUMES := 2048
    static DEPENDENT_DISK_FLAG_ALWAYS_ALLOW_SPARSE := 4096
    static DEPENDENT_DISK_FLAG_SUPPORT_ENCRYPTED_FILES := 8192
}
struct STORAGE_DEPENDENCY_INFO_VERSION extends Int32 {
    static STORAGE_DEPENDENCY_INFO_VERSION_UNSPECIFIED := 0
    static STORAGE_DEPENDENCY_INFO_VERSION_1 := 1
    static STORAGE_DEPENDENCY_INFO_VERSION_2 := 2
}
struct STORAGE_DEPENDENCY_INFO_TYPE_1 {
    DependencyTypeFlags : DEPENDENT_DISK_FLAG
    ProviderSpecificFlags : UInt32
    VirtualStorageType : VIRTUAL_STORAGE_TYPE
}
struct STORAGE_DEPENDENCY_INFO_TYPE_2 {
    DependencyTypeFlags : DEPENDENT_DISK_FLAG
    ProviderSpecificFlags : UInt32
    VirtualStorageType : VIRTUAL_STORAGE_TYPE
    AncestorLevel : UInt32
    DependencyDeviceName : PWSTR
    HostVolumeName : PWSTR
    DependentVolumeName : PWSTR
    DependentVolumeRelativePath : PWSTR
}
struct STORAGE_DEPENDENCY_INFO {
    Version : STORAGE_DEPENDENCY_INFO_VERSION
    NumberEntries : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1Entries : STORAGE_DEPENDENCY_INFO_TYPE_1[1]
            Version2Entries : STORAGE_DEPENDENCY_INFO_TYPE_2[1]
        }
    }
}
struct GET_STORAGE_DEPENDENCY_FLAG extends Int32 {
    static GET_STORAGE_DEPENDENCY_FLAG_NONE := 0
    static GET_STORAGE_DEPENDENCY_FLAG_HOST_VOLUMES := 1
    static GET_STORAGE_DEPENDENCY_FLAG_DISK_HANDLE := 2
}
struct GET_VIRTUAL_DISK_INFO_VERSION extends Int32 {
    static GET_VIRTUAL_DISK_INFO_UNSPECIFIED := 0
    static GET_VIRTUAL_DISK_INFO_SIZE := 1
    static GET_VIRTUAL_DISK_INFO_IDENTIFIER := 2
    static GET_VIRTUAL_DISK_INFO_PARENT_LOCATION := 3
    static GET_VIRTUAL_DISK_INFO_PARENT_IDENTIFIER := 4
    static GET_VIRTUAL_DISK_INFO_PARENT_TIMESTAMP := 5
    static GET_VIRTUAL_DISK_INFO_VIRTUAL_STORAGE_TYPE := 6
    static GET_VIRTUAL_DISK_INFO_PROVIDER_SUBTYPE := 7
    static GET_VIRTUAL_DISK_INFO_IS_4K_ALIGNED := 8
    static GET_VIRTUAL_DISK_INFO_PHYSICAL_DISK := 9
    static GET_VIRTUAL_DISK_INFO_VHD_PHYSICAL_SECTOR_SIZE := 10
    static GET_VIRTUAL_DISK_INFO_SMALLEST_SAFE_VIRTUAL_SIZE := 11
    static GET_VIRTUAL_DISK_INFO_FRAGMENTATION := 12
    static GET_VIRTUAL_DISK_INFO_IS_LOADED := 13
    static GET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID := 14
    static GET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE := 15
}
struct GET_VIRTUAL_DISK_INFO {
    Version : GET_VIRTUAL_DISK_INFO_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Size : this._Size_e__Struct
            Identifier : GUID
            ParentLocation : this._ParentLocation_e__Struct
            ParentIdentifier : GUID
            ParentTimestamp : UInt32
            VirtualStorageType : VIRTUAL_STORAGE_TYPE
            ProviderSubtype : UInt32
            Is4kAligned : BOOL
            IsLoaded : BOOL
            PhysicalDisk : this._PhysicalDisk_e__Struct
            VhdPhysicalSectorSize : UInt32
            SmallestSafeVirtualSize : Int64
            FragmentationPercentage : UInt32
            VirtualDiskId : GUID
            ChangeTrackingState : this._ChangeTrackingState_e__Struct
        }
        struct _Size_e__Struct {
            VirtualSize : Int64
            PhysicalSize : Int64
            BlockSize : UInt32
            SectorSize : UInt32
        }
        struct _ParentLocation_e__Struct {
            ParentResolved : BOOL
            ParentLocationBuffer : UInt16[1]
        }
        struct _PhysicalDisk_e__Struct {
            LogicalSectorSize : UInt32
            PhysicalSectorSize : UInt32
            IsRemote : BOOL
        }
        struct _ChangeTrackingState_e__Struct {
            Enabled : BOOL
            NewerChanges : BOOL
            MostRecentId : UInt16[1]
        }
    }
}
struct SET_VIRTUAL_DISK_INFO_VERSION extends Int32 {
    static SET_VIRTUAL_DISK_INFO_UNSPECIFIED := 0
    static SET_VIRTUAL_DISK_INFO_PARENT_PATH := 1
    static SET_VIRTUAL_DISK_INFO_IDENTIFIER := 2
    static SET_VIRTUAL_DISK_INFO_PARENT_PATH_WITH_DEPTH := 3
    static SET_VIRTUAL_DISK_INFO_PHYSICAL_SECTOR_SIZE := 4
    static SET_VIRTUAL_DISK_INFO_VIRTUAL_DISK_ID := 5
    static SET_VIRTUAL_DISK_INFO_CHANGE_TRACKING_STATE := 6
    static SET_VIRTUAL_DISK_INFO_PARENT_LOCATOR := 7
}
struct SET_VIRTUAL_DISK_INFO {
    Version : SET_VIRTUAL_DISK_INFO_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ParentFilePath : PWSTR
            UniqueIdentifier : GUID
            ParentPathWithDepthInfo : this._ParentPathWithDepthInfo_e__Struct
            VhdPhysicalSectorSize : UInt32
            VirtualDiskId : GUID
            ChangeTrackingEnabled : BOOL
            ParentLocator : this._ParentLocator_e__Struct
        }
        struct _ParentPathWithDepthInfo_e__Struct {
            ChildDepth : UInt32
            ParentFilePath : PWSTR
        }
        struct _ParentLocator_e__Struct {
            LinkageId : GUID
            ParentFilePath : PWSTR
        }
    }
}
struct VIRTUAL_DISK_PROGRESS {
    OperationStatus : UInt32
    CurrentValue : Int64
    CompletionValue : Int64
}
struct COMPACT_VIRTUAL_DISK_VERSION extends Int32 {
    static COMPACT_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static COMPACT_VIRTUAL_DISK_VERSION_1 := 1
}
struct COMPACT_VIRTUAL_DISK_PARAMETERS {
    Version : COMPACT_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            Reserved : UInt32
        }
    }
}
struct COMPACT_VIRTUAL_DISK_FLAG extends Int32 {
    static COMPACT_VIRTUAL_DISK_FLAG_NONE := 0
    static COMPACT_VIRTUAL_DISK_FLAG_NO_ZERO_SCAN := 1
    static COMPACT_VIRTUAL_DISK_FLAG_NO_BLOCK_MOVES := 2
}
struct MERGE_VIRTUAL_DISK_VERSION extends Int32 {
    static MERGE_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static MERGE_VIRTUAL_DISK_VERSION_1 := 1
    static MERGE_VIRTUAL_DISK_VERSION_2 := 2
}
struct MERGE_VIRTUAL_DISK_PARAMETERS {
    Version : MERGE_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
            Version2 : this._Version2_e__Struct
        }
        struct _Version1_e__Struct {
            MergeDepth : UInt32
        }
        struct _Version2_e__Struct {
            MergeSourceDepth : UInt32
            MergeTargetDepth : UInt32
        }
    }
}
struct MERGE_VIRTUAL_DISK_FLAG extends Int32 {
    static MERGE_VIRTUAL_DISK_FLAG_NONE := 0
}
struct EXPAND_VIRTUAL_DISK_VERSION extends Int32 {
    static EXPAND_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static EXPAND_VIRTUAL_DISK_VERSION_1 := 1
}
struct EXPAND_VIRTUAL_DISK_PARAMETERS {
    Version : EXPAND_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            NewSize : Int64
        }
    }
}
struct EXPAND_VIRTUAL_DISK_FLAG extends Int32 {
    static EXPAND_VIRTUAL_DISK_FLAG_NONE := 0
    static EXPAND_VIRTUAL_DISK_FLAG_NOTIFY_CHANGE := 1
}
struct RESIZE_VIRTUAL_DISK_VERSION extends Int32 {
    static RESIZE_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static RESIZE_VIRTUAL_DISK_VERSION_1 := 1
}
struct RESIZE_VIRTUAL_DISK_PARAMETERS {
    Version : RESIZE_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            NewSize : Int64
        }
    }
}
struct RESIZE_VIRTUAL_DISK_FLAG extends Int32 {
    static RESIZE_VIRTUAL_DISK_FLAG_NONE := 0
    static RESIZE_VIRTUAL_DISK_FLAG_ALLOW_UNSAFE_VIRTUAL_SIZE := 1
    static RESIZE_VIRTUAL_DISK_FLAG_RESIZE_TO_SMALLEST_SAFE_VIRTUAL_SIZE := 2
}
struct MIRROR_VIRTUAL_DISK_VERSION extends Int32 {
    static MIRROR_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static MIRROR_VIRTUAL_DISK_VERSION_1 := 1
}
struct MIRROR_VIRTUAL_DISK_PARAMETERS {
    Version : MIRROR_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            MirrorVirtualDiskPath : PWSTR
        }
    }
}
struct MIRROR_VIRTUAL_DISK_FLAG extends Int32 {
    static MIRROR_VIRTUAL_DISK_FLAG_NONE := 0
    static MIRROR_VIRTUAL_DISK_FLAG_EXISTING_FILE := 1
    static MIRROR_VIRTUAL_DISK_FLAG_SKIP_MIRROR_ACTIVATION := 2
    static MIRROR_VIRTUAL_DISK_FLAG_ENABLE_SMB_COMPRESSION := 4
    static MIRROR_VIRTUAL_DISK_FLAG_IS_LIVE_MIGRATION := 8
}
struct QUERY_CHANGES_VIRTUAL_DISK_RANGE {
    ByteOffset : Int64
    ByteLength : Int64
    Reserved : Int64
}
struct QUERY_CHANGES_VIRTUAL_DISK_FLAG extends Int32 {
    static QUERY_CHANGES_VIRTUAL_DISK_FLAG_NONE := 0
}
struct TAKE_SNAPSHOT_VHDSET_FLAG extends Int32 {
    static TAKE_SNAPSHOT_VHDSET_FLAG_NONE := 0
    static TAKE_SNAPSHOT_VHDSET_FLAG_WRITEABLE := 1
}
struct TAKE_SNAPSHOT_VHDSET_VERSION extends Int32 {
    static TAKE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED := 0
    static TAKE_SNAPSHOT_VHDSET_VERSION_1 := 1
}
struct TAKE_SNAPSHOT_VHDSET_PARAMETERS {
    Version : TAKE_SNAPSHOT_VHDSET_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            SnapshotId : GUID
        }
    }
}
struct DELETE_SNAPSHOT_VHDSET_FLAG extends Int32 {
    static DELETE_SNAPSHOT_VHDSET_FLAG_NONE := 0
    static DELETE_SNAPSHOT_VHDSET_FLAG_PERSIST_RCT := 1
}
struct DELETE_SNAPSHOT_VHDSET_VERSION extends Int32 {
    static DELETE_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED := 0
    static DELETE_SNAPSHOT_VHDSET_VERSION_1 := 1
}
struct DELETE_SNAPSHOT_VHDSET_PARAMETERS {
    Version : DELETE_SNAPSHOT_VHDSET_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            SnapshotId : GUID
        }
    }
}
struct MODIFY_VHDSET_VERSION extends Int32 {
    static MODIFY_VHDSET_UNSPECIFIED := 0
    static MODIFY_VHDSET_SNAPSHOT_PATH := 1
    static MODIFY_VHDSET_REMOVE_SNAPSHOT := 2
    static MODIFY_VHDSET_DEFAULT_SNAPSHOT_PATH := 3
}
struct MODIFY_VHDSET_FLAG extends Int32 {
    static MODIFY_VHDSET_FLAG_NONE := 0
    static MODIFY_VHDSET_FLAG_WRITEABLE_SNAPSHOT := 1
}
struct MODIFY_VHDSET_PARAMETERS {
    Version : MODIFY_VHDSET_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            SnapshotPath : this._SnapshotPath_e__Struct
            SnapshotId : GUID
            DefaultFilePath : PWSTR
        }
        struct _SnapshotPath_e__Struct {
            SnapshotId : GUID
            SnapshotFilePath : PWSTR
        }
    }
}
struct APPLY_SNAPSHOT_VHDSET_FLAG extends Int32 {
    static APPLY_SNAPSHOT_VHDSET_FLAG_NONE := 0
    static APPLY_SNAPSHOT_VHDSET_FLAG_WRITEABLE := 1
}
struct APPLY_SNAPSHOT_VHDSET_VERSION extends Int32 {
    static APPLY_SNAPSHOT_VHDSET_VERSION_UNSPECIFIED := 0
    static APPLY_SNAPSHOT_VHDSET_VERSION_1 := 1
}
struct APPLY_SNAPSHOT_VHDSET_PARAMETERS {
    Version : APPLY_SNAPSHOT_VHDSET_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            SnapshotId : GUID
            LeafSnapshotId : GUID
        }
    }
}
struct RAW_SCSI_VIRTUAL_DISK_FLAG extends Int32 {
    static RAW_SCSI_VIRTUAL_DISK_FLAG_NONE := 0
}
struct RAW_SCSI_VIRTUAL_DISK_VERSION extends Int32 {
    static RAW_SCSI_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static RAW_SCSI_VIRTUAL_DISK_VERSION_1 := 1
}
struct RAW_SCSI_VIRTUAL_DISK_PARAMETERS {
    Version : RAW_SCSI_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            RSVDHandle : BOOL
            DataIn : UInt8
            CdbLength : UInt8
            SenseInfoLength : UInt8
            SrbFlags : UInt32
            DataTransferLength : UInt32
            DataBuffer : Struct.Ptr
            SenseInfo : UInt8.Ptr
            Cdb : UInt8.Ptr
        }
    }
}
struct RAW_SCSI_VIRTUAL_DISK_RESPONSE {
    Version : RAW_SCSI_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            ScsiStatus : UInt8
            SenseInfoLength : UInt8
            DataTransferLength : UInt32
        }
    }
}
struct FORK_VIRTUAL_DISK_VERSION extends Int32 {
    static FORK_VIRTUAL_DISK_VERSION_UNSPECIFIED := 0
    static FORK_VIRTUAL_DISK_VERSION_1 := 1
}
struct FORK_VIRTUAL_DISK_PARAMETERS {
    Version : FORK_VIRTUAL_DISK_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version1 : this._Version1_e__Struct
        }
        struct _Version1_e__Struct {
            ForkedVirtualDiskPath : PWSTR
        }
    }
}
struct FORK_VIRTUAL_DISK_FLAG extends Int32 {
    static FORK_VIRTUAL_DISK_FLAG_NONE := 0
    static FORK_VIRTUAL_DISK_FLAG_EXISTING_FILE := 1
}
