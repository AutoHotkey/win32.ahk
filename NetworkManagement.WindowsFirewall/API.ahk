#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}
#Import "..\Security\Types.ahk" {PSID, SID_AND_ATTRIBUTES}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT}

NcFreeNetconProperties(pProps)
  => DllCall("Netshell.dll\NcFreeNetconProperties", NETCON_PROPERTIES.Ptr, pProps, "void")
NcIsValidConnectionName(pszwName)
  => DllCall("Netshell.dll\NcIsValidConnectionName", "Str", pszwName, BOOL)
NetworkIsolationDiagnoseConnectFailureAndGetInfo(wszServerName, netIsoError)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationDiagnoseConnectFailureAndGetInfo", "Str", wszServerName, NETISO_ERROR_TYPE.Ptr, netIsoError, UInt32)
NetworkIsolationEnumAppContainers(Flags, pdwNumPublicAppCs, ppPublicAppCs)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationEnumAppContainers", UInt32, Flags, UInt32.Ptr, pdwNumPublicAppCs, INET_FIREWALL_APP_CONTAINER.Ptr.Ptr, ppPublicAppCs, UInt32)
NetworkIsolationEnumerateAppContainerRules(newEnum)
  => DllCall("Firewallapi.dll\NetworkIsolationEnumerateAppContainerRules", IEnumVARIANT.Ptr, newEnum, "HRESULT")
NetworkIsolationFreeAppContainers(pPublicAppCs)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationFreeAppContainers", INET_FIREWALL_APP_CONTAINER.Ptr, pPublicAppCs, UInt32)
NetworkIsolationGetAppContainerConfig(pdwNumPublicAppCs, appContainerSids)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationGetAppContainerConfig", UInt32.Ptr, pdwNumPublicAppCs, SID_AND_ATTRIBUTES.Ptr.Ptr, appContainerSids, UInt32)
NetworkIsolationGetEnterpriseIdAsync(wszServerName, dwFlags, context?, callback, hOperation)
  => DllCall("Firewallapi.dll\NetworkIsolationGetEnterpriseIdAsync", "Str", wszServerName, UInt32, dwFlags, Struct.Ptr, context?, PNETISO_EDP_ID_CALLBACK_FN, callback, HANDLE.Ptr, hOperation, UInt32)
NetworkIsolationGetEnterpriseIdClose(hOperation, bWaitForOperation)
  => DllCall("Firewallapi.dll\NetworkIsolationGetEnterpriseIdClose", HANDLE, hOperation, BOOL, bWaitForOperation, UInt32)
NetworkIsolationRegisterForAppContainerChanges(flags, callback, context?, registrationObject)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationRegisterForAppContainerChanges", UInt32, flags, PAC_CHANGES_CALLBACK_FN, callback, Struct.Ptr, context?, HANDLE.Ptr, registrationObject, UInt32)
NetworkIsolationSetAppContainerConfig(appContainerSids)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationSetAppContainerConfig", UInt32, appContainerSids.Length, SID_AND_ATTRIBUTES.Ptr, appContainerSids, UInt32)
NetworkIsolationSetupAppContainerBinaries(applicationContainerSid, packageFullName, packageFolder, displayName, bBinariesFullyComputed, binaries)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationSetupAppContainerBinaries", PSID, applicationContainerSid, "Str", packageFullName, "Str", packageFolder, "Str", displayName, BOOL, bBinariesFullyComputed, PWSTR.Ptr, binaries, UInt32, binaries.Length, "HRESULT")
NetworkIsolationUnregisterForAppContainerChanges(registrationObject)
  => DllCall("api-ms-win-net-isolation-l1-1-0.dll\NetworkIsolationUnregisterForAppContainerChanges", HANDLE, registrationObject, UInt32)
