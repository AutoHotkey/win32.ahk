#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, COLORREF, HANDLE, HMODULE, HWND, LPARAM, POINT, POINTL, POINTS, PSTR, PWSTR, RECT, RECTL, SIZE, WPARAM}

struct R2_MODE extends Int32 {
    static R2_BLACK := 1
    static R2_NOTMERGEPEN := 2
    static R2_MASKNOTPEN := 3
    static R2_NOTCOPYPEN := 4
    static R2_MASKPENNOT := 5
    static R2_NOT := 6
    static R2_XORPEN := 7
    static R2_NOTMASKPEN := 8
    static R2_MASKPEN := 9
    static R2_NOTXORPEN := 10
    static R2_NOP := 11
    static R2_MERGENOTPEN := 12
    static R2_COPYPEN := 13
    static R2_MERGEPENNOT := 14
    static R2_MERGEPEN := 15
    static R2_WHITE := 16
    static R2_LAST := 16
}
struct RGN_COMBINE_MODE extends Int32 {
    static RGN_AND := 1
    static RGN_OR := 2
    static RGN_XOR := 3
    static RGN_DIFF := 4
    static RGN_COPY := 5
    static RGN_MIN := 1
    static RGN_MAX := 5
}
struct ETO_OPTIONS extends UInt32 {
    static ETO_OPAQUE := 2
    static ETO_CLIPPED := 4
    static ETO_GLYPH_INDEX := 16
    static ETO_RTLREADING := 128
    static ETO_NUMERICSLOCAL := 1024
    static ETO_NUMERICSLATIN := 2048
    static ETO_IGNORELANGUAGE := 4096
    static ETO_PDY := 8192
    static ETO_REVERSE_INDEX_MAP := 65536
}
struct OBJ_TYPE extends Int32 {
    static OBJ_PEN := 1
    static OBJ_BRUSH := 2
    static OBJ_DC := 3
    static OBJ_METADC := 4
    static OBJ_PAL := 5
    static OBJ_FONT := 6
    static OBJ_BITMAP := 7
    static OBJ_REGION := 8
    static OBJ_METAFILE := 9
    static OBJ_MEMDC := 10
    static OBJ_EXTPEN := 11
    static OBJ_ENHMETADC := 12
    static OBJ_ENHMETAFILE := 13
    static OBJ_COLORSPACE := 14
}
struct DIB_USAGE extends UInt32 {
    static DIB_RGB_COLORS := 0
    static DIB_PAL_COLORS := 1
}
struct MONITORINFOEXA {
    monitorInfo : MONITORINFO
    szDevice : CHAR[32]
}
struct MONITORINFOEXW {
    monitorInfo : MONITORINFO
    szDevice : UInt16[32]
}
struct DRAWEDGE_FLAGS extends UInt32 {
    static BDR_RAISEDOUTER := 1
    static BDR_SUNKENOUTER := 2
    static BDR_RAISEDINNER := 4
    static BDR_SUNKENINNER := 8
    static BDR_OUTER := 3
    static BDR_INNER := 12
    static BDR_RAISED := 5
    static BDR_SUNKEN := 10
    static EDGE_RAISED := 5
    static EDGE_SUNKEN := 10
    static EDGE_ETCHED := 6
    static EDGE_BUMP := 9
}
struct DFC_TYPE extends UInt32 {
    static DFC_CAPTION := 1
    static DFC_MENU := 2
    static DFC_SCROLL := 3
    static DFC_BUTTON := 4
    static DFC_POPUPMENU := 5
}
struct DFCS_STATE extends UInt32 {
    static DFCS_CAPTIONCLOSE := 0
    static DFCS_CAPTIONMIN := 1
    static DFCS_CAPTIONMAX := 2
    static DFCS_CAPTIONRESTORE := 3
    static DFCS_CAPTIONHELP := 4
    static DFCS_MENUARROW := 0
    static DFCS_MENUCHECK := 1
    static DFCS_MENUBULLET := 2
    static DFCS_MENUARROWRIGHT := 4
    static DFCS_SCROLLUP := 0
    static DFCS_SCROLLDOWN := 1
    static DFCS_SCROLLLEFT := 2
    static DFCS_SCROLLRIGHT := 3
    static DFCS_SCROLLCOMBOBOX := 5
    static DFCS_SCROLLSIZEGRIP := 8
    static DFCS_SCROLLSIZEGRIPRIGHT := 16
    static DFCS_BUTTONCHECK := 0
    static DFCS_BUTTONRADIOIMAGE := 1
    static DFCS_BUTTONRADIOMASK := 2
    static DFCS_BUTTONRADIO := 4
    static DFCS_BUTTON3STATE := 8
    static DFCS_BUTTONPUSH := 16
    static DFCS_INACTIVE := 256
    static DFCS_PUSHED := 512
    static DFCS_CHECKED := 1024
    static DFCS_TRANSPARENT := 2048
    static DFCS_HOT := 4096
    static DFCS_ADJUSTRECT := 8192
    static DFCS_FLAT := 16384
    static DFCS_MONO := 32768
}
struct CDS_TYPE extends UInt32 {
    static CDS_FULLSCREEN := 4
    static CDS_GLOBAL := 8
    static CDS_NORESET := 268435456
    static CDS_RESET := 1073741824
    static CDS_SET_PRIMARY := 16
    static CDS_TEST := 2
    static CDS_UPDATEREGISTRY := 1
    static CDS_VIDEOPARAMETERS := 32
    static CDS_ENABLE_UNSAFE_MODES := 256
    static CDS_DISABLE_UNSAFE_MODES := 512
    static CDS_RESET_EX := 536870912
}
struct DISP_CHANGE extends Int32 {
    static DISP_CHANGE_SUCCESSFUL := 0
    static DISP_CHANGE_RESTART := 1
    static DISP_CHANGE_FAILED := -1
    static DISP_CHANGE_BADMODE := -2
    static DISP_CHANGE_NOTUPDATED := -3
    static DISP_CHANGE_BADFLAGS := -4
    static DISP_CHANGE_BADPARAM := -5
    static DISP_CHANGE_BADDUALVIEW := -6
}
struct DRAWSTATE_FLAGS extends UInt32 {
    static DST_COMPLEX := 0
    static DST_TEXT := 1
    static DST_PREFIXTEXT := 2
    static DST_ICON := 3
    static DST_BITMAP := 4
    static DSS_NORMAL := 0
    static DSS_UNION := 16
    static DSS_DISABLED := 32
    static DSS_MONO := 128
    static DSS_HIDEPREFIX := 512
    static DSS_PREFIXONLY := 1024
    static DSS_RIGHT := 32768
}
struct REDRAW_WINDOW_FLAGS extends UInt32 {
    static RDW_INVALIDATE := 1
    static RDW_INTERNALPAINT := 2
    static RDW_ERASE := 4
    static RDW_VALIDATE := 8
    static RDW_NOINTERNALPAINT := 16
    static RDW_NOERASE := 32
    static RDW_NOCHILDREN := 64
    static RDW_ALLCHILDREN := 128
    static RDW_UPDATENOW := 256
    static RDW_ERASENOW := 512
    static RDW_FRAME := 1024
    static RDW_NOFRAME := 2048
}
struct ENUM_DISPLAY_SETTINGS_MODE extends UInt32 {
    static ENUM_CURRENT_SETTINGS := 4294967295
    static ENUM_REGISTRY_SETTINGS := 4294967294
}
struct TEXT_ALIGN_OPTIONS extends UInt32 {
    static TA_NOUPDATECP := 0
    static TA_UPDATECP := 1
    static TA_LEFT := 0
    static TA_RIGHT := 2
    static TA_CENTER := 6
    static TA_TOP := 0
    static TA_BOTTOM := 8
    static TA_BASELINE := 24
    static TA_RTLREADING := 256
    static TA_MASK := 287
    static VTA_BASELINE := 24
    static VTA_LEFT := 8
    static VTA_RIGHT := 0
    static VTA_CENTER := 6
    static VTA_BOTTOM := 2
    static VTA_TOP := 0
}
struct PEN_STYLE extends Int32 {
    static PS_GEOMETRIC := 65536
    static PS_COSMETIC := 0
    static PS_SOLID := 0
    static PS_DASH := 1
    static PS_DOT := 2
    static PS_DASHDOT := 3
    static PS_DASHDOTDOT := 4
    static PS_NULL := 5
    static PS_INSIDEFRAME := 6
    static PS_USERSTYLE := 7
    static PS_ALTERNATE := 8
    static PS_STYLE_MASK := 15
    static PS_ENDCAP_ROUND := 0
    static PS_ENDCAP_SQUARE := 256
    static PS_ENDCAP_FLAT := 512
    static PS_ENDCAP_MASK := 3840
    static PS_JOIN_ROUND := 0
    static PS_JOIN_BEVEL := 4096
    static PS_JOIN_MITER := 8192
    static PS_JOIN_MASK := 61440
    static PS_TYPE_MASK := 983040
}
struct TTEMBED_FLAGS extends UInt32 {
    static TTEMBED_EMBEDEUDC := 32
    static TTEMBED_RAW := 0
    static TTEMBED_SUBSET := 1
    static TTEMBED_TTCOMPRESSED := 4
}
struct DRAW_TEXT_FORMAT extends UInt32 {
    static DT_BOTTOM := 8
    static DT_CALCRECT := 1024
    static DT_CENTER := 1
    static DT_EDITCONTROL := 8192
    static DT_END_ELLIPSIS := 32768
    static DT_EXPANDTABS := 64
    static DT_EXTERNALLEADING := 512
    static DT_HIDEPREFIX := 1048576
    static DT_INTERNAL := 4096
    static DT_LEFT := 0
    static DT_MODIFYSTRING := 65536
    static DT_NOCLIP := 256
    static DT_NOFULLWIDTHCHARBREAK := 524288
    static DT_NOPREFIX := 2048
    static DT_PATH_ELLIPSIS := 16384
    static DT_PREFIXONLY := 2097152
    static DT_RIGHT := 2
    static DT_RTLREADING := 131072
    static DT_SINGLELINE := 32
    static DT_TABSTOP := 128
    static DT_TOP := 0
    static DT_VCENTER := 4
    static DT_WORDBREAK := 16
    static DT_WORD_ELLIPSIS := 262144
}
struct EMBED_FONT_CHARSET extends UInt32 {
    static CHARSET_UNICODE := 1
    static CHARSET_SYMBOL := 2
}
struct GET_DCX_FLAGS extends UInt32 {
    static DCX_WINDOW := 1
    static DCX_CACHE := 2
    static DCX_PARENTCLIP := 32
    static DCX_CLIPSIBLINGS := 16
    static DCX_CLIPCHILDREN := 8
    static DCX_NORESETATTRS := 4
    static DCX_LOCKWINDOWUPDATE := 1024
    static DCX_EXCLUDERGN := 64
    static DCX_INTERSECTRGN := 128
    static DCX_INTERSECTUPDATE := 512
    static DCX_VALIDATE := 2097152
}
struct GET_GLYPH_OUTLINE_FORMAT extends UInt32 {
    static GGO_BEZIER := 3
    static GGO_BITMAP := 1
    static GGO_GLYPH_INDEX := 128
    static GGO_GRAY2_BITMAP := 4
    static GGO_GRAY4_BITMAP := 5
    static GGO_GRAY8_BITMAP := 6
    static GGO_METRICS := 0
    static GGO_NATIVE := 2
    static GGO_UNHINTED := 256
}
struct SET_BOUNDS_RECT_FLAGS extends UInt32 {
    static DCB_ACCUMULATE := 2
    static DCB_DISABLE := 8
    static DCB_ENABLE := 4
    static DCB_RESET := 1
}
struct GET_STOCK_OBJECT_FLAGS extends Int32 {
    static BLACK_BRUSH := 4
    static DKGRAY_BRUSH := 3
    static DC_BRUSH := 18
    static GRAY_BRUSH := 2
    static HOLLOW_BRUSH := 5
    static LTGRAY_BRUSH := 1
    static NULL_BRUSH := 5
    static WHITE_BRUSH := 0
    static BLACK_PEN := 7
    static DC_PEN := 19
    static NULL_PEN := 8
    static WHITE_PEN := 6
    static ANSI_FIXED_FONT := 11
    static ANSI_VAR_FONT := 12
    static DEVICE_DEFAULT_FONT := 14
    static DEFAULT_GUI_FONT := 17
    static OEM_FIXED_FONT := 10
    static SYSTEM_FONT := 13
    static SYSTEM_FIXED_FONT := 16
    static DEFAULT_PALETTE := 15
}
struct MODIFY_WORLD_TRANSFORM_MODE extends UInt32 {
    static MWT_IDENTITY := 1
    static MWT_LEFTMULTIPLY := 2
    static MWT_RIGHTMULTIPLY := 3
}
struct FONT_CLIP_PRECISION extends UInt8 {
    static CLIP_DEFAULT_PRECIS := 0
    static CLIP_CHARACTER_PRECIS := 1
    static CLIP_STROKE_PRECIS := 2
    static CLIP_MASK := 15
    static CLIP_LH_ANGLES := 16
    static CLIP_TT_ALWAYS := 32
    static CLIP_DFA_DISABLE := 64
    static CLIP_EMBEDDED := 128
    static CLIP_DFA_OVERRIDE := 64
}
struct CREATE_POLYGON_RGN_MODE extends Int32 {
    static ALTERNATE := 1
    static WINDING := 2
}
struct EMBEDDED_FONT_PRIV_STATUS extends UInt32 {
    static EMBED_PREVIEWPRINT := 1
    static EMBED_EDITABLE := 2
    static EMBED_INSTALLABLE := 3
    static EMBED_NOEMBEDDING := 4
}
struct MONITOR_FROM_FLAGS extends UInt32 {
    static MONITOR_DEFAULTTONEAREST := 2
    static MONITOR_DEFAULTTONULL := 0
    static MONITOR_DEFAULTTOPRIMARY := 1
}
struct FONT_RESOURCE_CHARACTERISTICS extends UInt32 {
    static FR_PRIVATE := 16
    static FR_NOT_ENUM := 32
}
struct DC_LAYOUT extends UInt32 {
    static LAYOUT_BITMAPORIENTATIONPRESERVED := 8
    static LAYOUT_RTL := 1
}
struct GET_DEVICE_CAPS_INDEX extends UInt32 {
    static DRIVERVERSION := 0
    static TECHNOLOGY := 2
    static HORZSIZE := 4
    static VERTSIZE := 6
    static HORZRES := 8
    static VERTRES := 10
    static BITSPIXEL := 12
    static PLANES := 14
    static NUMBRUSHES := 16
    static NUMPENS := 18
    static NUMMARKERS := 20
    static NUMFONTS := 22
    static NUMCOLORS := 24
    static PDEVICESIZE := 26
    static CURVECAPS := 28
    static LINECAPS := 30
    static POLYGONALCAPS := 32
    static TEXTCAPS := 34
    static CLIPCAPS := 36
    static RASTERCAPS := 38
    static ASPECTX := 40
    static ASPECTY := 42
    static ASPECTXY := 44
    static LOGPIXELSX := 88
    static LOGPIXELSY := 90
    static SIZEPALETTE := 104
    static NUMRESERVED := 106
    static COLORRES := 108
    static PHYSICALWIDTH := 110
    static PHYSICALHEIGHT := 111
    static PHYSICALOFFSETX := 112
    static PHYSICALOFFSETY := 113
    static SCALINGFACTORX := 114
    static SCALINGFACTORY := 115
    static VREFRESH := 116
    static DESKTOPVERTRES := 117
    static DESKTOPHORZRES := 118
    static BLTALIGNMENT := 119
    static SHADEBLENDCAPS := 120
    static COLORMGMTCAPS := 121
}
struct FONT_OUTPUT_PRECISION extends UInt8 {
    static OUT_DEFAULT_PRECIS := 0
    static OUT_STRING_PRECIS := 1
    static OUT_CHARACTER_PRECIS := 2
    static OUT_STROKE_PRECIS := 3
    static OUT_TT_PRECIS := 4
    static OUT_DEVICE_PRECIS := 5
    static OUT_RASTER_PRECIS := 6
    static OUT_TT_ONLY_PRECIS := 7
    static OUT_OUTLINE_PRECIS := 8
    static OUT_SCREEN_OUTLINE_PRECIS := 9
    static OUT_PS_ONLY_PRECIS := 10
}
struct FONT_WEIGHT extends UInt32 {
    static FW_DONTCARE := 0
    static FW_THIN := 100
    static FW_EXTRALIGHT := 200
    static FW_LIGHT := 300
    static FW_NORMAL := 400
    static FW_MEDIUM := 500
    static FW_SEMIBOLD := 600
    static FW_BOLD := 700
    static FW_EXTRABOLD := 800
    static FW_HEAVY := 900
    static FW_ULTRALIGHT := 200
    static FW_REGULAR := 400
    static FW_DEMIBOLD := 600
    static FW_ULTRABOLD := 800
    static FW_BLACK := 900
}
struct FONT_CHARSET extends UInt8 {
    static ANSI_CHARSET := 0
    static DEFAULT_CHARSET := 1
    static SYMBOL_CHARSET := 2
    static SHIFTJIS_CHARSET := 128
    static HANGEUL_CHARSET := 129
    static HANGUL_CHARSET := 129
    static GB2312_CHARSET := 134
    static CHINESEBIG5_CHARSET := 136
    static OEM_CHARSET := 255
    static JOHAB_CHARSET := 130
    static HEBREW_CHARSET := 177
    static ARABIC_CHARSET := 178
    static GREEK_CHARSET := 161
    static TURKISH_CHARSET := 162
    static VIETNAMESE_CHARSET := 163
    static THAI_CHARSET := 222
    static EASTEUROPE_CHARSET := 238
    static RUSSIAN_CHARSET := 204
    static MAC_CHARSET := 77
    static BALTIC_CHARSET := 186
}
struct ARC_DIRECTION extends Int32 {
    static AD_COUNTERCLOCKWISE := 1
    static AD_CLOCKWISE := 2
}
struct TTLOAD_EMBEDDED_FONT_STATUS extends UInt32 {
    static TTLOAD_FONT_SUBSETTED := 1
    static TTLOAD_FONT_IN_SYSSTARTUP := 2
}
struct STRETCH_BLT_MODE extends Int32 {
    static BLACKONWHITE := 1
    static COLORONCOLOR := 3
    static HALFTONE := 4
    static STRETCH_ANDSCANS := 1
    static STRETCH_DELETESCANS := 3
    static STRETCH_HALFTONE := 4
    static STRETCH_ORSCANS := 2
    static WHITEONBLACK := 2
}
struct FONT_QUALITY extends UInt8 {
    static DEFAULT_QUALITY := 0
    static DRAFT_QUALITY := 1
    static PROOF_QUALITY := 2
    static NONANTIALIASED_QUALITY := 3
    static ANTIALIASED_QUALITY := 4
    static CLEARTYPE_QUALITY := 5
}
struct BACKGROUND_MODE extends UInt32 {
    static OPAQUE := 2
    static TRANSPARENT := 1
}
struct GET_CHARACTER_PLACEMENT_FLAGS extends UInt32 {
    static GCP_CLASSIN := 524288
    static GCP_DIACRITIC := 256
    static GCP_DISPLAYZWG := 4194304
    static GCP_GLYPHSHAPE := 16
    static GCP_JUSTIFY := 65536
    static GCP_KASHIDA := 1024
    static GCP_LIGATE := 32
    static GCP_MAXEXTENT := 1048576
    static GCP_NEUTRALOVERRIDE := 33554432
    static GCP_NUMERICOVERRIDE := 16777216
    static GCP_NUMERICSLATIN := 67108864
    static GCP_NUMERICSLOCAL := 134217728
    static GCP_REORDER := 2
    static GCP_SYMSWAPOFF := 8388608
    static GCP_USEKERNING := 8
}
struct DRAW_EDGE_FLAGS extends UInt32 {
    static BF_ADJUST := 8192
    static BF_BOTTOM := 8
    static BF_BOTTOMLEFT := 9
    static BF_BOTTOMRIGHT := 12
    static BF_DIAGONAL := 16
    static BF_DIAGONAL_ENDBOTTOMLEFT := 25
    static BF_DIAGONAL_ENDBOTTOMRIGHT := 28
    static BF_DIAGONAL_ENDTOPLEFT := 19
    static BF_DIAGONAL_ENDTOPRIGHT := 22
    static BF_FLAT := 16384
    static BF_LEFT := 1
    static BF_MIDDLE := 2048
    static BF_MONO := 32768
    static BF_RECT := 15
    static BF_RIGHT := 4
    static BF_SOFT := 4096
    static BF_TOP := 2
    static BF_TOPLEFT := 3
    static BF_TOPRIGHT := 6
}
struct SYS_COLOR_INDEX extends Int32 {
    static COLOR_SCROLLBAR := 0
    static COLOR_BACKGROUND := 1
    static COLOR_ACTIVECAPTION := 2
    static COLOR_INACTIVECAPTION := 3
    static COLOR_MENU := 4
    static COLOR_WINDOW := 5
    static COLOR_WINDOWFRAME := 6
    static COLOR_MENUTEXT := 7
    static COLOR_WINDOWTEXT := 8
    static COLOR_CAPTIONTEXT := 9
    static COLOR_ACTIVEBORDER := 10
    static COLOR_INACTIVEBORDER := 11
    static COLOR_APPWORKSPACE := 12
    static COLOR_HIGHLIGHT := 13
    static COLOR_HIGHLIGHTTEXT := 14
    static COLOR_BTNFACE := 15
    static COLOR_BTNSHADOW := 16
    static COLOR_GRAYTEXT := 17
    static COLOR_BTNTEXT := 18
    static COLOR_INACTIVECAPTIONTEXT := 19
    static COLOR_BTNHIGHLIGHT := 20
    static COLOR_3DDKSHADOW := 21
    static COLOR_3DLIGHT := 22
    static COLOR_INFOTEXT := 23
    static COLOR_INFOBK := 24
    static COLOR_HOTLIGHT := 26
    static COLOR_GRADIENTACTIVECAPTION := 27
    static COLOR_GRADIENTINACTIVECAPTION := 28
    static COLOR_MENUHILIGHT := 29
    static COLOR_MENUBAR := 30
    static COLOR_DESKTOP := 1
    static COLOR_3DFACE := 15
    static COLOR_3DSHADOW := 16
    static COLOR_3DHIGHLIGHT := 20
    static COLOR_3DHILIGHT := 20
    static COLOR_BTNHILIGHT := 20
}
struct FONT_LICENSE_PRIVS extends UInt32 {
    static LICENSE_PREVIEWPRINT := 4
    static LICENSE_EDITABLE := 8
    static LICENSE_INSTALLABLE := 0
    static LICENSE_NOEMBEDDING := 2
    static LICENSE_DEFAULT := 0
}
struct GRADIENT_FILL extends UInt32 {
    static GRADIENT_FILL_RECT_H := 0
    static GRADIENT_FILL_RECT_V := 1
    static GRADIENT_FILL_TRIANGLE := 2
}
struct CREATE_FONT_PACKAGE_SUBSET_ENCODING extends Int16 {
    static TTFCFP_STD_MAC_CHAR_SET := 0
    static TTFCFP_SYMBOL_CHAR_SET := 0
    static TTFCFP_UNICODE_CHAR_SET := 1
}
struct EXT_FLOOD_FILL_TYPE extends UInt32 {
    static FLOODFILLBORDER := 0
    static FLOODFILLSURFACE := 1
}
struct HATCH_BRUSH_STYLE extends Int32 {
    static HS_BDIAGONAL := 3
    static HS_CROSS := 4
    static HS_DIAGCROSS := 5
    static HS_FDIAGONAL := 2
    static HS_HORIZONTAL := 0
    static HS_VERTICAL := 1
}
struct DRAW_CAPTION_FLAGS extends UInt32 {
    static DC_ACTIVE := 1
    static DC_BUTTONS := 4096
    static DC_GRADIENT := 32
    static DC_ICON := 4
    static DC_INBUTTON := 16
    static DC_SMALLCAP := 2
    static DC_TEXT := 8
}
struct SYSTEM_PALETTE_USE extends UInt32 {
    static SYSPAL_NOSTATIC := 2
    static SYSPAL_NOSTATIC256 := 3
    static SYSPAL_STATIC := 1
}
struct GRAPHICS_MODE extends Int32 {
    static GM_COMPATIBLE := 1
    static GM_ADVANCED := 2
}
struct FONT_PITCH extends UInt8 {
    static DEFAULT_PITCH := 0
    static FIXED_PITCH := 1
    static VARIABLE_PITCH := 2
}
struct FONT_FAMILY extends UInt8 {
    static FF_DECORATIVE := 80
    static FF_DONTCARE := 0
    static FF_MODERN := 48
    static FF_ROMAN := 16
    static FF_SCRIPT := 64
    static FF_SWISS := 32
}
struct ROP_CODE extends UInt32 {
    static BLACKNESS := 66
    static NOTSRCERASE := 1114278
    static NOTSRCCOPY := 3342344
    static SRCERASE := 4457256
    static DSTINVERT := 5570569
    static PATINVERT := 5898313
    static SRCINVERT := 6684742
    static SRCAND := 8913094
    static MERGEPAINT := 12255782
    static MERGECOPY := 12583114
    static SRCCOPY := 13369376
    static SRCPAINT := 15597702
    static PATCOPY := 15728673
    static PATPAINT := 16452105
    static WHITENESS := 16711778
    static CAPTUREBLT := 1073741824
    static NOMIRRORBITMAP := 2147483648
}
struct CREATE_FONT_PACKAGE_SUBSET_PLATFORM extends Int16 {
    static TTFCFP_UNICODE_PLATFORMID := 0
    static TTFCFP_ISO_PLATFORMID := 2
}
struct HDC_MAP_MODE extends Int32 {
    static MM_ANISOTROPIC := 8
    static MM_HIENGLISH := 5
    static MM_HIMETRIC := 3
    static MM_ISOTROPIC := 7
    static MM_LOENGLISH := 4
    static MM_LOMETRIC := 2
    static MM_TEXT := 1
    static MM_TWIPS := 6
}
struct GDI_REGION_TYPE extends Int32 {
    static RGN_ERROR := 0
    static NULLREGION := 1
    static SIMPLEREGION := 2
    static COMPLEXREGION := 3
}
struct BRUSH_STYLE extends UInt32 {
    static BS_SOLID := 0
    static BS_NULL := 1
    static BS_HOLLOW := 1
    static BS_HATCHED := 2
    static BS_PATTERN := 3
    static BS_INDEXED := 4
    static BS_DIBPATTERN := 5
    static BS_DIBPATTERNPT := 6
    static BS_PATTERN8X8 := 7
    static BS_DIBPATTERN8X8 := 8
    static BS_MONOPATTERN := 9
}
struct TMPF_FLAGS extends UInt8 {
    static TMPF_FIXED_PITCH := 1
    static TMPF_VECTOR := 2
    static TMPF_DEVICE := 8
    static TMPF_TRUETYPE := 4
}
struct BI_COMPRESSION extends UInt32 {
    static BI_RGB := 0
    static BI_RLE8 := 1
    static BI_RLE4 := 2
    static BI_BITFIELDS := 3
    static BI_JPEG := 4
    static BI_PNG := 5
}
struct ENHANCED_METAFILE_RECORD_TYPE extends UInt32 {
    static EMR_HEADER := 1
    static EMR_POLYBEZIER := 2
    static EMR_POLYGON := 3
    static EMR_POLYLINE := 4
    static EMR_POLYBEZIERTO := 5
    static EMR_POLYLINETO := 6
    static EMR_POLYPOLYLINE := 7
    static EMR_POLYPOLYGON := 8
    static EMR_SETWINDOWEXTEX := 9
    static EMR_SETWINDOWORGEX := 10
    static EMR_SETVIEWPORTEXTEX := 11
    static EMR_SETVIEWPORTORGEX := 12
    static EMR_SETBRUSHORGEX := 13
    static EMR_EOF := 14
    static EMR_SETPIXELV := 15
    static EMR_SETMAPPERFLAGS := 16
    static EMR_SETMAPMODE := 17
    static EMR_SETBKMODE := 18
    static EMR_SETPOLYFILLMODE := 19
    static EMR_SETROP2 := 20
    static EMR_SETSTRETCHBLTMODE := 21
    static EMR_SETTEXTALIGN := 22
    static EMR_SETCOLORADJUSTMENT := 23
    static EMR_SETTEXTCOLOR := 24
    static EMR_SETBKCOLOR := 25
    static EMR_OFFSETCLIPRGN := 26
    static EMR_MOVETOEX := 27
    static EMR_SETMETARGN := 28
    static EMR_EXCLUDECLIPRECT := 29
    static EMR_INTERSECTCLIPRECT := 30
    static EMR_SCALEVIEWPORTEXTEX := 31
    static EMR_SCALEWINDOWEXTEX := 32
    static EMR_SAVEDC := 33
    static EMR_RESTOREDC := 34
    static EMR_SETWORLDTRANSFORM := 35
    static EMR_MODIFYWORLDTRANSFORM := 36
    static EMR_SELECTOBJECT := 37
    static EMR_CREATEPEN := 38
    static EMR_CREATEBRUSHINDIRECT := 39
    static EMR_DELETEOBJECT := 40
    static EMR_ANGLEARC := 41
    static EMR_ELLIPSE := 42
    static EMR_RECTANGLE := 43
    static EMR_ROUNDRECT := 44
    static EMR_ARC := 45
    static EMR_CHORD := 46
    static EMR_PIE := 47
    static EMR_SELECTPALETTE := 48
    static EMR_CREATEPALETTE := 49
    static EMR_SETPALETTEENTRIES := 50
    static EMR_RESIZEPALETTE := 51
    static EMR_REALIZEPALETTE := 52
    static EMR_EXTFLOODFILL := 53
    static EMR_LINETO := 54
    static EMR_ARCTO := 55
    static EMR_POLYDRAW := 56
    static EMR_SETARCDIRECTION := 57
    static EMR_SETMITERLIMIT := 58
    static EMR_BEGINPATH := 59
    static EMR_ENDPATH := 60
    static EMR_CLOSEFIGURE := 61
    static EMR_FILLPATH := 62
    static EMR_STROKEANDFILLPATH := 63
    static EMR_STROKEPATH := 64
    static EMR_FLATTENPATH := 65
    static EMR_WIDENPATH := 66
    static EMR_SELECTCLIPPATH := 67
    static EMR_ABORTPATH := 68
    static EMR_GDICOMMENT := 70
    static EMR_FILLRGN := 71
    static EMR_FRAMERGN := 72
    static EMR_INVERTRGN := 73
    static EMR_PAINTRGN := 74
    static EMR_EXTSELECTCLIPRGN := 75
    static EMR_BITBLT := 76
    static EMR_STRETCHBLT := 77
    static EMR_MASKBLT := 78
    static EMR_PLGBLT := 79
    static EMR_SETDIBITSTODEVICE := 80
    static EMR_STRETCHDIBITS := 81
    static EMR_EXTCREATEFONTINDIRECTW := 82
    static EMR_EXTTEXTOUTA := 83
    static EMR_EXTTEXTOUTW := 84
    static EMR_POLYBEZIER16 := 85
    static EMR_POLYGON16 := 86
    static EMR_POLYLINE16 := 87
    static EMR_POLYBEZIERTO16 := 88
    static EMR_POLYLINETO16 := 89
    static EMR_POLYPOLYLINE16 := 90
    static EMR_POLYPOLYGON16 := 91
    static EMR_POLYDRAW16 := 92
    static EMR_CREATEMONOBRUSH := 93
    static EMR_CREATEDIBPATTERNBRUSHPT := 94
    static EMR_EXTCREATEPEN := 95
    static EMR_POLYTEXTOUTA := 96
    static EMR_POLYTEXTOUTW := 97
    static EMR_SETICMMODE := 98
    static EMR_CREATECOLORSPACE := 99
    static EMR_SETCOLORSPACE := 100
    static EMR_DELETECOLORSPACE := 101
    static EMR_GLSRECORD := 102
    static EMR_GLSBOUNDEDRECORD := 103
    static EMR_PIXELFORMAT := 104
    static EMR_RESERVED_105 := 105
    static EMR_RESERVED_106 := 106
    static EMR_RESERVED_107 := 107
    static EMR_RESERVED_108 := 108
    static EMR_RESERVED_109 := 109
    static EMR_RESERVED_110 := 110
    static EMR_COLORCORRECTPALETTE := 111
    static EMR_SETICMPROFILEA := 112
    static EMR_SETICMPROFILEW := 113
    static EMR_ALPHABLEND := 114
    static EMR_SETLAYOUT := 115
    static EMR_TRANSPARENTBLT := 116
    static EMR_RESERVED_117 := 117
    static EMR_GRADIENTFILL := 118
    static EMR_RESERVED_119 := 119
    static EMR_RESERVED_120 := 120
    static EMR_COLORMATCHTOTARGETW := 121
    static EMR_CREATECOLORSPACEW := 122
    static EMR_MIN := 1
    static EMR_MAX := 122
}
struct DEVMODE_FIELD_FLAGS extends UInt32 {
    static DM_SPECVERSION := 1025
    static DM_ORIENTATION := 1
    static DM_PAPERSIZE := 2
    static DM_PAPERLENGTH := 4
    static DM_PAPERWIDTH := 8
    static DM_SCALE := 16
    static DM_POSITION := 32
    static DM_NUP := 64
    static DM_DISPLAYORIENTATION := 128
    static DM_COPIES := 256
    static DM_DEFAULTSOURCE := 512
    static DM_PRINTQUALITY := 1024
    static DM_COLOR := 2048
    static DM_DUPLEX := 4096
    static DM_YRESOLUTION := 8192
    static DM_TTOPTION := 16384
    static DM_COLLATE := 32768
    static DM_FORMNAME := 65536
    static DM_LOGPIXELS := 131072
    static DM_BITSPERPEL := 262144
    static DM_PELSWIDTH := 524288
    static DM_PELSHEIGHT := 1048576
    static DM_DISPLAYFLAGS := 2097152
    static DM_DISPLAYFREQUENCY := 4194304
    static DM_ICMMETHOD := 8388608
    static DM_ICMINTENT := 16777216
    static DM_MEDIATYPE := 33554432
    static DM_DITHERTYPE := 67108864
    static DM_PANNINGWIDTH := 134217728
    static DM_PANNINGHEIGHT := 268435456
    static DM_DISPLAYFIXEDOUTPUT := 536870912
    static DM_INTERLACED := 2
    static DM_UPDATE := 1
    static DM_COPY := 2
    static DM_PROMPT := 4
    static DM_MODIFY := 8
    static DM_IN_BUFFER := 8
    static DM_IN_PROMPT := 4
    static DM_OUT_BUFFER := 2
    static DM_OUT_DEFAULT := 1
}
struct DEVMODE_COLOR extends Int16 {
    static DMCOLOR_MONOCHROME := 1
    static DMCOLOR_COLOR := 2
}
struct DEVMODE_DUPLEX extends Int16 {
    static DMDUP_SIMPLEX := 1
    static DMDUP_VERTICAL := 2
    static DMDUP_HORIZONTAL := 3
}
struct DEVMODE_COLLATE extends Int16 {
    static DMCOLLATE_FALSE := 0
    static DMCOLLATE_TRUE := 1
}
struct DEVMODE_DISPLAY_ORIENTATION extends UInt32 {
    static DMDO_DEFAULT := 0
    static DMDO_90 := 1
    static DMDO_180 := 2
    static DMDO_270 := 3
}
struct DEVMODE_DISPLAY_FIXED_OUTPUT extends UInt32 {
    static DMDFO_DEFAULT := 0
    static DMDFO_STRETCH := 1
    static DMDFO_CENTER := 2
}
struct DEVMODE_TRUETYPE_OPTION extends Int16 {
    static DMTT_BITMAP := 1
    static DMTT_DOWNLOAD := 2
    static DMTT_SUBDEV := 3
    static DMTT_DOWNLOAD_OUTLINE := 4
}
struct PAN_FAMILY_TYPE extends UInt8 {
    static PAN_FAMILY_ANY := 0
    static PAN_FAMILY_NO_FIT := 1
    static PAN_FAMILY_TEXT_DISPLAY := 2
    static PAN_FAMILY_SCRIPT := 3
    static PAN_FAMILY_DECORATIVE := 4
    static PAN_FAMILY_PICTORIAL := 5
}
struct PAN_SERIF_STYLE extends UInt8 {
    static PAN_SERIF_ANY := 0
    static PAN_SERIF_NO_FIT := 1
    static PAN_SERIF_COVE := 2
    static PAN_SERIF_OBTUSE_COVE := 3
    static PAN_SERIF_SQUARE_COVE := 4
    static PAN_SERIF_OBTUSE_SQUARE_COVE := 5
    static PAN_SERIF_SQUARE := 6
    static PAN_SERIF_THIN := 7
    static PAN_SERIF_BONE := 8
    static PAN_SERIF_EXAGGERATED := 9
    static PAN_SERIF_TRIANGLE := 10
    static PAN_SERIF_NORMAL_SANS := 11
    static PAN_SERIF_OBTUSE_SANS := 12
    static PAN_SERIF_PERP_SANS := 13
    static PAN_SERIF_FLARED := 14
    static PAN_SERIF_ROUNDED := 15
}
struct PAN_WEIGHT extends UInt8 {
    static PAN_WEIGHT_ANY := 0
    static PAN_WEIGHT_NO_FIT := 1
    static PAN_WEIGHT_INDEX := 2
    static PAN_WEIGHT_VERY_LIGHT := 2
    static PAN_WEIGHT_LIGHT := 3
    static PAN_WEIGHT_THIN := 4
    static PAN_WEIGHT_BOOK := 5
    static PAN_WEIGHT_MEDIUM := 6
    static PAN_WEIGHT_DEMI := 7
    static PAN_WEIGHT_BOLD := 8
    static PAN_WEIGHT_HEAVY := 9
    static PAN_WEIGHT_BLACK := 10
    static PAN_WEIGHT_NORD := 11
}
struct PAN_STROKE_VARIATION extends UInt8 {
    static PAN_STROKE_ANY := 0
    static PAN_STROKE_NO_FIT := 1
    static PAN_STROKE_GRADUAL_DIAG := 2
    static PAN_STROKE_GRADUAL_TRAN := 3
    static PAN_STROKE_GRADUAL_VERT := 4
    static PAN_STROKE_GRADUAL_HORZ := 5
    static PAN_STROKE_RAPID_VERT := 6
    static PAN_STROKE_RAPID_HORZ := 7
    static PAN_STROKE_INSTANT_VERT := 8
}
struct PAN_PROPORTION extends UInt8 {
    static PAN_PROP_ANY := 0
    static PAN_PROP_NO_FIT := 1
    static PAN_PROP_OLD_STYLE := 2
    static PAN_PROP_MODERN := 3
    static PAN_PROP_EVEN_WIDTH := 4
    static PAN_PROP_EXPANDED := 5
    static PAN_PROP_CONDENSED := 6
    static PAN_PROP_VERY_EXPANDED := 7
    static PAN_PROP_VERY_CONDENSED := 8
    static PAN_PROP_MONOSPACED := 9
}
struct PAN_CONTRAST extends UInt8 {
    static PAN_CONTRAST_ANY := 0
    static PAN_CONTRAST_NO_FIT := 1
    static PAN_CONTRAST_INDEX := 4
    static PAN_CONTRAST_NONE := 2
    static PAN_CONTRAST_VERY_LOW := 3
    static PAN_CONTRAST_LOW := 4
    static PAN_CONTRAST_MEDIUM_LOW := 5
    static PAN_CONTRAST_MEDIUM := 6
    static PAN_CONTRAST_MEDIUM_HIGH := 7
    static PAN_CONTRAST_HIGH := 8
    static PAN_CONTRAST_VERY_HIGH := 9
}
struct PAN_ARM_STYLE extends UInt8 {
    static PAN_ARM_ANY := 0
    static PAN_ARM_NO_FIT := 1
    static PAN_STRAIGHT_ARMS_HORZ := 2
    static PAN_STRAIGHT_ARMS_WEDGE := 3
    static PAN_STRAIGHT_ARMS_VERT := 4
    static PAN_STRAIGHT_ARMS_SINGLE_SERIF := 5
    static PAN_STRAIGHT_ARMS_DOUBLE_SERIF := 6
    static PAN_BENT_ARMS_HORZ := 7
    static PAN_BENT_ARMS_WEDGE := 8
    static PAN_BENT_ARMS_VERT := 9
    static PAN_BENT_ARMS_SINGLE_SERIF := 10
    static PAN_BENT_ARMS_DOUBLE_SERIF := 11
}
struct PAN_LETT_FORM extends UInt8 {
    static PAN_LETT_FORM_ANY := 0
    static PAN_LETT_FORM_NO_FIT := 1
    static PAN_LETT_NORMAL_CONTACT := 2
    static PAN_LETT_NORMAL_WEIGHTED := 3
    static PAN_LETT_NORMAL_BOXED := 4
    static PAN_LETT_NORMAL_FLATTENED := 5
    static PAN_LETT_NORMAL_ROUNDED := 6
    static PAN_LETT_NORMAL_OFF_CENTER := 7
    static PAN_LETT_NORMAL_SQUARE := 8
    static PAN_LETT_OBLIQUE_CONTACT := 9
    static PAN_LETT_OBLIQUE_WEIGHTED := 10
    static PAN_LETT_OBLIQUE_BOXED := 11
    static PAN_LETT_OBLIQUE_FLATTENED := 12
    static PAN_LETT_OBLIQUE_ROUNDED := 13
    static PAN_LETT_OBLIQUE_OFF_CENTER := 14
    static PAN_LETT_OBLIQUE_SQUARE := 15
}
struct PAN_MIDLINE extends UInt8 {
    static PAN_MIDLINE_ANY := 0
    static PAN_MIDLINE_NO_FIT := 1
    static PAN_MIDLINE_INDEX := 8
    static PAN_MIDLINE_STANDARD_TRIMMED := 2
    static PAN_MIDLINE_STANDARD_POINTED := 3
    static PAN_MIDLINE_STANDARD_SERIFED := 4
    static PAN_MIDLINE_HIGH_TRIMMED := 5
    static PAN_MIDLINE_HIGH_POINTED := 6
    static PAN_MIDLINE_HIGH_SERIFED := 7
    static PAN_MIDLINE_CONSTANT_TRIMMED := 8
    static PAN_MIDLINE_CONSTANT_POINTED := 9
    static PAN_MIDLINE_CONSTANT_SERIFED := 10
    static PAN_MIDLINE_LOW_TRIMMED := 11
    static PAN_MIDLINE_LOW_POINTED := 12
    static PAN_MIDLINE_LOW_SERIFED := 13
}
struct PAN_XHEIGHT extends UInt8 {
    static PAN_XHEIGHT_ANY := 0
    static PAN_XHEIGHT_NO_FIT := 1
    static PAN_XHEIGHT_INDEX := 9
    static PAN_XHEIGHT_CONSTANT_SMALL := 2
    static PAN_XHEIGHT_CONSTANT_STD := 3
    static PAN_XHEIGHT_CONSTANT_LARGE := 4
    static PAN_XHEIGHT_DUCKING_SMALL := 5
    static PAN_XHEIGHT_DUCKING_STD := 6
    static PAN_XHEIGHT_DUCKING_LARGE := 7
}
struct ENUM_DISPLAY_SETTINGS_FLAGS extends UInt32 {
    static EDS_RAWMODE := 2
    static EDS_ROTATEDMODE := 4
}
struct DISPLAY_DEVICE_STATE_FLAGS extends UInt32 {
    static DISPLAY_DEVICE_ATTACHED_TO_DESKTOP := 1
    static DISPLAY_DEVICE_MULTI_DRIVER := 2
    static DISPLAY_DEVICE_PRIMARY_DEVICE := 4
    static DISPLAY_DEVICE_MIRRORING_DRIVER := 8
    static DISPLAY_DEVICE_VGA_COMPATIBLE := 16
    static DISPLAY_DEVICE_REMOVABLE := 32
    static DISPLAY_DEVICE_ACC_DRIVER := 64
    static DISPLAY_DEVICE_MODESPRUNED := 134217728
    static DISPLAY_DEVICE_RDPUDD := 16777216
    static DISPLAY_DEVICE_REMOTE := 67108864
    static DISPLAY_DEVICE_DISCONNECT := 33554432
    static DISPLAY_DEVICE_TS_COMPATIBLE := 2097152
    static DISPLAY_DEVICE_UNSAFE_MODES_ON := 524288
    static DISPLAY_DEVICE_ACTIVE := 1
    static DISPLAY_DEVICE_ATTACHED := 2
}
struct HBITMAP {
    Value : IntPtr
}
struct HRGN {
    Value : IntPtr
}
struct HPEN {
    Value : IntPtr
}
struct HBRUSH {
    Value : IntPtr
}
struct HFONT {
    Value : IntPtr
}
struct HMETAFILE {
    Value : IntPtr
}
struct HENHMETAFILE {
    Value : IntPtr
}
struct HPALETTE {
    Value : IntPtr
}
struct HDC {
    Value : IntPtr
}
struct HGDIOBJ {
    Value : IntPtr
}
struct HMONITOR {
    Value : IntPtr
}
struct XFORM {
    eM11 : Float32
    eM12 : Float32
    eM21 : Float32
    eM22 : Float32
    eDx : Float32
    eDy : Float32
}
struct BITMAP {
    bmType : Int32
    bmWidth : Int32
    bmHeight : Int32
    bmWidthBytes : Int32
    bmPlanes : UInt16
    bmBitsPixel : UInt16
    bmBits : Struct.Ptr
}
struct RGBTRIPLE {
    rgbtBlue : UInt8
    rgbtGreen : UInt8
    rgbtRed : UInt8
}
struct RGBQUAD {
    rgbBlue : UInt8
    rgbGreen : UInt8
    rgbRed : UInt8
    rgbReserved : UInt8
}
struct CIEXYZ {
    ciexyzX : Int32
    ciexyzY : Int32
    ciexyzZ : Int32
}
struct CIEXYZTRIPLE {
    ciexyzRed : CIEXYZ
    ciexyzGreen : CIEXYZ
    ciexyzBlue : CIEXYZ
}
struct BITMAPCOREHEADER {
    bcSize : UInt32
    bcWidth : UInt16
    bcHeight : UInt16
    bcPlanes : UInt16
    bcBitCount : UInt16
}
struct BITMAPINFOHEADER {
    biSize : UInt32
    biWidth : Int32
    biHeight : Int32
    biPlanes : UInt16
    biBitCount : UInt16
    biCompression : UInt32
    biSizeImage : UInt32
    biXPelsPerMeter : Int32
    biYPelsPerMeter : Int32
    biClrUsed : UInt32
    biClrImportant : UInt32
}
struct BITMAPV4HEADER {
    bV4Size : UInt32
    bV4Width : Int32
    bV4Height : Int32
    bV4Planes : UInt16
    bV4BitCount : UInt16
    bV4V4Compression : BI_COMPRESSION
    bV4SizeImage : UInt32
    bV4XPelsPerMeter : Int32
    bV4YPelsPerMeter : Int32
    bV4ClrUsed : UInt32
    bV4ClrImportant : UInt32
    bV4RedMask : UInt32
    bV4GreenMask : UInt32
    bV4BlueMask : UInt32
    bV4AlphaMask : UInt32
    bV4CSType : UInt32
    bV4Endpoints : CIEXYZTRIPLE
    bV4GammaRed : UInt32
    bV4GammaGreen : UInt32
    bV4GammaBlue : UInt32
}
struct BITMAPV5HEADER {
    bV5Size : UInt32
    bV5Width : Int32
    bV5Height : Int32
    bV5Planes : UInt16
    bV5BitCount : UInt16
    bV5Compression : BI_COMPRESSION
    bV5SizeImage : UInt32
    bV5XPelsPerMeter : Int32
    bV5YPelsPerMeter : Int32
    bV5ClrUsed : UInt32
    bV5ClrImportant : UInt32
    bV5RedMask : UInt32
    bV5GreenMask : UInt32
    bV5BlueMask : UInt32
    bV5AlphaMask : UInt32
    bV5CSType : UInt32
    bV5Endpoints : CIEXYZTRIPLE
    bV5GammaRed : UInt32
    bV5GammaGreen : UInt32
    bV5GammaBlue : UInt32
    bV5Intent : UInt32
    bV5ProfileData : UInt32
    bV5ProfileSize : UInt32
    bV5Reserved : UInt32
}
struct BITMAPINFO {
    bmiHeader : BITMAPINFOHEADER
    bmiColors : RGBQUAD[1]
}
struct BITMAPCOREINFO {
    bmciHeader : BITMAPCOREHEADER
    bmciColors : RGBTRIPLE[1]
}
struct BITMAPFILEHEADER {
    bfType : UInt16
    bfSize : UInt32
    bfReserved1 : UInt16
    bfReserved2 : UInt16
    bfOffBits : UInt32
}
struct HANDLETABLE {
    objectHandle : HGDIOBJ[1]
}
struct METARECORD {
    rdSize : UInt32
    rdFunction : UInt16
    rdParm : UInt16[1]
}
struct METAHEADER {
    mtType : UInt16
    mtHeaderSize : UInt16
    mtVersion : UInt16
    mtSize : UInt32
    mtNoObjects : UInt16
    mtMaxRecord : UInt32
    mtNoParameters : UInt16
}
struct ENHMETARECORD {
    iType : ENHANCED_METAFILE_RECORD_TYPE
    nSize : UInt32
    dParm : UInt32[1]
}
struct ENHMETAHEADER {
    iType : UInt32
    nSize : UInt32
    rclBounds : RECTL
    rclFrame : RECTL
    dSignature : UInt32
    nVersion : UInt32
    nBytes : UInt32
    nRecords : UInt32
    nHandles : UInt16
    sReserved : UInt16
    nDescription : UInt32
    offDescription : UInt32
    nPalEntries : UInt32
    szlDevice : SIZE
    szlMillimeters : SIZE
    cbPixelFormat : UInt32
    offPixelFormat : UInt32
    bOpenGL : UInt32
    szlMicrometers : SIZE
}
struct TEXTMETRICA {
    tmHeight : Int32
    tmAscent : Int32
    tmDescent : Int32
    tmInternalLeading : Int32
    tmExternalLeading : Int32
    tmAveCharWidth : Int32
    tmMaxCharWidth : Int32
    tmWeight : Int32
    tmOverhang : Int32
    tmDigitizedAspectX : Int32
    tmDigitizedAspectY : Int32
    tmFirstChar : UInt8
    tmLastChar : UInt8
    tmDefaultChar : UInt8
    tmBreakChar : UInt8
    tmItalic : UInt8
    tmUnderlined : UInt8
    tmStruckOut : UInt8
    tmPitchAndFamily : TMPF_FLAGS
    tmCharSet : UInt8
}
struct TEXTMETRICW {
    tmHeight : Int32
    tmAscent : Int32
    tmDescent : Int32
    tmInternalLeading : Int32
    tmExternalLeading : Int32
    tmAveCharWidth : Int32
    tmMaxCharWidth : Int32
    tmWeight : Int32
    tmOverhang : Int32
    tmDigitizedAspectX : Int32
    tmDigitizedAspectY : Int32
    tmFirstChar : UInt16
    tmLastChar : UInt16
    tmDefaultChar : UInt16
    tmBreakChar : UInt16
    tmItalic : UInt8
    tmUnderlined : UInt8
    tmStruckOut : UInt8
    tmPitchAndFamily : TMPF_FLAGS
    tmCharSet : UInt8
}
struct NEWTEXTMETRICA {
    tmHeight : Int32
    tmAscent : Int32
    tmDescent : Int32
    tmInternalLeading : Int32
    tmExternalLeading : Int32
    tmAveCharWidth : Int32
    tmMaxCharWidth : Int32
    tmWeight : Int32
    tmOverhang : Int32
    tmDigitizedAspectX : Int32
    tmDigitizedAspectY : Int32
    tmFirstChar : UInt8
    tmLastChar : UInt8
    tmDefaultChar : UInt8
    tmBreakChar : UInt8
    tmItalic : UInt8
    tmUnderlined : UInt8
    tmStruckOut : UInt8
    tmPitchAndFamily : TMPF_FLAGS
    tmCharSet : UInt8
    ntmFlags : UInt32
    ntmSizeEM : UInt32
    ntmCellHeight : UInt32
    ntmAvgWidth : UInt32
}
struct NEWTEXTMETRICW {
    tmHeight : Int32
    tmAscent : Int32
    tmDescent : Int32
    tmInternalLeading : Int32
    tmExternalLeading : Int32
    tmAveCharWidth : Int32
    tmMaxCharWidth : Int32
    tmWeight : Int32
    tmOverhang : Int32
    tmDigitizedAspectX : Int32
    tmDigitizedAspectY : Int32
    tmFirstChar : UInt16
    tmLastChar : UInt16
    tmDefaultChar : UInt16
    tmBreakChar : UInt16
    tmItalic : UInt8
    tmUnderlined : UInt8
    tmStruckOut : UInt8
    tmPitchAndFamily : TMPF_FLAGS
    tmCharSet : UInt8
    ntmFlags : UInt32
    ntmSizeEM : UInt32
    ntmCellHeight : UInt32
    ntmAvgWidth : UInt32
}
struct PELARRAY {
    paXCount : Int32
    paYCount : Int32
    paXExt : Int32
    paYExt : Int32
    paRGBs : UInt8
}
struct LOGBRUSH {
    lbStyle : BRUSH_STYLE
    lbColor : COLORREF
    lbHatch : IntPtr
}
struct LOGBRUSH32 {
    lbStyle : BRUSH_STYLE
    lbColor : COLORREF
    lbHatch : UInt32
}
struct LOGPEN {
    lopnStyle : UInt32
    lopnWidth : POINT
    lopnColor : COLORREF
}
struct EXTLOGPEN {
    elpPenStyle : UInt32
    elpWidth : UInt32
    elpBrushStyle : UInt32
    elpColor : COLORREF
    elpHatch : IntPtr
    elpNumEntries : UInt32
    elpStyleEntry : UInt32[1]
}
struct EXTLOGPEN32 {
    elpPenStyle : UInt32
    elpWidth : UInt32
    elpBrushStyle : UInt32
    elpColor : COLORREF
    elpHatch : UInt32
    elpNumEntries : UInt32
    elpStyleEntry : UInt32[1]
}
struct PALETTEENTRY {
    peRed : UInt8
    peGreen : UInt8
    peBlue : UInt8
    peFlags : UInt8
}
struct LOGPALETTE {
    palVersion : UInt16
    palNumEntries : UInt16
    palPalEntry : PALETTEENTRY[1]
}
struct LOGFONTA {
    lfHeight : Int32
    lfWidth : Int32
    lfEscapement : Int32
    lfOrientation : Int32
    lfWeight : Int32
    lfItalic : UInt8
    lfUnderline : UInt8
    lfStrikeOut : UInt8
    lfCharSet : FONT_CHARSET
    lfOutPrecision : FONT_OUTPUT_PRECISION
    lfClipPrecision : FONT_CLIP_PRECISION
    lfQuality : FONT_QUALITY
    lfPitchAndFamily : UInt8
    lfFaceName : CHAR[32]
}
struct LOGFONTW {
    lfHeight : Int32
    lfWidth : Int32
    lfEscapement : Int32
    lfOrientation : Int32
    lfWeight : Int32
    lfItalic : UInt8
    lfUnderline : UInt8
    lfStrikeOut : UInt8
    lfCharSet : FONT_CHARSET
    lfOutPrecision : FONT_OUTPUT_PRECISION
    lfClipPrecision : FONT_CLIP_PRECISION
    lfQuality : FONT_QUALITY
    lfPitchAndFamily : UInt8
    lfFaceName : UInt16[32]
}
struct ENUMLOGFONTA {
    elfLogFont : LOGFONTA
    elfFullName : UInt8[64]
    elfStyle : UInt8[32]
}
struct ENUMLOGFONTW {
    elfLogFont : LOGFONTW
    elfFullName : UInt16[64]
    elfStyle : UInt16[32]
}
struct ENUMLOGFONTEXA {
    elfLogFont : LOGFONTA
    elfFullName : UInt8[64]
    elfStyle : UInt8[32]
    elfScript : UInt8[32]
}
struct ENUMLOGFONTEXW {
    elfLogFont : LOGFONTW
    elfFullName : UInt16[64]
    elfStyle : UInt16[32]
    elfScript : UInt16[32]
}
struct PANOSE {
    bFamilyType : PAN_FAMILY_TYPE
    bSerifStyle : PAN_SERIF_STYLE
    bWeight : PAN_WEIGHT
    bProportion : PAN_PROPORTION
    bContrast : PAN_CONTRAST
    bStrokeVariation : PAN_STROKE_VARIATION
    bArmStyle : PAN_ARM_STYLE
    bLetterform : PAN_LETT_FORM
    bMidline : PAN_MIDLINE
    bXHeight : PAN_XHEIGHT
}
struct EXTLOGFONTA {
    elfLogFont : LOGFONTA
    elfFullName : UInt8[64]
    elfStyle : UInt8[32]
    elfVersion : UInt32
    elfStyleSize : UInt32
    elfMatch : UInt32
    elfReserved : UInt32
    elfVendorId : UInt8[4]
    elfCulture : UInt32
    elfPanose : PANOSE
}
struct EXTLOGFONTW {
    elfLogFont : LOGFONTW
    elfFullName : UInt16[64]
    elfStyle : UInt16[32]
    elfVersion : UInt32
    elfStyleSize : UInt32
    elfMatch : UInt32
    elfReserved : UInt32
    elfVendorId : UInt8[4]
    elfCulture : UInt32
    elfPanose : PANOSE
}
struct DEVMODEA {
    dmDeviceName : UInt8[32]
    dmSpecVersion : UInt16
    dmDriverVersion : UInt16
    dmSize : UInt16
    dmDriverExtra : UInt16
    dmFields : DEVMODE_FIELD_FLAGS
    Anonymous1 : this._Anonymous1_e__Union
    dmColor : DEVMODE_COLOR
    dmDuplex : DEVMODE_DUPLEX
    dmYResolution : Int16
    dmTTOption : DEVMODE_TRUETYPE_OPTION
    dmCollate : DEVMODE_COLLATE
    dmFormName : UInt8[32]
    dmLogPixels : UInt16
    dmBitsPerPel : UInt32
    dmPelsWidth : UInt32
    dmPelsHeight : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    dmDisplayFrequency : UInt32
    dmICMMethod : UInt32
    dmICMIntent : UInt32
    dmMediaType : UInt32
    dmDitherType : UInt32
    dmReserved1 : UInt32
    dmReserved2 : UInt32
    dmPanningWidth : UInt32
    dmPanningHeight : UInt32
    struct _Anonymous1_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            dmOrientation : Int16
            dmPaperSize : Int16
            dmPaperLength : Int16
            dmPaperWidth : Int16
            dmScale : Int16
            dmCopies : Int16
            dmDefaultSource : Int16
            dmPrintQuality : Int16
        }
        struct _Anonymous2_e__Struct {
            dmPosition : POINTL
            dmDisplayOrientation : DEVMODE_DISPLAY_ORIENTATION
            dmDisplayFixedOutput : DEVMODE_DISPLAY_FIXED_OUTPUT
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dmDisplayFlags : UInt32
            dmNup : UInt32
        }
    }
}
struct DEVMODEW {
    dmDeviceName : UInt16[32]
    dmSpecVersion : UInt16
    dmDriverVersion : UInt16
    dmSize : UInt16
    dmDriverExtra : UInt16
    dmFields : DEVMODE_FIELD_FLAGS
    Anonymous1 : this._Anonymous1_e__Union
    dmColor : DEVMODE_COLOR
    dmDuplex : DEVMODE_DUPLEX
    dmYResolution : Int16
    dmTTOption : DEVMODE_TRUETYPE_OPTION
    dmCollate : DEVMODE_COLLATE
    dmFormName : UInt16[32]
    dmLogPixels : UInt16
    dmBitsPerPel : UInt32
    dmPelsWidth : UInt32
    dmPelsHeight : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    dmDisplayFrequency : UInt32
    dmICMMethod : UInt32
    dmICMIntent : UInt32
    dmMediaType : UInt32
    dmDitherType : UInt32
    dmReserved1 : UInt32
    dmReserved2 : UInt32
    dmPanningWidth : UInt32
    dmPanningHeight : UInt32
    struct _Anonymous1_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            dmOrientation : Int16
            dmPaperSize : Int16
            dmPaperLength : Int16
            dmPaperWidth : Int16
            dmScale : Int16
            dmCopies : Int16
            dmDefaultSource : Int16
            dmPrintQuality : Int16
        }
        struct _Anonymous2_e__Struct {
            dmPosition : POINTL
            dmDisplayOrientation : DEVMODE_DISPLAY_ORIENTATION
            dmDisplayFixedOutput : DEVMODE_DISPLAY_FIXED_OUTPUT
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dmDisplayFlags : UInt32
            dmNup : UInt32
        }
    }
}
struct DISPLAY_DEVICEA {
    cb : UInt32
    DeviceName : CHAR[32]
    DeviceString : CHAR[128]
    StateFlags : DISPLAY_DEVICE_STATE_FLAGS
    DeviceID : CHAR[128]
    DeviceKey : CHAR[128]
}
struct DISPLAY_DEVICEW {
    cb : UInt32
    DeviceName : UInt16[32]
    DeviceString : UInt16[128]
    StateFlags : DISPLAY_DEVICE_STATE_FLAGS
    DeviceID : UInt16[128]
    DeviceKey : UInt16[128]
}
struct DISPLAYCONFIG_COLOR_ENCODING extends Int32 {
    static DISPLAYCONFIG_COLOR_ENCODING_RGB := 0
    static DISPLAYCONFIG_COLOR_ENCODING_YCBCR444 := 1
    static DISPLAYCONFIG_COLOR_ENCODING_YCBCR422 := 2
    static DISPLAYCONFIG_COLOR_ENCODING_YCBCR420 := 3
    static DISPLAYCONFIG_COLOR_ENCODING_INTENSITY := 4
}
struct DISPLAYCONFIG_ADVANCED_COLOR_MODE extends Int32 {
    static DISPLAYCONFIG_ADVANCED_COLOR_MODE_SDR := 0
    static DISPLAYCONFIG_ADVANCED_COLOR_MODE_WCG := 1
    static DISPLAYCONFIG_ADVANCED_COLOR_MODE_HDR := 2
}
struct RGNDATAHEADER {
    dwSize : UInt32
    iType : UInt32
    nCount : UInt32
    nRgnSize : UInt32
    rcBound : RECT
}
struct RGNDATA {
    rdh : RGNDATAHEADER
    Buffer : CHAR[1]
}
struct ABC {
    abcA : Int32
    abcB : UInt32
    abcC : Int32
}
struct ABCFLOAT {
    abcfA : Float32
    abcfB : Float32
    abcfC : Float32
}
struct OUTLINETEXTMETRICA {
    otmSize : UInt32
    otmTextMetrics : TEXTMETRICA
    otmFiller : UInt8
    otmPanoseNumber : PANOSE
    otmfsSelection : UInt32
    otmfsType : UInt32
    otmsCharSlopeRise : Int32
    otmsCharSlopeRun : Int32
    otmItalicAngle : Int32
    otmEMSquare : UInt32
    otmAscent : Int32
    otmDescent : Int32
    otmLineGap : UInt32
    otmsCapEmHeight : UInt32
    otmsXHeight : UInt32
    otmrcFontBox : RECT
    otmMacAscent : Int32
    otmMacDescent : Int32
    otmMacLineGap : UInt32
    otmusMinimumPPEM : UInt32
    otmptSubscriptSize : POINT
    otmptSubscriptOffset : POINT
    otmptSuperscriptSize : POINT
    otmptSuperscriptOffset : POINT
    otmsStrikeoutSize : UInt32
    otmsStrikeoutPosition : Int32
    otmsUnderscoreSize : Int32
    otmsUnderscorePosition : Int32
    otmpFamilyName : PSTR
    otmpFaceName : PSTR
    otmpStyleName : PSTR
    otmpFullName : PSTR
}
struct OUTLINETEXTMETRICW {
    otmSize : UInt32
    otmTextMetrics : TEXTMETRICW
    otmFiller : UInt8
    otmPanoseNumber : PANOSE
    otmfsSelection : UInt32
    otmfsType : UInt32
    otmsCharSlopeRise : Int32
    otmsCharSlopeRun : Int32
    otmItalicAngle : Int32
    otmEMSquare : UInt32
    otmAscent : Int32
    otmDescent : Int32
    otmLineGap : UInt32
    otmsCapEmHeight : UInt32
    otmsXHeight : UInt32
    otmrcFontBox : RECT
    otmMacAscent : Int32
    otmMacDescent : Int32
    otmMacLineGap : UInt32
    otmusMinimumPPEM : UInt32
    otmptSubscriptSize : POINT
    otmptSubscriptOffset : POINT
    otmptSuperscriptSize : POINT
    otmptSuperscriptOffset : POINT
    otmsStrikeoutSize : UInt32
    otmsStrikeoutPosition : Int32
    otmsUnderscoreSize : Int32
    otmsUnderscorePosition : Int32
    otmpFamilyName : PSTR
    otmpFaceName : PSTR
    otmpStyleName : PSTR
    otmpFullName : PSTR
}
struct POLYTEXTA {
    x : Int32
    y : Int32
    n : UInt32
    lpstr : PSTR
    uiFlags : UInt32
    rcl : RECT
    pdx : Int32.Ptr
}
struct POLYTEXTW {
    x : Int32
    y : Int32
    n : UInt32
    lpstr : PWSTR
    uiFlags : UInt32
    rcl : RECT
    pdx : Int32.Ptr
}
struct FIXED {
    fract : UInt16
    value : Int16
}
struct MAT2 {
    eM11 : FIXED
    eM12 : FIXED
    eM21 : FIXED
    eM22 : FIXED
}
struct GLYPHMETRICS {
    gmBlackBoxX : UInt32
    gmBlackBoxY : UInt32
    gmptGlyphOrigin : POINT
    gmCellIncX : Int16
    gmCellIncY : Int16
}
struct POINTFX {
    x : FIXED
    y : FIXED
}
struct TTPOLYCURVE {
    wType : UInt16
    cpfx : UInt16
    apfx : POINTFX[1]
}
struct TTPOLYGONHEADER {
    cb : UInt32
    dwType : UInt32
    pfxStart : POINTFX
}
struct GCP_RESULTSA {
    lStructSize : UInt32
    lpOutString : PSTR
    lpOrder : UInt32.Ptr
    lpDx : Int32.Ptr
    lpCaretPos : Int32.Ptr
    lpClass : PSTR
    lpGlyphs : PWSTR
    nGlyphs : UInt32
    nMaxFit : Int32
}
struct GCP_RESULTSW {
    lStructSize : UInt32
    lpOutString : PWSTR
    lpOrder : UInt32.Ptr
    lpDx : Int32.Ptr
    lpCaretPos : Int32.Ptr
    lpClass : PSTR
    lpGlyphs : PWSTR
    nGlyphs : UInt32
    nMaxFit : Int32
}
struct RASTERIZER_STATUS {
    nSize : Int16
    wFlags : Int16
    nLanguageID : Int16
}
struct FONTENUMPROCA extends FunctionPointer {
    static Types := [LOGFONTA.Ptr, TEXTMETRICA.Ptr, UInt32, LPARAM, Int32]
}
struct FONTENUMPROCW extends FunctionPointer {
    static Types := [LOGFONTW.Ptr, TEXTMETRICW.Ptr, UInt32, LPARAM, Int32]
}
struct GOBJENUMPROC extends FunctionPointer {
    static Types := [Struct.Ptr, LPARAM, Int32]
}
struct LINEDDAPROC extends FunctionPointer {
    static Types := [Int32, Int32, LPARAM, "Void"]
}
struct LPFNDEVMODE extends FunctionPointer {
    static Types := [HWND, HMODULE, DEVMODEA.Ptr, PSTR, PSTR, DEVMODEA.Ptr, PSTR, UInt32, UInt32]
}
struct LPFNDEVCAPS extends FunctionPointer {
    static Types := [PSTR, PSTR, UInt32, PSTR, DEVMODEA.Ptr, UInt32]
}
struct WCRANGE {
    wcLow : UInt16
    cGlyphs : UInt16
}
struct GLYPHSET {
    cbThis : UInt32
    flAccel : UInt32
    cGlyphsSupported : UInt32
    cRanges : UInt32
    ranges : WCRANGE[1]
}
struct DESIGNVECTOR {
    dvReserved : UInt32
    dvNumAxes : UInt32
    dvValues : Int32[16]
}
struct AXISINFOA {
    axMinValue : Int32
    axMaxValue : Int32
    axAxisName : UInt8[16]
}
struct AXISINFOW {
    axMinValue : Int32
    axMaxValue : Int32
    axAxisName : UInt16[16]
}
struct AXESLISTA {
    axlReserved : UInt32
    axlNumAxes : UInt32
    axlAxisInfo : AXISINFOA[16]
}
struct AXESLISTW {
    axlReserved : UInt32
    axlNumAxes : UInt32
    axlAxisInfo : AXISINFOW[16]
}
struct ENUMLOGFONTEXDVA {
    elfEnumLogfontEx : ENUMLOGFONTEXA
    elfDesignVector : DESIGNVECTOR
}
struct ENUMLOGFONTEXDVW {
    elfEnumLogfontEx : ENUMLOGFONTEXW
    elfDesignVector : DESIGNVECTOR
}
struct TRIVERTEX {
    x : Int32
    y : Int32
    Red : UInt16
    Green : UInt16
    Blue : UInt16
    Alpha : UInt16
}
struct GRADIENT_TRIANGLE {
    Vertex1 : UInt32
    Vertex2 : UInt32
    Vertex3 : UInt32
}
struct GRADIENT_RECT {
    UpperLeft : UInt32
    LowerRight : UInt32
}
struct BLENDFUNCTION {
    BlendOp : UInt8
    BlendFlags : UInt8
    SourceConstantAlpha : UInt8
    AlphaFormat : UInt8
}
struct MFENUMPROC extends FunctionPointer {
    static Types := [HDC, HANDLETABLE.Ptr, METARECORD.Ptr, Int32, LPARAM, Int32]
}
struct ENHMFENUMPROC extends FunctionPointer {
    static Types := [HDC, HANDLETABLE.Ptr, ENHMETARECORD.Ptr, Int32, LPARAM, Int32]
}
struct DIBSECTION {
    dsBm : BITMAP
    dsBmih : BITMAPINFOHEADER
    dsBitfields : UInt32[3]
    dshSection : HANDLE
    dsOffset : UInt32
}
struct COLORADJUSTMENT {
    caSize : UInt16
    caFlags : UInt16
    caIlluminantIndex : UInt16
    caRedGamma : UInt16
    caGreenGamma : UInt16
    caBlueGamma : UInt16
    caReferenceBlack : UInt16
    caReferenceWhite : UInt16
    caContrast : Int16
    caBrightness : Int16
    caColorfulness : Int16
    caRedGreenTint : Int16
}
struct KERNINGPAIR {
    wFirst : UInt16
    wSecond : UInt16
    iKernAmount : Int32
}
struct EMR {
    iType : ENHANCED_METAFILE_RECORD_TYPE
    nSize : UInt32
}
struct EMRTEXT {
    ptlReference : POINTL
    nChars : UInt32
    offString : UInt32
    fOptions : UInt32
    rcl : RECTL
    offDx : UInt32
}
struct ABORTPATH {
    emr : EMR
}
struct EMRSELECTCLIPPATH {
    emr : EMR
    iMode : UInt32
}
struct EMRSETMITERLIMIT {
    emr : EMR
    eMiterLimit : Float32
}
struct EMRRESTOREDC {
    emr : EMR
    iRelative : Int32
}
struct EMRSETARCDIRECTION {
    emr : EMR
    iArcDirection : UInt32
}
struct EMRSETMAPPERFLAGS {
    emr : EMR
    dwFlags : UInt32
}
struct EMRSETTEXTCOLOR {
    emr : EMR
    crColor : COLORREF
}
struct EMRSELECTOBJECT {
    emr : EMR
    ihObject : UInt32
}
struct EMRSELECTPALETTE {
    emr : EMR
    ihPal : UInt32
}
struct EMRRESIZEPALETTE {
    emr : EMR
    ihPal : UInt32
    cEntries : UInt32
}
struct EMRSETPALETTEENTRIES {
    emr : EMR
    ihPal : UInt32
    iStart : UInt32
    cEntries : UInt32
    aPalEntries : PALETTEENTRY[1]
}
struct EMRSETCOLORADJUSTMENT {
    emr : EMR
    ColorAdjustment : COLORADJUSTMENT
}
struct EMRGDICOMMENT {
    emr : EMR
    cbData : UInt32
    Data : UInt8[1]
}
struct EMREOF {
    emr : EMR
    nPalEntries : UInt32
    offPalEntries : UInt32
    nSizeLast : UInt32
}
struct EMRLINETO {
    emr : EMR
    ptl : POINTL
}
struct EMROFFSETCLIPRGN {
    emr : EMR
    ptlOffset : POINTL
}
struct EMRFILLPATH {
    emr : EMR
    rclBounds : RECTL
}
struct EMREXCLUDECLIPRECT {
    emr : EMR
    rclClip : RECTL
}
struct EMRSETVIEWPORTORGEX {
    emr : EMR
    ptlOrigin : POINTL
}
struct EMRSETVIEWPORTEXTEX {
    emr : EMR
    szlExtent : SIZE
}
struct EMRSCALEVIEWPORTEXTEX {
    emr : EMR
    xNum : Int32
    xDenom : Int32
    yNum : Int32
    yDenom : Int32
}
struct EMRSETWORLDTRANSFORM {
    emr : EMR
    xform : XFORM
}
struct EMRMODIFYWORLDTRANSFORM {
    emr : EMR
    xform : XFORM
    iMode : MODIFY_WORLD_TRANSFORM_MODE
}
struct EMRSETPIXELV {
    emr : EMR
    ptlPixel : POINTL
    crColor : COLORREF
}
struct EMREXTFLOODFILL {
    emr : EMR
    ptlStart : POINTL
    crColor : COLORREF
    iMode : UInt32
}
struct EMRELLIPSE {
    emr : EMR
    rclBox : RECTL
}
struct EMRROUNDRECT {
    emr : EMR
    rclBox : RECTL
    szlCorner : SIZE
}
struct EMRARC {
    emr : EMR
    rclBox : RECTL
    ptlStart : POINTL
    ptlEnd : POINTL
}
struct EMRANGLEARC {
    emr : EMR
    ptlCenter : POINTL
    nRadius : UInt32
    eStartAngle : Float32
    eSweepAngle : Float32
}
struct EMRPOLYLINE {
    emr : EMR
    rclBounds : RECTL
    cptl : UInt32
    aptl : POINTL[1]
}
struct EMRPOLYLINE16 {
    emr : EMR
    rclBounds : RECTL
    cpts : UInt32
    apts : POINTS[1]
}
struct EMRPOLYDRAW {
    emr : EMR
    rclBounds : RECTL
    cptl : UInt32
    aptl : POINTL[1]
    abTypes : UInt8[1]
}
struct EMRPOLYDRAW16 {
    emr : EMR
    rclBounds : RECTL
    cpts : UInt32
    apts : POINTS[1]
    abTypes : UInt8[1]
}
struct EMRPOLYPOLYLINE {
    emr : EMR
    rclBounds : RECTL
    nPolys : UInt32
    cptl : UInt32
    aPolyCounts : UInt32[1]
    aptl : POINTL[1]
}
struct EMRPOLYPOLYLINE16 {
    emr : EMR
    rclBounds : RECTL
    nPolys : UInt32
    cpts : UInt32
    aPolyCounts : UInt32[1]
    apts : POINTS[1]
}
struct EMRINVERTRGN {
    emr : EMR
    rclBounds : RECTL
    cbRgnData : UInt32
    RgnData : UInt8[1]
}
struct EMRFILLRGN {
    emr : EMR
    rclBounds : RECTL
    cbRgnData : UInt32
    ihBrush : UInt32
    RgnData : UInt8[1]
}
struct EMRFRAMERGN {
    emr : EMR
    rclBounds : RECTL
    cbRgnData : UInt32
    ihBrush : UInt32
    szlStroke : SIZE
    RgnData : UInt8[1]
}
struct EMREXTSELECTCLIPRGN {
    emr : EMR
    cbRgnData : UInt32
    iMode : UInt32
    RgnData : UInt8[1]
}
struct EMREXTTEXTOUTA {
    emr : EMR
    rclBounds : RECTL
    iGraphicsMode : UInt32
    exScale : Float32
    eyScale : Float32
    emrtext : EMRTEXT
}
struct EMRPOLYTEXTOUTA {
    emr : EMR
    rclBounds : RECTL
    iGraphicsMode : UInt32
    exScale : Float32
    eyScale : Float32
    cStrings : Int32
    aemrtext : EMRTEXT[1]
}
struct EMRBITBLT {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    cxDest : Int32
    cyDest : Int32
    dwRop : UInt32
    xSrc : Int32
    ySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
}
struct EMRSTRETCHBLT {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    cxDest : Int32
    cyDest : Int32
    dwRop : UInt32
    xSrc : Int32
    ySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    cxSrc : Int32
    cySrc : Int32
}
struct EMRMASKBLT {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    cxDest : Int32
    cyDest : Int32
    dwRop : UInt32
    xSrc : Int32
    ySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    xMask : Int32
    yMask : Int32
    iUsageMask : UInt32
    offBmiMask : UInt32
    cbBmiMask : UInt32
    offBitsMask : UInt32
    cbBitsMask : UInt32
}
struct EMRPLGBLT {
    emr : EMR
    rclBounds : RECTL
    aptlDest : POINTL[3]
    xSrc : Int32
    ySrc : Int32
    cxSrc : Int32
    cySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    xMask : Int32
    yMask : Int32
    iUsageMask : UInt32
    offBmiMask : UInt32
    cbBmiMask : UInt32
    offBitsMask : UInt32
    cbBitsMask : UInt32
}
struct EMRSETDIBITSTODEVICE {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    xSrc : Int32
    ySrc : Int32
    cxSrc : Int32
    cySrc : Int32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    iUsageSrc : UInt32
    iStartScan : UInt32
    cScans : UInt32
}
struct EMRSTRETCHDIBITS {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    xSrc : Int32
    ySrc : Int32
    cxSrc : Int32
    cySrc : Int32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    iUsageSrc : UInt32
    dwRop : UInt32
    cxDest : Int32
    cyDest : Int32
}
struct EMREXTCREATEFONTINDIRECTW {
    emr : EMR
    ihFont : UInt32
    elfw : EXTLOGFONTW
}
struct EMRCREATEPALETTE {
    emr : EMR
    ihPal : UInt32
    lgpl : LOGPALETTE
}
struct EMRCREATEPEN {
    emr : EMR
    ihPen : UInt32
    lopn : LOGPEN
}
struct EMREXTCREATEPEN {
    emr : EMR
    ihPen : UInt32
    offBmi : UInt32
    cbBmi : UInt32
    offBits : UInt32
    cbBits : UInt32
    elp : EXTLOGPEN32
}
struct EMRCREATEBRUSHINDIRECT {
    emr : EMR
    ihBrush : UInt32
    lb : LOGBRUSH32
}
struct EMRCREATEMONOBRUSH {
    emr : EMR
    ihBrush : UInt32
    iUsage : UInt32
    offBmi : UInt32
    cbBmi : UInt32
    offBits : UInt32
    cbBits : UInt32
}
struct EMRCREATEDIBPATTERNBRUSHPT {
    emr : EMR
    ihBrush : UInt32
    iUsage : UInt32
    offBmi : UInt32
    cbBmi : UInt32
    offBits : UInt32
    cbBits : UInt32
}
struct EMRFORMAT {
    dSignature : UInt32
    nVersion : UInt32
    cbData : UInt32
    offData : UInt32
}
struct EMRGLSRECORD {
    emr : EMR
    cbData : UInt32
    Data : UInt8[1]
}
struct EMRGLSBOUNDEDRECORD {
    emr : EMR
    rclBounds : RECTL
    cbData : UInt32
    Data : UInt8[1]
}
struct EMRSETCOLORSPACE {
    emr : EMR
    ihCS : UInt32
}
struct EMREXTESCAPE {
    emr : EMR
    iEscape : Int32
    cbEscData : Int32
    EscData : UInt8[1]
}
struct EMRNAMEDESCAPE {
    emr : EMR
    iEscape : Int32
    cbDriver : Int32
    cbEscData : Int32
    EscData : UInt8[1]
}
struct EMRSETICMPROFILE {
    emr : EMR
    dwFlags : UInt32
    cbName : UInt32
    cbData : UInt32
    Data : UInt8[1]
}
struct EMRCOLORMATCHTOTARGET {
    emr : EMR
    dwAction : UInt32
    dwFlags : UInt32
    cbName : UInt32
    cbData : UInt32
    Data : UInt8[1]
}
struct EMRCOLORCORRECTPALETTE {
    emr : EMR
    ihPalette : UInt32
    nFirstEntry : UInt32
    nPalEntries : UInt32
    nReserved : UInt32
}
struct EMRALPHABLEND {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    cxDest : Int32
    cyDest : Int32
    dwRop : UInt32
    xSrc : Int32
    ySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    cxSrc : Int32
    cySrc : Int32
}
struct EMRGRADIENTFILL {
    emr : EMR
    rclBounds : RECTL
    nVer : UInt32
    nTri : UInt32
    ulMode : GRADIENT_FILL
    Ver : TRIVERTEX[1]
}
struct EMRTRANSPARENTBLT {
    emr : EMR
    rclBounds : RECTL
    xDest : Int32
    yDest : Int32
    cxDest : Int32
    cyDest : Int32
    dwRop : UInt32
    xSrc : Int32
    ySrc : Int32
    xformSrc : XFORM
    crBkColorSrc : COLORREF
    iUsageSrc : UInt32
    offBmiSrc : UInt32
    cbBmiSrc : UInt32
    offBitsSrc : UInt32
    cbBitsSrc : UInt32
    cxSrc : Int32
    cySrc : Int32
}
struct WGLSWAP {
    hdc : HDC
    uiFlags : UInt32
}
struct CFP_ALLOCPROC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
    static Options := "C"
}
struct CFP_REALLOCPROC extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Struct.Ptr]
    static Options := "C"
}
struct CFP_FREEPROC extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
    static Options := "C"
}
struct READEMBEDPROC extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct WRITEEMBEDPROC extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct TTLOADINFO {
    usStructSize : UInt16
    usRefStrSize : UInt16
    pusRefStr : UInt16.Ptr
}
struct TTEMBEDINFO {
    usStructSize : UInt16
    usRootStrSize : UInt16
    pusRootStr : UInt16.Ptr
}
struct TTVALIDATIONTESTSPARAMS {
    ulStructSize : UInt32
    lTestFromSize : Int32
    lTestToSize : Int32
    ulCharSet : UInt32
    usReserved1 : UInt16
    usCharCodeCount : UInt16
    pusCharCodeSet : UInt16.Ptr
}
struct TTVALIDATIONTESTSPARAMSEX {
    ulStructSize : UInt32
    lTestFromSize : Int32
    lTestToSize : Int32
    ulCharSet : UInt32
    usReserved1 : UInt16
    usCharCodeCount : UInt16
    pulCharCodeSet : UInt32.Ptr
}
struct GRAYSTRINGPROC extends FunctionPointer {
    static Types := [HDC, LPARAM, Int32, BOOL]
}
struct DRAWSTATEPROC extends FunctionPointer {
    static Types := [HDC, LPARAM, WPARAM, Int32, Int32, BOOL]
}
struct PAINTSTRUCT {
    hdc : HDC
    fErase : BOOL
    rcPaint : RECT
    fRestore : BOOL
    fIncUpdate : BOOL
    rgbReserved : UInt8[32]
}
struct DRAWTEXTPARAMS {
    cbSize : UInt32 := this.Size
    iTabLength : Int32
    iLeftMargin : Int32
    iRightMargin : Int32
    uiLengthDrawn : UInt32
}
struct MONITORINFO {
    cbSize : UInt32 := this.Size
    rcMonitor : RECT
    rcWork : RECT
    dwFlags : UInt32
}
struct MONITORENUMPROC extends FunctionPointer {
    static Types := [HMONITOR, HDC, RECT.Ptr, LPARAM, BOOL]
}
