#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice}

PdfCreateRenderer(pDevice, ppRenderer)
  => DllCall("Windows.Data.Pdf.dll\PdfCreateRenderer", IDXGIDevice, pDevice, IPdfRendererNative.Ptr, ppRenderer, "HRESULT")
