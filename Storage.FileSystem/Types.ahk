#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR, SYSTEMTIME}
#Import "..\Security\Types.ahk" {GENERIC_MAPPING, PRIVILEGE_SET, PSECURITY_DESCRIPTOR, PSID, SECURITY_ATTRIBUTES, SID}
#Import "..\Security.Cryptography\Types.ahk" {ALG_ID}
#Import "..\System.Com\Types.ahk" {IConnectionPointContainer, IUnknown}

struct FIND_FIRST_EX_FLAGS extends UInt32 {
    static FIND_FIRST_EX_CASE_SENSITIVE := 1
    static FIND_FIRST_EX_LARGE_FETCH := 2
    static FIND_FIRST_EX_ON_DISK_ENTRIES_ONLY := 4
}
struct DEFINE_DOS_DEVICE_FLAGS extends UInt32 {
    static DDD_RAW_TARGET_PATH := 1
    static DDD_REMOVE_DEFINITION := 2
    static DDD_EXACT_MATCH_ON_REMOVE := 4
    static DDD_NO_BROADCAST_SYSTEM := 8
    static DDD_LUID_BROADCAST_DRIVE := 16
}
struct FILE_FLAGS_AND_ATTRIBUTES extends UInt32 {
    static FILE_ATTRIBUTE_READONLY := 1
    static FILE_ATTRIBUTE_HIDDEN := 2
    static FILE_ATTRIBUTE_SYSTEM := 4
    static FILE_ATTRIBUTE_DIRECTORY := 16
    static FILE_ATTRIBUTE_ARCHIVE := 32
    static FILE_ATTRIBUTE_DEVICE := 64
    static FILE_ATTRIBUTE_NORMAL := 128
    static FILE_ATTRIBUTE_TEMPORARY := 256
    static FILE_ATTRIBUTE_SPARSE_FILE := 512
    static FILE_ATTRIBUTE_REPARSE_POINT := 1024
    static FILE_ATTRIBUTE_COMPRESSED := 2048
    static FILE_ATTRIBUTE_OFFLINE := 4096
    static FILE_ATTRIBUTE_NOT_CONTENT_INDEXED := 8192
    static FILE_ATTRIBUTE_ENCRYPTED := 16384
    static FILE_ATTRIBUTE_INTEGRITY_STREAM := 32768
    static FILE_ATTRIBUTE_VIRTUAL := 65536
    static FILE_ATTRIBUTE_NO_SCRUB_DATA := 131072
    static FILE_ATTRIBUTE_EA := 262144
    static FILE_ATTRIBUTE_PINNED := 524288
    static FILE_ATTRIBUTE_UNPINNED := 1048576
    static FILE_ATTRIBUTE_RECALL_ON_OPEN := 262144
    static FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS := 4194304
    static FILE_FLAG_WRITE_THROUGH := 2147483648
    static FILE_FLAG_OVERLAPPED := 1073741824
    static FILE_FLAG_NO_BUFFERING := 536870912
    static FILE_FLAG_RANDOM_ACCESS := 268435456
    static FILE_FLAG_SEQUENTIAL_SCAN := 134217728
    static FILE_FLAG_DELETE_ON_CLOSE := 67108864
    static FILE_FLAG_BACKUP_SEMANTICS := 33554432
    static FILE_FLAG_POSIX_SEMANTICS := 16777216
    static FILE_FLAG_SESSION_AWARE := 8388608
    static FILE_FLAG_OPEN_REPARSE_POINT := 2097152
    static FILE_FLAG_OPEN_NO_RECALL := 1048576
    static FILE_FLAG_FIRST_PIPE_INSTANCE := 524288
    static PIPE_ACCESS_DUPLEX := 3
    static PIPE_ACCESS_INBOUND := 1
    static PIPE_ACCESS_OUTBOUND := 2
    static SECURITY_ANONYMOUS := 0
    static SECURITY_IDENTIFICATION := 65536
    static SECURITY_IMPERSONATION := 131072
    static SECURITY_DELEGATION := 196608
    static SECURITY_CONTEXT_TRACKING := 262144
    static SECURITY_EFFECTIVE_ONLY := 524288
    static SECURITY_SQOS_PRESENT := 1048576
    static SECURITY_VALID_SQOS_FLAGS := 2031616
}
struct FILE_ACCESS_RIGHTS extends UInt32 {
    static FILE_READ_DATA := 1
    static FILE_LIST_DIRECTORY := 1
    static FILE_WRITE_DATA := 2
    static FILE_ADD_FILE := 2
    static FILE_APPEND_DATA := 4
    static FILE_ADD_SUBDIRECTORY := 4
    static FILE_CREATE_PIPE_INSTANCE := 4
    static FILE_READ_EA := 8
    static FILE_WRITE_EA := 16
    static FILE_EXECUTE := 32
    static FILE_TRAVERSE := 32
    static FILE_DELETE_CHILD := 64
    static FILE_READ_ATTRIBUTES := 128
    static FILE_WRITE_ATTRIBUTES := 256
    static DELETE := 65536
    static READ_CONTROL := 131072
    static WRITE_DAC := 262144
    static WRITE_OWNER := 524288
    static SYNCHRONIZE := 1048576
    static STANDARD_RIGHTS_REQUIRED := 983040
    static STANDARD_RIGHTS_READ := 131072
    static STANDARD_RIGHTS_WRITE := 131072
    static STANDARD_RIGHTS_EXECUTE := 131072
    static STANDARD_RIGHTS_ALL := 2031616
    static SPECIFIC_RIGHTS_ALL := 65535
    static FILE_ALL_ACCESS := 2032127
    static FILE_GENERIC_READ := 1179785
    static FILE_GENERIC_WRITE := 1179926
    static FILE_GENERIC_EXECUTE := 1179808
}
struct GET_FILE_VERSION_INFO_FLAGS extends UInt32 {
    static FILE_VER_GET_LOCALISED := 1
    static FILE_VER_GET_NEUTRAL := 2
    static FILE_VER_GET_PREFETCHED := 4
}
struct VER_FIND_FILE_FLAGS extends UInt32 {
    static VFFF_ISSHAREDFILE := 1
}
struct VER_FIND_FILE_STATUS extends UInt32 {
    static VFF_CURNEDEST := 1
    static VFF_FILEINUSE := 2
    static VFF_BUFFTOOSMALL := 4
}
struct VER_INSTALL_FILE_FLAGS extends UInt32 {
    static VIFF_FORCEINSTALL := 1
    static VIFF_DONTDELETEOLD := 2
}
struct VER_INSTALL_FILE_STATUS extends UInt32 {
    static VIF_TEMPFILE := 1
    static VIF_MISMATCH := 2
    static VIF_SRCOLD := 4
    static VIF_DIFFLANG := 8
    static VIF_DIFFCODEPG := 16
    static VIF_DIFFTYPE := 32
    static VIF_WRITEPROT := 64
    static VIF_FILEINUSE := 128
    static VIF_OUTOFSPACE := 256
    static VIF_ACCESSVIOLATION := 512
    static VIF_SHARINGVIOLATION := 1024
    static VIF_CANNOTCREATE := 2048
    static VIF_CANNOTDELETE := 4096
    static VIF_CANNOTRENAME := 8192
    static VIF_CANNOTDELETECUR := 16384
    static VIF_OUTOFMEMORY := 32768
    static VIF_CANNOTREADSRC := 65536
    static VIF_CANNOTREADDST := 131072
    static VIF_BUFFTOOSMALL := 262144
    static VIF_CANNOTLOADLZ32 := 524288
    static VIF_CANNOTLOADCABINET := 1048576
}
struct VS_FIXEDFILEINFO_FILE_FLAGS extends UInt32 {
    static VS_FF_DEBUG := 1
    static VS_FF_PRERELEASE := 2
    static VS_FF_PATCHED := 4
    static VS_FF_PRIVATEBUILD := 8
    static VS_FF_INFOINFERRED := 16
    static VS_FF_SPECIALBUILD := 32
}
struct VS_FIXEDFILEINFO_FILE_OS extends UInt32 {
    static VOS_UNKNOWN := 0
    static VOS_DOS := 65536
    static VOS_OS216 := 131072
    static VOS_OS232 := 196608
    static VOS_NT := 262144
    static VOS_WINCE := 327680
    static VOS__BASE := 0
    static VOS__WINDOWS16 := 1
    static VOS__PM16 := 2
    static VOS__PM32 := 3
    static VOS__WINDOWS32 := 4
    static VOS_DOS_WINDOWS16 := 65537
    static VOS_DOS_WINDOWS32 := 65540
    static VOS_OS216_PM16 := 131074
    static VOS_OS232_PM32 := 196611
    static VOS_NT_WINDOWS32 := 262148
}
struct VS_FIXEDFILEINFO_FILE_TYPE extends Int32 {
    static VFT_UNKNOWN := 0
    static VFT_APP := 1
    static VFT_DLL := 2
    static VFT_DRV := 3
    static VFT_FONT := 4
    static VFT_VXD := 5
    static VFT_STATIC_LIB := 7
}
struct VS_FIXEDFILEINFO_FILE_SUBTYPE extends Int32 {
    static VFT2_UNKNOWN := 0
    static VFT2_DRV_PRINTER := 1
    static VFT2_DRV_KEYBOARD := 2
    static VFT2_DRV_LANGUAGE := 3
    static VFT2_DRV_DISPLAY := 4
    static VFT2_DRV_MOUSE := 5
    static VFT2_DRV_NETWORK := 6
    static VFT2_DRV_SYSTEM := 7
    static VFT2_DRV_INSTALLABLE := 8
    static VFT2_DRV_SOUND := 9
    static VFT2_DRV_COMM := 10
    static VFT2_DRV_INPUTMETHOD := 11
    static VFT2_DRV_VERSIONED_PRINTER := 12
    static VFT2_FONT_RASTER := 1
    static VFT2_FONT_VECTOR := 2
    static VFT2_FONT_TRUETYPE := 3
}
struct FILE_CREATION_DISPOSITION extends UInt32 {
    static CREATE_NEW := 1
    static CREATE_ALWAYS := 2
    static OPEN_EXISTING := 3
    static OPEN_ALWAYS := 4
    static TRUNCATE_EXISTING := 5
}
struct FILE_SHARE_MODE extends UInt32 {
    static FILE_SHARE_NONE := 0
    static FILE_SHARE_DELETE := 4
    static FILE_SHARE_READ := 1
    static FILE_SHARE_WRITE := 2
}
struct SHARE_TYPE extends UInt32 {
    static STYPE_DISKTREE := 0
    static STYPE_PRINTQ := 1
    static STYPE_DEVICE := 2
    static STYPE_IPC := 3
    static STYPE_SPECIAL := 2147483648
    static STYPE_TEMPORARY := 1073741824
    static STYPE_MASK := 255
}
struct CLFS_FLAG extends UInt32 {
    static CLFS_FLAG_FORCE_APPEND := 1
    static CLFS_FLAG_FORCE_FLUSH := 2
    static CLFS_FLAG_NO_FLAGS := 0
    static CLFS_FLAG_USE_RESERVATION := 4
}
struct SET_FILE_POINTER_MOVE_METHOD extends UInt32 {
    static FILE_BEGIN := 0
    static FILE_CURRENT := 1
    static FILE_END := 2
}
struct MOVE_FILE_FLAGS extends UInt32 {
    static MOVEFILE_COPY_ALLOWED := 2
    static MOVEFILE_CREATE_HARDLINK := 16
    static MOVEFILE_DELAY_UNTIL_REBOOT := 4
    static MOVEFILE_REPLACE_EXISTING := 1
    static MOVEFILE_WRITE_THROUGH := 8
    static MOVEFILE_FAIL_IF_NOT_TRACKABLE := 32
}
struct GETFINALPATHNAMEBYHANDLE_FLAGS extends UInt32 {
    static VOLUME_NAME_DOS := 0
    static VOLUME_NAME_GUID := 1
    static VOLUME_NAME_NT := 2
    static VOLUME_NAME_NONE := 4
    static FILE_NAME_NORMALIZED := 0
    static FILE_NAME_OPENED := 8
}
struct LZOPENFILE_STYLE extends UInt16 {
    static OF_CANCEL := 2048
    static OF_CREATE := 4096
    static OF_DELETE := 512
    static OF_EXIST := 16384
    static OF_PARSE := 256
    static OF_PROMPT := 8192
    static OF_READ := 0
    static OF_READWRITE := 2
    static OF_REOPEN := 32768
    static OF_SHARE_DENY_NONE := 64
    static OF_SHARE_DENY_READ := 48
    static OF_SHARE_DENY_WRITE := 32
    static OF_SHARE_EXCLUSIVE := 16
    static OF_WRITE := 1
    static OF_SHARE_COMPAT := 0
    static OF_VERIFY := 1024
}
struct FILE_NOTIFY_CHANGE extends UInt32 {
    static FILE_NOTIFY_CHANGE_FILE_NAME := 1
    static FILE_NOTIFY_CHANGE_DIR_NAME := 2
    static FILE_NOTIFY_CHANGE_ATTRIBUTES := 4
    static FILE_NOTIFY_CHANGE_SIZE := 8
    static FILE_NOTIFY_CHANGE_LAST_WRITE := 16
    static FILE_NOTIFY_CHANGE_LAST_ACCESS := 32
    static FILE_NOTIFY_CHANGE_CREATION := 64
    static FILE_NOTIFY_CHANGE_SECURITY := 256
}
struct TXFS_MINIVERSION extends UInt32 {
    static TXFS_MINIVERSION_COMMITTED_VIEW := 0
    static TXFS_MINIVERSION_DIRTY_VIEW := 65535
    static TXFS_MINIVERSION_DEFAULT_VIEW := 65534
}
struct TAPE_POSITION_TYPE extends UInt32 {
    static TAPE_ABSOLUTE_POSITION := 0
    static TAPE_LOGICAL_POSITION := 1
}
struct CREATE_TAPE_PARTITION_METHOD extends UInt32 {
    static TAPE_FIXED_PARTITIONS := 0
    static TAPE_INITIATOR_PARTITIONS := 2
    static TAPE_SELECT_PARTITIONS := 1
}
struct REPLACE_FILE_FLAGS extends UInt32 {
    static REPLACEFILE_WRITE_THROUGH := 1
    static REPLACEFILE_IGNORE_MERGE_ERRORS := 2
    static REPLACEFILE_IGNORE_ACL_ERRORS := 4
}
struct TAPEMARK_TYPE extends UInt32 {
    static TAPE_FILEMARKS := 1
    static TAPE_LONG_FILEMARKS := 3
    static TAPE_SETMARKS := 0
    static TAPE_SHORT_FILEMARKS := 2
}
struct DISKQUOTA_USERNAME_RESOLVE extends UInt32 {
    static DISKQUOTA_USERNAME_RESOLVE_ASYNC := 2
    static DISKQUOTA_USERNAME_RESOLVE_NONE := 0
    static DISKQUOTA_USERNAME_RESOLVE_SYNC := 1
}
struct TAPE_POSITION_METHOD extends UInt32 {
    static TAPE_ABSOLUTE_BLOCK := 1
    static TAPE_LOGICAL_BLOCK := 2
    static TAPE_REWIND := 0
    static TAPE_SPACE_END_OF_DATA := 4
    static TAPE_SPACE_FILEMARKS := 6
    static TAPE_SPACE_RELATIVE_BLOCKS := 5
    static TAPE_SPACE_SEQUENTIAL_FMKS := 7
    static TAPE_SPACE_SEQUENTIAL_SMKS := 9
    static TAPE_SPACE_SETMARKS := 8
}
struct TAPE_INFORMATION_TYPE extends UInt32 {
    static SET_TAPE_DRIVE_INFORMATION := 1
    static SET_TAPE_MEDIA_INFORMATION := 0
}
struct NTMS_OMID_TYPE extends UInt32 {
    static NTMS_OMID_TYPE_FILESYSTEM_INFO := 2
    static NTMS_OMID_TYPE_RAW_LABEL := 1
}
struct LOCK_FILE_FLAGS extends UInt32 {
    static LOCKFILE_EXCLUSIVE_LOCK := 2
    static LOCKFILE_FAIL_IMMEDIATELY := 1
}
struct LPPROGRESS_ROUTINE_CALLBACK_REASON extends UInt32 {
    static CALLBACK_CHUNK_FINISHED := 0
    static CALLBACK_STREAM_SWITCH := 1
}
struct PREPARE_TAPE_OPERATION extends UInt32 {
    static TAPE_FORMAT := 5
    static TAPE_LOAD := 0
    static TAPE_LOCK := 3
    static TAPE_TENSION := 2
    static TAPE_UNLOAD := 1
    static TAPE_UNLOCK := 4
}
struct GET_TAPE_DRIVE_PARAMETERS_OPERATION extends UInt32 {
    static GET_TAPE_DRIVE_INFORMATION := 1
    static GET_TAPE_MEDIA_INFORMATION := 0
}
struct ERASE_TAPE_TYPE extends UInt32 {
    static TAPE_ERASE_LONG := 1
    static TAPE_ERASE_SHORT := 0
}
struct FILE_ACTION extends UInt32 {
    static FILE_ACTION_ADDED := 1
    static FILE_ACTION_REMOVED := 2
    static FILE_ACTION_MODIFIED := 3
    static FILE_ACTION_RENAMED_OLD_NAME := 4
    static FILE_ACTION_RENAMED_NEW_NAME := 5
}
struct SHARE_INFO_PERMISSIONS extends UInt32 {
    static ACCESS_READ := 1
    static ACCESS_WRITE := 2
    static ACCESS_CREATE := 4
    static ACCESS_EXEC := 8
    static ACCESS_DELETE := 16
    static ACCESS_ATRIB := 32
    static ACCESS_PERM := 64
    static ACCESS_ALL := 32768
}
struct FILE_DEVICE_TYPE extends UInt32 {
    static FILE_DEVICE_CD_ROM := 2
    static FILE_DEVICE_DISK := 7
    static FILE_DEVICE_TAPE := 31
    static FILE_DEVICE_DVD := 51
}
struct SESSION_INFO_USER_FLAGS extends UInt32 {
    static SESS_GUEST := 1
    static SESS_NOENCRYPTION := 2
}
struct WIN_STREAM_ID extends UInt32 {
    static BACKUP_ALTERNATE_DATA := 4
    static BACKUP_DATA := 1
    static BACKUP_EA_DATA := 2
    static BACKUP_LINK := 5
    static BACKUP_OBJECT_ID := 7
    static BACKUP_PROPERTY_DATA := 6
    static BACKUP_REPARSE_DATA := 8
    static BACKUP_SECURITY_DATA := 3
    static BACKUP_SPARSE_BLOCK := 9
    static BACKUP_TXFS_DATA := 10
}
struct TXF_LOG_RECORD_TYPE extends UInt16 {
    static TXF_LOG_RECORD_TYPE_AFFECTED_FILE := 4
    static TXF_LOG_RECORD_TYPE_TRUNCATE := 2
    static TXF_LOG_RECORD_TYPE_WRITE := 1
}
struct FILE_INFO_FLAGS_PERMISSIONS extends UInt32 {
    static PERM_FILE_READ := 1
    static PERM_FILE_WRITE := 2
    static PERM_FILE_CREATE := 4
}
struct SYMBOLIC_LINK_FLAGS extends UInt32 {
    static SYMBOLIC_LINK_FLAG_DIRECTORY := 1
    static SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE := 2
}
struct COMPRESSION_FORMAT extends UInt16 {
    static COMPRESSION_FORMAT_NONE := 0
    static COMPRESSION_FORMAT_DEFAULT := 1
    static COMPRESSION_FORMAT_LZNT1 := 2
    static COMPRESSION_FORMAT_XPRESS := 3
    static COMPRESSION_FORMAT_XPRESS_HUFF := 4
    static COMPRESSION_FORMAT_XP10 := 5
    static COMPRESSION_FORMAT_LZ4 := 6
    static COMPRESSION_FORMAT_DEFLATE := 7
    static COMPRESSION_FORMAT_ZLIB := 8
}
struct FILE_TYPE extends UInt32 {
    static FILE_TYPE_UNKNOWN := 0
    static FILE_TYPE_DISK := 1
    static FILE_TYPE_CHAR := 2
    static FILE_TYPE_PIPE := 3
    static FILE_TYPE_REMOTE := 32768
}
struct FILE_DISPOSITION_INFO_EX_FLAGS extends UInt32 {
    static FILE_DISPOSITION_FLAG_DO_NOT_DELETE := 0
    static FILE_DISPOSITION_FLAG_DELETE := 1
    static FILE_DISPOSITION_FLAG_POSIX_SEMANTICS := 2
    static FILE_DISPOSITION_FLAG_FORCE_IMAGE_SECTION_CHECK := 4
    static FILE_DISPOSITION_FLAG_ON_CLOSE := 8
    static FILE_DISPOSITION_FLAG_IGNORE_READONLY_ATTRIBUTE := 16
}
struct COPYFILE_FLAGS extends UInt32 {
    static COPY_FILE_FAIL_IF_EXISTS := 1
    static COPY_FILE_RESTARTABLE := 2
    static COPY_FILE_OPEN_SOURCE_FOR_WRITE := 4
    static COPY_FILE_ALLOW_DECRYPTED_DESTINATION := 8
    static COPY_FILE_COPY_SYMLINK := 2048
    static COPY_FILE_NO_BUFFERING := 4096
    static COPY_FILE_REQUEST_SECURITY_PRIVILEGES := 8192
    static COPY_FILE_RESUME_FROM_PAUSE := 16384
    static COPY_FILE_NO_OFFLOAD := 262144
    static COPY_FILE_IGNORE_EDP_BLOCK := 4194304
    static COPY_FILE_IGNORE_SOURCE_ENCRYPTION := 8388608
    static COPY_FILE_DONT_REQUEST_DEST_WRITE_DAC := 33554432
    static COPY_FILE_REQUEST_COMPRESSED_TRAFFIC := 268435456
    static COPY_FILE_OPEN_AND_COPY_REPARSE_POINT := 2097152
    static COPY_FILE_DIRECTORY := 128
    static COPY_FILE_SKIP_ALTERNATE_STREAMS := 32768
    static COPY_FILE_DISABLE_PRE_ALLOCATION := 67108864
    static COPY_FILE_ENABLE_LOW_FREE_SPACE_MODE := 134217728
    static COPY_FILE_ENABLE_SPARSE_COPY := 536870912
    static COPY_FILE_DISABLE_SPARSE_COPY := 2147483648
}
struct COPYFILE2_V2_FLAGS extends UInt32 {
    static COPY_FILE2_V2_DONT_COPY_JUNCTIONS := 1
    static COPY_FILE2_V2_DISABLE_BLOCK_CLONING := 2
    static COPY_FILE2_V2_VALID_FLAGS := 3
}
struct COPYPROGRESSROUTINE_PROGRESS extends UInt32 {
    static PROGRESS_CONTINUE := 0
    static PROGRESS_CANCEL := 1
    static PROGRESS_STOP := 2
    static PROGRESS_QUIET := 3
}
struct FILE_DISPOSITION_INFO {
    DeleteFile : BOOLEAN
}
struct HIORING {
    Value : IntPtr
}
struct WIN32_FIND_DATAA {
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
    dwReserved0 : UInt32
    dwReserved1 : UInt32
    cFileName : CHAR[260]
    cAlternateFileName : CHAR[14]
}
struct WIN32_FIND_DATAW {
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
    dwReserved0 : UInt32
    dwReserved1 : UInt32
    cFileName : UInt16[260]
    cAlternateFileName : UInt16[14]
}
struct FINDEX_INFO_LEVELS extends Int32 {
    static FindExInfoStandard := 0
    static FindExInfoBasic := 1
    static FindExInfoMaxInfoLevel := 2
}
struct FINDEX_SEARCH_OPS extends Int32 {
    static FindExSearchNameMatch := 0
    static FindExSearchLimitToDirectories := 1
    static FindExSearchLimitToDevices := 2
    static FindExSearchMaxSearchOp := 3
}
struct READ_DIRECTORY_NOTIFY_INFORMATION_CLASS extends Int32 {
    static ReadDirectoryNotifyInformation := 1
    static ReadDirectoryNotifyExtendedInformation := 2
    static ReadDirectoryNotifyFullInformation := 3
    static ReadDirectoryNotifyMaximumInformation := 4
}
struct GET_FILEEX_INFO_LEVELS extends Int32 {
    static GetFileExInfoStandard := 0
    static GetFileExMaxInfoLevel := 1
}
struct FILE_INFO_BY_HANDLE_CLASS extends Int32 {
    static FileBasicInfo := 0
    static FileStandardInfo := 1
    static FileNameInfo := 2
    static FileRenameInfo := 3
    static FileDispositionInfo := 4
    static FileAllocationInfo := 5
    static FileEndOfFileInfo := 6
    static FileStreamInfo := 7
    static FileCompressionInfo := 8
    static FileAttributeTagInfo := 9
    static FileIdBothDirectoryInfo := 10
    static FileIdBothDirectoryRestartInfo := 11
    static FileIoPriorityHintInfo := 12
    static FileRemoteProtocolInfo := 13
    static FileFullDirectoryInfo := 14
    static FileFullDirectoryRestartInfo := 15
    static FileStorageInfo := 16
    static FileAlignmentInfo := 17
    static FileIdInfo := 18
    static FileIdExtdDirectoryInfo := 19
    static FileIdExtdDirectoryRestartInfo := 20
    static FileDispositionInfoEx := 21
    static FileRenameInfoEx := 22
    static FileCaseSensitiveInfo := 23
    static FileNormalizedNameInfo := 24
    static MaximumFileInfoByHandleClass := 25
}
struct FILE_INFO_BY_NAME_CLASS extends Int32 {
    static FileStatByNameInfo := 0
    static FileStatLxByNameInfo := 1
    static FileCaseSensitiveByNameInfo := 2
    static FileStatBasicByNameInfo := 3
    static MaximumFileInfoByNameClass := 4
}
struct TRANSACTION_NOTIFICATION {
    TransactionKey : Struct.Ptr
    TransactionNotification : UInt32
    TmVirtualClock : Int64
    ArgumentLength : UInt32
}
struct TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT {
    EnlistmentId : GUID
    UOW : GUID
}
struct TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT {
    TmIdentity : GUID
    Flags : UInt32
}
struct TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT {
    SavepointId : UInt32
}
struct TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT {
    PropagationCookie : UInt32
    UOW : GUID
    TmIdentity : GUID
    BufferLength : UInt32
}
struct TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT {
    MarshalCookie : UInt32
    UOW : GUID
}
struct KCRM_MARSHAL_HEADER {
    VersionMajor : UInt32
    VersionMinor : UInt32
    NumProtocols : UInt32
    Unused : UInt32
}
struct KCRM_TRANSACTION_BLOB {
    UOW : GUID
    TmIdentity : GUID
    IsolationLevel : UInt32
    IsolationFlags : UInt32
    Timeout : UInt32
    Description : UInt16[64]
}
struct KCRM_PROTOCOL_BLOB {
    ProtocolId : GUID
    StaticInfoLength : UInt32
    TransactionIdInfoLength : UInt32
    Unused1 : UInt32
    Unused2 : UInt32
}
struct DISK_SPACE_INFORMATION {
    ActualTotalAllocationUnits : Int64
    ActualAvailableAllocationUnits : Int64
    ActualPoolUnavailableAllocationUnits : Int64
    CallerTotalAllocationUnits : Int64
    CallerAvailableAllocationUnits : Int64
    CallerPoolUnavailableAllocationUnits : Int64
    UsedAllocationUnits : Int64
    TotalReservedAllocationUnits : Int64
    VolumeStorageReserveAllocationUnits : Int64
    AvailableCommittedAllocationUnits : Int64
    PoolAvailableAllocationUnits : Int64
    SectorsPerAllocationUnit : UInt32
    BytesPerSector : UInt32
}
struct WIN32_FILE_ATTRIBUTE_DATA {
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
}
struct BY_HANDLE_FILE_INFORMATION {
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    dwVolumeSerialNumber : UInt32
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
    nNumberOfLinks : UInt32
    nFileIndexHigh : UInt32
    nFileIndexLow : UInt32
}
struct CREATEFILE2_EXTENDED_PARAMETERS {
    dwSize : UInt32
    dwFileAttributes : UInt32
    dwFileFlags : UInt32
    dwSecurityQosFlags : UInt32
    lpSecurityAttributes : SECURITY_ATTRIBUTES.Ptr
    hTemplateFile : HANDLE
}
struct STREAM_INFO_LEVELS extends Int32 {
    static FindStreamInfoStandard := 0
    static FindStreamInfoMaxInfoLevel := 1
}
struct WIN32_FIND_STREAM_DATA {
    StreamSize : Int64
    cStreamName : UInt16[296]
}
struct CREATEFILE3_EXTENDED_PARAMETERS {
    dwSize : UInt32
    dwFileAttributes : UInt32
    dwFileFlags : UInt32
    dwSecurityQosFlags : UInt32
    lpSecurityAttributes : SECURITY_ATTRIBUTES.Ptr
    hTemplateFile : HANDLE
}
struct DIRECTORY_FLAGS extends Int32 {
    static DIRECTORY_FLAGS_NONE := 0
    static DIRECTORY_FLAGS_DISALLOW_PATH_REDIRECTS := 1
}
struct VS_FIXEDFILEINFO {
    dwSignature : UInt32
    dwStrucVersion : UInt32
    dwFileVersionMS : UInt32
    dwFileVersionLS : UInt32
    dwProductVersionMS : UInt32
    dwProductVersionLS : UInt32
    dwFileFlagsMask : UInt32
    dwFileFlags : VS_FIXEDFILEINFO_FILE_FLAGS
    dwFileOS : VS_FIXEDFILEINFO_FILE_OS
    dwFileType : UInt32
    dwFileSubtype : UInt32
    dwFileDateMS : UInt32
    dwFileDateLS : UInt32
}
struct NtmsObjectsTypes extends Int32 {
    static NTMS_UNKNOWN := 0
    static NTMS_OBJECT := 1
    static NTMS_CHANGER := 2
    static NTMS_CHANGER_TYPE := 3
    static NTMS_COMPUTER := 4
    static NTMS_DRIVE := 5
    static NTMS_DRIVE_TYPE := 6
    static NTMS_IEDOOR := 7
    static NTMS_IEPORT := 8
    static NTMS_LIBRARY := 9
    static NTMS_LIBREQUEST := 10
    static NTMS_LOGICAL_MEDIA := 11
    static NTMS_MEDIA_POOL := 12
    static NTMS_MEDIA_TYPE := 13
    static NTMS_PARTITION := 14
    static NTMS_PHYSICAL_MEDIA := 15
    static NTMS_STORAGESLOT := 16
    static NTMS_OPREQUEST := 17
    static NTMS_UI_DESTINATION := 18
    static NTMS_NUMBER_OF_OBJECT_TYPES := 19
}
struct NTMS_ASYNC_IO {
    OperationId : GUID
    EventId : GUID
    dwOperationType : UInt32
    dwResult : UInt32
    dwAsyncState : UInt32
    hEvent : HANDLE
    bOnStateChange : BOOL
}
struct NtmsAsyncStatus extends Int32 {
    static NTMS_ASYNCSTATE_QUEUED := 0
    static NTMS_ASYNCSTATE_WAIT_RESOURCE := 1
    static NTMS_ASYNCSTATE_WAIT_OPERATOR := 2
    static NTMS_ASYNCSTATE_INPROCESS := 3
    static NTMS_ASYNCSTATE_COMPLETE := 4
}
struct NtmsAsyncOperations extends Int32 {
    static NTMS_ASYNCOP_MOUNT := 1
}
struct NtmsSessionOptions extends Int32 {
    static NTMS_SESSION_QUERYEXPEDITE := 1
}
struct NtmsMountOptions extends Int32 {
    static NTMS_MOUNT_READ := 1
    static NTMS_MOUNT_WRITE := 2
    static NTMS_MOUNT_ERROR_NOT_AVAILABLE := 4
    static NTMS_MOUNT_ERROR_IF_UNAVAILABLE := 4
    static NTMS_MOUNT_ERROR_OFFLINE := 8
    static NTMS_MOUNT_ERROR_IF_OFFLINE := 8
    static NTMS_MOUNT_SPECIFIC_DRIVE := 16
    static NTMS_MOUNT_NOWAIT := 32
}
struct NtmsDismountOptions extends Int32 {
    static NTMS_DISMOUNT_DEFERRED := 1
    static NTMS_DISMOUNT_IMMEDIATE := 2
}
struct NtmsMountPriority extends Int32 {
    static NTMS_PRIORITY_DEFAULT := 0
    static NTMS_PRIORITY_HIGHEST := 15
    static NTMS_PRIORITY_HIGH := 7
    static NTMS_PRIORITY_NORMAL := 0
    static NTMS_PRIORITY_LOW := -7
    static NTMS_PRIORITY_LOWEST := -15
}
struct NTMS_MOUNT_INFORMATION {
    dwSize : UInt32
    lpReserved : Struct.Ptr
}
struct NtmsAllocateOptions extends Int32 {
    static NTMS_ALLOCATE_NEW := 1
    static NTMS_ALLOCATE_NEXT := 2
    static NTMS_ALLOCATE_ERROR_IF_UNAVAILABLE := 4
}
struct NTMS_ALLOCATION_INFORMATION {
    dwSize : UInt32
    lpReserved : Struct.Ptr
    AllocatedFrom : GUID
}
struct NtmsCreateOptions extends Int32 {
    static NTMS_OPEN_EXISTING := 1
    static NTMS_CREATE_NEW := 2
    static NTMS_OPEN_ALWAYS := 3
}
struct NtmsDriveState extends Int32 {
    static NTMS_DRIVESTATE_DISMOUNTED := 0
    static NTMS_DRIVESTATE_MOUNTED := 1
    static NTMS_DRIVESTATE_LOADED := 2
    static NTMS_DRIVESTATE_UNLOADED := 5
    static NTMS_DRIVESTATE_BEING_CLEANED := 6
    static NTMS_DRIVESTATE_DISMOUNTABLE := 7
}
struct NTMS_DRIVEINFORMATIONA {
    Number : UInt32
    State : UInt32
    DriveType : GUID
    szDeviceName : CHAR[64]
    szSerialNumber : CHAR[32]
    szRevision : CHAR[32]
    ScsiPort : UInt16
    ScsiBus : UInt16
    ScsiTarget : UInt16
    ScsiLun : UInt16
    dwMountCount : UInt32
    LastCleanedTs : SYSTEMTIME
    SavedPartitionId : GUID
    Library : GUID
    Reserved : GUID
    dwDeferDismountDelay : UInt32
}
struct NTMS_DRIVEINFORMATIONW {
    Number : UInt32
    State : UInt32
    DriveType : GUID
    szDeviceName : UInt16[64]
    szSerialNumber : UInt16[32]
    szRevision : UInt16[32]
    ScsiPort : UInt16
    ScsiBus : UInt16
    ScsiTarget : UInt16
    ScsiLun : UInt16
    dwMountCount : UInt32
    LastCleanedTs : SYSTEMTIME
    SavedPartitionId : GUID
    Library : GUID
    Reserved : GUID
    dwDeferDismountDelay : UInt32
}
struct NtmsLibraryType extends Int32 {
    static NTMS_LIBRARYTYPE_UNKNOWN := 0
    static NTMS_LIBRARYTYPE_OFFLINE := 1
    static NTMS_LIBRARYTYPE_ONLINE := 2
    static NTMS_LIBRARYTYPE_STANDALONE := 3
}
struct NtmsLibraryFlags extends Int32 {
    static NTMS_LIBRARYFLAG_FIXEDOFFLINE := 1
    static NTMS_LIBRARYFLAG_CLEANERPRESENT := 2
    static NTMS_LIBRARYFLAG_AUTODETECTCHANGE := 4
    static NTMS_LIBRARYFLAG_IGNORECLEANERUSESREMAINING := 8
    static NTMS_LIBRARYFLAG_RECOGNIZECLEANERBARCODE := 16
}
struct NtmsInventoryMethod extends Int32 {
    static NTMS_INVENTORY_NONE := 0
    static NTMS_INVENTORY_FAST := 1
    static NTMS_INVENTORY_OMID := 2
    static NTMS_INVENTORY_DEFAULT := 3
    static NTMS_INVENTORY_SLOT := 4
    static NTMS_INVENTORY_STOP := 5
    static NTMS_INVENTORY_MAX := 6
}
struct NTMS_LIBRARYINFORMATION {
    LibraryType : UInt32
    CleanerSlot : GUID
    CleanerSlotDefault : GUID
    LibrarySupportsDriveCleaning : BOOL
    BarCodeReaderInstalled : BOOL
    InventoryMethod : UInt32
    dwCleanerUsesRemaining : UInt32
    FirstDriveNumber : UInt32
    dwNumberOfDrives : UInt32
    FirstSlotNumber : UInt32
    dwNumberOfSlots : UInt32
    FirstDoorNumber : UInt32
    dwNumberOfDoors : UInt32
    FirstPortNumber : UInt32
    dwNumberOfPorts : UInt32
    FirstChangerNumber : UInt32
    dwNumberOfChangers : UInt32
    dwNumberOfMedia : UInt32
    dwNumberOfMediaTypes : UInt32
    dwNumberOfLibRequests : UInt32
    Reserved : GUID
    AutoRecovery : BOOL
    dwFlags : UInt32
}
struct NTMS_CHANGERINFORMATIONA {
    Number : UInt32
    ChangerType : GUID
    szSerialNumber : CHAR[32]
    szRevision : CHAR[32]
    szDeviceName : CHAR[64]
    ScsiPort : UInt16
    ScsiBus : UInt16
    ScsiTarget : UInt16
    ScsiLun : UInt16
    Library : GUID
}
struct NTMS_CHANGERINFORMATIONW {
    Number : UInt32
    ChangerType : GUID
    szSerialNumber : UInt16[32]
    szRevision : UInt16[32]
    szDeviceName : UInt16[64]
    ScsiPort : UInt16
    ScsiBus : UInt16
    ScsiTarget : UInt16
    ScsiLun : UInt16
    Library : GUID
}
struct NtmsSlotState extends Int32 {
    static NTMS_SLOTSTATE_UNKNOWN := 0
    static NTMS_SLOTSTATE_FULL := 1
    static NTMS_SLOTSTATE_EMPTY := 2
    static NTMS_SLOTSTATE_NOTPRESENT := 3
    static NTMS_SLOTSTATE_NEEDSINVENTORY := 4
}
struct NTMS_STORAGESLOTINFORMATION {
    Number : UInt32
    State : UInt32
    Library : GUID
}
struct NtmsDoorState extends Int32 {
    static NTMS_DOORSTATE_UNKNOWN := 0
    static NTMS_DOORSTATE_CLOSED := 1
    static NTMS_DOORSTATE_OPEN := 2
}
struct NTMS_IEDOORINFORMATION {
    Number : UInt32
    State : UInt32
    MaxOpenSecs : UInt16
    Library : GUID
}
struct NtmsPortPosition extends Int32 {
    static NTMS_PORTPOSITION_UNKNOWN := 0
    static NTMS_PORTPOSITION_EXTENDED := 1
    static NTMS_PORTPOSITION_RETRACTED := 2
}
struct NtmsPortContent extends Int32 {
    static NTMS_PORTCONTENT_UNKNOWN := 0
    static NTMS_PORTCONTENT_FULL := 1
    static NTMS_PORTCONTENT_EMPTY := 2
}
struct NTMS_IEPORTINFORMATION {
    Number : UInt32
    Content : UInt32
    Position : UInt32
    MaxExtendSecs : UInt16
    Library : GUID
}
struct NtmsBarCodeState extends Int32 {
    static NTMS_BARCODESTATE_OK := 1
    static NTMS_BARCODESTATE_UNREADABLE := 2
}
struct NtmsMediaState extends Int32 {
    static NTMS_MEDIASTATE_IDLE := 0
    static NTMS_MEDIASTATE_INUSE := 1
    static NTMS_MEDIASTATE_MOUNTED := 2
    static NTMS_MEDIASTATE_LOADED := 3
    static NTMS_MEDIASTATE_UNLOADED := 4
    static NTMS_MEDIASTATE_OPERROR := 5
    static NTMS_MEDIASTATE_OPREQ := 6
}
struct NTMS_PMIDINFORMATIONA {
    CurrentLibrary : GUID
    MediaPool : GUID
    Location : GUID
    LocationType : UInt32
    MediaType : GUID
    HomeSlot : GUID
    szBarCode : CHAR[64]
    BarCodeState : UInt32
    szSequenceNumber : CHAR[32]
    MediaState : UInt32
    dwNumberOfPartitions : UInt32
    dwMediaTypeCode : UInt32
    dwDensityCode : UInt32
    MountedPartition : GUID
}
struct NTMS_PMIDINFORMATIONW {
    CurrentLibrary : GUID
    MediaPool : GUID
    Location : GUID
    LocationType : UInt32
    MediaType : GUID
    HomeSlot : GUID
    szBarCode : UInt16[64]
    BarCodeState : UInt32
    szSequenceNumber : UInt16[32]
    MediaState : UInt32
    dwNumberOfPartitions : UInt32
    dwMediaTypeCode : UInt32
    dwDensityCode : UInt32
    MountedPartition : GUID
}
struct NTMS_LMIDINFORMATION {
    MediaPool : GUID
    dwNumberOfPartitions : UInt32
}
struct NtmsPartitionState extends Int32 {
    static NTMS_PARTSTATE_UNKNOWN := 0
    static NTMS_PARTSTATE_UNPREPARED := 1
    static NTMS_PARTSTATE_INCOMPATIBLE := 2
    static NTMS_PARTSTATE_DECOMMISSIONED := 3
    static NTMS_PARTSTATE_AVAILABLE := 4
    static NTMS_PARTSTATE_ALLOCATED := 5
    static NTMS_PARTSTATE_COMPLETE := 6
    static NTMS_PARTSTATE_FOREIGN := 7
    static NTMS_PARTSTATE_IMPORT := 8
    static NTMS_PARTSTATE_RESERVED := 9
}
struct NTMS_PARTITIONINFORMATIONA {
    PhysicalMedia : GUID
    LogicalMedia : GUID
    State : UInt32
    Side : UInt16
    dwOmidLabelIdLength : UInt32
    OmidLabelId : UInt8[255]
    szOmidLabelType : CHAR[64]
    szOmidLabelInfo : CHAR[256]
    dwMountCount : UInt32
    dwAllocateCount : UInt32
    Capacity : Int64
}
struct NTMS_PARTITIONINFORMATIONW {
    PhysicalMedia : GUID
    LogicalMedia : GUID
    State : UInt32
    Side : UInt16
    dwOmidLabelIdLength : UInt32
    OmidLabelId : UInt8[255]
    szOmidLabelType : UInt16[64]
    szOmidLabelInfo : UInt16[256]
    dwMountCount : UInt32
    dwAllocateCount : UInt32
    Capacity : Int64
}
struct NtmsPoolType extends Int32 {
    static NTMS_POOLTYPE_UNKNOWN := 0
    static NTMS_POOLTYPE_SCRATCH := 1
    static NTMS_POOLTYPE_FOREIGN := 2
    static NTMS_POOLTYPE_IMPORT := 3
    static NTMS_POOLTYPE_APPLICATION := 1000
}
struct NtmsAllocationPolicy extends Int32 {
    static NTMS_ALLOCATE_FROMSCRATCH := 1
}
struct NtmsDeallocationPolicy extends Int32 {
    static NTMS_DEALLOCATE_TOSCRATCH := 1
}
struct NTMS_MEDIAPOOLINFORMATION {
    PoolType : UInt32
    MediaType : GUID
    Parent : GUID
    AllocationPolicy : UInt32
    DeallocationPolicy : UInt32
    dwMaxAllocates : UInt32
    dwNumberOfPhysicalMedia : UInt32
    dwNumberOfLogicalMedia : UInt32
    dwNumberOfMediaPools : UInt32
}
struct NtmsReadWriteCharacteristics extends Int32 {
    static NTMS_MEDIARW_UNKNOWN := 0
    static NTMS_MEDIARW_REWRITABLE := 1
    static NTMS_MEDIARW_WRITEONCE := 2
    static NTMS_MEDIARW_READONLY := 3
}
struct NTMS_MEDIATYPEINFORMATION {
    MediaType : UInt32
    NumberOfSides : UInt32
    ReadWriteCharacteristics : UInt32
    DeviceType : FILE_DEVICE_TYPE
}
struct NTMS_DRIVETYPEINFORMATIONA {
    szVendor : CHAR[128]
    szProduct : CHAR[128]
    NumberOfHeads : UInt32
    DeviceType : FILE_DEVICE_TYPE
}
struct NTMS_DRIVETYPEINFORMATIONW {
    szVendor : UInt16[128]
    szProduct : UInt16[128]
    NumberOfHeads : UInt32
    DeviceType : FILE_DEVICE_TYPE
}
struct NTMS_CHANGERTYPEINFORMATIONA {
    szVendor : CHAR[128]
    szProduct : CHAR[128]
    DeviceType : UInt32
}
struct NTMS_CHANGERTYPEINFORMATIONW {
    szVendor : UInt16[128]
    szProduct : UInt16[128]
    DeviceType : UInt32
}
struct NtmsLmOperation extends Int32 {
    static NTMS_LM_REMOVE := 0
    static NTMS_LM_DISABLECHANGER := 1
    static NTMS_LM_DISABLELIBRARY := 1
    static NTMS_LM_ENABLECHANGER := 2
    static NTMS_LM_ENABLELIBRARY := 2
    static NTMS_LM_DISABLEDRIVE := 3
    static NTMS_LM_ENABLEDRIVE := 4
    static NTMS_LM_DISABLEMEDIA := 5
    static NTMS_LM_ENABLEMEDIA := 6
    static NTMS_LM_UPDATEOMID := 7
    static NTMS_LM_INVENTORY := 8
    static NTMS_LM_DOORACCESS := 9
    static NTMS_LM_EJECT := 10
    static NTMS_LM_EJECTCLEANER := 11
    static NTMS_LM_INJECT := 12
    static NTMS_LM_INJECTCLEANER := 13
    static NTMS_LM_PROCESSOMID := 14
    static NTMS_LM_CLEANDRIVE := 15
    static NTMS_LM_DISMOUNT := 16
    static NTMS_LM_MOUNT := 17
    static NTMS_LM_WRITESCRATCH := 18
    static NTMS_LM_CLASSIFY := 19
    static NTMS_LM_RESERVECLEANER := 20
    static NTMS_LM_RELEASECLEANER := 21
    static NTMS_LM_MAXWORKITEM := 22
}
struct NtmsLmState extends Int32 {
    static NTMS_LM_QUEUED := 0
    static NTMS_LM_INPROCESS := 1
    static NTMS_LM_PASSED := 2
    static NTMS_LM_FAILED := 3
    static NTMS_LM_INVALID := 4
    static NTMS_LM_WAITING := 5
    static NTMS_LM_DEFERRED := 6
    static NTMS_LM_DEFFERED := 6
    static NTMS_LM_CANCELLED := 7
    static NTMS_LM_STOPPED := 8
}
struct NTMS_LIBREQUESTINFORMATIONA {
    OperationCode : UInt32
    OperationOption : UInt32
    State : UInt32
    PartitionId : GUID
    DriveId : GUID
    PhysMediaId : GUID
    Library : GUID
    SlotId : GUID
    TimeQueued : SYSTEMTIME
    TimeCompleted : SYSTEMTIME
    szApplication : CHAR[64]
    szUser : CHAR[64]
    szComputer : CHAR[64]
    dwErrorCode : UInt32
    WorkItemId : GUID
    dwPriority : UInt32
}
struct NTMS_LIBREQUESTINFORMATIONW {
    OperationCode : UInt32
    OperationOption : UInt32
    State : UInt32
    PartitionId : GUID
    DriveId : GUID
    PhysMediaId : GUID
    Library : GUID
    SlotId : GUID
    TimeQueued : SYSTEMTIME
    TimeCompleted : SYSTEMTIME
    szApplication : UInt16[64]
    szUser : UInt16[64]
    szComputer : UInt16[64]
    dwErrorCode : UInt32
    WorkItemId : GUID
    dwPriority : UInt32
}
struct NtmsOpreqCommand extends Int32 {
    static NTMS_OPREQ_UNKNOWN := 0
    static NTMS_OPREQ_NEWMEDIA := 1
    static NTMS_OPREQ_CLEANER := 2
    static NTMS_OPREQ_DEVICESERVICE := 3
    static NTMS_OPREQ_MOVEMEDIA := 4
    static NTMS_OPREQ_MESSAGE := 5
}
struct NtmsOpreqState extends Int32 {
    static NTMS_OPSTATE_UNKNOWN := 0
    static NTMS_OPSTATE_SUBMITTED := 1
    static NTMS_OPSTATE_ACTIVE := 2
    static NTMS_OPSTATE_INPROGRESS := 3
    static NTMS_OPSTATE_REFUSED := 4
    static NTMS_OPSTATE_COMPLETE := 5
}
struct NTMS_OPREQUESTINFORMATIONA {
    Request : UInt32
    Submitted : SYSTEMTIME
    State : UInt32
    szMessage : CHAR[256]
    Arg1Type : UInt32
    Arg1 : GUID
    Arg2Type : UInt32
    Arg2 : GUID
    szApplication : CHAR[64]
    szUser : CHAR[64]
    szComputer : CHAR[64]
}
struct NTMS_OPREQUESTINFORMATIONW {
    Request : UInt32
    Submitted : SYSTEMTIME
    State : UInt32
    szMessage : UInt16[256]
    Arg1Type : UInt32
    Arg1 : GUID
    Arg2Type : UInt32
    Arg2 : GUID
    szApplication : UInt16[64]
    szUser : UInt16[64]
    szComputer : UInt16[64]
}
struct NTMS_COMPUTERINFORMATION {
    dwLibRequestPurgeTime : UInt32
    dwOpRequestPurgeTime : UInt32
    dwLibRequestFlags : UInt32
    dwOpRequestFlags : UInt32
    dwMediaPoolPolicy : UInt32
}
struct NtmsLibRequestFlags extends Int32 {
    static NTMS_LIBREQFLAGS_NOAUTOPURGE := 1
    static NTMS_LIBREQFLAGS_NOFAILEDPURGE := 2
}
struct NtmsOpRequestFlags extends Int32 {
    static NTMS_OPREQFLAGS_NOAUTOPURGE := 1
    static NTMS_OPREQFLAGS_NOFAILEDPURGE := 2
    static NTMS_OPREQFLAGS_NOALERTS := 16
    static NTMS_OPREQFLAGS_NOTRAYICON := 32
}
struct NtmsMediaPoolPolicy extends Int32 {
    static NTMS_POOLPOLICY_PURGEOFFLINESCRATCH := 1
    static NTMS_POOLPOLICY_KEEPOFFLINEIMPORT := 2
}
struct NtmsOperationalState extends Int32 {
    static NTMS_READY := 0
    static NTMS_INITIALIZING := 10
    static NTMS_NEEDS_SERVICE := 20
    static NTMS_NOT_PRESENT := 21
}
struct NTMS_OBJECTINFORMATIONA {
    dwSize : UInt32
    dwType : UInt32
    Created : SYSTEMTIME
    Modified : SYSTEMTIME
    ObjectGuid : GUID
    Enabled : BOOL
    dwOperationalState : UInt32
    szName : CHAR[64]
    szDescription : CHAR[127]
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            Drive : NTMS_DRIVEINFORMATIONA
            DriveType : NTMS_DRIVETYPEINFORMATIONA
            Library : NTMS_LIBRARYINFORMATION
            Changer : NTMS_CHANGERINFORMATIONA
            ChangerType : NTMS_CHANGERTYPEINFORMATIONA
            StorageSlot : NTMS_STORAGESLOTINFORMATION
            IEDoor : NTMS_IEDOORINFORMATION
            IEPort : NTMS_IEPORTINFORMATION
            PhysicalMedia : NTMS_PMIDINFORMATIONA
            LogicalMedia : NTMS_LMIDINFORMATION
            Partition : NTMS_PARTITIONINFORMATIONA
            MediaPool : NTMS_MEDIAPOOLINFORMATION
            MediaType : NTMS_MEDIATYPEINFORMATION
            LibRequest : NTMS_LIBREQUESTINFORMATIONA
            OpRequest : NTMS_OPREQUESTINFORMATIONA
            Computer : NTMS_COMPUTERINFORMATION
        }
    }
}
struct NTMS_OBJECTINFORMATIONW {
    dwSize : UInt32
    dwType : UInt32
    Created : SYSTEMTIME
    Modified : SYSTEMTIME
    ObjectGuid : GUID
    Enabled : BOOL
    dwOperationalState : UInt32
    szName : UInt16[64]
    szDescription : UInt16[127]
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            Drive : NTMS_DRIVEINFORMATIONW
            DriveType : NTMS_DRIVETYPEINFORMATIONW
            Library : NTMS_LIBRARYINFORMATION
            Changer : NTMS_CHANGERINFORMATIONW
            ChangerType : NTMS_CHANGERTYPEINFORMATIONW
            StorageSlot : NTMS_STORAGESLOTINFORMATION
            IEDoor : NTMS_IEDOORINFORMATION
            IEPort : NTMS_IEPORTINFORMATION
            PhysicalMedia : NTMS_PMIDINFORMATIONW
            LogicalMedia : NTMS_LMIDINFORMATION
            Partition : NTMS_PARTITIONINFORMATIONW
            MediaPool : NTMS_MEDIAPOOLINFORMATION
            MediaType : NTMS_MEDIATYPEINFORMATION
            LibRequest : NTMS_LIBREQUESTINFORMATIONW
            OpRequest : NTMS_OPREQUESTINFORMATIONW
            Computer : NTMS_COMPUTERINFORMATION
        }
    }
}
struct NTMS_I1_LIBRARYINFORMATION {
    LibraryType : UInt32
    CleanerSlot : GUID
    CleanerSlotDefault : GUID
    LibrarySupportsDriveCleaning : BOOL
    BarCodeReaderInstalled : BOOL
    InventoryMethod : UInt32
    dwCleanerUsesRemaining : UInt32
    FirstDriveNumber : UInt32
    dwNumberOfDrives : UInt32
    FirstSlotNumber : UInt32
    dwNumberOfSlots : UInt32
    FirstDoorNumber : UInt32
    dwNumberOfDoors : UInt32
    FirstPortNumber : UInt32
    dwNumberOfPorts : UInt32
    FirstChangerNumber : UInt32
    dwNumberOfChangers : UInt32
    dwNumberOfMedia : UInt32
    dwNumberOfMediaTypes : UInt32
    dwNumberOfLibRequests : UInt32
    Reserved : GUID
}
struct NTMS_I1_LIBREQUESTINFORMATIONA {
    OperationCode : UInt32
    OperationOption : UInt32
    State : UInt32
    PartitionId : GUID
    DriveId : GUID
    PhysMediaId : GUID
    Library : GUID
    SlotId : GUID
    TimeQueued : SYSTEMTIME
    TimeCompleted : SYSTEMTIME
    szApplication : CHAR[64]
    szUser : CHAR[64]
    szComputer : CHAR[64]
}
struct NTMS_I1_LIBREQUESTINFORMATIONW {
    OperationCode : UInt32
    OperationOption : UInt32
    State : UInt32
    PartitionId : GUID
    DriveId : GUID
    PhysMediaId : GUID
    Library : GUID
    SlotId : GUID
    TimeQueued : SYSTEMTIME
    TimeCompleted : SYSTEMTIME
    szApplication : UInt16[64]
    szUser : UInt16[64]
    szComputer : UInt16[64]
}
struct NTMS_I1_PMIDINFORMATIONA {
    CurrentLibrary : GUID
    MediaPool : GUID
    Location : GUID
    LocationType : UInt32
    MediaType : GUID
    HomeSlot : GUID
    szBarCode : CHAR[64]
    BarCodeState : UInt32
    szSequenceNumber : CHAR[32]
    MediaState : UInt32
    dwNumberOfPartitions : UInt32
}
struct NTMS_I1_PMIDINFORMATIONW {
    CurrentLibrary : GUID
    MediaPool : GUID
    Location : GUID
    LocationType : UInt32
    MediaType : GUID
    HomeSlot : GUID
    szBarCode : UInt16[64]
    BarCodeState : UInt32
    szSequenceNumber : UInt16[32]
    MediaState : UInt32
    dwNumberOfPartitions : UInt32
}
struct NTMS_I1_PARTITIONINFORMATIONA {
    PhysicalMedia : GUID
    LogicalMedia : GUID
    State : UInt32
    Side : UInt16
    dwOmidLabelIdLength : UInt32
    OmidLabelId : UInt8[255]
    szOmidLabelType : CHAR[64]
    szOmidLabelInfo : CHAR[256]
    dwMountCount : UInt32
    dwAllocateCount : UInt32
}
struct NTMS_I1_PARTITIONINFORMATIONW {
    PhysicalMedia : GUID
    LogicalMedia : GUID
    State : UInt32
    Side : UInt16
    dwOmidLabelIdLength : UInt32
    OmidLabelId : UInt8[255]
    szOmidLabelType : UInt16[64]
    szOmidLabelInfo : UInt16[256]
    dwMountCount : UInt32
    dwAllocateCount : UInt32
}
struct NTMS_I1_OPREQUESTINFORMATIONA {
    Request : UInt32
    Submitted : SYSTEMTIME
    State : UInt32
    szMessage : CHAR[127]
    Arg1Type : UInt32
    Arg1 : GUID
    Arg2Type : UInt32
    Arg2 : GUID
    szApplication : CHAR[64]
    szUser : CHAR[64]
    szComputer : CHAR[64]
}
struct NTMS_I1_OPREQUESTINFORMATIONW {
    Request : UInt32
    Submitted : SYSTEMTIME
    State : UInt32
    szMessage : UInt16[127]
    Arg1Type : UInt32
    Arg1 : GUID
    Arg2Type : UInt32
    Arg2 : GUID
    szApplication : UInt16[64]
    szUser : UInt16[64]
    szComputer : UInt16[64]
}
struct NTMS_I1_OBJECTINFORMATIONA {
    dwSize : UInt32
    dwType : UInt32
    Created : SYSTEMTIME
    Modified : SYSTEMTIME
    ObjectGuid : GUID
    Enabled : BOOL
    dwOperationalState : UInt32
    szName : CHAR[64]
    szDescription : CHAR[127]
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            Drive : NTMS_DRIVEINFORMATIONA
            DriveType : NTMS_DRIVETYPEINFORMATIONA
            Library : NTMS_I1_LIBRARYINFORMATION
            Changer : NTMS_CHANGERINFORMATIONA
            ChangerType : NTMS_CHANGERTYPEINFORMATIONA
            StorageSlot : NTMS_STORAGESLOTINFORMATION
            IEDoor : NTMS_IEDOORINFORMATION
            IEPort : NTMS_IEPORTINFORMATION
            PhysicalMedia : NTMS_I1_PMIDINFORMATIONA
            LogicalMedia : NTMS_LMIDINFORMATION
            Partition : NTMS_I1_PARTITIONINFORMATIONA
            MediaPool : NTMS_MEDIAPOOLINFORMATION
            MediaType : NTMS_MEDIATYPEINFORMATION
            LibRequest : NTMS_I1_LIBREQUESTINFORMATIONA
            OpRequest : NTMS_I1_OPREQUESTINFORMATIONA
        }
    }
}
struct NTMS_I1_OBJECTINFORMATIONW {
    dwSize : UInt32
    dwType : UInt32
    Created : SYSTEMTIME
    Modified : SYSTEMTIME
    ObjectGuid : GUID
    Enabled : BOOL
    dwOperationalState : UInt32
    szName : UInt16[64]
    szDescription : UInt16[127]
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            Drive : NTMS_DRIVEINFORMATIONW
            DriveType : NTMS_DRIVETYPEINFORMATIONW
            Library : NTMS_I1_LIBRARYINFORMATION
            Changer : NTMS_CHANGERINFORMATIONW
            ChangerType : NTMS_CHANGERTYPEINFORMATIONW
            StorageSlot : NTMS_STORAGESLOTINFORMATION
            IEDoor : NTMS_IEDOORINFORMATION
            IEPort : NTMS_IEPORTINFORMATION
            PhysicalMedia : NTMS_I1_PMIDINFORMATIONW
            LogicalMedia : NTMS_LMIDINFORMATION
            Partition : NTMS_I1_PARTITIONINFORMATIONW
            MediaPool : NTMS_MEDIAPOOLINFORMATION
            MediaType : NTMS_MEDIATYPEINFORMATION
            LibRequest : NTMS_I1_LIBREQUESTINFORMATIONW
            OpRequest : NTMS_I1_OPREQUESTINFORMATIONW
        }
    }
}
struct NtmsCreateNtmsMediaOptions extends Int32 {
    static NTMS_ERROR_ON_DUPLICATE := 1
}
struct NtmsEnumerateOption extends Int32 {
    static NTMS_ENUM_DEFAULT := 0
    static NTMS_ENUM_ROOTPOOL := 1
}
struct NtmsEjectOperation extends Int32 {
    static NTMS_EJECT_START := 0
    static NTMS_EJECT_STOP := 1
    static NTMS_EJECT_QUEUE := 2
    static NTMS_EJECT_FORCE := 3
    static NTMS_EJECT_IMMEDIATE := 4
    static NTMS_EJECT_ASK_USER := 5
}
struct NtmsInjectOperation extends Int32 {
    static NTMS_INJECT_START := 0
    static NTMS_INJECT_STOP := 1
    static NTMS_INJECT_RETRACT := 2
    static NTMS_INJECT_STARTMANY := 3
}
struct NTMS_FILESYSTEM_INFO {
    FileSystemType : UInt16[64]
    VolumeName : UInt16[256]
    SerialNumber : UInt32
}
struct NtmsDriveType extends Int32 {
    static NTMS_UNKNOWN_DRIVE := 0
}
struct NtmsAccessMask extends Int32 {
    static NTMS_USE_ACCESS := 1
    static NTMS_MODIFY_ACCESS := 2
    static NTMS_CONTROL_ACCESS := 4
}
struct NtmsUITypes extends Int32 {
    static NTMS_UITYPE_INVALID := 0
    static NTMS_UITYPE_INFO := 1
    static NTMS_UITYPE_REQ := 2
    static NTMS_UITYPE_ERR := 3
    static NTMS_UITYPE_MAX := 4
}
struct NtmsUIOperations extends Int32 {
    static NTMS_UIDEST_ADD := 1
    static NTMS_UIDEST_DELETE := 2
    static NTMS_UIDEST_DELETEALL := 3
    static NTMS_UIOPERATION_MAX := 4
}
struct NtmsNotificationOperations extends Int32 {
    static NTMS_OBJ_UPDATE := 1
    static NTMS_OBJ_INSERT := 2
    static NTMS_OBJ_DELETE := 3
    static NTMS_EVENT_SIGNAL := 4
    static NTMS_EVENT_COMPLETE := 5
}
struct NTMS_NOTIFICATIONINFORMATION {
    dwOperation : UInt32
    ObjectId : GUID
}
struct MediaLabelInfo {
    LabelType : UInt16[64]
    LabelIDSize : UInt32
    LabelID : UInt8[256]
    LabelAppDescr : UInt16[256]
}
struct MAXMEDIALABEL extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt32]
}
struct CLAIMMEDIALABEL extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, MediaLabelInfo.Ptr, UInt32]
}
struct CLAIMMEDIALABELEX extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, MediaLabelInfo.Ptr, GUID.Ptr, UInt32]
}
struct CLS_LSN {
    Internal : Int64
}
struct CLS_CONTEXT_MODE extends Int32 {
    static ClsContextNone := 0
    static ClsContextUndoNext := 1
    static ClsContextPrevious := 2
    static ClsContextForward := 3
}
struct CLFS_CONTEXT_MODE extends Int32 {
    static ClfsContextNone := 0
    static ClfsContextUndoNext := 1
    static ClfsContextPrevious := 2
    static ClfsContextForward := 3
}
struct CLFS_NODE_ID {
    cType : UInt32
    cbNode : UInt32
}
struct CLS_WRITE_ENTRY {
    Buffer : Struct.Ptr
    ByteLength : UInt32
}
struct CLS_INFORMATION {
    TotalAvailable : Int64
    CurrentAvailable : Int64
    TotalReservation : Int64
    BaseFileSize : Int64
    ContainerSize : Int64
    TotalContainers : UInt32
    FreeContainers : UInt32
    TotalClients : UInt32
    Attributes : UInt32
    FlushThreshold : UInt32
    SectorSize : UInt32
    MinArchiveTailLsn : CLS_LSN
    BaseLsn : CLS_LSN
    LastFlushedLsn : CLS_LSN
    LastLsn : CLS_LSN
    RestartLsn : CLS_LSN
    Identity : GUID
}
struct CLFS_LOG_NAME_INFORMATION {
    NameLengthInBytes : UInt16
    Name : UInt16[1]
}
struct CLFS_STREAM_ID_INFORMATION {
    StreamIdentifier : UInt8
}
struct CLFS_PHYSICAL_LSN_INFORMATION {
    StreamIdentifier : UInt8
    VirtualLsn : CLS_LSN
    PhysicalLsn : CLS_LSN
}
struct CLS_CONTAINER_INFORMATION {
    FileAttributes : UInt32
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ContainerSize : Int64
    FileNameActualLength : UInt32
    FileNameLength : UInt32
    FileName : UInt16[256]
    State : UInt32
    PhysicalContainerId : UInt32
    LogicalContainerId : UInt32
}
struct CLS_LOG_INFORMATION_CLASS extends Int32 {
    static ClfsLogBasicInformation := 0
    static ClfsLogBasicInformationPhysical := 1
    static ClfsLogPhysicalNameInformation := 2
    static ClfsLogStreamIdentifierInformation := 3
    static ClfsLogSystemMarkingInformation := 4
    static ClfsLogPhysicalLsnInformation := 5
}
struct CLS_IOSTATS_CLASS extends Int32 {
    static ClsIoStatsDefault := 0
    static ClsIoStatsMax := 65535
}
struct CLFS_IOSTATS_CLASS extends Int32 {
    static ClfsIoStatsDefault := 0
    static ClfsIoStatsMax := 65535
}
struct CLS_IO_STATISTICS_HEADER {
    ubMajorVersion : UInt8
    ubMinorVersion : UInt8
    eStatsClass : CLFS_IOSTATS_CLASS
    cbLength : UInt16
    coffData : UInt32
}
struct CLS_IO_STATISTICS {
    hdrIoStats : CLS_IO_STATISTICS_HEADER
    cFlush : Int64
    cbFlush : Int64
    cMetaFlush : Int64
    cbMetaFlush : Int64
}
struct CLS_SCAN_CONTEXT {
    cidNode : CLFS_NODE_ID
    hLog : HANDLE
    cIndex : UInt32
    cContainers : UInt32
    cContainersReturned : UInt32
    eScanMode : UInt8
    pinfoContainer : CLS_CONTAINER_INFORMATION.Ptr
}
struct CLS_ARCHIVE_DESCRIPTOR {
    coffLow : Int64
    coffHigh : Int64
    infoContainer : CLS_CONTAINER_INFORMATION
}
struct CLFS_BLOCK_ALLOCATION extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, Struct.Ptr]
}
struct CLFS_BLOCK_DEALLOCATION extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct CLFS_LOG_ARCHIVE_MODE extends Int32 {
    static ClfsLogArchiveEnabled := 1
    static ClfsLogArchiveDisabled := 2
}
struct PCLFS_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, "Void"]
}
struct CLFS_MGMT_POLICY_TYPE extends Int32 {
    static ClfsMgmtPolicyMaximumSize := 0
    static ClfsMgmtPolicyMinimumSize := 1
    static ClfsMgmtPolicyNewContainerSize := 2
    static ClfsMgmtPolicyGrowthRate := 3
    static ClfsMgmtPolicyLogTail := 4
    static ClfsMgmtPolicyAutoShrink := 5
    static ClfsMgmtPolicyAutoGrow := 6
    static ClfsMgmtPolicyNewContainerPrefix := 7
    static ClfsMgmtPolicyNewContainerSuffix := 8
    static ClfsMgmtPolicyNewContainerExtension := 9
    static ClfsMgmtPolicyInvalid := 10
}
struct CLFS_MGMT_POLICY {
    Version : UInt32
    LengthInBytes : UInt32
    PolicyFlags : UInt32
    PolicyType : CLFS_MGMT_POLICY_TYPE
    PolicyParameters : this._PolicyParameters_e__Union
    struct _PolicyParameters_e__Union {
        union {
            MaximumSize : this._MaximumSize_e__Struct
            MinimumSize : this._MinimumSize_e__Struct
            NewContainerSize : this._NewContainerSize_e__Struct
            GrowthRate : this._GrowthRate_e__Struct
            LogTail : this._LogTail_e__Struct
            AutoShrink : this._AutoShrink_e__Struct
            AutoGrow : this._AutoGrow_e__Struct
            NewContainerPrefix : this._NewContainerPrefix_e__Struct
            NewContainerSuffix : this._NewContainerSuffix_e__Struct
            NewContainerExtension : this._NewContainerExtension_e__Struct
        }
        struct _MaximumSize_e__Struct {
            Containers : UInt32
        }
        struct _MinimumSize_e__Struct {
            Containers : UInt32
        }
        struct _NewContainerSize_e__Struct {
            SizeInBytes : UInt32
        }
        struct _GrowthRate_e__Struct {
            AbsoluteGrowthInContainers : UInt32
            RelativeGrowthPercentage : UInt32
        }
        struct _LogTail_e__Struct {
            MinimumAvailablePercentage : UInt32
            MinimumAvailableContainers : UInt32
        }
        struct _AutoShrink_e__Struct {
            Percentage : UInt32
        }
        struct _AutoGrow_e__Struct {
            Enabled : UInt32
        }
        struct _NewContainerPrefix_e__Struct {
            PrefixLengthInBytes : UInt16
            PrefixString : UInt16[1]
        }
        struct _NewContainerSuffix_e__Struct {
            NextContainerSuffix : Int64
        }
        struct _NewContainerExtension_e__Struct {
            ExtensionLengthInBytes : UInt16
            ExtensionString : UInt16[1]
        }
    }
}
struct CLFS_MGMT_NOTIFICATION_TYPE extends Int32 {
    static ClfsMgmtAdvanceTailNotification := 0
    static ClfsMgmtLogFullHandlerNotification := 1
    static ClfsMgmtLogUnpinnedNotification := 2
    static ClfsMgmtLogWriteNotification := 3
}
struct CLFS_MGMT_NOTIFICATION {
    Notification : CLFS_MGMT_NOTIFICATION_TYPE
    Lsn : CLS_LSN
    LogIsPinned : UInt16
}
struct PLOG_TAIL_ADVANCE_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, CLS_LSN, Struct.Ptr, "Void"]
}
struct PLOG_FULL_HANDLER_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, UInt32, BOOL, Struct.Ptr, "Void"]
}
struct PLOG_UNPINNED_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, "Void"]
}
struct LOG_MANAGEMENT_CALLBACKS {
    CallbackContext : Struct.Ptr
    AdvanceTailCallback : PLOG_TAIL_ADVANCE_CALLBACK
    LogFullHandlerCallback : PLOG_FULL_HANDLER_CALLBACK
    LogUnpinnedCallback : PLOG_UNPINNED_CALLBACK
}
struct DISKQUOTA_USER_INFORMATION {
    QuotaUsed : Int64
    QuotaThreshold : Int64
    QuotaLimit : Int64
}
struct IDiskQuotaUser extends IUnknown {
    static IID := "{7988B574-EC89-11CF-9C00-00AA00A14F56}"
    GetID(pulID)
      => ComCall(3, this.p, UInt32.Ptr, pulID)
    GetName(pszAccountContainer, cchAccountContainer, pszLogonName, cchLogonName, pszDisplayName, cchDisplayName)
      => ComCall(4, this.p, "Str", pszAccountContainer, UInt32, cchAccountContainer, "Str", pszLogonName, UInt32, cchLogonName, "Str", pszDisplayName, UInt32, cchDisplayName)
    GetSidLength(pdwLength)
      => ComCall(5, this.p, UInt32.Ptr, pdwLength)
    GetSid(pbSidBuffer, cbSidBuffer)
      => ComCall(6, this.p, UInt8.Ptr, pbSidBuffer, UInt32, cbSidBuffer)
    GetQuotaThreshold(pllThreshold)
      => ComCall(7, this.p, Int64.Ptr, pllThreshold)
    GetQuotaThresholdText(pszText, cchText)
      => ComCall(8, this.p, "Str", pszText, UInt32, cchText)
    GetQuotaLimit(pllLimit)
      => ComCall(9, this.p, Int64.Ptr, pllLimit)
    GetQuotaLimitText(pszText, cchText)
      => ComCall(10, this.p, "Str", pszText, UInt32, cchText)
    GetQuotaUsed(pllUsed)
      => ComCall(11, this.p, Int64.Ptr, pllUsed)
    GetQuotaUsedText(pszText, cchText)
      => ComCall(12, this.p, "Str", pszText, UInt32, cchText)
    GetQuotaInformation(pbQuotaInfo, cbQuotaInfo)
      => ComCall(13, this.p, Struct.Ptr, pbQuotaInfo, UInt32, cbQuotaInfo)
    SetQuotaThreshold(llThreshold, fWriteThrough)
      => ComCall(14, this.p, Int64, llThreshold, BOOL, fWriteThrough)
    SetQuotaLimit(llLimit, fWriteThrough)
      => ComCall(15, this.p, Int64, llLimit, BOOL, fWriteThrough)
    Invalidate()
      => ComCall(16, this.p)
    GetAccountStatus(pdwStatus)
      => ComCall(17, this.p, UInt32.Ptr, pdwStatus)
}
struct IEnumDiskQuotaUsers extends IUnknown {
    static IID := "{7988B577-EC89-11CF-9C00-00AA00A14F56}"
    Next(cUsers, rgUsers, pcUsersFetched)
      => ComCall(3, this.p, UInt32, cUsers, IDiskQuotaUser.Ptr, rgUsers, UInt32.Ptr, pcUsersFetched)
    Skip(cUsers)
      => ComCall(4, this.p, UInt32, cUsers)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDiskQuotaUsers.Ptr, ppEnum)
}
struct IDiskQuotaUserBatch extends IUnknown {
    static IID := "{7988B576-EC89-11CF-9C00-00AA00A14F56}"
    Add(pUser)
      => ComCall(3, this.p, IDiskQuotaUser, pUser)
    Remove(pUser)
      => ComCall(4, this.p, IDiskQuotaUser, pUser)
    RemoveAll()
      => ComCall(5, this.p)
    FlushToDisk()
      => ComCall(6, this.p)
}
struct IDiskQuotaControl extends IConnectionPointContainer {
    static IID := "{7988B572-EC89-11CF-9C00-00AA00A14F56}"
    Initialize(pszPath, bReadWrite)
      => ComCall(5, this.p, "Str", pszPath, BOOL, bReadWrite)
    SetQuotaState(dwState)
      => ComCall(6, this.p, UInt32, dwState)
    GetQuotaState(pdwState)
      => ComCall(7, this.p, UInt32.Ptr, pdwState)
    SetQuotaLogFlags(dwFlags)
      => ComCall(8, this.p, UInt32, dwFlags)
    GetQuotaLogFlags(pdwFlags)
      => ComCall(9, this.p, UInt32.Ptr, pdwFlags)
    SetDefaultQuotaThreshold(llThreshold)
      => ComCall(10, this.p, Int64, llThreshold)
    GetDefaultQuotaThreshold(pllThreshold)
      => ComCall(11, this.p, Int64.Ptr, pllThreshold)
    GetDefaultQuotaThresholdText(pszText, cchText)
      => ComCall(12, this.p, "Str", pszText, UInt32, cchText)
    SetDefaultQuotaLimit(llLimit)
      => ComCall(13, this.p, Int64, llLimit)
    GetDefaultQuotaLimit(pllLimit)
      => ComCall(14, this.p, Int64.Ptr, pllLimit)
    GetDefaultQuotaLimitText(pszText, cchText)
      => ComCall(15, this.p, "Str", pszText, UInt32, cchText)
    AddUserSid(pUserSid, fNameResolution, ppUser)
      => ComCall(16, this.p, PSID, pUserSid, DISKQUOTA_USERNAME_RESOLVE, fNameResolution, IDiskQuotaUser.Ptr, ppUser)
    AddUserName(pszLogonName, fNameResolution, ppUser)
      => ComCall(17, this.p, "Str", pszLogonName, DISKQUOTA_USERNAME_RESOLVE, fNameResolution, IDiskQuotaUser.Ptr, ppUser)
    DeleteUser(pUser)
      => ComCall(18, this.p, IDiskQuotaUser, pUser)
    FindUserSid(pUserSid, fNameResolution, ppUser)
      => ComCall(19, this.p, PSID, pUserSid, DISKQUOTA_USERNAME_RESOLVE, fNameResolution, IDiskQuotaUser.Ptr, ppUser)
    FindUserName(pszLogonName, ppUser)
      => ComCall(20, this.p, "Str", pszLogonName, IDiskQuotaUser.Ptr, ppUser)
    CreateEnumUsers(rgpUserSids, cpSids, fNameResolution, ppEnum)
      => ComCall(21, this.p, PSID.Ptr, rgpUserSids, UInt32, cpSids, DISKQUOTA_USERNAME_RESOLVE, fNameResolution, IEnumDiskQuotaUsers.Ptr, ppEnum)
    CreateUserBatch(ppBatch)
      => ComCall(22, this.p, IDiskQuotaUserBatch.Ptr, ppBatch)
    InvalidateSidNameCache()
      => ComCall(23, this.p)
    GiveUserNameResolutionPriority(pUser)
      => ComCall(24, this.p, IDiskQuotaUser, pUser)
    ShutdownNameResolution()
      => ComCall(25, this.p)
}
struct IDiskQuotaEvents extends IUnknown {
    static IID := "{7988B579-EC89-11CF-9C00-00AA00A14F56}"
    OnUserNameChanged(pUser)
      => ComCall(3, this.p, IDiskQuotaUser, pUser)
}
struct EFS_CERTIFICATE_BLOB {
    dwCertEncodingType : UInt32
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct EFS_HASH_BLOB {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct EFS_RPC_BLOB {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct EFS_PIN_BLOB {
    cbPadding : UInt32
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct EFS_KEY_INFO {
    dwVersion : UInt32
    Entropy : UInt32
    Algorithm : ALG_ID
    KeyLength : UInt32
}
struct EFS_COMPATIBILITY_INFO {
    EfsVersion : UInt32
}
struct EFS_VERSION_INFO {
    EfsVersion : UInt32
    SubVersion : UInt32
}
struct EFS_DECRYPTION_STATUS_INFO {
    dwDecryptionError : UInt32
    dwHashOffset : UInt32
    cbHash : UInt32
}
struct EFS_ENCRYPTION_STATUS_INFO {
    bHasCurrentKey : BOOL
    dwEncryptionError : UInt32
}
struct ENCRYPTION_CERTIFICATE {
    cbTotalLength : UInt32
    pUserSid : SID.Ptr
    pCertBlob : EFS_CERTIFICATE_BLOB.Ptr
}
struct ENCRYPTION_CERTIFICATE_HASH {
    cbTotalLength : UInt32
    pUserSid : SID.Ptr
    pHash : EFS_HASH_BLOB.Ptr
    lpDisplayInformation : PWSTR
}
struct ENCRYPTION_CERTIFICATE_HASH_LIST {
    nCert_Hash : UInt32
    pUsers : ENCRYPTION_CERTIFICATE_HASH.Ptr.Ptr
}
struct ENCRYPTION_CERTIFICATE_LIST {
    nUsers : UInt32
    pUsers : ENCRYPTION_CERTIFICATE.Ptr.Ptr
}
struct ENCRYPTED_FILE_METADATA_SIGNATURE {
    dwEfsAccessType : UInt32
    pCertificatesAdded : ENCRYPTION_CERTIFICATE_HASH_LIST.Ptr
    pEncryptionCertificate : ENCRYPTION_CERTIFICATE.Ptr
    pEfsStreamSignature : EFS_RPC_BLOB.Ptr
}
struct ENCRYPTION_PROTECTOR {
    cbTotalLength : UInt32
    pUserSid : SID.Ptr
    lpProtectorDescriptor : PWSTR
}
struct ENCRYPTION_PROTECTOR_LIST {
    nProtectors : UInt32
    pProtectors : ENCRYPTION_PROTECTOR.Ptr.Ptr
}
struct WofEnumEntryProc extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, BOOL]
}
struct WofEnumFilesProc extends FunctionPointer {
    static Types := [PWSTR, Struct.Ptr, Struct.Ptr, BOOL]
}
struct WIM_ENTRY_INFO {
    WimEntryInfoSize : UInt32
    WimType : UInt32
    DataSourceId : Int64
    WimGuid : GUID
    WimPath : PWSTR
    WimIndex : UInt32
    Flags : UInt32
}
struct WIM_EXTERNAL_FILE_INFO {
    DataSourceId : Int64
    ResourceHash : UInt8[20]
    Flags : UInt32
}
struct WOF_FILE_COMPRESSION_INFO_V0 {
    Algorithm : UInt32
}
struct WOF_FILE_COMPRESSION_INFO_V1 {
    Algorithm : UInt32
    Flags : UInt32
}
struct TXF_ID {
    Anonymous : this._Anonymous_e__Struct
    struct _Anonymous_e__Struct {
        LowPart : Int64
        HighPart : Int64
    }
}
struct TXF_LOG_RECORD_BASE {
    Version : UInt16
    RecordType : TXF_LOG_RECORD_TYPE
    RecordLength : UInt32
}
struct TXF_LOG_RECORD_WRITE {
    Version : UInt16
    RecordType : UInt16
    RecordLength : UInt32
    Flags : UInt32
    TxfFileId : TXF_ID
    KtmGuid : GUID
    ByteOffsetInFile : Int64
    NumBytesWritten : UInt32
    ByteOffsetInStructure : UInt32
    FileNameLength : UInt32
    FileNameByteOffsetInStructure : UInt32
}
struct TXF_LOG_RECORD_TRUNCATE {
    Version : UInt16
    RecordType : UInt16
    RecordLength : UInt32
    Flags : UInt32
    TxfFileId : TXF_ID
    KtmGuid : GUID
    NewFileSize : Int64
    FileNameLength : UInt32
    FileNameByteOffsetInStructure : UInt32
}
struct TXF_LOG_RECORD_AFFECTED_FILE {
    Version : UInt16
    RecordLength : UInt32
    Flags : UInt32
    TxfFileId : TXF_ID
    KtmGuid : GUID
    FileNameLength : UInt32
    FileNameByteOffsetInStructure : UInt32
}
struct VOLUME_FAILOVER_SET {
    NumberOfDisks : UInt32
    DiskNumbers : UInt32[1]
}
struct VOLUME_NUMBER {
    VolumeNumber : UInt32
    VolumeManagerName : UInt16[8]
}
struct VOLUME_LOGICAL_OFFSET {
    LogicalOffset : Int64
}
struct VOLUME_PHYSICAL_OFFSET {
    DiskNumber : UInt32
    Offset : Int64
}
struct VOLUME_PHYSICAL_OFFSETS {
    NumberOfPhysicalOffsets : UInt32
    PhysicalOffset : VOLUME_PHYSICAL_OFFSET[1]
}
struct VOLUME_READ_PLEX_INPUT {
    ByteOffset : Int64
    Length : UInt32
    PlexNumber : UInt32
}
struct VOLUME_SET_GPT_ATTRIBUTES_INFORMATION {
    GptAttributes : Int64
    RevertOnClose : BOOLEAN
    ApplyToAllConnectedVolumes : BOOLEAN
    Reserved1 : UInt16
    Reserved2 : UInt32
}
struct VOLUME_GET_BC_PROPERTIES_INPUT {
    Version : UInt32
    Reserved1 : UInt32
    LowestByteOffset : Int64
    HighestByteOffset : Int64
    AccessType : UInt32
    AccessMode : UInt32
}
struct VOLUME_GET_BC_PROPERTIES_OUTPUT {
    MaximumRequestsPerPeriod : UInt32
    MinimumPeriod : UInt32
    MaximumRequestSize : Int64
    EstimatedTimePerRequest : UInt32
    NumOutStandingRequests : UInt32
    RequestSize : Int64
}
struct VOLUME_ALLOCATE_BC_STREAM_INPUT {
    Version : UInt32
    RequestsPerPeriod : UInt32
    Period : UInt32
    RetryFailures : BOOLEAN
    Discardable : BOOLEAN
    Reserved1 : BOOLEAN[2]
    LowestByteOffset : Int64
    HighestByteOffset : Int64
    AccessType : UInt32
    AccessMode : UInt32
}
struct VOLUME_ALLOCATE_BC_STREAM_OUTPUT {
    RequestSize : Int64
    NumOutStandingRequests : UInt32
}
struct FILE_EXTENT {
    VolumeOffset : Int64
    ExtentLength : Int64
}
struct VOLUME_CRITICAL_IO {
    AccessType : UInt32
    ExtentsCount : UInt32
    Extents : FILE_EXTENT[1]
}
struct VOLUME_ALLOCATION_HINT_INPUT {
    ClusterSize : UInt32
    NumberOfClusters : UInt32
    StartingClusterNumber : Int64
}
struct VOLUME_ALLOCATION_HINT_OUTPUT {
    Bitmap : UInt32[1]
}
struct VOLUME_SHRINK_INFO {
    VolumeSize : Int64
}
struct SHARE_INFO_0 {
    shi0_netname : PWSTR
}
struct SHARE_INFO_1 {
    shi1_netname : PWSTR
    shi1_type : SHARE_TYPE
    shi1_remark : PWSTR
}
struct SHARE_INFO_2 {
    shi2_netname : PWSTR
    shi2_type : SHARE_TYPE
    shi2_remark : PWSTR
    shi2_permissions : SHARE_INFO_PERMISSIONS
    shi2_max_uses : UInt32
    shi2_current_uses : UInt32
    shi2_path : PWSTR
    shi2_passwd : PWSTR
}
struct SHARE_INFO_501 {
    shi501_netname : PWSTR
    shi501_type : SHARE_TYPE
    shi501_remark : PWSTR
    shi501_flags : UInt32
}
struct SHARE_INFO_502 {
    shi502_netname : PWSTR
    shi502_type : SHARE_TYPE
    shi502_remark : PWSTR
    shi502_permissions : SHARE_INFO_PERMISSIONS
    shi502_max_uses : UInt32
    shi502_current_uses : UInt32
    shi502_path : PWSTR
    shi502_passwd : PWSTR
    shi502_reserved : UInt32
    shi502_security_descriptor : PSECURITY_DESCRIPTOR
}
struct SHARE_INFO_503 {
    shi503_netname : PWSTR
    shi503_type : SHARE_TYPE
    shi503_remark : PWSTR
    shi503_permissions : SHARE_INFO_PERMISSIONS
    shi503_max_uses : UInt32
    shi503_current_uses : UInt32
    shi503_path : PWSTR
    shi503_passwd : PWSTR
    shi503_servername : PWSTR
    shi503_reserved : UInt32
    shi503_security_descriptor : PSECURITY_DESCRIPTOR
}
struct SHARE_INFO_1004 {
    shi1004_remark : PWSTR
}
struct SHARE_INFO_1005 {
    shi1005_flags : UInt32
}
struct SHARE_INFO_1006 {
    shi1006_max_uses : UInt32
}
struct SHARE_INFO_1501 {
    shi1501_reserved : UInt32
    shi1501_security_descriptor : PSECURITY_DESCRIPTOR
}
struct SHARE_INFO_1503 {
    shi1503_sharefilter : GUID
}
struct SERVER_ALIAS_INFO_0 {
    srvai0_alias : PWSTR
    srvai0_target : PWSTR
    srvai0_default : BOOLEAN
    srvai0_reserved : UInt32
}
struct SESSION_INFO_0 {
    sesi0_cname : PWSTR
}
struct SESSION_INFO_1 {
    sesi1_cname : PWSTR
    sesi1_username : PWSTR
    sesi1_num_opens : UInt32
    sesi1_time : UInt32
    sesi1_idle_time : UInt32
    sesi1_user_flags : SESSION_INFO_USER_FLAGS
}
struct SESSION_INFO_2 {
    sesi2_cname : PWSTR
    sesi2_username : PWSTR
    sesi2_num_opens : UInt32
    sesi2_time : UInt32
    sesi2_idle_time : UInt32
    sesi2_user_flags : SESSION_INFO_USER_FLAGS
    sesi2_cltype_name : PWSTR
}
struct SESSION_INFO_10 {
    sesi10_cname : PWSTR
    sesi10_username : PWSTR
    sesi10_time : UInt32
    sesi10_idle_time : UInt32
}
struct SESSION_INFO_502 {
    sesi502_cname : PWSTR
    sesi502_username : PWSTR
    sesi502_num_opens : UInt32
    sesi502_time : UInt32
    sesi502_idle_time : UInt32
    sesi502_user_flags : SESSION_INFO_USER_FLAGS
    sesi502_cltype_name : PWSTR
    sesi502_transport : PWSTR
}
struct CONNECTION_INFO_0 {
    coni0_id : UInt32
}
struct CONNECTION_INFO_1 {
    coni1_id : UInt32
    coni1_type : SHARE_TYPE
    coni1_num_opens : UInt32
    coni1_num_users : UInt32
    coni1_time : UInt32
    coni1_username : PWSTR
    coni1_netname : PWSTR
}
struct FILE_INFO_2 {
    fi2_id : UInt32
}
struct FILE_INFO_3 {
    fi3_id : UInt32
    fi3_permissions : FILE_INFO_FLAGS_PERMISSIONS
    fi3_num_locks : UInt32
    fi3_pathname : PWSTR
    fi3_username : PWSTR
}
struct STAT_WORKSTATION_0 {
    StatisticsStartTime : Int64
    BytesReceived : Int64
    SmbsReceived : Int64
    PagingReadBytesRequested : Int64
    NonPagingReadBytesRequested : Int64
    CacheReadBytesRequested : Int64
    NetworkReadBytesRequested : Int64
    BytesTransmitted : Int64
    SmbsTransmitted : Int64
    PagingWriteBytesRequested : Int64
    NonPagingWriteBytesRequested : Int64
    CacheWriteBytesRequested : Int64
    NetworkWriteBytesRequested : Int64
    InitiallyFailedOperations : UInt32
    FailedCompletionOperations : UInt32
    ReadOperations : UInt32
    RandomReadOperations : UInt32
    ReadSmbs : UInt32
    LargeReadSmbs : UInt32
    SmallReadSmbs : UInt32
    WriteOperations : UInt32
    RandomWriteOperations : UInt32
    WriteSmbs : UInt32
    LargeWriteSmbs : UInt32
    SmallWriteSmbs : UInt32
    RawReadsDenied : UInt32
    RawWritesDenied : UInt32
    NetworkErrors : UInt32
    Sessions : UInt32
    FailedSessions : UInt32
    Reconnects : UInt32
    CoreConnects : UInt32
    Lanman20Connects : UInt32
    Lanman21Connects : UInt32
    LanmanNtConnects : UInt32
    ServerDisconnects : UInt32
    HungSessions : UInt32
    UseCount : UInt32
    FailedUseCount : UInt32
    CurrentCommands : UInt32
}
struct STAT_SERVER_0 {
    sts0_start : UInt32
    sts0_fopens : UInt32
    sts0_devopens : UInt32
    sts0_jobsqueued : UInt32
    sts0_sopens : UInt32
    sts0_stimedout : UInt32
    sts0_serrorout : UInt32
    sts0_pwerrors : UInt32
    sts0_permerrors : UInt32
    sts0_syserrors : UInt32
    sts0_bytessent_low : UInt32
    sts0_bytessent_high : UInt32
    sts0_bytesrcvd_low : UInt32
    sts0_bytesrcvd_high : UInt32
    sts0_avresponse : UInt32
    sts0_reqbufneed : UInt32
    sts0_bigbufneed : UInt32
}
struct PFN_IO_COMPLETION extends FunctionPointer {
    static Types := [FIO_CONTEXT.Ptr, FH_OVERLAPPED.Ptr, UInt32, UInt32, "Void"]
}
struct FH_OVERLAPPED {
    Internal : IntPtr
    InternalHigh : IntPtr
    Offset : UInt32
    OffsetHigh : UInt32
    hEvent : HANDLE
    pfnCompletion : PFN_IO_COMPLETION
    Reserved1 : IntPtr
    Reserved2 : IntPtr
    Reserved3 : IntPtr
    Reserved4 : IntPtr
}
struct FIO_CONTEXT {
    m_dwTempHack : UInt32
    m_dwSignature : UInt32
    m_hFile : HANDLE
    m_dwLinesOffset : UInt32
    m_dwHeaderLength : UInt32
}
struct FCACHE_CREATE_CALLBACK extends FunctionPointer {
    static Types := [PSTR, Struct.Ptr, UInt32.Ptr, UInt32.Ptr, HANDLE]
}
struct FCACHE_RICHCREATE_CALLBACK extends FunctionPointer {
    static Types := [PSTR, Struct.Ptr, UInt32.Ptr, UInt32.Ptr, BOOL.Ptr, BOOL.Ptr, BOOL.Ptr, BOOL.Ptr, HANDLE]
}
struct CACHE_KEY_COMPARE extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, UInt32, UInt8.Ptr, Int32]
}
struct CACHE_KEY_HASH extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, UInt32]
}
struct CACHE_READ_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, Struct.Ptr, BOOL]
}
struct CACHE_DESTROY_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, "Void"]
}
struct CACHE_ACCESS_CHECK extends FunctionPointer {
    static Types := [PSECURITY_DESCRIPTOR, HANDLE, UInt32, GENERIC_MAPPING.Ptr, PRIVILEGE_SET.Ptr, UInt32.Ptr, UInt32.Ptr, BOOL.Ptr, BOOL]
}
struct NAME_CACHE_CONTEXT {
    m_dwSignature : UInt32
}
struct IORING_VERSION extends Int32 {
    static IORING_VERSION_INVALID := 0
    static IORING_VERSION_1 := 1
    static IORING_VERSION_2 := 2
    static IORING_VERSION_3 := 300
    static IORING_VERSION_4 := 400
}
struct IORING_FEATURE_FLAGS extends Int32 {
    static IORING_FEATURE_FLAGS_NONE := 0
    static IORING_FEATURE_UM_EMULATION := 1
    static IORING_FEATURE_SET_COMPLETION_EVENT := 2
}
struct IORING_OP_CODE extends Int32 {
    static IORING_OP_NOP := 0
    static IORING_OP_READ := 1
    static IORING_OP_REGISTER_FILES := 2
    static IORING_OP_REGISTER_BUFFERS := 3
    static IORING_OP_CANCEL := 4
    static IORING_OP_WRITE := 5
    static IORING_OP_FLUSH := 6
    static IORING_OP_READ_SCATTER := 7
    static IORING_OP_WRITE_GATHER := 8
}
struct IORING_BUFFER_INFO {
    Address : Struct.Ptr
    Length : UInt32
}
struct IORING_REGISTERED_BUFFER {
    BufferIndex : UInt32
    Offset : UInt32
}
struct IORING_SQE_FLAGS extends Int32 {
    static IOSQE_FLAGS_NONE := 0
    static IOSQE_FLAGS_DRAIN_PRECEDING_OPS := 1
}
struct IORING_CREATE_REQUIRED_FLAGS extends Int32 {
    static IORING_CREATE_REQUIRED_FLAGS_NONE := 0
}
struct IORING_CREATE_ADVISORY_FLAGS extends Int32 {
    static IORING_CREATE_ADVISORY_FLAGS_NONE := 0
    static IORING_CREATE_SKIP_BUILDER_PARAM_CHECKS := 1
}
struct IORING_CREATE_FLAGS {
    Required : IORING_CREATE_REQUIRED_FLAGS
    Advisory : IORING_CREATE_ADVISORY_FLAGS
}
struct IORING_INFO {
    IoRingVersion : IORING_VERSION
    Flags : IORING_CREATE_FLAGS
    SubmissionQueueSize : UInt32
    CompletionQueueSize : UInt32
}
struct IORING_CAPABILITIES {
    MaxVersion : IORING_VERSION
    MaxSubmissionQueueSize : UInt32
    MaxCompletionQueueSize : UInt32
    FeatureFlags : IORING_FEATURE_FLAGS
}
struct IORING_REF_KIND extends Int32 {
    static IORING_REF_RAW := 0
    static IORING_REF_REGISTERED := 1
}
struct IORING_HANDLE_REF {
    Kind : IORING_REF_KIND
    Handle : this.HandleUnion
    struct HandleUnion {
        union {
            Handle : HANDLE
            Index : UInt32
        }
    }
}
struct IORING_BUFFER_REF {
    Kind : IORING_REF_KIND
    Buffer : this.BufferUnion
    struct BufferUnion {
        union {
            Address : Struct.Ptr
            IndexAndOffset : IORING_REGISTERED_BUFFER
        }
    }
}
struct IORING_CQE {
    UserData : IntPtr
    ResultCode : HRESULT
    Information : IntPtr
}
struct CREATE_BIND_LINK_FLAGS extends Int32 {
    static CREATE_BIND_LINK_FLAG_NONE := 0
    static CREATE_BIND_LINK_FLAG_READ_ONLY := 1
    static CREATE_BIND_LINK_FLAG_MERGED := 2
}
struct FILE_ID_128 {
    Identifier : UInt8[16]
}
struct FILE_NOTIFY_INFORMATION {
    NextEntryOffset : UInt32
    Action : FILE_ACTION
    FileNameLength : UInt32
    FileName : UInt16[1]
}
struct FILE_NOTIFY_EXTENDED_INFORMATION {
    NextEntryOffset : UInt32
    Action : FILE_ACTION
    CreationTime : Int64
    LastModificationTime : Int64
    LastChangeTime : Int64
    LastAccessTime : Int64
    AllocatedLength : Int64
    FileSize : Int64
    FileAttributes : UInt32
    Anonymous : this._Anonymous_e__Union
    FileId : Int64
    ParentFileId : Int64
    FileNameLength : UInt32
    FileName : UInt16[1]
    struct _Anonymous_e__Union {
        union {
            ReparsePointTag : UInt32
            EaSize : UInt32
        }
    }
}
struct FILE_STAT_BASIC_INFORMATION {
    FileId : Int64
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    AllocationSize : Int64
    EndOfFile : Int64
    FileAttributes : UInt32
    ReparseTag : UInt32
    NumberOfLinks : UInt32
    DeviceType : UInt32
    DeviceCharacteristics : UInt32
    Reserved : UInt32
    VolumeSerialNumber : Int64
    FileId128 : FILE_ID_128
}
struct FILE_SEGMENT_ELEMENT {
    union {
        Buffer : Struct.Ptr
        Alignment : Int64
    }
}
struct REPARSE_GUID_DATA_BUFFER {
    ReparseTag : UInt32
    ReparseDataLength : UInt16
    Reserved : UInt16
    ReparseGuid : GUID
    GenericReparseBuffer : this._GenericReparseBuffer_e__Struct
    struct _GenericReparseBuffer_e__Struct {
        DataBuffer : UInt8[1]
    }
}
struct TAPE_ERASE {
    Type : ERASE_TAPE_TYPE
    Immediate : BOOLEAN
}
struct TAPE_PREPARE {
    Operation : PREPARE_TAPE_OPERATION
    Immediate : BOOLEAN
}
struct TAPE_WRITE_MARKS {
    Type : TAPEMARK_TYPE
    Count : UInt32
    Immediate : BOOLEAN
}
struct TAPE_GET_POSITION {
    Type : TAPE_POSITION_TYPE
    Partition : UInt32
    Offset : Int64
}
struct TAPE_SET_POSITION {
    Method : TAPE_POSITION_METHOD
    Partition : UInt32
    Offset : Int64
    Immediate : BOOLEAN
}
struct TRANSACTION_OUTCOME extends Int32 {
    static TransactionOutcomeUndetermined := 1
    static TransactionOutcomeCommitted := 2
    static TransactionOutcomeAborted := 3
}
struct STORAGE_BUS_TYPE extends Int32 {
    static BusTypeUnknown := 0
    static BusTypeScsi := 1
    static BusTypeAtapi := 2
    static BusTypeAta := 3
    static BusType1394 := 4
    static BusTypeSsa := 5
    static BusTypeFibre := 6
    static BusTypeUsb := 7
    static BusTypeRAID := 8
    static BusTypeiScsi := 9
    static BusTypeSas := 10
    static BusTypeSata := 11
    static BusTypeSd := 12
    static BusTypeMmc := 13
    static BusTypeVirtual := 14
    static BusTypeFileBackedVirtual := 15
    static BusTypeSpaces := 16
    static BusTypeNvme := 17
    static BusTypeSCM := 18
    static BusTypeUfs := 19
    static BusTypeNvmeof := 20
    static BusTypeMax := 21
    static BusTypeMaxReserved := 127
}
struct FILE_WRITE_FLAGS extends Int32 {
    static FILE_WRITE_FLAGS_NONE := 0
    static FILE_WRITE_FLAGS_WRITE_THROUGH := 1
}
struct FILE_FLUSH_MODE extends Int32 {
    static FILE_FLUSH_DEFAULT := 0
    static FILE_FLUSH_DATA := 1
    static FILE_FLUSH_MIN_METADATA := 2
    static FILE_FLUSH_NO_SYNC := 3
}
struct OFSTRUCT {
    cBytes : UInt8
    fFixedDisk : UInt8
    nErrCode : UInt16
    Reserved1 : UInt16
    Reserved2 : UInt16
    szPathName : CHAR[128]
}
struct PFE_EXPORT_FUNC extends FunctionPointer {
    static Types := [UInt8.Ptr, Struct.Ptr, UInt32, UInt32]
}
struct PFE_IMPORT_FUNC extends FunctionPointer {
    static Types := [UInt8.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct WIN32_STREAM_ID {
    dwStreamId : WIN_STREAM_ID
    dwStreamAttributes : UInt32
    Size : Int64
    dwStreamNameSize : UInt32
    cStreamName : UInt16[1]
}
struct LPPROGRESS_ROUTINE extends FunctionPointer {
    static Types := [Int64, Int64, Int64, Int64, UInt32, LPPROGRESS_ROUTINE_CALLBACK_REASON, HANDLE, HANDLE, Struct.Ptr, COPYPROGRESSROUTINE_PROGRESS]
}
struct COPYFILE2_MESSAGE_TYPE extends Int32 {
    static COPYFILE2_CALLBACK_NONE := 0
    static COPYFILE2_CALLBACK_CHUNK_STARTED := 1
    static COPYFILE2_CALLBACK_CHUNK_FINISHED := 2
    static COPYFILE2_CALLBACK_STREAM_STARTED := 3
    static COPYFILE2_CALLBACK_STREAM_FINISHED := 4
    static COPYFILE2_CALLBACK_POLL_CONTINUE := 5
    static COPYFILE2_CALLBACK_ERROR := 6
    static COPYFILE2_CALLBACK_SPARSE_CHUNK_STARTED := 7
    static COPYFILE2_CALLBACK_SPARSE_CHUNK_FINISHED := 8
    static COPYFILE2_CALLBACK_MAX := 9
}
struct COPYFILE2_MESSAGE_ACTION extends Int32 {
    static COPYFILE2_PROGRESS_CONTINUE := 0
    static COPYFILE2_PROGRESS_CANCEL := 1
    static COPYFILE2_PROGRESS_STOP := 2
    static COPYFILE2_PROGRESS_QUIET := 3
    static COPYFILE2_PROGRESS_PAUSE := 4
}
struct COPYFILE2_COPY_PHASE extends Int32 {
    static COPYFILE2_PHASE_NONE := 0
    static COPYFILE2_PHASE_PREPARE_SOURCE := 1
    static COPYFILE2_PHASE_PREPARE_DEST := 2
    static COPYFILE2_PHASE_READ_SOURCE := 3
    static COPYFILE2_PHASE_WRITE_DESTINATION := 4
    static COPYFILE2_PHASE_SERVER_COPY := 5
    static COPYFILE2_PHASE_NAMEGRAFT_COPY := 6
    static COPYFILE2_PHASE_MAX := 7
}
struct COPYFILE2_MESSAGE {
    Type : COPYFILE2_MESSAGE_TYPE
    dwPadding : UInt32
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            ChunkStarted : this._ChunkStarted_e__Struct
            ChunkFinished : this._ChunkFinished_e__Struct
            StreamStarted : this._StreamStarted_e__Struct
            StreamFinished : this._StreamFinished_e__Struct
            PollContinue : this._PollContinue_e__Struct
            Error : this._Error_e__Struct
            SparseChunkStatus : this._SparseChunkStatus_e__Struct
        }
        struct _ChunkStarted_e__Struct {
            dwStreamNumber : UInt32
            dwReserved : UInt32
            hSourceFile : HANDLE
            hDestinationFile : HANDLE
            uliChunkNumber : Int64
            uliChunkSize : Int64
            uliStreamSize : Int64
            uliTotalFileSize : Int64
        }
        struct _ChunkFinished_e__Struct {
            dwStreamNumber : UInt32
            dwFlags : UInt32
            hSourceFile : HANDLE
            hDestinationFile : HANDLE
            uliChunkNumber : Int64
            uliChunkSize : Int64
            uliStreamSize : Int64
            uliStreamBytesTransferred : Int64
            uliTotalFileSize : Int64
            uliTotalBytesTransferred : Int64
        }
        struct _StreamStarted_e__Struct {
            dwStreamNumber : UInt32
            dwReserved : UInt32
            hSourceFile : HANDLE
            hDestinationFile : HANDLE
            uliStreamSize : Int64
            uliTotalFileSize : Int64
        }
        struct _StreamFinished_e__Struct {
            dwStreamNumber : UInt32
            dwReserved : UInt32
            hSourceFile : HANDLE
            hDestinationFile : HANDLE
            uliStreamSize : Int64
            uliStreamBytesTransferred : Int64
            uliTotalFileSize : Int64
            uliTotalBytesTransferred : Int64
        }
        struct _PollContinue_e__Struct {
            dwReserved : UInt32
        }
        struct _Error_e__Struct {
            CopyPhase : COPYFILE2_COPY_PHASE
            dwStreamNumber : UInt32
            hrFailure : HRESULT
            dwReserved : UInt32
            uliChunkNumber : Int64
            uliStreamSize : Int64
            uliStreamBytesTransferred : Int64
            uliTotalFileSize : Int64
            uliTotalBytesTransferred : Int64
        }
        struct _SparseChunkStatus_e__Struct {
            uliChunkNumber : Int64
            uliChunkSize : Int64
            uliChunkOffset : Int64
        }
    }
}
struct PCOPYFILE2_PROGRESS_ROUTINE extends FunctionPointer {
    static Types := [COPYFILE2_MESSAGE.Ptr, Struct.Ptr, COPYFILE2_MESSAGE_ACTION]
}
struct COPYFILE2_EXTENDED_PARAMETERS {
    dwSize : UInt32
    dwCopyFlags : COPYFILE_FLAGS
    pfCancel : BOOL.Ptr
    pProgressRoutine : PCOPYFILE2_PROGRESS_ROUTINE
    pvCallbackContext : Struct.Ptr
}
struct COPYFILE2_CREATE_OPLOCK_KEYS {
    ParentOplockKey : GUID
    TargetOplockKey : GUID
}
struct COPYFILE2_EXTENDED_PARAMETERS_V2 {
    dwSize : UInt32
    dwCopyFlags : COPYFILE_FLAGS
    pfCancel : BOOL.Ptr
    pProgressRoutine : PCOPYFILE2_PROGRESS_ROUTINE
    pvCallbackContext : Struct.Ptr
    dwCopyFlagsV2 : COPYFILE2_V2_FLAGS
    ioDesiredSize : UInt32
    ioDesiredRate : UInt32
    pProgressRoutineOld : LPPROGRESS_ROUTINE
    SourceOplockKeys : COPYFILE2_CREATE_OPLOCK_KEYS.Ptr
    reserved : Struct.Ptr[6]
}
struct FILE_BASIC_INFO {
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    FileAttributes : UInt32
}
struct FILE_STANDARD_INFO {
    AllocationSize : Int64
    EndOfFile : Int64
    NumberOfLinks : UInt32
    DeletePending : BOOLEAN
    Directory : BOOLEAN
}
struct FILE_NAME_INFO {
    FileNameLength : UInt32
    FileName : UInt16[1]
}
struct FILE_CASE_SENSITIVE_INFO {
    Flags : UInt32
}
struct FILE_RENAME_INFO {
    Anonymous : this._Anonymous_e__Union
    RootDirectory : HANDLE
    FileNameLength : UInt32
    FileName : UInt16[1]
    struct _Anonymous_e__Union {
        union {
            ReplaceIfExists : BOOLEAN
            Flags : UInt32
        }
    }
}
struct FILE_ALLOCATION_INFO {
    AllocationSize : Int64
}
struct FILE_END_OF_FILE_INFO {
    EndOfFile : Int64
}
struct FILE_STREAM_INFO {
    NextEntryOffset : UInt32
    StreamNameLength : UInt32
    StreamSize : Int64
    StreamAllocationSize : Int64
    StreamName : UInt16[1]
}
struct FILE_COMPRESSION_INFO {
    CompressedFileSize : Int64
    CompressionFormat : COMPRESSION_FORMAT
    CompressionUnitShift : UInt8
    ChunkShift : UInt8
    ClusterShift : UInt8
    Reserved : UInt8[3]
}
struct FILE_ATTRIBUTE_TAG_INFO {
    FileAttributes : UInt32
    ReparseTag : UInt32
}
struct FILE_DISPOSITION_INFO_EX {
    Flags : FILE_DISPOSITION_INFO_EX_FLAGS
}
struct FILE_ID_BOTH_DIR_INFO {
    NextEntryOffset : UInt32
    FileIndex : UInt32
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    EndOfFile : Int64
    AllocationSize : Int64
    FileAttributes : UInt32
    FileNameLength : UInt32
    EaSize : UInt32
    ShortNameLength : Int8
    ShortName : UInt16[12]
    FileId : Int64
    FileName : UInt16[1]
}
struct FILE_FULL_DIR_INFO {
    NextEntryOffset : UInt32
    FileIndex : UInt32
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    EndOfFile : Int64
    AllocationSize : Int64
    FileAttributes : UInt32
    FileNameLength : UInt32
    EaSize : UInt32
    FileName : UInt16[1]
}
struct PRIORITY_HINT extends Int32 {
    static IoPriorityHintVeryLow := 0
    static IoPriorityHintLow := 1
    static IoPriorityHintNormal := 2
    static MaximumIoPriorityHintType := 3
}
struct FILE_IO_PRIORITY_HINT_INFO {
    PriorityHint : PRIORITY_HINT
}
struct FILE_ALIGNMENT_INFO {
    AlignmentRequirement : UInt32
}
struct FILE_STORAGE_INFO {
    LogicalBytesPerSector : UInt32
    PhysicalBytesPerSectorForAtomicity : UInt32
    PhysicalBytesPerSectorForPerformance : UInt32
    FileSystemEffectivePhysicalBytesPerSectorForAtomicity : UInt32
    Flags : UInt32
    ByteOffsetForSectorAlignment : UInt32
    ByteOffsetForPartitionAlignment : UInt32
}
struct FILE_ID_INFO {
    VolumeSerialNumber : Int64
    FileId : FILE_ID_128
}
struct FILE_ID_EXTD_DIR_INFO {
    NextEntryOffset : UInt32
    FileIndex : UInt32
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    EndOfFile : Int64
    AllocationSize : Int64
    FileAttributes : UInt32
    FileNameLength : UInt32
    EaSize : UInt32
    ReparsePointTag : UInt32
    FileId : FILE_ID_128
    FileName : UInt16[1]
}
struct FILE_REMOTE_PROTOCOL_INFO {
    StructureVersion : UInt16
    StructureSize : UInt16
    Protocol : UInt32
    ProtocolMajorVersion : UInt16
    ProtocolMinorVersion : UInt16
    ProtocolRevision : UInt16
    Reserved : UInt16
    Flags : UInt32
    GenericReserved : this._GenericReserved_e__Struct
    ProtocolSpecific : this._ProtocolSpecific_e__Union
    struct _GenericReserved_e__Struct {
        Reserved : UInt32[8]
    }
    struct _ProtocolSpecific_e__Union {
        union {
            Smb2 : this._Smb2_e__Struct
            Reserved : UInt32[16]
        }
        struct _Smb2_e__Struct {
            Server : this._Server_e__Struct
            Share : this._Share_e__Struct
            struct _Server_e__Struct {
                Capabilities : UInt32
            }
            struct _Share_e__Struct {
                Capabilities : UInt32
                ShareFlags : UInt32
            }
        }
    }
}
struct FILE_ID_TYPE extends Int32 {
    static FileIdType := 0
    static ObjectIdType := 1
    static ExtendedFileIdType := 2
    static MaximumFileIdType := 3
}
struct FILE_ID_DESCRIPTOR {
    dwSize : UInt32
    Type : FILE_ID_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FileId : Int64
            ObjectId : GUID
            ExtendedFileId : FILE_ID_128
        }
    }
}
