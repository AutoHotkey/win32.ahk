#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR, WIN32_ERROR}

RmAddFilter(dwSessionHandle, strModuleName?, pProcess?, strServiceShortName?, FilterAction)
  => DllCall("RstrtMgr.dll\RmAddFilter", UInt32, dwSessionHandle, "Str", strModuleName?, RM_UNIQUE_PROCESS.Ptr, pProcess?, "Str", strServiceShortName?, RM_FILTER_ACTION, FilterAction, WIN32_ERROR)
RmCancelCurrentTask(dwSessionHandle)
  => DllCall("RstrtMgr.dll\RmCancelCurrentTask", UInt32, dwSessionHandle, WIN32_ERROR)
RmEndSession(dwSessionHandle)
  => DllCall("rstrtmgr.dll\RmEndSession", UInt32, dwSessionHandle, WIN32_ERROR)
RmGetFilterList(dwSessionHandle, pbFilterBuf?, cbFilterBufNeeded)
  => DllCall("RstrtMgr.dll\RmGetFilterList", UInt32, dwSessionHandle, UInt8.Ptr, pbFilterBuf?, UInt32, pbFilterBuf?.Size ?? 0, UInt32.Ptr, cbFilterBufNeeded, WIN32_ERROR)
RmGetList(dwSessionHandle, pnProcInfoNeeded, rgAffectedApps?, lpdwRebootReasons)
  => DllCall("rstrtmgr.dll\RmGetList", UInt32, dwSessionHandle, UInt32.Ptr, pnProcInfoNeeded, UInt32.Ptr, rgAffectedApps?.Length ?? 0, RM_PROCESS_INFO.Ptr, rgAffectedApps?, UInt32.Ptr, lpdwRebootReasons, WIN32_ERROR)
RmJoinSession(pSessionHandle, strSessionKey)
  => DllCall("RstrtMgr.dll\RmJoinSession", UInt32.Ptr, pSessionHandle, "Str", strSessionKey, WIN32_ERROR)
RmRegisterResources(dwSessionHandle, rgsFileNames?, rgApplications?, rgsServiceNames?)
  => DllCall("rstrtmgr.dll\RmRegisterResources", UInt32, dwSessionHandle, UInt32, rgsFileNames?.Length ?? 0, PWSTR.Ptr, rgsFileNames?, UInt32, rgApplications?.Length ?? 0, RM_UNIQUE_PROCESS.Ptr, rgApplications?, UInt32, rgsServiceNames?.Length ?? 0, PWSTR.Ptr, rgsServiceNames?, WIN32_ERROR)
RmRemoveFilter(dwSessionHandle, strModuleName?, pProcess?, strServiceShortName?)
  => DllCall("RstrtMgr.dll\RmRemoveFilter", UInt32, dwSessionHandle, "Str", strModuleName?, RM_UNIQUE_PROCESS.Ptr, pProcess?, "Str", strServiceShortName?, WIN32_ERROR)
RmRestart(dwSessionHandle, fnStatus?)
  => DllCall("rstrtmgr.dll\RmRestart", UInt32, dwSessionHandle, "Ptr", 0, RM_WRITE_STATUS_CALLBACK, fnStatus?, WIN32_ERROR)
RmShutdown(dwSessionHandle, lActionFlags, fnStatus?)
  => DllCall("rstrtmgr.dll\RmShutdown", UInt32, dwSessionHandle, UInt32, lActionFlags, RM_WRITE_STATUS_CALLBACK, fnStatus?, WIN32_ERROR)
RmStartSession(pSessionHandle, strSessionKey)
  => DllCall("rstrtmgr.dll\RmStartSession", UInt32.Ptr, pSessionHandle, "Ptr", 0, PWSTR, strSessionKey, WIN32_ERROR)
