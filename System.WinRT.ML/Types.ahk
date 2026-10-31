#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\AI.MachineLearning.WinML\Types.ahk" {IMLOperatorRegistry}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct3D12\Types.ahk" {ID3D12CommandQueue, ID3D12Resource}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct ILearningModelOperatorProviderNative extends IUnknown {
    static IID := "{1ADAA23A-EB67-41F3-AAD8-5D984E9BACD4}"
    GetRegistry(ppOperatorRegistry)
      => ComCall(3, this.p, IMLOperatorRegistry.Ptr, ppOperatorRegistry)
}
struct ITensorNative extends IUnknown {
    static IID := "{52F547EF-5B03-49B5-82D6-565F1EE0DD49}"
    GetBuffer(value)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, value, UInt32.Ptr, value.Length)
    GetD3D12Resource(result)
      => ComCall(4, this.p, ID3D12Resource.Ptr, result)
}
struct ITensorStaticsNative extends IUnknown {
    static IID := "{39D055A4-66F6-4EBC-95D9-7A29EBE7690A}"
    CreateFromD3D12Resource(value, shape, shapeCount, result)
      => ComCall(3, this.p, ID3D12Resource, value, Int64.Ptr, shape, Int32, shapeCount, IUnknown.Ptr, result)
}
struct ILearningModelDeviceFactoryNative extends IUnknown {
    static IID := "{1E9B31A1-662E-4AE0-AF67-F63BB337E634}"
    CreateFromD3D12CommandQueue(value, result)
      => ComCall(3, this.p, ID3D12CommandQueue, value, IUnknown.Ptr, result)
}
struct ILearningModelSessionOptionsNative extends IUnknown {
    static IID := "{C71E953F-37B4-4564-8658-D8396866DB0D}"
    SetIntraOpNumThreadsOverride(intraOpNumThreads)
      => ComCall(3, this.p, UInt32, intraOpNumThreads)
}
struct ILearningModelSessionOptionsNative1 extends IUnknown {
    static IID := "{5DA37A26-0526-414B-91E4-2A0FA3DDBA40}"
    SetIntraOpThreadSpinning(allowSpinning)
      => ComCall(3, this.p, UInt8, allowSpinning)
}
