#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch, SAFEARRAY}

struct ICatalog extends IDispatch {
    static IID := "{6EB22870-8A19-11D0-81B6-00A0C9231C29}"
    GetCollection(bstrCollName, ppCatalogCollection)
      => ComCall(7, this.p, BSTR, bstrCollName, IDispatch.Ptr, ppCatalogCollection)
    Connect(bstrConnectString, ppCatalogCollection)
      => ComCall(8, this.p, BSTR, bstrConnectString, IDispatch.Ptr, ppCatalogCollection)
    get_MajorVersion(retval)
      => ComCall(9, this.p, Int32.Ptr, retval)
    get_MinorVersion(retval)
      => ComCall(10, this.p, Int32.Ptr, retval)
}
struct IComponentUtil extends IDispatch {
    static IID := "{6EB22873-8A19-11D0-81B6-00A0C9231C29}"
    InstallComponent(bstrDLLFile, bstrTypelibFile, bstrProxyStubDLLFile)
      => ComCall(7, this.p, BSTR, bstrDLLFile, BSTR, bstrTypelibFile, BSTR, bstrProxyStubDLLFile)
    ImportComponent(bstrCLSID)
      => ComCall(8, this.p, BSTR, bstrCLSID)
    ImportComponentByName(bstrProgID)
      => ComCall(9, this.p, BSTR, bstrProgID)
    GetCLSIDs(bstrDLLFile, bstrTypelibFile, aCLSIDs)
      => ComCall(10, this.p, BSTR, bstrDLLFile, BSTR, bstrTypelibFile, SAFEARRAY.Ptr.Ptr, aCLSIDs)
}
struct IPackageUtil extends IDispatch {
    static IID := "{6EB22874-8A19-11D0-81B6-00A0C9231C29}"
    InstallPackage(bstrPackageFile, bstrInstallPath, lOptions)
      => ComCall(7, this.p, BSTR, bstrPackageFile, BSTR, bstrInstallPath, Int32, lOptions)
    ExportPackage(bstrPackageID, bstrPackageFile, lOptions)
      => ComCall(8, this.p, BSTR, bstrPackageID, BSTR, bstrPackageFile, Int32, lOptions)
    ShutdownPackage(bstrPackageID)
      => ComCall(9, this.p, BSTR, bstrPackageID)
}
struct IRemoteComponentUtil extends IDispatch {
    static IID := "{6EB22875-8A19-11D0-81B6-00A0C9231C29}"
    InstallRemoteComponent(bstrServer, bstrPackageID, bstrCLSID)
      => ComCall(7, this.p, BSTR, bstrServer, BSTR, bstrPackageID, BSTR, bstrCLSID)
    InstallRemoteComponentByName(bstrServer, bstrPackageName, bstrProgID)
      => ComCall(8, this.p, BSTR, bstrServer, BSTR, bstrPackageName, BSTR, bstrProgID)
}
struct IRoleAssociationUtil extends IDispatch {
    static IID := "{6EB22876-8A19-11D0-81B6-00A0C9231C29}"
    AssociateRole(bstrRoleID)
      => ComCall(7, this.p, BSTR, bstrRoleID)
    AssociateRoleByName(bstrRoleName)
      => ComCall(8, this.p, BSTR, bstrRoleName)
}
struct MTSPackageInstallOptions extends Int32 {
    static mtsInstallUsers := 1
}
struct MTSPackageExportOptions extends Int32 {
    static mtsExportUsers := 1
}
struct MTSAdminErrorCodes extends Int32 {
    static mtsErrObjectErrors := -2146368511
    static mtsErrObjectInvalid := -2146368510
    static mtsErrKeyMissing := -2146368509
    static mtsErrAlreadyInstalled := -2146368508
    static mtsErrDownloadFailed := -2146368507
    static mtsErrPDFWriteFail := -2146368505
    static mtsErrPDFReadFail := -2146368504
    static mtsErrPDFVersion := -2146368503
    static mtsErrCoReqCompInstalled := -2146368496
    static mtsErrBadPath := -2146368502
    static mtsErrPackageExists := -2146368501
    static mtsErrRoleExists := -2146368500
    static mtsErrCantCopyFile := -2146368499
    static mtsErrNoTypeLib := -2146368498
    static mtsErrNoUser := -2146368497
    static mtsErrInvalidUserids := -2146368496
    static mtsErrNoRegistryCLSID := -2146368495
    static mtsErrBadRegistryProgID := -2146368494
    static mtsErrAuthenticationLevel := -2146368493
    static mtsErrUserPasswdNotValid := -2146368492
    static mtsErrNoRegistryRead := -2146368491
    static mtsErrNoRegistryWrite := -2146368490
    static mtsErrNoRegistryRepair := -2146368489
    static mtsErrCLSIDOrIIDMismatch := -2146368488
    static mtsErrRemoteInterface := -2146368487
    static mtsErrDllRegisterServer := -2146368486
    static mtsErrNoServerShare := -2146368485
    static mtsErrNoAccessToUNC := -2146368484
    static mtsErrDllLoadFailed := -2146368483
    static mtsErrBadRegistryLibID := -2146368482
    static mtsErrPackDirNotFound := -2146368481
    static mtsErrTreatAs := -2146368480
    static mtsErrBadForward := -2146368479
    static mtsErrBadIID := -2146368478
    static mtsErrRegistrarFailed := -2146368477
    static mtsErrCompFileDoesNotExist := -2146368476
    static mtsErrCompFileLoadDLLFail := -2146368475
    static mtsErrCompFileGetClassObj := -2146368474
    static mtsErrCompFileClassNotAvail := -2146368473
    static mtsErrCompFileBadTLB := -2146368472
    static mtsErrCompFileNotInstallable := -2146368471
    static mtsErrNotChangeable := -2146368470
    static mtsErrNotDeletable := -2146368469
    static mtsErrSession := -2146368468
    static mtsErrCompFileNoRegistrar := -2146368460
}
