#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT.Metadata\Types.ahk" {ASSEMBLYMETADATA, COR_FIELD_OFFSET, CorElementType}

struct COR_IL_MAP {
    oldOffset : UInt32
    newOffset : UInt32
    fAccurate : BOOL
}
struct CorDebugIlToNativeMappingTypes extends Int32 {
    static NO_MAPPING := -1
    static PROLOG := -2
    static EPILOG := -3
}
struct COR_DEBUG_IL_TO_NATIVE_MAP {
    ilOffset : UInt32
    nativeStartOffset : UInt32
    nativeEndOffset : UInt32
}
struct FunctionIDOrClientID {
    union {
        functionID : IntPtr
        clientID : IntPtr
    }
}
struct FunctionIDMapper extends FunctionPointer {
    static Types := [IntPtr, BOOL.Ptr, IntPtr]
}
struct FunctionIDMapper2 extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, BOOL.Ptr, IntPtr]
}
struct COR_PRF_SNAPSHOT_INFO extends Int32 {
    static COR_PRF_SNAPSHOT_DEFAULT := 0
    static COR_PRF_SNAPSHOT_REGISTER_CONTEXT := 1
    static COR_PRF_SNAPSHOT_X86_OPTIMIZED := 2
}
struct COR_PRF_FUNCTION_ARGUMENT_RANGE {
    startAddress : IntPtr
    length : UInt32
}
struct COR_PRF_FUNCTION_ARGUMENT_INFO {
    numRanges : UInt32
    totalArgumentSize : UInt32
    ranges : COR_PRF_FUNCTION_ARGUMENT_RANGE[1]
}
struct COR_PRF_CODE_INFO {
    startAddress : IntPtr
    size : IntPtr
}
struct COR_PRF_STATIC_TYPE extends Int32 {
    static COR_PRF_FIELD_NOT_A_STATIC := 0
    static COR_PRF_FIELD_APP_DOMAIN_STATIC := 1
    static COR_PRF_FIELD_THREAD_STATIC := 2
    static COR_PRF_FIELD_CONTEXT_STATIC := 4
    static COR_PRF_FIELD_RVA_STATIC := 8
}
struct COR_PRF_FUNCTION {
    functionId : IntPtr
    reJitId : IntPtr
}
struct COR_PRF_ASSEMBLY_REFERENCE_INFO {
    pbPublicKeyOrToken : Struct.Ptr
    cbPublicKeyOrToken : UInt32
    szName : PWSTR
    pMetaData : ASSEMBLYMETADATA.Ptr
    pbHashValue : Struct.Ptr
    cbHashValue : UInt32
    dwAssemblyRefFlags : UInt32
}
struct COR_PRF_METHOD {
    moduleId : IntPtr
    methodId : UInt32
}
struct FunctionEnter extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct FunctionLeave extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct FunctionTailcall extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct FunctionEnter2 extends FunctionPointer {
    static Types := [IntPtr, IntPtr, IntPtr, COR_PRF_FUNCTION_ARGUMENT_INFO.Ptr, "Void"]
}
struct FunctionLeave2 extends FunctionPointer {
    static Types := [IntPtr, IntPtr, IntPtr, COR_PRF_FUNCTION_ARGUMENT_RANGE.Ptr, "Void"]
}
struct FunctionTailcall2 extends FunctionPointer {
    static Types := [IntPtr, IntPtr, IntPtr, "Void"]
}
struct FunctionEnter3 extends FunctionPointer {
    static Types := [FunctionIDOrClientID, "Void"]
}
struct FunctionLeave3 extends FunctionPointer {
    static Types := [FunctionIDOrClientID, "Void"]
}
struct FunctionTailcall3 extends FunctionPointer {
    static Types := [FunctionIDOrClientID, "Void"]
}
struct FunctionEnter3WithInfo extends FunctionPointer {
    static Types := [FunctionIDOrClientID, IntPtr, "Void"]
}
struct FunctionLeave3WithInfo extends FunctionPointer {
    static Types := [FunctionIDOrClientID, IntPtr, "Void"]
}
struct FunctionTailcall3WithInfo extends FunctionPointer {
    static Types := [FunctionIDOrClientID, IntPtr, "Void"]
}
struct StackSnapshotCallback extends FunctionPointer {
    static Types := [IntPtr, IntPtr, IntPtr, UInt32, UInt8.Ptr, Struct.Ptr, HRESULT]
}
struct ObjectReferenceCallback extends FunctionPointer {
    static Types := [IntPtr, IntPtr.Ptr, Struct.Ptr, BOOL]
}
struct COR_PRF_MONITOR extends Int32 {
    static COR_PRF_MONITOR_NONE := 0
    static COR_PRF_MONITOR_FUNCTION_UNLOADS := 1
    static COR_PRF_MONITOR_CLASS_LOADS := 2
    static COR_PRF_MONITOR_MODULE_LOADS := 4
    static COR_PRF_MONITOR_ASSEMBLY_LOADS := 8
    static COR_PRF_MONITOR_APPDOMAIN_LOADS := 16
    static COR_PRF_MONITOR_JIT_COMPILATION := 32
    static COR_PRF_MONITOR_EXCEPTIONS := 64
    static COR_PRF_MONITOR_GC := 128
    static COR_PRF_MONITOR_OBJECT_ALLOCATED := 256
    static COR_PRF_MONITOR_THREADS := 512
    static COR_PRF_MONITOR_REMOTING := 1024
    static COR_PRF_MONITOR_CODE_TRANSITIONS := 2048
    static COR_PRF_MONITOR_ENTERLEAVE := 4096
    static COR_PRF_MONITOR_CCW := 8192
    static COR_PRF_MONITOR_REMOTING_COOKIE := 17408
    static COR_PRF_MONITOR_REMOTING_ASYNC := 33792
    static COR_PRF_MONITOR_SUSPENDS := 65536
    static COR_PRF_MONITOR_CACHE_SEARCHES := 131072
    static COR_PRF_ENABLE_REJIT := 262144
    static COR_PRF_ENABLE_INPROC_DEBUGGING := 524288
    static COR_PRF_ENABLE_JIT_MAPS := 1048576
    static COR_PRF_DISABLE_INLINING := 2097152
    static COR_PRF_DISABLE_OPTIMIZATIONS := 4194304
    static COR_PRF_ENABLE_OBJECT_ALLOCATED := 8388608
    static COR_PRF_MONITOR_CLR_EXCEPTIONS := 16777216
    static COR_PRF_MONITOR_ALL := 17301503
    static COR_PRF_ENABLE_FUNCTION_ARGS := 33554432
    static COR_PRF_ENABLE_FUNCTION_RETVAL := 67108864
    static COR_PRF_ENABLE_FRAME_INFO := 134217728
    static COR_PRF_ENABLE_STACK_SNAPSHOT := 268435456
    static COR_PRF_USE_PROFILE_IMAGES := 536870912
    static COR_PRF_DISABLE_TRANSPARENCY_CHECKS_UNDER_FULL_TRUST := 1073741824
    static COR_PRF_DISABLE_ALL_NGEN_IMAGES := -2147483648
    static COR_PRF_ALL := -1879048193
    static COR_PRF_REQUIRE_PROFILE_IMAGE := 536877056
    static COR_PRF_ALLOWABLE_AFTER_ATTACH := 268763902
    static COR_PRF_ALLOWABLE_NOTIFICATION_PROFILER := -1310512257
    static COR_PRF_MONITOR_IMMUTABLE := -285684736
}
struct COR_PRF_HIGH_MONITOR extends Int32 {
    static COR_PRF_HIGH_MONITOR_NONE := 0
    static COR_PRF_HIGH_ADD_ASSEMBLY_REFERENCES := 1
    static COR_PRF_HIGH_IN_MEMORY_SYMBOLS_UPDATED := 2
    static COR_PRF_HIGH_MONITOR_DYNAMIC_FUNCTION_UNLOADS := 4
    static COR_PRF_HIGH_DISABLE_TIERED_COMPILATION := 8
    static COR_PRF_HIGH_BASIC_GC := 16
    static COR_PRF_HIGH_MONITOR_GC_MOVED_OBJECTS := 32
    static COR_PRF_HIGH_REQUIRE_PROFILE_IMAGE := 0
    static COR_PRF_HIGH_MONITOR_LARGEOBJECT_ALLOCATED := 64
    static COR_PRF_HIGH_MONITOR_EVENT_PIPE := 128
    static COR_PRF_HIGH_MONITOR_PINNEDOBJECT_ALLOCATED := 256
    static COR_PRF_HIGH_ALLOWABLE_AFTER_ATTACH := 246
    static COR_PRF_HIGH_ALLOWABLE_NOTIFICATION_PROFILER := 254
    static COR_PRF_HIGH_MONITOR_IMMUTABLE := 8
}
struct COR_PRF_MISC extends Int32 {
    static PROFILER_PARENT_UNKNOWN := -3
    static PROFILER_GLOBAL_CLASS := -2
    static PROFILER_GLOBAL_MODULE := -1
}
struct COR_PRF_JIT_CACHE extends Int32 {
    static COR_PRF_CACHED_FUNCTION_FOUND := 0
    static COR_PRF_CACHED_FUNCTION_NOT_FOUND := 1
}
struct COR_PRF_TRANSITION_REASON extends Int32 {
    static COR_PRF_TRANSITION_CALL := 0
    static COR_PRF_TRANSITION_RETURN := 1
}
struct COR_PRF_SUSPEND_REASON extends Int32 {
    static COR_PRF_SUSPEND_OTHER := 0
    static COR_PRF_SUSPEND_FOR_GC := 1
    static COR_PRF_SUSPEND_FOR_APPDOMAIN_SHUTDOWN := 2
    static COR_PRF_SUSPEND_FOR_CODE_PITCHING := 3
    static COR_PRF_SUSPEND_FOR_SHUTDOWN := 4
    static COR_PRF_SUSPEND_FOR_INPROC_DEBUGGER := 6
    static COR_PRF_SUSPEND_FOR_GC_PREP := 7
    static COR_PRF_SUSPEND_FOR_REJIT := 8
    static COR_PRF_SUSPEND_FOR_PROFILER := 9
}
struct COR_PRF_RUNTIME_TYPE extends Int32 {
    static COR_PRF_DESKTOP_CLR := 1
    static COR_PRF_CORE_CLR := 2
}
struct COR_PRF_REJIT_FLAGS extends Int32 {
    static COR_PRF_REJIT_BLOCK_INLINING := 1
    static COR_PRF_REJIT_INLINING_CALLBACKS := 2
}
struct COR_PRF_EVENTPIPE_PARAM_TYPE extends Int32 {
    static COR_PRF_EVENTPIPE_OBJECT := 1
    static COR_PRF_EVENTPIPE_BOOLEAN := 3
    static COR_PRF_EVENTPIPE_CHAR := 4
    static COR_PRF_EVENTPIPE_SBYTE := 5
    static COR_PRF_EVENTPIPE_BYTE := 6
    static COR_PRF_EVENTPIPE_INT16 := 7
    static COR_PRF_EVENTPIPE_UINT16 := 8
    static COR_PRF_EVENTPIPE_INT32 := 9
    static COR_PRF_EVENTPIPE_UINT32 := 10
    static COR_PRF_EVENTPIPE_INT64 := 11
    static COR_PRF_EVENTPIPE_UINT64 := 12
    static COR_PRF_EVENTPIPE_SINGLE := 13
    static COR_PRF_EVENTPIPE_DOUBLE := 14
    static COR_PRF_EVENTPIPE_DECIMAL := 15
    static COR_PRF_EVENTPIPE_DATETIME := 16
    static COR_PRF_EVENTPIPE_GUID := 17
    static COR_PRF_EVENTPIPE_STRING := 18
    static COR_PRF_EVENTPIPE_ARRAY := 19
}
struct COR_PRF_EVENTPIPE_LEVEL extends Int32 {
    static COR_PRF_EVENTPIPE_LOGALWAYS := 0
    static COR_PRF_EVENTPIPE_CRITICAL := 1
    static COR_PRF_EVENTPIPE_ERROR := 2
    static COR_PRF_EVENTPIPE_WARNING := 3
    static COR_PRF_EVENTPIPE_INFORMATIONAL := 4
    static COR_PRF_EVENTPIPE_VERBOSE := 5
}
struct COR_PRF_EVENTPIPE_PROVIDER_CONFIG {
    providerName : PWSTR
    keywords : Int64
    loggingLevel : UInt32
    filterData : PWSTR
}
struct COR_PRF_EVENTPIPE_PARAM_DESC {
    type : UInt32
    elementType : UInt32
    name : PWSTR
}
struct COR_PRF_EVENT_DATA {
    ptr : Int64
    size : UInt32
    reserved : UInt32
}
struct COR_PRF_FILTER_DATA {
    Ptr : Int64
    Size : UInt32
    Type : UInt32
}
struct EventPipeProviderCallback extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, UInt8, Int64, Int64, COR_PRF_FILTER_DATA.Ptr, Struct.Ptr, "Void"]
}
struct COR_PRF_HANDLE_TYPE extends Int32 {
    static COR_PRF_HANDLE_TYPE_WEAK := 1
    static COR_PRF_HANDLE_TYPE_STRONG := 2
    static COR_PRF_HANDLE_TYPE_PINNED := 3
}
struct ICorProfilerCallback extends IUnknown {
    static IID := "{176FBED1-A55C-4796-98CA-A9DA0EF883E7}"
    Initialize(pICorProfilerInfoUnk)
      => ComCall(3, this.p, IUnknown, pICorProfilerInfoUnk)
    Shutdown()
      => ComCall(4, this.p)
    AppDomainCreationStarted(appDomainId)
      => ComCall(5, this.p, IntPtr, appDomainId)
    AppDomainCreationFinished(appDomainId, hrStatus)
      => ComCall(6, this.p, IntPtr, appDomainId, HRESULT, hrStatus)
    AppDomainShutdownStarted(appDomainId)
      => ComCall(7, this.p, IntPtr, appDomainId)
    AppDomainShutdownFinished(appDomainId, hrStatus)
      => ComCall(8, this.p, IntPtr, appDomainId, HRESULT, hrStatus)
    AssemblyLoadStarted(assemblyId)
      => ComCall(9, this.p, IntPtr, assemblyId)
    AssemblyLoadFinished(assemblyId, hrStatus)
      => ComCall(10, this.p, IntPtr, assemblyId, HRESULT, hrStatus)
    AssemblyUnloadStarted(assemblyId)
      => ComCall(11, this.p, IntPtr, assemblyId)
    AssemblyUnloadFinished(assemblyId, hrStatus)
      => ComCall(12, this.p, IntPtr, assemblyId, HRESULT, hrStatus)
    ModuleLoadStarted(moduleId)
      => ComCall(13, this.p, IntPtr, moduleId)
    ModuleLoadFinished(moduleId, hrStatus)
      => ComCall(14, this.p, IntPtr, moduleId, HRESULT, hrStatus)
    ModuleUnloadStarted(moduleId)
      => ComCall(15, this.p, IntPtr, moduleId)
    ModuleUnloadFinished(moduleId, hrStatus)
      => ComCall(16, this.p, IntPtr, moduleId, HRESULT, hrStatus)
    ModuleAttachedToAssembly(moduleId, AssemblyId)
      => ComCall(17, this.p, IntPtr, moduleId, IntPtr, AssemblyId)
    ClassLoadStarted(classId)
      => ComCall(18, this.p, IntPtr, classId)
    ClassLoadFinished(classId, hrStatus)
      => ComCall(19, this.p, IntPtr, classId, HRESULT, hrStatus)
    ClassUnloadStarted(classId)
      => ComCall(20, this.p, IntPtr, classId)
    ClassUnloadFinished(classId, hrStatus)
      => ComCall(21, this.p, IntPtr, classId, HRESULT, hrStatus)
    FunctionUnloadStarted(functionId)
      => ComCall(22, this.p, IntPtr, functionId)
    JITCompilationStarted(functionId, fIsSafeToBlock)
      => ComCall(23, this.p, IntPtr, functionId, BOOL, fIsSafeToBlock)
    JITCompilationFinished(functionId, hrStatus, fIsSafeToBlock)
      => ComCall(24, this.p, IntPtr, functionId, HRESULT, hrStatus, BOOL, fIsSafeToBlock)
    JITCachedFunctionSearchStarted(functionId, pbUseCachedFunction)
      => ComCall(25, this.p, IntPtr, functionId, BOOL.Ptr, pbUseCachedFunction)
    JITCachedFunctionSearchFinished(functionId, result)
      => ComCall(26, this.p, IntPtr, functionId, COR_PRF_JIT_CACHE, result)
    JITFunctionPitched(functionId)
      => ComCall(27, this.p, IntPtr, functionId)
    JITInlining(callerId, calleeId, pfShouldInline)
      => ComCall(28, this.p, IntPtr, callerId, IntPtr, calleeId, BOOL.Ptr, pfShouldInline)
    ThreadCreated(threadId)
      => ComCall(29, this.p, IntPtr, threadId)
    ThreadDestroyed(threadId)
      => ComCall(30, this.p, IntPtr, threadId)
    ThreadAssignedToOSThread(managedThreadId, osThreadId)
      => ComCall(31, this.p, IntPtr, managedThreadId, UInt32, osThreadId)
    RemotingClientInvocationStarted()
      => ComCall(32, this.p)
    RemotingClientSendingMessage(pCookie, fIsAsync)
      => ComCall(33, this.p, GUID.Ptr, pCookie, BOOL, fIsAsync)
    RemotingClientReceivingReply(pCookie, fIsAsync)
      => ComCall(34, this.p, GUID.Ptr, pCookie, BOOL, fIsAsync)
    RemotingClientInvocationFinished()
      => ComCall(35, this.p)
    RemotingServerReceivingMessage(pCookie, fIsAsync)
      => ComCall(36, this.p, GUID.Ptr, pCookie, BOOL, fIsAsync)
    RemotingServerInvocationStarted()
      => ComCall(37, this.p)
    RemotingServerInvocationReturned()
      => ComCall(38, this.p)
    RemotingServerSendingReply(pCookie, fIsAsync)
      => ComCall(39, this.p, GUID.Ptr, pCookie, BOOL, fIsAsync)
    UnmanagedToManagedTransition(functionId, reason)
      => ComCall(40, this.p, IntPtr, functionId, COR_PRF_TRANSITION_REASON, reason)
    ManagedToUnmanagedTransition(functionId, reason)
      => ComCall(41, this.p, IntPtr, functionId, COR_PRF_TRANSITION_REASON, reason)
    RuntimeSuspendStarted(suspendReason)
      => ComCall(42, this.p, COR_PRF_SUSPEND_REASON, suspendReason)
    RuntimeSuspendFinished()
      => ComCall(43, this.p)
    RuntimeSuspendAborted()
      => ComCall(44, this.p)
    RuntimeResumeStarted()
      => ComCall(45, this.p)
    RuntimeResumeFinished()
      => ComCall(46, this.p)
    RuntimeThreadSuspended(threadId)
      => ComCall(47, this.p, IntPtr, threadId)
    RuntimeThreadResumed(threadId)
      => ComCall(48, this.p, IntPtr, threadId)
    MovedReferences(oldObjectIDRangeStart, newObjectIDRangeStart, cObjectIDRangeLength)
      => ComCall(49, this.p, UInt32, cObjectIDRangeLength.Length, IntPtr.Ptr, oldObjectIDRangeStart, IntPtr.Ptr, newObjectIDRangeStart, UInt32.Ptr, cObjectIDRangeLength)
    ObjectAllocated(objectId, classId)
      => ComCall(50, this.p, IntPtr, objectId, IntPtr, classId)
    ObjectsAllocatedByClass(classIds, cObjects)
      => ComCall(51, this.p, UInt32, cObjects.Length, IntPtr.Ptr, classIds, UInt32.Ptr, cObjects)
    ObjectReferences(objectId, classId, objectRefIds)
      => ComCall(52, this.p, IntPtr, objectId, IntPtr, classId, UInt32, objectRefIds.Length, IntPtr.Ptr, objectRefIds)
    RootReferences(rootRefIds)
      => ComCall(53, this.p, UInt32, rootRefIds.Length, IntPtr.Ptr, rootRefIds)
    ExceptionThrown(thrownObjectId)
      => ComCall(54, this.p, IntPtr, thrownObjectId)
    ExceptionSearchFunctionEnter(functionId)
      => ComCall(55, this.p, IntPtr, functionId)
    ExceptionSearchFunctionLeave()
      => ComCall(56, this.p)
    ExceptionSearchFilterEnter(functionId)
      => ComCall(57, this.p, IntPtr, functionId)
    ExceptionSearchFilterLeave()
      => ComCall(58, this.p)
    ExceptionSearchCatcherFound(functionId)
      => ComCall(59, this.p, IntPtr, functionId)
    ExceptionOSHandlerEnter(__unused)
      => ComCall(60, this.p, IntPtr, __unused)
    ExceptionOSHandlerLeave(__unused)
      => ComCall(61, this.p, IntPtr, __unused)
    ExceptionUnwindFunctionEnter(functionId)
      => ComCall(62, this.p, IntPtr, functionId)
    ExceptionUnwindFunctionLeave()
      => ComCall(63, this.p)
    ExceptionUnwindFinallyEnter(functionId)
      => ComCall(64, this.p, IntPtr, functionId)
    ExceptionUnwindFinallyLeave()
      => ComCall(65, this.p)
    ExceptionCatcherEnter(functionId, objectId)
      => ComCall(66, this.p, IntPtr, functionId, IntPtr, objectId)
    ExceptionCatcherLeave()
      => ComCall(67, this.p)
    COMClassicVTableCreated(wrappedClassId, implementedIID, pVTable, cSlots)
      => ComCall(68, this.p, IntPtr, wrappedClassId, GUID.Ptr, implementedIID, Struct.Ptr, pVTable, UInt32, cSlots)
    COMClassicVTableDestroyed(wrappedClassId, implementedIID, pVTable)
      => ComCall(69, this.p, IntPtr, wrappedClassId, GUID.Ptr, implementedIID, Struct.Ptr, pVTable)
    ExceptionCLRCatcherFound()
      => ComCall(70, this.p)
    ExceptionCLRCatcherExecute()
      => ComCall(71, this.p)
}
struct COR_PRF_GC_ROOT_KIND extends Int32 {
    static COR_PRF_GC_ROOT_STACK := 1
    static COR_PRF_GC_ROOT_FINALIZER := 2
    static COR_PRF_GC_ROOT_HANDLE := 3
    static COR_PRF_GC_ROOT_OTHER := 0
}
struct COR_PRF_GC_ROOT_FLAGS extends Int32 {
    static COR_PRF_GC_ROOT_PINNING := 1
    static COR_PRF_GC_ROOT_WEAKREF := 2
    static COR_PRF_GC_ROOT_INTERIOR := 4
    static COR_PRF_GC_ROOT_REFCOUNTED := 8
}
struct COR_PRF_FINALIZER_FLAGS extends Int32 {
    static COR_PRF_FINALIZER_CRITICAL := 1
}
struct COR_PRF_GC_GENERATION extends Int32 {
    static COR_PRF_GC_GEN_0 := 0
    static COR_PRF_GC_GEN_1 := 1
    static COR_PRF_GC_GEN_2 := 2
    static COR_PRF_GC_LARGE_OBJECT_HEAP := 3
    static COR_PRF_GC_PINNED_OBJECT_HEAP := 4
}
struct COR_PRF_GC_GENERATION_RANGE {
    generation : COR_PRF_GC_GENERATION
    rangeStart : IntPtr
    rangeLength : IntPtr
    rangeLengthReserved : IntPtr
}
struct COR_PRF_NONGC_HEAP_RANGE {
    rangeStart : IntPtr
    rangeLength : IntPtr
    rangeLengthReserved : IntPtr
}
struct COR_PRF_CLAUSE_TYPE extends Int32 {
    static COR_PRF_CLAUSE_NONE := 0
    static COR_PRF_CLAUSE_FILTER := 1
    static COR_PRF_CLAUSE_CATCH := 2
    static COR_PRF_CLAUSE_FINALLY := 3
}
struct COR_PRF_EX_CLAUSE_INFO {
    clauseType : COR_PRF_CLAUSE_TYPE
    programCounter : IntPtr
    framePointer : IntPtr
    shadowStackPointer : IntPtr
}
struct COR_PRF_GC_REASON extends Int32 {
    static COR_PRF_GC_INDUCED := 1
    static COR_PRF_GC_OTHER := 0
}
struct COR_PRF_MODULE_FLAGS extends Int32 {
    static COR_PRF_MODULE_DISK := 1
    static COR_PRF_MODULE_NGEN := 2
    static COR_PRF_MODULE_DYNAMIC := 4
    static COR_PRF_MODULE_COLLECTIBLE := 8
    static COR_PRF_MODULE_RESOURCE := 16
    static COR_PRF_MODULE_FLAT_LAYOUT := 32
    static COR_PRF_MODULE_WINDOWS_RUNTIME := 64
}
struct ICorProfilerCallback2 extends ICorProfilerCallback {
    static IID := "{8A8CC829-CCF2-49FE-BBAE-0F022228071A}"
    ThreadNameChanged(threadId, name?)
      => ComCall(72, this.p, IntPtr, threadId, UInt32, name?.Length ?? 0, "Str", name?)
    GarbageCollectionStarted(generationCollected, reason)
      => ComCall(73, this.p, Int32, generationCollected.Length, BOOL.Ptr, generationCollected, COR_PRF_GC_REASON, reason)
    SurvivingReferences(objectIDRangeStart, cObjectIDRangeLength)
      => ComCall(74, this.p, UInt32, cObjectIDRangeLength.Length, IntPtr.Ptr, objectIDRangeStart, UInt32.Ptr, cObjectIDRangeLength)
    GarbageCollectionFinished()
      => ComCall(75, this.p)
    FinalizeableObjectQueued(finalizerFlags, objectID)
      => ComCall(76, this.p, UInt32, finalizerFlags, IntPtr, objectID)
    RootReferences2(rootRefIds, rootKinds, rootFlags, rootIds)
      => ComCall(77, this.p, UInt32, rootIds.Length, IntPtr.Ptr, rootRefIds, COR_PRF_GC_ROOT_KIND.Ptr, rootKinds, COR_PRF_GC_ROOT_FLAGS.Ptr, rootFlags, IntPtr.Ptr, rootIds)
    HandleCreated(handleId, initialObjectId)
      => ComCall(78, this.p, IntPtr, handleId, IntPtr, initialObjectId)
    HandleDestroyed(handleId)
      => ComCall(79, this.p, IntPtr, handleId)
}
struct ICorProfilerCallback3 extends ICorProfilerCallback2 {
    static IID := "{4FD2ED52-7731-4B8D-9469-03D2CC3086C5}"
    InitializeForAttach(pCorProfilerInfoUnk, pvClientData, cbClientData)
      => ComCall(80, this.p, IUnknown, pCorProfilerInfoUnk, Struct.Ptr, pvClientData, UInt32, cbClientData)
    ProfilerAttachComplete()
      => ComCall(81, this.p)
    ProfilerDetachSucceeded()
      => ComCall(82, this.p)
}
struct ICorProfilerCallback4 extends ICorProfilerCallback3 {
    static IID := "{7B63B2E3-107D-4D48-B2F6-F61E229470D2}"
    ReJITCompilationStarted(functionId, rejitId, fIsSafeToBlock)
      => ComCall(83, this.p, IntPtr, functionId, IntPtr, rejitId, BOOL, fIsSafeToBlock)
    GetReJITParameters(moduleId, methodId, pFunctionControl)
      => ComCall(84, this.p, IntPtr, moduleId, UInt32, methodId, ICorProfilerFunctionControl, pFunctionControl)
    ReJITCompilationFinished(functionId, rejitId, hrStatus, fIsSafeToBlock)
      => ComCall(85, this.p, IntPtr, functionId, IntPtr, rejitId, HRESULT, hrStatus, BOOL, fIsSafeToBlock)
    ReJITError(moduleId, methodId, functionId, hrStatus)
      => ComCall(86, this.p, IntPtr, moduleId, UInt32, methodId, IntPtr, functionId, HRESULT, hrStatus)
    MovedReferences2(oldObjectIDRangeStart, newObjectIDRangeStart, cObjectIDRangeLength)
      => ComCall(87, this.p, UInt32, cObjectIDRangeLength.Length, IntPtr.Ptr, oldObjectIDRangeStart, IntPtr.Ptr, newObjectIDRangeStart, IntPtr.Ptr, cObjectIDRangeLength)
    SurvivingReferences2(objectIDRangeStart, cObjectIDRangeLength)
      => ComCall(88, this.p, UInt32, cObjectIDRangeLength.Length, IntPtr.Ptr, objectIDRangeStart, IntPtr.Ptr, cObjectIDRangeLength)
}
struct ICorProfilerCallback5 extends ICorProfilerCallback4 {
    static IID := "{8DFBA405-8C9F-45F8-BFFA-83B14CEF78B5}"
    ConditionalWeakTableElementReferences(keyRefIds, valueRefIds, rootIds)
      => ComCall(89, this.p, UInt32, rootIds.Length, IntPtr.Ptr, keyRefIds, IntPtr.Ptr, valueRefIds, IntPtr.Ptr, rootIds)
}
struct ICorProfilerCallback6 extends ICorProfilerCallback5 {
    static IID := "{FC13DF4B-4448-4F4F-950C-BA8D19D00C36}"
    GetAssemblyReferences(wszAssemblyPath, pAsmRefProvider)
      => ComCall(90, this.p, "Str", wszAssemblyPath, ICorProfilerAssemblyReferenceProvider, pAsmRefProvider)
}
struct ICorProfilerCallback7 extends ICorProfilerCallback6 {
    static IID := "{F76A2DBA-1D52-4539-866C-2AA518F9EFC3}"
    ModuleInMemorySymbolsUpdated(moduleId)
      => ComCall(91, this.p, IntPtr, moduleId)
}
struct ICorProfilerCallback8 extends ICorProfilerCallback7 {
    static IID := "{5BED9B15-C079-4D47-BFE2-215A140C07E0}"
    DynamicMethodJITCompilationStarted(functionId, fIsSafeToBlock, pILHeader, cbILHeader)
      => ComCall(92, this.p, IntPtr, functionId, BOOL, fIsSafeToBlock, UInt8.Ptr, pILHeader, UInt32, cbILHeader)
    DynamicMethodJITCompilationFinished(functionId, hrStatus, fIsSafeToBlock)
      => ComCall(93, this.p, IntPtr, functionId, HRESULT, hrStatus, BOOL, fIsSafeToBlock)
}
struct ICorProfilerCallback9 extends ICorProfilerCallback8 {
    static IID := "{27583EC3-C8F5-482F-8052-194B8CE4705A}"
    DynamicMethodUnloaded(functionId)
      => ComCall(94, this.p, IntPtr, functionId)
}
struct ICorProfilerCallback10 extends ICorProfilerCallback9 {
    static IID := "{CEC5B60E-C69C-495F-87F6-84D28EE16FFB}"
    EventPipeEventDelivered(provider, eventId, eventVersion, metadataBlob, eventData, pActivityId, pRelatedActivityId, eventThread, numStackFrames, stackFrames)
      => ComCall(95, this.p, IntPtr, provider, UInt32, eventId, UInt32, eventVersion, UInt32, metadataBlob.Length, UInt8.Ptr, metadataBlob, UInt32, eventData.Length, UInt8.Ptr, eventData, GUID.Ptr, pActivityId, GUID.Ptr, pRelatedActivityId, IntPtr, eventThread, UInt32, numStackFrames, IntPtr.Ptr, stackFrames)
    EventPipeProviderCreated(provider)
      => ComCall(96, this.p, IntPtr, provider)
}
struct ICorProfilerCallback11 extends ICorProfilerCallback10 {
    static IID := "{42350846-AAED-47F7-B128-FD0C98881CDE}"
    LoadAsNotificationOnly(pbNotificationOnly)
      => ComCall(97, this.p, BOOL.Ptr, pbNotificationOnly)
}
struct COR_PRF_CODEGEN_FLAGS extends Int32 {
    static COR_PRF_CODEGEN_DISABLE_INLINING := 1
    static COR_PRF_CODEGEN_DISABLE_ALL_OPTIMIZATIONS := 2
}
struct ICorProfilerInfo extends IUnknown {
    static IID := "{28B5557D-3F3F-48B4-90B2-5F9EEA2F6C48}"
    GetClassFromObject(objectId, pClassId)
      => ComCall(3, this.p, IntPtr, objectId, IntPtr.Ptr, pClassId)
    GetClassFromToken(moduleId, typeDef, pClassId)
      => ComCall(4, this.p, IntPtr, moduleId, UInt32, typeDef, IntPtr.Ptr, pClassId)
    GetCodeInfo(functionId, pStart, pcSize)
      => ComCall(5, this.p, IntPtr, functionId, UInt8.Ptr.Ptr, pStart, UInt32.Ptr, pcSize)
    GetEventMask(pdwEvents)
      => ComCall(6, this.p, UInt32.Ptr, pdwEvents)
    GetFunctionFromIP(ip, pFunctionId)
      => ComCall(7, this.p, UInt8.Ptr, ip, IntPtr.Ptr, pFunctionId)
    GetFunctionFromToken(moduleId, token, pFunctionId)
      => ComCall(8, this.p, IntPtr, moduleId, UInt32, token, IntPtr.Ptr, pFunctionId)
    GetHandleFromThread(threadId, phThread)
      => ComCall(9, this.p, IntPtr, threadId, HANDLE.Ptr, phThread)
    GetObjectSize(objectId, pcSize)
      => ComCall(10, this.p, IntPtr, objectId, UInt32.Ptr, pcSize)
    IsArrayClass(classId, pBaseElemType, pBaseClassId, pcRank)
      => ComCall(11, this.p, IntPtr, classId, CorElementType.Ptr, pBaseElemType, IntPtr.Ptr, pBaseClassId, UInt32.Ptr, pcRank)
    GetThreadInfo(threadId, pdwWin32ThreadId)
      => ComCall(12, this.p, IntPtr, threadId, UInt32.Ptr, pdwWin32ThreadId)
    GetCurrentThreadID(pThreadId)
      => ComCall(13, this.p, IntPtr.Ptr, pThreadId)
    GetClassIDInfo(classId, pModuleId, pTypeDefToken)
      => ComCall(14, this.p, IntPtr, classId, IntPtr.Ptr, pModuleId, UInt32.Ptr, pTypeDefToken)
    GetFunctionInfo(functionId, pClassId, pModuleId, pToken)
      => ComCall(15, this.p, IntPtr, functionId, IntPtr.Ptr, pClassId, IntPtr.Ptr, pModuleId, UInt32.Ptr, pToken)
    SetEventMask(dwEvents)
      => ComCall(16, this.p, UInt32, dwEvents)
    SetEnterLeaveFunctionHooks(pFuncEnter, pFuncLeave, pFuncTailcall)
      => ComCall(17, this.p, FunctionEnter.Ptr, pFuncEnter, FunctionLeave.Ptr, pFuncLeave, FunctionTailcall.Ptr, pFuncTailcall)
    SetFunctionIDMapper(pFunc)
      => ComCall(18, this.p, FunctionIDMapper.Ptr, pFunc)
    GetTokenAndMetaDataFromFunction(functionId, riid, ppImport, pToken)
      => ComCall(19, this.p, IntPtr, functionId, GUID.Ptr, riid, IUnknown.Ptr, ppImport, UInt32.Ptr, pToken)
    GetModuleInfo(moduleId, ppBaseLoadAddress, pcchName, szName, pAssemblyId)
      => ComCall(20, this.p, IntPtr, moduleId, UInt8.Ptr.Ptr, ppBaseLoadAddress, UInt32, szName.Length, UInt32.Ptr, pcchName, PWSTR, szName, IntPtr.Ptr, pAssemblyId)
    GetModuleMetaData(moduleId, dwOpenFlags, riid, ppOut)
      => ComCall(21, this.p, IntPtr, moduleId, UInt32, dwOpenFlags, GUID.Ptr, riid, IUnknown.Ptr, ppOut)
    GetILFunctionBody(moduleId, methodId, ppMethodHeader, pcbMethodSize)
      => ComCall(22, this.p, IntPtr, moduleId, UInt32, methodId, UInt8.Ptr.Ptr, ppMethodHeader, UInt32.Ptr, pcbMethodSize)
    GetILFunctionBodyAllocator(moduleId, ppMalloc)
      => ComCall(23, this.p, IntPtr, moduleId, IMethodMalloc.Ptr, ppMalloc)
    SetILFunctionBody(moduleId, methodid, pbNewILMethodHeader)
      => ComCall(24, this.p, IntPtr, moduleId, UInt32, methodid, UInt8.Ptr, pbNewILMethodHeader)
    GetAppDomainInfo(appDomainId, pcchName, szName, pProcessId)
      => ComCall(25, this.p, IntPtr, appDomainId, UInt32, szName.Length, UInt32.Ptr, pcchName, PWSTR, szName, IntPtr.Ptr, pProcessId)
    GetAssemblyInfo(assemblyId, pcchName, szName, pAppDomainId, pModuleId)
      => ComCall(26, this.p, IntPtr, assemblyId, UInt32, szName.Length, UInt32.Ptr, pcchName, PWSTR, szName, IntPtr.Ptr, pAppDomainId, IntPtr.Ptr, pModuleId)
    SetFunctionReJIT(functionId)
      => ComCall(27, this.p, IntPtr, functionId)
    ForceGC()
      => ComCall(28, this.p)
    SetILInstrumentedCodeMap(functionId, fStartJit, rgILMapEntries)
      => ComCall(29, this.p, IntPtr, functionId, BOOL, fStartJit, UInt32, rgILMapEntries.Length, COR_IL_MAP.Ptr, rgILMapEntries)
    GetInprocInspectionInterface(ppicd)
      => ComCall(30, this.p, IUnknown.Ptr, ppicd)
    GetInprocInspectionIThisThread(ppicd)
      => ComCall(31, this.p, IUnknown.Ptr, ppicd)
    GetThreadContext(threadId, pContextId)
      => ComCall(32, this.p, IntPtr, threadId, IntPtr.Ptr, pContextId)
    BeginInprocDebugging(fThisThreadOnly, pdwProfilerContext)
      => ComCall(33, this.p, BOOL, fThisThreadOnly, UInt32.Ptr, pdwProfilerContext)
    EndInprocDebugging(dwProfilerContext)
      => ComCall(34, this.p, UInt32, dwProfilerContext)
    GetILToNativeMapping(functionId, pcMap, map)
      => ComCall(35, this.p, IntPtr, functionId, UInt32, map.Length, UInt32.Ptr, pcMap, COR_DEBUG_IL_TO_NATIVE_MAP.Ptr, map)
}
struct ICorProfilerInfo2 extends ICorProfilerInfo {
    static IID := "{CC0935CD-A518-487D-B0BB-A93214E65478}"
    DoStackSnapshot(thread, callback, infoFlags, clientData, context)
      => ComCall(36, this.p, IntPtr, thread, StackSnapshotCallback.Ptr, callback, UInt32, infoFlags, Struct.Ptr, clientData, UInt8.Ptr, context, UInt32, context.Length)
    SetEnterLeaveFunctionHooks2(pFuncEnter, pFuncLeave, pFuncTailcall)
      => ComCall(37, this.p, FunctionEnter2.Ptr, pFuncEnter, FunctionLeave2.Ptr, pFuncLeave, FunctionTailcall2.Ptr, pFuncTailcall)
    GetFunctionInfo2(funcId, frameInfo, pClassId, pModuleId, pToken, cTypeArgs, pcTypeArgs, typeArgs)
      => ComCall(38, this.p, IntPtr, funcId, IntPtr, frameInfo, IntPtr.Ptr, pClassId, IntPtr.Ptr, pModuleId, UInt32.Ptr, pToken, UInt32, cTypeArgs, UInt32.Ptr, pcTypeArgs, IntPtr.Ptr, typeArgs)
    GetStringLayout(pBufferLengthOffset, pStringLengthOffset, pBufferOffset)
      => ComCall(39, this.p, UInt32.Ptr, pBufferLengthOffset, UInt32.Ptr, pStringLengthOffset, UInt32.Ptr, pBufferOffset)
    GetClassLayout(classID, rFieldOffset, cFieldOffset, pcFieldOffset, pulClassSize)
      => ComCall(40, this.p, IntPtr, classID, COR_FIELD_OFFSET.Ptr, rFieldOffset, UInt32, cFieldOffset, UInt32.Ptr, pcFieldOffset, UInt32.Ptr, pulClassSize)
    GetClassIDInfo2(classId, pModuleId, pTypeDefToken, pParentClassId, cNumTypeArgs, pcNumTypeArgs, typeArgs)
      => ComCall(41, this.p, IntPtr, classId, IntPtr.Ptr, pModuleId, UInt32.Ptr, pTypeDefToken, IntPtr.Ptr, pParentClassId, UInt32, cNumTypeArgs, UInt32.Ptr, pcNumTypeArgs, IntPtr.Ptr, typeArgs)
    GetCodeInfo2(functionID, pcCodeInfos, codeInfos)
      => ComCall(42, this.p, IntPtr, functionID, UInt32, codeInfos.Length, UInt32.Ptr, pcCodeInfos, COR_PRF_CODE_INFO.Ptr, codeInfos)
    GetClassFromTokenAndTypeArgs(moduleID, typeDef, typeArgs, pClassID)
      => ComCall(43, this.p, IntPtr, moduleID, UInt32, typeDef, UInt32, typeArgs.Length, IntPtr.Ptr, typeArgs, IntPtr.Ptr, pClassID)
    GetFunctionFromTokenAndTypeArgs(moduleID, funcDef, classId, typeArgs, pFunctionID)
      => ComCall(44, this.p, IntPtr, moduleID, UInt32, funcDef, IntPtr, classId, UInt32, typeArgs.Length, IntPtr.Ptr, typeArgs, IntPtr.Ptr, pFunctionID)
    EnumModuleFrozenObjects(moduleID, ppEnum)
      => ComCall(45, this.p, IntPtr, moduleID, ICorProfilerObjectEnum.Ptr, ppEnum)
    GetArrayObjectInfo(objectId, pDimensionSizes, pDimensionLowerBounds, ppData)
      => ComCall(46, this.p, IntPtr, objectId, UInt32, pDimensionLowerBounds.Length, UInt32.Ptr, pDimensionSizes, Int32.Ptr, pDimensionLowerBounds, UInt8.Ptr.Ptr, ppData)
    GetBoxClassLayout(classId, pBufferOffset)
      => ComCall(47, this.p, IntPtr, classId, UInt32.Ptr, pBufferOffset)
    GetThreadAppDomain(threadId, pAppDomainId)
      => ComCall(48, this.p, IntPtr, threadId, IntPtr.Ptr, pAppDomainId)
    GetRVAStaticAddress(classId, fieldToken, ppAddress)
      => ComCall(49, this.p, IntPtr, classId, UInt32, fieldToken, Struct.Ptr.Ptr, ppAddress)
    GetAppDomainStaticAddress(classId, fieldToken, appDomainId, ppAddress)
      => ComCall(50, this.p, IntPtr, classId, UInt32, fieldToken, IntPtr, appDomainId, Struct.Ptr.Ptr, ppAddress)
    GetThreadStaticAddress(classId, fieldToken, threadId, ppAddress)
      => ComCall(51, this.p, IntPtr, classId, UInt32, fieldToken, IntPtr, threadId, Struct.Ptr.Ptr, ppAddress)
    GetContextStaticAddress(classId, fieldToken, contextId, ppAddress)
      => ComCall(52, this.p, IntPtr, classId, UInt32, fieldToken, IntPtr, contextId, Struct.Ptr.Ptr, ppAddress)
    GetStaticFieldInfo(classId, fieldToken, pFieldInfo)
      => ComCall(53, this.p, IntPtr, classId, UInt32, fieldToken, COR_PRF_STATIC_TYPE.Ptr, pFieldInfo)
    GetGenerationBounds(pcObjectRanges, ranges)
      => ComCall(54, this.p, UInt32, ranges.Length, UInt32.Ptr, pcObjectRanges, COR_PRF_GC_GENERATION_RANGE.Ptr, ranges)
    GetObjectGeneration(objectId, range)
      => ComCall(55, this.p, IntPtr, objectId, COR_PRF_GC_GENERATION_RANGE.Ptr, range)
    GetNotifiedExceptionClauseInfo(pinfo)
      => ComCall(56, this.p, COR_PRF_EX_CLAUSE_INFO.Ptr, pinfo)
}
struct ICorProfilerInfo3 extends ICorProfilerInfo2 {
    static IID := "{B555ED4F-452A-4E54-8B39-B5360BAD32A0}"
    EnumJITedFunctions(ppEnum)
      => ComCall(57, this.p, ICorProfilerFunctionEnum.Ptr, ppEnum)
    RequestProfilerDetach(dwExpectedCompletionMilliseconds)
      => ComCall(58, this.p, UInt32, dwExpectedCompletionMilliseconds)
    SetFunctionIDMapper2(pFunc, clientData)
      => ComCall(59, this.p, FunctionIDMapper2.Ptr, pFunc, Struct.Ptr, clientData)
    GetStringLayout2(pStringLengthOffset, pBufferOffset)
      => ComCall(60, this.p, UInt32.Ptr, pStringLengthOffset, UInt32.Ptr, pBufferOffset)
    SetEnterLeaveFunctionHooks3(pFuncEnter3, pFuncLeave3, pFuncTailcall3)
      => ComCall(61, this.p, FunctionEnter3.Ptr, pFuncEnter3, FunctionLeave3.Ptr, pFuncLeave3, FunctionTailcall3.Ptr, pFuncTailcall3)
    SetEnterLeaveFunctionHooks3WithInfo(pFuncEnter3WithInfo, pFuncLeave3WithInfo, pFuncTailcall3WithInfo)
      => ComCall(62, this.p, FunctionEnter3WithInfo.Ptr, pFuncEnter3WithInfo, FunctionLeave3WithInfo.Ptr, pFuncLeave3WithInfo, FunctionTailcall3WithInfo.Ptr, pFuncTailcall3WithInfo)
    GetFunctionEnter3Info(functionId, eltInfo, pFrameInfo, pArgumentInfo)
      => ComCall(63, this.p, IntPtr, functionId, IntPtr, eltInfo, IntPtr.Ptr, pFrameInfo, UInt32.Ptr, pArgumentInfo.Length, COR_PRF_FUNCTION_ARGUMENT_INFO.Ptr, pArgumentInfo)
    GetFunctionLeave3Info(functionId, eltInfo, pFrameInfo, pRetvalRange)
      => ComCall(64, this.p, IntPtr, functionId, IntPtr, eltInfo, IntPtr.Ptr, pFrameInfo, COR_PRF_FUNCTION_ARGUMENT_RANGE.Ptr, pRetvalRange)
    GetFunctionTailcall3Info(functionId, eltInfo, pFrameInfo)
      => ComCall(65, this.p, IntPtr, functionId, IntPtr, eltInfo, IntPtr.Ptr, pFrameInfo)
    EnumModules(ppEnum)
      => ComCall(66, this.p, ICorProfilerModuleEnum.Ptr, ppEnum)
    GetRuntimeInformation(pClrInstanceId, pRuntimeType, pMajorVersion, pMinorVersion, pBuildNumber, pQFEVersion, pcchVersionString, szVersionString)
      => ComCall(67, this.p, UInt16.Ptr, pClrInstanceId, COR_PRF_RUNTIME_TYPE.Ptr, pRuntimeType, UInt16.Ptr, pMajorVersion, UInt16.Ptr, pMinorVersion, UInt16.Ptr, pBuildNumber, UInt16.Ptr, pQFEVersion, UInt32, szVersionString.Length, UInt32.Ptr, pcchVersionString, PWSTR, szVersionString)
    GetThreadStaticAddress2(classId, fieldToken, appDomainId, threadId, ppAddress)
      => ComCall(68, this.p, IntPtr, classId, UInt32, fieldToken, IntPtr, appDomainId, IntPtr, threadId, Struct.Ptr.Ptr, ppAddress)
    GetAppDomainsContainingModule(moduleId, pcAppDomainIds, appDomainIds)
      => ComCall(69, this.p, IntPtr, moduleId, UInt32, appDomainIds.Length, UInt32.Ptr, pcAppDomainIds, IntPtr.Ptr, appDomainIds)
    GetModuleInfo2(moduleId, ppBaseLoadAddress, pcchName, szName, pAssemblyId, pdwModuleFlags)
      => ComCall(70, this.p, IntPtr, moduleId, UInt8.Ptr.Ptr, ppBaseLoadAddress, UInt32, szName.Length, UInt32.Ptr, pcchName, PWSTR, szName, IntPtr.Ptr, pAssemblyId, UInt32.Ptr, pdwModuleFlags)
}
struct ICorProfilerObjectEnum extends IUnknown {
    static IID := "{2C6269BD-2D13-4321-AE12-6686365FD6AF}"
    Skip(celt)
      => ComCall(3, this.p, UInt32, celt)
    Reset()
      => ComCall(4, this.p)
    Clone(ppEnum)
      => ComCall(5, this.p, ICorProfilerObjectEnum.Ptr, ppEnum)
    GetCount(pcelt)
      => ComCall(6, this.p, UInt32.Ptr, pcelt)
    Next(objects, pceltFetched)
      => ComCall(7, this.p, UInt32, objects.Length, IntPtr.Ptr, objects, UInt32.Ptr, pceltFetched)
}
struct ICorProfilerFunctionEnum extends IUnknown {
    static IID := "{FF71301A-B994-429D-A10B-B345A65280EF}"
    Skip(celt)
      => ComCall(3, this.p, UInt32, celt)
    Reset()
      => ComCall(4, this.p)
    Clone(ppEnum)
      => ComCall(5, this.p, ICorProfilerFunctionEnum.Ptr, ppEnum)
    GetCount(pcelt)
      => ComCall(6, this.p, UInt32.Ptr, pcelt)
    Next(ids, pceltFetched)
      => ComCall(7, this.p, UInt32, ids.Length, COR_PRF_FUNCTION.Ptr, ids, UInt32.Ptr, pceltFetched)
}
struct ICorProfilerModuleEnum extends IUnknown {
    static IID := "{B0266D75-2081-4493-AF7F-028BA34DB891}"
    Skip(celt)
      => ComCall(3, this.p, UInt32, celt)
    Reset()
      => ComCall(4, this.p)
    Clone(ppEnum)
      => ComCall(5, this.p, ICorProfilerModuleEnum.Ptr, ppEnum)
    GetCount(pcelt)
      => ComCall(6, this.p, UInt32.Ptr, pcelt)
    Next(ids, pceltFetched)
      => ComCall(7, this.p, UInt32, ids.Length, IntPtr.Ptr, ids, UInt32.Ptr, pceltFetched)
}
struct IMethodMalloc extends IUnknown {
    static IID := "{A0EFB28B-6EE2-4D7B-B983-A75EF7BEEDB8}"
    Alloc(cb)
      => ComCall(3, this.p, UInt32, cb, Struct.Ptr)
}
struct ICorProfilerFunctionControl extends IUnknown {
    static IID := "{F0963021-E1EA-4732-8581-E01B0BD3C0C6}"
    SetCodegenFlags(flags)
      => ComCall(3, this.p, UInt32, flags)
    SetILFunctionBody(pbNewILMethodHeader)
      => ComCall(4, this.p, UInt32, pbNewILMethodHeader.Length, UInt8.Ptr, pbNewILMethodHeader)
    SetILInstrumentedCodeMap(rgILMapEntries)
      => ComCall(5, this.p, UInt32, rgILMapEntries.Length, COR_IL_MAP.Ptr, rgILMapEntries)
}
struct ICorProfilerInfo4 extends ICorProfilerInfo3 {
    static IID := "{0D8FDCAA-6257-47BF-B1BF-94DAC88466EE}"
    EnumThreads(ppEnum)
      => ComCall(71, this.p, ICorProfilerThreadEnum.Ptr, ppEnum)
    InitializeCurrentThread()
      => ComCall(72, this.p)
    RequestReJIT(moduleIds, methodIds)
      => ComCall(73, this.p, UInt32, methodIds.Length, IntPtr.Ptr, moduleIds, UInt32.Ptr, methodIds)
    RequestRevert(moduleIds, methodIds, status)
      => ComCall(74, this.p, UInt32, status.Length, IntPtr.Ptr, moduleIds, UInt32.Ptr, methodIds, HRESULT.Ptr, status)
    GetCodeInfo3(functionID, reJitId, pcCodeInfos, codeInfos)
      => ComCall(75, this.p, IntPtr, functionID, IntPtr, reJitId, UInt32, codeInfos.Length, UInt32.Ptr, pcCodeInfos, COR_PRF_CODE_INFO.Ptr, codeInfos)
    GetFunctionFromIP2(ip, pFunctionId, pReJitId)
      => ComCall(76, this.p, UInt8.Ptr, ip, IntPtr.Ptr, pFunctionId, IntPtr.Ptr, pReJitId)
    GetReJITIDs(functionId, pcReJitIds, reJitIds)
      => ComCall(77, this.p, IntPtr, functionId, UInt32, reJitIds.Length, UInt32.Ptr, pcReJitIds, IntPtr.Ptr, reJitIds)
    GetILToNativeMapping2(functionId, reJitId, pcMap, map)
      => ComCall(78, this.p, IntPtr, functionId, IntPtr, reJitId, UInt32, map.Length, UInt32.Ptr, pcMap, COR_DEBUG_IL_TO_NATIVE_MAP.Ptr, map)
    EnumJITedFunctions2(ppEnum)
      => ComCall(79, this.p, ICorProfilerFunctionEnum.Ptr, ppEnum)
    GetObjectSize2(objectId, pcSize)
      => ComCall(80, this.p, IntPtr, objectId, IntPtr.Ptr, pcSize)
}
struct ICorProfilerInfo5 extends ICorProfilerInfo4 {
    static IID := "{07602928-CE38-4B83-81E7-74ADAF781214}"
    GetEventMask2(pdwEventsLow, pdwEventsHigh)
      => ComCall(81, this.p, UInt32.Ptr, pdwEventsLow, UInt32.Ptr, pdwEventsHigh)
    SetEventMask2(dwEventsLow, dwEventsHigh)
      => ComCall(82, this.p, UInt32, dwEventsLow, UInt32, dwEventsHigh)
}
struct ICorProfilerInfo6 extends ICorProfilerInfo5 {
    static IID := "{F30A070D-BFFB-46A7-B1D8-8781EF7B698A}"
    EnumNgenModuleMethodsInliningThisMethod(inlinersModuleId, inlineeModuleId, inlineeMethodId, incompleteData, ppEnum)
      => ComCall(83, this.p, IntPtr, inlinersModuleId, IntPtr, inlineeModuleId, UInt32, inlineeMethodId, BOOL.Ptr, incompleteData, ICorProfilerMethodEnum.Ptr, ppEnum)
}
struct ICorProfilerInfo7 extends ICorProfilerInfo6 {
    static IID := "{9AEECC0D-63E0-4187-8C00-E312F503F663}"
    ApplyMetaData(moduleId)
      => ComCall(84, this.p, IntPtr, moduleId)
    GetInMemorySymbolsLength(moduleId, pCountSymbolBytes)
      => ComCall(85, this.p, IntPtr, moduleId, UInt32.Ptr, pCountSymbolBytes)
    ReadInMemorySymbols(moduleId, symbolsReadOffset, pSymbolBytes, countSymbolBytes, pCountSymbolBytesRead)
      => ComCall(86, this.p, IntPtr, moduleId, UInt32, symbolsReadOffset, UInt8.Ptr, pSymbolBytes, UInt32, countSymbolBytes, UInt32.Ptr, pCountSymbolBytesRead)
}
struct ICorProfilerInfo8 extends ICorProfilerInfo7 {
    static IID := "{C5AC80A6-782E-4716-8044-39598C60CFBF}"
    IsFunctionDynamic(functionId, isDynamic)
      => ComCall(87, this.p, IntPtr, functionId, BOOL.Ptr, isDynamic)
    GetFunctionFromIP3(ip, functionId, pReJitId)
      => ComCall(88, this.p, UInt8.Ptr, ip, IntPtr.Ptr, functionId, IntPtr.Ptr, pReJitId)
    GetDynamicFunctionInfo(functionId, moduleId, ppvSig, pbSig, cchName, pcchName, wszName)
      => ComCall(89, this.p, IntPtr, functionId, IntPtr.Ptr, moduleId, UInt8.Ptr.Ptr, ppvSig, UInt32.Ptr, pbSig, UInt32, cchName, UInt32.Ptr, pcchName, PWSTR, wszName)
}
struct ICorProfilerInfo9 extends ICorProfilerInfo8 {
    static IID := "{008170DB-F8CC-4796-9A51-DC8AA0B47012}"
    GetNativeCodeStartAddresses(functionID, reJitId, cCodeStartAddresses, pcCodeStartAddresses, codeStartAddresses)
      => ComCall(90, this.p, IntPtr, functionID, IntPtr, reJitId, UInt32, cCodeStartAddresses, UInt32.Ptr, pcCodeStartAddresses, IntPtr.Ptr, codeStartAddresses)
    GetILToNativeMapping3(pNativeCodeStartAddress, cMap, pcMap, map)
      => ComCall(91, this.p, IntPtr, pNativeCodeStartAddress, UInt32, cMap, UInt32.Ptr, pcMap, COR_DEBUG_IL_TO_NATIVE_MAP.Ptr, map)
    GetCodeInfo4(pNativeCodeStartAddress, cCodeInfos, pcCodeInfos, codeInfos)
      => ComCall(92, this.p, IntPtr, pNativeCodeStartAddress, UInt32, cCodeInfos, UInt32.Ptr, pcCodeInfos, COR_PRF_CODE_INFO.Ptr, codeInfos)
}
struct ICorProfilerInfo10 extends ICorProfilerInfo9 {
    static IID := "{2F1B5152-C869-40C9-AA5F-3ABE026BD720}"
    EnumerateObjectReferences(objectId, callback, clientData)
      => ComCall(93, this.p, IntPtr, objectId, ObjectReferenceCallback, callback, Struct.Ptr, clientData)
    IsFrozenObject(objectId, pbFrozen)
      => ComCall(94, this.p, IntPtr, objectId, BOOL.Ptr, pbFrozen)
    GetLOHObjectSizeThreshold(pThreshold)
      => ComCall(95, this.p, UInt32.Ptr, pThreshold)
    RequestReJITWithInliners(dwRejitFlags, moduleIds, methodIds)
      => ComCall(96, this.p, UInt32, dwRejitFlags, UInt32, methodIds.Length, IntPtr.Ptr, moduleIds, UInt32.Ptr, methodIds)
    SuspendRuntime()
      => ComCall(97, this.p)
    ResumeRuntime()
      => ComCall(98, this.p)
}
struct ICorProfilerInfo11 extends ICorProfilerInfo10 {
    static IID := "{06398876-8987-4154-B621-40A00D6E4D04}"
    GetEnvironmentVariableA(szName, pcchValue, szValue)
      => ComCall(99, this.p, "Str", szName, UInt32, szValue.Length, UInt32.Ptr, pcchValue, PWSTR, szValue)
    SetEnvironmentVariable(szName, szValue)
      => ComCall(100, this.p, "Str", szName, "Str", szValue)
}
struct ICorProfilerInfo12 extends ICorProfilerInfo11 {
    static IID := "{27B24CCD-1CB1-47C5-96EE-98190DC30959}"
    EventPipeStartSession(pProviderConfigs, requestRundown, pSession)
      => ComCall(101, this.p, UInt32, pProviderConfigs.Length, COR_PRF_EVENTPIPE_PROVIDER_CONFIG.Ptr, pProviderConfigs, BOOL, requestRundown, Int64.Ptr, pSession)
    EventPipeAddProviderToSession(session, providerConfig)
      => ComCall(102, this.p, Int64, session, COR_PRF_EVENTPIPE_PROVIDER_CONFIG, providerConfig)
    EventPipeStopSession(session)
      => ComCall(103, this.p, Int64, session)
    EventPipeCreateProvider(providerName, pProvider)
      => ComCall(104, this.p, "Str", providerName, IntPtr.Ptr, pProvider)
    EventPipeGetProviderInfo(provider, pcchName, providerName)
      => ComCall(105, this.p, IntPtr, provider, UInt32, providerName.Length, UInt32.Ptr, pcchName, PWSTR, providerName)
    EventPipeDefineEvent(provider, eventName, eventID, keywords, eventVersion, level, opcode, needStack, pParamDescs, pEvent)
      => ComCall(106, this.p, IntPtr, provider, "Str", eventName, UInt32, eventID, Int64, keywords, UInt32, eventVersion, UInt32, level, UInt8, opcode, BOOL, needStack, UInt32, pParamDescs.Length, COR_PRF_EVENTPIPE_PARAM_DESC.Ptr, pParamDescs, IntPtr.Ptr, pEvent)
    EventPipeWriteEvent(event, data, pActivityId, pRelatedActivityId)
      => ComCall(107, this.p, IntPtr, event, UInt32, data.Length, COR_PRF_EVENT_DATA.Ptr, data, GUID.Ptr, pActivityId, GUID.Ptr, pRelatedActivityId)
}
struct ICorProfilerInfo13 extends ICorProfilerInfo12 {
    static IID := "{6E6C7EE2-0701-4EC2-9D29-2E8733B66934}"
    CreateHandle(object, type, pHandle)
      => ComCall(108, this.p, IntPtr, object, COR_PRF_HANDLE_TYPE, type, Struct.Ptr.Ptr.Ptr, pHandle)
    DestroyHandle(handle)
      => ComCall(109, this.p, Struct.Ptr.Ptr, handle)
    GetObjectIDFromHandle(handle, pObject)
      => ComCall(110, this.p, Struct.Ptr.Ptr, handle, IntPtr.Ptr, pObject)
}
struct ICorProfilerInfo14 extends ICorProfilerInfo13 {
    static IID := "{F460E352-D76D-4FE9-835F-F6AF9D6E862D}"
    EnumerateNonGCObjects(ppEnum)
      => ComCall(111, this.p, ICorProfilerObjectEnum.Ptr, ppEnum)
    GetNonGCHeapBounds(pcObjectRanges, ranges)
      => ComCall(112, this.p, UInt32, ranges.Length, UInt32.Ptr, pcObjectRanges, COR_PRF_NONGC_HEAP_RANGE.Ptr, ranges)
    EventPipeCreateProvider2(providerName, pCallback, pProvider)
      => ComCall(113, this.p, "Str", providerName, EventPipeProviderCallback.Ptr, pCallback, IntPtr.Ptr, pProvider)
}
struct ICorProfilerMethodEnum extends IUnknown {
    static IID := "{FCCEE788-0088-454B-A811-C99F298D1942}"
    Skip(celt)
      => ComCall(3, this.p, UInt32, celt)
    Reset()
      => ComCall(4, this.p)
    Clone(ppEnum)
      => ComCall(5, this.p, ICorProfilerMethodEnum.Ptr, ppEnum)
    GetCount(pcelt)
      => ComCall(6, this.p, UInt32.Ptr, pcelt)
    Next(elements, pceltFetched)
      => ComCall(7, this.p, UInt32, elements.Length, COR_PRF_METHOD.Ptr, elements, UInt32.Ptr, pceltFetched)
}
struct ICorProfilerThreadEnum extends IUnknown {
    static IID := "{571194F7-25ED-419F-AA8B-7016B3159701}"
    Skip(celt)
      => ComCall(3, this.p, UInt32, celt)
    Reset()
      => ComCall(4, this.p)
    Clone(ppEnum)
      => ComCall(5, this.p, ICorProfilerThreadEnum.Ptr, ppEnum)
    GetCount(pcelt)
      => ComCall(6, this.p, UInt32.Ptr, pcelt)
    Next(ids, pceltFetched)
      => ComCall(7, this.p, UInt32, ids.Length, IntPtr.Ptr, ids, UInt32.Ptr, pceltFetched)
}
struct ICorProfilerAssemblyReferenceProvider extends IUnknown {
    static IID := "{66A78C24-2EEF-4F65-B45F-DD1D8038BF3C}"
    AddAssemblyReference(pAssemblyRefInfo)
      => ComCall(3, this.p, COR_PRF_ASSEMBLY_REFERENCE_INFO.Ptr, pAssemblyRefInfo)
}
