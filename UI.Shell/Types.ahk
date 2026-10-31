#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMDocument}
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, COLORREF, FILETIME, HANDLE, HINSTANCE, HRESULT, HWND, LPARAM, LRESULT, NTSTATUS, POINT, POINTL, PROPERTYKEY, PSTR, PWSTR, RECT, RECTL, SHANDLE_PTR, SIZE, SYSTEMTIME, VARIANT_BOOL, WPARAM}
#Import "..\Graphics.DirectComposition\Types.ahk" {IDCompositionAnimation}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HDC, HMONITOR, HPALETTE, LOGFONTW}
#Import "..\Graphics.GdiPlus\Types.ahk" {InterpolationMode}
#Import "..\NetworkManagement.IpHelper\Types.ahk" {NET_ADDRESS_INFO}
#Import "..\NetworkManagement.WNet\Types.ahk" {NETRESOURCEA}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\Storage.FileSystem\Types.ahk" {WIN32_FIND_DATAA, WIN32_FIND_DATAW}
#Import "..\System.Com\Types.ahk" {BYTE_BLOB, DISPPARAMS, EXCEPINFO, IBindCtx, IBindStatusCallback, IConnectionPoint, IDataObject, IDispatch, IEnumGUID, IEnumString, IEnumUnknown, IMalloc, IMoniker, IPersist, IServiceProvider, IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag, IPropertySetStorage, IStorage, PROPVARIANT}
#Import "..\System.Console\Types.ahk" {COORD}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}
#Import "..\System.Ole\Types.ahk" {DROPEFFECT, IDropTarget, IOleCommandTarget, IOleInPlaceSite, IOleObject, IOleWindow, OLECMDEXECOPT, OLECMDF, OLECMDID, OLEMENUGROUPWIDTHS, READYSTATE}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Search\Types.ahk" {ICondition}
#Import "..\System.SystemServices\Types.ahk" {SFGAO_FLAGS}
#Import "..\System.Threading\Types.ahk" {PROCESS_INFORMATION, STARTUPINFOW}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}
#Import "..\UI.Controls\Types.ahk" {HIMAGELIST, HPROPSHEETPAGE, LPFNSVADDPROPSHEETPAGE, NMHDR, TBBUTTON}
#Import "..\UI.Shell.Common\Types.ahk" {COMDLG_FILTERSPEC, DEVICE_SCALE_FACTOR, IObjectArray, ITEMIDLIST, SHCOLSTATE, SHELLDETAILS, STRRET}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {GETPROPERTYSTOREFLAGS, IPropertyChangeArray, IPropertyDescriptionList, IPropertyStore, PDOPSTATUS}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {CREATESTRUCTW, HACCEL, HDWP, HICON, HMENU, MSG, SHOW_WINDOW_CMD}

struct SHGFI_FLAGS extends UInt32 {
    static SHGFI_ADDOVERLAYS := 32
    static SHGFI_ATTR_SPECIFIED := 131072
    static SHGFI_ATTRIBUTES := 2048
    static SHGFI_DISPLAYNAME := 512
    static SHGFI_EXETYPE := 8192
    static SHGFI_ICON := 256
    static SHGFI_ICONLOCATION := 4096
    static SHGFI_LARGEICON := 0
    static SHGFI_LINKOVERLAY := 32768
    static SHGFI_OPENICON := 2
    static SHGFI_OVERLAYINDEX := 64
    static SHGFI_PIDL := 8
    static SHGFI_SELECTED := 65536
    static SHGFI_SHELLICONSIZE := 4
    static SHGFI_SMALLICON := 1
    static SHGFI_SYSICONINDEX := 16384
    static SHGFI_TYPENAME := 1024
    static SHGFI_USEFILEATTRIBUTES := 16
}
struct SHCNE_ID extends UInt32 {
    static SHCNE_RENAMEITEM := 1
    static SHCNE_CREATE := 2
    static SHCNE_DELETE := 4
    static SHCNE_MKDIR := 8
    static SHCNE_RMDIR := 16
    static SHCNE_MEDIAINSERTED := 32
    static SHCNE_MEDIAREMOVED := 64
    static SHCNE_DRIVEREMOVED := 128
    static SHCNE_DRIVEADD := 256
    static SHCNE_NETSHARE := 512
    static SHCNE_NETUNSHARE := 1024
    static SHCNE_ATTRIBUTES := 2048
    static SHCNE_UPDATEDIR := 4096
    static SHCNE_UPDATEITEM := 8192
    static SHCNE_SERVERDISCONNECT := 16384
    static SHCNE_UPDATEIMAGE := 32768
    static SHCNE_DRIVEADDGUI := 65536
    static SHCNE_RENAMEFOLDER := 131072
    static SHCNE_FREESPACE := 262144
    static SHCNE_EXTENDED_EVENT := 67108864
    static SHCNE_ASSOCCHANGED := 134217728
    static SHCNE_DISKEVENTS := 145439
    static SHCNE_GLOBALEVENTS := 201687520
    static SHCNE_ALLEVENTS := 2147483647
    static SHCNE_INTERRUPT := 2147483648
}
struct SHCNRF_SOURCE extends Int32 {
    static SHCNRF_InterruptLevel := 1
    static SHCNRF_ShellLevel := 2
    static SHCNRF_RecursiveInterrupt := 4096
    static SHCNRF_NewDelivery := 32768
}
struct SHCNF_FLAGS extends UInt32 {
    static SHCNF_IDLIST := 0
    static SHCNF_PATHA := 1
    static SHCNF_PRINTERA := 2
    static SHCNF_DWORD := 3
    static SHCNF_PATHW := 5
    static SHCNF_PRINTERW := 6
    static SHCNF_TYPE := 255
    static SHCNF_FLUSH := 4096
    static SHCNF_FLUSHNOWAIT := 12288
    static SHCNF_NOTIFYRECURSIVE := 65536
    static SHCNF_PATH := 5
    static SHCNF_PRINTER := 6
}
struct QITIPF_FLAGS extends Int32 {
    static QITIPF_DEFAULT := 0
    static QITIPF_USENAME := 1
    static QITIPF_LINKNOTARGET := 2
    static QITIPF_LINKUSETARGET := 4
    static QITIPF_USESLOWTIP := 8
    static QITIPF_SINGLELINE := 16
    static QIF_CACHED := 1
    static QIF_DONTEXPANDFOLDER := 2
}
struct SHDID_ID extends Int32 {
    static SHDID_ROOT_REGITEM := 1
    static SHDID_FS_FILE := 2
    static SHDID_FS_DIRECTORY := 3
    static SHDID_FS_OTHER := 4
    static SHDID_COMPUTER_DRIVE35 := 5
    static SHDID_COMPUTER_DRIVE525 := 6
    static SHDID_COMPUTER_REMOVABLE := 7
    static SHDID_COMPUTER_FIXED := 8
    static SHDID_COMPUTER_NETDRIVE := 9
    static SHDID_COMPUTER_CDROM := 10
    static SHDID_COMPUTER_RAMDISK := 11
    static SHDID_COMPUTER_OTHER := 12
    static SHDID_NET_DOMAIN := 13
    static SHDID_NET_SERVER := 14
    static SHDID_NET_SHARE := 15
    static SHDID_NET_RESTOFNET := 16
    static SHDID_NET_OTHER := 17
    static SHDID_COMPUTER_IMAGING := 18
    static SHDID_COMPUTER_AUDIO := 19
    static SHDID_COMPUTER_SHAREDDOCS := 20
    static SHDID_MOBILE_DEVICE := 21
    static SHDID_REMOTE_DESKTOP_DRIVE := 22
}
struct SHGDFIL_FORMAT extends Int32 {
    static SHGDFIL_FINDDATA := 1
    static SHGDFIL_NETRESOURCE := 2
    static SHGDFIL_DESCRIPTIONID := 3
}
struct PRF_FLAGS extends Int32 {
    static PRF_VERIFYEXISTS := 1
    static PRF_TRYPROGRAMEXTENSIONS := 3
    static PRF_FIRSTDIRDEF := 4
    static PRF_DONTFINDLNK := 8
    static PRF_REQUIREABSOLUTE := 16
}
struct PCS_RET extends UInt32 {
    static PCS_FATAL := 2147483648
    static PCS_REPLACEDCHAR := 1
    static PCS_REMOVEDCHAR := 2
    static PCS_TRUNCATED := 4
    static PCS_PATHTOOLONG := 8
}
struct MM_FLAGS extends UInt32 {
    static MM_ADDSEPARATOR := 1
    static MM_SUBMENUSHAVEIDS := 2
    static MM_DONTREMOVESEPS := 4
}
struct SHOP_TYPE extends Int32 {
    static SHOP_PRINTERNAME := 1
    static SHOP_FILEPATH := 2
    static SHOP_VOLUMEGUID := 4
}
struct SHFMT_ID extends UInt32 {
    static SHFMT_ID_DEFAULT := 65535
}
struct SHFMT_OPT extends Int32 {
    static SHFMT_OPT_NONE := 0
    static SHFMT_OPT_FULL := 1
    static SHFMT_OPT_SYSONLY := 2
}
struct SHFMT_RET extends UInt32 {
    static SHFMT_ERROR := 4294967295
    static SHFMT_CANCEL := 4294967294
    static SHFMT_NOFORMAT := 4294967293
}
struct VALIDATEUNC_OPTION extends Int32 {
    static VALIDATEUNC_CONNECT := 1
    static VALIDATEUNC_NOUI := 2
    static VALIDATEUNC_PRINT := 4
    static VALIDATEUNC_PERSIST := 8
    static VALIDATEUNC_VALID := 15
}
struct SFVM_MESSAGE_ID extends Int32 {
    static SFVM_MERGEMENU := 1
    static SFVM_INVOKECOMMAND := 2
    static SFVM_GETHELPTEXT := 3
    static SFVM_GETTOOLTIPTEXT := 4
    static SFVM_GETBUTTONINFO := 5
    static SFVM_GETBUTTONS := 6
    static SFVM_INITMENUPOPUP := 7
    static SFVM_FSNOTIFY := 14
    static SFVM_WINDOWCREATED := 15
    static SFVM_GETDETAILSOF := 23
    static SFVM_COLUMNCLICK := 24
    static SFVM_QUERYFSNOTIFY := 25
    static SFVM_DEFITEMCOUNT := 26
    static SFVM_DEFVIEWMODE := 27
    static SFVM_UNMERGEMENU := 28
    static SFVM_UPDATESTATUSBAR := 31
    static SFVM_BACKGROUNDENUM := 32
    static SFVM_DIDDRAGDROP := 36
    static SFVM_SETISFV := 39
    static SFVM_THISIDLIST := 41
    static SFVM_ADDPROPERTYPAGES := 47
    static SFVM_BACKGROUNDENUMDONE := 48
    static SFVM_GETNOTIFY := 49
    static SFVM_GETSORTDEFAULTS := 53
    static SFVM_SIZE := 57
    static SFVM_GETZONE := 58
    static SFVM_GETPANE := 59
    static SFVM_GETHELPTOPIC := 63
    static SFVM_GETANIMATION := 68
}
struct SFVS_SELECT extends Int32 {
    static SFVS_SELECT_NONE := 0
    static SFVS_SELECT_ALLITEMS := 1
    static SFVS_SELECT_INVERT := 2
}
struct DFM_MESSAGE_ID extends Int32 {
    static DFM_MERGECONTEXTMENU := 1
    static DFM_INVOKECOMMAND := 2
    static DFM_GETHELPTEXT := 5
    static DFM_WM_MEASUREITEM := 6
    static DFM_WM_DRAWITEM := 7
    static DFM_WM_INITMENUPOPUP := 8
    static DFM_VALIDATECMD := 9
    static DFM_MERGECONTEXTMENU_TOP := 10
    static DFM_GETHELPTEXTW := 11
    static DFM_INVOKECOMMANDEX := 12
    static DFM_MAPCOMMANDNAME := 13
    static DFM_GETDEFSTATICID := 14
    static DFM_GETVERBW := 15
    static DFM_GETVERBA := 16
    static DFM_MERGECONTEXTMENU_BOTTOM := 17
    static DFM_MODIFYQCMFLAGS := 18
}
struct DFM_CMD extends Int32 {
    static DFM_CMD_DELETE := -1
    static DFM_CMD_MOVE := -2
    static DFM_CMD_COPY := -3
    static DFM_CMD_LINK := -4
    static DFM_CMD_PROPERTIES := -5
    static DFM_CMD_NEWFOLDER := -6
    static DFM_CMD_PASTE := -7
    static DFM_CMD_VIEWLIST := -8
    static DFM_CMD_VIEWDETAILS := -9
    static DFM_CMD_PASTELINK := -10
    static DFM_CMD_PASTESPECIAL := -11
    static DFM_CMD_MODALPROP := -12
    static DFM_CMD_RENAME := -13
}
struct PID_IS extends Int32 {
    static PID_IS_URL := 2
    static PID_IS_NAME := 4
    static PID_IS_WORKINGDIR := 5
    static PID_IS_HOTKEY := 6
    static PID_IS_SHOWCMD := 7
    static PID_IS_ICONINDEX := 8
    static PID_IS_ICONFILE := 9
    static PID_IS_WHATSNEW := 10
    static PID_IS_AUTHOR := 11
    static PID_IS_DESCRIPTION := 12
    static PID_IS_COMMENT := 13
    static PID_IS_ROAMED := 15
}
struct PID_INTSITE extends Int32 {
    static PID_INTSITE_WHATSNEW := 2
    static PID_INTSITE_AUTHOR := 3
    static PID_INTSITE_LASTVISIT := 4
    static PID_INTSITE_LASTMOD := 5
    static PID_INTSITE_VISITCOUNT := 6
    static PID_INTSITE_DESCRIPTION := 7
    static PID_INTSITE_COMMENT := 8
    static PID_INTSITE_FLAGS := 9
    static PID_INTSITE_CONTENTLEN := 10
    static PID_INTSITE_CONTENTCODE := 11
    static PID_INTSITE_RECURSE := 12
    static PID_INTSITE_WATCH := 13
    static PID_INTSITE_SUBSCRIPTION := 14
    static PID_INTSITE_URL := 15
    static PID_INTSITE_TITLE := 16
    static PID_INTSITE_CODEPAGE := 18
    static PID_INTSITE_TRACKING := 19
    static PID_INTSITE_ICONINDEX := 20
    static PID_INTSITE_ICONFILE := 21
    static PID_INTSITE_ROAMED := 34
}
struct PIDISF_FLAGS extends Int32 {
    static PIDISF_RECENTLYCHANGED := 1
    static PIDISF_CACHEDSTICKY := 2
    static PIDISF_CACHEIMAGES := 16
    static PIDISF_FOLLOWALLLINKS := 32
}
struct PIDISM_OPTIONS extends Int32 {
    static PIDISM_GLOBAL := 0
    static PIDISM_WATCH := 1
    static PIDISM_DONTWATCH := 2
}
struct PIDISR_INFO extends Int32 {
    static PIDISR_UP_TO_DATE := 0
    static PIDISR_NEEDS_ADD := 1
    static PIDISR_NEEDS_UPDATE := 2
    static PIDISR_NEEDS_DELETE := 3
}
struct SSF_MASK extends UInt32 {
    static SSF_SHOWALLOBJECTS := 1
    static SSF_SHOWEXTENSIONS := 2
    static SSF_HIDDENFILEEXTS := 4
    static SSF_SERVERADMINUI := 4
    static SSF_SHOWCOMPCOLOR := 8
    static SSF_SORTCOLUMNS := 16
    static SSF_SHOWSYSFILES := 32
    static SSF_DOUBLECLICKINWEBVIEW := 128
    static SSF_SHOWATTRIBCOL := 256
    static SSF_DESKTOPHTML := 512
    static SSF_WIN95CLASSIC := 1024
    static SSF_DONTPRETTYPATH := 2048
    static SSF_SHOWINFOTIP := 8192
    static SSF_MAPNETDRVBUTTON := 4096
    static SSF_NOCONFIRMRECYCLE := 32768
    static SSF_HIDEICONS := 16384
    static SSF_FILTER := 65536
    static SSF_WEBVIEW := 131072
    static SSF_SHOWSUPERHIDDEN := 262144
    static SSF_SEPPROCESS := 524288
    static SSF_NONETCRAWLING := 1048576
    static SSF_STARTPANELON := 2097152
    static SSF_SHOWSTARTPAGE := 4194304
    static SSF_AUTOCHECKSELECT := 8388608
    static SSF_ICONSONLY := 16777216
    static SSF_SHOWTYPEOVERLAY := 33554432
    static SSF_SHOWSTATUSBAR := 67108864
}
struct ASSOCF extends UInt32 {
    static ASSOCF_NONE := 0
    static ASSOCF_INIT_NOREMAPCLSID := 1
    static ASSOCF_INIT_BYEXENAME := 2
    static ASSOCF_OPEN_BYEXENAME := 2
    static ASSOCF_INIT_DEFAULTTOSTAR := 4
    static ASSOCF_INIT_DEFAULTTOFOLDER := 8
    static ASSOCF_NOUSERSETTINGS := 16
    static ASSOCF_NOTRUNCATE := 32
    static ASSOCF_VERIFY := 64
    static ASSOCF_REMAPRUNDLL := 128
    static ASSOCF_NOFIXUPS := 256
    static ASSOCF_IGNOREBASECLASS := 512
    static ASSOCF_INIT_IGNOREUNKNOWN := 1024
    static ASSOCF_INIT_FIXED_PROGID := 2048
    static ASSOCF_IS_PROTOCOL := 4096
    static ASSOCF_INIT_FOR_FILE := 8192
    static ASSOCF_IS_FULL_URI := 16384
    static ASSOCF_PER_MACHINE_ONLY := 32768
    static ASSOCF_APP_TO_APP := 65536
}
struct NOTIFY_ICON_MESSAGE extends UInt32 {
    static NIM_ADD := 0
    static NIM_MODIFY := 1
    static NIM_DELETE := 2
    static NIM_SETFOCUS := 3
    static NIM_SETVERSION := 4
}
struct NOTIFY_ICON_DATA_FLAGS extends UInt32 {
    static NIF_MESSAGE := 1
    static NIF_ICON := 2
    static NIF_TIP := 4
    static NIF_STATE := 8
    static NIF_INFO := 16
    static NIF_GUID := 32
    static NIF_REALTIME := 64
    static NIF_SHOWTIP := 128
}
struct OS extends UInt32 {
    static OS_WINDOWS := 0
    static OS_NT := 1
    static OS_WIN95ORGREATER := 2
    static OS_NT4ORGREATER := 3
    static OS_WIN98ORGREATER := 5
    static OS_WIN98_GOLD := 6
    static OS_WIN2000ORGREATER := 7
    static OS_WIN2000PRO := 8
    static OS_WIN2000SERVER := 9
    static OS_WIN2000ADVSERVER := 10
    static OS_WIN2000DATACENTER := 11
    static OS_WIN2000TERMINAL := 12
    static OS_EMBEDDED := 13
    static OS_TERMINALCLIENT := 14
    static OS_TERMINALREMOTEADMIN := 15
    static OS_WIN95_GOLD := 16
    static OS_MEORGREATER := 17
    static OS_XPORGREATER := 18
    static OS_HOME := 19
    static OS_PROFESSIONAL := 20
    static OS_DATACENTER := 21
    static OS_ADVSERVER := 22
    static OS_SERVER := 23
    static OS_TERMINALSERVER := 24
    static OS_PERSONALTERMINALSERVER := 25
    static OS_FASTUSERSWITCHING := 26
    static OS_WELCOMELOGONUI := 27
    static OS_DOMAINMEMBER := 28
    static OS_ANYSERVER := 29
    static OS_WOW6432 := 30
    static OS_WEBSERVER := 31
    static OS_SMALLBUSINESSSERVER := 32
    static OS_TABLETPC := 33
    static OS_SERVERADMINUI := 34
    static OS_MEDIACENTER := 35
    static OS_APPLIANCE := 36
}
struct SHELL_AUTOCOMPLETE_FLAGS extends UInt32 {
    static SHACF_DEFAULT := 0
    static SHACF_FILESYSTEM := 1
    static SHACF_URLALL := 6
    static SHACF_URLHISTORY := 2
    static SHACF_URLMRU := 4
    static SHACF_USETAB := 8
    static SHACF_FILESYS_ONLY := 16
    static SHACF_FILESYS_DIRS := 32
    static SHACF_VIRTUAL_NAMESPACE := 64
    static SHACF_AUTOSUGGEST_FORCE_ON := 268435456
    static SHACF_AUTOSUGGEST_FORCE_OFF := 536870912
    static SHACF_AUTOAPPEND_FORCE_ON := 1073741824
    static SHACF_AUTOAPPEND_FORCE_OFF := 2147483648
}
struct HELP_INFO_TYPE extends Int32 {
    static HELPINFO_WINDOW := 1
    static HELPINFO_MENUITEM := 2
}
struct NOTIFY_ICON_INFOTIP_FLAGS extends UInt32 {
    static NIIF_NONE := 0
    static NIIF_INFO := 1
    static NIIF_WARNING := 2
    static NIIF_ERROR := 3
    static NIIF_USER := 4
    static NIIF_ICON_MASK := 15
    static NIIF_NOSOUND := 16
    static NIIF_LARGE_ICON := 32
    static NIIF_RESPECT_QUIET_TIME := 128
}
struct NOTIFY_ICON_STATE extends UInt32 {
    static NIS_HIDDEN := 1
    static NIS_SHAREDICON := 2
}
struct GPFIDL_FLAGS extends UInt32 {
    static GPFIDL_DEFAULT := 0
    static GPFIDL_ALTNAME := 1
    static GPFIDL_UNCPRINTER := 2
}
struct SHGSI_FLAGS extends UInt32 {
    static SHGSI_ICONLOCATION := 0
    static SHGSI_ICON := 256
    static SHGSI_SYSICONINDEX := 16384
    static SHGSI_LINKOVERLAY := 32768
    static SHGSI_SELECTED := 65536
    static SHGSI_LARGEICON := 0
    static SHGSI_SMALLICON := 1
    static SHGSI_SHELLICONSIZE := 4
}
struct FILEOPERATION_FLAGS extends UInt32 {
    static FOFX_NOSKIPJUNCTIONS := 65536
    static FOFX_PREFERHARDLINK := 131072
    static FOFX_SHOWELEVATIONPROMPT := 262144
    static FOFX_RECYCLEONDELETE := 524288
    static FOFX_EARLYFAILURE := 1048576
    static FOFX_PRESERVEFILEEXTENSIONS := 2097152
    static FOFX_KEEPNEWERFILE := 4194304
    static FOFX_NOCOPYHOOKS := 8388608
    static FOFX_NOMINIMIZEBOX := 16777216
    static FOFX_MOVEACLSACROSSVOLUMES := 33554432
    static FOFX_DONTDISPLAYSOURCEPATH := 67108864
    static FOFX_DONTDISPLAYDESTPATH := 134217728
    static FOFX_REQUIREELEVATION := 268435456
    static FOFX_ADDUNDORECORD := 536870912
    static FOFX_COPYASDOWNLOAD := 1073741824
    static FOFX_DONTDISPLAYLOCATIONS := 2147483648
    static FOF_MULTIDESTFILES := 1
    static FOF_CONFIRMMOUSE := 2
    static FOF_SILENT := 4
    static FOF_RENAMEONCOLLISION := 8
    static FOF_NOCONFIRMATION := 16
    static FOF_WANTMAPPINGHANDLE := 32
    static FOF_ALLOWUNDO := 64
    static FOF_FILESONLY := 128
    static FOF_SIMPLEPROGRESS := 256
    static FOF_NOCONFIRMMKDIR := 512
    static FOF_NOERRORUI := 1024
    static FOF_NOCOPYSECURITYATTRIBS := 2048
    static FOF_NORECURSION := 4096
    static FOF_NO_CONNECTED_ELEMENTS := 8192
    static FOF_WANTNUKEWARNING := 16384
    static FOF_NORECURSEREPARSE := 32768
    static FOF_NO_UI := 1556
}
struct HDROP {
    Value : IntPtr
}
struct HPSXA {
    Value : IntPtr
}
struct PAPPCONSTRAIN_REGISTRATION {
    Value : IntPtr
}
struct PAPPSTATE_REGISTRATION {
    Value : IntPtr
}
struct INotifyReplica extends IUnknown {
    static IID := "{99180163-DA16-101A-935C-444553540000}"
    YouAreAReplica(rgpmkOtherReplicas)
      => ComCall(3, this.p, UInt32, rgpmkOtherReplicas.Length, IMoniker.Ptr, rgpmkOtherReplicas)
}
struct APPCATEGORYINFO {
    Locale : UInt32
    pszDescription : PWSTR
    AppCategoryId : GUID
}
struct APPCATEGORYINFOLIST {
    cCategory : UInt32
    pCategoryInfo : APPCATEGORYINFO.Ptr
}
struct DRAGINFOA {
    uSize : UInt32
    pt : POINT
    fNC : BOOL
    lpFileList : PSTR
    grfKeyState : UInt32
}
struct DRAGINFOW {
    uSize : UInt32
    pt : POINT
    fNC : BOOL
    lpFileList : PWSTR
    grfKeyState : UInt32
}
struct APPBARDATA {
    cbSize : UInt32 := this.Size
    hWnd : HWND
    uCallbackMessage : UInt32
    uEdge : UInt32
    rc : RECT
    lParam : LPARAM
}
struct SHFILEOPSTRUCTA {
    hwnd : HWND
    wFunc : UInt32
    pFrom : Int8.Ptr
    pTo : Int8.Ptr
    fFlags : UInt16
    fAnyOperationsAborted : BOOL
    hNameMappings : Struct.Ptr
    lpszProgressTitle : PSTR
}
struct SHFILEOPSTRUCTW {
    hwnd : HWND
    wFunc : UInt32
    pFrom : PWSTR
    pTo : PWSTR
    fFlags : UInt16
    fAnyOperationsAborted : BOOL
    hNameMappings : Struct.Ptr
    lpszProgressTitle : PWSTR
}
struct SHNAMEMAPPINGA {
    pszOldPath : PSTR
    pszNewPath : PSTR
    cchOldPath : Int32
    cchNewPath : Int32
}
struct SHNAMEMAPPINGW {
    pszOldPath : PWSTR
    pszNewPath : PWSTR
    cchOldPath : Int32
    cchNewPath : Int32
}
struct SHELLEXECUTEINFOA {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    lpVerb : PSTR
    lpFile : PSTR
    lpParameters : PSTR
    lpDirectory : PSTR
    nShow : Int32
    hInstApp : HINSTANCE
    lpIDList : Struct.Ptr
    lpClass : PSTR
    hkeyClass : HKEY
    dwHotKey : UInt32
    Anonymous : this._Anonymous_e__Union
    hProcess : HANDLE
    struct _Anonymous_e__Union {
        union {
            hIcon : HANDLE
            hMonitor : HANDLE
        }
    }
}
struct SHELLEXECUTEINFOW {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    lpVerb : PWSTR
    lpFile : PWSTR
    lpParameters : PWSTR
    lpDirectory : PWSTR
    nShow : Int32
    hInstApp : HINSTANCE
    lpIDList : Struct.Ptr
    lpClass : PWSTR
    hkeyClass : HKEY
    dwHotKey : UInt32
    Anonymous : this._Anonymous_e__Union
    hProcess : HANDLE
    struct _Anonymous_e__Union {
        union {
            hIcon : HANDLE
            hMonitor : HANDLE
        }
    }
}
struct SHCREATEPROCESSINFOW {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    pszFile : PWSTR
    pszParameters : PWSTR
    pszCurrentDirectory : PWSTR
    hUserToken : HANDLE
    lpProcessAttributes : SECURITY_ATTRIBUTES.Ptr
    lpThreadAttributes : SECURITY_ATTRIBUTES.Ptr
    bInheritHandles : BOOL
    dwCreationFlags : UInt32
    lpStartupInfo : STARTUPINFOW.Ptr
    lpProcessInformation : PROCESS_INFORMATION.Ptr
}
struct ASSOCIATIONELEMENT {
    ac : ASSOCCLASS
    hkClass : HKEY
    pszClass : PWSTR
}
struct SHQUERYRBINFO {
    cbSize : UInt32 := this.Size
    i64Size : Int64
    i64NumItems : Int64
}
struct NOTIFYICONDATAA {
    cbSize : UInt32 := this.Size
    hWnd : HWND
    uID : UInt32
    uFlags : NOTIFY_ICON_DATA_FLAGS
    uCallbackMessage : UInt32
    hIcon : HICON
    szTip : CHAR[128]
    dwState : NOTIFY_ICON_STATE
    dwStateMask : NOTIFY_ICON_STATE
    szInfo : CHAR[256]
    Anonymous : this._Anonymous_e__Union
    szInfoTitle : CHAR[64]
    dwInfoFlags : NOTIFY_ICON_INFOTIP_FLAGS
    guidItem : GUID
    hBalloonIcon : HICON
    struct _Anonymous_e__Union {
        union {
            uTimeout : UInt32
            uVersion : UInt32
        }
    }
}
struct NOTIFYICONDATAW {
    cbSize : UInt32 := this.Size
    hWnd : HWND
    uID : UInt32
    uFlags : NOTIFY_ICON_DATA_FLAGS
    uCallbackMessage : UInt32
    hIcon : HICON
    szTip : UInt16[128]
    dwState : NOTIFY_ICON_STATE
    dwStateMask : NOTIFY_ICON_STATE
    szInfo : UInt16[256]
    Anonymous : this._Anonymous_e__Union
    szInfoTitle : UInt16[64]
    dwInfoFlags : NOTIFY_ICON_INFOTIP_FLAGS
    guidItem : GUID
    hBalloonIcon : HICON
    struct _Anonymous_e__Union {
        union {
            uTimeout : UInt32
            uVersion : UInt32
        }
    }
}
struct NOTIFYICONIDENTIFIER {
    cbSize : UInt32 := this.Size
    hWnd : HWND
    uID : UInt32
    guidItem : GUID
}
struct SHFILEINFOA {
    hIcon : HICON
    iIcon : Int32
    dwAttributes : UInt32
    szDisplayName : CHAR[260]
    szTypeName : CHAR[80]
}
struct SHFILEINFOW {
    hIcon : HICON
    iIcon : Int32
    dwAttributes : UInt32
    szDisplayName : UInt16[260]
    szTypeName : UInt16[80]
}
struct SHSTOCKICONINFO {
    cbSize : UInt32 := this.Size
    hIcon : HICON
    iSysImageIndex : Int32
    iIcon : Int32
    szPath : UInt16[260]
}
struct OPEN_PRINTER_PROPS_INFOA {
    dwSize : UInt32
    pszSheetName : PSTR
    uSheetIndex : UInt32
    dwFlags : UInt32
    bModal : BOOL
}
struct OPEN_PRINTER_PROPS_INFOW {
    dwSize : UInt32
    pszSheetName : PWSTR
    uSheetIndex : UInt32
    dwFlags : UInt32
    bModal : BOOL
}
struct SUBCLASSPROC extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, IntPtr, IntPtr, LRESULT]
}
struct HELPINFO {
    cbSize : UInt32 := this.Size
    iContextType : HELP_INFO_TYPE
    iCtrlId : Int32
    hItemHandle : HANDLE
    dwContextId : IntPtr
    MousePos : POINT
}
struct MULTIKEYHELPA {
    mkSize : UInt32
    mkKeylist : CHAR
    szKeyphrase : CHAR[1]
}
struct MULTIKEYHELPW {
    mkSize : UInt32
    mkKeylist : UInt16
    szKeyphrase : UInt16[1]
}
struct HELPWININFOA {
    wStructSize : Int32
    x : Int32
    y : Int32
    dx : Int32
    dy : Int32
    wMax : Int32
    rgchMember : CHAR[2]
}
struct HELPWININFOW {
    wStructSize : Int32
    x : Int32
    y : Int32
    dx : Int32
    dy : Int32
    wMax : Int32
    rgchMember : UInt16[2]
}
struct CMINVOKECOMMANDINFO {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    lpVerb : PSTR
    lpParameters : PSTR
    lpDirectory : PSTR
    nShow : Int32
    dwHotKey : UInt32
    hIcon : HANDLE
}
struct CMINVOKECOMMANDINFOEX {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    lpVerb : PSTR
    lpParameters : PSTR
    lpDirectory : PSTR
    nShow : Int32
    dwHotKey : UInt32
    hIcon : HANDLE
    lpTitle : PSTR
    lpVerbW : PWSTR
    lpParametersW : PWSTR
    lpDirectoryW : PWSTR
    lpTitleW : PWSTR
    ptInvoke : POINT
}
struct CMINVOKECOMMANDINFOEX_REMOTE {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    hwnd : HWND
    lpVerbString : PSTR
    lpParameters : PSTR
    lpDirectory : PSTR
    nShow : Int32
    dwHotKey : UInt32
    lpTitle : PSTR
    lpVerbWString : PWSTR
    lpParametersW : PWSTR
    lpDirectoryW : PWSTR
    lpTitleW : PWSTR
    ptInvoke : POINT
    lpVerbInt : UInt32
    lpVerbWInt : UInt32
}
struct IContextMenu extends IUnknown {
    static IID := "{000214E4-0000-0000-C000-000000000046}"
    QueryContextMenu(hmenu1, indexMenu, idCmdFirst, idCmdLast, uFlags)
      => ComCall(3, this.p, HMENU, hmenu1, UInt32, indexMenu, UInt32, idCmdFirst, UInt32, idCmdLast, UInt32, uFlags)
    InvokeCommand(pici)
      => ComCall(4, this.p, CMINVOKECOMMANDINFO.Ptr, pici)
    GetCommandString(idCmd, uType, pszName, cchMax)
      => ComCall(5, this.p, IntPtr, idCmd, UInt32, uType, "Ptr", 0, PSTR, pszName, UInt32, cchMax)
}
struct IContextMenu2 extends IContextMenu {
    static IID := "{000214F4-0000-0000-C000-000000000046}"
    HandleMenuMsg(uMsg, wParam1, lParam1)
      => ComCall(6, this.p, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
}
struct IContextMenu3 extends IContextMenu2 {
    static IID := "{BCFCE0A0-EC17-11D0-8D10-00A0C90F2719}"
    HandleMenuMsg2(uMsg, wParam1, lParam1, plResult?)
      => ComCall(7, this.p, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult?)
}
struct IStaticVerbProvider extends IUnknown {
    static IID := "{4B770DA6-D111-4015-96FD-8C1C56F06C55}"
    IsVerbSupported(verbName, result)
      => ComCall(3, this.p, "Str", verbName, BOOL.Ptr, result)
}
struct IExecuteCommand extends IUnknown {
    static IID := "{7F9185B0-CB92-43C5-80A9-92277A4F7B54}"
    SetKeyState(grfKeyState)
      => ComCall(3, this.p, UInt32, grfKeyState)
    SetParameters(pszParameters)
      => ComCall(4, this.p, "Str", pszParameters)
    SetPosition(pt)
      => ComCall(5, this.p, POINT, pt)
    SetShowWindow(nShow)
      => ComCall(6, this.p, Int32, nShow)
    SetNoShowUI(fNoShowUI)
      => ComCall(7, this.p, BOOL, fNoShowUI)
    SetDirectory(pszDirectory)
      => ComCall(8, this.p, "Str", pszDirectory)
    Execute()
      => ComCall(9, this.p)
}
struct IPersistFolder extends IPersist {
    static IID := "{000214EA-0000-0000-C000-000000000046}"
    Initialize(pidl)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidl)
}
struct IRunnableTask extends IUnknown {
    static IID := "{85788D00-6807-11D0-B810-00C04FD706EC}"
    Run()
      => ComCall(3, this.p)
    Kill(bWait)
      => ComCall(4, this.p, BOOL, bWait)
    Suspend()
      => ComCall(5, this.p)
    Resume()
      => ComCall(6, this.p)
    IsRunning()
      => ComCall(7, this.p, UInt32)
}
struct IShellTaskScheduler extends IUnknown {
    static IID := "{6CCB7BE0-6807-11D0-B810-00C04FD706EC}"
    AddTask(prt, rtoid, lParam, dwPriority)
      => ComCall(3, this.p, IRunnableTask, prt, GUID.Ptr, rtoid, IntPtr, lParam, UInt32, dwPriority)
    RemoveTasks(rtoid, lParam, bWaitIfRunning)
      => ComCall(4, this.p, GUID.Ptr, rtoid, IntPtr, lParam, BOOL, bWaitIfRunning)
    CountTasks(rtoid)
      => ComCall(5, this.p, GUID.Ptr, rtoid, UInt32)
    Status(dwReleaseStatus, dwThreadTimeout)
      => ComCall(6, this.p, UInt32, dwReleaseStatus, UInt32, dwThreadTimeout)
}
struct IPersistFolder2 extends IPersistFolder {
    static IID := "{1AC3D9F0-175C-11D1-95BE-00609797EA4F}"
    GetCurFolder(ppidl)
      => ComCall(5, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
}
struct PERSIST_FOLDER_TARGET_INFO {
    pidlTargetFolder : ITEMIDLIST.Ptr
    szTargetParsingName : UInt16[260]
    szNetworkProvider : UInt16[260]
    dwAttributes : UInt32
    csidl : Int32
}
struct IPersistFolder3 extends IPersistFolder2 {
    static IID := "{CEF04FDF-FE72-11D2-87A5-00C04F6837CF}"
    InitializeEx(pbc, pidlRoot, ppfti)
      => ComCall(6, this.p, IBindCtx, pbc, ITEMIDLIST.Ptr, pidlRoot, PERSIST_FOLDER_TARGET_INFO.Ptr, ppfti)
    GetFolderTargetInfo(ppfti)
      => ComCall(7, this.p, PERSIST_FOLDER_TARGET_INFO.Ptr, ppfti)
}
struct IPersistIDList extends IPersist {
    static IID := "{1079ACFC-29BD-11D3-8E0D-00C04F6837D5}"
    SetIDList(pidl)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidl)
    GetIDList(ppidl)
      => ComCall(5, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
}
struct IEnumIDList extends IUnknown {
    static IID := "{000214F2-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, ITEMIDLIST.Ptr.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumIDList.Ptr, ppenum)
}
struct IEnumFullIDList extends IUnknown {
    static IID := "{D0191542-7954-4908-BC06-B2360BBE45BA}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, ITEMIDLIST.Ptr.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumFullIDList.Ptr, ppenum)
}
struct SHGDNF extends UInt32 {
    static SHGDN_NORMAL := 0
    static SHGDN_INFOLDER := 1
    static SHGDN_FOREDITING := 4096
    static SHGDN_FORADDRESSBAR := 16384
    static SHGDN_FORPARSING := 32768
}
struct SHCONTF extends Int32 {
    static SHCONTF_CHECKING_FOR_CHILDREN := 16
    static SHCONTF_FOLDERS := 32
    static SHCONTF_NONFOLDERS := 64
    static SHCONTF_INCLUDEHIDDEN := 128
    static SHCONTF_INIT_ON_FIRST_NEXT := 256
    static SHCONTF_NETPRINTERSRCH := 512
    static SHCONTF_SHAREABLE := 1024
    static SHCONTF_STORAGE := 2048
    static SHCONTF_NAVIGATION_ENUM := 4096
    static SHCONTF_FASTITEMS := 8192
    static SHCONTF_FLATLIST := 16384
    static SHCONTF_ENABLE_ASYNC := 32768
    static SHCONTF_INCLUDESUPERHIDDEN := 65536
}
struct STORAGE_PROVIDER_FILE_FLAGS extends Int32 {
    static SPFF_NONE := 0
    static SPFF_DOWNLOAD_BY_DEFAULT := 1
    static SPFF_CREATED_ON_THIS_DEVICE := 2
}
struct MERGE_UPDATE_STATUS extends Int32 {
    static MUS_COMPLETE := 0
    static MUS_USERINPUTNEEDED := 1
    static MUS_FAILED := 2
}
struct IFileSyncMergeHandler extends IUnknown {
    static IID := "{D97B5AAC-C792-433C-975D-35C4EADC7A9D}"
    Merge(localFilePath, serverFilePath, updateStatus)
      => ComCall(3, this.p, "Str", localFilePath, "Str", serverFilePath, MERGE_UPDATE_STATUS.Ptr, updateStatus)
    ShowResolveConflictUIAsync(localFilePath, monitorToDisplayOn)
      => ComCall(4, this.p, "Str", localFilePath, HMONITOR, monitorToDisplayOn)
}
struct FOLDER_ENUM_MODE extends Int32 {
    static FEM_VIEWRESULT := 0
    static FEM_NAVIGATION := 1
}
struct IObjectWithFolderEnumMode extends IUnknown {
    static IID := "{6A9D9026-0E6E-464C-B000-42ECC07DE673}"
    SetMode(feMode)
      => ComCall(3, this.p, FOLDER_ENUM_MODE, feMode)
    GetMode(pfeMode)
      => ComCall(4, this.p, FOLDER_ENUM_MODE.Ptr, pfeMode)
}
struct IParseAndCreateItem extends IUnknown {
    static IID := "{67EFED0E-E827-4408-B493-78F3982B685C}"
    SetItem(psi)
      => ComCall(3, this.p, IShellItem, psi)
    GetItem(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IShellFolder extends IUnknown {
    static IID := "{000214E6-0000-0000-C000-000000000046}"
    ParseDisplayName(hwnd1, pbc, pszDisplayName, ppidl, pdwAttributes)
      => ComCall(3, this.p, HWND, hwnd1, IBindCtx, pbc, "Str", pszDisplayName, "Ptr", 0, ITEMIDLIST.Ptr.Ptr, ppidl, UInt32.Ptr, pdwAttributes)
    EnumObjects(hwnd1, grfFlags, ppenumIDList)
      => ComCall(4, this.p, HWND, hwnd1, UInt32, grfFlags, IEnumIDList.Ptr, ppenumIDList)
    BindToObject(pidl, pbc, riid, ppv)
      => ComCall(5, this.p, ITEMIDLIST.Ptr, pidl, IBindCtx, pbc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    BindToStorage(pidl, pbc, riid, ppv)
      => ComCall(6, this.p, ITEMIDLIST.Ptr, pidl, IBindCtx, pbc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CompareIDs(lParam1, pidl1, pidl2)
      => ComCall(7, this.p, LPARAM, lParam1, ITEMIDLIST.Ptr, pidl1, ITEMIDLIST.Ptr, pidl2)
    CreateViewObject(hwndOwner, riid, ppv)
      => ComCall(8, this.p, HWND, hwndOwner, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetAttributesOf(apidl, rgfInOut)
      => ComCall(9, this.p, UInt32, apidl.Length, ITEMIDLIST.Ptr.Ptr, apidl, UInt32.Ptr, rgfInOut)
    GetUIObjectOf(hwndOwner, apidl, riid, ppv)
      => ComCall(10, this.p, HWND, hwndOwner, UInt32, apidl.Length, ITEMIDLIST.Ptr.Ptr, apidl, GUID.Ptr, riid, "Ptr", 0, Struct.Ptr.Ptr, ppv)
    GetDisplayNameOf(pidl, uFlags, pName)
      => ComCall(11, this.p, ITEMIDLIST.Ptr, pidl, SHGDNF, uFlags, STRRET.Ptr, pName)
    SetNameOf(hwnd1?, pidl, pszName, uFlags, ppidlOut?)
      => ComCall(12, this.p, HWND, hwnd1?, ITEMIDLIST.Ptr, pidl, "Str", pszName, SHGDNF, uFlags, ITEMIDLIST.Ptr.Ptr, ppidlOut?)
}
struct EXTRASEARCH {
    guidSearch : GUID
    wszFriendlyName : UInt16[80]
    wszUrl : UInt16[2084]
}
struct IEnumExtraSearch extends IUnknown {
    static IID := "{0E700BE1-9DB6-11D1-A1CE-00C04FD75D13}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, EXTRASEARCH.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumExtraSearch.Ptr, ppenum)
}
struct IShellFolder2 extends IShellFolder {
    static IID := "{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}"
    GetDefaultSearchGUID(pguid)
      => ComCall(13, this.p, GUID.Ptr, pguid)
    EnumSearches(ppenum)
      => ComCall(14, this.p, IEnumExtraSearch.Ptr, ppenum)
    GetDefaultColumn(dwRes, pSort, pDisplay)
      => ComCall(15, this.p, UInt32, dwRes, UInt32.Ptr, pSort, UInt32.Ptr, pDisplay)
    GetDefaultColumnState(iColumn, pcsFlags)
      => ComCall(16, this.p, UInt32, iColumn, SHCOLSTATE.Ptr, pcsFlags)
    GetDetailsEx(pidl, pscid, pv)
      => ComCall(17, this.p, ITEMIDLIST.Ptr, pidl, PROPERTYKEY.Ptr, pscid, VARIANT.Ptr, pv)
    GetDetailsOf(pidl, iColumn, psd)
      => ComCall(18, this.p, ITEMIDLIST.Ptr, pidl, UInt32, iColumn, SHELLDETAILS.Ptr, psd)
    MapColumnToSCID(iColumn, pscid)
      => ComCall(19, this.p, UInt32, iColumn, PROPERTYKEY.Ptr, pscid)
}
struct FOLDERFLAGS extends Int32 {
    static FWF_NONE := 0
    static FWF_AUTOARRANGE := 1
    static FWF_ABBREVIATEDNAMES := 2
    static FWF_SNAPTOGRID := 4
    static FWF_OWNERDATA := 8
    static FWF_BESTFITWINDOW := 16
    static FWF_DESKTOP := 32
    static FWF_SINGLESEL := 64
    static FWF_NOSUBFOLDERS := 128
    static FWF_TRANSPARENT := 256
    static FWF_NOCLIENTEDGE := 512
    static FWF_NOSCROLL := 1024
    static FWF_ALIGNLEFT := 2048
    static FWF_NOICONS := 4096
    static FWF_SHOWSELALWAYS := 8192
    static FWF_NOVISIBLE := 16384
    static FWF_SINGLECLICKACTIVATE := 32768
    static FWF_NOWEBVIEW := 65536
    static FWF_HIDEFILENAMES := 131072
    static FWF_CHECKSELECT := 262144
    static FWF_NOENUMREFRESH := 524288
    static FWF_NOGROUPING := 1048576
    static FWF_FULLROWSELECT := 2097152
    static FWF_NOFILTERS := 4194304
    static FWF_NOCOLUMNHEADER := 8388608
    static FWF_NOHEADERINALLVIEWS := 16777216
    static FWF_EXTENDEDTILES := 33554432
    static FWF_TRICHECKSELECT := 67108864
    static FWF_AUTOCHECKSELECT := 134217728
    static FWF_NOBROWSERVIEWSTATE := 268435456
    static FWF_SUBSETGROUPS := 536870912
    static FWF_USESEARCHFOLDER := 1073741824
    static FWF_ALLOWRTLREADING := -2147483648
}
struct FOLDERVIEWMODE extends Int32 {
    static FVM_AUTO := -1
    static FVM_FIRST := 1
    static FVM_ICON := 1
    static FVM_SMALLICON := 2
    static FVM_LIST := 3
    static FVM_DETAILS := 4
    static FVM_THUMBNAIL := 5
    static FVM_TILE := 6
    static FVM_THUMBSTRIP := 7
    static FVM_CONTENT := 8
    static FVM_LAST := 8
}
struct FOLDERLOGICALVIEWMODE extends Int32 {
    static FLVM_UNSPECIFIED := -1
    static FLVM_FIRST := 1
    static FLVM_DETAILS := 1
    static FLVM_TILES := 2
    static FLVM_ICONS := 3
    static FLVM_LIST := 4
    static FLVM_CONTENT := 5
    static FLVM_LAST := 5
}
struct FOLDERSETTINGS {
    ViewMode : UInt32
    fFlags : UInt32
}
struct SVSIF extends Int32 {
    static SVSI_DESELECT := 0
    static SVSI_SELECT := 1
    static SVSI_EDIT := 3
    static SVSI_DESELECTOTHERS := 4
    static SVSI_ENSUREVISIBLE := 8
    static SVSI_FOCUSED := 16
    static SVSI_TRANSLATEPT := 32
    static SVSI_SELECTIONMARK := 64
    static SVSI_POSITIONITEM := 128
    static SVSI_CHECK := 256
    static SVSI_CHECK2 := 512
    static SVSI_KEYBOARDSELECT := 1025
    static SVSI_NOTAKEFOCUS := 1073741824
}
struct SVGIO extends Int32 {
    static SVGIO_BACKGROUND := 0
    static SVGIO_SELECTION := 1
    static SVGIO_ALLVIEW := 2
    static SVGIO_CHECKED := 3
    static SVGIO_TYPE_MASK := 15
    static SVGIO_FLAG_VIEWORDER := -2147483648
}
struct SVUIA_STATUS extends Int32 {
    static SVUIA_DEACTIVATE := 0
    static SVUIA_ACTIVATE_NOFOCUS := 1
    static SVUIA_ACTIVATE_FOCUS := 2
    static SVUIA_INPLACEACTIVATE := 3
}
struct IShellView extends IOleWindow {
    static IID := "{000214E3-0000-0000-C000-000000000046}"
    TranslateAccelerator(pmsg)
      => ComCall(5, this.p, MSG.Ptr, pmsg)
    EnableModeless(fEnable)
      => ComCall(6, this.p, BOOL, fEnable)
    UIActivate(uState)
      => ComCall(7, this.p, UInt32, uState)
    Refresh()
      => ComCall(8, this.p)
    CreateViewWindow(psvPrevious, pfs, psb, prcView, phWnd)
      => ComCall(9, this.p, IShellView, psvPrevious, FOLDERSETTINGS.Ptr, pfs, IShellBrowser, psb, RECT.Ptr, prcView, HWND.Ptr, phWnd)
    DestroyViewWindow()
      => ComCall(10, this.p)
    GetCurrentInfo(pfs)
      => ComCall(11, this.p, FOLDERSETTINGS.Ptr, pfs)
    AddPropertySheetPages(dwReserved, pfn, lparam1)
      => ComCall(12, this.p, UInt32, dwReserved, LPFNSVADDPROPSHEETPAGE, pfn, LPARAM, lparam1)
    SaveViewState()
      => ComCall(13, this.p)
    SelectItem(pidlItem, uFlags)
      => ComCall(14, this.p, ITEMIDLIST.Ptr, pidlItem, UInt32, uFlags)
    GetItemObject(uItem, riid, ppv)
      => ComCall(15, this.p, UInt32, uItem, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct SV2CVW2_PARAMS {
    cbSize : UInt32 := this.Size
    psvPrev : IShellView
    pfs : FOLDERSETTINGS.Ptr
    psbOwner : IShellBrowser
    prcView : RECT.Ptr
    pvid : GUID.Ptr
    hwndView : HWND
}
struct IShellView2 extends IShellView {
    static IID := "{88E39E80-3578-11CF-AE69-08002B2E1262}"
    GetView(pvid, uView)
      => ComCall(16, this.p, GUID.Ptr, pvid, UInt32, uView)
    CreateViewWindow2(lpParams)
      => ComCall(17, this.p, SV2CVW2_PARAMS.Ptr, lpParams)
    HandleRename(pidlNew)
      => ComCall(18, this.p, ITEMIDLIST.Ptr, pidlNew)
    SelectAndPositionItem(pidlItem, uFlags, ppt)
      => ComCall(19, this.p, ITEMIDLIST.Ptr, pidlItem, UInt32, uFlags, POINT.Ptr, ppt)
}
struct IFolderView extends IUnknown {
    static IID := "{CDE725B0-CCC9-4519-917E-325D72FAB4CE}"
    GetCurrentViewMode(pViewMode)
      => ComCall(3, this.p, UInt32.Ptr, pViewMode)
    SetCurrentViewMode(ViewMode)
      => ComCall(4, this.p, UInt32, ViewMode)
    GetFolder(riid, ppv)
      => ComCall(5, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Item(iItemIndex, ppidl)
      => ComCall(6, this.p, Int32, iItemIndex, ITEMIDLIST.Ptr.Ptr, ppidl)
    ItemCount(uFlags, pcItems)
      => ComCall(7, this.p, UInt32, uFlags, Int32.Ptr, pcItems)
    Items(uFlags, riid, ppv)
      => ComCall(8, this.p, UInt32, uFlags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetSelectionMarkedItem(piItem)
      => ComCall(9, this.p, Int32.Ptr, piItem)
    GetFocusedItem(piItem)
      => ComCall(10, this.p, Int32.Ptr, piItem)
    GetItemPosition(pidl, ppt)
      => ComCall(11, this.p, ITEMIDLIST.Ptr, pidl, POINT.Ptr, ppt)
    GetSpacing(ppt)
      => ComCall(12, this.p, POINT.Ptr, ppt)
    GetDefaultSpacing(ppt)
      => ComCall(13, this.p, POINT.Ptr, ppt)
    GetAutoArrange()
      => ComCall(14, this.p)
    SelectItem(iItem, dwFlags)
      => ComCall(15, this.p, Int32, iItem, UInt32, dwFlags)
    SelectAndPositionItems(apidl, apt?, dwFlags)
      => ComCall(16, this.p, UInt32, apt?.Length ?? 0, ITEMIDLIST.Ptr.Ptr, apidl, POINT.Ptr, apt?, UInt32, dwFlags)
}
struct SORTDIRECTION extends Int32 {
    static SORT_DESCENDING := -1
    static SORT_ASCENDING := 1
}
struct SORTCOLUMN {
    propkey : PROPERTYKEY
    direction : SORTDIRECTION
}
struct FVTEXTTYPE extends Int32 {
    static FVST_EMPTYTEXT := 0
}
struct IFolderView2 extends IFolderView {
    static IID := "{1AF3A467-214F-4298-908E-06B03E0B39F9}"
    SetGroupBy(key, fAscending)
      => ComCall(17, this.p, PROPERTYKEY.Ptr, key, BOOL, fAscending)
    GetGroupBy(pkey, pfAscending?)
      => ComCall(18, this.p, PROPERTYKEY.Ptr, pkey, BOOL.Ptr, pfAscending?)
    SetViewProperty(pidl, propkey, propvar)
      => ComCall(19, this.p, ITEMIDLIST.Ptr, pidl, PROPERTYKEY.Ptr, propkey, PROPVARIANT.Ptr, propvar)
    GetViewProperty(pidl, propkey, ppropvar)
      => ComCall(20, this.p, ITEMIDLIST.Ptr, pidl, PROPERTYKEY.Ptr, propkey, PROPVARIANT.Ptr, ppropvar)
    SetTileViewProperties(pidl, pszPropList)
      => ComCall(21, this.p, ITEMIDLIST.Ptr, pidl, "Str", pszPropList)
    SetExtendedTileViewProperties(pidl, pszPropList)
      => ComCall(22, this.p, ITEMIDLIST.Ptr, pidl, "Str", pszPropList)
    SetText(iType, pwszText)
      => ComCall(23, this.p, FVTEXTTYPE, iType, "Str", pwszText)
    SetCurrentFolderFlags(dwMask, dwFlags)
      => ComCall(24, this.p, UInt32, dwMask, UInt32, dwFlags)
    GetCurrentFolderFlags(pdwFlags)
      => ComCall(25, this.p, UInt32.Ptr, pdwFlags)
    GetSortColumnCount(pcColumns)
      => ComCall(26, this.p, Int32.Ptr, pcColumns)
    SetSortColumns(rgSortColumns)
      => ComCall(27, this.p, SORTCOLUMN.Ptr, rgSortColumns, Int32, rgSortColumns.Length)
    GetSortColumns(rgSortColumns)
      => ComCall(28, this.p, SORTCOLUMN.Ptr, rgSortColumns, Int32, rgSortColumns.Length)
    GetItem(iItem, riid, ppv)
      => ComCall(29, this.p, Int32, iItem, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetVisibleItem(iStart, fPrevious, piItem)
      => ComCall(30, this.p, Int32, iStart, BOOL, fPrevious, Int32.Ptr, piItem)
    GetSelectedItem(iStart, piItem)
      => ComCall(31, this.p, Int32, iStart, Int32.Ptr, piItem)
    GetSelection(fNoneImpliesFolder, ppsia)
      => ComCall(32, this.p, BOOL, fNoneImpliesFolder, IShellItemArray.Ptr, ppsia)
    GetSelectionState(pidl, pdwFlags)
      => ComCall(33, this.p, ITEMIDLIST.Ptr, pidl, UInt32.Ptr, pdwFlags)
    InvokeVerbOnSelection(pszVerb)
      => ComCall(34, this.p, PSTR, pszVerb)
    SetViewModeAndIconSize(uViewMode, iImageSize)
      => ComCall(35, this.p, FOLDERVIEWMODE, uViewMode, Int32, iImageSize)
    GetViewModeAndIconSize(puViewMode, piImageSize)
      => ComCall(36, this.p, FOLDERVIEWMODE.Ptr, puViewMode, Int32.Ptr, piImageSize)
    SetGroupSubsetCount(cVisibleRows)
      => ComCall(37, this.p, UInt32, cVisibleRows)
    GetGroupSubsetCount(pcVisibleRows)
      => ComCall(38, this.p, UInt32.Ptr, pcVisibleRows)
    SetRedraw(fRedrawOn)
      => ComCall(39, this.p, BOOL, fRedrawOn)
    IsMoveInSameFolder()
      => ComCall(40, this.p)
    DoRename()
      => ComCall(41, this.p)
}
struct IFolderViewSettings extends IUnknown {
    static IID := "{AE8C987D-8797-4ED3-BE72-2A47DD938DB0}"
    GetColumnPropertyList(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetGroupByProperty(pkey, pfGroupAscending)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, pkey, BOOL.Ptr, pfGroupAscending)
    GetViewMode(plvm)
      => ComCall(5, this.p, FOLDERLOGICALVIEWMODE.Ptr, plvm)
    GetIconSize(puIconSize)
      => ComCall(6, this.p, UInt32.Ptr, puIconSize)
    GetFolderFlags(pfolderMask, pfolderFlags)
      => ComCall(7, this.p, FOLDERFLAGS.Ptr, pfolderMask, FOLDERFLAGS.Ptr, pfolderFlags)
    GetSortColumns(rgSortColumns, pcColumnsOut)
      => ComCall(8, this.p, SORTCOLUMN.Ptr, rgSortColumns, UInt32, rgSortColumns.Length, UInt32.Ptr, pcColumnsOut)
    GetGroupSubsetCount(pcVisibleRows)
      => ComCall(9, this.p, UInt32.Ptr, pcVisibleRows)
}
struct IInitializeNetworkFolder extends IUnknown {
    static IID := "{6E0F9881-42A8-4F2A-97F8-8AF4E026D92D}"
    Initialize(pidl, pidlTarget, uDisplayType, pszResName, pszProvider)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidl, ITEMIDLIST.Ptr, pidlTarget, UInt32, uDisplayType, "Str", pszResName, "Str", pszProvider)
}
struct INetworkFolderInternal extends IUnknown {
    static IID := "{CEB38218-C971-47BB-A703-F0BC99CCDB81}"
    GetResourceDisplayType(displayType)
      => ComCall(3, this.p, UInt32.Ptr, displayType)
    GetIDList(idList)
      => ComCall(4, this.p, ITEMIDLIST.Ptr.Ptr, idList)
    GetProvider(itemIds, provider)
      => ComCall(5, this.p, UInt32, itemIds.Length, ITEMIDLIST.Ptr.Ptr, itemIds, UInt32, provider.Length, PWSTR, provider)
}
struct IPreviewHandlerVisuals extends IUnknown {
    static IID := "{196BF9A5-B346-4EF0-AA1E-5DCDB76768B1}"
    SetBackgroundColor(color)
      => ComCall(3, this.p, COLORREF, color)
    SetFont(plf)
      => ComCall(4, this.p, LOGFONTW.Ptr, plf)
    SetTextColor(color)
      => ComCall(5, this.p, COLORREF, color)
}
struct ICommDlgBrowser extends IUnknown {
    static IID := "{000214F1-0000-0000-C000-000000000046}"
    OnDefaultCommand(ppshv)
      => ComCall(3, this.p, IShellView, ppshv)
    OnStateChange(ppshv, uChange)
      => ComCall(4, this.p, IShellView, ppshv, UInt32, uChange)
    IncludeObject(ppshv, pidl)
      => ComCall(5, this.p, IShellView, ppshv, ITEMIDLIST.Ptr, pidl)
}
struct ICommDlgBrowser2 extends ICommDlgBrowser {
    static IID := "{10339516-2894-11D2-9039-00C04F8EEB3E}"
    Notify(ppshv, dwNotifyType)
      => ComCall(6, this.p, IShellView, ppshv, UInt32, dwNotifyType)
    GetDefaultMenuText(ppshv, pszText)
      => ComCall(7, this.p, IShellView, ppshv, PWSTR, pszText, Int32, pszText.Length)
    GetViewFlags(pdwFlags)
      => ComCall(8, this.p, UInt32.Ptr, pdwFlags)
}
struct CM_MASK extends Int32 {
    static CM_MASK_WIDTH := 1
    static CM_MASK_DEFAULTWIDTH := 2
    static CM_MASK_IDEALWIDTH := 4
    static CM_MASK_NAME := 8
    static CM_MASK_STATE := 16
}
struct CM_STATE extends Int32 {
    static CM_STATE_NONE := 0
    static CM_STATE_VISIBLE := 1
    static CM_STATE_FIXEDWIDTH := 2
    static CM_STATE_NOSORTBYFOLDERNESS := 4
    static CM_STATE_ALWAYSVISIBLE := 8
}
struct CM_ENUM_FLAGS extends Int32 {
    static CM_ENUM_ALL := 1
    static CM_ENUM_VISIBLE := 2
}
struct CM_SET_WIDTH_VALUE extends Int32 {
    static CM_WIDTH_USEDEFAULT := -1
    static CM_WIDTH_AUTOSIZE := -2
}
struct CM_COLUMNINFO {
    cbSize : UInt32 := this.Size
    dwMask : UInt32
    dwState : UInt32
    uWidth : UInt32
    uDefaultWidth : UInt32
    uIdealWidth : UInt32
    wszName : UInt16[80]
}
struct IColumnManager extends IUnknown {
    static IID := "{D8EC27BB-3F3B-4042-B10A-4ACFD924D453}"
    SetColumnInfo(propkey, pcmci)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, propkey, CM_COLUMNINFO.Ptr, pcmci)
    GetColumnInfo(propkey, pcmci)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, propkey, CM_COLUMNINFO.Ptr, pcmci)
    GetColumnCount(dwFlags, puCount)
      => ComCall(5, this.p, CM_ENUM_FLAGS, dwFlags, UInt32.Ptr, puCount)
    GetColumns(dwFlags, rgkeyOrder)
      => ComCall(6, this.p, CM_ENUM_FLAGS, dwFlags, PROPERTYKEY.Ptr, rgkeyOrder, UInt32, rgkeyOrder.Length)
    SetColumns(rgkeyOrder)
      => ComCall(7, this.p, PROPERTYKEY.Ptr, rgkeyOrder, UInt32, rgkeyOrder.Length)
}
struct IFolderFilterSite extends IUnknown {
    static IID := "{C0A651F5-B48B-11D2-B5ED-006097C686F6}"
    SetFilter(punk)
      => ComCall(3, this.p, IUnknown, punk)
}
struct IFolderFilter extends IUnknown {
    static IID := "{9CC22886-DC8E-11D2-B1D0-00C04F8EEB3E}"
    ShouldShow(psf, pidlFolder, pidlItem)
      => ComCall(3, this.p, IShellFolder, psf, ITEMIDLIST.Ptr, pidlFolder, ITEMIDLIST.Ptr, pidlItem)
    GetEnumFlags(psf, pidlFolder, phwnd, pgrfFlags)
      => ComCall(4, this.p, IShellFolder, psf, ITEMIDLIST.Ptr, pidlFolder, HWND.Ptr, phwnd, UInt32.Ptr, pgrfFlags)
}
struct IInputObjectSite extends IUnknown {
    static IID := "{F1DB8392-7331-11D0-8C99-00A0C92DBFE8}"
    OnFocusChangeIS(punkObj, fSetFocus)
      => ComCall(3, this.p, IUnknown, punkObj, BOOL, fSetFocus)
}
struct IInputObject extends IUnknown {
    static IID := "{68284FAA-6A48-11D0-8C78-00C04FD918B4}"
    UIActivateIO(fActivate, pMsg)
      => ComCall(3, this.p, BOOL, fActivate, MSG.Ptr, pMsg)
    HasFocusIO()
      => ComCall(4, this.p)
    TranslateAcceleratorIO(pMsg)
      => ComCall(5, this.p, MSG.Ptr, pMsg)
}
struct IInputObject2 extends IInputObject {
    static IID := "{6915C085-510B-44CD-94AF-28DFA56CF92B}"
    TranslateAcceleratorGlobal(pMsg)
      => ComCall(6, this.p, MSG.Ptr, pMsg)
}
struct IShellIcon extends IUnknown {
    static IID := "{000214E5-0000-0000-C000-000000000046}"
    GetIconOf(pidl, flags, pIconIndex)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidl, UInt32, flags, Int32.Ptr, pIconIndex)
}
struct IShellBrowser extends IOleWindow {
    static IID := "{000214E2-0000-0000-C000-000000000046}"
    InsertMenusSB(hmenuShared, lpMenuWidths)
      => ComCall(5, this.p, HMENU, hmenuShared, OLEMENUGROUPWIDTHS.Ptr, lpMenuWidths)
    SetMenuSB(hmenuShared, holemenuRes, hwndActiveObject)
      => ComCall(6, this.p, HMENU, hmenuShared, IntPtr, holemenuRes, HWND, hwndActiveObject)
    RemoveMenusSB(hmenuShared)
      => ComCall(7, this.p, HMENU, hmenuShared)
    SetStatusTextSB(pszStatusText)
      => ComCall(8, this.p, "Str", pszStatusText)
    EnableModelessSB(fEnable)
      => ComCall(9, this.p, BOOL, fEnable)
    TranslateAcceleratorSB(pmsg, wID)
      => ComCall(10, this.p, MSG.Ptr, pmsg, UInt16, wID)
    BrowseObject(pidl, wFlags)
      => ComCall(11, this.p, ITEMIDLIST.Ptr, pidl, UInt32, wFlags)
    GetViewStateStream(grfMode, ppStrm)
      => ComCall(12, this.p, UInt32, grfMode, IStream.Ptr, ppStrm)
    GetControlWindow(id, phwnd)
      => ComCall(13, this.p, UInt32, id, HWND.Ptr, phwnd)
    SendControlMsg(id, uMsg, wParam1, lParam1, pret?)
      => ComCall(14, this.p, UInt32, id, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, pret?)
    QueryActiveShellView(ppshv)
      => ComCall(15, this.p, IShellView.Ptr, ppshv)
    OnViewWindowActive(pshv)
      => ComCall(16, this.p, IShellView, pshv)
    SetToolbarItems(lpButtons?, uFlags)
      => ComCall(17, this.p, TBBUTTON.Ptr, lpButtons?, UInt32, lpButtons?.Length ?? 0, UInt32, uFlags)
}
struct IProfferService extends IUnknown {
    static IID := "{CB728B20-F786-11CE-92AD-00AA00A74CD0}"
    ProfferService(serviceId, serviceProvider, cookie)
      => ComCall(3, this.p, GUID.Ptr, serviceId, IServiceProvider, serviceProvider, UInt32.Ptr, cookie)
    RevokeService(cookie)
      => ComCall(4, this.p, UInt32, cookie)
}
struct IGetServiceIds extends IUnknown {
    static IID := "{4A073526-6103-4E21-B7BC-F519D1524E5D}"
    GetServiceIds(serviceIds)
      => ComCall(3, this.p, UInt32.Ptr, serviceIds.Length, GUID.Ptr.Ptr, serviceIds)
}
struct SIGDN extends Int32 {
    static SIGDN_NORMALDISPLAY := 0
    static SIGDN_PARENTRELATIVEPARSING := -2147385343
    static SIGDN_DESKTOPABSOLUTEPARSING := -2147319808
    static SIGDN_PARENTRELATIVEEDITING := -2147282943
    static SIGDN_DESKTOPABSOLUTEEDITING := -2147172352
    static SIGDN_FILESYSPATH := -2147123200
    static SIGDN_URL := -2147057664
    static SIGDN_PARENTRELATIVEFORADDRESSBAR := -2146975743
    static SIGDN_PARENTRELATIVE := -2146959359
    static SIGDN_PARENTRELATIVEFORUI := -2146877439
}
struct SICHINTF extends Int32 {
    static SICHINT_DISPLAY := 0
    static SICHINT_ALLFIELDS := -2147483648
    static SICHINT_CANONICAL := 268435456
    static SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL := 536870912
}
struct IShellItem extends IUnknown {
    static IID := "{43826D1E-E718-42EE-BC55-A1E261C37BFE}"
    BindToHandler(pbc, bhid, riid, ppv)
      => ComCall(3, this.p, IBindCtx, pbc, GUID.Ptr, bhid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetParent(ppsi)
      => ComCall(4, this.p, IShellItem.Ptr, ppsi)
    GetDisplayName(sigdnName, ppszName)
      => ComCall(5, this.p, SIGDN, sigdnName, PWSTR.Ptr, ppszName)
    GetAttributes(sfgaoMask, psfgaoAttribs)
      => ComCall(6, this.p, SFGAO_FLAGS, sfgaoMask, SFGAO_FLAGS.Ptr, psfgaoAttribs)
    Compare(psi, hint, piOrder)
      => ComCall(7, this.p, IShellItem, psi, UInt32, hint, Int32.Ptr, piOrder)
}
struct DATAOBJ_GET_ITEM_FLAGS extends Int32 {
    static DOGIF_DEFAULT := 0
    static DOGIF_TRAVERSE_LINK := 1
    static DOGIF_NO_HDROP := 2
    static DOGIF_NO_URL := 4
    static DOGIF_ONLY_IF_ONE := 8
}
struct IShellItem2 extends IShellItem {
    static IID := "{7E9FB0D3-919F-4307-AB2E-9B1860310C93}"
    GetPropertyStore(flags, riid, ppv)
      => ComCall(8, this.p, GETPROPERTYSTOREFLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyStoreWithCreateObject(flags, punkCreateObject, riid, ppv)
      => ComCall(9, this.p, GETPROPERTYSTOREFLAGS, flags, IUnknown, punkCreateObject, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyStoreForKeys(rgKeys, flags, riid, ppv)
      => ComCall(10, this.p, PROPERTYKEY.Ptr, rgKeys, UInt32, rgKeys.Length, GETPROPERTYSTOREFLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyDescriptionList(keyType, riid, ppv)
      => ComCall(11, this.p, PROPERTYKEY.Ptr, keyType, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Update(pbc)
      => ComCall(12, this.p, IBindCtx, pbc)
    GetProperty(key, ppropvar)
      => ComCall(13, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, ppropvar)
    GetCLSID(key, pclsid)
      => ComCall(14, this.p, PROPERTYKEY.Ptr, key, GUID.Ptr, pclsid)
    GetFileTime(key, pft)
      => ComCall(15, this.p, PROPERTYKEY.Ptr, key, FILETIME.Ptr, pft)
    GetInt32(key, pi)
      => ComCall(16, this.p, PROPERTYKEY.Ptr, key, Int32.Ptr, pi)
    GetString(key, ppsz)
      => ComCall(17, this.p, PROPERTYKEY.Ptr, key, PWSTR.Ptr, ppsz)
    GetUInt32(key, pui)
      => ComCall(18, this.p, PROPERTYKEY.Ptr, key, UInt32.Ptr, pui)
    GetUInt64(key, pull)
      => ComCall(19, this.p, PROPERTYKEY.Ptr, key, Int64.Ptr, pull)
    GetBool(key, pf)
      => ComCall(20, this.p, PROPERTYKEY.Ptr, key, BOOL.Ptr, pf)
}
struct SIIGBF extends Int32 {
    static SIIGBF_RESIZETOFIT := 0
    static SIIGBF_BIGGERSIZEOK := 1
    static SIIGBF_MEMORYONLY := 2
    static SIIGBF_ICONONLY := 4
    static SIIGBF_THUMBNAILONLY := 8
    static SIIGBF_INCACHEONLY := 16
    static SIIGBF_CROPTOSQUARE := 32
    static SIIGBF_WIDETHUMBNAILS := 64
    static SIIGBF_ICONBACKGROUND := 128
    static SIIGBF_SCALEUP := 256
}
struct IShellItemImageFactory extends IUnknown {
    static IID := "{BCC18B79-BA16-442F-80C4-8A59C30C463B}"
    GetImage(size1, flags, phbm)
      => ComCall(3, this.p, SIZE, size1, SIIGBF, flags, HBITMAP.Ptr, phbm)
}
struct IEnumShellItems extends IUnknown {
    static IID := "{70629033-E363-4A28-A567-0DB78006E6D7}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, IShellItem.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumShellItems.Ptr, ppenum)
}
struct STGOP extends Int32 {
    static STGOP_MOVE := 1
    static STGOP_COPY := 2
    static STGOP_SYNC := 3
    static STGOP_REMOVE := 5
    static STGOP_RENAME := 6
    static STGOP_APPLYPROPERTIES := 8
    static STGOP_NEW := 10
}
struct TRANSFER_SOURCE_FLAGS extends Int32 {
    static TSF_NORMAL := 0
    static TSF_FAIL_EXIST := 0
    static TSF_RENAME_EXIST := 1
    static TSF_OVERWRITE_EXIST := 2
    static TSF_ALLOW_DECRYPTION := 4
    static TSF_NO_SECURITY := 8
    static TSF_COPY_CREATION_TIME := 16
    static TSF_COPY_WRITE_TIME := 32
    static TSF_USE_FULL_ACCESS := 64
    static TSF_DELETE_RECYCLE_IF_POSSIBLE := 128
    static TSF_COPY_HARD_LINK := 256
    static TSF_COPY_LOCALIZED_NAME := 512
    static TSF_MOVE_AS_COPY_DELETE := 1024
    static TSF_SUSPEND_SHELLEVENTS := 2048
}
struct TRANSFER_ADVISE_STATE extends Int32 {
    static TS_NONE := 0
    static TS_PERFORMING := 1
    static TS_PREPARING := 2
    static TS_INDETERMINATE := 4
}
struct ITransferAdviseSink extends IUnknown {
    static IID := "{D594D0D8-8DA7-457B-B3B4-CE5DBAAC0B88}"
    UpdateProgress(ullSizeCurrent, ullSizeTotal, nFilesCurrent, nFilesTotal, nFoldersCurrent, nFoldersTotal)
      => ComCall(3, this.p, Int64, ullSizeCurrent, Int64, ullSizeTotal, Int32, nFilesCurrent, Int32, nFilesTotal, Int32, nFoldersCurrent, Int32, nFoldersTotal)
    UpdateTransferState(ts)
      => ComCall(4, this.p, UInt32, ts)
    ConfirmOverwrite(psiSource, psiDestParent, pszName)
      => ComCall(5, this.p, IShellItem, psiSource, IShellItem, psiDestParent, "Str", pszName)
    ConfirmEncryptionLoss(psiSource)
      => ComCall(6, this.p, IShellItem, psiSource)
    FileFailure(psi, pszItem, hrError, pszRename)
      => ComCall(7, this.p, IShellItem, psi, "Str", pszItem, HRESULT, hrError, PWSTR, pszRename, UInt32, pszRename.Length)
    SubStreamFailure(psi, pszStreamName, hrError)
      => ComCall(8, this.p, IShellItem, psi, "Str", pszStreamName, HRESULT, hrError)
    PropertyFailure(psi, pkey, hrError)
      => ComCall(9, this.p, IShellItem, psi, PROPERTYKEY.Ptr, pkey, HRESULT, hrError)
}
struct ITransferSource extends IUnknown {
    static IID := "{00ADB003-BDE9-45C6-8E29-D09F9353E108}"
    Advise(psink, pdwCookie)
      => ComCall(3, this.p, ITransferAdviseSink, psink, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    SetProperties(pproparray)
      => ComCall(5, this.p, IPropertyChangeArray, pproparray)
    OpenItem(psi, flags, riid, ppv)
      => ComCall(6, this.p, IShellItem, psi, UInt32, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    MoveItem(psi, psiParentDst, pszNameDst, flags, ppsiNew)
      => ComCall(7, this.p, IShellItem, psi, IShellItem, psiParentDst, "Str", pszNameDst, UInt32, flags, IShellItem.Ptr, ppsiNew)
    RecycleItem(psiSource, psiParentDest, flags, ppsiNewDest)
      => ComCall(8, this.p, IShellItem, psiSource, IShellItem, psiParentDest, UInt32, flags, IShellItem.Ptr, ppsiNewDest)
    RemoveItem(psiSource, flags)
      => ComCall(9, this.p, IShellItem, psiSource, UInt32, flags)
    RenameItem(psiSource, pszNewName, flags, ppsiNewDest)
      => ComCall(10, this.p, IShellItem, psiSource, "Str", pszNewName, UInt32, flags, IShellItem.Ptr, ppsiNewDest)
    LinkItem(psiSource, psiParentDest, pszNewName?, flags, ppsiNewDest)
      => ComCall(11, this.p, IShellItem, psiSource, IShellItem, psiParentDest, "Str", pszNewName?, UInt32, flags, IShellItem.Ptr, ppsiNewDest)
    ApplyPropertiesToItem(psiSource, ppsiNew)
      => ComCall(12, this.p, IShellItem, psiSource, IShellItem.Ptr, ppsiNew)
    GetDefaultDestinationName(psiSource, psiParentDest, ppszDestinationName)
      => ComCall(13, this.p, IShellItem, psiSource, IShellItem, psiParentDest, PWSTR.Ptr, ppszDestinationName)
    EnterFolder(psiChildFolderDest)
      => ComCall(14, this.p, IShellItem, psiChildFolderDest)
    LeaveFolder(psiChildFolderDest)
      => ComCall(15, this.p, IShellItem, psiChildFolderDest)
}
struct SHELL_ITEM_RESOURCE {
    guidType : GUID
    szName : UInt16[260]
}
struct IEnumResources extends IUnknown {
    static IID := "{2DD81FE3-A83C-4DA9-A330-47249D345BA1}"
    Next(psir, pceltFetched)
      => ComCall(3, this.p, UInt32, psir.Length, SHELL_ITEM_RESOURCE.Ptr, psir, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenumr)
      => ComCall(6, this.p, IEnumResources.Ptr, ppenumr)
}
struct IShellItemResources extends IUnknown {
    static IID := "{FF5693BE-2CE0-4D48-B5C5-40817D1ACDB9}"
    GetAttributes(pdwAttributes)
      => ComCall(3, this.p, UInt32.Ptr, pdwAttributes)
    GetSize(pullSize)
      => ComCall(4, this.p, Int64.Ptr, pullSize)
    GetTimes(pftCreation, pftWrite, pftAccess)
      => ComCall(5, this.p, FILETIME.Ptr, pftCreation, FILETIME.Ptr, pftWrite, FILETIME.Ptr, pftAccess)
    SetTimes(pftCreation, pftWrite, pftAccess)
      => ComCall(6, this.p, FILETIME.Ptr, pftCreation, FILETIME.Ptr, pftWrite, FILETIME.Ptr, pftAccess)
    GetResourceDescription(pcsir, ppszDescription)
      => ComCall(7, this.p, SHELL_ITEM_RESOURCE.Ptr, pcsir, PWSTR.Ptr, ppszDescription)
    EnumResources(ppenumr)
      => ComCall(8, this.p, IEnumResources.Ptr, ppenumr)
    SupportsResource(pcsir)
      => ComCall(9, this.p, SHELL_ITEM_RESOURCE.Ptr, pcsir)
    OpenResource(pcsir, riid, ppv)
      => ComCall(10, this.p, SHELL_ITEM_RESOURCE.Ptr, pcsir, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateResource(pcsir, riid, ppv)
      => ComCall(11, this.p, SHELL_ITEM_RESOURCE.Ptr, pcsir, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    MarkForDelete()
      => ComCall(12, this.p)
}
struct ITransferDestination extends IUnknown {
    static IID := "{48ADDD32-3CA5-4124-ABE3-B5A72531B207}"
    Advise(psink, pdwCookie)
      => ComCall(3, this.p, ITransferAdviseSink, psink, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    CreateItem(pszName, dwAttributes, ullSize, flags, riidItem, ppvItem, riidResources, ppvResources)
      => ComCall(5, this.p, "Str", pszName, UInt32, dwAttributes, Int64, ullSize, UInt32, flags, GUID.Ptr, riidItem, Struct.Ptr.Ptr, ppvItem, GUID.Ptr, riidResources, Struct.Ptr.Ptr, ppvResources)
}
struct IFileOperationProgressSink extends IUnknown {
    static IID := "{04B0F1A7-9490-44BC-96E1-4296A31252E2}"
    StartOperations()
      => ComCall(3, this.p)
    FinishOperations(hrResult)
      => ComCall(4, this.p, HRESULT, hrResult)
    PreRenameItem(dwFlags, psiItem, pszNewName)
      => ComCall(5, this.p, UInt32, dwFlags, IShellItem, psiItem, "Str", pszNewName)
    PostRenameItem(dwFlags, psiItem, pszNewName, hrRename, psiNewlyCreated)
      => ComCall(6, this.p, UInt32, dwFlags, IShellItem, psiItem, "Str", pszNewName, HRESULT, hrRename, IShellItem, psiNewlyCreated)
    PreMoveItem(dwFlags, psiItem, psiDestinationFolder, pszNewName)
      => ComCall(7, this.p, UInt32, dwFlags, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszNewName)
    PostMoveItem(dwFlags, psiItem, psiDestinationFolder, pszNewName, hrMove, psiNewlyCreated)
      => ComCall(8, this.p, UInt32, dwFlags, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszNewName, HRESULT, hrMove, IShellItem, psiNewlyCreated)
    PreCopyItem(dwFlags, psiItem, psiDestinationFolder, pszNewName)
      => ComCall(9, this.p, UInt32, dwFlags, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszNewName)
    PostCopyItem(dwFlags, psiItem, psiDestinationFolder, pszNewName, hrCopy, psiNewlyCreated)
      => ComCall(10, this.p, UInt32, dwFlags, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszNewName, HRESULT, hrCopy, IShellItem, psiNewlyCreated)
    PreDeleteItem(dwFlags, psiItem)
      => ComCall(11, this.p, UInt32, dwFlags, IShellItem, psiItem)
    PostDeleteItem(dwFlags, psiItem, hrDelete, psiNewlyCreated)
      => ComCall(12, this.p, UInt32, dwFlags, IShellItem, psiItem, HRESULT, hrDelete, IShellItem, psiNewlyCreated)
    PreNewItem(dwFlags, psiDestinationFolder, pszNewName)
      => ComCall(13, this.p, UInt32, dwFlags, IShellItem, psiDestinationFolder, "Str", pszNewName)
    PostNewItem(dwFlags, psiDestinationFolder, pszNewName, pszTemplateName, dwFileAttributes, hrNew, psiNewItem)
      => ComCall(14, this.p, UInt32, dwFlags, IShellItem, psiDestinationFolder, "Str", pszNewName, "Str", pszTemplateName, UInt32, dwFileAttributes, HRESULT, hrNew, IShellItem, psiNewItem)
    UpdateProgress(iWorkTotal, iWorkSoFar)
      => ComCall(15, this.p, UInt32, iWorkTotal, UInt32, iWorkSoFar)
    ResetTimer()
      => ComCall(16, this.p)
    PauseTimer()
      => ComCall(17, this.p)
    ResumeTimer()
      => ComCall(18, this.p)
}
struct SIATTRIBFLAGS extends Int32 {
    static SIATTRIBFLAGS_AND := 1
    static SIATTRIBFLAGS_OR := 2
    static SIATTRIBFLAGS_APPCOMPAT := 3
    static SIATTRIBFLAGS_MASK := 3
    static SIATTRIBFLAGS_ALLITEMS := 16384
}
struct IShellItemArray extends IUnknown {
    static IID := "{B63EA76D-1F85-456F-A19C-48159EFA858B}"
    BindToHandler(pbc, bhid, riid, ppvOut)
      => ComCall(3, this.p, IBindCtx, pbc, GUID.Ptr, bhid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvOut)
    GetPropertyStore(flags, riid, ppv)
      => ComCall(4, this.p, GETPROPERTYSTOREFLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyDescriptionList(keyType, riid, ppv)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, keyType, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetAttributes(AttribFlags, sfgaoMask, psfgaoAttribs)
      => ComCall(6, this.p, SIATTRIBFLAGS, AttribFlags, SFGAO_FLAGS, sfgaoMask, SFGAO_FLAGS.Ptr, psfgaoAttribs)
    GetCount(pdwNumItems)
      => ComCall(7, this.p, UInt32.Ptr, pdwNumItems)
    GetItemAt(dwIndex, ppsi)
      => ComCall(8, this.p, UInt32, dwIndex, IShellItem.Ptr, ppsi)
    EnumItems(ppenumShellItems)
      => ComCall(9, this.p, IEnumShellItems.Ptr, ppenumShellItems)
}
struct IInitializeWithItem extends IUnknown {
    static IID := "{7F73BE3F-FB79-493C-A6C7-7EE14E245841}"
    Initialize(psi, grfMode)
      => ComCall(3, this.p, IShellItem, psi, UInt32, grfMode)
}
struct IObjectWithSelection extends IUnknown {
    static IID := "{1C9CD5BB-98E9-4491-A60F-31AACC72B83C}"
    SetSelection(psia)
      => ComCall(3, this.p, IShellItemArray, psia)
    GetSelection(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IObjectWithBackReferences extends IUnknown {
    static IID := "{321A6A6A-D61F-4BF3-97AE-14BE2986BB36}"
    RemoveBackReferences()
      => ComCall(3, this.p)
}
struct ICategoryProvider extends IUnknown {
    static IID := "{9AF64809-5864-4C26-A720-C1F78C086EE3}"
    CanCategorizeOnSCID(pscid)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, pscid)
    GetDefaultCategory(pguid, pscid)
      => ComCall(4, this.p, GUID.Ptr, pguid, PROPERTYKEY.Ptr, pscid)
    GetCategoryForSCID(pscid, pguid)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, pscid, GUID.Ptr, pguid)
    EnumCategories(penum)
      => ComCall(6, this.p, IEnumGUID.Ptr, penum)
    GetCategoryName(pguid, pszName)
      => ComCall(7, this.p, GUID.Ptr, pguid, PWSTR, pszName, UInt32, pszName.Length)
    CreateCategory(pguid, riid, ppv)
      => ComCall(8, this.p, GUID.Ptr, pguid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct CATEGORYINFO_FLAGS extends Int32 {
    static CATINFO_NORMAL := 0
    static CATINFO_COLLAPSED := 1
    static CATINFO_HIDDEN := 2
    static CATINFO_EXPANDED := 4
    static CATINFO_NOHEADER := 8
    static CATINFO_NOTCOLLAPSIBLE := 16
    static CATINFO_NOHEADERCOUNT := 32
    static CATINFO_SUBSETTED := 64
    static CATINFO_SEPARATE_IMAGES := 128
    static CATINFO_SHOWEMPTY := 256
}
struct CATSORT_FLAGS extends Int32 {
    static CATSORT_DEFAULT := 0
    static CATSORT_NAME := 1
}
struct CATEGORY_INFO {
    cif : CATEGORYINFO_FLAGS
    wszName : UInt16[260]
}
struct ICategorizer extends IUnknown {
    static IID := "{A3B14589-9174-49A8-89A3-06A1AE2B9BA7}"
    GetDescription(pszDesc)
      => ComCall(3, this.p, PWSTR, pszDesc, UInt32, pszDesc.Length)
    GetCategory(apidl, rgCategoryIds)
      => ComCall(4, this.p, UInt32, rgCategoryIds.Length, ITEMIDLIST.Ptr.Ptr, apidl, UInt32.Ptr, rgCategoryIds)
    GetCategoryInfo(dwCategoryId, pci)
      => ComCall(5, this.p, UInt32, dwCategoryId, CATEGORY_INFO.Ptr, pci)
    CompareCategory(csfFlags, dwCategoryId1, dwCategoryId2)
      => ComCall(6, this.p, CATSORT_FLAGS, csfFlags, UInt32, dwCategoryId1, UInt32, dwCategoryId2)
}
struct SHDRAGIMAGE {
    sizeDragImage : SIZE
    ptOffset : POINT
    hbmpDragImage : HBITMAP
    crColorKey : COLORREF
}
struct IDropTargetHelper extends IUnknown {
    static IID := "{4657278B-411B-11D2-839A-00C04FD918D0}"
    DragEnter(hwndTarget, pDataObject, ppt, dwEffect)
      => ComCall(3, this.p, HWND, hwndTarget, IDataObject, pDataObject, POINT.Ptr, ppt, DROPEFFECT, dwEffect)
    DragLeave()
      => ComCall(4, this.p)
    DragOver(ppt, dwEffect)
      => ComCall(5, this.p, POINT.Ptr, ppt, DROPEFFECT, dwEffect)
    Drop(pDataObject, ppt, dwEffect)
      => ComCall(6, this.p, IDataObject, pDataObject, POINT.Ptr, ppt, DROPEFFECT, dwEffect)
    Show(fShow)
      => ComCall(7, this.p, BOOL, fShow)
}
struct IDragSourceHelper extends IUnknown {
    static IID := "{DE5BF786-477A-11D2-839D-00C04FD918D0}"
    InitializeFromBitmap(pshdi, pDataObject)
      => ComCall(3, this.p, SHDRAGIMAGE.Ptr, pshdi, IDataObject, pDataObject)
    InitializeFromWindow(hwnd1?, ppt?, pDataObject)
      => ComCall(4, this.p, HWND, hwnd1?, POINT.Ptr, ppt?, IDataObject, pDataObject)
}
struct SLR_FLAGS extends Int32 {
    static SLR_NONE := 0
    static SLR_NO_UI := 1
    static SLR_ANY_MATCH := 2
    static SLR_UPDATE := 4
    static SLR_NOUPDATE := 8
    static SLR_NOSEARCH := 16
    static SLR_NOTRACK := 32
    static SLR_NOLINKINFO := 64
    static SLR_INVOKE_MSI := 128
    static SLR_NO_UI_WITH_MSG_PUMP := 257
    static SLR_OFFER_DELETE_WITHOUT_FILE := 512
    static SLR_KNOWNFOLDER := 1024
    static SLR_MACHINE_IN_LOCAL_TARGET := 2048
    static SLR_UPDATE_MACHINE_AND_SID := 4096
    static SLR_NO_OBJECT_ID := 8192
}
struct SLGP_FLAGS extends Int32 {
    static SLGP_SHORTPATH := 1
    static SLGP_UNCPRIORITY := 2
    static SLGP_RAWPATH := 4
    static SLGP_RELATIVEPRIORITY := 8
}
struct IShellLinkA extends IUnknown {
    static IID := "{000214EE-0000-0000-C000-000000000046}"
    GetPath(pszFile, pfd, fFlags)
      => ComCall(3, this.p, PSTR, pszFile, Int32, pszFile.Length, WIN32_FIND_DATAA.Ptr, pfd, UInt32, fFlags)
    GetIDList(ppidl)
      => ComCall(4, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
    SetIDList(pidl)
      => ComCall(5, this.p, ITEMIDLIST.Ptr, pidl)
    GetDescription(pszName)
      => ComCall(6, this.p, PSTR, pszName, Int32, pszName.Length)
    SetDescription(pszName)
      => ComCall(7, this.p, PSTR, pszName)
    GetWorkingDirectory(pszDir)
      => ComCall(8, this.p, PSTR, pszDir, Int32, pszDir.Length)
    SetWorkingDirectory(pszDir)
      => ComCall(9, this.p, PSTR, pszDir)
    GetArguments(pszArgs)
      => ComCall(10, this.p, PSTR, pszArgs, Int32, pszArgs.Length)
    SetArguments(pszArgs)
      => ComCall(11, this.p, PSTR, pszArgs)
    GetHotkey(pwHotkey)
      => ComCall(12, this.p, UInt16.Ptr, pwHotkey)
    SetHotkey(wHotkey)
      => ComCall(13, this.p, UInt16, wHotkey)
    GetShowCmd(piShowCmd)
      => ComCall(14, this.p, SHOW_WINDOW_CMD.Ptr, piShowCmd)
    SetShowCmd(iShowCmd)
      => ComCall(15, this.p, SHOW_WINDOW_CMD, iShowCmd)
    GetIconLocation(pszIconPath, piIcon)
      => ComCall(16, this.p, PSTR, pszIconPath, Int32, pszIconPath.Length, Int32.Ptr, piIcon)
    SetIconLocation(pszIconPath, iIcon)
      => ComCall(17, this.p, PSTR, pszIconPath, Int32, iIcon)
    SetRelativePath(pszPathRel, dwReserved)
      => ComCall(18, this.p, PSTR, pszPathRel, UInt32, dwReserved)
    Resolve(hwnd1, fFlags)
      => ComCall(19, this.p, HWND, hwnd1, UInt32, fFlags)
    SetPath(pszFile)
      => ComCall(20, this.p, PSTR, pszFile)
}
struct IShellLinkW extends IUnknown {
    static IID := "{000214F9-0000-0000-C000-000000000046}"
    GetPath(pszFile, pfd, fFlags)
      => ComCall(3, this.p, PWSTR, pszFile, Int32, pszFile.Length, WIN32_FIND_DATAW.Ptr, pfd, UInt32, fFlags)
    GetIDList(ppidl)
      => ComCall(4, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
    SetIDList(pidl)
      => ComCall(5, this.p, ITEMIDLIST.Ptr, pidl)
    GetDescription(pszName)
      => ComCall(6, this.p, PWSTR, pszName, Int32, pszName.Length)
    SetDescription(pszName)
      => ComCall(7, this.p, "Str", pszName)
    GetWorkingDirectory(pszDir)
      => ComCall(8, this.p, PWSTR, pszDir, Int32, pszDir.Length)
    SetWorkingDirectory(pszDir)
      => ComCall(9, this.p, "Str", pszDir)
    GetArguments(pszArgs)
      => ComCall(10, this.p, PWSTR, pszArgs, Int32, pszArgs.Length)
    SetArguments(pszArgs)
      => ComCall(11, this.p, "Str", pszArgs)
    GetHotkey(pwHotkey)
      => ComCall(12, this.p, UInt16.Ptr, pwHotkey)
    SetHotkey(wHotkey)
      => ComCall(13, this.p, UInt16, wHotkey)
    GetShowCmd(piShowCmd)
      => ComCall(14, this.p, SHOW_WINDOW_CMD.Ptr, piShowCmd)
    SetShowCmd(iShowCmd)
      => ComCall(15, this.p, SHOW_WINDOW_CMD, iShowCmd)
    GetIconLocation(pszIconPath, piIcon)
      => ComCall(16, this.p, PWSTR, pszIconPath, Int32, pszIconPath.Length, Int32.Ptr, piIcon)
    SetIconLocation(pszIconPath, iIcon)
      => ComCall(17, this.p, "Str", pszIconPath, Int32, iIcon)
    SetRelativePath(pszPathRel, dwReserved)
      => ComCall(18, this.p, "Str", pszPathRel, UInt32, dwReserved)
    Resolve(hwnd1, fFlags)
      => ComCall(19, this.p, HWND, hwnd1, UInt32, fFlags)
    SetPath(pszFile)
      => ComCall(20, this.p, "Str", pszFile)
}
struct IShellLinkDataList extends IUnknown {
    static IID := "{45E2B4AE-B1C3-11D0-B92F-00A0C90312E1}"
    AddDataBlock(pDataBlock)
      => ComCall(3, this.p, Struct.Ptr, pDataBlock)
    CopyDataBlock(dwSig, ppDataBlock)
      => ComCall(4, this.p, UInt32, dwSig, Struct.Ptr.Ptr, ppDataBlock)
    RemoveDataBlock(dwSig)
      => ComCall(5, this.p, UInt32, dwSig)
    GetFlags(pdwFlags)
      => ComCall(6, this.p, UInt32.Ptr, pdwFlags)
    SetFlags(dwFlags)
      => ComCall(7, this.p, UInt32, dwFlags)
}
struct IResolveShellLink extends IUnknown {
    static IID := "{5CD52983-9449-11D2-963A-00C04F79ADF0}"
    ResolveShellLink(punkLink, hwnd1, fFlags)
      => ComCall(3, this.p, IUnknown, punkLink, HWND, hwnd1, UInt32, fFlags)
}
struct SPINITF extends Int32 {
    static SPINITF_NORMAL := 0
    static SPINITF_MODAL := 1
    static SPINITF_NOMINIMIZE := 8
}
struct IActionProgressDialog extends IUnknown {
    static IID := "{49FF1172-EADC-446D-9285-156453A6431C}"
    Initialize(flags, pszTitle, pszCancel)
      => ComCall(3, this.p, UInt32, flags, "Str", pszTitle, "Str", pszCancel)
    Stop()
      => ComCall(4, this.p)
}
struct SPBEGINF extends Int32 {
    static SPBEGINF_NORMAL := 0
    static SPBEGINF_AUTOTIME := 2
    static SPBEGINF_NOPROGRESSBAR := 16
    static SPBEGINF_MARQUEEPROGRESS := 32
    static SPBEGINF_NOCANCELBUTTON := 64
}
struct SPACTION extends Int32 {
    static SPACTION_NONE := 0
    static SPACTION_MOVING := 1
    static SPACTION_COPYING := 2
    static SPACTION_RECYCLING := 3
    static SPACTION_APPLYINGATTRIBS := 4
    static SPACTION_DOWNLOADING := 5
    static SPACTION_SEARCHING_INTERNET := 6
    static SPACTION_CALCULATING := 7
    static SPACTION_UPLOADING := 8
    static SPACTION_SEARCHING_FILES := 9
    static SPACTION_DELETING := 10
    static SPACTION_RENAMING := 11
    static SPACTION_FORMATTING := 12
    static SPACTION_COPY_MOVING := 13
}
struct SPTEXT extends Int32 {
    static SPTEXT_ACTIONDESCRIPTION := 1
    static SPTEXT_ACTIONDETAIL := 2
}
struct IActionProgress extends IUnknown {
    static IID := "{49FF1173-EADC-446D-9285-156453A6431C}"
    Begin(action, flags)
      => ComCall(3, this.p, SPACTION, action, UInt32, flags)
    UpdateProgress(ulCompleted, ulTotal)
      => ComCall(4, this.p, Int64, ulCompleted, Int64, ulTotal)
    UpdateText(sptext1, pszText, fMayCompact)
      => ComCall(5, this.p, SPTEXT, sptext1, "Str", pszText, BOOL, fMayCompact)
    QueryCancel(pfCancelled)
      => ComCall(6, this.p, BOOL.Ptr, pfCancelled)
    ResetCancel()
      => ComCall(7, this.p)
    End()
      => ComCall(8, this.p)
}
struct IShellExtInit extends IUnknown {
    static IID := "{000214E8-0000-0000-C000-000000000046}"
    Initialize(pidlFolder?, pdtobj?, hkeyProgID?)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidlFolder?, IDataObject, pdtobj?, HKEY, hkeyProgID?)
}
struct EXPPS extends Int32 {
    static EXPPS_FILETYPES := 1
}
struct IShellPropSheetExt extends IUnknown {
    static IID := "{000214E9-0000-0000-C000-000000000046}"
    AddPages(pfnAddPage, lParam1)
      => ComCall(3, this.p, LPFNSVADDPROPSHEETPAGE, pfnAddPage, LPARAM, lParam1)
    ReplacePage(uPageID, pfnReplaceWith, lParam1)
      => ComCall(4, this.p, UInt32, uPageID, LPFNSVADDPROPSHEETPAGE, pfnReplaceWith, LPARAM, lParam1)
}
struct IRemoteComputer extends IUnknown {
    static IID := "{000214FE-0000-0000-C000-000000000046}"
    Initialize(pszMachine, bEnumerating)
      => ComCall(3, this.p, "Str", pszMachine, BOOL, bEnumerating)
}
struct IQueryContinue extends IUnknown {
    static IID := "{7307055C-B24A-486B-9F25-163E597A28A9}"
    QueryContinue()
      => ComCall(3, this.p)
}
struct IObjectWithCancelEvent extends IUnknown {
    static IID := "{F279B885-0AE9-4B85-AC06-DDECF9408941}"
    GetCancelEvent(phEvent)
      => ComCall(3, this.p, HANDLE.Ptr, phEvent)
}
struct IUserNotification extends IUnknown {
    static IID := "{BA9711BA-5893-4787-A7E1-41277151550B}"
    SetBalloonInfo(pszTitle, pszText, dwInfoFlags)
      => ComCall(3, this.p, "Str", pszTitle, "Str", pszText, UInt32, dwInfoFlags)
    SetBalloonRetry(dwShowTime, dwInterval, cRetryCount)
      => ComCall(4, this.p, UInt32, dwShowTime, UInt32, dwInterval, UInt32, cRetryCount)
    SetIconInfo(hIcon1, pszToolTip)
      => ComCall(5, this.p, HICON, hIcon1, "Str", pszToolTip)
    Show(pqc, dwContinuePollInterval)
      => ComCall(6, this.p, IQueryContinue, pqc, UInt32, dwContinuePollInterval)
    PlaySound(pszSoundName)
      => ComCall(7, this.p, "Str", pszSoundName)
}
struct IItemNameLimits extends IUnknown {
    static IID := "{1DF0D7F1-B267-4D28-8B10-12E23202A5C4}"
    GetValidCharacters(ppwszValidChars, ppwszInvalidChars)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszValidChars, PWSTR.Ptr, ppwszInvalidChars)
    GetMaxLength(pszName, piMaxNameLen)
      => ComCall(4, this.p, "Str", pszName, Int32.Ptr, piMaxNameLen)
}
struct ISearchFolderItemFactory extends IUnknown {
    static IID := "{A0FFBC28-5482-4366-BE27-3E81E78E06C2}"
    SetDisplayName(pszDisplayName)
      => ComCall(3, this.p, "Str", pszDisplayName)
    SetFolderTypeID(ftid)
      => ComCall(4, this.p, GUID, ftid)
    SetFolderLogicalViewMode(flvm)
      => ComCall(5, this.p, FOLDERLOGICALVIEWMODE, flvm)
    SetIconSize(iIconSize)
      => ComCall(6, this.p, Int32, iIconSize)
    SetVisibleColumns(rgKey)
      => ComCall(7, this.p, UInt32, rgKey.Length, PROPERTYKEY.Ptr, rgKey)
    SetSortColumns(rgSortColumns)
      => ComCall(8, this.p, UInt32, rgSortColumns.Length, SORTCOLUMN.Ptr, rgSortColumns)
    SetGroupColumn(keyGroup)
      => ComCall(9, this.p, PROPERTYKEY.Ptr, keyGroup)
    SetStacks(rgStackKeys)
      => ComCall(10, this.p, UInt32, rgStackKeys.Length, PROPERTYKEY.Ptr, rgStackKeys)
    SetScope(psiaScope)
      => ComCall(11, this.p, IShellItemArray, psiaScope)
    SetCondition(pCondition)
      => ComCall(12, this.p, ICondition, pCondition)
    GetShellItem(riid, ppv)
      => ComCall(13, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetIDList(ppidl)
      => ComCall(14, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
}
struct IExtractImage extends IUnknown {
    static IID := "{BB2E617C-0920-11D1-9A0B-00C04FC2D6C1}"
    GetLocation(pszPathBuffer, pdwPriority, prgSize, dwRecClrDepth, pdwFlags)
      => ComCall(3, this.p, PWSTR, pszPathBuffer, UInt32, pszPathBuffer.Length, UInt32.Ptr, pdwPriority, SIZE.Ptr, prgSize, UInt32, dwRecClrDepth, UInt32.Ptr, pdwFlags)
    Extract(phBmpThumbnail)
      => ComCall(4, this.p, HBITMAP.Ptr, phBmpThumbnail)
}
struct IExtractImage2 extends IExtractImage {
    static IID := "{953BB1EE-93B4-11D1-98A3-00C04FB687DA}"
    GetDateStamp(pDateStamp)
      => ComCall(5, this.p, FILETIME.Ptr, pDateStamp)
}
struct IThumbnailHandlerFactory extends IUnknown {
    static IID := "{E35B4B2E-00DA-4BC1-9F13-38BC11F5D417}"
    GetThumbnailHandler(pidlChild, pbc, riid, ppv)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidlChild, IBindCtx, pbc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IParentAndItem extends IUnknown {
    static IID := "{B3A4B685-B685-4805-99D9-5DEAD2873236}"
    SetParentAndItem(pidlParent, psf, pidlChild)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidlParent, IShellFolder, psf, ITEMIDLIST.Ptr, pidlChild)
    GetParentAndItem(ppidlParent?, ppsf?, ppidlChild?)
      => ComCall(4, this.p, ITEMIDLIST.Ptr.Ptr, ppidlParent?, IShellFolder.Ptr, ppsf?, ITEMIDLIST.Ptr.Ptr, ppidlChild?)
}
struct IDockingWindow extends IOleWindow {
    static IID := "{012DD920-7B26-11D0-8CA9-00A0C92DBFE8}"
    ShowDW(fShow)
      => ComCall(5, this.p, BOOL, fShow)
    CloseDW(dwReserved)
      => ComCall(6, this.p, UInt32, dwReserved)
    ResizeBorderDW(prcBorder, punkToolbarSite, fReserved)
      => ComCall(7, this.p, RECT.Ptr, prcBorder, IUnknown, punkToolbarSite, BOOL, fReserved)
}
struct DESKBANDINFO {
    dwMask : UInt32
    ptMinSize : POINTL
    ptMaxSize : POINTL
    ptIntegral : POINTL
    ptActual : POINTL
    wszTitle : UInt16[256]
    dwModeFlags : UInt32
    crBkgnd : COLORREF
}
struct DESKBANDCID extends Int32 {
    static DBID_BANDINFOCHANGED := 0
    static DBID_SHOWONLY := 1
    static DBID_MAXIMIZEBAND := 2
    static DBID_PUSHCHEVRON := 3
    static DBID_DELAYINIT := 4
    static DBID_FINISHINIT := 5
    static DBID_SETWINDOWTHEME := 6
    static DBID_PERMITAUTOHIDE := 7
}
struct IDeskBand extends IDockingWindow {
    static IID := "{EB0FE172-1A3A-11D0-89B3-00A0C90A90AC}"
    GetBandInfo(dwBandID, dwViewMode, pdbi)
      => ComCall(8, this.p, UInt32, dwBandID, UInt32, dwViewMode, DESKBANDINFO.Ptr, pdbi)
}
struct IDeskBandInfo extends IUnknown {
    static IID := "{77E425FC-CBF9-4307-BA6A-BB5727745661}"
    GetDefaultBandWidth(dwBandID, dwViewMode, pnWidth)
      => ComCall(3, this.p, UInt32, dwBandID, UInt32, dwViewMode, Int32.Ptr, pnWidth)
}
struct ITaskbarList extends IUnknown {
    static IID := "{56FDF342-FD6D-11D0-958A-006097C9A090}"
    HrInit()
      => ComCall(3, this.p)
    AddTab(hwnd1)
      => ComCall(4, this.p, HWND, hwnd1)
    DeleteTab(hwnd1)
      => ComCall(5, this.p, HWND, hwnd1)
    ActivateTab(hwnd1)
      => ComCall(6, this.p, HWND, hwnd1)
    SetActiveAlt(hwnd1)
      => ComCall(7, this.p, HWND, hwnd1)
}
struct ITaskbarList2 extends ITaskbarList {
    static IID := "{602D4995-B13A-429B-A66E-1935E44F4317}"
    MarkFullscreenWindow(hwnd1, fFullscreen)
      => ComCall(8, this.p, HWND, hwnd1, BOOL, fFullscreen)
}
struct THUMBBUTTONFLAGS extends Int32 {
    static THBF_ENABLED := 0
    static THBF_DISABLED := 1
    static THBF_DISMISSONCLICK := 2
    static THBF_NOBACKGROUND := 4
    static THBF_HIDDEN := 8
    static THBF_NONINTERACTIVE := 16
}
struct THUMBBUTTONMASK extends Int32 {
    static THB_BITMAP := 1
    static THB_ICON := 2
    static THB_TOOLTIP := 4
    static THB_FLAGS := 8
}
struct THUMBBUTTON {
    dwMask : THUMBBUTTONMASK
    iId : UInt32
    iBitmap : UInt32
    hIcon : HICON
    szTip : UInt16[260]
    dwFlags : THUMBBUTTONFLAGS
}
struct TBPFLAG extends Int32 {
    static TBPF_NOPROGRESS := 0
    static TBPF_INDETERMINATE := 1
    static TBPF_NORMAL := 2
    static TBPF_ERROR := 4
    static TBPF_PAUSED := 8
}
struct ITaskbarList3 extends ITaskbarList2 {
    static IID := "{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}"
    SetProgressValue(hwnd1, ullCompleted, ullTotal)
      => ComCall(9, this.p, HWND, hwnd1, Int64, ullCompleted, Int64, ullTotal)
    SetProgressState(hwnd1, tbpFlags)
      => ComCall(10, this.p, HWND, hwnd1, TBPFLAG, tbpFlags)
    RegisterTab(hwndTab, hwndMDI)
      => ComCall(11, this.p, HWND, hwndTab, HWND, hwndMDI)
    UnregisterTab(hwndTab)
      => ComCall(12, this.p, HWND, hwndTab)
    SetTabOrder(hwndTab, hwndInsertBefore)
      => ComCall(13, this.p, HWND, hwndTab, HWND, hwndInsertBefore)
    SetTabActive(hwndTab, hwndMDI, dwReserved)
      => ComCall(14, this.p, HWND, hwndTab, HWND, hwndMDI, UInt32, dwReserved)
    ThumbBarAddButtons(hwnd1, pButton)
      => ComCall(15, this.p, HWND, hwnd1, UInt32, pButton.Length, THUMBBUTTON.Ptr, pButton)
    ThumbBarUpdateButtons(hwnd1, pButton)
      => ComCall(16, this.p, HWND, hwnd1, UInt32, pButton.Length, THUMBBUTTON.Ptr, pButton)
    ThumbBarSetImageList(hwnd1, himl)
      => ComCall(17, this.p, HWND, hwnd1, HIMAGELIST, himl)
    SetOverlayIcon(hwnd1, hIcon1, pszDescription)
      => ComCall(18, this.p, HWND, hwnd1, HICON, hIcon1, "Str", pszDescription)
    SetThumbnailTooltip(hwnd1, pszTip)
      => ComCall(19, this.p, HWND, hwnd1, "Str", pszTip)
    SetThumbnailClip(hwnd1, prcClip)
      => ComCall(20, this.p, HWND, hwnd1, RECT.Ptr, prcClip)
}
struct STPFLAG extends Int32 {
    static STPF_NONE := 0
    static STPF_USEAPPTHUMBNAILALWAYS := 1
    static STPF_USEAPPTHUMBNAILWHENACTIVE := 2
    static STPF_USEAPPPEEKALWAYS := 4
    static STPF_USEAPPPEEKWHENACTIVE := 8
}
struct ITaskbarList4 extends ITaskbarList3 {
    static IID := "{C43DC798-95D1-4BEA-9030-BB99E2983A1A}"
    SetTabProperties(hwndTab, stpFlags)
      => ComCall(21, this.p, HWND, hwndTab, STPFLAG, stpFlags)
}
struct IExplorerBrowserEvents extends IUnknown {
    static IID := "{361BBDC7-E6EE-4E13-BE58-58E2240C810F}"
    OnNavigationPending(pidlFolder)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidlFolder)
    OnViewCreated(psv)
      => ComCall(4, this.p, IShellView, psv)
    OnNavigationComplete(pidlFolder)
      => ComCall(5, this.p, ITEMIDLIST.Ptr, pidlFolder)
    OnNavigationFailed(pidlFolder)
      => ComCall(6, this.p, ITEMIDLIST.Ptr, pidlFolder)
}
struct EXPLORER_BROWSER_OPTIONS extends Int32 {
    static EBO_NONE := 0
    static EBO_NAVIGATEONCE := 1
    static EBO_SHOWFRAMES := 2
    static EBO_ALWAYSNAVIGATE := 4
    static EBO_NOTRAVELLOG := 8
    static EBO_NOWRAPPERWINDOW := 16
    static EBO_HTMLSHAREPOINTVIEW := 32
    static EBO_NOBORDER := 64
    static EBO_NOPERSISTVIEWSTATE := 128
}
struct EXPLORER_BROWSER_FILL_FLAGS extends Int32 {
    static EBF_NONE := 0
    static EBF_SELECTFROMDATAOBJECT := 256
    static EBF_NODROPTARGET := 512
}
struct IExplorerBrowser extends IUnknown {
    static IID := "{DFD3B6B5-C10C-4BE9-85F6-A66969F402F6}"
    Initialize(hwndParent, prc, pfs?)
      => ComCall(3, this.p, HWND, hwndParent, RECT.Ptr, prc, FOLDERSETTINGS.Ptr, pfs?)
    Destroy()
      => ComCall(4, this.p)
    SetRect(phdwp?, rcBrowser)
      => ComCall(5, this.p, HDWP.Ptr, phdwp?, RECT, rcBrowser)
    SetPropertyBag(pszPropertyBag)
      => ComCall(6, this.p, "Str", pszPropertyBag)
    SetEmptyText(pszEmptyText)
      => ComCall(7, this.p, "Str", pszEmptyText)
    SetFolderSettings(pfs)
      => ComCall(8, this.p, FOLDERSETTINGS.Ptr, pfs)
    Advise(psbe, pdwCookie)
      => ComCall(9, this.p, IExplorerBrowserEvents, psbe, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(10, this.p, UInt32, dwCookie)
    SetOptions(dwFlag)
      => ComCall(11, this.p, EXPLORER_BROWSER_OPTIONS, dwFlag)
    GetOptions(pdwFlag)
      => ComCall(12, this.p, EXPLORER_BROWSER_OPTIONS.Ptr, pdwFlag)
    BrowseToIDList(pidl, uFlags)
      => ComCall(13, this.p, ITEMIDLIST.Ptr, pidl, UInt32, uFlags)
    BrowseToObject(punk, uFlags)
      => ComCall(14, this.p, IUnknown, punk, UInt32, uFlags)
    FillFromObject(punk, dwFlags)
      => ComCall(15, this.p, IUnknown, punk, EXPLORER_BROWSER_FILL_FLAGS, dwFlags)
    RemoveAll()
      => ComCall(16, this.p)
    GetCurrentView(riid, ppv)
      => ComCall(17, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IEnumObjects extends IUnknown {
    static IID := "{2C1C7E2E-2D0E-4059-831E-1E6F82335C2E}"
    Next(riid, rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, GUID.Ptr, riid, Struct.Ptr.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumObjects.Ptr, ppenum)
}
struct OPPROGDLGF extends Int32 {
    static OPPROGDLG_DEFAULT := 0
    static OPPROGDLG_ENABLEPAUSE := 128
    static OPPROGDLG_ALLOWUNDO := 256
    static OPPROGDLG_DONTDISPLAYSOURCEPATH := 512
    static OPPROGDLG_DONTDISPLAYDESTPATH := 1024
    static OPPROGDLG_NOMULTIDAYESTIMATES := 2048
    static OPPROGDLG_DONTDISPLAYLOCATIONS := 4096
}
struct PDMODE extends Int32 {
    static PDM_DEFAULT := 0
    static PDM_RUN := 1
    static PDM_PREFLIGHT := 2
    static PDM_UNDOING := 4
    static PDM_ERRORSBLOCKING := 8
    static PDM_INDETERMINATE := 16
}
struct IOperationsProgressDialog extends IUnknown {
    static IID := "{0C9FB851-E5C9-43EB-A370-F0677B13874C}"
    StartProgressDialog(hwndOwner, flags)
      => ComCall(3, this.p, HWND, hwndOwner, UInt32, flags)
    StopProgressDialog()
      => ComCall(4, this.p)
    SetOperation(action)
      => ComCall(5, this.p, SPACTION, action)
    SetMode(mode)
      => ComCall(6, this.p, UInt32, mode)
    UpdateProgress(ullPointsCurrent, ullPointsTotal, ullSizeCurrent, ullSizeTotal, ullItemsCurrent, ullItemsTotal)
      => ComCall(7, this.p, Int64, ullPointsCurrent, Int64, ullPointsTotal, Int64, ullSizeCurrent, Int64, ullSizeTotal, Int64, ullItemsCurrent, Int64, ullItemsTotal)
    UpdateLocations(psiSource, psiTarget, psiItem)
      => ComCall(8, this.p, IShellItem, psiSource, IShellItem, psiTarget, IShellItem, psiItem)
    ResetTimer()
      => ComCall(9, this.p)
    PauseTimer()
      => ComCall(10, this.p)
    ResumeTimer()
      => ComCall(11, this.p)
    GetMilliseconds(pullElapsed, pullRemaining)
      => ComCall(12, this.p, Int64.Ptr, pullElapsed, Int64.Ptr, pullRemaining)
    GetOperationStatus(popstatus)
      => ComCall(13, this.p, PDOPSTATUS.Ptr, popstatus)
}
struct IIOCancelInformation extends IUnknown {
    static IID := "{F5B0BF81-8CB5-4B1B-9449-1A159E0C733C}"
    SetCancelInformation(dwThreadID, uMsgCancel)
      => ComCall(3, this.p, UInt32, dwThreadID, UInt32, uMsgCancel)
    GetCancelInformation(pdwThreadID?, puMsgCancel?)
      => ComCall(4, this.p, UInt32.Ptr, pdwThreadID?, UInt32.Ptr, puMsgCancel?)
}
struct IFileOperation extends IUnknown {
    static IID := "{947AAB5F-0A5C-4C13-B4D6-4BF7836FC9F8}"
    Advise(pfops, pdwCookie)
      => ComCall(3, this.p, IFileOperationProgressSink, pfops, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    SetOperationFlags(dwOperationFlags)
      => ComCall(5, this.p, FILEOPERATION_FLAGS, dwOperationFlags)
    SetProgressMessage(pszMessage)
      => ComCall(6, this.p, "Str", pszMessage)
    SetProgressDialog(popd)
      => ComCall(7, this.p, IOperationsProgressDialog, popd)
    SetProperties(pproparray)
      => ComCall(8, this.p, IPropertyChangeArray, pproparray)
    SetOwnerWindow(hwndOwner)
      => ComCall(9, this.p, HWND, hwndOwner)
    ApplyPropertiesToItem(psiItem)
      => ComCall(10, this.p, IShellItem, psiItem)
    ApplyPropertiesToItems(punkItems)
      => ComCall(11, this.p, IUnknown, punkItems)
    RenameItem(psiItem, pszNewName, pfopsItem)
      => ComCall(12, this.p, IShellItem, psiItem, "Str", pszNewName, IFileOperationProgressSink, pfopsItem)
    RenameItems(pUnkItems, pszNewName)
      => ComCall(13, this.p, IUnknown, pUnkItems, "Str", pszNewName)
    MoveItem(psiItem, psiDestinationFolder, pszNewName, pfopsItem)
      => ComCall(14, this.p, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszNewName, IFileOperationProgressSink, pfopsItem)
    MoveItems(punkItems, psiDestinationFolder)
      => ComCall(15, this.p, IUnknown, punkItems, IShellItem, psiDestinationFolder)
    CopyItem(psiItem, psiDestinationFolder, pszCopyName, pfopsItem)
      => ComCall(16, this.p, IShellItem, psiItem, IShellItem, psiDestinationFolder, "Str", pszCopyName, IFileOperationProgressSink, pfopsItem)
    CopyItems(punkItems, psiDestinationFolder)
      => ComCall(17, this.p, IUnknown, punkItems, IShellItem, psiDestinationFolder)
    DeleteItem(psiItem, pfopsItem)
      => ComCall(18, this.p, IShellItem, psiItem, IFileOperationProgressSink, pfopsItem)
    DeleteItems(punkItems)
      => ComCall(19, this.p, IUnknown, punkItems)
    NewItem(psiDestinationFolder, dwFileAttributes, pszName, pszTemplateName, pfopsItem)
      => ComCall(20, this.p, IShellItem, psiDestinationFolder, UInt32, dwFileAttributes, "Str", pszName, "Str", pszTemplateName, IFileOperationProgressSink, pfopsItem)
    PerformOperations()
      => ComCall(21, this.p)
    GetAnyOperationsAborted(pfAnyOperationsAborted)
      => ComCall(22, this.p, BOOL.Ptr, pfAnyOperationsAborted)
}
struct FILE_OPERATION_FLAGS2 extends Int32 {
    static FOF2_NONE := 0
    static FOF2_MERGEFOLDERSONCOLLISION := 1
}
struct IFileOperation2 extends IFileOperation {
    static IID := "{CD8F23C1-8F61-4916-909D-55BDD0918753}"
    SetOperationFlags2(operationFlags2)
      => ComCall(23, this.p, FILE_OPERATION_FLAGS2, operationFlags2)
}
struct IObjectProvider extends IUnknown {
    static IID := "{A6087428-3BE3-4D73-B308-7C04A540BF1A}"
    QueryObject(guidObject, riid, ppvOut)
      => ComCall(3, this.p, GUID.Ptr, guidObject, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvOut)
}
struct INamespaceWalkCB extends IUnknown {
    static IID := "{D92995F8-CF5E-4A76-BF59-EAD39EA2B97E}"
    FoundItem(psf, pidl)
      => ComCall(3, this.p, IShellFolder, psf, ITEMIDLIST.Ptr, pidl)
    EnterFolder(psf, pidl)
      => ComCall(4, this.p, IShellFolder, psf, ITEMIDLIST.Ptr, pidl)
    LeaveFolder(psf, pidl)
      => ComCall(5, this.p, IShellFolder, psf, ITEMIDLIST.Ptr, pidl)
    InitializeProgressDialog(ppszTitle, ppszCancel)
      => ComCall(6, this.p, PWSTR.Ptr, ppszTitle, PWSTR.Ptr, ppszCancel)
}
struct INamespaceWalkCB2 extends INamespaceWalkCB {
    static IID := "{7AC7492B-C38E-438A-87DB-68737844FF70}"
    WalkComplete(hr)
      => ComCall(7, this.p, HRESULT, hr)
}
struct NAMESPACEWALKFLAG extends Int32 {
    static NSWF_DEFAULT := 0
    static NSWF_NONE_IMPLIES_ALL := 1
    static NSWF_ONE_IMPLIES_ALL := 2
    static NSWF_DONT_TRAVERSE_LINKS := 4
    static NSWF_DONT_ACCUMULATE_RESULT := 8
    static NSWF_TRAVERSE_STREAM_JUNCTIONS := 16
    static NSWF_FILESYSTEM_ONLY := 32
    static NSWF_SHOW_PROGRESS := 64
    static NSWF_FLAG_VIEWORDER := 128
    static NSWF_IGNORE_AUTOPLAY_HIDA := 256
    static NSWF_ASYNC := 512
    static NSWF_DONT_RESOLVE_LINKS := 1024
    static NSWF_ACCUMULATE_FOLDERS := 2048
    static NSWF_DONT_SORT := 4096
    static NSWF_USE_TRANSFER_MEDIUM := 8192
    static NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS := 16384
    static NSWF_ANY_IMPLIES_ALL := 32768
}
struct INamespaceWalk extends IUnknown {
    static IID := "{57CED8A7-3F4A-432C-9350-30F24483F74F}"
    Walk(punkToWalk, dwFlags, cDepth, pnswcb)
      => ComCall(3, this.p, IUnknown, punkToWalk, UInt32, dwFlags, Int32, cDepth, INamespaceWalkCB, pnswcb)
    GetIDArrayResult(prgpidl)
      => ComCall(4, this.p, UInt32.Ptr, prgpidl.Length, ITEMIDLIST.Ptr.Ptr.Ptr, prgpidl)
}
struct BANDSITEINFO {
    dwMask : UInt32
    dwState : UInt32
    dwStyle : UInt32
}
struct BANDSITECID extends Int32 {
    static BSID_BANDADDED := 0
    static BSID_BANDREMOVED := 1
}
struct IBandSite extends IUnknown {
    static IID := "{4CF504B0-DE96-11D0-8B3F-00A0C911E8E5}"
    AddBand(punk)
      => ComCall(3, this.p, IUnknown, punk)
    EnumBands(uBand, pdwBandID)
      => ComCall(4, this.p, UInt32, uBand, UInt32.Ptr, pdwBandID)
    QueryBand(dwBandID, ppstb?, pdwState?, pszName?)
      => ComCall(5, this.p, UInt32, dwBandID, IDeskBand.Ptr, ppstb?, UInt32.Ptr, pdwState?, PWSTR, pszName?, Int32, pszName?.Length ?? 0)
    SetBandState(dwBandID, dwMask, dwState)
      => ComCall(6, this.p, UInt32, dwBandID, UInt32, dwMask, UInt32, dwState)
    RemoveBand(dwBandID)
      => ComCall(7, this.p, UInt32, dwBandID)
    GetBandObject(dwBandID, riid, ppv)
      => ComCall(8, this.p, UInt32, dwBandID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetBandSiteInfo(pbsinfo)
      => ComCall(9, this.p, BANDSITEINFO.Ptr, pbsinfo)
    GetBandSiteInfo(pbsinfo)
      => ComCall(10, this.p, BANDSITEINFO.Ptr, pbsinfo)
}
struct IModalWindow extends IUnknown {
    static IID := "{B4DB1657-70D7-485E-8E3E-6FCB5A5C1802}"
    Show(hwndOwner?)
      => ComCall(3, this.p, HWND, hwndOwner?)
}
struct IContextMenuSite extends IUnknown {
    static IID := "{0811AEBE-0B87-4C54-9E72-548CF649016B}"
    DoContextMenuPopup(punkContextMenu, fFlags, pt)
      => ComCall(3, this.p, IUnknown, punkContextMenu, UInt32, fFlags, POINT, pt)
}
struct MENUBANDHANDLERCID extends Int32 {
    static MBHANDCID_PIDLSELECT := 0
}
struct IMenuBand extends IUnknown {
    static IID := "{568804CD-CBD7-11D0-9816-00C04FD91972}"
    IsMenuMessage(pmsg)
      => ComCall(3, this.p, MSG.Ptr, pmsg)
    TranslateMenuMessage(pmsg, plRet)
      => ComCall(4, this.p, MSG.Ptr, pmsg, LRESULT.Ptr, plRet)
}
struct IRegTreeItem extends IUnknown {
    static IID := "{A9521922-0812-4D44-9EC3-7FD38C726F3D}"
    GetCheckState(pbCheck)
      => ComCall(3, this.p, BOOL.Ptr, pbCheck)
    SetCheckState(bCheck)
      => ComCall(4, this.p, BOOL, bCheck)
}
struct IDeskBar extends IOleWindow {
    static IID := "{EB0FE173-1A3A-11D0-89B3-00A0C90A90AC}"
    SetClient(punkClient?)
      => ComCall(5, this.p, IUnknown, punkClient?)
    GetClient(ppunkClient)
      => ComCall(6, this.p, IUnknown.Ptr, ppunkClient)
    OnPosRectChangeDB(prc)
      => ComCall(7, this.p, RECT.Ptr, prc)
}
struct MENUPOPUPSELECT extends Int32 {
    static MPOS_EXECUTE := 0
    static MPOS_FULLCANCEL := 1
    static MPOS_CANCELLEVEL := 2
    static MPOS_SELECTLEFT := 3
    static MPOS_SELECTRIGHT := 4
    static MPOS_CHILDTRACKING := 5
}
struct MENUPOPUPPOPUPFLAGS extends Int32 {
    static MPPF_SETFOCUS := 1
    static MPPF_INITIALSELECT := 2
    static MPPF_NOANIMATE := 4
    static MPPF_KEYBOARD := 16
    static MPPF_REPOSITION := 32
    static MPPF_FORCEZORDER := 64
    static MPPF_FINALSELECT := 128
    static MPPF_TOP := 536870912
    static MPPF_LEFT := 1073741824
    static MPPF_RIGHT := 1610612736
    static MPPF_BOTTOM := -2147483648
    static MPPF_POS_MASK := -536870912
    static MPPF_ALIGN_LEFT := 33554432
    static MPPF_ALIGN_RIGHT := 67108864
}
struct IMenuPopup extends IDeskBar {
    static IID := "{D1E7AFEB-6A2E-11D0-8C78-00C04FD918B4}"
    Popup(ppt, prcExclude?, dwFlags)
      => ComCall(8, this.p, POINTL.Ptr, ppt, RECTL.Ptr, prcExclude?, Int32, dwFlags)
    OnSelect(dwSelectType)
      => ComCall(9, this.p, UInt32, dwSelectType)
    SetSubMenu(pmp, fSet)
      => ComCall(10, this.p, IMenuPopup, pmp, BOOL, fSet)
}
struct FILE_USAGE_TYPE extends Int32 {
    static FUT_PLAYING := 0
    static FUT_EDITING := 1
    static FUT_GENERIC := 2
}
struct IFileIsInUse extends IUnknown {
    static IID := "{64A1CBF0-3A1A-4461-9158-376969693950}"
    GetAppName(ppszName)
      => ComCall(3, this.p, PWSTR.Ptr, ppszName)
    GetUsage(pfut)
      => ComCall(4, this.p, FILE_USAGE_TYPE.Ptr, pfut)
    GetCapabilities(pdwCapFlags)
      => ComCall(5, this.p, UInt32.Ptr, pdwCapFlags)
    GetSwitchToHWND(phwnd)
      => ComCall(6, this.p, HWND.Ptr, phwnd)
    CloseFile()
      => ComCall(7, this.p)
}
struct FDE_OVERWRITE_RESPONSE extends Int32 {
    static FDEOR_DEFAULT := 0
    static FDEOR_ACCEPT := 1
    static FDEOR_REFUSE := 2
}
struct FDE_SHAREVIOLATION_RESPONSE extends Int32 {
    static FDESVR_DEFAULT := 0
    static FDESVR_ACCEPT := 1
    static FDESVR_REFUSE := 2
}
struct FDAP extends Int32 {
    static FDAP_BOTTOM := 0
    static FDAP_TOP := 1
}
struct IFileDialogEvents extends IUnknown {
    static IID := "{973510DB-7D7F-452B-8975-74A85828D354}"
    OnFileOk(pfd)
      => ComCall(3, this.p, IFileDialog, pfd)
    OnFolderChanging(pfd, psiFolder)
      => ComCall(4, this.p, IFileDialog, pfd, IShellItem, psiFolder)
    OnFolderChange(pfd)
      => ComCall(5, this.p, IFileDialog, pfd)
    OnSelectionChange(pfd)
      => ComCall(6, this.p, IFileDialog, pfd)
    OnShareViolation(pfd, psi, pResponse)
      => ComCall(7, this.p, IFileDialog, pfd, IShellItem, psi, FDE_SHAREVIOLATION_RESPONSE.Ptr, pResponse)
    OnTypeChange(pfd)
      => ComCall(8, this.p, IFileDialog, pfd)
    OnOverwrite(pfd, psi, pResponse)
      => ComCall(9, this.p, IFileDialog, pfd, IShellItem, psi, FDE_OVERWRITE_RESPONSE.Ptr, pResponse)
}
struct FILEOPENDIALOGOPTIONS extends UInt32 {
    static FOS_OVERWRITEPROMPT := 2
    static FOS_STRICTFILETYPES := 4
    static FOS_NOCHANGEDIR := 8
    static FOS_PICKFOLDERS := 32
    static FOS_FORCEFILESYSTEM := 64
    static FOS_ALLNONSTORAGEITEMS := 128
    static FOS_NOVALIDATE := 256
    static FOS_ALLOWMULTISELECT := 512
    static FOS_PATHMUSTEXIST := 2048
    static FOS_FILEMUSTEXIST := 4096
    static FOS_CREATEPROMPT := 8192
    static FOS_SHAREAWARE := 16384
    static FOS_NOREADONLYRETURN := 32768
    static FOS_NOTESTFILECREATE := 65536
    static FOS_HIDEMRUPLACES := 131072
    static FOS_HIDEPINNEDPLACES := 262144
    static FOS_NODEREFERENCELINKS := 1048576
    static FOS_OKBUTTONNEEDSINTERACTION := 2097152
    static FOS_DONTADDTORECENT := 33554432
    static FOS_FORCESHOWHIDDEN := 268435456
    static FOS_DEFAULTNOMINIMODE := 536870912
    static FOS_FORCEPREVIEWPANEON := 1073741824
    static FOS_SUPPORTSTREAMABLEITEMS := 2147483648
}
struct IFileDialog extends IModalWindow {
    static IID := "{42F85136-DB7E-439C-85F1-E4075D135FC8}"
    SetFileTypes(rgFilterSpec)
      => ComCall(4, this.p, UInt32, rgFilterSpec.Length, COMDLG_FILTERSPEC.Ptr, rgFilterSpec)
    SetFileTypeIndex(iFileType)
      => ComCall(5, this.p, UInt32, iFileType)
    GetFileTypeIndex(piFileType)
      => ComCall(6, this.p, UInt32.Ptr, piFileType)
    Advise(pfde, pdwCookie)
      => ComCall(7, this.p, IFileDialogEvents, pfde, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(8, this.p, UInt32, dwCookie)
    SetOptions(fos)
      => ComCall(9, this.p, FILEOPENDIALOGOPTIONS, fos)
    GetOptions(pfos)
      => ComCall(10, this.p, FILEOPENDIALOGOPTIONS.Ptr, pfos)
    SetDefaultFolder(psi)
      => ComCall(11, this.p, IShellItem, psi)
    SetFolder(psi)
      => ComCall(12, this.p, IShellItem, psi)
    GetFolder(ppsi)
      => ComCall(13, this.p, IShellItem.Ptr, ppsi)
    GetCurrentSelection(ppsi)
      => ComCall(14, this.p, IShellItem.Ptr, ppsi)
    SetFileName(pszName)
      => ComCall(15, this.p, "Str", pszName)
    GetFileName(pszName)
      => ComCall(16, this.p, PWSTR.Ptr, pszName)
    SetTitle(pszTitle)
      => ComCall(17, this.p, "Str", pszTitle)
    SetOkButtonLabel(pszText)
      => ComCall(18, this.p, "Str", pszText)
    SetFileNameLabel(pszLabel)
      => ComCall(19, this.p, "Str", pszLabel)
    GetResult(ppsi)
      => ComCall(20, this.p, IShellItem.Ptr, ppsi)
    AddPlace(psi, fdap1)
      => ComCall(21, this.p, IShellItem, psi, FDAP, fdap1)
    SetDefaultExtension(pszDefaultExtension)
      => ComCall(22, this.p, "Str", pszDefaultExtension)
    Close(hr)
      => ComCall(23, this.p, HRESULT, hr)
    SetClientGuid(guid)
      => ComCall(24, this.p, GUID.Ptr, guid)
    ClearClientData()
      => ComCall(25, this.p)
    SetFilter(pFilter)
      => ComCall(26, this.p, IShellItemFilter, pFilter)
}
struct IFileSaveDialog extends IFileDialog {
    static IID := "{84BCCD23-5FDE-4CDB-AEA4-AF64B83D78AB}"
    SetSaveAsItem(psi)
      => ComCall(27, this.p, IShellItem, psi)
    SetProperties(pStore)
      => ComCall(28, this.p, IPropertyStore, pStore)
    SetCollectedProperties(pList, fAppendDefault)
      => ComCall(29, this.p, IPropertyDescriptionList, pList, BOOL, fAppendDefault)
    GetProperties(ppStore)
      => ComCall(30, this.p, IPropertyStore.Ptr, ppStore)
    ApplyProperties(psi, pStore, hwnd1, pSink)
      => ComCall(31, this.p, IShellItem, psi, IPropertyStore, pStore, HWND, hwnd1, IFileOperationProgressSink, pSink)
}
struct IFileOpenDialog extends IFileDialog {
    static IID := "{D57C7288-D4AD-4768-BE02-9D969532D960}"
    GetResults(ppenum)
      => ComCall(27, this.p, IShellItemArray.Ptr, ppenum)
    GetSelectedItems(ppsai)
      => ComCall(28, this.p, IShellItemArray.Ptr, ppsai)
}
struct CDCONTROLSTATEF extends Int32 {
    static CDCS_INACTIVE := 0
    static CDCS_ENABLED := 1
    static CDCS_VISIBLE := 2
    static CDCS_ENABLEDVISIBLE := 3
}
struct IFileDialogCustomize extends IUnknown {
    static IID := "{E6FDD21A-163F-4975-9C8C-A69F1BA37034}"
    EnableOpenDropDown(dwIDCtl)
      => ComCall(3, this.p, UInt32, dwIDCtl)
    AddMenu(dwIDCtl, pszLabel)
      => ComCall(4, this.p, UInt32, dwIDCtl, "Str", pszLabel)
    AddPushButton(dwIDCtl, pszLabel)
      => ComCall(5, this.p, UInt32, dwIDCtl, "Str", pszLabel)
    AddComboBox(dwIDCtl)
      => ComCall(6, this.p, UInt32, dwIDCtl)
    AddRadioButtonList(dwIDCtl)
      => ComCall(7, this.p, UInt32, dwIDCtl)
    AddCheckButton(dwIDCtl, pszLabel, bChecked)
      => ComCall(8, this.p, UInt32, dwIDCtl, "Str", pszLabel, BOOL, bChecked)
    AddEditBox(dwIDCtl, pszText)
      => ComCall(9, this.p, UInt32, dwIDCtl, "Str", pszText)
    AddSeparator(dwIDCtl)
      => ComCall(10, this.p, UInt32, dwIDCtl)
    AddText(dwIDCtl, pszText)
      => ComCall(11, this.p, UInt32, dwIDCtl, "Str", pszText)
    SetControlLabel(dwIDCtl, pszLabel)
      => ComCall(12, this.p, UInt32, dwIDCtl, "Str", pszLabel)
    GetControlState(dwIDCtl, pdwState)
      => ComCall(13, this.p, UInt32, dwIDCtl, CDCONTROLSTATEF.Ptr, pdwState)
    SetControlState(dwIDCtl, dwState)
      => ComCall(14, this.p, UInt32, dwIDCtl, CDCONTROLSTATEF, dwState)
    GetEditBoxText(dwIDCtl, ppszText)
      => ComCall(15, this.p, UInt32, dwIDCtl, UInt16.Ptr.Ptr, ppszText)
    SetEditBoxText(dwIDCtl, pszText)
      => ComCall(16, this.p, UInt32, dwIDCtl, "Str", pszText)
    GetCheckButtonState(dwIDCtl, pbChecked)
      => ComCall(17, this.p, UInt32, dwIDCtl, BOOL.Ptr, pbChecked)
    SetCheckButtonState(dwIDCtl, bChecked)
      => ComCall(18, this.p, UInt32, dwIDCtl, BOOL, bChecked)
    AddControlItem(dwIDCtl, dwIDItem, pszLabel)
      => ComCall(19, this.p, UInt32, dwIDCtl, UInt32, dwIDItem, "Str", pszLabel)
    RemoveControlItem(dwIDCtl, dwIDItem)
      => ComCall(20, this.p, UInt32, dwIDCtl, UInt32, dwIDItem)
    RemoveAllControlItems(dwIDCtl)
      => ComCall(21, this.p, UInt32, dwIDCtl)
    GetControlItemState(dwIDCtl, dwIDItem, pdwState)
      => ComCall(22, this.p, UInt32, dwIDCtl, UInt32, dwIDItem, CDCONTROLSTATEF.Ptr, pdwState)
    SetControlItemState(dwIDCtl, dwIDItem, dwState)
      => ComCall(23, this.p, UInt32, dwIDCtl, UInt32, dwIDItem, CDCONTROLSTATEF, dwState)
    GetSelectedControlItem(dwIDCtl, pdwIDItem)
      => ComCall(24, this.p, UInt32, dwIDCtl, UInt32.Ptr, pdwIDItem)
    SetSelectedControlItem(dwIDCtl, dwIDItem)
      => ComCall(25, this.p, UInt32, dwIDCtl, UInt32, dwIDItem)
    StartVisualGroup(dwIDCtl, pszLabel)
      => ComCall(26, this.p, UInt32, dwIDCtl, "Str", pszLabel)
    EndVisualGroup()
      => ComCall(27, this.p)
    MakeProminent(dwIDCtl)
      => ComCall(28, this.p, UInt32, dwIDCtl)
    SetControlItemText(dwIDCtl, dwIDItem, pszLabel)
      => ComCall(29, this.p, UInt32, dwIDCtl, UInt32, dwIDItem, "Str", pszLabel)
}
struct ASSOCIATIONLEVEL extends Int32 {
    static AL_MACHINE := 0
    static AL_EFFECTIVE := 1
    static AL_USER := 2
}
struct ASSOCIATIONTYPE extends Int32 {
    static AT_FILEEXTENSION := 0
    static AT_URLPROTOCOL := 1
    static AT_STARTMENUCLIENT := 2
    static AT_MIMETYPE := 3
}
struct IApplicationAssociationRegistration extends IUnknown {
    static IID := "{4E530B0A-E611-4C77-A3AC-9031D022281B}"
    QueryCurrentDefault(pszQuery, atQueryType, alQueryLevel, ppszAssociation)
      => ComCall(3, this.p, "Str", pszQuery, ASSOCIATIONTYPE, atQueryType, ASSOCIATIONLEVEL, alQueryLevel, PWSTR.Ptr, ppszAssociation)
    QueryAppIsDefault(pszQuery, atQueryType, alQueryLevel, pszAppRegistryName, pfDefault)
      => ComCall(4, this.p, "Str", pszQuery, ASSOCIATIONTYPE, atQueryType, ASSOCIATIONLEVEL, alQueryLevel, "Str", pszAppRegistryName, BOOL.Ptr, pfDefault)
    QueryAppIsDefaultAll(alQueryLevel, pszAppRegistryName, pfDefault)
      => ComCall(5, this.p, ASSOCIATIONLEVEL, alQueryLevel, "Str", pszAppRegistryName, BOOL.Ptr, pfDefault)
    SetAppAsDefault(pszAppRegistryName, pszSet, atSetType)
      => ComCall(6, this.p, "Str", pszAppRegistryName, "Str", pszSet, ASSOCIATIONTYPE, atSetType)
    SetAppAsDefaultAll(pszAppRegistryName)
      => ComCall(7, this.p, "Str", pszAppRegistryName)
    ClearUserAssociations()
      => ComCall(8, this.p)
}
struct DELEGATEITEMID {
    cbSize : UInt16 := this.Size
    wOuter : UInt16
    cbInner : UInt16
    rgb : UInt8[1]
}
struct IDelegateFolder extends IUnknown {
    static IID := "{ADD8BA80-002B-11D0-8F0F-00C04FD7D062}"
    SetItemAlloc(pmalloc)
      => ComCall(3, this.p, IMalloc, pmalloc)
}
struct BROWSERFRAMEOPTIONS extends Int32 {
    static BFO_NONE := 0
    static BFO_BROWSER_PERSIST_SETTINGS := 1
    static BFO_RENAME_FOLDER_OPTIONS_TOINTERNET := 2
    static BFO_BOTH_OPTIONS := 4
    static BIF_PREFER_INTERNET_SHORTCUT := 8
    static BFO_BROWSE_NO_IN_NEW_PROCESS := 16
    static BFO_ENABLE_HYPERLINK_TRACKING := 32
    static BFO_USE_IE_OFFLINE_SUPPORT := 64
    static BFO_SUBSTITUE_INTERNET_START_PAGE := 128
    static BFO_USE_IE_LOGOBANDING := 256
    static BFO_ADD_IE_TOCAPTIONBAR := 512
    static BFO_USE_DIALUP_REF := 1024
    static BFO_USE_IE_TOOLBAR := 2048
    static BFO_NO_PARENT_FOLDER_SUPPORT := 4096
    static BFO_NO_REOPEN_NEXT_RESTART := 8192
    static BFO_GO_HOME_PAGE := 16384
    static BFO_PREFER_IEPROCESS := 32768
    static BFO_SHOW_NAVIGATION_CANCELLED := 65536
    static BFO_USE_IE_STATUSBAR := 131072
    static BFO_QUERY_ALL := -1
}
struct IBrowserFrameOptions extends IUnknown {
    static IID := "{10DF43C8-1DBE-11D3-8B34-006097DF5BD4}"
    GetFrameOptions(dwMask, pdwOptions)
      => ComCall(3, this.p, UInt32, dwMask, UInt32.Ptr, pdwOptions)
}
struct NWMF extends Int32 {
    static NWMF_UNLOADING := 1
    static NWMF_USERINITED := 2
    static NWMF_FIRST := 4
    static NWMF_OVERRIDEKEY := 8
    static NWMF_SHOWHELP := 16
    static NWMF_HTMLDIALOG := 32
    static NWMF_FROMDIALOGCHILD := 64
    static NWMF_USERREQUESTED := 128
    static NWMF_USERALLOWED := 256
    static NWMF_FORCEWINDOW := 65536
    static NWMF_FORCETAB := 131072
    static NWMF_SUGGESTWINDOW := 262144
    static NWMF_SUGGESTTAB := 524288
    static NWMF_INACTIVETAB := 1048576
}
struct INewWindowManager extends IUnknown {
    static IID := "{D2BC4C84-3F72-4A52-A604-7BCBF3982CBB}"
    EvaluateNewWindow(pszUrl, pszName, pszUrlContext, pszFeatures, fReplace, dwFlags, dwUserActionTime)
      => ComCall(3, this.p, "Str", pszUrl, "Str", pszName, "Str", pszUrlContext, "Str", pszFeatures, BOOL, fReplace, UInt32, dwFlags, UInt32, dwUserActionTime)
}
struct ATTACHMENT_PROMPT extends Int32 {
    static ATTACHMENT_PROMPT_NONE := 0
    static ATTACHMENT_PROMPT_SAVE := 1
    static ATTACHMENT_PROMPT_EXEC := 2
    static ATTACHMENT_PROMPT_EXEC_OR_SAVE := 3
}
struct ATTACHMENT_ACTION extends Int32 {
    static ATTACHMENT_ACTION_CANCEL := 0
    static ATTACHMENT_ACTION_SAVE := 1
    static ATTACHMENT_ACTION_EXEC := 2
}
struct IAttachmentExecute extends IUnknown {
    static IID := "{73DB1241-1E85-4581-8E4F-A81E1D0F8C57}"
    SetClientTitle(pszTitle)
      => ComCall(3, this.p, "Str", pszTitle)
    SetClientGuid(guid)
      => ComCall(4, this.p, GUID.Ptr, guid)
    SetLocalPath(pszLocalPath)
      => ComCall(5, this.p, "Str", pszLocalPath)
    SetFileName(pszFileName)
      => ComCall(6, this.p, "Str", pszFileName)
    SetSource(pszSource)
      => ComCall(7, this.p, "Str", pszSource)
    SetReferrer(pszReferrer)
      => ComCall(8, this.p, "Str", pszReferrer)
    CheckPolicy()
      => ComCall(9, this.p)
    Prompt(hwnd1, prompt, paction)
      => ComCall(10, this.p, HWND, hwnd1, ATTACHMENT_PROMPT, prompt, ATTACHMENT_ACTION.Ptr, paction)
    Save()
      => ComCall(11, this.p)
    Execute(hwnd1, pszVerb?, phProcess?)
      => ComCall(12, this.p, HWND, hwnd1, "Str", pszVerb?, HANDLE.Ptr, phProcess?)
    SaveWithUI(hwnd1)
      => ComCall(13, this.p, HWND, hwnd1)
    ClearClientState()
      => ComCall(14, this.p)
}
struct IAttachmentExecute2 extends IAttachmentExecute {
    static IID := "{4F2B781F-A608-4543-ABF0-49C246EBBBA9}"
    SaveNoVirusCheck()
      => ComCall(15, this.p)
    SaveWithUINoVirusCheck(hwnd1)
      => ComCall(16, this.p, HWND, hwnd1)
}
struct SMDATA {
    dwMask : UInt32
    dwFlags : UInt32
    hmenu : HMENU
    hwnd : HWND
    uId : UInt32
    uIdParent : UInt32
    uIdAncestor : UInt32
    punk : IUnknown
    pidlFolder : ITEMIDLIST.Ptr
    pidlItem : ITEMIDLIST.Ptr
    psf : IShellFolder
    pvUserData : Struct.Ptr
}
struct SMINFO {
    dwMask : UInt32
    dwType : UInt32
    dwFlags : UInt32
    iIcon : Int32
}
struct SMCSHCHANGENOTIFYSTRUCT {
    lEvent : Int32
    pidl1 : ITEMIDLIST.Ptr
    pidl2 : ITEMIDLIST.Ptr
}
struct SMINFOMASK extends Int32 {
    static SMIM_TYPE := 1
    static SMIM_FLAGS := 2
    static SMIM_ICON := 4
}
struct SMINFOTYPE extends Int32 {
    static SMIT_SEPARATOR := 1
    static SMIT_STRING := 2
}
struct SMINFOFLAGS extends Int32 {
    static SMIF_ICON := 1
    static SMIF_ACCELERATOR := 2
    static SMIF_DROPTARGET := 4
    static SMIF_SUBMENU := 8
    static SMIF_CHECKED := 32
    static SMIF_DROPCASCADE := 64
    static SMIF_HIDDEN := 128
    static SMIF_DISABLED := 256
    static SMIF_TRACKPOPUP := 512
    static SMIF_DEMOTED := 1024
    static SMIF_ALTSTATE := 2048
    static SMIF_DRAGNDROP := 4096
    static SMIF_NEW := 8192
}
struct IShellMenuCallback extends IUnknown {
    static IID := "{4CA300A1-9B8D-11D1-8B22-00C04FD918D0}"
    CallbackSM(psmd, uMsg, wParam1, lParam1)
      => ComCall(3, this.p, SMDATA.Ptr, psmd, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
}
struct IShellMenu extends IUnknown {
    static IID := "{EE1F7637-E138-11D1-8379-00C04FD918D0}"
    Initialize(psmc?, uId, uIdAncestor, dwFlags)
      => ComCall(3, this.p, IShellMenuCallback, psmc?, UInt32, uId, UInt32, uIdAncestor, UInt32, dwFlags)
    GetMenuInfo(ppsmc?, puId?, puIdAncestor?, pdwFlags?)
      => ComCall(4, this.p, IShellMenuCallback.Ptr, ppsmc?, UInt32.Ptr, puId?, UInt32.Ptr, puIdAncestor?, UInt32.Ptr, pdwFlags?)
    SetShellFolder(psf?, pidlFolder?, hKey1?, dwFlags)
      => ComCall(5, this.p, IShellFolder, psf?, ITEMIDLIST.Ptr, pidlFolder?, HKEY, hKey1?, UInt32, dwFlags)
    GetShellFolder(pdwFlags, ppidl, riid, ppv)
      => ComCall(6, this.p, UInt32.Ptr, pdwFlags, ITEMIDLIST.Ptr.Ptr, ppidl, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetMenu(hmenu1?, hwnd1?, dwFlags)
      => ComCall(7, this.p, HMENU, hmenu1?, HWND, hwnd1?, UInt32, dwFlags)
    GetMenu(phmenu?, phwnd?, pdwFlags?)
      => ComCall(8, this.p, HMENU.Ptr, phmenu?, HWND.Ptr, phwnd?, UInt32.Ptr, pdwFlags?)
    InvalidateItem(psmd?, dwFlags)
      => ComCall(9, this.p, SMDATA.Ptr, psmd?, UInt32, dwFlags)
    GetState(psmd)
      => ComCall(10, this.p, SMDATA.Ptr, psmd)
    SetMenuToolbar(punk, dwFlags)
      => ComCall(11, this.p, IUnknown, punk, UInt32, dwFlags)
}
struct KF_CATEGORY extends Int32 {
    static KF_CATEGORY_VIRTUAL := 1
    static KF_CATEGORY_FIXED := 2
    static KF_CATEGORY_COMMON := 3
    static KF_CATEGORY_PERUSER := 4
}
struct KF_DEFINITION_FLAGS extends Int32 {
    static KFDF_LOCAL_REDIRECT_ONLY := 2
    static KFDF_ROAMABLE := 4
    static KFDF_PRECREATE := 8
    static KFDF_STREAM := 16
    static KFDF_PUBLISHEXPANDEDPATH := 32
    static KFDF_NO_REDIRECT_UI := 64
}
struct KF_REDIRECT_FLAGS extends Int32 {
    static KF_REDIRECT_USER_EXCLUSIVE := 1
    static KF_REDIRECT_COPY_SOURCE_DACL := 2
    static KF_REDIRECT_OWNER_USER := 4
    static KF_REDIRECT_SET_OWNER_EXPLICIT := 8
    static KF_REDIRECT_CHECK_ONLY := 16
    static KF_REDIRECT_WITH_UI := 32
    static KF_REDIRECT_UNPIN := 64
    static KF_REDIRECT_PIN := 128
    static KF_REDIRECT_COPY_CONTENTS := 512
    static KF_REDIRECT_DEL_SOURCE_CONTENTS := 1024
    static KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS := 2048
}
struct KF_REDIRECTION_CAPABILITIES extends Int32 {
    static KF_REDIRECTION_CAPABILITIES_ALLOW_ALL := 255
    static KF_REDIRECTION_CAPABILITIES_REDIRECTABLE := 1
    static KF_REDIRECTION_CAPABILITIES_DENY_ALL := 1048320
    static KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED := 256
    static KF_REDIRECTION_CAPABILITIES_DENY_POLICY := 512
    static KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS := 1024
}
struct KNOWNFOLDER_DEFINITION {
    category : KF_CATEGORY
    pszName : PWSTR
    pszDescription : PWSTR
    fidParent : GUID
    pszRelativePath : PWSTR
    pszParsingName : PWSTR
    pszTooltip : PWSTR
    pszLocalizedName : PWSTR
    pszIcon : PWSTR
    pszSecurity : PWSTR
    dwAttributes : UInt32
    kfdFlags : UInt32
    ftidType : GUID
}
struct IKnownFolder extends IUnknown {
    static IID := "{3AA7AF7E-9B36-420C-A8E3-F77D4674A488}"
    GetId(pkfid)
      => ComCall(3, this.p, GUID.Ptr, pkfid)
    GetCategory(pCategory)
      => ComCall(4, this.p, KF_CATEGORY.Ptr, pCategory)
    GetShellItem(dwFlags, riid, ppv)
      => ComCall(5, this.p, UInt32, dwFlags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPath(dwFlags, ppszPath)
      => ComCall(6, this.p, UInt32, dwFlags, PWSTR.Ptr, ppszPath)
    SetPath(dwFlags, pszPath)
      => ComCall(7, this.p, UInt32, dwFlags, "Str", pszPath)
    GetIDList(dwFlags, ppidl)
      => ComCall(8, this.p, UInt32, dwFlags, ITEMIDLIST.Ptr.Ptr, ppidl)
    GetFolderType(pftid)
      => ComCall(9, this.p, GUID.Ptr, pftid)
    GetRedirectionCapabilities(pCapabilities)
      => ComCall(10, this.p, UInt32.Ptr, pCapabilities)
    GetFolderDefinition(pKFD)
      => ComCall(11, this.p, KNOWNFOLDER_DEFINITION.Ptr, pKFD)
}
struct FFFP_MODE extends Int32 {
    static FFFP_EXACTMATCH := 0
    static FFFP_NEARESTPARENTMATCH := 1
}
struct IKnownFolderManager extends IUnknown {
    static IID := "{8BE2D872-86AA-4D47-B776-32CCA40C7018}"
    FolderIdFromCsidl(nCsidl, pfid)
      => ComCall(3, this.p, Int32, nCsidl, GUID.Ptr, pfid)
    FolderIdToCsidl(rfid, pnCsidl)
      => ComCall(4, this.p, GUID.Ptr, rfid, Int32.Ptr, pnCsidl)
    GetFolderIds(ppKFId)
      => ComCall(5, this.p, GUID.Ptr.Ptr, ppKFId, UInt32.Ptr, ppKFId.Length)
    GetFolder(rfid, ppkf)
      => ComCall(6, this.p, GUID.Ptr, rfid, IKnownFolder.Ptr, ppkf)
    GetFolderByName(pszCanonicalName, ppkf)
      => ComCall(7, this.p, "Str", pszCanonicalName, IKnownFolder.Ptr, ppkf)
    RegisterFolder(rfid, pKFD)
      => ComCall(8, this.p, GUID.Ptr, rfid, KNOWNFOLDER_DEFINITION.Ptr, pKFD)
    UnregisterFolder(rfid)
      => ComCall(9, this.p, GUID.Ptr, rfid)
    FindFolderFromPath(pszPath, mode, ppkf)
      => ComCall(10, this.p, "Str", pszPath, FFFP_MODE, mode, IKnownFolder.Ptr, ppkf)
    FindFolderFromIDList(pidl, ppkf)
      => ComCall(11, this.p, ITEMIDLIST.Ptr, pidl, IKnownFolder.Ptr, ppkf)
    Redirect(rfid, hwnd1?, flags, pszTargetPath?, pExclusion?, ppszError?)
      => ComCall(12, this.p, GUID.Ptr, rfid, HWND, hwnd1?, UInt32, flags, "Str", pszTargetPath?, UInt32, pExclusion?.Length ?? 0, GUID.Ptr, pExclusion?, PWSTR.Ptr, ppszError?)
}
struct SHARE_ROLE extends Int32 {
    static SHARE_ROLE_INVALID := -1
    static SHARE_ROLE_READER := 0
    static SHARE_ROLE_CONTRIBUTOR := 1
    static SHARE_ROLE_CO_OWNER := 2
    static SHARE_ROLE_OWNER := 3
    static SHARE_ROLE_CUSTOM := 4
    static SHARE_ROLE_MIXED := 5
}
struct DEF_SHARE_ID extends Int32 {
    static DEFSHAREID_USERS := 1
    static DEFSHAREID_PUBLIC := 2
}
struct ISharingConfigurationManager extends IUnknown {
    static IID := "{B4CD448A-9C86-4466-9201-2E62105B87AE}"
    CreateShare(dsid, role)
      => ComCall(3, this.p, DEF_SHARE_ID, dsid, SHARE_ROLE, role)
    DeleteShare(dsid)
      => ComCall(4, this.p, DEF_SHARE_ID, dsid)
    ShareExists(dsid)
      => ComCall(5, this.p, DEF_SHARE_ID, dsid)
    GetSharePermissions(dsid, pRole)
      => ComCall(6, this.p, DEF_SHARE_ID, dsid, SHARE_ROLE.Ptr, pRole)
    SharePrinters()
      => ComCall(7, this.p)
    StopSharingPrinters()
      => ComCall(8, this.p)
    ArePrintersShared()
      => ComCall(9, this.p)
}
struct IRelatedItem extends IUnknown {
    static IID := "{A73CE67A-8AB1-44F1-8D43-D2FCBF6B1CD0}"
    GetItemIDList(ppidl)
      => ComCall(3, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
    GetItem(ppsi)
      => ComCall(4, this.p, IShellItem.Ptr, ppsi)
}
struct IIdentityName extends IRelatedItem {
    static IID := "{7D903FCA-D6F9-4810-8332-946C0177E247}"
}
struct IDelegateItem extends IRelatedItem {
    static IID := "{3C5A1C94-C951-4CB7-BB6D-3B93F30CCE93}"
}
struct ICurrentItem extends IRelatedItem {
    static IID := "{240A7174-D653-4A1D-A6D3-D4943CFBFE3D}"
}
struct ITransferMediumItem extends IRelatedItem {
    static IID := "{77F295D5-2D6F-4E19-B8AE-322F3E721AB5}"
}
struct IDisplayItem extends IRelatedItem {
    static IID := "{C6FD5997-9F6B-4888-8703-94E80E8CDE3F}"
}
struct IViewStateIdentityItem extends IRelatedItem {
    static IID := "{9D264146-A94F-4195-9F9F-3BB12CE0C955}"
}
struct IPreviewItem extends IRelatedItem {
    static IID := "{36149969-0A8F-49C8-8B00-4AECB20222FB}"
}
struct IDestinationStreamFactory extends IUnknown {
    static IID := "{8A87781B-39A7-4A1F-AAB3-A39B9C34A7D9}"
    GetDestinationStream(ppstm)
      => ComCall(3, this.p, IStream.Ptr, ppstm)
}
struct ICreateProcessInputs extends IUnknown {
    static IID := "{F6EF6140-E26F-4D82-BAC4-E9BA5FD239A8}"
    GetCreateFlags(pdwCreationFlags)
      => ComCall(3, this.p, UInt32.Ptr, pdwCreationFlags)
    SetCreateFlags(dwCreationFlags)
      => ComCall(4, this.p, UInt32, dwCreationFlags)
    AddCreateFlags(dwCreationFlags)
      => ComCall(5, this.p, UInt32, dwCreationFlags)
    SetHotKey(wHotKey)
      => ComCall(6, this.p, UInt16, wHotKey)
    AddStartupFlags(dwStartupInfoFlags)
      => ComCall(7, this.p, UInt32, dwStartupInfoFlags)
    SetTitle(pszTitle)
      => ComCall(8, this.p, "Str", pszTitle)
    SetEnvironmentVariable(pszName, pszValue)
      => ComCall(9, this.p, "Str", pszName, "Str", pszValue)
}
struct ICreatingProcess extends IUnknown {
    static IID := "{C2B937A9-3110-4398-8A56-F34C6342D244}"
    OnCreating(pcpi)
      => ComCall(3, this.p, ICreateProcessInputs, pcpi)
}
struct ILaunchUIContext extends IUnknown {
    static IID := "{1791E8F6-21C7-4340-882A-A6A93E3FD73B}"
    SetAssociatedWindow(value)
      => ComCall(3, this.p, HWND, value)
    SetTabGroupingPreference(value)
      => ComCall(4, this.p, UInt32, value)
}
struct ILaunchUIContextProvider extends IUnknown {
    static IID := "{0D12C4C8-A3D9-4E24-94C1-0E20C5A956C4}"
    UpdateContext(context)
      => ComCall(3, this.p, ILaunchUIContext, context)
}
struct NMCII_FLAGS extends Int32 {
    static NMCII_NONE := 0
    static NMCII_ITEMS := 1
    static NMCII_FOLDERS := 2
}
struct NMCSAEI_FLAGS extends Int32 {
    static NMCSAEI_SELECT := 0
    static NMCSAEI_EDIT := 1
}
struct INewMenuClient extends IUnknown {
    static IID := "{DCB07FDC-3BB5-451C-90BE-966644FED7B0}"
    IncludeItems(pflags)
      => ComCall(3, this.p, Int32.Ptr, pflags)
    SelectAndEditItem(pidlItem, flags)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidlItem, Int32, flags)
}
struct IInitializeWithBindCtx extends IUnknown {
    static IID := "{71C0D2BC-726D-45CC-A6C0-2E31C1DB2159}"
    Initialize(pbc)
      => ComCall(3, this.p, IBindCtx, pbc)
}
struct IShellItemFilter extends IUnknown {
    static IID := "{2659B475-EEB8-48B7-8F07-B378810F48CF}"
    IncludeItem(psi)
      => ComCall(3, this.p, IShellItem, psi)
    GetEnumFlagsForItem(psi, pgrfFlags)
      => ComCall(4, this.p, IShellItem, psi, UInt32.Ptr, pgrfFlags)
}
struct NSTCSTYLE extends Int32 {
    static NSTCS_HASEXPANDOS := 1
    static NSTCS_HASLINES := 2
    static NSTCS_SINGLECLICKEXPAND := 4
    static NSTCS_FULLROWSELECT := 8
    static NSTCS_SPRINGEXPAND := 16
    static NSTCS_HORIZONTALSCROLL := 32
    static NSTCS_ROOTHASEXPANDO := 64
    static NSTCS_SHOWSELECTIONALWAYS := 128
    static NSTCS_NOINFOTIP := 512
    static NSTCS_EVENHEIGHT := 1024
    static NSTCS_NOREPLACEOPEN := 2048
    static NSTCS_DISABLEDRAGDROP := 4096
    static NSTCS_NOORDERSTREAM := 8192
    static NSTCS_RICHTOOLTIP := 16384
    static NSTCS_BORDER := 32768
    static NSTCS_NOEDITLABELS := 65536
    static NSTCS_TABSTOP := 131072
    static NSTCS_FAVORITESMODE := 524288
    static NSTCS_AUTOHSCROLL := 1048576
    static NSTCS_FADEINOUTEXPANDOS := 2097152
    static NSTCS_EMPTYTEXT := 4194304
    static NSTCS_CHECKBOXES := 8388608
    static NSTCS_PARTIALCHECKBOXES := 16777216
    static NSTCS_EXCLUSIONCHECKBOXES := 33554432
    static NSTCS_DIMMEDCHECKBOXES := 67108864
    static NSTCS_NOINDENTCHECKS := 134217728
    static NSTCS_ALLOWJUNCTIONS := 268435456
    static NSTCS_SHOWTABSBUTTON := 536870912
    static NSTCS_SHOWDELETEBUTTON := 1073741824
    static NSTCS_SHOWREFRESHBUTTON := -2147483648
}
struct NSTCROOTSTYLE extends Int32 {
    static NSTCRS_VISIBLE := 0
    static NSTCRS_HIDDEN := 1
    static NSTCRS_EXPANDED := 2
}
struct NSTCITEMSTATE extends Int32 {
    static NSTCIS_NONE := 0
    static NSTCIS_SELECTED := 1
    static NSTCIS_EXPANDED := 2
    static NSTCIS_BOLD := 4
    static NSTCIS_DISABLED := 8
    static NSTCIS_SELECTEDNOEXPAND := 16
}
struct NSTCGNI extends Int32 {
    static NSTCGNI_NEXT := 0
    static NSTCGNI_NEXTVISIBLE := 1
    static NSTCGNI_PREV := 2
    static NSTCGNI_PREVVISIBLE := 3
    static NSTCGNI_PARENT := 4
    static NSTCGNI_CHILD := 5
    static NSTCGNI_FIRSTVISIBLE := 6
    static NSTCGNI_LASTVISIBLE := 7
}
struct INameSpaceTreeControl extends IUnknown {
    static IID := "{028212A3-B627-47E9-8856-C14265554E4F}"
    Initialize(hwndParent, prc, nsctsFlags)
      => ComCall(3, this.p, HWND, hwndParent, RECT.Ptr, prc, UInt32, nsctsFlags)
    TreeAdvise(punk, pdwCookie)
      => ComCall(4, this.p, IUnknown, punk, UInt32.Ptr, pdwCookie)
    TreeUnadvise(dwCookie)
      => ComCall(5, this.p, UInt32, dwCookie)
    AppendRoot(psiRoot, grfEnumFlags, grfRootStyle, pif)
      => ComCall(6, this.p, IShellItem, psiRoot, UInt32, grfEnumFlags, UInt32, grfRootStyle, IShellItemFilter, pif)
    InsertRoot(iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif)
      => ComCall(7, this.p, Int32, iIndex, IShellItem, psiRoot, UInt32, grfEnumFlags, UInt32, grfRootStyle, IShellItemFilter, pif)
    RemoveRoot(psiRoot)
      => ComCall(8, this.p, IShellItem, psiRoot)
    RemoveAllRoots()
      => ComCall(9, this.p)
    GetRootItems(ppsiaRootItems)
      => ComCall(10, this.p, IShellItemArray.Ptr, ppsiaRootItems)
    SetItemState(psi, nstcisMask, nstcisFlags)
      => ComCall(11, this.p, IShellItem, psi, UInt32, nstcisMask, UInt32, nstcisFlags)
    GetItemState(psi, nstcisMask, pnstcisFlags)
      => ComCall(12, this.p, IShellItem, psi, UInt32, nstcisMask, UInt32.Ptr, pnstcisFlags)
    GetSelectedItems(psiaItems)
      => ComCall(13, this.p, IShellItemArray.Ptr, psiaItems)
    GetItemCustomState(psi, piStateNumber)
      => ComCall(14, this.p, IShellItem, psi, Int32.Ptr, piStateNumber)
    SetItemCustomState(psi, iStateNumber)
      => ComCall(15, this.p, IShellItem, psi, Int32, iStateNumber)
    EnsureItemVisible(psi)
      => ComCall(16, this.p, IShellItem, psi)
    SetTheme(pszTheme)
      => ComCall(17, this.p, "Str", pszTheme)
    GetNextItem(psi, nstcgi, ppsiNext)
      => ComCall(18, this.p, IShellItem, psi, NSTCGNI, nstcgi, IShellItem.Ptr, ppsiNext)
    HitTest(ppt, ppsiOut)
      => ComCall(19, this.p, POINT.Ptr, ppt, IShellItem.Ptr, ppsiOut)
    GetItemRect(psi, prect)
      => ComCall(20, this.p, IShellItem, psi, RECT.Ptr, prect)
    CollapseAll()
      => ComCall(21, this.p)
}
struct NSTCFOLDERCAPABILITIES extends Int32 {
    static NSTCFC_NONE := 0
    static NSTCFC_PINNEDITEMFILTERING := 1
    static NSTCFC_DELAY_REGISTER_NOTIFY := 2
}
struct INameSpaceTreeControlFolderCapabilities extends IUnknown {
    static IID := "{E9701183-E6B3-4FF2-8568-813615FEC7BE}"
    GetFolderCapabilities(nfcMask, pnfcValue)
      => ComCall(3, this.p, NSTCFOLDERCAPABILITIES, nfcMask, NSTCFOLDERCAPABILITIES.Ptr, pnfcValue)
}
struct IPreviewHandler extends IUnknown {
    static IID := "{8895B1C6-B41F-4C1C-A562-0D564250836F}"
    SetWindow(hwnd1, prc)
      => ComCall(3, this.p, HWND, hwnd1, RECT.Ptr, prc)
    SetRect(prc)
      => ComCall(4, this.p, RECT.Ptr, prc)
    DoPreview()
      => ComCall(5, this.p)
    Unload()
      => ComCall(6, this.p)
    SetFocus()
      => ComCall(7, this.p)
    QueryFocus(phwnd)
      => ComCall(8, this.p, HWND.Ptr, phwnd)
    TranslateAccelerator(pmsg)
      => ComCall(9, this.p, MSG.Ptr, pmsg)
}
struct PREVIEWHANDLERFRAMEINFO {
    haccel : HACCEL
    cAccelEntries : UInt32
}
struct IPreviewHandlerFrame extends IUnknown {
    static IID := "{FEC87AAF-35F9-447A-ADB7-20234491401A}"
    GetWindowContext(pinfo)
      => ComCall(3, this.p, PREVIEWHANDLERFRAMEINFO.Ptr, pinfo)
    TranslateAccelerator(pmsg)
      => ComCall(4, this.p, MSG.Ptr, pmsg)
}
struct EXPLORERPANESTATE extends Int32 {
    static EPS_DONTCARE := 0
    static EPS_DEFAULT_ON := 1
    static EPS_DEFAULT_OFF := 2
    static EPS_STATEMASK := 65535
    static EPS_INITIALSTATE := 65536
    static EPS_FORCE := 131072
}
struct IExplorerPaneVisibility extends IUnknown {
    static IID := "{E07010EC-BC17-44C0-97B0-46C7C95B9EDC}"
    GetPaneState(ep, peps)
      => ComCall(3, this.p, GUID.Ptr, ep, UInt32.Ptr, peps)
}
struct IContextMenuCB extends IUnknown {
    static IID := "{3409E930-5A39-11D1-83FA-00A0C90DC849}"
    CallBack(psf?, hwndOwner?, pdtobj?, uMsg, wParam1, lParam1)
      => ComCall(3, this.p, IShellFolder, psf?, HWND, hwndOwner?, IDataObject, pdtobj?, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
}
struct IDefaultExtractIconInit extends IUnknown {
    static IID := "{41DED17D-D6B3-4261-997D-88C60E4B1D58}"
    SetFlags(uFlags)
      => ComCall(3, this.p, UInt32, uFlags)
    SetKey(hkey1)
      => ComCall(4, this.p, HKEY, hkey1)
    SetNormalIcon(pszFile?, iIcon)
      => ComCall(5, this.p, "Str", pszFile?, Int32, iIcon)
    SetOpenIcon(pszFile?, iIcon)
      => ComCall(6, this.p, "Str", pszFile?, Int32, iIcon)
    SetShortcutIcon(pszFile?, iIcon)
      => ComCall(7, this.p, "Str", pszFile?, Int32, iIcon)
    SetDefaultIcon(pszFile?, iIcon)
      => ComCall(8, this.p, "Str", pszFile?, Int32, iIcon)
}
struct EXPCMDSTATE extends Int32 {
    static ECS_ENABLED := 0
    static ECS_DISABLED := 1
    static ECS_HIDDEN := 2
    static ECS_CHECKBOX := 4
    static ECS_CHECKED := 8
    static ECS_RADIOCHECK := 16
}
struct EXPCMDFLAGS extends Int32 {
    static ECF_DEFAULT := 0
    static ECF_HASSUBCOMMANDS := 1
    static ECF_HASSPLITBUTTON := 2
    static ECF_HIDELABEL := 4
    static ECF_ISSEPARATOR := 8
    static ECF_HASLUASHIELD := 16
    static ECF_SEPARATORBEFORE := 32
    static ECF_SEPARATORAFTER := 64
    static ECF_ISDROPDOWN := 128
    static ECF_TOGGLEABLE := 256
    static ECF_AUTOMENUICONS := 512
}
struct IExplorerCommand extends IUnknown {
    static IID := "{A08CE4D0-FA25-44AB-B57C-C7B1C323E0B9}"
    GetTitle(psiItemArray, ppszName)
      => ComCall(3, this.p, IShellItemArray, psiItemArray, PWSTR.Ptr, ppszName)
    GetIcon(psiItemArray, ppszIcon)
      => ComCall(4, this.p, IShellItemArray, psiItemArray, PWSTR.Ptr, ppszIcon)
    GetToolTip(psiItemArray, ppszInfotip)
      => ComCall(5, this.p, IShellItemArray, psiItemArray, PWSTR.Ptr, ppszInfotip)
    GetCanonicalName(pguidCommandName)
      => ComCall(6, this.p, GUID.Ptr, pguidCommandName)
    GetState(psiItemArray, fOkToBeSlow, pCmdState)
      => ComCall(7, this.p, IShellItemArray, psiItemArray, BOOL, fOkToBeSlow, UInt32.Ptr, pCmdState)
    Invoke(psiItemArray, pbc)
      => ComCall(8, this.p, IShellItemArray, psiItemArray, IBindCtx, pbc)
    GetFlags(pFlags)
      => ComCall(9, this.p, UInt32.Ptr, pFlags)
    EnumSubCommands(ppEnum)
      => ComCall(10, this.p, IEnumExplorerCommand.Ptr, ppEnum)
}
struct IExplorerCommandState extends IUnknown {
    static IID := "{BDDACB60-7657-47AE-8445-D23E1ACF82AE}"
    GetState(psiItemArray, fOkToBeSlow, pCmdState)
      => ComCall(3, this.p, IShellItemArray, psiItemArray, BOOL, fOkToBeSlow, UInt32.Ptr, pCmdState)
}
struct IInitializeCommand extends IUnknown {
    static IID := "{85075ACF-231F-40EA-9610-D26B7B58F638}"
    Initialize(pszCommandName, ppb)
      => ComCall(3, this.p, "Str", pszCommandName, IPropertyBag, ppb)
}
struct IEnumExplorerCommand extends IUnknown {
    static IID := "{A88826F8-186F-4987-AADE-EA0CEF8FBFE8}"
    Next(pUICommand, pceltFetched?)
      => ComCall(3, this.p, UInt32, pUICommand.Length, IExplorerCommand.Ptr, pUICommand, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumExplorerCommand.Ptr, ppenum)
}
struct IExplorerCommandProvider extends IUnknown {
    static IID := "{64961751-0835-43C0-8FFE-D57686530E64}"
    GetCommands(punkSite, riid, ppv)
      => ComCall(3, this.p, IUnknown, punkSite, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetCommand(rguidCommandId, riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, rguidCommandId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct CPVIEW extends Int32 {
    static CPVIEW_CLASSIC := 0
    static CPVIEW_ALLITEMS := 0
    static CPVIEW_CATEGORY := 1
    static CPVIEW_HOME := 1
}
struct IOpenControlPanel extends IUnknown {
    static IID := "{D11AD862-66DE-4DF4-BF6C-1F5621996AF1}"
    Open(pszName, pszPage, punkSite)
      => ComCall(3, this.p, "Str", pszName, "Str", pszPage, IUnknown, punkSite)
    GetPath(pszName, pszPath)
      => ComCall(4, this.p, "Str", pszName, PWSTR, pszPath, UInt32, pszPath.Length)
    GetCurrentView(pView)
      => ComCall(5, this.p, CPVIEW.Ptr, pView)
}
struct IFileSystemBindData extends IUnknown {
    static IID := "{01E18D10-4D8B-11D2-855D-006008059367}"
    SetFindData(pfd)
      => ComCall(3, this.p, WIN32_FIND_DATAW.Ptr, pfd)
    GetFindData(pfd)
      => ComCall(4, this.p, WIN32_FIND_DATAW.Ptr, pfd)
}
struct IFileSystemBindData2 extends IFileSystemBindData {
    static IID := "{3ACF075F-71DB-4AFA-81F0-3FC4FDF2A5B8}"
    SetFileID(liFileID)
      => ComCall(5, this.p, Int64, liFileID)
    GetFileID(pliFileID)
      => ComCall(6, this.p, Int64.Ptr, pliFileID)
    SetJunctionCLSID(clsid)
      => ComCall(7, this.p, GUID.Ptr, clsid)
    GetJunctionCLSID(pclsid)
      => ComCall(8, this.p, GUID.Ptr, pclsid)
}
struct KNOWNDESTCATEGORY extends Int32 {
    static KDC_FREQUENT := 1
    static KDC_RECENT := 2
}
struct ICustomDestinationList extends IUnknown {
    static IID := "{6332DEBF-87B5-4670-90C0-5E57B408A49E}"
    SetAppID(pszAppID)
      => ComCall(3, this.p, "Str", pszAppID)
    BeginList(pcMinSlots, riid, ppv)
      => ComCall(4, this.p, UInt32.Ptr, pcMinSlots, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    AppendCategory(pszCategory, poa)
      => ComCall(5, this.p, "Str", pszCategory, IObjectArray, poa)
    AppendKnownCategory(category)
      => ComCall(6, this.p, KNOWNDESTCATEGORY, category)
    AddUserTasks(poa)
      => ComCall(7, this.p, IObjectArray, poa)
    CommitList()
      => ComCall(8, this.p)
    GetRemovedDestinations(riid, ppv)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    DeleteList(pszAppID)
      => ComCall(10, this.p, "Str", pszAppID)
    AbortList()
      => ComCall(11, this.p)
}
struct IApplicationDestinations extends IUnknown {
    static IID := "{12337D35-94C6-48A0-BCE7-6A9C69D4D600}"
    SetAppID(pszAppID)
      => ComCall(3, this.p, "Str", pszAppID)
    RemoveDestination(punk)
      => ComCall(4, this.p, IUnknown, punk)
    RemoveAllDestinations()
      => ComCall(5, this.p)
}
struct APPDOCLISTTYPE extends Int32 {
    static ADLT_RECENT := 0
    static ADLT_FREQUENT := 1
}
struct IApplicationDocumentLists extends IUnknown {
    static IID := "{3C594F9F-9F30-47A1-979A-C9E83D3D0A06}"
    SetAppID(pszAppID)
      => ComCall(3, this.p, "Str", pszAppID)
    GetList(listtype, cItemsDesired, riid, ppv)
      => ComCall(4, this.p, APPDOCLISTTYPE, listtype, UInt32, cItemsDesired, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IObjectWithAppUserModelID extends IUnknown {
    static IID := "{36DB0196-9665-46D1-9BA7-D3709EECF9ED}"
    SetAppID(pszAppID)
      => ComCall(3, this.p, "Str", pszAppID)
    GetAppID(ppszAppID)
      => ComCall(4, this.p, PWSTR.Ptr, ppszAppID)
}
struct IObjectWithPackageFullName extends IUnknown {
    static IID := "{ED2AA515-602F-469C-A130-CE69FD0FA878}"
    GetPackageFullName(packageFullName)
      => ComCall(3, this.p, PWSTR.Ptr, packageFullName)
}
struct IObjectWithProgID extends IUnknown {
    static IID := "{71E806FB-8DEE-46FC-BF8C-7748A8A1AE13}"
    SetProgID(pszProgID)
      => ComCall(3, this.p, "Str", pszProgID)
    GetProgID(ppszProgID)
      => ComCall(4, this.p, PWSTR.Ptr, ppszProgID)
}
struct IUpdateIDList extends IUnknown {
    static IID := "{6589B6D2-5F8D-4B9E-B7E0-23CDD9717D8C}"
    Update(pbc?, pidlIn, ppidlOut)
      => ComCall(3, this.p, IBindCtx, pbc?, ITEMIDLIST.Ptr, pidlIn, ITEMIDLIST.Ptr.Ptr, ppidlOut)
}
struct DESKTOP_SLIDESHOW_OPTIONS extends Int32 {
    static DSO_SHUFFLEIMAGES := 1
}
struct DESKTOP_SLIDESHOW_STATE extends Int32 {
    static DSS_ENABLED := 1
    static DSS_SLIDESHOW := 2
    static DSS_DISABLED_BY_REMOTE_SESSION := 4
}
struct DESKTOP_SLIDESHOW_DIRECTION extends Int32 {
    static DSD_FORWARD := 0
    static DSD_BACKWARD := 1
}
struct DESKTOP_WALLPAPER_POSITION extends Int32 {
    static DWPOS_CENTER := 0
    static DWPOS_TILE := 1
    static DWPOS_STRETCH := 2
    static DWPOS_FIT := 3
    static DWPOS_FILL := 4
    static DWPOS_SPAN := 5
}
struct IDesktopWallpaper extends IUnknown {
    static IID := "{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}"
    SetWallpaper(monitorID, wallpaper)
      => ComCall(3, this.p, "Str", monitorID, "Str", wallpaper)
    GetWallpaper(monitorID, wallpaper)
      => ComCall(4, this.p, "Str", monitorID, PWSTR.Ptr, wallpaper)
    GetMonitorDevicePathAt(monitorIndex, monitorID)
      => ComCall(5, this.p, UInt32, monitorIndex, PWSTR.Ptr, monitorID)
    GetMonitorDevicePathCount(count)
      => ComCall(6, this.p, UInt32.Ptr, count)
    GetMonitorRECT(monitorID, displayRect)
      => ComCall(7, this.p, "Str", monitorID, RECT.Ptr, displayRect)
    SetBackgroundColor(color)
      => ComCall(8, this.p, COLORREF, color)
    GetBackgroundColor(color)
      => ComCall(9, this.p, COLORREF.Ptr, color)
    SetPosition(position)
      => ComCall(10, this.p, DESKTOP_WALLPAPER_POSITION, position)
    GetPosition(position)
      => ComCall(11, this.p, DESKTOP_WALLPAPER_POSITION.Ptr, position)
    SetSlideshow(items)
      => ComCall(12, this.p, IShellItemArray, items)
    GetSlideshow(items)
      => ComCall(13, this.p, IShellItemArray.Ptr, items)
    SetSlideshowOptions(options, slideshowTick)
      => ComCall(14, this.p, DESKTOP_SLIDESHOW_OPTIONS, options, UInt32, slideshowTick)
    GetSlideshowOptions(options, slideshowTick)
      => ComCall(15, this.p, DESKTOP_SLIDESHOW_OPTIONS.Ptr, options, UInt32.Ptr, slideshowTick)
    AdvanceSlideshow(monitorID, direction)
      => ComCall(16, this.p, "Str", monitorID, DESKTOP_SLIDESHOW_DIRECTION, direction)
    GetStatus(state)
      => ComCall(17, this.p, DESKTOP_SLIDESHOW_STATE.Ptr, state)
    Enable(enable)
      => ComCall(18, this.p, BOOL, enable)
}
struct HOMEGROUPSHARINGCHOICES extends Int32 {
    static HGSC_NONE := 0
    static HGSC_MUSICLIBRARY := 1
    static HGSC_PICTURESLIBRARY := 2
    static HGSC_VIDEOSLIBRARY := 4
    static HGSC_DOCUMENTSLIBRARY := 8
    static HGSC_PRINTERS := 16
}
struct IHomeGroup extends IUnknown {
    static IID := "{7A3BD1D9-35A9-4FB3-A467-F48CAC35E2D0}"
    IsMember(member)
      => ComCall(3, this.p, BOOL.Ptr, member)
    ShowSharingWizard(owner, sharingchoices)
      => ComCall(4, this.p, HWND, owner, HOMEGROUPSHARINGCHOICES.Ptr, sharingchoices)
}
struct IInitializeWithPropertyStore extends IUnknown {
    static IID := "{C3E12EB5-7D8D-44F8-B6DD-0E77B34D6DE4}"
    Initialize(pps)
      => ComCall(3, this.p, IPropertyStore, pps)
}
struct IOpenSearchSource extends IUnknown {
    static IID := "{F0EE7333-E6FC-479B-9F25-A860C234A38E}"
    GetResults(hwnd1, pszQuery, dwStartIndex, dwCount, riid, ppv)
      => ComCall(3, this.p, HWND, hwnd1, "Str", pszQuery, UInt32, dwStartIndex, UInt32, dwCount, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct LIBRARYFOLDERFILTER extends Int32 {
    static LFF_FORCEFILESYSTEM := 1
    static LFF_STORAGEITEMS := 2
    static LFF_ALLITEMS := 3
}
struct LIBRARYOPTIONFLAGS extends Int32 {
    static LOF_DEFAULT := 0
    static LOF_PINNEDTONAVPANE := 1
    static LOF_MASK_ALL := 1
}
struct DEFAULTSAVEFOLDERTYPE extends Int32 {
    static DSFT_DETECT := 1
    static DSFT_PRIVATE := 2
    static DSFT_PUBLIC := 3
}
struct LIBRARYSAVEFLAGS extends Int32 {
    static LSF_FAILIFTHERE := 0
    static LSF_OVERRIDEEXISTING := 1
    static LSF_MAKEUNIQUENAME := 2
}
struct IShellLibrary extends IUnknown {
    static IID := "{11A66EFA-382E-451A-9234-1E0E12EF3085}"
    LoadLibraryFromItem(psiLibrary, grfMode)
      => ComCall(3, this.p, IShellItem, psiLibrary, UInt32, grfMode)
    LoadLibraryFromKnownFolder(kfidLibrary, grfMode)
      => ComCall(4, this.p, GUID.Ptr, kfidLibrary, UInt32, grfMode)
    AddFolder(psiLocation)
      => ComCall(5, this.p, IShellItem, psiLocation)
    RemoveFolder(psiLocation)
      => ComCall(6, this.p, IShellItem, psiLocation)
    GetFolders(lff, riid, ppv)
      => ComCall(7, this.p, LIBRARYFOLDERFILTER, lff, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ResolveFolder(psiFolderToResolve, dwTimeout, riid, ppv)
      => ComCall(8, this.p, IShellItem, psiFolderToResolve, UInt32, dwTimeout, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetDefaultSaveFolder(dsft, riid, ppv)
      => ComCall(9, this.p, DEFAULTSAVEFOLDERTYPE, dsft, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetDefaultSaveFolder(dsft, psi)
      => ComCall(10, this.p, DEFAULTSAVEFOLDERTYPE, dsft, IShellItem, psi)
    GetOptions(plofOptions)
      => ComCall(11, this.p, LIBRARYOPTIONFLAGS.Ptr, plofOptions)
    SetOptions(lofMask, lofOptions)
      => ComCall(12, this.p, LIBRARYOPTIONFLAGS, lofMask, LIBRARYOPTIONFLAGS, lofOptions)
    GetFolderType(pftid)
      => ComCall(13, this.p, GUID.Ptr, pftid)
    SetFolderType(ftid)
      => ComCall(14, this.p, GUID.Ptr, ftid)
    GetIcon(ppszIcon)
      => ComCall(15, this.p, PWSTR.Ptr, ppszIcon)
    SetIcon(pszIcon)
      => ComCall(16, this.p, "Str", pszIcon)
    Commit()
      => ComCall(17, this.p)
    Save(psiFolderToSaveIn, pszLibraryName, lsf, ppsiSavedTo)
      => ComCall(18, this.p, IShellItem, psiFolderToSaveIn, "Str", pszLibraryName, LIBRARYSAVEFLAGS, lsf, IShellItem.Ptr, ppsiSavedTo)
    SaveInKnownFolder(kfidToSaveIn, pszLibraryName, lsf, ppsiSavedTo)
      => ComCall(19, this.p, GUID.Ptr, kfidToSaveIn, "Str", pszLibraryName, LIBRARYSAVEFLAGS, lsf, IShellItem.Ptr, ppsiSavedTo)
}
struct DEFAULT_FOLDER_MENU_RESTRICTIONS extends Int32 {
    static DFMR_DEFAULT := 0
    static DFMR_NO_STATIC_VERBS := 8
    static DFMR_STATIC_VERBS_ONLY := 16
    static DFMR_NO_RESOURCE_VERBS := 32
    static DFMR_OPTIN_HANDLERS_ONLY := 64
    static DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY := 128
    static DFMR_USE_SPECIFIED_HANDLERS := 256
    static DFMR_USE_SPECIFIED_VERBS := 512
    static DFMR_NO_ASYNC_VERBS := 1024
    static DFMR_NO_NATIVECPU_VERBS := 2048
    static DFMR_NO_NONWOW_VERBS := 4096
}
struct IDefaultFolderMenuInitialize extends IUnknown {
    static IID := "{7690AA79-F8FC-4615-A327-36F7D18F5D91}"
    Initialize(hwnd1, pcmcb?, pidlFolder?, psf?, apidl, punkAssociation?, cKeys, aKeys?)
      => ComCall(3, this.p, HWND, hwnd1, IContextMenuCB, pcmcb?, ITEMIDLIST.Ptr, pidlFolder?, IShellFolder, psf?, UInt32, apidl.Length, ITEMIDLIST.Ptr.Ptr, apidl, IUnknown, punkAssociation?, UInt32, cKeys, HKEY.Ptr, aKeys?)
    SetMenuRestrictions(dfmrValues)
      => ComCall(4, this.p, DEFAULT_FOLDER_MENU_RESTRICTIONS, dfmrValues)
    GetMenuRestrictions(dfmrMask, pdfmrValues)
      => ComCall(5, this.p, DEFAULT_FOLDER_MENU_RESTRICTIONS, dfmrMask, DEFAULT_FOLDER_MENU_RESTRICTIONS.Ptr, pdfmrValues)
    SetHandlerClsid(rclsid)
      => ComCall(6, this.p, GUID.Ptr, rclsid)
}
struct ACTIVATEOPTIONS extends Int32 {
    static AO_NONE := 0
    static AO_DESIGNMODE := 1
    static AO_NOERRORUI := 2
    static AO_NOSPLASHSCREEN := 4
    static AO_PRELAUNCH := 33554432
}
struct IApplicationActivationManager extends IUnknown {
    static IID := "{2E941141-7F97-4756-BA1D-9DECDE894A3D}"
    ActivateApplication(appUserModelId, arguments, options, processId)
      => ComCall(3, this.p, "Str", appUserModelId, "Str", arguments, ACTIVATEOPTIONS, options, UInt32.Ptr, processId)
    ActivateForFile(appUserModelId, itemArray, verb, processId)
      => ComCall(4, this.p, "Str", appUserModelId, IShellItemArray, itemArray, "Str", verb, UInt32.Ptr, processId)
    ActivateForProtocol(appUserModelId, itemArray, processId)
      => ComCall(5, this.p, "Str", appUserModelId, IShellItemArray, itemArray, UInt32.Ptr, processId)
}
struct IVirtualDesktopManager extends IUnknown {
    static IID := "{A5CD92FF-29BE-454C-8D04-D82879FB3F1B}"
    IsWindowOnCurrentVirtualDesktop(topLevelWindow, onCurrentDesktop)
      => ComCall(3, this.p, HWND, topLevelWindow, BOOL.Ptr, onCurrentDesktop)
    GetWindowDesktopId(topLevelWindow, desktopId)
      => ComCall(4, this.p, HWND, topLevelWindow, GUID.Ptr, desktopId)
    MoveWindowToDesktop(topLevelWindow, desktopId)
      => ComCall(5, this.p, HWND, topLevelWindow, GUID.Ptr, desktopId)
}
struct LIBRARYMANAGEDIALOGOPTIONS extends Int32 {
    static LMD_DEFAULT := 0
    static LMD_ALLOWUNINDEXABLENETWORKLOCATIONS := 1
}
struct IAssocHandlerInvoker extends IUnknown {
    static IID := "{92218CAB-ECAA-4335-8133-807FD234C2EE}"
    SupportsSelection()
      => ComCall(3, this.p)
    Invoke()
      => ComCall(4, this.p)
}
struct AHTYPE extends Int32 {
    static AHTYPE_UNDEFINED := 0
    static AHTYPE_USER_APPLICATION := 8
    static AHTYPE_ANY_APPLICATION := 16
    static AHTYPE_MACHINEDEFAULT := 32
    static AHTYPE_PROGID := 64
    static AHTYPE_APPLICATION := 128
    static AHTYPE_CLASS_APPLICATION := 256
    static AHTYPE_ANY_PROGID := 512
}
struct IAssocHandler extends IUnknown {
    static IID := "{F04061AC-1659-4A3F-A954-775AA57FC083}"
    GetName(ppsz)
      => ComCall(3, this.p, PWSTR.Ptr, ppsz)
    GetUIName(ppsz)
      => ComCall(4, this.p, PWSTR.Ptr, ppsz)
    GetIconLocation(ppszPath, pIndex)
      => ComCall(5, this.p, PWSTR.Ptr, ppszPath, Int32.Ptr, pIndex)
    IsRecommended()
      => ComCall(6, this.p)
    MakeDefault(pszDescription)
      => ComCall(7, this.p, "Str", pszDescription)
    Invoke(pdo)
      => ComCall(8, this.p, IDataObject, pdo)
    CreateInvoker(pdo, ppInvoker)
      => ComCall(9, this.p, IDataObject, pdo, IAssocHandlerInvoker.Ptr, ppInvoker)
}
struct IEnumAssocHandlers extends IUnknown {
    static IID := "{973810AE-9599-4B88-9E4D-6EE98C9552DA}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, IAssocHandler.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
}
struct ASSOC_FILTER extends Int32 {
    static ASSOC_FILTER_NONE := 0
    static ASSOC_FILTER_RECOMMENDED := 1
}
struct IDataObjectProvider extends IUnknown {
    static IID := "{3D25F6D6-4B2A-433C-9184-7C33AD35D001}"
    GetDataObject(dataObject)
      => ComCall(3, this.p, IDataObject.Ptr, dataObject)
    SetDataObject(dataObject)
      => ComCall(4, this.p, IDataObject, dataObject)
}
struct IDataTransferManagerInterop extends IUnknown {
    static IID := "{3A3DCD6C-3EAB-43DC-BCDE-45671CE800C8}"
    GetForWindow(appWindow, riid, dataTransferManager)
      => ComCall(3, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, dataTransferManager)
    ShowShareUIForWindow(appWindow)
      => ComCall(4, this.p, HWND, appWindow)
}
struct IFrameworkInputPaneHandler extends IUnknown {
    static IID := "{226C537B-1E76-4D9E-A760-33DB29922F18}"
    Showing(prcInputPaneScreenLocation, fEnsureFocusedElementInView)
      => ComCall(3, this.p, RECT.Ptr, prcInputPaneScreenLocation, BOOL, fEnsureFocusedElementInView)
    Hiding(fEnsureFocusedElementInView)
      => ComCall(4, this.p, BOOL, fEnsureFocusedElementInView)
}
struct IFrameworkInputPane extends IUnknown {
    static IID := "{5752238B-24F0-495A-82F1-2FD593056796}"
    Advise(pWindow, pHandler, pdwCookie)
      => ComCall(3, this.p, IUnknown, pWindow, IFrameworkInputPaneHandler, pHandler, UInt32.Ptr, pdwCookie)
    AdviseWithHWND(hwnd1, pHandler, pdwCookie)
      => ComCall(4, this.p, HWND, hwnd1, IFrameworkInputPaneHandler, pHandler, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(5, this.p, UInt32, dwCookie)
    Location(prcInputPaneScreenLocation)
      => ComCall(6, this.p, RECT.Ptr, prcInputPaneScreenLocation)
}
struct MONITOR_APP_VISIBILITY extends Int32 {
    static MAV_UNKNOWN := 0
    static MAV_NO_APP_VISIBLE := 1
    static MAV_APP_VISIBLE := 2
}
struct IAppVisibilityEvents extends IUnknown {
    static IID := "{6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}"
    AppVisibilityOnMonitorChanged(hMonitor1, previousMode, currentMode)
      => ComCall(3, this.p, HMONITOR, hMonitor1, MONITOR_APP_VISIBILITY, previousMode, MONITOR_APP_VISIBILITY, currentMode)
    LauncherVisibilityChange(currentVisibleState)
      => ComCall(4, this.p, BOOL, currentVisibleState)
}
struct IAppVisibility extends IUnknown {
    static IID := "{2246EA2D-CAEA-4444-A3C4-6DE827E44313}"
    GetAppVisibilityOnMonitor(hMonitor1, pMode)
      => ComCall(3, this.p, HMONITOR, hMonitor1, MONITOR_APP_VISIBILITY.Ptr, pMode)
    IsLauncherVisible(pfVisible)
      => ComCall(4, this.p, BOOL.Ptr, pfVisible)
    Advise(pCallback, pdwCookie)
      => ComCall(5, this.p, IAppVisibilityEvents, pCallback, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(6, this.p, UInt32, dwCookie)
}
struct PACKAGE_EXECUTION_STATE extends Int32 {
    static PES_UNKNOWN := 0
    static PES_RUNNING := 1
    static PES_SUSPENDING := 2
    static PES_SUSPENDED := 3
    static PES_TERMINATED := 4
}
struct IPackageExecutionStateChangeNotification extends IUnknown {
    static IID := "{1BB12A62-2AD8-432B-8CCF-0C2C52AFCD5B}"
    OnStateChanged(pszPackageFullName, pesNewState)
      => ComCall(3, this.p, "Str", pszPackageFullName, PACKAGE_EXECUTION_STATE, pesNewState)
}
struct IPackageDebugSettings extends IUnknown {
    static IID := "{F27C3930-8029-4AD1-94E3-3DBA417810C1}"
    EnableDebugging(packageFullName, debuggerCommandLine?, environment?)
      => ComCall(3, this.p, "Str", packageFullName, "Str", debuggerCommandLine?, "Str", environment?)
    DisableDebugging(packageFullName)
      => ComCall(4, this.p, "Str", packageFullName)
    Suspend(packageFullName)
      => ComCall(5, this.p, "Str", packageFullName)
    Resume(packageFullName)
      => ComCall(6, this.p, "Str", packageFullName)
    TerminateAllProcesses(packageFullName)
      => ComCall(7, this.p, "Str", packageFullName)
    SetTargetSessionId(sessionId)
      => ComCall(8, this.p, UInt32, sessionId)
    EnumerateBackgroundTasks(packageFullName, taskCount, taskIds, taskNames)
      => ComCall(9, this.p, "Str", packageFullName, UInt32.Ptr, taskCount, GUID.Ptr.Ptr, taskIds, PWSTR.Ptr.Ptr, taskNames)
    ActivateBackgroundTask(taskId)
      => ComCall(10, this.p, GUID.Ptr, taskId)
    StartServicing(packageFullName)
      => ComCall(11, this.p, "Str", packageFullName)
    StopServicing(packageFullName)
      => ComCall(12, this.p, "Str", packageFullName)
    StartSessionRedirection(packageFullName, sessionId)
      => ComCall(13, this.p, "Str", packageFullName, UInt32, sessionId)
    StopSessionRedirection(packageFullName)
      => ComCall(14, this.p, "Str", packageFullName)
    GetPackageExecutionState(packageFullName, packageExecutionState)
      => ComCall(15, this.p, "Str", packageFullName, PACKAGE_EXECUTION_STATE.Ptr, packageExecutionState)
    RegisterForPackageStateChanges(packageFullName, pPackageExecutionStateChangeNotification, pdwCookie)
      => ComCall(16, this.p, "Str", packageFullName, IPackageExecutionStateChangeNotification, pPackageExecutionStateChangeNotification, UInt32.Ptr, pdwCookie)
    UnregisterForPackageStateChanges(dwCookie)
      => ComCall(17, this.p, UInt32, dwCookie)
}
struct IPackageDebugSettings2 extends IPackageDebugSettings {
    static IID := "{6E3194BB-AB82-4D22-93F5-FABDA40E7B16}"
    EnumerateApps(packageFullName, appCount, appUserModelIds, appDisplayNames)
      => ComCall(18, this.p, "Str", packageFullName, UInt32.Ptr, appCount, PWSTR.Ptr.Ptr, appUserModelIds, PWSTR.Ptr.Ptr, appDisplayNames)
}
struct ISuspensionDependencyManager extends IUnknown {
    static IID := "{52B83A42-2543-416A-81D9-C0DE7969C8B3}"
    RegisterAsChild(processHandle)
      => ComCall(3, this.p, HANDLE, processHandle)
    GroupChildWithParent(childProcessHandle)
      => ComCall(4, this.p, HANDLE, childProcessHandle)
    UngroupChildFromParent(childProcessHandle)
      => ComCall(5, this.p, HANDLE, childProcessHandle)
}
struct AHE_TYPE extends Int32 {
    static AHE_DESKTOP := 0
    static AHE_IMMERSIVE := 1
}
struct IExecuteCommandApplicationHostEnvironment extends IUnknown {
    static IID := "{18B21AA9-E184-4FF0-9F5E-F882D03771B3}"
    GetValue(pahe)
      => ComCall(3, this.p, AHE_TYPE.Ptr, pahe)
}
struct EC_HOST_UI_MODE extends Int32 {
    static ECHUIM_DESKTOP := 0
    static ECHUIM_IMMERSIVE := 1
    static ECHUIM_SYSTEM_LAUNCHER := 2
}
struct IExecuteCommandHost extends IUnknown {
    static IID := "{4B6832A2-5F04-4C9D-B89D-727A15D103E7}"
    GetUIMode(pUIMode)
      => ComCall(3, this.p, EC_HOST_UI_MODE.Ptr, pUIMode)
}
struct APPLICATION_VIEW_STATE extends Int32 {
    static AVS_FULLSCREEN_LANDSCAPE := 0
    static AVS_FILLED := 1
    static AVS_SNAPPED := 2
    static AVS_FULLSCREEN_PORTRAIT := 3
}
struct EDGE_GESTURE_KIND extends Int32 {
    static EGK_TOUCH := 0
    static EGK_KEYBOARD := 1
    static EGK_MOUSE := 2
}
struct IApplicationDesignModeSettings extends IUnknown {
    static IID := "{2A3DEE9A-E31D-46D6-8508-BCC597DB3557}"
    SetNativeDisplaySize(nativeDisplaySizePixels)
      => ComCall(3, this.p, SIZE, nativeDisplaySizePixels)
    SetScaleFactor(scaleFactor)
      => ComCall(4, this.p, DEVICE_SCALE_FACTOR, scaleFactor)
    SetApplicationViewState(viewState)
      => ComCall(5, this.p, APPLICATION_VIEW_STATE, viewState)
    ComputeApplicationSize(applicationSizePixels)
      => ComCall(6, this.p, SIZE.Ptr, applicationSizePixels)
    IsApplicationViewStateSupported(viewState, nativeDisplaySizePixels, scaleFactor, supported)
      => ComCall(7, this.p, APPLICATION_VIEW_STATE, viewState, SIZE, nativeDisplaySizePixels, DEVICE_SCALE_FACTOR, scaleFactor, BOOL.Ptr, supported)
    TriggerEdgeGesture(edgeGestureKind)
      => ComCall(8, this.p, EDGE_GESTURE_KIND, edgeGestureKind)
}
struct NATIVE_DISPLAY_ORIENTATION extends Int32 {
    static NDO_LANDSCAPE := 0
    static NDO_PORTRAIT := 1
}
struct APPLICATION_VIEW_ORIENTATION extends Int32 {
    static AVO_LANDSCAPE := 0
    static AVO_PORTRAIT := 1
}
struct ADJACENT_DISPLAY_EDGES extends Int32 {
    static ADE_NONE := 0
    static ADE_LEFT := 1
    static ADE_RIGHT := 2
}
struct APPLICATION_VIEW_MIN_WIDTH extends Int32 {
    static AVMW_DEFAULT := 0
    static AVMW_320 := 1
    static AVMW_500 := 2
}
struct IApplicationDesignModeSettings2 extends IApplicationDesignModeSettings {
    static IID := "{490514E1-675A-4D6E-A58D-E54901B4CA2F}"
    SetNativeDisplayOrientation(nativeDisplayOrientation)
      => ComCall(9, this.p, NATIVE_DISPLAY_ORIENTATION, nativeDisplayOrientation)
    SetApplicationViewOrientation(viewOrientation)
      => ComCall(10, this.p, APPLICATION_VIEW_ORIENTATION, viewOrientation)
    SetAdjacentDisplayEdges(adjacentDisplayEdges)
      => ComCall(11, this.p, ADJACENT_DISPLAY_EDGES, adjacentDisplayEdges)
    SetIsOnLockScreen(isOnLockScreen)
      => ComCall(12, this.p, BOOL, isOnLockScreen)
    SetApplicationViewMinWidth(viewMinWidth)
      => ComCall(13, this.p, APPLICATION_VIEW_MIN_WIDTH, viewMinWidth)
    GetApplicationSizeBounds(minApplicationSizePixels, maxApplicationSizePixels)
      => ComCall(14, this.p, SIZE.Ptr, minApplicationSizePixels, SIZE.Ptr, maxApplicationSizePixels)
    GetApplicationViewOrientation(applicationSizePixels, viewOrientation)
      => ComCall(15, this.p, SIZE, applicationSizePixels, APPLICATION_VIEW_ORIENTATION.Ptr, viewOrientation)
}
struct ILaunchTargetMonitor extends IUnknown {
    static IID := "{266FBC7E-490D-46ED-A96B-2274DB252003}"
    GetMonitor(monitor)
      => ComCall(3, this.p, HMONITOR.Ptr, monitor)
}
struct APPLICATION_VIEW_SIZE_PREFERENCE extends Int32 {
    static AVSP_DEFAULT := 0
    static AVSP_USE_LESS := 1
    static AVSP_USE_HALF := 2
    static AVSP_USE_MORE := 3
    static AVSP_USE_MINIMUM := 4
    static AVSP_USE_NONE := 5
    static AVSP_CUSTOM := 6
}
struct ILaunchSourceViewSizePreference extends IUnknown {
    static IID := "{E5AA01F7-1FB8-4830-8720-4E6734CBD5F3}"
    GetSourceViewToPosition(hwnd)
      => ComCall(3, this.p, HWND.Ptr, hwnd)
    GetSourceViewSizePreference(sourceSizeAfterLaunch)
      => ComCall(4, this.p, APPLICATION_VIEW_SIZE_PREFERENCE.Ptr, sourceSizeAfterLaunch)
}
struct ILaunchTargetViewSizePreference extends IUnknown {
    static IID := "{2F0666C6-12F7-4360-B511-A394A0553725}"
    GetTargetViewSizePreference(targetSizeOnLaunch)
      => ComCall(3, this.p, APPLICATION_VIEW_SIZE_PREFERENCE.Ptr, targetSizeOnLaunch)
}
struct ILaunchSourceAppUserModelId extends IUnknown {
    static IID := "{989191AC-28FF-4CF0-9584-E0D078BC2396}"
    GetAppUserModelId(launchingApp)
      => ComCall(3, this.p, PWSTR.Ptr, launchingApp)
}
struct IInitializeWithWindow extends IUnknown {
    static IID := "{3E68D4BD-7135-4D10-8018-9FB6D9F33FA1}"
    Initialize(hwnd1)
      => ComCall(3, this.p, HWND, hwnd1)
}
struct IHandlerInfo extends IUnknown {
    static IID := "{997706EF-F880-453B-8118-39E1A2D2655A}"
    GetApplicationDisplayName(value)
      => ComCall(3, this.p, PWSTR.Ptr, value)
    GetApplicationPublisher(value)
      => ComCall(4, this.p, PWSTR.Ptr, value)
    GetApplicationIconReference(value)
      => ComCall(5, this.p, PWSTR.Ptr, value)
}
struct IHandlerInfo2 extends IHandlerInfo {
    static IID := "{31CCA04C-04D3-4EA9-90DE-97B15E87A532}"
    GetApplicationId(value)
      => ComCall(6, this.p, PWSTR.Ptr, value)
}
struct IHandlerActivationHost extends IUnknown {
    static IID := "{35094A87-8BB1-4237-96C6-C417EEBDB078}"
    BeforeCoCreateInstance(clsidHandler, itemsBeingActivated, handlerInfo)
      => ComCall(3, this.p, GUID.Ptr, clsidHandler, IShellItemArray, itemsBeingActivated, IHandlerInfo, handlerInfo)
    BeforeCreateProcess(applicationPath, commandLine, handlerInfo)
      => ComCall(4, this.p, "Str", applicationPath, "Str", commandLine, IHandlerInfo, handlerInfo)
}
struct IAppActivationUIInfo extends IUnknown {
    static IID := "{ABAD189D-9FA3-4278-B3CA-8CA448A88DCB}"
    GetMonitor(value)
      => ComCall(3, this.p, HMONITOR.Ptr, value)
    GetInvokePoint(value)
      => ComCall(4, this.p, POINT.Ptr, value)
    GetShowCommand(value)
      => ComCall(5, this.p, Int32.Ptr, value)
    GetShowUI(value)
      => ComCall(6, this.p, BOOL.Ptr, value)
    GetKeyState(value)
      => ComCall(7, this.p, UInt32.Ptr, value)
}
struct FLYOUT_PLACEMENT extends Int32 {
    static FP_DEFAULT := 0
    static FP_ABOVE := 1
    static FP_BELOW := 2
    static FP_LEFT := 3
    static FP_RIGHT := 4
}
struct IContactManagerInterop extends IUnknown {
    static IID := "{99EACBA7-E073-43B6-A896-55AFE48A0833}"
    ShowContactCardForWindow(appWindow, contact, selection, preferredPlacement)
      => ComCall(3, this.p, HWND, appWindow, IUnknown, contact, RECT.Ptr, selection, FLYOUT_PLACEMENT, preferredPlacement)
}
struct IShellIconOverlayIdentifier extends IUnknown {
    static IID := "{0C6C4200-C589-11D0-999A-00C04FD655E1}"
    IsMemberOf(pwszPath, dwAttrib)
      => ComCall(3, this.p, "Str", pwszPath, UInt32, dwAttrib)
    GetOverlayInfo(pwszIconFile, pIndex, pdwFlags)
      => ComCall(4, this.p, PWSTR, pwszIconFile, Int32, pwszIconFile.Length, Int32.Ptr, pIndex, UInt32.Ptr, pdwFlags)
    GetPriority(pPriority)
      => ComCall(5, this.p, Int32.Ptr, pPriority)
}
struct BANNER_NOTIFICATION_EVENT extends Int32 {
    static BNE_Rendered := 0
    static BNE_Hovered := 1
    static BNE_Closed := 2
    static BNE_Dismissed := 3
    static BNE_Button1Clicked := 4
    static BNE_Button2Clicked := 5
}
struct BANNER_NOTIFICATION {
    event : BANNER_NOTIFICATION_EVENT
    providerIdentity : PWSTR
    contentId : PWSTR
}
struct IBannerNotificationHandler extends IUnknown {
    static IID := "{8D7B2BA7-DB05-46A8-823C-D2B6DE08EE91}"
    OnBannerEvent(notification)
      => ComCall(3, this.p, BANNER_NOTIFICATION.Ptr, notification)
}
struct SORT_ORDER_TYPE extends Int32 {
    static SOT_DEFAULT := 0
    static SOT_IGNORE_FOLDERNESS := 1
}
struct ISortColumnArray extends IUnknown {
    static IID := "{6DFC60FB-F2E9-459B-BEB5-288F1A7C7D54}"
    GetCount(columnCount)
      => ComCall(3, this.p, UInt32.Ptr, columnCount)
    GetAt(index, sortcolumn)
      => ComCall(4, this.p, UInt32, index, SORTCOLUMN.Ptr, sortcolumn)
    GetSortType(type)
      => ComCall(5, this.p, SORT_ORDER_TYPE.Ptr, type)
}
struct IPropertyKeyStore extends IUnknown {
    static IID := "{75BD59AA-F23B-4963-ABA4-0B355752A91B}"
    GetKeyCount(keyCount)
      => ComCall(3, this.p, Int32.Ptr, keyCount)
    GetKeyAt(index, pkey)
      => ComCall(4, this.p, Int32, index, PROPERTYKEY.Ptr, pkey)
    AppendKey(key)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, key)
    DeleteKey(index)
      => ComCall(6, this.p, Int32, index)
    IsKeyInStore(key)
      => ComCall(7, this.p, PROPERTYKEY.Ptr, key)
    RemoveKey(key)
      => ComCall(8, this.p, PROPERTYKEY.Ptr, key)
}
struct IQueryCodePage extends IUnknown {
    static IID := "{C7B236CE-EE80-11D0-985F-006008059382}"
    GetCodePage(puiCodePage)
      => ComCall(3, this.p, UInt32.Ptr, puiCodePage)
    SetCodePage(uiCodePage)
      => ComCall(4, this.p, UInt32, uiCodePage)
}
struct FOLDERVIEWOPTIONS extends Int32 {
    static FVO_DEFAULT := 0
    static FVO_VISTALAYOUT := 1
    static FVO_CUSTOMPOSITION := 2
    static FVO_CUSTOMORDERING := 4
    static FVO_SUPPORTHYPERLINKS := 8
    static FVO_NOANIMATIONS := 16
    static FVO_NOSCROLLTIPS := 32
}
struct IFolderViewOptions extends IUnknown {
    static IID := "{3CC974D2-B302-4D36-AD3E-06D93F695D3F}"
    SetFolderViewOptions(fvoMask, fvoFlags)
      => ComCall(3, this.p, FOLDERVIEWOPTIONS, fvoMask, FOLDERVIEWOPTIONS, fvoFlags)
    GetFolderViewOptions(pfvoFlags)
      => ComCall(4, this.p, FOLDERVIEWOPTIONS.Ptr, pfvoFlags)
}
struct SV3CVW3_FLAGS extends Int32 {
    static SV3CVW3_DEFAULT := 0
    static SV3CVW3_NONINTERACTIVE := 1
    static SV3CVW3_FORCEVIEWMODE := 2
    static SV3CVW3_FORCEFOLDERFLAGS := 4
}
struct IShellView3 extends IShellView2 {
    static IID := "{EC39FA88-F8AF-41C5-8421-38BED28F4673}"
    CreateViewWindow3(psbOwner, psvPrev, dwViewFlags, dwMask, dwFlags, fvMode, pvid, prcView, phwndView)
      => ComCall(20, this.p, IShellBrowser, psbOwner, IShellView, psvPrev, UInt32, dwViewFlags, FOLDERFLAGS, dwMask, FOLDERFLAGS, dwFlags, FOLDERVIEWMODE, fvMode, GUID.Ptr, pvid, RECT.Ptr, prcView, HWND.Ptr, phwndView)
}
struct ISearchBoxInfo extends IUnknown {
    static IID := "{6AF6E03F-D664-4EF4-9626-F7E0ED36755E}"
    GetCondition(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetText(ppsz)
      => ComCall(4, this.p, PWSTR.Ptr, ppsz)
}
struct VPWATERMARKFLAGS extends Int32 {
    static VPWF_DEFAULT := 0
    static VPWF_ALPHABLEND := 1
}
struct VPCOLORFLAGS extends Int32 {
    static VPCF_TEXT := 1
    static VPCF_BACKGROUND := 2
    static VPCF_SORTCOLUMN := 3
    static VPCF_SUBTEXT := 4
    static VPCF_TEXTBACKGROUND := 5
}
struct IVisualProperties extends IUnknown {
    static IID := "{E693CF68-D967-4112-8763-99172AEE5E5A}"
    SetWatermark(hbmp, vpwf)
      => ComCall(3, this.p, HBITMAP, hbmp, VPWATERMARKFLAGS, vpwf)
    SetColor(vpcf, cr)
      => ComCall(4, this.p, VPCOLORFLAGS, vpcf, COLORREF, cr)
    GetColor(vpcf, pcr)
      => ComCall(5, this.p, VPCOLORFLAGS, vpcf, COLORREF.Ptr, pcr)
    SetItemHeight(cyItemInPixels)
      => ComCall(6, this.p, Int32, cyItemInPixels)
    GetItemHeight(cyItemInPixels)
      => ComCall(7, this.p, Int32.Ptr, cyItemInPixels)
    SetFont(plf, bRedraw)
      => ComCall(8, this.p, LOGFONTW.Ptr, plf, BOOL, bRedraw)
    GetFont(plf)
      => ComCall(9, this.p, LOGFONTW.Ptr, plf)
    SetTheme(pszSubAppName, pszSubIdList)
      => ComCall(10, this.p, "Str", pszSubAppName, "Str", pszSubIdList)
}
struct ICommDlgBrowser3 extends ICommDlgBrowser2 {
    static IID := "{C8AD25A1-3294-41EE-8165-71174BD01C57}"
    OnColumnClicked(ppshv, iColumn)
      => ComCall(9, this.p, IShellView, ppshv, Int32, iColumn)
    GetCurrentFilter(pszFileSpec)
      => ComCall(10, this.p, PWSTR, pszFileSpec, Int32, pszFileSpec.Length)
    OnPreViewCreated(ppshv)
      => ComCall(11, this.p, IShellView, ppshv)
}
struct IUserAccountChangeCallback extends IUnknown {
    static IID := "{A561E69A-B4B8-4113-91A5-64C6BCCA3430}"
    OnPictureChange(pszUserName)
      => ComCall(3, this.p, "Str", pszUserName)
}
struct IStreamAsync extends IStream {
    static IID := "{FE0B6665-E0CA-49B9-A178-2B5CB48D92A5}"
    ReadAsync(pv, pcbRead?, lpOverlapped)
      => ComCall(14, this.p, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbRead?, OVERLAPPED.Ptr, lpOverlapped)
    WriteAsync(lpBuffer, pcbWritten?, lpOverlapped)
      => ComCall(15, this.p, Struct.Ptr, lpBuffer, UInt32, lpBuffer.Size, UInt32.Ptr, pcbWritten?, OVERLAPPED.Ptr, lpOverlapped)
    OverlappedResult(lpOverlapped, lpNumberOfBytesTransferred, bWait)
      => ComCall(16, this.p, OVERLAPPED.Ptr, lpOverlapped, UInt32.Ptr, lpNumberOfBytesTransferred, BOOL, bWait)
    CancelIo()
      => ComCall(17, this.p)
}
struct IStreamUnbufferedInfo extends IUnknown {
    static IID := "{8A68FDDA-1FDC-4C20-8CEB-416643B5A625}"
    GetSectorSize(pcbSectorSize)
      => ComCall(3, this.p, UInt32.Ptr, pcbSectorSize)
}
struct DSH_FLAGS extends Int32 {
    static DSH_ALLOWDROPDESCRIPTIONTEXT := 1
}
struct IDragSourceHelper2 extends IDragSourceHelper {
    static IID := "{83E07D0D-0C5F-4163-BF1A-60B274051E40}"
    SetFlags(dwFlags)
      => ComCall(5, this.p, UInt32, dwFlags)
}
struct IHWEventHandler extends IUnknown {
    static IID := "{C1FB73D0-EC3A-4BA2-B512-8CDB9187B6D1}"
    Initialize(pszParams)
      => ComCall(3, this.p, "Str", pszParams)
    HandleEvent(pszDeviceID, pszAltDeviceID, pszEventType)
      => ComCall(4, this.p, "Str", pszDeviceID, "Str", pszAltDeviceID, "Str", pszEventType)
    HandleEventWithContent(pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject)
      => ComCall(5, this.p, "Str", pszDeviceID, "Str", pszAltDeviceID, "Str", pszEventType, "Str", pszContentTypeHandler, IDataObject, pdataobject)
}
struct IHWEventHandler2 extends IHWEventHandler {
    static IID := "{CFCC809F-295D-42E8-9FFC-424B33C487E6}"
    HandleEventWithHWND(pszDeviceID, pszAltDeviceID, pszEventType, hwndOwner)
      => ComCall(6, this.p, "Str", pszDeviceID, "Str", pszAltDeviceID, "Str", pszEventType, HWND, hwndOwner)
}
struct IQueryCancelAutoPlay extends IUnknown {
    static IID := "{DDEFE873-6997-4E68-BE26-39B633ADBE12}"
    AllowAutoPlay(pszPath, dwContentType, pszLabel, dwSerialNumber)
      => ComCall(3, this.p, "Str", pszPath, UInt32, dwContentType, "Str", pszLabel, UInt32, dwSerialNumber)
}
struct IDynamicHWHandler extends IUnknown {
    static IID := "{DC2601D7-059E-42FC-A09D-2AFD21B6D5F7}"
    GetDynamicInfo(pszDeviceID, dwContentType, ppszAction)
      => ComCall(3, this.p, "Str", pszDeviceID, UInt32, dwContentType, PWSTR.Ptr, ppszAction)
}
struct IUserNotificationCallback extends IUnknown {
    static IID := "{19108294-0441-4AFF-8013-FA0A730B0BEA}"
    OnBalloonUserClick(pt)
      => ComCall(3, this.p, POINT.Ptr, pt)
    OnLeftClick(pt)
      => ComCall(4, this.p, POINT.Ptr, pt)
    OnContextMenu(pt)
      => ComCall(5, this.p, POINT.Ptr, pt)
}
struct IUserNotification2 extends IUnknown {
    static IID := "{215913CC-57EB-4FAB-AB5A-E5FA7BEA2A6C}"
    SetBalloonInfo(pszTitle, pszText, dwInfoFlags)
      => ComCall(3, this.p, "Str", pszTitle, "Str", pszText, UInt32, dwInfoFlags)
    SetBalloonRetry(dwShowTime, dwInterval, cRetryCount)
      => ComCall(4, this.p, UInt32, dwShowTime, UInt32, dwInterval, UInt32, cRetryCount)
    SetIconInfo(hIcon1, pszToolTip)
      => ComCall(5, this.p, HICON, hIcon1, "Str", pszToolTip)
    Show(pqc, dwContinuePollInterval, pSink)
      => ComCall(6, this.p, IQueryContinue, pqc, UInt32, dwContinuePollInterval, IUserNotificationCallback, pSink)
    PlaySound(pszSoundName)
      => ComCall(7, this.p, "Str", pszSoundName)
}
struct IDeskBand2 extends IDeskBand {
    static IID := "{79D16DE4-ABEE-4021-8D9D-9169B261D657}"
    CanRenderComposited(pfCanRenderComposited)
      => ComCall(9, this.p, BOOL.Ptr, pfCanRenderComposited)
    SetCompositionState(fCompositionEnabled)
      => ComCall(10, this.p, BOOL, fCompositionEnabled)
    GetCompositionState(pfCompositionEnabled)
      => ComCall(11, this.p, BOOL.Ptr, pfCompositionEnabled)
}
struct IStartMenuPinnedList extends IUnknown {
    static IID := "{4CD19ADA-25A5-4A32-B3B7-347BEE5BE36B}"
    RemoveFromList(pitem)
      => ComCall(3, this.p, IShellItem, pitem)
}
struct ICDBurn extends IUnknown {
    static IID := "{3D73A659-E5D0-4D42-AFC0-5121BA425C8D}"
    GetRecorderDriveLetter(pszDrive)
      => ComCall(3, this.p, PWSTR, pszDrive, UInt32, pszDrive.Length)
    Burn(hwnd1)
      => ComCall(4, this.p, HWND, hwnd1)
    HasRecordableDrive(pfHasRecorder)
      => ComCall(5, this.p, BOOL.Ptr, pfHasRecorder)
}
struct IWizardSite extends IUnknown {
    static IID := "{88960F5B-422F-4E7B-8013-73415381C3C3}"
    GetPreviousPage(phpage)
      => ComCall(3, this.p, HPROPSHEETPAGE.Ptr, phpage)
    GetNextPage(phpage)
      => ComCall(4, this.p, HPROPSHEETPAGE.Ptr, phpage)
    GetCancelledPage(phpage)
      => ComCall(5, this.p, HPROPSHEETPAGE.Ptr, phpage)
}
struct IWizardExtension extends IUnknown {
    static IID := "{C02EA696-86CC-491E-9B23-74394A0444A8}"
    AddPages(aPages, pnPagesAdded)
      => ComCall(3, this.p, HPROPSHEETPAGE.Ptr, aPages, UInt32, aPages.Length, UInt32.Ptr, pnPagesAdded)
    GetFirstPage(phpage)
      => ComCall(4, this.p, HPROPSHEETPAGE.Ptr, phpage)
    GetLastPage(phpage)
      => ComCall(5, this.p, HPROPSHEETPAGE.Ptr, phpage)
}
struct IWebWizardExtension extends IWizardExtension {
    static IID := "{0E6B3F66-98D1-48C0-A222-FBDE74E2FBC5}"
    SetInitialURL(pszURL)
      => ComCall(6, this.p, "Str", pszURL)
    SetErrorURL(pszErrorURL)
      => ComCall(7, this.p, "Str", pszErrorURL)
}
struct IPublishingWizard extends IWizardExtension {
    static IID := "{AA9198BB-CCEC-472D-BEED-19A4F6733F7A}"
    Initialize(pdo?, dwOptions, pszServiceScope)
      => ComCall(6, this.p, IDataObject, pdo?, UInt32, dwOptions, "Str", pszServiceScope)
    GetTransferManifest(phrFromTransfer?, pdocManifest?)
      => ComCall(7, this.p, HRESULT.Ptr, phrFromTransfer?, IXMLDOMDocument.Ptr, pdocManifest?)
}
struct IFolderViewHost extends IUnknown {
    static IID := "{1EA58F02-D55A-411D-B09E-9E65AC21605B}"
    Initialize(hwndParent, pdo, prc)
      => ComCall(3, this.p, HWND, hwndParent, IDataObject, pdo, RECT.Ptr, prc)
}
struct IAccessibleObject extends IUnknown {
    static IID := "{95A391C5-9ED4-4C28-8401-AB9E06719E11}"
    SetAccessibleName(pszName)
      => ComCall(3, this.p, "Str", pszName)
}
struct IResultsFolder extends IUnknown {
    static IID := "{96E5AE6D-6AE1-4B1C-900C-C6480EAA8828}"
    AddItem(psi)
      => ComCall(3, this.p, IShellItem, psi)
    AddIDList(pidl, ppidlAdded?)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidl, ITEMIDLIST.Ptr.Ptr, ppidlAdded?)
    RemoveItem(psi)
      => ComCall(5, this.p, IShellItem, psi)
    RemoveIDList(pidl)
      => ComCall(6, this.p, ITEMIDLIST.Ptr, pidl)
    RemoveAll()
      => ComCall(7, this.p)
}
struct IAutoCompleteDropDown extends IUnknown {
    static IID := "{3CD141F4-3C6A-11D2-BCAA-00C04FD929DB}"
    GetDropDownStatus(pdwFlags, ppwszString)
      => ComCall(3, this.p, UInt32.Ptr, pdwFlags, PWSTR.Ptr, ppwszString)
    ResetEnumerator()
      => ComCall(4, this.p)
}
struct CDBURNINGEXTENSIONRET extends Int32 {
    static CDBE_RET_DEFAULT := 0
    static CDBE_RET_DONTRUNOTHEREXTS := 1
    static CDBE_RET_STOPWIZARD := 2
}
struct CDBE_ACTIONS extends Int32 {
    static CDBE_TYPE_MUSIC := 1
    static CDBE_TYPE_DATA := 2
    static CDBE_TYPE_ALL := -1
}
struct ICDBurnExt extends IUnknown {
    static IID := "{2271DCCA-74FC-4414-8FB7-C56B05ACE2D7}"
    GetSupportedActionTypes(pdwActions)
      => ComCall(3, this.p, UInt32.Ptr, pdwActions)
}
struct IEnumReadyCallback extends IUnknown {
    static IID := "{61E00D45-8FFF-4E60-924E-6537B61612DD}"
    EnumReady()
      => ComCall(3, this.p)
}
struct IEnumerableView extends IUnknown {
    static IID := "{8C8BF236-1AEC-495F-9894-91D57C3C686F}"
    SetEnumReadyCallback(percb)
      => ComCall(3, this.p, IEnumReadyCallback, percb)
    CreateEnumIDListFromContents(pidlFolder, dwEnumFlags, ppEnumIDList)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidlFolder, UInt32, dwEnumFlags, IEnumIDList.Ptr, ppEnumIDList)
}
struct IInsertItem extends IUnknown {
    static IID := "{D2B57227-3D23-4B95-93C0-492BD454C356}"
    InsertItem(pidl)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidl)
}
struct IFolderBandPriv extends IUnknown {
    static IID := "{47C01F95-E185-412C-B5C5-4F27DF965AEA}"
    SetCascade(fCascade)
      => ComCall(3, this.p, BOOL, fCascade)
    SetAccelerators(fAccelerators)
      => ComCall(4, this.p, BOOL, fAccelerators)
    SetNoIcons(fNoIcons)
      => ComCall(5, this.p, BOOL, fNoIcons)
    SetNoText(fNoText)
      => ComCall(6, this.p, BOOL, fNoText)
}
struct IImageRecompress extends IUnknown {
    static IID := "{505F1513-6B3E-4892-A272-59F8889A4D3E}"
    RecompressImage(psi, cx, cy, iQuality, pstg, ppstrmOut)
      => ComCall(3, this.p, IShellItem, psi, Int32, cx, Int32, cy, Int32, iQuality, IStorage, pstg, IStream.Ptr, ppstrmOut)
}
struct IFileDialogControlEvents extends IUnknown {
    static IID := "{36116642-D713-4B97-9B83-7484A9D00433}"
    OnItemSelected(pfdc, dwIDCtl, dwIDItem)
      => ComCall(3, this.p, IFileDialogCustomize, pfdc, UInt32, dwIDCtl, UInt32, dwIDItem)
    OnButtonClicked(pfdc, dwIDCtl)
      => ComCall(4, this.p, IFileDialogCustomize, pfdc, UInt32, dwIDCtl)
    OnCheckButtonToggled(pfdc, dwIDCtl, bChecked)
      => ComCall(5, this.p, IFileDialogCustomize, pfdc, UInt32, dwIDCtl, BOOL, bChecked)
    OnControlActivating(pfdc, dwIDCtl)
      => ComCall(6, this.p, IFileDialogCustomize, pfdc, UInt32, dwIDCtl)
}
struct IFileDialog2 extends IFileDialog {
    static IID := "{61744FC7-85B5-4791-A9B0-272276309B13}"
    SetCancelButtonLabel(pszLabel)
      => ComCall(27, this.p, "Str", pszLabel)
    SetNavigationRoot(psi)
      => ComCall(28, this.p, IShellItem, psi)
}
struct IApplicationAssociationRegistrationUI extends IUnknown {
    static IID := "{1F76A169-F994-40AC-8FC8-0959E8874710}"
    LaunchAdvancedAssociationUI(pszAppRegistryName)
      => ComCall(3, this.p, "Str", pszAppRegistryName)
}
struct IShellRunDll extends IUnknown {
    static IID := "{FCE4BDE0-4B68-4B80-8E9C-7426315A7388}"
    Run(pszArgs)
      => ComCall(3, this.p, "Str", pszArgs)
}
struct IPreviousVersionsInfo extends IUnknown {
    static IID := "{76E54780-AD74-48E3-A695-3BA9A0AFF10D}"
    AreSnapshotsAvailable(pszPath, fOkToBeSlow, pfAvailable)
      => ComCall(3, this.p, "Str", pszPath, BOOL, fOkToBeSlow, BOOL.Ptr, pfAvailable)
}
struct IUseToBrowseItem extends IRelatedItem {
    static IID := "{05EDDA5C-98A3-4717-8ADB-C5E7DA991EB1}"
}
struct NSTCSTYLE2 extends Int32 {
    static NSTCS2_DEFAULT := 0
    static NSTCS2_INTERRUPTNOTIFICATIONS := 1
    static NSTCS2_SHOWNULLSPACEMENU := 2
    static NSTCS2_DISPLAYPADDING := 4
    static NSTCS2_DISPLAYPINNEDONLY := 8
    static NTSCS2_NOSINGLETONAUTOEXPAND := 16
    static NTSCS2_NEVERINSERTNONENUMERATED := 32
}
struct INameSpaceTreeControl2 extends INameSpaceTreeControl {
    static IID := "{7CC7AED8-290E-49BC-8945-C1401CC9306C}"
    SetControlStyle(nstcsMask, nstcsStyle)
      => ComCall(22, this.p, UInt32, nstcsMask, UInt32, nstcsStyle)
    GetControlStyle(nstcsMask, pnstcsStyle)
      => ComCall(23, this.p, UInt32, nstcsMask, UInt32.Ptr, pnstcsStyle)
    SetControlStyle2(nstcsMask, nstcsStyle)
      => ComCall(24, this.p, NSTCSTYLE2, nstcsMask, NSTCSTYLE2, nstcsStyle)
    GetControlStyle2(nstcsMask, pnstcsStyle)
      => ComCall(25, this.p, NSTCSTYLE2, nstcsMask, NSTCSTYLE2.Ptr, pnstcsStyle)
}
struct NSTCEHITTEST extends Int32 {
    static NSTCEHT_NOWHERE := 1
    static NSTCEHT_ONITEMICON := 2
    static NSTCEHT_ONITEMLABEL := 4
    static NSTCEHT_ONITEMINDENT := 8
    static NSTCEHT_ONITEMBUTTON := 16
    static NSTCEHT_ONITEMRIGHT := 32
    static NSTCEHT_ONITEMSTATEICON := 64
    static NSTCEHT_ONITEM := 70
    static NSTCEHT_ONITEMTABBUTTON := 4096
}
struct NSTCECLICKTYPE extends Int32 {
    static NSTCECT_LBUTTON := 1
    static NSTCECT_MBUTTON := 2
    static NSTCECT_RBUTTON := 3
    static NSTCECT_BUTTON := 3
    static NSTCECT_DBLCLICK := 4
}
struct INameSpaceTreeControlEvents extends IUnknown {
    static IID := "{93D77985-B3D8-4484-8318-672CDDA002CE}"
    OnItemClick(psi, nstceHitTest, nstceClickType)
      => ComCall(3, this.p, IShellItem, psi, UInt32, nstceHitTest, UInt32, nstceClickType)
    OnPropertyItemCommit(psi)
      => ComCall(4, this.p, IShellItem, psi)
    OnItemStateChanging(psi, nstcisMask, nstcisState)
      => ComCall(5, this.p, IShellItem, psi, UInt32, nstcisMask, UInt32, nstcisState)
    OnItemStateChanged(psi, nstcisMask, nstcisState)
      => ComCall(6, this.p, IShellItem, psi, UInt32, nstcisMask, UInt32, nstcisState)
    OnSelectionChanged(psiaSelection)
      => ComCall(7, this.p, IShellItemArray, psiaSelection)
    OnKeyboardInput(uMsg, wParam1, lParam1)
      => ComCall(8, this.p, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
    OnBeforeExpand(psi)
      => ComCall(9, this.p, IShellItem, psi)
    OnAfterExpand(psi)
      => ComCall(10, this.p, IShellItem, psi)
    OnBeginLabelEdit(psi)
      => ComCall(11, this.p, IShellItem, psi)
    OnEndLabelEdit(psi)
      => ComCall(12, this.p, IShellItem, psi)
    OnGetToolTip(psi, pszTip)
      => ComCall(13, this.p, IShellItem, psi, PWSTR, pszTip, Int32, pszTip.Length)
    OnBeforeItemDelete(psi)
      => ComCall(14, this.p, IShellItem, psi)
    OnItemAdded(psi, fIsRoot)
      => ComCall(15, this.p, IShellItem, psi, BOOL, fIsRoot)
    OnItemDeleted(psi, fIsRoot)
      => ComCall(16, this.p, IShellItem, psi, BOOL, fIsRoot)
    OnBeforeContextMenu(psi?, riid, ppv)
      => ComCall(17, this.p, IShellItem, psi?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    OnAfterContextMenu(psi?, pcmIn, riid, ppv)
      => ComCall(18, this.p, IShellItem, psi?, IContextMenu, pcmIn, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    OnBeforeStateImageChange(psi)
      => ComCall(19, this.p, IShellItem, psi)
    OnGetDefaultIconIndex(psi, piDefaultIcon, piOpenIcon)
      => ComCall(20, this.p, IShellItem, psi, Int32.Ptr, piDefaultIcon, Int32.Ptr, piOpenIcon)
}
struct INameSpaceTreeControlDropHandler extends IUnknown {
    static IID := "{F9C665D6-C2F2-4C19-BF33-8322D7352F51}"
    OnDragEnter(psiOver?, psiaData, fOutsideSource, grfKeyState, pdwEffect)
      => ComCall(3, this.p, IShellItem, psiOver?, IShellItemArray, psiaData, BOOL, fOutsideSource, UInt32, grfKeyState, UInt32.Ptr, pdwEffect)
    OnDragOver(psiOver?, psiaData, grfKeyState, pdwEffect)
      => ComCall(4, this.p, IShellItem, psiOver?, IShellItemArray, psiaData, UInt32, grfKeyState, UInt32.Ptr, pdwEffect)
    OnDragPosition(psiOver?, psiaData, iNewPosition, iOldPosition)
      => ComCall(5, this.p, IShellItem, psiOver?, IShellItemArray, psiaData, Int32, iNewPosition, Int32, iOldPosition)
    OnDrop(psiOver?, psiaData, iPosition, grfKeyState, pdwEffect)
      => ComCall(6, this.p, IShellItem, psiOver?, IShellItemArray, psiaData, Int32, iPosition, UInt32, grfKeyState, UInt32.Ptr, pdwEffect)
    OnDropPosition(psiOver?, psiaData, iNewPosition, iOldPosition)
      => ComCall(7, this.p, IShellItem, psiOver?, IShellItemArray, psiaData, Int32, iNewPosition, Int32, iOldPosition)
    OnDragLeave(psiOver?)
      => ComCall(8, this.p, IShellItem, psiOver?)
}
struct INameSpaceTreeAccessible extends IUnknown {
    static IID := "{71F312DE-43ED-4190-8477-E9536B82350B}"
    OnGetDefaultAccessibilityAction(psi, pbstrDefaultAction)
      => ComCall(3, this.p, IShellItem, psi, BSTR.Ptr, pbstrDefaultAction)
    OnDoDefaultAccessibilityAction(psi)
      => ComCall(4, this.p, IShellItem, psi)
    OnGetAccessibilityRole(psi, pvarRole)
      => ComCall(5, this.p, IShellItem, psi, VARIANT.Ptr, pvarRole)
}
struct NSTCCUSTOMDRAW {
    psi : IShellItem
    uItemState : UInt32
    nstcis : UInt32
    pszText : PWSTR
    iImage : Int32
    himl : HIMAGELIST
    iLevel : Int32
    iIndent : Int32
}
struct INameSpaceTreeControlCustomDraw extends IUnknown {
    static IID := "{2D3BA758-33EE-42D5-BB7B-5F3431D86C78}"
    PrePaint(hdc1, prc, plres)
      => ComCall(3, this.p, HDC, hdc1, RECT.Ptr, prc, LRESULT.Ptr, plres)
    PostPaint(hdc1, prc)
      => ComCall(4, this.p, HDC, hdc1, RECT.Ptr, prc)
    ItemPrePaint(hdc1, prc, pnstccdItem, pclrText, pclrTextBk, plres)
      => ComCall(5, this.p, HDC, hdc1, RECT.Ptr, prc, NSTCCUSTOMDRAW.Ptr, pnstccdItem, COLORREF.Ptr, pclrText, COLORREF.Ptr, pclrTextBk, LRESULT.Ptr, plres)
    ItemPostPaint(hdc1, prc, pnstccdItem)
      => ComCall(6, this.p, HDC, hdc1, RECT.Ptr, prc, NSTCCUSTOMDRAW.Ptr, pnstccdItem)
}
struct ITrayDeskBand extends IUnknown {
    static IID := "{6D67E846-5B9C-4DB8-9CBC-DDE12F4254F1}"
    ShowDeskBand(clsid)
      => ComCall(3, this.p, GUID.Ptr, clsid)
    HideDeskBand(clsid)
      => ComCall(4, this.p, GUID.Ptr, clsid)
    IsDeskBandShown(clsid)
      => ComCall(5, this.p, GUID.Ptr, clsid)
    DeskBandRegistrationChanged()
      => ComCall(6, this.p)
}
struct IBandHost extends IUnknown {
    static IID := "{B9075C7C-D48E-403F-AB99-D6C77A1084AC}"
    CreateBand(rclsidBand, fAvailable, fVisible, riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, rclsidBand, BOOL, fAvailable, BOOL, fVisible, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetBandAvailability(rclsidBand, fAvailable)
      => ComCall(4, this.p, GUID.Ptr, rclsidBand, BOOL, fAvailable)
    DestroyBand(rclsidBand)
      => ComCall(5, this.p, GUID.Ptr, rclsidBand)
}
struct IComputerInfoChangeNotify extends IUnknown {
    static IID := "{0DF60D92-6818-46D6-B358-D66170DDE466}"
    ComputerInfoChanged()
      => ComCall(3, this.p)
}
struct IDesktopGadget extends IUnknown {
    static IID := "{C1646BC4-F298-4F91-A204-EB2DD1709D1A}"
    RunGadget(gadgetPath)
      => ComCall(3, this.p, "Str", gadgetPath)
}
struct UNDOCK_REASON extends Int32 {
    static UR_RESOLUTION_CHANGE := 0
    static UR_MONITOR_DISCONNECT := 1
}
struct IAccessibilityDockingServiceCallback extends IUnknown {
    static IID := "{157733FD-A592-42E5-B594-248468C5A81B}"
    Undocked(undockReason)
      => ComCall(3, this.p, UNDOCK_REASON, undockReason)
}
struct IAccessibilityDockingService extends IUnknown {
    static IID := "{8849DC22-CEDF-4C95-998D-051419DD3F76}"
    GetAvailableSize(hMonitor1, pcxFixed, pcyMax)
      => ComCall(3, this.p, HMONITOR, hMonitor1, UInt32.Ptr, pcxFixed, UInt32.Ptr, pcyMax)
    DockWindow(hwnd1, hMonitor1, cyRequested, pCallback)
      => ComCall(4, this.p, HWND, hwnd1, HMONITOR, hMonitor1, UInt32, cyRequested, IAccessibilityDockingServiceCallback, pCallback)
    UndockWindow(hwnd1)
      => ComCall(5, this.p, HWND, hwnd1)
}
struct IStorageProviderBanners extends IUnknown {
    static IID := "{5EFB46D7-47C0-4B68-ACDA-DED47C90EC91}"
    SetBanner(providerIdentity, subscriptionId, contentId)
      => ComCall(3, this.p, "Str", providerIdentity, "Str", subscriptionId, "Str", contentId)
    ClearBanner(providerIdentity, subscriptionId)
      => ComCall(4, this.p, "Str", providerIdentity, "Str", subscriptionId)
    ClearAllBanners(providerIdentity)
      => ComCall(5, this.p, "Str", providerIdentity)
    GetBanner(providerIdentity, subscriptionId, contentId)
      => ComCall(6, this.p, "Str", providerIdentity, "Str", subscriptionId, PWSTR.Ptr, contentId)
}
struct IStorageProviderCopyHook extends IUnknown {
    static IID := "{7BF992A9-AF7A-4DBA-B2E5-4D080B1ECBC6}"
    CopyCallback(hwnd1, operation, flags, srcFile, srcAttribs, destFile, destAttribs, result)
      => ComCall(3, this.p, HWND, hwnd1, UInt32, operation, UInt32, flags, "Str", srcFile, UInt32, srcAttribs, "Str", destFile, UInt32, destAttribs, UInt32.Ptr, result)
}
struct CommandStateChangeConstants extends Int32 {
    static CSC_UPDATECOMMANDS := -1
    static CSC_NAVIGATEFORWARD := 1
    static CSC_NAVIGATEBACK := 2
}
struct SecureLockIconConstants extends Int32 {
    static secureLockIconUnsecure := 0
    static secureLockIconMixed := 1
    static secureLockIconSecureUnknownBits := 2
    static secureLockIconSecure40Bit := 3
    static secureLockIconSecure56Bit := 4
    static secureLockIconSecureFortezza := 5
    static secureLockIconSecure128Bit := 6
}
struct NewProcessCauseConstants extends Int32 {
    static ProtectedModeRedirect := 1
}
struct ShellWindowTypeConstants extends Int32 {
    static SWC_EXPLORER := 0
    static SWC_BROWSER := 1
    static SWC_3RDPARTY := 2
    static SWC_CALLBACK := 4
    static SWC_DESKTOP := 8
}
struct ShellWindowFindWindowOptions extends Int32 {
    static SWFO_NEEDDISPATCH := 1
    static SWFO_INCLUDEPENDING := 2
    static SWFO_COOKIEPASSED := 4
}
struct BrowserNavConstants extends Int32 {
    static navOpenInNewWindow := 1
    static navNoHistory := 2
    static navNoReadFromCache := 4
    static navNoWriteToCache := 8
    static navAllowAutosearch := 16
    static navBrowserBar := 32
    static navHyperlink := 64
    static navEnforceRestricted := 128
    static navNewWindowsManaged := 256
    static navUntrustedForDownload := 512
    static navTrustedForActiveX := 1024
    static navOpenInNewTab := 2048
    static navOpenInBackgroundTab := 4096
    static navKeepWordWheelText := 8192
    static navVirtualTab := 16384
    static navBlockRedirectsXDomain := 32768
    static navOpenNewForegroundTab := 65536
    static navTravelLogScreenshot := 131072
    static navDeferUnload := 262144
    static navSpeculative := 524288
    static navSuggestNewWindow := 1048576
    static navSuggestNewTab := 2097152
    static navReserved1 := 4194304
    static navHomepageNavigate := 8388608
    static navRefresh := 16777216
    static navHostNavigation := 33554432
    static navReserved2 := 67108864
    static navReserved3 := 134217728
    static navReserved4 := 268435456
    static navReserved5 := 536870912
    static navReserved6 := 1073741824
    static navReserved7 := -2147483648
}
struct RefreshConstants extends Int32 {
    static REFRESH_NORMAL := 0
    static REFRESH_IFEXPIRED := 1
    static REFRESH_COMPLETELY := 3
}
struct IWebBrowser extends IDispatch {
    static IID := "{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}"
    GoBack()
      => ComCall(7, this.p)
    GoForward()
      => ComCall(8, this.p)
    GoHome()
      => ComCall(9, this.p)
    GoSearch()
      => ComCall(10, this.p)
    Navigate(URL, Flags?, TargetFrameName?, PostData?, Headers?)
      => ComCall(11, this.p, BSTR, URL, VARIANT.Ptr, Flags?, VARIANT.Ptr, TargetFrameName?, VARIANT.Ptr, PostData?, VARIANT.Ptr, Headers?)
    Refresh()
      => ComCall(12, this.p)
    Refresh2(Level?)
      => ComCall(13, this.p, VARIANT.Ptr, Level?)
    Stop()
      => ComCall(14, this.p)
    get_Application(ppDisp)
      => ComCall(15, this.p, IDispatch.Ptr, ppDisp)
    get_Parent(ppDisp)
      => ComCall(16, this.p, IDispatch.Ptr, ppDisp)
    get_Container(ppDisp)
      => ComCall(17, this.p, IDispatch.Ptr, ppDisp)
    get_Document(ppDisp)
      => ComCall(18, this.p, IDispatch.Ptr, ppDisp)
    get_TopLevelContainer(pBool)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pBool)
    get_Type(Type)
      => ComCall(20, this.p, BSTR.Ptr, Type)
    get_Left(pl)
      => ComCall(21, this.p, Int32.Ptr, pl)
    put_Left(Left)
      => ComCall(22, this.p, Int32, Left)
    get_Top(pl)
      => ComCall(23, this.p, Int32.Ptr, pl)
    put_Top(Top)
      => ComCall(24, this.p, Int32, Top)
    get_Width(pl)
      => ComCall(25, this.p, Int32.Ptr, pl)
    put_Width(Width)
      => ComCall(26, this.p, Int32, Width)
    get_Height(pl)
      => ComCall(27, this.p, Int32.Ptr, pl)
    put_Height(Height)
      => ComCall(28, this.p, Int32, Height)
    get_LocationName(LocationName)
      => ComCall(29, this.p, BSTR.Ptr, LocationName)
    get_LocationURL(LocationURL)
      => ComCall(30, this.p, BSTR.Ptr, LocationURL)
    get_Busy(pBool)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pBool)
}
struct DWebBrowserEvents extends IDispatch {
    static IID := "{EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B}"
}
struct IWebBrowserApp extends IWebBrowser {
    static IID := "{0002DF05-0000-0000-C000-000000000046}"
    Quit()
      => ComCall(32, this.p)
    ClientToWindow(pcx, pcy)
      => ComCall(33, this.p, Int32.Ptr, pcx, Int32.Ptr, pcy)
    PutProperty(Property, vtValue)
      => ComCall(34, this.p, BSTR, Property, VARIANT, vtValue)
    GetProperty(Property, pvtValue)
      => ComCall(35, this.p, BSTR, Property, VARIANT.Ptr, pvtValue)
    get_Name(Name)
      => ComCall(36, this.p, BSTR.Ptr, Name)
    get_HWND(pHWND)
      => ComCall(37, this.p, SHANDLE_PTR.Ptr, pHWND)
    get_FullName(FullName)
      => ComCall(38, this.p, BSTR.Ptr, FullName)
    get_Path(Path)
      => ComCall(39, this.p, BSTR.Ptr, Path)
    get_Visible(pBool)
      => ComCall(40, this.p, VARIANT_BOOL.Ptr, pBool)
    put_Visible(Value)
      => ComCall(41, this.p, VARIANT_BOOL, Value)
    get_StatusBar(pBool)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, pBool)
    put_StatusBar(Value)
      => ComCall(43, this.p, VARIANT_BOOL, Value)
    get_StatusText(StatusText)
      => ComCall(44, this.p, BSTR.Ptr, StatusText)
    put_StatusText(StatusText)
      => ComCall(45, this.p, BSTR, StatusText)
    get_ToolBar(Value)
      => ComCall(46, this.p, Int32.Ptr, Value)
    put_ToolBar(Value)
      => ComCall(47, this.p, Int32, Value)
    get_MenuBar(Value)
      => ComCall(48, this.p, VARIANT_BOOL.Ptr, Value)
    put_MenuBar(Value)
      => ComCall(49, this.p, VARIANT_BOOL, Value)
    get_FullScreen(pbFullScreen)
      => ComCall(50, this.p, VARIANT_BOOL.Ptr, pbFullScreen)
    put_FullScreen(bFullScreen)
      => ComCall(51, this.p, VARIANT_BOOL, bFullScreen)
}
struct IWebBrowser2 extends IWebBrowserApp {
    static IID := "{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}"
    Navigate2(URL, Flags?, TargetFrameName?, PostData?, Headers?)
      => ComCall(52, this.p, VARIANT.Ptr, URL, VARIANT.Ptr, Flags?, VARIANT.Ptr, TargetFrameName?, VARIANT.Ptr, PostData?, VARIANT.Ptr, Headers?)
    QueryStatusWB(cmdID, pcmdf)
      => ComCall(53, this.p, OLECMDID, cmdID, OLECMDF.Ptr, pcmdf)
    ExecWB(cmdID, cmdexecopt, pvaIn?, pvaOut?)
      => ComCall(54, this.p, OLECMDID, cmdID, OLECMDEXECOPT, cmdexecopt, VARIANT.Ptr, pvaIn?, VARIANT.Ptr, pvaOut?)
    ShowBrowserBar(pvaClsid, pvarShow?, pvarSize?)
      => ComCall(55, this.p, VARIANT.Ptr, pvaClsid, VARIANT.Ptr, pvarShow?, VARIANT.Ptr, pvarSize?)
    get_ReadyState(plReadyState)
      => ComCall(56, this.p, READYSTATE.Ptr, plReadyState)
    get_Offline(pbOffline)
      => ComCall(57, this.p, VARIANT_BOOL.Ptr, pbOffline)
    put_Offline(bOffline)
      => ComCall(58, this.p, VARIANT_BOOL, bOffline)
    get_Silent(pbSilent)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, pbSilent)
    put_Silent(bSilent)
      => ComCall(60, this.p, VARIANT_BOOL, bSilent)
    get_RegisterAsBrowser(pbRegister)
      => ComCall(61, this.p, VARIANT_BOOL.Ptr, pbRegister)
    put_RegisterAsBrowser(bRegister)
      => ComCall(62, this.p, VARIANT_BOOL, bRegister)
    get_RegisterAsDropTarget(pbRegister)
      => ComCall(63, this.p, VARIANT_BOOL.Ptr, pbRegister)
    put_RegisterAsDropTarget(bRegister)
      => ComCall(64, this.p, VARIANT_BOOL, bRegister)
    get_TheaterMode(pbRegister)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, pbRegister)
    put_TheaterMode(bRegister)
      => ComCall(66, this.p, VARIANT_BOOL, bRegister)
    get_AddressBar(Value)
      => ComCall(67, this.p, VARIANT_BOOL.Ptr, Value)
    put_AddressBar(Value)
      => ComCall(68, this.p, VARIANT_BOOL, Value)
    get_Resizable(Value)
      => ComCall(69, this.p, VARIANT_BOOL.Ptr, Value)
    put_Resizable(Value)
      => ComCall(70, this.p, VARIANT_BOOL, Value)
}
struct DWebBrowserEvents2 extends IDispatch {
    static IID := "{34A715A0-6587-11D0-924A-0020AFC7AC4D}"
}
struct DShellWindowsEvents extends IDispatch {
    static IID := "{FE4106E0-399A-11D0-A48C-00A0C90A8F39}"
}
struct IShellWindows extends IDispatch {
    static IID := "{85CB6900-4D95-11CF-960C-0080C7F4EE85}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(index, Folder)
      => ComCall(8, this.p, VARIANT, index, IDispatch.Ptr, Folder)
    _NewEnum(ppunk)
      => ComCall(9, this.p, IUnknown.Ptr, ppunk)
    Register(pid, hwnd, swClass, plCookie)
      => ComCall(10, this.p, IDispatch, pid, Int32, hwnd, ShellWindowTypeConstants, swClass, Int32.Ptr, plCookie)
    RegisterPending(lThreadId, pvarloc, pvarlocRoot, swClass, plCookie)
      => ComCall(11, this.p, Int32, lThreadId, VARIANT.Ptr, pvarloc, VARIANT.Ptr, pvarlocRoot, ShellWindowTypeConstants, swClass, Int32.Ptr, plCookie)
    Revoke(lCookie)
      => ComCall(12, this.p, Int32, lCookie)
    OnNavigate(lCookie, pvarLoc)
      => ComCall(13, this.p, Int32, lCookie, VARIANT.Ptr, pvarLoc)
    OnActivated(lCookie, fActive)
      => ComCall(14, this.p, Int32, lCookie, VARIANT_BOOL, fActive)
    FindWindowSW(pvarLoc, pvarLocRoot, swClass, phwnd, swfwOptions, ppdispOut)
      => ComCall(15, this.p, VARIANT.Ptr, pvarLoc, VARIANT.Ptr, pvarLocRoot, ShellWindowTypeConstants, swClass, Int32.Ptr, phwnd, ShellWindowFindWindowOptions, swfwOptions, IDispatch.Ptr, ppdispOut)
    OnCreated(lCookie, punk)
      => ComCall(16, this.p, Int32, lCookie, IUnknown, punk)
    ProcessAttachDetach(fAttach)
      => ComCall(17, this.p, VARIANT_BOOL, fAttach)
}
struct IShellUIHelper extends IDispatch {
    static IID := "{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}"
    ResetFirstBootMode()
      => ComCall(7, this.p)
    ResetSafeMode()
      => ComCall(8, this.p)
    RefreshOfflineDesktop()
      => ComCall(9, this.p)
    AddFavorite(URL, Title?)
      => ComCall(10, this.p, BSTR, URL, VARIANT.Ptr, Title?)
    AddChannel(URL)
      => ComCall(11, this.p, BSTR, URL)
    AddDesktopComponent(URL, Type, Left?, Top?, Width?, Height?)
      => ComCall(12, this.p, BSTR, URL, BSTR, Type, VARIANT.Ptr, Left?, VARIANT.Ptr, Top?, VARIANT.Ptr, Width?, VARIANT.Ptr, Height?)
    IsSubscribed(URL, pBool)
      => ComCall(13, this.p, BSTR, URL, VARIANT_BOOL.Ptr, pBool)
    NavigateAndFind(URL, strQuery, varTargetFrame)
      => ComCall(14, this.p, BSTR, URL, BSTR, strQuery, VARIANT.Ptr, varTargetFrame)
    ImportExportFavorites(fImport, strImpExpPath)
      => ComCall(15, this.p, VARIANT_BOOL, fImport, BSTR, strImpExpPath)
    AutoCompleteSaveForm(Form?)
      => ComCall(16, this.p, VARIANT.Ptr, Form?)
    AutoScan(strSearch, strFailureUrl, pvarTargetFrame?)
      => ComCall(17, this.p, BSTR, strSearch, BSTR, strFailureUrl, VARIANT.Ptr, pvarTargetFrame?)
    AutoCompleteAttach(Reserved?)
      => ComCall(18, this.p, VARIANT.Ptr, Reserved?)
    ShowBrowserUI(bstrName, pvarIn, pvarOut)
      => ComCall(19, this.p, BSTR, bstrName, VARIANT.Ptr, pvarIn, VARIANT.Ptr, pvarOut)
}
struct IShellUIHelper2 extends IShellUIHelper {
    static IID := "{A7FE6EDA-1932-4281-B881-87B31B8BC52C}"
    AddSearchProvider(URL)
      => ComCall(20, this.p, BSTR, URL)
    RunOnceShown()
      => ComCall(21, this.p)
    SkipRunOnce()
      => ComCall(22, this.p)
    CustomizeSettings(fSQM, fPhishing, bstrLocale)
      => ComCall(23, this.p, VARIANT_BOOL, fSQM, VARIANT_BOOL, fPhishing, BSTR, bstrLocale)
    SqmEnabled(pfEnabled)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    PhishingEnabled(pfEnabled)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    BrandImageUri(pbstrUri)
      => ComCall(26, this.p, BSTR.Ptr, pbstrUri)
    SkipTabsWelcome()
      => ComCall(27, this.p)
    DiagnoseConnection()
      => ComCall(28, this.p)
    CustomizeClearType(fSet)
      => ComCall(29, this.p, VARIANT_BOOL, fSet)
    IsSearchProviderInstalled(URL, pdwResult)
      => ComCall(30, this.p, BSTR, URL, UInt32.Ptr, pdwResult)
    IsSearchMigrated(pfMigrated)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pfMigrated)
    DefaultSearchProvider(pbstrName)
      => ComCall(32, this.p, BSTR.Ptr, pbstrName)
    RunOnceRequiredSettingsComplete(fComplete)
      => ComCall(33, this.p, VARIANT_BOOL, fComplete)
    RunOnceHasShown(pfShown)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, pfShown)
    SearchGuideUrl(pbstrUrl)
      => ComCall(35, this.p, BSTR.Ptr, pbstrUrl)
}
struct IShellUIHelper3 extends IShellUIHelper2 {
    static IID := "{528DF2EC-D419-40BC-9B6D-DCDBF9C1B25D}"
    AddService(URL)
      => ComCall(36, this.p, BSTR, URL)
    IsServiceInstalled(URL, Verb, pdwResult)
      => ComCall(37, this.p, BSTR, URL, BSTR, Verb, UInt32.Ptr, pdwResult)
    InPrivateFilteringEnabled(pfEnabled)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    AddToFavoritesBar(URL, Title, Type)
      => ComCall(39, this.p, BSTR, URL, BSTR, Title, VARIANT.Ptr, Type)
    BuildNewTabPage()
      => ComCall(40, this.p)
    SetRecentlyClosedVisible(fVisible)
      => ComCall(41, this.p, VARIANT_BOOL, fVisible)
    SetActivitiesVisible(fVisible)
      => ComCall(42, this.p, VARIANT_BOOL, fVisible)
    ContentDiscoveryReset()
      => ComCall(43, this.p)
    IsSuggestedSitesEnabled(pfEnabled)
      => ComCall(44, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    EnableSuggestedSites(fEnable)
      => ComCall(45, this.p, VARIANT_BOOL, fEnable)
    NavigateToSuggestedSites(bstrRelativeUrl)
      => ComCall(46, this.p, BSTR, bstrRelativeUrl)
    ShowTabsHelp()
      => ComCall(47, this.p)
    ShowInPrivateHelp()
      => ComCall(48, this.p)
}
struct IShellUIHelper4 extends IShellUIHelper3 {
    static IID := "{B36E6A53-8073-499E-824C-D776330A333E}"
    msIsSiteMode(pfSiteMode)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, pfSiteMode)
    msSiteModeShowThumbBar()
      => ComCall(50, this.p)
    msSiteModeAddThumbBarButton(bstrIconURL, bstrTooltip, pvarButtonID)
      => ComCall(51, this.p, BSTR, bstrIconURL, BSTR, bstrTooltip, VARIANT.Ptr, pvarButtonID)
    msSiteModeUpdateThumbBarButton(ButtonID, fEnabled, fVisible)
      => ComCall(52, this.p, VARIANT, ButtonID, VARIANT_BOOL, fEnabled, VARIANT_BOOL, fVisible)
    msSiteModeSetIconOverlay(IconUrl, pvarDescription)
      => ComCall(53, this.p, BSTR, IconUrl, VARIANT.Ptr, pvarDescription)
    msSiteModeClearIconOverlay()
      => ComCall(54, this.p)
    msAddSiteMode()
      => ComCall(55, this.p)
    msSiteModeCreateJumpList(bstrHeader)
      => ComCall(56, this.p, BSTR, bstrHeader)
    msSiteModeAddJumpListItem(bstrName, bstrActionUri, bstrIconUri, pvarWindowType)
      => ComCall(57, this.p, BSTR, bstrName, BSTR, bstrActionUri, BSTR, bstrIconUri, VARIANT.Ptr, pvarWindowType)
    msSiteModeClearJumpList()
      => ComCall(58, this.p)
    msSiteModeShowJumpList()
      => ComCall(59, this.p)
    msSiteModeAddButtonStyle(uiButtonID, bstrIconUrl, bstrTooltip, pvarStyleID)
      => ComCall(60, this.p, VARIANT, uiButtonID, BSTR, bstrIconUrl, BSTR, bstrTooltip, VARIANT.Ptr, pvarStyleID)
    msSiteModeShowButtonStyle(uiButtonID, uiStyleID)
      => ComCall(61, this.p, VARIANT, uiButtonID, VARIANT, uiStyleID)
    msSiteModeActivate()
      => ComCall(62, this.p)
    msIsSiteModeFirstRun(fPreserveState, puiFirstRun)
      => ComCall(63, this.p, VARIANT_BOOL, fPreserveState, VARIANT.Ptr, puiFirstRun)
    msAddTrackingProtectionList(URL, bstrFilterName)
      => ComCall(64, this.p, BSTR, URL, BSTR, bstrFilterName)
    msTrackingProtectionEnabled(pfEnabled)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    msActiveXFilteringEnabled(pfEnabled)
      => ComCall(66, this.p, VARIANT_BOOL.Ptr, pfEnabled)
}
struct IShellUIHelper5 extends IShellUIHelper4 {
    static IID := "{A2A08B09-103D-4D3F-B91C-EA455CA82EFA}"
    msProvisionNetworks(bstrProvisioningXml, puiResult)
      => ComCall(67, this.p, BSTR, bstrProvisioningXml, VARIANT.Ptr, puiResult)
    msReportSafeUrl()
      => ComCall(68, this.p)
    msSiteModeRefreshBadge()
      => ComCall(69, this.p)
    msSiteModeClearBadge()
      => ComCall(70, this.p)
    msDiagnoseConnectionUILess()
      => ComCall(71, this.p)
    msLaunchNetworkClientHelp()
      => ComCall(72, this.p)
    msChangeDefaultBrowser(fChange)
      => ComCall(73, this.p, VARIANT_BOOL, fChange)
}
struct IShellUIHelper6 extends IShellUIHelper5 {
    static IID := "{987A573E-46EE-4E89-96AB-DDF7F8FDC98C}"
    msStopPeriodicTileUpdate()
      => ComCall(74, this.p)
    msStartPeriodicTileUpdate(pollingUris, startTime, uiUpdateRecurrence)
      => ComCall(75, this.p, VARIANT, pollingUris, VARIANT, startTime, VARIANT, uiUpdateRecurrence)
    msStartPeriodicTileUpdateBatch(pollingUris, startTime, uiUpdateRecurrence)
      => ComCall(76, this.p, VARIANT, pollingUris, VARIANT, startTime, VARIANT, uiUpdateRecurrence)
    msClearTile()
      => ComCall(77, this.p)
    msEnableTileNotificationQueue(fChange)
      => ComCall(78, this.p, VARIANT_BOOL, fChange)
    msPinnedSiteState(pvarSiteState)
      => ComCall(79, this.p, VARIANT.Ptr, pvarSiteState)
    msEnableTileNotificationQueueForSquare150x150(fChange)
      => ComCall(80, this.p, VARIANT_BOOL, fChange)
    msEnableTileNotificationQueueForWide310x150(fChange)
      => ComCall(81, this.p, VARIANT_BOOL, fChange)
    msEnableTileNotificationQueueForSquare310x310(fChange)
      => ComCall(82, this.p, VARIANT_BOOL, fChange)
    msScheduledTileNotification(bstrNotificationXml, bstrNotificationId, bstrNotificationTag, startTime, expirationTime)
      => ComCall(83, this.p, BSTR, bstrNotificationXml, BSTR, bstrNotificationId, BSTR, bstrNotificationTag, VARIANT, startTime, VARIANT, expirationTime)
    msRemoveScheduledTileNotification(bstrNotificationId)
      => ComCall(84, this.p, BSTR, bstrNotificationId)
    msStartPeriodicBadgeUpdate(pollingUri, startTime, uiUpdateRecurrence)
      => ComCall(85, this.p, BSTR, pollingUri, VARIANT, startTime, VARIANT, uiUpdateRecurrence)
    msStopPeriodicBadgeUpdate()
      => ComCall(86, this.p)
    msLaunchInternetOptions()
      => ComCall(87, this.p)
}
struct IShellUIHelper7 extends IShellUIHelper6 {
    static IID := "{60E567C8-9573-4AB2-A264-637C6C161CB1}"
    SetExperimentalFlag(bstrFlagString, vfFlag)
      => ComCall(88, this.p, BSTR, bstrFlagString, VARIANT_BOOL, vfFlag)
    GetExperimentalFlag(bstrFlagString, vfFlag)
      => ComCall(89, this.p, BSTR, bstrFlagString, VARIANT_BOOL.Ptr, vfFlag)
    SetExperimentalValue(bstrValueString, dwValue)
      => ComCall(90, this.p, BSTR, bstrValueString, UInt32, dwValue)
    GetExperimentalValue(bstrValueString, pdwValue)
      => ComCall(91, this.p, BSTR, bstrValueString, UInt32.Ptr, pdwValue)
    ResetAllExperimentalFlagsAndValues()
      => ComCall(92, this.p)
    GetNeedIEAutoLaunchFlag(bstrUrl, flag)
      => ComCall(93, this.p, BSTR, bstrUrl, VARIANT_BOOL.Ptr, flag)
    SetNeedIEAutoLaunchFlag(bstrUrl, flag)
      => ComCall(94, this.p, BSTR, bstrUrl, VARIANT_BOOL, flag)
    HasNeedIEAutoLaunchFlag(bstrUrl, exists)
      => ComCall(95, this.p, BSTR, bstrUrl, VARIANT_BOOL.Ptr, exists)
    LaunchIE(bstrUrl, automated)
      => ComCall(96, this.p, BSTR, bstrUrl, VARIANT_BOOL, automated)
}
struct IShellUIHelper8 extends IShellUIHelper7 {
    static IID := "{66DEBCF2-05B0-4F07-B49B-B96241A65DB2}"
    GetCVListData(pbstrResult)
      => ComCall(97, this.p, BSTR.Ptr, pbstrResult)
    GetCVListLocalData(pbstrResult)
      => ComCall(98, this.p, BSTR.Ptr, pbstrResult)
    GetEMIEListData(pbstrResult)
      => ComCall(99, this.p, BSTR.Ptr, pbstrResult)
    GetEMIEListLocalData(pbstrResult)
      => ComCall(100, this.p, BSTR.Ptr, pbstrResult)
    OpenFavoritesPane()
      => ComCall(101, this.p)
    OpenFavoritesSettings()
      => ComCall(102, this.p)
    LaunchInHVSI(bstrUrl)
      => ComCall(103, this.p, BSTR, bstrUrl)
}
struct IShellUIHelper9 extends IShellUIHelper8 {
    static IID := "{6CDF73B0-7F2F-451F-BC0F-63E0F3284E54}"
    GetOSSku(pdwResult)
      => ComCall(104, this.p, UInt32.Ptr, pdwResult)
}
struct DShellNameSpaceEvents extends IDispatch {
    static IID := "{55136806-B2DE-11D1-B9F2-00A0C98BC547}"
}
struct IShellFavoritesNameSpace extends IDispatch {
    static IID := "{55136804-B2DE-11D1-B9F2-00A0C98BC547}"
    MoveSelectionUp()
      => ComCall(7, this.p)
    MoveSelectionDown()
      => ComCall(8, this.p)
    ResetSort()
      => ComCall(9, this.p)
    NewFolder()
      => ComCall(10, this.p)
    Synchronize()
      => ComCall(11, this.p)
    Import()
      => ComCall(12, this.p)
    Export()
      => ComCall(13, this.p)
    InvokeContextMenuCommand(strCommand)
      => ComCall(14, this.p, BSTR, strCommand)
    MoveSelectionTo()
      => ComCall(15, this.p)
    get_SubscriptionsEnabled(pBool)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pBool)
    CreateSubscriptionForSelection(pBool)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pBool)
    DeleteSubscriptionForSelection(pBool)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pBool)
    SetRoot(bstrFullPath)
      => ComCall(19, this.p, BSTR, bstrFullPath)
}
struct IShellNameSpace extends IShellFavoritesNameSpace {
    static IID := "{E572D3C9-37BE-4AE2-825D-D521763E3108}"
    get_EnumOptions(pgrfEnumFlags)
      => ComCall(20, this.p, Int32.Ptr, pgrfEnumFlags)
    put_EnumOptions(lVal)
      => ComCall(21, this.p, Int32, lVal)
    get_SelectedItem(pItem)
      => ComCall(22, this.p, IDispatch.Ptr, pItem)
    put_SelectedItem(pItem)
      => ComCall(23, this.p, IDispatch, pItem)
    get_Root(pvar)
      => ComCall(24, this.p, VARIANT.Ptr, pvar)
    put_Root(var)
      => ComCall(25, this.p, VARIANT, var)
    get_Depth(piDepth)
      => ComCall(26, this.p, Int32.Ptr, piDepth)
    put_Depth(iDepth)
      => ComCall(27, this.p, Int32, iDepth)
    get_Mode(puMode)
      => ComCall(28, this.p, UInt32.Ptr, puMode)
    put_Mode(uMode)
      => ComCall(29, this.p, UInt32, uMode)
    get_Flags(pdwFlags)
      => ComCall(30, this.p, UInt32.Ptr, pdwFlags)
    put_Flags(dwFlags)
      => ComCall(31, this.p, UInt32, dwFlags)
    put_TVFlags(dwFlags)
      => ComCall(32, this.p, UInt32, dwFlags)
    get_TVFlags(dwFlags)
      => ComCall(33, this.p, UInt32.Ptr, dwFlags)
    get_Columns(bstrColumns)
      => ComCall(34, this.p, BSTR.Ptr, bstrColumns)
    put_Columns(bstrColumns)
      => ComCall(35, this.p, BSTR, bstrColumns)
    get_CountViewTypes(piTypes)
      => ComCall(36, this.p, Int32.Ptr, piTypes)
    SetViewType(iType)
      => ComCall(37, this.p, Int32, iType)
    SelectedItems(ppid)
      => ComCall(38, this.p, IDispatch.Ptr, ppid)
    Expand(var, iDepth)
      => ComCall(39, this.p, VARIANT, var, Int32, iDepth)
    UnselectAll()
      => ComCall(40, this.p)
}
struct IScriptErrorList extends IDispatch {
    static IID := "{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}"
    advanceError()
      => ComCall(7, this.p)
    retreatError()
      => ComCall(8, this.p)
    canAdvanceError(pfCanAdvance)
      => ComCall(9, this.p, BOOL.Ptr, pfCanAdvance)
    canRetreatError(pfCanRetreat)
      => ComCall(10, this.p, BOOL.Ptr, pfCanRetreat)
    getErrorLine(plLine)
      => ComCall(11, this.p, Int32.Ptr, plLine)
    getErrorChar(plChar)
      => ComCall(12, this.p, Int32.Ptr, plChar)
    getErrorCode(plCode)
      => ComCall(13, this.p, Int32.Ptr, plCode)
    getErrorMsg(pstr)
      => ComCall(14, this.p, BSTR.Ptr, pstr)
    getErrorUrl(pstr)
      => ComCall(15, this.p, BSTR.Ptr, pstr)
    getAlwaysShowLockState(pfAlwaysShowLocked)
      => ComCall(16, this.p, BOOL.Ptr, pfAlwaysShowLocked)
    getDetailsPaneOpen(pfDetailsPaneOpen)
      => ComCall(17, this.p, BOOL.Ptr, pfDetailsPaneOpen)
    setDetailsPaneOpen(fDetailsPaneOpen)
      => ComCall(18, this.p, BOOL, fDetailsPaneOpen)
    getPerErrorDisplay(pfPerErrorDisplay)
      => ComCall(19, this.p, BOOL.Ptr, pfPerErrorDisplay)
    setPerErrorDisplay(fPerErrorDisplay)
      => ComCall(20, this.p, BOOL, fPerErrorDisplay)
}
struct OfflineFolderStatus extends Int32 {
    static OFS_INACTIVE := -1
    static OFS_ONLINE := 0
    static OFS_OFFLINE := 1
    static OFS_SERVERBACK := 2
    static OFS_DIRTYCACHE := 3
}
struct ShellFolderViewOptions extends Int32 {
    static SFVVO_SHOWALLOBJECTS := 1
    static SFVVO_SHOWEXTENSIONS := 2
    static SFVVO_SHOWCOMPCOLOR := 8
    static SFVVO_SHOWSYSFILES := 32
    static SFVVO_WIN95CLASSIC := 64
    static SFVVO_DOUBLECLICKINWEBVIEW := 128
    static SFVVO_DESKTOPHTML := 512
}
struct ShellSpecialFolderConstants extends Int32 {
    static ssfDESKTOP := 0
    static ssfPROGRAMS := 2
    static ssfCONTROLS := 3
    static ssfPRINTERS := 4
    static ssfPERSONAL := 5
    static ssfFAVORITES := 6
    static ssfSTARTUP := 7
    static ssfRECENT := 8
    static ssfSENDTO := 9
    static ssfBITBUCKET := 10
    static ssfSTARTMENU := 11
    static ssfDESKTOPDIRECTORY := 16
    static ssfDRIVES := 17
    static ssfNETWORK := 18
    static ssfNETHOOD := 19
    static ssfFONTS := 20
    static ssfTEMPLATES := 21
    static ssfCOMMONSTARTMENU := 22
    static ssfCOMMONPROGRAMS := 23
    static ssfCOMMONSTARTUP := 24
    static ssfCOMMONDESKTOPDIR := 25
    static ssfAPPDATA := 26
    static ssfPRINTHOOD := 27
    static ssfLOCALAPPDATA := 28
    static ssfALTSTARTUP := 29
    static ssfCOMMONALTSTARTUP := 30
    static ssfCOMMONFAVORITES := 31
    static ssfINTERNETCACHE := 32
    static ssfCOOKIES := 33
    static ssfHISTORY := 34
    static ssfCOMMONAPPDATA := 35
    static ssfWINDOWS := 36
    static ssfSYSTEM := 37
    static ssfPROGRAMFILES := 38
    static ssfMYPICTURES := 39
    static ssfPROFILE := 40
    static ssfSYSTEMx86 := 41
    static ssfPROGRAMFILESx86 := 48
}
struct IFolderViewOC extends IDispatch {
    static IID := "{9BA05970-F6A8-11CF-A442-00A0C90A8F39}"
    SetFolderView(pdisp)
      => ComCall(7, this.p, IDispatch, pdisp)
}
struct DShellFolderViewEvents extends IDispatch {
    static IID := "{62112AA2-EBE4-11CF-A5FB-0020AFE7292D}"
}
struct DFConstraint extends IDispatch {
    static IID := "{4A3DF050-23BD-11D2-939F-00A0C91EEDBA}"
    get_Name(pbs)
      => ComCall(7, this.p, BSTR.Ptr, pbs)
    get_Value(pv)
      => ComCall(8, this.p, VARIANT.Ptr, pv)
}
struct FolderItem extends IDispatch {
    static IID := "{FAC32C80-CBE4-11CE-8350-444553540000}"
    get_Application(ppid)
      => ComCall(7, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Name(pbs)
      => ComCall(9, this.p, BSTR.Ptr, pbs)
    put_Name(bs)
      => ComCall(10, this.p, BSTR, bs)
    get_Path(pbs)
      => ComCall(11, this.p, BSTR.Ptr, pbs)
    get_GetLink(ppid)
      => ComCall(12, this.p, IDispatch.Ptr, ppid)
    get_GetFolder(ppid)
      => ComCall(13, this.p, IDispatch.Ptr, ppid)
    get_IsLink(pb)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pb)
    get_IsFolder(pb)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pb)
    get_IsFileSystem(pb)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pb)
    get_IsBrowsable(pb)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pb)
    get_ModifyDate(pdt)
      => ComCall(18, this.p, Float64.Ptr, pdt)
    put_ModifyDate(dt)
      => ComCall(19, this.p, Float64, dt)
    get_Size(pul)
      => ComCall(20, this.p, Int32.Ptr, pul)
    get_Type(pbs)
      => ComCall(21, this.p, BSTR.Ptr, pbs)
    Verbs(ppfic)
      => ComCall(22, this.p, FolderItemVerbs.Ptr, ppfic)
    InvokeVerb(vVerb)
      => ComCall(23, this.p, VARIANT, vVerb)
}
struct FolderItems extends IDispatch {
    static IID := "{744129E0-CBE5-11CE-8350-444553540000}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_Application(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(9, this.p, IDispatch.Ptr, ppid)
    Item(index, ppid)
      => ComCall(10, this.p, VARIANT, index, FolderItem.Ptr, ppid)
    _NewEnum(ppunk)
      => ComCall(11, this.p, IUnknown.Ptr, ppunk)
}
struct FolderItemVerb extends IDispatch {
    static IID := "{08EC3E00-50B0-11CF-960C-0080C7F4EE85}"
    get_Application(ppid)
      => ComCall(7, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Name(pbs)
      => ComCall(9, this.p, BSTR.Ptr, pbs)
    DoIt()
      => ComCall(10, this.p)
}
struct FolderItemVerbs extends IDispatch {
    static IID := "{1F8352C0-50B0-11CF-960C-0080C7F4EE85}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_Application(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(9, this.p, IDispatch.Ptr, ppid)
    Item(index, ppid)
      => ComCall(10, this.p, VARIANT, index, FolderItemVerb.Ptr, ppid)
    _NewEnum(ppunk)
      => ComCall(11, this.p, IUnknown.Ptr, ppunk)
}
struct Folder extends IDispatch {
    static IID := "{BBCBDE60-C3FF-11CE-8350-444553540000}"
    get_Title(pbs)
      => ComCall(7, this.p, BSTR.Ptr, pbs)
    get_Application(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(9, this.p, IDispatch.Ptr, ppid)
    get_ParentFolder(ppsf)
      => ComCall(10, this.p, Folder.Ptr, ppsf)
    Items(ppid)
      => ComCall(11, this.p, FolderItems.Ptr, ppid)
    ParseName(bName, ppid)
      => ComCall(12, this.p, BSTR, bName, FolderItem.Ptr, ppid)
    NewFolder(bName, vOptions)
      => ComCall(13, this.p, BSTR, bName, VARIANT, vOptions)
    MoveHere(vItem, vOptions)
      => ComCall(14, this.p, VARIANT, vItem, VARIANT, vOptions)
    CopyHere(vItem, vOptions)
      => ComCall(15, this.p, VARIANT, vItem, VARIANT, vOptions)
    GetDetailsOf(vItem, iColumn, pbs)
      => ComCall(16, this.p, VARIANT, vItem, Int32, iColumn, BSTR.Ptr, pbs)
}
struct Folder2 extends Folder {
    static IID := "{F0D2D8EF-3890-11D2-BF8B-00C04FB93661}"
    get_Self(ppfi)
      => ComCall(17, this.p, FolderItem.Ptr, ppfi)
    get_OfflineStatus(pul)
      => ComCall(18, this.p, Int32.Ptr, pul)
    Synchronize()
      => ComCall(19, this.p)
    get_HaveToShowWebViewBarricade(pbHaveToShowWebViewBarricade)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, pbHaveToShowWebViewBarricade)
    DismissedWebViewBarricade()
      => ComCall(21, this.p)
}
struct Folder3 extends Folder2 {
    static IID := "{A7AE5F64-C4D7-4D7F-9307-4D24EE54B841}"
    get_ShowWebViewBarricade(pbShowWebViewBarricade)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, pbShowWebViewBarricade)
    put_ShowWebViewBarricade(bShowWebViewBarricade)
      => ComCall(23, this.p, VARIANT_BOOL, bShowWebViewBarricade)
}
struct FolderItem2 extends FolderItem {
    static IID := "{EDC817AA-92B8-11D1-B075-00C04FC33AA5}"
    InvokeVerbEx(vVerb, vArgs)
      => ComCall(24, this.p, VARIANT, vVerb, VARIANT, vArgs)
    ExtendedProperty(bstrPropName, pvRet)
      => ComCall(25, this.p, BSTR, bstrPropName, VARIANT.Ptr, pvRet)
}
struct FolderItems2 extends FolderItems {
    static IID := "{C94F0AD0-F363-11D2-A327-00C04F8EEC7F}"
    InvokeVerbEx(vVerb, vArgs)
      => ComCall(12, this.p, VARIANT, vVerb, VARIANT, vArgs)
}
struct FolderItems3 extends FolderItems2 {
    static IID := "{EAA7C309-BBEC-49D5-821D-64D966CB667F}"
    Filter(grfFlags, bstrFileSpec)
      => ComCall(13, this.p, Int32, grfFlags, BSTR, bstrFileSpec)
    get_Verbs(ppfic)
      => ComCall(14, this.p, FolderItemVerbs.Ptr, ppfic)
}
struct IShellLinkDual extends IDispatch {
    static IID := "{88A05C00-F000-11CE-8350-444553540000}"
    get_Path(pbs)
      => ComCall(7, this.p, BSTR.Ptr, pbs)
    put_Path(bs)
      => ComCall(8, this.p, BSTR, bs)
    get_Description(pbs)
      => ComCall(9, this.p, BSTR.Ptr, pbs)
    put_Description(bs)
      => ComCall(10, this.p, BSTR, bs)
    get_WorkingDirectory(pbs)
      => ComCall(11, this.p, BSTR.Ptr, pbs)
    put_WorkingDirectory(bs)
      => ComCall(12, this.p, BSTR, bs)
    get_Arguments(pbs)
      => ComCall(13, this.p, BSTR.Ptr, pbs)
    put_Arguments(bs)
      => ComCall(14, this.p, BSTR, bs)
    get_Hotkey(piHK)
      => ComCall(15, this.p, Int32.Ptr, piHK)
    put_Hotkey(iHK)
      => ComCall(16, this.p, Int32, iHK)
    get_ShowCommand(piShowCommand)
      => ComCall(17, this.p, Int32.Ptr, piShowCommand)
    put_ShowCommand(iShowCommand)
      => ComCall(18, this.p, Int32, iShowCommand)
    Resolve(fFlags)
      => ComCall(19, this.p, Int32, fFlags)
    GetIconLocation(pbs, piIcon)
      => ComCall(20, this.p, BSTR.Ptr, pbs, Int32.Ptr, piIcon)
    SetIconLocation(bs, iIcon)
      => ComCall(21, this.p, BSTR, bs, Int32, iIcon)
    Save(vWhere)
      => ComCall(22, this.p, VARIANT, vWhere)
}
struct IShellLinkDual2 extends IShellLinkDual {
    static IID := "{317EE249-F12E-11D2-B1E4-00C04F8EEB3E}"
    get_Target(ppfi)
      => ComCall(23, this.p, FolderItem.Ptr, ppfi)
}
struct IShellFolderViewDual extends IDispatch {
    static IID := "{E7A1AF80-4D96-11CF-960C-0080C7F4EE85}"
    get_Application(ppid)
      => ComCall(7, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    get_Folder(ppid)
      => ComCall(9, this.p, Folder.Ptr, ppid)
    SelectedItems(ppid)
      => ComCall(10, this.p, FolderItems.Ptr, ppid)
    get_FocusedItem(ppid)
      => ComCall(11, this.p, FolderItem.Ptr, ppid)
    SelectItem(pvfi, dwFlags)
      => ComCall(12, this.p, VARIANT.Ptr, pvfi, Int32, dwFlags)
    PopupItemMenu(pfi, vx, vy, pbs)
      => ComCall(13, this.p, FolderItem, pfi, VARIANT, vx, VARIANT, vy, BSTR.Ptr, pbs)
    get_Script(ppDisp)
      => ComCall(14, this.p, IDispatch.Ptr, ppDisp)
    get_ViewOptions(plViewOptions)
      => ComCall(15, this.p, Int32.Ptr, plViewOptions)
}
struct IShellFolderViewDual2 extends IShellFolderViewDual {
    static IID := "{31C147B6-0ADE-4A3C-B514-DDF932EF6D17}"
    get_CurrentViewMode(pViewMode)
      => ComCall(16, this.p, UInt32.Ptr, pViewMode)
    put_CurrentViewMode(ViewMode)
      => ComCall(17, this.p, UInt32, ViewMode)
    SelectItemRelative(iRelative)
      => ComCall(18, this.p, Int32, iRelative)
}
struct IShellFolderViewDual3 extends IShellFolderViewDual2 {
    static IID := "{29EC8E6C-46D3-411F-BAAA-611A6C9CAC66}"
    get_GroupBy(pbstrGroupBy)
      => ComCall(19, this.p, BSTR.Ptr, pbstrGroupBy)
    put_GroupBy(bstrGroupBy)
      => ComCall(20, this.p, BSTR, bstrGroupBy)
    get_FolderFlags(pdwFlags)
      => ComCall(21, this.p, UInt32.Ptr, pdwFlags)
    put_FolderFlags(dwFlags)
      => ComCall(22, this.p, UInt32, dwFlags)
    get_SortColumns(pbstrSortColumns)
      => ComCall(23, this.p, BSTR.Ptr, pbstrSortColumns)
    put_SortColumns(bstrSortColumns)
      => ComCall(24, this.p, BSTR, bstrSortColumns)
    put_IconSize(iIconSize)
      => ComCall(25, this.p, Int32, iIconSize)
    get_IconSize(piIconSize)
      => ComCall(26, this.p, Int32.Ptr, piIconSize)
    FilterView(bstrFilterText)
      => ComCall(27, this.p, BSTR, bstrFilterText)
}
struct IShellDispatch extends IDispatch {
    static IID := "{D8F015C0-C278-11CE-A49E-444553540000}"
    get_Application(ppid)
      => ComCall(7, this.p, IDispatch.Ptr, ppid)
    get_Parent(ppid)
      => ComCall(8, this.p, IDispatch.Ptr, ppid)
    NameSpace(vDir, ppsdf)
      => ComCall(9, this.p, VARIANT, vDir, Folder.Ptr, ppsdf)
    BrowseForFolder(Hwnd, Title, Options, RootFolder, ppsdf)
      => ComCall(10, this.p, Int32, Hwnd, BSTR, Title, Int32, Options, VARIANT, RootFolder, Folder.Ptr, ppsdf)
    Windows(ppid)
      => ComCall(11, this.p, IDispatch.Ptr, ppid)
    Open(vDir)
      => ComCall(12, this.p, VARIANT, vDir)
    Explore(vDir)
      => ComCall(13, this.p, VARIANT, vDir)
    MinimizeAll()
      => ComCall(14, this.p)
    UndoMinimizeALL()
      => ComCall(15, this.p)
    FileRun()
      => ComCall(16, this.p)
    CascadeWindows()
      => ComCall(17, this.p)
    TileVertically()
      => ComCall(18, this.p)
    TileHorizontally()
      => ComCall(19, this.p)
    ShutdownWindows()
      => ComCall(20, this.p)
    Suspend()
      => ComCall(21, this.p)
    EjectPC()
      => ComCall(22, this.p)
    SetTime()
      => ComCall(23, this.p)
    TrayProperties()
      => ComCall(24, this.p)
    Help()
      => ComCall(25, this.p)
    FindFiles()
      => ComCall(26, this.p)
    FindComputer()
      => ComCall(27, this.p)
    RefreshMenu()
      => ComCall(28, this.p)
    ControlPanelItem(bstrDir)
      => ComCall(29, this.p, BSTR, bstrDir)
}
struct IShellDispatch2 extends IShellDispatch {
    static IID := "{A4C6892C-3BA9-11D2-9DEA-00C04FB16162}"
    IsRestricted(Group, Restriction, plRestrictValue)
      => ComCall(30, this.p, BSTR, Group, BSTR, Restriction, Int32.Ptr, plRestrictValue)
    ShellExecute(File, vArgs, vDir, vOperation, vShow)
      => ComCall(31, this.p, BSTR, File, VARIANT, vArgs, VARIANT, vDir, VARIANT, vOperation, VARIANT, vShow)
    FindPrinter(name, location, model)
      => ComCall(32, this.p, BSTR, name, BSTR, location, BSTR, model)
    GetSystemInformation(name, pv)
      => ComCall(33, this.p, BSTR, name, VARIANT.Ptr, pv)
    ServiceStart(ServiceName, Persistent, pSuccess)
      => ComCall(34, this.p, BSTR, ServiceName, VARIANT, Persistent, VARIANT.Ptr, pSuccess)
    ServiceStop(ServiceName, Persistent, pSuccess)
      => ComCall(35, this.p, BSTR, ServiceName, VARIANT, Persistent, VARIANT.Ptr, pSuccess)
    IsServiceRunning(ServiceName, pRunning)
      => ComCall(36, this.p, BSTR, ServiceName, VARIANT.Ptr, pRunning)
    CanStartStopService(ServiceName, pCanStartStop)
      => ComCall(37, this.p, BSTR, ServiceName, VARIANT.Ptr, pCanStartStop)
    ShowBrowserBar(bstrClsid, bShow, pSuccess)
      => ComCall(38, this.p, BSTR, bstrClsid, VARIANT, bShow, VARIANT.Ptr, pSuccess)
}
struct IShellDispatch3 extends IShellDispatch2 {
    static IID := "{177160CA-BB5A-411C-841D-BD38FACDEAA0}"
    AddToRecent(varFile, bstrCategory)
      => ComCall(39, this.p, VARIANT, varFile, BSTR, bstrCategory)
}
struct IShellDispatch4 extends IShellDispatch3 {
    static IID := "{EFD84B2D-4BCF-4298-BE25-EB542A59FBDA}"
    WindowsSecurity()
      => ComCall(40, this.p)
    ToggleDesktop()
      => ComCall(41, this.p)
    ExplorerPolicy(bstrPolicyName, pValue)
      => ComCall(42, this.p, BSTR, bstrPolicyName, VARIANT.Ptr, pValue)
    GetSetting(lSetting, pResult)
      => ComCall(43, this.p, Int32, lSetting, VARIANT_BOOL.Ptr, pResult)
}
struct IShellDispatch5 extends IShellDispatch4 {
    static IID := "{866738B9-6CF2-4DE8-8767-F794EBE74F4E}"
    WindowSwitcher()
      => ComCall(44, this.p)
}
struct IShellDispatch6 extends IShellDispatch5 {
    static IID := "{286E6F1B-7113-4355-9562-96B7E9D64C54}"
    SearchCommand()
      => ComCall(45, this.p)
}
struct IFileSearchBand extends IDispatch {
    static IID := "{2D91EEA1-9932-11D2-BE86-00A0C9A83DA1}"
    SetFocus()
      => ComCall(7, this.p)
    SetSearchParameters(pbstrSearchID, bNavToResults, pvarScope, pvarQueryFile)
      => ComCall(8, this.p, BSTR.Ptr, pbstrSearchID, VARIANT_BOOL, bNavToResults, VARIANT.Ptr, pvarScope, VARIANT.Ptr, pvarQueryFile)
    get_SearchID(pbstrSearchID)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSearchID)
    get_Scope(pvarScope)
      => ComCall(10, this.p, VARIANT.Ptr, pvarScope)
    get_QueryFile(pvarFile)
      => ComCall(11, this.p, VARIANT.Ptr, pvarFile)
}
struct IWebWizardHost extends IDispatch {
    static IID := "{18BCC359-4990-4BFB-B951-3C83702BE5F9}"
    FinalBack()
      => ComCall(7, this.p)
    FinalNext()
      => ComCall(8, this.p)
    Cancel()
      => ComCall(9, this.p)
    put_Caption(bstrCaption)
      => ComCall(10, this.p, BSTR, bstrCaption)
    get_Caption(pbstrCaption)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCaption)
    put_Property(bstrPropertyName, pvProperty)
      => ComCall(12, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, pvProperty)
    get_Property(bstrPropertyName, pvProperty)
      => ComCall(13, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, pvProperty)
    SetWizardButtons(vfEnableBack, vfEnableNext, vfLastPage)
      => ComCall(14, this.p, VARIANT_BOOL, vfEnableBack, VARIANT_BOOL, vfEnableNext, VARIANT_BOOL, vfLastPage)
    SetHeaderText(bstrHeaderTitle, bstrHeaderSubtitle)
      => ComCall(15, this.p, BSTR, bstrHeaderTitle, BSTR, bstrHeaderSubtitle)
}
struct IWebWizardHost2 extends IWebWizardHost {
    static IID := "{F9C013DC-3C23-4041-8E39-CFB402F7EA59}"
    SignString(value, signedValue)
      => ComCall(16, this.p, BSTR, value, BSTR.Ptr, signedValue)
}
struct INewWDEvents extends IWebWizardHost {
    static IID := "{0751C551-7568-41C9-8E5B-E22E38919236}"
    PassportAuthenticate(bstrSignInUrl, pvfAuthenitcated)
      => ComCall(16, this.p, BSTR, bstrSignInUrl, VARIANT_BOOL.Ptr, pvfAuthenitcated)
}
struct IAutoComplete extends IUnknown {
    static IID := "{00BB2762-6A77-11D0-A535-00C04FD7D062}"
    Init(hwndEdit, punkACL, pwszRegKeyPath?, pwszQuickComplete?)
      => ComCall(3, this.p, HWND, hwndEdit, IUnknown, punkACL, "Str", pwszRegKeyPath?, "Str", pwszQuickComplete?)
    Enable(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
}
struct AUTOCOMPLETEOPTIONS extends Int32 {
    static ACO_NONE := 0
    static ACO_AUTOSUGGEST := 1
    static ACO_AUTOAPPEND := 2
    static ACO_SEARCH := 4
    static ACO_FILTERPREFIXES := 8
    static ACO_USETAB := 16
    static ACO_UPDOWNKEYDROPSLIST := 32
    static ACO_RTLREADING := 64
    static ACO_WORD_FILTER := 128
    static ACO_NOPREFIXFILTERING := 256
}
struct IAutoComplete2 extends IAutoComplete {
    static IID := "{EAC04BC0-3791-11D2-BB95-0060977B464C}"
    SetOptions(dwFlag)
      => ComCall(5, this.p, UInt32, dwFlag)
    GetOptions(pdwFlag)
      => ComCall(6, this.p, UInt32.Ptr, pdwFlag)
}
struct ACENUMOPTION extends Int32 {
    static ACEO_NONE := 0
    static ACEO_MOSTRECENTFIRST := 1
    static ACEO_FIRSTUNUSED := 65536
}
struct IEnumACString extends IEnumString {
    static IID := "{8E74C210-CF9D-4EAF-A403-7356428F0A5A}"
    NextItem(pszUrl?, pulSortIndex)
      => ComCall(7, this.p, PWSTR, pszUrl?, UInt32, pszUrl?.Length ?? 0, UInt32.Ptr, pulSortIndex)
    SetEnumOptions(dwOptions)
      => ComCall(8, this.p, UInt32, dwOptions)
    GetEnumOptions(pdwOptions)
      => ComCall(9, this.p, UInt32.Ptr, pdwOptions)
}
struct IDataObjectAsyncCapability extends IUnknown {
    static IID := "{3D8B0590-F691-11D2-8EA9-006097DF5BD4}"
    SetAsyncMode(fDoOpAsync)
      => ComCall(3, this.p, BOOL, fDoOpAsync)
    GetAsyncMode(pfIsOpAsync)
      => ComCall(4, this.p, BOOL.Ptr, pfIsOpAsync)
    StartOperation(pbcReserved?)
      => ComCall(5, this.p, IBindCtx, pbcReserved?)
    InOperation(pfInAsyncOp)
      => ComCall(6, this.p, BOOL.Ptr, pfInAsyncOp)
    EndOperation(hResult1, pbcReserved, dwEffects)
      => ComCall(7, this.p, HRESULT, hResult1, IBindCtx, pbcReserved, UInt32, dwEffects)
}
struct IExtractIconA extends IUnknown {
    static IID := "{000214EB-0000-0000-C000-000000000046}"
    GetIconLocation(uFlags, pszIconFile, piIndex, pwFlags)
      => ComCall(3, this.p, UInt32, uFlags, PSTR, pszIconFile, UInt32, pszIconFile.Length, Int32.Ptr, piIndex, UInt32.Ptr, pwFlags)
    Extract(pszFile, nIconIndex, phiconLarge?, phiconSmall?, nIconSize)
      => ComCall(4, this.p, PSTR, pszFile, UInt32, nIconIndex, HICON.Ptr, phiconLarge?, HICON.Ptr, phiconSmall?, UInt32, nIconSize)
}
struct IExtractIconW extends IUnknown {
    static IID := "{000214FA-0000-0000-C000-000000000046}"
    GetIconLocation(uFlags, pszIconFile, piIndex, pwFlags)
      => ComCall(3, this.p, UInt32, uFlags, PWSTR, pszIconFile, UInt32, pszIconFile.Length, Int32.Ptr, piIndex, UInt32.Ptr, pwFlags)
    Extract(pszFile, nIconIndex, phiconLarge?, phiconSmall?, nIconSize)
      => ComCall(4, this.p, "Str", pszFile, UInt32, nIconIndex, HICON.Ptr, phiconLarge?, HICON.Ptr, phiconSmall?, UInt32, nIconSize)
}
struct IShellIconOverlayManager extends IUnknown {
    static IID := "{F10B5E34-DD3B-42A7-AA7D-2F4EC54BB09B}"
    GetFileOverlayInfo(pwszPath, dwAttrib, pIndex, dwflags)
      => ComCall(3, this.p, "Str", pwszPath, UInt32, dwAttrib, Int32.Ptr, pIndex, UInt32, dwflags)
    GetReservedOverlayInfo(pwszPath?, dwAttrib, pIndex, dwflags, iReservedID)
      => ComCall(4, this.p, "Str", pwszPath?, UInt32, dwAttrib, Int32.Ptr, pIndex, UInt32, dwflags, Int32, iReservedID)
    RefreshOverlayImages(dwFlags)
      => ComCall(5, this.p, UInt32, dwFlags)
    LoadNonloadedOverlayIdentifiers()
      => ComCall(6, this.p)
    OverlayIndexFromImageIndex(iImage, piIndex, fAdd)
      => ComCall(7, this.p, Int32, iImage, Int32.Ptr, piIndex, BOOL, fAdd)
}
struct IShellIconOverlay extends IUnknown {
    static IID := "{7D688A70-C613-11D0-999B-00C04FD655E1}"
    GetOverlayIndex(pidl, pIndex)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidl, Int32.Ptr, pIndex)
    GetOverlayIconIndex(pidl, pIconIndex)
      => ComCall(4, this.p, ITEMIDLIST.Ptr, pidl, Int32.Ptr, pIconIndex)
}
struct SHELL_LINK_DATA_FLAGS extends Int32 {
    static SLDF_DEFAULT := 0
    static SLDF_HAS_ID_LIST := 1
    static SLDF_HAS_LINK_INFO := 2
    static SLDF_HAS_NAME := 4
    static SLDF_HAS_RELPATH := 8
    static SLDF_HAS_WORKINGDIR := 16
    static SLDF_HAS_ARGS := 32
    static SLDF_HAS_ICONLOCATION := 64
    static SLDF_UNICODE := 128
    static SLDF_FORCE_NO_LINKINFO := 256
    static SLDF_HAS_EXP_SZ := 512
    static SLDF_RUN_IN_SEPARATE := 1024
    static SLDF_HAS_DARWINID := 4096
    static SLDF_RUNAS_USER := 8192
    static SLDF_HAS_EXP_ICON_SZ := 16384
    static SLDF_NO_PIDL_ALIAS := 32768
    static SLDF_FORCE_UNCNAME := 65536
    static SLDF_RUN_WITH_SHIMLAYER := 131072
    static SLDF_FORCE_NO_LINKTRACK := 262144
    static SLDF_ENABLE_TARGET_METADATA := 524288
    static SLDF_DISABLE_LINK_PATH_TRACKING := 1048576
    static SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING := 2097152
    static SLDF_NO_KF_ALIAS := 4194304
    static SLDF_ALLOW_LINK_TO_LINK := 8388608
    static SLDF_UNALIAS_ON_SAVE := 16777216
    static SLDF_PREFER_ENVIRONMENT_PATH := 33554432
    static SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET := 67108864
    static SLDF_PERSIST_VOLUME_ID_RELATIVE := 134217728
    static SLDF_VALID := 268433407
    static SLDF_RESERVED := -2147483648
}
struct DATABLOCK_HEADER {
    cbSize : UInt32 := this.Size
    dwSignature : UInt32
}
struct NT_CONSOLE_PROPS {
    dbh : DATABLOCK_HEADER
    wFillAttribute : UInt16
    wPopupFillAttribute : UInt16
    dwScreenBufferSize : COORD
    dwWindowSize : COORD
    dwWindowOrigin : COORD
    nFont : UInt32
    nInputBufferSize : UInt32
    dwFontSize : COORD
    uFontFamily : UInt32
    uFontWeight : UInt32
    FaceName : UInt16[32]
    uCursorSize : UInt32
    bFullScreen : BOOL
    bQuickEdit : BOOL
    bInsertMode : BOOL
    bAutoPosition : BOOL
    uHistoryBufferSize : UInt32
    uNumberOfHistoryBuffers : UInt32
    bHistoryNoDup : BOOL
    ColorTable : COLORREF[16]
}
struct NT_FE_CONSOLE_PROPS {
    dbh : DATABLOCK_HEADER
    uCodePage : UInt32
}
struct EXP_DARWIN_LINK {
    dbh : DATABLOCK_HEADER
    szDarwinID : CHAR[260]
    szwDarwinID : UInt16[260]
}
struct EXP_SPECIAL_FOLDER {
    cbSize : UInt32 := this.Size
    dwSignature : UInt32
    idSpecialFolder : UInt32
    cbOffset : UInt32
}
struct EXP_SZ_LINK {
    cbSize : UInt32 := this.Size
    dwSignature : UInt32
    szTarget : CHAR[260]
    swzTarget : UInt16[260]
}
struct EXP_PROPERTYSTORAGE {
    cbSize : UInt32 := this.Size
    dwSignature : UInt32
    abPropertyStorage : UInt8[1]
}
struct IURLSearchHook extends IUnknown {
    static IID := "{AC60F6A0-0FD9-11D0-99CB-00C04FD64497}"
    Translate(pwszSearchURL)
      => ComCall(3, this.p, PWSTR, pwszSearchURL, UInt32, pwszSearchURL.Length)
}
struct ISearchContext extends IUnknown {
    static IID := "{09F656A2-41AF-480C-88F7-16CC0D164615}"
    GetSearchUrl(pbstrSearchUrl)
      => ComCall(3, this.p, BSTR.Ptr, pbstrSearchUrl)
    GetSearchText(pbstrSearchText)
      => ComCall(4, this.p, BSTR.Ptr, pbstrSearchText)
    GetSearchStyle(pdwSearchStyle)
      => ComCall(5, this.p, UInt32.Ptr, pdwSearchStyle)
}
struct IURLSearchHook2 extends IURLSearchHook {
    static IID := "{5EE44DA4-6D32-46E3-86BC-07540DEDD0E0}"
    TranslateWithSearchContext(pwszSearchURL, pSearchContext?)
      => ComCall(4, this.p, PWSTR, pwszSearchURL, UInt32, pwszSearchURL.Length, ISearchContext, pSearchContext?)
}
struct SHGFP_TYPE extends Int32 {
    static SHGFP_TYPE_CURRENT := 0
    static SHGFP_TYPE_DEFAULT := 1
}
struct KNOWN_FOLDER_FLAG extends Int32 {
    static KF_FLAG_DEFAULT := 0
    static KF_FLAG_FORCE_APP_DATA_REDIRECTION := 524288
    static KF_FLAG_RETURN_FILTER_REDIRECTION_TARGET := 262144
    static KF_FLAG_FORCE_PACKAGE_REDIRECTION := 131072
    static KF_FLAG_NO_PACKAGE_REDIRECTION := 65536
    static KF_FLAG_FORCE_APPCONTAINER_REDIRECTION := 131072
    static KF_FLAG_NO_APPCONTAINER_REDIRECTION := 65536
    static KF_FLAG_CREATE := 32768
    static KF_FLAG_DONT_VERIFY := 16384
    static KF_FLAG_DONT_UNEXPAND := 8192
    static KF_FLAG_NO_ALIAS := 4096
    static KF_FLAG_INIT := 2048
    static KF_FLAG_DEFAULT_PATH := 1024
    static KF_FLAG_NOT_PARENT_RELATIVE := 512
    static KF_FLAG_SIMPLE_IDLIST := 256
    static KF_FLAG_ALIAS_ONLY := -2147483648
}
struct SHFOLDERCUSTOMSETTINGS {
    dwSize : UInt32
    dwMask : UInt32
    pvid : GUID.Ptr
    pszWebViewTemplate : PWSTR
    cchWebViewTemplate : UInt32
    pszWebViewTemplateVersion : PWSTR
    pszInfoTip : PWSTR
    cchInfoTip : UInt32
    pclsid : GUID.Ptr
    dwFlags : UInt32
    pszIconFile : PWSTR
    cchIconFile : UInt32
    iIconIndex : Int32
    pszLogo : PWSTR
    cchLogo : UInt32
}
struct BFFCALLBACK extends FunctionPointer {
    static Types := [HWND, UInt32, LPARAM, LPARAM, Int32]
}
struct BROWSEINFOA {
    hwndOwner : HWND
    pidlRoot : ITEMIDLIST.Ptr
    pszDisplayName : PSTR
    lpszTitle : PSTR
    ulFlags : UInt32
    lpfn : BFFCALLBACK
    lParam : LPARAM
    iImage : Int32
}
struct BROWSEINFOW {
    hwndOwner : HWND
    pidlRoot : ITEMIDLIST.Ptr
    pszDisplayName : PWSTR
    lpszTitle : PWSTR
    ulFlags : UInt32
    lpfn : BFFCALLBACK
    lParam : LPARAM
    iImage : Int32
}
struct IShellDetails extends IUnknown {
    static IID := "{000214EC-0000-0000-C000-000000000046}"
    GetDetailsOf(pidl?, iColumn, pDetails)
      => ComCall(3, this.p, ITEMIDLIST.Ptr, pidl?, UInt32, iColumn, SHELLDETAILS.Ptr, pDetails)
    ColumnClick(iColumn)
      => ComCall(4, this.p, UInt32, iColumn)
}
struct IObjMgr extends IUnknown {
    static IID := "{00BB2761-6A77-11D0-A535-00C04FD7D062}"
    Append(punk)
      => ComCall(3, this.p, IUnknown, punk)
    Remove(punk)
      => ComCall(4, this.p, IUnknown, punk)
}
struct IACList extends IUnknown {
    static IID := "{77A130B0-94FD-11D0-A544-00C04FD7D062}"
    Expand(pszExpand)
      => ComCall(3, this.p, "Str", pszExpand)
}
struct AUTOCOMPLETELISTOPTIONS extends Int32 {
    static ACLO_NONE := 0
    static ACLO_CURRENTDIR := 1
    static ACLO_MYCOMPUTER := 2
    static ACLO_DESKTOP := 4
    static ACLO_FAVORITES := 8
    static ACLO_FILESYSONLY := 16
    static ACLO_FILESYSDIRS := 32
    static ACLO_VIRTUALNAMESPACE := 64
}
struct IACList2 extends IACList {
    static IID := "{470141A0-5186-11D2-BBB6-0060977B464C}"
    SetOptions(dwFlag)
      => ComCall(4, this.p, UInt32, dwFlag)
    GetOptions(pdwFlag)
      => ComCall(5, this.p, UInt32.Ptr, pdwFlag)
}
struct IProgressDialog extends IUnknown {
    static IID := "{EBBC7C04-315E-11D2-B62F-006097DF5BD4}"
    StartProgressDialog(hwndParent?, punkEnableModless?, dwFlags)
      => ComCall(3, this.p, HWND, hwndParent?, IUnknown, punkEnableModless?, UInt32, dwFlags, "Ptr", 0)
    StopProgressDialog()
      => ComCall(4, this.p)
    SetTitle(pwzTitle)
      => ComCall(5, this.p, "Str", pwzTitle)
    SetAnimation(hInstAnimation?, idAnimation)
      => ComCall(6, this.p, HINSTANCE, hInstAnimation?, UInt32, idAnimation)
    HasUserCancelled()
      => ComCall(7, this.p, BOOL)
    SetProgress(dwCompleted, dwTotal)
      => ComCall(8, this.p, UInt32, dwCompleted, UInt32, dwTotal)
    SetProgress64(ullCompleted, ullTotal)
      => ComCall(9, this.p, Int64, ullCompleted, Int64, ullTotal)
    SetLine(dwLineNum, pwzString, fCompactPath)
      => ComCall(10, this.p, UInt32, dwLineNum, "Str", pwzString, BOOL, fCompactPath, "Ptr", 0)
    SetCancelMsg(pwzCancelMsg)
      => ComCall(11, this.p, "Str", pwzCancelMsg, "Ptr", 0)
    Timer(dwTimerAction)
      => ComCall(12, this.p, UInt32, dwTimerAction, "Ptr", 0)
}
struct IDockingWindowSite extends IOleWindow {
    static IID := "{2A342FC2-7B26-11D0-8CA9-00A0C92DBFE8}"
    GetBorderDW(punkObj, prcBorder)
      => ComCall(5, this.p, IUnknown, punkObj, RECT.Ptr, prcBorder)
    RequestBorderSpaceDW(punkObj, pbw)
      => ComCall(6, this.p, IUnknown, punkObj, RECT.Ptr, pbw)
    SetBorderSpaceDW(punkObj, pbw)
      => ComCall(7, this.p, IUnknown, punkObj, RECT.Ptr, pbw)
}
struct NRESARRAY {
    cItems : UInt32
    nr : NETRESOURCEA[1]
}
struct CIDA {
    cidl : UInt32
    aoffset : UInt32[1]
}
struct FD_FLAGS extends Int32 {
    static FD_CLSID := 1
    static FD_SIZEPOINT := 2
    static FD_ATTRIBUTES := 4
    static FD_CREATETIME := 8
    static FD_ACCESSTIME := 16
    static FD_WRITESTIME := 32
    static FD_FILESIZE := 64
    static FD_PROGRESSUI := 16384
    static FD_LINKUI := 32768
    static FD_UNICODE := -2147483648
}
struct FILEDESCRIPTORA {
    dwFlags : UInt32
    clsid : GUID
    sizel : SIZE
    pointl : POINTL
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
    cFileName : CHAR[260]
}
struct FILEDESCRIPTORW {
    dwFlags : UInt32
    clsid : GUID
    sizel : SIZE
    pointl : POINTL
    dwFileAttributes : UInt32
    ftCreationTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastWriteTime : FILETIME
    nFileSizeHigh : UInt32
    nFileSizeLow : UInt32
    cFileName : UInt16[260]
}
struct FILEGROUPDESCRIPTORA {
    cItems : UInt32
    fgd : FILEDESCRIPTORA[1]
}
struct FILEGROUPDESCRIPTORW {
    cItems : UInt32
    fgd : FILEDESCRIPTORW[1]
}
struct DROPFILES {
    pFiles : UInt32
    pt : POINT
    fNC : BOOL
    fWide : BOOL
}
struct FILE_ATTRIBUTES_ARRAY {
    cItems : UInt32
    dwSumFileAttributes : UInt32
    dwProductFileAttributes : UInt32
    rgdwFileAttributes : UInt32[1]
}
struct DROPIMAGETYPE extends Int32 {
    static DROPIMAGE_INVALID := -1
    static DROPIMAGE_NONE := 0
    static DROPIMAGE_COPY := 1
    static DROPIMAGE_MOVE := 2
    static DROPIMAGE_LINK := 4
    static DROPIMAGE_LABEL := 6
    static DROPIMAGE_WARNING := 7
    static DROPIMAGE_NOIMAGE := 8
}
struct DROPDESCRIPTION {
    type : DROPIMAGETYPE
    szMessage : UInt16[260]
    szInsert : UInt16[260]
}
struct SHChangeNotifyEntry {
    pidl : ITEMIDLIST.Ptr
    fRecursive : BOOL
}
struct IShellChangeNotify extends IUnknown {
    static IID := "{D82BE2B1-5764-11D0-A96E-00C04FD705A2}"
    OnChange(lEvent, pidl1?, pidl2?)
      => ComCall(3, this.p, Int32, lEvent, ITEMIDLIST.Ptr, pidl1?, ITEMIDLIST.Ptr, pidl2?)
}
struct IQueryInfo extends IUnknown {
    static IID := "{00021500-0000-0000-C000-000000000046}"
    GetInfoTip(dwFlags, ppwszTip)
      => ComCall(3, this.p, UInt32, dwFlags, PWSTR.Ptr, ppwszTip)
    GetInfoFlags(pdwFlags)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags)
}
struct SHARD extends Int32 {
    static SHARD_PIDL := 1
    static SHARD_PATHA := 2
    static SHARD_PATHW := 3
    static SHARD_APPIDINFO := 4
    static SHARD_APPIDINFOIDLIST := 5
    static SHARD_LINK := 6
    static SHARD_APPIDINFOLINK := 7
    static SHARD_SHELLITEM := 8
}
struct SHARDAPPIDINFO {
    psi : IShellItem
    pszAppID : PWSTR
}
struct SHARDAPPIDINFOIDLIST {
    pidl : ITEMIDLIST.Ptr
    pszAppID : PWSTR
}
struct SHARDAPPIDINFOLINK {
    psl : IShellLinkA
    pszAppID : PWSTR
}
struct SHChangeDWORDAsIDList {
    cb : UInt16
    dwItem1 : UInt32
    dwItem2 : UInt32
    cbZero : UInt16
}
struct SHChangeUpdateImageIDList {
    cb : UInt16
    iIconIndex : Int32
    iCurIndex : Int32
    uFlags : UInt32
    dwProcessID : UInt32
    szName : UInt16[260]
    cbZero : UInt16
}
struct SCNRT_STATUS extends Int32 {
    static SCNRT_ENABLE := 0
    static SCNRT_DISABLE := 1
}
struct SHDESCRIPTIONID {
    dwDescriptionId : UInt32
    clsid : GUID
}
struct AUTO_SCROLL_DATA {
    iNextSample : Int32
    dwLastScroll : UInt32
    bFull : BOOL
    pts : POINT[3]
    dwTimes : UInt32[3]
}
struct CABINETSTATE {
    cLength : UInt16
    nVersion : UInt16
    _bitfield : Int32
    fMenuEnumFilter : UInt32
}
struct RESTRICTIONS extends Int32 {
    static REST_NONE := 0
    static REST_NORUN := 1
    static REST_NOCLOSE := 2
    static REST_NOSAVESET := 4
    static REST_NOFILEMENU := 8
    static REST_NOSETFOLDERS := 16
    static REST_NOSETTASKBAR := 32
    static REST_NODESKTOP := 64
    static REST_NOFIND := 128
    static REST_NODRIVES := 256
    static REST_NODRIVEAUTORUN := 512
    static REST_NODRIVETYPEAUTORUN := 1024
    static REST_NONETHOOD := 2048
    static REST_STARTBANNER := 4096
    static REST_RESTRICTRUN := 8192
    static REST_NOPRINTERTABS := 16384
    static REST_NOPRINTERDELETE := 32768
    static REST_NOPRINTERADD := 65536
    static REST_NOSTARTMENUSUBFOLDERS := 131072
    static REST_MYDOCSONNET := 262144
    static REST_NOEXITTODOS := 524288
    static REST_ENFORCESHELLEXTSECURITY := 1048576
    static REST_LINKRESOLVEIGNORELINKINFO := 2097152
    static REST_NOCOMMONGROUPS := 4194304
    static REST_SEPARATEDESKTOPPROCESS := 8388608
    static REST_NOWEB := 16777216
    static REST_NOTRAYCONTEXTMENU := 33554432
    static REST_NOVIEWCONTEXTMENU := 67108864
    static REST_NONETCONNECTDISCONNECT := 134217728
    static REST_STARTMENULOGOFF := 268435456
    static REST_NOSETTINGSASSIST := 536870912
    static REST_NOINTERNETICON := 1073741825
    static REST_NORECENTDOCSHISTORY := 1073741826
    static REST_NORECENTDOCSMENU := 1073741827
    static REST_NOACTIVEDESKTOP := 1073741828
    static REST_NOACTIVEDESKTOPCHANGES := 1073741829
    static REST_NOFAVORITESMENU := 1073741830
    static REST_CLEARRECENTDOCSONEXIT := 1073741831
    static REST_CLASSICSHELL := 1073741832
    static REST_NOCUSTOMIZEWEBVIEW := 1073741833
    static REST_NOHTMLWALLPAPER := 1073741840
    static REST_NOCHANGINGWALLPAPER := 1073741841
    static REST_NODESKCOMP := 1073741842
    static REST_NOADDDESKCOMP := 1073741843
    static REST_NODELDESKCOMP := 1073741844
    static REST_NOCLOSEDESKCOMP := 1073741845
    static REST_NOCLOSE_DRAGDROPBAND := 1073741846
    static REST_NOMOVINGBAND := 1073741847
    static REST_NOEDITDESKCOMP := 1073741848
    static REST_NORESOLVESEARCH := 1073741849
    static REST_NORESOLVETRACK := 1073741850
    static REST_FORCECOPYACLWITHFILE := 1073741851
    static REST_NOFORGETSOFTWAREUPDATE := 1073741853
    static REST_NOSETACTIVEDESKTOP := 1073741854
    static REST_NOUPDATEWINDOWS := 1073741855
    static REST_NOCHANGESTARMENU := 1073741856
    static REST_NOFOLDEROPTIONS := 1073741857
    static REST_HASFINDCOMPUTERS := 1073741858
    static REST_INTELLIMENUS := 1073741859
    static REST_RUNDLGMEMCHECKBOX := 1073741860
    static REST_ARP_ShowPostSetup := 1073741861
    static REST_NOCSC := 1073741862
    static REST_NOCONTROLPANEL := 1073741863
    static REST_ENUMWORKGROUP := 1073741864
    static REST_ARP_NOARP := 1073741865
    static REST_ARP_NOREMOVEPAGE := 1073741866
    static REST_ARP_NOADDPAGE := 1073741867
    static REST_ARP_NOWINSETUPPAGE := 1073741868
    static REST_GREYMSIADS := 1073741869
    static REST_NOCHANGEMAPPEDDRIVELABEL := 1073741870
    static REST_NOCHANGEMAPPEDDRIVECOMMENT := 1073741871
    static REST_MaxRecentDocs := 1073741872
    static REST_NONETWORKCONNECTIONS := 1073741873
    static REST_FORCESTARTMENULOGOFF := 1073741874
    static REST_NOWEBVIEW := 1073741875
    static REST_NOCUSTOMIZETHISFOLDER := 1073741876
    static REST_NOENCRYPTION := 1073741877
    static REST_DONTSHOWSUPERHIDDEN := 1073741879
    static REST_NOSHELLSEARCHBUTTON := 1073741880
    static REST_NOHARDWARETAB := 1073741881
    static REST_NORUNASINSTALLPROMPT := 1073741882
    static REST_PROMPTRUNASINSTALLNETPATH := 1073741883
    static REST_NOMANAGEMYCOMPUTERVERB := 1073741884
    static REST_DISALLOWRUN := 1073741886
    static REST_NOWELCOMESCREEN := 1073741887
    static REST_RESTRICTCPL := 1073741888
    static REST_DISALLOWCPL := 1073741889
    static REST_NOSMBALLOONTIP := 1073741890
    static REST_NOSMHELP := 1073741891
    static REST_NOWINKEYS := 1073741892
    static REST_NOENCRYPTONMOVE := 1073741893
    static REST_NOLOCALMACHINERUN := 1073741894
    static REST_NOCURRENTUSERRUN := 1073741895
    static REST_NOLOCALMACHINERUNONCE := 1073741896
    static REST_NOCURRENTUSERRUNONCE := 1073741897
    static REST_FORCEACTIVEDESKTOPON := 1073741898
    static REST_NOVIEWONDRIVE := 1073741900
    static REST_NONETCRAWL := 1073741901
    static REST_NOSHAREDDOCUMENTS := 1073741902
    static REST_NOSMMYDOCS := 1073741903
    static REST_NOSMMYPICS := 1073741904
    static REST_ALLOWBITBUCKDRIVES := 1073741905
    static REST_NONLEGACYSHELLMODE := 1073741906
    static REST_NOCONTROLPANELBARRICADE := 1073741907
    static REST_NOSTARTPAGE := 1073741908
    static REST_NOAUTOTRAYNOTIFY := 1073741909
    static REST_NOTASKGROUPING := 1073741910
    static REST_NOCDBURNING := 1073741911
    static REST_MYCOMPNOPROP := 1073741912
    static REST_MYDOCSNOPROP := 1073741913
    static REST_NOSTARTPANEL := 1073741914
    static REST_NODISPLAYAPPEARANCEPAGE := 1073741915
    static REST_NOTHEMESTAB := 1073741916
    static REST_NOVISUALSTYLECHOICE := 1073741917
    static REST_NOSIZECHOICE := 1073741918
    static REST_NOCOLORCHOICE := 1073741919
    static REST_SETVISUALSTYLE := 1073741920
    static REST_STARTRUNNOHOMEPATH := 1073741921
    static REST_NOUSERNAMEINSTARTPANEL := 1073741922
    static REST_NOMYCOMPUTERICON := 1073741923
    static REST_NOSMNETWORKPLACES := 1073741924
    static REST_NOSMPINNEDLIST := 1073741925
    static REST_NOSMMYMUSIC := 1073741926
    static REST_NOSMEJECTPC := 1073741927
    static REST_NOSMMOREPROGRAMS := 1073741928
    static REST_NOSMMFUPROGRAMS := 1073741929
    static REST_NOTRAYITEMSDISPLAY := 1073741930
    static REST_NOTOOLBARSONTASKBAR := 1073741931
    static REST_NOSMCONFIGUREPROGRAMS := 1073741935
    static REST_HIDECLOCK := 1073741936
    static REST_NOLOWDISKSPACECHECKS := 1073741937
    static REST_NOENTIRENETWORK := 1073741938
    static REST_NODESKTOPCLEANUP := 1073741939
    static REST_BITBUCKNUKEONDELETE := 1073741940
    static REST_BITBUCKCONFIRMDELETE := 1073741941
    static REST_BITBUCKNOPROP := 1073741942
    static REST_NODISPBACKGROUND := 1073741943
    static REST_NODISPSCREENSAVEPG := 1073741944
    static REST_NODISPSETTINGSPG := 1073741945
    static REST_NODISPSCREENSAVEPREVIEW := 1073741946
    static REST_NODISPLAYCPL := 1073741947
    static REST_HIDERUNASVERB := 1073741948
    static REST_NOTHUMBNAILCACHE := 1073741949
    static REST_NOSTRCMPLOGICAL := 1073741950
    static REST_NOPUBLISHWIZARD := 1073741951
    static REST_NOONLINEPRINTSWIZARD := 1073741952
    static REST_NOWEBSERVICES := 1073741953
    static REST_ALLOWUNHASHEDWEBVIEW := 1073741954
    static REST_ALLOWLEGACYWEBVIEW := 1073741955
    static REST_REVERTWEBVIEWSECURITY := 1073741956
    static REST_INHERITCONSOLEHANDLES := 1073741958
    static REST_NOREMOTERECURSIVEEVENTS := 1073741961
    static REST_NOREMOTECHANGENOTIFY := 1073741969
    static REST_NOENUMENTIRENETWORK := 1073741971
    static REST_NOINTERNETOPENWITH := 1073741973
    static REST_DONTRETRYBADNETNAME := 1073741979
    static REST_ALLOWFILECLSIDJUNCTIONS := 1073741980
    static REST_NOUPNPINSTALL := 1073741981
    static REST_ARP_DONTGROUPPATCHES := 1073741996
    static REST_ARP_NOCHOOSEPROGRAMSPAGE := 1073741997
    static REST_NODISCONNECT := 1090519041
    static REST_NOSECURITY := 1090519042
    static REST_NOFILEASSOCIATE := 1090519043
    static REST_ALLOWCOMMENTTOGGLE := 1090519044
}
struct OPEN_AS_INFO_FLAGS extends Int32 {
    static OAIF_ALLOW_REGISTRATION := 1
    static OAIF_REGISTER_EXT := 2
    static OAIF_EXEC := 4
    static OAIF_FORCE_REGISTRATION := 8
    static OAIF_HIDE_REGISTRATION := 32
    static OAIF_URL_PROTOCOL := 64
    static OAIF_FILE_IS_URI := 128
}
struct OPENASINFO {
    pcszFile : PWSTR
    pcszClass : PWSTR
    oaifInFlags : OPEN_AS_INFO_FLAGS
}
struct IShellFolderViewCB extends IUnknown {
    static IID := "{2047E320-F2A9-11CE-AE65-08002B2E1262}"
    MessageSFVCB(uMsg, wParam1, lParam1)
      => ComCall(3, this.p, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
}
struct QCMINFO_IDMAP_PLACEMENT {
    id : UInt32
    fFlags : UInt32
}
struct QCMINFO_IDMAP {
    nMaxIds : UInt32
    pIdList : QCMINFO_IDMAP_PLACEMENT[1]
}
struct QCMINFO {
    hmenu : HMENU
    indexMenu : UInt32
    idCmdFirst : UInt32
    idCmdLast : UInt32
    pIdMap : QCMINFO_IDMAP.Ptr
}
struct DETAILSINFO {
    pidl : ITEMIDLIST.Ptr
    fmt : Int32
    cxChar : Int32
    str : STRRET
    iImage : Int32
}
struct SFVM_PROPPAGE_DATA {
    dwReserved : UInt32
    pfn : LPFNSVADDPROPSHEETPAGE
    lParam : LPARAM
}
struct SFVM_HELPTOPIC_DATA {
    wszHelpFile : UInt16[260]
    wszHelpTopic : UInt16[260]
}
struct ITEMSPACING {
    cxSmall : Int32
    cySmall : Int32
    cxLarge : Int32
    cyLarge : Int32
}
struct IShellFolderView extends IUnknown {
    static IID := "{37A378C0-F82D-11CE-AE65-08002B2E1262}"
    Rearrange(lParamSort)
      => ComCall(3, this.p, LPARAM, lParamSort)
    GetArrangeParam(plParamSort)
      => ComCall(4, this.p, LPARAM.Ptr, plParamSort)
    ArrangeGrid()
      => ComCall(5, this.p)
    AutoArrange()
      => ComCall(6, this.p)
    GetAutoArrange()
      => ComCall(7, this.p)
    AddObject(pidl, puItem)
      => ComCall(8, this.p, ITEMIDLIST.Ptr, pidl, UInt32.Ptr, puItem)
    GetObject(ppidl, uItem)
      => ComCall(9, this.p, ITEMIDLIST.Ptr.Ptr, ppidl, UInt32, uItem)
    RemoveObject(pidl?, puItem)
      => ComCall(10, this.p, ITEMIDLIST.Ptr, pidl?, UInt32.Ptr, puItem)
    GetObjectCount(puCount)
      => ComCall(11, this.p, UInt32.Ptr, puCount)
    SetObjectCount(uCount, dwFlags)
      => ComCall(12, this.p, UInt32, uCount, UInt32, dwFlags)
    UpdateObject(pidlOld, pidlNew, puItem)
      => ComCall(13, this.p, ITEMIDLIST.Ptr, pidlOld, ITEMIDLIST.Ptr, pidlNew, UInt32.Ptr, puItem)
    RefreshObject(pidl, puItem)
      => ComCall(14, this.p, ITEMIDLIST.Ptr, pidl, UInt32.Ptr, puItem)
    SetRedraw(bRedraw)
      => ComCall(15, this.p, BOOL, bRedraw)
    GetSelectedCount(puSelected)
      => ComCall(16, this.p, UInt32.Ptr, puSelected)
    GetSelectedObjects(pppidl, puItems)
      => ComCall(17, this.p, ITEMIDLIST.Ptr.Ptr.Ptr, pppidl, UInt32.Ptr, puItems)
    IsDropOnSource(pDropTarget?)
      => ComCall(18, this.p, IDropTarget, pDropTarget?)
    GetDragPoint(ppt)
      => ComCall(19, this.p, POINT.Ptr, ppt)
    GetDropPoint(ppt)
      => ComCall(20, this.p, POINT.Ptr, ppt)
    MoveIcons(pDataObject)
      => ComCall(21, this.p, IDataObject, pDataObject)
    SetItemPos(pidl, ppt)
      => ComCall(22, this.p, ITEMIDLIST.Ptr, pidl, POINT.Ptr, ppt)
    IsBkDropTarget(pDropTarget?)
      => ComCall(23, this.p, IDropTarget, pDropTarget?)
    SetClipboard(bMove)
      => ComCall(24, this.p, BOOL, bMove)
    SetPoints(pDataObject)
      => ComCall(25, this.p, IDataObject, pDataObject)
    GetItemSpacing(pSpacing)
      => ComCall(26, this.p, ITEMSPACING.Ptr, pSpacing)
    SetCallback(pNewCB?, ppOldCB)
      => ComCall(27, this.p, IShellFolderViewCB, pNewCB?, IShellFolderViewCB.Ptr, ppOldCB)
    Select(dwFlags)
      => ComCall(28, this.p, UInt32, dwFlags)
    QuerySupport(pdwSupport)
      => ComCall(29, this.p, UInt32.Ptr, pdwSupport)
    SetAutomationObject(pdisp?)
      => ComCall(30, this.p, IDispatch, pdisp?)
}
struct SFV_CREATE {
    cbSize : UInt32 := this.Size
    pshf : IShellFolder
    psvOuter : IShellView
    psfvcb : IShellFolderViewCB
}
struct LPFNDFMCALLBACK extends FunctionPointer {
    static Types := [IShellFolder, HWND, IDataObject, UInt32, WPARAM, LPARAM, HRESULT]
}
struct DEFCONTEXTMENU {
    hwnd : HWND
    pcmcb : IContextMenuCB
    pidlFolder : ITEMIDLIST.Ptr
    psf : IShellFolder
    cidl : UInt32
    apidl : ITEMIDLIST.Ptr.Ptr
    punkAssociationInfo : IUnknown
    cKeys : UInt32
    aKeys : HKEY.Ptr
}
struct DFMICS {
    cbSize : UInt32 := this.Size
    fMask : UInt32
    lParam : LPARAM
    idCmdFirst : UInt32
    idDefMax : UInt32
    pici : CMINVOKECOMMANDINFO.Ptr
    punkSite : IUnknown
}
struct LPFNVIEWCALLBACK extends FunctionPointer {
    static Types := [IShellView, IShellFolder, HWND, UInt32, WPARAM, LPARAM, HRESULT]
}
struct CSFV {
    cbSize : UInt32 := this.Size
    pshf : IShellFolder
    psvOuter : IShellView
    pidl : ITEMIDLIST.Ptr
    lEvents : Int32
    pfnCallback : LPFNVIEWCALLBACK
    fvm : FOLDERVIEWMODE
}
struct SHELLSTATEA {
    _bitfield1 : Int32
    dwWin95Unused : UInt32
    uWin95Unused : UInt32
    lParamSort : Int32
    iSortDirection : Int32
    version : UInt32
    uNotUsed : UInt32
    _bitfield2 : Int32
}
struct SHELLSTATEW {
    _bitfield1 : Int32
    dwWin95Unused : UInt32
    uWin95Unused : UInt32
    lParamSort : Int32
    iSortDirection : Int32
    version : UInt32
    uNotUsed : UInt32
    _bitfield2 : Int32
}
struct SHELLFLAGSTATE {
    _bitfield : Int32
}
struct INamedPropertyBag extends IUnknown {
    static IID := "{FB700430-952C-11D1-946F-000000000000}"
    ReadPropertyNPB(pszBagname, pszPropName, pVar)
      => ComCall(3, this.p, "Str", pszBagname, "Str", pszPropName, PROPVARIANT.Ptr, pVar)
    WritePropertyNPB(pszBagname, pszPropName, pVar)
      => ComCall(4, this.p, "Str", pszBagname, "Str", pszPropName, PROPVARIANT.Ptr, pVar)
    RemovePropertyNPB(pszBagname, pszPropName)
      => ComCall(5, this.p, "Str", pszBagname, "Str", pszPropName)
}
struct IESHORTCUTFLAGS extends Int32 {
    static IESHORTCUT_NEWBROWSER := 1
    static IESHORTCUT_OPENNEWTAB := 2
    static IESHORTCUT_FORCENAVIGATE := 4
    static IESHORTCUT_BACKGROUNDTAB := 8
}
struct INewShortcutHookA extends IUnknown {
    static IID := "{000214E1-0000-0000-C000-000000000046}"
    SetReferent(pcszReferent, hwnd1?)
      => ComCall(3, this.p, PSTR, pcszReferent, HWND, hwnd1?)
    GetReferent(pszReferent)
      => ComCall(4, this.p, PSTR, pszReferent, Int32, pszReferent.Length)
    SetFolder(pcszFolder)
      => ComCall(5, this.p, PSTR, pcszFolder)
    GetFolder(pszFolder)
      => ComCall(6, this.p, PSTR, pszFolder, Int32, pszFolder.Length)
    GetName(pszName)
      => ComCall(7, this.p, PSTR, pszName, Int32, pszName.Length)
    GetExtension(pszExtension)
      => ComCall(8, this.p, PSTR, pszExtension, Int32, pszExtension.Length)
}
struct INewShortcutHookW extends IUnknown {
    static IID := "{000214F7-0000-0000-C000-000000000046}"
    SetReferent(pcszReferent, hwnd1?)
      => ComCall(3, this.p, "Str", pcszReferent, HWND, hwnd1?)
    GetReferent(pszReferent)
      => ComCall(4, this.p, PWSTR, pszReferent, Int32, pszReferent.Length)
    SetFolder(pcszFolder)
      => ComCall(5, this.p, "Str", pcszFolder)
    GetFolder(pszFolder)
      => ComCall(6, this.p, PWSTR, pszFolder, Int32, pszFolder.Length)
    GetName(pszName)
      => ComCall(7, this.p, PWSTR, pszName, Int32, pszName.Length)
    GetExtension(pszExtension)
      => ComCall(8, this.p, PWSTR, pszExtension, Int32, pszExtension.Length)
}
struct ICopyHookA extends IUnknown {
    static IID := "{000214EF-0000-0000-C000-000000000046}"
    CopyCallback(hwnd1?, wFunc, wFlags, pszSrcFile, dwSrcAttribs, pszDestFile?, dwDestAttribs)
      => ComCall(3, this.p, HWND, hwnd1?, UInt32, wFunc, UInt32, wFlags, PSTR, pszSrcFile, UInt32, dwSrcAttribs, PSTR, pszDestFile?, UInt32, dwDestAttribs, UInt32)
}
struct ICopyHookW extends IUnknown {
    static IID := "{000214FC-0000-0000-C000-000000000046}"
    CopyCallback(hwnd1?, wFunc, wFlags, pszSrcFile, dwSrcAttribs, pszDestFile?, dwDestAttribs)
      => ComCall(3, this.p, HWND, hwnd1?, UInt32, wFunc, UInt32, wFlags, "Str", pszSrcFile, UInt32, dwSrcAttribs, "Str", pszDestFile?, UInt32, dwDestAttribs, UInt32)
}
struct ICurrentWorkingDirectory extends IUnknown {
    static IID := "{91956D21-9276-11D1-921A-006097DF5BD4}"
    GetDirectory(pwzPath)
      => ComCall(3, this.p, PWSTR, pwzPath, UInt32, pwzPath.Length)
    SetDirectory(pwzPath)
      => ComCall(4, this.p, "Str", pwzPath)
}
struct IDockingWindowFrame extends IOleWindow {
    static IID := "{47D2657A-7B27-11D0-8CA9-00A0C92DBFE8}"
    AddToolbar(punkSrc, pwszItem, dwAddFlags)
      => ComCall(5, this.p, IUnknown, punkSrc, "Str", pwszItem, UInt32, dwAddFlags)
    RemoveToolbar(punkSrc, dwRemoveFlags)
      => ComCall(6, this.p, IUnknown, punkSrc, UInt32, dwRemoveFlags)
    FindToolbar(pwszItem, riid, ppv)
      => ComCall(7, this.p, "Str", pwszItem, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IThumbnailCapture extends IUnknown {
    static IID := "{4EA39266-7211-409F-B622-F63DBD16C533}"
    CaptureThumbnail(pMaxSize, pHTMLDoc2, phbmThumbnail)
      => ComCall(3, this.p, SIZE.Ptr, pMaxSize, IUnknown, pHTMLDoc2, HBITMAP.Ptr, phbmThumbnail)
}
struct BANDINFOSFB {
    dwMask : UInt32
    dwStateMask : UInt32
    dwState : UInt32
    crBkgnd : COLORREF
    crBtnLt : COLORREF
    crBtnDk : COLORREF
    wViewMode : UInt16
    wAlign : UInt16
    psf : IShellFolder
    pidl : ITEMIDLIST.Ptr
}
struct IShellFolderBand extends IUnknown {
    static IID := "{7FE80CC8-C247-11D0-B93A-00A0C90312E1}"
    InitializeSFB(psf?, pidl?)
      => ComCall(3, this.p, IShellFolder, psf?, ITEMIDLIST.Ptr, pidl?)
    SetBandInfoSFB(pbi)
      => ComCall(4, this.p, BANDINFOSFB.Ptr, pbi)
    GetBandInfoSFB(pbi)
      => ComCall(5, this.p, BANDINFOSFB.Ptr, pbi)
}
struct IDeskBarClient extends IOleWindow {
    static IID := "{EB0FE175-1A3A-11D0-89B3-00A0C90A90AC}"
    SetDeskBarSite(punkSite?)
      => ComCall(5, this.p, IUnknown, punkSite?)
    SetModeDBC(dwMode)
      => ComCall(6, this.p, UInt32, dwMode)
    UIActivateDBC(dwState)
      => ComCall(7, this.p, UInt32, dwState)
    GetSize(dwWhich, prc)
      => ComCall(8, this.p, UInt32, dwWhich, RECT.Ptr, prc)
}
struct SHCOLUMNINFO {
    scid : PROPERTYKEY
    vt : VARENUM
    fmt : UInt32
    cChars : UInt32
    csFlags : UInt32
    wszTitle : UInt16[80]
    wszDescription : UInt16[128]
}
struct SHCOLUMNINIT {
    dwFlags : UInt32
    dwReserved : UInt32
    wszFolder : UInt16[260]
}
struct SHCOLUMNDATA {
    dwFlags : UInt32
    dwFileAttributes : UInt32
    dwReserved : UInt32
    pwszExt : PWSTR
    wszFile : UInt16[260]
}
struct IColumnProvider extends IUnknown {
    static IID := "{E8025004-1C42-11D2-BE2C-00A0C9A83DA1}"
    Initialize(psci)
      => ComCall(3, this.p, SHCOLUMNINIT.Ptr, psci)
    GetColumnInfo(dwIndex, psci)
      => ComCall(4, this.p, UInt32, dwIndex, SHCOLUMNINFO.Ptr, psci)
    GetItemData(pscid, pscd, pvarData)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, pscid, SHCOLUMNDATA.Ptr, pscd, VARIANT.Ptr, pvarData)
}
struct SHChangeProductKeyAsIDList {
    cb : UInt16
    wszProductKey : UInt16[39]
    cbZero : UInt16
}
struct IDocViewSite extends IUnknown {
    static IID := "{87D605E0-C511-11CF-89A9-00A0C9054129}"
    OnSetTitle(pvTitle)
      => ComCall(3, this.p, VARIANT.Ptr, pvTitle)
}
struct IInitializeObject extends IUnknown {
    static IID := "{4622AD16-FF23-11D0-8D34-00A0C90F2719}"
    Initialize()
      => ComCall(3, this.p)
}
struct IBanneredBar extends IUnknown {
    static IID := "{596A9A94-013E-11D1-8D34-00A0C90F2719}"
    SetIconSize(iIcon)
      => ComCall(3, this.p, UInt32, iIcon)
    GetIconSize(piIcon)
      => ComCall(4, this.p, UInt32.Ptr, piIcon)
    SetBitmap(hBitmap1)
      => ComCall(5, this.p, HBITMAP, hBitmap1)
    GetBitmap(phBitmap)
      => ComCall(6, this.p, HBITMAP.Ptr, phBitmap)
}
struct TBINFO {
    cbuttons : UInt32
    uFlags : UInt32
}
struct SFV_SETITEMPOS {
    pidl : ITEMIDLIST.Ptr
    pt : POINT
}
struct AASHELLMENUFILENAME {
    cbTotal : Int16
    rgbReserved : UInt8[12]
    szFileName : UInt16[1]
}
struct AASHELLMENUITEM {
    lpReserved1 : Struct.Ptr
    iReserved : Int32
    uiReserved : UInt32
    lpName : AASHELLMENUFILENAME.Ptr
    psz : PWSTR
}
struct DISPLAY_DEVICE_TYPE extends Int32 {
    static DEVICE_PRIMARY := 0
    static DEVICE_IMMERSIVE := 1
}
struct SCALE_CHANGE_FLAGS extends Int32 {
    static SCF_VALUE_NONE := 0
    static SCF_SCALE := 1
    static SCF_PHYSICAL := 2
}
struct SHELL_UI_COMPONENT extends Int32 {
    static SHELL_UI_COMPONENT_TASKBARS := 0
    static SHELL_UI_COMPONENT_NOTIFICATIONAREA := 1
    static SHELL_UI_COMPONENT_DESKBAND := 2
}
struct ASSOCCLASS extends Int32 {
    static ASSOCCLASS_SHELL_KEY := 0
    static ASSOCCLASS_PROGID_KEY := 1
    static ASSOCCLASS_PROGID_STR := 2
    static ASSOCCLASS_CLSID_KEY := 3
    static ASSOCCLASS_CLSID_STR := 4
    static ASSOCCLASS_APP_KEY := 5
    static ASSOCCLASS_APP_STR := 6
    static ASSOCCLASS_SYSTEM_STR := 7
    static ASSOCCLASS_FOLDER := 8
    static ASSOCCLASS_STAR := 9
    static ASSOCCLASS_FIXED_PROGID_STR := 10
    static ASSOCCLASS_PROTOCOL_STR := 11
}
struct QUERY_USER_NOTIFICATION_STATE extends Int32 {
    static QUNS_NOT_PRESENT := 1
    static QUNS_BUSY := 2
    static QUNS_RUNNING_D3D_FULL_SCREEN := 3
    static QUNS_PRESENTATION_MODE := 4
    static QUNS_ACCEPTS_NOTIFICATIONS := 5
    static QUNS_QUIET_TIME := 6
    static QUNS_APP := 7
}
struct SHSTOCKICONID extends Int32 {
    static SIID_DOCNOASSOC := 0
    static SIID_DOCASSOC := 1
    static SIID_APPLICATION := 2
    static SIID_FOLDER := 3
    static SIID_FOLDEROPEN := 4
    static SIID_DRIVE525 := 5
    static SIID_DRIVE35 := 6
    static SIID_DRIVEREMOVE := 7
    static SIID_DRIVEFIXED := 8
    static SIID_DRIVENET := 9
    static SIID_DRIVENETDISABLED := 10
    static SIID_DRIVECD := 11
    static SIID_DRIVERAM := 12
    static SIID_WORLD := 13
    static SIID_SERVER := 15
    static SIID_PRINTER := 16
    static SIID_MYNETWORK := 17
    static SIID_FIND := 22
    static SIID_HELP := 23
    static SIID_SHARE := 28
    static SIID_LINK := 29
    static SIID_SLOWFILE := 30
    static SIID_RECYCLER := 31
    static SIID_RECYCLERFULL := 32
    static SIID_MEDIACDAUDIO := 40
    static SIID_LOCK := 47
    static SIID_AUTOLIST := 49
    static SIID_PRINTERNET := 50
    static SIID_SERVERSHARE := 51
    static SIID_PRINTERFAX := 52
    static SIID_PRINTERFAXNET := 53
    static SIID_PRINTERFILE := 54
    static SIID_STACK := 55
    static SIID_MEDIASVCD := 56
    static SIID_STUFFEDFOLDER := 57
    static SIID_DRIVEUNKNOWN := 58
    static SIID_DRIVEDVD := 59
    static SIID_MEDIADVD := 60
    static SIID_MEDIADVDRAM := 61
    static SIID_MEDIADVDRW := 62
    static SIID_MEDIADVDR := 63
    static SIID_MEDIADVDROM := 64
    static SIID_MEDIACDAUDIOPLUS := 65
    static SIID_MEDIACDRW := 66
    static SIID_MEDIACDR := 67
    static SIID_MEDIACDBURN := 68
    static SIID_MEDIABLANKCD := 69
    static SIID_MEDIACDROM := 70
    static SIID_AUDIOFILES := 71
    static SIID_IMAGEFILES := 72
    static SIID_VIDEOFILES := 73
    static SIID_MIXEDFILES := 74
    static SIID_FOLDERBACK := 75
    static SIID_FOLDERFRONT := 76
    static SIID_SHIELD := 77
    static SIID_WARNING := 78
    static SIID_INFO := 79
    static SIID_ERROR := 80
    static SIID_KEY := 81
    static SIID_SOFTWARE := 82
    static SIID_RENAME := 83
    static SIID_DELETE := 84
    static SIID_MEDIAAUDIODVD := 85
    static SIID_MEDIAMOVIEDVD := 86
    static SIID_MEDIAENHANCEDCD := 87
    static SIID_MEDIAENHANCEDDVD := 88
    static SIID_MEDIAHDDVD := 89
    static SIID_MEDIABLURAY := 90
    static SIID_MEDIAVCD := 91
    static SIID_MEDIADVDPLUSR := 92
    static SIID_MEDIADVDPLUSRW := 93
    static SIID_DESKTOPPC := 94
    static SIID_MOBILEPC := 95
    static SIID_USERS := 96
    static SIID_MEDIASMARTMEDIA := 97
    static SIID_MEDIACOMPACTFLASH := 98
    static SIID_DEVICECELLPHONE := 99
    static SIID_DEVICECAMERA := 100
    static SIID_DEVICEVIDEOCAMERA := 101
    static SIID_DEVICEAUDIOPLAYER := 102
    static SIID_NETWORKCONNECT := 103
    static SIID_INTERNET := 104
    static SIID_ZIPFILE := 105
    static SIID_SETTINGS := 106
    static SIID_DRIVEHDDVD := 132
    static SIID_DRIVEBD := 133
    static SIID_MEDIAHDDVDROM := 134
    static SIID_MEDIAHDDVDR := 135
    static SIID_MEDIAHDDVDRAM := 136
    static SIID_MEDIABDROM := 137
    static SIID_MEDIABDR := 138
    static SIID_MEDIABDRE := 139
    static SIID_CLUSTEREDDRIVE := 140
    static SIID_MAX_ICONS := 181
}
struct PFNCANSHAREFOLDERW extends FunctionPointer {
    static Types := [PWSTR, HRESULT]
}
struct PFNSHOWSHAREFOLDERUIW extends FunctionPointer {
    static Types := [HWND, PWSTR, HRESULT]
}
struct NC_ADDRESS {
    pAddrInfo : NET_ADDRESS_INFO.Ptr
    PortNumber : UInt16
    PrefixLength : UInt8
}
struct SFBS_FLAGS extends Int32 {
    static SFBS_FLAGS_ROUND_TO_NEAREST_DISPLAYED_DIGIT := 1
    static SFBS_FLAGS_TRUNCATE_UNDISPLAYED_DECIMAL_DIGITS := 2
}
struct URL_SCHEME extends Int32 {
    static URL_SCHEME_INVALID := -1
    static URL_SCHEME_UNKNOWN := 0
    static URL_SCHEME_FTP := 1
    static URL_SCHEME_HTTP := 2
    static URL_SCHEME_GOPHER := 3
    static URL_SCHEME_MAILTO := 4
    static URL_SCHEME_NEWS := 5
    static URL_SCHEME_NNTP := 6
    static URL_SCHEME_TELNET := 7
    static URL_SCHEME_WAIS := 8
    static URL_SCHEME_FILE := 9
    static URL_SCHEME_MK := 10
    static URL_SCHEME_HTTPS := 11
    static URL_SCHEME_SHELL := 12
    static URL_SCHEME_SNEWS := 13
    static URL_SCHEME_LOCAL := 14
    static URL_SCHEME_JAVASCRIPT := 15
    static URL_SCHEME_VBSCRIPT := 16
    static URL_SCHEME_ABOUT := 17
    static URL_SCHEME_RES := 18
    static URL_SCHEME_MSSHELLROOTED := 19
    static URL_SCHEME_MSSHELLIDLIST := 20
    static URL_SCHEME_MSHELP := 21
    static URL_SCHEME_MSSHELLDEVICE := 22
    static URL_SCHEME_WILDCARD := 23
    static URL_SCHEME_SEARCH_MS := 24
    static URL_SCHEME_SEARCH := 25
    static URL_SCHEME_KNOWNFOLDER := 26
    static URL_SCHEME_MAXVALUE := 27
}
struct URL_PART extends Int32 {
    static URL_PART_NONE := 0
    static URL_PART_SCHEME := 1
    static URL_PART_HOSTNAME := 2
    static URL_PART_USERNAME := 3
    static URL_PART_PASSWORD := 4
    static URL_PART_PORT := 5
    static URL_PART_QUERY := 6
}
struct URLIS extends Int32 {
    static URLIS_URL := 0
    static URLIS_OPAQUE := 1
    static URLIS_NOHISTORY := 2
    static URLIS_FILEURL := 3
    static URLIS_APPLIABLE := 4
    static URLIS_DIRECTORY := 5
    static URLIS_HASQUERY := 6
}
struct PARSEDURLA {
    cbSize : UInt32 := this.Size
    pszProtocol : PSTR
    cchProtocol : UInt32
    pszSuffix : PSTR
    cchSuffix : UInt32
    nScheme : UInt32
}
struct PARSEDURLW {
    cbSize : UInt32 := this.Size
    pszProtocol : PWSTR
    cchProtocol : UInt32
    pszSuffix : PWSTR
    cchSuffix : UInt32
    nScheme : UInt32
}
struct SHREGDEL_FLAGS extends Int32 {
    static SHREGDEL_DEFAULT := 0
    static SHREGDEL_HKCU := 1
    static SHREGDEL_HKLM := 16
    static SHREGDEL_BOTH := 17
}
struct SHREGENUM_FLAGS extends Int32 {
    static SHREGENUM_DEFAULT := 0
    static SHREGENUM_HKCU := 1
    static SHREGENUM_HKLM := 16
    static SHREGENUM_BOTH := 17
}
struct ASSOCSTR extends Int32 {
    static ASSOCSTR_COMMAND := 1
    static ASSOCSTR_EXECUTABLE := 2
    static ASSOCSTR_FRIENDLYDOCNAME := 3
    static ASSOCSTR_FRIENDLYAPPNAME := 4
    static ASSOCSTR_NOOPEN := 5
    static ASSOCSTR_SHELLNEWVALUE := 6
    static ASSOCSTR_DDECOMMAND := 7
    static ASSOCSTR_DDEIFEXEC := 8
    static ASSOCSTR_DDEAPPLICATION := 9
    static ASSOCSTR_DDETOPIC := 10
    static ASSOCSTR_INFOTIP := 11
    static ASSOCSTR_QUICKTIP := 12
    static ASSOCSTR_TILEINFO := 13
    static ASSOCSTR_CONTENTTYPE := 14
    static ASSOCSTR_DEFAULTICON := 15
    static ASSOCSTR_SHELLEXTENSION := 16
    static ASSOCSTR_DROPTARGET := 17
    static ASSOCSTR_DELEGATEEXECUTE := 18
    static ASSOCSTR_SUPPORTED_URI_PROTOCOLS := 19
    static ASSOCSTR_PROGID := 20
    static ASSOCSTR_APPID := 21
    static ASSOCSTR_APPPUBLISHER := 22
    static ASSOCSTR_APPICONREFERENCE := 23
    static ASSOCSTR_MAX := 24
}
struct ASSOCKEY extends Int32 {
    static ASSOCKEY_SHELLEXECCLASS := 1
    static ASSOCKEY_APP := 2
    static ASSOCKEY_CLASS := 3
    static ASSOCKEY_BASECLASS := 4
    static ASSOCKEY_MAX := 5
}
struct ASSOCDATA extends Int32 {
    static ASSOCDATA_MSIDESCRIPTOR := 1
    static ASSOCDATA_NOACTIVATEHANDLER := 2
    static ASSOCDATA_UNUSED1 := 3
    static ASSOCDATA_HASPERUSERASSOC := 4
    static ASSOCDATA_EDITFLAGS := 5
    static ASSOCDATA_VALUE := 6
    static ASSOCDATA_MAX := 7
}
struct ASSOCENUM extends Int32 {
    static ASSOCENUM_NONE := 0
}
struct FILETYPEATTRIBUTEFLAGS extends Int32 {
    static FTA_None := 0
    static FTA_Exclude := 1
    static FTA_Show := 2
    static FTA_HasExtension := 4
    static FTA_NoEdit := 8
    static FTA_NoRemove := 16
    static FTA_NoNewVerb := 32
    static FTA_NoEditVerb := 64
    static FTA_NoRemoveVerb := 128
    static FTA_NoEditDesc := 256
    static FTA_NoEditIcon := 512
    static FTA_NoEditDflt := 1024
    static FTA_NoEditVerbCmd := 2048
    static FTA_NoEditVerbExe := 4096
    static FTA_NoDDE := 8192
    static FTA_NoEditMIME := 32768
    static FTA_OpenIsSafe := 65536
    static FTA_AlwaysUnsafe := 131072
    static FTA_NoRecentDocs := 1048576
    static FTA_SafeForElevation := 2097152
    static FTA_AlwaysUseDirectInvoke := 4194304
}
struct IQueryAssociations extends IUnknown {
    static IID := "{C46CA590-3C3F-11D2-BEE6-0000F805CA57}"
    Init(flags, pszAssoc?, hkProgid?, hwnd1?)
      => ComCall(3, this.p, ASSOCF, flags, "Str", pszAssoc?, HKEY, hkProgid?, HWND, hwnd1?)
    GetString(flags, str, pszExtra?, pszOut?)
      => ComCall(4, this.p, ASSOCF, flags, ASSOCSTR, str, "Str", pszExtra?, PWSTR, pszOut?, UInt32.Ptr, pszOut?.Length ?? 0)
    GetKey(flags, key, pszExtra?, phkeyOut)
      => ComCall(5, this.p, ASSOCF, flags, ASSOCKEY, key, "Str", pszExtra?, HKEY.Ptr, phkeyOut)
    GetData(flags, data, pszExtra?, pvOut?, pcbOut := pvOut.Size)
      => ComCall(6, this.p, ASSOCF, flags, ASSOCDATA, data, "Str", pszExtra?, Struct.Ptr, pvOut?, UInt32.Ptr, pcbOut?)
    GetEnum(flags, assocenum1, pszExtra?, riid, ppvOut)
      => ComCall(7, this.p, ASSOCF, flags, ASSOCENUM, assocenum1, "Str", pszExtra?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvOut)
}
struct SHGLOBALCOUNTER extends Int32 {
    static GLOBALCOUNTER_SEARCHMANAGER := 0
    static GLOBALCOUNTER_SEARCHOPTIONS := 1
    static GLOBALCOUNTER_FOLDERSETTINGSCHANGE := 2
    static GLOBALCOUNTER_RATINGS := 3
    static GLOBALCOUNTER_APPROVEDSITES := 4
    static GLOBALCOUNTER_RESTRICTIONS := 5
    static GLOBALCOUNTER_SHELLSETTINGSCHANGED := 6
    static GLOBALCOUNTER_SYSTEMPIDLCHANGE := 7
    static GLOBALCOUNTER_OVERLAYMANAGER := 8
    static GLOBALCOUNTER_QUERYASSOCIATIONS := 9
    static GLOBALCOUNTER_IESESSIONS := 10
    static GLOBALCOUNTER_IEONLY_SESSIONS := 11
    static GLOBALCOUNTER_APPLICATION_DESTINATIONS := 12
    static __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_CSCSYNCINPROGRESS := 13
    static GLOBALCOUNTER_BITBUCKETNUMDELETERS := 14
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SHARES := 15
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_A := 16
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_B := 17
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_C := 18
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_D := 19
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_E := 20
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_F := 21
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_G := 22
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_H := 23
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_I := 24
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_J := 25
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_K := 26
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_L := 27
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_M := 28
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_N := 29
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_O := 30
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_P := 31
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Q := 32
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_R := 33
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_S := 34
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_T := 35
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_U := 36
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_V := 37
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_W := 38
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_X := 39
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Y := 40
    static GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Z := 41
    static __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SERVERDRIVE := 42
    static __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEGLOBALDIRTYCOUNT := 43
    static GLOBALCOUNTER_RECYCLEBINENUM := 44
    static GLOBALCOUNTER_RECYCLEBINCORRUPTED := 45
    static GLOBALCOUNTER_RATINGS_STATECOUNTER := 46
    static GLOBALCOUNTER_PRIVATE_PROFILE_CACHE := 47
    static GLOBALCOUNTER_INTERNETTOOLBAR_LAYOUT := 48
    static GLOBALCOUNTER_FOLDERDEFINITION_CACHE := 49
    static GLOBALCOUNTER_COMMONPLACES_LIST_CACHE := 50
    static GLOBALCOUNTER_PRIVATE_PROFILE_CACHE_MACHINEWIDE := 51
    static GLOBALCOUNTER_ASSOCCHANGED := 52
    static GLOBALCOUNTER_APP_ITEMS_STATE_STORE_CACHE := 53
    static GLOBALCOUNTER_SETTINGSYNC_ENABLED := 54
    static GLOBALCOUNTER_APPSFOLDER_FILETYPEASSOCIATION_COUNTER := 55
    static GLOBALCOUNTER_USERINFOCHANGED := 56
    static GLOBALCOUNTER_SYNC_ENGINE_INFORMATION_CACHE_MACHINEWIDE := 57
    static GLOBALCOUNTER_BANNERS_DATAMODEL_CACHE_MACHINEWIDE := 58
    static GLOBALCOUNTER_MAXIMUMVALUE := 59
}
struct QITAB {
    piid : GUID.Ptr
    dwOffset : UInt32
}
struct DLLVERSIONINFO {
    cbSize : UInt32 := this.Size
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    dwPlatformID : UInt32
}
struct DLLVERSIONINFO2 {
    info1 : DLLVERSIONINFO
    dwFlags : UInt32
    ullVersion : Int64
}
struct DLLGETVERSIONPROC extends FunctionPointer {
    static Types := [DLLVERSIONINFO.Ptr, HRESULT]
}
struct APPINFODATAFLAGS extends Int32 {
    static AIM_DISPLAYNAME := 1
    static AIM_VERSION := 2
    static AIM_PUBLISHER := 4
    static AIM_PRODUCTID := 8
    static AIM_REGISTEREDOWNER := 16
    static AIM_REGISTEREDCOMPANY := 32
    static AIM_LANGUAGE := 64
    static AIM_SUPPORTURL := 128
    static AIM_SUPPORTTELEPHONE := 256
    static AIM_HELPLINK := 512
    static AIM_INSTALLLOCATION := 1024
    static AIM_INSTALLSOURCE := 2048
    static AIM_INSTALLDATE := 4096
    static AIM_CONTACT := 16384
    static AIM_COMMENTS := 32768
    static AIM_IMAGE := 131072
    static AIM_READMEURL := 262144
    static AIM_UPDATEINFOURL := 524288
}
struct APPINFODATA {
    cbSize : UInt32 := this.Size
    dwMask : UInt32
    pszDisplayName : PWSTR
    pszVersion : PWSTR
    pszPublisher : PWSTR
    pszProductID : PWSTR
    pszRegisteredOwner : PWSTR
    pszRegisteredCompany : PWSTR
    pszLanguage : PWSTR
    pszSupportUrl : PWSTR
    pszSupportTelephone : PWSTR
    pszHelpLink : PWSTR
    pszInstallLocation : PWSTR
    pszInstallSource : PWSTR
    pszInstallDate : PWSTR
    pszContact : PWSTR
    pszComments : PWSTR
    pszImage : PWSTR
    pszReadmeUrl : PWSTR
    pszUpdateInfoUrl : PWSTR
}
struct APPACTIONFLAGS extends Int32 {
    static APPACTION_INSTALL := 1
    static APPACTION_UNINSTALL := 2
    static APPACTION_MODIFY := 4
    static APPACTION_REPAIR := 8
    static APPACTION_UPGRADE := 16
    static APPACTION_CANGETSIZE := 32
    static APPACTION_MODIFYREMOVE := 128
    static APPACTION_ADDLATER := 256
    static APPACTION_UNSCHEDULE := 512
}
struct SLOWAPPINFO {
    ullSize : Int64
    ftLastUsed : FILETIME
    iTimesUsed : Int32
    pszImage : PWSTR
}
struct IShellApp extends IUnknown {
    static IID := "{A3E14960-935F-11D1-B8B8-006008059382}"
    GetAppInfo(pai)
      => ComCall(3, this.p, APPINFODATA.Ptr, pai)
    GetPossibleActions(pdwActions)
      => ComCall(4, this.p, UInt32.Ptr, pdwActions)
    GetSlowAppInfo(psaid)
      => ComCall(5, this.p, SLOWAPPINFO.Ptr, psaid)
    GetCachedSlowAppInfo(psaid)
      => ComCall(6, this.p, SLOWAPPINFO.Ptr, psaid)
    IsInstalled()
      => ComCall(7, this.p)
}
struct PUBAPPINFOFLAGS extends Int32 {
    static PAI_SOURCE := 1
    static PAI_ASSIGNEDTIME := 2
    static PAI_PUBLISHEDTIME := 4
    static PAI_SCHEDULEDTIME := 8
    static PAI_EXPIRETIME := 16
}
struct PUBAPPINFO {
    cbSize : UInt32 := this.Size
    dwMask : UInt32
    pszSource : PWSTR
    stAssigned : SYSTEMTIME
    stPublished : SYSTEMTIME
    stScheduled : SYSTEMTIME
    stExpire : SYSTEMTIME
}
struct IPublishedApp extends IShellApp {
    static IID := "{1BC752E0-9046-11D1-B8B3-006008059382}"
    Install(pstInstall)
      => ComCall(8, this.p, SYSTEMTIME.Ptr, pstInstall)
    GetPublishedAppInfo(ppai)
      => ComCall(9, this.p, PUBAPPINFO.Ptr, ppai)
    Unschedule()
      => ComCall(10, this.p)
}
struct IPublishedApp2 extends IPublishedApp {
    static IID := "{12B81347-1B3A-4A04-AA61-3F768B67FD7E}"
    Install2(pstInstall, hwndParent)
      => ComCall(11, this.p, SYSTEMTIME.Ptr, pstInstall, HWND, hwndParent)
}
struct IEnumPublishedApps extends IUnknown {
    static IID := "{0B124F8C-91F0-11D1-B8B5-006008059382}"
    Next(pia)
      => ComCall(3, this.p, IPublishedApp.Ptr, pia)
    Reset()
      => ComCall(4, this.p)
}
struct IAppPublisher extends IUnknown {
    static IID := "{07250A10-9CF9-11D1-9076-006008059382}"
    GetNumberOfCategories(pdwCat)
      => ComCall(3, this.p, UInt32.Ptr, pdwCat)
    GetCategories(pAppCategoryList)
      => ComCall(4, this.p, APPCATEGORYINFOLIST.Ptr, pAppCategoryList)
    GetNumberOfApps(pdwApps)
      => ComCall(5, this.p, UInt32.Ptr, pdwApps)
    EnumApps(pAppCategoryId, ppepa)
      => ComCall(6, this.p, GUID.Ptr, pAppCategoryId, IEnumPublishedApps.Ptr, ppepa)
}
struct CREDENTIAL_PROVIDER_USAGE_SCENARIO extends Int32 {
    static CPUS_INVALID := 0
    static CPUS_LOGON := 1
    static CPUS_UNLOCK_WORKSTATION := 2
    static CPUS_CHANGE_PASSWORD := 3
    static CPUS_CREDUI := 4
    static CPUS_PLAP := 5
}
struct CREDENTIAL_PROVIDER_FIELD_TYPE extends Int32 {
    static CPFT_INVALID := 0
    static CPFT_LARGE_TEXT := 1
    static CPFT_SMALL_TEXT := 2
    static CPFT_COMMAND_LINK := 3
    static CPFT_EDIT_TEXT := 4
    static CPFT_PASSWORD_TEXT := 5
    static CPFT_TILE_IMAGE := 6
    static CPFT_CHECKBOX := 7
    static CPFT_COMBOBOX := 8
    static CPFT_SUBMIT_BUTTON := 9
}
struct CREDENTIAL_PROVIDER_FIELD_STATE extends Int32 {
    static CPFS_HIDDEN := 0
    static CPFS_DISPLAY_IN_SELECTED_TILE := 1
    static CPFS_DISPLAY_IN_DESELECTED_TILE := 2
    static CPFS_DISPLAY_IN_BOTH := 3
}
struct CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE extends Int32 {
    static CPFIS_NONE := 0
    static CPFIS_READONLY := 1
    static CPFIS_DISABLED := 2
    static CPFIS_FOCUSED := 3
}
struct CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR {
    dwFieldID : UInt32
    cpft : CREDENTIAL_PROVIDER_FIELD_TYPE
    pszLabel : PWSTR
    guidFieldType : GUID
}
struct CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE extends Int32 {
    static CPGSR_NO_CREDENTIAL_NOT_FINISHED := 0
    static CPGSR_NO_CREDENTIAL_FINISHED := 1
    static CPGSR_RETURN_CREDENTIAL_FINISHED := 2
    static CPGSR_RETURN_NO_CREDENTIAL_FINISHED := 3
}
struct CREDENTIAL_PROVIDER_STATUS_ICON extends Int32 {
    static CPSI_NONE := 0
    static CPSI_ERROR := 1
    static CPSI_WARNING := 2
    static CPSI_SUCCESS := 3
}
struct CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION {
    ulAuthenticationPackage : UInt32
    clsidCredentialProvider : GUID
    cbSerialization : UInt32
    rgbSerialization : UInt8.Ptr
}
struct CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS extends Int32 {
    static CPAO_NONE := 0
    static CPAO_EMPTY_LOCAL := 1
    static CPAO_EMPTY_CONNECTED := 2
}
struct CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS extends Int32 {
    static CPCFO_NONE := 0
    static CPCFO_ENABLE_PASSWORD_REVEAL := 1
    static CPCFO_IS_EMAIL_ADDRESS := 2
    static CPCFO_ENABLE_TOUCH_KEYBOARD_AUTO_INVOKE := 4
    static CPCFO_NUMBERS_ONLY := 8
    static CPCFO_SHOW_ENGLISH_KEYBOARD := 16
}
struct ICredentialProviderCredential extends IUnknown {
    static IID := "{63913A93-40C1-481A-818D-4072FF8C70CC}"
    Advise(pcpce)
      => ComCall(3, this.p, ICredentialProviderCredentialEvents, pcpce)
    UnAdvise()
      => ComCall(4, this.p)
    SetSelected(pbAutoLogon)
      => ComCall(5, this.p, BOOL.Ptr, pbAutoLogon)
    SetDeselected()
      => ComCall(6, this.p)
    GetFieldState(dwFieldID, pcpfs, pcpfis)
      => ComCall(7, this.p, UInt32, dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE.Ptr, pcpfs, CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE.Ptr, pcpfis)
    GetStringValue(dwFieldID, ppsz)
      => ComCall(8, this.p, UInt32, dwFieldID, PWSTR.Ptr, ppsz)
    GetBitmapValue(dwFieldID, phbmp)
      => ComCall(9, this.p, UInt32, dwFieldID, HBITMAP.Ptr, phbmp)
    GetCheckboxValue(dwFieldID, pbChecked, ppszLabel)
      => ComCall(10, this.p, UInt32, dwFieldID, BOOL.Ptr, pbChecked, PWSTR.Ptr, ppszLabel)
    GetSubmitButtonValue(dwFieldID, pdwAdjacentTo)
      => ComCall(11, this.p, UInt32, dwFieldID, UInt32.Ptr, pdwAdjacentTo)
    GetComboBoxValueCount(dwFieldID, pcItems, pdwSelectedItem)
      => ComCall(12, this.p, UInt32, dwFieldID, UInt32.Ptr, pcItems, UInt32.Ptr, pdwSelectedItem)
    GetComboBoxValueAt(dwFieldID, dwItem, ppszItem)
      => ComCall(13, this.p, UInt32, dwFieldID, UInt32, dwItem, PWSTR.Ptr, ppszItem)
    SetStringValue(dwFieldID, psz)
      => ComCall(14, this.p, UInt32, dwFieldID, "Str", psz)
    SetCheckboxValue(dwFieldID, bChecked)
      => ComCall(15, this.p, UInt32, dwFieldID, BOOL, bChecked)
    SetComboBoxSelectedValue(dwFieldID, dwSelectedItem)
      => ComCall(16, this.p, UInt32, dwFieldID, UInt32, dwSelectedItem)
    CommandLinkClicked(dwFieldID)
      => ComCall(17, this.p, UInt32, dwFieldID)
    GetSerialization(pcpgsr, pcpcs, ppszOptionalStatusText, pcpsiOptionalStatusIcon)
      => ComCall(18, this.p, CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE.Ptr, pcpgsr, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION.Ptr, pcpcs, PWSTR.Ptr, ppszOptionalStatusText, CREDENTIAL_PROVIDER_STATUS_ICON.Ptr, pcpsiOptionalStatusIcon)
    ReportResult(ntsStatus, ntsSubstatus, ppszOptionalStatusText, pcpsiOptionalStatusIcon)
      => ComCall(19, this.p, NTSTATUS, ntsStatus, NTSTATUS, ntsSubstatus, PWSTR.Ptr, ppszOptionalStatusText, CREDENTIAL_PROVIDER_STATUS_ICON.Ptr, pcpsiOptionalStatusIcon)
}
struct IQueryContinueWithStatus extends IQueryContinue {
    static IID := "{9090BE5B-502B-41FB-BCCC-0049A6C7254B}"
    SetStatusMessage(psz)
      => ComCall(4, this.p, "Str", psz)
}
struct IConnectableCredentialProviderCredential extends ICredentialProviderCredential {
    static IID := "{9387928B-AC75-4BF9-8AB2-2B93C4A55290}"
    Connect(pqcws)
      => ComCall(20, this.p, IQueryContinueWithStatus, pqcws)
    Disconnect()
      => ComCall(21, this.p)
}
struct ICredentialProviderCredentialEvents extends IUnknown {
    static IID := "{FA6FA76B-66B7-4B11-95F1-86171118E816}"
    SetFieldState(pcpc, dwFieldID, cpfs)
      => ComCall(3, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE, cpfs)
    SetFieldInteractiveState(pcpc, dwFieldID, cpfis)
      => ComCall(4, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE, cpfis)
    SetFieldString(pcpc, dwFieldID, psz)
      => ComCall(5, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, "Str", psz)
    SetFieldCheckbox(pcpc, dwFieldID, bChecked, pszLabel)
      => ComCall(6, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, BOOL, bChecked, "Str", pszLabel)
    SetFieldBitmap(pcpc, dwFieldID, hbmp)
      => ComCall(7, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, HBITMAP, hbmp)
    SetFieldComboBoxSelectedItem(pcpc, dwFieldID, dwSelectedItem)
      => ComCall(8, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, UInt32, dwSelectedItem)
    DeleteFieldComboBoxItem(pcpc, dwFieldID, dwItem)
      => ComCall(9, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, UInt32, dwItem)
    AppendFieldComboBoxItem(pcpc, dwFieldID, pszItem)
      => ComCall(10, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, "Str", pszItem)
    SetFieldSubmitButton(pcpc, dwFieldID, dwAdjacentTo)
      => ComCall(11, this.p, ICredentialProviderCredential, pcpc, UInt32, dwFieldID, UInt32, dwAdjacentTo)
    OnCreatingWindow(phwndOwner)
      => ComCall(12, this.p, HWND.Ptr, phwndOwner)
}
struct ICredentialProvider extends IUnknown {
    static IID := "{D27C3481-5A1C-45B2-8AAA-C20EBBE8229E}"
    SetUsageScenario(cpus, dwFlags)
      => ComCall(3, this.p, CREDENTIAL_PROVIDER_USAGE_SCENARIO, cpus, UInt32, dwFlags)
    SetSerialization(pcpcs)
      => ComCall(4, this.p, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION.Ptr, pcpcs)
    Advise(pcpe, upAdviseContext)
      => ComCall(5, this.p, ICredentialProviderEvents, pcpe, IntPtr, upAdviseContext)
    UnAdvise()
      => ComCall(6, this.p)
    GetFieldDescriptorCount(pdwCount)
      => ComCall(7, this.p, UInt32.Ptr, pdwCount)
    GetFieldDescriptorAt(dwIndex, ppcpfd)
      => ComCall(8, this.p, UInt32, dwIndex, CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR.Ptr.Ptr, ppcpfd)
    GetCredentialCount(pdwCount, pdwDefault, pbAutoLogonWithDefault)
      => ComCall(9, this.p, UInt32.Ptr, pdwCount, UInt32.Ptr, pdwDefault, BOOL.Ptr, pbAutoLogonWithDefault)
    GetCredentialAt(dwIndex, ppcpc)
      => ComCall(10, this.p, UInt32, dwIndex, ICredentialProviderCredential.Ptr, ppcpc)
}
struct ICredentialProviderEvents extends IUnknown {
    static IID := "{34201E5A-A787-41A3-A5A4-BD6DCF2A854E}"
    CredentialsChanged(upAdviseContext)
      => ComCall(3, this.p, IntPtr, upAdviseContext)
}
struct ICredentialProviderFilter extends IUnknown {
    static IID := "{A5DA53F9-D475-4080-A120-910C4A739880}"
    Filter(cpus, dwFlags, rgclsidProviders, rgbAllow)
      => ComCall(3, this.p, CREDENTIAL_PROVIDER_USAGE_SCENARIO, cpus, UInt32, dwFlags, GUID.Ptr, rgclsidProviders, BOOL.Ptr, rgbAllow, UInt32, rgbAllow.Length)
    UpdateRemoteCredential(pcpcsIn, pcpcsOut)
      => ComCall(4, this.p, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION.Ptr, pcpcsIn, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION.Ptr, pcpcsOut)
}
struct ICredentialProviderCredential2 extends ICredentialProviderCredential {
    static IID := "{FD672C54-40EA-4D6E-9B49-CFB1A7507BD7}"
    GetUserSid(sid)
      => ComCall(20, this.p, PWSTR.Ptr, sid)
}
struct ICredentialProviderCredentialWithFieldOptions extends IUnknown {
    static IID := "{DBC6FB30-C843-49E3-A645-573E6F39446A}"
    GetFieldOptions(fieldID, options)
      => ComCall(3, this.p, UInt32, fieldID, CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS.Ptr, options)
}
struct ICredentialProviderCredentialEvents2 extends ICredentialProviderCredentialEvents {
    static IID := "{B53C00B6-9922-4B78-B1F4-DDFE774DC39B}"
    BeginFieldUpdates()
      => ComCall(13, this.p)
    EndFieldUpdates()
      => ComCall(14, this.p)
    SetFieldOptions(credential, fieldID, options)
      => ComCall(15, this.p, ICredentialProviderCredential, credential, UInt32, fieldID, CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS, options)
}
struct ICredentialProviderUser extends IUnknown {
    static IID := "{13793285-3EA6-40FD-B420-15F47DA41FBB}"
    GetSid(sid)
      => ComCall(3, this.p, PWSTR.Ptr, sid)
    GetProviderID(providerID)
      => ComCall(4, this.p, GUID.Ptr, providerID)
    GetStringValue(key, stringValue)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, key, PWSTR.Ptr, stringValue)
    GetValue(key, value)
      => ComCall(6, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, value)
}
struct ICredentialProviderUserArray extends IUnknown {
    static IID := "{90C119AE-0F18-4520-A1F1-114366A40FE8}"
    SetProviderFilter(guidProviderToFilterTo)
      => ComCall(3, this.p, GUID.Ptr, guidProviderToFilterTo)
    GetAccountOptions(credentialProviderAccountOptions)
      => ComCall(4, this.p, CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS.Ptr, credentialProviderAccountOptions)
    GetCount(userCount)
      => ComCall(5, this.p, UInt32.Ptr, userCount)
    GetAt(userIndex, user)
      => ComCall(6, this.p, UInt32, userIndex, ICredentialProviderUser.Ptr, user)
}
struct ICredentialProviderSetUserArray extends IUnknown {
    static IID := "{095C1484-1C0C-4388-9C6D-500E61BF84BD}"
    SetUserArray(users)
      => ComCall(3, this.p, ICredentialProviderUserArray, users)
}
struct ISyncMgrHandlerCollection extends IUnknown {
    static IID := "{A7F337A3-D20B-45CB-9ED7-87D094CA5045}"
    GetHandlerEnumerator(ppenum)
      => ComCall(3, this.p, IEnumString.Ptr, ppenum)
    BindToHandler(pszHandlerID, riid, ppv)
      => ComCall(4, this.p, "Str", pszHandlerID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct SYNCMGR_HANDLER_CAPABILITIES extends Int32 {
    static SYNCMGR_HCM_NONE := 0
    static SYNCMGR_HCM_PROVIDES_ICON := 1
    static SYNCMGR_HCM_EVENT_STORE := 2
    static SYNCMGR_HCM_CONFLICT_STORE := 4
    static SYNCMGR_HCM_SUPPORTS_CONCURRENT_SESSIONS := 16
    static SYNCMGR_HCM_CAN_BROWSE_CONTENT := 65536
    static SYNCMGR_HCM_CAN_SHOW_SCHEDULE := 131072
    static SYNCMGR_HCM_QUERY_BEFORE_ACTIVATE := 1048576
    static SYNCMGR_HCM_QUERY_BEFORE_DEACTIVATE := 2097152
    static SYNCMGR_HCM_QUERY_BEFORE_ENABLE := 4194304
    static SYNCMGR_HCM_QUERY_BEFORE_DISABLE := 8388608
    static SYNCMGR_HCM_VALID_MASK := 15925271
}
struct SYNCMGR_HANDLER_POLICIES extends Int32 {
    static SYNCMGR_HPM_NONE := 0
    static SYNCMGR_HPM_PREVENT_ACTIVATE := 1
    static SYNCMGR_HPM_PREVENT_DEACTIVATE := 2
    static SYNCMGR_HPM_PREVENT_ENABLE := 4
    static SYNCMGR_HPM_PREVENT_DISABLE := 8
    static SYNCMGR_HPM_PREVENT_START_SYNC := 16
    static SYNCMGR_HPM_PREVENT_STOP_SYNC := 32
    static SYNCMGR_HPM_DISABLE_ENABLE := 256
    static SYNCMGR_HPM_DISABLE_DISABLE := 512
    static SYNCMGR_HPM_DISABLE_START_SYNC := 1024
    static SYNCMGR_HPM_DISABLE_STOP_SYNC := 2048
    static SYNCMGR_HPM_DISABLE_BROWSE := 4096
    static SYNCMGR_HPM_DISABLE_SCHEDULE := 8192
    static SYNCMGR_HPM_HIDDEN_BY_DEFAULT := 65536
    static SYNCMGR_HPM_BACKGROUND_SYNC_ONLY := 48
    static SYNCMGR_HPM_VALID_MASK := 77631
}
struct ISyncMgrHandler extends IUnknown {
    static IID := "{04EC2E43-AC77-49F9-9B98-0307EF7A72A2}"
    GetName(ppszName)
      => ComCall(3, this.p, PWSTR.Ptr, ppszName)
    GetHandlerInfo(ppHandlerInfo)
      => ComCall(4, this.p, ISyncMgrHandlerInfo.Ptr, ppHandlerInfo)
    GetObject(rguidObjectID, riid, ppv)
      => ComCall(5, this.p, GUID.Ptr, rguidObjectID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetCapabilities(pmCapabilities)
      => ComCall(6, this.p, SYNCMGR_HANDLER_CAPABILITIES.Ptr, pmCapabilities)
    GetPolicies(pmPolicies)
      => ComCall(7, this.p, SYNCMGR_HANDLER_POLICIES.Ptr, pmPolicies)
    Activate(fActivate)
      => ComCall(8, this.p, BOOL, fActivate)
    Enable(fEnable)
      => ComCall(9, this.p, BOOL, fEnable)
    Synchronize(ppszItemIDs, hwndOwner, pSessionCreator, punk)
      => ComCall(10, this.p, PWSTR.Ptr, ppszItemIDs, UInt32, ppszItemIDs.Length, HWND, hwndOwner, ISyncMgrSessionCreator, pSessionCreator, IUnknown, punk)
}
struct SYNCMGR_HANDLER_TYPE extends Int32 {
    static SYNCMGR_HT_UNSPECIFIED := 0
    static SYNCMGR_HT_APPLICATION := 1
    static SYNCMGR_HT_DEVICE := 2
    static SYNCMGR_HT_FOLDER := 3
    static SYNCMGR_HT_SERVICE := 4
    static SYNCMGR_HT_COMPUTER := 5
    static SYNCMGR_HT_MIN := 0
    static SYNCMGR_HT_MAX := 5
}
struct ISyncMgrHandlerInfo extends IUnknown {
    static IID := "{4FF1D798-ECF7-4524-AA81-1E362A0AEF3A}"
    GetType(pnType)
      => ComCall(3, this.p, SYNCMGR_HANDLER_TYPE.Ptr, pnType)
    GetTypeLabel(ppszTypeLabel)
      => ComCall(4, this.p, PWSTR.Ptr, ppszTypeLabel)
    GetComment(ppszComment)
      => ComCall(5, this.p, PWSTR.Ptr, ppszComment)
    GetLastSyncTime(pftLastSync)
      => ComCall(6, this.p, FILETIME.Ptr, pftLastSync)
    IsActive()
      => ComCall(7, this.p)
    IsEnabled()
      => ComCall(8, this.p)
    IsConnected()
      => ComCall(9, this.p)
}
struct ISyncMgrSyncItemContainer extends IUnknown {
    static IID := "{90701133-BE32-4129-A65C-99E616CAFFF4}"
    GetSyncItem(pszItemID, ppItem)
      => ComCall(3, this.p, "Str", pszItemID, ISyncMgrSyncItem.Ptr, ppItem)
    GetSyncItemEnumerator(ppenum)
      => ComCall(4, this.p, IEnumSyncMgrSyncItems.Ptr, ppenum)
    GetSyncItemCount(pcItems)
      => ComCall(5, this.p, UInt32.Ptr, pcItems)
}
struct SYNCMGR_ITEM_CAPABILITIES extends Int32 {
    static SYNCMGR_ICM_NONE := 0
    static SYNCMGR_ICM_PROVIDES_ICON := 1
    static SYNCMGR_ICM_EVENT_STORE := 2
    static SYNCMGR_ICM_CONFLICT_STORE := 4
    static SYNCMGR_ICM_CAN_DELETE := 16
    static SYNCMGR_ICM_CAN_BROWSE_CONTENT := 65536
    static SYNCMGR_ICM_QUERY_BEFORE_ENABLE := 1048576
    static SYNCMGR_ICM_QUERY_BEFORE_DISABLE := 2097152
    static SYNCMGR_ICM_QUERY_BEFORE_DELETE := 4194304
    static SYNCMGR_ICM_VALID_MASK := 7405591
}
struct SYNCMGR_ITEM_POLICIES extends Int32 {
    static SYNCMGR_IPM_NONE := 0
    static SYNCMGR_IPM_PREVENT_ENABLE := 1
    static SYNCMGR_IPM_PREVENT_DISABLE := 2
    static SYNCMGR_IPM_PREVENT_START_SYNC := 4
    static SYNCMGR_IPM_PREVENT_STOP_SYNC := 8
    static SYNCMGR_IPM_DISABLE_ENABLE := 16
    static SYNCMGR_IPM_DISABLE_DISABLE := 32
    static SYNCMGR_IPM_DISABLE_START_SYNC := 64
    static SYNCMGR_IPM_DISABLE_STOP_SYNC := 128
    static SYNCMGR_IPM_DISABLE_BROWSE := 256
    static SYNCMGR_IPM_DISABLE_DELETE := 512
    static SYNCMGR_IPM_HIDDEN_BY_DEFAULT := 65536
    static SYNCMGR_IPM_VALID_MASK := 66303
}
struct ISyncMgrSyncItem extends IUnknown {
    static IID := "{B20B24CE-2593-4F04-BD8B-7AD6C45051CD}"
    GetItemID(ppszItemID)
      => ComCall(3, this.p, PWSTR.Ptr, ppszItemID)
    GetName(ppszName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszName)
    GetItemInfo(ppItemInfo)
      => ComCall(5, this.p, ISyncMgrSyncItemInfo.Ptr, ppItemInfo)
    GetObject(rguidObjectID, riid, ppv)
      => ComCall(6, this.p, GUID.Ptr, rguidObjectID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetCapabilities(pmCapabilities)
      => ComCall(7, this.p, SYNCMGR_ITEM_CAPABILITIES.Ptr, pmCapabilities)
    GetPolicies(pmPolicies)
      => ComCall(8, this.p, SYNCMGR_ITEM_POLICIES.Ptr, pmPolicies)
    Enable(fEnable)
      => ComCall(9, this.p, BOOL, fEnable)
    Delete()
      => ComCall(10, this.p)
}
struct ISyncMgrSyncItemInfo extends IUnknown {
    static IID := "{E7FD9502-BE0C-4464-90A1-2B5277031232}"
    GetTypeLabel(ppszTypeLabel)
      => ComCall(3, this.p, PWSTR.Ptr, ppszTypeLabel)
    GetComment(ppszComment)
      => ComCall(4, this.p, PWSTR.Ptr, ppszComment)
    GetLastSyncTime(pftLastSync)
      => ComCall(5, this.p, FILETIME.Ptr, pftLastSync)
    IsEnabled()
      => ComCall(6, this.p)
    IsConnected()
      => ComCall(7, this.p)
}
struct IEnumSyncMgrSyncItems extends IUnknown {
    static IID := "{54B3ABF3-F085-4181-B546-E29C403C726B}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ISyncMgrSyncItem.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSyncMgrSyncItems.Ptr, ppenum)
}
struct SYNCMGR_PROGRESS_STATUS extends Int32 {
    static SYNCMGR_PS_UPDATING := 1
    static SYNCMGR_PS_UPDATING_INDETERMINATE := 2
    static SYNCMGR_PS_SUCCEEDED := 3
    static SYNCMGR_PS_FAILED := 4
    static SYNCMGR_PS_CANCELED := 5
    static SYNCMGR_PS_DISCONNECTED := 6
    static SYNCMGR_PS_MAX := 6
}
struct SYNCMGR_CANCEL_REQUEST extends Int32 {
    static SYNCMGR_CR_NONE := 0
    static SYNCMGR_CR_CANCEL_ITEM := 1
    static SYNCMGR_CR_CANCEL_ALL := 2
    static SYNCMGR_CR_MAX := 2
}
struct SYNCMGR_EVENT_LEVEL extends Int32 {
    static SYNCMGR_EL_INFORMATION := 1
    static SYNCMGR_EL_WARNING := 2
    static SYNCMGR_EL_ERROR := 3
    static SYNCMGR_EL_MAX := 3
}
struct SYNCMGR_EVENT_FLAGS extends Int32 {
    static SYNCMGR_EF_NONE := 0
    static SYNCMGR_EF_VALID := 0
}
struct ISyncMgrSessionCreator extends IUnknown {
    static IID := "{17F48517-F305-4321-A08D-B25A834918FD}"
    CreateSession(pszHandlerID, ppszItemIDs, ppCallback)
      => ComCall(3, this.p, "Str", pszHandlerID, PWSTR.Ptr, ppszItemIDs, UInt32, ppszItemIDs.Length, ISyncMgrSyncCallback.Ptr, ppCallback)
}
struct ISyncMgrSyncCallback extends IUnknown {
    static IID := "{884CCD87-B139-4937-A4BA-4F8E19513FBE}"
    ReportProgress(pszItemID, pszProgressText, nStatus, uCurrentStep, uMaxStep, pnCancelRequest)
      => ComCall(3, this.p, "Str", pszItemID, "Str", pszProgressText, SYNCMGR_PROGRESS_STATUS, nStatus, UInt32, uCurrentStep, UInt32, uMaxStep, SYNCMGR_CANCEL_REQUEST.Ptr, pnCancelRequest)
    SetHandlerProgressText(pszProgressText, pnCancelRequest)
      => ComCall(4, this.p, "Str", pszProgressText, SYNCMGR_CANCEL_REQUEST.Ptr, pnCancelRequest)
    ReportEvent(pszItemID, nLevel, nFlags, pszName, pszDescription, pszLinkText, pszLinkReference, pszContext, pguidEventID)
      => ComCall(5, this.p, "Str", pszItemID, SYNCMGR_EVENT_LEVEL, nLevel, SYNCMGR_EVENT_FLAGS, nFlags, "Str", pszName, "Str", pszDescription, "Str", pszLinkText, "Str", pszLinkReference, "Str", pszContext, GUID.Ptr, pguidEventID)
    CanContinue(pszItemID)
      => ComCall(6, this.p, "Str", pszItemID)
    QueryForAdditionalItems(ppenumItemIDs, ppenumPunks)
      => ComCall(7, this.p, IEnumString.Ptr, ppenumItemIDs, IEnumUnknown.Ptr, ppenumPunks)
    AddItemToSession(pszItemID)
      => ComCall(8, this.p, "Str", pszItemID)
    AddIUnknownToSession(punk)
      => ComCall(9, this.p, IUnknown, punk)
    ProposeItem(pNewItem)
      => ComCall(10, this.p, ISyncMgrSyncItem, pNewItem)
    CommitItem(pszItemID)
      => ComCall(11, this.p, "Str", pszItemID)
    ReportManualSync()
      => ComCall(12, this.p)
}
struct ISyncMgrUIOperation extends IUnknown {
    static IID := "{FC7CFA47-DFE1-45B5-A049-8CFD82BEC271}"
    Run(hwndOwner)
      => ComCall(3, this.p, HWND, hwndOwner)
}
struct ISyncMgrEventLinkUIOperation extends ISyncMgrUIOperation {
    static IID := "{64522E52-848B-4015-89CE-5A36F00B94FF}"
    Init(rguidEventID, pEvent)
      => ComCall(4, this.p, GUID.Ptr, rguidEventID, ISyncMgrEvent, pEvent)
}
struct ISyncMgrScheduleWizardUIOperation extends ISyncMgrUIOperation {
    static IID := "{459A6C84-21D2-4DDC-8A53-F023A46066F2}"
    InitWizard(pszHandlerID)
      => ComCall(4, this.p, "Str", pszHandlerID)
}
struct ISyncMgrSyncResult extends IUnknown {
    static IID := "{2B90F17E-5A3E-4B33-BB7F-1BC48056B94D}"
    Result(nStatus, cError, cConflicts)
      => ComCall(3, this.p, SYNCMGR_PROGRESS_STATUS, nStatus, UInt32, cError, UInt32, cConflicts)
}
struct SYNCMGR_CONTROL_FLAGS extends Int32 {
    static SYNCMGR_CF_NONE := 0
    static SYNCMGR_CF_NOWAIT := 0
    static SYNCMGR_CF_WAIT := 1
    static SYNCMGR_CF_NOUI := 2
    static SYNCMGR_CF_VALID := 3
}
struct SYNCMGR_SYNC_CONTROL_FLAGS extends Int32 {
    static SYNCMGR_SCF_NONE := 0
    static SYNCMGR_SCF_IGNORE_IF_ALREADY_SYNCING := 1
    static SYNCMGR_SCF_VALID := 1
}
struct SYNCMGR_UPDATE_REASON extends Int32 {
    static SYNCMGR_UR_ADDED := 0
    static SYNCMGR_UR_CHANGED := 1
    static SYNCMGR_UR_REMOVED := 2
    static SYNCMGR_UR_MAX := 2
}
struct ISyncMgrControl extends IUnknown {
    static IID := "{9B63616C-36B2-46BC-959F-C1593952D19B}"
    StartHandlerSync(pszHandlerID, hwndOwner, punk, nSyncControlFlags, pResult)
      => ComCall(3, this.p, "Str", pszHandlerID, HWND, hwndOwner, IUnknown, punk, SYNCMGR_SYNC_CONTROL_FLAGS, nSyncControlFlags, ISyncMgrSyncResult, pResult)
    StartItemSync(pszHandlerID, ppszItemIDs, hwndOwner, punk, nSyncControlFlags, pResult)
      => ComCall(4, this.p, "Str", pszHandlerID, PWSTR.Ptr, ppszItemIDs, UInt32, ppszItemIDs.Length, HWND, hwndOwner, IUnknown, punk, SYNCMGR_SYNC_CONTROL_FLAGS, nSyncControlFlags, ISyncMgrSyncResult, pResult)
    StartSyncAll(hwndOwner)
      => ComCall(5, this.p, HWND, hwndOwner)
    StopHandlerSync(pszHandlerID)
      => ComCall(6, this.p, "Str", pszHandlerID)
    StopItemSync(pszHandlerID, ppszItemIDs)
      => ComCall(7, this.p, "Str", pszHandlerID, PWSTR.Ptr, ppszItemIDs, UInt32, ppszItemIDs.Length)
    StopSyncAll()
      => ComCall(8, this.p)
    UpdateHandlerCollection(rclsidCollectionID, nControlFlags)
      => ComCall(9, this.p, GUID.Ptr, rclsidCollectionID, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    UpdateHandler(pszHandlerID, nControlFlags)
      => ComCall(10, this.p, "Str", pszHandlerID, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    UpdateItem(pszHandlerID, pszItemID, nControlFlags)
      => ComCall(11, this.p, "Str", pszHandlerID, "Str", pszItemID, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    UpdateEvents(pszHandlerID, pszItemID, nControlFlags)
      => ComCall(12, this.p, "Str", pszHandlerID, "Str", pszItemID, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    UpdateConflict(pszHandlerID, pszItemID, pConflict, nReason)
      => ComCall(13, this.p, "Str", pszHandlerID, "Str", pszItemID, ISyncMgrConflict, pConflict, SYNCMGR_UPDATE_REASON, nReason)
    UpdateConflicts(pszHandlerID, pszItemID, nControlFlags)
      => ComCall(14, this.p, "Str", pszHandlerID, "Str", pszItemID, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    ActivateHandler(fActivate, pszHandlerID, hwndOwner, nControlFlags)
      => ComCall(15, this.p, BOOL, fActivate, "Str", pszHandlerID, HWND, hwndOwner, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    EnableHandler(fEnable, pszHandlerID, hwndOwner, nControlFlags)
      => ComCall(16, this.p, BOOL, fEnable, "Str", pszHandlerID, HWND, hwndOwner, SYNCMGR_CONTROL_FLAGS, nControlFlags)
    EnableItem(fEnable, pszHandlerID, pszItemID, hwndOwner, nControlFlags)
      => ComCall(17, this.p, BOOL, fEnable, "Str", pszHandlerID, "Str", pszItemID, HWND, hwndOwner, SYNCMGR_CONTROL_FLAGS, nControlFlags)
}
struct ISyncMgrEventStore extends IUnknown {
    static IID := "{37E412F9-016E-44C2-81FF-DB3ADD774266}"
    GetEventEnumerator(ppenum)
      => ComCall(3, this.p, IEnumSyncMgrEvents.Ptr, ppenum)
    GetEventCount(pcEvents)
      => ComCall(4, this.p, UInt32.Ptr, pcEvents)
    GetEvent(rguidEventID, ppEvent)
      => ComCall(5, this.p, GUID.Ptr, rguidEventID, ISyncMgrEvent.Ptr, ppEvent)
    RemoveEvent(pguidEventIDs)
      => ComCall(6, this.p, GUID.Ptr, pguidEventIDs, UInt32, pguidEventIDs.Length)
}
struct ISyncMgrEvent extends IUnknown {
    static IID := "{FEE0EF8B-46BD-4DB4-B7E6-FF2C687313BC}"
    GetEventID(pguidEventID)
      => ComCall(3, this.p, GUID.Ptr, pguidEventID)
    GetHandlerID(ppszHandlerID)
      => ComCall(4, this.p, PWSTR.Ptr, ppszHandlerID)
    GetItemID(ppszItemID)
      => ComCall(5, this.p, PWSTR.Ptr, ppszItemID)
    GetLevel(pnLevel)
      => ComCall(6, this.p, SYNCMGR_EVENT_LEVEL.Ptr, pnLevel)
    GetFlags(pnFlags)
      => ComCall(7, this.p, SYNCMGR_EVENT_FLAGS.Ptr, pnFlags)
    GetTime(pfCreationTime)
      => ComCall(8, this.p, FILETIME.Ptr, pfCreationTime)
    GetName(ppszName)
      => ComCall(9, this.p, PWSTR.Ptr, ppszName)
    GetDescription(ppszDescription)
      => ComCall(10, this.p, PWSTR.Ptr, ppszDescription)
    GetLinkText(ppszLinkText)
      => ComCall(11, this.p, PWSTR.Ptr, ppszLinkText)
    GetLinkReference(ppszLinkReference)
      => ComCall(12, this.p, PWSTR.Ptr, ppszLinkReference)
    GetContext(ppszContext)
      => ComCall(13, this.p, PWSTR.Ptr, ppszContext)
}
struct IEnumSyncMgrEvents extends IUnknown {
    static IID := "{C81A1D4E-8CF7-4683-80E0-BCAE88D677B6}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ISyncMgrEvent.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSyncMgrEvents.Ptr, ppenum)
}
struct SYNCMGR_CONFLICT_ID_INFO {
    pblobID : BYTE_BLOB.Ptr
    pblobExtra : BYTE_BLOB.Ptr
}
struct ISyncMgrConflictStore extends IUnknown {
    static IID := "{CF8FC579-C396-4774-85F1-D908A831156E}"
    EnumConflicts(pszHandlerID, pszItemID, ppEnum)
      => ComCall(3, this.p, "Str", pszHandlerID, "Str", pszItemID, IEnumSyncMgrConflict.Ptr, ppEnum)
    BindToConflict(pConflictIdInfo, riid, ppv)
      => ComCall(4, this.p, SYNCMGR_CONFLICT_ID_INFO.Ptr, pConflictIdInfo, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    RemoveConflicts(rgConflictIdInfo)
      => ComCall(5, this.p, SYNCMGR_CONFLICT_ID_INFO.Ptr, rgConflictIdInfo, UInt32, rgConflictIdInfo.Length)
    GetCount(pszHandlerID, pszItemID, pnConflicts)
      => ComCall(6, this.p, "Str", pszHandlerID, "Str", pszItemID, UInt32.Ptr, pnConflicts)
}
struct IEnumSyncMgrConflict extends IUnknown {
    static IID := "{82705914-DDA3-4893-BA99-49DE6C8C8036}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ISyncMgrConflict.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSyncMgrConflict.Ptr, ppenum)
}
struct SYNCMGR_CONFLICT_ITEM_TYPE extends Int32 {
    static SYNCMGR_CIT_UPDATED := 1
    static SYNCMGR_CIT_DELETED := 2
}
struct ISyncMgrConflict extends IUnknown {
    static IID := "{9C204249-C443-4BA4-85ED-C972681DB137}"
    GetProperty(propkey, ppropvar)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, propkey, PROPVARIANT.Ptr, ppropvar)
    GetConflictIdInfo(pConflictIdInfo)
      => ComCall(4, this.p, SYNCMGR_CONFLICT_ID_INFO.Ptr, pConflictIdInfo)
    GetItemsArray(ppArray)
      => ComCall(5, this.p, ISyncMgrConflictItems.Ptr, ppArray)
    Resolve(pResolveInfo)
      => ComCall(6, this.p, ISyncMgrConflictResolveInfo, pResolveInfo)
    GetResolutionHandler(riid, ppvResolutionHandler)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvResolutionHandler)
}
struct SYNCMGR_RESOLUTION_ABILITIES extends Int32 {
    static SYNCMGR_RA_KEEPOTHER := 1
    static SYNCMGR_RA_KEEPRECENT := 2
    static SYNCMGR_RA_REMOVEFROMSYNCSET := 4
    static SYNCMGR_RA_KEEP_SINGLE := 8
    static SYNCMGR_RA_KEEP_MULTIPLE := 16
    static SYNCMGR_RA_VALID := 31
}
struct SYNCMGR_RESOLUTION_FEEDBACK extends Int32 {
    static SYNCMGR_RF_CONTINUE := 0
    static SYNCMGR_RF_REFRESH := 1
    static SYNCMGR_RF_CANCEL := 2
}
struct ISyncMgrResolutionHandler extends IUnknown {
    static IID := "{40A3D052-8BFF-4C4B-A338-D4A395700DE9}"
    QueryAbilities(pdwAbilities)
      => ComCall(3, this.p, UInt32.Ptr, pdwAbilities)
    KeepOther(psiOther, pFeedback)
      => ComCall(4, this.p, IShellItem, psiOther, SYNCMGR_RESOLUTION_FEEDBACK.Ptr, pFeedback)
    KeepRecent(pFeedback)
      => ComCall(5, this.p, SYNCMGR_RESOLUTION_FEEDBACK.Ptr, pFeedback)
    RemoveFromSyncSet(pFeedback)
      => ComCall(6, this.p, SYNCMGR_RESOLUTION_FEEDBACK.Ptr, pFeedback)
    KeepItems(pArray, pFeedback)
      => ComCall(7, this.p, ISyncMgrConflictResolutionItems, pArray, SYNCMGR_RESOLUTION_FEEDBACK.Ptr, pFeedback)
}
struct ISyncMgrConflictPresenter extends IUnknown {
    static IID := "{0B4F5353-FD2B-42CD-8763-4779F2D508A3}"
    PresentConflict(pConflict, pResolveInfo)
      => ComCall(3, this.p, ISyncMgrConflict, pConflict, ISyncMgrConflictResolveInfo, pResolveInfo)
}
struct SYNCMGR_PRESENTER_NEXT_STEP extends Int32 {
    static SYNCMGR_PNS_CONTINUE := 0
    static SYNCMGR_PNS_DEFAULT := 1
    static SYNCMGR_PNS_CANCEL := 2
}
struct SYNCMGR_PRESENTER_CHOICE extends Int32 {
    static SYNCMGR_PC_NO_CHOICE := 0
    static SYNCMGR_PC_KEEP_ONE := 1
    static SYNCMGR_PC_KEEP_MULTIPLE := 2
    static SYNCMGR_PC_KEEP_RECENT := 3
    static SYNCMGR_PC_REMOVE_FROM_SYNC_SET := 4
    static SYNCMGR_PC_SKIP := 5
}
struct ISyncMgrConflictResolveInfo extends IUnknown {
    static IID := "{C405A219-25A2-442E-8743-B845A2CEE93F}"
    GetIterationInfo(pnCurrentConflict, pcConflicts, pcRemainingForApplyToAll)
      => ComCall(3, this.p, UInt32.Ptr, pnCurrentConflict, UInt32.Ptr, pcConflicts, UInt32.Ptr, pcRemainingForApplyToAll)
    GetPresenterNextStep(pnPresenterNextStep)
      => ComCall(4, this.p, SYNCMGR_PRESENTER_NEXT_STEP.Ptr, pnPresenterNextStep)
    GetPresenterChoice(pnPresenterChoice, pfApplyToAll)
      => ComCall(5, this.p, SYNCMGR_PRESENTER_CHOICE.Ptr, pnPresenterChoice, BOOL.Ptr, pfApplyToAll)
    GetItemChoiceCount(pcChoices)
      => ComCall(6, this.p, UInt32.Ptr, pcChoices)
    GetItemChoice(iChoice, piChoiceIndex)
      => ComCall(7, this.p, UInt32, iChoice, UInt32.Ptr, piChoiceIndex)
    SetPresenterNextStep(nPresenterNextStep)
      => ComCall(8, this.p, SYNCMGR_PRESENTER_NEXT_STEP, nPresenterNextStep)
    SetPresenterChoice(nPresenterChoice, fApplyToAll)
      => ComCall(9, this.p, SYNCMGR_PRESENTER_CHOICE, nPresenterChoice, BOOL, fApplyToAll)
    SetItemChoices(prgiConflictItemIndexes, cChoices)
      => ComCall(10, this.p, UInt32.Ptr, prgiConflictItemIndexes, UInt32, cChoices)
}
struct ISyncMgrConflictFolder extends IUnknown {
    static IID := "{59287F5E-BC81-4FCA-A7F1-E5A8ECDB1D69}"
    GetConflictIDList(pConflict, ppidlConflict)
      => ComCall(3, this.p, ISyncMgrConflict, pConflict, ITEMIDLIST.Ptr.Ptr, ppidlConflict)
}
struct CONFIRM_CONFLICT_ITEM {
    pShellItem : IShellItem2
    pszOriginalName : PWSTR
    pszAlternateName : PWSTR
    pszLocationShort : PWSTR
    pszLocationFull : PWSTR
    nType : SYNCMGR_CONFLICT_ITEM_TYPE
}
struct CONFIRM_CONFLICT_RESULT_INFO {
    pszNewName : PWSTR
    iItemIndex : UInt32
}
struct ISyncMgrConflictItems extends IUnknown {
    static IID := "{9C7EAD52-8023-4936-A4DB-D2A9A99E436A}"
    GetCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetItem(iIndex, pItemInfo)
      => ComCall(4, this.p, UInt32, iIndex, CONFIRM_CONFLICT_ITEM.Ptr, pItemInfo)
}
struct ISyncMgrConflictResolutionItems extends IUnknown {
    static IID := "{458725B9-129D-4135-A998-9CEAFEC27007}"
    GetCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetItem(iIndex, pItemInfo)
      => ComCall(4, this.p, UInt32, iIndex, CONFIRM_CONFLICT_RESULT_INFO.Ptr, pItemInfo)
}
struct IInputPanelConfiguration extends IUnknown {
    static IID := "{41C81592-514C-48BD-A22E-E6AF638521A6}"
    EnableFocusTracking()
      => ComCall(3, this.p)
}
struct IInputPanelInvocationConfiguration extends IUnknown {
    static IID := "{A213F136-3B45-4362-A332-EFB6547CD432}"
    RequireTouchInEditControl()
      => ComCall(3, this.p)
}
struct WTS_FLAGS extends Int32 {
    static WTS_NONE := 0
    static WTS_EXTRACT := 0
    static WTS_INCACHEONLY := 1
    static WTS_FASTEXTRACT := 2
    static WTS_FORCEEXTRACTION := 4
    static WTS_SLOWRECLAIM := 8
    static WTS_EXTRACTDONOTCACHE := 32
    static WTS_SCALETOREQUESTEDSIZE := 64
    static WTS_SKIPFASTEXTRACT := 128
    static WTS_EXTRACTINPROC := 256
    static WTS_CROPTOSQUARE := 512
    static WTS_INSTANCESURROGATE := 1024
    static WTS_REQUIRESURROGATE := 2048
    static WTS_APPSTYLE := 8192
    static WTS_WIDETHUMBNAILS := 16384
    static WTS_IDEALCACHESIZEONLY := 32768
    static WTS_SCALEUP := 65536
}
struct WTS_CACHEFLAGS extends Int32 {
    static WTS_DEFAULT := 0
    static WTS_LOWQUALITY := 1
    static WTS_CACHED := 2
}
struct WTS_CONTEXTFLAGS extends Int32 {
    static WTSCF_DEFAULT := 0
    static WTSCF_APPSTYLE := 1
    static WTSCF_SQUARE := 2
    static WTSCF_WIDE := 4
    static WTSCF_FAST := 8
}
struct WTS_ALPHATYPE extends Int32 {
    static WTSAT_UNKNOWN := 0
    static WTSAT_RGB := 1
    static WTSAT_ARGB := 2
}
struct WTS_THUMBNAILID {
    rgbKey : UInt8[16]
}
struct ISharedBitmap extends IUnknown {
    static IID := "{091162A4-BC96-411F-AAE8-C5122CD03363}"
    GetSharedBitmap(phbm)
      => ComCall(3, this.p, HBITMAP.Ptr, phbm)
    GetSize(pSize)
      => ComCall(4, this.p, SIZE.Ptr, pSize)
    GetFormat(pat)
      => ComCall(5, this.p, WTS_ALPHATYPE.Ptr, pat)
    InitializeBitmap(hbm, wtsAT)
      => ComCall(6, this.p, HBITMAP, hbm, WTS_ALPHATYPE, wtsAT)
    Detach(phbm)
      => ComCall(7, this.p, HBITMAP.Ptr, phbm)
}
struct IThumbnailCache extends IUnknown {
    static IID := "{F676C15D-596A-4CE2-8234-33996F445DB1}"
    GetThumbnail(pShellItem, cxyRequestedThumbSize, flags, ppvThumb?, pOutFlags?, pThumbnailID?)
      => ComCall(3, this.p, IShellItem, pShellItem, UInt32, cxyRequestedThumbSize, WTS_FLAGS, flags, ISharedBitmap.Ptr, ppvThumb?, WTS_CACHEFLAGS.Ptr, pOutFlags?, WTS_THUMBNAILID.Ptr, pThumbnailID?)
    GetThumbnailByID(thumbnailID, cxyRequestedThumbSize, ppvThumb?, pOutFlags?)
      => ComCall(4, this.p, WTS_THUMBNAILID, thumbnailID, UInt32, cxyRequestedThumbSize, ISharedBitmap.Ptr, ppvThumb?, WTS_CACHEFLAGS.Ptr, pOutFlags?)
}
struct IThumbnailProvider extends IUnknown {
    static IID := "{E357FCCD-A995-4576-B01F-234630154E96}"
    GetThumbnail(cx, phbmp, pdwAlpha)
      => ComCall(3, this.p, UInt32, cx, HBITMAP.Ptr, phbmp, WTS_ALPHATYPE.Ptr, pdwAlpha)
}
struct IThumbnailSettings extends IUnknown {
    static IID := "{F4376F00-BEF5-4D45-80F3-1E023BBF1209}"
    SetContext(dwContext)
      => ComCall(3, this.p, WTS_CONTEXTFLAGS, dwContext)
}
struct IThumbnailCachePrimer extends IUnknown {
    static IID := "{0F03F8FE-2B26-46F0-965A-212AA8D66B76}"
    PageInThumbnail(psi, wtsFlags, cxyRequestedThumbSize)
      => ComCall(3, this.p, IShellItem, psi, WTS_FLAGS, wtsFlags, UInt32, cxyRequestedThumbSize)
}
struct IShellImageDataFactory extends IUnknown {
    static IID := "{9BE8ED5C-EDAB-4D75-90F3-BD5BDBB21C82}"
    CreateIShellImageData(ppshimg)
      => ComCall(3, this.p, IShellImageData.Ptr, ppshimg)
    CreateImageFromFile(pszPath, ppshimg)
      => ComCall(4, this.p, "Str", pszPath, IShellImageData.Ptr, ppshimg)
    CreateImageFromStream(pStream?, ppshimg)
      => ComCall(5, this.p, IStream, pStream?, IShellImageData.Ptr, ppshimg)
    GetDataFormatFromPath(pszPath, pDataFormat)
      => ComCall(6, this.p, "Str", pszPath, GUID.Ptr, pDataFormat)
}
struct IShellImageData extends IUnknown {
    static IID := "{BFDEEC12-8040-4403-A5EA-9E07DAFCF530}"
    Decode(dwFlags, cxDesired, cyDesired)
      => ComCall(3, this.p, UInt32, dwFlags, UInt32, cxDesired, UInt32, cyDesired)
    Draw(hdc1, prcDest, prcSrc)
      => ComCall(4, this.p, HDC, hdc1, RECT.Ptr, prcDest, RECT.Ptr, prcSrc)
    NextFrame()
      => ComCall(5, this.p)
    NextPage()
      => ComCall(6, this.p)
    PrevPage()
      => ComCall(7, this.p)
    IsTransparent()
      => ComCall(8, this.p)
    IsAnimated()
      => ComCall(9, this.p)
    IsVector()
      => ComCall(10, this.p)
    IsMultipage()
      => ComCall(11, this.p)
    IsEditable()
      => ComCall(12, this.p)
    IsPrintable()
      => ComCall(13, this.p)
    IsDecoded()
      => ComCall(14, this.p)
    GetCurrentPage(pnPage)
      => ComCall(15, this.p, UInt32.Ptr, pnPage)
    GetPageCount(pcPages)
      => ComCall(16, this.p, UInt32.Ptr, pcPages)
    SelectPage(iPage)
      => ComCall(17, this.p, UInt32, iPage)
    GetSize(pSize)
      => ComCall(18, this.p, SIZE.Ptr, pSize)
    GetRawDataFormat(pDataFormat)
      => ComCall(19, this.p, GUID.Ptr, pDataFormat)
    GetPixelFormat(pFormat)
      => ComCall(20, this.p, UInt32.Ptr, pFormat)
    GetDelay(pdwDelay)
      => ComCall(21, this.p, UInt32.Ptr, pdwDelay)
    GetProperties(dwMode, ppPropSet)
      => ComCall(22, this.p, UInt32, dwMode, IPropertySetStorage.Ptr, ppPropSet)
    Rotate(dwAngle)
      => ComCall(23, this.p, UInt32, dwAngle)
    Scale(cx, cy, hints)
      => ComCall(24, this.p, UInt32, cx, UInt32, cy, InterpolationMode, hints)
    DiscardEdit()
      => ComCall(25, this.p)
    SetEncoderParams(pbagEnc)
      => ComCall(26, this.p, IPropertyBag, pbagEnc)
    DisplayName(wszName, cch)
      => ComCall(27, this.p, "Str", wszName, UInt32, cch)
    GetResolution(puResolutionX, puResolutionY)
      => ComCall(28, this.p, UInt32.Ptr, puResolutionX, UInt32.Ptr, puResolutionY)
    GetEncoderParams(pguidFmt, ppEncParams)
      => ComCall(29, this.p, GUID.Ptr, pguidFmt, UInt8.Ptr.Ptr, ppEncParams)
    RegisterAbort(pAbort, ppAbortPrev)
      => ComCall(30, this.p, IShellImageDataAbort, pAbort, IShellImageDataAbort.Ptr, ppAbortPrev)
    CloneFrame(ppImg)
      => ComCall(31, this.p, UInt8.Ptr.Ptr, ppImg)
    ReplaceFrame(pImg)
      => ComCall(32, this.p, UInt8.Ptr, pImg)
}
struct IShellImageDataAbort extends IUnknown {
    static IID := "{53FB8E58-50C0-4003-B4AA-0C8DF28E7F3A}"
    QueryAbort()
      => ComCall(3, this.p)
}
struct IStorageProviderPropertyHandler extends IUnknown {
    static IID := "{301DFBE5-524C-4B0F-8B2D-21C40B3A2988}"
    RetrieveProperties(propertiesToRetrieve, retrievedProperties)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, propertiesToRetrieve, UInt32, propertiesToRetrieve.Length, IPropertyStore.Ptr, retrievedProperties)
    SaveProperties(propertiesToSave)
      => ComCall(4, this.p, IPropertyStore, propertiesToSave)
}
struct IStorageProviderHandler extends IUnknown {
    static IID := "{162C6FB5-44D3-435B-903D-E613FA093FB5}"
    GetPropertyHandlerFromPath(path, propertyHandler)
      => ComCall(3, this.p, "Str", path, IStorageProviderPropertyHandler.Ptr, propertyHandler)
    GetPropertyHandlerFromUri(uri, propertyHandler)
      => ComCall(4, this.p, "Str", uri, IStorageProviderPropertyHandler.Ptr, propertyHandler)
    GetPropertyHandlerFromFileId(fileId, propertyHandler)
      => ComCall(5, this.p, "Str", fileId, IStorageProviderPropertyHandler.Ptr, propertyHandler)
}
struct SYNCMGRSTATUS extends Int32 {
    static SYNCMGRSTATUS_STOPPED := 0
    static SYNCMGRSTATUS_SKIPPED := 1
    static SYNCMGRSTATUS_PENDING := 2
    static SYNCMGRSTATUS_UPDATING := 3
    static SYNCMGRSTATUS_SUCCEEDED := 4
    static SYNCMGRSTATUS_FAILED := 5
    static SYNCMGRSTATUS_PAUSED := 6
    static SYNCMGRSTATUS_RESUMING := 7
    static SYNCMGRSTATUS_UPDATING_INDETERMINATE := 8
    static SYNCMGRSTATUS_DELETED := 256
}
struct SYNCMGRPROGRESSITEM {
    cbSize : UInt32 := this.Size
    mask : UInt32
    lpcStatusText : PWSTR
    dwStatusType : UInt32
    iProgValue : Int32
    iMaxValue : Int32
}
struct SYNCMGRLOGLEVEL extends Int32 {
    static SYNCMGRLOGLEVEL_INFORMATION := 1
    static SYNCMGRLOGLEVEL_WARNING := 2
    static SYNCMGRLOGLEVEL_ERROR := 3
    static SYNCMGRLOGLEVEL_LOGLEVELMAX := 3
}
struct SYNCMGRERRORFLAGS extends Int32 {
    static SYNCMGRERRORFLAG_ENABLEJUMPTEXT := 1
}
struct SYNCMGRLOGERRORINFO {
    cbSize : UInt32 := this.Size
    mask : UInt32
    dwSyncMgrErrorFlags : UInt32
    ErrorID : GUID
    ItemID : GUID
}
struct ISyncMgrSynchronizeCallback extends IUnknown {
    static IID := "{6295DF41-35EE-11D1-8707-00C04FD93327}"
    ShowPropertiesCompleted(hr)
      => ComCall(3, this.p, HRESULT, hr)
    PrepareForSyncCompleted(hr)
      => ComCall(4, this.p, HRESULT, hr)
    SynchronizeCompleted(hr)
      => ComCall(5, this.p, HRESULT, hr)
    ShowErrorCompleted(hr, pItemIDs)
      => ComCall(6, this.p, HRESULT, hr, UInt32, pItemIDs.Length, GUID.Ptr, pItemIDs)
    EnableModeless(fEnable)
      => ComCall(7, this.p, BOOL, fEnable)
    Progress(ItemID, pSyncProgressItem)
      => ComCall(8, this.p, GUID.Ptr, ItemID, SYNCMGRPROGRESSITEM.Ptr, pSyncProgressItem)
    LogError(dwErrorLevel, pszErrorText, pSyncLogError)
      => ComCall(9, this.p, UInt32, dwErrorLevel, "Str", pszErrorText, SYNCMGRLOGERRORINFO.Ptr, pSyncLogError)
    DeleteLogError(ErrorID, dwReserved)
      => ComCall(10, this.p, GUID.Ptr, ErrorID, UInt32, dwReserved)
    EstablishConnection(pwszConnection, dwReserved)
      => ComCall(11, this.p, "Str", pwszConnection, UInt32, dwReserved)
}
struct SYNCMGRITEMFLAGS extends Int32 {
    static SYNCMGRITEM_HASPROPERTIES := 1
    static SYNCMGRITEM_TEMPORARY := 2
    static SYNCMGRITEM_ROAMINGUSER := 4
    static SYNCMGRITEM_LASTUPDATETIME := 8
    static SYNCMGRITEM_MAYDELETEITEM := 16
    static SYNCMGRITEM_HIDDEN := 32
}
struct SYNCMGRITEM {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    ItemID : GUID
    dwItemState : UInt32
    hIcon : HICON
    wszItemName : UInt16[128]
    ftLastUpdate : FILETIME
}
struct ISyncMgrEnumItems extends IUnknown {
    static IID := "{6295DF2A-35EE-11D1-8707-00C04FD93327}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, SYNCMGRITEM.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, ISyncMgrEnumItems.Ptr, ppenum)
}
struct SYNCMGRFLAG extends Int32 {
    static SYNCMGRFLAG_CONNECT := 1
    static SYNCMGRFLAG_PENDINGDISCONNECT := 2
    static SYNCMGRFLAG_MANUAL := 3
    static SYNCMGRFLAG_IDLE := 4
    static SYNCMGRFLAG_INVOKE := 5
    static SYNCMGRFLAG_SCHEDULED := 6
    static SYNCMGRFLAG_EVENTMASK := 255
    static SYNCMGRFLAG_SETTINGS := 256
    static SYNCMGRFLAG_MAYBOTHERUSER := 512
}
struct SYNCMGRHANDLERFLAGS extends Int32 {
    static SYNCMGRHANDLER_HASPROPERTIES := 1
    static SYNCMGRHANDLER_MAYESTABLISHCONNECTION := 2
    static SYNCMGRHANDLER_ALWAYSLISTHANDLER := 4
    static SYNCMGRHANDLER_HIDDEN := 8
}
struct SYNCMGRHANDLERINFO {
    cbSize : UInt32 := this.Size
    hIcon : HICON
    SyncMgrHandlerFlags : UInt32
    wszHandlerName : UInt16[32]
}
struct SYNCMGRITEMSTATE extends Int32 {
    static SYNCMGRITEMSTATE_UNCHECKED := 0
    static SYNCMGRITEMSTATE_CHECKED := 1
}
struct ISyncMgrSynchronize extends IUnknown {
    static IID := "{6295DF40-35EE-11D1-8707-00C04FD93327}"
    Initialize(dwReserved, dwSyncMgrFlags, lpCookie)
      => ComCall(3, this.p, UInt32, dwReserved, UInt32, dwSyncMgrFlags, UInt32, lpCookie.Length, UInt8.Ptr, lpCookie)
    GetHandlerInfo(ppSyncMgrHandlerInfo)
      => ComCall(4, this.p, SYNCMGRHANDLERINFO.Ptr.Ptr, ppSyncMgrHandlerInfo)
    EnumSyncMgrItems(ppSyncMgrEnumItems)
      => ComCall(5, this.p, ISyncMgrEnumItems.Ptr, ppSyncMgrEnumItems)
    GetItemObject(ItemID, riid, ppv)
      => ComCall(6, this.p, GUID.Ptr, ItemID, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ShowProperties(hWndParent, ItemID)
      => ComCall(7, this.p, HWND, hWndParent, GUID.Ptr, ItemID)
    SetProgressCallback(lpCallBack)
      => ComCall(8, this.p, ISyncMgrSynchronizeCallback, lpCallBack)
    PrepareForSync(pItemIDs, hWndParent, dwReserved)
      => ComCall(9, this.p, UInt32, pItemIDs.Length, GUID.Ptr, pItemIDs, HWND, hWndParent, UInt32, dwReserved)
    Synchronize(hWndParent)
      => ComCall(10, this.p, HWND, hWndParent)
    SetItemStatus(pItemID, dwSyncMgrStatus)
      => ComCall(11, this.p, GUID.Ptr, pItemID, UInt32, dwSyncMgrStatus)
    ShowError(hWndParent, ErrorID)
      => ComCall(12, this.p, HWND, hWndParent, GUID.Ptr, ErrorID)
}
struct SYNCMGRINVOKEFLAGS extends Int32 {
    static SYNCMGRINVOKE_STARTSYNC := 2
    static SYNCMGRINVOKE_MINIMIZED := 4
}
struct ISyncMgrSynchronizeInvoke extends IUnknown {
    static IID := "{6295DF2C-35EE-11D1-8707-00C04FD93327}"
    UpdateItems(dwInvokeFlags, clsid, pCookie)
      => ComCall(3, this.p, UInt32, dwInvokeFlags, GUID.Ptr, clsid, UInt32, pCookie.Length, UInt8.Ptr, pCookie)
    UpdateAll()
      => ComCall(4, this.p)
}
struct SYNCMGRREGISTERFLAGS extends Int32 {
    static SYNCMGRREGISTERFLAG_CONNECT := 1
    static SYNCMGRREGISTERFLAG_PENDINGDISCONNECT := 2
    static SYNCMGRREGISTERFLAG_IDLE := 4
}
struct ISyncMgrRegister extends IUnknown {
    static IID := "{6295DF42-35EE-11D1-8707-00C04FD93327}"
    RegisterSyncMgrHandler(clsidHandler, pwszDescription, dwSyncMgrRegisterFlags)
      => ComCall(3, this.p, GUID.Ptr, clsidHandler, "Str", pwszDescription, UInt32, dwSyncMgrRegisterFlags)
    UnregisterSyncMgrHandler(clsidHandler, dwReserved)
      => ComCall(4, this.p, GUID.Ptr, clsidHandler, UInt32, dwReserved)
    GetHandlerRegistrationInfo(clsidHandler, pdwSyncMgrRegisterFlags)
      => ComCall(5, this.p, GUID.Ptr, clsidHandler, UInt32.Ptr, pdwSyncMgrRegisterFlags)
}
struct ThumbnailStreamCacheOptions extends Int32 {
    static ExtractIfNotCached := 0
    static ReturnOnlyIfCached := 1
    static ResizeThumbnail := 2
    static AllowSmallerSize := 4
}
struct IThumbnailStreamCache extends IUnknown {
    static IID := "{90E11430-9569-41D8-AE75-6D4D2AE7CCA0}"
    GetThumbnailStream(path, cacheId, options, requestedThumbnailSize, thumbnailSize, thumbnailStream)
      => ComCall(3, this.p, "Str", path, Int64, cacheId, ThumbnailStreamCacheOptions, options, UInt32, requestedThumbnailSize, SIZE.Ptr, thumbnailSize, IStream.Ptr, thumbnailStream)
    SetThumbnailStream(path, cacheId, thumbnailSize, thumbnailStream)
      => ComCall(4, this.p, "Str", path, Int64, cacheId, SIZE, thumbnailSize, IStream, thumbnailStream)
}
struct WINDOWDATA {
    dwWindowID : UInt32
    uiCP : UInt32
    pidl : ITEMIDLIST.Ptr
    lpszUrl : PWSTR
    lpszUrlLocation : PWSTR
    lpszTitle : PWSTR
}
struct ITravelLogEntry extends IUnknown {
    static IID := "{7EBFDD87-AD18-11D3-A4C5-00C04F72D6B8}"
    GetTitle(ppszTitle)
      => ComCall(3, this.p, PWSTR.Ptr, ppszTitle)
    GetURL(ppszURL)
      => ComCall(4, this.p, PWSTR.Ptr, ppszURL)
}
struct ITravelLogClient extends IUnknown {
    static IID := "{241C033E-E659-43DA-AA4D-4086DBC4758D}"
    FindWindowByIndex(dwID, ppunk)
      => ComCall(3, this.p, UInt32, dwID, IUnknown.Ptr, ppunk)
    GetWindowData(pStream, pWinData)
      => ComCall(4, this.p, IStream, pStream, WINDOWDATA.Ptr, pWinData)
    LoadHistoryPosition(pszUrlLocation, dwPosition)
      => ComCall(5, this.p, "Str", pszUrlLocation, UInt32, dwPosition)
}
struct IEnumTravelLogEntry extends IUnknown {
    static IID := "{7EBFDD85-AD18-11D3-A4C5-00C04F72D6B8}"
    Next(rgElt, pcEltFetched)
      => ComCall(3, this.p, UInt32, rgElt.Length, ITravelLogEntry.Ptr, rgElt, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumTravelLogEntry.Ptr, ppEnum)
}
struct TLENUMF extends Int32 {
    static TLEF_RELATIVE_INCLUDE_CURRENT := 1
    static TLEF_RELATIVE_BACK := 16
    static TLEF_RELATIVE_FORE := 32
    static TLEF_INCLUDE_UNINVOKEABLE := 64
    static TLEF_ABSOLUTE := 49
    static TLEF_EXCLUDE_SUBFRAME_ENTRIES := 128
    static TLEF_EXCLUDE_ABOUT_PAGES := 256
}
struct ITravelLogStg extends IUnknown {
    static IID := "{7EBFDD80-AD18-11D3-A4C5-00C04F72D6B8}"
    CreateEntry(pszUrl, pszTitle, ptleRelativeTo, fPrepend, pptle)
      => ComCall(3, this.p, "Str", pszUrl, "Str", pszTitle, ITravelLogEntry, ptleRelativeTo, BOOL, fPrepend, ITravelLogEntry.Ptr, pptle)
    TravelTo(ptle)
      => ComCall(4, this.p, ITravelLogEntry, ptle)
    EnumEntries(flags, ppenum)
      => ComCall(5, this.p, TLENUMF, flags, IEnumTravelLogEntry.Ptr, ppenum)
    FindEntries(flags, pszUrl, ppenum)
      => ComCall(6, this.p, TLENUMF, flags, "Str", pszUrl, IEnumTravelLogEntry.Ptr, ppenum)
    GetCount(flags, pcEntries)
      => ComCall(7, this.p, TLENUMF, flags, UInt32.Ptr, pcEntries)
    RemoveEntry(ptle)
      => ComCall(8, this.p, ITravelLogEntry, ptle)
    GetRelativeEntry(iOffset, ptle)
      => ComCall(9, this.p, Int32, iOffset, ITravelLogEntry.Ptr, ptle)
}
struct HLSR extends Int32 {
    static HLSR_HOME := 0
    static HLSR_SEARCHPAGE := 1
    static HLSR_HISTORYFOLDER := 2
}
struct HLSHORTCUTF extends Int32 {
    static HLSHORTCUTF_DEFAULT := 0
    static HLSHORTCUTF_DONTACTUALLYCREATE := 1
    static HLSHORTCUTF_USEFILENAMEFROMFRIENDLYNAME := 2
    static HLSHORTCUTF_USEUNIQUEFILENAME := 4
    static HLSHORTCUTF_MAYUSEEXISTINGSHORTCUT := 8
}
struct HLTRANSLATEF extends Int32 {
    static HLTRANSLATEF_DEFAULT := 0
    static HLTRANSLATEF_DONTAPPLYDEFAULTPREFIX := 1
}
struct HLNF extends UInt32 {
    static HLNF_INTERNALJUMP := 1
    static HLNF_OPENINNEWWINDOW := 2
    static HLNF_NAVIGATINGBACK := 4
    static HLNF_NAVIGATINGFORWARD := 8
    static HLNF_NAVIGATINGTOSTACKITEM := 16
    static HLNF_CREATENOHISTORY := 32
}
struct HLINKGETREF extends Int32 {
    static HLINKGETREF_DEFAULT := 0
    static HLINKGETREF_ABSOLUTE := 1
    static HLINKGETREF_RELATIVE := 2
}
struct HLFNAMEF extends Int32 {
    static HLFNAMEF_DEFAULT := 0
    static HLFNAMEF_TRYCACHE := 1
    static HLFNAMEF_TRYPRETTYTARGET := 2
    static HLFNAMEF_TRYFULLTARGET := 4
    static HLFNAMEF_TRYWIN95SHORTCUT := 8
}
struct HLINKMISC extends Int32 {
    static HLINKMISC_RELATIVE := 1
}
struct HLINKSETF extends Int32 {
    static HLINKSETF_TARGET := 1
    static HLINKSETF_LOCATION := 2
}
struct IHlink extends IUnknown {
    static IID := "{79EAC9C3-BAF9-11CE-8C82-00AA004BA90B}"
    SetHlinkSite(pihlSite, dwSiteData)
      => ComCall(3, this.p, IHlinkSite, pihlSite, UInt32, dwSiteData)
    GetHlinkSite(ppihlSite, pdwSiteData)
      => ComCall(4, this.p, IHlinkSite.Ptr, ppihlSite, UInt32.Ptr, pdwSiteData)
    SetMonikerReference(grfHLSETF, pimkTarget, pwzLocation)
      => ComCall(5, this.p, UInt32, grfHLSETF, IMoniker, pimkTarget, "Str", pwzLocation)
    GetMonikerReference(dwWhichRef, ppimkTarget?, ppwzLocation?)
      => ComCall(6, this.p, UInt32, dwWhichRef, IMoniker.Ptr, ppimkTarget?, PWSTR.Ptr, ppwzLocation?)
    SetStringReference(grfHLSETF, pwzTarget, pwzLocation)
      => ComCall(7, this.p, UInt32, grfHLSETF, "Str", pwzTarget, "Str", pwzLocation)
    GetStringReference(dwWhichRef, ppwzTarget?, ppwzLocation?)
      => ComCall(8, this.p, UInt32, dwWhichRef, PWSTR.Ptr, ppwzTarget?, PWSTR.Ptr, ppwzLocation?)
    SetFriendlyName(pwzFriendlyName)
      => ComCall(9, this.p, "Str", pwzFriendlyName)
    GetFriendlyName(grfHLFNAMEF, ppwzFriendlyName)
      => ComCall(10, this.p, UInt32, grfHLFNAMEF, PWSTR.Ptr, ppwzFriendlyName)
    SetTargetFrameName(pwzTargetFrameName)
      => ComCall(11, this.p, "Str", pwzTargetFrameName)
    GetTargetFrameName(ppwzTargetFrameName)
      => ComCall(12, this.p, PWSTR.Ptr, ppwzTargetFrameName)
    GetMiscStatus(pdwStatus)
      => ComCall(13, this.p, UInt32.Ptr, pdwStatus)
    Navigate(grfHLNF, pibc, pibsc, pihlbc)
      => ComCall(14, this.p, UInt32, grfHLNF, IBindCtx, pibc, IBindStatusCallback, pibsc, IHlinkBrowseContext, pihlbc)
    SetAdditionalParams(pwzAdditionalParams)
      => ComCall(15, this.p, "Str", pwzAdditionalParams)
    GetAdditionalParams(ppwzAdditionalParams)
      => ComCall(16, this.p, PWSTR.Ptr, ppwzAdditionalParams)
}
struct HLINKWHICHMK extends Int32 {
    static HLINKWHICHMK_CONTAINER := 1
    static HLINKWHICHMK_BASE := 2
}
struct IHlinkSite extends IUnknown {
    static IID := "{79EAC9C2-BAF9-11CE-8C82-00AA004BA90B}"
    QueryService(dwSiteData, guidService, riid, ppiunk)
      => ComCall(3, this.p, UInt32, dwSiteData, GUID.Ptr, guidService, GUID.Ptr, riid, IUnknown.Ptr, ppiunk)
    GetMoniker(dwSiteData, dwAssign, dwWhich, ppimk)
      => ComCall(4, this.p, UInt32, dwSiteData, UInt32, dwAssign, UInt32, dwWhich, IMoniker.Ptr, ppimk)
    ReadyToNavigate(dwSiteData, dwReserved)
      => ComCall(5, this.p, UInt32, dwSiteData, UInt32, dwReserved)
    OnNavigationComplete(dwSiteData, dwreserved, hrError, pwzError)
      => ComCall(6, this.p, UInt32, dwSiteData, UInt32, dwreserved, HRESULT, hrError, "Str", pwzError)
}
struct IHlinkTarget extends IUnknown {
    static IID := "{79EAC9C4-BAF9-11CE-8C82-00AA004BA90B}"
    SetBrowseContext(pihlbc)
      => ComCall(3, this.p, IHlinkBrowseContext, pihlbc)
    GetBrowseContext(ppihlbc)
      => ComCall(4, this.p, IHlinkBrowseContext.Ptr, ppihlbc)
    Navigate(grfHLNF, pwzJumpLocation)
      => ComCall(5, this.p, UInt32, grfHLNF, "Str", pwzJumpLocation)
    GetMoniker(pwzLocation, dwAssign, ppimkLocation)
      => ComCall(6, this.p, "Str", pwzLocation, UInt32, dwAssign, IMoniker.Ptr, ppimkLocation)
    GetFriendlyName(pwzLocation, ppwzFriendlyName)
      => ComCall(7, this.p, "Str", pwzLocation, PWSTR.Ptr, ppwzFriendlyName)
}
struct IHlinkFrame extends IUnknown {
    static IID := "{79EAC9C5-BAF9-11CE-8C82-00AA004BA90B}"
    SetBrowseContext(pihlbc)
      => ComCall(3, this.p, IHlinkBrowseContext, pihlbc)
    GetBrowseContext(ppihlbc)
      => ComCall(4, this.p, IHlinkBrowseContext.Ptr, ppihlbc)
    Navigate(grfHLNF, pbc, pibsc, pihlNavigate)
      => ComCall(5, this.p, UInt32, grfHLNF, IBindCtx, pbc, IBindStatusCallback, pibsc, IHlink, pihlNavigate)
    OnNavigate(grfHLNF, pimkTarget, pwzLocation, pwzFriendlyName, dwreserved)
      => ComCall(6, this.p, UInt32, grfHLNF, IMoniker, pimkTarget, "Str", pwzLocation, "Str", pwzFriendlyName, UInt32, dwreserved)
    UpdateHlink(uHLID, pimkTarget, pwzLocation, pwzFriendlyName)
      => ComCall(7, this.p, UInt32, uHLID, IMoniker, pimkTarget, "Str", pwzLocation, "Str", pwzFriendlyName)
}
struct HLITEM {
    uHLID : UInt32
    pwzFriendlyName : PWSTR
}
struct IEnumHLITEM extends IUnknown {
    static IID := "{79EAC9C6-BAF9-11CE-8C82-00AA004BA90B}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, HLITEM.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppienumhlitem)
      => ComCall(6, this.p, IEnumHLITEM.Ptr, ppienumhlitem)
}
struct HLTB_INFO extends Int32 {
    static HLTB_DOCKEDLEFT := 0
    static HLTB_DOCKEDTOP := 1
    static HLTB_DOCKEDRIGHT := 2
    static HLTB_DOCKEDBOTTOM := 3
    static HLTB_FLOATING := 4
}
struct HLTBINFO {
    uDockType : UInt32
    rcTbPos : RECT
}
struct HLBWIF_FLAGS extends Int32 {
    static HLBWIF_HASFRAMEWNDINFO := 1
    static HLBWIF_HASDOCWNDINFO := 2
    static HLBWIF_FRAMEWNDMAXIMIZED := 4
    static HLBWIF_DOCWNDMAXIMIZED := 8
    static HLBWIF_HASWEBTOOLBARINFO := 16
    static HLBWIF_WEBTOOLBARHIDDEN := 32
}
struct HLBWINFO {
    cbSize : UInt32 := this.Size
    grfHLBWIF : UInt32
    rcFramePos : RECT
    rcDocPos : RECT
    hltbinfo : HLTBINFO
}
struct HLID_INFO extends UInt32 {
    static HLID_INVALID := 0
    static HLID_PREVIOUS := 4294967295
    static HLID_NEXT := 4294967294
    static HLID_CURRENT := 4294967293
    static HLID_STACKBOTTOM := 4294967292
    static HLID_STACKTOP := 4294967291
}
struct HLQF_INFO extends Int32 {
    static HLQF_ISVALID := 1
    static HLQF_ISCURRENT := 2
}
struct IHlinkBrowseContext extends IUnknown {
    static IID := "{79EAC9C7-BAF9-11CE-8C82-00AA004BA90B}"
    Register(reserved, piunk, pimk, pdwRegister)
      => ComCall(3, this.p, UInt32, reserved, IUnknown, piunk, IMoniker, pimk, UInt32.Ptr, pdwRegister)
    GetObject(pimk, fBindIfRootRegistered, ppiunk)
      => ComCall(4, this.p, IMoniker, pimk, BOOL, fBindIfRootRegistered, IUnknown.Ptr, ppiunk)
    Revoke(dwRegister)
      => ComCall(5, this.p, UInt32, dwRegister)
    SetBrowseWindowInfo(phlbwi)
      => ComCall(6, this.p, HLBWINFO.Ptr, phlbwi)
    GetBrowseWindowInfo(phlbwi)
      => ComCall(7, this.p, HLBWINFO.Ptr, phlbwi)
    SetInitialHlink(pimkTarget, pwzLocation, pwzFriendlyName)
      => ComCall(8, this.p, IMoniker, pimkTarget, "Str", pwzLocation, "Str", pwzFriendlyName)
    OnNavigateHlink(grfHLNF, pimkTarget, pwzLocation, pwzFriendlyName, puHLID)
      => ComCall(9, this.p, UInt32, grfHLNF, IMoniker, pimkTarget, "Str", pwzLocation, "Str", pwzFriendlyName, UInt32.Ptr, puHLID)
    UpdateHlink(uHLID, pimkTarget, pwzLocation, pwzFriendlyName)
      => ComCall(10, this.p, UInt32, uHLID, IMoniker, pimkTarget, "Str", pwzLocation, "Str", pwzFriendlyName)
    EnumNavigationStack(dwReserved, grfHLFNAMEF, ppienumhlitem)
      => ComCall(11, this.p, UInt32, dwReserved, UInt32, grfHLFNAMEF, IEnumHLITEM.Ptr, ppienumhlitem)
    QueryHlink(grfHLQF, uHLID)
      => ComCall(12, this.p, UInt32, grfHLQF, UInt32, uHLID)
    GetHlink(uHLID, ppihl)
      => ComCall(13, this.p, UInt32, uHLID, IHlink.Ptr, ppihl)
    SetCurrentHlink(uHLID)
      => ComCall(14, this.p, UInt32, uHLID)
    Clone(piunkOuter, riid, ppiunkObj)
      => ComCall(15, this.p, IUnknown, piunkOuter, GUID.Ptr, riid, IUnknown.Ptr, ppiunkObj)
    Close(reserved)
      => ComCall(16, this.p, UInt32, reserved)
}
struct IExtensionServices extends IUnknown {
    static IID := "{79EAC9CB-BAF9-11CE-8C82-00AA004BA90B}"
    SetAdditionalHeaders(pwzAdditionalHeaders)
      => ComCall(3, this.p, "Str", pwzAdditionalHeaders)
    SetAuthenticateData(phwnd, pwzUsername, pwzPassword)
      => ComCall(4, this.p, HWND, phwnd, "Str", pwzUsername, "Str", pwzPassword)
}
struct ITravelEntry extends IUnknown {
    static IID := "{F46EDB3B-BC2F-11D0-9412-00AA00A3EBD3}"
    Invoke(punk?)
      => ComCall(3, this.p, IUnknown, punk?)
    Update(punk?, fIsLocalAnchor)
      => ComCall(4, this.p, IUnknown, punk?, BOOL, fIsLocalAnchor)
    GetPidl(ppidl)
      => ComCall(5, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
}
struct ITravelLog extends IUnknown {
    static IID := "{66A9CB08-4802-11D2-A561-00A0C92DBFE8}"
    AddEntry(punk?, fIsLocalAnchor)
      => ComCall(3, this.p, IUnknown, punk?, BOOL, fIsLocalAnchor)
    UpdateEntry(punk?, fIsLocalAnchor)
      => ComCall(4, this.p, IUnknown, punk?, BOOL, fIsLocalAnchor)
    UpdateExternal(punk?, punkHLBrowseContext?)
      => ComCall(5, this.p, IUnknown, punk?, IUnknown, punkHLBrowseContext?)
    Travel(punk?, iOffset)
      => ComCall(6, this.p, IUnknown, punk?, Int32, iOffset)
    GetTravelEntry(punk, iOffset, ppte?)
      => ComCall(7, this.p, IUnknown, punk, Int32, iOffset, ITravelEntry.Ptr, ppte?)
    FindTravelEntry(punk?, pidl, ppte)
      => ComCall(8, this.p, IUnknown, punk?, ITEMIDLIST.Ptr, pidl, ITravelEntry.Ptr, ppte)
    GetToolTipText(punk?, iOffset, idsTemplate, pwzText)
      => ComCall(9, this.p, IUnknown, punk?, Int32, iOffset, Int32, idsTemplate, PWSTR, pwzText, UInt32, pwzText.Length)
    InsertMenuEntries(punk?, hmenu1, nPos, idFirst, idLast, dwFlags)
      => ComCall(10, this.p, IUnknown, punk?, HMENU, hmenu1, Int32, nPos, Int32, idFirst, Int32, idLast, UInt32, dwFlags)
    Clone(pptl)
      => ComCall(11, this.p, ITravelLog.Ptr, pptl)
    CountEntries(punk)
      => ComCall(12, this.p, IUnknown, punk, UInt32)
    Revert()
      => ComCall(13, this.p)
}
struct CIE4ConnectionPoint extends IConnectionPoint {
    DoInvokeIE4(pf, ppv, dispid, pdispparams)
      => ComCall(8, this.p, BOOL.Ptr, pf, Struct.Ptr.Ptr, ppv, Int32, dispid, DISPPARAMS.Ptr, pdispparams)
    DoInvokePIDLIE4(dispid, pidl, fCanCancel)
      => ComCall(9, this.p, Int32, dispid, ITEMIDLIST.Ptr, pidl, BOOL, fCanCancel)
}
struct IExpDispSupportXP extends IUnknown {
    static IID := "{2F0DD58C-F789-4F14-99FB-9293B3C9C212}"
    FindCIE4ConnectionPoint(riid, ppccp)
      => ComCall(3, this.p, GUID.Ptr, riid, CIE4ConnectionPoint.Ptr, ppccp)
    OnTranslateAccelerator(pMsg, grfModifiers)
      => ComCall(4, this.p, MSG.Ptr, pMsg, UInt32, grfModifiers)
    OnInvoke(dispidMember, iid, lcid, wFlags, pdispparams, pVarResult, pexcepinfo, puArgErr)
      => ComCall(5, this.p, Int32, dispidMember, GUID.Ptr, iid, UInt32, lcid, UInt16, wFlags, DISPPARAMS.Ptr, pdispparams, VARIANT.Ptr, pVarResult, EXCEPINFO.Ptr, pexcepinfo, UInt32.Ptr, puArgErr)
}
struct IExpDispSupport extends IUnknown {
    static IID := "{0D7D1D00-6FC0-11D0-A974-00C04FD705A2}"
    FindConnectionPoint(riid, ppccp)
      => ComCall(3, this.p, GUID.Ptr, riid, IConnectionPoint.Ptr, ppccp)
    OnTranslateAccelerator(pMsg, grfModifiers)
      => ComCall(4, this.p, MSG.Ptr, pMsg, UInt32, grfModifiers)
    OnInvoke(dispidMember, iid, lcid, wFlags, pdispparams, pVarResult, pexcepinfo, puArgErr)
      => ComCall(5, this.p, Int32, dispidMember, GUID.Ptr, iid, UInt32, lcid, UInt16, wFlags, DISPPARAMS.Ptr, pdispparams, VARIANT.Ptr, pVarResult, EXCEPINFO.Ptr, pexcepinfo, UInt32.Ptr, puArgErr)
}
struct BNSTATE extends Int32 {
    static BNS_NORMAL := 0
    static BNS_BEGIN_NAVIGATE := 1
    static BNS_NAVIGATE := 2
}
struct SHELLBROWSERSHOWCONTROL extends Int32 {
    static SBSC_HIDE := 0
    static SBSC_SHOW := 1
    static SBSC_TOGGLE := 2
    static SBSC_QUERY := 3
}
struct IBrowserService extends IUnknown {
    static IID := "{02BA3B52-0547-11D1-B833-00C04FC9B31F}"
    GetParentSite(ppipsite)
      => ComCall(3, this.p, IOleInPlaceSite.Ptr, ppipsite)
    SetTitle(psv, pszName)
      => ComCall(4, this.p, IShellView, psv, "Str", pszName)
    GetTitle(psv, pszName)
      => ComCall(5, this.p, IShellView, psv, PWSTR, pszName, UInt32, pszName.Length)
    GetOleObject(ppobjv)
      => ComCall(6, this.p, IOleObject.Ptr, ppobjv)
    GetTravelLog(pptl)
      => ComCall(7, this.p, ITravelLog.Ptr, pptl)
    ShowControlWindow(id, fShow)
      => ComCall(8, this.p, UInt32, id, BOOL, fShow)
    IsControlWindowShown(id, pfShown)
      => ComCall(9, this.p, UInt32, id, BOOL.Ptr, pfShown)
    IEGetDisplayName(pidl, pwszName, uFlags)
      => ComCall(10, this.p, ITEMIDLIST.Ptr, pidl, PWSTR, pwszName, UInt32, uFlags)
    IEParseDisplayName(uiCP, pwszPath, ppidlOut)
      => ComCall(11, this.p, UInt32, uiCP, "Str", pwszPath, ITEMIDLIST.Ptr.Ptr, ppidlOut)
    DisplayParseError(hres, pwszPath)
      => ComCall(12, this.p, HRESULT, hres, "Str", pwszPath)
    NavigateToPidl(pidl, grfHLNF)
      => ComCall(13, this.p, ITEMIDLIST.Ptr, pidl, UInt32, grfHLNF)
    SetNavigateState(bnstate1)
      => ComCall(14, this.p, BNSTATE, bnstate1)
    GetNavigateState(pbnstate)
      => ComCall(15, this.p, BNSTATE.Ptr, pbnstate)
    NotifyRedirect(psv, pidl, pfDidBrowse)
      => ComCall(16, this.p, IShellView, psv, ITEMIDLIST.Ptr, pidl, BOOL.Ptr, pfDidBrowse)
    UpdateWindowList()
      => ComCall(17, this.p)
    UpdateBackForwardState()
      => ComCall(18, this.p)
    SetFlags(dwFlags, dwFlagMask)
      => ComCall(19, this.p, UInt32, dwFlags, UInt32, dwFlagMask)
    GetFlags(pdwFlags)
      => ComCall(20, this.p, UInt32.Ptr, pdwFlags)
    CanNavigateNow()
      => ComCall(21, this.p)
    GetPidl(ppidl)
      => ComCall(22, this.p, ITEMIDLIST.Ptr.Ptr, ppidl)
    SetReferrer(pidl)
      => ComCall(23, this.p, ITEMIDLIST.Ptr, pidl)
    GetBrowserIndex()
      => ComCall(24, this.p, UInt32)
    GetBrowserByIndex(dwID, ppunk)
      => ComCall(25, this.p, UInt32, dwID, IUnknown.Ptr, ppunk)
    GetHistoryObject(ppole, pstm, ppbc)
      => ComCall(26, this.p, IOleObject.Ptr, ppole, IStream.Ptr, pstm, IBindCtx.Ptr, ppbc)
    SetHistoryObject(pole, fIsLocalAnchor)
      => ComCall(27, this.p, IOleObject, pole, BOOL, fIsLocalAnchor)
    CacheOLEServer(pole)
      => ComCall(28, this.p, IOleObject, pole)
    GetSetCodePage(pvarIn, pvarOut)
      => ComCall(29, this.p, VARIANT.Ptr, pvarIn, VARIANT.Ptr, pvarOut)
    OnHttpEquiv(psv, fDone, pvarargIn, pvarargOut)
      => ComCall(30, this.p, IShellView, psv, BOOL, fDone, VARIANT.Ptr, pvarargIn, VARIANT.Ptr, pvarargOut)
    GetPalette(hpal)
      => ComCall(31, this.p, HPALETTE.Ptr, hpal)
    RegisterWindow(fForceRegister, swc)
      => ComCall(32, this.p, BOOL, fForceRegister, ShellWindowTypeConstants, swc)
}
struct IShellService extends IUnknown {
    static IID := "{5836FB00-8187-11CF-A12B-00AA004AE837}"
    SetOwner(punkOwner?)
      => ComCall(3, this.p, IUnknown, punkOwner?)
}
struct SECURELOCKCODE extends Int32 {
    static SECURELOCK_NOCHANGE := -1
    static SECURELOCK_SET_UNSECURE := 0
    static SECURELOCK_SET_MIXED := 1
    static SECURELOCK_SET_SECUREUNKNOWNBIT := 2
    static SECURELOCK_SET_SECURE40BIT := 3
    static SECURELOCK_SET_SECURE56BIT := 4
    static SECURELOCK_SET_FORTEZZA := 5
    static SECURELOCK_SET_SECURE128BIT := 6
    static SECURELOCK_FIRSTSUGGEST := 7
    static SECURELOCK_SUGGEST_UNSECURE := 7
    static SECURELOCK_SUGGEST_MIXED := 8
    static SECURELOCK_SUGGEST_SECUREUNKNOWNBIT := 9
    static SECURELOCK_SUGGEST_SECURE40BIT := 10
    static SECURELOCK_SUGGEST_SECURE56BIT := 11
    static SECURELOCK_SUGGEST_FORTEZZA := 12
    static SECURELOCK_SUGGEST_SECURE128BIT := 13
}
struct BASEBROWSERDATAXP {
    _hwnd : HWND
    _ptl : ITravelLog
    _phlf : IHlinkFrame
    _pautoWB2 : IWebBrowser2
    _pautoEDS : IExpDispSupportXP
    _pautoSS : IShellService
    _eSecureLockIcon : Int32
    _bitfield : UInt32
    _uActivateState : UInt32
    _pidlViewState : ITEMIDLIST.Ptr
    _pctView : IOleCommandTarget
    _pidlCur : ITEMIDLIST.Ptr
    _psv : IShellView
    _psf : IShellFolder
    _hwndView : HWND
    _pszTitleCur : PWSTR
    _pidlPending : ITEMIDLIST.Ptr
    _psvPending : IShellView
    _psfPending : IShellFolder
    _hwndViewPending : HWND
    _pszTitlePending : PWSTR
    _fIsViewMSHTML : BOOL
    _fPrivacyImpacted : BOOL
    _clsidView : GUID
    _clsidViewPending : GUID
    _hwndFrame : HWND
}
struct BASEBROWSERDATALH {
    _hwnd : HWND
    _ptl : ITravelLog
    _phlf : IHlinkFrame
    _pautoWB2 : IWebBrowser2
    _pautoEDS : IExpDispSupport
    _pautoSS : IShellService
    _eSecureLockIcon : Int32
    _bitfield : UInt32
    _uActivateState : UInt32
    _pidlViewState : ITEMIDLIST.Ptr
    _pctView : IOleCommandTarget
    _pidlCur : ITEMIDLIST.Ptr
    _psv : IShellView
    _psf : IShellFolder
    _hwndView : HWND
    _pszTitleCur : PWSTR
    _pidlPending : ITEMIDLIST.Ptr
    _psvPending : IShellView
    _psfPending : IShellFolder
    _hwndViewPending : HWND
    _pszTitlePending : PWSTR
    _fIsViewMSHTML : BOOL
    _fPrivacyImpacted : BOOL
    _clsidView : GUID
    _clsidViewPending : GUID
    _hwndFrame : HWND
    _lPhishingFilterStatus : Int32
}
struct FOLDERSETDATA {
    _fs : FOLDERSETTINGS
    _vidRestore : GUID
    _dwViewPriority : UInt32
}
struct TOOLBARITEM {
    ptbar : IDockingWindow
    rcBorderTool : RECT
    pwszItem : PWSTR
    fShow : BOOL
    hMon : HMONITOR
}
struct IBrowserService2 extends IBrowserService {
    static IID := "{68BD21CC-438B-11D2-A560-00A0C92DBFE8}"
    WndProcBS(hwnd1, uMsg, wParam1, lParam1)
      => ComCall(33, this.p, HWND, hwnd1, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT)
    SetAsDefFolderSettings()
      => ComCall(34, this.p)
    GetViewRect(prc)
      => ComCall(35, this.p, RECT.Ptr, prc)
    OnSize(wParam1)
      => ComCall(36, this.p, WPARAM, wParam1)
    OnCreate(pcs)
      => ComCall(37, this.p, CREATESTRUCTW.Ptr, pcs)
    OnCommand(wParam1, lParam1)
      => ComCall(38, this.p, WPARAM, wParam1, LPARAM, lParam1, LRESULT)
    OnDestroy()
      => ComCall(39, this.p)
    OnNotify(pnm)
      => ComCall(40, this.p, NMHDR.Ptr, pnm, LRESULT)
    OnSetFocus()
      => ComCall(41, this.p)
    OnFrameWindowActivateBS(fActive)
      => ComCall(42, this.p, BOOL, fActive)
    ReleaseShellView()
      => ComCall(43, this.p)
    ActivatePendingView()
      => ComCall(44, this.p)
    CreateViewWindow(psvNew, psvOld, prcView, phwnd)
      => ComCall(45, this.p, IShellView, psvNew, IShellView, psvOld, RECT.Ptr, prcView, HWND.Ptr, phwnd)
    CreateBrowserPropSheetExt(riid, ppv)
      => ComCall(46, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetViewWindow(phwndView)
      => ComCall(47, this.p, HWND.Ptr, phwndView)
    GetBaseBrowserData(pbbd)
      => ComCall(48, this.p, BASEBROWSERDATALH.Ptr.Ptr, pbbd)
    PutBaseBrowserData()
      => ComCall(49, this.p, BASEBROWSERDATALH.Ptr)
    InitializeTravelLog(ptl, dw)
      => ComCall(50, this.p, ITravelLog, ptl, UInt32, dw)
    SetTopBrowser()
      => ComCall(51, this.p)
    Offline(iCmd)
      => ComCall(52, this.p, Int32, iCmd)
    AllowViewResize(f)
      => ComCall(53, this.p, BOOL, f)
    SetActivateState(u)
      => ComCall(54, this.p, UInt32, u)
    UpdateSecureLockIcon(eSecureLock)
      => ComCall(55, this.p, Int32, eSecureLock)
    InitializeDownloadManager()
      => ComCall(56, this.p)
    InitializeTransitionSite()
      => ComCall(57, this.p)
    _Initialize(hwnd1, pauto)
      => ComCall(58, this.p, HWND, hwnd1, IUnknown, pauto)
    _CancelPendingNavigationAsync()
      => ComCall(59, this.p)
    _CancelPendingView()
      => ComCall(60, this.p)
    _MaySaveChanges()
      => ComCall(61, this.p)
    _PauseOrResumeView(fPaused)
      => ComCall(62, this.p, BOOL, fPaused)
    _DisableModeless()
      => ComCall(63, this.p)
    _NavigateToPidl2(pidl, grfHLNF, dwFlags)
      => ComCall(64, this.p, ITEMIDLIST.Ptr, pidl, UInt32, grfHLNF, UInt32, dwFlags)
    _TryShell2Rename(psv, pidlNew)
      => ComCall(65, this.p, IShellView, psv, ITEMIDLIST.Ptr, pidlNew)
    _SwitchActivationNow()
      => ComCall(66, this.p)
    _ExecChildren(punkBar, fBroadcast, pguidCmdGroup?, nCmdID, nCmdexecopt, pvarargIn?, pvarargOut?)
      => ComCall(67, this.p, IUnknown, punkBar, BOOL, fBroadcast, GUID.Ptr, pguidCmdGroup?, UInt32, nCmdID, UInt32, nCmdexecopt, VARIANT.Ptr, pvarargIn?, VARIANT.Ptr, pvarargOut?)
    _SendChildren(hwndBar, fBroadcast, uMsg, wParam1, lParam1)
      => ComCall(68, this.p, HWND, hwndBar, BOOL, fBroadcast, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1)
    GetFolderSetData(pfsd)
      => ComCall(69, this.p, FOLDERSETDATA.Ptr, pfsd)
    _OnFocusChange(itb)
      => ComCall(70, this.p, UInt32, itb)
    v_ShowHideChildWindows(fChildOnly)
      => ComCall(71, this.p, BOOL, fChildOnly)
    _get_itbLastFocus()
      => ComCall(72, this.p, UInt32)
    _put_itbLastFocus(itbLastFocus)
      => ComCall(73, this.p, UInt32, itbLastFocus)
    _UIActivateView(uState)
      => ComCall(74, this.p, UInt32, uState)
    _GetViewBorderRect(prc)
      => ComCall(75, this.p, RECT.Ptr, prc)
    _UpdateViewRectSize()
      => ComCall(76, this.p)
    _ResizeNextBorder(itb)
      => ComCall(77, this.p, UInt32, itb)
    _ResizeView()
      => ComCall(78, this.p)
    _GetEffectiveClientArea(lprectBorder, hmon)
      => ComCall(79, this.p, RECT.Ptr, lprectBorder, HMONITOR, hmon)
    v_GetViewStream(pidl, grfMode, pwszName)
      => ComCall(80, this.p, ITEMIDLIST.Ptr, pidl, UInt32, grfMode, "Str", pwszName, IStream)
    ForwardViewMsg(uMsg, wParam1, lParam1)
      => ComCall(81, this.p, UInt32, uMsg, WPARAM, wParam1, LPARAM, lParam1, LRESULT)
    SetAcceleratorMenu(hacc)
      => ComCall(82, this.p, HACCEL, hacc)
    _GetToolbarCount()
      => ComCall(83, this.p, Int32)
    _GetToolbarItem(itb)
      => ComCall(84, this.p, Int32, itb, TOOLBARITEM.Ptr)
    _SaveToolbars(pstm)
      => ComCall(85, this.p, IStream, pstm)
    _LoadToolbars(pstm)
      => ComCall(86, this.p, IStream, pstm)
    _CloseAndReleaseToolbars(fClose)
      => ComCall(87, this.p, BOOL, fClose)
    v_MayGetNextToolbarFocus(lpMsg, itbNext, citb, pptbi, phwnd)
      => ComCall(88, this.p, MSG.Ptr, lpMsg, UInt32, itbNext, Int32, citb, TOOLBARITEM.Ptr.Ptr, pptbi, HWND.Ptr, phwnd)
    _ResizeNextBorderHelper(itb, bUseHmonitor)
      => ComCall(89, this.p, UInt32, itb, BOOL, bUseHmonitor)
    _FindTBar(punkSrc)
      => ComCall(90, this.p, IUnknown, punkSrc, UInt32)
    _SetFocus(ptbi, hwnd1, lpMsg)
      => ComCall(91, this.p, TOOLBARITEM.Ptr, ptbi, HWND, hwnd1, MSG.Ptr, lpMsg)
    v_MayTranslateAccelerator(pmsg)
      => ComCall(92, this.p, MSG.Ptr, pmsg)
    _GetBorderDWHelper(punkSrc, lprectBorder, bUseHmonitor)
      => ComCall(93, this.p, IUnknown, punkSrc, RECT.Ptr, lprectBorder, BOOL, bUseHmonitor)
    v_CheckZoneCrossing(pidl)
      => ComCall(94, this.p, ITEMIDLIST.Ptr, pidl)
}
struct IEPDNFLAGS extends Int32 {
    static IEPDN_BINDINGUI := 1
}
struct IBrowserService3 extends IBrowserService2 {
    static IID := "{27D7CE21-762D-48F3-86F3-40E2FD3749C4}"
    _PositionViewWindow(hwnd1, prc)
      => ComCall(95, this.p, HWND, hwnd1, RECT.Ptr, prc)
    IEParseDisplayNameEx(uiCP, pwszPath, dwFlags, ppidlOut)
      => ComCall(96, this.p, UInt32, uiCP, "Str", pwszPath, UInt32, dwFlags, ITEMIDLIST.Ptr.Ptr, ppidlOut)
}
struct IBrowserService4 extends IBrowserService3 {
    static IID := "{639F1BFF-E135-4096-ABD8-E0F504D649A4}"
    ActivateView(fPendingView)
      => ComCall(97, this.p, BOOL, fPendingView)
    SaveViewState()
      => ComCall(98, this.p)
    _ResizeAllBorders()
      => ComCall(99, this.p)
}
struct ITrackShellMenu extends IShellMenu {
    static IID := "{8278F932-2A3E-11D2-838F-00C04FD918D0}"
    SetObscured(hwndTB, punkBand, dwSMSetFlags)
      => ComCall(12, this.p, HWND, hwndTB, IUnknown, punkBand, UInt32, dwSMSetFlags)
    Popup(hwnd1, ppt, prcExclude, dwFlags)
      => ComCall(13, this.p, HWND, hwnd1, POINTL.Ptr, ppt, RECTL.Ptr, prcExclude, Int32, dwFlags)
}
struct TI_FLAGS extends Int32 {
    static TI_BITMAP := 1
    static TI_JPEG := 2
}
struct ITranscodeImage extends IUnknown {
    static IID := "{BAE86DDD-DC11-421C-B7AB-CC55D1D65C44}"
    TranscodeImage(pShellItem?, uiMaxWidth, uiMaxHeight, flags, pvImage?, puiWidth, puiHeight)
      => ComCall(3, this.p, IShellItem, pShellItem?, UInt32, uiMaxWidth, UInt32, uiMaxHeight, UInt32, flags, IStream, pvImage?, UInt32.Ptr, puiWidth, UInt32.Ptr, puiHeight)
}
struct PATHCCH_OPTIONS extends UInt32 {
    static PATHCCH_NONE := 0
    static PATHCCH_ALLOW_LONG_PATHS := 1
    static PATHCCH_FORCE_ENABLE_LONG_NAME_PROCESS := 2
    static PATHCCH_FORCE_DISABLE_LONG_NAME_PROCESS := 4
    static PATHCCH_DO_NOT_NORMALIZE_SEGMENTS := 8
    static PATHCCH_ENSURE_IS_EXTENDED_LENGTH_PATH := 16
    static PATHCCH_ENSURE_TRAILING_SLASH := 32
    static PATHCCH_CANONICALIZE_SLASHES := 64
}
struct APPLET_PROC extends FunctionPointer {
    static Types := [HWND, UInt32, LPARAM, LPARAM, Int32]
}
struct CPLINFO {
    idIcon : Int32
    idName : Int32
    idInfo : Int32
    lData : IntPtr
}
struct NEWCPLINFOA {
    dwSize : UInt32
    dwFlags : UInt32
    dwHelpContext : UInt32
    lData : IntPtr
    hIcon : HICON
    szName : CHAR[32]
    szInfo : CHAR[64]
    szHelpFile : CHAR[128]
}
struct NEWCPLINFOW {
    dwSize : UInt32
    dwFlags : UInt32
    dwHelpContext : UInt32
    lData : IntPtr
    hIcon : HICON
    szName : UInt16[32]
    szInfo : UInt16[64]
    szHelpFile : UInt16[128]
}
struct PROFILEINFOA {
    dwSize : UInt32
    dwFlags : UInt32
    lpUserName : PSTR
    lpProfilePath : PSTR
    lpDefaultPath : PSTR
    lpServerName : PSTR
    lpPolicyPath : PSTR
    hProfile : HANDLE
}
struct PROFILEINFOW {
    dwSize : UInt32
    dwFlags : UInt32
    lpUserName : PWSTR
    lpProfilePath : PWSTR
    lpDefaultPath : PWSTR
    lpServerName : PWSTR
    lpPolicyPath : PWSTR
    hProfile : HANDLE
}
struct IURL_SETURL_FLAGS extends Int32 {
    static IURL_SETURL_FL_GUESS_PROTOCOL := 1
    static IURL_SETURL_FL_USE_DEFAULT_PROTOCOL := 2
}
struct IURL_INVOKECOMMAND_FLAGS extends Int32 {
    static IURL_INVOKECOMMAND_FL_ALLOW_UI := 1
    static IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB := 2
    static IURL_INVOKECOMMAND_FL_DDEWAIT := 4
    static IURL_INVOKECOMMAND_FL_ASYNCOK := 8
    static IURL_INVOKECOMMAND_FL_LOG_USAGE := 16
}
struct URLINVOKECOMMANDINFOA {
    dwcbSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    pcszVerb : PSTR
}
struct URLINVOKECOMMANDINFOW {
    dwcbSize : UInt32
    dwFlags : UInt32
    hwndParent : HWND
    pcszVerb : PWSTR
}
struct IUniformResourceLocatorA extends IUnknown {
    static IID := "{FBF23B80-E3F0-101B-8488-00AA003E56F8}"
    SetURL(pcszURL, dwInFlags)
      => ComCall(3, this.p, PSTR, pcszURL, UInt32, dwInFlags)
    GetURL(ppszURL)
      => ComCall(4, this.p, PSTR.Ptr, ppszURL)
    InvokeCommand(purlici)
      => ComCall(5, this.p, URLINVOKECOMMANDINFOA.Ptr, purlici)
}
struct IUniformResourceLocatorW extends IUnknown {
    static IID := "{CABB0DA0-DA57-11CF-9974-0020AFD79762}"
    SetURL(pcszURL, dwInFlags)
      => ComCall(3, this.p, "Str", pcszURL, UInt32, dwInFlags)
    GetURL(ppszURL)
      => ComCall(4, this.p, PWSTR.Ptr, ppszURL)
    InvokeCommand(purlici)
      => ComCall(5, this.p, URLINVOKECOMMANDINFOW.Ptr, purlici)
}
struct TRANSLATEURL_IN_FLAGS extends Int32 {
    static TRANSLATEURL_FL_GUESS_PROTOCOL := 1
    static TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL := 2
}
struct URLASSOCIATIONDIALOG_IN_FLAGS extends Int32 {
    static URLASSOCDLG_FL_USE_DEFAULT_NAME := 1
    static URLASSOCDLG_FL_REGISTER_ASSOC := 2
}
struct MIMEASSOCIATIONDIALOG_IN_FLAGS extends Int32 {
    static MIMEASSOCDLG_FL_REGISTER_ASSOC := 1
}
struct PAPPSTATE_CHANGE_ROUTINE extends FunctionPointer {
    static Types := [BOOLEAN, Struct.Ptr, "Void"]
}
struct PAPPCONSTRAIN_CHANGE_ROUTINE extends FunctionPointer {
    static Types := [BOOLEAN, Struct.Ptr, "Void"]
}
struct IInputPaneAnimationCoordinator extends IUnknown {
    static IID := "{2AF16BA9-2DE5-4B75-82D9-01372AFBFFB4}"
    AddAnimation(device, animation)
      => ComCall(3, this.p, IUnknown, device, IDCompositionAnimation, animation)
}
