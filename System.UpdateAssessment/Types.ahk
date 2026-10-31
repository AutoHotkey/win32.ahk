#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct UpdateImpactLevel extends Int32 {
    static UpdateImpactLevel_None := 0
    static UpdateImpactLevel_Low := 1
    static UpdateImpactLevel_Medium := 2
    static UpdateImpactLevel_High := 3
}
struct UpdateAssessmentStatus extends Int32 {
    static UpdateAssessmentStatus_Latest := 0
    static UpdateAssessmentStatus_NotLatestSoftRestriction := 1
    static UpdateAssessmentStatus_NotLatestHardRestriction := 2
    static UpdateAssessmentStatus_NotLatestEndOfSupport := 3
    static UpdateAssessmentStatus_NotLatestServicingTrain := 4
    static UpdateAssessmentStatus_NotLatestDeferredFeature := 5
    static UpdateAssessmentStatus_NotLatestDeferredQuality := 6
    static UpdateAssessmentStatus_NotLatestPausedFeature := 7
    static UpdateAssessmentStatus_NotLatestPausedQuality := 8
    static UpdateAssessmentStatus_NotLatestManaged := 9
    static UpdateAssessmentStatus_NotLatestUnknown := 10
    static UpdateAssessmentStatus_NotLatestTargetedVersion := 11
}
struct UpdateAssessment {
    status : UpdateAssessmentStatus
    impact : UpdateImpactLevel
    daysOutOfDate : UInt32
}
struct OSUpdateAssessment {
    isEndOfSupport : BOOL
    assessmentForCurrent : UpdateAssessment
    assessmentForUpToDate : UpdateAssessment
    securityStatus : UpdateAssessmentStatus
    assessmentTime : FILETIME
    releaseInfoTime : FILETIME
    currentOSBuild : PWSTR
    currentOSReleaseTime : FILETIME
    upToDateOSBuild : PWSTR
    upToDateOSReleaseTime : FILETIME
}
struct CloudCampaignAssessment {
    name : PWSTR
    tool : PWSTR
}
struct IWaaSAssessor extends IUnknown {
    static IID := "{2347BBEF-1A3B-45A4-902D-3E09C269B45E}"
    GetOSUpdateAssessment(result)
      => ComCall(3, this.p, OSUpdateAssessment.Ptr, result)
}
