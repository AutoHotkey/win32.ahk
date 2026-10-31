#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

CreateDXGIFactory(riid, ppFactory)
  => DllCall("dxgi.dll\CreateDXGIFactory", GUID.Ptr, riid, Struct.Ptr.Ptr, ppFactory, "HRESULT")
CreateDXGIFactory1(riid, ppFactory)
  => DllCall("dxgi.dll\CreateDXGIFactory1", GUID.Ptr, riid, Struct.Ptr.Ptr, ppFactory, "HRESULT")
CreateDXGIFactory2(Flags, riid, ppFactory)
  => DllCall("dxgi.dll\CreateDXGIFactory2", DXGI_CREATE_FACTORY_FLAGS, Flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppFactory, "HRESULT")
DXGIDeclareAdapterRemovalSupport()
  => DllCall("dxgi.dll\DXGIDeclareAdapterRemovalSupport", "HRESULT")
DXGIDisableVBlankVirtualization()
  => DllCall("dxgi.dll\DXGIDisableVBlankVirtualization", "HRESULT")
DXGIGetDebugInterface1(Flags, riid, pDebug)
  => DllCall("dxgi.dll\DXGIGetDebugInterface1", UInt32, Flags, GUID.Ptr, riid, Struct.Ptr.Ptr, pDebug, "HRESULT")
