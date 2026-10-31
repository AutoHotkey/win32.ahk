#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HRESULT, PWSTR}

struct IsolationState extends Int32 {
    static isolationStateNotRestricted := 1
    static isolationStateInProbation := 2
    static isolationStateRestrictedAccess := 3
}
struct ExtendedIsolationState extends Int32 {
    static extendedIsolationStateNoData := 0
    static extendedIsolationStateTransition := 1
    static extendedIsolationStateInfected := 2
    static extendedIsolationStateUnknown := 3
}
struct NapTracingLevel extends Int32 {
    static tracingLevelUndefined := 0
    static tracingLevelBasic := 1
    static tracingLevelAdvanced := 2
    static tracingLevelDebug := 3
}
struct CountedString {
    length : UInt16
    string : PWSTR
}
struct IsolationInfo {
    isolationState : IsolationState
    probEndTime : FILETIME
    failureUrl : CountedString
}
struct IsolationInfoEx {
    isolationState : IsolationState
    extendedIsolationState : ExtendedIsolationState
    probEndTime : FILETIME
    failureUrl : CountedString
}
struct FailureCategory extends Int32 {
    static failureCategoryNone := 0
    static failureCategoryOther := 1
    static failureCategoryClientComponent := 2
    static failureCategoryClientCommunication := 3
    static failureCategoryServerComponent := 4
    static failureCategoryServerCommunication := 5
}
struct FailureCategoryMapping {
    mappingCompliance : BOOL[5]
}
struct CorrelationId {
    connId : GUID
    timeStamp : FILETIME
}
struct ResultCodes {
    count : UInt16
    results : HRESULT.Ptr
}
struct Ipv4Address {
    addr : UInt8[4]
}
struct Ipv6Address {
    addr : UInt8[16]
}
struct FixupState extends Int32 {
    static fixupStateSuccess := 0
    static fixupStateInProgress := 1
    static fixupStateCouldNotUpdate := 2
}
struct FixupInfo {
    state : FixupState
    percentage : UInt8
    resultCodes : ResultCodes
    fixupMsgId : UInt32
}
struct NapNotifyType extends Int32 {
    static napNotifyTypeUnknown := 0
    static napNotifyTypeServiceState := 1
    static napNotifyTypeQuarState := 2
}
struct SystemHealthAgentState {
    id : UInt32
    shaResultCodes : ResultCodes
    failureCategory : FailureCategory
    fixupInfo : FixupInfo
}
struct SoHAttribute {
    type : UInt16
    size : UInt16
    value : UInt8.Ptr
}
struct SoH {
    count : UInt16
    attributes : SoHAttribute.Ptr
}
struct NetworkSoH {
    size : UInt16
    data : UInt8.Ptr
}
struct PrivateData {
    size : UInt16
    data : UInt8.Ptr
}
struct NapComponentRegistrationInfo {
    id : UInt32
    friendlyName : CountedString
    description : CountedString
    version : CountedString
    vendorName : CountedString
    infoClsid : GUID
    configClsid : GUID
    registrationDate : FILETIME
    componentType : UInt32
}
struct RemoteConfigurationType extends Int32 {
    static remoteConfigTypeMachine := 1
    static remoteConfigTypeConfigBlob := 2
}
