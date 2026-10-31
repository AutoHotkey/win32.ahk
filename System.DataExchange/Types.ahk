#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HWND, LPARAM, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {HMETAFILE}
#Import "..\Security\Types.ahk" {SECURITY_QUALITY_OF_SERVICE}

struct DDE_ENABLE_CALLBACK_CMD extends UInt32 {
    static EC_ENABLEALL := 0
    static EC_ENABLEONE := 128
    static EC_DISABLE := 8
    static EC_QUERYWAITING := 2
}
struct DDE_INITIALIZE_COMMAND extends UInt32 {
    static APPCLASS_MONITOR := 1
    static APPCLASS_STANDARD := 0
    static APPCMD_CLIENTONLY := 16
    static APPCMD_FILTERINITS := 32
    static CBF_FAIL_ALLSVRXACTIONS := 258048
    static CBF_FAIL_ADVISES := 16384
    static CBF_FAIL_CONNECTIONS := 8192
    static CBF_FAIL_EXECUTES := 32768
    static CBF_FAIL_POKES := 65536
    static CBF_FAIL_REQUESTS := 131072
    static CBF_FAIL_SELFCONNECTIONS := 4096
    static CBF_SKIP_ALLNOTIFICATIONS := 3932160
    static CBF_SKIP_CONNECT_CONFIRMS := 262144
    static CBF_SKIP_DISCONNECTS := 2097152
    static CBF_SKIP_REGISTRATIONS := 524288
    static CBF_SKIP_UNREGISTRATIONS := 1048576
    static MF_CALLBACKS := 134217728
    static MF_CONV := 1073741824
    static MF_ERRORS := 268435456
    static MF_HSZ_INFO := 16777216
    static MF_LINKS := 536870912
    static MF_POSTMSGS := 67108864
    static MF_SENDMSGS := 33554432
}
struct DDE_NAME_SERVICE_CMD extends UInt32 {
    static DNS_REGISTER := 1
    static DNS_UNREGISTER := 2
    static DNS_FILTERON := 4
    static DNS_FILTEROFF := 8
}
struct DDE_CLIENT_TRANSACTION_TYPE extends UInt32 {
    static XTYP_ADVSTART := 4144
    static XTYP_ADVSTOP := 32832
    static XTYP_EXECUTE := 16464
    static XTYP_POKE := 16528
    static XTYP_REQUEST := 8368
    static XTYP_ADVDATA := 16400
    static XTYP_ADVREQ := 8226
    static XTYP_CONNECT := 4194
    static XTYP_CONNECT_CONFIRM := 32882
    static XTYP_DISCONNECT := 32962
    static XTYP_MONITOR := 33010
    static XTYP_REGISTER := 32930
    static XTYP_UNREGISTER := 32978
    static XTYP_WILDCONNECT := 8418
    static XTYP_XACT_COMPLETE := 32896
}
struct CONVINFO_CONVERSATION_STATE extends UInt32 {
    static XST_ADVACKRCVD := 13
    static XST_ADVDATAACKRCVD := 16
    static XST_ADVDATASENT := 15
    static XST_ADVSENT := 11
    static XST_CONNECTED := 2
    static XST_DATARCVD := 6
    static XST_EXECACKRCVD := 10
    static XST_EXECSENT := 9
    static XST_INCOMPLETE := 1
    static XST_INIT1 := 3
    static XST_INIT2 := 4
    static XST_NULL := 0
    static XST_POKEACKRCVD := 8
    static XST_POKESENT := 7
    static XST_REQSENT := 5
    static XST_UNADVACKRCVD := 14
    static XST_UNADVSENT := 12
}
struct CONVINFO_STATUS extends UInt32 {
    static ST_ADVISE := 2
    static ST_BLOCKED := 8
    static ST_BLOCKNEXT := 128
    static ST_CLIENT := 16
    static ST_CONNECTED := 1
    static ST_INLIST := 64
    static ST_ISLOCAL := 4
    static ST_ISSELF := 256
    static ST_TERMINATED := 32
}
struct HSZ {
    Value : IntPtr
}
struct HCONV {
    Value : IntPtr
}
struct HCONVLIST {
    Value : IntPtr
}
struct HDDEDATA {
    Value : IntPtr
}
struct DDEACK {
    _bitfield : UInt16
}
struct DDEADVISE {
    _bitfield : UInt16
    cfFormat : Int16
}
struct DDEDATA {
    _bitfield : UInt16
    cfFormat : Int16
    Value : UInt8[1]
}
struct DDEPOKE {
    _bitfield : UInt16
    cfFormat : Int16
    Value : UInt8[1]
}
struct DDELN {
    _bitfield : UInt16
    cfFormat : Int16
}
struct DDEUP {
    _bitfield : UInt16
    cfFormat : Int16
    rgb : UInt8[1]
}
struct HSZPAIR {
    hszSvc : HSZ
    hszTopic : HSZ
}
struct CONVCONTEXT {
    cb : UInt32
    wFlags : UInt32
    wCountryID : UInt32
    iCodePage : Int32
    dwLangID : UInt32
    dwSecurity : UInt32
    qos : SECURITY_QUALITY_OF_SERVICE
}
struct CONVINFO {
    cb : UInt32
    hUser : IntPtr
    hConvPartner : HCONV
    hszSvcPartner : HSZ
    hszServiceReq : HSZ
    hszTopic : HSZ
    hszItem : HSZ
    wFmt : UInt32
    wType : DDE_CLIENT_TRANSACTION_TYPE
    wStatus : CONVINFO_STATUS
    wConvst : CONVINFO_CONVERSATION_STATE
    wLastError : UInt32
    hConvList : HCONVLIST
    ConvCtxt : CONVCONTEXT
    hwnd : HWND
    hwndPartner : HWND
}
struct PFNCALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, HCONV, HSZ, HSZ, HDDEDATA, IntPtr, IntPtr, HDDEDATA]
}
struct DDEML_MSG_HOOK_DATA {
    uiLo : IntPtr
    uiHi : IntPtr
    cbData : UInt32
    Data : UInt32[8]
}
struct MONMSGSTRUCT {
    cb : UInt32
    hwndTo : HWND
    dwTime : UInt32
    hTask : HANDLE
    wMsg : UInt32
    wParam : WPARAM
    lParam : LPARAM
    dmhd : DDEML_MSG_HOOK_DATA
}
struct MONCBSTRUCT {
    cb : UInt32
    dwTime : UInt32
    hTask : HANDLE
    dwRet : UInt32
    wType : UInt32
    wFmt : UInt32
    hConv : HCONV
    hsz1 : HSZ
    hsz2 : HSZ
    hData : HDDEDATA
    dwData1 : IntPtr
    dwData2 : IntPtr
    cc : CONVCONTEXT
    cbData : UInt32
    Data : UInt32[8]
}
struct MONHSZSTRUCTA {
    cb : UInt32
    fsAction : BOOL
    dwTime : UInt32
    hsz : HSZ
    hTask : HANDLE
    str : CHAR[1]
}
struct MONHSZSTRUCTW {
    cb : UInt32
    fsAction : BOOL
    dwTime : UInt32
    hsz : HSZ
    hTask : HANDLE
    str : UInt16[1]
}
struct MONERRSTRUCT {
    cb : UInt32
    wLastError : UInt32
    dwTime : UInt32
    hTask : HANDLE
}
struct MONLINKSTRUCT {
    cb : UInt32
    dwTime : UInt32
    hTask : HANDLE
    fEstablished : BOOL
    fNoData : BOOL
    hszSvc : HSZ
    hszTopic : HSZ
    hszItem : HSZ
    wFmt : UInt32
    fServer : BOOL
    hConvServer : HCONV
    hConvClient : HCONV
}
struct MONCONVSTRUCT {
    cb : UInt32
    fConnect : BOOL
    dwTime : UInt32
    hTask : HANDLE
    hszSvc : HSZ
    hszTopic : HSZ
    hConvClient : HCONV
    hConvServer : HCONV
}
struct METAFILEPICT {
    mm : Int32
    xExt : Int32
    yExt : Int32
    hMF : HMETAFILE
}
struct COPYDATASTRUCT {
    dwData : IntPtr
    cbData : UInt32
    lpData : Struct.Ptr
}
