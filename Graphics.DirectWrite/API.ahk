#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

DWriteCreateFactory(factoryType, iid, factory)
  => DllCall("DWrite.dll\DWriteCreateFactory", DWRITE_FACTORY_TYPE, factoryType, GUID.Ptr, iid, Struct.Ptr.Ptr, factory, "HRESULT")
