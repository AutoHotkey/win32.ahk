#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMDocument2}
#Import "..\Devices.Communication\Types.ahk" {COMMTIMEOUTS}
#Import "..\Devices.Display\Types.ahk" {FD_KERNINGPAIR}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FARPROC, FILETIME, HANDLE, HINSTANCE, HRESULT, HWND, LPARAM, LRESULT, POINTL, PSTR, PWSTR, RECTL, SIZE, SYSTEMTIME, WPARAM}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGISurface}
#Import "..\Graphics.Gdi\Types.ahk" {DEVMODEA, DEVMODEW, HDC, PANOSE}
#Import "..\Graphics.Imaging\Types.ahk" {IWICBitmap}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR}
#Import "..\Storage.Xps\Types.ahk" {IXpsOMPage}
#Import "..\System.Com\Types.ahk" {IDispatch, IEnumUnknown, IErrorInfo, IStream, IUnknown, STREAM_SEEK}
#Import "..\System.Ole\Types.ahk" {ICreateErrorInfo}
#Import "..\System.Power\Types.ahk" {POWERBROADCAST_SETTING}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {DLGPROC, HICON}

struct PRINTER_ACCESS_RIGHTS extends UInt32 {
    static PRINTER_ALL_ACCESS := 983052
    static PRINTER_READ := 131080
    static PRINTER_WRITE := 131080
    static PRINTER_EXECUTE := 131080
    static SERVER_ALL_ACCESS := 983043
    static SERVER_READ := 131074
    static SERVER_WRITE := 131075
    static SERVER_EXECUTE := 131074
    static PRINTER_DELETE := 65536
    static PRINTER_READ_CONTROL := 131072
    static PRINTER_WRITE_DAC := 262144
    static PRINTER_WRITE_OWNER := 524288
    static PRINTER_SYNCHRONIZE := 1048576
    static PRINTER_STANDARD_RIGHTS_REQUIRED := 983040
    static PRINTER_STANDARD_RIGHTS_READ := 131072
    static PRINTER_STANDARD_RIGHTS_WRITE := 131072
    static PRINTER_STANDARD_RIGHTS_EXECUTE := 131072
    static SERVER_ACCESS_ADMINISTER := 1
    static SERVER_ACCESS_ENUMERATE := 2
    static PRINTER_ACCESS_ADMINISTER := 4
    static PRINTER_ACCESS_USE := 8
    static PRINTER_ACCESS_MANAGE_LIMITED := 64
}
struct PFN_PRINTING_ENUMPORTS extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_OPENPORT extends FunctionPointer {
    static Types := [PWSTR, HANDLE.Ptr, BOOL]
}
struct PFN_PRINTING_OPENPORTEX extends FunctionPointer {
    static Types := [HANDLE, PWSTR, PWSTR, HANDLE.Ptr, MONITOR2.Ptr, BOOL]
}
struct PFN_PRINTING_STARTDOCPORT extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, UInt32, UInt8.Ptr, BOOL]
}
struct PFN_PRINTING_WRITEPORT extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_READPORT extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_ENDDOCPORT extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_CLOSEPORT extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_ADDPORT extends FunctionPointer {
    static Types := [PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_ADDPORTEX extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt8.Ptr, PWSTR, BOOL]
}
struct PFN_PRINTING_CONFIGUREPORT extends FunctionPointer {
    static Types := [PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_DELETEPORT extends FunctionPointer {
    static Types := [PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_GETPRINTERDATAFROMPORT extends FunctionPointer {
    static Types := [HANDLE, UInt32, PWSTR, PWSTR, UInt32, PWSTR, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_SETPORTTIMEOUTS extends FunctionPointer {
    static Types := [HANDLE, COMMTIMEOUTS.Ptr, UInt32, BOOL]
}
struct PFN_PRINTING_XCVOPENPORT extends FunctionPointer {
    static Types := [PWSTR, UInt32, HANDLE.Ptr, BOOL]
}
struct PFN_PRINTING_XCVDATAPORT extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_PRINTING_XCVCLOSEPORT extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_ENUMPORTS2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_OPENPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, HANDLE.Ptr, BOOL]
}
struct PFN_PRINTING_OPENPORTEX2 extends FunctionPointer {
    static Types := [HANDLE, HANDLE, PWSTR, PWSTR, HANDLE.Ptr, MONITOR2.Ptr, BOOL]
}
struct PFN_PRINTING_STARTDOCPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, UInt32, UInt8.Ptr, BOOL]
}
struct PFN_PRINTING_WRITEPORT2 extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_READPORT2 extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_ENDDOCPORT2 extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_CLOSEPORT2 extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_ADDPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_ADDPORTEX2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, UInt8.Ptr, PWSTR, BOOL]
}
struct PFN_PRINTING_CONFIGUREPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_DELETEPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, HWND, PWSTR, BOOL]
}
struct PFN_PRINTING_GETPRINTERDATAFROMPORT2 extends FunctionPointer {
    static Types := [HANDLE, UInt32, PWSTR, PWSTR, UInt32, PWSTR, UInt32, UInt32.Ptr, BOOL]
}
struct PFN_PRINTING_SETPORTTIMEOUTS2 extends FunctionPointer {
    static Types := [HANDLE, COMMTIMEOUTS.Ptr, UInt32, BOOL]
}
struct PFN_PRINTING_XCVOPENPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, HANDLE.Ptr, BOOL]
}
struct PFN_PRINTING_XCVDATAPORT2 extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_PRINTING_XCVCLOSEPORT2 extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFN_PRINTING_SHUTDOWN2 extends FunctionPointer {
    static Types := [HANDLE, "Void"]
}
struct PFN_PRINTING_SENDRECVBIDIDATAFROMPORT2 extends FunctionPointer {
    static Types := [HANDLE, UInt32, PWSTR, BIDI_REQUEST_CONTAINER.Ptr, BIDI_RESPONSE_CONTAINER.Ptr.Ptr, UInt32]
}
struct PFN_PRINTING_NOTIFYUSEDPORTS2 extends FunctionPointer {
    static Types := [HANDLE, UInt32, PWSTR, UInt32]
}
struct PFN_PRINTING_NOTIFYUNUSEDPORTS2 extends FunctionPointer {
    static Types := [HANDLE, UInt32, PWSTR, UInt32]
}
struct PFN_PRINTING_POWEREVENT2 extends FunctionPointer {
    static Types := [HANDLE, UInt32, POWERBROADCAST_SETTING.Ptr, UInt32]
}
struct PRINTER_HANDLE {
    Value : Struct.Ptr
}
struct FINDPRINTERCHANGENOTIFICATION_HANDLE {
    Value : Struct.Ptr
}
struct SPLCLIENT_INFO_2_WINXP {
    hSplPrinter : Int64
}
struct IBidiRequest extends IUnknown {
    static IID := "{8F348BD7-4B47-4755-8A9D-0F422DF3DC89}"
    SetSchema(pszSchema)
      => ComCall(3, this.p, "Str", pszSchema)
    SetInputData(dwType, pData, uSize)
      => ComCall(4, this.p, UInt32, dwType, UInt8.Ptr, pData, UInt32, uSize)
    GetResult(phr)
      => ComCall(5, this.p, HRESULT.Ptr, phr)
    GetOutputData(dwIndex, ppszSchema, pdwType, ppData, uSize)
      => ComCall(6, this.p, UInt32, dwIndex, PWSTR.Ptr, ppszSchema, UInt32.Ptr, pdwType, UInt8.Ptr.Ptr, ppData, UInt32.Ptr, uSize)
    GetEnumCount(pdwTotal)
      => ComCall(7, this.p, UInt32.Ptr, pdwTotal)
}
struct IBidiRequestContainer extends IUnknown {
    static IID := "{D752F6C0-94A8-4275-A77D-8F1D1A1121AE}"
    AddRequest(pRequest?)
      => ComCall(3, this.p, IBidiRequest, pRequest?)
    GetEnumObject(ppenum)
      => ComCall(4, this.p, IEnumUnknown.Ptr, ppenum)
    GetRequestCount(puCount)
      => ComCall(5, this.p, UInt32.Ptr, puCount)
}
struct IBidiSpl extends IUnknown {
    static IID := "{D580DC0E-DE39-4649-BAA8-BF0B85A03A97}"
    BindDevice(pszDeviceName, dwAccess)
      => ComCall(3, this.p, "Str", pszDeviceName, UInt32, dwAccess)
    UnbindDevice()
      => ComCall(4, this.p)
    SendRecv(pszAction, pRequest?)
      => ComCall(5, this.p, "Str", pszAction, IBidiRequest, pRequest?)
    MultiSendRecv(pszAction, pRequestContainer?)
      => ComCall(6, this.p, "Str", pszAction, IBidiRequestContainer, pRequestContainer?)
}
struct IBidiSpl2 extends IUnknown {
    static IID := "{0E8F51B8-8273-4906-8E7B-BE453FFD2E2B}"
    BindDevice(pszDeviceName, dwAccess)
      => ComCall(3, this.p, "Str", pszDeviceName, UInt32, dwAccess)
    UnbindDevice()
      => ComCall(4, this.p)
    SendRecvXMLString(bstrRequest, pbstrResponse)
      => ComCall(5, this.p, BSTR, bstrRequest, BSTR.Ptr, pbstrResponse)
    SendRecvXMLStream(pSRequest?, ppSResponse)
      => ComCall(6, this.p, IStream, pSRequest?, IStream.Ptr, ppSResponse)
}
struct ImgErrorInfo {
    description : BSTR
    guid : GUID
    helpContext : UInt32
    helpFile : BSTR
    source : BSTR
    devDescription : BSTR
    errorID : GUID
    cUserParameters : UInt32
    aUserParameters : BSTR.Ptr
    userFallback : BSTR
    exceptionID : UInt32
}
struct IImgErrorInfo extends IErrorInfo {
    static IID := "{2BCE4ECE-D30E-445A-9423-6829BE945AD8}"
    GetDeveloperDescription(pbstrDevDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDevDescription)
    GetUserErrorId(pErrorId)
      => ComCall(9, this.p, GUID.Ptr, pErrorId)
    GetUserParameterCount(pcUserParams)
      => ComCall(10, this.p, UInt32.Ptr, pcUserParams)
    GetUserParameter(cParam, pbstrParam)
      => ComCall(11, this.p, UInt32, cParam, BSTR.Ptr, pbstrParam)
    GetUserFallback(pbstrFallback)
      => ComCall(12, this.p, BSTR.Ptr, pbstrFallback)
    GetExceptionId(pExceptionId)
      => ComCall(13, this.p, UInt32.Ptr, pExceptionId)
    DetachErrorInfo(pErrorInfo)
      => ComCall(14, this.p, ImgErrorInfo.Ptr, pErrorInfo)
}
struct IImgCreateErrorInfo extends ICreateErrorInfo {
    static IID := "{1C55A64C-07CD-4FB5-90F7-B753D91F0C9E}"
    AttachToErrorInfo(pErrorInfo)
      => ComCall(8, this.p, ImgErrorInfo.Ptr, pErrorInfo)
}
struct EXpsCompressionOptions extends Int32 {
    static Compression_NotCompressed := 0
    static Compression_Normal := 1
    static Compression_Small := 2
    static Compression_Fast := 3
}
struct EXpsFontOptions extends Int32 {
    static Font_Normal := 0
    static Font_Obfusticate := 1
}
struct EXpsJobConsumption extends Int32 {
    static XpsJob_DocumentSequenceAdded := 0
    static XpsJob_FixedDocumentAdded := 1
    static XpsJob_FixedPageAdded := 2
}
struct EXpsFontRestriction extends Int32 {
    static Xps_Restricted_Font_Installable := 0
    static Xps_Restricted_Font_NoEmbedding := 2
    static Xps_Restricted_Font_PreviewPrint := 4
    static Xps_Restricted_Font_Editable := 8
}
struct IPrintReadStream extends IUnknown {
    static IID := "{4D47A67C-66CC-4430-850E-DAF466FE5BC4}"
    Seek(dlibMove, dwOrigin, plibNewPosition?)
      => ComCall(3, this.p, Int64, dlibMove, UInt32, dwOrigin, Int64.Ptr, plibNewPosition?)
    ReadBytes(pvBuffer, pcbRead, pbEndOfFile)
      => ComCall(4, this.p, Struct.Ptr, pvBuffer, UInt32, pvBuffer.Size, UInt32.Ptr, pcbRead, BOOL.Ptr, pbEndOfFile)
}
struct IPrintWriteStream extends IUnknown {
    static IID := "{65BB7F1B-371E-4571-8AC7-912F510C1A38}"
    WriteBytes(pvBuffer, pcbWritten)
      => ComCall(3, this.p, Struct.Ptr, pvBuffer, UInt32, pvBuffer.Size, UInt32.Ptr, pcbWritten)
    Close()
      => ComCall(4, this.p, "void")
}
struct IPrintWriteStreamFlush extends IUnknown {
    static IID := "{07D11FF8-1753-4873-B749-6CDAF068E4C3}"
    FlushData()
      => ComCall(3, this.p)
}
struct IInterFilterCommunicator extends IUnknown {
    static IID := "{4DAF1E69-81FD-462D-940F-8CD3DDF56FCA}"
    RequestReader(ppIReader)
      => ComCall(3, this.p, Struct.Ptr.Ptr, ppIReader)
    RequestWriter(ppIWriter)
      => ComCall(4, this.p, Struct.Ptr.Ptr, ppIWriter)
}
struct IPrintPipelineManagerControl extends IUnknown {
    static IID := "{AA3E4910-5889-4681-91EF-823AD4ED4E44}"
    RequestShutdown(hrReason, pReason)
      => ComCall(3, this.p, HRESULT, hrReason, IImgErrorInfo, pReason)
    FilterFinished()
      => ComCall(4, this.p)
}
struct IPrintPipelinePropertyBag extends IUnknown {
    static IID := "{8B8C99DC-7892-4A95-8A04-57422E9FBB47}"
    AddProperty(pszName, pVar)
      => ComCall(3, this.p, "Str", pszName, VARIANT.Ptr, pVar)
    GetProperty(pszName, pVar)
      => ComCall(4, this.p, "Str", pszName, VARIANT.Ptr, pVar)
    DeleteProperty(pszName)
      => ComCall(5, this.p, "Str", pszName, BOOL)
}
struct IPrintPipelineProgressReport extends IUnknown {
    static IID := "{EDC12C7C-ED40-4EA5-96A6-5E4397497A61}"
    ReportProgress(update)
      => ComCall(3, this.p, EXpsJobConsumption, update)
}
struct IPrintClassObjectFactory extends IUnknown {
    static IID := "{9AF593DD-9B02-48A8-9BAD-69ACE423F88B}"
    GetPrintClassObject(pszPrinterName, riid, ppNewObject)
      => ComCall(3, this.p, "Str", pszPrinterName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppNewObject)
}
struct IPrintPipelineFilter extends IUnknown {
    static IID := "{CDB62FC0-8BED-434E-86FB-A2CAE55F19EA}"
    InitializeFilter(pINegotiation, pIPropertyBag, pIPipelineControl)
      => ComCall(3, this.p, IInterFilterCommunicator, pINegotiation, IPrintPipelinePropertyBag, pIPropertyBag, IPrintPipelineManagerControl, pIPipelineControl)
    ShutdownOperation()
      => ComCall(4, this.p)
    StartOperation()
      => ComCall(5, this.p)
}
struct IXpsDocumentProvider extends IUnknown {
    static IID := "{B8CF8530-5562-47C4-AB67-B1F69ECF961E}"
    GetXpsPart(ppIXpsPart)
      => ComCall(3, this.p, IUnknown.Ptr, ppIXpsPart)
}
struct IXpsDocumentConsumer extends IUnknown {
    static IID := "{4368D8A2-4181-4A9F-B295-3D9A38BB9BA0}"
    SendXpsUnknown(pUnknown)
      => ComCall(3, this.p, IUnknown, pUnknown)
    SendXpsDocument(pIXpsDocument)
      => ComCall(4, this.p, IXpsDocument, pIXpsDocument)
    SendFixedDocumentSequence(pIFixedDocumentSequence)
      => ComCall(5, this.p, IFixedDocumentSequence, pIFixedDocumentSequence)
    SendFixedDocument(pIFixedDocument)
      => ComCall(6, this.p, IFixedDocument, pIFixedDocument)
    SendFixedPage(pIFixedPage)
      => ComCall(7, this.p, IFixedPage, pIFixedPage)
    CloseSender()
      => ComCall(8, this.p)
    GetNewEmptyPart(uri, riid, ppNewObject, ppWriteStream)
      => ComCall(9, this.p, "Str", uri, GUID.Ptr, riid, Struct.Ptr.Ptr, ppNewObject, IPrintWriteStream.Ptr, ppWriteStream)
}
struct IXpsDocument extends IUnknown {
    static IID := "{E8D907DB-62A9-4A95-ABE7-E01763DD30F8}"
    GetThumbnail(ppThumbnail)
      => ComCall(3, this.p, IPartThumbnail.Ptr, ppThumbnail)
    SetThumbnail(pThumbnail)
      => ComCall(4, this.p, IPartThumbnail, pThumbnail)
}
struct IFixedDocumentSequence extends IUnknown {
    static IID := "{8028D181-2C32-4249-8493-1BFB22045574}"
    GetUri(uri)
      => ComCall(3, this.p, BSTR.Ptr, uri)
    GetPrintTicket(ppPrintTicket)
      => ComCall(4, this.p, IPartPrintTicket.Ptr, ppPrintTicket)
    SetPrintTicket(pPrintTicket)
      => ComCall(5, this.p, IPartPrintTicket, pPrintTicket)
}
struct IFixedDocument extends IUnknown {
    static IID := "{F222CA9F-9968-4DB9-81BD-ABAEBF15F93F}"
    GetUri(uri)
      => ComCall(3, this.p, BSTR.Ptr, uri)
    GetPrintTicket(ppPrintTicket)
      => ComCall(4, this.p, IPartPrintTicket.Ptr, ppPrintTicket)
    SetPrintTicket(pPrintTicket)
      => ComCall(5, this.p, IPartPrintTicket, pPrintTicket)
}
struct IPartBase extends IUnknown {
    static IID := "{36D51E28-369E-43BA-A666-9540C62C3F58}"
    GetUri(uri)
      => ComCall(3, this.p, BSTR.Ptr, uri)
    GetStream(ppStream)
      => ComCall(4, this.p, IPrintReadStream.Ptr, ppStream)
    GetPartCompression(pCompression)
      => ComCall(5, this.p, EXpsCompressionOptions.Ptr, pCompression)
    SetPartCompression(compression)
      => ComCall(6, this.p, EXpsCompressionOptions, compression)
}
struct IFixedPage extends IPartBase {
    static IID := "{3D9F6448-7E95-4CB5-94FB-0180C2883A57}"
    GetPrintTicket(ppPrintTicket)
      => ComCall(7, this.p, IPartPrintTicket.Ptr, ppPrintTicket)
    GetPagePart(uri, ppUnk)
      => ComCall(8, this.p, "Str", uri, IUnknown.Ptr, ppUnk)
    GetWriteStream(ppWriteStream)
      => ComCall(9, this.p, IPrintWriteStream.Ptr, ppWriteStream)
    SetPrintTicket(ppPrintTicket)
      => ComCall(10, this.p, IPartPrintTicket, ppPrintTicket)
    SetPagePart(pUnk)
      => ComCall(11, this.p, IUnknown, pUnk)
    DeleteResource(uri)
      => ComCall(12, this.p, "Str", uri)
    GetXpsPartIterator(pXpsPartIt)
      => ComCall(13, this.p, IXpsPartIterator.Ptr, pXpsPartIt)
}
struct IPartImage extends IPartBase {
    static IID := "{725F2E3C-401A-4705-9DE0-FE6F1353B87F}"
    GetImageProperties(pContentType)
      => ComCall(7, this.p, BSTR.Ptr, pContentType)
    SetImageContent(pContentType)
      => ComCall(8, this.p, "Str", pContentType)
}
struct IPartFont extends IPartBase {
    static IID := "{E07FE0AB-1124-43D0-A865-E8FFB6A3EA82}"
    GetFontProperties(pContentType, pFontOptions)
      => ComCall(7, this.p, BSTR.Ptr, pContentType, EXpsFontOptions.Ptr, pFontOptions)
    SetFontContent(pContentType)
      => ComCall(8, this.p, "Str", pContentType)
    SetFontOptions(options)
      => ComCall(9, this.p, EXpsFontOptions, options)
}
struct IPartFont2 extends IPartFont {
    static IID := "{511E025F-D6CB-43BE-BF65-63FE88515A39}"
    GetFontRestriction(pRestriction)
      => ComCall(10, this.p, EXpsFontRestriction.Ptr, pRestriction)
}
struct IPartThumbnail extends IPartBase {
    static IID := "{027ED1C9-BA39-4CC5-AA55-7EC3A0DE171A}"
    GetThumbnailProperties(pContentType)
      => ComCall(7, this.p, BSTR.Ptr, pContentType)
    SetThumbnailContent(pContentType)
      => ComCall(8, this.p, "Str", pContentType)
}
struct IPartPrintTicket extends IPartBase {
    static IID := "{4A0F50F6-F9A2-41F0-99E7-5AE955BE8E9E}"
}
struct IPartColorProfile extends IPartBase {
    static IID := "{63CCA95B-7D18-4762-B15E-98658693D24A}"
}
struct IPartResourceDictionary extends IPartBase {
    static IID := "{16CFCE6D-E744-4FB3-B474-F1D54F024A01}"
}
struct IXpsPartIterator extends IUnknown {
    static IID := "{0021D3CD-AF6F-42AB-9999-14BC82A62D2E}"
    Reset()
      => ComCall(3, this.p, "void")
    Current(pUri, ppXpsPart)
      => ComCall(4, this.p, BSTR.Ptr, pUri, IUnknown.Ptr, ppXpsPart)
    IsDone()
      => ComCall(5, this.p, BOOL)
    Next()
      => ComCall(6, this.p, "void")
}
struct IPrintReadStreamFactory extends IUnknown {
    static IID := "{ACB971E3-DF8D-4FC2-BEE6-0609D15F3CF9}"
    GetStream(ppStream)
      => ComCall(3, this.p, IPrintReadStream.Ptr, ppStream)
}
struct IPartDiscardControl extends IUnknown {
    static IID := "{CC350C00-095B-42A5-BF0F-C8780EDADB3C}"
    GetDiscardProperties(uriSentinelPage, uriPartToDiscard)
      => ComCall(3, this.p, BSTR.Ptr, uriSentinelPage, BSTR.Ptr, uriPartToDiscard)
}
struct OPTPARAM {
    cbSize : UInt16 := this.Size
    Flags : UInt8
    Style : UInt8
    pData : Int8.Ptr
    IconID : IntPtr
    lParam : LPARAM
    dwReserved : IntPtr[2]
}
struct OPTCOMBO {
    cbSize : UInt16 := this.Size
    Flags : UInt8
    cListItem : UInt16
    pListItem : OPTPARAM.Ptr
    Sel : Int32
    dwReserved : UInt32[3]
}
struct OPTTYPE {
    cbSize : UInt16 := this.Size
    Type : UInt8
    Flags : UInt8
    Count : UInt16
    BegCtrlID : UInt16
    pOptParam : OPTPARAM.Ptr
    Style : UInt16
    wReserved : UInt16[3]
    dwReserved : IntPtr[3]
}
struct EXTPUSH {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    pTitle : Int8.Ptr
    Anonymous1 : this._Anonymous1_e__Union
    IconID : IntPtr
    Anonymous2 : this._Anonymous2_e__Union
    dwReserved : IntPtr[3]
    struct _Anonymous1_e__Union {
        union {
            DlgProc : DLGPROC
            pfnCallBack : FARPROC
        }
    }
    struct _Anonymous2_e__Union {
        union {
            DlgTemplateID : UInt16
            hDlgTemplate : HANDLE
        }
    }
}
struct EXTCHKBOX {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    pTitle : Int8.Ptr
    pSeparator : Int8.Ptr
    pCheckedName : Int8.Ptr
    IconID : IntPtr
    wReserved : UInt16[4]
    dwReserved : IntPtr[2]
}
struct OIEXT {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    hInstCaller : HINSTANCE
    pHelpFile : Int8.Ptr
    dwReserved : IntPtr[4]
}
struct OPTITEM {
    cbSize : UInt16 := this.Size
    Level : UInt8
    DlgPageIdx : UInt8
    Flags : UInt32
    UserData : IntPtr
    pName : Int8.Ptr
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pOptType : OPTTYPE.Ptr
    HelpIndex : UInt32
    DMPubID : UInt8
    UserItemID : UInt8
    wReserved : UInt16
    pOIExt : OIEXT.Ptr
    dwReserved : IntPtr[3]
    struct _Anonymous1_e__Union {
        union {
            Sel : Int32
            pSel : Int8.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pExtChkBox : EXTCHKBOX.Ptr
            pExtPush : EXTPUSH.Ptr
        }
    }
}
struct CPSUICBPARAM {
    cbSize : UInt16 := this.Size
    Reason : UInt16
    hDlg : HWND
    pOptItem : OPTITEM.Ptr
    cOptItem : UInt16
    Flags : UInt16
    pCurItem : OPTITEM.Ptr
    Anonymous : this._Anonymous_e__Union
    UserData : IntPtr
    Result : IntPtr
    struct _Anonymous_e__Union {
        union {
            OldSel : Int32
            pOldSel : Int8.Ptr
        }
    }
}
struct CPSUICALLBACK extends FunctionPointer {
    static Types := [CPSUICBPARAM.Ptr, Int32]
}
struct DLGPAGE {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    DlgProc : DLGPROC
    pTabName : Int8.Ptr
    IconID : IntPtr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            DlgTemplateID : UInt16
            hDlgTemplate : HANDLE
        }
    }
}
struct COMPROPSHEETUI {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    hInstCaller : HINSTANCE
    pCallerName : Int8.Ptr
    UserData : IntPtr
    pHelpFile : Int8.Ptr
    pfnCallBack : CPSUICALLBACK
    pOptItem : OPTITEM.Ptr
    pDlgPage : DLGPAGE.Ptr
    cOptItem : UInt16
    cDlgPage : UInt16
    IconID : IntPtr
    pOptItemName : Int8.Ptr
    CallerVersion : UInt16
    OptItemVersion : UInt16
    dwReserved : IntPtr[4]
}
struct SETRESULT_INFO {
    cbSize : UInt16 := this.Size
    wReserved : UInt16
    hSetResult : HANDLE
    Result : LRESULT
}
struct INSERTPSUIPAGE_INFO {
    cbSize : UInt16 := this.Size
    Type : UInt8
    Mode : UInt8
    dwData1 : IntPtr
    dwData2 : IntPtr
    dwData3 : IntPtr
}
struct PFNCOMPROPSHEET extends FunctionPointer {
    static Types := [HANDLE, UInt32, LPARAM, LPARAM, IntPtr]
}
struct PSPINFO {
    cbSize : UInt16 := this.Size
    wReserved : UInt16
    hComPropSheet : HANDLE
    hCPSUIPage : HANDLE
    pfnComPropSheet : PFNCOMPROPSHEET
}
struct CPSUIDATABLOCK {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct PROPSHEETUI_INFO {
    cbSize : UInt16 := this.Size
    Version : UInt16
    Flags : UInt16
    Reason : UInt16
    hComPropSheet : HANDLE
    pfnComPropSheet : PFNCOMPROPSHEET
    lParamInit : LPARAM
    UserData : IntPtr
    Result : IntPtr
}
struct PROPSHEETUI_GETICON_INFO {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    cxIcon : UInt16
    cyIcon : UInt16
    hIcon : HICON
}
struct PFNPROPSHEETUI extends FunctionPointer {
    static Types := [PROPSHEETUI_INFO.Ptr, LPARAM, Int32]
}
struct PROPSHEETUI_INFO_HEADER {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    pTitle : Int8.Ptr
    hWndParent : HWND
    hInst : HINSTANCE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            hIcon : HICON
            IconID : IntPtr
        }
    }
}
struct PRINTER_INFO_1A {
    Flags : UInt32
    pDescription : PSTR
    pName : PSTR
    pComment : PSTR
}
struct PRINTER_INFO_1W {
    Flags : UInt32
    pDescription : PWSTR
    pName : PWSTR
    pComment : PWSTR
}
struct PRINTER_INFO_2A {
    pServerName : PSTR
    pPrinterName : PSTR
    pShareName : PSTR
    pPortName : PSTR
    pDriverName : PSTR
    pComment : PSTR
    pLocation : PSTR
    pDevMode : DEVMODEA.Ptr
    pSepFile : PSTR
    pPrintProcessor : PSTR
    pDatatype : PSTR
    pParameters : PSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Attributes : UInt32
    Priority : UInt32
    DefaultPriority : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    Status : UInt32
    cJobs : UInt32
    AveragePPM : UInt32
}
struct PRINTER_INFO_2W {
    pServerName : PWSTR
    pPrinterName : PWSTR
    pShareName : PWSTR
    pPortName : PWSTR
    pDriverName : PWSTR
    pComment : PWSTR
    pLocation : PWSTR
    pDevMode : DEVMODEW.Ptr
    pSepFile : PWSTR
    pPrintProcessor : PWSTR
    pDatatype : PWSTR
    pParameters : PWSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Attributes : UInt32
    Priority : UInt32
    DefaultPriority : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    Status : UInt32
    cJobs : UInt32
    AveragePPM : UInt32
}
struct PRINTER_INFO_3 {
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct PRINTER_INFO_4A {
    pPrinterName : PSTR
    pServerName : PSTR
    Attributes : UInt32
}
struct PRINTER_INFO_4W {
    pPrinterName : PWSTR
    pServerName : PWSTR
    Attributes : UInt32
}
struct PRINTER_INFO_5A {
    pPrinterName : PSTR
    pPortName : PSTR
    Attributes : UInt32
    DeviceNotSelectedTimeout : UInt32
    TransmissionRetryTimeout : UInt32
}
struct PRINTER_INFO_5W {
    pPrinterName : PWSTR
    pPortName : PWSTR
    Attributes : UInt32
    DeviceNotSelectedTimeout : UInt32
    TransmissionRetryTimeout : UInt32
}
struct PRINTER_INFO_6 {
    dwStatus : UInt32
}
struct PRINTER_INFO_7A {
    pszObjectGUID : PSTR
    dwAction : UInt32
}
struct PRINTER_INFO_7W {
    pszObjectGUID : PWSTR
    dwAction : UInt32
}
struct PRINTER_INFO_8A {
    pDevMode : DEVMODEA.Ptr
}
struct PRINTER_INFO_8W {
    pDevMode : DEVMODEW.Ptr
}
struct PRINTER_INFO_9A {
    pDevMode : DEVMODEA.Ptr
}
struct PRINTER_INFO_9W {
    pDevMode : DEVMODEW.Ptr
}
struct JOB_INFO_1A {
    JobId : UInt32
    pPrinterName : PSTR
    pMachineName : PSTR
    pUserName : PSTR
    pDocument : PSTR
    pDatatype : PSTR
    pStatus : PSTR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    TotalPages : UInt32
    PagesPrinted : UInt32
    Submitted : SYSTEMTIME
}
struct JOB_INFO_1W {
    JobId : UInt32
    pPrinterName : PWSTR
    pMachineName : PWSTR
    pUserName : PWSTR
    pDocument : PWSTR
    pDatatype : PWSTR
    pStatus : PWSTR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    TotalPages : UInt32
    PagesPrinted : UInt32
    Submitted : SYSTEMTIME
}
struct JOB_INFO_2A {
    JobId : UInt32
    pPrinterName : PSTR
    pMachineName : PSTR
    pUserName : PSTR
    pDocument : PSTR
    pNotifyName : PSTR
    pDatatype : PSTR
    pPrintProcessor : PSTR
    pParameters : PSTR
    pDriverName : PSTR
    pDevMode : DEVMODEA.Ptr
    pStatus : PSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    TotalPages : UInt32
    Size : UInt32
    Submitted : SYSTEMTIME
    Time : UInt32
    PagesPrinted : UInt32
}
struct JOB_INFO_2W {
    JobId : UInt32
    pPrinterName : PWSTR
    pMachineName : PWSTR
    pUserName : PWSTR
    pDocument : PWSTR
    pNotifyName : PWSTR
    pDatatype : PWSTR
    pPrintProcessor : PWSTR
    pParameters : PWSTR
    pDriverName : PWSTR
    pDevMode : DEVMODEW.Ptr
    pStatus : PWSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    TotalPages : UInt32
    Size : UInt32
    Submitted : SYSTEMTIME
    Time : UInt32
    PagesPrinted : UInt32
}
struct JOB_INFO_3 {
    JobId : UInt32
    NextJobId : UInt32
    Reserved : UInt32
}
struct JOB_INFO_4A {
    JobId : UInt32
    pPrinterName : PSTR
    pMachineName : PSTR
    pUserName : PSTR
    pDocument : PSTR
    pNotifyName : PSTR
    pDatatype : PSTR
    pPrintProcessor : PSTR
    pParameters : PSTR
    pDriverName : PSTR
    pDevMode : DEVMODEA.Ptr
    pStatus : PSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    TotalPages : UInt32
    Size : UInt32
    Submitted : SYSTEMTIME
    Time : UInt32
    PagesPrinted : UInt32
    SizeHigh : Int32
}
struct JOB_INFO_4W {
    JobId : UInt32
    pPrinterName : PWSTR
    pMachineName : PWSTR
    pUserName : PWSTR
    pDocument : PWSTR
    pNotifyName : PWSTR
    pDatatype : PWSTR
    pPrintProcessor : PWSTR
    pParameters : PWSTR
    pDriverName : PWSTR
    pDevMode : DEVMODEW.Ptr
    pStatus : PWSTR
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
    Status : UInt32
    Priority : UInt32
    Position : UInt32
    StartTime : UInt32
    UntilTime : UInt32
    TotalPages : UInt32
    Size : UInt32
    Submitted : SYSTEMTIME
    Time : UInt32
    PagesPrinted : UInt32
    SizeHigh : Int32
}
struct ADDJOB_INFO_1A {
    Path : PSTR
    JobId : UInt32
}
struct ADDJOB_INFO_1W {
    Path : PWSTR
    JobId : UInt32
}
struct DRIVER_INFO_1A {
    pName : PSTR
}
struct DRIVER_INFO_1W {
    pName : PWSTR
}
struct DRIVER_INFO_2A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
}
struct DRIVER_INFO_2W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
}
struct DRIVER_INFO_3A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
    pHelpFile : PSTR
    pDependentFiles : PSTR
    pMonitorName : PSTR
    pDefaultDataType : PSTR
}
struct DRIVER_INFO_3W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
    pHelpFile : PWSTR
    pDependentFiles : PWSTR
    pMonitorName : PWSTR
    pDefaultDataType : PWSTR
}
struct DRIVER_INFO_4A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
    pHelpFile : PSTR
    pDependentFiles : PSTR
    pMonitorName : PSTR
    pDefaultDataType : PSTR
    pszzPreviousNames : PSTR
}
struct DRIVER_INFO_4W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
    pHelpFile : PWSTR
    pDependentFiles : PWSTR
    pMonitorName : PWSTR
    pDefaultDataType : PWSTR
    pszzPreviousNames : PWSTR
}
struct DRIVER_INFO_5A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
    dwDriverAttributes : UInt32
    dwConfigVersion : UInt32
    dwDriverVersion : UInt32
}
struct DRIVER_INFO_5W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
    dwDriverAttributes : UInt32
    dwConfigVersion : UInt32
    dwDriverVersion : UInt32
}
struct DRIVER_INFO_6A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
    pHelpFile : PSTR
    pDependentFiles : PSTR
    pMonitorName : PSTR
    pDefaultDataType : PSTR
    pszzPreviousNames : PSTR
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    pszMfgName : PSTR
    pszOEMUrl : PSTR
    pszHardwareID : PSTR
    pszProvider : PSTR
}
struct DRIVER_INFO_6W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
    pHelpFile : PWSTR
    pDependentFiles : PWSTR
    pMonitorName : PWSTR
    pDefaultDataType : PWSTR
    pszzPreviousNames : PWSTR
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    pszMfgName : PWSTR
    pszOEMUrl : PWSTR
    pszHardwareID : PWSTR
    pszProvider : PWSTR
}
struct DRIVER_INFO_8A {
    cVersion : UInt32
    pName : PSTR
    pEnvironment : PSTR
    pDriverPath : PSTR
    pDataFile : PSTR
    pConfigFile : PSTR
    pHelpFile : PSTR
    pDependentFiles : PSTR
    pMonitorName : PSTR
    pDefaultDataType : PSTR
    pszzPreviousNames : PSTR
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    pszMfgName : PSTR
    pszOEMUrl : PSTR
    pszHardwareID : PSTR
    pszProvider : PSTR
    pszPrintProcessor : PSTR
    pszVendorSetup : PSTR
    pszzColorProfiles : PSTR
    pszInfPath : PSTR
    dwPrinterDriverAttributes : UInt32
    pszzCoreDriverDependencies : PSTR
    ftMinInboxDriverVerDate : FILETIME
    dwlMinInboxDriverVerVersion : Int64
}
struct DRIVER_INFO_8W {
    cVersion : UInt32
    pName : PWSTR
    pEnvironment : PWSTR
    pDriverPath : PWSTR
    pDataFile : PWSTR
    pConfigFile : PWSTR
    pHelpFile : PWSTR
    pDependentFiles : PWSTR
    pMonitorName : PWSTR
    pDefaultDataType : PWSTR
    pszzPreviousNames : PWSTR
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    pszMfgName : PWSTR
    pszOEMUrl : PWSTR
    pszHardwareID : PWSTR
    pszProvider : PWSTR
    pszPrintProcessor : PWSTR
    pszVendorSetup : PWSTR
    pszzColorProfiles : PWSTR
    pszInfPath : PWSTR
    dwPrinterDriverAttributes : UInt32
    pszzCoreDriverDependencies : PWSTR
    ftMinInboxDriverVerDate : FILETIME
    dwlMinInboxDriverVerVersion : Int64
}
struct DOC_INFO_1A {
    pDocName : PSTR
    pOutputFile : PSTR
    pDatatype : PSTR
}
struct DOC_INFO_1W {
    pDocName : PWSTR
    pOutputFile : PWSTR
    pDatatype : PWSTR
}
struct FORM_INFO_1A {
    Flags : UInt32
    pName : PSTR
    Size : SIZE
    ImageableArea : RECTL
}
struct FORM_INFO_1W {
    Flags : UInt32
    pName : PWSTR
    Size : SIZE
    ImageableArea : RECTL
}
struct FORM_INFO_2A {
    Flags : UInt32
    pName : PSTR
    Size : SIZE
    ImageableArea : RECTL
    pKeyword : PSTR
    StringType : UInt32
    pMuiDll : PSTR
    dwResourceId : UInt32
    pDisplayName : PSTR
    wLangId : UInt16
}
struct FORM_INFO_2W {
    Flags : UInt32
    pName : PWSTR
    Size : SIZE
    ImageableArea : RECTL
    pKeyword : PSTR
    StringType : UInt32
    pMuiDll : PWSTR
    dwResourceId : UInt32
    pDisplayName : PWSTR
    wLangId : UInt16
}
struct DOC_INFO_2A {
    pDocName : PSTR
    pOutputFile : PSTR
    pDatatype : PSTR
    dwMode : UInt32
    JobId : UInt32
}
struct DOC_INFO_2W {
    pDocName : PWSTR
    pOutputFile : PWSTR
    pDatatype : PWSTR
    dwMode : UInt32
    JobId : UInt32
}
struct DOC_INFO_3A {
    pDocName : PSTR
    pOutputFile : PSTR
    pDatatype : PSTR
    dwFlags : UInt32
}
struct DOC_INFO_3W {
    pDocName : PWSTR
    pOutputFile : PWSTR
    pDatatype : PWSTR
    dwFlags : UInt32
}
struct PRINTPROCESSOR_INFO_1A {
    pName : PSTR
}
struct PRINTPROCESSOR_INFO_1W {
    pName : PWSTR
}
struct PRINTPROCESSOR_CAPS_1 {
    dwLevel : UInt32
    dwNupOptions : UInt32
    dwPageOrderFlags : UInt32
    dwNumberOfCopies : UInt32
}
struct PRINTPROCESSOR_CAPS_2 {
    dwLevel : UInt32
    dwNupOptions : UInt32
    dwPageOrderFlags : UInt32
    dwNumberOfCopies : UInt32
    dwDuplexHandlingCaps : UInt32
    dwNupDirectionCaps : UInt32
    dwNupBorderCaps : UInt32
    dwBookletHandlingCaps : UInt32
    dwScalingCaps : UInt32
}
struct PORT_INFO_1A {
    pName : PSTR
}
struct PORT_INFO_1W {
    pName : PWSTR
}
struct PORT_INFO_2A {
    pPortName : PSTR
    pMonitorName : PSTR
    pDescription : PSTR
    fPortType : UInt32
    Reserved : UInt32
}
struct PORT_INFO_2W {
    pPortName : PWSTR
    pMonitorName : PWSTR
    pDescription : PWSTR
    fPortType : UInt32
    Reserved : UInt32
}
struct PORT_INFO_3A {
    dwStatus : UInt32
    pszStatus : PSTR
    dwSeverity : UInt32
}
struct PORT_INFO_3W {
    dwStatus : UInt32
    pszStatus : PWSTR
    dwSeverity : UInt32
}
struct MONITOR_INFO_1A {
    pName : PSTR
}
struct MONITOR_INFO_1W {
    pName : PWSTR
}
struct MONITOR_INFO_2A {
    pName : PSTR
    pEnvironment : PSTR
    pDLLName : PSTR
}
struct MONITOR_INFO_2W {
    pName : PWSTR
    pEnvironment : PWSTR
    pDLLName : PWSTR
}
struct DATATYPES_INFO_1A {
    pName : PSTR
}
struct DATATYPES_INFO_1W {
    pName : PWSTR
}
struct PRINTER_DEFAULTSA {
    pDatatype : PSTR
    pDevMode : DEVMODEA.Ptr
    DesiredAccess : PRINTER_ACCESS_RIGHTS
}
struct PRINTER_DEFAULTSW {
    pDatatype : PWSTR
    pDevMode : DEVMODEW.Ptr
    DesiredAccess : PRINTER_ACCESS_RIGHTS
}
struct PRINTER_ENUM_VALUESA {
    pValueName : PSTR
    cbValueName : UInt32
    dwType : UInt32
    pData : UInt8.Ptr
    cbData : UInt32
}
struct PRINTER_ENUM_VALUESW {
    pValueName : PWSTR
    cbValueName : UInt32
    dwType : UInt32
    pData : UInt8.Ptr
    cbData : UInt32
}
struct PRINTER_NOTIFY_OPTIONS_TYPE {
    Type : UInt16
    Reserved0 : UInt16
    Reserved1 : UInt32
    Reserved2 : UInt32
    Count : UInt32
    pFields : UInt16.Ptr
}
struct PRINTER_NOTIFY_OPTIONS {
    Version : UInt32
    Flags : UInt32
    Count : UInt32
    pTypes : PRINTER_NOTIFY_OPTIONS_TYPE.Ptr
}
struct PRINTER_NOTIFY_INFO_DATA {
    Type : UInt16
    Field : UInt16
    Reserved : UInt32
    Id : UInt32
    NotifyData : this._NotifyData_e__Union
    struct _NotifyData_e__Union {
        union {
            adwData : UInt32[2]
            Data : this._Data_e__Struct
        }
        struct _Data_e__Struct {
            cbBuf : UInt32
            pBuf : Struct.Ptr
        }
    }
}
struct PRINTER_NOTIFY_INFO {
    Version : UInt32
    Flags : UInt32
    Count : UInt32
    aData : PRINTER_NOTIFY_INFO_DATA[1]
}
struct BINARY_CONTAINER {
    cbBuf : UInt32
    pData : UInt8.Ptr
}
struct BIDI_DATA {
    dwBidiType : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            bData : BOOL
            iData : Int32
            sData : PWSTR
            fData : Float32
            biData : BINARY_CONTAINER
        }
    }
}
struct BIDI_REQUEST_DATA {
    dwReqNumber : UInt32
    pSchema : PWSTR
    data : BIDI_DATA
}
struct BIDI_REQUEST_CONTAINER {
    Version : UInt32
    Flags : UInt32
    Count : UInt32
    aData : BIDI_REQUEST_DATA[1]
}
struct BIDI_RESPONSE_DATA {
    dwResult : UInt32
    dwReqNumber : UInt32
    pSchema : PWSTR
    data : BIDI_DATA
}
struct BIDI_RESPONSE_CONTAINER {
    Version : UInt32
    Flags : UInt32
    Count : UInt32
    aData : BIDI_RESPONSE_DATA[1]
}
struct BIDI_TYPE extends Int32 {
    static BIDI_NULL := 0
    static BIDI_INT := 1
    static BIDI_FLOAT := 2
    static BIDI_BOOL := 3
    static BIDI_STRING := 4
    static BIDI_TEXT := 5
    static BIDI_ENUM := 6
    static BIDI_BLOB := 7
}
struct PROVIDOR_INFO_1A {
    pName : PSTR
    pEnvironment : PSTR
    pDLLName : PSTR
}
struct PROVIDOR_INFO_1W {
    pName : PWSTR
    pEnvironment : PWSTR
    pDLLName : PWSTR
}
struct PROVIDOR_INFO_2A {
    pOrder : PSTR
}
struct PROVIDOR_INFO_2W {
    pOrder : PWSTR
}
struct PRINTER_OPTION_FLAGS extends Int32 {
    static PRINTER_OPTION_NO_CACHE := 1
    static PRINTER_OPTION_CACHE := 2
    static PRINTER_OPTION_CLIENT_CHANGE := 4
    static PRINTER_OPTION_NO_CLIENT_DATA := 8
}
struct PRINTER_OPTIONSA {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
}
struct PRINTER_OPTIONSW {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
}
struct PRINTER_CONNECTION_INFO_1A {
    dwFlags : UInt32
    pszDriverName : PSTR
}
struct PRINTER_CONNECTION_INFO_1W {
    dwFlags : UInt32
    pszDriverName : PWSTR
}
struct CORE_PRINTER_DRIVERA {
    CoreDriverGUID : GUID
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    szPackageID : CHAR[260]
}
struct CORE_PRINTER_DRIVERW {
    CoreDriverGUID : GUID
    ftDriverDate : FILETIME
    dwlDriverVersion : Int64
    szPackageID : UInt16[260]
}
struct EPrintPropertyType extends Int32 {
    static kPropertyTypeString := 1
    static kPropertyTypeInt32 := 2
    static kPropertyTypeInt64 := 3
    static kPropertyTypeByte := 4
    static kPropertyTypeTime := 5
    static kPropertyTypeDevMode := 6
    static kPropertyTypeSD := 7
    static kPropertyTypeNotificationReply := 8
    static kPropertyTypeNotificationOptions := 9
    static kPropertyTypeBuffer := 10
}
struct EPrintXPSJobProgress extends Int32 {
    static kAddingDocumentSequence := 0
    static kDocumentSequenceAdded := 1
    static kAddingFixedDocument := 2
    static kFixedDocumentAdded := 3
    static kAddingFixedPage := 4
    static kFixedPageAdded := 5
    static kResourceAdded := 6
    static kFontAdded := 7
    static kImageAdded := 8
    static kXpsDocumentCommitted := 9
}
struct EPrintXPSJobOperation extends Int32 {
    static kJobProduction := 1
    static kJobConsumption := 2
}
struct PrintPropertyValue {
    ePropertyType : EPrintPropertyType
    value : this._value_e__Union
    struct _value_e__Union {
        union {
            propertyByte : UInt8
            propertyString : PWSTR
            propertyInt32 : Int32
            propertyInt64 : Int64
            propertyBlob : this._propertyBlob_e__Struct
        }
        struct _propertyBlob_e__Struct {
            cbBuf : UInt32
            pBuf : Struct.Ptr
        }
    }
}
struct PrintNamedProperty {
    propertyName : PWSTR
    propertyValue : PrintPropertyValue
}
struct PrintPropertiesCollection {
    numberOfProperties : UInt32
    propertiesCollection : PrintNamedProperty.Ptr
}
struct PRINT_EXECUTION_CONTEXT extends Int32 {
    static PRINT_EXECUTION_CONTEXT_APPLICATION := 0
    static PRINT_EXECUTION_CONTEXT_SPOOLER_SERVICE := 1
    static PRINT_EXECUTION_CONTEXT_SPOOLER_ISOLATION_HOST := 2
    static PRINT_EXECUTION_CONTEXT_FILTER_PIPELINE := 3
    static PRINT_EXECUTION_CONTEXT_WOW64 := 4
}
struct PRINT_EXECUTION_DATA {
    context : PRINT_EXECUTION_CONTEXT
    clientAppPID : UInt32
}
struct MXDC_LANDSCAPE_ROTATION_ENUMS extends Int32 {
    static MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_90_DEGREES := 90
    static MXDC_LANDSCAPE_ROTATE_NONE := 0
    static MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_270_DEGREES := -90
}
struct MXDC_IMAGE_TYPE_ENUMS extends Int32 {
    static MXDC_IMAGETYPE_JPEGHIGH_COMPRESSION := 1
    static MXDC_IMAGETYPE_JPEGMEDIUM_COMPRESSION := 2
    static MXDC_IMAGETYPE_JPEGLOW_COMPRESSION := 3
    static MXDC_IMAGETYPE_PNG := 4
}
struct MXDC_ESCAPE_HEADER_T {
    cbInput : UInt32
    cbOutput : UInt32
    opCode : UInt32
}
struct MXDC_GET_FILENAME_DATA_T {
    cbOutput : UInt32
    wszData : UInt16[1]
}
struct MXDC_S0PAGE_DATA_T {
    dwSize : UInt32
    bData : UInt8[1]
}
struct MXDC_S0_PAGE_ENUMS extends Int32 {
    static MXDC_RESOURCE_TTF := 0
    static MXDC_RESOURCE_JPEG := 1
    static MXDC_RESOURCE_PNG := 2
    static MXDC_RESOURCE_TIFF := 3
    static MXDC_RESOURCE_WDP := 4
    static MXDC_RESOURCE_DICTIONARY := 5
    static MXDC_RESOURCE_ICC_PROFILE := 6
    static MXDC_RESOURCE_JPEG_THUMBNAIL := 7
    static MXDC_RESOURCE_PNG_THUMBNAIL := 8
    static MXDC_RESOURCE_MAX := 9
}
struct MXDC_XPS_S0PAGE_RESOURCE_T {
    dwSize : UInt32
    dwResourceType : UInt32
    szUri : UInt8[260]
    dwDataSize : UInt32
    bData : UInt8[1]
}
struct MXDC_PRINTTICKET_DATA_T {
    dwDataSize : UInt32
    bData : UInt8[1]
}
struct MXDC_PRINTTICKET_ESCAPE_T {
    mxdcEscape : MXDC_ESCAPE_HEADER_T
    printTicketData : MXDC_PRINTTICKET_DATA_T
}
struct MXDC_S0PAGE_PASSTHROUGH_ESCAPE_T {
    mxdcEscape : MXDC_ESCAPE_HEADER_T
    xpsS0PageData : MXDC_S0PAGE_DATA_T
}
struct MXDC_S0PAGE_RESOURCE_ESCAPE_T {
    mxdcEscape : MXDC_ESCAPE_HEADER_T
    xpsS0PageResourcePassthrough : MXDC_XPS_S0PAGE_RESOURCE_T
}
struct DEVICEPROPERTYHEADER {
    cbSize : UInt16 := this.Size
    Flags : UInt16
    hPrinter : HANDLE
    pszPrinterName : Int8.Ptr
}
struct DOCUMENTPROPERTYHEADER {
    cbSize : UInt16 := this.Size
    Reserved : UInt16
    hPrinter : HANDLE
    pszPrinterName : Int8.Ptr
    pdmIn : DEVMODEA.Ptr
    pdmOut : DEVMODEA.Ptr
    cbOut : UInt32
    fMode : UInt32
}
struct DEVQUERYPRINT_INFO {
    cbSize : UInt16 := this.Size
    Level : UInt16
    hPrinter : HANDLE
    pDevMode : DEVMODEA.Ptr
    pszErrorStr : PWSTR
    cchErrorStr : UInt32
    cchNeeded : UInt32
}
struct DRIVER_UPGRADE_INFO_1 {
    pPrinterName : Int8.Ptr
    pOldDriverDirectory : Int8.Ptr
}
struct DRIVER_UPGRADE_INFO_2 {
    pPrinterName : Int8.Ptr
    pOldDriverDirectory : Int8.Ptr
    cVersion : UInt32
    pName : Int8.Ptr
    pEnvironment : Int8.Ptr
    pDriverPath : Int8.Ptr
    pDataFile : Int8.Ptr
    pConfigFile : Int8.Ptr
    pHelpFile : Int8.Ptr
    pDependentFiles : Int8.Ptr
    pMonitorName : Int8.Ptr
    pDefaultDataType : Int8.Ptr
    pszzPreviousNames : Int8.Ptr
}
struct DOCEVENT_FILTER {
    cbSize : UInt32 := this.Size
    cElementsAllocated : UInt32
    cElementsNeeded : UInt32
    cElementsReturned : UInt32
    aDocEventCall : UInt32[1]
}
struct DOCEVENT_CREATEDCPRE {
    pszDriver : PWSTR
    pszDevice : PWSTR
    pdm : DEVMODEW.Ptr
    bIC : BOOL
}
struct DOCEVENT_ESCAPE {
    iEscape : Int32
    cjInput : Int32
    pvInData : Struct.Ptr
}
struct PRINTER_EVENT_ATTRIBUTES_INFO {
    cbSize : UInt32 := this.Size
    dwOldAttributes : UInt32
    dwNewAttributes : UInt32
}
struct ATTRIBUTE_INFO_1 {
    dwJobNumberOfPagesPerSide : UInt32
    dwDrvNumberOfPagesPerSide : UInt32
    dwNupBorderFlags : UInt32
    dwJobPageOrderFlags : UInt32
    dwDrvPageOrderFlags : UInt32
    dwJobNumberOfCopies : UInt32
    dwDrvNumberOfCopies : UInt32
}
struct ATTRIBUTE_INFO_2 {
    dwJobNumberOfPagesPerSide : UInt32
    dwDrvNumberOfPagesPerSide : UInt32
    dwNupBorderFlags : UInt32
    dwJobPageOrderFlags : UInt32
    dwDrvPageOrderFlags : UInt32
    dwJobNumberOfCopies : UInt32
    dwDrvNumberOfCopies : UInt32
    dwColorOptimization : UInt32
}
struct ATTRIBUTE_INFO_3 {
    dwJobNumberOfPagesPerSide : UInt32
    dwDrvNumberOfPagesPerSide : UInt32
    dwNupBorderFlags : UInt32
    dwJobPageOrderFlags : UInt32
    dwDrvPageOrderFlags : UInt32
    dwJobNumberOfCopies : UInt32
    dwDrvNumberOfCopies : UInt32
    dwColorOptimization : UInt32
    dmPrintQuality : Int16
    dmYResolution : Int16
}
struct ATTRIBUTE_INFO_4 {
    dwJobNumberOfPagesPerSide : UInt32
    dwDrvNumberOfPagesPerSide : UInt32
    dwNupBorderFlags : UInt32
    dwJobPageOrderFlags : UInt32
    dwDrvPageOrderFlags : UInt32
    dwJobNumberOfCopies : UInt32
    dwDrvNumberOfCopies : UInt32
    dwColorOptimization : UInt32
    dmPrintQuality : Int16
    dmYResolution : Int16
    dwDuplexFlags : UInt32
    dwNupDirection : UInt32
    dwBookletFlags : UInt32
    dwScalingPercentX : UInt32
    dwScalingPercentY : UInt32
}
struct PSCRIPT5_PRIVATE_DEVMODE {
    wReserved : UInt16[57]
    wSize : UInt16
}
struct UNIDRV_PRIVATE_DEVMODE {
    wReserved : UInt16[4]
    wSize : UInt16
}
struct PUBLISHERINFO {
    dwMode : UInt32
    wMinoutlinePPEM : UInt16
    wMaxbitmapPPEM : UInt16
}
struct OEMDMPARAM {
    cbSize : UInt32 := this.Size
    pdriverobj : Struct.Ptr
    hPrinter : HANDLE
    hModule : HANDLE
    pPublicDMIn : DEVMODEA.Ptr
    pPublicDMOut : DEVMODEA.Ptr
    pOEMDMIn : Struct.Ptr
    pOEMDMOut : Struct.Ptr
    cbBufSize : UInt32
}
struct OEM_DMEXTRAHEADER {
    dwSize : UInt32
    dwSignature : UInt32
    dwVersion : UInt32
}
struct USERDATA {
    dwSize : UInt32
    dwItemID : IntPtr
    pKeyWordName : PSTR
    dwReserved : UInt32[8]
}
struct PFN_DrvGetDriverSetting extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_DrvUpgradeRegistrySetting extends FunctionPointer {
    static Types := [HANDLE, PSTR, PSTR, BOOL]
}
struct PFN_DrvUpdateUISetting extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, UInt32, BOOL]
}
struct SIMULATE_CAPS_1 {
    dwLevel : UInt32
    dwPageOrderFlags : UInt32
    dwNumberOfCopies : UInt32
    dwCollate : UInt32
    dwNupOptions : UInt32
}
struct OEMUIPROCS {
    DrvGetDriverSetting : PFN_DrvGetDriverSetting
    DrvUpdateUISetting : PFN_DrvUpdateUISetting
}
struct OEMUIOBJ {
    cbSize : UInt32 := this.Size
    pOemUIProcs : OEMUIPROCS.Ptr
}
struct OEMCUIPCALLBACK extends FunctionPointer {
    static Types := [CPSUICBPARAM.Ptr, OEMCUIPPARAM.Ptr, Int32]
}
struct OEMCUIPPARAM {
    cbSize : UInt32 := this.Size
    poemuiobj : OEMUIOBJ.Ptr
    hPrinter : HANDLE
    pPrinterName : PWSTR
    hModule : HANDLE
    hOEMHeap : HANDLE
    pPublicDM : DEVMODEA.Ptr
    pOEMDM : Struct.Ptr
    dwFlags : UInt32
    pDrvOptItems : OPTITEM.Ptr
    cDrvOptItems : UInt32
    pOEMOptItems : OPTITEM.Ptr
    cOEMOptItems : UInt32
    pOEMUserData : Struct.Ptr
    OEMCUIPCallback : OEMCUIPCALLBACK
}
struct OEMUIPSPARAM {
    cbSize : UInt32 := this.Size
    poemuiobj : OEMUIOBJ.Ptr
    hPrinter : HANDLE
    pPrinterName : PWSTR
    hModule : HANDLE
    hOEMHeap : HANDLE
    pPublicDM : DEVMODEA.Ptr
    pOEMDM : Struct.Ptr
    pOEMUserData : Struct.Ptr
    dwFlags : UInt32
    pOemEntry : Struct.Ptr
}
struct EATTRIBUTE_DATATYPE extends Int32 {
    static kADT_UNKNOWN := 0
    static kADT_BOOL := 1
    static kADT_INT := 2
    static kADT_LONG := 3
    static kADT_DWORD := 4
    static kADT_ASCII := 5
    static kADT_UNICODE := 6
    static kADT_BINARY := 7
    static kADT_SIZE := 8
    static kADT_RECT := 9
    static kADT_CUSTOMSIZEPARAMS := 10
}
struct CUSTOMSIZEPARAM {
    dwOrder : Int32
    lMinVal : Int32
    lMaxVal : Int32
}
struct PRINT_FEATURE_OPTION {
    pszFeature : PSTR
    pszOption : PSTR
}
struct IPrintCoreHelper extends IUnknown {
    static IID := "{A89EC53E-3905-49C6-9C1A-C0A88117FDB6}"
    GetOption(pDevmode?, pszFeatureRequested, ppszOption)
      => ComCall(3, this.p, DEVMODEA.Ptr, pDevmode?, UInt32, pDevmode?.Size ?? 0, PSTR, pszFeatureRequested, PSTR.Ptr, ppszOption)
    SetOptions(pDevmode, cbSize, bResolveConflicts, pFOPairs, cPairs, pcPairsWritten, pdwResult)
      => ComCall(4, this.p, DEVMODEA.Ptr, pDevmode, UInt32, cbSize, BOOL, bResolveConflicts, PRINT_FEATURE_OPTION.Ptr, pFOPairs, UInt32, cPairs, UInt32.Ptr, pcPairsWritten, UInt32.Ptr, pdwResult)
    EnumConstrainedOptions(pDevmode, cbSize, pszFeatureKeyword, pConstrainedOptionList, pdwNumOptions)
      => ComCall(5, this.p, DEVMODEA.Ptr, pDevmode, UInt32, cbSize, PSTR, pszFeatureKeyword, PSTR.Ptr.Ptr.Ptr, pConstrainedOptionList, UInt32.Ptr, pdwNumOptions)
    WhyConstrained(pDevmode?, pszFeatureKeyword, pszOptionKeyword, ppFOConstraints, pdwNumOptions)
      => ComCall(6, this.p, DEVMODEA.Ptr, pDevmode?, UInt32, pDevmode?.Size ?? 0, PSTR, pszFeatureKeyword, PSTR, pszOptionKeyword, PRINT_FEATURE_OPTION.Ptr.Ptr, ppFOConstraints, UInt32.Ptr, pdwNumOptions)
    EnumFeatures(pFeatureList, pdwNumFeatures)
      => ComCall(7, this.p, PSTR.Ptr.Ptr.Ptr, pFeatureList, UInt32.Ptr, pdwNumFeatures)
    EnumOptions(pszFeatureKeyword, pOptionList, pdwNumOptions)
      => ComCall(8, this.p, PSTR, pszFeatureKeyword, PSTR.Ptr.Ptr.Ptr, pOptionList, UInt32.Ptr, pdwNumOptions)
    GetFontSubstitution(pszTrueTypeFontName, ppszDevFontName)
      => ComCall(9, this.p, "Str", pszTrueTypeFontName, PWSTR.Ptr, ppszDevFontName)
    SetFontSubstitution(pszTrueTypeFontName, pszDevFontName)
      => ComCall(10, this.p, "Str", pszTrueTypeFontName, "Str", pszDevFontName)
    CreateInstanceOfMSXMLObject(rclsid, pUnkOuter, dwClsContext, riid, ppv)
      => ComCall(11, this.p, GUID.Ptr, rclsid, IUnknown, pUnkOuter, UInt32, dwClsContext, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IPrintCoreHelperUni extends IPrintCoreHelper {
    static IID := "{7E8E51D6-E5EE-4426-817B-958B9444EB79}"
    CreateGDLSnapshot(pDevmode, cbSize, dwFlags, ppSnapshotStream)
      => ComCall(12, this.p, DEVMODEA.Ptr, pDevmode, UInt32, cbSize, UInt32, dwFlags, IStream.Ptr, ppSnapshotStream)
    CreateDefaultGDLSnapshot(dwFlags, ppSnapshotStream)
      => ComCall(13, this.p, UInt32, dwFlags, IStream.Ptr, ppSnapshotStream)
}
struct IPrintCoreHelperUni2 extends IPrintCoreHelperUni {
    static IID := "{6C8AFDFC-EAD0-4D2D-8071-9BF0175A6C3A}"
    GetNamedCommand(pDevmode?, pszCommandName, ppCommandBytes, pcbCommandSize)
      => ComCall(14, this.p, DEVMODEA.Ptr, pDevmode?, UInt32, pDevmode?.Size ?? 0, "Str", pszCommandName, UInt8.Ptr.Ptr, ppCommandBytes, UInt32.Ptr, pcbCommandSize)
}
struct IPrintCoreHelperPS extends IPrintCoreHelper {
    static IID := "{C2C14F6F-95D3-4D63-96CF-6BD9E6C907C2}"
    GetGlobalAttribute(pszAttribute, pdwDataType, ppbData, pcbSize)
      => ComCall(12, this.p, PSTR, pszAttribute, UInt32.Ptr, pdwDataType, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbSize)
    GetFeatureAttribute(pszFeatureKeyword, pszAttribute, pdwDataType, ppbData, pcbSize)
      => ComCall(13, this.p, PSTR, pszFeatureKeyword, PSTR, pszAttribute, UInt32.Ptr, pdwDataType, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbSize)
    GetOptionAttribute(pszFeatureKeyword, pszOptionKeyword, pszAttribute?, pdwDataType, ppbData, pcbSize)
      => ComCall(14, this.p, PSTR, pszFeatureKeyword, PSTR, pszOptionKeyword, PSTR, pszAttribute?, UInt32.Ptr, pdwDataType, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbSize)
}
struct IPrintOemCommon extends IUnknown {
    static IID := "{7F42285E-91D5-11D1-8820-00C04FB961EC}"
    GetInfo(dwMode, pBuffer, pcbNeeded)
      => ComCall(3, this.p, UInt32, dwMode, Struct.Ptr, pBuffer, UInt32, pBuffer.Size, UInt32.Ptr, pcbNeeded)
    DevMode(dwMode, pOemDMParam)
      => ComCall(4, this.p, UInt32, dwMode, OEMDMPARAM.Ptr, pOemDMParam)
}
struct IPrintOemUI extends IPrintOemCommon {
    static IID := "{C6A7A9D0-774C-11D1-947F-00A0C90640B8}"
    PublishDriverInterface(pIUnknown)
      => ComCall(5, this.p, IUnknown, pIUnknown)
    CommonUIProp(dwMode, pOemCUIPParam)
      => ComCall(6, this.p, UInt32, dwMode, OEMCUIPPARAM.Ptr, pOemCUIPParam)
    DocumentPropertySheets(pPSUIInfo, lParam1)
      => ComCall(7, this.p, PROPSHEETUI_INFO.Ptr, pPSUIInfo, LPARAM, lParam1)
    DevicePropertySheets(pPSUIInfo, lParam1)
      => ComCall(8, this.p, PROPSHEETUI_INFO.Ptr, pPSUIInfo, LPARAM, lParam1)
    DevQueryPrintEx(poemuiobj, pDQPInfo, pPublicDM, pOEMDM)
      => ComCall(9, this.p, OEMUIOBJ.Ptr, poemuiobj, DEVQUERYPRINT_INFO.Ptr, pDQPInfo, DEVMODEA.Ptr, pPublicDM, Struct.Ptr, pOEMDM)
    DeviceCapabilitiesA(poemuiobj, hPrinter, pDeviceName, wCapability, pOutput, pPublicDM, pOEMDM, dwOld, dwResult)
      => ComCall(10, this.p, OEMUIOBJ.Ptr, poemuiobj, HANDLE, hPrinter, "Str", pDeviceName, UInt16, wCapability, Struct.Ptr, pOutput, DEVMODEA.Ptr, pPublicDM, Struct.Ptr, pOEMDM, UInt32, dwOld, UInt32.Ptr, dwResult)
    UpgradePrinter(dwLevel, pDriverUpgradeInfo)
      => ComCall(11, this.p, UInt32, dwLevel, UInt8.Ptr, pDriverUpgradeInfo)
    PrinterEvent(pPrinterName, iDriverEvent, dwFlags, lParam1)
      => ComCall(12, this.p, "Str", pPrinterName, Int32, iDriverEvent, UInt32, dwFlags, LPARAM, lParam1)
    DriverEvent(dwDriverEvent, dwLevel, pDriverInfo, lParam1)
      => ComCall(13, this.p, UInt32, dwDriverEvent, UInt32, dwLevel, UInt8.Ptr, pDriverInfo, LPARAM, lParam1)
    QueryColorProfile(hPrinter, poemuiobj, pPublicDM, pOEMDM, ulQueryMode, pvProfileData, pflProfileData)
      => ComCall(14, this.p, PRINTER_HANDLE, hPrinter, OEMUIOBJ.Ptr, poemuiobj, DEVMODEA.Ptr, pPublicDM, Struct.Ptr, pOEMDM, UInt32, ulQueryMode, Struct.Ptr, pvProfileData, UInt32.Ptr, pvProfileData.Length, UInt32.Ptr, pflProfileData)
    FontInstallerDlgProc(hWnd1, usMsg, wParam1, lParam1)
      => ComCall(15, this.p, HWND, hWnd1, UInt32, usMsg, WPARAM, wParam1, LPARAM, lParam1)
    UpdateExternalFonts(hPrinter, hHeap, pwstrCartridges)
      => ComCall(16, this.p, PRINTER_HANDLE, hPrinter, HANDLE, hHeap, "Str", pwstrCartridges)
}
struct IPrintOemUI2 extends IPrintOemUI {
    static IID := "{292515F9-B54B-489B-9275-BAB56821395E}"
    QueryJobAttributes(hPrinter, pDevmode, dwLevel, lpAttributeInfo)
      => ComCall(17, this.p, PRINTER_HANDLE, hPrinter, DEVMODEA.Ptr, pDevmode, UInt32, dwLevel, UInt8.Ptr, lpAttributeInfo)
    HideStandardUI(dwMode)
      => ComCall(18, this.p, UInt32, dwMode)
    DocumentEvent(hPrinter, hdc1, iEsc, cbIn, pvIn, cbOut, pvOut, piResult)
      => ComCall(19, this.p, PRINTER_HANDLE, hPrinter, HDC, hdc1, Int32, iEsc, UInt32, cbIn, Struct.Ptr, pvIn, UInt32, cbOut, Struct.Ptr, pvOut, Int32.Ptr, piResult)
}
struct IPrintOemUIMXDC extends IUnknown {
    static IID := "{7349D725-E2C1-4DCA-AFB5-C13E91BC9306}"
    AdjustImageableArea(hPrinter, cbDevMode, pDevMode, cbOEMDM, pOEMDM, prclImageableArea)
      => ComCall(3, this.p, PRINTER_HANDLE, hPrinter, UInt32, cbDevMode, DEVMODEA.Ptr, pDevMode, UInt32, cbOEMDM, Struct.Ptr, pOEMDM, RECTL.Ptr, prclImageableArea)
    AdjustImageCompression(hPrinter, cbDevMode, pDevMode, cbOEMDM, pOEMDM, pCompressionMode)
      => ComCall(4, this.p, PRINTER_HANDLE, hPrinter, UInt32, cbDevMode, DEVMODEA.Ptr, pDevMode, UInt32, cbOEMDM, Struct.Ptr, pOEMDM, Int32.Ptr, pCompressionMode)
    AdjustDPI(hPrinter, cbDevMode, pDevMode, cbOEMDM, pOEMDM, pDPI)
      => ComCall(5, this.p, PRINTER_HANDLE, hPrinter, UInt32, cbDevMode, DEVMODEA.Ptr, pDevMode, UInt32, cbOEMDM, Struct.Ptr, pOEMDM, Int32.Ptr, pDPI)
}
struct IPrintOemDriverUI extends IUnknown {
    static IID := "{92B05D50-78BC-11D1-9480-00A0C90640B8}"
    DrvGetDriverSetting(pci, Feature, pOutput, cbSize, pcbNeeded, pdwOptionsReturned)
      => ComCall(3, this.p, Struct.Ptr, pci, PSTR, Feature, Struct.Ptr, pOutput, UInt32, cbSize, UInt32.Ptr, pcbNeeded, UInt32.Ptr, pdwOptionsReturned)
    DrvUpgradeRegistrySetting(hPrinter, pFeature, pOption)
      => ComCall(4, this.p, HANDLE, hPrinter, PSTR, pFeature, PSTR, pOption)
    DrvUpdateUISetting(pci, pOptItem, dwPreviousSelection, dwMode)
      => ComCall(5, this.p, Struct.Ptr, pci, Struct.Ptr, pOptItem, UInt32, dwPreviousSelection, UInt32, dwMode)
}
struct IPrintCoreUI2 extends IPrintOemDriverUI {
    static IID := "{085CCFCA-3ADF-4C9E-B491-D851A6EDC997}"
    GetOptions(poemuiobj, pmszFeaturesRequested?, pmszFeatureOptionBuf?, pcbNeeded)
      => ComCall(6, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, Int8.Ptr, pmszFeaturesRequested?, UInt32, pmszFeaturesRequested?.Size ?? 0, PSTR, pmszFeatureOptionBuf?, UInt32, pmszFeatureOptionBuf?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    SetOptions(poemuiobj, dwFlags, pmszFeatureOptionBuf, pdwResult)
      => ComCall(7, this.p, OEMUIOBJ.Ptr, poemuiobj, UInt32, dwFlags, Int8.Ptr, pmszFeatureOptionBuf, UInt32, pmszFeatureOptionBuf.Size, UInt32.Ptr, pdwResult)
    EnumConstrainedOptions(poemuiobj, pszFeatureKeyword, pmszConstrainedOptionList?, pcbNeeded)
      => ComCall(8, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszFeatureKeyword, PSTR, pmszConstrainedOptionList?, UInt32, pmszConstrainedOptionList?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    WhyConstrained(poemuiobj, pszFeatureKeyword, pszOptionKeyword, pmszReasonList?, pcbNeeded)
      => ComCall(9, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszFeatureKeyword, PSTR, pszOptionKeyword, PSTR, pmszReasonList?, UInt32, pmszReasonList?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    GetGlobalAttribute(poemuiobj, pszAttribute?, pdwDataType, pbData?, pcbNeeded)
      => ComCall(10, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszAttribute?, UInt32.Ptr, pdwDataType, UInt8.Ptr, pbData?, UInt32, pbData?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    GetFeatureAttribute(poemuiobj, pszFeatureKeyword, pszAttribute?, pdwDataType, pbData?, pcbNeeded)
      => ComCall(11, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszFeatureKeyword, PSTR, pszAttribute?, UInt32.Ptr, pdwDataType, UInt8.Ptr, pbData?, UInt32, pbData?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    GetOptionAttribute(poemuiobj, pszFeatureKeyword, pszOptionKeyword, pszAttribute?, pdwDataType, pbData?, pcbNeeded)
      => ComCall(12, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszFeatureKeyword, PSTR, pszOptionKeyword, PSTR, pszAttribute?, UInt32.Ptr, pdwDataType, UInt8.Ptr, pbData?, UInt32, pbData?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    EnumFeatures(poemuiobj, pmszFeatureList?, pcbNeeded)
      => ComCall(13, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pmszFeatureList?, UInt32, pmszFeatureList?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    EnumOptions(poemuiobj, pszFeatureKeyword, pmszOptionList?, pcbNeeded)
      => ComCall(14, this.p, OEMUIOBJ.Ptr, poemuiobj, "Ptr", 0, PSTR, pszFeatureKeyword, PSTR, pmszOptionList?, UInt32, pmszOptionList?.Size ?? 0, UInt32.Ptr, pcbNeeded)
    QuerySimulationSupport(hPrinter, dwLevel, pCaps?, pcbNeeded)
      => ComCall(15, this.p, HANDLE, hPrinter, UInt32, dwLevel, UInt8.Ptr, pCaps?, UInt32, pCaps?.Size ?? 0, UInt32.Ptr, pcbNeeded)
}
struct SHIMOPTS extends Int32 {
    static PTSHIM_DEFAULT := 0
    static PTSHIM_NOSNAPSHOT := 1
}
struct IPrintTicketProvider extends IUnknown {
    static IID := "{BB5116DB-0A23-4C3A-A6B6-89E5558DFB5D}"
    GetSupportedVersions(hPrinter, ppVersions, cVersions)
      => ComCall(3, this.p, PRINTER_HANDLE, hPrinter, Int32.Ptr.Ptr, ppVersions, Int32.Ptr, cVersions)
    BindPrinter(hPrinter, version, pOptions, pDevModeFlags, cNamespaces, ppNamespaces)
      => ComCall(4, this.p, PRINTER_HANDLE, hPrinter, Int32, version, SHIMOPTS.Ptr, pOptions, UInt32.Ptr, pDevModeFlags, Int32.Ptr, cNamespaces, BSTR.Ptr.Ptr, ppNamespaces)
    QueryDeviceNamespace(pDefaultNamespace)
      => ComCall(5, this.p, BSTR.Ptr, pDefaultNamespace)
    ConvertPrintTicketToDevMode(pPrintTicket, cbDevmodeIn, pDevmodeIn, pcbDevmodeOut, ppDevmodeOut)
      => ComCall(6, this.p, IXMLDOMDocument2, pPrintTicket, UInt32, cbDevmodeIn, DEVMODEA.Ptr, pDevmodeIn, UInt32.Ptr, pcbDevmodeOut, DEVMODEA.Ptr.Ptr, ppDevmodeOut)
    ConvertDevModeToPrintTicket(cbDevmode, pDevmode, pPrintTicket)
      => ComCall(7, this.p, UInt32, cbDevmode, DEVMODEA.Ptr, pDevmode, IXMLDOMDocument2, pPrintTicket)
    GetPrintCapabilities(pPrintTicket, ppCapabilities)
      => ComCall(8, this.p, IXMLDOMDocument2, pPrintTicket, IXMLDOMDocument2.Ptr, ppCapabilities)
    ValidatePrintTicket(pBaseTicket)
      => ComCall(9, this.p, IXMLDOMDocument2, pBaseTicket)
}
struct IPrintTicketProvider2 extends IPrintTicketProvider {
    static IID := "{B8A70AB2-3DFC-4FEC-A074-511B13C651CB}"
    GetPrintDeviceCapabilities(pPrintTicket, ppDeviceCapabilities)
      => ComCall(10, this.p, IXMLDOMDocument2, pPrintTicket, IXMLDOMDocument2.Ptr, ppDeviceCapabilities)
    GetPrintDeviceResources(pszLocaleName, pPrintTicket, ppDeviceResources)
      => ComCall(11, this.p, "Str", pszLocaleName, IXMLDOMDocument2, pPrintTicket, IXMLDOMDocument2.Ptr, ppDeviceResources)
}
struct IPrintSchemaElement extends IDispatch {
    static IID := "{724C1646-E64B-4BBF-8EB4-D45E4FD580DA}"
    get_XmlNode(ppXmlNode)
      => ComCall(7, this.p, IUnknown.Ptr, ppXmlNode)
    get_Name(pbstrName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrName)
    get_NamespaceUri(pbstrNamespaceUri)
      => ComCall(9, this.p, BSTR.Ptr, pbstrNamespaceUri)
}
struct IPrintSchemaDisplayableElement extends IPrintSchemaElement {
    static IID := "{AF45AF49-D6AA-407D-BF87-3912236E9D94}"
    get_DisplayName(pbstrDisplayName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrDisplayName)
}
struct PrintSchemaConstrainedSetting extends Int32 {
    static PrintSchemaConstrainedSetting_None := 0
    static PrintSchemaConstrainedSetting_PrintTicket := 1
    static PrintSchemaConstrainedSetting_Admin := 2
    static PrintSchemaConstrainedSetting_Device := 3
}
struct IPrintSchemaOption extends IPrintSchemaDisplayableElement {
    static IID := "{66BB2F51-5844-4997-8D70-4B7CC221CF92}"
    get_Selected(pbIsSelected)
      => ComCall(11, this.p, BOOL.Ptr, pbIsSelected)
    get_Constrained(pSetting)
      => ComCall(12, this.p, PrintSchemaConstrainedSetting.Ptr, pSetting)
    GetPropertyValue(bstrName, bstrNamespaceUri, ppXmlValueNode)
      => ComCall(13, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IUnknown.Ptr, ppXmlValueNode)
}
struct IPrintSchemaPageMediaSizeOption extends IPrintSchemaOption {
    static IID := "{68746729-F493-4830-A10F-69028774605D}"
    get_WidthInMicrons(pulWidth)
      => ComCall(14, this.p, UInt32.Ptr, pulWidth)
    get_HeightInMicrons(pulHeight)
      => ComCall(15, this.p, UInt32.Ptr, pulHeight)
}
struct IPrintSchemaNUpOption extends IPrintSchemaOption {
    static IID := "{1F6342F2-D848-42E3-8995-C10A9EF9A3BA}"
    get_PagesPerSheet(pulPagesPerSheet)
      => ComCall(14, this.p, UInt32.Ptr, pulPagesPerSheet)
}
struct PrintSchemaSelectionType extends Int32 {
    static PrintSchemaSelectionType_PickOne := 0
    static PrintSchemaSelectionType_PickMany := 1
}
struct IPrintSchemaOptionCollection extends IDispatch {
    static IID := "{BAECB0BD-A946-4771-BC30-E8B24F8D45C1}"
    get_Count(pulCount)
      => ComCall(7, this.p, UInt32.Ptr, pulCount)
    GetAt(ulIndex, ppOption)
      => ComCall(8, this.p, UInt32, ulIndex, IPrintSchemaOption.Ptr, ppOption)
    get__NewEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
}
struct IPrintSchemaFeature extends IPrintSchemaDisplayableElement {
    static IID := "{EF189461-5D62-4626-8E57-FF83583C4826}"
    get_SelectedOption(ppOption)
      => ComCall(11, this.p, IPrintSchemaOption.Ptr, ppOption)
    put_SelectedOption(pOption)
      => ComCall(12, this.p, IPrintSchemaOption, pOption)
    get_SelectionType(pSelectionType)
      => ComCall(13, this.p, PrintSchemaSelectionType.Ptr, pSelectionType)
    GetOption(bstrName, bstrNamespaceUri, ppOption)
      => ComCall(14, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IPrintSchemaOption.Ptr, ppOption)
    get_DisplayUI(pbShow)
      => ComCall(15, this.p, BOOL.Ptr, pbShow)
}
struct IPrintSchemaPageImageableSize extends IPrintSchemaElement {
    static IID := "{7C85BF5E-DC7C-4F61-839B-4107E1C9B68E}"
    get_ImageableSizeWidthInMicrons(pulImageableSizeWidth)
      => ComCall(10, this.p, UInt32.Ptr, pulImageableSizeWidth)
    get_ImageableSizeHeightInMicrons(pulImageableSizeHeight)
      => ComCall(11, this.p, UInt32.Ptr, pulImageableSizeHeight)
    get_OriginWidthInMicrons(pulOriginWidth)
      => ComCall(12, this.p, UInt32.Ptr, pulOriginWidth)
    get_OriginHeightInMicrons(pulOriginHeight)
      => ComCall(13, this.p, UInt32.Ptr, pulOriginHeight)
    get_ExtentWidthInMicrons(pulExtentWidth)
      => ComCall(14, this.p, UInt32.Ptr, pulExtentWidth)
    get_ExtentHeightInMicrons(pulExtentHeight)
      => ComCall(15, this.p, UInt32.Ptr, pulExtentHeight)
}
struct PrintSchemaParameterDataType extends Int32 {
    static PrintSchemaParameterDataType_Integer := 0
    static PrintSchemaParameterDataType_NumericString := 1
    static PrintSchemaParameterDataType_String := 2
}
struct IPrintSchemaParameterDefinition extends IPrintSchemaDisplayableElement {
    static IID := "{B5ADE81E-0E61-4FE1-81C6-C333E4FFE0F1}"
    get_UserInputRequired(pbIsRequired)
      => ComCall(11, this.p, BOOL.Ptr, pbIsRequired)
    get_UnitType(pbstrUnitType)
      => ComCall(12, this.p, BSTR.Ptr, pbstrUnitType)
    get_DataType(pDataType)
      => ComCall(13, this.p, PrintSchemaParameterDataType.Ptr, pDataType)
    get_RangeMin(pRangeMin)
      => ComCall(14, this.p, Int32.Ptr, pRangeMin)
    get_RangeMax(pRangeMax)
      => ComCall(15, this.p, Int32.Ptr, pRangeMax)
}
struct IPrintSchemaParameterInitializer extends IPrintSchemaElement {
    static IID := "{52027082-0B74-4648-9564-828CC6CB656C}"
    get_Value(pVar)
      => ComCall(10, this.p, VARIANT.Ptr, pVar)
    put_Value(pVar)
      => ComCall(11, this.p, VARIANT.Ptr, pVar)
}
struct IPrintSchemaCapabilities extends IPrintSchemaElement {
    static IID := "{5A577640-501D-4927-BCD0-5EF57A7ED175}"
    GetFeatureByKeyName(bstrKeyName, ppFeature)
      => ComCall(10, this.p, BSTR, bstrKeyName, IPrintSchemaFeature.Ptr, ppFeature)
    GetFeature(bstrName, bstrNamespaceUri, ppFeature)
      => ComCall(11, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IPrintSchemaFeature.Ptr, ppFeature)
    get_PageImageableSize(ppPageImageableSize)
      => ComCall(12, this.p, IPrintSchemaPageImageableSize.Ptr, ppPageImageableSize)
    get_JobCopiesAllDocumentsMinValue(pulJobCopiesAllDocumentsMinValue)
      => ComCall(13, this.p, UInt32.Ptr, pulJobCopiesAllDocumentsMinValue)
    get_JobCopiesAllDocumentsMaxValue(pulJobCopiesAllDocumentsMaxValue)
      => ComCall(14, this.p, UInt32.Ptr, pulJobCopiesAllDocumentsMaxValue)
    GetSelectedOptionInPrintTicket(pFeature, ppOption)
      => ComCall(15, this.p, IPrintSchemaFeature, pFeature, IPrintSchemaOption.Ptr, ppOption)
    GetOptions(pFeature, ppOptionCollection)
      => ComCall(16, this.p, IPrintSchemaFeature, pFeature, IPrintSchemaOptionCollection.Ptr, ppOptionCollection)
}
struct IPrintSchemaCapabilities2 extends IPrintSchemaCapabilities {
    static IID := "{B58845F4-9970-4D87-A636-169FB82ED642}"
    GetParameterDefinition(bstrName, bstrNamespaceUri, ppParameterDefinition)
      => ComCall(17, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IPrintSchemaParameterDefinition.Ptr, ppParameterDefinition)
}
struct IPrintSchemaAsyncOperation extends IDispatch {
    static IID := "{143C8DCB-D37F-47F7-88E8-6B1D21F2C5F7}"
    Start()
      => ComCall(7, this.p)
    Cancel()
      => ComCall(8, this.p)
}
struct IPrintSchemaTicket extends IPrintSchemaElement {
    static IID := "{E480B861-4708-4E6D-A5B4-A2B4EEB9BAA4}"
    GetFeatureByKeyName(bstrKeyName, ppFeature)
      => ComCall(10, this.p, BSTR, bstrKeyName, IPrintSchemaFeature.Ptr, ppFeature)
    GetFeature(bstrName, bstrNamespaceUri, ppFeature)
      => ComCall(11, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IPrintSchemaFeature.Ptr, ppFeature)
    ValidateAsync(ppAsyncOperation)
      => ComCall(12, this.p, IPrintSchemaAsyncOperation.Ptr, ppAsyncOperation)
    CommitAsync(pPrintTicketCommit, ppAsyncOperation)
      => ComCall(13, this.p, IPrintSchemaTicket, pPrintTicketCommit, IPrintSchemaAsyncOperation.Ptr, ppAsyncOperation)
    NotifyXmlChanged()
      => ComCall(14, this.p)
    GetCapabilities(ppCapabilities)
      => ComCall(15, this.p, IPrintSchemaCapabilities.Ptr, ppCapabilities)
    get_JobCopiesAllDocuments(pulJobCopiesAllDocuments)
      => ComCall(16, this.p, UInt32.Ptr, pulJobCopiesAllDocuments)
    put_JobCopiesAllDocuments(ulJobCopiesAllDocuments)
      => ComCall(17, this.p, UInt32, ulJobCopiesAllDocuments)
}
struct IPrintSchemaTicket2 extends IPrintSchemaTicket {
    static IID := "{2EC1F844-766A-47A1-91F4-2EEB6190F80C}"
    GetParameterInitializer(bstrName, bstrNamespaceUri, ppParameterInitializer)
      => ComCall(18, this.p, BSTR, bstrName, BSTR, bstrNamespaceUri, IPrintSchemaParameterInitializer.Ptr, ppParameterInitializer)
}
struct IPrintSchemaAsyncOperationEvent extends IDispatch {
    static IID := "{23ADBB16-0133-4906-B29A-1DCE1D026379}"
    Completed(pTicket, hrOperation)
      => ComCall(7, this.p, IPrintSchemaTicket, pTicket, HRESULT, hrOperation)
}
struct IPrinterScriptableSequentialStream extends IDispatch {
    static IID := "{2072838A-316F-467A-A949-27F68C44A854}"
    Read(cbRead, ppArray)
      => ComCall(7, this.p, Int32, cbRead, IDispatch.Ptr, ppArray)
    Write(pArray, pcbWritten)
      => ComCall(8, this.p, IDispatch, pArray, Int32.Ptr, pcbWritten)
}
struct IPrinterScriptableStream extends IPrinterScriptableSequentialStream {
    static IID := "{7EDF9A92-4750-41A5-A17F-879A6F4F7DCB}"
    Commit()
      => ComCall(9, this.p)
    Seek(lOffset, streamSeek, plPosition)
      => ComCall(10, this.p, Int32, lOffset, STREAM_SEEK, streamSeek, Int32.Ptr, plPosition)
    SetSize(lSize)
      => ComCall(11, this.p, Int32, lSize)
}
struct IPrinterPropertyBag extends IDispatch {
    static IID := "{FEA77364-DF95-4A23-A905-019B79A8E481}"
    GetBool(bstrName, pbValue)
      => ComCall(7, this.p, BSTR, bstrName, BOOL.Ptr, pbValue)
    SetBool(bstrName, bValue)
      => ComCall(8, this.p, BSTR, bstrName, BOOL, bValue)
    GetInt32(bstrName, pnValue)
      => ComCall(9, this.p, BSTR, bstrName, Int32.Ptr, pnValue)
    SetInt32(bstrName, nValue)
      => ComCall(10, this.p, BSTR, bstrName, Int32, nValue)
    GetString(bstrName, pbstrValue)
      => ComCall(11, this.p, BSTR, bstrName, BSTR.Ptr, pbstrValue)
    SetString(bstrName, bstrValue)
      => ComCall(12, this.p, BSTR, bstrName, BSTR, bstrValue)
    GetBytes(bstrName, ppValue)
      => ComCall(13, this.p, BSTR, bstrName, UInt32.Ptr, ppValue.Length, UInt8.Ptr.Ptr, ppValue)
    SetBytes(bstrName, pValue)
      => ComCall(14, this.p, BSTR, bstrName, UInt32, pValue.Length, UInt8.Ptr, pValue)
    GetReadStream(bstrName, ppValue)
      => ComCall(15, this.p, BSTR, bstrName, IStream.Ptr, ppValue)
    GetWriteStream(bstrName, ppValue)
      => ComCall(16, this.p, BSTR, bstrName, IStream.Ptr, ppValue)
}
struct IPrinterScriptablePropertyBag extends IDispatch {
    static IID := "{91C7765F-ED57-49AD-8B01-DC24816A5294}"
    GetBool(bstrName, pbValue)
      => ComCall(7, this.p, BSTR, bstrName, BOOL.Ptr, pbValue)
    SetBool(bstrName, bValue)
      => ComCall(8, this.p, BSTR, bstrName, BOOL, bValue)
    GetInt32(bstrName, pnValue)
      => ComCall(9, this.p, BSTR, bstrName, Int32.Ptr, pnValue)
    SetInt32(bstrName, nValue)
      => ComCall(10, this.p, BSTR, bstrName, Int32, nValue)
    GetString(bstrName, pbstrValue)
      => ComCall(11, this.p, BSTR, bstrName, BSTR.Ptr, pbstrValue)
    SetString(bstrName, bstrValue)
      => ComCall(12, this.p, BSTR, bstrName, BSTR, bstrValue)
    GetBytes(bstrName, ppArray)
      => ComCall(13, this.p, BSTR, bstrName, IDispatch.Ptr, ppArray)
    SetBytes(bstrName, pArray)
      => ComCall(14, this.p, BSTR, bstrName, IDispatch, pArray)
    GetReadStream(bstrName, ppStream)
      => ComCall(15, this.p, BSTR, bstrName, IPrinterScriptableStream.Ptr, ppStream)
    GetWriteStream(bstrName, ppStream)
      => ComCall(16, this.p, BSTR, bstrName, IPrinterScriptableStream.Ptr, ppStream)
}
struct IPrinterScriptablePropertyBag2 extends IPrinterScriptablePropertyBag {
    static IID := "{2A1C53C4-8638-4B3E-B518-2773C94556A3}"
    GetReadStreamAsXML(bstrName, ppXmlNode)
      => ComCall(17, this.p, BSTR, bstrName, IUnknown.Ptr, ppXmlNode)
}
struct IPrinterQueue extends IDispatch {
    static IID := "{3580A828-07FE-4B94-AC1A-757D9D2D3056}"
    get_Handle(phPrinter)
      => ComCall(7, this.p, PRINTER_HANDLE.Ptr, phPrinter)
    get_Name(pbstrName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrName)
    SendBidiQuery(bstrBidiQuery)
      => ComCall(9, this.p, BSTR, bstrBidiQuery)
    GetProperties(ppPropertyBag)
      => ComCall(10, this.p, IPrinterPropertyBag.Ptr, ppPropertyBag)
}
struct PrintJobStatus extends Int32 {
    static PrintJobStatus_Paused := 1
    static PrintJobStatus_Error := 2
    static PrintJobStatus_Deleting := 4
    static PrintJobStatus_Spooling := 8
    static PrintJobStatus_Printing := 16
    static PrintJobStatus_Offline := 32
    static PrintJobStatus_PaperOut := 64
    static PrintJobStatus_Printed := 128
    static PrintJobStatus_Deleted := 256
    static PrintJobStatus_BlockedDeviceQueue := 512
    static PrintJobStatus_UserIntervention := 1024
    static PrintJobStatus_Restarted := 2048
    static PrintJobStatus_Complete := 4096
    static PrintJobStatus_Retained := 8192
}
struct IPrintJob extends IUnknown {
    static IID := "{B771DAB8-1282-41B7-858C-F206E4D20577}"
    get_Name(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
    get_Id(pulID)
      => ComCall(4, this.p, UInt32.Ptr, pulID)
    get_PrintedPages(pulPages)
      => ComCall(5, this.p, UInt32.Ptr, pulPages)
    get_TotalPages(pulPages)
      => ComCall(6, this.p, UInt32.Ptr, pulPages)
    get_Status(pStatus)
      => ComCall(7, this.p, PrintJobStatus.Ptr, pStatus)
    get_SubmissionTime(pSubmissionTime)
      => ComCall(8, this.p, Float64.Ptr, pSubmissionTime)
    RequestCancel()
      => ComCall(9, this.p)
}
struct IPrintJobCollection extends IDispatch {
    static IID := "{72B82A24-A598-4E87-895F-CDB23A49E9DC}"
    get_Count(pulCount)
      => ComCall(7, this.p, UInt32.Ptr, pulCount)
    GetAt(ulIndex, ppJob)
      => ComCall(8, this.p, UInt32, ulIndex, IPrintJob.Ptr, ppJob)
    get__NewEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
}
struct IPrinterQueueViewEvent extends IDispatch {
    static IID := "{C5B6042B-FD21-404A-A0EF-E2FBB52B9080}"
    OnChanged(pCollection, ulViewOffset, ulViewSize, ulCountJobsInPrintQueue)
      => ComCall(7, this.p, IPrintJobCollection, pCollection, UInt32, ulViewOffset, UInt32, ulViewSize, UInt32, ulCountJobsInPrintQueue)
}
struct IPrinterQueueView extends IDispatch {
    static IID := "{476E2969-3B2B-4B3F-8277-CFF6056042AA}"
    SetViewRange(ulViewOffset, ulViewSize)
      => ComCall(7, this.p, UInt32, ulViewOffset, UInt32, ulViewSize)
}
struct IPrinterQueueEvent extends IDispatch {
    static IID := "{214685F6-7B78-4681-87E0-495F739273D1}"
    OnBidiResponseReceived(bstrResponse, hrStatus)
      => ComCall(7, this.p, BSTR, bstrResponse, HRESULT, hrStatus)
}
struct IPrinterBidiSetRequestCallback extends IUnknown {
    static IID := "{C52D32DD-F2B4-4052-8502-EC4305ECB71F}"
    Completed(bstrResponse, hrStatus)
      => ComCall(3, this.p, BSTR, bstrResponse, HRESULT, hrStatus)
}
struct IPrinterExtensionAsyncOperation extends IUnknown {
    static IID := "{108D6A23-6A4B-4552-9448-68B427186ACD}"
    Cancel()
      => ComCall(3, this.p)
}
struct IPrinterQueue2 extends IPrinterQueue {
    static IID := "{8CD444E8-C9BB-49B3-8E38-E03209416131}"
    SendBidiSetRequestAsync(bstrBidiRequest, pCallback, ppAsyncOperation)
      => ComCall(11, this.p, BSTR, bstrBidiRequest, IPrinterBidiSetRequestCallback, pCallback, IPrinterExtensionAsyncOperation.Ptr, ppAsyncOperation)
    GetPrinterQueueView(ulViewOffset, ulViewSize, ppJobView)
      => ComCall(12, this.p, UInt32, ulViewOffset, UInt32, ulViewSize, IPrinterQueueView.Ptr, ppJobView)
}
struct IPrinterExtensionContext extends IDispatch {
    static IID := "{39843BF2-C4D2-41FD-B4B2-AEDBEE5E1900}"
    get_PrinterQueue(ppQueue)
      => ComCall(7, this.p, IPrinterQueue.Ptr, ppQueue)
    get_PrintSchemaTicket(ppTicket)
      => ComCall(8, this.p, IPrintSchemaTicket.Ptr, ppTicket)
    get_DriverProperties(ppPropertyBag)
      => ComCall(9, this.p, IPrinterPropertyBag.Ptr, ppPropertyBag)
    get_UserProperties(ppPropertyBag)
      => ComCall(10, this.p, IPrinterPropertyBag.Ptr, ppPropertyBag)
}
struct IPrinterExtensionRequest extends IDispatch {
    static IID := "{39843BF3-C4D2-41FD-B4B2-AEDBEE5E1900}"
    Cancel(hrStatus, bstrLogMessage)
      => ComCall(7, this.p, HRESULT, hrStatus, BSTR, bstrLogMessage)
    Complete()
      => ComCall(8, this.p)
}
struct IPrinterExtensionEventArgs extends IPrinterExtensionContext {
    static IID := "{39843BF4-C4D2-41FD-B4B2-AEDBEE5E1900}"
    get_BidiNotification(pbstrBidiNotification)
      => ComCall(11, this.p, BSTR.Ptr, pbstrBidiNotification)
    get_ReasonId(pReasonId)
      => ComCall(12, this.p, GUID.Ptr, pReasonId)
    get_Request(ppRequest)
      => ComCall(13, this.p, IPrinterExtensionRequest.Ptr, ppRequest)
    get_SourceApplication(pbstrApplication)
      => ComCall(14, this.p, BSTR.Ptr, pbstrApplication)
    get_DetailedReasonId(pDetailedReasonId)
      => ComCall(15, this.p, GUID.Ptr, pDetailedReasonId)
    get_WindowModal(pbModal)
      => ComCall(16, this.p, BOOL.Ptr, pbModal)
    get_WindowParent(phwndParent)
      => ComCall(17, this.p, HANDLE.Ptr, phwndParent)
}
struct IPrinterExtensionContextCollection extends IDispatch {
    static IID := "{FB476970-9BAB-4861-811E-3E98B0C5ADDF}"
    get_Count(pulCount)
      => ComCall(7, this.p, UInt32.Ptr, pulCount)
    GetAt(ulIndex, ppContext)
      => ComCall(8, this.p, UInt32, ulIndex, IPrinterExtensionContext.Ptr, ppContext)
    get__NewEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
}
struct IPrinterExtensionEvent extends IDispatch {
    static IID := "{C093CB63-5EF5-4585-AF8E-4D5637487B57}"
    OnDriverEvent(pEventArgs)
      => ComCall(7, this.p, IPrinterExtensionEventArgs, pEventArgs)
    OnPrinterQueuesEnumerated(pContextCollection)
      => ComCall(8, this.p, IPrinterExtensionContextCollection, pContextCollection)
}
struct IPrinterExtensionManager extends IUnknown {
    static IID := "{93C6EB8C-B001-4355-9629-8E8A1B3F8E77}"
    EnableEvents(printerDriverId)
      => ComCall(3, this.p, GUID, printerDriverId)
    DisableEvents()
      => ComCall(4, this.p)
}
struct IPrinterScriptContext extends IDispatch {
    static IID := "{066ACBCA-8881-49C9-BB98-FAE16B4889E1}"
    get_DriverProperties(ppPropertyBag)
      => ComCall(7, this.p, IPrinterScriptablePropertyBag.Ptr, ppPropertyBag)
    get_QueueProperties(ppPropertyBag)
      => ComCall(8, this.p, IPrinterScriptablePropertyBag.Ptr, ppPropertyBag)
    get_UserProperties(ppPropertyBag)
      => ComCall(9, this.p, IPrinterScriptablePropertyBag.Ptr, ppPropertyBag)
}
struct PrintAsyncNotifyUserFilter extends Int32 {
    static kPerUser := 0
    static kAllUsers := 1
}
struct PrintAsyncNotifyConversationStyle extends Int32 {
    static kBiDirectional := 0
    static kUniDirectional := 1
}
struct IPrintAsyncNotifyDataObject extends IUnknown {
    static IID := "{77CF513E-5D49-4789-9F30-D0822B335C0D}"
    AcquireData(ppNotificationData?, pSize?, ppSchema?)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppNotificationData?, UInt32.Ptr, pSize?, GUID.Ptr.Ptr, ppSchema?)
    ReleaseData()
      => ComCall(4, this.p)
}
struct IPrintAsyncNotifyChannel extends IUnknown {
    static IID := "{4A5031B1-1F3F-4DB0-A462-4530ED8B0451}"
    SendNotification(pData)
      => ComCall(3, this.p, IPrintAsyncNotifyDataObject, pData)
    CloseChannel(pData)
      => ComCall(4, this.p, IPrintAsyncNotifyDataObject, pData)
}
struct IPrintAsyncNotifyCallback extends IUnknown {
    static IID := "{7DEF34C1-9D92-4C99-B3B3-DB94A9D4191B}"
    OnEventNotify(pChannel, pData)
      => ComCall(3, this.p, IPrintAsyncNotifyChannel, pChannel, IPrintAsyncNotifyDataObject, pData)
    ChannelClosed(pChannel, pData)
      => ComCall(4, this.p, IPrintAsyncNotifyChannel, pChannel, IPrintAsyncNotifyDataObject, pData)
}
struct PrintAsyncNotifyError extends Int32 {
    static CHANNEL_CLOSED_BY_SERVER := 1
    static CHANNEL_CLOSED_BY_ANOTHER_LISTENER := 2
    static CHANNEL_CLOSED_BY_SAME_LISTENER := 3
    static CHANNEL_RELEASED_BY_LISTENER := 4
    static UNIRECTIONAL_NOTIFICATION_LOST := 5
    static ASYNC_NOTIFICATION_FAILURE := 6
    static NO_LISTENERS := 7
    static CHANNEL_ALREADY_CLOSED := 8
    static CHANNEL_ALREADY_OPENED := 9
    static CHANNEL_WAITING_FOR_CLIENT_NOTIFICATION := 10
    static CHANNEL_NOT_OPENED := 11
    static ASYNC_CALL_ALREADY_PARKED := 12
    static NOT_REGISTERED := 13
    static ALREADY_UNREGISTERED := 14
    static ALREADY_REGISTERED := 15
    static CHANNEL_ACQUIRED := 16
    static ASYNC_CALL_IN_PROGRESS := 17
    static MAX_NOTIFICATION_SIZE_EXCEEDED := 18
    static INTERNAL_NOTIFICATION_QUEUE_IS_FULL := 19
    static INVALID_NOTIFICATION_TYPE := 20
    static MAX_REGISTRATION_COUNT_EXCEEDED := 21
    static MAX_CHANNEL_COUNT_EXCEEDED := 22
    static LOCAL_ONLY_REGISTRATION := 23
    static REMOTE_ONLY_REGISTRATION := 24
}
struct IPrintAsyncNotifyRegistration extends IUnknown {
    static IID := "{0F6F27B6-6F86-4591-9203-64C3BFADEDFE}"
    RegisterForNotifications()
      => ComCall(3, this.p)
    UnregisterForNotifications()
      => ComCall(4, this.p)
}
struct IPrintAsyncNotify extends IUnknown {
    static IID := "{532818F7-921B-4FB2-BFF8-2F4FD52EBEBF}"
    CreatePrintAsyncNotifyChannel(param0, param1, param2, param3, param4, param5)
      => ComCall(3, this.p, UInt32, param0, GUID.Ptr, param1, PrintAsyncNotifyUserFilter, param2, PrintAsyncNotifyConversationStyle, param3, IPrintAsyncNotifyCallback, param4, IPrintAsyncNotifyChannel.Ptr, param5)
    CreatePrintAsyncNotifyRegistration(param0, param1, param2, param3, param4)
      => ComCall(4, this.p, GUID.Ptr, param0, PrintAsyncNotifyUserFilter, param1, PrintAsyncNotifyConversationStyle, param2, IPrintAsyncNotifyCallback, param3, IPrintAsyncNotifyRegistration.Ptr, param4)
}
struct IPrintAsyncCookie extends IUnknown {
    FinishAsyncCall(param0)
      => ComCall(3, this.p, HRESULT, param0)
    CancelAsyncCall(param0)
      => ComCall(4, this.p, HRESULT, param0)
}
struct IPrintAsyncNewChannelCookie extends IPrintAsyncCookie {
    FinishAsyncCallWithData(param0, param1)
      => ComCall(5, this.p, IPrintAsyncNotifyChannel.Ptr, param0, UInt32, param1)
}
struct IAsyncGetSendNotificationCookie extends IPrintAsyncCookie {
    FinishAsyncCallWithData(param0, param1)
      => ComCall(5, this.p, IPrintAsyncNotifyDataObject, param0, BOOL, param1)
}
struct IAsyncGetSrvReferralCookie extends IUnknown {
    FinishAsyncCall(param0)
      => ComCall(3, this.p, HRESULT, param0)
    CancelAsyncCall(param0)
      => ComCall(4, this.p, HRESULT, param0)
    FinishAsyncCallWithData(param0)
      => ComCall(5, this.p, "Str", param0)
}
struct IPrintBidiAsyncNotifyRegistration extends IPrintAsyncNotifyRegistration {
    AsyncGetNewChannel(param0)
      => ComCall(5, this.p, IPrintAsyncNewChannelCookie, param0)
}
struct IPrintUnidiAsyncNotifyRegistration extends IPrintAsyncNotifyRegistration {
    AsyncGetNotification(param0)
      => ComCall(5, this.p, IAsyncGetSendNotificationCookie, param0)
}
struct IPrintAsyncNotifyServerReferral extends IUnknown {
    GetServerReferral(param0)
      => ComCall(3, this.p, PWSTR.Ptr, param0)
    AsyncGetServerReferral(param0)
      => ComCall(4, this.p, IAsyncGetSrvReferralCookie, param0)
    SetServerReferral(pRmtServerReferral)
      => ComCall(5, this.p, "Str", pRmtServerReferral)
}
struct IBidiAsyncNotifyChannel extends IPrintAsyncNotifyChannel {
    static IID := "{532818F7-921B-4FB2-BFF8-2F4FD52EBEBF}"
    CreateNotificationChannel()
      => ComCall(5, this.p)
    GetPrintName(param0)
      => ComCall(6, this.p, IPrintAsyncNotifyDataObject.Ptr, param0)
    GetChannelNotificationType(param0)
      => ComCall(7, this.p, IPrintAsyncNotifyDataObject.Ptr, param0)
    AsyncGetNotificationSendResponse(param0, param1)
      => ComCall(8, this.p, IPrintAsyncNotifyDataObject, param0, IAsyncGetSendNotificationCookie, param1)
    AsyncCloseChannel(param0, param1)
      => ComCall(9, this.p, IPrintAsyncNotifyDataObject, param0, IPrintAsyncCookie, param1)
}
struct UNIFM_HDR {
    dwSize : UInt32
    dwVersion : UInt32
    ulDefaultCodepage : UInt32
    lGlyphSetDataRCID : Int32
    loUnidrvInfo : UInt32
    loIFIMetrics : UInt32
    loExtTextMetric : UInt32
    loWidthTable : UInt32
    loKernPair : UInt32
    dwReserved : UInt32[2]
}
struct INVOC {
    dwCount : UInt32
    loOffset : UInt32
}
struct UNIDRVINFO {
    dwSize : UInt32
    flGenFlags : UInt32
    wType : UInt16
    fCaps : UInt16
    wXRes : UInt16
    wYRes : UInt16
    sYAdjust : Int16
    sYMoved : Int16
    wPrivateData : UInt16
    sShift : Int16
    SelectFont : INVOC
    UnSelectFont : INVOC
    wReserved : UInt16[4]
}
struct PRINTIFI32 {
    cjThis : UInt32
    cjIfiExtra : UInt32
    dpwszFamilyName : Int32
    dpwszStyleName : Int32
    dpwszFaceName : Int32
    dpwszUniqueName : Int32
    dpFontSim : Int32
    lEmbedId : Int32
    lItalicAngle : Int32
    lCharBias : Int32
    dpCharSets : Int32
    jWinCharSet : UInt8
    jWinPitchAndFamily : UInt8
    usWinWeight : UInt16
    flInfo : UInt32
    fsSelection : UInt16
    fsType : UInt16
    fwdUnitsPerEm : Int16
    fwdLowestPPEm : Int16
    fwdWinAscender : Int16
    fwdWinDescender : Int16
    fwdMacAscender : Int16
    fwdMacDescender : Int16
    fwdMacLineGap : Int16
    fwdTypoAscender : Int16
    fwdTypoDescender : Int16
    fwdTypoLineGap : Int16
    fwdAveCharWidth : Int16
    fwdMaxCharInc : Int16
    fwdCapHeight : Int16
    fwdXHeight : Int16
    fwdSubscriptXSize : Int16
    fwdSubscriptYSize : Int16
    fwdSubscriptXOffset : Int16
    fwdSubscriptYOffset : Int16
    fwdSuperscriptXSize : Int16
    fwdSuperscriptYSize : Int16
    fwdSuperscriptXOffset : Int16
    fwdSuperscriptYOffset : Int16
    fwdUnderscoreSize : Int16
    fwdUnderscorePosition : Int16
    fwdStrikeoutSize : Int16
    fwdStrikeoutPosition : Int16
    chFirstChar : UInt8
    chLastChar : UInt8
    chDefaultChar : UInt8
    chBreakChar : UInt8
    wcFirstChar : UInt16
    wcLastChar : UInt16
    wcDefaultChar : UInt16
    wcBreakChar : UInt16
    ptlBaseline : POINTL
    ptlAspect : POINTL
    ptlCaret : POINTL
    rclFontBox : RECTL
    achVendId : UInt8[4]
    cKerningPairs : UInt32
    ulPanoseCulture : UInt32
    panose : PANOSE
}
struct EXTTEXTMETRIC {
    emSize : Int16
    emPointSize : Int16
    emOrientation : Int16
    emMasterHeight : Int16
    emMinScale : Int16
    emMaxScale : Int16
    emMasterUnits : Int16
    emCapHeight : Int16
    emXHeight : Int16
    emLowerCaseAscent : Int16
    emLowerCaseDescent : Int16
    emSlant : Int16
    emSuperScript : Int16
    emSubScript : Int16
    emSuperScriptSize : Int16
    emSubScriptSize : Int16
    emUnderlineOffset : Int16
    emUnderlineWidth : Int16
    emDoubleUpperUnderlineOffset : Int16
    emDoubleLowerUnderlineOffset : Int16
    emDoubleUpperUnderlineWidth : Int16
    emDoubleLowerUnderlineWidth : Int16
    emStrikeOutOffset : Int16
    emStrikeOutWidth : Int16
    emKernPairs : UInt16
    emKernTracks : UInt16
}
struct WIDTHRUN {
    wStartGlyph : UInt16
    wGlyphCount : UInt16
    loCharWidthOffset : UInt32
}
struct WIDTHTABLE {
    dwSize : UInt32
    dwRunNum : UInt32
    WidthRun : WIDTHRUN[1]
}
struct KERNDATA {
    dwSize : UInt32
    dwKernPairNum : UInt32
    KernPair : FD_KERNINGPAIR[1]
}
struct UNI_GLYPHSETDATA {
    dwSize : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    lPredefinedID : Int32
    dwGlyphCount : UInt32
    dwRunCount : UInt32
    loRunOffset : UInt32
    dwCodePageCount : UInt32
    loCodePageOffset : UInt32
    loMapTableOffset : UInt32
    dwReserved : UInt32[2]
}
struct UNI_CODEPAGEINFO {
    dwCodePage : UInt32
    SelectSymbolSet : INVOC
    UnSelectSymbolSet : INVOC
}
struct GLYPHRUN {
    wcLow : UInt16
    wGlyphCount : UInt16
}
struct TRANSDATA {
    ubCodePageID : UInt8
    ubType : UInt8
    uCode : this._uCode_e__Union
    struct _uCode_e__Union {
        union {
            sCode : Int16
            ubCode : UInt8
            ubPairs : UInt8[2]
        }
    }
}
struct MAPTABLE {
    dwSize : UInt32
    dwGlyphNum : UInt32
    Trans : TRANSDATA[1]
}
struct UFF_FILEHEADER {
    dwSignature : UInt32
    dwVersion : UInt32
    dwSize : UInt32
    nFonts : UInt32
    nGlyphSets : UInt32
    nVarData : UInt32
    offFontDir : UInt32
    dwFlags : UInt32
    dwReserved : UInt32[4]
}
struct UFF_FONTDIRECTORY {
    dwSignature : UInt32
    wSize : UInt16
    wFontID : UInt16
    sGlyphID : Int16
    wFlags : UInt16
    dwInstallerSig : UInt32
    offFontName : UInt32
    offCartridgeName : UInt32
    offFontData : UInt32
    offGlyphData : UInt32
    offVarData : UInt32
}
struct DATA_HEADER {
    dwSignature : UInt32
    wSize : UInt16
    wDataID : UInt16
    dwDataSize : UInt32
    dwReserved : UInt32
}
struct OEMFONTINSTPARAM {
    cbSize : UInt32 := this.Size
    hPrinter : HANDLE
    hModule : HANDLE
    hHeap : HANDLE
    dwFlags : UInt32
    pFontInstallerName : PWSTR
}
struct PORT_DATA_1 {
    sztPortName : UInt16[64]
    dwVersion : UInt32
    dwProtocol : UInt32
    cbSize : UInt32 := this.Size
    dwReserved : UInt32
    sztHostAddress : UInt16[49]
    sztSNMPCommunity : UInt16[33]
    dwDoubleSpool : UInt32
    sztQueue : UInt16[33]
    sztIPAddress : UInt16[16]
    Reserved : UInt8[540]
    dwPortNumber : UInt32
    dwSNMPEnabled : UInt32
    dwSNMPDevIndex : UInt32
}
struct PORT_DATA_2 {
    sztPortName : UInt16[64]
    dwVersion : UInt32
    dwProtocol : UInt32
    cbSize : UInt32 := this.Size
    dwReserved : UInt32
    sztHostAddress : UInt16[128]
    sztSNMPCommunity : UInt16[33]
    dwDoubleSpool : UInt32
    sztQueue : UInt16[33]
    Reserved : UInt8[514]
    dwPortNumber : UInt32
    dwSNMPEnabled : UInt32
    dwSNMPDevIndex : UInt32
    dwPortMonitorMibIndex : UInt32
}
struct PORT_DATA_LIST_1 {
    dwVersion : UInt32
    cPortData : UInt32
    pPortData : PORT_DATA_2[1]
}
struct DELETE_PORT_DATA_1 {
    psztPortName : UInt16[64]
    Reserved : UInt8[98]
    dwVersion : UInt32
    dwReserved : UInt32
}
struct CONFIG_INFO_DATA_1 {
    Reserved : UInt8[128]
    dwVersion : UInt32
}
struct EMFPLAYPROC extends FunctionPointer {
    static Types := [HDC, Int32, HANDLE, Int32]
}
struct EBranchOfficeJobEventType extends Int32 {
    static kInvalidJobState := 0
    static kLogJobPrinted := 1
    static kLogJobRendered := 2
    static kLogJobError := 3
    static kLogJobPipelineError := 4
    static kLogOfflineFileFull := 5
}
struct BranchOfficeJobDataPrinted {
    Status : UInt32
    pDocumentName : PWSTR
    pUserName : PWSTR
    pMachineName : PWSTR
    pPrinterName : PWSTR
    pPortName : PWSTR
    Size : Int64
    TotalPages : UInt32
}
struct BranchOfficeJobDataError {
    LastError : UInt32
    pDocumentName : PWSTR
    pUserName : PWSTR
    pPrinterName : PWSTR
    pDataType : PWSTR
    TotalSize : Int64
    PrintedSize : Int64
    TotalPages : UInt32
    PrintedPages : UInt32
    pMachineName : PWSTR
    pJobError : PWSTR
    pErrorDescription : PWSTR
}
struct BranchOfficeJobDataRendered {
    Size : Int64
    ICMMethod : UInt32
    Color : Int16
    PrintQuality : Int16
    YResolution : Int16
    Copies : Int16
    TTOption : Int16
}
struct BranchOfficeJobDataPipelineFailed {
    pDocumentName : PWSTR
    pPrinterName : PWSTR
    pExtraErrorInfo : PWSTR
}
struct BranchOfficeLogOfflineFileFull {
    pMachineName : PWSTR
}
struct BranchOfficeJobData {
    eEventType : EBranchOfficeJobEventType
    JobId : UInt32
    JobInfo : this._JobInfo_e__Union
    struct _JobInfo_e__Union {
        union {
            LogJobPrinted : BranchOfficeJobDataPrinted
            LogJobRendered : BranchOfficeJobDataRendered
            LogJobError : BranchOfficeJobDataError
            LogPipelineFailed : BranchOfficeJobDataPipelineFailed
            LogOfflineFileFull : BranchOfficeLogOfflineFileFull
        }
    }
}
struct BranchOfficeJobDataContainer {
    cJobDataEntries : UInt32
    JobData : BranchOfficeJobData[1]
}
struct PRINTER_NOTIFY_INIT {
    Size : UInt32
    Reserved : UInt32
    PollTime : UInt32
}
struct SPLCLIENT_INFO_1 {
    dwSize : UInt32
    pMachineName : PWSTR
    pUserName : PWSTR
    dwBuildNum : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    wProcessorArchitecture : UInt16
}
struct SPLCLIENT_INFO_2_W2K {
    hSplPrinter : IntPtr
}
struct SPLCLIENT_INFO_2_V3 {
    hSplPrinter : Int64
}
struct DOC_INFO_INTERNAL {
    pDocName : Int8.Ptr
    pOutputFile : Int8.Ptr
    pDatatype : Int8.Ptr
    bLowILJob : BOOL
    hTokenLowIL : HANDLE
}
struct SPLCLIENT_INFO_3_VISTA {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwSize : UInt32
    pMachineName : PWSTR
    pUserName : PWSTR
    dwBuildNum : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    wProcessorArchitecture : UInt16
    hSplPrinter : Int64
}
struct SPLCLIENT_INFO_INTERNAL {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwSize : UInt32
    pMachineName : PWSTR
    pUserName : PWSTR
    dwBuildNum : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    wProcessorArchitecture : UInt16
    hSplPrinter : Int64
    dwProcessId : UInt32
    dwSessionId : UInt32
}
struct PRINTPROVIDOR {
    fpOpenPrinter : IntPtr
    fpSetJob : IntPtr
    fpGetJob : IntPtr
    fpEnumJobs : IntPtr
    fpAddPrinter : IntPtr
    fpDeletePrinter : IntPtr
    fpSetPrinter : IntPtr
    fpGetPrinter : IntPtr
    fpEnumPrinters : IntPtr
    fpAddPrinterDriver : IntPtr
    fpEnumPrinterDrivers : IntPtr
    fpGetPrinterDriver : IntPtr
    fpGetPrinterDriverDirectory : IntPtr
    fpDeletePrinterDriver : IntPtr
    fpAddPrintProcessor : IntPtr
    fpEnumPrintProcessors : IntPtr
    fpGetPrintProcessorDirectory : IntPtr
    fpDeletePrintProcessor : IntPtr
    fpEnumPrintProcessorDatatypes : IntPtr
    fpStartDocPrinter : IntPtr
    fpStartPagePrinter : IntPtr
    fpWritePrinter : IntPtr
    fpEndPagePrinter : IntPtr
    fpAbortPrinter : IntPtr
    fpReadPrinter : IntPtr
    fpEndDocPrinter : IntPtr
    fpAddJob : IntPtr
    fpScheduleJob : IntPtr
    fpGetPrinterData : IntPtr
    fpSetPrinterData : IntPtr
    fpWaitForPrinterChange : IntPtr
    fpClosePrinter : IntPtr
    fpAddForm : IntPtr
    fpDeleteForm : IntPtr
    fpGetForm : IntPtr
    fpSetForm : IntPtr
    fpEnumForms : IntPtr
    fpEnumMonitors : IntPtr
    fpEnumPorts : IntPtr
    fpAddPort : IntPtr
    fpConfigurePort : IntPtr
    fpDeletePort : IntPtr
    fpCreatePrinterIC : IntPtr
    fpPlayGdiScriptOnPrinterIC : IntPtr
    fpDeletePrinterIC : IntPtr
    fpAddPrinterConnection : IntPtr
    fpDeletePrinterConnection : IntPtr
    fpPrinterMessageBox : IntPtr
    fpAddMonitor : IntPtr
    fpDeleteMonitor : IntPtr
    fpResetPrinter : IntPtr
    fpGetPrinterDriverEx : IntPtr
    fpFindFirstPrinterChangeNotification : IntPtr
    fpFindClosePrinterChangeNotification : IntPtr
    fpAddPortEx : IntPtr
    fpShutDown : IntPtr
    fpRefreshPrinterChangeNotification : IntPtr
    fpOpenPrinterEx : IntPtr
    fpAddPrinterEx : IntPtr
    fpSetPort : IntPtr
    fpEnumPrinterData : IntPtr
    fpDeletePrinterData : IntPtr
    fpClusterSplOpen : IntPtr
    fpClusterSplClose : IntPtr
    fpClusterSplIsAlive : IntPtr
    fpSetPrinterDataEx : IntPtr
    fpGetPrinterDataEx : IntPtr
    fpEnumPrinterDataEx : IntPtr
    fpEnumPrinterKey : IntPtr
    fpDeletePrinterDataEx : IntPtr
    fpDeletePrinterKey : IntPtr
    fpSeekPrinter : IntPtr
    fpDeletePrinterDriverEx : IntPtr
    fpAddPerMachineConnection : IntPtr
    fpDeletePerMachineConnection : IntPtr
    fpEnumPerMachineConnections : IntPtr
    fpXcvData : IntPtr
    fpAddPrinterDriverEx : IntPtr
    fpSplReadPrinter : IntPtr
    fpDriverUnloadComplete : IntPtr
    fpGetSpoolFileInfo : IntPtr
    fpCommitSpoolData : IntPtr
    fpCloseSpoolFileHandle : IntPtr
    fpFlushPrinter : IntPtr
    fpSendRecvBidiData : IntPtr
    fpAddPrinterConnection2 : IntPtr
    fpGetPrintClassObject : IntPtr
    fpReportJobProcessingProgress : IntPtr
    fpEnumAndLogProvidorObjects : IntPtr
    fpInternalGetPrinterDriver : IntPtr
    fpFindCompatibleDriver : IntPtr
    fpInstallPrinterDriverPackageFromConnection : IntPtr
    fpGetJobNamedPropertyValue : IntPtr
    fpSetJobNamedProperty : IntPtr
    fpDeleteJobNamedProperty : IntPtr
    fpEnumJobNamedProperties : IntPtr
    fpPowerEvent : IntPtr
    fpGetUserPropertyBag : IntPtr
    fpCanShutdown : IntPtr
    fpLogJobInfoForBranchOffice : IntPtr
    fpRegeneratePrintDeviceCapabilities : IntPtr
    fpPrintSupportOperation : IntPtr
    fpIppCreateJobOnPrinter : IntPtr
    fpIppGetJobAttributes : IntPtr
    fpIppSetJobAttributes : IntPtr
    fpIppGetPrinterAttributes : IntPtr
    fpIppSetPrinterAttributes : IntPtr
    fpIppCreateJobOnPrinterWithAttributes : IntPtr
}
struct PRINTPROCESSOROPENDATA {
    pDevMode : DEVMODEA.Ptr
    pDatatype : PWSTR
    pParameters : PWSTR
    pDocumentName : PWSTR
    JobId : UInt32
    pOutputFile : PWSTR
    pPrinterName : PWSTR
}
struct MONITORREG {
    cbSize : UInt32 := this.Size
    fpCreateKey : IntPtr
    fpOpenKey : IntPtr
    fpCloseKey : IntPtr
    fpDeleteKey : IntPtr
    fpEnumKey : IntPtr
    fpQueryInfoKey : IntPtr
    fpSetValue : IntPtr
    fpDeleteValue : IntPtr
    fpEnumValue : IntPtr
    fpQueryValue : IntPtr
}
struct MONITORINIT {
    cbSize : UInt32 := this.Size
    hSpooler : HANDLE
    hckRegistryRoot : HKEY
    pMonitorReg : MONITORREG.Ptr
    bLocal : BOOL
    pszServerName : PWSTR
}
struct MONITOR {
    pfnEnumPorts : PFN_PRINTING_ENUMPORTS
    pfnOpenPort : PFN_PRINTING_OPENPORT
    pfnOpenPortEx : PFN_PRINTING_OPENPORTEX
    pfnStartDocPort : PFN_PRINTING_STARTDOCPORT
    pfnWritePort : PFN_PRINTING_WRITEPORT
    pfnReadPort : PFN_PRINTING_READPORT
    pfnEndDocPort : PFN_PRINTING_ENDDOCPORT
    pfnClosePort : PFN_PRINTING_CLOSEPORT
    pfnAddPort : PFN_PRINTING_ADDPORT
    pfnAddPortEx : PFN_PRINTING_ADDPORTEX
    pfnConfigurePort : PFN_PRINTING_CONFIGUREPORT
    pfnDeletePort : PFN_PRINTING_DELETEPORT
    pfnGetPrinterDataFromPort : PFN_PRINTING_GETPRINTERDATAFROMPORT
    pfnSetPortTimeOuts : PFN_PRINTING_SETPORTTIMEOUTS
    pfnXcvOpenPort : PFN_PRINTING_XCVOPENPORT
    pfnXcvDataPort : PFN_PRINTING_XCVDATAPORT
    pfnXcvClosePort : PFN_PRINTING_XCVCLOSEPORT
}
struct MONITOREX {
    dwMonitorSize : UInt32
    Monitor : MONITOR
}
struct MONITOR2 {
    cbSize : UInt32 := this.Size
    pfnEnumPorts : PFN_PRINTING_ENUMPORTS2
    pfnOpenPort : PFN_PRINTING_OPENPORT2
    pfnOpenPortEx : PFN_PRINTING_OPENPORTEX2
    pfnStartDocPort : PFN_PRINTING_STARTDOCPORT2
    pfnWritePort : PFN_PRINTING_WRITEPORT2
    pfnReadPort : PFN_PRINTING_READPORT2
    pfnEndDocPort : PFN_PRINTING_ENDDOCPORT2
    pfnClosePort : PFN_PRINTING_CLOSEPORT2
    pfnAddPort : PFN_PRINTING_ADDPORT2
    pfnAddPortEx : PFN_PRINTING_ADDPORTEX2
    pfnConfigurePort : PFN_PRINTING_CONFIGUREPORT2
    pfnDeletePort : PFN_PRINTING_DELETEPORT2
    pfnGetPrinterDataFromPort : PFN_PRINTING_GETPRINTERDATAFROMPORT2
    pfnSetPortTimeOuts : PFN_PRINTING_SETPORTTIMEOUTS2
    pfnXcvOpenPort : PFN_PRINTING_XCVOPENPORT2
    pfnXcvDataPort : PFN_PRINTING_XCVDATAPORT2
    pfnXcvClosePort : PFN_PRINTING_XCVCLOSEPORT2
    pfnShutdown : PFN_PRINTING_SHUTDOWN2
    pfnSendRecvBidiDataFromPort : PFN_PRINTING_SENDRECVBIDIDATAFROMPORT2
    pfnNotifyUsedPorts : PFN_PRINTING_NOTIFYUSEDPORTS2
    pfnNotifyUnusedPorts : PFN_PRINTING_NOTIFYUNUSEDPORTS2
    pfnPowerEvent : PFN_PRINTING_POWEREVENT2
}
struct MONITORUI {
    dwMonitorUISize : UInt32
    pfnAddPortUI : IntPtr
    pfnConfigurePortUI : IntPtr
    pfnDeletePortUI : IntPtr
}
struct ROUTER_NOTIFY_CALLBACK extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, PRINTER_NOTIFY_INFO.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct NOTIFICATION_CALLBACK_COMMANDS extends Int32 {
    static NOTIFICATION_COMMAND_NOTIFY := 0
    static NOTIFICATION_COMMAND_CONTEXT_ACQUIRE := 1
    static NOTIFICATION_COMMAND_CONTEXT_RELEASE := 2
}
struct NOTIFICATION_CONFIG_1 {
    cbSize : UInt32 := this.Size
    fdwFlags : UInt32
    pfnNotifyCallback : ROUTER_NOTIFY_CALLBACK
    pContext : Struct.Ptr
}
struct NOTIFICATION_CONFIG_FLAGS extends Int32 {
    static NOTIFICATION_CONFIG_CREATE_EVENT := 1
    static NOTIFICATION_CONFIG_REGISTER_CALLBACK := 2
    static NOTIFICATION_CONFIG_EVENT_TRIGGER := 4
    static NOTIFICATION_CONFIG_ASYNC_CHANNEL := 8
}
struct UI_TYPE extends Int32 {
    static kMessageBox := 0
}
struct MESSAGEBOX_PARAMS {
    cbSize : UInt32 := this.Size
    pTitle : PWSTR
    pMessage : PWSTR
    Style : UInt32
    dwTimeout : UInt32
    bWait : BOOL
}
struct SHOWUIPARAMS {
    UIType : UI_TYPE
    MessageBoxParams : MESSAGEBOX_PARAMS
}
struct IXpsRasterizerNotificationCallback extends IUnknown {
    static IID := "{9AB8FD0D-CB94-49C2-9CB0-97EC1D5469D2}"
    Continue()
      => ComCall(3, this.p)
}
struct XPSRAS_RENDERING_MODE extends Int32 {
    static XPSRAS_RENDERING_MODE_ANTIALIASED := 0
    static XPSRAS_RENDERING_MODE_ALIASED := 1
}
struct IXpsRasterizer extends IUnknown {
    static IID := "{7567CFC8-C156-47A8-9DAC-11A2AE5BDD6B}"
    RasterizeRect(x, y, width, height, notificationCallback?, bitmap)
      => ComCall(3, this.p, Int32, x, Int32, y, Int32, width, Int32, height, IXpsRasterizerNotificationCallback, notificationCallback?, IWICBitmap.Ptr, bitmap)
    SetMinimalLineWidth(width)
      => ComCall(4, this.p, Int32, width)
}
struct IXpsRasterizationFactory extends IUnknown {
    static IID := "{E094808A-24C6-482B-A3A7-C21AC9B55F17}"
    CreateRasterizer(xpsPage?, DPI, nonTextRenderingMode, textRenderingMode, ppIXPSRasterizer)
      => ComCall(3, this.p, IXpsOMPage, xpsPage?, Float32, DPI, XPSRAS_RENDERING_MODE, nonTextRenderingMode, XPSRAS_RENDERING_MODE, textRenderingMode, IXpsRasterizer.Ptr, ppIXPSRasterizer)
}
struct XPSRAS_PIXEL_FORMAT extends Int32 {
    static XPSRAS_PIXEL_FORMAT_32BPP_PBGRA_UINT_SRGB := 1
    static XPSRAS_PIXEL_FORMAT_64BPP_PRGBA_HALF_SCRGB := 2
    static XPSRAS_PIXEL_FORMAT_128BPP_PRGBA_FLOAT_SCRGB := 3
}
struct IXpsRasterizationFactory1 extends IUnknown {
    static IID := "{2D6E5F77-6414-4A1E-A8E0-D4194CE6A26F}"
    CreateRasterizer(xpsPage?, DPI, nonTextRenderingMode, textRenderingMode, pixelFormat, ppIXPSRasterizer)
      => ComCall(3, this.p, IXpsOMPage, xpsPage?, Float32, DPI, XPSRAS_RENDERING_MODE, nonTextRenderingMode, XPSRAS_RENDERING_MODE, textRenderingMode, XPSRAS_PIXEL_FORMAT, pixelFormat, IXpsRasterizer.Ptr, ppIXPSRasterizer)
}
struct XPSRAS_BACKGROUND_COLOR extends Int32 {
    static XPSRAS_BACKGROUND_COLOR_TRANSPARENT := 0
    static XPSRAS_BACKGROUND_COLOR_OPAQUE := 1
}
struct IXpsRasterizationFactory2 extends IUnknown {
    static IID := "{9C16CE3E-10F5-41FD-9DDC-6826669C2FF6}"
    CreateRasterizer(xpsPage?, DPIX, DPIY, nonTextRenderingMode, textRenderingMode, pixelFormat, backgroundColor, ppIXpsRasterizer)
      => ComCall(3, this.p, IXpsOMPage, xpsPage?, Float32, DPIX, Float32, DPIY, XPSRAS_RENDERING_MODE, nonTextRenderingMode, XPSRAS_RENDERING_MODE, textRenderingMode, XPSRAS_PIXEL_FORMAT, pixelFormat, XPSRAS_BACKGROUND_COLOR, backgroundColor, IXpsRasterizer.Ptr, ppIXpsRasterizer)
}
struct PageCountType extends Int32 {
    static FinalPageCount := 0
    static IntermediatePageCount := 1
}
struct IPrintPreviewDxgiPackageTarget extends IUnknown {
    static IID := "{1A6DD0AD-1E2A-4E99-A5BA-91F17818290E}"
    SetJobPageCount(countType, count)
      => ComCall(3, this.p, PageCountType, countType, UInt32, count)
    DrawPage(jobPageNumber, pageImage, dpiX, dpiY)
      => ComCall(4, this.p, UInt32, jobPageNumber, IDXGISurface, pageImage, Float32, dpiX, Float32, dpiY)
    InvalidatePreview()
      => ComCall(5, this.p)
}
