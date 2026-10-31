#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

CreatePresentationFactory(d3dDevice, riid, presentationFactory)
  => DllCall("dcomp.dll\CreatePresentationFactory", IUnknown, d3dDevice, GUID.Ptr, riid, Struct.Ptr.Ptr, presentationFactory, "HRESULT")
