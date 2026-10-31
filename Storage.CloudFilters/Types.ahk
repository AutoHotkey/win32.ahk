#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, NTSTATUS, PWSTR}
#Import "..\Storage.FileSystem\Types.ahk" {FILE_BASIC_INFO}
#Import "..\System.CorrelationVector\Types.ahk" {CORRELATION_VECTOR}

struct CF_CONNECTION_KEY {
    Value : Int64
}
struct CF_FS_METADATA {
    BasicInfo : FILE_BASIC_INFO
    FileSize : Int64
}
struct CF_PLACEHOLDER_CREATE_FLAGS extends Int32 {
    static CF_PLACEHOLDER_CREATE_FLAG_NONE := 0
    static CF_PLACEHOLDER_CREATE_FLAG_DISABLE_ON_DEMAND_POPULATION := 1
    static CF_PLACEHOLDER_CREATE_FLAG_MARK_IN_SYNC := 2
    static CF_PLACEHOLDER_CREATE_FLAG_SUPERSEDE := 4
    static CF_PLACEHOLDER_CREATE_FLAG_ALWAYS_FULL := 8
}
struct CF_PLACEHOLDER_CREATE_INFO {
    RelativeFileName : PWSTR
    FsMetadata : CF_FS_METADATA
    FileIdentity : Struct.Ptr
    FileIdentityLength : UInt32
    Flags : CF_PLACEHOLDER_CREATE_FLAGS
    Result : HRESULT
    CreateUsn : Int64
}
struct CF_SYNC_PROVIDER_STATUS extends UInt32 {
    static CF_PROVIDER_STATUS_DISCONNECTED := 0
    static CF_PROVIDER_STATUS_IDLE := 1
    static CF_PROVIDER_STATUS_POPULATE_NAMESPACE := 2
    static CF_PROVIDER_STATUS_POPULATE_METADATA := 4
    static CF_PROVIDER_STATUS_POPULATE_CONTENT := 8
    static CF_PROVIDER_STATUS_SYNC_INCREMENTAL := 16
    static CF_PROVIDER_STATUS_SYNC_FULL := 32
    static CF_PROVIDER_STATUS_CONNECTIVITY_LOST := 64
    static CF_PROVIDER_STATUS_CLEAR_FLAGS := 2147483648
    static CF_PROVIDER_STATUS_TERMINATED := 3221225473
    static CF_PROVIDER_STATUS_ERROR := 3221225474
}
struct CF_PROCESS_INFO {
    StructSize : UInt32
    ProcessId : UInt32
    ImagePath : PWSTR
    PackageName : PWSTR
    ApplicationId : PWSTR
    CommandLine : PWSTR
    SessionId : UInt32
}
struct CF_PLATFORM_INFO {
    BuildNumber : UInt32
    RevisionNumber : UInt32
    IntegrationNumber : UInt32
}
struct CF_REGISTER_FLAGS extends Int32 {
    static CF_REGISTER_FLAG_NONE := 0
    static CF_REGISTER_FLAG_UPDATE := 1
    static CF_REGISTER_FLAG_DISABLE_ON_DEMAND_POPULATION_ON_ROOT := 2
    static CF_REGISTER_FLAG_MARK_IN_SYNC_ON_ROOT := 4
}
struct CF_HYDRATION_POLICY_PRIMARY extends UInt16 {
    static CF_HYDRATION_POLICY_PARTIAL := 0
    static CF_HYDRATION_POLICY_PROGRESSIVE := 1
    static CF_HYDRATION_POLICY_FULL := 2
    static CF_HYDRATION_POLICY_ALWAYS_FULL := 3
}
struct CF_HYDRATION_POLICY_MODIFIER extends UInt16 {
    static CF_HYDRATION_POLICY_MODIFIER_NONE := 0
    static CF_HYDRATION_POLICY_MODIFIER_VALIDATION_REQUIRED := 1
    static CF_HYDRATION_POLICY_MODIFIER_STREAMING_ALLOWED := 2
    static CF_HYDRATION_POLICY_MODIFIER_AUTO_DEHYDRATION_ALLOWED := 4
    static CF_HYDRATION_POLICY_MODIFIER_ALLOW_FULL_RESTART_HYDRATION := 8
}
struct CF_HYDRATION_POLICY {
    Primary : CF_HYDRATION_POLICY_PRIMARY
    Modifier : CF_HYDRATION_POLICY_MODIFIER
}
struct CF_POPULATION_POLICY_PRIMARY extends UInt16 {
    static CF_POPULATION_POLICY_PARTIAL := 0
    static CF_POPULATION_POLICY_FULL := 2
    static CF_POPULATION_POLICY_ALWAYS_FULL := 3
}
struct CF_POPULATION_POLICY_MODIFIER extends UInt16 {
    static CF_POPULATION_POLICY_MODIFIER_NONE := 0
}
struct CF_POPULATION_POLICY {
    Primary : CF_POPULATION_POLICY_PRIMARY
    Modifier : CF_POPULATION_POLICY_MODIFIER
}
struct CF_PLACEHOLDER_MANAGEMENT_POLICY extends Int32 {
    static CF_PLACEHOLDER_MANAGEMENT_POLICY_DEFAULT := 0
    static CF_PLACEHOLDER_MANAGEMENT_POLICY_CREATE_UNRESTRICTED := 1
    static CF_PLACEHOLDER_MANAGEMENT_POLICY_CONVERT_TO_UNRESTRICTED := 2
    static CF_PLACEHOLDER_MANAGEMENT_POLICY_UPDATE_UNRESTRICTED := 4
}
struct CF_INSYNC_POLICY extends UInt32 {
    static CF_INSYNC_POLICY_NONE := 0
    static CF_INSYNC_POLICY_TRACK_FILE_CREATION_TIME := 1
    static CF_INSYNC_POLICY_TRACK_FILE_READONLY_ATTRIBUTE := 2
    static CF_INSYNC_POLICY_TRACK_FILE_HIDDEN_ATTRIBUTE := 4
    static CF_INSYNC_POLICY_TRACK_FILE_SYSTEM_ATTRIBUTE := 8
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_CREATION_TIME := 16
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_READONLY_ATTRIBUTE := 32
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_HIDDEN_ATTRIBUTE := 64
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_SYSTEM_ATTRIBUTE := 128
    static CF_INSYNC_POLICY_TRACK_FILE_LAST_WRITE_TIME := 256
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_LAST_WRITE_TIME := 512
    static CF_INSYNC_POLICY_TRACK_FILE_ALL := 5592335
    static CF_INSYNC_POLICY_TRACK_DIRECTORY_ALL := 11184880
    static CF_INSYNC_POLICY_TRACK_ALL := 16777215
    static CF_INSYNC_POLICY_PRESERVE_INSYNC_FOR_SYNC_ENGINE := 2147483648
}
struct CF_HARDLINK_POLICY extends Int32 {
    static CF_HARDLINK_POLICY_NONE := 0
    static CF_HARDLINK_POLICY_ALLOWED := 1
}
struct CF_SYNC_POLICIES {
    StructSize : UInt32
    Hydration : CF_HYDRATION_POLICY
    Population : CF_POPULATION_POLICY
    InSync : CF_INSYNC_POLICY
    HardLink : CF_HARDLINK_POLICY
    PlaceholderManagement : CF_PLACEHOLDER_MANAGEMENT_POLICY
}
struct CF_SYNC_REGISTRATION {
    StructSize : UInt32
    ProviderName : PWSTR
    ProviderVersion : PWSTR
    SyncRootIdentity : Struct.Ptr
    SyncRootIdentityLength : UInt32
    FileIdentity : Struct.Ptr
    FileIdentityLength : UInt32
    ProviderId : GUID
}
struct CF_CALLBACK_INFO {
    StructSize : UInt32
    ConnectionKey : CF_CONNECTION_KEY
    CallbackContext : Struct.Ptr
    VolumeGuidName : PWSTR
    VolumeDosName : PWSTR
    VolumeSerialNumber : UInt32
    SyncRootFileId : Int64
    SyncRootIdentity : Struct.Ptr
    SyncRootIdentityLength : UInt32
    FileId : Int64
    FileSize : Int64
    FileIdentity : Struct.Ptr
    FileIdentityLength : UInt32
    NormalizedPath : PWSTR
    TransferKey : Int64
    PriorityHint : UInt8
    CorrelationVector : CORRELATION_VECTOR.Ptr
    ProcessInfo : CF_PROCESS_INFO.Ptr
    RequestKey : Int64
}
struct CF_CALLBACK_CANCEL_FLAGS extends Int32 {
    static CF_CALLBACK_CANCEL_FLAG_NONE := 0
    static CF_CALLBACK_CANCEL_FLAG_IO_TIMEOUT := 1
    static CF_CALLBACK_CANCEL_FLAG_IO_ABORTED := 2
}
struct CF_CALLBACK_FETCH_DATA_FLAGS extends Int32 {
    static CF_CALLBACK_FETCH_DATA_FLAG_NONE := 0
    static CF_CALLBACK_FETCH_DATA_FLAG_RECOVERY := 1
    static CF_CALLBACK_FETCH_DATA_FLAG_EXPLICIT_HYDRATION := 2
}
struct CF_CALLBACK_VALIDATE_DATA_FLAGS extends Int32 {
    static CF_CALLBACK_VALIDATE_DATA_FLAG_NONE := 0
    static CF_CALLBACK_VALIDATE_DATA_FLAG_EXPLICIT_HYDRATION := 2
}
struct CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS extends Int32 {
    static CF_CALLBACK_FETCH_PLACEHOLDERS_FLAG_NONE := 0
}
struct CF_CALLBACK_OPEN_COMPLETION_FLAGS extends Int32 {
    static CF_CALLBACK_OPEN_COMPLETION_FLAG_NONE := 0
    static CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNKNOWN := 1
    static CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNSUPPORTED := 2
}
struct CF_CALLBACK_CLOSE_COMPLETION_FLAGS extends Int32 {
    static CF_CALLBACK_CLOSE_COMPLETION_FLAG_NONE := 0
    static CF_CALLBACK_CLOSE_COMPLETION_FLAG_DELETED := 1
}
struct CF_CALLBACK_DEHYDRATE_FLAGS extends Int32 {
    static CF_CALLBACK_DEHYDRATE_FLAG_NONE := 0
    static CF_CALLBACK_DEHYDRATE_FLAG_BACKGROUND := 1
}
struct CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS extends Int32 {
    static CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_NONE := 0
    static CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_BACKGROUND := 1
    static CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_DEHYDRATED := 2
}
struct CF_CALLBACK_DELETE_FLAGS extends Int32 {
    static CF_CALLBACK_DELETE_FLAG_NONE := 0
    static CF_CALLBACK_DELETE_FLAG_IS_DIRECTORY := 1
    static CF_CALLBACK_DELETE_FLAG_IS_UNDELETE := 2
}
struct CF_CALLBACK_DELETE_COMPLETION_FLAGS extends Int32 {
    static CF_CALLBACK_DELETE_COMPLETION_FLAG_NONE := 0
}
struct CF_CALLBACK_RENAME_FLAGS extends Int32 {
    static CF_CALLBACK_RENAME_FLAG_NONE := 0
    static CF_CALLBACK_RENAME_FLAG_IS_DIRECTORY := 1
    static CF_CALLBACK_RENAME_FLAG_SOURCE_IN_SCOPE := 2
    static CF_CALLBACK_RENAME_FLAG_TARGET_IN_SCOPE := 4
}
struct CF_CALLBACK_RENAME_COMPLETION_FLAGS extends Int32 {
    static CF_CALLBACK_RENAME_COMPLETION_FLAG_NONE := 0
}
struct CF_CALLBACK_DEHYDRATION_REASON extends Int32 {
    static CF_CALLBACK_DEHYDRATION_REASON_NONE := 0
    static CF_CALLBACK_DEHYDRATION_REASON_USER_MANUAL := 1
    static CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_LOW_SPACE := 2
    static CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_INACTIVITY := 3
    static CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_OS_UPGRADE := 4
}
struct CF_CALLBACK_PARAMETERS {
    ParamSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Cancel : this._Cancel_e__Struct
            FetchData : this._FetchData_e__Struct
            ValidateData : this._ValidateData_e__Struct
            FetchPlaceholders : this._FetchPlaceholders_e__Struct
            OpenCompletion : this._OpenCompletion_e__Struct
            CloseCompletion : this._CloseCompletion_e__Struct
            Dehydrate : this._Dehydrate_e__Struct
            DehydrateCompletion : this._DehydrateCompletion_e__Struct
            Delete : this._Delete_e__Struct
            DeleteCompletion : this._DeleteCompletion_e__Struct
            Rename : this._Rename_e__Struct
            RenameCompletion : this._RenameCompletion_e__Struct
        }
        struct _Cancel_e__Struct {
            Flags : CF_CALLBACK_CANCEL_FLAGS
            Anonymous : this._Anonymous_e__Union
            struct _Anonymous_e__Union {
                union {
                    FetchData : this._FetchData_e__Struct
                }
                struct _FetchData_e__Struct {
                    FileOffset : Int64
                    Length : Int64
                }
            }
        }
        struct _FetchData_e__Struct {
            Flags : CF_CALLBACK_FETCH_DATA_FLAGS
            RequiredFileOffset : Int64
            RequiredLength : Int64
            OptionalFileOffset : Int64
            OptionalLength : Int64
            LastDehydrationTime : Int64
            LastDehydrationReason : CF_CALLBACK_DEHYDRATION_REASON
        }
        struct _ValidateData_e__Struct {
            Flags : CF_CALLBACK_VALIDATE_DATA_FLAGS
            RequiredFileOffset : Int64
            RequiredLength : Int64
        }
        struct _FetchPlaceholders_e__Struct {
            Flags : CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS
            Pattern : PWSTR
        }
        struct _OpenCompletion_e__Struct {
            Flags : CF_CALLBACK_OPEN_COMPLETION_FLAGS
        }
        struct _CloseCompletion_e__Struct {
            Flags : CF_CALLBACK_CLOSE_COMPLETION_FLAGS
        }
        struct _Dehydrate_e__Struct {
            Flags : CF_CALLBACK_DEHYDRATE_FLAGS
            Reason : CF_CALLBACK_DEHYDRATION_REASON
        }
        struct _DehydrateCompletion_e__Struct {
            Flags : CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS
            Reason : CF_CALLBACK_DEHYDRATION_REASON
        }
        struct _Delete_e__Struct {
            Flags : CF_CALLBACK_DELETE_FLAGS
        }
        struct _DeleteCompletion_e__Struct {
            Flags : CF_CALLBACK_DELETE_COMPLETION_FLAGS
        }
        struct _Rename_e__Struct {
            Flags : CF_CALLBACK_RENAME_FLAGS
            TargetPath : PWSTR
        }
        struct _RenameCompletion_e__Struct {
            Flags : CF_CALLBACK_RENAME_COMPLETION_FLAGS
            SourcePath : PWSTR
        }
    }
}
struct CF_CALLBACK extends FunctionPointer {
    static Types := [CF_CALLBACK_INFO.Ptr, CF_CALLBACK_PARAMETERS.Ptr, "Void"]
}
struct CF_CALLBACK_TYPE extends Int32 {
    static CF_CALLBACK_TYPE_FETCH_DATA := 0
    static CF_CALLBACK_TYPE_VALIDATE_DATA := 1
    static CF_CALLBACK_TYPE_CANCEL_FETCH_DATA := 2
    static CF_CALLBACK_TYPE_FETCH_PLACEHOLDERS := 3
    static CF_CALLBACK_TYPE_CANCEL_FETCH_PLACEHOLDERS := 4
    static CF_CALLBACK_TYPE_NOTIFY_FILE_OPEN_COMPLETION := 5
    static CF_CALLBACK_TYPE_NOTIFY_FILE_CLOSE_COMPLETION := 6
    static CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE := 7
    static CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE_COMPLETION := 8
    static CF_CALLBACK_TYPE_NOTIFY_DELETE := 9
    static CF_CALLBACK_TYPE_NOTIFY_DELETE_COMPLETION := 10
    static CF_CALLBACK_TYPE_NOTIFY_RENAME := 11
    static CF_CALLBACK_TYPE_NOTIFY_RENAME_COMPLETION := 12
    static CF_CALLBACK_TYPE_NONE := -1
}
struct CF_CALLBACK_REGISTRATION {
    Type : CF_CALLBACK_TYPE
    Callback : CF_CALLBACK
}
struct CF_CONNECT_FLAGS extends Int32 {
    static CF_CONNECT_FLAG_NONE := 0
    static CF_CONNECT_FLAG_REQUIRE_PROCESS_INFO := 2
    static CF_CONNECT_FLAG_REQUIRE_FULL_FILE_PATH := 4
    static CF_CONNECT_FLAG_BLOCK_SELF_IMPLICIT_HYDRATION := 8
}
struct CF_OPERATION_TYPE extends Int32 {
    static CF_OPERATION_TYPE_TRANSFER_DATA := 0
    static CF_OPERATION_TYPE_RETRIEVE_DATA := 1
    static CF_OPERATION_TYPE_ACK_DATA := 2
    static CF_OPERATION_TYPE_RESTART_HYDRATION := 3
    static CF_OPERATION_TYPE_TRANSFER_PLACEHOLDERS := 4
    static CF_OPERATION_TYPE_ACK_DEHYDRATE := 5
    static CF_OPERATION_TYPE_ACK_DELETE := 6
    static CF_OPERATION_TYPE_ACK_RENAME := 7
}
struct CF_SYNC_STATUS {
    StructSize : UInt32
    Code : UInt32
    DescriptionOffset : UInt32
    DescriptionLength : UInt32
    DeviceIdOffset : UInt32
    DeviceIdLength : UInt32
}
struct CF_OPERATION_INFO {
    StructSize : UInt32
    Type : CF_OPERATION_TYPE
    ConnectionKey : CF_CONNECTION_KEY
    TransferKey : Int64
    CorrelationVector : CORRELATION_VECTOR.Ptr
    SyncStatus : CF_SYNC_STATUS.Ptr
    RequestKey : Int64
}
struct CF_OPERATION_TRANSFER_DATA_FLAGS extends Int32 {
    static CF_OPERATION_TRANSFER_DATA_FLAG_NONE := 0
}
struct CF_OPERATION_RETRIEVE_DATA_FLAGS extends Int32 {
    static CF_OPERATION_RETRIEVE_DATA_FLAG_NONE := 0
}
struct CF_OPERATION_ACK_DATA_FLAGS extends Int32 {
    static CF_OPERATION_ACK_DATA_FLAG_NONE := 0
}
struct CF_OPERATION_RESTART_HYDRATION_FLAGS extends Int32 {
    static CF_OPERATION_RESTART_HYDRATION_FLAG_NONE := 0
    static CF_OPERATION_RESTART_HYDRATION_FLAG_MARK_IN_SYNC := 1
}
struct CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS extends Int32 {
    static CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_NONE := 0
    static CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_STOP_ON_ERROR := 1
    static CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_DISABLE_ON_DEMAND_POPULATION := 2
}
struct CF_OPERATION_ACK_DEHYDRATE_FLAGS extends Int32 {
    static CF_OPERATION_ACK_DEHYDRATE_FLAG_NONE := 0
}
struct CF_OPERATION_ACK_RENAME_FLAGS extends Int32 {
    static CF_OPERATION_ACK_RENAME_FLAG_NONE := 0
}
struct CF_OPERATION_ACK_DELETE_FLAGS extends Int32 {
    static CF_OPERATION_ACK_DELETE_FLAG_NONE := 0
}
struct CF_OPERATION_PARAMETERS {
    ParamSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            TransferData : this._TransferData_e__Struct
            RetrieveData : this._RetrieveData_e__Struct
            AckData : this._AckData_e__Struct
            RestartHydration : this._RestartHydration_e__Struct
            TransferPlaceholders : this._TransferPlaceholders_e__Struct
            AckDehydrate : this._AckDehydrate_e__Struct
            AckRename : this._AckRename_e__Struct
            AckDelete : this._AckDelete_e__Struct
        }
        struct _TransferData_e__Struct {
            Flags : CF_OPERATION_TRANSFER_DATA_FLAGS
            CompletionStatus : NTSTATUS
            Buffer : Struct.Ptr
            Offset : Int64
            Length : Int64
        }
        struct _RetrieveData_e__Struct {
            Flags : CF_OPERATION_RETRIEVE_DATA_FLAGS
            Buffer : Struct.Ptr
            Offset : Int64
            Length : Int64
            ReturnedLength : Int64
        }
        struct _AckData_e__Struct {
            Flags : CF_OPERATION_ACK_DATA_FLAGS
            CompletionStatus : NTSTATUS
            Offset : Int64
            Length : Int64
        }
        struct _RestartHydration_e__Struct {
            Flags : CF_OPERATION_RESTART_HYDRATION_FLAGS
            FsMetadata : CF_FS_METADATA.Ptr
            FileIdentity : Struct.Ptr
            FileIdentityLength : UInt32
        }
        struct _TransferPlaceholders_e__Struct {
            Flags : CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS
            CompletionStatus : NTSTATUS
            PlaceholderTotalCount : Int64
            PlaceholderArray : CF_PLACEHOLDER_CREATE_INFO.Ptr
            PlaceholderCount : UInt32
            EntriesProcessed : UInt32
        }
        struct _AckDehydrate_e__Struct {
            Flags : CF_OPERATION_ACK_DEHYDRATE_FLAGS
            CompletionStatus : NTSTATUS
            FileIdentity : Struct.Ptr
            FileIdentityLength : UInt32
        }
        struct _AckRename_e__Struct {
            Flags : CF_OPERATION_ACK_RENAME_FLAGS
            CompletionStatus : NTSTATUS
        }
        struct _AckDelete_e__Struct {
            Flags : CF_OPERATION_ACK_DELETE_FLAGS
            CompletionStatus : NTSTATUS
        }
    }
}
struct CF_CREATE_FLAGS extends Int32 {
    static CF_CREATE_FLAG_NONE := 0
    static CF_CREATE_FLAG_STOP_ON_ERROR := 1
}
struct CF_OPEN_FILE_FLAGS extends Int32 {
    static CF_OPEN_FILE_FLAG_NONE := 0
    static CF_OPEN_FILE_FLAG_EXCLUSIVE := 1
    static CF_OPEN_FILE_FLAG_WRITE_ACCESS := 2
    static CF_OPEN_FILE_FLAG_DELETE_ACCESS := 4
    static CF_OPEN_FILE_FLAG_FOREGROUND := 8
}
struct CF_FILE_RANGE {
    StartingOffset : Int64
    Length : Int64
}
struct CF_CONVERT_FLAGS extends Int32 {
    static CF_CONVERT_FLAG_NONE := 0
    static CF_CONVERT_FLAG_MARK_IN_SYNC := 1
    static CF_CONVERT_FLAG_DEHYDRATE := 2
    static CF_CONVERT_FLAG_ENABLE_ON_DEMAND_POPULATION := 4
    static CF_CONVERT_FLAG_ALWAYS_FULL := 8
    static CF_CONVERT_FLAG_FORCE_CONVERT_TO_CLOUD_FILE := 16
}
struct CF_UPDATE_FLAGS extends Int32 {
    static CF_UPDATE_FLAG_NONE := 0
    static CF_UPDATE_FLAG_VERIFY_IN_SYNC := 1
    static CF_UPDATE_FLAG_MARK_IN_SYNC := 2
    static CF_UPDATE_FLAG_DEHYDRATE := 4
    static CF_UPDATE_FLAG_ENABLE_ON_DEMAND_POPULATION := 8
    static CF_UPDATE_FLAG_DISABLE_ON_DEMAND_POPULATION := 16
    static CF_UPDATE_FLAG_REMOVE_FILE_IDENTITY := 32
    static CF_UPDATE_FLAG_CLEAR_IN_SYNC := 64
    static CF_UPDATE_FLAG_REMOVE_PROPERTY := 128
    static CF_UPDATE_FLAG_PASSTHROUGH_FS_METADATA := 256
    static CF_UPDATE_FLAG_ALWAYS_FULL := 512
    static CF_UPDATE_FLAG_ALLOW_PARTIAL := 1024
}
struct CF_REVERT_FLAGS extends Int32 {
    static CF_REVERT_FLAG_NONE := 0
}
struct CF_HYDRATE_FLAGS extends Int32 {
    static CF_HYDRATE_FLAG_NONE := 0
}
struct CF_DEHYDRATE_FLAGS extends Int32 {
    static CF_DEHYDRATE_FLAG_NONE := 0
    static CF_DEHYDRATE_FLAG_BACKGROUND := 1
}
struct CF_PIN_STATE extends Int32 {
    static CF_PIN_STATE_UNSPECIFIED := 0
    static CF_PIN_STATE_PINNED := 1
    static CF_PIN_STATE_UNPINNED := 2
    static CF_PIN_STATE_EXCLUDED := 3
    static CF_PIN_STATE_INHERIT := 4
}
struct CF_SET_PIN_FLAGS extends Int32 {
    static CF_SET_PIN_FLAG_NONE := 0
    static CF_SET_PIN_FLAG_RECURSE := 1
    static CF_SET_PIN_FLAG_RECURSE_ONLY := 2
    static CF_SET_PIN_FLAG_RECURSE_STOP_ON_ERROR := 4
}
struct CF_IN_SYNC_STATE extends Int32 {
    static CF_IN_SYNC_STATE_NOT_IN_SYNC := 0
    static CF_IN_SYNC_STATE_IN_SYNC := 1
}
struct CF_SET_IN_SYNC_FLAGS extends Int32 {
    static CF_SET_IN_SYNC_FLAG_NONE := 0
}
struct CF_PLACEHOLDER_STATE extends UInt32 {
    static CF_PLACEHOLDER_STATE_NO_STATES := 0
    static CF_PLACEHOLDER_STATE_PLACEHOLDER := 1
    static CF_PLACEHOLDER_STATE_SYNC_ROOT := 2
    static CF_PLACEHOLDER_STATE_ESSENTIAL_PROP_PRESENT := 4
    static CF_PLACEHOLDER_STATE_IN_SYNC := 8
    static CF_PLACEHOLDER_STATE_PARTIAL := 16
    static CF_PLACEHOLDER_STATE_PARTIALLY_ON_DISK := 32
    static CF_PLACEHOLDER_STATE_INVALID := 4294967295
}
struct CF_PLACEHOLDER_INFO_CLASS extends Int32 {
    static CF_PLACEHOLDER_INFO_BASIC := 0
    static CF_PLACEHOLDER_INFO_STANDARD := 1
}
struct CF_PLACEHOLDER_BASIC_INFO {
    PinState : CF_PIN_STATE
    InSyncState : CF_IN_SYNC_STATE
    FileId : Int64
    SyncRootFileId : Int64
    FileIdentityLength : UInt32
    FileIdentity : UInt8[1]
}
struct CF_PLACEHOLDER_STANDARD_INFO {
    OnDiskDataSize : Int64
    ValidatedDataSize : Int64
    ModifiedDataSize : Int64
    PropertiesSize : Int64
    PinState : CF_PIN_STATE
    InSyncState : CF_IN_SYNC_STATE
    FileId : Int64
    SyncRootFileId : Int64
    FileIdentityLength : UInt32
    FileIdentity : UInt8[1]
}
struct CF_SYNC_ROOT_INFO_CLASS extends Int32 {
    static CF_SYNC_ROOT_INFO_BASIC := 0
    static CF_SYNC_ROOT_INFO_STANDARD := 1
    static CF_SYNC_ROOT_INFO_PROVIDER := 2
}
struct CF_SYNC_ROOT_BASIC_INFO {
    SyncRootFileId : Int64
}
struct CF_SYNC_ROOT_PROVIDER_INFO {
    ProviderStatus : CF_SYNC_PROVIDER_STATUS
    ProviderName : UInt16[256]
    ProviderVersion : UInt16[256]
}
struct CF_SYNC_ROOT_STANDARD_INFO {
    SyncRootFileId : Int64
    HydrationPolicy : CF_HYDRATION_POLICY
    PopulationPolicy : CF_POPULATION_POLICY
    InSyncPolicy : CF_INSYNC_POLICY
    HardLinkPolicy : CF_HARDLINK_POLICY
    ProviderStatus : CF_SYNC_PROVIDER_STATUS
    ProviderName : UInt16[256]
    ProviderVersion : UInt16[256]
    SyncRootIdentityLength : UInt32
    SyncRootIdentity : UInt8[1]
}
struct CF_PLACEHOLDER_RANGE_INFO_CLASS extends Int32 {
    static CF_PLACEHOLDER_RANGE_INFO_ONDISK := 1
    static CF_PLACEHOLDER_RANGE_INFO_VALIDATED := 2
    static CF_PLACEHOLDER_RANGE_INFO_MODIFIED := 3
}
