#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct FsrmQuotaFlags extends Int32 {
    static FsrmQuotaFlags_Enforce := 256
    static FsrmQuotaFlags_Disable := 512
    static FsrmQuotaFlags_StatusIncomplete := 65536
    static FsrmQuotaFlags_StatusRebuilding := 131072
}
struct FsrmFileScreenFlags extends Int32 {
    static FsrmFileScreenFlags_Enforce := 1
}
struct FsrmCollectionState extends Int32 {
    static FsrmCollectionState_Fetching := 1
    static FsrmCollectionState_Committing := 2
    static FsrmCollectionState_Complete := 3
    static FsrmCollectionState_Cancelled := 4
}
struct FsrmEnumOptions extends Int32 {
    static FsrmEnumOptions_None := 0
    static FsrmEnumOptions_Asynchronous := 1
    static FsrmEnumOptions_CheckRecycleBin := 2
    static FsrmEnumOptions_IncludeClusterNodes := 4
    static FsrmEnumOptions_IncludeDeprecatedObjects := 8
}
struct FsrmCommitOptions extends Int32 {
    static FsrmCommitOptions_None := 0
    static FsrmCommitOptions_Asynchronous := 1
}
struct FsrmTemplateApplyOptions extends Int32 {
    static FsrmTemplateApplyOptions_ApplyToDerivedMatching := 1
    static FsrmTemplateApplyOptions_ApplyToDerivedAll := 2
}
struct FsrmActionType extends Int32 {
    static FsrmActionType_Unknown := 0
    static FsrmActionType_EventLog := 1
    static FsrmActionType_Email := 2
    static FsrmActionType_Command := 3
    static FsrmActionType_Report := 4
}
struct FsrmEventType extends Int32 {
    static FsrmEventType_Unknown := 0
    static FsrmEventType_Information := 1
    static FsrmEventType_Warning := 2
    static FsrmEventType_Error := 3
}
struct FsrmAccountType extends Int32 {
    static FsrmAccountType_Unknown := 0
    static FsrmAccountType_NetworkService := 1
    static FsrmAccountType_LocalService := 2
    static FsrmAccountType_LocalSystem := 3
    static FsrmAccountType_InProc := 4
    static FsrmAccountType_External := 5
    static FsrmAccountType_Automatic := 500
}
struct FsrmReportType extends Int32 {
    static FsrmReportType_Unknown := 0
    static FsrmReportType_LargeFiles := 1
    static FsrmReportType_FilesByType := 2
    static FsrmReportType_LeastRecentlyAccessed := 3
    static FsrmReportType_MostRecentlyAccessed := 4
    static FsrmReportType_QuotaUsage := 5
    static FsrmReportType_FilesByOwner := 6
    static FsrmReportType_ExportReport := 7
    static FsrmReportType_DuplicateFiles := 8
    static FsrmReportType_FileScreenAudit := 9
    static FsrmReportType_FilesByProperty := 10
    static FsrmReportType_AutomaticClassification := 11
    static FsrmReportType_Expiration := 12
    static FsrmReportType_FoldersByProperty := 13
}
struct FsrmReportFormat extends Int32 {
    static FsrmReportFormat_Unknown := 0
    static FsrmReportFormat_DHtml := 1
    static FsrmReportFormat_Html := 2
    static FsrmReportFormat_Txt := 3
    static FsrmReportFormat_Csv := 4
    static FsrmReportFormat_Xml := 5
}
struct FsrmReportRunningStatus extends Int32 {
    static FsrmReportRunningStatus_Unknown := 0
    static FsrmReportRunningStatus_NotRunning := 1
    static FsrmReportRunningStatus_Queued := 2
    static FsrmReportRunningStatus_Running := 3
}
struct FsrmReportGenerationContext extends Int32 {
    static FsrmReportGenerationContext_Undefined := 1
    static FsrmReportGenerationContext_ScheduledReport := 2
    static FsrmReportGenerationContext_InteractiveReport := 3
    static FsrmReportGenerationContext_IncidentReport := 4
}
struct FsrmReportFilter extends Int32 {
    static FsrmReportFilter_MinSize := 1
    static FsrmReportFilter_MinAgeDays := 2
    static FsrmReportFilter_MaxAgeDays := 3
    static FsrmReportFilter_MinQuotaUsage := 4
    static FsrmReportFilter_FileGroups := 5
    static FsrmReportFilter_Owners := 6
    static FsrmReportFilter_NamePattern := 7
    static FsrmReportFilter_Property := 8
}
struct FsrmReportLimit extends Int32 {
    static FsrmReportLimit_MaxFiles := 1
    static FsrmReportLimit_MaxFileGroups := 2
    static FsrmReportLimit_MaxOwners := 3
    static FsrmReportLimit_MaxFilesPerFileGroup := 4
    static FsrmReportLimit_MaxFilesPerOwner := 5
    static FsrmReportLimit_MaxFilesPerDuplGroup := 6
    static FsrmReportLimit_MaxDuplicateGroups := 7
    static FsrmReportLimit_MaxQuotas := 8
    static FsrmReportLimit_MaxFileScreenEvents := 9
    static FsrmReportLimit_MaxPropertyValues := 10
    static FsrmReportLimit_MaxFilesPerPropertyValue := 11
    static FsrmReportLimit_MaxFolders := 12
}
struct FsrmPropertyDefinitionType extends Int32 {
    static FsrmPropertyDefinitionType_Unknown := 0
    static FsrmPropertyDefinitionType_OrderedList := 1
    static FsrmPropertyDefinitionType_MultiChoiceList := 2
    static FsrmPropertyDefinitionType_SingleChoiceList := 3
    static FsrmPropertyDefinitionType_String := 4
    static FsrmPropertyDefinitionType_MultiString := 5
    static FsrmPropertyDefinitionType_Int := 6
    static FsrmPropertyDefinitionType_Bool := 7
    static FsrmPropertyDefinitionType_Date := 8
}
struct FsrmPropertyDefinitionFlags extends Int32 {
    static FsrmPropertyDefinitionFlags_Global := 1
    static FsrmPropertyDefinitionFlags_Deprecated := 2
    static FsrmPropertyDefinitionFlags_Secure := 4
}
struct FsrmPropertyDefinitionAppliesTo extends Int32 {
    static FsrmPropertyDefinitionAppliesTo_Files := 1
    static FsrmPropertyDefinitionAppliesTo_Folders := 2
}
struct FsrmRuleType extends Int32 {
    static FsrmRuleType_Unknown := 0
    static FsrmRuleType_Classification := 1
    static FsrmRuleType_Generic := 2
}
struct FsrmRuleFlags extends Int32 {
    static FsrmRuleFlags_Disabled := 256
    static FsrmRuleFlags_ClearAutomaticallyClassifiedProperty := 1024
    static FsrmRuleFlags_ClearManuallyClassifiedProperty := 2048
    static FsrmRuleFlags_Invalid := 4096
}
struct FsrmClassificationLoggingFlags extends Int32 {
    static FsrmClassificationLoggingFlags_None := 0
    static FsrmClassificationLoggingFlags_ClassificationsInLogFile := 1
    static FsrmClassificationLoggingFlags_ErrorsInLogFile := 2
    static FsrmClassificationLoggingFlags_ClassificationsInSystemLog := 4
    static FsrmClassificationLoggingFlags_ErrorsInSystemLog := 8
}
struct FsrmExecutionOption extends Int32 {
    static FsrmExecutionOption_Unknown := 0
    static FsrmExecutionOption_EvaluateUnset := 1
    static FsrmExecutionOption_ReEvaluate_ConsiderExistingValue := 2
    static FsrmExecutionOption_ReEvaluate_IgnoreExistingValue := 3
}
struct FsrmStorageModuleCaps extends Int32 {
    static FsrmStorageModuleCaps_Unknown := 0
    static FsrmStorageModuleCaps_CanGet := 1
    static FsrmStorageModuleCaps_CanSet := 2
    static FsrmStorageModuleCaps_CanHandleDirectories := 4
    static FsrmStorageModuleCaps_CanHandleFiles := 8
}
struct FsrmStorageModuleType extends Int32 {
    static FsrmStorageModuleType_Unknown := 0
    static FsrmStorageModuleType_Cache := 1
    static FsrmStorageModuleType_InFile := 2
    static FsrmStorageModuleType_Database := 3
    static FsrmStorageModuleType_System := 100
}
struct FsrmPropertyBagFlags extends Int32 {
    static FsrmPropertyBagFlags_UpdatedByClassifier := 1
    static FsrmPropertyBagFlags_FailedLoadingProperties := 2
    static FsrmPropertyBagFlags_FailedSavingProperties := 4
    static FsrmPropertyBagFlags_FailedClassifyingProperties := 8
}
struct FsrmPropertyBagField extends Int32 {
    static FsrmPropertyBagField_AccessVolume := 0
    static FsrmPropertyBagField_VolumeGuidName := 1
}
struct FsrmPropertyFlags extends Int32 {
    static FsrmPropertyFlags_None := 0
    static FsrmPropertyFlags_Orphaned := 1
    static FsrmPropertyFlags_RetrievedFromCache := 2
    static FsrmPropertyFlags_RetrievedFromStorage := 4
    static FsrmPropertyFlags_SetByClassifier := 8
    static FsrmPropertyFlags_Deleted := 16
    static FsrmPropertyFlags_Reclassified := 32
    static FsrmPropertyFlags_AggregationFailed := 64
    static FsrmPropertyFlags_Existing := 128
    static FsrmPropertyFlags_FailedLoadingProperties := 256
    static FsrmPropertyFlags_FailedClassifyingProperties := 512
    static FsrmPropertyFlags_FailedSavingProperties := 1024
    static FsrmPropertyFlags_Secure := 2048
    static FsrmPropertyFlags_PolicyDerived := 4096
    static FsrmPropertyFlags_Inherited := 8192
    static FsrmPropertyFlags_Manual := 16384
    static FsrmPropertyFlags_ExplicitValueDeleted := 32768
    static FsrmPropertyFlags_PropertyDeletedFromClear := 65536
    static FsrmPropertyFlags_PropertySourceMask := 14
    static FsrmPropertyFlags_PersistentMask := 20480
}
struct FsrmPipelineModuleType extends Int32 {
    static FsrmPipelineModuleType_Unknown := 0
    static FsrmPipelineModuleType_Storage := 1
    static FsrmPipelineModuleType_Classifier := 2
}
struct FsrmGetFilePropertyOptions extends Int32 {
    static FsrmGetFilePropertyOptions_None := 0
    static FsrmGetFilePropertyOptions_NoRuleEvaluation := 1
    static FsrmGetFilePropertyOptions_Persistent := 2
    static FsrmGetFilePropertyOptions_FailOnPersistErrors := 4
    static FsrmGetFilePropertyOptions_SkipOrphaned := 8
}
struct FsrmFileManagementType extends Int32 {
    static FsrmFileManagementType_Unknown := 0
    static FsrmFileManagementType_Expiration := 1
    static FsrmFileManagementType_Custom := 2
    static FsrmFileManagementType_Rms := 3
}
struct FsrmFileManagementLoggingFlags extends Int32 {
    static FsrmFileManagementLoggingFlags_None := 0
    static FsrmFileManagementLoggingFlags_Error := 1
    static FsrmFileManagementLoggingFlags_Information := 2
    static FsrmFileManagementLoggingFlags_Audit := 4
}
struct FsrmPropertyConditionType extends Int32 {
    static FsrmPropertyConditionType_Unknown := 0
    static FsrmPropertyConditionType_Equal := 1
    static FsrmPropertyConditionType_NotEqual := 2
    static FsrmPropertyConditionType_GreaterThan := 3
    static FsrmPropertyConditionType_LessThan := 4
    static FsrmPropertyConditionType_Contain := 5
    static FsrmPropertyConditionType_Exist := 6
    static FsrmPropertyConditionType_NotExist := 7
    static FsrmPropertyConditionType_StartWith := 8
    static FsrmPropertyConditionType_EndWith := 9
    static FsrmPropertyConditionType_ContainedIn := 10
    static FsrmPropertyConditionType_PrefixOf := 11
    static FsrmPropertyConditionType_SuffixOf := 12
    static FsrmPropertyConditionType_MatchesPattern := 13
}
struct FsrmFileStreamingMode extends Int32 {
    static FsrmFileStreamingMode_Unknown := 0
    static FsrmFileStreamingMode_Read := 1
    static FsrmFileStreamingMode_Write := 2
}
struct FsrmFileStreamingInterfaceType extends Int32 {
    static FsrmFileStreamingInterfaceType_Unknown := 0
    static FsrmFileStreamingInterfaceType_ILockBytes := 1
    static FsrmFileStreamingInterfaceType_IStream := 2
}
struct FsrmFileConditionType extends Int32 {
    static FsrmFileConditionType_Unknown := 0
    static FsrmFileConditionType_Property := 1
}
struct FsrmFileSystemPropertyId extends Int32 {
    static FsrmFileSystemPropertyId_Undefined := 0
    static FsrmFileSystemPropertyId_FileName := 1
    static FsrmFileSystemPropertyId_DateCreated := 2
    static FsrmFileSystemPropertyId_DateLastAccessed := 3
    static FsrmFileSystemPropertyId_DateLastModified := 4
    static FsrmFileSystemPropertyId_DateNow := 5
}
struct FsrmPropertyValueType extends Int32 {
    static FsrmPropertyValueType_Undefined := 0
    static FsrmPropertyValueType_Literal := 1
    static FsrmPropertyValueType_DateOffset := 2
}
struct AdrClientDisplayFlags extends Int32 {
    static AdrClientDisplayFlags_AllowEmailRequests := 1
    static AdrClientDisplayFlags_ShowDeviceTroubleshooting := 2
}
struct AdrEmailFlags extends Int32 {
    static AdrEmailFlags_PutDataOwnerOnToLine := 1
    static AdrEmailFlags_PutAdminOnToLine := 2
    static AdrEmailFlags_IncludeDeviceClaims := 4
    static AdrEmailFlags_IncludeUserInfo := 8
    static AdrEmailFlags_GenerateEventLog := 16
}
struct AdrClientErrorType extends Int32 {
    static AdrClientErrorType_Unknown := 0
    static AdrClientErrorType_AccessDenied := 1
    static AdrClientErrorType_FileNotFound := 2
}
struct AdrClientFlags extends Int32 {
    static AdrClientFlags_None := 0
    static AdrClientFlags_FailForLocalPaths := 1
    static AdrClientFlags_FailIfNotSupportedByServer := 2
    static AdrClientFlags_FailIfNotDomainJoined := 4
}
struct IFsrmObject extends IDispatch {
    static IID := "{22BCEF93-4A3F-4183-89F9-2F8B8A628AEE}"
    get_Id(id)
      => ComCall(7, this.p, GUID.Ptr, id)
    get_Description(description)
      => ComCall(8, this.p, BSTR.Ptr, description)
    put_Description(description)
      => ComCall(9, this.p, BSTR, description)
    Delete()
      => ComCall(10, this.p)
    Commit()
      => ComCall(11, this.p)
}
struct IFsrmCollection extends IDispatch {
    static IID := "{F76FBF3B-8DDD-4B42-B05A-CB1C3FF1FEE8}"
    get__NewEnum(unknown)
      => ComCall(7, this.p, IUnknown.Ptr, unknown)
    get_Item(index, item)
      => ComCall(8, this.p, Int32, index, VARIANT.Ptr, item)
    get_Count(count)
      => ComCall(9, this.p, Int32.Ptr, count)
    get_State(state)
      => ComCall(10, this.p, FsrmCollectionState.Ptr, state)
    Cancel()
      => ComCall(11, this.p)
    WaitForCompletion(waitSeconds, completed)
      => ComCall(12, this.p, Int32, waitSeconds, VARIANT_BOOL.Ptr, completed)
    GetById(id, entry)
      => ComCall(13, this.p, GUID, id, VARIANT.Ptr, entry)
}
struct IFsrmMutableCollection extends IFsrmCollection {
    static IID := "{1BB617B8-3886-49DC-AF82-A6C90FA35DDA}"
    Add(item)
      => ComCall(14, this.p, VARIANT, item)
    Remove(index)
      => ComCall(15, this.p, Int32, index)
    RemoveById(id)
      => ComCall(16, this.p, GUID, id)
    Clone(collection)
      => ComCall(17, this.p, IFsrmMutableCollection.Ptr, collection)
}
struct IFsrmCommittableCollection extends IFsrmMutableCollection {
    static IID := "{96DEB3B5-8B91-4A2A-9D93-80A35D8AA847}"
    Commit(options, results)
      => ComCall(18, this.p, FsrmCommitOptions, options, IFsrmCollection.Ptr, results)
}
struct IFsrmAction extends IDispatch {
    static IID := "{6CD6408A-AE60-463B-9EF1-E117534D69DC}"
    get_Id(id)
      => ComCall(7, this.p, GUID.Ptr, id)
    get_ActionType(actionType)
      => ComCall(8, this.p, FsrmActionType.Ptr, actionType)
    get_RunLimitInterval(minutes)
      => ComCall(9, this.p, Int32.Ptr, minutes)
    put_RunLimitInterval(minutes)
      => ComCall(10, this.p, Int32, minutes)
    Delete()
      => ComCall(11, this.p)
}
struct IFsrmActionEmail extends IFsrmAction {
    static IID := "{D646567D-26AE-4CAA-9F84-4E0AAD207FCA}"
    get_MailFrom(mailFrom)
      => ComCall(12, this.p, BSTR.Ptr, mailFrom)
    put_MailFrom(mailFrom)
      => ComCall(13, this.p, BSTR, mailFrom)
    get_MailReplyTo(mailReplyTo)
      => ComCall(14, this.p, BSTR.Ptr, mailReplyTo)
    put_MailReplyTo(mailReplyTo)
      => ComCall(15, this.p, BSTR, mailReplyTo)
    get_MailTo(mailTo)
      => ComCall(16, this.p, BSTR.Ptr, mailTo)
    put_MailTo(mailTo)
      => ComCall(17, this.p, BSTR, mailTo)
    get_MailCc(mailCc)
      => ComCall(18, this.p, BSTR.Ptr, mailCc)
    put_MailCc(mailCc)
      => ComCall(19, this.p, BSTR, mailCc)
    get_MailBcc(mailBcc)
      => ComCall(20, this.p, BSTR.Ptr, mailBcc)
    put_MailBcc(mailBcc)
      => ComCall(21, this.p, BSTR, mailBcc)
    get_MailSubject(mailSubject)
      => ComCall(22, this.p, BSTR.Ptr, mailSubject)
    put_MailSubject(mailSubject)
      => ComCall(23, this.p, BSTR, mailSubject)
    get_MessageText(messageText)
      => ComCall(24, this.p, BSTR.Ptr, messageText)
    put_MessageText(messageText)
      => ComCall(25, this.p, BSTR, messageText)
}
struct IFsrmActionEmail2 extends IFsrmActionEmail {
    static IID := "{8276702F-2532-4839-89BF-4872609A2EA4}"
    get_AttachmentFileListSize(attachmentFileListSize)
      => ComCall(26, this.p, Int32.Ptr, attachmentFileListSize)
    put_AttachmentFileListSize(attachmentFileListSize)
      => ComCall(27, this.p, Int32, attachmentFileListSize)
}
struct IFsrmActionReport extends IFsrmAction {
    static IID := "{2DBE63C4-B340-48A0-A5B0-158E07FC567E}"
    get_ReportTypes(reportTypes)
      => ComCall(12, this.p, SAFEARRAY.Ptr.Ptr, reportTypes)
    put_ReportTypes(reportTypes)
      => ComCall(13, this.p, SAFEARRAY.Ptr, reportTypes)
    get_MailTo(mailTo)
      => ComCall(14, this.p, BSTR.Ptr, mailTo)
    put_MailTo(mailTo)
      => ComCall(15, this.p, BSTR, mailTo)
}
struct IFsrmActionEventLog extends IFsrmAction {
    static IID := "{4C8F96C3-5D94-4F37-A4F4-F56AB463546F}"
    get_EventType(eventType)
      => ComCall(12, this.p, FsrmEventType.Ptr, eventType)
    put_EventType(eventType)
      => ComCall(13, this.p, FsrmEventType, eventType)
    get_MessageText(messageText)
      => ComCall(14, this.p, BSTR.Ptr, messageText)
    put_MessageText(messageText)
      => ComCall(15, this.p, BSTR, messageText)
}
struct IFsrmActionCommand extends IFsrmAction {
    static IID := "{12937789-E247-4917-9C20-F3EE9C7EE783}"
    get_ExecutablePath(executablePath)
      => ComCall(12, this.p, BSTR.Ptr, executablePath)
    put_ExecutablePath(executablePath)
      => ComCall(13, this.p, BSTR, executablePath)
    get_Arguments(arguments)
      => ComCall(14, this.p, BSTR.Ptr, arguments)
    put_Arguments(arguments)
      => ComCall(15, this.p, BSTR, arguments)
    get_Account(account)
      => ComCall(16, this.p, FsrmAccountType.Ptr, account)
    put_Account(account)
      => ComCall(17, this.p, FsrmAccountType, account)
    get_WorkingDirectory(workingDirectory)
      => ComCall(18, this.p, BSTR.Ptr, workingDirectory)
    put_WorkingDirectory(workingDirectory)
      => ComCall(19, this.p, BSTR, workingDirectory)
    get_MonitorCommand(monitorCommand)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, monitorCommand)
    put_MonitorCommand(monitorCommand)
      => ComCall(21, this.p, VARIANT_BOOL, monitorCommand)
    get_KillTimeOut(minutes)
      => ComCall(22, this.p, Int32.Ptr, minutes)
    put_KillTimeOut(minutes)
      => ComCall(23, this.p, Int32, minutes)
    get_LogResult(logResults)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, logResults)
    put_LogResult(logResults)
      => ComCall(25, this.p, VARIANT_BOOL, logResults)
}
struct IFsrmSetting extends IDispatch {
    static IID := "{F411D4FD-14BE-4260-8C40-03B7C95E608A}"
    get_SmtpServer(smtpServer)
      => ComCall(7, this.p, BSTR.Ptr, smtpServer)
    put_SmtpServer(smtpServer)
      => ComCall(8, this.p, BSTR, smtpServer)
    get_MailFrom(mailFrom)
      => ComCall(9, this.p, BSTR.Ptr, mailFrom)
    put_MailFrom(mailFrom)
      => ComCall(10, this.p, BSTR, mailFrom)
    get_AdminEmail(adminEmail)
      => ComCall(11, this.p, BSTR.Ptr, adminEmail)
    put_AdminEmail(adminEmail)
      => ComCall(12, this.p, BSTR, adminEmail)
    get_DisableCommandLine(disableCommandLine)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, disableCommandLine)
    put_DisableCommandLine(disableCommandLine)
      => ComCall(14, this.p, VARIANT_BOOL, disableCommandLine)
    get_EnableScreeningAudit(enableScreeningAudit)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, enableScreeningAudit)
    put_EnableScreeningAudit(enableScreeningAudit)
      => ComCall(16, this.p, VARIANT_BOOL, enableScreeningAudit)
    EmailTest(mailTo)
      => ComCall(17, this.p, BSTR, mailTo)
    SetActionRunLimitInterval(actionType, delayTimeMinutes)
      => ComCall(18, this.p, FsrmActionType, actionType, Int32, delayTimeMinutes)
    GetActionRunLimitInterval(actionType, delayTimeMinutes)
      => ComCall(19, this.p, FsrmActionType, actionType, Int32.Ptr, delayTimeMinutes)
}
struct IFsrmPathMapper extends IDispatch {
    static IID := "{6F4DBFFF-6920-4821-A6C3-B7E94C1FD60C}"
    GetSharePathsForLocalPath(localPath, sharePaths)
      => ComCall(7, this.p, BSTR, localPath, SAFEARRAY.Ptr.Ptr, sharePaths)
}
struct IFsrmExportImport extends IDispatch {
    static IID := "{EFCB0AB1-16C4-4A79-812C-725614C3306B}"
    ExportFileGroups(filePath, fileGroupNamesSafeArray, remoteHost)
      => ComCall(7, this.p, BSTR, filePath, VARIANT.Ptr, fileGroupNamesSafeArray, BSTR, remoteHost)
    ImportFileGroups(filePath, fileGroupNamesSafeArray, remoteHost, fileGroups)
      => ComCall(8, this.p, BSTR, filePath, VARIANT.Ptr, fileGroupNamesSafeArray, BSTR, remoteHost, IFsrmCommittableCollection.Ptr, fileGroups)
    ExportFileScreenTemplates(filePath, templateNamesSafeArray, remoteHost)
      => ComCall(9, this.p, BSTR, filePath, VARIANT.Ptr, templateNamesSafeArray, BSTR, remoteHost)
    ImportFileScreenTemplates(filePath, templateNamesSafeArray, remoteHost, templates)
      => ComCall(10, this.p, BSTR, filePath, VARIANT.Ptr, templateNamesSafeArray, BSTR, remoteHost, IFsrmCommittableCollection.Ptr, templates)
    ExportQuotaTemplates(filePath, templateNamesSafeArray, remoteHost)
      => ComCall(11, this.p, BSTR, filePath, VARIANT.Ptr, templateNamesSafeArray, BSTR, remoteHost)
    ImportQuotaTemplates(filePath, templateNamesSafeArray, remoteHost, templates)
      => ComCall(12, this.p, BSTR, filePath, VARIANT.Ptr, templateNamesSafeArray, BSTR, remoteHost, IFsrmCommittableCollection.Ptr, templates)
}
struct IFsrmDerivedObjectsResult extends IDispatch {
    static IID := "{39322A2D-38EE-4D0D-8095-421A80849A82}"
    get_DerivedObjects(derivedObjects)
      => ComCall(7, this.p, IFsrmCollection.Ptr, derivedObjects)
    get_Results(results)
      => ComCall(8, this.p, IFsrmCollection.Ptr, results)
}
struct IFsrmAccessDeniedRemediationClient extends IDispatch {
    static IID := "{40002314-590B-45A5-8E1B-8C05DA527E52}"
    Show(parentWnd, accessPath, errorType, flags, windowTitle, windowMessage, result)
      => ComCall(7, this.p, IntPtr, parentWnd, BSTR, accessPath, AdrClientErrorType, errorType, Int32, flags, BSTR, windowTitle, BSTR, windowMessage, Int32.Ptr, result)
}
struct IFsrmQuotaBase extends IFsrmObject {
    static IID := "{1568A795-3924-4118-B74B-68D8F0FA5DAF}"
    get_QuotaLimit(quotaLimit)
      => ComCall(12, this.p, VARIANT.Ptr, quotaLimit)
    put_QuotaLimit(quotaLimit)
      => ComCall(13, this.p, VARIANT, quotaLimit)
    get_QuotaFlags(quotaFlags)
      => ComCall(14, this.p, Int32.Ptr, quotaFlags)
    put_QuotaFlags(quotaFlags)
      => ComCall(15, this.p, Int32, quotaFlags)
    get_Thresholds(thresholds)
      => ComCall(16, this.p, SAFEARRAY.Ptr.Ptr, thresholds)
    AddThreshold(threshold)
      => ComCall(17, this.p, Int32, threshold)
    DeleteThreshold(threshold)
      => ComCall(18, this.p, Int32, threshold)
    ModifyThreshold(threshold, newThreshold)
      => ComCall(19, this.p, Int32, threshold, Int32, newThreshold)
    CreateThresholdAction(threshold, actionType, action)
      => ComCall(20, this.p, Int32, threshold, FsrmActionType, actionType, IFsrmAction.Ptr, action)
    EnumThresholdActions(threshold, actions)
      => ComCall(21, this.p, Int32, threshold, IFsrmCollection.Ptr, actions)
}
struct IFsrmQuotaObject extends IFsrmQuotaBase {
    static IID := "{42DC3511-61D5-48AE-B6DC-59FC00C0A8D6}"
    get_Path(path)
      => ComCall(22, this.p, BSTR.Ptr, path)
    get_UserSid(userSid)
      => ComCall(23, this.p, BSTR.Ptr, userSid)
    get_UserAccount(userAccount)
      => ComCall(24, this.p, BSTR.Ptr, userAccount)
    get_SourceTemplateName(quotaTemplateName)
      => ComCall(25, this.p, BSTR.Ptr, quotaTemplateName)
    get_MatchesSourceTemplate(matches)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, matches)
    ApplyTemplate(quotaTemplateName)
      => ComCall(27, this.p, BSTR, quotaTemplateName)
}
struct IFsrmQuota extends IFsrmQuotaObject {
    static IID := "{377F739D-9647-4B8E-97D2-5FFCE6D759CD}"
    get_QuotaUsed(used)
      => ComCall(28, this.p, VARIANT.Ptr, used)
    get_QuotaPeakUsage(peakUsage)
      => ComCall(29, this.p, VARIANT.Ptr, peakUsage)
    get_QuotaPeakUsageTime(peakUsageDateTime)
      => ComCall(30, this.p, Float64.Ptr, peakUsageDateTime)
    ResetPeakUsage()
      => ComCall(31, this.p)
    RefreshUsageProperties()
      => ComCall(32, this.p)
}
struct IFsrmAutoApplyQuota extends IFsrmQuotaObject {
    static IID := "{F82E5729-6ABA-4740-BFC7-C7F58F75FB7B}"
    get_ExcludeFolders(folders)
      => ComCall(28, this.p, SAFEARRAY.Ptr.Ptr, folders)
    put_ExcludeFolders(folders)
      => ComCall(29, this.p, SAFEARRAY.Ptr, folders)
    CommitAndUpdateDerived(commitOptions, applyOptions, derivedObjectsResult)
      => ComCall(30, this.p, FsrmCommitOptions, commitOptions, FsrmTemplateApplyOptions, applyOptions, IFsrmDerivedObjectsResult.Ptr, derivedObjectsResult)
}
struct IFsrmQuotaManager extends IDispatch {
    static IID := "{8BB68C7D-19D8-4FFB-809E-BE4FC1734014}"
    get_ActionVariables(variables)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, variables)
    get_ActionVariableDescriptions(descriptions)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, descriptions)
    CreateQuota(path, quota)
      => ComCall(9, this.p, BSTR, path, IFsrmQuota.Ptr, quota)
    CreateAutoApplyQuota(quotaTemplateName, path, quota)
      => ComCall(10, this.p, BSTR, quotaTemplateName, BSTR, path, IFsrmAutoApplyQuota.Ptr, quota)
    GetQuota(path, quota)
      => ComCall(11, this.p, BSTR, path, IFsrmQuota.Ptr, quota)
    GetAutoApplyQuota(path, quota)
      => ComCall(12, this.p, BSTR, path, IFsrmAutoApplyQuota.Ptr, quota)
    GetRestrictiveQuota(path, quota)
      => ComCall(13, this.p, BSTR, path, IFsrmQuota.Ptr, quota)
    EnumQuotas(path, options, quotas)
      => ComCall(14, this.p, BSTR, path, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, quotas)
    EnumAutoApplyQuotas(path, options, quotas)
      => ComCall(15, this.p, BSTR, path, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, quotas)
    EnumEffectiveQuotas(path, options, quotas)
      => ComCall(16, this.p, BSTR, path, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, quotas)
    Scan(strPath)
      => ComCall(17, this.p, BSTR, strPath)
    CreateQuotaCollection(collection)
      => ComCall(18, this.p, IFsrmCommittableCollection.Ptr, collection)
}
struct IFsrmQuotaManagerEx extends IFsrmQuotaManager {
    static IID := "{4846CB01-D430-494F-ABB4-B1054999FB09}"
    IsAffectedByQuota(path, options, affected)
      => ComCall(19, this.p, BSTR, path, FsrmEnumOptions, options, VARIANT_BOOL.Ptr, affected)
}
struct IFsrmQuotaTemplate extends IFsrmQuotaBase {
    static IID := "{A2EFAB31-295E-46BB-B976-E86D58B52E8B}"
    get_Name(name)
      => ComCall(22, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(23, this.p, BSTR, name)
    CopyTemplate(quotaTemplateName)
      => ComCall(24, this.p, BSTR, quotaTemplateName)
    CommitAndUpdateDerived(commitOptions, applyOptions, derivedObjectsResult)
      => ComCall(25, this.p, FsrmCommitOptions, commitOptions, FsrmTemplateApplyOptions, applyOptions, IFsrmDerivedObjectsResult.Ptr, derivedObjectsResult)
}
struct IFsrmQuotaTemplateImported extends IFsrmQuotaTemplate {
    static IID := "{9A2BF113-A329-44CC-809A-5C00FCE8DA40}"
    get_OverwriteOnCommit(overwrite)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, overwrite)
    put_OverwriteOnCommit(overwrite)
      => ComCall(27, this.p, VARIANT_BOOL, overwrite)
}
struct IFsrmQuotaTemplateManager extends IDispatch {
    static IID := "{4173AC41-172D-4D52-963C-FDC7E415F717}"
    CreateTemplate(quotaTemplate)
      => ComCall(7, this.p, IFsrmQuotaTemplate.Ptr, quotaTemplate)
    GetTemplate(name, quotaTemplate)
      => ComCall(8, this.p, BSTR, name, IFsrmQuotaTemplate.Ptr, quotaTemplate)
    EnumTemplates(options, quotaTemplates)
      => ComCall(9, this.p, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, quotaTemplates)
    ExportTemplates(quotaTemplateNamesArray, serializedQuotaTemplates)
      => ComCall(10, this.p, VARIANT.Ptr, quotaTemplateNamesArray, BSTR.Ptr, serializedQuotaTemplates)
    ImportTemplates(serializedQuotaTemplates, quotaTemplateNamesArray, quotaTemplates)
      => ComCall(11, this.p, BSTR, serializedQuotaTemplates, VARIANT.Ptr, quotaTemplateNamesArray, IFsrmCommittableCollection.Ptr, quotaTemplates)
}
struct IFsrmFileGroup extends IFsrmObject {
    static IID := "{8DD04909-0E34-4D55-AFAA-89E1F1A1BBB9}"
    get_Name(name)
      => ComCall(12, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(13, this.p, BSTR, name)
    get_Members(members)
      => ComCall(14, this.p, IFsrmMutableCollection.Ptr, members)
    put_Members(members)
      => ComCall(15, this.p, IFsrmMutableCollection, members)
    get_NonMembers(nonMembers)
      => ComCall(16, this.p, IFsrmMutableCollection.Ptr, nonMembers)
    put_NonMembers(nonMembers)
      => ComCall(17, this.p, IFsrmMutableCollection, nonMembers)
}
struct IFsrmFileGroupImported extends IFsrmFileGroup {
    static IID := "{AD55F10B-5F11-4BE7-94EF-D9EE2E470DED}"
    get_OverwriteOnCommit(overwrite)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, overwrite)
    put_OverwriteOnCommit(overwrite)
      => ComCall(19, this.p, VARIANT_BOOL, overwrite)
}
struct IFsrmFileGroupManager extends IDispatch {
    static IID := "{426677D5-018C-485C-8A51-20B86D00BDC4}"
    CreateFileGroup(fileGroup)
      => ComCall(7, this.p, IFsrmFileGroup.Ptr, fileGroup)
    GetFileGroup(name, fileGroup)
      => ComCall(8, this.p, BSTR, name, IFsrmFileGroup.Ptr, fileGroup)
    EnumFileGroups(options, fileGroups)
      => ComCall(9, this.p, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, fileGroups)
    ExportFileGroups(fileGroupNamesArray, serializedFileGroups)
      => ComCall(10, this.p, VARIANT.Ptr, fileGroupNamesArray, BSTR.Ptr, serializedFileGroups)
    ImportFileGroups(serializedFileGroups, fileGroupNamesArray, fileGroups)
      => ComCall(11, this.p, BSTR, serializedFileGroups, VARIANT.Ptr, fileGroupNamesArray, IFsrmCommittableCollection.Ptr, fileGroups)
}
struct IFsrmFileScreenBase extends IFsrmObject {
    static IID := "{F3637E80-5B22-4A2B-A637-BBB642B41CFC}"
    get_BlockedFileGroups(blockList)
      => ComCall(12, this.p, IFsrmMutableCollection.Ptr, blockList)
    put_BlockedFileGroups(blockList)
      => ComCall(13, this.p, IFsrmMutableCollection, blockList)
    get_FileScreenFlags(fileScreenFlags)
      => ComCall(14, this.p, Int32.Ptr, fileScreenFlags)
    put_FileScreenFlags(fileScreenFlags)
      => ComCall(15, this.p, Int32, fileScreenFlags)
    CreateAction(actionType, action)
      => ComCall(16, this.p, FsrmActionType, actionType, IFsrmAction.Ptr, action)
    EnumActions(actions)
      => ComCall(17, this.p, IFsrmCollection.Ptr, actions)
}
struct IFsrmFileScreen extends IFsrmFileScreenBase {
    static IID := "{5F6325D3-CE88-4733-84C1-2D6AEFC5EA07}"
    get_Path(path)
      => ComCall(18, this.p, BSTR.Ptr, path)
    get_SourceTemplateName(fileScreenTemplateName)
      => ComCall(19, this.p, BSTR.Ptr, fileScreenTemplateName)
    get_MatchesSourceTemplate(matches)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, matches)
    get_UserSid(userSid)
      => ComCall(21, this.p, BSTR.Ptr, userSid)
    get_UserAccount(userAccount)
      => ComCall(22, this.p, BSTR.Ptr, userAccount)
    ApplyTemplate(fileScreenTemplateName)
      => ComCall(23, this.p, BSTR, fileScreenTemplateName)
}
struct IFsrmFileScreenException extends IFsrmObject {
    static IID := "{BEE7CE02-DF77-4515-9389-78F01C5AFC1A}"
    get_Path(path)
      => ComCall(12, this.p, BSTR.Ptr, path)
    get_AllowedFileGroups(allowList)
      => ComCall(13, this.p, IFsrmMutableCollection.Ptr, allowList)
    put_AllowedFileGroups(allowList)
      => ComCall(14, this.p, IFsrmMutableCollection, allowList)
}
struct IFsrmFileScreenManager extends IDispatch {
    static IID := "{FF4FA04E-5A94-4BDA-A3A0-D5B4D3C52EBA}"
    get_ActionVariables(variables)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, variables)
    get_ActionVariableDescriptions(descriptions)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, descriptions)
    CreateFileScreen(path, fileScreen)
      => ComCall(9, this.p, BSTR, path, IFsrmFileScreen.Ptr, fileScreen)
    GetFileScreen(path, fileScreen)
      => ComCall(10, this.p, BSTR, path, IFsrmFileScreen.Ptr, fileScreen)
    EnumFileScreens(path, options, fileScreens)
      => ComCall(11, this.p, BSTR, path, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, fileScreens)
    CreateFileScreenException(path, fileScreenException)
      => ComCall(12, this.p, BSTR, path, IFsrmFileScreenException.Ptr, fileScreenException)
    GetFileScreenException(path, fileScreenException)
      => ComCall(13, this.p, BSTR, path, IFsrmFileScreenException.Ptr, fileScreenException)
    EnumFileScreenExceptions(path, options, fileScreenExceptions)
      => ComCall(14, this.p, BSTR, path, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, fileScreenExceptions)
    CreateFileScreenCollection(collection)
      => ComCall(15, this.p, IFsrmCommittableCollection.Ptr, collection)
}
struct IFsrmFileScreenTemplate extends IFsrmFileScreenBase {
    static IID := "{205BEBF8-DD93-452A-95A6-32B566B35828}"
    get_Name(name)
      => ComCall(18, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(19, this.p, BSTR, name)
    CopyTemplate(fileScreenTemplateName)
      => ComCall(20, this.p, BSTR, fileScreenTemplateName)
    CommitAndUpdateDerived(commitOptions, applyOptions, derivedObjectsResult)
      => ComCall(21, this.p, FsrmCommitOptions, commitOptions, FsrmTemplateApplyOptions, applyOptions, IFsrmDerivedObjectsResult.Ptr, derivedObjectsResult)
}
struct IFsrmFileScreenTemplateImported extends IFsrmFileScreenTemplate {
    static IID := "{E1010359-3E5D-4ECD-9FE4-EF48622FDF30}"
    get_OverwriteOnCommit(overwrite)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, overwrite)
    put_OverwriteOnCommit(overwrite)
      => ComCall(23, this.p, VARIANT_BOOL, overwrite)
}
struct IFsrmFileScreenTemplateManager extends IDispatch {
    static IID := "{CFE36CBA-1949-4E74-A14F-F1D580CEAF13}"
    CreateTemplate(fileScreenTemplate)
      => ComCall(7, this.p, IFsrmFileScreenTemplate.Ptr, fileScreenTemplate)
    GetTemplate(name, fileScreenTemplate)
      => ComCall(8, this.p, BSTR, name, IFsrmFileScreenTemplate.Ptr, fileScreenTemplate)
    EnumTemplates(options, fileScreenTemplates)
      => ComCall(9, this.p, FsrmEnumOptions, options, IFsrmCommittableCollection.Ptr, fileScreenTemplates)
    ExportTemplates(fileScreenTemplateNamesArray, serializedFileScreenTemplates)
      => ComCall(10, this.p, VARIANT.Ptr, fileScreenTemplateNamesArray, BSTR.Ptr, serializedFileScreenTemplates)
    ImportTemplates(serializedFileScreenTemplates, fileScreenTemplateNamesArray, fileScreenTemplates)
      => ComCall(11, this.p, BSTR, serializedFileScreenTemplates, VARIANT.Ptr, fileScreenTemplateNamesArray, IFsrmCommittableCollection.Ptr, fileScreenTemplates)
}
struct IFsrmReportManager extends IDispatch {
    static IID := "{27B899FE-6FFA-4481-A184-D3DAADE8A02B}"
    EnumReportJobs(options, reportJobs)
      => ComCall(7, this.p, FsrmEnumOptions, options, IFsrmCollection.Ptr, reportJobs)
    CreateReportJob(reportJob)
      => ComCall(8, this.p, IFsrmReportJob.Ptr, reportJob)
    GetReportJob(taskName, reportJob)
      => ComCall(9, this.p, BSTR, taskName, IFsrmReportJob.Ptr, reportJob)
    GetOutputDirectory(context, path)
      => ComCall(10, this.p, FsrmReportGenerationContext, context, BSTR.Ptr, path)
    SetOutputDirectory(context, path)
      => ComCall(11, this.p, FsrmReportGenerationContext, context, BSTR, path)
    IsFilterValidForReportType(reportType, filter, valid)
      => ComCall(12, this.p, FsrmReportType, reportType, FsrmReportFilter, filter, VARIANT_BOOL.Ptr, valid)
    GetDefaultFilter(reportType, filter, filterValue)
      => ComCall(13, this.p, FsrmReportType, reportType, FsrmReportFilter, filter, VARIANT.Ptr, filterValue)
    SetDefaultFilter(reportType, filter, filterValue)
      => ComCall(14, this.p, FsrmReportType, reportType, FsrmReportFilter, filter, VARIANT, filterValue)
    GetReportSizeLimit(limit, limitValue)
      => ComCall(15, this.p, FsrmReportLimit, limit, VARIANT.Ptr, limitValue)
    SetReportSizeLimit(limit, limitValue)
      => ComCall(16, this.p, FsrmReportLimit, limit, VARIANT, limitValue)
}
struct IFsrmReportJob extends IFsrmObject {
    static IID := "{38E87280-715C-4C7D-A280-EA1651A19FEF}"
    get_Task(taskName)
      => ComCall(12, this.p, BSTR.Ptr, taskName)
    put_Task(taskName)
      => ComCall(13, this.p, BSTR, taskName)
    get_NamespaceRoots(namespaceRoots)
      => ComCall(14, this.p, SAFEARRAY.Ptr.Ptr, namespaceRoots)
    put_NamespaceRoots(namespaceRoots)
      => ComCall(15, this.p, SAFEARRAY.Ptr, namespaceRoots)
    get_Formats(formats)
      => ComCall(16, this.p, SAFEARRAY.Ptr.Ptr, formats)
    put_Formats(formats)
      => ComCall(17, this.p, SAFEARRAY.Ptr, formats)
    get_MailTo(mailTo)
      => ComCall(18, this.p, BSTR.Ptr, mailTo)
    put_MailTo(mailTo)
      => ComCall(19, this.p, BSTR, mailTo)
    get_RunningStatus(runningStatus)
      => ComCall(20, this.p, FsrmReportRunningStatus.Ptr, runningStatus)
    get_LastRun(lastRun)
      => ComCall(21, this.p, Float64.Ptr, lastRun)
    get_LastError(lastError)
      => ComCall(22, this.p, BSTR.Ptr, lastError)
    get_LastGeneratedInDirectory(path)
      => ComCall(23, this.p, BSTR.Ptr, path)
    EnumReports(reports)
      => ComCall(24, this.p, IFsrmCollection.Ptr, reports)
    CreateReport(reportType, report)
      => ComCall(25, this.p, FsrmReportType, reportType, IFsrmReport.Ptr, report)
    Run(context)
      => ComCall(26, this.p, FsrmReportGenerationContext, context)
    WaitForCompletion(waitSeconds, completed)
      => ComCall(27, this.p, Int32, waitSeconds, VARIANT_BOOL.Ptr, completed)
    Cancel()
      => ComCall(28, this.p)
}
struct IFsrmReport extends IDispatch {
    static IID := "{D8CC81D9-46B8-4FA4-BFA5-4AA9DEC9B638}"
    get_Type(reportType)
      => ComCall(7, this.p, FsrmReportType.Ptr, reportType)
    get_Name(name)
      => ComCall(8, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(9, this.p, BSTR, name)
    get_Description(description)
      => ComCall(10, this.p, BSTR.Ptr, description)
    put_Description(description)
      => ComCall(11, this.p, BSTR, description)
    get_LastGeneratedFileNamePrefix(prefix)
      => ComCall(12, this.p, BSTR.Ptr, prefix)
    GetFilter(filter, filterValue)
      => ComCall(13, this.p, FsrmReportFilter, filter, VARIANT.Ptr, filterValue)
    SetFilter(filter, filterValue)
      => ComCall(14, this.p, FsrmReportFilter, filter, VARIANT, filterValue)
    Delete()
      => ComCall(15, this.p)
}
struct IFsrmReportScheduler extends IDispatch {
    static IID := "{6879CAF9-6617-4484-8719-71C3D8645F94}"
    VerifyNamespaces(namespacesSafeArray)
      => ComCall(7, this.p, VARIANT.Ptr, namespacesSafeArray)
    CreateScheduleTask(taskName, namespacesSafeArray, serializedTask)
      => ComCall(8, this.p, BSTR, taskName, VARIANT.Ptr, namespacesSafeArray, BSTR, serializedTask)
    ModifyScheduleTask(taskName, namespacesSafeArray, serializedTask)
      => ComCall(9, this.p, BSTR, taskName, VARIANT.Ptr, namespacesSafeArray, BSTR, serializedTask)
    DeleteScheduleTask(taskName)
      => ComCall(10, this.p, BSTR, taskName)
}
struct IFsrmFileManagementJobManager extends IDispatch {
    static IID := "{EE321ECB-D95E-48E9-907C-C7685A013235}"
    get_ActionVariables(variables)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, variables)
    get_ActionVariableDescriptions(descriptions)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, descriptions)
    EnumFileManagementJobs(options, fileManagementJobs)
      => ComCall(9, this.p, FsrmEnumOptions, options, IFsrmCollection.Ptr, fileManagementJobs)
    CreateFileManagementJob(fileManagementJob)
      => ComCall(10, this.p, IFsrmFileManagementJob.Ptr, fileManagementJob)
    GetFileManagementJob(name, fileManagementJob)
      => ComCall(11, this.p, BSTR, name, IFsrmFileManagementJob.Ptr, fileManagementJob)
}
struct IFsrmFileManagementJob extends IFsrmObject {
    static IID := "{0770687E-9F36-4D6F-8778-599D188461C9}"
    get_Name(name)
      => ComCall(12, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(13, this.p, BSTR, name)
    get_NamespaceRoots(namespaceRoots)
      => ComCall(14, this.p, SAFEARRAY.Ptr.Ptr, namespaceRoots)
    put_NamespaceRoots(namespaceRoots)
      => ComCall(15, this.p, SAFEARRAY.Ptr, namespaceRoots)
    get_Enabled(enabled)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(17, this.p, VARIANT_BOOL, enabled)
    get_OperationType(operationType)
      => ComCall(18, this.p, FsrmFileManagementType.Ptr, operationType)
    put_OperationType(operationType)
      => ComCall(19, this.p, FsrmFileManagementType, operationType)
    get_ExpirationDirectory(expirationDirectory)
      => ComCall(20, this.p, BSTR.Ptr, expirationDirectory)
    put_ExpirationDirectory(expirationDirectory)
      => ComCall(21, this.p, BSTR, expirationDirectory)
    get_CustomAction(action)
      => ComCall(22, this.p, IFsrmActionCommand.Ptr, action)
    get_Notifications(notifications)
      => ComCall(23, this.p, SAFEARRAY.Ptr.Ptr, notifications)
    get_Logging(loggingFlags)
      => ComCall(24, this.p, Int32.Ptr, loggingFlags)
    put_Logging(loggingFlags)
      => ComCall(25, this.p, Int32, loggingFlags)
    get_ReportEnabled(reportEnabled)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, reportEnabled)
    put_ReportEnabled(reportEnabled)
      => ComCall(27, this.p, VARIANT_BOOL, reportEnabled)
    get_Formats(formats)
      => ComCall(28, this.p, SAFEARRAY.Ptr.Ptr, formats)
    put_Formats(formats)
      => ComCall(29, this.p, SAFEARRAY.Ptr, formats)
    get_MailTo(mailTo)
      => ComCall(30, this.p, BSTR.Ptr, mailTo)
    put_MailTo(mailTo)
      => ComCall(31, this.p, BSTR, mailTo)
    get_DaysSinceFileCreated(daysSinceCreation)
      => ComCall(32, this.p, Int32.Ptr, daysSinceCreation)
    put_DaysSinceFileCreated(daysSinceCreation)
      => ComCall(33, this.p, Int32, daysSinceCreation)
    get_DaysSinceFileLastAccessed(daysSinceAccess)
      => ComCall(34, this.p, Int32.Ptr, daysSinceAccess)
    put_DaysSinceFileLastAccessed(daysSinceAccess)
      => ComCall(35, this.p, Int32, daysSinceAccess)
    get_DaysSinceFileLastModified(daysSinceModify)
      => ComCall(36, this.p, Int32.Ptr, daysSinceModify)
    put_DaysSinceFileLastModified(daysSinceModify)
      => ComCall(37, this.p, Int32, daysSinceModify)
    get_PropertyConditions(propertyConditions)
      => ComCall(38, this.p, IFsrmCollection.Ptr, propertyConditions)
    get_FromDate(fromDate)
      => ComCall(39, this.p, Float64.Ptr, fromDate)
    put_FromDate(fromDate)
      => ComCall(40, this.p, Float64, fromDate)
    get_Task(taskName)
      => ComCall(41, this.p, BSTR.Ptr, taskName)
    put_Task(taskName)
      => ComCall(42, this.p, BSTR, taskName)
    get_Parameters(parameters)
      => ComCall(43, this.p, SAFEARRAY.Ptr.Ptr, parameters)
    put_Parameters(parameters)
      => ComCall(44, this.p, SAFEARRAY.Ptr, parameters)
    get_RunningStatus(runningStatus)
      => ComCall(45, this.p, FsrmReportRunningStatus.Ptr, runningStatus)
    get_LastError(lastError)
      => ComCall(46, this.p, BSTR.Ptr, lastError)
    get_LastReportPathWithoutExtension(path)
      => ComCall(47, this.p, BSTR.Ptr, path)
    get_LastRun(lastRun)
      => ComCall(48, this.p, Float64.Ptr, lastRun)
    get_FileNamePattern(fileNamePattern)
      => ComCall(49, this.p, BSTR.Ptr, fileNamePattern)
    put_FileNamePattern(fileNamePattern)
      => ComCall(50, this.p, BSTR, fileNamePattern)
    Run(context)
      => ComCall(51, this.p, FsrmReportGenerationContext, context)
    WaitForCompletion(waitSeconds, completed)
      => ComCall(52, this.p, Int32, waitSeconds, VARIANT_BOOL.Ptr, completed)
    Cancel()
      => ComCall(53, this.p)
    AddNotification(days)
      => ComCall(54, this.p, Int32, days)
    DeleteNotification(days)
      => ComCall(55, this.p, Int32, days)
    ModifyNotification(days, newDays)
      => ComCall(56, this.p, Int32, days, Int32, newDays)
    CreateNotificationAction(days, actionType, action)
      => ComCall(57, this.p, Int32, days, FsrmActionType, actionType, IFsrmAction.Ptr, action)
    EnumNotificationActions(days, actions)
      => ComCall(58, this.p, Int32, days, IFsrmCollection.Ptr, actions)
    CreatePropertyCondition(name, propertyCondition)
      => ComCall(59, this.p, BSTR, name, IFsrmPropertyCondition.Ptr, propertyCondition)
    CreateCustomAction(customAction)
      => ComCall(60, this.p, IFsrmActionCommand.Ptr, customAction)
}
struct IFsrmPropertyCondition extends IDispatch {
    static IID := "{326AF66F-2AC0-4F68-BF8C-4759F054FA29}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_Type(type)
      => ComCall(9, this.p, FsrmPropertyConditionType.Ptr, type)
    put_Type(type)
      => ComCall(10, this.p, FsrmPropertyConditionType, type)
    get_Value(value)
      => ComCall(11, this.p, BSTR.Ptr, value)
    put_Value(value)
      => ComCall(12, this.p, BSTR, value)
    Delete()
      => ComCall(13, this.p)
}
struct IFsrmFileCondition extends IDispatch {
    static IID := "{70684FFC-691A-4A1A-B922-97752E138CC1}"
    get_Type(pVal)
      => ComCall(7, this.p, FsrmFileConditionType.Ptr, pVal)
    Delete()
      => ComCall(8, this.p)
}
struct IFsrmFileConditionProperty extends IFsrmFileCondition {
    static IID := "{81926775-B981-4479-988F-DA171D627360}"
    get_PropertyName(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_PropertyName(newVal)
      => ComCall(10, this.p, BSTR, newVal)
    get_PropertyId(pVal)
      => ComCall(11, this.p, FsrmFileSystemPropertyId.Ptr, pVal)
    put_PropertyId(newVal)
      => ComCall(12, this.p, FsrmFileSystemPropertyId, newVal)
    get_Operator(pVal)
      => ComCall(13, this.p, FsrmPropertyConditionType.Ptr, pVal)
    put_Operator(newVal)
      => ComCall(14, this.p, FsrmPropertyConditionType, newVal)
    get_ValueType(pVal)
      => ComCall(15, this.p, FsrmPropertyValueType.Ptr, pVal)
    put_ValueType(newVal)
      => ComCall(16, this.p, FsrmPropertyValueType, newVal)
    get_Value(pVal)
      => ComCall(17, this.p, VARIANT.Ptr, pVal)
    put_Value(newVal)
      => ComCall(18, this.p, VARIANT, newVal)
}
struct IFsrmPropertyDefinition extends IFsrmObject {
    static IID := "{EDE0150F-E9A3-419C-877C-01FE5D24C5D3}"
    get_Name(name)
      => ComCall(12, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(13, this.p, BSTR, name)
    get_Type(type)
      => ComCall(14, this.p, FsrmPropertyDefinitionType.Ptr, type)
    put_Type(type)
      => ComCall(15, this.p, FsrmPropertyDefinitionType, type)
    get_PossibleValues(possibleValues)
      => ComCall(16, this.p, SAFEARRAY.Ptr.Ptr, possibleValues)
    put_PossibleValues(possibleValues)
      => ComCall(17, this.p, SAFEARRAY.Ptr, possibleValues)
    get_ValueDescriptions(valueDescriptions)
      => ComCall(18, this.p, SAFEARRAY.Ptr.Ptr, valueDescriptions)
    put_ValueDescriptions(valueDescriptions)
      => ComCall(19, this.p, SAFEARRAY.Ptr, valueDescriptions)
    get_Parameters(parameters)
      => ComCall(20, this.p, SAFEARRAY.Ptr.Ptr, parameters)
    put_Parameters(parameters)
      => ComCall(21, this.p, SAFEARRAY.Ptr, parameters)
}
struct IFsrmPropertyDefinition2 extends IFsrmPropertyDefinition {
    static IID := "{47782152-D16C-4229-B4E1-0DDFE308B9F6}"
    get_PropertyDefinitionFlags(propertyDefinitionFlags)
      => ComCall(22, this.p, Int32.Ptr, propertyDefinitionFlags)
    get_DisplayName(name)
      => ComCall(23, this.p, BSTR.Ptr, name)
    put_DisplayName(name)
      => ComCall(24, this.p, BSTR, name)
    get_AppliesTo(appliesTo)
      => ComCall(25, this.p, Int32.Ptr, appliesTo)
    get_ValueDefinitions(valueDefinitions)
      => ComCall(26, this.p, IFsrmCollection.Ptr, valueDefinitions)
}
struct IFsrmPropertyDefinitionValue extends IDispatch {
    static IID := "{E946D148-BD67-4178-8E22-1C44925ED710}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_DisplayName(displayName)
      => ComCall(8, this.p, BSTR.Ptr, displayName)
    get_Description(description)
      => ComCall(9, this.p, BSTR.Ptr, description)
    get_UniqueID(uniqueID)
      => ComCall(10, this.p, BSTR.Ptr, uniqueID)
}
struct IFsrmProperty extends IDispatch {
    static IID := "{4A73FEE4-4102-4FCC-9FFB-38614F9EE768}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_Value(value)
      => ComCall(8, this.p, BSTR.Ptr, value)
    get_Sources(sources)
      => ComCall(9, this.p, SAFEARRAY.Ptr.Ptr, sources)
    get_PropertyFlags(flags)
      => ComCall(10, this.p, Int32.Ptr, flags)
}
struct IFsrmRule extends IFsrmObject {
    static IID := "{CB0DF960-16F5-4495-9079-3F9360D831DF}"
    get_Name(name)
      => ComCall(12, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(13, this.p, BSTR, name)
    get_RuleType(ruleType)
      => ComCall(14, this.p, FsrmRuleType.Ptr, ruleType)
    get_ModuleDefinitionName(moduleDefinitionName)
      => ComCall(15, this.p, BSTR.Ptr, moduleDefinitionName)
    put_ModuleDefinitionName(moduleDefinitionName)
      => ComCall(16, this.p, BSTR, moduleDefinitionName)
    get_NamespaceRoots(namespaceRoots)
      => ComCall(17, this.p, SAFEARRAY.Ptr.Ptr, namespaceRoots)
    put_NamespaceRoots(namespaceRoots)
      => ComCall(18, this.p, SAFEARRAY.Ptr, namespaceRoots)
    get_RuleFlags(ruleFlags)
      => ComCall(19, this.p, Int32.Ptr, ruleFlags)
    put_RuleFlags(ruleFlags)
      => ComCall(20, this.p, Int32, ruleFlags)
    get_Parameters(parameters)
      => ComCall(21, this.p, SAFEARRAY.Ptr.Ptr, parameters)
    put_Parameters(parameters)
      => ComCall(22, this.p, SAFEARRAY.Ptr, parameters)
    get_LastModified(lastModified)
      => ComCall(23, this.p, VARIANT.Ptr, lastModified)
}
struct IFsrmClassificationRule extends IFsrmRule {
    static IID := "{AFC052C2-5315-45AB-841B-C6DB0E120148}"
    get_ExecutionOption(executionOption)
      => ComCall(24, this.p, FsrmExecutionOption.Ptr, executionOption)
    put_ExecutionOption(executionOption)
      => ComCall(25, this.p, FsrmExecutionOption, executionOption)
    get_PropertyAffected(property)
      => ComCall(26, this.p, BSTR.Ptr, property)
    put_PropertyAffected(property)
      => ComCall(27, this.p, BSTR, property)
    get_Value(value)
      => ComCall(28, this.p, BSTR.Ptr, value)
    put_Value(value)
      => ComCall(29, this.p, BSTR, value)
}
struct IFsrmPipelineModuleDefinition extends IFsrmObject {
    static IID := "{515C1277-2C81-440E-8FCF-367921ED4F59}"
    get_ModuleClsid(moduleClsid)
      => ComCall(12, this.p, BSTR.Ptr, moduleClsid)
    put_ModuleClsid(moduleClsid)
      => ComCall(13, this.p, BSTR, moduleClsid)
    get_Name(name)
      => ComCall(14, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(15, this.p, BSTR, name)
    get_Company(company)
      => ComCall(16, this.p, BSTR.Ptr, company)
    put_Company(company)
      => ComCall(17, this.p, BSTR, company)
    get_Version(version)
      => ComCall(18, this.p, BSTR.Ptr, version)
    put_Version(version)
      => ComCall(19, this.p, BSTR, version)
    get_ModuleType(moduleType)
      => ComCall(20, this.p, FsrmPipelineModuleType.Ptr, moduleType)
    get_Enabled(enabled)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(22, this.p, VARIANT_BOOL, enabled)
    get_NeedsFileContent(needsFileContent)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, needsFileContent)
    put_NeedsFileContent(needsFileContent)
      => ComCall(24, this.p, VARIANT_BOOL, needsFileContent)
    get_Account(retrievalAccount)
      => ComCall(25, this.p, FsrmAccountType.Ptr, retrievalAccount)
    put_Account(retrievalAccount)
      => ComCall(26, this.p, FsrmAccountType, retrievalAccount)
    get_SupportedExtensions(supportedExtensions)
      => ComCall(27, this.p, SAFEARRAY.Ptr.Ptr, supportedExtensions)
    put_SupportedExtensions(supportedExtensions)
      => ComCall(28, this.p, SAFEARRAY.Ptr, supportedExtensions)
    get_Parameters(parameters)
      => ComCall(29, this.p, SAFEARRAY.Ptr.Ptr, parameters)
    put_Parameters(parameters)
      => ComCall(30, this.p, SAFEARRAY.Ptr, parameters)
}
struct IFsrmClassifierModuleDefinition extends IFsrmPipelineModuleDefinition {
    static IID := "{BB36EA26-6318-4B8C-8592-F72DD602E7A5}"
    get_PropertiesAffected(propertiesAffected)
      => ComCall(31, this.p, SAFEARRAY.Ptr.Ptr, propertiesAffected)
    put_PropertiesAffected(propertiesAffected)
      => ComCall(32, this.p, SAFEARRAY.Ptr, propertiesAffected)
    get_PropertiesUsed(propertiesUsed)
      => ComCall(33, this.p, SAFEARRAY.Ptr.Ptr, propertiesUsed)
    put_PropertiesUsed(propertiesUsed)
      => ComCall(34, this.p, SAFEARRAY.Ptr, propertiesUsed)
    get_NeedsExplicitValue(needsExplicitValue)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, needsExplicitValue)
    put_NeedsExplicitValue(needsExplicitValue)
      => ComCall(36, this.p, VARIANT_BOOL, needsExplicitValue)
}
struct IFsrmStorageModuleDefinition extends IFsrmPipelineModuleDefinition {
    static IID := "{15A81350-497D-4ABA-80E9-D4DBCC5521FE}"
    get_Capabilities(capabilities)
      => ComCall(31, this.p, FsrmStorageModuleCaps.Ptr, capabilities)
    put_Capabilities(capabilities)
      => ComCall(32, this.p, FsrmStorageModuleCaps, capabilities)
    get_StorageType(storageType)
      => ComCall(33, this.p, FsrmStorageModuleType.Ptr, storageType)
    put_StorageType(storageType)
      => ComCall(34, this.p, FsrmStorageModuleType, storageType)
    get_UpdatesFileContent(updatesFileContent)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, updatesFileContent)
    put_UpdatesFileContent(updatesFileContent)
      => ComCall(36, this.p, VARIANT_BOOL, updatesFileContent)
}
struct IFsrmClassificationManager extends IDispatch {
    static IID := "{D2DC89DA-EE91-48A0-85D8-CC72A56F7D04}"
    get_ClassificationReportFormats(formats)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, formats)
    put_ClassificationReportFormats(formats)
      => ComCall(8, this.p, SAFEARRAY.Ptr, formats)
    get_Logging(logging)
      => ComCall(9, this.p, Int32.Ptr, logging)
    put_Logging(logging)
      => ComCall(10, this.p, Int32, logging)
    get_ClassificationReportMailTo(mailTo)
      => ComCall(11, this.p, BSTR.Ptr, mailTo)
    put_ClassificationReportMailTo(mailTo)
      => ComCall(12, this.p, BSTR, mailTo)
    get_ClassificationReportEnabled(reportEnabled)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, reportEnabled)
    put_ClassificationReportEnabled(reportEnabled)
      => ComCall(14, this.p, VARIANT_BOOL, reportEnabled)
    get_ClassificationLastReportPathWithoutExtension(lastReportPath)
      => ComCall(15, this.p, BSTR.Ptr, lastReportPath)
    get_ClassificationLastError(lastError)
      => ComCall(16, this.p, BSTR.Ptr, lastError)
    get_ClassificationRunningStatus(runningStatus)
      => ComCall(17, this.p, FsrmReportRunningStatus.Ptr, runningStatus)
    EnumPropertyDefinitions(options, propertyDefinitions)
      => ComCall(18, this.p, FsrmEnumOptions, options, IFsrmCollection.Ptr, propertyDefinitions)
    CreatePropertyDefinition(propertyDefinition)
      => ComCall(19, this.p, IFsrmPropertyDefinition.Ptr, propertyDefinition)
    GetPropertyDefinition(propertyName, propertyDefinition)
      => ComCall(20, this.p, BSTR, propertyName, IFsrmPropertyDefinition.Ptr, propertyDefinition)
    EnumRules(ruleType, options, Rules)
      => ComCall(21, this.p, FsrmRuleType, ruleType, FsrmEnumOptions, options, IFsrmCollection.Ptr, Rules)
    CreateRule(ruleType, Rule)
      => ComCall(22, this.p, FsrmRuleType, ruleType, IFsrmRule.Ptr, Rule)
    GetRule(ruleName, ruleType, Rule)
      => ComCall(23, this.p, BSTR, ruleName, FsrmRuleType, ruleType, IFsrmRule.Ptr, Rule)
    EnumModuleDefinitions(moduleType, options, moduleDefinitions)
      => ComCall(24, this.p, FsrmPipelineModuleType, moduleType, FsrmEnumOptions, options, IFsrmCollection.Ptr, moduleDefinitions)
    CreateModuleDefinition(moduleType, moduleDefinition)
      => ComCall(25, this.p, FsrmPipelineModuleType, moduleType, IFsrmPipelineModuleDefinition.Ptr, moduleDefinition)
    GetModuleDefinition(moduleName, moduleType, moduleDefinition)
      => ComCall(26, this.p, BSTR, moduleName, FsrmPipelineModuleType, moduleType, IFsrmPipelineModuleDefinition.Ptr, moduleDefinition)
    RunClassification(context, reserved)
      => ComCall(27, this.p, FsrmReportGenerationContext, context, BSTR, reserved)
    WaitForClassificationCompletion(waitSeconds, completed)
      => ComCall(28, this.p, Int32, waitSeconds, VARIANT_BOOL.Ptr, completed)
    CancelClassification()
      => ComCall(29, this.p)
    EnumFileProperties(filePath, options, fileProperties)
      => ComCall(30, this.p, BSTR, filePath, FsrmGetFilePropertyOptions, options, IFsrmCollection.Ptr, fileProperties)
    GetFileProperty(filePath, propertyName, options, property)
      => ComCall(31, this.p, BSTR, filePath, BSTR, propertyName, FsrmGetFilePropertyOptions, options, IFsrmProperty.Ptr, property)
    SetFileProperty(filePath, propertyName, propertyValue)
      => ComCall(32, this.p, BSTR, filePath, BSTR, propertyName, BSTR, propertyValue)
    ClearFileProperty(filePath, property)
      => ComCall(33, this.p, BSTR, filePath, BSTR, property)
}
struct IFsrmClassificationManager2 extends IFsrmClassificationManager {
    static IID := "{0004C1C9-127E-4765-BA07-6A3147BCA112}"
    ClassifyFiles(filePaths, propertyNames, propertyValues, options)
      => ComCall(34, this.p, SAFEARRAY.Ptr, filePaths, SAFEARRAY.Ptr, propertyNames, SAFEARRAY.Ptr, propertyValues, FsrmGetFilePropertyOptions, options)
}
struct IFsrmPropertyBag extends IDispatch {
    static IID := "{774589D1-D300-4F7A-9A24-F7B766800250}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_RelativePath(path)
      => ComCall(8, this.p, BSTR.Ptr, path)
    get_VolumeName(volumeName)
      => ComCall(9, this.p, BSTR.Ptr, volumeName)
    get_RelativeNamespaceRoot(relativeNamespaceRoot)
      => ComCall(10, this.p, BSTR.Ptr, relativeNamespaceRoot)
    get_VolumeIndex(volumeId)
      => ComCall(11, this.p, UInt32.Ptr, volumeId)
    get_FileId(fileId)
      => ComCall(12, this.p, VARIANT.Ptr, fileId)
    get_ParentDirectoryId(parentDirectoryId)
      => ComCall(13, this.p, VARIANT.Ptr, parentDirectoryId)
    get_Size(size)
      => ComCall(14, this.p, VARIANT.Ptr, size)
    get_SizeAllocated(sizeAllocated)
      => ComCall(15, this.p, VARIANT.Ptr, sizeAllocated)
    get_CreationTime(creationTime)
      => ComCall(16, this.p, VARIANT.Ptr, creationTime)
    get_LastAccessTime(lastAccessTime)
      => ComCall(17, this.p, VARIANT.Ptr, lastAccessTime)
    get_LastModificationTime(lastModificationTime)
      => ComCall(18, this.p, VARIANT.Ptr, lastModificationTime)
    get_Attributes(attributes)
      => ComCall(19, this.p, UInt32.Ptr, attributes)
    get_OwnerSid(ownerSid)
      => ComCall(20, this.p, BSTR.Ptr, ownerSid)
    get_FilePropertyNames(filePropertyNames)
      => ComCall(21, this.p, SAFEARRAY.Ptr.Ptr, filePropertyNames)
    get_Messages(messages)
      => ComCall(22, this.p, SAFEARRAY.Ptr.Ptr, messages)
    get_PropertyBagFlags(flags)
      => ComCall(23, this.p, UInt32.Ptr, flags)
    GetFileProperty(name, fileProperty)
      => ComCall(24, this.p, BSTR, name, IFsrmProperty.Ptr, fileProperty)
    SetFileProperty(name, value)
      => ComCall(25, this.p, BSTR, name, BSTR, value)
    AddMessage(message)
      => ComCall(26, this.p, BSTR, message)
    GetFileStreamInterface(accessMode, interfaceType, pStreamInterface)
      => ComCall(27, this.p, FsrmFileStreamingMode, accessMode, FsrmFileStreamingInterfaceType, interfaceType, VARIANT.Ptr, pStreamInterface)
}
struct IFsrmPropertyBag2 extends IFsrmPropertyBag {
    static IID := "{0E46BDBD-2402-4FED-9C30-9266E6EB2CC9}"
    GetFieldValue(field, value)
      => ComCall(28, this.p, FsrmPropertyBagField, field, VARIANT.Ptr, value)
    GetUntrustedInFileProperties(props)
      => ComCall(29, this.p, IFsrmCollection.Ptr, props)
}
struct IFsrmPipelineModuleImplementation extends IDispatch {
    static IID := "{B7907906-2B02-4CB5-84A9-FDF54613D6CD}"
    OnLoad(moduleDefinition, moduleConnector)
      => ComCall(7, this.p, IFsrmPipelineModuleDefinition, moduleDefinition, IFsrmPipelineModuleConnector.Ptr, moduleConnector)
    OnUnload()
      => ComCall(8, this.p)
}
struct IFsrmClassifierModuleImplementation extends IFsrmPipelineModuleImplementation {
    static IID := "{4C968FC6-6EDB-4051-9C18-73B7291AE106}"
    get_LastModified(lastModified)
      => ComCall(9, this.p, VARIANT.Ptr, lastModified)
    UseRulesAndDefinitions(rules, propertyDefinitions)
      => ComCall(10, this.p, IFsrmCollection, rules, IFsrmCollection, propertyDefinitions)
    OnBeginFile(propertyBag, arrayRuleIds)
      => ComCall(11, this.p, IFsrmPropertyBag, propertyBag, SAFEARRAY.Ptr, arrayRuleIds)
    DoesPropertyValueApply(property, value, applyValue, idRule, idPropDef)
      => ComCall(12, this.p, BSTR, property, BSTR, value, VARIANT_BOOL.Ptr, applyValue, GUID, idRule, GUID, idPropDef)
    GetPropertyValueToApply(property, value, idRule, idPropDef)
      => ComCall(13, this.p, BSTR, property, BSTR.Ptr, value, GUID, idRule, GUID, idPropDef)
    OnEndFile()
      => ComCall(14, this.p)
}
struct IFsrmStorageModuleImplementation extends IFsrmPipelineModuleImplementation {
    static IID := "{0AF4A0DA-895A-4E50-8712-A96724BCEC64}"
    UseDefinitions(propertyDefinitions)
      => ComCall(9, this.p, IFsrmCollection, propertyDefinitions)
    LoadProperties(propertyBag)
      => ComCall(10, this.p, IFsrmPropertyBag, propertyBag)
    SaveProperties(propertyBag)
      => ComCall(11, this.p, IFsrmPropertyBag, propertyBag)
}
struct IFsrmPipelineModuleConnector extends IDispatch {
    static IID := "{C16014F3-9AA1-46B3-B0A7-AB146EB205F2}"
    get_ModuleImplementation(pipelineModuleImplementation)
      => ComCall(7, this.p, IFsrmPipelineModuleImplementation.Ptr, pipelineModuleImplementation)
    get_ModuleName(userName)
      => ComCall(8, this.p, BSTR.Ptr, userName)
    get_HostingUserAccount(userAccount)
      => ComCall(9, this.p, BSTR.Ptr, userAccount)
    get_HostingProcessPid(pid)
      => ComCall(10, this.p, Int32.Ptr, pid)
    Bind(moduleDefinition, moduleImplementation)
      => ComCall(11, this.p, IFsrmPipelineModuleDefinition, moduleDefinition, IFsrmPipelineModuleImplementation, moduleImplementation)
}
struct DIFsrmClassificationEvents extends IDispatch {
    static IID := "{26942DB0-DABF-41D8-BBDD-B129A9F70424}"
}
