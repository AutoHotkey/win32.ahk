#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, COLORREF, HINSTANCE, HRESULT, HWND, POINT, PSTR, PWSTR, RECT}
#Import "..\System.Com\Types.ahk" {IPersistStreamInit, IStream, IUnknown}
#Import "..\System.Search\Types.ahk" {IStemmer}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {NMHDR}

struct HTML_HELP_COMMAND extends Int32 {
    static HH_DISPLAY_TOPIC := 0
    static HH_HELP_FINDER := 0
    static HH_DISPLAY_TOC := 1
    static HH_DISPLAY_INDEX := 2
    static HH_DISPLAY_SEARCH := 3
    static HH_SET_WIN_TYPE := 4
    static HH_GET_WIN_TYPE := 5
    static HH_GET_WIN_HANDLE := 6
    static HH_ENUM_INFO_TYPE := 7
    static HH_SET_INFO_TYPE := 8
    static HH_SYNC := 9
    static HH_RESERVED1 := 10
    static HH_RESERVED2 := 11
    static HH_RESERVED3 := 12
    static HH_KEYWORD_LOOKUP := 13
    static HH_DISPLAY_TEXT_POPUP := 14
    static HH_HELP_CONTEXT := 15
    static HH_TP_HELP_CONTEXTMENU := 16
    static HH_TP_HELP_WM_HELP := 17
    static HH_CLOSE_ALL := 18
    static HH_ALINK_LOOKUP := 19
    static HH_GET_LAST_ERROR := 20
    static HH_ENUM_CATEGORY := 21
    static HH_ENUM_CATEGORY_IT := 22
    static HH_RESET_IT_FILTER := 23
    static HH_SET_INCLUSIVE_FILTER := 24
    static HH_SET_EXCLUSIVE_FILTER := 25
    static HH_INITIALIZE := 28
    static HH_UNINITIALIZE := 29
    static HH_SET_QUERYSERVICE := 30
    static HH_PRETRANSLATEMESSAGE := 253
    static HH_SET_GLOBAL_PROPERTY := 252
    static HH_SAFE_DISPLAY_TOPIC := 32
    static HH_MAX_TABS := 19
    static HH_MAX_TABS_CUSTOM := 9
    static HH_FTS_DEFAULT_PROXIMITY := -1
}
struct HHN_NOTIFY {
    hdr : NMHDR
    pszUrl : PSTR
}
struct HH_POPUP {
    cbStruct : Int32
    hinst : HINSTANCE
    idString : UInt32
    pszText : Int8.Ptr
    pt : POINT
    clrForeground : COLORREF
    clrBackground : COLORREF
    rcMargins : RECT
    pszFont : Int8.Ptr
}
struct HH_AKLINK {
    cbStruct : Int32
    fReserved : BOOL
    pszKeywords : Int8.Ptr
    pszUrl : Int8.Ptr
    pszMsgText : Int8.Ptr
    pszMsgTitle : Int8.Ptr
    pszWindow : Int8.Ptr
    fIndexOnFail : BOOL
}
struct HH_ENUM_IT {
    cbStruct : Int32
    iType : Int32
    pszCatName : PSTR
    pszITName : PSTR
    pszITDescription : PSTR
}
struct HH_ENUM_CAT {
    cbStruct : Int32
    pszCatName : PSTR
    pszCatDescription : PSTR
}
struct HH_SET_INFOTYPE {
    cbStruct : Int32
    pszCatName : PSTR
    pszInfoTypeName : PSTR
}
struct HH_FTS_QUERY {
    cbStruct : Int32
    fUniCodeStrings : BOOL
    pszSearchQuery : Int8.Ptr
    iProximity : Int32
    fStemmedSearch : BOOL
    fTitleOnly : BOOL
    fExecute : BOOL
    pszWindow : Int8.Ptr
}
struct HH_WINTYPE {
    cbStruct : Int32
    fUniCodeStrings : BOOL
    pszType : Int8.Ptr
    fsValidMembers : UInt32
    fsWinProperties : UInt32
    pszCaption : Int8.Ptr
    dwStyles : UInt32
    dwExStyles : UInt32
    rcWindowPos : RECT
    nShowState : Int32
    hwndHelp : HWND
    hwndCaller : HWND
    paInfoTypes : UInt32.Ptr
    hwndToolBar : HWND
    hwndNavigation : HWND
    hwndHTML : HWND
    iNavWidth : Int32
    rcHTML : RECT
    pszToc : Int8.Ptr
    pszIndex : Int8.Ptr
    pszFile : Int8.Ptr
    pszHome : Int8.Ptr
    fsToolBarFlags : UInt32
    fNotExpanded : BOOL
    curNavType : Int32
    tabpos : Int32
    idNotify : Int32
    tabOrder : UInt8[20]
    cHistory : Int32
    pszJump1 : Int8.Ptr
    pszJump2 : Int8.Ptr
    pszUrlJump1 : Int8.Ptr
    pszUrlJump2 : Int8.Ptr
    rcMinSize : RECT
    cbInfoTypes : Int32
    pszCustomTabs : Int8.Ptr
}
struct HHNTRACK {
    hdr : NMHDR
    pszCurUrl : PSTR
    idAction : Int32
    phhWinType : HH_WINTYPE.Ptr
}
struct HH_GPROPID extends Int32 {
    static HH_GPROPID_SINGLETHREAD := 1
    static HH_GPROPID_TOOLBAR_MARGIN := 2
    static HH_GPROPID_UI_LANGUAGE := 3
    static HH_GPROPID_CURRENT_SUBSET := 4
    static HH_GPROPID_CONTENT_LANGUAGE := 5
}
struct HH_GLOBAL_PROPERTY {
    id : HH_GPROPID
    var : VARIANT
}
struct CProperty {
    dwPropID : UInt32
    cbData : UInt32
    dwType : UInt32
    Anonymous : this._Anonymous_e__Union
    fPersist : BOOL
    struct _Anonymous_e__Union {
        union {
            lpszwData : PWSTR
            lpvData : Struct.Ptr
            dwValue : UInt32
        }
    }
}
struct IITPropList extends IPersistStreamInit {
    static IID := "{1F403BB1-9997-11D0-A850-00AA006C7D01}"
    Set(PropID, lpszwString, dwOperation)
      => ComCall(9, this.p, UInt32, PropID, "Str", lpszwString, UInt32, dwOperation)
    Set_2(PropID, lpvData, cbData, dwOperation)
      => ComCall(10, this.p, UInt32, PropID, Struct.Ptr, lpvData, UInt32, cbData, UInt32, dwOperation)
    Set_3(PropID, dwData, dwOperation)
      => ComCall(11, this.p, UInt32, PropID, UInt32, dwData, UInt32, dwOperation)
    Add(Prop)
      => ComCall(12, this.p, CProperty.Ptr, Prop)
    Get(PropID, Property)
      => ComCall(13, this.p, UInt32, PropID, CProperty.Ptr, Property)
    Clear()
      => ComCall(14, this.p)
    SetPersist(fPersist)
      => ComCall(15, this.p, BOOL, fPersist)
    SetPersist_2(PropID, fPersist)
      => ComCall(16, this.p, UInt32, PropID, BOOL, fPersist)
    GetFirst(Property)
      => ComCall(17, this.p, CProperty.Ptr, Property)
    GetNext(Property)
      => ComCall(18, this.p, CProperty.Ptr, Property)
    GetPropCount(cProp)
      => ComCall(19, this.p, Int32.Ptr, cProp)
    SaveHeader(lpvData, dwHdrSize)
      => ComCall(20, this.p, Struct.Ptr, lpvData, UInt32, dwHdrSize)
    SaveData(lpvHeader, dwHdrSize, lpvData, dwBufSize)
      => ComCall(21, this.p, Struct.Ptr, lpvHeader, UInt32, dwHdrSize, Struct.Ptr, lpvData, UInt32, dwBufSize)
    GetHeaderSize(dwHdrSize)
      => ComCall(22, this.p, UInt32.Ptr, dwHdrSize)
    GetDataSize(lpvHeader, dwHdrSize, dwDataSize)
      => ComCall(23, this.p, Struct.Ptr, lpvHeader, UInt32, dwHdrSize, UInt32.Ptr, dwDataSize)
    SaveDataToStream(lpvHeader, dwHdrSize, pStream)
      => ComCall(24, this.p, Struct.Ptr, lpvHeader, UInt32, dwHdrSize, IStream, pStream)
    LoadFromMem(lpvData, dwBufSize)
      => ComCall(25, this.p, Struct.Ptr, lpvData, UInt32, dwBufSize)
    SaveToMem(lpvData, dwBufSize)
      => ComCall(26, this.p, Struct.Ptr, lpvData, UInt32, dwBufSize)
}
struct IITDatabase extends IUnknown {
    static IID := "{8FA0D5A2-DEDF-11D0-9A61-00C04FB68BF7}"
    Open(lpszHost, lpszMoniker, dwFlags)
      => ComCall(3, this.p, "Str", lpszHost, "Str", lpszMoniker, UInt32, dwFlags)
    Close()
      => ComCall(4, this.p)
    CreateObject(rclsid, pdwObjInstance)
      => ComCall(5, this.p, GUID.Ptr, rclsid, UInt32.Ptr, pdwObjInstance)
    GetObject(dwObjInstance, riid, ppvObj)
      => ComCall(6, this.p, UInt32, dwObjInstance, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
    GetObjectPersistence(lpwszObject, dwObjInstance, ppvPersistence, fStream)
      => ComCall(7, this.p, "Str", lpwszObject, UInt32, dwObjInstance, Struct.Ptr.Ptr, ppvPersistence, BOOL, fStream)
}
struct IStemSink extends IUnknown {
    static IID := "{FE77C330-7F42-11CE-BE57-00AA0051FE20}"
    PutAltWord(pwcInBuf, cwc)
      => ComCall(3, this.p, "Str", pwcInBuf, UInt32, cwc)
    PutWord(pwcInBuf, cwc)
      => ComCall(4, this.p, "Str", pwcInBuf, UInt32, cwc)
}
struct IStemmerConfig extends IUnknown {
    static IID := "{8FA0D5A7-DEDF-11D0-9A61-00C04FB68BF7}"
    SetLocaleInfo(dwCodePageID, lcid)
      => ComCall(3, this.p, UInt32, dwCodePageID, UInt32, lcid)
    GetLocaleInfo(pdwCodePageID, plcid)
      => ComCall(4, this.p, UInt32.Ptr, pdwCodePageID, UInt32.Ptr, plcid)
    SetControlInfo(grfStemFlags, dwReserved)
      => ComCall(5, this.p, UInt32, grfStemFlags, UInt32, dwReserved)
    GetControlInfo(pgrfStemFlags, pdwReserved)
      => ComCall(6, this.p, UInt32.Ptr, pgrfStemFlags, UInt32.Ptr, pdwReserved)
    LoadExternalStemmerData(pStream, dwExtDataType)
      => ComCall(7, this.p, IStream, pStream, UInt32, dwExtDataType)
}
struct IWordBreakerConfig extends IUnknown {
    static IID := "{8FA0D5A6-DEDF-11D0-9A61-00C04FB68BF7}"
    SetLocaleInfo(dwCodePageID, lcid)
      => ComCall(3, this.p, UInt32, dwCodePageID, UInt32, lcid)
    GetLocaleInfo(pdwCodePageID, plcid)
      => ComCall(4, this.p, UInt32.Ptr, pdwCodePageID, UInt32.Ptr, plcid)
    SetBreakWordType(dwBreakWordType)
      => ComCall(5, this.p, UInt32, dwBreakWordType)
    GetBreakWordType(pdwBreakWordType)
      => ComCall(6, this.p, UInt32.Ptr, pdwBreakWordType)
    SetControlInfo(grfBreakFlags, dwReserved)
      => ComCall(7, this.p, UInt32, grfBreakFlags, UInt32, dwReserved)
    GetControlInfo(pgrfBreakFlags, pdwReserved)
      => ComCall(8, this.p, UInt32.Ptr, pgrfBreakFlags, UInt32.Ptr, pdwReserved)
    LoadExternalBreakerData(pStream, dwExtDataType)
      => ComCall(9, this.p, IStream, pStream, UInt32, dwExtDataType)
    SetWordStemmer(rclsid, pStemmer)
      => ComCall(10, this.p, GUID.Ptr, rclsid, IStemmer, pStemmer)
    GetWordStemmer(ppStemmer)
      => ComCall(11, this.p, IStemmer.Ptr, ppStemmer)
}
struct PRIORITY extends Int32 {
    static PRIORITY_LOW := 0
    static PRIORITY_NORMAL := 1
    static PRIORITY_HIGH := 2
}
struct ROWSTATUS {
    lRowFirst : Int32
    cRows : Int32
    cProperties : Int32
    cRowsTotal : Int32
}
struct COLUMNSTATUS {
    cPropCount : Int32
    cPropsLoaded : Int32
}
struct PFNCOLHEAPFREE extends FunctionPointer {
    static Types := [Struct.Ptr, Int32]
}
struct IITResultSet extends IUnknown {
    static IID := "{3BB91D41-998B-11D0-A850-00AA006C7D01}"
    SetColumnPriority(lColumnIndex, ColumnPriority)
      => ComCall(3, this.p, Int32, lColumnIndex, PRIORITY, ColumnPriority)
    SetColumnHeap(lColumnIndex, lpvHeap, pfnColHeapFree1)
      => ComCall(4, this.p, Int32, lColumnIndex, Struct.Ptr, lpvHeap, PFNCOLHEAPFREE, pfnColHeapFree1)
    SetKeyProp(PropID)
      => ComCall(5, this.p, UInt32, PropID)
    Add(PropID, dwDefaultData, Priority1)
      => ComCall(6, this.p, UInt32, PropID, UInt32, dwDefaultData, PRIORITY, Priority1)
    Add_2(PropID, lpszwDefault, Priority1)
      => ComCall(7, this.p, UInt32, PropID, "Str", lpszwDefault, PRIORITY, Priority1)
    Add_3(PropID, lpvDefaultData, cbData, Priority1)
      => ComCall(8, this.p, UInt32, PropID, Struct.Ptr, lpvDefaultData, UInt32, cbData, PRIORITY, Priority1)
    Add_4(lpvHdr)
      => ComCall(9, this.p, Struct.Ptr, lpvHdr)
    Append(lpvHdr, lpvData)
      => ComCall(10, this.p, Struct.Ptr, lpvHdr, Struct.Ptr, lpvData)
    Set(lRowIndex, lColumnIndex, lpvData, cbData)
      => ComCall(11, this.p, Int32, lRowIndex, Int32, lColumnIndex, Struct.Ptr, lpvData, UInt32, cbData)
    Set_2(lRowIndex, lColumnIndex, lpwStr)
      => ComCall(12, this.p, Int32, lRowIndex, Int32, lColumnIndex, "Str", lpwStr)
    Set_3(lRowIndex, lColumnIndex, dwData)
      => ComCall(13, this.p, Int32, lRowIndex, Int32, lColumnIndex, IntPtr, dwData)
    Set_4(lRowIndex, lpvHdr, lpvData)
      => ComCall(14, this.p, Int32, lRowIndex, Struct.Ptr, lpvHdr, Struct.Ptr, lpvData)
    Copy(pRSCopy)
      => ComCall(15, this.p, IITResultSet, pRSCopy)
    AppendRows(pResSrc, lRowSrcFirst, cSrcRows, lRowFirstDest)
      => ComCall(16, this.p, IITResultSet, pResSrc, Int32, lRowSrcFirst, Int32, cSrcRows, Int32.Ptr, lRowFirstDest)
    Get(lRowIndex, lColumnIndex, Prop)
      => ComCall(17, this.p, Int32, lRowIndex, Int32, lColumnIndex, CProperty.Ptr, Prop)
    GetKeyProp(KeyPropID)
      => ComCall(18, this.p, UInt32.Ptr, KeyPropID)
    GetColumnPriority(lColumnIndex, ColumnPriority)
      => ComCall(19, this.p, Int32, lColumnIndex, PRIORITY.Ptr, ColumnPriority)
    GetRowCount(lNumberOfRows)
      => ComCall(20, this.p, Int32.Ptr, lNumberOfRows)
    GetColumnCount(lNumberOfColumns)
      => ComCall(21, this.p, Int32.Ptr, lNumberOfColumns)
    GetColumn(lColumnIndex, PropID, dwType, lpvDefaultValue, cbSize, ColumnPriority)
      => ComCall(22, this.p, Int32, lColumnIndex, UInt32.Ptr, PropID, UInt32.Ptr, dwType, Struct.Ptr.Ptr, lpvDefaultValue, UInt32.Ptr, cbSize, PRIORITY.Ptr, ColumnPriority)
    GetColumn_2(lColumnIndex, PropID)
      => ComCall(23, this.p, Int32, lColumnIndex, UInt32.Ptr, PropID)
    GetColumnFromPropID(PropID, lColumnIndex)
      => ComCall(24, this.p, UInt32, PropID, Int32.Ptr, lColumnIndex)
    Clear()
      => ComCall(25, this.p)
    ClearRows()
      => ComCall(26, this.p)
    Free()
      => ComCall(27, this.p)
    IsCompleted()
      => ComCall(28, this.p)
    Cancel()
      => ComCall(29, this.p)
    Pause(fPause)
      => ComCall(30, this.p, BOOL, fPause)
    GetRowStatus(lRowFirst, cRows, lpRowStatus)
      => ComCall(31, this.p, Int32, lRowFirst, Int32, cRows, ROWSTATUS.Ptr, lpRowStatus)
    GetColumnStatus(lpColStatus)
      => ComCall(32, this.p, COLUMNSTATUS.Ptr, lpColStatus)
}
