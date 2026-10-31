#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, PSTR, PWSTR, SYSTEMTIME}
#Import "..\Security\Types.ahk" {PSID}

struct REPORT_EVENT_TYPE extends UInt16 {
    static EVENTLOG_SUCCESS := 0
    static EVENTLOG_AUDIT_FAILURE := 16
    static EVENTLOG_AUDIT_SUCCESS := 8
    static EVENTLOG_ERROR_TYPE := 1
    static EVENTLOG_INFORMATION_TYPE := 4
    static EVENTLOG_WARNING_TYPE := 2
}
struct READ_EVENT_LOG_READ_FLAGS extends UInt32 {
    static EVENTLOG_SEEK_READ := 2
    static EVENTLOG_SEQUENTIAL_READ := 1
    static EVENTLOG_FORWARDS_READ := 4
    static EVENTLOG_BACKWARDS_READ := 8
}
struct EVT_HANDLE {
    Value : IntPtr
}
struct EVT_VARIANT_TYPE extends Int32 {
    static EvtVarTypeNull := 0
    static EvtVarTypeString := 1
    static EvtVarTypeAnsiString := 2
    static EvtVarTypeSByte := 3
    static EvtVarTypeByte := 4
    static EvtVarTypeInt16 := 5
    static EvtVarTypeUInt16 := 6
    static EvtVarTypeInt32 := 7
    static EvtVarTypeUInt32 := 8
    static EvtVarTypeInt64 := 9
    static EvtVarTypeUInt64 := 10
    static EvtVarTypeSingle := 11
    static EvtVarTypeDouble := 12
    static EvtVarTypeBoolean := 13
    static EvtVarTypeBinary := 14
    static EvtVarTypeGuid := 15
    static EvtVarTypeSizeT := 16
    static EvtVarTypeFileTime := 17
    static EvtVarTypeSysTime := 18
    static EvtVarTypeSid := 19
    static EvtVarTypeHexInt32 := 20
    static EvtVarTypeHexInt64 := 21
    static EvtVarTypeEvtHandle := 32
    static EvtVarTypeEvtXml := 35
}
struct EVT_VARIANT {
    Anonymous : this._Anonymous_e__Union
    Count : UInt32
    Type : UInt32
    struct _Anonymous_e__Union {
        union {
            BooleanVal : BOOL
            SByteVal : Int8
            Int16Val : Int16
            Int32Val : Int32
            Int64Val : Int64
            ByteVal : UInt8
            UInt16Val : UInt16
            UInt32Val : UInt32
            UInt64Val : Int64
            SingleVal : Float32
            DoubleVal : Float64
            FileTimeVal : Int64
            SysTimeVal : SYSTEMTIME.Ptr
            GuidVal : GUID.Ptr
            StringVal : PWSTR
            AnsiStringVal : PSTR
            BinaryVal : UInt8.Ptr
            SidVal : PSID
            SizeTVal : IntPtr
            BooleanArr : BOOL.Ptr
            SByteArr : Int8.Ptr
            Int16Arr : Int16.Ptr
            Int32Arr : Int32.Ptr
            Int64Arr : Int64.Ptr
            ByteArr : UInt8.Ptr
            UInt16Arr : UInt16.Ptr
            UInt32Arr : UInt32.Ptr
            UInt64Arr : Int64.Ptr
            SingleArr : Float32.Ptr
            DoubleArr : Float64.Ptr
            FileTimeArr : FILETIME.Ptr
            SysTimeArr : SYSTEMTIME.Ptr
            GuidArr : GUID.Ptr
            StringArr : PWSTR.Ptr
            AnsiStringArr : PSTR.Ptr
            SidArr : PSID.Ptr
            SizeTArr : IntPtr.Ptr
            EvtHandleVal : EVT_HANDLE
            XmlVal : PWSTR
            XmlValArr : PWSTR.Ptr
        }
    }
}
struct EVT_LOGIN_CLASS extends Int32 {
    static EvtRpcLogin := 1
}
struct EVT_RPC_LOGIN_FLAGS extends UInt32 {
    static EvtRpcLoginAuthDefault := 0
    static EvtRpcLoginAuthNegotiate := 1
    static EvtRpcLoginAuthKerberos := 2
    static EvtRpcLoginAuthNTLM := 3
}
struct EVT_RPC_LOGIN {
    Server : PWSTR
    User : PWSTR
    Domain : PWSTR
    Password : PWSTR
    Flags : UInt32
}
struct EVT_QUERY_FLAGS extends UInt32 {
    static EvtQueryChannelPath := 1
    static EvtQueryFilePath := 2
    static EvtQueryForwardDirection := 256
    static EvtQueryReverseDirection := 512
    static EvtQueryTolerateQueryErrors := 4096
}
struct EVT_SEEK_FLAGS extends UInt32 {
    static EvtSeekRelativeToFirst := 1
    static EvtSeekRelativeToLast := 2
    static EvtSeekRelativeToCurrent := 3
    static EvtSeekRelativeToBookmark := 4
    static EvtSeekOriginMask := 7
    static EvtSeekStrict := 65536
}
struct EVT_SUBSCRIBE_FLAGS extends UInt32 {
    static EvtSubscribeToFutureEvents := 1
    static EvtSubscribeStartAtOldestRecord := 2
    static EvtSubscribeStartAfterBookmark := 3
    static EvtSubscribeOriginMask := 3
    static EvtSubscribeTolerateQueryErrors := 4096
    static EvtSubscribeStrict := 65536
}
struct EVT_SUBSCRIBE_NOTIFY_ACTION extends Int32 {
    static EvtSubscribeActionError := 0
    static EvtSubscribeActionDeliver := 1
}
struct EVT_SUBSCRIBE_CALLBACK extends FunctionPointer {
    static Types := [EVT_SUBSCRIBE_NOTIFY_ACTION, Struct.Ptr, EVT_HANDLE, UInt32]
}
struct EVT_SYSTEM_PROPERTY_ID extends Int32 {
    static EvtSystemProviderName := 0
    static EvtSystemProviderGuid := 1
    static EvtSystemEventID := 2
    static EvtSystemQualifiers := 3
    static EvtSystemLevel := 4
    static EvtSystemTask := 5
    static EvtSystemOpcode := 6
    static EvtSystemKeywords := 7
    static EvtSystemTimeCreated := 8
    static EvtSystemEventRecordId := 9
    static EvtSystemActivityID := 10
    static EvtSystemRelatedActivityID := 11
    static EvtSystemProcessID := 12
    static EvtSystemThreadID := 13
    static EvtSystemChannel := 14
    static EvtSystemComputer := 15
    static EvtSystemUserID := 16
    static EvtSystemVersion := 17
    static EvtSystemPropertyIdEND := 18
}
struct EVT_RENDER_CONTEXT_FLAGS extends UInt32 {
    static EvtRenderContextValues := 0
    static EvtRenderContextSystem := 1
    static EvtRenderContextUser := 2
}
struct EVT_RENDER_FLAGS extends UInt32 {
    static EvtRenderEventValues := 0
    static EvtRenderEventXml := 1
    static EvtRenderBookmark := 2
}
struct EVT_FORMAT_MESSAGE_FLAGS extends UInt32 {
    static EvtFormatMessageEvent := 1
    static EvtFormatMessageLevel := 2
    static EvtFormatMessageTask := 3
    static EvtFormatMessageOpcode := 4
    static EvtFormatMessageKeyword := 5
    static EvtFormatMessageChannel := 6
    static EvtFormatMessageProvider := 7
    static EvtFormatMessageId := 8
    static EvtFormatMessageXml := 9
}
struct EVT_OPEN_LOG_FLAGS extends UInt32 {
    static EvtOpenChannelPath := 1
    static EvtOpenFilePath := 2
}
struct EVT_LOG_PROPERTY_ID extends Int32 {
    static EvtLogCreationTime := 0
    static EvtLogLastAccessTime := 1
    static EvtLogLastWriteTime := 2
    static EvtLogFileSize := 3
    static EvtLogAttributes := 4
    static EvtLogNumberOfLogRecords := 5
    static EvtLogOldestRecordNumber := 6
    static EvtLogFull := 7
}
struct EVT_EXPORTLOG_FLAGS extends UInt32 {
    static EvtExportLogChannelPath := 1
    static EvtExportLogFilePath := 2
    static EvtExportLogTolerateQueryErrors := 4096
    static EvtExportLogOverwrite := 8192
}
struct EVT_CHANNEL_CONFIG_PROPERTY_ID extends Int32 {
    static EvtChannelConfigEnabled := 0
    static EvtChannelConfigIsolation := 1
    static EvtChannelConfigType := 2
    static EvtChannelConfigOwningPublisher := 3
    static EvtChannelConfigClassicEventlog := 4
    static EvtChannelConfigAccess := 5
    static EvtChannelLoggingConfigRetention := 6
    static EvtChannelLoggingConfigAutoBackup := 7
    static EvtChannelLoggingConfigMaxSize := 8
    static EvtChannelLoggingConfigLogFilePath := 9
    static EvtChannelPublishingConfigLevel := 10
    static EvtChannelPublishingConfigKeywords := 11
    static EvtChannelPublishingConfigControlGuid := 12
    static EvtChannelPublishingConfigBufferSize := 13
    static EvtChannelPublishingConfigMinBuffers := 14
    static EvtChannelPublishingConfigMaxBuffers := 15
    static EvtChannelPublishingConfigLatency := 16
    static EvtChannelPublishingConfigClockType := 17
    static EvtChannelPublishingConfigSidType := 18
    static EvtChannelPublisherList := 19
    static EvtChannelPublishingConfigFileMax := 20
    static EvtChannelConfigPropertyIdEND := 21
}
struct EVT_CHANNEL_TYPE extends Int32 {
    static EvtChannelTypeAdmin := 0
    static EvtChannelTypeOperational := 1
    static EvtChannelTypeAnalytic := 2
    static EvtChannelTypeDebug := 3
}
struct EVT_CHANNEL_ISOLATION_TYPE extends Int32 {
    static EvtChannelIsolationTypeApplication := 0
    static EvtChannelIsolationTypeSystem := 1
    static EvtChannelIsolationTypeCustom := 2
}
struct EVT_CHANNEL_CLOCK_TYPE extends Int32 {
    static EvtChannelClockTypeSystemTime := 0
    static EvtChannelClockTypeQPC := 1
}
struct EVT_CHANNEL_SID_TYPE extends Int32 {
    static EvtChannelSidTypeNone := 0
    static EvtChannelSidTypePublishing := 1
}
struct EVT_CHANNEL_REFERENCE_FLAGS extends UInt32 {
    static EvtChannelReferenceImported := 1
}
struct EVT_PUBLISHER_METADATA_PROPERTY_ID extends Int32 {
    static EvtPublisherMetadataPublisherGuid := 0
    static EvtPublisherMetadataResourceFilePath := 1
    static EvtPublisherMetadataParameterFilePath := 2
    static EvtPublisherMetadataMessageFilePath := 3
    static EvtPublisherMetadataHelpLink := 4
    static EvtPublisherMetadataPublisherMessageID := 5
    static EvtPublisherMetadataChannelReferences := 6
    static EvtPublisherMetadataChannelReferencePath := 7
    static EvtPublisherMetadataChannelReferenceIndex := 8
    static EvtPublisherMetadataChannelReferenceID := 9
    static EvtPublisherMetadataChannelReferenceFlags := 10
    static EvtPublisherMetadataChannelReferenceMessageID := 11
    static EvtPublisherMetadataLevels := 12
    static EvtPublisherMetadataLevelName := 13
    static EvtPublisherMetadataLevelValue := 14
    static EvtPublisherMetadataLevelMessageID := 15
    static EvtPublisherMetadataTasks := 16
    static EvtPublisherMetadataTaskName := 17
    static EvtPublisherMetadataTaskEventGuid := 18
    static EvtPublisherMetadataTaskValue := 19
    static EvtPublisherMetadataTaskMessageID := 20
    static EvtPublisherMetadataOpcodes := 21
    static EvtPublisherMetadataOpcodeName := 22
    static EvtPublisherMetadataOpcodeValue := 23
    static EvtPublisherMetadataOpcodeMessageID := 24
    static EvtPublisherMetadataKeywords := 25
    static EvtPublisherMetadataKeywordName := 26
    static EvtPublisherMetadataKeywordValue := 27
    static EvtPublisherMetadataKeywordMessageID := 28
    static EvtPublisherMetadataPropertyIdEND := 29
}
struct EVT_EVENT_METADATA_PROPERTY_ID extends Int32 {
    static EventMetadataEventID := 0
    static EventMetadataEventVersion := 1
    static EventMetadataEventChannel := 2
    static EventMetadataEventLevel := 3
    static EventMetadataEventOpcode := 4
    static EventMetadataEventTask := 5
    static EventMetadataEventKeyword := 6
    static EventMetadataEventMessageID := 7
    static EventMetadataEventTemplate := 8
    static EvtEventMetadataPropertyIdEND := 9
}
struct EVT_QUERY_PROPERTY_ID extends Int32 {
    static EvtQueryNames := 0
    static EvtQueryStatuses := 1
    static EvtQueryPropertyIdEND := 2
}
struct EVT_EVENT_PROPERTY_ID extends Int32 {
    static EvtEventQueryIDs := 0
    static EvtEventPath := 1
    static EvtEventPropertyIdEND := 2
}
struct EVENTLOGRECORD {
    Length : UInt32
    Reserved : UInt32
    RecordNumber : UInt32
    TimeGenerated : UInt32
    TimeWritten : UInt32
    EventID : UInt32
    EventType : REPORT_EVENT_TYPE
    NumStrings : UInt16
    EventCategory : UInt16
    ReservedFlags : UInt16
    ClosingRecordNumber : UInt32
    StringOffset : UInt32
    UserSidLength : UInt32
    UserSidOffset : UInt32
    DataLength : UInt32
    DataOffset : UInt32
}
struct EVENTSFORLOGFILE {
    ulSize : UInt32
    szLogicalLogFile : UInt16[256]
    ulNumRecords : UInt32
    pEventLogRecords : EVENTLOGRECORD[1]
}
struct EVENTLOG_FULL_INFORMATION {
    dwFull : UInt32
}
