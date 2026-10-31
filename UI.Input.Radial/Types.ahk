#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct IRadialControllerInterop extends IInspectable {
    static IID := "{1B0535C9-57AD-45C1-9D79-AD5C34360513}"
    CreateForWindow(hwnd1, riid, ppv)
      => ComCall(6, this.p, HWND, hwnd1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IRadialControllerConfigurationInterop extends IInspectable {
    static IID := "{787CDAAC-3186-476D-87E4-B9374A7B9970}"
    GetForWindow(hwnd1, riid, ppv)
      => ComCall(6, this.p, HWND, hwnd1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IRadialControllerIndependentInputSourceInterop extends IInspectable {
    static IID := "{3D577EFF-4CEE-11E6-B535-001BDC06AB3B}"
    CreateForWindow(hwnd1, riid, ppv)
      => ComCall(6, this.p, HWND, hwnd1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
