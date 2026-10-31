#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IInkCommitRequestHandler extends IUnknown {
    static IID := "{FABEA3FC-B108-45B6-A9FC-8D08FA9F85CF}"
    OnCommitRequested()
      => ComCall(3, this.p)
}
struct IInkPresenterDesktop extends IUnknown {
    static IID := "{73F3C0D9-2E8B-48F3-895E-20CBD27B723B}"
    SetRootVisual(rootVisual, device)
      => ComCall(3, this.p, IUnknown, rootVisual, IUnknown, device)
    SetCommitRequestHandler(handler)
      => ComCall(4, this.p, IInkCommitRequestHandler, handler)
    GetSize(width, height)
      => ComCall(5, this.p, Float32.Ptr, width, Float32.Ptr, height)
    SetSize(width, height)
      => ComCall(6, this.p, Float32, width, Float32, height)
    OnHighContrastChanged()
      => ComCall(7, this.p)
}
struct IInkHostWorkItem extends IUnknown {
    static IID := "{CCDA0A9A-1B78-4632-BB96-97800662E26C}"
    Invoke()
      => ComCall(3, this.p)
}
struct IInkDesktopHost extends IUnknown {
    static IID := "{4CE7D875-A981-4140-A1FF-AD93258E8D59}"
    QueueWorkItem(workItem)
      => ComCall(3, this.p, IInkHostWorkItem, workItem)
    CreateInkPresenter(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateAndInitializeInkPresenter(rootVisual, width, height, riid, ppv)
      => ComCall(5, this.p, IUnknown, rootVisual, Float32, width, Float32, height, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct INK_HIGH_CONTRAST_ADJUSTMENT extends Int32 {
    static USE_SYSTEM_COLORS_WHEN_NECESSARY := 0
    static USE_SYSTEM_COLORS := 1
    static USE_ORIGINAL_COLORS := 2
}
struct IInkD2DRenderer extends IUnknown {
    static IID := "{407FB1DE-F85A-4150-97CF-B7FB274FB4F8}"
    Draw(pD2D1DeviceContext, pInkStrokeIterable, fHighContrast)
      => ComCall(3, this.p, IUnknown, pD2D1DeviceContext, IUnknown, pInkStrokeIterable, BOOL, fHighContrast)
}
struct IInkD2DRenderer2 extends IUnknown {
    static IID := "{0A95DCD9-4578-4B71-B20B-BF664D4BFEEE}"
    Draw(pD2D1DeviceContext, pInkStrokeIterable, highContrastAdjustment)
      => ComCall(3, this.p, IUnknown, pD2D1DeviceContext, IUnknown, pInkStrokeIterable, INK_HIGH_CONTRAST_ADJUSTMENT, highContrastAdjustment)
}
