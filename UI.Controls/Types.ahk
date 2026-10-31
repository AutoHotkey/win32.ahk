#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, COLORREF, HANDLE, HINSTANCE, HRESULT, HWND, LPARAM, POINT, PSTR, PWSTR, RECT, SIZE, SYSTEMTIME, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {BLENDFUNCTION, HBITMAP, HBRUSH, HDC, HFONT, HMONITOR, HPALETTE, HPEN}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\UI.Input.Pointer\Types.ahk" {POINTER_FEEDBACK_MODE}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {DLGPROC, DLGTEMPLATE, HICON, POINTER_INPUT_TYPE, WINDOWPOS}

struct THEME_PROPERTY_SYMBOL_ID extends UInt32 {
    static TMT_RESERVEDLOW := 0
    static TMT_RESERVEDHIGH := 7999
    static TMT_DIBDATA := 2
    static TMT_GLYPHDIBDATA := 8
    static TMT_ENUM := 200
    static TMT_STRING := 201
    static TMT_INT := 202
    static TMT_BOOL := 203
    static TMT_COLOR := 204
    static TMT_MARGINS := 205
    static TMT_FILENAME := 206
    static TMT_SIZE := 207
    static TMT_POSITION := 208
    static TMT_RECT := 209
    static TMT_FONT := 210
    static TMT_INTLIST := 211
    static TMT_HBITMAP := 212
    static TMT_DISKSTREAM := 213
    static TMT_STREAM := 214
    static TMT_BITMAPREF := 215
    static TMT_FLOAT := 216
    static TMT_FLOATLIST := 217
    static TMT_COLORSCHEMES := 401
    static TMT_SIZES := 402
    static TMT_CHARSET := 403
    static TMT_NAME := 600
    static TMT_DISPLAYNAME := 601
    static TMT_TOOLTIP := 602
    static TMT_COMPANY := 603
    static TMT_AUTHOR := 604
    static TMT_COPYRIGHT := 605
    static TMT_URL := 606
    static TMT_VERSION := 607
    static TMT_DESCRIPTION := 608
    static TMT_FIRST_RCSTRING_NAME := 601
    static TMT_LAST_RCSTRING_NAME := 608
    static TMT_CAPTIONFONT := 801
    static TMT_SMALLCAPTIONFONT := 802
    static TMT_MENUFONT := 803
    static TMT_STATUSFONT := 804
    static TMT_MSGBOXFONT := 805
    static TMT_ICONTITLEFONT := 806
    static TMT_HEADING1FONT := 807
    static TMT_HEADING2FONT := 808
    static TMT_BODYFONT := 809
    static TMT_FIRSTFONT := 801
    static TMT_LASTFONT := 809
    static TMT_FLATMENUS := 1001
    static TMT_FIRSTBOOL := 1001
    static TMT_LASTBOOL := 1001
    static TMT_SIZINGBORDERWIDTH := 1201
    static TMT_SCROLLBARWIDTH := 1202
    static TMT_SCROLLBARHEIGHT := 1203
    static TMT_CAPTIONBARWIDTH := 1204
    static TMT_CAPTIONBARHEIGHT := 1205
    static TMT_SMCAPTIONBARWIDTH := 1206
    static TMT_SMCAPTIONBARHEIGHT := 1207
    static TMT_MENUBARWIDTH := 1208
    static TMT_MENUBARHEIGHT := 1209
    static TMT_PADDEDBORDERWIDTH := 1210
    static TMT_FIRSTSIZE := 1201
    static TMT_LASTSIZE := 1210
    static TMT_MINCOLORDEPTH := 1301
    static TMT_FIRSTINT := 1301
    static TMT_LASTINT := 1301
    static TMT_CSSNAME := 1401
    static TMT_XMLNAME := 1402
    static TMT_LASTUPDATED := 1403
    static TMT_ALIAS := 1404
    static TMT_FIRSTSTRING := 1401
    static TMT_LASTSTRING := 1404
    static TMT_SCROLLBAR := 1601
    static TMT_BACKGROUND := 1602
    static TMT_ACTIVECAPTION := 1603
    static TMT_INACTIVECAPTION := 1604
    static TMT_MENU := 1605
    static TMT_WINDOW := 1606
    static TMT_WINDOWFRAME := 1607
    static TMT_MENUTEXT := 1608
    static TMT_WINDOWTEXT := 1609
    static TMT_CAPTIONTEXT := 1610
    static TMT_ACTIVEBORDER := 1611
    static TMT_INACTIVEBORDER := 1612
    static TMT_APPWORKSPACE := 1613
    static TMT_HIGHLIGHT := 1614
    static TMT_HIGHLIGHTTEXT := 1615
    static TMT_BTNFACE := 1616
    static TMT_BTNSHADOW := 1617
    static TMT_GRAYTEXT := 1618
    static TMT_BTNTEXT := 1619
    static TMT_INACTIVECAPTIONTEXT := 1620
    static TMT_BTNHIGHLIGHT := 1621
    static TMT_DKSHADOW3D := 1622
    static TMT_LIGHT3D := 1623
    static TMT_INFOTEXT := 1624
    static TMT_INFOBK := 1625
    static TMT_BUTTONALTERNATEFACE := 1626
    static TMT_HOTTRACKING := 1627
    static TMT_GRADIENTACTIVECAPTION := 1628
    static TMT_GRADIENTINACTIVECAPTION := 1629
    static TMT_MENUHILIGHT := 1630
    static TMT_MENUBAR := 1631
    static TMT_FIRSTCOLOR := 1601
    static TMT_LASTCOLOR := 1631
    static TMT_FROMHUE1 := 1801
    static TMT_FROMHUE2 := 1802
    static TMT_FROMHUE3 := 1803
    static TMT_FROMHUE4 := 1804
    static TMT_FROMHUE5 := 1805
    static TMT_TOHUE1 := 1806
    static TMT_TOHUE2 := 1807
    static TMT_TOHUE3 := 1808
    static TMT_TOHUE4 := 1809
    static TMT_TOHUE5 := 1810
    static TMT_FROMCOLOR1 := 2001
    static TMT_FROMCOLOR2 := 2002
    static TMT_FROMCOLOR3 := 2003
    static TMT_FROMCOLOR4 := 2004
    static TMT_FROMCOLOR5 := 2005
    static TMT_TOCOLOR1 := 2006
    static TMT_TOCOLOR2 := 2007
    static TMT_TOCOLOR3 := 2008
    static TMT_TOCOLOR4 := 2009
    static TMT_TOCOLOR5 := 2010
    static TMT_TRANSPARENT := 2201
    static TMT_AUTOSIZE := 2202
    static TMT_BORDERONLY := 2203
    static TMT_COMPOSITED := 2204
    static TMT_BGFILL := 2205
    static TMT_GLYPHTRANSPARENT := 2206
    static TMT_GLYPHONLY := 2207
    static TMT_ALWAYSSHOWSIZINGBAR := 2208
    static TMT_MIRRORIMAGE := 2209
    static TMT_UNIFORMSIZING := 2210
    static TMT_INTEGRALSIZING := 2211
    static TMT_SOURCEGROW := 2212
    static TMT_SOURCESHRINK := 2213
    static TMT_DRAWBORDERS := 2214
    static TMT_NOETCHEDEFFECT := 2215
    static TMT_TEXTAPPLYOVERLAY := 2216
    static TMT_TEXTGLOW := 2217
    static TMT_TEXTITALIC := 2218
    static TMT_COMPOSITEDOPAQUE := 2219
    static TMT_LOCALIZEDMIRRORIMAGE := 2220
    static TMT_IMAGECOUNT := 2401
    static TMT_ALPHALEVEL := 2402
    static TMT_BORDERSIZE := 2403
    static TMT_ROUNDCORNERWIDTH := 2404
    static TMT_ROUNDCORNERHEIGHT := 2405
    static TMT_GRADIENTRATIO1 := 2406
    static TMT_GRADIENTRATIO2 := 2407
    static TMT_GRADIENTRATIO3 := 2408
    static TMT_GRADIENTRATIO4 := 2409
    static TMT_GRADIENTRATIO5 := 2410
    static TMT_PROGRESSCHUNKSIZE := 2411
    static TMT_PROGRESSSPACESIZE := 2412
    static TMT_SATURATION := 2413
    static TMT_TEXTBORDERSIZE := 2414
    static TMT_ALPHATHRESHOLD := 2415
    static TMT_WIDTH := 2416
    static TMT_HEIGHT := 2417
    static TMT_GLYPHINDEX := 2418
    static TMT_TRUESIZESTRETCHMARK := 2419
    static TMT_MINDPI1 := 2420
    static TMT_MINDPI2 := 2421
    static TMT_MINDPI3 := 2422
    static TMT_MINDPI4 := 2423
    static TMT_MINDPI5 := 2424
    static TMT_TEXTGLOWSIZE := 2425
    static TMT_FRAMESPERSECOND := 2426
    static TMT_PIXELSPERFRAME := 2427
    static TMT_ANIMATIONDELAY := 2428
    static TMT_GLOWINTENSITY := 2429
    static TMT_OPACITY := 2430
    static TMT_COLORIZATIONCOLOR := 2431
    static TMT_COLORIZATIONOPACITY := 2432
    static TMT_MINDPI6 := 2433
    static TMT_MINDPI7 := 2434
    static TMT_GLYPHFONT := 2601
    static TMT_IMAGEFILE := 3001
    static TMT_IMAGEFILE1 := 3002
    static TMT_IMAGEFILE2 := 3003
    static TMT_IMAGEFILE3 := 3004
    static TMT_IMAGEFILE4 := 3005
    static TMT_IMAGEFILE5 := 3006
    static TMT_GLYPHIMAGEFILE := 3008
    static TMT_IMAGEFILE6 := 3009
    static TMT_IMAGEFILE7 := 3010
    static TMT_TEXT := 3201
    static TMT_CLASSICVALUE := 3202
    static TMT_OFFSET := 3401
    static TMT_TEXTSHADOWOFFSET := 3402
    static TMT_MINSIZE := 3403
    static TMT_MINSIZE1 := 3404
    static TMT_MINSIZE2 := 3405
    static TMT_MINSIZE3 := 3406
    static TMT_MINSIZE4 := 3407
    static TMT_MINSIZE5 := 3408
    static TMT_NORMALSIZE := 3409
    static TMT_MINSIZE6 := 3410
    static TMT_MINSIZE7 := 3411
    static TMT_SIZINGMARGINS := 3601
    static TMT_CONTENTMARGINS := 3602
    static TMT_CAPTIONMARGINS := 3603
    static TMT_BORDERCOLOR := 3801
    static TMT_FILLCOLOR := 3802
    static TMT_TEXTCOLOR := 3803
    static TMT_EDGELIGHTCOLOR := 3804
    static TMT_EDGEHIGHLIGHTCOLOR := 3805
    static TMT_EDGESHADOWCOLOR := 3806
    static TMT_EDGEDKSHADOWCOLOR := 3807
    static TMT_EDGEFILLCOLOR := 3808
    static TMT_TRANSPARENTCOLOR := 3809
    static TMT_GRADIENTCOLOR1 := 3810
    static TMT_GRADIENTCOLOR2 := 3811
    static TMT_GRADIENTCOLOR3 := 3812
    static TMT_GRADIENTCOLOR4 := 3813
    static TMT_GRADIENTCOLOR5 := 3814
    static TMT_SHADOWCOLOR := 3815
    static TMT_GLOWCOLOR := 3816
    static TMT_TEXTBORDERCOLOR := 3817
    static TMT_TEXTSHADOWCOLOR := 3818
    static TMT_GLYPHTEXTCOLOR := 3819
    static TMT_GLYPHTRANSPARENTCOLOR := 3820
    static TMT_FILLCOLORHINT := 3821
    static TMT_BORDERCOLORHINT := 3822
    static TMT_ACCENTCOLORHINT := 3823
    static TMT_TEXTCOLORHINT := 3824
    static TMT_HEADING1TEXTCOLOR := 3825
    static TMT_HEADING2TEXTCOLOR := 3826
    static TMT_BODYTEXTCOLOR := 3827
    static TMT_BGTYPE := 4001
    static TMT_BORDERTYPE := 4002
    static TMT_FILLTYPE := 4003
    static TMT_SIZINGTYPE := 4004
    static TMT_HALIGN := 4005
    static TMT_CONTENTALIGNMENT := 4006
    static TMT_VALIGN := 4007
    static TMT_OFFSETTYPE := 4008
    static TMT_ICONEFFECT := 4009
    static TMT_TEXTSHADOWTYPE := 4010
    static TMT_IMAGELAYOUT := 4011
    static TMT_GLYPHTYPE := 4012
    static TMT_IMAGESELECTTYPE := 4013
    static TMT_GLYPHFONTSIZINGTYPE := 4014
    static TMT_TRUESIZESCALINGTYPE := 4015
    static TMT_USERPICTURE := 5001
    static TMT_DEFAULTPANESIZE := 5002
    static TMT_BLENDCOLOR := 5003
    static TMT_CUSTOMSPLITRECT := 5004
    static TMT_ANIMATIONBUTTONRECT := 5005
    static TMT_ANIMATIONDURATION := 5006
    static TMT_TRANSITIONDURATIONS := 6000
    static TMT_SCALEDBACKGROUND := 7001
    static TMT_ATLASIMAGE := 8000
    static TMT_ATLASINPUTIMAGE := 8001
    static TMT_ATLASRECT := 8002
}
struct SET_THEME_APP_PROPERTIES_FLAGS extends UInt32 {
    static ALLOW_NONCLIENT := 1
    static ALLOW_CONTROLS := 2
    static ALLOW_WEBCONTENT := 4
    static VALIDBITS := 7
}
struct DRAGLISTINFO_NOTIFICATION_FLAGS extends UInt32 {
    static DL_BEGINDRAG := 1157
    static DL_CANCELDRAG := 1160
    static DL_DRAGGING := 1158
    static DL_DROPPED := 1159
}
struct WORD_BREAK_ACTION extends Int32 {
    static WB_CLASSIFY := 3
    static WB_ISDELIMITER := 2
    static WB_LEFT := 0
    static WB_LEFTBREAK := 6
    static WB_MOVEWORDLEFT := 4
    static WB_MOVEWORDRIGHT := 5
    static WB_RIGHT := 1
    static WB_RIGHTBREAK := 7
}
struct DPAMM_MESSAGE extends UInt32 {
    static DPAMM_MERGE := 1
    static DPAMM_DELETE := 2
    static DPAMM_INSERT := 3
}
struct DLG_DIR_LIST_FILE_TYPE extends UInt32 {
    static DDL_ARCHIVE := 32
    static DDL_DIRECTORY := 16
    static DDL_DRIVES := 16384
    static DDL_EXCLUSIVE := 32768
    static DDL_HIDDEN := 2
    static DDL_READONLY := 1
    static DDL_READWRITE := 0
    static DDL_SYSTEM := 4
    static DDL_POSTMSGS := 8192
}
struct OPEN_THEME_DATA_FLAGS extends UInt32 {
    static OTD_FORCE_RECT_SIZING := 1
    static OTD_NONCLIENT := 2
}
struct GET_THEME_BITMAP_FLAGS extends UInt32 {
    static GBF_DIRECT := 1
    static GBF_COPY := 2
    static GBF_VALIDBITS := 3
}
struct ENABLE_SCROLL_BAR_ARROWS extends UInt32 {
    static ESB_DISABLE_BOTH := 3
    static ESB_DISABLE_DOWN := 2
    static ESB_DISABLE_LEFT := 1
    static ESB_DISABLE_LTUP := 1
    static ESB_DISABLE_RIGHT := 2
    static ESB_DISABLE_RTDN := 2
    static ESB_DISABLE_UP := 1
    static ESB_ENABLE_BOTH := 0
}
struct IMAGE_LIST_DRAW_STYLE extends UInt32 {
    static ILD_NORMAL := 0
    static ILD_TRANSPARENT := 1
    static ILD_BLEND25 := 2
    static ILD_FOCUS := 2
    static ILD_BLEND50 := 4
    static ILD_SELECTED := 4
    static ILD_BLEND := 4
    static ILD_MASK := 16
    static ILD_IMAGE := 32
    static ILD_ROP := 64
    static ILD_OVERLAYMASK := 3840
    static ILD_PRESERVEALPHA := 4096
    static ILD_SCALE := 8192
    static ILD_DPISCALE := 16384
    static ILD_ASYNC := 32768
}
struct WSB_PROP extends Int32 {
    static WSB_PROP_CXHSCROLL := 2
    static WSB_PROP_CXHTHUMB := 16
    static WSB_PROP_CXVSCROLL := 8
    static WSB_PROP_CYHSCROLL := 4
    static WSB_PROP_CYVSCROLL := 1
    static WSB_PROP_CYVTHUMB := 32
    static WSB_PROP_HBKGCOLOR := 128
    static WSB_PROP_HSTYLE := 512
    static WSB_PROP_PALETTE := 2048
    static WSB_PROP_VBKGCOLOR := 64
    static WSB_PROP_VSTYLE := 256
    static WSB_PROP_WINSTYLE := 1024
}
struct PSPCB_MESSAGE extends UInt32 {
    static PSPCB_ADDREF := 0
    static PSPCB_CREATE := 2
    static PSPCB_RELEASE := 1
    static PSPCB_SI_INITDIALOG := 1025
}
struct HEADER_CONTROL_NOTIFICATION_BUTTON extends Int32 {
    static HEADER_CONTROL_NOTIFICATION_BUTTON_LEFT := 0
    static HEADER_CONTROL_NOTIFICATION_BUTTON_RIGHT := 1
    static HEADER_CONTROL_NOTIFICATION_BUTTON_MIDDLE := 2
}
struct IMAGE_LIST_COPY_FLAGS extends UInt32 {
    static ILCF_MOVE := 0
    static ILCF_SWAP := 1
}
struct DLG_BUTTON_CHECK_STATE extends UInt32 {
    static BST_CHECKED := 1
    static BST_INDETERMINATE := 2
    static BST_UNCHECKED := 0
}
struct DRAW_THEME_PARENT_BACKGROUND_FLAGS extends UInt32 {
    static DTPB_WINDOWDC := 1
    static DTPB_USECTLCOLORSTATIC := 2
    static DTPB_USEERASEBKGND := 4
}
struct IMAGE_LIST_ITEM_FLAGS extends UInt32 {
    static ILIF_ALPHA := 1
    static ILIF_LOWQUALITY := 2
}
struct HDI_MASK extends UInt32 {
    static HDI_WIDTH := 1
    static HDI_HEIGHT := 1
    static HDI_TEXT := 2
    static HDI_FORMAT := 4
    static HDI_LPARAM := 8
    static HDI_BITMAP := 16
    static HDI_IMAGE := 32
    static HDI_DI_SETITEM := 64
    static HDI_ORDER := 128
    static HDI_FILTER := 256
    static HDI_STATE := 512
}
struct NMREBAR_MASK_FLAGS extends UInt32 {
    static RBNM_ID := 1
    static RBNM_LPARAM := 4
    static RBNM_STYLE := 2
}
struct EDITBALLOONTIP_ICON extends Int32 {
    static TTI_ERROR := 3
    static TTI_INFO := 1
    static TTI_NONE := 0
    static TTI_WARNING := 2
    static TTI_INFO_LARGE := 4
    static TTI_WARNING_LARGE := 5
    static TTI_ERROR_LARGE := 6
}
struct LVCOLUMNW_FORMAT extends Int32 {
    static LVCFMT_LEFT := 0
    static LVCFMT_RIGHT := 1
    static LVCFMT_CENTER := 2
    static LVCFMT_JUSTIFYMASK := 3
    static LVCFMT_IMAGE := 2048
    static LVCFMT_BITMAP_ON_RIGHT := 4096
    static LVCFMT_COL_HAS_IMAGES := 32768
    static LVCFMT_FIXED_WIDTH := 256
    static LVCFMT_NO_DPI_SCALE := 262144
    static LVCFMT_FIXED_RATIO := 524288
    static LVCFMT_SPLITBUTTON := 16777216
}
struct NMPGSCROLL_KEYS extends UInt16 {
    static PGK_NONE := 0
    static PGK_SHIFT := 1
    static PGK_CONTROL := 2
    static PGK_MENU := 4
}
struct COMBOBOX_EX_ITEM_FLAGS extends UInt32 {
    static CBEIF_DI_SETITEM := 268435456
    static CBEIF_IMAGE := 2
    static CBEIF_INDENT := 16
    static CBEIF_LPARAM := 32
    static CBEIF_OVERLAY := 8
    static CBEIF_SELECTEDIMAGE := 4
    static CBEIF_TEXT := 1
}
struct TVITEMEXW_CHILDREN extends Int32 {
    static I_ZERO := 0
    static I_ONE_OR_MORE := 1
    static I_CHILDRENCALLBACK := -1
    static I_CHILDRENAUTO := -2
}
struct TVITEM_MASK extends UInt32 {
    static TVIF_CHILDREN := 64
    static TVIF_DI_SETITEM := 4096
    static TVIF_HANDLE := 16
    static TVIF_IMAGE := 2
    static TVIF_PARAM := 4
    static TVIF_SELECTEDIMAGE := 32
    static TVIF_STATE := 8
    static TVIF_TEXT := 1
    static TVIF_EXPANDEDIMAGE := 512
    static TVIF_INTEGRAL := 128
    static TVIF_STATEEX := 256
}
struct TCITEMHEADERA_MASK extends UInt32 {
    static TCIF_IMAGE := 2
    static TCIF_RTLREADING := 4
    static TCIF_TEXT := 1
    static TCIF_PARAM := 8
    static TCIF_STATE := 16
}
struct TCHITTESTINFO_FLAGS extends UInt32 {
    static TCHT_NOWHERE := 1
    static TCHT_ONITEM := 6
    static TCHT_ONITEMICON := 2
    static TCHT_ONITEMLABEL := 4
}
struct COMBOBOXINFO_BUTTON_STATE extends UInt32 {
    static STATE_SYSTEM_INVISIBLE := 32768
    static STATE_SYSTEM_PRESSED := 8
    static STATE_SYSTEM_FOCUSABLE := 1048576
    static STATE_SYSTEM_OFFSCREEN := 65536
    static STATE_SYSTEM_UNAVAILABLE := 1
}
struct NMCUSTOMDRAW_DRAW_STAGE extends UInt32 {
    static CDDS_POSTPAINT := 2
    static CDDS_PREERASE := 3
    static CDDS_PREPAINT := 1
    static CDDS_ITEMPOSTERASE := 65540
    static CDDS_ITEMPOSTPAINT := 65538
    static CDDS_ITEMPREERASE := 65539
    static CDDS_ITEMPREPAINT := 65537
    static CDDS_SUBITEM := 131072
}
struct MCGRIDINFO_PART extends UInt32 {
    static MCGIP_CALENDARCONTROL := 0
    static MCGIP_NEXT := 1
    static MCGIP_PREV := 2
    static MCGIP_FOOTER := 3
    static MCGIP_CALENDAR := 4
    static MCGIP_CALENDARHEADER := 5
    static MCGIP_CALENDARBODY := 6
    static MCGIP_CALENDARROW := 7
    static MCGIP_CALENDARCELL := 8
}
struct LVITEMA_GROUP_ID extends Int32 {
    static I_GROUPIDCALLBACK := -1
    static I_GROUPIDNONE := -2
}
struct NMTBHOTITEM_FLAGS extends UInt32 {
    static HICF_ACCELERATOR := 4
    static HICF_ARROWKEYS := 2
    static HICF_DUPACCEL := 8
    static HICF_ENTERING := 16
    static HICF_LEAVING := 32
    static HICF_LMOUSE := 128
    static HICF_MOUSE := 1
    static HICF_OTHER := 0
    static HICF_RESELECT := 64
    static HICF_TOGGLEDROPDOWN := 256
}
struct TOOLTIP_FLAGS extends UInt32 {
    static TTF_IDISHWND := 1
    static TTF_CENTERTIP := 2
    static TTF_RTLREADING := 4
    static TTF_SUBCLASS := 16
    static TTF_TRACK := 32
    static TTF_ABSOLUTE := 128
    static TTF_TRANSPARENT := 256
    static TTF_PARSELINKS := 4096
    static TTF_DI_SETITEM := 32768
}
struct LVTILEVIEWINFO_FLAGS extends UInt32 {
    static LVTVIF_AUTOSIZE := 0
    static LVTVIF_FIXEDWIDTH := 1
    static LVTVIF_FIXEDHEIGHT := 2
    static LVTVIF_FIXEDSIZE := 3
}
struct LVTILEVIEWINFO_MASK extends UInt32 {
    static LVTVIM_TILESIZE := 1
    static LVTVIM_COLUMNS := 2
    static LVTVIM_LABELMARGIN := 4
}
struct NMPGSCROLL_DIR extends Int32 {
    static PGF_SCROLLDOWN := 2
    static PGF_SCROLLLEFT := 4
    static PGF_SCROLLRIGHT := 8
    static PGF_SCROLLUP := 1
}
struct LVCOLUMNW_MASK extends UInt32 {
    static LVCF_FMT := 1
    static LVCF_WIDTH := 2
    static LVCF_TEXT := 4
    static LVCF_SUBITEM := 8
    static LVCF_IMAGE := 16
    static LVCF_ORDER := 32
    static LVCF_MINWIDTH := 64
    static LVCF_DEFAULTWIDTH := 128
    static LVCF_IDEALWIDTH := 256
}
struct LVFINDINFOW_FLAGS extends UInt32 {
    static LVFI_PARAM := 1
    static LVFI_PARTIAL := 8
    static LVFI_STRING := 2
    static LVFI_SUBSTRING := 4
    static LVFI_WRAP := 32
    static LVFI_NEARESTXY := 64
}
struct BUTTON_IMAGELIST_ALIGN extends UInt32 {
    static BUTTON_IMAGELIST_ALIGN_LEFT := 0
    static BUTTON_IMAGELIST_ALIGN_RIGHT := 1
    static BUTTON_IMAGELIST_ALIGN_TOP := 2
    static BUTTON_IMAGELIST_ALIGN_BOTTOM := 3
    static BUTTON_IMAGELIST_ALIGN_CENTER := 4
}
struct TBBUTTONINFOW_MASK extends UInt32 {
    static TBIF_BYINDEX := 2147483648
    static TBIF_COMMAND := 32
    static TBIF_IMAGE := 1
    static TBIF_LPARAM := 16
    static TBIF_SIZE := 64
    static TBIF_STATE := 4
    static TBIF_STYLE := 8
    static TBIF_TEXT := 2
}
struct TBINSERTMARK_FLAGS extends UInt32 {
    static TBIMHT_NONE := 0
    static TBIMHT_AFTER := 1
    static TBIMHT_BACKGROUND := 2
}
struct LVGROUP_MASK extends UInt32 {
    static LVGF_NONE := 0
    static LVGF_HEADER := 1
    static LVGF_FOOTER := 2
    static LVGF_STATE := 4
    static LVGF_ALIGN := 8
    static LVGF_GROUPID := 16
    static LVGF_SUBTITLE := 256
    static LVGF_TASK := 512
    static LVGF_DESCRIPTIONTOP := 1024
    static LVGF_DESCRIPTIONBOTTOM := 2048
    static LVGF_TITLEIMAGE := 4096
    static LVGF_EXTENDEDIMAGE := 8192
    static LVGF_ITEMS := 16384
    static LVGF_SUBSET := 32768
    static LVGF_SUBSETITEMS := 65536
}
struct BP_PAINTPARAMS_FLAGS extends UInt32 {
    static BPPF_ERASE := 1
    static BPPF_NOCLIP := 2
    static BPPF_NONCLIENT := 4
}
struct TVHITTESTINFO_FLAGS extends UInt32 {
    static TVHT_ABOVE := 256
    static TVHT_BELOW := 512
    static TVHT_NOWHERE := 1
    static TVHT_ONITEM := 70
    static TVHT_ONITEMBUTTON := 16
    static TVHT_ONITEMICON := 2
    static TVHT_ONITEMINDENT := 8
    static TVHT_ONITEMLABEL := 4
    static TVHT_ONITEMRIGHT := 32
    static TVHT_ONITEMSTATEICON := 64
    static TVHT_TOLEFT := 2048
    static TVHT_TORIGHT := 1024
}
struct DRAWITEMSTRUCT_CTL_TYPE extends UInt32 {
    static ODT_BUTTON := 4
    static ODT_COMBOBOX := 3
    static ODT_LISTBOX := 2
    static ODT_LISTVIEW := 102
    static ODT_MENU := 1
    static ODT_STATIC := 5
    static ODT_TAB := 101
}
struct NMPGCALCSIZE_FLAGS extends UInt32 {
    static PGF_CALCHEIGHT := 2
    static PGF_CALCWIDTH := 1
}
struct MCGRIDINFO_FLAGS extends UInt32 {
    static MCGIF_DATE := 1
    static MCGIF_RECT := 2
    static MCGIF_NAME := 4
}
struct LVHITTESTINFO_FLAGS extends UInt32 {
    static LVHT_ABOVE := 8
    static LVHT_BELOW := 16
    static LVHT_NOWHERE := 1
    static LVHT_ONITEMICON := 2
    static LVHT_ONITEMLABEL := 4
    static LVHT_ONITEMSTATEICON := 8
    static LVHT_TOLEFT := 64
    static LVHT_TORIGHT := 32
    static LVHT_EX_GROUP_HEADER := 268435456
    static LVHT_EX_GROUP_FOOTER := 536870912
    static LVHT_EX_GROUP_COLLAPSE := 1073741824
    static LVHT_EX_GROUP_BACKGROUND := 2147483648
    static LVHT_EX_GROUP_STATEICON := 16777216
    static LVHT_EX_GROUP_SUBSETLINK := 33554432
    static LVHT_EX_GROUP := 4076863488
    static LVHT_EX_ONCONTENTS := 67108864
    static LVHT_EX_FOOTER := 134217728
}
struct INITCOMMONCONTROLSEX_ICC extends UInt32 {
    static ICC_ANIMATE_CLASS := 128
    static ICC_BAR_CLASSES := 4
    static ICC_COOL_CLASSES := 1024
    static ICC_DATE_CLASSES := 256
    static ICC_HOTKEY_CLASS := 64
    static ICC_INTERNET_CLASSES := 2048
    static ICC_LINK_CLASS := 32768
    static ICC_LISTVIEW_CLASSES := 1
    static ICC_NATIVEFNTCTL_CLASS := 8192
    static ICC_PAGESCROLLER_CLASS := 4096
    static ICC_PROGRESS_CLASS := 32
    static ICC_STANDARD_CLASSES := 16384
    static ICC_TAB_CLASSES := 8
    static ICC_TREEVIEW_CLASSES := 2
    static ICC_UPDOWN_CLASS := 16
    static ICC_USEREX_CLASSES := 512
    static ICC_WIN95_CLASSES := 255
}
struct NMLVCUSTOMDRAW_ITEM_TYPE extends UInt32 {
    static LVCDI_ITEM := 0
    static LVCDI_GROUP := 1
    static LVCDI_ITEMSLIST := 2
}
struct NMTBDISPINFOW_MASK extends UInt32 {
    static TBNF_IMAGE := 1
    static TBNF_TEXT := 2
    static TBNF_DI_SETITEM := 268435456
}
struct NMLVEMPTYMARKUP_FLAGS extends UInt32 {
    static EMF_CENTERED := 1
}
struct LVFOOTERITEM_MASK extends UInt32 {
    static LVFIF_TEXT := 1
    static LVFIF_STATE := 2
}
struct IMAGELIST_CREATION_FLAGS extends UInt32 {
    static ILC_MASK := 1
    static ILC_COLOR := 0
    static ILC_COLORDDB := 254
    static ILC_COLOR4 := 4
    static ILC_COLOR8 := 8
    static ILC_COLOR16 := 16
    static ILC_COLOR24 := 24
    static ILC_COLOR32 := 32
    static ILC_PALETTE := 2048
    static ILC_MIRROR := 8192
    static ILC_PERITEMMIRROR := 32768
    static ILC_ORIGINALSIZE := 65536
    static ILC_HIGHQUALITYSCALE := 131072
}
struct DTTOPTS_FLAGS extends UInt32 {
    static DTT_TEXTCOLOR := 1
    static DTT_BORDERCOLOR := 2
    static DTT_SHADOWCOLOR := 4
    static DTT_SHADOWTYPE := 8
    static DTT_SHADOWOFFSET := 16
    static DTT_BORDERSIZE := 32
    static DTT_FONTPROP := 64
    static DTT_COLORPROP := 128
    static DTT_STATEID := 256
    static DTT_CALCRECT := 512
    static DTT_APPLYOVERLAY := 1024
    static DTT_GLOWSIZE := 2048
    static DTT_CALLBACK := 4096
    static DTT_COMPOSITED := 8192
    static DTT_VALIDBITS := 12287
}
struct NMLVGETINFOTIP_FLAGS extends UInt32 {
    static LVGIT_UNFOLDED := 1
    static LVGIT_ZERO := 0
}
struct LIST_VIEW_ITEM_STATE_FLAGS extends UInt32 {
    static LVIS_FOCUSED := 1
    static LVIS_SELECTED := 2
    static LVIS_CUT := 4
    static LVIS_DROPHILITED := 8
    static LVIS_GLOW := 16
    static LVIS_ACTIVATING := 32
    static LVIS_OVERLAYMASK := 3840
    static LVIS_STATEIMAGEMASK := 61440
}
struct NM_TREEVIEW_ACTION extends UInt32 {
    static TVE_COLLAPSE := 1
    static TVE_EXPAND := 2
    static TVE_TOGGLE := 3
    static TVE_EXPANDPARTIAL := 16384
    static TVE_COLLAPSERESET := 32768
    static TVC_UNKNOWN := 0
    static TVC_BYMOUSE := 1
    static TVC_BYKEYBOARD := 2
}
struct MONTH_CALDENDAR_MESSAGES_VIEW extends UInt32 {
    static MCMV_MONTH := 0
    static MCMV_YEAR := 1
    static MCMV_DECADE := 2
    static MCMV_CENTURY := 3
    static MCMV_MAX := 3
}
struct TAB_CONTROL_ITEM_STATE extends UInt32 {
    static TCIS_BUTTONPRESSED := 1
    static TCIS_HIGHLIGHTED := 2
}
struct TREE_VIEW_ITEM_STATE_FLAGS extends UInt32 {
    static TVIS_SELECTED := 2
    static TVIS_CUT := 4
    static TVIS_DROPHILITED := 8
    static TVIS_BOLD := 16
    static TVIS_EXPANDED := 32
    static TVIS_EXPANDEDONCE := 64
    static TVIS_EXPANDPARTIAL := 128
    static TVIS_OVERLAYMASK := 3840
    static TVIS_STATEIMAGEMASK := 61440
    static TVIS_USERMASK := 61440
    static TVIS_EX_FLAT := 1
    static TVIS_EX_DISABLED := 2
    static TVIS_EX_ALL := 2
}
struct HEADER_CONTROL_FORMAT_FLAGS extends Int32 {
    static HDF_LEFT := 0
    static HDF_RIGHT := 1
    static HDF_CENTER := 2
    static HDF_JUSTIFYMASK := 3
    static HDF_RTLREADING := 4
    static HDF_BITMAP := 8192
    static HDF_STRING := 16384
    static HDF_OWNERDRAW := 32768
    static HDF_IMAGE := 2048
    static HDF_BITMAP_ON_RIGHT := 4096
    static HDF_SORTUP := 1024
    static HDF_SORTDOWN := 512
    static HDF_CHECKBOX := 64
    static HDF_CHECKED := 128
    static HDF_FIXEDWIDTH := 256
    static HDF_SPLITBUTTON := 16777216
}
struct HEADER_CONTROL_FORMAT_TYPE extends UInt32 {
    static HDFT_ISSTRING := 0
    static HDFT_ISNUMBER := 1
    static HDFT_ISDATE := 2
    static HDFT_HASNOVALUE := 32768
}
struct HEADER_CONTROL_FORMAT_STATE extends UInt32 {
    static HDIS_FOCUSED := 1
}
struct HEADER_HITTEST_INFO_FLAGS extends UInt32 {
    static HHT_NOWHERE := 1
    static HHT_ONHEADER := 2
    static HHT_ONDIVIDER := 4
    static HHT_ONDIVOPEN := 8
    static HHT_ONFILTER := 16
    static HHT_ONFILTERBUTTON := 32
    static HHT_ABOVE := 256
    static HHT_BELOW := 512
    static HHT_TORIGHT := 1024
    static HHT_TOLEFT := 2048
    static HHT_ONITEMSTATEICON := 4096
    static HHT_ONDROPDOWN := 8192
    static HHT_ONOVERFLOW := 16384
}
struct IMAGE_LIST_WRITE_STREAM_FLAGS extends UInt32 {
    static ILP_NORMAL := 0
    static ILP_DOWNLEVEL := 1
}
struct LIST_ITEM_FLAGS extends UInt32 {
    static LIF_ITEMINDEX := 1
    static LIF_STATE := 2
    static LIF_ITEMID := 4
    static LIF_URL := 8
}
struct LIST_ITEM_STATE_FLAGS extends UInt32 {
    static LIS_FOCUSED := 1
    static LIS_ENABLED := 2
    static LIS_VISITED := 4
    static LIS_HOTTRACK := 8
    static LIS_DEFAULTCOLORS := 16
}
struct LIST_VIEW_BACKGROUND_IMAGE_FLAGS extends UInt32 {
    static LVBKIF_SOURCE_NONE := 0
    static LVBKIF_SOURCE_HBITMAP := 1
    static LVBKIF_SOURCE_URL := 2
    static LVBKIF_SOURCE_MASK := 3
    static LVBKIF_STYLE_NORMAL := 0
    static LVBKIF_STYLE_TILE := 16
    static LVBKIF_STYLE_MASK := 16
    static LVBKIF_FLAG_TILEOFFSET := 256
    static LVBKIF_TYPE_WATERMARK := 268435456
    static LVBKIF_FLAG_ALPHABLEND := 536870912
}
struct LIST_VIEW_GROUP_STATE_FLAGS extends UInt32 {
    static LVGS_NORMAL := 0
    static LVGS_COLLAPSED := 1
    static LVGS_HIDDEN := 2
    static LVGS_NOHEADER := 4
    static LVGS_COLLAPSIBLE := 8
    static LVGS_FOCUSED := 16
    static LVGS_SELECTED := 32
    static LVGS_SUBSETED := 64
    static LVGS_SUBSETLINKFOCUSED := 128
}
struct LIST_VIEW_GROUP_ALIGN_FLAGS extends UInt32 {
    static LVGA_HEADER_LEFT := 1
    static LVGA_HEADER_CENTER := 2
    static LVGA_HEADER_RIGHT := 4
    static LVGA_FOOTER_LEFT := 8
    static LVGA_FOOTER_CENTER := 16
    static LVGA_FOOTER_RIGHT := 32
}
struct LIST_VIEW_ITEM_COLUMN_FORMAT_FLAGS extends Int32 {
    static LVCFMT_LINE_BREAK := 1048576
    static LVCFMT_FILL := 2097152
    static LVCFMT_WRAP := 4194304
    static LVCFMT_NO_TITLE := 8388608
    static LVCFMT_TILE_PLACEMENTMASK := 3145728
}
struct MCHITTESTINFO_HIT_FLAGS extends UInt32 {
    static MCHT_TITLE := 65536
    static MCHT_CALENDAR := 131072
    static MCHT_TODAYLINK := 196608
    static MCHT_CALENDARCONTROL := 1048576
    static MCHT_NEXT := 16777216
    static MCHT_PREV := 33554432
    static MCHT_NOWHERE := 0
    static MCHT_TITLEBK := 65536
    static MCHT_TITLEMONTH := 65537
    static MCHT_TITLEYEAR := 65538
    static MCHT_TITLEBTNNEXT := 16842755
    static MCHT_TITLEBTNPREV := 33619971
    static MCHT_CALENDARBK := 131072
    static MCHT_CALENDARDATE := 131073
    static MCHT_CALENDARDATENEXT := 16908289
    static MCHT_CALENDARDATEPREV := 33685505
    static MCHT_CALENDARDAY := 131074
    static MCHT_CALENDARWEEKNUM := 131075
    static MCHT_CALENDARDATEMIN := 131076
    static MCHT_CALENDARDATEMAX := 131077
}
struct NMCUSTOMDRAW_DRAW_STATE_FLAGS extends UInt32 {
    static CDIS_SELECTED := 1
    static CDIS_GRAYED := 2
    static CDIS_DISABLED := 4
    static CDIS_CHECKED := 8
    static CDIS_FOCUS := 16
    static CDIS_DEFAULT := 32
    static CDIS_HOT := 64
    static CDIS_MARKED := 128
    static CDIS_INDETERMINATE := 256
    static CDIS_SHOWKEYBOARDCUES := 512
    static CDIS_NEARHOT := 1024
    static CDIS_OTHERSIDEHOT := 2048
    static CDIS_DROPHILITED := 4096
}
struct NMDATETIMECHANGE_FLAGS extends UInt32 {
    static GDT_NONE := 1
    static GDT_VALID := 0
}
struct LIST_VIEW_ITEM_FLAGS extends UInt32 {
    static LVIF_TEXT := 1
    static LVIF_IMAGE := 2
    static LVIF_PARAM := 4
    static LVIF_STATE := 8
    static LVIF_INDENT := 16
    static LVIF_NORECOMPUTE := 2048
    static LVIF_GROUPID := 256
    static LVIF_COLUMNS := 512
    static LVIF_COLFMT := 65536
    static LVIF_DI_SETITEM := 4096
}
struct ODA_FLAGS extends UInt32 {
    static ODA_DRAWENTIRE := 1
    static ODA_SELECT := 2
    static ODA_FOCUS := 4
}
struct ODS_FLAGS extends UInt32 {
    static ODS_SELECTED := 1
    static ODS_GRAYED := 2
    static ODS_DISABLED := 4
    static ODS_CHECKED := 8
    static ODS_FOCUS := 16
    static ODS_DEFAULT := 32
    static ODS_COMBOBOXEDIT := 4096
    static ODS_HOTLIGHT := 64
    static ODS_INACTIVE := 128
    static ODS_NOACCEL := 256
    static ODS_NOFOCUSRECT := 512
}
struct HIT_TEST_BACKGROUND_OPTIONS extends UInt32 {
    static HTTB_BACKGROUNDSEG := 0
    static HTTB_FIXEDBORDER := 2
    static HTTB_CAPTION := 4
    static HTTB_RESIZINGBORDER_LEFT := 16
    static HTTB_RESIZINGBORDER_TOP := 32
    static HTTB_RESIZINGBORDER_RIGHT := 64
    static HTTB_RESIZINGBORDER_BOTTOM := 128
    static HTTB_RESIZINGBORDER := 240
    static HTTB_SIZINGTEMPLATE := 256
    static HTTB_SYSTEMSIZINGMARGINS := 512
}
struct TASKDIALOG_COMMON_BUTTON_FLAGS extends Int32 {
    static TDCBF_OK_BUTTON := 1
    static TDCBF_YES_BUTTON := 2
    static TDCBF_NO_BUTTON := 4
    static TDCBF_CANCEL_BUTTON := 8
    static TDCBF_RETRY_BUTTON := 16
    static TDCBF_CLOSE_BUTTON := 32
    static TDCBF_ABORT_BUTTON := 65536
    static TDCBF_IGNORE_BUTTON := 131072
    static TDCBF_TRYAGAIN_BUTTON := 262144
    static TDCBF_CONTINUE_BUTTON := 524288
    static TDCBF_HELP_BUTTON := 1048576
}
struct HPROPSHEETPAGE {
    Value : IntPtr
}
struct HIMAGELIST {
    Value : IntPtr
}
struct HTHEME {
    Value : IntPtr
}
struct HTREEITEM {
    Value : IntPtr
}
struct HDSA {
    Value : IntPtr
}
struct HDPA {
    Value : IntPtr
}
struct TBBUTTON {
    iBitmap : Int32
    idCommand : Int32
    fsState : UInt8
    fsStyle : UInt8
    bReserved : UInt8[6]
    dwData : IntPtr
    iString : IntPtr
}
struct LPFNPSPCALLBACKA extends FunctionPointer {
    static Types := [HWND, PSPCB_MESSAGE, PROPSHEETPAGEA.Ptr, UInt32]
}
struct LPFNPSPCALLBACKW extends FunctionPointer {
    static Types := [HWND, PSPCB_MESSAGE, PROPSHEETPAGEW.Ptr, UInt32]
}
struct PROPSHEETPAGEA_V1 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKA
    pcRefParent : UInt32.Ptr
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
}
struct PROPSHEETPAGEA_V2 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKA
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PSTR
    pszHeaderSubTitle : PSTR
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
}
struct PROPSHEETPAGEA_V3 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKA
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PSTR
    pszHeaderSubTitle : PSTR
    hActCtx : HANDLE
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
}
struct PROPSHEETPAGEA {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKA
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PSTR
    pszHeaderSubTitle : PSTR
    hActCtx : HANDLE
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            hbmHeader : HBITMAP
            pszbmHeader : PSTR
        }
    }
}
struct PROPSHEETPAGEW_V1 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PWSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKW
    pcRefParent : UInt32.Ptr
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PWSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
}
struct PROPSHEETPAGEW_V2 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PWSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKW
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PWSTR
    pszHeaderSubTitle : PWSTR
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PWSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
}
struct PROPSHEETPAGEW_V3 {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PWSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKW
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PWSTR
    pszHeaderSubTitle : PWSTR
    hActCtx : HANDLE
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PWSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
}
struct PROPSHEETPAGEW {
    dwSize : UInt32
    dwFlags : UInt32
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    pszTitle : PWSTR
    pfnDlgProc : DLGPROC
    lParam : LPARAM
    pfnCallback : LPFNPSPCALLBACKW
    pcRefParent : UInt32.Ptr
    pszHeaderTitle : PWSTR
    pszHeaderSubTitle : PWSTR
    hActCtx : HANDLE
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            pszTemplate : PWSTR
            pResource : DLGTEMPLATE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            hbmHeader : HBITMAP
            pszbmHeader : PWSTR
        }
    }
}
struct PFNPROPSHEETCALLBACK extends FunctionPointer {
    static Types := [HWND, UInt32, LPARAM, Int32]
}
struct PROPSHEETHEADERA_V1 {
    dwSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    pszCaption : PSTR
    nPages : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    pfnCallback : PFNPROPSHEETCALLBACK
    struct _Anonymous1_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            nStartPage : UInt32
            pStartPage : PSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ppsp : PROPSHEETPAGEA.Ptr
            phpage : HPROPSHEETPAGE.Ptr
        }
    }
}
struct PROPSHEETHEADERA_V2 {
    dwSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    pszCaption : PSTR
    nPages : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    pfnCallback : PFNPROPSHEETCALLBACK
    Anonymous4 : this._Anonymous4_e__Union
    hplWatermark : HPALETTE
    Anonymous5 : this._Anonymous5_e__Union
    struct _Anonymous1_e__Union {
        union {
            hIcon : HICON
            pszIcon : PSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            nStartPage : UInt32
            pStartPage : PSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ppsp : PROPSHEETPAGEA.Ptr
            phpage : HPROPSHEETPAGE.Ptr
        }
    }
    struct _Anonymous4_e__Union {
        union {
            hbmWatermark : HBITMAP
            pszbmWatermark : PSTR
        }
    }
    struct _Anonymous5_e__Union {
        union {
            hbmHeader : HBITMAP
            pszbmHeader : PSTR
        }
    }
}
struct PROPSHEETHEADERW_V1 {
    dwSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    pszCaption : PWSTR
    nPages : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    pfnCallback : PFNPROPSHEETCALLBACK
    struct _Anonymous1_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            nStartPage : UInt32
            pStartPage : PWSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ppsp : PROPSHEETPAGEW.Ptr
            phpage : HPROPSHEETPAGE.Ptr
        }
    }
}
struct PROPSHEETHEADERW_V2 {
    dwSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    hInstance : HINSTANCE
    Anonymous1 : this._Anonymous1_e__Union
    pszCaption : PWSTR
    nPages : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    pfnCallback : PFNPROPSHEETCALLBACK
    Anonymous4 : this._Anonymous4_e__Union
    hplWatermark : HPALETTE
    Anonymous5 : this._Anonymous5_e__Union
    struct _Anonymous1_e__Union {
        union {
            hIcon : HICON
            pszIcon : PWSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            nStartPage : UInt32
            pStartPage : PWSTR
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ppsp : PROPSHEETPAGEW.Ptr
            phpage : HPROPSHEETPAGE.Ptr
        }
    }
    struct _Anonymous4_e__Union {
        union {
            hbmWatermark : HBITMAP
            pszbmWatermark : PWSTR
        }
    }
    struct _Anonymous5_e__Union {
        union {
            hbmHeader : HBITMAP
            pszbmHeader : PWSTR
        }
    }
}
struct LPFNSVADDPROPSHEETPAGE extends FunctionPointer {
    static Types := [HPROPSHEETPAGE, LPARAM, BOOL]
}
struct LPFNADDPROPSHEETPAGES extends FunctionPointer {
    static Types := [Struct.Ptr, LPFNSVADDPROPSHEETPAGE, LPARAM, BOOL]
}
struct PSHNOTIFY {
    hdr : NMHDR
    lParam : LPARAM
}
struct INITCOMMONCONTROLSEX {
    dwSize : UInt32
    dwICC : INITCOMMONCONTROLSEX_ICC
}
struct COLORSCHEME {
    dwSize : UInt32
    clrBtnHighlight : COLORREF
    clrBtnShadow : COLORREF
}
struct NMTOOLTIPSCREATED {
    hdr : NMHDR
    hwndToolTips : HWND
}
struct NMMOUSE {
    hdr : NMHDR
    dwItemSpec : IntPtr
    dwItemData : IntPtr
    pt : POINT
    dwHitInfo : LPARAM
}
struct NMOBJECTNOTIFY {
    hdr : NMHDR
    iItem : Int32
    piid : GUID.Ptr
    pObject : Struct.Ptr
    hResult : HRESULT
    dwFlags : UInt32
}
struct NMKEY {
    hdr : NMHDR
    nVKey : UInt32
    uFlags : UInt32
}
struct NMCHAR {
    hdr : NMHDR
    ch : UInt32
    dwItemPrev : UInt32
    dwItemNext : UInt32
}
struct NMCUSTOMTEXT {
    hdr : NMHDR
    hDC : HDC
    lpString : PWSTR
    nCount : Int32
    lpRect : RECT.Ptr
    uFormat : UInt32
    fLink : BOOL
}
struct NMCUSTOMDRAW {
    hdr : NMHDR
    dwDrawStage : NMCUSTOMDRAW_DRAW_STAGE
    hdc : HDC
    rc : RECT
    dwItemSpec : IntPtr
    uItemState : NMCUSTOMDRAW_DRAW_STATE_FLAGS
    lItemlParam : LPARAM
}
struct NMTTCUSTOMDRAW {
    nmcd : NMCUSTOMDRAW
    uDrawFlags : UInt32
}
struct NMCUSTOMSPLITRECTINFO {
    hdr : NMHDR
    rcClient : RECT
    rcButton : RECT
    rcSplit : RECT
}
struct IMAGELISTDRAWPARAMS {
    cbSize : UInt32 := this.Size
    himl : HIMAGELIST
    i : Int32
    hdcDst : HDC
    x : Int32
    y : Int32
    cx : Int32
    cy : Int32
    xBitmap : Int32
    yBitmap : Int32
    rgbBk : COLORREF
    rgbFg : COLORREF
    fStyle : UInt32
    dwRop : UInt32
    fState : UInt32
    Frame : UInt32
    crEffect : COLORREF
}
struct IMAGEINFO {
    hbmImage : HBITMAP
    hbmMask : HBITMAP
    Unused1 : Int32
    Unused2 : Int32
    rcImage : RECT
}
struct HD_TEXTFILTERA {
    pszText : PSTR
    cchTextMax : Int32
}
struct HD_TEXTFILTERW {
    pszText : PWSTR
    cchTextMax : Int32
}
struct HDITEMA {
    mask : HDI_MASK
    cxy : Int32
    pszText : PSTR
    hbm : HBITMAP
    cchTextMax : Int32
    fmt : HEADER_CONTROL_FORMAT_FLAGS
    lParam : LPARAM
    iImage : Int32
    iOrder : Int32
    type : HEADER_CONTROL_FORMAT_TYPE
    pvFilter : Struct.Ptr
    state : HEADER_CONTROL_FORMAT_STATE
}
struct HDITEMW {
    mask : HDI_MASK
    cxy : Int32
    pszText : PWSTR
    hbm : HBITMAP
    cchTextMax : Int32
    fmt : HEADER_CONTROL_FORMAT_FLAGS
    lParam : LPARAM
    iImage : Int32
    iOrder : Int32
    type : HEADER_CONTROL_FORMAT_TYPE
    pvFilter : Struct.Ptr
    state : HEADER_CONTROL_FORMAT_STATE
}
struct HDLAYOUT {
    prc : RECT.Ptr
    pwpos : WINDOWPOS.Ptr
}
struct HDHITTESTINFO {
    pt : POINT
    flags : HEADER_HITTEST_INFO_FLAGS
    iItem : Int32
}
struct NMHEADERA {
    hdr : NMHDR
    iItem : Int32
    iButton : HEADER_CONTROL_NOTIFICATION_BUTTON
    pitem : HDITEMA.Ptr
}
struct NMHEADERW {
    hdr : NMHDR
    iItem : Int32
    iButton : HEADER_CONTROL_NOTIFICATION_BUTTON
    pitem : HDITEMW.Ptr
}
struct NMHDDISPINFOW {
    hdr : NMHDR
    iItem : Int32
    mask : HDI_MASK
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
}
struct NMHDDISPINFOA {
    hdr : NMHDR
    iItem : Int32
    mask : HDI_MASK
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
}
struct NMHDFILTERBTNCLICK {
    hdr : NMHDR
    iItem : Int32
    rc : RECT
}
struct COLORMAP {
    from : COLORREF
    to : COLORREF
}
struct NMTBCUSTOMDRAW {
    nmcd : NMCUSTOMDRAW
    hbrMonoDither : HBRUSH
    hbrLines : HBRUSH
    hpenLines : HPEN
    clrText : COLORREF
    clrMark : COLORREF
    clrTextHighlight : COLORREF
    clrBtnFace : COLORREF
    clrBtnHighlight : COLORREF
    clrHighlightHotTrack : COLORREF
    rcText : RECT
    nStringBkMode : Int32
    nHLStringBkMode : Int32
    iListGap : Int32
}
struct TBADDBITMAP {
    hInst : HINSTANCE
    nID : IntPtr
}
struct TBSAVEPARAMSA {
    hkr : HKEY
    pszSubKey : PSTR
    pszValueName : PSTR
}
struct TBSAVEPARAMSW {
    hkr : HKEY
    pszSubKey : PWSTR
    pszValueName : PWSTR
}
struct TBINSERTMARK {
    iButton : Int32
    dwFlags : TBINSERTMARK_FLAGS
}
struct TBREPLACEBITMAP {
    hInstOld : HINSTANCE
    nIDOld : IntPtr
    hInstNew : HINSTANCE
    nIDNew : IntPtr
    nButtons : Int32
}
struct TBBUTTONINFOA {
    cbSize : UInt32 := this.Size
    dwMask : TBBUTTONINFOW_MASK
    idCommand : Int32
    iImage : Int32
    fsState : UInt8
    fsStyle : UInt8
    cx : UInt16
    lParam : IntPtr
    pszText : PSTR
    cchText : Int32
}
struct TBBUTTONINFOW {
    cbSize : UInt32 := this.Size
    dwMask : TBBUTTONINFOW_MASK
    idCommand : Int32
    iImage : Int32
    fsState : UInt8
    fsStyle : UInt8
    cx : UInt16
    lParam : IntPtr
    pszText : PWSTR
    cchText : Int32
}
struct TBMETRICS {
    cbSize : UInt32 := this.Size
    dwMask : UInt32
    cxPad : Int32
    cyPad : Int32
    cxBarPad : Int32
    cyBarPad : Int32
    cxButtonSpacing : Int32
    cyButtonSpacing : Int32
}
struct NMTBHOTITEM {
    hdr : NMHDR
    idOld : Int32
    idNew : Int32
    dwFlags : NMTBHOTITEM_FLAGS
}
struct NMTBSAVE {
    hdr : NMHDR
    pData : UInt32.Ptr
    pCurrent : UInt32.Ptr
    cbData : UInt32
    iItem : Int32
    cButtons : Int32
    tbButton : TBBUTTON
}
struct NMTBRESTORE {
    hdr : NMHDR
    pData : UInt32.Ptr
    pCurrent : UInt32.Ptr
    cbData : UInt32
    iItem : Int32
    cButtons : Int32
    cbBytesPerRecord : Int32
    tbButton : TBBUTTON
}
struct NMTBGETINFOTIPA {
    hdr : NMHDR
    pszText : PSTR
    cchTextMax : Int32
    iItem : Int32
    lParam : LPARAM
}
struct NMTBGETINFOTIPW {
    hdr : NMHDR
    pszText : PWSTR
    cchTextMax : Int32
    iItem : Int32
    lParam : LPARAM
}
struct NMTBDISPINFOA {
    hdr : NMHDR
    dwMask : NMTBDISPINFOW_MASK
    idCommand : Int32
    lParam : IntPtr
    iImage : Int32
    pszText : PSTR
    cchText : Int32
}
struct NMTBDISPINFOW {
    hdr : NMHDR
    dwMask : NMTBDISPINFOW_MASK
    idCommand : Int32
    lParam : IntPtr
    iImage : Int32
    pszText : PWSTR
    cchText : Int32
}
struct NMTOOLBARA {
    hdr : NMHDR
    iItem : Int32
    tbButton : TBBUTTON
    cchText : Int32
    pszText : PSTR
    rcButton : RECT
}
struct NMTOOLBARW {
    hdr : NMHDR
    iItem : Int32
    tbButton : TBBUTTON
    cchText : Int32
    pszText : PWSTR
    rcButton : RECT
}
struct REBARINFO {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    himl : HIMAGELIST
}
struct REBARBANDINFOA {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    fStyle : UInt32
    clrFore : COLORREF
    clrBack : COLORREF
    lpText : PSTR
    cch : UInt32
    iImage : Int32
    hwndChild : HWND
    cxMinChild : UInt32
    cyMinChild : UInt32
    cx : UInt32
    hbmBack : HBITMAP
    wID : UInt32
    cyChild : UInt32
    cyMaxChild : UInt32
    cyIntegral : UInt32
    cxIdeal : UInt32
    lParam : LPARAM
    cxHeader : UInt32
    rcChevronLocation : RECT
    uChevronState : UInt32
}
struct REBARBANDINFOW {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    fStyle : UInt32
    clrFore : COLORREF
    clrBack : COLORREF
    lpText : PWSTR
    cch : UInt32
    iImage : Int32
    hwndChild : HWND
    cxMinChild : UInt32
    cyMinChild : UInt32
    cx : UInt32
    hbmBack : HBITMAP
    wID : UInt32
    cyChild : UInt32
    cyMaxChild : UInt32
    cyIntegral : UInt32
    cxIdeal : UInt32
    lParam : LPARAM
    cxHeader : UInt32
    rcChevronLocation : RECT
    uChevronState : UInt32
}
struct NMREBARCHILDSIZE {
    hdr : NMHDR
    uBand : UInt32
    wID : UInt32
    rcChild : RECT
    rcBand : RECT
}
struct NMREBAR {
    hdr : NMHDR
    dwMask : NMREBAR_MASK_FLAGS
    uBand : UInt32
    fStyle : UInt32
    wID : UInt32
    lParam : LPARAM
}
struct NMRBAUTOSIZE {
    hdr : NMHDR
    fChanged : BOOL
    rcTarget : RECT
    rcActual : RECT
}
struct NMREBARCHEVRON {
    hdr : NMHDR
    uBand : UInt32
    wID : UInt32
    lParam : LPARAM
    rc : RECT
    lParamNM : LPARAM
}
struct NMREBARSPLITTER {
    hdr : NMHDR
    rcSizing : RECT
}
struct NMREBARAUTOBREAK {
    hdr : NMHDR
    uBand : UInt32
    wID : UInt32
    lParam : LPARAM
    uMsg : UInt32
    fStyleCurrent : UInt32
    fAutoBreak : BOOL
}
struct RBHITTESTINFO {
    pt : POINT
    flags : UInt32
    iBand : Int32
}
struct TTTOOLINFOA {
    cbSize : UInt32 := this.Size
    uFlags : TOOLTIP_FLAGS
    hwnd : HWND
    uId : IntPtr
    rect : RECT
    hinst : HINSTANCE
    lpszText : PSTR
    lParam : LPARAM
    lpReserved : Struct.Ptr
}
struct TTTOOLINFOW {
    cbSize : UInt32 := this.Size
    uFlags : TOOLTIP_FLAGS
    hwnd : HWND
    uId : IntPtr
    rect : RECT
    hinst : HINSTANCE
    lpszText : PWSTR
    lParam : LPARAM
    lpReserved : Struct.Ptr
}
struct TTGETTITLE {
    dwSize : UInt32
    uTitleBitmap : UInt32
    cch : UInt32
    pszTitle : PWSTR
}
struct TTHITTESTINFOA {
    hwnd : HWND
    pt : POINT
    ti : TTTOOLINFOA
}
struct TTHITTESTINFOW {
    hwnd : HWND
    pt : POINT
    ti : TTTOOLINFOW
}
struct NMTTDISPINFOA {
    hdr : NMHDR
    lpszText : PSTR
    szText : CHAR[80]
    hinst : HINSTANCE
    uFlags : TOOLTIP_FLAGS
    lParam : LPARAM
}
struct NMTTDISPINFOW {
    hdr : NMHDR
    lpszText : PWSTR
    szText : UInt16[80]
    hinst : HINSTANCE
    uFlags : TOOLTIP_FLAGS
    lParam : LPARAM
}
struct NMTRBTHUMBPOSCHANGING {
    hdr : NMHDR
    dwPos : UInt32
    nReason : Int32
}
struct DRAGLISTINFO {
    uNotification : DRAGLISTINFO_NOTIFICATION_FLAGS
    hWnd : HWND
    ptCursor : POINT
}
struct UDACCEL {
    nSec : UInt32
    nInc : UInt32
}
struct NMUPDOWN {
    hdr : NMHDR
    iPos : Int32
    iDelta : Int32
}
struct PBRANGE {
    iLow : Int32
    iHigh : Int32
}
struct LITEM {
    mask : LIST_ITEM_FLAGS
    iLink : Int32
    state : LIST_ITEM_STATE_FLAGS
    stateMask : LIST_ITEM_STATE_FLAGS
    szID : UInt16[48]
    szUrl : UInt16[2084]
}
struct LHITTESTINFO {
    pt : POINT
    item : LITEM
}
struct NMLINK {
    hdr : NMHDR
    item : LITEM
}
struct LVITEMA {
    mask : LIST_VIEW_ITEM_FLAGS
    iItem : Int32
    iSubItem : Int32
    state : LIST_VIEW_ITEM_STATE_FLAGS
    stateMask : LIST_VIEW_ITEM_STATE_FLAGS
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
    iIndent : Int32
    iGroupId : Int32
    cColumns : UInt32
    puColumns : UInt32.Ptr
    piColFmt : LIST_VIEW_ITEM_COLUMN_FORMAT_FLAGS.Ptr
    iGroup : Int32
}
struct LVITEMW {
    mask : LIST_VIEW_ITEM_FLAGS
    iItem : Int32
    iSubItem : Int32
    state : LIST_VIEW_ITEM_STATE_FLAGS
    stateMask : LIST_VIEW_ITEM_STATE_FLAGS
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
    iIndent : Int32
    iGroupId : Int32
    cColumns : UInt32
    puColumns : UInt32.Ptr
    piColFmt : LIST_VIEW_ITEM_COLUMN_FORMAT_FLAGS.Ptr
    iGroup : Int32
}
struct LVFINDINFOA {
    flags : LVFINDINFOW_FLAGS
    psz : PSTR
    lParam : LPARAM
    pt : POINT
    vkDirection : UInt32
}
struct LVFINDINFOW {
    flags : LVFINDINFOW_FLAGS
    psz : PWSTR
    lParam : LPARAM
    pt : POINT
    vkDirection : UInt32
}
struct LVHITTESTINFO {
    pt : POINT
    flags : LVHITTESTINFO_FLAGS
    iItem : Int32
    iSubItem : Int32
    iGroup : Int32
}
struct LVCOLUMNA {
    mask : LVCOLUMNW_MASK
    fmt : LVCOLUMNW_FORMAT
    cx : Int32
    pszText : PSTR
    cchTextMax : Int32
    iSubItem : Int32
    iImage : Int32
    iOrder : Int32
    cxMin : Int32
    cxDefault : Int32
    cxIdeal : Int32
}
struct LVCOLUMNW {
    mask : LVCOLUMNW_MASK
    fmt : LVCOLUMNW_FORMAT
    cx : Int32
    pszText : PWSTR
    cchTextMax : Int32
    iSubItem : Int32
    iImage : Int32
    iOrder : Int32
    cxMin : Int32
    cxDefault : Int32
    cxIdeal : Int32
}
struct PFNLVCOMPARE extends FunctionPointer {
    static Types := [LPARAM, LPARAM, LPARAM, Int32]
}
struct LVBKIMAGEA {
    ulFlags : LIST_VIEW_BACKGROUND_IMAGE_FLAGS
    hbm : HBITMAP
    pszImage : PSTR
    cchImageMax : UInt32
    xOffsetPercent : Int32
    yOffsetPercent : Int32
}
struct LVBKIMAGEW {
    ulFlags : LIST_VIEW_BACKGROUND_IMAGE_FLAGS
    hbm : HBITMAP
    pszImage : PWSTR
    cchImageMax : UInt32
    xOffsetPercent : Int32
    yOffsetPercent : Int32
}
struct LVGROUP {
    cbSize : UInt32 := this.Size
    mask : LVGROUP_MASK
    pszHeader : PWSTR
    cchHeader : Int32
    pszFooter : PWSTR
    cchFooter : Int32
    iGroupId : Int32
    stateMask : LIST_VIEW_GROUP_STATE_FLAGS
    state : LIST_VIEW_GROUP_STATE_FLAGS
    uAlign : LIST_VIEW_GROUP_ALIGN_FLAGS
    pszSubtitle : PWSTR
    cchSubtitle : UInt32
    pszTask : PWSTR
    cchTask : UInt32
    pszDescriptionTop : PWSTR
    cchDescriptionTop : UInt32
    pszDescriptionBottom : PWSTR
    cchDescriptionBottom : UInt32
    iTitleImage : Int32
    iExtendedImage : Int32
    iFirstItem : Int32
    cItems : UInt32
    pszSubsetTitle : PWSTR
    cchSubsetTitle : UInt32
}
struct LVGROUPMETRICS {
    cbSize : UInt32 := this.Size
    mask : UInt32
    Left : UInt32
    Top : UInt32
    Right : UInt32
    Bottom : UInt32
    crLeft : COLORREF
    crTop : COLORREF
    crRight : COLORREF
    crBottom : COLORREF
    crHeader : COLORREF
    crFooter : COLORREF
}
struct PFNLVGROUPCOMPARE extends FunctionPointer {
    static Types := [Int32, Int32, Struct.Ptr, Int32]
}
struct LVINSERTGROUPSORTED {
    pfnGroupCompare : PFNLVGROUPCOMPARE
    pvData : Struct.Ptr
    lvGroup : LVGROUP
}
struct LVTILEVIEWINFO {
    cbSize : UInt32 := this.Size
    dwMask : LVTILEVIEWINFO_MASK
    dwFlags : LVTILEVIEWINFO_FLAGS
    sizeTile : SIZE
    cLines : Int32
    rcLabelMargin : RECT
}
struct LVTILEINFO {
    cbSize : UInt32 := this.Size
    iItem : Int32
    cColumns : UInt32
    puColumns : UInt32.Ptr
    piColFmt : Int32.Ptr
}
struct LVINSERTMARK {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    iItem : Int32
    dwReserved : UInt32
}
struct LVSETINFOTIP {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    pszText : PWSTR
    iItem : Int32
    iSubItem : Int32
}
struct LVFOOTERINFO {
    mask : UInt32
    pszText : PWSTR
    cchTextMax : Int32
    cItems : UInt32
}
struct LVFOOTERITEM {
    mask : LVFOOTERITEM_MASK
    iItem : Int32
    pszText : PWSTR
    cchTextMax : Int32
    state : UInt32
    stateMask : UInt32
}
struct LVITEMINDEX {
    iItem : Int32
    iGroup : Int32
}
struct NMLISTVIEW {
    hdr : NMHDR
    iItem : Int32
    iSubItem : Int32
    uNewState : UInt32
    uOldState : UInt32
    uChanged : LIST_VIEW_ITEM_FLAGS
    ptAction : POINT
    lParam : LPARAM
}
struct NMITEMACTIVATE {
    hdr : NMHDR
    iItem : Int32
    iSubItem : Int32
    uNewState : UInt32
    uOldState : UInt32
    uChanged : UInt32
    ptAction : POINT
    lParam : LPARAM
    uKeyFlags : UInt32
}
struct NMLVCUSTOMDRAW {
    nmcd : NMCUSTOMDRAW
    clrText : COLORREF
    clrTextBk : COLORREF
    iSubItem : Int32
    dwItemType : NMLVCUSTOMDRAW_ITEM_TYPE
    clrFace : COLORREF
    iIconEffect : Int32
    iIconPhase : Int32
    iPartId : Int32
    iStateId : Int32
    rcText : RECT
    uAlign : LIST_VIEW_GROUP_ALIGN_FLAGS
}
struct NMLVCACHEHINT {
    hdr : NMHDR
    iFrom : Int32
    iTo : Int32
}
struct NMLVFINDITEMA {
    hdr : NMHDR
    iStart : Int32
    lvfi : LVFINDINFOA
}
struct NMLVFINDITEMW {
    hdr : NMHDR
    iStart : Int32
    lvfi : LVFINDINFOW
}
struct NMLVODSTATECHANGE {
    hdr : NMHDR
    iFrom : Int32
    iTo : Int32
    uNewState : LIST_VIEW_ITEM_STATE_FLAGS
    uOldState : LIST_VIEW_ITEM_STATE_FLAGS
}
struct NMLVDISPINFOA {
    hdr : NMHDR
    item : LVITEMA
}
struct NMLVDISPINFOW {
    hdr : NMHDR
    item : LVITEMW
}
struct NMLVKEYDOWN {
    hdr : NMHDR
    wVKey : UInt16
    flags : UInt32
}
struct NMLVLINK {
    hdr : NMHDR
    link : LITEM
    iItem : Int32
    iSubItem : Int32
}
struct NMLVGETINFOTIPA {
    hdr : NMHDR
    dwFlags : NMLVGETINFOTIP_FLAGS
    pszText : PSTR
    cchTextMax : Int32
    iItem : Int32
    iSubItem : Int32
    lParam : LPARAM
}
struct NMLVGETINFOTIPW {
    hdr : NMHDR
    dwFlags : NMLVGETINFOTIP_FLAGS
    pszText : PWSTR
    cchTextMax : Int32
    iItem : Int32
    iSubItem : Int32
    lParam : LPARAM
}
struct NMLVSCROLL {
    hdr : NMHDR
    dx : Int32
    dy : Int32
}
struct NMLVEMPTYMARKUP {
    hdr : NMHDR
    dwFlags : NMLVEMPTYMARKUP_FLAGS
    szMarkup : UInt16[2084]
}
struct NMTVSTATEIMAGECHANGING {
    hdr : NMHDR
    hti : HTREEITEM
    iOldStateImageIndex : Int32
    iNewStateImageIndex : Int32
}
struct TVITEMA {
    mask : TVITEM_MASK
    hItem : HTREEITEM
    state : TREE_VIEW_ITEM_STATE_FLAGS
    stateMask : TREE_VIEW_ITEM_STATE_FLAGS
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    cChildren : TVITEMEXW_CHILDREN
    lParam : LPARAM
}
struct TVITEMW {
    mask : TVITEM_MASK
    hItem : HTREEITEM
    state : TREE_VIEW_ITEM_STATE_FLAGS
    stateMask : TREE_VIEW_ITEM_STATE_FLAGS
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    cChildren : TVITEMEXW_CHILDREN
    lParam : LPARAM
}
struct TVITEMEXA {
    mask : TVITEM_MASK
    hItem : HTREEITEM
    state : UInt32
    stateMask : UInt32
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    cChildren : TVITEMEXW_CHILDREN
    lParam : LPARAM
    iIntegral : Int32
    uStateEx : UInt32
    hwnd : HWND
    iExpandedImage : Int32
    iReserved : Int32
}
struct TVITEMEXW {
    mask : TVITEM_MASK
    hItem : HTREEITEM
    state : UInt32
    stateMask : UInt32
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    cChildren : TVITEMEXW_CHILDREN
    lParam : LPARAM
    iIntegral : Int32
    uStateEx : UInt32
    hwnd : HWND
    iExpandedImage : Int32
    iReserved : Int32
}
struct TVINSERTSTRUCTA {
    hParent : HTREEITEM
    hInsertAfter : HTREEITEM
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            itemex : TVITEMEXA
            item : TVITEMA
        }
    }
}
struct TVINSERTSTRUCTW {
    hParent : HTREEITEM
    hInsertAfter : HTREEITEM
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            itemex : TVITEMEXW
            item : TVITEMW
        }
    }
}
struct TVHITTESTINFO {
    pt : POINT
    flags : TVHITTESTINFO_FLAGS
    hItem : HTREEITEM
}
struct TVITEMPART extends Int32 {
    static TVGIPR_BUTTON := 1
}
struct TVGETITEMPARTRECTINFO {
    hti : HTREEITEM
    prc : RECT.Ptr
    partID : TVITEMPART
}
struct PFNTVCOMPARE extends FunctionPointer {
    static Types := [LPARAM, LPARAM, LPARAM, Int32]
}
struct TVSORTCB {
    hParent : HTREEITEM
    lpfnCompare : PFNTVCOMPARE
    lParam : LPARAM
}
struct NMTREEVIEWA {
    hdr : NMHDR
    action : NM_TREEVIEW_ACTION
    itemOld : TVITEMA
    itemNew : TVITEMA
    ptDrag : POINT
}
struct NMTREEVIEWW {
    hdr : NMHDR
    action : NM_TREEVIEW_ACTION
    itemOld : TVITEMW
    itemNew : TVITEMW
    ptDrag : POINT
}
struct NMTVDISPINFOA {
    hdr : NMHDR
    item : TVITEMA
}
struct NMTVDISPINFOW {
    hdr : NMHDR
    item : TVITEMW
}
struct NMTVDISPINFOEXA {
    hdr : NMHDR
    item : TVITEMEXA
}
struct NMTVDISPINFOEXW {
    hdr : NMHDR
    item : TVITEMEXW
}
struct NMTVKEYDOWN {
    hdr : NMHDR
    wVKey : UInt16
    flags : UInt32
}
struct NMTVCUSTOMDRAW {
    nmcd : NMCUSTOMDRAW
    clrText : COLORREF
    clrTextBk : COLORREF
    iLevel : Int32
}
struct NMTVGETINFOTIPA {
    hdr : NMHDR
    pszText : PSTR
    cchTextMax : Int32
    hItem : HTREEITEM
    lParam : LPARAM
}
struct NMTVGETINFOTIPW {
    hdr : NMHDR
    pszText : PWSTR
    cchTextMax : Int32
    hItem : HTREEITEM
    lParam : LPARAM
}
struct NMTVITEMCHANGE {
    hdr : NMHDR
    uChanged : UInt32
    hItem : HTREEITEM
    uStateNew : UInt32
    uStateOld : UInt32
    lParam : LPARAM
}
struct NMTVASYNCDRAW {
    hdr : NMHDR
    pimldp : IMAGELISTDRAWPARAMS.Ptr
    hr : HRESULT
    hItem : HTREEITEM
    lParam : LPARAM
    dwRetFlags : UInt32
    iRetImageIndex : Int32
}
struct COMBOBOXEXITEMA {
    mask : COMBOBOX_EX_ITEM_FLAGS
    iItem : IntPtr
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    iOverlay : Int32
    iIndent : Int32
    lParam : LPARAM
}
struct COMBOBOXEXITEMW {
    mask : COMBOBOX_EX_ITEM_FLAGS
    iItem : IntPtr
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    iSelectedImage : Int32
    iOverlay : Int32
    iIndent : Int32
    lParam : LPARAM
}
struct NMCOMBOBOXEXA {
    hdr : NMHDR
    ceItem : COMBOBOXEXITEMA
}
struct NMCOMBOBOXEXW {
    hdr : NMHDR
    ceItem : COMBOBOXEXITEMW
}
struct NMCBEDRAGBEGINW {
    hdr : NMHDR
    iItemid : Int32
    szText : UInt16[260]
}
struct NMCBEDRAGBEGINA {
    hdr : NMHDR
    iItemid : Int32
    szText : CHAR[260]
}
struct NMCBEENDEDITW {
    hdr : NMHDR
    fChanged : BOOL
    iNewSelection : Int32
    szText : UInt16[260]
    iWhy : Int32
}
struct NMCBEENDEDITA {
    hdr : NMHDR
    fChanged : BOOL
    iNewSelection : Int32
    szText : CHAR[260]
    iWhy : Int32
}
struct TCITEMHEADERA {
    mask : TCITEMHEADERA_MASK
    lpReserved1 : UInt32
    lpReserved2 : UInt32
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
}
struct TCITEMHEADERW {
    mask : TCITEMHEADERA_MASK
    lpReserved1 : UInt32
    lpReserved2 : UInt32
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
}
struct TCITEMA {
    mask : TCITEMHEADERA_MASK
    dwState : TAB_CONTROL_ITEM_STATE
    dwStateMask : TAB_CONTROL_ITEM_STATE
    pszText : PSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
}
struct TCITEMW {
    mask : TCITEMHEADERA_MASK
    dwState : TAB_CONTROL_ITEM_STATE
    dwStateMask : TAB_CONTROL_ITEM_STATE
    pszText : PWSTR
    cchTextMax : Int32
    iImage : Int32
    lParam : LPARAM
}
struct TCHITTESTINFO {
    pt : POINT
    flags : TCHITTESTINFO_FLAGS
}
struct NMTCKEYDOWN {
    hdr : NMHDR
    wVKey : UInt16
    flags : UInt32
}
struct MCHITTESTINFO {
    cbSize : UInt32 := this.Size
    pt : POINT
    uHit : MCHITTESTINFO_HIT_FLAGS
    st : SYSTEMTIME
    rc : RECT
    iOffset : Int32
    iRow : Int32
    iCol : Int32
}
struct MCGRIDINFO {
    cbSize : UInt32 := this.Size
    dwPart : MCGRIDINFO_PART
    dwFlags : MCGRIDINFO_FLAGS
    iCalendar : Int32
    iRow : Int32
    iCol : Int32
    bSelected : BOOL
    stStart : SYSTEMTIME
    stEnd : SYSTEMTIME
    rc : RECT
    pszName : PWSTR
    cchName : IntPtr
}
struct NMSELCHANGE {
    nmhdr : NMHDR
    stSelStart : SYSTEMTIME
    stSelEnd : SYSTEMTIME
}
struct NMDAYSTATE {
    nmhdr : NMHDR
    stStart : SYSTEMTIME
    cDayState : Int32
    prgDayState : UInt32.Ptr
}
struct NMVIEWCHANGE {
    nmhdr : NMHDR
    dwOldView : MONTH_CALDENDAR_MESSAGES_VIEW
    dwNewView : MONTH_CALDENDAR_MESSAGES_VIEW
}
struct DATETIMEPICKERINFO {
    cbSize : UInt32 := this.Size
    rcCheck : RECT
    stateCheck : UInt32
    rcButton : RECT
    stateButton : UInt32
    hwndEdit : HWND
    hwndUD : HWND
    hwndDropDown : HWND
}
struct NMDATETIMECHANGE {
    nmhdr : NMHDR
    dwFlags : NMDATETIMECHANGE_FLAGS
    st : SYSTEMTIME
}
struct NMDATETIMESTRINGA {
    nmhdr : NMHDR
    pszUserString : PSTR
    st : SYSTEMTIME
    dwFlags : UInt32
}
struct NMDATETIMESTRINGW {
    nmhdr : NMHDR
    pszUserString : PWSTR
    st : SYSTEMTIME
    dwFlags : UInt32
}
struct NMDATETIMEWMKEYDOWNA {
    nmhdr : NMHDR
    nVirtKey : Int32
    pszFormat : PSTR
    st : SYSTEMTIME
}
struct NMDATETIMEWMKEYDOWNW {
    nmhdr : NMHDR
    nVirtKey : Int32
    pszFormat : PWSTR
    st : SYSTEMTIME
}
struct NMDATETIMEFORMATA {
    nmhdr : NMHDR
    pszFormat : PSTR
    st : SYSTEMTIME
    pszDisplay : PSTR
    szDisplay : CHAR[64]
}
struct NMDATETIMEFORMATW {
    nmhdr : NMHDR
    pszFormat : PWSTR
    st : SYSTEMTIME
    pszDisplay : PWSTR
    szDisplay : UInt16[64]
}
struct NMDATETIMEFORMATQUERYA {
    nmhdr : NMHDR
    pszFormat : PSTR
    szMax : SIZE
}
struct NMDATETIMEFORMATQUERYW {
    nmhdr : NMHDR
    pszFormat : PWSTR
    szMax : SIZE
}
struct NMIPADDRESS {
    hdr : NMHDR
    iField : Int32
    iValue : Int32
}
struct NMPGSCROLL {
    hdr : NMHDR
    fwKeys : NMPGSCROLL_KEYS
    rcParent : RECT
    iDir : NMPGSCROLL_DIR
    iXpos : Int32
    iYpos : Int32
    iScroll : Int32
}
struct NMPGCALCSIZE {
    hdr : NMHDR
    dwFlag : NMPGCALCSIZE_FLAGS
    iWidth : Int32
    iHeight : Int32
}
struct NMPGHOTITEM {
    hdr : NMHDR
    idOld : Int32
    idNew : Int32
    dwFlags : UInt32
}
struct BUTTON_IMAGELIST {
    himl : HIMAGELIST
    margin : RECT
    uAlign : BUTTON_IMAGELIST_ALIGN
}
struct NMBCHOTITEM {
    hdr : NMHDR
    dwFlags : NMTBHOTITEM_FLAGS
}
struct BUTTON_SPLITINFO {
    mask : UInt32
    himlGlyph : HIMAGELIST
    uSplitStyle : UInt32
    size : SIZE
}
struct NMBCDROPDOWN {
    hdr : NMHDR
    rcButton : RECT
}
struct EDITBALLOONTIP {
    cbStruct : UInt32
    pszTitle : PWSTR
    pszText : PWSTR
    ttiIcon : EDITBALLOONTIP_ICON
}
struct EC_ENDOFLINE extends Int32 {
    static EC_ENDOFLINE_DETECTFROMCONTENT := 0
    static EC_ENDOFLINE_CRLF := 1
    static EC_ENDOFLINE_CR := 2
    static EC_ENDOFLINE_LF := 3
}
struct EC_SEARCHWEB_ENTRYPOINT extends Int32 {
    static EC_SEARCHWEB_ENTRYPOINT_EXTERNAL := 0
    static EC_SEARCHWEB_ENTRYPOINT_CONTEXTMENU := 1
}
struct NMSEARCHWEB {
    hdr : NMHDR
    entrypoint : EC_SEARCHWEB_ENTRYPOINT
    hasQueryText : BOOL
    invokeSucceeded : BOOL
}
struct PFTASKDIALOGCALLBACK extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr, HRESULT]
}
struct TASKDIALOG_FLAGS extends Int32 {
    static TDF_ENABLE_HYPERLINKS := 1
    static TDF_USE_HICON_MAIN := 2
    static TDF_USE_HICON_FOOTER := 4
    static TDF_ALLOW_DIALOG_CANCELLATION := 8
    static TDF_USE_COMMAND_LINKS := 16
    static TDF_USE_COMMAND_LINKS_NO_ICON := 32
    static TDF_EXPAND_FOOTER_AREA := 64
    static TDF_EXPANDED_BY_DEFAULT := 128
    static TDF_VERIFICATION_FLAG_CHECKED := 256
    static TDF_SHOW_PROGRESS_BAR := 512
    static TDF_SHOW_MARQUEE_PROGRESS_BAR := 1024
    static TDF_CALLBACK_TIMER := 2048
    static TDF_POSITION_RELATIVE_TO_WINDOW := 4096
    static TDF_RTL_LAYOUT := 8192
    static TDF_NO_DEFAULT_RADIO_BUTTON := 16384
    static TDF_CAN_BE_MINIMIZED := 32768
    static TDF_NO_SET_FOREGROUND := 65536
    static TDF_SIZE_TO_CONTENT := 16777216
}
struct TASKDIALOG_MESSAGES extends Int32 {
    static TDM_NAVIGATE_PAGE := 1125
    static TDM_CLICK_BUTTON := 1126
    static TDM_SET_MARQUEE_PROGRESS_BAR := 1127
    static TDM_SET_PROGRESS_BAR_STATE := 1128
    static TDM_SET_PROGRESS_BAR_RANGE := 1129
    static TDM_SET_PROGRESS_BAR_POS := 1130
    static TDM_SET_PROGRESS_BAR_MARQUEE := 1131
    static TDM_SET_ELEMENT_TEXT := 1132
    static TDM_CLICK_RADIO_BUTTON := 1134
    static TDM_ENABLE_BUTTON := 1135
    static TDM_ENABLE_RADIO_BUTTON := 1136
    static TDM_CLICK_VERIFICATION := 1137
    static TDM_UPDATE_ELEMENT_TEXT := 1138
    static TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE := 1139
    static TDM_UPDATE_ICON := 1140
}
struct TASKDIALOG_NOTIFICATIONS extends Int32 {
    static TDN_CREATED := 0
    static TDN_NAVIGATED := 1
    static TDN_BUTTON_CLICKED := 2
    static TDN_HYPERLINK_CLICKED := 3
    static TDN_TIMER := 4
    static TDN_DESTROYED := 5
    static TDN_RADIO_BUTTON_CLICKED := 6
    static TDN_DIALOG_CONSTRUCTED := 7
    static TDN_VERIFICATION_CLICKED := 8
    static TDN_HELP := 9
    static TDN_EXPANDO_BUTTON_CLICKED := 10
}
struct TASKDIALOG_BUTTON {
    nButtonID : Int32
    pszButtonText : PWSTR
}
struct TASKDIALOG_ELEMENTS extends Int32 {
    static TDE_CONTENT := 0
    static TDE_EXPANDED_INFORMATION := 1
    static TDE_FOOTER := 2
    static TDE_MAIN_INSTRUCTION := 3
}
struct TASKDIALOG_ICON_ELEMENTS extends Int32 {
    static TDIE_ICON_MAIN := 0
    static TDIE_ICON_FOOTER := 1
}
struct TASKDIALOGCONFIG {
    cbSize : UInt32 := this.Size
    hwndParent : HWND
    hInstance : HINSTANCE
    dwFlags : TASKDIALOG_FLAGS
    dwCommonButtons : TASKDIALOG_COMMON_BUTTON_FLAGS
    pszWindowTitle : PWSTR
    Anonymous1 : this._Anonymous1_e__Union
    pszMainInstruction : PWSTR
    pszContent : PWSTR
    cButtons : UInt32
    pButtons : TASKDIALOG_BUTTON.Ptr
    nDefaultButton : Int32
    cRadioButtons : UInt32
    pRadioButtons : TASKDIALOG_BUTTON.Ptr
    nDefaultRadioButton : Int32
    pszVerificationText : PWSTR
    pszExpandedInformation : PWSTR
    pszExpandedControlText : PWSTR
    pszCollapsedControlText : PWSTR
    Anonymous2 : this._Anonymous2_e__Union
    pszFooter : PWSTR
    pfCallback : PFTASKDIALOGCALLBACK
    lpCallbackData : IntPtr
    cxWidth : UInt32
    struct _Anonymous1_e__Union {
        union {
            hMainIcon : HICON
            pszMainIcon : PWSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hFooterIcon : HICON
            pszFooterIcon : PWSTR
        }
    }
}
struct PFNDAENUMCALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, Int32]
}
struct PFNDAENUMCALLBACKCONST extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, Int32]
}
struct PFNDACOMPARE extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, LPARAM, Int32]
}
struct PFNDACOMPARECONST extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, LPARAM, Int32]
}
struct DPASTREAMINFO {
    iPos : Int32
    pvItem : Struct.Ptr
}
struct PFNDPASTREAM extends FunctionPointer {
    static Types := [DPASTREAMINFO.Ptr, IStream, Struct.Ptr, HRESULT]
}
struct PFNDPAMERGE extends FunctionPointer {
    static Types := [DPAMM_MESSAGE, Struct.Ptr, Struct.Ptr, LPARAM, Struct.Ptr]
}
struct PFNDPAMERGECONST extends FunctionPointer {
    static Types := [DPAMM_MESSAGE, Struct.Ptr, Struct.Ptr, LPARAM, Struct.Ptr]
}
struct LI_METRIC extends Int32 {
    static LIM_SMALL := 0
    static LIM_LARGE := 1
}
struct IImageList extends IUnknown {
    static IID := "{46EB5926-582E-4017-9FDF-E8998DAA0950}"
    Add(hbmImage, hbmMask?, pi)
      => ComCall(3, this.p, HBITMAP, hbmImage, HBITMAP, hbmMask?, Int32.Ptr, pi)
    ReplaceIcon(i, hicon1, pi)
      => ComCall(4, this.p, Int32, i, HICON, hicon1, Int32.Ptr, pi)
    SetOverlayImage(iImage, iOverlay)
      => ComCall(5, this.p, Int32, iImage, Int32, iOverlay)
    Replace(i, hbmImage, hbmMask?)
      => ComCall(6, this.p, Int32, i, HBITMAP, hbmImage, HBITMAP, hbmMask?)
    AddMasked(hbmImage, crMask, pi)
      => ComCall(7, this.p, HBITMAP, hbmImage, COLORREF, crMask, Int32.Ptr, pi)
    Draw(pimldp)
      => ComCall(8, this.p, IMAGELISTDRAWPARAMS.Ptr, pimldp)
    Remove(i)
      => ComCall(9, this.p, Int32, i)
    GetIcon(i, flags, picon)
      => ComCall(10, this.p, Int32, i, UInt32, flags, HICON.Ptr, picon)
    GetImageInfo(i, pImageInfo)
      => ComCall(11, this.p, Int32, i, IMAGEINFO.Ptr, pImageInfo)
    Copy(iDst, punkSrc, iSrc, uFlags)
      => ComCall(12, this.p, Int32, iDst, IUnknown, punkSrc, Int32, iSrc, UInt32, uFlags)
    Merge(i1, punk2, i2, dx, dy, riid, ppv)
      => ComCall(13, this.p, Int32, i1, IUnknown, punk2, Int32, i2, Int32, dx, Int32, dy, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Clone(riid, ppv)
      => ComCall(14, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetImageRect(i, prc)
      => ComCall(15, this.p, Int32, i, RECT.Ptr, prc)
    GetIconSize(cx, cy)
      => ComCall(16, this.p, Int32.Ptr, cx, Int32.Ptr, cy)
    SetIconSize(cx, cy)
      => ComCall(17, this.p, Int32, cx, Int32, cy)
    GetImageCount(pi)
      => ComCall(18, this.p, Int32.Ptr, pi)
    SetImageCount(uNewCount)
      => ComCall(19, this.p, UInt32, uNewCount)
    SetBkColor(clrBk, pclr)
      => ComCall(20, this.p, COLORREF, clrBk, COLORREF.Ptr, pclr)
    GetBkColor(pclr)
      => ComCall(21, this.p, COLORREF.Ptr, pclr)
    BeginDrag(iTrack, dxHotspot, dyHotspot)
      => ComCall(22, this.p, Int32, iTrack, Int32, dxHotspot, Int32, dyHotspot)
    EndDrag()
      => ComCall(23, this.p)
    DragEnter(hwndLock?, x, y)
      => ComCall(24, this.p, HWND, hwndLock?, Int32, x, Int32, y)
    DragLeave(hwndLock?)
      => ComCall(25, this.p, HWND, hwndLock?)
    DragMove(x, y)
      => ComCall(26, this.p, Int32, x, Int32, y)
    SetDragCursorImage(punk, iDrag, dxHotspot, dyHotspot)
      => ComCall(27, this.p, IUnknown, punk, Int32, iDrag, Int32, dxHotspot, Int32, dyHotspot)
    DragShowNolock(fShow)
      => ComCall(28, this.p, BOOL, fShow)
    GetDragImage(ppt?, pptHotspot?, riid, ppv)
      => ComCall(29, this.p, POINT.Ptr, ppt?, POINT.Ptr, pptHotspot?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetItemFlags(i, dwFlags)
      => ComCall(30, this.p, Int32, i, IMAGE_LIST_ITEM_FLAGS.Ptr, dwFlags)
    GetOverlayImage(iOverlay, piIndex)
      => ComCall(31, this.p, Int32, iOverlay, Int32.Ptr, piIndex)
}
struct IMAGELISTSTATS {
    cbSize : UInt32 := this.Size
    cAlloc : Int32
    cUsed : Int32
    cStandby : Int32
}
struct IImageList2 extends IImageList {
    static IID := "{192B9D83-50FC-457B-90A0-2B82A8B5DAE1}"
    Resize(cxNewIconSize, cyNewIconSize)
      => ComCall(32, this.p, Int32, cxNewIconSize, Int32, cyNewIconSize)
    GetOriginalSize(iImage, dwFlags, pcx, pcy)
      => ComCall(33, this.p, Int32, iImage, UInt32, dwFlags, Int32.Ptr, pcx, Int32.Ptr, pcy)
    SetOriginalSize(iImage, cx, cy)
      => ComCall(34, this.p, Int32, iImage, Int32, cx, Int32, cy)
    SetCallback(punk?)
      => ComCall(35, this.p, IUnknown, punk?)
    GetCallback(riid, ppv)
      => ComCall(36, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ForceImagePresent(iImage, dwFlags)
      => ComCall(37, this.p, Int32, iImage, UInt32, dwFlags)
    DiscardImages(iFirstImage, iLastImage, dwFlags)
      => ComCall(38, this.p, Int32, iFirstImage, Int32, iLastImage, UInt32, dwFlags)
    PreloadImages(pimldp)
      => ComCall(39, this.p, IMAGELISTDRAWPARAMS.Ptr, pimldp)
    GetStatistics(pils)
      => ComCall(40, this.p, IMAGELISTSTATS.Ptr, pils)
    Initialize(cx, cy, flags, cInitial, cGrow)
      => ComCall(41, this.p, Int32, cx, Int32, cy, IMAGELIST_CREATION_FLAGS, flags, Int32, cInitial, Int32, cGrow)
    Replace2(i, hbmImage, hbmMask?, punk?, dwFlags)
      => ComCall(42, this.p, Int32, i, HBITMAP, hbmImage, HBITMAP, hbmMask?, IUnknown, punk?, UInt32, dwFlags)
    ReplaceFromImageList(i, pil, iSrc, punk?, dwFlags)
      => ComCall(43, this.p, Int32, i, IImageList, pil, Int32, iSrc, IUnknown, punk?, UInt32, dwFlags)
}
struct TA_PROPERTY extends Int32 {
    static TAP_FLAGS := 0
    static TAP_TRANSFORMCOUNT := 1
    static TAP_STAGGERDELAY := 2
    static TAP_STAGGERDELAYCAP := 3
    static TAP_STAGGERDELAYFACTOR := 4
    static TAP_ZORDER := 5
}
struct TA_PROPERTY_FLAG extends Int32 {
    static TAPF_NONE := 0
    static TAPF_HASSTAGGER := 1
    static TAPF_ISRTLAWARE := 2
    static TAPF_ALLOWCOLLECTION := 4
    static TAPF_HASBACKGROUND := 8
    static TAPF_HASPERSPECTIVE := 16
}
struct TA_TRANSFORM_TYPE extends Int32 {
    static TATT_TRANSLATE_2D := 0
    static TATT_SCALE_2D := 1
    static TATT_OPACITY := 2
    static TATT_CLIP := 3
}
struct TA_TRANSFORM_FLAG extends Int32 {
    static TATF_NONE := 0
    static TATF_TARGETVALUES_USER := 1
    static TATF_HASINITIALVALUES := 2
    static TATF_HASORIGINVALUES := 4
}
struct TA_TRANSFORM {
    eTransformType : TA_TRANSFORM_TYPE
    dwTimingFunctionId : UInt32
    dwStartTime : UInt32
    dwDurationTime : UInt32
    eFlags : TA_TRANSFORM_FLAG
}
struct TA_TRANSFORM_2D {
    header : TA_TRANSFORM
    rX : Float32
    rY : Float32
    rInitialX : Float32
    rInitialY : Float32
    rOriginX : Float32
    rOriginY : Float32
}
struct TA_TRANSFORM_OPACITY {
    header : TA_TRANSFORM
    rOpacity : Float32
    rInitialOpacity : Float32
}
struct TA_TRANSFORM_CLIP {
    header : TA_TRANSFORM
    rLeft : Float32
    rTop : Float32
    rRight : Float32
    rBottom : Float32
    rInitialLeft : Float32
    rInitialTop : Float32
    rInitialRight : Float32
    rInitialBottom : Float32
}
struct TA_TIMINGFUNCTION_TYPE extends Int32 {
    static TTFT_UNDEFINED := 0
    static TTFT_CUBIC_BEZIER := 1
}
struct TA_TIMINGFUNCTION {
    eTimingFunctionType : TA_TIMINGFUNCTION_TYPE
}
struct TA_CUBIC_BEZIER {
    header : TA_TIMINGFUNCTION
    rX0 : Float32
    rY0 : Float32
    rX1 : Float32
    rY1 : Float32
}
struct DTBGOPTS {
    dwSize : UInt32
    dwFlags : UInt32
    rcClip : RECT
}
struct THEMESIZE extends Int32 {
    static TS_MIN := 0
    static TS_TRUE := 1
    static TS_DRAW := 2
}
struct MARGINS {
    cxLeftWidth : Int32
    cxRightWidth : Int32
    cyTopHeight : Int32
    cyBottomHeight : Int32
}
struct INTLIST {
    iValueCount : Int32
    iValues : Int32[402]
}
struct PROPERTYORIGIN extends Int32 {
    static PO_STATE := 0
    static PO_PART := 1
    static PO_CLASS := 2
    static PO_GLOBAL := 3
    static PO_NOTFOUND := 4
}
struct WINDOWTHEMEATTRIBUTETYPE extends Int32 {
    static WTA_NONCLIENT := 1
}
struct WTA_OPTIONS {
    dwFlags : UInt32
    dwMask : UInt32
}
struct DTT_CALLBACK_PROC extends FunctionPointer {
    static Types := [HDC, PWSTR, Int32, RECT.Ptr, UInt32, LPARAM, Int32]
}
struct DTTOPTS {
    dwSize : UInt32
    dwFlags : DTTOPTS_FLAGS
    crText : COLORREF
    crBorder : COLORREF
    crShadow : COLORREF
    iTextShadowType : Int32
    ptShadowOffset : POINT
    iBorderSize : Int32
    iFontPropId : Int32
    iColorPropId : Int32
    iStateId : Int32
    fApplyOverlay : BOOL
    iGlowSize : Int32
    pfnDrawTextCallback : DTT_CALLBACK_PROC
    lParam : LPARAM
}
struct BP_BUFFERFORMAT extends Int32 {
    static BPBF_COMPATIBLEBITMAP := 0
    static BPBF_DIB := 1
    static BPBF_TOPDOWNDIB := 2
    static BPBF_TOPDOWNMONODIB := 3
}
struct BP_ANIMATIONSTYLE extends Int32 {
    static BPAS_NONE := 0
    static BPAS_LINEAR := 1
    static BPAS_CUBIC := 2
    static BPAS_SINE := 3
}
struct BP_ANIMATIONPARAMS {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    style : BP_ANIMATIONSTYLE
    dwDuration : UInt32
}
struct BP_PAINTPARAMS {
    cbSize : UInt32 := this.Size
    dwFlags : BP_PAINTPARAMS_FLAGS
    prcExclude : RECT.Ptr
    pBlendFunction : BLENDFUNCTION.Ptr
}
struct AEROWIZARDPARTS extends Int32 {
    static AW_TITLEBAR := 1
    static AW_HEADERAREA := 2
    static AW_CONTENTAREA := 3
    static AW_COMMANDAREA := 4
    static AW_BUTTON := 5
}
struct TITLEBARSTATES extends Int32 {
    static AW_S_TITLEBAR_ACTIVE := 1
    static AW_S_TITLEBAR_INACTIVE := 2
}
struct HEADERAREASTATES extends Int32 {
    static AW_S_HEADERAREA_NOMARGIN := 1
}
struct CONTENTAREASTATES extends Int32 {
    static AW_S_CONTENTAREA_NOMARGIN := 1
}
struct BUTTONPARTS extends Int32 {
    static BP_PUSHBUTTON := 1
    static BP_RADIOBUTTON := 2
    static BP_CHECKBOX := 3
    static BP_GROUPBOX := 4
    static BP_USERBUTTON := 5
    static BP_COMMANDLINK := 6
    static BP_COMMANDLINKGLYPH := 7
    static BP_RADIOBUTTON_HCDISABLED := 8
    static BP_CHECKBOX_HCDISABLED := 9
    static BP_GROUPBOX_HCDISABLED := 10
    static BP_PUSHBUTTONDROPDOWN := 11
}
struct PUSHBUTTONSTATES extends Int32 {
    static PBS_NORMAL := 1
    static PBS_HOT := 2
    static PBS_PRESSED := 3
    static PBS_DISABLED := 4
    static PBS_DEFAULTED := 5
    static PBS_DEFAULTED_ANIMATING := 6
}
struct RADIOBUTTONSTATES extends Int32 {
    static RBS_UNCHECKEDNORMAL := 1
    static RBS_UNCHECKEDHOT := 2
    static RBS_UNCHECKEDPRESSED := 3
    static RBS_UNCHECKEDDISABLED := 4
    static RBS_CHECKEDNORMAL := 5
    static RBS_CHECKEDHOT := 6
    static RBS_CHECKEDPRESSED := 7
    static RBS_CHECKEDDISABLED := 8
}
struct CHECKBOXSTATES extends Int32 {
    static CBS_UNCHECKEDNORMAL := 1
    static CBS_UNCHECKEDHOT := 2
    static CBS_UNCHECKEDPRESSED := 3
    static CBS_UNCHECKEDDISABLED := 4
    static CBS_CHECKEDNORMAL := 5
    static CBS_CHECKEDHOT := 6
    static CBS_CHECKEDPRESSED := 7
    static CBS_CHECKEDDISABLED := 8
    static CBS_MIXEDNORMAL := 9
    static CBS_MIXEDHOT := 10
    static CBS_MIXEDPRESSED := 11
    static CBS_MIXEDDISABLED := 12
    static CBS_IMPLICITNORMAL := 13
    static CBS_IMPLICITHOT := 14
    static CBS_IMPLICITPRESSED := 15
    static CBS_IMPLICITDISABLED := 16
    static CBS_EXCLUDEDNORMAL := 17
    static CBS_EXCLUDEDHOT := 18
    static CBS_EXCLUDEDPRESSED := 19
    static CBS_EXCLUDEDDISABLED := 20
}
struct GROUPBOXSTATES extends Int32 {
    static GBS_NORMAL := 1
    static GBS_DISABLED := 2
}
struct COMMANDLINKSTATES extends Int32 {
    static CMDLS_NORMAL := 1
    static CMDLS_HOT := 2
    static CMDLS_PRESSED := 3
    static CMDLS_DISABLED := 4
    static CMDLS_DEFAULTED := 5
    static CMDLS_DEFAULTED_ANIMATING := 6
}
struct COMMANDLINKGLYPHSTATES extends Int32 {
    static CMDLGS_NORMAL := 1
    static CMDLGS_HOT := 2
    static CMDLGS_PRESSED := 3
    static CMDLGS_DISABLED := 4
    static CMDLGS_DEFAULTED := 5
}
struct PUSHBUTTONDROPDOWNSTATES extends Int32 {
    static PBDDS_NORMAL := 1
    static PBDDS_DISABLED := 2
}
struct COMBOBOXPARTS extends Int32 {
    static CP_DROPDOWNBUTTON := 1
    static CP_BACKGROUND := 2
    static CP_TRANSPARENTBACKGROUND := 3
    static CP_BORDER := 4
    static CP_READONLY := 5
    static CP_DROPDOWNBUTTONRIGHT := 6
    static CP_DROPDOWNBUTTONLEFT := 7
    static CP_CUEBANNER := 8
    static CP_DROPDOWNITEM := 9
}
struct COMBOBOXSTYLESTATES extends Int32 {
    static CBXS_NORMAL := 1
    static CBXS_HOT := 2
    static CBXS_PRESSED := 3
    static CBXS_DISABLED := 4
}
struct DROPDOWNBUTTONRIGHTSTATES extends Int32 {
    static CBXSR_NORMAL := 1
    static CBXSR_HOT := 2
    static CBXSR_PRESSED := 3
    static CBXSR_DISABLED := 4
}
struct DROPDOWNBUTTONLEFTSTATES extends Int32 {
    static CBXSL_NORMAL := 1
    static CBXSL_HOT := 2
    static CBXSL_PRESSED := 3
    static CBXSL_DISABLED := 4
}
struct TRANSPARENTBACKGROUNDSTATES extends Int32 {
    static CBTBS_NORMAL := 1
    static CBTBS_HOT := 2
    static CBTBS_DISABLED := 3
    static CBTBS_FOCUSED := 4
}
struct BORDERSTATES extends Int32 {
    static CBB_NORMAL := 1
    static CBB_HOT := 2
    static CBB_FOCUSED := 3
    static CBB_DISABLED := 4
}
struct READONLYSTATES extends Int32 {
    static CBRO_NORMAL := 1
    static CBRO_HOT := 2
    static CBRO_PRESSED := 3
    static CBRO_DISABLED := 4
}
struct CUEBANNERSTATES extends Int32 {
    static CBCB_NORMAL := 1
    static CBCB_HOT := 2
    static CBCB_PRESSED := 3
    static CBCB_DISABLED := 4
}
struct DROPDOWNITEMSTATES extends Int32 {
    static CBDI_NORMAL := 1
    static CBDI_HIGHLIGHTED := 2
}
struct COMMUNICATIONSPARTS extends Int32 {
    static CSST_TAB := 1
}
struct TABSTATES extends Int32 {
    static CSTB_NORMAL := 1
    static CSTB_HOT := 2
    static CSTB_SELECTED := 3
}
struct CONTROLPANELPARTS extends Int32 {
    static CPANEL_NAVIGATIONPANE := 1
    static CPANEL_CONTENTPANE := 2
    static CPANEL_NAVIGATIONPANELABEL := 3
    static CPANEL_CONTENTPANELABEL := 4
    static CPANEL_TITLE := 5
    static CPANEL_BODYTEXT := 6
    static CPANEL_HELPLINK := 7
    static CPANEL_TASKLINK := 8
    static CPANEL_GROUPTEXT := 9
    static CPANEL_CONTENTLINK := 10
    static CPANEL_SECTIONTITLELINK := 11
    static CPANEL_LARGECOMMANDAREA := 12
    static CPANEL_SMALLCOMMANDAREA := 13
    static CPANEL_BUTTON := 14
    static CPANEL_MESSAGETEXT := 15
    static CPANEL_NAVIGATIONPANELINE := 16
    static CPANEL_CONTENTPANELINE := 17
    static CPANEL_BANNERAREA := 18
    static CPANEL_BODYTITLE := 19
}
struct HELPLINKSTATES extends Int32 {
    static CPHL_NORMAL := 1
    static CPHL_HOT := 2
    static CPHL_PRESSED := 3
    static CPHL_DISABLED := 4
}
struct TASKLINKSTATES extends Int32 {
    static CPTL_NORMAL := 1
    static CPTL_HOT := 2
    static CPTL_PRESSED := 3
    static CPTL_DISABLED := 4
    static CPTL_PAGE := 5
}
struct CONTENTLINKSTATES extends Int32 {
    static CPCL_NORMAL := 1
    static CPCL_HOT := 2
    static CPCL_PRESSED := 3
    static CPCL_DISABLED := 4
}
struct SECTIONTITLELINKSTATES extends Int32 {
    static CPSTL_NORMAL := 1
    static CPSTL_HOT := 2
}
struct DATEPICKERPARTS extends Int32 {
    static DP_DATETEXT := 1
    static DP_DATEBORDER := 2
    static DP_SHOWCALENDARBUTTONRIGHT := 3
}
struct DATETEXTSTATES extends Int32 {
    static DPDT_NORMAL := 1
    static DPDT_DISABLED := 2
    static DPDT_SELECTED := 3
}
struct DATEBORDERSTATES extends Int32 {
    static DPDB_NORMAL := 1
    static DPDB_HOT := 2
    static DPDB_FOCUSED := 3
    static DPDB_DISABLED := 4
}
struct SHOWCALENDARBUTTONRIGHTSTATES extends Int32 {
    static DPSCBR_NORMAL := 1
    static DPSCBR_HOT := 2
    static DPSCBR_PRESSED := 3
    static DPSCBR_DISABLED := 4
}
struct DRAGDROPPARTS extends Int32 {
    static DD_COPY := 1
    static DD_MOVE := 2
    static DD_UPDATEMETADATA := 3
    static DD_CREATELINK := 4
    static DD_WARNING := 5
    static DD_NONE := 6
    static DD_IMAGEBG := 7
    static DD_TEXTBG := 8
}
struct COPYSTATES extends Int32 {
    static DDCOPY_HIGHLIGHT := 1
    static DDCOPY_NOHIGHLIGHT := 2
}
struct MOVESTATES extends Int32 {
    static DDMOVE_HIGHLIGHT := 1
    static DDMOVE_NOHIGHLIGHT := 2
}
struct UPDATEMETADATASTATES extends Int32 {
    static DDUPDATEMETADATA_HIGHLIGHT := 1
    static DDUPDATEMETADATA_NOHIGHLIGHT := 2
}
struct CREATELINKSTATES extends Int32 {
    static DDCREATELINK_HIGHLIGHT := 1
    static DDCREATELINK_NOHIGHLIGHT := 2
}
struct WARNINGSTATES extends Int32 {
    static DDWARNING_HIGHLIGHT := 1
    static DDWARNING_NOHIGHLIGHT := 2
}
struct NONESTATES extends Int32 {
    static DDNONE_HIGHLIGHT := 1
    static DDNONE_NOHIGHLIGHT := 2
}
struct EDITPARTS extends Int32 {
    static EP_EDITTEXT := 1
    static EP_CARET := 2
    static EP_BACKGROUND := 3
    static EP_PASSWORD := 4
    static EP_BACKGROUNDWITHBORDER := 5
    static EP_EDITBORDER_NOSCROLL := 6
    static EP_EDITBORDER_HSCROLL := 7
    static EP_EDITBORDER_VSCROLL := 8
    static EP_EDITBORDER_HVSCROLL := 9
}
struct EDITTEXTSTATES extends Int32 {
    static ETS_NORMAL := 1
    static ETS_HOT := 2
    static ETS_SELECTED := 3
    static ETS_DISABLED := 4
    static ETS_FOCUSED := 5
    static ETS_READONLY := 6
    static ETS_ASSIST := 7
    static ETS_CUEBANNER := 8
}
struct BACKGROUNDSTATES extends Int32 {
    static EBS_NORMAL := 1
    static EBS_HOT := 2
    static EBS_DISABLED := 3
    static EBS_FOCUSED := 4
    static EBS_READONLY := 5
    static EBS_ASSIST := 6
}
struct BACKGROUNDWITHBORDERSTATES extends Int32 {
    static EBWBS_NORMAL := 1
    static EBWBS_HOT := 2
    static EBWBS_DISABLED := 3
    static EBWBS_FOCUSED := 4
}
struct EDITBORDER_NOSCROLLSTATES extends Int32 {
    static EPSN_NORMAL := 1
    static EPSN_HOT := 2
    static EPSN_FOCUSED := 3
    static EPSN_DISABLED := 4
}
struct EDITBORDER_HSCROLLSTATES extends Int32 {
    static EPSH_NORMAL := 1
    static EPSH_HOT := 2
    static EPSH_FOCUSED := 3
    static EPSH_DISABLED := 4
}
struct EDITBORDER_VSCROLLSTATES extends Int32 {
    static EPSV_NORMAL := 1
    static EPSV_HOT := 2
    static EPSV_FOCUSED := 3
    static EPSV_DISABLED := 4
}
struct EDITBORDER_HVSCROLLSTATES extends Int32 {
    static EPSHV_NORMAL := 1
    static EPSHV_HOT := 2
    static EPSHV_FOCUSED := 3
    static EPSHV_DISABLED := 4
}
struct EXPLORERBARPARTS extends Int32 {
    static EBP_HEADERBACKGROUND := 1
    static EBP_HEADERCLOSE := 2
    static EBP_HEADERPIN := 3
    static EBP_IEBARMENU := 4
    static EBP_NORMALGROUPBACKGROUND := 5
    static EBP_NORMALGROUPCOLLAPSE := 6
    static EBP_NORMALGROUPEXPAND := 7
    static EBP_NORMALGROUPHEAD := 8
    static EBP_SPECIALGROUPBACKGROUND := 9
    static EBP_SPECIALGROUPCOLLAPSE := 10
    static EBP_SPECIALGROUPEXPAND := 11
    static EBP_SPECIALGROUPHEAD := 12
}
struct HEADERCLOSESTATES extends Int32 {
    static EBHC_NORMAL := 1
    static EBHC_HOT := 2
    static EBHC_PRESSED := 3
}
struct HEADERPINSTATES extends Int32 {
    static EBHP_NORMAL := 1
    static EBHP_HOT := 2
    static EBHP_PRESSED := 3
    static EBHP_SELECTEDNORMAL := 4
    static EBHP_SELECTEDHOT := 5
    static EBHP_SELECTEDPRESSED := 6
}
struct IEBARMENUSTATES extends Int32 {
    static EBM_NORMAL := 1
    static EBM_HOT := 2
    static EBM_PRESSED := 3
}
struct NORMALGROUPCOLLAPSESTATES extends Int32 {
    static EBNGC_NORMAL := 1
    static EBNGC_HOT := 2
    static EBNGC_PRESSED := 3
}
struct NORMALGROUPEXPANDSTATES extends Int32 {
    static EBNGE_NORMAL := 1
    static EBNGE_HOT := 2
    static EBNGE_PRESSED := 3
}
struct SPECIALGROUPCOLLAPSESTATES extends Int32 {
    static EBSGC_NORMAL := 1
    static EBSGC_HOT := 2
    static EBSGC_PRESSED := 3
}
struct SPECIALGROUPEXPANDSTATES extends Int32 {
    static EBSGE_NORMAL := 1
    static EBSGE_HOT := 2
    static EBSGE_PRESSED := 3
}
struct FLYOUTPARTS extends Int32 {
    static FLYOUT_HEADER := 1
    static FLYOUT_BODY := 2
    static FLYOUT_LABEL := 3
    static FLYOUT_LINK := 4
    static FLYOUT_DIVIDER := 5
    static FLYOUT_WINDOW := 6
    static FLYOUT_LINKAREA := 7
    static FLYOUT_LINKHEADER := 8
}
struct LABELSTATES extends Int32 {
    static FLS_NORMAL := 1
    static FLS_SELECTED := 2
    static FLS_EMPHASIZED := 3
    static FLS_DISABLED := 4
}
struct LINKSTATES extends Int32 {
    static FLYOUTLINK_NORMAL := 1
    static FLYOUTLINK_HOVER := 2
}
struct BODYSTATES extends Int32 {
    static FBS_NORMAL := 1
    static FBS_EMPHASIZED := 2
}
struct LINKHEADERSTATES extends Int32 {
    static FLH_NORMAL := 1
    static FLH_HOVER := 2
}
struct HEADERPARTS extends Int32 {
    static HP_HEADERITEM := 1
    static HP_HEADERITEMLEFT := 2
    static HP_HEADERITEMRIGHT := 3
    static HP_HEADERSORTARROW := 4
    static HP_HEADERDROPDOWN := 5
    static HP_HEADERDROPDOWNFILTER := 6
    static HP_HEADEROVERFLOW := 7
}
struct HEADERSTYLESTATES extends Int32 {
    static HBG_DETAILS := 1
    static HBG_ICON := 2
}
struct HEADERITEMSTATES extends Int32 {
    static HIS_NORMAL := 1
    static HIS_HOT := 2
    static HIS_PRESSED := 3
    static HIS_SORTEDNORMAL := 4
    static HIS_SORTEDHOT := 5
    static HIS_SORTEDPRESSED := 6
    static HIS_ICONNORMAL := 7
    static HIS_ICONHOT := 8
    static HIS_ICONPRESSED := 9
    static HIS_ICONSORTEDNORMAL := 10
    static HIS_ICONSORTEDHOT := 11
    static HIS_ICONSORTEDPRESSED := 12
}
struct HEADERITEMLEFTSTATES extends Int32 {
    static HILS_NORMAL := 1
    static HILS_HOT := 2
    static HILS_PRESSED := 3
}
struct HEADERITEMRIGHTSTATES extends Int32 {
    static HIRS_NORMAL := 1
    static HIRS_HOT := 2
    static HIRS_PRESSED := 3
}
struct HEADERSORTARROWSTATES extends Int32 {
    static HSAS_SORTEDUP := 1
    static HSAS_SORTEDDOWN := 2
}
struct HEADERDROPDOWNSTATES extends Int32 {
    static HDDS_NORMAL := 1
    static HDDS_SOFTHOT := 2
    static HDDS_HOT := 3
}
struct HEADERDROPDOWNFILTERSTATES extends Int32 {
    static HDDFS_NORMAL := 1
    static HDDFS_SOFTHOT := 2
    static HDDFS_HOT := 3
}
struct HEADEROVERFLOWSTATES extends Int32 {
    static HOFS_NORMAL := 1
    static HOFS_HOT := 2
}
struct LISTBOXPARTS extends Int32 {
    static LBCP_BORDER_HSCROLL := 1
    static LBCP_BORDER_HVSCROLL := 2
    static LBCP_BORDER_NOSCROLL := 3
    static LBCP_BORDER_VSCROLL := 4
    static LBCP_ITEM := 5
}
struct BORDER_HSCROLLSTATES extends Int32 {
    static LBPSH_NORMAL := 1
    static LBPSH_FOCUSED := 2
    static LBPSH_HOT := 3
    static LBPSH_DISABLED := 4
}
struct BORDER_HVSCROLLSTATES extends Int32 {
    static LBPSHV_NORMAL := 1
    static LBPSHV_FOCUSED := 2
    static LBPSHV_HOT := 3
    static LBPSHV_DISABLED := 4
}
struct BORDER_NOSCROLLSTATES extends Int32 {
    static LBPSN_NORMAL := 1
    static LBPSN_FOCUSED := 2
    static LBPSN_HOT := 3
    static LBPSN_DISABLED := 4
}
struct BORDER_VSCROLLSTATES extends Int32 {
    static LBPSV_NORMAL := 1
    static LBPSV_FOCUSED := 2
    static LBPSV_HOT := 3
    static LBPSV_DISABLED := 4
}
struct ITEMSTATES extends Int32 {
    static LBPSI_HOT := 1
    static LBPSI_HOTSELECTED := 2
    static LBPSI_SELECTED := 3
    static LBPSI_SELECTEDNOTFOCUS := 4
}
struct LISTVIEWPARTS extends Int32 {
    static LVP_LISTITEM := 1
    static LVP_LISTGROUP := 2
    static LVP_LISTDETAIL := 3
    static LVP_LISTSORTEDDETAIL := 4
    static LVP_EMPTYTEXT := 5
    static LVP_GROUPHEADER := 6
    static LVP_GROUPHEADERLINE := 7
    static LVP_EXPANDBUTTON := 8
    static LVP_COLLAPSEBUTTON := 9
    static LVP_COLUMNDETAIL := 10
}
struct LISTITEMSTATES extends Int32 {
    static LISS_NORMAL := 1
    static LISS_HOT := 2
    static LISS_SELECTED := 3
    static LISS_DISABLED := 4
    static LISS_SELECTEDNOTFOCUS := 5
    static LISS_HOTSELECTED := 6
}
struct GROUPHEADERSTATES extends Int32 {
    static LVGH_OPEN := 1
    static LVGH_OPENHOT := 2
    static LVGH_OPENSELECTED := 3
    static LVGH_OPENSELECTEDHOT := 4
    static LVGH_OPENSELECTEDNOTFOCUSED := 5
    static LVGH_OPENSELECTEDNOTFOCUSEDHOT := 6
    static LVGH_OPENMIXEDSELECTION := 7
    static LVGH_OPENMIXEDSELECTIONHOT := 8
    static LVGH_CLOSE := 9
    static LVGH_CLOSEHOT := 10
    static LVGH_CLOSESELECTED := 11
    static LVGH_CLOSESELECTEDHOT := 12
    static LVGH_CLOSESELECTEDNOTFOCUSED := 13
    static LVGH_CLOSESELECTEDNOTFOCUSEDHOT := 14
    static LVGH_CLOSEMIXEDSELECTION := 15
    static LVGH_CLOSEMIXEDSELECTIONHOT := 16
}
struct GROUPHEADERLINESTATES extends Int32 {
    static LVGHL_OPEN := 1
    static LVGHL_OPENHOT := 2
    static LVGHL_OPENSELECTED := 3
    static LVGHL_OPENSELECTEDHOT := 4
    static LVGHL_OPENSELECTEDNOTFOCUSED := 5
    static LVGHL_OPENSELECTEDNOTFOCUSEDHOT := 6
    static LVGHL_OPENMIXEDSELECTION := 7
    static LVGHL_OPENMIXEDSELECTIONHOT := 8
    static LVGHL_CLOSE := 9
    static LVGHL_CLOSEHOT := 10
    static LVGHL_CLOSESELECTED := 11
    static LVGHL_CLOSESELECTEDHOT := 12
    static LVGHL_CLOSESELECTEDNOTFOCUSED := 13
    static LVGHL_CLOSESELECTEDNOTFOCUSEDHOT := 14
    static LVGHL_CLOSEMIXEDSELECTION := 15
    static LVGHL_CLOSEMIXEDSELECTIONHOT := 16
}
struct EXPANDBUTTONSTATES extends Int32 {
    static LVEB_NORMAL := 1
    static LVEB_HOVER := 2
    static LVEB_PUSHED := 3
}
struct COLLAPSEBUTTONSTATES extends Int32 {
    static LVCB_NORMAL := 1
    static LVCB_HOVER := 2
    static LVCB_PUSHED := 3
}
struct MENUPARTS extends Int32 {
    static MENU_MENUITEM_TMSCHEMA := 1
    static MENU_MENUDROPDOWN_TMSCHEMA := 2
    static MENU_MENUBARITEM_TMSCHEMA := 3
    static MENU_MENUBARDROPDOWN_TMSCHEMA := 4
    static MENU_CHEVRON_TMSCHEMA := 5
    static MENU_SEPARATOR_TMSCHEMA := 6
    static MENU_BARBACKGROUND := 7
    static MENU_BARITEM := 8
    static MENU_POPUPBACKGROUND := 9
    static MENU_POPUPBORDERS := 10
    static MENU_POPUPCHECK := 11
    static MENU_POPUPCHECKBACKGROUND := 12
    static MENU_POPUPGUTTER := 13
    static MENU_POPUPITEM := 14
    static MENU_POPUPSEPARATOR := 15
    static MENU_POPUPSUBMENU := 16
    static MENU_SYSTEMCLOSE := 17
    static MENU_SYSTEMMAXIMIZE := 18
    static MENU_SYSTEMMINIMIZE := 19
    static MENU_SYSTEMRESTORE := 20
    static MENU_POPUPSUBMENUHCHOT := 21
    static MENU_SYSTEMCLOSEHCHOT := 22
    static MENU_SYSTEMMAXIMIZEHCHOT := 23
    static MENU_SYSTEMMINIMIZEHCHOT := 24
    static MENU_SYSTEMRESTOREHCHOT := 25
    static MENU_POPUPITEMKBFOCUS := 26
    static MENU_POPUPITEMFOCUSABLE := 27
    static MENU_POPUPSUBMENU_HCHOT := 21
}
struct BARBACKGROUNDSTATES extends Int32 {
    static MB_ACTIVE := 1
    static MB_INACTIVE := 2
}
struct BARITEMSTATES extends Int32 {
    static MBI_NORMAL := 1
    static MBI_HOT := 2
    static MBI_PUSHED := 3
    static MBI_DISABLED := 4
    static MBI_DISABLEDHOT := 5
    static MBI_DISABLEDPUSHED := 6
}
struct POPUPCHECKSTATES extends Int32 {
    static MC_CHECKMARKNORMAL := 1
    static MC_CHECKMARKDISABLED := 2
    static MC_BULLETNORMAL := 3
    static MC_BULLETDISABLED := 4
}
struct POPUPCHECKBACKGROUNDSTATES extends Int32 {
    static MCB_DISABLED := 1
    static MCB_NORMAL := 2
    static MCB_BITMAP := 3
}
struct POPUPITEMSTATES extends Int32 {
    static MPI_NORMAL := 1
    static MPI_HOT := 2
    static MPI_DISABLED := 3
    static MPI_DISABLEDHOT := 4
}
struct POPUPSUBMENUSTATES extends Int32 {
    static MSM_NORMAL := 1
    static MSM_DISABLED := 2
}
struct SYSTEMCLOSESTATES extends Int32 {
    static MSYSC_NORMAL := 1
    static MSYSC_DISABLED := 2
}
struct SYSTEMMAXIMIZESTATES extends Int32 {
    static MSYSMX_NORMAL := 1
    static MSYSMX_DISABLED := 2
}
struct SYSTEMMINIMIZESTATES extends Int32 {
    static MSYSMN_NORMAL := 1
    static MSYSMN_DISABLED := 2
}
struct SYSTEMRESTORESTATES extends Int32 {
    static MSYSR_NORMAL := 1
    static MSYSR_DISABLED := 2
}
struct POPUPSUBMENUHCHOTSTATES extends Int32 {
    static MSMHC_HOT := 1
}
struct SYSTEMCLOSEHCHOTSTATES extends Int32 {
    static MSYSCHC_HOT := 1
}
struct SYSTEMMAXIMIZEHCHOTSTATES extends Int32 {
    static MSYSMXHC_HOT := 1
}
struct SYSTEMMINIMIZEHCHOTSTATES extends Int32 {
    static MSYSMNHC_HOT := 1
}
struct SYSTEMRESTOREHCHOTSTATES extends Int32 {
    static MSYSRHC_HOT := 1
}
struct POPUPITEMKBFOCUSSTATES extends Int32 {
    static MPIKBFOCUS_NORMAL := 1
}
struct POPUPITEMFOCUSABLESTATES extends Int32 {
    static MPIF_NORMAL := 1
    static MPIF_HOT := 2
    static MPIF_DISABLED := 3
    static MPIF_DISABLEDHOT := 4
}
struct NAVIGATIONPARTS extends Int32 {
    static NAV_BACKBUTTON := 1
    static NAV_FORWARDBUTTON := 2
    static NAV_MENUBUTTON := 3
}
struct NAV_BACKBUTTONSTATES extends Int32 {
    static NAV_BB_NORMAL := 1
    static NAV_BB_HOT := 2
    static NAV_BB_PRESSED := 3
    static NAV_BB_DISABLED := 4
}
struct NAV_FORWARDBUTTONSTATES extends Int32 {
    static NAV_FB_NORMAL := 1
    static NAV_FB_HOT := 2
    static NAV_FB_PRESSED := 3
    static NAV_FB_DISABLED := 4
}
struct NAV_MENUBUTTONSTATES extends Int32 {
    static NAV_MB_NORMAL := 1
    static NAV_MB_HOT := 2
    static NAV_MB_PRESSED := 3
    static NAV_MB_DISABLED := 4
}
struct PROGRESSPARTS extends Int32 {
    static PP_BAR := 1
    static PP_BARVERT := 2
    static PP_CHUNK := 3
    static PP_CHUNKVERT := 4
    static PP_FILL := 5
    static PP_FILLVERT := 6
    static PP_PULSEOVERLAY := 7
    static PP_MOVEOVERLAY := 8
    static PP_PULSEOVERLAYVERT := 9
    static PP_MOVEOVERLAYVERT := 10
    static PP_TRANSPARENTBAR := 11
    static PP_TRANSPARENTBARVERT := 12
}
struct TRANSPARENTBARSTATES extends Int32 {
    static PBBS_NORMAL := 1
    static PBBS_PARTIAL := 2
}
struct TRANSPARENTBARVERTSTATES extends Int32 {
    static PBBVS_NORMAL := 1
    static PBBVS_PARTIAL := 2
}
struct FILLSTATES extends Int32 {
    static PBFS_NORMAL := 1
    static PBFS_ERROR := 2
    static PBFS_PAUSED := 3
    static PBFS_PARTIAL := 4
}
struct FILLVERTSTATES extends Int32 {
    static PBFVS_NORMAL := 1
    static PBFVS_ERROR := 2
    static PBFVS_PAUSED := 3
    static PBFVS_PARTIAL := 4
}
struct REBARPARTS extends Int32 {
    static RP_GRIPPER := 1
    static RP_GRIPPERVERT := 2
    static RP_BAND := 3
    static RP_CHEVRON := 4
    static RP_CHEVRONVERT := 5
    static RP_BACKGROUND := 6
    static RP_SPLITTER := 7
    static RP_SPLITTERVERT := 8
}
struct CHEVRONSTATES extends Int32 {
    static CHEVS_NORMAL := 1
    static CHEVS_HOT := 2
    static CHEVS_PRESSED := 3
}
struct CHEVRONVERTSTATES extends Int32 {
    static CHEVSV_NORMAL := 1
    static CHEVSV_HOT := 2
    static CHEVSV_PRESSED := 3
}
struct SPLITTERSTATES extends Int32 {
    static SPLITS_NORMAL := 1
    static SPLITS_HOT := 2
    static SPLITS_PRESSED := 3
}
struct SPLITTERVERTSTATES extends Int32 {
    static SPLITSV_NORMAL := 1
    static SPLITSV_HOT := 2
    static SPLITSV_PRESSED := 3
}
struct SCROLLBARPARTS extends Int32 {
    static SBP_ARROWBTN := 1
    static SBP_THUMBBTNHORZ := 2
    static SBP_THUMBBTNVERT := 3
    static SBP_LOWERTRACKHORZ := 4
    static SBP_UPPERTRACKHORZ := 5
    static SBP_LOWERTRACKVERT := 6
    static SBP_UPPERTRACKVERT := 7
    static SBP_GRIPPERHORZ := 8
    static SBP_GRIPPERVERT := 9
    static SBP_SIZEBOX := 10
    static SBP_SIZEBOXBKGND := 11
}
struct ARROWBTNSTATES extends Int32 {
    static ABS_UPNORMAL := 1
    static ABS_UPHOT := 2
    static ABS_UPPRESSED := 3
    static ABS_UPDISABLED := 4
    static ABS_DOWNNORMAL := 5
    static ABS_DOWNHOT := 6
    static ABS_DOWNPRESSED := 7
    static ABS_DOWNDISABLED := 8
    static ABS_LEFTNORMAL := 9
    static ABS_LEFTHOT := 10
    static ABS_LEFTPRESSED := 11
    static ABS_LEFTDISABLED := 12
    static ABS_RIGHTNORMAL := 13
    static ABS_RIGHTHOT := 14
    static ABS_RIGHTPRESSED := 15
    static ABS_RIGHTDISABLED := 16
    static ABS_UPHOVER := 17
    static ABS_DOWNHOVER := 18
    static ABS_LEFTHOVER := 19
    static ABS_RIGHTHOVER := 20
}
struct SCROLLBARSTYLESTATES extends Int32 {
    static SCRBS_NORMAL := 1
    static SCRBS_HOT := 2
    static SCRBS_PRESSED := 3
    static SCRBS_DISABLED := 4
    static SCRBS_HOVER := 5
}
struct SIZEBOXSTATES extends Int32 {
    static SZB_RIGHTALIGN := 1
    static SZB_LEFTALIGN := 2
    static SZB_TOPRIGHTALIGN := 3
    static SZB_TOPLEFTALIGN := 4
    static SZB_HALFBOTTOMRIGHTALIGN := 5
    static SZB_HALFBOTTOMLEFTALIGN := 6
    static SZB_HALFTOPRIGHTALIGN := 7
    static SZB_HALFTOPLEFTALIGN := 8
}
struct SPINPARTS extends Int32 {
    static SPNP_UP := 1
    static SPNP_DOWN := 2
    static SPNP_UPHORZ := 3
    static SPNP_DOWNHORZ := 4
}
struct UPSTATES extends Int32 {
    static UPS_NORMAL := 1
    static UPS_HOT := 2
    static UPS_PRESSED := 3
    static UPS_DISABLED := 4
}
struct DOWNSTATES extends Int32 {
    static DNS_NORMAL := 1
    static DNS_HOT := 2
    static DNS_PRESSED := 3
    static DNS_DISABLED := 4
}
struct UPHORZSTATES extends Int32 {
    static UPHZS_NORMAL := 1
    static UPHZS_HOT := 2
    static UPHZS_PRESSED := 3
    static UPHZS_DISABLED := 4
}
struct DOWNHORZSTATES extends Int32 {
    static DNHZS_NORMAL := 1
    static DNHZS_HOT := 2
    static DNHZS_PRESSED := 3
    static DNHZS_DISABLED := 4
}
struct STATUSPARTS extends Int32 {
    static SP_PANE := 1
    static SP_GRIPPERPANE := 2
    static SP_GRIPPER := 3
}
struct TABPARTS extends Int32 {
    static TABP_TABITEM := 1
    static TABP_TABITEMLEFTEDGE := 2
    static TABP_TABITEMRIGHTEDGE := 3
    static TABP_TABITEMBOTHEDGE := 4
    static TABP_TOPTABITEM := 5
    static TABP_TOPTABITEMLEFTEDGE := 6
    static TABP_TOPTABITEMRIGHTEDGE := 7
    static TABP_TOPTABITEMBOTHEDGE := 8
    static TABP_PANE := 9
    static TABP_BODY := 10
    static TABP_AEROWIZARDBODY := 11
}
struct TABITEMSTATES extends Int32 {
    static TIS_NORMAL := 1
    static TIS_HOT := 2
    static TIS_SELECTED := 3
    static TIS_DISABLED := 4
    static TIS_FOCUSED := 5
}
struct TABITEMLEFTEDGESTATES extends Int32 {
    static TILES_NORMAL := 1
    static TILES_HOT := 2
    static TILES_SELECTED := 3
    static TILES_DISABLED := 4
    static TILES_FOCUSED := 5
}
struct TABITEMRIGHTEDGESTATES extends Int32 {
    static TIRES_NORMAL := 1
    static TIRES_HOT := 2
    static TIRES_SELECTED := 3
    static TIRES_DISABLED := 4
    static TIRES_FOCUSED := 5
}
struct TABITEMBOTHEDGESTATES extends Int32 {
    static TIBES_NORMAL := 1
    static TIBES_HOT := 2
    static TIBES_SELECTED := 3
    static TIBES_DISABLED := 4
    static TIBES_FOCUSED := 5
}
struct TOPTABITEMSTATES extends Int32 {
    static TTIS_NORMAL := 1
    static TTIS_HOT := 2
    static TTIS_SELECTED := 3
    static TTIS_DISABLED := 4
    static TTIS_FOCUSED := 5
}
struct TOPTABITEMLEFTEDGESTATES extends Int32 {
    static TTILES_NORMAL := 1
    static TTILES_HOT := 2
    static TTILES_SELECTED := 3
    static TTILES_DISABLED := 4
    static TTILES_FOCUSED := 5
}
struct TOPTABITEMRIGHTEDGESTATES extends Int32 {
    static TTIRES_NORMAL := 1
    static TTIRES_HOT := 2
    static TTIRES_SELECTED := 3
    static TTIRES_DISABLED := 4
    static TTIRES_FOCUSED := 5
}
struct TOPTABITEMBOTHEDGESTATES extends Int32 {
    static TTIBES_NORMAL := 1
    static TTIBES_HOT := 2
    static TTIBES_SELECTED := 3
    static TTIBES_DISABLED := 4
    static TTIBES_FOCUSED := 5
}
struct TASKDIALOGPARTS extends Int32 {
    static TDLG_PRIMARYPANEL := 1
    static TDLG_MAININSTRUCTIONPANE := 2
    static TDLG_MAINICON := 3
    static TDLG_CONTENTPANE := 4
    static TDLG_CONTENTICON := 5
    static TDLG_EXPANDEDCONTENT := 6
    static TDLG_COMMANDLINKPANE := 7
    static TDLG_SECONDARYPANEL := 8
    static TDLG_CONTROLPANE := 9
    static TDLG_BUTTONSECTION := 10
    static TDLG_BUTTONWRAPPER := 11
    static TDLG_EXPANDOTEXT := 12
    static TDLG_EXPANDOBUTTON := 13
    static TDLG_VERIFICATIONTEXT := 14
    static TDLG_FOOTNOTEPANE := 15
    static TDLG_FOOTNOTEAREA := 16
    static TDLG_FOOTNOTESEPARATOR := 17
    static TDLG_EXPANDEDFOOTERAREA := 18
    static TDLG_PROGRESSBAR := 19
    static TDLG_IMAGEALIGNMENT := 20
    static TDLG_RADIOBUTTONPANE := 21
}
struct CONTENTPANESTATES extends Int32 {
    static TDLGCPS_STANDALONE := 1
}
struct EXPANDOBUTTONSTATES extends Int32 {
    static TDLGEBS_NORMAL := 1
    static TDLGEBS_HOVER := 2
    static TDLGEBS_PRESSED := 3
    static TDLGEBS_EXPANDEDNORMAL := 4
    static TDLGEBS_EXPANDEDHOVER := 5
    static TDLGEBS_EXPANDEDPRESSED := 6
    static TDLGEBS_NORMALDISABLED := 7
    static TDLGEBS_EXPANDEDDISABLED := 8
}
struct TEXTSTYLEPARTS extends Int32 {
    static TEXT_MAININSTRUCTION := 1
    static TEXT_INSTRUCTION := 2
    static TEXT_BODYTITLE := 3
    static TEXT_BODYTEXT := 4
    static TEXT_SECONDARYTEXT := 5
    static TEXT_HYPERLINKTEXT := 6
    static TEXT_EXPANDED := 7
    static TEXT_LABEL := 8
    static TEXT_CONTROLLABEL := 9
}
struct HYPERLINKTEXTSTATES extends Int32 {
    static TS_HYPERLINK_NORMAL := 1
    static TS_HYPERLINK_HOT := 2
    static TS_HYPERLINK_PRESSED := 3
    static TS_HYPERLINK_DISABLED := 4
}
struct CONTROLLABELSTATES extends Int32 {
    static TS_CONTROLLABEL_NORMAL := 1
    static TS_CONTROLLABEL_DISABLED := 2
}
struct TOOLBARPARTS extends Int32 {
    static TP_BUTTON := 1
    static TP_DROPDOWNBUTTON := 2
    static TP_SPLITBUTTON := 3
    static TP_SPLITBUTTONDROPDOWN := 4
    static TP_SEPARATOR := 5
    static TP_SEPARATORVERT := 6
    static TP_DROPDOWNBUTTONGLYPH := 7
}
struct TOOLBARSTYLESTATES extends Int32 {
    static TS_NORMAL := 1
    static TS_HOT := 2
    static TS_PRESSED := 3
    static TS_DISABLED := 4
    static TS_CHECKED := 5
    static TS_HOTCHECKED := 6
    static TS_NEARHOT := 7
    static TS_OTHERSIDEHOT := 8
}
struct TOOLTIPPARTS extends Int32 {
    static TTP_STANDARD := 1
    static TTP_STANDARDTITLE := 2
    static TTP_BALLOON := 3
    static TTP_BALLOONTITLE := 4
    static TTP_CLOSE := 5
    static TTP_BALLOONSTEM := 6
    static TTP_WRENCH := 7
}
struct CLOSESTATES extends Int32 {
    static TTCS_NORMAL := 1
    static TTCS_HOT := 2
    static TTCS_PRESSED := 3
}
struct STANDARDSTATES extends Int32 {
    static TTSS_NORMAL := 1
    static TTSS_LINK := 2
}
struct BALLOONSTATES extends Int32 {
    static TTBS_NORMAL := 1
    static TTBS_LINK := 2
}
struct BALLOONSTEMSTATES extends Int32 {
    static TTBSS_POINTINGUPLEFTWALL := 1
    static TTBSS_POINTINGUPCENTERED := 2
    static TTBSS_POINTINGUPRIGHTWALL := 3
    static TTBSS_POINTINGDOWNRIGHTWALL := 4
    static TTBSS_POINTINGDOWNCENTERED := 5
    static TTBSS_POINTINGDOWNLEFTWALL := 6
}
struct WRENCHSTATES extends Int32 {
    static TTWS_NORMAL := 1
    static TTWS_HOT := 2
    static TTWS_PRESSED := 3
}
struct TRACKBARPARTS extends Int32 {
    static TKP_TRACK := 1
    static TKP_TRACKVERT := 2
    static TKP_THUMB := 3
    static TKP_THUMBBOTTOM := 4
    static TKP_THUMBTOP := 5
    static TKP_THUMBVERT := 6
    static TKP_THUMBLEFT := 7
    static TKP_THUMBRIGHT := 8
    static TKP_TICS := 9
    static TKP_TICSVERT := 10
}
struct TRACKBARSTYLESTATES extends Int32 {
    static TKS_NORMAL := 1
}
struct TRACKSTATES extends Int32 {
    static TRS_NORMAL := 1
}
struct TRACKVERTSTATES extends Int32 {
    static TRVS_NORMAL := 1
}
struct THUMBSTATES extends Int32 {
    static TUS_NORMAL := 1
    static TUS_HOT := 2
    static TUS_PRESSED := 3
    static TUS_FOCUSED := 4
    static TUS_DISABLED := 5
}
struct THUMBBOTTOMSTATES extends Int32 {
    static TUBS_NORMAL := 1
    static TUBS_HOT := 2
    static TUBS_PRESSED := 3
    static TUBS_FOCUSED := 4
    static TUBS_DISABLED := 5
}
struct THUMBTOPSTATES extends Int32 {
    static TUTS_NORMAL := 1
    static TUTS_HOT := 2
    static TUTS_PRESSED := 3
    static TUTS_FOCUSED := 4
    static TUTS_DISABLED := 5
}
struct THUMBVERTSTATES extends Int32 {
    static TUVS_NORMAL := 1
    static TUVS_HOT := 2
    static TUVS_PRESSED := 3
    static TUVS_FOCUSED := 4
    static TUVS_DISABLED := 5
}
struct THUMBLEFTSTATES extends Int32 {
    static TUVLS_NORMAL := 1
    static TUVLS_HOT := 2
    static TUVLS_PRESSED := 3
    static TUVLS_FOCUSED := 4
    static TUVLS_DISABLED := 5
}
struct THUMBRIGHTSTATES extends Int32 {
    static TUVRS_NORMAL := 1
    static TUVRS_HOT := 2
    static TUVRS_PRESSED := 3
    static TUVRS_FOCUSED := 4
    static TUVRS_DISABLED := 5
}
struct TICSSTATES extends Int32 {
    static TSS_NORMAL := 1
}
struct TICSVERTSTATES extends Int32 {
    static TSVS_NORMAL := 1
}
struct TREEVIEWPARTS extends Int32 {
    static TVP_TREEITEM := 1
    static TVP_GLYPH := 2
    static TVP_BRANCH := 3
    static TVP_HOTGLYPH := 4
}
struct TREEITEMSTATES extends Int32 {
    static TREIS_NORMAL := 1
    static TREIS_HOT := 2
    static TREIS_SELECTED := 3
    static TREIS_DISABLED := 4
    static TREIS_SELECTEDNOTFOCUS := 5
    static TREIS_HOTSELECTED := 6
}
struct GLYPHSTATES extends Int32 {
    static GLPS_CLOSED := 1
    static GLPS_OPENED := 2
}
struct HOTGLYPHSTATES extends Int32 {
    static HGLPS_CLOSED := 1
    static HGLPS_OPENED := 2
}
struct USERTILEPARTS extends Int32 {
    static UTP_STROKEBACKGROUND := 1
    static UTP_HOVERBACKGROUND := 2
}
struct HOVERBACKGROUNDSTATES extends Int32 {
    static UTS_NORMAL := 1
    static UTS_HOT := 2
    static UTS_PRESSED := 3
}
struct TEXTSELECTIONGRIPPERPARTS extends Int32 {
    static TSGP_GRIPPER := 1
}
struct GRIPPERSTATES extends Int32 {
    static TSGS_NORMAL := 1
    static TSGS_CENTERED := 2
}
struct WINDOWPARTS extends Int32 {
    static WP_CAPTION := 1
    static WP_SMALLCAPTION := 2
    static WP_MINCAPTION := 3
    static WP_SMALLMINCAPTION := 4
    static WP_MAXCAPTION := 5
    static WP_SMALLMAXCAPTION := 6
    static WP_FRAMELEFT := 7
    static WP_FRAMERIGHT := 8
    static WP_FRAMEBOTTOM := 9
    static WP_SMALLFRAMELEFT := 10
    static WP_SMALLFRAMERIGHT := 11
    static WP_SMALLFRAMEBOTTOM := 12
    static WP_SYSBUTTON := 13
    static WP_MDISYSBUTTON := 14
    static WP_MINBUTTON := 15
    static WP_MDIMINBUTTON := 16
    static WP_MAXBUTTON := 17
    static WP_CLOSEBUTTON := 18
    static WP_SMALLCLOSEBUTTON := 19
    static WP_MDICLOSEBUTTON := 20
    static WP_RESTOREBUTTON := 21
    static WP_MDIRESTOREBUTTON := 22
    static WP_HELPBUTTON := 23
    static WP_MDIHELPBUTTON := 24
    static WP_HORZSCROLL := 25
    static WP_HORZTHUMB := 26
    static WP_VERTSCROLL := 27
    static WP_VERTTHUMB := 28
    static WP_DIALOG := 29
    static WP_CAPTIONSIZINGTEMPLATE := 30
    static WP_SMALLCAPTIONSIZINGTEMPLATE := 31
    static WP_FRAMELEFTSIZINGTEMPLATE := 32
    static WP_SMALLFRAMELEFTSIZINGTEMPLATE := 33
    static WP_FRAMERIGHTSIZINGTEMPLATE := 34
    static WP_SMALLFRAMERIGHTSIZINGTEMPLATE := 35
    static WP_FRAMEBOTTOMSIZINGTEMPLATE := 36
    static WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE := 37
    static WP_FRAME := 38
    static WP_BORDER := 39
}
struct FRAMESTATES extends Int32 {
    static FS_ACTIVE := 1
    static FS_INACTIVE := 2
}
struct CAPTIONSTATES extends Int32 {
    static CS_ACTIVE := 1
    static CS_INACTIVE := 2
    static CS_DISABLED := 3
}
struct MAXCAPTIONSTATES extends Int32 {
    static MXCS_ACTIVE := 1
    static MXCS_INACTIVE := 2
    static MXCS_DISABLED := 3
}
struct MINCAPTIONSTATES extends Int32 {
    static MNCS_ACTIVE := 1
    static MNCS_INACTIVE := 2
    static MNCS_DISABLED := 3
}
struct HORZSCROLLSTATES extends Int32 {
    static HSS_NORMAL := 1
    static HSS_HOT := 2
    static HSS_PUSHED := 3
    static HSS_DISABLED := 4
}
struct HORZTHUMBSTATES extends Int32 {
    static HTS_NORMAL := 1
    static HTS_HOT := 2
    static HTS_PUSHED := 3
    static HTS_DISABLED := 4
}
struct VERTSCROLLSTATES extends Int32 {
    static VSS_NORMAL := 1
    static VSS_HOT := 2
    static VSS_PUSHED := 3
    static VSS_DISABLED := 4
}
struct VERTTHUMBSTATES extends Int32 {
    static VTS_NORMAL := 1
    static VTS_HOT := 2
    static VTS_PUSHED := 3
    static VTS_DISABLED := 4
}
struct SYSBUTTONSTATES extends Int32 {
    static SBS_NORMAL := 1
    static SBS_HOT := 2
    static SBS_PUSHED := 3
    static SBS_DISABLED := 4
}
struct MINBUTTONSTATES extends Int32 {
    static MINBS_NORMAL := 1
    static MINBS_HOT := 2
    static MINBS_PUSHED := 3
    static MINBS_DISABLED := 4
}
struct MAXBUTTONSTATES extends Int32 {
    static MAXBS_NORMAL := 1
    static MAXBS_HOT := 2
    static MAXBS_PUSHED := 3
    static MAXBS_DISABLED := 4
}
struct RESTOREBUTTONSTATES extends Int32 {
    static RBS_NORMAL := 1
    static RBS_HOT := 2
    static RBS_PUSHED := 3
    static RBS_DISABLED := 4
}
struct HELPBUTTONSTATES extends Int32 {
    static HBS_NORMAL := 1
    static HBS_HOT := 2
    static HBS_PUSHED := 3
    static HBS_DISABLED := 4
}
struct CLOSEBUTTONSTATES extends Int32 {
    static CBS_NORMAL := 1
    static CBS_HOT := 2
    static CBS_PUSHED := 3
    static CBS_DISABLED := 4
}
struct SMALLCLOSEBUTTONSTATES extends Int32 {
    static SCBS_NORMAL := 1
    static SCBS_HOT := 2
    static SCBS_PUSHED := 3
    static SCBS_DISABLED := 4
}
struct FRAMEBOTTOMSTATES extends Int32 {
    static FRB_ACTIVE := 1
    static FRB_INACTIVE := 2
}
struct FRAMELEFTSTATES extends Int32 {
    static FRL_ACTIVE := 1
    static FRL_INACTIVE := 2
}
struct FRAMERIGHTSTATES extends Int32 {
    static FRR_ACTIVE := 1
    static FRR_INACTIVE := 2
}
struct SMALLCAPTIONSTATES extends Int32 {
    static SCS_ACTIVE := 1
    static SCS_INACTIVE := 2
    static SCS_DISABLED := 3
}
struct SMALLFRAMEBOTTOMSTATES extends Int32 {
    static SFRB_ACTIVE := 1
    static SFRB_INACTIVE := 2
}
struct SMALLFRAMELEFTSTATES extends Int32 {
    static SFRL_ACTIVE := 1
    static SFRL_INACTIVE := 2
}
struct SMALLFRAMERIGHTSTATES extends Int32 {
    static SFRR_ACTIVE := 1
    static SFRR_INACTIVE := 2
}
struct MDICLOSEBUTTONSTATES extends Int32 {
    static MDCL_NORMAL := 1
    static MDCL_HOT := 2
    static MDCL_PUSHED := 3
    static MDCL_DISABLED := 4
}
struct MDIMINBUTTONSTATES extends Int32 {
    static MDMI_NORMAL := 1
    static MDMI_HOT := 2
    static MDMI_PUSHED := 3
    static MDMI_DISABLED := 4
}
struct MDIRESTOREBUTTONSTATES extends Int32 {
    static MDRE_NORMAL := 1
    static MDRE_HOT := 2
    static MDRE_PUSHED := 3
    static MDRE_DISABLED := 4
}
struct BGTYPE extends Int32 {
    static BT_IMAGEFILE := 0
    static BT_BORDERFILL := 1
    static BT_NONE := 2
}
struct IMAGELAYOUT extends Int32 {
    static IL_VERTICAL := 0
    static IL_HORIZONTAL := 1
}
struct BORDERTYPE extends Int32 {
    static BT_RECT := 0
    static BT_ROUNDRECT := 1
    static BT_ELLIPSE := 2
}
struct FILLTYPE extends Int32 {
    static FT_SOLID := 0
    static FT_VERTGRADIENT := 1
    static FT_HORZGRADIENT := 2
    static FT_RADIALGRADIENT := 3
    static FT_TILEIMAGE := 4
}
struct SIZINGTYPE extends Int32 {
    static ST_TRUESIZE := 0
    static ST_STRETCH := 1
    static ST_TILE := 2
}
struct HALIGN extends Int32 {
    static HA_LEFT := 0
    static HA_CENTER := 1
    static HA_RIGHT := 2
}
struct CONTENTALIGNMENT extends Int32 {
    static CA_LEFT := 0
    static CA_CENTER := 1
    static CA_RIGHT := 2
}
struct VALIGN extends Int32 {
    static VA_TOP := 0
    static VA_CENTER := 1
    static VA_BOTTOM := 2
}
struct OFFSETTYPE extends Int32 {
    static OT_TOPLEFT := 0
    static OT_TOPRIGHT := 1
    static OT_TOPMIDDLE := 2
    static OT_BOTTOMLEFT := 3
    static OT_BOTTOMRIGHT := 4
    static OT_BOTTOMMIDDLE := 5
    static OT_MIDDLELEFT := 6
    static OT_MIDDLERIGHT := 7
    static OT_LEFTOFCAPTION := 8
    static OT_RIGHTOFCAPTION := 9
    static OT_LEFTOFLASTBUTTON := 10
    static OT_RIGHTOFLASTBUTTON := 11
    static OT_ABOVELASTBUTTON := 12
    static OT_BELOWLASTBUTTON := 13
}
struct ICONEFFECT extends Int32 {
    static ICE_NONE := 0
    static ICE_GLOW := 1
    static ICE_SHADOW := 2
    static ICE_PULSE := 3
    static ICE_ALPHA := 4
}
struct TEXTSHADOWTYPE extends Int32 {
    static TST_NONE := 0
    static TST_SINGLE := 1
    static TST_CONTINUOUS := 2
}
struct GLYPHTYPE extends Int32 {
    static GT_NONE := 0
    static GT_IMAGEGLYPH := 1
    static GT_FONTGLYPH := 2
}
struct IMAGESELECTTYPE extends Int32 {
    static IST_NONE := 0
    static IST_SIZE := 1
    static IST_DPI := 2
}
struct TRUESIZESCALINGTYPE extends Int32 {
    static TSST_NONE := 0
    static TSST_SIZE := 1
    static TSST_DPI := 2
}
struct GLYPHFONTSIZINGTYPE extends Int32 {
    static GFST_NONE := 0
    static GFST_SIZE := 1
    static GFST_DPI := 2
}
struct LINKPARTS extends Int32 {
    static LP_HYPERLINK := 1
}
struct HYPERLINKSTATES extends Int32 {
    static HLS_NORMALTEXT := 1
    static HLS_LINKTEXT := 2
}
struct EMPTYMARKUPPARTS extends Int32 {
    static EMP_MARKUPTEXT := 1
}
struct MARKUPTEXTSTATES extends Int32 {
    static EMT_NORMALTEXT := 1
    static EMT_LINKTEXT := 2
}
struct STATICPARTS extends Int32 {
    static STAT_TEXT := 1
}
struct PAGEPARTS extends Int32 {
    static PGRP_UP := 1
    static PGRP_DOWN := 2
    static PGRP_UPHORZ := 3
    static PGRP_DOWNHORZ := 4
}
struct MONTHCALPARTS extends Int32 {
    static MC_BACKGROUND := 1
    static MC_BORDERS := 2
    static MC_GRIDBACKGROUND := 3
    static MC_COLHEADERSPLITTER := 4
    static MC_GRIDCELLBACKGROUND := 5
    static MC_GRIDCELL := 6
    static MC_GRIDCELLUPPER := 7
    static MC_TRAILINGGRIDCELL := 8
    static MC_TRAILINGGRIDCELLUPPER := 9
    static MC_NAVNEXT := 10
    static MC_NAVPREV := 11
}
struct GRIDCELLBACKGROUNDSTATES extends Int32 {
    static MCGCB_SELECTED := 1
    static MCGCB_HOT := 2
    static MCGCB_SELECTEDHOT := 3
    static MCGCB_SELECTEDNOTFOCUSED := 4
    static MCGCB_TODAY := 5
    static MCGCB_TODAYSELECTED := 6
}
struct GRIDCELLSTATES extends Int32 {
    static MCGC_HOT := 1
    static MCGC_HASSTATE := 2
    static MCGC_HASSTATEHOT := 3
    static MCGC_TODAY := 4
    static MCGC_TODAYSELECTED := 5
    static MCGC_SELECTED := 6
    static MCGC_SELECTEDHOT := 7
}
struct GRIDCELLUPPERSTATES extends Int32 {
    static MCGCU_HOT := 1
    static MCGCU_HASSTATE := 2
    static MCGCU_HASSTATEHOT := 3
    static MCGCU_SELECTED := 4
    static MCGCU_SELECTEDHOT := 5
}
struct TRAILINGGRIDCELLSTATES extends Int32 {
    static MCTGC_HOT := 1
    static MCTGC_HASSTATE := 2
    static MCTGC_HASSTATEHOT := 3
    static MCTGC_TODAY := 4
    static MCTGC_TODAYSELECTED := 5
    static MCTGC_SELECTED := 6
    static MCTGC_SELECTEDHOT := 7
}
struct TRAILINGGRIDCELLUPPERSTATES extends Int32 {
    static MCTGCU_HOT := 1
    static MCTGCU_HASSTATE := 2
    static MCTGCU_HASSTATEHOT := 3
    static MCTGCU_SELECTED := 4
    static MCTGCU_SELECTEDHOT := 5
}
struct NAVNEXTSTATES extends Int32 {
    static MCNN_NORMAL := 1
    static MCNN_HOT := 2
    static MCNN_PRESSED := 3
    static MCNN_DISABLED := 4
}
struct NAVPREVSTATES extends Int32 {
    static MCNP_NORMAL := 1
    static MCNP_HOT := 2
    static MCNP_PRESSED := 3
    static MCNP_DISABLED := 4
}
struct CLOCKPARTS extends Int32 {
    static CLP_TIME := 1
}
struct CLOCKSTATES extends Int32 {
    static CLS_NORMAL := 1
    static CLS_HOT := 2
    static CLS_PRESSED := 3
}
struct TRAYNOTIFYPARTS extends Int32 {
    static TNP_BACKGROUND := 1
    static TNP_ANIMBACKGROUND := 2
}
struct TASKBARPARTS extends Int32 {
    static TBP_BACKGROUNDBOTTOM := 1
    static TBP_BACKGROUNDRIGHT := 2
    static TBP_BACKGROUNDTOP := 3
    static TBP_BACKGROUNDLEFT := 4
    static TBP_SIZINGBARBOTTOM := 5
    static TBP_SIZINGBARRIGHT := 6
    static TBP_SIZINGBARTOP := 7
    static TBP_SIZINGBARLEFT := 8
}
struct TASKBANDPARTS extends Int32 {
    static TDP_GROUPCOUNT := 1
    static TDP_FLASHBUTTON := 2
    static TDP_FLASHBUTTONGROUPMENU := 3
}
struct STARTPANELPARTS extends Int32 {
    static SPP_USERPANE := 1
    static SPP_MOREPROGRAMS := 2
    static SPP_MOREPROGRAMSARROW := 3
    static SPP_PROGLIST := 4
    static SPP_PROGLISTSEPARATOR := 5
    static SPP_PLACESLIST := 6
    static SPP_PLACESLISTSEPARATOR := 7
    static SPP_LOGOFF := 8
    static SPP_LOGOFFBUTTONS := 9
    static SPP_USERPICTURE := 10
    static SPP_PREVIEW := 11
    static SPP_MOREPROGRAMSTAB := 12
    static SPP_NSCHOST := 13
    static SPP_SOFTWAREEXPLORER := 14
    static SPP_OPENBOX := 15
    static SPP_SEARCHVIEW := 16
    static SPP_MOREPROGRAMSARROWBACK := 17
    static SPP_TOPMATCH := 18
    static SPP_LOGOFFSPLITBUTTONDROPDOWN := 19
}
struct MOREPROGRAMSTABSTATES extends Int32 {
    static SPMPT_NORMAL := 1
    static SPMPT_HOT := 2
    static SPMPT_SELECTED := 3
    static SPMPT_DISABLED := 4
    static SPMPT_FOCUSED := 5
}
struct SOFTWAREEXPLORERSTATES extends Int32 {
    static SPSE_NORMAL := 1
    static SPSE_HOT := 2
    static SPSE_SELECTED := 3
    static SPSE_DISABLED := 4
    static SPSE_FOCUSED := 5
}
struct OPENBOXSTATES extends Int32 {
    static SPOB_NORMAL := 1
    static SPOB_HOT := 2
    static SPOB_SELECTED := 3
    static SPOB_DISABLED := 4
    static SPOB_FOCUSED := 5
}
struct MOREPROGRAMSARROWSTATES extends Int32 {
    static SPS_NORMAL := 1
    static SPS_HOT := 2
    static SPS_PRESSED := 3
}
struct MOREPROGRAMSARROWBACKSTATES extends Int32 {
    static SPSB_NORMAL := 1
    static SPSB_HOT := 2
    static SPSB_PRESSED := 3
}
struct LOGOFFBUTTONSSTATES extends Int32 {
    static SPLS_NORMAL := 1
    static SPLS_HOT := 2
    static SPLS_PRESSED := 3
}
struct MENUBANDPARTS extends Int32 {
    static MDP_NEWAPPBUTTON := 1
    static MDP_SEPERATOR := 2
}
struct MENUBANDSTATES extends Int32 {
    static MDS_NORMAL := 1
    static MDS_HOT := 2
    static MDS_PRESSED := 3
    static MDS_DISABLED := 4
    static MDS_CHECKED := 5
    static MDS_HOTCHECKED := 6
}
struct CCSTYLEA {
    flStyle : UInt32
    flExtStyle : UInt32
    szText : CHAR[256]
    lgid : UInt16
    wReserved1 : UInt16
}
struct CCSTYLEW {
    flStyle : UInt32
    flExtStyle : UInt32
    szText : UInt16[256]
    lgid : UInt16
    wReserved1 : UInt16
}
struct LPFNCCSTYLEA extends FunctionPointer {
    static Types := [HWND, CCSTYLEA.Ptr, BOOL]
}
struct LPFNCCSTYLEW extends FunctionPointer {
    static Types := [HWND, CCSTYLEW.Ptr, BOOL]
}
struct LPFNCCSIZETOTEXTA extends FunctionPointer {
    static Types := [UInt32, UInt32, HFONT, PSTR, Int32]
}
struct LPFNCCSIZETOTEXTW extends FunctionPointer {
    static Types := [UInt32, UInt32, HFONT, PWSTR, Int32]
}
struct CCSTYLEFLAGA {
    flStyle : UInt32
    flStyleMask : UInt32
    pszStyle : PSTR
}
struct CCSTYLEFLAGW {
    flStyle : UInt32
    flStyleMask : UInt32
    pszStyle : PWSTR
}
struct CCINFOA {
    szClass : CHAR[32]
    flOptions : UInt32
    szDesc : CHAR[32]
    cxDefault : UInt32
    cyDefault : UInt32
    flStyleDefault : UInt32
    flExtStyleDefault : UInt32
    flCtrlTypeMask : UInt32
    szTextDefault : CHAR[256]
    cStyleFlags : Int32
    aStyleFlags : CCSTYLEFLAGA.Ptr
    lpfnStyle : LPFNCCSTYLEA
    lpfnSizeToText : LPFNCCSIZETOTEXTA
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct CCINFOW {
    szClass : UInt16[32]
    flOptions : UInt32
    szDesc : UInt16[32]
    cxDefault : UInt32
    cyDefault : UInt32
    flStyleDefault : UInt32
    flExtStyleDefault : UInt32
    flCtrlTypeMask : UInt32
    cStyleFlags : Int32
    aStyleFlags : CCSTYLEFLAGW.Ptr
    szTextDefault : UInt16[256]
    lpfnStyle : LPFNCCSTYLEW
    lpfnSizeToText : LPFNCCSIZETOTEXTW
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct LPFNCCINFOA extends FunctionPointer {
    static Types := [CCINFOA.Ptr, UInt32]
}
struct LPFNCCINFOW extends FunctionPointer {
    static Types := [CCINFOW.Ptr, UInt32]
}
struct EDITWORDBREAKPROCA extends FunctionPointer {
    static Types := [PSTR, Int32, Int32, WORD_BREAK_ACTION, Int32]
}
struct EDITWORDBREAKPROCW extends FunctionPointer {
    static Types := [PWSTR, Int32, Int32, WORD_BREAK_ACTION, Int32]
}
struct NMHDR {
    hwndFrom : HWND
    idFrom : IntPtr
    code : UInt32
}
struct MEASUREITEMSTRUCT {
    CtlType : DRAWITEMSTRUCT_CTL_TYPE
    CtlID : UInt32
    itemID : UInt32
    itemWidth : UInt32
    itemHeight : UInt32
    itemData : IntPtr
}
struct DRAWITEMSTRUCT {
    CtlType : DRAWITEMSTRUCT_CTL_TYPE
    CtlID : UInt32
    itemID : UInt32
    itemAction : ODA_FLAGS
    itemState : ODS_FLAGS
    hwndItem : HWND
    hDC : HDC
    rcItem : RECT
    itemData : IntPtr
}
struct DELETEITEMSTRUCT {
    CtlType : DRAWITEMSTRUCT_CTL_TYPE
    CtlID : UInt32
    itemID : UInt32
    hwndItem : HWND
    itemData : IntPtr
}
struct COMPAREITEMSTRUCT {
    CtlType : DRAWITEMSTRUCT_CTL_TYPE
    CtlID : UInt32
    hwndItem : HWND
    itemID1 : UInt32
    itemData1 : IntPtr
    itemID2 : UInt32
    itemData2 : IntPtr
    dwLocaleId : UInt32
}
struct USAGE_PROPERTIES {
    level : UInt16
    page : UInt16
    usage : UInt16
    logicalMinimum : Int32
    logicalMaximum : Int32
    unit : UInt16
    exponent : UInt16
    count : UInt8
    physicalMinimum : Int32
    physicalMaximum : Int32
}
struct SYNTHETIC_DEVICE_CREATION_OPTIONS extends Int32 {
    static SDCO_NONE := 0
    static SDCO_PHYSICAL_SIZE := 1
    static SDCO_TOUCHPAD_GESTURE_ONLY := 2
}
struct SYNTHETIC_DEVICE_CREATION_PARAMS {
    pointerType : POINTER_INPUT_TYPE
    maxCount : UInt32
    feedbackMode : POINTER_FEEDBACK_MODE
    hMonitor : HMONITOR
    deviceWidth : UInt32
    deviceHeight : UInt32
    options : SYNTHETIC_DEVICE_CREATION_OPTIONS
}
struct TOUCH_HIT_TESTING_PROXIMITY_EVALUATION {
    score : UInt16
    adjustedPoint : POINT
}
struct TOUCH_HIT_TESTING_INPUT {
    pointerId : UInt32
    point : POINT
    boundingBox : RECT
    nonOccludedBoundingBox : RECT
    orientation : UInt32
}
struct FEEDBACK_TYPE extends Int32 {
    static FEEDBACK_TOUCH_CONTACTVISUALIZATION := 1
    static FEEDBACK_PEN_BARRELVISUALIZATION := 2
    static FEEDBACK_PEN_TAP := 3
    static FEEDBACK_PEN_DOUBLETAP := 4
    static FEEDBACK_PEN_PRESSANDHOLD := 5
    static FEEDBACK_PEN_RIGHTTAP := 6
    static FEEDBACK_TOUCH_TAP := 7
    static FEEDBACK_TOUCH_DOUBLETAP := 8
    static FEEDBACK_TOUCH_PRESSANDHOLD := 9
    static FEEDBACK_TOUCH_RIGHTTAP := 10
    static FEEDBACK_GESTURE_PRESSANDTAP := 11
    static FEEDBACK_MAX := -1
}
struct COMBOBOXINFO {
    cbSize : UInt32 := this.Size
    rcItem : RECT
    rcButton : RECT
    stateButton : COMBOBOXINFO_BUTTON_STATE
    hwndCombo : HWND
    hwndItem : HWND
    hwndList : HWND
}
