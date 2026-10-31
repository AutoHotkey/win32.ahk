#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PWSTR}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR}

struct DFS_INFO_1_32 {
    EntryPath : UInt32
}
struct DFS_INFO_2_32 {
    EntryPath : UInt32
    Comment : UInt32
    State : UInt32
    NumberOfStorages : UInt32
}
struct DFS_STORAGE_INFO_0_32 {
    State : UInt32
    ServerName : UInt32
    ShareName : UInt32
}
struct DFS_INFO_3_32 {
    EntryPath : UInt32
    Comment : UInt32
    State : UInt32
    NumberOfStorages : UInt32
    Storage : UInt32
}
struct DFS_INFO_4_32 {
    EntryPath : UInt32
    Comment : UInt32
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    NumberOfStorages : UInt32
    Storage : UInt32
}
struct DFS_TARGET_PRIORITY_CLASS extends Int32 {
    static DfsInvalidPriorityClass := -1
    static DfsSiteCostNormalPriorityClass := 0
    static DfsGlobalHighPriorityClass := 1
    static DfsSiteCostHighPriorityClass := 2
    static DfsSiteCostLowPriorityClass := 3
    static DfsGlobalLowPriorityClass := 4
}
struct DFS_TARGET_PRIORITY {
    TargetPriorityClass : DFS_TARGET_PRIORITY_CLASS
    TargetPriorityRank : UInt16
    Reserved : UInt16
}
struct DFS_INFO_1 {
    EntryPath : PWSTR
}
struct DFS_INFO_2 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    NumberOfStorages : UInt32
}
struct DFS_STORAGE_INFO {
    State : UInt32
    ServerName : PWSTR
    ShareName : PWSTR
}
struct DFS_STORAGE_INFO_1 {
    State : UInt32
    ServerName : PWSTR
    ShareName : PWSTR
    TargetPriority : DFS_TARGET_PRIORITY
}
struct DFS_INFO_3 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    NumberOfStorages : UInt32
    Storage : DFS_STORAGE_INFO.Ptr
}
struct DFS_INFO_4 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    NumberOfStorages : UInt32
    Storage : DFS_STORAGE_INFO.Ptr
}
struct DFS_INFO_5 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    PropertyFlags : UInt32
    MetadataSize : UInt32
    NumberOfStorages : UInt32
}
struct DFS_INFO_6 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    PropertyFlags : UInt32
    MetadataSize : UInt32
    NumberOfStorages : UInt32
    Storage : DFS_STORAGE_INFO_1.Ptr
}
struct DFS_INFO_7 {
    GenerationGuid : GUID
}
struct DFS_INFO_8 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    PropertyFlags : UInt32
    MetadataSize : UInt32
    SdLengthReserved : UInt32
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    NumberOfStorages : UInt32
}
struct DFS_INFO_9 {
    EntryPath : PWSTR
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    Guid : GUID
    PropertyFlags : UInt32
    MetadataSize : UInt32
    SdLengthReserved : UInt32
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    NumberOfStorages : UInt32
    Storage : DFS_STORAGE_INFO_1.Ptr
}
struct DFS_INFO_50 {
    NamespaceMajorVersion : UInt32
    NamespaceMinorVersion : UInt32
    NamespaceCapabilities : Int64
}
struct DFS_INFO_100 {
    Comment : PWSTR
}
struct DFS_INFO_101 {
    State : UInt32
}
struct DFS_INFO_102 {
    Timeout : UInt32
}
struct DFS_INFO_103 {
    PropertyFlagMask : UInt32
    PropertyFlags : UInt32
}
struct DFS_INFO_104 {
    TargetPriority : DFS_TARGET_PRIORITY
}
struct DFS_INFO_105 {
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    PropertyFlagMask : UInt32
    PropertyFlags : UInt32
}
struct DFS_INFO_106 {
    State : UInt32
    TargetPriority : DFS_TARGET_PRIORITY
}
struct DFS_INFO_107 {
    Comment : PWSTR
    State : UInt32
    Timeout : UInt32
    PropertyFlagMask : UInt32
    PropertyFlags : UInt32
    SdLengthReserved : UInt32
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct DFS_INFO_150 {
    SdLengthReserved : UInt32
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct DFS_INFO_200 {
    FtDfsName : PWSTR
}
struct DFS_INFO_300 {
    Flags : UInt32
    DfsName : PWSTR
}
struct DFS_SITENAME_INFO {
    SiteFlags : UInt32
    SiteName : PWSTR
}
struct DFS_SITELIST_INFO {
    cSites : UInt32
    Site : DFS_SITENAME_INFO[1]
}
struct DFS_NAMESPACE_VERSION_ORIGIN extends Int32 {
    static DFS_NAMESPACE_VERSION_ORIGIN_COMBINED := 0
    static DFS_NAMESPACE_VERSION_ORIGIN_SERVER := 1
    static DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN := 2
}
struct DFS_SUPPORTED_NAMESPACE_VERSION_INFO {
    DomainDfsMajorVersion : UInt32
    DomainDfsMinorVersion : UInt32
    DomainDfsCapabilities : Int64
    StandaloneDfsMajorVersion : UInt32
    StandaloneDfsMinorVersion : UInt32
    StandaloneDfsCapabilities : Int64
}
struct DFS_GET_PKT_ENTRY_STATE_ARG {
    DfsEntryPathLen : UInt16
    ServerNameLen : UInt16
    ShareNameLen : UInt16
    Level : UInt32
    Buffer : UInt16[1]
}
