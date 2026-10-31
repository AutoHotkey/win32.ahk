#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLElement}
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, PWSTR}
#Import "..\Media.DirectShow\Types.ahk" {IGraphBuilder}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IXMLGraphBuilder extends IUnknown {
    static IID := "{1BB05960-5FBF-11D2-A521-44DF07C10000}"
    BuildFromXML(pGraph, pxml)
      => ComCall(3, this.p, IGraphBuilder, pGraph, IXMLElement, pxml)
    SaveToXML(pGraph, pbstrxml)
      => ComCall(4, this.p, IGraphBuilder, pGraph, BSTR.Ptr, pbstrxml)
    BuildFromXMLFile(pGraph, wszFileName, wszBaseURL)
      => ComCall(5, this.p, IGraphBuilder, pGraph, "Str", wszFileName, "Str", wszBaseURL)
}
