#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\Graphics.Imaging\Types.ahk" {IWICBitmap}
#Import "..\Media.MediaFoundation\Types.ahk" {IMF2DBuffer2, MFVideoArea}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct ISoftwareBitmapNative extends IInspectable {
    static IID := "{94BC8415-04EA-4B2E-AF13-4DE95AA898EB}"
    GetData(riid, ppv)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct ISoftwareBitmapNativeFactory extends IInspectable {
    static IID := "{C3C181EC-2914-4791-AF02-02D224A10B43}"
    CreateFromWICBitmap(data, forceReadOnly, riid, ppv)
      => ComCall(6, this.p, IWICBitmap, data, BOOL, forceReadOnly, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateFromMF2DBuffer2(data, subtype, width, height, forceReadOnly, minDisplayAperture?, riid, ppv)
      => ComCall(7, this.p, IMF2DBuffer2, data, GUID.Ptr, subtype, UInt32, width, UInt32, height, BOOL, forceReadOnly, MFVideoArea.Ptr, minDisplayAperture?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
