#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HANDLE, HMODULE, HRESULT, NTSTATUS, PSTR, PWSTR, UNICODE_STRING}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Kernel\Types.ahk" {LIST_ENTRY}
#Import "..\System.SystemInformation\Types.ahk" {IMAGE_FILE_MACHINE}
#Import "..\System.SystemServices\Types.ahk" {RTL_UMS_SCHEDULER_REASON}

struct THREAD_CREATION_FLAGS extends UInt32 {
    static THREAD_CREATE_RUN_IMMEDIATELY := 0
    static THREAD_CREATE_SUSPENDED := 4
    static STACK_SIZE_PARAM_IS_A_RESERVATION := 65536
}
struct THREAD_PRIORITY extends Int32 {
    static THREAD_MODE_BACKGROUND_BEGIN := 65536
    static THREAD_MODE_BACKGROUND_END := 131072
    static THREAD_PRIORITY_ABOVE_NORMAL := 1
    static THREAD_PRIORITY_BELOW_NORMAL := -1
    static THREAD_PRIORITY_HIGHEST := 2
    static THREAD_PRIORITY_IDLE := -15
    static THREAD_PRIORITY_MIN := -2
    static THREAD_PRIORITY_LOWEST := -2
    static THREAD_PRIORITY_NORMAL := 0
    static THREAD_PRIORITY_TIME_CRITICAL := 15
}
struct WORKER_THREAD_FLAGS extends UInt32 {
    static WT_EXECUTEDEFAULT := 0
    static WT_EXECUTEINIOTHREAD := 1
    static WT_EXECUTEINPERSISTENTTHREAD := 128
    static WT_EXECUTEINWAITTHREAD := 4
    static WT_EXECUTELONGFUNCTION := 16
    static WT_EXECUTEONLYONCE := 8
    static WT_TRANSFER_IMPERSONATION := 256
    static WT_EXECUTEINTIMERTHREAD := 32
}
struct CREATE_EVENT extends UInt32 {
    static CREATE_EVENT_INITIAL_SET := 2
    static CREATE_EVENT_MANUAL_RESET := 1
}
struct CREATE_PROCESS_LOGON_FLAGS extends UInt32 {
    static LOGON_WITH_PROFILE := 1
    static LOGON_NETCREDENTIALS_ONLY := 2
}
struct PROCESS_AFFINITY_AUTO_UPDATE_FLAGS extends UInt32 {
    static PROCESS_AFFINITY_DISABLE_AUTO_UPDATE := 0
    static PROCESS_AFFINITY_ENABLE_AUTO_UPDATE := 1
}
struct PROCESS_DEP_FLAGS extends UInt32 {
    static PROCESS_DEP_ENABLE := 1
    static PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION := 2
    static PROCESS_DEP_NONE := 0
}
struct PROCESS_NAME_FORMAT extends UInt32 {
    static PROCESS_NAME_WIN32 := 0
    static PROCESS_NAME_NATIVE := 1
}
struct PROCESSOR_FEATURE_ID extends UInt32 {
    static PF_FLOATING_POINT_PRECISION_ERRATA := 0
    static PF_FLOATING_POINT_EMULATED := 1
    static PF_COMPARE_EXCHANGE_DOUBLE := 2
    static PF_MMX_INSTRUCTIONS_AVAILABLE := 3
    static PF_PPC_MOVEMEM_64BIT_OK := 4
    static PF_ALPHA_BYTE_INSTRUCTIONS := 5
    static PF_XMMI_INSTRUCTIONS_AVAILABLE := 6
    static PF_3DNOW_INSTRUCTIONS_AVAILABLE := 7
    static PF_RDTSC_INSTRUCTION_AVAILABLE := 8
    static PF_PAE_ENABLED := 9
    static PF_XMMI64_INSTRUCTIONS_AVAILABLE := 10
    static PF_SSE_DAZ_MODE_AVAILABLE := 11
    static PF_NX_ENABLED := 12
    static PF_SSE3_INSTRUCTIONS_AVAILABLE := 13
    static PF_COMPARE_EXCHANGE128 := 14
    static PF_COMPARE64_EXCHANGE128 := 15
    static PF_CHANNELS_ENABLED := 16
    static PF_XSAVE_ENABLED := 17
    static PF_ARM_VFP_32_REGISTERS_AVAILABLE := 18
    static PF_ARM_NEON_INSTRUCTIONS_AVAILABLE := 19
    static PF_SECOND_LEVEL_ADDRESS_TRANSLATION := 20
    static PF_VIRT_FIRMWARE_ENABLED := 21
    static PF_RDWRFSGSBASE_AVAILABLE := 22
    static PF_FASTFAIL_AVAILABLE := 23
    static PF_ARM_DIVIDE_INSTRUCTION_AVAILABLE := 24
    static PF_ARM_64BIT_LOADSTORE_ATOMIC := 25
    static PF_ARM_EXTERNAL_CACHE_AVAILABLE := 26
    static PF_ARM_FMAC_INSTRUCTIONS_AVAILABLE := 27
    static PF_RDRAND_INSTRUCTION_AVAILABLE := 28
    static PF_ARM_V8_INSTRUCTIONS_AVAILABLE := 29
    static PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE := 30
    static PF_ARM_V8_CRC32_INSTRUCTIONS_AVAILABLE := 31
    static PF_RDTSCP_INSTRUCTION_AVAILABLE := 32
    static PF_RDPID_INSTRUCTION_AVAILABLE := 33
    static PF_ARM_V81_ATOMIC_INSTRUCTIONS_AVAILABLE := 34
    static PF_MONITORX_INSTRUCTION_AVAILABLE := 35
    static PF_SSSE3_INSTRUCTIONS_AVAILABLE := 36
    static PF_SSE4_1_INSTRUCTIONS_AVAILABLE := 37
    static PF_SSE4_2_INSTRUCTIONS_AVAILABLE := 38
    static PF_AVX_INSTRUCTIONS_AVAILABLE := 39
    static PF_AVX2_INSTRUCTIONS_AVAILABLE := 40
    static PF_AVX512F_INSTRUCTIONS_AVAILABLE := 41
    static PF_ERMS_AVAILABLE := 42
    static PF_ARM_V82_DP_INSTRUCTIONS_AVAILABLE := 43
    static PF_ARM_V83_JSCVT_INSTRUCTIONS_AVAILABLE := 44
    static PF_ARM_V83_LRCPC_INSTRUCTIONS_AVAILABLE := 45
    static PF_ARM_SVE_INSTRUCTIONS_AVAILABLE := 46
    static PF_ARM_SVE2_INSTRUCTIONS_AVAILABLE := 47
    static PF_ARM_SVE2_1_INSTRUCTIONS_AVAILABLE := 48
    static PF_ARM_SVE_AES_INSTRUCTIONS_AVAILABLE := 49
    static PF_ARM_SVE_PMULL128_INSTRUCTIONS_AVAILABLE := 50
    static PF_ARM_SVE_BITPERM_INSTRUCTIONS_AVAILABLE := 51
    static PF_ARM_SVE_BF16_INSTRUCTIONS_AVAILABLE := 52
    static PF_ARM_SVE_EBF16_INSTRUCTIONS_AVAILABLE := 53
    static PF_ARM_SVE_B16B16_INSTRUCTIONS_AVAILABLE := 54
    static PF_ARM_SVE_SHA3_INSTRUCTIONS_AVAILABLE := 55
    static PF_ARM_SVE_SM4_INSTRUCTIONS_AVAILABLE := 56
    static PF_ARM_SVE_I8MM_INSTRUCTIONS_AVAILABLE := 57
    static PF_ARM_SVE_F32MM_INSTRUCTIONS_AVAILABLE := 58
    static PF_ARM_SVE_F64MM_INSTRUCTIONS_AVAILABLE := 59
    static PF_BMI2_INSTRUCTIONS_AVAILABLE := 60
    static PF_MOVDIR64B_INSTRUCTION_AVAILABLE := 61
    static PF_ARM_LSE2_AVAILABLE := 62
    static PF_RESERVED_FEATURE := 63
    static PF_ARM_SHA3_INSTRUCTIONS_AVAILABLE := 64
    static PF_ARM_SHA512_INSTRUCTIONS_AVAILABLE := 65
    static PF_ARM_V82_I8MM_INSTRUCTIONS_AVAILABLE := 66
    static PF_ARM_V82_FP16_INSTRUCTIONS_AVAILABLE := 67
    static PF_ARM_V86_BF16_INSTRUCTIONS_AVAILABLE := 68
    static PF_ARM_V86_EBF16_INSTRUCTIONS_AVAILABLE := 69
    static PF_ARM_SME_INSTRUCTIONS_AVAILABLE := 70
    static PF_ARM_SME2_INSTRUCTIONS_AVAILABLE := 71
    static PF_ARM_SME2_1_INSTRUCTIONS_AVAILABLE := 72
    static PF_ARM_SME2_2_INSTRUCTIONS_AVAILABLE := 73
    static PF_ARM_SME_AES_INSTRUCTIONS_AVAILABLE := 74
    static PF_ARM_SME_SBITPERM_INSTRUCTIONS_AVAILABLE := 75
    static PF_ARM_SME_SF8MM4_INSTRUCTIONS_AVAILABLE := 76
    static PF_ARM_SME_SF8MM8_INSTRUCTIONS_AVAILABLE := 77
    static PF_ARM_SME_SF8DP2_INSTRUCTIONS_AVAILABLE := 78
    static PF_ARM_SME_SF8DP4_INSTRUCTIONS_AVAILABLE := 79
    static PF_ARM_SME_SF8FMA_INSTRUCTIONS_AVAILABLE := 80
    static PF_ARM_SME_F8F32_INSTRUCTIONS_AVAILABLE := 81
    static PF_ARM_SME_F8F16_INSTRUCTIONS_AVAILABLE := 82
    static PF_ARM_SME_F16F16_INSTRUCTIONS_AVAILABLE := 83
    static PF_ARM_SME_B16B16_INSTRUCTIONS_AVAILABLE := 84
    static PF_ARM_SME_F64F64_INSTRUCTIONS_AVAILABLE := 85
    static PF_ARM_SME_I16I64_INSTRUCTIONS_AVAILABLE := 86
    static PF_ARM_SME_LUTv2_INSTRUCTIONS_AVAILABLE := 87
    static PF_ARM_SME_FA64_INSTRUCTIONS_AVAILABLE := 88
    static PF_UMONITOR_INSTRUCTION_AVAILABLE := 89
}
struct GET_GUI_RESOURCES_FLAGS extends UInt32 {
    static GR_GLOBAL := 4294967294
    static GR_GDIOBJECTS := 0
    static GR_GDIOBJECTS_PEAK := 2
    static GR_USEROBJECTS := 1
    static GR_USEROBJECTS_PEAK := 4
}
struct STARTUPINFOW_FLAGS extends UInt32 {
    static STARTF_FORCEONFEEDBACK := 64
    static STARTF_FORCEOFFFEEDBACK := 128
    static STARTF_PREVENTPINNING := 8192
    static STARTF_RUNFULLSCREEN := 32
    static STARTF_TITLEISAPPID := 4096
    static STARTF_TITLEISLINKNAME := 2048
    static STARTF_UNTRUSTEDSOURCE := 32768
    static STARTF_USECOUNTCHARS := 8
    static STARTF_USEFILLATTRIBUTE := 16
    static STARTF_USEHOTKEY := 512
    static STARTF_USEPOSITION := 4
    static STARTF_USESHOWWINDOW := 1
    static STARTF_USESIZE := 2
    static STARTF_USESTDHANDLES := 256
}
struct MEMORY_PRIORITY extends UInt32 {
    static MEMORY_PRIORITY_VERY_LOW := 1
    static MEMORY_PRIORITY_LOW := 2
    static MEMORY_PRIORITY_MEDIUM := 3
    static MEMORY_PRIORITY_BELOW_NORMAL := 4
    static MEMORY_PRIORITY_NORMAL := 5
}
struct PROCESS_PROTECTION_LEVEL extends UInt32 {
    static PROTECTION_LEVEL_WINTCB_LIGHT := 0
    static PROTECTION_LEVEL_WINDOWS := 1
    static PROTECTION_LEVEL_WINDOWS_LIGHT := 2
    static PROTECTION_LEVEL_ANTIMALWARE_LIGHT := 3
    static PROTECTION_LEVEL_LSA_LIGHT := 4
    static PROTECTION_LEVEL_WINTCB := 5
    static PROTECTION_LEVEL_CODEGEN_LIGHT := 6
    static PROTECTION_LEVEL_AUTHENTICODE := 7
    static PROTECTION_LEVEL_PPL_APP := 8
    static PROTECTION_LEVEL_NONE := 4294967294
}
struct POWER_REQUEST_CONTEXT_FLAGS extends UInt32 {
    static POWER_REQUEST_CONTEXT_DETAILED_STRING := 2
    static POWER_REQUEST_CONTEXT_SIMPLE_STRING := 1
}
struct THREAD_ACCESS_RIGHTS extends UInt32 {
    static THREAD_TERMINATE := 1
    static THREAD_SUSPEND_RESUME := 2
    static THREAD_GET_CONTEXT := 8
    static THREAD_SET_CONTEXT := 16
    static THREAD_SET_INFORMATION := 32
    static THREAD_QUERY_INFORMATION := 64
    static THREAD_SET_THREAD_TOKEN := 128
    static THREAD_IMPERSONATE := 256
    static THREAD_DIRECT_IMPERSONATION := 512
    static THREAD_SET_LIMITED_INFORMATION := 1024
    static THREAD_QUERY_LIMITED_INFORMATION := 2048
    static THREAD_RESUME := 4096
    static THREAD_ALL_ACCESS := 2097151
    static THREAD_DELETE := 65536
    static THREAD_READ_CONTROL := 131072
    static THREAD_WRITE_DAC := 262144
    static THREAD_WRITE_OWNER := 524288
    static THREAD_SYNCHRONIZE := 1048576
    static THREAD_STANDARD_RIGHTS_REQUIRED := 983040
}
struct SYNCHRONIZATION_ACCESS_RIGHTS extends UInt32 {
    static EVENT_ALL_ACCESS := 2031619
    static EVENT_MODIFY_STATE := 2
    static MUTEX_ALL_ACCESS := 2031617
    static MUTEX_MODIFY_STATE := 1
    static SEMAPHORE_ALL_ACCESS := 2031619
    static SEMAPHORE_MODIFY_STATE := 2
    static TIMER_ALL_ACCESS := 2031619
    static TIMER_MODIFY_STATE := 2
    static TIMER_QUERY_STATE := 1
    static SYNCHRONIZATION_DELETE := 65536
    static SYNCHRONIZATION_READ_CONTROL := 131072
    static SYNCHRONIZATION_WRITE_DAC := 262144
    static SYNCHRONIZATION_WRITE_OWNER := 524288
    static SYNCHRONIZATION_SYNCHRONIZE := 1048576
}
struct PROCESS_BASIC_INFORMATION {
    ExitStatus : NTSTATUS
    PebBaseAddress : PEB.Ptr
    AffinityMask : IntPtr
    BasePriority : Int32
    UniqueProcessId : IntPtr
    InheritedFromUniqueProcessId : IntPtr
}
struct PROCESS_CREATION_FLAGS extends UInt32 {
    static DEBUG_PROCESS := 1
    static DEBUG_ONLY_THIS_PROCESS := 2
    static CREATE_SUSPENDED := 4
    static DETACHED_PROCESS := 8
    static CREATE_NEW_CONSOLE := 16
    static NORMAL_PRIORITY_CLASS := 32
    static IDLE_PRIORITY_CLASS := 64
    static HIGH_PRIORITY_CLASS := 128
    static REALTIME_PRIORITY_CLASS := 256
    static CREATE_NEW_PROCESS_GROUP := 512
    static CREATE_UNICODE_ENVIRONMENT := 1024
    static CREATE_SEPARATE_WOW_VDM := 2048
    static CREATE_SHARED_WOW_VDM := 4096
    static CREATE_FORCEDOS := 8192
    static BELOW_NORMAL_PRIORITY_CLASS := 16384
    static ABOVE_NORMAL_PRIORITY_CLASS := 32768
    static INHERIT_PARENT_AFFINITY := 65536
    static INHERIT_CALLER_PRIORITY := 131072
    static CREATE_PROTECTED_PROCESS := 262144
    static EXTENDED_STARTUPINFO_PRESENT := 524288
    static PROCESS_MODE_BACKGROUND_BEGIN := 1048576
    static PROCESS_MODE_BACKGROUND_END := 2097152
    static CREATE_SECURE_PROCESS := 4194304
    static CREATE_BREAKAWAY_FROM_JOB := 16777216
    static CREATE_PRESERVE_CODE_AUTHZ_LEVEL := 33554432
    static CREATE_DEFAULT_ERROR_MODE := 67108864
    static CREATE_NO_WINDOW := 134217728
    static PROFILE_USER := 268435456
    static PROFILE_KERNEL := 536870912
    static PROFILE_SERVER := 1073741824
    static CREATE_IGNORE_SYSTEM_DEFAULT := 2147483648
}
struct PROCESS_ACCESS_RIGHTS extends UInt32 {
    static PROCESS_TERMINATE := 1
    static PROCESS_CREATE_THREAD := 2
    static PROCESS_SET_SESSIONID := 4
    static PROCESS_VM_OPERATION := 8
    static PROCESS_VM_READ := 16
    static PROCESS_VM_WRITE := 32
    static PROCESS_DUP_HANDLE := 64
    static PROCESS_CREATE_PROCESS := 128
    static PROCESS_SET_QUOTA := 256
    static PROCESS_SET_INFORMATION := 512
    static PROCESS_QUERY_INFORMATION := 1024
    static PROCESS_SUSPEND_RESUME := 2048
    static PROCESS_QUERY_LIMITED_INFORMATION := 4096
    static PROCESS_SET_LIMITED_INFORMATION := 8192
    static PROCESS_ALL_ACCESS := 2097151
    static PROCESS_DELETE := 65536
    static PROCESS_READ_CONTROL := 131072
    static PROCESS_WRITE_DAC := 262144
    static PROCESS_WRITE_OWNER := 524288
    static PROCESS_SYNCHRONIZE := 1048576
    static PROCESS_STANDARD_RIGHTS_REQUIRED := 983040
}
struct PTP_POOL {
    Value : IntPtr
}
struct PTP_CLEANUP_GROUP {
    Value : IntPtr
}
struct AVRT_TASK_HANDLE {
    Value : Struct.Ptr
}
struct AVRT_THREAD_ORDERING_GROUP_HANDLE {
    Value : Struct.Ptr
}
struct LPPROC_THREAD_ATTRIBUTE_LIST {
    Value : Struct.Ptr
}
struct PTP_IO {
    Value : IntPtr
}
struct PTP_TIMER {
    Value : IntPtr
}
struct PTP_WAIT {
    Value : IntPtr
}
struct PTP_WORK {
    Value : IntPtr
}
struct PTP_CALLBACK_INSTANCE {
    Value : IntPtr
}
struct REASON_CONTEXT {
    Version : UInt32
    Flags : POWER_REQUEST_CONTEXT_FLAGS
    Reason : this._Reason_e__Union
    struct _Reason_e__Union {
        union {
            Detailed : this._Detailed_e__Struct
            SimpleReasonString : PWSTR
        }
        struct _Detailed_e__Struct {
            LocalizedReasonModule : HMODULE
            LocalizedReasonId : UInt32
            ReasonStringCount : UInt32
            ReasonStrings : PWSTR.Ptr
        }
    }
}
struct LPTHREAD_START_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PINIT_ONCE_FN extends FunctionPointer {
    static Types := [INIT_ONCE.Ptr, Struct.Ptr, Struct.Ptr.Ptr, BOOL]
}
struct PTIMERAPCROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, "Void"]
}
struct PROCESS_INFORMATION {
    hProcess : HANDLE
    hThread : HANDLE
    dwProcessId : UInt32
    dwThreadId : UInt32
}
struct STARTUPINFOA {
    cb : UInt32
    lpReserved : PSTR
    lpDesktop : PSTR
    lpTitle : PSTR
    dwX : UInt32
    dwY : UInt32
    dwXSize : UInt32
    dwYSize : UInt32
    dwXCountChars : UInt32
    dwYCountChars : UInt32
    dwFillAttribute : UInt32
    dwFlags : STARTUPINFOW_FLAGS
    wShowWindow : UInt16
    cbReserved2 : UInt16
    lpReserved2 : UInt8.Ptr
    hStdInput : HANDLE
    hStdOutput : HANDLE
    hStdError : HANDLE
}
struct STARTUPINFOW {
    cb : UInt32
    lpReserved : PWSTR
    lpDesktop : PWSTR
    lpTitle : PWSTR
    dwX : UInt32
    dwY : UInt32
    dwXSize : UInt32
    dwYSize : UInt32
    dwXCountChars : UInt32
    dwYCountChars : UInt32
    dwFillAttribute : UInt32
    dwFlags : STARTUPINFOW_FLAGS
    wShowWindow : UInt16
    cbReserved2 : UInt16
    lpReserved2 : UInt8.Ptr
    hStdInput : HANDLE
    hStdOutput : HANDLE
    hStdError : HANDLE
}
struct QUEUE_USER_APC_FLAGS extends Int32 {
    static QUEUE_USER_APC_FLAGS_NONE := 0
    static QUEUE_USER_APC_FLAGS_SPECIAL_USER_APC := 1
    static QUEUE_USER_APC_CALLBACK_DATA_CONTEXT := 65536
}
struct THREAD_INFORMATION_CLASS extends Int32 {
    static ThreadMemoryPriority := 0
    static ThreadAbsoluteCpuPriority := 1
    static ThreadDynamicCodePolicy := 2
    static ThreadPowerThrottling := 3
    static ThreadInformationClassMax := 4
}
struct MEMORY_PRIORITY_INFORMATION {
    MemoryPriority : MEMORY_PRIORITY
}
struct THREAD_POWER_THROTTLING_STATE {
    Version : UInt32
    ControlMask : UInt32
    StateMask : UInt32
}
struct PROCESS_INFORMATION_CLASS extends Int32 {
    static ProcessMemoryPriority := 0
    static ProcessMemoryExhaustionInfo := 1
    static ProcessAppMemoryInfo := 2
    static ProcessInPrivateInfo := 3
    static ProcessPowerThrottling := 4
    static ProcessReservedValue1 := 5
    static ProcessTelemetryCoverageInfo := 6
    static ProcessProtectionLevelInfo := 7
    static ProcessLeapSecondInfo := 8
    static ProcessMachineTypeInfo := 9
    static ProcessOverrideSubsequentPrefetchParameter := 10
    static ProcessMaxOverridePrefetchParameter := 11
    static ProcessInformationClassMax := 12
}
struct APP_MEMORY_INFORMATION {
    AvailableCommit : Int64
    PrivateCommitUsage : Int64
    PeakPrivateCommitUsage : Int64
    TotalCommitUsage : Int64
}
struct MACHINE_ATTRIBUTES extends Int32 {
    static UserEnabled := 1
    static KernelEnabled := 2
    static Wow64Container := 4
}
struct PROCESS_MACHINE_INFORMATION {
    ProcessMachine : IMAGE_FILE_MACHINE
    Res0 : UInt16
    MachineAttributes : MACHINE_ATTRIBUTES
}
struct OVERRIDE_PREFETCH_PARAMETER {
    Value : UInt32
}
struct PROCESS_MEMORY_EXHAUSTION_TYPE extends Int32 {
    static PMETypeFailFastOnCommitFailure := 0
    static PMETypeMax := 1
}
struct PROCESS_MEMORY_EXHAUSTION_INFO {
    Version : UInt16
    Reserved : UInt16
    Type : PROCESS_MEMORY_EXHAUSTION_TYPE
    Value : IntPtr
}
struct PROCESS_POWER_THROTTLING_STATE {
    Version : UInt32
    ControlMask : UInt32
    StateMask : UInt32
}
struct PROCESS_PROTECTION_LEVEL_INFORMATION {
    ProtectionLevel : PROCESS_PROTECTION_LEVEL
}
struct PROCESS_LEAP_SECOND_INFO {
    Flags : UInt32
    Reserved : UInt32
}
struct PTP_WIN32_IO_CALLBACK extends FunctionPointer {
    static Types := [PTP_CALLBACK_INSTANCE, Struct.Ptr, Struct.Ptr, UInt32, IntPtr, PTP_IO, "Void"]
}
struct AVRT_PRIORITY extends Int32 {
    static AVRT_PRIORITY_VERYLOW := -2
    static AVRT_PRIORITY_LOW := -1
    static AVRT_PRIORITY_NORMAL := 0
    static AVRT_PRIORITY_HIGH := 1
    static AVRT_PRIORITY_CRITICAL := 2
}
struct RTWQPERIODICCALLBACK extends FunctionPointer {
    static Types := [IUnknown, "Void"]
}
struct RTWQ_WORKQUEUE_TYPE extends Int32 {
    static RTWQ_STANDARD_WORKQUEUE := 0
    static RTWQ_WINDOW_WORKQUEUE := 1
    static RTWQ_MULTITHREADED_WORKQUEUE := 2
}
struct IRtwqAsyncResult extends IUnknown {
    static IID := "{AC6B7889-0740-4D51-8619-905994A55CC6}"
    GetState(ppunkState)
      => ComCall(3, this.p, IUnknown.Ptr, ppunkState)
    GetStatus()
      => ComCall(4, this.p)
    SetStatus(hrStatus)
      => ComCall(5, this.p, HRESULT, hrStatus)
    GetObject(ppObject)
      => ComCall(6, this.p, IUnknown.Ptr, ppObject)
    GetStateNoAddRef()
      => ComCall(7, this.p, IUnknown)
}
struct IRtwqAsyncCallback extends IUnknown {
    static IID := "{A27003CF-2354-4F2A-8D6A-AB7CFF15437E}"
    GetParameters(pdwFlags, pdwQueue)
      => ComCall(3, this.p, UInt32.Ptr, pdwFlags, UInt32.Ptr, pdwQueue)
    Invoke(pAsyncResult)
      => ComCall(4, this.p, IRtwqAsyncResult, pAsyncResult)
}
struct RTWQASYNCRESULT extends IRtwqAsyncResult {
}
struct IRtwqPlatformEvents extends IUnknown {
    static IID := "{63D9255A-7FF1-4B61-8FAF-ED6460DACF2B}"
    InitializationComplete()
      => ComCall(3, this.p)
    ShutdownStart()
      => ComCall(4, this.p)
    ShutdownComplete()
      => ComCall(5, this.p)
}
struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGET {
    TargetAddress : IntPtr
    Flags : IntPtr
}
struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGETS_INFORMATION {
    NumberOfTargets : UInt16
    Reserved : UInt16
    Reserved2 : UInt32
    Targets : PROCESS_DYNAMIC_EH_CONTINUATION_TARGET.Ptr
}
struct PROCESS_DYNAMIC_ENFORCED_ADDRESS_RANGE {
    BaseAddress : IntPtr
    Size : IntPtr
    Flags : UInt32
}
struct PROCESS_DYNAMIC_ENFORCED_ADDRESS_RANGES_INFORMATION {
    NumberOfRanges : UInt16
    Reserved : UInt16
    Reserved2 : UInt32
    Ranges : PROCESS_DYNAMIC_ENFORCED_ADDRESS_RANGE.Ptr
}
struct IO_COUNTERS {
    ReadOperationCount : Int64
    WriteOperationCount : Int64
    OtherOperationCount : Int64
    ReadTransferCount : Int64
    WriteTransferCount : Int64
    OtherTransferCount : Int64
}
struct PROCESS_MITIGATION_POLICY extends Int32 {
    static ProcessDEPPolicy := 0
    static ProcessASLRPolicy := 1
    static ProcessDynamicCodePolicy := 2
    static ProcessStrictHandleCheckPolicy := 3
    static ProcessSystemCallDisablePolicy := 4
    static ProcessMitigationOptionsMask := 5
    static ProcessExtensionPointDisablePolicy := 6
    static ProcessControlFlowGuardPolicy := 7
    static ProcessSignaturePolicy := 8
    static ProcessFontDisablePolicy := 9
    static ProcessImageLoadPolicy := 10
    static ProcessSystemCallFilterPolicy := 11
    static ProcessPayloadRestrictionPolicy := 12
    static ProcessChildProcessPolicy := 13
    static ProcessSideChannelIsolationPolicy := 14
    static ProcessUserShadowStackPolicy := 15
    static ProcessRedirectionTrustPolicy := 16
    static ProcessUserPointerAuthPolicy := 17
    static ProcessSEHOPPolicy := 18
    static ProcessActivationContextTrustPolicy := 19
    static MaxProcessMitigationPolicy := 20
}
struct INIT_ONCE {
    union {
        Ptr : Struct.Ptr
    }
}
struct SYNCHRONIZATION_BARRIER {
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : IntPtr[2]
    Reserved4 : UInt32
    Reserved5 : UInt32
}
struct UMS_THREAD_INFO_CLASS extends Int32 {
    static UmsThreadInvalidInfoClass := 0
    static UmsThreadUserContext := 1
    static UmsThreadPriority := 2
    static UmsThreadAffinity := 3
    static UmsThreadTeb := 4
    static UmsThreadIsSuspended := 5
    static UmsThreadIsTerminated := 6
    static UmsThreadMaxInfoClass := 7
}
struct PRTL_UMS_SCHEDULER_ENTRY_POINT extends FunctionPointer {
    static Types := [RTL_UMS_SCHEDULER_REASON, IntPtr, Struct.Ptr, "Void"]
}
struct CRITICAL_SECTION_DEBUG {
    Type : UInt16
    CreatorBackTraceIndex : UInt16
    CriticalSection : CRITICAL_SECTION.Ptr
    ProcessLocksList : LIST_ENTRY
    EntryCount : UInt32
    ContentionCount : UInt32
    Flags : UInt32
    CreatorBackTraceIndexHigh : UInt16
    Identifier : UInt16
}
struct CRITICAL_SECTION {
    DebugInfo : CRITICAL_SECTION_DEBUG.Ptr
    LockCount : Int32
    RecursionCount : Int32
    OwningThread : HANDLE
    LockSemaphore : HANDLE
    SpinCount : IntPtr
}
struct SRWLOCK {
    Ptr : Struct.Ptr
}
struct CONDITION_VARIABLE {
    Ptr : Struct.Ptr
}
struct WAITORTIMERCALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, BOOLEAN, "Void"]
}
struct WORKERCALLBACKFUNC extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct APC_CALLBACK_FUNCTION extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, Struct.Ptr, "Void"]
}
struct PFLS_CALLBACK_FUNCTION extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PTP_SIMPLE_CALLBACK extends FunctionPointer {
    static Types := [PTP_CALLBACK_INSTANCE, Struct.Ptr, "Void"]
}
struct TP_CALLBACK_PRIORITY extends Int32 {
    static TP_CALLBACK_PRIORITY_HIGH := 0
    static TP_CALLBACK_PRIORITY_NORMAL := 1
    static TP_CALLBACK_PRIORITY_LOW := 2
    static TP_CALLBACK_PRIORITY_INVALID := 3
    static TP_CALLBACK_PRIORITY_COUNT := 3
}
struct TP_POOL_STACK_INFORMATION {
    StackReserve : IntPtr
    StackCommit : IntPtr
}
struct PTP_CLEANUP_GROUP_CANCEL_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct TP_CALLBACK_ENVIRON_V3 {
    Version : UInt32
    Pool : PTP_POOL
    CleanupGroup : PTP_CLEANUP_GROUP
    CleanupGroupCancelCallback : PTP_CLEANUP_GROUP_CANCEL_CALLBACK
    RaceDll : Struct.Ptr
    ActivationContext : IntPtr
    FinalizationCallback : PTP_SIMPLE_CALLBACK
    u : this._u_e__Union
    CallbackPriority : TP_CALLBACK_PRIORITY
    Size : UInt32
    struct _u_e__Union {
        union {
            Flags : UInt32
            s : this._s_e__Struct
        }
        struct _s_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PTP_WORK_CALLBACK extends FunctionPointer {
    static Types := [PTP_CALLBACK_INSTANCE, Struct.Ptr, PTP_WORK, "Void"]
}
struct PTP_TIMER_CALLBACK extends FunctionPointer {
    static Types := [PTP_CALLBACK_INSTANCE, Struct.Ptr, PTP_TIMER, "Void"]
}
struct PTP_WAIT_CALLBACK extends FunctionPointer {
    static Types := [PTP_CALLBACK_INSTANCE, Struct.Ptr, PTP_WAIT, UInt32, "Void"]
}
struct LPFIBER_START_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct UMS_SCHEDULER_STARTUP_INFO {
    UmsVersion : UInt32
    CompletionList : Struct.Ptr
    SchedulerProc : PRTL_UMS_SCHEDULER_ENTRY_POINT
    SchedulerParam : Struct.Ptr
}
struct UMS_SYSTEM_THREAD_INFORMATION {
    UmsVersion : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ThreadUmsFlags : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct STARTUPINFOEXA {
    StartupInfo : STARTUPINFOA
    lpAttributeList : LPPROC_THREAD_ATTRIBUTE_LIST
}
struct STARTUPINFOEXW {
    StartupInfo : STARTUPINFOW
    lpAttributeList : LPPROC_THREAD_ATTRIBUTE_LIST
}
struct PROC_THREAD_ATTRIBUTE_NUM extends UInt32 {
    static ProcThreadAttributeParentProcess := 0
    static ProcThreadAttributeHandleList := 2
    static ProcThreadAttributeGroupAffinity := 3
    static ProcThreadAttributePreferredNode := 4
    static ProcThreadAttributeIdealProcessor := 5
    static ProcThreadAttributeUmsThread := 6
    static ProcThreadAttributeMitigationPolicy := 7
    static ProcThreadAttributeSecurityCapabilities := 9
    static ProcThreadAttributeProtectionLevel := 11
    static ProcThreadAttributeJobList := 13
    static ProcThreadAttributeChildProcessPolicy := 14
    static ProcThreadAttributeAllApplicationPackagesPolicy := 15
    static ProcThreadAttributeWin32kFilter := 16
    static ProcThreadAttributeSafeOpenPromptOriginClaim := 17
    static ProcThreadAttributeDesktopAppPolicy := 18
    static ProcThreadAttributePseudoConsole := 22
    static ProcThreadAttributeMitigationAuditPolicy := 24
    static ProcThreadAttributeMachineType := 25
    static ProcThreadAttributeComponentFilter := 26
    static ProcThreadAttributeEnableOptionalXStateFeatures := 27
    static ProcThreadAttributeTrustedApp := 29
    static ProcThreadAttributeSveVectorLength := 30
    static ProcThreadAttributeSmeVectorLength := 31
    static ProcThreadAttributeContainmentConfiguration := 33
}
struct PEB_LDR_DATA {
    Reserved1 : UInt8[8]
    Reserved2 : Struct.Ptr[3]
    InMemoryOrderModuleList : LIST_ENTRY
}
struct RTL_USER_PROCESS_PARAMETERS {
    Reserved1 : UInt8[16]
    Reserved2 : Struct.Ptr[10]
    ImagePathName : UNICODE_STRING
    CommandLine : UNICODE_STRING
}
struct PPS_POST_PROCESS_INIT_ROUTINE extends FunctionPointer {
    static Types := ["Void"]
}
struct PEB {
    Reserved1 : UInt8[2]
    BeingDebugged : UInt8
    Reserved2 : UInt8[1]
    Reserved3 : Struct.Ptr[2]
    Ldr : PEB_LDR_DATA.Ptr
    ProcessParameters : RTL_USER_PROCESS_PARAMETERS.Ptr
    Reserved4 : Struct.Ptr[3]
    AtlThunkSListPtr : Struct.Ptr
    Reserved5 : Struct.Ptr
    Reserved6 : UInt32
    Reserved7 : Struct.Ptr
    Reserved8 : UInt32
    AtlThunkSListPtr32 : UInt32
    Reserved9 : Struct.Ptr[45]
    Reserved10 : UInt8[96]
    PostProcessInitRoutine : PPS_POST_PROCESS_INIT_ROUTINE
    Reserved11 : UInt8[128]
    Reserved12 : Struct.Ptr[1]
    SessionId : UInt32
}
struct TEB {
    Reserved1 : Struct.Ptr[12]
    ProcessEnvironmentBlock : PEB.Ptr
    Reserved2 : Struct.Ptr[399]
    Reserved3 : UInt8[1952]
    TlsSlots : Struct.Ptr[64]
    Reserved4 : UInt8[8]
    Reserved5 : Struct.Ptr[26]
    ReservedForOle : Struct.Ptr
    Reserved6 : Struct.Ptr[4]
    TlsExpansionSlots : Struct.Ptr
}
