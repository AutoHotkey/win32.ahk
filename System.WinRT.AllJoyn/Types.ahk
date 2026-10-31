#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.WinRT\Types.ahk" {HSTRING, IInspectable}

struct IWindowsDevicesAllJoynBusAttachmentInterop extends IInspectable {
    static IID := "{FD89C65B-B50E-4A19-9D0C-B42B783281CD}"
    get_Win32Handle(value)
      => ComCall(6, this.p, Int64.Ptr, value)
}
struct IWindowsDevicesAllJoynBusAttachmentFactoryInterop extends IInspectable {
    static IID := "{4B8F7505-B239-4E7B-88AF-F6682575D861}"
    CreateFromWin32Handle(win32handle, enableAboutData, riid, ppv)
      => ComCall(6, this.p, Int64, win32handle, UInt8, enableAboutData, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IWindowsDevicesAllJoynBusObjectInterop extends IInspectable {
    static IID := "{D78AA3D5-5054-428F-99F2-EC3A5DE3C3BC}"
    AddPropertyGetHandler(context, interfaceName, callback)
      => ComCall(6, this.p, Struct.Ptr, context, HSTRING, interfaceName, IntPtr, callback)
    AddPropertySetHandler(context, interfaceName, callback)
      => ComCall(7, this.p, Struct.Ptr, context, HSTRING, interfaceName, IntPtr, callback)
    get_Win32Handle(value)
      => ComCall(8, this.p, Int64.Ptr, value)
}
struct IWindowsDevicesAllJoynBusObjectFactoryInterop extends IInspectable {
    static IID := "{6174E506-8B95-4E36-95C0-B88FED34938C}"
    CreateFromWin32Handle(win32handle, riid, ppv)
      => ComCall(6, this.p, Int64, win32handle, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
