#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT\Types.ahk" {HSTRING, IInspectable}

struct IDisplayDeviceInterop extends IUnknown {
    static IID := "{64338358-366A-471B-BD56-DD8EF48E439B}"
    CreateSharedHandle(pObject, pSecurityAttributes, Access, Name, pHandle)
      => ComCall(3, this.p, IInspectable, pObject, SECURITY_ATTRIBUTES.Ptr, pSecurityAttributes, UInt32, Access, HSTRING, Name, HANDLE.Ptr, pHandle)
    OpenSharedHandle(NTHandle, riid, ppvObj)
      => ComCall(4, this.p, HANDLE, NTHandle, GUID, riid, Struct.Ptr.Ptr, ppvObj)
}
struct IDisplayPathInterop extends IUnknown {
    static IID := "{A6BA4205-E59E-4E71-B25B-4E436D21EE3D}"
    CreateSourcePresentationHandle(pValue)
      => ComCall(3, this.p, HANDLE.Ptr, pValue)
    GetSourceId(pSourceId)
      => ComCall(4, this.p, UInt32.Ptr, pSourceId)
}
