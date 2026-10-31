#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

struct TASK_TRIGGER_TYPE extends Int32 {
    static TASK_TIME_TRIGGER_ONCE := 0
    static TASK_TIME_TRIGGER_DAILY := 1
    static TASK_TIME_TRIGGER_WEEKLY := 2
    static TASK_TIME_TRIGGER_MONTHLYDATE := 3
    static TASK_TIME_TRIGGER_MONTHLYDOW := 4
    static TASK_EVENT_TRIGGER_ON_IDLE := 5
    static TASK_EVENT_TRIGGER_AT_SYSTEMSTART := 6
    static TASK_EVENT_TRIGGER_AT_LOGON := 7
}
struct DAILY {
    DaysInterval : UInt16
}
struct WEEKLY {
    WeeksInterval : UInt16
    rgfDaysOfTheWeek : UInt16
}
struct MONTHLYDATE {
    rgfDays : UInt32
    rgfMonths : UInt16
}
struct MONTHLYDOW {
    wWhichWeek : UInt16
    rgfDaysOfTheWeek : UInt16
    rgfMonths : UInt16
}
struct TRIGGER_TYPE_UNION {
    union {
        Daily : DAILY
        Weekly : WEEKLY
        MonthlyDate : MONTHLYDATE
        MonthlyDOW : MONTHLYDOW
    }
}
struct TASK_TRIGGER {
    cbTriggerSize : UInt16
    Reserved1 : UInt16
    wBeginYear : UInt16
    wBeginMonth : UInt16
    wBeginDay : UInt16
    wEndYear : UInt16
    wEndMonth : UInt16
    wEndDay : UInt16
    wStartHour : UInt16
    wStartMinute : UInt16
    MinutesDuration : UInt32
    MinutesInterval : UInt32
    rgFlags : UInt32
    TriggerType : TASK_TRIGGER_TYPE
    Type : TRIGGER_TYPE_UNION
    Reserved2 : UInt16
    wRandomMinutesInterval : UInt16
}
struct ITaskTrigger extends IUnknown {
    static IID := "{148BD52B-A2AB-11CE-B11F-00AA00530503}"
    SetTrigger(pTrigger)
      => ComCall(3, this.p, TASK_TRIGGER.Ptr, pTrigger)
    GetTrigger(pTrigger)
      => ComCall(4, this.p, TASK_TRIGGER.Ptr, pTrigger)
    GetTriggerString(ppwszTrigger)
      => ComCall(5, this.p, PWSTR.Ptr, ppwszTrigger)
}
struct IScheduledWorkItem extends IUnknown {
    static IID := "{A6B952F0-A4B1-11D0-997D-00AA006887EC}"
    CreateTrigger(piNewTrigger, ppTrigger)
      => ComCall(3, this.p, UInt16.Ptr, piNewTrigger, ITaskTrigger.Ptr, ppTrigger)
    DeleteTrigger(iTrigger)
      => ComCall(4, this.p, UInt16, iTrigger)
    GetTriggerCount(pwCount)
      => ComCall(5, this.p, UInt16.Ptr, pwCount)
    GetTrigger(iTrigger, ppTrigger)
      => ComCall(6, this.p, UInt16, iTrigger, ITaskTrigger.Ptr, ppTrigger)
    GetTriggerString(iTrigger, ppwszTrigger)
      => ComCall(7, this.p, UInt16, iTrigger, PWSTR.Ptr, ppwszTrigger)
    GetRunTimes(pstBegin, pstEnd, pCount, rgstTaskTimes)
      => ComCall(8, this.p, SYSTEMTIME.Ptr, pstBegin, SYSTEMTIME.Ptr, pstEnd, UInt16.Ptr, pCount, SYSTEMTIME.Ptr.Ptr, rgstTaskTimes)
    GetNextRunTime(pstNextRun)
      => ComCall(9, this.p, SYSTEMTIME.Ptr, pstNextRun)
    SetIdleWait(wIdleMinutes, wDeadlineMinutes)
      => ComCall(10, this.p, UInt16, wIdleMinutes, UInt16, wDeadlineMinutes)
    GetIdleWait(pwIdleMinutes, pwDeadlineMinutes)
      => ComCall(11, this.p, UInt16.Ptr, pwIdleMinutes, UInt16.Ptr, pwDeadlineMinutes)
    Run()
      => ComCall(12, this.p)
    Terminate()
      => ComCall(13, this.p)
    EditWorkItem(hParent, dwReserved)
      => ComCall(14, this.p, HWND, hParent, UInt32, dwReserved)
    GetMostRecentRunTime(pstLastRun)
      => ComCall(15, this.p, SYSTEMTIME.Ptr, pstLastRun)
    GetStatus(phrStatus)
      => ComCall(16, this.p, HRESULT.Ptr, phrStatus)
    GetExitCode(pdwExitCode)
      => ComCall(17, this.p, UInt32.Ptr, pdwExitCode)
    SetComment(pwszComment)
      => ComCall(18, this.p, "Str", pwszComment)
    GetComment(ppwszComment)
      => ComCall(19, this.p, PWSTR.Ptr, ppwszComment)
    SetCreator(pwszCreator)
      => ComCall(20, this.p, "Str", pwszCreator)
    GetCreator(ppwszCreator)
      => ComCall(21, this.p, PWSTR.Ptr, ppwszCreator)
    SetWorkItemData(cbData, rgbData)
      => ComCall(22, this.p, UInt16, cbData, UInt8.Ptr, rgbData)
    GetWorkItemData(pcbData, prgbData)
      => ComCall(23, this.p, UInt16.Ptr, pcbData, UInt8.Ptr.Ptr, prgbData)
    SetErrorRetryCount(wRetryCount)
      => ComCall(24, this.p, UInt16, wRetryCount)
    GetErrorRetryCount(pwRetryCount)
      => ComCall(25, this.p, UInt16.Ptr, pwRetryCount)
    SetErrorRetryInterval(wRetryInterval)
      => ComCall(26, this.p, UInt16, wRetryInterval)
    GetErrorRetryInterval(pwRetryInterval)
      => ComCall(27, this.p, UInt16.Ptr, pwRetryInterval)
    SetFlags(dwFlags)
      => ComCall(28, this.p, UInt32, dwFlags)
    GetFlags(pdwFlags)
      => ComCall(29, this.p, UInt32.Ptr, pdwFlags)
    SetAccountInformation(pwszAccountName, pwszPassword)
      => ComCall(30, this.p, "Str", pwszAccountName, "Str", pwszPassword)
    GetAccountInformation(ppwszAccountName)
      => ComCall(31, this.p, PWSTR.Ptr, ppwszAccountName)
}
struct ITask extends IScheduledWorkItem {
    static IID := "{148BD524-A2AB-11CE-B11F-00AA00530503}"
    SetApplicationName(pwszApplicationName)
      => ComCall(32, this.p, "Str", pwszApplicationName)
    GetApplicationName(ppwszApplicationName)
      => ComCall(33, this.p, PWSTR.Ptr, ppwszApplicationName)
    SetParameters(pwszParameters)
      => ComCall(34, this.p, "Str", pwszParameters)
    GetParameters(ppwszParameters)
      => ComCall(35, this.p, PWSTR.Ptr, ppwszParameters)
    SetWorkingDirectory(pwszWorkingDirectory)
      => ComCall(36, this.p, "Str", pwszWorkingDirectory)
    GetWorkingDirectory(ppwszWorkingDirectory)
      => ComCall(37, this.p, PWSTR.Ptr, ppwszWorkingDirectory)
    SetPriority(dwPriority)
      => ComCall(38, this.p, UInt32, dwPriority)
    GetPriority(pdwPriority)
      => ComCall(39, this.p, UInt32.Ptr, pdwPriority)
    SetTaskFlags(dwFlags)
      => ComCall(40, this.p, UInt32, dwFlags)
    GetTaskFlags(pdwFlags)
      => ComCall(41, this.p, UInt32.Ptr, pdwFlags)
    SetMaxRunTime(dwMaxRunTimeMS)
      => ComCall(42, this.p, UInt32, dwMaxRunTimeMS)
    GetMaxRunTime(pdwMaxRunTimeMS)
      => ComCall(43, this.p, UInt32.Ptr, pdwMaxRunTimeMS)
}
struct IEnumWorkItems extends IUnknown {
    static IID := "{148BD528-A2AB-11CE-B11F-00AA00530503}"
    Next(celt, rgpwszNames, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, PWSTR.Ptr.Ptr, rgpwszNames, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumWorkItems)
      => ComCall(6, this.p, IEnumWorkItems.Ptr, ppEnumWorkItems)
}
struct ITaskScheduler extends IUnknown {
    static IID := "{148BD527-A2AB-11CE-B11F-00AA00530503}"
    SetTargetComputer(pwszComputer)
      => ComCall(3, this.p, "Str", pwszComputer)
    GetTargetComputer(ppwszComputer)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszComputer)
    Enum(ppEnumWorkItems)
      => ComCall(5, this.p, IEnumWorkItems.Ptr, ppEnumWorkItems)
    Activate(pwszName, riid, ppUnk)
      => ComCall(6, this.p, "Str", pwszName, GUID.Ptr, riid, IUnknown.Ptr, ppUnk)
    Delete(pwszName)
      => ComCall(7, this.p, "Str", pwszName)
    NewWorkItem(pwszTaskName, rclsid, riid, ppUnk)
      => ComCall(8, this.p, "Str", pwszTaskName, GUID.Ptr, rclsid, GUID.Ptr, riid, IUnknown.Ptr, ppUnk)
    AddWorkItem(pwszTaskName, pWorkItem)
      => ComCall(9, this.p, "Str", pwszTaskName, IScheduledWorkItem, pWorkItem)
    IsOfType(pwszName, riid)
      => ComCall(10, this.p, "Str", pwszName, GUID.Ptr, riid)
}
struct TASKPAGE extends Int32 {
    static TASKPAGE_TASK := 0
    static TASKPAGE_SCHEDULE := 1
    static TASKPAGE_SETTINGS := 2
}
struct IProvideTaskPage extends IUnknown {
    static IID := "{4086658A-CBBB-11CF-B604-00C04FD8D565}"
    GetPage(tpType, fPersistChanges, phPage)
      => ComCall(3, this.p, TASKPAGE, tpType, BOOL, fPersistChanges, HPROPSHEETPAGE.Ptr, phPage)
}
struct TASK_RUN_FLAGS extends Int32 {
    static TASK_RUN_NO_FLAGS := 0
    static TASK_RUN_AS_SELF := 1
    static TASK_RUN_IGNORE_CONSTRAINTS := 2
    static TASK_RUN_USE_SESSION_ID := 4
    static TASK_RUN_USER_SID := 8
}
struct TASK_ENUM_FLAGS extends Int32 {
    static TASK_ENUM_HIDDEN := 1
}
struct TASK_LOGON_TYPE extends Int32 {
    static TASK_LOGON_NONE := 0
    static TASK_LOGON_PASSWORD := 1
    static TASK_LOGON_S4U := 2
    static TASK_LOGON_INTERACTIVE_TOKEN := 3
    static TASK_LOGON_GROUP := 4
    static TASK_LOGON_SERVICE_ACCOUNT := 5
    static TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD := 6
}
struct TASK_RUNLEVEL_TYPE extends Int32 {
    static TASK_RUNLEVEL_LUA := 0
    static TASK_RUNLEVEL_HIGHEST := 1
}
struct TASK_PROCESSTOKENSID_TYPE extends Int32 {
    static TASK_PROCESSTOKENSID_NONE := 0
    static TASK_PROCESSTOKENSID_UNRESTRICTED := 1
    static TASK_PROCESSTOKENSID_DEFAULT := 2
}
struct TASK_STATE extends Int32 {
    static TASK_STATE_UNKNOWN := 0
    static TASK_STATE_DISABLED := 1
    static TASK_STATE_QUEUED := 2
    static TASK_STATE_READY := 3
    static TASK_STATE_RUNNING := 4
}
struct TASK_CREATION extends Int32 {
    static TASK_VALIDATE_ONLY := 1
    static TASK_CREATE := 2
    static TASK_UPDATE := 4
    static TASK_CREATE_OR_UPDATE := 6
    static TASK_DISABLE := 8
    static TASK_DONT_ADD_PRINCIPAL_ACE := 16
    static TASK_IGNORE_REGISTRATION_TRIGGERS := 32
}
struct TASK_TRIGGER_TYPE2 extends Int32 {
    static TASK_TRIGGER_EVENT := 0
    static TASK_TRIGGER_TIME := 1
    static TASK_TRIGGER_DAILY := 2
    static TASK_TRIGGER_WEEKLY := 3
    static TASK_TRIGGER_MONTHLY := 4
    static TASK_TRIGGER_MONTHLYDOW := 5
    static TASK_TRIGGER_IDLE := 6
    static TASK_TRIGGER_REGISTRATION := 7
    static TASK_TRIGGER_BOOT := 8
    static TASK_TRIGGER_LOGON := 9
    static TASK_TRIGGER_SESSION_STATE_CHANGE := 11
    static TASK_TRIGGER_CUSTOM_TRIGGER_01 := 12
}
struct TASK_SESSION_STATE_CHANGE_TYPE extends Int32 {
    static TASK_CONSOLE_CONNECT := 1
    static TASK_CONSOLE_DISCONNECT := 2
    static TASK_REMOTE_CONNECT := 3
    static TASK_REMOTE_DISCONNECT := 4
    static TASK_SESSION_LOCK := 7
    static TASK_SESSION_UNLOCK := 8
}
struct TASK_ACTION_TYPE extends Int32 {
    static TASK_ACTION_EXEC := 0
    static TASK_ACTION_COM_HANDLER := 5
    static TASK_ACTION_SEND_EMAIL := 6
    static TASK_ACTION_SHOW_MESSAGE := 7
}
struct TASK_INSTANCES_POLICY extends Int32 {
    static TASK_INSTANCES_PARALLEL := 0
    static TASK_INSTANCES_QUEUE := 1
    static TASK_INSTANCES_IGNORE_NEW := 2
    static TASK_INSTANCES_STOP_EXISTING := 3
}
struct TASK_COMPATIBILITY extends Int32 {
    static TASK_COMPATIBILITY_AT := 0
    static TASK_COMPATIBILITY_V1 := 1
    static TASK_COMPATIBILITY_V2 := 2
    static TASK_COMPATIBILITY_V2_1 := 3
    static TASK_COMPATIBILITY_V2_2 := 4
    static TASK_COMPATIBILITY_V2_3 := 5
    static TASK_COMPATIBILITY_V2_4 := 6
}
struct ITaskFolderCollection extends IDispatch {
    static IID := "{79184A66-8664-423F-97F1-637356A5D812}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppFolder)
      => ComCall(8, this.p, VARIANT, index, ITaskFolder.Ptr, ppFolder)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
}
struct ITaskService extends IDispatch {
    static IID := "{2FABA4C7-4DA9-4013-9697-20CC3FD40F85}"
    GetFolder(path?, ppFolder)
      => ComCall(7, this.p, BSTR, path?, ITaskFolder.Ptr, ppFolder)
    GetRunningTasks(flags, ppRunningTasks)
      => ComCall(8, this.p, Int32, flags, IRunningTaskCollection.Ptr, ppRunningTasks)
    NewTask(flags, ppDefinition)
      => ComCall(9, this.p, UInt32, flags, ITaskDefinition.Ptr, ppDefinition)
    Connect(serverName, user, domain, password)
      => ComCall(10, this.p, VARIANT, serverName, VARIANT, user, VARIANT, domain, VARIANT, password)
    get_Connected(pConnected)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pConnected)
    get_TargetServer(pServer)
      => ComCall(12, this.p, BSTR.Ptr, pServer)
    get_ConnectedUser(pUser)
      => ComCall(13, this.p, BSTR.Ptr, pUser)
    get_ConnectedDomain(pDomain)
      => ComCall(14, this.p, BSTR.Ptr, pDomain)
    get_HighestVersion(pVersion)
      => ComCall(15, this.p, UInt32.Ptr, pVersion)
}
struct ITaskHandler extends IUnknown {
    static IID := "{839D7762-5121-4009-9234-4F0D19394F04}"
    Start(pHandlerServices?, data)
      => ComCall(3, this.p, IUnknown, pHandlerServices?, BSTR, data)
    Stop(pRetCode)
      => ComCall(4, this.p, HRESULT.Ptr, pRetCode)
    Pause()
      => ComCall(5, this.p)
    Resume()
      => ComCall(6, this.p)
}
struct ITaskHandlerStatus extends IUnknown {
    static IID := "{EAEC7A8F-27A0-4DDC-8675-14726A01A38A}"
    UpdateStatus(percentComplete, statusMessage)
      => ComCall(3, this.p, Int16, percentComplete, BSTR, statusMessage)
    TaskCompleted(taskErrCode)
      => ComCall(4, this.p, HRESULT, taskErrCode)
}
struct ITaskVariables extends IUnknown {
    static IID := "{3E4C9351-D966-4B8B-BB87-CEBA68BB0107}"
    GetInput(pInput)
      => ComCall(3, this.p, BSTR.Ptr, pInput)
    SetOutput(input)
      => ComCall(4, this.p, BSTR, input)
    GetContext(pContext)
      => ComCall(5, this.p, BSTR.Ptr, pContext)
}
struct ITaskNamedValuePair extends IDispatch {
    static IID := "{39038068-2B46-4AFD-8662-7BB6F868D221}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_Value(pValue)
      => ComCall(9, this.p, BSTR.Ptr, pValue)
    put_Value(value)
      => ComCall(10, this.p, BSTR, value)
}
struct ITaskNamedValueCollection extends IDispatch {
    static IID := "{B4EF826B-63C3-46E4-A504-EF69E4F7EA4D}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppPair)
      => ComCall(8, this.p, Int32, index, ITaskNamedValuePair.Ptr, ppPair)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
    Create(name, value, ppPair)
      => ComCall(10, this.p, BSTR, name, BSTR, value, ITaskNamedValuePair.Ptr, ppPair)
    Remove(index)
      => ComCall(11, this.p, Int32, index)
    Clear()
      => ComCall(12, this.p)
}
struct IRunningTask extends IDispatch {
    static IID := "{653758FB-7B9A-4F1E-A471-BEEB8E9B834E}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    get_InstanceGuid(pGuid)
      => ComCall(8, this.p, BSTR.Ptr, pGuid)
    get_Path(pPath)
      => ComCall(9, this.p, BSTR.Ptr, pPath)
    get_State(pState)
      => ComCall(10, this.p, TASK_STATE.Ptr, pState)
    get_CurrentAction(pName)
      => ComCall(11, this.p, BSTR.Ptr, pName)
    Stop()
      => ComCall(12, this.p)
    Refresh()
      => ComCall(13, this.p)
    get_EnginePID(pPID)
      => ComCall(14, this.p, UInt32.Ptr, pPID)
}
struct IRunningTaskCollection extends IDispatch {
    static IID := "{6A67614B-6828-4FEC-AA54-6D52E8F1F2DB}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppRunningTask)
      => ComCall(8, this.p, VARIANT, index, IRunningTask.Ptr, ppRunningTask)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
}
struct IRegisteredTask extends IDispatch {
    static IID := "{9C86F320-DEE3-4DD1-B972-A303F26B061E}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    get_Path(pPath)
      => ComCall(8, this.p, BSTR.Ptr, pPath)
    get_State(pState)
      => ComCall(9, this.p, TASK_STATE.Ptr, pState)
    get_Enabled(pEnabled)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pEnabled)
    put_Enabled(enabled)
      => ComCall(11, this.p, VARIANT_BOOL, enabled)
    Run(params, ppRunningTask)
      => ComCall(12, this.p, VARIANT, params, IRunningTask.Ptr, ppRunningTask)
    RunEx(params, flags, sessionID, user, ppRunningTask)
      => ComCall(13, this.p, VARIANT, params, Int32, flags, Int32, sessionID, BSTR, user, IRunningTask.Ptr, ppRunningTask)
    GetInstances(flags, ppRunningTasks)
      => ComCall(14, this.p, Int32, flags, IRunningTaskCollection.Ptr, ppRunningTasks)
    get_LastRunTime(pLastRunTime)
      => ComCall(15, this.p, Float64.Ptr, pLastRunTime)
    get_LastTaskResult(pLastTaskResult)
      => ComCall(16, this.p, Int32.Ptr, pLastTaskResult)
    get_NumberOfMissedRuns(pNumberOfMissedRuns)
      => ComCall(17, this.p, Int32.Ptr, pNumberOfMissedRuns)
    get_NextRunTime(pNextRunTime)
      => ComCall(18, this.p, Float64.Ptr, pNextRunTime)
    get_Definition(ppDefinition)
      => ComCall(19, this.p, ITaskDefinition.Ptr, ppDefinition)
    get_Xml(pXml)
      => ComCall(20, this.p, BSTR.Ptr, pXml)
    GetSecurityDescriptor(securityInformation, pSddl)
      => ComCall(21, this.p, Int32, securityInformation, BSTR.Ptr, pSddl)
    SetSecurityDescriptor(sddl, flags)
      => ComCall(22, this.p, BSTR, sddl, Int32, flags)
    Stop(flags)
      => ComCall(23, this.p, Int32, flags)
    GetRunTimes(pstStart, pstEnd, pCount, pRunTimes)
      => ComCall(24, this.p, SYSTEMTIME.Ptr, pstStart, SYSTEMTIME.Ptr, pstEnd, UInt32.Ptr, pCount, SYSTEMTIME.Ptr.Ptr, pRunTimes)
}
struct ITrigger extends IDispatch {
    static IID := "{09941815-EA89-4B5B-89E0-2A773801FAC3}"
    get_Type(pType)
      => ComCall(7, this.p, TASK_TRIGGER_TYPE2.Ptr, pType)
    get_Id(pId)
      => ComCall(8, this.p, BSTR.Ptr, pId)
    put_Id(id)
      => ComCall(9, this.p, BSTR, id)
    get_Repetition(ppRepeat)
      => ComCall(10, this.p, IRepetitionPattern.Ptr, ppRepeat)
    put_Repetition(pRepeat)
      => ComCall(11, this.p, IRepetitionPattern, pRepeat)
    get_ExecutionTimeLimit(pTimeLimit)
      => ComCall(12, this.p, BSTR.Ptr, pTimeLimit)
    put_ExecutionTimeLimit(timelimit)
      => ComCall(13, this.p, BSTR, timelimit)
    get_StartBoundary(pStart)
      => ComCall(14, this.p, BSTR.Ptr, pStart)
    put_StartBoundary(start)
      => ComCall(15, this.p, BSTR, start)
    get_EndBoundary(pEnd)
      => ComCall(16, this.p, BSTR.Ptr, pEnd)
    put_EndBoundary(end)
      => ComCall(17, this.p, BSTR, end)
    get_Enabled(pEnabled)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pEnabled)
    put_Enabled(enabled)
      => ComCall(19, this.p, VARIANT_BOOL, enabled)
}
struct IIdleTrigger extends ITrigger {
    static IID := "{D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3}"
}
struct ILogonTrigger extends ITrigger {
    static IID := "{72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C}"
    get_Delay(pDelay)
      => ComCall(20, this.p, BSTR.Ptr, pDelay)
    put_Delay(delay)
      => ComCall(21, this.p, BSTR, delay)
    get_UserId(pUser)
      => ComCall(22, this.p, BSTR.Ptr, pUser)
    put_UserId(user)
      => ComCall(23, this.p, BSTR, user)
}
struct ISessionStateChangeTrigger extends ITrigger {
    static IID := "{754DA71B-4385-4475-9DD9-598294FA3641}"
    get_Delay(pDelay)
      => ComCall(20, this.p, BSTR.Ptr, pDelay)
    put_Delay(delay)
      => ComCall(21, this.p, BSTR, delay)
    get_UserId(pUser)
      => ComCall(22, this.p, BSTR.Ptr, pUser)
    put_UserId(user)
      => ComCall(23, this.p, BSTR, user)
    get_StateChange(pType)
      => ComCall(24, this.p, TASK_SESSION_STATE_CHANGE_TYPE.Ptr, pType)
    put_StateChange(type)
      => ComCall(25, this.p, TASK_SESSION_STATE_CHANGE_TYPE, type)
}
struct IEventTrigger extends ITrigger {
    static IID := "{D45B0167-9653-4EEF-B94F-0732CA7AF251}"
    get_Subscription(pQuery)
      => ComCall(20, this.p, BSTR.Ptr, pQuery)
    put_Subscription(query)
      => ComCall(21, this.p, BSTR, query)
    get_Delay(pDelay)
      => ComCall(22, this.p, BSTR.Ptr, pDelay)
    put_Delay(delay)
      => ComCall(23, this.p, BSTR, delay)
    get_ValueQueries(ppNamedXPaths)
      => ComCall(24, this.p, ITaskNamedValueCollection.Ptr, ppNamedXPaths)
    put_ValueQueries(pNamedXPaths)
      => ComCall(25, this.p, ITaskNamedValueCollection, pNamedXPaths)
}
struct ITimeTrigger extends ITrigger {
    static IID := "{B45747E0-EBA7-4276-9F29-85C5BB300006}"
    get_RandomDelay(pRandomDelay)
      => ComCall(20, this.p, BSTR.Ptr, pRandomDelay)
    put_RandomDelay(randomDelay)
      => ComCall(21, this.p, BSTR, randomDelay)
}
struct IDailyTrigger extends ITrigger {
    static IID := "{126C5CD8-B288-41D5-8DBF-E491446ADC5C}"
    get_DaysInterval(pDays)
      => ComCall(20, this.p, Int16.Ptr, pDays)
    put_DaysInterval(days)
      => ComCall(21, this.p, Int16, days)
    get_RandomDelay(pRandomDelay)
      => ComCall(22, this.p, BSTR.Ptr, pRandomDelay)
    put_RandomDelay(randomDelay)
      => ComCall(23, this.p, BSTR, randomDelay)
}
struct IWeeklyTrigger extends ITrigger {
    static IID := "{5038FC98-82FF-436D-8728-A512A57C9DC1}"
    get_DaysOfWeek(pDays)
      => ComCall(20, this.p, Int16.Ptr, pDays)
    put_DaysOfWeek(days)
      => ComCall(21, this.p, Int16, days)
    get_WeeksInterval(pWeeks)
      => ComCall(22, this.p, Int16.Ptr, pWeeks)
    put_WeeksInterval(weeks)
      => ComCall(23, this.p, Int16, weeks)
    get_RandomDelay(pRandomDelay)
      => ComCall(24, this.p, BSTR.Ptr, pRandomDelay)
    put_RandomDelay(randomDelay)
      => ComCall(25, this.p, BSTR, randomDelay)
}
struct IMonthlyTrigger extends ITrigger {
    static IID := "{97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC}"
    get_DaysOfMonth(pDays)
      => ComCall(20, this.p, Int32.Ptr, pDays)
    put_DaysOfMonth(days)
      => ComCall(21, this.p, Int32, days)
    get_MonthsOfYear(pMonths)
      => ComCall(22, this.p, Int16.Ptr, pMonths)
    put_MonthsOfYear(months)
      => ComCall(23, this.p, Int16, months)
    get_RunOnLastDayOfMonth(pLastDay)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, pLastDay)
    put_RunOnLastDayOfMonth(lastDay)
      => ComCall(25, this.p, VARIANT_BOOL, lastDay)
    get_RandomDelay(pRandomDelay)
      => ComCall(26, this.p, BSTR.Ptr, pRandomDelay)
    put_RandomDelay(randomDelay)
      => ComCall(27, this.p, BSTR, randomDelay)
}
struct IMonthlyDOWTrigger extends ITrigger {
    static IID := "{77D025A3-90FA-43AA-B52E-CDA5499B946A}"
    get_DaysOfWeek(pDays)
      => ComCall(20, this.p, Int16.Ptr, pDays)
    put_DaysOfWeek(days)
      => ComCall(21, this.p, Int16, days)
    get_WeeksOfMonth(pWeeks)
      => ComCall(22, this.p, Int16.Ptr, pWeeks)
    put_WeeksOfMonth(weeks)
      => ComCall(23, this.p, Int16, weeks)
    get_MonthsOfYear(pMonths)
      => ComCall(24, this.p, Int16.Ptr, pMonths)
    put_MonthsOfYear(months)
      => ComCall(25, this.p, Int16, months)
    get_RunOnLastWeekOfMonth(pLastWeek)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pLastWeek)
    put_RunOnLastWeekOfMonth(lastWeek)
      => ComCall(27, this.p, VARIANT_BOOL, lastWeek)
    get_RandomDelay(pRandomDelay)
      => ComCall(28, this.p, BSTR.Ptr, pRandomDelay)
    put_RandomDelay(randomDelay)
      => ComCall(29, this.p, BSTR, randomDelay)
}
struct IBootTrigger extends ITrigger {
    static IID := "{2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB}"
    get_Delay(pDelay)
      => ComCall(20, this.p, BSTR.Ptr, pDelay)
    put_Delay(delay)
      => ComCall(21, this.p, BSTR, delay)
}
struct IRegistrationTrigger extends ITrigger {
    static IID := "{4C8FEC3A-C218-4E0C-B23D-629024DB91A2}"
    get_Delay(pDelay)
      => ComCall(20, this.p, BSTR.Ptr, pDelay)
    put_Delay(delay)
      => ComCall(21, this.p, BSTR, delay)
}
struct IAction extends IDispatch {
    static IID := "{BAE54997-48B1-4CBE-9965-D6BE263EBEA4}"
    get_Id(pId)
      => ComCall(7, this.p, BSTR.Ptr, pId)
    put_Id(Id)
      => ComCall(8, this.p, BSTR, Id)
    get_Type(pType)
      => ComCall(9, this.p, TASK_ACTION_TYPE.Ptr, pType)
}
struct IExecAction extends IAction {
    static IID := "{4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047}"
    get_Path(pPath)
      => ComCall(10, this.p, BSTR.Ptr, pPath)
    put_Path(path)
      => ComCall(11, this.p, BSTR, path)
    get_Arguments(pArgument)
      => ComCall(12, this.p, BSTR.Ptr, pArgument)
    put_Arguments(argument)
      => ComCall(13, this.p, BSTR, argument)
    get_WorkingDirectory(pWorkingDirectory)
      => ComCall(14, this.p, BSTR.Ptr, pWorkingDirectory)
    put_WorkingDirectory(workingDirectory)
      => ComCall(15, this.p, BSTR, workingDirectory)
}
struct IExecAction2 extends IExecAction {
    static IID := "{F2A82542-BDA5-4E6B-9143-E2BF4F8987B6}"
    get_HideAppWindow(pHideAppWindow)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pHideAppWindow)
    put_HideAppWindow(hideAppWindow)
      => ComCall(17, this.p, VARIANT_BOOL, hideAppWindow)
}
struct IShowMessageAction extends IAction {
    static IID := "{505E9E68-AF89-46B8-A30F-56162A83D537}"
    get_Title(pTitle)
      => ComCall(10, this.p, BSTR.Ptr, pTitle)
    put_Title(title)
      => ComCall(11, this.p, BSTR, title)
    get_MessageBody(pMessageBody)
      => ComCall(12, this.p, BSTR.Ptr, pMessageBody)
    put_MessageBody(messageBody)
      => ComCall(13, this.p, BSTR, messageBody)
}
struct IComHandlerAction extends IAction {
    static IID := "{6D2FD252-75C5-4F66-90BA-2A7D8CC3039F}"
    get_ClassId(pClsid)
      => ComCall(10, this.p, BSTR.Ptr, pClsid)
    put_ClassId(clsid)
      => ComCall(11, this.p, BSTR, clsid)
    get_Data(pData)
      => ComCall(12, this.p, BSTR.Ptr, pData)
    put_Data(data)
      => ComCall(13, this.p, BSTR, data)
}
struct IEmailAction extends IAction {
    static IID := "{10F62C64-7E16-4314-A0C2-0C3683F99D40}"
    get_Server(pServer)
      => ComCall(10, this.p, BSTR.Ptr, pServer)
    put_Server(server)
      => ComCall(11, this.p, BSTR, server)
    get_Subject(pSubject)
      => ComCall(12, this.p, BSTR.Ptr, pSubject)
    put_Subject(subject)
      => ComCall(13, this.p, BSTR, subject)
    get_To(pTo)
      => ComCall(14, this.p, BSTR.Ptr, pTo)
    put_To(to)
      => ComCall(15, this.p, BSTR, to)
    get_Cc(pCc)
      => ComCall(16, this.p, BSTR.Ptr, pCc)
    put_Cc(cc)
      => ComCall(17, this.p, BSTR, cc)
    get_Bcc(pBcc)
      => ComCall(18, this.p, BSTR.Ptr, pBcc)
    put_Bcc(bcc)
      => ComCall(19, this.p, BSTR, bcc)
    get_ReplyTo(pReplyTo)
      => ComCall(20, this.p, BSTR.Ptr, pReplyTo)
    put_ReplyTo(replyTo)
      => ComCall(21, this.p, BSTR, replyTo)
    get_From(pFrom)
      => ComCall(22, this.p, BSTR.Ptr, pFrom)
    put_From(from)
      => ComCall(23, this.p, BSTR, from)
    get_HeaderFields(ppHeaderFields)
      => ComCall(24, this.p, ITaskNamedValueCollection.Ptr, ppHeaderFields)
    put_HeaderFields(pHeaderFields)
      => ComCall(25, this.p, ITaskNamedValueCollection, pHeaderFields)
    get_Body(pBody)
      => ComCall(26, this.p, BSTR.Ptr, pBody)
    put_Body(body)
      => ComCall(27, this.p, BSTR, body)
    get_Attachments(pAttachements)
      => ComCall(28, this.p, SAFEARRAY.Ptr.Ptr, pAttachements)
    put_Attachments(pAttachements)
      => ComCall(29, this.p, SAFEARRAY.Ptr, pAttachements)
}
struct ITriggerCollection extends IDispatch {
    static IID := "{85DF5081-1B24-4F32-878A-D9D14DF4CB77}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppTrigger)
      => ComCall(8, this.p, Int32, index, ITrigger.Ptr, ppTrigger)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
    Create(type, ppTrigger)
      => ComCall(10, this.p, TASK_TRIGGER_TYPE2, type, ITrigger.Ptr, ppTrigger)
    Remove(index)
      => ComCall(11, this.p, VARIANT, index)
    Clear()
      => ComCall(12, this.p)
}
struct IActionCollection extends IDispatch {
    static IID := "{02820E19-7B98-4ED2-B2E8-FDCCCEFF619B}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppAction)
      => ComCall(8, this.p, Int32, index, IAction.Ptr, ppAction)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
    get_XmlText(pText)
      => ComCall(10, this.p, BSTR.Ptr, pText)
    put_XmlText(text)
      => ComCall(11, this.p, BSTR, text)
    Create(type, ppAction)
      => ComCall(12, this.p, TASK_ACTION_TYPE, type, IAction.Ptr, ppAction)
    Remove(index)
      => ComCall(13, this.p, VARIANT, index)
    Clear()
      => ComCall(14, this.p)
    get_Context(pContext)
      => ComCall(15, this.p, BSTR.Ptr, pContext)
    put_Context(context)
      => ComCall(16, this.p, BSTR, context)
}
struct IPrincipal extends IDispatch {
    static IID := "{D98D51E5-C9B4-496A-A9C1-18980261CF0F}"
    get_Id(pId)
      => ComCall(7, this.p, BSTR.Ptr, pId)
    put_Id(Id)
      => ComCall(8, this.p, BSTR, Id)
    get_DisplayName(pName)
      => ComCall(9, this.p, BSTR.Ptr, pName)
    put_DisplayName(name)
      => ComCall(10, this.p, BSTR, name)
    get_UserId(pUser)
      => ComCall(11, this.p, BSTR.Ptr, pUser)
    put_UserId(user)
      => ComCall(12, this.p, BSTR, user)
    get_LogonType(pLogon)
      => ComCall(13, this.p, TASK_LOGON_TYPE.Ptr, pLogon)
    put_LogonType(logon)
      => ComCall(14, this.p, TASK_LOGON_TYPE, logon)
    get_GroupId(pGroup)
      => ComCall(15, this.p, BSTR.Ptr, pGroup)
    put_GroupId(group)
      => ComCall(16, this.p, BSTR, group)
    get_RunLevel(pRunLevel)
      => ComCall(17, this.p, TASK_RUNLEVEL_TYPE.Ptr, pRunLevel)
    put_RunLevel(runLevel)
      => ComCall(18, this.p, TASK_RUNLEVEL_TYPE, runLevel)
}
struct IPrincipal2 extends IDispatch {
    static IID := "{248919AE-E345-4A6D-8AEB-E0D3165C904E}"
    get_ProcessTokenSidType(pProcessTokenSidType)
      => ComCall(7, this.p, TASK_PROCESSTOKENSID_TYPE.Ptr, pProcessTokenSidType)
    put_ProcessTokenSidType(processTokenSidType)
      => ComCall(8, this.p, TASK_PROCESSTOKENSID_TYPE, processTokenSidType)
    get_RequiredPrivilegeCount(pCount)
      => ComCall(9, this.p, Int32.Ptr, pCount)
    get_RequiredPrivilege(index, pPrivilege)
      => ComCall(10, this.p, Int32, index, BSTR.Ptr, pPrivilege)
    AddRequiredPrivilege(privilege)
      => ComCall(11, this.p, BSTR, privilege)
}
struct IRegistrationInfo extends IDispatch {
    static IID := "{416D8B73-CB41-4EA1-805C-9BE9A5AC4A74}"
    get_Description(pDescription)
      => ComCall(7, this.p, BSTR.Ptr, pDescription)
    put_Description(description)
      => ComCall(8, this.p, BSTR, description)
    get_Author(pAuthor)
      => ComCall(9, this.p, BSTR.Ptr, pAuthor)
    put_Author(author)
      => ComCall(10, this.p, BSTR, author)
    get_Version(pVersion)
      => ComCall(11, this.p, BSTR.Ptr, pVersion)
    put_Version(version)
      => ComCall(12, this.p, BSTR, version)
    get_Date(pDate)
      => ComCall(13, this.p, BSTR.Ptr, pDate)
    put_Date(date)
      => ComCall(14, this.p, BSTR, date)
    get_Documentation(pDocumentation)
      => ComCall(15, this.p, BSTR.Ptr, pDocumentation)
    put_Documentation(documentation)
      => ComCall(16, this.p, BSTR, documentation)
    get_XmlText(pText)
      => ComCall(17, this.p, BSTR.Ptr, pText)
    put_XmlText(text)
      => ComCall(18, this.p, BSTR, text)
    get_URI(pUri)
      => ComCall(19, this.p, BSTR.Ptr, pUri)
    put_URI(uri)
      => ComCall(20, this.p, BSTR, uri)
    get_SecurityDescriptor(pSddl)
      => ComCall(21, this.p, VARIANT.Ptr, pSddl)
    put_SecurityDescriptor(sddl)
      => ComCall(22, this.p, VARIANT, sddl)
    get_Source(pSource)
      => ComCall(23, this.p, BSTR.Ptr, pSource)
    put_Source(source)
      => ComCall(24, this.p, BSTR, source)
}
struct ITaskDefinition extends IDispatch {
    static IID := "{F5BC8FC5-536D-4F77-B852-FBC1356FDEB6}"
    get_RegistrationInfo(ppRegistrationInfo)
      => ComCall(7, this.p, IRegistrationInfo.Ptr, ppRegistrationInfo)
    put_RegistrationInfo(pRegistrationInfo)
      => ComCall(8, this.p, IRegistrationInfo, pRegistrationInfo)
    get_Triggers(ppTriggers)
      => ComCall(9, this.p, ITriggerCollection.Ptr, ppTriggers)
    put_Triggers(pTriggers)
      => ComCall(10, this.p, ITriggerCollection, pTriggers)
    get_Settings(ppSettings)
      => ComCall(11, this.p, ITaskSettings.Ptr, ppSettings)
    put_Settings(pSettings)
      => ComCall(12, this.p, ITaskSettings, pSettings)
    get_Data(pData)
      => ComCall(13, this.p, BSTR.Ptr, pData)
    put_Data(data)
      => ComCall(14, this.p, BSTR, data)
    get_Principal(ppPrincipal)
      => ComCall(15, this.p, IPrincipal.Ptr, ppPrincipal)
    put_Principal(pPrincipal)
      => ComCall(16, this.p, IPrincipal, pPrincipal)
    get_Actions(ppActions)
      => ComCall(17, this.p, IActionCollection.Ptr, ppActions)
    put_Actions(pActions)
      => ComCall(18, this.p, IActionCollection, pActions)
    get_XmlText(pXml)
      => ComCall(19, this.p, BSTR.Ptr, pXml)
    put_XmlText(xml)
      => ComCall(20, this.p, BSTR, xml)
}
struct ITaskSettings extends IDispatch {
    static IID := "{8FD4711D-2D02-4C8C-87E3-EFF699DE127E}"
    get_AllowDemandStart(pAllowDemandStart)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pAllowDemandStart)
    put_AllowDemandStart(allowDemandStart)
      => ComCall(8, this.p, VARIANT_BOOL, allowDemandStart)
    get_RestartInterval(pRestartInterval)
      => ComCall(9, this.p, BSTR.Ptr, pRestartInterval)
    put_RestartInterval(restartInterval)
      => ComCall(10, this.p, BSTR, restartInterval)
    get_RestartCount(pRestartCount)
      => ComCall(11, this.p, Int32.Ptr, pRestartCount)
    put_RestartCount(restartCount)
      => ComCall(12, this.p, Int32, restartCount)
    get_MultipleInstances(pPolicy)
      => ComCall(13, this.p, TASK_INSTANCES_POLICY.Ptr, pPolicy)
    put_MultipleInstances(policy)
      => ComCall(14, this.p, TASK_INSTANCES_POLICY, policy)
    get_StopIfGoingOnBatteries(pStopIfOnBatteries)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pStopIfOnBatteries)
    put_StopIfGoingOnBatteries(stopIfOnBatteries)
      => ComCall(16, this.p, VARIANT_BOOL, stopIfOnBatteries)
    get_DisallowStartIfOnBatteries(pDisallowStart)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pDisallowStart)
    put_DisallowStartIfOnBatteries(disallowStart)
      => ComCall(18, this.p, VARIANT_BOOL, disallowStart)
    get_AllowHardTerminate(pAllowHardTerminate)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pAllowHardTerminate)
    put_AllowHardTerminate(allowHardTerminate)
      => ComCall(20, this.p, VARIANT_BOOL, allowHardTerminate)
    get_StartWhenAvailable(pStartWhenAvailable)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pStartWhenAvailable)
    put_StartWhenAvailable(startWhenAvailable)
      => ComCall(22, this.p, VARIANT_BOOL, startWhenAvailable)
    get_XmlText(pText)
      => ComCall(23, this.p, BSTR.Ptr, pText)
    put_XmlText(text)
      => ComCall(24, this.p, BSTR, text)
    get_RunOnlyIfNetworkAvailable(pRunOnlyIfNetworkAvailable)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pRunOnlyIfNetworkAvailable)
    put_RunOnlyIfNetworkAvailable(runOnlyIfNetworkAvailable)
      => ComCall(26, this.p, VARIANT_BOOL, runOnlyIfNetworkAvailable)
    get_ExecutionTimeLimit(pExecutionTimeLimit)
      => ComCall(27, this.p, BSTR.Ptr, pExecutionTimeLimit)
    put_ExecutionTimeLimit(executionTimeLimit)
      => ComCall(28, this.p, BSTR, executionTimeLimit)
    get_Enabled(pEnabled)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pEnabled)
    put_Enabled(enabled)
      => ComCall(30, this.p, VARIANT_BOOL, enabled)
    get_DeleteExpiredTaskAfter(pExpirationDelay)
      => ComCall(31, this.p, BSTR.Ptr, pExpirationDelay)
    put_DeleteExpiredTaskAfter(expirationDelay)
      => ComCall(32, this.p, BSTR, expirationDelay)
    get_Priority(pPriority)
      => ComCall(33, this.p, Int32.Ptr, pPriority)
    put_Priority(priority)
      => ComCall(34, this.p, Int32, priority)
    get_Compatibility(pCompatLevel)
      => ComCall(35, this.p, TASK_COMPATIBILITY.Ptr, pCompatLevel)
    put_Compatibility(compatLevel)
      => ComCall(36, this.p, TASK_COMPATIBILITY, compatLevel)
    get_Hidden(pHidden)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, pHidden)
    put_Hidden(hidden)
      => ComCall(38, this.p, VARIANT_BOOL, hidden)
    get_IdleSettings(ppIdleSettings)
      => ComCall(39, this.p, IIdleSettings.Ptr, ppIdleSettings)
    put_IdleSettings(pIdleSettings)
      => ComCall(40, this.p, IIdleSettings, pIdleSettings)
    get_RunOnlyIfIdle(pRunOnlyIfIdle)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pRunOnlyIfIdle)
    put_RunOnlyIfIdle(runOnlyIfIdle)
      => ComCall(42, this.p, VARIANT_BOOL, runOnlyIfIdle)
    get_WakeToRun(pWake)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pWake)
    put_WakeToRun(wake)
      => ComCall(44, this.p, VARIANT_BOOL, wake)
    get_NetworkSettings(ppNetworkSettings)
      => ComCall(45, this.p, INetworkSettings.Ptr, ppNetworkSettings)
    put_NetworkSettings(pNetworkSettings)
      => ComCall(46, this.p, INetworkSettings, pNetworkSettings)
}
struct ITaskSettings2 extends IDispatch {
    static IID := "{2C05C3F0-6EED-4C05-A15F-ED7D7A98A369}"
    get_DisallowStartOnRemoteAppSession(pDisallowStart)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pDisallowStart)
    put_DisallowStartOnRemoteAppSession(disallowStart)
      => ComCall(8, this.p, VARIANT_BOOL, disallowStart)
    get_UseUnifiedSchedulingEngine(pUseUnifiedEngine)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pUseUnifiedEngine)
    put_UseUnifiedSchedulingEngine(useUnifiedEngine)
      => ComCall(10, this.p, VARIANT_BOOL, useUnifiedEngine)
}
struct ITaskSettings3 extends ITaskSettings {
    static IID := "{0AD9D0D7-0C7F-4EBB-9A5F-D1C648DCA528}"
    get_DisallowStartOnRemoteAppSession(pDisallowStart)
      => ComCall(47, this.p, VARIANT_BOOL.Ptr, pDisallowStart)
    put_DisallowStartOnRemoteAppSession(disallowStart)
      => ComCall(48, this.p, VARIANT_BOOL, disallowStart)
    get_UseUnifiedSchedulingEngine(pUseUnifiedEngine)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, pUseUnifiedEngine)
    put_UseUnifiedSchedulingEngine(useUnifiedEngine)
      => ComCall(50, this.p, VARIANT_BOOL, useUnifiedEngine)
    get_MaintenanceSettings(ppMaintenanceSettings)
      => ComCall(51, this.p, IMaintenanceSettings.Ptr, ppMaintenanceSettings)
    put_MaintenanceSettings(pMaintenanceSettings)
      => ComCall(52, this.p, IMaintenanceSettings, pMaintenanceSettings)
    CreateMaintenanceSettings(ppMaintenanceSettings)
      => ComCall(53, this.p, IMaintenanceSettings.Ptr, ppMaintenanceSettings)
    get_Volatile(pVolatile)
      => ComCall(54, this.p, VARIANT_BOOL.Ptr, pVolatile)
    put_Volatile(Volatile)
      => ComCall(55, this.p, VARIANT_BOOL, Volatile)
}
struct IMaintenanceSettings extends IDispatch {
    static IID := "{A6024FA8-9652-4ADB-A6BF-5CFCD877A7BA}"
    put_Period(value)
      => ComCall(7, this.p, BSTR, value)
    get_Period(target)
      => ComCall(8, this.p, BSTR.Ptr, target)
    put_Deadline(value)
      => ComCall(9, this.p, BSTR, value)
    get_Deadline(target)
      => ComCall(10, this.p, BSTR.Ptr, target)
    put_Exclusive(value)
      => ComCall(11, this.p, VARIANT_BOOL, value)
    get_Exclusive(target)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, target)
}
struct IRegisteredTaskCollection extends IDispatch {
    static IID := "{86627EB4-42A7-41E4-A4D9-AC33A72F2D52}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    get_Item(index, ppRegisteredTask)
      => ComCall(8, this.p, VARIANT, index, IRegisteredTask.Ptr, ppRegisteredTask)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
}
struct ITaskFolder extends IDispatch {
    static IID := "{8CFAC062-A080-4C15-9A88-AA7C2AF80DFC}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    get_Path(pPath)
      => ComCall(8, this.p, BSTR.Ptr, pPath)
    GetFolder(path, ppFolder)
      => ComCall(9, this.p, BSTR, path, ITaskFolder.Ptr, ppFolder)
    GetFolders(flags, ppFolders)
      => ComCall(10, this.p, Int32, flags, ITaskFolderCollection.Ptr, ppFolders)
    CreateFolder(subFolderName, sddl, ppFolder)
      => ComCall(11, this.p, BSTR, subFolderName, VARIANT, sddl, ITaskFolder.Ptr, ppFolder)
    DeleteFolder(subFolderName, flags)
      => ComCall(12, this.p, BSTR, subFolderName, Int32, flags)
    GetTask(path, ppTask)
      => ComCall(13, this.p, BSTR, path, IRegisteredTask.Ptr, ppTask)
    GetTasks(flags, ppTasks)
      => ComCall(14, this.p, Int32, flags, IRegisteredTaskCollection.Ptr, ppTasks)
    DeleteTask(name, flags)
      => ComCall(15, this.p, BSTR, name, Int32, flags)
    RegisterTask(path, xmlText, flags, userId, password, logonType, sddl, ppTask)
      => ComCall(16, this.p, BSTR, path, BSTR, xmlText, Int32, flags, VARIANT, userId, VARIANT, password, TASK_LOGON_TYPE, logonType, VARIANT, sddl, IRegisteredTask.Ptr, ppTask)
    RegisterTaskDefinition(path, pDefinition?, flags, userId, password, logonType, sddl, ppTask)
      => ComCall(17, this.p, BSTR, path, ITaskDefinition, pDefinition?, Int32, flags, VARIANT, userId, VARIANT, password, TASK_LOGON_TYPE, logonType, VARIANT, sddl, IRegisteredTask.Ptr, ppTask)
    GetSecurityDescriptor(securityInformation, pSddl)
      => ComCall(18, this.p, Int32, securityInformation, BSTR.Ptr, pSddl)
    SetSecurityDescriptor(sddl, flags)
      => ComCall(19, this.p, BSTR, sddl, Int32, flags)
}
struct IIdleSettings extends IDispatch {
    static IID := "{84594461-0053-4342-A8FD-088FABF11F32}"
    get_IdleDuration(pDelay)
      => ComCall(7, this.p, BSTR.Ptr, pDelay)
    put_IdleDuration(delay)
      => ComCall(8, this.p, BSTR, delay)
    get_WaitTimeout(pTimeout)
      => ComCall(9, this.p, BSTR.Ptr, pTimeout)
    put_WaitTimeout(timeout)
      => ComCall(10, this.p, BSTR, timeout)
    get_StopOnIdleEnd(pStop)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pStop)
    put_StopOnIdleEnd(stop)
      => ComCall(12, this.p, VARIANT_BOOL, stop)
    get_RestartOnIdle(pRestart)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pRestart)
    put_RestartOnIdle(restart)
      => ComCall(14, this.p, VARIANT_BOOL, restart)
}
struct INetworkSettings extends IDispatch {
    static IID := "{9F7DEA84-C30B-4245-80B6-00E9F646F1B4}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_Id(pId)
      => ComCall(9, this.p, BSTR.Ptr, pId)
    put_Id(id)
      => ComCall(10, this.p, BSTR, id)
}
struct IRepetitionPattern extends IDispatch {
    static IID := "{7FB9ACF1-26BE-400E-85B5-294B9C75DFD6}"
    get_Interval(pInterval)
      => ComCall(7, this.p, BSTR.Ptr, pInterval)
    put_Interval(interval)
      => ComCall(8, this.p, BSTR, interval)
    get_Duration(pDuration)
      => ComCall(9, this.p, BSTR.Ptr, pDuration)
    put_Duration(duration)
      => ComCall(10, this.p, BSTR, duration)
    get_StopAtDurationEnd(pStop)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pStop)
    put_StopAtDurationEnd(stop)
      => ComCall(12, this.p, VARIANT_BOOL, stop)
}
