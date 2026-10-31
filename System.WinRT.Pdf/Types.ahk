#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HRESULT, POINT}
#Import "..\Graphics.Direct2D\Types.ahk" {ID2D1DeviceContext}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D_COLOR_F, D2D_RECT_F}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice, IDXGISurface}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct PFN_PDF_CREATE_RENDERER extends FunctionPointer {
    static Types := [IDXGIDevice, IPdfRendererNative.Ptr, HRESULT]
}
struct PDF_RENDER_PARAMS {
    SourceRect : D2D_RECT_F
    DestinationWidth : UInt32
    DestinationHeight : UInt32
    BackgroundColor : D2D_COLOR_F
    IgnoreHighContrast : BOOLEAN
}
struct IPdfRendererNative extends IUnknown {
    static IID := "{7D9DCD91-D277-4947-8527-07A0DAEDA94A}"
    RenderPageToSurface(pdfPage, pSurface, offset, pRenderParams?)
      => ComCall(3, this.p, IUnknown, pdfPage, IDXGISurface, pSurface, POINT, offset, PDF_RENDER_PARAMS.Ptr, pRenderParams?)
    RenderPageToDeviceContext(pdfPage, pD2DDeviceContext, pRenderParams?)
      => ComCall(4, this.p, IUnknown, pdfPage, ID2D1DeviceContext, pD2DDeviceContext, PDF_RENDER_PARAMS.Ptr, pRenderParams?)
}
