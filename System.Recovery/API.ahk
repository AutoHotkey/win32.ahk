#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}
#Import "..\System.WindowsProgramming\Types.ahk" {APPLICATION_RECOVERY_CALLBACK}

ApplicationRecoveryFinished(bSuccess)
  => DllCall("KERNEL32.dll\ApplicationRecoveryFinished", BOOL, bSuccess, "void")
ApplicationRecoveryInProgress(pbCancelled)
  => DllCall("KERNEL32.dll\ApplicationRecoveryInProgress", BOOL.Ptr, pbCancelled, "HRESULT")
GetApplicationRecoveryCallback(hProcess, pRecoveryCallback, ppvParameter?, pdwPingInterval?, pdwFlags?)
  => DllCall("KERNEL32.dll\GetApplicationRecoveryCallback", HANDLE, hProcess, APPLICATION_RECOVERY_CALLBACK.Ptr, pRecoveryCallback, Struct.Ptr.Ptr, ppvParameter?, UInt32.Ptr, pdwPingInterval?, UInt32.Ptr, pdwFlags?, "HRESULT")
GetApplicationRestartSettings(hProcess, pwzCommandline?, pdwFlags?)
  => DllCall("KERNEL32.dll\GetApplicationRestartSettings", HANDLE, hProcess, PWSTR, pwzCommandline?, UInt32.Ptr, pwzCommandline?.Length ?? 0, UInt32.Ptr, pdwFlags?, "HRESULT")
RegisterApplicationRecoveryCallback(pRecoveyCallback, pvParameter?, dwPingInterval, dwFlags)
  => DllCall("KERNEL32.dll\RegisterApplicationRecoveryCallback", APPLICATION_RECOVERY_CALLBACK, pRecoveyCallback, Struct.Ptr, pvParameter?, UInt32, dwPingInterval, UInt32, dwFlags, "HRESULT")
RegisterApplicationRestart(pwzCommandline?, dwFlags)
  => DllCall("KERNEL32.dll\RegisterApplicationRestart", "Str", pwzCommandline?, REGISTER_APPLICATION_RESTART_FLAGS, dwFlags, "HRESULT")
UnregisterApplicationRecoveryCallback()
  => DllCall("KERNEL32.dll\UnregisterApplicationRecoveryCallback", "HRESULT")
UnregisterApplicationRestart()
  => DllCall("KERNEL32.dll\UnregisterApplicationRestart", "HRESULT")
