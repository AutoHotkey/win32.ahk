#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}

D3DPERF_BeginEvent(col, wszName)
  => DllCall("d3d9.dll\D3DPERF_BeginEvent", UInt32, col, "Str", wszName, Int32)
D3DPERF_EndEvent()
  => DllCall("d3d9.dll\D3DPERF_EndEvent", Int32)
D3DPERF_GetStatus()
  => DllCall("d3d9.dll\D3DPERF_GetStatus", UInt32)
D3DPERF_QueryRepeatFrame()
  => DllCall("d3d9.dll\D3DPERF_QueryRepeatFrame", BOOL)
D3DPERF_SetMarker(col, wszName)
  => DllCall("d3d9.dll\D3DPERF_SetMarker", UInt32, col, "Str", wszName, "void")
D3DPERF_SetOptions(dwOptions)
  => DllCall("d3d9.dll\D3DPERF_SetOptions", UInt32, dwOptions, "void")
D3DPERF_SetRegion(col, wszName)
  => DllCall("d3d9.dll\D3DPERF_SetRegion", UInt32, col, "Str", wszName, "void")
Direct3DCreate9(SDKVersion)
  => DllCall("d3d9.dll\Direct3DCreate9", UInt32, SDKVersion, IDirect3D9)
Direct3DCreate9Ex(SDKVersion, param1)
  => DllCall("d3d9.dll\Direct3DCreate9Ex", UInt32, SDKVersion, IDirect3D9Ex.Ptr, param1, "HRESULT")
