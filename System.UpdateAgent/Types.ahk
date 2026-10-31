#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, DECIMAL, HRESULT, HWND, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct AutomaticUpdatesNotificationLevel extends Int32 {
    static aunlNotConfigured := 0
    static aunlDisabled := 1
    static aunlNotifyBeforeDownload := 2
    static aunlNotifyBeforeInstallation := 3
    static aunlScheduledInstallation := 4
}
struct AutomaticUpdatesScheduledInstallationDay extends Int32 {
    static ausidEveryDay := 0
    static ausidEverySunday := 1
    static ausidEveryMonday := 2
    static ausidEveryTuesday := 3
    static ausidEveryWednesday := 4
    static ausidEveryThursday := 5
    static ausidEveryFriday := 6
    static ausidEverySaturday := 7
}
struct DownloadPhase extends Int32 {
    static dphInitializing := 1
    static dphDownloading := 2
    static dphVerifying := 3
}
struct DownloadPriority extends Int32 {
    static dpLow := 1
    static dpNormal := 2
    static dpHigh := 3
    static dpExtraHigh := 4
}
struct AutoSelectionMode extends Int32 {
    static asLetWindowsUpdateDecide := 0
    static asAutoSelectIfDownloaded := 1
    static asNeverAutoSelect := 2
    static asAlwaysAutoSelect := 3
}
struct AutoDownloadMode extends Int32 {
    static adLetWindowsUpdateDecide := 0
    static adNeverAutoDownload := 1
    static adAlwaysAutoDownload := 2
}
struct InstallationImpact extends Int32 {
    static iiNormal := 0
    static iiMinor := 1
    static iiRequiresExclusiveHandling := 2
}
struct InstallationRebootBehavior extends Int32 {
    static irbNeverReboots := 0
    static irbAlwaysRequiresReboot := 1
    static irbCanRequestReboot := 2
}
struct OperationResultCode extends Int32 {
    static orcNotStarted := 0
    static orcInProgress := 1
    static orcSucceeded := 2
    static orcSucceededWithErrors := 3
    static orcFailed := 4
    static orcAborted := 5
}
struct ServerSelection extends Int32 {
    static ssDefault := 0
    static ssManagedServer := 1
    static ssWindowsUpdate := 2
    static ssOthers := 3
}
struct UpdateType extends Int32 {
    static utSoftware := 1
    static utDriver := 2
}
struct UpdateOperation extends Int32 {
    static uoInstallation := 1
    static uoUninstallation := 2
}
struct DeploymentAction extends Int32 {
    static daNone := 0
    static daInstallation := 1
    static daUninstallation := 2
    static daDetection := 3
    static daOptionalInstallation := 4
}
struct UpdateExceptionContext extends Int32 {
    static uecGeneral := 1
    static uecWindowsDriver := 2
    static uecWindowsInstaller := 3
    static uecSearchIncomplete := 4
}
struct AutomaticUpdatesUserType extends Int32 {
    static auutCurrentUser := 1
    static auutLocalAdministrator := 2
}
struct AutomaticUpdatesPermissionType extends Int32 {
    static auptSetNotificationLevel := 1
    static auptDisableAutomaticUpdates := 2
    static auptSetIncludeRecommendedUpdates := 3
    static auptSetFeaturedUpdatesEnabled := 4
    static auptSetNonAdministratorsElevated := 5
}
struct UpdateServiceRegistrationState extends Int32 {
    static usrsNotRegistered := 1
    static usrsRegistrationPending := 2
    static usrsRegistered := 3
}
struct SearchScope extends Int32 {
    static searchScopeDefault := 0
    static searchScopeMachineOnly := 1
    static searchScopeCurrentUserOnly := 2
    static searchScopeMachineAndCurrentUser := 3
    static searchScopeMachineAndAllUsers := 4
    static searchScopeAllUsers := 5
}
struct DownloadType extends Int32 {
    static downloadTypeFull := 0
    static downloadTypeUpdateBootstrapper := 1
}
struct IUpdateLockdown extends IUnknown {
    static IID := "{A976C28D-75A1-42AA-94AE-8AF8B872089A}"
    LockDown(flags)
      => ComCall(3, this.p, Int32, flags)
}
struct IStringCollection extends IDispatch {
    static IID := "{EFF90582-2DDC-480F-A06D-60F3FBC362C3}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, BSTR.Ptr, retval)
    put_Item(index, value)
      => ComCall(8, this.p, Int32, index, BSTR, value)
    get__NewEnum(retval)
      => ComCall(9, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
    get_ReadOnly(retval)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, retval)
    Add(value, retval)
      => ComCall(12, this.p, BSTR, value, Int32.Ptr, retval)
    Clear()
      => ComCall(13, this.p)
    Copy(retval)
      => ComCall(14, this.p, IStringCollection.Ptr, retval)
    Insert(index, value)
      => ComCall(15, this.p, Int32, index, BSTR, value)
    RemoveAt(index)
      => ComCall(16, this.p, Int32, index)
}
struct IWebProxy extends IDispatch {
    static IID := "{174C81FE-AECD-4DAE-B8A0-2C6318DD86A8}"
    get_Address(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_Address(value)
      => ComCall(8, this.p, BSTR, value)
    get_BypassList(retval)
      => ComCall(9, this.p, IStringCollection.Ptr, retval)
    put_BypassList(value)
      => ComCall(10, this.p, IStringCollection, value)
    get_BypassProxyOnLocal(retval)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, retval)
    put_BypassProxyOnLocal(value)
      => ComCall(12, this.p, VARIANT_BOOL, value)
    get_ReadOnly(retval)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, retval)
    get_UserName(retval)
      => ComCall(14, this.p, BSTR.Ptr, retval)
    put_UserName(value)
      => ComCall(15, this.p, BSTR, value)
    SetPassword(value)
      => ComCall(16, this.p, BSTR, value)
    PromptForCredentials(parentWindow, title)
      => ComCall(17, this.p, IUnknown, parentWindow, BSTR, title)
    PromptForCredentialsFromHwnd(parentWindow, title)
      => ComCall(18, this.p, HWND, parentWindow, BSTR, title)
    get_AutoDetect(retval)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, retval)
    put_AutoDetect(value)
      => ComCall(20, this.p, VARIANT_BOOL, value)
}
struct ISystemInformation extends IDispatch {
    static IID := "{ADE87BF7-7B56-4275-8FAB-B9B0E591844B}"
    get_OemHardwareSupportLink(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_RebootRequired(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IWindowsUpdateAgentInfo extends IDispatch {
    static IID := "{85713FA1-7796-4FA2-BE3B-E2D6124DD373}"
    GetInfo(varInfoIdentifier, retval)
      => ComCall(7, this.p, VARIANT, varInfoIdentifier, VARIANT.Ptr, retval)
}
struct IAutomaticUpdatesResults extends IDispatch {
    static IID := "{E7A4D634-7942-4DD9-A111-82228BA33901}"
    get_LastSearchSuccessDate(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    get_LastInstallationSuccessDate(retval)
      => ComCall(8, this.p, VARIANT.Ptr, retval)
}
struct IAutomaticUpdatesSettings extends IDispatch {
    static IID := "{2EE48F22-AF3C-405F-8970-F71BE12EE9A2}"
    get_NotificationLevel(retval)
      => ComCall(7, this.p, AutomaticUpdatesNotificationLevel.Ptr, retval)
    put_NotificationLevel(value)
      => ComCall(8, this.p, AutomaticUpdatesNotificationLevel, value)
    get_ReadOnly(retval)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, retval)
    get_Required(retval)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, retval)
    get_ScheduledInstallationDay(retval)
      => ComCall(11, this.p, AutomaticUpdatesScheduledInstallationDay.Ptr, retval)
    put_ScheduledInstallationDay(value)
      => ComCall(12, this.p, AutomaticUpdatesScheduledInstallationDay, value)
    get_ScheduledInstallationTime(retval)
      => ComCall(13, this.p, Int32.Ptr, retval)
    put_ScheduledInstallationTime(value)
      => ComCall(14, this.p, Int32, value)
    Refresh()
      => ComCall(15, this.p)
    Save()
      => ComCall(16, this.p)
}
struct IAutomaticUpdatesSettings2 extends IAutomaticUpdatesSettings {
    static IID := "{6ABC136A-C3CA-4384-8171-CB2B1E59B8DC}"
    get_IncludeRecommendedUpdates(retval)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, retval)
    put_IncludeRecommendedUpdates(value)
      => ComCall(18, this.p, VARIANT_BOOL, value)
    CheckPermission(userType, permissionType, userHasPermission)
      => ComCall(19, this.p, AutomaticUpdatesUserType, userType, AutomaticUpdatesPermissionType, permissionType, VARIANT_BOOL.Ptr, userHasPermission)
}
struct IAutomaticUpdatesSettings3 extends IAutomaticUpdatesSettings2 {
    static IID := "{B587F5C3-F57E-485F-BBF5-0D181C5CD0DC}"
    get_NonAdministratorsElevated(retval)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, retval)
    put_NonAdministratorsElevated(value)
      => ComCall(21, this.p, VARIANT_BOOL, value)
    get_FeaturedUpdatesEnabled(retval)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, retval)
    put_FeaturedUpdatesEnabled(value)
      => ComCall(23, this.p, VARIANT_BOOL, value)
}
struct IAutomaticUpdates extends IDispatch {
    static IID := "{673425BF-C082-4C7C-BDFD-569464B8E0CE}"
    DetectNow()
      => ComCall(7, this.p)
    Pause()
      => ComCall(8, this.p)
    Resume()
      => ComCall(9, this.p)
    ShowSettingsDialog()
      => ComCall(10, this.p)
    get_Settings(retval)
      => ComCall(11, this.p, IAutomaticUpdatesSettings.Ptr, retval)
    get_ServiceEnabled(retval)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, retval)
    EnableService()
      => ComCall(13, this.p)
}
struct IAutomaticUpdates2 extends IAutomaticUpdates {
    static IID := "{4A2F5C31-CFD9-410E-B7FB-29A653973A0F}"
    get_Results(retval)
      => ComCall(14, this.p, IAutomaticUpdatesResults.Ptr, retval)
}
struct IUpdateIdentity extends IDispatch {
    static IID := "{46297823-9940-4C09-AED9-CD3EA6D05968}"
    get_RevisionNumber(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_UpdateID(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
}
struct IImageInformation extends IDispatch {
    static IID := "{7C907864-346C-4AEB-8F3F-57DA289F969F}"
    get_AltText(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_Height(retval)
      => ComCall(8, this.p, Int32.Ptr, retval)
    get_Source(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    get_Width(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
}
struct ICategory extends IDispatch {
    static IID := "{81DDC1B8-9D35-47A6-B471-5B80F519223B}"
    get_Name(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_CategoryID(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_Children(retval)
      => ComCall(9, this.p, ICategoryCollection.Ptr, retval)
    get_Description(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
    get_Image(retval)
      => ComCall(11, this.p, IImageInformation.Ptr, retval)
    get_Order(retval)
      => ComCall(12, this.p, Int32.Ptr, retval)
    get_Parent(retval)
      => ComCall(13, this.p, ICategory.Ptr, retval)
    get_Type(retval)
      => ComCall(14, this.p, BSTR.Ptr, retval)
    get_Updates(retval)
      => ComCall(15, this.p, IUpdateCollection.Ptr, retval)
}
struct ICategoryCollection extends IDispatch {
    static IID := "{3A56BFB8-576C-43F7-9335-FE4838FD7E37}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, ICategory.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct IInstallationBehavior extends IDispatch {
    static IID := "{D9A59339-E245-4DBD-9686-4D5763E39624}"
    get_CanRequestUserInput(retval)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, retval)
    get_Impact(retval)
      => ComCall(8, this.p, InstallationImpact.Ptr, retval)
    get_RebootBehavior(retval)
      => ComCall(9, this.p, InstallationRebootBehavior.Ptr, retval)
    get_RequiresNetworkConnectivity(retval)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdateDownloadContent extends IDispatch {
    static IID := "{54A2CB2D-9A0C-48B6-8A50-9ABB69EE2D02}"
    get_DownloadUrl(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
}
struct IUpdateDownloadContent2 extends IUpdateDownloadContent {
    static IID := "{C97AD11B-F257-420B-9D9F-377F733F6F68}"
    get_IsDeltaCompressedContent(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdateDownloadContentCollection extends IDispatch {
    static IID := "{BC5513C8-B3B8-4BF7-A4D4-361C0D8C88BA}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IUpdateDownloadContent.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct IUpdate extends IDispatch {
    static IID := "{6A92B07A-D821-4682-B423-5C805022CC4D}"
    get_Title(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_AutoSelectOnWebSites(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    get_BundledUpdates(retval)
      => ComCall(9, this.p, IUpdateCollection.Ptr, retval)
    get_CanRequireSource(retval)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, retval)
    get_Categories(retval)
      => ComCall(11, this.p, ICategoryCollection.Ptr, retval)
    get_Deadline(retval)
      => ComCall(12, this.p, VARIANT.Ptr, retval)
    get_DeltaCompressedContentAvailable(retval)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, retval)
    get_DeltaCompressedContentPreferred(retval)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, retval)
    get_Description(retval)
      => ComCall(15, this.p, BSTR.Ptr, retval)
    get_EulaAccepted(retval)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, retval)
    get_EulaText(retval)
      => ComCall(17, this.p, BSTR.Ptr, retval)
    get_HandlerID(retval)
      => ComCall(18, this.p, BSTR.Ptr, retval)
    get_Identity(retval)
      => ComCall(19, this.p, IUpdateIdentity.Ptr, retval)
    get_Image(retval)
      => ComCall(20, this.p, IImageInformation.Ptr, retval)
    get_InstallationBehavior(retval)
      => ComCall(21, this.p, IInstallationBehavior.Ptr, retval)
    get_IsBeta(retval)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsDownloaded(retval)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsHidden(retval)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, retval)
    put_IsHidden(value)
      => ComCall(25, this.p, VARIANT_BOOL, value)
    get_IsInstalled(retval)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsMandatory(retval)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsUninstallable(retval)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, retval)
    get_Languages(retval)
      => ComCall(29, this.p, IStringCollection.Ptr, retval)
    get_LastDeploymentChangeTime(retval)
      => ComCall(30, this.p, Float64.Ptr, retval)
    get_MaxDownloadSize(retval)
      => ComCall(31, this.p, DECIMAL.Ptr, retval)
    get_MinDownloadSize(retval)
      => ComCall(32, this.p, DECIMAL.Ptr, retval)
    get_MoreInfoUrls(retval)
      => ComCall(33, this.p, IStringCollection.Ptr, retval)
    get_MsrcSeverity(retval)
      => ComCall(34, this.p, BSTR.Ptr, retval)
    get_RecommendedCpuSpeed(retval)
      => ComCall(35, this.p, Int32.Ptr, retval)
    get_RecommendedHardDiskSpace(retval)
      => ComCall(36, this.p, Int32.Ptr, retval)
    get_RecommendedMemory(retval)
      => ComCall(37, this.p, Int32.Ptr, retval)
    get_ReleaseNotes(retval)
      => ComCall(38, this.p, BSTR.Ptr, retval)
    get_SecurityBulletinIDs(retval)
      => ComCall(39, this.p, IStringCollection.Ptr, retval)
    get_SupersededUpdateIDs(retval)
      => ComCall(40, this.p, IStringCollection.Ptr, retval)
    get_SupportUrl(retval)
      => ComCall(41, this.p, BSTR.Ptr, retval)
    get_Type(retval)
      => ComCall(42, this.p, UpdateType.Ptr, retval)
    get_UninstallationNotes(retval)
      => ComCall(43, this.p, BSTR.Ptr, retval)
    get_UninstallationBehavior(retval)
      => ComCall(44, this.p, IInstallationBehavior.Ptr, retval)
    get_UninstallationSteps(retval)
      => ComCall(45, this.p, IStringCollection.Ptr, retval)
    get_KBArticleIDs(retval)
      => ComCall(46, this.p, IStringCollection.Ptr, retval)
    AcceptEula()
      => ComCall(47, this.p)
    get_DeploymentAction(retval)
      => ComCall(48, this.p, DeploymentAction.Ptr, retval)
    CopyFromCache(path, toExtractCabFiles)
      => ComCall(49, this.p, BSTR, path, VARIANT_BOOL, toExtractCabFiles)
    get_DownloadPriority(retval)
      => ComCall(50, this.p, DownloadPriority.Ptr, retval)
    get_DownloadContents(retval)
      => ComCall(51, this.p, IUpdateDownloadContentCollection.Ptr, retval)
}
struct IWindowsDriverUpdate extends IUpdate {
    static IID := "{B383CD1A-5CE9-4504-9F63-764B1236F191}"
    get_DriverClass(retval)
      => ComCall(52, this.p, BSTR.Ptr, retval)
    get_DriverHardwareID(retval)
      => ComCall(53, this.p, BSTR.Ptr, retval)
    get_DriverManufacturer(retval)
      => ComCall(54, this.p, BSTR.Ptr, retval)
    get_DriverModel(retval)
      => ComCall(55, this.p, BSTR.Ptr, retval)
    get_DriverProvider(retval)
      => ComCall(56, this.p, BSTR.Ptr, retval)
    get_DriverVerDate(retval)
      => ComCall(57, this.p, Float64.Ptr, retval)
    get_DeviceProblemNumber(retval)
      => ComCall(58, this.p, Int32.Ptr, retval)
    get_DeviceStatus(retval)
      => ComCall(59, this.p, Int32.Ptr, retval)
}
struct IUpdate2 extends IUpdate {
    static IID := "{144FE9B0-D23D-4A8B-8634-FB4457533B7A}"
    get_RebootRequired(retval)
      => ComCall(52, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsPresent(retval)
      => ComCall(53, this.p, VARIANT_BOOL.Ptr, retval)
    get_CveIDs(retval)
      => ComCall(54, this.p, IStringCollection.Ptr, retval)
    CopyToCache(pFiles)
      => ComCall(55, this.p, IStringCollection, pFiles)
}
struct IUpdate3 extends IUpdate2 {
    static IID := "{112EDA6B-95B3-476F-9D90-AEE82C6B8181}"
    get_BrowseOnly(retval)
      => ComCall(56, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdate4 extends IUpdate3 {
    static IID := "{27E94B0D-5139-49A2-9A61-93522DC54652}"
    get_PerUser(retval)
      => ComCall(57, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdate5 extends IUpdate4 {
    static IID := "{C1C2F21A-D2F4-4902-B5C6-8A081C19A890}"
    get_AutoSelection(retval)
      => ComCall(58, this.p, AutoSelectionMode.Ptr, retval)
    get_AutoDownload(retval)
      => ComCall(59, this.p, AutoDownloadMode.Ptr, retval)
}
struct IUpdateEx extends IUpdate5 {
    static IID := "{769355A3-C5A0-497C-A606-560A36D2121C}"
    get_ExtendedStaticProperty(propertyName, retval)
      => ComCall(60, this.p, BSTR, propertyName, VARIANT.Ptr, retval)
    EvaluateExtendedDynamicProperty(propertyName, retval)
      => ComCall(61, this.p, BSTR, propertyName, VARIANT.Ptr, retval)
}
struct IWindowsDriverUpdate2 extends IWindowsDriverUpdate {
    static IID := "{615C4269-7A48-43BD-96B7-BF6CA27D6C3E}"
    get_RebootRequired(retval)
      => ComCall(60, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsPresent(retval)
      => ComCall(61, this.p, VARIANT_BOOL.Ptr, retval)
    get_CveIDs(retval)
      => ComCall(62, this.p, IStringCollection.Ptr, retval)
    CopyToCache(pFiles)
      => ComCall(63, this.p, IStringCollection, pFiles)
}
struct IWindowsDriverUpdate3 extends IWindowsDriverUpdate2 {
    static IID := "{49EBD502-4A96-41BD-9E3E-4C5057F4250C}"
    get_BrowseOnly(retval)
      => ComCall(64, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IWindowsDriverUpdateEntry extends IDispatch {
    static IID := "{ED8BFE40-A60B-42EA-9652-817DFCFA23EC}"
    get_DriverClass(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_DriverHardwareID(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_DriverManufacturer(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    get_DriverModel(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
    get_DriverProvider(retval)
      => ComCall(11, this.p, BSTR.Ptr, retval)
    get_DriverVerDate(retval)
      => ComCall(12, this.p, Float64.Ptr, retval)
    get_DeviceProblemNumber(retval)
      => ComCall(13, this.p, Int32.Ptr, retval)
    get_DeviceStatus(retval)
      => ComCall(14, this.p, Int32.Ptr, retval)
}
struct IWindowsDriverUpdateEntryCollection extends IDispatch {
    static IID := "{0D521700-A372-4BEF-828B-3D00C10ADEBD}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IWindowsDriverUpdateEntry.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct IWindowsDriverUpdate4 extends IWindowsDriverUpdate3 {
    static IID := "{004C6A2B-0C19-4C69-9F5C-A269B2560DB9}"
    get_WindowsDriverUpdateEntries(retval)
      => ComCall(65, this.p, IWindowsDriverUpdateEntryCollection.Ptr, retval)
    get_PerUser(retval)
      => ComCall(66, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IWindowsDriverUpdate5 extends IWindowsDriverUpdate4 {
    static IID := "{70CF5C82-8642-42BB-9DBC-0CFD263C6C4F}"
    get_AutoSelection(retval)
      => ComCall(67, this.p, AutoSelectionMode.Ptr, retval)
    get_AutoDownload(retval)
      => ComCall(68, this.p, AutoDownloadMode.Ptr, retval)
}
struct IUpdateCollection extends IDispatch {
    static IID := "{07F7438C-7709-4CA5-B518-91279288134E}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IUpdate.Ptr, retval)
    put_Item(index, value)
      => ComCall(8, this.p, Int32, index, IUpdate, value)
    get__NewEnum(retval)
      => ComCall(9, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
    get_ReadOnly(retval)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, retval)
    Add(value, retval)
      => ComCall(12, this.p, IUpdate, value, Int32.Ptr, retval)
    Clear()
      => ComCall(13, this.p)
    Copy(retval)
      => ComCall(14, this.p, IUpdateCollection.Ptr, retval)
    Insert(index, value)
      => ComCall(15, this.p, Int32, index, IUpdate, value)
    RemoveAt(index)
      => ComCall(16, this.p, Int32, index)
}
struct IUpdateException extends IDispatch {
    static IID := "{A376DD5E-09D4-427F-AF7C-FED5B6E1C1D6}"
    get_Message(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_HResult(retval)
      => ComCall(8, this.p, Int32.Ptr, retval)
    get_Context(retval)
      => ComCall(9, this.p, UpdateExceptionContext.Ptr, retval)
}
struct IInvalidProductLicenseException extends IUpdateException {
    static IID := "{A37D00F5-7BB0-4953-B414-F9E98326F2E8}"
    get_Product(retval)
      => ComCall(10, this.p, BSTR.Ptr, retval)
}
struct IUpdateExceptionCollection extends IDispatch {
    static IID := "{503626A3-8E14-4729-9355-0FE664BD2321}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IUpdateException.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct ISearchResult extends IDispatch {
    static IID := "{D40CFF62-E08C-4498-941A-01E25F0FD33C}"
    get_ResultCode(retval)
      => ComCall(7, this.p, OperationResultCode.Ptr, retval)
    get_RootCategories(retval)
      => ComCall(8, this.p, ICategoryCollection.Ptr, retval)
    get_Updates(retval)
      => ComCall(9, this.p, IUpdateCollection.Ptr, retval)
    get_Warnings(retval)
      => ComCall(10, this.p, IUpdateExceptionCollection.Ptr, retval)
}
struct ISearchJob extends IDispatch {
    static IID := "{7366EA16-7A1A-4EA2-B042-973D3E9CD99B}"
    get_AsyncState(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    get_IsCompleted(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    CleanUp()
      => ComCall(9, this.p)
    RequestAbort()
      => ComCall(10, this.p)
}
struct ISearchCompletedCallbackArgs extends IDispatch {
    static IID := "{A700A634-2850-4C47-938A-9E4B6E5AF9A6}"
}
struct ISearchCompletedCallback extends IUnknown {
    static IID := "{88AEE058-D4B0-4725-A2F1-814A67AE964C}"
    Invoke(searchJob, callbackArgs)
      => ComCall(3, this.p, ISearchJob, searchJob, ISearchCompletedCallbackArgs, callbackArgs)
}
struct IUpdateHistoryEntry extends IDispatch {
    static IID := "{BE56A644-AF0E-4E0E-A311-C1D8E695CBFF}"
    get_Operation(retval)
      => ComCall(7, this.p, UpdateOperation.Ptr, retval)
    get_ResultCode(retval)
      => ComCall(8, this.p, OperationResultCode.Ptr, retval)
    get_HResult(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    get_Date(retval)
      => ComCall(10, this.p, Float64.Ptr, retval)
    get_UpdateIdentity(retval)
      => ComCall(11, this.p, IUpdateIdentity.Ptr, retval)
    get_Title(retval)
      => ComCall(12, this.p, BSTR.Ptr, retval)
    get_Description(retval)
      => ComCall(13, this.p, BSTR.Ptr, retval)
    get_UnmappedResultCode(retval)
      => ComCall(14, this.p, Int32.Ptr, retval)
    get_ClientApplicationID(retval)
      => ComCall(15, this.p, BSTR.Ptr, retval)
    get_ServerSelection(retval)
      => ComCall(16, this.p, ServerSelection.Ptr, retval)
    get_ServiceID(retval)
      => ComCall(17, this.p, BSTR.Ptr, retval)
    get_UninstallationSteps(retval)
      => ComCall(18, this.p, IStringCollection.Ptr, retval)
    get_UninstallationNotes(retval)
      => ComCall(19, this.p, BSTR.Ptr, retval)
    get_SupportUrl(retval)
      => ComCall(20, this.p, BSTR.Ptr, retval)
}
struct IUpdateHistoryEntry2 extends IUpdateHistoryEntry {
    static IID := "{C2BFB780-4539-4132-AB8C-0A8772013AB6}"
    get_Categories(retval)
      => ComCall(21, this.p, ICategoryCollection.Ptr, retval)
}
struct IUpdateHistoryEntryCollection extends IDispatch {
    static IID := "{A7F04F3C-A290-435B-AADF-A116C3357A5C}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IUpdateHistoryEntry.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct IUpdateSearcher extends IDispatch {
    static IID := "{8F45ABF1-F9AE-4B95-A933-F0F66E5056EA}"
    get_CanAutomaticallyUpgradeService(retval)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, retval)
    put_CanAutomaticallyUpgradeService(value)
      => ComCall(8, this.p, VARIANT_BOOL, value)
    get_ClientApplicationID(retval)
      => ComCall(9, this.p, BSTR.Ptr, retval)
    put_ClientApplicationID(value)
      => ComCall(10, this.p, BSTR, value)
    get_IncludePotentiallySupersededUpdates(retval)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, retval)
    put_IncludePotentiallySupersededUpdates(value)
      => ComCall(12, this.p, VARIANT_BOOL, value)
    get_ServerSelection(retval)
      => ComCall(13, this.p, ServerSelection.Ptr, retval)
    put_ServerSelection(value)
      => ComCall(14, this.p, ServerSelection, value)
    BeginSearch(criteria, onCompleted, state, retval)
      => ComCall(15, this.p, BSTR, criteria, IUnknown, onCompleted, VARIANT, state, ISearchJob.Ptr, retval)
    EndSearch(searchJob, retval)
      => ComCall(16, this.p, ISearchJob, searchJob, ISearchResult.Ptr, retval)
    EscapeString(unescaped, retval)
      => ComCall(17, this.p, BSTR, unescaped, BSTR.Ptr, retval)
    QueryHistory(startIndex, count, retval)
      => ComCall(18, this.p, Int32, startIndex, Int32, count, IUpdateHistoryEntryCollection.Ptr, retval)
    Search(criteria, retval)
      => ComCall(19, this.p, BSTR, criteria, ISearchResult.Ptr, retval)
    get_Online(retval)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, retval)
    put_Online(value)
      => ComCall(21, this.p, VARIANT_BOOL, value)
    GetTotalHistoryCount(retval)
      => ComCall(22, this.p, Int32.Ptr, retval)
    get_ServiceID(retval)
      => ComCall(23, this.p, BSTR.Ptr, retval)
    put_ServiceID(value)
      => ComCall(24, this.p, BSTR, value)
}
struct IUpdateSearcher2 extends IUpdateSearcher {
    static IID := "{4CBDCB2D-1589-4BEB-BD1C-3E582FF0ADD0}"
    get_IgnoreDownloadPriority(retval)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, retval)
    put_IgnoreDownloadPriority(value)
      => ComCall(26, this.p, VARIANT_BOOL, value)
}
struct IUpdateSearcher3 extends IUpdateSearcher2 {
    static IID := "{04C6895D-EAF2-4034-97F3-311DE9BE413A}"
    get_SearchScope(retval)
      => ComCall(27, this.p, SearchScope.Ptr, retval)
    put_SearchScope(value)
      => ComCall(28, this.p, SearchScope, value)
}
struct IUpdateDownloadResult extends IDispatch {
    static IID := "{BF99AF76-B575-42AD-8AA4-33CBB5477AF1}"
    get_HResult(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_ResultCode(retval)
      => ComCall(8, this.p, OperationResultCode.Ptr, retval)
}
struct IDownloadResult extends IDispatch {
    static IID := "{DAA4FDD0-4727-4DBE-A1E7-745DCA317144}"
    get_HResult(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_ResultCode(retval)
      => ComCall(8, this.p, OperationResultCode.Ptr, retval)
    GetUpdateResult(updateIndex, retval)
      => ComCall(9, this.p, Int32, updateIndex, IUpdateDownloadResult.Ptr, retval)
}
struct IDownloadProgress extends IDispatch {
    static IID := "{D31A5BAC-F719-4178-9DBB-5E2CB47FD18A}"
    get_CurrentUpdateBytesDownloaded(retval)
      => ComCall(7, this.p, DECIMAL.Ptr, retval)
    get_CurrentUpdateBytesToDownload(retval)
      => ComCall(8, this.p, DECIMAL.Ptr, retval)
    get_CurrentUpdateIndex(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    get_PercentComplete(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
    get_TotalBytesDownloaded(retval)
      => ComCall(11, this.p, DECIMAL.Ptr, retval)
    get_TotalBytesToDownload(retval)
      => ComCall(12, this.p, DECIMAL.Ptr, retval)
    GetUpdateResult(updateIndex, retval)
      => ComCall(13, this.p, Int32, updateIndex, IUpdateDownloadResult.Ptr, retval)
    get_CurrentUpdateDownloadPhase(retval)
      => ComCall(14, this.p, DownloadPhase.Ptr, retval)
    get_CurrentUpdatePercentComplete(retval)
      => ComCall(15, this.p, Int32.Ptr, retval)
}
struct IDownloadJob extends IDispatch {
    static IID := "{C574DE85-7358-43F6-AAE8-8697E62D8BA7}"
    get_AsyncState(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    get_IsCompleted(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    get_Updates(retval)
      => ComCall(9, this.p, IUpdateCollection.Ptr, retval)
    CleanUp()
      => ComCall(10, this.p)
    GetProgress(retval)
      => ComCall(11, this.p, IDownloadProgress.Ptr, retval)
    RequestAbort()
      => ComCall(12, this.p)
}
struct IDownloadCompletedCallbackArgs extends IDispatch {
    static IID := "{FA565B23-498C-47A0-979D-E7D5B1813360}"
}
struct IDownloadCompletedCallback extends IUnknown {
    static IID := "{77254866-9F5B-4C8E-B9E2-C77A8530D64B}"
    Invoke(downloadJob, callbackArgs)
      => ComCall(3, this.p, IDownloadJob, downloadJob, IDownloadCompletedCallbackArgs, callbackArgs)
}
struct IDownloadProgressChangedCallbackArgs extends IDispatch {
    static IID := "{324FF2C6-4981-4B04-9412-57481745AB24}"
    get_Progress(retval)
      => ComCall(7, this.p, IDownloadProgress.Ptr, retval)
}
struct IDownloadProgressChangedCallback extends IUnknown {
    static IID := "{8C3F1CDD-6173-4591-AEBD-A56A53CA77C1}"
    Invoke(downloadJob, callbackArgs)
      => ComCall(3, this.p, IDownloadJob, downloadJob, IDownloadProgressChangedCallbackArgs, callbackArgs)
}
struct IUpdateDownloader extends IDispatch {
    static IID := "{68F1C6F9-7ECC-4666-A464-247FE12496C3}"
    get_ClientApplicationID(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ClientApplicationID(value)
      => ComCall(8, this.p, BSTR, value)
    get_IsForced(retval)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, retval)
    put_IsForced(value)
      => ComCall(10, this.p, VARIANT_BOOL, value)
    get_Priority(retval)
      => ComCall(11, this.p, DownloadPriority.Ptr, retval)
    put_Priority(value)
      => ComCall(12, this.p, DownloadPriority, value)
    get_Updates(retval)
      => ComCall(13, this.p, IUpdateCollection.Ptr, retval)
    put_Updates(value)
      => ComCall(14, this.p, IUpdateCollection, value)
    BeginDownload(onProgressChanged, onCompleted, state, retval)
      => ComCall(15, this.p, IUnknown, onProgressChanged, IUnknown, onCompleted, VARIANT, state, IDownloadJob.Ptr, retval)
    Download(retval)
      => ComCall(16, this.p, IDownloadResult.Ptr, retval)
    EndDownload(value, retval)
      => ComCall(17, this.p, IDownloadJob, value, IDownloadResult.Ptr, retval)
}
struct IUpdateDownloaderEx extends IUpdateDownloader {
    static IID := "{94726306-F12A-482A-A774-FB4F870D98C0}"
    BeginDownload2(downloadType1, onProgressChanged, onCompleted, state, retval)
      => ComCall(18, this.p, DownloadType, downloadType1, IUnknown, onProgressChanged, IUnknown, onCompleted, VARIANT, state, IDownloadJob.Ptr, retval)
    Download2(downloadType1, retval)
      => ComCall(19, this.p, DownloadType, downloadType1, IDownloadResult.Ptr, retval)
}
struct IUpdateInstallationResult extends IDispatch {
    static IID := "{D940F0F8-3CBB-4FD0-993F-471E7F2328AD}"
    get_HResult(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_RebootRequired(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    get_ResultCode(retval)
      => ComCall(9, this.p, OperationResultCode.Ptr, retval)
}
struct IInstallationResult extends IDispatch {
    static IID := "{A43C56D6-7451-48D4-AF96-B6CD2D0D9B7A}"
    get_HResult(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_RebootRequired(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    get_ResultCode(retval)
      => ComCall(9, this.p, OperationResultCode.Ptr, retval)
    GetUpdateResult(updateIndex, retval)
      => ComCall(10, this.p, Int32, updateIndex, IUpdateInstallationResult.Ptr, retval)
}
struct IInstallationProgress extends IDispatch {
    static IID := "{345C8244-43A3-4E32-A368-65F073B76F36}"
    get_CurrentUpdateIndex(retval)
      => ComCall(7, this.p, Int32.Ptr, retval)
    get_CurrentUpdatePercentComplete(retval)
      => ComCall(8, this.p, Int32.Ptr, retval)
    get_PercentComplete(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    GetUpdateResult(updateIndex, retval)
      => ComCall(10, this.p, Int32, updateIndex, IUpdateInstallationResult.Ptr, retval)
}
struct IInstallationJob extends IDispatch {
    static IID := "{5C209F0B-BAD5-432A-9556-4699BED2638A}"
    get_AsyncState(retval)
      => ComCall(7, this.p, VARIANT.Ptr, retval)
    get_IsCompleted(retval)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, retval)
    get_Updates(retval)
      => ComCall(9, this.p, IUpdateCollection.Ptr, retval)
    CleanUp()
      => ComCall(10, this.p)
    GetProgress(retval)
      => ComCall(11, this.p, IInstallationProgress.Ptr, retval)
    RequestAbort()
      => ComCall(12, this.p)
}
struct IInstallationCompletedCallbackArgs extends IDispatch {
    static IID := "{250E2106-8EFB-4705-9653-EF13C581B6A1}"
}
struct IInstallationCompletedCallback extends IUnknown {
    static IID := "{45F4F6F3-D602-4F98-9A8A-3EFA152AD2D3}"
    Invoke(installationJob, callbackArgs)
      => ComCall(3, this.p, IInstallationJob, installationJob, IInstallationCompletedCallbackArgs, callbackArgs)
}
struct IInstallationProgressChangedCallbackArgs extends IDispatch {
    static IID := "{E4F14E1E-689D-4218-A0B9-BC189C484A01}"
    get_Progress(retval)
      => ComCall(7, this.p, IInstallationProgress.Ptr, retval)
}
struct IInstallationProgressChangedCallback extends IUnknown {
    static IID := "{E01402D5-F8DA-43BA-A012-38894BD048F1}"
    Invoke(installationJob, callbackArgs)
      => ComCall(3, this.p, IInstallationJob, installationJob, IInstallationProgressChangedCallbackArgs, callbackArgs)
}
struct IUpdateInstaller extends IDispatch {
    static IID := "{7B929C68-CCDC-4226-96B1-8724600B54C2}"
    get_ClientApplicationID(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ClientApplicationID(value)
      => ComCall(8, this.p, BSTR, value)
    get_IsForced(retval)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, retval)
    put_IsForced(value)
      => ComCall(10, this.p, VARIANT_BOOL, value)
    get_ParentHwnd(retval)
      => ComCall(11, this.p, HWND.Ptr, retval)
    put_ParentHwnd(value)
      => ComCall(12, this.p, HWND, value)
    put_ParentWindow(value)
      => ComCall(13, this.p, IUnknown, value)
    get_ParentWindow(retval)
      => ComCall(14, this.p, IUnknown.Ptr, retval)
    get_Updates(retval)
      => ComCall(15, this.p, IUpdateCollection.Ptr, retval)
    put_Updates(value)
      => ComCall(16, this.p, IUpdateCollection, value)
    BeginInstall(onProgressChanged, onCompleted, state, retval)
      => ComCall(17, this.p, IUnknown, onProgressChanged, IUnknown, onCompleted, VARIANT, state, IInstallationJob.Ptr, retval)
    BeginUninstall(onProgressChanged, onCompleted, state, retval)
      => ComCall(18, this.p, IUnknown, onProgressChanged, IUnknown, onCompleted, VARIANT, state, IInstallationJob.Ptr, retval)
    EndInstall(value, retval)
      => ComCall(19, this.p, IInstallationJob, value, IInstallationResult.Ptr, retval)
    EndUninstall(value, retval)
      => ComCall(20, this.p, IInstallationJob, value, IInstallationResult.Ptr, retval)
    Install(retval)
      => ComCall(21, this.p, IInstallationResult.Ptr, retval)
    RunWizard(dialogTitle, retval)
      => ComCall(22, this.p, BSTR, dialogTitle, IInstallationResult.Ptr, retval)
    get_IsBusy(retval)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, retval)
    Uninstall(retval)
      => ComCall(24, this.p, IInstallationResult.Ptr, retval)
    get_AllowSourcePrompts(retval)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, retval)
    put_AllowSourcePrompts(value)
      => ComCall(26, this.p, VARIANT_BOOL, value)
    get_RebootRequiredBeforeInstallation(retval)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdateInstaller2 extends IUpdateInstaller {
    static IID := "{3442D4FE-224D-4CEE-98CF-30E0C4D229E6}"
    get_ForceQuiet(retval)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, retval)
    put_ForceQuiet(value)
      => ComCall(29, this.p, VARIANT_BOOL, value)
}
struct IUpdateInstaller3 extends IUpdateInstaller2 {
    static IID := "{16D11C35-099A-48D0-8338-5FAE64047F8E}"
    get_AttemptCloseAppsIfNecessary(retval)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, retval)
    put_AttemptCloseAppsIfNecessary(value)
      => ComCall(31, this.p, VARIANT_BOOL, value)
}
struct IUpdateInstaller4 extends IUpdateInstaller3 {
    static IID := "{EF8208EA-2304-492D-9109-23813B0958E1}"
    Commit(dwFlags)
      => ComCall(32, this.p, UInt32, dwFlags)
}
struct IUpdateSession extends IDispatch {
    static IID := "{816858A4-260D-4260-933A-2585F1ABC76B}"
    get_ClientApplicationID(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    put_ClientApplicationID(value)
      => ComCall(8, this.p, BSTR, value)
    get_ReadOnly(retval)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, retval)
    get_WebProxy(retval)
      => ComCall(10, this.p, IWebProxy.Ptr, retval)
    put_WebProxy(value)
      => ComCall(11, this.p, IWebProxy, value)
    CreateUpdateSearcher(retval)
      => ComCall(12, this.p, IUpdateSearcher.Ptr, retval)
    CreateUpdateDownloader(retval)
      => ComCall(13, this.p, IUpdateDownloader.Ptr, retval)
    CreateUpdateInstaller(retval)
      => ComCall(14, this.p, IUpdateInstaller.Ptr, retval)
}
struct IUpdateSession2 extends IUpdateSession {
    static IID := "{91CAF7B0-EB23-49ED-9937-C52D817F46F7}"
    get_UserLocale(retval)
      => ComCall(15, this.p, UInt32.Ptr, retval)
    put_UserLocale(lcid)
      => ComCall(16, this.p, UInt32, lcid)
}
struct IUpdateSession3 extends IUpdateSession2 {
    static IID := "{918EFD1E-B5D8-4C90-8540-AEB9BDC56F9D}"
    CreateUpdateServiceManager(retval)
      => ComCall(17, this.p, IUpdateServiceManager2.Ptr, retval)
    QueryHistory(criteria, startIndex, count, retval)
      => ComCall(18, this.p, BSTR, criteria, Int32, startIndex, Int32, count, IUpdateHistoryEntryCollection.Ptr, retval)
}
struct IUpdateService extends IDispatch {
    static IID := "{76B3B17E-AED6-4DA5-85F0-83587F81ABE3}"
    get_Name(retval)
      => ComCall(7, this.p, BSTR.Ptr, retval)
    get_ContentValidationCert(retval)
      => ComCall(8, this.p, VARIANT.Ptr, retval)
    get_ExpirationDate(retval)
      => ComCall(9, this.p, Float64.Ptr, retval)
    get_IsManaged(retval)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, retval)
    get_IsRegisteredWithAU(retval)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, retval)
    get_IssueDate(retval)
      => ComCall(12, this.p, Float64.Ptr, retval)
    get_OffersWindowsUpdates(retval)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, retval)
    get_RedirectUrls(retval)
      => ComCall(14, this.p, IStringCollection.Ptr, retval)
    get_ServiceID(retval)
      => ComCall(15, this.p, BSTR.Ptr, retval)
    get_IsScanPackageService(retval)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, retval)
    get_CanRegisterWithAU(retval)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, retval)
    get_ServiceUrl(retval)
      => ComCall(18, this.p, BSTR.Ptr, retval)
    get_SetupPrefix(retval)
      => ComCall(19, this.p, BSTR.Ptr, retval)
}
struct IUpdateService2 extends IUpdateService {
    static IID := "{1518B460-6518-4172-940F-C75883B24CEB}"
    get_IsDefaultAUService(retval)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, retval)
}
struct IUpdateServiceCollection extends IDispatch {
    static IID := "{9B0353AA-0E52-44FF-B8B0-1F7FA0437F88}"
    get_Item(index, retval)
      => ComCall(7, this.p, Int32, index, IUpdateService.Ptr, retval)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Count(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
}
struct IUpdateServiceRegistration extends IDispatch {
    static IID := "{DDE02280-12B3-4E0B-937B-6747F6ACB286}"
    get_RegistrationState(retval)
      => ComCall(7, this.p, UpdateServiceRegistrationState.Ptr, retval)
    get_ServiceID(retval)
      => ComCall(8, this.p, BSTR.Ptr, retval)
    get_IsPendingRegistrationWithAU(retval)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, retval)
    get_Service(retval)
      => ComCall(10, this.p, IUpdateService2.Ptr, retval)
}
struct IUpdateServiceManager extends IDispatch {
    static IID := "{23857E3C-02BA-44A3-9423-B1C900805F37}"
    get_Services(retval)
      => ComCall(7, this.p, IUpdateServiceCollection.Ptr, retval)
    AddService(serviceID, authorizationCabPath, retval)
      => ComCall(8, this.p, BSTR, serviceID, BSTR, authorizationCabPath, IUpdateService.Ptr, retval)
    RegisterServiceWithAU(serviceID)
      => ComCall(9, this.p, BSTR, serviceID)
    RemoveService(serviceID)
      => ComCall(10, this.p, BSTR, serviceID)
    UnregisterServiceWithAU(serviceID)
      => ComCall(11, this.p, BSTR, serviceID)
    AddScanPackageService(serviceName, scanFileLocation, flags, ppService)
      => ComCall(12, this.p, BSTR, serviceName, BSTR, scanFileLocation, Int32, flags, IUpdateService.Ptr, ppService)
    SetOption(optionName, optionValue)
      => ComCall(13, this.p, BSTR, optionName, VARIANT, optionValue)
}
struct IUpdateServiceManager2 extends IUpdateServiceManager {
    static IID := "{0BB8531D-7E8D-424F-986C-A0B8F60A3E7B}"
    get_ClientApplicationID(retval)
      => ComCall(14, this.p, BSTR.Ptr, retval)
    put_ClientApplicationID(value)
      => ComCall(15, this.p, BSTR, value)
    QueryServiceRegistration(serviceID, retval)
      => ComCall(16, this.p, BSTR, serviceID, IUpdateServiceRegistration.Ptr, retval)
    AddService2(serviceID, flags, authorizationCabPath, retval)
      => ComCall(17, this.p, BSTR, serviceID, Int32, flags, BSTR, authorizationCabPath, IUpdateServiceRegistration.Ptr, retval)
}
struct IInstallationAgent extends IDispatch {
    static IID := "{925CBC18-A2EA-4648-BF1C-EC8BADCFE20A}"
    RecordInstallationResult(installationResultCookie, hresult, extendedReportingData)
      => ComCall(7, this.p, BSTR, installationResultCookie, Int32, hresult, IStringCollection, extendedReportingData)
}
struct UpdateLockdownOption extends Int32 {
    static uloForWebsiteAccess := 1
}
struct AddServiceFlag extends Int32 {
    static asfAllowPendingRegistration := 1
    static asfAllowOnlineRegistration := 2
    static asfRegisterServiceWithAU := 4
}
struct UpdateServiceOption extends Int32 {
    static usoNonVolatileService := 1
}
