#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

DXCoreCreateAdapterFactory(riid, ppvFactory)
  => DllCall("DXCORE.dll\DXCoreCreateAdapterFactory", GUID.Ptr, riid, Struct.Ptr.Ptr, ppvFactory, "HRESULT")
