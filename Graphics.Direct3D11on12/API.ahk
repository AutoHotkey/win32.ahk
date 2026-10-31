#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_FEATURE_LEVEL}
#Import "..\Graphics.Direct3D11\Types.ahk" {ID3D11Device, ID3D11DeviceContext}
#Import "..\System.Com\Types.ahk" {IUnknown}

D3D11On12CreateDevice(pDevice, Flags, pFeatureLevels?, ppCommandQueues?, NodeMask, ppDevice?, ppImmediateContext?, pChosenFeatureLevel?)
  => DllCall("d3d11.dll\D3D11On12CreateDevice", IUnknown, pDevice, UInt32, Flags, D3D_FEATURE_LEVEL.Ptr, pFeatureLevels?, UInt32, pFeatureLevels?.Length ?? 0, IUnknown.Ptr, ppCommandQueues?, UInt32, ppCommandQueues?.Length ?? 0, UInt32, NodeMask, ID3D11Device.Ptr, ppDevice?, ID3D11DeviceContext.Ptr, ppImmediateContext?, D3D_FEATURE_LEVEL.Ptr, pChosenFeatureLevel?, "HRESULT")
