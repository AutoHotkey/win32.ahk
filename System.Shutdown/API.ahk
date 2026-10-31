#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HWND, PWSTR}

AbortSystemShutdown(lpMachineName?)
  => DllCall("ADVAPI32.dll\AbortSystemShutdownW", "Str", lpMachineName?, BOOL)
CheckForHiberboot(pHiberboot, bClearFlag)
  => DllCall("ADVAPI32.dll\CheckForHiberboot", BOOLEAN.Ptr, pHiberboot, BOOLEAN, bClearFlag, UInt32)
ExitWindowsEx(uFlags, dwReason)
  => DllCall("USER32.dll\ExitWindowsEx", EXIT_WINDOWS_FLAGS, uFlags, SHUTDOWN_REASON, dwReason, BOOL)
InitiateShutdown(lpMachineName?, lpMessage?, dwGracePeriod, dwShutdownFlags, dwReason)
  => DllCall("ADVAPI32.dll\InitiateShutdownW", "Str", lpMachineName?, "Str", lpMessage?, UInt32, dwGracePeriod, SHUTDOWN_FLAGS, dwShutdownFlags, SHUTDOWN_REASON, dwReason, UInt32)
InitiateSystemShutdown(lpMachineName?, lpMessage?, dwTimeout, bForceAppsClosed, bRebootAfterShutdown)
  => DllCall("ADVAPI32.dll\InitiateSystemShutdownW", "Str", lpMachineName?, "Str", lpMessage?, UInt32, dwTimeout, BOOL, bForceAppsClosed, BOOL, bRebootAfterShutdown, BOOL)
InitiateSystemShutdownEx(lpMachineName?, lpMessage?, dwTimeout, bForceAppsClosed, bRebootAfterShutdown, dwReason)
  => DllCall("ADVAPI32.dll\InitiateSystemShutdownExW", "Str", lpMachineName?, "Str", lpMessage?, UInt32, dwTimeout, BOOL, bForceAppsClosed, BOOL, bRebootAfterShutdown, SHUTDOWN_REASON, dwReason, BOOL)
LockWorkStation()
  => DllCall("USER32.dll\LockWorkStation", BOOL)
ShutdownBlockReasonCreate(hWnd1, pwszReason)
  => DllCall("USER32.dll\ShutdownBlockReasonCreate", HWND, hWnd1, "Str", pwszReason, BOOL)
ShutdownBlockReasonDestroy(hWnd1)
  => DllCall("USER32.dll\ShutdownBlockReasonDestroy", HWND, hWnd1, BOOL)
ShutdownBlockReasonQuery(hWnd1, pwszBuff?)
  => DllCall("USER32.dll\ShutdownBlockReasonQuery", HWND, hWnd1, PWSTR, pwszBuff?, UInt32.Ptr, pwszBuff?.Length ?? 0, BOOL)
