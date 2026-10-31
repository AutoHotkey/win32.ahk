#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HRESULT, HWND, LPARAM, LRESULT, POINT, PSTR, PWSTR, RECT, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, LOGFONTA, LOGFONTW}
#Import "..\System.Com\Types.ahk" {IClassFactory, IUnknown, SAFEARRAY}
#Import "..\UI.Input.KeyboardAndMouse\Types.ahk" {HKL}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON, MSG}

struct SET_COMPOSITION_STRING_TYPE extends UInt32 {
    static SCS_SETSTR := 9
    static SCS_CHANGEATTR := 18
    static SCS_CHANGECLAUSE := 36
    static SCS_SETRECONVERTSTRING := 65536
    static SCS_QUERYRECONVERTSTRING := 131072
}
struct GET_GUIDE_LINE_TYPE extends UInt32 {
    static GGL_LEVEL := 1
    static GGL_INDEX := 2
    static GGL_STRING := 3
    static GGL_PRIVATE := 4
}
struct NOTIFY_IME_INDEX extends UInt32 {
    static CPS_CANCEL := 4
    static CPS_COMPLETE := 1
    static CPS_CONVERT := 2
    static CPS_REVERT := 3
}
struct NOTIFY_IME_ACTION extends UInt32 {
    static NI_CHANGECANDIDATELIST := 19
    static NI_CLOSECANDIDATE := 17
    static NI_COMPOSITIONSTR := 21
    static NI_IMEMENUSELECTED := 24
    static NI_OPENCANDIDATE := 16
    static NI_SELECTCANDIDATESTR := 18
    static NI_SETCANDIDATE_PAGESIZE := 23
    static NI_SETCANDIDATE_PAGESTART := 22
}
struct GET_CONVERSION_LIST_FLAG extends UInt32 {
    static GCL_CONVERSION := 1
    static GCL_REVERSECONVERSION := 2
    static GCL_REVERSE_LENGTH := 3
}
struct IME_PAD_REQUEST_FLAGS extends UInt32 {
    static IMEPADREQ_INSERTSTRING := 4097
    static IMEPADREQ_SENDCONTROL := 4100
    static IMEPADREQ_SETAPPLETSIZE := 4104
    static IMEPADREQ_GETCOMPOSITIONSTRING := 4102
    static IMEPADREQ_GETCOMPOSITIONSTRINGINFO := 4108
    static IMEPADREQ_DELETESTRING := 4112
    static IMEPADREQ_CHANGESTRING := 4113
    static IMEPADREQ_GETAPPLHWND := 4116
    static IMEPADREQ_FORCEIMEPADWINDOWSHOW := 4117
    static IMEPADREQ_POSTMODALNOTIFY := 4118
    static IMEPADREQ_GETDEFAULTUILANGID := 4119
    static IMEPADREQ_GETAPPLETUISTYLE := 4121
    static IMEPADREQ_SETAPPLETUISTYLE := 4122
    static IMEPADREQ_ISAPPLETACTIVE := 4123
    static IMEPADREQ_ISIMEPADWINDOWVISIBLE := 4124
    static IMEPADREQ_SETAPPLETMINMAXSIZE := 4125
    static IMEPADREQ_GETCONVERSIONSTATUS := 4126
    static IMEPADREQ_GETVERSION := 4127
    static IMEPADREQ_GETCURRENTIMEINFO := 4128
}
struct IME_CONVERSION_MODE extends UInt32 {
    static IME_CMODE_ALPHANUMERIC := 0
    static IME_CMODE_NATIVE := 1
    static IME_CMODE_CHINESE := 1
    static IME_CMODE_HANGUL := 1
    static IME_CMODE_JAPANESE := 1
    static IME_CMODE_KATAKANA := 2
    static IME_CMODE_LANGUAGE := 3
    static IME_CMODE_FULLSHAPE := 8
    static IME_CMODE_ROMAN := 16
    static IME_CMODE_CHARCODE := 32
    static IME_CMODE_HANJACONVERT := 64
    static IME_CMODE_NATIVESYMBOL := 128
    static IME_CMODE_HANGEUL := 1
    static IME_CMODE_SOFTKBD := 128
    static IME_CMODE_NOCONVERSION := 256
    static IME_CMODE_EUDC := 512
    static IME_CMODE_SYMBOL := 1024
    static IME_CMODE_FIXED := 2048
    static IME_CMODE_RESERVED := 4026531840
}
struct IME_SENTENCE_MODE extends UInt32 {
    static IME_SMODE_NONE := 0
    static IME_SMODE_PLAURALCLAUSE := 1
    static IME_SMODE_SINGLECONVERT := 2
    static IME_SMODE_AUTOMATIC := 4
    static IME_SMODE_PHRASEPREDICT := 8
    static IME_SMODE_CONVERSATION := 16
    static IME_SMODE_RESERVED := 61440
}
struct IME_COMPOSITION_STRING extends UInt32 {
    static GCS_COMPREADSTR := 1
    static GCS_COMPREADATTR := 2
    static GCS_COMPREADCLAUSE := 4
    static GCS_COMPSTR := 8
    static GCS_COMPATTR := 16
    static GCS_COMPCLAUSE := 32
    static GCS_CURSORPOS := 128
    static GCS_DELTASTART := 256
    static GCS_RESULTREADSTR := 512
    static GCS_RESULTREADCLAUSE := 1024
    static GCS_RESULTSTR := 2048
    static GCS_RESULTCLAUSE := 4096
}
struct IME_ESCAPE extends UInt32 {
    static IME_ESC_QUERY_SUPPORT := 3
    static IME_ESC_RESERVED_FIRST := 4
    static IME_ESC_RESERVED_LAST := 2047
    static IME_ESC_PRIVATE_FIRST := 2048
    static IME_ESC_PRIVATE_LAST := 4095
    static IME_ESC_SEQUENCE_TO_INTERNAL := 4097
    static IME_ESC_GET_EUDC_DICTIONARY := 4099
    static IME_ESC_SET_EUDC_DICTIONARY := 4100
    static IME_ESC_MAX_KEY := 4101
    static IME_ESC_IME_NAME := 4102
    static IME_ESC_SYNC_HOTKEY := 4103
    static IME_ESC_HANJA_MODE := 4104
    static IME_ESC_AUTOMATA := 4105
    static IME_ESC_PRIVATE_HOTKEY := 4106
    static IME_ESC_GETHELPFILENAME := 4107
}
struct IME_HOTKEY_IDENTIFIER extends UInt32 {
    static IME_CHOTKEY_IME_NONIME_TOGGLE := 16
    static IME_CHOTKEY_SHAPE_TOGGLE := 17
    static IME_CHOTKEY_SYMBOL_TOGGLE := 18
    static IME_JHOTKEY_CLOSE_OPEN := 48
    static IME_KHOTKEY_SHAPE_TOGGLE := 80
    static IME_KHOTKEY_HANJACONVERT := 81
    static IME_KHOTKEY_ENGLISH := 82
    static IME_THOTKEY_IME_NONIME_TOGGLE := 112
    static IME_THOTKEY_SHAPE_TOGGLE := 113
    static IME_THOTKEY_SYMBOL_TOGGLE := 114
    static IME_ITHOTKEY_RESEND_RESULTSTR := 512
    static IME_ITHOTKEY_PREVIOUS_COMPOSITION := 513
    static IME_ITHOTKEY_UISTYLE_TOGGLE := 514
    static IME_ITHOTKEY_RECONVERTSTRING := 515
}
struct HIMC {
    Value : IntPtr
}
struct HIMCC {
    Value : IntPtr
}
struct COMPOSITIONFORM {
    dwStyle : UInt32
    ptCurrentPos : POINT
    rcArea : RECT
}
struct CANDIDATEFORM {
    dwIndex : UInt32
    dwStyle : UInt32
    ptCurrentPos : POINT
    rcArea : RECT
}
struct CANDIDATELIST {
    dwSize : UInt32
    dwStyle : UInt32
    dwCount : UInt32
    dwSelection : UInt32
    dwPageStart : UInt32
    dwPageSize : UInt32
    dwOffset : UInt32[1]
}
struct REGISTERWORDA {
    lpReading : PSTR
    lpWord : PSTR
}
struct REGISTERWORDW {
    lpReading : PWSTR
    lpWord : PWSTR
}
struct RECONVERTSTRING {
    dwSize : UInt32
    dwVersion : UInt32
    dwStrLen : UInt32
    dwStrOffset : UInt32
    dwCompStrLen : UInt32
    dwCompStrOffset : UInt32
    dwTargetStrLen : UInt32
    dwTargetStrOffset : UInt32
}
struct STYLEBUFA {
    dwStyle : UInt32
    szDescription : CHAR[32]
}
struct STYLEBUFW {
    dwStyle : UInt32
    szDescription : UInt16[32]
}
struct IMEMENUITEMINFOA {
    cbSize : UInt32 := this.Size
    fType : UInt32
    fState : UInt32
    wID : UInt32
    hbmpChecked : HBITMAP
    hbmpUnchecked : HBITMAP
    dwItemData : UInt32
    szString : CHAR[80]
    hbmpItem : HBITMAP
}
struct IMEMENUITEMINFOW {
    cbSize : UInt32 := this.Size
    fType : UInt32
    fState : UInt32
    wID : UInt32
    hbmpChecked : HBITMAP
    hbmpUnchecked : HBITMAP
    dwItemData : UInt32
    szString : UInt16[80]
    hbmpItem : HBITMAP
}
struct IMECHARPOSITION {
    dwSize : UInt32
    dwCharPos : UInt32
    pt : POINT
    cLineHeight : UInt32
    rcDocument : RECT
}
struct IMCENUMPROC extends FunctionPointer {
    static Types := [HIMC, LPARAM, BOOL]
}
struct REGISTERWORDENUMPROCA extends FunctionPointer {
    static Types := [PSTR, UInt32, PSTR, Struct.Ptr, Int32]
}
struct REGISTERWORDENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, UInt32, PWSTR, Struct.Ptr, Int32]
}
struct IFEClassFactory extends IClassFactory {
}
struct IMEDLG {
    cbIMEDLG : Int32
    hwnd : HWND
    lpwstrWord : PWSTR
    nTabId : Int32
}
struct IFECommon extends IUnknown {
    static IID := "{019F7151-E6DB-11D0-83C3-00C04FDDB82E}"
    IsDefaultIME(szName)
      => ComCall(3, this.p, PSTR, szName, Int32, szName.Length)
    SetDefaultIME()
      => ComCall(4, this.p)
    InvokeWordRegDialog(pimedlg)
      => ComCall(5, this.p, IMEDLG.Ptr, pimedlg)
    InvokeDictToolDialog(pimedlg)
      => ComCall(6, this.p, IMEDLG.Ptr, pimedlg)
}
struct WDD {
    wDispPos : UInt16
    Anonymous1 : this._Anonymous1_e__Union
    cchDisp : UInt16
    Anonymous2 : this._Anonymous2_e__Union
    WDD_nReserve1 : UInt32
    nPos : UInt16
    _bitfield : UInt16
    pReserved : Struct.Ptr
    struct _Anonymous1_e__Union {
        union {
            wReadPos : UInt16
            wCompPos : UInt16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cchRead : UInt16
            cchComp : UInt16
        }
    }
}
struct MORRSLT {
    dwSize : UInt32
    pwchOutput : PWSTR
    cchOutput : UInt16
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pchInputPos : UInt16.Ptr
    pchOutputIdxWDD : UInt16.Ptr
    Anonymous3 : this._Anonymous3_e__Union
    paMonoRubyPos : UInt16.Ptr
    pWDD : WDD.Ptr
    cWDD : Int32
    pPrivate : Struct.Ptr
    BLKBuff : UInt16[1]
    struct _Anonymous1_e__Union {
        union {
            pwchRead : PWSTR
            pwchComp : PWSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cchRead : UInt16
            cchComp : UInt16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            pchReadIdxWDD : UInt16.Ptr
            pchCompIdxWDD : UInt16.Ptr
        }
    }
}
struct IFELanguage extends IUnknown {
    static IID := "{019F7152-E6DB-11D0-83C3-00C04FDDB82E}"
    Open()
      => ComCall(3, this.p)
    Close()
      => ComCall(4, this.p)
    GetJMorphResult(dwRequest, dwCMode, cwchInput, pwchInput, pfCInfo, ppResult)
      => ComCall(5, this.p, UInt32, dwRequest, UInt32, dwCMode, Int32, cwchInput, "Str", pwchInput, UInt32.Ptr, pfCInfo, MORRSLT.Ptr.Ptr, ppResult)
    GetConversionModeCaps(pdwCaps)
      => ComCall(6, this.p, UInt32.Ptr, pdwCaps)
    GetPhonetic(string, start, length, phonetic)
      => ComCall(7, this.p, BSTR, string, Int32, start, Int32, length, BSTR.Ptr, phonetic)
    GetConversion(string, start, length, result)
      => ComCall(8, this.p, BSTR, string, Int32, start, Int32, length, BSTR.Ptr, result)
}
struct IMEREG extends Int32 {
    static IFED_REG_HEAD := 0
    static IFED_REG_TAIL := 1
    static IFED_REG_DEL := 2
}
struct IMEFMT extends Int32 {
    static IFED_UNKNOWN := 0
    static IFED_MSIME2_BIN_SYSTEM := 1
    static IFED_MSIME2_BIN_USER := 2
    static IFED_MSIME2_TEXT_USER := 3
    static IFED_MSIME95_BIN_SYSTEM := 4
    static IFED_MSIME95_BIN_USER := 5
    static IFED_MSIME95_TEXT_USER := 6
    static IFED_MSIME97_BIN_SYSTEM := 7
    static IFED_MSIME97_BIN_USER := 8
    static IFED_MSIME97_TEXT_USER := 9
    static IFED_MSIME98_BIN_SYSTEM := 10
    static IFED_MSIME98_BIN_USER := 11
    static IFED_MSIME98_TEXT_USER := 12
    static IFED_ACTIVE_DICT := 13
    static IFED_ATOK9 := 14
    static IFED_ATOK10 := 15
    static IFED_NEC_AI_ := 16
    static IFED_WX_II := 17
    static IFED_WX_III := 18
    static IFED_VJE_20 := 19
    static IFED_MSIME98_SYSTEM_CE := 20
    static IFED_MSIME_BIN_SYSTEM := 21
    static IFED_MSIME_BIN_USER := 22
    static IFED_MSIME_TEXT_USER := 23
    static IFED_PIME2_BIN_USER := 24
    static IFED_PIME2_BIN_SYSTEM := 25
    static IFED_PIME2_BIN_STANDARD_SYSTEM := 26
}
struct IMEUCT extends Int32 {
    static IFED_UCT_NONE := 0
    static IFED_UCT_STRING_SJIS := 1
    static IFED_UCT_STRING_UNICODE := 2
    static IFED_UCT_USER_DEFINED := 3
    static IFED_UCT_MAX := 4
}
struct IMEWRD {
    pwchReading : PWSTR
    pwchDisplay : PWSTR
    Anonymous : this._Anonymous_e__Union
    rgulAttrs : UInt32[2]
    cbComment : Int32
    uct : IMEUCT
    pvComment : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            ulPos : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            nPos1 : UInt16
            nPos2 : UInt16
        }
    }
}
struct IMESHF {
    cbShf : UInt16
    verDic : UInt16
    szTitle : CHAR[48]
    szDescription : CHAR[256]
    szCopyright : CHAR[128]
}
struct POSTBL {
    nPos : UInt16
    szName : UInt8.Ptr
}
struct IMEREL extends Int32 {
    static IFED_REL_NONE := 0
    static IFED_REL_NO := 1
    static IFED_REL_GA := 2
    static IFED_REL_WO := 3
    static IFED_REL_NI := 4
    static IFED_REL_DE := 5
    static IFED_REL_YORI := 6
    static IFED_REL_KARA := 7
    static IFED_REL_MADE := 8
    static IFED_REL_HE := 9
    static IFED_REL_TO := 10
    static IFED_REL_IDEOM := 11
    static IFED_REL_FUKU_YOUGEN := 12
    static IFED_REL_KEIYOU_YOUGEN := 13
    static IFED_REL_KEIDOU1_YOUGEN := 14
    static IFED_REL_KEIDOU2_YOUGEN := 15
    static IFED_REL_TAIGEN := 16
    static IFED_REL_YOUGEN := 17
    static IFED_REL_RENTAI_MEI := 18
    static IFED_REL_RENSOU := 19
    static IFED_REL_KEIYOU_TO_YOUGEN := 20
    static IFED_REL_KEIYOU_TARU_YOUGEN := 21
    static IFED_REL_UNKNOWN1 := 22
    static IFED_REL_UNKNOWN2 := 23
    static IFED_REL_ALL := 24
}
struct IMEDP {
    wrdModifier : IMEWRD
    wrdModifiee : IMEWRD
    relID : IMEREL
}
struct PFNLOG extends FunctionPointer {
    static Types := [IMEDP.Ptr, HRESULT, BOOL]
}
struct IFEDictionary extends IUnknown {
    static IID := "{019F7153-E6DB-11D0-83C3-00C04FDDB82E}"
    Open(pchDictPath?, pshf)
      => ComCall(3, this.p, PSTR, pchDictPath?, IMESHF.Ptr, pshf)
    Close()
      => ComCall(4, this.p)
    GetHeader(pchDictPath?, pshf, pjfmt, pulType)
      => ComCall(5, this.p, PSTR, pchDictPath?, IMESHF.Ptr, pshf, IMEFMT.Ptr, pjfmt, UInt32.Ptr, pulType)
    DisplayProperty(hwnd1)
      => ComCall(6, this.p, HWND, hwnd1)
    GetPosTable(prgPosTbl, pcPosTbl)
      => ComCall(7, this.p, POSTBL.Ptr.Ptr, prgPosTbl, Int32.Ptr, pcPosTbl)
    GetWords(pwchFirst, pwchLast, pwchDisplay, ulPos, ulSelect, ulWordSrc, pchBuffer, cbBuffer, pcWrd)
      => ComCall(8, this.p, "Str", pwchFirst, "Str", pwchLast, "Str", pwchDisplay, UInt32, ulPos, UInt32, ulSelect, UInt32, ulWordSrc, UInt8.Ptr, pchBuffer, UInt32, cbBuffer, UInt32.Ptr, pcWrd)
    NextWords(pchBuffer, cbBuffer, pcWrd)
      => ComCall(9, this.p, UInt8.Ptr, pchBuffer, UInt32, cbBuffer, UInt32.Ptr, pcWrd)
    Create(pchDictPath, pshf)
      => ComCall(10, this.p, PSTR, pchDictPath, IMESHF.Ptr, pshf)
    SetHeader(pshf)
      => ComCall(11, this.p, IMESHF.Ptr, pshf)
    ExistWord(pwrd)
      => ComCall(12, this.p, IMEWRD.Ptr, pwrd)
    ExistDependency(pdp)
      => ComCall(13, this.p, IMEDP.Ptr, pdp)
    RegisterWord(reg, pwrd)
      => ComCall(14, this.p, IMEREG, reg, IMEWRD.Ptr, pwrd)
    RegisterDependency(reg, pdp)
      => ComCall(15, this.p, IMEREG, reg, IMEDP.Ptr, pdp)
    GetDependencies(pwchKakariReading, pwchKakariDisplay, ulKakariPos, pwchUkeReading, pwchUkeDisplay, ulUkePos, jrel, ulWordSrc, pchBuffer, cbBuffer, pcdp)
      => ComCall(16, this.p, "Str", pwchKakariReading, "Str", pwchKakariDisplay, UInt32, ulKakariPos, "Str", pwchUkeReading, "Str", pwchUkeDisplay, UInt32, ulUkePos, IMEREL, jrel, UInt32, ulWordSrc, UInt8.Ptr, pchBuffer, UInt32, cbBuffer, UInt32.Ptr, pcdp)
    NextDependencies(pchBuffer, cbBuffer, pcDp)
      => ComCall(17, this.p, UInt8.Ptr, pchBuffer, UInt32, cbBuffer, UInt32.Ptr, pcDp)
    ConvertFromOldMSIME(pchDic, pfnLog1, reg)
      => ComCall(18, this.p, PSTR, pchDic, PFNLOG, pfnLog1, IMEREG, reg)
    ConvertFromUserToSys()
      => ComCall(19, this.p)
}
struct IMEKMSINIT {
    cbSize : Int32 := this.Size
    hWnd : HWND
}
struct IMEKMSKEY {
    dwStatus : UInt32
    dwCompStatus : UInt32
    dwVKEY : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            dwControl : UInt32
            dwNotUsed : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pwszDscr : UInt16[31]
            pwszNoUse : UInt16[31]
        }
    }
}
struct IMEKMS {
    cbSize : Int32 := this.Size
    hIMC : HIMC
    cKeyList : UInt32
    pKeyList : IMEKMSKEY.Ptr
}
struct IMEKMSNTFY {
    cbSize : Int32 := this.Size
    hIMC : HIMC
    fSelect : BOOL
}
struct IMEKMSKMP {
    cbSize : Int32 := this.Size
    hIMC : HIMC
    idLang : UInt16
    wVKStart : UInt16
    wVKEnd : UInt16
    cKeyList : Int32
    pKeyList : IMEKMSKEY.Ptr
}
struct IMEKMSINVK {
    cbSize : Int32 := this.Size
    hIMC : HIMC
    dwControl : UInt32
}
struct IMEKMSFUNCDESC {
    cbSize : Int32 := this.Size
    idLang : UInt16
    dwControl : UInt32
    pwszDescription : UInt16[128]
}
struct fpCreateIFECommonInstanceType extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, HRESULT]
}
struct fpCreateIFELanguageInstanceType extends FunctionPointer {
    static Types := [GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct fpCreateIFEDictionaryInstanceType extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, HRESULT]
}
struct COMPOSITIONSTRING {
    dwSize : UInt32
    dwCompReadAttrLen : UInt32
    dwCompReadAttrOffset : UInt32
    dwCompReadClauseLen : UInt32
    dwCompReadClauseOffset : UInt32
    dwCompReadStrLen : UInt32
    dwCompReadStrOffset : UInt32
    dwCompAttrLen : UInt32
    dwCompAttrOffset : UInt32
    dwCompClauseLen : UInt32
    dwCompClauseOffset : UInt32
    dwCompStrLen : UInt32
    dwCompStrOffset : UInt32
    dwCursorPos : UInt32
    dwDeltaStart : UInt32
    dwResultReadClauseLen : UInt32
    dwResultReadClauseOffset : UInt32
    dwResultReadStrLen : UInt32
    dwResultReadStrOffset : UInt32
    dwResultClauseLen : UInt32
    dwResultClauseOffset : UInt32
    dwResultStrLen : UInt32
    dwResultStrOffset : UInt32
    dwPrivateSize : UInt32
    dwPrivateOffset : UInt32
}
struct GUIDELINE {
    dwSize : UInt32
    dwLevel : UInt32
    dwIndex : UInt32
    dwStrLen : UInt32
    dwStrOffset : UInt32
    dwPrivateSize : UInt32
    dwPrivateOffset : UInt32
}
struct TRANSMSG {
    message : UInt32
    wParam : WPARAM
    lParam : LPARAM
}
struct TRANSMSGLIST {
    uMsgCount : UInt32
    TransMsg : TRANSMSG[1]
}
struct CANDIDATEINFO {
    dwSize : UInt32
    dwCount : UInt32
    dwOffset : UInt32[32]
    dwPrivateSize : UInt32
    dwPrivateOffset : UInt32
}
struct INPUTCONTEXT {
    hWnd : HWND
    fOpen : BOOL
    ptStatusWndPos : POINT
    ptSoftKbdPos : POINT
    fdwConversion : UInt32
    fdwSentence : UInt32
    lfFont : this._lfFont_e__Union
    cfCompForm : COMPOSITIONFORM
    cfCandForm : CANDIDATEFORM[4]
    hCompStr : HIMCC
    hCandInfo : HIMCC
    hGuideLine : HIMCC
    hPrivate : HIMCC
    dwNumMsgBuf : UInt32
    hMsgBuf : HIMCC
    fdwInit : UInt32
    dwReserve : UInt32[3]
    struct _lfFont_e__Union {
        union {
            A : LOGFONTA
            W : LOGFONTW
        }
    }
}
struct IMEINFO {
    dwPrivateDataSize : UInt32
    fdwProperty : UInt32
    fdwConversionCaps : UInt32
    fdwSentenceCaps : UInt32
    fdwUICaps : UInt32
    fdwSCSCaps : UInt32
    fdwSelectCaps : UInt32
}
struct SOFTKBDDATA {
    uCount : UInt32
    wCode : UInt16[256]
}
struct APPLETIDLIST {
    count : Int32
    pIIDList : GUID.Ptr
}
struct IMESTRINGCANDIDATE {
    uCount : UInt32
    lpwstr : PWSTR[1]
}
struct IMEITEM {
    cbSize : Int32 := this.Size
    iType : Int32
    lpItemData : Struct.Ptr
}
struct IMEITEMCANDIDATE {
    uCount : UInt32
    imeItem : IMEITEM[1]
}
struct IMESTRINGINFO {
    dwFarEastId : UInt32
    lpwstr : PWSTR
}
struct IMEFAREASTINFO {
    dwSize : UInt32
    dwType : UInt32
    dwData : UInt32[1]
}
struct IMESTRINGCANDIDATEINFO {
    dwFarEastId : UInt32
    lpFarEastInfo : IMEFAREASTINFO.Ptr
    fInfoMask : UInt32
    iSelIndex : Int32
    uCount : UInt32
    lpwstr : PWSTR[1]
}
struct IMECOMPOSITIONSTRINGINFO {
    iCompStrLen : Int32
    iCaretPos : Int32
    iEditStart : Int32
    iEditLen : Int32
    iTargetStart : Int32
    iTargetLen : Int32
}
struct IMECHARINFO {
    wch : UInt16
    dwCharInfo : UInt32
}
struct IMEAPPLETCFG {
    dwConfig : UInt32
    wchTitle : UInt16[64]
    wchTitleFontFace : UInt16[32]
    dwCharSet : UInt32
    iCategory : Int32
    hIcon : HICON
    langID : UInt16
    dummy : UInt16
    lReserved1 : LPARAM
}
struct IMEAPPLETUI {
    hwnd : HWND
    dwStyle : UInt32
    width : Int32
    height : Int32
    minWidth : Int32
    minHeight : Int32
    maxWidth : Int32
    maxHeight : Int32
    lReserved1 : LPARAM
    lReserved2 : LPARAM
}
struct APPLYCANDEXPARAM {
    dwSize : UInt32
    lpwstrDisplay : PWSTR
    lpwstrReading : PWSTR
    dwReserved : UInt32
}
struct IImeSpecifyApplets extends IUnknown {
    static IID := "{5D8E643C-C3A9-11D1-AFEF-00805F0C8B6D}"
    GetAppletIIDList(refiid, lpIIDList)
      => ComCall(3, this.p, GUID.Ptr, refiid, APPLETIDLIST.Ptr, lpIIDList)
}
struct IImePadApplet extends IUnknown {
    static IID := "{5D8E643B-C3A9-11D1-AFEF-00805F0C8B6D}"
    Initialize(lpIImePad)
      => ComCall(3, this.p, IUnknown, lpIImePad)
    Terminate()
      => ComCall(4, this.p)
    GetAppletConfig(lpAppletCfg)
      => ComCall(5, this.p, IMEAPPLETCFG.Ptr, lpAppletCfg)
    CreateUI(hwndParent, lpImeAppletUI)
      => ComCall(6, this.p, HWND, hwndParent, IMEAPPLETUI.Ptr, lpImeAppletUI)
    Notify(lpImePad, notify, wParam1, lParam1)
      => ComCall(7, this.p, IUnknown, lpImePad, Int32, notify, WPARAM, wParam1, LPARAM, lParam1)
}
struct IImePad extends IUnknown {
    static IID := "{5D8E643A-C3A9-11D1-AFEF-00805F0C8B6D}"
    Request(pIImePadApplet, reqId, wParam1, lParam1)
      => ComCall(3, this.p, IImePadApplet, pIImePadApplet, Int32, reqId, WPARAM, wParam1, LPARAM, lParam1)
}
struct IImePlugInDictDictionaryList extends IUnknown {
    static IID := "{98752974-B0A6-489B-8F6F-BFF3769C8EEB}"
    GetDictionariesInUse(prgDictionaryGUID, prgDateCreated, prgfEncrypted)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, prgDictionaryGUID, SAFEARRAY.Ptr.Ptr, prgDateCreated, SAFEARRAY.Ptr.Ptr, prgfEncrypted)
    DeleteDictionary(bstrDictionaryGUID)
      => ComCall(4, this.p, BSTR, bstrDictionaryGUID)
}
struct IEnumRegisterWordA extends IUnknown {
    static IID := "{08C03412-F96B-11D0-A475-00AA006BCC59}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumRegisterWordA.Ptr, ppEnum)
    Next(ulCount, rgRegisterWord, pcFetched)
      => ComCall(4, this.p, UInt32, ulCount, REGISTERWORDA.Ptr, rgRegisterWord, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct IEnumRegisterWordW extends IUnknown {
    static IID := "{4955DD31-B159-11D0-8FCF-00AA006BCC59}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumRegisterWordW.Ptr, ppEnum)
    Next(ulCount, rgRegisterWord, pcFetched)
      => ComCall(4, this.p, UInt32, ulCount, REGISTERWORDW.Ptr, rgRegisterWord, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct IEnumInputContext extends IUnknown {
    static IID := "{09B5EAB0-F997-11D1-93D4-0060B067B86E}"
    Clone(ppEnum)
      => ComCall(3, this.p, IEnumInputContext.Ptr, ppEnum)
    Next(ulCount, rgInputContext, pcFetched)
      => ComCall(4, this.p, UInt32, ulCount, HIMC.Ptr, rgInputContext, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(5, this.p)
    Skip(ulCount)
      => ComCall(6, this.p, UInt32, ulCount)
}
struct IActiveIMMRegistrar extends IUnknown {
    static IID := "{B3458082-BD00-11D1-939B-0060B067B86E}"
    RegisterIME(rclsid, lgid, pszIconFile, pszDesc)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt16, lgid, "Str", pszIconFile, "Str", pszDesc)
    UnregisterIME(rclsid)
      => ComCall(4, this.p, GUID.Ptr, rclsid)
}
struct IActiveIMMMessagePumpOwner extends IUnknown {
    static IID := "{B5CF2CFA-8AEB-11D1-9364-0060B067B86E}"
    Start()
      => ComCall(3, this.p)
    End()
      => ComCall(4, this.p)
    OnTranslateMessage(pMsg)
      => ComCall(5, this.p, MSG.Ptr, pMsg)
    Pause(pdwCookie)
      => ComCall(6, this.p, UInt32.Ptr, pdwCookie)
    Resume(dwCookie)
      => ComCall(7, this.p, UInt32, dwCookie)
}
struct IActiveIMMApp extends IUnknown {
    static IID := "{08C0E040-62D1-11D1-9326-0060B067B86E}"
    AssociateContext(hWnd1, hIME, phPrev)
      => ComCall(3, this.p, HWND, hWnd1, HIMC, hIME, HIMC.Ptr, phPrev)
    ConfigureIMEA(hKL1, hWnd1, dwMode, pData)
      => ComCall(4, this.p, HKL, hKL1, HWND, hWnd1, UInt32, dwMode, REGISTERWORDA.Ptr, pData)
    ConfigureIMEW(hKL1, hWnd1, dwMode, pData)
      => ComCall(5, this.p, HKL, hKL1, HWND, hWnd1, UInt32, dwMode, REGISTERWORDW.Ptr, pData)
    CreateContext(phIMC)
      => ComCall(6, this.p, HIMC.Ptr, phIMC)
    DestroyContext(hIME)
      => ComCall(7, this.p, HIMC, hIME)
    EnumRegisterWordA(hKL1, szReading, dwStyle, szRegister, pData, pEnum)
      => ComCall(8, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szRegister, Struct.Ptr, pData, IEnumRegisterWordA.Ptr, pEnum)
    EnumRegisterWordW(hKL1, szReading, dwStyle, szRegister, pData, pEnum)
      => ComCall(9, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szRegister, Struct.Ptr, pData, IEnumRegisterWordW.Ptr, pEnum)
    EscapeA(hKL1, hIMC1, uEscape, pData, plResult)
      => ComCall(10, this.p, HKL, hKL1, HIMC, hIMC1, UInt32, uEscape, Struct.Ptr, pData, LRESULT.Ptr, plResult)
    EscapeW(hKL1, hIMC1, uEscape, pData, plResult)
      => ComCall(11, this.p, HKL, hKL1, HIMC, hIMC1, UInt32, uEscape, Struct.Ptr, pData, LRESULT.Ptr, plResult)
    GetCandidateListA(hIMC1, dwIndex, uBufLen, pCandList, puCopied)
      => ComCall(12, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, uBufLen, CANDIDATELIST.Ptr, pCandList, UInt32.Ptr, puCopied)
    GetCandidateListW(hIMC1, dwIndex, uBufLen, pCandList, puCopied)
      => ComCall(13, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, uBufLen, CANDIDATELIST.Ptr, pCandList, UInt32.Ptr, puCopied)
    GetCandidateListCountA(hIMC1, pdwListSize, pdwBufLen)
      => ComCall(14, this.p, HIMC, hIMC1, UInt32.Ptr, pdwListSize, UInt32.Ptr, pdwBufLen)
    GetCandidateListCountW(hIMC1, pdwListSize, pdwBufLen)
      => ComCall(15, this.p, HIMC, hIMC1, UInt32.Ptr, pdwListSize, UInt32.Ptr, pdwBufLen)
    GetCandidateWindow(hIMC1, dwIndex, pCandidate)
      => ComCall(16, this.p, HIMC, hIMC1, UInt32, dwIndex, CANDIDATEFORM.Ptr, pCandidate)
    GetCompositionFontA(hIMC1, plf)
      => ComCall(17, this.p, HIMC, hIMC1, LOGFONTA.Ptr, plf)
    GetCompositionFontW(hIMC1, plf)
      => ComCall(18, this.p, HIMC, hIMC1, LOGFONTW.Ptr, plf)
    GetCompositionStringA(hIMC1, dwIndex, dwBufLen, plCopied, pBuf)
      => ComCall(19, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, Int32.Ptr, plCopied, Struct.Ptr, pBuf)
    GetCompositionStringW(hIMC1, dwIndex, dwBufLen, plCopied, pBuf)
      => ComCall(20, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, Int32.Ptr, plCopied, Struct.Ptr, pBuf)
    GetCompositionWindow(hIMC1, pCompForm)
      => ComCall(21, this.p, HIMC, hIMC1, COMPOSITIONFORM.Ptr, pCompForm)
    GetContext(hWnd1, phIMC)
      => ComCall(22, this.p, HWND, hWnd1, HIMC.Ptr, phIMC)
    GetConversionListA(hKL1, hIMC1, pSrc, uBufLen, uFlag, pDst, puCopied)
      => ComCall(23, this.p, HKL, hKL1, HIMC, hIMC1, PSTR, pSrc, UInt32, uBufLen, UInt32, uFlag, CANDIDATELIST.Ptr, pDst, UInt32.Ptr, puCopied)
    GetConversionListW(hKL1, hIMC1, pSrc, uBufLen, uFlag, pDst, puCopied)
      => ComCall(24, this.p, HKL, hKL1, HIMC, hIMC1, "Str", pSrc, UInt32, uBufLen, UInt32, uFlag, CANDIDATELIST.Ptr, pDst, UInt32.Ptr, puCopied)
    GetConversionStatus(hIMC1, pfdwConversion, pfdwSentence)
      => ComCall(25, this.p, HIMC, hIMC1, UInt32.Ptr, pfdwConversion, UInt32.Ptr, pfdwSentence)
    GetDefaultIMEWnd(hWnd1, phDefWnd)
      => ComCall(26, this.p, HWND, hWnd1, HWND.Ptr, phDefWnd)
    GetDescriptionA(hKL1, uBufLen, szDescription, puCopied)
      => ComCall(27, this.p, HKL, hKL1, UInt32, uBufLen, PSTR, szDescription, UInt32.Ptr, puCopied)
    GetDescriptionW(hKL1, uBufLen, szDescription, puCopied)
      => ComCall(28, this.p, HKL, hKL1, UInt32, uBufLen, PWSTR, szDescription, UInt32.Ptr, puCopied)
    GetGuideLineA(hIMC1, dwIndex, dwBufLen, pBuf, pdwResult)
      => ComCall(29, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, PSTR, pBuf, UInt32.Ptr, pdwResult)
    GetGuideLineW(hIMC1, dwIndex, dwBufLen, pBuf, pdwResult)
      => ComCall(30, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, PWSTR, pBuf, UInt32.Ptr, pdwResult)
    GetIMEFileNameA(hKL1, uBufLen, szFileName, puCopied)
      => ComCall(31, this.p, HKL, hKL1, UInt32, uBufLen, PSTR, szFileName, UInt32.Ptr, puCopied)
    GetIMEFileNameW(hKL1, uBufLen, szFileName, puCopied)
      => ComCall(32, this.p, HKL, hKL1, UInt32, uBufLen, PWSTR, szFileName, UInt32.Ptr, puCopied)
    GetOpenStatus(hIMC1)
      => ComCall(33, this.p, HIMC, hIMC1)
    GetProperty(hKL1, fdwIndex, pdwProperty)
      => ComCall(34, this.p, HKL, hKL1, UInt32, fdwIndex, UInt32.Ptr, pdwProperty)
    GetRegisterWordStyleA(hKL1, nItem, pStyleBuf, puCopied)
      => ComCall(35, this.p, HKL, hKL1, UInt32, nItem, STYLEBUFA.Ptr, pStyleBuf, UInt32.Ptr, puCopied)
    GetRegisterWordStyleW(hKL1, nItem, pStyleBuf, puCopied)
      => ComCall(36, this.p, HKL, hKL1, UInt32, nItem, STYLEBUFW.Ptr, pStyleBuf, UInt32.Ptr, puCopied)
    GetStatusWindowPos(hIMC1, pptPos)
      => ComCall(37, this.p, HIMC, hIMC1, POINT.Ptr, pptPos)
    GetVirtualKey(hWnd1, puVirtualKey)
      => ComCall(38, this.p, HWND, hWnd1, UInt32.Ptr, puVirtualKey)
    InstallIMEA(szIMEFileName, szLayoutText, phKL)
      => ComCall(39, this.p, PSTR, szIMEFileName, PSTR, szLayoutText, HKL.Ptr, phKL)
    InstallIMEW(szIMEFileName, szLayoutText, phKL)
      => ComCall(40, this.p, "Str", szIMEFileName, "Str", szLayoutText, HKL.Ptr, phKL)
    IsIME(hKL1)
      => ComCall(41, this.p, HKL, hKL1)
    IsUIMessageA(hWndIME, msg, wParam1, lParam1)
      => ComCall(42, this.p, HWND, hWndIME, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1)
    IsUIMessageW(hWndIME, msg, wParam1, lParam1)
      => ComCall(43, this.p, HWND, hWndIME, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1)
    NotifyIME(hIMC1, dwAction, dwIndex, dwValue)
      => ComCall(44, this.p, HIMC, hIMC1, UInt32, dwAction, UInt32, dwIndex, UInt32, dwValue)
    RegisterWordA(hKL1, szReading, dwStyle, szRegister)
      => ComCall(45, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szRegister)
    RegisterWordW(hKL1, szReading, dwStyle, szRegister)
      => ComCall(46, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szRegister)
    ReleaseContext(hWnd1, hIMC1)
      => ComCall(47, this.p, HWND, hWnd1, HIMC, hIMC1)
    SetCandidateWindow(hIMC1, pCandidate)
      => ComCall(48, this.p, HIMC, hIMC1, CANDIDATEFORM.Ptr, pCandidate)
    SetCompositionFontA(hIMC1, plf)
      => ComCall(49, this.p, HIMC, hIMC1, LOGFONTA.Ptr, plf)
    SetCompositionFontW(hIMC1, plf)
      => ComCall(50, this.p, HIMC, hIMC1, LOGFONTW.Ptr, plf)
    SetCompositionStringA(hIMC1, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
      => ComCall(51, this.p, HIMC, hIMC1, UInt32, dwIndex, Struct.Ptr, pComp, UInt32, dwCompLen, Struct.Ptr, pRead, UInt32, dwReadLen)
    SetCompositionStringW(hIMC1, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
      => ComCall(52, this.p, HIMC, hIMC1, UInt32, dwIndex, Struct.Ptr, pComp, UInt32, dwCompLen, Struct.Ptr, pRead, UInt32, dwReadLen)
    SetCompositionWindow(hIMC1, pCompForm)
      => ComCall(53, this.p, HIMC, hIMC1, COMPOSITIONFORM.Ptr, pCompForm)
    SetConversionStatus(hIMC1, fdwConversion, fdwSentence)
      => ComCall(54, this.p, HIMC, hIMC1, UInt32, fdwConversion, UInt32, fdwSentence)
    SetOpenStatus(hIMC1, fOpen)
      => ComCall(55, this.p, HIMC, hIMC1, BOOL, fOpen)
    SetStatusWindowPos(hIMC1, pptPos)
      => ComCall(56, this.p, HIMC, hIMC1, POINT.Ptr, pptPos)
    SimulateHotKey(hWnd1, dwHotKeyID)
      => ComCall(57, this.p, HWND, hWnd1, UInt32, dwHotKeyID)
    UnregisterWordA(hKL1, szReading, dwStyle, szUnregister)
      => ComCall(58, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szUnregister)
    UnregisterWordW(hKL1, szReading, dwStyle, szUnregister)
      => ComCall(59, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szUnregister)
    Activate(fRestoreLayout)
      => ComCall(60, this.p, BOOL, fRestoreLayout)
    Deactivate()
      => ComCall(61, this.p)
    OnDefWindowProc(hWnd1, Msg, wParam1, lParam1, plResult)
      => ComCall(62, this.p, HWND, hWnd1, UInt32, Msg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    FilterClientWindows(aaClassList, uSize)
      => ComCall(63, this.p, UInt16.Ptr, aaClassList, UInt32, uSize)
    GetCodePageA(hKL1, uCodePage)
      => ComCall(64, this.p, HKL, hKL1, UInt32.Ptr, uCodePage)
    GetLangId(hKL1, plid)
      => ComCall(65, this.p, HKL, hKL1, UInt16.Ptr, plid)
    AssociateContextEx(hWnd1, hIMC1, dwFlags)
      => ComCall(66, this.p, HWND, hWnd1, HIMC, hIMC1, UInt32, dwFlags)
    DisableIME(idThread)
      => ComCall(67, this.p, UInt32, idThread)
    GetImeMenuItemsA(hIMC1, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
      => ComCall(68, this.p, HIMC, hIMC1, UInt32, dwFlags, UInt32, dwType, IMEMENUITEMINFOA.Ptr, pImeParentMenu, IMEMENUITEMINFOA.Ptr, pImeMenu, UInt32, dwSize, UInt32.Ptr, pdwResult)
    GetImeMenuItemsW(hIMC1, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
      => ComCall(69, this.p, HIMC, hIMC1, UInt32, dwFlags, UInt32, dwType, IMEMENUITEMINFOW.Ptr, pImeParentMenu, IMEMENUITEMINFOW.Ptr, pImeMenu, UInt32, dwSize, UInt32.Ptr, pdwResult)
    EnumInputContext(idThread, ppEnum)
      => ComCall(70, this.p, UInt32, idThread, IEnumInputContext.Ptr, ppEnum)
}
struct IActiveIMMIME extends IUnknown {
    static IID := "{08C03411-F96B-11D0-A475-00AA006BCC59}"
    AssociateContext(hWnd1, hIME, phPrev)
      => ComCall(3, this.p, HWND, hWnd1, HIMC, hIME, HIMC.Ptr, phPrev)
    ConfigureIMEA(hKL1, hWnd1, dwMode, pData)
      => ComCall(4, this.p, HKL, hKL1, HWND, hWnd1, UInt32, dwMode, REGISTERWORDA.Ptr, pData)
    ConfigureIMEW(hKL1, hWnd1, dwMode, pData)
      => ComCall(5, this.p, HKL, hKL1, HWND, hWnd1, UInt32, dwMode, REGISTERWORDW.Ptr, pData)
    CreateContext(phIMC)
      => ComCall(6, this.p, HIMC.Ptr, phIMC)
    DestroyContext(hIME)
      => ComCall(7, this.p, HIMC, hIME)
    EnumRegisterWordA(hKL1, szReading, dwStyle, szRegister, pData, pEnum)
      => ComCall(8, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szRegister, Struct.Ptr, pData, IEnumRegisterWordA.Ptr, pEnum)
    EnumRegisterWordW(hKL1, szReading, dwStyle, szRegister, pData, pEnum)
      => ComCall(9, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szRegister, Struct.Ptr, pData, IEnumRegisterWordW.Ptr, pEnum)
    EscapeA(hKL1, hIMC1, uEscape, pData, plResult)
      => ComCall(10, this.p, HKL, hKL1, HIMC, hIMC1, UInt32, uEscape, Struct.Ptr, pData, LRESULT.Ptr, plResult)
    EscapeW(hKL1, hIMC1, uEscape, pData, plResult)
      => ComCall(11, this.p, HKL, hKL1, HIMC, hIMC1, UInt32, uEscape, Struct.Ptr, pData, LRESULT.Ptr, plResult)
    GetCandidateListA(hIMC1, dwIndex, uBufLen, pCandList, puCopied)
      => ComCall(12, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, uBufLen, CANDIDATELIST.Ptr, pCandList, UInt32.Ptr, puCopied)
    GetCandidateListW(hIMC1, dwIndex, uBufLen, pCandList, puCopied)
      => ComCall(13, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, uBufLen, CANDIDATELIST.Ptr, pCandList, UInt32.Ptr, puCopied)
    GetCandidateListCountA(hIMC1, pdwListSize, pdwBufLen)
      => ComCall(14, this.p, HIMC, hIMC1, UInt32.Ptr, pdwListSize, UInt32.Ptr, pdwBufLen)
    GetCandidateListCountW(hIMC1, pdwListSize, pdwBufLen)
      => ComCall(15, this.p, HIMC, hIMC1, UInt32.Ptr, pdwListSize, UInt32.Ptr, pdwBufLen)
    GetCandidateWindow(hIMC1, dwIndex, pCandidate)
      => ComCall(16, this.p, HIMC, hIMC1, UInt32, dwIndex, CANDIDATEFORM.Ptr, pCandidate)
    GetCompositionFontA(hIMC1, plf)
      => ComCall(17, this.p, HIMC, hIMC1, LOGFONTA.Ptr, plf)
    GetCompositionFontW(hIMC1, plf)
      => ComCall(18, this.p, HIMC, hIMC1, LOGFONTW.Ptr, plf)
    GetCompositionStringA(hIMC1, dwIndex, dwBufLen, plCopied, pBuf)
      => ComCall(19, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, Int32.Ptr, plCopied, Struct.Ptr, pBuf)
    GetCompositionStringW(hIMC1, dwIndex, dwBufLen, plCopied, pBuf)
      => ComCall(20, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, Int32.Ptr, plCopied, Struct.Ptr, pBuf)
    GetCompositionWindow(hIMC1, pCompForm)
      => ComCall(21, this.p, HIMC, hIMC1, COMPOSITIONFORM.Ptr, pCompForm)
    GetContext(hWnd1, phIMC)
      => ComCall(22, this.p, HWND, hWnd1, HIMC.Ptr, phIMC)
    GetConversionListA(hKL1, hIMC1, pSrc, uBufLen, uFlag, pDst, puCopied)
      => ComCall(23, this.p, HKL, hKL1, HIMC, hIMC1, PSTR, pSrc, UInt32, uBufLen, UInt32, uFlag, CANDIDATELIST.Ptr, pDst, UInt32.Ptr, puCopied)
    GetConversionListW(hKL1, hIMC1, pSrc, uBufLen, uFlag, pDst, puCopied)
      => ComCall(24, this.p, HKL, hKL1, HIMC, hIMC1, "Str", pSrc, UInt32, uBufLen, UInt32, uFlag, CANDIDATELIST.Ptr, pDst, UInt32.Ptr, puCopied)
    GetConversionStatus(hIMC1, pfdwConversion, pfdwSentence)
      => ComCall(25, this.p, HIMC, hIMC1, UInt32.Ptr, pfdwConversion, UInt32.Ptr, pfdwSentence)
    GetDefaultIMEWnd(hWnd1, phDefWnd)
      => ComCall(26, this.p, HWND, hWnd1, HWND.Ptr, phDefWnd)
    GetDescriptionA(hKL1, uBufLen, szDescription, puCopied)
      => ComCall(27, this.p, HKL, hKL1, UInt32, uBufLen, PSTR, szDescription, UInt32.Ptr, puCopied)
    GetDescriptionW(hKL1, uBufLen, szDescription, puCopied)
      => ComCall(28, this.p, HKL, hKL1, UInt32, uBufLen, PWSTR, szDescription, UInt32.Ptr, puCopied)
    GetGuideLineA(hIMC1, dwIndex, dwBufLen, pBuf, pdwResult)
      => ComCall(29, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, PSTR, pBuf, UInt32.Ptr, pdwResult)
    GetGuideLineW(hIMC1, dwIndex, dwBufLen, pBuf, pdwResult)
      => ComCall(30, this.p, HIMC, hIMC1, UInt32, dwIndex, UInt32, dwBufLen, PWSTR, pBuf, UInt32.Ptr, pdwResult)
    GetIMEFileNameA(hKL1, uBufLen, szFileName, puCopied)
      => ComCall(31, this.p, HKL, hKL1, UInt32, uBufLen, PSTR, szFileName, UInt32.Ptr, puCopied)
    GetIMEFileNameW(hKL1, uBufLen, szFileName, puCopied)
      => ComCall(32, this.p, HKL, hKL1, UInt32, uBufLen, PWSTR, szFileName, UInt32.Ptr, puCopied)
    GetOpenStatus(hIMC1)
      => ComCall(33, this.p, HIMC, hIMC1)
    GetProperty(hKL1, fdwIndex, pdwProperty)
      => ComCall(34, this.p, HKL, hKL1, UInt32, fdwIndex, UInt32.Ptr, pdwProperty)
    GetRegisterWordStyleA(hKL1, nItem, pStyleBuf, puCopied)
      => ComCall(35, this.p, HKL, hKL1, UInt32, nItem, STYLEBUFA.Ptr, pStyleBuf, UInt32.Ptr, puCopied)
    GetRegisterWordStyleW(hKL1, nItem, pStyleBuf, puCopied)
      => ComCall(36, this.p, HKL, hKL1, UInt32, nItem, STYLEBUFW.Ptr, pStyleBuf, UInt32.Ptr, puCopied)
    GetStatusWindowPos(hIMC1, pptPos)
      => ComCall(37, this.p, HIMC, hIMC1, POINT.Ptr, pptPos)
    GetVirtualKey(hWnd1, puVirtualKey)
      => ComCall(38, this.p, HWND, hWnd1, UInt32.Ptr, puVirtualKey)
    InstallIMEA(szIMEFileName, szLayoutText, phKL)
      => ComCall(39, this.p, PSTR, szIMEFileName, PSTR, szLayoutText, HKL.Ptr, phKL)
    InstallIMEW(szIMEFileName, szLayoutText, phKL)
      => ComCall(40, this.p, "Str", szIMEFileName, "Str", szLayoutText, HKL.Ptr, phKL)
    IsIME(hKL1)
      => ComCall(41, this.p, HKL, hKL1)
    IsUIMessageA(hWndIME, msg, wParam1, lParam1)
      => ComCall(42, this.p, HWND, hWndIME, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1)
    IsUIMessageW(hWndIME, msg, wParam1, lParam1)
      => ComCall(43, this.p, HWND, hWndIME, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1)
    NotifyIME(hIMC1, dwAction, dwIndex, dwValue)
      => ComCall(44, this.p, HIMC, hIMC1, UInt32, dwAction, UInt32, dwIndex, UInt32, dwValue)
    RegisterWordA(hKL1, szReading, dwStyle, szRegister)
      => ComCall(45, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szRegister)
    RegisterWordW(hKL1, szReading, dwStyle, szRegister)
      => ComCall(46, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szRegister)
    ReleaseContext(hWnd1, hIMC1)
      => ComCall(47, this.p, HWND, hWnd1, HIMC, hIMC1)
    SetCandidateWindow(hIMC1, pCandidate)
      => ComCall(48, this.p, HIMC, hIMC1, CANDIDATEFORM.Ptr, pCandidate)
    SetCompositionFontA(hIMC1, plf)
      => ComCall(49, this.p, HIMC, hIMC1, LOGFONTA.Ptr, plf)
    SetCompositionFontW(hIMC1, plf)
      => ComCall(50, this.p, HIMC, hIMC1, LOGFONTW.Ptr, plf)
    SetCompositionStringA(hIMC1, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
      => ComCall(51, this.p, HIMC, hIMC1, UInt32, dwIndex, Struct.Ptr, pComp, UInt32, dwCompLen, Struct.Ptr, pRead, UInt32, dwReadLen)
    SetCompositionStringW(hIMC1, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
      => ComCall(52, this.p, HIMC, hIMC1, UInt32, dwIndex, Struct.Ptr, pComp, UInt32, dwCompLen, Struct.Ptr, pRead, UInt32, dwReadLen)
    SetCompositionWindow(hIMC1, pCompForm)
      => ComCall(53, this.p, HIMC, hIMC1, COMPOSITIONFORM.Ptr, pCompForm)
    SetConversionStatus(hIMC1, fdwConversion, fdwSentence)
      => ComCall(54, this.p, HIMC, hIMC1, UInt32, fdwConversion, UInt32, fdwSentence)
    SetOpenStatus(hIMC1, fOpen)
      => ComCall(55, this.p, HIMC, hIMC1, BOOL, fOpen)
    SetStatusWindowPos(hIMC1, pptPos)
      => ComCall(56, this.p, HIMC, hIMC1, POINT.Ptr, pptPos)
    SimulateHotKey(hWnd1, dwHotKeyID)
      => ComCall(57, this.p, HWND, hWnd1, UInt32, dwHotKeyID)
    UnregisterWordA(hKL1, szReading, dwStyle, szUnregister)
      => ComCall(58, this.p, HKL, hKL1, PSTR, szReading, UInt32, dwStyle, PSTR, szUnregister)
    UnregisterWordW(hKL1, szReading, dwStyle, szUnregister)
      => ComCall(59, this.p, HKL, hKL1, "Str", szReading, UInt32, dwStyle, "Str", szUnregister)
    GenerateMessage(hIMC1)
      => ComCall(60, this.p, HIMC, hIMC1)
    LockIMC(hIMC1, ppIMC)
      => ComCall(61, this.p, HIMC, hIMC1, INPUTCONTEXT.Ptr.Ptr, ppIMC)
    UnlockIMC(hIMC1)
      => ComCall(62, this.p, HIMC, hIMC1)
    GetIMCLockCount(hIMC1, pdwLockCount)
      => ComCall(63, this.p, HIMC, hIMC1, UInt32.Ptr, pdwLockCount)
    CreateIMCC(dwSize, phIMCC)
      => ComCall(64, this.p, UInt32, dwSize, HIMCC.Ptr, phIMCC)
    DestroyIMCC(hIMCC1)
      => ComCall(65, this.p, HIMCC, hIMCC1)
    LockIMCC(hIMCC1, ppv)
      => ComCall(66, this.p, HIMCC, hIMCC1, Struct.Ptr.Ptr, ppv)
    UnlockIMCC(hIMCC1)
      => ComCall(67, this.p, HIMCC, hIMCC1)
    ReSizeIMCC(hIMCC1, dwSize, phIMCC)
      => ComCall(68, this.p, HIMCC, hIMCC1, UInt32, dwSize, HIMCC.Ptr, phIMCC)
    GetIMCCSize(hIMCC1, pdwSize)
      => ComCall(69, this.p, HIMCC, hIMCC1, UInt32.Ptr, pdwSize)
    GetIMCCLockCount(hIMCC1, pdwLockCount)
      => ComCall(70, this.p, HIMCC, hIMCC1, UInt32.Ptr, pdwLockCount)
    GetHotKey(dwHotKeyID, puModifiers, puVKey, phKL)
      => ComCall(71, this.p, UInt32, dwHotKeyID, UInt32.Ptr, puModifiers, UInt32.Ptr, puVKey, HKL.Ptr, phKL)
    SetHotKey(dwHotKeyID, uModifiers, uVKey, hKL1)
      => ComCall(72, this.p, UInt32, dwHotKeyID, UInt32, uModifiers, UInt32, uVKey, HKL, hKL1)
    CreateSoftKeyboard(uType, hOwner, x, y, phSoftKbdWnd)
      => ComCall(73, this.p, UInt32, uType, HWND, hOwner, Int32, x, Int32, y, HWND.Ptr, phSoftKbdWnd)
    DestroySoftKeyboard(hSoftKbdWnd)
      => ComCall(74, this.p, HWND, hSoftKbdWnd)
    ShowSoftKeyboard(hSoftKbdWnd, nCmdShow)
      => ComCall(75, this.p, HWND, hSoftKbdWnd, Int32, nCmdShow)
    GetCodePageA(hKL1, uCodePage)
      => ComCall(76, this.p, HKL, hKL1, UInt32.Ptr, uCodePage)
    GetLangId(hKL1, plid)
      => ComCall(77, this.p, HKL, hKL1, UInt16.Ptr, plid)
    KeybdEvent(lgidIME, bVk, bScan, dwFlags, dwExtraInfo)
      => ComCall(78, this.p, UInt16, lgidIME, UInt8, bVk, UInt8, bScan, UInt32, dwFlags, UInt32, dwExtraInfo)
    LockModal()
      => ComCall(79, this.p)
    UnlockModal()
      => ComCall(80, this.p)
    AssociateContextEx(hWnd1, hIMC1, dwFlags)
      => ComCall(81, this.p, HWND, hWnd1, HIMC, hIMC1, UInt32, dwFlags)
    DisableIME(idThread)
      => ComCall(82, this.p, UInt32, idThread)
    GetImeMenuItemsA(hIMC1, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
      => ComCall(83, this.p, HIMC, hIMC1, UInt32, dwFlags, UInt32, dwType, IMEMENUITEMINFOA.Ptr, pImeParentMenu, IMEMENUITEMINFOA.Ptr, pImeMenu, UInt32, dwSize, UInt32.Ptr, pdwResult)
    GetImeMenuItemsW(hIMC1, dwFlags, dwType, pImeParentMenu, pImeMenu, dwSize, pdwResult)
      => ComCall(84, this.p, HIMC, hIMC1, UInt32, dwFlags, UInt32, dwType, IMEMENUITEMINFOW.Ptr, pImeParentMenu, IMEMENUITEMINFOW.Ptr, pImeMenu, UInt32, dwSize, UInt32.Ptr, pdwResult)
    EnumInputContext(idThread, ppEnum)
      => ComCall(85, this.p, UInt32, idThread, IEnumInputContext.Ptr, ppEnum)
    RequestMessageA(hIMC1, wParam1, lParam1, plResult)
      => ComCall(86, this.p, HIMC, hIMC1, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    RequestMessageW(hIMC1, wParam1, lParam1, plResult)
      => ComCall(87, this.p, HIMC, hIMC1, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    SendIMCA(hWnd1, uMsg, wParam1, lParam1, plResult)
      => ComCall(88, this.p, HWND, hWnd1, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    SendIMCW(hWnd1, uMsg, wParam1, lParam1, plResult)
      => ComCall(89, this.p, HWND, hWnd1, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    IsSleeping()
      => ComCall(90, this.p)
}
struct IActiveIME extends IUnknown {
    static IID := "{6FE20962-D077-11D0-8FE7-00AA006BCC59}"
    Inquire(dwSystemInfoFlags, pIMEInfo, szWndClass, pdwPrivate)
      => ComCall(3, this.p, UInt32, dwSystemInfoFlags, IMEINFO.Ptr, pIMEInfo, PWSTR, szWndClass, UInt32.Ptr, pdwPrivate)
    ConversionList(hIMC1, szSource, uFlag, uBufLen, pDest, puCopied)
      => ComCall(4, this.p, HIMC, hIMC1, "Str", szSource, UInt32, uFlag, UInt32, uBufLen, CANDIDATELIST.Ptr, pDest, UInt32.Ptr, puCopied)
    Configure(hKL1, hWnd1, dwMode, pRegisterWord)
      => ComCall(5, this.p, HKL, hKL1, HWND, hWnd1, UInt32, dwMode, REGISTERWORDW.Ptr, pRegisterWord)
    Destroy(uReserved)
      => ComCall(6, this.p, UInt32, uReserved)
    Escape(hIMC1, uEscape, pData, plResult)
      => ComCall(7, this.p, HIMC, hIMC1, UInt32, uEscape, Struct.Ptr, pData, LRESULT.Ptr, plResult)
    SetActiveContext(hIMC1, fFlag)
      => ComCall(8, this.p, HIMC, hIMC1, BOOL, fFlag)
    ProcessKey(hIMC1, uVirKey, lParam, pbKeyState)
      => ComCall(9, this.p, HIMC, hIMC1, UInt32, uVirKey, UInt32, lParam, UInt8.Ptr, pbKeyState)
    Notify(hIMC1, dwAction, dwIndex, dwValue)
      => ComCall(10, this.p, HIMC, hIMC1, UInt32, dwAction, UInt32, dwIndex, UInt32, dwValue)
    Select(hIMC1, fSelect)
      => ComCall(11, this.p, HIMC, hIMC1, BOOL, fSelect)
    SetCompositionString(hIMC1, dwIndex, pComp, dwCompLen, pRead, dwReadLen)
      => ComCall(12, this.p, HIMC, hIMC1, UInt32, dwIndex, Struct.Ptr, pComp, UInt32, dwCompLen, Struct.Ptr, pRead, UInt32, dwReadLen)
    ToAsciiEx(uVirKey, uScanCode, pbKeyState, fuState, hIMC1, pdwTransBuf, puSize)
      => ComCall(13, this.p, UInt32, uVirKey, UInt32, uScanCode, UInt8.Ptr, pbKeyState, UInt32, fuState, HIMC, hIMC1, UInt32.Ptr, pdwTransBuf, UInt32.Ptr, puSize)
    RegisterWord(szReading, dwStyle, szString)
      => ComCall(14, this.p, "Str", szReading, UInt32, dwStyle, "Str", szString)
    UnregisterWord(szReading, dwStyle, szString)
      => ComCall(15, this.p, "Str", szReading, UInt32, dwStyle, "Str", szString)
    GetRegisterWordStyle(nItem, pStyleBuf, puBufSize)
      => ComCall(16, this.p, UInt32, nItem, STYLEBUFW.Ptr, pStyleBuf, UInt32.Ptr, puBufSize)
    EnumRegisterWord(szReading, dwStyle, szRegister, pData, ppEnum)
      => ComCall(17, this.p, "Str", szReading, UInt32, dwStyle, "Str", szRegister, Struct.Ptr, pData, IEnumRegisterWordW.Ptr, ppEnum)
    GetCodePageA(uCodePage)
      => ComCall(18, this.p, UInt32.Ptr, uCodePage)
    GetLangId(plid)
      => ComCall(19, this.p, UInt16.Ptr, plid)
}
struct IActiveIME2 extends IActiveIME {
    static IID := "{E1C4BF0E-2D53-11D2-93E1-0060B067B86E}"
    Sleep()
      => ComCall(20, this.p)
    Unsleep(fDead)
      => ComCall(21, this.p, BOOL, fDead)
}
