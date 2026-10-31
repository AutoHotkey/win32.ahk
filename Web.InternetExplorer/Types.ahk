#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, HWND, LPARAM, LUID, POINT, PWSTR, RECT, SIZE, VARIANT_BOOL, WPARAM}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_FORMAT, DXGI_MODE_ROTATION}
#Import "..\Graphics.Gdi\Types.ahk" {RGBQUAD}
#Import "..\System.Com\Types.ahk" {BINDINFO, IBindCtx, IBindStatusCallback, IDispatch, IMoniker, IPersist, IStream, IUnknown, IUri}
#Import "..\System.Ole\Types.ahk" {IOleCommandTarget, IOleContainer}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\System.WinRT\Types.ahk" {IInspectable}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}
#Import "..\Web.MsHtml\Types.ahk" {IHTMLDocument2, IHTMLElement, IHTMLWindow2, VIEW_OBJECT_ALPHA_MODE, styleMsTouchAction}

struct IDocObjectService extends IUnknown {
    static IID := "{3050F801-98B5-11CF-BB82-00AA00BDCE0B}"
    FireBeforeNavigate2(pDispatch?, lpszUrl, dwFlags, lpszFrameName, pPostData, cbPostData, lpszHeaders, fPlayNavSound, pfCancel)
      => ComCall(3, this.p, IDispatch, pDispatch?, "Str", lpszUrl, UInt32, dwFlags, "Str", lpszFrameName, UInt8.Ptr, pPostData, UInt32, cbPostData, "Str", lpszHeaders, BOOL, fPlayNavSound, BOOL.Ptr, pfCancel)
    FireNavigateComplete2(pHTMLWindow2?, dwFlags)
      => ComCall(4, this.p, IHTMLWindow2, pHTMLWindow2?, UInt32, dwFlags)
    FireDownloadBegin()
      => ComCall(5, this.p)
    FireDownloadComplete()
      => ComCall(6, this.p)
    FireDocumentComplete(pHTMLWindow?, dwFlags)
      => ComCall(7, this.p, IHTMLWindow2, pHTMLWindow?, UInt32, dwFlags)
    UpdateDesktopComponent(pHTMLWindow?)
      => ComCall(8, this.p, IHTMLWindow2, pHTMLWindow?)
    GetPendingUrl(pbstrPendingUrl)
      => ComCall(9, this.p, BSTR.Ptr, pbstrPendingUrl)
    ActiveElementChanged(pHTMLElement?)
      => ComCall(10, this.p, IHTMLElement, pHTMLElement?)
    GetUrlSearchComponent(pbstrSearch)
      => ComCall(11, this.p, BSTR.Ptr, pbstrSearch)
    IsErrorUrl(lpszUrl, pfIsError)
      => ComCall(12, this.p, "Str", lpszUrl, BOOL.Ptr, pfIsError)
}
struct IDownloadManager extends IUnknown {
    static IID := "{988934A4-064B-11D3-BB80-00104B35E7F9}"
    Download(pmk, pbc, dwBindVerb, grfBINDF, pBindInfo, pszHeaders, pszRedir, uiCP)
      => ComCall(3, this.p, IMoniker, pmk, IBindCtx, pbc, UInt32, dwBindVerb, Int32, grfBINDF, BINDINFO.Ptr, pBindInfo, "Str", pszHeaders, "Str", pszRedir, UInt32, uiCP)
}
struct ExtensionValidationContexts extends Int32 {
    static ExtensionValidationContextNone := 0
    static ExtensionValidationContextDynamic := 1
    static ExtensionValidationContextParsed := 2
}
struct ExtensionValidationResults extends Int32 {
    static ExtensionValidationResultNone := 0
    static ExtensionValidationResultDoNotInstantiate := 1
    static ExtensionValidationResultArrestPageLoad := 2
}
struct IExtensionValidation extends IUnknown {
    static IID := "{7D33F73D-8525-4E0F-87DB-830288BAFF44}"
    Validate(extensionGuid, extensionModulePath, extensionFileVersionMS, extensionFileVersionLS, htmlDocumentTop, htmlDocumentSubframe, htmlElement, contexts, results)
      => ComCall(3, this.p, GUID.Ptr, extensionGuid, "Str", extensionModulePath, UInt32, extensionFileVersionMS, UInt32, extensionFileVersionLS, IHTMLDocument2, htmlDocumentTop, IHTMLDocument2, htmlDocumentSubframe, IHTMLElement, htmlElement, ExtensionValidationContexts, contexts, ExtensionValidationResults.Ptr, results)
    DisplayName(displayName)
      => ComCall(4, this.p, PWSTR.Ptr, displayName)
}
struct IHomePageSetting extends IUnknown {
    static IID := "{FDFC244F-18FA-4FF2-B08E-1D618F3FFBE4}"
    SetHomePage(hwnd1, homePageUri, brandingMessage)
      => ComCall(3, this.p, HWND, hwnd1, "Str", homePageUri, "Str", brandingMessage)
    IsHomePage(uri, isDefault)
      => ComCall(4, this.p, "Str", uri, BOOL.Ptr, isDefault)
    SetHomePageToBrowserDefault()
      => ComCall(5, this.p)
}
struct ITargetNotify extends IUnknown {
    static IID := "{863A99A0-21BC-11D0-82B4-00A0C90C29C5}"
    OnCreate(pUnkDestination, cbCookie)
      => ComCall(3, this.p, IUnknown, pUnkDestination, UInt32, cbCookie)
    OnReuse(pUnkDestination)
      => ComCall(4, this.p, IUnknown, pUnkDestination)
}
struct ITargetNotify2 extends ITargetNotify {
    static IID := "{3050F6B1-98B5-11CF-BB82-00AA00BDCE0B}"
    GetOptionString(pbstrOptions)
      => ComCall(5, this.p, BSTR.Ptr, pbstrOptions)
}
struct FINDFRAME_FLAGS extends Int32 {
    static FINDFRAME_NONE := 0
    static FINDFRAME_JUSTTESTEXISTENCE := 1
    static FINDFRAME_INTERNAL := -2147483648
}
struct FRAMEOPTIONS_FLAGS extends Int32 {
    static FRAMEOPTIONS_SCROLL_YES := 1
    static FRAMEOPTIONS_SCROLL_NO := 2
    static FRAMEOPTIONS_SCROLL_AUTO := 4
    static FRAMEOPTIONS_NORESIZE := 8
    static FRAMEOPTIONS_NO3DBORDER := 16
    static FRAMEOPTIONS_DESKTOP := 32
    static FRAMEOPTIONS_BROWSERBAND := 64
}
struct ITargetFrame2 extends IUnknown {
    static IID := "{86D52E11-94A8-11D0-82AF-00C04FD5AE38}"
    SetFrameName(pszFrameName)
      => ComCall(3, this.p, "Str", pszFrameName)
    GetFrameName(ppszFrameName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszFrameName)
    GetParentFrame(ppunkParent)
      => ComCall(5, this.p, IUnknown.Ptr, ppunkParent)
    SetFrameSrc(pszFrameSrc)
      => ComCall(6, this.p, "Str", pszFrameSrc)
    GetFrameSrc(ppszFrameSrc)
      => ComCall(7, this.p, PWSTR.Ptr, ppszFrameSrc)
    GetFramesContainer(ppContainer)
      => ComCall(8, this.p, IOleContainer.Ptr, ppContainer)
    SetFrameOptions(dwFlags)
      => ComCall(9, this.p, UInt32, dwFlags)
    GetFrameOptions(pdwFlags)
      => ComCall(10, this.p, UInt32.Ptr, pdwFlags)
    SetFrameMargins(dwWidth, dwHeight)
      => ComCall(11, this.p, UInt32, dwWidth, UInt32, dwHeight)
    GetFrameMargins(pdwWidth, pdwHeight)
      => ComCall(12, this.p, UInt32.Ptr, pdwWidth, UInt32.Ptr, pdwHeight)
    FindFrame(pszTargetName, dwFlags, ppunkTargetFrame)
      => ComCall(13, this.p, "Str", pszTargetName, UInt32, dwFlags, IUnknown.Ptr, ppunkTargetFrame)
    GetTargetAlias(pszTargetName, ppszTargetAlias)
      => ComCall(14, this.p, "Str", pszTargetName, PWSTR.Ptr, ppszTargetAlias)
}
struct ITargetContainer extends IUnknown {
    static IID := "{7847EC01-2BEC-11D0-82B4-00A0C90C29C5}"
    GetFrameUrl(ppszFrameSrc)
      => ComCall(3, this.p, PWSTR.Ptr, ppszFrameSrc)
    GetFramesContainer(ppContainer)
      => ComCall(4, this.p, IOleContainer.Ptr, ppContainer)
}
struct NAVIGATEFRAME_FLAGS extends Int32 {
    static NAVIGATEFRAME_FL_RECORD := 1
    static NAVIGATEFRAME_FL_POST := 2
    static NAVIGATEFRAME_FL_NO_DOC_CACHE := 4
    static NAVIGATEFRAME_FL_NO_IMAGE_CACHE := 8
    static NAVIGATEFRAME_FL_AUTH_FAIL_CACHE_OK := 16
    static NAVIGATEFRAME_FL_SENDING_FROM_FORM := 32
    static NAVIGATEFRAME_FL_REALLY_SENDING_FROM_FORM := 64
}
struct NAVIGATEDATA {
    ulTarget : UInt32
    ulURL : UInt32
    ulRefURL : UInt32
    ulPostData : UInt32
    dwFlags : UInt32
}
struct ITargetFrame extends IUnknown {
    static IID := "{D5F78C80-5252-11CF-90FA-00AA0042106E}"
    SetFrameName(pszFrameName)
      => ComCall(3, this.p, "Str", pszFrameName)
    GetFrameName(ppszFrameName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszFrameName)
    GetParentFrame(ppunkParent)
      => ComCall(5, this.p, IUnknown.Ptr, ppunkParent)
    FindFrame(pszTargetName, ppunkContextFrame, dwFlags, ppunkTargetFrame)
      => ComCall(6, this.p, "Str", pszTargetName, IUnknown, ppunkContextFrame, UInt32, dwFlags, IUnknown.Ptr, ppunkTargetFrame)
    SetFrameSrc(pszFrameSrc)
      => ComCall(7, this.p, "Str", pszFrameSrc)
    GetFrameSrc(ppszFrameSrc)
      => ComCall(8, this.p, PWSTR.Ptr, ppszFrameSrc)
    GetFramesContainer(ppContainer)
      => ComCall(9, this.p, IOleContainer.Ptr, ppContainer)
    SetFrameOptions(dwFlags)
      => ComCall(10, this.p, UInt32, dwFlags)
    GetFrameOptions(pdwFlags)
      => ComCall(11, this.p, UInt32.Ptr, pdwFlags)
    SetFrameMargins(dwWidth, dwHeight)
      => ComCall(12, this.p, UInt32, dwWidth, UInt32, dwHeight)
    GetFrameMargins(pdwWidth, pdwHeight)
      => ComCall(13, this.p, UInt32.Ptr, pdwWidth, UInt32.Ptr, pdwHeight)
    RemoteNavigate(pulData)
      => ComCall(14, this.p, UInt32, pulData.Length, UInt32.Ptr, pulData)
    OnChildFrameActivate(pUnkChildFrame)
      => ComCall(15, this.p, IUnknown, pUnkChildFrame)
    OnChildFrameDeactivate(pUnkChildFrame)
      => ComCall(16, this.p, IUnknown, pUnkChildFrame)
}
struct ITargetEmbedding extends IUnknown {
    static IID := "{548793C0-9E74-11CF-9655-00A0C9034923}"
    GetTargetFrame(ppTargetFrame)
      => ComCall(3, this.p, ITargetFrame.Ptr, ppTargetFrame)
}
struct ITargetFramePriv extends IUnknown {
    static IID := "{9216E421-2BF5-11D0-82B4-00A0C90C29C5}"
    FindFrameDownwards(pszTargetName, dwFlags, ppunkTargetFrame)
      => ComCall(3, this.p, "Str", pszTargetName, UInt32, dwFlags, IUnknown.Ptr, ppunkTargetFrame)
    FindFrameInContext(pszTargetName, punkContextFrame, dwFlags, ppunkTargetFrame)
      => ComCall(4, this.p, "Str", pszTargetName, IUnknown, punkContextFrame, UInt32, dwFlags, IUnknown.Ptr, ppunkTargetFrame)
    OnChildFrameActivate(pUnkChildFrame)
      => ComCall(5, this.p, IUnknown, pUnkChildFrame)
    OnChildFrameDeactivate(pUnkChildFrame)
      => ComCall(6, this.p, IUnknown, pUnkChildFrame)
    NavigateHack(grfHLNF, pbc, pibsc, pszTargetName, pszUrl, pszLocation)
      => ComCall(7, this.p, UInt32, grfHLNF, IBindCtx, pbc, IBindStatusCallback, pibsc, "Str", pszTargetName, "Str", pszUrl, "Str", pszLocation)
    FindBrowserByIndex(dwID, ppunkBrowser)
      => ComCall(8, this.p, UInt32, dwID, IUnknown.Ptr, ppunkBrowser)
}
struct ITargetFramePriv2 extends ITargetFramePriv {
    static IID := "{B2C867E6-69D6-46F2-A611-DED9A4BD7FEF}"
    AggregatedNavigation2(grfHLNF, pbc, pibsc, pszTargetName, pUri, pszLocation)
      => ComCall(9, this.p, UInt32, grfHLNF, IBindCtx, pbc, IBindStatusCallback, pibsc, "Str", pszTargetName, IUri, pUri, "Str", pszLocation)
}
struct ISurfacePresenterFlipBuffer extends IUnknown {
    static IID := "{E43F4A08-8BBC-4665-AC92-C55CE61FD7E7}"
    BeginDraw(riid, ppBuffer)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppBuffer)
    EndDraw()
      => ComCall(4, this.p)
}
struct ISurfacePresenterFlip extends IUnknown {
    static IID := "{30510848-98B5-11CF-BB82-00AA00BDCE0B}"
    Present()
      => ComCall(3, this.p)
    GetBuffer(backBufferIndex, riid, ppBuffer)
      => ComCall(4, this.p, UInt32, backBufferIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppBuffer)
}
struct ISurfacePresenterFlip2 extends IUnknown {
    static IID := "{30510865-98B5-11CF-BB82-00AA00BDCE0B}"
    SetRotation(dxgiRotation)
      => ComCall(3, this.p, DXGI_MODE_ROTATION, dxgiRotation)
}
struct IViewObjectPresentFlipSite extends IUnknown {
    static IID := "{30510846-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateSurfacePresenterFlip(pDevice?, width, height, backBufferCount, format, mode, ppSPFlip)
      => ComCall(3, this.p, IUnknown, pDevice?, UInt32, width, UInt32, height, UInt32, backBufferCount, DXGI_FORMAT, format, VIEW_OBJECT_ALPHA_MODE, mode, ISurfacePresenterFlip.Ptr, ppSPFlip)
    GetDeviceLuid(pLuid)
      => ComCall(4, this.p, LUID.Ptr, pLuid)
    EnterFullScreen()
      => ComCall(5, this.p)
    ExitFullScreen()
      => ComCall(6, this.p)
    IsFullScreen(pfFullScreen)
      => ComCall(7, this.p, BOOL.Ptr, pfFullScreen)
    GetBoundingRect(pRect)
      => ComCall(8, this.p, RECT.Ptr, pRect)
    GetMetrics(pPos, pSize, pScaleX, pScaleY)
      => ComCall(9, this.p, POINT.Ptr, pPos, SIZE.Ptr, pSize, Float32.Ptr, pScaleX, Float32.Ptr, pScaleY)
    GetFullScreenSize(pSize)
      => ComCall(10, this.p, SIZE.Ptr, pSize)
}
struct IViewObjectPresentFlipSite2 extends IUnknown {
    static IID := "{AAD0CBF1-E7FD-4F12-8902-C78132A8E01D}"
    GetRotationForCurrentOutput(pDxgiRotation)
      => ComCall(3, this.p, DXGI_MODE_ROTATION.Ptr, pDxgiRotation)
}
struct IViewObjectPresentFlip extends IUnknown {
    static IID := "{30510847-98B5-11CF-BB82-00AA00BDCE0B}"
    NotifyRender(fRecreatePresenter)
      => ComCall(3, this.p, BOOL, fRecreatePresenter)
    RenderObjectToBitmap(pBitmap?)
      => ComCall(4, this.p, IUnknown, pBitmap?)
    RenderObjectToSharedBuffer(pBuffer?)
      => ComCall(5, this.p, ISurfacePresenterFlipBuffer, pBuffer?)
}
struct IViewObjectPresentFlip2 extends IUnknown {
    static IID := "{30510856-98B5-11CF-BB82-00AA00BDCE0B}"
    NotifyLeavingView()
      => ComCall(3, this.p)
}
struct IActiveXUIHandlerSite2 extends IUnknown {
    static IID := "{7E3707B2-D087-4542-AC1F-A0D2FCD080FD}"
    AddSuspensionExemption(pullCookie)
      => ComCall(3, this.p, Int64.Ptr, pullCookie)
    RemoveSuspensionExemption(ullCookie)
      => ComCall(4, this.p, Int64, ullCookie)
}
struct ICaretPositionProvider extends IUnknown {
    static IID := "{58DA43A2-108E-4D5B-9F75-E5F74F93FFF5}"
    GetCaretPosition(pptCaret, pflHeight)
      => ComCall(3, this.p, POINT.Ptr, pptCaret, Float32.Ptr, pflHeight)
}
struct ITridentTouchInput extends IUnknown {
    static IID := "{30510850-98B5-11CF-BB82-00AA00BDCE0B}"
    OnPointerMessage(msg, wParam1, lParam1, pfAllowManipulations)
      => ComCall(3, this.p, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfAllowManipulations)
}
struct ITridentTouchInputSite extends IUnknown {
    static IID := "{30510849-98B5-11CF-BB82-00AA00BDCE0B}"
    SetManipulationMode(msTouchAction)
      => ComCall(3, this.p, styleMsTouchAction, msTouchAction)
    ZoomToPoint(x, y)
      => ComCall(4, this.p, Int32, x, Int32, y)
}
struct MEDIA_ACTIVITY_NOTIFY_TYPE extends Int32 {
    static MediaPlayback := 0
    static MediaRecording := 1
    static MediaCasting := 2
}
struct IMediaActivityNotifySite extends IUnknown {
    static IID := "{8165CFEF-179D-46C2-BC71-3FA726DC1F8D}"
    OnMediaActivityStarted(mediaActivityType)
      => ComCall(3, this.p, MEDIA_ACTIVITY_NOTIFY_TYPE, mediaActivityType)
    OnMediaActivityStopped(mediaActivityType)
      => ComCall(4, this.p, MEDIA_ACTIVITY_NOTIFY_TYPE, mediaActivityType)
}
struct IAudioSessionSite extends IUnknown {
    static IID := "{D7D8B684-D02D-4517-B6B7-19E3DFE29C45}"
    GetAudioSessionGuid(audioSessionGuid)
      => ComCall(3, this.p, GUID.Ptr, audioSessionGuid)
    OnAudioStreamCreated(endpointID)
      => ComCall(4, this.p, "Str", endpointID)
    OnAudioStreamDestroyed(endpointID)
      => ComCall(5, this.p, "Str", endpointID)
}
struct IPrintTaskRequestHandler extends IUnknown {
    static IID := "{191CD340-CF36-44FF-BD53-D1B701799D9B}"
    HandlePrintTaskRequest(pPrintTaskRequest)
      => ComCall(3, this.p, IInspectable, pPrintTaskRequest)
}
struct IPrintTaskRequestFactory extends IUnknown {
    static IID := "{BB516745-8C34-4F8B-9605-684DCB144BE5}"
    CreatePrintTaskRequest(pPrintTaskRequestHandler?)
      => ComCall(3, this.p, IPrintTaskRequestHandler, pPrintTaskRequestHandler?)
}
struct IScrollableContextMenu extends IUnknown {
    static IID := "{30510854-98B5-11CF-BB82-00AA00BDCE0B}"
    AddItem(itemText, cmdID)
      => ComCall(3, this.p, "Str", itemText, UInt32, cmdID)
    ShowModal(x, y, cmdID)
      => ComCall(4, this.p, Int32, x, Int32, y, UInt32.Ptr, cmdID)
}
struct SCROLLABLECONTEXTMENU_PLACEMENT extends Int32 {
    static SCMP_TOP := 0
    static SCMP_BOTTOM := 1
    static SCMP_LEFT := 2
    static SCMP_RIGHT := 3
    static SCMP_FULL := 4
}
struct IScrollableContextMenu2 extends IScrollableContextMenu {
    static IID := "{F77E9056-8674-4936-924C-0E4A06FA634A}"
    AddSeparator()
      => ComCall(5, this.p)
    SetPlacement(scmp)
      => ComCall(6, this.p, SCROLLABLECONTEXTMENU_PLACEMENT, scmp)
}
struct IActiveXUIHandlerSite extends IUnknown {
    static IID := "{30510853-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateScrollableContextMenu(scrollableContextMenu)
      => ComCall(3, this.p, IScrollableContextMenu.Ptr, scrollableContextMenu)
    PickFileAndGetResult(filePicker?, allowMultipleSelections, result)
      => ComCall(4, this.p, IUnknown, filePicker?, BOOL, allowMultipleSelections, IUnknown.Ptr, result)
}
struct IActiveXUIHandlerSite3 extends IUnknown {
    static IID := "{7904009A-1238-47F4-901C-871375C34608}"
    MessageBoxW(hwnd1?, text?, caption?, type, result)
      => ComCall(3, this.p, HWND, hwnd1?, "Str", text?, "Str", caption?, UInt32, type, Int32.Ptr, result)
}
struct INTERNETEXPLORERCONFIGURATION extends Int32 {
    static INTERNETEXPLORERCONFIGURATION_HOST := 1
    static INTERNETEXPLORERCONFIGURATION_WEB_DRIVER := 2
    static INTERNETEXPLORERCONFIGURATION_WEB_DRIVER_EDGE := 4
}
struct IEnumManagerFrames extends IUnknown {
    static IID := "{3CAA826A-9B1F-4A79-BC81-F0430DED1648}"
    Next(ppWindows, pceltFetched)
      => ComCall(3, this.p, UInt32, ppWindows.Length, HWND.Ptr.Ptr, ppWindows, UInt32.Ptr, pceltFetched)
    Count(pcelt)
      => ComCall(4, this.p, UInt32.Ptr, pcelt)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Reset()
      => ComCall(6, this.p)
    Clone(ppEnum)
      => ComCall(7, this.p, IEnumManagerFrames.Ptr, ppEnum)
}
struct IInternetExplorerManager extends IUnknown {
    static IID := "{ACC84351-04FF-44F9-B23F-655ED168C6D5}"
    CreateObject(dwConfig, pszURL, riid, ppv)
      => ComCall(3, this.p, UInt32, dwConfig, "Str", pszURL, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IInternetExplorerManager2 extends IUnknown {
    static IID := "{DFBB5136-9259-4895-B4A7-C1934429919A}"
    EnumFrameWindows(ppEnum)
      => ComCall(3, this.p, IEnumManagerFrames.Ptr, ppEnum)
}
struct IELAUNCHOPTION_FLAGS extends Int32 {
    static IELAUNCHOPTION_SCRIPTDEBUG := 1
    static IELAUNCHOPTION_FORCE_COMPAT := 2
    static IELAUNCHOPTION_FORCE_EDGE := 4
    static IELAUNCHOPTION_LOCK_ENGINE := 8
}
struct IELAUNCHURLINFO {
    cbSize : UInt32 := this.Size
    dwCreationFlags : UInt32
    dwLaunchOptionFlags : UInt32
}
struct IIEWebDriverSite extends IDispatch {
    static IID := "{FFB84444-453D-4FBC-9F9D-8DB5C471EC75}"
    WindowOperation(operationCode, hWnd)
      => ComCall(7, this.p, UInt32, operationCode, UInt32, hWnd)
    DetachWebdriver(pUnkWD)
      => ComCall(8, this.p, IUnknown, pUnkWD)
    GetCapabilityValue(pUnkWD, capName, capValue)
      => ComCall(9, this.p, IUnknown, pUnkWD, "Str", capName, VARIANT.Ptr, capValue)
}
struct IIEWebDriverManager extends IDispatch {
    static IID := "{BD1DC630-6590-4CA2-A293-6BC72B2438D8}"
    ExecuteCommand(command, response)
      => ComCall(7, this.p, "Str", command, PWSTR.Ptr, response)
}
struct IPeerFactory extends IUnknown {
    static IID := "{6663F9D3-B482-11D1-89C6-00C04FB6BFC4}"
}
struct IHomePage extends IDispatch {
    static IID := "{766BF2AF-D650-11D1-9811-00C04FC31D2E}"
    navigateHomePage()
      => ComCall(7, this.p)
    setHomePage(bstrURL)
      => ComCall(8, this.p, BSTR, bstrURL)
    isHomePage(bstrURL, p)
      => ComCall(9, this.p, BSTR, bstrURL, VARIANT_BOOL.Ptr, p)
}
struct IIntelliForms extends IDispatch {
    static IID := "{9B9F68E6-1AAA-11D2-BCA5-00C04FD929DB}"
    get_enabled(pVal)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pVal)
    put_enabled(bVal)
      => ComCall(8, this.p, VARIANT_BOOL, bVal)
}
struct Iwfolders extends IDispatch {
    static IID := "{BAE31F98-1B81-11D2-A97A-00C04F8ECB02}"
    navigate(bstrUrl, pbstrRetVal)
      => ComCall(7, this.p, BSTR, bstrUrl, BSTR.Ptr, pbstrRetVal)
    navigateFrame(bstrUrl, bstrTargetFrame, pbstrRetVal)
      => ComCall(8, this.p, BSTR, bstrUrl, BSTR, bstrTargetFrame, BSTR.Ptr, pbstrRetVal)
    navigateNoSite(bstrUrl, bstrTargetFrame, dwhwnd, pwb)
      => ComCall(9, this.p, BSTR, bstrUrl, BSTR, bstrTargetFrame, UInt32, dwhwnd, IUnknown, pwb)
}
struct IAnchorClick extends IDispatch {
    static IID := "{13D5413B-33B9-11D2-95A7-00C04F8ECB02}"
    ProcOnClick()
      => ComCall(7, this.p)
}
struct IHTMLUserDataOM extends IDispatch {
    static IID := "{3050F48F-98B5-11CF-BB82-00AA00BDCE0B}"
    get_XMLDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    save(strName)
      => ComCall(8, this.p, BSTR, strName)
    load(strName)
      => ComCall(9, this.p, BSTR, strName)
    getAttribute(name, pValue)
      => ComCall(10, this.p, BSTR, name, VARIANT.Ptr, pValue)
    setAttribute(name, value)
      => ComCall(11, this.p, BSTR, name, VARIANT, value)
    removeAttribute(name)
      => ComCall(12, this.p, BSTR, name)
    put_expires(bstr1)
      => ComCall(13, this.p, BSTR, bstr1)
    get_expires(pbstr)
      => ComCall(14, this.p, BSTR.Ptr, pbstr)
}
struct IHTMLPersistDataOM extends IDispatch {
    static IID := "{3050F4C0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_XMLDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    getAttribute(name, pValue)
      => ComCall(8, this.p, BSTR, name, VARIANT.Ptr, pValue)
    setAttribute(name, value)
      => ComCall(9, this.p, BSTR, name, VARIANT, value)
    removeAttribute(name)
      => ComCall(10, this.p, BSTR, name)
}
struct IHTMLPersistData extends IUnknown {
    static IID := "{3050F4C5-98B5-11CF-BB82-00AA00BDCE0B}"
    save(pUnk, lType, fContinueBroacast)
      => ComCall(3, this.p, IUnknown, pUnk, Int32, lType, VARIANT_BOOL.Ptr, fContinueBroacast)
    load(pUnk, lType, fDoDefault)
      => ComCall(4, this.p, IUnknown, pUnk, Int32, lType, VARIANT_BOOL.Ptr, fDoDefault)
    queryType(lType, pfSupportsType)
      => ComCall(5, this.p, Int32, lType, VARIANT_BOOL.Ptr, pfSupportsType)
}
struct IDownloadBehavior extends IDispatch {
    static IID := "{3050F5BD-98B5-11CF-BB82-00AA00BDCE0B}"
    startDownload(bstrUrl, pdispCallback)
      => ComCall(7, this.p, BSTR, bstrUrl, IDispatch, pdispCallback)
}
struct ILayoutRect extends IDispatch {
    static IID := "{3050F665-98B5-11CF-BB82-00AA00BDCE0B}"
    put_nextRect(bstrElementId)
      => ComCall(7, this.p, BSTR, bstrElementId)
    get_nextRect(pbstrElementId)
      => ComCall(8, this.p, BSTR.Ptr, pbstrElementId)
    put_contentSrc(varContentSrc)
      => ComCall(9, this.p, VARIANT, varContentSrc)
    get_contentSrc(pvarContentSrc)
      => ComCall(10, this.p, VARIANT.Ptr, pvarContentSrc)
    put_honorPageBreaks(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_honorPageBreaks(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    put_honorPageRules(v)
      => ComCall(13, this.p, VARIANT_BOOL, v)
    get_honorPageRules(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    put_nextRectElement(pElem)
      => ComCall(15, this.p, IDispatch, pElem)
    get_nextRectElement(ppElem)
      => ComCall(16, this.p, IDispatch.Ptr, ppElem)
    get_contentDocument(pDoc)
      => ComCall(17, this.p, IDispatch.Ptr, pDoc)
}
struct IDeviceRect extends IDispatch {
    static IID := "{3050F6D5-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHeaderFooter extends IDispatch {
    static IID := "{3050F6CE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_htmlHead(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_htmlFoot(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_textHead(v)
      => ComCall(9, this.p, BSTR, v)
    get_textHead(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_textFoot(v)
      => ComCall(11, this.p, BSTR, v)
    get_textFoot(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_page(v)
      => ComCall(13, this.p, UInt32, v)
    get_page(p)
      => ComCall(14, this.p, UInt32.Ptr, p)
    put_pageTotal(v)
      => ComCall(15, this.p, UInt32, v)
    get_pageTotal(p)
      => ComCall(16, this.p, UInt32.Ptr, p)
    put_URL(v)
      => ComCall(17, this.p, BSTR, v)
    get_URL(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_title(v)
      => ComCall(19, this.p, BSTR, v)
    get_title(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_dateShort(v)
      => ComCall(21, this.p, BSTR, v)
    get_dateShort(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_dateLong(v)
      => ComCall(23, this.p, BSTR, v)
    get_dateLong(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_timeShort(v)
      => ComCall(25, this.p, BSTR, v)
    get_timeShort(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_timeLong(v)
      => ComCall(27, this.p, BSTR, v)
    get_timeLong(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
}
struct IHeaderFooter2 extends IHeaderFooter {
    static IID := "{305104A5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_font(v)
      => ComCall(29, this.p, BSTR, v)
    get_font(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
}
struct OpenServiceErrors extends Int32 {
    static OS_E_NOTFOUND := -2147287038
    static OS_E_NOTSUPPORTED := -2147467231
    static OS_E_CANCELLED := -2147471631
    static OS_E_GPDISABLED := -1072886820
}
struct OpenServiceActivityContentType extends Int32 {
    static ActivityContentNone := -1
    static ActivityContentDocument := 0
    static ActivityContentSelection := 1
    static ActivityContentLink := 2
    static ActivityContentCount := 3
}
struct IOpenServiceActivityInput extends IUnknown {
    static IID := "{75CB4DB9-6DA0-4DA3-83CE-422B6A433346}"
    GetVariable(pwzVariableName, pwzVariableType, pbstrVariableContent)
      => ComCall(3, this.p, "Str", pwzVariableName, "Str", pwzVariableType, BSTR.Ptr, pbstrVariableContent)
    HasVariable(pwzVariableName, pwzVariableType, pfHasVariable)
      => ComCall(4, this.p, "Str", pwzVariableName, "Str", pwzVariableType, BOOL.Ptr, pfHasVariable)
    GetType(pType)
      => ComCall(5, this.p, OpenServiceActivityContentType.Ptr, pType)
}
struct IOpenServiceActivityOutputContext extends IUnknown {
    static IID := "{E289DEAB-F709-49A9-B99E-282364074571}"
    Navigate(pwzUri, pwzMethod, pwzHeaders, pPostData)
      => ComCall(3, this.p, "Str", pwzUri, "Str", pwzMethod, "Str", pwzHeaders, IStream, pPostData)
    CanNavigate(pwzUri, pwzMethod, pwzHeaders, pPostData, pfCanNavigate)
      => ComCall(4, this.p, "Str", pwzUri, "Str", pwzMethod, "Str", pwzHeaders, IStream, pPostData, BOOL.Ptr, pfCanNavigate)
}
struct IOpenService extends IUnknown {
    static IID := "{C2952ED1-6A89-4606-925F-1ED8B4BE0630}"
    IsDefault(pfIsDefault)
      => ComCall(3, this.p, BOOL.Ptr, pfIsDefault)
    SetDefault(fDefault, hwnd1)
      => ComCall(4, this.p, BOOL, fDefault, HWND, hwnd1)
    GetID(pbstrID)
      => ComCall(5, this.p, BSTR.Ptr, pbstrID)
}
struct IOpenServiceManager extends IUnknown {
    static IID := "{5664125F-4E10-4E90-98E4-E4513D955A14}"
    InstallService(pwzServiceUrl, ppService)
      => ComCall(3, this.p, "Str", pwzServiceUrl, IOpenService.Ptr, ppService)
    UninstallService(pService)
      => ComCall(4, this.p, IOpenService, pService)
    GetServiceByID(pwzID, ppService)
      => ComCall(5, this.p, "Str", pwzID, IOpenService.Ptr, ppService)
}
struct IOpenServiceActivity extends IOpenService {
    static IID := "{13645C88-221A-4905-8ED1-4F5112CFC108}"
    Execute(pInput, pOutput)
      => ComCall(6, this.p, IOpenServiceActivityInput, pInput, IOpenServiceActivityOutputContext, pOutput)
    CanExecute(pInput, pOutput, pfCanExecute)
      => ComCall(7, this.p, IOpenServiceActivityInput, pInput, IOpenServiceActivityOutputContext, pOutput, BOOL.Ptr, pfCanExecute)
    CanExecuteType(type, pfCanExecute)
      => ComCall(8, this.p, OpenServiceActivityContentType, type, BOOL.Ptr, pfCanExecute)
    Preview(pInput, pOutput)
      => ComCall(9, this.p, IOpenServiceActivityInput, pInput, IOpenServiceActivityOutputContext, pOutput)
    CanPreview(pInput, pOutput, pfCanPreview)
      => ComCall(10, this.p, IOpenServiceActivityInput, pInput, IOpenServiceActivityOutputContext, pOutput, BOOL.Ptr, pfCanPreview)
    CanPreviewType(type, pfCanPreview)
      => ComCall(11, this.p, OpenServiceActivityContentType, type, BOOL.Ptr, pfCanPreview)
    GetStatusText(pInput, pbstrStatusText)
      => ComCall(12, this.p, IOpenServiceActivityInput, pInput, BSTR.Ptr, pbstrStatusText)
    GetHomepageUrl(pbstrHomepageUrl)
      => ComCall(13, this.p, BSTR.Ptr, pbstrHomepageUrl)
    GetDisplayName(pbstrDisplayName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrDisplayName)
    GetDescription(pbstrDescription)
      => ComCall(15, this.p, BSTR.Ptr, pbstrDescription)
    GetCategoryName(pbstrCategoryName)
      => ComCall(16, this.p, BSTR.Ptr, pbstrCategoryName)
    GetIconPath(pbstrIconPath)
      => ComCall(17, this.p, BSTR.Ptr, pbstrIconPath)
    GetIcon(fSmallIcon, phIcon)
      => ComCall(18, this.p, BOOL, fSmallIcon, HICON.Ptr, phIcon)
    GetDescriptionFilePath(pbstrXmlPath)
      => ComCall(19, this.p, BSTR.Ptr, pbstrXmlPath)
    GetDownloadUrl(pbstrXmlUri)
      => ComCall(20, this.p, BSTR.Ptr, pbstrXmlUri)
    GetInstallUrl(pbstrInstallUri)
      => ComCall(21, this.p, BSTR.Ptr, pbstrInstallUri)
    IsEnabled(pfIsEnabled)
      => ComCall(22, this.p, BOOL.Ptr, pfIsEnabled)
    SetEnabled(fEnable)
      => ComCall(23, this.p, BOOL, fEnable)
}
struct IEnumOpenServiceActivity extends IUnknown {
    static IID := "{A436D7D2-17C3-4EF4-A1E8-5C86FAFF26C0}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IOpenServiceActivity.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumOpenServiceActivity.Ptr, ppenum)
}
struct IOpenServiceActivityCategory extends IUnknown {
    static IID := "{850AF9D6-7309-40B5-BDB8-786C106B2153}"
    HasDefaultActivity(pfHasDefaultActivity)
      => ComCall(3, this.p, BOOL.Ptr, pfHasDefaultActivity)
    GetDefaultActivity(ppDefaultActivity)
      => ComCall(4, this.p, IOpenServiceActivity.Ptr, ppDefaultActivity)
    SetDefaultActivity(pActivity, hwnd1)
      => ComCall(5, this.p, IOpenServiceActivity, pActivity, HWND, hwnd1)
    GetName(pbstrName)
      => ComCall(6, this.p, BSTR.Ptr, pbstrName)
    GetActivityEnumerator(pInput, pOutput, ppEnumActivity)
      => ComCall(7, this.p, IOpenServiceActivityInput, pInput, IOpenServiceActivityOutputContext, pOutput, IEnumOpenServiceActivity.Ptr, ppEnumActivity)
}
struct IEnumOpenServiceActivityCategory extends IUnknown {
    static IID := "{33627A56-8C9A-4430-8FD1-B5F5C771AFB6}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IOpenServiceActivityCategory.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumOpenServiceActivityCategory.Ptr, ppenum)
}
struct IOpenServiceActivityManager extends IUnknown {
    static IID := "{8A2D0A9D-E920-4BDC-A291-D30F650BC4F1}"
    GetCategoryEnumerator(eType, ppEnum)
      => ComCall(3, this.p, OpenServiceActivityContentType, eType, IEnumOpenServiceActivityCategory.Ptr, ppEnum)
    GetActivityByID(pwzActivityID, ppActivity)
      => ComCall(4, this.p, "Str", pwzActivityID, IOpenServiceActivity.Ptr, ppActivity)
    GetActivityByHomepageAndCategory(pwzHomepage, pwzCategory, ppActivity)
      => ComCall(5, this.p, "Str", pwzHomepage, "Str", pwzCategory, IOpenServiceActivity.Ptr, ppActivity)
    GetVersionCookie(pdwVersionCookie)
      => ComCall(6, this.p, UInt32.Ptr, pdwVersionCookie)
}
struct IPersistHistory extends IPersist {
    static IID := "{91A565C1-E38F-11D0-94BF-00A0C9055CBF}"
    LoadHistory(pStream, pbc)
      => ComCall(4, this.p, IStream, pStream, IBindCtx, pbc)
    SaveHistory(pStream)
      => ComCall(5, this.p, IStream, pStream)
    SetPositionCookie(dwPositioncookie)
      => ComCall(6, this.p, UInt32, dwPositioncookie)
    GetPositionCookie(pdwPositioncookie)
      => ComCall(7, this.p, UInt32.Ptr, pdwPositioncookie)
}
struct ADDURL_FLAG extends Int32 {
    static ADDURL_FIRST := 0
    static ADDURL_ADDTOHISTORYANDCACHE := 0
    static ADDURL_ADDTOCACHE := 1
    static ADDURL_Max := 2147483647
}
struct STATURL {
    cbSize : UInt32 := this.Size
    pwcsUrl : PWSTR
    pwcsTitle : PWSTR
    ftLastVisited : FILETIME
    ftLastUpdated : FILETIME
    ftExpires : FILETIME
    dwFlags : UInt32
}
struct IEnumSTATURL extends IUnknown {
    static IID := "{3C374A42-BAE4-11CF-BF7D-00AA006946EE}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, STATURL.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSTATURL.Ptr, ppenum)
    SetFilter(poszFilter, dwFlags)
      => ComCall(7, this.p, "Str", poszFilter, UInt32, dwFlags)
}
struct IUrlHistoryStg extends IUnknown {
    static IID := "{3C374A41-BAE4-11CF-BF7D-00AA006946EE}"
    AddUrl(pocsUrl, pocsTitle, dwFlags)
      => ComCall(3, this.p, "Str", pocsUrl, "Str", pocsTitle, UInt32, dwFlags)
    DeleteUrl(pocsUrl, dwFlags)
      => ComCall(4, this.p, "Str", pocsUrl, UInt32, dwFlags)
    QueryUrl(pocsUrl, dwFlags, lpSTATURL)
      => ComCall(5, this.p, "Str", pocsUrl, UInt32, dwFlags, STATURL.Ptr, lpSTATURL)
    BindToObject(pocsUrl, riid, ppvOut)
      => ComCall(6, this.p, "Str", pocsUrl, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvOut)
    EnumUrls(ppEnum)
      => ComCall(7, this.p, IEnumSTATURL.Ptr, ppEnum)
}
struct IUrlHistoryStg2 extends IUrlHistoryStg {
    static IID := "{AFA0DC11-C313-11D0-831A-00C04FD5AE38}"
    AddUrlAndNotify(pocsUrl, pocsTitle, dwFlags, fWriteHistory, poctNotify, punkISFolder)
      => ComCall(8, this.p, "Str", pocsUrl, "Str", pocsTitle, UInt32, dwFlags, BOOL, fWriteHistory, IOleCommandTarget, poctNotify, IUnknown, punkISFolder)
    ClearHistory()
      => ComCall(9, this.p)
}
struct IUrlHistoryNotify extends IOleCommandTarget {
    static IID := "{BC40BEC1-C493-11D0-831B-00C04FD5AE38}"
}
struct IWebBrowserEventsService extends IUnknown {
    static IID := "{54A8F188-9EBD-4795-AD16-9B4945119636}"
    FireBeforeNavigate2Event(pfCancel)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pfCancel)
    FireNavigateComplete2Event()
      => ComCall(4, this.p)
    FireDownloadBeginEvent()
      => ComCall(5, this.p)
    FireDownloadCompleteEvent()
      => ComCall(6, this.p)
    FireDocumentCompleteEvent()
      => ComCall(7, this.p)
}
struct IWebBrowserEventsUrlService extends IUnknown {
    static IID := "{87CC5D04-EAFA-4833-9820-8F986530CC00}"
    GetUrlForEvents(pUrl)
      => ComCall(3, this.p, BSTR.Ptr, pUrl)
}
struct ITimerService extends IUnknown {
    static IID := "{3050F35F-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateTimer(pReferenceTimer, ppNewTimer)
      => ComCall(3, this.p, ITimer, pReferenceTimer, ITimer.Ptr, ppNewTimer)
    GetNamedTimer(rguidName, ppTimer)
      => ComCall(4, this.p, GUID.Ptr, rguidName, ITimer.Ptr, ppTimer)
    SetNamedTimerReference(rguidName, pReferenceTimer)
      => ComCall(5, this.p, GUID.Ptr, rguidName, ITimer, pReferenceTimer)
}
struct ITimer extends IUnknown {
    static IID := "{3050F360-98B5-11CF-BB82-00AA00BDCE0B}"
    Advise(vtimeMin, vtimeMax, vtimeInterval, dwFlags, pTimerSink, pdwCookie)
      => ComCall(3, this.p, VARIANT, vtimeMin, VARIANT, vtimeMax, VARIANT, vtimeInterval, UInt32, dwFlags, ITimerSink, pTimerSink, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    Freeze(fFreeze)
      => ComCall(5, this.p, BOOL, fFreeze)
    GetTime(pvtime)
      => ComCall(6, this.p, VARIANT.Ptr, pvtime)
}
struct ITimerEx extends ITimer {
    static IID := "{30510414-98B5-11CF-BB82-00AA00BDCE0B}"
    SetMode(dwMode)
      => ComCall(7, this.p, UInt32, dwMode)
}
struct ITimerSink extends IUnknown {
    static IID := "{3050F361-98B5-11CF-BB82-00AA00BDCE0B}"
    OnTimer(vtimeAdvise)
      => ComCall(3, this.p, VARIANT, vtimeAdvise)
}
struct IMapMIMEToCLSID extends IUnknown {
    static IID := "{D9E89500-30FA-11D0-B724-00AA006C1A01}"
    EnableDefaultMappings(bEnable)
      => ComCall(3, this.p, BOOL, bEnable)
    MapMIMEToCLSID(pszMIMEType, pCLSID)
      => ComCall(4, this.p, "Str", pszMIMEType, GUID.Ptr, pCLSID)
    SetMapping(pszMIMEType, dwMapMode, clsid)
      => ComCall(5, this.p, "Str", pszMIMEType, UInt32, dwMapMode, GUID.Ptr, clsid)
}
struct IImageDecodeFilter extends IUnknown {
    static IID := "{A3CCEDF3-2DE2-11D0-86F4-00A0C913F750}"
    Initialize(pEventSink?)
      => ComCall(3, this.p, IImageDecodeEventSink, pEventSink?)
    Process(pStream?)
      => ComCall(4, this.p, IStream, pStream?)
    Terminate(hrStatus)
      => ComCall(5, this.p, HRESULT, hrStatus)
}
struct IImageDecodeEventSink extends IUnknown {
    static IID := "{BAA342A0-2DED-11D0-86F4-00A0C913F750}"
    GetSurface(nWidth, nHeight, bfid, nPasses, dwHints, ppSurface)
      => ComCall(3, this.p, Int32, nWidth, Int32, nHeight, GUID.Ptr, bfid, UInt32, nPasses, UInt32, dwHints, IUnknown.Ptr, ppSurface)
    OnBeginDecode(pdwEvents, ppFormats)
      => ComCall(4, this.p, UInt32.Ptr, pdwEvents, UInt32.Ptr, ppFormats.Length, GUID.Ptr.Ptr, ppFormats)
    OnBitsComplete()
      => ComCall(5, this.p)
    OnDecodeComplete(hrStatus)
      => ComCall(6, this.p, HRESULT, hrStatus)
    OnPalette()
      => ComCall(7, this.p)
    OnProgress(pBounds, bComplete)
      => ComCall(8, this.p, RECT.Ptr, pBounds, BOOL, bComplete)
}
struct IImageDecodeEventSink2 extends IImageDecodeEventSink {
    static IID := "{8EBD8A57-8A96-48C9-84A6-962E2DB9C931}"
    IsAlphaPremultRequired(pfPremultAlpha)
      => ComCall(9, this.p, BOOL.Ptr, pfPremultAlpha)
}
struct ISniffStream extends IUnknown {
    static IID := "{4EF17940-30E0-11D0-B724-00AA006C1A01}"
    Init(pStream)
      => ComCall(3, this.p, IStream, pStream)
    Peek(pBuffer, nBytes, pnBytesRead)
      => ComCall(4, this.p, Struct.Ptr, pBuffer, UInt32, nBytes, UInt32.Ptr, pnBytesRead)
}
struct IDithererImpl extends IUnknown {
    static IID := "{7C48E840-3910-11D0-86FC-00A0C913F750}"
    SetDestColorTable(nColors, prgbColors)
      => ComCall(3, this.p, UInt32, nColors, RGBQUAD.Ptr, prgbColors)
    SetEventSink(pEventSink)
      => ComCall(4, this.p, IImageDecodeEventSink, pEventSink)
}
