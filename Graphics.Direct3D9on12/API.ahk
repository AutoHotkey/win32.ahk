#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D9\Types.ahk" {IDirect3D9, IDirect3D9Ex}

Direct3DCreate9On12(SDKVersion, pOverrideList, NumOverrideEntries)
  => DllCall("d3d9.dll\Direct3DCreate9On12", UInt32, SDKVersion, D3D9ON12_ARGS.Ptr, pOverrideList, UInt32, NumOverrideEntries, IDirect3D9)
Direct3DCreate9On12Ex(SDKVersion, pOverrideList, NumOverrideEntries, ppOutputInterface)
  => DllCall("d3d9.dll\Direct3DCreate9On12Ex", UInt32, SDKVersion, D3D9ON12_ARGS.Ptr, pOverrideList, UInt32, NumOverrideEntries, IDirect3D9Ex.Ptr, ppOutputInterface, "HRESULT")
