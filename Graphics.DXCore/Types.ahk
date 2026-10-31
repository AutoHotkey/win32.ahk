#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, LUID, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DXCoreAdapterProperty extends UInt32 {
    static InstanceLuid := 0
    static DriverVersion := 1
    static DriverDescription := 2
    static HardwareID := 3
    static KmdModelVersion := 4
    static ComputePreemptionGranularity := 5
    static GraphicsPreemptionGranularity := 6
    static DedicatedAdapterMemory := 7
    static DedicatedSystemMemory := 8
    static SharedSystemMemory := 9
    static AcgCompatible := 10
    static IsHardware := 11
    static IsIntegrated := 12
    static IsDetachable := 13
    static HardwareIDParts := 14
    static PhysicalAdapterCount := 15
    static AdapterEngineCount := 16
    static AdapterEngineName := 17
}
struct DXCoreAdapterState extends UInt32 {
    static IsDriverUpdateInProgress := 0
    static AdapterMemoryBudget := 1
    static AdapterMemoryUsageBytes := 2
    static AdapterMemoryUsageByProcessBytes := 3
    static AdapterEngineRunningTimeMicroseconds := 4
    static AdapterEngineRunningTimeByProcessMicroseconds := 5
    static AdapterTemperatureCelsius := 6
    static AdapterInUseProcessCount := 7
    static AdapterInUseProcessSet := 8
    static AdapterEngineFrequencyHertz := 9
    static AdapterMemoryFrequencyHertz := 10
    static SingleAdapterHybridMode := 11
}
struct DXCoreSegmentGroup extends UInt32 {
    static Local := 0
    static NonLocal := 1
}
struct DXCoreNotificationType extends UInt32 {
    static AdapterListStale := 0
    static AdapterNoLongerValid := 1
    static AdapterBudgetChange := 2
    static AdapterHardwareContentProtectionTeardown := 3
}
struct DXCoreAdapterPreference extends UInt32 {
    static Hardware := 0
    static MinimumPower := 1
    static HighPerformance := 2
}
struct DXCoreSingleAdapterHybridMode extends UInt32 {
    static Unspecified := 0
    static MinimumPower := 1
    static HighPerformance := 2
}
struct DXCoreWorkload extends UInt32 {
    static Graphics := 0
    static Compute := 1
    static Media := 2
    static MachineLearning := 3
}
struct DXCoreRuntimeFilterFlags extends UInt32 {
    static None := 0
    static D3D11 := 1
    static D3D12 := 2
}
struct DXCoreHardwareTypeFilterFlags extends UInt32 {
    static None := 0
    static GPU := 1
    static ComputeAccelerator := 2
    static NPU := 4
    static MediaAccelerator := 8
}
struct DXCoreHardwareID {
    vendorID : UInt32
    deviceID : UInt32
    subSysID : UInt32
    revision : UInt32
}
struct DXCoreHardwareIDParts {
    vendorID : UInt32
    deviceID : UInt32
    subSystemID : UInt32
    subVendorID : UInt32
    revisionID : UInt32
}
struct DXCoreAdapterMemoryBudgetNodeSegmentGroup {
    nodeIndex : UInt32
    segmentGroup : DXCoreSegmentGroup
}
struct DXCoreAdapterMemoryBudget {
    budget : Int64
    currentUsage : Int64
    availableForReservation : Int64
    currentReservation : Int64
}
struct DXCoreAdapterEngineIndex {
    physicalAdapterIndex : UInt32
    engineIndex : UInt32
}
struct DXCoreEngineQueryInput {
    adapterEngineIndex : DXCoreAdapterEngineIndex
    processId : UInt32
}
struct DXCoreEngineQueryOutput {
    runningTime : Int64
    processQuerySucceeded : UInt8
}
struct DXCoreMemoryType extends UInt32 {
    static Dedicated := 0
    static Shared := 1
}
struct DXCoreMemoryUsage {
    committed : Int64
    resident : Int64
}
struct DXCoreMemoryQueryInput {
    physicalAdapterIndex : UInt32
    memoryType : DXCoreMemoryType
}
struct DXCoreProcessMemoryQueryInput {
    physicalAdapterIndex : UInt32
    memoryType : DXCoreMemoryType
    processId : UInt32
}
struct DXCoreProcessMemoryQueryOutput {
    memoryUsage : DXCoreMemoryUsage
    processQuerySucceeded : UInt8
}
struct DXCoreAdapterProcessSetQueryInput {
    arraySize : UInt32
    processIds : UInt32.Ptr
}
struct DXCoreAdapterProcessSetQueryOutput {
    processesWritten : UInt32
    processesTotal : UInt32
}
struct DXCoreEngineNamePropertyInput {
    adapterEngineIndex : DXCoreAdapterEngineIndex
    engineNameLength : UInt32
    engineName : PWSTR
}
struct DXCoreEngineNamePropertyOutput {
    engineNameLength : UInt32
}
struct DXCoreFrequencyQueryOutput {
    frequency : Int64
    maxFrequency : Int64
    maxOverclockedFrequency : Int64
}
struct PFN_DXCORE_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [DXCoreNotificationType, IUnknown, Struct.Ptr, "Void"]
}
struct IDXCoreAdapter extends IUnknown {
    static IID := "{F0DB4C7F-FE5A-42A2-BD62-F2A6CF6FC83E}"
    IsValid()
      => ComCall(3, this.p, Boolean8)
    IsAttributeSupported(attributeGUID)
      => ComCall(4, this.p, GUID.Ptr, attributeGUID, Boolean8)
    IsPropertySupported(property)
      => ComCall(5, this.p, DXCoreAdapterProperty, property, Boolean8)
    GetProperty(property, propertyData)
      => ComCall(6, this.p, DXCoreAdapterProperty, property, IntPtr, propertyData.Size, Struct.Ptr, propertyData)
    GetPropertySize(property, bufferSize)
      => ComCall(7, this.p, DXCoreAdapterProperty, property, IntPtr.Ptr, bufferSize)
    IsQueryStateSupported(property)
      => ComCall(8, this.p, DXCoreAdapterState, property, Boolean8)
    QueryState(state, inputStateDetails?, outputBuffer)
      => ComCall(9, this.p, DXCoreAdapterState, state, IntPtr, inputStateDetails?.Size ?? 0, Struct.Ptr, inputStateDetails?, IntPtr, outputBuffer.Size, Struct.Ptr, outputBuffer)
    IsSetStateSupported(property)
      => ComCall(10, this.p, DXCoreAdapterState, property, Boolean8)
    SetState(state, inputStateDetails?, inputData)
      => ComCall(11, this.p, DXCoreAdapterState, state, IntPtr, inputStateDetails?.Size ?? 0, Struct.Ptr, inputStateDetails?, IntPtr, inputData.Size, Struct.Ptr, inputData)
    GetFactory(riid, ppvFactory)
      => ComCall(12, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvFactory)
}
struct IDXCoreAdapter1 extends IDXCoreAdapter {
    static IID := "{A0783366-CFA3-43BE-9D79-55B2DA97C63C}"
    GetPropertyWithInput(property, inputPropertyDetails?, outputBuffer)
      => ComCall(13, this.p, DXCoreAdapterProperty, property, IntPtr, inputPropertyDetails?.Size ?? 0, Struct.Ptr, inputPropertyDetails?, IntPtr, outputBuffer.Size, Struct.Ptr, outputBuffer)
}
struct IDXCoreAdapterList extends IUnknown {
    static IID := "{526C7776-40E9-459B-B711-F32AD76DFC28}"
    GetAdapter(index, riid, ppvAdapter)
      => ComCall(3, this.p, UInt32, index, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapter)
    GetAdapterCount()
      => ComCall(4, this.p, UInt32)
    IsStale()
      => ComCall(5, this.p, Boolean8)
    GetFactory(riid, ppvFactory)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvFactory)
    Sort(preferences)
      => ComCall(7, this.p, UInt32, preferences.Length, DXCoreAdapterPreference.Ptr, preferences)
    IsAdapterPreferenceSupported(preference)
      => ComCall(8, this.p, DXCoreAdapterPreference, preference, Boolean8)
}
struct IDXCoreAdapterFactory extends IUnknown {
    static IID := "{78EE5945-C36E-4B13-A669-005DD11C0F06}"
    CreateAdapterList(filterAttributes, riid, ppvAdapterList)
      => ComCall(3, this.p, UInt32, filterAttributes.Length, GUID.Ptr, filterAttributes, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapterList)
    GetAdapterByLuid(adapterLUID, riid, ppvAdapter)
      => ComCall(4, this.p, LUID.Ptr, adapterLUID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapter)
    IsNotificationTypeSupported(notificationType)
      => ComCall(5, this.p, DXCoreNotificationType, notificationType, Boolean8)
    RegisterEventNotification(dxCoreObject, notificationType, callbackFunction, callbackContext?, eventCookie)
      => ComCall(6, this.p, IUnknown, dxCoreObject, DXCoreNotificationType, notificationType, PFN_DXCORE_NOTIFICATION_CALLBACK, callbackFunction, Struct.Ptr, callbackContext?, UInt32.Ptr, eventCookie)
    UnregisterEventNotification(eventCookie)
      => ComCall(7, this.p, UInt32, eventCookie)
}
struct IDXCoreAdapterFactory1 extends IDXCoreAdapterFactory {
    static IID := "{D5682E19-6D21-401C-827A-9A51A4EA35D7}"
    CreateAdapterListByWorkload(workload, runtimeFilter, hardwareTypeFilter, riid, ppvAdapterList)
      => ComCall(8, this.p, DXCoreWorkload, workload, DXCoreRuntimeFilterFlags, runtimeFilter, DXCoreHardwareTypeFilterFlags, hardwareTypeFilter, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapterList)
}
