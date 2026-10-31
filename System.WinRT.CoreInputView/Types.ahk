#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct ICoreFrameworkInputViewInterop extends IInspectable {
    static IID := "{0E3DA342-B11C-484B-9C1C-BE0D61C2F6C5}"
    GetForWindow(appWindow, riid, coreFrameworkInputView)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, coreFrameworkInputView)
}
