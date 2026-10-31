#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice, IDXGISurface}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

CreateDirect3D11DeviceFromDXGIDevice(dxgiDevice, graphicsDevice)
  => DllCall("d3d11.dll\CreateDirect3D11DeviceFromDXGIDevice", IDXGIDevice, dxgiDevice, IInspectable.Ptr, graphicsDevice, "HRESULT")
CreateDirect3D11SurfaceFromDXGISurface(dgxiSurface, graphicsSurface)
  => DllCall("d3d11.dll\CreateDirect3D11SurfaceFromDXGISurface", IDXGISurface, dgxiSurface, IInspectable.Ptr, graphicsSurface, "HRESULT")
