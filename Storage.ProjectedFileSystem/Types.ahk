#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HRESULT, PWSTR}

struct PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT {
    Value : Struct.Ptr
}
struct PRJ_DIR_ENTRY_BUFFER_HANDLE {
    Value : Struct.Ptr
}
struct PRJ_NOTIFY_TYPES extends UInt32 {
    static PRJ_NOTIFY_NONE := 0
    static PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS := 1
    static PRJ_NOTIFY_FILE_OPENED := 2
    static PRJ_NOTIFY_NEW_FILE_CREATED := 4
    static PRJ_NOTIFY_FILE_OVERWRITTEN := 8
    static PRJ_NOTIFY_PRE_DELETE := 16
    static PRJ_NOTIFY_PRE_RENAME := 32
    static PRJ_NOTIFY_PRE_SET_HARDLINK := 64
    static PRJ_NOTIFY_FILE_RENAMED := 128
    static PRJ_NOTIFY_HARDLINK_CREATED := 256
    static PRJ_NOTIFY_FILE_HANDLE_CLOSED_NO_MODIFICATION := 512
    static PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED := 1024
    static PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED := 2048
    static PRJ_NOTIFY_FILE_PRE_CONVERT_TO_FULL := 4096
    static PRJ_NOTIFY_USE_EXISTING_MASK := 4294967295
}
struct PRJ_NOTIFICATION extends Int32 {
    static PRJ_NOTIFICATION_FILE_OPENED := 2
    static PRJ_NOTIFICATION_NEW_FILE_CREATED := 4
    static PRJ_NOTIFICATION_FILE_OVERWRITTEN := 8
    static PRJ_NOTIFICATION_PRE_DELETE := 16
    static PRJ_NOTIFICATION_PRE_RENAME := 32
    static PRJ_NOTIFICATION_PRE_SET_HARDLINK := 64
    static PRJ_NOTIFICATION_FILE_RENAMED := 128
    static PRJ_NOTIFICATION_HARDLINK_CREATED := 256
    static PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_NO_MODIFICATION := 512
    static PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED := 1024
    static PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED := 2048
    static PRJ_NOTIFICATION_FILE_PRE_CONVERT_TO_FULL := 4096
}
struct PRJ_EXT_INFO_TYPE extends Int32 {
    static PRJ_EXT_INFO_TYPE_SYMLINK := 1
}
struct PRJ_EXTENDED_INFO {
    InfoType : PRJ_EXT_INFO_TYPE
    NextInfoOffset : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Symlink : this._Symlink_e__Struct
        }
        struct _Symlink_e__Struct {
            TargetName : PWSTR
        }
    }
}
struct PRJ_NOTIFICATION_MAPPING {
    NotificationBitMask : PRJ_NOTIFY_TYPES
    NotificationRoot : PWSTR
}
struct PRJ_STARTVIRTUALIZING_FLAGS extends Int32 {
    static PRJ_FLAG_NONE := 0
    static PRJ_FLAG_USE_NEGATIVE_PATH_CACHE := 1
}
struct PRJ_STARTVIRTUALIZING_OPTIONS {
    Flags : PRJ_STARTVIRTUALIZING_FLAGS
    PoolThreadCount : UInt32
    ConcurrentThreadCount : UInt32
    NotificationMappings : PRJ_NOTIFICATION_MAPPING.Ptr
    NotificationMappingsCount : UInt32
}
struct PRJ_VIRTUALIZATION_INSTANCE_INFO {
    InstanceID : GUID
    WriteAlignment : UInt32
}
struct PRJ_PLACEHOLDER_ID extends Int32 {
    static PRJ_PLACEHOLDER_ID_LENGTH := 128
}
struct PRJ_PLACEHOLDER_VERSION_INFO {
    ProviderID : UInt8[128]
    ContentID : UInt8[128]
}
struct PRJ_FILE_BASIC_INFO {
    IsDirectory : BOOLEAN
    FileSize : Int64
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    FileAttributes : UInt32
}
struct PRJ_PLACEHOLDER_INFO {
    FileBasicInfo : PRJ_FILE_BASIC_INFO
    EaInformation : this._EaInformation_e__Struct
    SecurityInformation : this._SecurityInformation_e__Struct
    StreamsInformation : this._StreamsInformation_e__Struct
    VersionInfo : PRJ_PLACEHOLDER_VERSION_INFO
    VariableData : UInt8[1]
    struct _EaInformation_e__Struct {
        EaBufferSize : UInt32
        OffsetToFirstEa : UInt32
    }
    struct _SecurityInformation_e__Struct {
        SecurityBufferSize : UInt32
        OffsetToSecurityDescriptor : UInt32
    }
    struct _StreamsInformation_e__Struct {
        StreamsInfoBufferSize : UInt32
        OffsetToFirstStreamInfo : UInt32
    }
}
struct PRJ_UPDATE_TYPES extends Int32 {
    static PRJ_UPDATE_NONE := 0
    static PRJ_UPDATE_ALLOW_DIRTY_METADATA := 1
    static PRJ_UPDATE_ALLOW_DIRTY_DATA := 2
    static PRJ_UPDATE_ALLOW_TOMBSTONE := 4
    static PRJ_UPDATE_RESERVED1 := 8
    static PRJ_UPDATE_RESERVED2 := 16
    static PRJ_UPDATE_ALLOW_READ_ONLY := 32
    static PRJ_UPDATE_MAX_VAL := 64
}
struct PRJ_UPDATE_FAILURE_CAUSES extends Int32 {
    static PRJ_UPDATE_FAILURE_CAUSE_NONE := 0
    static PRJ_UPDATE_FAILURE_CAUSE_DIRTY_METADATA := 1
    static PRJ_UPDATE_FAILURE_CAUSE_DIRTY_DATA := 2
    static PRJ_UPDATE_FAILURE_CAUSE_TOMBSTONE := 4
    static PRJ_UPDATE_FAILURE_CAUSE_READ_ONLY := 8
}
struct PRJ_FILE_STATE extends Int32 {
    static PRJ_FILE_STATE_PLACEHOLDER := 1
    static PRJ_FILE_STATE_HYDRATED_PLACEHOLDER := 2
    static PRJ_FILE_STATE_DIRTY_PLACEHOLDER := 4
    static PRJ_FILE_STATE_FULL := 8
    static PRJ_FILE_STATE_TOMBSTONE := 16
}
struct PRJ_CALLBACK_DATA_FLAGS extends Int32 {
    static PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN := 1
    static PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY := 2
}
struct PRJ_CALLBACK_DATA {
    Size : UInt32
    Flags : PRJ_CALLBACK_DATA_FLAGS
    NamespaceVirtualizationContext : PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT
    CommandId : Int32
    FileId : GUID
    DataStreamId : GUID
    FilePathName : PWSTR
    VersionInfo : PRJ_PLACEHOLDER_VERSION_INFO.Ptr
    TriggeringProcessId : UInt32
    TriggeringProcessImageFileName : PWSTR
    InstanceContext : Struct.Ptr
}
struct PRJ_START_DIRECTORY_ENUMERATION_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, GUID.Ptr, HRESULT]
}
struct PRJ_GET_DIRECTORY_ENUMERATION_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, GUID.Ptr, PWSTR, PRJ_DIR_ENTRY_BUFFER_HANDLE, HRESULT]
}
struct PRJ_END_DIRECTORY_ENUMERATION_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, GUID.Ptr, HRESULT]
}
struct PRJ_GET_PLACEHOLDER_INFO_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, HRESULT]
}
struct PRJ_GET_FILE_DATA_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, Int64, UInt32, HRESULT]
}
struct PRJ_QUERY_FILE_NAME_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, HRESULT]
}
struct PRJ_NOTIFICATION_PARAMETERS {
    union {
        PostCreate : this._PostCreate_e__Struct
        FileRenamed : this._FileRenamed_e__Struct
        FileDeletedOnHandleClose : this._FileDeletedOnHandleClose_e__Struct
    }
    struct _PostCreate_e__Struct {
        NotificationMask : PRJ_NOTIFY_TYPES
    }
    struct _FileRenamed_e__Struct {
        NotificationMask : PRJ_NOTIFY_TYPES
    }
    struct _FileDeletedOnHandleClose_e__Struct {
        IsFileModified : BOOLEAN
    }
}
struct PRJ_NOTIFICATION_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, BOOLEAN, PRJ_NOTIFICATION, PWSTR, PRJ_NOTIFICATION_PARAMETERS.Ptr, HRESULT]
}
struct PRJ_CANCEL_COMMAND_CB extends FunctionPointer {
    static Types := [PRJ_CALLBACK_DATA.Ptr, "Void"]
}
struct PRJ_CALLBACKS {
    StartDirectoryEnumerationCallback : PRJ_START_DIRECTORY_ENUMERATION_CB
    EndDirectoryEnumerationCallback : PRJ_END_DIRECTORY_ENUMERATION_CB
    GetDirectoryEnumerationCallback : PRJ_GET_DIRECTORY_ENUMERATION_CB
    GetPlaceholderInfoCallback : PRJ_GET_PLACEHOLDER_INFO_CB
    GetFileDataCallback : PRJ_GET_FILE_DATA_CB
    QueryFileNameCallback : PRJ_QUERY_FILE_NAME_CB
    NotificationCallback : PRJ_NOTIFICATION_CB
    CancelCommandCallback : PRJ_CANCEL_COMMAND_CB
}
struct PRJ_COMPLETE_COMMAND_TYPE extends Int32 {
    static PRJ_COMPLETE_COMMAND_TYPE_NOTIFICATION := 1
    static PRJ_COMPLETE_COMMAND_TYPE_ENUMERATION := 2
}
struct PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS {
    CommandType : PRJ_COMPLETE_COMMAND_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Notification : this._Notification_e__Struct
            Enumeration : this._Enumeration_e__Struct
        }
        struct _Notification_e__Struct {
            NotificationMask : PRJ_NOTIFY_TYPES
        }
        struct _Enumeration_e__Struct {
            DirEntryBufferHandle : PRJ_DIR_ENTRY_BUFFER_HANDLE
        }
    }
}
