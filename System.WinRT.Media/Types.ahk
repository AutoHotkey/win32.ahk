#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\Media.MediaFoundation\Types.ahk" {IMFDXGIDeviceManager, IMFSample, MFVideoArea}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct IAudioFrameNative extends IInspectable {
    static IID := "{20BE1E2E-930F-4746-9335-3C332F255093}"
    GetData(riid, ppv)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IVideoFrameNative extends IInspectable {
    static IID := "{26BA702B-314A-4620-AAF6-7A51AA58FA18}"
    GetData(riid, ppv)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetDevice(riid, ppv)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IAudioFrameNativeFactory extends IInspectable {
    static IID := "{7BD67CF8-BF7D-43E6-AF8D-B170EE0C0110}"
    CreateFromMFSample(data, forceReadOnly, riid, ppv)
      => ComCall(6, this.p, IMFSample, data, BOOL, forceReadOnly, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IVideoFrameNativeFactory extends IInspectable {
    static IID := "{69E3693E-8E1E-4E63-AC4C-7FDC21D9731D}"
    CreateFromMFSample(data, subtype, width, height, forceReadOnly, minDisplayAperture?, device?, riid, ppv)
      => ComCall(6, this.p, IMFSample, data, GUID.Ptr, subtype, UInt32, width, UInt32, height, BOOL, forceReadOnly, MFVideoArea.Ptr, minDisplayAperture?, IMFDXGIDeviceManager, device?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
