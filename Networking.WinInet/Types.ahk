#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, FILETIME, HANDLE, HRESULT, HWND, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\Security.Authentication.Identity\Types.ahk" {SecPkgContext_Bindings, SecPkgContext_CipherInfo, SecPkgContext_ConnectionInfo}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CHAIN_CONTEXT, CERT_CONTEXT}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct CACHE_CONFIG extends UInt32 {
    static CACHE_CONFIG_FORCE_CLEANUP_FC := 32
    static CACHE_CONFIG_DISK_CACHE_PATHS_FC := 64
    static CACHE_CONFIG_SYNC_MODE_FC := 128
    static CACHE_CONFIG_CONTENT_PATHS_FC := 256
    static CACHE_CONFIG_HISTORY_PATHS_FC := 1024
    static CACHE_CONFIG_COOKIES_PATHS_FC := 512
    static CACHE_CONFIG_QUOTA_FC := 2048
    static CACHE_CONFIG_USER_MODE_FC := 4096
    static CACHE_CONFIG_CONTENT_USAGE_FC := 8192
    static CACHE_CONFIG_STICKY_CONTENT_USAGE_FC := 16384
}
struct FTP_FLAGS extends UInt32 {
    static FTP_TRANSFER_TYPE_ASCII := 1
    static FTP_TRANSFER_TYPE_BINARY := 2
    static FTP_TRANSFER_TYPE_UNKNOWN := 0
    static INTERNET_FLAG_TRANSFER_ASCII := 1
    static INTERNET_FLAG_TRANSFER_BINARY := 2
}
struct INTERNET_CONNECTION extends UInt32 {
    static INTERNET_CONNECTION_CONFIGURED := 64
    static INTERNET_CONNECTION_LAN := 2
    static INTERNET_CONNECTION_MODEM := 1
    static INTERNET_CONNECTION_MODEM_BUSY := 8
    static INTERNET_CONNECTION_OFFLINE := 32
    static INTERNET_CONNECTION_PROXY := 4
    static INTERNET_RAS_INSTALLED := 16
}
struct HTTP_ADDREQ_FLAG extends UInt32 {
    static HTTP_ADDREQ_FLAG_ADD := 536870912
    static HTTP_ADDREQ_FLAG_ADD_IF_NEW := 268435456
    static HTTP_ADDREQ_FLAG_COALESCE := 1073741824
    static HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA := 1073741824
    static HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON := 16777216
    static HTTP_ADDREQ_FLAG_REPLACE := 2147483648
}
struct INTERNET_COOKIE_FLAGS extends UInt32 {
    static INTERNET_COOKIE_HTTPONLY := 8192
    static INTERNET_COOKIE_THIRD_PARTY := 16
    static INTERNET_FLAG_RESTRICTED_ZONE := 131072
}
struct PROXY_AUTO_DETECT_TYPE extends UInt32 {
    static PROXY_AUTO_DETECT_TYPE_DHCP := 1
    static PROXY_AUTO_DETECT_TYPE_DNS_A := 2
}
struct INTERNET_AUTODIAL extends UInt32 {
    static INTERNET_AUTODIAL_FAILIFSECURITYCHECK := 4
    static INTERNET_AUTODIAL_FORCE_ONLINE := 1
    static INTERNET_AUTODIAL_FORCE_UNATTENDED := 2
    static INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT := 8
}
struct GOPHER_TYPE extends UInt32 {
    static GOPHER_TYPE_ASK := 1073741824
    static GOPHER_TYPE_BINARY := 512
    static GOPHER_TYPE_BITMAP := 16384
    static GOPHER_TYPE_CALENDAR := 524288
    static GOPHER_TYPE_CSO := 4
    static GOPHER_TYPE_DIRECTORY := 2
    static GOPHER_TYPE_DOS_ARCHIVE := 32
    static GOPHER_TYPE_ERROR := 8
    static GOPHER_TYPE_GIF := 4096
    static GOPHER_TYPE_GOPHER_PLUS := 2147483648
    static GOPHER_TYPE_HTML := 131072
    static GOPHER_TYPE_IMAGE := 8192
    static GOPHER_TYPE_INDEX_SERVER := 128
    static GOPHER_TYPE_INLINE := 1048576
    static GOPHER_TYPE_MAC_BINHEX := 16
    static GOPHER_TYPE_MOVIE := 32768
    static GOPHER_TYPE_PDF := 262144
    static GOPHER_TYPE_REDUNDANT := 1024
    static GOPHER_TYPE_SOUND := 65536
    static GOPHER_TYPE_TELNET := 256
    static GOPHER_TYPE_TEXT_FILE := 1
    static GOPHER_TYPE_TN3270 := 2048
    static GOPHER_TYPE_UNIX_UUENCODED := 64
    static GOPHER_TYPE_UNKNOWN := 536870912
}
struct INTERNET_PER_CONN extends UInt32 {
    static INTERNET_PER_CONN_AUTOCONFIG_URL := 4
    static INTERNET_PER_CONN_AUTODISCOVERY_FLAGS := 5
    static INTERNET_PER_CONN_FLAGS := 1
    static INTERNET_PER_CONN_PROXY_BYPASS := 3
    static INTERNET_PER_CONN_PROXY_SERVER := 2
    static INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL := 6
    static INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS := 7
    static INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME := 8
    static INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL := 9
}
struct INTERNET_ACCESS_TYPE extends UInt32 {
    static INTERNET_OPEN_TYPE_DIRECT := 1
    static INTERNET_OPEN_TYPE_PRECONFIG := 0
    static INTERNET_OPEN_TYPE_PROXY := 3
}
struct INTERNET_STATE extends UInt32 {
    static INTERNET_STATE_CONNECTED := 1
    static INTERNET_STATE_DISCONNECTED := 2
    static INTERNET_STATE_DISCONNECTED_BY_USER := 16
    static INTERNET_STATE_IDLE := 256
    static INTERNET_STATE_BUSY := 512
}
struct HTTP_PUSH_WAIT_HANDLE {
    Value : IntPtr
}
struct INTERNET_SCHEME extends Int32 {
    static INTERNET_SCHEME_PARTIAL := -2
    static INTERNET_SCHEME_UNKNOWN := -1
    static INTERNET_SCHEME_DEFAULT := 0
    static INTERNET_SCHEME_FTP := 1
    static INTERNET_SCHEME_GOPHER := 2
    static INTERNET_SCHEME_HTTP := 3
    static INTERNET_SCHEME_HTTPS := 4
    static INTERNET_SCHEME_FILE := 5
    static INTERNET_SCHEME_NEWS := 6
    static INTERNET_SCHEME_MAILTO := 7
    static INTERNET_SCHEME_SOCKS := 8
    static INTERNET_SCHEME_JAVASCRIPT := 9
    static INTERNET_SCHEME_VBSCRIPT := 10
    static INTERNET_SCHEME_RES := 11
    static INTERNET_SCHEME_FIRST := 1
    static INTERNET_SCHEME_LAST := 11
}
struct INTERNET_ASYNC_RESULT {
    dwResult : IntPtr
    dwError : UInt32
}
struct INTERNET_DIAGNOSTIC_SOCKET_INFO {
    Socket : IntPtr
    SourcePort : UInt32
    DestPort : UInt32
    Flags : UInt32
}
struct INTERNET_PROXY_INFO {
    dwAccessType : INTERNET_ACCESS_TYPE
    lpszProxy : Int8.Ptr
    lpszProxyBypass : Int8.Ptr
}
struct INTERNET_PER_CONN_OPTIONA {
    dwOption : INTERNET_PER_CONN
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            dwValue : UInt32
            pszValue : PSTR
            ftValue : FILETIME
        }
    }
}
struct INTERNET_PER_CONN_OPTIONW {
    dwOption : INTERNET_PER_CONN
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            dwValue : UInt32
            pszValue : PWSTR
            ftValue : FILETIME
        }
    }
}
struct INTERNET_PER_CONN_OPTION_LISTA {
    dwSize : UInt32
    pszConnection : PSTR
    dwOptionCount : UInt32
    dwOptionError : UInt32
    pOptions : INTERNET_PER_CONN_OPTIONA.Ptr
}
struct INTERNET_PER_CONN_OPTION_LISTW {
    dwSize : UInt32
    pszConnection : PWSTR
    dwOptionCount : UInt32
    dwOptionError : UInt32
    pOptions : INTERNET_PER_CONN_OPTIONW.Ptr
}
struct INTERNET_VERSION_INFO {
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
}
struct INTERNET_CONNECTED_INFO {
    dwConnectedState : INTERNET_STATE
    dwFlags : UInt32
}
struct URL_COMPONENTSA {
    dwStructSize : UInt32
    lpszScheme : PSTR
    dwSchemeLength : UInt32
    nScheme : INTERNET_SCHEME
    lpszHostName : PSTR
    dwHostNameLength : UInt32
    nPort : UInt16
    lpszUserName : PSTR
    dwUserNameLength : UInt32
    lpszPassword : PSTR
    dwPasswordLength : UInt32
    lpszUrlPath : PSTR
    dwUrlPathLength : UInt32
    lpszExtraInfo : PSTR
    dwExtraInfoLength : UInt32
}
struct URL_COMPONENTSW {
    dwStructSize : UInt32
    lpszScheme : PWSTR
    dwSchemeLength : UInt32
    nScheme : INTERNET_SCHEME
    lpszHostName : PWSTR
    dwHostNameLength : UInt32
    nPort : UInt16
    lpszUserName : PWSTR
    dwUserNameLength : UInt32
    lpszPassword : PWSTR
    dwPasswordLength : UInt32
    lpszUrlPath : PWSTR
    dwUrlPathLength : UInt32
    lpszExtraInfo : PWSTR
    dwExtraInfoLength : UInt32
}
struct INTERNET_CERTIFICATE_INFO {
    ftExpiry : FILETIME
    ftStart : FILETIME
    lpszSubjectInfo : Int8.Ptr
    lpszIssuerInfo : Int8.Ptr
    lpszProtocolName : Int8.Ptr
    lpszSignatureAlgName : Int8.Ptr
    lpszEncryptionAlgName : Int8.Ptr
    dwKeySize : UInt32
}
struct INTERNET_BUFFERSA {
    dwStructSize : UInt32
    Next : INTERNET_BUFFERSA.Ptr
    lpcszHeader : PSTR
    dwHeadersLength : UInt32
    dwHeadersTotal : UInt32
    lpvBuffer : Struct.Ptr
    dwBufferLength : UInt32
    dwBufferTotal : UInt32
    dwOffsetLow : UInt32
    dwOffsetHigh : UInt32
}
struct INTERNET_BUFFERSW {
    dwStructSize : UInt32
    Next : INTERNET_BUFFERSW.Ptr
    lpcszHeader : PWSTR
    dwHeadersLength : UInt32
    dwHeadersTotal : UInt32
    lpvBuffer : Struct.Ptr
    dwBufferLength : UInt32
    dwBufferTotal : UInt32
    dwOffsetLow : UInt32
    dwOffsetHigh : UInt32
}
struct LPINTERNET_STATUS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, Struct.Ptr, UInt32, "Void"]
}
struct InternetCookieState extends Int32 {
    static COOKIE_STATE_UNKNOWN := 0
    static COOKIE_STATE_ACCEPT := 1
    static COOKIE_STATE_PROMPT := 2
    static COOKIE_STATE_LEASH := 3
    static COOKIE_STATE_DOWNGRADE := 4
    static COOKIE_STATE_REJECT := 5
    static COOKIE_STATE_MAX := 5
}
struct IncomingCookieState {
    cSession : Int32
    cPersistent : Int32
    cAccepted : Int32
    cLeashed : Int32
    cDowngraded : Int32
    cBlocked : Int32
    pszLocation : PSTR
}
struct OutgoingCookieState {
    cSent : Int32
    cSuppressed : Int32
    pszLocation : PSTR
}
struct InternetCookieHistory {
    fAccepted : BOOL
    fLeashed : BOOL
    fDowngraded : BOOL
    fRejected : BOOL
}
struct CookieDecision {
    dwCookieState : UInt32
    fAllowSession : BOOL
}
struct GOPHER_FIND_DATAA {
    DisplayString : CHAR[129]
    GopherType : GOPHER_TYPE
    SizeLow : UInt32
    SizeHigh : UInt32
    LastModificationTime : FILETIME
    Locator : CHAR[654]
}
struct GOPHER_FIND_DATAW {
    DisplayString : UInt16[129]
    GopherType : GOPHER_TYPE
    SizeLow : UInt32
    SizeHigh : UInt32
    LastModificationTime : FILETIME
    Locator : UInt16[654]
}
struct GOPHER_ADMIN_ATTRIBUTE_TYPE {
    Comment : Int8.Ptr
    EmailAddress : Int8.Ptr
}
struct GOPHER_MOD_DATE_ATTRIBUTE_TYPE {
    DateAndTime : FILETIME
}
struct GOPHER_TTL_ATTRIBUTE_TYPE {
    Ttl : UInt32
}
struct GOPHER_SCORE_ATTRIBUTE_TYPE {
    Score : Int32
}
struct GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE {
    LowerBound : Int32
    UpperBound : Int32
}
struct GOPHER_SITE_ATTRIBUTE_TYPE {
    Site : Int8.Ptr
}
struct GOPHER_ORGANIZATION_ATTRIBUTE_TYPE {
    Organization : Int8.Ptr
}
struct GOPHER_LOCATION_ATTRIBUTE_TYPE {
    Location : Int8.Ptr
}
struct GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE {
    DegreesNorth : Int32
    MinutesNorth : Int32
    SecondsNorth : Int32
    DegreesEast : Int32
    MinutesEast : Int32
    SecondsEast : Int32
}
struct GOPHER_TIMEZONE_ATTRIBUTE_TYPE {
    Zone : Int32
}
struct GOPHER_PROVIDER_ATTRIBUTE_TYPE {
    Provider : Int8.Ptr
}
struct GOPHER_VERSION_ATTRIBUTE_TYPE {
    Version : Int8.Ptr
}
struct GOPHER_ABSTRACT_ATTRIBUTE_TYPE {
    ShortAbstract : Int8.Ptr
    AbstractFile : Int8.Ptr
}
struct GOPHER_VIEW_ATTRIBUTE_TYPE {
    ContentType : Int8.Ptr
    Language : Int8.Ptr
    Size : UInt32
}
struct GOPHER_VERONICA_ATTRIBUTE_TYPE {
    TreeWalk : BOOL
}
struct GOPHER_ASK_ATTRIBUTE_TYPE {
    QuestionType : Int8.Ptr
    QuestionText : Int8.Ptr
}
struct GOPHER_UNKNOWN_ATTRIBUTE_TYPE {
    Text : Int8.Ptr
}
struct GOPHER_ATTRIBUTE_TYPE {
    CategoryId : UInt32
    AttributeId : UInt32
    AttributeType : this._AttributeType_e__Union
    struct _AttributeType_e__Union {
        union {
            Admin : GOPHER_ADMIN_ATTRIBUTE_TYPE
            ModDate : GOPHER_MOD_DATE_ATTRIBUTE_TYPE
            Ttl : GOPHER_TTL_ATTRIBUTE_TYPE
            Score : GOPHER_SCORE_ATTRIBUTE_TYPE
            ScoreRange : GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE
            Site : GOPHER_SITE_ATTRIBUTE_TYPE
            Organization : GOPHER_ORGANIZATION_ATTRIBUTE_TYPE
            Location : GOPHER_LOCATION_ATTRIBUTE_TYPE
            GeographicalLocation : GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE
            TimeZone : GOPHER_TIMEZONE_ATTRIBUTE_TYPE
            Provider : GOPHER_PROVIDER_ATTRIBUTE_TYPE
            Version : GOPHER_VERSION_ATTRIBUTE_TYPE
            Abstract : GOPHER_ABSTRACT_ATTRIBUTE_TYPE
            View : GOPHER_VIEW_ATTRIBUTE_TYPE
            Veronica : GOPHER_VERONICA_ATTRIBUTE_TYPE
            Ask : GOPHER_ASK_ATTRIBUTE_TYPE
            Unknown : GOPHER_UNKNOWN_ATTRIBUTE_TYPE
        }
    }
}
struct GOPHER_ATTRIBUTE_ENUMERATOR extends FunctionPointer {
    static Types := [GOPHER_ATTRIBUTE_TYPE.Ptr, UInt32, BOOL]
}
struct INTERNET_COOKIE2 {
    pwszName : PWSTR
    pwszValue : PWSTR
    pwszDomain : PWSTR
    pwszPath : PWSTR
    dwFlags : UInt32
    ftExpires : FILETIME
    fExpiresSet : BOOL
}
struct PFN_AUTH_NOTIFY extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, UInt32]
}
struct INTERNET_AUTH_NOTIFY_DATA {
    cbStruct : UInt32
    dwOptions : UInt32
    pfnNotify : PFN_AUTH_NOTIFY
    dwContext : IntPtr
}
struct INTERNET_CACHE_ENTRY_INFOA {
    dwStructSize : UInt32
    lpszSourceUrlName : PSTR
    lpszLocalFileName : PSTR
    CacheEntryType : UInt32
    dwUseCount : UInt32
    dwHitRate : UInt32
    dwSizeLow : UInt32
    dwSizeHigh : UInt32
    LastModifiedTime : FILETIME
    ExpireTime : FILETIME
    LastAccessTime : FILETIME
    LastSyncTime : FILETIME
    lpHeaderInfo : PSTR
    dwHeaderInfoSize : UInt32
    lpszFileExtension : PSTR
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwReserved : UInt32
            dwExemptDelta : UInt32
        }
    }
}
struct INTERNET_CACHE_ENTRY_INFOW {
    dwStructSize : UInt32
    lpszSourceUrlName : PWSTR
    lpszLocalFileName : PWSTR
    CacheEntryType : UInt32
    dwUseCount : UInt32
    dwHitRate : UInt32
    dwSizeLow : UInt32
    dwSizeHigh : UInt32
    LastModifiedTime : FILETIME
    ExpireTime : FILETIME
    LastAccessTime : FILETIME
    LastSyncTime : FILETIME
    lpHeaderInfo : PWSTR
    dwHeaderInfoSize : UInt32
    lpszFileExtension : PWSTR
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwReserved : UInt32
            dwExemptDelta : UInt32
        }
    }
}
struct INTERNET_CACHE_TIMESTAMPS {
    ftExpires : FILETIME
    ftLastModified : FILETIME
}
struct INTERNET_CACHE_GROUP_INFOA {
    dwGroupSize : UInt32
    dwGroupFlags : UInt32
    dwGroupType : UInt32
    dwDiskUsage : UInt32
    dwDiskQuota : UInt32
    dwOwnerStorage : UInt32[4]
    szGroupName : CHAR[120]
}
struct INTERNET_CACHE_GROUP_INFOW {
    dwGroupSize : UInt32
    dwGroupFlags : UInt32
    dwGroupType : UInt32
    dwDiskUsage : UInt32
    dwDiskQuota : UInt32
    dwOwnerStorage : UInt32[4]
    szGroupName : UInt16[120]
}
struct AutoProxyHelperVtbl {
    IsResolvable : IntPtr
    GetIPAddress : IntPtr
    ResolveHostName : IntPtr
    IsInNet : IntPtr
    IsResolvableEx : IntPtr
    GetIPAddressEx : IntPtr
    ResolveHostNameEx : IntPtr
    IsInNetEx : IntPtr
    SortIpList : IntPtr
}
struct AUTO_PROXY_SCRIPT_BUFFER {
    dwStructSize : UInt32
    lpszScriptBuffer : PSTR
    dwScriptBufferSize : UInt32
}
struct AutoProxyHelperFunctions {
    lpVtbl : AutoProxyHelperVtbl.Ptr
}
struct pfnInternetInitializeAutoProxyDll extends FunctionPointer {
    static Types := [UInt32, PSTR, PSTR, AutoProxyHelperFunctions.Ptr, AUTO_PROXY_SCRIPT_BUFFER.Ptr, BOOL]
}
struct pfnInternetDeInitializeAutoProxyDll extends FunctionPointer {
    static Types := [PSTR, UInt32, BOOL]
}
struct pfnInternetGetProxyInfo extends FunctionPointer {
    static Types := [PSTR, UInt32, PSTR, UInt32, PSTR.Ptr, UInt32.Ptr, BOOL]
}
struct WPAD_CACHE_DELETE extends Int32 {
    static WPAD_CACHE_DELETE_CURRENT := 0
    static WPAD_CACHE_DELETE_ALL := 1
}
struct PFN_DIAL_HANDLER extends FunctionPointer {
    static Types := [HWND, PSTR, UInt32, UInt32.Ptr, UInt32]
}
struct IDialEventSink extends IUnknown {
    static IID := "{2D86F4FF-6E2D-4488-B2E9-6934AFD41BEA}"
    OnEvent(dwEvent, dwStatus)
      => ComCall(3, this.p, UInt32, dwEvent, UInt32, dwStatus)
}
struct IDialEngine extends IUnknown {
    static IID := "{39FD782B-7905-40D5-9148-3C9B190423D5}"
    Initialize(pwzConnectoid, pIDES)
      => ComCall(3, this.p, "Str", pwzConnectoid, IDialEventSink, pIDES)
    GetProperty(pwzProperty, pwzValue, dwBufSize)
      => ComCall(4, this.p, "Str", pwzProperty, "Str", pwzValue, UInt32, dwBufSize)
    SetProperty(pwzProperty, pwzValue)
      => ComCall(5, this.p, "Str", pwzProperty, "Str", pwzValue)
    Dial()
      => ComCall(6, this.p)
    HangUp()
      => ComCall(7, this.p)
    GetConnectedState(pdwState)
      => ComCall(8, this.p, UInt32.Ptr, pdwState)
    GetConnectHandle(pdwHandle)
      => ComCall(9, this.p, IntPtr.Ptr, pdwHandle)
}
struct IDialBranding extends IUnknown {
    static IID := "{8AECAFA9-4306-43CC-8C5A-765F2979CC16}"
    Initialize(pwzConnectoid)
      => ComCall(3, this.p, "Str", pwzConnectoid)
    GetBitmap(dwIndex, phBitmap)
      => ComCall(4, this.p, UInt32, dwIndex, HBITMAP.Ptr, phBitmap)
}
struct INTERNET_PREFETCH_STATUS {
    dwStatus : UInt32
    dwSize : UInt32
}
struct INTERNET_SECURITY_INFO {
    dwSize : UInt32
    pCertificate : CERT_CONTEXT.Ptr
    pcCertChain : CERT_CHAIN_CONTEXT.Ptr
    connectionInfo : SecPkgContext_ConnectionInfo
    cipherInfo : SecPkgContext_CipherInfo
    pcUnverifiedCertChain : CERT_CHAIN_CONTEXT.Ptr
    channelBindingToken : SecPkgContext_Bindings
}
struct INTERNET_SECURITY_CONNECTION_INFO {
    dwSize : UInt32
    fSecure : BOOL
    connectionInfo : SecPkgContext_ConnectionInfo
    cipherInfo : SecPkgContext_CipherInfo
}
struct FORTCMD extends Int32 {
    static FORTCMD_LOGON := 1
    static FORTCMD_LOGOFF := 2
    static FORTCMD_CHG_PERSONALITY := 3
}
struct FORTSTAT extends Int32 {
    static FORTSTAT_INSTALLED := 1
    static FORTSTAT_LOGGEDON := 2
}
struct INTERNET_DOWNLOAD_MODE_HANDLE {
    pcwszFileName : PWSTR
    phFile : HANDLE.Ptr
}
struct REQUEST_TIMES extends Int32 {
    static NameResolutionStart := 0
    static NameResolutionEnd := 1
    static ConnectionEstablishmentStart := 2
    static ConnectionEstablishmentEnd := 3
    static TLSHandshakeStart := 4
    static TLSHandshakeEnd := 5
    static HttpRequestTimeMax := 32
}
struct HTTP_REQUEST_TIMES {
    cTimes : UInt32
    rgTimes : Int64[32]
}
struct INTERNET_SERVER_CONNECTION_STATE {
    lpcwszHostName : PWSTR
    fProxy : BOOL
    dwCounter : UInt32
    dwConnectionLimit : UInt32
    dwAvailableCreates : UInt32
    dwAvailableKeepAlives : UInt32
    dwActiveConnections : UInt32
    dwWaiters : UInt32
}
struct INTERNET_END_BROWSER_SESSION_DATA {
    lpBuffer : Struct.Ptr
    dwBufferLength : UInt32
}
struct INTERNET_CALLBACK_COOKIE {
    pcwszName : PWSTR
    pcwszValue : PWSTR
    pcwszDomain : PWSTR
    pcwszPath : PWSTR
    ftExpires : FILETIME
    dwFlags : UInt32
}
struct INTERNET_CREDENTIALS {
    lpcwszHostName : PWSTR
    dwPort : UInt32
    dwScheme : UInt32
    lpcwszUrl : PWSTR
    lpcwszRealm : PWSTR
    fAuthIdentity : BOOL
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            pAuthIdentityOpaque : Struct.Ptr
        }
        struct _Anonymous_e__Struct {
            lpcwszUserName : PWSTR
            lpcwszPassword : PWSTR
        }
    }
}
struct HTTP_PUSH_TRANSPORT_SETTING {
    TransportSettingId : GUID
    BrokerEventId : GUID
}
struct HTTP_PUSH_NOTIFICATION_STATUS {
    ChannelStatusValid : BOOL
    ChannelStatus : UInt32
}
struct HTTP_PUSH_WAIT_TYPE extends Int32 {
    static HttpPushWaitEnableComplete := 0
    static HttpPushWaitReceiveComplete := 1
    static HttpPushWaitSendComplete := 2
}
struct INTERNET_COOKIE {
    cbSize : UInt32 := this.Size
    pszName : PSTR
    pszData : PSTR
    pszDomain : PSTR
    pszPath : PSTR
    pftExpires : FILETIME.Ptr
    dwFlags : UInt32
    pszUrl : PSTR
    pszP3PPolicy : PSTR
}
struct COOKIE_DLG_INFO {
    pszServer : PWSTR
    pic : INTERNET_COOKIE.Ptr
    dwStopWarning : UInt32
    cx : Int32
    cy : Int32
    pszHeader : PWSTR
    dwOperation : UInt32
}
struct INTERNET_CACHE_CONFIG_PATH_ENTRYA {
    CachePath : CHAR[260]
    dwCacheSize : UInt32
}
struct INTERNET_CACHE_CONFIG_PATH_ENTRYW {
    CachePath : UInt16[260]
    dwCacheSize : UInt32
}
struct INTERNET_CACHE_CONFIG_INFOA {
    dwStructSize : UInt32
    dwContainer : UInt32
    dwQuota : UInt32
    dwReserved4 : UInt32
    fPerUser : BOOL
    dwSyncMode : UInt32
    dwNumCachePaths : UInt32
    Anonymous : this._Anonymous_e__Union
    dwNormalUsage : UInt32
    dwExemptUsage : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            CachePaths : INTERNET_CACHE_CONFIG_PATH_ENTRYA[1]
        }
        struct _Anonymous_e__Struct {
            CachePath : CHAR[260]
            dwCacheSize : UInt32
        }
    }
}
struct INTERNET_CACHE_CONFIG_INFOW {
    dwStructSize : UInt32
    dwContainer : UInt32
    dwQuota : UInt32
    dwReserved4 : UInt32
    fPerUser : BOOL
    dwSyncMode : UInt32
    dwNumCachePaths : UInt32
    Anonymous : this._Anonymous_e__Union
    dwNormalUsage : UInt32
    dwExemptUsage : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            CachePaths : INTERNET_CACHE_CONFIG_PATH_ENTRYW[1]
        }
        struct _Anonymous_e__Struct {
            CachePath : UInt16[260]
            dwCacheSize : UInt32
        }
    }
}
struct INTERNET_CACHE_CONTAINER_INFOA {
    dwCacheVersion : UInt32
    lpszName : PSTR
    lpszCachePrefix : PSTR
    lpszVolumeLabel : PSTR
    lpszVolumeTitle : PSTR
}
struct INTERNET_CACHE_CONTAINER_INFOW {
    dwCacheVersion : UInt32
    lpszName : PWSTR
    lpszCachePrefix : PWSTR
    lpszVolumeLabel : PWSTR
    lpszVolumeTitle : PWSTR
}
struct WININET_SYNC_MODE extends Int32 {
    static WININET_SYNC_MODE_NEVER := 0
    static WININET_SYNC_MODE_ON_EXPIRY := 1
    static WININET_SYNC_MODE_ONCE_PER_SESSION := 2
    static WININET_SYNC_MODE_ALWAYS := 3
    static WININET_SYNC_MODE_AUTOMATIC := 4
    static WININET_SYNC_MODE_DEFAULT := 4
}
struct APP_CACHE_STATE extends Int32 {
    static AppCacheStateNoUpdateNeeded := 0
    static AppCacheStateUpdateNeeded := 1
    static AppCacheStateUpdateNeededNew := 2
    static AppCacheStateUpdateNeededMasterOnly := 3
}
struct APP_CACHE_DOWNLOAD_ENTRY {
    pwszUrl : PWSTR
    dwEntryType : UInt32
}
struct APP_CACHE_DOWNLOAD_LIST {
    dwEntryCount : UInt32
    pEntries : APP_CACHE_DOWNLOAD_ENTRY.Ptr
}
struct APP_CACHE_FINALIZE_STATE extends Int32 {
    static AppCacheFinalizeStateIncomplete := 0
    static AppCacheFinalizeStateManifestChange := 1
    static AppCacheFinalizeStateComplete := 2
}
struct APP_CACHE_GROUP_INFO {
    pwszManifestUrl : PWSTR
    ftLastAccessTime : FILETIME
    ullSize : Int64
}
struct APP_CACHE_GROUP_LIST {
    dwAppCacheGroupCount : UInt32
    pAppCacheGroups : APP_CACHE_GROUP_INFO.Ptr
}
struct URLCACHE_ENTRY_INFO {
    pwszSourceUrlName : PWSTR
    pwszLocalFileName : PWSTR
    dwCacheEntryType : UInt32
    dwUseCount : UInt32
    dwHitRate : UInt32
    dwSizeLow : UInt32
    dwSizeHigh : UInt32
    ftLastModifiedTime : FILETIME
    ftExpireTime : FILETIME
    ftLastAccessTime : FILETIME
    ftLastSyncTime : FILETIME
    pbHeaderInfo : UInt8.Ptr
    cbHeaderInfoSize : UInt32
    pbExtraData : UInt8.Ptr
    cbExtraDataSize : UInt32
}
struct URL_CACHE_LIMIT_TYPE extends Int32 {
    static UrlCacheLimitTypeIE := 0
    static UrlCacheLimitTypeIETotal := 1
    static UrlCacheLimitTypeAppContainer := 2
    static UrlCacheLimitTypeAppContainerTotal := 3
    static UrlCacheLimitTypeNum := 4
}
struct WININET_PROXY_INFO {
    fProxy : BOOL
    fBypass : BOOL
    ProxyScheme : INTERNET_SCHEME
    pwszProxy : PWSTR
    ProxyPort : UInt16
}
struct WININET_PROXY_INFO_LIST {
    dwProxyInfoCount : UInt32
    pProxyInfo : WININET_PROXY_INFO.Ptr
}
struct CACHE_OPERATOR extends FunctionPointer {
    static Types := [INTERNET_CACHE_ENTRY_INFOA.Ptr, UInt32.Ptr, Struct.Ptr, BOOL]
}
struct HTTP_WEB_SOCKET_OPERATION extends Int32 {
    static HTTP_WEB_SOCKET_SEND_OPERATION := 0
    static HTTP_WEB_SOCKET_RECEIVE_OPERATION := 1
    static HTTP_WEB_SOCKET_CLOSE_OPERATION := 2
    static HTTP_WEB_SOCKET_SHUTDOWN_OPERATION := 3
}
struct HTTP_WEB_SOCKET_BUFFER_TYPE extends Int32 {
    static HTTP_WEB_SOCKET_BINARY_MESSAGE_TYPE := 0
    static HTTP_WEB_SOCKET_BINARY_FRAGMENT_TYPE := 1
    static HTTP_WEB_SOCKET_UTF8_MESSAGE_TYPE := 2
    static HTTP_WEB_SOCKET_UTF8_FRAGMENT_TYPE := 3
    static HTTP_WEB_SOCKET_CLOSE_TYPE := 4
    static HTTP_WEB_SOCKET_PING_TYPE := 5
}
struct HTTP_WEB_SOCKET_CLOSE_STATUS extends Int32 {
    static HTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS := 1000
    static HTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS := 1001
    static HTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS := 1002
    static HTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS := 1003
    static HTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS := 1005
    static HTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS := 1006
    static HTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS := 1007
    static HTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS := 1008
    static HTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS := 1009
    static HTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS := 1010
    static HTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS := 1011
    static HTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS := 1015
}
struct HTTP_WEB_SOCKET_ASYNC_RESULT {
    AsyncResult : INTERNET_ASYNC_RESULT
    Operation : HTTP_WEB_SOCKET_OPERATION
    BufferType : HTTP_WEB_SOCKET_BUFFER_TYPE
    dwBytesTransferred : UInt32
}
struct HTTP_POLICY_EXTENSION_TYPE extends Int32 {
    static POLICY_EXTENSION_TYPE_NONE := 0
    static POLICY_EXTENSION_TYPE_WINHTTP := 1
    static POLICY_EXTENSION_TYPE_WININET := 2
}
struct HTTP_POLICY_EXTENSION_VERSION extends Int32 {
    static POLICY_EXTENSION_VERSION1 := 1
}
struct HTTP_POLICY_EXTENSION_INIT extends FunctionPointer {
    static Types := [HTTP_POLICY_EXTENSION_VERSION, HTTP_POLICY_EXTENSION_TYPE, Struct.Ptr, UInt32, UInt32]
}
struct HTTP_POLICY_EXTENSION_SHUTDOWN extends FunctionPointer {
    static Types := [HTTP_POLICY_EXTENSION_TYPE, UInt32]
}
struct ProofOfPossessionCookieInfo {
    name : PWSTR
    data : PWSTR
    flags : UInt32
    p3pHeader : PWSTR
}
struct PROOF_OF_POSSESSION_FLAGS extends UInt32 {
    static PROOF_OF_POSSESSION_DEFAULT := 0
    static PROOF_OF_POSSESSION_ALLOW_SILENT_REQUESTS := 1
}
struct IProofOfPossessionCookieInfoManager extends IUnknown {
    static IID := "{CDAECE56-4EDF-43DF-B113-88E4556FA1BB}"
    GetCookieInfoForUri(uri, cookieInfo)
      => ComCall(3, this.p, "Str", uri, UInt32.Ptr, cookieInfo.Length, ProofOfPossessionCookieInfo.Ptr.Ptr, cookieInfo)
}
struct IProofOfPossessionCookieInfoManager2 extends IUnknown {
    static IID := "{15E41407-B42F-4AE7-9966-34A087B2D713}"
    GetCookieInfoWithUriForAccount(webAccount, uri, cookieInfo)
      => ComCall(3, this.p, IInspectable, webAccount, "Str", uri, UInt32.Ptr, cookieInfo.Length, ProofOfPossessionCookieInfo.Ptr.Ptr, cookieInfo)
}
struct IProofOfPossessionCookieInfoManager3 extends IUnknown {
    static IID := "{C8891744-32BD-4A77-B92C-0E79A2823B96}"
    GetCookieInfoForUriWithOptions(uri, options, cookieInfo)
      => ComCall(3, this.p, "Str", uri, UInt32, options, UInt32.Ptr, cookieInfo.Length, ProofOfPossessionCookieInfo.Ptr.Ptr, cookieInfo)
}
struct IProofOfPossessionCookieInfoManager4 extends IUnknown {
    static IID := "{3B74C75B-6E3F-494E-95EC-13174E12A89F}"
    GetCookieInfoForUriWithUserAgentId(uri, uaClientId, cookieInfo)
      => ComCall(3, this.p, "Str", uri, "Str", uaClientId, UInt32.Ptr, cookieInfo.Length, ProofOfPossessionCookieInfo.Ptr.Ptr, cookieInfo)
    GetCookieInfoWithUriAndUserAgentIdForAccount(webAccount, uri, uaClientId, cookieInfo)
      => ComCall(4, this.p, IInspectable, webAccount, "Str", uri, "Str", uaClientId, UInt32.Ptr, cookieInfo.Length, ProofOfPossessionCookieInfo.Ptr.Ptr, cookieInfo)
}
