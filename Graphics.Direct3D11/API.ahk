#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HMODULE, HRESULT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_DRIVER_TYPE, D3D_FEATURE_LEVEL, ID3DBlob}
#Import "..\Graphics.Dxgi\Types.ahk" {DXGI_SWAP_CHAIN_DESC, IDXGIAdapter, IDXGISwapChain}

D3D11CreateDevice(pAdapter?, DriverType, Software?, Flags, pFeatureLevels?, SDKVersion, ppDevice?, pFeatureLevel?, ppImmediateContext?)
  => DllCall("d3d11.dll\D3D11CreateDevice", IDXGIAdapter, pAdapter?, D3D_DRIVER_TYPE, DriverType, HMODULE, Software?, D3D11_CREATE_DEVICE_FLAG, Flags, D3D_FEATURE_LEVEL.Ptr, pFeatureLevels?, UInt32, pFeatureLevels?.Length ?? 0, UInt32, SDKVersion, ID3D11Device.Ptr, ppDevice?, D3D_FEATURE_LEVEL.Ptr, pFeatureLevel?, ID3D11DeviceContext.Ptr, ppImmediateContext?, "HRESULT")
D3D11CreateDeviceAndSwapChain(pAdapter?, DriverType, Software, Flags, pFeatureLevels?, SDKVersion, pSwapChainDesc?, ppSwapChain?, ppDevice?, pFeatureLevel?, ppImmediateContext?)
  => DllCall("d3d11.dll\D3D11CreateDeviceAndSwapChain", IDXGIAdapter, pAdapter?, D3D_DRIVER_TYPE, DriverType, HMODULE, Software, D3D11_CREATE_DEVICE_FLAG, Flags, D3D_FEATURE_LEVEL.Ptr, pFeatureLevels?, UInt32, pFeatureLevels?.Length ?? 0, UInt32, SDKVersion, DXGI_SWAP_CHAIN_DESC.Ptr, pSwapChainDesc?, IDXGISwapChain.Ptr, ppSwapChain?, ID3D11Device.Ptr, ppDevice?, D3D_FEATURE_LEVEL.Ptr, pFeatureLevel?, ID3D11DeviceContext.Ptr, ppImmediateContext?, "HRESULT")
D3DDisassemble11Trace(pSrcData, pTrace, StartStep, NumSteps, Flags, ppDisassembly)
  => DllCall("D3DCOMPILER_47.dll\D3DDisassemble11Trace", Struct.Ptr, pSrcData, IntPtr, pSrcData.Size, ID3D11ShaderTrace, pTrace, UInt32, StartStep, UInt32, NumSteps, UInt32, Flags, ID3DBlob.Ptr, ppDisassembly, "HRESULT")
D3DX11CreateFFT(pDeviceContext, pDesc, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT", ID3D11DeviceContext, pDeviceContext, D3DX11_FFT_DESC.Ptr, pDesc, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT1DComplex(pDeviceContext, X, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT1DComplex", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT1DReal(pDeviceContext, X, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT1DReal", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT2DComplex(pDeviceContext, X, Y, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT2DComplex", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Y, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT2DReal(pDeviceContext, X, Y, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT2DReal", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Y, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT3DComplex(pDeviceContext, X, Y, Z, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT3DComplex", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Y, UInt32, Z, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateFFT3DReal(pDeviceContext, X, Y, Z, Flags, pBufferInfo, ppFFT)
  => DllCall("d3dcsx.dll\D3DX11CreateFFT3DReal", ID3D11DeviceContext, pDeviceContext, UInt32, X, UInt32, Y, UInt32, Z, UInt32, Flags, D3DX11_FFT_BUFFER_INFO.Ptr, pBufferInfo, ID3DX11FFT.Ptr, ppFFT, "HRESULT")
D3DX11CreateScan(pDeviceContext, MaxElementScanSize, MaxScanCount, ppScan)
  => DllCall("d3dcsx.dll\D3DX11CreateScan", ID3D11DeviceContext, pDeviceContext, UInt32, MaxElementScanSize, UInt32, MaxScanCount, ID3DX11Scan.Ptr, ppScan, "HRESULT")
D3DX11CreateSegmentedScan(pDeviceContext, MaxElementScanSize, ppScan)
  => DllCall("d3dcsx.dll\D3DX11CreateSegmentedScan", ID3D11DeviceContext, pDeviceContext, UInt32, MaxElementScanSize, ID3DX11SegmentedScan.Ptr, ppScan, "HRESULT")
