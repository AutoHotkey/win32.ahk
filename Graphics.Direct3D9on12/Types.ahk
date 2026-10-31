#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\Graphics.Direct3D12\Types.ahk" {ID3D12CommandQueue, ID3D12Fence}
#Import "..\Graphics.Direct3D9\Types.ahk" {IDirect3D9, IDirect3D9Ex, IDirect3DResource9}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct D3D9ON12_ARGS {
    Enable9On12 : BOOL
    pD3D12Device : IUnknown
    ppD3D12Queues : IUnknown[2]
    NumQueues : UInt32
    NodeMask : UInt32
}
struct PFN_Direct3DCreate9On12Ex extends FunctionPointer {
    static Types := [UInt32, D3D9ON12_ARGS.Ptr, UInt32, IDirect3D9Ex.Ptr, HRESULT]
}
struct PFN_Direct3DCreate9On12 extends FunctionPointer {
    static Types := [UInt32, D3D9ON12_ARGS.Ptr, UInt32, IDirect3D9]
}
struct IDirect3DDevice9On12 extends IUnknown {
    static IID := "{E7FDA234-B589-4049-940D-8878977531C8}"
    GetD3D12Device(riid, ppvDevice)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvDevice)
    UnwrapUnderlyingResource(pResource, pCommandQueue, riid, ppvResource12)
      => ComCall(4, this.p, IDirect3DResource9, pResource, ID3D12CommandQueue, pCommandQueue, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvResource12)
    ReturnUnderlyingResource(pResource, NumSync, pSignalValues, ppFences)
      => ComCall(5, this.p, IDirect3DResource9, pResource, UInt32, NumSync, Int64.Ptr, pSignalValues, ID3D12Fence.Ptr, ppFences)
}
