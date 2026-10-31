#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

MLCreateOperatorRegistry(registry)
  => DllCall("windows.ai.machinelearning.dll\MLCreateOperatorRegistry", IMLOperatorRegistry.Ptr, registry, "HRESULT")
WinMLCreateRuntime(runtime)
  => DllCall("winml.dll\WinMLCreateRuntime", IWinMLRuntime.Ptr, runtime, "HRESULT")
