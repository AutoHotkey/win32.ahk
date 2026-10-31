#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PSTR, PWSTR}

WslConfigureDistribution(distributionName, defaultUID, wslDistributionFlags)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslConfigureDistribution", "Str", distributionName, UInt32, defaultUID, WSL_DISTRIBUTION_FLAGS, wslDistributionFlags, "HRESULT")
WslGetDistributionConfiguration(distributionName, distributionVersion, defaultUID, wslDistributionFlags, defaultEnvironmentVariables, defaultEnvironmentVariableCount)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslGetDistributionConfiguration", "Str", distributionName, UInt32.Ptr, distributionVersion, UInt32.Ptr, defaultUID, WSL_DISTRIBUTION_FLAGS.Ptr, wslDistributionFlags, PSTR.Ptr.Ptr, defaultEnvironmentVariables, UInt32.Ptr, defaultEnvironmentVariableCount, "HRESULT")
WslIsDistributionRegistered(distributionName)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslIsDistributionRegistered", "Str", distributionName, BOOL)
WslLaunch(distributionName, command?, useCurrentWorkingDirectory, stdIn, stdOut, stdErr, process)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslLaunch", "Str", distributionName, "Str", command?, BOOL, useCurrentWorkingDirectory, HANDLE, stdIn, HANDLE, stdOut, HANDLE, stdErr, HANDLE.Ptr, process, "HRESULT")
WslLaunchInteractive(distributionName, command?, useCurrentWorkingDirectory, exitCode)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslLaunchInteractive", "Str", distributionName, "Str", command?, BOOL, useCurrentWorkingDirectory, UInt32.Ptr, exitCode, "HRESULT")
WslRegisterDistribution(distributionName, tarGzFilename)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslRegisterDistribution", "Str", distributionName, "Str", tarGzFilename, "HRESULT")
WslUnregisterDistribution(distributionName)
  => DllCall("Api-ms-win-wsl-api-l1-1-0.dll\WslUnregisterDistribution", "Str", distributionName, "HRESULT")
