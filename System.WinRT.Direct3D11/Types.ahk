#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IDirect3DDxgiInterfaceAccess extends IUnknown {
    static IID := "{A9B3D012-3DF2-4EE3-B8D1-8695F457D3C1}"
    GetInterface(iid, p)
      => ComCall(3, this.p, GUID.Ptr, iid, Struct.Ptr.Ptr, p)
}
