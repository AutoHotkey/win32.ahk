#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D12\Types.ahk" {ID3D12Device}

DMLCreateDevice(d3d12Device, flags, riid, ppv?)
  => DllCall("DirectML.dll\DMLCreateDevice", ID3D12Device, d3d12Device, DML_CREATE_DEVICE_FLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv?, "HRESULT")
DMLCreateDevice1(d3d12Device, flags, minimumFeatureLevel, riid, ppv?)
  => DllCall("DirectML.dll\DMLCreateDevice1", ID3D12Device, d3d12Device, DML_CREATE_DEVICE_FLAGS, flags, DML_FEATURE_LEVEL, minimumFeatureLevel, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv?, "HRESULT")
