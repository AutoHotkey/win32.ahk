#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HANDLE, PWSTR}
#Import "..\Security\Types.ahk" {SAFER_LEVEL_HANDLE}

SaferCloseLevel(hLevelHandle)
  => DllCall("ADVAPI32.dll\SaferCloseLevel", SAFER_LEVEL_HANDLE, hLevelHandle, BOOL)
SaferComputeTokenFromLevel(LevelHandle, InAccessToken?, OutAccessToken, dwFlags, lpReserved?)
  => DllCall("ADVAPI32.dll\SaferComputeTokenFromLevel", SAFER_LEVEL_HANDLE, LevelHandle, HANDLE, InAccessToken?, HANDLE.Ptr, OutAccessToken, SAFER_COMPUTE_TOKEN_FROM_LEVEL_FLAGS, dwFlags, Struct.Ptr, lpReserved?, BOOL)
SaferCreateLevel(dwScopeId, dwLevelId, OpenFlags, pLevelHandle)
  => DllCall("ADVAPI32.dll\SaferCreateLevel", UInt32, dwScopeId, UInt32, dwLevelId, UInt32, OpenFlags, SAFER_LEVEL_HANDLE.Ptr, pLevelHandle, "Ptr", 0, BOOL)
SaferGetLevelInformation(LevelHandle, dwInfoType, lpQueryBuffer?, lpdwOutBufferSize)
  => DllCall("ADVAPI32.dll\SaferGetLevelInformation", SAFER_LEVEL_HANDLE, LevelHandle, SAFER_OBJECT_INFO_CLASS, dwInfoType, Struct.Ptr, lpQueryBuffer?, UInt32, lpQueryBuffer?.Size ?? 0, UInt32.Ptr, lpdwOutBufferSize, BOOL)
SaferGetPolicyInformation(dwScopeId, SaferPolicyInfoClass, InfoBuffer, InfoBufferRetSize)
  => DllCall("ADVAPI32.dll\SaferGetPolicyInformation", UInt32, dwScopeId, SAFER_POLICY_INFO_CLASS, SaferPolicyInfoClass, UInt32, InfoBuffer.Size, Struct.Ptr, InfoBuffer, UInt32.Ptr, InfoBufferRetSize, "Ptr", 0, BOOL)
SaferIdentifyLevel(pCodeProperties?, pLevelHandle, lpReserved?)
  => DllCall("ADVAPI32.dll\SaferIdentifyLevel", UInt32, pCodeProperties?.Length ?? 0, SAFER_CODE_PROPERTIES_V2.Ptr, pCodeProperties?, SAFER_LEVEL_HANDLE.Ptr, pLevelHandle, Struct.Ptr, lpReserved?, BOOL)
SaferRecordEventLogEntry(hLevel, szTargetPath)
  => DllCall("ADVAPI32.dll\SaferRecordEventLogEntry", SAFER_LEVEL_HANDLE, hLevel, "Str", szTargetPath, "Ptr", 0, BOOL)
SaferSetLevelInformation(LevelHandle, dwInfoType, lpQueryBuffer)
  => DllCall("ADVAPI32.dll\SaferSetLevelInformation", SAFER_LEVEL_HANDLE, LevelHandle, SAFER_OBJECT_INFO_CLASS, dwInfoType, Struct.Ptr, lpQueryBuffer, UInt32, lpQueryBuffer.Size, BOOL)
SaferSetPolicyInformation(dwScopeId, SaferPolicyInfoClass, InfoBuffer)
  => DllCall("ADVAPI32.dll\SaferSetPolicyInformation", UInt32, dwScopeId, SAFER_POLICY_INFO_CLASS, SaferPolicyInfoClass, UInt32, InfoBuffer.Size, Struct.Ptr, InfoBuffer, "Ptr", 0, BOOL)
SaferiIsExecutableFileType(szFullPathname, bFromShellExecute)
  => DllCall("ADVAPI32.dll\SaferiIsExecutableFileType", "Str", szFullPathname, BOOLEAN, bFromShellExecute, BOOL)
