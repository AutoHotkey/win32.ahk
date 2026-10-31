#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HANDLE, HRESULT, PSTR, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {SOCKADDR, SOCKADDR_STORAGE}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR}

struct HTTP_RECEIVE_HTTP_REQUEST_FLAGS extends UInt32 {
    static HTTP_RECEIVE_REQUEST_FLAG_COPY_BODY := 1
    static HTTP_RECEIVE_REQUEST_FLAG_FLUSH_BODY := 2
}
struct HTTP_INITIALIZE extends UInt32 {
    static HTTP_INITIALIZE_CONFIG := 2
    static HTTP_INITIALIZE_SERVER := 1
}
struct HTTP_REQUEST_QUEUE_HANDLE {
    Value : Struct.Ptr
}
struct HTTP_SERVER_PROPERTY extends Int32 {
    static HttpServerAuthenticationProperty := 0
    static HttpServerLoggingProperty := 1
    static HttpServerQosProperty := 2
    static HttpServerTimeoutsProperty := 3
    static HttpServerQueueLengthProperty := 4
    static HttpServerStateProperty := 5
    static HttpServer503VerbosityProperty := 6
    static HttpServerBindingProperty := 7
    static HttpServerExtendedAuthenticationProperty := 8
    static HttpServerListenEndpointProperty := 9
    static HttpServerChannelBindProperty := 10
    static HttpServerProtectionLevelProperty := 11
    static HttpServerDelegationProperty := 16
    static HttpServerFastForwardingProperty := 18
    static HttpServerRequestInfoProperty := 19
}
struct HTTP_PROPERTY_FLAGS {
    _bitfield : UInt32
}
struct HTTP_ENABLED_STATE extends Int32 {
    static HttpEnabledStateActive := 0
    static HttpEnabledStateInactive := 1
}
struct HTTP_STATE_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    State : HTTP_ENABLED_STATE
}
struct HTTP_503_RESPONSE_VERBOSITY extends Int32 {
    static Http503ResponseVerbosityBasic := 0
    static Http503ResponseVerbosityLimited := 1
    static Http503ResponseVerbosityFull := 2
}
struct HTTP_QOS_SETTING_TYPE extends Int32 {
    static HttpQosSettingTypeBandwidth := 0
    static HttpQosSettingTypeConnectionLimit := 1
    static HttpQosSettingTypeFlowRate := 2
}
struct HTTP_QOS_SETTING_INFO {
    QosType : HTTP_QOS_SETTING_TYPE
    QosSetting : Struct.Ptr
}
struct HTTP_CONNECTION_LIMIT_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    MaxConnections : UInt32
}
struct HTTP_BANDWIDTH_LIMIT_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    MaxBandwidth : UInt32
}
struct HTTP_FLOWRATE_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    MaxBandwidth : UInt32
    MaxPeakBandwidth : UInt32
    BurstSize : UInt32
}
struct HTTP_SERVICE_CONFIG_TIMEOUT_KEY extends Int32 {
    static IdleConnectionTimeout := 0
    static HeaderWaitTimeout := 1
}
struct HTTP_SERVICE_CONFIG_TIMEOUT_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_TIMEOUT_KEY
    ParamDesc : UInt16
}
struct HTTP_TIMEOUT_LIMIT_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    EntityBody : UInt16
    DrainEntityBody : UInt16
    RequestQueue : UInt16
    IdleConnection : UInt16
    HeaderWait : UInt16
    MinSendRate : UInt32
}
struct HTTP_SERVICE_CONFIG_SETTING_KEY extends Int32 {
    static HttpNone := 0
    static HttpTlsThrottle := 1
}
struct HTTP_SERVICE_CONFIG_SETTING_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_SETTING_KEY
    ParamDesc : UInt32
}
struct HTTP_LISTEN_ENDPOINT_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    EnableSharing : BOOLEAN
}
struct HTTP_FAST_FORWARD_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    EnableFastForwarding : BOOLEAN
}
struct HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS {
    DomainNameLength : UInt16
    DomainName : PWSTR
    RealmLength : UInt16
    Realm : PWSTR
}
struct HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS {
    RealmLength : UInt16
    Realm : PWSTR
}
struct HTTP_SERVER_AUTHENTICATION_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    AuthSchemes : UInt32
    ReceiveMutualAuth : BOOLEAN
    ReceiveContextHandle : BOOLEAN
    DisableNTLMCredentialCaching : BOOLEAN
    ExFlags : UInt8
    DigestParams : HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
    BasicParams : HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
}
struct HTTP_SERVICE_BINDING_TYPE extends Int32 {
    static HttpServiceBindingTypeNone := 0
    static HttpServiceBindingTypeW := 1
    static HttpServiceBindingTypeA := 2
}
struct HTTP_SERVICE_BINDING_BASE {
    Type : HTTP_SERVICE_BINDING_TYPE
}
struct HTTP_SERVICE_BINDING_A {
    Base : HTTP_SERVICE_BINDING_BASE
    Buffer : PSTR
    BufferSize : UInt32
}
struct HTTP_SERVICE_BINDING_W {
    Base : HTTP_SERVICE_BINDING_BASE
    Buffer : PWSTR
    BufferSize : UInt32
}
struct HTTP_AUTHENTICATION_HARDENING_LEVELS extends Int32 {
    static HttpAuthenticationHardeningLegacy := 0
    static HttpAuthenticationHardeningMedium := 1
    static HttpAuthenticationHardeningStrict := 2
}
struct HTTP_CHANNEL_BIND_INFO {
    Hardening : HTTP_AUTHENTICATION_HARDENING_LEVELS
    Flags : UInt32
    ServiceNames : HTTP_SERVICE_BINDING_BASE.Ptr.Ptr
    NumberOfServiceNames : UInt32
}
struct HTTP_REQUEST_CHANNEL_BIND_STATUS {
    ServiceName : HTTP_SERVICE_BINDING_BASE.Ptr
    ChannelToken : UInt8.Ptr
    ChannelTokenSize : UInt32
    Flags : UInt32
}
struct HTTP_REQUEST_TOKEN_BINDING_INFO {
    TokenBinding : UInt8.Ptr
    TokenBindingSize : UInt32
    EKM : UInt8.Ptr
    EKMSize : UInt32
    KeyType : UInt8
}
struct HTTP_LOGGING_TYPE extends Int32 {
    static HttpLoggingTypeW3C := 0
    static HttpLoggingTypeIIS := 1
    static HttpLoggingTypeNCSA := 2
    static HttpLoggingTypeRaw := 3
}
struct HTTP_LOGGING_ROLLOVER_TYPE extends Int32 {
    static HttpLoggingRolloverSize := 0
    static HttpLoggingRolloverDaily := 1
    static HttpLoggingRolloverWeekly := 2
    static HttpLoggingRolloverMonthly := 3
    static HttpLoggingRolloverHourly := 4
}
struct HTTP_LOGGING_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    LoggingFlags : UInt32
    SoftwareName : PWSTR
    SoftwareNameLength : UInt16
    DirectoryNameLength : UInt16
    DirectoryName : PWSTR
    Format : HTTP_LOGGING_TYPE
    Fields : UInt32
    pExtFields : Struct.Ptr
    NumOfExtFields : UInt16
    MaxRecordSize : UInt16
    RolloverType : HTTP_LOGGING_ROLLOVER_TYPE
    RolloverSize : UInt32
    pSecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct HTTP_BINDING_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    RequestQueueHandle : HANDLE
}
struct HTTP_PROTECTION_LEVEL_TYPE extends Int32 {
    static HttpProtectionLevelUnrestricted := 0
    static HttpProtectionLevelEdgeRestricted := 1
    static HttpProtectionLevelRestricted := 2
}
struct HTTP_PROTECTION_LEVEL_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    Level : HTTP_PROTECTION_LEVEL_TYPE
}
struct HTTP_REQUEST_INFO_PROPERTY_INFO {
    Flags : HTTP_PROPERTY_FLAGS
    RequestInfoFlags : Int64
}
struct HTTP_BYTE_RANGE {
    StartingOffset : Int64
    Length : Int64
}
struct HTTP_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct HTTP_SCHEME extends Int32 {
    static HttpSchemeHttp := 0
    static HttpSchemeHttps := 1
    static HttpSchemeMaximum := 2
}
struct HTTP_VERB extends Int32 {
    static HttpVerbUnparsed := 0
    static HttpVerbUnknown := 1
    static HttpVerbInvalid := 2
    static HttpVerbOPTIONS := 3
    static HttpVerbGET := 4
    static HttpVerbHEAD := 5
    static HttpVerbPOST := 6
    static HttpVerbPUT := 7
    static HttpVerbDELETE := 8
    static HttpVerbTRACE := 9
    static HttpVerbCONNECT := 10
    static HttpVerbTRACK := 11
    static HttpVerbMOVE := 12
    static HttpVerbCOPY := 13
    static HttpVerbPROPFIND := 14
    static HttpVerbPROPPATCH := 15
    static HttpVerbMKCOL := 16
    static HttpVerbLOCK := 17
    static HttpVerbUNLOCK := 18
    static HttpVerbSEARCH := 19
    static HttpVerbMaximum := 20
}
struct HTTP_HEADER_ID extends Int32 {
    static HttpHeaderCacheControl := 0
    static HttpHeaderConnection := 1
    static HttpHeaderDate := 2
    static HttpHeaderKeepAlive := 3
    static HttpHeaderPragma := 4
    static HttpHeaderTrailer := 5
    static HttpHeaderTransferEncoding := 6
    static HttpHeaderUpgrade := 7
    static HttpHeaderVia := 8
    static HttpHeaderWarning := 9
    static HttpHeaderAllow := 10
    static HttpHeaderContentLength := 11
    static HttpHeaderContentType := 12
    static HttpHeaderContentEncoding := 13
    static HttpHeaderContentLanguage := 14
    static HttpHeaderContentLocation := 15
    static HttpHeaderContentMd5 := 16
    static HttpHeaderContentRange := 17
    static HttpHeaderExpires := 18
    static HttpHeaderLastModified := 19
    static HttpHeaderAccept := 20
    static HttpHeaderAcceptCharset := 21
    static HttpHeaderAcceptEncoding := 22
    static HttpHeaderAcceptLanguage := 23
    static HttpHeaderAuthorization := 24
    static HttpHeaderCookie := 25
    static HttpHeaderExpect := 26
    static HttpHeaderFrom := 27
    static HttpHeaderHost := 28
    static HttpHeaderIfMatch := 29
    static HttpHeaderIfModifiedSince := 30
    static HttpHeaderIfNoneMatch := 31
    static HttpHeaderIfRange := 32
    static HttpHeaderIfUnmodifiedSince := 33
    static HttpHeaderMaxForwards := 34
    static HttpHeaderProxyAuthorization := 35
    static HttpHeaderReferer := 36
    static HttpHeaderRange := 37
    static HttpHeaderTe := 38
    static HttpHeaderTranslate := 39
    static HttpHeaderUserAgent := 40
    static HttpHeaderRequestMaximum := 41
    static HttpHeaderAcceptRanges := 20
    static HttpHeaderAge := 21
    static HttpHeaderEtag := 22
    static HttpHeaderLocation := 23
    static HttpHeaderProxyAuthenticate := 24
    static HttpHeaderRetryAfter := 25
    static HttpHeaderServer := 26
    static HttpHeaderSetCookie := 27
    static HttpHeaderVary := 28
    static HttpHeaderWwwAuthenticate := 29
    static HttpHeaderResponseMaximum := 30
    static HttpHeaderMaximum := 41
}
struct HTTP_KNOWN_HEADER {
    RawValueLength : UInt16
    pRawValue : PSTR
}
struct HTTP_UNKNOWN_HEADER {
    NameLength : UInt16
    RawValueLength : UInt16
    pName : PSTR
    pRawValue : PSTR
}
struct HTTP_LOG_DATA_TYPE extends Int32 {
    static HttpLogDataTypeFields := 0
}
struct HTTP_LOG_DATA {
    Type : HTTP_LOG_DATA_TYPE
}
struct HTTP_LOG_FIELDS_DATA {
    Base : HTTP_LOG_DATA
    UserNameLength : UInt16
    UriStemLength : UInt16
    ClientIpLength : UInt16
    ServerNameLength : UInt16
    ServiceNameLength : UInt16
    ServerIpLength : UInt16
    MethodLength : UInt16
    UriQueryLength : UInt16
    HostLength : UInt16
    UserAgentLength : UInt16
    CookieLength : UInt16
    ReferrerLength : UInt16
    UserName : PWSTR
    UriStem : PWSTR
    ClientIp : PSTR
    ServerName : PSTR
    ServiceName : PSTR
    ServerIp : PSTR
    Method : PSTR
    UriQuery : PSTR
    Host : PSTR
    UserAgent : PSTR
    Cookie : PSTR
    Referrer : PSTR
    ServerPort : UInt16
    ProtocolStatus : UInt16
    Win32Status : UInt32
    MethodNum : HTTP_VERB
    SubStatus : UInt16
}
struct HTTP_WINHTTP_FAST_FORWARDING_DATA {
    Reserved : UInt8[16]
}
struct HTTP_DATA_CHUNK_TYPE extends Int32 {
    static HttpDataChunkFromMemory := 0
    static HttpDataChunkFromFileHandle := 1
    static HttpDataChunkFromFragmentCache := 2
    static HttpDataChunkFromFragmentCacheEx := 3
    static HttpDataChunkTrailers := 4
    static HttpDataChunkFromWinHttpFastForwarding := 5
    static HttpDataChunkMaximum := 6
}
struct HTTP_DATA_CHUNK {
    DataChunkType : HTTP_DATA_CHUNK_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FromMemory : this._FromMemory_e__Struct
            FromFileHandle : this._FromFileHandle_e__Struct
            FromFragmentCache : this._FromFragmentCache_e__Struct
            FromFragmentCacheEx : this._FromFragmentCacheEx_e__Struct
            Trailers : this._Trailers_e__Struct
            FromWinHttpFastForwarding : this._FromWinHttpFastForwarding_e__Struct
        }
        struct _FromMemory_e__Struct {
            pBuffer : Struct.Ptr
            BufferLength : UInt32
        }
        struct _FromFileHandle_e__Struct {
            ByteRange : HTTP_BYTE_RANGE
            FileHandle : HANDLE
        }
        struct _FromFragmentCache_e__Struct {
            FragmentNameLength : UInt16
            pFragmentName : PWSTR
        }
        struct _FromFragmentCacheEx_e__Struct {
            ByteRange : HTTP_BYTE_RANGE
            pFragmentName : PWSTR
        }
        struct _Trailers_e__Struct {
            TrailerCount : UInt16
            pTrailers : HTTP_UNKNOWN_HEADER.Ptr
        }
        struct _FromWinHttpFastForwarding_e__Struct {
            WhFastForwardingData : HTTP_WINHTTP_FAST_FORWARDING_DATA
        }
    }
}
struct HTTP_REQUEST_HEADERS {
    UnknownHeaderCount : UInt16
    pUnknownHeaders : HTTP_UNKNOWN_HEADER.Ptr
    TrailerCount : UInt16
    pTrailers : HTTP_UNKNOWN_HEADER.Ptr
    KnownHeaders : HTTP_KNOWN_HEADER[41]
}
struct HTTP_RESPONSE_HEADERS {
    UnknownHeaderCount : UInt16
    pUnknownHeaders : HTTP_UNKNOWN_HEADER.Ptr
    TrailerCount : UInt16
    pTrailers : HTTP_UNKNOWN_HEADER.Ptr
    KnownHeaders : HTTP_KNOWN_HEADER[30]
}
struct HTTP_DELEGATE_REQUEST_PROPERTY_ID extends Int32 {
    static DelegateRequestReservedProperty := 0
    static DelegateRequestDelegateUrlProperty := 1
}
struct HTTP_DELEGATE_REQUEST_PROPERTY_INFO {
    PropertyId : HTTP_DELEGATE_REQUEST_PROPERTY_ID
    PropertyInfoLength : UInt32
    PropertyInfo : Struct.Ptr
}
struct HTTP_CREATE_REQUEST_QUEUE_PROPERTY_ID extends Int32 {
    static CreateRequestQueueExternalIdProperty := 1
    static CreateRequestQueueMax := 2
}
struct HTTP_CREATE_REQUEST_QUEUE_PROPERTY_INFO {
    PropertyId : HTTP_CREATE_REQUEST_QUEUE_PROPERTY_ID
    PropertyInfoLength : UInt32
    PropertyInfo : Struct.Ptr
}
struct HTTP_TRANSPORT_ADDRESS {
    pRemoteAddress : SOCKADDR.Ptr
    pLocalAddress : SOCKADDR.Ptr
}
struct HTTP_COOKED_URL {
    FullUrlLength : UInt16
    HostLength : UInt16
    AbsPathLength : UInt16
    QueryStringLength : UInt16
    pFullUrl : PWSTR
    pHost : PWSTR
    pAbsPath : PWSTR
    pQueryString : PWSTR
}
struct HTTP_AUTH_STATUS extends Int32 {
    static HttpAuthStatusSuccess := 0
    static HttpAuthStatusNotAuthenticated := 1
    static HttpAuthStatusFailure := 2
}
struct HTTP_REQUEST_AUTH_TYPE extends Int32 {
    static HttpRequestAuthTypeNone := 0
    static HttpRequestAuthTypeBasic := 1
    static HttpRequestAuthTypeDigest := 2
    static HttpRequestAuthTypeNTLM := 3
    static HttpRequestAuthTypeNegotiate := 4
    static HttpRequestAuthTypeKerberos := 5
}
struct HTTP_SSL_CLIENT_CERT_INFO {
    CertFlags : UInt32
    CertEncodedSize : UInt32
    pCertEncoded : UInt8.Ptr
    Token : HANDLE
    CertDeniedByMapper : BOOLEAN
}
struct HTTP_SSL_INFO {
    ServerCertKeySize : UInt16
    ConnectionKeySize : UInt16
    ServerCertIssuerSize : UInt32
    ServerCertSubjectSize : UInt32
    pServerCertIssuer : PSTR
    pServerCertSubject : PSTR
    pClientCertInfo : HTTP_SSL_CLIENT_CERT_INFO.Ptr
    SslClientCertNegotiated : UInt32
}
struct HTTP_SSL_PROTOCOL_INFO {
    Protocol : UInt32
    CipherType : UInt32
    CipherStrength : UInt32
    HashType : UInt32
    HashStrength : UInt32
    KeyExchangeType : UInt32
    KeyExchangeStrength : UInt32
}
struct HTTP_REQUEST_SIZING_TYPE extends Int32 {
    static HttpRequestSizingTypeTlsHandshakeLeg1ClientData := 0
    static HttpRequestSizingTypeTlsHandshakeLeg1ServerData := 1
    static HttpRequestSizingTypeTlsHandshakeLeg2ClientData := 2
    static HttpRequestSizingTypeTlsHandshakeLeg2ServerData := 3
    static HttpRequestSizingTypeHeaders := 4
    static HttpRequestSizingTypeMax := 5
}
struct HTTP_REQUEST_SIZING_INFO {
    Flags : Int64
    RequestIndex : UInt32
    RequestSizingCount : UInt32
    RequestSizing : Int64[5]
}
struct HTTP_REQUEST_TIMING_TYPE extends Int32 {
    static HttpRequestTimingTypeConnectionStart := 0
    static HttpRequestTimingTypeDataStart := 1
    static HttpRequestTimingTypeTlsCertificateLoadStart := 2
    static HttpRequestTimingTypeTlsCertificateLoadEnd := 3
    static HttpRequestTimingTypeTlsHandshakeLeg1Start := 4
    static HttpRequestTimingTypeTlsHandshakeLeg1End := 5
    static HttpRequestTimingTypeTlsHandshakeLeg2Start := 6
    static HttpRequestTimingTypeTlsHandshakeLeg2End := 7
    static HttpRequestTimingTypeTlsAttributesQueryStart := 8
    static HttpRequestTimingTypeTlsAttributesQueryEnd := 9
    static HttpRequestTimingTypeTlsClientCertQueryStart := 10
    static HttpRequestTimingTypeTlsClientCertQueryEnd := 11
    static HttpRequestTimingTypeHttp2StreamStart := 12
    static HttpRequestTimingTypeHttp2HeaderDecodeStart := 13
    static HttpRequestTimingTypeHttp2HeaderDecodeEnd := 14
    static HttpRequestTimingTypeRequestHeaderParseStart := 15
    static HttpRequestTimingTypeRequestHeaderParseEnd := 16
    static HttpRequestTimingTypeRequestRoutingStart := 17
    static HttpRequestTimingTypeRequestRoutingEnd := 18
    static HttpRequestTimingTypeRequestQueuedForInspection := 19
    static HttpRequestTimingTypeRequestDeliveredForInspection := 20
    static HttpRequestTimingTypeRequestReturnedAfterInspection := 21
    static HttpRequestTimingTypeRequestQueuedForDelegation := 22
    static HttpRequestTimingTypeRequestDeliveredForDelegation := 23
    static HttpRequestTimingTypeRequestReturnedAfterDelegation := 24
    static HttpRequestTimingTypeRequestQueuedForIO := 25
    static HttpRequestTimingTypeRequestDeliveredForIO := 26
    static HttpRequestTimingTypeHttp3StreamStart := 27
    static HttpRequestTimingTypeHttp3HeaderDecodeStart := 28
    static HttpRequestTimingTypeHttp3HeaderDecodeEnd := 29
    static HttpRequestTimingTypeMax := 30
}
struct HTTP_REQUEST_TIMING_INFO {
    RequestTimingCount : UInt32
    RequestTiming : Int64[30]
}
struct HTTP_REQUEST_TRANSPORT_IDLE_CONNECTION_TIMEOUT_INFO {
    TransportIdleConnectionTimeout : UInt16
}
struct HTTP_REQUEST_DSCP_INFO {
    DscpTag : UInt8
}
struct HTTP_REQUEST_INITIAL_PACKET_TTL_INFO {
    InitialPacketTtl : UInt8
}
struct HTTP_REQUEST_INFO_TYPE extends Int32 {
    static HttpRequestInfoTypeAuth := 0
    static HttpRequestInfoTypeChannelBind := 1
    static HttpRequestInfoTypeSslProtocol := 2
    static HttpRequestInfoTypeSslTokenBindingDraft := 3
    static HttpRequestInfoTypeSslTokenBinding := 4
    static HttpRequestInfoTypeRequestTiming := 5
    static HttpRequestInfoTypeTcpInfoV0 := 6
    static HttpRequestInfoTypeRequestSizing := 7
    static HttpRequestInfoTypeQuicStats := 8
    static HttpRequestInfoTypeTcpInfoV1 := 9
    static HttpRequestInfoTypeQuicStatsV2 := 10
    static HttpRequestInfoTypeTcpInfoV2 := 11
    static HttpRequestInfoTypeTransportIdleConnectionTimeout := 12
    static HttpRequestInfoTypeDscpTag := 13
    static HttpRequestInfoTypeInitialPacketTtl := 14
}
struct HTTP_REQUEST_INFO {
    InfoType : HTTP_REQUEST_INFO_TYPE
    InfoLength : UInt32
    pInfo : Struct.Ptr
}
struct HTTP_REQUEST_AUTH_INFO {
    AuthStatus : HTTP_AUTH_STATUS
    SecStatus : HRESULT
    Flags : UInt32
    AuthType : HTTP_REQUEST_AUTH_TYPE
    AccessToken : HANDLE
    ContextAttributes : UInt32
    PackedContextLength : UInt32
    PackedContextType : UInt32
    PackedContext : Struct.Ptr
    MutualAuthDataLength : UInt32
    pMutualAuthData : PSTR
    PackageNameLength : UInt16
    pPackageName : PWSTR
}
struct HTTP_REQUEST_V1 {
    Flags : UInt32
    ConnectionId : Int64
    RequestId : Int64
    UrlContext : Int64
    Version : HTTP_VERSION
    Verb : HTTP_VERB
    UnknownVerbLength : UInt16
    RawUrlLength : UInt16
    pUnknownVerb : PSTR
    pRawUrl : PSTR
    CookedUrl : HTTP_COOKED_URL
    Address : HTTP_TRANSPORT_ADDRESS
    Headers : HTTP_REQUEST_HEADERS
    BytesReceived : Int64
    EntityChunkCount : UInt16
    pEntityChunks : HTTP_DATA_CHUNK.Ptr
    RawConnectionId : Int64
    pSslInfo : HTTP_SSL_INFO.Ptr
}
struct HTTP_REQUEST_V2 {
    Base : HTTP_REQUEST_V1
    RequestInfoCount : UInt16
    pRequestInfo : HTTP_REQUEST_INFO.Ptr
}
struct HTTP_RESPONSE_V1 {
    Flags : UInt32
    Version : HTTP_VERSION
    StatusCode : UInt16
    ReasonLength : UInt16
    pReason : PSTR
    Headers : HTTP_RESPONSE_HEADERS
    EntityChunkCount : UInt16
    pEntityChunks : HTTP_DATA_CHUNK.Ptr
}
struct HTTP_RESPONSE_INFO_TYPE extends Int32 {
    static HttpResponseInfoTypeMultipleKnownHeaders := 0
    static HttpResponseInfoTypeAuthenticationProperty := 1
    static HttpResponseInfoTypeQoSProperty := 2
    static HttpResponseInfoTypeChannelBind := 3
}
struct HTTP_RESPONSE_INFO {
    Type : HTTP_RESPONSE_INFO_TYPE
    Length : UInt32
    pInfo : Struct.Ptr
}
struct HTTP_MULTIPLE_KNOWN_HEADERS {
    HeaderId : HTTP_HEADER_ID
    Flags : UInt32
    KnownHeaderCount : UInt16
    KnownHeaders : HTTP_KNOWN_HEADER.Ptr
}
struct HTTP_RESPONSE_V2 {
    Base : HTTP_RESPONSE_V1
    ResponseInfoCount : UInt16
    pResponseInfo : HTTP_RESPONSE_INFO.Ptr
}
struct HTTPAPI_VERSION {
    HttpApiMajorVersion : UInt16
    HttpApiMinorVersion : UInt16
}
struct HTTP_CACHE_POLICY_TYPE extends Int32 {
    static HttpCachePolicyNocache := 0
    static HttpCachePolicyUserInvalidates := 1
    static HttpCachePolicyTimeToLive := 2
    static HttpCachePolicyMaximum := 3
}
struct HTTP_CACHE_POLICY {
    Policy : HTTP_CACHE_POLICY_TYPE
    SecondsToLive : UInt32
}
struct HTTP_SERVICE_CONFIG_ID extends Int32 {
    static HttpServiceConfigIPListenList := 0
    static HttpServiceConfigSSLCertInfo := 1
    static HttpServiceConfigUrlAclInfo := 2
    static HttpServiceConfigTimeout := 3
    static HttpServiceConfigCache := 4
    static HttpServiceConfigSslSniCertInfo := 5
    static HttpServiceConfigSslCcsCertInfo := 6
    static HttpServiceConfigSetting := 7
    static HttpServiceConfigSslCertInfoEx := 8
    static HttpServiceConfigSslSniCertInfoEx := 9
    static HttpServiceConfigSslCcsCertInfoEx := 10
    static HttpServiceConfigSslScopedCcsCertInfo := 11
    static HttpServiceConfigSslScopedCcsCertInfoEx := 12
    static HttpServiceConfigMax := 13
}
struct HTTP_SERVICE_CONFIG_QUERY_TYPE extends Int32 {
    static HttpServiceConfigQueryExact := 0
    static HttpServiceConfigQueryNext := 1
    static HttpServiceConfigQueryMax := 2
}
struct HTTP_SERVICE_CONFIG_SSL_KEY {
    pIpPort : SOCKADDR.Ptr
}
struct HTTP_SERVICE_CONFIG_SSL_KEY_EX {
    IpPort : SOCKADDR_STORAGE
}
struct HTTP_SERVICE_CONFIG_SSL_SNI_KEY {
    IpPort : SOCKADDR_STORAGE
    Host : PWSTR
}
struct HTTP_SERVICE_CONFIG_SSL_CCS_KEY {
    LocalAddress : SOCKADDR_STORAGE
}
struct HTTP_SERVICE_CONFIG_SSL_PARAM {
    SslHashLength : UInt32
    pSslHash : Struct.Ptr
    AppId : GUID
    pSslCertStoreName : PWSTR
    DefaultCertCheckMode : UInt32
    DefaultRevocationFreshnessTime : UInt32
    DefaultRevocationUrlRetrievalTimeout : UInt32
    pDefaultSslCtlIdentifier : PWSTR
    pDefaultSslCtlStoreName : PWSTR
    DefaultFlags : UInt32
}
struct HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE extends Int32 {
    static ExParamTypeHttp2Window := 0
    static ExParamTypeHttp2SettingsLimits := 1
    static ExParamTypeHttpPerformance := 2
    static ExParamTypeTlsRestrictions := 3
    static ExParamTypeErrorHeaders := 4
    static ExParamTypeTlsSessionTicketKeys := 5
    static ExParamTypeCertConfig := 6
    static ExParamTypeMax := 7
}
struct HTTP2_WINDOW_SIZE_PARAM {
    Http2ReceiveWindowSize : UInt32
}
struct HTTP2_SETTINGS_LIMITS_PARAM {
    Http2MaxSettingsPerFrame : UInt32
    Http2MaxSettingsPerMinute : UInt32
}
struct HTTP_PERFORMANCE_PARAM_TYPE extends Int32 {
    static PerformanceParamSendBufferingFlags := 0
    static PerformanceParamAggressiveICW := 1
    static PerformanceParamMaxSendBufferSize := 2
    static PerformanceParamMaxConcurrentClientStreams := 3
    static PerformanceParamMaxReceiveBufferSize := 4
    static PerformanceParamDecryptOnSspiThread := 5
    static PerformanceParamMax := 6
}
struct HTTP_PERFORMANCE_PARAM {
    Type : HTTP_PERFORMANCE_PARAM_TYPE
    BufferSize : UInt32
    Buffer : Struct.Ptr
}
struct HTTP_TLS_RESTRICTIONS_PARAM {
    RestrictionCount : UInt32
    TlsRestrictions : Struct.Ptr
}
struct HTTP_ERROR_HEADERS_PARAM {
    StatusCode : UInt16
    HeaderCount : UInt16
    Headers : HTTP_UNKNOWN_HEADER.Ptr
}
struct HTTP_TLS_SESSION_TICKET_KEYS_PARAM {
    SessionTicketKeyCount : UInt32
    SessionTicketKeys : Struct.Ptr
}
struct HTTP_CERT_CONFIG_ENTRY {
    CertHash : UInt8[20]
    CertStoreName : UInt16[128]
}
struct HTTP_CERT_CONFIG_PARAM {
    CertConfigCount : UInt32
    CertConfigs : HTTP_CERT_CONFIG_ENTRY.Ptr
}
struct HTTP_SERVICE_CONFIG_SSL_PARAM_EX {
    ParamType : HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE
    Flags : Int64
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Http2WindowSizeParam : HTTP2_WINDOW_SIZE_PARAM
            Http2SettingsLimitsParam : HTTP2_SETTINGS_LIMITS_PARAM
            HttpPerformanceParam : HTTP_PERFORMANCE_PARAM
            HttpTlsRestrictionsParam : HTTP_TLS_RESTRICTIONS_PARAM
            HttpErrorHeadersParam : HTTP_ERROR_HEADERS_PARAM
            HttpTlsSessionTicketKeysParam : HTTP_TLS_SESSION_TICKET_KEYS_PARAM
            HttpCertConfigParam : HTTP_CERT_CONFIG_PARAM
        }
    }
}
struct HTTP_SERVICE_CONFIG_SSL_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM
}
struct HTTP_SERVICE_CONFIG_SSL_SNI_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_SNI_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM
}
struct HTTP_SERVICE_CONFIG_SSL_CCS_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_CCS_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM
}
struct HTTP_SERVICE_CONFIG_SSL_SET_EX {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_KEY_EX
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM_EX
}
struct HTTP_SERVICE_CONFIG_SSL_SNI_SET_EX {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_SNI_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM_EX
}
struct HTTP_SERVICE_CONFIG_SSL_CCS_SET_EX {
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_CCS_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_SSL_PARAM_EX
}
struct HTTP_SERVICE_CONFIG_SSL_QUERY {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_KEY
    dwToken : UInt32
}
struct HTTP_SERVICE_CONFIG_SSL_SNI_QUERY {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_SNI_KEY
    dwToken : UInt32
}
struct HTTP_SERVICE_CONFIG_SSL_CCS_QUERY {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_CCS_KEY
    dwToken : UInt32
}
struct HTTP_SERVICE_CONFIG_SSL_QUERY_EX {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_KEY_EX
    dwToken : UInt32
    ParamType : HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE
}
struct HTTP_SERVICE_CONFIG_SSL_SNI_QUERY_EX {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_SNI_KEY
    dwToken : UInt32
    ParamType : HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE
}
struct HTTP_SERVICE_CONFIG_SSL_CCS_QUERY_EX {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_SSL_CCS_KEY
    dwToken : UInt32
    ParamType : HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE
}
struct HTTP_SERVICE_CONFIG_IP_LISTEN_PARAM {
    AddrLength : UInt16
    pAddress : SOCKADDR.Ptr
}
struct HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY {
    AddrCount : UInt32
    AddrList : SOCKADDR_STORAGE[1]
}
struct HTTP_SERVICE_CONFIG_URLACL_KEY {
    pUrlPrefix : PWSTR
}
struct HTTP_SERVICE_CONFIG_URLACL_PARAM {
    pStringSecurityDescriptor : PWSTR
}
struct HTTP_SERVICE_CONFIG_URLACL_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_URLACL_KEY
    ParamDesc : HTTP_SERVICE_CONFIG_URLACL_PARAM
}
struct HTTP_SERVICE_CONFIG_URLACL_QUERY {
    QueryDesc : HTTP_SERVICE_CONFIG_QUERY_TYPE
    KeyDesc : HTTP_SERVICE_CONFIG_URLACL_KEY
    dwToken : UInt32
}
struct HTTP_SERVICE_CONFIG_CACHE_KEY extends Int32 {
    static MaxCacheResponseSize := 0
    static CacheRangeChunkSize := 1
}
struct HTTP_SERVICE_CONFIG_CACHE_SET {
    KeyDesc : HTTP_SERVICE_CONFIG_CACHE_KEY
    ParamDesc : UInt32
}
struct HTTP_REQUEST_PROPERTY extends Int32 {
    static HttpRequestPropertyIsb := 0
    static HttpRequestPropertyTcpInfoV0 := 1
    static HttpRequestPropertyQuicStats := 2
    static HttpRequestPropertyTcpInfoV1 := 3
    static HttpRequestPropertySni := 4
    static HttpRequestPropertyStreamError := 5
    static HttpRequestPropertyWskApiTimings := 6
    static HttpRequestPropertyQuicApiTimings := 7
    static HttpRequestPropertyQuicStatsV2 := 8
    static HttpRequestPropertyQuicStreamStats := 9
    static HttpRequestPropertyTcpInfoV2 := 10
    static HttpRequestPropertyTlsClientHello := 11
    static HttpRequestPropertyTransportIdleConnectionTimeout := 12
    static HttpRequestPropertyDscpTag := 13
    static HttpRequestPropertyTlsCipherInfo := 14
}
struct HTTP_QUERY_REQUEST_QUALIFIER_TCP {
    Freshness : Int64
}
struct HTTP_QUERY_REQUEST_QUALIFIER_QUIC {
    Freshness : Int64
}
struct HTTP_REQUEST_PROPERTY_SNI {
    Hostname : UInt16[256]
    Flags : UInt32
}
struct HTTP_REQUEST_PROPERTY_STREAM_ERROR {
    ErrorCode : UInt32
}
struct HTTP_WSK_API_TIMINGS {
    ConnectCount : Int64
    ConnectSum : Int64
    DisconnectCount : Int64
    DisconnectSum : Int64
    SendCount : Int64
    SendSum : Int64
    ReceiveCount : Int64
    ReceiveSum : Int64
    ReleaseCount : Int64
    ReleaseSum : Int64
    ControlSocketCount : Int64
    ControlSocketSum : Int64
}
struct HTTP_QUIC_STREAM_API_TIMINGS {
    OpenCount : Int64
    OpenSum : Int64
    CloseCount : Int64
    CloseSum : Int64
    StartCount : Int64
    StartSum : Int64
    ShutdownCount : Int64
    ShutdownSum : Int64
    SendCount : Int64
    SendSum : Int64
    ReceiveSetEnabledCount : Int64
    ReceiveSetEnabledSum : Int64
    GetParamCount : Int64
    GetParamSum : Int64
    SetParamCount : Int64
    SetParamSum : Int64
    SetCallbackHandlerCount : Int64
    SetCallbackHandlerSum : Int64
}
struct HTTP_QUIC_CONNECTION_API_TIMINGS {
    OpenTime : Int64
    CloseTime : Int64
    StartTime : Int64
    ShutdownTime : Int64
    SecConfigCreateTime : Int64
    SecConfigDeleteTime : Int64
    GetParamCount : Int64
    GetParamSum : Int64
    SetParamCount : Int64
    SetParamSum : Int64
    SetCallbackHandlerCount : Int64
    SetCallbackHandlerSum : Int64
    ControlStreamTimings : HTTP_QUIC_STREAM_API_TIMINGS
}
struct HTTP_QUIC_API_TIMINGS {
    ConnectionTimings : HTTP_QUIC_CONNECTION_API_TIMINGS
    StreamTimings : HTTP_QUIC_STREAM_API_TIMINGS
}
struct HTTP_QUIC_STREAM_REQUEST_STATS {
    StreamWaitStart : Int64
    StreamWaitEnd : Int64
    RequestHeadersCompressionStart : Int64
    RequestHeadersCompressionEnd : Int64
    ResponseHeadersDecompressionStart : Int64
    ResponseHeadersDecompressionEnd : Int64
    RequestHeadersCompressedSize : Int64
    ResponseHeadersCompressedSize : Int64
}
struct HTTP_FEATURE_ID extends Int32 {
    static HttpFeatureUnknown := 0
    static HttpFeatureResponseTrailers := 1
    static HttpFeatureApiTimings := 2
    static HttpFeatureDelegateEx := 3
    static HttpFeatureHttp3 := 4
    static HttpFeatureTlsSessionTickets := 5
    static HttpFeatureDisableTlsSessionId := 6
    static HttpFeatureTlsDualCerts := 7
    static HttpFeatureAutomaticChunkedEncoding := 8
    static HttpFeatureDedicatedReqQueueDelegationType := 9
    static HttpFeatureFastForwardResponse := 10
    static HttpFeatureCacheTlsClientHello := 11
    static HttpFeatureIdleConnectionTimeoutRequestProperty := 12
    static HttpFeatureDisableAiaFlag := 13
    static HttpFeatureDscp := 14
    static HttpFeatureQueryCipherInfo := 15
    static HttpFeatureQueryInitialPacketTtl := 16
    static HttpFeatureTlsHandshakePerformanceCounters := 17
    static HttpFeatureLast := 18
    static HttpFeaturemax := -1
}
