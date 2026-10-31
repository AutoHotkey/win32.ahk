#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, PWSTR}

struct HDIAGNOSTIC_DATA_QUERY_SESSION {
    Value : IntPtr
}
struct HDIAGNOSTIC_REPORT {
    Value : IntPtr
}
struct HDIAGNOSTIC_EVENT_TAG_DESCRIPTION {
    Value : IntPtr
}
struct HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION {
    Value : IntPtr
}
struct HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION {
    Value : IntPtr
}
struct HDIAGNOSTIC_RECORD {
    Value : IntPtr
}
struct DdqAccessLevel extends Int32 {
    static NoData := 0
    static CurrentUserData := 1
    static AllUserData := 2
}
struct DIAGNOSTIC_DATA_RECORD {
    rowId : Int64
    timestamp : Int64
    eventKeywords : Int64
    fullEventName : PWSTR
    providerGroupGuid : PWSTR
    producerName : PWSTR
    privacyTags : Int32.Ptr
    privacyTagCount : UInt32
    categoryIds : Int32.Ptr
    categoryIdCount : UInt32
    isCoreData : BOOL
    extra1 : PWSTR
    extra2 : PWSTR
    extra3 : PWSTR
}
struct DIAGNOSTIC_DATA_SEARCH_CRITERIA {
    producerNames : PWSTR.Ptr
    producerNameCount : UInt32
    textToMatch : PWSTR
    categoryIds : Int32.Ptr
    categoryIdCount : UInt32
    privacyTags : Int32.Ptr
    privacyTagCount : UInt32
    coreDataOnly : BOOL
}
struct DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION {
    privacyTag : Int32
    name : PWSTR
    description : PWSTR
}
struct DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION {
    name : PWSTR
}
struct DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION {
    id : Int32
    name : PWSTR
}
struct DIAGNOSTIC_DATA_EVENT_TAG_STATS {
    privacyTag : Int32
    eventCount : UInt32
}
struct DIAGNOSTIC_DATA_EVENT_BINARY_STATS {
    moduleName : PWSTR
    friendlyModuleName : PWSTR
    eventCount : UInt32
    uploadSizeBytes : Int64
}
struct DIAGNOSTIC_DATA_GENERAL_STATS {
    optInLevel : UInt32
    transcriptSizeBytes : Int64
    oldestEventTimestamp : Int64
    totalEventCountLast24Hours : UInt32
    averageDailyEvents : Float32
}
struct DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION {
    hoursOfHistoryToKeep : UInt32
    maxStoreMegabytes : UInt32
    requestedMaxStoreMegabytes : UInt32
}
struct DIAGNOSTIC_REPORT_PARAMETER {
    name : UInt16[129]
    value : UInt16[260]
}
struct DIAGNOSTIC_REPORT_SIGNATURE {
    eventName : UInt16[65]
    parameters : DIAGNOSTIC_REPORT_PARAMETER[10]
}
struct DIAGNOSTIC_REPORT_DATA {
    signature : DIAGNOSTIC_REPORT_SIGNATURE
    bucketId : GUID
    reportId : GUID
    creationTime : FILETIME
    sizeInBytes : Int64
    cabId : PWSTR
    reportStatus : UInt32
    reportIntegratorId : GUID
    fileNames : PWSTR.Ptr
    fileCount : UInt32
    friendlyEventName : PWSTR
    applicationName : PWSTR
    applicationPath : PWSTR
    description : PWSTR
    bucketIdString : PWSTR
    legacyBucketId : Int64
    reportKey : PWSTR
}
