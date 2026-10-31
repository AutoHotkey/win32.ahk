#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, FILETIME, HRESULT, HWND, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Ole\Types.ahk" {IFontDisp}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct PERF_DETAIL extends UInt32 {
    static PERF_DETAIL_NOVICE := 100
    static PERF_DETAIL_ADVANCED := 200
    static PERF_DETAIL_EXPERT := 300
    static PERF_DETAIL_WIZARD := 400
}
struct REAL_TIME_DATA_SOURCE_ID_FLAGS extends UInt32 {
    static DATA_SOURCE_REGISTRY := 1
    static DATA_SOURCE_WBEM := 4
}
struct PDH_PATH_FLAGS extends UInt32 {
    static PDH_PATH_WBEM_RESULT := 1
    static PDH_PATH_WBEM_INPUT := 2
    static PDH_PATH_WBEM_NONE := 0
}
struct PDH_FMT extends UInt32 {
    static PDH_FMT_DOUBLE := 512
    static PDH_FMT_LARGE := 1024
    static PDH_FMT_LONG := 256
}
struct PDH_LOG_TYPE extends UInt32 {
    static PDH_LOG_TYPE_UNDEFINED := 0
    static PDH_LOG_TYPE_CSV := 1
    static PDH_LOG_TYPE_SQL := 7
    static PDH_LOG_TYPE_TSV := 2
    static PDH_LOG_TYPE_BINARY := 8
    static PDH_LOG_TYPE_PERFMON := 6
}
struct PDH_LOG extends UInt32 {
    static PDH_LOG_READ_ACCESS := 65536
    static PDH_LOG_WRITE_ACCESS := 131072
    static PDH_LOG_UPDATE_ACCESS := 262144
}
struct PDH_SELECT_DATA_SOURCE_FLAGS extends UInt32 {
    static PDH_FLAGS_FILE_BROWSER_ONLY := 1
    static PDH_FLAGS_NONE := 0
}
struct PDH_DLL_VERSION extends UInt32 {
    static PDH_CVERSION_WIN50 := 1280
    static PDH_VERSION := 1283
}
struct PERF_COUNTER_AGGREGATE_FUNC extends UInt32 {
    static PERF_AGGREGATE_UNDEFINED := 0
    static PERF_AGGREGATE_TOTAL := 1
    static PERF_AGGREGATE_AVG := 2
    static PERF_AGGREGATE_MIN := 3
    static PERF_AGGREGATE_MAX := 4
}
struct PDH_HLOG {
    Value : Struct.Ptr
}
struct PDH_HQUERY {
    Value : Struct.Ptr
}
struct PDH_HCOUNTER {
    Value : Struct.Ptr
}
struct DataCollectorType extends Int32 {
    static plaPerformanceCounter := 0
    static plaTrace := 1
    static plaConfiguration := 2
    static plaAlert := 3
    static plaApiTrace := 4
}
struct FileFormat extends Int32 {
    static plaCommaSeparated := 0
    static plaTabSeparated := 1
    static plaSql := 2
    static plaBinary := 3
}
struct AutoPathFormat extends Int32 {
    static plaNone := 0
    static plaPattern := 1
    static plaComputer := 2
    static plaMonthDayHour := 256
    static plaSerialNumber := 512
    static plaYearDayOfYear := 1024
    static plaYearMonth := 2048
    static plaYearMonthDay := 4096
    static plaYearMonthDayHour := 8192
    static plaMonthDayHourMinute := 16384
}
struct DataCollectorSetStatus extends Int32 {
    static plaStopped := 0
    static plaRunning := 1
    static plaCompiling := 2
    static plaPending := 3
    static plaUndefined := 4
}
struct ClockType extends Int32 {
    static plaTimeStamp := 0
    static plaPerformance := 1
    static plaSystem := 2
    static plaCycle := 3
}
struct StreamMode extends Int32 {
    static plaFile := 1
    static plaRealTime := 2
    static plaBoth := 3
    static plaBuffering := 4
}
struct CommitMode extends Int32 {
    static plaCreateNew := 1
    static plaModify := 2
    static plaCreateOrModify := 3
    static plaUpdateRunningInstance := 16
    static plaFlushTrace := 32
    static plaValidateOnly := 4096
}
struct ValueMapType extends Int32 {
    static plaIndex := 1
    static plaFlag := 2
    static plaFlagArray := 3
    static plaValidation := 4
}
struct WeekDays extends Int32 {
    static plaRunOnce := 0
    static plaSunday := 1
    static plaMonday := 2
    static plaTuesday := 4
    static plaWednesday := 8
    static plaThursday := 16
    static plaFriday := 32
    static plaSaturday := 64
    static plaEveryday := 127
}
struct ResourcePolicy extends Int32 {
    static plaDeleteLargest := 0
    static plaDeleteOldest := 1
}
struct DataManagerSteps extends Int32 {
    static plaCreateReport := 1
    static plaRunRules := 2
    static plaCreateHtml := 4
    static plaFolderActions := 8
    static plaResourceFreeing := 16
}
struct FolderActionSteps extends Int32 {
    static plaCreateCab := 1
    static plaDeleteData := 2
    static plaSendCab := 4
    static plaDeleteCab := 8
    static plaDeleteReport := 16
}
struct PLA_CABEXTRACT_CALLBACK extends FunctionPointer {
    static Types := [PWSTR, Struct.Ptr, "Void"]
}
struct IDataCollectorSet extends IDispatch {
    static IID := "{03837520-098B-11D8-9414-505054503030}"
    get_DataCollectors(collectors)
      => ComCall(7, this.p, IDataCollectorCollection.Ptr, collectors)
    get_Duration(seconds)
      => ComCall(8, this.p, UInt32.Ptr, seconds)
    put_Duration(seconds)
      => ComCall(9, this.p, UInt32, seconds)
    get_Description(description)
      => ComCall(10, this.p, BSTR.Ptr, description)
    put_Description(description)
      => ComCall(11, this.p, BSTR, description)
    get_DescriptionUnresolved(Descr)
      => ComCall(12, this.p, BSTR.Ptr, Descr)
    get_DisplayName(DisplayName)
      => ComCall(13, this.p, BSTR.Ptr, DisplayName)
    put_DisplayName(DisplayName)
      => ComCall(14, this.p, BSTR, DisplayName)
    get_DisplayNameUnresolved(name)
      => ComCall(15, this.p, BSTR.Ptr, name)
    get_Keywords(keywords)
      => ComCall(16, this.p, SAFEARRAY.Ptr.Ptr, keywords)
    put_Keywords(keywords)
      => ComCall(17, this.p, SAFEARRAY.Ptr, keywords)
    get_LatestOutputLocation(path)
      => ComCall(18, this.p, BSTR.Ptr, path)
    put_LatestOutputLocation(path)
      => ComCall(19, this.p, BSTR, path)
    get_Name(name)
      => ComCall(20, this.p, BSTR.Ptr, name)
    get_OutputLocation(path)
      => ComCall(21, this.p, BSTR.Ptr, path)
    get_RootPath(folder)
      => ComCall(22, this.p, BSTR.Ptr, folder)
    put_RootPath(folder)
      => ComCall(23, this.p, BSTR, folder)
    get_Segment(segment)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, segment)
    put_Segment(segment)
      => ComCall(25, this.p, VARIANT_BOOL, segment)
    get_SegmentMaxDuration(seconds)
      => ComCall(26, this.p, UInt32.Ptr, seconds)
    put_SegmentMaxDuration(seconds)
      => ComCall(27, this.p, UInt32, seconds)
    get_SegmentMaxSize(size)
      => ComCall(28, this.p, UInt32.Ptr, size)
    put_SegmentMaxSize(size)
      => ComCall(29, this.p, UInt32, size)
    get_SerialNumber(index)
      => ComCall(30, this.p, UInt32.Ptr, index)
    put_SerialNumber(index)
      => ComCall(31, this.p, UInt32, index)
    get_Server(server)
      => ComCall(32, this.p, BSTR.Ptr, server)
    get_Status(status)
      => ComCall(33, this.p, DataCollectorSetStatus.Ptr, status)
    get_Subdirectory(folder)
      => ComCall(34, this.p, BSTR.Ptr, folder)
    put_Subdirectory(folder)
      => ComCall(35, this.p, BSTR, folder)
    get_SubdirectoryFormat(format)
      => ComCall(36, this.p, AutoPathFormat.Ptr, format)
    put_SubdirectoryFormat(format)
      => ComCall(37, this.p, AutoPathFormat, format)
    get_SubdirectoryFormatPattern(pattern)
      => ComCall(38, this.p, BSTR.Ptr, pattern)
    put_SubdirectoryFormatPattern(pattern)
      => ComCall(39, this.p, BSTR, pattern)
    get_Task(task)
      => ComCall(40, this.p, BSTR.Ptr, task)
    put_Task(task)
      => ComCall(41, this.p, BSTR, task)
    get_TaskRunAsSelf(RunAsSelf)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, RunAsSelf)
    put_TaskRunAsSelf(RunAsSelf)
      => ComCall(43, this.p, VARIANT_BOOL, RunAsSelf)
    get_TaskArguments(task)
      => ComCall(44, this.p, BSTR.Ptr, task)
    put_TaskArguments(task)
      => ComCall(45, this.p, BSTR, task)
    get_TaskUserTextArguments(UserText)
      => ComCall(46, this.p, BSTR.Ptr, UserText)
    put_TaskUserTextArguments(UserText)
      => ComCall(47, this.p, BSTR, UserText)
    get_Schedules(ppSchedules)
      => ComCall(48, this.p, IScheduleCollection.Ptr, ppSchedules)
    get_SchedulesEnabled(enabled)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, enabled)
    put_SchedulesEnabled(enabled)
      => ComCall(50, this.p, VARIANT_BOOL, enabled)
    get_UserAccount(user)
      => ComCall(51, this.p, BSTR.Ptr, user)
    get_Xml(xml)
      => ComCall(52, this.p, BSTR.Ptr, xml)
    get_Security(pbstrSecurity)
      => ComCall(53, this.p, BSTR.Ptr, pbstrSecurity)
    put_Security(bstrSecurity)
      => ComCall(54, this.p, BSTR, bstrSecurity)
    get_StopOnCompletion(Stop)
      => ComCall(55, this.p, VARIANT_BOOL.Ptr, Stop)
    put_StopOnCompletion(Stop)
      => ComCall(56, this.p, VARIANT_BOOL, Stop)
    get_DataManager(DataManager)
      => ComCall(57, this.p, IDataManager.Ptr, DataManager)
    SetCredentials(user, password)
      => ComCall(58, this.p, BSTR, user, BSTR, password)
    Query(name, server?)
      => ComCall(59, this.p, BSTR, name, BSTR, server?)
    Commit(name, server?, mode, validation)
      => ComCall(60, this.p, BSTR, name, BSTR, server?, CommitMode, mode, IValueMap.Ptr, validation)
    Delete()
      => ComCall(61, this.p)
    Start(Synchronous)
      => ComCall(62, this.p, VARIANT_BOOL, Synchronous)
    Stop(Synchronous)
      => ComCall(63, this.p, VARIANT_BOOL, Synchronous)
    SetXml(xml, validation)
      => ComCall(64, this.p, BSTR, xml, IValueMap.Ptr, validation)
    SetValue(key, value)
      => ComCall(65, this.p, BSTR, key, BSTR, value)
    GetValue(key, value)
      => ComCall(66, this.p, BSTR, key, BSTR.Ptr, value)
}
struct IDataManager extends IDispatch {
    static IID := "{03837541-098B-11D8-9414-505054503030}"
    get_Enabled(pfEnabled)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_Enabled(fEnabled)
      => ComCall(8, this.p, VARIANT_BOOL, fEnabled)
    get_CheckBeforeRunning(pfCheck)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pfCheck)
    put_CheckBeforeRunning(fCheck)
      => ComCall(10, this.p, VARIANT_BOOL, fCheck)
    get_MinFreeDisk(MinFreeDisk)
      => ComCall(11, this.p, UInt32.Ptr, MinFreeDisk)
    put_MinFreeDisk(MinFreeDisk)
      => ComCall(12, this.p, UInt32, MinFreeDisk)
    get_MaxSize(pulMaxSize)
      => ComCall(13, this.p, UInt32.Ptr, pulMaxSize)
    put_MaxSize(ulMaxSize)
      => ComCall(14, this.p, UInt32, ulMaxSize)
    get_MaxFolderCount(pulMaxFolderCount)
      => ComCall(15, this.p, UInt32.Ptr, pulMaxFolderCount)
    put_MaxFolderCount(ulMaxFolderCount)
      => ComCall(16, this.p, UInt32, ulMaxFolderCount)
    get_ResourcePolicy(pPolicy)
      => ComCall(17, this.p, ResourcePolicy.Ptr, pPolicy)
    put_ResourcePolicy(Policy)
      => ComCall(18, this.p, ResourcePolicy, Policy)
    get_FolderActions(Actions)
      => ComCall(19, this.p, IFolderActionCollection.Ptr, Actions)
    get_ReportSchema(ReportSchema)
      => ComCall(20, this.p, BSTR.Ptr, ReportSchema)
    put_ReportSchema(ReportSchema)
      => ComCall(21, this.p, BSTR, ReportSchema)
    get_ReportFileName(pbstrFilename)
      => ComCall(22, this.p, BSTR.Ptr, pbstrFilename)
    put_ReportFileName(pbstrFilename)
      => ComCall(23, this.p, BSTR, pbstrFilename)
    get_RuleTargetFileName(Filename)
      => ComCall(24, this.p, BSTR.Ptr, Filename)
    put_RuleTargetFileName(Filename)
      => ComCall(25, this.p, BSTR, Filename)
    get_EventsFileName(pbstrFilename)
      => ComCall(26, this.p, BSTR.Ptr, pbstrFilename)
    put_EventsFileName(pbstrFilename)
      => ComCall(27, this.p, BSTR, pbstrFilename)
    get_Rules(pbstrXml)
      => ComCall(28, this.p, BSTR.Ptr, pbstrXml)
    put_Rules(bstrXml)
      => ComCall(29, this.p, BSTR, bstrXml)
    Run(Steps, bstrFolder, Errors)
      => ComCall(30, this.p, DataManagerSteps, Steps, BSTR, bstrFolder, IValueMap.Ptr, Errors)
    Extract(CabFilename, DestinationPath)
      => ComCall(31, this.p, BSTR, CabFilename, BSTR, DestinationPath)
}
struct IFolderAction extends IDispatch {
    static IID := "{03837543-098B-11D8-9414-505054503030}"
    get_Age(pulAge)
      => ComCall(7, this.p, UInt32.Ptr, pulAge)
    put_Age(ulAge)
      => ComCall(8, this.p, UInt32, ulAge)
    get_Size(pulAge)
      => ComCall(9, this.p, UInt32.Ptr, pulAge)
    put_Size(ulAge)
      => ComCall(10, this.p, UInt32, ulAge)
    get_Actions(Steps)
      => ComCall(11, this.p, FolderActionSteps.Ptr, Steps)
    put_Actions(Steps)
      => ComCall(12, this.p, FolderActionSteps, Steps)
    get_SendCabTo(pbstrDestination)
      => ComCall(13, this.p, BSTR.Ptr, pbstrDestination)
    put_SendCabTo(bstrDestination)
      => ComCall(14, this.p, BSTR, bstrDestination)
}
struct IFolderActionCollection extends IDispatch {
    static IID := "{03837544-098B-11D8-9414-505054503030}"
    get_Count(Count)
      => ComCall(7, this.p, UInt32.Ptr, Count)
    get_Item(Index, Action)
      => ComCall(8, this.p, VARIANT, Index, IFolderAction.Ptr, Action)
    get__NewEnum(Enum)
      => ComCall(9, this.p, IUnknown.Ptr, Enum)
    Add(Action?)
      => ComCall(10, this.p, IFolderAction, Action?)
    Remove(Index)
      => ComCall(11, this.p, VARIANT, Index)
    Clear()
      => ComCall(12, this.p)
    AddRange(Actions?)
      => ComCall(13, this.p, IFolderActionCollection, Actions?)
    CreateFolderAction(FolderAction)
      => ComCall(14, this.p, IFolderAction.Ptr, FolderAction)
}
struct IDataCollector extends IDispatch {
    static IID := "{038374FF-098B-11D8-9414-505054503030}"
    get_DataCollectorSet(group)
      => ComCall(7, this.p, IDataCollectorSet.Ptr, group)
    put_DataCollectorSet(group?)
      => ComCall(8, this.p, IDataCollectorSet, group?)
    get_DataCollectorType(type)
      => ComCall(9, this.p, DataCollectorType.Ptr, type)
    get_FileName(name)
      => ComCall(10, this.p, BSTR.Ptr, name)
    put_FileName(name)
      => ComCall(11, this.p, BSTR, name)
    get_FileNameFormat(format)
      => ComCall(12, this.p, AutoPathFormat.Ptr, format)
    put_FileNameFormat(format)
      => ComCall(13, this.p, AutoPathFormat, format)
    get_FileNameFormatPattern(pattern)
      => ComCall(14, this.p, BSTR.Ptr, pattern)
    put_FileNameFormatPattern(pattern)
      => ComCall(15, this.p, BSTR, pattern)
    get_LatestOutputLocation(path)
      => ComCall(16, this.p, BSTR.Ptr, path)
    put_LatestOutputLocation(path)
      => ComCall(17, this.p, BSTR, path)
    get_LogAppend(append)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, append)
    put_LogAppend(append)
      => ComCall(19, this.p, VARIANT_BOOL, append)
    get_LogCircular(circular)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, circular)
    put_LogCircular(circular)
      => ComCall(21, this.p, VARIANT_BOOL, circular)
    get_LogOverwrite(overwrite)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, overwrite)
    put_LogOverwrite(overwrite)
      => ComCall(23, this.p, VARIANT_BOOL, overwrite)
    get_Name(name)
      => ComCall(24, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(25, this.p, BSTR, name)
    get_OutputLocation(path)
      => ComCall(26, this.p, BSTR.Ptr, path)
    get_Index(index)
      => ComCall(27, this.p, Int32.Ptr, index)
    put_Index(index)
      => ComCall(28, this.p, Int32, index)
    get_Xml(Xml)
      => ComCall(29, this.p, BSTR.Ptr, Xml)
    SetXml(Xml, Validation)
      => ComCall(30, this.p, BSTR, Xml, IValueMap.Ptr, Validation)
    CreateOutputLocation(Latest, Location)
      => ComCall(31, this.p, VARIANT_BOOL, Latest, BSTR.Ptr, Location)
}
struct IPerformanceCounterDataCollector extends IDataCollector {
    static IID := "{03837506-098B-11D8-9414-505054503030}"
    get_DataSourceName(dsn)
      => ComCall(32, this.p, BSTR.Ptr, dsn)
    put_DataSourceName(dsn)
      => ComCall(33, this.p, BSTR, dsn)
    get_PerformanceCounters(counters)
      => ComCall(34, this.p, SAFEARRAY.Ptr.Ptr, counters)
    put_PerformanceCounters(counters)
      => ComCall(35, this.p, SAFEARRAY.Ptr, counters)
    get_LogFileFormat(format)
      => ComCall(36, this.p, FileFormat.Ptr, format)
    put_LogFileFormat(format)
      => ComCall(37, this.p, FileFormat, format)
    get_SampleInterval(interval)
      => ComCall(38, this.p, UInt32.Ptr, interval)
    put_SampleInterval(interval)
      => ComCall(39, this.p, UInt32, interval)
    get_SegmentMaxRecords(records)
      => ComCall(40, this.p, UInt32.Ptr, records)
    put_SegmentMaxRecords(records)
      => ComCall(41, this.p, UInt32, records)
}
struct ITraceDataCollector extends IDataCollector {
    static IID := "{0383750B-098B-11D8-9414-505054503030}"
    get_BufferSize(size)
      => ComCall(32, this.p, UInt32.Ptr, size)
    put_BufferSize(size)
      => ComCall(33, this.p, UInt32, size)
    get_BuffersLost(buffers)
      => ComCall(34, this.p, UInt32.Ptr, buffers)
    put_BuffersLost(buffers)
      => ComCall(35, this.p, UInt32, buffers)
    get_BuffersWritten(buffers)
      => ComCall(36, this.p, UInt32.Ptr, buffers)
    put_BuffersWritten(buffers)
      => ComCall(37, this.p, UInt32, buffers)
    get_ClockType(clock)
      => ComCall(38, this.p, ClockType.Ptr, clock)
    put_ClockType(clock)
      => ComCall(39, this.p, ClockType, clock)
    get_EventsLost(events)
      => ComCall(40, this.p, UInt32.Ptr, events)
    put_EventsLost(events)
      => ComCall(41, this.p, UInt32, events)
    get_ExtendedModes(mode)
      => ComCall(42, this.p, UInt32.Ptr, mode)
    put_ExtendedModes(mode)
      => ComCall(43, this.p, UInt32, mode)
    get_FlushTimer(seconds)
      => ComCall(44, this.p, UInt32.Ptr, seconds)
    put_FlushTimer(seconds)
      => ComCall(45, this.p, UInt32, seconds)
    get_FreeBuffers(buffers)
      => ComCall(46, this.p, UInt32.Ptr, buffers)
    put_FreeBuffers(buffers)
      => ComCall(47, this.p, UInt32, buffers)
    get_Guid(guid)
      => ComCall(48, this.p, GUID.Ptr, guid)
    put_Guid(guid1)
      => ComCall(49, this.p, GUID, guid1)
    get_IsKernelTrace(kernel)
      => ComCall(50, this.p, VARIANT_BOOL.Ptr, kernel)
    get_MaximumBuffers(buffers)
      => ComCall(51, this.p, UInt32.Ptr, buffers)
    put_MaximumBuffers(buffers)
      => ComCall(52, this.p, UInt32, buffers)
    get_MinimumBuffers(buffers)
      => ComCall(53, this.p, UInt32.Ptr, buffers)
    put_MinimumBuffers(buffers)
      => ComCall(54, this.p, UInt32, buffers)
    get_NumberOfBuffers(buffers)
      => ComCall(55, this.p, UInt32.Ptr, buffers)
    put_NumberOfBuffers(buffers)
      => ComCall(56, this.p, UInt32, buffers)
    get_PreallocateFile(allocate)
      => ComCall(57, this.p, VARIANT_BOOL.Ptr, allocate)
    put_PreallocateFile(allocate)
      => ComCall(58, this.p, VARIANT_BOOL, allocate)
    get_ProcessMode(process)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, process)
    put_ProcessMode(process)
      => ComCall(60, this.p, VARIANT_BOOL, process)
    get_RealTimeBuffersLost(buffers)
      => ComCall(61, this.p, UInt32.Ptr, buffers)
    put_RealTimeBuffersLost(buffers)
      => ComCall(62, this.p, UInt32, buffers)
    get_SessionId(id)
      => ComCall(63, this.p, Int64.Ptr, id)
    put_SessionId(id)
      => ComCall(64, this.p, Int64, id)
    get_SessionName(name)
      => ComCall(65, this.p, BSTR.Ptr, name)
    put_SessionName(name)
      => ComCall(66, this.p, BSTR, name)
    get_SessionThreadId(tid)
      => ComCall(67, this.p, UInt32.Ptr, tid)
    put_SessionThreadId(tid)
      => ComCall(68, this.p, UInt32, tid)
    get_StreamMode(mode)
      => ComCall(69, this.p, StreamMode.Ptr, mode)
    put_StreamMode(mode)
      => ComCall(70, this.p, StreamMode, mode)
    get_TraceDataProviders(providers)
      => ComCall(71, this.p, ITraceDataProviderCollection.Ptr, providers)
}
struct IConfigurationDataCollector extends IDataCollector {
    static IID := "{03837514-098B-11D8-9414-505054503030}"
    get_FileMaxCount(count)
      => ComCall(32, this.p, UInt32.Ptr, count)
    put_FileMaxCount(count)
      => ComCall(33, this.p, UInt32, count)
    get_FileMaxRecursiveDepth(depth)
      => ComCall(34, this.p, UInt32.Ptr, depth)
    put_FileMaxRecursiveDepth(depth)
      => ComCall(35, this.p, UInt32, depth)
    get_FileMaxTotalSize(size)
      => ComCall(36, this.p, UInt32.Ptr, size)
    put_FileMaxTotalSize(size)
      => ComCall(37, this.p, UInt32, size)
    get_Files(Files)
      => ComCall(38, this.p, SAFEARRAY.Ptr.Ptr, Files)
    put_Files(Files)
      => ComCall(39, this.p, SAFEARRAY.Ptr, Files)
    get_ManagementQueries(Queries)
      => ComCall(40, this.p, SAFEARRAY.Ptr.Ptr, Queries)
    put_ManagementQueries(Queries)
      => ComCall(41, this.p, SAFEARRAY.Ptr, Queries)
    get_QueryNetworkAdapters(network)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, network)
    put_QueryNetworkAdapters(network)
      => ComCall(43, this.p, VARIANT_BOOL, network)
    get_RegistryKeys(query)
      => ComCall(44, this.p, SAFEARRAY.Ptr.Ptr, query)
    put_RegistryKeys(query)
      => ComCall(45, this.p, SAFEARRAY.Ptr, query)
    get_RegistryMaxRecursiveDepth(depth)
      => ComCall(46, this.p, UInt32.Ptr, depth)
    put_RegistryMaxRecursiveDepth(depth)
      => ComCall(47, this.p, UInt32, depth)
    get_SystemStateFile(FileName)
      => ComCall(48, this.p, BSTR.Ptr, FileName)
    put_SystemStateFile(FileName)
      => ComCall(49, this.p, BSTR, FileName)
}
struct IAlertDataCollector extends IDataCollector {
    static IID := "{03837516-098B-11D8-9414-505054503030}"
    get_AlertThresholds(alerts)
      => ComCall(32, this.p, SAFEARRAY.Ptr.Ptr, alerts)
    put_AlertThresholds(alerts)
      => ComCall(33, this.p, SAFEARRAY.Ptr, alerts)
    get_EventLog(log)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, log)
    put_EventLog(log)
      => ComCall(35, this.p, VARIANT_BOOL, log)
    get_SampleInterval(interval)
      => ComCall(36, this.p, UInt32.Ptr, interval)
    put_SampleInterval(interval)
      => ComCall(37, this.p, UInt32, interval)
    get_Task(task)
      => ComCall(38, this.p, BSTR.Ptr, task)
    put_Task(task)
      => ComCall(39, this.p, BSTR, task)
    get_TaskRunAsSelf(RunAsSelf)
      => ComCall(40, this.p, VARIANT_BOOL.Ptr, RunAsSelf)
    put_TaskRunAsSelf(RunAsSelf)
      => ComCall(41, this.p, VARIANT_BOOL, RunAsSelf)
    get_TaskArguments(task)
      => ComCall(42, this.p, BSTR.Ptr, task)
    put_TaskArguments(task)
      => ComCall(43, this.p, BSTR, task)
    get_TaskUserTextArguments(task)
      => ComCall(44, this.p, BSTR.Ptr, task)
    put_TaskUserTextArguments(task)
      => ComCall(45, this.p, BSTR, task)
    get_TriggerDataCollectorSet(name)
      => ComCall(46, this.p, BSTR.Ptr, name)
    put_TriggerDataCollectorSet(name)
      => ComCall(47, this.p, BSTR, name)
}
struct IApiTracingDataCollector extends IDataCollector {
    static IID := "{0383751A-098B-11D8-9414-505054503030}"
    get_LogApiNamesOnly(logapinames)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, logapinames)
    put_LogApiNamesOnly(logapinames)
      => ComCall(33, this.p, VARIANT_BOOL, logapinames)
    get_LogApisRecursively(logrecursively)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, logrecursively)
    put_LogApisRecursively(logrecursively)
      => ComCall(35, this.p, VARIANT_BOOL, logrecursively)
    get_ExePath(exepath)
      => ComCall(36, this.p, BSTR.Ptr, exepath)
    put_ExePath(exepath)
      => ComCall(37, this.p, BSTR, exepath)
    get_LogFilePath(logfilepath)
      => ComCall(38, this.p, BSTR.Ptr, logfilepath)
    put_LogFilePath(logfilepath)
      => ComCall(39, this.p, BSTR, logfilepath)
    get_IncludeModules(includemodules)
      => ComCall(40, this.p, SAFEARRAY.Ptr.Ptr, includemodules)
    put_IncludeModules(includemodules)
      => ComCall(41, this.p, SAFEARRAY.Ptr, includemodules)
    get_IncludeApis(includeapis)
      => ComCall(42, this.p, SAFEARRAY.Ptr.Ptr, includeapis)
    put_IncludeApis(includeapis)
      => ComCall(43, this.p, SAFEARRAY.Ptr, includeapis)
    get_ExcludeApis(excludeapis)
      => ComCall(44, this.p, SAFEARRAY.Ptr.Ptr, excludeapis)
    put_ExcludeApis(excludeapis)
      => ComCall(45, this.p, SAFEARRAY.Ptr, excludeapis)
}
struct IDataCollectorCollection extends IDispatch {
    static IID := "{03837502-098B-11D8-9414-505054503030}"
    get_Count(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_Item(index, collector)
      => ComCall(8, this.p, VARIANT, index, IDataCollector.Ptr, collector)
    get__NewEnum(retVal)
      => ComCall(9, this.p, IUnknown.Ptr, retVal)
    Add(collector?)
      => ComCall(10, this.p, IDataCollector, collector?)
    Remove(collector)
      => ComCall(11, this.p, VARIANT, collector)
    Clear()
      => ComCall(12, this.p)
    AddRange(collectors?)
      => ComCall(13, this.p, IDataCollectorCollection, collectors?)
    CreateDataCollectorFromXml(bstrXml, pValidation, pCollector)
      => ComCall(14, this.p, BSTR, bstrXml, IValueMap.Ptr, pValidation, IDataCollector.Ptr, pCollector)
    CreateDataCollector(Type, Collector)
      => ComCall(15, this.p, DataCollectorType, Type, IDataCollector.Ptr, Collector)
}
struct IDataCollectorSetCollection extends IDispatch {
    static IID := "{03837524-098B-11D8-9414-505054503030}"
    get_Count(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_Item(index, set)
      => ComCall(8, this.p, VARIANT, index, IDataCollectorSet.Ptr, set)
    get__NewEnum(retVal)
      => ComCall(9, this.p, IUnknown.Ptr, retVal)
    Add(set?)
      => ComCall(10, this.p, IDataCollectorSet, set?)
    Remove(set)
      => ComCall(11, this.p, VARIANT, set)
    Clear()
      => ComCall(12, this.p)
    AddRange(sets?)
      => ComCall(13, this.p, IDataCollectorSetCollection, sets?)
    GetDataCollectorSets(server?, filter?)
      => ComCall(14, this.p, BSTR, server?, BSTR, filter?)
}
struct ITraceDataProvider extends IDispatch {
    static IID := "{03837512-098B-11D8-9414-505054503030}"
    get_DisplayName(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_DisplayName(name)
      => ComCall(8, this.p, BSTR, name)
    get_Guid(guid)
      => ComCall(9, this.p, GUID.Ptr, guid)
    put_Guid(guid1)
      => ComCall(10, this.p, GUID, guid1)
    get_Level(ppLevel)
      => ComCall(11, this.p, IValueMap.Ptr, ppLevel)
    get_KeywordsAny(ppKeywords)
      => ComCall(12, this.p, IValueMap.Ptr, ppKeywords)
    get_KeywordsAll(ppKeywords)
      => ComCall(13, this.p, IValueMap.Ptr, ppKeywords)
    get_Properties(ppProperties)
      => ComCall(14, this.p, IValueMap.Ptr, ppProperties)
    get_FilterEnabled(FilterEnabled)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, FilterEnabled)
    put_FilterEnabled(FilterEnabled)
      => ComCall(16, this.p, VARIANT_BOOL, FilterEnabled)
    get_FilterType(pulType)
      => ComCall(17, this.p, UInt32.Ptr, pulType)
    put_FilterType(ulType)
      => ComCall(18, this.p, UInt32, ulType)
    get_FilterData(ppData)
      => ComCall(19, this.p, SAFEARRAY.Ptr.Ptr, ppData)
    put_FilterData(pData)
      => ComCall(20, this.p, SAFEARRAY.Ptr, pData)
    Query(bstrName, bstrServer?)
      => ComCall(21, this.p, BSTR, bstrName, BSTR, bstrServer?)
    Resolve(pFrom?)
      => ComCall(22, this.p, IDispatch, pFrom?)
    SetSecurity(Sddl)
      => ComCall(23, this.p, BSTR, Sddl)
    GetSecurity(SecurityInfo, Sddl)
      => ComCall(24, this.p, UInt32, SecurityInfo, BSTR.Ptr, Sddl)
    GetRegisteredProcesses(Processes)
      => ComCall(25, this.p, IValueMap.Ptr, Processes)
}
struct ITraceDataProviderCollection extends IDispatch {
    static IID := "{03837510-098B-11D8-9414-505054503030}"
    get_Count(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_Item(index, ppProvider)
      => ComCall(8, this.p, VARIANT, index, ITraceDataProvider.Ptr, ppProvider)
    get__NewEnum(retVal)
      => ComCall(9, this.p, IUnknown.Ptr, retVal)
    Add(pProvider?)
      => ComCall(10, this.p, ITraceDataProvider, pProvider?)
    Remove(vProvider)
      => ComCall(11, this.p, VARIANT, vProvider)
    Clear()
      => ComCall(12, this.p)
    AddRange(providers?)
      => ComCall(13, this.p, ITraceDataProviderCollection, providers?)
    CreateTraceDataProvider(Provider)
      => ComCall(14, this.p, ITraceDataProvider.Ptr, Provider)
    GetTraceDataProviders(server?)
      => ComCall(15, this.p, BSTR, server?)
    GetTraceDataProvidersByProcess(Server?, Pid)
      => ComCall(16, this.p, BSTR, Server?, UInt32, Pid)
}
struct ISchedule extends IDispatch {
    static IID := "{0383753A-098B-11D8-9414-505054503030}"
    get_StartDate(start)
      => ComCall(7, this.p, VARIANT.Ptr, start)
    put_StartDate(start)
      => ComCall(8, this.p, VARIANT, start)
    get_EndDate(end)
      => ComCall(9, this.p, VARIANT.Ptr, end)
    put_EndDate(end)
      => ComCall(10, this.p, VARIANT, end)
    get_StartTime(start)
      => ComCall(11, this.p, VARIANT.Ptr, start)
    put_StartTime(start)
      => ComCall(12, this.p, VARIANT, start)
    get_Days(days)
      => ComCall(13, this.p, WeekDays.Ptr, days)
    put_Days(days)
      => ComCall(14, this.p, WeekDays, days)
}
struct IScheduleCollection extends IDispatch {
    static IID := "{0383753D-098B-11D8-9414-505054503030}"
    get_Count(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_Item(index, ppSchedule)
      => ComCall(8, this.p, VARIANT, index, ISchedule.Ptr, ppSchedule)
    get__NewEnum(ienum)
      => ComCall(9, this.p, IUnknown.Ptr, ienum)
    Add(pSchedule?)
      => ComCall(10, this.p, ISchedule, pSchedule?)
    Remove(vSchedule)
      => ComCall(11, this.p, VARIANT, vSchedule)
    Clear()
      => ComCall(12, this.p)
    AddRange(pSchedules?)
      => ComCall(13, this.p, IScheduleCollection, pSchedules?)
    CreateSchedule(Schedule)
      => ComCall(14, this.p, ISchedule.Ptr, Schedule)
}
struct IValueMapItem extends IDispatch {
    static IID := "{03837533-098B-11D8-9414-505054503030}"
    get_Description(description)
      => ComCall(7, this.p, BSTR.Ptr, description)
    put_Description(description)
      => ComCall(8, this.p, BSTR, description)
    get_Enabled(enabled)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(10, this.p, VARIANT_BOOL, enabled)
    get_Key(key)
      => ComCall(11, this.p, BSTR.Ptr, key)
    put_Key(key)
      => ComCall(12, this.p, BSTR, key)
    get_Value(Value)
      => ComCall(13, this.p, VARIANT.Ptr, Value)
    put_Value(Value)
      => ComCall(14, this.p, VARIANT, Value)
    get_ValueMapType(type)
      => ComCall(15, this.p, ValueMapType.Ptr, type)
    put_ValueMapType(type)
      => ComCall(16, this.p, ValueMapType, type)
}
struct IValueMap extends IDispatch {
    static IID := "{03837534-098B-11D8-9414-505054503030}"
    get_Count(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_Item(index, value)
      => ComCall(8, this.p, VARIANT, index, IValueMapItem.Ptr, value)
    get__NewEnum(retVal)
      => ComCall(9, this.p, IUnknown.Ptr, retVal)
    get_Description(description)
      => ComCall(10, this.p, BSTR.Ptr, description)
    put_Description(description)
      => ComCall(11, this.p, BSTR, description)
    get_Value(Value)
      => ComCall(12, this.p, VARIANT.Ptr, Value)
    put_Value(Value)
      => ComCall(13, this.p, VARIANT, Value)
    get_ValueMapType(type)
      => ComCall(14, this.p, ValueMapType.Ptr, type)
    put_ValueMapType(type)
      => ComCall(15, this.p, ValueMapType, type)
    Add(value)
      => ComCall(16, this.p, VARIANT, value)
    Remove(value)
      => ComCall(17, this.p, VARIANT, value)
    Clear()
      => ComCall(18, this.p)
    AddRange(map?)
      => ComCall(19, this.p, IValueMap, map?)
    CreateValueMapItem(Item)
      => ComCall(20, this.p, IValueMapItem.Ptr, Item)
}
struct PERF_OBJECT_TYPE {
    TotalByteLength : UInt32
    DefinitionLength : UInt32
    HeaderLength : UInt32
    ObjectNameTitleIndex : UInt32
    ObjectNameTitle : UInt32
    ObjectHelpTitleIndex : UInt32
    ObjectHelpTitle : UInt32
    DetailLevel : UInt32
    NumCounters : UInt32
    DefaultCounter : Int32
    NumInstances : Int32
    CodePage : UInt32
    PerfTime : Int64
    PerfFreq : Int64
}
struct PERF_COUNTER_DEFINITION {
    ByteLength : UInt32
    CounterNameTitleIndex : UInt32
    CounterNameTitle : UInt32
    CounterHelpTitleIndex : UInt32
    CounterHelpTitle : UInt32
    DefaultScale : Int32
    DetailLevel : UInt32
    CounterType : UInt32
    CounterSize : UInt32
    CounterOffset : UInt32
}
struct PERF_COUNTERSET_INFO {
    CounterSetGuid : GUID
    ProviderGuid : GUID
    NumCounters : UInt32
    InstanceType : UInt32
}
struct PERF_COUNTER_INFO {
    CounterId : UInt32
    Type : UInt32
    Attrib : Int64
    Size : UInt32
    DetailLevel : UInt32
    Scale : Int32
    Offset : UInt32
}
struct PERF_COUNTERSET_INSTANCE {
    CounterSetGuid : GUID
    dwSize : UInt32
    InstanceId : UInt32
    InstanceNameOffset : UInt32
    InstanceNameSize : UInt32
}
struct PERF_COUNTER_IDENTITY {
    CounterSetGuid : GUID
    BufferSize : UInt32
    CounterId : UInt32
    InstanceId : UInt32
    MachineOffset : UInt32
    NameOffset : UInt32
    Reserved : UInt32
}
struct PERFLIBREQUEST extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, UInt32]
}
struct PERF_MEM_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, Struct.Ptr]
}
struct PERF_MEM_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct PERF_PROVIDER_CONTEXT {
    ContextSize : UInt32
    Reserved : UInt32
    ControlCallback : PERFLIBREQUEST
    MemAllocRoutine : PERF_MEM_ALLOC
    MemFreeRoutine : PERF_MEM_FREE
    pMemContext : Struct.Ptr
}
struct PERF_INSTANCE_HEADER {
    Size : UInt32
    InstanceId : UInt32
}
struct PerfRegInfoType extends Int32 {
    static PERF_REG_COUNTERSET_STRUCT := 1
    static PERF_REG_COUNTER_STRUCT := 2
    static PERF_REG_COUNTERSET_NAME_STRING := 3
    static PERF_REG_COUNTERSET_HELP_STRING := 4
    static PERF_REG_COUNTER_NAME_STRINGS := 5
    static PERF_REG_COUNTER_HELP_STRINGS := 6
    static PERF_REG_PROVIDER_NAME := 7
    static PERF_REG_PROVIDER_GUID := 8
    static PERF_REG_COUNTERSET_ENGLISH_NAME := 9
    static PERF_REG_COUNTER_ENGLISH_NAMES := 10
}
struct PERF_COUNTERSET_REG_INFO {
    CounterSetGuid : GUID
    CounterSetType : UInt32
    DetailLevel : UInt32
    NumCounters : UInt32
    InstanceType : UInt32
}
struct PERF_COUNTER_REG_INFO {
    CounterId : UInt32
    Type : UInt32
    Attrib : Int64
    DetailLevel : UInt32
    DefaultScale : Int32
    BaseCounterId : UInt32
    PerfTimeId : UInt32
    PerfFreqId : UInt32
    MultiId : UInt32
    AggregateFunc : PERF_COUNTER_AGGREGATE_FUNC
    Reserved : UInt32
}
struct PERF_STRING_BUFFER_HEADER {
    dwSize : UInt32
    dwCounters : UInt32
}
struct PERF_STRING_COUNTER_HEADER {
    dwCounterId : UInt32
    dwOffset : UInt32
}
struct PERF_COUNTER_IDENTIFIER {
    CounterSetGuid : GUID
    Status : UInt32
    Size : UInt32
    CounterId : UInt32
    InstanceId : UInt32
    Index : UInt32
    Reserved : UInt32
}
struct PERF_DATA_HEADER {
    dwTotalSize : UInt32
    dwNumCounters : UInt32
    PerfTimeStamp : Int64
    PerfTime100NSec : Int64
    PerfFreq : Int64
    SystemTime : SYSTEMTIME
}
struct PerfCounterDataType extends Int32 {
    static PERF_ERROR_RETURN := 0
    static PERF_SINGLE_COUNTER := 1
    static PERF_MULTIPLE_COUNTERS := 2
    static PERF_MULTIPLE_INSTANCES := 4
    static PERF_COUNTERSET := 6
}
struct PERF_COUNTER_HEADER {
    dwStatus : UInt32
    dwType : PerfCounterDataType
    dwSize : UInt32
    Reserved : UInt32
}
struct PERF_MULTI_INSTANCES {
    dwTotalSize : UInt32
    dwInstances : UInt32
}
struct PERF_MULTI_COUNTERS {
    dwSize : UInt32
    dwCounters : UInt32
}
struct PERF_COUNTER_DATA {
    dwDataSize : UInt32
    dwSize : UInt32
}
struct PERF_DATA_BLOCK {
    Signature : UInt16[4]
    LittleEndian : UInt32
    Version : UInt32
    Revision : UInt32
    TotalByteLength : UInt32
    HeaderLength : UInt32
    NumObjectTypes : UInt32
    DefaultObject : Int32
    SystemTime : SYSTEMTIME
    PerfTime : Int64
    PerfFreq : Int64
    PerfTime100nSec : Int64
    SystemNameLength : UInt32
    SystemNameOffset : UInt32
}
struct PERF_INSTANCE_DEFINITION {
    ByteLength : UInt32
    ParentObjectTitleIndex : UInt32
    ParentObjectInstance : UInt32
    UniqueID : Int32
    NameOffset : UInt32
    NameLength : UInt32
}
struct PERF_COUNTER_BLOCK {
    ByteLength : UInt32
}
struct PM_OPEN_PROC extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PM_COLLECT_PROC extends FunctionPointer {
    static Types := [PWSTR, Struct.Ptr.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PM_CLOSE_PROC extends FunctionPointer {
    static Types := [UInt32]
}
struct PDH_RAW_COUNTER {
    CStatus : UInt32
    TimeStamp : FILETIME
    FirstValue : Int64
    SecondValue : Int64
    MultiCount : UInt32
}
struct PDH_RAW_COUNTER_ITEM_A {
    szName : PSTR
    RawValue : PDH_RAW_COUNTER
}
struct PDH_RAW_COUNTER_ITEM_W {
    szName : PWSTR
    RawValue : PDH_RAW_COUNTER
}
struct PDH_FMT_COUNTERVALUE {
    CStatus : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            longValue : Int32
            doubleValue : Float64
            largeValue : Int64
            AnsiStringValue : PSTR
            WideStringValue : PWSTR
        }
    }
}
struct PDH_FMT_COUNTERVALUE_ITEM_A {
    szName : PSTR
    FmtValue : PDH_FMT_COUNTERVALUE
}
struct PDH_FMT_COUNTERVALUE_ITEM_W {
    szName : PWSTR
    FmtValue : PDH_FMT_COUNTERVALUE
}
struct PDH_STATISTICS {
    dwFormat : UInt32
    count : UInt32
    min : PDH_FMT_COUNTERVALUE
    max : PDH_FMT_COUNTERVALUE
    mean : PDH_FMT_COUNTERVALUE
}
struct PDH_COUNTER_PATH_ELEMENTS_A {
    szMachineName : PSTR
    szObjectName : PSTR
    szInstanceName : PSTR
    szParentInstance : PSTR
    dwInstanceIndex : UInt32
    szCounterName : PSTR
}
struct PDH_COUNTER_PATH_ELEMENTS_W {
    szMachineName : PWSTR
    szObjectName : PWSTR
    szInstanceName : PWSTR
    szParentInstance : PWSTR
    dwInstanceIndex : UInt32
    szCounterName : PWSTR
}
struct PDH_DATA_ITEM_PATH_ELEMENTS_A {
    szMachineName : PSTR
    ObjectGUID : GUID
    dwItemId : UInt32
    szInstanceName : PSTR
}
struct PDH_DATA_ITEM_PATH_ELEMENTS_W {
    szMachineName : PWSTR
    ObjectGUID : GUID
    dwItemId : UInt32
    szInstanceName : PWSTR
}
struct PDH_COUNTER_INFO_A {
    dwLength : UInt32
    dwType : UInt32
    CVersion : UInt32
    CStatus : UInt32
    lScale : Int32
    lDefaultScale : Int32
    dwUserData : IntPtr
    dwQueryUserData : IntPtr
    szFullPath : PSTR
    Anonymous : this._Anonymous_e__Union
    szExplainText : PSTR
    DataBuffer : UInt32[1]
    struct _Anonymous_e__Union {
        union {
            DataItemPath : PDH_DATA_ITEM_PATH_ELEMENTS_A
            CounterPath : PDH_COUNTER_PATH_ELEMENTS_A
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            szMachineName : PSTR
            szObjectName : PSTR
            szInstanceName : PSTR
            szParentInstance : PSTR
            dwInstanceIndex : UInt32
            szCounterName : PSTR
        }
    }
}
struct PDH_COUNTER_INFO_W {
    dwLength : UInt32
    dwType : UInt32
    CVersion : UInt32
    CStatus : UInt32
    lScale : Int32
    lDefaultScale : Int32
    dwUserData : IntPtr
    dwQueryUserData : IntPtr
    szFullPath : PWSTR
    Anonymous : this._Anonymous_e__Union
    szExplainText : PWSTR
    DataBuffer : UInt32[1]
    struct _Anonymous_e__Union {
        union {
            DataItemPath : PDH_DATA_ITEM_PATH_ELEMENTS_W
            CounterPath : PDH_COUNTER_PATH_ELEMENTS_W
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            szMachineName : PWSTR
            szObjectName : PWSTR
            szInstanceName : PWSTR
            szParentInstance : PWSTR
            dwInstanceIndex : UInt32
            szCounterName : PWSTR
        }
    }
}
struct PDH_TIME_INFO {
    StartTime : Int64
    EndTime : Int64
    SampleCount : UInt32
}
struct PDH_RAW_LOG_RECORD {
    dwStructureSize : UInt32
    dwRecordType : PDH_LOG_TYPE
    dwItems : UInt32
    RawBytes : UInt8[1]
}
struct PDH_LOG_SERVICE_QUERY_INFO_A {
    dwSize : UInt32
    dwFlags : UInt32
    dwLogQuota : UInt32
    szLogFileCaption : PSTR
    szDefaultDir : PSTR
    szBaseFileName : PSTR
    dwFileType : UInt32
    dwReserved : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            PdlAutoNameInterval : UInt32
            PdlAutoNameUnits : UInt32
            PdlCommandFilename : PSTR
            PdlCounterList : PSTR
            PdlAutoNameFormat : UInt32
            PdlSampleInterval : UInt32
            PdlLogStartTime : FILETIME
            PdlLogEndTime : FILETIME
        }
        struct _Anonymous2_e__Struct {
            TlNumberOfBuffers : UInt32
            TlMinimumBuffers : UInt32
            TlMaximumBuffers : UInt32
            TlFreeBuffers : UInt32
            TlBufferSize : UInt32
            TlEventsLost : UInt32
            TlLoggerThreadId : UInt32
            TlBuffersWritten : UInt32
            TlLogHandle : UInt32
            TlLogFileName : PSTR
        }
    }
}
struct PDH_LOG_SERVICE_QUERY_INFO_W {
    dwSize : UInt32
    dwFlags : UInt32
    dwLogQuota : UInt32
    szLogFileCaption : PWSTR
    szDefaultDir : PWSTR
    szBaseFileName : PWSTR
    dwFileType : UInt32
    dwReserved : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            PdlAutoNameInterval : UInt32
            PdlAutoNameUnits : UInt32
            PdlCommandFilename : PWSTR
            PdlCounterList : PWSTR
            PdlAutoNameFormat : UInt32
            PdlSampleInterval : UInt32
            PdlLogStartTime : FILETIME
            PdlLogEndTime : FILETIME
        }
        struct _Anonymous2_e__Struct {
            TlNumberOfBuffers : UInt32
            TlMinimumBuffers : UInt32
            TlMaximumBuffers : UInt32
            TlFreeBuffers : UInt32
            TlBufferSize : UInt32
            TlEventsLost : UInt32
            TlLoggerThreadId : UInt32
            TlBuffersWritten : UInt32
            TlLogHandle : UInt32
            TlLogFileName : PWSTR
        }
    }
}
struct CounterPathCallBack extends FunctionPointer {
    static Types := [IntPtr, Int32]
}
struct PDH_BROWSE_DLG_CONFIG_HW {
    _bitfield : UInt32
    hWndOwner : HWND
    hDataSource : PDH_HLOG
    szReturnPathBuffer : PWSTR
    cchReturnPathLength : UInt32
    pCallBack : CounterPathCallBack
    dwCallBackArg : IntPtr
    CallBackStatus : Int32
    dwDefaultDetailLevel : PERF_DETAIL
    szDialogBoxCaption : PWSTR
}
struct PDH_BROWSE_DLG_CONFIG_HA {
    _bitfield : UInt32
    hWndOwner : HWND
    hDataSource : PDH_HLOG
    szReturnPathBuffer : PSTR
    cchReturnPathLength : UInt32
    pCallBack : CounterPathCallBack
    dwCallBackArg : IntPtr
    CallBackStatus : Int32
    dwDefaultDetailLevel : PERF_DETAIL
    szDialogBoxCaption : PSTR
}
struct PDH_BROWSE_DLG_CONFIG_W {
    _bitfield : UInt32
    hWndOwner : HWND
    szDataSource : PWSTR
    szReturnPathBuffer : PWSTR
    cchReturnPathLength : UInt32
    pCallBack : CounterPathCallBack
    dwCallBackArg : IntPtr
    CallBackStatus : Int32
    dwDefaultDetailLevel : PERF_DETAIL
    szDialogBoxCaption : PWSTR
}
struct PDH_BROWSE_DLG_CONFIG_A {
    _bitfield : UInt32
    hWndOwner : HWND
    szDataSource : PSTR
    szReturnPathBuffer : PSTR
    cchReturnPathLength : UInt32
    pCallBack : CounterPathCallBack
    dwCallBackArg : IntPtr
    CallBackStatus : Int32
    dwDefaultDetailLevel : PERF_DETAIL
    szDialogBoxCaption : PSTR
}
struct DisplayTypeConstants extends Int32 {
    static sysmonLineGraph := 1
    static sysmonHistogram := 2
    static sysmonReport := 3
    static sysmonChartArea := 4
    static sysmonChartStackedArea := 5
}
struct ReportValueTypeConstants extends Int32 {
    static sysmonDefaultValue := 0
    static sysmonCurrentValue := 1
    static sysmonAverage := 2
    static sysmonMinimum := 3
    static sysmonMaximum := 4
}
struct DataSourceTypeConstants extends Int32 {
    static sysmonNullDataSource := -1
    static sysmonCurrentActivity := 1
    static sysmonLogFiles := 2
    static sysmonSqlLog := 3
}
struct SysmonFileType extends Int32 {
    static sysmonFileHtml := 1
    static sysmonFileReport := 2
    static sysmonFileCsv := 3
    static sysmonFileTsv := 4
    static sysmonFileBlg := 5
    static sysmonFileRetiredBlg := 6
    static sysmonFileGif := 7
}
struct SysmonDataType extends Int32 {
    static sysmonDataAvg := 1
    static sysmonDataMin := 2
    static sysmonDataMax := 3
    static sysmonDataTime := 4
    static sysmonDataCount := 5
}
struct SysmonBatchReason extends Int32 {
    static sysmonBatchNone := 0
    static sysmonBatchAddFiles := 1
    static sysmonBatchAddCounters := 2
    static sysmonBatchAddFilesAutoCounters := 3
}
struct ICounterItem extends IUnknown {
    static IID := "{771A9520-EE28-11CE-941E-008029004347}"
    get_Value(pdblValue)
      => ComCall(3, this.p, Float64.Ptr, pdblValue)
    put_Color(Color)
      => ComCall(4, this.p, UInt32, Color)
    get_Color(pColor)
      => ComCall(5, this.p, UInt32.Ptr, pColor)
    put_Width(iWidth)
      => ComCall(6, this.p, Int32, iWidth)
    get_Width(piValue)
      => ComCall(7, this.p, Int32.Ptr, piValue)
    put_LineStyle(iLineStyle)
      => ComCall(8, this.p, Int32, iLineStyle)
    get_LineStyle(piValue)
      => ComCall(9, this.p, Int32.Ptr, piValue)
    put_ScaleFactor(iScale)
      => ComCall(10, this.p, Int32, iScale)
    get_ScaleFactor(piValue)
      => ComCall(11, this.p, Int32.Ptr, piValue)
    get_Path(pstrValue)
      => ComCall(12, this.p, BSTR.Ptr, pstrValue)
    GetValue(Value, Status)
      => ComCall(13, this.p, Float64.Ptr, Value, Int32.Ptr, Status)
    GetStatistics(Max, Min, Avg, Status)
      => ComCall(14, this.p, Float64.Ptr, Max, Float64.Ptr, Min, Float64.Ptr, Avg, Int32.Ptr, Status)
}
struct ICounterItem2 extends ICounterItem {
    static IID := "{EEFCD4E1-EA1C-4435-B7F4-E341BA03B4F9}"
    put_Selected(bState)
      => ComCall(15, this.p, VARIANT_BOOL, bState)
    get_Selected(pbState)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pbState)
    put_Visible(bState)
      => ComCall(17, this.p, VARIANT_BOOL, bState)
    get_Visible(pbState)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pbState)
    GetDataAt(iIndex, iWhich, pVariant)
      => ComCall(19, this.p, Int32, iIndex, SysmonDataType, iWhich, VARIANT.Ptr, pVariant)
}
struct ICounterItemUnion extends IUnknown {
    static IID := "{DE1A6B74-9182-4C41-8E2C-24C2CD30EE83}"
    get_Value(pdblValue)
      => ComCall(3, this.p, Float64.Ptr, pdblValue)
    put_Color(Color)
      => ComCall(4, this.p, UInt32, Color)
    get_Color(pColor)
      => ComCall(5, this.p, UInt32.Ptr, pColor)
    put_Width(iWidth)
      => ComCall(6, this.p, Int32, iWidth)
    get_Width(piValue)
      => ComCall(7, this.p, Int32.Ptr, piValue)
    put_LineStyle(iLineStyle)
      => ComCall(8, this.p, Int32, iLineStyle)
    get_LineStyle(piValue)
      => ComCall(9, this.p, Int32.Ptr, piValue)
    put_ScaleFactor(iScale)
      => ComCall(10, this.p, Int32, iScale)
    get_ScaleFactor(piValue)
      => ComCall(11, this.p, Int32.Ptr, piValue)
    get_Path(pstrValue)
      => ComCall(12, this.p, BSTR.Ptr, pstrValue)
    GetValue(Value, Status)
      => ComCall(13, this.p, Float64.Ptr, Value, Int32.Ptr, Status)
    GetStatistics(Max, Min, Avg, Status)
      => ComCall(14, this.p, Float64.Ptr, Max, Float64.Ptr, Min, Float64.Ptr, Avg, Int32.Ptr, Status)
    put_Selected(bState)
      => ComCall(15, this.p, VARIANT_BOOL, bState)
    get_Selected(pbState)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pbState)
    put_Visible(bState)
      => ComCall(17, this.p, VARIANT_BOOL, bState)
    get_Visible(pbState)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pbState)
    GetDataAt(iIndex, iWhich, pVariant)
      => ComCall(19, this.p, Int32, iIndex, SysmonDataType, iWhich, VARIANT.Ptr, pVariant)
}
struct DICounterItem extends IDispatch {
    static IID := "{C08C4FF2-0E2E-11CF-942C-008029004347}"
}
struct ICounters extends IDispatch {
    static IID := "{79167962-28FC-11CF-942F-008029004347}"
    get_Count(pLong)
      => ComCall(7, this.p, Int32.Ptr, pLong)
    get__NewEnum(ppIunk)
      => ComCall(8, this.p, IUnknown.Ptr, ppIunk)
    get_Item(index, ppI)
      => ComCall(9, this.p, VARIANT, index, DICounterItem.Ptr, ppI)
    Add(pathname, ppI)
      => ComCall(10, this.p, BSTR, pathname, DICounterItem.Ptr, ppI)
    Remove(index)
      => ComCall(11, this.p, VARIANT, index)
}
struct ILogFileItem extends IUnknown {
    static IID := "{D6B518DD-05C7-418A-89E6-4F9CE8C6841E}"
    get_Path(pstrValue)
      => ComCall(3, this.p, BSTR.Ptr, pstrValue)
}
struct DILogFileItem extends IDispatch {
    static IID := "{8D093FFC-F777-4917-82D1-833FBC54C58F}"
}
struct ILogFiles extends IDispatch {
    static IID := "{6A2A97E6-6851-41EA-87AD-2A8225335865}"
    get_Count(pLong)
      => ComCall(7, this.p, Int32.Ptr, pLong)
    get__NewEnum(ppIunk)
      => ComCall(8, this.p, IUnknown.Ptr, ppIunk)
    get_Item(index, ppI)
      => ComCall(9, this.p, VARIANT, index, DILogFileItem.Ptr, ppI)
    Add(pathname, ppI)
      => ComCall(10, this.p, BSTR, pathname, DILogFileItem.Ptr, ppI)
    Remove(index)
      => ComCall(11, this.p, VARIANT, index)
}
struct ISystemMonitor extends IUnknown {
    static IID := "{194EB241-C32C-11CF-9398-00AA00A3DDEA}"
    get_Appearance(iAppearance)
      => ComCall(3, this.p, Int32.Ptr, iAppearance)
    put_Appearance(iAppearance)
      => ComCall(4, this.p, Int32, iAppearance)
    get_BackColor(pColor)
      => ComCall(5, this.p, UInt32.Ptr, pColor)
    put_BackColor(Color)
      => ComCall(6, this.p, UInt32, Color)
    get_BorderStyle(iBorderStyle)
      => ComCall(7, this.p, Int32.Ptr, iBorderStyle)
    put_BorderStyle(iBorderStyle)
      => ComCall(8, this.p, Int32, iBorderStyle)
    get_ForeColor(pColor)
      => ComCall(9, this.p, UInt32.Ptr, pColor)
    put_ForeColor(Color)
      => ComCall(10, this.p, UInt32, Color)
    get_Font(ppFont)
      => ComCall(11, this.p, IFontDisp.Ptr, ppFont)
    putref_Font(pFont?)
      => ComCall(12, this.p, IFontDisp, pFont?)
    get_Counters(ppICounters)
      => ComCall(13, this.p, ICounters.Ptr, ppICounters)
    put_ShowVerticalGrid(bState)
      => ComCall(14, this.p, VARIANT_BOOL, bState)
    get_ShowVerticalGrid(pbState)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowHorizontalGrid(bState)
      => ComCall(16, this.p, VARIANT_BOOL, bState)
    get_ShowHorizontalGrid(pbState)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowLegend(bState)
      => ComCall(18, this.p, VARIANT_BOOL, bState)
    get_ShowLegend(pbState)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowScaleLabels(bState)
      => ComCall(20, this.p, VARIANT_BOOL, bState)
    get_ShowScaleLabels(pbState)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowValueBar(bState)
      => ComCall(22, this.p, VARIANT_BOOL, bState)
    get_ShowValueBar(pbState)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pbState)
    put_MaximumScale(iValue)
      => ComCall(24, this.p, Int32, iValue)
    get_MaximumScale(piValue)
      => ComCall(25, this.p, Int32.Ptr, piValue)
    put_MinimumScale(iValue)
      => ComCall(26, this.p, Int32, iValue)
    get_MinimumScale(piValue)
      => ComCall(27, this.p, Int32.Ptr, piValue)
    put_UpdateInterval(fValue)
      => ComCall(28, this.p, Float32, fValue)
    get_UpdateInterval(pfValue)
      => ComCall(29, this.p, Float32.Ptr, pfValue)
    put_DisplayType(eDisplayType)
      => ComCall(30, this.p, DisplayTypeConstants, eDisplayType)
    get_DisplayType(peDisplayType)
      => ComCall(31, this.p, DisplayTypeConstants.Ptr, peDisplayType)
    put_ManualUpdate(bState)
      => ComCall(32, this.p, VARIANT_BOOL, bState)
    get_ManualUpdate(pbState)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, pbState)
    put_GraphTitle(bsTitle)
      => ComCall(34, this.p, BSTR, bsTitle)
    get_GraphTitle(pbsTitle)
      => ComCall(35, this.p, BSTR.Ptr, pbsTitle)
    put_YAxisLabel(bsTitle)
      => ComCall(36, this.p, BSTR, bsTitle)
    get_YAxisLabel(pbsTitle)
      => ComCall(37, this.p, BSTR.Ptr, pbsTitle)
    CollectSample()
      => ComCall(38, this.p)
    UpdateGraph()
      => ComCall(39, this.p)
    BrowseCounters()
      => ComCall(40, this.p)
    DisplayProperties()
      => ComCall(41, this.p)
    Counter(iIndex, ppICounter)
      => ComCall(42, this.p, Int32, iIndex, ICounterItem.Ptr, ppICounter)
    AddCounter(bsPath, ppICounter)
      => ComCall(43, this.p, BSTR, bsPath, ICounterItem.Ptr, ppICounter)
    DeleteCounter(pCtr?)
      => ComCall(44, this.p, ICounterItem, pCtr?)
    get_BackColorCtl(pColor)
      => ComCall(45, this.p, UInt32.Ptr, pColor)
    put_BackColorCtl(Color)
      => ComCall(46, this.p, UInt32, Color)
    put_LogFileName(bsFileName)
      => ComCall(47, this.p, BSTR, bsFileName)
    get_LogFileName(bsFileName)
      => ComCall(48, this.p, BSTR.Ptr, bsFileName)
    put_LogViewStart(StartTime)
      => ComCall(49, this.p, Float64, StartTime)
    get_LogViewStart(StartTime)
      => ComCall(50, this.p, Float64.Ptr, StartTime)
    put_LogViewStop(StopTime)
      => ComCall(51, this.p, Float64, StopTime)
    get_LogViewStop(StopTime)
      => ComCall(52, this.p, Float64.Ptr, StopTime)
    get_GridColor(pColor)
      => ComCall(53, this.p, UInt32.Ptr, pColor)
    put_GridColor(Color)
      => ComCall(54, this.p, UInt32, Color)
    get_TimeBarColor(pColor)
      => ComCall(55, this.p, UInt32.Ptr, pColor)
    put_TimeBarColor(Color)
      => ComCall(56, this.p, UInt32, Color)
    get_Highlight(pbState)
      => ComCall(57, this.p, VARIANT_BOOL.Ptr, pbState)
    put_Highlight(bState)
      => ComCall(58, this.p, VARIANT_BOOL, bState)
    get_ShowToolbar(pbState)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowToolbar(bState)
      => ComCall(60, this.p, VARIANT_BOOL, bState)
    Paste()
      => ComCall(61, this.p)
    Copy()
      => ComCall(62, this.p)
    Reset()
      => ComCall(63, this.p)
    put_ReadOnly(bState)
      => ComCall(64, this.p, VARIANT_BOOL, bState)
    get_ReadOnly(pbState)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ReportValueType(eReportValueType)
      => ComCall(66, this.p, ReportValueTypeConstants, eReportValueType)
    get_ReportValueType(peReportValueType)
      => ComCall(67, this.p, ReportValueTypeConstants.Ptr, peReportValueType)
    put_MonitorDuplicateInstances(bState)
      => ComCall(68, this.p, VARIANT_BOOL, bState)
    get_MonitorDuplicateInstances(pbState)
      => ComCall(69, this.p, VARIANT_BOOL.Ptr, pbState)
    put_DisplayFilter(iValue)
      => ComCall(70, this.p, Int32, iValue)
    get_DisplayFilter(piValue)
      => ComCall(71, this.p, Int32.Ptr, piValue)
    get_LogFiles(ppILogFiles)
      => ComCall(72, this.p, ILogFiles.Ptr, ppILogFiles)
    put_DataSourceType(eDataSourceType)
      => ComCall(73, this.p, DataSourceTypeConstants, eDataSourceType)
    get_DataSourceType(peDataSourceType)
      => ComCall(74, this.p, DataSourceTypeConstants.Ptr, peDataSourceType)
    put_SqlDsnName(bsSqlDsnName)
      => ComCall(75, this.p, BSTR, bsSqlDsnName)
    get_SqlDsnName(bsSqlDsnName)
      => ComCall(76, this.p, BSTR.Ptr, bsSqlDsnName)
    put_SqlLogSetName(bsSqlLogSetName)
      => ComCall(77, this.p, BSTR, bsSqlLogSetName)
    get_SqlLogSetName(bsSqlLogSetName)
      => ComCall(78, this.p, BSTR.Ptr, bsSqlLogSetName)
}
struct ISystemMonitor2 extends ISystemMonitor {
    static IID := "{08E3206A-5FD2-4FDE-A8A5-8CB3B63D2677}"
    put_EnableDigitGrouping(bState)
      => ComCall(79, this.p, VARIANT_BOOL, bState)
    get_EnableDigitGrouping(pbState)
      => ComCall(80, this.p, VARIANT_BOOL.Ptr, pbState)
    put_EnableToolTips(bState)
      => ComCall(81, this.p, VARIANT_BOOL, bState)
    get_EnableToolTips(pbState)
      => ComCall(82, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowTimeAxisLabels(bState)
      => ComCall(83, this.p, VARIANT_BOOL, bState)
    get_ShowTimeAxisLabels(pbState)
      => ComCall(84, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ChartScroll(bScroll)
      => ComCall(85, this.p, VARIANT_BOOL, bScroll)
    get_ChartScroll(pbScroll)
      => ComCall(86, this.p, VARIANT_BOOL.Ptr, pbScroll)
    put_DataPointCount(iNewCount)
      => ComCall(87, this.p, Int32, iNewCount)
    get_DataPointCount(piDataPointCount)
      => ComCall(88, this.p, Int32.Ptr, piDataPointCount)
    ScaleToFit(bSelectedCountersOnly)
      => ComCall(89, this.p, VARIANT_BOOL, bSelectedCountersOnly)
    SaveAs(bstrFileName, eSysmonFileType)
      => ComCall(90, this.p, BSTR, bstrFileName, SysmonFileType, eSysmonFileType)
    Relog(bstrFileName, eSysmonFileType, iFilter)
      => ComCall(91, this.p, BSTR, bstrFileName, SysmonFileType, eSysmonFileType, Int32, iFilter)
    ClearData()
      => ComCall(92, this.p)
    get_LogSourceStartTime(pDate)
      => ComCall(93, this.p, Float64.Ptr, pDate)
    get_LogSourceStopTime(pDate)
      => ComCall(94, this.p, Float64.Ptr, pDate)
    SetLogViewRange(StartTime, StopTime)
      => ComCall(95, this.p, Float64, StartTime, Float64, StopTime)
    GetLogViewRange(StartTime, StopTime)
      => ComCall(96, this.p, Float64.Ptr, StartTime, Float64.Ptr, StopTime)
    BatchingLock(fLock, eBatchReason)
      => ComCall(97, this.p, VARIANT_BOOL, fLock, SysmonBatchReason, eBatchReason)
    LoadSettings(bstrSettingFileName)
      => ComCall(98, this.p, BSTR, bstrSettingFileName)
}
struct ISystemMonitorUnion extends IUnknown {
    static IID := "{C8A77338-265F-4DE5-AA25-C7DA1CE5A8F4}"
    get_Appearance(iAppearance)
      => ComCall(3, this.p, Int32.Ptr, iAppearance)
    put_Appearance(iAppearance)
      => ComCall(4, this.p, Int32, iAppearance)
    get_BackColor(pColor)
      => ComCall(5, this.p, UInt32.Ptr, pColor)
    put_BackColor(Color)
      => ComCall(6, this.p, UInt32, Color)
    get_BorderStyle(iBorderStyle)
      => ComCall(7, this.p, Int32.Ptr, iBorderStyle)
    put_BorderStyle(iBorderStyle)
      => ComCall(8, this.p, Int32, iBorderStyle)
    get_ForeColor(pColor)
      => ComCall(9, this.p, UInt32.Ptr, pColor)
    put_ForeColor(Color)
      => ComCall(10, this.p, UInt32, Color)
    get_Font(ppFont)
      => ComCall(11, this.p, IFontDisp.Ptr, ppFont)
    putref_Font(pFont?)
      => ComCall(12, this.p, IFontDisp, pFont?)
    get_Counters(ppICounters)
      => ComCall(13, this.p, ICounters.Ptr, ppICounters)
    put_ShowVerticalGrid(bState)
      => ComCall(14, this.p, VARIANT_BOOL, bState)
    get_ShowVerticalGrid(pbState)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowHorizontalGrid(bState)
      => ComCall(16, this.p, VARIANT_BOOL, bState)
    get_ShowHorizontalGrid(pbState)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowLegend(bState)
      => ComCall(18, this.p, VARIANT_BOOL, bState)
    get_ShowLegend(pbState)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowScaleLabels(bState)
      => ComCall(20, this.p, VARIANT_BOOL, bState)
    get_ShowScaleLabels(pbState)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowValueBar(bState)
      => ComCall(22, this.p, VARIANT_BOOL, bState)
    get_ShowValueBar(pbState)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pbState)
    put_MaximumScale(iValue)
      => ComCall(24, this.p, Int32, iValue)
    get_MaximumScale(piValue)
      => ComCall(25, this.p, Int32.Ptr, piValue)
    put_MinimumScale(iValue)
      => ComCall(26, this.p, Int32, iValue)
    get_MinimumScale(piValue)
      => ComCall(27, this.p, Int32.Ptr, piValue)
    put_UpdateInterval(fValue)
      => ComCall(28, this.p, Float32, fValue)
    get_UpdateInterval(pfValue)
      => ComCall(29, this.p, Float32.Ptr, pfValue)
    put_DisplayType(eDisplayType)
      => ComCall(30, this.p, DisplayTypeConstants, eDisplayType)
    get_DisplayType(peDisplayType)
      => ComCall(31, this.p, DisplayTypeConstants.Ptr, peDisplayType)
    put_ManualUpdate(bState)
      => ComCall(32, this.p, VARIANT_BOOL, bState)
    get_ManualUpdate(pbState)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, pbState)
    put_GraphTitle(bsTitle)
      => ComCall(34, this.p, BSTR, bsTitle)
    get_GraphTitle(pbsTitle)
      => ComCall(35, this.p, BSTR.Ptr, pbsTitle)
    put_YAxisLabel(bsTitle)
      => ComCall(36, this.p, BSTR, bsTitle)
    get_YAxisLabel(pbsTitle)
      => ComCall(37, this.p, BSTR.Ptr, pbsTitle)
    CollectSample()
      => ComCall(38, this.p)
    UpdateGraph()
      => ComCall(39, this.p)
    BrowseCounters()
      => ComCall(40, this.p)
    DisplayProperties()
      => ComCall(41, this.p)
    Counter(iIndex, ppICounter)
      => ComCall(42, this.p, Int32, iIndex, ICounterItem.Ptr, ppICounter)
    AddCounter(bsPath, ppICounter)
      => ComCall(43, this.p, BSTR, bsPath, ICounterItem.Ptr, ppICounter)
    DeleteCounter(pCtr?)
      => ComCall(44, this.p, ICounterItem, pCtr?)
    get_BackColorCtl(pColor)
      => ComCall(45, this.p, UInt32.Ptr, pColor)
    put_BackColorCtl(Color)
      => ComCall(46, this.p, UInt32, Color)
    put_LogFileName(bsFileName)
      => ComCall(47, this.p, BSTR, bsFileName)
    get_LogFileName(bsFileName)
      => ComCall(48, this.p, BSTR.Ptr, bsFileName)
    put_LogViewStart(StartTime)
      => ComCall(49, this.p, Float64, StartTime)
    get_LogViewStart(StartTime)
      => ComCall(50, this.p, Float64.Ptr, StartTime)
    put_LogViewStop(StopTime)
      => ComCall(51, this.p, Float64, StopTime)
    get_LogViewStop(StopTime)
      => ComCall(52, this.p, Float64.Ptr, StopTime)
    get_GridColor(pColor)
      => ComCall(53, this.p, UInt32.Ptr, pColor)
    put_GridColor(Color)
      => ComCall(54, this.p, UInt32, Color)
    get_TimeBarColor(pColor)
      => ComCall(55, this.p, UInt32.Ptr, pColor)
    put_TimeBarColor(Color)
      => ComCall(56, this.p, UInt32, Color)
    get_Highlight(pbState)
      => ComCall(57, this.p, VARIANT_BOOL.Ptr, pbState)
    put_Highlight(bState)
      => ComCall(58, this.p, VARIANT_BOOL, bState)
    get_ShowToolbar(pbState)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowToolbar(bState)
      => ComCall(60, this.p, VARIANT_BOOL, bState)
    Paste()
      => ComCall(61, this.p)
    Copy()
      => ComCall(62, this.p)
    Reset()
      => ComCall(63, this.p)
    put_ReadOnly(bState)
      => ComCall(64, this.p, VARIANT_BOOL, bState)
    get_ReadOnly(pbState)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ReportValueType(eReportValueType)
      => ComCall(66, this.p, ReportValueTypeConstants, eReportValueType)
    get_ReportValueType(peReportValueType)
      => ComCall(67, this.p, ReportValueTypeConstants.Ptr, peReportValueType)
    put_MonitorDuplicateInstances(bState)
      => ComCall(68, this.p, VARIANT_BOOL, bState)
    get_MonitorDuplicateInstances(pbState)
      => ComCall(69, this.p, VARIANT_BOOL.Ptr, pbState)
    put_DisplayFilter(iValue)
      => ComCall(70, this.p, Int32, iValue)
    get_DisplayFilter(piValue)
      => ComCall(71, this.p, Int32.Ptr, piValue)
    get_LogFiles(ppILogFiles)
      => ComCall(72, this.p, ILogFiles.Ptr, ppILogFiles)
    put_DataSourceType(eDataSourceType)
      => ComCall(73, this.p, DataSourceTypeConstants, eDataSourceType)
    get_DataSourceType(peDataSourceType)
      => ComCall(74, this.p, DataSourceTypeConstants.Ptr, peDataSourceType)
    put_SqlDsnName(bsSqlDsnName)
      => ComCall(75, this.p, BSTR, bsSqlDsnName)
    get_SqlDsnName(bsSqlDsnName)
      => ComCall(76, this.p, BSTR.Ptr, bsSqlDsnName)
    put_SqlLogSetName(bsSqlLogSetName)
      => ComCall(77, this.p, BSTR, bsSqlLogSetName)
    get_SqlLogSetName(bsSqlLogSetName)
      => ComCall(78, this.p, BSTR.Ptr, bsSqlLogSetName)
    put_EnableDigitGrouping(bState)
      => ComCall(79, this.p, VARIANT_BOOL, bState)
    get_EnableDigitGrouping(pbState)
      => ComCall(80, this.p, VARIANT_BOOL.Ptr, pbState)
    put_EnableToolTips(bState)
      => ComCall(81, this.p, VARIANT_BOOL, bState)
    get_EnableToolTips(pbState)
      => ComCall(82, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ShowTimeAxisLabels(bState)
      => ComCall(83, this.p, VARIANT_BOOL, bState)
    get_ShowTimeAxisLabels(pbState)
      => ComCall(84, this.p, VARIANT_BOOL.Ptr, pbState)
    put_ChartScroll(bScroll)
      => ComCall(85, this.p, VARIANT_BOOL, bScroll)
    get_ChartScroll(pbScroll)
      => ComCall(86, this.p, VARIANT_BOOL.Ptr, pbScroll)
    put_DataPointCount(iNewCount)
      => ComCall(87, this.p, Int32, iNewCount)
    get_DataPointCount(piDataPointCount)
      => ComCall(88, this.p, Int32.Ptr, piDataPointCount)
    ScaleToFit(bSelectedCountersOnly)
      => ComCall(89, this.p, VARIANT_BOOL, bSelectedCountersOnly)
    SaveAs(bstrFileName, eSysmonFileType)
      => ComCall(90, this.p, BSTR, bstrFileName, SysmonFileType, eSysmonFileType)
    Relog(bstrFileName, eSysmonFileType, iFilter)
      => ComCall(91, this.p, BSTR, bstrFileName, SysmonFileType, eSysmonFileType, Int32, iFilter)
    ClearData()
      => ComCall(92, this.p)
    get_LogSourceStartTime(pDate)
      => ComCall(93, this.p, Float64.Ptr, pDate)
    get_LogSourceStopTime(pDate)
      => ComCall(94, this.p, Float64.Ptr, pDate)
    SetLogViewRange(StartTime, StopTime)
      => ComCall(95, this.p, Float64, StartTime, Float64, StopTime)
    GetLogViewRange(StartTime, StopTime)
      => ComCall(96, this.p, Float64.Ptr, StartTime, Float64.Ptr, StopTime)
    BatchingLock(fLock, eBatchReason)
      => ComCall(97, this.p, VARIANT_BOOL, fLock, SysmonBatchReason, eBatchReason)
    LoadSettings(bstrSettingFileName)
      => ComCall(98, this.p, BSTR, bstrSettingFileName)
}
struct DISystemMonitor extends IDispatch {
    static IID := "{13D73D81-C32E-11CF-9398-00AA00A3DDEA}"
}
struct DISystemMonitorInternal extends IDispatch {
    static IID := "{194EB242-C32C-11CF-9398-00AA00A3DDEA}"
}
struct ISystemMonitorEvents extends IUnknown {
    static IID := "{EE660EA0-4ABD-11CF-943A-008029004347}"
    OnCounterSelected(Index)
      => ComCall(3, this.p, Int32, Index, "void")
    OnCounterAdded(Index)
      => ComCall(4, this.p, Int32, Index, "void")
    OnCounterDeleted(Index)
      => ComCall(5, this.p, Int32, Index, "void")
    OnSampleCollected()
      => ComCall(6, this.p, "void")
    OnDblClick(Index)
      => ComCall(7, this.p, Int32, Index, "void")
}
struct DISystemMonitorEvents extends IDispatch {
    static IID := "{84979930-4AB3-11CF-943A-008029004347}"
}
