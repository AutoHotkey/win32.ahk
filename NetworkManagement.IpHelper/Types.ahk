#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, PSTR, PWSTR}
#Import "..\NetworkManagement.Ndis\Types.ahk" {IF_OPER_STATUS, NDIS_MEDIUM, NDIS_PHYSICAL_MEDIUM, NET_IF_ACCESS_TYPE, NET_IF_ADMIN_STATUS, NET_IF_COMPARTMENT_ID, NET_IF_CONNECTION_TYPE, NET_IF_DIRECTION_TYPE, NET_IF_MEDIA_CONNECT_STATE, NET_LUID_LH, TUNNEL_TYPE}
#Import "..\Networking.WinSock\Types.ahk" {ADDRESS_FAMILY, IN6_ADDR, NL_BANDWIDTH_INFORMATION, NL_DAD_STATE, NL_INTERFACE_OFFLOAD_ROD, NL_LINK_LOCAL_ADDRESS_BEHAVIOR, NL_NEIGHBOR_STATE, NL_NETWORK_CONNECTIVITY_HINT, NL_PREFIX_ORIGIN, NL_ROUTER_DISCOVERY_BEHAVIOR, NL_ROUTE_ORIGIN, NL_ROUTE_PROTOCOL, NL_SUFFIX_ORIGIN, SCOPE_ID, SOCKADDR, SOCKADDR_IN, SOCKADDR_IN6, SOCKADDR_INET, SOCKET_ADDRESS}

struct GET_ADAPTERS_ADDRESSES_FLAGS extends UInt32 {
    static GAA_FLAG_SKIP_UNICAST := 1
    static GAA_FLAG_SKIP_ANYCAST := 2
    static GAA_FLAG_SKIP_MULTICAST := 4
    static GAA_FLAG_SKIP_DNS_SERVER := 8
    static GAA_FLAG_INCLUDE_PREFIX := 16
    static GAA_FLAG_SKIP_FRIENDLY_NAME := 32
    static GAA_FLAG_INCLUDE_WINS_INFO := 64
    static GAA_FLAG_INCLUDE_GATEWAYS := 128
    static GAA_FLAG_INCLUDE_ALL_INTERFACES := 256
    static GAA_FLAG_INCLUDE_ALL_COMPARTMENTS := 512
    static GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER := 1024
}
struct HIFTIMESTAMPCHANGE {
    Value : IntPtr
}
struct IP_OPTION_INFORMATION32 {
    Ttl : UInt8
    Tos : UInt8
    Flags : UInt8
    OptionsSize : UInt8
    OptionsData : UInt8.Ptr
}
struct ICMP_ECHO_REPLY32 {
    Address : UInt32
    Status : UInt32
    RoundTripTime : UInt32
    DataSize : UInt16
    Reserved : UInt16
    Data : Struct.Ptr
    Options : IP_OPTION_INFORMATION32
}
struct IP_OPTION_INFORMATION {
    Ttl : UInt8
    Tos : UInt8
    Flags : UInt8
    OptionsSize : UInt8
    OptionsData : UInt8.Ptr
}
struct ICMP_ECHO_REPLY {
    Address : UInt32
    Status : UInt32
    RoundTripTime : UInt32
    DataSize : UInt16
    Reserved : UInt16
    Data : Struct.Ptr
    Options : IP_OPTION_INFORMATION
}
struct IPV6_ADDRESS_EX {
    sin6_port : UInt16
    sin6_flowinfo : UInt32
    sin6_addr : UInt16[8]
    sin6_scope_id : UInt32
}
struct ICMPV6_ECHO_REPLY_LH {
    Address : IPV6_ADDRESS_EX
    Status : UInt32
    RoundTripTime : UInt32
}
struct ARP_SEND_REPLY {
    DestAddress : UInt32
    SrcAddress : UInt32
}
struct TCP_RESERVE_PORT_RANGE {
    UpperRange : UInt16
    LowerRange : UInt16
}
struct IP_ADAPTER_INDEX_MAP {
    Index : UInt32
    Name : UInt16[128]
}
struct IP_INTERFACE_INFO {
    NumAdapters : Int32
    Adapter : IP_ADAPTER_INDEX_MAP[1]
}
struct IP_UNIDIRECTIONAL_ADAPTER_ADDRESS {
    NumAdapters : UInt32
    Address : UInt32[1]
}
struct IP_ADAPTER_ORDER_MAP {
    NumAdapters : UInt32
    AdapterOrder : UInt32[1]
}
struct IP_MCAST_COUNTER_INFO {
    InMcastOctets : Int64
    OutMcastOctets : Int64
    InMcastPkts : Int64
    OutMcastPkts : Int64
}
struct IF_ACCESS_TYPE extends Int32 {
    static IF_ACCESS_LOOPBACK := 1
    static IF_ACCESS_BROADCAST := 2
    static IF_ACCESS_POINT_TO_POINT := 3
    static IF_ACCESS_POINTTOPOINT := 3
    static IF_ACCESS_POINT_TO_MULTI_POINT := 4
    static IF_ACCESS_POINTTOMULTIPOINT := 4
}
struct INTERNAL_IF_OPER_STATUS extends Int32 {
    static IF_OPER_STATUS_NON_OPERATIONAL := 0
    static IF_OPER_STATUS_UNREACHABLE := 1
    static IF_OPER_STATUS_DISCONNECTED := 2
    static IF_OPER_STATUS_CONNECTING := 3
    static IF_OPER_STATUS_CONNECTED := 4
    static IF_OPER_STATUS_OPERATIONAL := 5
}
struct MIB_OPAQUE_QUERY {
    dwVarId : UInt32
    rgdwVarIndex : UInt32[1]
}
struct MIB_IFNUMBER {
    dwValue : UInt32
}
struct MIB_IFROW {
    wszName : UInt16[256]
    dwIndex : UInt32
    dwType : UInt32
    dwMtu : UInt32
    dwSpeed : UInt32
    dwPhysAddrLen : UInt32
    bPhysAddr : UInt8[8]
    dwAdminStatus : UInt32
    dwOperStatus : INTERNAL_IF_OPER_STATUS
    dwLastChange : UInt32
    dwInOctets : UInt32
    dwInUcastPkts : UInt32
    dwInNUcastPkts : UInt32
    dwInDiscards : UInt32
    dwInErrors : UInt32
    dwInUnknownProtos : UInt32
    dwOutOctets : UInt32
    dwOutUcastPkts : UInt32
    dwOutNUcastPkts : UInt32
    dwOutDiscards : UInt32
    dwOutErrors : UInt32
    dwOutQLen : UInt32
    dwDescrLen : UInt32
    bDescr : UInt8[256]
}
struct MIB_IFTABLE {
    dwNumEntries : UInt32
    table : MIB_IFROW[1]
}
struct MIB_IPADDRROW_XP {
    dwAddr : UInt32
    dwIndex : UInt32
    dwMask : UInt32
    dwBCastAddr : UInt32
    dwReasmSize : UInt32
    unused1 : UInt16
    wType : UInt16
}
struct MIB_IPADDRROW_W2K {
    dwAddr : UInt32
    dwIndex : UInt32
    dwMask : UInt32
    dwBCastAddr : UInt32
    dwReasmSize : UInt32
    unused1 : UInt16
    unused2 : UInt16
}
struct MIB_IPADDRTABLE {
    dwNumEntries : UInt32
    table : MIB_IPADDRROW_XP[1]
}
struct MIB_IPFORWARDNUMBER {
    dwValue : UInt32
}
struct MIB_IPFORWARD_TYPE extends Int32 {
    static MIB_IPROUTE_TYPE_OTHER := 1
    static MIB_IPROUTE_TYPE_INVALID := 2
    static MIB_IPROUTE_TYPE_DIRECT := 3
    static MIB_IPROUTE_TYPE_INDIRECT := 4
}
struct MIB_IPFORWARDROW {
    dwForwardDest : UInt32
    dwForwardMask : UInt32
    dwForwardPolicy : UInt32
    dwForwardNextHop : UInt32
    dwForwardIfIndex : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    dwForwardAge : UInt32
    dwForwardNextHopAS : UInt32
    dwForwardMetric1 : UInt32
    dwForwardMetric2 : UInt32
    dwForwardMetric3 : UInt32
    dwForwardMetric4 : UInt32
    dwForwardMetric5 : UInt32
    struct _Anonymous1_e__Union {
        union {
            dwForwardType : UInt32
            ForwardType : MIB_IPFORWARD_TYPE
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwForwardProto : UInt32
            ForwardProto : NL_ROUTE_PROTOCOL
        }
    }
}
struct MIB_IPFORWARDTABLE {
    dwNumEntries : UInt32
    table : MIB_IPFORWARDROW[1]
}
struct MIB_IPNET_TYPE extends Int32 {
    static MIB_IPNET_TYPE_OTHER := 1
    static MIB_IPNET_TYPE_INVALID := 2
    static MIB_IPNET_TYPE_DYNAMIC := 3
    static MIB_IPNET_TYPE_STATIC := 4
}
struct MIB_IPNETROW_LH {
    dwIndex : UInt32
    dwPhysAddrLen : UInt32
    bPhysAddr : UInt8[8]
    dwAddr : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwType : UInt32
            Type : MIB_IPNET_TYPE
        }
    }
}
struct MIB_IPNETROW_W2K {
    dwIndex : UInt32
    dwPhysAddrLen : UInt32
    bPhysAddr : UInt8[8]
    dwAddr : UInt32
    dwType : UInt32
}
struct MIB_IPNETTABLE {
    dwNumEntries : UInt32
    table : MIB_IPNETROW_LH[1]
}
struct MIB_IPSTATS_FORWARDING extends Int32 {
    static MIB_IP_FORWARDING := 1
    static MIB_IP_NOT_FORWARDING := 2
}
struct MIB_IPSTATS_LH {
    Anonymous : this._Anonymous_e__Union
    dwDefaultTTL : UInt32
    dwInReceives : UInt32
    dwInHdrErrors : UInt32
    dwInAddrErrors : UInt32
    dwForwDatagrams : UInt32
    dwInUnknownProtos : UInt32
    dwInDiscards : UInt32
    dwInDelivers : UInt32
    dwOutRequests : UInt32
    dwRoutingDiscards : UInt32
    dwOutDiscards : UInt32
    dwOutNoRoutes : UInt32
    dwReasmTimeout : UInt32
    dwReasmReqds : UInt32
    dwReasmOks : UInt32
    dwReasmFails : UInt32
    dwFragOks : UInt32
    dwFragFails : UInt32
    dwFragCreates : UInt32
    dwNumIf : UInt32
    dwNumAddr : UInt32
    dwNumRoutes : UInt32
    struct _Anonymous_e__Union {
        union {
            dwForwarding : UInt32
            Forwarding : MIB_IPSTATS_FORWARDING
        }
    }
}
struct MIB_IPSTATS_W2K {
    dwForwarding : UInt32
    dwDefaultTTL : UInt32
    dwInReceives : UInt32
    dwInHdrErrors : UInt32
    dwInAddrErrors : UInt32
    dwForwDatagrams : UInt32
    dwInUnknownProtos : UInt32
    dwInDiscards : UInt32
    dwInDelivers : UInt32
    dwOutRequests : UInt32
    dwRoutingDiscards : UInt32
    dwOutDiscards : UInt32
    dwOutNoRoutes : UInt32
    dwReasmTimeout : UInt32
    dwReasmReqds : UInt32
    dwReasmOks : UInt32
    dwReasmFails : UInt32
    dwFragOks : UInt32
    dwFragFails : UInt32
    dwFragCreates : UInt32
    dwNumIf : UInt32
    dwNumAddr : UInt32
    dwNumRoutes : UInt32
}
struct MIBICMPSTATS {
    dwMsgs : UInt32
    dwErrors : UInt32
    dwDestUnreachs : UInt32
    dwTimeExcds : UInt32
    dwParmProbs : UInt32
    dwSrcQuenchs : UInt32
    dwRedirects : UInt32
    dwEchos : UInt32
    dwEchoReps : UInt32
    dwTimestamps : UInt32
    dwTimestampReps : UInt32
    dwAddrMasks : UInt32
    dwAddrMaskReps : UInt32
}
struct MIBICMPINFO {
    icmpInStats : MIBICMPSTATS
    icmpOutStats : MIBICMPSTATS
}
struct MIB_ICMP {
    stats : MIBICMPINFO
}
struct MIBICMPSTATS_EX_XPSP1 {
    dwMsgs : UInt32
    dwErrors : UInt32
    rgdwTypeCount : UInt32[256]
}
struct MIB_ICMP_EX_XPSP1 {
    icmpInStats : MIBICMPSTATS_EX_XPSP1
    icmpOutStats : MIBICMPSTATS_EX_XPSP1
}
struct ICMP6_TYPE extends Int32 {
    static ICMP6_DST_UNREACH := 1
    static ICMP6_PACKET_TOO_BIG := 2
    static ICMP6_TIME_EXCEEDED := 3
    static ICMP6_PARAM_PROB := 4
    static ICMP6_ECHO_REQUEST := 128
    static ICMP6_ECHO_REPLY := 129
    static ICMP6_MEMBERSHIP_QUERY := 130
    static ICMP6_MEMBERSHIP_REPORT := 131
    static ICMP6_MEMBERSHIP_REDUCTION := 132
    static ND_ROUTER_SOLICIT := 133
    static ND_ROUTER_ADVERT := 134
    static ND_NEIGHBOR_SOLICIT := 135
    static ND_NEIGHBOR_ADVERT := 136
    static ND_REDIRECT := 137
    static ICMP6_V2_MEMBERSHIP_REPORT := 143
}
struct ICMP4_TYPE extends Int32 {
    static ICMP4_ECHO_REPLY := 0
    static ICMP4_DST_UNREACH := 3
    static ICMP4_SOURCE_QUENCH := 4
    static ICMP4_REDIRECT := 5
    static ICMP4_ECHO_REQUEST := 8
    static ICMP4_ROUTER_ADVERT := 9
    static ICMP4_ROUTER_SOLICIT := 10
    static ICMP4_TIME_EXCEEDED := 11
    static ICMP4_PARAM_PROB := 12
    static ICMP4_TIMESTAMP_REQUEST := 13
    static ICMP4_TIMESTAMP_REPLY := 14
    static ICMP4_MASK_REQUEST := 17
    static ICMP4_MASK_REPLY := 18
}
struct MIB_IPMCAST_OIF_XP {
    dwOutIfIndex : UInt32
    dwNextHopAddr : UInt32
    dwReserved : UInt32
    dwReserved1 : UInt32
}
struct MIB_IPMCAST_OIF_W2K {
    dwOutIfIndex : UInt32
    dwNextHopAddr : UInt32
    pvReserved : Struct.Ptr
    dwReserved : UInt32
}
struct MIB_IPMCAST_MFE {
    dwGroup : UInt32
    dwSource : UInt32
    dwSrcMask : UInt32
    dwUpStrmNgbr : UInt32
    dwInIfIndex : UInt32
    dwInIfProtocol : UInt32
    dwRouteProtocol : UInt32
    dwRouteNetwork : UInt32
    dwRouteMask : UInt32
    ulUpTime : UInt32
    ulExpiryTime : UInt32
    ulTimeOut : UInt32
    ulNumOutIf : UInt32
    fFlags : UInt32
    dwReserved : UInt32
    rgmioOutInfo : MIB_IPMCAST_OIF_XP[1]
}
struct MIB_MFE_TABLE {
    dwNumEntries : UInt32
    table : MIB_IPMCAST_MFE[1]
}
struct MIB_IPMCAST_OIF_STATS_LH {
    dwOutIfIndex : UInt32
    dwNextHopAddr : UInt32
    dwDialContext : UInt32
    ulTtlTooLow : UInt32
    ulFragNeeded : UInt32
    ulOutPackets : UInt32
    ulOutDiscards : UInt32
}
struct MIB_IPMCAST_OIF_STATS_W2K {
    dwOutIfIndex : UInt32
    dwNextHopAddr : UInt32
    pvDialContext : Struct.Ptr
    ulTtlTooLow : UInt32
    ulFragNeeded : UInt32
    ulOutPackets : UInt32
    ulOutDiscards : UInt32
}
struct MIB_IPMCAST_MFE_STATS {
    dwGroup : UInt32
    dwSource : UInt32
    dwSrcMask : UInt32
    dwUpStrmNgbr : UInt32
    dwInIfIndex : UInt32
    dwInIfProtocol : UInt32
    dwRouteProtocol : UInt32
    dwRouteNetwork : UInt32
    dwRouteMask : UInt32
    ulUpTime : UInt32
    ulExpiryTime : UInt32
    ulNumOutIf : UInt32
    ulInPkts : UInt32
    ulInOctets : UInt32
    ulPktsDifferentIf : UInt32
    ulQueueOverflow : UInt32
    rgmiosOutStats : MIB_IPMCAST_OIF_STATS_LH[1]
}
struct MIB_MFE_STATS_TABLE {
    dwNumEntries : UInt32
    table : MIB_IPMCAST_MFE_STATS[1]
}
struct MIB_IPMCAST_MFE_STATS_EX_XP {
    dwGroup : UInt32
    dwSource : UInt32
    dwSrcMask : UInt32
    dwUpStrmNgbr : UInt32
    dwInIfIndex : UInt32
    dwInIfProtocol : UInt32
    dwRouteProtocol : UInt32
    dwRouteNetwork : UInt32
    dwRouteMask : UInt32
    ulUpTime : UInt32
    ulExpiryTime : UInt32
    ulNumOutIf : UInt32
    ulInPkts : UInt32
    ulInOctets : UInt32
    ulPktsDifferentIf : UInt32
    ulQueueOverflow : UInt32
    ulUninitMfe : UInt32
    ulNegativeMfe : UInt32
    ulInDiscards : UInt32
    ulInHdrErrors : UInt32
    ulTotalOutPackets : UInt32
    rgmiosOutStats : MIB_IPMCAST_OIF_STATS_LH[1]
}
struct MIB_MFE_STATS_TABLE_EX_XP {
    dwNumEntries : UInt32
    table : MIB_IPMCAST_MFE_STATS_EX_XP.Ptr[1]
}
struct MIB_IPMCAST_GLOBAL {
    dwEnable : UInt32
}
struct MIB_IPMCAST_IF_ENTRY {
    dwIfIndex : UInt32
    dwTtl : UInt32
    dwProtocol : UInt32
    dwRateLimit : UInt32
    ulInMcastOctets : UInt32
    ulOutMcastOctets : UInt32
}
struct MIB_IPMCAST_IF_TABLE {
    dwNumEntries : UInt32
    table : MIB_IPMCAST_IF_ENTRY[1]
}
struct MIB_TCP_STATE extends Int32 {
    static MIB_TCP_STATE_CLOSED := 1
    static MIB_TCP_STATE_LISTEN := 2
    static MIB_TCP_STATE_SYN_SENT := 3
    static MIB_TCP_STATE_SYN_RCVD := 4
    static MIB_TCP_STATE_ESTAB := 5
    static MIB_TCP_STATE_FIN_WAIT1 := 6
    static MIB_TCP_STATE_FIN_WAIT2 := 7
    static MIB_TCP_STATE_CLOSE_WAIT := 8
    static MIB_TCP_STATE_CLOSING := 9
    static MIB_TCP_STATE_LAST_ACK := 10
    static MIB_TCP_STATE_TIME_WAIT := 11
    static MIB_TCP_STATE_DELETE_TCB := 12
    static MIB_TCP_STATE_RESERVED := 100
}
struct TCP_CONNECTION_OFFLOAD_STATE extends Int32 {
    static TcpConnectionOffloadStateInHost := 0
    static TcpConnectionOffloadStateOffloading := 1
    static TcpConnectionOffloadStateOffloaded := 2
    static TcpConnectionOffloadStateUploading := 3
    static TcpConnectionOffloadStateMax := 4
}
struct MIB_TCPROW_LH {
    Anonymous : this._Anonymous_e__Union
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
    struct _Anonymous_e__Union {
        union {
            dwState : UInt32
            State : MIB_TCP_STATE
        }
    }
}
struct MIB_TCPROW_W2K {
    dwState : UInt32
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
}
struct MIB_TCPTABLE {
    dwNumEntries : UInt32
    table : MIB_TCPROW_LH[1]
}
struct MIB_TCPROW2 {
    dwState : UInt32
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
    dwOwningPid : UInt32
    dwOffloadState : TCP_CONNECTION_OFFLOAD_STATE
}
struct MIB_TCPTABLE2 {
    dwNumEntries : UInt32
    table : MIB_TCPROW2[1]
}
struct MIB_TCPROW_OWNER_PID {
    dwState : UInt32
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
    dwOwningPid : UInt32
}
struct MIB_TCPTABLE_OWNER_PID {
    dwNumEntries : UInt32
    table : MIB_TCPROW_OWNER_PID[1]
}
struct MIB_TCPROW_OWNER_MODULE {
    dwState : UInt32
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    OwningModuleInfo : Int64[16]
}
struct MIB_TCPTABLE_OWNER_MODULE {
    dwNumEntries : UInt32
    table : MIB_TCPROW_OWNER_MODULE[1]
}
struct MIB_TCP6ROW {
    State : MIB_TCP_STATE
    LocalAddr : IN6_ADDR
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    RemoteAddr : IN6_ADDR
    dwRemoteScopeId : UInt32
    dwRemotePort : UInt32
}
struct MIB_TCP6TABLE {
    dwNumEntries : UInt32
    table : MIB_TCP6ROW[1]
}
struct MIB_TCP6ROW2 {
    LocalAddr : IN6_ADDR
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    RemoteAddr : IN6_ADDR
    dwRemoteScopeId : UInt32
    dwRemotePort : UInt32
    State : MIB_TCP_STATE
    dwOwningPid : UInt32
    dwOffloadState : TCP_CONNECTION_OFFLOAD_STATE
}
struct MIB_TCP6TABLE2 {
    dwNumEntries : UInt32
    table : MIB_TCP6ROW2[1]
}
struct MIB_TCP6ROW_OWNER_PID {
    ucLocalAddr : UInt8[16]
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    ucRemoteAddr : UInt8[16]
    dwRemoteScopeId : UInt32
    dwRemotePort : UInt32
    dwState : UInt32
    dwOwningPid : UInt32
}
struct MIB_TCP6TABLE_OWNER_PID {
    dwNumEntries : UInt32
    table : MIB_TCP6ROW_OWNER_PID[1]
}
struct MIB_TCP6ROW_OWNER_MODULE {
    ucLocalAddr : UInt8[16]
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    ucRemoteAddr : UInt8[16]
    dwRemoteScopeId : UInt32
    dwRemotePort : UInt32
    dwState : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    OwningModuleInfo : Int64[16]
}
struct MIB_TCP6TABLE_OWNER_MODULE {
    dwNumEntries : UInt32
    table : MIB_TCP6ROW_OWNER_MODULE[1]
}
struct TCP_RTO_ALGORITHM extends Int32 {
    static TcpRtoAlgorithmOther := 1
    static TcpRtoAlgorithmConstant := 2
    static TcpRtoAlgorithmRsre := 3
    static TcpRtoAlgorithmVanj := 4
    static MIB_TCP_RTO_OTHER := 1
    static MIB_TCP_RTO_CONSTANT := 2
    static MIB_TCP_RTO_RSRE := 3
    static MIB_TCP_RTO_VANJ := 4
}
struct MIB_TCPSTATS_LH {
    Anonymous : this._Anonymous_e__Union
    dwRtoMin : UInt32
    dwRtoMax : UInt32
    dwMaxConn : UInt32
    dwActiveOpens : UInt32
    dwPassiveOpens : UInt32
    dwAttemptFails : UInt32
    dwEstabResets : UInt32
    dwCurrEstab : UInt32
    dwInSegs : UInt32
    dwOutSegs : UInt32
    dwRetransSegs : UInt32
    dwInErrs : UInt32
    dwOutRsts : UInt32
    dwNumConns : UInt32
    struct _Anonymous_e__Union {
        union {
            dwRtoAlgorithm : UInt32
            RtoAlgorithm : TCP_RTO_ALGORITHM
        }
    }
}
struct MIB_TCPSTATS_W2K {
    dwRtoAlgorithm : UInt32
    dwRtoMin : UInt32
    dwRtoMax : UInt32
    dwMaxConn : UInt32
    dwActiveOpens : UInt32
    dwPassiveOpens : UInt32
    dwAttemptFails : UInt32
    dwEstabResets : UInt32
    dwCurrEstab : UInt32
    dwInSegs : UInt32
    dwOutSegs : UInt32
    dwRetransSegs : UInt32
    dwInErrs : UInt32
    dwOutRsts : UInt32
    dwNumConns : UInt32
}
struct MIB_TCPSTATS2 {
    RtoAlgorithm : TCP_RTO_ALGORITHM
    dwRtoMin : UInt32
    dwRtoMax : UInt32
    dwMaxConn : UInt32
    dwActiveOpens : UInt32
    dwPassiveOpens : UInt32
    dwAttemptFails : UInt32
    dwEstabResets : UInt32
    dwCurrEstab : UInt32
    dw64InSegs : Int64
    dw64OutSegs : Int64
    dwRetransSegs : UInt32
    dwInErrs : UInt32
    dwOutRsts : UInt32
    dwNumConns : UInt32
}
struct MIB_UDPROW {
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
}
struct MIB_UDPTABLE {
    dwNumEntries : UInt32
    table : MIB_UDPROW[1]
}
struct MIB_UDPROW_OWNER_PID {
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
}
struct MIB_UDPTABLE_OWNER_PID {
    dwNumEntries : UInt32
    table : MIB_UDPROW_OWNER_PID[1]
}
struct MIB_UDPROW_OWNER_MODULE {
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    Anonymous : this._Anonymous_e__Union
    OwningModuleInfo : Int64[16]
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            dwFlags : Int32
        }
        struct _Anonymous_e__Struct {
            _bitfield : Int32
        }
    }
}
struct MIB_UDPTABLE_OWNER_MODULE {
    dwNumEntries : UInt32
    table : MIB_UDPROW_OWNER_MODULE[1]
}
struct MIB_UDPROW2 {
    dwLocalAddr : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    Anonymous : this._Anonymous_e__Union
    OwningModuleInfo : Int64[16]
    dwRemoteAddr : UInt32
    dwRemotePort : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            dwFlags : Int32
        }
        struct _Anonymous_e__Struct {
            _bitfield : Int32
        }
    }
}
struct MIB_UDPTABLE2 {
    dwNumEntries : UInt32
    table : MIB_UDPROW2[1]
}
struct MIB_UDP6ROW {
    dwLocalAddr : IN6_ADDR
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
}
struct MIB_UDP6TABLE {
    dwNumEntries : UInt32
    table : MIB_UDP6ROW[1]
}
struct MIB_UDP6ROW_OWNER_PID {
    ucLocalAddr : UInt8[16]
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
}
struct MIB_UDP6TABLE_OWNER_PID {
    dwNumEntries : UInt32
    table : MIB_UDP6ROW_OWNER_PID[1]
}
struct MIB_UDP6ROW_OWNER_MODULE {
    ucLocalAddr : UInt8[16]
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    Anonymous : this._Anonymous_e__Union
    OwningModuleInfo : Int64[16]
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            dwFlags : Int32
        }
        struct _Anonymous_e__Struct {
            _bitfield : Int32
        }
    }
}
struct MIB_UDP6TABLE_OWNER_MODULE {
    dwNumEntries : UInt32
    table : MIB_UDP6ROW_OWNER_MODULE[1]
}
struct MIB_UDP6ROW2 {
    ucLocalAddr : UInt8[16]
    dwLocalScopeId : UInt32
    dwLocalPort : UInt32
    dwOwningPid : UInt32
    liCreateTimestamp : Int64
    Anonymous : this._Anonymous_e__Union
    OwningModuleInfo : Int64[16]
    ucRemoteAddr : UInt8[16]
    dwRemoteScopeId : UInt32
    dwRemotePort : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            dwFlags : Int32
        }
        struct _Anonymous_e__Struct {
            _bitfield : Int32
        }
    }
}
struct MIB_UDP6TABLE2 {
    dwNumEntries : UInt32
    table : MIB_UDP6ROW2[1]
}
struct MIB_UDPSTATS {
    dwInDatagrams : UInt32
    dwNoPorts : UInt32
    dwInErrors : UInt32
    dwOutDatagrams : UInt32
    dwNumAddrs : UInt32
}
struct MIB_UDPSTATS2 {
    dw64InDatagrams : Int64
    dwNoPorts : UInt32
    dwInErrors : UInt32
    dw64OutDatagrams : Int64
    dwNumAddrs : UInt32
}
struct TCP_TABLE_CLASS extends Int32 {
    static TCP_TABLE_BASIC_LISTENER := 0
    static TCP_TABLE_BASIC_CONNECTIONS := 1
    static TCP_TABLE_BASIC_ALL := 2
    static TCP_TABLE_OWNER_PID_LISTENER := 3
    static TCP_TABLE_OWNER_PID_CONNECTIONS := 4
    static TCP_TABLE_OWNER_PID_ALL := 5
    static TCP_TABLE_OWNER_MODULE_LISTENER := 6
    static TCP_TABLE_OWNER_MODULE_CONNECTIONS := 7
    static TCP_TABLE_OWNER_MODULE_ALL := 8
}
struct UDP_TABLE_CLASS extends Int32 {
    static UDP_TABLE_BASIC := 0
    static UDP_TABLE_OWNER_PID := 1
    static UDP_TABLE_OWNER_MODULE := 2
}
struct TCPIP_OWNER_MODULE_INFO_CLASS extends Int32 {
    static TCPIP_OWNER_MODULE_INFO_BASIC := 0
}
struct TCPIP_OWNER_MODULE_BASIC_INFO {
    pModuleName : PWSTR
    pModulePath : PWSTR
}
struct MIB_IPMCAST_BOUNDARY {
    dwIfIndex : UInt32
    dwGroupAddress : UInt32
    dwGroupMask : UInt32
    dwStatus : UInt32
}
struct MIB_IPMCAST_BOUNDARY_TABLE {
    dwNumEntries : UInt32
    table : MIB_IPMCAST_BOUNDARY[1]
}
struct MIB_BOUNDARYROW {
    dwGroupAddress : UInt32
    dwGroupMask : UInt32
}
struct MIB_MCAST_LIMIT_ROW {
    dwTtl : UInt32
    dwRateLimit : UInt32
}
struct MIB_IPMCAST_SCOPE {
    dwGroupAddress : UInt32
    dwGroupMask : UInt32
    snNameBuffer : UInt16[256]
    dwStatus : UInt32
}
struct MIB_IPDESTROW {
    ForwardRow : MIB_IPFORWARDROW
    dwForwardPreference : UInt32
    dwForwardViewSet : UInt32
}
struct MIB_IPDESTTABLE {
    dwNumEntries : UInt32
    table : MIB_IPDESTROW[1]
}
struct MIB_BEST_IF {
    dwDestAddr : UInt32
    dwIfIndex : UInt32
}
struct MIB_PROXYARP {
    dwAddress : UInt32
    dwMask : UInt32
    dwIfIndex : UInt32
}
struct MIB_IFSTATUS {
    dwIfIndex : UInt32
    dwAdminStatus : UInt32
    dwOperationalStatus : UInt32
    bMHbeatActive : BOOL
    bMHbeatAlive : BOOL
}
struct MIB_ROUTESTATE {
    bRoutesSetToStack : BOOL
}
struct MIB_OPAQUE_INFO {
    dwId : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ullAlign : Int64
            rgbyData : UInt8[1]
        }
    }
}
struct IP_ADDRESS_STRING {
    String : CHAR[16]
}
struct IP_ADDR_STRING {
    Next : IP_ADDR_STRING.Ptr
    IpAddress : IP_ADDRESS_STRING
    IpMask : IP_ADDRESS_STRING
    Context : UInt32
}
struct IP_ADAPTER_INFO {
    Next : IP_ADAPTER_INFO.Ptr
    ComboIndex : UInt32
    AdapterName : CHAR[260]
    Description : CHAR[132]
    AddressLength : UInt32
    Address : UInt8[8]
    Index : UInt32
    Type : UInt32
    DhcpEnabled : UInt32
    CurrentIpAddress : IP_ADDR_STRING.Ptr
    IpAddressList : IP_ADDR_STRING
    GatewayList : IP_ADDR_STRING
    DhcpServer : IP_ADDR_STRING
    HaveWins : BOOL
    PrimaryWinsServer : IP_ADDR_STRING
    SecondaryWinsServer : IP_ADDR_STRING
    LeaseObtained : Int64
    LeaseExpires : Int64
}
struct IP_ADAPTER_UNICAST_ADDRESS_LH {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_UNICAST_ADDRESS_LH.Ptr
    Address : SOCKET_ADDRESS
    PrefixOrigin : NL_PREFIX_ORIGIN
    SuffixOrigin : NL_SUFFIX_ORIGIN
    DadState : NL_DAD_STATE
    ValidLifetime : UInt32
    PreferredLifetime : UInt32
    LeaseLifetime : UInt32
    OnLinkPrefixLength : UInt8
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Flags : UInt32
        }
    }
}
struct IP_ADAPTER_UNICAST_ADDRESS_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_UNICAST_ADDRESS_XP.Ptr
    Address : SOCKET_ADDRESS
    PrefixOrigin : NL_PREFIX_ORIGIN
    SuffixOrigin : NL_SUFFIX_ORIGIN
    DadState : NL_DAD_STATE
    ValidLifetime : UInt32
    PreferredLifetime : UInt32
    LeaseLifetime : UInt32
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Flags : UInt32
        }
    }
}
struct IP_ADAPTER_ANYCAST_ADDRESS_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_ANYCAST_ADDRESS_XP.Ptr
    Address : SOCKET_ADDRESS
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Flags : UInt32
        }
    }
}
struct IP_ADAPTER_MULTICAST_ADDRESS_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_MULTICAST_ADDRESS_XP.Ptr
    Address : SOCKET_ADDRESS
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Flags : UInt32
        }
    }
}
struct IP_ADAPTER_DNS_SERVER_ADDRESS_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_DNS_SERVER_ADDRESS_XP.Ptr
    Address : SOCKET_ADDRESS
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Reserved : UInt32
        }
    }
}
struct IP_ADAPTER_WINS_SERVER_ADDRESS_LH {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_WINS_SERVER_ADDRESS_LH.Ptr
    Address : SOCKET_ADDRESS
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Reserved : UInt32
        }
    }
}
struct IP_ADAPTER_GATEWAY_ADDRESS_LH {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_GATEWAY_ADDRESS_LH.Ptr
    Address : SOCKET_ADDRESS
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Reserved : UInt32
        }
    }
}
struct IP_ADAPTER_PREFIX_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_PREFIX_XP.Ptr
    Address : SOCKET_ADDRESS
    PrefixLength : UInt32
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            Flags : UInt32
        }
    }
}
struct IP_ADAPTER_DNS_SUFFIX {
    Next : IP_ADAPTER_DNS_SUFFIX.Ptr
    String : UInt16[256]
}
struct IP_ADAPTER_ADDRESSES_LH {
    Anonymous1 : this._Anonymous1_e__Union
    Next : IP_ADAPTER_ADDRESSES_LH.Ptr
    AdapterName : PSTR
    FirstUnicastAddress : IP_ADAPTER_UNICAST_ADDRESS_LH.Ptr
    FirstAnycastAddress : IP_ADAPTER_ANYCAST_ADDRESS_XP.Ptr
    FirstMulticastAddress : IP_ADAPTER_MULTICAST_ADDRESS_XP.Ptr
    FirstDnsServerAddress : IP_ADAPTER_DNS_SERVER_ADDRESS_XP.Ptr
    DnsSuffix : PWSTR
    Description : PWSTR
    FriendlyName : PWSTR
    PhysicalAddress : UInt8[8]
    PhysicalAddressLength : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Mtu : UInt32
    IfType : UInt32
    OperStatus : IF_OPER_STATUS
    Ipv6IfIndex : UInt32
    ZoneIndices : UInt32[16]
    FirstPrefix : IP_ADAPTER_PREFIX_XP.Ptr
    TransmitLinkSpeed : Int64
    ReceiveLinkSpeed : Int64
    FirstWinsServerAddress : IP_ADAPTER_WINS_SERVER_ADDRESS_LH.Ptr
    FirstGatewayAddress : IP_ADAPTER_GATEWAY_ADDRESS_LH.Ptr
    Ipv4Metric : UInt32
    Ipv6Metric : UInt32
    Luid : NET_LUID_LH
    Dhcpv4Server : SOCKET_ADDRESS
    CompartmentId : NET_IF_COMPARTMENT_ID
    NetworkGuid : GUID
    ConnectionType : NET_IF_CONNECTION_TYPE
    TunnelType : TUNNEL_TYPE
    Dhcpv6Server : SOCKET_ADDRESS
    Dhcpv6ClientDuid : UInt8[130]
    Dhcpv6ClientDuidLength : UInt32
    Dhcpv6Iaid : UInt32
    FirstDnsSuffix : IP_ADAPTER_DNS_SUFFIX.Ptr
    struct _Anonymous1_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            IfIndex : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct IP_ADAPTER_ADDRESSES_XP {
    Anonymous : this._Anonymous_e__Union
    Next : IP_ADAPTER_ADDRESSES_XP.Ptr
    AdapterName : PSTR
    FirstUnicastAddress : IP_ADAPTER_UNICAST_ADDRESS_XP.Ptr
    FirstAnycastAddress : IP_ADAPTER_ANYCAST_ADDRESS_XP.Ptr
    FirstMulticastAddress : IP_ADAPTER_MULTICAST_ADDRESS_XP.Ptr
    FirstDnsServerAddress : IP_ADAPTER_DNS_SERVER_ADDRESS_XP.Ptr
    DnsSuffix : PWSTR
    Description : PWSTR
    FriendlyName : PWSTR
    PhysicalAddress : UInt8[8]
    PhysicalAddressLength : UInt32
    Flags : UInt32
    Mtu : UInt32
    IfType : UInt32
    OperStatus : IF_OPER_STATUS
    Ipv6IfIndex : UInt32
    ZoneIndices : UInt32[16]
    FirstPrefix : IP_ADAPTER_PREFIX_XP.Ptr
    struct _Anonymous_e__Union {
        union {
            Alignment : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Length : UInt32
            IfIndex : UInt32
        }
    }
}
struct IP_PER_ADAPTER_INFO_W2KSP1 {
    AutoconfigEnabled : UInt32
    AutoconfigActive : UInt32
    CurrentDnsServer : IP_ADDR_STRING.Ptr
    DnsServerList : IP_ADDR_STRING
}
struct FIXED_INFO_W2KSP1 {
    HostName : CHAR[132]
    DomainName : CHAR[132]
    CurrentDnsServer : IP_ADDR_STRING.Ptr
    DnsServerList : IP_ADDR_STRING
    NodeType : UInt32
    ScopeId : CHAR[260]
    EnableRouting : UInt32
    EnableProxy : UInt32
    EnableDns : UInt32
}
struct IP_INTERFACE_NAME_INFO_W2KSP1 {
    Index : UInt32
    MediaType : UInt32
    ConnectionType : UInt8
    AccessType : UInt8
    DeviceGuid : GUID
    InterfaceGuid : GUID
}
struct TCP_ESTATS_TYPE extends Int32 {
    static TcpConnectionEstatsSynOpts := 0
    static TcpConnectionEstatsData := 1
    static TcpConnectionEstatsSndCong := 2
    static TcpConnectionEstatsPath := 3
    static TcpConnectionEstatsSendBuff := 4
    static TcpConnectionEstatsRec := 5
    static TcpConnectionEstatsObsRec := 6
    static TcpConnectionEstatsBandwidth := 7
    static TcpConnectionEstatsFineRtt := 8
    static TcpConnectionEstatsMaximum := 9
}
struct TCP_BOOLEAN_OPTIONAL extends Int32 {
    static TcpBoolOptDisabled := 0
    static TcpBoolOptEnabled := 1
    static TcpBoolOptUnchanged := -1
}
struct TCP_ESTATS_SYN_OPTS_ROS_v0 {
    ActiveOpen : BOOLEAN
    MssRcvd : UInt32
    MssSent : UInt32
}
struct TCP_SOFT_ERROR extends Int32 {
    static TcpErrorNone := 0
    static TcpErrorBelowDataWindow := 1
    static TcpErrorAboveDataWindow := 2
    static TcpErrorBelowAckWindow := 3
    static TcpErrorAboveAckWindow := 4
    static TcpErrorBelowTsWindow := 5
    static TcpErrorAboveTsWindow := 6
    static TcpErrorDataChecksumError := 7
    static TcpErrorDataLengthError := 8
    static TcpErrorMaxSoftError := 9
}
struct TCP_ESTATS_DATA_ROD_v0 {
    DataBytesOut : Int64
    DataSegsOut : Int64
    DataBytesIn : Int64
    DataSegsIn : Int64
    SegsOut : Int64
    SegsIn : Int64
    SoftErrors : UInt32
    SoftErrorReason : UInt32
    SndUna : UInt32
    SndNxt : UInt32
    SndMax : UInt32
    ThruBytesAcked : Int64
    RcvNxt : UInt32
    ThruBytesReceived : Int64
}
struct TCP_ESTATS_DATA_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_SND_CONG_ROD_v0 {
    SndLimTransRwin : UInt32
    SndLimTimeRwin : UInt32
    SndLimBytesRwin : IntPtr
    SndLimTransCwnd : UInt32
    SndLimTimeCwnd : UInt32
    SndLimBytesCwnd : IntPtr
    SndLimTransSnd : UInt32
    SndLimTimeSnd : UInt32
    SndLimBytesSnd : IntPtr
    SlowStart : UInt32
    CongAvoid : UInt32
    OtherReductions : UInt32
    CurCwnd : UInt32
    MaxSsCwnd : UInt32
    MaxCaCwnd : UInt32
    CurSsthresh : UInt32
    MaxSsthresh : UInt32
    MinSsthresh : UInt32
}
struct TCP_ESTATS_SND_CONG_ROS_v0 {
    LimCwnd : UInt32
}
struct TCP_ESTATS_SND_CONG_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_PATH_ROD_v0 {
    FastRetran : UInt32
    Timeouts : UInt32
    SubsequentTimeouts : UInt32
    CurTimeoutCount : UInt32
    AbruptTimeouts : UInt32
    PktsRetrans : UInt32
    BytesRetrans : UInt32
    DupAcksIn : UInt32
    SacksRcvd : UInt32
    SackBlocksRcvd : UInt32
    CongSignals : UInt32
    PreCongSumCwnd : UInt32
    PreCongSumRtt : UInt32
    PostCongSumRtt : UInt32
    PostCongCountRtt : UInt32
    EcnSignals : UInt32
    EceRcvd : UInt32
    SendStall : UInt32
    QuenchRcvd : UInt32
    RetranThresh : UInt32
    SndDupAckEpisodes : UInt32
    SumBytesReordered : UInt32
    NonRecovDa : UInt32
    NonRecovDaEpisodes : UInt32
    AckAfterFr : UInt32
    DsackDups : UInt32
    SampleRtt : UInt32
    SmoothedRtt : UInt32
    RttVar : UInt32
    MaxRtt : UInt32
    MinRtt : UInt32
    SumRtt : UInt32
    CountRtt : UInt32
    CurRto : UInt32
    MaxRto : UInt32
    MinRto : UInt32
    CurMss : UInt32
    MaxMss : UInt32
    MinMss : UInt32
    SpuriousRtoDetections : UInt32
}
struct TCP_ESTATS_PATH_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_SEND_BUFF_ROD_v0 {
    CurRetxQueue : IntPtr
    MaxRetxQueue : IntPtr
    CurAppWQueue : IntPtr
    MaxAppWQueue : IntPtr
}
struct TCP_ESTATS_SEND_BUFF_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_REC_ROD_v0 {
    CurRwinSent : UInt32
    MaxRwinSent : UInt32
    MinRwinSent : UInt32
    LimRwin : UInt32
    DupAckEpisodes : UInt32
    DupAcksOut : UInt32
    CeRcvd : UInt32
    EcnSent : UInt32
    EcnNoncesRcvd : UInt32
    CurReasmQueue : UInt32
    MaxReasmQueue : UInt32
    CurAppRQueue : IntPtr
    MaxAppRQueue : IntPtr
    WinScaleSent : UInt8
}
struct TCP_ESTATS_REC_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_OBS_REC_ROD_v0 {
    CurRwinRcvd : UInt32
    MaxRwinRcvd : UInt32
    MinRwinRcvd : UInt32
    WinScaleRcvd : UInt8
}
struct TCP_ESTATS_OBS_REC_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_BANDWIDTH_RW_v0 {
    EnableCollectionOutbound : TCP_BOOLEAN_OPTIONAL
    EnableCollectionInbound : TCP_BOOLEAN_OPTIONAL
}
struct TCP_ESTATS_BANDWIDTH_ROD_v0 {
    OutboundBandwidth : Int64
    InboundBandwidth : Int64
    OutboundInstability : Int64
    InboundInstability : Int64
    OutboundBandwidthPeaked : BOOLEAN
    InboundBandwidthPeaked : BOOLEAN
}
struct TCP_ESTATS_FINE_RTT_RW_v0 {
    EnableCollection : BOOLEAN
}
struct TCP_ESTATS_FINE_RTT_ROD_v0 {
    RttVar : UInt32
    MaxRtt : UInt32
    MinRtt : UInt32
    SumRtt : UInt32
}
struct INTERFACE_HARDWARE_TIMESTAMP_CAPABILITIES {
    PtpV2OverUdpIPv4EventMessageReceive : BOOLEAN
    PtpV2OverUdpIPv4AllMessageReceive : BOOLEAN
    PtpV2OverUdpIPv4EventMessageTransmit : BOOLEAN
    PtpV2OverUdpIPv4AllMessageTransmit : BOOLEAN
    PtpV2OverUdpIPv6EventMessageReceive : BOOLEAN
    PtpV2OverUdpIPv6AllMessageReceive : BOOLEAN
    PtpV2OverUdpIPv6EventMessageTransmit : BOOLEAN
    PtpV2OverUdpIPv6AllMessageTransmit : BOOLEAN
    AllReceive : BOOLEAN
    AllTransmit : BOOLEAN
    TaggedTransmit : BOOLEAN
}
struct INTERFACE_SOFTWARE_TIMESTAMP_CAPABILITIES {
    AllReceive : BOOLEAN
    AllTransmit : BOOLEAN
    TaggedTransmit : BOOLEAN
}
struct INTERFACE_TIMESTAMP_CAPABILITIES {
    HardwareClockFrequencyHz : Int64
    SupportsCrossTimestamp : BOOLEAN
    HardwareCapabilities : INTERFACE_HARDWARE_TIMESTAMP_CAPABILITIES
    SoftwareCapabilities : INTERFACE_SOFTWARE_TIMESTAMP_CAPABILITIES
}
struct INTERFACE_HARDWARE_CROSSTIMESTAMP {
    SystemTimestamp1 : Int64
    HardwareClockTimestamp : Int64
    SystemTimestamp2 : Int64
}
struct PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct NET_ADDRESS_FORMAT extends Int32 {
    static NET_ADDRESS_FORMAT_UNSPECIFIED := 0
    static NET_ADDRESS_DNS_NAME := 1
    static NET_ADDRESS_IPV4 := 2
    static NET_ADDRESS_IPV6 := 3
}
struct NET_ADDRESS_INFO {
    Format : NET_ADDRESS_FORMAT
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            NamedAddress : this._NamedAddress_e__Struct
            Ipv4Address : SOCKADDR_IN
            Ipv6Address : SOCKADDR_IN6
            IpAddress : SOCKADDR
        }
        struct _NamedAddress_e__Struct {
            Address : UInt16[256]
            Port : UInt16[6]
        }
    }
}
struct MIB_NOTIFICATION_TYPE extends Int32 {
    static MibParameterNotification := 0
    static MibAddInstance := 1
    static MibDeleteInstance := 2
    static MibInitialNotification := 3
}
struct MIB_IF_ROW2 {
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    InterfaceGuid : GUID
    Alias : UInt16[257]
    Description : UInt16[257]
    PhysicalAddressLength : UInt32
    PhysicalAddress : UInt8[32]
    PermanentPhysicalAddress : UInt8[32]
    Mtu : UInt32
    Type : UInt32
    TunnelType : TUNNEL_TYPE
    MediaType : NDIS_MEDIUM
    PhysicalMediumType : NDIS_PHYSICAL_MEDIUM
    AccessType : NET_IF_ACCESS_TYPE
    DirectionType : NET_IF_DIRECTION_TYPE
    InterfaceAndOperStatusFlags : this._InterfaceAndOperStatusFlags_e__Struct
    OperStatus : IF_OPER_STATUS
    AdminStatus : NET_IF_ADMIN_STATUS
    MediaConnectState : NET_IF_MEDIA_CONNECT_STATE
    NetworkGuid : GUID
    ConnectionType : NET_IF_CONNECTION_TYPE
    TransmitLinkSpeed : Int64
    ReceiveLinkSpeed : Int64
    InOctets : Int64
    InUcastPkts : Int64
    InNUcastPkts : Int64
    InDiscards : Int64
    InErrors : Int64
    InUnknownProtos : Int64
    InUcastOctets : Int64
    InMulticastOctets : Int64
    InBroadcastOctets : Int64
    OutOctets : Int64
    OutUcastPkts : Int64
    OutNUcastPkts : Int64
    OutDiscards : Int64
    OutErrors : Int64
    OutUcastOctets : Int64
    OutMulticastOctets : Int64
    OutBroadcastOctets : Int64
    OutQLen : Int64
    struct _InterfaceAndOperStatusFlags_e__Struct {
        _bitfield : UInt8
    }
}
struct MIB_IF_TABLE2 {
    NumEntries : UInt32
    Table : MIB_IF_ROW2[1]
}
struct MIB_IF_ENTRY_LEVEL extends Int32 {
    static MibIfEntryNormal := 0
    static MibIfEntryNormalWithoutStatistics := 2
}
struct MIB_IF_TABLE_LEVEL extends Int32 {
    static MibIfTableNormal := 0
    static MibIfTableRaw := 1
    static MibIfTableNormalWithoutStatistics := 2
}
struct MIB_IPINTERFACE_ROW {
    Family : ADDRESS_FAMILY
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    MaxReassemblySize : UInt32
    InterfaceIdentifier : Int64
    MinRouterAdvertisementInterval : UInt32
    MaxRouterAdvertisementInterval : UInt32
    AdvertisingEnabled : BOOLEAN
    ForwardingEnabled : BOOLEAN
    WeakHostSend : BOOLEAN
    WeakHostReceive : BOOLEAN
    UseAutomaticMetric : BOOLEAN
    UseNeighborUnreachabilityDetection : BOOLEAN
    ManagedAddressConfigurationSupported : BOOLEAN
    OtherStatefulConfigurationSupported : BOOLEAN
    AdvertiseDefaultRoute : BOOLEAN
    RouterDiscoveryBehavior : NL_ROUTER_DISCOVERY_BEHAVIOR
    DadTransmits : UInt32
    BaseReachableTime : UInt32
    RetransmitTime : UInt32
    PathMtuDiscoveryTimeout : UInt32
    LinkLocalAddressBehavior : NL_LINK_LOCAL_ADDRESS_BEHAVIOR
    LinkLocalAddressTimeout : UInt32
    ZoneIndices : UInt32[16]
    SitePrefixLength : UInt32
    Metric : UInt32
    NlMtu : UInt32
    Connected : BOOLEAN
    SupportsWakeUpPatterns : BOOLEAN
    SupportsNeighborDiscovery : BOOLEAN
    SupportsRouterDiscovery : BOOLEAN
    ReachableTime : UInt32
    TransmitOffload : NL_INTERFACE_OFFLOAD_ROD
    ReceiveOffload : NL_INTERFACE_OFFLOAD_ROD
    DisableDefaultRoutes : BOOLEAN
}
struct MIB_IPINTERFACE_TABLE {
    NumEntries : UInt32
    Table : MIB_IPINTERFACE_ROW[1]
}
struct MIB_IFSTACK_ROW {
    HigherLayerInterfaceIndex : UInt32
    LowerLayerInterfaceIndex : UInt32
}
struct MIB_INVERTEDIFSTACK_ROW {
    LowerLayerInterfaceIndex : UInt32
    HigherLayerInterfaceIndex : UInt32
}
struct MIB_IFSTACK_TABLE {
    NumEntries : UInt32
    Table : MIB_IFSTACK_ROW[1]
}
struct MIB_INVERTEDIFSTACK_TABLE {
    NumEntries : UInt32
    Table : MIB_INVERTEDIFSTACK_ROW[1]
}
struct PIPINTERFACE_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, MIB_IPINTERFACE_ROW.Ptr, MIB_NOTIFICATION_TYPE, "Void"]
}
struct MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES {
    InboundBandwidthInformation : NL_BANDWIDTH_INFORMATION
    OutboundBandwidthInformation : NL_BANDWIDTH_INFORMATION
}
struct MIB_UNICASTIPADDRESS_ROW {
    Address : SOCKADDR_INET
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    PrefixOrigin : NL_PREFIX_ORIGIN
    SuffixOrigin : NL_SUFFIX_ORIGIN
    ValidLifetime : UInt32
    PreferredLifetime : UInt32
    OnLinkPrefixLength : UInt8
    SkipAsSource : BOOLEAN
    DadState : NL_DAD_STATE
    ScopeId : SCOPE_ID
    CreationTimeStamp : Int64
}
struct MIB_UNICASTIPADDRESS_TABLE {
    NumEntries : UInt32
    Table : MIB_UNICASTIPADDRESS_ROW[1]
}
struct PUNICAST_IPADDRESS_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, MIB_UNICASTIPADDRESS_ROW.Ptr, MIB_NOTIFICATION_TYPE, "Void"]
}
struct PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, MIB_UNICASTIPADDRESS_TABLE.Ptr, "Void"]
}
struct MIB_ANYCASTIPADDRESS_ROW {
    Address : SOCKADDR_INET
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    ScopeId : SCOPE_ID
}
struct MIB_ANYCASTIPADDRESS_TABLE {
    NumEntries : UInt32
    Table : MIB_ANYCASTIPADDRESS_ROW[1]
}
struct MIB_MULTICASTIPADDRESS_ROW {
    Address : SOCKADDR_INET
    InterfaceIndex : UInt32
    InterfaceLuid : NET_LUID_LH
    ScopeId : SCOPE_ID
}
struct MIB_MULTICASTIPADDRESS_TABLE {
    NumEntries : UInt32
    Table : MIB_MULTICASTIPADDRESS_ROW[1]
}
struct IP_ADDRESS_PREFIX {
    Prefix : SOCKADDR_INET
    PrefixLength : UInt8
}
struct MIB_IPFORWARD_ROW2 {
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    DestinationPrefix : IP_ADDRESS_PREFIX
    NextHop : SOCKADDR_INET
    SitePrefixLength : UInt8
    ValidLifetime : UInt32
    PreferredLifetime : UInt32
    Metric : UInt32
    Protocol : NL_ROUTE_PROTOCOL
    Loopback : BOOLEAN
    AutoconfigureAddress : BOOLEAN
    Publish : BOOLEAN
    Immortal : BOOLEAN
    Age : UInt32
    Origin : NL_ROUTE_ORIGIN
}
struct MIB_IPFORWARD_TABLE2 {
    NumEntries : UInt32
    Table : MIB_IPFORWARD_ROW2[1]
}
struct PIPFORWARD_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, MIB_IPFORWARD_ROW2.Ptr, MIB_NOTIFICATION_TYPE, "Void"]
}
struct MIB_IPPATH_ROW {
    Source : SOCKADDR_INET
    Destination : SOCKADDR_INET
    InterfaceLuid : NET_LUID_LH
    InterfaceIndex : UInt32
    CurrentNextHop : SOCKADDR_INET
    PathMtu : UInt32
    RttMean : UInt32
    RttDeviation : UInt32
    Anonymous : this._Anonymous_e__Union
    IsReachable : BOOLEAN
    LinkTransmitSpeed : Int64
    LinkReceiveSpeed : Int64
    struct _Anonymous_e__Union {
        union {
            LastReachable : UInt32
            LastUnreachable : UInt32
        }
    }
}
struct MIB_IPPATH_TABLE {
    NumEntries : UInt32
    Table : MIB_IPPATH_ROW[1]
}
struct MIB_IPNET_ROW2 {
    Address : SOCKADDR_INET
    InterfaceIndex : UInt32
    InterfaceLuid : NET_LUID_LH
    PhysicalAddress : UInt8[32]
    PhysicalAddressLength : UInt32
    State : NL_NEIGHBOR_STATE
    Anonymous : this._Anonymous_e__Union
    ReachabilityTime : this._ReachabilityTime_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Flags : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _ReachabilityTime_e__Union {
        union {
            LastReachable : UInt32
            LastUnreachable : UInt32
        }
    }
}
struct MIB_IPNET_TABLE2 {
    NumEntries : UInt32
    Table : MIB_IPNET_ROW2[1]
}
struct PTEREDO_PORT_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16, MIB_NOTIFICATION_TYPE, "Void"]
}
struct DNS_SETTINGS {
    Version : UInt32
    Flags : Int64
    Hostname : PWSTR
    Domain : PWSTR
    SearchList : PWSTR
}
struct DNS_SETTINGS2 {
    Version : UInt32
    Flags : Int64
    Hostname : PWSTR
    Domain : PWSTR
    SearchList : PWSTR
    SettingFlags : Int64
}
struct DNS_DOH_SERVER_SETTINGS {
    Template : PWSTR
    Flags : Int64
}
struct DNS_DOT_SERVER_SETTINGS {
    Hostname : PWSTR
    Flags : Int64
    Port : UInt16
}
struct DNS_SERVER_PROPERTY_TYPE extends Int32 {
    static DnsServerInvalidProperty := 0
    static DnsServerDohProperty := 1
    static DnsServerDotProperty := 2
}
struct DNS_SERVER_PROPERTY_TYPES {
    union {
        DohSettings : DNS_DOH_SERVER_SETTINGS.Ptr
        DotSettings : DNS_DOT_SERVER_SETTINGS.Ptr
    }
}
struct DNS_SERVER_PROPERTY {
    Version : UInt32
    ServerIndex : UInt32
    Type : DNS_SERVER_PROPERTY_TYPE
    Property : DNS_SERVER_PROPERTY_TYPES
}
struct DNS_INTERFACE_SETTINGS {
    Version : UInt32
    Flags : Int64
    Domain : PWSTR
    NameServer : PWSTR
    SearchList : PWSTR
    RegistrationEnabled : UInt32
    RegisterAdapterName : UInt32
    EnableLLMNR : UInt32
    QueryAdapterName : UInt32
    ProfileNameServer : PWSTR
}
struct DNS_INTERFACE_SETTINGS_EX {
    SettingsV1 : DNS_INTERFACE_SETTINGS
    DisableUnconstrainedQueries : UInt32
    SupplementalSearchList : PWSTR
}
struct DNS_INTERFACE_SETTINGS3 {
    Version : UInt32
    Flags : Int64
    Domain : PWSTR
    NameServer : PWSTR
    SearchList : PWSTR
    RegistrationEnabled : UInt32
    RegisterAdapterName : UInt32
    EnableLLMNR : UInt32
    QueryAdapterName : UInt32
    ProfileNameServer : PWSTR
    DisableUnconstrainedQueries : UInt32
    SupplementalSearchList : PWSTR
    cServerProperties : UInt32
    ServerProperties : DNS_SERVER_PROPERTY.Ptr
    cProfileServerProperties : UInt32
    ProfileServerProperties : DNS_SERVER_PROPERTY.Ptr
}
struct DNS_INTERFACE_SETTINGS4 {
    Version : UInt32
    Flags : Int64
    Domain : PWSTR
    NameServer : PWSTR
    SearchList : PWSTR
    RegistrationEnabled : UInt32
    RegisterAdapterName : UInt32
    EnableLLMNR : UInt32
    QueryAdapterName : UInt32
    ProfileNameServer : PWSTR
    DisableUnconstrainedQueries : UInt32
    SupplementalSearchList : PWSTR
    cServerProperties : UInt32
    ServerProperties : DNS_SERVER_PROPERTY.Ptr
    cProfileServerProperties : UInt32
    ProfileServerProperties : DNS_SERVER_PROPERTY.Ptr
    EncryptedDnsAdapterFlags : UInt32
}
struct PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, NL_NETWORK_CONNECTIVITY_HINT, "Void"]
}
struct NET_FL_VIRTUAL_INTERFACE_ORIGIN extends Int32 {
    static NetFlVirtualInterfaceOriginOid := 0
    static NetFlVirtualInterfaceOriginApi := 1
    static NetFlVirtualInterfaceOriginDefault := 2
}
struct NET_FL_ISOLATION_MODE extends Int32 {
    static NetFlIsolationModeNone := 0
    static NetFlIsolationModeVlan := 1
    static NetFlIsolationModeVsid := 2
}
struct MIB_FL_VIRTUAL_INTERFACE_ROW {
    Family : ADDRESS_FAMILY
    IfLuid : NET_LUID_LH
    VirtualIfId : UInt32
    CompartmentGuid : GUID
    IsolationMode : NET_FL_ISOLATION_MODE
    Origin : NET_FL_VIRTUAL_INTERFACE_ORIGIN
    VirtualIfLuid : NET_LUID_LH
    VirtualIfIndex : UInt32
    AllowLocalNd : BOOLEAN
    AttachedFlsnpiClients : UInt32
    FlsnpiClientConfigErrors : UInt32
    FlsnpiClientInjectErrors : Int64
    FlsnpiClientCloneErrors : Int64
    InFlsnpiIndicatedPackets : Int64
    InFlsnpiClientReturnedPackets : Int64
    InFlsnpiClientSilentlyDroppedPackets : Int64
    InFlsnpiClientDroppedPackets : Int64
    InFlsnpiClientInjectedPackets : Int64
    InFlsnpiClientClonedPackets : Int64
    OutFlsnpiIndicatedPackets : Int64
    OutFlsnpiClientReturnedPackets : Int64
    OutFlsnpiClientDroppedPackets : Int64
    OutFlsnpiClientSilentlyDroppedPackets : Int64
    OutFlsnpiClientInjectedPackets : Int64
    OutFlsnpiClientClonedPackets : Int64
    OutFlsnpiClientClonedPacketsForNbSplit : Int64
}
struct MIB_FL_VIRTUAL_INTERFACE_TABLE {
    NumEntries : UInt32
    Table : MIB_FL_VIRTUAL_INTERFACE_ROW[1]
}
struct GLOBAL_FILTER extends Int32 {
    static GF_FRAGMENTS := 2
    static GF_STRONGHOST := 8
    static GF_FRAGCACHE := 9
}
struct PFFORWARD_ACTION extends Int32 {
    static PF_ACTION_FORWARD := 0
    static PF_ACTION_DROP := 1
}
struct PFADDRESSTYPE extends Int32 {
    static PF_IPV4 := 0
    static PF_IPV6 := 1
}
struct PF_FILTER_DESCRIPTOR {
    dwFilterFlags : UInt32
    dwRule : UInt32
    pfatType : PFADDRESSTYPE
    SrcAddr : UInt8.Ptr
    SrcMask : UInt8.Ptr
    DstAddr : UInt8.Ptr
    DstMask : UInt8.Ptr
    dwProtocol : UInt32
    fLateBound : UInt32
    wSrcPort : UInt16
    wDstPort : UInt16
    wSrcPortHighRange : UInt16
    wDstPortHighRange : UInt16
}
struct PF_FILTER_STATS {
    dwNumPacketsFiltered : UInt32
    info : PF_FILTER_DESCRIPTOR
}
struct PF_INTERFACE_STATS {
    pvDriverContext : Struct.Ptr
    dwFlags : UInt32
    dwInDrops : UInt32
    dwOutDrops : UInt32
    eaInAction : PFFORWARD_ACTION
    eaOutAction : PFFORWARD_ACTION
    dwNumInFilters : UInt32
    dwNumOutFilters : UInt32
    dwFrag : UInt32
    dwSpoof : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    liSYN : Int64
    liTotalLogged : Int64
    dwLostLogEntries : UInt32
    FilterInfo : PF_FILTER_STATS[1]
}
struct PF_LATEBIND_INFO {
    SrcAddr : UInt8.Ptr
    DstAddr : UInt8.Ptr
    Mask : UInt8.Ptr
}
struct PFFRAMETYPE extends Int32 {
    static PFFT_FILTER := 1
    static PFFT_FRAG := 2
    static PFFT_SPOOF := 3
}
struct PFLOGFRAME {
    Timestamp : Int64
    pfeTypeOfFrame : PFFRAMETYPE
    dwTotalSizeUsed : UInt32
    dwFilterRule : UInt32
    wSizeOfAdditionalData : UInt16
    wSizeOfIpHeader : UInt16
    dwInterfaceName : UInt32
    dwIPIndex : UInt32
    bPacketData : UInt8[1]
}
