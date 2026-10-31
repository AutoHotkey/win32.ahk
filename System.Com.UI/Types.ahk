#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HDC}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct IThumbnailExtractor extends IUnknown {
    static IID := "{969DC708-5C76-11D1-8D86-0000F804B057}"
    ExtractThumbnail(pStg, ulLength, ulHeight, pulOutputLength, pulOutputHeight, phOutputBitmap)
      => ComCall(3, this.p, IStorage, pStg, UInt32, ulLength, UInt32, ulHeight, UInt32.Ptr, pulOutputLength, UInt32.Ptr, pulOutputHeight, HBITMAP.Ptr, phOutputBitmap)
    OnFileUpdated(pStg)
      => ComCall(4, this.p, IStorage, pStg)
}
struct IDummyHICONIncluder extends IUnknown {
    static IID := "{947990DE-CC28-11D2-A0F7-00805F858FB1}"
    Dummy(h1, h2)
      => ComCall(3, this.p, HICON, h1, HDC, h2)
}
