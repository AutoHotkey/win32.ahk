#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_FEATURE_LEVEL}
#Import "..\Graphics.Direct3D11\Types.ahk" {ID3D11Device, ID3D11DeviceContext, ID3D11Resource}
#Import "..\Graphics.Direct3D12\Types.ahk" {D3D12_RESOURCE_STATES, ID3D12CommandQueue, ID3D12Fence}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct PFN_D3D11ON12_CREATE_DEVICE extends FunctionPointer {
    static Types := [IUnknown, UInt32, D3D_FEATURE_LEVEL.Ptr, UInt32, IUnknown.Ptr, UInt32, UInt32, ID3D11Device.Ptr, ID3D11DeviceContext.Ptr, D3D_FEATURE_LEVEL.Ptr, HRESULT]
}
struct D3D11_RESOURCE_FLAGS {
    BindFlags : UInt32
    MiscFlags : UInt32
    CPUAccessFlags : UInt32
    StructureByteStride : UInt32
}
struct ID3D11On12Device extends IUnknown {
    static IID := "{85611E73-70A9-490E-9614-A9E302777904}"
    CreateWrappedResource(pResource12, pFlags11, InState, OutState, riid, ppResource11?)
      => ComCall(3, this.p, IUnknown, pResource12, D3D11_RESOURCE_FLAGS.Ptr, pFlags11, D3D12_RESOURCE_STATES, InState, D3D12_RESOURCE_STATES, OutState, GUID.Ptr, riid, Struct.Ptr.Ptr, ppResource11?)
    ReleaseWrappedResources(ppResources)
      => ComCall(4, this.p, ID3D11Resource.Ptr, ppResources, UInt32, ppResources.Length, "void")
    AcquireWrappedResources(ppResources)
      => ComCall(5, this.p, ID3D11Resource.Ptr, ppResources, UInt32, ppResources.Length, "void")
}
struct ID3D11On12Device1 extends ID3D11On12Device {
    static IID := "{BDB64DF4-EA2F-4C70-B861-AAAB1258BB5D}"
    GetD3D12Device(riid, ppvDevice)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvDevice)
}
struct ID3D11On12Device2 extends ID3D11On12Device1 {
    static IID := "{DC90F331-4740-43FA-866E-67F12CB58223}"
    UnwrapUnderlyingResource(pResource11, pCommandQueue, riid, ppvResource12)
      => ComCall(7, this.p, ID3D11Resource, pResource11, ID3D12CommandQueue, pCommandQueue, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvResource12)
    ReturnUnderlyingResource(pResource11, pSignalValues, ppFences)
      => ComCall(8, this.p, ID3D11Resource, pResource11, UInt32, ppFences.Length, Int64.Ptr, pSignalValues, ID3D12Fence.Ptr, ppFences)
}
