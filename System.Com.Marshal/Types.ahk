#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {CO_MARSHALING_CONTEXT_ATTRIBUTES, IStream, IUnknown}

struct IMarshal extends IUnknown {
    static IID := "{00000003-0000-0000-C000-000000000046}"
    GetUnmarshalClass(riid, pv?, dwDestContext, mshlflags, pCid)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr, pv?, UInt32, dwDestContext, "Ptr", 0, UInt32, mshlflags, GUID.Ptr, pCid)
    GetMarshalSizeMax(riid, pv?, dwDestContext, mshlflags, pSize)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr, pv?, UInt32, dwDestContext, "Ptr", 0, UInt32, mshlflags, UInt32.Ptr, pSize)
    MarshalInterface(pStm, riid, pv?, dwDestContext, mshlflags)
      => ComCall(5, this.p, IStream, pStm, GUID.Ptr, riid, Struct.Ptr, pv?, UInt32, dwDestContext, "Ptr", 0, UInt32, mshlflags)
    UnmarshalInterface(pStm, riid, ppv)
      => ComCall(6, this.p, IStream, pStm, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ReleaseMarshalData(pStm)
      => ComCall(7, this.p, IStream, pStm)
    DisconnectObject(dwReserved)
      => ComCall(8, this.p, UInt32, dwReserved)
}
struct IMarshal2 extends IMarshal {
    static IID := "{000001CF-0000-0000-C000-000000000046}"
}
struct IMarshalingStream extends IStream {
    static IID := "{D8F2F5E6-6102-4863-9F26-389A4676EFDE}"
    GetMarshalingContextAttribute(attribute, pAttributeValue)
      => ComCall(14, this.p, CO_MARSHALING_CONTEXT_ATTRIBUTES, attribute, IntPtr.Ptr, pAttributeValue)
}
struct STDMSHLFLAGS extends Int32 {
    static SMEXF_SERVER := 1
    static SMEXF_HANDLER := 2
}
