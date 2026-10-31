#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\NetworkManagement.Ndis\Types.ahk" {NETWORK_ADDRESS_LIST}
#Import "..\Networking.WinSock\Types.ahk" {FLOWSPEC, SOCKADDR}

struct RHANDLE {
    Value : Struct.Ptr
}
struct QOS_OBJECT_HDR {
    ObjectType : UInt32
    ObjectLength : UInt32
}
struct QOS_SD_MODE {
    ObjectHdr : QOS_OBJECT_HDR
    ShapeDiscardMode : UInt32
}
struct QOS_SHAPING_RATE {
    ObjectHdr : QOS_OBJECT_HDR
    ShapingRate : UInt32
}
struct QOS_TRAFFIC_TYPE extends Int32 {
    static QOSTrafficTypeBestEffort := 0
    static QOSTrafficTypeBackground := 1
    static QOSTrafficTypeExcellentEffort := 2
    static QOSTrafficTypeAudioVideo := 3
    static QOSTrafficTypeVoice := 4
    static QOSTrafficTypeControl := 5
}
struct QOS_SET_FLOW extends Int32 {
    static QOSSetTrafficType := 0
    static QOSSetOutgoingRate := 1
    static QOSSetOutgoingDSCPValue := 2
}
struct QOS_PACKET_PRIORITY {
    ConformantDSCPValue : UInt32
    NonConformantDSCPValue : UInt32
    ConformantL2Value : UInt32
    NonConformantL2Value : UInt32
}
struct QOS_FLOW_FUNDAMENTALS {
    BottleneckBandwidthSet : BOOL
    BottleneckBandwidth : Int64
    AvailableBandwidthSet : BOOL
    AvailableBandwidth : Int64
    RTTSet : BOOL
    RTT : UInt32
}
struct QOS_FLOWRATE_REASON extends Int32 {
    static QOSFlowRateNotApplicable := 0
    static QOSFlowRateContentChange := 1
    static QOSFlowRateCongestion := 2
    static QOSFlowRateHigherContentEncoding := 3
    static QOSFlowRateUserCaused := 4
}
struct QOS_SHAPING extends Int32 {
    static QOSShapeOnly := 0
    static QOSShapeAndMark := 1
    static QOSUseNonConformantMarkings := 2
}
struct QOS_FLOWRATE_OUTGOING {
    Bandwidth : Int64
    ShapingBehavior : QOS_SHAPING
    Reason : QOS_FLOWRATE_REASON
}
struct QOS_QUERY_FLOW extends Int32 {
    static QOSQueryFlowFundamentals := 0
    static QOSQueryPacketPriority := 1
    static QOSQueryOutgoingRate := 2
}
struct QOS_NOTIFY_FLOW extends Int32 {
    static QOSNotifyCongested := 0
    static QOSNotifyUncongested := 1
    static QOSNotifyAvailable := 2
}
struct QOS_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct QOS_FRIENDLY_NAME {
    ObjectHdr : QOS_OBJECT_HDR
    FriendlyName : UInt16[256]
}
struct QOS_TRAFFIC_CLASS {
    ObjectHdr : QOS_OBJECT_HDR
    TrafficClass : UInt32
}
struct QOS_DS_CLASS {
    ObjectHdr : QOS_OBJECT_HDR
    DSField : UInt32
}
struct QOS_DIFFSERV {
    ObjectHdr : QOS_OBJECT_HDR
    DSFieldCount : UInt32
    DiffservRule : UInt8[1]
}
struct QOS_DIFFSERV_RULE {
    InboundDSField : UInt8
    ConformingOutboundDSField : UInt8
    NonConformingOutboundDSField : UInt8
    ConformingUserPriority : UInt8
    NonConformingUserPriority : UInt8
}
struct QOS_TCP_TRAFFIC {
    ObjectHdr : QOS_OBJECT_HDR
}
struct TCI_NOTIFY_HANDLER extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, HANDLE, UInt32, Struct.Ptr, "Void"]
}
struct TCI_ADD_FLOW_COMPLETE_HANDLER extends FunctionPointer {
    static Types := [HANDLE, UInt32, "Void"]
}
struct TCI_MOD_FLOW_COMPLETE_HANDLER extends FunctionPointer {
    static Types := [HANDLE, UInt32, "Void"]
}
struct TCI_DEL_FLOW_COMPLETE_HANDLER extends FunctionPointer {
    static Types := [HANDLE, UInt32, "Void"]
}
struct TCI_CLIENT_FUNC_LIST {
    ClNotifyHandler : TCI_NOTIFY_HANDLER
    ClAddFlowCompleteHandler : TCI_ADD_FLOW_COMPLETE_HANDLER
    ClModifyFlowCompleteHandler : TCI_MOD_FLOW_COMPLETE_HANDLER
    ClDeleteFlowCompleteHandler : TCI_DEL_FLOW_COMPLETE_HANDLER
}
struct ADDRESS_LIST_DESCRIPTOR {
    MediaType : UInt32
    AddressList : NETWORK_ADDRESS_LIST
}
struct TC_IFC_DESCRIPTOR {
    Length : UInt32
    pInterfaceName : PWSTR
    pInterfaceID : PWSTR
    AddressListDesc : ADDRESS_LIST_DESCRIPTOR
}
struct TC_SUPPORTED_INFO_BUFFER {
    InstanceIDLength : UInt16
    InstanceID : UInt16[256]
    InterfaceLuid : Int64
    AddrListDesc : ADDRESS_LIST_DESCRIPTOR
}
struct TC_GEN_FILTER {
    AddressType : UInt16
    PatternSize : UInt32
    Pattern : Struct.Ptr
    Mask : Struct.Ptr
}
struct TC_GEN_FLOW {
    SendingFlowspec : FLOWSPEC
    ReceivingFlowspec : FLOWSPEC
    TcObjectsLength : UInt32
    TcObjects : QOS_OBJECT_HDR[1]
}
struct IP_PATTERN {
    Reserved1 : UInt32
    Reserved2 : UInt32
    SrcAddr : UInt32
    DstAddr : UInt32
    S_un : this._S_un_e__Union
    ProtocolId : UInt8
    Reserved3 : UInt8[3]
    struct _S_un_e__Union {
        union {
            S_un_ports : this._S_un_ports_e__Struct
            S_un_icmp : this._S_un_icmp_e__Struct
            S_Spi : UInt32
        }
        struct _S_un_ports_e__Struct {
            s_srcport : UInt16
            s_dstport : UInt16
        }
        struct _S_un_icmp_e__Struct {
            s_type : UInt8
            s_code : UInt8
            filler : UInt16
        }
    }
}
struct IPX_PATTERN {
    Src : this._Src_e__Struct
    Dest : this._Src_e__Struct
    struct _Src_e__Struct {
        NetworkAddress : UInt32
        NodeAddress : UInt8[6]
        Socket : UInt16
    }
}
struct ENUMERATION_BUFFER {
    Length : UInt32
    OwnerProcessId : UInt32
    FlowNameLength : UInt16
    FlowName : UInt16[256]
    pFlow : TC_GEN_FLOW.Ptr
    NumberOfFilters : UInt32
    GenericFilter : TC_GEN_FILTER[1]
}
struct IN_ADDR_IPV4 {
    union {
        Addr : UInt32
        AddrBytes : UInt8[4]
    }
}
struct IN_ADDR_IPV6 {
    Addr : UInt8[16]
}
struct RSVP_FILTERSPEC_V4 {
    Address : IN_ADDR_IPV4
    Unused : UInt16
    Port : UInt16
}
struct RSVP_FILTERSPEC_V6 {
    Address : IN_ADDR_IPV6
    UnUsed : UInt16
    Port : UInt16
}
struct RSVP_FILTERSPEC_V6_FLOW {
    Address : IN_ADDR_IPV6
    UnUsed : UInt8
    FlowLabel : UInt8[3]
}
struct RSVP_FILTERSPEC_V4_GPI {
    Address : IN_ADDR_IPV4
    GeneralPortId : UInt32
}
struct RSVP_FILTERSPEC_V6_GPI {
    Address : IN_ADDR_IPV6
    GeneralPortId : UInt32
}
struct FilterType extends Int32 {
    static FILTERSPECV4 := 1
    static FILTERSPECV6 := 2
    static FILTERSPECV6_FLOW := 3
    static FILTERSPECV4_GPI := 4
    static FILTERSPECV6_GPI := 5
    static FILTERSPEC_END := 6
}
struct RSVP_FILTERSPEC {
    Type : FilterType
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FilterSpecV4 : RSVP_FILTERSPEC_V4
            FilterSpecV6 : RSVP_FILTERSPEC_V6
            FilterSpecV6Flow : RSVP_FILTERSPEC_V6_FLOW
            FilterSpecV4Gpi : RSVP_FILTERSPEC_V4_GPI
            FilterSpecV6Gpi : RSVP_FILTERSPEC_V6_GPI
        }
    }
}
struct FLOWDESCRIPTOR {
    FlowSpec : FLOWSPEC
    NumFilters : UInt32
    FilterList : RSVP_FILTERSPEC.Ptr
}
struct RSVP_POLICY {
    Len : UInt16
    Type : UInt16
    Info : UInt8[4]
}
struct RSVP_POLICY_INFO {
    ObjectHdr : QOS_OBJECT_HDR
    NumPolicyElement : UInt32
    PolicyElement : RSVP_POLICY[1]
}
struct RSVP_RESERVE_INFO {
    ObjectHdr : QOS_OBJECT_HDR
    Style : UInt32
    ConfirmRequest : UInt32
    PolicyElementList : RSVP_POLICY_INFO.Ptr
    NumFlowDesc : UInt32
    FlowDescList : FLOWDESCRIPTOR.Ptr
}
struct RSVP_STATUS_INFO {
    ObjectHdr : QOS_OBJECT_HDR
    StatusCode : UInt32
    ExtendedStatus1 : UInt32
    ExtendedStatus2 : UInt32
}
struct QOS_DESTADDR {
    ObjectHdr : QOS_OBJECT_HDR
    SocketAddress : SOCKADDR.Ptr
    SocketAddressLength : UInt32
}
struct AD_GENERAL_PARAMS {
    IntServAwareHopCount : UInt32
    PathBandwidthEstimate : UInt32
    MinimumLatency : UInt32
    PathMTU : UInt32
    Flags : UInt32
}
struct AD_GUARANTEED {
    CTotal : UInt32
    DTotal : UInt32
    CSum : UInt32
    DSum : UInt32
}
struct PARAM_BUFFER {
    ParameterId : UInt32
    Length : UInt32
    Buffer : UInt8[1]
}
struct CONTROL_SERVICE {
    Length : UInt32
    Service : UInt32
    Overrides : AD_GENERAL_PARAMS
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Guaranteed : AD_GUARANTEED
            ParamBuffer : PARAM_BUFFER[1]
        }
    }
}
struct RSVP_ADSPEC {
    ObjectHdr : QOS_OBJECT_HDR
    GeneralParams : AD_GENERAL_PARAMS
    NumberOfServices : UInt32
    Services : CONTROL_SERVICE[1]
}
struct IDPE_ATTR {
    PeAttribLength : UInt16
    PeAttribType : UInt8
    PeAttribSubType : UInt8
    PeAttribValue : UInt8[4]
}
struct SIPAEVENT_REFS_ROLLBACK_PROTECTION_USER_PAYLOAD_HASH_DATA {
    ChecksumType : UInt16
    ChecksumBuffer : UInt8[1]
}
struct SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE extends Int32 {
    static SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE_NONE := 0
    static SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE_CERTIFICATE := 1
    static SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE_TPM := 2
    static SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE_KEY_RING := 4
}
struct SIPAEVENT_REFS_ATTESTATION_CERTIFICATE_HEADER {
    Size : UInt32
    Version : UInt32
    LeafCertificateFingerprintSize : UInt32
    LeafCertificateFingerprint : UInt8[64]
    RootCertificateFingerprintSize : UInt32
    RootCertificateFingerprint : UInt8[64]
    AttestedHashSize : UInt32
    AttestedHash : UInt8[64]
    UserPayloadOffset : UInt32
    UserPayloadSize : UInt32
    LeafCertificateIssuerBlobOffset : UInt32
    LeafCertificateIssuerBlobSize : UInt32
    LeafCertificateSubjectBlobOffset : UInt32
    LeafCertificateSubjectBlobSize : UInt32
    Reserved : Int64[2]
    Data : UInt8[1]
}
struct SIPAEVENT_REFS_ATTESTATION_SUMMARY_HEADER {
    Size : UInt32
    Version : UInt32
    AttestedType : SIPAEVENT_REFS_ATTESTATION_ATTESTED_TYPE
    AttestedHashSize : UInt32
    AttestedHash : UInt8[64]
    ProofOfOriginHashSize : UInt32
    ProofOfOriginHash : UInt8[64]
    Reserved : Int64[4]
    CertificateHeader : SIPAEVENT_REFS_ATTESTATION_CERTIFICATE_HEADER
}
struct WBCL_Iterator {
    firstElementPtr : Struct.Ptr
    logSize : UInt32
    currentElementPtr : Struct.Ptr
    currentElementSize : UInt32
    digestSize : UInt16
    logFormat : UInt16
    numberOfDigests : UInt32
    digestSizes : Struct.Ptr
    supportedAlgorithms : UInt32
    hashAlgorithm : UInt16
}
struct PLUTON_UPGRADE_IMAGEDATA {
    hashAlgID : UInt16
    digestSize : UInt16
    digest : UInt8[64]
    fileName : UInt16[64]
}
struct TCG_PCClientPCREventStruct {
    pcrIndex : UInt32
    eventType : UInt32
    digest : UInt8[20]
    eventDataSize : UInt32
    event : UInt8[1]
}
struct TCG_PCClientTaggedEventStruct {
    EventID : UInt32
    EventDataSize : UInt32
    EventData : UInt8[1]
}
struct WBCL_LogHdr {
    signature : UInt32
    version : UInt32
    entries : UInt32
    length : UInt32
}
struct SIPAEVENT_VSM_IDK_RSA_INFO {
    KeyBitLength : UInt32
    PublicExpLengthBytes : UInt32
    ModulusSizeBytes : UInt32
    PublicKeyData : UInt8[1]
}
struct SIPAEVENT_VSM_IDK_INFO_PAYLOAD {
    KeyAlgID : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            RsaKeyInfo : SIPAEVENT_VSM_IDK_RSA_INFO
        }
    }
}
struct SIPAEVENT_SI_POLICY_PAYLOAD {
    PolicyVersion : Int64
    PolicyNameLength : UInt16
    HashAlgID : UInt16
    DigestLength : UInt32
    VarLengthData : UInt8[1]
}
struct SIPAEVENT_SI_POLICY_CERTIFICATE_PAYLOAD {
    PublisherCommonNameLength : UInt16
    IssuerCommonNameLength : UInt16
    HashAlgID : UInt32
    DigestLength : UInt16
    VarLengthData : UInt8[1]
}
struct SIPAEVENT_SI_POLICY_SIGNER_PAYLOAD {
    RootID : UInt32
    CertificatesLength : UInt32
    CertificatesCount : UInt16
    PolicyNameLength : UInt16
    EKUsLength : UInt16
    EKUsCount : UInt16
    VarLengthData : UInt8[1]
}
struct SIPAEVENT_SI_POLICY_SUPPLEMENTAL_POLICY_INFO_V1 {
    PayloadVersion : UInt32
    VarDataOffset : UInt32
    PolicyNameLength : UInt16
    BasePolicyIDLength : UInt16
}
struct SIPAEVENT_REVOCATION_LIST_PAYLOAD {
    CreationTime : Int64
    DigestLength : UInt32
    HashAlgID : UInt16
    Digest : UInt8[1]
}
struct SIPAEVENT_KSR_SIGNATURE_PAYLOAD {
    SignAlgID : UInt32
    SignatureLength : UInt32
    Signature : UInt8[1]
}
struct SIPAEVENT_SBCP_INFO_PAYLOAD_V1 {
    PayloadVersion : UInt32
    VarDataOffset : UInt32
    HashAlgID : UInt16
    DigestLength : UInt16
    Options : UInt32
    SignersCount : UInt32
    VarData : UInt8[1]
}
