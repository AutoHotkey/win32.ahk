#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}
#Import "..\Security\Types.ahk" {PSID, SID_AND_ATTRIBUTES}
#Import "..\System.Registry\Types.ahk" {HKEY}

CreateAppContainerProfile(pszAppContainerName, pszDisplayName, pszDescription, pCapabilities?, ppSidAppContainerSid)
  => DllCall("USERENV.dll\CreateAppContainerProfile", "Str", pszAppContainerName, "Str", pszDisplayName, "Str", pszDescription, SID_AND_ATTRIBUTES.Ptr, pCapabilities?, UInt32, pCapabilities?.Length ?? 0, PSID.Ptr, ppSidAppContainerSid, "HRESULT")
DeleteAppContainerProfile(pszAppContainerName)
  => DllCall("USERENV.dll\DeleteAppContainerProfile", "Str", pszAppContainerName, "HRESULT")
DeriveAppContainerSidFromAppContainerName(pszAppContainerName, ppsidAppContainerSid)
  => DllCall("USERENV.dll\DeriveAppContainerSidFromAppContainerName", "Str", pszAppContainerName, PSID.Ptr, ppsidAppContainerSid, "HRESULT")
DeriveRestrictedAppContainerSidFromAppContainerSidAndRestrictedName(psidAppContainerSid, pszRestrictedAppContainerName, ppsidRestrictedAppContainerSid)
  => DllCall("USERENV.dll\DeriveRestrictedAppContainerSidFromAppContainerSidAndRestrictedName", PSID, psidAppContainerSid, "Str", pszRestrictedAppContainerName, PSID.Ptr, ppsidRestrictedAppContainerSid, "HRESULT")
GetAppContainerFolderPath(pszAppContainerSid, ppszPath)
  => DllCall("USERENV.dll\GetAppContainerFolderPath", "Str", pszAppContainerSid, PWSTR.Ptr, ppszPath, "HRESULT")
GetAppContainerNamedObjectPath(Token?, AppContainerSid?, ObjectPath?, ReturnLength)
  => DllCall("KERNEL32.dll\GetAppContainerNamedObjectPath", HANDLE, Token?, PSID, AppContainerSid?, UInt32, ObjectPath?.Length ?? 0, PWSTR, ObjectPath?, UInt32.Ptr, ReturnLength, BOOL)
GetAppContainerRegistryLocation(desiredAccess, phAppContainerKey)
  => DllCall("USERENV.dll\GetAppContainerRegistryLocation", UInt32, desiredAccess, HKEY.Ptr, phAppContainerKey, "HRESULT")
IsCrossIsolatedEnvironmentClipboardContent(isCrossIsolatedEnvironmentClipboardContent)
  => DllCall("IsolatedWindowsEnvironmentUtils.dll\IsCrossIsolatedEnvironmentClipboardContent", BOOL.Ptr, isCrossIsolatedEnvironmentClipboardContent, "HRESULT")
IsProcessInIsolatedContainer(isProcessInIsolatedContainer)
  => DllCall("api-ms-win-security-isolatedcontainer-l1-1-0.dll\IsProcessInIsolatedContainer", BOOL.Ptr, isProcessInIsolatedContainer, "HRESULT")
IsProcessInIsolatedWindowsEnvironment(isProcessInIsolatedWindowsEnvironment)
  => DllCall("IsolatedWindowsEnvironmentUtils.dll\IsProcessInIsolatedWindowsEnvironment", BOOL.Ptr, isProcessInIsolatedWindowsEnvironment, "HRESULT")
IsProcessInWDAGContainer(Reserved, isProcessInWDAGContainer)
  => DllCall("api-ms-win-security-isolatedcontainer-l1-1-1.dll\IsProcessInWDAGContainer", Struct.Ptr, Reserved, BOOL.Ptr, isProcessInWDAGContainer, "HRESULT")
