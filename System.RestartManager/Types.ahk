#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, PWSTR}

struct RM_APP_TYPE extends Int32 {
    static RmUnknownApp := 0
    static RmMainWindow := 1
    static RmOtherWindow := 2
    static RmService := 3
    static RmExplorer := 4
    static RmConsole := 5
    static RmCritical := 1000
}
struct RM_SHUTDOWN_TYPE extends Int32 {
    static RmForceShutdown := 1
    static RmShutdownOnlyRegistered := 16
}
struct RM_APP_STATUS extends Int32 {
    static RmStatusUnknown := 0
    static RmStatusRunning := 1
    static RmStatusStopped := 2
    static RmStatusStoppedOther := 4
    static RmStatusRestarted := 8
    static RmStatusErrorOnStop := 16
    static RmStatusErrorOnRestart := 32
    static RmStatusShutdownMasked := 64
    static RmStatusRestartMasked := 128
}
struct RM_REBOOT_REASON extends Int32 {
    static RmRebootReasonNone := 0
    static RmRebootReasonPermissionDenied := 1
    static RmRebootReasonSessionMismatch := 2
    static RmRebootReasonCriticalProcess := 4
    static RmRebootReasonCriticalService := 8
    static RmRebootReasonDetectedSelf := 16
}
struct RM_UNIQUE_PROCESS {
    dwProcessId : UInt32
    ProcessStartTime : FILETIME
}
struct RM_PROCESS_INFO {
    Process : RM_UNIQUE_PROCESS
    strAppName : UInt16[256]
    strServiceShortName : UInt16[64]
    ApplicationType : RM_APP_TYPE
    AppStatus : UInt32
    TSSessionId : UInt32
    bRestartable : BOOL
}
struct RM_FILTER_TRIGGER extends Int32 {
    static RmFilterTriggerInvalid := 0
    static RmFilterTriggerFile := 1
    static RmFilterTriggerProcess := 2
    static RmFilterTriggerService := 3
}
struct RM_FILTER_ACTION extends Int32 {
    static RmInvalidFilterAction := 0
    static RmNoRestart := 1
    static RmNoShutdown := 2
}
struct RM_FILTER_INFO {
    FilterAction : RM_FILTER_ACTION
    FilterTrigger : RM_FILTER_TRIGGER
    cbNextOffset : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            strFilename : PWSTR
            Process : RM_UNIQUE_PROCESS
            strServiceShortName : PWSTR
        }
    }
}
struct RM_WRITE_STATUS_CALLBACK extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
