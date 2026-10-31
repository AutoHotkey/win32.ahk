#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}

BindIFilterFromStorage(pStg, pUnkOuter, ppIUnk)
  => DllCall("query.dll\BindIFilterFromStorage", IStorage, pStg, IUnknown, pUnkOuter, Struct.Ptr.Ptr, ppIUnk, "HRESULT")
BindIFilterFromStream(pStm, pUnkOuter, ppIUnk)
  => DllCall("query.dll\BindIFilterFromStream", IStream, pStm, IUnknown, pUnkOuter, Struct.Ptr.Ptr, ppIUnk, "HRESULT")
LoadIFilter(pwcsPath, pUnkOuter, ppIUnk)
  => DllCall("query.dll\LoadIFilter", "Str", pwcsPath, IUnknown, pUnkOuter, Struct.Ptr.Ptr, ppIUnk, "HRESULT")
LoadIFilterEx(pwcsPath, dwFlags, riid, ppIUnk)
  => DllCall("query.dll\LoadIFilterEx", "Str", pwcsPath, UInt32, dwFlags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppIUnk, "HRESULT")
