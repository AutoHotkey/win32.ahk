#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HMODULE, PWSTR}

EmptyWorkingSet(hProcess)
  => DllCall("PSAPI.dll\EmptyWorkingSet", HANDLE, hProcess, BOOL)
EnumProcessModules(hProcess, lphModule, lpcbNeeded)
  => DllCall("PSAPI.dll\EnumProcessModules", HANDLE, hProcess, HMODULE.Ptr, lphModule, UInt32, lphModule.Size, UInt32.Ptr, lpcbNeeded, BOOL)
EnumProcessModulesEx(hProcess, lphModule, lpcbNeeded, dwFilterFlag)
  => DllCall("PSAPI.dll\EnumProcessModulesEx", HANDLE, hProcess, HMODULE.Ptr, lphModule, UInt32, lphModule.Size, UInt32.Ptr, lpcbNeeded, ENUM_PROCESS_MODULES_EX_FLAGS, dwFilterFlag, BOOL)
EnumProcesses(lpidProcess, lpcbNeeded)
  => DllCall("PSAPI.dll\EnumProcesses", UInt32.Ptr, lpidProcess, UInt32, lpidProcess.Size, UInt32.Ptr, lpcbNeeded, BOOL)
GetMappedFileName(hProcess, lpv, lpFilename)
  => DllCall("PSAPI.dll\GetMappedFileNameW", HANDLE, hProcess, Struct.Ptr, lpv, PWSTR, lpFilename, UInt32, lpFilename.Length, UInt32)
GetModuleBaseName(hProcess, hModule1?, lpBaseName)
  => DllCall("PSAPI.dll\GetModuleBaseNameW", HANDLE, hProcess, HMODULE, hModule1?, PWSTR, lpBaseName, UInt32, lpBaseName.Length, UInt32)
GetModuleFileNameEx(hProcess?, hModule1?, lpFilename)
  => DllCall("PSAPI.dll\GetModuleFileNameExW", HANDLE, hProcess?, HMODULE, hModule1?, PWSTR, lpFilename, UInt32, lpFilename.Length, UInt32)
GetModuleInformation(hProcess, hModule1, lpmodinfo, cb)
  => DllCall("PSAPI.dll\GetModuleInformation", HANDLE, hProcess, HMODULE, hModule1, MODULEINFO.Ptr, lpmodinfo, UInt32, cb, BOOL)
GetWsChanges(hProcess, lpWatchInfo)
  => DllCall("PSAPI.dll\GetWsChanges", HANDLE, hProcess, PSAPI_WS_WATCH_INFORMATION.Ptr, lpWatchInfo, UInt32, lpWatchInfo.Size, BOOL)
GetWsChangesEx(hProcess, lpWatchInfoEx, cb)
  => DllCall("PSAPI.dll\GetWsChangesEx", HANDLE, hProcess, PSAPI_WS_WATCH_INFORMATION_EX.Ptr, lpWatchInfoEx, UInt32.Ptr, cb, BOOL)
InitializeProcessForWsWatch(hProcess)
  => DllCall("PSAPI.dll\InitializeProcessForWsWatch", HANDLE, hProcess, BOOL)
