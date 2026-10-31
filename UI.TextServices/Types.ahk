#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, COLORREF, HRESULT, HWND, LPARAM, POINT, PWSTR, RECT, SIZE, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\System.Com\Types.ahk" {FORMATETC, IDataObject, IEnumGUID, IEnumString, IEnumUnknown, IStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Input.KeyboardAndMouse\Types.ahk" {HKL}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON, MSG}

struct LANG_BAR_ITEM_ICON_MODE_FLAGS extends UInt32 {
    static TF_DTLBI_NONE := 0
    static TF_DTLBI_USEPROFILEICON := 1
}
struct TEXT_STORE_TEXT_CHANGE_FLAGS extends UInt32 {
    static TS_ST_NONE := 0
    static TS_ST_CORRECTION := 1
}
struct TEXT_STORE_CHANGE_FLAGS extends UInt32 {
    static TS_TC_NONE := 0
    static TS_TC_CORRECTION := 1
}
struct INSERT_TEXT_AT_SELECTION_FLAGS extends UInt32 {
    static TF_IAS_NOQUERY := 1
    static TF_IAS_QUERYONLY := 2
    static TF_IAS_NO_DEFAULT_COMPOSITION := 2147483648
}
struct ANCHOR_CHANGE_HISTORY_FLAGS extends UInt32 {
    static TS_CH_PRECEDING_DEL := 1
    static TS_CH_FOLLOWING_DEL := 2
}
struct TEXT_STORE_LOCK_FLAGS extends UInt32 {
    static TS_LF_READ := 2
    static TS_LF_READWRITE := 6
}
struct GET_TEXT_AND_PROPERTY_UPDATES_FLAGS extends UInt32 {
    static TF_GTP_NONE := 0
    static TF_GTP_INCL_TEXT := 1
}
struct TF_CONTEXT_EDIT_CONTEXT_FLAGS extends UInt32 {
    static TF_ES_ASYNCDONTCARE := 0
    static TF_ES_SYNC := 1
    static TF_ES_READ := 2
    static TF_ES_READWRITE := 6
    static TF_ES_ASYNC := 8
}
struct TS_STATUS {
    dwDynamicFlags : UInt32
    dwStaticFlags : UInt32
}
struct TS_TEXTCHANGE {
    acpStart : Int32
    acpOldEnd : Int32
    acpNewEnd : Int32
}
struct TsActiveSelEnd extends Int32 {
    static TS_AE_NONE := 0
    static TS_AE_START := 1
    static TS_AE_END := 2
}
struct TS_SELECTIONSTYLE {
    ase : TsActiveSelEnd
    fInterimChar : BOOL
}
struct TS_SELECTION_ACP {
    acpStart : Int32
    acpEnd : Int32
    style : TS_SELECTIONSTYLE
}
struct TS_SELECTION_ANCHOR {
    paStart : IAnchor
    paEnd : IAnchor
    style : TS_SELECTIONSTYLE
}
struct TS_ATTRVAL {
    idAttr : GUID
    dwOverlapId : UInt32
    varValue : VARIANT
}
struct TsLayoutCode extends Int32 {
    static TS_LC_CREATE := 0
    static TS_LC_CHANGE := 1
    static TS_LC_DESTROY := 2
}
struct TsRunType extends Int32 {
    static TS_RT_PLAIN := 0
    static TS_RT_HIDDEN := 1
    static TS_RT_OPAQUE := 2
}
struct TS_RUNINFO {
    uCount : UInt32
    type : TsRunType
}
struct ITextStoreACP extends IUnknown {
    static IID := "{28888FE3-C2A0-483A-A3EA-8CB1CE51FF3D}"
    AdviseSink(riid, punk, dwMask)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk, UInt32, dwMask)
    UnadviseSink(punk)
      => ComCall(4, this.p, IUnknown, punk)
    RequestLock(dwLockFlags, phrSession)
      => ComCall(5, this.p, UInt32, dwLockFlags, HRESULT.Ptr, phrSession)
    GetStatus(pdcs)
      => ComCall(6, this.p, TS_STATUS.Ptr, pdcs)
    QueryInsert(acpTestStart, acpTestEnd, cch, pacpResultStart, pacpResultEnd)
      => ComCall(7, this.p, Int32, acpTestStart, Int32, acpTestEnd, UInt32, cch, Int32.Ptr, pacpResultStart, Int32.Ptr, pacpResultEnd)
    GetSelection(ulIndex, pSelection, pcFetched)
      => ComCall(8, this.p, UInt32, ulIndex, UInt32, pSelection.Length, TS_SELECTION_ACP.Ptr, pSelection, UInt32.Ptr, pcFetched)
    SetSelection(pSelection)
      => ComCall(9, this.p, UInt32, pSelection.Length, TS_SELECTION_ACP.Ptr, pSelection)
    GetText(acpStart, acpEnd, pchPlain, pcchPlainRet, prgRunInfo, pcRunInfoRet, pacpNext)
      => ComCall(10, this.p, Int32, acpStart, Int32, acpEnd, PWSTR, pchPlain, UInt32, pchPlain.Length, UInt32.Ptr, pcchPlainRet, TS_RUNINFO.Ptr, prgRunInfo, UInt32, prgRunInfo.Length, UInt32.Ptr, pcRunInfoRet, Int32.Ptr, pacpNext)
    SetText(dwFlags, acpStart, acpEnd, pchText, pChange)
      => ComCall(11, this.p, UInt32, dwFlags, Int32, acpStart, Int32, acpEnd, "Str", pchText, UInt32, pchText.Length, TS_TEXTCHANGE.Ptr, pChange)
    GetFormattedText(acpStart, acpEnd, ppDataObject)
      => ComCall(12, this.p, Int32, acpStart, Int32, acpEnd, IDataObject.Ptr, ppDataObject)
    GetEmbedded(acpPos, rguidService, riid, ppunk)
      => ComCall(13, this.p, Int32, acpPos, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    QueryInsertEmbedded(pguidService, pFormatEtc, pfInsertable)
      => ComCall(14, this.p, GUID.Ptr, pguidService, FORMATETC.Ptr, pFormatEtc, BOOL.Ptr, pfInsertable)
    InsertEmbedded(dwFlags, acpStart, acpEnd, pDataObject, pChange)
      => ComCall(15, this.p, UInt32, dwFlags, Int32, acpStart, Int32, acpEnd, IDataObject, pDataObject, TS_TEXTCHANGE.Ptr, pChange)
    InsertTextAtSelection(dwFlags, pchText, pacpStart, pacpEnd, pChange)
      => ComCall(16, this.p, UInt32, dwFlags, "Str", pchText, UInt32, pchText.Length, Int32.Ptr, pacpStart, Int32.Ptr, pacpEnd, TS_TEXTCHANGE.Ptr, pChange)
    InsertEmbeddedAtSelection(dwFlags, pDataObject, pacpStart, pacpEnd, pChange)
      => ComCall(17, this.p, UInt32, dwFlags, IDataObject, pDataObject, Int32.Ptr, pacpStart, Int32.Ptr, pacpEnd, TS_TEXTCHANGE.Ptr, pChange)
    RequestSupportedAttrs(dwFlags, paFilterAttrs)
      => ComCall(18, this.p, UInt32, dwFlags, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs)
    RequestAttrsAtPosition(acpPos, paFilterAttrs, dwFlags)
      => ComCall(19, this.p, Int32, acpPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    RequestAttrsTransitioningAtPosition(acpPos, paFilterAttrs, dwFlags)
      => ComCall(20, this.p, Int32, acpPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    FindNextAttrTransition(acpStart, acpHalt, paFilterAttrs, dwFlags, pacpNext, pfFound, plFoundOffset)
      => ComCall(21, this.p, Int32, acpStart, Int32, acpHalt, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags, Int32.Ptr, pacpNext, BOOL.Ptr, pfFound, Int32.Ptr, plFoundOffset)
    RetrieveRequestedAttrs(paAttrVals, pcFetched)
      => ComCall(22, this.p, UInt32, paAttrVals.Length, TS_ATTRVAL.Ptr, paAttrVals, UInt32.Ptr, pcFetched)
    GetEndACP(pacp)
      => ComCall(23, this.p, Int32.Ptr, pacp)
    GetActiveView(pvcView)
      => ComCall(24, this.p, UInt32.Ptr, pvcView)
    GetACPFromPoint(vcView, ptScreen, dwFlags, pacp)
      => ComCall(25, this.p, UInt32, vcView, POINT.Ptr, ptScreen, UInt32, dwFlags, Int32.Ptr, pacp)
    GetTextExt(vcView, acpStart, acpEnd, prc, pfClipped)
      => ComCall(26, this.p, UInt32, vcView, Int32, acpStart, Int32, acpEnd, RECT.Ptr, prc, BOOL.Ptr, pfClipped)
    GetScreenExt(vcView, prc)
      => ComCall(27, this.p, UInt32, vcView, RECT.Ptr, prc)
    GetWnd(vcView, phwnd)
      => ComCall(28, this.p, UInt32, vcView, HWND.Ptr, phwnd)
}
struct ITextStoreACP2 extends IUnknown {
    static IID := "{F86AD89F-5FE4-4B8D-BB9F-EF3797A84F1F}"
    AdviseSink(riid, punk, dwMask)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk, UInt32, dwMask)
    UnadviseSink(punk)
      => ComCall(4, this.p, IUnknown, punk)
    RequestLock(dwLockFlags, phrSession)
      => ComCall(5, this.p, UInt32, dwLockFlags, HRESULT.Ptr, phrSession)
    GetStatus(pdcs)
      => ComCall(6, this.p, TS_STATUS.Ptr, pdcs)
    QueryInsert(acpTestStart, acpTestEnd, cch, pacpResultStart, pacpResultEnd)
      => ComCall(7, this.p, Int32, acpTestStart, Int32, acpTestEnd, UInt32, cch, Int32.Ptr, pacpResultStart, Int32.Ptr, pacpResultEnd)
    GetSelection(ulIndex, pSelection, pcFetched)
      => ComCall(8, this.p, UInt32, ulIndex, UInt32, pSelection.Length, TS_SELECTION_ACP.Ptr, pSelection, UInt32.Ptr, pcFetched)
    SetSelection(pSelection)
      => ComCall(9, this.p, UInt32, pSelection.Length, TS_SELECTION_ACP.Ptr, pSelection)
    GetText(acpStart, acpEnd, pchPlain, pcchPlainRet, prgRunInfo, pcRunInfoRet, pacpNext)
      => ComCall(10, this.p, Int32, acpStart, Int32, acpEnd, PWSTR, pchPlain, UInt32, pchPlain.Length, UInt32.Ptr, pcchPlainRet, TS_RUNINFO.Ptr, prgRunInfo, UInt32, prgRunInfo.Length, UInt32.Ptr, pcRunInfoRet, Int32.Ptr, pacpNext)
    SetText(dwFlags, acpStart, acpEnd, pchText, pChange)
      => ComCall(11, this.p, UInt32, dwFlags, Int32, acpStart, Int32, acpEnd, "Str", pchText, UInt32, pchText.Length, TS_TEXTCHANGE.Ptr, pChange)
    GetFormattedText(acpStart, acpEnd, ppDataObject)
      => ComCall(12, this.p, Int32, acpStart, Int32, acpEnd, IDataObject.Ptr, ppDataObject)
    GetEmbedded(acpPos, rguidService, riid, ppunk)
      => ComCall(13, this.p, Int32, acpPos, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    QueryInsertEmbedded(pguidService, pFormatEtc, pfInsertable)
      => ComCall(14, this.p, GUID.Ptr, pguidService, FORMATETC.Ptr, pFormatEtc, BOOL.Ptr, pfInsertable)
    InsertEmbedded(dwFlags, acpStart, acpEnd, pDataObject, pChange)
      => ComCall(15, this.p, UInt32, dwFlags, Int32, acpStart, Int32, acpEnd, IDataObject, pDataObject, TS_TEXTCHANGE.Ptr, pChange)
    InsertTextAtSelection(dwFlags, pchText, pacpStart, pacpEnd, pChange)
      => ComCall(16, this.p, UInt32, dwFlags, "Str", pchText, UInt32, pchText.Length, Int32.Ptr, pacpStart, Int32.Ptr, pacpEnd, TS_TEXTCHANGE.Ptr, pChange)
    InsertEmbeddedAtSelection(dwFlags, pDataObject, pacpStart, pacpEnd, pChange)
      => ComCall(17, this.p, UInt32, dwFlags, IDataObject, pDataObject, Int32.Ptr, pacpStart, Int32.Ptr, pacpEnd, TS_TEXTCHANGE.Ptr, pChange)
    RequestSupportedAttrs(dwFlags, paFilterAttrs)
      => ComCall(18, this.p, UInt32, dwFlags, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs)
    RequestAttrsAtPosition(acpPos, paFilterAttrs, dwFlags)
      => ComCall(19, this.p, Int32, acpPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    RequestAttrsTransitioningAtPosition(acpPos, paFilterAttrs, dwFlags)
      => ComCall(20, this.p, Int32, acpPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    FindNextAttrTransition(acpStart, acpHalt, paFilterAttrs, dwFlags, pacpNext, pfFound, plFoundOffset)
      => ComCall(21, this.p, Int32, acpStart, Int32, acpHalt, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags, Int32.Ptr, pacpNext, BOOL.Ptr, pfFound, Int32.Ptr, plFoundOffset)
    RetrieveRequestedAttrs(paAttrVals, pcFetched)
      => ComCall(22, this.p, UInt32, paAttrVals.Length, TS_ATTRVAL.Ptr, paAttrVals, UInt32.Ptr, pcFetched)
    GetEndACP(pacp)
      => ComCall(23, this.p, Int32.Ptr, pacp)
    GetActiveView(pvcView)
      => ComCall(24, this.p, UInt32.Ptr, pvcView)
    GetACPFromPoint(vcView, ptScreen, dwFlags, pacp)
      => ComCall(25, this.p, UInt32, vcView, POINT.Ptr, ptScreen, UInt32, dwFlags, Int32.Ptr, pacp)
    GetTextExt(vcView, acpStart, acpEnd, prc, pfClipped)
      => ComCall(26, this.p, UInt32, vcView, Int32, acpStart, Int32, acpEnd, RECT.Ptr, prc, BOOL.Ptr, pfClipped)
    GetScreenExt(vcView, prc)
      => ComCall(27, this.p, UInt32, vcView, RECT.Ptr, prc)
}
struct ITextStoreACPSink extends IUnknown {
    static IID := "{22D44C94-A419-4542-A272-AE26093ECECF}"
    OnTextChange(dwFlags, pChange)
      => ComCall(3, this.p, TEXT_STORE_TEXT_CHANGE_FLAGS, dwFlags, TS_TEXTCHANGE.Ptr, pChange)
    OnSelectionChange()
      => ComCall(4, this.p)
    OnLayoutChange(lcode, vcView)
      => ComCall(5, this.p, TsLayoutCode, lcode, UInt32, vcView)
    OnStatusChange(dwFlags)
      => ComCall(6, this.p, UInt32, dwFlags)
    OnAttrsChange(acpStart, acpEnd, paAttrs)
      => ComCall(7, this.p, Int32, acpStart, Int32, acpEnd, UInt32, paAttrs.Length, GUID.Ptr, paAttrs)
    OnLockGranted(dwLockFlags)
      => ComCall(8, this.p, TEXT_STORE_LOCK_FLAGS, dwLockFlags)
    OnStartEditTransaction()
      => ComCall(9, this.p)
    OnEndEditTransaction()
      => ComCall(10, this.p)
}
struct TsGravity extends Int32 {
    static TS_GR_BACKWARD := 0
    static TS_GR_FORWARD := 1
}
struct TsShiftDir extends Int32 {
    static TS_SD_BACKWARD := 0
    static TS_SD_FORWARD := 1
}
struct IAnchor extends IUnknown {
    static IID := "{0FEB7E34-5A60-4356-8EF7-ABDEC2FF7CF8}"
    SetGravity(gravity)
      => ComCall(3, this.p, TsGravity, gravity)
    GetGravity(pgravity)
      => ComCall(4, this.p, TsGravity.Ptr, pgravity)
    IsEqual(paWith, pfEqual)
      => ComCall(5, this.p, IAnchor, paWith, BOOL.Ptr, pfEqual)
    Compare(paWith, plResult)
      => ComCall(6, this.p, IAnchor, paWith, Int32.Ptr, plResult)
    Shift(dwFlags, cchReq, pcch, paHaltAnchor)
      => ComCall(7, this.p, UInt32, dwFlags, Int32, cchReq, Int32.Ptr, pcch, IAnchor, paHaltAnchor)
    ShiftTo(paSite)
      => ComCall(8, this.p, IAnchor, paSite)
    ShiftRegion(dwFlags, dir, pfNoRegion)
      => ComCall(9, this.p, UInt32, dwFlags, TsShiftDir, dir, BOOL.Ptr, pfNoRegion)
    SetChangeHistoryMask(dwMask)
      => ComCall(10, this.p, UInt32, dwMask)
    GetChangeHistory(pdwHistory)
      => ComCall(11, this.p, ANCHOR_CHANGE_HISTORY_FLAGS.Ptr, pdwHistory)
    ClearChangeHistory()
      => ComCall(12, this.p)
    Clone(ppaClone)
      => ComCall(13, this.p, IAnchor.Ptr, ppaClone)
}
struct ITextStoreAnchor extends IUnknown {
    static IID := "{9B2077B0-5F18-4DEC-BEE9-3CC722F5DFE0}"
    AdviseSink(riid, punk, dwMask)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk, UInt32, dwMask)
    UnadviseSink(punk)
      => ComCall(4, this.p, IUnknown, punk)
    RequestLock(dwLockFlags, phrSession)
      => ComCall(5, this.p, UInt32, dwLockFlags, HRESULT.Ptr, phrSession)
    GetStatus(pdcs)
      => ComCall(6, this.p, TS_STATUS.Ptr, pdcs)
    QueryInsert(paTestStart, paTestEnd, cch, ppaResultStart, ppaResultEnd)
      => ComCall(7, this.p, IAnchor, paTestStart, IAnchor, paTestEnd, UInt32, cch, IAnchor.Ptr, ppaResultStart, IAnchor.Ptr, ppaResultEnd)
    GetSelection(ulIndex, pSelection, pcFetched)
      => ComCall(8, this.p, UInt32, ulIndex, UInt32, pSelection.Length, TS_SELECTION_ANCHOR.Ptr, pSelection, UInt32.Ptr, pcFetched)
    SetSelection(pSelection)
      => ComCall(9, this.p, UInt32, pSelection.Length, TS_SELECTION_ANCHOR.Ptr, pSelection)
    GetText(dwFlags, paStart, paEnd, pchText, pcch, fUpdateAnchor)
      => ComCall(10, this.p, UInt32, dwFlags, IAnchor, paStart, IAnchor, paEnd, PWSTR, pchText, UInt32, pchText.Length, UInt32.Ptr, pcch, BOOL, fUpdateAnchor)
    SetText(dwFlags, paStart, paEnd, pchText)
      => ComCall(11, this.p, UInt32, dwFlags, IAnchor, paStart, IAnchor, paEnd, "Str", pchText, UInt32, pchText.Length)
    GetFormattedText(paStart, paEnd, ppDataObject)
      => ComCall(12, this.p, IAnchor, paStart, IAnchor, paEnd, IDataObject.Ptr, ppDataObject)
    GetEmbedded(dwFlags, paPos, rguidService, riid, ppunk)
      => ComCall(13, this.p, UInt32, dwFlags, IAnchor, paPos, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    InsertEmbedded(dwFlags, paStart, paEnd, pDataObject)
      => ComCall(14, this.p, UInt32, dwFlags, IAnchor, paStart, IAnchor, paEnd, IDataObject, pDataObject)
    RequestSupportedAttrs(dwFlags, paFilterAttrs)
      => ComCall(15, this.p, UInt32, dwFlags, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs)
    RequestAttrsAtPosition(paPos, paFilterAttrs, dwFlags)
      => ComCall(16, this.p, IAnchor, paPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    RequestAttrsTransitioningAtPosition(paPos, paFilterAttrs, dwFlags)
      => ComCall(17, this.p, IAnchor, paPos, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags)
    FindNextAttrTransition(paStart, paHalt, paFilterAttrs, dwFlags, pfFound, plFoundOffset)
      => ComCall(18, this.p, IAnchor, paStart, IAnchor, paHalt, UInt32, paFilterAttrs.Length, GUID.Ptr, paFilterAttrs, UInt32, dwFlags, BOOL.Ptr, pfFound, Int32.Ptr, plFoundOffset)
    RetrieveRequestedAttrs(paAttrVals, pcFetched)
      => ComCall(19, this.p, UInt32, paAttrVals.Length, TS_ATTRVAL.Ptr, paAttrVals, UInt32.Ptr, pcFetched)
    GetStart(ppaStart)
      => ComCall(20, this.p, IAnchor.Ptr, ppaStart)
    GetEnd(ppaEnd)
      => ComCall(21, this.p, IAnchor.Ptr, ppaEnd)
    GetActiveView(pvcView)
      => ComCall(22, this.p, UInt32.Ptr, pvcView)
    GetAnchorFromPoint(vcView, ptScreen, dwFlags, ppaSite)
      => ComCall(23, this.p, UInt32, vcView, POINT.Ptr, ptScreen, UInt32, dwFlags, IAnchor.Ptr, ppaSite)
    GetTextExt(vcView, paStart, paEnd, prc, pfClipped)
      => ComCall(24, this.p, UInt32, vcView, IAnchor, paStart, IAnchor, paEnd, RECT.Ptr, prc, BOOL.Ptr, pfClipped)
    GetScreenExt(vcView, prc)
      => ComCall(25, this.p, UInt32, vcView, RECT.Ptr, prc)
    GetWnd(vcView, phwnd)
      => ComCall(26, this.p, UInt32, vcView, HWND.Ptr, phwnd)
    QueryInsertEmbedded(pguidService, pFormatEtc, pfInsertable)
      => ComCall(27, this.p, GUID.Ptr, pguidService, FORMATETC.Ptr, pFormatEtc, BOOL.Ptr, pfInsertable)
    InsertTextAtSelection(dwFlags, pchText, ppaStart, ppaEnd)
      => ComCall(28, this.p, UInt32, dwFlags, "Str", pchText, UInt32, pchText.Length, IAnchor.Ptr, ppaStart, IAnchor.Ptr, ppaEnd)
    InsertEmbeddedAtSelection(dwFlags, pDataObject, ppaStart, ppaEnd)
      => ComCall(29, this.p, UInt32, dwFlags, IDataObject, pDataObject, IAnchor.Ptr, ppaStart, IAnchor.Ptr, ppaEnd)
}
struct ITextStoreAnchorSink extends IUnknown {
    static IID := "{AA80E905-2021-11D2-93E0-0060B067B86E}"
    OnTextChange(dwFlags, paStart, paEnd)
      => ComCall(3, this.p, TEXT_STORE_CHANGE_FLAGS, dwFlags, IAnchor, paStart, IAnchor, paEnd)
    OnSelectionChange()
      => ComCall(4, this.p)
    OnLayoutChange(lcode, vcView)
      => ComCall(5, this.p, TsLayoutCode, lcode, UInt32, vcView)
    OnStatusChange(dwFlags)
      => ComCall(6, this.p, UInt32, dwFlags)
    OnAttrsChange(paStart, paEnd, paAttrs)
      => ComCall(7, this.p, IAnchor, paStart, IAnchor, paEnd, UInt32, paAttrs.Length, GUID.Ptr, paAttrs)
    OnLockGranted(dwLockFlags)
      => ComCall(8, this.p, TEXT_STORE_LOCK_FLAGS, dwLockFlags)
    OnStartEditTransaction()
      => ComCall(9, this.p)
    OnEndEditTransaction()
      => ComCall(10, this.p)
}
struct ITfLangBarMgr extends IUnknown {
    static IID := "{87955690-E627-11D2-8DDB-00105A2799B5}"
    AdviseEventSink(pSink, hwnd1, dwFlags, pdwCookie)
      => ComCall(3, this.p, ITfLangBarEventSink, pSink, HWND, hwnd1, UInt32, dwFlags, UInt32.Ptr, pdwCookie)
    UnadviseEventSink(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    GetThreadMarshalInterface(dwThreadId, dwType, riid, ppunk)
      => ComCall(5, this.p, UInt32, dwThreadId, UInt32, dwType, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    GetThreadLangBarItemMgr(dwThreadId, pplbi, pdwThreadid)
      => ComCall(6, this.p, UInt32, dwThreadId, ITfLangBarItemMgr.Ptr, pplbi, UInt32.Ptr, pdwThreadid)
    GetInputProcessorProfiles(dwThreadId, ppaip, pdwThreadid)
      => ComCall(7, this.p, UInt32, dwThreadId, ITfInputProcessorProfiles.Ptr, ppaip, UInt32.Ptr, pdwThreadid)
    RestoreLastFocus(pdwThreadId, fPrev)
      => ComCall(8, this.p, UInt32.Ptr, pdwThreadId, BOOL, fPrev)
    SetModalInput(pSink, dwThreadId, dwFlags)
      => ComCall(9, this.p, ITfLangBarEventSink, pSink, UInt32, dwThreadId, UInt32, dwFlags)
    ShowFloating(dwFlags)
      => ComCall(10, this.p, UInt32, dwFlags)
    GetShowFloatingStatus(pdwFlags)
      => ComCall(11, this.p, UInt32.Ptr, pdwFlags)
}
struct ITfLangBarEventSink extends IUnknown {
    static IID := "{18A4E900-E0AE-11D2-AFDD-00105A2799B5}"
    OnSetFocus(dwThreadId)
      => ComCall(3, this.p, UInt32, dwThreadId)
    OnThreadTerminate(dwThreadId)
      => ComCall(4, this.p, UInt32, dwThreadId)
    OnThreadItemChange(dwThreadId)
      => ComCall(5, this.p, UInt32, dwThreadId)
    OnModalInput(dwThreadId, uMsg, wParam1, lParam1)
      => ComCall(6, this.p, UInt32, dwThreadId, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
    ShowFloating(dwFlags)
      => ComCall(7, this.p, UInt32, dwFlags)
    GetItemFloatingRect(dwThreadId, rguid, prc)
      => ComCall(8, this.p, UInt32, dwThreadId, GUID.Ptr, rguid, RECT.Ptr, prc)
}
struct ITfLangBarItemSink extends IUnknown {
    static IID := "{57DBE1A0-DE25-11D2-AFDD-00105A2799B5}"
    OnUpdate(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
}
struct IEnumTfLangBarItems extends IUnknown {
    static IID := "{583F34D0-DE25-11D2-AFDD-00105A2799B5}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfLangBarItems.Ptr, ppEnum)
    Next(ppItem, pcFetched)
      => ComCall(4, this.p, UInt32, ppItem.Length, ITfLangBarItem.Ptr, ppItem, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct TF_LANGBARITEMINFO {
    clsidService : GUID
    guidItem : GUID
    dwStyle : UInt32
    ulSort : UInt32
    szDescription : UInt16[32]
}
struct ITfLangBarItemMgr extends IUnknown {
    static IID := "{BA468C55-9956-4FB1-A59D-52A7DD7CC6AA}"
    EnumItems(ppEnum)
      => ComCall(3, this.p, IEnumTfLangBarItems.Ptr, ppEnum)
    GetItem(rguid, ppItem)
      => ComCall(4, this.p, GUID.Ptr, rguid, ITfLangBarItem.Ptr, ppItem)
    AddItem(punk)
      => ComCall(5, this.p, ITfLangBarItem, punk)
    RemoveItem(punk)
      => ComCall(6, this.p, ITfLangBarItem, punk)
    AdviseItemSink(punk, pdwCookie, rguidItem)
      => ComCall(7, this.p, ITfLangBarItemSink, punk, UInt32.Ptr, pdwCookie, GUID.Ptr, rguidItem)
    UnadviseItemSink(dwCookie)
      => ComCall(8, this.p, UInt32, dwCookie)
    GetItemFloatingRect(dwThreadId, rguid, prc)
      => ComCall(9, this.p, UInt32, dwThreadId, GUID.Ptr, rguid, RECT.Ptr, prc)
    GetItemsStatus(prgguid, pdwStatus)
      => ComCall(10, this.p, UInt32, pdwStatus.Length, GUID.Ptr, prgguid, UInt32.Ptr, pdwStatus)
    GetItemNum(pulCount)
      => ComCall(11, this.p, UInt32.Ptr, pulCount)
    GetItems(ppItem, pInfo, pdwStatus, pcFetched)
      => ComCall(12, this.p, UInt32, pdwStatus.Length, ITfLangBarItem.Ptr, ppItem, TF_LANGBARITEMINFO.Ptr, pInfo, UInt32.Ptr, pdwStatus, UInt32.Ptr, pcFetched)
    AdviseItemsSink(ppunk, pguidItem, pdwCookie)
      => ComCall(13, this.p, UInt32, pdwCookie.Length, ITfLangBarItemSink.Ptr, ppunk, GUID.Ptr, pguidItem, UInt32.Ptr, pdwCookie)
    UnadviseItemsSink(pdwCookie)
      => ComCall(14, this.p, UInt32, pdwCookie.Length, UInt32.Ptr, pdwCookie)
}
struct ITfLangBarItem extends IUnknown {
    static IID := "{73540D69-EDEB-4EE9-96C9-23AA30B25916}"
    GetInfo(pInfo)
      => ComCall(3, this.p, TF_LANGBARITEMINFO.Ptr, pInfo)
    GetStatus(pdwStatus)
      => ComCall(4, this.p, UInt32.Ptr, pdwStatus)
    Show(fShow)
      => ComCall(5, this.p, BOOL, fShow)
    GetTooltipString(pbstrToolTip)
      => ComCall(6, this.p, BSTR.Ptr, pbstrToolTip)
}
struct ITfSystemLangBarItemSink extends IUnknown {
    static IID := "{1449D9AB-13CF-4687-AA3E-8D8B18574396}"
    InitMenu(pMenu)
      => ComCall(3, this.p, ITfMenu, pMenu)
    OnMenuSelect(wID)
      => ComCall(4, this.p, UInt32, wID)
}
struct ITfSystemLangBarItem extends IUnknown {
    static IID := "{1E13E9EC-6B33-4D4A-B5EB-8A92F029F356}"
    SetIcon(hIcon1)
      => ComCall(3, this.p, HICON, hIcon1)
    SetTooltipString(pchToolTip)
      => ComCall(4, this.p, "Str", pchToolTip, UInt32, pchToolTip.Length)
}
struct ITfSystemLangBarItemText extends IUnknown {
    static IID := "{5C4CE0E5-BA49-4B52-AC6B-3B397B4F701F}"
    SetItemText(pch)
      => ComCall(3, this.p, "Str", pch, UInt32, pch.Length)
    GetItemText(pbstrText)
      => ComCall(4, this.p, BSTR.Ptr, pbstrText)
}
struct ITfSystemDeviceTypeLangBarItem extends IUnknown {
    static IID := "{45672EB9-9059-46A2-838D-4530355F6A77}"
    SetIconMode(dwFlags)
      => ComCall(3, this.p, LANG_BAR_ITEM_ICON_MODE_FLAGS, dwFlags)
    GetIconMode(pdwFlags)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags)
}
struct TfLBIClick extends Int32 {
    static TF_LBI_CLK_RIGHT := 1
    static TF_LBI_CLK_LEFT := 2
}
struct ITfLangBarItemButton extends ITfLangBarItem {
    static IID := "{28C7F1D0-DE25-11D2-AFDD-00105A2799B5}"
    OnClick(click, pt, prcArea)
      => ComCall(7, this.p, TfLBIClick, click, POINT, pt, RECT.Ptr, prcArea)
    InitMenu(pMenu)
      => ComCall(8, this.p, ITfMenu, pMenu)
    OnMenuSelect(wID)
      => ComCall(9, this.p, UInt32, wID)
    GetIcon(phIcon)
      => ComCall(10, this.p, HICON.Ptr, phIcon)
    GetText(pbstrText)
      => ComCall(11, this.p, BSTR.Ptr, pbstrText)
}
struct ITfLangBarItemBitmapButton extends ITfLangBarItem {
    static IID := "{A26A0525-3FAE-4FA0-89EE-88A964F9F1B5}"
    OnClick(click, pt, prcArea)
      => ComCall(7, this.p, TfLBIClick, click, POINT, pt, RECT.Ptr, prcArea)
    InitMenu(pMenu)
      => ComCall(8, this.p, ITfMenu, pMenu)
    OnMenuSelect(wID)
      => ComCall(9, this.p, UInt32, wID)
    GetPreferredSize(pszDefault, psz)
      => ComCall(10, this.p, SIZE.Ptr, pszDefault, SIZE.Ptr, psz)
    DrawBitmap(bmWidth, bmHeight, dwFlags, phbmp, phbmpMask)
      => ComCall(11, this.p, Int32, bmWidth, Int32, bmHeight, UInt32, dwFlags, HBITMAP.Ptr, phbmp, HBITMAP.Ptr, phbmpMask)
    GetText(pbstrText)
      => ComCall(12, this.p, BSTR.Ptr, pbstrText)
}
struct ITfLangBarItemBitmap extends ITfLangBarItem {
    static IID := "{73830352-D722-4179-ADA5-F045C98DF355}"
    OnClick(click, pt, prcArea)
      => ComCall(7, this.p, TfLBIClick, click, POINT, pt, RECT.Ptr, prcArea)
    GetPreferredSize(pszDefault, psz)
      => ComCall(8, this.p, SIZE.Ptr, pszDefault, SIZE.Ptr, psz)
    DrawBitmap(bmWidth, bmHeight, dwFlags, phbmp, phbmpMask)
      => ComCall(9, this.p, Int32, bmWidth, Int32, bmHeight, UInt32, dwFlags, HBITMAP.Ptr, phbmp, HBITMAP.Ptr, phbmpMask)
}
struct TfLBBalloonStyle extends Int32 {
    static TF_LB_BALLOON_RECO := 0
    static TF_LB_BALLOON_SHOW := 1
    static TF_LB_BALLOON_MISS := 2
}
struct TF_LBBALLOONINFO {
    style : TfLBBalloonStyle
    bstrText : BSTR
}
struct ITfLangBarItemBalloon extends ITfLangBarItem {
    static IID := "{01C2D285-D3C7-4B7B-B5B5-D97411D0C283}"
    OnClick(click, pt, prcArea)
      => ComCall(7, this.p, TfLBIClick, click, POINT, pt, RECT.Ptr, prcArea)
    GetPreferredSize(pszDefault, psz)
      => ComCall(8, this.p, SIZE.Ptr, pszDefault, SIZE.Ptr, psz)
    GetBalloonInfo(pInfo)
      => ComCall(9, this.p, TF_LBBALLOONINFO.Ptr, pInfo)
}
struct ITfMenu extends IUnknown {
    static IID := "{6F8A98E4-AAA0-4F15-8C5B-07E0DF0A3DD8}"
    AddMenuItem(uId, dwFlags, hbmp, hbmpMask, pch, ppMenu)
      => ComCall(3, this.p, UInt32, uId, UInt32, dwFlags, HBITMAP, hbmp, HBITMAP, hbmpMask, "Str", pch, UInt32, pch.Length, ITfMenu.Ptr, ppMenu)
}
struct TF_PERSISTENT_PROPERTY_HEADER_ACP {
    guidType : GUID
    ichStart : Int32
    cch : Int32
    cb : UInt32
    dwPrivate : UInt32
    clsidTIP : GUID
}
struct TF_LANGUAGEPROFILE {
    clsid : GUID
    langid : UInt16
    catid : GUID
    fActive : BOOL
    guidProfile : GUID
}
struct TfAnchor extends Int32 {
    static TF_ANCHOR_START := 0
    static TF_ANCHOR_END := 1
}
struct ITfThreadMgr extends IUnknown {
    static IID := "{AA80E801-2021-11D2-93E0-0060B067B86E}"
    Activate(ptid)
      => ComCall(3, this.p, UInt32.Ptr, ptid)
    Deactivate()
      => ComCall(4, this.p)
    CreateDocumentMgr(ppdim)
      => ComCall(5, this.p, ITfDocumentMgr.Ptr, ppdim)
    EnumDocumentMgrs(ppEnum)
      => ComCall(6, this.p, IEnumTfDocumentMgrs.Ptr, ppEnum)
    GetFocus(ppdimFocus)
      => ComCall(7, this.p, ITfDocumentMgr.Ptr, ppdimFocus)
    SetFocus(pdimFocus)
      => ComCall(8, this.p, ITfDocumentMgr, pdimFocus)
    AssociateFocus(hwnd1, pdimNew, ppdimPrev)
      => ComCall(9, this.p, HWND, hwnd1, ITfDocumentMgr, pdimNew, ITfDocumentMgr.Ptr, ppdimPrev)
    IsThreadFocus(pfThreadFocus)
      => ComCall(10, this.p, BOOL.Ptr, pfThreadFocus)
    GetFunctionProvider(clsid, ppFuncProv)
      => ComCall(11, this.p, GUID.Ptr, clsid, ITfFunctionProvider.Ptr, ppFuncProv)
    EnumFunctionProviders(ppEnum)
      => ComCall(12, this.p, IEnumTfFunctionProviders.Ptr, ppEnum)
    GetGlobalCompartment(ppCompMgr)
      => ComCall(13, this.p, ITfCompartmentMgr.Ptr, ppCompMgr)
}
struct ITfThreadMgrEx extends ITfThreadMgr {
    static IID := "{3E90ADE3-7594-4CB0-BB58-69628F5F458C}"
    ActivateEx(ptid, dwFlags)
      => ComCall(14, this.p, UInt32.Ptr, ptid, UInt32, dwFlags)
    GetActiveFlags(lpdwFlags)
      => ComCall(15, this.p, UInt32.Ptr, lpdwFlags)
}
struct ITfThreadMgr2 extends IUnknown {
    static IID := "{0AB198EF-6477-4EE8-8812-6780EDB82D5E}"
    Activate(ptid)
      => ComCall(3, this.p, UInt32.Ptr, ptid)
    Deactivate()
      => ComCall(4, this.p)
    CreateDocumentMgr(ppdim)
      => ComCall(5, this.p, ITfDocumentMgr.Ptr, ppdim)
    EnumDocumentMgrs(ppEnum)
      => ComCall(6, this.p, IEnumTfDocumentMgrs.Ptr, ppEnum)
    GetFocus(ppdimFocus)
      => ComCall(7, this.p, ITfDocumentMgr.Ptr, ppdimFocus)
    SetFocus(pdimFocus)
      => ComCall(8, this.p, ITfDocumentMgr, pdimFocus)
    IsThreadFocus(pfThreadFocus)
      => ComCall(9, this.p, BOOL.Ptr, pfThreadFocus)
    GetFunctionProvider(clsid, ppFuncProv)
      => ComCall(10, this.p, GUID.Ptr, clsid, ITfFunctionProvider.Ptr, ppFuncProv)
    EnumFunctionProviders(ppEnum)
      => ComCall(11, this.p, IEnumTfFunctionProviders.Ptr, ppEnum)
    GetGlobalCompartment(ppCompMgr)
      => ComCall(12, this.p, ITfCompartmentMgr.Ptr, ppCompMgr)
    ActivateEx(ptid, dwFlags)
      => ComCall(13, this.p, UInt32.Ptr, ptid, UInt32, dwFlags)
    GetActiveFlags(lpdwFlags)
      => ComCall(14, this.p, UInt32.Ptr, lpdwFlags)
    SuspendKeystrokeHandling()
      => ComCall(15, this.p)
    ResumeKeystrokeHandling()
      => ComCall(16, this.p)
}
struct ITfThreadMgrEventSink extends IUnknown {
    static IID := "{AA80E80E-2021-11D2-93E0-0060B067B86E}"
    OnInitDocumentMgr(pdim)
      => ComCall(3, this.p, ITfDocumentMgr, pdim)
    OnUninitDocumentMgr(pdim)
      => ComCall(4, this.p, ITfDocumentMgr, pdim)
    OnSetFocus(pdimFocus, pdimPrevFocus)
      => ComCall(5, this.p, ITfDocumentMgr, pdimFocus, ITfDocumentMgr, pdimPrevFocus)
    OnPushContext(pic)
      => ComCall(6, this.p, ITfContext, pic)
    OnPopContext(pic)
      => ComCall(7, this.p, ITfContext, pic)
}
struct ITfConfigureSystemKeystrokeFeed extends IUnknown {
    static IID := "{0D2C969A-BC9C-437C-84EE-951C49B1A764}"
    DisableSystemKeystrokeFeed()
      => ComCall(3, this.p)
    EnableSystemKeystrokeFeed()
      => ComCall(4, this.p)
}
struct IEnumTfDocumentMgrs extends IUnknown {
    static IID := "{AA80E808-2021-11D2-93E0-0060B067B86E}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfDocumentMgrs.Ptr, ppEnum)
    Next(rgDocumentMgr, pcFetched)
      => ComCall(4, this.p, UInt32, rgDocumentMgr.Length, ITfDocumentMgr.Ptr, rgDocumentMgr, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfDocumentMgr extends IUnknown {
    static IID := "{AA80E7F4-2021-11D2-93E0-0060B067B86E}"
    CreateContext(tidOwner, dwFlags, punk, ppic, pecTextStore)
      => ComCall(3, this.p, UInt32, tidOwner, UInt32, dwFlags, IUnknown, punk, ITfContext.Ptr, ppic, UInt32.Ptr, pecTextStore)
    Push(pic)
      => ComCall(4, this.p, ITfContext, pic)
    Pop(dwFlags)
      => ComCall(5, this.p, UInt32, dwFlags)
    GetTop(ppic)
      => ComCall(6, this.p, ITfContext.Ptr, ppic)
    GetBase(ppic)
      => ComCall(7, this.p, ITfContext.Ptr, ppic)
    EnumContexts(ppEnum)
      => ComCall(8, this.p, IEnumTfContexts.Ptr, ppEnum)
}
struct IEnumTfContexts extends IUnknown {
    static IID := "{8F1A7EA6-1654-4502-A86E-B2902344D507}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfContexts.Ptr, ppEnum)
    Next(rgContext, pcFetched)
      => ComCall(4, this.p, UInt32, rgContext.Length, ITfContext.Ptr, rgContext, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfCompositionView extends IUnknown {
    static IID := "{D7540241-F9A1-4364-BEFC-DBCD2C4395B7}"
    GetOwnerClsid(pclsid)
      => ComCall(3, this.p, GUID.Ptr, pclsid)
    GetRange(ppRange)
      => ComCall(4, this.p, ITfRange.Ptr, ppRange)
}
struct IEnumITfCompositionView extends IUnknown {
    static IID := "{5EFD22BA-7838-46CB-88E2-CADB14124F8F}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumITfCompositionView.Ptr, ppEnum)
    Next(rgCompositionView, pcFetched)
      => ComCall(4, this.p, UInt32, rgCompositionView.Length, ITfCompositionView.Ptr, rgCompositionView, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfComposition extends IUnknown {
    static IID := "{20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9}"
    GetRange(ppRange)
      => ComCall(3, this.p, ITfRange.Ptr, ppRange)
    ShiftStart(ecWrite, pNewStart)
      => ComCall(4, this.p, UInt32, ecWrite, ITfRange, pNewStart)
    ShiftEnd(ecWrite, pNewEnd)
      => ComCall(5, this.p, UInt32, ecWrite, ITfRange, pNewEnd)
    EndComposition(ecWrite)
      => ComCall(6, this.p, UInt32, ecWrite)
}
struct ITfCompositionSink extends IUnknown {
    static IID := "{A781718C-579A-4B15-A280-32B8577ACC5E}"
    OnCompositionTerminated(ecWrite, pComposition)
      => ComCall(3, this.p, UInt32, ecWrite, ITfComposition, pComposition)
}
struct ITfContextComposition extends IUnknown {
    static IID := "{D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B}"
    StartComposition(ecWrite, pCompositionRange, pSink, ppComposition)
      => ComCall(3, this.p, UInt32, ecWrite, ITfRange, pCompositionRange, ITfCompositionSink, pSink, ITfComposition.Ptr, ppComposition)
    EnumCompositions(ppEnum)
      => ComCall(4, this.p, IEnumITfCompositionView.Ptr, ppEnum)
    FindComposition(ecRead, pTestRange, ppEnum)
      => ComCall(5, this.p, UInt32, ecRead, ITfRange, pTestRange, IEnumITfCompositionView.Ptr, ppEnum)
    TakeOwnership(ecWrite, pComposition, pSink, ppComposition)
      => ComCall(6, this.p, UInt32, ecWrite, ITfCompositionView, pComposition, ITfCompositionSink, pSink, ITfComposition.Ptr, ppComposition)
}
struct ITfContextOwnerCompositionServices extends ITfContextComposition {
    static IID := "{86462810-593B-4916-9764-19C08E9CE110}"
    TerminateComposition(pComposition)
      => ComCall(7, this.p, ITfCompositionView, pComposition)
}
struct ITfContextOwnerCompositionSink extends IUnknown {
    static IID := "{5F20AA40-B57A-4F34-96AB-3576F377CC79}"
    OnStartComposition(pComposition, pfOk)
      => ComCall(3, this.p, ITfCompositionView, pComposition, BOOL.Ptr, pfOk)
    OnUpdateComposition(pComposition, pRangeNew)
      => ComCall(4, this.p, ITfCompositionView, pComposition, ITfRange, pRangeNew)
    OnEndComposition(pComposition)
      => ComCall(5, this.p, ITfCompositionView, pComposition)
}
struct ITfContextView extends IUnknown {
    static IID := "{2433BF8E-0F9B-435C-BA2C-180611978C30}"
    GetRangeFromPoint(ec, ppt, dwFlags, ppRange)
      => ComCall(3, this.p, UInt32, ec, POINT.Ptr, ppt, UInt32, dwFlags, ITfRange.Ptr, ppRange)
    GetTextExt(ec, pRange, prc, pfClipped)
      => ComCall(4, this.p, UInt32, ec, ITfRange, pRange, RECT.Ptr, prc, BOOL.Ptr, pfClipped)
    GetScreenExt(prc)
      => ComCall(5, this.p, RECT.Ptr, prc)
    GetWnd(phwnd)
      => ComCall(6, this.p, HWND.Ptr, phwnd)
}
struct IEnumTfContextViews extends IUnknown {
    static IID := "{F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfContextViews.Ptr, ppEnum)
    Next(rgViews, pcFetched)
      => ComCall(4, this.p, UInt32, rgViews.Length, ITfContextView.Ptr, rgViews, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct TfActiveSelEnd extends Int32 {
    static TF_AE_NONE := 0
    static TF_AE_START := 1
    static TF_AE_END := 2
}
struct TF_SELECTIONSTYLE {
    ase : TfActiveSelEnd
    fInterimChar : BOOL
}
struct TF_SELECTION {
    range : ITfRange
    style : TF_SELECTIONSTYLE
}
struct ITfContext extends IUnknown {
    static IID := "{AA80E7FD-2021-11D2-93E0-0060B067B86E}"
    RequestEditSession(tid, pes, dwFlags, phrSession)
      => ComCall(3, this.p, UInt32, tid, ITfEditSession, pes, TF_CONTEXT_EDIT_CONTEXT_FLAGS, dwFlags, HRESULT.Ptr, phrSession)
    InWriteSession(tid, pfWriteSession)
      => ComCall(4, this.p, UInt32, tid, BOOL.Ptr, pfWriteSession)
    GetSelection(ec, ulIndex, pSelection, pcFetched)
      => ComCall(5, this.p, UInt32, ec, UInt32, ulIndex, UInt32, pSelection.Length, TF_SELECTION.Ptr, pSelection, UInt32.Ptr, pcFetched)
    SetSelection(ec, pSelection)
      => ComCall(6, this.p, UInt32, ec, UInt32, pSelection.Length, TF_SELECTION.Ptr, pSelection)
    GetStart(ec, ppStart)
      => ComCall(7, this.p, UInt32, ec, ITfRange.Ptr, ppStart)
    GetEnd(ec, ppEnd)
      => ComCall(8, this.p, UInt32, ec, ITfRange.Ptr, ppEnd)
    GetActiveView(ppView)
      => ComCall(9, this.p, ITfContextView.Ptr, ppView)
    EnumViews(ppEnum)
      => ComCall(10, this.p, IEnumTfContextViews.Ptr, ppEnum)
    GetStatus(pdcs)
      => ComCall(11, this.p, TS_STATUS.Ptr, pdcs)
    GetProperty(guidProp, ppProp)
      => ComCall(12, this.p, GUID.Ptr, guidProp, ITfProperty.Ptr, ppProp)
    GetAppProperty(guidProp, ppProp)
      => ComCall(13, this.p, GUID.Ptr, guidProp, ITfReadOnlyProperty.Ptr, ppProp)
    TrackProperties(prgProp, prgAppProp, ppProperty)
      => ComCall(14, this.p, GUID.Ptr.Ptr, prgProp, UInt32, prgProp.Length, GUID.Ptr.Ptr, prgAppProp, UInt32, prgAppProp.Length, ITfReadOnlyProperty.Ptr, ppProperty)
    EnumProperties(ppEnum)
      => ComCall(15, this.p, IEnumTfProperties.Ptr, ppEnum)
    GetDocumentMgr(ppDm)
      => ComCall(16, this.p, ITfDocumentMgr.Ptr, ppDm)
    CreateRangeBackup(ec, pRange, ppBackup)
      => ComCall(17, this.p, UInt32, ec, ITfRange, pRange, ITfRangeBackup.Ptr, ppBackup)
}
struct ITfQueryEmbedded extends IUnknown {
    static IID := "{0FAB9BDB-D250-4169-84E5-6BE118FDD7A8}"
    QueryInsertEmbedded(pguidService, pFormatEtc, pfInsertable)
      => ComCall(3, this.p, GUID.Ptr, pguidService, FORMATETC.Ptr, pFormatEtc, BOOL.Ptr, pfInsertable)
}
struct ITfInsertAtSelection extends IUnknown {
    static IID := "{55CE16BA-3014-41C1-9CEB-FADE1446AC6C}"
    InsertTextAtSelection(ec, dwFlags, pchText, ppRange)
      => ComCall(3, this.p, UInt32, ec, INSERT_TEXT_AT_SELECTION_FLAGS, dwFlags, "Str", pchText, Int32, pchText.Length, ITfRange.Ptr, ppRange)
    InsertEmbeddedAtSelection(ec, dwFlags, pDataObject, ppRange)
      => ComCall(4, this.p, UInt32, ec, UInt32, dwFlags, IDataObject, pDataObject, ITfRange.Ptr, ppRange)
}
struct ITfCleanupContextSink extends IUnknown {
    static IID := "{01689689-7ACB-4E9B-AB7C-7EA46B12B522}"
    OnCleanupContext(ecWrite, pic)
      => ComCall(3, this.p, UInt32, ecWrite, ITfContext, pic)
}
struct ITfCleanupContextDurationSink extends IUnknown {
    static IID := "{45C35144-154E-4797-BED8-D33AE7BF8794}"
    OnStartCleanupContext()
      => ComCall(3, this.p)
    OnEndCleanupContext()
      => ComCall(4, this.p)
}
struct ITfReadOnlyProperty extends IUnknown {
    static IID := "{17D49A3D-F8B8-4B2F-B254-52319DD64C53}"
    GetType(pguid)
      => ComCall(3, this.p, GUID.Ptr, pguid)
    EnumRanges(ec, ppEnum, pTargetRange)
      => ComCall(4, this.p, UInt32, ec, IEnumTfRanges.Ptr, ppEnum, ITfRange, pTargetRange)
    GetValue(ec, pRange, pvarValue)
      => ComCall(5, this.p, UInt32, ec, ITfRange, pRange, VARIANT.Ptr, pvarValue)
    GetContext(ppContext)
      => ComCall(6, this.p, ITfContext.Ptr, ppContext)
}
struct TF_PROPERTYVAL {
    guidId : GUID
    varValue : VARIANT
}
struct IEnumTfPropertyValue extends IUnknown {
    static IID := "{8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfPropertyValue.Ptr, ppEnum)
    Next(rgValues, pcFetched)
      => ComCall(4, this.p, UInt32, rgValues.Length, TF_PROPERTYVAL.Ptr, rgValues, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfMouseTracker extends IUnknown {
    static IID := "{09D146CD-A544-4132-925B-7AFA8EF322D0}"
    AdviseMouseSink(range, pSink, pdwCookie)
      => ComCall(3, this.p, ITfRange, range, ITfMouseSink, pSink, UInt32.Ptr, pdwCookie)
    UnadviseMouseSink(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
}
struct ITfMouseTrackerACP extends IUnknown {
    static IID := "{3BDD78E2-C16E-47FD-B883-CE6FACC1A208}"
    AdviseMouseSink(range, pSink, pdwCookie)
      => ComCall(3, this.p, ITfRangeACP, range, ITfMouseSink, pSink, UInt32.Ptr, pdwCookie)
    UnadviseMouseSink(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
}
struct ITfMouseSink extends IUnknown {
    static IID := "{A1ADAAA2-3A24-449D-AC96-5183E7F5C217}"
    OnMouseEvent(uEdge, uQuadrant, dwBtnStatus, pfEaten)
      => ComCall(3, this.p, UInt32, uEdge, UInt32, uQuadrant, UInt32, dwBtnStatus, BOOL.Ptr, pfEaten)
}
struct ITfEditRecord extends IUnknown {
    static IID := "{42D4D099-7C1A-4A89-B836-6C6F22160DF0}"
    GetSelectionStatus(pfChanged)
      => ComCall(3, this.p, BOOL.Ptr, pfChanged)
    GetTextAndPropertyUpdates(dwFlags, prgProperties, ppEnum)
      => ComCall(4, this.p, GET_TEXT_AND_PROPERTY_UPDATES_FLAGS, dwFlags, GUID.Ptr.Ptr, prgProperties, UInt32, prgProperties.Length, IEnumTfRanges.Ptr, ppEnum)
}
struct ITfTextEditSink extends IUnknown {
    static IID := "{8127D409-CCD3-4683-967A-B43D5B482BF7}"
    OnEndEdit(pic, ecReadOnly, pEditRecord)
      => ComCall(3, this.p, ITfContext, pic, UInt32, ecReadOnly, ITfEditRecord, pEditRecord)
}
struct TfLayoutCode extends Int32 {
    static TF_LC_CREATE := 0
    static TF_LC_CHANGE := 1
    static TF_LC_DESTROY := 2
}
struct ITfTextLayoutSink extends IUnknown {
    static IID := "{2AF2D06A-DD5B-4927-A0B4-54F19C91FADE}"
    OnLayoutChange(pic, lcode, pView)
      => ComCall(3, this.p, ITfContext, pic, TfLayoutCode, lcode, ITfContextView, pView)
}
struct ITfStatusSink extends IUnknown {
    static IID := "{6B7D8D73-B267-4F69-B32E-1CA321CE4F45}"
    OnStatusChange(pic, dwFlags)
      => ComCall(3, this.p, ITfContext, pic, UInt32, dwFlags)
}
struct ITfEditTransactionSink extends IUnknown {
    static IID := "{708FBF70-B520-416B-B06C-2C41AB44F8BA}"
    OnStartEditTransaction(pic)
      => ComCall(3, this.p, ITfContext, pic)
    OnEndEditTransaction(pic)
      => ComCall(4, this.p, ITfContext, pic)
}
struct ITfContextOwner extends IUnknown {
    static IID := "{AA80E80C-2021-11D2-93E0-0060B067B86E}"
    GetACPFromPoint(ptScreen, dwFlags, pacp)
      => ComCall(3, this.p, POINT.Ptr, ptScreen, UInt32, dwFlags, Int32.Ptr, pacp)
    GetTextExt(acpStart, acpEnd, prc, pfClipped)
      => ComCall(4, this.p, Int32, acpStart, Int32, acpEnd, RECT.Ptr, prc, BOOL.Ptr, pfClipped)
    GetScreenExt(prc)
      => ComCall(5, this.p, RECT.Ptr, prc)
    GetStatus(pdcs)
      => ComCall(6, this.p, TS_STATUS.Ptr, pdcs)
    GetWnd(phwnd)
      => ComCall(7, this.p, HWND.Ptr, phwnd)
    GetAttribute(rguidAttribute, pvarValue)
      => ComCall(8, this.p, GUID.Ptr, rguidAttribute, VARIANT.Ptr, pvarValue)
}
struct ITfContextOwnerServices extends IUnknown {
    static IID := "{B23EB630-3E1C-11D3-A745-0050040AB407}"
    OnLayoutChange()
      => ComCall(3, this.p)
    OnStatusChange(dwFlags)
      => ComCall(4, this.p, UInt32, dwFlags)
    OnAttributeChange(rguidAttribute)
      => ComCall(5, this.p, GUID.Ptr, rguidAttribute)
    Serialize(pProp, pRange, pHdr, pStream)
      => ComCall(6, this.p, ITfProperty, pProp, ITfRange, pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP.Ptr, pHdr, IStream, pStream)
    Unserialize(pProp, pHdr, pStream, pLoader)
      => ComCall(7, this.p, ITfProperty, pProp, TF_PERSISTENT_PROPERTY_HEADER_ACP.Ptr, pHdr, IStream, pStream, ITfPersistentPropertyLoaderACP, pLoader)
    ForceLoadProperty(pProp)
      => ComCall(8, this.p, ITfProperty, pProp)
    CreateRange(acpStart, acpEnd, ppRange)
      => ComCall(9, this.p, Int32, acpStart, Int32, acpEnd, ITfRangeACP.Ptr, ppRange)
}
struct ITfContextKeyEventSink extends IUnknown {
    static IID := "{0552BA5D-C835-4934-BF50-846AAA67432F}"
    OnKeyDown(wParam1, lParam1, pfEaten)
      => ComCall(3, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnKeyUp(wParam1, lParam1, pfEaten)
      => ComCall(4, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnTestKeyDown(wParam1, lParam1, pfEaten)
      => ComCall(5, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnTestKeyUp(wParam1, lParam1, pfEaten)
      => ComCall(6, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
}
struct ITfEditSession extends IUnknown {
    static IID := "{AA80E803-2021-11D2-93E0-0060B067B86E}"
    DoEditSession(ec)
      => ComCall(3, this.p, UInt32, ec)
}
struct TfGravity extends Int32 {
    static TF_GRAVITY_BACKWARD := 0
    static TF_GRAVITY_FORWARD := 1
}
struct TfShiftDir extends Int32 {
    static TF_SD_BACKWARD := 0
    static TF_SD_FORWARD := 1
}
struct TF_HALTCOND {
    pHaltRange : ITfRange
    aHaltPos : TfAnchor
    dwFlags : UInt32
}
struct ITfRange extends IUnknown {
    static IID := "{AA80E7FF-2021-11D2-93E0-0060B067B86E}"
    GetText(ec, dwFlags, pchText, pcch)
      => ComCall(3, this.p, UInt32, ec, UInt32, dwFlags, PWSTR, pchText, UInt32, pchText.Length, UInt32.Ptr, pcch)
    SetText(ec, dwFlags, pchText)
      => ComCall(4, this.p, UInt32, ec, UInt32, dwFlags, "Str", pchText, Int32, pchText.Length)
    GetFormattedText(ec, ppDataObject)
      => ComCall(5, this.p, UInt32, ec, IDataObject.Ptr, ppDataObject)
    GetEmbedded(ec, rguidService, riid, ppunk)
      => ComCall(6, this.p, UInt32, ec, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    InsertEmbedded(ec, dwFlags, pDataObject)
      => ComCall(7, this.p, UInt32, ec, UInt32, dwFlags, IDataObject, pDataObject)
    ShiftStart(ec, cchReq, pcch, pHalt)
      => ComCall(8, this.p, UInt32, ec, Int32, cchReq, Int32.Ptr, pcch, TF_HALTCOND.Ptr, pHalt)
    ShiftEnd(ec, cchReq, pcch, pHalt)
      => ComCall(9, this.p, UInt32, ec, Int32, cchReq, Int32.Ptr, pcch, TF_HALTCOND.Ptr, pHalt)
    ShiftStartToRange(ec, pRange, aPos)
      => ComCall(10, this.p, UInt32, ec, ITfRange, pRange, TfAnchor, aPos)
    ShiftEndToRange(ec, pRange, aPos)
      => ComCall(11, this.p, UInt32, ec, ITfRange, pRange, TfAnchor, aPos)
    ShiftStartRegion(ec, dir, pfNoRegion)
      => ComCall(12, this.p, UInt32, ec, TfShiftDir, dir, BOOL.Ptr, pfNoRegion)
    ShiftEndRegion(ec, dir, pfNoRegion)
      => ComCall(13, this.p, UInt32, ec, TfShiftDir, dir, BOOL.Ptr, pfNoRegion)
    IsEmpty(ec, pfEmpty)
      => ComCall(14, this.p, UInt32, ec, BOOL.Ptr, pfEmpty)
    Collapse(ec, aPos)
      => ComCall(15, this.p, UInt32, ec, TfAnchor, aPos)
    IsEqualStart(ec, pWith, aPos, pfEqual)
      => ComCall(16, this.p, UInt32, ec, ITfRange, pWith, TfAnchor, aPos, BOOL.Ptr, pfEqual)
    IsEqualEnd(ec, pWith, aPos, pfEqual)
      => ComCall(17, this.p, UInt32, ec, ITfRange, pWith, TfAnchor, aPos, BOOL.Ptr, pfEqual)
    CompareStart(ec, pWith, aPos, plResult)
      => ComCall(18, this.p, UInt32, ec, ITfRange, pWith, TfAnchor, aPos, Int32.Ptr, plResult)
    CompareEnd(ec, pWith, aPos, plResult)
      => ComCall(19, this.p, UInt32, ec, ITfRange, pWith, TfAnchor, aPos, Int32.Ptr, plResult)
    AdjustForInsert(ec, cchInsert, pfInsertOk)
      => ComCall(20, this.p, UInt32, ec, UInt32, cchInsert, BOOL.Ptr, pfInsertOk)
    GetGravity(pgStart, pgEnd)
      => ComCall(21, this.p, TfGravity.Ptr, pgStart, TfGravity.Ptr, pgEnd)
    SetGravity(ec, gStart, gEnd)
      => ComCall(22, this.p, UInt32, ec, TfGravity, gStart, TfGravity, gEnd)
    Clone(ppClone)
      => ComCall(23, this.p, ITfRange.Ptr, ppClone)
    GetContext(ppContext)
      => ComCall(24, this.p, ITfContext.Ptr, ppContext)
}
struct ITfRangeACP extends ITfRange {
    static IID := "{057A6296-029B-4154-B79A-0D461D4EA94C}"
    GetExtent(pacpAnchor, pcch)
      => ComCall(25, this.p, Int32.Ptr, pacpAnchor, Int32.Ptr, pcch)
    SetExtent(acpAnchor, cch)
      => ComCall(26, this.p, Int32, acpAnchor, Int32, cch)
}
struct ITextStoreACPServices extends IUnknown {
    static IID := "{AA80E901-2021-11D2-93E0-0060B067B86E}"
    Serialize(pProp, pRange, pHdr, pStream)
      => ComCall(3, this.p, ITfProperty, pProp, ITfRange, pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP.Ptr, pHdr, IStream, pStream)
    Unserialize(pProp, pHdr, pStream, pLoader)
      => ComCall(4, this.p, ITfProperty, pProp, TF_PERSISTENT_PROPERTY_HEADER_ACP.Ptr, pHdr, IStream, pStream, ITfPersistentPropertyLoaderACP, pLoader)
    ForceLoadProperty(pProp)
      => ComCall(5, this.p, ITfProperty, pProp)
    CreateRange(acpStart, acpEnd, ppRange)
      => ComCall(6, this.p, Int32, acpStart, Int32, acpEnd, ITfRangeACP.Ptr, ppRange)
}
struct ITfRangeBackup extends IUnknown {
    static IID := "{463A506D-6992-49D2-9B88-93D55E70BB16}"
    Restore(ec, pRange)
      => ComCall(3, this.p, UInt32, ec, ITfRange, pRange)
}
struct ITfPropertyStore extends IUnknown {
    static IID := "{6834B120-88CB-11D2-BF45-00105A2799B5}"
    GetType(pguid)
      => ComCall(3, this.p, GUID.Ptr, pguid)
    GetDataType(pdwReserved)
      => ComCall(4, this.p, UInt32.Ptr, pdwReserved)
    GetData(pvarValue)
      => ComCall(5, this.p, VARIANT.Ptr, pvarValue)
    OnTextUpdated(dwFlags, pRangeNew, pfAccept)
      => ComCall(6, this.p, UInt32, dwFlags, ITfRange, pRangeNew, BOOL.Ptr, pfAccept)
    Shrink(pRangeNew, pfFree)
      => ComCall(7, this.p, ITfRange, pRangeNew, BOOL.Ptr, pfFree)
    Divide(pRangeThis, pRangeNew, ppPropStore)
      => ComCall(8, this.p, ITfRange, pRangeThis, ITfRange, pRangeNew, ITfPropertyStore.Ptr, ppPropStore)
    Clone(pPropStore)
      => ComCall(9, this.p, ITfPropertyStore.Ptr, pPropStore)
    GetPropertyRangeCreator(pclsid)
      => ComCall(10, this.p, GUID.Ptr, pclsid)
    Serialize(pStream, pcb)
      => ComCall(11, this.p, IStream, pStream, UInt32.Ptr, pcb)
}
struct IEnumTfRanges extends IUnknown {
    static IID := "{F99D3F40-8E32-11D2-BF46-00105A2799B5}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfRanges.Ptr, ppEnum)
    Next(ppRange, pcFetched)
      => ComCall(4, this.p, UInt32, ppRange.Length, ITfRange.Ptr, ppRange, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfCreatePropertyStore extends IUnknown {
    static IID := "{2463FBF0-B0AF-11D2-AFC5-00105A2799B5}"
    IsStoreSerializable(guidProp, pRange, pPropStore, pfSerializable)
      => ComCall(3, this.p, GUID.Ptr, guidProp, ITfRange, pRange, ITfPropertyStore, pPropStore, BOOL.Ptr, pfSerializable)
    CreatePropertyStore(guidProp, pRange, cb, pStream, ppStore)
      => ComCall(4, this.p, GUID.Ptr, guidProp, ITfRange, pRange, UInt32, cb, IStream, pStream, ITfPropertyStore.Ptr, ppStore)
}
struct ITfPersistentPropertyLoaderACP extends IUnknown {
    static IID := "{4EF89150-0807-11D3-8DF0-00105A2799B5}"
    LoadProperty(pHdr, ppStream)
      => ComCall(3, this.p, TF_PERSISTENT_PROPERTY_HEADER_ACP.Ptr, pHdr, IStream.Ptr, ppStream)
}
struct ITfProperty extends ITfReadOnlyProperty {
    static IID := "{E2449660-9542-11D2-BF46-00105A2799B5}"
    FindRange(ec, pRange, ppRange, aPos)
      => ComCall(7, this.p, UInt32, ec, ITfRange, pRange, ITfRange.Ptr, ppRange, TfAnchor, aPos)
    SetValueStore(ec, pRange, pPropStore)
      => ComCall(8, this.p, UInt32, ec, ITfRange, pRange, ITfPropertyStore, pPropStore)
    SetValue(ec, pRange, pvarValue)
      => ComCall(9, this.p, UInt32, ec, ITfRange, pRange, VARIANT.Ptr, pvarValue)
    Clear(ec, pRange)
      => ComCall(10, this.p, UInt32, ec, ITfRange, pRange)
}
struct IEnumTfProperties extends IUnknown {
    static IID := "{19188CB0-ACA9-11D2-AFC5-00105A2799B5}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfProperties.Ptr, ppEnum)
    Next(ppProp, pcFetched)
      => ComCall(4, this.p, UInt32, ppProp.Length, ITfProperty.Ptr, ppProp, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfCompartment extends IUnknown {
    static IID := "{BB08F7A9-607A-4384-8623-056892B64371}"
    SetValue(tid, pvarValue)
      => ComCall(3, this.p, UInt32, tid, VARIANT.Ptr, pvarValue)
    GetValue(pvarValue)
      => ComCall(4, this.p, VARIANT.Ptr, pvarValue)
}
struct ITfCompartmentEventSink extends IUnknown {
    static IID := "{743ABD5F-F26D-48DF-8CC5-238492419B64}"
    OnChange(rguid)
      => ComCall(3, this.p, GUID.Ptr, rguid)
}
struct ITfCompartmentMgr extends IUnknown {
    static IID := "{7DCF57AC-18AD-438B-824D-979BFFB74B7C}"
    GetCompartment(rguid, ppcomp)
      => ComCall(3, this.p, GUID.Ptr, rguid, ITfCompartment.Ptr, ppcomp)
    ClearCompartment(tid, rguid)
      => ComCall(4, this.p, UInt32, tid, GUID.Ptr, rguid)
    EnumCompartments(ppEnum)
      => ComCall(5, this.p, IEnumGUID.Ptr, ppEnum)
}
struct ITfFunction extends IUnknown {
    static IID := "{DB593490-098F-11D3-8DF0-00105A2799B5}"
    GetDisplayName(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
}
struct ITfFunctionProvider extends IUnknown {
    static IID := "{101D6610-0990-11D3-8DF0-00105A2799B5}"
    GetType(pguid)
      => ComCall(3, this.p, GUID.Ptr, pguid)
    GetDescription(pbstrDesc)
      => ComCall(4, this.p, BSTR.Ptr, pbstrDesc)
    GetFunction(rguid, riid, ppunk)
      => ComCall(5, this.p, GUID.Ptr, rguid, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
}
struct IEnumTfFunctionProviders extends IUnknown {
    static IID := "{E4B24DB0-0990-11D3-8DF0-00105A2799B5}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfFunctionProviders.Ptr, ppEnum)
    Next(ppCmdobj, pcFetch)
      => ComCall(4, this.p, UInt32, ppCmdobj.Length, ITfFunctionProvider.Ptr, ppCmdobj, UInt32.Ptr, pcFetch)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfInputProcessorProfiles extends IUnknown {
    static IID := "{1F02B6C5-7842-4EE6-8A0B-9A24183A95CA}"
    Register(rclsid)
      => ComCall(3, this.p, GUID.Ptr, rclsid)
    Unregister(rclsid)
      => ComCall(4, this.p, GUID.Ptr, rclsid)
    AddLanguageProfile(rclsid, langid, guidProfile, pchDesc, pchIconFile, uIconIndex)
      => ComCall(5, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, "Str", pchDesc, UInt32, pchDesc.Length, "Str", pchIconFile, UInt32, pchIconFile.Length, UInt32, uIconIndex)
    RemoveLanguageProfile(rclsid, langid, guidProfile)
      => ComCall(6, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile)
    EnumInputProcessorInfo(ppEnum)
      => ComCall(7, this.p, IEnumGUID.Ptr, ppEnum)
    GetDefaultLanguageProfile(langid, catid, pclsid, pguidProfile)
      => ComCall(8, this.p, UInt16, langid, GUID.Ptr, catid, GUID.Ptr, pclsid, GUID.Ptr, pguidProfile)
    SetDefaultLanguageProfile(langid, rclsid, guidProfiles)
      => ComCall(9, this.p, UInt16, langid, GUID.Ptr, rclsid, GUID.Ptr, guidProfiles)
    ActivateLanguageProfile(rclsid, langid, guidProfiles)
      => ComCall(10, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfiles)
    GetActiveLanguageProfile(rclsid, plangid, pguidProfile)
      => ComCall(11, this.p, GUID.Ptr, rclsid, UInt16.Ptr, plangid, GUID.Ptr, pguidProfile)
    GetLanguageProfileDescription(rclsid, langid, guidProfile, pbstrProfile)
      => ComCall(12, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, BSTR.Ptr, pbstrProfile)
    GetCurrentLanguage(plangid)
      => ComCall(13, this.p, UInt16.Ptr, plangid)
    ChangeCurrentLanguage(langid)
      => ComCall(14, this.p, UInt16, langid)
    GetLanguageList(ppLangId)
      => ComCall(15, this.p, UInt16.Ptr.Ptr, ppLangId, UInt32.Ptr, ppLangId.Length)
    EnumLanguageProfiles(langid, ppEnum)
      => ComCall(16, this.p, UInt16, langid, IEnumTfLanguageProfiles.Ptr, ppEnum)
    EnableLanguageProfile(rclsid, langid, guidProfile, fEnable)
      => ComCall(17, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, BOOL, fEnable)
    IsEnabledLanguageProfile(rclsid, langid, guidProfile, pfEnable)
      => ComCall(18, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, BOOL.Ptr, pfEnable)
    EnableLanguageProfileByDefault(rclsid, langid, guidProfile, fEnable)
      => ComCall(19, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, BOOL, fEnable)
    SubstituteKeyboardLayout(rclsid, langid, guidProfile, hKL1)
      => ComCall(20, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, HKL, hKL1)
}
struct ITfInputProcessorProfilesEx extends ITfInputProcessorProfiles {
    static IID := "{892F230F-FE00-4A41-A98E-FCD6DE0D35EF}"
    SetLanguageProfileDisplayName(rclsid, langid, guidProfile, pchFile, uResId)
      => ComCall(21, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, "Str", pchFile, UInt32, pchFile.Length, UInt32, uResId)
}
struct ITfInputProcessorProfileSubstituteLayout extends IUnknown {
    static IID := "{4FD67194-1002-4513-BFF2-C0DDF6258552}"
    GetSubstituteKeyboardLayout(rclsid, langid, guidProfile, phKL)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, HKL.Ptr, phKL)
}
struct ITfActiveLanguageProfileNotifySink extends IUnknown {
    static IID := "{B246CB75-A93E-4652-BF8C-B3FE0CFD7E57}"
    OnActivated(clsid, guidProfile, fActivated)
      => ComCall(3, this.p, GUID.Ptr, clsid, GUID.Ptr, guidProfile, BOOL, fActivated)
}
struct IEnumTfLanguageProfiles extends IUnknown {
    static IID := "{3D61BF11-AC5F-42C8-A4CB-931BCC28C744}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfLanguageProfiles.Ptr, ppEnum)
    Next(pProfile, pcFetch)
      => ComCall(4, this.p, UInt32, pProfile.Length, TF_LANGUAGEPROFILE.Ptr, pProfile, UInt32.Ptr, pcFetch)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfLanguageProfileNotifySink extends IUnknown {
    static IID := "{43C9FE15-F494-4C17-9DE2-B8A4AC350AA8}"
    OnLanguageChange(langid, pfAccept)
      => ComCall(3, this.p, UInt16, langid, BOOL.Ptr, pfAccept)
    OnLanguageChanged()
      => ComCall(4, this.p)
}
struct TF_INPUTPROCESSORPROFILE {
    dwProfileType : UInt32
    langid : UInt16
    clsid : GUID
    guidProfile : GUID
    catid : GUID
    hklSubstitute : HKL
    dwCaps : UInt32
    hkl : HKL
    dwFlags : UInt32
}
struct ITfInputProcessorProfileMgr extends IUnknown {
    static IID := "{71C6E74C-0F28-11D8-A82A-00065B84435C}"
    ActivateProfile(dwProfileType, langid, clsid, guidProfile, hkl1, dwFlags)
      => ComCall(3, this.p, UInt32, dwProfileType, UInt16, langid, GUID.Ptr, clsid, GUID.Ptr, guidProfile, HKL, hkl1, UInt32, dwFlags)
    DeactivateProfile(dwProfileType, langid, clsid, guidProfile, hkl1, dwFlags)
      => ComCall(4, this.p, UInt32, dwProfileType, UInt16, langid, GUID.Ptr, clsid, GUID.Ptr, guidProfile, HKL, hkl1, UInt32, dwFlags)
    GetProfile(dwProfileType, langid, clsid, guidProfile, hkl1, pProfile)
      => ComCall(5, this.p, UInt32, dwProfileType, UInt16, langid, GUID.Ptr, clsid, GUID.Ptr, guidProfile, HKL, hkl1, TF_INPUTPROCESSORPROFILE.Ptr, pProfile)
    EnumProfiles(langid, ppEnum)
      => ComCall(6, this.p, UInt16, langid, IEnumTfInputProcessorProfiles.Ptr, ppEnum)
    ReleaseInputProcessor(rclsid, dwFlags)
      => ComCall(7, this.p, GUID.Ptr, rclsid, UInt32, dwFlags)
    RegisterProfile(rclsid, langid, guidProfile, pchDesc, pchIconFile, uIconIndex, hklsubstitute, dwPreferredLayout, bEnabledByDefault, dwFlags)
      => ComCall(8, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, "Str", pchDesc, UInt32, pchDesc.Length, "Str", pchIconFile, UInt32, pchIconFile.Length, UInt32, uIconIndex, HKL, hklsubstitute, UInt32, dwPreferredLayout, BOOL, bEnabledByDefault, UInt32, dwFlags)
    UnregisterProfile(rclsid, langid, guidProfile, dwFlags)
      => ComCall(9, this.p, GUID.Ptr, rclsid, UInt16, langid, GUID.Ptr, guidProfile, UInt32, dwFlags)
    GetActiveProfile(catid, pProfile)
      => ComCall(10, this.p, GUID.Ptr, catid, TF_INPUTPROCESSORPROFILE.Ptr, pProfile)
}
struct IEnumTfInputProcessorProfiles extends IUnknown {
    static IID := "{71C6E74D-0F28-11D8-A82A-00065B84435C}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfInputProcessorProfiles.Ptr, ppEnum)
    Next(pProfile, pcFetch)
      => ComCall(4, this.p, UInt32, pProfile.Length, TF_INPUTPROCESSORPROFILE.Ptr, pProfile, UInt32.Ptr, pcFetch)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfInputProcessorProfileActivationSink extends IUnknown {
    static IID := "{71C6E74E-0F28-11D8-A82A-00065B84435C}"
    OnActivated(dwProfileType, langid, clsid, catid, guidProfile, hkl1, dwFlags)
      => ComCall(3, this.p, UInt32, dwProfileType, UInt16, langid, GUID.Ptr, clsid, GUID.Ptr, catid, GUID.Ptr, guidProfile, HKL, hkl1, UInt32, dwFlags)
}
struct TF_PRESERVEDKEY {
    uVKey : UInt32
    uModifiers : UInt32
}
struct ITfKeystrokeMgr extends IUnknown {
    static IID := "{AA80E7F0-2021-11D2-93E0-0060B067B86E}"
    AdviseKeyEventSink(tid, pSink, fForeground)
      => ComCall(3, this.p, UInt32, tid, ITfKeyEventSink, pSink, BOOL, fForeground)
    UnadviseKeyEventSink(tid)
      => ComCall(4, this.p, UInt32, tid)
    GetForeground(pclsid)
      => ComCall(5, this.p, GUID.Ptr, pclsid)
    TestKeyDown(wParam1, lParam1, pfEaten)
      => ComCall(6, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    TestKeyUp(wParam1, lParam1, pfEaten)
      => ComCall(7, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    KeyDown(wParam1, lParam1, pfEaten)
      => ComCall(8, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    KeyUp(wParam1, lParam1, pfEaten)
      => ComCall(9, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    GetPreservedKey(pic, pprekey, pguid)
      => ComCall(10, this.p, ITfContext, pic, TF_PRESERVEDKEY.Ptr, pprekey, GUID.Ptr, pguid)
    IsPreservedKey(rguid, pprekey, pfRegistered)
      => ComCall(11, this.p, GUID.Ptr, rguid, TF_PRESERVEDKEY.Ptr, pprekey, BOOL.Ptr, pfRegistered)
    PreserveKey(tid, rguid, prekey, pchDesc)
      => ComCall(12, this.p, UInt32, tid, GUID.Ptr, rguid, TF_PRESERVEDKEY.Ptr, prekey, "Str", pchDesc, UInt32, pchDesc.Length)
    UnpreserveKey(rguid, pprekey)
      => ComCall(13, this.p, GUID.Ptr, rguid, TF_PRESERVEDKEY.Ptr, pprekey)
    SetPreservedKeyDescription(rguid, pchDesc)
      => ComCall(14, this.p, GUID.Ptr, rguid, "Str", pchDesc, UInt32, pchDesc.Length)
    GetPreservedKeyDescription(rguid, pbstrDesc)
      => ComCall(15, this.p, GUID.Ptr, rguid, BSTR.Ptr, pbstrDesc)
    SimulatePreservedKey(pic, rguid, pfEaten)
      => ComCall(16, this.p, ITfContext, pic, GUID.Ptr, rguid, BOOL.Ptr, pfEaten)
}
struct ITfKeyEventSink extends IUnknown {
    static IID := "{AA80E7F5-2021-11D2-93E0-0060B067B86E}"
    OnSetFocus(fForeground)
      => ComCall(3, this.p, BOOL, fForeground)
    OnTestKeyDown(pic, wParam1, lParam1, pfEaten)
      => ComCall(4, this.p, ITfContext, pic, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnTestKeyUp(pic, wParam1, lParam1, pfEaten)
      => ComCall(5, this.p, ITfContext, pic, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnKeyDown(pic, wParam1, lParam1, pfEaten)
      => ComCall(6, this.p, ITfContext, pic, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnKeyUp(pic, wParam1, lParam1, pfEaten)
      => ComCall(7, this.p, ITfContext, pic, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    OnPreservedKey(pic, rguid, pfEaten)
      => ComCall(8, this.p, ITfContext, pic, GUID.Ptr, rguid, BOOL.Ptr, pfEaten)
}
struct ITfKeyTraceEventSink extends IUnknown {
    static IID := "{1CD4C13B-1C36-4191-A70A-7F3E611F367D}"
    OnKeyTraceDown(wParam1, lParam1)
      => ComCall(3, this.p, WPARAM, wParam1, LPARAM, lParam1)
    OnKeyTraceUp(wParam1, lParam1)
      => ComCall(4, this.p, WPARAM, wParam1, LPARAM, lParam1)
}
struct ITfPreservedKeyNotifySink extends IUnknown {
    static IID := "{6F77C993-D2B1-446E-853E-5912EFC8A286}"
    OnUpdated(pprekey)
      => ComCall(3, this.p, TF_PRESERVEDKEY.Ptr, pprekey)
}
struct ITfMessagePump extends IUnknown {
    static IID := "{8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C}"
    PeekMessageA(pMsg, hwnd1, wMsgFilterMin, wMsgFilterMax, wRemoveMsg, pfResult)
      => ComCall(3, this.p, MSG.Ptr, pMsg, HWND, hwnd1, UInt32, wMsgFilterMin, UInt32, wMsgFilterMax, UInt32, wRemoveMsg, BOOL.Ptr, pfResult)
    GetMessageA(pMsg, hwnd1, wMsgFilterMin, wMsgFilterMax, pfResult)
      => ComCall(4, this.p, MSG.Ptr, pMsg, HWND, hwnd1, UInt32, wMsgFilterMin, UInt32, wMsgFilterMax, BOOL.Ptr, pfResult)
    PeekMessageW(pMsg, hwnd1, wMsgFilterMin, wMsgFilterMax, wRemoveMsg, pfResult)
      => ComCall(5, this.p, MSG.Ptr, pMsg, HWND, hwnd1, UInt32, wMsgFilterMin, UInt32, wMsgFilterMax, UInt32, wRemoveMsg, BOOL.Ptr, pfResult)
    GetMessageW(pMsg, hwnd1, wMsgFilterMin, wMsgFilterMax, pfResult)
      => ComCall(6, this.p, MSG.Ptr, pMsg, HWND, hwnd1, UInt32, wMsgFilterMin, UInt32, wMsgFilterMax, BOOL.Ptr, pfResult)
}
struct ITfThreadFocusSink extends IUnknown {
    static IID := "{C0F1DB0C-3A20-405C-A303-96B6010A885F}"
    OnSetThreadFocus()
      => ComCall(3, this.p)
    OnKillThreadFocus()
      => ComCall(4, this.p)
}
struct ITfTextInputProcessor extends IUnknown {
    static IID := "{AA80E7F7-2021-11D2-93E0-0060B067B86E}"
    Activate(ptim, tid)
      => ComCall(3, this.p, ITfThreadMgr, ptim, UInt32, tid)
    Deactivate()
      => ComCall(4, this.p)
}
struct ITfTextInputProcessorEx extends ITfTextInputProcessor {
    static IID := "{6E4E2102-F9CD-433D-B496-303CE03A6507}"
    ActivateEx(ptim, tid, dwFlags)
      => ComCall(5, this.p, ITfThreadMgr, ptim, UInt32, tid, UInt32, dwFlags)
}
struct ITfClientId extends IUnknown {
    static IID := "{D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3}"
    GetClientId(rclsid, ptid)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt32.Ptr, ptid)
}
struct TF_DA_LINESTYLE extends Int32 {
    static TF_LS_NONE := 0
    static TF_LS_SOLID := 1
    static TF_LS_DOT := 2
    static TF_LS_DASH := 3
    static TF_LS_SQUIGGLE := 4
}
struct TF_DA_COLORTYPE extends Int32 {
    static TF_CT_NONE := 0
    static TF_CT_SYSCOLOR := 1
    static TF_CT_COLORREF := 2
}
struct TF_DA_COLOR {
    type : TF_DA_COLORTYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            nIndex : Int32
            cr : COLORREF
        }
    }
}
struct TF_DA_ATTR_INFO extends Int32 {
    static TF_ATTR_INPUT := 0
    static TF_ATTR_TARGET_CONVERTED := 1
    static TF_ATTR_CONVERTED := 2
    static TF_ATTR_TARGET_NOTCONVERTED := 3
    static TF_ATTR_INPUT_ERROR := 4
    static TF_ATTR_FIXEDCONVERTED := 5
    static TF_ATTR_OTHER := -1
}
struct TF_DISPLAYATTRIBUTE {
    crText : TF_DA_COLOR
    crBk : TF_DA_COLOR
    lsStyle : TF_DA_LINESTYLE
    fBoldLine : BOOL
    crLine : TF_DA_COLOR
    bAttr : TF_DA_ATTR_INFO
}
struct ITfDisplayAttributeInfo extends IUnknown {
    static IID := "{70528852-2F26-4AEA-8C96-215150578932}"
    GetGUID(pguid)
      => ComCall(3, this.p, GUID.Ptr, pguid)
    GetDescription(pbstrDesc)
      => ComCall(4, this.p, BSTR.Ptr, pbstrDesc)
    GetAttributeInfo(pda)
      => ComCall(5, this.p, TF_DISPLAYATTRIBUTE.Ptr, pda)
    SetAttributeInfo(pda)
      => ComCall(6, this.p, TF_DISPLAYATTRIBUTE.Ptr, pda)
    Reset()
      => ComCall(7, this.p)
}
struct IEnumTfDisplayAttributeInfo extends IUnknown {
    static IID := "{7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfDisplayAttributeInfo.Ptr, ppEnum)
    Next(rgInfo, pcFetched)
      => ComCall(4, this.p, UInt32, rgInfo.Length, ITfDisplayAttributeInfo.Ptr, rgInfo, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfDisplayAttributeProvider extends IUnknown {
    static IID := "{FEE47777-163C-4769-996A-6E9C50AD8F54}"
    EnumDisplayAttributeInfo(ppEnum)
      => ComCall(3, this.p, IEnumTfDisplayAttributeInfo.Ptr, ppEnum)
    GetDisplayAttributeInfo(guid, ppInfo)
      => ComCall(4, this.p, GUID.Ptr, guid, ITfDisplayAttributeInfo.Ptr, ppInfo)
}
struct ITfDisplayAttributeMgr extends IUnknown {
    static IID := "{8DED7393-5DB1-475C-9E71-A39111B0FF67}"
    OnUpdateInfo()
      => ComCall(3, this.p)
    EnumDisplayAttributeInfo(ppEnum)
      => ComCall(4, this.p, IEnumTfDisplayAttributeInfo.Ptr, ppEnum)
    GetDisplayAttributeInfo(guid, ppInfo, pclsidOwner)
      => ComCall(5, this.p, GUID.Ptr, guid, ITfDisplayAttributeInfo.Ptr, ppInfo, GUID.Ptr, pclsidOwner)
}
struct ITfDisplayAttributeNotifySink extends IUnknown {
    static IID := "{AD56F402-E162-4F25-908F-7D577CF9BDA9}"
    OnUpdateInfo()
      => ComCall(3, this.p)
}
struct ITfCategoryMgr extends IUnknown {
    static IID := "{C3ACEFB5-F69D-4905-938F-FCADCF4BE830}"
    RegisterCategory(rclsid, rcatid, rguid)
      => ComCall(3, this.p, GUID.Ptr, rclsid, GUID.Ptr, rcatid, GUID.Ptr, rguid)
    UnregisterCategory(rclsid, rcatid, rguid)
      => ComCall(4, this.p, GUID.Ptr, rclsid, GUID.Ptr, rcatid, GUID.Ptr, rguid)
    EnumCategoriesInItem(rguid, ppEnum)
      => ComCall(5, this.p, GUID.Ptr, rguid, IEnumGUID.Ptr, ppEnum)
    EnumItemsInCategory(rcatid, ppEnum)
      => ComCall(6, this.p, GUID.Ptr, rcatid, IEnumGUID.Ptr, ppEnum)
    FindClosestCategory(rguid, pcatid, ppcatidList)
      => ComCall(7, this.p, GUID.Ptr, rguid, GUID.Ptr, pcatid, GUID.Ptr.Ptr, ppcatidList, UInt32, ppcatidList.Length)
    RegisterGUIDDescription(rclsid, rguid, pchDesc)
      => ComCall(8, this.p, GUID.Ptr, rclsid, GUID.Ptr, rguid, "Str", pchDesc, UInt32, pchDesc.Length)
    UnregisterGUIDDescription(rclsid, rguid)
      => ComCall(9, this.p, GUID.Ptr, rclsid, GUID.Ptr, rguid)
    GetGUIDDescription(rguid, pbstrDesc)
      => ComCall(10, this.p, GUID.Ptr, rguid, BSTR.Ptr, pbstrDesc)
    RegisterGUIDDWORD(rclsid, rguid, dw)
      => ComCall(11, this.p, GUID.Ptr, rclsid, GUID.Ptr, rguid, UInt32, dw)
    UnregisterGUIDDWORD(rclsid, rguid)
      => ComCall(12, this.p, GUID.Ptr, rclsid, GUID.Ptr, rguid)
    GetGUIDDWORD(rguid, pdw)
      => ComCall(13, this.p, GUID.Ptr, rguid, UInt32.Ptr, pdw)
    RegisterGUID(rguid, pguidatom)
      => ComCall(14, this.p, GUID.Ptr, rguid, UInt32.Ptr, pguidatom)
    GetGUID(guidatom, pguid)
      => ComCall(15, this.p, UInt32, guidatom, GUID.Ptr, pguid)
    IsEqualTfGuidAtom(guidatom, rguid, pfEqual)
      => ComCall(16, this.p, UInt32, guidatom, GUID.Ptr, rguid, BOOL.Ptr, pfEqual)
}
struct ITfSource extends IUnknown {
    static IID := "{4EA48A35-60AE-446F-8FD6-E6A8D82459F7}"
    AdviseSink(riid, punk, pdwCookie)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk, UInt32.Ptr, pdwCookie)
    UnadviseSink(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
}
struct ITfSourceSingle extends IUnknown {
    static IID := "{73131F9C-56A9-49DD-B0EE-D046633F7528}"
    AdviseSingleSink(tid, riid, punk)
      => ComCall(3, this.p, UInt32, tid, GUID.Ptr, riid, IUnknown, punk)
    UnadviseSingleSink(tid, riid)
      => ComCall(4, this.p, UInt32, tid, GUID.Ptr, riid)
}
struct ITfUIElementMgr extends IUnknown {
    static IID := "{EA1EA135-19DF-11D7-A6D2-00065B84435C}"
    BeginUIElement(pElement, pbShow, pdwUIElementId)
      => ComCall(3, this.p, ITfUIElement, pElement, BOOL.Ptr, pbShow, UInt32.Ptr, pdwUIElementId)
    UpdateUIElement(dwUIElementId)
      => ComCall(4, this.p, UInt32, dwUIElementId)
    EndUIElement(dwUIElementId)
      => ComCall(5, this.p, UInt32, dwUIElementId)
    GetUIElement(dwUIELementId, ppElement)
      => ComCall(6, this.p, UInt32, dwUIELementId, ITfUIElement.Ptr, ppElement)
    EnumUIElements(ppEnum)
      => ComCall(7, this.p, IEnumTfUIElements.Ptr, ppEnum)
}
struct IEnumTfUIElements extends IUnknown {
    static IID := "{887AA91E-ACBA-4931-84DA-3C5208CF543F}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfUIElements.Ptr, ppEnum)
    Next(ppElement, pcFetched)
      => ComCall(4, this.p, UInt32, ppElement.Length, ITfUIElement.Ptr, ppElement, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfUIElementSink extends IUnknown {
    static IID := "{EA1EA136-19DF-11D7-A6D2-00065B84435C}"
    BeginUIElement(dwUIElementId, pbShow)
      => ComCall(3, this.p, UInt32, dwUIElementId, BOOL.Ptr, pbShow)
    UpdateUIElement(dwUIElementId)
      => ComCall(4, this.p, UInt32, dwUIElementId)
    EndUIElement(dwUIElementId)
      => ComCall(5, this.p, UInt32, dwUIElementId)
}
struct ITfUIElement extends IUnknown {
    static IID := "{EA1EA137-19DF-11D7-A6D2-00065B84435C}"
    GetDescription(pbstrDescription)
      => ComCall(3, this.p, BSTR.Ptr, pbstrDescription)
    GetGUID(pguid)
      => ComCall(4, this.p, GUID.Ptr, pguid)
    Show(bShow)
      => ComCall(5, this.p, BOOL, bShow)
    IsShown(pbShow)
      => ComCall(6, this.p, BOOL.Ptr, pbShow)
}
struct ITfCandidateListUIElement extends ITfUIElement {
    static IID := "{EA1EA138-19DF-11D7-A6D2-00065B84435C}"
    GetUpdatedFlags(pdwFlags)
      => ComCall(7, this.p, UInt32.Ptr, pdwFlags)
    GetDocumentMgr(ppdim)
      => ComCall(8, this.p, ITfDocumentMgr.Ptr, ppdim)
    GetCount(puCount)
      => ComCall(9, this.p, UInt32.Ptr, puCount)
    GetSelection(puIndex)
      => ComCall(10, this.p, UInt32.Ptr, puIndex)
    GetString(uIndex, pstr)
      => ComCall(11, this.p, UInt32, uIndex, BSTR.Ptr, pstr)
    GetPageIndex(pIndex?, puPageCnt)
      => ComCall(12, this.p, UInt32.Ptr, pIndex?, UInt32, pIndex?.Length ?? 0, UInt32.Ptr, puPageCnt)
    SetPageIndex(pIndex)
      => ComCall(13, this.p, UInt32.Ptr, pIndex, UInt32, pIndex.Length)
    GetCurrentPage(puPage)
      => ComCall(14, this.p, UInt32.Ptr, puPage)
}
struct ITfCandidateListUIElementBehavior extends ITfCandidateListUIElement {
    static IID := "{85FAD185-58CE-497A-9460-355366B64B9A}"
    SetSelection(nIndex)
      => ComCall(15, this.p, UInt32, nIndex)
    Finalize()
      => ComCall(16, this.p)
    Abort()
      => ComCall(17, this.p)
}
struct ITfReadingInformationUIElement extends ITfUIElement {
    static IID := "{EA1EA139-19DF-11D7-A6D2-00065B84435C}"
    GetUpdatedFlags(pdwFlags)
      => ComCall(7, this.p, UInt32.Ptr, pdwFlags)
    GetContext(ppic)
      => ComCall(8, this.p, ITfContext.Ptr, ppic)
    GetString(pstr)
      => ComCall(9, this.p, BSTR.Ptr, pstr)
    GetMaxReadingStringLength(pcchMax)
      => ComCall(10, this.p, UInt32.Ptr, pcchMax)
    GetErrorIndex(pErrorIndex)
      => ComCall(11, this.p, UInt32.Ptr, pErrorIndex)
    IsVerticalOrderPreferred(pfVertical)
      => ComCall(12, this.p, BOOL.Ptr, pfVertical)
}
struct ITfTransitoryExtensionUIElement extends ITfUIElement {
    static IID := "{858F956A-972F-42A2-A2F2-0321E1ABE209}"
    GetDocumentMgr(ppdim)
      => ComCall(7, this.p, ITfDocumentMgr.Ptr, ppdim)
}
struct ITfTransitoryExtensionSink extends IUnknown {
    static IID := "{A615096F-1C57-4813-8A15-55EE6E5A839C}"
    OnTransitoryExtensionUpdated(pic, ecReadOnly, pResultRange, pCompositionRange, pfDeleteResultRange)
      => ComCall(3, this.p, ITfContext, pic, UInt32, ecReadOnly, ITfRange, pResultRange, ITfRange, pCompositionRange, BOOL.Ptr, pfDeleteResultRange)
}
struct ITfToolTipUIElement extends ITfUIElement {
    static IID := "{52B18B5C-555D-46B2-B00A-FA680144FBDB}"
    GetString(pstr)
      => ComCall(7, this.p, BSTR.Ptr, pstr)
}
struct ITfReverseConversionList extends IUnknown {
    static IID := "{151D69F0-86F4-4674-B721-56911E797F47}"
    GetLength(puIndex)
      => ComCall(3, this.p, UInt32.Ptr, puIndex)
    GetString(uIndex, pbstr)
      => ComCall(4, this.p, UInt32, uIndex, BSTR.Ptr, pbstr)
}
struct ITfReverseConversion extends IUnknown {
    static IID := "{A415E162-157D-417D-8A8C-0AB26C7D2781}"
    DoReverseConversion(lpstr, ppList)
      => ComCall(3, this.p, "Str", lpstr, ITfReverseConversionList.Ptr, ppList)
}
struct ITfReverseConversionMgr extends IUnknown {
    static IID := "{B643C236-C493-41B6-ABB3-692412775CC4}"
    GetReverseConversion(langid, guidProfile, dwflag, ppReverseConversion)
      => ComCall(3, this.p, UInt16, langid, GUID.Ptr, guidProfile, UInt32, dwflag, ITfReverseConversion.Ptr, ppReverseConversion)
}
struct ITfCandidateString extends IUnknown {
    static IID := "{581F317E-FD9D-443F-B972-ED00467C5D40}"
    GetString(pbstr)
      => ComCall(3, this.p, BSTR.Ptr, pbstr)
    GetIndex(pnIndex)
      => ComCall(4, this.p, UInt32.Ptr, pnIndex)
}
struct IEnumTfCandidates extends IUnknown {
    static IID := "{DEFB1926-6C80-4CE8-87D4-D6B72B812BDE}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfCandidates.Ptr, ppEnum)
    Next(ppCand, pcFetched)
      => ComCall(4, this.p, UInt32, ppCand.Length, ITfCandidateString.Ptr, ppCand, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct TfCandidateResult extends Int32 {
    static CAND_FINALIZED := 0
    static CAND_SELECTED := 1
    static CAND_CANCELED := 2
}
struct ITfCandidateList extends IUnknown {
    static IID := "{A3AD50FB-9BDB-49E3-A843-6C76520FBF5D}"
    EnumCandidates(ppEnum)
      => ComCall(3, this.p, IEnumTfCandidates.Ptr, ppEnum)
    GetCandidate(nIndex, ppCand)
      => ComCall(4, this.p, UInt32, nIndex, ITfCandidateString.Ptr, ppCand)
    GetCandidateNum(pnCnt)
      => ComCall(5, this.p, UInt32.Ptr, pnCnt)
    SetResult(nIndex, imcr)
      => ComCall(6, this.p, UInt32, nIndex, TfCandidateResult, imcr)
}
struct ITfFnReconversion extends ITfFunction {
    static IID := "{4CEA93C0-0A58-11D3-8DF0-00105A2799B5}"
    QueryRange(pRange, ppNewRange, pfConvertable)
      => ComCall(4, this.p, ITfRange, pRange, ITfRange.Ptr, ppNewRange, BOOL.Ptr, pfConvertable)
    GetReconversion(pRange, ppCandList)
      => ComCall(5, this.p, ITfRange, pRange, ITfCandidateList.Ptr, ppCandList)
    Reconvert(pRange)
      => ComCall(6, this.p, ITfRange, pRange)
}
struct ITfFnPlayBack extends ITfFunction {
    static IID := "{A3A416A4-0F64-11D3-B5B7-00C04FC324A1}"
    QueryRange(pRange, ppNewRange, pfPlayable)
      => ComCall(4, this.p, ITfRange, pRange, ITfRange.Ptr, ppNewRange, BOOL.Ptr, pfPlayable)
    Play(pRange)
      => ComCall(5, this.p, ITfRange, pRange)
}
struct ITfFnLangProfileUtil extends ITfFunction {
    static IID := "{A87A8574-A6C1-4E15-99F0-3D3965F548EB}"
    RegisterActiveProfiles()
      => ComCall(4, this.p)
    IsProfileAvailableForLang(langid, pfAvailable)
      => ComCall(5, this.p, UInt16, langid, BOOL.Ptr, pfAvailable)
}
struct ITfFnConfigure extends ITfFunction {
    static IID := "{88F567C6-1757-49F8-A1B2-89234C1EEFF9}"
    Show(hwndParent, langid, rguidProfile)
      => ComCall(4, this.p, HWND, hwndParent, UInt16, langid, GUID.Ptr, rguidProfile)
}
struct ITfFnConfigureRegisterWord extends ITfFunction {
    static IID := "{BB95808A-6D8F-4BCA-8400-5390B586AEDF}"
    Show(hwndParent, langid, rguidProfile, bstrRegistered)
      => ComCall(4, this.p, HWND, hwndParent, UInt16, langid, GUID.Ptr, rguidProfile, BSTR, bstrRegistered)
}
struct ITfFnConfigureRegisterEudc extends ITfFunction {
    static IID := "{B5E26FF5-D7AD-4304-913F-21A2ED95A1B0}"
    Show(hwndParent, langid, rguidProfile, bstrRegistered)
      => ComCall(4, this.p, HWND, hwndParent, UInt16, langid, GUID.Ptr, rguidProfile, BSTR, bstrRegistered)
}
struct ITfFnShowHelp extends ITfFunction {
    static IID := "{5AB1D30C-094D-4C29-8EA5-0BF59BE87BF3}"
    Show(hwndParent)
      => ComCall(4, this.p, HWND, hwndParent)
}
struct ITfFnBalloon extends IUnknown {
    static IID := "{3BAB89E4-5FBE-45F4-A5BC-DCA36AD225A8}"
    UpdateBalloon(style, pch)
      => ComCall(3, this.p, TfLBBalloonStyle, style, "Str", pch, UInt32, pch.Length)
}
struct TfSapiObject extends Int32 {
    static GETIF_RESMGR := 0
    static GETIF_RECOCONTEXT := 1
    static GETIF_RECOGNIZER := 2
    static GETIF_VOICE := 3
    static GETIF_DICTGRAM := 4
    static GETIF_RECOGNIZERNOINIT := 5
}
struct ITfFnGetSAPIObject extends ITfFunction {
    static IID := "{5C0AB7EA-167D-4F59-BFB5-4693755E90CA}"
    Get(sObj, ppunk)
      => ComCall(4, this.p, TfSapiObject, sObj, IUnknown.Ptr, ppunk)
}
struct ITfFnPropertyUIStatus extends ITfFunction {
    static IID := "{2338AC6E-2B9D-44C0-A75E-EE64F256B3BD}"
    GetStatus(refguidProp, pdw)
      => ComCall(4, this.p, GUID.Ptr, refguidProp, UInt32.Ptr, pdw)
    SetStatus(refguidProp, dw)
      => ComCall(5, this.p, GUID.Ptr, refguidProp, UInt32, dw)
}
struct IEnumSpeechCommands extends IUnknown {
    static IID := "{8C5DAC4F-083C-4B85-A4C9-71746048ADCA}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumSpeechCommands.Ptr, ppEnum)
    Next(pSpCmds, pcFetched)
      => ComCall(4, this.p, UInt32, pSpCmds.Length, UInt16.Ptr.Ptr, pSpCmds, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ISpeechCommandProvider extends IUnknown {
    static IID := "{38E09D4C-586D-435A-B592-C8A86691DEC6}"
    EnumSpeechCommands(langid, ppEnum)
      => ComCall(3, this.p, UInt16, langid, IEnumSpeechCommands.Ptr, ppEnum)
    ProcessCommand(pszCommand, langid)
      => ComCall(4, this.p, "Str", pszCommand, UInt32, pszCommand.Length, UInt16, langid)
}
struct ITfFnCustomSpeechCommand extends ITfFunction {
    static IID := "{FCA6C349-A12F-43A3-8DD6-5A5A4282577B}"
    SetSpeechCommandProvider(pspcmdProvider)
      => ComCall(4, this.p, IUnknown, pspcmdProvider)
}
struct ITfFnLMProcessor extends ITfFunction {
    static IID := "{7AFBF8E7-AC4B-4082-B058-890899D3A010}"
    QueryRange(pRange, ppNewRange, pfAccepted)
      => ComCall(4, this.p, ITfRange, pRange, ITfRange.Ptr, ppNewRange, BOOL.Ptr, pfAccepted)
    QueryLangID(langid, pfAccepted)
      => ComCall(5, this.p, UInt16, langid, BOOL.Ptr, pfAccepted)
    GetReconversion(pRange, ppCandList)
      => ComCall(6, this.p, ITfRange, pRange, ITfCandidateList.Ptr, ppCandList)
    Reconvert(pRange)
      => ComCall(7, this.p, ITfRange, pRange)
    QueryKey(fUp, vKey, lparamKeydata, pfInterested)
      => ComCall(8, this.p, BOOL, fUp, WPARAM, vKey, LPARAM, lparamKeydata, BOOL.Ptr, pfInterested)
    InvokeKey(fUp, vKey, lparamKeyData)
      => ComCall(9, this.p, BOOL, fUp, WPARAM, vKey, LPARAM, lparamKeyData)
    InvokeFunc(pic, refguidFunc)
      => ComCall(10, this.p, ITfContext, pic, GUID.Ptr, refguidFunc)
}
struct ITfFnLMInternal extends ITfFnLMProcessor {
    static IID := "{04B825B1-AC9A-4F7B-B5AD-C7168F1EE445}"
    ProcessLattice(pRange)
      => ComCall(11, this.p, ITfRange, pRange)
}
struct TF_LMLATTELEMENT {
    dwFrameStart : UInt32
    dwFrameLen : UInt32
    dwFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    bstrText : BSTR
    struct _Anonymous_e__Union {
        union {
            iCost : Int32
        }
    }
}
struct IEnumTfLatticeElements extends IUnknown {
    static IID := "{56988052-47DA-4A05-911A-E3D941F17145}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumTfLatticeElements.Ptr, ppEnum)
    Next(rgsElements, pcFetched)
      => ComCall(4, this.p, UInt32, rgsElements.Length, TF_LMLATTELEMENT.Ptr, rgsElements, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct ITfLMLattice extends IUnknown {
    static IID := "{D4236675-A5BF-4570-9D42-5D6D7B02D59B}"
    QueryType(rguidType, pfSupported)
      => ComCall(3, this.p, GUID.Ptr, rguidType, BOOL.Ptr, pfSupported)
    EnumLatticeElements(dwFrameStart, rguidType, ppEnum)
      => ComCall(4, this.p, UInt32, dwFrameStart, GUID.Ptr, rguidType, IEnumTfLatticeElements.Ptr, ppEnum)
}
struct ITfFnAdviseText extends ITfFunction {
    static IID := "{3527268B-7D53-4DD9-92B7-7296AE461249}"
    OnTextUpdate(pRange, pchText)
      => ComCall(4, this.p, ITfRange, pRange, "Str", pchText, Int32, pchText.Length)
    OnLatticeUpdate(pRange, pLattice)
      => ComCall(5, this.p, ITfRange, pRange, ITfLMLattice, pLattice)
}
struct ITfFnSearchCandidateProvider extends ITfFunction {
    static IID := "{87A2AD8F-F27B-4920-8501-67602280175D}"
    GetSearchCandidates(bstrQuery, bstrApplicationId, pplist)
      => ComCall(4, this.p, BSTR, bstrQuery, BSTR, bstrApplicationId, ITfCandidateList.Ptr, pplist)
    SetResult(bstrQuery, bstrApplicationID, bstrResult)
      => ComCall(5, this.p, BSTR, bstrQuery, BSTR, bstrApplicationID, BSTR, bstrResult)
}
struct TfIntegratableCandidateListSelectionStyle extends Int32 {
    static STYLE_ACTIVE_SELECTION := 0
    static STYLE_IMPLIED_SELECTION := 1
}
struct ITfIntegratableCandidateListUIElement extends IUnknown {
    static IID := "{C7A6F54F-B180-416F-B2BF-7BF2E4683D7B}"
    SetIntegrationStyle(guidIntegrationStyle)
      => ComCall(3, this.p, GUID, guidIntegrationStyle)
    GetSelectionStyle(ptfSelectionStyle)
      => ComCall(4, this.p, TfIntegratableCandidateListSelectionStyle.Ptr, ptfSelectionStyle)
    OnKeyDown(wParam1, lParam1, pfEaten)
      => ComCall(5, this.p, WPARAM, wParam1, LPARAM, lParam1, BOOL.Ptr, pfEaten)
    ShowCandidateNumbers(pfShow)
      => ComCall(6, this.p, BOOL.Ptr, pfShow)
    FinalizeExactCompositionString()
      => ComCall(7, this.p)
}
struct TKBLayoutType extends Int32 {
    static TKBLT_UNDEFINED := 0
    static TKBLT_CLASSIC := 1
    static TKBLT_OPTIMIZED := 2
}
struct ITfFnGetPreferredTouchKeyboardLayout extends ITfFunction {
    static IID := "{5F309A41-590A-4ACC-A97F-D8EFFF13FDFC}"
    GetLayout(pTKBLayoutType, pwPreferredLayoutId)
      => ComCall(4, this.p, TKBLayoutType.Ptr, pTKBLayoutType, UInt16.Ptr, pwPreferredLayoutId)
}
struct ITfFnGetLinguisticAlternates extends ITfFunction {
    static IID := "{EA163CE2-7A65-4506-82A3-C528215DA64E}"
    GetAlternates(pRange, ppCandidateList)
      => ComCall(4, this.p, ITfRange, pRange, ITfCandidateList.Ptr, ppCandidateList)
}
struct IUIManagerEventSink extends IUnknown {
    static IID := "{CD91D690-A7E8-4265-9B38-8BB3BBABA7DE}"
    OnWindowOpening(prcBounds)
      => ComCall(3, this.p, RECT.Ptr, prcBounds)
    OnWindowOpened(prcBounds)
      => ComCall(4, this.p, RECT.Ptr, prcBounds)
    OnWindowUpdating(prcUpdatedBounds)
      => ComCall(5, this.p, RECT.Ptr, prcUpdatedBounds)
    OnWindowUpdated(prcUpdatedBounds)
      => ComCall(6, this.p, RECT.Ptr, prcUpdatedBounds)
    OnWindowClosing()
      => ComCall(7, this.p)
    OnWindowClosed()
      => ComCall(8, this.p)
}
struct InputScope extends Int32 {
    static IS_DEFAULT := 0
    static IS_URL := 1
    static IS_FILE_FULLFILEPATH := 2
    static IS_FILE_FILENAME := 3
    static IS_EMAIL_USERNAME := 4
    static IS_EMAIL_SMTPEMAILADDRESS := 5
    static IS_LOGINNAME := 6
    static IS_PERSONALNAME_FULLNAME := 7
    static IS_PERSONALNAME_PREFIX := 8
    static IS_PERSONALNAME_GIVENNAME := 9
    static IS_PERSONALNAME_MIDDLENAME := 10
    static IS_PERSONALNAME_SURNAME := 11
    static IS_PERSONALNAME_SUFFIX := 12
    static IS_ADDRESS_FULLPOSTALADDRESS := 13
    static IS_ADDRESS_POSTALCODE := 14
    static IS_ADDRESS_STREET := 15
    static IS_ADDRESS_STATEORPROVINCE := 16
    static IS_ADDRESS_CITY := 17
    static IS_ADDRESS_COUNTRYNAME := 18
    static IS_ADDRESS_COUNTRYSHORTNAME := 19
    static IS_CURRENCY_AMOUNTANDSYMBOL := 20
    static IS_CURRENCY_AMOUNT := 21
    static IS_DATE_FULLDATE := 22
    static IS_DATE_MONTH := 23
    static IS_DATE_DAY := 24
    static IS_DATE_YEAR := 25
    static IS_DATE_MONTHNAME := 26
    static IS_DATE_DAYNAME := 27
    static IS_DIGITS := 28
    static IS_NUMBER := 29
    static IS_ONECHAR := 30
    static IS_PASSWORD := 31
    static IS_TELEPHONE_FULLTELEPHONENUMBER := 32
    static IS_TELEPHONE_COUNTRYCODE := 33
    static IS_TELEPHONE_AREACODE := 34
    static IS_TELEPHONE_LOCALNUMBER := 35
    static IS_TIME_FULLTIME := 36
    static IS_TIME_HOUR := 37
    static IS_TIME_MINORSEC := 38
    static IS_NUMBER_FULLWIDTH := 39
    static IS_ALPHANUMERIC_HALFWIDTH := 40
    static IS_ALPHANUMERIC_FULLWIDTH := 41
    static IS_CURRENCY_CHINESE := 42
    static IS_BOPOMOFO := 43
    static IS_HIRAGANA := 44
    static IS_KATAKANA_HALFWIDTH := 45
    static IS_KATAKANA_FULLWIDTH := 46
    static IS_HANJA := 47
    static IS_HANGUL_HALFWIDTH := 48
    static IS_HANGUL_FULLWIDTH := 49
    static IS_SEARCH := 50
    static IS_FORMULA := 51
    static IS_SEARCH_INCREMENTAL := 52
    static IS_CHINESE_HALFWIDTH := 53
    static IS_CHINESE_FULLWIDTH := 54
    static IS_NATIVE_SCRIPT := 55
    static IS_YOMI := 56
    static IS_TEXT := 57
    static IS_CHAT := 58
    static IS_NAME_OR_PHONENUMBER := 59
    static IS_EMAILNAME_OR_ADDRESS := 60
    static IS_PRIVATE := 61
    static IS_MAPS := 62
    static IS_NUMERIC_PASSWORD := 63
    static IS_NUMERIC_PIN := 64
    static IS_ALPHANUMERIC_PIN := 65
    static IS_ALPHANUMERIC_PIN_SET := 66
    static IS_FORMULA_NUMBER := 67
    static IS_CHAT_WITHOUT_EMOJI := 68
    static IS_PHRASELIST := -1
    static IS_REGULAREXPRESSION := -2
    static IS_SRGS := -3
    static IS_XML := -4
    static IS_ENUMSTRING := -5
}
struct ITfInputScope extends IUnknown {
    static IID := "{FDE1EAEE-6924-4CDF-91E7-DA38CFF5559D}"
    GetInputScopes(pprgInputScopes)
      => ComCall(3, this.p, InputScope.Ptr.Ptr, pprgInputScopes, UInt32.Ptr, pprgInputScopes.Length)
    GetPhrase(ppbstrPhrases)
      => ComCall(4, this.p, BSTR.Ptr.Ptr, ppbstrPhrases, UInt32.Ptr, ppbstrPhrases.Length)
    GetRegularExpression(pbstrRegExp)
      => ComCall(5, this.p, BSTR.Ptr, pbstrRegExp)
    GetSRGS(pbstrSRGS)
      => ComCall(6, this.p, BSTR.Ptr, pbstrSRGS)
    GetXML(pbstrXML)
      => ComCall(7, this.p, BSTR.Ptr, pbstrXML)
}
struct ITfInputScope2 extends ITfInputScope {
    static IID := "{5731EAA0-6BC2-4681-A532-92FBB74D7C41}"
    EnumWordList(ppEnumString)
      => ComCall(8, this.p, IEnumString.Ptr, ppEnumString)
}
struct ITfMSAAControl extends IUnknown {
    static IID := "{B5F8FB3B-393F-4F7C-84CB-504924C2705A}"
    SystemEnableMSAA()
      => ComCall(3, this.p)
    SystemDisableMSAA()
      => ComCall(4, this.p)
}
struct IInternalDocWrap extends IUnknown {
    static IID := "{E1AA6466-9DB4-40BA-BE03-77C38E8E60B2}"
    NotifyRevoke()
      => ComCall(3, this.p)
}
struct ITextStoreACPEx extends IUnknown {
    static IID := "{A2DE3BC2-3D8E-11D3-81A9-F753FBE61A00}"
    ScrollToRect(acpStart, acpEnd, rc, dwPosition)
      => ComCall(3, this.p, Int32, acpStart, Int32, acpEnd, RECT, rc, UInt32, dwPosition)
}
struct ITextStoreAnchorEx extends IUnknown {
    static IID := "{A2DE3BC1-3D8E-11D3-81A9-F753FBE61A00}"
    ScrollToRect(pStart, pEnd, rc, dwPosition)
      => ComCall(3, this.p, IAnchor, pStart, IAnchor, pEnd, RECT, rc, UInt32, dwPosition)
}
struct ITextStoreACPSinkEx extends ITextStoreACPSink {
    static IID := "{2BDF9464-41E2-43E3-950C-A6865BA25CD4}"
    OnDisconnect()
      => ComCall(11, this.p)
}
struct ITextStoreSinkAnchorEx extends ITextStoreAnchorSink {
    static IID := "{25642426-028D-4474-977B-111BB114FE3E}"
    OnDisconnect()
      => ComCall(11, this.p)
}
struct IAccDictionary extends IUnknown {
    static IID := "{1DC4CB5F-D737-474D-ADE9-5CCFC9BC1CC9}"
    GetLocalizedString(Term, lcid, pResult, plcid)
      => ComCall(3, this.p, GUID.Ptr, Term, UInt32, lcid, BSTR.Ptr, pResult, UInt32.Ptr, plcid)
    GetParentTerm(Term, pParentTerm)
      => ComCall(4, this.p, GUID.Ptr, Term, GUID.Ptr, pParentTerm)
    GetMnemonicString(Term, pResult)
      => ComCall(5, this.p, GUID.Ptr, Term, BSTR.Ptr, pResult)
    LookupMnemonicTerm(bstrMnemonic, pTerm)
      => ComCall(6, this.p, BSTR, bstrMnemonic, GUID.Ptr, pTerm)
    ConvertValueToString(Term, lcid, varValue, pbstrResult, plcid)
      => ComCall(7, this.p, GUID.Ptr, Term, UInt32, lcid, VARIANT, varValue, BSTR.Ptr, pbstrResult, UInt32.Ptr, plcid)
}
struct IVersionInfo extends IUnknown {
    static IID := "{401518EC-DB00-4611-9B29-2A0E4B9AFA85}"
    GetSubcomponentCount(ulSub, ulCount)
      => ComCall(3, this.p, UInt32, ulSub, UInt32.Ptr, ulCount)
    GetImplementationID(ulSub, implid)
      => ComCall(4, this.p, UInt32, ulSub, GUID.Ptr, implid)
    GetBuildVersion(ulSub, pdwMajor, pdwMinor)
      => ComCall(5, this.p, UInt32, ulSub, UInt32.Ptr, pdwMajor, UInt32.Ptr, pdwMinor)
    GetComponentDescription(ulSub, pImplStr)
      => ComCall(6, this.p, UInt32, ulSub, BSTR.Ptr, pImplStr)
    GetInstanceDescription(ulSub, pImplStr)
      => ComCall(7, this.p, UInt32, ulSub, BSTR.Ptr, pImplStr)
}
struct ICoCreateLocally extends IUnknown {
    static IID := "{03DE00AA-F272-41E3-99CB-03C5E8114EA0}"
    CoCreateLocally(rclsid, dwClsContext, riid, punk, riidParam, punkParam, varParam)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt32, dwClsContext, GUID.Ptr, riid, IUnknown.Ptr, punk, GUID.Ptr, riidParam, IUnknown, punkParam, VARIANT, varParam)
}
struct ICoCreatedLocally extends IUnknown {
    static IID := "{0A53EB6C-1908-4742-8CFF-2CEE2E93F94C}"
    LocalInit(punkLocalObject, riidParam, punkParam, varParam)
      => ComCall(3, this.p, IUnknown, punkLocalObject, GUID.Ptr, riidParam, IUnknown, punkParam, VARIANT, varParam)
}
struct IAccStore extends IUnknown {
    static IID := "{E2CD4A63-2B72-4D48-B739-95E4765195BA}"
    Register(riid, punk)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk)
    Unregister(punk)
      => ComCall(4, this.p, IUnknown, punk)
    GetDocuments(enumUnknown)
      => ComCall(5, this.p, IEnumUnknown.Ptr, enumUnknown)
    LookupByHWND(hWnd1, riid, ppunk)
      => ComCall(6, this.p, HWND, hWnd1, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    LookupByPoint(pt, riid, ppunk)
      => ComCall(7, this.p, POINT, pt, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    OnDocumentFocus(punk)
      => ComCall(8, this.p, IUnknown, punk)
    GetFocused(riid, ppunk)
      => ComCall(9, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
}
struct IAccServerDocMgr extends IUnknown {
    static IID := "{AD7C73CF-6DD5-4855-ABC2-B04BAD5B9153}"
    NewDocument(riid, punk)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk)
    RevokeDocument(punk)
      => ComCall(4, this.p, IUnknown, punk)
    OnDocumentFocus(punk)
      => ComCall(5, this.p, IUnknown, punk)
}
struct IAccClientDocMgr extends IUnknown {
    static IID := "{4C896039-7B6D-49E6-A8C1-45116A98292B}"
    GetDocuments(enumUnknown)
      => ComCall(3, this.p, IEnumUnknown.Ptr, enumUnknown)
    LookupByHWND(hWnd1, riid, ppunk)
      => ComCall(4, this.p, HWND, hWnd1, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    LookupByPoint(pt, riid, ppunk)
      => ComCall(5, this.p, POINT, pt, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    GetFocused(riid, ppunk)
      => ComCall(6, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
}
struct IDocWrap extends IUnknown {
    static IID := "{DCD285FE-0BE0-43BD-99C9-AAAEC513C555}"
    SetDoc(riid, punk)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, punk)
    GetWrappedDoc(riid, ppunk)
      => ComCall(4, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
}
struct IClonableWrapper extends IUnknown {
    static IID := "{B33E75FF-E84C-4DCA-A25C-33B8DC003374}"
    CloneNewWrapper(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct ITfSpeechUIServer extends IUnknown {
    static IID := "{90E9A944-9244-489F-A78F-DE67AFC013A7}"
    Initialize()
      => ComCall(3, this.p)
    ShowUI(fShow)
      => ComCall(4, this.p, BOOL, fShow)
    UpdateBalloon(style, pch)
      => ComCall(5, this.p, TfLBBalloonStyle, style, "Str", pch, UInt32, pch.Length)
}
