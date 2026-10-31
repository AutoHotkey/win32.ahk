#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMNodeList}
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, HWND, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Accessibility\Types.ahk" {IAccessible}

struct WINSAT_OEM_CUSTOMIZATION_STATE extends Int32 {
    static WINSAT_OEM_DATA_VALID := 0
    static WINSAT_OEM_DATA_NON_SYS_CONFIG_MATCH := 1
    static WINSAT_OEM_DATA_INVALID := 2
    static WINSAT_OEM_NO_DATA_SUPPLIED := 3
}
struct WINSAT_ASSESSMENT_STATE extends Int32 {
    static WINSAT_ASSESSMENT_STATE_MIN := 0
    static WINSAT_ASSESSMENT_STATE_UNKNOWN := 0
    static WINSAT_ASSESSMENT_STATE_VALID := 1
    static WINSAT_ASSESSMENT_STATE_INCOHERENT_WITH_HARDWARE := 2
    static WINSAT_ASSESSMENT_STATE_NOT_AVAILABLE := 3
    static WINSAT_ASSESSMENT_STATE_INVALID := 4
    static WINSAT_ASSESSMENT_STATE_MAX := 4
}
struct WINSAT_ASSESSMENT_TYPE extends Int32 {
    static WINSAT_ASSESSMENT_MEMORY := 0
    static WINSAT_ASSESSMENT_CPU := 1
    static WINSAT_ASSESSMENT_DISK := 2
    static WINSAT_ASSESSMENT_D3D := 3
    static WINSAT_ASSESSMENT_GRAPHICS := 4
}
struct WINSAT_BITMAP_SIZE extends Int32 {
    static WINSAT_BITMAP_SIZE_SMALL := 0
    static WINSAT_BITMAP_SIZE_NORMAL := 1
}
struct IProvideWinSATAssessmentInfo extends IDispatch {
    static IID := "{0CD1C380-52D3-4678-AC6F-E929E480BE9E}"
    get_Score(score)
      => ComCall(7, this.p, Float32.Ptr, score)
    get_Title(title)
      => ComCall(8, this.p, BSTR.Ptr, title)
    get_Description(description)
      => ComCall(9, this.p, BSTR.Ptr, description)
}
struct IProvideWinSATResultsInfo extends IDispatch {
    static IID := "{F8334D5D-568E-4075-875F-9DF341506640}"
    GetAssessmentInfo(assessment, ppinfo)
      => ComCall(7, this.p, WINSAT_ASSESSMENT_TYPE, assessment, IProvideWinSATAssessmentInfo.Ptr, ppinfo)
    get_AssessmentState(state)
      => ComCall(8, this.p, WINSAT_ASSESSMENT_STATE.Ptr, state)
    get_AssessmentDateTime(fileTime)
      => ComCall(9, this.p, VARIANT.Ptr, fileTime)
    get_SystemRating(level)
      => ComCall(10, this.p, Float32.Ptr, level)
    get_RatingStateDesc(description)
      => ComCall(11, this.p, BSTR.Ptr, description)
}
struct IQueryRecentWinSATAssessment extends IDispatch {
    static IID := "{F8AD5D1F-3B47-4BDC-9375-7C6B1DA4ECA7}"
    get_XML(xPath, namespaces, ppDomNodeList)
      => ComCall(7, this.p, BSTR, xPath, BSTR, namespaces, IXMLDOMNodeList.Ptr, ppDomNodeList)
    get_Info(ppWinSATAssessmentInfo)
      => ComCall(8, this.p, IProvideWinSATResultsInfo.Ptr, ppWinSATAssessmentInfo)
}
struct IProvideWinSATVisuals extends IUnknown {
    static IID := "{A9F4ADE0-871A-42A3-B813-3078D25162C9}"
    get_Bitmap(bitmapSize, state, rating, pBitmap)
      => ComCall(3, this.p, WINSAT_BITMAP_SIZE, bitmapSize, WINSAT_ASSESSMENT_STATE, state, Float32, rating, HBITMAP.Ptr, pBitmap)
}
struct IQueryAllWinSATAssessments extends IDispatch {
    static IID := "{0B89ED1D-6398-4FEA-87FC-567D8D19176F}"
    get_AllXML(xPath, namespaces, ppDomNodeList)
      => ComCall(7, this.p, BSTR, xPath, BSTR, namespaces, IXMLDOMNodeList.Ptr, ppDomNodeList)
}
struct IWinSATInitiateEvents extends IUnknown {
    static IID := "{262A1918-BA0D-41D5-92C2-FAB4633EE74F}"
    WinSATComplete(hresult1, strDescription)
      => ComCall(3, this.p, HRESULT, hresult1, "Str", strDescription)
    WinSATUpdate(uCurrentTick, uTickTotal, strCurrentState)
      => ComCall(4, this.p, UInt32, uCurrentTick, UInt32, uTickTotal, "Str", strCurrentState)
}
struct IInitiateWinSATAssessment extends IUnknown {
    static IID := "{D983FC50-F5BF-49D5-B5ED-CCCB18AA7FC1}"
    InitiateAssessment(cmdLine, pCallbacks?, callerHwnd?)
      => ComCall(3, this.p, "Str", cmdLine, IWinSATInitiateEvents, pCallbacks?, HWND, callerHwnd?)
    InitiateFormalAssessment(pCallbacks?, callerHwnd?)
      => ComCall(4, this.p, IWinSATInitiateEvents, pCallbacks?, HWND, callerHwnd?)
    CancelAssessment()
      => ComCall(5, this.p)
}
struct IAccessibleWinSAT extends IAccessible {
    static IID := "{30E6018A-94A8-4FF8-A69A-71B67413F07B}"
    SetAccessiblityData(wsName, wsValue, wsDesc)
      => ComCall(28, this.p, "Str", wsName, "Str", wsValue, "Str", wsDesc)
}
struct IQueryOEMWinSATCustomization extends IUnknown {
    static IID := "{BC9A6A9F-AD4E-420E-9953-B34671E9DF22}"
    GetOEMPrePopulationInfo(state)
      => ComCall(3, this.p, WINSAT_OEM_CUSTOMIZATION_STATE.Ptr, state)
}
