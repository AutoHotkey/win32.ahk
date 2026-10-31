#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, PSTR, PWSTR}

struct ENUM_SERVICE_STATE extends UInt32 {
    static SERVICE_ACTIVE := 1
    static SERVICE_INACTIVE := 2
    static SERVICE_STATE_ALL := 3
}
struct SERVICE_ERROR extends UInt32 {
    static SERVICE_ERROR_CRITICAL := 3
    static SERVICE_ERROR_IGNORE := 0
    static SERVICE_ERROR_NORMAL := 1
    static SERVICE_ERROR_SEVERE := 2
}
struct SERVICE_CONFIG extends UInt32 {
    static SERVICE_CONFIG_DELAYED_AUTO_START_INFO := 3
    static SERVICE_CONFIG_DESCRIPTION := 1
    static SERVICE_CONFIG_FAILURE_ACTIONS := 2
    static SERVICE_CONFIG_FAILURE_ACTIONS_FLAG := 4
    static SERVICE_CONFIG_PREFERRED_NODE := 9
    static SERVICE_CONFIG_PRESHUTDOWN_INFO := 7
    static SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO := 6
    static SERVICE_CONFIG_SERVICE_SID_INFO := 5
    static SERVICE_CONFIG_TRIGGER_INFO := 8
    static SERVICE_CONFIG_LAUNCH_PROTECTED := 12
}
struct ENUM_SERVICE_TYPE extends UInt32 {
    static SERVICE_DRIVER := 11
    static SERVICE_KERNEL_DRIVER := 1
    static SERVICE_WIN32 := 48
    static SERVICE_WIN32_SHARE_PROCESS := 32
    static SERVICE_ADAPTER := 4
    static SERVICE_FILE_SYSTEM_DRIVER := 2
    static SERVICE_RECOGNIZER_DRIVER := 8
    static SERVICE_WIN32_OWN_PROCESS := 16
    static SERVICE_USER_OWN_PROCESS := 80
    static SERVICE_USER_SHARE_PROCESS := 96
}
struct SERVICE_START_TYPE extends UInt32 {
    static SERVICE_AUTO_START := 2
    static SERVICE_BOOT_START := 0
    static SERVICE_DEMAND_START := 3
    static SERVICE_DISABLED := 4
    static SERVICE_SYSTEM_START := 1
}
struct SERVICE_NOTIFY extends UInt32 {
    static SERVICE_NOTIFY_CREATED := 128
    static SERVICE_NOTIFY_CONTINUE_PENDING := 16
    static SERVICE_NOTIFY_DELETE_PENDING := 512
    static SERVICE_NOTIFY_DELETED := 256
    static SERVICE_NOTIFY_PAUSE_PENDING := 32
    static SERVICE_NOTIFY_PAUSED := 64
    static SERVICE_NOTIFY_RUNNING := 8
    static SERVICE_NOTIFY_START_PENDING := 2
    static SERVICE_NOTIFY_STOP_PENDING := 4
    static SERVICE_NOTIFY_STOPPED := 1
}
struct SERVICE_RUNS_IN_PROCESS extends UInt32 {
    static SERVICE_RUNS_IN_NON_SYSTEM_OR_NOT_RUNNING := 0
    static SERVICE_RUNS_IN_SYSTEM_PROCESS := 1
}
struct SERVICE_TRIGGER_ACTION extends UInt32 {
    static SERVICE_TRIGGER_ACTION_SERVICE_START := 1
    static SERVICE_TRIGGER_ACTION_SERVICE_STOP := 2
}
struct SERVICE_TRIGGER_TYPE extends UInt32 {
    static SERVICE_TRIGGER_TYPE_CUSTOM := 20
    static SERVICE_TRIGGER_TYPE_DEVICE_INTERFACE_ARRIVAL := 1
    static SERVICE_TRIGGER_TYPE_DOMAIN_JOIN := 3
    static SERVICE_TRIGGER_TYPE_FIREWALL_PORT_EVENT := 4
    static SERVICE_TRIGGER_TYPE_GROUP_POLICY := 5
    static SERVICE_TRIGGER_TYPE_IP_ADDRESS_AVAILABILITY := 2
    static SERVICE_TRIGGER_TYPE_NETWORK_ENDPOINT := 6
}
struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE extends UInt32 {
    static SERVICE_TRIGGER_DATA_TYPE_BINARY := 1
    static SERVICE_TRIGGER_DATA_TYPE_STRING := 2
    static SERVICE_TRIGGER_DATA_TYPE_LEVEL := 3
    static SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ANY := 4
    static SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ALL := 5
}
struct SERVICE_STATUS_CURRENT_STATE extends UInt32 {
    static SERVICE_CONTINUE_PENDING := 5
    static SERVICE_PAUSE_PENDING := 6
    static SERVICE_PAUSED := 7
    static SERVICE_RUNNING := 4
    static SERVICE_START_PENDING := 2
    static SERVICE_STOP_PENDING := 3
    static SERVICE_STOPPED := 1
}
struct SC_HANDLE {
    Value : Struct.Ptr
}
struct SERVICE_STATUS_HANDLE {
    Value : Struct.Ptr
}
struct PSC_NOTIFICATION_REGISTRATION {
    Value : IntPtr
}
struct SERVICE_TRIGGER_CUSTOM_STATE_ID {
    Data : UInt32[2]
}
struct SERVICE_CUSTOM_SYSTEM_STATE_CHANGE_DATA_ITEM {
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            CustomStateId : SERVICE_TRIGGER_CUSTOM_STATE_ID
            s : this._s_e__Struct
        }
        struct _s_e__Struct {
            DataOffset : UInt32
            Data : UInt8[1]
        }
    }
}
struct SERVICE_DESCRIPTIONA {
    lpDescription : PSTR
}
struct SERVICE_DESCRIPTIONW {
    lpDescription : PWSTR
}
struct SC_ACTION_TYPE extends Int32 {
    static SC_ACTION_NONE := 0
    static SC_ACTION_RESTART := 1
    static SC_ACTION_REBOOT := 2
    static SC_ACTION_RUN_COMMAND := 3
    static SC_ACTION_OWN_RESTART := 4
}
struct SC_ACTION {
    Type : SC_ACTION_TYPE
    Delay : UInt32
}
struct SERVICE_FAILURE_ACTIONSA {
    dwResetPeriod : UInt32
    lpRebootMsg : PSTR
    lpCommand : PSTR
    cActions : UInt32
    lpsaActions : SC_ACTION.Ptr
}
struct SERVICE_FAILURE_ACTIONSW {
    dwResetPeriod : UInt32
    lpRebootMsg : PWSTR
    lpCommand : PWSTR
    cActions : UInt32
    lpsaActions : SC_ACTION.Ptr
}
struct SERVICE_DELAYED_AUTO_START_INFO {
    fDelayedAutostart : BOOL
}
struct SERVICE_FAILURE_ACTIONS_FLAG {
    fFailureActionsOnNonCrashFailures : BOOL
}
struct SERVICE_SID_INFO {
    dwServiceSidType : UInt32
}
struct SERVICE_REQUIRED_PRIVILEGES_INFOA {
    pmszRequiredPrivileges : PSTR
}
struct SERVICE_REQUIRED_PRIVILEGES_INFOW {
    pmszRequiredPrivileges : PWSTR
}
struct SERVICE_PRESHUTDOWN_INFO {
    dwPreshutdownTimeout : UInt32
}
struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM {
    dwDataType : SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE
    cbData : UInt32
    pData : UInt8.Ptr
}
struct SERVICE_TRIGGER {
    dwTriggerType : SERVICE_TRIGGER_TYPE
    dwAction : SERVICE_TRIGGER_ACTION
    pTriggerSubtype : GUID.Ptr
    cDataItems : UInt32
    pDataItems : SERVICE_TRIGGER_SPECIFIC_DATA_ITEM.Ptr
}
struct SERVICE_TRIGGER_INFO {
    cTriggers : UInt32
    pTriggers : SERVICE_TRIGGER.Ptr
    pReserved : UInt8.Ptr
}
struct SERVICE_PREFERRED_NODE_INFO {
    usPreferredNode : UInt16
    fDelete : BOOLEAN
}
struct SERVICE_TIMECHANGE_INFO {
    liNewTime : Int64
    liOldTime : Int64
}
struct SERVICE_LAUNCH_PROTECTED_INFO {
    dwLaunchProtected : UInt32
}
struct SC_STATUS_TYPE extends Int32 {
    static SC_STATUS_PROCESS_INFO := 0
}
struct SC_ENUM_TYPE extends Int32 {
    static SC_ENUM_PROCESS_INFO := 0
}
struct SERVICE_STATUS {
    dwServiceType : ENUM_SERVICE_TYPE
    dwCurrentState : SERVICE_STATUS_CURRENT_STATE
    dwControlsAccepted : UInt32
    dwWin32ExitCode : UInt32
    dwServiceSpecificExitCode : UInt32
    dwCheckPoint : UInt32
    dwWaitHint : UInt32
}
struct SERVICE_STATUS_PROCESS {
    dwServiceType : ENUM_SERVICE_TYPE
    dwCurrentState : SERVICE_STATUS_CURRENT_STATE
    dwControlsAccepted : UInt32
    dwWin32ExitCode : UInt32
    dwServiceSpecificExitCode : UInt32
    dwCheckPoint : UInt32
    dwWaitHint : UInt32
    dwProcessId : UInt32
    dwServiceFlags : SERVICE_RUNS_IN_PROCESS
}
struct ENUM_SERVICE_STATUSA {
    lpServiceName : PSTR
    lpDisplayName : PSTR
    ServiceStatus : SERVICE_STATUS
}
struct ENUM_SERVICE_STATUSW {
    lpServiceName : PWSTR
    lpDisplayName : PWSTR
    ServiceStatus : SERVICE_STATUS
}
struct ENUM_SERVICE_STATUS_PROCESSA {
    lpServiceName : PSTR
    lpDisplayName : PSTR
    ServiceStatusProcess : SERVICE_STATUS_PROCESS
}
struct ENUM_SERVICE_STATUS_PROCESSW {
    lpServiceName : PWSTR
    lpDisplayName : PWSTR
    ServiceStatusProcess : SERVICE_STATUS_PROCESS
}
struct QUERY_SERVICE_LOCK_STATUSA {
    fIsLocked : UInt32
    lpLockOwner : PSTR
    dwLockDuration : UInt32
}
struct QUERY_SERVICE_LOCK_STATUSW {
    fIsLocked : UInt32
    lpLockOwner : PWSTR
    dwLockDuration : UInt32
}
struct QUERY_SERVICE_CONFIGA {
    dwServiceType : ENUM_SERVICE_TYPE
    dwStartType : SERVICE_START_TYPE
    dwErrorControl : SERVICE_ERROR
    lpBinaryPathName : PSTR
    lpLoadOrderGroup : PSTR
    dwTagId : UInt32
    lpDependencies : PSTR
    lpServiceStartName : PSTR
    lpDisplayName : PSTR
}
struct QUERY_SERVICE_CONFIGW {
    dwServiceType : ENUM_SERVICE_TYPE
    dwStartType : SERVICE_START_TYPE
    dwErrorControl : SERVICE_ERROR
    lpBinaryPathName : PWSTR
    lpLoadOrderGroup : PWSTR
    dwTagId : UInt32
    lpDependencies : PWSTR
    lpServiceStartName : PWSTR
    lpDisplayName : PWSTR
}
struct SERVICE_MAIN_FUNCTIONW extends FunctionPointer {
    static Types := [UInt32, PWSTR.Ptr, "Void"]
}
struct SERVICE_MAIN_FUNCTIONA extends FunctionPointer {
    static Types := [UInt32, Int8.Ptr.Ptr, "Void"]
}
struct LPSERVICE_MAIN_FUNCTIONW extends FunctionPointer {
    static Types := [UInt32, PWSTR.Ptr, "Void"]
}
struct LPSERVICE_MAIN_FUNCTIONA extends FunctionPointer {
    static Types := [UInt32, PSTR.Ptr, "Void"]
}
struct SERVICE_TABLE_ENTRYA {
    lpServiceName : PSTR
    lpServiceProc : LPSERVICE_MAIN_FUNCTIONA
}
struct SERVICE_TABLE_ENTRYW {
    lpServiceName : PWSTR
    lpServiceProc : LPSERVICE_MAIN_FUNCTIONW
}
struct HANDLER_FUNCTION extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
struct HANDLER_FUNCTION_EX extends FunctionPointer {
    static Types := [UInt32, UInt32, Struct.Ptr, Struct.Ptr, UInt32]
}
struct LPHANDLER_FUNCTION extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
struct LPHANDLER_FUNCTION_EX extends FunctionPointer {
    static Types := [UInt32, UInt32, Struct.Ptr, Struct.Ptr, UInt32]
}
struct PFN_SC_NOTIFY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct SERVICE_NOTIFY_1 {
    dwVersion : UInt32
    pfnNotifyCallback : PFN_SC_NOTIFY_CALLBACK
    pContext : Struct.Ptr
    dwNotificationStatus : UInt32
    ServiceStatus : SERVICE_STATUS_PROCESS
}
struct SERVICE_NOTIFY_2A {
    dwVersion : UInt32
    pfnNotifyCallback : PFN_SC_NOTIFY_CALLBACK
    pContext : Struct.Ptr
    dwNotificationStatus : UInt32
    ServiceStatus : SERVICE_STATUS_PROCESS
    dwNotificationTriggered : UInt32
    pszServiceNames : PSTR
}
struct SERVICE_NOTIFY_2W {
    dwVersion : UInt32
    pfnNotifyCallback : PFN_SC_NOTIFY_CALLBACK
    pContext : Struct.Ptr
    dwNotificationStatus : UInt32
    ServiceStatus : SERVICE_STATUS_PROCESS
    dwNotificationTriggered : UInt32
    pszServiceNames : PWSTR
}
struct SERVICE_CONTROL_STATUS_REASON_PARAMSA {
    dwReason : UInt32
    pszComment : PSTR
    ServiceStatus : SERVICE_STATUS_PROCESS
}
struct SERVICE_CONTROL_STATUS_REASON_PARAMSW {
    dwReason : UInt32
    pszComment : PWSTR
    ServiceStatus : SERVICE_STATUS_PROCESS
}
struct SERVICE_START_REASON {
    dwReason : UInt32
}
struct SC_EVENT_TYPE extends Int32 {
    static SC_EVENT_DATABASE_CHANGE := 0
    static SC_EVENT_PROPERTY_CHANGE := 1
    static SC_EVENT_STATUS_CHANGE := 2
}
struct PSC_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, "Void"]
}
struct SERVICE_REGISTRY_STATE_TYPE extends Int32 {
    static ServiceRegistryStateParameters := 0
    static ServiceRegistryStatePersistent := 1
    static MaxServiceRegistryStateType := 2
}
struct SERVICE_DIRECTORY_TYPE extends Int32 {
    static ServiceDirectoryPersistentState := 0
    static ServiceDirectoryTypeMax := 1
}
struct SERVICE_SHARED_REGISTRY_STATE_TYPE extends Int32 {
    static ServiceSharedRegistryPersistentState := 0
}
struct SERVICE_SHARED_DIRECTORY_TYPE extends Int32 {
    static ServiceSharedDirectoryPersistentState := 0
}
