#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {ITypeInfo, IUnknown}

CoGetInterceptor(iidIntercepted, punkOuter, iid, ppv)
  => DllCall("ole32.dll\CoGetInterceptor", GUID.Ptr, iidIntercepted, IUnknown, punkOuter, GUID.Ptr, iid, Struct.Ptr.Ptr, ppv, "HRESULT")
CoGetInterceptorFromTypeInfo(iidIntercepted, punkOuter, typeInfo, iid, ppv)
  => DllCall("ole32.dll\CoGetInterceptorFromTypeInfo", GUID.Ptr, iidIntercepted, IUnknown, punkOuter, ITypeInfo, typeInfo, GUID.Ptr, iid, Struct.Ptr.Ptr, ppv, "HRESULT")
