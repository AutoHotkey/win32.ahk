#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {SOCKADDR_STORAGE}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT, HCERTSTORE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct WSD_CONFIG_PARAM_TYPE extends Int32 {
    static WSD_CONFIG_MAX_INBOUND_MESSAGE_SIZE := 1
    static WSD_CONFIG_MAX_OUTBOUND_MESSAGE_SIZE := 2
    static WSD_SECURITY_SSL_CERT_FOR_CLIENT_AUTH := 3
    static WSD_SECURITY_SSL_SERVER_CERT_VALIDATION := 4
    static WSD_SECURITY_SSL_CLIENT_CERT_VALIDATION := 5
    static WSD_SECURITY_SSL_NEGOTIATE_CLIENT_CERT := 6
    static WSD_SECURITY_COMPACTSIG_SIGNING_CERT := 7
    static WSD_SECURITY_COMPACTSIG_VALIDATION := 8
    static WSD_CONFIG_HOSTING_ADDRESSES := 9
    static WSD_CONFIG_DEVICE_ADDRESSES := 10
    static WSD_SECURITY_REQUIRE_HTTP_CLIENT_AUTH := 11
    static WSD_SECURITY_REQUIRE_CLIENT_CERT_OR_HTTP_CLIENT_AUTH := 12
    static WSD_SECURITY_USE_HTTP_CLIENT_AUTH := 13
}
struct WSD_CONFIG_PARAM {
    configParamType : WSD_CONFIG_PARAM_TYPE
    pConfigData : Struct.Ptr
    dwConfigDataSize : UInt32
}
struct WSD_SECURITY_CERT_VALIDATION_V1 {
    certMatchArray : CERT_CONTEXT.Ptr.Ptr
    dwCertMatchArrayCount : UInt32
    hCertMatchStore : HCERTSTORE
    hCertIssuerStore : HCERTSTORE
    dwCertCheckOptions : UInt32
}
struct WSD_SECURITY_CERT_VALIDATION {
    certMatchArray : CERT_CONTEXT.Ptr.Ptr
    dwCertMatchArrayCount : UInt32
    hCertMatchStore : HCERTSTORE
    hCertIssuerStore : HCERTSTORE
    dwCertCheckOptions : UInt32
    pszCNGHashAlgId : PWSTR
    pbCertHash : UInt8.Ptr
    dwCertHashSize : UInt32
}
struct WSD_SECURITY_SIGNATURE_VALIDATION {
    signingCertArray : CERT_CONTEXT.Ptr.Ptr
    dwSigningCertArrayCount : UInt32
    hSigningCertStore : HCERTSTORE
    dwFlags : UInt32
}
struct WSD_CONFIG_ADDRESSES {
    addresses : IWSDAddress.Ptr
    dwAddressCount : UInt32
}
struct IWSDAddress extends IUnknown {
    static IID := "{B9574C6C-12A6-4F74-93A1-3318FF605759}"
    Serialize(pszBuffer, fSafe)
      => ComCall(3, this.p, PWSTR, pszBuffer, UInt32, pszBuffer.Length, BOOL, fSafe)
    Deserialize(pszBuffer)
      => ComCall(4, this.p, "Str", pszBuffer)
}
struct IWSDTransportAddress extends IWSDAddress {
    static IID := "{70D23498-4EE6-4340-A3DF-D845D2235467}"
    GetPort(pwPort)
      => ComCall(5, this.p, UInt16.Ptr, pwPort)
    SetPort(wPort)
      => ComCall(6, this.p, UInt16, wPort)
    GetTransportAddress(ppszAddress)
      => ComCall(7, this.p, PWSTR.Ptr, ppszAddress)
    GetTransportAddressEx(fSafe, ppszAddress)
      => ComCall(8, this.p, BOOL, fSafe, PWSTR.Ptr, ppszAddress)
    SetTransportAddress(pszAddress?)
      => ComCall(9, this.p, "Str", pszAddress?)
}
struct IWSDMessageParameters extends IUnknown {
    static IID := "{1FAFE8A2-E6FC-4B80-B6CF-B7D45C416D7C}"
    GetLocalAddress(ppAddress)
      => ComCall(3, this.p, IWSDAddress.Ptr, ppAddress)
    SetLocalAddress(pAddress)
      => ComCall(4, this.p, IWSDAddress, pAddress)
    GetRemoteAddress(ppAddress)
      => ComCall(5, this.p, IWSDAddress.Ptr, ppAddress)
    SetRemoteAddress(pAddress)
      => ComCall(6, this.p, IWSDAddress, pAddress)
    GetLowerParameters(ppTxParams)
      => ComCall(7, this.p, IWSDMessageParameters.Ptr, ppTxParams)
}
struct WSDUdpRetransmitParams {
    ulSendDelay : UInt32
    ulRepeat : UInt32
    ulRepeatMinDelay : UInt32
    ulRepeatMaxDelay : UInt32
    ulRepeatUpperDelay : UInt32
}
struct IWSDUdpMessageParameters extends IWSDMessageParameters {
    static IID := "{9934149F-8F0C-447B-AA0B-73124B0CA7F0}"
    SetRetransmitParams(pParams)
      => ComCall(8, this.p, WSDUdpRetransmitParams.Ptr, pParams)
    GetRetransmitParams(pParams)
      => ComCall(9, this.p, WSDUdpRetransmitParams.Ptr, pParams)
}
struct WSDUdpMessageType extends Int32 {
    static ONE_WAY := 0
    static TWO_WAY := 1
}
struct IWSDUdpAddress extends IWSDTransportAddress {
    static IID := "{74D6124A-A441-4F78-A1EB-97A8D1996893}"
    SetSockaddr(pSockAddr)
      => ComCall(10, this.p, SOCKADDR_STORAGE.Ptr, pSockAddr)
    GetSockaddr(pSockAddr)
      => ComCall(11, this.p, SOCKADDR_STORAGE.Ptr, pSockAddr)
    SetExclusive(fExclusive)
      => ComCall(12, this.p, BOOL, fExclusive)
    GetExclusive()
      => ComCall(13, this.p)
    SetMessageType(messageType)
      => ComCall(14, this.p, WSDUdpMessageType, messageType)
    GetMessageType(pMessageType)
      => ComCall(15, this.p, WSDUdpMessageType.Ptr, pMessageType)
    SetTTL(dwTTL)
      => ComCall(16, this.p, UInt32, dwTTL)
    GetTTL(pdwTTL)
      => ComCall(17, this.p, UInt32.Ptr, pdwTTL)
    SetAlias(pAlias)
      => ComCall(18, this.p, GUID.Ptr, pAlias)
    GetAlias(pAlias)
      => ComCall(19, this.p, GUID.Ptr, pAlias)
}
struct IWSDHttpMessageParameters extends IWSDMessageParameters {
    static IID := "{540BD122-5C83-4DEC-B396-EA62A2697FDF}"
    SetInboundHttpHeaders(pszHeaders?)
      => ComCall(8, this.p, "Str", pszHeaders?)
    GetInboundHttpHeaders(ppszHeaders)
      => ComCall(9, this.p, PWSTR.Ptr, ppszHeaders)
    SetOutboundHttpHeaders(pszHeaders?)
      => ComCall(10, this.p, "Str", pszHeaders?)
    GetOutboundHttpHeaders(ppszHeaders)
      => ComCall(11, this.p, PWSTR.Ptr, ppszHeaders)
    SetID(pszId?)
      => ComCall(12, this.p, "Str", pszId?)
    GetID(ppszId)
      => ComCall(13, this.p, PWSTR.Ptr, ppszId)
    SetContext(pContext)
      => ComCall(14, this.p, IUnknown, pContext)
    GetContext(ppContext)
      => ComCall(15, this.p, IUnknown.Ptr, ppContext)
    Clear()
      => ComCall(16, this.p)
}
struct IWSDHttpAddress extends IWSDTransportAddress {
    static IID := "{D09AC7BD-2A3E-4B85-8605-2737FF3E4EA0}"
    GetSecure()
      => ComCall(10, this.p)
    SetSecure(fSecure)
      => ComCall(11, this.p, BOOL, fSecure)
    GetPath(ppszPath)
      => ComCall(12, this.p, PWSTR.Ptr, ppszPath)
    SetPath(pszPath)
      => ComCall(13, this.p, "Str", pszPath)
}
struct IWSDSSLClientCertificate extends IUnknown {
    static IID := "{DE105E87-A0DA-418E-98AD-27B9EED87BDC}"
    GetClientCertificate(ppCertContext)
      => ComCall(3, this.p, CERT_CONTEXT.Ptr.Ptr, ppCertContext)
    GetMappedAccessToken(phToken)
      => ComCall(4, this.p, HANDLE.Ptr, phToken)
}
struct IWSDHttpAuthParameters extends IUnknown {
    static IID := "{0B476DF0-8DAC-480D-B05C-99781A5884AA}"
    GetClientAccessToken(phToken)
      => ComCall(3, this.p, HANDLE.Ptr, phToken)
    GetAuthType(pAuthType)
      => ComCall(4, this.p, UInt32.Ptr, pAuthType)
}
struct IWSDSignatureProperty extends IUnknown {
    static IID := "{03CE20AA-71C4-45E2-B32E-3766C61C790F}"
    IsMessageSigned(pbSigned)
      => ComCall(3, this.p, BOOL.Ptr, pbSigned)
    IsMessageSignatureTrusted(pbSignatureTrusted)
      => ComCall(4, this.p, BOOL.Ptr, pbSignatureTrusted)
    GetKeyInfo(pbKeyInfo?, pdwKeyInfoSize)
      => ComCall(5, this.p, UInt8.Ptr, pbKeyInfo?, UInt32.Ptr, pdwKeyInfoSize)
    GetSignature(pbSignature?, pdwSignatureSize)
      => ComCall(6, this.p, UInt8.Ptr, pbSignature?, UInt32.Ptr, pdwSignatureSize)
    GetSignedInfoHash(pbSignedInfoHash?, pdwHashSize)
      => ComCall(7, this.p, UInt8.Ptr, pbSignedInfoHash?, UInt32.Ptr, pdwHashSize)
}
struct IWSDAttachment extends IUnknown {
    static IID := "{5D55A616-9DF8-4B09-B156-9BA351A48B76}"
}
struct IWSDOutboundAttachment extends IWSDAttachment {
    static IID := "{AA302F8D-5A22-4BA5-B392-AA8486F4C15D}"
    Write(pBuffer, pdwNumberOfBytesWritten)
      => ComCall(3, this.p, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32.Ptr, pdwNumberOfBytesWritten)
    Close()
      => ComCall(4, this.p)
    Abort()
      => ComCall(5, this.p)
}
struct IWSDInboundAttachment extends IWSDAttachment {
    static IID := "{5BD6CA65-233C-4FB8-9F7A-2641619655C9}"
    Read(pBuffer, pdwNumberOfBytesRead)
      => ComCall(3, this.p, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32.Ptr, pdwNumberOfBytesRead)
    Close()
      => ComCall(4, this.p)
}
struct WSD_DATETIME {
    isPositive : BOOL
    year : UInt32
    month : UInt8
    day : UInt8
    hour : UInt8
    minute : UInt8
    second : UInt8
    millisecond : UInt32
    TZIsLocal : BOOL
    TZIsPositive : BOOL
    TZHour : UInt8
    TZMinute : UInt8
}
struct WSD_DURATION {
    isPositive : BOOL
    year : UInt32
    month : UInt32
    day : UInt32
    hour : UInt32
    minute : UInt32
    second : UInt32
    millisecond : UInt32
}
struct WSDXML_OP extends Int32 {
    static OpNone := 0
    static OpEndOfTable := 1
    static OpBeginElement_ := 2
    static OpBeginAnyElement := 3
    static OpEndElement := 4
    static OpElement_ := 5
    static OpAnyElement := 6
    static OpAnyElements := 7
    static OpAnyText := 8
    static OpAttribute_ := 9
    static OpBeginChoice := 10
    static OpEndChoice := 11
    static OpBeginSequence := 12
    static OpEndSequence := 13
    static OpBeginAll := 14
    static OpEndAll := 15
    static OpAnything := 16
    static OpAnyNumber := 17
    static OpOneOrMore := 18
    static OpOptional := 19
    static OpFormatBool_ := 20
    static OpFormatInt8_ := 21
    static OpFormatInt16_ := 22
    static OpFormatInt32_ := 23
    static OpFormatInt64_ := 24
    static OpFormatUInt8_ := 25
    static OpFormatUInt16_ := 26
    static OpFormatUInt32_ := 27
    static OpFormatUInt64_ := 28
    static OpFormatUnicodeString_ := 29
    static OpFormatDom_ := 30
    static OpFormatStruct_ := 31
    static OpFormatUri_ := 32
    static OpFormatUuidUri_ := 33
    static OpFormatName_ := 34
    static OpFormatListInsertTail_ := 35
    static OpFormatType_ := 36
    static OpFormatDynamicType_ := 37
    static OpFormatLookupType_ := 38
    static OpFormatDuration_ := 39
    static OpFormatDateTime_ := 40
    static OpFormatFloat_ := 41
    static OpFormatDouble_ := 42
    static OpProcess_ := 43
    static OpQualifiedAttribute_ := 44
    static OpFormatXMLDeclaration_ := 45
    static OpFormatMax := 46
}
struct IWSDXMLContext extends IUnknown {
    static IID := "{75D8F3EE-3E5A-43B4-A15A-BCF6887460C0}"
    AddNamespace(pszUri, pszSuggestedPrefix, ppNamespace?)
      => ComCall(3, this.p, "Str", pszUri, "Str", pszSuggestedPrefix, WSDXML_NAMESPACE.Ptr.Ptr, ppNamespace?)
    AddNameToNamespace(pszUri, pszName, ppName?)
      => ComCall(4, this.p, "Str", pszUri, "Str", pszName, WSDXML_NAME.Ptr.Ptr, ppName?)
    SetNamespaces(pNamespaces, bLayerNumber)
      => ComCall(5, this.p, WSDXML_NAMESPACE.Ptr.Ptr, pNamespaces, UInt16, pNamespaces.Length, UInt8, bLayerNumber)
    SetTypes(pTypes, bLayerNumber)
      => ComCall(6, this.p, WSDXML_TYPE.Ptr.Ptr, pTypes, UInt32, pTypes.Length, UInt8, bLayerNumber)
}
struct WSDXML_NAMESPACE {
    Uri : PWSTR
    PreferredPrefix : PWSTR
    Names : WSDXML_NAME.Ptr
    NamesCount : UInt16
    Encoding : UInt16
}
struct WSDXML_NAME {
    Space : WSDXML_NAMESPACE.Ptr
    LocalName : PWSTR
}
struct WSDXML_TYPE {
    Uri : PWSTR
    Table : UInt8.Ptr
}
struct WSDXML_PREFIX_MAPPING {
    Refs : UInt32
    Next : WSDXML_PREFIX_MAPPING.Ptr
    Space : WSDXML_NAMESPACE.Ptr
    Prefix : PWSTR
}
struct WSDXML_ATTRIBUTE {
    Element : WSDXML_ELEMENT.Ptr
    Next : WSDXML_ATTRIBUTE.Ptr
    Name : WSDXML_NAME.Ptr
    Value : PWSTR
}
struct WSDXML_NODE {
    Type : Int32
    Parent : WSDXML_ELEMENT.Ptr
    Next : WSDXML_NODE.Ptr
}
struct WSDXML_ELEMENT {
    Node : WSDXML_NODE
    Name : WSDXML_NAME.Ptr
    FirstAttribute : WSDXML_ATTRIBUTE.Ptr
    FirstChild : WSDXML_NODE.Ptr
    PrefixMappings : WSDXML_PREFIX_MAPPING.Ptr
}
struct WSDXML_TEXT {
    Node : WSDXML_NODE
    Text : PWSTR
}
struct WSDXML_ELEMENT_LIST {
    Next : WSDXML_ELEMENT_LIST.Ptr
    Element : WSDXML_ELEMENT.Ptr
}
struct WSD_STUB_FUNCTION extends FunctionPointer {
    static Types := [IUnknown, IWSDServiceMessaging, WSD_EVENT.Ptr, HRESULT]
}
struct DeviceDiscoveryMechanism extends Int32 {
    static MulticastDiscovery := 0
    static DirectedDiscovery := 1
    static SecureDirectedDiscovery := 2
}
struct WSD_PROTOCOL_TYPE extends Int32 {
    static WSD_PT_NONE := 0
    static WSD_PT_UDP := 1
    static WSD_PT_HTTP := 2
    static WSD_PT_HTTPS := 4
    static WSD_PT_ALL := 255
}
struct WSD_OPERATION {
    RequestType : WSDXML_TYPE.Ptr
    ResponseType : WSDXML_TYPE.Ptr
    RequestStubFunction : WSD_STUB_FUNCTION
}
struct PWSD_SOAP_MESSAGE_HANDLER extends FunctionPointer {
    static Types := [IUnknown, WSD_EVENT.Ptr, HRESULT]
}
struct WSD_HANDLER_CONTEXT {
    Handler : PWSD_SOAP_MESSAGE_HANDLER
    PVoid : Struct.Ptr
    Unknown : IUnknown
}
struct WSDEventType extends Int32 {
    static WSDET_NONE := 0
    static WSDET_INCOMING_MESSAGE := 1
    static WSDET_INCOMING_FAULT := 2
    static WSDET_TRANSMISSION_FAILURE := 3
    static WSDET_RESPONSE_TIMEOUT := 4
}
struct WSD_SYNCHRONOUS_RESPONSE_CONTEXT {
    hr : HRESULT
    eventHandle : HANDLE
    messageParameters : IWSDMessageParameters
    results : Struct.Ptr
}
struct WSD_PORT_TYPE {
    EncodedName : UInt32
    OperationCount : UInt32
    Operations : WSD_OPERATION.Ptr
    ProtocolType : WSD_PROTOCOL_TYPE
}
struct WSD_RELATIONSHIP_METADATA {
    Type : PWSTR
    Data : WSD_HOST_METADATA.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_SERVICE_METADATA_LIST {
    Next : WSD_SERVICE_METADATA_LIST.Ptr
    Element : WSD_SERVICE_METADATA.Ptr
}
struct WSD_HOST_METADATA {
    Host : WSD_SERVICE_METADATA.Ptr
    Hosted : WSD_SERVICE_METADATA_LIST.Ptr
}
struct WSD_ENDPOINT_REFERENCE_LIST {
    Next : WSD_ENDPOINT_REFERENCE_LIST.Ptr
    Element : WSD_ENDPOINT_REFERENCE.Ptr
}
struct WSD_SERVICE_METADATA {
    EndpointReference : WSD_ENDPOINT_REFERENCE_LIST.Ptr
    Types : WSD_NAME_LIST.Ptr
    ServiceId : PWSTR
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_THIS_DEVICE_METADATA {
    FriendlyName : WSD_LOCALIZED_STRING_LIST.Ptr
    FirmwareVersion : PWSTR
    SerialNumber : PWSTR
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_THIS_MODEL_METADATA {
    Manufacturer : WSD_LOCALIZED_STRING_LIST.Ptr
    ManufacturerUrl : PWSTR
    ModelName : WSD_LOCALIZED_STRING_LIST.Ptr
    ModelNumber : PWSTR
    ModelUrl : PWSTR
    PresentationUrl : PWSTR
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_LOCALIZED_STRING_LIST {
    Next : WSD_LOCALIZED_STRING_LIST.Ptr
    Element : WSD_LOCALIZED_STRING.Ptr
}
struct WSD_SOAP_FAULT_REASON {
    Text : WSD_LOCALIZED_STRING_LIST.Ptr
}
struct WSD_SOAP_FAULT_SUBCODE {
    Value : WSDXML_NAME.Ptr
    Subcode : WSD_SOAP_FAULT_SUBCODE.Ptr
}
struct WSD_SOAP_FAULT_CODE {
    Value : WSDXML_NAME.Ptr
    Subcode : WSD_SOAP_FAULT_SUBCODE.Ptr
}
struct WSD_SOAP_FAULT {
    Code : WSD_SOAP_FAULT_CODE.Ptr
    Reason : WSD_SOAP_FAULT_REASON.Ptr
    Node : PWSTR
    Role : PWSTR
    Detail : WSDXML_ELEMENT.Ptr
}
struct WSD_APP_SEQUENCE {
    InstanceId : Int64
    SequenceId : PWSTR
    MessageNumber : Int64
}
struct WSD_HEADER_RELATESTO {
    RelationshipType : WSDXML_NAME.Ptr
    MessageID : PWSTR
}
struct WSD_SOAP_HEADER {
    To : PWSTR
    Action : PWSTR
    MessageID : PWSTR
    RelatesTo : WSD_HEADER_RELATESTO
    ReplyTo : WSD_ENDPOINT_REFERENCE.Ptr
    From : WSD_ENDPOINT_REFERENCE.Ptr
    FaultTo : WSD_ENDPOINT_REFERENCE.Ptr
    AppSequence : WSD_APP_SEQUENCE.Ptr
    AnyHeaders : WSDXML_ELEMENT.Ptr
}
struct WSD_SOAP_MESSAGE {
    Header : WSD_SOAP_HEADER
    Body : Struct.Ptr
    BodyType : WSDXML_TYPE.Ptr
}
struct WSD_RESOLVE_MATCHES {
    ResolveMatch : WSD_RESOLVE_MATCH.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_RESOLVE_MATCH {
    EndpointReference : WSD_ENDPOINT_REFERENCE.Ptr
    Types : WSD_NAME_LIST.Ptr
    Scopes : WSD_SCOPES.Ptr
    XAddrs : WSD_URI_LIST.Ptr
    MetadataVersion : Int64
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_RESOLVE {
    EndpointReference : WSD_ENDPOINT_REFERENCE.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_PROBE_MATCH {
    EndpointReference : WSD_ENDPOINT_REFERENCE.Ptr
    Types : WSD_NAME_LIST.Ptr
    Scopes : WSD_SCOPES.Ptr
    XAddrs : WSD_URI_LIST.Ptr
    MetadataVersion : Int64
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_PROBE_MATCH_LIST {
    Next : WSD_PROBE_MATCH_LIST.Ptr
    Element : WSD_PROBE_MATCH.Ptr
}
struct WSD_PROBE_MATCHES {
    ProbeMatch : WSD_PROBE_MATCH_LIST.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_PROBE {
    Types : WSD_NAME_LIST.Ptr
    Scopes : WSD_SCOPES.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_BYE {
    EndpointReference : WSD_ENDPOINT_REFERENCE.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_SCOPES {
    MatchBy : PWSTR
    Scopes : WSD_URI_LIST.Ptr
}
struct WSD_NAME_LIST {
    Next : WSD_NAME_LIST.Ptr
    Element : WSDXML_NAME.Ptr
}
struct WSD_HELLO {
    EndpointReference : WSD_ENDPOINT_REFERENCE.Ptr
    Types : WSD_NAME_LIST.Ptr
    Scopes : WSD_SCOPES.Ptr
    XAddrs : WSD_URI_LIST.Ptr
    MetadataVersion : Int64
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_REFERENCE_PARAMETERS {
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_REFERENCE_PROPERTIES {
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_ENDPOINT_REFERENCE {
    Address : PWSTR
    ReferenceProperties : WSD_REFERENCE_PROPERTIES
    ReferenceParameters : WSD_REFERENCE_PARAMETERS
    PortType : WSDXML_NAME.Ptr
    ServiceName : WSDXML_NAME.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_METADATA_SECTION {
    Dialect : PWSTR
    Identifier : PWSTR
    Data : Struct.Ptr
    MetadataReference : WSD_ENDPOINT_REFERENCE.Ptr
    Location : PWSTR
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_METADATA_SECTION_LIST {
    Next : WSD_METADATA_SECTION_LIST.Ptr
    Element : WSD_METADATA_SECTION.Ptr
}
struct WSD_URI_LIST {
    Next : WSD_URI_LIST.Ptr
    Element : PWSTR
}
struct WSD_EVENTING_FILTER_ACTION {
    Actions : WSD_URI_LIST.Ptr
}
struct WSD_EVENTING_FILTER {
    Dialect : PWSTR
    FilterAction : WSD_EVENTING_FILTER_ACTION.Ptr
    Data : Struct.Ptr
}
struct WSD_EVENTING_EXPIRES {
    Duration : WSD_DURATION.Ptr
    DateTime : WSD_DATETIME.Ptr
}
struct WSD_EVENTING_DELIVERY_MODE_PUSH {
    NotifyTo : WSD_ENDPOINT_REFERENCE.Ptr
}
struct WSD_EVENTING_DELIVERY_MODE {
    Mode : PWSTR
    Push : WSD_EVENTING_DELIVERY_MODE_PUSH.Ptr
    Data : Struct.Ptr
}
struct WSD_LOCALIZED_STRING {
    lang : PWSTR
    String : PWSTR
}
struct RESPONSEBODY_GetMetadata {
    Metadata : WSD_METADATA_SECTION_LIST.Ptr
}
struct REQUESTBODY_Subscribe {
    EndTo : WSD_ENDPOINT_REFERENCE.Ptr
    Delivery : WSD_EVENTING_DELIVERY_MODE.Ptr
    Expires : WSD_EVENTING_EXPIRES.Ptr
    Filter : WSD_EVENTING_FILTER.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct RESPONSEBODY_Subscribe {
    SubscriptionManager : WSD_ENDPOINT_REFERENCE.Ptr
    expires : WSD_EVENTING_EXPIRES.Ptr
    any : WSDXML_ELEMENT.Ptr
}
struct REQUESTBODY_Renew {
    Expires : WSD_EVENTING_EXPIRES.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct RESPONSEBODY_Renew {
    expires : WSD_EVENTING_EXPIRES.Ptr
    any : WSDXML_ELEMENT.Ptr
}
struct REQUESTBODY_GetStatus {
    Any : WSDXML_ELEMENT.Ptr
}
struct RESPONSEBODY_GetStatus {
    expires : WSD_EVENTING_EXPIRES.Ptr
    any : WSDXML_ELEMENT.Ptr
}
struct REQUESTBODY_Unsubscribe {
    any : WSDXML_ELEMENT.Ptr
}
struct RESPONSEBODY_SubscriptionEnd {
    SubscriptionManager : WSD_ENDPOINT_REFERENCE.Ptr
    Status : PWSTR
    Reason : WSD_LOCALIZED_STRING.Ptr
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_UNKNOWN_LOOKUP {
    Any : WSDXML_ELEMENT.Ptr
}
struct WSD_EVENT {
    Hr : HRESULT
    EventType : UInt32
    DispatchTag : PWSTR
    HandlerContext : WSD_HANDLER_CONTEXT
    Soap : WSD_SOAP_MESSAGE.Ptr
    Operation : WSD_OPERATION.Ptr
    MessageParameters : IWSDMessageParameters
}
struct IWSDiscoveryProvider extends IUnknown {
    static IID := "{8FFC8E55-F0EB-480F-88B7-B435DD281D45}"
    SetAddressFamily(dwAddressFamily)
      => ComCall(3, this.p, UInt32, dwAddressFamily)
    Attach(pSink)
      => ComCall(4, this.p, IWSDiscoveryProviderNotify, pSink)
    Detach()
      => ComCall(5, this.p)
    SearchById(pszId, pszTag?)
      => ComCall(6, this.p, "Str", pszId, "Str", pszTag?)
    SearchByAddress(pszAddress, pszTag?)
      => ComCall(7, this.p, "Str", pszAddress, "Str", pszTag?)
    SearchByType(pTypesList?, pScopesList?, pszMatchBy?, pszTag?)
      => ComCall(8, this.p, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, "Str", pszMatchBy?, "Str", pszTag?)
    GetXMLContext(ppContext)
      => ComCall(9, this.p, IWSDXMLContext.Ptr, ppContext)
}
struct IWSDiscoveryProviderNotify extends IUnknown {
    static IID := "{73EE3CED-B6E6-4329-A546-3E8AD46563D2}"
    Add(pService)
      => ComCall(3, this.p, IWSDiscoveredService, pService)
    Remove(pService)
      => ComCall(4, this.p, IWSDiscoveredService, pService)
    SearchFailed(hr, pszTag?)
      => ComCall(5, this.p, HRESULT, hr, "Str", pszTag?)
    SearchComplete(pszTag?)
      => ComCall(6, this.p, "Str", pszTag?)
}
struct IWSDiscoveredService extends IUnknown {
    static IID := "{4BAD8A3B-B374-4420-9632-AAC945B374AA}"
    GetEndpointReference(ppEndpointReference)
      => ComCall(3, this.p, WSD_ENDPOINT_REFERENCE.Ptr.Ptr, ppEndpointReference)
    GetTypes(ppTypesList)
      => ComCall(4, this.p, WSD_NAME_LIST.Ptr.Ptr, ppTypesList)
    GetScopes(ppScopesList)
      => ComCall(5, this.p, WSD_URI_LIST.Ptr.Ptr, ppScopesList)
    GetXAddrs(ppXAddrsList)
      => ComCall(6, this.p, WSD_URI_LIST.Ptr.Ptr, ppXAddrsList)
    GetMetadataVersion(pullMetadataVersion)
      => ComCall(7, this.p, Int64.Ptr, pullMetadataVersion)
    GetExtendedDiscoXML(ppHeaderAny, ppBodyAny)
      => ComCall(8, this.p, WSDXML_ELEMENT.Ptr.Ptr, ppHeaderAny, WSDXML_ELEMENT.Ptr.Ptr, ppBodyAny)
    GetProbeResolveTag(ppszTag)
      => ComCall(9, this.p, PWSTR.Ptr, ppszTag)
    GetRemoteTransportAddress(ppszRemoteTransportAddress)
      => ComCall(10, this.p, PWSTR.Ptr, ppszRemoteTransportAddress)
    GetLocalTransportAddress(ppszLocalTransportAddress)
      => ComCall(11, this.p, PWSTR.Ptr, ppszLocalTransportAddress)
    GetLocalInterfaceGUID(pGuid)
      => ComCall(12, this.p, GUID.Ptr, pGuid)
    GetInstanceId(pullInstanceId)
      => ComCall(13, this.p, Int64.Ptr, pullInstanceId)
}
struct IWSDiscoveryPublisher extends IUnknown {
    static IID := "{AE01E1A8-3FF9-4148-8116-057CC616FE13}"
    SetAddressFamily(dwAddressFamily)
      => ComCall(3, this.p, UInt32, dwAddressFamily)
    RegisterNotificationSink(pSink)
      => ComCall(4, this.p, IWSDiscoveryPublisherNotify, pSink)
    UnRegisterNotificationSink(pSink)
      => ComCall(5, this.p, IWSDiscoveryPublisherNotify, pSink)
    Publish(pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?)
      => ComCall(6, this.p, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?)
    UnPublish(pszId, ullInstanceId, ullMessageNumber, pszSessionId?, pAny?)
      => ComCall(7, this.p, "Str", pszId, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSDXML_ELEMENT.Ptr, pAny?)
    MatchProbe(pProbeMessage, pMessageParameters, pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?)
      => ComCall(8, this.p, WSD_SOAP_MESSAGE.Ptr, pProbeMessage, IWSDMessageParameters, pMessageParameters, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?)
    MatchResolve(pResolveMessage, pMessageParameters, pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?)
      => ComCall(9, this.p, WSD_SOAP_MESSAGE.Ptr, pResolveMessage, IWSDMessageParameters, pMessageParameters, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?)
    PublishEx(pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?, pHeaderAny?, pReferenceParameterAny?, pPolicyAny?, pEndpointReferenceAny?, pAny?)
      => ComCall(10, this.p, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?, WSDXML_ELEMENT.Ptr, pHeaderAny?, WSDXML_ELEMENT.Ptr, pReferenceParameterAny?, WSDXML_ELEMENT.Ptr, pPolicyAny?, WSDXML_ELEMENT.Ptr, pEndpointReferenceAny?, WSDXML_ELEMENT.Ptr, pAny?)
    MatchProbeEx(pProbeMessage, pMessageParameters, pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?, pHeaderAny?, pReferenceParameterAny?, pPolicyAny?, pEndpointReferenceAny?, pAny?)
      => ComCall(11, this.p, WSD_SOAP_MESSAGE.Ptr, pProbeMessage, IWSDMessageParameters, pMessageParameters, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?, WSDXML_ELEMENT.Ptr, pHeaderAny?, WSDXML_ELEMENT.Ptr, pReferenceParameterAny?, WSDXML_ELEMENT.Ptr, pPolicyAny?, WSDXML_ELEMENT.Ptr, pEndpointReferenceAny?, WSDXML_ELEMENT.Ptr, pAny?)
    MatchResolveEx(pResolveMessage, pMessageParameters, pszId, ullMetadataVersion, ullInstanceId, ullMessageNumber, pszSessionId?, pTypesList?, pScopesList?, pXAddrsList?, pHeaderAny?, pReferenceParameterAny?, pPolicyAny?, pEndpointReferenceAny?, pAny?)
      => ComCall(12, this.p, WSD_SOAP_MESSAGE.Ptr, pResolveMessage, IWSDMessageParameters, pMessageParameters, "Str", pszId, Int64, ullMetadataVersion, Int64, ullInstanceId, Int64, ullMessageNumber, "Str", pszSessionId?, WSD_NAME_LIST.Ptr, pTypesList?, WSD_URI_LIST.Ptr, pScopesList?, WSD_URI_LIST.Ptr, pXAddrsList?, WSDXML_ELEMENT.Ptr, pHeaderAny?, WSDXML_ELEMENT.Ptr, pReferenceParameterAny?, WSDXML_ELEMENT.Ptr, pPolicyAny?, WSDXML_ELEMENT.Ptr, pEndpointReferenceAny?, WSDXML_ELEMENT.Ptr, pAny?)
    RegisterScopeMatchingRule(pScopeMatchingRule)
      => ComCall(13, this.p, IWSDScopeMatchingRule, pScopeMatchingRule)
    UnRegisterScopeMatchingRule(pScopeMatchingRule)
      => ComCall(14, this.p, IWSDScopeMatchingRule, pScopeMatchingRule)
    GetXMLContext(ppContext)
      => ComCall(15, this.p, IWSDXMLContext.Ptr, ppContext)
}
struct IWSDiscoveryPublisherNotify extends IUnknown {
    static IID := "{E67651B0-337A-4B3C-9758-733388568251}"
    ProbeHandler(pSoap, pMessageParameters)
      => ComCall(3, this.p, WSD_SOAP_MESSAGE.Ptr, pSoap, IWSDMessageParameters, pMessageParameters)
    ResolveHandler(pSoap, pMessageParameters)
      => ComCall(4, this.p, WSD_SOAP_MESSAGE.Ptr, pSoap, IWSDMessageParameters, pMessageParameters)
}
struct IWSDScopeMatchingRule extends IUnknown {
    static IID := "{FCAFE424-FEF5-481A-BD9F-33CE0574256F}"
    GetScopeRule(ppszScopeMatchingRule)
      => ComCall(3, this.p, PWSTR.Ptr, ppszScopeMatchingRule)
    MatchScopes(pszScope1, pszScope2, pfMatch)
      => ComCall(4, this.p, "Str", pszScope1, "Str", pszScope2, BOOL.Ptr, pfMatch)
}
struct IWSDEndpointProxy extends IUnknown {
    static IID := "{1860D430-B24C-4975-9F90-DBB39BAA24EC}"
    SendOneWayRequest(pBody, pOperation)
      => ComCall(3, this.p, Struct.Ptr, pBody, WSD_OPERATION.Ptr, pOperation)
    SendTwoWayRequest(pBody, pOperation, pResponseContext?)
      => ComCall(4, this.p, Struct.Ptr, pBody, WSD_OPERATION.Ptr, pOperation, WSD_SYNCHRONOUS_RESPONSE_CONTEXT.Ptr, pResponseContext?)
    SendTwoWayRequestAsync(pBody, pOperation, pAsyncState, pCallback, pResult)
      => ComCall(5, this.p, Struct.Ptr, pBody, WSD_OPERATION.Ptr, pOperation, IUnknown, pAsyncState, IWSDAsyncCallback, pCallback, IWSDAsyncResult.Ptr, pResult)
    AbortAsyncOperation(pAsyncResult)
      => ComCall(6, this.p, IWSDAsyncResult, pAsyncResult)
    ProcessFault(pFault)
      => ComCall(7, this.p, WSD_SOAP_FAULT.Ptr, pFault)
    GetErrorInfo(ppszErrorInfo)
      => ComCall(8, this.p, PWSTR.Ptr, ppszErrorInfo)
    GetFaultInfo(ppFault)
      => ComCall(9, this.p, WSD_SOAP_FAULT.Ptr.Ptr, ppFault)
}
struct IWSDMetadataExchange extends IUnknown {
    static IID := "{06996D57-1D67-4928-9307-3D7833FDB846}"
    GetMetadata(MetadataOut)
      => ComCall(3, this.p, WSD_METADATA_SECTION_LIST.Ptr.Ptr, MetadataOut)
}
struct IWSDServiceProxy extends IWSDMetadataExchange {
    static IID := "{D4C7FB9C-03AB-4175-9D67-094FAFEBF487}"
    BeginGetMetadata(ppResult)
      => ComCall(4, this.p, IWSDAsyncResult.Ptr, ppResult)
    EndGetMetadata(pResult, ppMetadata)
      => ComCall(5, this.p, IWSDAsyncResult, pResult, WSD_METADATA_SECTION_LIST.Ptr.Ptr, ppMetadata)
    GetServiceMetadata(ppServiceMetadata)
      => ComCall(6, this.p, WSD_SERVICE_METADATA.Ptr.Ptr, ppServiceMetadata)
    SubscribeToOperation(pOperation, pUnknown, pAny, ppAny?)
      => ComCall(7, this.p, WSD_OPERATION.Ptr, pOperation, IUnknown, pUnknown, WSDXML_ELEMENT.Ptr, pAny, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    UnsubscribeToOperation(pOperation)
      => ComCall(8, this.p, WSD_OPERATION.Ptr, pOperation)
    SetEventingStatusCallback(pStatus?)
      => ComCall(9, this.p, IWSDEventingStatus, pStatus?)
    GetEndpointProxy(ppProxy)
      => ComCall(10, this.p, IWSDEndpointProxy.Ptr, ppProxy)
}
struct IWSDServiceProxyEventing extends IWSDServiceProxy {
    static IID := "{F9279D6D-1012-4A94-B8CC-FD35D2202BFE}"
    SubscribeToMultipleOperations(pOperations, pUnknown?, pExpires?, pAny?, ppExpires?, ppAny?)
      => ComCall(11, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IUnknown, pUnknown?, WSD_EVENTING_EXPIRES.Ptr, pExpires?, WSDXML_ELEMENT.Ptr, pAny?, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    BeginSubscribeToMultipleOperations(pOperations, pUnknown?, pExpires?, pAny?, pAsyncState?, pAsyncCallback?, ppResult)
      => ComCall(12, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IUnknown, pUnknown?, WSD_EVENTING_EXPIRES.Ptr, pExpires?, WSDXML_ELEMENT.Ptr, pAny?, IUnknown, pAsyncState?, IWSDAsyncCallback, pAsyncCallback?, IWSDAsyncResult.Ptr, ppResult)
    EndSubscribeToMultipleOperations(pOperations, pResult, ppExpires?, ppAny?)
      => ComCall(13, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IWSDAsyncResult, pResult, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    UnsubscribeToMultipleOperations(pOperations, pAny)
      => ComCall(14, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSDXML_ELEMENT.Ptr, pAny)
    BeginUnsubscribeToMultipleOperations(pOperations, pAny?, pAsyncState?, pAsyncCallback?, ppResult)
      => ComCall(15, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSDXML_ELEMENT.Ptr, pAny?, IUnknown, pAsyncState?, IWSDAsyncCallback, pAsyncCallback?, IWSDAsyncResult.Ptr, ppResult)
    EndUnsubscribeToMultipleOperations(pOperations, pResult)
      => ComCall(16, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IWSDAsyncResult, pResult)
    RenewMultipleOperations(pOperations, pExpires?, pAny?, ppExpires?, ppAny?)
      => ComCall(17, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSD_EVENTING_EXPIRES.Ptr, pExpires?, WSDXML_ELEMENT.Ptr, pAny?, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    BeginRenewMultipleOperations(pOperations, pExpires?, pAny?, pAsyncState?, pAsyncCallback?, ppResult)
      => ComCall(18, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSD_EVENTING_EXPIRES.Ptr, pExpires?, WSDXML_ELEMENT.Ptr, pAny?, IUnknown, pAsyncState?, IWSDAsyncCallback, pAsyncCallback?, IWSDAsyncResult.Ptr, ppResult)
    EndRenewMultipleOperations(pOperations, pResult, ppExpires?, ppAny?)
      => ComCall(19, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IWSDAsyncResult, pResult, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    GetStatusForMultipleOperations(pOperations, pAny?, ppExpires?, ppAny?)
      => ComCall(20, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSDXML_ELEMENT.Ptr, pAny?, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
    BeginGetStatusForMultipleOperations(pOperations, pAny?, pAsyncState?, pAsyncCallback?, ppResult)
      => ComCall(21, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, WSDXML_ELEMENT.Ptr, pAny?, IUnknown, pAsyncState?, IWSDAsyncCallback, pAsyncCallback?, IWSDAsyncResult.Ptr, ppResult)
    EndGetStatusForMultipleOperations(pOperations, pResult, ppExpires?, ppAny?)
      => ComCall(22, this.p, WSD_OPERATION.Ptr, pOperations, UInt32, pOperations.Length, IWSDAsyncResult, pResult, WSD_EVENTING_EXPIRES.Ptr.Ptr, ppExpires?, WSDXML_ELEMENT.Ptr.Ptr, ppAny?)
}
struct IWSDDeviceProxy extends IUnknown {
    static IID := "{EEE0C031-C578-4C0E-9A3B-973C35F409DB}"
    Init(pszDeviceId, pDeviceAddress, pszLocalId, pContext?, pSponsor?)
      => ComCall(3, this.p, "Str", pszDeviceId, IWSDAddress, pDeviceAddress, "Str", pszLocalId, IWSDXMLContext, pContext?, IWSDDeviceProxy, pSponsor?)
    BeginGetMetadata(ppResult)
      => ComCall(4, this.p, IWSDAsyncResult.Ptr, ppResult)
    EndGetMetadata(pResult)
      => ComCall(5, this.p, IWSDAsyncResult, pResult)
    GetHostMetadata(ppHostMetadata)
      => ComCall(6, this.p, WSD_HOST_METADATA.Ptr.Ptr, ppHostMetadata)
    GetThisModelMetadata(ppManufacturerMetadata)
      => ComCall(7, this.p, WSD_THIS_MODEL_METADATA.Ptr.Ptr, ppManufacturerMetadata)
    GetThisDeviceMetadata(ppThisDeviceMetadata)
      => ComCall(8, this.p, WSD_THIS_DEVICE_METADATA.Ptr.Ptr, ppThisDeviceMetadata)
    GetAllMetadata(ppMetadata)
      => ComCall(9, this.p, WSD_METADATA_SECTION_LIST.Ptr.Ptr, ppMetadata)
    GetServiceProxyById(pszServiceId, ppServiceProxy)
      => ComCall(10, this.p, "Str", pszServiceId, IWSDServiceProxy.Ptr, ppServiceProxy)
    GetServiceProxyByType(pType, ppServiceProxy)
      => ComCall(11, this.p, WSDXML_NAME.Ptr, pType, IWSDServiceProxy.Ptr, ppServiceProxy)
    GetEndpointProxy(ppProxy)
      => ComCall(12, this.p, IWSDEndpointProxy.Ptr, ppProxy)
}
struct IWSDAsyncResult extends IUnknown {
    static IID := "{11A9852A-8DD8-423E-B537-9356DB4FBFB8}"
    SetCallback(pCallback, pAsyncState)
      => ComCall(3, this.p, IWSDAsyncCallback, pCallback, IUnknown, pAsyncState)
    SetWaitHandle(hWaitHandle)
      => ComCall(4, this.p, HANDLE, hWaitHandle)
    HasCompleted()
      => ComCall(5, this.p)
    GetAsyncState(ppAsyncState)
      => ComCall(6, this.p, IUnknown.Ptr, ppAsyncState)
    Abort()
      => ComCall(7, this.p)
    GetEvent(pEvent)
      => ComCall(8, this.p, WSD_EVENT.Ptr, pEvent)
    GetEndpointProxy(ppEndpoint)
      => ComCall(9, this.p, IWSDEndpointProxy.Ptr, ppEndpoint)
}
struct IWSDAsyncCallback extends IUnknown {
    static IID := "{A63E109D-CE72-49E2-BA98-E845F5EE1666}"
    AsyncOperationComplete(pAsyncResult, pAsyncState)
      => ComCall(3, this.p, IWSDAsyncResult, pAsyncResult, IUnknown, pAsyncState)
}
struct IWSDEventingStatus extends IUnknown {
    static IID := "{49B17F52-637A-407A-AE99-FBE82A4D38C0}"
    SubscriptionRenewed(pszSubscriptionAction)
      => ComCall(3, this.p, "Str", pszSubscriptionAction, "void")
    SubscriptionRenewalFailed(pszSubscriptionAction, hr)
      => ComCall(4, this.p, "Str", pszSubscriptionAction, HRESULT, hr, "void")
    SubscriptionEnded(pszSubscriptionAction)
      => ComCall(5, this.p, "Str", pszSubscriptionAction, "void")
}
struct IWSDDeviceHost extends IUnknown {
    static IID := "{917FE891-3D13-4138-9809-934C8ABEB12C}"
    Init(pszLocalId, pContext?, ppHostAddresses?)
      => ComCall(3, this.p, "Str", pszLocalId, IWSDXMLContext, pContext?, IWSDAddress.Ptr, ppHostAddresses?, UInt32, ppHostAddresses?.Length ?? 0)
    Start(ullInstanceId, pScopeList, pNotificationSink?)
      => ComCall(4, this.p, Int64, ullInstanceId, WSD_URI_LIST.Ptr, pScopeList, IWSDDeviceHostNotify, pNotificationSink?)
    Stop()
      => ComCall(5, this.p)
    Terminate()
      => ComCall(6, this.p)
    RegisterPortType(pPortType)
      => ComCall(7, this.p, WSD_PORT_TYPE.Ptr, pPortType)
    SetMetadata(pThisModelMetadata, pThisDeviceMetadata, pHostMetadata?, pCustomMetadata?)
      => ComCall(8, this.p, WSD_THIS_MODEL_METADATA.Ptr, pThisModelMetadata, WSD_THIS_DEVICE_METADATA.Ptr, pThisDeviceMetadata, WSD_HOST_METADATA.Ptr, pHostMetadata?, WSD_METADATA_SECTION_LIST.Ptr, pCustomMetadata?)
    RegisterService(pszServiceId, pService)
      => ComCall(9, this.p, "Str", pszServiceId, IUnknown, pService)
    RetireService(pszServiceId)
      => ComCall(10, this.p, "Str", pszServiceId)
    AddDynamicService(pszServiceId, pszEndpointAddress?, pPortType?, pPortName?, pAny?, pService?)
      => ComCall(11, this.p, "Str", pszServiceId, "Str", pszEndpointAddress?, WSD_PORT_TYPE.Ptr, pPortType?, WSDXML_NAME.Ptr, pPortName?, WSDXML_ELEMENT.Ptr, pAny?, IUnknown, pService?)
    RemoveDynamicService(pszServiceId)
      => ComCall(12, this.p, "Str", pszServiceId)
    SetServiceDiscoverable(pszServiceId, fDiscoverable)
      => ComCall(13, this.p, "Str", pszServiceId, BOOL, fDiscoverable)
    SignalEvent(pszServiceId, pBody?, pOperation)
      => ComCall(14, this.p, "Str", pszServiceId, Struct.Ptr, pBody?, WSD_OPERATION.Ptr, pOperation)
}
struct IWSDDeviceHostNotify extends IUnknown {
    static IID := "{B5BEE9F9-EEDA-41FE-96F7-F45E14990FB0}"
    GetService(pszServiceId, ppService)
      => ComCall(3, this.p, "Str", pszServiceId, IUnknown.Ptr, ppService)
}
struct IWSDServiceMessaging extends IUnknown {
    static IID := "{94974CF4-0CAB-460D-A3F6-7A0AD623C0E6}"
    SendResponse(pBody?, pOperation, pMessageParameters)
      => ComCall(3, this.p, Struct.Ptr, pBody?, WSD_OPERATION.Ptr, pOperation, IWSDMessageParameters, pMessageParameters)
    FaultRequest(pRequestHeader, pMessageParameters, pFault?)
      => ComCall(4, this.p, WSD_SOAP_HEADER.Ptr, pRequestHeader, IWSDMessageParameters, pMessageParameters, WSD_SOAP_FAULT.Ptr, pFault?)
}
