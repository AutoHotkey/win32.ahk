#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, POINT, RECT}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice, IDXGISurface, IDXGISwapChain}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {MSG}

struct TrackerHandle {
    Value : Struct.Ptr
}
struct ISurfaceImageSourceNative extends IUnknown {
    static IID := "{F2E9EDC1-D307-4525-9886-0FAFAA44163C}"
    SetDevice(device)
      => ComCall(3, this.p, IDXGIDevice, device)
    BeginDraw(updateRect, surface, offset)
      => ComCall(4, this.p, RECT, updateRect, IDXGISurface.Ptr, surface, POINT.Ptr, offset)
    EndDraw()
      => ComCall(5, this.p)
}
struct IVirtualSurfaceUpdatesCallbackNative extends IUnknown {
    static IID := "{DBF2E947-8E6C-4254-9EEE-7738F71386C9}"
    UpdatesNeeded()
      => ComCall(3, this.p)
}
struct IVirtualSurfaceImageSourceNative extends ISurfaceImageSourceNative {
    static IID := "{E9550983-360B-4F53-B391-AFD695078691}"
    Invalidate(updateRect)
      => ComCall(6, this.p, RECT, updateRect)
    GetUpdateRectCount(count)
      => ComCall(7, this.p, UInt32.Ptr, count)
    GetUpdateRects(updates)
      => ComCall(8, this.p, RECT.Ptr, updates, UInt32, updates.Length)
    GetVisibleBounds(bounds)
      => ComCall(9, this.p, RECT.Ptr, bounds)
    RegisterForUpdatesNeeded(callback?)
      => ComCall(10, this.p, IVirtualSurfaceUpdatesCallbackNative, callback?)
    Resize(newWidth, newHeight)
      => ComCall(11, this.p, Int32, newWidth, Int32, newHeight)
}
struct ISwapChainBackgroundPanelNative extends IUnknown {
    static IID := "{43BEBD4E-ADD5-4035-8F85-5608D08E9DC9}"
    SetSwapChain(swapChain)
      => ComCall(3, this.p, IDXGISwapChain, swapChain)
}
struct ISurfaceImageSourceManagerNative extends IUnknown {
    static IID := "{4C8798B7-1D88-4A0F-B59B-B93F600DE8C8}"
    FlushAllSurfacesWithDevice(device)
      => ComCall(3, this.p, IUnknown, device)
}
struct ISurfaceImageSourceNativeWithD2D extends IUnknown {
    static IID := "{54298223-41E1-4A41-9C08-02E8256864A1}"
    SetDevice(device)
      => ComCall(3, this.p, IUnknown, device)
    BeginDraw(updateRect, iid, updateObject, offset)
      => ComCall(4, this.p, RECT.Ptr, updateRect, GUID.Ptr, iid, Struct.Ptr.Ptr, updateObject, POINT.Ptr, offset)
    EndDraw()
      => ComCall(5, this.p)
    SuspendDraw()
      => ComCall(6, this.p)
    ResumeDraw()
      => ComCall(7, this.p)
}
struct ISwapChainPanelNative extends IUnknown {
    static IID := "{F92F19D2-3ADE-45A6-A20C-F6F1EA90554B}"
    SetSwapChain(swapChain)
      => ComCall(3, this.p, IDXGISwapChain, swapChain)
}
struct ISwapChainPanelNative2 extends ISwapChainPanelNative {
    static IID := "{D5A2F60C-37B2-44A2-937B-8D8EB9726821}"
    SetSwapChainHandle(swapChainHandle)
      => ComCall(4, this.p, HANDLE, swapChainHandle)
}
struct IDesktopWindowXamlSourceNative extends IUnknown {
    static IID := "{3CBCF1BF-2F76-4E9C-96AB-E84B37972554}"
    AttachToWindow(parentWnd)
      => ComCall(3, this.p, HWND, parentWnd)
    get_WindowHandle(hWnd)
      => ComCall(4, this.p, HWND.Ptr, hWnd)
}
struct IDesktopWindowXamlSourceNative2 extends IDesktopWindowXamlSourceNative {
    static IID := "{E3DCD8C7-3057-4692-99C3-7B7720AFDA31}"
    PreTranslateMessage(message, result)
      => ComCall(5, this.p, MSG.Ptr, message, BOOL.Ptr, result)
}
struct IReferenceTrackerTarget extends IUnknown {
    static IID := "{64BD43F8-BFEE-4EC4-B7EB-2935158DAE21}"
    AddRefFromReferenceTracker()
      => ComCall(3, this.p, UInt32)
    ReleaseFromReferenceTracker()
      => ComCall(4, this.p, UInt32)
    Peg()
      => ComCall(5, this.p)
    Unpeg()
      => ComCall(6, this.p)
}
struct IReferenceTracker extends IUnknown {
    static IID := "{11D3B13A-180E-4789-A8BE-7712882893E6}"
    ConnectFromTrackerSource()
      => ComCall(3, this.p)
    DisconnectFromTrackerSource()
      => ComCall(4, this.p)
    FindTrackerTargets(callback)
      => ComCall(5, this.p, IFindReferenceTargetsCallback, callback)
    GetReferenceTrackerManager(value)
      => ComCall(6, this.p, IReferenceTrackerManager.Ptr, value)
    AddRefFromTrackerSource()
      => ComCall(7, this.p)
    ReleaseFromTrackerSource()
      => ComCall(8, this.p)
    PegFromTrackerSource()
      => ComCall(9, this.p)
}
struct IReferenceTrackerManager extends IUnknown {
    static IID := "{3CF184B4-7CCB-4DDA-8455-7E6CE99A3298}"
    ReferenceTrackingStarted()
      => ComCall(3, this.p)
    FindTrackerTargetsCompleted(findFailed)
      => ComCall(4, this.p, UInt8, findFailed)
    ReferenceTrackingCompleted()
      => ComCall(5, this.p)
    SetReferenceTrackerHost(value)
      => ComCall(6, this.p, IReferenceTrackerHost, value)
}
struct IFindReferenceTargetsCallback extends IUnknown {
    static IID := "{04B3486C-4687-4229-8D14-505AB584DD88}"
    FoundTrackerTarget(target)
      => ComCall(3, this.p, IReferenceTrackerTarget, target)
}
struct XAML_REFERENCETRACKER_DISCONNECT extends Int32 {
    static XAML_REFERENCETRACKER_DISCONNECT_DEFAULT := 0
    static XAML_REFERENCETRACKER_DISCONNECT_SUSPEND := 1
}
struct IReferenceTrackerHost extends IUnknown {
    static IID := "{29A71C6A-3C42-4416-A39D-E2825A07A773}"
    DisconnectUnusedReferenceSources(options)
      => ComCall(3, this.p, XAML_REFERENCETRACKER_DISCONNECT, options)
    ReleaseDisconnectedReferenceSources()
      => ComCall(4, this.p)
    NotifyEndOfReferenceTrackingOnThread()
      => ComCall(5, this.p)
    GetTrackerTarget(unknown, newReference)
      => ComCall(6, this.p, IUnknown, unknown, IReferenceTrackerTarget.Ptr, newReference)
    AddMemoryPressure(bytesAllocated)
      => ComCall(7, this.p, Int64, bytesAllocated)
    RemoveMemoryPressure(bytesAllocated)
      => ComCall(8, this.p, Int64, bytesAllocated)
}
struct IReferenceTrackerExtension extends IUnknown {
    static IID := "{4E897CAA-59D5-4613-8F8C-F7EBD1F399B0}"
}
struct ITrackerOwner extends IUnknown {
    static IID := "{EB24C20B-9816-4AC7-8CFF-36F67A118F4E}"
    CreateTrackerHandle(returnValue)
      => ComCall(3, this.p, TrackerHandle.Ptr, returnValue)
    DeleteTrackerHandle(handle)
      => ComCall(4, this.p, TrackerHandle, handle)
    SetTrackerValue(handle, value)
      => ComCall(5, this.p, TrackerHandle, handle, IUnknown, value)
    TryGetSafeTrackerValue(handle, returnValue)
      => ComCall(6, this.p, TrackerHandle, handle, IUnknown.Ptr, returnValue, UInt8)
}
