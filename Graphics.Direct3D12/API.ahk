#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_FEATURE_LEVEL, ID3DBlob}
#Import "..\System.Com\Types.ahk" {IUnknown}

D3D12CreateDevice(pAdapter?, MinimumFeatureLevel, riid, ppDevice?)
  => DllCall("d3d12.dll\D3D12CreateDevice", IUnknown, pAdapter?, D3D_FEATURE_LEVEL, MinimumFeatureLevel, GUID.Ptr, riid, Struct.Ptr.Ptr, ppDevice?, "HRESULT")
D3D12CreateRootSignatureDeserializer(pSrcData, pRootSignatureDeserializerInterface, ppRootSignatureDeserializer)
  => DllCall("d3d12.dll\D3D12CreateRootSignatureDeserializer", Struct.Ptr, pSrcData, IntPtr, pSrcData.Size, GUID.Ptr, pRootSignatureDeserializerInterface, Struct.Ptr.Ptr, ppRootSignatureDeserializer, "HRESULT")
D3D12CreateVersionedRootSignatureDeserializer(pSrcData, pRootSignatureDeserializerInterface, ppRootSignatureDeserializer)
  => DllCall("d3d12.dll\D3D12CreateVersionedRootSignatureDeserializer", Struct.Ptr, pSrcData, IntPtr, pSrcData.Size, GUID.Ptr, pRootSignatureDeserializerInterface, Struct.Ptr.Ptr, ppRootSignatureDeserializer, "HRESULT")
D3D12EnableExperimentalFeatures(pIIDs, pConfigurationStructs?, pConfigurationStructSizes?)
  => DllCall("d3d12.dll\D3D12EnableExperimentalFeatures", UInt32, pConfigurationStructSizes?.Length ?? 0, GUID.Ptr, pIIDs, Struct.Ptr, pConfigurationStructs?, UInt32.Ptr, pConfigurationStructSizes?, "HRESULT")
D3D12GetDebugInterface(riid, ppvDebug?)
  => DllCall("d3d12.dll\D3D12GetDebugInterface", GUID.Ptr, riid, Struct.Ptr.Ptr, ppvDebug?, "HRESULT")
D3D12GetInterface(rclsid, riid, ppvDebug?)
  => DllCall("d3d12.dll\D3D12GetInterface", GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvDebug?, "HRESULT")
D3D12SerializeRootSignature(pRootSignature, Version, ppBlob, ppErrorBlob?)
  => DllCall("d3d12.dll\D3D12SerializeRootSignature", D3D12_ROOT_SIGNATURE_DESC.Ptr, pRootSignature, D3D_ROOT_SIGNATURE_VERSION, Version, ID3DBlob.Ptr, ppBlob, ID3DBlob.Ptr, ppErrorBlob?, "HRESULT")
D3D12SerializeVersionedRootSignature(pRootSignature, ppBlob, ppErrorBlob?)
  => DllCall("d3d12.dll\D3D12SerializeVersionedRootSignature", D3D12_VERSIONED_ROOT_SIGNATURE_DESC.Ptr, pRootSignature, ID3DBlob.Ptr, ppBlob, ID3DBlob.Ptr, ppErrorBlob?, "HRESULT")
