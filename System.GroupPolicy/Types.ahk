#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HANDLE, HRESULT, HWND, LPARAM, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\System.Wmi\Types.ahk" {IWbemServices}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

struct GPO_OPEN_FLAGS extends UInt32 {
    static GPO_OPEN_LOAD_REGISTRY := 1
    static GPO_OPEN_READ_ONLY := 2
}
struct GPO_OPTIONS extends UInt32 {
    static GPO_OPTION_DISABLE_USER := 1
    static GPO_OPTION_DISABLE_MACHINE := 2
}
struct GPO_SECTION extends UInt32 {
    static GPO_SECTION_ROOT := 0
    static GPO_SECTION_USER := 1
    static GPO_SECTION_MACHINE := 2
}
struct GPMRSOPMode extends Int32 {
    static rsopUnknown := 0
    static rsopPlanning := 1
    static rsopLogging := 2
}
struct GPMPermissionType extends Int32 {
    static permGPOApply := 65536
    static permGPORead := 65792
    static permGPOEdit := 65793
    static permGPOEditSecurityAndDelete := 65794
    static permGPOCustom := 65795
    static permWMIFilterEdit := 131072
    static permWMIFilterFullControl := 131073
    static permWMIFilterCustom := 131074
    static permSOMLink := 1835008
    static permSOMLogging := 1573120
    static permSOMPlanning := 1573376
    static permSOMWMICreate := 1049344
    static permSOMWMIFullControl := 1049345
    static permSOMGPOCreate := 1049600
    static permStarterGPORead := 197888
    static permStarterGPOEdit := 197889
    static permStarterGPOFullControl := 197890
    static permStarterGPOCustom := 197891
    static permSOMStarterGPOCreate := 1049856
}
struct GPMSearchProperty extends Int32 {
    static gpoPermissions := 0
    static gpoEffectivePermissions := 1
    static gpoDisplayName := 2
    static gpoWMIFilter := 3
    static gpoID := 4
    static gpoComputerExtensions := 5
    static gpoUserExtensions := 6
    static somLinks := 7
    static gpoDomain := 8
    static backupMostRecent := 9
    static starterGPOPermissions := 10
    static starterGPOEffectivePermissions := 11
    static starterGPODisplayName := 12
    static starterGPOID := 13
    static starterGPODomain := 14
}
struct GPMSearchOperation extends Int32 {
    static opEquals := 0
    static opContains := 1
    static opNotContains := 2
    static opNotEquals := 3
}
struct GPMReportType extends Int32 {
    static repXML := 0
    static repHTML := 1
    static repInfraXML := 2
    static repInfraRefreshXML := 3
    static repClientHealthXML := 4
    static repClientHealthRefreshXML := 5
}
struct GPMEntryType extends Int32 {
    static typeUser := 0
    static typeComputer := 1
    static typeLocalGroup := 2
    static typeGlobalGroup := 3
    static typeUniversalGroup := 4
    static typeUNCPath := 5
    static typeUnknown := 6
}
struct GPMDestinationOption extends Int32 {
    static opDestinationSameAsSource := 0
    static opDestinationNone := 1
    static opDestinationByRelativeName := 2
    static opDestinationSet := 3
}
struct GPMReportingOptions extends Int32 {
    static opReportLegacy := 0
    static opReportComments := 1
}
struct IGPM extends IDispatch {
    static IID := "{F5FAE809-3BD6-4DA9-A65E-17665B41D763}"
    GetDomain(bstrDomain, bstrDomainController, lDCFlags, pIGPMDomain)
      => ComCall(7, this.p, BSTR, bstrDomain, BSTR, bstrDomainController, Int32, lDCFlags, IGPMDomain.Ptr, pIGPMDomain)
    GetBackupDir(bstrBackupDir, pIGPMBackupDir)
      => ComCall(8, this.p, BSTR, bstrBackupDir, IGPMBackupDir.Ptr, pIGPMBackupDir)
    GetSitesContainer(bstrForest, bstrDomain, bstrDomainController, lDCFlags, ppIGPMSitesContainer)
      => ComCall(9, this.p, BSTR, bstrForest, BSTR, bstrDomain, BSTR, bstrDomainController, Int32, lDCFlags, IGPMSitesContainer.Ptr, ppIGPMSitesContainer)
    GetRSOP(gpmRSoPMode1, bstrNamespace, lFlags, ppIGPMRSOP)
      => ComCall(10, this.p, GPMRSOPMode, gpmRSoPMode1, BSTR, bstrNamespace, Int32, lFlags, IGPMRSOP.Ptr, ppIGPMRSOP)
    CreatePermission(bstrTrustee, perm, bInheritable, ppPerm)
      => ComCall(11, this.p, BSTR, bstrTrustee, GPMPermissionType, perm, VARIANT_BOOL, bInheritable, IGPMPermission.Ptr, ppPerm)
    CreateSearchCriteria(ppIGPMSearchCriteria)
      => ComCall(12, this.p, IGPMSearchCriteria.Ptr, ppIGPMSearchCriteria)
    CreateTrustee(bstrTrustee, ppIGPMTrustee)
      => ComCall(13, this.p, BSTR, bstrTrustee, IGPMTrustee.Ptr, ppIGPMTrustee)
    GetClientSideExtensions(ppIGPMCSECollection)
      => ComCall(14, this.p, IGPMCSECollection.Ptr, ppIGPMCSECollection)
    GetConstants(ppIGPMConstants)
      => ComCall(15, this.p, IGPMConstants.Ptr, ppIGPMConstants)
    GetMigrationTable(bstrMigrationTablePath, ppMigrationTable)
      => ComCall(16, this.p, BSTR, bstrMigrationTablePath, IGPMMigrationTable.Ptr, ppMigrationTable)
    CreateMigrationTable(ppMigrationTable)
      => ComCall(17, this.p, IGPMMigrationTable.Ptr, ppMigrationTable)
    InitializeReporting(bstrAdmPath)
      => ComCall(18, this.p, BSTR, bstrAdmPath)
}
struct IGPMDomain extends IDispatch {
    static IID := "{6B21CC14-5A00-4F44-A738-FEEC8A94C7E3}"
    get_DomainController(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_Domain(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    CreateGPO(ppNewGPO)
      => ComCall(9, this.p, IGPMGPO.Ptr, ppNewGPO)
    GetGPO(bstrGuid, ppGPO)
      => ComCall(10, this.p, BSTR, bstrGuid, IGPMGPO.Ptr, ppGPO)
    SearchGPOs(pIGPMSearchCriteria, ppIGPMGPOCollection)
      => ComCall(11, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMGPOCollection.Ptr, ppIGPMGPOCollection)
    RestoreGPO(pIGPMBackup, lDCFlags, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(12, this.p, IGPMBackup, pIGPMBackup, Int32, lDCFlags, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GetSOM(bstrPath, ppSOM)
      => ComCall(13, this.p, BSTR, bstrPath, IGPMSOM.Ptr, ppSOM)
    SearchSOMs(pIGPMSearchCriteria, ppIGPMSOMCollection)
      => ComCall(14, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMSOMCollection.Ptr, ppIGPMSOMCollection)
    GetWMIFilter(bstrPath, ppWMIFilter)
      => ComCall(15, this.p, BSTR, bstrPath, IGPMWMIFilter.Ptr, ppWMIFilter)
    SearchWMIFilters(pIGPMSearchCriteria, ppIGPMWMIFilterCollection)
      => ComCall(16, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMWMIFilterCollection.Ptr, ppIGPMWMIFilterCollection)
}
struct IGPMBackupDir extends IDispatch {
    static IID := "{B1568BED-0A93-4ACC-810F-AFE7081019B9}"
    get_BackupDirectory(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    GetBackup(bstrID, ppBackup)
      => ComCall(8, this.p, BSTR, bstrID, IGPMBackup.Ptr, ppBackup)
    SearchBackups(pIGPMSearchCriteria, ppIGPMBackupCollection)
      => ComCall(9, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMBackupCollection.Ptr, ppIGPMBackupCollection)
}
struct IGPMSitesContainer extends IDispatch {
    static IID := "{4725A899-2782-4D27-A6BB-D499246FFD72}"
    get_DomainController(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_Domain(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_Forest(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    GetSite(bstrSiteName, ppSOM)
      => ComCall(10, this.p, BSTR, bstrSiteName, IGPMSOM.Ptr, ppSOM)
    SearchSites(pIGPMSearchCriteria, ppIGPMSOMCollection)
      => ComCall(11, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMSOMCollection.Ptr, ppIGPMSOMCollection)
}
struct IGPMSearchCriteria extends IDispatch {
    static IID := "{D6F11C42-829B-48D4-83F5-3615B67DFC22}"
    Add(searchProperty, searchOperation, varValue)
      => ComCall(7, this.p, GPMSearchProperty, searchProperty, GPMSearchOperation, searchOperation, VARIANT, varValue)
}
struct IGPMTrustee extends IDispatch {
    static IID := "{3B466DA8-C1A4-4B2A-999A-BEFCDD56CEFB}"
    get_TrusteeSid(bstrVal)
      => ComCall(7, this.p, BSTR.Ptr, bstrVal)
    get_TrusteeName(bstrVal)
      => ComCall(8, this.p, BSTR.Ptr, bstrVal)
    get_TrusteeDomain(bstrVal)
      => ComCall(9, this.p, BSTR.Ptr, bstrVal)
    get_TrusteeDSPath(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_TrusteeType(lVal)
      => ComCall(11, this.p, Int32.Ptr, lVal)
}
struct IGPMPermission extends IDispatch {
    static IID := "{35EBCA40-E1A1-4A02-8905-D79416FB464A}"
    get_Inherited(pVal)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pVal)
    get_Inheritable(pVal)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pVal)
    get_Denied(pVal)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pVal)
    get_Permission(pVal)
      => ComCall(10, this.p, GPMPermissionType.Ptr, pVal)
    get_Trustee(ppIGPMTrustee)
      => ComCall(11, this.p, IGPMTrustee.Ptr, ppIGPMTrustee)
}
struct IGPMSecurityInfo extends IDispatch {
    static IID := "{B6C31ED4-1C93-4D3E-AE84-EB6D61161B60}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppEnum)
    Add(pPerm)
      => ComCall(10, this.p, IGPMPermission, pPerm)
    Remove(pPerm)
      => ComCall(11, this.p, IGPMPermission, pPerm)
    RemoveTrustee(bstrTrustee)
      => ComCall(12, this.p, BSTR, bstrTrustee)
}
struct IGPMBackup extends IDispatch {
    static IID := "{D8A16A35-3B0D-416B-8D02-4DF6F95A7119}"
    get_ID(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_GPOID(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_GPODomain(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    get_GPODisplayName(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_Timestamp(pVal)
      => ComCall(11, this.p, Float64.Ptr, pVal)
    get_Comment(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
    get_BackupDir(pVal)
      => ComCall(13, this.p, BSTR.Ptr, pVal)
    Delete()
      => ComCall(14, this.p)
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(15, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReportToFile(gpmReportType1, bstrTargetFilePath, ppIGPMResult)
      => ComCall(16, this.p, GPMReportType, gpmReportType1, BSTR, bstrTargetFilePath, IGPMResult.Ptr, ppIGPMResult)
}
struct IGPMBackupCollection extends IDispatch {
    static IID := "{C786FC0F-26D8-4BAB-A745-39CA7E800CAC}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMBackup)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMBackup)
}
struct GPMSOMType extends Int32 {
    static somSite := 0
    static somDomain := 1
    static somOU := 2
}
struct IGPMSOM extends IDispatch {
    static IID := "{C0A7F09E-05A1-4F0C-8158-9E5C33684F6B}"
    get_GPOInheritanceBlocked(pVal)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pVal)
    put_GPOInheritanceBlocked(newVal)
      => ComCall(8, this.p, VARIANT_BOOL, newVal)
    get_Name(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    get_Path(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    CreateGPOLink(lLinkPos, pGPO, ppNewGPOLink)
      => ComCall(11, this.p, Int32, lLinkPos, IGPMGPO, pGPO, IGPMGPOLink.Ptr, ppNewGPOLink)
    get_Type(pVal)
      => ComCall(12, this.p, GPMSOMType.Ptr, pVal)
    GetGPOLinks(ppGPOLinks)
      => ComCall(13, this.p, IGPMGPOLinksCollection.Ptr, ppGPOLinks)
    GetInheritedGPOLinks(ppGPOLinks)
      => ComCall(14, this.p, IGPMGPOLinksCollection.Ptr, ppGPOLinks)
    GetSecurityInfo(ppSecurityInfo)
      => ComCall(15, this.p, IGPMSecurityInfo.Ptr, ppSecurityInfo)
    SetSecurityInfo(pSecurityInfo)
      => ComCall(16, this.p, IGPMSecurityInfo, pSecurityInfo)
}
struct IGPMSOMCollection extends IDispatch {
    static IID := "{ADC1688E-00E4-4495-ABBA-BED200DF0CAB}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMSOM)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMSOM)
}
struct IGPMWMIFilter extends IDispatch {
    static IID := "{EF2FF9B4-3C27-459A-B979-038305CEC75D}"
    get_Path(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_Name(newVal)
      => ComCall(8, this.p, BSTR, newVal)
    get_Name(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_Description(newVal)
      => ComCall(10, this.p, BSTR, newVal)
    get_Description(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    GetQueryList(pQryList)
      => ComCall(12, this.p, VARIANT.Ptr, pQryList)
    GetSecurityInfo(ppSecurityInfo)
      => ComCall(13, this.p, IGPMSecurityInfo.Ptr, ppSecurityInfo)
    SetSecurityInfo(pSecurityInfo)
      => ComCall(14, this.p, IGPMSecurityInfo, pSecurityInfo)
}
struct IGPMWMIFilterCollection extends IDispatch {
    static IID := "{5782D582-1A36-4661-8A94-C3C32551945B}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, pVal)
}
struct IGPMRSOP extends IDispatch {
    static IID := "{49ED785A-3237-4FF2-B1F0-FDF5A8D5A1EE}"
    get_Mode(pVal)
      => ComCall(7, this.p, GPMRSOPMode.Ptr, pVal)
    get_Namespace(bstrVal)
      => ComCall(8, this.p, BSTR.Ptr, bstrVal)
    put_LoggingComputer(bstrVal)
      => ComCall(9, this.p, BSTR, bstrVal)
    get_LoggingComputer(bstrVal)
      => ComCall(10, this.p, BSTR.Ptr, bstrVal)
    put_LoggingUser(bstrVal)
      => ComCall(11, this.p, BSTR, bstrVal)
    get_LoggingUser(bstrVal)
      => ComCall(12, this.p, BSTR.Ptr, bstrVal)
    put_LoggingFlags(lVal)
      => ComCall(13, this.p, Int32, lVal)
    get_LoggingFlags(lVal)
      => ComCall(14, this.p, Int32.Ptr, lVal)
    put_PlanningFlags(lVal)
      => ComCall(15, this.p, Int32, lVal)
    get_PlanningFlags(lVal)
      => ComCall(16, this.p, Int32.Ptr, lVal)
    put_PlanningDomainController(bstrVal)
      => ComCall(17, this.p, BSTR, bstrVal)
    get_PlanningDomainController(bstrVal)
      => ComCall(18, this.p, BSTR.Ptr, bstrVal)
    put_PlanningSiteName(bstrVal)
      => ComCall(19, this.p, BSTR, bstrVal)
    get_PlanningSiteName(bstrVal)
      => ComCall(20, this.p, BSTR.Ptr, bstrVal)
    put_PlanningUser(bstrVal)
      => ComCall(21, this.p, BSTR, bstrVal)
    get_PlanningUser(bstrVal)
      => ComCall(22, this.p, BSTR.Ptr, bstrVal)
    put_PlanningUserSOM(bstrVal)
      => ComCall(23, this.p, BSTR, bstrVal)
    get_PlanningUserSOM(bstrVal)
      => ComCall(24, this.p, BSTR.Ptr, bstrVal)
    put_PlanningUserWMIFilters(varVal)
      => ComCall(25, this.p, VARIANT, varVal)
    get_PlanningUserWMIFilters(varVal)
      => ComCall(26, this.p, VARIANT.Ptr, varVal)
    put_PlanningUserSecurityGroups(varVal)
      => ComCall(27, this.p, VARIANT, varVal)
    get_PlanningUserSecurityGroups(varVal)
      => ComCall(28, this.p, VARIANT.Ptr, varVal)
    put_PlanningComputer(bstrVal)
      => ComCall(29, this.p, BSTR, bstrVal)
    get_PlanningComputer(bstrVal)
      => ComCall(30, this.p, BSTR.Ptr, bstrVal)
    put_PlanningComputerSOM(bstrVal)
      => ComCall(31, this.p, BSTR, bstrVal)
    get_PlanningComputerSOM(bstrVal)
      => ComCall(32, this.p, BSTR.Ptr, bstrVal)
    put_PlanningComputerWMIFilters(varVal)
      => ComCall(33, this.p, VARIANT, varVal)
    get_PlanningComputerWMIFilters(varVal)
      => ComCall(34, this.p, VARIANT.Ptr, varVal)
    put_PlanningComputerSecurityGroups(varVal)
      => ComCall(35, this.p, VARIANT, varVal)
    get_PlanningComputerSecurityGroups(varVal)
      => ComCall(36, this.p, VARIANT.Ptr, varVal)
    LoggingEnumerateUsers(varVal)
      => ComCall(37, this.p, VARIANT.Ptr, varVal)
    CreateQueryResults()
      => ComCall(38, this.p)
    ReleaseQueryResults()
      => ComCall(39, this.p)
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(40, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReportToFile(gpmReportType1, bstrTargetFilePath, ppIGPMResult)
      => ComCall(41, this.p, GPMReportType, gpmReportType1, BSTR, bstrTargetFilePath, IGPMResult.Ptr, ppIGPMResult)
}
struct IGPMGPO extends IDispatch {
    static IID := "{58CC4352-1CA3-48E5-9864-1DA4D6E0D60F}"
    get_DisplayName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_DisplayName(newVal)
      => ComCall(8, this.p, BSTR, newVal)
    get_Path(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    get_ID(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_DomainName(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    get_CreationTime(pDate)
      => ComCall(12, this.p, Float64.Ptr, pDate)
    get_ModificationTime(pDate)
      => ComCall(13, this.p, Float64.Ptr, pDate)
    get_UserDSVersionNumber(pVal)
      => ComCall(14, this.p, Int32.Ptr, pVal)
    get_ComputerDSVersionNumber(pVal)
      => ComCall(15, this.p, Int32.Ptr, pVal)
    get_UserSysvolVersionNumber(pVal)
      => ComCall(16, this.p, Int32.Ptr, pVal)
    get_ComputerSysvolVersionNumber(pVal)
      => ComCall(17, this.p, Int32.Ptr, pVal)
    GetWMIFilter(ppIGPMWMIFilter)
      => ComCall(18, this.p, IGPMWMIFilter.Ptr, ppIGPMWMIFilter)
    SetWMIFilter(pIGPMWMIFilter)
      => ComCall(19, this.p, IGPMWMIFilter, pIGPMWMIFilter)
    SetUserEnabled(vbEnabled)
      => ComCall(20, this.p, VARIANT_BOOL, vbEnabled)
    SetComputerEnabled(vbEnabled)
      => ComCall(21, this.p, VARIANT_BOOL, vbEnabled)
    IsUserEnabled(pvbEnabled)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, pvbEnabled)
    IsComputerEnabled(pvbEnabled)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pvbEnabled)
    GetSecurityInfo(ppSecurityInfo)
      => ComCall(24, this.p, IGPMSecurityInfo.Ptr, ppSecurityInfo)
    SetSecurityInfo(pSecurityInfo)
      => ComCall(25, this.p, IGPMSecurityInfo, pSecurityInfo)
    Delete()
      => ComCall(26, this.p)
    Backup(bstrBackupDir, bstrComment, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(27, this.p, BSTR, bstrBackupDir, BSTR, bstrComment, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    Import(lFlags, pIGPMBackup, pvarMigrationTable, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(28, this.p, Int32, lFlags, IGPMBackup, pIGPMBackup, VARIANT.Ptr, pvarMigrationTable, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(29, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReportToFile(gpmReportType1, bstrTargetFilePath, ppIGPMResult)
      => ComCall(30, this.p, GPMReportType, gpmReportType1, BSTR, bstrTargetFilePath, IGPMResult.Ptr, ppIGPMResult)
    CopyTo(lFlags, pIGPMDomain, pvarNewDisplayName, pvarMigrationTable, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(31, this.p, Int32, lFlags, IGPMDomain, pIGPMDomain, VARIANT.Ptr, pvarNewDisplayName, VARIANT.Ptr, pvarMigrationTable, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    SetSecurityDescriptor(lFlags, pSD)
      => ComCall(32, this.p, Int32, lFlags, IDispatch, pSD)
    GetSecurityDescriptor(lFlags, ppSD)
      => ComCall(33, this.p, Int32, lFlags, IDispatch.Ptr, ppSD)
    IsACLConsistent(pvbConsistent)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, pvbConsistent)
    MakeACLConsistent()
      => ComCall(35, this.p)
}
struct IGPMGPOCollection extends IDispatch {
    static IID := "{F0F0D5CF-70CA-4C39-9E29-B642F8726C01}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMGPOs)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMGPOs)
}
struct IGPMGPOLink extends IDispatch {
    static IID := "{434B99BD-5DE7-478A-809C-C251721DF70C}"
    get_GPOID(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_GPODomain(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_Enabled(pVal)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pVal)
    put_Enabled(newVal)
      => ComCall(10, this.p, VARIANT_BOOL, newVal)
    get_Enforced(pVal)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pVal)
    put_Enforced(newVal)
      => ComCall(12, this.p, VARIANT_BOOL, newVal)
    get_SOMLinkOrder(lVal)
      => ComCall(13, this.p, Int32.Ptr, lVal)
    get_SOM(ppIGPMSOM)
      => ComCall(14, this.p, IGPMSOM.Ptr, ppIGPMSOM)
    Delete()
      => ComCall(15, this.p)
}
struct IGPMGPOLinksCollection extends IDispatch {
    static IID := "{189D7B68-16BD-4D0D-A2EC-2E6AA2288C7F}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMLinks)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMLinks)
}
struct IGPMCSECollection extends IDispatch {
    static IID := "{2E52A97D-0A4A-4A6F-85DB-201622455DA0}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMCSEs)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMCSEs)
}
struct IGPMClientSideExtension extends IDispatch {
    static IID := "{69DA7488-B8DB-415E-9266-901BE4D49928}"
    get_ID(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_DisplayName(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    IsUserEnabled(pvbEnabled)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pvbEnabled)
    IsComputerEnabled(pvbEnabled)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pvbEnabled)
}
struct IGPMAsyncCancel extends IDispatch {
    static IID := "{DDC67754-BE67-4541-8166-F48166868C9C}"
    Cancel()
      => ComCall(7, this.p)
}
struct IGPMAsyncProgress extends IDispatch {
    static IID := "{6AAC29F8-5948-4324-BF70-423818942DBC}"
    Status(lProgressNumerator, lProgressDenominator, hrStatus, pResult, ppIGPMStatusMsgCollection)
      => ComCall(7, this.p, Int32, lProgressNumerator, Int32, lProgressDenominator, HRESULT, hrStatus, VARIANT.Ptr, pResult, IGPMStatusMsgCollection, ppIGPMStatusMsgCollection)
}
struct IGPMStatusMsgCollection extends IDispatch {
    static IID := "{9B6E1AF0-1A92-40F3-A59D-F36AC1F728B7}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, pVal)
}
struct IGPMStatusMessage extends IDispatch {
    static IID := "{8496C22F-F3DE-4A1F-8F58-603CAAA93D7B}"
    get_ObjectPath(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    ErrorCode()
      => ComCall(8, this.p)
    get_ExtensionName(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    get_SettingsName(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    OperationCode()
      => ComCall(11, this.p)
    get_Message(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
}
struct IGPMConstants extends IDispatch {
    static IID := "{50EF73E6-D35C-4C8D-BE63-7EA5D2AAC5C4}"
    get_PermGPOApply(pVal)
      => ComCall(7, this.p, GPMPermissionType.Ptr, pVal)
    get_PermGPORead(pVal)
      => ComCall(8, this.p, GPMPermissionType.Ptr, pVal)
    get_PermGPOEdit(pVal)
      => ComCall(9, this.p, GPMPermissionType.Ptr, pVal)
    get_PermGPOEditSecurityAndDelete(pVal)
      => ComCall(10, this.p, GPMPermissionType.Ptr, pVal)
    get_PermGPOCustom(pVal)
      => ComCall(11, this.p, GPMPermissionType.Ptr, pVal)
    get_PermWMIFilterEdit(pVal)
      => ComCall(12, this.p, GPMPermissionType.Ptr, pVal)
    get_PermWMIFilterFullControl(pVal)
      => ComCall(13, this.p, GPMPermissionType.Ptr, pVal)
    get_PermWMIFilterCustom(pVal)
      => ComCall(14, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMLink(pVal)
      => ComCall(15, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMLogging(pVal)
      => ComCall(16, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMPlanning(pVal)
      => ComCall(17, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMGPOCreate(pVal)
      => ComCall(18, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMWMICreate(pVal)
      => ComCall(19, this.p, GPMPermissionType.Ptr, pVal)
    get_PermSOMWMIFullControl(pVal)
      => ComCall(20, this.p, GPMPermissionType.Ptr, pVal)
    get_SearchPropertyGPOPermissions(pVal)
      => ComCall(21, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPOEffectivePermissions(pVal)
      => ComCall(22, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPODisplayName(pVal)
      => ComCall(23, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPOWMIFilter(pVal)
      => ComCall(24, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPOID(pVal)
      => ComCall(25, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPOComputerExtensions(pVal)
      => ComCall(26, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPOUserExtensions(pVal)
      => ComCall(27, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertySOMLinks(pVal)
      => ComCall(28, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyGPODomain(pVal)
      => ComCall(29, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyBackupMostRecent(pVal)
      => ComCall(30, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchOpEquals(pVal)
      => ComCall(31, this.p, GPMSearchOperation.Ptr, pVal)
    get_SearchOpContains(pVal)
      => ComCall(32, this.p, GPMSearchOperation.Ptr, pVal)
    get_SearchOpNotContains(pVal)
      => ComCall(33, this.p, GPMSearchOperation.Ptr, pVal)
    get_SearchOpNotEquals(pVal)
      => ComCall(34, this.p, GPMSearchOperation.Ptr, pVal)
    get_UsePDC(pVal)
      => ComCall(35, this.p, Int32.Ptr, pVal)
    get_UseAnyDC(pVal)
      => ComCall(36, this.p, Int32.Ptr, pVal)
    get_DoNotUseW2KDC(pVal)
      => ComCall(37, this.p, Int32.Ptr, pVal)
    get_SOMSite(pVal)
      => ComCall(38, this.p, GPMSOMType.Ptr, pVal)
    get_SOMDomain(pVal)
      => ComCall(39, this.p, GPMSOMType.Ptr, pVal)
    get_SOMOU(pVal)
      => ComCall(40, this.p, GPMSOMType.Ptr, pVal)
    get_SecurityFlags(vbOwner, vbGroup, vbDACL, vbSACL, pVal)
      => ComCall(41, this.p, VARIANT_BOOL, vbOwner, VARIANT_BOOL, vbGroup, VARIANT_BOOL, vbDACL, VARIANT_BOOL, vbSACL, Int32.Ptr, pVal)
    get_DoNotValidateDC(pVal)
      => ComCall(42, this.p, Int32.Ptr, pVal)
    get_ReportHTML(pVal)
      => ComCall(43, this.p, GPMReportType.Ptr, pVal)
    get_ReportXML(pVal)
      => ComCall(44, this.p, GPMReportType.Ptr, pVal)
    get_RSOPModeUnknown(pVal)
      => ComCall(45, this.p, GPMRSOPMode.Ptr, pVal)
    get_RSOPModePlanning(pVal)
      => ComCall(46, this.p, GPMRSOPMode.Ptr, pVal)
    get_RSOPModeLogging(pVal)
      => ComCall(47, this.p, GPMRSOPMode.Ptr, pVal)
    get_EntryTypeUser(pVal)
      => ComCall(48, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeComputer(pVal)
      => ComCall(49, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeLocalGroup(pVal)
      => ComCall(50, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeGlobalGroup(pVal)
      => ComCall(51, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeUniversalGroup(pVal)
      => ComCall(52, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeUNCPath(pVal)
      => ComCall(53, this.p, GPMEntryType.Ptr, pVal)
    get_EntryTypeUnknown(pVal)
      => ComCall(54, this.p, GPMEntryType.Ptr, pVal)
    get_DestinationOptionSameAsSource(pVal)
      => ComCall(55, this.p, GPMDestinationOption.Ptr, pVal)
    get_DestinationOptionNone(pVal)
      => ComCall(56, this.p, GPMDestinationOption.Ptr, pVal)
    get_DestinationOptionByRelativeName(pVal)
      => ComCall(57, this.p, GPMDestinationOption.Ptr, pVal)
    get_DestinationOptionSet(pVal)
      => ComCall(58, this.p, GPMDestinationOption.Ptr, pVal)
    get_MigrationTableOnly(pVal)
      => ComCall(59, this.p, Int32.Ptr, pVal)
    get_ProcessSecurity(pVal)
      => ComCall(60, this.p, Int32.Ptr, pVal)
    get_RsopLoggingNoComputer(pVal)
      => ComCall(61, this.p, Int32.Ptr, pVal)
    get_RsopLoggingNoUser(pVal)
      => ComCall(62, this.p, Int32.Ptr, pVal)
    get_RsopPlanningAssumeSlowLink(pVal)
      => ComCall(63, this.p, Int32.Ptr, pVal)
    get_RsopPlanningLoopbackOption(vbMerge, pVal)
      => ComCall(64, this.p, VARIANT_BOOL, vbMerge, Int32.Ptr, pVal)
    get_RsopPlanningAssumeUserWQLFilterTrue(pVal)
      => ComCall(65, this.p, Int32.Ptr, pVal)
    get_RsopPlanningAssumeCompWQLFilterTrue(pVal)
      => ComCall(66, this.p, Int32.Ptr, pVal)
}
struct IGPMResult extends IDispatch {
    static IID := "{86DFF7E9-F76F-42AB-9570-CEBC6BE8A52D}"
    get_Status(ppIGPMStatusMsgCollection)
      => ComCall(7, this.p, IGPMStatusMsgCollection.Ptr, ppIGPMStatusMsgCollection)
    get_Result(pvarResult)
      => ComCall(8, this.p, VARIANT.Ptr, pvarResult)
    OverallStatus()
      => ComCall(9, this.p)
}
struct IGPMMapEntryCollection extends IDispatch {
    static IID := "{BB0BF49B-E53F-443F-B807-8BE22BFB6D42}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, pVal)
}
struct IGPMMapEntry extends IDispatch {
    static IID := "{8E79AD06-2381-4444-BE4C-FF693E6E6F2B}"
    get_Source(pbstrSource)
      => ComCall(7, this.p, BSTR.Ptr, pbstrSource)
    get_Destination(pbstrDestination)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDestination)
    get_DestinationOption(pgpmDestOption)
      => ComCall(9, this.p, GPMDestinationOption.Ptr, pgpmDestOption)
    get_EntryType(pgpmEntryType)
      => ComCall(10, this.p, GPMEntryType.Ptr, pgpmEntryType)
}
struct IGPMMigrationTable extends IDispatch {
    static IID := "{48F823B1-EFAF-470B-B6ED-40D14EE1A4EC}"
    Save(bstrMigrationTablePath)
      => ComCall(7, this.p, BSTR, bstrMigrationTablePath)
    Add(lFlags, var)
      => ComCall(8, this.p, Int32, lFlags, VARIANT, var)
    AddEntry(bstrSource, gpmEntryType1, pvarDestination, ppEntry)
      => ComCall(9, this.p, BSTR, bstrSource, GPMEntryType, gpmEntryType1, VARIANT.Ptr, pvarDestination, IGPMMapEntry.Ptr, ppEntry)
    GetEntry(bstrSource, ppEntry)
      => ComCall(10, this.p, BSTR, bstrSource, IGPMMapEntry.Ptr, ppEntry)
    DeleteEntry(bstrSource)
      => ComCall(11, this.p, BSTR, bstrSource)
    UpdateDestination(bstrSource, pvarDestination, ppEntry)
      => ComCall(12, this.p, BSTR, bstrSource, VARIANT.Ptr, pvarDestination, IGPMMapEntry.Ptr, ppEntry)
    Validate(ppResult)
      => ComCall(13, this.p, IGPMResult.Ptr, ppResult)
    GetEntries(ppEntries)
      => ComCall(14, this.p, IGPMMapEntryCollection.Ptr, ppEntries)
}
struct GPMBackupType extends Int32 {
    static typeGPO := 0
    static typeStarterGPO := 1
}
struct GPMStarterGPOType extends Int32 {
    static typeSystem := 0
    static typeCustom := 1
}
struct IGPMBackupDirEx extends IDispatch {
    static IID := "{F8DC55ED-3BA0-4864-AAD4-D365189EE1D5}"
    get_BackupDir(pbstrBackupDir)
      => ComCall(7, this.p, BSTR.Ptr, pbstrBackupDir)
    get_BackupType(pgpmBackupType)
      => ComCall(8, this.p, GPMBackupType.Ptr, pgpmBackupType)
    GetBackup(bstrID, pvarBackup)
      => ComCall(9, this.p, BSTR, bstrID, VARIANT.Ptr, pvarBackup)
    SearchBackups(pIGPMSearchCriteria, pvarBackupCollection)
      => ComCall(10, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, VARIANT.Ptr, pvarBackupCollection)
}
struct IGPMStarterGPOBackupCollection extends IDispatch {
    static IID := "{C998031D-ADD0-4BB5-8DEA-298505D8423B}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMTmplBackup)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMTmplBackup)
}
struct IGPMStarterGPOBackup extends IDispatch {
    static IID := "{51D98EDA-A87E-43DD-B80A-0B66EF1938D6}"
    get_BackupDir(pbstrBackupDir)
      => ComCall(7, this.p, BSTR.Ptr, pbstrBackupDir)
    get_Comment(pbstrComment)
      => ComCall(8, this.p, BSTR.Ptr, pbstrComment)
    get_DisplayName(pbstrDisplayName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDisplayName)
    get_Domain(pbstrTemplateDomain)
      => ComCall(10, this.p, BSTR.Ptr, pbstrTemplateDomain)
    get_StarterGPOID(pbstrTemplateID)
      => ComCall(11, this.p, BSTR.Ptr, pbstrTemplateID)
    get_ID(pbstrID)
      => ComCall(12, this.p, BSTR.Ptr, pbstrID)
    get_Timestamp(pTimestamp)
      => ComCall(13, this.p, Float64.Ptr, pTimestamp)
    get_Type(pType)
      => ComCall(14, this.p, GPMStarterGPOType.Ptr, pType)
    Delete()
      => ComCall(15, this.p)
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(16, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReportToFile(gpmReportType1, bstrTargetFilePath, ppIGPMResult)
      => ComCall(17, this.p, GPMReportType, gpmReportType1, BSTR, bstrTargetFilePath, IGPMResult.Ptr, ppIGPMResult)
}
struct IGPM2 extends IGPM {
    static IID := "{00238F8A-3D86-41AC-8F5E-06A6638A634A}"
    GetBackupDirEx(bstrBackupDir, backupDirType, ppIGPMBackupDirEx)
      => ComCall(19, this.p, BSTR, bstrBackupDir, GPMBackupType, backupDirType, IGPMBackupDirEx.Ptr, ppIGPMBackupDirEx)
    InitializeReportingEx(bstrAdmPath, reportingOptions)
      => ComCall(20, this.p, BSTR, bstrAdmPath, Int32, reportingOptions)
}
struct IGPMStarterGPO extends IDispatch {
    static IID := "{DFC3F61B-8880-4490-9337-D29C7BA8C2F0}"
    get_DisplayName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_DisplayName(newVal)
      => ComCall(8, this.p, BSTR, newVal)
    get_Description(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_Description(newVal)
      => ComCall(10, this.p, BSTR, newVal)
    get_Author(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    get_Product(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
    get_CreationTime(pVal)
      => ComCall(13, this.p, Float64.Ptr, pVal)
    get_ID(pVal)
      => ComCall(14, this.p, BSTR.Ptr, pVal)
    get_ModifiedTime(pVal)
      => ComCall(15, this.p, Float64.Ptr, pVal)
    get_Type(pVal)
      => ComCall(16, this.p, GPMStarterGPOType.Ptr, pVal)
    get_ComputerVersion(pVal)
      => ComCall(17, this.p, UInt16.Ptr, pVal)
    get_UserVersion(pVal)
      => ComCall(18, this.p, UInt16.Ptr, pVal)
    get_StarterGPOVersion(pVal)
      => ComCall(19, this.p, BSTR.Ptr, pVal)
    Delete()
      => ComCall(20, this.p)
    Save(bstrSaveFile, bOverwrite, bSaveAsSystem, bstrLanguage, bstrAuthor, bstrProduct, bstrUniqueID, bstrVersion, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(21, this.p, BSTR, bstrSaveFile, VARIANT_BOOL, bOverwrite, VARIANT_BOOL, bSaveAsSystem, VARIANT.Ptr, bstrLanguage, VARIANT.Ptr, bstrAuthor, VARIANT.Ptr, bstrProduct, VARIANT.Ptr, bstrUniqueID, VARIANT.Ptr, bstrVersion, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    Backup(bstrBackupDir, bstrComment, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(22, this.p, BSTR, bstrBackupDir, BSTR, bstrComment, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    CopyTo(pvarNewDisplayName, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(23, this.p, VARIANT.Ptr, pvarNewDisplayName, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(24, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    GenerateReportToFile(gpmReportType1, bstrTargetFilePath, ppIGPMResult)
      => ComCall(25, this.p, GPMReportType, gpmReportType1, BSTR, bstrTargetFilePath, IGPMResult.Ptr, ppIGPMResult)
    GetSecurityInfo(ppSecurityInfo)
      => ComCall(26, this.p, IGPMSecurityInfo.Ptr, ppSecurityInfo)
    SetSecurityInfo(pSecurityInfo)
      => ComCall(27, this.p, IGPMSecurityInfo, pSecurityInfo)
}
struct IGPMStarterGPOCollection extends IDispatch {
    static IID := "{2E522729-2219-44AD-933A-64DFD650C423}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_Item(lIndex, pVal)
      => ComCall(8, this.p, Int32, lIndex, VARIANT.Ptr, pVal)
    get__NewEnum(ppIGPMTemplates)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, ppIGPMTemplates)
}
struct IGPMDomain2 extends IGPMDomain {
    static IID := "{7CA6BB8B-F1EB-490A-938D-3C4E51C768E6}"
    CreateStarterGPO(ppnewTemplate)
      => ComCall(17, this.p, IGPMStarterGPO.Ptr, ppnewTemplate)
    CreateGPOFromStarterGPO(pGPOTemplate, ppnewGPO)
      => ComCall(18, this.p, IGPMStarterGPO, pGPOTemplate, IGPMGPO.Ptr, ppnewGPO)
    GetStarterGPO(bstrGuid, ppTemplate)
      => ComCall(19, this.p, BSTR, bstrGuid, IGPMStarterGPO.Ptr, ppTemplate)
    SearchStarterGPOs(pIGPMSearchCriteria, ppIGPMTemplateCollection)
      => ComCall(20, this.p, IGPMSearchCriteria, pIGPMSearchCriteria, IGPMStarterGPOCollection.Ptr, ppIGPMTemplateCollection)
    LoadStarterGPO(bstrLoadFile, bOverwrite, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(21, this.p, BSTR, bstrLoadFile, VARIANT_BOOL, bOverwrite, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    RestoreStarterGPO(pIGPMTmplBackup, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(22, this.p, IGPMStarterGPOBackup, pIGPMTmplBackup, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
}
struct IGPMConstants2 extends IGPMConstants {
    static IID := "{05AE21B0-AC09-4032-A26F-9E7DA786DC19}"
    get_BackupTypeGPO(pVal)
      => ComCall(67, this.p, GPMBackupType.Ptr, pVal)
    get_BackupTypeStarterGPO(pVal)
      => ComCall(68, this.p, GPMBackupType.Ptr, pVal)
    get_StarterGPOTypeSystem(pVal)
      => ComCall(69, this.p, GPMStarterGPOType.Ptr, pVal)
    get_StarterGPOTypeCustom(pVal)
      => ComCall(70, this.p, GPMStarterGPOType.Ptr, pVal)
    get_SearchPropertyStarterGPOPermissions(pVal)
      => ComCall(71, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyStarterGPOEffectivePermissions(pVal)
      => ComCall(72, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyStarterGPODisplayName(pVal)
      => ComCall(73, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyStarterGPOID(pVal)
      => ComCall(74, this.p, GPMSearchProperty.Ptr, pVal)
    get_SearchPropertyStarterGPODomain(pVal)
      => ComCall(75, this.p, GPMSearchProperty.Ptr, pVal)
    get_PermStarterGPORead(pVal)
      => ComCall(76, this.p, GPMPermissionType.Ptr, pVal)
    get_PermStarterGPOEdit(pVal)
      => ComCall(77, this.p, GPMPermissionType.Ptr, pVal)
    get_PermStarterGPOFullControl(pVal)
      => ComCall(78, this.p, GPMPermissionType.Ptr, pVal)
    get_PermStarterGPOCustom(pVal)
      => ComCall(79, this.p, GPMPermissionType.Ptr, pVal)
    get_ReportLegacy(pVal)
      => ComCall(80, this.p, GPMReportingOptions.Ptr, pVal)
    get_ReportComments(pVal)
      => ComCall(81, this.p, GPMReportingOptions.Ptr, pVal)
}
struct IGPMGPO2 extends IGPMGPO {
    static IID := "{8A66A210-B78B-4D99-88E2-C306A817C925}"
    get_Description(pVal)
      => ComCall(36, this.p, BSTR.Ptr, pVal)
    put_Description(newVal)
      => ComCall(37, this.p, BSTR, newVal)
}
struct IGPMDomain3 extends IGPMDomain2 {
    static IID := "{0077FDFE-88C7-4ACF-A11D-D10A7C310A03}"
    GenerateReport(gpmReportType1, pvarGPMProgress, pvarGPMCancel, ppIGPMResult)
      => ComCall(23, this.p, GPMReportType, gpmReportType1, VARIANT.Ptr, pvarGPMProgress, VARIANT.Ptr, pvarGPMCancel, IGPMResult.Ptr, ppIGPMResult)
    get_InfrastructureDC(pVal)
      => ComCall(24, this.p, BSTR.Ptr, pVal)
    put_InfrastructureDC(newVal)
      => ComCall(25, this.p, BSTR, newVal)
    put_InfrastructureFlags(dwFlags)
      => ComCall(26, this.p, UInt32, dwFlags)
}
struct IGPMGPO3 extends IGPMGPO2 {
    static IID := "{7CF123A1-F94A-4112-BFAE-6AA1DB9CB248}"
    get_InfrastructureDC(pVal)
      => ComCall(38, this.p, BSTR.Ptr, pVal)
    put_InfrastructureDC(newVal)
      => ComCall(39, this.p, BSTR, newVal)
    put_InfrastructureFlags(dwFlags)
      => ComCall(40, this.p, UInt32, dwFlags)
}
struct GPO_LINK extends Int32 {
    static GPLinkUnknown := 0
    static GPLinkMachine := 1
    static GPLinkSite := 2
    static GPLinkDomain := 3
    static GPLinkOrganizationalUnit := 4
}
struct GROUP_POLICY_OBJECTA {
    dwOptions : UInt32
    dwVersion : UInt32
    lpDSPath : PSTR
    lpFileSysPath : PSTR
    lpDisplayName : PSTR
    szGPOName : CHAR[50]
    GPOLink : GPO_LINK
    lParam : LPARAM
    pNext : GROUP_POLICY_OBJECTA.Ptr
    pPrev : GROUP_POLICY_OBJECTA.Ptr
    lpExtensions : PSTR
    lParam2 : LPARAM
    lpLink : PSTR
}
struct GROUP_POLICY_OBJECTW {
    dwOptions : UInt32
    dwVersion : UInt32
    lpDSPath : PWSTR
    lpFileSysPath : PWSTR
    lpDisplayName : PWSTR
    szGPOName : UInt16[50]
    GPOLink : GPO_LINK
    lParam : LPARAM
    pNext : GROUP_POLICY_OBJECTW.Ptr
    pPrev : GROUP_POLICY_OBJECTW.Ptr
    lpExtensions : PWSTR
    lParam2 : LPARAM
    lpLink : PWSTR
}
struct PFNSTATUSMESSAGECALLBACK extends FunctionPointer {
    static Types := [BOOL, PWSTR, UInt32]
}
struct PFNPROCESSGROUPPOLICY extends FunctionPointer {
    static Types := [UInt32, HANDLE, HKEY, GROUP_POLICY_OBJECTA.Ptr, GROUP_POLICY_OBJECTA.Ptr, IntPtr, BOOL.Ptr, PFNSTATUSMESSAGECALLBACK, UInt32]
}
struct PFNPROCESSGROUPPOLICYEX extends FunctionPointer {
    static Types := [UInt32, HANDLE, HKEY, GROUP_POLICY_OBJECTA.Ptr, GROUP_POLICY_OBJECTA.Ptr, IntPtr, BOOL.Ptr, PFNSTATUSMESSAGECALLBACK, IWbemServices, HRESULT.Ptr, UInt32]
}
struct RSOP_TARGET {
    pwszAccountName : PWSTR
    pwszNewSOM : PWSTR
    psaSecurityGroups : SAFEARRAY.Ptr
    pRsopToken : Struct.Ptr
    pGPOList : GROUP_POLICY_OBJECTA.Ptr
    pWbemServices : IWbemServices
}
struct PFNGENERATEGROUPPOLICY extends FunctionPointer {
    static Types := [UInt32, BOOL.Ptr, PWSTR, RSOP_TARGET.Ptr, RSOP_TARGET.Ptr, UInt32]
}
struct SETTINGSTATUS extends Int32 {
    static RSOPUnspecified := 0
    static RSOPApplied := 1
    static RSOPIgnored := 2
    static RSOPFailed := 3
    static RSOPSubsettingFailed := 4
}
struct POLICYSETTINGSTATUSINFO {
    szKey : PWSTR
    szEventSource : PWSTR
    szEventLogName : PWSTR
    dwEventID : UInt32
    dwErrorCode : UInt32
    status : SETTINGSTATUS
    timeLogged : SYSTEMTIME
}
struct INSTALLSPECTYPE extends Int32 {
    static APPNAME := 1
    static FILEEXT := 2
    static PROGID := 3
    static COMCLASS := 4
}
struct INSTALLSPEC {
    union {
        AppName : this._AppName_e__Struct
        FileExt : PWSTR
        ProgId : PWSTR
        COMClass : this._COMClass_e__Struct
    }
    struct _AppName_e__Struct {
        Name : PWSTR
        GPOId : GUID
    }
    struct _COMClass_e__Struct {
        Clsid : GUID
        ClsCtx : UInt32
    }
}
struct INSTALLDATA {
    Type : INSTALLSPECTYPE
    Spec : INSTALLSPEC
}
struct APPSTATE extends Int32 {
    static ABSENT := 0
    static ASSIGNED := 1
    static PUBLISHED := 2
}
struct LOCALMANAGEDAPPLICATION {
    pszDeploymentName : PWSTR
    pszPolicyName : PWSTR
    pszProductId : PWSTR
    dwState : UInt32
}
struct MANAGEDAPPLICATION {
    pszPackageName : PWSTR
    pszPublisher : PWSTR
    dwVersionHi : UInt32
    dwVersionLo : UInt32
    dwRevision : UInt32
    GpoId : GUID
    pszPolicyName : PWSTR
    ProductId : GUID
    Language : UInt16
    pszOwner : PWSTR
    pszCompany : PWSTR
    pszComments : PWSTR
    pszContact : PWSTR
    pszSupportUrl : PWSTR
    dwPathType : UInt32
    bInstalled : BOOL
}
struct GROUP_POLICY_OBJECT_TYPE extends Int32 {
    static GPOTypeLocal := 0
    static GPOTypeRemote := 1
    static GPOTypeDS := 2
    static GPOTypeLocalUser := 3
    static GPOTypeLocalGroup := 4
}
struct GROUP_POLICY_HINT_TYPE extends Int32 {
    static GPHintUnknown := 0
    static GPHintMachine := 1
    static GPHintSite := 2
    static GPHintDomain := 3
    static GPHintOrganizationalUnit := 4
}
struct IGPEInformation extends IUnknown {
    static IID := "{8FC0B735-A0E1-11D1-A7D3-0000F87571E3}"
    GetName(pszName)
      => ComCall(3, this.p, PWSTR, pszName, Int32, pszName.Length)
    GetDisplayName(pszName)
      => ComCall(4, this.p, PWSTR, pszName, Int32, pszName.Length)
    GetRegistryKey(dwSection, hKey)
      => ComCall(5, this.p, UInt32, dwSection, HKEY.Ptr, hKey)
    GetDSPath(dwSection, pszPath)
      => ComCall(6, this.p, UInt32, dwSection, PWSTR, pszPath, Int32, pszPath.Length)
    GetFileSysPath(dwSection, pszPath)
      => ComCall(7, this.p, UInt32, dwSection, PWSTR, pszPath, Int32, pszPath.Length)
    GetOptions(dwOptions)
      => ComCall(8, this.p, UInt32.Ptr, dwOptions)
    GetType(gpoType)
      => ComCall(9, this.p, GROUP_POLICY_OBJECT_TYPE.Ptr, gpoType)
    GetHint(gpHint)
      => ComCall(10, this.p, GROUP_POLICY_HINT_TYPE.Ptr, gpHint)
    PolicyChanged(bMachine, bAdd, pGuidExtension, pGuidSnapin)
      => ComCall(11, this.p, BOOL, bMachine, BOOL, bAdd, GUID.Ptr, pGuidExtension, GUID.Ptr, pGuidSnapin)
}
struct IGroupPolicyObject extends IUnknown {
    static IID := "{EA502723-A23D-11D1-A7D3-0000F87571E3}"
    New(pszDomainName, pszDisplayName?, dwFlags)
      => ComCall(3, this.p, "Str", pszDomainName, "Str", pszDisplayName?, UInt32, dwFlags)
    OpenDSGPO(pszPath, dwFlags)
      => ComCall(4, this.p, "Str", pszPath, GPO_OPEN_FLAGS, dwFlags)
    OpenLocalMachineGPO(dwFlags)
      => ComCall(5, this.p, GPO_OPEN_FLAGS, dwFlags)
    OpenRemoteMachineGPO(pszComputerName, dwFlags)
      => ComCall(6, this.p, "Str", pszComputerName, GPO_OPEN_FLAGS, dwFlags)
    Save(bMachine, bAdd, pGuidExtension, pGuid)
      => ComCall(7, this.p, BOOL, bMachine, BOOL, bAdd, GUID.Ptr, pGuidExtension, GUID.Ptr, pGuid)
    Delete()
      => ComCall(8, this.p)
    GetName(pszName)
      => ComCall(9, this.p, PWSTR, pszName, Int32, pszName.Length)
    GetDisplayName(pszName)
      => ComCall(10, this.p, PWSTR, pszName, Int32, pszName.Length)
    SetDisplayName(pszName)
      => ComCall(11, this.p, "Str", pszName)
    GetPath(pszPath)
      => ComCall(12, this.p, PWSTR, pszPath, Int32, pszPath.Length)
    GetDSPath(dwSection, pszPath)
      => ComCall(13, this.p, UInt32, dwSection, PWSTR, pszPath, Int32, pszPath.Length)
    GetFileSysPath(dwSection, pszPath)
      => ComCall(14, this.p, UInt32, dwSection, PWSTR, pszPath, Int32, pszPath.Length)
    GetRegistryKey(dwSection, hKey)
      => ComCall(15, this.p, GPO_SECTION, dwSection, HKEY.Ptr, hKey)
    GetOptions(dwOptions)
      => ComCall(16, this.p, GPO_OPTIONS.Ptr, dwOptions)
    SetOptions(dwOptions, dwMask)
      => ComCall(17, this.p, GPO_OPTIONS, dwOptions, UInt32, dwMask)
    GetType(gpoType)
      => ComCall(18, this.p, GROUP_POLICY_OBJECT_TYPE.Ptr, gpoType)
    GetMachineName(pszName)
      => ComCall(19, this.p, PWSTR, pszName, Int32, pszName.Length)
    GetPropertySheetPages(hPages, uPageCount)
      => ComCall(20, this.p, HPROPSHEETPAGE.Ptr.Ptr, hPages, UInt32.Ptr, uPageCount)
}
struct IRSOPInformation extends IUnknown {
    static IID := "{9A5A81B5-D9C7-49EF-9D11-DDF50968C48D}"
    GetNamespace(dwSection, pszName)
      => ComCall(3, this.p, UInt32, dwSection, PWSTR, pszName, Int32, pszName.Length)
    GetFlags(pdwFlags)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags)
    GetEventLogEntryText(pszEventSource, pszEventLogName, pszEventTime, dwEventID, ppszText)
      => ComCall(5, this.p, "Str", pszEventSource, "Str", pszEventLogName, "Str", pszEventTime, UInt32, dwEventID, PWSTR.Ptr, ppszText)
}
struct GPOBROWSEINFO {
    dwSize : UInt32
    dwFlags : UInt32
    hwndOwner : HWND
    lpTitle : PWSTR
    lpInitialOU : PWSTR
    lpDSPath : PWSTR
    dwDSPathSize : UInt32
    lpName : PWSTR
    dwNameSize : UInt32
    gpoType : GROUP_POLICY_OBJECT_TYPE
    gpoHint : GROUP_POLICY_HINT_TYPE
}
