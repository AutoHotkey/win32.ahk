#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {IServiceProvider, IUnknown}
#Import "..\System.Diagnostics.Debug.ActiveScript\Types.ahk" {IActiveScriptError}
#Import "..\Web.MsHtml\Types.ahk" {IHTMLDocument2, IHTMLWindow2}

struct IWebApplicationScriptEvents extends IUnknown {
    static IID := "{7C3F6998-1567-4BBA-B52B-48D32141D613}"
    BeforeScriptExecute(htmlWindow)
      => ComCall(3, this.p, IHTMLWindow2, htmlWindow)
    ScriptError(htmlWindow?, scriptError, url, errorHandled)
      => ComCall(4, this.p, IHTMLWindow2, htmlWindow?, IActiveScriptError, scriptError, "Str", url, BOOL, errorHandled)
}
struct IWebApplicationNavigationEvents extends IUnknown {
    static IID := "{C22615D2-D318-4DA2-8422-1FCAF77B10E4}"
    BeforeNavigate(htmlWindow, url, navigationFlags, targetFrameName?)
      => ComCall(3, this.p, IHTMLWindow2, htmlWindow, "Str", url, UInt32, navigationFlags, "Str", targetFrameName?)
    NavigateComplete(htmlWindow, url)
      => ComCall(4, this.p, IHTMLWindow2, htmlWindow, "Str", url)
    NavigateError(htmlWindow, url, targetFrameName?, statusCode)
      => ComCall(5, this.p, IHTMLWindow2, htmlWindow, "Str", url, "Str", targetFrameName?, UInt32, statusCode)
    DocumentComplete(htmlWindow, url)
      => ComCall(6, this.p, IHTMLWindow2, htmlWindow, "Str", url)
    DownloadBegin()
      => ComCall(7, this.p)
    DownloadComplete()
      => ComCall(8, this.p)
}
struct IWebApplicationUIEvents extends IUnknown {
    static IID := "{5B2B3F99-328C-41D5-A6F7-7483ED8E71DD}"
    SecurityProblem(securityProblem, result)
      => ComCall(3, this.p, UInt32, securityProblem, HRESULT.Ptr, result)
}
struct IWebApplicationUpdateEvents extends IUnknown {
    static IID := "{3E59E6B7-C652-4DAF-AD5E-16FEB350CDE3}"
    OnPaint()
      => ComCall(3, this.p)
    OnCssChanged()
      => ComCall(4, this.p)
}
struct IWebApplicationHost extends IUnknown {
    static IID := "{CECBD2C3-A3A5-4749-9681-20E9161C6794}"
    get_HWND(hwnd)
      => ComCall(3, this.p, HWND.Ptr, hwnd)
    get_Document(htmlDocument)
      => ComCall(4, this.p, IHTMLDocument2.Ptr, htmlDocument)
    Refresh()
      => ComCall(5, this.p)
    Advise(interfaceId, callback, cookie)
      => ComCall(6, this.p, GUID.Ptr, interfaceId, IUnknown, callback, UInt32.Ptr, cookie)
    Unadvise(cookie)
      => ComCall(7, this.p, UInt32, cookie)
}
struct IWebApplicationActivation extends IUnknown {
    static IID := "{BCDCD0DE-330E-481B-B843-4898A6A8EBAC}"
    CancelPendingActivation()
      => ComCall(3, this.p)
}
struct IWebApplicationAuthoringMode extends IServiceProvider {
    static IID := "{720AEA93-1964-4DB0-B005-29EB9E2B18A9}"
    get_AuthoringClientBinary(designModeDllPath)
      => ComCall(4, this.p, BSTR.Ptr, designModeDllPath)
}
struct RegisterAuthoringClientFunctionType extends FunctionPointer {
    static Types := [IWebApplicationAuthoringMode, IWebApplicationHost, HRESULT]
}
struct UnregisterAuthoringClientFunctionType extends FunctionPointer {
    static Types := [IWebApplicationHost, HRESULT]
}
