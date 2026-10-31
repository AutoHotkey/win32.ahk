#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

CreateDeviceAccessInstance(deviceInterfacePath, desiredAccess, createAsync)
  => DllCall("deviceaccess.dll\CreateDeviceAccessInstance", "Str", deviceInterfacePath, UInt32, desiredAccess, ICreateDeviceAccessAsync.Ptr, createAsync, "HRESULT")
