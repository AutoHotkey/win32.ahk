#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

InitializeXamlDiagnostic(endPointName, pid, wszDllXamlDiagnostics, wszTAPDllName, tapClsid)
  => DllCall("Windows.UI.Xaml.dll\InitializeXamlDiagnostic", "Str", endPointName, UInt32, pid, "Str", wszDllXamlDiagnostics, "Str", wszTAPDllName, GUID, tapClsid, "HRESULT")
InitializeXamlDiagnosticsEx(endPointName, pid, wszDllXamlDiagnostics, wszTAPDllName, tapClsid, wszInitializationData)
  => DllCall("Windows.UI.Xaml.dll\InitializeXamlDiagnosticsEx", "Str", endPointName, UInt32, pid, "Str", wszDllXamlDiagnostics, "Str", wszTAPDllName, GUID, tapClsid, "Str", wszInitializationData, "HRESULT")
