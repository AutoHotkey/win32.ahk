#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, PWSTR}
#Import "..\Security\Types.ahk" {SECURITY_DESCRIPTOR}

struct HCS_OPERATION {
    Value : IntPtr
}
struct HCS_SYSTEM {
    Value : IntPtr
}
struct HCS_PROCESS {
    Value : IntPtr
}
struct HCS_OPERATION_TYPE extends Int32 {
    static HcsOperationTypeNone := -1
    static HcsOperationTypeEnumerate := 0
    static HcsOperationTypeCreate := 1
    static HcsOperationTypeStart := 2
    static HcsOperationTypeShutdown := 3
    static HcsOperationTypePause := 4
    static HcsOperationTypeResume := 5
    static HcsOperationTypeSave := 6
    static HcsOperationTypeTerminate := 7
    static HcsOperationTypeModify := 8
    static HcsOperationTypeGetProperties := 9
    static HcsOperationTypeCreateProcess := 10
    static HcsOperationTypeSignalProcess := 11
    static HcsOperationTypeGetProcessInfo := 12
    static HcsOperationTypeGetProcessProperties := 13
    static HcsOperationTypeModifyProcess := 14
    static HcsOperationTypeCrash := 15
    static HcsOperationTypeLiveMigration := 19
    static HcsOperationTypeReserved1 := 16
    static HcsOperationTypeReserved2 := 17
    static HcsOperationTypeReserved3 := 18
}
struct HCS_OPERATION_COMPLETION extends FunctionPointer {
    static Types := [HCS_OPERATION, Struct.Ptr, "Void"]
}
struct HCS_EVENT_TYPE extends Int32 {
    static HcsEventInvalid := 0
    static HcsEventSystemExited := 1
    static HcsEventSystemCrashInitiated := 2
    static HcsEventSystemCrashReport := 3
    static HcsEventSystemRdpEnhancedModeStateChanged := 4
    static HcsEventSystemSiloJobCreated := 5
    static HcsEventSystemGuestConnectionClosed := 6
    static HcsEventProcessExited := 65536
    static HcsEventOperationCallback := 16777216
    static HcsEventServiceDisconnect := 33554432
    static HcsEventGroupVmLifecycle := -2147483646
    static HcsEventGroupLiveMigration := -2147483645
    static HcsEventGroupOperationInfo := -1073741823
}
struct HCS_EVENT {
    Type : HCS_EVENT_TYPE
    EventData : PWSTR
    Operation : HCS_OPERATION
}
struct HCS_EVENT_OPTIONS extends Int32 {
    static HcsEventOptionNone := 0
    static HcsEventOptionEnableOperationCallbacks := 1
    static HcsEventOptionEnableVmLifecycle := 2
    static HcsEventOptionEnableLiveMigrationEvents := 4
}
struct HCS_OPERATION_OPTIONS extends Int32 {
    static HcsOperationOptionNone := 0
    static HcsOperationOptionProgressUpdate := 1
    static HcsOperationOptionReserved1 := 2
}
struct HCS_EVENT_CALLBACK extends FunctionPointer {
    static Types := [HCS_EVENT.Ptr, Struct.Ptr, "Void"]
}
struct HCS_RESOURCE_TYPE extends Int32 {
    static HcsResourceTypeNone := 0
    static HcsResourceTypeFile := 1
    static HcsResourceTypeJob := 2
    static HcsResourceTypeComObject := 3
    static HcsResourceTypeSocket := 4
    static HcsResourceTypeSection := 5
}
struct HCS_NOTIFICATION_FLAGS extends Int32 {
    static HcsNotificationFlagSuccess := 0
    static HcsNotificationFlagFailure := -2147483648
}
struct HCS_NOTIFICATIONS extends Int32 {
    static HcsNotificationInvalid := 0
    static HcsNotificationSystemExited := 1
    static HcsNotificationSystemCreateCompleted := 2
    static HcsNotificationSystemStartCompleted := 3
    static HcsNotificationSystemPauseCompleted := 4
    static HcsNotificationSystemResumeCompleted := 5
    static HcsNotificationSystemCrashReport := 6
    static HcsNotificationSystemSiloJobCreated := 7
    static HcsNotificationSystemSaveCompleted := 8
    static HcsNotificationSystemRdpEnhancedModeStateChanged := 9
    static HcsNotificationSystemShutdownFailed := 10
    static HcsNotificationSystemShutdownCompleted := 10
    static HcsNotificationSystemGetPropertiesCompleted := 11
    static HcsNotificationSystemModifyCompleted := 12
    static HcsNotificationSystemCrashInitiated := 13
    static HcsNotificationSystemGuestConnectionClosed := 14
    static HcsNotificationSystemOperationCompletion := 15
    static HcsNotificationSystemPassThru := 16
    static HcsNotificationOperationProgressUpdate := 256
    static HcsNotificationProcessExited := 65536
    static HcsNotificationServiceDisconnect := 16777216
    static HcsNotificationFlagsReserved := -268435456
}
struct HCS_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, HRESULT, PWSTR, "Void"]
}
struct HCS_PROCESS_INFORMATION {
    ProcessId : UInt32
    Reserved : UInt32
    StdInput : HANDLE
    StdOutput : HANDLE
    StdError : HANDLE
}
struct HCS_CREATE_OPTIONS extends Int32 {
    static HcsCreateOptions_1 := 65536
}
struct HCS_CREATE_OPTIONS_1 {
    Version : HCS_CREATE_OPTIONS
    UserToken : HANDLE
    SecurityDescriptor : SECURITY_DESCRIPTOR.Ptr
    CallbackOptions : HCS_EVENT_OPTIONS
    CallbackContext : Struct.Ptr
    Callback : HCS_EVENT_CALLBACK
}
