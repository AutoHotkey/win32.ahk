#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND, PWSTR}
#Import "..\Graphics.Printing\Types.ahk" {IPrinterPropertyBag, IPrinterQueue}
#Import "..\Storage.Xps\Types.ahk" {IXpsDocumentPackageTarget, IXpsOMObjectFactory1, IXpsOMPageReference}
#Import "..\Storage.Xps.Printing\Types.ahk" {IPrintDocumentPackageTarget}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct IPrinting3DManagerInterop extends IInspectable {
    static IID := "{9CA31010-1484-4587-B26B-DDDF9F9CAECD}"
    GetForWindow(appWindow, riid, printManager)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, printManager)
    ShowPrintUIForWindowAsync(appWindow, riid, asyncOperation)
      => ComCall(7, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
}
struct IPrintManagerInterop extends IInspectable {
    static IID := "{C5435A42-8D43-4E7B-A68A-EF311E392087}"
    GetForWindow(appWindow, riid, printManager)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, printManager)
    ShowPrintUIForWindowAsync(appWindow, riid, asyncOperation)
      => ComCall(7, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
}
struct IPrintPreviewPageCollection extends IUnknown {
    static IID := "{0B31CC62-D7EC-4747-9D6E-F2537D870F2B}"
    Paginate(currentJobPage, printTaskOptions?)
      => ComCall(3, this.p, UInt32, currentJobPage, IInspectable, printTaskOptions?)
    MakePage(desiredJobPage, width, height)
      => ComCall(4, this.p, UInt32, desiredJobPage, Float32, width, Float32, height)
}
struct IPrintDocumentPageSource extends IUnknown {
    static IID := "{A96BB1DB-172E-4667-82B5-AD97A252318F}"
    GetPreviewPageCollection(docPackageTarget?, docPageCollection)
      => ComCall(3, this.p, IPrintDocumentPackageTarget, docPackageTarget?, IPrintPreviewPageCollection.Ptr, docPageCollection)
    MakeDocument(printTaskOptions?, docPackageTarget?)
      => ComCall(4, this.p, IInspectable, printTaskOptions?, IPrintDocumentPackageTarget, docPackageTarget?)
}
struct IPrintWorkflowXpsReceiver extends IUnknown {
    static IID := "{04097374-77B8-47F6-8167-AAE29D4CF84B}"
    SetDocumentSequencePrintTicket(documentSequencePrintTicket)
      => ComCall(3, this.p, IStream, documentSequencePrintTicket)
    SetDocumentSequenceUri(documentSequenceUri)
      => ComCall(4, this.p, "Str", documentSequenceUri)
    AddDocumentData(documentId, documentPrintTicket, documentUri)
      => ComCall(5, this.p, UInt32, documentId, IStream, documentPrintTicket, "Str", documentUri)
    AddPage(documentId, pageId, pageReference, pageUri)
      => ComCall(6, this.p, UInt32, documentId, UInt32, pageId, IXpsOMPageReference, pageReference, "Str", pageUri)
    Close()
      => ComCall(7, this.p)
}
struct IPrintWorkflowXpsReceiver2 extends IPrintWorkflowXpsReceiver {
    static IID := "{023BCC0C-DFAB-4A61-B074-490C6995580D}"
    Failed(XpsError)
      => ComCall(8, this.p, HRESULT, XpsError)
}
struct IPrintWorkflowObjectModelSourceFileContentNative extends IUnknown {
    static IID := "{68C9E477-993E-4052-8AC6-454EFF58DB9D}"
    StartXpsOMGeneration(receiver)
      => ComCall(3, this.p, IPrintWorkflowXpsReceiver, receiver)
    get_ObjectFactory(value)
      => ComCall(4, this.p, IXpsOMObjectFactory1.Ptr, value)
}
struct IPrintWorkflowXpsObjectModelTargetPackageNative extends IUnknown {
    static IID := "{7D96BC74-9B54-4CA1-AD3A-979C3D44DDAC}"
    get_DocumentPackageTarget(value)
      => ComCall(3, this.p, IXpsDocumentPackageTarget.Ptr, value)
}
struct IPrintWorkflowConfigurationNative extends IUnknown {
    static IID := "{C056BE0A-9EE2-450A-9823-964F0006F2BB}"
    get_PrinterQueue(value)
      => ComCall(3, this.p, IPrinterQueue.Ptr, value)
    get_DriverProperties(value)
      => ComCall(4, this.p, IPrinterPropertyBag.Ptr, value)
    get_UserProperties(value)
      => ComCall(5, this.p, IPrinterPropertyBag.Ptr, value)
}
