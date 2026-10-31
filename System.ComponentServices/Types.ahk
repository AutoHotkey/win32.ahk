#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\Security\Types.ahk" {PSID}
#Import "..\System.Com\Types.ahk" {BLOB, IClassFactory, IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.DistributedTransactionCoordinator\Types.ahk" {ITransaction, ITransactionVoterBallotAsync2, ITransactionVoterNotifyAsync2}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct ICOMAdminCatalog extends IDispatch {
    static IID := "{DD662187-DFC2-11D1-A2CF-00805FC79235}"
    GetCollection(bstrCollName, ppCatalogCollection)
      => ComCall(7, this.p, BSTR, bstrCollName, IDispatch.Ptr, ppCatalogCollection)
    Connect(bstrCatalogServerName, ppCatalogCollection)
      => ComCall(8, this.p, BSTR, bstrCatalogServerName, IDispatch.Ptr, ppCatalogCollection)
    get_MajorVersion(plMajorVersion)
      => ComCall(9, this.p, Int32.Ptr, plMajorVersion)
    get_MinorVersion(plMinorVersion)
      => ComCall(10, this.p, Int32.Ptr, plMinorVersion)
    GetCollectionByQuery(bstrCollName, ppsaVarQuery, ppCatalogCollection)
      => ComCall(11, this.p, BSTR, bstrCollName, SAFEARRAY.Ptr.Ptr, ppsaVarQuery, IDispatch.Ptr, ppCatalogCollection)
    ImportComponent(bstrApplIDOrName, bstrCLSIDOrProgID)
      => ComCall(12, this.p, BSTR, bstrApplIDOrName, BSTR, bstrCLSIDOrProgID)
    InstallComponent(bstrApplIDOrName, bstrDLL, bstrTLB, bstrPSDLL)
      => ComCall(13, this.p, BSTR, bstrApplIDOrName, BSTR, bstrDLL, BSTR, bstrTLB, BSTR, bstrPSDLL)
    ShutdownApplication(bstrApplIDOrName)
      => ComCall(14, this.p, BSTR, bstrApplIDOrName)
    ExportApplication(bstrApplIDOrName, bstrApplicationFile, lOptions)
      => ComCall(15, this.p, BSTR, bstrApplIDOrName, BSTR, bstrApplicationFile, COMAdminApplicationExportOptions, lOptions)
    InstallApplication(bstrApplicationFile, bstrDestinationDirectory, lOptions, bstrUserId, bstrPassword, bstrRSN)
      => ComCall(16, this.p, BSTR, bstrApplicationFile, BSTR, bstrDestinationDirectory, COMAdminApplicationInstallOptions, lOptions, BSTR, bstrUserId, BSTR, bstrPassword, BSTR, bstrRSN)
    StopRouter()
      => ComCall(17, this.p)
    RefreshRouter()
      => ComCall(18, this.p)
    StartRouter()
      => ComCall(19, this.p)
    Reserved1()
      => ComCall(20, this.p)
    Reserved2()
      => ComCall(21, this.p)
    InstallMultipleComponents(bstrApplIDOrName, ppsaVarFileNames, ppsaVarCLSIDs)
      => ComCall(22, this.p, BSTR, bstrApplIDOrName, SAFEARRAY.Ptr.Ptr, ppsaVarFileNames, SAFEARRAY.Ptr.Ptr, ppsaVarCLSIDs)
    GetMultipleComponentsInfo(bstrApplIdOrName, ppsaVarFileNames, ppsaVarCLSIDs, ppsaVarClassNames, ppsaVarFileFlags, ppsaVarComponentFlags)
      => ComCall(23, this.p, BSTR, bstrApplIdOrName, SAFEARRAY.Ptr.Ptr, ppsaVarFileNames, SAFEARRAY.Ptr.Ptr, ppsaVarCLSIDs, SAFEARRAY.Ptr.Ptr, ppsaVarClassNames, SAFEARRAY.Ptr.Ptr, ppsaVarFileFlags, SAFEARRAY.Ptr.Ptr, ppsaVarComponentFlags)
    RefreshComponents()
      => ComCall(24, this.p)
    BackupREGDB(bstrBackupFilePath)
      => ComCall(25, this.p, BSTR, bstrBackupFilePath)
    RestoreREGDB(bstrBackupFilePath)
      => ComCall(26, this.p, BSTR, bstrBackupFilePath)
    QueryApplicationFile(bstrApplicationFile, pbstrApplicationName, pbstrApplicationDescription, pbHasUsers, pbIsProxy, ppsaVarFileNames)
      => ComCall(27, this.p, BSTR, bstrApplicationFile, BSTR.Ptr, pbstrApplicationName, BSTR.Ptr, pbstrApplicationDescription, VARIANT_BOOL.Ptr, pbHasUsers, VARIANT_BOOL.Ptr, pbIsProxy, SAFEARRAY.Ptr.Ptr, ppsaVarFileNames)
    StartApplication(bstrApplIdOrName)
      => ComCall(28, this.p, BSTR, bstrApplIdOrName)
    ServiceCheck(lService, plStatus)
      => ComCall(29, this.p, Int32, lService, Int32.Ptr, plStatus)
    InstallMultipleEventClasses(bstrApplIdOrName, ppsaVarFileNames, ppsaVarCLSIDS)
      => ComCall(30, this.p, BSTR, bstrApplIdOrName, SAFEARRAY.Ptr.Ptr, ppsaVarFileNames, SAFEARRAY.Ptr.Ptr, ppsaVarCLSIDS)
    InstallEventClass(bstrApplIdOrName, bstrDLL, bstrTLB, bstrPSDLL)
      => ComCall(31, this.p, BSTR, bstrApplIdOrName, BSTR, bstrDLL, BSTR, bstrTLB, BSTR, bstrPSDLL)
    GetEventClassesForIID(bstrIID, ppsaVarCLSIDs, ppsaVarProgIDs, ppsaVarDescriptions)
      => ComCall(32, this.p, BSTR, bstrIID, SAFEARRAY.Ptr.Ptr, ppsaVarCLSIDs, SAFEARRAY.Ptr.Ptr, ppsaVarProgIDs, SAFEARRAY.Ptr.Ptr, ppsaVarDescriptions)
}
struct COMAdminInUse extends Int32 {
    static COMAdminNotInUse := 0
    static COMAdminInUseByCatalog := 1
    static COMAdminInUseByRegistryUnknown := 2
    static COMAdminInUseByRegistryProxyStub := 3
    static COMAdminInUseByRegistryTypeLib := 4
    static COMAdminInUseByRegistryClsid := 5
}
struct ICOMAdminCatalog2 extends ICOMAdminCatalog {
    static IID := "{790C6E0B-9194-4CC9-9426-A48A63185696}"
    GetCollectionByQuery2(bstrCollectionName, pVarQueryStrings, ppCatalogCollection)
      => ComCall(33, this.p, BSTR, bstrCollectionName, VARIANT.Ptr, pVarQueryStrings, IDispatch.Ptr, ppCatalogCollection)
    GetApplicationInstanceIDFromProcessID(lProcessID, pbstrApplicationInstanceID)
      => ComCall(34, this.p, Int32, lProcessID, BSTR.Ptr, pbstrApplicationInstanceID)
    ShutdownApplicationInstances(pVarApplicationInstanceID)
      => ComCall(35, this.p, VARIANT.Ptr, pVarApplicationInstanceID)
    PauseApplicationInstances(pVarApplicationInstanceID)
      => ComCall(36, this.p, VARIANT.Ptr, pVarApplicationInstanceID)
    ResumeApplicationInstances(pVarApplicationInstanceID)
      => ComCall(37, this.p, VARIANT.Ptr, pVarApplicationInstanceID)
    RecycleApplicationInstances(pVarApplicationInstanceID, lReasonCode)
      => ComCall(38, this.p, VARIANT.Ptr, pVarApplicationInstanceID, Int32, lReasonCode)
    AreApplicationInstancesPaused(pVarApplicationInstanceID, pVarBoolPaused)
      => ComCall(39, this.p, VARIANT.Ptr, pVarApplicationInstanceID, VARIANT_BOOL.Ptr, pVarBoolPaused)
    DumpApplicationInstance(bstrApplicationInstanceID, bstrDirectory, lMaxImages, pbstrDumpFile)
      => ComCall(40, this.p, BSTR, bstrApplicationInstanceID, BSTR, bstrDirectory, Int32, lMaxImages, BSTR.Ptr, pbstrDumpFile)
    get_IsApplicationInstanceDumpSupported(pVarBoolDumpSupported)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pVarBoolDumpSupported)
    CreateServiceForApplication(bstrApplicationIDOrName, bstrServiceName, bstrStartType, bstrErrorControl, bstrDependencies, bstrRunAs, bstrPassword, bDesktopOk)
      => ComCall(42, this.p, BSTR, bstrApplicationIDOrName, BSTR, bstrServiceName, BSTR, bstrStartType, BSTR, bstrErrorControl, BSTR, bstrDependencies, BSTR, bstrRunAs, BSTR, bstrPassword, VARIANT_BOOL, bDesktopOk)
    DeleteServiceForApplication(bstrApplicationIDOrName)
      => ComCall(43, this.p, BSTR, bstrApplicationIDOrName)
    GetPartitionID(bstrApplicationIDOrName, pbstrPartitionID)
      => ComCall(44, this.p, BSTR, bstrApplicationIDOrName, BSTR.Ptr, pbstrPartitionID)
    GetPartitionName(bstrApplicationIDOrName, pbstrPartitionName)
      => ComCall(45, this.p, BSTR, bstrApplicationIDOrName, BSTR.Ptr, pbstrPartitionName)
    put_CurrentPartition(bstrPartitionIDOrName)
      => ComCall(46, this.p, BSTR, bstrPartitionIDOrName)
    get_CurrentPartitionID(pbstrPartitionID)
      => ComCall(47, this.p, BSTR.Ptr, pbstrPartitionID)
    get_CurrentPartitionName(pbstrPartitionName)
      => ComCall(48, this.p, BSTR.Ptr, pbstrPartitionName)
    get_GlobalPartitionID(pbstrGlobalPartitionID)
      => ComCall(49, this.p, BSTR.Ptr, pbstrGlobalPartitionID)
    FlushPartitionCache()
      => ComCall(50, this.p)
    CopyApplications(bstrSourcePartitionIDOrName, pVarApplicationID, bstrDestinationPartitionIDOrName)
      => ComCall(51, this.p, BSTR, bstrSourcePartitionIDOrName, VARIANT.Ptr, pVarApplicationID, BSTR, bstrDestinationPartitionIDOrName)
    CopyComponents(bstrSourceApplicationIDOrName, pVarCLSIDOrProgID, bstrDestinationApplicationIDOrName)
      => ComCall(52, this.p, BSTR, bstrSourceApplicationIDOrName, VARIANT.Ptr, pVarCLSIDOrProgID, BSTR, bstrDestinationApplicationIDOrName)
    MoveComponents(bstrSourceApplicationIDOrName, pVarCLSIDOrProgID, bstrDestinationApplicationIDOrName)
      => ComCall(53, this.p, BSTR, bstrSourceApplicationIDOrName, VARIANT.Ptr, pVarCLSIDOrProgID, BSTR, bstrDestinationApplicationIDOrName)
    AliasComponent(bstrSrcApplicationIDOrName, bstrCLSIDOrProgID, bstrDestApplicationIDOrName, bstrNewProgId, bstrNewClsid)
      => ComCall(54, this.p, BSTR, bstrSrcApplicationIDOrName, BSTR, bstrCLSIDOrProgID, BSTR, bstrDestApplicationIDOrName, BSTR, bstrNewProgId, BSTR, bstrNewClsid)
    IsSafeToDelete(bstrDllName, pCOMAdminInUse)
      => ComCall(55, this.p, BSTR, bstrDllName, COMAdminInUse.Ptr, pCOMAdminInUse)
    ImportUnconfiguredComponents(bstrApplicationIDOrName, pVarCLSIDOrProgID, pVarComponentType)
      => ComCall(56, this.p, BSTR, bstrApplicationIDOrName, VARIANT.Ptr, pVarCLSIDOrProgID, VARIANT.Ptr, pVarComponentType)
    PromoteUnconfiguredComponents(bstrApplicationIDOrName, pVarCLSIDOrProgID, pVarComponentType)
      => ComCall(57, this.p, BSTR, bstrApplicationIDOrName, VARIANT.Ptr, pVarCLSIDOrProgID, VARIANT.Ptr, pVarComponentType)
    ImportComponents(bstrApplicationIDOrName, pVarCLSIDOrProgID, pVarComponentType)
      => ComCall(58, this.p, BSTR, bstrApplicationIDOrName, VARIANT.Ptr, pVarCLSIDOrProgID, VARIANT.Ptr, pVarComponentType)
    get_Is64BitCatalogServer(pbIs64Bit)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, pbIs64Bit)
    ExportPartition(bstrPartitionIDOrName, bstrPartitionFileName, lOptions)
      => ComCall(60, this.p, BSTR, bstrPartitionIDOrName, BSTR, bstrPartitionFileName, COMAdminApplicationExportOptions, lOptions)
    InstallPartition(bstrFileName, bstrDestDirectory, lOptions, bstrUserID, bstrPassword, bstrRSN)
      => ComCall(61, this.p, BSTR, bstrFileName, BSTR, bstrDestDirectory, COMAdminApplicationInstallOptions, lOptions, BSTR, bstrUserID, BSTR, bstrPassword, BSTR, bstrRSN)
    QueryApplicationFile2(bstrApplicationFile, ppFilesForImport)
      => ComCall(62, this.p, BSTR, bstrApplicationFile, IDispatch.Ptr, ppFilesForImport)
    GetComponentVersionCount(bstrCLSIDOrProgID, plVersionCount)
      => ComCall(63, this.p, BSTR, bstrCLSIDOrProgID, Int32.Ptr, plVersionCount)
}
struct ICatalogObject extends IDispatch {
    static IID := "{6EB22871-8A19-11D0-81B6-00A0C9231C29}"
    get_Value(bstrPropName, pvarRetVal)
      => ComCall(7, this.p, BSTR, bstrPropName, VARIANT.Ptr, pvarRetVal)
    put_Value(bstrPropName, val)
      => ComCall(8, this.p, BSTR, bstrPropName, VARIANT, val)
    get_Key(pvarRetVal)
      => ComCall(9, this.p, VARIANT.Ptr, pvarRetVal)
    get_Name(pvarRetVal)
      => ComCall(10, this.p, VARIANT.Ptr, pvarRetVal)
    IsPropertyReadOnly(bstrPropName, pbRetVal)
      => ComCall(11, this.p, BSTR, bstrPropName, VARIANT_BOOL.Ptr, pbRetVal)
    get_Valid(pbRetVal)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pbRetVal)
    IsPropertyWriteOnly(bstrPropName, pbRetVal)
      => ComCall(13, this.p, BSTR, bstrPropName, VARIANT_BOOL.Ptr, pbRetVal)
}
struct ICatalogCollection extends IDispatch {
    static IID := "{6EB22872-8A19-11D0-81B6-00A0C9231C29}"
    get__NewEnum(ppEnumVariant)
      => ComCall(7, this.p, IUnknown.Ptr, ppEnumVariant)
    get_Item(lIndex, ppCatalogObject)
      => ComCall(8, this.p, Int32, lIndex, IDispatch.Ptr, ppCatalogObject)
    get_Count(plObjectCount)
      => ComCall(9, this.p, Int32.Ptr, plObjectCount)
    Remove(lIndex)
      => ComCall(10, this.p, Int32, lIndex)
    Add(ppCatalogObject)
      => ComCall(11, this.p, IDispatch.Ptr, ppCatalogObject)
    Populate()
      => ComCall(12, this.p)
    SaveChanges(pcChanges)
      => ComCall(13, this.p, Int32.Ptr, pcChanges)
    GetCollection(bstrCollName, varObjectKey, ppCatalogCollection)
      => ComCall(14, this.p, BSTR, bstrCollName, VARIANT, varObjectKey, IDispatch.Ptr, ppCatalogCollection)
    get_Name(pVarNamel)
      => ComCall(15, this.p, VARIANT.Ptr, pVarNamel)
    get_AddEnabled(pVarBool)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pVarBool)
    get_RemoveEnabled(pVarBool)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pVarBool)
    GetUtilInterface(ppIDispatch)
      => ComCall(18, this.p, IDispatch.Ptr, ppIDispatch)
    get_DataStoreMajorVersion(plMajorVersion)
      => ComCall(19, this.p, Int32.Ptr, plMajorVersion)
    get_DataStoreMinorVersion(plMinorVersionl)
      => ComCall(20, this.p, Int32.Ptr, plMinorVersionl)
    PopulateByKey(psaKeys)
      => ComCall(21, this.p, SAFEARRAY.Ptr, psaKeys)
    PopulateByQuery(bstrQueryString, lQueryType)
      => ComCall(22, this.p, BSTR, bstrQueryString, Int32, lQueryType)
}
struct COMAdminComponentType extends Int32 {
    static COMAdmin32BitComponent := 1
    static COMAdmin64BitComponent := 2
}
struct COMAdminApplicationInstallOptions extends Int32 {
    static COMAdminInstallNoUsers := 0
    static COMAdminInstallUsers := 1
    static COMAdminInstallForceOverwriteOfFiles := 2
}
struct COMAdminApplicationExportOptions extends Int32 {
    static COMAdminExportNoUsers := 0
    static COMAdminExportUsers := 1
    static COMAdminExportApplicationProxy := 2
    static COMAdminExportForceOverwriteOfFiles := 4
    static COMAdminExportIn10Format := 16
}
struct COMAdminThreadingModels extends Int32 {
    static COMAdminThreadingModelApartment := 0
    static COMAdminThreadingModelFree := 1
    static COMAdminThreadingModelMain := 2
    static COMAdminThreadingModelBoth := 3
    static COMAdminThreadingModelNeutral := 4
    static COMAdminThreadingModelNotSpecified := 5
}
struct COMAdminTransactionOptions extends Int32 {
    static COMAdminTransactionIgnored := 0
    static COMAdminTransactionNone := 1
    static COMAdminTransactionSupported := 2
    static COMAdminTransactionRequired := 3
    static COMAdminTransactionRequiresNew := 4
}
struct COMAdminTxIsolationLevelOptions extends Int32 {
    static COMAdminTxIsolationLevelAny := 0
    static COMAdminTxIsolationLevelReadUnCommitted := 1
    static COMAdminTxIsolationLevelReadCommitted := 2
    static COMAdminTxIsolationLevelRepeatableRead := 3
    static COMAdminTxIsolationLevelSerializable := 4
}
struct COMAdminSynchronizationOptions extends Int32 {
    static COMAdminSynchronizationIgnored := 0
    static COMAdminSynchronizationNone := 1
    static COMAdminSynchronizationSupported := 2
    static COMAdminSynchronizationRequired := 3
    static COMAdminSynchronizationRequiresNew := 4
}
struct COMAdminActivationOptions extends Int32 {
    static COMAdminActivationInproc := 0
    static COMAdminActivationLocal := 1
}
struct COMAdminAccessChecksLevelOptions extends Int32 {
    static COMAdminAccessChecksApplicationLevel := 0
    static COMAdminAccessChecksApplicationComponentLevel := 1
}
struct COMAdminAuthenticationLevelOptions extends Int32 {
    static COMAdminAuthenticationDefault := 0
    static COMAdminAuthenticationNone := 1
    static COMAdminAuthenticationConnect := 2
    static COMAdminAuthenticationCall := 3
    static COMAdminAuthenticationPacket := 4
    static COMAdminAuthenticationIntegrity := 5
    static COMAdminAuthenticationPrivacy := 6
}
struct COMAdminImpersonationLevelOptions extends Int32 {
    static COMAdminImpersonationAnonymous := 1
    static COMAdminImpersonationIdentify := 2
    static COMAdminImpersonationImpersonate := 3
    static COMAdminImpersonationDelegate := 4
}
struct COMAdminAuthenticationCapabilitiesOptions extends Int32 {
    static COMAdminAuthenticationCapabilitiesNone := 0
    static COMAdminAuthenticationCapabilitiesSecureReference := 2
    static COMAdminAuthenticationCapabilitiesStaticCloaking := 32
    static COMAdminAuthenticationCapabilitiesDynamicCloaking := 64
}
struct COMAdminOS extends Int32 {
    static COMAdminOSNotInitialized := 0
    static COMAdminOSWindows3_1 := 1
    static COMAdminOSWindows9x := 2
    static COMAdminOSWindows2000 := 3
    static COMAdminOSWindows2000AdvancedServer := 4
    static COMAdminOSWindows2000Unknown := 5
    static COMAdminOSUnknown := 6
    static COMAdminOSWindowsXPPersonal := 11
    static COMAdminOSWindowsXPProfessional := 12
    static COMAdminOSWindowsNETStandardServer := 13
    static COMAdminOSWindowsNETEnterpriseServer := 14
    static COMAdminOSWindowsNETDatacenterServer := 15
    static COMAdminOSWindowsNETWebServer := 16
    static COMAdminOSWindowsLonghornPersonal := 17
    static COMAdminOSWindowsLonghornProfessional := 18
    static COMAdminOSWindowsLonghornStandardServer := 19
    static COMAdminOSWindowsLonghornEnterpriseServer := 20
    static COMAdminOSWindowsLonghornDatacenterServer := 21
    static COMAdminOSWindowsLonghornWebServer := 22
    static COMAdminOSWindows7Personal := 23
    static COMAdminOSWindows7Professional := 24
    static COMAdminOSWindows7StandardServer := 25
    static COMAdminOSWindows7EnterpriseServer := 26
    static COMAdminOSWindows7DatacenterServer := 27
    static COMAdminOSWindows7WebServer := 28
    static COMAdminOSWindows8Personal := 29
    static COMAdminOSWindows8Professional := 30
    static COMAdminOSWindows8StandardServer := 31
    static COMAdminOSWindows8EnterpriseServer := 32
    static COMAdminOSWindows8DatacenterServer := 33
    static COMAdminOSWindows8WebServer := 34
    static COMAdminOSWindowsBluePersonal := 35
    static COMAdminOSWindowsBlueProfessional := 36
    static COMAdminOSWindowsBlueStandardServer := 37
    static COMAdminOSWindowsBlueEnterpriseServer := 38
    static COMAdminOSWindowsBlueDatacenterServer := 39
    static COMAdminOSWindowsBlueWebServer := 40
}
struct COMAdminServiceOptions extends Int32 {
    static COMAdminServiceLoadBalanceRouter := 1
}
struct COMAdminServiceStatusOptions extends Int32 {
    static COMAdminServiceStopped := 0
    static COMAdminServiceStartPending := 1
    static COMAdminServiceStopPending := 2
    static COMAdminServiceRunning := 3
    static COMAdminServiceContinuePending := 4
    static COMAdminServicePausePending := 5
    static COMAdminServicePaused := 6
    static COMAdminServiceUnknownState := 7
}
struct COMAdminQCMessageAuthenticateOptions extends Int32 {
    static COMAdminQCMessageAuthenticateSecureApps := 0
    static COMAdminQCMessageAuthenticateOff := 1
    static COMAdminQCMessageAuthenticateOn := 2
}
struct COMAdminFileFlags extends Int32 {
    static COMAdminFileFlagLoadable := 1
    static COMAdminFileFlagCOM := 2
    static COMAdminFileFlagContainsPS := 4
    static COMAdminFileFlagContainsComp := 8
    static COMAdminFileFlagContainsTLB := 16
    static COMAdminFileFlagSelfReg := 32
    static COMAdminFileFlagSelfUnReg := 64
    static COMAdminFileFlagUnloadableDLL := 128
    static COMAdminFileFlagDoesNotExist := 256
    static COMAdminFileFlagAlreadyInstalled := 512
    static COMAdminFileFlagBadTLB := 1024
    static COMAdminFileFlagGetClassObjFailed := 2048
    static COMAdminFileFlagClassNotAvailable := 4096
    static COMAdminFileFlagRegistrar := 8192
    static COMAdminFileFlagNoRegistrar := 16384
    static COMAdminFileFlagDLLRegsvrFailed := 32768
    static COMAdminFileFlagRegTLBFailed := 65536
    static COMAdminFileFlagRegistrarFailed := 131072
    static COMAdminFileFlagError := 262144
}
struct COMAdminComponentFlags extends Int32 {
    static COMAdminCompFlagTypeInfoFound := 1
    static COMAdminCompFlagCOMPlusPropertiesFound := 2
    static COMAdminCompFlagProxyFound := 4
    static COMAdminCompFlagInterfacesFound := 8
    static COMAdminCompFlagAlreadyInstalled := 16
    static COMAdminCompFlagNotInApplication := 32
}
struct COMAdminErrorCodes extends Int32 {
    static COMAdminErrObjectErrors := -2146368511
    static COMAdminErrObjectInvalid := -2146368510
    static COMAdminErrKeyMissing := -2146368509
    static COMAdminErrAlreadyInstalled := -2146368508
    static COMAdminErrAppFileWriteFail := -2146368505
    static COMAdminErrAppFileReadFail := -2146368504
    static COMAdminErrAppFileVersion := -2146368503
    static COMAdminErrBadPath := -2146368502
    static COMAdminErrApplicationExists := -2146368501
    static COMAdminErrRoleExists := -2146368500
    static COMAdminErrCantCopyFile := -2146368499
    static COMAdminErrNoUser := -2146368497
    static COMAdminErrInvalidUserids := -2146368496
    static COMAdminErrNoRegistryCLSID := -2146368495
    static COMAdminErrBadRegistryProgID := -2146368494
    static COMAdminErrAuthenticationLevel := -2146368493
    static COMAdminErrUserPasswdNotValid := -2146368492
    static COMAdminErrCLSIDOrIIDMismatch := -2146368488
    static COMAdminErrRemoteInterface := -2146368487
    static COMAdminErrDllRegisterServer := -2146368486
    static COMAdminErrNoServerShare := -2146368485
    static COMAdminErrDllLoadFailed := -2146368483
    static COMAdminErrBadRegistryLibID := -2146368482
    static COMAdminErrAppDirNotFound := -2146368481
    static COMAdminErrRegistrarFailed := -2146368477
    static COMAdminErrCompFileDoesNotExist := -2146368476
    static COMAdminErrCompFileLoadDLLFail := -2146368475
    static COMAdminErrCompFileGetClassObj := -2146368474
    static COMAdminErrCompFileClassNotAvail := -2146368473
    static COMAdminErrCompFileBadTLB := -2146368472
    static COMAdminErrCompFileNotInstallable := -2146368471
    static COMAdminErrNotChangeable := -2146368470
    static COMAdminErrNotDeletable := -2146368469
    static COMAdminErrSession := -2146368468
    static COMAdminErrCompMoveLocked := -2146368467
    static COMAdminErrCompMoveBadDest := -2146368466
    static COMAdminErrRegisterTLB := -2146368464
    static COMAdminErrSystemApp := -2146368461
    static COMAdminErrCompFileNoRegistrar := -2146368460
    static COMAdminErrCoReqCompInstalled := -2146368459
    static COMAdminErrServiceNotInstalled := -2146368458
    static COMAdminErrPropertySaveFailed := -2146368457
    static COMAdminErrObjectExists := -2146368456
    static COMAdminErrComponentExists := -2146368455
    static COMAdminErrRegFileCorrupt := -2146368453
    static COMAdminErrPropertyOverflow := -2146368452
    static COMAdminErrNotInRegistry := -2146368450
    static COMAdminErrObjectNotPoolable := -2146368449
    static COMAdminErrApplidMatchesClsid := -2146368442
    static COMAdminErrRoleDoesNotExist := -2146368441
    static COMAdminErrStartAppNeedsComponents := -2146368440
    static COMAdminErrRequiresDifferentPlatform := -2146368439
    static COMAdminErrQueuingServiceNotAvailable := -2146367998
    static COMAdminErrObjectParentMissing := -2146367480
    static COMAdminErrObjectDoesNotExist := -2146367479
    static COMAdminErrCanNotExportAppProxy := -2146368438
    static COMAdminErrCanNotStartApp := -2146368437
    static COMAdminErrCanNotExportSystemApp := -2146368436
    static COMAdminErrCanNotSubscribeToComponent := -2146368435
    static COMAdminErrAppNotRunning := -2146367478
    static COMAdminErrEventClassCannotBeSubscriber := -2146368434
    static COMAdminErrLibAppProxyIncompatible := -2146368433
    static COMAdminErrBasePartitionOnly := -2146368432
    static COMAdminErrDuplicatePartitionName := -2146368425
    static COMAdminErrPartitionInUse := -2146368423
    static COMAdminErrImportedComponentsNotAllowed := -2146368421
    static COMAdminErrRegdbNotInitialized := -2146368398
    static COMAdminErrRegdbNotOpen := -2146368397
    static COMAdminErrRegdbSystemErr := -2146368396
    static COMAdminErrRegdbAlreadyRunning := -2146368395
    static COMAdminErrMigVersionNotSupported := -2146368384
    static COMAdminErrMigSchemaNotFound := -2146368383
    static COMAdminErrCatBitnessMismatch := -2146368382
    static COMAdminErrCatUnacceptableBitness := -2146368381
    static COMAdminErrCatWrongAppBitnessBitness := -2146368380
    static COMAdminErrCatPauseResumeNotSupported := -2146368379
    static COMAdminErrCatServerFault := -2146368378
    static COMAdminErrCantRecycleLibraryApps := -2146367473
    static COMAdminErrCantRecycleServiceApps := -2146367471
    static COMAdminErrProcessAlreadyRecycled := -2146367470
    static COMAdminErrPausedProcessMayNotBeRecycled := -2146367469
    static COMAdminErrInvalidPartition := -2146367477
    static COMAdminErrPartitionMsiOnly := -2146367463
    static COMAdminErrStartAppDisabled := -2146368431
    static COMAdminErrCompMoveSource := -2146367460
    static COMAdminErrCompMoveDest := -2146367459
    static COMAdminErrCompMovePrivate := -2146367458
    static COMAdminErrCannotCopyEventClass := -2146367456
}
struct ISecurityIdentityColl extends IDispatch {
    static IID := "{CAFC823C-B441-11D1-B82B-0000F8757E2A}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_Item(name, pItem)
      => ComCall(8, this.p, BSTR, name, VARIANT.Ptr, pItem)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
}
struct ISecurityCallersColl extends IDispatch {
    static IID := "{CAFC823D-B441-11D1-B82B-0000F8757E2A}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_Item(lIndex, pObj)
      => ComCall(8, this.p, Int32, lIndex, ISecurityIdentityColl.Ptr, pObj)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
}
struct ISecurityCallContext extends IDispatch {
    static IID := "{CAFC823E-B441-11D1-B82B-0000F8757E2A}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_Item(name, pItem)
      => ComCall(8, this.p, BSTR, name, VARIANT.Ptr, pItem)
    get__NewEnum(ppEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnum)
    IsCallerInRole(bstrRole, pfInRole)
      => ComCall(10, this.p, BSTR, bstrRole, VARIANT_BOOL.Ptr, pfInRole)
    IsSecurityEnabled(pfIsEnabled)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pfIsEnabled)
    IsUserInRole(pUser, bstrRole, pfInRole)
      => ComCall(12, this.p, VARIANT.Ptr, pUser, BSTR, bstrRole, VARIANT_BOOL.Ptr, pfInRole)
}
struct IGetSecurityCallContext extends IDispatch {
    static IID := "{CAFC823F-B441-11D1-B82B-0000F8757E2A}"
    GetSecurityCallContext(ppObject)
      => ComCall(7, this.p, ISecurityCallContext.Ptr, ppObject)
}
struct SecurityProperty extends IDispatch {
    static IID := "{E74A7215-014D-11D1-A63C-00A0C911B4E0}"
    GetDirectCallerName(bstrUserName)
      => ComCall(7, this.p, BSTR.Ptr, bstrUserName)
    GetDirectCreatorName(bstrUserName)
      => ComCall(8, this.p, BSTR.Ptr, bstrUserName)
    GetOriginalCallerName(bstrUserName)
      => ComCall(9, this.p, BSTR.Ptr, bstrUserName)
    GetOriginalCreatorName(bstrUserName)
      => ComCall(10, this.p, BSTR.Ptr, bstrUserName)
}
struct ContextInfo extends IDispatch {
    static IID := "{19A5A02C-0AC8-11D2-B286-00C04F8EF934}"
    IsInTransaction(pbIsInTx)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbIsInTx)
    GetTransaction(ppTx)
      => ComCall(8, this.p, IUnknown.Ptr, ppTx)
    GetTransactionId(pbstrTxId)
      => ComCall(9, this.p, BSTR.Ptr, pbstrTxId)
    GetActivityId(pbstrActivityId)
      => ComCall(10, this.p, BSTR.Ptr, pbstrActivityId)
    GetContextId(pbstrCtxId)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCtxId)
}
struct ContextInfo2 extends ContextInfo {
    static IID := "{C99D6E75-2375-11D4-8331-00C04F605588}"
    GetPartitionId(__MIDL__ContextInfo20000)
      => ComCall(12, this.p, BSTR.Ptr, __MIDL__ContextInfo20000)
    GetApplicationId(__MIDL__ContextInfo20001)
      => ComCall(13, this.p, BSTR.Ptr, __MIDL__ContextInfo20001)
    GetApplicationInstanceId(__MIDL__ContextInfo20002)
      => ComCall(14, this.p, BSTR.Ptr, __MIDL__ContextInfo20002)
}
struct ObjectContext extends IDispatch {
    static IID := "{74C08646-CEDB-11CF-8B49-00AA00B8A790}"
    CreateInstance(bstrProgID, pObject)
      => ComCall(7, this.p, BSTR, bstrProgID, VARIANT.Ptr, pObject)
    SetComplete()
      => ComCall(8, this.p)
    SetAbort()
      => ComCall(9, this.p)
    EnableCommit()
      => ComCall(10, this.p)
    DisableCommit()
      => ComCall(11, this.p)
    IsInTransaction(pbIsInTx)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pbIsInTx)
    IsSecurityEnabled(pbIsEnabled)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pbIsEnabled)
    IsCallerInRole(bstrRole, pbInRole)
      => ComCall(14, this.p, BSTR, bstrRole, VARIANT_BOOL.Ptr, pbInRole)
    get_Count(plCount)
      => ComCall(15, this.p, Int32.Ptr, plCount)
    get_Item(name, pItem)
      => ComCall(16, this.p, BSTR, name, VARIANT.Ptr, pItem)
    get__NewEnum(ppEnum)
      => ComCall(17, this.p, IUnknown.Ptr, ppEnum)
    get_Security(ppSecurityProperty)
      => ComCall(18, this.p, SecurityProperty.Ptr, ppSecurityProperty)
    get_ContextInfo(ppContextInfo)
      => ComCall(19, this.p, ContextInfo.Ptr, ppContextInfo)
}
struct ITransactionContextEx extends IUnknown {
    static IID := "{7999FC22-D3C6-11CF-ACAB-00A024A55AEF}"
    CreateInstance(rclsid, riid, pObject)
      => ComCall(3, this.p, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, pObject)
    Commit()
      => ComCall(4, this.p)
    Abort()
      => ComCall(5, this.p)
}
struct ITransactionContext extends IDispatch {
    static IID := "{7999FC21-D3C6-11CF-ACAB-00A024A55AEF}"
    CreateInstance(pszProgId, pObject)
      => ComCall(7, this.p, BSTR, pszProgId, VARIANT.Ptr, pObject)
    Commit()
      => ComCall(8, this.p)
    Abort()
      => ComCall(9, this.p)
}
struct ICreateWithTransactionEx extends IUnknown {
    static IID := "{455ACF57-5345-11D2-99CF-00C04F797BC9}"
    CreateInstance(pTransaction?, rclsid, riid, pObject)
      => ComCall(3, this.p, ITransaction, pTransaction?, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, pObject)
}
struct ICreateWithLocalTransaction extends IUnknown {
    static IID := "{227AC7A8-8423-42CE-B7CF-03061EC9AAA3}"
    CreateInstanceWithSysTx(pTransaction, rclsid, riid, pObject)
      => ComCall(3, this.p, IUnknown, pTransaction, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, pObject)
}
struct ICreateWithTipTransactionEx extends IUnknown {
    static IID := "{455ACF59-5345-11D2-99CF-00C04F797BC9}"
    CreateInstance(bstrTipUrl, rclsid, riid, pObject)
      => ComCall(3, this.p, BSTR, bstrTipUrl, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, pObject)
}
struct COMSVCSEVENTINFO {
    cbSize : UInt32 := this.Size
    dwPid : UInt32
    lTime : Int64
    lMicroTime : Int32
    perfCount : Int64
    guidApp : GUID
    sMachineName : PWSTR
}
struct IComLTxEvents extends IUnknown {
    static IID := "{605CF82C-578E-4298-975D-82BABCD9E053}"
    OnLtxTransactionStart(pInfo, guidLtx, tsid, fRoot, nIsolationLevel)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidLtx, GUID, tsid, BOOL, fRoot, Int32, nIsolationLevel)
    OnLtxTransactionPrepare(pInfo, guidLtx, fVote)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidLtx, BOOL, fVote)
    OnLtxTransactionAbort(pInfo, guidLtx)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidLtx)
    OnLtxTransactionCommit(pInfo, guidLtx)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidLtx)
    OnLtxTransactionPromote(pInfo, guidLtx, txnId)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidLtx, GUID, txnId)
}
struct IComUserEvent extends IUnknown {
    static IID := "{683130A4-2E50-11D2-98A5-00C04F8EE1C4}"
    OnUserEvent(pInfo, pvarEvent)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, VARIANT.Ptr, pvarEvent)
}
struct IComThreadEvents extends IUnknown {
    static IID := "{683130A5-2E50-11D2-98A5-00C04F8EE1C4}"
    OnThreadStart(pInfo, ThreadID, dwThread, dwTheadCnt)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, UInt32, dwThread, UInt32, dwTheadCnt)
    OnThreadTerminate(pInfo, ThreadID, dwThread, dwTheadCnt)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, UInt32, dwThread, UInt32, dwTheadCnt)
    OnThreadBindToApartment(pInfo, ThreadID, AptID, dwActCnt, dwLowCnt)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, AptID, UInt32, dwActCnt, UInt32, dwLowCnt)
    OnThreadUnBind(pInfo, ThreadID, AptID, dwActCnt)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, AptID, UInt32, dwActCnt)
    OnThreadWorkEnque(pInfo, ThreadID, MsgWorkID, QueueLen)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, MsgWorkID, UInt32, QueueLen)
    OnThreadWorkPrivate(pInfo, ThreadID, MsgWorkID)
      => ComCall(8, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, MsgWorkID)
    OnThreadWorkPublic(pInfo, ThreadID, MsgWorkID, QueueLen)
      => ComCall(9, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, MsgWorkID, UInt32, QueueLen)
    OnThreadWorkRedirect(pInfo, ThreadID, MsgWorkID, QueueLen, ThreadNum)
      => ComCall(10, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, MsgWorkID, UInt32, QueueLen, Int64, ThreadNum)
    OnThreadWorkReject(pInfo, ThreadID, MsgWorkID, QueueLen)
      => ComCall(11, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ThreadID, Int64, MsgWorkID, UInt32, QueueLen)
    OnThreadAssignApartment(pInfo, guidActivity, AptID)
      => ComCall(12, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, Int64, AptID)
    OnThreadUnassignApartment(pInfo, AptID)
      => ComCall(13, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, AptID)
}
struct IComAppEvents extends IUnknown {
    static IID := "{683130A6-2E50-11D2-98A5-00C04F8EE1C4}"
    OnAppActivation(pInfo, guidApp)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnAppShutdown(pInfo, guidApp)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnAppForceShutdown(pInfo, guidApp)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
}
struct IComInstanceEvents extends IUnknown {
    static IID := "{683130A7-2E50-11D2-98A5-00C04F8EE1C4}"
    OnObjectCreate(pInfo, guidActivity, clsid, tsid, CtxtID, ObjectID)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, clsid, GUID.Ptr, tsid, Int64, CtxtID, Int64, ObjectID)
    OnObjectDestroy(pInfo, CtxtID)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
}
struct IComTransactionEvents extends IUnknown {
    static IID := "{683130A8-2E50-11D2-98A5-00C04F8EE1C4}"
    OnTransactionStart(pInfo, guidTx, tsid, fRoot)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx, GUID.Ptr, tsid, BOOL, fRoot)
    OnTransactionPrepare(pInfo, guidTx, fVoteYes)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx, BOOL, fVoteYes)
    OnTransactionAbort(pInfo, guidTx)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx)
    OnTransactionCommit(pInfo, guidTx)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx)
}
struct IComMethodEvents extends IUnknown {
    static IID := "{683130A9-2E50-11D2-98A5-00C04F8EE1C4}"
    OnMethodCall(pInfo, oid, guidCid, guidRid, iMeth)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, iMeth)
    OnMethodReturn(pInfo, oid, guidCid, guidRid, iMeth, hresult1)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, iMeth, HRESULT, hresult1)
    OnMethodException(pInfo, oid, guidCid, guidRid, iMeth)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, iMeth)
}
struct IComObjectEvents extends IUnknown {
    static IID := "{683130AA-2E50-11D2-98A5-00C04F8EE1C4}"
    OnObjectActivate(pInfo, CtxtID, ObjectID)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID, Int64, ObjectID)
    OnObjectDeactivate(pInfo, CtxtID, ObjectID)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID, Int64, ObjectID)
    OnDisableCommit(pInfo, CtxtID)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
    OnEnableCommit(pInfo, CtxtID)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
    OnSetComplete(pInfo, CtxtID)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
    OnSetAbort(pInfo, CtxtID)
      => ComCall(8, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
}
struct IComResourceEvents extends IUnknown {
    static IID := "{683130AB-2E50-11D2-98A5-00C04F8EE1C4}"
    OnResourceCreate(pInfo, ObjectID, pszType, resId, enlisted)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjectID, "Str", pszType, Int64, resId, BOOL, enlisted)
    OnResourceAllocate(pInfo, ObjectID, pszType, resId, enlisted, NumRated, Rating)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjectID, "Str", pszType, Int64, resId, BOOL, enlisted, UInt32, NumRated, UInt32, Rating)
    OnResourceRecycle(pInfo, ObjectID, pszType, resId)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjectID, "Str", pszType, Int64, resId)
    OnResourceDestroy(pInfo, ObjectID, hr, pszType, resId)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjectID, HRESULT, hr, "Str", pszType, Int64, resId)
    OnResourceTrack(pInfo, ObjectID, pszType, resId, enlisted)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjectID, "Str", pszType, Int64, resId, BOOL, enlisted)
}
struct IComSecurityEvents extends IUnknown {
    static IID := "{683130AC-2E50-11D2-98A5-00C04F8EE1C4}"
    OnAuthenticate(pInfo, guidActivity, ObjectID, guidIID, iMeth, pSidOriginalUser, pSidCurrentUser, bCurrentUserInpersonatingInProc)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, Int64, ObjectID, GUID.Ptr, guidIID, UInt32, iMeth, UInt32, pSidOriginalUser.Length, UInt8.Ptr, pSidOriginalUser, UInt32, pSidCurrentUser.Length, UInt8.Ptr, pSidCurrentUser, BOOL, bCurrentUserInpersonatingInProc)
    OnAuthenticateFail(pInfo, guidActivity, ObjectID, guidIID, iMeth, pSidOriginalUser, pSidCurrentUser, bCurrentUserInpersonatingInProc)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, Int64, ObjectID, GUID.Ptr, guidIID, UInt32, iMeth, UInt32, pSidOriginalUser.Length, UInt8.Ptr, pSidOriginalUser, UInt32, pSidCurrentUser.Length, UInt8.Ptr, pSidCurrentUser, BOOL, bCurrentUserInpersonatingInProc)
}
struct IComObjectPoolEvents extends IUnknown {
    static IID := "{683130AD-2E50-11D2-98A5-00C04F8EE1C4}"
    OnObjPoolPutObject(pInfo, guidObject, nReason, dwAvailable, oid)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, Int32, nReason, UInt32, dwAvailable, Int64, oid)
    OnObjPoolGetObject(pInfo, guidActivity, guidObject, dwAvailable, oid)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, UInt32, dwAvailable, Int64, oid)
    OnObjPoolRecycleToTx(pInfo, guidActivity, guidObject, guidTx, objid)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, GUID.Ptr, guidTx, Int64, objid)
    OnObjPoolGetFromTx(pInfo, guidActivity, guidObject, guidTx, objid)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, GUID.Ptr, guidTx, Int64, objid)
}
struct IComObjectPoolEvents2 extends IUnknown {
    static IID := "{683130AE-2E50-11D2-98A5-00C04F8EE1C4}"
    OnObjPoolCreateObject(pInfo, guidObject, dwObjsCreated, oid)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, UInt32, dwObjsCreated, Int64, oid)
    OnObjPoolDestroyObject(pInfo, guidObject, dwObjsCreated, oid)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, UInt32, dwObjsCreated, Int64, oid)
    OnObjPoolCreateDecision(pInfo, dwThreadsWaiting, dwAvail, dwCreated, dwMin, dwMax)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, UInt32, dwThreadsWaiting, UInt32, dwAvail, UInt32, dwCreated, UInt32, dwMin, UInt32, dwMax)
    OnObjPoolTimeout(pInfo, guidObject, guidActivity, dwTimeout)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, GUID.Ptr, guidActivity, UInt32, dwTimeout)
    OnObjPoolCreatePool(pInfo, guidObject, dwMin, dwMax, dwTimeout)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, UInt32, dwMin, UInt32, dwMax, UInt32, dwTimeout)
}
struct IComObjectConstructionEvents extends IUnknown {
    static IID := "{683130AF-2E50-11D2-98A5-00C04F8EE1C4}"
    OnObjectConstruct(pInfo, guidObject, sConstructString, oid)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, "Str", sConstructString, Int64, oid)
}
struct IComActivityEvents extends IUnknown {
    static IID := "{683130B0-2E50-11D2-98A5-00C04F8EE1C4}"
    OnActivityCreate(pInfo, guidActivity)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity)
    OnActivityDestroy(pInfo, guidActivity)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity)
    OnActivityEnter(pInfo, guidCurrent, guidEntered, dwThread)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidCurrent, GUID.Ptr, guidEntered, UInt32, dwThread)
    OnActivityTimeout(pInfo, guidCurrent, guidEntered, dwThread, dwTimeout)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidCurrent, GUID.Ptr, guidEntered, UInt32, dwThread, UInt32, dwTimeout)
    OnActivityReenter(pInfo, guidCurrent, dwThread, dwCallDepth)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidCurrent, UInt32, dwThread, UInt32, dwCallDepth)
    OnActivityLeave(pInfo, guidCurrent, guidLeft)
      => ComCall(8, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidCurrent, GUID.Ptr, guidLeft)
    OnActivityLeaveSame(pInfo, guidCurrent, dwCallDepth)
      => ComCall(9, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidCurrent, UInt32, dwCallDepth)
}
struct IComIdentityEvents extends IUnknown {
    static IID := "{683130B1-2E50-11D2-98A5-00C04F8EE1C4}"
    OnIISRequestInfo(pInfo, ObjId, pszClientIP, pszServerIP, pszURL)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, ObjId, "Str", pszClientIP, "Str", pszServerIP, "Str", pszURL)
}
struct IComQCEvents extends IUnknown {
    static IID := "{683130B2-2E50-11D2-98A5-00C04F8EE1C4}"
    OnQCRecord(pInfo, objid, szQueue, guidMsgId, guidWorkFlowId, msmqhr)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, objid, "Str", szQueue, GUID.Ptr, guidMsgId, GUID.Ptr, guidWorkFlowId, HRESULT, msmqhr)
    OnQCQueueOpen(pInfo, szQueue, QueueID, hr)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, "Str", szQueue, Int64, QueueID, HRESULT, hr)
    OnQCReceive(pInfo, QueueID, guidMsgId, guidWorkFlowId, hr)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, QueueID, GUID.Ptr, guidMsgId, GUID.Ptr, guidWorkFlowId, HRESULT, hr)
    OnQCReceiveFail(pInfo, QueueID, msmqhr)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, QueueID, HRESULT, msmqhr)
    OnQCMoveToReTryQueue(pInfo, guidMsgId, guidWorkFlowId, RetryIndex)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidMsgId, GUID.Ptr, guidWorkFlowId, UInt32, RetryIndex)
    OnQCMoveToDeadQueue(pInfo, guidMsgId, guidWorkFlowId)
      => ComCall(8, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidMsgId, GUID.Ptr, guidWorkFlowId)
    OnQCPlayback(pInfo, objid, guidMsgId, guidWorkFlowId, hr)
      => ComCall(9, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, objid, GUID.Ptr, guidMsgId, GUID.Ptr, guidWorkFlowId, HRESULT, hr)
}
struct IComExceptionEvents extends IUnknown {
    static IID := "{683130B3-2E50-11D2-98A5-00C04F8EE1C4}"
    OnExceptionUser(pInfo, code, address, pszStackTrace)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, UInt32, code, Int64, address, "Str", pszStackTrace)
}
struct ILBEvents extends IUnknown {
    static IID := "{683130B4-2E50-11D2-98A5-00C04F8EE1C4}"
    TargetUp(bstrServerName, bstrClsidEng)
      => ComCall(3, this.p, BSTR, bstrServerName, BSTR, bstrClsidEng)
    TargetDown(bstrServerName, bstrClsidEng)
      => ComCall(4, this.p, BSTR, bstrServerName, BSTR, bstrClsidEng)
    EngineDefined(bstrPropName, varPropValue, bstrClsidEng)
      => ComCall(5, this.p, BSTR, bstrPropName, VARIANT.Ptr, varPropValue, BSTR, bstrClsidEng)
}
struct IComCRMEvents extends IUnknown {
    static IID := "{683130B5-2E50-11D2-98A5-00C04F8EE1C4}"
    OnCRMRecoveryStart(pInfo, guidApp)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnCRMRecoveryDone(pInfo, guidApp)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnCRMCheckpoint(pInfo, guidApp)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnCRMBegin(pInfo, guidClerkCLSID, guidActivity, guidTx, szProgIdCompensator, szDescription)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID, GUID, guidActivity, GUID, guidTx, "Str", szProgIdCompensator, "Str", szDescription)
    OnCRMPrepare(pInfo, guidClerkCLSID)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMCommit(pInfo, guidClerkCLSID)
      => ComCall(8, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMAbort(pInfo, guidClerkCLSID)
      => ComCall(9, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMIndoubt(pInfo, guidClerkCLSID)
      => ComCall(10, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMDone(pInfo, guidClerkCLSID)
      => ComCall(11, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMRelease(pInfo, guidClerkCLSID)
      => ComCall(12, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMAnalyze(pInfo, guidClerkCLSID, dwCrmRecordType, dwRecordSize)
      => ComCall(13, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID, UInt32, dwCrmRecordType, UInt32, dwRecordSize)
    OnCRMWrite(pInfo, guidClerkCLSID, fVariants, dwRecordSize)
      => ComCall(14, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID, BOOL, fVariants, UInt32, dwRecordSize)
    OnCRMForget(pInfo, guidClerkCLSID)
      => ComCall(15, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMForce(pInfo, guidClerkCLSID)
      => ComCall(16, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID)
    OnCRMDeliver(pInfo, guidClerkCLSID, fVariants, dwRecordSize)
      => ComCall(17, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidClerkCLSID, BOOL, fVariants, UInt32, dwRecordSize)
}
struct IComMethod2Events extends IUnknown {
    static IID := "{FB388AAA-567D-4024-AF8E-6E93EE748573}"
    OnMethodCall2(pInfo, oid, guidCid, guidRid, dwThread, iMeth)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, dwThread, UInt32, iMeth)
    OnMethodReturn2(pInfo, oid, guidCid, guidRid, dwThread, iMeth, hresult1)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, dwThread, UInt32, iMeth, HRESULT, hresult1)
    OnMethodException2(pInfo, oid, guidCid, guidRid, dwThread, iMeth)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, oid, GUID.Ptr, guidCid, GUID.Ptr, guidRid, UInt32, dwThread, UInt32, iMeth)
}
struct IComTrackingInfoEvents extends IUnknown {
    static IID := "{4E6CDCC9-FB25-4FD5-9CC5-C9F4B6559CEC}"
    OnNewTrackingInfo(pToplevelCollection?)
      => ComCall(3, this.p, IUnknown, pToplevelCollection?)
}
struct TRACKING_COLL_TYPE extends Int32 {
    static TRKCOLL_PROCESSES := 0
    static TRKCOLL_APPLICATIONS := 1
    static TRKCOLL_COMPONENTS := 2
}
struct IComTrackingInfoCollection extends IUnknown {
    static IID := "{C266C677-C9AD-49AB-9FD9-D9661078588A}"
    Type(pType)
      => ComCall(3, this.p, TRACKING_COLL_TYPE.Ptr, pType)
    Count(pCount)
      => ComCall(4, this.p, UInt32.Ptr, pCount)
    Item(ulIndex, riid, ppv)
      => ComCall(5, this.p, UInt32, ulIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IComTrackingInfoObject extends IUnknown {
    static IID := "{116E42C5-D8B1-47BF-AB1E-C895ED3E2372}"
    GetValue(szPropertyName, pvarOut)
      => ComCall(3, this.p, "Str", szPropertyName, VARIANT.Ptr, pvarOut)
}
struct IComTrackingInfoProperties extends IUnknown {
    static IID := "{789B42BE-6F6B-443A-898E-67ABF390AA14}"
    PropCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetPropName(ulIndex, ppszPropName)
      => ComCall(4, this.p, UInt32, ulIndex, PWSTR.Ptr, ppszPropName)
}
struct IComApp2Events extends IUnknown {
    static IID := "{1290BC1A-B219-418D-B078-5934DED08242}"
    OnAppActivation2(pInfo, guidApp, guidProcess)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp, GUID, guidProcess)
    OnAppShutdown2(pInfo, guidApp)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnAppForceShutdown2(pInfo, guidApp)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp)
    OnAppPaused2(pInfo, guidApp, bPaused)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp, BOOL, bPaused)
    OnAppRecycle2(pInfo, guidApp, guidProcess, lReason)
      => ComCall(7, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID, guidApp, GUID, guidProcess, Int32, lReason)
}
struct IComTransaction2Events extends IUnknown {
    static IID := "{A136F62A-2F94-4288-86E0-D8A1FA4C0299}"
    OnTransactionStart2(pInfo, guidTx, tsid, fRoot, nIsolationLevel)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx, GUID.Ptr, tsid, BOOL, fRoot, Int32, nIsolationLevel)
    OnTransactionPrepare2(pInfo, guidTx, fVoteYes)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx, BOOL, fVoteYes)
    OnTransactionAbort2(pInfo, guidTx)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx)
    OnTransactionCommit2(pInfo, guidTx)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidTx)
}
struct IComInstance2Events extends IUnknown {
    static IID := "{20E3BF07-B506-4AD5-A50C-D2CA5B9C158E}"
    OnObjectCreate2(pInfo, guidActivity, clsid, tsid, CtxtID, ObjectID, guidPartition)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, clsid, GUID.Ptr, tsid, Int64, CtxtID, Int64, ObjectID, GUID.Ptr, guidPartition)
    OnObjectDestroy2(pInfo, CtxtID)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, Int64, CtxtID)
}
struct IComObjectPool2Events extends IUnknown {
    static IID := "{65BF6534-85EA-4F64-8CF4-3D974B2AB1CF}"
    OnObjPoolPutObject2(pInfo, guidObject, nReason, dwAvailable, oid)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, Int32, nReason, UInt32, dwAvailable, Int64, oid)
    OnObjPoolGetObject2(pInfo, guidActivity, guidObject, dwAvailable, oid, guidPartition)
      => ComCall(4, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, UInt32, dwAvailable, Int64, oid, GUID.Ptr, guidPartition)
    OnObjPoolRecycleToTx2(pInfo, guidActivity, guidObject, guidTx, objid)
      => ComCall(5, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, GUID.Ptr, guidTx, Int64, objid)
    OnObjPoolGetFromTx2(pInfo, guidActivity, guidObject, guidTx, objid, guidPartition)
      => ComCall(6, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidActivity, GUID.Ptr, guidObject, GUID.Ptr, guidTx, Int64, objid, GUID.Ptr, guidPartition)
}
struct IComObjectConstruction2Events extends IUnknown {
    static IID := "{4B5A7827-8DF2-45C0-8F6F-57EA1F856A9F}"
    OnObjectConstruct2(pInfo, guidObject, sConstructString, oid, guidPartition)
      => ComCall(3, this.p, COMSVCSEVENTINFO.Ptr, pInfo, GUID.Ptr, guidObject, "Str", sConstructString, Int64, oid, GUID.Ptr, guidPartition)
}
struct ISystemAppEventData extends IUnknown {
    static IID := "{D6D48A3C-D5C5-49E7-8C74-99E4889ED52F}"
    Startup()
      => ComCall(3, this.p)
    OnDataChanged(dwPID, dwMask, dwNumberSinks, bstrDwMethodMask, dwReason, u64TraceHandle)
      => ComCall(4, this.p, UInt32, dwPID, UInt32, dwMask, UInt32, dwNumberSinks, BSTR, bstrDwMethodMask, UInt32, dwReason, Int64, u64TraceHandle)
}
struct IMtsEvents extends IDispatch {
    static IID := "{BACEDF4D-74AB-11D0-B162-00AA00BA3258}"
    get_PackageName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_PackageGuid(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    PostEvent(vEvent)
      => ComCall(9, this.p, VARIANT.Ptr, vEvent)
    get_FireEvents(pVal)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pVal)
    GetProcessID(id)
      => ComCall(11, this.p, Int32.Ptr, id)
}
struct IMtsEventInfo extends IDispatch {
    static IID := "{D56C3DC1-8482-11D0-B170-00AA00BA3258}"
    get_Names(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    get_DisplayName(sDisplayName)
      => ComCall(8, this.p, BSTR.Ptr, sDisplayName)
    get_EventID(sGuidEventID)
      => ComCall(9, this.p, BSTR.Ptr, sGuidEventID)
    get_Count(lCount)
      => ComCall(10, this.p, Int32.Ptr, lCount)
    get_Value(sKey, pVal)
      => ComCall(11, this.p, BSTR, sKey, VARIANT.Ptr, pVal)
}
struct IMTSLocator extends IDispatch {
    static IID := "{D19B8BFD-7F88-11D0-B16E-00AA00BA3258}"
    GetEventDispatcher(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
}
struct IMtsGrp extends IDispatch {
    static IID := "{4B2E958C-0393-11D1-B1AB-00AA00BA3258}"
    get_Count(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    Item(lIndex, ppUnkDispatcher)
      => ComCall(8, this.p, Int32, lIndex, IUnknown.Ptr, ppUnkDispatcher)
    Refresh()
      => ComCall(9, this.p)
}
struct IMessageMover extends IDispatch {
    static IID := "{588A085A-B795-11D1-8054-00C04FC340EE}"
    get_SourcePath(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_SourcePath(newVal)
      => ComCall(8, this.p, BSTR, newVal)
    get_DestPath(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_DestPath(newVal)
      => ComCall(10, this.p, BSTR, newVal)
    get_CommitBatchSize(pVal)
      => ComCall(11, this.p, Int32.Ptr, pVal)
    put_CommitBatchSize(newVal)
      => ComCall(12, this.p, Int32, newVal)
    MoveMessages(plMessagesMoved)
      => ComCall(13, this.p, Int32.Ptr, plMessagesMoved)
}
struct IEventServerTrace extends IDispatch {
    static IID := "{9A9F12B8-80AF-47AB-A579-35EA57725370}"
    StartTraceGuid(bstrguidEvent, bstrguidFilter, lPidFilter)
      => ComCall(7, this.p, BSTR, bstrguidEvent, BSTR, bstrguidFilter, Int32, lPidFilter)
    StopTraceGuid(bstrguidEvent, bstrguidFilter, lPidFilter)
      => ComCall(8, this.p, BSTR, bstrguidEvent, BSTR, bstrguidFilter, Int32, lPidFilter)
    EnumTraceGuid(plCntGuids, pbstrGuidList)
      => ComCall(9, this.p, Int32.Ptr, plCntGuids, BSTR.Ptr, pbstrGuidList)
}
struct RECYCLE_INFO {
    guidCombaseProcessIdentifier : GUID
    ProcessStartTime : Int64
    dwRecycleLifetimeLimit : UInt32
    dwRecycleMemoryLimit : UInt32
    dwRecycleExpirationTimeout : UInt32
}
struct DUMPTYPE extends Int32 {
    static DUMPTYPE_FULL := 0
    static DUMPTYPE_MINI := 1
    static DUMPTYPE_NONE := 2
}
struct HANG_INFO {
    fAppHangMonitorEnabled : BOOL
    fTerminateOnHang : BOOL
    DumpType : DUMPTYPE
    dwHangTimeout : UInt32
    dwDumpCount : UInt32
    dwInfoMsgCount : UInt32
}
struct COMPLUS_APPTYPE extends Int32 {
    static APPTYPE_UNKNOWN := -1
    static APPTYPE_SERVER := 1
    static APPTYPE_LIBRARY := 0
    static APPTYPE_SWC := 2
}
struct APPSTATISTICS {
    m_cTotalCalls : UInt32
    m_cTotalInstances : UInt32
    m_cTotalClasses : UInt32
    m_cCallsPerSecond : UInt32
}
struct APPDATA {
    m_idApp : UInt32
    m_szAppGuid : UInt16[40]
    m_dwAppProcessId : UInt32
    m_AppStatistics : APPSTATISTICS
}
struct CLSIDDATA {
    m_clsid : GUID
    m_cReferences : UInt32
    m_cBound : UInt32
    m_cPooled : UInt32
    m_cInCall : UInt32
    m_dwRespTime : UInt32
    m_cCallsCompleted : UInt32
    m_cCallsFailed : UInt32
}
struct CLSIDDATA2 {
    m_clsid : GUID
    m_appid : GUID
    m_partid : GUID
    m_pwszAppName : PWSTR
    m_pwszCtxName : PWSTR
    m_eAppType : COMPLUS_APPTYPE
    m_cReferences : UInt32
    m_cBound : UInt32
    m_cPooled : UInt32
    m_cInCall : UInt32
    m_dwRespTime : UInt32
    m_cCallsCompleted : UInt32
    m_cCallsFailed : UInt32
}
struct GetAppTrackerDataFlags extends Int32 {
    static GATD_INCLUDE_PROCESS_EXE_NAME := 1
    static GATD_INCLUDE_LIBRARY_APPS := 2
    static GATD_INCLUDE_SWC := 4
    static GATD_INCLUDE_CLASS_NAME := 8
    static GATD_INCLUDE_APPLICATION_NAME := 16
}
struct ApplicationProcessSummary {
    PartitionIdPrimaryApplication : GUID
    ApplicationIdPrimaryApplication : GUID
    ApplicationInstanceId : GUID
    ProcessId : UInt32
    Type : COMPLUS_APPTYPE
    ProcessExeName : PWSTR
    IsService : BOOL
    IsPaused : BOOL
    IsRecycled : BOOL
}
struct ApplicationProcessStatistics {
    NumCallsOutstanding : UInt32
    NumTrackedComponents : UInt32
    NumComponentInstances : UInt32
    AvgCallsPerSecond : UInt32
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : UInt32
    Reserved4 : UInt32
}
struct ApplicationProcessRecycleInfo {
    IsRecyclable : BOOL
    IsRecycled : BOOL
    TimeRecycled : FILETIME
    TimeToTerminate : FILETIME
    RecycleReasonCode : Int32
    IsPendingRecycle : BOOL
    HasAutomaticLifetimeRecycling : BOOL
    TimeForAutomaticRecycling : FILETIME
    MemoryLimitInKB : UInt32
    MemoryUsageInKBLastCheck : UInt32
    ActivationLimit : UInt32
    NumActivationsLastReported : UInt32
    CallLimit : UInt32
    NumCallsLastReported : UInt32
}
struct ApplicationSummary {
    ApplicationInstanceId : GUID
    PartitionId : GUID
    ApplicationId : GUID
    Type : COMPLUS_APPTYPE
    ApplicationName : PWSTR
    NumTrackedComponents : UInt32
    NumComponentInstances : UInt32
}
struct ComponentSummary {
    ApplicationInstanceId : GUID
    PartitionId : GUID
    ApplicationId : GUID
    Clsid : GUID
    ClassName : PWSTR
    ApplicationName : PWSTR
}
struct ComponentStatistics {
    NumInstances : UInt32
    NumBoundReferences : UInt32
    NumPooledObjects : UInt32
    NumObjectsInCall : UInt32
    AvgResponseTimeInMs : UInt32
    NumCallsCompletedRecent : UInt32
    NumCallsFailedRecent : UInt32
    NumCallsCompletedTotal : UInt32
    NumCallsFailedTotal : UInt32
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : UInt32
    Reserved4 : UInt32
}
struct ComponentHangMonitorInfo {
    IsMonitored : BOOL
    TerminateOnHang : BOOL
    AvgCallThresholdInMs : UInt32
}
struct IGetAppTrackerData extends IUnknown {
    static IID := "{507C3AC8-3E12-4CB0-9366-653D3E050638}"
    GetApplicationProcesses(PartitionId, ApplicationId, Flags, NumApplicationProcesses, ApplicationProcesses)
      => ComCall(3, this.p, GUID.Ptr, PartitionId, GUID.Ptr, ApplicationId, UInt32, Flags, UInt32.Ptr, NumApplicationProcesses, ApplicationProcessSummary.Ptr.Ptr, ApplicationProcesses)
    GetApplicationProcessDetails(ApplicationInstanceId, ProcessId, Flags, Summary?, Statistics?, RecycleInfo?, AnyComponentsHangMonitored?)
      => ComCall(4, this.p, GUID.Ptr, ApplicationInstanceId, UInt32, ProcessId, UInt32, Flags, ApplicationProcessSummary.Ptr, Summary?, ApplicationProcessStatistics.Ptr, Statistics?, ApplicationProcessRecycleInfo.Ptr, RecycleInfo?, BOOL.Ptr, AnyComponentsHangMonitored?)
    GetApplicationsInProcess(ApplicationInstanceId, ProcessId, PartitionId, Flags, NumApplicationsInProcess, Applications)
      => ComCall(5, this.p, GUID.Ptr, ApplicationInstanceId, UInt32, ProcessId, GUID.Ptr, PartitionId, UInt32, Flags, UInt32.Ptr, NumApplicationsInProcess, ApplicationSummary.Ptr.Ptr, Applications)
    GetComponentsInProcess(ApplicationInstanceId, ProcessId, PartitionId, ApplicationId, Flags, NumComponentsInProcess, Components)
      => ComCall(6, this.p, GUID.Ptr, ApplicationInstanceId, UInt32, ProcessId, GUID.Ptr, PartitionId, GUID.Ptr, ApplicationId, UInt32, Flags, UInt32.Ptr, NumComponentsInProcess, ComponentSummary.Ptr.Ptr, Components)
    GetComponentDetails(ApplicationInstanceId, ProcessId, Clsid, Flags, Summary?, Statistics?, HangMonitorInfo?)
      => ComCall(7, this.p, GUID.Ptr, ApplicationInstanceId, UInt32, ProcessId, GUID.Ptr, Clsid, UInt32, Flags, ComponentSummary.Ptr, Summary?, ComponentStatistics.Ptr, Statistics?, ComponentHangMonitorInfo.Ptr, HangMonitorInfo?)
    GetTrackerDataAsCollectionObject(TopLevelCollection)
      => ComCall(8, this.p, IUnknown.Ptr, TopLevelCollection)
    GetSuggestedPollingInterval(PollingIntervalInSeconds)
      => ComCall(9, this.p, UInt32.Ptr, PollingIntervalInSeconds)
}
struct IDispenserManager extends IUnknown {
    static IID := "{5CB31E10-2B5F-11CF-BE10-00AA00A2FA25}"
    RegisterDispenser(__MIDL__IDispenserManager0000, szDispenserName, __MIDL__IDispenserManager0001)
      => ComCall(3, this.p, IDispenserDriver, __MIDL__IDispenserManager0000, "Str", szDispenserName, IHolder.Ptr, __MIDL__IDispenserManager0001)
    GetContext(__MIDL__IDispenserManager0002, __MIDL__IDispenserManager0003)
      => ComCall(4, this.p, IntPtr.Ptr, __MIDL__IDispenserManager0002, IntPtr.Ptr, __MIDL__IDispenserManager0003)
}
struct IHolder extends IUnknown {
    static IID := "{BF6A1850-2B45-11CF-BE10-00AA00A2FA25}"
    AllocResource(__MIDL__IHolder0000, __MIDL__IHolder0001)
      => ComCall(3, this.p, IntPtr, __MIDL__IHolder0000, IntPtr.Ptr, __MIDL__IHolder0001)
    FreeResource(__MIDL__IHolder0002)
      => ComCall(4, this.p, IntPtr, __MIDL__IHolder0002)
    TrackResource(__MIDL__IHolder0003)
      => ComCall(5, this.p, IntPtr, __MIDL__IHolder0003)
    TrackResourceS(__MIDL__IHolder0004)
      => ComCall(6, this.p, UInt16.Ptr, __MIDL__IHolder0004)
    UntrackResource(__MIDL__IHolder0005, __MIDL__IHolder0006)
      => ComCall(7, this.p, IntPtr, __MIDL__IHolder0005, BOOL, __MIDL__IHolder0006)
    UntrackResourceS(__MIDL__IHolder0007, __MIDL__IHolder0008)
      => ComCall(8, this.p, UInt16.Ptr, __MIDL__IHolder0007, BOOL, __MIDL__IHolder0008)
    Close()
      => ComCall(9, this.p)
    RequestDestroyResource(__MIDL__IHolder0009)
      => ComCall(10, this.p, IntPtr, __MIDL__IHolder0009)
}
struct IDispenserDriver extends IUnknown {
    static IID := "{208B3651-2B48-11CF-BE10-00AA00A2FA25}"
    CreateResource(ResTypId, pResId, pSecsFreeBeforeDestroy)
      => ComCall(3, this.p, IntPtr, ResTypId, IntPtr.Ptr, pResId, Int32.Ptr, pSecsFreeBeforeDestroy)
    RateResource(ResTypId, ResId, fRequiresTransactionEnlistment, pRating)
      => ComCall(4, this.p, IntPtr, ResTypId, IntPtr, ResId, BOOL, fRequiresTransactionEnlistment, UInt32.Ptr, pRating)
    EnlistResource(ResId, TransId)
      => ComCall(5, this.p, IntPtr, ResId, IntPtr, TransId)
    ResetResource(ResId)
      => ComCall(6, this.p, IntPtr, ResId)
    DestroyResource(ResId)
      => ComCall(7, this.p, IntPtr, ResId)
    DestroyResourceS(ResId)
      => ComCall(8, this.p, UInt16.Ptr, ResId)
}
struct ITransactionProxy extends IUnknown {
    static IID := "{02558374-DF2E-4DAE-BD6B-1D5C994F9BDC}"
    Commit(guid1)
      => ComCall(3, this.p, GUID, guid1)
    Abort()
      => ComCall(4, this.p)
    Promote(pTransaction)
      => ComCall(5, this.p, ITransaction.Ptr, pTransaction)
    CreateVoter(pTxAsync, ppBallot)
      => ComCall(6, this.p, ITransactionVoterNotifyAsync2, pTxAsync, ITransactionVoterBallotAsync2.Ptr, ppBallot)
    GetIsolationLevel(__MIDL__ITransactionProxy0000)
      => ComCall(7, this.p, Int32.Ptr, __MIDL__ITransactionProxy0000)
    GetIdentifier(pbstrIdentifier)
      => ComCall(8, this.p, GUID.Ptr, pbstrIdentifier)
    IsReusable(pfIsReusable)
      => ComCall(9, this.p, BOOL.Ptr, pfIsReusable)
}
struct IContextSecurityPerimeter extends IUnknown {
    static IID := "{A7549A29-A7C4-42E1-8DC1-7E3D748DC24A}"
    GetPerimeterFlag(pFlag)
      => ComCall(3, this.p, BOOL.Ptr, pFlag)
    SetPerimeterFlag(fFlag)
      => ComCall(4, this.p, BOOL, fFlag)
}
struct ITxProxyHolder extends IUnknown {
    static IID := "{13D86F31-0139-41AF-BCAD-C7D50435FE9F}"
    GetIdentifier(pGuidLtx)
      => ComCall(3, this.p, GUID.Ptr, pGuidLtx, "void")
}
struct IObjectContext extends IUnknown {
    static IID := "{51372AE0-CAE7-11CF-BE81-00AA00A2FA25}"
    CreateInstance(rclsid, riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetComplete()
      => ComCall(4, this.p)
    SetAbort()
      => ComCall(5, this.p)
    EnableCommit()
      => ComCall(6, this.p)
    DisableCommit()
      => ComCall(7, this.p)
    IsInTransaction()
      => ComCall(8, this.p, BOOL)
    IsSecurityEnabled()
      => ComCall(9, this.p, BOOL)
    IsCallerInRole(bstrRole, pfIsInRole)
      => ComCall(10, this.p, BSTR, bstrRole, BOOL.Ptr, pfIsInRole)
}
struct IObjectControl extends IUnknown {
    static IID := "{51372AEC-CAE7-11CF-BE81-00AA00A2FA25}"
    Activate()
      => ComCall(3, this.p)
    Deactivate()
      => ComCall(4, this.p, "void")
    CanBePooled()
      => ComCall(5, this.p, BOOL)
}
struct IEnumNames extends IUnknown {
    static IID := "{51372AF2-CAE7-11CF-BE81-00AA00A2FA25}"
    Next(celt, rgname, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, BSTR.Ptr, rgname, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNames.Ptr, ppenum)
}
struct ISecurityProperty extends IUnknown {
    static IID := "{51372AEA-CAE7-11CF-BE81-00AA00A2FA25}"
    GetDirectCreatorSID(pSID)
      => ComCall(3, this.p, PSID.Ptr, pSID)
    GetOriginalCreatorSID(pSID)
      => ComCall(4, this.p, PSID.Ptr, pSID)
    GetDirectCallerSID(pSID)
      => ComCall(5, this.p, PSID.Ptr, pSID)
    GetOriginalCallerSID(pSID)
      => ComCall(6, this.p, PSID.Ptr, pSID)
    ReleaseSID(pSID1)
      => ComCall(7, this.p, PSID, pSID1)
}
struct ObjectControl extends IUnknown {
    static IID := "{7DC41850-0C31-11D0-8B79-00AA00B8A790}"
    Activate()
      => ComCall(3, this.p)
    Deactivate()
      => ComCall(4, this.p)
    CanBePooled(pbPoolable)
      => ComCall(5, this.p, VARIANT_BOOL.Ptr, pbPoolable)
}
struct ISharedProperty extends IDispatch {
    static IID := "{2A005C01-A5DE-11CF-9E66-00AA00A3F464}"
    get_Value(pVal)
      => ComCall(7, this.p, VARIANT.Ptr, pVal)
    put_Value(val)
      => ComCall(8, this.p, VARIANT, val)
}
struct ISharedPropertyGroup extends IDispatch {
    static IID := "{2A005C07-A5DE-11CF-9E66-00AA00A3F464}"
    CreatePropertyByPosition(Index, fExists, ppProp)
      => ComCall(7, this.p, Int32, Index, VARIANT_BOOL.Ptr, fExists, ISharedProperty.Ptr, ppProp)
    get_PropertyByPosition(Index, ppProperty)
      => ComCall(8, this.p, Int32, Index, ISharedProperty.Ptr, ppProperty)
    CreateProperty(Name, fExists, ppProp)
      => ComCall(9, this.p, BSTR, Name, VARIANT_BOOL.Ptr, fExists, ISharedProperty.Ptr, ppProp)
    get_Property(Name, ppProperty)
      => ComCall(10, this.p, BSTR, Name, ISharedProperty.Ptr, ppProperty)
}
struct ISharedPropertyGroupManager extends IDispatch {
    static IID := "{2A005C0D-A5DE-11CF-9E66-00AA00A3F464}"
    CreatePropertyGroup(Name, dwIsoMode, dwRelMode, fExists, ppGroup)
      => ComCall(7, this.p, BSTR, Name, Int32.Ptr, dwIsoMode, Int32.Ptr, dwRelMode, VARIANT_BOOL.Ptr, fExists, ISharedPropertyGroup.Ptr, ppGroup)
    get_Group(Name, ppGroup)
      => ComCall(8, this.p, BSTR, Name, ISharedPropertyGroup.Ptr, ppGroup)
    get__NewEnum(retval)
      => ComCall(9, this.p, IUnknown.Ptr, retval)
}
struct IObjectConstruct extends IUnknown {
    static IID := "{41C4F8B3-7439-11D2-98CB-00C04F8EE1C4}"
    Construct(pCtorObj)
      => ComCall(3, this.p, IDispatch, pCtorObj)
}
struct IObjectConstructString extends IDispatch {
    static IID := "{41C4F8B2-7439-11D2-98CB-00C04F8EE1C4}"
    get_ConstructString(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
}
struct IObjectContextActivity extends IUnknown {
    static IID := "{51372AFC-CAE7-11CF-BE81-00AA00A2FA25}"
    GetActivityId(pGUID)
      => ComCall(3, this.p, GUID.Ptr, pGUID)
}
struct IObjectContextInfo extends IUnknown {
    static IID := "{75B52DDB-E8ED-11D1-93AD-00AA00BA3258}"
    IsInTransaction()
      => ComCall(3, this.p, BOOL)
    GetTransaction(pptrans)
      => ComCall(4, this.p, IUnknown.Ptr, pptrans)
    GetTransactionId(pGuid)
      => ComCall(5, this.p, GUID.Ptr, pGuid)
    GetActivityId(pGUID)
      => ComCall(6, this.p, GUID.Ptr, pGUID)
    GetContextId(pGuid)
      => ComCall(7, this.p, GUID.Ptr, pGuid)
}
struct IObjectContextInfo2 extends IObjectContextInfo {
    static IID := "{594BE71A-4BC4-438B-9197-CFD176248B09}"
    GetPartitionId(pGuid)
      => ComCall(8, this.p, GUID.Ptr, pGuid)
    GetApplicationId(pGuid)
      => ComCall(9, this.p, GUID.Ptr, pGuid)
    GetApplicationInstanceId(pGuid)
      => ComCall(10, this.p, GUID.Ptr, pGuid)
}
struct ITransactionStatus extends IUnknown {
    static IID := "{61F589E8-3724-4898-A0A4-664AE9E1D1B4}"
    SetTransactionStatus(hrStatus)
      => ComCall(3, this.p, HRESULT, hrStatus)
    GetTransactionStatus(pHrStatus)
      => ComCall(4, this.p, HRESULT.Ptr, pHrStatus)
}
struct IObjectContextTip extends IUnknown {
    static IID := "{92FD41CA-BAD9-11D2-9A2D-00C04F797BC9}"
    GetTipUrl(pTipUrl)
      => ComCall(3, this.p, BSTR.Ptr, pTipUrl)
}
struct IPlaybackControl extends IUnknown {
    static IID := "{51372AFD-CAE7-11CF-BE81-00AA00A2FA25}"
    FinalClientRetry()
      => ComCall(3, this.p)
    FinalServerRetry()
      => ComCall(4, this.p)
}
struct IGetContextProperties extends IUnknown {
    static IID := "{51372AF4-CAE7-11CF-BE81-00AA00A2FA25}"
    Count(plCount)
      => ComCall(3, this.p, Int32.Ptr, plCount)
    GetProperty(name, pProperty)
      => ComCall(4, this.p, BSTR, name, VARIANT.Ptr, pProperty)
    EnumNames(ppenum)
      => ComCall(5, this.p, IEnumNames.Ptr, ppenum)
}
struct TransactionVote extends Int32 {
    static TxCommit := 0
    static TxAbort := 1
}
struct IContextState extends IUnknown {
    static IID := "{3C05E54B-A42A-11D2-AFC4-00C04F8EE1C4}"
    SetDeactivateOnReturn(bDeactivate)
      => ComCall(3, this.p, VARIANT_BOOL, bDeactivate)
    GetDeactivateOnReturn(pbDeactivate)
      => ComCall(4, this.p, VARIANT_BOOL.Ptr, pbDeactivate)
    SetMyTransactionVote(txVote)
      => ComCall(5, this.p, TransactionVote, txVote)
    GetMyTransactionVote(ptxVote)
      => ComCall(6, this.p, TransactionVote.Ptr, ptxVote)
}
struct IPoolManager extends IDispatch {
    static IID := "{0A469861-5A91-43A0-99B6-D5E179BB0631}"
    ShutdownPool(CLSIDOrProgID)
      => ComCall(7, this.p, BSTR, CLSIDOrProgID)
}
struct ISelectCOMLBServer extends IUnknown {
    static IID := "{DCF443F4-3F8A-4872-B9F0-369A796D12D6}"
    Init()
      => ComCall(3, this.p)
    GetLBServer(pUnk)
      => ComCall(4, this.p, IUnknown, pUnk)
}
struct ICOMLBArguments extends IUnknown {
    static IID := "{3A0F150F-8EE5-4B94-B40E-AEF2F9E42ED2}"
    GetCLSID(pCLSID)
      => ComCall(3, this.p, GUID.Ptr, pCLSID)
    SetCLSID(pCLSID)
      => ComCall(4, this.p, GUID.Ptr, pCLSID)
    GetMachineName(szServerName)
      => ComCall(5, this.p, UInt32, szServerName.Length, PWSTR, szServerName)
    SetMachineName(szServerName)
      => ComCall(6, this.p, UInt32, szServerName.Length, "Str", szServerName)
}
struct ICrmLogControl extends IUnknown {
    static IID := "{A0E174B3-D26E-11D2-8F84-00805FC7BCD9}"
    get_TransactionUOW(pVal)
      => ComCall(3, this.p, BSTR.Ptr, pVal)
    RegisterCompensator(lpcwstrProgIdCompensator, lpcwstrDescription, lCrmRegFlags)
      => ComCall(4, this.p, "Str", lpcwstrProgIdCompensator, "Str", lpcwstrDescription, Int32, lCrmRegFlags)
    WriteLogRecordVariants(pLogRecord)
      => ComCall(5, this.p, VARIANT.Ptr, pLogRecord)
    ForceLog()
      => ComCall(6, this.p)
    ForgetLogRecord()
      => ComCall(7, this.p)
    ForceTransactionToAbort()
      => ComCall(8, this.p)
    WriteLogRecord(rgBlob)
      => ComCall(9, this.p, BLOB.Ptr, rgBlob, UInt32, rgBlob.Length)
}
struct ICrmCompensatorVariants extends IUnknown {
    static IID := "{F0BAF8E4-7804-11D1-82E9-00A0C91EEDE9}"
    SetLogControlVariants(pLogControl?)
      => ComCall(3, this.p, ICrmLogControl, pLogControl?)
    BeginPrepareVariants()
      => ComCall(4, this.p)
    PrepareRecordVariants(pLogRecord, pbForget)
      => ComCall(5, this.p, VARIANT.Ptr, pLogRecord, VARIANT_BOOL.Ptr, pbForget)
    EndPrepareVariants(pbOkToPrepare)
      => ComCall(6, this.p, VARIANT_BOOL.Ptr, pbOkToPrepare)
    BeginCommitVariants(bRecovery)
      => ComCall(7, this.p, VARIANT_BOOL, bRecovery)
    CommitRecordVariants(pLogRecord, pbForget)
      => ComCall(8, this.p, VARIANT.Ptr, pLogRecord, VARIANT_BOOL.Ptr, pbForget)
    EndCommitVariants()
      => ComCall(9, this.p)
    BeginAbortVariants(bRecovery)
      => ComCall(10, this.p, VARIANT_BOOL, bRecovery)
    AbortRecordVariants(pLogRecord, pbForget)
      => ComCall(11, this.p, VARIANT.Ptr, pLogRecord, VARIANT_BOOL.Ptr, pbForget)
    EndAbortVariants()
      => ComCall(12, this.p)
}
struct CrmLogRecordRead {
    dwCrmFlags : UInt32
    dwSequenceNumber : UInt32
    blobUserData : BLOB
}
struct ICrmCompensator extends IUnknown {
    static IID := "{BBC01830-8D3B-11D1-82EC-00A0C91EEDE9}"
    SetLogControl(pLogControl?)
      => ComCall(3, this.p, ICrmLogControl, pLogControl?)
    BeginPrepare()
      => ComCall(4, this.p)
    PrepareRecord(crmLogRec, pfForget)
      => ComCall(5, this.p, CrmLogRecordRead, crmLogRec, BOOL.Ptr, pfForget)
    EndPrepare(pfOkToPrepare)
      => ComCall(6, this.p, BOOL.Ptr, pfOkToPrepare)
    BeginCommit(fRecovery)
      => ComCall(7, this.p, BOOL, fRecovery)
    CommitRecord(crmLogRec, pfForget)
      => ComCall(8, this.p, CrmLogRecordRead, crmLogRec, BOOL.Ptr, pfForget)
    EndCommit()
      => ComCall(9, this.p)
    BeginAbort(fRecovery)
      => ComCall(10, this.p, BOOL, fRecovery)
    AbortRecord(crmLogRec, pfForget)
      => ComCall(11, this.p, CrmLogRecordRead, crmLogRec, BOOL.Ptr, pfForget)
    EndAbort()
      => ComCall(12, this.p)
}
struct CrmTransactionState extends Int32 {
    static TxState_Active := 0
    static TxState_Committed := 1
    static TxState_Aborted := 2
    static TxState_Indoubt := 3
}
struct ICrmMonitorLogRecords extends IUnknown {
    static IID := "{70C8E441-C7ED-11D1-82FB-00A0C91EEDE9}"
    get_Count(pVal)
      => ComCall(3, this.p, Int32.Ptr, pVal)
    get_TransactionState(pVal)
      => ComCall(4, this.p, CrmTransactionState.Ptr, pVal)
    get_StructuredRecords(pVal)
      => ComCall(5, this.p, VARIANT_BOOL.Ptr, pVal)
    GetLogRecord(dwIndex, pCrmLogRec)
      => ComCall(6, this.p, UInt32, dwIndex, CrmLogRecordRead.Ptr, pCrmLogRec)
    GetLogRecordVariants(IndexNumber, pLogRecord)
      => ComCall(7, this.p, VARIANT, IndexNumber, VARIANT.Ptr, pLogRecord)
}
struct ICrmMonitorClerks extends IDispatch {
    static IID := "{70C8E442-C7ED-11D1-82FB-00A0C91EEDE9}"
    Item(Index, pItem)
      => ComCall(7, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
    get__NewEnum(pVal)
      => ComCall(8, this.p, IUnknown.Ptr, pVal)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    ProgIdCompensator(Index, pItem)
      => ComCall(10, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
    Description(Index, pItem)
      => ComCall(11, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
    TransactionUOW(Index, pItem)
      => ComCall(12, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
    ActivityId(Index, pItem)
      => ComCall(13, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
}
struct ICrmMonitor extends IUnknown {
    static IID := "{70C8E443-C7ED-11D1-82FB-00A0C91EEDE9}"
    GetClerks(pClerks)
      => ComCall(3, this.p, ICrmMonitorClerks.Ptr, pClerks)
    HoldClerk(Index, pItem)
      => ComCall(4, this.p, VARIANT, Index, VARIANT.Ptr, pItem)
}
struct ICrmFormatLogRecords extends IUnknown {
    static IID := "{9C51D821-C98B-11D1-82FB-00A0C91EEDE9}"
    GetColumnCount(plColumnCount)
      => ComCall(3, this.p, Int32.Ptr, plColumnCount)
    GetColumnHeaders(pHeaders)
      => ComCall(4, this.p, VARIANT.Ptr, pHeaders)
    GetColumn(CrmLogRec, pFormattedLogRecord)
      => ComCall(5, this.p, CrmLogRecordRead, CrmLogRec, VARIANT.Ptr, pFormattedLogRecord)
    GetColumnVariants(LogRecord, pFormattedLogRecord)
      => ComCall(6, this.p, VARIANT, LogRecord, VARIANT.Ptr, pFormattedLogRecord)
}
struct CSC_InheritanceConfig extends Int32 {
    static CSC_Inherit := 0
    static CSC_Ignore := 1
}
struct CSC_ThreadPool extends Int32 {
    static CSC_ThreadPoolNone := 0
    static CSC_ThreadPoolInherit := 1
    static CSC_STAThreadPool := 2
    static CSC_MTAThreadPool := 3
}
struct CSC_Binding extends Int32 {
    static CSC_NoBinding := 0
    static CSC_BindToPoolThread := 1
}
struct CSC_TransactionConfig extends Int32 {
    static CSC_NoTransaction := 0
    static CSC_IfContainerIsTransactional := 1
    static CSC_CreateTransactionIfNecessary := 2
    static CSC_NewTransaction := 3
}
struct CSC_SynchronizationConfig extends Int32 {
    static CSC_NoSynchronization := 0
    static CSC_IfContainerIsSynchronized := 1
    static CSC_NewSynchronizationIfNecessary := 2
    static CSC_NewSynchronization := 3
}
struct CSC_TrackerConfig extends Int32 {
    static CSC_DontUseTracker := 0
    static CSC_UseTracker := 1
}
struct CSC_PartitionConfig extends Int32 {
    static CSC_NoPartition := 0
    static CSC_InheritPartition := 1
    static CSC_NewPartition := 2
}
struct CSC_IISIntrinsicsConfig extends Int32 {
    static CSC_NoIISIntrinsics := 0
    static CSC_InheritIISIntrinsics := 1
}
struct CSC_COMTIIntrinsicsConfig extends Int32 {
    static CSC_NoCOMTIIntrinsics := 0
    static CSC_InheritCOMTIIntrinsics := 1
}
struct CSC_SxsConfig extends Int32 {
    static CSC_NoSxs := 0
    static CSC_InheritSxs := 1
    static CSC_NewSxs := 2
}
struct IServiceIISIntrinsicsConfig extends IUnknown {
    static IID := "{1A0CF920-D452-46F4-BC36-48118D54EA52}"
    IISIntrinsicsConfig(iisIntrinsicsConfig)
      => ComCall(3, this.p, CSC_IISIntrinsicsConfig, iisIntrinsicsConfig)
}
struct IServiceComTIIntrinsicsConfig extends IUnknown {
    static IID := "{09E6831E-04E1-4ED4-9D0F-E8B168BAFEAF}"
    ComTIIntrinsicsConfig(comtiIntrinsicsConfig)
      => ComCall(3, this.p, CSC_COMTIIntrinsicsConfig, comtiIntrinsicsConfig)
}
struct IServiceSxsConfig extends IUnknown {
    static IID := "{C7CD7379-F3F2-4634-811B-703281D73E08}"
    SxsConfig(scsConfig)
      => ComCall(3, this.p, CSC_SxsConfig, scsConfig)
    SxsName(szSxsName)
      => ComCall(4, this.p, "Str", szSxsName)
    SxsDirectory(szSxsDirectory)
      => ComCall(5, this.p, "Str", szSxsDirectory)
}
struct ICheckSxsConfig extends IUnknown {
    static IID := "{0FF5A96F-11FC-47D1-BAA6-25DD347E7242}"
    IsSameSxsConfig(wszSxsName, wszSxsDirectory, wszSxsAppName)
      => ComCall(3, this.p, "Str", wszSxsName, "Str", wszSxsDirectory, "Str", wszSxsAppName)
}
struct IServiceInheritanceConfig extends IUnknown {
    static IID := "{92186771-D3B4-4D77-A8EA-EE842D586F35}"
    ContainingContextTreatment(inheritanceConfig)
      => ComCall(3, this.p, CSC_InheritanceConfig, inheritanceConfig)
}
struct IServiceThreadPoolConfig extends IUnknown {
    static IID := "{186D89BC-F277-4BCC-80D5-4DF7B836EF4A}"
    SelectThreadPool(threadPool)
      => ComCall(3, this.p, CSC_ThreadPool, threadPool)
    SetBindingInfo(binding)
      => ComCall(4, this.p, CSC_Binding, binding)
}
struct IServiceTransactionConfigBase extends IUnknown {
    static IID := "{772B3FBE-6FFD-42FB-B5F8-8F9B260F3810}"
    ConfigureTransaction(transactionConfig)
      => ComCall(3, this.p, CSC_TransactionConfig, transactionConfig)
    IsolationLevel(option)
      => ComCall(4, this.p, COMAdminTxIsolationLevelOptions, option)
    TransactionTimeout(ulTimeoutSec)
      => ComCall(5, this.p, UInt32, ulTimeoutSec)
    BringYourOwnTransaction(szTipURL)
      => ComCall(6, this.p, "Str", szTipURL)
    NewTransactionDescription(szTxDesc)
      => ComCall(7, this.p, "Str", szTxDesc)
}
struct IServiceTransactionConfig extends IServiceTransactionConfigBase {
    static IID := "{59F4C2A3-D3D7-4A31-B6E4-6AB3177C50B9}"
    ConfigureBYOT(pITxByot?)
      => ComCall(8, this.p, ITransaction, pITxByot?)
}
struct IServiceSysTxnConfig extends IServiceTransactionConfig {
    static IID := "{33CAF1A1-FCB8-472B-B45E-967448DED6D8}"
    ConfigureBYOTSysTxn(pTxProxy)
      => ComCall(9, this.p, ITransactionProxy, pTxProxy)
}
struct IServiceSynchronizationConfig extends IUnknown {
    static IID := "{FD880E81-6DCE-4C58-AF83-A208846C0030}"
    ConfigureSynchronization(synchConfig)
      => ComCall(3, this.p, CSC_SynchronizationConfig, synchConfig)
}
struct IServiceTrackerConfig extends IUnknown {
    static IID := "{6C3A3E1D-0BA6-4036-B76F-D0404DB816C9}"
    TrackerConfig(trackerConfig, szTrackerAppName, szTrackerCtxName)
      => ComCall(3, this.p, CSC_TrackerConfig, trackerConfig, "Str", szTrackerAppName, "Str", szTrackerCtxName)
}
struct IServicePartitionConfig extends IUnknown {
    static IID := "{80182D03-5EA4-4831-AE97-55BEFFC2E590}"
    PartitionConfig(partitionConfig)
      => ComCall(3, this.p, CSC_PartitionConfig, partitionConfig)
    PartitionID(guidPartitionID)
      => ComCall(4, this.p, GUID.Ptr, guidPartitionID)
}
struct IServiceCall extends IUnknown {
    static IID := "{BD3E2E12-42DD-40F4-A09A-95A50C58304B}"
    OnCall()
      => ComCall(3, this.p)
}
struct IAsyncErrorNotify extends IUnknown {
    static IID := "{FE6777FB-A674-4177-8F32-6D707E113484}"
    OnError(hr)
      => ComCall(3, this.p, HRESULT, hr)
}
struct IServiceActivity extends IUnknown {
    static IID := "{67532E0C-9E2F-4450-A354-035633944E17}"
    SynchronousCall(pIServiceCall?)
      => ComCall(3, this.p, IServiceCall, pIServiceCall?)
    AsynchronousCall(pIServiceCall?)
      => ComCall(4, this.p, IServiceCall, pIServiceCall?)
    BindToCurrentThread()
      => ComCall(5, this.p)
    UnbindFromThread()
      => ComCall(6, this.p)
}
struct IThreadPoolKnobs extends IUnknown {
    static IID := "{51372AF7-CAE7-11CF-BE81-00AA00A2FA25}"
    GetMaxThreads(plcMaxThreads)
      => ComCall(3, this.p, Int32.Ptr, plcMaxThreads)
    GetCurrentThreads(plcCurrentThreads)
      => ComCall(4, this.p, Int32.Ptr, plcCurrentThreads)
    SetMaxThreads(lcMaxThreads)
      => ComCall(5, this.p, Int32, lcMaxThreads)
    GetDeleteDelay(pmsecDeleteDelay)
      => ComCall(6, this.p, Int32.Ptr, pmsecDeleteDelay)
    SetDeleteDelay(msecDeleteDelay)
      => ComCall(7, this.p, Int32, msecDeleteDelay)
    GetMaxQueuedRequests(plcMaxQueuedRequests)
      => ComCall(8, this.p, Int32.Ptr, plcMaxQueuedRequests)
    GetCurrentQueuedRequests(plcCurrentQueuedRequests)
      => ComCall(9, this.p, Int32.Ptr, plcCurrentQueuedRequests)
    SetMaxQueuedRequests(lcMaxQueuedRequests)
      => ComCall(10, this.p, Int32, lcMaxQueuedRequests)
    SetMinThreads(lcMinThreads)
      => ComCall(11, this.p, Int32, lcMinThreads)
    SetQueueDepth(lcQueueDepth)
      => ComCall(12, this.p, Int32, lcQueueDepth)
}
struct IComStaThreadPoolKnobs extends IUnknown {
    static IID := "{324B64FA-33B6-11D2-98B7-00C04F8EE1C4}"
    SetMinThreadCount(minThreads)
      => ComCall(3, this.p, UInt32, minThreads)
    GetMinThreadCount(minThreads)
      => ComCall(4, this.p, UInt32.Ptr, minThreads)
    SetMaxThreadCount(maxThreads)
      => ComCall(5, this.p, UInt32, maxThreads)
    GetMaxThreadCount(maxThreads)
      => ComCall(6, this.p, UInt32.Ptr, maxThreads)
    SetActivityPerThread(activitiesPerThread)
      => ComCall(7, this.p, UInt32, activitiesPerThread)
    GetActivityPerThread(activitiesPerThread)
      => ComCall(8, this.p, UInt32.Ptr, activitiesPerThread)
    SetActivityRatio(activityRatio)
      => ComCall(9, this.p, Float64, activityRatio)
    GetActivityRatio(activityRatio)
      => ComCall(10, this.p, Float64.Ptr, activityRatio)
    GetThreadCount(pdwThreads)
      => ComCall(11, this.p, UInt32.Ptr, pdwThreads)
    GetQueueDepth(pdwQDepth)
      => ComCall(12, this.p, UInt32.Ptr, pdwQDepth)
    SetQueueDepth(dwQDepth)
      => ComCall(13, this.p, Int32, dwQDepth)
}
struct IComMtaThreadPoolKnobs extends IUnknown {
    static IID := "{F9A76D2E-76A5-43EB-A0C4-49BEC8E48480}"
    MTASetMaxThreadCount(dwMaxThreads)
      => ComCall(3, this.p, UInt32, dwMaxThreads)
    MTAGetMaxThreadCount(pdwMaxThreads)
      => ComCall(4, this.p, UInt32.Ptr, pdwMaxThreads)
    MTASetThrottleValue(dwThrottle)
      => ComCall(5, this.p, UInt32, dwThrottle)
    MTAGetThrottleValue(pdwThrottle)
      => ComCall(6, this.p, UInt32.Ptr, pdwThrottle)
}
struct IComStaThreadPoolKnobs2 extends IComStaThreadPoolKnobs {
    static IID := "{73707523-FF9A-4974-BF84-2108DC213740}"
    GetMaxCPULoad(pdwLoad)
      => ComCall(14, this.p, UInt32.Ptr, pdwLoad)
    SetMaxCPULoad(pdwLoad)
      => ComCall(15, this.p, Int32, pdwLoad)
    GetCPUMetricEnabled(pbMetricEnabled)
      => ComCall(16, this.p, BOOL.Ptr, pbMetricEnabled)
    SetCPUMetricEnabled(bMetricEnabled)
      => ComCall(17, this.p, BOOL, bMetricEnabled)
    GetCreateThreadsAggressively(pbMetricEnabled)
      => ComCall(18, this.p, BOOL.Ptr, pbMetricEnabled)
    SetCreateThreadsAggressively(bMetricEnabled)
      => ComCall(19, this.p, BOOL, bMetricEnabled)
    GetMaxCSR(pdwCSR)
      => ComCall(20, this.p, UInt32.Ptr, pdwCSR)
    SetMaxCSR(dwCSR)
      => ComCall(21, this.p, Int32, dwCSR)
    GetWaitTimeForThreadCleanup(pdwThreadCleanupWaitTime)
      => ComCall(22, this.p, UInt32.Ptr, pdwThreadCleanupWaitTime)
    SetWaitTimeForThreadCleanup(dwThreadCleanupWaitTime)
      => ComCall(23, this.p, Int32, dwThreadCleanupWaitTime)
}
struct IProcessInitializer extends IUnknown {
    static IID := "{1113F52D-DC7F-4943-AED6-88D04027E32A}"
    Startup(punkProcessControl?)
      => ComCall(3, this.p, IUnknown, punkProcessControl?)
    Shutdown()
      => ComCall(4, this.p)
}
struct IServicePoolConfig extends IUnknown {
    static IID := "{A9690656-5BCA-470C-8451-250C1F43A33E}"
    put_MaxPoolSize(dwMaxPool)
      => ComCall(3, this.p, UInt32, dwMaxPool)
    get_MaxPoolSize(pdwMaxPool)
      => ComCall(4, this.p, UInt32.Ptr, pdwMaxPool)
    put_MinPoolSize(dwMinPool)
      => ComCall(5, this.p, UInt32, dwMinPool)
    get_MinPoolSize(pdwMinPool)
      => ComCall(6, this.p, UInt32.Ptr, pdwMinPool)
    put_CreationTimeout(dwCreationTimeout)
      => ComCall(7, this.p, UInt32, dwCreationTimeout)
    get_CreationTimeout(pdwCreationTimeout)
      => ComCall(8, this.p, UInt32.Ptr, pdwCreationTimeout)
    put_TransactionAffinity(fTxAffinity)
      => ComCall(9, this.p, BOOL, fTxAffinity)
    get_TransactionAffinity(pfTxAffinity)
      => ComCall(10, this.p, BOOL.Ptr, pfTxAffinity)
    put_ClassFactory(pFactory)
      => ComCall(11, this.p, IClassFactory, pFactory)
    get_ClassFactory(pFactory)
      => ComCall(12, this.p, IClassFactory.Ptr, pFactory)
}
struct IServicePool extends IUnknown {
    static IID := "{B302DF81-EA45-451E-99A2-09F9FD1B1E13}"
    Initialize(pPoolConfig)
      => ComCall(3, this.p, IUnknown, pPoolConfig)
    GetObject(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Shutdown()
      => ComCall(5, this.p)
}
struct IManagedPooledObj extends IUnknown {
    static IID := "{C5DA4BEA-1B42-4437-8926-B6A38860A770}"
    SetHeld(m_bHeld)
      => ComCall(3, this.p, BOOL, m_bHeld)
}
struct IManagedPoolAction extends IUnknown {
    static IID := "{DA91B74E-5388-4783-949D-C1CD5FB00506}"
    LastRelease()
      => ComCall(3, this.p)
}
struct IManagedObjectInfo extends IUnknown {
    static IID := "{1427C51A-4584-49D8-90A0-C50D8086CBE9}"
    GetIUnknown(pUnk)
      => ComCall(3, this.p, IUnknown.Ptr, pUnk)
    GetIObjectControl(pCtrl)
      => ComCall(4, this.p, IObjectControl.Ptr, pCtrl)
    SetInPool(bInPool, pPooledObj)
      => ComCall(5, this.p, BOOL, bInPool, IManagedPooledObj, pPooledObj)
    SetWrapperStrength(bStrong)
      => ComCall(6, this.p, BOOL, bStrong)
}
struct IAppDomainHelper extends IDispatch {
    static IID := "{C7B67079-8255-42C6-9EC0-6994A3548780}"
    Initialize(pUnkAD, __MIDL__IAppDomainHelper0000, pPool)
      => ComCall(7, this.p, IUnknown, pUnkAD, IntPtr, __MIDL__IAppDomainHelper0000, Struct.Ptr, pPool)
    DoCallback(pUnkAD, __MIDL__IAppDomainHelper0001, pPool)
      => ComCall(8, this.p, IUnknown, pUnkAD, IntPtr, __MIDL__IAppDomainHelper0001, Struct.Ptr, pPool)
}
struct IAssemblyLocator extends IDispatch {
    static IID := "{391FFBB9-A8EE-432A-ABC8-BAA238DAB90F}"
    GetModules(applicationDir, applicationName, assemblyName, pModules)
      => ComCall(7, this.p, BSTR, applicationDir, BSTR, applicationName, BSTR, assemblyName, SAFEARRAY.Ptr.Ptr, pModules)
}
struct IManagedActivationEvents extends IUnknown {
    static IID := "{A5F325AF-572F-46DA-B8AB-827C3D95D99E}"
    CreateManagedStub(pInfo, fDist)
      => ComCall(3, this.p, IManagedObjectInfo, pInfo, BOOL, fDist)
    DestroyManagedStub(pInfo)
      => ComCall(4, this.p, IManagedObjectInfo, pInfo)
}
struct ISendMethodEvents extends IUnknown {
    static IID := "{2732FD59-B2B4-4D44-878C-8B8F09626008}"
    SendMethodCall(pIdentity, riid, dwMeth)
      => ComCall(3, this.p, Struct.Ptr, pIdentity, GUID.Ptr, riid, UInt32, dwMeth)
    SendMethodReturn(pIdentity, riid, dwMeth, hrCall, hrServer)
      => ComCall(4, this.p, Struct.Ptr, pIdentity, GUID.Ptr, riid, UInt32, dwMeth, HRESULT, hrCall, HRESULT, hrServer)
}
struct ITransactionResourcePool extends IUnknown {
    static IID := "{C5FEB7C1-346A-11D1-B1CC-00AA00BA3258}"
    PutResource(pPool, pUnk)
      => ComCall(3, this.p, IObjPool, pPool, IUnknown, pUnk)
    GetResource(pPool, ppUnk)
      => ComCall(4, this.p, IObjPool, pPool, IUnknown.Ptr, ppUnk)
}
struct IMTSCall extends IUnknown {
    static IID := "{51372AEF-CAE7-11CF-BE81-00AA00A2FA25}"
    OnCall()
      => ComCall(3, this.p)
}
struct IContextProperties extends IUnknown {
    static IID := "{D396DA85-BF8F-11D1-BBAE-00C04FC2FA5F}"
    Count(plCount)
      => ComCall(3, this.p, Int32.Ptr, plCount)
    GetProperty(name, pProperty)
      => ComCall(4, this.p, BSTR, name, VARIANT.Ptr, pProperty)
    EnumNames(ppenum)
      => ComCall(5, this.p, IEnumNames.Ptr, ppenum)
    SetProperty(name, property)
      => ComCall(6, this.p, BSTR, name, VARIANT, property)
    RemoveProperty(name)
      => ComCall(7, this.p, BSTR, name)
}
struct IObjPool extends IUnknown {
    static IID := "{7D8805A0-2EA7-11D1-B1CC-00AA00BA3258}"
    Reserved1()
      => ComCall(3, this.p, "void")
    Reserved2()
      => ComCall(4, this.p, "void")
    Reserved3()
      => ComCall(5, this.p, "void")
    Reserved4()
      => ComCall(6, this.p, "void")
    PutEndTx(pObj)
      => ComCall(7, this.p, IUnknown, pObj, "void")
    Reserved5()
      => ComCall(8, this.p, "void")
    Reserved6()
      => ComCall(9, this.p, "void")
}
struct ITransactionProperty extends IUnknown {
    static IID := "{788EA814-87B1-11D1-BBA6-00C04FC2FA5F}"
    Reserved1()
      => ComCall(3, this.p, "void")
    Reserved2()
      => ComCall(4, this.p, "void")
    Reserved3()
      => ComCall(5, this.p, "void")
    Reserved4()
      => ComCall(6, this.p, "void")
    Reserved5()
      => ComCall(7, this.p, "void")
    Reserved6()
      => ComCall(8, this.p, "void")
    Reserved7()
      => ComCall(9, this.p, "void")
    Reserved8()
      => ComCall(10, this.p, "void")
    Reserved9()
      => ComCall(11, this.p, "void")
    GetTransactionResourcePool(ppTxPool)
      => ComCall(12, this.p, ITransactionResourcePool.Ptr, ppTxPool)
    Reserved10()
      => ComCall(13, this.p, "void")
    Reserved11()
      => ComCall(14, this.p, "void")
    Reserved12()
      => ComCall(15, this.p, "void")
    Reserved13()
      => ComCall(16, this.p, "void")
    Reserved14()
      => ComCall(17, this.p, "void")
    Reserved15()
      => ComCall(18, this.p, "void")
    Reserved16()
      => ComCall(19, this.p, "void")
    Reserved17()
      => ComCall(20, this.p, "void")
}
struct IMTSActivity extends IUnknown {
    static IID := "{51372AF0-CAE7-11CF-BE81-00AA00A2FA25}"
    SynchronousCall(pCall)
      => ComCall(3, this.p, IMTSCall, pCall)
    AsyncCall(pCall)
      => ComCall(4, this.p, IMTSCall, pCall)
    Reserved1()
      => ComCall(5, this.p, "void")
    BindToCurrentThread()
      => ComCall(6, this.p)
    UnbindFromThread()
      => ComCall(7, this.p)
}
struct AutoSvcs_Error_Constants extends UInt32 {
    static mtsErrCtxAborted := 2147803138
    static mtsErrCtxAborting := 2147803139
    static mtsErrCtxNoContext := 2147803140
    static mtsErrCtxNotRegistered := 2147803141
    static mtsErrCtxSynchTimeout := 2147803142
    static mtsErrCtxOldReference := 2147803143
    static mtsErrCtxRoleNotFound := 2147803148
    static mtsErrCtxNoSecurity := 2147803149
    static mtsErrCtxWrongThread := 2147803150
    static mtsErrCtxTMNotAvailable := 2147803151
    static comQCErrApplicationNotQueued := 2148599296
    static comQCErrNoQueueableInterfaces := 2148599297
    static comQCErrQueuingServiceNotAvailable := 2148599298
    static comQCErrQueueTransactMismatch := 2148599299
    static comqcErrRecorderMarshalled := 2148599300
    static comqcErrOutParam := 2148599301
    static comqcErrRecorderNotTrusted := 2148599302
    static comqcErrPSLoad := 2148599303
    static comqcErrMarshaledObjSameTxn := 2148599304
    static comqcErrInvalidMessage := 2148599376
    static comqcErrMsmqSidUnavailable := 2148599377
    static comqcErrWrongMsgExtension := 2148599378
    static comqcErrMsmqServiceUnavailable := 2148599379
    static comqcErrMsgNotAuthenticated := 2148599380
    static comqcErrMsmqConnectorUsed := 2148599381
    static comqcErrBadMarshaledObject := 2148599382
}
struct LockModes extends Int32 {
    static LockSetGet := 0
    static LockMethod := 1
}
struct ReleaseModes extends Int32 {
    static Standard := 0
    static Process := 1
}
struct CRMFLAGS extends Int32 {
    static CRMFLAG_FORGETTARGET := 1
    static CRMFLAG_WRITTENDURINGPREPARE := 2
    static CRMFLAG_WRITTENDURINGCOMMIT := 4
    static CRMFLAG_WRITTENDURINGABORT := 8
    static CRMFLAG_WRITTENDURINGRECOVERY := 16
    static CRMFLAG_WRITTENDURINGREPLAY := 32
    static CRMFLAG_REPLAYINPROGRESS := 64
}
struct CRMREGFLAGS extends Int32 {
    static CRMREGFLAG_PREPAREPHASE := 1
    static CRMREGFLAG_COMMITPHASE := 2
    static CRMREGFLAG_ABORTPHASE := 4
    static CRMREGFLAG_ALLPHASES := 7
    static CRMREGFLAG_FAILIFINDOUBTSREMAIN := 16
}
