#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN}

struct SECURE_ELEMENT_TYPE extends Int32 {
    static Integrated := 0
    static External := 1
    static DeviceHost := 2
}
struct SECURE_ELEMENT_EVENT_TYPE extends Int32 {
    static ExternalReaderArrival := 0
    static ExternalReaderDeparture := 1
    static ApplicationSelected := 2
    static Transaction := 3
    static HceActivated := 4
    static HceDeactivated := 5
    static ExternalFieldEnter := 6
    static ExternalFieldExit := 7
}
struct SECURE_ELEMENT_CARD_EMULATION_MODE extends Int32 {
    static EmulationOff := 0
    static EmulationOnPowerIndependent := 1
    static EmulationOnPowerDependent := 2
    static EmulationStealthListen := 3
}
struct SECURE_ELEMENT_ENDPOINT_INFO {
    guidSecureElementId : GUID
    eSecureElementType : SECURE_ELEMENT_TYPE
}
struct SECURE_ELEMENT_ENDPOINT_LIST {
    NumberOfEndpoints : UInt32
    EndpointList : SECURE_ELEMENT_ENDPOINT_INFO[1]
}
struct SECURE_ELEMENT_EVENT_SUBSCRIPTION_INFO {
    guidSecureElementId : GUID
    eEventType : SECURE_ELEMENT_EVENT_TYPE
}
struct SECURE_ELEMENT_EVENT_INFO {
    guidSecureElementId : GUID
    eEventType : SECURE_ELEMENT_EVENT_TYPE
    cbEventData : UInt32
    pbEventData : UInt8[1]
}
struct SECURE_ELEMENT_SET_CARD_EMULATION_MODE_INFO {
    guidSecureElementId : GUID
    eMode : SECURE_ELEMENT_CARD_EMULATION_MODE
}
struct SECURE_ELEMENT_NFCC_CAPABILITIES {
    cbMaxRoutingTableSize : UInt16
    IsAidRoutingSupported : BOOLEAN
    IsProtocolRoutingSupported : BOOLEAN
    IsTechRoutingSupported : BOOLEAN
}
struct SECURE_ELEMENT_ROUTING_TYPE extends Int32 {
    static RoutingTypeTech := 0
    static RoutingTypeProtocol := 1
    static RoutingTypeAid := 2
}
struct SECURE_ELEMENT_TECH_ROUTING_INFO {
    guidSecureElementId : GUID
    eRfTechType : UInt8
}
struct SECURE_ELEMENT_PROTO_ROUTING_INFO {
    guidSecureElementId : GUID
    eRfProtocolType : UInt8
}
struct SECURE_ELEMENT_AID_ROUTING_INFO {
    guidSecureElementId : GUID
    cbAid : UInt32
    pbAid : UInt8[16]
}
struct SECURE_ELEMENT_ROUTING_TABLE_ENTRY {
    eRoutingType : SECURE_ELEMENT_ROUTING_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            TechRoutingInfo : SECURE_ELEMENT_TECH_ROUTING_INFO
            ProtoRoutingInfo : SECURE_ELEMENT_PROTO_ROUTING_INFO
            AidRoutingInfo : SECURE_ELEMENT_AID_ROUTING_INFO
        }
    }
}
struct SECURE_ELEMENT_ROUTING_TABLE {
    NumberOfEntries : UInt32
    TableEntries : SECURE_ELEMENT_ROUTING_TABLE_ENTRY[1]
}
struct SECURE_ELEMENT_HCE_ACTIVATION_PAYLOAD {
    bConnectionId : UInt16
    eRfTechType : UInt8
    eRfProtocolType : UInt8
}
struct SECURE_ELEMENT_HCE_DATA_PACKET {
    bConnectionId : UInt16
    cbPayload : UInt16
    pbPayload : UInt8[1]
}
struct SECURE_ELEMENT_POWER_MODE extends Int32 {
    static SEPowerMode_ForceOn := 0
    static SEPowerMode_AllowOff := 1
}
struct SECURE_ELEMENT_SET_POWER_MODE_INFO {
    guidSecureElementId : GUID
    powerMode : SECURE_ELEMENT_POWER_MODE
}
struct NFC_RF_DISCOVERY_MODE extends Int32 {
    static RfDiscoveryConfig := 0
    static RfDiscoveryStart := 1
    static RFDiscoveryResume := 2
}
struct NFC_RF_DISCOVERY_CONFIG {
    usTotalDuration : UInt16
    ulPollConfig : UInt32
    fDisableCardEmulation : BOOLEAN
    ucNfcIPMode : UInt8
    fNfcIPTgtModeDisable : BOOLEAN
    ucNfcIPTgtMode : UInt8
    ucNfcCEMode : UInt8
    ucBailoutConfig : UInt8
    ucSystemCode : UInt8[2]
    ucRequestCode : UInt8
    ucTimeSlotNumber : UInt8
    eRfDiscoveryMode : NFC_RF_DISCOVERY_MODE
}
struct NFC_P2P_MODE extends Int32 {
    static NfcDepDefault := 0
    static NfcDepPoll := 1
    static NfcDepListen := 2
}
struct NFC_P2P_PARAM_CONFIG {
    eP2pMode : NFC_P2P_MODE
    cbGeneralBytes : UInt8
    pbGeneralBytes : UInt8[48]
}
struct NFC_DEVICE_TYPE extends Int32 {
    static NfcType1Tag := 0
    static NfcType2Tag := 1
    static NfcType3Tag := 2
    static NfcType4Tag := 3
    static NfcIP1Target := 4
    static NfcIP1Initiator := 5
    static NfcReader := 6
}
struct NFC_REMOTE_DEV_INFO {
    hRemoteDev : IntPtr
    eType : NFC_DEVICE_TYPE
    eRFTech : UInt8
    eProtocol : UInt8
    cbUid : UInt8
    pbUid : UInt8[16]
}
struct NFC_RELEASE_TYPE extends Int32 {
    static IdleMode := 0
    static SleepMode := 1
    static Discovery := 2
}
struct NFC_REMOTE_DEVICE_DISCONNET {
    hRemoteDev : IntPtr
    eReleaseType : NFC_RELEASE_TYPE
}
struct NFC_DATA_BUFFER {
    cbBuffer : UInt16
    pbBuffer : UInt8[1]
}
struct NFC_REMOTE_DEV_SEND_INFO {
    hRemoteDev : IntPtr
    usTimeOut : UInt16
    sSendBuffer : NFC_DATA_BUFFER
}
struct NFC_REMOTE_DEV_RECV_INFO {
    hRemoteDev : IntPtr
    sRecvBuffer : NFC_DATA_BUFFER
}
struct NFC_NDEF_INFO {
    fIsNdefFormatted : BOOLEAN
    fIsReadOnly : BOOLEAN
    dwActualMessageLength : UInt32
    dwMaxMessageLength : UInt32
}
struct NFC_LLCP_SOCKET_OPTION {
    uMIUX : UInt16
    bRW : UInt8
}
struct NFC_LLCP_CONFIG {
    uMIU : UInt16
    uWKS : UInt16
    bLTO : UInt8
    bOptions : UInt8
    fAutoActivate : BOOLEAN
}
struct NFC_LLCP_SERVICE_NAME_ENTRY {
    cbServiceName : UInt32
    pbServiceName : UInt8[1]
}
struct NFC_LLCP_SERVICE_DISCOVER_REQUEST {
    hRemoteDev : IntPtr
    NumberOfEntries : UInt32
    ServiceNameEntries : NFC_LLCP_SERVICE_NAME_ENTRY[1]
}
struct NFC_LLCP_SERVICE_DISCOVER_SAP {
    NumberOfEntries : UInt32
    SAPEntries : UInt8[1]
}
struct NFC_LLCP_SOCKET_TYPE extends Int32 {
    static ConnectionOriented := 0
    static Connectionless := 1
}
struct NFC_LLCP_LINK_STATUS extends Int32 {
    static LinkActivated := 0
    static LinkDeactivated := 1
}
struct NFC_LLCP_SOCKET_INFO {
    eSocketType : NFC_LLCP_SOCKET_TYPE
    sSocketOption : NFC_LLCP_SOCKET_OPTION
}
struct NFC_LLCP_SOCKET_SERVICE_INFO {
    hSocket : IntPtr
    bSAP : UInt8
    sServiceName : NFC_LLCP_SERVICE_NAME_ENTRY
}
struct NFC_LLCP_SOCKET_PAYLOAD {
    hSocket : IntPtr
    bSAP : UInt8
    sPayload : NFC_DATA_BUFFER
}
struct NFC_LLCP_SOCKET_ACCEPT_INFO {
    hSocket : IntPtr
    sSocketOption : NFC_LLCP_SOCKET_OPTION
}
struct NFC_LLCP_SOCKET_CONNECT_TYPE extends Int32 {
    static NfcConnectBySap := 0
    static NfcConnectByUri := 1
}
struct NFC_LLCP_SOCKET_CONNECT_INFO {
    hRemoteDev : IntPtr
    hSocket : IntPtr
    eConnectType : NFC_LLCP_SOCKET_CONNECT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bSAP : UInt8
            sServiceName : NFC_LLCP_SERVICE_NAME_ENTRY
        }
    }
}
struct NFC_LLCP_SOCKET_CL_PAYLOAD {
    hSocket : IntPtr
    bSAP : UInt8
    sPayload : NFC_DATA_BUFFER
}
struct NFC_LLCP_SOCKET_ERROR extends Int32 {
    static NfcLlcpErrorDisconnected := 0
    static NfcLlcpErrorFrameRejected := 1
    static NfcLlcpErrorBusyCondition := 2
    static NfcLlcpErrorNotBusyCondition := 3
}
struct NFC_LLCP_SOCKET_ERROR_INFO {
    hSocket : IntPtr
    eSocketError : NFC_LLCP_SOCKET_ERROR
}
struct NFC_SNEP_SERVER_TYPE extends Int32 {
    static DefaultSnepServer := 0
    static ExtendedSnepServer := 1
}
struct NFC_SNEP_REQUEST_TYPE extends Int32 {
    static SnepRequestGet := 0
    static SnepRequestPut := 1
}
struct NFC_SNEP_SERVER_INFO {
    eServerType : NFC_SNEP_SERVER_TYPE
    sSocketOption : NFC_LLCP_SOCKET_OPTION
    usInboxSize : UInt16
    bSAP : UInt8
    sService : NFC_LLCP_SERVICE_NAME_ENTRY
}
struct NFC_SNEP_SERVER_ACCEPT_INFO {
    hSnepServer : IntPtr
    hConnection : IntPtr
    sSocketOption : NFC_LLCP_SOCKET_OPTION
}
struct NFC_SNEP_SERVER_REQUEST {
    hSnepServer : IntPtr
    hConnection : IntPtr
    eRequestType : NFC_SNEP_REQUEST_TYPE
    sRequestPayload : NFC_DATA_BUFFER
}
struct NFC_SNEP_SERVER_RESPONSE_INFO {
    hSnepServer : IntPtr
    hConnection : IntPtr
    dwResponseStatus : UInt32
    sResponsePayload : NFC_DATA_BUFFER
}
struct NFC_SNEP_CLIENT_INFO {
    hRemoteDev : IntPtr
    eServerType : NFC_SNEP_SERVER_TYPE
    sSocketOption : NFC_LLCP_SOCKET_OPTION
    sService : NFC_LLCP_SERVICE_NAME_ENTRY
}
struct NFC_SNEP_CLIENT_PUT_INFO {
    hSnepClient : IntPtr
    sPutPayload : NFC_DATA_BUFFER
}
struct NFC_SNEP_CLIENT_GET_INFO {
    hSnepClient : IntPtr
    sGetPayload : NFC_DATA_BUFFER
}
struct NFC_SE_EMULATION_MODE extends Int32 {
    static EmulationDisabled := 0
    static EmulationEnabled := 1
}
struct NFC_SE_INFO {
    hSecureElement : IntPtr
    eSecureElementType : SECURE_ELEMENT_TYPE
}
struct NFC_SE_LIST {
    NumberOfEndpoints : UInt32
    EndpointList : NFC_SE_INFO[1]
}
struct NFC_SE_EMULATION_MODE_INFO {
    hSecureElement : IntPtr
    eMode : NFC_SE_EMULATION_MODE
}
struct NFC_SE_TECH_ROUTING_INFO {
    hSecureElement : IntPtr
    bPowerState : UInt8
    eRfTechType : UInt8
}
struct NFC_SE_PROTO_ROUTING_INFO {
    hSecureElement : IntPtr
    bPowerState : UInt8
    eRfProtocolType : UInt8
}
struct NFC_SE_AID_ROUTING_INFO {
    hSecureElement : IntPtr
    bPowerState : UInt8
    cbAid : UInt32
    pbAid : UInt8[16]
}
struct NFC_SE_ROUTING_TABLE_ENTRY {
    eRoutingType : SECURE_ELEMENT_ROUTING_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            TechRoutingInfo : NFC_SE_TECH_ROUTING_INFO
            ProtoRoutingInfo : NFC_SE_PROTO_ROUTING_INFO
            AidRoutingInfo : NFC_SE_AID_ROUTING_INFO
        }
    }
}
struct NFC_SE_ROUTING_TABLE {
    NumberOfEntries : UInt32
    TableEntries : NFC_SE_ROUTING_TABLE_ENTRY[1]
}
struct NFC_SE_EVENT_INFO {
    hSecureElement : IntPtr
    eEventType : SECURE_ELEMENT_EVENT_TYPE
    cbEventData : UInt32
    pbEventData : UInt8[1]
}
struct NFCRM_SET_RADIO_STATE {
    SystemStateUpdate : BOOLEAN
    MediaRadioOn : BOOLEAN
}
struct NFCRM_RADIO_STATE {
    MediaRadioOn : BOOLEAN
}
