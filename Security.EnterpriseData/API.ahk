#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, NTSTATUS, PWSTR}
#Import "..\Storage.Packaging.Appx\Types.ahk" {PACKAGE_ID}

ProtectFileToEnterpriseIdentity(fileOrFolderPath, identity)
  => DllCall("efswrt.dll\ProtectFileToEnterpriseIdentity", "Str", fileOrFolderPath, "Str", identity, "HRESULT")
SrpCloseThreadNetworkContext(threadNetworkContext)
  => DllCall("srpapi.dll\SrpCloseThreadNetworkContext", HTHREAD_NETWORK_CONTEXT.Ptr, threadNetworkContext, "HRESULT")
SrpCreateThreadNetworkContext(enterpriseId, threadNetworkContext)
  => DllCall("srpapi.dll\SrpCreateThreadNetworkContext", "Str", enterpriseId, HTHREAD_NETWORK_CONTEXT.Ptr, threadNetworkContext, "HRESULT")
SrpDisablePermissiveModeFileEncryption()
  => DllCall("srpapi.dll\SrpDisablePermissiveModeFileEncryption", "HRESULT")
SrpDoesPolicyAllowAppExecution(packageId, isAllowed)
  => DllCall("srpapi.dll\SrpDoesPolicyAllowAppExecution", PACKAGE_ID.Ptr, packageId, BOOL.Ptr, isAllowed, "HRESULT")
SrpEnablePermissiveModeFileEncryption(enterpriseId?)
  => DllCall("srpapi.dll\SrpEnablePermissiveModeFileEncryption", "Str", enterpriseId?, "HRESULT")
SrpGetEnterpriseIds(tokenHandle, numberOfBytes := enterpriseIds.Size, enterpriseIds?, enterpriseIdCount)
  => DllCall("srpapi.dll\SrpGetEnterpriseIds", HANDLE, tokenHandle, UInt32.Ptr, numberOfBytes?, PWSTR.Ptr, enterpriseIds?, UInt32.Ptr, enterpriseIdCount, "HRESULT")
SrpGetEnterprisePolicy(tokenHandle, policyFlags)
  => DllCall("srpapi.dll\SrpGetEnterprisePolicy", HANDLE, tokenHandle, ENTERPRISE_DATA_POLICIES.Ptr, policyFlags, "HRESULT")
SrpHostingInitialize(Version, Type, pvData, cbData)
  => DllCall("srpapi.dll\SrpHostingInitialize", SRPHOSTING_VERSION, Version, SRPHOSTING_TYPE, Type, Struct.Ptr, pvData, UInt32, cbData, "HRESULT")
SrpHostingTerminate(Type)
  => DllCall("srpapi.dll\SrpHostingTerminate", SRPHOSTING_TYPE, Type, "void")
SrpIsAllowed(FileInfo)
  => DllCall("srpapi.dll\SrpIsAllowed", SRP_REQUEST.Ptr, FileInfo, NTSTATUS)
SrpIsTokenService(TokenHandle, IsTokenService)
  => DllCall("srpapi.dll\SrpIsTokenService", HANDLE, TokenHandle, UInt8.Ptr, IsTokenService, NTSTATUS)
SrpSetTokenEnterpriseId(tokenHandle, enterpriseId?)
  => DllCall("srpapi.dll\SrpSetTokenEnterpriseId", HANDLE, tokenHandle, "Str", enterpriseId?, "HRESULT")
UnprotectFile(fileOrFolderPath, options?)
  => DllCall("efswrt.dll\UnprotectFile", "Str", fileOrFolderPath, FILE_UNPROTECT_OPTIONS.Ptr, options?, "HRESULT")
