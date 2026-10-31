#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, COLORREF, HANDLE, HGLOBAL, HRESULT, HWND, LPARAM, LRESULT, POINT, PSTR, PWSTR, RECT, RECTL, SIZE, WPARAM}
#Import "..\Graphics.Direct2D\Types.ahk" {ID2D1RenderTarget}
#Import "..\Graphics.Gdi\Types.ahk" {FONT_CHARSET, HBITMAP, HDC, HPALETTE, HRGN, SYS_COLOR_INDEX}
#Import "..\System.Com\Types.ahk" {DVASPECT, DVTARGETDEVICE, IDataObject, IDispatch, IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}
#Import "..\System.Ole\Types.ahk" {DROPEFFECT, IDropTarget, IOleClientSite, IOleInPlaceFrame, IOleInPlaceUIWindow, IOleObject, OLEINPLACEFRAMEINFO}
#Import "..\System.SystemServices\Types.ahk" {MODIFIERKEYS_FLAGS, RECO_FLAGS}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {NMHDR}
#Import "..\UI.Input.Ime\Types.ahk" {HIMC}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HCURSOR, HMENU, SCROLLBAR_CONSTANTS, SCROLL_WINDOW_FLAGS}

struct CFM_MASK extends UInt32 {
    static CFM_SUBSCRIPT := 196608
    static CFM_SUPERSCRIPT := 196608
    static CFM_EFFECTS := 1073741887
    static CFM_ALL := 4160749631
    static CFM_BOLD := 1
    static CFM_CHARSET := 134217728
    static CFM_COLOR := 1073741824
    static CFM_FACE := 536870912
    static CFM_ITALIC := 2
    static CFM_OFFSET := 268435456
    static CFM_PROTECTED := 16
    static CFM_SIZE := 2147483648
    static CFM_STRIKEOUT := 8
    static CFM_UNDERLINE := 4
    static CFM_LINK := 32
    static CFM_SMALLCAPS := 64
    static CFM_ALLCAPS := 128
    static CFM_HIDDEN := 256
    static CFM_OUTLINE := 512
    static CFM_SHADOW := 1024
    static CFM_EMBOSS := 2048
    static CFM_IMPRINT := 4096
    static CFM_DISABLED := 8192
    static CFM_REVISED := 16384
    static CFM_REVAUTHOR := 32768
    static CFM_ANIMATION := 262144
    static CFM_STYLE := 524288
    static CFM_KERNING := 1048576
    static CFM_SPACING := 2097152
    static CFM_WEIGHT := 4194304
    static CFM_UNDERLINETYPE := 8388608
    static CFM_COOKIE := 16777216
    static CFM_LCID := 33554432
    static CFM_BACKCOLOR := 67108864
    static CFM_EFFECTS2 := 1141080063
    static CFM_ALL2 := 4294967295
    static CFM_FONTBOUND := 1048576
    static CFM_LINKPROTECTED := 8388608
    static CFM_EXTENDED := 33554432
    static CFM_MATHNOBUILDUP := 134217728
    static CFM_MATH := 268435456
    static CFM_MATHORDINARY := 536870912
    static CFM_ALLEFFECTS := 2115207167
}
struct CFE_EFFECTS extends UInt32 {
    static CFE_ALLCAPS := 128
    static CFE_AUTOBACKCOLOR := 67108864
    static CFE_DISABLED := 8192
    static CFE_EMBOSS := 2048
    static CFE_HIDDEN := 256
    static CFE_IMPRINT := 4096
    static CFE_OUTLINE := 512
    static CFE_REVISED := 16384
    static CFE_SHADOW := 1024
    static CFE_SMALLCAPS := 64
    static CFE_AUTOCOLOR := 1073741824
    static CFE_BOLD := 1
    static CFE_ITALIC := 2
    static CFE_STRIKEOUT := 8
    static CFE_UNDERLINE := 4
    static CFE_PROTECTED := 16
    static CFE_LINK := 32
    static CFE_SUBSCRIPT := 65536
    static CFE_SUPERSCRIPT := 131072
    static CFE_FONTBOUND := 1048576
    static CFE_LINKPROTECTED := 8388608
    static CFE_EXTENDED := 33554432
    static CFE_MATHNOBUILDUP := 134217728
    static CFE_MATH := 268435456
    static CFE_MATHORDINARY := 536870912
}
struct PARAFORMAT_MASK extends UInt32 {
    static PFM_STARTINDENT := 1
    static PFM_RIGHTINDENT := 2
    static PFM_OFFSET := 4
    static PFM_ALIGNMENT := 8
    static PFM_TABSTOPS := 16
    static PFM_NUMBERING := 32
    static PFM_OFFSETINDENT := 2147483648
    static PFM_SPACEBEFORE := 64
    static PFM_SPACEAFTER := 128
    static PFM_LINESPACING := 256
    static PFM_STYLE := 1024
    static PFM_BORDER := 2048
    static PFM_SHADING := 4096
    static PFM_NUMBERINGSTYLE := 8192
    static PFM_NUMBERINGTAB := 16384
    static PFM_NUMBERINGSTART := 32768
    static PFM_RTLPARA := 65536
    static PFM_KEEP := 131072
    static PFM_KEEPNEXT := 262144
    static PFM_PAGEBREAKBEFORE := 524288
    static PFM_NOLINENUMBER := 1048576
    static PFM_NOWIDOWCONTROL := 2097152
    static PFM_DONOTHYPHEN := 4194304
    static PFM_SIDEBYSIDE := 8388608
    static PFM_COLLAPSED := 16777216
    static PFM_OUTLINELEVEL := 33554432
    static PFM_BOX := 67108864
    static PFM_RESERVED2 := 134217728
    static PFM_TABLEROWDELIMITER := 268435456
    static PFM_TEXTWRAPPINGBREAK := 536870912
    static PFM_TABLE := 1073741824
    static PFM_ALL := 2147549247
    static PFM_EFFECTS := 1358888960
    static PFM_ALL2 := 3506437631
}
struct RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE extends UInt16 {
    static SEL_EMPTY := 0
    static SEL_TEXT := 1
    static SEL_OBJECT := 2
    static SEL_MULTICHAR := 4
    static SEL_MULTIOBJECT := 8
    static GCM_RIGHTMOUSEDROP := 32768
}
struct RICH_EDIT_GET_OBJECT_FLAGS extends UInt32 {
    static REO_GETOBJ_POLEOBJ := 1
    static REO_GETOBJ_PSTG := 2
    static REO_GETOBJ_POLESITE := 4
    static REO_GETOBJ_NO_INTERFACES := 0
    static REO_GETOBJ_ALL_INTERFACES := 7
}
struct PARAFORMAT_BORDERS extends UInt16 {
    static PARAFORMAT_BORDERS_LEFT := 1
    static PARAFORMAT_BORDERS_RIGHT := 2
    static PARAFORMAT_BORDERS_TOP := 4
    static PARAFORMAT_BORDERS_BOTTOM := 8
    static PARAFORMAT_BORDERS_INSIDE := 16
    static PARAFORMAT_BORDERS_OUTSIDE := 32
    static PARAFORMAT_BORDERS_AUTOCOLOR := 64
}
struct PARAFORMAT_SHADING_STYLE extends UInt16 {
    static PARAFORMAT_SHADING_STYLE_NONE := 0
    static PARAFORMAT_SHADING_STYLE_DARK_HORIZ := 1
    static PARAFORMAT_SHADING_STYLE_DARK_VERT := 2
    static PARAFORMAT_SHADING_STYLE_DARK_DOWN_DIAG := 3
    static PARAFORMAT_SHADING_STYLE_DARK_UP_DIAG := 4
    static PARAFORMAT_SHADING_STYLE_DARK_GRID := 5
    static PARAFORMAT_SHADING_STYLE_DARK_TRELLIS := 6
    static PARAFORMAT_SHADING_STYLE_LIGHT_HORZ := 7
    static PARAFORMAT_SHADING_STYLE_LIGHT_VERT := 8
    static PARAFORMAT_SHADING_STYLE_LIGHT_DOWN_DIAG := 9
    static PARAFORMAT_SHADING_STYLE_LIGHT_UP_DIAG := 10
    static PARAFORMAT_SHADING_STYLE_LIGHT_GRID := 11
    static PARAFORMAT_SHADING_STYLE_LIGHT_TRELLIS := 12
}
struct GETTEXTEX_FLAGS extends UInt32 {
    static GT_DEFAULT := 0
    static GT_NOHIDDENTEXT := 8
    static GT_RAWTEXT := 4
    static GT_SELECTION := 2
    static GT_USECRLF := 1
}
struct ENDCOMPOSITIONNOTIFY_CODE extends UInt32 {
    static ECN_ENDCOMPOSITION := 1
    static ECN_NEWTEXT := 2
}
struct IMECOMPTEXT_FLAGS extends UInt32 {
    static ICT_RESULTREADSTR := 1
}
struct GETTEXTLENGTHEX_FLAGS extends UInt32 {
    static GTL_DEFAULT := 0
    static GTL_USECRLF := 1
    static GTL_PRECISE := 2
    static GTL_CLOSE := 4
    static GTL_NUMCHARS := 8
    static GTL_NUMBYTES := 16
}
struct REOBJECT_FLAGS extends UInt32 {
    static REO_ALIGNTORIGHT := 256
    static REO_BELOWBASELINE := 2
    static REO_BLANK := 16
    static REO_CANROTATE := 128
    static REO_DONTNEEDPALETTE := 32
    static REO_DYNAMICSIZE := 8
    static REO_GETMETAFILE := 4194304
    static REO_HILITED := 16777216
    static REO_INPLACEACTIVE := 33554432
    static REO_INVERTEDSELECT := 4
    static REO_LINK := 2147483648
    static REO_LINKAVAILABLE := 8388608
    static REO_OPEN := 67108864
    static REO_OWNERDRAWSELECT := 64
    static REO_RESIZABLE := 1
    static REO_SELECTED := 134217728
    static REO_STATIC := 1073741824
    static REO_USEASBACKGROUND := 1024
    static REO_WRAPTEXTAROUND := 512
}
struct PARAFORMAT_NUMBERING_STYLE extends UInt16 {
    static PFNS_PAREN := 0
    static PFNS_PARENS := 256
    static PFNS_PERIOD := 512
    static PFNS_PLAIN := 768
    static PFNS_NONUMBER := 1024
    static PFNS_NEWNUMBER := 32768
}
struct PARAFORMAT_ALIGNMENT extends UInt16 {
    static PFA_LEFT := 1
    static PFA_RIGHT := 2
    static PFA_CENTER := 3
    static PFA_JUSTIFY := 4
    static PFA_FULL_INTERWORD := 4
    static PFA_FULL_NEWSPAPER := 5
    static PFA_FULL_INTERLETTER := 6
    static PFA_FULL_SCALED := 7
    static PFA_FULL_GLYPHS := 8
}
struct PARAFORMAT_NUMBERING extends UInt16 {
    static PFN_BULLET := 1
    static PFN_ARABIC := 2
    static PFN_LCLETTER := 3
    static PFN_UCLETTER := 4
    static PFN_LCROMAN := 5
    static PFN_UCROMAN := 6
}
struct RICHEDIT_IMAGE_PARAMETERS {
    xWidth : Int32
    yHeight : Int32
    Ascent : Int32
    Type : Int32
    pwszAlternateText : PWSTR
    pIStream : IStream
}
struct ENDCOMPOSITIONNOTIFY {
    nmhdr : NMHDR
    dwCode : ENDCOMPOSITIONNOTIFY_CODE
}
struct TEXTRANGEA {
    chrg : CHARRANGE
    lpstrText : PSTR
}
struct TEXTRANGEW {
    chrg : CHARRANGE
    lpstrText : PWSTR
}
struct EDITSTREAM {
    dwCookie : IntPtr
    dwError : UInt32
    pfnCallback : EDITSTREAMCALLBACK
}
struct FINDTEXTA {
    chrg : CHARRANGE
    lpstrText : PSTR
}
struct FINDTEXTW {
    chrg : CHARRANGE
    lpstrText : PWSTR
}
struct FINDTEXTEXA {
    chrg : CHARRANGE
    lpstrText : PSTR
    chrgText : CHARRANGE
}
struct FINDTEXTEXW {
    chrg : CHARRANGE
    lpstrText : PWSTR
    chrgText : CHARRANGE
}
struct FORMATRANGE {
    hdc : HDC
    hdcTarget : HDC
    rc : RECT
    rcPage : RECT
    chrg : CHARRANGE
}
struct MSGFILTER {
    nmhdr : NMHDR
    msg : UInt32
    wParam : WPARAM
    lParam : LPARAM
}
struct REQRESIZE {
    nmhdr : NMHDR
    rc : RECT
}
struct SELCHANGE {
    nmhdr : NMHDR
    chrg : CHARRANGE
    seltyp : RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE
}
struct CLIPBOARDFORMAT {
    nmhdr : NMHDR
    cf : UInt16
}
struct GETCONTEXTMENUEX {
    chrg : CHARRANGE
    dwFlags : UInt32
    pt : POINT
    pvReserved : Struct.Ptr
}
struct ENDROPFILES {
    nmhdr : NMHDR
    hDrop : HANDLE
    cp : Int32
    fProtected : BOOL
}
struct ENPROTECTED {
    nmhdr : NMHDR
    msg : UInt32
    wParam : WPARAM
    lParam : LPARAM
    chrg : CHARRANGE
}
struct ENSAVECLIPBOARD {
    nmhdr : NMHDR
    cObjectCount : Int32
    cch : Int32
}
struct ENOLEOPFAILED {
    nmhdr : NMHDR
    iob : Int32
    lOper : Int32
    hr : HRESULT
}
struct OBJECTPOSITIONS {
    nmhdr : NMHDR
    cObjectCount : Int32
    pcpPositions : Int32.Ptr
}
struct ENLINK {
    nmhdr : NMHDR
    msg : UInt32
    wParam : WPARAM
    lParam : LPARAM
    chrg : CHARRANGE
}
struct ENLOWFIRTF {
    nmhdr : NMHDR
    szControl : PSTR
}
struct ENCORRECTTEXT {
    nmhdr : NMHDR
    chrg : CHARRANGE
    seltyp : RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE
}
struct PUNCTUATION {
    iSize : UInt32
    szPunctuation : PSTR
}
struct REPASTESPECIAL {
    dwAspect : DVASPECT
    dwParam : IntPtr
}
struct GETTEXTEX {
    cb : UInt32
    flags : GETTEXTEX_FLAGS
    codepage : UInt32
    lpDefaultChar : PSTR
    lpUsedDefChar : BOOL.Ptr
}
struct HYPHENATEINFO {
    cbSize : Int16 := this.Size
    dxHyphenateZone : Int16
    pfnHyphenate : IntPtr
}
struct TEXTMODE extends Int32 {
    static TM_PLAINTEXT := 1
    static TM_RICHTEXT := 2
    static TM_SINGLELEVELUNDO := 4
    static TM_MULTILEVELUNDO := 8
    static TM_SINGLECODEPAGE := 16
    static TM_MULTICODEPAGE := 32
}
struct IMECOMPTEXT {
    cb : Int32
    flags : IMECOMPTEXT_FLAGS
}
struct TABLEROWPARMS {
    cbRow : UInt8
    cbCell : UInt8
    cCell : UInt8
    cRow : UInt8
    dxCellMargin : Int32
    dxIndent : Int32
    dyHeight : Int32
    _bitfield : UInt32
    cpStartRow : Int32
    bTableLevel : UInt8
    iCell : UInt8
}
struct TABLECELLPARMS {
    dxWidth : Int32
    _bitfield : UInt16
    wShading : UInt16
    dxBrdrLeft : Int16
    dyBrdrTop : Int16
    dxBrdrRight : Int16
    dyBrdrBottom : Int16
    crBrdrLeft : COLORREF
    crBrdrTop : COLORREF
    crBrdrRight : COLORREF
    crBrdrBottom : COLORREF
    crBackPat : COLORREF
    crForePat : COLORREF
}
struct AutoCorrectProc extends FunctionPointer {
    static Types := [UInt16, PWSTR, PWSTR, Int32, Int32.Ptr, Int32]
}
struct EDITWORDBREAKPROCEX extends FunctionPointer {
    static Types := [PSTR, Int32, UInt8, Int32, Int32]
}
struct CHARFORMATA {
    cbSize : UInt32 := this.Size
    dwMask : CFM_MASK
    dwEffects : CFE_EFFECTS
    yHeight : Int32
    yOffset : Int32
    crTextColor : COLORREF
    bCharSet : FONT_CHARSET
    bPitchAndFamily : UInt8
    szFaceName : CHAR[32]
}
struct CHARFORMATW {
    cbSize : UInt32 := this.Size
    dwMask : CFM_MASK
    dwEffects : CFE_EFFECTS
    yHeight : Int32
    yOffset : Int32
    crTextColor : COLORREF
    bCharSet : FONT_CHARSET
    bPitchAndFamily : UInt8
    szFaceName : UInt16[32]
}
struct CHARFORMAT2W {
    Base : CHARFORMATW
    wWeight : UInt16
    sSpacing : Int16
    crBackColor : COLORREF
    lcid : UInt32
    Anonymous : this._Anonymous_e__Union
    sStyle : Int16
    wKerning : UInt16
    bUnderlineType : UInt8
    bAnimation : UInt8
    bRevAuthor : UInt8
    bUnderlineColor : UInt8
    struct _Anonymous_e__Union {
        union {
            dwReserved : UInt32
            dwCookie : UInt32
        }
    }
}
struct CHARFORMAT2A {
    Base : CHARFORMATA
    wWeight : UInt16
    sSpacing : Int16
    crBackColor : COLORREF
    lcid : UInt32
    Anonymous : this._Anonymous_e__Union
    sStyle : Int16
    wKerning : UInt16
    bUnderlineType : UInt8
    bAnimation : UInt8
    bRevAuthor : UInt8
    bUnderlineColor : UInt8
    struct _Anonymous_e__Union {
        union {
            dwReserved : UInt32
            dwCookie : UInt32
        }
    }
}
struct CHARRANGE {
    cpMin : Int32
    cpMax : Int32
}
struct EDITSTREAMCALLBACK extends FunctionPointer {
    static Types := [IntPtr, UInt8.Ptr, Int32, Int32.Ptr, UInt32]
}
struct PARAFORMAT {
    cbSize : UInt32 := this.Size
    dwMask : PARAFORMAT_MASK
    wNumbering : PARAFORMAT_NUMBERING
    Anonymous : this._Anonymous_e__Union
    dxStartIndent : Int32
    dxRightIndent : Int32
    dxOffset : Int32
    wAlignment : PARAFORMAT_ALIGNMENT
    cTabCount : Int16
    rgxTabs : UInt32[32]
    struct _Anonymous_e__Union {
        union {
            wReserved : UInt16
            wEffects : UInt16
        }
    }
}
struct PARAFORMAT2 {
    Base : PARAFORMAT
    dySpaceBefore : Int32
    dySpaceAfter : Int32
    dyLineSpacing : Int32
    sStyle : Int16
    bLineSpacingRule : UInt8
    bOutlineLevel : UInt8
    wShadingWeight : UInt16
    wShadingStyle : PARAFORMAT_SHADING_STYLE
    wNumberingStart : UInt16
    wNumberingStyle : PARAFORMAT_NUMBERING_STYLE
    wNumberingTab : UInt16
    wBorderSpace : UInt16
    wBorderWidth : UInt16
    wBorders : PARAFORMAT_BORDERS
}
struct GROUPTYPINGCHANGE {
    nmhdr : NMHDR
    fGroupTyping : BOOL
}
struct COMPCOLOR {
    crText : COLORREF
    crBackground : COLORREF
    dwEffects : UInt32
}
struct UNDONAMEID extends Int32 {
    static UID_UNKNOWN := 0
    static UID_TYPING := 1
    static UID_DELETE := 2
    static UID_DRAGDROP := 3
    static UID_CUT := 4
    static UID_PASTE := 5
    static UID_AUTOTABLE := 6
}
struct SETTEXTEX {
    flags : UInt32
    codepage : UInt32
}
struct GETTEXTLENGTHEX {
    flags : GETTEXTLENGTHEX_FLAGS
    codepage : UInt32
}
struct BIDIOPTIONS {
    cbSize : UInt32 := this.Size
    wMask : UInt16
    wEffects : UInt16
}
struct KHYPH extends Int32 {
    static khyphNil := 0
    static khyphNormal := 1
    static khyphAddBefore := 2
    static khyphChangeBefore := 3
    static khyphDeleteBefore := 4
    static khyphChangeAfter := 5
    static khyphDelAndChange := 6
}
struct HYPHRESULT {
    khyph : KHYPH
    ichHyph : Int32
    chHyph : UInt16
}
struct TXTBACKSTYLE extends Int32 {
    static TXTBACK_TRANSPARENT := 0
    static TXTBACK_OPAQUE := 1
}
struct TXTHITRESULT extends Int32 {
    static TXTHITRESULT_NOHIT := 0
    static TXTHITRESULT_TRANSPARENT := 1
    static TXTHITRESULT_CLOSE := 2
    static TXTHITRESULT_HIT := 3
}
struct TXTNATURALSIZE extends Int32 {
    static TXTNS_FITTOCONTENT2 := 0
    static TXTNS_FITTOCONTENT := 1
    static TXTNS_ROUNDTOLINE := 2
    static TXTNS_FITTOCONTENT3 := 3
    static TXTNS_FITTOCONTENTWSP := 4
    static TXTNS_INCLUDELASTLINE := 1073741824
    static TXTNS_EMU := -2147483648
}
struct TXTVIEW extends Int32 {
    static TXTVIEW_ACTIVE := 0
    static TXTVIEW_INACTIVE := -1
}
struct CHANGETYPE extends Int32 {
    static CN_GENERIC := 0
    static CN_TEXTCHANGED := 1
    static CN_NEWUNDO := 2
    static CN_NEWREDO := 4
}
struct CHANGENOTIFY {
    dwChangeType : UInt32
    pvCookieData : Struct.Ptr
}
struct ITextServices extends IUnknown {
    TxSendMessage(msg, wparam1, lparam1, plresult)
      => ComCall(3, this.p, UInt32, msg, WPARAM, wparam1, LPARAM, lparam1, LRESULT.Ptr, plresult)
    TxDraw(dwDrawAspect, lindex, pvAspect, ptd, hdcDraw, hicTargetDev, lprcBounds, lprcWBounds, lprcUpdate, pfnContinue, dwContinue, lViewId)
      => ComCall(4, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, DVTARGETDEVICE.Ptr, ptd, HDC, hdcDraw, HDC, hicTargetDev, RECTL.Ptr, lprcBounds, RECTL.Ptr, lprcWBounds, RECT.Ptr, lprcUpdate, IntPtr, pfnContinue, UInt32, dwContinue, Int32, lViewId)
    TxGetHScroll(plMin, plMax, plPos, plPage, pfEnabled)
      => ComCall(5, this.p, Int32.Ptr, plMin, Int32.Ptr, plMax, Int32.Ptr, plPos, Int32.Ptr, plPage, BOOL.Ptr, pfEnabled)
    TxGetVScroll(plMin, plMax, plPos, plPage, pfEnabled)
      => ComCall(6, this.p, Int32.Ptr, plMin, Int32.Ptr, plMax, Int32.Ptr, plPos, Int32.Ptr, plPage, BOOL.Ptr, pfEnabled)
    OnTxSetCursor(dwDrawAspect, lindex, pvAspect, ptd, hdcDraw, hicTargetDev, lprcClient, x, y)
      => ComCall(7, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, DVTARGETDEVICE.Ptr, ptd, HDC, hdcDraw, HDC, hicTargetDev, RECT.Ptr, lprcClient, Int32, x, Int32, y)
    TxQueryHitPoint(dwDrawAspect, lindex, pvAspect, ptd, hdcDraw, hicTargetDev, lprcClient, x, y, pHitResult)
      => ComCall(8, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, DVTARGETDEVICE.Ptr, ptd, HDC, hdcDraw, HDC, hicTargetDev, RECT.Ptr, lprcClient, Int32, x, Int32, y, UInt32.Ptr, pHitResult)
    OnTxInPlaceActivate(prcClient)
      => ComCall(9, this.p, RECT.Ptr, prcClient)
    OnTxInPlaceDeactivate()
      => ComCall(10, this.p)
    OnTxUIActivate()
      => ComCall(11, this.p)
    OnTxUIDeactivate()
      => ComCall(12, this.p)
    TxGetText(pbstrText)
      => ComCall(13, this.p, BSTR.Ptr, pbstrText)
    TxSetText(pszText)
      => ComCall(14, this.p, "Str", pszText)
    TxGetCurTargetX(param0)
      => ComCall(15, this.p, Int32.Ptr, param0)
    TxGetBaseLinePos(param0)
      => ComCall(16, this.p, Int32.Ptr, param0)
    TxGetNaturalSize(dwAspect, hdcDraw, hicTargetDev, ptd, dwMode, psizelExtent, pwidth, pheight)
      => ComCall(17, this.p, UInt32, dwAspect, HDC, hdcDraw, HDC, hicTargetDev, DVTARGETDEVICE.Ptr, ptd, UInt32, dwMode, SIZE.Ptr, psizelExtent, Int32.Ptr, pwidth, Int32.Ptr, pheight)
    TxGetDropTarget(ppDropTarget)
      => ComCall(18, this.p, IDropTarget.Ptr, ppDropTarget)
    OnTxPropertyBitsChange(dwMask, dwBits)
      => ComCall(19, this.p, UInt32, dwMask, UInt32, dwBits)
    TxGetCachedSize(pdwWidth, pdwHeight)
      => ComCall(20, this.p, UInt32.Ptr, pdwWidth, UInt32.Ptr, pdwHeight)
}
struct CARET_FLAGS extends Int32 {
    static CARET_NONE := 0
    static CARET_CUSTOM := 1
    static CARET_RTL := 2
    static CARET_ITALIC := 32
    static CARET_NULL := 64
    static CARET_ROTATE90 := 128
}
struct CARET_INFO {
    union {
        hbitmap : HBITMAP
        caretFlags : CARET_FLAGS
    }
}
struct ITextHost extends IUnknown {
    TxGetDC()
      => ComCall(3, this.p, HDC)
    TxReleaseDC(hdc1)
      => ComCall(4, this.p, HDC, hdc1, Int32)
    TxShowScrollBar(fnBar, fShow)
      => ComCall(5, this.p, Int32, fnBar, BOOL, fShow, BOOL)
    TxEnableScrollBar(fuSBFlags, fuArrowflags)
      => ComCall(6, this.p, SCROLLBAR_CONSTANTS, fuSBFlags, Int32, fuArrowflags, BOOL)
    TxSetScrollRange(fnBar, nMinPos, nMaxPos, fRedraw)
      => ComCall(7, this.p, Int32, fnBar, Int32, nMinPos, Int32, nMaxPos, BOOL, fRedraw, BOOL)
    TxSetScrollPos(fnBar, nPos, fRedraw)
      => ComCall(8, this.p, Int32, fnBar, Int32, nPos, BOOL, fRedraw, BOOL)
    TxInvalidateRect(prc, fMode)
      => ComCall(9, this.p, RECT.Ptr, prc, BOOL, fMode, "void")
    TxViewChange(fUpdate)
      => ComCall(10, this.p, BOOL, fUpdate, "void")
    TxCreateCaret(hbmp, xWidth, yHeight)
      => ComCall(11, this.p, HBITMAP, hbmp, Int32, xWidth, Int32, yHeight, BOOL)
    TxShowCaret(fShow)
      => ComCall(12, this.p, BOOL, fShow, BOOL)
    TxSetCaretPos(x, y)
      => ComCall(13, this.p, Int32, x, Int32, y, BOOL)
    TxSetTimer(idTimer, uTimeout)
      => ComCall(14, this.p, UInt32, idTimer, UInt32, uTimeout, BOOL)
    TxKillTimer(idTimer)
      => ComCall(15, this.p, UInt32, idTimer, "void")
    TxScrollWindowEx(dx, dy, lprcScroll, lprcClip, hrgnUpdate, lprcUpdate, fuScroll)
      => ComCall(16, this.p, Int32, dx, Int32, dy, RECT.Ptr, lprcScroll, RECT.Ptr, lprcClip, HRGN, hrgnUpdate, RECT.Ptr, lprcUpdate, SCROLL_WINDOW_FLAGS, fuScroll, "void")
    TxSetCapture(fCapture)
      => ComCall(17, this.p, BOOL, fCapture, "void")
    TxSetFocus()
      => ComCall(18, this.p, "void")
    TxSetCursor(hcur, fText)
      => ComCall(19, this.p, HCURSOR, hcur, BOOL, fText, "void")
    TxScreenToClient(lppt)
      => ComCall(20, this.p, POINT.Ptr, lppt, BOOL)
    TxClientToScreen(lppt)
      => ComCall(21, this.p, POINT.Ptr, lppt, BOOL)
    TxActivate(plOldState)
      => ComCall(22, this.p, Int32.Ptr, plOldState)
    TxDeactivate(lNewState)
      => ComCall(23, this.p, Int32, lNewState)
    TxGetClientRect(prc)
      => ComCall(24, this.p, RECT.Ptr, prc)
    TxGetViewInset(prc)
      => ComCall(25, this.p, RECT.Ptr, prc)
    TxGetCharFormat(ppCF)
      => ComCall(26, this.p, CHARFORMATW.Ptr.Ptr, ppCF)
    TxGetParaFormat(ppPF)
      => ComCall(27, this.p, PARAFORMAT.Ptr.Ptr, ppPF)
    TxGetSysColor(nIndex)
      => ComCall(28, this.p, SYS_COLOR_INDEX, nIndex, COLORREF)
    TxGetBackStyle(pstyle)
      => ComCall(29, this.p, TXTBACKSTYLE.Ptr, pstyle)
    TxGetMaxLength(plength)
      => ComCall(30, this.p, UInt32.Ptr, plength)
    TxGetScrollBars(pdwScrollBar)
      => ComCall(31, this.p, UInt32.Ptr, pdwScrollBar)
    TxGetPasswordChar(pch)
      => ComCall(32, this.p, Int8.Ptr, pch)
    TxGetAcceleratorPos(pcp)
      => ComCall(33, this.p, Int32.Ptr, pcp)
    TxGetExtent(lpExtent)
      => ComCall(34, this.p, SIZE.Ptr, lpExtent)
    OnTxCharFormatChange(pCF)
      => ComCall(35, this.p, CHARFORMATW.Ptr, pCF)
    OnTxParaFormatChange(pPF)
      => ComCall(36, this.p, PARAFORMAT.Ptr, pPF)
    TxGetPropertyBits(dwMask, pdwBits)
      => ComCall(37, this.p, UInt32, dwMask, UInt32.Ptr, pdwBits)
    TxNotify(iNotify, pv)
      => ComCall(38, this.p, UInt32, iNotify, Struct.Ptr, pv)
    TxImmGetContext()
      => ComCall(39, this.p, HIMC)
    TxImmReleaseContext(himc1)
      => ComCall(40, this.p, HIMC, himc1, "void")
    TxGetSelectionBarWidth(lSelBarWidth)
      => ComCall(41, this.p, Int32.Ptr, lSelBarWidth)
}
struct IRicheditUiaOverrides extends IUnknown {
    GetPropertyOverrideValue(propertyId, pRetValue)
      => ComCall(3, this.p, Int32, propertyId, VARIANT.Ptr, pRetValue)
}
struct PCreateTextServices extends FunctionPointer {
    static Types := [IUnknown, ITextHost, IUnknown.Ptr, HRESULT]
}
struct PShutdownTextServices extends FunctionPointer {
    static Types := [IUnknown, HRESULT]
}
struct ITextHost2 extends ITextHost {
    TxIsDoubleClickPending()
      => ComCall(42, this.p, BOOL)
    TxGetWindow(phwnd)
      => ComCall(43, this.p, HWND.Ptr, phwnd)
    TxSetForegroundWindow()
      => ComCall(44, this.p)
    TxGetPalette()
      => ComCall(45, this.p, HPALETTE)
    TxGetEastAsianFlags(pFlags)
      => ComCall(46, this.p, Int32.Ptr, pFlags)
    TxSetCursor2(hcur, bText)
      => ComCall(47, this.p, HCURSOR, hcur, BOOL, bText, HCURSOR)
    TxFreeTextServicesNotification()
      => ComCall(48, this.p, "void")
    TxGetEditStyle(dwItem, pdwData)
      => ComCall(49, this.p, UInt32, dwItem, UInt32.Ptr, pdwData)
    TxGetWindowStyles(pdwStyle, pdwExStyle)
      => ComCall(50, this.p, UInt32.Ptr, pdwStyle, UInt32.Ptr, pdwExStyle)
    TxShowDropCaret(fShow, hdc1, prc)
      => ComCall(51, this.p, BOOL, fShow, HDC, hdc1, RECT.Ptr, prc)
    TxDestroyCaret()
      => ComCall(52, this.p)
    TxGetHorzExtent(plHorzExtent)
      => ComCall(53, this.p, Int32.Ptr, plHorzExtent)
}
struct ITextServices2 extends ITextServices {
    TxGetNaturalSize2(dwAspect, hdcDraw, hicTargetDev, ptd, dwMode, psizelExtent, pwidth, pheight, pascent)
      => ComCall(21, this.p, UInt32, dwAspect, HDC, hdcDraw, HDC, hicTargetDev, DVTARGETDEVICE.Ptr, ptd, UInt32, dwMode, SIZE.Ptr, psizelExtent, Int32.Ptr, pwidth, Int32.Ptr, pheight, Int32.Ptr, pascent)
    TxDrawD2D(pRenderTarget, lprcBounds, lprcUpdate, lViewId)
      => ComCall(22, this.p, ID2D1RenderTarget, pRenderTarget, RECTL.Ptr, lprcBounds, RECT.Ptr, lprcUpdate, Int32, lViewId)
}
struct REOBJECT {
    cbStruct : UInt32
    cp : Int32
    clsid : GUID
    poleobj : IOleObject
    pstg : IStorage
    polesite : IOleClientSite
    sizel : SIZE
    dvaspect : UInt32
    dwFlags : REOBJECT_FLAGS
    dwUser : UInt32
}
struct IRichEditOle extends IUnknown {
    static IID := "{00020D00-0000-0000-C000-000000000046}"
    GetClientSite(lplpolesite)
      => ComCall(3, this.p, IOleClientSite.Ptr, lplpolesite)
    GetObjectCount()
      => ComCall(4, this.p, Int32)
    GetLinkCount()
      => ComCall(5, this.p, Int32)
    GetObject(iob, lpreobject, dwFlags)
      => ComCall(6, this.p, Int32, iob, REOBJECT.Ptr, lpreobject, RICH_EDIT_GET_OBJECT_FLAGS, dwFlags)
    InsertObject(lpreobject)
      => ComCall(7, this.p, REOBJECT.Ptr, lpreobject)
    ConvertObject(iob, rclsidNew, lpstrUserTypeNew)
      => ComCall(8, this.p, Int32, iob, GUID.Ptr, rclsidNew, PSTR, lpstrUserTypeNew)
    ActivateAs(rclsid, rclsidAs)
      => ComCall(9, this.p, GUID.Ptr, rclsid, GUID.Ptr, rclsidAs)
    SetHostNames(lpstrContainerApp, lpstrContainerObj)
      => ComCall(10, this.p, PSTR, lpstrContainerApp, PSTR, lpstrContainerObj)
    SetLinkAvailable(iob, fAvailable)
      => ComCall(11, this.p, Int32, iob, BOOL, fAvailable)
    SetDvaspect(iob, dvaspect)
      => ComCall(12, this.p, Int32, iob, UInt32, dvaspect)
    HandsOffStorage(iob)
      => ComCall(13, this.p, Int32, iob)
    SaveCompleted(iob, lpstg)
      => ComCall(14, this.p, Int32, iob, IStorage, lpstg)
    InPlaceDeactivate()
      => ComCall(15, this.p)
    ContextSensitiveHelp(fEnterMode)
      => ComCall(16, this.p, BOOL, fEnterMode)
    GetClipboardData(lpchrg, reco, lplpdataobj)
      => ComCall(17, this.p, CHARRANGE.Ptr, lpchrg, UInt32, reco, IDataObject.Ptr, lplpdataobj)
    ImportDataObject(lpdataobj, cf, hMetaPict)
      => ComCall(18, this.p, IDataObject, lpdataobj, UInt16, cf, HGLOBAL, hMetaPict)
}
struct IRichEditOleCallback extends IUnknown {
    static IID := "{00020D03-0000-0000-C000-000000000046}"
    GetNewStorage(lplpstg)
      => ComCall(3, this.p, IStorage.Ptr, lplpstg)
    GetInPlaceContext(lplpFrame, lplpDoc, lpFrameInfo)
      => ComCall(4, this.p, IOleInPlaceFrame.Ptr, lplpFrame, IOleInPlaceUIWindow.Ptr, lplpDoc, OLEINPLACEFRAMEINFO.Ptr, lpFrameInfo)
    ShowContainerUI(fShow)
      => ComCall(5, this.p, BOOL, fShow)
    QueryInsertObject(lpclsid, lpstg, cp)
      => ComCall(6, this.p, GUID.Ptr, lpclsid, IStorage, lpstg, Int32, cp)
    DeleteObject(lpoleobj)
      => ComCall(7, this.p, IOleObject, lpoleobj)
    QueryAcceptData(lpdataobj, lpcfFormat, reco, fReally, hMetaPict)
      => ComCall(8, this.p, IDataObject, lpdataobj, UInt16.Ptr, lpcfFormat, RECO_FLAGS, reco, BOOL, fReally, HGLOBAL, hMetaPict)
    ContextSensitiveHelp(fEnterMode)
      => ComCall(9, this.p, BOOL, fEnterMode)
    GetClipboardData(lpchrg, reco, lplpdataobj)
      => ComCall(10, this.p, CHARRANGE.Ptr, lpchrg, UInt32, reco, IDataObject.Ptr, lplpdataobj)
    GetDragDropEffect(fDrag, grfKeyState, pdwEffect)
      => ComCall(11, this.p, BOOL, fDrag, MODIFIERKEYS_FLAGS, grfKeyState, DROPEFFECT.Ptr, pdwEffect)
    GetContextMenu(seltype, lpoleobj, lpchrg, lphmenu)
      => ComCall(12, this.p, RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE, seltype, IOleObject, lpoleobj, CHARRANGE.Ptr, lpchrg, HMENU.Ptr, lphmenu)
}
struct tomConstants extends Int32 {
    static tomFalse := 0
    static tomTrue := -1
    static tomUndefined := -9999999
    static tomToggle := -9999998
    static tomAutoColor := -9999997
    static tomDefault := -9999996
    static tomSuspend := -9999995
    static tomResume := -9999994
    static tomApplyNow := 0
    static tomApplyLater := 1
    static tomTrackParms := 2
    static tomCacheParms := 3
    static tomApplyTmp := 4
    static tomDisableSmartFont := 8
    static tomEnableSmartFont := 9
    static tomUsePoints := 10
    static tomUseTwips := 11
    static tomBackward := -1073741823
    static tomForward := 1073741823
    static tomMove := 0
    static tomExtend := 1
    static tomNoSelection := 0
    static tomSelectionIP := 1
    static tomSelectionNormal := 2
    static tomSelectionFrame := 3
    static tomSelectionColumn := 4
    static tomSelectionRow := 5
    static tomSelectionBlock := 6
    static tomSelectionInlineShape := 7
    static tomSelectionShape := 8
    static tomSelStartActive := 1
    static tomSelAtEOL := 2
    static tomSelOvertype := 4
    static tomSelActive := 8
    static tomSelReplace := 16
    static tomEnd := 0
    static tomStart := 32
    static tomCollapseEnd := 0
    static tomCollapseStart := 1
    static tomClientCoord := 256
    static tomAllowOffClient := 512
    static tomTransform := 1024
    static tomObjectArg := 2048
    static tomAtEnd := 4096
    static tomNone := 0
    static tomSingle := 1
    static tomWords := 2
    static tomDouble := 3
    static tomDotted := 4
    static tomDash := 5
    static tomDashDot := 6
    static tomDashDotDot := 7
    static tomWave := 8
    static tomThick := 9
    static tomHair := 10
    static tomDoubleWave := 11
    static tomHeavyWave := 12
    static tomLongDash := 13
    static tomThickDash := 14
    static tomThickDashDot := 15
    static tomThickDashDotDot := 16
    static tomThickDotted := 17
    static tomThickLongDash := 18
    static tomLineSpaceSingle := 0
    static tomLineSpace1pt5 := 1
    static tomLineSpaceDouble := 2
    static tomLineSpaceAtLeast := 3
    static tomLineSpaceExactly := 4
    static tomLineSpaceMultiple := 5
    static tomLineSpacePercent := 6
    static tomAlignLeft := 0
    static tomAlignCenter := 1
    static tomAlignRight := 2
    static tomAlignJustify := 3
    static tomAlignDecimal := 3
    static tomAlignBar := 4
    static tomDefaultTab := 5
    static tomAlignInterWord := 3
    static tomAlignNewspaper := 4
    static tomAlignInterLetter := 5
    static tomAlignScaled := 6
    static tomSpaces := 0
    static tomDots := 1
    static tomDashes := 2
    static tomLines := 3
    static tomThickLines := 4
    static tomEquals := 5
    static tomTabBack := -3
    static tomTabNext := -2
    static tomTabHere := -1
    static tomListNone := 0
    static tomListBullet := 1
    static tomListNumberAsArabic := 2
    static tomListNumberAsLCLetter := 3
    static tomListNumberAsUCLetter := 4
    static tomListNumberAsLCRoman := 5
    static tomListNumberAsUCRoman := 6
    static tomListNumberAsSequence := 7
    static tomListNumberedCircle := 8
    static tomListNumberedBlackCircleWingding := 9
    static tomListNumberedWhiteCircleWingding := 10
    static tomListNumberedArabicWide := 11
    static tomListNumberedChS := 12
    static tomListNumberedChT := 13
    static tomListNumberedJpnChS := 14
    static tomListNumberedJpnKor := 15
    static tomListNumberedArabic1 := 16
    static tomListNumberedArabic2 := 17
    static tomListNumberedHebrew := 18
    static tomListNumberedThaiAlpha := 19
    static tomListNumberedThaiNum := 20
    static tomListNumberedHindiAlpha := 21
    static tomListNumberedHindiAlpha1 := 22
    static tomListNumberedHindiNum := 23
    static tomListParentheses := 65536
    static tomListPeriod := 131072
    static tomListPlain := 196608
    static tomListNoNumber := 262144
    static tomListMinus := 524288
    static tomIgnoreNumberStyle := 16777216
    static tomParaStyleNormal := -1
    static tomParaStyleHeading1 := -2
    static tomParaStyleHeading2 := -3
    static tomParaStyleHeading3 := -4
    static tomParaStyleHeading4 := -5
    static tomParaStyleHeading5 := -6
    static tomParaStyleHeading6 := -7
    static tomParaStyleHeading7 := -8
    static tomParaStyleHeading8 := -9
    static tomParaStyleHeading9 := -10
    static tomCharacter := 1
    static tomWord := 2
    static tomSentence := 3
    static tomParagraph := 4
    static tomLine := 5
    static tomStory := 6
    static tomScreen := 7
    static tomSection := 8
    static tomTableColumn := 9
    static tomColumn := 9
    static tomRow := 10
    static tomWindow := 11
    static tomCell := 12
    static tomCharFormat := 13
    static tomParaFormat := 14
    static tomTable := 15
    static tomObject := 16
    static tomPage := 17
    static tomHardParagraph := 18
    static tomCluster := 19
    static tomInlineObject := 20
    static tomInlineObjectArg := 21
    static tomLeafLine := 22
    static tomLayoutColumn := 23
    static tomProcessId := 1073741825
    static tomMatchWord := 2
    static tomMatchCase := 4
    static tomMatchPattern := 8
    static tomUnknownStory := 0
    static tomMainTextStory := 1
    static tomFootnotesStory := 2
    static tomEndnotesStory := 3
    static tomCommentsStory := 4
    static tomTextFrameStory := 5
    static tomEvenPagesHeaderStory := 6
    static tomPrimaryHeaderStory := 7
    static tomEvenPagesFooterStory := 8
    static tomPrimaryFooterStory := 9
    static tomFirstPageHeaderStory := 10
    static tomFirstPageFooterStory := 11
    static tomScratchStory := 127
    static tomFindStory := 128
    static tomReplaceStory := 129
    static tomStoryInactive := 0
    static tomStoryActiveDisplay := 1
    static tomStoryActiveUI := 2
    static tomStoryActiveDisplayUI := 3
    static tomNoAnimation := 0
    static tomLasVegasLights := 1
    static tomBlinkingBackground := 2
    static tomSparkleText := 3
    static tomMarchingBlackAnts := 4
    static tomMarchingRedAnts := 5
    static tomShimmer := 6
    static tomWipeDown := 7
    static tomWipeRight := 8
    static tomAnimationMax := 8
    static tomLowerCase := 0
    static tomUpperCase := 1
    static tomTitleCase := 2
    static tomSentenceCase := 4
    static tomToggleCase := 5
    static tomReadOnly := 256
    static tomShareDenyRead := 512
    static tomShareDenyWrite := 1024
    static tomPasteFile := 4096
    static tomCreateNew := 16
    static tomCreateAlways := 32
    static tomOpenExisting := 48
    static tomOpenAlways := 64
    static tomTruncateExisting := 80
    static tomRTF := 1
    static tomText := 2
    static tomHTML := 3
    static tomWordDocument := 4
    static tomBold := -2147483647
    static tomItalic := -2147483646
    static tomUnderline := -2147483644
    static tomStrikeout := -2147483640
    static tomProtected := -2147483632
    static tomLink := -2147483616
    static tomSmallCaps := -2147483584
    static tomAllCaps := -2147483520
    static tomHidden := -2147483392
    static tomOutline := -2147483136
    static tomShadow := -2147482624
    static tomEmboss := -2147481600
    static tomImprint := -2147479552
    static tomDisabled := -2147475456
    static tomRevised := -2147467264
    static tomSubscriptCF := -2147418112
    static tomSuperscriptCF := -2147352576
    static tomFontBound := -2146435072
    static tomLinkProtected := -2139095040
    static tomInlineObjectStart := -2130706432
    static tomExtendedChar := -2113929216
    static tomAutoBackColor := -2080374784
    static tomMathZoneNoBuildUp := -2013265920
    static tomMathZone := -1879048192
    static tomMathZoneOrdinary := -1610612736
    static tomAutoTextColor := -1073741824
    static tomMathZoneDisplay := 262144
    static tomParaEffectRTL := 1
    static tomParaEffectKeep := 2
    static tomParaEffectKeepNext := 4
    static tomParaEffectPageBreakBefore := 8
    static tomParaEffectNoLineNumber := 16
    static tomParaEffectNoWidowControl := 32
    static tomParaEffectDoNotHyphen := 64
    static tomParaEffectSideBySide := 128
    static tomParaEffectCollapsed := 256
    static tomParaEffectOutlineLevel := 512
    static tomParaEffectBox := 1024
    static tomParaEffectTableRowDelimiter := 4096
    static tomParaEffectTable := 16384
    static tomModWidthPairs := 1
    static tomModWidthSpace := 2
    static tomAutoSpaceAlpha := 4
    static tomAutoSpaceNumeric := 8
    static tomAutoSpaceParens := 16
    static tomEmbeddedFont := 32
    static tomDoublestrike := 64
    static tomOverlapping := 128
    static tomNormalCaret := 0
    static tomKoreanBlockCaret := 1
    static tomNullCaret := 2
    static tomIncludeInset := 1
    static tomUnicodeBiDi := 1
    static tomMathCFCheck := 4
    static tomUnlink := 8
    static tomUnhide := 16
    static tomCheckTextLimit := 32
    static tomIgnoreCurrentFont := 0
    static tomMatchCharRep := 1
    static tomMatchFontSignature := 2
    static tomMatchAscii := 4
    static tomGetHeightOnly := 8
    static tomMatchMathFont := 16
    static tomCharset := -2147483648
    static tomCharRepFromLcid := 1073741824
    static tomAnsi := 0
    static tomEastEurope := 1
    static tomCyrillic := 2
    static tomGreek := 3
    static tomTurkish := 4
    static tomHebrew := 5
    static tomArabic := 6
    static tomBaltic := 7
    static tomVietnamese := 8
    static tomDefaultCharRep := 9
    static tomSymbol := 10
    static tomThai := 11
    static tomShiftJIS := 12
    static tomGB2312 := 13
    static tomHangul := 14
    static tomBIG5 := 15
    static tomPC437 := 16
    static tomOEM := 17
    static tomMac := 18
    static tomArmenian := 19
    static tomSyriac := 20
    static tomThaana := 21
    static tomDevanagari := 22
    static tomBengali := 23
    static tomGurmukhi := 24
    static tomGujarati := 25
    static tomOriya := 26
    static tomTamil := 27
    static tomTelugu := 28
    static tomKannada := 29
    static tomMalayalam := 30
    static tomSinhala := 31
    static tomLao := 32
    static tomTibetan := 33
    static tomMyanmar := 34
    static tomGeorgian := 35
    static tomJamo := 36
    static tomEthiopic := 37
    static tomCherokee := 38
    static tomAboriginal := 39
    static tomOgham := 40
    static tomRunic := 41
    static tomKhmer := 42
    static tomMongolian := 43
    static tomBraille := 44
    static tomYi := 45
    static tomLimbu := 46
    static tomTaiLe := 47
    static tomNewTaiLue := 48
    static tomSylotiNagri := 49
    static tomKharoshthi := 50
    static tomKayahli := 51
    static tomUsymbol := 52
    static tomEmoji := 53
    static tomGlagolitic := 54
    static tomLisu := 55
    static tomVai := 56
    static tomNKo := 57
    static tomOsmanya := 58
    static tomPhagsPa := 59
    static tomGothic := 60
    static tomDeseret := 61
    static tomTifinagh := 62
    static tomCharRepMax := 63
    static tomRE10Mode := 1
    static tomUseAtFont := 2
    static tomTextFlowMask := 12
    static tomTextFlowES := 0
    static tomTextFlowSW := 4
    static tomTextFlowWN := 8
    static tomTextFlowNE := 12
    static tomNoIME := 524288
    static tomSelfIME := 262144
    static tomNoUpScroll := 65536
    static tomNoVpScroll := 262144
    static tomNoLink := 0
    static tomClientLink := 1
    static tomFriendlyLinkName := 2
    static tomFriendlyLinkAddress := 3
    static tomAutoLinkURL := 4
    static tomAutoLinkEmail := 5
    static tomAutoLinkPhone := 6
    static tomAutoLinkPath := 7
    static tomCompressNone := 0
    static tomCompressPunctuation := 1
    static tomCompressPunctuationAndKana := 2
    static tomCompressMax := 2
    static tomUnderlinePositionAuto := 0
    static tomUnderlinePositionBelow := 1
    static tomUnderlinePositionAbove := 2
    static tomUnderlinePositionMax := 2
    static tomFontAlignmentAuto := 0
    static tomFontAlignmentTop := 1
    static tomFontAlignmentBaseline := 2
    static tomFontAlignmentBottom := 3
    static tomFontAlignmentCenter := 4
    static tomFontAlignmentMax := 4
    static tomRubyBelow := 128
    static tomRubyAlignCenter := 0
    static tomRubyAlign010 := 1
    static tomRubyAlign121 := 2
    static tomRubyAlignLeft := 3
    static tomRubyAlignRight := 4
    static tomLimitsDefault := 0
    static tomLimitsUnderOver := 1
    static tomLimitsSubSup := 2
    static tomUpperLimitAsSuperScript := 3
    static tomLimitsOpposite := 4
    static tomShowLLimPlaceHldr := 8
    static tomShowULimPlaceHldr := 16
    static tomDontGrowWithContent := 64
    static tomGrowWithContent := 128
    static tomSubSupAlign := 1
    static tomLimitAlignMask := 3
    static tomLimitAlignCenter := 0
    static tomLimitAlignLeft := 1
    static tomLimitAlignRight := 2
    static tomShowDegPlaceHldr := 8
    static tomAlignDefault := 0
    static tomAlignMatchAscentDescent := 2
    static tomMathVariant := 32
    static tomStyleDefault := 0
    static tomStyleScriptScriptCramped := 1
    static tomStyleScriptScript := 2
    static tomStyleScriptCramped := 3
    static tomStyleScript := 4
    static tomStyleTextCramped := 5
    static tomStyleText := 6
    static tomStyleDisplayCramped := 7
    static tomStyleDisplay := 8
    static tomMathRelSize := 64
    static tomDecDecSize := 254
    static tomDecSize := 255
    static tomIncSize := 65
    static tomIncIncSize := 66
    static tomGravityUI := 0
    static tomGravityBack := 1
    static tomGravityFore := 2
    static tomGravityIn := 3
    static tomGravityOut := 4
    static tomGravityBackward := 536870912
    static tomGravityForward := 1073741824
    static tomAdjustCRLF := 1
    static tomUseCRLF := 2
    static tomTextize := 4
    static tomAllowFinalEOP := 8
    static tomFoldMathAlpha := 16
    static tomNoHidden := 32
    static tomIncludeNumbering := 64
    static tomTranslateTableCell := 128
    static tomNoMathZoneBrackets := 256
    static tomConvertMathChar := 512
    static tomNoUCGreekItalic := 1024
    static tomAllowMathBold := 2048
    static tomLanguageTag := 4096
    static tomConvertRTF := 8192
    static tomApplyRtfDocProps := 16384
    static tomPhantomShow := 1
    static tomPhantomZeroWidth := 2
    static tomPhantomZeroAscent := 4
    static tomPhantomZeroDescent := 8
    static tomPhantomTransparent := 16
    static tomPhantomASmash := 5
    static tomPhantomDSmash := 9
    static tomPhantomHSmash := 3
    static tomPhantomSmash := 13
    static tomPhantomHorz := 12
    static tomPhantomVert := 2
    static tomBoxHideTop := 1
    static tomBoxHideBottom := 2
    static tomBoxHideLeft := 4
    static tomBoxHideRight := 8
    static tomBoxStrikeH := 16
    static tomBoxStrikeV := 32
    static tomBoxStrikeTLBR := 64
    static tomBoxStrikeBLTR := 128
    static tomBoxAlignCenter := 1
    static tomSpaceMask := 28
    static tomSpaceDefault := 0
    static tomSpaceUnary := 4
    static tomSpaceBinary := 8
    static tomSpaceRelational := 12
    static tomSpaceSkip := 16
    static tomSpaceOrd := 20
    static tomSpaceDifferential := 24
    static tomSizeText := 32
    static tomSizeScript := 64
    static tomSizeScriptScript := 96
    static tomNoBreak := 128
    static tomTransparentForPositioning := 256
    static tomTransparentForSpacing := 512
    static tomStretchCharBelow := 0
    static tomStretchCharAbove := 1
    static tomStretchBaseBelow := 2
    static tomStretchBaseAbove := 3
    static tomMatrixAlignMask := 3
    static tomMatrixAlignCenter := 0
    static tomMatrixAlignTopRow := 1
    static tomMatrixAlignBottomRow := 3
    static tomShowMatPlaceHldr := 8
    static tomEqArrayLayoutWidth := 1
    static tomEqArrayAlignMask := 12
    static tomEqArrayAlignCenter := 0
    static tomEqArrayAlignTopRow := 4
    static tomEqArrayAlignBottomRow := 12
    static tomMathManualBreakMask := 127
    static tomMathBreakLeft := 125
    static tomMathBreakCenter := 126
    static tomMathBreakRight := 127
    static tomMathEqAlign := 128
    static tomMathArgShadingStart := 593
    static tomMathArgShadingEnd := 594
    static tomMathObjShadingStart := 595
    static tomMathObjShadingEnd := 596
    static tomFunctionTypeNone := 0
    static tomFunctionTypeTakesArg := 1
    static tomFunctionTypeTakesLim := 2
    static tomFunctionTypeTakesLim2 := 3
    static tomFunctionTypeIsLim := 4
    static tomMathParaAlignDefault := 0
    static tomMathParaAlignCenterGroup := 1
    static tomMathParaAlignCenter := 2
    static tomMathParaAlignLeft := 3
    static tomMathParaAlignRight := 4
    static tomMathDispAlignMask := 3
    static tomMathDispAlignCenterGroup := 0
    static tomMathDispAlignCenter := 1
    static tomMathDispAlignLeft := 2
    static tomMathDispAlignRight := 3
    static tomMathDispIntUnderOver := 4
    static tomMathDispFracTeX := 8
    static tomMathDispNaryGrow := 16
    static tomMathDocEmptyArgMask := 96
    static tomMathDocEmptyArgAuto := 0
    static tomMathDocEmptyArgAlways := 32
    static tomMathDocEmptyArgNever := 64
    static tomMathDocSbSpOpUnchanged := 128
    static tomMathDocDiffMask := 768
    static tomMathDocDiffDefault := 0
    static tomMathDocDiffUpright := 256
    static tomMathDocDiffItalic := 512
    static tomMathDocDiffOpenItalic := 768
    static tomMathDispNarySubSup := 1024
    static tomMathDispDef := 2048
    static tomMathEnableRtl := 4096
    static tomMathBrkBinMask := 196608
    static tomMathBrkBinBefore := 0
    static tomMathBrkBinAfter := 65536
    static tomMathBrkBinDup := 131072
    static tomMathBrkBinSubMask := 786432
    static tomMathBrkBinSubMM := 0
    static tomMathBrkBinSubPM := 262144
    static tomMathBrkBinSubMP := 524288
    static tomSelRange := 597
    static tomHstring := 596
    static tomFontPropTeXStyle := 828
    static tomFontPropAlign := 829
    static tomFontStretch := 830
    static tomFontStyle := 831
    static tomFontStyleUpright := 0
    static tomFontStyleOblique := 1
    static tomFontStyleItalic := 2
    static tomFontStretchDefault := 0
    static tomFontStretchUltraCondensed := 1
    static tomFontStretchExtraCondensed := 2
    static tomFontStretchCondensed := 3
    static tomFontStretchSemiCondensed := 4
    static tomFontStretchNormal := 5
    static tomFontStretchSemiExpanded := 6
    static tomFontStretchExpanded := 7
    static tomFontStretchExtraExpanded := 8
    static tomFontStretchUltraExpanded := 9
    static tomFontWeightDefault := 0
    static tomFontWeightThin := 100
    static tomFontWeightExtraLight := 200
    static tomFontWeightLight := 300
    static tomFontWeightNormal := 400
    static tomFontWeightRegular := 400
    static tomFontWeightMedium := 500
    static tomFontWeightSemiBold := 600
    static tomFontWeightBold := 700
    static tomFontWeightExtraBold := 800
    static tomFontWeightBlack := 900
    static tomFontWeightHeavy := 900
    static tomFontWeightExtraBlack := 950
    static tomParaPropMathAlign := 1079
    static tomDocMathBuild := 128
    static tomMathLMargin := 129
    static tomMathRMargin := 130
    static tomMathWrapIndent := 131
    static tomMathWrapRight := 132
    static tomMathPostSpace := 134
    static tomMathPreSpace := 133
    static tomMathInterSpace := 135
    static tomMathIntraSpace := 136
    static tomCanCopy := 137
    static tomCanRedo := 138
    static tomCanUndo := 139
    static tomUndoLimit := 140
    static tomDocAutoLink := 141
    static tomEllipsisMode := 142
    static tomEllipsisState := 143
    static tomEllipsisNone := 0
    static tomEllipsisEnd := 1
    static tomEllipsisWord := 3
    static tomEllipsisPresent := 1
    static tomVTopCell := 1
    static tomVLowCell := 2
    static tomHStartCell := 4
    static tomHContCell := 8
    static tomRowUpdate := 1
    static tomRowApplyDefault := 0
    static tomCellStructureChangeOnly := 1
    static tomRowHeightActual := 2059
}
struct OBJECTTYPE extends Int32 {
    static tomSimpleText := 0
    static tomRuby := 1
    static tomHorzVert := 2
    static tomWarichu := 3
    static tomEq := 9
    static tomMath := 10
    static tomAccent := 10
    static tomBox := 11
    static tomBoxedFormula := 12
    static tomBrackets := 13
    static tomBracketsWithSeps := 14
    static tomEquationArray := 15
    static tomFraction := 16
    static tomFunctionApply := 17
    static tomLeftSubSup := 18
    static tomLowerLimit := 19
    static tomMatrix := 20
    static tomNary := 21
    static tomOpChar := 22
    static tomOverbar := 23
    static tomPhantom := 24
    static tomRadical := 25
    static tomSlashedFraction := 26
    static tomStack := 27
    static tomStretchStack := 28
    static tomSubscript := 29
    static tomSubSup := 30
    static tomSuperscript := 31
    static tomUnderbar := 32
    static tomUpperLimit := 33
    static tomObjectMax := 33
}
struct MANCODE extends Int32 {
    static MBOLD := 16
    static MITAL := 32
    static MGREEK := 64
    static MROMN := 0
    static MSCRP := 1
    static MFRAK := 2
    static MOPEN := 3
    static MSANS := 4
    static MMONO := 5
    static MMATH := 6
    static MISOL := 7
    static MINIT := 8
    static MTAIL := 9
    static MSTRCH := 10
    static MLOOP := 11
    static MOPENA := 12
}
struct ITextDocument extends IDispatch {
    static IID := "{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}"
    GetName(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    GetSelection(ppSel)
      => ComCall(8, this.p, ITextSelection.Ptr, ppSel)
    GetStoryCount(pCount)
      => ComCall(9, this.p, Int32.Ptr, pCount)
    GetStoryRanges(ppStories)
      => ComCall(10, this.p, ITextStoryRanges.Ptr, ppStories)
    GetSaved(pValue)
      => ComCall(11, this.p, Int32.Ptr, pValue)
    SetSaved(Value)
      => ComCall(12, this.p, tomConstants, Value)
    GetDefaultTabStop(pValue)
      => ComCall(13, this.p, Float32.Ptr, pValue)
    SetDefaultTabStop(Value)
      => ComCall(14, this.p, Float32, Value)
    New()
      => ComCall(15, this.p)
    Open(pVar, Flags, CodePage)
      => ComCall(16, this.p, VARIANT.Ptr, pVar, tomConstants, Flags, Int32, CodePage)
    Save(pVar, Flags, CodePage)
      => ComCall(17, this.p, VARIANT.Ptr, pVar, tomConstants, Flags, Int32, CodePage)
    Freeze(pCount)
      => ComCall(18, this.p, Int32.Ptr, pCount)
    Unfreeze(pCount)
      => ComCall(19, this.p, Int32.Ptr, pCount)
    BeginEditCollection()
      => ComCall(20, this.p)
    EndEditCollection()
      => ComCall(21, this.p)
    Undo(Count, pCount)
      => ComCall(22, this.p, Int32, Count, Int32.Ptr, pCount)
    Redo(Count, pCount)
      => ComCall(23, this.p, Int32, Count, Int32.Ptr, pCount)
    Range(cpActive, cpAnchor, ppRange)
      => ComCall(24, this.p, Int32, cpActive, Int32, cpAnchor, ITextRange.Ptr, ppRange)
    RangeFromPoint(x, y, ppRange)
      => ComCall(25, this.p, Int32, x, Int32, y, ITextRange.Ptr, ppRange)
}
struct ITextRange extends IDispatch {
    static IID := "{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}"
    GetText(pbstr)
      => ComCall(7, this.p, BSTR.Ptr, pbstr)
    SetText(bstr1)
      => ComCall(8, this.p, BSTR, bstr1)
    GetChar(pChar)
      => ComCall(9, this.p, Int32.Ptr, pChar)
    SetChar(Char)
      => ComCall(10, this.p, Int32, Char)
    GetDuplicate(ppRange)
      => ComCall(11, this.p, ITextRange.Ptr, ppRange)
    GetFormattedText(ppRange)
      => ComCall(12, this.p, ITextRange.Ptr, ppRange)
    SetFormattedText(pRange?)
      => ComCall(13, this.p, ITextRange, pRange?)
    GetStart(pcpFirst)
      => ComCall(14, this.p, Int32.Ptr, pcpFirst)
    SetStart(cpFirst)
      => ComCall(15, this.p, Int32, cpFirst)
    GetEnd(pcpLim)
      => ComCall(16, this.p, Int32.Ptr, pcpLim)
    SetEnd(cpLim)
      => ComCall(17, this.p, Int32, cpLim)
    GetFont(ppFont)
      => ComCall(18, this.p, ITextFont.Ptr, ppFont)
    SetFont(pFont?)
      => ComCall(19, this.p, ITextFont, pFont?)
    GetPara(ppPara)
      => ComCall(20, this.p, ITextPara.Ptr, ppPara)
    SetPara(pPara?)
      => ComCall(21, this.p, ITextPara, pPara?)
    GetStoryLength(pCount)
      => ComCall(22, this.p, Int32.Ptr, pCount)
    GetStoryType(pValue)
      => ComCall(23, this.p, Int32.Ptr, pValue)
    Collapse(bStart)
      => ComCall(24, this.p, Int32, bStart)
    Expand(Unit, pDelta)
      => ComCall(25, this.p, Int32, Unit, Int32.Ptr, pDelta)
    GetIndex(Unit, pIndex)
      => ComCall(26, this.p, Int32, Unit, Int32.Ptr, pIndex)
    SetIndex(Unit, Index, Extend)
      => ComCall(27, this.p, Int32, Unit, Int32, Index, Int32, Extend)
    SetRange(cpAnchor, cpActive)
      => ComCall(28, this.p, Int32, cpAnchor, Int32, cpActive)
    InRange(pRange?, pValue)
      => ComCall(29, this.p, ITextRange, pRange?, Int32.Ptr, pValue)
    InStory(pRange?, pValue)
      => ComCall(30, this.p, ITextRange, pRange?, Int32.Ptr, pValue)
    IsEqual(pRange?, pValue)
      => ComCall(31, this.p, ITextRange, pRange?, Int32.Ptr, pValue)
    Select()
      => ComCall(32, this.p)
    StartOf(Unit, Extend, pDelta)
      => ComCall(33, this.p, Int32, Unit, Int32, Extend, Int32.Ptr, pDelta)
    EndOf(Unit, Extend, pDelta)
      => ComCall(34, this.p, Int32, Unit, Int32, Extend, Int32.Ptr, pDelta)
    Move(Unit, Count, pDelta)
      => ComCall(35, this.p, Int32, Unit, Int32, Count, Int32.Ptr, pDelta)
    MoveStart(Unit, Count, pDelta)
      => ComCall(36, this.p, Int32, Unit, Int32, Count, Int32.Ptr, pDelta)
    MoveEnd(Unit, Count, pDelta)
      => ComCall(37, this.p, Int32, Unit, Int32, Count, Int32.Ptr, pDelta)
    MoveWhile(Cset, Count, pDelta)
      => ComCall(38, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    MoveStartWhile(Cset, Count, pDelta)
      => ComCall(39, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    MoveEndWhile(Cset, Count, pDelta)
      => ComCall(40, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    MoveUntil(Cset, Count, pDelta)
      => ComCall(41, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    MoveStartUntil(Cset, Count, pDelta)
      => ComCall(42, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    MoveEndUntil(Cset, Count, pDelta)
      => ComCall(43, this.p, VARIANT.Ptr, Cset, Int32, Count, Int32.Ptr, pDelta)
    FindText(bstr1, Count, Flags, pLength)
      => ComCall(44, this.p, BSTR, bstr1, Int32, Count, tomConstants, Flags, Int32.Ptr, pLength)
    FindTextStart(bstr1, Count, Flags, pLength)
      => ComCall(45, this.p, BSTR, bstr1, Int32, Count, tomConstants, Flags, Int32.Ptr, pLength)
    FindTextEnd(bstr1, Count, Flags, pLength)
      => ComCall(46, this.p, BSTR, bstr1, Int32, Count, tomConstants, Flags, Int32.Ptr, pLength)
    Delete(Unit, Count, pDelta)
      => ComCall(47, this.p, Int32, Unit, Int32, Count, Int32.Ptr, pDelta)
    Cut(pVar)
      => ComCall(48, this.p, VARIANT.Ptr, pVar)
    Copy(pVar)
      => ComCall(49, this.p, VARIANT.Ptr, pVar)
    Paste(pVar, Format)
      => ComCall(50, this.p, VARIANT.Ptr, pVar, Int32, Format)
    CanPaste(pVar, Format, pValue)
      => ComCall(51, this.p, VARIANT.Ptr, pVar, Int32, Format, Int32.Ptr, pValue)
    CanEdit(pValue)
      => ComCall(52, this.p, Int32.Ptr, pValue)
    ChangeCase(Type)
      => ComCall(53, this.p, tomConstants, Type)
    GetPoint(Type, px, py)
      => ComCall(54, this.p, tomConstants, Type, Int32.Ptr, px, Int32.Ptr, py)
    SetPoint(x, y, Type, Extend)
      => ComCall(55, this.p, Int32, x, Int32, y, tomConstants, Type, Int32, Extend)
    ScrollIntoView(Value)
      => ComCall(56, this.p, Int32, Value)
    GetEmbeddedObject(ppObject)
      => ComCall(57, this.p, IUnknown.Ptr, ppObject)
}
struct ITextSelection extends ITextRange {
    static IID := "{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}"
    GetFlags(pFlags)
      => ComCall(58, this.p, Int32.Ptr, pFlags)
    SetFlags(Flags)
      => ComCall(59, this.p, Int32, Flags)
    GetType(pType)
      => ComCall(60, this.p, Int32.Ptr, pType)
    MoveLeft(Unit, Count, Extend, pDelta)
      => ComCall(61, this.p, Int32, Unit, Int32, Count, Int32, Extend, Int32.Ptr, pDelta)
    MoveRight(Unit, Count, Extend, pDelta)
      => ComCall(62, this.p, Int32, Unit, Int32, Count, Int32, Extend, Int32.Ptr, pDelta)
    MoveUp(Unit, Count, Extend, pDelta)
      => ComCall(63, this.p, Int32, Unit, Int32, Count, Int32, Extend, Int32.Ptr, pDelta)
    MoveDown(Unit, Count, Extend, pDelta)
      => ComCall(64, this.p, Int32, Unit, Int32, Count, Int32, Extend, Int32.Ptr, pDelta)
    HomeKey(Unit, Extend, pDelta)
      => ComCall(65, this.p, tomConstants, Unit, Int32, Extend, Int32.Ptr, pDelta)
    EndKey(Unit, Extend, pDelta)
      => ComCall(66, this.p, Int32, Unit, Int32, Extend, Int32.Ptr, pDelta)
    TypeText(bstr1)
      => ComCall(67, this.p, BSTR, bstr1)
}
struct ITextFont extends IDispatch {
    static IID := "{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}"
    GetDuplicate(ppFont)
      => ComCall(7, this.p, ITextFont.Ptr, ppFont)
    SetDuplicate(pFont?)
      => ComCall(8, this.p, ITextFont, pFont?)
    CanChange(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
    IsEqual(pFont?, pValue)
      => ComCall(10, this.p, ITextFont, pFont?, Int32.Ptr, pValue)
    Reset(Value)
      => ComCall(11, this.p, tomConstants, Value)
    GetStyle(pValue)
      => ComCall(12, this.p, Int32.Ptr, pValue)
    SetStyle(Value)
      => ComCall(13, this.p, Int32, Value)
    GetAllCaps(pValue)
      => ComCall(14, this.p, Int32.Ptr, pValue)
    SetAllCaps(Value)
      => ComCall(15, this.p, Int32, Value)
    GetAnimation(pValue)
      => ComCall(16, this.p, Int32.Ptr, pValue)
    SetAnimation(Value)
      => ComCall(17, this.p, Int32, Value)
    GetBackColor(pValue)
      => ComCall(18, this.p, Int32.Ptr, pValue)
    SetBackColor(Value)
      => ComCall(19, this.p, Int32, Value)
    GetBold(pValue)
      => ComCall(20, this.p, Int32.Ptr, pValue)
    SetBold(Value)
      => ComCall(21, this.p, Int32, Value)
    GetEmboss(pValue)
      => ComCall(22, this.p, Int32.Ptr, pValue)
    SetEmboss(Value)
      => ComCall(23, this.p, Int32, Value)
    GetForeColor(pValue)
      => ComCall(24, this.p, Int32.Ptr, pValue)
    SetForeColor(Value)
      => ComCall(25, this.p, Int32, Value)
    GetHidden(pValue)
      => ComCall(26, this.p, Int32.Ptr, pValue)
    SetHidden(Value)
      => ComCall(27, this.p, Int32, Value)
    GetEngrave(pValue)
      => ComCall(28, this.p, Int32.Ptr, pValue)
    SetEngrave(Value)
      => ComCall(29, this.p, Int32, Value)
    GetItalic(pValue)
      => ComCall(30, this.p, Int32.Ptr, pValue)
    SetItalic(Value)
      => ComCall(31, this.p, Int32, Value)
    GetKerning(pValue)
      => ComCall(32, this.p, Float32.Ptr, pValue)
    SetKerning(Value)
      => ComCall(33, this.p, Float32, Value)
    GetLanguageID(pValue)
      => ComCall(34, this.p, Int32.Ptr, pValue)
    SetLanguageID(Value)
      => ComCall(35, this.p, Int32, Value)
    GetName(pbstr)
      => ComCall(36, this.p, BSTR.Ptr, pbstr)
    SetName(bstr1)
      => ComCall(37, this.p, BSTR, bstr1)
    GetOutline(pValue)
      => ComCall(38, this.p, Int32.Ptr, pValue)
    SetOutline(Value)
      => ComCall(39, this.p, Int32, Value)
    GetPosition(pValue)
      => ComCall(40, this.p, Float32.Ptr, pValue)
    SetPosition(Value)
      => ComCall(41, this.p, Float32, Value)
    GetProtected(pValue)
      => ComCall(42, this.p, Int32.Ptr, pValue)
    SetProtected(Value)
      => ComCall(43, this.p, Int32, Value)
    GetShadow(pValue)
      => ComCall(44, this.p, Int32.Ptr, pValue)
    SetShadow(Value)
      => ComCall(45, this.p, Int32, Value)
    GetSize(pValue)
      => ComCall(46, this.p, Float32.Ptr, pValue)
    SetSize(Value)
      => ComCall(47, this.p, Float32, Value)
    GetSmallCaps(pValue)
      => ComCall(48, this.p, Int32.Ptr, pValue)
    SetSmallCaps(Value)
      => ComCall(49, this.p, Int32, Value)
    GetSpacing(pValue)
      => ComCall(50, this.p, Float32.Ptr, pValue)
    SetSpacing(Value)
      => ComCall(51, this.p, Float32, Value)
    GetStrikeThrough(pValue)
      => ComCall(52, this.p, Int32.Ptr, pValue)
    SetStrikeThrough(Value)
      => ComCall(53, this.p, Int32, Value)
    GetSubscript(pValue)
      => ComCall(54, this.p, Int32.Ptr, pValue)
    SetSubscript(Value)
      => ComCall(55, this.p, Int32, Value)
    GetSuperscript(pValue)
      => ComCall(56, this.p, Int32.Ptr, pValue)
    SetSuperscript(Value)
      => ComCall(57, this.p, Int32, Value)
    GetUnderline(pValue)
      => ComCall(58, this.p, Int32.Ptr, pValue)
    SetUnderline(Value)
      => ComCall(59, this.p, Int32, Value)
    GetWeight(pValue)
      => ComCall(60, this.p, Int32.Ptr, pValue)
    SetWeight(Value)
      => ComCall(61, this.p, Int32, Value)
}
struct ITextPara extends IDispatch {
    static IID := "{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}"
    GetDuplicate(ppPara)
      => ComCall(7, this.p, ITextPara.Ptr, ppPara)
    SetDuplicate(pPara?)
      => ComCall(8, this.p, ITextPara, pPara?)
    CanChange(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
    IsEqual(pPara?, pValue)
      => ComCall(10, this.p, ITextPara, pPara?, Int32.Ptr, pValue)
    Reset(Value)
      => ComCall(11, this.p, Int32, Value)
    GetStyle(pValue)
      => ComCall(12, this.p, Int32.Ptr, pValue)
    SetStyle(Value)
      => ComCall(13, this.p, Int32, Value)
    GetAlignment(pValue)
      => ComCall(14, this.p, Int32.Ptr, pValue)
    SetAlignment(Value)
      => ComCall(15, this.p, Int32, Value)
    GetHyphenation(pValue)
      => ComCall(16, this.p, tomConstants.Ptr, pValue)
    SetHyphenation(Value)
      => ComCall(17, this.p, Int32, Value)
    GetFirstLineIndent(pValue)
      => ComCall(18, this.p, Float32.Ptr, pValue)
    GetKeepTogether(pValue)
      => ComCall(19, this.p, tomConstants.Ptr, pValue)
    SetKeepTogether(Value)
      => ComCall(20, this.p, Int32, Value)
    GetKeepWithNext(pValue)
      => ComCall(21, this.p, tomConstants.Ptr, pValue)
    SetKeepWithNext(Value)
      => ComCall(22, this.p, Int32, Value)
    GetLeftIndent(pValue)
      => ComCall(23, this.p, Float32.Ptr, pValue)
    GetLineSpacing(pValue)
      => ComCall(24, this.p, Float32.Ptr, pValue)
    GetLineSpacingRule(pValue)
      => ComCall(25, this.p, Int32.Ptr, pValue)
    GetListAlignment(pValue)
      => ComCall(26, this.p, Int32.Ptr, pValue)
    SetListAlignment(Value)
      => ComCall(27, this.p, Int32, Value)
    GetListLevelIndex(pValue)
      => ComCall(28, this.p, Int32.Ptr, pValue)
    SetListLevelIndex(Value)
      => ComCall(29, this.p, Int32, Value)
    GetListStart(pValue)
      => ComCall(30, this.p, Int32.Ptr, pValue)
    SetListStart(Value)
      => ComCall(31, this.p, Int32, Value)
    GetListTab(pValue)
      => ComCall(32, this.p, Float32.Ptr, pValue)
    SetListTab(Value)
      => ComCall(33, this.p, Float32, Value)
    GetListType(pValue)
      => ComCall(34, this.p, Int32.Ptr, pValue)
    SetListType(Value)
      => ComCall(35, this.p, Int32, Value)
    GetNoLineNumber(pValue)
      => ComCall(36, this.p, Int32.Ptr, pValue)
    SetNoLineNumber(Value)
      => ComCall(37, this.p, Int32, Value)
    GetPageBreakBefore(pValue)
      => ComCall(38, this.p, Int32.Ptr, pValue)
    SetPageBreakBefore(Value)
      => ComCall(39, this.p, Int32, Value)
    GetRightIndent(pValue)
      => ComCall(40, this.p, Float32.Ptr, pValue)
    SetRightIndent(Value)
      => ComCall(41, this.p, Float32, Value)
    SetIndents(First, Left, Right)
      => ComCall(42, this.p, Float32, First, Float32, Left, Float32, Right)
    SetLineSpacing(Rule, Spacing)
      => ComCall(43, this.p, Int32, Rule, Float32, Spacing)
    GetSpaceAfter(pValue)
      => ComCall(44, this.p, Float32.Ptr, pValue)
    SetSpaceAfter(Value)
      => ComCall(45, this.p, Float32, Value)
    GetSpaceBefore(pValue)
      => ComCall(46, this.p, Float32.Ptr, pValue)
    SetSpaceBefore(Value)
      => ComCall(47, this.p, Float32, Value)
    GetWidowControl(pValue)
      => ComCall(48, this.p, Int32.Ptr, pValue)
    SetWidowControl(Value)
      => ComCall(49, this.p, Int32, Value)
    GetTabCount(pCount)
      => ComCall(50, this.p, Int32.Ptr, pCount)
    AddTab(tbPos, tbAlign, tbLeader)
      => ComCall(51, this.p, Float32, tbPos, Int32, tbAlign, Int32, tbLeader)
    ClearAllTabs()
      => ComCall(52, this.p)
    DeleteTab(tbPos)
      => ComCall(53, this.p, Float32, tbPos)
    GetTab(iTab, ptbPos, ptbAlign, ptbLeader)
      => ComCall(54, this.p, Int32, iTab, Float32.Ptr, ptbPos, Int32.Ptr, ptbAlign, Int32.Ptr, ptbLeader)
}
struct ITextStoryRanges extends IDispatch {
    static IID := "{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}"
    _NewEnum(ppunkEnum)
      => ComCall(7, this.p, IUnknown.Ptr, ppunkEnum)
    Item(Index, ppRange)
      => ComCall(8, this.p, Int32, Index, ITextRange.Ptr, ppRange)
    GetCount(pCount)
      => ComCall(9, this.p, Int32.Ptr, pCount)
}
struct ITextDocument2 extends ITextDocument {
    static IID := "{C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetCaretType(pValue)
      => ComCall(26, this.p, Int32.Ptr, pValue)
    SetCaretType(Value)
      => ComCall(27, this.p, Int32, Value)
    GetDisplays(ppDisplays)
      => ComCall(28, this.p, ITextDisplays.Ptr, ppDisplays)
    GetDocumentFont(ppFont)
      => ComCall(29, this.p, ITextFont2.Ptr, ppFont)
    SetDocumentFont(pFont?)
      => ComCall(30, this.p, ITextFont2, pFont?)
    GetDocumentPara(ppPara)
      => ComCall(31, this.p, ITextPara2.Ptr, ppPara)
    SetDocumentPara(pPara?)
      => ComCall(32, this.p, ITextPara2, pPara?)
    GetEastAsianFlags(pFlags)
      => ComCall(33, this.p, tomConstants.Ptr, pFlags)
    GetGenerator(pbstr)
      => ComCall(34, this.p, BSTR.Ptr, pbstr)
    SetIMEInProgress(Value)
      => ComCall(35, this.p, Int32, Value)
    GetNotificationMode(pValue)
      => ComCall(36, this.p, Int32.Ptr, pValue)
    SetNotificationMode(Value)
      => ComCall(37, this.p, Int32, Value)
    GetSelection2(ppSel)
      => ComCall(38, this.p, ITextSelection2.Ptr, ppSel)
    GetStoryRanges2(ppStories)
      => ComCall(39, this.p, ITextStoryRanges2.Ptr, ppStories)
    GetTypographyOptions(pOptions)
      => ComCall(40, this.p, Int32.Ptr, pOptions)
    GetVersion(pValue)
      => ComCall(41, this.p, Int32.Ptr, pValue)
    GetWindow(pHwnd)
      => ComCall(42, this.p, Int64.Ptr, pHwnd)
    AttachMsgFilter(pFilter?)
      => ComCall(43, this.p, IUnknown, pFilter?)
    CheckTextLimit(cch, pcch)
      => ComCall(44, this.p, Int32, cch, Int32.Ptr, pcch)
    GetCallManager(ppVoid)
      => ComCall(45, this.p, IUnknown.Ptr, ppVoid)
    GetClientRect(Type, pLeft, pTop, pRight, pBottom)
      => ComCall(46, this.p, tomConstants, Type, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pRight, Int32.Ptr, pBottom)
    GetEffectColor(Index, pValue)
      => ComCall(47, this.p, Int32, Index, Int32.Ptr, pValue)
    GetImmContext(pContext)
      => ComCall(48, this.p, Int64.Ptr, pContext)
    GetPreferredFont(cp, CharRep, Options, curCharRep, curFontSize, pbstr, pPitchAndFamily, pNewFontSize)
      => ComCall(49, this.p, Int32, cp, Int32, CharRep, Int32, Options, Int32, curCharRep, Int32, curFontSize, BSTR.Ptr, pbstr, Int32.Ptr, pPitchAndFamily, Int32.Ptr, pNewFontSize)
    GetProperty(Type, pValue)
      => ComCall(50, this.p, Int32, Type, Int32.Ptr, pValue)
    GetStrings(ppStrs)
      => ComCall(51, this.p, ITextStrings.Ptr, ppStrs)
    Notify(Notify)
      => ComCall(52, this.p, Int32, Notify)
    Range2(cpActive, cpAnchor, ppRange)
      => ComCall(53, this.p, Int32, cpActive, Int32, cpAnchor, ITextRange2.Ptr, ppRange)
    RangeFromPoint2(x, y, Type, ppRange)
      => ComCall(54, this.p, Int32, x, Int32, y, Int32, Type, ITextRange2.Ptr, ppRange)
    ReleaseCallManager(pVoid?)
      => ComCall(55, this.p, IUnknown, pVoid?)
    ReleaseImmContext(Context)
      => ComCall(56, this.p, Int64, Context)
    SetEffectColor(Index, Value)
      => ComCall(57, this.p, Int32, Index, Int32, Value)
    SetProperty(Type, Value)
      => ComCall(58, this.p, Int32, Type, Int32, Value)
    SetTypographyOptions(Options, Mask)
      => ComCall(59, this.p, Int32, Options, Int32, Mask)
    SysBeep()
      => ComCall(60, this.p)
    Update(Value)
      => ComCall(61, this.p, Int32, Value)
    UpdateWindow()
      => ComCall(62, this.p)
    GetMathProperties(pOptions)
      => ComCall(63, this.p, Int32.Ptr, pOptions)
    SetMathProperties(Options, Mask)
      => ComCall(64, this.p, Int32, Options, Int32, Mask)
    GetActiveStory(ppStory)
      => ComCall(65, this.p, ITextStory.Ptr, ppStory)
    SetActiveStory(pStory?)
      => ComCall(66, this.p, ITextStory, pStory?)
    GetMainStory(ppStory)
      => ComCall(67, this.p, ITextStory.Ptr, ppStory)
    GetNewStory(ppStory)
      => ComCall(68, this.p, ITextStory.Ptr, ppStory)
    GetStory(Index, ppStory)
      => ComCall(69, this.p, Int32, Index, ITextStory.Ptr, ppStory)
}
struct ITextRange2 extends ITextSelection {
    static IID := "{C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetCch(pcch)
      => ComCall(68, this.p, Int32.Ptr, pcch)
    GetCells(ppCells)
      => ComCall(69, this.p, IUnknown.Ptr, ppCells)
    GetColumn(ppColumn)
      => ComCall(70, this.p, IUnknown.Ptr, ppColumn)
    GetCount(pCount)
      => ComCall(71, this.p, Int32.Ptr, pCount)
    GetDuplicate2(ppRange)
      => ComCall(72, this.p, ITextRange2.Ptr, ppRange)
    GetFont2(ppFont)
      => ComCall(73, this.p, ITextFont2.Ptr, ppFont)
    SetFont2(pFont?)
      => ComCall(74, this.p, ITextFont2, pFont?)
    GetFormattedText2(ppRange)
      => ComCall(75, this.p, ITextRange2.Ptr, ppRange)
    SetFormattedText2(pRange?)
      => ComCall(76, this.p, ITextRange2, pRange?)
    GetGravity(pValue)
      => ComCall(77, this.p, Int32.Ptr, pValue)
    SetGravity(Value)
      => ComCall(78, this.p, Int32, Value)
    GetPara2(ppPara)
      => ComCall(79, this.p, ITextPara2.Ptr, ppPara)
    SetPara2(pPara?)
      => ComCall(80, this.p, ITextPara2, pPara?)
    GetRow(ppRow)
      => ComCall(81, this.p, ITextRow.Ptr, ppRow)
    GetStartPara(pValue)
      => ComCall(82, this.p, Int32.Ptr, pValue)
    GetTable(ppTable)
      => ComCall(83, this.p, IUnknown.Ptr, ppTable)
    GetURL(pbstr)
      => ComCall(84, this.p, BSTR.Ptr, pbstr)
    SetURL(bstr1)
      => ComCall(85, this.p, BSTR, bstr1)
    AddSubrange(cp1, cp2, Activate)
      => ComCall(86, this.p, Int32, cp1, Int32, cp2, Int32, Activate)
    BuildUpMath(Flags)
      => ComCall(87, this.p, Int32, Flags)
    DeleteSubrange(cpFirst, cpLim)
      => ComCall(88, this.p, Int32, cpFirst, Int32, cpLim)
    Find(pRange?, Count, Flags, pDelta)
      => ComCall(89, this.p, ITextRange2, pRange?, Int32, Count, Int32, Flags, Int32.Ptr, pDelta)
    GetChar2(pChar, Offset)
      => ComCall(90, this.p, Int32.Ptr, pChar, Int32, Offset)
    GetDropCap(pcLine, pPosition)
      => ComCall(91, this.p, Int32.Ptr, pcLine, Int32.Ptr, pPosition)
    GetInlineObject(pType, pAlign, pChar, pChar1, pChar2, pCount, pTeXStyle, pcCol, pLevel)
      => ComCall(92, this.p, Int32.Ptr, pType, Int32.Ptr, pAlign, Int32.Ptr, pChar, Int32.Ptr, pChar1, Int32.Ptr, pChar2, Int32.Ptr, pCount, Int32.Ptr, pTeXStyle, Int32.Ptr, pcCol, Int32.Ptr, pLevel)
    GetProperty(Type, pValue)
      => ComCall(93, this.p, Int32, Type, Int32.Ptr, pValue)
    GetRect(Type, pLeft, pTop, pRight, pBottom, pHit)
      => ComCall(94, this.p, Int32, Type, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pRight, Int32.Ptr, pBottom, Int32.Ptr, pHit)
    GetSubrange(iSubrange, pcpFirst, pcpLim)
      => ComCall(95, this.p, Int32, iSubrange, Int32.Ptr, pcpFirst, Int32.Ptr, pcpLim)
    GetText2(Flags, pbstr)
      => ComCall(96, this.p, Int32, Flags, BSTR.Ptr, pbstr)
    HexToUnicode()
      => ComCall(97, this.p)
    InsertTable(cCol, cRow, AutoFit)
      => ComCall(98, this.p, Int32, cCol, Int32, cRow, Int32, AutoFit)
    Linearize(Flags)
      => ComCall(99, this.p, Int32, Flags)
    SetActiveSubrange(cpAnchor, cpActive)
      => ComCall(100, this.p, Int32, cpAnchor, Int32, cpActive)
    SetDropCap(cLine, Position)
      => ComCall(101, this.p, Int32, cLine, Int32, Position)
    SetProperty(Type, Value)
      => ComCall(102, this.p, Int32, Type, Int32, Value)
    SetText2(Flags, bstr1)
      => ComCall(103, this.p, Int32, Flags, BSTR, bstr1)
    UnicodeToHex()
      => ComCall(104, this.p)
    SetInlineObject(Type, Align, Char, Char1, Char2, Count, TeXStyle, cCol)
      => ComCall(105, this.p, Int32, Type, Int32, Align, Int32, Char, Int32, Char1, Int32, Char2, Int32, Count, Int32, TeXStyle, Int32, cCol)
    GetMathFunctionType(bstr1, pValue)
      => ComCall(106, this.p, BSTR, bstr1, Int32.Ptr, pValue)
    InsertImage(width, height, ascent, Type, bstrAltText, pStream?)
      => ComCall(107, this.p, Int32, width, Int32, height, Int32, ascent, Int32, Type, BSTR, bstrAltText, IStream, pStream?)
}
struct ITextSelection2 extends ITextRange2 {
    static IID := "{C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3}"
}
struct ITextFont2 extends ITextFont {
    static IID := "{C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetCount(pCount)
      => ComCall(62, this.p, Int32.Ptr, pCount)
    GetAutoLigatures(pValue)
      => ComCall(63, this.p, Int32.Ptr, pValue)
    SetAutoLigatures(Value)
      => ComCall(64, this.p, Int32, Value)
    GetAutospaceAlpha(pValue)
      => ComCall(65, this.p, Int32.Ptr, pValue)
    SetAutospaceAlpha(Value)
      => ComCall(66, this.p, Int32, Value)
    GetAutospaceNumeric(pValue)
      => ComCall(67, this.p, Int32.Ptr, pValue)
    SetAutospaceNumeric(Value)
      => ComCall(68, this.p, Int32, Value)
    GetAutospaceParens(pValue)
      => ComCall(69, this.p, Int32.Ptr, pValue)
    SetAutospaceParens(Value)
      => ComCall(70, this.p, Int32, Value)
    GetCharRep(pValue)
      => ComCall(71, this.p, Int32.Ptr, pValue)
    SetCharRep(Value)
      => ComCall(72, this.p, Int32, Value)
    GetCompressionMode(pValue)
      => ComCall(73, this.p, Int32.Ptr, pValue)
    SetCompressionMode(Value)
      => ComCall(74, this.p, Int32, Value)
    GetCookie(pValue)
      => ComCall(75, this.p, Int32.Ptr, pValue)
    SetCookie(Value)
      => ComCall(76, this.p, Int32, Value)
    GetDoubleStrike(pValue)
      => ComCall(77, this.p, Int32.Ptr, pValue)
    SetDoubleStrike(Value)
      => ComCall(78, this.p, Int32, Value)
    GetDuplicate2(ppFont)
      => ComCall(79, this.p, ITextFont2.Ptr, ppFont)
    SetDuplicate2(pFont?)
      => ComCall(80, this.p, ITextFont2, pFont?)
    GetLinkType(pValue)
      => ComCall(81, this.p, Int32.Ptr, pValue)
    GetMathZone(pValue)
      => ComCall(82, this.p, Int32.Ptr, pValue)
    SetMathZone(Value)
      => ComCall(83, this.p, Int32, Value)
    GetModWidthPairs(pValue)
      => ComCall(84, this.p, Int32.Ptr, pValue)
    SetModWidthPairs(Value)
      => ComCall(85, this.p, Int32, Value)
    GetModWidthSpace(pValue)
      => ComCall(86, this.p, Int32.Ptr, pValue)
    SetModWidthSpace(Value)
      => ComCall(87, this.p, Int32, Value)
    GetOldNumbers(pValue)
      => ComCall(88, this.p, Int32.Ptr, pValue)
    SetOldNumbers(Value)
      => ComCall(89, this.p, Int32, Value)
    GetOverlapping(pValue)
      => ComCall(90, this.p, Int32.Ptr, pValue)
    SetOverlapping(Value)
      => ComCall(91, this.p, Int32, Value)
    GetPositionSubSuper(pValue)
      => ComCall(92, this.p, Int32.Ptr, pValue)
    SetPositionSubSuper(Value)
      => ComCall(93, this.p, Int32, Value)
    GetScaling(pValue)
      => ComCall(94, this.p, Int32.Ptr, pValue)
    SetScaling(Value)
      => ComCall(95, this.p, Int32, Value)
    GetSpaceExtension(pValue)
      => ComCall(96, this.p, Float32.Ptr, pValue)
    SetSpaceExtension(Value)
      => ComCall(97, this.p, Float32, Value)
    GetUnderlinePositionMode(pValue)
      => ComCall(98, this.p, Int32.Ptr, pValue)
    SetUnderlinePositionMode(Value)
      => ComCall(99, this.p, Int32, Value)
    GetEffects(pValue, pMask)
      => ComCall(100, this.p, Int32.Ptr, pValue, Int32.Ptr, pMask)
    GetEffects2(pValue, pMask)
      => ComCall(101, this.p, Int32.Ptr, pValue, Int32.Ptr, pMask)
    GetProperty(Type, pValue)
      => ComCall(102, this.p, Int32, Type, Int32.Ptr, pValue)
    GetPropertyInfo(Index, pType, pValue)
      => ComCall(103, this.p, Int32, Index, Int32.Ptr, pType, Int32.Ptr, pValue)
    IsEqual2(pFont?, pB)
      => ComCall(104, this.p, ITextFont2, pFont?, Int32.Ptr, pB)
    SetEffects(Value, Mask)
      => ComCall(105, this.p, Int32, Value, Int32, Mask)
    SetEffects2(Value, Mask)
      => ComCall(106, this.p, Int32, Value, Int32, Mask)
    SetProperty(Type, Value)
      => ComCall(107, this.p, Int32, Type, Int32, Value)
}
struct ITextPara2 extends ITextPara {
    static IID := "{C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetBorders(ppBorders)
      => ComCall(55, this.p, IUnknown.Ptr, ppBorders)
    GetDuplicate2(ppPara)
      => ComCall(56, this.p, ITextPara2.Ptr, ppPara)
    SetDuplicate2(pPara?)
      => ComCall(57, this.p, ITextPara2, pPara?)
    GetFontAlignment(pValue)
      => ComCall(58, this.p, Int32.Ptr, pValue)
    SetFontAlignment(Value)
      => ComCall(59, this.p, Int32, Value)
    GetHangingPunctuation(pValue)
      => ComCall(60, this.p, Int32.Ptr, pValue)
    SetHangingPunctuation(Value)
      => ComCall(61, this.p, Int32, Value)
    GetSnapToGrid(pValue)
      => ComCall(62, this.p, Int32.Ptr, pValue)
    SetSnapToGrid(Value)
      => ComCall(63, this.p, Int32, Value)
    GetTrimPunctuationAtStart(pValue)
      => ComCall(64, this.p, Int32.Ptr, pValue)
    SetTrimPunctuationAtStart(Value)
      => ComCall(65, this.p, Int32, Value)
    GetEffects(pValue, pMask)
      => ComCall(66, this.p, Int32.Ptr, pValue, Int32.Ptr, pMask)
    GetProperty(Type, pValue)
      => ComCall(67, this.p, Int32, Type, Int32.Ptr, pValue)
    IsEqual2(pPara?, pB)
      => ComCall(68, this.p, ITextPara2, pPara?, Int32.Ptr, pB)
    SetEffects(Value, Mask)
      => ComCall(69, this.p, Int32, Value, Int32, Mask)
    SetProperty(Type, Value)
      => ComCall(70, this.p, Int32, Type, Int32, Value)
}
struct ITextStoryRanges2 extends ITextStoryRanges {
    static IID := "{C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3}"
    Item2(Index, ppRange)
      => ComCall(10, this.p, Int32, Index, ITextRange2.Ptr, ppRange)
}
struct ITextStory extends IUnknown {
    static IID := "{C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetActive(pValue)
      => ComCall(3, this.p, Int32.Ptr, pValue)
    SetActive(Value)
      => ComCall(4, this.p, Int32, Value)
    GetDisplay(ppDisplay)
      => ComCall(5, this.p, IUnknown.Ptr, ppDisplay)
    GetIndex(pValue)
      => ComCall(6, this.p, Int32.Ptr, pValue)
    GetType(pValue)
      => ComCall(7, this.p, Int32.Ptr, pValue)
    SetType(Value)
      => ComCall(8, this.p, Int32, Value)
    GetProperty(Type, pValue)
      => ComCall(9, this.p, Int32, Type, Int32.Ptr, pValue)
    GetRange(cpActive, cpAnchor, ppRange)
      => ComCall(10, this.p, Int32, cpActive, Int32, cpAnchor, ITextRange2.Ptr, ppRange)
    GetText(Flags, pbstr)
      => ComCall(11, this.p, Int32, Flags, BSTR.Ptr, pbstr)
    SetFormattedText(pUnk?)
      => ComCall(12, this.p, IUnknown, pUnk?)
    SetProperty(Type, Value)
      => ComCall(13, this.p, Int32, Type, Int32, Value)
    SetText(Flags, bstr1)
      => ComCall(14, this.p, Int32, Flags, BSTR, bstr1)
}
struct ITextStrings extends IDispatch {
    static IID := "{C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3}"
    Item(Index, ppRange)
      => ComCall(7, this.p, Int32, Index, ITextRange2.Ptr, ppRange)
    GetCount(pCount)
      => ComCall(8, this.p, Int32.Ptr, pCount)
    Add(bstr1)
      => ComCall(9, this.p, BSTR, bstr1)
    Append(pRange?, iString)
      => ComCall(10, this.p, ITextRange2, pRange?, Int32, iString)
    Cat2(iString)
      => ComCall(11, this.p, Int32, iString)
    CatTop2(bstr1)
      => ComCall(12, this.p, BSTR, bstr1)
    DeleteRange(pRange?)
      => ComCall(13, this.p, ITextRange2, pRange?)
    EncodeFunction(Type, Align, Char, Char1, Char2, Count, TeXStyle, cCol, pRange?)
      => ComCall(14, this.p, Int32, Type, Int32, Align, Int32, Char, Int32, Char1, Int32, Char2, Int32, Count, Int32, TeXStyle, Int32, cCol, ITextRange2, pRange?)
    GetCch(iString, pcch)
      => ComCall(15, this.p, Int32, iString, Int32.Ptr, pcch)
    InsertNullStr(iString)
      => ComCall(16, this.p, Int32, iString)
    MoveBoundary(iString, cch)
      => ComCall(17, this.p, Int32, iString, Int32, cch)
    PrefixTop(bstr1)
      => ComCall(18, this.p, BSTR, bstr1)
    Remove(iString, cString)
      => ComCall(19, this.p, Int32, iString, Int32, cString)
    SetFormattedText(pRangeD?, pRangeS?)
      => ComCall(20, this.p, ITextRange2, pRangeD?, ITextRange2, pRangeS?)
    SetOpCp(iString, cp)
      => ComCall(21, this.p, Int32, iString, Int32, cp)
    SuffixTop(bstr1, pRange?)
      => ComCall(22, this.p, BSTR, bstr1, ITextRange2, pRange?)
    Swap()
      => ComCall(23, this.p)
}
struct ITextRow extends IDispatch {
    static IID := "{C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3}"
    GetAlignment(pValue)
      => ComCall(7, this.p, Int32.Ptr, pValue)
    SetAlignment(Value)
      => ComCall(8, this.p, Int32, Value)
    GetCellCount(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
    SetCellCount(Value)
      => ComCall(10, this.p, Int32, Value)
    GetCellCountCache(pValue)
      => ComCall(11, this.p, Int32.Ptr, pValue)
    SetCellCountCache(Value)
      => ComCall(12, this.p, Int32, Value)
    GetCellIndex(pValue)
      => ComCall(13, this.p, Int32.Ptr, pValue)
    SetCellIndex(Value)
      => ComCall(14, this.p, Int32, Value)
    GetCellMargin(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
    SetCellMargin(Value)
      => ComCall(16, this.p, Int32, Value)
    GetHeight(pValue)
      => ComCall(17, this.p, Int32.Ptr, pValue)
    SetHeight(Value)
      => ComCall(18, this.p, Int32, Value)
    GetIndent(pValue)
      => ComCall(19, this.p, Int32.Ptr, pValue)
    SetIndent(Value)
      => ComCall(20, this.p, Int32, Value)
    GetKeepTogether(pValue)
      => ComCall(21, this.p, Int32.Ptr, pValue)
    SetKeepTogether(Value)
      => ComCall(22, this.p, Int32, Value)
    GetKeepWithNext(pValue)
      => ComCall(23, this.p, Int32.Ptr, pValue)
    SetKeepWithNext(Value)
      => ComCall(24, this.p, Int32, Value)
    GetNestLevel(pValue)
      => ComCall(25, this.p, Int32.Ptr, pValue)
    GetRTL(pValue)
      => ComCall(26, this.p, Int32.Ptr, pValue)
    SetRTL(Value)
      => ComCall(27, this.p, Int32, Value)
    GetCellAlignment(pValue)
      => ComCall(28, this.p, Int32.Ptr, pValue)
    SetCellAlignment(Value)
      => ComCall(29, this.p, Int32, Value)
    GetCellColorBack(pValue)
      => ComCall(30, this.p, Int32.Ptr, pValue)
    SetCellColorBack(Value)
      => ComCall(31, this.p, Int32, Value)
    GetCellColorFore(pValue)
      => ComCall(32, this.p, Int32.Ptr, pValue)
    SetCellColorFore(Value)
      => ComCall(33, this.p, Int32, Value)
    GetCellMergeFlags(pValue)
      => ComCall(34, this.p, Int32.Ptr, pValue)
    SetCellMergeFlags(Value)
      => ComCall(35, this.p, Int32, Value)
    GetCellShading(pValue)
      => ComCall(36, this.p, Int32.Ptr, pValue)
    SetCellShading(Value)
      => ComCall(37, this.p, Int32, Value)
    GetCellVerticalText(pValue)
      => ComCall(38, this.p, Int32.Ptr, pValue)
    SetCellVerticalText(Value)
      => ComCall(39, this.p, Int32, Value)
    GetCellWidth(pValue)
      => ComCall(40, this.p, Int32.Ptr, pValue)
    SetCellWidth(Value)
      => ComCall(41, this.p, Int32, Value)
    GetCellBorderColors(pcrLeft, pcrTop, pcrRight, pcrBottom)
      => ComCall(42, this.p, Int32.Ptr, pcrLeft, Int32.Ptr, pcrTop, Int32.Ptr, pcrRight, Int32.Ptr, pcrBottom)
    GetCellBorderWidths(pduLeft, pduTop, pduRight, pduBottom)
      => ComCall(43, this.p, Int32.Ptr, pduLeft, Int32.Ptr, pduTop, Int32.Ptr, pduRight, Int32.Ptr, pduBottom)
    SetCellBorderColors(crLeft, crTop, crRight, crBottom)
      => ComCall(44, this.p, Int32, crLeft, Int32, crTop, Int32, crRight, Int32, crBottom)
    SetCellBorderWidths(duLeft, duTop, duRight, duBottom)
      => ComCall(45, this.p, Int32, duLeft, Int32, duTop, Int32, duRight, Int32, duBottom)
    Apply(cRow, Flags)
      => ComCall(46, this.p, Int32, cRow, tomConstants, Flags)
    CanChange(pValue)
      => ComCall(47, this.p, Int32.Ptr, pValue)
    GetProperty(Type, pValue)
      => ComCall(48, this.p, Int32, Type, Int32.Ptr, pValue)
    Insert(cRow)
      => ComCall(49, this.p, Int32, cRow)
    IsEqual(pRow?, pB)
      => ComCall(50, this.p, ITextRow, pRow?, Int32.Ptr, pB)
    Reset(Value)
      => ComCall(51, this.p, Int32, Value)
    SetProperty(Type, Value)
      => ComCall(52, this.p, Int32, Type, Int32, Value)
}
struct ITextDisplays extends IDispatch {
    static IID := "{C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3}"
}
struct ITextDocument2Old extends ITextDocument {
    static IID := "{01C25500-4268-11D1-883A-3C8B00C10000}"
    AttachMsgFilter(pFilter?)
      => ComCall(26, this.p, IUnknown, pFilter?)
    SetEffectColor(Index, cr)
      => ComCall(27, this.p, Int32, Index, COLORREF, cr)
    GetEffectColor(Index, pcr)
      => ComCall(28, this.p, Int32, Index, COLORREF.Ptr, pcr)
    GetCaretType(pCaretType)
      => ComCall(29, this.p, Int32.Ptr, pCaretType)
    SetCaretType(CaretType)
      => ComCall(30, this.p, Int32, CaretType)
    GetImmContext(pContext)
      => ComCall(31, this.p, Int64.Ptr, pContext)
    ReleaseImmContext(Context)
      => ComCall(32, this.p, Int64, Context)
    GetPreferredFont(cp, CharRep, Option, CharRepCur, curFontSize, pbstr, pPitchAndFamily, pNewFontSize)
      => ComCall(33, this.p, Int32, cp, Int32, CharRep, Int32, Option, Int32, CharRepCur, Int32, curFontSize, BSTR.Ptr, pbstr, Int32.Ptr, pPitchAndFamily, Int32.Ptr, pNewFontSize)
    GetNotificationMode(pMode)
      => ComCall(34, this.p, Int32.Ptr, pMode)
    SetNotificationMode(Mode)
      => ComCall(35, this.p, Int32, Mode)
    GetClientRect(Type, pLeft, pTop, pRight, pBottom)
      => ComCall(36, this.p, Int32, Type, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pRight, Int32.Ptr, pBottom)
    GetSelection2(ppSel)
      => ComCall(37, this.p, ITextSelection.Ptr, ppSel)
    GetWindow(phWnd)
      => ComCall(38, this.p, Int32.Ptr, phWnd)
    GetFEFlags(pFlags)
      => ComCall(39, this.p, Int32.Ptr, pFlags)
    UpdateWindow()
      => ComCall(40, this.p)
    CheckTextLimit(cch, pcch)
      => ComCall(41, this.p, Int32, cch, Int32.Ptr, pcch)
    IMEInProgress(Value)
      => ComCall(42, this.p, Int32, Value)
    SysBeep()
      => ComCall(43, this.p)
    Update(Mode)
      => ComCall(44, this.p, Int32, Mode)
    Notify(Notify)
      => ComCall(45, this.p, Int32, Notify)
    GetDocumentFont(ppITextFont)
      => ComCall(46, this.p, ITextFont.Ptr, ppITextFont)
    GetDocumentPara(ppITextPara)
      => ComCall(47, this.p, ITextPara.Ptr, ppITextPara)
    GetCallManager(ppVoid)
      => ComCall(48, this.p, IUnknown.Ptr, ppVoid)
    ReleaseCallManager(pVoid?)
      => ComCall(49, this.p, IUnknown, pVoid?)
}
