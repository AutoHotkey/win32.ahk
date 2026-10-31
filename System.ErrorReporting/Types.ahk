#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HANDLE, HRESULT, HWND, PSTR, PWSTR}
#Import "..\System.Diagnostics.Debug\Types.ahk" {CONTEXT, EXCEPTION_POINTERS, EXCEPTION_RECORD}

struct WER_FILE extends UInt32 {
    static WER_FILE_ANONYMOUS_DATA := 2
    static WER_FILE_DELETE_WHEN_DONE := 1
}
struct WER_SUBMIT_FLAGS extends UInt32 {
    static WER_SUBMIT_ADD_REGISTERED_DATA := 16
    static WER_SUBMIT_HONOR_RECOVERY := 1
    static WER_SUBMIT_HONOR_RESTART := 2
    static WER_SUBMIT_NO_ARCHIVE := 256
    static WER_SUBMIT_NO_CLOSE_UI := 64
    static WER_SUBMIT_NO_QUEUE := 128
    static WER_SUBMIT_OUTOFPROCESS := 32
    static WER_SUBMIT_OUTOFPROCESS_ASYNC := 1024
    static WER_SUBMIT_QUEUE := 4
    static WER_SUBMIT_SHOW_DEBUG := 8
    static WER_SUBMIT_START_MINIMIZED := 512
    static WER_SUBMIT_BYPASS_DATA_THROTTLING := 2048
    static WER_SUBMIT_ARCHIVE_PARAMETERS_ONLY := 4096
    static WER_SUBMIT_REPORT_MACHINE_ID := 8192
}
struct WER_FAULT_REPORTING extends UInt32 {
    static WER_FAULT_REPORTING_FLAG_DISABLE_THREAD_SUSPENSION := 4
    static WER_FAULT_REPORTING_FLAG_NOHEAP := 1
    static WER_FAULT_REPORTING_FLAG_QUEUE := 2
    static WER_FAULT_REPORTING_FLAG_QUEUE_UPLOAD := 8
    static WER_FAULT_REPORTING_ALWAYS_SHOW_UI := 16
}
struct HREPORT {
    Value : IntPtr
}
struct HREPORTSTORE {
    Value : IntPtr
}
struct WER_REPORT_UI extends Int32 {
    static WerUIAdditionalDataDlgHeader := 1
    static WerUIIconFilePath := 2
    static WerUIConsentDlgHeader := 3
    static WerUIConsentDlgBody := 4
    static WerUIOnlineSolutionCheckText := 5
    static WerUIOfflineSolutionCheckText := 6
    static WerUICloseText := 7
    static WerUICloseDlgHeader := 8
    static WerUICloseDlgBody := 9
    static WerUICloseDlgButtonText := 10
    static WerUIMax := 11
}
struct WER_REGISTER_FILE_TYPE extends Int32 {
    static WerRegFileTypeUserDocument := 1
    static WerRegFileTypeOther := 2
    static WerRegFileTypeMax := 3
}
struct WER_FILE_TYPE extends Int32 {
    static WerFileTypeMicrodump := 1
    static WerFileTypeMinidump := 2
    static WerFileTypeHeapdump := 3
    static WerFileTypeUserDocument := 4
    static WerFileTypeOther := 5
    static WerFileTypeTriagedump := 6
    static WerFileTypeCustomDump := 7
    static WerFileTypeAuxiliaryDump := 8
    static WerFileTypeEtlTrace := 9
    static WerFileTypeAuxiliaryHeapDump := 10
    static WerFileTypeMax := 11
}
struct WER_SUBMIT_RESULT extends Int32 {
    static WerReportQueued := 1
    static WerReportUploaded := 2
    static WerReportDebug := 3
    static WerReportFailed := 4
    static WerDisabled := 5
    static WerReportCancelled := 6
    static WerDisabledQueue := 7
    static WerReportAsync := 8
    static WerCustomAction := 9
    static WerThrottled := 10
    static WerReportUploadedCab := 11
    static WerStorageLocationNotFound := 12
    static WerSubmitResultMax := 13
}
struct WER_REPORT_TYPE extends Int32 {
    static WerReportNonCritical := 0
    static WerReportCritical := 1
    static WerReportApplicationCrash := 2
    static WerReportApplicationHang := 3
    static WerReportKernel := 4
    static WerReportInvalid := 5
}
struct WER_REPORT_INFORMATION {
    dwSize : UInt32
    hProcess : HANDLE
    wzConsentKey : UInt16[64]
    wzFriendlyEventName : UInt16[128]
    wzApplicationName : UInt16[128]
    wzApplicationPath : UInt16[260]
    wzDescription : UInt16[512]
    hwndParent : HWND
}
struct WER_REPORT_INFORMATION_V3 {
    dwSize : UInt32
    hProcess : HANDLE
    wzConsentKey : UInt16[64]
    wzFriendlyEventName : UInt16[128]
    wzApplicationName : UInt16[128]
    wzApplicationPath : UInt16[260]
    wzDescription : UInt16[512]
    hwndParent : HWND
    wzNamespacePartner : UInt16[64]
    wzNamespaceGroup : UInt16[64]
}
struct WER_DUMP_CUSTOM_OPTIONS {
    dwSize : UInt32
    dwMask : UInt32
    dwDumpFlags : UInt32
    bOnlyThisThread : BOOL
    dwExceptionThreadFlags : UInt32
    dwOtherThreadFlags : UInt32
    dwExceptionThreadExFlags : UInt32
    dwOtherThreadExFlags : UInt32
    dwPreferredModuleFlags : UInt32
    dwOtherModuleFlags : UInt32
    wzPreferredModuleList : UInt16[256]
}
struct WER_DUMP_CUSTOM_OPTIONS_V2 {
    dwSize : UInt32
    dwMask : UInt32
    dwDumpFlags : UInt32
    bOnlyThisThread : BOOL
    dwExceptionThreadFlags : UInt32
    dwOtherThreadFlags : UInt32
    dwExceptionThreadExFlags : UInt32
    dwOtherThreadExFlags : UInt32
    dwPreferredModuleFlags : UInt32
    dwOtherModuleFlags : UInt32
    wzPreferredModuleList : UInt16[256]
    dwPreferredModuleResetFlags : UInt32
    dwOtherModuleResetFlags : UInt32
}
struct WER_REPORT_INFORMATION_V4 {
    dwSize : UInt32
    hProcess : HANDLE
    wzConsentKey : UInt16[64]
    wzFriendlyEventName : UInt16[128]
    wzApplicationName : UInt16[128]
    wzApplicationPath : UInt16[260]
    wzDescription : UInt16[512]
    hwndParent : HWND
    wzNamespacePartner : UInt16[64]
    wzNamespaceGroup : UInt16[64]
    rgbApplicationIdentity : UInt8[16]
    hSnapshot : HANDLE
    hDeleteFilesImpersonationToken : HANDLE
}
struct WER_REPORT_INFORMATION_V5 {
    dwSize : UInt32
    hProcess : HANDLE
    wzConsentKey : UInt16[64]
    wzFriendlyEventName : UInt16[128]
    wzApplicationName : UInt16[128]
    wzApplicationPath : UInt16[260]
    wzDescription : UInt16[512]
    hwndParent : HWND
    wzNamespacePartner : UInt16[64]
    wzNamespaceGroup : UInt16[64]
    rgbApplicationIdentity : UInt8[16]
    hSnapshot : HANDLE
    hDeleteFilesImpersonationToken : HANDLE
    submitResultMax : WER_SUBMIT_RESULT
}
struct WER_DUMP_CUSTOM_OPTIONS_V3 {
    dwSize : UInt32
    dwMask : UInt32
    dwDumpFlags : UInt32
    bOnlyThisThread : BOOL
    dwExceptionThreadFlags : UInt32
    dwOtherThreadFlags : UInt32
    dwExceptionThreadExFlags : UInt32
    dwOtherThreadExFlags : UInt32
    dwPreferredModuleFlags : UInt32
    dwOtherModuleFlags : UInt32
    wzPreferredModuleList : UInt16[256]
    dwPreferredModuleResetFlags : UInt32
    dwOtherModuleResetFlags : UInt32
    pvDumpKey : Struct.Ptr
    hSnapshot : HANDLE
    dwThreadID : UInt32
}
struct WER_EXCEPTION_INFORMATION {
    pExceptionPointers : EXCEPTION_POINTERS.Ptr
    bClientPointers : BOOL
}
struct WER_CONSENT extends Int32 {
    static WerConsentNotAsked := 1
    static WerConsentApproved := 2
    static WerConsentDenied := 3
    static WerConsentAlwaysPrompt := 4
    static WerConsentMax := 5
}
struct WER_DUMP_TYPE extends Int32 {
    static WerDumpTypeNone := 0
    static WerDumpTypeMicroDump := 1
    static WerDumpTypeMiniDump := 2
    static WerDumpTypeHeapDump := 3
    static WerDumpTypeTriageDump := 4
    static WerDumpTypeMax := 5
}
struct WER_RUNTIME_EXCEPTION_INFORMATION {
    dwSize : UInt32
    hProcess : HANDLE
    hThread : HANDLE
    exceptionRecord : EXCEPTION_RECORD
    context : CONTEXT
    pwszReportId : PWSTR
    bIsFatal : BOOL
    dwReserved : UInt32
}
struct PFN_WER_RUNTIME_EXCEPTION_EVENT extends FunctionPointer {
    static Types := [Struct.Ptr, WER_RUNTIME_EXCEPTION_INFORMATION.Ptr, BOOL.Ptr, PWSTR, UInt32.Ptr, UInt32.Ptr, HRESULT]
}
struct PFN_WER_RUNTIME_EXCEPTION_EVENT_SIGNATURE extends FunctionPointer {
    static Types := [Struct.Ptr, WER_RUNTIME_EXCEPTION_INFORMATION.Ptr, UInt32, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, HRESULT]
}
struct PFN_WER_RUNTIME_EXCEPTION_DEBUGGER_LAUNCH extends FunctionPointer {
    static Types := [Struct.Ptr, WER_RUNTIME_EXCEPTION_INFORMATION.Ptr, BOOL.Ptr, PWSTR, UInt32.Ptr, BOOL.Ptr, HRESULT]
}
struct REPORT_STORE_TYPES extends Int32 {
    static E_STORE_USER_ARCHIVE := 0
    static E_STORE_USER_QUEUE := 1
    static E_STORE_MACHINE_ARCHIVE := 2
    static E_STORE_MACHINE_QUEUE := 3
    static E_STORE_INVALID := 4
}
struct WER_REPORT_PARAMETER {
    Name : UInt16[129]
    Value : UInt16[260]
}
struct WER_REPORT_SIGNATURE {
    EventName : UInt16[65]
    Parameters : WER_REPORT_PARAMETER[10]
}
struct WER_REPORT_METADATA_V2 {
    Signature : WER_REPORT_SIGNATURE
    BucketId : GUID
    ReportId : GUID
    CreationTime : FILETIME
    SizeInBytes : Int64
    CabId : UInt16[260]
    ReportStatus : UInt32
    ReportIntegratorId : GUID
    NumberOfFiles : UInt32
    SizeOfFileNames : UInt32
    FileNames : PWSTR
}
struct WER_REPORT_METADATA_V3 {
    Signature : WER_REPORT_SIGNATURE
    BucketId : GUID
    ReportId : GUID
    CreationTime : FILETIME
    SizeInBytes : Int64
    CabId : UInt16[260]
    ReportStatus : UInt32
    ReportIntegratorId : GUID
    NumberOfFiles : UInt32
    SizeOfFileNames : UInt32
    FileNames : PWSTR
    FriendlyEventName : UInt16[128]
    ApplicationName : UInt16[128]
    ApplicationPath : UInt16[260]
    Description : UInt16[512]
    BucketIdString : UInt16[260]
    LegacyBucketId : Int64
}
struct WER_REPORT_METADATA_V1 {
    Signature : WER_REPORT_SIGNATURE
    BucketId : GUID
    ReportId : GUID
    CreationTime : FILETIME
    SizeInBytes : Int64
}
struct EFaultRepRetVal extends Int32 {
    static frrvOk := 0
    static frrvOkManifest := 1
    static frrvOkQueued := 2
    static frrvErr := 3
    static frrvErrNoDW := 4
    static frrvErrTimeout := 5
    static frrvLaunchDebugger := 6
    static frrvOkHeadless := 7
    static frrvErrAnotherInstance := 8
    static frrvErrNoMemory := 9
    static frrvErrDoubleFault := 10
}
struct pfn_REPORTFAULT extends FunctionPointer {
    static Types := [EXCEPTION_POINTERS.Ptr, UInt32, EFaultRepRetVal]
}
struct pfn_ADDEREXCLUDEDAPPLICATIONA extends FunctionPointer {
    static Types := [PSTR, EFaultRepRetVal]
}
struct pfn_ADDEREXCLUDEDAPPLICATIONW extends FunctionPointer {
    static Types := [PWSTR, EFaultRepRetVal]
}
