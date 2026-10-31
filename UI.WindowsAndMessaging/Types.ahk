#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, COLORREF, HANDLE, HINSTANCE, HWND, LPARAM, LRESULT, POINT, PSTR, PWSTR, RECT, SIZE, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {BLENDFUNCTION, HBITMAP, HBRUSH, HDC, LOGFONTA, LOGFONTW}
#Import "..\UI.Shell\Types.ahk" {HELPINFO}

struct WNDCLASS_STYLES extends UInt32 {
    static CS_VREDRAW := 1
    static CS_HREDRAW := 2
    static CS_DBLCLKS := 8
    static CS_OWNDC := 32
    static CS_CLASSDC := 64
    static CS_PARENTDC := 128
    static CS_NOCLOSE := 512
    static CS_SAVEBITS := 2048
    static CS_BYTEALIGNCLIENT := 4096
    static CS_BYTEALIGNWINDOW := 8192
    static CS_GLOBALCLASS := 16384
    static CS_IME := 65536
    static CS_DROPSHADOW := 131072
}
struct CWP_FLAGS extends UInt32 {
    static CWP_ALL := 0
    static CWP_SKIPINVISIBLE := 1
    static CWP_SKIPDISABLED := 2
    static CWP_SKIPTRANSPARENT := 4
}
struct MESSAGEBOX_STYLE extends UInt32 {
    static MB_ABORTRETRYIGNORE := 2
    static MB_CANCELTRYCONTINUE := 6
    static MB_HELP := 16384
    static MB_OK := 0
    static MB_OKCANCEL := 1
    static MB_RETRYCANCEL := 5
    static MB_YESNO := 4
    static MB_YESNOCANCEL := 3
    static MB_ICONHAND := 16
    static MB_ICONQUESTION := 32
    static MB_ICONEXCLAMATION := 48
    static MB_ICONASTERISK := 64
    static MB_USERICON := 128
    static MB_ICONWARNING := 48
    static MB_ICONERROR := 16
    static MB_ICONINFORMATION := 64
    static MB_ICONSTOP := 16
    static MB_DEFBUTTON1 := 0
    static MB_DEFBUTTON2 := 256
    static MB_DEFBUTTON3 := 512
    static MB_DEFBUTTON4 := 768
    static MB_APPLMODAL := 0
    static MB_SYSTEMMODAL := 4096
    static MB_TASKMODAL := 8192
    static MB_NOFOCUS := 32768
    static MB_SETFOREGROUND := 65536
    static MB_DEFAULT_DESKTOP_ONLY := 131072
    static MB_TOPMOST := 262144
    static MB_RIGHT := 524288
    static MB_RTLREADING := 1048576
    static MB_SERVICE_NOTIFICATION := 2097152
    static MB_SERVICE_NOTIFICATION_NT3X := 262144
    static MB_TYPEMASK := 15
    static MB_ICONMASK := 240
    static MB_DEFMASK := 3840
    static MB_MODEMASK := 12288
    static MB_MISCMASK := 49152
}
struct MENU_ITEM_FLAGS extends UInt32 {
    static MF_BYCOMMAND := 0
    static MF_BYPOSITION := 1024
    static MF_BITMAP := 4
    static MF_CHECKED := 8
    static MF_DISABLED := 2
    static MF_ENABLED := 0
    static MF_GRAYED := 1
    static MF_MENUBARBREAK := 32
    static MF_MENUBREAK := 64
    static MF_OWNERDRAW := 256
    static MF_POPUP := 16
    static MF_SEPARATOR := 2048
    static MF_STRING := 0
    static MF_UNCHECKED := 0
    static MF_INSERT := 0
    static MF_CHANGE := 128
    static MF_APPEND := 256
    static MF_DELETE := 512
    static MF_REMOVE := 4096
    static MF_USECHECKBITMAPS := 512
    static MF_UNHILITE := 0
    static MF_HILITE := 128
    static MF_DEFAULT := 4096
    static MF_SYSMENU := 8192
    static MF_HELP := 16384
    static MF_RIGHTJUSTIFY := 16384
    static MF_MOUSESELECT := 32768
    static MF_END := 128
}
struct SHOW_WINDOW_CMD extends Int32 {
    static SW_HIDE := 0
    static SW_SHOWNORMAL := 1
    static SW_NORMAL := 1
    static SW_SHOWMINIMIZED := 2
    static SW_SHOWMAXIMIZED := 3
    static SW_MAXIMIZE := 3
    static SW_SHOWNOACTIVATE := 4
    static SW_SHOW := 5
    static SW_MINIMIZE := 6
    static SW_SHOWMINNOACTIVE := 7
    static SW_SHOWNA := 8
    static SW_RESTORE := 9
    static SW_SHOWDEFAULT := 10
    static SW_FORCEMINIMIZE := 11
    static SW_MAX := 11
}
struct SHOW_WINDOW_STATUS extends UInt32 {
    static SW_PARENTCLOSING := 1
    static SW_OTHERZOOM := 2
    static SW_PARENTOPENING := 3
    static SW_OTHERUNZOOM := 4
}
struct SCROLL_WINDOW_FLAGS extends UInt32 {
    static SW_SCROLLCHILDREN := 1
    static SW_INVALIDATE := 2
    static SW_ERASE := 4
    static SW_SMOOTHSCROLL := 16
}
struct SYSTEM_PARAMETERS_INFO_ACTION extends UInt32 {
    static SPI_GETBEEP := 1
    static SPI_SETBEEP := 2
    static SPI_GETMOUSE := 3
    static SPI_SETMOUSE := 4
    static SPI_GETBORDER := 5
    static SPI_SETBORDER := 6
    static SPI_GETKEYBOARDSPEED := 10
    static SPI_SETKEYBOARDSPEED := 11
    static SPI_LANGDRIVER := 12
    static SPI_ICONHORIZONTALSPACING := 13
    static SPI_GETSCREENSAVETIMEOUT := 14
    static SPI_SETSCREENSAVETIMEOUT := 15
    static SPI_GETSCREENSAVEACTIVE := 16
    static SPI_SETSCREENSAVEACTIVE := 17
    static SPI_GETGRIDGRANULARITY := 18
    static SPI_SETGRIDGRANULARITY := 19
    static SPI_SETDESKWALLPAPER := 20
    static SPI_SETDESKPATTERN := 21
    static SPI_GETKEYBOARDDELAY := 22
    static SPI_SETKEYBOARDDELAY := 23
    static SPI_ICONVERTICALSPACING := 24
    static SPI_GETICONTITLEWRAP := 25
    static SPI_SETICONTITLEWRAP := 26
    static SPI_GETMENUDROPALIGNMENT := 27
    static SPI_SETMENUDROPALIGNMENT := 28
    static SPI_SETDOUBLECLKWIDTH := 29
    static SPI_SETDOUBLECLKHEIGHT := 30
    static SPI_GETICONTITLELOGFONT := 31
    static SPI_SETDOUBLECLICKTIME := 32
    static SPI_SETMOUSEBUTTONSWAP := 33
    static SPI_SETICONTITLELOGFONT := 34
    static SPI_GETFASTTASKSWITCH := 35
    static SPI_SETFASTTASKSWITCH := 36
    static SPI_SETDRAGFULLWINDOWS := 37
    static SPI_GETDRAGFULLWINDOWS := 38
    static SPI_GETNONCLIENTMETRICS := 41
    static SPI_SETNONCLIENTMETRICS := 42
    static SPI_GETMINIMIZEDMETRICS := 43
    static SPI_SETMINIMIZEDMETRICS := 44
    static SPI_GETICONMETRICS := 45
    static SPI_SETICONMETRICS := 46
    static SPI_SETWORKAREA := 47
    static SPI_GETWORKAREA := 48
    static SPI_SETPENWINDOWS := 49
    static SPI_GETHIGHCONTRAST := 66
    static SPI_SETHIGHCONTRAST := 67
    static SPI_GETKEYBOARDPREF := 68
    static SPI_SETKEYBOARDPREF := 69
    static SPI_GETSCREENREADER := 70
    static SPI_SETSCREENREADER := 71
    static SPI_GETANIMATION := 72
    static SPI_SETANIMATION := 73
    static SPI_GETFONTSMOOTHING := 74
    static SPI_SETFONTSMOOTHING := 75
    static SPI_SETDRAGWIDTH := 76
    static SPI_SETDRAGHEIGHT := 77
    static SPI_SETHANDHELD := 78
    static SPI_GETLOWPOWERTIMEOUT := 79
    static SPI_GETPOWEROFFTIMEOUT := 80
    static SPI_SETLOWPOWERTIMEOUT := 81
    static SPI_SETPOWEROFFTIMEOUT := 82
    static SPI_GETLOWPOWERACTIVE := 83
    static SPI_GETPOWEROFFACTIVE := 84
    static SPI_SETLOWPOWERACTIVE := 85
    static SPI_SETPOWEROFFACTIVE := 86
    static SPI_SETCURSORS := 87
    static SPI_SETICONS := 88
    static SPI_GETDEFAULTINPUTLANG := 89
    static SPI_SETDEFAULTINPUTLANG := 90
    static SPI_SETLANGTOGGLE := 91
    static SPI_GETWINDOWSEXTENSION := 92
    static SPI_SETMOUSETRAILS := 93
    static SPI_GETMOUSETRAILS := 94
    static SPI_SETSCREENSAVERRUNNING := 97
    static SPI_SCREENSAVERRUNNING := 97
    static SPI_GETFILTERKEYS := 50
    static SPI_SETFILTERKEYS := 51
    static SPI_GETTOGGLEKEYS := 52
    static SPI_SETTOGGLEKEYS := 53
    static SPI_GETMOUSEKEYS := 54
    static SPI_SETMOUSEKEYS := 55
    static SPI_GETSHOWSOUNDS := 56
    static SPI_SETSHOWSOUNDS := 57
    static SPI_GETSTICKYKEYS := 58
    static SPI_SETSTICKYKEYS := 59
    static SPI_GETACCESSTIMEOUT := 60
    static SPI_SETACCESSTIMEOUT := 61
    static SPI_GETSERIALKEYS := 62
    static SPI_SETSERIALKEYS := 63
    static SPI_GETSOUNDSENTRY := 64
    static SPI_SETSOUNDSENTRY := 65
    static SPI_GETSNAPTODEFBUTTON := 95
    static SPI_SETSNAPTODEFBUTTON := 96
    static SPI_GETMOUSEHOVERWIDTH := 98
    static SPI_SETMOUSEHOVERWIDTH := 99
    static SPI_GETMOUSEHOVERHEIGHT := 100
    static SPI_SETMOUSEHOVERHEIGHT := 101
    static SPI_GETMOUSEHOVERTIME := 102
    static SPI_SETMOUSEHOVERTIME := 103
    static SPI_GETWHEELSCROLLLINES := 104
    static SPI_SETWHEELSCROLLLINES := 105
    static SPI_GETMENUSHOWDELAY := 106
    static SPI_SETMENUSHOWDELAY := 107
    static SPI_GETWHEELSCROLLCHARS := 108
    static SPI_SETWHEELSCROLLCHARS := 109
    static SPI_GETSHOWIMEUI := 110
    static SPI_SETSHOWIMEUI := 111
    static SPI_GETMOUSESPEED := 112
    static SPI_SETMOUSESPEED := 113
    static SPI_GETSCREENSAVERRUNNING := 114
    static SPI_GETDESKWALLPAPER := 115
    static SPI_GETAUDIODESCRIPTION := 116
    static SPI_SETAUDIODESCRIPTION := 117
    static SPI_GETSCREENSAVESECURE := 118
    static SPI_SETSCREENSAVESECURE := 119
    static SPI_GETHUNGAPPTIMEOUT := 120
    static SPI_SETHUNGAPPTIMEOUT := 121
    static SPI_GETWAITTOKILLTIMEOUT := 122
    static SPI_SETWAITTOKILLTIMEOUT := 123
    static SPI_GETWAITTOKILLSERVICETIMEOUT := 124
    static SPI_SETWAITTOKILLSERVICETIMEOUT := 125
    static SPI_GETMOUSEDOCKTHRESHOLD := 126
    static SPI_SETMOUSEDOCKTHRESHOLD := 127
    static SPI_GETPENDOCKTHRESHOLD := 128
    static SPI_SETPENDOCKTHRESHOLD := 129
    static SPI_GETWINARRANGING := 130
    static SPI_SETWINARRANGING := 131
    static SPI_GETMOUSEDRAGOUTTHRESHOLD := 132
    static SPI_SETMOUSEDRAGOUTTHRESHOLD := 133
    static SPI_GETPENDRAGOUTTHRESHOLD := 134
    static SPI_SETPENDRAGOUTTHRESHOLD := 135
    static SPI_GETMOUSESIDEMOVETHRESHOLD := 136
    static SPI_SETMOUSESIDEMOVETHRESHOLD := 137
    static SPI_GETPENSIDEMOVETHRESHOLD := 138
    static SPI_SETPENSIDEMOVETHRESHOLD := 139
    static SPI_GETDRAGFROMMAXIMIZE := 140
    static SPI_SETDRAGFROMMAXIMIZE := 141
    static SPI_GETSNAPSIZING := 142
    static SPI_SETSNAPSIZING := 143
    static SPI_GETDOCKMOVING := 144
    static SPI_SETDOCKMOVING := 145
    static SPI_GETTOUCHPREDICTIONPARAMETERS := 156
    static SPI_SETTOUCHPREDICTIONPARAMETERS := 157
    static SPI_GETLOGICALDPIOVERRIDE := 158
    static SPI_SETLOGICALDPIOVERRIDE := 159
    static SPI_GETMENURECT := 162
    static SPI_SETMENURECT := 163
    static SPI_GETTOUCHPADPARAMETERS := 174
    static SPI_SETTOUCHPADPARAMETERS := 175
    static SPI_GETACTIVEWINDOWTRACKING := 4096
    static SPI_SETACTIVEWINDOWTRACKING := 4097
    static SPI_GETMENUANIMATION := 4098
    static SPI_SETMENUANIMATION := 4099
    static SPI_GETCOMBOBOXANIMATION := 4100
    static SPI_SETCOMBOBOXANIMATION := 4101
    static SPI_GETLISTBOXSMOOTHSCROLLING := 4102
    static SPI_SETLISTBOXSMOOTHSCROLLING := 4103
    static SPI_GETGRADIENTCAPTIONS := 4104
    static SPI_SETGRADIENTCAPTIONS := 4105
    static SPI_GETKEYBOARDCUES := 4106
    static SPI_SETKEYBOARDCUES := 4107
    static SPI_GETMENUUNDERLINES := 4106
    static SPI_SETMENUUNDERLINES := 4107
    static SPI_GETACTIVEWNDTRKZORDER := 4108
    static SPI_SETACTIVEWNDTRKZORDER := 4109
    static SPI_GETHOTTRACKING := 4110
    static SPI_SETHOTTRACKING := 4111
    static SPI_GETMENUFADE := 4114
    static SPI_SETMENUFADE := 4115
    static SPI_GETSELECTIONFADE := 4116
    static SPI_SETSELECTIONFADE := 4117
    static SPI_GETTOOLTIPANIMATION := 4118
    static SPI_SETTOOLTIPANIMATION := 4119
    static SPI_GETTOOLTIPFADE := 4120
    static SPI_SETTOOLTIPFADE := 4121
    static SPI_GETCURSORSHADOW := 4122
    static SPI_SETCURSORSHADOW := 4123
    static SPI_GETMOUSESONAR := 4124
    static SPI_SETMOUSESONAR := 4125
    static SPI_GETMOUSECLICKLOCK := 4126
    static SPI_SETMOUSECLICKLOCK := 4127
    static SPI_GETMOUSEVANISH := 4128
    static SPI_SETMOUSEVANISH := 4129
    static SPI_GETFLATMENU := 4130
    static SPI_SETFLATMENU := 4131
    static SPI_GETDROPSHADOW := 4132
    static SPI_SETDROPSHADOW := 4133
    static SPI_GETBLOCKSENDINPUTRESETS := 4134
    static SPI_SETBLOCKSENDINPUTRESETS := 4135
    static SPI_GETUIEFFECTS := 4158
    static SPI_SETUIEFFECTS := 4159
    static SPI_GETDISABLEOVERLAPPEDCONTENT := 4160
    static SPI_SETDISABLEOVERLAPPEDCONTENT := 4161
    static SPI_GETCLIENTAREAANIMATION := 4162
    static SPI_SETCLIENTAREAANIMATION := 4163
    static SPI_GETCLEARTYPE := 4168
    static SPI_SETCLEARTYPE := 4169
    static SPI_GETSPEECHRECOGNITION := 4170
    static SPI_SETSPEECHRECOGNITION := 4171
    static SPI_GETCARETBROWSING := 4172
    static SPI_SETCARETBROWSING := 4173
    static SPI_GETTHREADLOCALINPUTSETTINGS := 4174
    static SPI_SETTHREADLOCALINPUTSETTINGS := 4175
    static SPI_GETSYSTEMLANGUAGEBAR := 4176
    static SPI_SETSYSTEMLANGUAGEBAR := 4177
    static SPI_GETFOREGROUNDLOCKTIMEOUT := 8192
    static SPI_SETFOREGROUNDLOCKTIMEOUT := 8193
    static SPI_GETACTIVEWNDTRKTIMEOUT := 8194
    static SPI_SETACTIVEWNDTRKTIMEOUT := 8195
    static SPI_GETFOREGROUNDFLASHCOUNT := 8196
    static SPI_SETFOREGROUNDFLASHCOUNT := 8197
    static SPI_GETCARETWIDTH := 8198
    static SPI_SETCARETWIDTH := 8199
    static SPI_GETMOUSECLICKLOCKTIME := 8200
    static SPI_SETMOUSECLICKLOCKTIME := 8201
    static SPI_GETFONTSMOOTHINGTYPE := 8202
    static SPI_SETFONTSMOOTHINGTYPE := 8203
    static SPI_GETFONTSMOOTHINGCONTRAST := 8204
    static SPI_SETFONTSMOOTHINGCONTRAST := 8205
    static SPI_GETFOCUSBORDERWIDTH := 8206
    static SPI_SETFOCUSBORDERWIDTH := 8207
    static SPI_GETFOCUSBORDERHEIGHT := 8208
    static SPI_SETFOCUSBORDERHEIGHT := 8209
    static SPI_GETFONTSMOOTHINGORIENTATION := 8210
    static SPI_SETFONTSMOOTHINGORIENTATION := 8211
    static SPI_GETMINIMUMHITRADIUS := 8212
    static SPI_SETMINIMUMHITRADIUS := 8213
    static SPI_GETMESSAGEDURATION := 8214
    static SPI_SETMESSAGEDURATION := 8215
    static SPI_GETCONTACTVISUALIZATION := 8216
    static SPI_SETCONTACTVISUALIZATION := 8217
    static SPI_GETGESTUREVISUALIZATION := 8218
    static SPI_SETGESTUREVISUALIZATION := 8219
    static SPI_GETMOUSEWHEELROUTING := 8220
    static SPI_SETMOUSEWHEELROUTING := 8221
    static SPI_GETPENVISUALIZATION := 8222
    static SPI_SETPENVISUALIZATION := 8223
    static SPI_GETPENARBITRATIONTYPE := 8224
    static SPI_SETPENARBITRATIONTYPE := 8225
    static SPI_GETCARETTIMEOUT := 8226
    static SPI_SETCARETTIMEOUT := 8227
    static SPI_GETHANDEDNESS := 8228
    static SPI_SETHANDEDNESS := 8229
}
struct TRACK_POPUP_MENU_FLAGS extends UInt32 {
    static TPM_LEFTBUTTON := 0
    static TPM_RIGHTBUTTON := 2
    static TPM_LEFTALIGN := 0
    static TPM_CENTERALIGN := 4
    static TPM_RIGHTALIGN := 8
    static TPM_TOPALIGN := 0
    static TPM_VCENTERALIGN := 16
    static TPM_BOTTOMALIGN := 32
    static TPM_HORIZONTAL := 0
    static TPM_VERTICAL := 64
    static TPM_NONOTIFY := 128
    static TPM_RETURNCMD := 256
    static TPM_RECURSE := 1
    static TPM_HORPOSANIMATION := 1024
    static TPM_HORNEGANIMATION := 2048
    static TPM_VERPOSANIMATION := 4096
    static TPM_VERNEGANIMATION := 8192
    static TPM_NOANIMATION := 16384
    static TPM_LAYOUTRTL := 32768
    static TPM_WORKAREA := 65536
}
struct WINDOW_EX_STYLE extends UInt32 {
    static WS_EX_DLGMODALFRAME := 1
    static WS_EX_NOPARENTNOTIFY := 4
    static WS_EX_TOPMOST := 8
    static WS_EX_ACCEPTFILES := 16
    static WS_EX_TRANSPARENT := 32
    static WS_EX_MDICHILD := 64
    static WS_EX_TOOLWINDOW := 128
    static WS_EX_WINDOWEDGE := 256
    static WS_EX_CLIENTEDGE := 512
    static WS_EX_CONTEXTHELP := 1024
    static WS_EX_RIGHT := 4096
    static WS_EX_LEFT := 0
    static WS_EX_RTLREADING := 8192
    static WS_EX_LTRREADING := 0
    static WS_EX_LEFTSCROLLBAR := 16384
    static WS_EX_RIGHTSCROLLBAR := 0
    static WS_EX_CONTROLPARENT := 65536
    static WS_EX_STATICEDGE := 131072
    static WS_EX_APPWINDOW := 262144
    static WS_EX_OVERLAPPEDWINDOW := 768
    static WS_EX_PALETTEWINDOW := 392
    static WS_EX_LAYERED := 524288
    static WS_EX_NOINHERITLAYOUT := 1048576
    static WS_EX_NOREDIRECTIONBITMAP := 2097152
    static WS_EX_LAYOUTRTL := 4194304
    static WS_EX_COMPOSITED := 33554432
    static WS_EX_NOACTIVATE := 134217728
}
struct WINDOW_STYLE extends UInt32 {
    static WS_OVERLAPPED := 0
    static WS_POPUP := 2147483648
    static WS_CHILD := 1073741824
    static WS_MINIMIZE := 536870912
    static WS_VISIBLE := 268435456
    static WS_DISABLED := 134217728
    static WS_CLIPSIBLINGS := 67108864
    static WS_CLIPCHILDREN := 33554432
    static WS_MAXIMIZE := 16777216
    static WS_CAPTION := 12582912
    static WS_BORDER := 8388608
    static WS_DLGFRAME := 4194304
    static WS_VSCROLL := 2097152
    static WS_HSCROLL := 1048576
    static WS_SYSMENU := 524288
    static WS_THICKFRAME := 262144
    static WS_GROUP := 131072
    static WS_TABSTOP := 65536
    static WS_MINIMIZEBOX := 131072
    static WS_MAXIMIZEBOX := 65536
    static WS_TILED := 0
    static WS_ICONIC := 536870912
    static WS_SIZEBOX := 262144
    static WS_TILEDWINDOW := 13565952
    static WS_OVERLAPPEDWINDOW := 13565952
    static WS_POPUPWINDOW := 2156396544
    static WS_CHILDWINDOW := 1073741824
    static WS_ACTIVECAPTION := 1
}
struct OBJECT_IDENTIFIER extends Int32 {
    static OBJID_WINDOW := 0
    static OBJID_SYSMENU := -1
    static OBJID_TITLEBAR := -2
    static OBJID_MENU := -3
    static OBJID_CLIENT := -4
    static OBJID_VSCROLL := -5
    static OBJID_HSCROLL := -6
    static OBJID_SIZEGRIP := -7
    static OBJID_CARET := -8
    static OBJID_CURSOR := -9
    static OBJID_ALERT := -10
    static OBJID_SOUND := -11
    static OBJID_QUERYCLASSNAMEIDX := -12
    static OBJID_NATIVEOM := -16
}
struct MENU_ITEM_TYPE extends UInt32 {
    static MFT_BITMAP := 4
    static MFT_MENUBARBREAK := 32
    static MFT_MENUBREAK := 64
    static MFT_OWNERDRAW := 256
    static MFT_RADIOCHECK := 512
    static MFT_RIGHTJUSTIFY := 16384
    static MFT_RIGHTORDER := 8192
    static MFT_SEPARATOR := 2048
    static MFT_STRING := 0
}
struct MESSAGEBOX_RESULT extends Int32 {
    static IDOK := 1
    static IDCANCEL := 2
    static IDABORT := 3
    static IDRETRY := 4
    static IDIGNORE := 5
    static IDYES := 6
    static IDNO := 7
    static IDCLOSE := 8
    static IDHELP := 9
    static IDTRYAGAIN := 10
    static IDCONTINUE := 11
    static IDASYNC := 32001
    static IDTIMEOUT := 32000
}
struct MENU_ITEM_STATE extends UInt32 {
    static MFS_GRAYED := 3
    static MFS_DISABLED := 3
    static MFS_CHECKED := 8
    static MFS_HILITE := 128
    static MFS_ENABLED := 0
    static MFS_UNCHECKED := 0
    static MFS_UNHILITE := 0
    static MFS_DEFAULT := 4096
}
struct SCROLLBAR_CONSTANTS extends Int32 {
    static SB_CTL := 2
    static SB_HORZ := 0
    static SB_VERT := 1
    static SB_BOTH := 3
}
struct GET_CLASS_LONG_INDEX extends Int32 {
    static GCW_ATOM := -32
    static GCL_CBCLSEXTRA := -20
    static GCL_CBWNDEXTRA := -18
    static GCL_HBRBACKGROUND := -10
    static GCL_HCURSOR := -12
    static GCL_HICON := -14
    static GCL_HICONSM := -34
    static GCL_HMODULE := -16
    static GCL_MENUNAME := -8
    static GCL_STYLE := -26
    static GCL_WNDPROC := -24
    static GCLP_HBRBACKGROUND := -10
    static GCLP_HCURSOR := -12
    static GCLP_HICON := -14
    static GCLP_HICONSM := -34
    static GCLP_HMODULE := -16
    static GCLP_MENUNAME := -8
    static GCLP_WNDPROC := -24
}
struct UPDATE_LAYERED_WINDOW_FLAGS extends UInt32 {
    static ULW_ALPHA := 2
    static ULW_COLORKEY := 1
    static ULW_OPAQUE := 4
    static ULW_EX_NORESIZE := 8
}
struct WINDOW_LONG_PTR_INDEX extends Int32 {
    static GWL_EXSTYLE := -20
    static GWLP_HINSTANCE := -6
    static GWLP_HWNDPARENT := -8
    static GWLP_ID := -12
    static GWL_STYLE := -16
    static GWLP_USERDATA := -21
    static GWLP_WNDPROC := -4
    static GWL_HINSTANCE := -6
    static GWL_ID := -12
    static GWL_USERDATA := -21
    static GWL_WNDPROC := -4
    static GWL_HWNDPARENT := -8
}
struct ANIMATE_WINDOW_FLAGS extends UInt32 {
    static AW_ACTIVATE := 131072
    static AW_BLEND := 524288
    static AW_CENTER := 16
    static AW_HIDE := 65536
    static AW_HOR_POSITIVE := 1
    static AW_HOR_NEGATIVE := 2
    static AW_SLIDE := 262144
    static AW_VER_POSITIVE := 4
    static AW_VER_NEGATIVE := 8
}
struct CHANGE_WINDOW_MESSAGE_FILTER_FLAGS extends UInt32 {
    static MSGFLT_ADD := 1
    static MSGFLT_REMOVE := 2
}
struct GDI_IMAGE_TYPE extends UInt32 {
    static IMAGE_BITMAP := 0
    static IMAGE_CURSOR := 2
    static IMAGE_ICON := 1
}
struct WINDOWS_HOOK_ID extends Int32 {
    static WH_CALLWNDPROC := 4
    static WH_CALLWNDPROCRET := 12
    static WH_CBT := 5
    static WH_DEBUG := 9
    static WH_FOREGROUNDIDLE := 11
    static WH_GETMESSAGE := 3
    static WH_JOURNALPLAYBACK := 1
    static WH_JOURNALRECORD := 0
    static WH_KEYBOARD := 2
    static WH_KEYBOARD_LL := 13
    static WH_MOUSE := 7
    static WH_MOUSE_LL := 14
    static WH_MSGFILTER := -1
    static WH_SHELL := 10
    static WH_SYSMSGFILTER := 6
}
struct IMAGE_FLAGS extends UInt32 {
    static LR_CREATEDIBSECTION := 8192
    static LR_DEFAULTCOLOR := 0
    static LR_DEFAULTSIZE := 64
    static LR_LOADFROMFILE := 16
    static LR_LOADMAP3DCOLORS := 4096
    static LR_LOADTRANSPARENT := 32
    static LR_MONOCHROME := 1
    static LR_SHARED := 32768
    static LR_VGACOLOR := 128
    static LR_COPYDELETEORG := 8
    static LR_COPYFROMRESOURCE := 16384
    static LR_COPYRETURNORG := 4
}
struct SYSTEM_PARAMETERS_INFO_UPDATE_FLAGS extends UInt32 {
    static SPIF_UPDATEINIFILE := 1
    static SPIF_SENDCHANGE := 2
    static SPIF_SENDWININICHANGE := 2
}
struct SET_WINDOW_POS_FLAGS extends UInt32 {
    static SWP_ASYNCWINDOWPOS := 16384
    static SWP_DEFERERASE := 8192
    static SWP_DRAWFRAME := 32
    static SWP_FRAMECHANGED := 32
    static SWP_HIDEWINDOW := 128
    static SWP_NOACTIVATE := 16
    static SWP_NOCOPYBITS := 256
    static SWP_NOMOVE := 2
    static SWP_NOOWNERZORDER := 512
    static SWP_NOREDRAW := 8
    static SWP_NOREPOSITION := 512
    static SWP_NOSENDCHANGING := 1024
    static SWP_NOSIZE := 1
    static SWP_NOZORDER := 4
    static SWP_SHOWWINDOW := 64
}
struct MSG_WAIT_FOR_MULTIPLE_OBJECTS_EX_FLAGS extends UInt32 {
    static MWMO_NONE := 0
    static MWMO_ALERTABLE := 2
    static MWMO_INPUTAVAILABLE := 4
    static MWMO_WAITALL := 1
}
struct QUEUE_STATUS_FLAGS extends UInt32 {
    static QS_ALLEVENTS := 1215
    static QS_ALLINPUT := 1279
    static QS_ALLPOSTMESSAGE := 256
    static QS_HOTKEY := 128
    static QS_INPUT := 1031
    static QS_KEY := 1
    static QS_MOUSE := 6
    static QS_MOUSEBUTTON := 4
    static QS_MOUSEMOVE := 2
    static QS_PAINT := 32
    static QS_POSTMESSAGE := 8
    static QS_RAWINPUT := 1024
    static QS_SENDMESSAGE := 64
    static QS_TIMER := 16
}
struct REGISTER_NOTIFICATION_FLAGS extends UInt32 {
    static DEVICE_NOTIFY_SERVICE_HANDLE := 1
    static DEVICE_NOTIFY_CALLBACK := 2
    static DEVICE_NOTIFY_WINDOW_HANDLE := 0
    static DEVICE_NOTIFY_ALL_INTERFACE_CLASSES := 4
}
struct SYSTEM_CURSOR_ID extends UInt32 {
    static OCR_APPSTARTING := 32650
    static OCR_NORMAL := 32512
    static OCR_CROSS := 32515
    static OCR_HAND := 32649
    static OCR_HELP := 32651
    static OCR_IBEAM := 32513
    static OCR_NO := 32648
    static OCR_SIZEALL := 32646
    static OCR_SIZENESW := 32643
    static OCR_SIZENS := 32645
    static OCR_SIZENWSE := 32642
    static OCR_SIZEWE := 32644
    static OCR_UP := 32516
    static OCR_WAIT := 32514
}
struct LAYERED_WINDOW_ATTRIBUTES_FLAGS extends UInt32 {
    static LWA_ALPHA := 2
    static LWA_COLORKEY := 1
}
struct SEND_MESSAGE_TIMEOUT_FLAGS extends UInt32 {
    static SMTO_ABORTIFHUNG := 2
    static SMTO_BLOCK := 1
    static SMTO_NORMAL := 0
    static SMTO_NOTIMEOUTIFNOTHUNG := 8
    static SMTO_ERRORONEXIT := 32
}
struct PEEK_MESSAGE_REMOVE_TYPE extends UInt32 {
    static PM_NOREMOVE := 0
    static PM_REMOVE := 1
    static PM_NOYIELD := 2
    static PM_QS_INPUT := 67567616
    static PM_QS_POSTMESSAGE := 9961472
    static PM_QS_PAINT := 2097152
    static PM_QS_SENDMESSAGE := 4194304
}
struct GET_WINDOW_CMD extends UInt32 {
    static GW_CHILD := 5
    static GW_ENABLEDPOPUP := 6
    static GW_HWNDFIRST := 0
    static GW_HWNDLAST := 1
    static GW_HWNDNEXT := 2
    static GW_HWNDPREV := 3
    static GW_OWNER := 4
}
struct SYSTEM_METRICS_INDEX extends Int32 {
    static SM_ARRANGE := 56
    static SM_CLEANBOOT := 67
    static SM_CMONITORS := 80
    static SM_CMOUSEBUTTONS := 43
    static SM_CONVERTIBLESLATEMODE := 8195
    static SM_CXBORDER := 5
    static SM_CXCURSOR := 13
    static SM_CXDLGFRAME := 7
    static SM_CXDOUBLECLK := 36
    static SM_CXDRAG := 68
    static SM_CXEDGE := 45
    static SM_CXFIXEDFRAME := 7
    static SM_CXFOCUSBORDER := 83
    static SM_CXFRAME := 32
    static SM_CXFULLSCREEN := 16
    static SM_CXHSCROLL := 21
    static SM_CXHTHUMB := 10
    static SM_CXICON := 11
    static SM_CXICONSPACING := 38
    static SM_CXMAXIMIZED := 61
    static SM_CXMAXTRACK := 59
    static SM_CXMENUCHECK := 71
    static SM_CXMENUSIZE := 54
    static SM_CXMIN := 28
    static SM_CXMINIMIZED := 57
    static SM_CXMINSPACING := 47
    static SM_CXMINTRACK := 34
    static SM_CXPADDEDBORDER := 92
    static SM_CXSCREEN := 0
    static SM_CXSIZE := 30
    static SM_CXSIZEFRAME := 32
    static SM_CXSMICON := 49
    static SM_CXSMSIZE := 52
    static SM_CXVIRTUALSCREEN := 78
    static SM_CXVSCROLL := 2
    static SM_CYBORDER := 6
    static SM_CYCAPTION := 4
    static SM_CYCURSOR := 14
    static SM_CYDLGFRAME := 8
    static SM_CYDOUBLECLK := 37
    static SM_CYDRAG := 69
    static SM_CYEDGE := 46
    static SM_CYFIXEDFRAME := 8
    static SM_CYFOCUSBORDER := 84
    static SM_CYFRAME := 33
    static SM_CYFULLSCREEN := 17
    static SM_CYHSCROLL := 3
    static SM_CYICON := 12
    static SM_CYICONSPACING := 39
    static SM_CYKANJIWINDOW := 18
    static SM_CYMAXIMIZED := 62
    static SM_CYMAXTRACK := 60
    static SM_CYMENU := 15
    static SM_CYMENUCHECK := 72
    static SM_CYMENUSIZE := 55
    static SM_CYMIN := 29
    static SM_CYMINIMIZED := 58
    static SM_CYMINSPACING := 48
    static SM_CYMINTRACK := 35
    static SM_CYSCREEN := 1
    static SM_CYSIZE := 31
    static SM_CYSIZEFRAME := 33
    static SM_CYSMCAPTION := 51
    static SM_CYSMICON := 50
    static SM_CYSMSIZE := 53
    static SM_CYVIRTUALSCREEN := 79
    static SM_CYVSCROLL := 20
    static SM_CYVTHUMB := 9
    static SM_DBCSENABLED := 42
    static SM_DEBUG := 22
    static SM_DIGITIZER := 94
    static SM_IMMENABLED := 82
    static SM_MAXIMUMTOUCHES := 95
    static SM_MEDIACENTER := 87
    static SM_MENUDROPALIGNMENT := 40
    static SM_MIDEASTENABLED := 74
    static SM_MOUSEPRESENT := 19
    static SM_MOUSEHORIZONTALWHEELPRESENT := 91
    static SM_MOUSEWHEELPRESENT := 75
    static SM_NETWORK := 63
    static SM_PENWINDOWS := 41
    static SM_REMOTECONTROL := 8193
    static SM_REMOTESESSION := 4096
    static SM_SAMEDISPLAYFORMAT := 81
    static SM_SECURE := 44
    static SM_SERVERR2 := 89
    static SM_SHOWSOUNDS := 70
    static SM_SHUTTINGDOWN := 8192
    static SM_SLOWMACHINE := 73
    static SM_STARTER := 88
    static SM_SWAPBUTTON := 23
    static SM_SYSTEMDOCKED := 8196
    static SM_TABLETPC := 86
    static SM_XVIRTUALSCREEN := 76
    static SM_YVIRTUALSCREEN := 77
}
struct GET_ANCESTOR_FLAGS extends UInt32 {
    static GA_PARENT := 1
    static GA_ROOT := 2
    static GA_ROOTOWNER := 3
}
struct TILE_WINDOWS_HOW extends UInt32 {
    static MDITILE_HORIZONTAL := 1
    static MDITILE_VERTICAL := 0
}
struct WINDOW_DISPLAY_AFFINITY extends UInt32 {
    static WDA_NONE := 0
    static WDA_MONITOR := 1
    static WDA_EXCLUDEFROMCAPTURE := 17
}
struct FOREGROUND_WINDOW_LOCK_CODE extends UInt32 {
    static LSFW_LOCK := 1
    static LSFW_UNLOCK := 2
}
struct CASCADE_WINDOWS_HOW extends UInt32 {
    static MDITILE_SKIPDISABLED := 2
    static MDITILE_ZORDER := 4
}
struct WINDOW_MESSAGE_FILTER_ACTION extends UInt32 {
    static MSGFLT_ALLOW := 1
    static MSGFLT_DISALLOW := 2
    static MSGFLT_RESET := 0
}
struct GET_MENU_DEFAULT_ITEM_FLAGS extends UInt32 {
    static GMDI_GOINTOPOPUPS := 2
    static GMDI_USEDISABLED := 1
}
struct MSGFLTINFO_STATUS extends UInt32 {
    static MSGFLTINFO_NONE := 0
    static MSGFLTINFO_ALLOWED_HIGHER := 3
    static MSGFLTINFO_ALREADYALLOWED_FORWND := 1
    static MSGFLTINFO_ALREADYDISALLOWED_FORWND := 2
}
struct MENU_ITEM_MASK extends UInt32 {
    static MIIM_BITMAP := 128
    static MIIM_CHECKMARKS := 8
    static MIIM_DATA := 32
    static MIIM_FTYPE := 256
    static MIIM_ID := 2
    static MIIM_STATE := 1
    static MIIM_STRING := 64
    static MIIM_SUBMENU := 4
    static MIIM_TYPE := 16
}
struct FLASHWINFO_FLAGS extends UInt32 {
    static FLASHW_ALL := 3
    static FLASHW_CAPTION := 1
    static FLASHW_STOP := 0
    static FLASHW_TIMER := 4
    static FLASHW_TIMERNOFG := 12
    static FLASHW_TRAY := 2
}
struct CURSORINFO_FLAGS extends UInt32 {
    static CURSOR_SHOWING := 1
    static CURSOR_SUPPRESSED := 2
}
struct MENUINFO_STYLE extends UInt32 {
    static MNS_AUTODISMISS := 268435456
    static MNS_CHECKORBMP := 67108864
    static MNS_DRAGDROP := 536870912
    static MNS_MODELESS := 1073741824
    static MNS_NOCHECK := 2147483648
    static MNS_NOTIFYBYPOS := 134217728
}
struct WINDOWPLACEMENT_FLAGS extends UInt32 {
    static WPF_ASYNCWINDOWPLACEMENT := 4
    static WPF_RESTORETOMAXIMIZED := 2
    static WPF_SETMINPOSITION := 1
}
struct MENUINFO_MASK extends UInt32 {
    static MIM_APPLYTOSUBMENUS := 2147483648
    static MIM_BACKGROUND := 2
    static MIM_HELPID := 4
    static MIM_MAXHEIGHT := 1
    static MIM_MENUDATA := 8
    static MIM_STYLE := 16
}
struct DEV_BROADCAST_HDR_DEVICE_TYPE extends UInt32 {
    static DBT_DEVTYP_DEVICEINTERFACE := 5
    static DBT_DEVTYP_HANDLE := 6
    static DBT_DEVTYP_OEM := 0
    static DBT_DEVTYP_PORT := 3
    static DBT_DEVTYP_VOLUME := 2
}
struct MINIMIZEDMETRICS_ARRANGE extends Int32 {
    static ARW_BOTTOMLEFT := 0
    static ARW_BOTTOMRIGHT := 1
    static ARW_TOPLEFT := 2
    static ARW_TOPRIGHT := 3
}
struct DEV_BROADCAST_VOLUME_FLAGS extends UInt16 {
    static DBTF_MEDIA := 1
    static DBTF_NET := 2
}
struct SCROLLINFO_MASK extends UInt32 {
    static SIF_ALL := 23
    static SIF_DISABLENOSCROLL := 8
    static SIF_PAGE := 2
    static SIF_POS := 4
    static SIF_RANGE := 1
    static SIF_TRACKPOS := 16
}
struct MENUGETOBJECTINFO_FLAGS extends UInt32 {
    static MNGOF_BOTTOMGAP := 2
    static MNGOF_TOPGAP := 1
}
struct GUITHREADINFO_FLAGS extends UInt32 {
    static GUI_CARETBLINKING := 1
    static GUI_INMENUMODE := 4
    static GUI_INMOVESIZE := 2
    static GUI_POPUPMENUMODE := 16
    static GUI_SYSTEMMENUMODE := 8
}
struct KBDLLHOOKSTRUCT_FLAGS extends UInt32 {
    static LLKHF_EXTENDED := 1
    static LLKHF_ALTDOWN := 32
    static LLKHF_UP := 128
    static LLKHF_INJECTED := 16
    static LLKHF_LOWER_IL_INJECTED := 2
}
struct ACCEL_VIRT_FLAGS extends UInt8 {
    static FVIRTKEY := 1
    static FNOINVERT := 2
    static FSHIFT := 4
    static FCONTROL := 8
    static FALT := 16
}
struct SCROLLBAR_COMMAND extends Int32 {
    static SB_LINEUP := 0
    static SB_LINELEFT := 0
    static SB_LINEDOWN := 1
    static SB_LINERIGHT := 1
    static SB_PAGEUP := 2
    static SB_PAGELEFT := 2
    static SB_PAGEDOWN := 3
    static SB_PAGERIGHT := 3
    static SB_THUMBPOSITION := 4
    static SB_THUMBTRACK := 5
    static SB_TOP := 6
    static SB_LEFT := 6
    static SB_RIGHT := 7
    static SB_BOTTOM := 7
    static SB_ENDSCROLL := 8
}
struct DI_FLAGS extends UInt32 {
    static DI_MASK := 1
    static DI_IMAGE := 2
    static DI_NORMAL := 3
    static DI_COMPAT := 4
    static DI_DEFAULTSIZE := 8
    static DI_NOMIRROR := 16
}
struct HHOOK {
    Value : IntPtr
}
struct HICON {
    Value : IntPtr
}
struct HMENU {
    Value : IntPtr
}
struct HCURSOR {
    Value : IntPtr
}
struct HACCEL {
    Value : IntPtr
}
struct HDEVNOTIFY {
    Value : IntPtr
}
struct HDWP {
    Value : IntPtr
}
struct MESSAGE_RESOURCE_ENTRY {
    Length : UInt16
    Flags : UInt16
    Text : UInt8[1]
}
struct MESSAGE_RESOURCE_BLOCK {
    LowId : UInt32
    HighId : UInt32
    OffsetToEntries : UInt32
}
struct MESSAGE_RESOURCE_DATA {
    NumberOfBlocks : UInt32
    Blocks : MESSAGE_RESOURCE_BLOCK[1]
}
struct WNDPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, LRESULT]
}
struct DLGPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr]
}
struct TIMERPROC extends FunctionPointer {
    static Types := [HWND, UInt32, IntPtr, UInt32, "Void"]
}
struct WNDENUMPROC extends FunctionPointer {
    static Types := [HWND, LPARAM, BOOL]
}
struct HOOKPROC extends FunctionPointer {
    static Types := [Int32, WPARAM, LPARAM, LRESULT]
}
struct SENDASYNCPROC extends FunctionPointer {
    static Types := [HWND, UInt32, IntPtr, LRESULT, "Void"]
}
struct PROPENUMPROCA extends FunctionPointer {
    static Types := [HWND, PSTR, HANDLE, BOOL]
}
struct PROPENUMPROCW extends FunctionPointer {
    static Types := [HWND, PWSTR, HANDLE, BOOL]
}
struct PROPENUMPROCEXA extends FunctionPointer {
    static Types := [HWND, PSTR, HANDLE, IntPtr, BOOL]
}
struct PROPENUMPROCEXW extends FunctionPointer {
    static Types := [HWND, PWSTR, HANDLE, IntPtr, BOOL]
}
struct NAMEENUMPROCA extends FunctionPointer {
    static Types := [PSTR, LPARAM, BOOL]
}
struct NAMEENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, LPARAM, BOOL]
}
struct CBT_CREATEWNDA {
    lpcs : CREATESTRUCTA.Ptr
    hwndInsertAfter : HWND
}
struct CBT_CREATEWNDW {
    lpcs : CREATESTRUCTW.Ptr
    hwndInsertAfter : HWND
}
struct CBTACTIVATESTRUCT {
    fMouse : BOOL
    hWndActive : HWND
}
struct SHELLHOOKINFO {
    hwnd : HWND
    rc : RECT
}
struct EVENTMSG {
    message : UInt32
    paramL : UInt32
    paramH : UInt32
    time : UInt32
    hwnd : HWND
}
struct CWPSTRUCT {
    lParam : LPARAM
    wParam : WPARAM
    message : UInt32
    hwnd : HWND
}
struct CWPRETSTRUCT {
    lResult : LRESULT
    lParam : LPARAM
    wParam : WPARAM
    message : UInt32
    hwnd : HWND
}
struct KBDLLHOOKSTRUCT {
    vkCode : UInt32
    scanCode : UInt32
    flags : KBDLLHOOKSTRUCT_FLAGS
    time : UInt32
    dwExtraInfo : IntPtr
}
struct MSLLHOOKSTRUCT {
    pt : POINT
    mouseData : UInt32
    flags : UInt32
    time : UInt32
    dwExtraInfo : IntPtr
}
struct DEBUGHOOKINFO {
    idThread : UInt32
    idThreadInstaller : UInt32
    lParam : LPARAM
    wParam : WPARAM
    code : Int32
}
struct MOUSEHOOKSTRUCT {
    pt : POINT
    hwnd : HWND
    wHitTestCode : UInt32
    dwExtraInfo : IntPtr
}
struct MOUSEHOOKSTRUCTEX {
    Base : MOUSEHOOKSTRUCT
    mouseData : UInt32
}
struct HARDWAREHOOKSTRUCT {
    hwnd : HWND
    message : UInt32
    wParam : WPARAM
    lParam : LPARAM
}
struct WNDCLASSEXA {
    cbSize : UInt32 := this.Size
    style : WNDCLASS_STYLES
    lpfnWndProc : WNDPROC
    cbClsExtra : Int32
    cbWndExtra : Int32
    hInstance : HINSTANCE
    hIcon : HICON
    hCursor : HCURSOR
    hbrBackground : HBRUSH
    lpszMenuName : PSTR
    lpszClassName : PSTR
    hIconSm : HICON
}
struct WNDCLASSEXW {
    cbSize : UInt32 := this.Size
    style : WNDCLASS_STYLES
    lpfnWndProc : WNDPROC
    cbClsExtra : Int32
    cbWndExtra : Int32
    hInstance : HINSTANCE
    hIcon : HICON
    hCursor : HCURSOR
    hbrBackground : HBRUSH
    lpszMenuName : PWSTR
    lpszClassName : PWSTR
    hIconSm : HICON
}
struct WNDCLASSA {
    style : WNDCLASS_STYLES
    lpfnWndProc : WNDPROC
    cbClsExtra : Int32
    cbWndExtra : Int32
    hInstance : HINSTANCE
    hIcon : HICON
    hCursor : HCURSOR
    hbrBackground : HBRUSH
    lpszMenuName : PSTR
    lpszClassName : PSTR
}
struct WNDCLASSW {
    style : WNDCLASS_STYLES
    lpfnWndProc : WNDPROC
    cbClsExtra : Int32
    cbWndExtra : Int32
    hInstance : HINSTANCE
    hIcon : HICON
    hCursor : HCURSOR
    hbrBackground : HBRUSH
    lpszMenuName : PWSTR
    lpszClassName : PWSTR
}
struct MSG {
    hwnd : HWND
    message : UInt32
    wParam : WPARAM
    lParam : LPARAM
    time : UInt32
    pt : POINT
}
struct MINMAXINFO {
    ptReserved : POINT
    ptMaxSize : POINT
    ptMaxPosition : POINT
    ptMinTrackSize : POINT
    ptMaxTrackSize : POINT
}
struct MDINEXTMENU {
    hmenuIn : HMENU
    hmenuNext : HMENU
    hwndNext : HWND
}
struct WINDOWPOS {
    hwnd : HWND
    hwndInsertAfter : HWND
    x : Int32
    y : Int32
    cx : Int32
    cy : Int32
    flags : SET_WINDOW_POS_FLAGS
}
struct NCCALCSIZE_PARAMS {
    rgrc : RECT[3]
    lppos : WINDOWPOS.Ptr
}
struct ACCEL {
    fVirt : ACCEL_VIRT_FLAGS
    key : UInt16
    cmd : UInt16
}
struct CREATESTRUCTA {
    lpCreateParams : Struct.Ptr
    hInstance : HINSTANCE
    hMenu : HMENU
    hwndParent : HWND
    cy : Int32
    cx : Int32
    y : Int32
    x : Int32
    style : Int32
    lpszName : PSTR
    lpszClass : PSTR
    dwExStyle : WINDOW_EX_STYLE
}
struct CREATESTRUCTW {
    lpCreateParams : Struct.Ptr
    hInstance : HINSTANCE
    hMenu : HMENU
    hwndParent : HWND
    cy : Int32
    cx : Int32
    y : Int32
    x : Int32
    style : Int32
    lpszName : PWSTR
    lpszClass : PWSTR
    dwExStyle : WINDOW_EX_STYLE
}
struct WINDOWPLACEMENT {
    length : UInt32
    flags : WINDOWPLACEMENT_FLAGS
    showCmd : UInt32
    ptMinPosition : POINT
    ptMaxPosition : POINT
    rcNormalPosition : RECT
}
struct STYLESTRUCT {
    styleOld : UInt32
    styleNew : UInt32
}
struct PREGISTERCLASSNAMEW extends FunctionPointer {
    static Types := [PWSTR, BOOLEAN]
}
struct UPDATELAYEREDWINDOWINFO {
    cbSize : UInt32 := this.Size
    hdcDst : HDC
    pptDst : POINT.Ptr
    psize : SIZE.Ptr
    hdcSrc : HDC
    pptSrc : POINT.Ptr
    crKey : COLORREF
    pblend : BLENDFUNCTION.Ptr
    dwFlags : UPDATE_LAYERED_WINDOW_FLAGS
    prcDirty : RECT.Ptr
}
struct FRAME_MARGIN {
    left : Int16
    right : Int16
    top : Int16
    bottom : Int16
}
struct FLASHWINFO {
    cbSize : UInt32 := this.Size
    hwnd : HWND
    dwFlags : FLASHWINFO_FLAGS
    uCount : UInt32
    dwTimeout : UInt32
}
struct DLGTEMPLATE {
    style : UInt32
    dwExtendedStyle : UInt32
    cdit : UInt16
    x : Int16
    y : Int16
    cx : Int16
    cy : Int16
}
struct DLGITEMTEMPLATE {
    style : UInt32
    dwExtendedStyle : UInt32
    x : Int16
    y : Int16
    cx : Int16
    cy : Int16
    id : UInt16
}
struct GETCLIPBMETADATA {
    Version : UInt32
    IsDelayRendered : BOOL
    IsSynthetic : BOOL
}
struct POINTER_INPUT_TYPE extends Int32 {
    static PT_POINTER := 1
    static PT_TOUCH := 2
    static PT_PEN := 3
    static PT_MOUSE := 4
    static PT_TOUCHPAD := 5
}
struct TPMPARAMS {
    cbSize : UInt32 := this.Size
    rcExclude : RECT
}
struct MENUINFO {
    cbSize : UInt32 := this.Size
    fMask : MENUINFO_MASK
    dwStyle : MENUINFO_STYLE
    cyMax : UInt32
    hbrBack : HBRUSH
    dwContextHelpID : UInt32
    dwMenuData : IntPtr
}
struct MENUGETOBJECTINFO {
    dwFlags : MENUGETOBJECTINFO_FLAGS
    uPos : UInt32
    hmenu : HMENU
    riid : Struct.Ptr
    pvObj : Struct.Ptr
}
struct MENUITEMINFOA {
    cbSize : UInt32 := this.Size
    fMask : MENU_ITEM_MASK
    fType : MENU_ITEM_TYPE
    fState : MENU_ITEM_STATE
    wID : UInt32
    hSubMenu : HMENU
    hbmpChecked : HBITMAP
    hbmpUnchecked : HBITMAP
    dwItemData : IntPtr
    dwTypeData : PSTR
    cch : UInt32
    hbmpItem : HBITMAP
}
struct MENUITEMINFOW {
    cbSize : UInt32 := this.Size
    fMask : MENU_ITEM_MASK
    fType : MENU_ITEM_TYPE
    fState : MENU_ITEM_STATE
    wID : UInt32
    hSubMenu : HMENU
    hbmpChecked : HBITMAP
    hbmpUnchecked : HBITMAP
    dwItemData : IntPtr
    dwTypeData : PWSTR
    cch : UInt32
    hbmpItem : HBITMAP
}
struct DROPSTRUCT {
    hwndSource : HWND
    hwndSink : HWND
    wFmt : UInt32
    dwData : IntPtr
    ptDrop : POINT
    dwControlData : UInt32
}
struct MSGBOXCALLBACK extends FunctionPointer {
    static Types := [HELPINFO.Ptr, "Void"]
}
struct MSGBOXPARAMSA {
    cbSize : UInt32 := this.Size
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpszText : PSTR
    lpszCaption : PSTR
    dwStyle : MESSAGEBOX_STYLE
    lpszIcon : PSTR
    dwContextHelpId : IntPtr
    lpfnMsgBoxCallback : MSGBOXCALLBACK
    dwLanguageId : UInt32
}
struct MSGBOXPARAMSW {
    cbSize : UInt32 := this.Size
    hwndOwner : HWND
    hInstance : HINSTANCE
    lpszText : PWSTR
    lpszCaption : PWSTR
    dwStyle : MESSAGEBOX_STYLE
    lpszIcon : PWSTR
    dwContextHelpId : IntPtr
    lpfnMsgBoxCallback : MSGBOXCALLBACK
    dwLanguageId : UInt32
}
struct MENUITEMTEMPLATEHEADER {
    versionNumber : UInt16
    offset : UInt16
}
struct MENUITEMTEMPLATE {
    mtOption : UInt16
    mtID : UInt16
    mtString : UInt16[1]
}
struct ICONINFO {
    fIcon : BOOL
    xHotspot : UInt32
    yHotspot : UInt32
    hbmMask : HBITMAP
    hbmColor : HBITMAP
}
struct CURSORSHAPE {
    xHotSpot : Int32
    yHotSpot : Int32
    cx : Int32
    cy : Int32
    cbWidth : Int32
    Planes : UInt8
    BitsPixel : UInt8
}
struct ICONINFOEXA {
    cbSize : UInt32 := this.Size
    fIcon : BOOL
    xHotspot : UInt32
    yHotspot : UInt32
    hbmMask : HBITMAP
    hbmColor : HBITMAP
    wResID : UInt16
    szModName : CHAR[260]
    szResName : CHAR[260]
}
struct ICONINFOEXW {
    cbSize : UInt32 := this.Size
    fIcon : BOOL
    xHotspot : UInt32
    yHotspot : UInt32
    hbmMask : HBITMAP
    hbmColor : HBITMAP
    wResID : UInt16
    szModName : UInt16[260]
    szResName : UInt16[260]
}
struct EDIT_CONTROL_FEATURE extends Int32 {
    static EDIT_CONTROL_FEATURE_ENTERPRISE_DATA_PROTECTION_PASTE_SUPPORT := 0
    static EDIT_CONTROL_FEATURE_PASTE_NOTIFICATIONS := 1
}
struct SCROLLINFO {
    cbSize : UInt32 := this.Size
    fMask : SCROLLINFO_MASK
    nMin : Int32
    nMax : Int32
    nPage : UInt32
    nPos : Int32
    nTrackPos : Int32
}
struct MDICREATESTRUCTA {
    szClass : PSTR
    szTitle : PSTR
    hOwner : HANDLE
    x : Int32
    y : Int32
    cx : Int32
    cy : Int32
    style : WINDOW_STYLE
    lParam : LPARAM
}
struct MDICREATESTRUCTW {
    szClass : PWSTR
    szTitle : PWSTR
    hOwner : HANDLE
    x : Int32
    y : Int32
    cx : Int32
    cy : Int32
    style : WINDOW_STYLE
    lParam : LPARAM
}
struct CLIENTCREATESTRUCT {
    hWindowMenu : HANDLE
    idFirstChild : UInt32
}
struct TOUCHPREDICTIONPARAMETERS {
    cbSize : UInt32 := this.Size
    dwLatency : UInt32
    dwSampleTime : UInt32
    bUseHWTimeStamp : UInt32
}
struct HANDEDNESS extends Int32 {
    static HANDEDNESS_LEFT := 0
    static HANDEDNESS_RIGHT := 1
}
struct NONCLIENTMETRICSA {
    cbSize : UInt32 := this.Size
    iBorderWidth : Int32
    iScrollWidth : Int32
    iScrollHeight : Int32
    iCaptionWidth : Int32
    iCaptionHeight : Int32
    lfCaptionFont : LOGFONTA
    iSmCaptionWidth : Int32
    iSmCaptionHeight : Int32
    lfSmCaptionFont : LOGFONTA
    iMenuWidth : Int32
    iMenuHeight : Int32
    lfMenuFont : LOGFONTA
    lfStatusFont : LOGFONTA
    lfMessageFont : LOGFONTA
    iPaddedBorderWidth : Int32
}
struct NONCLIENTMETRICSW {
    cbSize : UInt32 := this.Size
    iBorderWidth : Int32
    iScrollWidth : Int32
    iScrollHeight : Int32
    iCaptionWidth : Int32
    iCaptionHeight : Int32
    lfCaptionFont : LOGFONTW
    iSmCaptionWidth : Int32
    iSmCaptionHeight : Int32
    lfSmCaptionFont : LOGFONTW
    iMenuWidth : Int32
    iMenuHeight : Int32
    lfMenuFont : LOGFONTW
    lfStatusFont : LOGFONTW
    lfMessageFont : LOGFONTW
    iPaddedBorderWidth : Int32
}
struct MINIMIZEDMETRICS {
    cbSize : UInt32 := this.Size
    iWidth : Int32
    iHorzGap : Int32
    iVertGap : Int32
    iArrange : MINIMIZEDMETRICS_ARRANGE
}
struct ICONMETRICSA {
    cbSize : UInt32 := this.Size
    iHorzSpacing : Int32
    iVertSpacing : Int32
    iTitleWrap : Int32
    lfFont : LOGFONTA
}
struct ICONMETRICSW {
    cbSize : UInt32 := this.Size
    iHorzSpacing : Int32
    iVertSpacing : Int32
    iTitleWrap : Int32
    lfFont : LOGFONTW
}
struct ANIMATIONINFO {
    cbSize : UInt32 := this.Size
    iMinAnimate : Int32
}
struct AUDIODESCRIPTION {
    cbSize : UInt32 := this.Size
    Enabled : BOOL
    Locale : UInt32
}
struct GUITHREADINFO {
    cbSize : UInt32 := this.Size
    flags : GUITHREADINFO_FLAGS
    hwndActive : HWND
    hwndFocus : HWND
    hwndCapture : HWND
    hwndMenuOwner : HWND
    hwndMoveSize : HWND
    hwndCaret : HWND
    rcCaret : RECT
}
struct CURSORINFO {
    cbSize : UInt32 := this.Size
    flags : CURSORINFO_FLAGS
    hCursor : HCURSOR
    ptScreenPos : POINT
}
struct WINDOWINFO {
    cbSize : UInt32 := this.Size
    rcWindow : RECT
    rcClient : RECT
    dwStyle : WINDOW_STYLE
    dwExStyle : WINDOW_EX_STYLE
    dwWindowStatus : UInt32
    cxWindowBorders : UInt32
    cyWindowBorders : UInt32
    atomWindowType : UInt16
    wCreatorVersion : UInt16
}
struct TITLEBARINFO {
    cbSize : UInt32 := this.Size
    rcTitleBar : RECT
    rgstate : UInt32[6]
}
struct TITLEBARINFOEX {
    cbSize : UInt32 := this.Size
    rcTitleBar : RECT
    rgstate : UInt32[6]
    rgrect : RECT[6]
}
struct MENUBARINFO {
    cbSize : UInt32 := this.Size
    rcBar : RECT
    hMenu : HMENU
    hwndMenu : HWND
    _bitfield : Int32
}
struct SCROLLBARINFO {
    cbSize : UInt32 := this.Size
    rcScrollBar : RECT
    dxyLineButton : Int32
    xyThumbTop : Int32
    xyThumbBottom : Int32
    reserved : Int32
    rgstate : UInt32[6]
}
struct ALTTABINFO {
    cbSize : UInt32 := this.Size
    cItems : Int32
    cColumns : Int32
    cRows : Int32
    iColFocus : Int32
    iRowFocus : Int32
    cxItem : Int32
    cyItem : Int32
    ptStart : POINT
}
struct LEGACY_TOUCHPAD_FEATURES extends Int32 {
    static LEGACY_TOUCHPAD_FEATURE_NONE := 0
    static LEGACY_TOUCHPAD_FEATURE_ENABLE_DISABLE := 1
    static LEGACY_TOUCHPAD_FEATURE_REVERSE_SCROLL_DIRECTION := 4
}
struct TOUCHPAD_SENSITIVITY_LEVEL extends Int32 {
    static TOUCHPAD_SENSITIVITY_LEVEL_MOST_SENSITIVE := 0
    static TOUCHPAD_SENSITIVITY_LEVEL_HIGH_SENSITIVITY := 1
    static TOUCHPAD_SENSITIVITY_LEVEL_MEDIUM_SENSITIVITY := 2
    static TOUCHPAD_SENSITIVITY_LEVEL_LOW_SENSITIVITY := 3
    static TOUCHPAD_SENSITIVITY_LEVEL_LEAST_SENSITIVE := 4
}
struct TOUCHPAD_PARAMETERS_V1 {
    versionNumber : UInt32
    maxSupportedContacts : UInt32
    legacyTouchpadFeatures : LEGACY_TOUCHPAD_FEATURES
    _bitfield1 : Int32
    _bitfield2 : Int32
    sensitivityLevel : TOUCHPAD_SENSITIVITY_LEVEL
    cursorSpeed : UInt32
    feedbackIntensity : UInt32
    clickForceSensitivity : UInt32
    rightClickZoneWidth : UInt32
    rightClickZoneHeight : UInt32
}
struct TOUCHPAD_PARAMETERS_V2 {
    Base : TOUCHPAD_PARAMETERS_V1
    _bitfield : Int32
}
struct CHANGEFILTERSTRUCT {
    cbSize : UInt32 := this.Size
    ExtStatus : MSGFLTINFO_STATUS
}
struct WINDOW_PLACEMENT_STATE extends Int32 {
    static WPS_NORMAL := 0
    static WPS_MAXIMIZED := 1
    static WPS_MINIMIZED := 2
    static WPS_ARRANGED := 3
}
struct WINDOW_ACTION_KINDS extends Int32 {
    static WAK_NONE := 0
    static WAK_VISIBILITY := 1
    static WAK_POSITION := 2
    static WAK_SIZE := 4
    static WAK_INSERT_AFTER := 8
    static WAK_ACTIVATE := 16
    static WAK_PLACEMENT_STATE := 32
    static WAK_NORMAL_RECT := 64
    static WAK_MOVE_TO_MONITOR := 128
    static WAK_FIT_TO_MONITOR := 256
    static WAK_DISPLAY_CHANGE := 512
    static WAK_SYSTEM_OPERATION := 1024
    static WAK_COALESCEABLE := 31
}
struct WINDOW_ACTION_MODIFIERS extends Int32 {
    static WAM_NONE := 0
    static WAM_FRAME_BOUNDS := 1
    static WAM_ACTIVATE_FOREGROUND := 2
    static WAM_ACTIVATE_INPUT := 4
    static WAM_ACTIVATE_NO_ZORDER := 8
    static WAM_INSERT_AFTER_NO_OWNER := 16
    static WAM_RESTORE_TO_NORMAL := 32
    static WAM_RESTORE_TO_MAXIMIZED := 64
    static WAM_RESTORE_TO_ARRANGED := 128
    static WAM_WORK_AREA := 256
    static WAM_DPI := 512
    static WAM_SCALED_TO_MONITOR := 1024
}
struct WINDOW_ACTION {
    kinds : WINDOW_ACTION_KINDS
    modifiers : WINDOW_ACTION_MODIFIERS
    visible : BOOL
    position : POINT
    size : SIZE
    insertAfter : HWND
    placementState : WINDOW_PLACEMENT_STATE
    normalRect : RECT
    workArea : RECT
    dpi : UInt32
    pointOnMonitor : POINT
    monitorTopologyId : UInt32
}
struct TOOLTIP_DISMISS_FLAGS extends Int32 {
    static TDF_REGISTER := 1
    static TDF_UNREGISTER := 2
}
struct MOVESIZE_OPERATION extends Int32 {
    static MSO_SIZE_LEFT := 1
    static MSO_SIZE_RIGHT := 2
    static MSO_SIZE_TOP := 3
    static MSO_SIZE_TOPLEFT := 4
    static MSO_SIZE_TOPRIGHT := 5
    static MSO_SIZE_BOTTOM := 6
    static MSO_SIZE_BOTTOMLEFT := 7
    static MSO_SIZE_BOTTOMRIGHT := 8
    static MSO_MOVE := 9
}
struct MENUEX_TEMPLATE_HEADER {
    wVersion : UInt16
    wOffset : UInt16
    dwHelpId : UInt32
}
struct MENUEX_TEMPLATE_ITEM {
    dwType : UInt32
    dwState : UInt32
    uId : UInt32
    wFlags : UInt16
    szText : UInt16[1]
}
struct MENUTEMPLATEEX {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Menu : this._Menu_e__Struct
            MenuEx : this._MenuEx_e__Struct
        }
        struct _Menu_e__Struct {
            mitHeader : MENUITEMTEMPLATEHEADER
            miTemplate : MENUITEMTEMPLATE[1]
        }
        struct _MenuEx_e__Struct {
            mexHeader : MENUEX_TEMPLATE_HEADER
            mexItem : MENUEX_TEMPLATE_ITEM[1]
        }
    }
}
struct IndexedResourceQualifier {
    name : PWSTR
    value : PWSTR
}
struct MrmPlatformVersion extends Int32 {
    static MrmPlatformVersion_Default := 0
    static MrmPlatformVersion_Windows10_0_0_0 := 17432576
    static MrmPlatformVersion_Windows10_0_0_5 := 17432581
}
struct MrmResourceIndexerHandle {
    handle : Struct.Ptr
}
struct MrmPackagingMode extends Int32 {
    static MrmPackagingModeStandaloneFile := 0
    static MrmPackagingModeAutoSplit := 1
    static MrmPackagingModeResourcePack := 2
}
struct MrmPackagingOptions extends Int32 {
    static MrmPackagingOptionsNone := 0
    static MrmPackagingOptionsOmitSchemaFromResourcePacks := 1
    static MrmPackagingOptionsSplitLanguageVariants := 2
}
struct MrmDumpType extends Int32 {
    static MrmDumpType_Basic := 0
    static MrmDumpType_Detailed := 1
    static MrmDumpType_Schema := 2
}
struct MrmResourceIndexerMessageSeverity extends Int32 {
    static MrmResourceIndexerMessageSeverityVerbose := 0
    static MrmResourceIndexerMessageSeverityInfo := 1
    static MrmResourceIndexerMessageSeverityWarning := 2
    static MrmResourceIndexerMessageSeverityError := 3
}
struct MrmIndexerFlags extends Int32 {
    static MrmIndexerFlagsNone := 0
    static MrmIndexerFlagsAutoMerge := 1
    static MrmIndexerFlagsCreateContentChecksum := 2
}
struct MrmResourceIndexerMessage {
    severity : MrmResourceIndexerMessageSeverity
    id : UInt32
    text : PWSTR
}
struct DEV_BROADCAST_HDR {
    dbch_size : UInt32
    dbch_devicetype : DEV_BROADCAST_HDR_DEVICE_TYPE
    dbch_reserved : UInt32
}
struct VolLockBroadcast {
    vlb_dbh : DEV_BROADCAST_HDR
    vlb_owner : UInt32
    vlb_perms : UInt8
    vlb_lockType : UInt8
    vlb_drive : UInt8
    vlb_flags : UInt8
}
struct DEV_BROADCAST_HEADER {
    dbcd_size : UInt32
    dbcd_devicetype : UInt32
    dbcd_reserved : UInt32
}
struct DEV_BROADCAST_OEM {
    dbco_size : UInt32
    dbco_devicetype : UInt32
    dbco_reserved : UInt32
    dbco_identifier : UInt32
    dbco_suppfunc : UInt32
}
struct DEV_BROADCAST_DEVNODE {
    dbcd_size : UInt32
    dbcd_devicetype : UInt32
    dbcd_reserved : UInt32
    dbcd_devnode : UInt32
}
struct DEV_BROADCAST_VOLUME {
    dbcv_size : UInt32
    dbcv_devicetype : UInt32
    dbcv_reserved : UInt32
    dbcv_unitmask : UInt32
    dbcv_flags : DEV_BROADCAST_VOLUME_FLAGS
}
struct DEV_BROADCAST_PORT_A {
    dbcp_size : UInt32
    dbcp_devicetype : UInt32
    dbcp_reserved : UInt32
    dbcp_name : CHAR[1]
}
struct DEV_BROADCAST_PORT_W {
    dbcp_size : UInt32
    dbcp_devicetype : UInt32
    dbcp_reserved : UInt32
    dbcp_name : UInt16[1]
}
struct DEV_BROADCAST_NET {
    dbcn_size : UInt32
    dbcn_devicetype : UInt32
    dbcn_reserved : UInt32
    dbcn_resource : UInt32
    dbcn_flags : UInt32
}
struct DEV_BROADCAST_DEVICEINTERFACE_A {
    dbcc_size : UInt32
    dbcc_devicetype : UInt32
    dbcc_reserved : UInt32
    dbcc_classguid : GUID
    dbcc_name : CHAR[1]
}
struct DEV_BROADCAST_DEVICEINTERFACE_W {
    dbcc_size : UInt32
    dbcc_devicetype : UInt32
    dbcc_reserved : UInt32
    dbcc_classguid : GUID
    dbcc_name : UInt16[1]
}
struct DEV_BROADCAST_HANDLE {
    dbch_size : UInt32
    dbch_devicetype : UInt32
    dbch_reserved : UInt32
    dbch_handle : HANDLE
    dbch_hdevnotify : HDEVNOTIFY
    dbch_eventguid : GUID
    dbch_nameoffset : Int32
    dbch_data : UInt8[1]
}
struct DEV_BROADCAST_HANDLE32 {
    dbch_size : UInt32
    dbch_devicetype : UInt32
    dbch_reserved : UInt32
    dbch_handle : UInt32
    dbch_hdevnotify : UInt32
    dbch_eventguid : GUID
    dbch_nameoffset : Int32
    dbch_data : UInt8[1]
}
struct DEV_BROADCAST_HANDLE64 {
    dbch_size : UInt32
    dbch_devicetype : UInt32
    dbch_reserved : UInt32
    dbch_handle : Int64
    dbch_hdevnotify : Int64
    dbch_eventguid : GUID
    dbch_nameoffset : Int32
    dbch_data : UInt8[1]
}
struct DEV_BROADCAST_USERDEFINED {
    dbud_dbh : DEV_BROADCAST_HDR
    dbud_szName : CHAR[1]
}
struct DEVICE_EVENT_MOUNT {
    Version : UInt32
    Flags : UInt32
    FileSystemNameLength : UInt32
    FileSystemNameOffset : UInt32
}
struct DEVICE_EVENT_BECOMING_READY {
    Version : UInt32
    Reason : UInt32
    Estimated100msToReady : UInt32
}
struct DEVICE_EVENT_EXTERNAL_REQUEST {
    Version : UInt32
    DeviceClass : UInt32
    ButtonStatus : UInt16
    Request : UInt16
    SystemTime : Int64
}
struct DEVICE_EVENT_GENERIC_DATA {
    EventNumber : UInt32
}
struct DEVICE_EVENT_RBC_DATA {
    EventNumber : UInt32
    SenseQualifier : UInt8
    SenseCode : UInt8
    SenseKey : UInt8
    Reserved : UInt8
    Information : UInt32
}
struct GUID_IO_DISK_CLONE_ARRIVAL_INFORMATION {
    DiskNumber : UInt32
}
struct DISK_HEALTH_NOTIFICATION_DATA {
    DeviceGuid : GUID
}
