#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLElement}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HANDLE_PTR, HRESULT, HWND, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {BINDINFO, IBindCtx, IBinding, IClassFactory, IEnumString, IMoniker, IUnknown, IUri, IUriBuilder}

struct IEObjectType extends Int32 {
    static IE_EPM_OBJECT_EVENT := 0
    static IE_EPM_OBJECT_MUTEX := 1
    static IE_EPM_OBJECT_SEMAPHORE := 2
    static IE_EPM_OBJECT_SHARED_MEMORY := 3
    static IE_EPM_OBJECT_WAITABLE_TIMER := 4
    static IE_EPM_OBJECT_FILE := 5
    static IE_EPM_OBJECT_NAMED_PIPE := 6
    static IE_EPM_OBJECT_REGISTRY := 7
}
struct IPersistMoniker extends IUnknown {
    static IID := "{79EAC9C9-BAF9-11CE-8C82-00AA004BA90B}"
    GetClassID(pClassID)
      => ComCall(3, this.p, GUID.Ptr, pClassID)
    IsDirty()
      => ComCall(4, this.p)
    Load(fFullyAvailable, pimkName, pibc, grfMode)
      => ComCall(5, this.p, BOOL, fFullyAvailable, IMoniker, pimkName, IBindCtx, pibc, UInt32, grfMode)
    Save(pimkName, pbc, fRemember)
      => ComCall(6, this.p, IMoniker, pimkName, IBindCtx, pbc, BOOL, fRemember)
    SaveCompleted(pimkName, pibc)
      => ComCall(7, this.p, IMoniker, pimkName, IBindCtx, pibc)
    GetCurMoniker(ppimkName)
      => ComCall(8, this.p, IMoniker.Ptr, ppimkName)
}
struct MONIKERPROPERTY extends Int32 {
    static MIMETYPEPROP := 0
    static USE_SRC_URL := 1
    static CLASSIDPROP := 2
    static TRUSTEDDOWNLOADPROP := 3
    static POPUPLEVELPROP := 4
}
struct IMonikerProp extends IUnknown {
    static IID := "{A5CA5F7F-1847-4D87-9C5B-918509F7511D}"
    PutProperty(mkp, val)
      => ComCall(3, this.p, MONIKERPROPERTY, mkp, "Str", val)
}
struct IBindProtocol extends IUnknown {
    static IID := "{79EAC9CD-BAF9-11CE-8C82-00AA004BA90B}"
    CreateBinding(szUrl, pbc, ppb)
      => ComCall(3, this.p, "Str", szUrl, IBindCtx, pbc, IBinding.Ptr, ppb)
}
struct BINDVERB extends Int32 {
    static BINDVERB_GET := 0
    static BINDVERB_POST := 1
    static BINDVERB_PUT := 2
    static BINDVERB_CUSTOM := 3
    static BINDVERB_RESERVED1 := 4
}
struct BINDF extends Int32 {
    static BINDF_ASYNCHRONOUS := 1
    static BINDF_ASYNCSTORAGE := 2
    static BINDF_NOPROGRESSIVERENDERING := 4
    static BINDF_OFFLINEOPERATION := 8
    static BINDF_GETNEWESTVERSION := 16
    static BINDF_NOWRITECACHE := 32
    static BINDF_NEEDFILE := 64
    static BINDF_PULLDATA := 128
    static BINDF_IGNORESECURITYPROBLEM := 256
    static BINDF_RESYNCHRONIZE := 512
    static BINDF_HYPERLINK := 1024
    static BINDF_NO_UI := 2048
    static BINDF_SILENTOPERATION := 4096
    static BINDF_PRAGMA_NO_CACHE := 8192
    static BINDF_GETCLASSOBJECT := 16384
    static BINDF_RESERVED_1 := 32768
    static BINDF_FREE_THREADED := 65536
    static BINDF_DIRECT_READ := 131072
    static BINDF_FORMS_SUBMIT := 262144
    static BINDF_GETFROMCACHE_IF_NET_FAIL := 524288
    static BINDF_FROMURLMON := 1048576
    static BINDF_FWD_BACK := 2097152
    static BINDF_PREFERDEFAULTHANDLER := 4194304
    static BINDF_ENFORCERESTRICTED := 8388608
    static BINDF_RESERVED_2 := -2147483648
    static BINDF_RESERVED_3 := 16777216
    static BINDF_RESERVED_4 := 33554432
    static BINDF_RESERVED_5 := 67108864
    static BINDF_RESERVED_6 := 134217728
    static BINDF_RESERVED_7 := 1073741824
    static BINDF_RESERVED_8 := 536870912
}
struct URL_ENCODING extends Int32 {
    static URL_ENCODING_NONE := 0
    static URL_ENCODING_ENABLE_UTF8 := 268435456
    static URL_ENCODING_DISABLE_UTF8 := 536870912
}
struct REMSECURITY_ATTRIBUTES {
    nLength : UInt32
    lpSecurityDescriptor : UInt32
    bInheritHandle : BOOL
}
struct RemBINDINFO {
    cbSize : UInt32 := this.Size
    szExtraInfo : PWSTR
    grfBindInfoF : UInt32
    dwBindVerb : UInt32
    szCustomVerb : PWSTR
    cbstgmedData : UInt32
    dwOptions : UInt32
    dwOptionsFlags : UInt32
    dwCodePage : UInt32
    securityAttributes : REMSECURITY_ATTRIBUTES
    iid : GUID
    pUnk : IUnknown
    dwReserved : UInt32
}
struct RemFORMATETC {
    cfFormat : UInt32
    ptd : UInt32
    dwAspect : UInt32
    lindex : Int32
    tymed : UInt32
}
struct BINDINFO_OPTIONS extends Int32 {
    static BINDINFO_OPTIONS_WININETFLAG := 65536
    static BINDINFO_OPTIONS_ENABLE_UTF8 := 131072
    static BINDINFO_OPTIONS_DISABLE_UTF8 := 262144
    static BINDINFO_OPTIONS_USE_IE_ENCODING := 524288
    static BINDINFO_OPTIONS_BINDTOOBJECT := 1048576
    static BINDINFO_OPTIONS_SECURITYOPTOUT := 2097152
    static BINDINFO_OPTIONS_IGNOREMIMETEXTPLAIN := 4194304
    static BINDINFO_OPTIONS_USEBINDSTRINGCREDS := 8388608
    static BINDINFO_OPTIONS_IGNOREHTTPHTTPSREDIRECTS := 16777216
    static BINDINFO_OPTIONS_IGNORE_SSLERRORS_ONCE := 33554432
    static BINDINFO_WPC_DOWNLOADBLOCKED := 134217728
    static BINDINFO_WPC_LOGGING_ENABLED := 268435456
    static BINDINFO_OPTIONS_ALLOWCONNECTDATA := 536870912
    static BINDINFO_OPTIONS_DISABLEAUTOREDIRECTS := 1073741824
    static BINDINFO_OPTIONS_SHDOCVW_NAVIGATE := -2147483648
}
struct BSCF extends Int32 {
    static BSCF_FIRSTDATANOTIFICATION := 1
    static BSCF_INTERMEDIATEDATANOTIFICATION := 2
    static BSCF_LASTDATANOTIFICATION := 4
    static BSCF_DATAFULLYAVAILABLE := 8
    static BSCF_AVAILABLEDATASIZEUNKNOWN := 16
    static BSCF_SKIPDRAINDATAFORFILEURLS := 32
    static BSCF_64BITLENGTHDOWNLOAD := 64
}
struct BINDSTATUS extends Int32 {
    static BINDSTATUS_FINDINGRESOURCE := 1
    static BINDSTATUS_CONNECTING := 2
    static BINDSTATUS_REDIRECTING := 3
    static BINDSTATUS_BEGINDOWNLOADDATA := 4
    static BINDSTATUS_DOWNLOADINGDATA := 5
    static BINDSTATUS_ENDDOWNLOADDATA := 6
    static BINDSTATUS_BEGINDOWNLOADCOMPONENTS := 7
    static BINDSTATUS_INSTALLINGCOMPONENTS := 8
    static BINDSTATUS_ENDDOWNLOADCOMPONENTS := 9
    static BINDSTATUS_USINGCACHEDCOPY := 10
    static BINDSTATUS_SENDINGREQUEST := 11
    static BINDSTATUS_CLASSIDAVAILABLE := 12
    static BINDSTATUS_MIMETYPEAVAILABLE := 13
    static BINDSTATUS_CACHEFILENAMEAVAILABLE := 14
    static BINDSTATUS_BEGINSYNCOPERATION := 15
    static BINDSTATUS_ENDSYNCOPERATION := 16
    static BINDSTATUS_BEGINUPLOADDATA := 17
    static BINDSTATUS_UPLOADINGDATA := 18
    static BINDSTATUS_ENDUPLOADDATA := 19
    static BINDSTATUS_PROTOCOLCLASSID := 20
    static BINDSTATUS_ENCODING := 21
    static BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE := 22
    static BINDSTATUS_CLASSINSTALLLOCATION := 23
    static BINDSTATUS_DECODING := 24
    static BINDSTATUS_LOADINGMIMEHANDLER := 25
    static BINDSTATUS_CONTENTDISPOSITIONATTACH := 26
    static BINDSTATUS_FILTERREPORTMIMETYPE := 27
    static BINDSTATUS_CLSIDCANINSTANTIATE := 28
    static BINDSTATUS_IUNKNOWNAVAILABLE := 29
    static BINDSTATUS_DIRECTBIND := 30
    static BINDSTATUS_RAWMIMETYPE := 31
    static BINDSTATUS_PROXYDETECTING := 32
    static BINDSTATUS_ACCEPTRANGES := 33
    static BINDSTATUS_COOKIE_SENT := 34
    static BINDSTATUS_COMPACT_POLICY_RECEIVED := 35
    static BINDSTATUS_COOKIE_SUPPRESSED := 36
    static BINDSTATUS_COOKIE_STATE_UNKNOWN := 37
    static BINDSTATUS_COOKIE_STATE_ACCEPT := 38
    static BINDSTATUS_COOKIE_STATE_REJECT := 39
    static BINDSTATUS_COOKIE_STATE_PROMPT := 40
    static BINDSTATUS_COOKIE_STATE_LEASH := 41
    static BINDSTATUS_COOKIE_STATE_DOWNGRADE := 42
    static BINDSTATUS_POLICY_HREF := 43
    static BINDSTATUS_P3P_HEADER := 44
    static BINDSTATUS_SESSION_COOKIE_RECEIVED := 45
    static BINDSTATUS_PERSISTENT_COOKIE_RECEIVED := 46
    static BINDSTATUS_SESSION_COOKIES_ALLOWED := 47
    static BINDSTATUS_CACHECONTROL := 48
    static BINDSTATUS_CONTENTDISPOSITIONFILENAME := 49
    static BINDSTATUS_MIMETEXTPLAINMISMATCH := 50
    static BINDSTATUS_PUBLISHERAVAILABLE := 51
    static BINDSTATUS_DISPLAYNAMEAVAILABLE := 52
    static BINDSTATUS_SSLUX_NAVBLOCKED := 53
    static BINDSTATUS_SERVER_MIMETYPEAVAILABLE := 54
    static BINDSTATUS_SNIFFED_CLASSIDAVAILABLE := 55
    static BINDSTATUS_64BIT_PROGRESS := 56
    static BINDSTATUS_LAST := 56
    static BINDSTATUS_RESERVED_0 := 57
    static BINDSTATUS_RESERVED_1 := 58
    static BINDSTATUS_RESERVED_2 := 59
    static BINDSTATUS_RESERVED_3 := 60
    static BINDSTATUS_RESERVED_4 := 61
    static BINDSTATUS_RESERVED_5 := 62
    static BINDSTATUS_RESERVED_6 := 63
    static BINDSTATUS_RESERVED_7 := 64
    static BINDSTATUS_RESERVED_8 := 65
    static BINDSTATUS_RESERVED_9 := 66
    static BINDSTATUS_RESERVED_A := 67
    static BINDSTATUS_RESERVED_B := 68
    static BINDSTATUS_RESERVED_C := 69
    static BINDSTATUS_RESERVED_D := 70
    static BINDSTATUS_RESERVED_E := 71
    static BINDSTATUS_RESERVED_F := 72
    static BINDSTATUS_RESERVED_10 := 73
    static BINDSTATUS_RESERVED_11 := 74
    static BINDSTATUS_RESERVED_12 := 75
    static BINDSTATUS_RESERVED_13 := 76
    static BINDSTATUS_RESERVED_14 := 77
    static BINDSTATUS_LAST_PRIVATE := 77
}
struct BINDF2 extends Int32 {
    static BINDF2_DISABLEBASICOVERHTTP := 1
    static BINDF2_DISABLEAUTOCOOKIEHANDLING := 2
    static BINDF2_READ_DATA_GREATER_THAN_4GB := 4
    static BINDF2_DISABLE_HTTP_REDIRECT_XSECURITYID := 8
    static BINDF2_SETDOWNLOADMODE := 32
    static BINDF2_DISABLE_HTTP_REDIRECT_CACHING := 64
    static BINDF2_KEEP_CALLBACK_MODULE_LOADED := 128
    static BINDF2_ALLOW_PROXY_CRED_PROMPT := 256
    static BINDF2_RESERVED_17 := 512
    static BINDF2_RESERVED_16 := 1024
    static BINDF2_RESERVED_15 := 2048
    static BINDF2_RESERVED_14 := 4096
    static BINDF2_RESERVED_13 := 8192
    static BINDF2_RESERVED_12 := 16384
    static BINDF2_RESERVED_11 := 32768
    static BINDF2_RESERVED_10 := 65536
    static BINDF2_RESERVED_F := 131072
    static BINDF2_RESERVED_E := 262144
    static BINDF2_RESERVED_D := 524288
    static BINDF2_RESERVED_C := 1048576
    static BINDF2_RESERVED_B := 2097152
    static BINDF2_RESERVED_A := 4194304
    static BINDF2_RESERVED_9 := 8388608
    static BINDF2_RESERVED_8 := 16777216
    static BINDF2_RESERVED_7 := 33554432
    static BINDF2_RESERVED_6 := 67108864
    static BINDF2_RESERVED_5 := 134217728
    static BINDF2_RESERVED_4 := 268435456
    static BINDF2_RESERVED_3 := 536870912
    static BINDF2_RESERVED_2 := 1073741824
    static BINDF2_RESERVED_1 := -2147483648
}
struct AUTHENTICATEF extends Int32 {
    static AUTHENTICATEF_PROXY := 1
    static AUTHENTICATEF_BASIC := 2
    static AUTHENTICATEF_HTTP := 4
}
struct IHttpNegotiate extends IUnknown {
    static IID := "{79EAC9D2-BAF9-11CE-8C82-00AA004BA90B}"
    BeginningTransaction(szURL, szHeaders, dwReserved, pszAdditionalHeaders)
      => ComCall(3, this.p, "Str", szURL, "Str", szHeaders, UInt32, dwReserved, PWSTR.Ptr, pszAdditionalHeaders)
    OnResponse(dwResponseCode, szResponseHeaders, szRequestHeaders, pszAdditionalRequestHeaders)
      => ComCall(4, this.p, UInt32, dwResponseCode, "Str", szResponseHeaders, "Str", szRequestHeaders, PWSTR.Ptr, pszAdditionalRequestHeaders)
}
struct IHttpNegotiate2 extends IHttpNegotiate {
    static IID := "{4F9F9FCB-E0F4-48EB-B7AB-FA2EA9365CB4}"
    GetRootSecurityId(pbSecurityId, dwReserved)
      => ComCall(5, this.p, UInt8.Ptr, pbSecurityId, UInt32.Ptr, pbSecurityId.Length, IntPtr, dwReserved)
}
struct IHttpNegotiate3 extends IHttpNegotiate2 {
    static IID := "{57B6C80A-34C2-4602-BC26-66A02FC57153}"
    GetSerializedClientCertContext(ppbCert)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, ppbCert, UInt32.Ptr, ppbCert.Length)
}
struct IWinInetFileStream extends IUnknown {
    static IID := "{F134C4B7-B1F8-4E75-B886-74B90943BECB}"
    SetHandleForUnlock(hWinInetLockHandle, dwReserved)
      => ComCall(3, this.p, IntPtr, hWinInetLockHandle, IntPtr, dwReserved)
    SetDeleteFile(dwReserved)
      => ComCall(4, this.p, IntPtr, dwReserved)
}
struct IWindowForBindingUI extends IUnknown {
    static IID := "{79EAC9D5-BAFA-11CE-8C82-00AA004BA90B}"
    GetWindow(rguidReason, phwnd)
      => ComCall(3, this.p, GUID.Ptr, rguidReason, HWND.Ptr, phwnd)
}
struct CIP_STATUS extends Int32 {
    static CIP_DISK_FULL := 0
    static CIP_ACCESS_DENIED := 1
    static CIP_NEWER_VERSION_EXISTS := 2
    static CIP_OLDER_VERSION_EXISTS := 3
    static CIP_NAME_CONFLICT := 4
    static CIP_TRUST_VERIFICATION_COMPONENT_MISSING := 5
    static CIP_EXE_SELF_REGISTERATION_TIMEOUT := 6
    static CIP_UNSAFE_TO_ABORT := 7
    static CIP_NEED_REBOOT := 8
    static CIP_NEED_REBOOT_UI_PERMISSION := 9
}
struct ICodeInstall extends IWindowForBindingUI {
    static IID := "{79EAC9D1-BAF9-11CE-8C82-00AA004BA90B}"
    OnCodeInstallProblem(ulStatusCode, szDestination, szSource, dwReserved)
      => ComCall(4, this.p, UInt32, ulStatusCode, "Str", szDestination, "Str", szSource, UInt32, dwReserved)
}
struct Uri_HOST_TYPE extends Int32 {
    static Uri_HOST_UNKNOWN := 0
    static Uri_HOST_DNS := 1
    static Uri_HOST_IPV4 := 2
    static Uri_HOST_IPV6 := 3
    static Uri_HOST_IDN := 4
}
struct IUriContainer extends IUnknown {
    static IID := "{A158A630-ED6F-45FB-B987-F68676F57752}"
    GetIUri(ppIUri)
      => ComCall(3, this.p, IUri.Ptr, ppIUri)
}
struct IUriBuilderFactory extends IUnknown {
    static IID := "{E982CE48-0B96-440C-BC37-0C869B27A29E}"
    CreateIUriBuilder(dwFlags, dwReserved, ppIUriBuilder)
      => ComCall(3, this.p, UInt32, dwFlags, IntPtr, dwReserved, IUriBuilder.Ptr, ppIUriBuilder)
    CreateInitializedIUriBuilder(dwFlags, dwReserved, ppIUriBuilder)
      => ComCall(4, this.p, UInt32, dwFlags, IntPtr, dwReserved, IUriBuilder.Ptr, ppIUriBuilder)
}
struct IWinInetInfo extends IUnknown {
    static IID := "{79EAC9D6-BAFA-11CE-8C82-00AA004BA90B}"
    QueryOption(dwOption, pBuffer)
      => ComCall(3, this.p, UInt32, dwOption, Struct.Ptr, pBuffer, UInt32.Ptr, pBuffer.Length)
}
struct IHttpSecurity extends IWindowForBindingUI {
    static IID := "{79EAC9D7-BAFA-11CE-8C82-00AA004BA90B}"
    OnSecurityProblem(dwProblem)
      => ComCall(4, this.p, UInt32, dwProblem)
}
struct IWinInetHttpInfo extends IWinInetInfo {
    static IID := "{79EAC9D8-BAFA-11CE-8C82-00AA004BA90B}"
    QueryInfo(dwOption, pBuffer, pdwFlags, pdwReserved)
      => ComCall(4, this.p, UInt32, dwOption, Struct.Ptr, pBuffer, UInt32.Ptr, pBuffer.Length, UInt32.Ptr, pdwFlags, UInt32.Ptr, pdwReserved)
}
struct IWinInetHttpTimeouts extends IUnknown {
    static IID := "{F286FA56-C1FD-4270-8E67-B3EB790A81E8}"
    GetRequestTimeouts(pdwConnectTimeout, pdwSendTimeout, pdwReceiveTimeout)
      => ComCall(3, this.p, UInt32.Ptr, pdwConnectTimeout, UInt32.Ptr, pdwSendTimeout, UInt32.Ptr, pdwReceiveTimeout)
}
struct IWinInetCacheHints extends IUnknown {
    static IID := "{DD1EC3B3-8391-4FDB-A9E6-347C3CAAA7DD}"
    SetCacheExtension(pwzExt, pszCacheFile, pdwWinInetError, pdwReserved)
      => ComCall(3, this.p, "Str", pwzExt, Struct.Ptr, pszCacheFile, UInt32.Ptr, pszCacheFile.Length, UInt32.Ptr, pdwWinInetError, UInt32.Ptr, pdwReserved)
}
struct IWinInetCacheHints2 extends IWinInetCacheHints {
    static IID := "{7857AEAC-D31F-49BF-884E-DD46DF36780A}"
    SetCacheExtension2(pwzExt, pwzCacheFile, pdwWinInetError, pdwReserved)
      => ComCall(4, this.p, "Str", pwzExt, PWSTR, pwzCacheFile, UInt32.Ptr, pwzCacheFile.Length, UInt32.Ptr, pdwWinInetError, UInt32.Ptr, pdwReserved)
}
struct IInternet extends IUnknown {
    static IID := "{79EAC9E0-BAF9-11CE-8C82-00AA004BA90B}"
}
struct BINDSTRING extends Int32 {
    static BINDSTRING_HEADERS := 1
    static BINDSTRING_ACCEPT_MIMES := 2
    static BINDSTRING_EXTRA_URL := 3
    static BINDSTRING_LANGUAGE := 4
    static BINDSTRING_USERNAME := 5
    static BINDSTRING_PASSWORD := 6
    static BINDSTRING_UA_PIXELS := 7
    static BINDSTRING_UA_COLOR := 8
    static BINDSTRING_OS := 9
    static BINDSTRING_USER_AGENT := 10
    static BINDSTRING_ACCEPT_ENCODINGS := 11
    static BINDSTRING_POST_COOKIE := 12
    static BINDSTRING_POST_DATA_MIME := 13
    static BINDSTRING_URL := 14
    static BINDSTRING_IID := 15
    static BINDSTRING_FLAG_BIND_TO_OBJECT := 16
    static BINDSTRING_PTR_BIND_CONTEXT := 17
    static BINDSTRING_XDR_ORIGIN := 18
    static BINDSTRING_DOWNLOADPATH := 19
    static BINDSTRING_ROOTDOC_URL := 20
    static BINDSTRING_INITIAL_FILENAME := 21
    static BINDSTRING_PROXY_USERNAME := 22
    static BINDSTRING_PROXY_PASSWORD := 23
    static BINDSTRING_ENTERPRISE_ID := 24
    static BINDSTRING_DOC_URL := 25
    static BINDSTRING_SAMESITE_COOKIE_LEVEL := 26
}
struct IInternetBindInfo extends IUnknown {
    static IID := "{79EAC9E1-BAF9-11CE-8C82-00AA004BA90B}"
    GetBindInfo(grfBINDF, pbindinfo)
      => ComCall(3, this.p, UInt32.Ptr, grfBINDF, BINDINFO.Ptr, pbindinfo)
    GetBindString(ulStringType, ppwzStr, cEl, pcElFetched)
      => ComCall(4, this.p, UInt32, ulStringType, PWSTR.Ptr, ppwzStr, UInt32, cEl, UInt32.Ptr, pcElFetched)
}
struct IInternetBindInfoEx extends IInternetBindInfo {
    static IID := "{A3E015B7-A82C-4DCD-A150-569AEEED36AB}"
    GetBindInfoEx(grfBINDF, pbindinfo, grfBINDF2, pdwReserved)
      => ComCall(5, this.p, UInt32.Ptr, grfBINDF, BINDINFO.Ptr, pbindinfo, UInt32.Ptr, grfBINDF2, UInt32.Ptr, pdwReserved)
}
struct PI_FLAGS extends Int32 {
    static PI_PARSE_URL := 1
    static PI_FILTER_MODE := 2
    static PI_FORCE_ASYNC := 4
    static PI_USE_WORKERTHREAD := 8
    static PI_MIMEVERIFICATION := 16
    static PI_CLSIDLOOKUP := 32
    static PI_DATAPROGRESS := 64
    static PI_SYNCHRONOUS := 128
    static PI_APARTMENTTHREADED := 256
    static PI_CLASSINSTALL := 512
    static PI_PASSONBINDCTX := 8192
    static PI_NOMIMEHANDLER := 32768
    static PI_LOADAPPDIRECT := 16384
    static PD_FORCE_SWITCH := 65536
    static PI_PREFERDEFAULTHANDLER := 131072
}
struct PROTOCOLDATA {
    grfFlags : UInt32
    dwState : UInt32
    pData : Struct.Ptr
    cbData : UInt32
}
struct StartParam {
    iid : GUID
    pIBindCtx : IBindCtx
    pItf : IUnknown
}
struct IInternetProtocolRoot extends IUnknown {
    static IID := "{79EAC9E3-BAF9-11CE-8C82-00AA004BA90B}"
    Start(szUrl, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
      => ComCall(3, this.p, "Str", szUrl, IInternetProtocolSink, pOIProtSink, IInternetBindInfo, pOIBindInfo, UInt32, grfPI, HANDLE_PTR, dwReserved)
    Continue(pProtocolData)
      => ComCall(4, this.p, PROTOCOLDATA.Ptr, pProtocolData)
    Abort(hrReason, dwOptions)
      => ComCall(5, this.p, HRESULT, hrReason, UInt32, dwOptions)
    Terminate(dwOptions)
      => ComCall(6, this.p, UInt32, dwOptions)
    Suspend()
      => ComCall(7, this.p)
    Resume()
      => ComCall(8, this.p)
}
struct IInternetProtocol extends IInternetProtocolRoot {
    static IID := "{79EAC9E4-BAF9-11CE-8C82-00AA004BA90B}"
    Read(pv, pcbRead)
      => ComCall(9, this.p, Struct.Ptr, pv, UInt32, pv.Length, UInt32.Ptr, pcbRead)
    Seek(dlibMove, dwOrigin, plibNewPosition)
      => ComCall(10, this.p, Int64, dlibMove, UInt32, dwOrigin, Int64.Ptr, plibNewPosition)
    LockRequest(dwOptions)
      => ComCall(11, this.p, UInt32, dwOptions)
    UnlockRequest()
      => ComCall(12, this.p)
}
struct IInternetProtocolEx extends IInternetProtocol {
    static IID := "{C7A98E66-1010-492C-A1C8-C809E1F75905}"
    StartEx(pUri, pOIProtSink, pOIBindInfo, grfPI, dwReserved)
      => ComCall(13, this.p, IUri, pUri, IInternetProtocolSink, pOIProtSink, IInternetBindInfo, pOIBindInfo, UInt32, grfPI, HANDLE_PTR, dwReserved)
}
struct IInternetProtocolSink extends IUnknown {
    static IID := "{79EAC9E5-BAF9-11CE-8C82-00AA004BA90B}"
    Switch(pProtocolData)
      => ComCall(3, this.p, PROTOCOLDATA.Ptr, pProtocolData)
    ReportProgress(ulStatusCode, szStatusText)
      => ComCall(4, this.p, UInt32, ulStatusCode, "Str", szStatusText)
    ReportData(grfBSCF, ulProgress, ulProgressMax)
      => ComCall(5, this.p, UInt32, grfBSCF, UInt32, ulProgress, UInt32, ulProgressMax)
    ReportResult(hrResult, dwError, szResult)
      => ComCall(6, this.p, HRESULT, hrResult, UInt32, dwError, "Str", szResult)
}
struct IInternetProtocolSinkStackable extends IUnknown {
    static IID := "{79EAC9F0-BAF9-11CE-8C82-00AA004BA90B}"
    SwitchSink(pOIProtSink)
      => ComCall(3, this.p, IInternetProtocolSink, pOIProtSink)
    CommitSwitch()
      => ComCall(4, this.p)
    RollbackSwitch()
      => ComCall(5, this.p)
}
struct OIBDG_FLAGS extends Int32 {
    static OIBDG_APARTMENTTHREADED := 256
    static OIBDG_DATAONLY := 4096
}
struct IInternetSession extends IUnknown {
    static IID := "{79EAC9E7-BAF9-11CE-8C82-00AA004BA90B}"
    RegisterNameSpace(pCF, rclsid, pwzProtocol, cPatterns, ppwzPatterns, dwReserved)
      => ComCall(3, this.p, IClassFactory, pCF, GUID.Ptr, rclsid, "Str", pwzProtocol, UInt32, cPatterns, PWSTR.Ptr, ppwzPatterns, UInt32, dwReserved)
    UnregisterNameSpace(pCF, pszProtocol)
      => ComCall(4, this.p, IClassFactory, pCF, "Str", pszProtocol)
    RegisterMimeFilter(pCF, rclsid, pwzType)
      => ComCall(5, this.p, IClassFactory, pCF, GUID.Ptr, rclsid, "Str", pwzType)
    UnregisterMimeFilter(pCF, pwzType)
      => ComCall(6, this.p, IClassFactory, pCF, "Str", pwzType)
    CreateBinding(pBC, szUrl, pUnkOuter, ppUnk, ppOInetProt, dwOption)
      => ComCall(7, this.p, IBindCtx, pBC, "Str", szUrl, IUnknown, pUnkOuter, IUnknown.Ptr, ppUnk, IInternetProtocol.Ptr, ppOInetProt, UInt32, dwOption)
    SetSessionOption(dwOption, pBuffer, dwBufferLength, dwReserved)
      => ComCall(8, this.p, UInt32, dwOption, Struct.Ptr, pBuffer, UInt32, dwBufferLength, UInt32, dwReserved)
    GetSessionOption(dwOption, pBuffer, pdwBufferLength, dwReserved)
      => ComCall(9, this.p, UInt32, dwOption, Struct.Ptr, pBuffer, UInt32.Ptr, pdwBufferLength, UInt32, dwReserved)
}
struct IInternetThreadSwitch extends IUnknown {
    static IID := "{79EAC9E8-BAF9-11CE-8C82-00AA004BA90B}"
    Prepare()
      => ComCall(3, this.p)
    Continue()
      => ComCall(4, this.p)
}
struct IInternetPriority extends IUnknown {
    static IID := "{79EAC9EB-BAF9-11CE-8C82-00AA004BA90B}"
    SetPriority(nPriority)
      => ComCall(3, this.p, Int32, nPriority)
    GetPriority(pnPriority)
      => ComCall(4, this.p, Int32.Ptr, pnPriority)
}
struct PARSEACTION extends Int32 {
    static PARSE_CANONICALIZE := 1
    static PARSE_FRIENDLY := 2
    static PARSE_SECURITY_URL := 3
    static PARSE_ROOTDOCUMENT := 4
    static PARSE_DOCUMENT := 5
    static PARSE_ANCHOR := 6
    static PARSE_ENCODE_IS_UNESCAPE := 7
    static PARSE_DECODE_IS_ESCAPE := 8
    static PARSE_PATH_FROM_URL := 9
    static PARSE_URL_FROM_PATH := 10
    static PARSE_MIME := 11
    static PARSE_SERVER := 12
    static PARSE_SCHEMA := 13
    static PARSE_SITE := 14
    static PARSE_DOMAIN := 15
    static PARSE_LOCATION := 16
    static PARSE_SECURITY_DOMAIN := 17
    static PARSE_ESCAPE := 18
    static PARSE_UNESCAPE := 19
}
struct PSUACTION extends Int32 {
    static PSU_DEFAULT := 1
    static PSU_SECURITY_URL_ONLY := 2
}
struct QUERYOPTION extends Int32 {
    static QUERY_EXPIRATION_DATE := 1
    static QUERY_TIME_OF_LAST_CHANGE := 2
    static QUERY_CONTENT_ENCODING := 3
    static QUERY_CONTENT_TYPE := 4
    static QUERY_REFRESH := 5
    static QUERY_RECOMBINE := 6
    static QUERY_CAN_NAVIGATE := 7
    static QUERY_USES_NETWORK := 8
    static QUERY_IS_CACHED := 9
    static QUERY_IS_INSTALLEDENTRY := 10
    static QUERY_IS_CACHED_OR_MAPPED := 11
    static QUERY_USES_CACHE := 12
    static QUERY_IS_SECURE := 13
    static QUERY_IS_SAFE := 14
    static QUERY_USES_HISTORYFOLDER := 15
    static QUERY_IS_CACHED_AND_USABLE_OFFLINE := 16
}
struct IInternetProtocolInfo extends IUnknown {
    static IID := "{79EAC9EC-BAF9-11CE-8C82-00AA004BA90B}"
    ParseUrl(pwzUrl, ParseAction1, dwParseFlags, pwzResult, cchResult, pcchResult, dwReserved)
      => ComCall(3, this.p, "Str", pwzUrl, PARSEACTION, ParseAction1, UInt32, dwParseFlags, PWSTR, pwzResult, UInt32, cchResult, UInt32.Ptr, pcchResult, UInt32, dwReserved)
    CombineUrl(pwzBaseUrl, pwzRelativeUrl, dwCombineFlags, pwzResult, cchResult, pcchResult, dwReserved)
      => ComCall(4, this.p, "Str", pwzBaseUrl, "Str", pwzRelativeUrl, UInt32, dwCombineFlags, "Str", pwzResult, UInt32, cchResult, UInt32.Ptr, pcchResult, UInt32, dwReserved)
    CompareUrl(pwzUrl1, pwzUrl2, dwCompareFlags)
      => ComCall(5, this.p, "Str", pwzUrl1, "Str", pwzUrl2, UInt32, dwCompareFlags)
    QueryInfo(pwzUrl, OueryOption, dwQueryFlags, pBuffer, cbBuffer, dwReserved)
      => ComCall(6, this.p, "Str", pwzUrl, QUERYOPTION, OueryOption, UInt32, dwQueryFlags, Struct.Ptr, pBuffer, UInt32, cbBuffer, UInt32.Ptr, pBuffer.Length, UInt32, dwReserved)
}
struct INTERNETFEATURELIST extends Int32 {
    static FEATURE_OBJECT_CACHING := 0
    static FEATURE_ZONE_ELEVATION := 1
    static FEATURE_MIME_HANDLING := 2
    static FEATURE_MIME_SNIFFING := 3
    static FEATURE_WINDOW_RESTRICTIONS := 4
    static FEATURE_WEBOC_POPUPMANAGEMENT := 5
    static FEATURE_BEHAVIORS := 6
    static FEATURE_DISABLE_MK_PROTOCOL := 7
    static FEATURE_LOCALMACHINE_LOCKDOWN := 8
    static FEATURE_SECURITYBAND := 9
    static FEATURE_RESTRICT_ACTIVEXINSTALL := 10
    static FEATURE_VALIDATE_NAVIGATE_URL := 11
    static FEATURE_RESTRICT_FILEDOWNLOAD := 12
    static FEATURE_ADDON_MANAGEMENT := 13
    static FEATURE_PROTOCOL_LOCKDOWN := 14
    static FEATURE_HTTP_USERNAME_PASSWORD_DISABLE := 15
    static FEATURE_SAFE_BINDTOOBJECT := 16
    static FEATURE_UNC_SAVEDFILECHECK := 17
    static FEATURE_GET_URL_DOM_FILEPATH_UNENCODED := 18
    static FEATURE_TABBED_BROWSING := 19
    static FEATURE_SSLUX := 20
    static FEATURE_DISABLE_NAVIGATION_SOUNDS := 21
    static FEATURE_DISABLE_LEGACY_COMPRESSION := 22
    static FEATURE_FORCE_ADDR_AND_STATUS := 23
    static FEATURE_XMLHTTP := 24
    static FEATURE_DISABLE_TELNET_PROTOCOL := 25
    static FEATURE_FEEDS := 26
    static FEATURE_BLOCK_INPUT_PROMPTS := 27
    static FEATURE_ENTRY_COUNT := 28
}
struct IInternetSecurityMgrSite extends IUnknown {
    static IID := "{79EAC9ED-BAF9-11CE-8C82-00AA004BA90B}"
    GetWindow(phwnd)
      => ComCall(3, this.p, HWND.Ptr, phwnd)
    EnableModeless(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
}
struct PUAF extends Int32 {
    static PUAF_DEFAULT := 0
    static PUAF_NOUI := 1
    static PUAF_ISFILE := 2
    static PUAF_WARN_IF_DENIED := 4
    static PUAF_FORCEUI_FOREGROUND := 8
    static PUAF_CHECK_TIFS := 16
    static PUAF_DONTCHECKBOXINDIALOG := 32
    static PUAF_TRUSTED := 64
    static PUAF_ACCEPT_WILDCARD_SCHEME := 128
    static PUAF_ENFORCERESTRICTED := 256
    static PUAF_NOSAVEDFILECHECK := 512
    static PUAF_REQUIRESAVEDFILECHECK := 1024
    static PUAF_DONT_USE_CACHE := 4096
    static PUAF_RESERVED1 := 8192
    static PUAF_RESERVED2 := 16384
    static PUAF_LMZ_UNLOCKED := 65536
    static PUAF_LMZ_LOCKED := 131072
    static PUAF_DEFAULTZONEPOL := 262144
    static PUAF_NPL_USE_LOCKED_IF_RESTRICTED := 524288
    static PUAF_NOUIIFLOCKED := 1048576
    static PUAF_DRAGPROTOCOLCHECK := 2097152
}
struct PUAFOUT extends Int32 {
    static PUAFOUT_DEFAULT := 0
    static PUAFOUT_ISLOCKZONEPOLICY := 1
}
struct SZM_FLAGS extends Int32 {
    static SZM_CREATE := 0
    static SZM_DELETE := 1
}
struct IInternetSecurityManager extends IUnknown {
    static IID := "{79EAC9EE-BAF9-11CE-8C82-00AA004BA90B}"
    SetSecuritySite(pSite)
      => ComCall(3, this.p, IInternetSecurityMgrSite, pSite)
    GetSecuritySite(ppSite)
      => ComCall(4, this.p, IInternetSecurityMgrSite.Ptr, ppSite)
    MapUrlToZone(pwszUrl, pdwZone, dwFlags)
      => ComCall(5, this.p, "Str", pwszUrl, UInt32.Ptr, pdwZone, UInt32, dwFlags)
    GetSecurityId(pwszUrl, pbSecurityId, pcbSecurityId, dwReserved)
      => ComCall(6, this.p, "Str", pwszUrl, UInt8.Ptr, pbSecurityId, UInt32.Ptr, pcbSecurityId, IntPtr, dwReserved)
    ProcessUrlAction(pwszUrl, dwAction, pPolicy, pContext, cbContext, dwFlags, dwReserved)
      => ComCall(7, this.p, "Str", pwszUrl, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, UInt8.Ptr, pContext, UInt32, cbContext, UInt32, dwFlags, UInt32, dwReserved)
    QueryCustomPolicy(pwszUrl, guidKey, ppPolicy, pContext, cbContext, dwReserved)
      => ComCall(8, this.p, "Str", pwszUrl, GUID.Ptr, guidKey, UInt8.Ptr.Ptr, ppPolicy, UInt32.Ptr, ppPolicy.Length, UInt8.Ptr, pContext, UInt32, cbContext, UInt32, dwReserved)
    SetZoneMapping(dwZone, lpszPattern, dwFlags)
      => ComCall(9, this.p, UInt32, dwZone, "Str", lpszPattern, UInt32, dwFlags)
    GetZoneMappings(dwZone, ppenumString, dwFlags)
      => ComCall(10, this.p, UInt32, dwZone, IEnumString.Ptr, ppenumString, UInt32, dwFlags)
}
struct IInternetSecurityManagerEx extends IInternetSecurityManager {
    static IID := "{F164EDF1-CC7C-4F0D-9A94-34222625C393}"
    ProcessUrlActionEx(pwszUrl, dwAction, pPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
      => ComCall(11, this.p, "Str", pwszUrl, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, UInt8.Ptr, pContext, UInt32, cbContext, UInt32, dwFlags, UInt32, dwReserved, UInt32.Ptr, pdwOutFlags)
}
struct IInternetSecurityManagerEx2 extends IInternetSecurityManagerEx {
    static IID := "{F1E50292-A795-4117-8E09-2B560A72AC60}"
    MapUrlToZoneEx2(pUri, pdwZone, dwFlags, ppwszMappedUrl?, pdwOutFlags?)
      => ComCall(12, this.p, IUri, pUri, UInt32.Ptr, pdwZone, UInt32, dwFlags, PWSTR.Ptr, ppwszMappedUrl?, UInt32.Ptr, pdwOutFlags?)
    ProcessUrlActionEx2(pUri, dwAction, pPolicy, pContext, cbContext, dwFlags, dwReserved, pdwOutFlags)
      => ComCall(13, this.p, IUri, pUri, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, UInt8.Ptr, pContext, UInt32, cbContext, UInt32, dwFlags, IntPtr, dwReserved, UInt32.Ptr, pdwOutFlags)
    GetSecurityIdEx2(pUri, pbSecurityId, pcbSecurityId, dwReserved)
      => ComCall(14, this.p, IUri, pUri, UInt8.Ptr, pbSecurityId, UInt32.Ptr, pcbSecurityId, IntPtr, dwReserved)
    QueryCustomPolicyEx2(pUri, guidKey, ppPolicy, pContext, cbContext, dwReserved)
      => ComCall(15, this.p, IUri, pUri, GUID.Ptr, guidKey, UInt8.Ptr.Ptr, ppPolicy, UInt32.Ptr, ppPolicy.Length, UInt8.Ptr, pContext, UInt32, cbContext, IntPtr, dwReserved)
}
struct IZoneIdentifier extends IUnknown {
    static IID := "{CD45F185-1B21-48E2-967B-EAD743A8914E}"
    GetId(pdwZone)
      => ComCall(3, this.p, UInt32.Ptr, pdwZone)
    SetId(dwZone)
      => ComCall(4, this.p, UInt32, dwZone)
    Remove()
      => ComCall(5, this.p)
}
struct IZoneIdentifier2 extends IZoneIdentifier {
    static IID := "{EB5E760C-09EF-45C0-B510-70830CE31E6A}"
    GetLastWriterPackageFamilyName(packageFamilyName)
      => ComCall(6, this.p, PWSTR.Ptr, packageFamilyName)
    SetLastWriterPackageFamilyName(packageFamilyName)
      => ComCall(7, this.p, "Str", packageFamilyName)
    RemoveLastWriterPackageFamilyName()
      => ComCall(8, this.p)
    GetAppZoneId(zone)
      => ComCall(9, this.p, UInt32.Ptr, zone)
    SetAppZoneId(zone)
      => ComCall(10, this.p, UInt32, zone)
    RemoveAppZoneId()
      => ComCall(11, this.p)
}
struct IInternetHostSecurityManager extends IUnknown {
    static IID := "{3AF280B6-CB3F-11D0-891E-00C04FB6BFC4}"
    GetSecurityId(pbSecurityId, dwReserved)
      => ComCall(3, this.p, UInt8.Ptr, pbSecurityId, UInt32.Ptr, pbSecurityId.Length, IntPtr, dwReserved)
    ProcessUrlAction(dwAction, pPolicy, pContext?, dwFlags, dwReserved)
      => ComCall(4, this.p, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, UInt8.Ptr, pContext?, UInt32, pContext?.Length ?? 0, UInt32, dwFlags, UInt32, dwReserved)
    QueryCustomPolicy(guidKey, ppPolicy, pcbPolicy, pContext, dwReserved)
      => ComCall(5, this.p, GUID.Ptr, guidKey, UInt8.Ptr.Ptr, ppPolicy, UInt32.Ptr, pcbPolicy, UInt8.Ptr, pContext, UInt32, pContext.Length, UInt32, dwReserved)
}
struct URLZONE extends Int32 {
    static URLZONE_INVALID := -1
    static URLZONE_PREDEFINED_MIN := 0
    static URLZONE_LOCAL_MACHINE := 0
    static URLZONE_INTRANET := 1
    static URLZONE_TRUSTED := 2
    static URLZONE_INTERNET := 3
    static URLZONE_UNTRUSTED := 4
    static URLZONE_PREDEFINED_MAX := 999
    static URLZONE_USER_MIN := 1000
    static URLZONE_USER_MAX := 10000
}
struct URLTEMPLATE extends Int32 {
    static URLTEMPLATE_CUSTOM := 0
    static URLTEMPLATE_PREDEFINED_MIN := 65536
    static URLTEMPLATE_LOW := 65536
    static URLTEMPLATE_MEDLOW := 66816
    static URLTEMPLATE_MEDIUM := 69632
    static URLTEMPLATE_MEDHIGH := 70912
    static URLTEMPLATE_HIGH := 73728
    static URLTEMPLATE_PREDEFINED_MAX := 131072
}
struct INET_ZONE_MANAGER_CONSTANTS extends Int32 {
    static MAX_ZONE_PATH := 260
    static MAX_ZONE_DESCRIPTION := 200
}
struct ZAFLAGS extends Int32 {
    static ZAFLAGS_CUSTOM_EDIT := 1
    static ZAFLAGS_ADD_SITES := 2
    static ZAFLAGS_REQUIRE_VERIFICATION := 4
    static ZAFLAGS_INCLUDE_PROXY_OVERRIDE := 8
    static ZAFLAGS_INCLUDE_INTRANET_SITES := 16
    static ZAFLAGS_NO_UI := 32
    static ZAFLAGS_SUPPORTS_VERIFICATION := 64
    static ZAFLAGS_UNC_AS_INTRANET := 128
    static ZAFLAGS_DETECT_INTRANET := 256
    static ZAFLAGS_USE_LOCKED_ZONES := 65536
    static ZAFLAGS_VERIFY_TEMPLATE_SETTINGS := 131072
    static ZAFLAGS_NO_CACHE := 262144
}
struct ZONEATTRIBUTES {
    cbSize : UInt32 := this.Size
    szDisplayName : UInt16[260]
    szDescription : UInt16[200]
    szIconPath : UInt16[260]
    dwTemplateMinLevel : UInt32
    dwTemplateRecommended : UInt32
    dwTemplateCurrentLevel : UInt32
    dwFlags : UInt32
}
struct URLZONEREG extends Int32 {
    static URLZONEREG_DEFAULT := 0
    static URLZONEREG_HKLM := 1
    static URLZONEREG_HKCU := 2
}
struct IInternetZoneManager extends IUnknown {
    static IID := "{79EAC9EF-BAF9-11CE-8C82-00AA004BA90B}"
    GetZoneAttributes(dwZone, pZoneAttributes)
      => ComCall(3, this.p, UInt32, dwZone, ZONEATTRIBUTES.Ptr, pZoneAttributes)
    SetZoneAttributes(dwZone, pZoneAttributes)
      => ComCall(4, this.p, UInt32, dwZone, ZONEATTRIBUTES.Ptr, pZoneAttributes)
    GetZoneCustomPolicy(dwZone, guidKey, ppPolicy, pcbPolicy, urlZoneReg1)
      => ComCall(5, this.p, UInt32, dwZone, GUID.Ptr, guidKey, UInt8.Ptr.Ptr, ppPolicy, UInt32.Ptr, pcbPolicy, URLZONEREG, urlZoneReg1)
    SetZoneCustomPolicy(dwZone, guidKey, pPolicy, urlZoneReg1)
      => ComCall(6, this.p, UInt32, dwZone, GUID.Ptr, guidKey, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, URLZONEREG, urlZoneReg1)
    GetZoneActionPolicy(dwZone, dwAction, pPolicy, urlZoneReg1)
      => ComCall(7, this.p, UInt32, dwZone, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, URLZONEREG, urlZoneReg1)
    SetZoneActionPolicy(dwZone, dwAction, pPolicy, urlZoneReg1)
      => ComCall(8, this.p, UInt32, dwZone, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, URLZONEREG, urlZoneReg1)
    PromptAction(dwAction, hwndParent, pwszUrl, pwszText, dwPromptFlags)
      => ComCall(9, this.p, UInt32, dwAction, HWND, hwndParent, "Str", pwszUrl, "Str", pwszText, UInt32, dwPromptFlags)
    LogAction(dwAction, pwszUrl, pwszText, dwLogFlags)
      => ComCall(10, this.p, UInt32, dwAction, "Str", pwszUrl, "Str", pwszText, UInt32, dwLogFlags)
    CreateZoneEnumerator(pdwEnum, pdwCount, dwFlags)
      => ComCall(11, this.p, UInt32.Ptr, pdwEnum, UInt32.Ptr, pdwCount, UInt32, dwFlags)
    GetZoneAt(dwEnum, dwIndex, pdwZone)
      => ComCall(12, this.p, UInt32, dwEnum, UInt32, dwIndex, UInt32.Ptr, pdwZone)
    DestroyZoneEnumerator(dwEnum)
      => ComCall(13, this.p, UInt32, dwEnum)
    CopyTemplatePoliciesToZone(dwTemplate, dwZone, dwReserved)
      => ComCall(14, this.p, UInt32, dwTemplate, UInt32, dwZone, UInt32, dwReserved)
}
struct IInternetZoneManagerEx extends IInternetZoneManager {
    static IID := "{A4C23339-8E06-431E-9BF4-7E711C085648}"
    GetZoneActionPolicyEx(dwZone, dwAction, pPolicy, urlZoneReg1, dwFlags)
      => ComCall(15, this.p, UInt32, dwZone, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, URLZONEREG, urlZoneReg1, UInt32, dwFlags)
    SetZoneActionPolicyEx(dwZone, dwAction, pPolicy, urlZoneReg1, dwFlags)
      => ComCall(16, this.p, UInt32, dwZone, UInt32, dwAction, UInt8.Ptr, pPolicy, UInt32, pPolicy.Length, URLZONEREG, urlZoneReg1, UInt32, dwFlags)
}
struct IInternetZoneManagerEx2 extends IInternetZoneManagerEx {
    static IID := "{EDC17559-DD5D-4846-8EEF-8BECBA5A4ABF}"
    GetZoneAttributesEx(dwZone, pZoneAttributes, dwFlags)
      => ComCall(17, this.p, UInt32, dwZone, ZONEATTRIBUTES.Ptr, pZoneAttributes, UInt32, dwFlags)
    GetZoneSecurityState(dwZoneIndex, fRespectPolicy, pdwState, pfPolicyEncountered)
      => ComCall(18, this.p, UInt32, dwZoneIndex, BOOL, fRespectPolicy, UInt32.Ptr, pdwState, BOOL.Ptr, pfPolicyEncountered)
    GetIESecurityState(fRespectPolicy, pdwState, pfPolicyEncountered, fNoCache)
      => ComCall(19, this.p, BOOL, fRespectPolicy, UInt32.Ptr, pdwState, BOOL.Ptr, pfPolicyEncountered, BOOL, fNoCache)
    FixUnsecureSettings()
      => ComCall(20, this.p)
}
struct CODEBASEHOLD {
    cbSize : UInt32 := this.Size
    szDistUnit : PWSTR
    szCodeBase : PWSTR
    dwVersionMS : UInt32
    dwVersionLS : UInt32
    dwStyle : UInt32
}
struct SOFTDISTINFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwAdState : UInt32
    szTitle : PWSTR
    szAbstract : PWSTR
    szHREF : PWSTR
    dwInstalledVersionMS : UInt32
    dwInstalledVersionLS : UInt32
    dwUpdateVersionMS : UInt32
    dwUpdateVersionLS : UInt32
    dwAdvertisedVersionMS : UInt32
    dwAdvertisedVersionLS : UInt32
    dwReserved : UInt32
}
struct ISoftDistExt extends IUnknown {
    static IID := "{B15B8DC1-C7E1-11D0-8680-00AA00BDCB71}"
    ProcessSoftDist(szCDFURL, pSoftDistElement, lpsdi)
      => ComCall(3, this.p, "Str", szCDFURL, IXMLElement, pSoftDistElement, SOFTDISTINFO.Ptr, lpsdi)
    GetFirstCodeBase(szCodeBase, dwMaxSize)
      => ComCall(4, this.p, PWSTR.Ptr, szCodeBase, UInt32.Ptr, dwMaxSize)
    GetNextCodeBase(szCodeBase, dwMaxSize)
      => ComCall(5, this.p, PWSTR.Ptr, szCodeBase, UInt32.Ptr, dwMaxSize)
    AsyncInstallDistributionUnit(pbc, pvReserved, flags, lpcbh)
      => ComCall(6, this.p, IBindCtx, pbc, Struct.Ptr, pvReserved, UInt32, flags, CODEBASEHOLD.Ptr, lpcbh)
}
struct ICatalogFileInfo extends IUnknown {
    static IID := "{711C7600-6B48-11D1-B403-00AA00B92AF1}"
    GetCatalogFile(ppszCatalogFile)
      => ComCall(3, this.p, PSTR.Ptr, ppszCatalogFile)
    GetJavaTrust(ppJavaTrust)
      => ComCall(4, this.p, Struct.Ptr.Ptr, ppJavaTrust)
}
struct IDataFilter extends IUnknown {
    static IID := "{69D14C80-C18E-11D0-A9CE-006097942311}"
    DoEncode(dwFlags, pbInBuffer, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
      => ComCall(3, this.p, UInt32, dwFlags, Int32, pbInBuffer.Length, UInt8.Ptr, pbInBuffer, Int32, pbOutBuffer.Length, UInt8.Ptr, pbOutBuffer, Int32, lInBytesAvailable, Int32.Ptr, plInBytesRead, Int32.Ptr, plOutBytesWritten, UInt32, dwReserved)
    DoDecode(dwFlags, pbInBuffer, pbOutBuffer, lInBytesAvailable, plInBytesRead, plOutBytesWritten, dwReserved)
      => ComCall(4, this.p, UInt32, dwFlags, Int32, pbInBuffer.Length, UInt8.Ptr, pbInBuffer, Int32, pbOutBuffer.Length, UInt8.Ptr, pbOutBuffer, Int32, lInBytesAvailable, Int32.Ptr, plInBytesRead, Int32.Ptr, plOutBytesWritten, UInt32, dwReserved)
    SetEncodingLevel(dwEncLevel)
      => ComCall(5, this.p, UInt32, dwEncLevel)
}
struct PROTOCOLFILTERDATA {
    cbSize : UInt32 := this.Size
    pProtocolSink : IInternetProtocolSink
    pProtocol : IInternetProtocol
    pUnk : IUnknown
    dwFilterFlags : UInt32
}
struct DATAINFO {
    ulTotalSize : UInt32
    ulavrPacketSize : UInt32
    ulConnectSpeed : UInt32
    ulProcessorSpeed : UInt32
}
struct IEncodingFilterFactory extends IUnknown {
    static IID := "{70BDDE00-C18E-11D0-A9CE-006097942311}"
    FindBestFilter(pwzCodeIn, pwzCodeOut, info, ppDF)
      => ComCall(3, this.p, "Str", pwzCodeIn, "Str", pwzCodeOut, DATAINFO, info, IDataFilter.Ptr, ppDF)
    GetDefaultFilter(pwzCodeIn, pwzCodeOut, ppDF)
      => ComCall(4, this.p, "Str", pwzCodeIn, "Str", pwzCodeOut, IDataFilter.Ptr, ppDF)
}
struct HIT_LOGGING_INFO {
    dwStructSize : UInt32
    lpszLoggedUrlName : PSTR
    StartTime : SYSTEMTIME
    EndTime : SYSTEMTIME
    lpszExtendedInfo : PSTR
}
struct CONFIRMSAFETY {
    clsid : GUID
    pUnk : IUnknown
    dwFlags : UInt32
}
struct IWrappedProtocol extends IUnknown {
    static IID := "{53C84785-8425-4DC5-971B-E58D9C19F9B6}"
    GetWrapperCode(pnCode, dwReserved)
      => ComCall(3, this.p, Int32.Ptr, pnCode, IntPtr, dwReserved)
}
struct BINDHANDLETYPES extends Int32 {
    static BINDHANDLETYPES_APPCACHE := 0
    static BINDHANDLETYPES_DEPENDENCY := 1
    static BINDHANDLETYPES_COUNT := 2
}
struct IGetBindHandle extends IUnknown {
    static IID := "{AF0FF408-129D-4B20-91F0-02BD23D88352}"
    GetBindHandle(enumRequestedHandle, pRetHandle)
      => ComCall(3, this.p, BINDHANDLETYPES, enumRequestedHandle, HANDLE.Ptr, pRetHandle)
}
struct PROTOCOL_ARGUMENT {
    szMethod : PWSTR
    szTargetUrl : PWSTR
}
struct IBindCallbackRedirect extends IUnknown {
    static IID := "{11C81BC2-121E-4ED5-B9C4-B430BD54F2C0}"
    Redirect(lpcUrl, vbCancel)
      => ComCall(3, this.p, "Str", lpcUrl, VARIANT_BOOL.Ptr, vbCancel)
}
struct IBindHttpSecurity extends IUnknown {
    static IID := "{A9EDA967-F50E-4A33-B358-206F6EF3086D}"
    GetIgnoreCertMask(pdwIgnoreCertMask)
      => ComCall(3, this.p, UInt32.Ptr, pdwIgnoreCertMask)
}
