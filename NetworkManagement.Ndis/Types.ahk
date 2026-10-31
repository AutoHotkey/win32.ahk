#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, CHAR, HANDLE}

struct NET_IF_COMPARTMENT_ID {
    Value : UInt32
}
struct NET_IF_OPER_STATUS extends Int32 {
    static NET_IF_OPER_STATUS_UP := 1
    static NET_IF_OPER_STATUS_DOWN := 2
    static NET_IF_OPER_STATUS_TESTING := 3
    static NET_IF_OPER_STATUS_UNKNOWN := 4
    static NET_IF_OPER_STATUS_DORMANT := 5
    static NET_IF_OPER_STATUS_NOT_PRESENT := 6
    static NET_IF_OPER_STATUS_LOWER_LAYER_DOWN := 7
}
struct NET_IF_ADMIN_STATUS extends Int32 {
    static NET_IF_ADMIN_STATUS_UP := 1
    static NET_IF_ADMIN_STATUS_DOWN := 2
    static NET_IF_ADMIN_STATUS_TESTING := 3
}
struct NET_IF_RCV_ADDRESS_TYPE extends Int32 {
    static NET_IF_RCV_ADDRESS_TYPE_OTHER := 1
    static NET_IF_RCV_ADDRESS_TYPE_VOLATILE := 2
    static NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE := 3
}
struct NET_IF_RCV_ADDRESS_LH {
    ifRcvAddressType : NET_IF_RCV_ADDRESS_TYPE
    ifRcvAddressLength : UInt16
    ifRcvAddressOffset : UInt16
}
struct NET_IF_ALIAS_LH {
    ifAliasLength : UInt16
    ifAliasOffset : UInt16
}
struct NET_LUID_LH {
    union {
        Value : Int64
        Info : this._Info_e__Struct
    }
    struct _Info_e__Struct {
        _bitfield : Int64
    }
}
struct NET_IF_CONNECTION_TYPE extends Int32 {
    static NET_IF_CONNECTION_DEDICATED := 1
    static NET_IF_CONNECTION_PASSIVE := 2
    static NET_IF_CONNECTION_DEMAND := 3
    static NET_IF_CONNECTION_MAXIMUM := 4
}
struct TUNNEL_TYPE extends Int32 {
    static TUNNEL_TYPE_NONE := 0
    static TUNNEL_TYPE_OTHER := 1
    static TUNNEL_TYPE_DIRECT := 2
    static TUNNEL_TYPE_6TO4 := 11
    static TUNNEL_TYPE_ISATAP := 13
    static TUNNEL_TYPE_TEREDO := 14
    static TUNNEL_TYPE_IPHTTPS := 15
}
struct NET_IF_ACCESS_TYPE extends Int32 {
    static NET_IF_ACCESS_LOOPBACK := 1
    static NET_IF_ACCESS_BROADCAST := 2
    static NET_IF_ACCESS_POINT_TO_POINT := 3
    static NET_IF_ACCESS_POINT_TO_MULTI_POINT := 4
    static NET_IF_ACCESS_MAXIMUM := 5
}
struct NET_IF_DIRECTION_TYPE extends Int32 {
    static NET_IF_DIRECTION_SENDRECEIVE := 0
    static NET_IF_DIRECTION_SENDONLY := 1
    static NET_IF_DIRECTION_RECEIVEONLY := 2
    static NET_IF_DIRECTION_MAXIMUM := 3
}
struct NET_IF_MEDIA_CONNECT_STATE extends Int32 {
    static MediaConnectStateUnknown := 0
    static MediaConnectStateConnected := 1
    static MediaConnectStateDisconnected := 2
}
struct NET_IF_MEDIA_DUPLEX_STATE extends Int32 {
    static MediaDuplexStateUnknown := 0
    static MediaDuplexStateHalf := 1
    static MediaDuplexStateFull := 2
}
struct NET_PHYSICAL_LOCATION_LH {
    BusNumber : UInt32
    SlotNumber : UInt32
    FunctionNumber : UInt32
}
struct IF_COUNTED_STRING_LH {
    Length : UInt16
    String : UInt16[257]
}
struct IF_PHYSICAL_ADDRESS_LH {
    Length : UInt16
    Address : UInt8[32]
}
struct IF_ADMINISTRATIVE_STATE extends Int32 {
    static IF_ADMINISTRATIVE_DISABLED := 0
    static IF_ADMINISTRATIVE_ENABLED := 1
    static IF_ADMINISTRATIVE_DEMANDDIAL := 2
}
struct IF_OPER_STATUS extends Int32 {
    static IfOperStatusUp := 1
    static IfOperStatusDown := 2
    static IfOperStatusTesting := 3
    static IfOperStatusUnknown := 4
    static IfOperStatusDormant := 5
    static IfOperStatusNotPresent := 6
    static IfOperStatusLowerLayerDown := 7
}
struct NDIS_INTERFACE_INFORMATION {
    ifOperStatus : NET_IF_OPER_STATUS
    ifOperStatusFlags : UInt32
    MediaConnectState : NET_IF_MEDIA_CONNECT_STATE
    MediaDuplexState : NET_IF_MEDIA_DUPLEX_STATE
    ifMtu : UInt32
    ifPromiscuousMode : BOOLEAN
    ifDeviceWakeUpEnable : BOOLEAN
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
    ifLastChange : Int64
    ifCounterDiscontinuityTime : Int64
    ifInUnknownProtos : Int64
    ifInDiscards : Int64
    ifInErrors : Int64
    ifHCInOctets : Int64
    ifHCInUcastPkts : Int64
    ifHCInMulticastPkts : Int64
    ifHCInBroadcastPkts : Int64
    ifHCOutOctets : Int64
    ifHCOutUcastPkts : Int64
    ifHCOutMulticastPkts : Int64
    ifHCOutBroadcastPkts : Int64
    ifOutErrors : Int64
    ifOutDiscards : Int64
    ifHCInUcastOctets : Int64
    ifHCInMulticastOctets : Int64
    ifHCInBroadcastOctets : Int64
    ifHCOutUcastOctets : Int64
    ifHCOutMulticastOctets : Int64
    ifHCOutBroadcastOctets : Int64
    CompartmentId : NET_IF_COMPARTMENT_ID
    SupportedStatistics : UInt32
}
struct NDIS_REQUEST_TYPE extends Int32 {
    static NdisRequestQueryInformation := 0
    static NdisRequestSetInformation := 1
    static NdisRequestQueryStatistics := 2
    static NdisRequestOpen := 3
    static NdisRequestClose := 4
    static NdisRequestSend := 5
    static NdisRequestTransferData := 6
    static NdisRequestReset := 7
    static NdisRequestGeneric1 := 8
    static NdisRequestGeneric2 := 9
    static NdisRequestGeneric3 := 10
    static NdisRequestGeneric4 := 11
}
struct NDIS_STATISTICS_VALUE {
    Oid : UInt32
    DataLength : UInt32
    Data : UInt8[1]
}
struct NDIS_STATISTICS_VALUE_EX {
    Oid : UInt32
    DataLength : UInt32
    Length : UInt32
    Data : UInt8[1]
}
struct NDIS_VAR_DATA_DESC {
    Length : UInt16
    MaximumLength : UInt16
    Offset : IntPtr
}
struct NDIS_OBJECT_HEADER {
    Type : UInt8
    Revision : UInt8
    Size : UInt16
}
struct NDIS_STATISTICS_INFO {
    Header : NDIS_OBJECT_HEADER
    SupportedStatistics : UInt32
    ifInDiscards : Int64
    ifInErrors : Int64
    ifHCInOctets : Int64
    ifHCInUcastPkts : Int64
    ifHCInMulticastPkts : Int64
    ifHCInBroadcastPkts : Int64
    ifHCOutOctets : Int64
    ifHCOutUcastPkts : Int64
    ifHCOutMulticastPkts : Int64
    ifHCOutBroadcastPkts : Int64
    ifOutErrors : Int64
    ifOutDiscards : Int64
    ifHCInUcastOctets : Int64
    ifHCInMulticastOctets : Int64
    ifHCInBroadcastOctets : Int64
    ifHCOutUcastOctets : Int64
    ifHCOutMulticastOctets : Int64
    ifHCOutBroadcastOctets : Int64
}
struct NDIS_INTERRUPT_MODERATION extends Int32 {
    static NdisInterruptModerationUnknown := 0
    static NdisInterruptModerationNotSupported := 1
    static NdisInterruptModerationEnabled := 2
    static NdisInterruptModerationDisabled := 3
}
struct NDIS_INTERRUPT_MODERATION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    InterruptModeration : NDIS_INTERRUPT_MODERATION
}
struct NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    TimeoutArrayLength : UInt32
    TimeoutArray : UInt32[1]
}
struct NDIS_PCI_DEVICE_CUSTOM_PROPERTIES {
    Header : NDIS_OBJECT_HEADER
    DeviceType : UInt32
    CurrentSpeedAndMode : UInt32
    CurrentPayloadSize : UInt32
    MaxPayloadSize : UInt32
    MaxReadRequestSize : UInt32
    CurrentLinkSpeed : UInt32
    CurrentLinkWidth : UInt32
    MaxLinkSpeed : UInt32
    MaxLinkWidth : UInt32
    PciExpressVersion : UInt32
    InterruptType : UInt32
    MaxInterruptMessages : UInt32
}
struct NDIS_802_11_STATUS_TYPE extends Int32 {
    static Ndis802_11StatusType_Authentication := 0
    static Ndis802_11StatusType_MediaStreamMode := 1
    static Ndis802_11StatusType_PMKID_CandidateList := 2
    static Ndis802_11StatusTypeMax := 3
}
struct NDIS_802_11_STATUS_INDICATION {
    StatusType : NDIS_802_11_STATUS_TYPE
}
struct NDIS_802_11_AUTHENTICATION_REQUEST {
    Length : UInt32
    Bssid : UInt8[6]
    Flags : UInt32
}
struct PMKID_CANDIDATE {
    BSSID : UInt8[6]
    Flags : UInt32
}
struct NDIS_802_11_PMKID_CANDIDATE_LIST {
    Version : UInt32
    NumCandidates : UInt32
    CandidateList : PMKID_CANDIDATE[1]
}
struct NDIS_802_11_NETWORK_TYPE extends Int32 {
    static Ndis802_11FH := 0
    static Ndis802_11DS := 1
    static Ndis802_11OFDM5 := 2
    static Ndis802_11OFDM24 := 3
    static Ndis802_11Automode := 4
    static Ndis802_11NetworkTypeMax := 5
}
struct NDIS_802_11_NETWORK_TYPE_LIST {
    NumberOfItems : UInt32
    NetworkType : NDIS_802_11_NETWORK_TYPE[1]
}
struct NDIS_802_11_POWER_MODE extends Int32 {
    static Ndis802_11PowerModeCAM := 0
    static Ndis802_11PowerModeMAX_PSP := 1
    static Ndis802_11PowerModeFast_PSP := 2
    static Ndis802_11PowerModeMax := 3
}
struct NDIS_802_11_CONFIGURATION_FH {
    Length : UInt32
    HopPattern : UInt32
    HopSet : UInt32
    DwellTime : UInt32
}
struct NDIS_802_11_CONFIGURATION {
    Length : UInt32
    BeaconPeriod : UInt32
    ATIMWindow : UInt32
    DSConfig : UInt32
    FHConfig : NDIS_802_11_CONFIGURATION_FH
}
struct NDIS_802_11_STATISTICS {
    Length : UInt32
    TransmittedFragmentCount : Int64
    MulticastTransmittedFrameCount : Int64
    FailedCount : Int64
    RetryCount : Int64
    MultipleRetryCount : Int64
    RTSSuccessCount : Int64
    RTSFailureCount : Int64
    ACKFailureCount : Int64
    FrameDuplicateCount : Int64
    ReceivedFragmentCount : Int64
    MulticastReceivedFrameCount : Int64
    FCSErrorCount : Int64
    TKIPLocalMICFailures : Int64
    TKIPICVErrorCount : Int64
    TKIPCounterMeasuresInvoked : Int64
    TKIPReplays : Int64
    CCMPFormatErrors : Int64
    CCMPReplays : Int64
    CCMPDecryptErrors : Int64
    FourWayHandshakeFailures : Int64
    WEPUndecryptableCount : Int64
    WEPICVErrorCount : Int64
    DecryptSuccessCount : Int64
    DecryptFailureCount : Int64
}
struct NDIS_802_11_KEY {
    Length : UInt32
    KeyIndex : UInt32
    KeyLength : UInt32
    BSSID : UInt8[6]
    KeyRSC : Int64
    KeyMaterial : UInt8[1]
}
struct NDIS_802_11_REMOVE_KEY {
    Length : UInt32
    KeyIndex : UInt32
    BSSID : UInt8[6]
}
struct NDIS_802_11_WEP {
    Length : UInt32
    KeyIndex : UInt32
    KeyLength : UInt32
    KeyMaterial : UInt8[1]
}
struct NDIS_802_11_NETWORK_INFRASTRUCTURE extends Int32 {
    static Ndis802_11IBSS := 0
    static Ndis802_11Infrastructure := 1
    static Ndis802_11AutoUnknown := 2
    static Ndis802_11InfrastructureMax := 3
}
struct NDIS_802_11_AUTHENTICATION_MODE extends Int32 {
    static Ndis802_11AuthModeOpen := 0
    static Ndis802_11AuthModeShared := 1
    static Ndis802_11AuthModeAutoSwitch := 2
    static Ndis802_11AuthModeWPA := 3
    static Ndis802_11AuthModeWPAPSK := 4
    static Ndis802_11AuthModeWPANone := 5
    static Ndis802_11AuthModeWPA2 := 6
    static Ndis802_11AuthModeWPA2PSK := 7
    static Ndis802_11AuthModeWPA3 := 8
    static Ndis802_11AuthModeWPA3Ent192 := 8
    static Ndis802_11AuthModeWPA3SAE := 9
    static Ndis802_11AuthModeWPA3Ent := 10
    static Ndis802_11AuthModeMax := 11
}
struct NDIS_802_11_SSID {
    SsidLength : UInt32
    Ssid : UInt8[32]
}
struct NDIS_WLAN_BSSID {
    Length : UInt32
    MacAddress : UInt8[6]
    Reserved : UInt8[2]
    Ssid : NDIS_802_11_SSID
    Privacy : UInt32
    Rssi : Int32
    NetworkTypeInUse : NDIS_802_11_NETWORK_TYPE
    Configuration : NDIS_802_11_CONFIGURATION
    InfrastructureMode : NDIS_802_11_NETWORK_INFRASTRUCTURE
    SupportedRates : UInt8[8]
}
struct NDIS_802_11_BSSID_LIST {
    NumberOfItems : UInt32
    Bssid : NDIS_WLAN_BSSID[1]
}
struct NDIS_WLAN_BSSID_EX {
    Length : UInt32
    MacAddress : UInt8[6]
    Reserved : UInt8[2]
    Ssid : NDIS_802_11_SSID
    Privacy : UInt32
    Rssi : Int32
    NetworkTypeInUse : NDIS_802_11_NETWORK_TYPE
    Configuration : NDIS_802_11_CONFIGURATION
    InfrastructureMode : NDIS_802_11_NETWORK_INFRASTRUCTURE
    SupportedRates : UInt8[16]
    IELength : UInt32
    IEs : UInt8[1]
}
struct NDIS_802_11_BSSID_LIST_EX {
    NumberOfItems : UInt32
    Bssid : NDIS_WLAN_BSSID_EX[1]
}
struct NDIS_802_11_FIXED_IEs {
    Timestamp : UInt8[8]
    BeaconInterval : UInt16
    Capabilities : UInt16
}
struct NDIS_802_11_VARIABLE_IEs {
    ElementID : UInt8
    Length : UInt8
    data : UInt8[1]
}
struct NDIS_802_11_PRIVACY_FILTER extends Int32 {
    static Ndis802_11PrivFilterAcceptAll := 0
    static Ndis802_11PrivFilter8021xWEP := 1
}
struct NDIS_802_11_WEP_STATUS extends Int32 {
    static Ndis802_11WEPEnabled := 0
    static Ndis802_11Encryption1Enabled := 0
    static Ndis802_11WEPDisabled := 1
    static Ndis802_11EncryptionDisabled := 1
    static Ndis802_11WEPKeyAbsent := 2
    static Ndis802_11Encryption1KeyAbsent := 2
    static Ndis802_11WEPNotSupported := 3
    static Ndis802_11EncryptionNotSupported := 3
    static Ndis802_11Encryption2Enabled := 4
    static Ndis802_11Encryption2KeyAbsent := 5
    static Ndis802_11Encryption3Enabled := 6
    static Ndis802_11Encryption3KeyAbsent := 7
}
struct NDIS_802_11_RELOAD_DEFAULTS extends Int32 {
    static Ndis802_11ReloadWEPKeys := 0
}
struct NDIS_802_11_AI_REQFI {
    Capabilities : UInt16
    ListenInterval : UInt16
    CurrentAPAddress : UInt8[6]
}
struct NDIS_802_11_AI_RESFI {
    Capabilities : UInt16
    StatusCode : UInt16
    AssociationId : UInt16
}
struct NDIS_802_11_ASSOCIATION_INFORMATION {
    Length : UInt32
    AvailableRequestFixedIEs : UInt16
    RequestFixedIEs : NDIS_802_11_AI_REQFI
    RequestIELength : UInt32
    OffsetRequestIEs : UInt32
    AvailableResponseFixedIEs : UInt16
    ResponseFixedIEs : NDIS_802_11_AI_RESFI
    ResponseIELength : UInt32
    OffsetResponseIEs : UInt32
}
struct NDIS_802_11_AUTHENTICATION_EVENT {
    Status : NDIS_802_11_STATUS_INDICATION
    Request : NDIS_802_11_AUTHENTICATION_REQUEST[1]
}
struct NDIS_802_11_TEST {
    Length : UInt32
    Type : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            AuthenticationEvent : NDIS_802_11_AUTHENTICATION_EVENT
            RssiTrigger : Int32
        }
    }
}
struct NDIS_802_11_MEDIA_STREAM_MODE extends Int32 {
    static Ndis802_11MediaStreamOff := 0
    static Ndis802_11MediaStreamOn := 1
}
struct BSSID_INFO {
    BSSID : UInt8[6]
    PMKID : UInt8[16]
}
struct NDIS_802_11_PMKID {
    Length : UInt32
    BSSIDInfoCount : UInt32
    BSSIDInfo : BSSID_INFO[1]
}
struct NDIS_802_11_AUTHENTICATION_ENCRYPTION {
    AuthModeSupported : NDIS_802_11_AUTHENTICATION_MODE
    EncryptStatusSupported : NDIS_802_11_WEP_STATUS
}
struct NDIS_802_11_CAPABILITY {
    Length : UInt32
    Version : UInt32
    NoOfPMKIDs : UInt32
    NoOfAuthEncryptPairsSupported : UInt32
    AuthenticationEncryptionSupported : NDIS_802_11_AUTHENTICATION_ENCRYPTION[1]
}
struct NDIS_802_11_NON_BCAST_SSID_LIST {
    NumberOfItems : UInt32
    Non_Bcast_Ssid : NDIS_802_11_SSID[1]
}
struct NDIS_802_11_RADIO_STATUS extends Int32 {
    static Ndis802_11RadioStatusOn := 0
    static Ndis802_11RadioStatusHardwareOff := 1
    static Ndis802_11RadioStatusSoftwareOff := 2
    static Ndis802_11RadioStatusHardwareSoftwareOff := 3
    static Ndis802_11RadioStatusMax := 4
}
struct NDIS_CO_DEVICE_PROFILE {
    DeviceDescription : NDIS_VAR_DATA_DESC
    DevSpecificInfo : NDIS_VAR_DATA_DESC
    ulTAPISupplementaryPassThru : UInt32
    ulAddressModes : UInt32
    ulNumAddresses : UInt32
    ulBearerModes : UInt32
    ulMaxTxRate : UInt32
    ulMinTxRate : UInt32
    ulMaxRxRate : UInt32
    ulMinRxRate : UInt32
    ulMediaModes : UInt32
    ulGenerateToneModes : UInt32
    ulGenerateToneMaxNumFreq : UInt32
    ulGenerateDigitModes : UInt32
    ulMonitorToneMaxNumFreq : UInt32
    ulMonitorToneMaxNumEntries : UInt32
    ulMonitorDigitModes : UInt32
    ulGatherDigitsMinTimeout : UInt32
    ulGatherDigitsMaxTimeout : UInt32
    ulDevCapFlags : UInt32
    ulMaxNumActiveCalls : UInt32
    ulAnswerMode : UInt32
    ulUUIAcceptSize : UInt32
    ulUUIAnswerSize : UInt32
    ulUUIMakeCallSize : UInt32
    ulUUIDropSize : UInt32
    ulUUISendUserUserInfoSize : UInt32
    ulUUICallInfoSize : UInt32
}
struct OFFLOAD_OPERATION_E extends Int32 {
    static AUTHENTICATE := 1
    static ENCRYPT := 2
}
struct OFFLOAD_ALGO_INFO {
    algoIdentifier : UInt32
    algoKeylen : UInt32
    algoRounds : UInt32
}
struct OFFLOAD_CONF_ALGO extends Int32 {
    static OFFLOAD_IPSEC_CONF_NONE := 0
    static OFFLOAD_IPSEC_CONF_DES := 1
    static OFFLOAD_IPSEC_CONF_RESERVED := 2
    static OFFLOAD_IPSEC_CONF_3_DES := 3
    static OFFLOAD_IPSEC_CONF_MAX := 4
}
struct OFFLOAD_INTEGRITY_ALGO extends Int32 {
    static OFFLOAD_IPSEC_INTEGRITY_NONE := 0
    static OFFLOAD_IPSEC_INTEGRITY_MD5 := 1
    static OFFLOAD_IPSEC_INTEGRITY_SHA := 2
    static OFFLOAD_IPSEC_INTEGRITY_MAX := 3
}
struct OFFLOAD_SECURITY_ASSOCIATION {
    Operation : OFFLOAD_OPERATION_E
    SPI : UInt32
    IntegrityAlgo : OFFLOAD_ALGO_INFO
    ConfAlgo : OFFLOAD_ALGO_INFO
    Reserved : OFFLOAD_ALGO_INFO
}
struct OFFLOAD_IPSEC_ADD_SA {
    SrcAddr : UInt32
    SrcMask : UInt32
    DestAddr : UInt32
    DestMask : UInt32
    Protocol : UInt32
    SrcPort : UInt16
    DestPort : UInt16
    SrcTunnelAddr : UInt32
    DestTunnelAddr : UInt32
    Flags : UInt16
    NumSAs : Int16
    SecAssoc : OFFLOAD_SECURITY_ASSOCIATION[3]
    OffloadHandle : HANDLE
    KeyLen : UInt32
    KeyMat : UInt8[1]
}
struct OFFLOAD_IPSEC_DELETE_SA {
    OffloadHandle : HANDLE
}
struct UDP_ENCAP_TYPE extends Int32 {
    static OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE := 0
    static OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER := 1
}
struct OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY {
    UdpEncapType : UDP_ENCAP_TYPE
    DstEncapPort : UInt16
}
struct OFFLOAD_IPSEC_ADD_UDPESP_SA {
    SrcAddr : UInt32
    SrcMask : UInt32
    DstAddr : UInt32
    DstMask : UInt32
    Protocol : UInt32
    SrcPort : UInt16
    DstPort : UInt16
    SrcTunnelAddr : UInt32
    DstTunnelAddr : UInt32
    Flags : UInt16
    NumSAs : Int16
    SecAssoc : OFFLOAD_SECURITY_ASSOCIATION[3]
    OffloadHandle : HANDLE
    EncapTypeEntry : OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
    EncapTypeEntryOffldHandle : HANDLE
    KeyLen : UInt32
    KeyMat : UInt8[1]
}
struct OFFLOAD_IPSEC_DELETE_UDPESP_SA {
    OffloadHandle : HANDLE
    EncapTypeEntryOffldHandle : HANDLE
}
struct NDIS_MEDIUM extends Int32 {
    static NdisMedium802_3 := 0
    static NdisMedium802_5 := 1
    static NdisMediumFddi := 2
    static NdisMediumWan := 3
    static NdisMediumLocalTalk := 4
    static NdisMediumDix := 5
    static NdisMediumArcnetRaw := 6
    static NdisMediumArcnet878_2 := 7
    static NdisMediumAtm := 8
    static NdisMediumWirelessWan := 9
    static NdisMediumIrda := 10
    static NdisMediumBpc := 11
    static NdisMediumCoWan := 12
    static NdisMedium1394 := 13
    static NdisMediumInfiniBand := 14
    static NdisMediumTunnel := 15
    static NdisMediumNative802_11 := 16
    static NdisMediumLoopback := 17
    static NdisMediumWiMAX := 18
    static NdisMediumIP := 19
    static NdisMediumMax := 20
}
struct NDIS_PHYSICAL_MEDIUM extends Int32 {
    static NdisPhysicalMediumUnspecified := 0
    static NdisPhysicalMediumWirelessLan := 1
    static NdisPhysicalMediumCableModem := 2
    static NdisPhysicalMediumPhoneLine := 3
    static NdisPhysicalMediumPowerLine := 4
    static NdisPhysicalMediumDSL := 5
    static NdisPhysicalMediumFibreChannel := 6
    static NdisPhysicalMedium1394 := 7
    static NdisPhysicalMediumWirelessWan := 8
    static NdisPhysicalMediumNative802_11 := 9
    static NdisPhysicalMediumBluetooth := 10
    static NdisPhysicalMediumInfiniband := 11
    static NdisPhysicalMediumWiMax := 12
    static NdisPhysicalMediumUWB := 13
    static NdisPhysicalMedium802_3 := 14
    static NdisPhysicalMedium802_5 := 15
    static NdisPhysicalMediumIrda := 16
    static NdisPhysicalMediumWiredWAN := 17
    static NdisPhysicalMediumWiredCoWan := 18
    static NdisPhysicalMediumOther := 19
    static NdisPhysicalMediumNative802_15_4 := 20
    static NdisPhysicalMediumMax := 21
}
struct TRANSPORT_HEADER_OFFSET {
    ProtocolType : UInt16
    HeaderOffset : UInt16
}
struct NETWORK_ADDRESS {
    AddressLength : UInt16
    AddressType : UInt16
    Address : UInt8[1]
}
struct NETWORK_ADDRESS_LIST {
    AddressCount : Int32
    AddressType : UInt16
    Address : NETWORK_ADDRESS[1]
}
struct NETWORK_ADDRESS_IP {
    sin_port : UInt16
    IN_ADDR : UInt32
    sin_zero : UInt8[8]
}
struct NETWORK_ADDRESS_IP6 {
    sin6_port : UInt16
    sin6_flowinfo : UInt32
    sin6_addr : UInt16[8]
    sin6_scope_id : UInt32
}
struct NETWORK_ADDRESS_IPX {
    NetworkAddress : UInt32
    NodeAddress : UInt8[6]
    Socket : UInt16
}
struct NDIS_HARDWARE_STATUS extends Int32 {
    static NdisHardwareStatusReady := 0
    static NdisHardwareStatusInitializing := 1
    static NdisHardwareStatusReset := 2
    static NdisHardwareStatusClosing := 3
    static NdisHardwareStatusNotReady := 4
}
struct GEN_GET_TIME_CAPS {
    Flags : UInt32
    ClockPrecision : UInt32
}
struct GEN_GET_NETCARD_TIME {
    ReadTime : Int64
}
struct NDIS_PM_PACKET_PATTERN {
    Priority : UInt32
    Reserved : UInt32
    MaskSize : UInt32
    PatternOffset : UInt32
    PatternSize : UInt32
    PatternFlags : UInt32
}
struct NDIS_DEVICE_POWER_STATE extends Int32 {
    static NdisDeviceStateUnspecified := 0
    static NdisDeviceStateD0 := 1
    static NdisDeviceStateD1 := 2
    static NdisDeviceStateD2 := 3
    static NdisDeviceStateD3 := 4
    static NdisDeviceStateMaximum := 5
}
struct NDIS_PM_WAKE_UP_CAPABILITIES {
    MinMagicPacketWakeUp : NDIS_DEVICE_POWER_STATE
    MinPatternWakeUp : NDIS_DEVICE_POWER_STATE
    MinLinkChangeWakeUp : NDIS_DEVICE_POWER_STATE
}
struct NDIS_PNP_CAPABILITIES {
    Flags : UInt32
    WakeUpCapabilities : NDIS_PM_WAKE_UP_CAPABILITIES
}
struct NDIS_FDDI_ATTACHMENT_TYPE extends Int32 {
    static NdisFddiTypeIsolated := 1
    static NdisFddiTypeLocalA := 2
    static NdisFddiTypeLocalB := 3
    static NdisFddiTypeLocalAB := 4
    static NdisFddiTypeLocalS := 5
    static NdisFddiTypeWrapA := 6
    static NdisFddiTypeWrapB := 7
    static NdisFddiTypeWrapAB := 8
    static NdisFddiTypeWrapS := 9
    static NdisFddiTypeCWrapA := 10
    static NdisFddiTypeCWrapB := 11
    static NdisFddiTypeCWrapS := 12
    static NdisFddiTypeThrough := 13
}
struct NDIS_FDDI_RING_MGT_STATE extends Int32 {
    static NdisFddiRingIsolated := 1
    static NdisFddiRingNonOperational := 2
    static NdisFddiRingOperational := 3
    static NdisFddiRingDetect := 4
    static NdisFddiRingNonOperationalDup := 5
    static NdisFddiRingOperationalDup := 6
    static NdisFddiRingDirected := 7
    static NdisFddiRingTrace := 8
}
struct NDIS_FDDI_LCONNECTION_STATE extends Int32 {
    static NdisFddiStateOff := 1
    static NdisFddiStateBreak := 2
    static NdisFddiStateTrace := 3
    static NdisFddiStateConnect := 4
    static NdisFddiStateNext := 5
    static NdisFddiStateSignal := 6
    static NdisFddiStateJoin := 7
    static NdisFddiStateVerify := 8
    static NdisFddiStateActive := 9
    static NdisFddiStateMaintenance := 10
}
struct NDIS_WAN_MEDIUM_SUBTYPE extends Int32 {
    static NdisWanMediumHub := 0
    static NdisWanMediumX_25 := 1
    static NdisWanMediumIsdn := 2
    static NdisWanMediumSerial := 3
    static NdisWanMediumFrameRelay := 4
    static NdisWanMediumAtm := 5
    static NdisWanMediumSonet := 6
    static NdisWanMediumSW56K := 7
    static NdisWanMediumPPTP := 8
    static NdisWanMediumL2TP := 9
    static NdisWanMediumIrda := 10
    static NdisWanMediumParallel := 11
    static NdisWanMediumPppoe := 12
    static NdisWanMediumSSTP := 13
    static NdisWanMediumAgileVPN := 14
    static NdisWanMediumGre := 15
    static NdisWanMediumSubTypeMax := 16
}
struct NDIS_WAN_HEADER_FORMAT extends Int32 {
    static NdisWanHeaderNative := 0
    static NdisWanHeaderEthernet := 1
}
struct NDIS_WAN_QUALITY extends Int32 {
    static NdisWanRaw := 0
    static NdisWanErrorControl := 1
    static NdisWanReliable := 2
}
struct NDIS_WAN_PROTOCOL_CAPS {
    Flags : UInt32
    Reserved : UInt32
}
struct NDIS_802_5_RING_STATE extends Int32 {
    static NdisRingStateOpened := 1
    static NdisRingStateClosed := 2
    static NdisRingStateOpening := 3
    static NdisRingStateClosing := 4
    static NdisRingStateOpenFailure := 5
    static NdisRingStateRingFailure := 6
}
struct NDIS_MEDIA_STATE extends Int32 {
    static NdisMediaStateConnected := 0
    static NdisMediaStateDisconnected := 1
}
struct NDIS_CO_LINK_SPEED {
    Outbound : UInt32
    Inbound : UInt32
}
struct NDIS_LINK_SPEED {
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
}
struct NDIS_GUID {
    Guid : GUID
    Anonymous : this._Anonymous_e__Union
    Size : UInt32
    Flags : UInt32
    struct _Anonymous_e__Union {
        union {
            Oid : UInt32
            Status : Int32
        }
    }
}
struct NDIS_IRDA_PACKET_INFO {
    ExtraBOFs : UInt32
    MinTurnAroundTime : UInt32
}
struct NDIS_SUPPORTED_PAUSE_FUNCTIONS extends Int32 {
    static NdisPauseFunctionsUnsupported := 0
    static NdisPauseFunctionsSendOnly := 1
    static NdisPauseFunctionsReceiveOnly := 2
    static NdisPauseFunctionsSendAndReceive := 3
    static NdisPauseFunctionsUnknown := 4
}
struct NDIS_LINK_STATE {
    Header : NDIS_OBJECT_HEADER
    MediaConnectState : NET_IF_MEDIA_CONNECT_STATE
    MediaDuplexState : NET_IF_MEDIA_DUPLEX_STATE
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
    PauseFunctions : NDIS_SUPPORTED_PAUSE_FUNCTIONS
    AutoNegotiationFlags : UInt32
}
struct NDIS_LINK_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    MediaDuplexState : NET_IF_MEDIA_DUPLEX_STATE
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
    PauseFunctions : NDIS_SUPPORTED_PAUSE_FUNCTIONS
    AutoNegotiationFlags : UInt32
}
struct NDIS_OPER_STATE {
    Header : NDIS_OBJECT_HEADER
    OperationalStatus : NET_IF_OPER_STATUS
    OperationalStatusFlags : UInt32
}
struct NDIS_IP_OPER_STATUS {
    AddressFamily : UInt32
    OperationalStatus : NET_IF_OPER_STATUS
    OperationalStatusFlags : UInt32
}
struct NDIS_IP_OPER_STATUS_INFO {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    NumberofAddressFamiliesReturned : UInt32
    IpOperationalStatus : NDIS_IP_OPER_STATUS[32]
}
struct NDIS_IP_OPER_STATE {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    IpOperationalStatus : NDIS_IP_OPER_STATUS
}
struct NDIS_OFFLOAD_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    IPv4Checksum : UInt8
    TCPIPv4Checksum : UInt8
    UDPIPv4Checksum : UInt8
    TCPIPv6Checksum : UInt8
    UDPIPv6Checksum : UInt8
    LsoV1 : UInt8
    IPsecV1 : UInt8
    LsoV2IPv4 : UInt8
    LsoV2IPv6 : UInt8
    TcpConnectionIPv4 : UInt8
    TcpConnectionIPv6 : UInt8
    Flags : UInt32
}
struct NDIS_TCP_LARGE_SEND_OFFLOAD_V1 {
    IPv4 : this._IPv4_e__Struct
    struct _IPv4_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
        _bitfield : UInt32
    }
}
struct NDIS_TCP_IP_CHECKSUM_OFFLOAD {
    IPv4Transmit : this._IPv4Transmit_e__Struct
    IPv4Receive : this._IPv4Receive_e__Struct
    IPv6Transmit : this._IPv6Transmit_e__Struct
    IPv6Receive : this._IPv6Receive_e__Struct
    struct _IPv4Transmit_e__Struct {
        Encapsulation : UInt32
        _bitfield : UInt32
    }
    struct _IPv4Receive_e__Struct {
        Encapsulation : UInt32
        _bitfield : UInt32
    }
    struct _IPv6Transmit_e__Struct {
        Encapsulation : UInt32
        _bitfield : UInt32
    }
    struct _IPv6Receive_e__Struct {
        Encapsulation : UInt32
        _bitfield : UInt32
    }
}
struct NDIS_IPSEC_OFFLOAD_V1 {
    Supported : this._Supported_e__Struct
    IPv4AH : this._IPv4AH_e__Struct
    IPv4ESP : this._IPv4ESP_e__Struct
    struct _Supported_e__Struct {
        Encapsulation : UInt32
        AhEspCombined : UInt32
        TransportTunnelCombined : UInt32
        IPv4Options : UInt32
        Flags : UInt32
    }
    struct _IPv4AH_e__Struct {
        _bitfield : UInt32
    }
    struct _IPv4ESP_e__Struct {
        _bitfield : UInt32
    }
}
struct NDIS_TCP_LARGE_SEND_OFFLOAD_V2 {
    IPv4 : this._IPv4_e__Struct
    IPv6 : this._IPv6_e__Struct
    struct _IPv4_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
    }
    struct _IPv6_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
        _bitfield : UInt32
    }
}
struct NDIS_OFFLOAD {
    Header : NDIS_OBJECT_HEADER
    Checksum : NDIS_TCP_IP_CHECKSUM_OFFLOAD
    LsoV1 : NDIS_TCP_LARGE_SEND_OFFLOAD_V1
    IPsecV1 : NDIS_IPSEC_OFFLOAD_V1
    LsoV2 : NDIS_TCP_LARGE_SEND_OFFLOAD_V2
    Flags : UInt32
}
struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1 {
    IPv4 : this._IPv4_e__Struct
    struct _IPv4_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
        TcpOptions : UInt32
        IpOptions : UInt32
    }
}
struct NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD {
    IPv4Transmit : this._IPv4Transmit_e__Struct
    IPv4Receive : this._IPv4Receive_e__Struct
    IPv6Transmit : this._IPv6Transmit_e__Struct
    IPv6Receive : this._IPv6Receive_e__Struct
    struct _IPv4Transmit_e__Struct {
        Encapsulation : UInt32
        IpOptionsSupported : UInt32
        TcpOptionsSupported : UInt32
        TcpChecksum : UInt32
        UdpChecksum : UInt32
        IpChecksum : UInt32
    }
    struct _IPv4Receive_e__Struct {
        Encapsulation : UInt32
        IpOptionsSupported : UInt32
        TcpOptionsSupported : UInt32
        TcpChecksum : UInt32
        UdpChecksum : UInt32
        IpChecksum : UInt32
    }
    struct _IPv6Transmit_e__Struct {
        Encapsulation : UInt32
        IpExtensionHeadersSupported : UInt32
        TcpOptionsSupported : UInt32
        TcpChecksum : UInt32
        UdpChecksum : UInt32
    }
    struct _IPv6Receive_e__Struct {
        Encapsulation : UInt32
        IpExtensionHeadersSupported : UInt32
        TcpOptionsSupported : UInt32
        TcpChecksum : UInt32
        UdpChecksum : UInt32
    }
}
struct NDIS_WMI_IPSEC_OFFLOAD_V1 {
    Supported : this._Supported_e__Struct
    IPv4AH : this._IPv4AH_e__Struct
    IPv4ESP : this._IPv4ESP_e__Struct
    struct _Supported_e__Struct {
        Encapsulation : UInt32
        AhEspCombined : UInt32
        TransportTunnelCombined : UInt32
        IPv4Options : UInt32
        Flags : UInt32
    }
    struct _IPv4AH_e__Struct {
        Md5 : UInt32
        Sha_1 : UInt32
        Transport : UInt32
        Tunnel : UInt32
        Send : UInt32
        Receive : UInt32
    }
    struct _IPv4ESP_e__Struct {
        Des : UInt32
        Reserved : UInt32
        TripleDes : UInt32
        NullEsp : UInt32
        Transport : UInt32
        Tunnel : UInt32
        Send : UInt32
        Receive : UInt32
    }
}
struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2 {
    IPv4 : this._IPv4_e__Struct
    IPv6 : this._IPv6_e__Struct
    struct _IPv4_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
    }
    struct _IPv6_e__Struct {
        Encapsulation : UInt32
        MaxOffLoadSize : UInt32
        MinSegmentCount : UInt32
        IpExtensionHeadersSupported : UInt32
        TcpOptionsSupported : UInt32
    }
}
struct NDIS_WMI_OFFLOAD {
    Header : NDIS_OBJECT_HEADER
    Checksum : NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
    LsoV1 : NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
    IPsecV1 : NDIS_WMI_IPSEC_OFFLOAD_V1
    LsoV2 : NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
    Flags : UInt32
}
struct NDIS_TCP_CONNECTION_OFFLOAD {
    Header : NDIS_OBJECT_HEADER
    Encapsulation : UInt32
    _bitfield : UInt32
    TcpConnectionOffloadCapacity : UInt32
    Flags : UInt32
}
struct NDIS_WMI_TCP_CONNECTION_OFFLOAD {
    Header : NDIS_OBJECT_HEADER
    Encapsulation : UInt32
    SupportIPv4 : UInt32
    SupportIPv6 : UInt32
    SupportIPv6ExtensionHeaders : UInt32
    SupportSack : UInt32
    TcpConnectionOffloadCapacity : UInt32
    Flags : UInt32
}
struct NDIS_PORT_TYPE extends Int32 {
    static NdisPortTypeUndefined := 0
    static NdisPortTypeBridge := 1
    static NdisPortTypeRasConnection := 2
    static NdisPortType8021xSupplicant := 3
    static NdisPortTypeMax := 4
}
struct NDIS_PORT_AUTHORIZATION_STATE extends Int32 {
    static NdisPortAuthorizationUnknown := 0
    static NdisPortAuthorized := 1
    static NdisPortUnauthorized := 2
    static NdisPortReauthorizing := 3
}
struct NDIS_PORT_CONTROL_STATE extends Int32 {
    static NdisPortControlStateUnknown := 0
    static NdisPortControlStateControlled := 1
    static NdisPortControlStateUncontrolled := 2
}
struct NDIS_PORT_AUTHENTICATION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    SendControlState : NDIS_PORT_CONTROL_STATE
    RcvControlState : NDIS_PORT_CONTROL_STATE
    SendAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
}
struct NDIS_NETWORK_CHANGE_TYPE extends Int32 {
    static NdisPossibleNetworkChange := 1
    static NdisDefinitelyNetworkChange := 2
    static NdisNetworkChangeFromMediaConnect := 3
    static NdisNetworkChangeMax := 4
}
struct NDIS_WMI_METHOD_HEADER {
    Header : NDIS_OBJECT_HEADER
    PortNumber : UInt32
    NetLuid : NET_LUID_LH
    RequestId : Int64
    Timeout : UInt32
    Padding : UInt8[4]
}
struct NDIS_WMI_SET_HEADER {
    Header : NDIS_OBJECT_HEADER
    PortNumber : UInt32
    NetLuid : NET_LUID_LH
    RequestId : Int64
    Timeout : UInt32
    Padding : UInt8[4]
}
struct NDIS_WMI_EVENT_HEADER {
    Header : NDIS_OBJECT_HEADER
    IfIndex : UInt32
    NetLuid : NET_LUID_LH
    RequestId : Int64
    PortNumber : UInt32
    DeviceNameLength : UInt32
    DeviceNameOffset : UInt32
    Padding : UInt8[4]
}
struct NDIS_WMI_ENUM_ADAPTER {
    Header : NDIS_OBJECT_HEADER
    IfIndex : UInt32
    NetLuid : NET_LUID_LH
    DeviceNameLength : UInt16
    DeviceName : CHAR[1]
}
struct NDIS_WMI_OUTPUT_INFO {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    SupportedRevision : UInt8
    DataOffset : UInt32
}
struct NDIS_RECEIVE_SCALE_CAPABILITIES {
    Header : NDIS_OBJECT_HEADER
    CapabilitiesFlags : UInt32
    NumberOfInterruptMessages : UInt32
    NumberOfReceiveQueues : UInt32
}
struct NDIS_RECEIVE_SCALE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt16
    BaseCpuNumber : UInt16
    HashInformation : UInt32
    IndirectionTableSize : UInt16
    IndirectionTableOffset : UInt32
    HashSecretKeySize : UInt16
    HashSecretKeyOffset : UInt32
}
struct NDIS_RECEIVE_HASH_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    HashInformation : UInt32
    HashSecretKeySize : UInt16
    HashSecretKeyOffset : UInt32
}
struct NDIS_PROCESSOR_VENDOR extends Int32 {
    static NdisProcessorVendorUnknown := 0
    static NdisProcessorVendorGenuinIntel := 1
    static NdisProcessorVendorGenuineIntel := 1
    static NdisProcessorVendorAuthenticAMD := 2
}
struct NDIS_PORT_STATE {
    Header : NDIS_OBJECT_HEADER
    MediaConnectState : NET_IF_MEDIA_CONNECT_STATE
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
    Direction : NET_IF_DIRECTION_TYPE
    SendControlState : NDIS_PORT_CONTROL_STATE
    RcvControlState : NDIS_PORT_CONTROL_STATE
    SendAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
    Flags : UInt32
}
struct NDIS_PORT_CHARACTERISTICS {
    Header : NDIS_OBJECT_HEADER
    PortNumber : UInt32
    Flags : UInt32
    Type : NDIS_PORT_TYPE
    MediaConnectState : NET_IF_MEDIA_CONNECT_STATE
    XmitLinkSpeed : Int64
    RcvLinkSpeed : Int64
    Direction : NET_IF_DIRECTION_TYPE
    SendControlState : NDIS_PORT_CONTROL_STATE
    RcvControlState : NDIS_PORT_CONTROL_STATE
    SendAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
    RcvAuthorizationState : NDIS_PORT_AUTHORIZATION_STATE
}
struct NDIS_PORT {
    Next : NDIS_PORT.Ptr
    NdisReserved : Struct.Ptr
    MiniportReserved : Struct.Ptr
    ProtocolReserved : Struct.Ptr
    PortCharacteristics : NDIS_PORT_CHARACTERISTICS
}
struct NDIS_PORT_ARRAY {
    Header : NDIS_OBJECT_HEADER
    NumberOfPorts : UInt32
    OffsetFirstPort : UInt32
    ElementSize : UInt32
    Ports : NDIS_PORT_CHARACTERISTICS[1]
}
struct NDIS_TIMESTAMP_CAPABILITY_FLAGS {
    PtpV2OverUdpIPv4EventMsgReceiveHw : BOOLEAN
    PtpV2OverUdpIPv4AllMsgReceiveHw : BOOLEAN
    PtpV2OverUdpIPv4EventMsgTransmitHw : BOOLEAN
    PtpV2OverUdpIPv4AllMsgTransmitHw : BOOLEAN
    PtpV2OverUdpIPv6EventMsgReceiveHw : BOOLEAN
    PtpV2OverUdpIPv6AllMsgReceiveHw : BOOLEAN
    PtpV2OverUdpIPv6EventMsgTransmitHw : BOOLEAN
    PtpV2OverUdpIPv6AllMsgTransmitHw : BOOLEAN
    AllReceiveHw : BOOLEAN
    AllTransmitHw : BOOLEAN
    TaggedTransmitHw : BOOLEAN
    AllReceiveSw : BOOLEAN
    AllTransmitSw : BOOLEAN
    TaggedTransmitSw : BOOLEAN
}
struct NDIS_TIMESTAMP_CAPABILITIES {
    Header : NDIS_OBJECT_HEADER
    HardwareClockFrequencyHz : Int64
    CrossTimestamp : BOOLEAN
    Reserved1 : Int64
    Reserved2 : Int64
    TimestampFlags : NDIS_TIMESTAMP_CAPABILITY_FLAGS
}
struct NDIS_HARDWARE_CROSSTIMESTAMP {
    Header : NDIS_OBJECT_HEADER
    Flags : UInt32
    SystemTimestamp1 : Int64
    HardwareClockTimestamp : Int64
    SystemTimestamp2 : Int64
}
struct NDK_VERSION {
    Major : UInt16
    Minor : UInt16
}
struct NDK_RDMA_TECHNOLOGY extends Int32 {
    static NdkUndefined := 0
    static NdkiWarp := 1
    static NdkInfiniBand := 2
    static NdkRoCE := 3
    static NdkRoCEv2 := 4
    static NdkMaxTechnology := 5
}
struct NDK_ADAPTER_INFO {
    Version : NDK_VERSION
    VendorId : UInt32
    DeviceId : UInt32
    MaxRegistrationSize : IntPtr
    MaxWindowSize : IntPtr
    FRMRPageCount : UInt32
    MaxInitiatorRequestSge : UInt32
    MaxReceiveRequestSge : UInt32
    MaxReadRequestSge : UInt32
    MaxTransferLength : UInt32
    MaxInlineDataSize : UInt32
    MaxInboundReadLimit : UInt32
    MaxOutboundReadLimit : UInt32
    MaxReceiveQueueDepth : UInt32
    MaxInitiatorQueueDepth : UInt32
    MaxSrqDepth : UInt32
    MaxCqDepth : UInt32
    LargeRequestThreshold : UInt32
    MaxCallerData : UInt32
    MaxCalleeData : UInt32
    AdapterFlags : UInt32
    RdmaTechnology : NDK_RDMA_TECHNOLOGY
}
