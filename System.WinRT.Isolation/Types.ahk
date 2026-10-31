#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IIsolatedEnvironmentInterop extends IUnknown {
    static IID := "{85713C2E-8E62-46C5-8DE2-C647E1D54636}"
    GetHostHwndInterop(containerHwnd, hostHwnd)
      => ComCall(3, this.p, HWND, containerHwnd, HWND.Ptr, hostHwnd)
}
