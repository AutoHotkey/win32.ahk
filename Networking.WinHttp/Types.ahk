#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\Networking.WinSock\Types.ahk" {SOCKADDR_STORAGE}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct WINHTTP_OPEN_REQUEST_FLAGS extends UInt32 {
    static WINHTTP_FLAG_BYPASS_PROXY_CACHE := 256
    static WINHTTP_FLAG_ESCAPE_DISABLE := 64
    static WINHTTP_FLAG_ESCAPE_DISABLE_QUERY := 128
    static WINHTTP_FLAG_ESCAPE_PERCENT := 4
    static WINHTTP_FLAG_NULL_CODEPAGE := 8
    static WINHTTP_FLAG_REFRESH := 256
    static WINHTTP_FLAG_SECURE := 8388608
}
struct WIN_HTTP_CREATE_URL_FLAGS extends UInt32 {
    static ICU_ESCAPE := 2147483648
    static ICU_REJECT_USERPWD := 16384
    static ICU_DECODE := 268435456
}
struct WINHTTP_ACCESS_TYPE extends UInt32 {
    static WINHTTP_ACCESS_TYPE_NO_PROXY := 1
    static WINHTTP_ACCESS_TYPE_DEFAULT_PROXY := 0
    static WINHTTP_ACCESS_TYPE_NAMED_PROXY := 3
    static WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY := 4
}
struct WINHTTP_CREDS_AUTHSCHEME extends UInt32 {
    static WINHTTP_AUTH_SCHEME_BASIC := 1
    static WINHTTP_AUTH_SCHEME_NTLM := 2
    static WINHTTP_AUTH_SCHEME_NEGOTIATE := 16
}
struct WINHTTP_INTERNET_SCHEME extends Int32 {
    static WINHTTP_INTERNET_SCHEME_HTTP := 1
    static WINHTTP_INTERNET_SCHEME_HTTPS := 2
    static WINHTTP_INTERNET_SCHEME_FTP := 3
    static WINHTTP_INTERNET_SCHEME_SOCKS := 4
}
struct WINHTTP_CONNECTION_INFO {
    cbSize : UInt32 := this.Size
    LocalAddress : SOCKADDR_STORAGE
    RemoteAddress : SOCKADDR_STORAGE
}
struct WINHTTP_REQUEST_TIMES {
    cTimes : UInt32
    rgullTimes : Int64[64]
}
struct WINHTTP_REQUEST_STATS {
    ullFlags : Int64
    ulIndex : UInt32
    cStats : UInt32
    rgullStats : Int64[32]
}
struct WINHTTP_MATCH_CONNECTION_GUID {
    ConnectionGuid : GUID
    ullFlags : Int64
}
struct WINHTTP_RESOLVER_CACHE_CONFIG {
    ulMaxResolverCacheEntries : UInt32
    ulMaxCacheEntryAge : UInt32
    ulMinCacheEntryTtl : UInt32
    SecureDnsSetting : WINHTTP_SECURE_DNS_SETTING
    ullConnResolutionWaitTime : Int64
    ullFlags : Int64
}
struct WINHTTP_PROXY_SETTINGS_EX {
    ullGenerationId : Int64
    ullFlags : Int64
    pcwszAutoconfigUrl : PWSTR
    pcwszProxy : PWSTR
    pcwszSecureProxy : PWSTR
    cProxyBypasses : UInt32
    rgpcwszProxyBypasses : PWSTR.Ptr
    dwInterfaceIndex : UInt32
    pcwszConnectionName : PWSTR
}
struct WINHTTP_PROXY_SETTINGS_PARAM {
    ullFlags : Int64
    pcwszConnectionName : PWSTR
    pcwszProbeHost : PWSTR
}
struct WINHTTP_FAST_FORWARDING_STATUS {
    TransferState : WINHTTP_FAST_FORWARDING_STATE
    NtStatus : Int32
    dwError : UInt32
    ullBytesTransferred : Int64
}
struct WINHTTP_ASYNC_RESULT {
    dwResult : IntPtr
    dwError : UInt32
}
struct HTTP_VERSION_INFO {
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
}
struct URL_COMPONENTS {
    dwStructSize : UInt32
    lpszScheme : PWSTR
    dwSchemeLength : UInt32
    nScheme : WINHTTP_INTERNET_SCHEME
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
struct WINHTTP_PROXY_INFO {
    dwAccessType : WINHTTP_ACCESS_TYPE
    lpszProxy : PWSTR
    lpszProxyBypass : PWSTR
}
struct WINHTTP_AUTOPROXY_OPTIONS {
    dwFlags : UInt32
    dwAutoDetectFlags : UInt32
    lpszAutoConfigUrl : PWSTR
    lpvReserved : Struct.Ptr
    dwReserved : UInt32
    fAutoLogonIfChallenged : BOOL
}
struct WINHTTP_PROXY_RESULT_ENTRY {
    fProxy : BOOL
    fBypass : BOOL
    ProxyScheme : WINHTTP_INTERNET_SCHEME
    pwszProxy : PWSTR
    ProxyPort : UInt16
}
struct WINHTTP_PROXY_RESULT {
    cEntries : UInt32
    pEntries : WINHTTP_PROXY_RESULT_ENTRY.Ptr
}
struct WINHTTP_PROXY_RESULT_EX {
    cEntries : UInt32
    pEntries : WINHTTP_PROXY_RESULT_ENTRY.Ptr
    hProxyDetectionHandle : HANDLE
    dwProxyInterfaceAffinity : UInt32
}
struct WINHTTP_PROXY_NETWORKING_KEY {
    pbBuffer : UInt8[128]
}
struct WINHTTP_PROXY_SETTINGS {
    dwStructSize : UInt32
    dwFlags : UInt32
    dwCurrentSettingsVersion : UInt32
    pwszConnectionName : PWSTR
    pwszProxy : PWSTR
    pwszProxyBypass : PWSTR
    pwszAutoconfigUrl : PWSTR
    pwszAutoconfigSecondaryUrl : PWSTR
    dwAutoDiscoveryFlags : UInt32
    pwszLastKnownGoodAutoConfigUrl : PWSTR
    dwAutoconfigReloadDelayMins : UInt32
    ftLastKnownDetectTime : FILETIME
    dwDetectedInterfaceIpCount : UInt32
    pdwDetectedInterfaceIp : UInt32.Ptr
    cNetworkKeys : UInt32
    pNetworkKeys : WINHTTP_PROXY_NETWORKING_KEY.Ptr
}
struct WINHTTP_CERTIFICATE_INFO {
    ftExpiry : FILETIME
    ftStart : FILETIME
    lpszSubjectInfo : PWSTR
    lpszIssuerInfo : PWSTR
    lpszProtocolName : PWSTR
    lpszSignatureAlgName : PWSTR
    lpszEncryptionAlgName : PWSTR
    dwKeySize : UInt32
}
struct WINHTTP_REQUEST_TIME_ENTRY extends Int32 {
    static WinHttpProxyDetectionStart := 0
    static WinHttpProxyDetectionEnd := 1
    static WinHttpConnectionAcquireStart := 2
    static WinHttpConnectionAcquireWaitEnd := 3
    static WinHttpConnectionAcquireEnd := 4
    static WinHttpNameResolutionStart := 5
    static WinHttpNameResolutionEnd := 6
    static WinHttpConnectionEstablishmentStart := 7
    static WinHttpConnectionEstablishmentEnd := 8
    static WinHttpTlsHandshakeClientLeg1Start := 9
    static WinHttpTlsHandshakeClientLeg1End := 10
    static WinHttpTlsHandshakeClientLeg2Start := 11
    static WinHttpTlsHandshakeClientLeg2End := 12
    static WinHttpTlsHandshakeClientLeg3Start := 13
    static WinHttpTlsHandshakeClientLeg3End := 14
    static WinHttpStreamWaitStart := 15
    static WinHttpStreamWaitEnd := 16
    static WinHttpSendRequestStart := 17
    static WinHttpSendRequestHeadersCompressionStart := 18
    static WinHttpSendRequestHeadersCompressionEnd := 19
    static WinHttpSendRequestHeadersEnd := 20
    static WinHttpSendRequestEnd := 21
    static WinHttpReceiveResponseStart := 22
    static WinHttpReceiveResponseHeadersDecompressionStart := 23
    static WinHttpReceiveResponseHeadersDecompressionEnd := 24
    static WinHttpReceiveResponseHeadersEnd := 25
    static WinHttpReceiveResponseBodyDecompressionDelta := 26
    static WinHttpReceiveResponseEnd := 27
    static WinHttpProxyTunnelStart := 28
    static WinHttpProxyTunnelEnd := 29
    static WinHttpProxyTlsHandshakeClientLeg1Start := 30
    static WinHttpProxyTlsHandshakeClientLeg1End := 31
    static WinHttpProxyTlsHandshakeClientLeg2Start := 32
    static WinHttpProxyTlsHandshakeClientLeg2End := 33
    static WinHttpProxyTlsHandshakeClientLeg3Start := 34
    static WinHttpProxyTlsHandshakeClientLeg3End := 35
    static WinHttpRequestTimeLast := 36
    static WinHttpRequestTimeMax := 64
}
struct WINHTTP_REQUEST_STAT_ENTRY extends Int32 {
    static WinHttpConnectFailureCount := 0
    static WinHttpProxyFailureCount := 1
    static WinHttpTlsHandshakeClientLeg1Size := 2
    static WinHttpTlsHandshakeServerLeg1Size := 3
    static WinHttpTlsHandshakeClientLeg2Size := 4
    static WinHttpTlsHandshakeServerLeg2Size := 5
    static WinHttpRequestHeadersSize := 6
    static WinHttpRequestHeadersCompressedSize := 7
    static WinHttpResponseHeadersSize := 8
    static WinHttpResponseHeadersCompressedSize := 9
    static WinHttpResponseBodySize := 10
    static WinHttpResponseBodyCompressedSize := 11
    static WinHttpProxyTlsHandshakeClientLeg1Size := 12
    static WinHttpProxyTlsHandshakeServerLeg1Size := 13
    static WinHttpProxyTlsHandshakeClientLeg2Size := 14
    static WinHttpProxyTlsHandshakeServerLeg2Size := 15
    static WinHttpRequestStatLast := 16
    static WinHttpRequestStatMax := 32
}
struct WINHTTP_EXTENDED_HEADER {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            pwszName : PWSTR
            pszName : PSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pwszValue : PWSTR
            pszValue : PSTR
        }
    }
}
struct WINHTTP_HEADER_NAME {
    union {
        pwszName : PWSTR
        pszName : PSTR
    }
}
struct WINHTTP_SECURE_DNS_SETTING extends Int32 {
    static WinHttpSecureDnsSettingDefault := 0
    static WinHttpSecureDnsSettingForcePlaintext := 1
    static WinHttpSecureDnsSettingRequireEncryption := 2
    static WinHttpSecureDnsSettingTryEncryptionWithFallback := 3
    static WinHttpSecureDnsSettingMax := 4
}
struct WINHTTP_CONNECTION_GROUP {
    cConnections : UInt32
    guidGroup : GUID
}
struct WINHTTP_HOST_CONNECTION_GROUP {
    pwszHost : PWSTR
    cConnectionGroups : UInt32
    pConnectionGroups : WINHTTP_CONNECTION_GROUP.Ptr
}
struct WINHTTP_QUERY_CONNECTION_GROUP_RESULT {
    cHosts : UInt32
    pHostConnectionGroups : WINHTTP_HOST_CONNECTION_GROUP.Ptr
}
struct WINHTTP_HTTP2_RECEIVE_WINDOW {
    ulStreamWindow : UInt32
    ulStreamWindowUpdateDelta : UInt32
}
struct WINHTTP_FAILED_CONNECTION_RETRIES {
    dwMaxRetries : UInt32
    dwAllowedRetryConditions : UInt32
}
struct WINHTTP_CREDS {
    lpszUserName : PSTR
    lpszPassword : PSTR
    lpszRealm : PSTR
    dwAuthScheme : WINHTTP_CREDS_AUTHSCHEME
    lpszHostName : PSTR
    dwPort : UInt32
}
struct WINHTTP_CREDS_EX {
    lpszUserName : PSTR
    lpszPassword : PSTR
    lpszRealm : PSTR
    dwAuthScheme : WINHTTP_CREDS_AUTHSCHEME
    lpszHostName : PSTR
    dwPort : UInt32
    lpszUrl : PSTR
}
struct WINHTTP_STATUS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, Struct.Ptr, UInt32, "Void"]
}
struct WINHTTP_CURRENT_USER_IE_PROXY_CONFIG {
    fAutoDetect : BOOL
    lpszAutoConfigUrl : PWSTR
    lpszProxy : PWSTR
    lpszProxyBypass : PWSTR
}
struct WINHTTP_WEB_SOCKET_OPERATION extends Int32 {
    static WINHTTP_WEB_SOCKET_SEND_OPERATION := 0
    static WINHTTP_WEB_SOCKET_RECEIVE_OPERATION := 1
    static WINHTTP_WEB_SOCKET_CLOSE_OPERATION := 2
    static WINHTTP_WEB_SOCKET_SHUTDOWN_OPERATION := 3
}
struct WINHTTP_WEB_SOCKET_BUFFER_TYPE extends Int32 {
    static WINHTTP_WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE := 0
    static WINHTTP_WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE := 1
    static WINHTTP_WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE := 2
    static WINHTTP_WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE := 3
    static WINHTTP_WEB_SOCKET_CLOSE_BUFFER_TYPE := 4
}
struct WINHTTP_WEB_SOCKET_CLOSE_STATUS extends Int32 {
    static WINHTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS := 1000
    static WINHTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS := 1001
    static WINHTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS := 1002
    static WINHTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS := 1003
    static WINHTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS := 1005
    static WINHTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS := 1006
    static WINHTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS := 1007
    static WINHTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS := 1008
    static WINHTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS := 1009
    static WINHTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS := 1010
    static WINHTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS := 1011
    static WINHTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS := 1015
}
struct WINHTTP_WEB_SOCKET_ASYNC_RESULT {
    AsyncResult : WINHTTP_ASYNC_RESULT
    Operation : WINHTTP_WEB_SOCKET_OPERATION
}
struct WINHTTP_WEB_SOCKET_STATUS {
    dwBytesTransferred : UInt32
    eBufferType : WINHTTP_WEB_SOCKET_BUFFER_TYPE
}
struct WINHTTP_PROTOCOL_OPERATION extends Int32 {
    static WINHTTP_PROTOCOL_SEND_OPERATION := 0
    static WINHTTP_PROTOCOL_RECEIVE_OPERATION := 1
}
struct WINHTTP_PROTOCOL_ASYNC_RESULT {
    AsyncResult : WINHTTP_ASYNC_RESULT
    Operation : WINHTTP_PROTOCOL_OPERATION
}
struct WINHTTP_PROXY_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, "Void"]
}
struct WINHTTP_PROXY_SETTINGS_TYPE extends Int32 {
    static WinHttpProxySettingsTypeUnknown := 0
    static WinHttpProxySettingsTypeWsl := 1
    static WinHttpProxySettingsTypeWsa := 2
    static WinHttpProxySettingsTypeXBox := 3
}
struct WINHTTP_FAST_FORWARDING_STATE extends Int32 {
    static WinHttpFastForwardingStateInProgress := 0
    static WinHttpFastForwardingStateSucceeded := 1
    static WinHttpFastForwardingStateClientSideFailed := 2
    static WinHttpFastForwardingStateServerSideFailed := 3
}
struct WinHttpRequestOption extends Int32 {
    static WinHttpRequestOption_UserAgentString := 0
    static WinHttpRequestOption_URL := 1
    static WinHttpRequestOption_URLCodePage := 2
    static WinHttpRequestOption_EscapePercentInURL := 3
    static WinHttpRequestOption_SslErrorIgnoreFlags := 4
    static WinHttpRequestOption_SelectCertificate := 5
    static WinHttpRequestOption_EnableRedirects := 6
    static WinHttpRequestOption_UrlEscapeDisable := 7
    static WinHttpRequestOption_UrlEscapeDisableQuery := 8
    static WinHttpRequestOption_SecureProtocols := 9
    static WinHttpRequestOption_EnableTracing := 10
    static WinHttpRequestOption_RevertImpersonationOverSsl := 11
    static WinHttpRequestOption_EnableHttpsToHttpRedirects := 12
    static WinHttpRequestOption_EnablePassportAuthentication := 13
    static WinHttpRequestOption_MaxAutomaticRedirects := 14
    static WinHttpRequestOption_MaxResponseHeaderSize := 15
    static WinHttpRequestOption_MaxResponseDrainSize := 16
    static WinHttpRequestOption_EnableHttp1_1 := 17
    static WinHttpRequestOption_EnableCertificateRevocationCheck := 18
    static WinHttpRequestOption_RejectUserpwd := 19
}
struct WinHttpRequestAutoLogonPolicy extends Int32 {
    static AutoLogonPolicy_Always := 0
    static AutoLogonPolicy_OnlyIfBypassProxy := 1
    static AutoLogonPolicy_Never := 2
}
struct WinHttpRequestSslErrorFlags extends Int32 {
    static SslErrorFlag_UnknownCA := 256
    static SslErrorFlag_CertWrongUsage := 512
    static SslErrorFlag_CertCNInvalid := 4096
    static SslErrorFlag_CertDateInvalid := 8192
    static SslErrorFlag_Ignore_All := 13056
}
struct WinHttpRequestSecureProtocols extends Int32 {
    static SecureProtocol_SSL2 := 8
    static SecureProtocol_SSL3 := 32
    static SecureProtocol_TLS1 := 128
    static SecureProtocol_TLS1_1 := 512
    static SecureProtocol_TLS1_2 := 2048
    static SecureProtocol_ALL := 168
}
struct IWinHttpRequest extends IDispatch {
    static IID := "{016FE2EC-B2C8-45F8-B23B-39E53A75396B}"
    SetProxy(ProxySetting, ProxyServer, BypassList)
      => ComCall(7, this.p, Int32, ProxySetting, VARIANT, ProxyServer, VARIANT, BypassList)
    SetCredentials(UserName, Password, Flags)
      => ComCall(8, this.p, BSTR, UserName, BSTR, Password, Int32, Flags)
    Open(Method, Url, Async)
      => ComCall(9, this.p, BSTR, Method, BSTR, Url, VARIANT, Async)
    SetRequestHeader(Header, Value)
      => ComCall(10, this.p, BSTR, Header, BSTR, Value)
    GetResponseHeader(Header, Value)
      => ComCall(11, this.p, BSTR, Header, BSTR.Ptr, Value)
    GetAllResponseHeaders(Headers)
      => ComCall(12, this.p, BSTR.Ptr, Headers)
    Send(Body)
      => ComCall(13, this.p, VARIANT, Body)
    get_Status(Status)
      => ComCall(14, this.p, Int32.Ptr, Status)
    get_StatusText(Status)
      => ComCall(15, this.p, BSTR.Ptr, Status)
    get_ResponseText(Body)
      => ComCall(16, this.p, BSTR.Ptr, Body)
    get_ResponseBody(Body)
      => ComCall(17, this.p, VARIANT.Ptr, Body)
    get_ResponseStream(Body)
      => ComCall(18, this.p, VARIANT.Ptr, Body)
    get_Option(Option, Value)
      => ComCall(19, this.p, WinHttpRequestOption, Option, VARIANT.Ptr, Value)
    put_Option(Option, Value)
      => ComCall(20, this.p, WinHttpRequestOption, Option, VARIANT, Value)
    WaitForResponse(Timeout, Succeeded)
      => ComCall(21, this.p, VARIANT, Timeout, VARIANT_BOOL.Ptr, Succeeded)
    Abort()
      => ComCall(22, this.p)
    SetTimeouts(ResolveTimeout, ConnectTimeout, SendTimeout, ReceiveTimeout)
      => ComCall(23, this.p, Int32, ResolveTimeout, Int32, ConnectTimeout, Int32, SendTimeout, Int32, ReceiveTimeout)
    SetClientCertificate(ClientCertificate)
      => ComCall(24, this.p, BSTR, ClientCertificate)
    SetAutoLogonPolicy(AutoLogonPolicy)
      => ComCall(25, this.p, WinHttpRequestAutoLogonPolicy, AutoLogonPolicy)
}
struct IWinHttpRequestEvents extends IUnknown {
    static IID := "{F97F4E15-B787-4212-80D1-D380CBBF982E}"
    OnResponseStart(Status, ContentType)
      => ComCall(3, this.p, Int32, Status, BSTR, ContentType, "void")
    OnResponseDataAvailable(Data)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, Data, "void")
    OnResponseFinished()
      => ComCall(5, this.p, "void")
    OnError(ErrorNumber, ErrorDescription)
      => ComCall(6, this.p, Int32, ErrorNumber, BSTR, ErrorDescription, "void")
}
