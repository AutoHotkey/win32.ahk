#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {IMalloc}

DxcCreateInstance(rclsid, riid, ppv)
  => DllCall("dxcompiler.dll\DxcCreateInstance", GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv, "HRESULT")
DxcCreateInstance2(pMalloc, rclsid, riid, ppv)
  => DllCall("dxcompiler.dll\DxcCreateInstance2", IMalloc, pMalloc, GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv, "HRESULT")
