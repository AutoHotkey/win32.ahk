#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PSTR, PWSTR}

CreateDataModelManager(debugHost, manager)
  => DllCall("dbgmodel.dll\CreateDataModelManager", IDebugHost, debugHost, IDataModelManager.Ptr, manager, "HRESULT")
DebugConnect(RemoteOptions, InterfaceId, Interface)
  => DllCall("dbgeng.dll\DebugConnect", PSTR, RemoteOptions, GUID.Ptr, InterfaceId, Struct.Ptr.Ptr, Interface, "HRESULT")
DebugConnectWide(RemoteOptions, InterfaceId, Interface)
  => DllCall("dbgeng.dll\DebugConnectWide", "Str", RemoteOptions, GUID.Ptr, InterfaceId, Struct.Ptr.Ptr, Interface, "HRESULT")
DebugCreate(InterfaceId, Interface)
  => DllCall("dbgeng.dll\DebugCreate", GUID.Ptr, InterfaceId, Struct.Ptr.Ptr, Interface, "HRESULT")
DebugCreateEx(InterfaceId, DbgEngOptions, Interface)
  => DllCall("dbgeng.dll\DebugCreateEx", GUID.Ptr, InterfaceId, UInt32, DbgEngOptions, Struct.Ptr.Ptr, Interface, "HRESULT")
