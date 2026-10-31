#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D12\Types.ahk" {D3D12_RESOURCE_DESC, ID3D12CommandQueue, ID3D12Device, ID3D12Fence, ID3D12ProtectedResourceSession, ID3D12Resource}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct IHolographicCameraInterop extends IInspectable {
    static IID := "{7CC1F9C5-6D02-41FA-9500-E1809EB48EEC}"
    CreateDirect3D12BackBufferResource(pDevice, pTexture2DDesc, ppCreatedTexture2DResource)
      => ComCall(6, this.p, ID3D12Device, pDevice, D3D12_RESOURCE_DESC.Ptr, pTexture2DDesc, ID3D12Resource.Ptr, ppCreatedTexture2DResource)
    CreateDirect3D12HardwareProtectedBackBufferResource(pDevice, pTexture2DDesc, pProtectedResourceSession, ppCreatedTexture2DResource)
      => ComCall(7, this.p, ID3D12Device, pDevice, D3D12_RESOURCE_DESC.Ptr, pTexture2DDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession, ID3D12Resource.Ptr, ppCreatedTexture2DResource)
    AcquireDirect3D12BufferResource(pResourceToAcquire, pCommandQueue)
      => ComCall(8, this.p, ID3D12Resource, pResourceToAcquire, ID3D12CommandQueue, pCommandQueue)
    AcquireDirect3D12BufferResourceWithTimeout(pResourceToAcquire, pCommandQueue, duration)
      => ComCall(9, this.p, ID3D12Resource, pResourceToAcquire, ID3D12CommandQueue, pCommandQueue, Int64, duration)
    UnacquireDirect3D12BufferResource(pResourceToUnacquire)
      => ComCall(10, this.p, ID3D12Resource, pResourceToUnacquire)
}
struct IHolographicCameraRenderingParametersInterop extends IInspectable {
    static IID := "{F75B68D6-D1FD-4707-AAFD-FA6F4C0E3BF4}"
    CommitDirect3D12Resource(pColorResourceToCommit, pColorResourceFence, colorResourceFenceSignalValue)
      => ComCall(6, this.p, ID3D12Resource, pColorResourceToCommit, ID3D12Fence, pColorResourceFence, Int64, colorResourceFenceSignalValue)
    CommitDirect3D12ResourceWithDepthData(pColorResourceToCommit, pColorResourceFence, colorResourceFenceSignalValue, pDepthResourceToCommit, pDepthResourceFence, depthResourceFenceSignalValue)
      => ComCall(7, this.p, ID3D12Resource, pColorResourceToCommit, ID3D12Fence, pColorResourceFence, Int64, colorResourceFenceSignalValue, ID3D12Resource, pDepthResourceToCommit, ID3D12Fence, pDepthResourceFence, Int64, depthResourceFenceSignalValue)
}
struct IHolographicQuadLayerInterop extends IInspectable {
    static IID := "{CFA688F0-639E-4A47-83D7-6B7F5EBF7FED}"
    CreateDirect3D12ContentBufferResource(pDevice, pTexture2DDesc, ppTexture2DResource)
      => ComCall(6, this.p, ID3D12Device, pDevice, D3D12_RESOURCE_DESC.Ptr, pTexture2DDesc, ID3D12Resource.Ptr, ppTexture2DResource)
    CreateDirect3D12HardwareProtectedContentBufferResource(pDevice, pTexture2DDesc, pProtectedResourceSession, ppCreatedTexture2DResource)
      => ComCall(7, this.p, ID3D12Device, pDevice, D3D12_RESOURCE_DESC.Ptr, pTexture2DDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession, ID3D12Resource.Ptr, ppCreatedTexture2DResource)
    AcquireDirect3D12BufferResource(pResourceToAcquire, pCommandQueue)
      => ComCall(8, this.p, ID3D12Resource, pResourceToAcquire, ID3D12CommandQueue, pCommandQueue)
    AcquireDirect3D12BufferResourceWithTimeout(pResourceToAcquire, pCommandQueue, duration)
      => ComCall(9, this.p, ID3D12Resource, pResourceToAcquire, ID3D12CommandQueue, pCommandQueue, Int64, duration)
    UnacquireDirect3D12BufferResource(pResourceToUnacquire)
      => ComCall(10, this.p, ID3D12Resource, pResourceToUnacquire)
}
struct IHolographicQuadLayerUpdateParametersInterop extends IInspectable {
    static IID := "{E5F549CD-C909-444F-8809-7CC18A9C8920}"
    CommitDirect3D12Resource(pColorResourceToCommit, pColorResourceFence, colorResourceFenceSignalValue)
      => ComCall(6, this.p, ID3D12Resource, pColorResourceToCommit, ID3D12Fence, pColorResourceFence, Int64, colorResourceFenceSignalValue)
}
