#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, HANDLE, HMODULE, HRESULT, PSTR, PWSTR}
#Import "..\Security\Types.ahk" {ACL}
#Import "..\System.Com\Types.ahk" {IEnumUnknown, IStream, IUnknown}
#Import "..\System.Diagnostics.Debug\Types.ahk" {EXCEPTION_POINTERS}
#Import "..\System.IO\Types.ahk" {LPOVERLAPPED_COMPLETION_ROUTINE}
#Import "..\System.Threading\Types.ahk" {LPTHREAD_START_ROUTINE, WAITORTIMERCALLBACK}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct COR_GC_STAT_TYPES extends Int32 {
    static COR_GC_COUNTS := 1
    static COR_GC_MEMORYUSAGE := 2
}
struct COR_GC_THREAD_STATS_TYPES extends Int32 {
    static COR_GC_THREAD_HAS_PROMOTED_BYTES := 1
}
struct COR_GC_STATS {
    Flags : UInt32
    ExplicitGCCount : IntPtr
    GenCollectionsTaken : IntPtr[3]
    CommittedKBytes : IntPtr
    ReservedKBytes : IntPtr
    Gen0HeapSizeKBytes : IntPtr
    Gen1HeapSizeKBytes : IntPtr
    Gen2HeapSizeKBytes : IntPtr
    LargeObjectHeapSizeKBytes : IntPtr
    KBytesPromotedFromGen0 : IntPtr
    KBytesPromotedFromGen1 : IntPtr
}
struct COR_GC_THREAD_STATS {
    PerThreadAllocation : Int64
    Flags : UInt32
}
struct IGCHost extends IUnknown {
    static IID := "{FAC34F6E-0DCD-47B5-8021-531BC5ECCA63}"
    SetGCStartupLimits(SegmentSize, MaxGen0Size)
      => ComCall(3, this.p, UInt32, SegmentSize, UInt32, MaxGen0Size)
    Collect(Generation)
      => ComCall(4, this.p, Int32, Generation)
    GetStats(pStats)
      => ComCall(5, this.p, COR_GC_STATS.Ptr, pStats)
    GetThreadStats(pFiberCookie, pStats)
      => ComCall(6, this.p, UInt32.Ptr, pFiberCookie, COR_GC_THREAD_STATS.Ptr, pStats)
    SetVirtualMemLimit(sztMaxVirtualMemMB)
      => ComCall(7, this.p, IntPtr, sztMaxVirtualMemMB)
}
struct IGCHost2 extends IGCHost {
    static IID := "{A1D70CEC-2DBE-4E2F-9291-FDF81438A1DF}"
    SetGCStartupLimitsEx(SegmentSize, MaxGen0Size)
      => ComCall(8, this.p, IntPtr, SegmentSize, IntPtr, MaxGen0Size)
}
struct FLockClrVersionCallback extends FunctionPointer {
    static Types := [HRESULT]
}
struct HOST_TYPE extends Int32 {
    static HOST_TYPE_DEFAULT := 0
    static HOST_TYPE_APPLAUNCH := 1
    static HOST_TYPE_CORFLAG := 2
}
struct FExecuteInAppDomainCallback extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct STARTUP_FLAGS extends Int32 {
    static STARTUP_CONCURRENT_GC := 1
    static STARTUP_LOADER_OPTIMIZATION_MASK := 6
    static STARTUP_LOADER_OPTIMIZATION_SINGLE_DOMAIN := 2
    static STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN := 4
    static STARTUP_LOADER_OPTIMIZATION_MULTI_DOMAIN_HOST := 6
    static STARTUP_LOADER_SAFEMODE := 16
    static STARTUP_LOADER_SETPREFERENCE := 256
    static STARTUP_SERVER_GC := 4096
    static STARTUP_HOARD_GC_VM := 8192
    static STARTUP_SINGLE_VERSION_HOSTING_INTERFACE := 16384
    static STARTUP_LEGACY_IMPERSONATION := 65536
    static STARTUP_DISABLE_COMMITTHREADSTACK := 131072
    static STARTUP_ALWAYSFLOW_IMPERSONATION := 262144
    static STARTUP_TRIM_GC_COMMIT := 524288
    static STARTUP_ETW := 1048576
    static STARTUP_ARM := 4194304
}
struct CLSID_RESOLUTION_FLAGS extends Int32 {
    static CLSID_RESOLUTION_DEFAULT := 0
    static CLSID_RESOLUTION_REGISTERED := 1
}
struct RUNTIME_INFO_FLAGS extends Int32 {
    static RUNTIME_INFO_UPGRADE_VERSION := 1
    static RUNTIME_INFO_REQUEST_IA64 := 2
    static RUNTIME_INFO_REQUEST_AMD64 := 4
    static RUNTIME_INFO_REQUEST_X86 := 8
    static RUNTIME_INFO_DONT_RETURN_DIRECTORY := 16
    static RUNTIME_INFO_DONT_RETURN_VERSION := 32
    static RUNTIME_INFO_DONT_SHOW_ERROR_DIALOG := 64
    static RUNTIME_INFO_IGNORE_ERROR_MODE := 4096
    static RUNTIME_INFO_REQUEST_ARM64 := 8192
}
struct APPDOMAIN_SECURITY_FLAGS extends Int32 {
    static APPDOMAIN_SECURITY_DEFAULT := 0
    static APPDOMAIN_SECURITY_SANDBOXED := 1
    static APPDOMAIN_SECURITY_FORBID_CROSSAD_REVERSE_PINVOKE := 2
    static APPDOMAIN_FORCE_TRIVIAL_WAIT_OPERATIONS := 8
}
struct IObjectHandle extends IUnknown {
    static IID := "{C460E2B4-E199-412A-8456-84DC3E4838C3}"
    Unwrap(ppv)
      => ComCall(3, this.p, VARIANT.Ptr, ppv)
}
struct IAppDomainBinding extends IUnknown {
    static IID := "{5C2B07A7-1E98-11D3-872F-00C04F79ED0D}"
    OnAppDomain(pAppdomain)
      => ComCall(3, this.p, IUnknown, pAppdomain)
}
struct IGCThreadControl extends IUnknown {
    static IID := "{F31D1788-C397-4725-87A5-6AF3472C2791}"
    ThreadIsBlockingForSuspension()
      => ComCall(3, this.p)
    SuspensionStarting()
      => ComCall(4, this.p)
    SuspensionEnding(Generation)
      => ComCall(5, this.p, UInt32, Generation)
}
struct IGCHostControl extends IUnknown {
    static IID := "{5513D564-8374-4CB9-AED9-0083F4160A1D}"
    RequestVirtualMemLimit(sztMaxVirtualMemMB, psztNewMaxVirtualMemMB)
      => ComCall(3, this.p, IntPtr, sztMaxVirtualMemMB, IntPtr.Ptr, psztNewMaxVirtualMemMB)
}
struct PTLS_CALLBACK_FUNCTION extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct ICorThreadpool extends IUnknown {
    static IID := "{84680D3A-B2C1-46E8-ACC2-DBC0A359159A}"
    CorRegisterWaitForSingleObject(phNewWaitObject, hWaitObject, Callback, Context, timeout, executeOnlyOnce, result)
      => ComCall(3, this.p, HANDLE.Ptr, phNewWaitObject, HANDLE, hWaitObject, WAITORTIMERCALLBACK, Callback, Struct.Ptr, Context, UInt32, timeout, BOOL, executeOnlyOnce, BOOL.Ptr, result)
    CorUnregisterWait(hWaitObject, CompletionEvent, result)
      => ComCall(4, this.p, HANDLE, hWaitObject, HANDLE, CompletionEvent, BOOL.Ptr, result)
    CorQueueUserWorkItem(Function, Context, executeOnlyOnce, result)
      => ComCall(5, this.p, LPTHREAD_START_ROUTINE, Function, Struct.Ptr, Context, BOOL, executeOnlyOnce, BOOL.Ptr, result)
    CorCreateTimer(phNewTimer, Callback, Parameter, DueTime, Period, result)
      => ComCall(6, this.p, HANDLE.Ptr, phNewTimer, WAITORTIMERCALLBACK, Callback, Struct.Ptr, Parameter, UInt32, DueTime, UInt32, Period, BOOL.Ptr, result)
    CorChangeTimer(Timer, DueTime, Period, result)
      => ComCall(7, this.p, HANDLE, Timer, UInt32, DueTime, UInt32, Period, BOOL.Ptr, result)
    CorDeleteTimer(Timer, CompletionEvent, result)
      => ComCall(8, this.p, HANDLE, Timer, HANDLE, CompletionEvent, BOOL.Ptr, result)
    CorBindIoCompletionCallback(fileHandle, callback)
      => ComCall(9, this.p, HANDLE, fileHandle, LPOVERLAPPED_COMPLETION_ROUTINE, callback)
    CorCallOrQueueUserWorkItem(Function, Context, result)
      => ComCall(10, this.p, LPTHREAD_START_ROUTINE, Function, Struct.Ptr, Context, BOOL.Ptr, result)
    CorSetMaxThreads(MaxWorkerThreads, MaxIOCompletionThreads)
      => ComCall(11, this.p, UInt32, MaxWorkerThreads, UInt32, MaxIOCompletionThreads)
    CorGetMaxThreads(MaxWorkerThreads, MaxIOCompletionThreads)
      => ComCall(12, this.p, UInt32.Ptr, MaxWorkerThreads, UInt32.Ptr, MaxIOCompletionThreads)
    CorGetAvailableThreads(AvailableWorkerThreads, AvailableIOCompletionThreads)
      => ComCall(13, this.p, UInt32.Ptr, AvailableWorkerThreads, UInt32.Ptr, AvailableIOCompletionThreads)
}
struct IDebuggerThreadControl extends IUnknown {
    static IID := "{23D86786-0BB5-4774-8FB5-E3522ADD6246}"
    ThreadIsBlockingForDebugger()
      => ComCall(3, this.p)
    ReleaseAllRuntimeThreads()
      => ComCall(4, this.p)
    StartBlockingForDebugger(dwUnused)
      => ComCall(5, this.p, UInt32, dwUnused)
}
struct IDebuggerInfo extends IUnknown {
    static IID := "{BF24142D-A47D-4D24-A66D-8C2141944E44}"
    IsDebuggerAttached(pbAttached)
      => ComCall(3, this.p, BOOL.Ptr, pbAttached)
}
struct ICorConfiguration extends IUnknown {
    static IID := "{5C2B07A5-1E98-11D3-872F-00C04F79ED0D}"
    SetGCThreadControl(pGCThreadControl)
      => ComCall(3, this.p, IGCThreadControl, pGCThreadControl)
    SetGCHostControl(pGCHostControl)
      => ComCall(4, this.p, IGCHostControl, pGCHostControl)
    SetDebuggerThreadControl(pDebuggerThreadControl)
      => ComCall(5, this.p, IDebuggerThreadControl, pDebuggerThreadControl)
    AddDebuggerSpecialThread(dwSpecialThreadId)
      => ComCall(6, this.p, UInt32, dwSpecialThreadId)
}
struct ICorRuntimeHost extends IUnknown {
    static IID := "{CB2F6722-AB3A-11D2-9C40-00C04FA30A3E}"
    CreateLogicalThreadState()
      => ComCall(3, this.p)
    DeleteLogicalThreadState()
      => ComCall(4, this.p)
    SwitchInLogicalThreadState(pFiberCookie)
      => ComCall(5, this.p, UInt32.Ptr, pFiberCookie)
    SwitchOutLogicalThreadState(pFiberCookie)
      => ComCall(6, this.p, UInt32.Ptr.Ptr, pFiberCookie)
    LocksHeldByLogicalThread(pCount)
      => ComCall(7, this.p, UInt32.Ptr, pCount)
    MapFile(hFile, hMapAddress)
      => ComCall(8, this.p, HANDLE, hFile, HMODULE.Ptr, hMapAddress)
    GetConfiguration(pConfiguration)
      => ComCall(9, this.p, ICorConfiguration.Ptr, pConfiguration)
    Start()
      => ComCall(10, this.p)
    Stop()
      => ComCall(11, this.p)
    CreateDomain(pwzFriendlyName, pIdentityArray, pAppDomain)
      => ComCall(12, this.p, "Str", pwzFriendlyName, IUnknown, pIdentityArray, IUnknown.Ptr, pAppDomain)
    GetDefaultDomain(pAppDomain)
      => ComCall(13, this.p, IUnknown.Ptr, pAppDomain)
    EnumDomains(hEnum)
      => ComCall(14, this.p, Struct.Ptr.Ptr, hEnum)
    NextDomain(hEnum, pAppDomain)
      => ComCall(15, this.p, Struct.Ptr, hEnum, IUnknown.Ptr, pAppDomain)
    CloseEnum(hEnum)
      => ComCall(16, this.p, Struct.Ptr, hEnum)
    CreateDomainEx(pwzFriendlyName, pSetup, pEvidence, pAppDomain)
      => ComCall(17, this.p, "Str", pwzFriendlyName, IUnknown, pSetup, IUnknown, pEvidence, IUnknown.Ptr, pAppDomain)
    CreateDomainSetup(pAppDomainSetup)
      => ComCall(18, this.p, IUnknown.Ptr, pAppDomainSetup)
    CreateEvidence(pEvidence)
      => ComCall(19, this.p, IUnknown.Ptr, pEvidence)
    UnloadDomain(pAppDomain)
      => ComCall(20, this.p, IUnknown, pAppDomain)
    CurrentDomain(pAppDomain)
      => ComCall(21, this.p, IUnknown.Ptr, pAppDomain)
}
struct EMemoryAvailable extends Int32 {
    static eMemoryAvailableLow := 1
    static eMemoryAvailableNeutral := 2
    static eMemoryAvailableHigh := 3
}
struct EMemoryCriticalLevel extends Int32 {
    static eTaskCritical := 0
    static eAppDomainCritical := 1
    static eProcessCritical := 2
}
struct WAIT_OPTION extends Int32 {
    static WAIT_MSGPUMP := 1
    static WAIT_ALERTABLE := 2
    static WAIT_NOTINDEADLOCK := 4
}
struct ICLRMemoryNotificationCallback extends IUnknown {
    static IID := "{47EB8E57-0846-4546-AF76-6F42FCFC2649}"
    OnMemoryNotification(eMemoryAvailable1)
      => ComCall(3, this.p, EMemoryAvailable, eMemoryAvailable1)
}
struct IHostMalloc extends IUnknown {
    static IID := "{1831991C-CC53-4A31-B218-04E910446479}"
    Alloc(cbSize, eCriticalLevel, ppMem)
      => ComCall(3, this.p, IntPtr, cbSize, EMemoryCriticalLevel, eCriticalLevel, Struct.Ptr.Ptr, ppMem)
    DebugAlloc(cbSize, eCriticalLevel, pszFileName, iLineNo, ppMem)
      => ComCall(4, this.p, IntPtr, cbSize, EMemoryCriticalLevel, eCriticalLevel, UInt8.Ptr, pszFileName, Int32, iLineNo, Struct.Ptr.Ptr, ppMem)
    Free(pMem)
      => ComCall(5, this.p, Struct.Ptr, pMem)
}
struct MALLOC_TYPE extends Int32 {
    static MALLOC_THREADSAFE := 1
    static MALLOC_EXECUTABLE := 2
}
struct IHostMemoryManager extends IUnknown {
    static IID := "{7BC698D1-F9E3-4460-9CDE-D04248E9FA25}"
    CreateMalloc(dwMallocType, ppMalloc)
      => ComCall(3, this.p, UInt32, dwMallocType, IHostMalloc.Ptr, ppMalloc)
    VirtualAlloc(pAddress, dwSize, flAllocationType, flProtect, eCriticalLevel, ppMem)
      => ComCall(4, this.p, Struct.Ptr, pAddress, IntPtr, dwSize, UInt32, flAllocationType, UInt32, flProtect, EMemoryCriticalLevel, eCriticalLevel, Struct.Ptr.Ptr, ppMem)
    VirtualFree(lpAddress, dwSize, dwFreeType)
      => ComCall(5, this.p, Struct.Ptr, lpAddress, IntPtr, dwSize, UInt32, dwFreeType)
    VirtualQuery(lpAddress, lpBuffer, dwLength, pResult)
      => ComCall(6, this.p, Struct.Ptr, lpAddress, Struct.Ptr, lpBuffer, IntPtr, dwLength, IntPtr.Ptr, pResult)
    VirtualProtect(lpAddress, dwSize, flNewProtect, pflOldProtect)
      => ComCall(7, this.p, Struct.Ptr, lpAddress, IntPtr, dwSize, UInt32, flNewProtect, UInt32.Ptr, pflOldProtect)
    GetMemoryLoad(pMemoryLoad, pAvailableBytes)
      => ComCall(8, this.p, UInt32.Ptr, pMemoryLoad, IntPtr.Ptr, pAvailableBytes)
    RegisterMemoryNotificationCallback(pCallback)
      => ComCall(9, this.p, ICLRMemoryNotificationCallback, pCallback)
    NeedsVirtualAddressSpace(startAddress, size)
      => ComCall(10, this.p, Struct.Ptr, startAddress, IntPtr, size)
    AcquiredVirtualAddressSpace(startAddress, size)
      => ComCall(11, this.p, Struct.Ptr, startAddress, IntPtr, size)
    ReleasedVirtualAddressSpace(startAddress)
      => ComCall(12, this.p, Struct.Ptr, startAddress)
}
struct ICLRTask extends IUnknown {
    static IID := "{28E66A4A-9906-4225-B231-9187C3EB8611}"
    SwitchIn(threadHandle)
      => ComCall(3, this.p, HANDLE, threadHandle)
    SwitchOut()
      => ComCall(4, this.p)
    GetMemStats(memUsage)
      => ComCall(5, this.p, COR_GC_THREAD_STATS.Ptr, memUsage)
    Reset(fFull)
      => ComCall(6, this.p, BOOL, fFull)
    ExitTask()
      => ComCall(7, this.p)
    Abort()
      => ComCall(8, this.p)
    RudeAbort()
      => ComCall(9, this.p)
    NeedsPriorityScheduling(pbNeedsPriorityScheduling)
      => ComCall(10, this.p, BOOL.Ptr, pbNeedsPriorityScheduling)
    YieldTask()
      => ComCall(11, this.p)
    LocksHeld(pLockCount)
      => ComCall(12, this.p, IntPtr.Ptr, pLockCount)
    SetTaskIdentifier(asked)
      => ComCall(13, this.p, Int64, asked)
}
struct ICLRTask2 extends ICLRTask {
    static IID := "{28E66A4A-9906-4225-B231-9187C3EB8612}"
    BeginPreventAsyncAbort()
      => ComCall(14, this.p)
    EndPreventAsyncAbort()
      => ComCall(15, this.p)
}
struct IHostTask extends IUnknown {
    static IID := "{C2275828-C4B1-4B55-82C9-92135F74DF1A}"
    Start()
      => ComCall(3, this.p)
    Alert()
      => ComCall(4, this.p)
    Join(dwMilliseconds, option)
      => ComCall(5, this.p, UInt32, dwMilliseconds, UInt32, option)
    SetPriority(newPriority)
      => ComCall(6, this.p, Int32, newPriority)
    GetPriority(pPriority)
      => ComCall(7, this.p, Int32.Ptr, pPriority)
    SetCLRTask(pCLRTask)
      => ComCall(8, this.p, ICLRTask, pCLRTask)
}
struct ETaskType extends Int32 {
    static TT_DEBUGGERHELPER := 1
    static TT_GC := 2
    static TT_FINALIZER := 4
    static TT_THREADPOOL_TIMER := 8
    static TT_THREADPOOL_GATE := 16
    static TT_THREADPOOL_WORKER := 32
    static TT_THREADPOOL_IOCOMPLETION := 64
    static TT_ADUNLOAD := 128
    static TT_USER := 256
    static TT_THREADPOOL_WAIT := 512
    static TT_UNKNOWN := -2147483648
}
struct ICLRTaskManager extends IUnknown {
    static IID := "{4862EFBE-3AE5-44F8-8FEB-346190EE8A34}"
    CreateTask(pTask)
      => ComCall(3, this.p, ICLRTask.Ptr, pTask)
    GetCurrentTask(pTask)
      => ComCall(4, this.p, ICLRTask.Ptr, pTask)
    SetUILocale(lcid)
      => ComCall(5, this.p, UInt32, lcid)
    SetLocale(lcid)
      => ComCall(6, this.p, UInt32, lcid)
    GetCurrentTaskType(pTaskType)
      => ComCall(7, this.p, ETaskType.Ptr, pTaskType)
}
struct IHostTaskManager extends IUnknown {
    static IID := "{997FF24C-43B7-4352-8667-0DC04FAFD354}"
    GetCurrentTask(pTask)
      => ComCall(3, this.p, IHostTask.Ptr, pTask)
    CreateTask(dwStackSize, pStartAddress, pParameter, ppTask)
      => ComCall(4, this.p, UInt32, dwStackSize, LPTHREAD_START_ROUTINE, pStartAddress, Struct.Ptr, pParameter, IHostTask.Ptr, ppTask)
    Sleep(dwMilliseconds, option)
      => ComCall(5, this.p, UInt32, dwMilliseconds, UInt32, option)
    SwitchToTask(option)
      => ComCall(6, this.p, UInt32, option)
    SetUILocale(lcid)
      => ComCall(7, this.p, UInt32, lcid)
    SetLocale(lcid)
      => ComCall(8, this.p, UInt32, lcid)
    CallNeedsHostHook(target, pbCallNeedsHostHook)
      => ComCall(9, this.p, IntPtr, target, BOOL.Ptr, pbCallNeedsHostHook)
    LeaveRuntime(target)
      => ComCall(10, this.p, IntPtr, target)
    EnterRuntime()
      => ComCall(11, this.p)
    ReverseLeaveRuntime()
      => ComCall(12, this.p)
    ReverseEnterRuntime()
      => ComCall(13, this.p)
    BeginDelayAbort()
      => ComCall(14, this.p)
    EndDelayAbort()
      => ComCall(15, this.p)
    BeginThreadAffinity()
      => ComCall(16, this.p)
    EndThreadAffinity()
      => ComCall(17, this.p)
    SetStackGuarantee(guarantee)
      => ComCall(18, this.p, UInt32, guarantee)
    GetStackGuarantee(pGuarantee)
      => ComCall(19, this.p, UInt32.Ptr, pGuarantee)
    SetCLRTaskManager(ppManager)
      => ComCall(20, this.p, ICLRTaskManager, ppManager)
}
struct IHostThreadpoolManager extends IUnknown {
    static IID := "{983D50E2-CB15-466B-80FC-845DC6E8C5FD}"
    QueueUserWorkItem(Function, Context, Flags)
      => ComCall(3, this.p, LPTHREAD_START_ROUTINE, Function, Struct.Ptr, Context, UInt32, Flags)
    SetMaxThreads(dwMaxWorkerThreads)
      => ComCall(4, this.p, UInt32, dwMaxWorkerThreads)
    GetMaxThreads(pdwMaxWorkerThreads)
      => ComCall(5, this.p, UInt32.Ptr, pdwMaxWorkerThreads)
    GetAvailableThreads(pdwAvailableWorkerThreads)
      => ComCall(6, this.p, UInt32.Ptr, pdwAvailableWorkerThreads)
    SetMinThreads(dwMinIOCompletionThreads)
      => ComCall(7, this.p, UInt32, dwMinIOCompletionThreads)
    GetMinThreads(pdwMinIOCompletionThreads)
      => ComCall(8, this.p, UInt32.Ptr, pdwMinIOCompletionThreads)
}
struct ICLRIoCompletionManager extends IUnknown {
    static IID := "{2D74CE86-B8D6-4C84-B3A7-9768933B3C12}"
    OnComplete(dwErrorCode, NumberOfBytesTransferred, pvOverlapped)
      => ComCall(3, this.p, UInt32, dwErrorCode, UInt32, NumberOfBytesTransferred, Struct.Ptr, pvOverlapped)
}
struct IHostIoCompletionManager extends IUnknown {
    static IID := "{8BDE9D80-EC06-41D6-83E6-22580EFFCC20}"
    CreateIoCompletionPort(phPort)
      => ComCall(3, this.p, HANDLE.Ptr, phPort)
    CloseIoCompletionPort(hPort)
      => ComCall(4, this.p, HANDLE, hPort)
    SetMaxThreads(dwMaxIOCompletionThreads)
      => ComCall(5, this.p, UInt32, dwMaxIOCompletionThreads)
    GetMaxThreads(pdwMaxIOCompletionThreads)
      => ComCall(6, this.p, UInt32.Ptr, pdwMaxIOCompletionThreads)
    GetAvailableThreads(pdwAvailableIOCompletionThreads)
      => ComCall(7, this.p, UInt32.Ptr, pdwAvailableIOCompletionThreads)
    GetHostOverlappedSize(pcbSize)
      => ComCall(8, this.p, UInt32.Ptr, pcbSize)
    SetCLRIoCompletionManager(pManager)
      => ComCall(9, this.p, ICLRIoCompletionManager, pManager)
    InitializeHostOverlapped(pvOverlapped)
      => ComCall(10, this.p, Struct.Ptr, pvOverlapped)
    Bind(hPort, hHandle)
      => ComCall(11, this.p, HANDLE, hPort, HANDLE, hHandle)
    SetMinThreads(dwMinIOCompletionThreads)
      => ComCall(12, this.p, UInt32, dwMinIOCompletionThreads)
    GetMinThreads(pdwMinIOCompletionThreads)
      => ComCall(13, this.p, UInt32.Ptr, pdwMinIOCompletionThreads)
}
struct ESymbolReadingPolicy extends Int32 {
    static eSymbolReadingNever := 0
    static eSymbolReadingAlways := 1
    static eSymbolReadingFullTrustOnly := 2
}
struct ICLRDebugManager extends IUnknown {
    static IID := "{00DCAEC6-2AC0-43A9-ACF9-1E36C139B10D}"
    BeginConnection(dwConnectionId, szConnectionName)
      => ComCall(3, this.p, UInt32, dwConnectionId, "Str", szConnectionName)
    SetConnectionTasks(id, ppCLRTask)
      => ComCall(4, this.p, UInt32, id, UInt32, ppCLRTask.Length, ICLRTask.Ptr, ppCLRTask)
    EndConnection(dwConnectionId)
      => ComCall(5, this.p, UInt32, dwConnectionId)
    SetDacl(pacl)
      => ComCall(6, this.p, ACL.Ptr, pacl)
    GetDacl(pacl)
      => ComCall(7, this.p, ACL.Ptr.Ptr, pacl)
    IsDebuggerAttached(pbAttached)
      => ComCall(8, this.p, BOOL.Ptr, pbAttached)
    SetSymbolReadingPolicy(policy)
      => ComCall(9, this.p, ESymbolReadingPolicy, policy)
}
struct ECustomDumpFlavor extends Int32 {
    static DUMP_FLAVOR_Mini := 0
    static DUMP_FLAVOR_CriticalCLRState := 1
    static DUMP_FLAVOR_NonHeapCLRState := 2
    static DUMP_FLAVOR_Default := 0
}
struct ECustomDumpItemKind extends Int32 {
    static DUMP_ITEM_None := 0
}
struct CustomDumpItem {
    itemKind : ECustomDumpItemKind
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pReserved : IntPtr
        }
    }
}
struct BucketParameterIndex extends Int32 {
    static Parameter1 := 0
    static Parameter2 := 1
    static Parameter3 := 2
    static Parameter4 := 3
    static Parameter5 := 4
    static Parameter6 := 5
    static Parameter7 := 6
    static Parameter8 := 7
    static Parameter9 := 8
    static InvalidBucketParamIndex := 9
}
struct BucketParameters {
    fInited : BOOL
    pszEventTypeName : UInt16[255]
    pszParams : UInt16[2550]
}
struct ICLRErrorReportingManager extends IUnknown {
    static IID := "{980D2F1A-BF79-4C08-812A-BB9778928F78}"
    GetBucketParametersForCurrentException(pParams)
      => ComCall(3, this.p, BucketParameters.Ptr, pParams)
    BeginCustomDump(dwFlavor, items, dwReserved)
      => ComCall(4, this.p, ECustomDumpFlavor, dwFlavor, UInt32, items.Length, CustomDumpItem.Ptr, items, UInt32, dwReserved)
    EndCustomDump()
      => ComCall(5, this.p)
}
struct IHostCrst extends IUnknown {
    static IID := "{6DF710A6-26A4-4A65-8CD5-7237B8BDA8DC}"
    Enter(option)
      => ComCall(3, this.p, UInt32, option)
    Leave()
      => ComCall(4, this.p)
    TryEnter(option, pbSucceeded)
      => ComCall(5, this.p, UInt32, option, BOOL.Ptr, pbSucceeded)
    SetSpinCount(dwSpinCount)
      => ComCall(6, this.p, UInt32, dwSpinCount)
}
struct IHostAutoEvent extends IUnknown {
    static IID := "{50B0CFCE-4063-4278-9673-E5CB4ED0BDB8}"
    Wait(dwMilliseconds, option)
      => ComCall(3, this.p, UInt32, dwMilliseconds, UInt32, option)
    Set()
      => ComCall(4, this.p)
}
struct IHostManualEvent extends IUnknown {
    static IID := "{1BF4EC38-AFFE-4FB9-85A6-525268F15B54}"
    Wait(dwMilliseconds, option)
      => ComCall(3, this.p, UInt32, dwMilliseconds, UInt32, option)
    Reset()
      => ComCall(4, this.p)
    Set()
      => ComCall(5, this.p)
}
struct IHostSemaphore extends IUnknown {
    static IID := "{855EFD47-CC09-463A-A97D-16ACAB882661}"
    Wait(dwMilliseconds, option)
      => ComCall(3, this.p, UInt32, dwMilliseconds, UInt32, option)
    ReleaseSemaphore(lReleaseCount, lpPreviousCount)
      => ComCall(4, this.p, Int32, lReleaseCount, Int32.Ptr, lpPreviousCount)
}
struct ICLRSyncManager extends IUnknown {
    static IID := "{55FF199D-AD21-48F9-A16C-F24EBBB8727D}"
    GetMonitorOwner(Cookie, ppOwnerHostTask)
      => ComCall(3, this.p, IntPtr, Cookie, IHostTask.Ptr, ppOwnerHostTask)
    CreateRWLockOwnerIterator(Cookie, pIterator)
      => ComCall(4, this.p, IntPtr, Cookie, IntPtr.Ptr, pIterator)
    GetRWLockOwnerNext(Iterator, ppOwnerHostTask)
      => ComCall(5, this.p, IntPtr, Iterator, IHostTask.Ptr, ppOwnerHostTask)
    DeleteRWLockOwnerIterator(Iterator)
      => ComCall(6, this.p, IntPtr, Iterator)
}
struct IHostSyncManager extends IUnknown {
    static IID := "{234330C7-5F10-4F20-9615-5122DAB7A0AC}"
    SetCLRSyncManager(pManager)
      => ComCall(3, this.p, ICLRSyncManager, pManager)
    CreateCrst(ppCrst)
      => ComCall(4, this.p, IHostCrst.Ptr, ppCrst)
    CreateCrstWithSpinCount(dwSpinCount, ppCrst)
      => ComCall(5, this.p, UInt32, dwSpinCount, IHostCrst.Ptr, ppCrst)
    CreateAutoEvent(ppEvent)
      => ComCall(6, this.p, IHostAutoEvent.Ptr, ppEvent)
    CreateManualEvent(bInitialState, ppEvent)
      => ComCall(7, this.p, BOOL, bInitialState, IHostManualEvent.Ptr, ppEvent)
    CreateMonitorEvent(Cookie, ppEvent)
      => ComCall(8, this.p, IntPtr, Cookie, IHostAutoEvent.Ptr, ppEvent)
    CreateRWLockWriterEvent(Cookie, ppEvent)
      => ComCall(9, this.p, IntPtr, Cookie, IHostAutoEvent.Ptr, ppEvent)
    CreateRWLockReaderEvent(bInitialState, Cookie, ppEvent)
      => ComCall(10, this.p, BOOL, bInitialState, IntPtr, Cookie, IHostManualEvent.Ptr, ppEvent)
    CreateSemaphoreA(dwInitial, dwMax, ppSemaphore)
      => ComCall(11, this.p, UInt32, dwInitial, UInt32, dwMax, IHostSemaphore.Ptr, ppSemaphore)
}
struct EClrOperation extends Int32 {
    static OPR_ThreadAbort := 0
    static OPR_ThreadRudeAbortInNonCriticalRegion := 1
    static OPR_ThreadRudeAbortInCriticalRegion := 2
    static OPR_AppDomainUnload := 3
    static OPR_AppDomainRudeUnload := 4
    static OPR_ProcessExit := 5
    static OPR_FinalizerRun := 6
    static MaxClrOperation := 7
}
struct EClrFailure extends Int32 {
    static FAIL_NonCriticalResource := 0
    static FAIL_CriticalResource := 1
    static FAIL_FatalRuntime := 2
    static FAIL_OrphanedLock := 3
    static FAIL_StackOverflow := 4
    static FAIL_AccessViolation := 5
    static FAIL_CodeContract := 6
    static MaxClrFailure := 7
}
struct EClrUnhandledException extends Int32 {
    static eRuntimeDeterminedPolicy := 0
    static eHostDeterminedPolicy := 1
}
struct EPolicyAction extends Int32 {
    static eNoAction := 0
    static eThrowException := 1
    static eAbortThread := 2
    static eRudeAbortThread := 3
    static eUnloadAppDomain := 4
    static eRudeUnloadAppDomain := 5
    static eExitProcess := 6
    static eFastExitProcess := 7
    static eRudeExitProcess := 8
    static eDisableRuntime := 9
    static MaxPolicyAction := 10
}
struct ICLRPolicyManager extends IUnknown {
    static IID := "{7D290010-D781-45DA-A6F8-AA5D711A730E}"
    SetDefaultAction(operation, action)
      => ComCall(3, this.p, EClrOperation, operation, EPolicyAction, action)
    SetTimeout(operation, dwMilliseconds)
      => ComCall(4, this.p, EClrOperation, operation, UInt32, dwMilliseconds)
    SetActionOnTimeout(operation, action)
      => ComCall(5, this.p, EClrOperation, operation, EPolicyAction, action)
    SetTimeoutAndAction(operation, dwMilliseconds, action)
      => ComCall(6, this.p, EClrOperation, operation, UInt32, dwMilliseconds, EPolicyAction, action)
    SetActionOnFailure(failure, action)
      => ComCall(7, this.p, EClrFailure, failure, EPolicyAction, action)
    SetUnhandledExceptionPolicy(policy)
      => ComCall(8, this.p, EClrUnhandledException, policy)
}
struct IHostPolicyManager extends IUnknown {
    static IID := "{7AE49844-B1E3-4683-BA7C-1E8212EA3B79}"
    OnDefaultAction(operation, action)
      => ComCall(3, this.p, EClrOperation, operation, EPolicyAction, action)
    OnTimeout(operation, action)
      => ComCall(4, this.p, EClrOperation, operation, EPolicyAction, action)
    OnFailure(failure, action)
      => ComCall(5, this.p, EClrFailure, failure, EPolicyAction, action)
}
struct EClrEvent extends Int32 {
    static Event_DomainUnload := 0
    static Event_ClrDisabled := 1
    static Event_MDAFired := 2
    static Event_StackOverflow := 3
    static MaxClrEvent := 4
}
struct MDAInfo {
    lpMDACaption : PWSTR
    lpMDAMessage : PWSTR
    lpStackTrace : PWSTR
}
struct StackOverflowType extends Int32 {
    static SO_Managed := 0
    static SO_ClrEngine := 1
    static SO_Other := 2
}
struct StackOverflowInfo {
    soType : StackOverflowType
    pExceptionInfo : EXCEPTION_POINTERS.Ptr
}
struct IActionOnCLREvent extends IUnknown {
    static IID := "{607BE24B-D91B-4E28-A242-61871CE56E35}"
    OnEvent(event, data)
      => ComCall(3, this.p, EClrEvent, event, Struct.Ptr, data)
}
struct ICLROnEventManager extends IUnknown {
    static IID := "{1D0E0132-E64F-493D-9260-025C0E32C175}"
    RegisterActionOnEvent(event, pAction)
      => ComCall(3, this.p, EClrEvent, event, IActionOnCLREvent, pAction)
    UnregisterActionOnEvent(event, pAction)
      => ComCall(4, this.p, EClrEvent, event, IActionOnCLREvent, pAction)
}
struct IHostGCManager extends IUnknown {
    static IID := "{5D4EC34E-F248-457B-B603-255FAABA0D21}"
    ThreadIsBlockingForSuspension()
      => ComCall(3, this.p)
    SuspensionStarting()
      => ComCall(4, this.p)
    SuspensionEnding(Generation)
      => ComCall(5, this.p, UInt32, Generation)
}
struct ICLRAssemblyReferenceList extends IUnknown {
    static IID := "{1B2C9750-2E66-4BDA-8B44-0A642C5CD733}"
    IsStringAssemblyReferenceInList(pwzAssemblyName)
      => ComCall(3, this.p, "Str", pwzAssemblyName)
    IsAssemblyReferenceInList(pName)
      => ComCall(4, this.p, IUnknown, pName)
}
struct ICLRReferenceAssemblyEnum extends IUnknown {
    static IID := "{D509CB5D-CF32-4876-AE61-67770CF91973}"
    Get(dwIndex, pwzBuffer)
      => ComCall(3, this.p, UInt32, dwIndex, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
}
struct ICLRProbingAssemblyEnum extends IUnknown {
    static IID := "{D0C5FB1F-416B-4F97-81F4-7AC7DC24DD5D}"
    Get(dwIndex, pwzBuffer)
      => ComCall(3, this.p, UInt32, dwIndex, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
}
struct ECLRAssemblyIdentityFlags extends Int32 {
    static CLR_ASSEMBLY_IDENTITY_FLAGS_DEFAULT := 0
}
struct ICLRAssemblyIdentityManager extends IUnknown {
    static IID := "{15F0A9DA-3FF6-4393-9DA9-FDFD284E6972}"
    GetCLRAssemblyReferenceList(ppwzAssemblyReferences, dwNumOfReferences, ppReferenceList)
      => ComCall(3, this.p, PWSTR.Ptr, ppwzAssemblyReferences, UInt32, dwNumOfReferences, ICLRAssemblyReferenceList.Ptr, ppReferenceList)
    GetBindingIdentityFromFile(pwzFilePath, dwFlags, pwzBuffer)
      => ComCall(4, this.p, "Str", pwzFilePath, UInt32, dwFlags, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
    GetBindingIdentityFromStream(pStream, dwFlags, pwzBuffer)
      => ComCall(5, this.p, IStream, pStream, UInt32, dwFlags, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
    GetReferencedAssembliesFromFile(pwzFilePath, dwFlags, pExcludeAssembliesList, ppReferenceEnum)
      => ComCall(6, this.p, "Str", pwzFilePath, UInt32, dwFlags, ICLRAssemblyReferenceList, pExcludeAssembliesList, ICLRReferenceAssemblyEnum.Ptr, ppReferenceEnum)
    GetReferencedAssembliesFromStream(pStream, dwFlags, pExcludeAssembliesList, ppReferenceEnum)
      => ComCall(7, this.p, IStream, pStream, UInt32, dwFlags, ICLRAssemblyReferenceList, pExcludeAssembliesList, ICLRReferenceAssemblyEnum.Ptr, ppReferenceEnum)
    GetProbingAssembliesFromReference(dwMachineType, dwFlags, pwzReferenceIdentity, ppProbingAssemblyEnum)
      => ComCall(8, this.p, UInt32, dwMachineType, UInt32, dwFlags, "Str", pwzReferenceIdentity, ICLRProbingAssemblyEnum.Ptr, ppProbingAssemblyEnum)
    IsStronglyNamed(pwzAssemblyIdentity, pbIsStronglyNamed)
      => ComCall(9, this.p, "Str", pwzAssemblyIdentity, BOOL.Ptr, pbIsStronglyNamed)
}
struct EHostBindingPolicyModifyFlags extends Int32 {
    static HOST_BINDING_POLICY_MODIFY_DEFAULT := 0
    static HOST_BINDING_POLICY_MODIFY_CHAIN := 1
    static HOST_BINDING_POLICY_MODIFY_REMOVE := 2
    static HOST_BINDING_POLICY_MODIFY_MAX := 3
}
struct ICLRHostBindingPolicyManager extends IUnknown {
    static IID := "{4B3545E7-1856-48C9-A8BA-24B21A753C09}"
    ModifyApplicationPolicy(pwzSourceAssemblyIdentity, pwzTargetAssemblyIdentity, pbApplicationPolicy, cbAppPolicySize, dwPolicyModifyFlags, pbNewApplicationPolicy)
      => ComCall(3, this.p, "Str", pwzSourceAssemblyIdentity, "Str", pwzTargetAssemblyIdentity, UInt8.Ptr, pbApplicationPolicy, UInt32, cbAppPolicySize, UInt32, dwPolicyModifyFlags, UInt8.Ptr, pbNewApplicationPolicy, UInt32.Ptr, pbNewApplicationPolicy.Length)
    EvaluatePolicy(pwzReferenceIdentity, pbApplicationPolicy, cbAppPolicySize, pwzPostPolicyReferenceIdentity, pdwPoliciesApplied)
      => ComCall(4, this.p, "Str", pwzReferenceIdentity, UInt8.Ptr, pbApplicationPolicy, UInt32, cbAppPolicySize, PWSTR, pwzPostPolicyReferenceIdentity, UInt32.Ptr, pwzPostPolicyReferenceIdentity.Length, UInt32.Ptr, pdwPoliciesApplied)
}
struct ICLRGCManager extends IUnknown {
    static IID := "{54D9007E-A8E2-4885-B7BF-F998DEEE4F2A}"
    Collect(Generation)
      => ComCall(3, this.p, Int32, Generation)
    GetStats(pStats)
      => ComCall(4, this.p, COR_GC_STATS.Ptr, pStats)
    SetGCStartupLimits(SegmentSize, MaxGen0Size)
      => ComCall(5, this.p, UInt32, SegmentSize, UInt32, MaxGen0Size)
}
struct ICLRGCManager2 extends ICLRGCManager {
    static IID := "{0603B793-A97A-4712-9CB4-0CD1C74C0F7C}"
    SetGCStartupLimitsEx(SegmentSize, MaxGen0Size)
      => ComCall(6, this.p, IntPtr, SegmentSize, IntPtr, MaxGen0Size)
}
struct EBindPolicyLevels extends Int32 {
    static ePolicyLevelNone := 0
    static ePolicyLevelRetargetable := 1
    static ePolicyUnifiedToCLR := 2
    static ePolicyLevelApp := 4
    static ePolicyLevelPublisher := 8
    static ePolicyLevelHost := 16
    static ePolicyLevelAdmin := 32
    static ePolicyPortability := 64
}
struct AssemblyBindInfo {
    dwAppDomainId : UInt32
    lpReferencedIdentity : PWSTR
    lpPostPolicyIdentity : PWSTR
    ePolicyLevel : UInt32
}
struct ModuleBindInfo {
    dwAppDomainId : UInt32
    lpAssemblyIdentity : PWSTR
    lpModuleName : PWSTR
}
struct EHostApplicationPolicy extends Int32 {
    static HOST_APPLICATION_BINDING_POLICY := 1
}
struct IHostAssemblyStore extends IUnknown {
    static IID := "{7B102A88-3F7F-496D-8FA2-C35374E01AF3}"
    ProvideAssembly(pBindInfo, pAssemblyId, pContext, ppStmAssemblyImage, ppStmPDB)
      => ComCall(3, this.p, AssemblyBindInfo.Ptr, pBindInfo, Int64.Ptr, pAssemblyId, Int64.Ptr, pContext, IStream.Ptr, ppStmAssemblyImage, IStream.Ptr, ppStmPDB)
    ProvideModule(pBindInfo, pdwModuleId, ppStmModuleImage, ppStmPDB)
      => ComCall(4, this.p, ModuleBindInfo.Ptr, pBindInfo, UInt32.Ptr, pdwModuleId, IStream.Ptr, ppStmModuleImage, IStream.Ptr, ppStmPDB)
}
struct IHostAssemblyManager extends IUnknown {
    static IID := "{613DABD7-62B2-493E-9E65-C1E32A1E0C5E}"
    GetNonHostStoreAssemblies(ppReferenceList)
      => ComCall(3, this.p, ICLRAssemblyReferenceList.Ptr, ppReferenceList)
    GetAssemblyStore(ppAssemblyStore)
      => ComCall(4, this.p, IHostAssemblyStore.Ptr, ppAssemblyStore)
}
struct IHostControl extends IUnknown {
    static IID := "{02CA073C-7079-4860-880A-C2F7A449C991}"
    GetHostManager(riid, ppObject)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppObject)
    SetAppDomainManager(dwAppDomainID, pUnkAppDomainManager)
      => ComCall(4, this.p, UInt32, dwAppDomainID, IUnknown, pUnkAppDomainManager)
}
struct ICLRControl extends IUnknown {
    static IID := "{9065597E-D1A1-4FB2-B6BA-7E1FCE230F61}"
    GetCLRManager(riid, ppObject)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppObject)
    SetAppDomainManagerType(pwzAppDomainManagerAssembly, pwzAppDomainManagerType)
      => ComCall(4, this.p, "Str", pwzAppDomainManagerAssembly, "Str", pwzAppDomainManagerType)
}
struct ICLRRuntimeHost extends IUnknown {
    static IID := "{90F1A06C-7712-4762-86B5-7A5EBA6BDB02}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
    SetHostControl(pHostControl)
      => ComCall(5, this.p, IHostControl, pHostControl)
    GetCLRControl(pCLRControl)
      => ComCall(6, this.p, ICLRControl.Ptr, pCLRControl)
    UnloadAppDomain(dwAppDomainId, fWaitUntilDone)
      => ComCall(7, this.p, UInt32, dwAppDomainId, BOOL, fWaitUntilDone)
    ExecuteInAppDomain(dwAppDomainId, pCallback, cookie)
      => ComCall(8, this.p, UInt32, dwAppDomainId, FExecuteInAppDomainCallback, pCallback, Struct.Ptr, cookie)
    GetCurrentAppDomainId(pdwAppDomainId)
      => ComCall(9, this.p, UInt32.Ptr, pdwAppDomainId)
    ExecuteApplication(pwzAppFullName, dwManifestPaths, ppwzManifestPaths, dwActivationData, ppwzActivationData, pReturnValue)
      => ComCall(10, this.p, "Str", pwzAppFullName, UInt32, dwManifestPaths, PWSTR.Ptr, ppwzManifestPaths, UInt32, dwActivationData, PWSTR.Ptr, ppwzActivationData, Int32.Ptr, pReturnValue)
    ExecuteInDefaultAppDomain(pwzAssemblyPath, pwzTypeName, pwzMethodName, pwzArgument, pReturnValue)
      => ComCall(11, this.p, "Str", pwzAssemblyPath, "Str", pwzTypeName, "Str", pwzMethodName, "Str", pwzArgument, UInt32.Ptr, pReturnValue)
}
struct EApiCategories extends Int32 {
    static eNoChecks := 0
    static eSynchronization := 1
    static eSharedState := 2
    static eExternalProcessMgmt := 4
    static eSelfAffectingProcessMgmt := 8
    static eExternalThreading := 16
    static eSelfAffectingThreading := 32
    static eSecurityInfrastructure := 64
    static eUI := 128
    static eMayLeakOnAbort := 256
    static eAll := 511
}
struct ICLRHostProtectionManager extends IUnknown {
    static IID := "{89F25F5C-CEEF-43E1-9CFA-A68CE863AAAC}"
    SetProtectedCategories(categories)
      => ComCall(3, this.p, EApiCategories, categories)
    SetEagerSerializeGrantSets()
      => ComCall(4, this.p)
}
struct EInitializeNewDomainFlags extends Int32 {
    static eInitializeNewDomainFlags_None := 0
    static eInitializeNewDomainFlags_NoSecurityChanges := 2
}
struct ICLRDomainManager extends IUnknown {
    static IID := "{270D00A2-8E15-4D0B-ADEB-37BC3E47DF77}"
    SetAppDomainManagerType(wszAppDomainManagerAssembly, wszAppDomainManagerType, dwInitializeDomainFlags)
      => ComCall(3, this.p, "Str", wszAppDomainManagerAssembly, "Str", wszAppDomainManagerType, EInitializeNewDomainFlags, dwInitializeDomainFlags)
    SetPropertiesForDefaultAppDomain(nProperties, pwszPropertyNames, pwszPropertyValues)
      => ComCall(4, this.p, UInt32, nProperties, PWSTR.Ptr, pwszPropertyNames, PWSTR.Ptr, pwszPropertyValues)
}
struct ITypeName extends IUnknown {
    static IID := "{B81FF171-20F3-11D2-8DCC-00A0C9B00522}"
    GetNameCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetNames(count, rgbszNames, pCount)
      => ComCall(4, this.p, UInt32, count, BSTR.Ptr, rgbszNames, UInt32.Ptr, pCount)
    GetTypeArgumentCount(pCount)
      => ComCall(5, this.p, UInt32.Ptr, pCount)
    GetTypeArguments(count, rgpArguments, pCount)
      => ComCall(6, this.p, UInt32, count, ITypeName.Ptr, rgpArguments, UInt32.Ptr, pCount)
    GetModifierLength(pCount)
      => ComCall(7, this.p, UInt32.Ptr, pCount)
    GetModifiers(count, rgModifiers, pCount)
      => ComCall(8, this.p, UInt32, count, UInt32.Ptr, rgModifiers, UInt32.Ptr, pCount)
    GetAssemblyName(rgbszAssemblyNames)
      => ComCall(9, this.p, BSTR.Ptr, rgbszAssemblyNames)
}
struct ITypeNameBuilder extends IUnknown {
    static IID := "{B81FF171-20F3-11D2-8DCC-00A0C9B00523}"
    OpenGenericArguments()
      => ComCall(3, this.p)
    CloseGenericArguments()
      => ComCall(4, this.p)
    OpenGenericArgument()
      => ComCall(5, this.p)
    CloseGenericArgument()
      => ComCall(6, this.p)
    AddName(szName)
      => ComCall(7, this.p, "Str", szName)
    AddPointer()
      => ComCall(8, this.p)
    AddByRef()
      => ComCall(9, this.p)
    AddSzArray()
      => ComCall(10, this.p)
    AddArray(rank)
      => ComCall(11, this.p, UInt32, rank)
    AddAssemblySpec(szAssemblySpec)
      => ComCall(12, this.p, "Str", szAssemblySpec)
    ToString(pszStringRepresentation)
      => ComCall(13, this.p, BSTR.Ptr, pszStringRepresentation)
    Clear()
      => ComCall(14, this.p)
}
struct ITypeNameFactory extends IUnknown {
    static IID := "{B81FF171-20F3-11D2-8DCC-00A0C9B00521}"
    ParseTypeName(szName, pError, ppTypeName)
      => ComCall(3, this.p, "Str", szName, UInt32.Ptr, pError, ITypeName.Ptr, ppTypeName)
    GetTypeNameBuilder(ppTypeBuilder)
      => ComCall(4, this.p, ITypeNameBuilder.Ptr, ppTypeBuilder)
}
struct IApartmentCallback extends IUnknown {
    static IID := "{178E5337-1528-4591-B1C9-1C6E484686D8}"
    DoCallback(pFunc, pData)
      => ComCall(3, this.p, IntPtr, pFunc, IntPtr, pData)
}
struct IManagedObject extends IUnknown {
    static IID := "{C3FCC19E-A970-11D2-8B5A-00A0C9B7C9C4}"
    GetSerializedBuffer(pBSTR)
      => ComCall(3, this.p, BSTR.Ptr, pBSTR)
    GetObjectIdentity(pBSTRGUID, AppDomainID, pCCW)
      => ComCall(4, this.p, BSTR.Ptr, pBSTRGUID, Int32.Ptr, AppDomainID, Int32.Ptr, pCCW)
}
struct ICatalogServices extends IUnknown {
    static IID := "{04C6BE1E-1DB1-4058-AB7A-700CCCFBF254}"
    Autodone()
      => ComCall(3, this.p)
    NotAutodone()
      => ComCall(4, this.p)
}
struct EContextType extends Int32 {
    static eCurrentContext := 0
    static eRestrictedContext := 1
}
struct IHostSecurityContext extends IUnknown {
    static IID := "{7E573CE4-0343-4423-98D7-6318348A1D3C}"
    Capture(ppClonedContext)
      => ComCall(3, this.p, IHostSecurityContext.Ptr, ppClonedContext)
}
struct IHostSecurityManager extends IUnknown {
    static IID := "{75AD2468-A349-4D02-A764-76A68AEE0C4F}"
    ImpersonateLoggedOnUser(hToken)
      => ComCall(3, this.p, HANDLE, hToken)
    RevertToSelf()
      => ComCall(4, this.p)
    OpenThreadToken(dwDesiredAccess, bOpenAsSelf, phThreadToken)
      => ComCall(5, this.p, UInt32, dwDesiredAccess, BOOL, bOpenAsSelf, HANDLE.Ptr, phThreadToken)
    SetThreadToken(hToken)
      => ComCall(6, this.p, HANDLE, hToken)
    GetSecurityContext(eContextType1, ppSecurityContext)
      => ComCall(7, this.p, EContextType, eContextType1, IHostSecurityContext.Ptr, ppSecurityContext)
    SetSecurityContext(eContextType1, pSecurityContext)
      => ComCall(8, this.p, EContextType, eContextType1, IHostSecurityContext, pSecurityContext)
}
struct ICLRAppDomainResourceMonitor extends IUnknown {
    static IID := "{C62DE18C-2E23-4AEA-8423-B40C1FC59EAE}"
    GetCurrentAllocated(dwAppDomainId, pBytesAllocated)
      => ComCall(3, this.p, UInt32, dwAppDomainId, Int64.Ptr, pBytesAllocated)
    GetCurrentSurvived(dwAppDomainId, pAppDomainBytesSurvived, pTotalBytesSurvived)
      => ComCall(4, this.p, UInt32, dwAppDomainId, Int64.Ptr, pAppDomainBytesSurvived, Int64.Ptr, pTotalBytesSurvived)
    GetCurrentCpuTime(dwAppDomainId, pMilliseconds)
      => ComCall(5, this.p, UInt32, dwAppDomainId, Int64.Ptr, pMilliseconds)
}
struct CLRCreateInstanceFnPtr extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct CreateInterfaceFnPtr extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct CallbackThreadSetFnPtr extends FunctionPointer {
    static Types := [HRESULT]
}
struct CallbackThreadUnsetFnPtr extends FunctionPointer {
    static Types := [HRESULT]
}
struct RuntimeLoadedCallbackFnPtr extends FunctionPointer {
    static Types := [ICLRRuntimeInfo, CallbackThreadSetFnPtr, CallbackThreadUnsetFnPtr, "Void"]
}
struct ICLRMetaHost extends IUnknown {
    static IID := "{D332DB9E-B9B3-4125-8207-A14884F53216}"
    GetRuntime(pwzVersion, riid, ppRuntime)
      => ComCall(3, this.p, "Str", pwzVersion, GUID.Ptr, riid, Struct.Ptr.Ptr, ppRuntime)
    GetVersionFromFile(pwzFilePath, pwzBuffer)
      => ComCall(4, this.p, "Str", pwzFilePath, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
    EnumerateInstalledRuntimes(ppEnumerator)
      => ComCall(5, this.p, IEnumUnknown.Ptr, ppEnumerator)
    EnumerateLoadedRuntimes(hndProcess, ppEnumerator)
      => ComCall(6, this.p, HANDLE, hndProcess, IEnumUnknown.Ptr, ppEnumerator)
    RequestRuntimeLoadedNotification(pCallbackFunction)
      => ComCall(7, this.p, RuntimeLoadedCallbackFnPtr, pCallbackFunction)
    QueryLegacyV2RuntimeBinding(riid, ppUnk)
      => ComCall(8, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    ExitProcess(iExitCode)
      => ComCall(9, this.p, Int32, iExitCode)
}
struct METAHOST_POLICY_FLAGS extends Int32 {
    static METAHOST_POLICY_HIGHCOMPAT := 0
    static METAHOST_POLICY_APPLY_UPGRADE_POLICY := 8
    static METAHOST_POLICY_EMULATE_EXE_LAUNCH := 16
    static METAHOST_POLICY_SHOW_ERROR_DIALOG := 32
    static METAHOST_POLICY_USE_PROCESS_IMAGE_PATH := 64
    static METAHOST_POLICY_ENSURE_SKU_SUPPORTED := 128
    static METAHOST_POLICY_IGNORE_ERROR_MODE := 4096
}
struct METAHOST_CONFIG_FLAGS extends Int32 {
    static METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_UNSET := 0
    static METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_TRUE := 1
    static METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_FALSE := 2
    static METAHOST_CONFIG_FLAGS_LEGACY_V2_ACTIVATION_POLICY_MASK := 3
}
struct ICLRMetaHostPolicy extends IUnknown {
    static IID := "{E2190695-77B2-492E-8E14-C4B3A7FDD593}"
    GetRequestedRuntime(dwPolicyFlags, pwzBinary, pCfgStream, pwzVersion?, pwzImageVersion?, pdwConfigFlags, riid, ppRuntime)
      => ComCall(3, this.p, METAHOST_POLICY_FLAGS, dwPolicyFlags, "Str", pwzBinary, IStream, pCfgStream, PWSTR, pwzVersion?, UInt32.Ptr, pwzVersion?.Length ?? 0, PWSTR, pwzImageVersion?, UInt32.Ptr, pwzImageVersion?.Length ?? 0, UInt32.Ptr, pdwConfigFlags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppRuntime)
}
struct ICLRProfiling extends IUnknown {
    static IID := "{B349ABE3-B56F-4689-BFCD-76BF39D888EA}"
    AttachProfiler(dwProfileeProcessID, dwMillisecondsMax, pClsidProfiler, wszProfilerPath, pvClientData)
      => ComCall(3, this.p, UInt32, dwProfileeProcessID, UInt32, dwMillisecondsMax, GUID.Ptr, pClsidProfiler, "Str", wszProfilerPath, Struct.Ptr, pvClientData, UInt32, pvClientData.Length)
}
struct CLR_DEBUGGING_VERSION {
    wStructVersion : UInt16
    wMajor : UInt16
    wMinor : UInt16
    wBuild : UInt16
    wRevision : UInt16
}
struct CLR_DEBUGGING_PROCESS_FLAGS extends Int32 {
    static CLR_DEBUGGING_MANAGED_EVENT_PENDING := 1
    static CLR_DEBUGGING_MANAGED_EVENT_DEBUGGER_LAUNCH := 2
}
struct ICLRDebuggingLibraryProvider extends IUnknown {
    static IID := "{3151C08D-4D09-4F9B-8838-2880BF18FE51}"
    ProvideLibrary(pwszFileName, dwTimestamp, dwSizeOfImage, phModule)
      => ComCall(3, this.p, "Str", pwszFileName, UInt32, dwTimestamp, UInt32, dwSizeOfImage, HMODULE.Ptr, phModule)
}
struct ICLRDebugging extends IUnknown {
    static IID := "{D28F3C5A-9634-4206-A509-477552EEFB10}"
    OpenVirtualProcess(moduleBaseAddress, pDataTarget, pLibraryProvider, pMaxDebuggerSupportedVersion, riidProcess, ppProcess, pVersion, pdwFlags)
      => ComCall(3, this.p, Int64, moduleBaseAddress, IUnknown, pDataTarget, ICLRDebuggingLibraryProvider, pLibraryProvider, CLR_DEBUGGING_VERSION.Ptr, pMaxDebuggerSupportedVersion, GUID.Ptr, riidProcess, IUnknown.Ptr, ppProcess, CLR_DEBUGGING_VERSION.Ptr, pVersion, CLR_DEBUGGING_PROCESS_FLAGS.Ptr, pdwFlags)
    CanUnloadNow(hModule1)
      => ComCall(4, this.p, HMODULE, hModule1)
}
struct ICLRRuntimeInfo extends IUnknown {
    static IID := "{BD39D1D2-BA2F-486A-89B0-B4B0CB466891}"
    GetVersionString(pwzBuffer?)
      => ComCall(3, this.p, PWSTR, pwzBuffer?, UInt32.Ptr, pwzBuffer?.Length ?? 0)
    GetRuntimeDirectory(pwzBuffer)
      => ComCall(4, this.p, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length)
    IsLoaded(hndProcess, pbLoaded)
      => ComCall(5, this.p, HANDLE, hndProcess, BOOL.Ptr, pbLoaded)
    LoadErrorString(iResourceID, pwzBuffer, iLocaleID)
      => ComCall(6, this.p, UInt32, iResourceID, PWSTR, pwzBuffer, UInt32.Ptr, pwzBuffer.Length, Int32, iLocaleID)
    LoadLibraryA(pwzDllName, phndModule)
      => ComCall(7, this.p, "Str", pwzDllName, HMODULE.Ptr, phndModule)
    GetProcAddress(pszProcName, ppProc)
      => ComCall(8, this.p, PSTR, pszProcName, Struct.Ptr.Ptr, ppProc)
    GetInterface(rclsid, riid, ppUnk)
      => ComCall(9, this.p, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    IsLoadable(pbLoadable)
      => ComCall(10, this.p, BOOL.Ptr, pbLoadable)
    SetDefaultStartupFlags(dwStartupFlags, pwzHostConfigFile)
      => ComCall(11, this.p, UInt32, dwStartupFlags, "Str", pwzHostConfigFile)
    GetDefaultStartupFlags(pdwStartupFlags, pwzHostConfigFile?)
      => ComCall(12, this.p, UInt32.Ptr, pdwStartupFlags, PWSTR, pwzHostConfigFile?, UInt32.Ptr, pwzHostConfigFile?.Length ?? 0)
    BindAsLegacyV2Runtime()
      => ComCall(13, this.p)
    IsStarted(pbStarted, pdwStartupFlags)
      => ComCall(14, this.p, BOOL.Ptr, pbStarted, UInt32.Ptr, pdwStartupFlags)
}
struct ICLRStrongName extends IUnknown {
    static IID := "{9FD93CCF-3280-4391-B3A9-96E1CDE77C8D}"
    GetHashFromAssemblyFile(pszFilePath, piHashAlg, pbHash, pchHash)
      => ComCall(3, this.p, PSTR, pszFilePath, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    GetHashFromAssemblyFileW(pwzFilePath, piHashAlg, pbHash, pchHash)
      => ComCall(4, this.p, "Str", pwzFilePath, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    GetHashFromBlob(pbBlob, cchBlob, piHashAlg, pbHash, pchHash)
      => ComCall(5, this.p, UInt8.Ptr, pbBlob, UInt32, cchBlob, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    GetHashFromFile(pszFilePath, piHashAlg, pbHash, pchHash)
      => ComCall(6, this.p, PSTR, pszFilePath, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    GetHashFromFileW(pwzFilePath, piHashAlg, pbHash, pchHash)
      => ComCall(7, this.p, "Str", pwzFilePath, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    GetHashFromHandle(hFile, piHashAlg, pbHash, pchHash)
      => ComCall(8, this.p, HANDLE, hFile, UInt32.Ptr, piHashAlg, UInt8.Ptr, pbHash, UInt32, pbHash.Length, UInt32.Ptr, pchHash)
    StrongNameCompareAssemblies(pwzAssembly1, pwzAssembly2, pdwResult)
      => ComCall(9, this.p, "Str", pwzAssembly1, "Str", pwzAssembly2, UInt32.Ptr, pdwResult)
    StrongNameFreeBuffer(pbMemory)
      => ComCall(10, this.p, UInt8.Ptr, pbMemory)
    StrongNameGetBlob(pwzFilePath, pbBlob)
      => ComCall(11, this.p, "Str", pwzFilePath, UInt8.Ptr, pbBlob, UInt32.Ptr, pbBlob.Length)
    StrongNameGetBlobFromImage(pbBase, pbBlob)
      => ComCall(12, this.p, UInt8.Ptr, pbBase, UInt32, pbBase.Length, UInt8.Ptr, pbBlob, UInt32.Ptr, pbBlob.Length)
    StrongNameGetPublicKey(pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbPublicKeyBlob, pcbPublicKeyBlob)
      => ComCall(13, this.p, "Str", pwzKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, cbKeyBlob, UInt8.Ptr.Ptr, ppbPublicKeyBlob, UInt32.Ptr, pcbPublicKeyBlob)
    StrongNameHashSize(ulHashAlg, pcbSize)
      => ComCall(14, this.p, UInt32, ulHashAlg, UInt32.Ptr, pcbSize)
    StrongNameKeyDelete(pwzKeyContainer)
      => ComCall(15, this.p, "Str", pwzKeyContainer)
    StrongNameKeyGen(pwzKeyContainer, dwFlags, ppbKeyBlob, pcbKeyBlob)
      => ComCall(16, this.p, "Str", pwzKeyContainer, UInt32, dwFlags, UInt8.Ptr.Ptr, ppbKeyBlob, UInt32.Ptr, pcbKeyBlob)
    StrongNameKeyGenEx(pwzKeyContainer, dwFlags, dwKeySize, ppbKeyBlob, pcbKeyBlob)
      => ComCall(17, this.p, "Str", pwzKeyContainer, UInt32, dwFlags, UInt32, dwKeySize, UInt8.Ptr.Ptr, ppbKeyBlob, UInt32.Ptr, pcbKeyBlob)
    StrongNameKeyInstall(pwzKeyContainer, pbKeyBlob, cbKeyBlob)
      => ComCall(18, this.p, "Str", pwzKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, cbKeyBlob)
    StrongNameSignatureGeneration(pwzFilePath, pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbSignatureBlob, pcbSignatureBlob)
      => ComCall(19, this.p, "Str", pwzFilePath, "Str", pwzKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, cbKeyBlob, UInt8.Ptr.Ptr, ppbSignatureBlob, UInt32.Ptr, pcbSignatureBlob)
    StrongNameSignatureGenerationEx(wszFilePath, wszKeyContainer, pbKeyBlob, cbKeyBlob, ppbSignatureBlob, pcbSignatureBlob, dwFlags)
      => ComCall(20, this.p, "Str", wszFilePath, "Str", wszKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, cbKeyBlob, UInt8.Ptr.Ptr, ppbSignatureBlob, UInt32.Ptr, pcbSignatureBlob, UInt32, dwFlags)
    StrongNameSignatureSize(pbPublicKeyBlob, cbPublicKeyBlob, pcbSize)
      => ComCall(21, this.p, UInt8.Ptr, pbPublicKeyBlob, UInt32, cbPublicKeyBlob, UInt32.Ptr, pcbSize)
    StrongNameSignatureVerification(pwzFilePath, dwInFlags, pdwOutFlags)
      => ComCall(22, this.p, "Str", pwzFilePath, UInt32, dwInFlags, UInt32.Ptr, pdwOutFlags)
    StrongNameSignatureVerificationEx(pwzFilePath, fForceVerification, pfWasVerified)
      => ComCall(23, this.p, "Str", pwzFilePath, BOOLEAN, fForceVerification, UInt8.Ptr, pfWasVerified)
    StrongNameSignatureVerificationFromImage(pbBase, dwLength, dwInFlags, pdwOutFlags)
      => ComCall(24, this.p, UInt8.Ptr, pbBase, UInt32, dwLength, UInt32, dwInFlags, UInt32.Ptr, pdwOutFlags)
    StrongNameTokenFromAssembly(pwzFilePath, ppbStrongNameToken, pcbStrongNameToken)
      => ComCall(25, this.p, "Str", pwzFilePath, UInt8.Ptr.Ptr, ppbStrongNameToken, UInt32.Ptr, pcbStrongNameToken)
    StrongNameTokenFromAssemblyEx(pwzFilePath, ppbStrongNameToken, pcbStrongNameToken, ppbPublicKeyBlob, pcbPublicKeyBlob)
      => ComCall(26, this.p, "Str", pwzFilePath, UInt8.Ptr.Ptr, ppbStrongNameToken, UInt32.Ptr, pcbStrongNameToken, UInt8.Ptr.Ptr, ppbPublicKeyBlob, UInt32.Ptr, pcbPublicKeyBlob)
    StrongNameTokenFromPublicKey(pbPublicKeyBlob, cbPublicKeyBlob, ppbStrongNameToken, pcbStrongNameToken)
      => ComCall(27, this.p, UInt8.Ptr, pbPublicKeyBlob, UInt32, cbPublicKeyBlob, UInt8.Ptr.Ptr, ppbStrongNameToken, UInt32.Ptr, pcbStrongNameToken)
}
struct ICLRStrongName2 extends IUnknown {
    static IID := "{C22ED5C5-4B59-4975-90EB-85EA55C0069B}"
    StrongNameGetPublicKeyEx(pwzKeyContainer, pbKeyBlob, cbKeyBlob, ppbPublicKeyBlob, pcbPublicKeyBlob, uHashAlgId, uReserved)
      => ComCall(3, this.p, "Str", pwzKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, cbKeyBlob, UInt8.Ptr.Ptr, ppbPublicKeyBlob, UInt32.Ptr, pcbPublicKeyBlob, UInt32, uHashAlgId, UInt32, uReserved)
    StrongNameSignatureVerificationEx2(wszFilePath, fForceVerification, pbEcmaPublicKey, cbEcmaPublicKey, pfWasVerified)
      => ComCall(4, this.p, "Str", wszFilePath, BOOLEAN, fForceVerification, UInt8.Ptr, pbEcmaPublicKey, UInt32, cbEcmaPublicKey, UInt8.Ptr, pfWasVerified)
}
struct ICLRStrongName3 extends IUnknown {
    static IID := "{22C7089B-BBD3-414A-B698-210F263F1FED}"
    StrongNameDigestGenerate(wszFilePath, ppbDigestBlob, pcbDigestBlob, dwFlags)
      => ComCall(3, this.p, "Str", wszFilePath, UInt8.Ptr.Ptr, ppbDigestBlob, UInt32.Ptr, pcbDigestBlob, UInt32, dwFlags)
    StrongNameDigestSign(wszKeyContainer, pbKeyBlob, pbDigestBlob, hashAlgId, ppbSignatureBlob, pcbSignatureBlob, dwFlags)
      => ComCall(4, this.p, "Str", wszKeyContainer, UInt8.Ptr, pbKeyBlob, UInt32, pbKeyBlob.Length, UInt8.Ptr, pbDigestBlob, UInt32, pbDigestBlob.Length, UInt32, hashAlgId, UInt8.Ptr.Ptr, ppbSignatureBlob, UInt32.Ptr, pcbSignatureBlob, UInt32, dwFlags)
    StrongNameDigestEmbed(wszFilePath, pbSignatureBlob)
      => ComCall(5, this.p, "Str", wszFilePath, UInt8.Ptr, pbSignatureBlob, UInt32, pbSignatureBlob.Length)
}
