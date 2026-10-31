#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {SOCKET, SOCKET_ADDRESS_LIST}
#Import "..\Security\Types.ahk" {SID}

NdfCancelIncident(Handle)
  => DllCall("NDFAPI.dll\NdfCancelIncident", Struct.Ptr, Handle, "HRESULT")
NdfCloseIncident(handle)
  => DllCall("NDFAPI.dll\NdfCloseIncident", Struct.Ptr, handle, "HRESULT")
NdfCreateConnectivityIncident(handle)
  => DllCall("NDFAPI.dll\NdfCreateConnectivityIncident", Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateDNSIncident(hostname, queryType, handle)
  => DllCall("NDFAPI.dll\NdfCreateDNSIncident", "Str", hostname, UInt16, queryType, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateGroupingIncident(CloudName?, GroupName?, Identity?, Invitation?, Addresses?, appId?, handle)
  => DllCall("NDFAPI.dll\NdfCreateGroupingIncident", "Str", CloudName?, "Str", GroupName?, "Str", Identity?, "Str", Invitation?, SOCKET_ADDRESS_LIST.Ptr, Addresses?, "Str", appId?, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateIncident(helperClassName, attributes, handle)
  => DllCall("NDFAPI.dll\NdfCreateIncident", "Str", helperClassName, UInt32, attributes.Length, HELPER_ATTRIBUTE.Ptr, attributes, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateNetConnectionIncident(handle, id)
  => DllCall("NDFAPI.dll\NdfCreateNetConnectionIncident", Struct.Ptr.Ptr, handle, GUID, id, "HRESULT")
NdfCreatePnrpIncident(cloudname, peername?, diagnosePublish, appId?, handle)
  => DllCall("NDFAPI.dll\NdfCreatePnrpIncident", "Str", cloudname, "Str", peername?, BOOL, diagnosePublish, "Str", appId?, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateSharingIncident(UNCPath, handle)
  => DllCall("NDFAPI.dll\NdfCreateSharingIncident", "Str", UNCPath, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateWebIncident(url, handle)
  => DllCall("NDFAPI.dll\NdfCreateWebIncident", "Str", url, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateWebIncidentEx(url, useWinHTTP, moduleName?, handle)
  => DllCall("NDFAPI.dll\NdfCreateWebIncidentEx", "Str", url, BOOL, useWinHTTP, "Str", moduleName?, Struct.Ptr.Ptr, handle, "HRESULT")
NdfCreateWinSockIncident(sock, host?, port, appId?, userId?, handle)
  => DllCall("NDFAPI.dll\NdfCreateWinSockIncident", SOCKET, sock, "Str", host?, UInt16, port, "Str", appId?, SID.Ptr, userId?, Struct.Ptr.Ptr, handle, "HRESULT")
NdfDiagnoseIncident(Handle, RootCauseCount, RootCauses, dwWait, dwFlags)
  => DllCall("NDFAPI.dll\NdfDiagnoseIncident", Struct.Ptr, Handle, UInt32.Ptr, RootCauseCount, RootCauseInfo.Ptr.Ptr, RootCauses, UInt32, dwWait, UInt32, dwFlags, "HRESULT")
NdfExecuteDiagnosis(handle, hwnd1?)
  => DllCall("NDFAPI.dll\NdfExecuteDiagnosis", Struct.Ptr, handle, HWND, hwnd1?, "HRESULT")
NdfGetTraceFile(Handle, TraceFileLocation)
  => DllCall("NDFAPI.dll\NdfGetTraceFile", Struct.Ptr, Handle, PWSTR.Ptr, TraceFileLocation, "HRESULT")
NdfRepairIncident(Handle, RepairEx, dwWait)
  => DllCall("NDFAPI.dll\NdfRepairIncident", Struct.Ptr, Handle, RepairInfoEx.Ptr, RepairEx, UInt32, dwWait, "HRESULT")
