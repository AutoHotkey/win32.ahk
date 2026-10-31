#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND}
#Import "..\Graphics.Gdi\Types.ahk" {HMONITOR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IGraphicsCaptureItemInterop extends IUnknown {
    static IID := "{3628E81B-3CAC-4C60-B7F4-23CE0E0C3356}"
    CreateForWindow(window, riid, result)
      => ComCall(3, this.p, HWND, window, GUID.Ptr, riid, Struct.Ptr.Ptr, result)
    CreateForMonitor(monitor, riid, result)
      => ComCall(4, this.p, HMONITOR, monitor, GUID.Ptr, riid, Struct.Ptr.Ptr, result)
}
struct IWindowGraphicsCaptureItemInterop extends IUnknown {
    static IID := "{38E4C48B-94E6-4C44-9CFA-968193316C0C}"
    GetWindow(window)
      => ComCall(3, this.p, HWND.Ptr, window)
}
struct IMonitorGraphicsCaptureItemInterop extends IUnknown {
    static IID := "{33274D14-A076-4048-8416-747E9B04DB7B}"
    GetMonitor(monitor)
      => ComCall(3, this.p, HMONITOR.Ptr, monitor)
}
