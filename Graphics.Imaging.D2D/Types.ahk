#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Direct2D\Types.ahk" {ID2D1Device, ID2D1Image}
#Import "..\Graphics.Imaging\Types.ahk" {IWICBitmapEncoder, IWICBitmapFrameEncode, IWICBitmapToneMapper, IWICImagingFactory, WICImageParameters}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IWICImageEncoder extends IUnknown {
    static IID := "{04C75BF8-3CE1-473B-ACC5-3CC4F5E94999}"
    WriteFrame(pImage, pFrameEncode, pImageParameters)
      => ComCall(3, this.p, ID2D1Image, pImage, IWICBitmapFrameEncode, pFrameEncode, WICImageParameters.Ptr, pImageParameters)
    WriteFrameThumbnail(pImage, pFrameEncode, pImageParameters)
      => ComCall(4, this.p, ID2D1Image, pImage, IWICBitmapFrameEncode, pFrameEncode, WICImageParameters.Ptr, pImageParameters)
    WriteThumbnail(pImage, pEncoder, pImageParameters)
      => ComCall(5, this.p, ID2D1Image, pImage, IWICBitmapEncoder, pEncoder, WICImageParameters.Ptr, pImageParameters)
}
struct IWICImagingFactory2 extends IWICImagingFactory {
    static IID := "{7B816B45-1996-4476-B132-DE9E247C8AF0}"
    CreateImageEncoder(pD2DDevice, ppWICImageEncoder)
      => ComCall(28, this.p, ID2D1Device, pD2DDevice, IWICImageEncoder.Ptr, ppWICImageEncoder)
}
struct IWICImagingFactory3 extends IWICImagingFactory2 {
    static IID := "{489B3D8B-624A-4258-B678-7EECE70F299D}"
    CreateBitmapToneMapper(ppToneMapper)
      => ComCall(29, this.p, IWICBitmapToneMapper.Ptr, ppToneMapper)
}
