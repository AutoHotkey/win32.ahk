#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {COLORREF, HGLOBAL, HINSTANCE, HRESULT, HWND, LPARAM, LRESULT, POINT, PSTR, PWSTR, RECT, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {DEVMODEA, HDC, LOGFONTA, LOGFONTW}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE, NMHDR}

struct COMMON_DLG_ERRORS extends UInt32 {
    static CDERR_DIALOGFAILURE := 65535
    static CDERR_GENERALCODES := 0
    static CDERR_STRUCTSIZE := 1
    static CDERR_INITIALIZATION := 2
    static CDERR_NOTEMPLATE := 3
    static CDERR_NOHINSTANCE := 4
    static CDERR_LOADSTRFAILURE := 5
    static CDERR_FINDRESFAILURE := 6
    static CDERR_LOADRESFAILURE := 7
    static CDERR_LOCKRESFAILURE := 8
    static CDERR_MEMALLOCFAILURE := 9
    static CDERR_MEMLOCKFAILURE := 10
    static CDERR_NOHOOK := 11
    static CDERR_REGISTERMSGFAIL := 12
    static PDERR_PRINTERCODES := 4096
    static PDERR_SETUPFAILURE := 4097
    static PDERR_PARSEFAILURE := 4098
    static PDERR_RETDEFFAILURE := 4099
    static PDERR_LOADDRVFAILURE := 4100
    static PDERR_GETDEVMODEFAIL := 4101
    static PDERR_INITFAILURE := 4102
    static PDERR_NODEVICES := 4103
    static PDERR_NODEFAULTPRN := 4104
    static PDERR_DNDMMISMATCH := 4105
    static PDERR_CREATEICFAILURE := 4106
    static PDERR_PRINTERNOTFOUND := 4107
    static PDERR_DEFAULTDIFFERENT := 4108
    static CFERR_CHOOSEFONTCODES := 8192
    static CFERR_NOFONTS := 8193
    static CFERR_MAXLESSTHANMIN := 8194
    static FNERR_FILENAMECODES := 12288
    static FNERR_SUBCLASSFAILURE := 12289
    static FNERR_INVALIDFILENAME := 12290
    static FNERR_BUFFERTOOSMALL := 12291
    static FRERR_FINDREPLACECODES := 16384
    static FRERR_BUFFERLENGTHZERO := 16385
    static CCERR_CHOOSECOLORCODES := 20480
}
struct CHOOSECOLOR_FLAGS extends UInt32 {
    static CC_RGBINIT := 1
    static CC_FULLOPEN := 2
    static CC_PREVENTFULLOPEN := 4
    static CC_SHOWHELP := 8
    static CC_ENABLEHOOK := 16
    static CC_ENABLETEMPLATE := 32
    static CC_ENABLETEMPLATEHANDLE := 64
    static CC_SOLIDCOLOR := 128
    static CC_ANYCOLOR := 256
}
struct OPEN_FILENAME_FLAGS extends UInt32 {
    static OFN_READONLY := 1
    static OFN_OVERWRITEPROMPT := 2
    static OFN_HIDEREADONLY := 4
    static OFN_NOCHANGEDIR := 8
    static OFN_SHOWHELP := 16
    static OFN_ENABLEHOOK := 32
    static OFN_ENABLETEMPLATE := 64
    static OFN_ENABLETEMPLATEHANDLE := 128
    static OFN_NOVALIDATE := 256
    static OFN_ALLOWMULTISELECT := 512
    static OFN_EXTENSIONDIFFERENT := 1024
    static OFN_PATHMUSTEXIST := 2048
    static OFN_FILEMUSTEXIST := 4096
    static OFN_CREATEPROMPT := 8192
    static OFN_SHAREAWARE := 16384
    static OFN_NOREADONLYRETURN := 32768
    static OFN_NOTESTFILECREATE := 65536
    static OFN_NONETWORKBUTTON := 131072
    static OFN_NOLONGNAMES := 262144
    static OFN_EXPLORER := 524288
    static OFN_NODEREFERENCELINKS := 1048576
    static OFN_LONGNAMES := 2097152
    static OFN_ENABLEINCLUDENOTIFY := 4194304
    static OFN_ENABLESIZING := 8388608
    static OFN_DONTADDTORECENT := 33554432
    static OFN_FORCESHOWHIDDEN := 268435456
}
struct OPEN_FILENAME_FLAGS_EX extends UInt32 {
    static OFN_EX_NONE := 0
    static OFN_EX_NOPLACESBAR := 1
}
struct PAGESETUPDLG_FLAGS extends UInt32 {
    static PSD_DEFAULTMINMARGINS := 0
    static PSD_DISABLEMARGINS := 16
    static PSD_DISABLEORIENTATION := 256
    static PSD_DISABLEPAGEPAINTING := 524288
    static PSD_DISABLEPAPER := 512
    static PSD_DISABLEPRINTER := 32
    static PSD_ENABLEPAGEPAINTHOOK := 262144
    static PSD_ENABLEPAGESETUPHOOK := 8192
    static PSD_ENABLEPAGESETUPTEMPLATE := 32768
    static PSD_ENABLEPAGESETUPTEMPLATEHANDLE := 131072
    static PSD_INHUNDREDTHSOFMILLIMETERS := 8
    static PSD_INTHOUSANDTHSOFINCHES := 4
    static PSD_INWININIINTLMEASURE := 0
    static PSD_MARGINS := 2
    static PSD_MINMARGINS := 1
    static PSD_NONETWORKBUTTON := 2097152
    static PSD_NOWARNING := 128
    static PSD_RETURNDEFAULT := 1024
    static PSD_SHOWHELP := 2048
}
struct CHOOSEFONT_FLAGS extends UInt32 {
    static CF_APPLY := 512
    static CF_ANSIONLY := 1024
    static CF_BOTH := 3
    static CF_EFFECTS := 256
    static CF_ENABLEHOOK := 8
    static CF_ENABLETEMPLATE := 16
    static CF_ENABLETEMPLATEHANDLE := 32
    static CF_FIXEDPITCHONLY := 16384
    static CF_FORCEFONTEXIST := 65536
    static CF_INACTIVEFONTS := 33554432
    static CF_INITTOLOGFONTSTRUCT := 64
    static CF_LIMITSIZE := 8192
    static CF_NOOEMFONTS := 2048
    static CF_NOFACESEL := 524288
    static CF_NOSCRIPTSEL := 8388608
    static CF_NOSIMULATIONS := 4096
    static CF_NOSIZESEL := 2097152
    static CF_NOSTYLESEL := 1048576
    static CF_NOVECTORFONTS := 2048
    static CF_NOVERTFONTS := 16777216
    static CF_PRINTERFONTS := 2
    static CF_SCALABLEONLY := 131072
    static CF_SCREENFONTS := 1
    static CF_SCRIPTSONLY := 1024
    static CF_SELECTSCRIPT := 4194304
    static CF_SHOWHELP := 4
    static CF_TTONLY := 262144
    static CF_USESTYLE := 128
    static CF_WYSIWYG := 32768
}
struct FINDREPLACE_FLAGS extends UInt32 {
    static FR_DOWN := 1
    static FR_WHOLEWORD := 2
    static FR_MATCHCASE := 4
    static FR_FINDNEXT := 8
    static FR_REPLACE := 16
    static FR_REPLACEALL := 32
    static FR_DIALOGTERM := 64
    static FR_SHOWHELP := 128
    static FR_ENABLEHOOK := 256
    static FR_ENABLETEMPLATE := 512
    static FR_NOUPDOWN := 1024
    static FR_NOMATCHCASE := 2048
    static FR_NOWHOLEWORD := 4096
    static FR_ENABLETEMPLATEHANDLE := 8192
    static FR_HIDEUPDOWN := 16384
    static FR_HIDEMATCHCASE := 32768
    static FR_HIDEWHOLEWORD := 65536
    static FR_RAW := 131072
    static FR_SHOWWRAPAROUND := 262144
    static FR_NOWRAPAROUND := 524288
    static FR_WRAPAROUND := 1048576
    static FR_MATCHDIAC := 536870912
    static FR_MATCHKASHIDA := 1073741824
    static FR_MATCHALEFHAMZA := 2147483648
}
struct PRINTDLGEX_FLAGS extends UInt32 {
    static PD_ALLPAGES := 0
    static PD_COLLATE := 16
    static PD_CURRENTPAGE := 4194304
    static PD_DISABLEPRINTTOFILE := 524288
    static PD_ENABLEPRINTTEMPLATE := 16384
    static PD_ENABLEPRINTTEMPLATEHANDLE := 65536
    static PD_EXCLUSIONFLAGS := 16777216
    static PD_HIDEPRINTTOFILE := 1048576
    static PD_NOCURRENTPAGE := 8388608
    static PD_NOPAGENUMS := 8
    static PD_NOSELECTION := 4
    static PD_NOWARNING := 128
    static PD_PAGENUMS := 2
    static PD_PRINTTOFILE := 32
    static PD_RETURNDC := 256
    static PD_RETURNDEFAULT := 1024
    static PD_RETURNIC := 512
    static PD_SELECTION := 1
    static PD_USEDEVMODECOPIES := 262144
    static PD_USEDEVMODECOPIESANDCOLLATE := 262144
    static PD_USELARGETEMPLATE := 268435456
    static PD_ENABLEPRINTHOOK := 4096
    static PD_ENABLESETUPHOOK := 8192
    static PD_ENABLESETUPTEMPLATE := 32768
    static PD_ENABLESETUPTEMPLATEHANDLE := 131072
    static PD_NONETWORKBUTTON := 2097152
    static PD_PRINTSETUP := 64
    static PD_SHOWHELP := 2048
}
struct CHOOSEFONT_FONT_TYPE extends UInt16 {
    static BOLD_FONTTYPE := 256
    static ITALIC_FONTTYPE := 512
    static PRINTER_FONTTYPE := 16384
    static REGULAR_FONTTYPE := 1024
    static SCREEN_FONTTYPE := 8192
    static SIMULATED_FONTTYPE := 32768
}
struct OPENFILENAME_NT4A {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpstrFilter : PSTR
    lpstrCustomFilter : PSTR
    nMaxCustFilter : UInt32
    nFilterIndex : UInt32
    lpstrFile : PSTR
    nMaxFile : UInt32
    lpstrFileTitle : PSTR
    nMaxFileTitle : UInt32
    lpstrInitialDir : PSTR
    lpstrTitle : PSTR
    Flags : UInt32
    nFileOffset : UInt16
    nFileExtension : UInt16
    lpstrDefExt : PSTR
    lCustData : LPARAM
    lpfnHook : LPOFNHOOKPROC
    lpTemplateName : PSTR
}
struct OPENFILENAME_NT4W {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpstrFilter : PWSTR
    lpstrCustomFilter : PWSTR
    nMaxCustFilter : UInt32
    nFilterIndex : UInt32
    lpstrFile : PWSTR
    nMaxFile : UInt32
    lpstrFileTitle : PWSTR
    nMaxFileTitle : UInt32
    lpstrInitialDir : PWSTR
    lpstrTitle : PWSTR
    Flags : UInt32
    nFileOffset : UInt16
    nFileExtension : UInt16
    lpstrDefExt : PWSTR
    lCustData : LPARAM
    lpfnHook : LPOFNHOOKPROC
    lpTemplateName : PWSTR
}
struct OPENFILENAMEA {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpstrFilter : PSTR
    lpstrCustomFilter : PSTR
    nMaxCustFilter : UInt32
    nFilterIndex : UInt32
    lpstrFile : PSTR
    nMaxFile : UInt32
    lpstrFileTitle : PSTR
    nMaxFileTitle : UInt32
    lpstrInitialDir : PSTR
    lpstrTitle : PSTR
    Flags : OPEN_FILENAME_FLAGS
    nFileOffset : UInt16
    nFileExtension : UInt16
    lpstrDefExt : PSTR
    lCustData : LPARAM
    lpfnHook : LPOFNHOOKPROC
    lpTemplateName : PSTR
    pvReserved : Struct.Ptr
    dwReserved : UInt32
    FlagsEx : OPEN_FILENAME_FLAGS_EX
}
struct OPENFILENAMEW {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpstrFilter : PWSTR
    lpstrCustomFilter : PWSTR
    nMaxCustFilter : UInt32
    nFilterIndex : UInt32
    lpstrFile : PWSTR
    nMaxFile : UInt32
    lpstrFileTitle : PWSTR
    nMaxFileTitle : UInt32
    lpstrInitialDir : PWSTR
    lpstrTitle : PWSTR
    Flags : OPEN_FILENAME_FLAGS
    nFileOffset : UInt16
    nFileExtension : UInt16
    lpstrDefExt : PWSTR
    lCustData : LPARAM
    lpfnHook : LPOFNHOOKPROC
    lpTemplateName : PWSTR
    pvReserved : Struct.Ptr
    dwReserved : UInt32
    FlagsEx : OPEN_FILENAME_FLAGS_EX
}
struct OFNOTIFYA {
    hdr : NMHDR
    lpOFN : OPENFILENAMEA.Ptr
    pszFile : PSTR
}
struct OFNOTIFYW {
    hdr : NMHDR
    lpOFN : OPENFILENAMEW.Ptr
    pszFile : PWSTR
}
struct OFNOTIFYEXA {
    hdr : NMHDR
    lpOFN : OPENFILENAMEA.Ptr
    psf : Struct.Ptr
    pidl : Struct.Ptr
}
struct OFNOTIFYEXW {
    hdr : NMHDR
    lpOFN : OPENFILENAMEW.Ptr
    psf : Struct.Ptr
    pidl : Struct.Ptr
}
struct CHOOSECOLORA {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HWND
    rgbResult : COLORREF
    lpCustColors : COLORREF.Ptr
    Flags : CHOOSECOLOR_FLAGS
    lCustData : LPARAM
    lpfnHook : LPCCHOOKPROC
    lpTemplateName : PSTR
}
struct CHOOSECOLORW {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HWND
    rgbResult : COLORREF
    lpCustColors : COLORREF.Ptr
    Flags : CHOOSECOLOR_FLAGS
    lCustData : LPARAM
    lpfnHook : LPCCHOOKPROC
    lpTemplateName : PWSTR
}
struct FINDREPLACEA {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    Flags : FINDREPLACE_FLAGS
    lpstrFindWhat : PSTR
    lpstrReplaceWith : PSTR
    wFindWhatLen : UInt16
    wReplaceWithLen : UInt16
    lCustData : LPARAM
    lpfnHook : LPFRHOOKPROC
    lpTemplateName : PSTR
}
struct FINDREPLACEW {
    lStructSize : UInt32
    hwndOwner : HWND
    hInstance : HINSTANCE
    Flags : FINDREPLACE_FLAGS
    lpstrFindWhat : PWSTR
    lpstrReplaceWith : PWSTR
    wFindWhatLen : UInt16
    wReplaceWithLen : UInt16
    lCustData : LPARAM
    lpfnHook : LPFRHOOKPROC
    lpTemplateName : PWSTR
}
struct CHOOSEFONTA {
    lStructSize : UInt32
    hwndOwner : HWND
    hDC : HDC
    lpLogFont : LOGFONTA.Ptr
    iPointSize : Int32
    Flags : CHOOSEFONT_FLAGS
    rgbColors : COLORREF
    lCustData : LPARAM
    lpfnHook : LPCFHOOKPROC
    lpTemplateName : PSTR
    hInstance : HINSTANCE
    lpszStyle : PSTR
    nFontType : CHOOSEFONT_FONT_TYPE
    ___MISSING_ALIGNMENT__ : UInt16
    nSizeMin : Int32
    nSizeMax : Int32
}
struct CHOOSEFONTW {
    lStructSize : UInt32
    hwndOwner : HWND
    hDC : HDC
    lpLogFont : LOGFONTW.Ptr
    iPointSize : Int32
    Flags : CHOOSEFONT_FLAGS
    rgbColors : COLORREF
    lCustData : LPARAM
    lpfnHook : LPCFHOOKPROC
    lpTemplateName : PWSTR
    hInstance : HINSTANCE
    lpszStyle : PWSTR
    nFontType : CHOOSEFONT_FONT_TYPE
    ___MISSING_ALIGNMENT__ : UInt16
    nSizeMin : Int32
    nSizeMax : Int32
}
struct PRINTDLGA {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    hDC : HDC
    Flags : PRINTDLGEX_FLAGS
    nFromPage : UInt16
    nToPage : UInt16
    nMinPage : UInt16
    nMaxPage : UInt16
    nCopies : UInt16
    hInstance : HINSTANCE
    lCustData : LPARAM
    lpfnPrintHook : LPPRINTHOOKPROC
    lpfnSetupHook : LPSETUPHOOKPROC
    lpPrintTemplateName : PSTR
    lpSetupTemplateName : PSTR
    hPrintTemplate : HGLOBAL
    hSetupTemplate : HGLOBAL
}
struct PRINTDLGW {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    hDC : HDC
    Flags : PRINTDLGEX_FLAGS
    nFromPage : UInt16
    nToPage : UInt16
    nMinPage : UInt16
    nMaxPage : UInt16
    nCopies : UInt16
    hInstance : HINSTANCE
    lCustData : LPARAM
    lpfnPrintHook : LPPRINTHOOKPROC
    lpfnSetupHook : LPSETUPHOOKPROC
    lpPrintTemplateName : PWSTR
    lpSetupTemplateName : PWSTR
    hPrintTemplate : HGLOBAL
    hSetupTemplate : HGLOBAL
}
struct PRINTPAGERANGE {
    nFromPage : UInt32
    nToPage : UInt32
}
struct PRINTDLGEXA {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    hDC : HDC
    Flags : PRINTDLGEX_FLAGS
    Flags2 : UInt32
    ExclusionFlags : UInt32
    nPageRanges : UInt32
    nMaxPageRanges : UInt32
    lpPageRanges : PRINTPAGERANGE.Ptr
    nMinPage : UInt32
    nMaxPage : UInt32
    nCopies : UInt32
    hInstance : HINSTANCE
    lpPrintTemplateName : PSTR
    lpCallback : IUnknown
    nPropertyPages : UInt32
    lphPropertyPages : HPROPSHEETPAGE.Ptr
    nStartPage : UInt32
    dwResultAction : UInt32
}
struct PRINTDLGEXW {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    hDC : HDC
    Flags : PRINTDLGEX_FLAGS
    Flags2 : UInt32
    ExclusionFlags : UInt32
    nPageRanges : UInt32
    nMaxPageRanges : UInt32
    lpPageRanges : PRINTPAGERANGE.Ptr
    nMinPage : UInt32
    nMaxPage : UInt32
    nCopies : UInt32
    hInstance : HINSTANCE
    lpPrintTemplateName : PWSTR
    lpCallback : IUnknown
    nPropertyPages : UInt32
    lphPropertyPages : HPROPSHEETPAGE.Ptr
    nStartPage : UInt32
    dwResultAction : UInt32
}
struct DEVNAMES {
    wDriverOffset : UInt16
    wDeviceOffset : UInt16
    wOutputOffset : UInt16
    wDefault : UInt16
}
struct PAGESETUPDLGA {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    Flags : PAGESETUPDLG_FLAGS
    ptPaperSize : POINT
    rtMinMargin : RECT
    rtMargin : RECT
    hInstance : HINSTANCE
    lCustData : LPARAM
    lpfnPageSetupHook : LPPAGESETUPHOOK
    lpfnPagePaintHook : LPPAGEPAINTHOOK
    lpPageSetupTemplateName : PSTR
    hPageSetupTemplate : HGLOBAL
}
struct PAGESETUPDLGW {
    lStructSize : UInt32
    hwndOwner : HWND
    hDevMode : HGLOBAL
    hDevNames : HGLOBAL
    Flags : PAGESETUPDLG_FLAGS
    ptPaperSize : POINT
    rtMinMargin : RECT
    rtMargin : RECT
    hInstance : HINSTANCE
    lCustData : LPARAM
    lpfnPageSetupHook : LPPAGESETUPHOOK
    lpfnPagePaintHook : LPPAGEPAINTHOOK
    lpPageSetupTemplateName : PWSTR
    hPageSetupTemplate : HGLOBAL
}
struct LPOFNHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPCCHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPFRHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPCFHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPPRINTHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPSETUPHOOKPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct IPrintDialogCallback extends IUnknown {
    static IID := "{5852A2C3-6530-11D1-B6A3-0000F8757BF9}"
    InitDone()
      => ComCall(3, this.p)
    SelectionChange()
      => ComCall(4, this.p)
    HandleMessage(hDlg, uMsg, wParam1, lParam1, pResult)
      => ComCall(5, this.p, HWND, hDlg, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, pResult)
}
struct IPrintDialogServices extends IUnknown {
    static IID := "{509AAEDA-5639-11D1-B6A1-0000F8757BF9}"
    GetCurrentDevMode(pDevMode, pcbSize)
      => ComCall(3, this.p, DEVMODEA.Ptr, pDevMode, UInt32.Ptr, pcbSize)
    GetCurrentPrinterName(pPrinterName?)
      => ComCall(4, this.p, PWSTR, pPrinterName?, UInt32.Ptr, pPrinterName?.Length ?? 0)
    GetCurrentPortName(pPortName?)
      => ComCall(5, this.p, PWSTR, pPortName?, UInt32.Ptr, pPortName?.Length ?? 0)
}
struct LPPAGEPAINTHOOK extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct LPPAGESETUPHOOK extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
