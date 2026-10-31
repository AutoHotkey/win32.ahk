#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, POINT, RECT, SIZE}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT\Types.ahk" {IInspectable}
#Import "..\UI.Input.Pointer\Types.ahk" {POINTER_INFO}

struct ICompositionDrawingSurfaceInterop extends IUnknown {
    static IID := "{FD04E6E3-FE0C-4C3C-AB19-A07601A576EE}"
    BeginDraw(updateRect?, iid, updateObject, updateOffset)
      => ComCall(3, this.p, RECT.Ptr, updateRect?, GUID.Ptr, iid, Struct.Ptr.Ptr, updateObject, POINT.Ptr, updateOffset)
    EndDraw()
      => ComCall(4, this.p)
    Resize(sizePixels)
      => ComCall(5, this.p, SIZE, sizePixels)
    Scroll(scrollRect?, clipRect?, offsetX, offsetY)
      => ComCall(6, this.p, RECT.Ptr, scrollRect?, RECT.Ptr, clipRect?, Int32, offsetX, Int32, offsetY)
    ResumeDraw()
      => ComCall(7, this.p)
    SuspendDraw()
      => ComCall(8, this.p)
}
struct ICompositionDrawingSurfaceInterop2 extends ICompositionDrawingSurfaceInterop {
    static IID := "{41E64AAE-98C0-4239-8E95-A330DD6AA18B}"
    CopySurface(destinationResource, destinationOffsetX, destinationOffsetY, sourceRectangle?)
      => ComCall(9, this.p, IUnknown, destinationResource, Int32, destinationOffsetX, Int32, destinationOffsetY, RECT.Ptr, sourceRectangle?)
}
struct ICompositionGraphicsDeviceInterop extends IUnknown {
    static IID := "{A116FF71-F8BF-4C8A-9C98-70779A32A9C8}"
    GetRenderingDevice(value)
      => ComCall(3, this.p, IUnknown.Ptr, value)
    SetRenderingDevice(value)
      => ComCall(4, this.p, IUnknown, value)
}
struct ICompositorInterop extends IUnknown {
    static IID := "{25297D5C-3AD4-4C9C-B5CF-E36A38512330}"
    CreateCompositionSurfaceForHandle(swapChain, result)
      => ComCall(3, this.p, HANDLE, swapChain, UnsupportedType("Windows.UI.Composition.ICompositionSurface").Ptr, result)
    CreateCompositionSurfaceForSwapChain(swapChain, result)
      => ComCall(4, this.p, IUnknown, swapChain, UnsupportedType("Windows.UI.Composition.ICompositionSurface").Ptr, result)
    CreateGraphicsDevice(renderingDevice, result)
      => ComCall(5, this.p, IUnknown, renderingDevice, UnsupportedType("Windows.UI.Composition.CompositionGraphicsDevice").Ptr, result)
}
struct ICompositorInterop2 extends IUnknown {
    static IID := "{D3EEF34C-0667-4AFC-8D13-867607B0FE91}"
    CheckCompositionTextureSupport(renderingDevice, supportsCompositionTextures)
      => ComCall(3, this.p, IUnknown, renderingDevice, BOOL.Ptr, supportsCompositionTextures)
    CreateCompositionTexture(d3dTexture, compositionTexture)
      => ComCall(4, this.p, IUnknown, d3dTexture, UnsupportedType("Windows.UI.Composition.CompositionTexture").Ptr, compositionTexture)
}
struct ICompositionTextureInterop extends IUnknown {
    static IID := "{D528A265-F0A5-422F-A39D-EF62D7CD1CC4}"
    GetAvailableFence(fenceValue, iid, availableFence)
      => ComCall(3, this.p, Int64.Ptr, fenceValue, GUID.Ptr, iid, Struct.Ptr.Ptr, availableFence)
}
struct IVisualInteractionSourceInterop extends IUnknown {
    static IID := "{11F62CD1-2F9D-42D3-B05F-D6790D9E9F8E}"
    TryRedirectForManipulation(pointerInfo)
      => ComCall(3, this.p, POINTER_INFO.Ptr, pointerInfo)
}
struct ICompositionCapabilitiesInteropFactory extends IInspectable {
    static IID := "{2C9DB356-E70D-4642-8298-BC4AA5B4865C}"
    GetForWindow(hwnd1, result)
      => ComCall(6, this.p, HWND, hwnd1, UnsupportedType("Windows.UI.Composition.CompositionCapabilities").Ptr, result)
}
struct ICompositorDesktopInterop extends IUnknown {
    static IID := "{29E691FA-4567-4DCA-B319-D0F207EB6807}"
    CreateDesktopWindowTarget(hwndTarget, isTopmost, result)
      => ComCall(3, this.p, HWND, hwndTarget, BOOL, isTopmost, UnsupportedType("Windows.UI.Composition.Desktop.DesktopWindowTarget").Ptr, result)
    EnsureOnThread(threadId)
      => ComCall(4, this.p, UInt32, threadId)
}
struct IDesktopWindowTargetInterop extends IUnknown {
    static IID := "{35DBF59E-E3F9-45B0-81E7-FE75F4145DC9}"
    get_Hwnd(value)
      => ComCall(3, this.p, HWND.Ptr, value)
}
