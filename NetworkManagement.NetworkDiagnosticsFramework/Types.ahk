#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, FILETIME, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct ATTRIBUTE_TYPE extends Int32 {
    static AT_INVALID := 0
    static AT_BOOLEAN := 1
    static AT_INT8 := 2
    static AT_UINT8 := 3
    static AT_INT16 := 4
    static AT_UINT16 := 5
    static AT_INT32 := 6
    static AT_UINT32 := 7
    static AT_INT64 := 8
    static AT_UINT64 := 9
    static AT_STRING := 10
    static AT_GUID := 11
    static AT_LIFE_TIME := 12
    static AT_SOCKADDR := 13
    static AT_OCTET_STRING := 14
}
struct OCTET_STRING {
    dwLength : UInt32
    lpValue : UInt8.Ptr
}
struct LIFE_TIME {
    startTime : FILETIME
    endTime : FILETIME
}
struct DIAG_SOCKADDR {
    family : UInt16
    data : CHAR[126]
}
struct HELPER_ATTRIBUTE {
    pwszName : PWSTR
    type : ATTRIBUTE_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Boolean : BOOL
            Char : UInt8
            Byte : UInt8
            Short : Int16
            Word : UInt16
            Int : Int32
            DWord : UInt32
            Int64 : Int64
            UInt64 : Int64
            PWStr : PWSTR
            Guid : GUID
            LifeTime : LIFE_TIME
            Address : DIAG_SOCKADDR
            OctetString : OCTET_STRING
        }
    }
}
struct REPAIR_SCOPE extends Int32 {
    static RS_SYSTEM := 0
    static RS_USER := 1
    static RS_APPLICATION := 2
    static RS_PROCESS := 3
}
struct REPAIR_RISK extends Int32 {
    static RR_NOROLLBACK := 0
    static RR_ROLLBACK := 1
    static RR_NORISK := 2
}
struct UI_INFO_TYPE extends Int32 {
    static UIT_INVALID := 0
    static UIT_NONE := 1
    static UIT_SHELL_COMMAND := 2
    static UIT_HELP_PANE := 3
    static UIT_DUI := 4
}
struct ShellCommandInfo {
    pwszOperation : PWSTR
    pwszFile : PWSTR
    pwszParameters : PWSTR
    pwszDirectory : PWSTR
    nShowCmd : UInt32
}
struct UiInfo {
    type : UI_INFO_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pwzNull : PWSTR
            ShellInfo : ShellCommandInfo
            pwzHelpUrl : PWSTR
            pwzDui : PWSTR
        }
    }
}
struct RepairInfo {
    guid : GUID
    pwszClassName : PWSTR
    pwszDescription : PWSTR
    sidType : UInt32
    cost : Int32
    flags : UInt32
    scope : REPAIR_SCOPE
    risk : REPAIR_RISK
    UiInfo : UiInfo
    rootCauseIndex : Int32
}
struct RepairInfoEx {
    repair : RepairInfo
    repairRank : UInt16
}
struct RootCauseInfo {
    pwszDescription : PWSTR
    rootCauseID : GUID
    rootCauseFlags : UInt32
    networkInterfaceID : GUID
    pRepairs : RepairInfoEx.Ptr
    repairCount : UInt16
}
struct DIAGNOSIS_STATUS extends Int32 {
    static DS_NOT_IMPLEMENTED := 0
    static DS_CONFIRMED := 1
    static DS_REJECTED := 2
    static DS_INDETERMINATE := 3
    static DS_DEFERRED := 4
    static DS_PASSTHROUGH := 5
}
struct REPAIR_STATUS extends Int32 {
    static RS_NOT_IMPLEMENTED := 0
    static RS_REPAIRED := 1
    static RS_UNREPAIRED := 2
    static RS_DEFERRED := 3
    static RS_USER_ACTION := 4
}
struct PROBLEM_TYPE extends Int32 {
    static PT_INVALID := 0
    static PT_LOW_HEALTH := 1
    static PT_LOWER_HEALTH := 2
    static PT_DOWN_STREAM_HEALTH := 4
    static PT_HIGH_UTILIZATION := 8
    static PT_HIGHER_UTILIZATION := 16
    static PT_UP_STREAM_UTILIZATION := 32
}
struct HYPOTHESIS {
    pwszClassName : PWSTR
    pwszDescription : PWSTR
    celt : UInt32
    rgAttributes : HELPER_ATTRIBUTE.Ptr
}
struct HelperAttributeInfo {
    pwszName : PWSTR
    type : ATTRIBUTE_TYPE
}
struct DiagnosticsInfo {
    cost : Int32
    flags : UInt32
}
struct INetDiagHelper extends IUnknown {
    static IID := "{C0B35746-EBF5-11D8-BBE9-505054503030}"
    Initialize(rgAttributes)
      => ComCall(3, this.p, UInt32, rgAttributes.Length, HELPER_ATTRIBUTE.Ptr, rgAttributes)
    GetDiagnosticsInfo(ppInfo)
      => ComCall(4, this.p, DiagnosticsInfo.Ptr.Ptr, ppInfo)
    GetKeyAttributes(pprgAttributes)
      => ComCall(5, this.p, UInt32.Ptr, pprgAttributes.Length, HELPER_ATTRIBUTE.Ptr.Ptr, pprgAttributes)
    LowHealth(pwszInstanceDescription, ppwszDescription, pDeferredTime, pStatus)
      => ComCall(6, this.p, "Str", pwszInstanceDescription, PWSTR.Ptr, ppwszDescription, Int32.Ptr, pDeferredTime, DIAGNOSIS_STATUS.Ptr, pStatus)
    HighUtilization(pwszInstanceDescription, ppwszDescription, pDeferredTime, pStatus)
      => ComCall(7, this.p, "Str", pwszInstanceDescription, PWSTR.Ptr, ppwszDescription, Int32.Ptr, pDeferredTime, DIAGNOSIS_STATUS.Ptr, pStatus)
    GetLowerHypotheses(pprgHypotheses)
      => ComCall(8, this.p, UInt32.Ptr, pprgHypotheses.Length, HYPOTHESIS.Ptr.Ptr, pprgHypotheses)
    GetDownStreamHypotheses(pprgHypotheses)
      => ComCall(9, this.p, UInt32.Ptr, pprgHypotheses.Length, HYPOTHESIS.Ptr.Ptr, pprgHypotheses)
    GetHigherHypotheses(pprgHypotheses)
      => ComCall(10, this.p, UInt32.Ptr, pprgHypotheses.Length, HYPOTHESIS.Ptr.Ptr, pprgHypotheses)
    GetUpStreamHypotheses(pprgHypotheses)
      => ComCall(11, this.p, UInt32.Ptr, pprgHypotheses.Length, HYPOTHESIS.Ptr.Ptr, pprgHypotheses)
    Repair(pInfo, pDeferredTime, pStatus)
      => ComCall(12, this.p, RepairInfo.Ptr, pInfo, Int32.Ptr, pDeferredTime, REPAIR_STATUS.Ptr, pStatus)
    Validate(problem, pDeferredTime, pStatus)
      => ComCall(13, this.p, PROBLEM_TYPE, problem, Int32.Ptr, pDeferredTime, REPAIR_STATUS.Ptr, pStatus)
    GetRepairInfo(problem, ppInfo)
      => ComCall(14, this.p, PROBLEM_TYPE, problem, UInt32.Ptr, ppInfo.Length, RepairInfo.Ptr.Ptr, ppInfo)
    GetLifeTime(pLifeTime)
      => ComCall(15, this.p, LIFE_TIME.Ptr, pLifeTime)
    SetLifeTime(lifeTime)
      => ComCall(16, this.p, LIFE_TIME, lifeTime)
    GetCacheTime(pCacheTime)
      => ComCall(17, this.p, FILETIME.Ptr, pCacheTime)
    GetAttributes(pprgAttributes)
      => ComCall(18, this.p, UInt32.Ptr, pprgAttributes.Length, HELPER_ATTRIBUTE.Ptr.Ptr, pprgAttributes)
    Cancel()
      => ComCall(19, this.p)
    Cleanup()
      => ComCall(20, this.p)
}
struct HypothesisResult {
    hypothesis : HYPOTHESIS
    pathStatus : DIAGNOSIS_STATUS
}
struct INetDiagHelperUtilFactory extends IUnknown {
    static IID := "{104613FB-BC57-4178-95BA-88809698354A}"
    CreateUtilityInstance(riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct INetDiagHelperEx extends IUnknown {
    static IID := "{972DAB4D-E4E3-4FC6-AE54-5F65CCDE4A15}"
    ReconfirmLowHealth(pResults, ppwszUpdatedDescription, pUpdatedStatus)
      => ComCall(3, this.p, UInt32, pResults.Length, HypothesisResult.Ptr, pResults, PWSTR.Ptr, ppwszUpdatedDescription, DIAGNOSIS_STATUS.Ptr, pUpdatedStatus)
    SetUtilities(pUtilities)
      => ComCall(4, this.p, INetDiagHelperUtilFactory, pUtilities)
    ReproduceFailure()
      => ComCall(5, this.p)
}
struct INetDiagHelperInfo extends IUnknown {
    static IID := "{C0B35747-EBF5-11D8-BBE9-505054503030}"
    GetAttributeInfo(pprgAttributeInfos)
      => ComCall(3, this.p, UInt32.Ptr, pprgAttributeInfos.Length, HelperAttributeInfo.Ptr.Ptr, pprgAttributeInfos)
}
struct INetDiagExtensibleHelper extends IUnknown {
    static IID := "{C0B35748-EBF5-11D8-BBE9-505054503030}"
    ResolveAttributes(rgKeyAttributes, prgMatchValues)
      => ComCall(3, this.p, UInt32, rgKeyAttributes.Length, HELPER_ATTRIBUTE.Ptr, rgKeyAttributes, UInt32.Ptr, prgMatchValues.Length, HELPER_ATTRIBUTE.Ptr.Ptr, prgMatchValues)
}
