#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, LPARAM, PWSTR}

struct POWER_COOLING_MODE extends UInt16 {
    static PO_TZ_ACTIVE := 0
    static PO_TZ_PASSIVE := 1
    static PO_TZ_INVALID_MODE := 2
}
struct PROCESSOR_POWER_INFORMATION {
    Number : UInt32
    MaxMhz : UInt32
    CurrentMhz : UInt32
    MhzLimit : UInt32
    MaxIdleState : UInt32
    CurrentIdleState : UInt32
}
struct SYSTEM_POWER_INFORMATION {
    MaxIdlenessAllowed : UInt32
    Idleness : UInt32
    TimeRemaining : UInt32
    CoolingMode : POWER_COOLING_MODE
}
struct POWER_PLATFORM_ROLE_VERSION extends UInt32 {
    static POWER_PLATFORM_ROLE_V1 := 1
    static POWER_PLATFORM_ROLE_V2 := 2
}
struct EXECUTION_STATE extends UInt32 {
    static ES_AWAYMODE_REQUIRED := 64
    static ES_CONTINUOUS := 2147483648
    static ES_DISPLAY_REQUIRED := 2
    static ES_SYSTEM_REQUIRED := 1
    static ES_USER_PRESENT := 4
}
struct POWER_ACTION_POLICY_EVENT_CODE extends UInt32 {
    static POWER_FORCE_TRIGGER_RESET := 2147483648
    static POWER_LEVEL_USER_NOTIFY_EXEC := 4
    static POWER_LEVEL_USER_NOTIFY_SOUND := 2
    static POWER_LEVEL_USER_NOTIFY_TEXT := 1
    static POWER_USER_NOTIFY_BUTTON := 8
    static POWER_USER_NOTIFY_SHUTDOWN := 16
}
struct DEVICE_POWER_CAPABILITIES extends UInt32 {
    static PDCAP_D0_SUPPORTED := 1
    static PDCAP_D1_SUPPORTED := 2
    static PDCAP_D2_SUPPORTED := 4
    static PDCAP_D3_SUPPORTED := 8
    static PDCAP_WAKE_FROM_D0_SUPPORTED := 16
    static PDCAP_WAKE_FROM_D1_SUPPORTED := 32
    static PDCAP_WAKE_FROM_D2_SUPPORTED := 64
    static PDCAP_WAKE_FROM_D3_SUPPORTED := 128
    static PDCAP_WARM_EJECT_SUPPORTED := 256
    static PDCAP_S0_SUPPORTED := 65536
    static PDCAP_S1_SUPPORTED := 131072
    static PDCAP_S2_SUPPORTED := 262144
    static PDCAP_S3_SUPPORTED := 524288
    static PDCAP_WAKE_FROM_S0_SUPPORTED := 1048576
    static PDCAP_WAKE_FROM_S1_SUPPORTED := 2097152
    static PDCAP_WAKE_FROM_S2_SUPPORTED := 4194304
    static PDCAP_WAKE_FROM_S3_SUPPORTED := 8388608
    static PDCAP_S4_SUPPORTED := 16777216
    static PDCAP_S5_SUPPORTED := 33554432
}
struct HPOWERNOTIFY {
    Value : IntPtr
}
struct EFFECTIVE_POWER_MODE extends Int32 {
    static EffectivePowerModeBatterySaver := 0
    static EffectivePowerModeEnergySaverHighSavings := 0
    static EffectivePowerModeBetterBattery := 1
    static EffectivePowerModeEnergySaverStandard := 1
    static EffectivePowerModeBalanced := 2
    static EffectivePowerModeHighPerformance := 3
    static EffectivePowerModeMaxPerformance := 4
    static EffectivePowerModeGameMode := 5
    static EffectivePowerModeMixedReality := 6
}
struct EFFECTIVE_POWER_MODE_CALLBACK extends FunctionPointer {
    static Types := [EFFECTIVE_POWER_MODE, Struct.Ptr, "Void"]
}
struct GLOBAL_MACHINE_POWER_POLICY {
    Revision : UInt32
    LidOpenWakeAc : SYSTEM_POWER_STATE
    LidOpenWakeDc : SYSTEM_POWER_STATE
    BroadcastCapacityResolution : UInt32
}
struct GLOBAL_USER_POWER_POLICY {
    Revision : UInt32
    PowerButtonAc : POWER_ACTION_POLICY
    PowerButtonDc : POWER_ACTION_POLICY
    SleepButtonAc : POWER_ACTION_POLICY
    SleepButtonDc : POWER_ACTION_POLICY
    LidCloseAc : POWER_ACTION_POLICY
    LidCloseDc : POWER_ACTION_POLICY
    DischargePolicy : SYSTEM_POWER_LEVEL[4]
    GlobalFlags : UInt32
}
struct GLOBAL_POWER_POLICY {
    user : GLOBAL_USER_POWER_POLICY
    mach : GLOBAL_MACHINE_POWER_POLICY
}
struct MACHINE_POWER_POLICY {
    Revision : UInt32
    MinSleepAc : SYSTEM_POWER_STATE
    MinSleepDc : SYSTEM_POWER_STATE
    ReducedLatencySleepAc : SYSTEM_POWER_STATE
    ReducedLatencySleepDc : SYSTEM_POWER_STATE
    DozeTimeoutAc : UInt32
    DozeTimeoutDc : UInt32
    DozeS4TimeoutAc : UInt32
    DozeS4TimeoutDc : UInt32
    MinThrottleAc : UInt8
    MinThrottleDc : UInt8
    pad1 : UInt8[2]
    OverThrottledAc : POWER_ACTION_POLICY
    OverThrottledDc : POWER_ACTION_POLICY
}
struct MACHINE_PROCESSOR_POWER_POLICY {
    Revision : UInt32
    ProcessorPolicyAc : PROCESSOR_POWER_POLICY
    ProcessorPolicyDc : PROCESSOR_POWER_POLICY
}
struct USER_POWER_POLICY {
    Revision : UInt32
    IdleAc : POWER_ACTION_POLICY
    IdleDc : POWER_ACTION_POLICY
    IdleTimeoutAc : UInt32
    IdleTimeoutDc : UInt32
    IdleSensitivityAc : UInt8
    IdleSensitivityDc : UInt8
    ThrottlePolicyAc : UInt8
    ThrottlePolicyDc : UInt8
    MaxSleepAc : SYSTEM_POWER_STATE
    MaxSleepDc : SYSTEM_POWER_STATE
    Reserved : UInt32[2]
    VideoTimeoutAc : UInt32
    VideoTimeoutDc : UInt32
    SpindownTimeoutAc : UInt32
    SpindownTimeoutDc : UInt32
    OptimizeForPowerAc : BOOLEAN
    OptimizeForPowerDc : BOOLEAN
    FanThrottleToleranceAc : UInt8
    FanThrottleToleranceDc : UInt8
    ForcedThrottleAc : UInt8
    ForcedThrottleDc : UInt8
}
struct POWER_POLICY {
    user : USER_POWER_POLICY
    mach : MACHINE_POWER_POLICY
}
struct PWRSCHEMESENUMPROC_V1 extends FunctionPointer {
    static Types := [UInt32, UInt32, Int8.Ptr, UInt32, Int8.Ptr, POWER_POLICY.Ptr, LPARAM, BOOLEAN]
}
struct PWRSCHEMESENUMPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, UInt32, PWSTR, POWER_POLICY.Ptr, LPARAM, BOOLEAN]
}
struct POWER_DATA_ACCESSOR extends Int32 {
    static ACCESS_AC_POWER_SETTING_INDEX := 0
    static ACCESS_DC_POWER_SETTING_INDEX := 1
    static ACCESS_FRIENDLY_NAME := 2
    static ACCESS_DESCRIPTION := 3
    static ACCESS_POSSIBLE_POWER_SETTING := 4
    static ACCESS_POSSIBLE_POWER_SETTING_FRIENDLY_NAME := 5
    static ACCESS_POSSIBLE_POWER_SETTING_DESCRIPTION := 6
    static ACCESS_DEFAULT_AC_POWER_SETTING := 7
    static ACCESS_DEFAULT_DC_POWER_SETTING := 8
    static ACCESS_POSSIBLE_VALUE_MIN := 9
    static ACCESS_POSSIBLE_VALUE_MAX := 10
    static ACCESS_POSSIBLE_VALUE_INCREMENT := 11
    static ACCESS_POSSIBLE_VALUE_UNITS := 12
    static ACCESS_ICON_RESOURCE := 13
    static ACCESS_DEFAULT_SECURITY_DESCRIPTOR := 14
    static ACCESS_ATTRIBUTES := 15
    static ACCESS_SCHEME := 16
    static ACCESS_SUBGROUP := 17
    static ACCESS_INDIVIDUAL_SETTING := 18
    static ACCESS_ACTIVE_SCHEME := 19
    static ACCESS_CREATE_SCHEME := 20
    static ACCESS_AC_POWER_SETTING_MAX := 21
    static ACCESS_DC_POWER_SETTING_MAX := 22
    static ACCESS_AC_POWER_SETTING_MIN := 23
    static ACCESS_DC_POWER_SETTING_MIN := 24
    static ACCESS_PROFILE := 25
    static ACCESS_OVERLAY_SCHEME := 26
    static ACCESS_POWER_MODE := 26
    static ACCESS_ACTIVE_OVERLAY_SCHEME := 27
}
struct PDEVICE_NOTIFY_CALLBACK_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct DEVICE_NOTIFY_SUBSCRIBE_PARAMETERS {
    Callback : PDEVICE_NOTIFY_CALLBACK_ROUTINE
    Context : Struct.Ptr
}
struct THERMAL_EVENT {
    Version : UInt32
    Size : UInt32
    Type : UInt32
    Temperature : UInt32
    TripPointTemperature : UInt32
    Initiator : PWSTR
}
struct BATTERY_QUERY_INFORMATION_LEVEL extends Int32 {
    static BatteryInformation := 0
    static BatteryGranularityInformation := 1
    static BatteryTemperature := 2
    static BatteryEstimatedTime := 3
    static BatteryDeviceName := 4
    static BatteryManufactureDate := 5
    static BatteryManufactureName := 6
    static BatteryUniqueID := 7
    static BatterySerialNumber := 8
}
struct BATTERY_QUERY_INFORMATION {
    BatteryTag : UInt32
    InformationLevel : BATTERY_QUERY_INFORMATION_LEVEL
    AtRate : UInt32
}
struct BATTERY_INFORMATION {
    Capabilities : UInt32
    Technology : UInt8
    Reserved : UInt8[3]
    Chemistry : UInt8[4]
    DesignedCapacity : UInt32
    FullChargedCapacity : UInt32
    DefaultAlert1 : UInt32
    DefaultAlert2 : UInt32
    CriticalBias : UInt32
    CycleCount : UInt32
}
struct BATTERY_CHARGING_SOURCE_TYPE extends Int32 {
    static BatteryChargingSourceType_AC := 1
    static BatteryChargingSourceType_USB := 2
    static BatteryChargingSourceType_Wireless := 3
    static BatteryChargingSourceType_Max := 4
}
struct BATTERY_CHARGING_SOURCE {
    Type : BATTERY_CHARGING_SOURCE_TYPE
    MaxCurrent : UInt32
}
struct BATTERY_CHARGING_SOURCE_INFORMATION {
    Type : BATTERY_CHARGING_SOURCE_TYPE
    SourceOnline : BOOLEAN
}
struct USB_CHARGER_PORT extends Int32 {
    static UsbChargerPort_Legacy := 0
    static UsbChargerPort_TypeC := 1
    static UsbChargerPort_Max := 2
}
struct BATTERY_SET_INFORMATION_LEVEL extends Int32 {
    static BatteryCriticalBias := 0
    static BatteryCharge := 1
    static BatteryDischarge := 2
    static BatteryChargingSource := 3
    static BatteryChargerId := 4
    static BatteryChargerStatus := 5
}
struct BATTERY_SET_INFORMATION {
    BatteryTag : UInt32
    InformationLevel : BATTERY_SET_INFORMATION_LEVEL
    Buffer : UInt8[1]
}
struct BATTERY_CHARGER_STATUS {
    Type : BATTERY_CHARGING_SOURCE_TYPE
    VaData : UInt32[1]
}
struct BATTERY_USB_CHARGER_STATUS {
    Type : BATTERY_CHARGING_SOURCE_TYPE
    Reserved : UInt32
    Flags : UInt32
    MaxCurrent : UInt32
    Voltage : UInt32
    PortType : USB_CHARGER_PORT
    PortId : Int64
    PowerSourceInformation : Struct.Ptr
    OemCharger : GUID
}
struct BATTERY_WAIT_STATUS {
    BatteryTag : UInt32
    Timeout : UInt32
    PowerState : UInt32
    LowCapacity : UInt32
    HighCapacity : UInt32
}
struct BATTERY_STATUS {
    PowerState : UInt32
    Capacity : UInt32
    Voltage : UInt32
    Rate : Int32
}
struct POWER_ADAPTER_POWER_STATES {
    union {
        States : this._States_e__Struct
        AsUlong : UInt32
    }
    struct _States_e__Struct {
        _bitfield : UInt32
    }
}
struct POWER_ADAPTER_STATUS {
    Version : UInt8
    Reserved : UInt8[3]
    PowerState : POWER_ADAPTER_POWER_STATES
    PeakPower : UInt32
    MaxOutputPower : UInt32
    MaxInputPower : UInt32
    RecStartTime : Int64
    RecEndTime : Int64
}
struct POWER_ADAPTER_SET_STATUS_BUFFER {
    Version : UInt8
    RecOverride : BOOLEAN
    Reserved : UInt8[2]
}
struct POWER_ADAPTER_CHARGE_REQUIREMENT {
    AcAdapterType : UInt32
    MinimumPower : UInt32
    NominalPower : UInt32
    MaximumPower : UInt32
}
struct BATTERY_MANUFACTURE_DATE {
    Day : UInt8
    Month : UInt8
    Year : UInt16
}
struct CUSTOMIZED_IO_CAPABILITIES {
    SupportedInputs : UInt32
    SupportedOutputs : UInt32
}
struct CUSTOMIZED_IO_QUERY_INPUT_RETURN {
    FunctionId : UInt32
    ErrorCode : UInt32
    Value : UInt32
}
struct CUSTOMIZED_IO_SEND_OUTPUT_BUFFER {
    FunctionId : UInt32
    Value : UInt32
}
struct THERMAL_INFORMATION {
    ThermalStamp : UInt32
    ThermalConstant1 : UInt32
    ThermalConstant2 : UInt32
    Processors : IntPtr
    SamplingPeriod : UInt32
    CurrentTemperature : UInt32
    PassiveTripPoint : UInt32
    CriticalTripPoint : UInt32
    ActiveTripPointCount : UInt8
    ActiveTripPoint : UInt32[10]
}
struct THERMAL_WAIT_READ {
    Timeout : UInt32
    LowTemperature : UInt32
    HighTemperature : UInt32
}
struct THERMAL_POLICY {
    Version : UInt32
    WaitForUpdate : BOOLEAN
    Hibernate : BOOLEAN
    Critical : BOOLEAN
    ThermalStandby : BOOLEAN
    ActivationReasons : UInt32
    PassiveLimit : UInt32
    ActiveLevel : UInt32
    OverThrottled : BOOLEAN
}
struct PROCESSOR_OBJECT_INFO {
    PhysicalID : UInt32
    PBlkAddress : UInt32
    PBlkLength : UInt8
}
struct PROCESSOR_OBJECT_INFO_EX {
    PhysicalID : UInt32
    PBlkAddress : UInt32
    PBlkLength : UInt8
    InitialApicId : UInt32
}
struct WAKE_ALARM_INFORMATION {
    TimerIdentifier : UInt32
    Timeout : UInt32
}
struct ACPI_REAL_TIME {
    Year : UInt16
    Month : UInt8
    Day : UInt8
    Hour : UInt8
    Minute : UInt8
    Second : UInt8
    Valid : UInt8
    Milliseconds : UInt16
    TimeZone : Int16
    DayLight : UInt8
    Reserved1 : UInt8[3]
}
struct ACPI_TIME_RESOLUTION extends Int32 {
    static AcpiTimeResolutionMilliseconds := 0
    static AcpiTimeResolutionSeconds := 1
    static AcpiTimeResolutionMax := 2
}
struct ACPI_TIME_AND_ALARM_CAPABILITIES {
    AcWakeSupported : BOOLEAN
    DcWakeSupported : BOOLEAN
    S4AcWakeSupported : BOOLEAN
    S4DcWakeSupported : BOOLEAN
    S5AcWakeSupported : BOOLEAN
    S5DcWakeSupported : BOOLEAN
    S4S5WakeStatusSupported : BOOLEAN
    DeepestWakeSystemState : UInt32
    RealTimeFeaturesSupported : BOOLEAN
    RealTimeResolution : ACPI_TIME_RESOLUTION
}
struct EMI_MEASUREMENT_UNIT extends Int32 {
    static EmiMeasurementUnitPicowattHours := 0
}
struct EMI_VERSION {
    EmiVersion : UInt16
}
struct EMI_METADATA_SIZE {
    MetadataSize : UInt32
}
struct EMI_CHANNEL_MEASUREMENT_DATA {
    AbsoluteEnergy : Int64
    AbsoluteTime : Int64
}
struct EMI_METADATA_V1 {
    MeasurementUnit : EMI_MEASUREMENT_UNIT
    HardwareOEM : UInt16[16]
    HardwareModel : UInt16[16]
    HardwareRevision : UInt16
    MeteredHardwareNameSize : UInt16
    MeteredHardwareName : UInt16[1]
}
struct EMI_CHANNEL_V2 {
    MeasurementUnit : EMI_MEASUREMENT_UNIT
    ChannelNameSize : UInt16
    ChannelName : UInt16[1]
}
struct EMI_METADATA_V2 {
    HardwareOEM : UInt16[16]
    HardwareModel : UInt16[16]
    HardwareRevision : UInt16
    ChannelCount : UInt16
    Channels : EMI_CHANNEL_V2[1]
}
struct EMI_MEASUREMENT_DATA_V2 {
    ChannelData : EMI_CHANNEL_MEASUREMENT_DATA[1]
}
struct SYSTEM_POWER_STATE extends Int32 {
    static PowerSystemUnspecified := 0
    static PowerSystemWorking := 1
    static PowerSystemSleeping1 := 2
    static PowerSystemSleeping2 := 3
    static PowerSystemSleeping3 := 4
    static PowerSystemHibernate := 5
    static PowerSystemShutdown := 6
    static PowerSystemMaximum := 7
}
struct POWER_ACTION extends Int32 {
    static PowerActionNone := 0
    static PowerActionReserved := 1
    static PowerActionSleep := 2
    static PowerActionHibernate := 3
    static PowerActionShutdown := 4
    static PowerActionShutdownReset := 5
    static PowerActionShutdownOff := 6
    static PowerActionWarmEject := 7
    static PowerActionDisplayOff := 8
}
struct DEVICE_POWER_STATE extends Int32 {
    static PowerDeviceUnspecified := 0
    static PowerDeviceD0 := 1
    static PowerDeviceD1 := 2
    static PowerDeviceD2 := 3
    static PowerDeviceD3 := 4
    static PowerDeviceMaximum := 5
}
struct USER_ACTIVITY_PRESENCE extends Int32 {
    static PowerUserPresent := 0
    static PowerUserNotPresent := 1
    static PowerUserInactive := 2
    static PowerUserMaximum := 3
    static PowerUserInvalid := 3
}
struct LATENCY_TIME extends Int32 {
    static LT_DONT_CARE := 0
    static LT_LOWEST_LATENCY := 1
}
struct POWER_REQUEST_TYPE extends Int32 {
    static PowerRequestDisplayRequired := 0
    static PowerRequestSystemRequired := 1
    static PowerRequestAwayModeRequired := 2
    static PowerRequestExecutionRequired := 3
}
struct CM_POWER_DATA {
    PD_Size : UInt32
    PD_MostRecentPowerState : DEVICE_POWER_STATE
    PD_Capabilities : UInt32
    PD_D1Latency : UInt32
    PD_D2Latency : UInt32
    PD_D3Latency : UInt32
    PD_PowerStateMapping : DEVICE_POWER_STATE[7]
    PD_DeepestSystemWake : SYSTEM_POWER_STATE
}
struct POWER_INFORMATION_LEVEL extends Int32 {
    static SystemPowerPolicyAc := 0
    static SystemPowerPolicyDc := 1
    static VerifySystemPolicyAc := 2
    static VerifySystemPolicyDc := 3
    static SystemPowerCapabilities := 4
    static SystemBatteryState := 5
    static SystemPowerStateHandler := 6
    static ProcessorStateHandler := 7
    static SystemPowerPolicyCurrent := 8
    static AdministratorPowerPolicy := 9
    static SystemReserveHiberFile := 10
    static ProcessorInformation := 11
    static SystemPowerInformation := 12
    static ProcessorStateHandler2 := 13
    static LastWakeTime := 14
    static LastSleepTime := 15
    static SystemExecutionState := 16
    static SystemPowerStateNotifyHandler := 17
    static ProcessorPowerPolicyAc := 18
    static ProcessorPowerPolicyDc := 19
    static VerifyProcessorPowerPolicyAc := 20
    static VerifyProcessorPowerPolicyDc := 21
    static ProcessorPowerPolicyCurrent := 22
    static SystemPowerStateLogging := 23
    static SystemPowerLoggingEntry := 24
    static SetPowerSettingValue := 25
    static NotifyUserPowerSetting := 26
    static PowerInformationLevelUnused0 := 27
    static SystemMonitorHiberBootPowerOff := 28
    static SystemVideoState := 29
    static TraceApplicationPowerMessage := 30
    static TraceApplicationPowerMessageEnd := 31
    static ProcessorPerfStates := 32
    static ProcessorIdleStates := 33
    static ProcessorCap := 34
    static SystemWakeSource := 35
    static SystemHiberFileInformation := 36
    static TraceServicePowerMessage := 37
    static ProcessorLoad := 38
    static PowerShutdownNotification := 39
    static MonitorCapabilities := 40
    static SessionPowerInit := 41
    static SessionDisplayState := 42
    static PowerRequestCreate := 43
    static PowerRequestAction := 44
    static GetPowerRequestList := 45
    static ProcessorInformationEx := 46
    static NotifyUserModeLegacyPowerEvent := 47
    static GroupPark := 48
    static ProcessorIdleDomains := 49
    static WakeTimerList := 50
    static SystemHiberFileSize := 51
    static ProcessorIdleStatesHv := 52
    static ProcessorPerfStatesHv := 53
    static ProcessorPerfCapHv := 54
    static ProcessorSetIdle := 55
    static LogicalProcessorIdling := 56
    static UserPresence := 57
    static PowerSettingNotificationName := 58
    static GetPowerSettingValue := 59
    static IdleResiliency := 60
    static SessionRITState := 61
    static SessionConnectNotification := 62
    static SessionPowerCleanup := 63
    static SessionLockState := 64
    static SystemHiberbootState := 65
    static PlatformInformation := 66
    static PdcInvocation := 67
    static MonitorInvocation := 68
    static FirmwareTableInformationRegistered := 69
    static SetShutdownSelectedTime := 70
    static SuspendResumeInvocation := 71
    static PlmPowerRequestCreate := 72
    static ScreenOff := 73
    static CsDeviceNotification := 74
    static PlatformRole := 75
    static LastResumePerformance := 76
    static DisplayBurst := 77
    static ExitLatencySamplingPercentage := 78
    static RegisterSpmPowerSettings := 79
    static PlatformIdleStates := 80
    static ProcessorIdleVeto := 81
    static PlatformIdleVeto := 82
    static SystemBatteryStatePrecise := 83
    static ThermalEvent := 84
    static PowerRequestActionInternal := 85
    static BatteryDeviceState := 86
    static PowerInformationInternal := 87
    static ThermalStandby := 88
    static SystemHiberFileType := 89
    static PhysicalPowerButtonPress := 90
    static QueryPotentialDripsConstraint := 91
    static EnergyTrackerCreate := 92
    static EnergyTrackerQuery := 93
    static UpdateBlackBoxRecorder := 94
    static SessionAllowExternalDmaDevices := 95
    static SendSuspendResumeNotification := 96
    static BlackBoxRecorderDirectAccessBuffer := 97
    static SystemPowerSourceState := 98
    static PowerInformationLevelMaximum := 99
}
struct POWER_USER_PRESENCE_TYPE extends Int32 {
    static UserNotPresent := 0
    static UserPresent := 1
    static UserUnknown := 255
}
struct POWER_USER_PRESENCE {
    UserPresence : POWER_USER_PRESENCE_TYPE
}
struct POWER_SESSION_CONNECT {
    Connected : BOOLEAN
    Console : BOOLEAN
}
struct POWER_SESSION_TIMEOUTS {
    InputTimeout : UInt32
    DisplayTimeout : UInt32
}
struct POWER_SESSION_RIT_STATE {
    Active : BOOLEAN
    LastInputTime : Int64
}
struct POWER_SESSION_WINLOGON {
    SessionId : UInt32
    Console : BOOLEAN
    Locked : BOOLEAN
}
struct POWER_SESSION_ALLOW_EXTERNAL_DMA_DEVICES {
    IsAllowed : BOOLEAN
}
struct POWER_IDLE_RESILIENCY {
    CoalescingTimeout : UInt32
    IdleResiliencyPeriod : UInt32
}
struct POWER_MONITOR_REQUEST_REASON extends Int32 {
    static MonitorRequestReasonUnknown := 0
    static MonitorRequestReasonPowerButton := 1
    static MonitorRequestReasonRemoteConnection := 2
    static MonitorRequestReasonScMonitorpower := 3
    static MonitorRequestReasonUserInput := 4
    static MonitorRequestReasonAcDcDisplayBurst := 5
    static MonitorRequestReasonUserDisplayBurst := 6
    static MonitorRequestReasonPoSetSystemState := 7
    static MonitorRequestReasonSetThreadExecutionState := 8
    static MonitorRequestReasonFullWake := 9
    static MonitorRequestReasonSessionUnlock := 10
    static MonitorRequestReasonScreenOffRequest := 11
    static MonitorRequestReasonIdleTimeout := 12
    static MonitorRequestReasonPolicyChange := 13
    static MonitorRequestReasonSleepButton := 14
    static MonitorRequestReasonLid := 15
    static MonitorRequestReasonBatteryCountChange := 16
    static MonitorRequestReasonGracePeriod := 17
    static MonitorRequestReasonPnP := 18
    static MonitorRequestReasonDP := 19
    static MonitorRequestReasonSxTransition := 20
    static MonitorRequestReasonSystemIdle := 21
    static MonitorRequestReasonNearProximity := 22
    static MonitorRequestReasonThermalStandby := 23
    static MonitorRequestReasonResumePdc := 24
    static MonitorRequestReasonResumeS4 := 25
    static MonitorRequestReasonTerminal := 26
    static MonitorRequestReasonPdcSignal := 27
    static MonitorRequestReasonAcDcDisplayBurstSuppressed := 28
    static MonitorRequestReasonSystemStateEntered := 29
    static MonitorRequestReasonWinrt := 30
    static MonitorRequestReasonUserInputKeyboard := 31
    static MonitorRequestReasonUserInputMouse := 32
    static MonitorRequestReasonUserInputTouchpad := 33
    static MonitorRequestReasonUserInputPen := 34
    static MonitorRequestReasonUserInputAccelerometer := 35
    static MonitorRequestReasonUserInputHid := 36
    static MonitorRequestReasonUserInputPoUserPresent := 37
    static MonitorRequestReasonUserInputSessionSwitch := 38
    static MonitorRequestReasonUserInputInitialization := 39
    static MonitorRequestReasonPdcSignalWindowsMobilePwrNotif := 40
    static MonitorRequestReasonPdcSignalWindowsMobileShell := 41
    static MonitorRequestReasonPdcSignalHeyCortana := 42
    static MonitorRequestReasonPdcSignalHolographicShell := 43
    static MonitorRequestReasonPdcSignalFingerprint := 44
    static MonitorRequestReasonDirectedDrips := 45
    static MonitorRequestReasonDim := 46
    static MonitorRequestReasonBuiltinPanel := 47
    static MonitorRequestReasonDisplayRequiredUnDim := 48
    static MonitorRequestReasonBatteryCountChangeSuppressed := 49
    static MonitorRequestReasonResumeModernStandby := 50
    static MonitorRequestReasonTerminalInit := 51
    static MonitorRequestReasonPdcSignalSensorsHumanPresence := 52
    static MonitorRequestReasonBatteryPreCritical := 53
    static MonitorRequestReasonUserInputTouch := 54
    static MonitorRequestReasonRestrictedStandbyBatteryDrain := 55
    static MonitorRequestReasonDozeRestrictedStandby := 56
    static MonitorRequestReasonSmartRestrictedStandby := 57
    static MonitorRequestReasonMax := 58
}
struct POWER_MONITOR_REQUEST_TYPE extends Int32 {
    static MonitorRequestTypeOff := 0
    static MonitorRequestTypeOnAndPresent := 1
    static MonitorRequestTypeToggleOn := 2
}
struct POWER_MONITOR_INVOCATION {
    Console : BOOLEAN
    RequestReason : POWER_MONITOR_REQUEST_REASON
}
struct RESUME_PERFORMANCE {
    PostTimeMs : UInt32
    TotalResumeTimeMs : Int64
    ResumeCompleteTimestamp : Int64
}
struct SYSTEM_POWER_CONDITION extends Int32 {
    static PoAc := 0
    static PoDc := 1
    static PoHot := 2
    static PoConditionMaximum := 3
}
struct SET_POWER_SETTING_VALUE {
    Version : UInt32
    Guid : GUID
    PowerCondition : SYSTEM_POWER_CONDITION
    DataLength : UInt32
    Data : UInt8[1]
}
struct POWER_PLATFORM_ROLE extends Int32 {
    static PlatformRoleUnspecified := 0
    static PlatformRoleDesktop := 1
    static PlatformRoleMobile := 2
    static PlatformRoleWorkstation := 3
    static PlatformRoleEnterpriseServer := 4
    static PlatformRoleSOHOServer := 5
    static PlatformRoleAppliancePC := 6
    static PlatformRolePerformanceServer := 7
    static PlatformRoleSlate := 8
    static PlatformRoleMaximum := 9
}
struct POWER_PLATFORM_INFORMATION {
    AoAc : BOOLEAN
}
struct POWER_SETTING_ALTITUDE extends Int32 {
    static ALTITUDE_GROUP_POLICY := 0
    static ALTITUDE_USER := 1
    static ALTITUDE_RUNTIME_OVERRIDE := 2
    static ALTITUDE_PROVISIONING := 3
    static ALTITUDE_OEM_CUSTOMIZATION := 4
    static ALTITUDE_INTERNAL_OVERRIDE := 5
    static ALTITUDE_OS_DEFAULT := 6
}
struct BATTERY_REPORTING_SCALE {
    Granularity : UInt32
    Capacity : UInt32
}
struct PPM_WMI_LEGACY_PERFSTATE {
    Frequency : UInt32
    Flags : UInt32
    PercentFrequency : UInt32
}
struct PPM_WMI_IDLE_STATE {
    Latency : UInt32
    Power : UInt32
    TimeCheck : UInt32
    PromotePercent : UInt8
    DemotePercent : UInt8
    StateType : UInt8
    Reserved : UInt8
    StateFlags : UInt32
    Context : UInt32
    IdleHandler : UInt32
    Reserved1 : UInt32
}
struct PPM_WMI_IDLE_STATES {
    Type : UInt32
    Count : UInt32
    TargetState : UInt32
    OldState : UInt32
    TargetProcessors : Int64
    State : PPM_WMI_IDLE_STATE[1]
}
struct PPM_WMI_IDLE_STATES_EX {
    Type : UInt32
    Count : UInt32
    TargetState : UInt32
    OldState : UInt32
    TargetProcessors : Struct.Ptr
    State : PPM_WMI_IDLE_STATE[1]
}
struct PPM_WMI_PERF_STATE {
    Frequency : UInt32
    Power : UInt32
    PercentFrequency : UInt8
    IncreaseLevel : UInt8
    DecreaseLevel : UInt8
    Type : UInt8
    IncreaseTime : UInt32
    DecreaseTime : UInt32
    Control : Int64
    Status : Int64
    HitCount : UInt32
    Reserved1 : UInt32
    Reserved2 : Int64
    Reserved3 : Int64
}
struct PPM_WMI_PERF_STATES {
    Count : UInt32
    MaxFrequency : UInt32
    CurrentState : UInt32
    MaxPerfState : UInt32
    MinPerfState : UInt32
    LowestPerfState : UInt32
    ThermalConstraint : UInt32
    BusyAdjThreshold : UInt8
    PolicyType : UInt8
    Type : UInt8
    Reserved : UInt8
    TimerInterval : UInt32
    TargetProcessors : Int64
    PStateHandler : UInt32
    PStateContext : UInt32
    TStateHandler : UInt32
    TStateContext : UInt32
    FeedbackHandler : UInt32
    Reserved1 : UInt32
    Reserved2 : Int64
    State : PPM_WMI_PERF_STATE[1]
}
struct PPM_WMI_PERF_STATES_EX {
    Count : UInt32
    MaxFrequency : UInt32
    CurrentState : UInt32
    MaxPerfState : UInt32
    MinPerfState : UInt32
    LowestPerfState : UInt32
    ThermalConstraint : UInt32
    BusyAdjThreshold : UInt8
    PolicyType : UInt8
    Type : UInt8
    Reserved : UInt8
    TimerInterval : UInt32
    TargetProcessors : Struct.Ptr
    PStateHandler : UInt32
    PStateContext : UInt32
    TStateHandler : UInt32
    TStateContext : UInt32
    FeedbackHandler : UInt32
    Reserved1 : UInt32
    Reserved2 : Int64
    State : PPM_WMI_PERF_STATE[1]
}
struct PPM_IDLE_STATE_ACCOUNTING {
    IdleTransitions : UInt32
    FailedTransitions : UInt32
    InvalidBucketIndex : UInt32
    TotalTime : Int64
    IdleTimeBuckets : UInt32[6]
}
struct PPM_IDLE_ACCOUNTING {
    StateCount : UInt32
    TotalTransitions : UInt32
    ResetCount : UInt32
    StartTime : Int64
    State : PPM_IDLE_STATE_ACCOUNTING[1]
}
struct PPM_IDLE_STATE_BUCKET_EX {
    TotalTimeUs : Int64
    MinTimeUs : UInt32
    MaxTimeUs : UInt32
    Count : UInt32
}
struct PPM_IDLE_STATE_ACCOUNTING_EX {
    TotalTime : Int64
    IdleTransitions : UInt32
    FailedTransitions : UInt32
    InvalidBucketIndex : UInt32
    MinTimeUs : UInt32
    MaxTimeUs : UInt32
    CancelledTransitions : UInt32
    IdleTimeBuckets : PPM_IDLE_STATE_BUCKET_EX[16]
}
struct PPM_IDLE_ACCOUNTING_EX {
    StateCount : UInt32
    TotalTransitions : UInt32
    ResetCount : UInt32
    AbortCount : UInt32
    StartTime : Int64
    State : PPM_IDLE_STATE_ACCOUNTING_EX[1]
}
struct PPM_PERFSTATE_EVENT {
    State : UInt32
    Status : UInt32
    Latency : UInt32
    Speed : UInt32
    Processor : UInt32
}
struct PPM_PERFSTATE_DOMAIN_EVENT {
    State : UInt32
    Latency : UInt32
    Speed : UInt32
    Processors : Int64
}
struct PPM_IDLESTATE_EVENT {
    NewState : UInt32
    OldState : UInt32
    Processors : Int64
}
struct PPM_THERMALCHANGE_EVENT {
    ThermalConstraint : UInt32
    Processors : Int64
}
struct PPM_THERMAL_POLICY_EVENT {
    Mode : UInt8
    Processors : Int64
}
struct POWER_ACTION_POLICY {
    Action : POWER_ACTION
    Flags : UInt32
    EventCode : POWER_ACTION_POLICY_EVENT_CODE
}
struct SYSTEM_POWER_LEVEL {
    Enable : BOOLEAN
    Spare : UInt8[3]
    BatteryLevel : UInt32
    PowerPolicy : POWER_ACTION_POLICY
    MinSystemState : SYSTEM_POWER_STATE
}
struct SYSTEM_POWER_POLICY {
    Revision : UInt32
    PowerButton : POWER_ACTION_POLICY
    SleepButton : POWER_ACTION_POLICY
    LidClose : POWER_ACTION_POLICY
    LidOpenWake : SYSTEM_POWER_STATE
    Reserved : UInt32
    Idle : POWER_ACTION_POLICY
    IdleTimeout : UInt32
    IdleSensitivity : UInt8
    DynamicThrottle : UInt8
    Spare2 : UInt8[2]
    MinSleep : SYSTEM_POWER_STATE
    MaxSleep : SYSTEM_POWER_STATE
    ReducedLatencySleep : SYSTEM_POWER_STATE
    WinLogonFlags : UInt32
    Spare3 : UInt32
    DozeS4Timeout : UInt32
    BroadcastCapacityResolution : UInt32
    DischargePolicy : SYSTEM_POWER_LEVEL[4]
    VideoTimeout : UInt32
    VideoDimDisplay : BOOLEAN
    VideoReserved : UInt32[3]
    SpindownTimeout : UInt32
    OptimizeForPower : BOOLEAN
    FanThrottleTolerance : UInt8
    ForcedThrottle : UInt8
    MinThrottle : UInt8
    OverThrottled : POWER_ACTION_POLICY
}
struct PROCESSOR_POWER_POLICY_INFO {
    TimeCheck : UInt32
    DemoteLimit : UInt32
    PromoteLimit : UInt32
    DemotePercent : UInt8
    PromotePercent : UInt8
    Spare : UInt8[2]
    _bitfield : UInt32
}
struct PROCESSOR_POWER_POLICY {
    Revision : UInt32
    DynamicThrottle : UInt8
    Spare : UInt8[3]
    _bitfield : UInt32
    PolicyCount : UInt32
    Policy : PROCESSOR_POWER_POLICY_INFO[3]
}
struct ADMINISTRATOR_POWER_POLICY {
    MinSleep : SYSTEM_POWER_STATE
    MaxSleep : SYSTEM_POWER_STATE
    MinVideoTimeout : UInt32
    MaxVideoTimeout : UInt32
    MinSpindownTimeout : UInt32
    MaxSpindownTimeout : UInt32
}
struct SYSTEM_POWER_CAPABILITIES {
    PowerButtonPresent : BOOLEAN
    SleepButtonPresent : BOOLEAN
    LidPresent : BOOLEAN
    SystemS1 : BOOLEAN
    SystemS2 : BOOLEAN
    SystemS3 : BOOLEAN
    SystemS4 : BOOLEAN
    SystemS5 : BOOLEAN
    HiberFilePresent : BOOLEAN
    FullWake : BOOLEAN
    VideoDimPresent : BOOLEAN
    ApmPresent : BOOLEAN
    UpsPresent : BOOLEAN
    ThermalControl : BOOLEAN
    ProcessorThrottle : BOOLEAN
    ProcessorMinThrottle : UInt8
    ProcessorMaxThrottle : UInt8
    FastSystemS4 : BOOLEAN
    Hiberboot : BOOLEAN
    WakeAlarmPresent : BOOLEAN
    AoAc : BOOLEAN
    DiskSpinDown : BOOLEAN
    HiberFileType : UInt8
    AoAcConnectivitySupported : BOOLEAN
    spare3 : UInt8[6]
    SystemBatteriesPresent : BOOLEAN
    BatteriesAreShortTerm : BOOLEAN
    BatteryScale : BATTERY_REPORTING_SCALE[3]
    AcOnLineWake : SYSTEM_POWER_STATE
    SoftLidWake : SYSTEM_POWER_STATE
    RtcWake : SYSTEM_POWER_STATE
    MinDeviceWakeState : SYSTEM_POWER_STATE
    DefaultLowLatencyWake : SYSTEM_POWER_STATE
}
struct SYSTEM_BATTERY_STATE {
    AcOnLine : BOOLEAN
    BatteryPresent : BOOLEAN
    Charging : BOOLEAN
    Discharging : BOOLEAN
    Spare1 : BOOLEAN[3]
    Tag : UInt8
    MaxCapacity : UInt32
    RemainingCapacity : UInt32
    Rate : UInt32
    EstimatedTime : UInt32
    DefaultAlert1 : UInt32
    DefaultAlert2 : UInt32
}
struct POWERBROADCAST_SETTING {
    PowerSetting : GUID
    DataLength : UInt32
    Data : UInt8[1]
}
struct SYSTEM_POWER_STATUS {
    ACLineStatus : UInt8
    BatteryFlag : UInt8
    BatteryLifePercent : UInt8
    SystemStatusFlag : UInt8
    BatteryLifeTime : UInt32
    BatteryFullLifeTime : UInt32
}
