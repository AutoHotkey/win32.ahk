#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct FH_SERVICE_PIPE_HANDLE {
    Value : Struct.Ptr
}
struct FH_TARGET_PROPERTY_TYPE extends Int32 {
    static FH_TARGET_NAME := 0
    static FH_TARGET_URL := 1
    static FH_TARGET_DRIVE_TYPE := 2
    static MAX_TARGET_PROPERTY := 3
}
struct FH_TARGET_DRIVE_TYPES extends Int32 {
    static FH_DRIVE_UNKNOWN := 0
    static FH_DRIVE_REMOVABLE := 2
    static FH_DRIVE_FIXED := 3
    static FH_DRIVE_REMOTE := 4
}
struct IFhTarget extends IUnknown {
    static IID := "{D87965FD-2BAD-4657-BD3B-9567EB300CED}"
    GetStringProperty(PropertyType, PropertyValue)
      => ComCall(3, this.p, FH_TARGET_PROPERTY_TYPE, PropertyType, BSTR.Ptr, PropertyValue)
    GetNumericalProperty(PropertyType, PropertyValue)
      => ComCall(4, this.p, FH_TARGET_PROPERTY_TYPE, PropertyType, Int64.Ptr, PropertyValue)
}
struct IFhScopeIterator extends IUnknown {
    static IID := "{3197ABCE-532A-44C6-8615-F3666566A720}"
    MoveToNextItem()
      => ComCall(3, this.p)
    GetItem(Item)
      => ComCall(4, this.p, BSTR.Ptr, Item)
}
struct FH_PROTECTED_ITEM_CATEGORY extends Int32 {
    static FH_FOLDER := 0
    static FH_LIBRARY := 1
    static MAX_PROTECTED_ITEM_CATEGORY := 2
}
struct FH_LOCAL_POLICY_TYPE extends Int32 {
    static FH_FREQUENCY := 0
    static FH_RETENTION_TYPE := 1
    static FH_RETENTION_AGE := 2
    static MAX_LOCAL_POLICY := 3
}
struct FH_RETENTION_TYPES extends Int32 {
    static FH_RETENTION_DISABLED := 0
    static FH_RETENTION_UNLIMITED := 1
    static FH_RETENTION_AGE_BASED := 2
    static MAX_RETENTION_TYPE := 3
}
struct FH_BACKUP_STATUS extends Int32 {
    static FH_STATUS_DISABLED := 0
    static FH_STATUS_DISABLED_BY_GP := 1
    static FH_STATUS_ENABLED := 2
    static FH_STATUS_REHYDRATING := 3
    static MAX_BACKUP_STATUS := 4
}
struct FH_DEVICE_VALIDATION_RESULT extends Int32 {
    static FH_ACCESS_DENIED := 0
    static FH_INVALID_DRIVE_TYPE := 1
    static FH_READ_ONLY_PERMISSION := 2
    static FH_CURRENT_DEFAULT := 3
    static FH_NAMESPACE_EXISTS := 4
    static FH_TARGET_PART_OF_LIBRARY := 5
    static FH_VALID_TARGET := 6
    static MAX_VALIDATION_RESULT := 7
}
struct IFhConfigMgr extends IUnknown {
    static IID := "{6A5FEA5B-BF8F-4EE5-B8C3-44D8A0D7331C}"
    LoadConfiguration()
      => ComCall(3, this.p)
    CreateDefaultConfiguration(OverwriteIfExists)
      => ComCall(4, this.p, BOOL, OverwriteIfExists)
    SaveConfiguration()
      => ComCall(5, this.p)
    AddRemoveExcludeRule(Add, Category, Item)
      => ComCall(6, this.p, BOOL, Add, FH_PROTECTED_ITEM_CATEGORY, Category, BSTR, Item)
    GetIncludeExcludeRules(Include, Category, Iterator)
      => ComCall(7, this.p, BOOL, Include, FH_PROTECTED_ITEM_CATEGORY, Category, IFhScopeIterator.Ptr, Iterator)
    GetLocalPolicy(LocalPolicyType, PolicyValue)
      => ComCall(8, this.p, FH_LOCAL_POLICY_TYPE, LocalPolicyType, Int64.Ptr, PolicyValue)
    SetLocalPolicy(LocalPolicyType, PolicyValue)
      => ComCall(9, this.p, FH_LOCAL_POLICY_TYPE, LocalPolicyType, Int64, PolicyValue)
    GetBackupStatus(BackupStatus)
      => ComCall(10, this.p, FH_BACKUP_STATUS.Ptr, BackupStatus)
    SetBackupStatus(BackupStatus)
      => ComCall(11, this.p, FH_BACKUP_STATUS, BackupStatus)
    GetDefaultTarget(DefaultTarget)
      => ComCall(12, this.p, IFhTarget.Ptr, DefaultTarget)
    ValidateTarget(TargetUrl, ValidationResult)
      => ComCall(13, this.p, BSTR, TargetUrl, FH_DEVICE_VALIDATION_RESULT.Ptr, ValidationResult)
    ProvisionAndSetNewTarget(TargetUrl, TargetName)
      => ComCall(14, this.p, BSTR, TargetUrl, BSTR, TargetName)
    ChangeDefaultTargetRecommendation(Recommend)
      => ComCall(15, this.p, BOOL, Recommend)
    QueryProtectionStatus(ProtectionState, ProtectedUntilTime)
      => ComCall(16, this.p, UInt32.Ptr, ProtectionState, BSTR.Ptr, ProtectedUntilTime)
}
struct IFhReassociation extends IUnknown {
    static IID := "{6544A28A-F68D-47AC-91EF-16B2B36AA3EE}"
    ValidateTarget(TargetUrl, ValidationResult)
      => ComCall(3, this.p, BSTR, TargetUrl, FH_DEVICE_VALIDATION_RESULT.Ptr, ValidationResult)
    ScanTargetForConfigurations(TargetUrl)
      => ComCall(4, this.p, BSTR, TargetUrl)
    GetConfigurationDetails(Index, UserName, PcName, BackupTime)
      => ComCall(5, this.p, UInt32, Index, BSTR.Ptr, UserName, BSTR.Ptr, PcName, FILETIME.Ptr, BackupTime)
    SelectConfiguration(Index)
      => ComCall(6, this.p, UInt32, Index)
    PerformReassociation(OverwriteIfExists)
      => ComCall(7, this.p, BOOL, OverwriteIfExists)
}
struct FhBackupStopReason extends Int32 {
    static BackupInvalidStopReason := 0
    static BackupLimitUserBusyMachineOnAC := 1
    static BackupLimitUserIdleMachineOnDC := 2
    static BackupLimitUserBusyMachineOnDC := 3
    static BackupCancelled := 4
}
