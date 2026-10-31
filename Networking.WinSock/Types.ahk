#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, HANDLE, HWND, LPARAM, LUID, PSTR, PWSTR, WPARAM}
#Import "..\System.Com\Types.ahk" {BLOB}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}
#Import "..\System.Kernel\Types.ahk" {COMPARTMENT_ID, PROCESSOR_NUMBER}

struct WSA_ERROR extends Int32 {
    static WSA_IO_PENDING := 997
    static WSA_IO_INCOMPLETE := 996
    static WSA_INVALID_HANDLE := 6
    static WSA_INVALID_PARAMETER := 87
    static WSA_NOT_ENOUGH_MEMORY := 8
    static WSA_OPERATION_ABORTED := 995
    static WSA_WAIT_EVENT_0 := 0
    static WSA_WAIT_IO_COMPLETION := 192
    static WSABASEERR := 10000
    static WSAEINTR := 10004
    static WSAEBADF := 10009
    static WSAEACCES := 10013
    static WSAEFAULT := 10014
    static WSAEINVAL := 10022
    static WSAEMFILE := 10024
    static WSAEWOULDBLOCK := 10035
    static WSAEINPROGRESS := 10036
    static WSAEALREADY := 10037
    static WSAENOTSOCK := 10038
    static WSAEDESTADDRREQ := 10039
    static WSAEMSGSIZE := 10040
    static WSAEPROTOTYPE := 10041
    static WSAENOPROTOOPT := 10042
    static WSAEPROTONOSUPPORT := 10043
    static WSAESOCKTNOSUPPORT := 10044
    static WSAEOPNOTSUPP := 10045
    static WSAEPFNOSUPPORT := 10046
    static WSAEAFNOSUPPORT := 10047
    static WSAEADDRINUSE := 10048
    static WSAEADDRNOTAVAIL := 10049
    static WSAENETDOWN := 10050
    static WSAENETUNREACH := 10051
    static WSAENETRESET := 10052
    static WSAECONNABORTED := 10053
    static WSAECONNRESET := 10054
    static WSAENOBUFS := 10055
    static WSAEISCONN := 10056
    static WSAENOTCONN := 10057
    static WSAESHUTDOWN := 10058
    static WSAETOOMANYREFS := 10059
    static WSAETIMEDOUT := 10060
    static WSAECONNREFUSED := 10061
    static WSAELOOP := 10062
    static WSAENAMETOOLONG := 10063
    static WSAEHOSTDOWN := 10064
    static WSAEHOSTUNREACH := 10065
    static WSAENOTEMPTY := 10066
    static WSAEPROCLIM := 10067
    static WSAEUSERS := 10068
    static WSAEDQUOT := 10069
    static WSAESTALE := 10070
    static WSAEREMOTE := 10071
    static WSASYSNOTREADY := 10091
    static WSAVERNOTSUPPORTED := 10092
    static WSANOTINITIALISED := 10093
    static WSAEDISCON := 10101
    static WSAENOMORE := 10102
    static WSAECANCELLED := 10103
    static WSAEINVALIDPROCTABLE := 10104
    static WSAEINVALIDPROVIDER := 10105
    static WSAEPROVIDERFAILEDINIT := 10106
    static WSASYSCALLFAILURE := 10107
    static WSASERVICE_NOT_FOUND := 10108
    static WSATYPE_NOT_FOUND := 10109
    static WSA_E_NO_MORE := 10110
    static WSA_E_CANCELLED := 10111
    static WSAEREFUSED := 10112
    static WSAHOST_NOT_FOUND := 11001
    static WSATRY_AGAIN := 11002
    static WSANO_RECOVERY := 11003
    static WSANO_DATA := 11004
    static WSA_QOS_RECEIVERS := 11005
    static WSA_QOS_SENDERS := 11006
    static WSA_QOS_NO_SENDERS := 11007
    static WSA_QOS_NO_RECEIVERS := 11008
    static WSA_QOS_REQUEST_CONFIRMED := 11009
    static WSA_QOS_ADMISSION_FAILURE := 11010
    static WSA_QOS_POLICY_FAILURE := 11011
    static WSA_QOS_BAD_STYLE := 11012
    static WSA_QOS_BAD_OBJECT := 11013
    static WSA_QOS_TRAFFIC_CTRL_ERROR := 11014
    static WSA_QOS_GENERIC_ERROR := 11015
    static WSA_QOS_ESERVICETYPE := 11016
    static WSA_QOS_EFLOWSPEC := 11017
    static WSA_QOS_EPROVSPECBUF := 11018
    static WSA_QOS_EFILTERSTYLE := 11019
    static WSA_QOS_EFILTERTYPE := 11020
    static WSA_QOS_EFILTERCOUNT := 11021
    static WSA_QOS_EOBJLENGTH := 11022
    static WSA_QOS_EFLOWCOUNT := 11023
    static WSA_QOS_EUNKOWNPSOBJ := 11024
    static WSA_QOS_EPOLICYOBJ := 11025
    static WSA_QOS_EFLOWDESC := 11026
    static WSA_QOS_EPSFLOWSPEC := 11027
    static WSA_QOS_EPSFILTERSPEC := 11028
    static WSA_QOS_ESDMODEOBJ := 11029
    static WSA_QOS_ESHAPERATEOBJ := 11030
    static WSA_QOS_RESERVED_PETYPE := 11031
    static WSA_SECURE_HOST_NOT_FOUND := 11032
    static WSA_IPSEC_NAME_POLICY_ERROR := 11033
}
struct ADDRESS_FAMILY extends UInt16 {
    static AF_INET := 2
    static AF_INET6 := 23
    static AF_UNSPEC := 0
}
struct SET_SERVICE_OPERATION extends UInt32 {
    static SERVICE_REGISTER := 1
    static SERVICE_DEREGISTER := 2
    static SERVICE_FLUSH := 3
    static SERVICE_ADD_TYPE := 4
    static SERVICE_DELETE_TYPE := 5
}
struct SEND_RECV_FLAGS extends Int32 {
    static MSG_OOB := 1
    static MSG_PEEK := 2
    static MSG_DONTROUTE := 4
    static MSG_WAITALL := 8
    static MSG_PUSH_IMMEDIATE := 32
}
struct RESOURCE_DISPLAY_TYPE extends UInt32 {
    static RESOURCEDISPLAYTYPE_DOMAIN := 1
    static RESOURCEDISPLAYTYPE_FILE := 4
    static RESOURCEDISPLAYTYPE_GENERIC := 0
    static RESOURCEDISPLAYTYPE_GROUP := 5
    static RESOURCEDISPLAYTYPE_SERVER := 2
    static RESOURCEDISPLAYTYPE_SHARE := 3
    static RESOURCEDISPLAYTYPE_TREE := 10
}
struct WSAPOLL_EVENT_FLAGS extends Int16 {
    static POLLRDNORM := 256
    static POLLRDBAND := 512
    static POLLIN := 768
    static POLLPRI := 1024
    static POLLWRNORM := 16
    static POLLOUT := 16
    static POLLWRBAND := 32
    static POLLERR := 1
    static POLLHUP := 2
    static POLLNVAL := 4
}
struct WINSOCK_SHUTDOWN_HOW extends Int32 {
    static SD_RECEIVE := 0
    static SD_SEND := 1
    static SD_BOTH := 2
}
struct WINSOCK_SOCKET_TYPE extends Int32 {
    static SOCK_STREAM := 1
    static SOCK_DGRAM := 2
    static SOCK_RAW := 3
    static SOCK_RDM := 4
    static SOCK_SEQPACKET := 5
}
struct WSAEVENT {
    Value : IntPtr
}
struct SOCKET {
    Value : IntPtr
}
struct socklen_t {
    Value : Int32
}
struct RIO_BUFFERID {
    Value : IntPtr
}
struct RIO_CQ {
    Value : IntPtr
}
struct RIO_RQ {
    Value : IntPtr
}
struct FLOWSPEC {
    TokenRate : UInt32
    TokenBucketSize : UInt32
    PeakBandwidth : UInt32
    Latency : UInt32
    DelayVariation : UInt32
    ServiceType : UInt32
    MaxSduSize : UInt32
    MinimumPolicedSize : UInt32
}
struct SERVENT {
    s_name : PSTR
    s_aliases : Int8.Ptr.Ptr
    s_proto : PSTR
    s_port : Int16
}
struct WSADATA {
    wVersion : UInt16
    wHighVersion : UInt16
    iMaxSockets : UInt16
    iMaxUdpDg : UInt16
    lpVendorInfo : PSTR
    szDescription : CHAR[257]
    szSystemStatus : CHAR[129]
}
struct IN_ADDR {
    S_un : this._S_un_e__Union
    struct _S_un_e__Union {
        union {
            S_un_b : this._S_un_b_e__Struct
            S_un_w : this._S_un_w_e__Struct
            S_addr : UInt32
        }
        struct _S_un_b_e__Struct {
            s_b1 : UInt8
            s_b2 : UInt8
            s_b3 : UInt8
            s_b4 : UInt8
        }
        struct _S_un_w_e__Struct {
            s_w1 : UInt16
            s_w2 : UInt16
        }
    }
}
struct SOCKADDR {
    sa_family : ADDRESS_FAMILY
    sa_data : CHAR[14]
}
struct SOCKET_ADDRESS {
    lpSockaddr : SOCKADDR.Ptr
    iSockaddrLength : Int32
}
struct SOCKET_ADDRESS_LIST {
    iAddressCount : Int32
    Address : SOCKET_ADDRESS[1]
}
struct CSADDR_INFO {
    LocalAddr : SOCKET_ADDRESS
    RemoteAddr : SOCKET_ADDRESS
    iSocketType : Int32
    iProtocol : Int32
}
struct SOCKADDR_STORAGE {
    ss_family : ADDRESS_FAMILY
    __ss_pad1 : CHAR[6]
    __ss_align : Int64
    __ss_pad2 : CHAR[112]
}
struct SOCKADDR_STORAGE_XP {
    ss_family : Int16
    __ss_pad1 : CHAR[6]
    __ss_align : Int64
    __ss_pad2 : CHAR[112]
}
struct SOCKET_PROCESSOR_AFFINITY {
    Processor : PROCESSOR_NUMBER
    NumaNodeId : UInt16
    Reserved : UInt16
}
struct IPPROTO extends Int32 {
    static IPPROTO_HOPOPTS := 0
    static IPPROTO_ICMP := 1
    static IPPROTO_IGMP := 2
    static IPPROTO_GGP := 3
    static IPPROTO_IPV4 := 4
    static IPPROTO_ST := 5
    static IPPROTO_TCP := 6
    static IPPROTO_CBT := 7
    static IPPROTO_EGP := 8
    static IPPROTO_IGP := 9
    static IPPROTO_PUP := 12
    static IPPROTO_UDP := 17
    static IPPROTO_IDP := 22
    static IPPROTO_RDP := 27
    static IPPROTO_IPV6 := 41
    static IPPROTO_ROUTING := 43
    static IPPROTO_FRAGMENT := 44
    static IPPROTO_ESP := 50
    static IPPROTO_AH := 51
    static IPPROTO_ICMPV6 := 58
    static IPPROTO_NONE := 59
    static IPPROTO_DSTOPTS := 60
    static IPPROTO_ND := 77
    static IPPROTO_ICLFXBM := 78
    static IPPROTO_PIM := 103
    static IPPROTO_PGM := 113
    static IPPROTO_L2TP := 115
    static IPPROTO_SCTP := 132
    static IPPROTO_RAW := 255
    static IPPROTO_MAX := 256
    static IPPROTO_RESERVED_RAW := 257
    static IPPROTO_RESERVED_IPSEC := 258
    static IPPROTO_RESERVED_IPSECOFFLOAD := 259
    static IPPROTO_RESERVED_WNV := 260
    static IPPROTO_RESERVED_MAX := 261
    static IPPROTO_IP := 0
    static IPPROTO_RM := 113
}
struct SCOPE_LEVEL extends Int32 {
    static ScopeLevelInterface := 1
    static ScopeLevelLink := 2
    static ScopeLevelSubnet := 3
    static ScopeLevelAdmin := 4
    static ScopeLevelSite := 5
    static ScopeLevelOrganization := 8
    static ScopeLevelGlobal := 14
    static ScopeLevelCount := 16
}
struct SCOPE_ID {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct SOCKADDR_IN {
    sin_family : ADDRESS_FAMILY
    sin_port : UInt16
    sin_addr : IN_ADDR
    sin_zero : CHAR[8]
}
struct SOCKADDR_DL {
    sdl_family : ADDRESS_FAMILY
    sdl_data : UInt8[8]
    sdl_zero : UInt8[4]
}
struct WSABUF {
    len : UInt32
    buf : PSTR
}
struct WSAMSG {
    name : SOCKADDR.Ptr
    namelen : Int32
    lpBuffers : WSABUF.Ptr
    dwBufferCount : UInt32
    Control : WSABUF
    dwFlags : UInt32
}
struct CMSGHDR {
    cmsg_len : IntPtr
    cmsg_level : Int32
    cmsg_type : Int32
}
struct ADDRINFOA {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PSTR
    ai_addr : SOCKADDR.Ptr
    ai_next : ADDRINFOA.Ptr
}
struct ADDRINFOW {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_next : ADDRINFOW.Ptr
}
struct ADDRINFOEXA {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEXA.Ptr
}
struct ADDRINFOEXW {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEXW.Ptr
}
struct ADDRINFOEX2A {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX2A.Ptr
    ai_version : Int32
    ai_fqdn : PSTR
}
struct ADDRINFOEX2W {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX2W.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
}
struct ADDRINFOEX3 {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX3.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
    ai_interfaceindex : Int32
}
struct ADDRINFOEX4 {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX4.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
    ai_interfaceindex : Int32
    ai_resolutionhandle : HANDLE
}
struct ADDRINFOEX5 {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX5.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
    ai_interfaceindex : Int32
    ai_resolutionhandle : HANDLE
    ai_ttl : UInt32
}
struct ADDRINFO_DNS_SERVER {
    ai_servertype : UInt32
    ai_flags : Int64
    ai_addrlen : UInt32
    ai_addr : SOCKADDR.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ai_template : PWSTR
            ai_hostname : PWSTR
        }
    }
}
struct ADDRINFOEX6 {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX5.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
    ai_interfaceindex : Int32
    ai_resolutionhandle : HANDLE
    ai_ttl : UInt32
    ai_numservers : UInt32
    ai_servers : ADDRINFO_DNS_SERVER.Ptr
    ai_responseflags : Int64
}
struct ADDRINFOEX7 {
    ai_flags : Int32
    ai_family : Int32
    ai_socktype : Int32
    ai_protocol : Int32
    ai_addrlen : IntPtr
    ai_canonname : PWSTR
    ai_addr : SOCKADDR.Ptr
    ai_blob : Struct.Ptr
    ai_bloblen : IntPtr
    ai_provider : GUID.Ptr
    ai_next : ADDRINFOEX7.Ptr
    ai_version : Int32
    ai_fqdn : PWSTR
    ai_interfaceindex : Int32
    ai_resolutionhandle : HANDLE
    ai_ttl : UInt32
    ai_numservers : UInt32
    ai_servers : ADDRINFO_DNS_SERVER.Ptr
    ai_responseflags : Int64
    ai_extraflags : Int64
}
struct FD_SET {
    fd_count : UInt32
    fd_array : SOCKET[64]
}
struct TIMEVAL {
    tv_sec : Int32
    tv_usec : Int32
}
struct HOSTENT {
    h_name : PSTR
    h_aliases : Int8.Ptr.Ptr
    h_addrtype : Int16
    h_length : Int16
    h_addr_list : Int8.Ptr.Ptr
}
struct netent {
    n_name : PSTR
    n_aliases : Int8.Ptr.Ptr
    n_addrtype : Int16
    n_net : UInt32
}
struct PROTOENT {
    p_name : PSTR
    p_aliases : Int8.Ptr.Ptr
    p_proto : Int16
}
struct sockproto {
    sp_family : UInt16
    sp_protocol : UInt16
}
struct LINGER {
    l_onoff : UInt16
    l_linger : UInt16
}
struct QOS {
    SendingFlowspec : FLOWSPEC
    ReceivingFlowspec : FLOWSPEC
    ProviderSpecific : WSABUF
}
struct WSANETWORKEVENTS {
    lNetworkEvents : Int32
    iErrorCode : Int32[10]
}
struct WSAPROTOCOLCHAIN {
    ChainLen : Int32
    ChainEntries : UInt32[7]
}
struct WSAPROTOCOL_INFOA {
    dwServiceFlags1 : UInt32
    dwServiceFlags2 : UInt32
    dwServiceFlags3 : UInt32
    dwServiceFlags4 : UInt32
    dwProviderFlags : UInt32
    ProviderId : GUID
    dwCatalogEntryId : UInt32
    ProtocolChain : WSAPROTOCOLCHAIN
    iVersion : Int32
    iAddressFamily : Int32
    iMaxSockAddr : Int32
    iMinSockAddr : Int32
    iSocketType : Int32
    iProtocol : Int32
    iProtocolMaxOffset : Int32
    iNetworkByteOrder : Int32
    iSecurityScheme : Int32
    dwMessageSize : UInt32
    dwProviderReserved : UInt32
    szProtocol : CHAR[256]
}
struct WSAPROTOCOL_INFOW {
    dwServiceFlags1 : UInt32
    dwServiceFlags2 : UInt32
    dwServiceFlags3 : UInt32
    dwServiceFlags4 : UInt32
    dwProviderFlags : UInt32
    ProviderId : GUID
    dwCatalogEntryId : UInt32
    ProtocolChain : WSAPROTOCOLCHAIN
    iVersion : Int32
    iAddressFamily : Int32
    iMaxSockAddr : Int32
    iMinSockAddr : Int32
    iSocketType : Int32
    iProtocol : Int32
    iProtocolMaxOffset : Int32
    iNetworkByteOrder : Int32
    iSecurityScheme : Int32
    dwMessageSize : UInt32
    dwProviderReserved : UInt32
    szProtocol : UInt16[256]
}
struct LPCONDITIONPROC extends FunctionPointer {
    static Types := [WSABUF.Ptr, WSABUF.Ptr, QOS.Ptr, QOS.Ptr, WSABUF.Ptr, WSABUF.Ptr, UInt32.Ptr, IntPtr, Int32]
}
struct LPWSAOVERLAPPED_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [UInt32, UInt32, OVERLAPPED.Ptr, UInt32, "Void"]
}
struct WSACOMPLETIONTYPE extends Int32 {
    static NSP_NOTIFY_IMMEDIATELY := 0
    static NSP_NOTIFY_HWND := 1
    static NSP_NOTIFY_EVENT := 2
    static NSP_NOTIFY_PORT := 3
    static NSP_NOTIFY_APC := 4
}
struct WSACOMPLETION {
    Type : WSACOMPLETIONTYPE
    Parameters : this._Parameters_e__Union
    struct _Parameters_e__Union {
        union {
            WindowMessage : this._WindowMessage_e__Struct
            Event : this._Event_e__Struct
            Apc : this._Apc_e__Struct
            Port : this._Port_e__Struct
        }
        struct _WindowMessage_e__Struct {
            hWnd : HWND
            uMsg : UInt32
            context : WPARAM
        }
        struct _Event_e__Struct {
            lpOverlapped : OVERLAPPED.Ptr
        }
        struct _Apc_e__Struct {
            lpOverlapped : OVERLAPPED.Ptr
            lpfnCompletionProc : LPWSAOVERLAPPED_COMPLETION_ROUTINE
        }
        struct _Port_e__Struct {
            lpOverlapped : OVERLAPPED.Ptr
            hPort : HANDLE
            Key : IntPtr
        }
    }
}
struct AFPROTOCOLS {
    iAddressFamily : Int32
    iProtocol : Int32
}
struct WSAECOMPARATOR extends Int32 {
    static COMP_EQUAL := 0
    static COMP_NOTLESS := 1
}
struct WSAVERSION {
    dwVersion : UInt32
    ecHow : WSAECOMPARATOR
}
struct WSAQUERYSETA {
    dwSize : UInt32
    lpszServiceInstanceName : PSTR
    lpServiceClassId : GUID.Ptr
    lpVersion : WSAVERSION.Ptr
    lpszComment : PSTR
    dwNameSpace : UInt32
    lpNSProviderId : GUID.Ptr
    lpszContext : PSTR
    dwNumberOfProtocols : UInt32
    lpafpProtocols : AFPROTOCOLS.Ptr
    lpszQueryString : PSTR
    dwNumberOfCsAddrs : UInt32
    lpcsaBuffer : CSADDR_INFO.Ptr
    dwOutputFlags : UInt32
    lpBlob : BLOB.Ptr
}
struct WSAQUERYSETW {
    dwSize : UInt32
    lpszServiceInstanceName : PWSTR
    lpServiceClassId : GUID.Ptr
    lpVersion : WSAVERSION.Ptr
    lpszComment : PWSTR
    dwNameSpace : UInt32
    lpNSProviderId : GUID.Ptr
    lpszContext : PWSTR
    dwNumberOfProtocols : UInt32
    lpafpProtocols : AFPROTOCOLS.Ptr
    lpszQueryString : PWSTR
    dwNumberOfCsAddrs : UInt32
    lpcsaBuffer : CSADDR_INFO.Ptr
    dwOutputFlags : UInt32
    lpBlob : BLOB.Ptr
}
struct WSAQUERYSET2A {
    dwSize : UInt32
    lpszServiceInstanceName : PSTR
    lpVersion : WSAVERSION.Ptr
    lpszComment : PSTR
    dwNameSpace : UInt32
    lpNSProviderId : GUID.Ptr
    lpszContext : PSTR
    dwNumberOfProtocols : UInt32
    lpafpProtocols : AFPROTOCOLS.Ptr
    lpszQueryString : PSTR
    dwNumberOfCsAddrs : UInt32
    lpcsaBuffer : CSADDR_INFO.Ptr
    dwOutputFlags : UInt32
    lpBlob : BLOB.Ptr
}
struct WSAQUERYSET2W {
    dwSize : UInt32
    lpszServiceInstanceName : PWSTR
    lpVersion : WSAVERSION.Ptr
    lpszComment : PWSTR
    dwNameSpace : UInt32
    lpNSProviderId : GUID.Ptr
    lpszContext : PWSTR
    dwNumberOfProtocols : UInt32
    lpafpProtocols : AFPROTOCOLS.Ptr
    lpszQueryString : PWSTR
    dwNumberOfCsAddrs : UInt32
    lpcsaBuffer : CSADDR_INFO.Ptr
    dwOutputFlags : UInt32
    lpBlob : BLOB.Ptr
}
struct WSAESETSERVICEOP extends Int32 {
    static RNRSERVICE_REGISTER := 0
    static RNRSERVICE_DEREGISTER := 1
    static RNRSERVICE_DELETE := 2
}
struct WSANSCLASSINFOA {
    lpszName : PSTR
    dwNameSpace : UInt32
    dwValueType : UInt32
    dwValueSize : UInt32
    lpValue : Struct.Ptr
}
struct WSANSCLASSINFOW {
    lpszName : PWSTR
    dwNameSpace : UInt32
    dwValueType : UInt32
    dwValueSize : UInt32
    lpValue : Struct.Ptr
}
struct WSASERVICECLASSINFOA {
    lpServiceClassId : GUID.Ptr
    lpszServiceClassName : PSTR
    dwCount : UInt32
    lpClassInfos : WSANSCLASSINFOA.Ptr
}
struct WSASERVICECLASSINFOW {
    lpServiceClassId : GUID.Ptr
    lpszServiceClassName : PWSTR
    dwCount : UInt32
    lpClassInfos : WSANSCLASSINFOW.Ptr
}
struct WSANAMESPACE_INFOA {
    NSProviderId : GUID
    dwNameSpace : UInt32
    fActive : BOOL
    dwVersion : UInt32
    lpszIdentifier : PSTR
}
struct WSANAMESPACE_INFOW {
    NSProviderId : GUID
    dwNameSpace : UInt32
    fActive : BOOL
    dwVersion : UInt32
    lpszIdentifier : PWSTR
}
struct WSANAMESPACE_INFOEXA {
    NSProviderId : GUID
    dwNameSpace : UInt32
    fActive : BOOL
    dwVersion : UInt32
    lpszIdentifier : PSTR
    ProviderSpecific : BLOB
}
struct WSANAMESPACE_INFOEXW {
    NSProviderId : GUID
    dwNameSpace : UInt32
    fActive : BOOL
    dwVersion : UInt32
    lpszIdentifier : PWSTR
    ProviderSpecific : BLOB
}
struct WSAPOLLFD {
    fd : SOCKET
    events : WSAPOLL_EVENT_FLAGS
    revents : WSAPOLL_EVENT_FLAGS
}
struct SOCK_NOTIFY_REGISTRATION {
    socket : SOCKET
    completionKey : Struct.Ptr
    eventFilter : UInt16
    operation : UInt8
    triggerFlags : UInt8
    registrationResult : UInt32
}
struct IN6_ADDR {
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            Byte : UInt8[16]
            Word : UInt16[8]
        }
    }
}
struct sockaddr_in6_old {
    sin6_family : Int16
    sin6_port : UInt16
    sin6_flowinfo : UInt32
    sin6_addr : IN6_ADDR
}
struct sockaddr_gen {
    union {
        Address : SOCKADDR
        AddressIn : SOCKADDR_IN
        AddressIn6 : sockaddr_in6_old
    }
}
struct INTERFACE_INFO {
    iiFlags : UInt32
    iiAddress : sockaddr_gen
    iiBroadcastAddress : sockaddr_gen
    iiNetmask : sockaddr_gen
}
struct INTERFACE_INFO_EX {
    iiFlags : UInt32
    iiAddress : SOCKET_ADDRESS
    iiBroadcastAddress : SOCKET_ADDRESS
    iiNetmask : SOCKET_ADDRESS
}
struct PMTUD_STATE extends Int32 {
    static IP_PMTUDISC_NOT_SET := 0
    static IP_PMTUDISC_DO := 1
    static IP_PMTUDISC_DONT := 2
    static IP_PMTUDISC_PROBE := 3
    static IP_PMTUDISC_MAX := 4
}
struct SOCKADDR_IN6 {
    sin6_family : ADDRESS_FAMILY
    sin6_port : UInt16
    sin6_flowinfo : UInt32
    sin6_addr : IN6_ADDR
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            sin6_scope_id : UInt32
            sin6_scope_struct : SCOPE_ID
        }
    }
}
struct SOCKADDR_IN6_W2KSP1 {
    sin6_family : Int16
    sin6_port : UInt16
    sin6_flowinfo : UInt32
    sin6_addr : IN6_ADDR
    sin6_scope_id : UInt32
}
struct SOCKADDR_INET {
    union {
        Ipv4 : SOCKADDR_IN
        Ipv6 : SOCKADDR_IN6
        si_family : ADDRESS_FAMILY
    }
}
struct SOCKADDR_IN6_PAIR {
    SourceAddress : SOCKADDR_IN6.Ptr
    DestinationAddress : SOCKADDR_IN6.Ptr
}
struct MULTICAST_MODE_TYPE extends Int32 {
    static MCAST_INCLUDE := 0
    static MCAST_EXCLUDE := 1
}
struct IP_MREQ {
    imr_multiaddr : IN_ADDR
    imr_interface : IN_ADDR
}
struct IP_MREQ_SOURCE {
    imr_multiaddr : IN_ADDR
    imr_sourceaddr : IN_ADDR
    imr_interface : IN_ADDR
}
struct IP_MSFILTER {
    imsf_multiaddr : IN_ADDR
    imsf_interface : IN_ADDR
    imsf_fmode : MULTICAST_MODE_TYPE
    imsf_numsrc : UInt32
    imsf_slist : IN_ADDR[1]
}
struct IPV6_MREQ {
    ipv6mr_multiaddr : IN6_ADDR
    ipv6mr_interface : UInt32
}
struct GROUP_REQ {
    gr_interface : UInt32
    gr_group : SOCKADDR_STORAGE
}
struct GROUP_SOURCE_REQ {
    gsr_interface : UInt32
    gsr_group : SOCKADDR_STORAGE
    gsr_source : SOCKADDR_STORAGE
}
struct GROUP_FILTER {
    gf_interface : UInt32
    gf_group : SOCKADDR_STORAGE
    gf_fmode : MULTICAST_MODE_TYPE
    gf_numsrc : UInt32
    gf_slist : SOCKADDR_STORAGE[1]
}
struct IN_PKTINFO {
    ipi_addr : IN_ADDR
    ipi_ifindex : UInt32
}
struct IN6_PKTINFO {
    ipi6_addr : IN6_ADDR
    ipi6_ifindex : UInt32
}
struct IN_PKTINFO_EX {
    pkt_info : IN_PKTINFO
    scope_id : SCOPE_ID
}
struct IN6_PKTINFO_EX {
    pkt_info : IN6_PKTINFO
    scope_id : SCOPE_ID
}
struct IN_RECVERR {
    protocol : IPPROTO
    info : UInt32
    type : UInt8
    code : UInt8
}
struct ICMP_ERROR_INFO {
    srcaddress : SOCKADDR_INET
    protocol : IPPROTO
    type : UInt8
    code : UInt8
}
struct eWINDOW_ADVANCE_METHOD extends Int32 {
    static E_WINDOW_ADVANCE_BY_TIME := 1
    static E_WINDOW_USE_AS_DATA_CACHE := 2
}
struct RM_SEND_WINDOW {
    RateKbitsPerSec : UInt32
    WindowSizeInMSecs : UInt32
    WindowSizeInBytes : UInt32
}
struct RM_SENDER_STATS {
    DataBytesSent : Int64
    TotalBytesSent : Int64
    NaksReceived : Int64
    NaksReceivedTooLate : Int64
    NumOutstandingNaks : Int64
    NumNaksAfterRData : Int64
    RepairPacketsSent : Int64
    BufferSpaceAvailable : Int64
    TrailingEdgeSeqId : Int64
    LeadingEdgeSeqId : Int64
    RateKBitsPerSecOverall : Int64
    RateKBitsPerSecLast : Int64
    TotalODataPacketsSent : Int64
}
struct RM_RECEIVER_STATS {
    NumODataPacketsReceived : Int64
    NumRDataPacketsReceived : Int64
    NumDuplicateDataPackets : Int64
    DataBytesReceived : Int64
    TotalBytesReceived : Int64
    RateKBitsPerSecOverall : Int64
    RateKBitsPerSecLast : Int64
    TrailingEdgeSeqId : Int64
    LeadingEdgeSeqId : Int64
    AverageSequencesInWindow : Int64
    MinSequencesInWindow : Int64
    MaxSequencesInWindow : Int64
    FirstNakSequenceNumber : Int64
    NumPendingNaks : Int64
    NumOutstandingNaks : Int64
    NumDataPacketsBuffered : Int64
    TotalSelectiveNaksSent : Int64
    TotalParityNaksSent : Int64
}
struct RM_FEC_INFO {
    FECBlockSize : UInt16
    FECProActivePackets : UInt16
    FECGroupSize : UInt8
    fFECOnDemandParityEnabled : BOOLEAN
}
struct IPX_ADDRESS_DATA {
    adapternum : Int32
    netnum : UInt8[4]
    nodenum : UInt8[6]
    wan : BOOLEAN
    status : BOOLEAN
    maxpkt : Int32
    linkspeed : UInt32
}
struct IPX_NETNUM_DATA {
    netnum : UInt8[4]
    hopcount : UInt16
    netdelay : UInt16
    cardnum : Int32
    router : UInt8[6]
}
struct IPX_SPXCONNSTATUS_DATA {
    ConnectionState : UInt8
    WatchDogActive : UInt8
    LocalConnectionId : UInt16
    RemoteConnectionId : UInt16
    LocalSequenceNumber : UInt16
    LocalAckNumber : UInt16
    LocalAllocNumber : UInt16
    RemoteAckNumber : UInt16
    RemoteAllocNumber : UInt16
    LocalSocket : UInt16
    ImmediateAddress : UInt8[6]
    RemoteNetwork : UInt8[4]
    RemoteNode : UInt8[6]
    RemoteSocket : UInt16
    RetransmissionCount : UInt16
    EstimatedRoundTripDelay : UInt16
    RetransmittedPackets : UInt16
    SuppressedPacket : UInt16
}
struct LM_IRPARMS {
    nTXDataBytes : UInt32
    nRXDataBytes : UInt32
    nBaudRate : UInt32
    thresholdTime : UInt32
    discTime : UInt32
    nMSLinkTurn : UInt16
    nTXPackets : UInt8
    nRXPackets : UInt8
}
struct SOCKADDR_IRDA {
    irdaAddressFamily : UInt16
    irdaDeviceID : UInt8[4]
    irdaServiceName : CHAR[25]
}
struct WINDOWS_IRDA_DEVICE_INFO {
    irdaDeviceID : UInt8[4]
    irdaDeviceName : CHAR[22]
    irdaDeviceHints1 : UInt8
    irdaDeviceHints2 : UInt8
    irdaCharSet : UInt8
}
struct WCE_IRDA_DEVICE_INFO {
    irdaDeviceID : UInt8[4]
    irdaDeviceName : CHAR[22]
    Reserved : UInt8[2]
}
struct WINDOWS_DEVICELIST {
    numDevice : UInt32
    Device : WINDOWS_IRDA_DEVICE_INFO[1]
}
struct WCE_DEVICELIST {
    numDevice : UInt32
    Device : WCE_IRDA_DEVICE_INFO[1]
}
struct WINDOWS_IAS_SET {
    irdaClassName : CHAR[64]
    irdaAttribName : CHAR[256]
    irdaAttribType : UInt32
    irdaAttribute : this._irdaAttribute_e__Union
    struct _irdaAttribute_e__Union {
        union {
            irdaAttribInt : Int32
            irdaAttribOctetSeq : this._irdaAttribOctetSeq_e__Struct
            irdaAttribUsrStr : this._irdaAttribUsrStr_e__Struct
        }
        struct _irdaAttribOctetSeq_e__Struct {
            Len : UInt16
            OctetSeq : UInt8[1024]
        }
        struct _irdaAttribUsrStr_e__Struct {
            Len : UInt8
            CharSet : UInt8
            UsrStr : UInt8[256]
        }
    }
}
struct WINDOWS_IAS_QUERY {
    irdaDeviceID : UInt8[4]
    irdaClassName : CHAR[64]
    irdaAttribName : CHAR[256]
    irdaAttribType : UInt32
    irdaAttribute : this._irdaAttribute_e__Union
    struct _irdaAttribute_e__Union {
        union {
            irdaAttribInt : Int32
            irdaAttribOctetSeq : this._irdaAttribOctetSeq_e__Struct
            irdaAttribUsrStr : this._irdaAttribUsrStr_e__Struct
        }
        struct _irdaAttribOctetSeq_e__Struct {
            Len : UInt32
            OctetSeq : UInt8[1024]
        }
        struct _irdaAttribUsrStr_e__Struct {
            Len : UInt32
            CharSet : UInt32
            UsrStr : UInt8[256]
        }
    }
}
struct NL_PREFIX_ORIGIN extends Int32 {
    static IpPrefixOriginOther := 0
    static IpPrefixOriginManual := 1
    static IpPrefixOriginWellKnown := 2
    static IpPrefixOriginDhcp := 3
    static IpPrefixOriginRouterAdvertisement := 4
    static IpPrefixOriginUnchanged := 16
}
struct NL_SUFFIX_ORIGIN extends Int32 {
    static NlsoOther := 0
    static NlsoManual := 1
    static NlsoWellKnown := 2
    static NlsoDhcp := 3
    static NlsoLinkLayerAddress := 4
    static NlsoRandom := 5
    static IpSuffixOriginOther := 0
    static IpSuffixOriginManual := 1
    static IpSuffixOriginWellKnown := 2
    static IpSuffixOriginDhcp := 3
    static IpSuffixOriginLinkLayerAddress := 4
    static IpSuffixOriginRandom := 5
    static IpSuffixOriginUnchanged := 16
}
struct NL_DAD_STATE extends Int32 {
    static NldsInvalid := 0
    static NldsTentative := 1
    static NldsDuplicate := 2
    static NldsDeprecated := 3
    static NldsPreferred := 4
    static IpDadStateInvalid := 0
    static IpDadStateTentative := 1
    static IpDadStateDuplicate := 2
    static IpDadStateDeprecated := 3
    static IpDadStatePreferred := 4
}
struct NL_ROUTE_PROTOCOL extends Int32 {
    static RouteProtocolOther := 1
    static RouteProtocolLocal := 2
    static RouteProtocolNetMgmt := 3
    static RouteProtocolIcmp := 4
    static RouteProtocolEgp := 5
    static RouteProtocolGgp := 6
    static RouteProtocolHello := 7
    static RouteProtocolRip := 8
    static RouteProtocolIsIs := 9
    static RouteProtocolEsIs := 10
    static RouteProtocolCisco := 11
    static RouteProtocolBbn := 12
    static RouteProtocolOspf := 13
    static RouteProtocolBgp := 14
    static RouteProtocolIdpr := 15
    static RouteProtocolEigrp := 16
    static RouteProtocolDvmrp := 17
    static RouteProtocolRpl := 18
    static RouteProtocolDhcp := 19
    static MIB_IPPROTO_OTHER := 1
    static PROTO_IP_OTHER := 1
    static MIB_IPPROTO_LOCAL := 2
    static PROTO_IP_LOCAL := 2
    static MIB_IPPROTO_NETMGMT := 3
    static PROTO_IP_NETMGMT := 3
    static MIB_IPPROTO_ICMP := 4
    static PROTO_IP_ICMP := 4
    static MIB_IPPROTO_EGP := 5
    static PROTO_IP_EGP := 5
    static MIB_IPPROTO_GGP := 6
    static PROTO_IP_GGP := 6
    static MIB_IPPROTO_HELLO := 7
    static PROTO_IP_HELLO := 7
    static MIB_IPPROTO_RIP := 8
    static PROTO_IP_RIP := 8
    static MIB_IPPROTO_IS_IS := 9
    static PROTO_IP_IS_IS := 9
    static MIB_IPPROTO_ES_IS := 10
    static PROTO_IP_ES_IS := 10
    static MIB_IPPROTO_CISCO := 11
    static PROTO_IP_CISCO := 11
    static MIB_IPPROTO_BBN := 12
    static PROTO_IP_BBN := 12
    static MIB_IPPROTO_OSPF := 13
    static PROTO_IP_OSPF := 13
    static MIB_IPPROTO_BGP := 14
    static PROTO_IP_BGP := 14
    static MIB_IPPROTO_IDPR := 15
    static PROTO_IP_IDPR := 15
    static MIB_IPPROTO_EIGRP := 16
    static PROTO_IP_EIGRP := 16
    static MIB_IPPROTO_DVMRP := 17
    static PROTO_IP_DVMRP := 17
    static MIB_IPPROTO_RPL := 18
    static PROTO_IP_RPL := 18
    static MIB_IPPROTO_DHCP := 19
    static PROTO_IP_DHCP := 19
    static MIB_IPPROTO_NT_AUTOSTATIC := 10002
    static PROTO_IP_NT_AUTOSTATIC := 10002
    static MIB_IPPROTO_NT_STATIC := 10006
    static PROTO_IP_NT_STATIC := 10006
    static MIB_IPPROTO_NT_STATIC_NON_DOD := 10007
    static PROTO_IP_NT_STATIC_NON_DOD := 10007
}
struct NL_ADDRESS_TYPE extends Int32 {
    static NlatUnspecified := 0
    static NlatUnicast := 1
    static NlatAnycast := 2
    static NlatMulticast := 3
    static NlatBroadcast := 4
    static NlatInvalid := 5
}
struct NL_ROUTE_ORIGIN extends Int32 {
    static NlroManual := 0
    static NlroWellKnown := 1
    static NlroDHCP := 2
    static NlroRouterAdvertisement := 3
    static Nlro6to4 := 4
}
struct NL_NEIGHBOR_STATE extends Int32 {
    static NlnsUnreachable := 0
    static NlnsIncomplete := 1
    static NlnsProbe := 2
    static NlnsDelay := 3
    static NlnsStale := 4
    static NlnsReachable := 5
    static NlnsPermanent := 6
    static NlnsMaximum := 7
}
struct NL_LINK_LOCAL_ADDRESS_BEHAVIOR extends Int32 {
    static LinkLocalAlwaysOff := 0
    static LinkLocalDelayed := 1
    static LinkLocalAlwaysOn := 2
    static LinkLocalUnchanged := -1
}
struct NL_INTERFACE_OFFLOAD_ROD {
    _bitfield : UInt8
}
struct NL_ROUTER_DISCOVERY_BEHAVIOR extends Int32 {
    static RouterDiscoveryDisabled := 0
    static RouterDiscoveryEnabled := 1
    static RouterDiscoveryDhcp := 2
    static RouterDiscoveryUnchanged := -1
}
struct NL_BANDWIDTH_FLAG extends Int32 {
    static NlbwDisabled := 0
    static NlbwEnabled := 1
    static NlbwUnchanged := -1
}
struct NL_PATH_BANDWIDTH_ROD {
    Bandwidth : Int64
    Instability : Int64
    BandwidthPeaked : BOOLEAN
}
struct NL_NETWORK_CATEGORY extends Int32 {
    static NetworkCategoryPublic := 0
    static NetworkCategoryPrivate := 1
    static NetworkCategoryDomainAuthenticated := 2
    static NetworkCategoryUnchanged := -1
    static NetworkCategoryUnknown := -1
}
struct NL_INTERFACE_NETWORK_CATEGORY_STATE extends Int32 {
    static NlincCategoryUnknown := 0
    static NlincPublic := 1
    static NlincPrivate := 2
    static NlincDomainAuthenticated := 3
    static NlincCategoryStateMax := 4
}
struct NL_NETWORK_CONNECTIVITY_LEVEL_HINT extends Int32 {
    static NetworkConnectivityLevelHintUnknown := 0
    static NetworkConnectivityLevelHintNone := 1
    static NetworkConnectivityLevelHintLocalAccess := 2
    static NetworkConnectivityLevelHintInternetAccess := 3
    static NetworkConnectivityLevelHintConstrainedInternetAccess := 4
    static NetworkConnectivityLevelHintHidden := 5
}
struct NL_NETWORK_CONNECTIVITY_COST_HINT extends Int32 {
    static NetworkConnectivityCostHintUnknown := 0
    static NetworkConnectivityCostHintUnrestricted := 1
    static NetworkConnectivityCostHintFixed := 2
    static NetworkConnectivityCostHintVariable := 3
}
struct NL_NETWORK_CONNECTIVITY_HINT {
    ConnectivityLevel : NL_NETWORK_CONNECTIVITY_LEVEL_HINT
    ConnectivityCost : NL_NETWORK_CONNECTIVITY_COST_HINT
    ApproachingDataLimit : BOOLEAN
    OverDataLimit : BOOLEAN
    Roaming : BOOLEAN
}
struct NL_BANDWIDTH_INFORMATION {
    Bandwidth : Int64
    Instability : Int64
    BandwidthPeaked : BOOLEAN
}
struct TCPSTATE extends Int32 {
    static TCPSTATE_CLOSED := 0
    static TCPSTATE_LISTEN := 1
    static TCPSTATE_SYN_SENT := 2
    static TCPSTATE_SYN_RCVD := 3
    static TCPSTATE_ESTABLISHED := 4
    static TCPSTATE_FIN_WAIT_1 := 5
    static TCPSTATE_FIN_WAIT_2 := 6
    static TCPSTATE_CLOSE_WAIT := 7
    static TCPSTATE_CLOSING := 8
    static TCPSTATE_LAST_ACK := 9
    static TCPSTATE_TIME_WAIT := 10
    static TCPSTATE_MAX := 11
}
struct TRANSPORT_SETTING_ID {
    Guid : GUID
}
struct tcp_keepalive {
    onoff : UInt32
    keepalivetime : UInt32
    keepaliveinterval : UInt32
}
struct CONTROL_CHANNEL_TRIGGER_STATUS extends Int32 {
    static CONTROL_CHANNEL_TRIGGER_STATUS_INVALID := 0
    static CONTROL_CHANNEL_TRIGGER_STATUS_SOFTWARE_SLOT_ALLOCATED := 1
    static CONTROL_CHANNEL_TRIGGER_STATUS_HARDWARE_SLOT_ALLOCATED := 2
    static CONTROL_CHANNEL_TRIGGER_STATUS_POLICY_ERROR := 3
    static CONTROL_CHANNEL_TRIGGER_STATUS_SYSTEM_ERROR := 4
    static CONTROL_CHANNEL_TRIGGER_STATUS_TRANSPORT_DISCONNECTED := 5
    static CONTROL_CHANNEL_TRIGGER_STATUS_SERVICE_UNAVAILABLE := 6
}
struct REAL_TIME_NOTIFICATION_SETTING_INPUT {
    TransportSettingId : TRANSPORT_SETTING_ID
    BrokerEventGuid : GUID
}
struct REAL_TIME_NOTIFICATION_SETTING_INPUT_EX {
    TransportSettingId : TRANSPORT_SETTING_ID
    BrokerEventGuid : GUID
    Unmark : BOOLEAN
}
struct REAL_TIME_NOTIFICATION_SETTING_OUTPUT {
    ChannelStatus : CONTROL_CHANNEL_TRIGGER_STATUS
}
struct ASSOCIATE_NAMERES_CONTEXT_INPUT {
    TransportSettingId : TRANSPORT_SETTING_ID
    Handle : Int64
}
struct TIMESTAMPING_CONFIG {
    Flags : UInt32
    TxTimestampsBuffered : UInt16
}
struct SOCKET_PRIORITY_HINT extends Int32 {
    static SocketPriorityHintVeryLow := 0
    static SocketPriorityHintLow := 1
    static SocketPriorityHintNormal := 2
    static SocketMaximumPriorityHintType := 3
}
struct PRIORITY_STATUS {
    Sender : SOCKET_PRIORITY_HINT
    Receiver : SOCKET_PRIORITY_HINT
}
struct RCVALL_VALUE extends Int32 {
    static RCVALL_OFF := 0
    static RCVALL_ON := 1
    static RCVALL_SOCKETLEVELONLY := 2
    static RCVALL_IPLEVEL := 3
}
struct RCVALL_IF {
    Mode : RCVALL_VALUE
    Interface : UInt32
}
struct TCP_INITIAL_RTO_PARAMETERS {
    Rtt : UInt16
    MaxSynRetransmissions : UInt8
}
struct TCP_ICW_LEVEL extends Int32 {
    static TCP_ICW_LEVEL_DEFAULT := 0
    static TCP_ICW_LEVEL_HIGH := 1
    static TCP_ICW_LEVEL_VERY_HIGH := 2
    static TCP_ICW_LEVEL_AGGRESSIVE := 3
    static TCP_ICW_LEVEL_EXPERIMENTAL := 4
    static TCP_ICW_LEVEL_COMPAT := 254
    static TCP_ICW_LEVEL_MAX := 255
}
struct TCP_ICW_PARAMETERS {
    Level : TCP_ICW_LEVEL
}
struct TCP_ACK_FREQUENCY_PARAMETERS {
    TcpDelayedAckFrequency : UInt8
}
struct TCP_INFO_v0 {
    State : TCPSTATE
    Mss : UInt32
    ConnectionTimeMs : Int64
    TimestampsEnabled : BOOLEAN
    RttUs : UInt32
    MinRttUs : UInt32
    BytesInFlight : UInt32
    Cwnd : UInt32
    SndWnd : UInt32
    RcvWnd : UInt32
    RcvBuf : UInt32
    BytesOut : Int64
    BytesIn : Int64
    BytesReordered : UInt32
    BytesRetrans : UInt32
    FastRetrans : UInt32
    DupAcksIn : UInt32
    TimeoutEpisodes : UInt32
    SynRetrans : UInt8
}
struct TCP_INFO_v1 {
    State : TCPSTATE
    Mss : UInt32
    ConnectionTimeMs : Int64
    TimestampsEnabled : BOOLEAN
    RttUs : UInt32
    MinRttUs : UInt32
    BytesInFlight : UInt32
    Cwnd : UInt32
    SndWnd : UInt32
    RcvWnd : UInt32
    RcvBuf : UInt32
    BytesOut : Int64
    BytesIn : Int64
    BytesReordered : UInt32
    BytesRetrans : UInt32
    FastRetrans : UInt32
    DupAcksIn : UInt32
    TimeoutEpisodes : UInt32
    SynRetrans : UInt8
    SndLimTransRwin : UInt32
    SndLimTimeRwin : UInt32
    SndLimBytesRwin : Int64
    SndLimTransCwnd : UInt32
    SndLimTimeCwnd : UInt32
    SndLimBytesCwnd : Int64
    SndLimTransSnd : UInt32
    SndLimTimeSnd : UInt32
    SndLimBytesSnd : Int64
}
struct TCP_INFO_v2 {
    State : TCPSTATE
    Mss : UInt32
    ConnectionTimeMs : Int64
    TimestampsEnabled : BOOLEAN
    RttUs : UInt32
    MinRttUs : UInt32
    BytesInFlight : UInt32
    Cwnd : UInt32
    SndWnd : UInt32
    RcvWnd : UInt32
    RcvBuf : UInt32
    BytesOut : Int64
    BytesIn : Int64
    BytesReordered : UInt32
    BytesRetrans : UInt32
    FastRetrans : UInt32
    DupAcksIn : UInt32
    TimeoutEpisodes : UInt32
    SynRetrans : UInt8
    SndLimTransRwin : UInt32
    SndLimTimeRwin : UInt32
    SndLimBytesRwin : Int64
    SndLimTransCwnd : UInt32
    SndLimTimeCwnd : UInt32
    SndLimBytesCwnd : Int64
    SndLimTransSnd : UInt32
    SndLimTimeSnd : UInt32
    SndLimBytesSnd : Int64
    OutOfOrderPktsIn : UInt32
    EcnNegotiated : BOOLEAN
    EceAcksIn : UInt32
    PtoEpisodes : UInt32
}
struct INET_PORT_RANGE {
    StartPort : UInt16
    NumberOfPorts : UInt16
}
struct INET_PORT_RESERVATION_TOKEN {
    Token : Int64
}
struct INET_PORT_RESERVATION_INSTANCE {
    Reservation : INET_PORT_RANGE
    Token : INET_PORT_RESERVATION_TOKEN
}
struct INET_PORT_RESERVATION_INFORMATION {
    OwningPid : UInt32
}
struct SOCKET_USAGE_TYPE extends Int32 {
    static SYSTEM_CRITICAL_SOCKET := 1
}
struct SOCKET_SECURITY_PROTOCOL extends Int32 {
    static SOCKET_SECURITY_PROTOCOL_DEFAULT := 0
    static SOCKET_SECURITY_PROTOCOL_IPSEC := 1
    static SOCKET_SECURITY_PROTOCOL_IPSEC2 := 2
    static SOCKET_SECURITY_PROTOCOL_INVALID := 3
}
struct SOCKET_SECURITY_SETTINGS {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    SecurityFlags : UInt32
}
struct SOCKET_SECURITY_SETTINGS_IPSEC {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    SecurityFlags : UInt32
    IpsecFlags : UInt32
    AuthipMMPolicyKey : GUID
    AuthipQMPolicyKey : GUID
    Reserved : GUID
    Reserved2 : Int64
    UserNameStringLen : UInt32
    DomainNameStringLen : UInt32
    PasswordStringLen : UInt32
    AllStrings : UInt16[1]
}
struct SOCKET_PEER_TARGET_NAME {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    PeerAddress : SOCKADDR_STORAGE
    PeerTargetNameStringLen : UInt32
    AllStrings : UInt16[1]
}
struct SOCKET_SECURITY_QUERY_TEMPLATE {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    PeerAddress : SOCKADDR_STORAGE
    PeerTokenAccessMask : UInt32
}
struct SOCKET_SECURITY_QUERY_TEMPLATE_IPSEC2 {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    PeerAddress : SOCKADDR_STORAGE
    PeerTokenAccessMask : UInt32
    Flags : UInt32
    FieldMask : UInt32
}
struct SOCKET_SECURITY_QUERY_INFO {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    Flags : UInt32
    PeerApplicationAccessTokenHandle : Int64
    PeerMachineAccessTokenHandle : Int64
}
struct SOCKET_SECURITY_QUERY_INFO_IPSEC2 {
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL
    Flags : UInt32
    PeerApplicationAccessTokenHandle : Int64
    PeerMachineAccessTokenHandle : Int64
    MmSaId : Int64
    QmSaId : Int64
    NegotiationWinerr : UInt32
    SaLookupContext : GUID
}
struct RSS_SCALABILITY_INFO {
    RssEnabled : BOOLEAN
}
struct WSA_COMPATIBILITY_BEHAVIOR_ID extends Int32 {
    static WsaBehaviorAll := 0
    static WsaBehaviorReceiveBuffering := 1
    static WsaBehaviorAutoTuning := 2
}
struct WSA_COMPATIBILITY_MODE {
    BehaviorId : WSA_COMPATIBILITY_BEHAVIOR_ID
    TargetOsVersion : UInt32
}
struct RIORESULT {
    Status : Int32
    BytesTransferred : UInt32
    SocketContext : Int64
    RequestContext : Int64
}
struct RIO_BUF {
    BufferId : RIO_BUFFERID
    Offset : UInt32
    Length : UInt32
}
struct RIO_CMSG_BUFFER {
    TotalLength : UInt32
}
struct ATM_ADDRESS {
    AddressType : UInt32
    NumofDigits : UInt32
    Addr : UInt8[20]
}
struct ATM_BLLI {
    Layer2Protocol : UInt32
    Layer2UserSpecifiedProtocol : UInt32
    Layer3Protocol : UInt32
    Layer3UserSpecifiedProtocol : UInt32
    Layer3IPI : UInt32
    SnapID : UInt8[5]
}
struct ATM_BHLI {
    HighLayerInfoType : UInt32
    HighLayerInfoLength : UInt32
    HighLayerInfo : UInt8[8]
}
struct SOCKADDR_ATM {
    satm_family : UInt16
    satm_number : ATM_ADDRESS
    satm_blli : ATM_BLLI
    satm_bhli : ATM_BHLI
}
struct Q2931_IE_TYPE extends Int32 {
    static IE_AALParameters := 0
    static IE_TrafficDescriptor := 1
    static IE_BroadbandBearerCapability := 2
    static IE_BHLI := 3
    static IE_BLLI := 4
    static IE_CalledPartyNumber := 5
    static IE_CalledPartySubaddress := 6
    static IE_CallingPartyNumber := 7
    static IE_CallingPartySubaddress := 8
    static IE_Cause := 9
    static IE_QOSClass := 10
    static IE_TransitNetworkSelection := 11
}
struct Q2931_IE {
    IEType : Q2931_IE_TYPE
    IELength : UInt32
    IE : UInt8[1]
}
struct AAL_TYPE extends Int32 {
    static AALTYPE_5 := 5
    static AALTYPE_USER := 16
}
struct AAL5_PARAMETERS {
    ForwardMaxCPCSSDUSize : UInt32
    BackwardMaxCPCSSDUSize : UInt32
    Mode : UInt8
    SSCSType : UInt8
}
struct AALUSER_PARAMETERS {
    UserDefined : UInt32
}
struct AAL_PARAMETERS_IE {
    AALType : AAL_TYPE
    AALSpecificParameters : this._AALSpecificParameters_e__Union
    struct _AALSpecificParameters_e__Union {
        union {
            AAL5Parameters : AAL5_PARAMETERS
            AALUserParameters : AALUSER_PARAMETERS
        }
    }
}
struct ATM_TD {
    PeakCellRate_CLP0 : UInt32
    PeakCellRate_CLP01 : UInt32
    SustainableCellRate_CLP0 : UInt32
    SustainableCellRate_CLP01 : UInt32
    MaxBurstSize_CLP0 : UInt32
    MaxBurstSize_CLP01 : UInt32
    Tagging : BOOL
}
struct ATM_TRAFFIC_DESCRIPTOR_IE {
    Forward : ATM_TD
    Backward : ATM_TD
    BestEffort : BOOL
}
struct ATM_BROADBAND_BEARER_CAPABILITY_IE {
    BearerClass : UInt8
    TrafficType : UInt8
    TimingRequirements : UInt8
    ClippingSusceptability : UInt8
    UserPlaneConnectionConfig : UInt8
}
struct ATM_BLLI_IE {
    Layer2Protocol : UInt32
    Layer2Mode : UInt8
    Layer2WindowSize : UInt8
    Layer2UserSpecifiedProtocol : UInt32
    Layer3Protocol : UInt32
    Layer3Mode : UInt8
    Layer3DefaultPacketSize : UInt8
    Layer3PacketWindowSize : UInt8
    Layer3UserSpecifiedProtocol : UInt32
    Layer3IPI : UInt32
    SnapID : UInt8[5]
}
struct ATM_CALLING_PARTY_NUMBER_IE {
    ATM_Number : ATM_ADDRESS
    Presentation_Indication : UInt8
    Screening_Indicator : UInt8
}
struct ATM_CAUSE_IE {
    Location : UInt8
    Cause : UInt8
    DiagnosticsLength : UInt8
    Diagnostics : UInt8[4]
}
struct ATM_QOS_CLASS_IE {
    QOSClassForward : UInt8
    QOSClassBackward : UInt8
}
struct ATM_TRANSIT_NETWORK_SELECTION_IE {
    TypeOfNetworkId : UInt8
    NetworkIdPlan : UInt8
    NetworkIdLength : UInt8
    NetworkId : UInt8[1]
}
struct ATM_CONNECTION_ID {
    DeviceNumber : UInt32
    VPI : UInt32
    VCI : UInt32
}
struct ATM_PVC_PARAMS {
    PvcConnectionId : ATM_CONNECTION_ID
    PvcQos : QOS
}
struct NAPI_PROVIDER_TYPE extends Int32 {
    static ProviderType_Application := 1
    static ProviderType_Service := 2
}
struct NAPI_PROVIDER_LEVEL extends Int32 {
    static ProviderLevel_None := 0
    static ProviderLevel_Secondary := 1
    static ProviderLevel_Primary := 2
}
struct NAPI_DOMAIN_DESCRIPTION_BLOB {
    AuthLevel : UInt32
    cchDomainName : UInt32
    OffsetNextDomainDescription : UInt32
    OffsetThisDomainName : UInt32
}
struct NAPI_PROVIDER_INSTALLATION_BLOB {
    dwVersion : UInt32
    dwProviderType : UInt32
    fSupportsWildCard : UInt32
    cDomains : UInt32
    OffsetFirstDomain : UInt32
}
struct TRANSMIT_FILE_BUFFERS {
    Head : Struct.Ptr
    HeadLength : UInt32
    Tail : Struct.Ptr
    TailLength : UInt32
}
struct LPFN_TRANSMITFILE extends FunctionPointer {
    static Types := [SOCKET, HANDLE, UInt32, UInt32, OVERLAPPED.Ptr, TRANSMIT_FILE_BUFFERS.Ptr, UInt32, BOOL]
}
struct LPFN_ACCEPTEX extends FunctionPointer {
    static Types := [SOCKET, SOCKET, Struct.Ptr, UInt32, UInt32, UInt32, UInt32.Ptr, OVERLAPPED.Ptr, BOOL]
}
struct LPFN_GETACCEPTEXSOCKADDRS extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, UInt32, SOCKADDR.Ptr.Ptr, Int32.Ptr, SOCKADDR.Ptr.Ptr, Int32.Ptr, "Void"]
}
struct TRANSMIT_PACKETS_ELEMENT {
    dwElFlags : UInt32
    cLength : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            pBuffer : Struct.Ptr
        }
        struct _Anonymous_e__Struct {
            nFileOffset : Int64
            hFile : HANDLE
        }
    }
}
struct LPFN_TRANSMITPACKETS extends FunctionPointer {
    static Types := [SOCKET, TRANSMIT_PACKETS_ELEMENT.Ptr, UInt32, UInt32, OVERLAPPED.Ptr, UInt32, BOOL]
}
struct LPFN_CONNECTEX extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32, Struct.Ptr, UInt32, UInt32.Ptr, OVERLAPPED.Ptr, BOOL]
}
struct LPFN_DISCONNECTEX extends FunctionPointer {
    static Types := [SOCKET, OVERLAPPED.Ptr, UInt32, UInt32, BOOL]
}
struct NLA_BLOB_DATA_TYPE extends Int32 {
    static NLA_RAW_DATA := 0
    static NLA_INTERFACE := 1
    static NLA_802_1X_LOCATION := 2
    static NLA_CONNECTIVITY := 3
    static NLA_ICS := 4
}
struct NLA_CONNECTIVITY_TYPE extends Int32 {
    static NLA_NETWORK_AD_HOC := 0
    static NLA_NETWORK_MANAGED := 1
    static NLA_NETWORK_UNMANAGED := 2
    static NLA_NETWORK_UNKNOWN := 3
}
struct NLA_INTERNET extends Int32 {
    static NLA_INTERNET_UNKNOWN := 0
    static NLA_INTERNET_NO := 1
    static NLA_INTERNET_YES := 2
}
struct NLA_BLOB {
    header : this._header_e__Struct
    data : this._data_e__Union
    struct _header_e__Struct {
        type : NLA_BLOB_DATA_TYPE
        dwSize : UInt32
        nextOffset : UInt32
    }
    struct _data_e__Union {
        union {
            rawData : CHAR[1]
            interfaceData : this._interfaceData_e__Struct
            locationData : this._locationData_e__Struct
            connectivity : this._connectivity_e__Struct
            ICS : this._ICS_e__Struct
        }
        struct _interfaceData_e__Struct {
            dwType : UInt32
            dwSpeed : UInt32
            adapterName : CHAR[1]
        }
        struct _locationData_e__Struct {
            information : CHAR[1]
        }
        struct _connectivity_e__Struct {
            type : NLA_CONNECTIVITY_TYPE
            internet : NLA_INTERNET
        }
        struct _ICS_e__Struct {
            remote : this._remote_e__Struct
            struct _remote_e__Struct {
                speed : UInt32
                type : UInt32
                state : UInt32
                machineName : UInt16[256]
                sharedAdapterName : UInt16[256]
            }
        }
    }
}
struct LPFN_WSARECVMSG extends FunctionPointer {
    static Types := [SOCKET, WSAMSG.Ptr, UInt32.Ptr, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, Int32]
}
struct WSAPOLLDATA {
    result : Int32
    fds : UInt32
    timeout : Int32
    fdArray : WSAPOLLFD[1]
}
struct WSASENDMSG {
    lpMsg : WSAMSG.Ptr
    dwFlags : UInt32
    lpNumberOfBytesSent : UInt32.Ptr
    lpOverlapped : OVERLAPPED.Ptr
    lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE
}
struct LPFN_WSASENDMSG extends FunctionPointer {
    static Types := [SOCKET, WSAMSG.Ptr, UInt32, UInt32.Ptr, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, Int32]
}
struct LPFN_WSAPOLL extends FunctionPointer {
    static Types := [WSAPOLLFD.Ptr, UInt32, Int32, Int32]
}
struct LPFN_RIORECEIVE extends FunctionPointer {
    static Types := [RIO_RQ, RIO_BUF.Ptr, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct LPFN_RIORECEIVEEX extends FunctionPointer {
    static Types := [RIO_RQ, RIO_BUF.Ptr, UInt32, RIO_BUF.Ptr, RIO_BUF.Ptr, RIO_BUF.Ptr, RIO_BUF.Ptr, UInt32, Struct.Ptr, Int32]
}
struct LPFN_RIOSEND extends FunctionPointer {
    static Types := [RIO_RQ, RIO_BUF.Ptr, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct LPFN_RIOSENDEX extends FunctionPointer {
    static Types := [RIO_RQ, RIO_BUF.Ptr, UInt32, RIO_BUF.Ptr, RIO_BUF.Ptr, RIO_BUF.Ptr, RIO_BUF.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct LPFN_RIOCLOSECOMPLETIONQUEUE extends FunctionPointer {
    static Types := [RIO_CQ, "Void"]
}
struct RIO_NOTIFICATION_COMPLETION_TYPE extends Int32 {
    static RIO_EVENT_COMPLETION := 1
    static RIO_IOCP_COMPLETION := 2
}
struct RIO_NOTIFICATION_COMPLETION {
    Type : RIO_NOTIFICATION_COMPLETION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Event : this._Event_e__Struct
            Iocp : this._Iocp_e__Struct
        }
        struct _Event_e__Struct {
            EventHandle : HANDLE
            NotifyReset : BOOL
        }
        struct _Iocp_e__Struct {
            IocpHandle : HANDLE
            CompletionKey : Struct.Ptr
            Overlapped : Struct.Ptr
        }
    }
}
struct LPFN_RIOCREATECOMPLETIONQUEUE extends FunctionPointer {
    static Types := [UInt32, RIO_NOTIFICATION_COMPLETION.Ptr, RIO_CQ]
}
struct LPFN_RIOCREATEREQUESTQUEUE extends FunctionPointer {
    static Types := [SOCKET, UInt32, UInt32, UInt32, UInt32, RIO_CQ, RIO_CQ, Struct.Ptr, RIO_RQ]
}
struct LPFN_RIODEQUEUECOMPLETION extends FunctionPointer {
    static Types := [RIO_CQ, RIORESULT.Ptr, UInt32, UInt32]
}
struct LPFN_RIODEREGISTERBUFFER extends FunctionPointer {
    static Types := [RIO_BUFFERID, "Void"]
}
struct LPFN_RIONOTIFY extends FunctionPointer {
    static Types := [RIO_CQ, Int32]
}
struct LPFN_RIOREGISTERBUFFER extends FunctionPointer {
    static Types := [PSTR, UInt32, RIO_BUFFERID]
}
struct LPFN_RIORESIZECOMPLETIONQUEUE extends FunctionPointer {
    static Types := [RIO_CQ, UInt32, BOOL]
}
struct LPFN_RIORESIZEREQUESTQUEUE extends FunctionPointer {
    static Types := [RIO_RQ, UInt32, UInt32, BOOL]
}
struct RIO_EXTENSION_FUNCTION_TABLE {
    cbSize : UInt32 := this.Size
    RIOReceive : LPFN_RIORECEIVE
    RIOReceiveEx : LPFN_RIORECEIVEEX
    RIOSend : LPFN_RIOSEND
    RIOSendEx : LPFN_RIOSENDEX
    RIOCloseCompletionQueue : LPFN_RIOCLOSECOMPLETIONQUEUE
    RIOCreateCompletionQueue : LPFN_RIOCREATECOMPLETIONQUEUE
    RIOCreateRequestQueue : LPFN_RIOCREATEREQUESTQUEUE
    RIODequeueCompletion : LPFN_RIODEQUEUECOMPLETION
    RIODeregisterBuffer : LPFN_RIODEREGISTERBUFFER
    RIONotify : LPFN_RIONOTIFY
    RIORegisterBuffer : LPFN_RIOREGISTERBUFFER
    RIOResizeCompletionQueue : LPFN_RIORESIZECOMPLETIONQUEUE
    RIOResizeRequestQueue : LPFN_RIORESIZEREQUESTQUEUE
}
struct WSPDATA {
    wVersion : UInt16
    wHighVersion : UInt16
    szDescription : UInt16[256]
}
struct WSATHREADID {
    ThreadHandle : HANDLE
    Reserved : IntPtr
}
struct LPBLOCKINGCALLBACK extends FunctionPointer {
    static Types := [IntPtr, BOOL]
}
struct LPWSAUSERAPC extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct LPWSPACCEPT extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32.Ptr, LPCONDITIONPROC, IntPtr, Int32.Ptr, SOCKET]
}
struct LPWSPADDRESSTOSTRING extends FunctionPointer {
    static Types := [SOCKADDR.Ptr, UInt32, WSAPROTOCOL_INFOW.Ptr, PWSTR, UInt32.Ptr, Int32.Ptr, Int32]
}
struct LPWSPASYNCSELECT extends FunctionPointer {
    static Types := [SOCKET, HWND, UInt32, Int32, Int32.Ptr, Int32]
}
struct LPWSPBIND extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32, Int32.Ptr, Int32]
}
struct LPWSPCANCELBLOCKINGCALL extends FunctionPointer {
    static Types := [Int32.Ptr, Int32]
}
struct LPWSPCLEANUP extends FunctionPointer {
    static Types := [Int32.Ptr, Int32]
}
struct LPWSPCLOSESOCKET extends FunctionPointer {
    static Types := [SOCKET, Int32.Ptr, Int32]
}
struct LPWSPCONNECT extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32, WSABUF.Ptr, WSABUF.Ptr, QOS.Ptr, QOS.Ptr, Int32.Ptr, Int32]
}
struct LPWSPDUPLICATESOCKET extends FunctionPointer {
    static Types := [SOCKET, UInt32, WSAPROTOCOL_INFOW.Ptr, Int32.Ptr, Int32]
}
struct LPWSPENUMNETWORKEVENTS extends FunctionPointer {
    static Types := [SOCKET, HANDLE, WSANETWORKEVENTS.Ptr, Int32.Ptr, Int32]
}
struct LPWSPEVENTSELECT extends FunctionPointer {
    static Types := [SOCKET, WSAEVENT, Int32, Int32.Ptr, Int32]
}
struct LPWSPGETOVERLAPPEDRESULT extends FunctionPointer {
    static Types := [SOCKET, OVERLAPPED.Ptr, UInt32.Ptr, BOOL, UInt32.Ptr, Int32.Ptr, BOOL]
}
struct LPWSPGETPEERNAME extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32.Ptr, Int32.Ptr, Int32]
}
struct LPWSPGETSOCKNAME extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32.Ptr, Int32.Ptr, Int32]
}
struct LPWSPGETSOCKOPT extends FunctionPointer {
    static Types := [SOCKET, Int32, Int32, PSTR, Int32.Ptr, Int32.Ptr, Int32]
}
struct LPWSPGETQOSBYNAME extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, QOS.Ptr, Int32.Ptr, BOOL]
}
struct LPWSPIOCTL extends FunctionPointer {
    static Types := [SOCKET, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWSPJOINLEAF extends FunctionPointer {
    static Types := [SOCKET, SOCKADDR.Ptr, Int32, WSABUF.Ptr, WSABUF.Ptr, QOS.Ptr, QOS.Ptr, UInt32, Int32.Ptr, SOCKET]
}
struct LPWSPLISTEN extends FunctionPointer {
    static Types := [SOCKET, Int32, Int32.Ptr, Int32]
}
struct LPWSPRECV extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWSPRECVDISCONNECT extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, Int32.Ptr, Int32]
}
struct LPWSPRECVFROM extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, SOCKADDR.Ptr, Int32.Ptr, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWSPSELECT extends FunctionPointer {
    static Types := [Int32, FD_SET.Ptr, FD_SET.Ptr, FD_SET.Ptr, TIMEVAL.Ptr, Int32.Ptr, Int32]
}
struct LPWSPSEND extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, UInt32, UInt32.Ptr, UInt32, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWSPSENDDISCONNECT extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, Int32.Ptr, Int32]
}
struct LPWSPSENDTO extends FunctionPointer {
    static Types := [SOCKET, WSABUF.Ptr, UInt32, UInt32.Ptr, UInt32, SOCKADDR.Ptr, Int32, OVERLAPPED.Ptr, LPWSAOVERLAPPED_COMPLETION_ROUTINE, WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWSPSETSOCKOPT extends FunctionPointer {
    static Types := [SOCKET, Int32, Int32, PSTR, Int32, Int32.Ptr, Int32]
}
struct LPWSPSHUTDOWN extends FunctionPointer {
    static Types := [SOCKET, Int32, Int32.Ptr, Int32]
}
struct LPWSPSOCKET extends FunctionPointer {
    static Types := [Int32, Int32, Int32, WSAPROTOCOL_INFOW.Ptr, UInt32, UInt32, Int32.Ptr, SOCKET]
}
struct LPWSPSTRINGTOADDRESS extends FunctionPointer {
    static Types := [PWSTR, Int32, WSAPROTOCOL_INFOW.Ptr, SOCKADDR.Ptr, Int32.Ptr, Int32.Ptr, Int32]
}
struct WSPPROC_TABLE {
    lpWSPAccept : LPWSPACCEPT
    lpWSPAddressToString : LPWSPADDRESSTOSTRING
    lpWSPAsyncSelect : LPWSPASYNCSELECT
    lpWSPBind : LPWSPBIND
    lpWSPCancelBlockingCall : LPWSPCANCELBLOCKINGCALL
    lpWSPCleanup : LPWSPCLEANUP
    lpWSPCloseSocket : LPWSPCLOSESOCKET
    lpWSPConnect : LPWSPCONNECT
    lpWSPDuplicateSocket : LPWSPDUPLICATESOCKET
    lpWSPEnumNetworkEvents : LPWSPENUMNETWORKEVENTS
    lpWSPEventSelect : LPWSPEVENTSELECT
    lpWSPGetOverlappedResult : LPWSPGETOVERLAPPEDRESULT
    lpWSPGetPeerName : LPWSPGETPEERNAME
    lpWSPGetSockName : LPWSPGETSOCKNAME
    lpWSPGetSockOpt : LPWSPGETSOCKOPT
    lpWSPGetQOSByName : LPWSPGETQOSBYNAME
    lpWSPIoctl : LPWSPIOCTL
    lpWSPJoinLeaf : LPWSPJOINLEAF
    lpWSPListen : LPWSPLISTEN
    lpWSPRecv : LPWSPRECV
    lpWSPRecvDisconnect : LPWSPRECVDISCONNECT
    lpWSPRecvFrom : LPWSPRECVFROM
    lpWSPSelect : LPWSPSELECT
    lpWSPSend : LPWSPSEND
    lpWSPSendDisconnect : LPWSPSENDDISCONNECT
    lpWSPSendTo : LPWSPSENDTO
    lpWSPSetSockOpt : LPWSPSETSOCKOPT
    lpWSPShutdown : LPWSPSHUTDOWN
    lpWSPSocket : LPWSPSOCKET
    lpWSPStringToAddress : LPWSPSTRINGTOADDRESS
}
struct LPWPUCLOSEEVENT extends FunctionPointer {
    static Types := [WSAEVENT, Int32.Ptr, BOOL]
}
struct LPWPUCLOSESOCKETHANDLE extends FunctionPointer {
    static Types := [SOCKET, Int32.Ptr, Int32]
}
struct LPWPUCREATEEVENT extends FunctionPointer {
    static Types := [Int32.Ptr, WSAEVENT]
}
struct LPWPUCREATESOCKETHANDLE extends FunctionPointer {
    static Types := [UInt32, IntPtr, Int32.Ptr, SOCKET]
}
struct LPWPUFDISSET extends FunctionPointer {
    static Types := [SOCKET, FD_SET.Ptr, Int32]
}
struct LPWPUGETPROVIDERPATH extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, Int32.Ptr, Int32.Ptr, Int32]
}
struct LPWPUMODIFYIFSHANDLE extends FunctionPointer {
    static Types := [UInt32, SOCKET, Int32.Ptr, SOCKET]
}
struct LPWPUPOSTMESSAGE extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, BOOL]
}
struct LPWPUQUERYBLOCKINGCALLBACK extends FunctionPointer {
    static Types := [UInt32, LPBLOCKINGCALLBACK.Ptr, IntPtr.Ptr, Int32.Ptr, Int32]
}
struct LPWPUQUERYSOCKETHANDLECONTEXT extends FunctionPointer {
    static Types := [SOCKET, IntPtr.Ptr, Int32.Ptr, Int32]
}
struct LPWPUQUEUEAPC extends FunctionPointer {
    static Types := [WSATHREADID.Ptr, LPWSAUSERAPC, IntPtr, Int32.Ptr, Int32]
}
struct LPWPURESETEVENT extends FunctionPointer {
    static Types := [WSAEVENT, Int32.Ptr, BOOL]
}
struct LPWPUSETEVENT extends FunctionPointer {
    static Types := [WSAEVENT, Int32.Ptr, BOOL]
}
struct LPWPUOPENCURRENTTHREAD extends FunctionPointer {
    static Types := [WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWPUCLOSETHREAD extends FunctionPointer {
    static Types := [WSATHREADID.Ptr, Int32.Ptr, Int32]
}
struct LPWPUCOMPLETEOVERLAPPEDREQUEST extends FunctionPointer {
    static Types := [SOCKET, OVERLAPPED.Ptr, UInt32, UInt32, Int32.Ptr, Int32]
}
struct WSPUPCALLTABLE {
    lpWPUCloseEvent : LPWPUCLOSEEVENT
    lpWPUCloseSocketHandle : LPWPUCLOSESOCKETHANDLE
    lpWPUCreateEvent : LPWPUCREATEEVENT
    lpWPUCreateSocketHandle : LPWPUCREATESOCKETHANDLE
    lpWPUFDIsSet : LPWPUFDISSET
    lpWPUGetProviderPath : LPWPUGETPROVIDERPATH
    lpWPUModifyIFSHandle : LPWPUMODIFYIFSHANDLE
    lpWPUPostMessage : LPWPUPOSTMESSAGE
    lpWPUQueryBlockingCallback : LPWPUQUERYBLOCKINGCALLBACK
    lpWPUQuerySocketHandleContext : LPWPUQUERYSOCKETHANDLECONTEXT
    lpWPUQueueApc : LPWPUQUEUEAPC
    lpWPUResetEvent : LPWPURESETEVENT
    lpWPUSetEvent : LPWPUSETEVENT
    lpWPUOpenCurrentThread : LPWPUOPENCURRENTTHREAD
    lpWPUCloseThread : LPWPUCLOSETHREAD
}
struct LPWSPSTARTUP extends FunctionPointer {
    static Types := [UInt16, WSPDATA.Ptr, WSAPROTOCOL_INFOW.Ptr, WSPUPCALLTABLE, WSPPROC_TABLE.Ptr, Int32]
}
struct LPWSCENUMPROTOCOLS extends FunctionPointer {
    static Types := [Int32.Ptr, WSAPROTOCOL_INFOW.Ptr, UInt32.Ptr, Int32.Ptr, Int32]
}
struct LPWSCDEINSTALLPROVIDER extends FunctionPointer {
    static Types := [GUID.Ptr, Int32.Ptr, Int32]
}
struct LPWSCINSTALLPROVIDER extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, WSAPROTOCOL_INFOW.Ptr, UInt32, Int32.Ptr, Int32]
}
struct LPWSCGETPROVIDERPATH extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, Int32.Ptr, Int32.Ptr, Int32]
}
struct LPWSCUPDATEPROVIDER extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, WSAPROTOCOL_INFOW.Ptr, UInt32, Int32.Ptr, Int32]
}
struct WSC_PROVIDER_INFO_TYPE extends Int32 {
    static ProviderInfoLspCategories := 0
    static ProviderInfoAudit := 1
}
struct WSC_PROVIDER_AUDIT_INFO {
    RecordSize : UInt32
    Reserved : Struct.Ptr
}
struct LPWSCINSTALLNAMESPACE extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, UInt32, GUID.Ptr, Int32]
}
struct LPWSCUNINSTALLNAMESPACE extends FunctionPointer {
    static Types := [GUID.Ptr, Int32]
}
struct LPWSCENABLENSPROVIDER extends FunctionPointer {
    static Types := [GUID.Ptr, BOOL, Int32]
}
struct LPNSPCLEANUP extends FunctionPointer {
    static Types := [GUID.Ptr, Int32]
}
struct LPNSPLOOKUPSERVICEBEGIN extends FunctionPointer {
    static Types := [GUID.Ptr, WSAQUERYSETW.Ptr, WSASERVICECLASSINFOW.Ptr, UInt32, HANDLE.Ptr, Int32]
}
struct LPNSPLOOKUPSERVICENEXT extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32.Ptr, WSAQUERYSETW.Ptr, Int32]
}
struct LPNSPIOCTL extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, WSACOMPLETION.Ptr, WSATHREADID.Ptr, Int32]
}
struct LPNSPLOOKUPSERVICEEND extends FunctionPointer {
    static Types := [HANDLE, Int32]
}
struct LPNSPSETSERVICE extends FunctionPointer {
    static Types := [GUID.Ptr, WSASERVICECLASSINFOW.Ptr, WSAQUERYSETW.Ptr, WSAESETSERVICEOP, UInt32, Int32]
}
struct LPNSPINSTALLSERVICECLASS extends FunctionPointer {
    static Types := [GUID.Ptr, WSASERVICECLASSINFOW.Ptr, Int32]
}
struct LPNSPREMOVESERVICECLASS extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, Int32]
}
struct LPNSPGETSERVICECLASSINFO extends FunctionPointer {
    static Types := [GUID.Ptr, UInt32.Ptr, WSASERVICECLASSINFOW.Ptr, Int32]
}
struct NSP_ROUTINE {
    cbSize : UInt32 := this.Size
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    NSPCleanup : LPNSPCLEANUP
    NSPLookupServiceBegin : LPNSPLOOKUPSERVICEBEGIN
    NSPLookupServiceNext : LPNSPLOOKUPSERVICENEXT
    NSPLookupServiceEnd : LPNSPLOOKUPSERVICEEND
    NSPSetService : LPNSPSETSERVICE
    NSPInstallServiceClass : LPNSPINSTALLSERVICECLASS
    NSPRemoveServiceClass : LPNSPREMOVESERVICECLASS
    NSPGetServiceClassInfo : LPNSPGETSERVICECLASSINFO
    NSPIoctl : LPNSPIOCTL
}
struct LPNSPSTARTUP extends FunctionPointer {
    static Types := [GUID.Ptr, NSP_ROUTINE.Ptr, Int32]
}
struct LPNSPV2STARTUP extends FunctionPointer {
    static Types := [GUID.Ptr, Struct.Ptr.Ptr, Int32]
}
struct LPNSPV2CLEANUP extends FunctionPointer {
    static Types := [GUID.Ptr, Struct.Ptr, Int32]
}
struct LPNSPV2LOOKUPSERVICEBEGIN extends FunctionPointer {
    static Types := [GUID.Ptr, WSAQUERYSET2W.Ptr, UInt32, Struct.Ptr, HANDLE.Ptr, Int32]
}
struct LPNSPV2LOOKUPSERVICENEXTEX extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32.Ptr, WSAQUERYSET2W.Ptr, "Void"]
}
struct LPNSPV2LOOKUPSERVICEEND extends FunctionPointer {
    static Types := [HANDLE, Int32]
}
struct LPNSPV2SETSERVICEEX extends FunctionPointer {
    static Types := [HANDLE, GUID.Ptr, WSAQUERYSET2W.Ptr, WSAESETSERVICEOP, UInt32, Struct.Ptr, "Void"]
}
struct LPNSPV2CLIENTSESSIONRUNDOWN extends FunctionPointer {
    static Types := [GUID.Ptr, Struct.Ptr, "Void"]
}
struct NSPV2_ROUTINE {
    cbSize : UInt32 := this.Size
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    NSPv2Startup : LPNSPV2STARTUP
    NSPv2Cleanup : LPNSPV2CLEANUP
    NSPv2LookupServiceBegin : LPNSPV2LOOKUPSERVICEBEGIN
    NSPv2LookupServiceNextEx : LPNSPV2LOOKUPSERVICENEXTEX
    NSPv2LookupServiceEnd : LPNSPV2LOOKUPSERVICEEND
    NSPv2SetServiceEx : LPNSPV2SETSERVICEEX
    NSPv2ClientSessionRundown : LPNSPV2CLIENTSESSIONRUNDOWN
}
struct NS_INFOA {
    dwNameSpace : UInt32
    dwNameSpaceFlags : UInt32
    lpNameSpace : PSTR
}
struct NS_INFOW {
    dwNameSpace : UInt32
    dwNameSpaceFlags : UInt32
    lpNameSpace : PWSTR
}
struct SERVICE_TYPE_VALUE {
    dwNameSpace : UInt32
    dwValueType : UInt32
    dwValueSize : UInt32
    dwValueNameOffset : UInt32
    dwValueOffset : UInt32
}
struct SERVICE_TYPE_VALUE_ABSA {
    dwNameSpace : UInt32
    dwValueType : UInt32
    dwValueSize : UInt32
    lpValueName : PSTR
    lpValue : Struct.Ptr
}
struct SERVICE_TYPE_VALUE_ABSW {
    dwNameSpace : UInt32
    dwValueType : UInt32
    dwValueSize : UInt32
    lpValueName : PWSTR
    lpValue : Struct.Ptr
}
struct SERVICE_TYPE_INFO {
    dwTypeNameOffset : UInt32
    dwValueCount : UInt32
    Values : SERVICE_TYPE_VALUE[1]
}
struct SERVICE_TYPE_INFO_ABSA {
    lpTypeName : PSTR
    dwValueCount : UInt32
    Values : SERVICE_TYPE_VALUE_ABSA[1]
}
struct SERVICE_TYPE_INFO_ABSW {
    lpTypeName : PWSTR
    dwValueCount : UInt32
    Values : SERVICE_TYPE_VALUE_ABSW[1]
}
struct SERVICE_ADDRESS {
    dwAddressType : UInt32
    dwAddressFlags : UInt32
    dwAddressLength : UInt32
    dwPrincipalLength : UInt32
    lpAddress : UInt8.Ptr
    lpPrincipal : UInt8.Ptr
}
struct SERVICE_ADDRESSES {
    dwAddressCount : UInt32
    Addresses : SERVICE_ADDRESS[1]
}
struct SERVICE_INFOA {
    lpServiceType : GUID.Ptr
    lpServiceName : PSTR
    lpComment : PSTR
    lpLocale : PSTR
    dwDisplayHint : RESOURCE_DISPLAY_TYPE
    dwVersion : UInt32
    dwTime : UInt32
    lpMachineName : PSTR
    lpServiceAddress : SERVICE_ADDRESSES.Ptr
    ServiceSpecificInfo : BLOB
}
struct SERVICE_INFOW {
    lpServiceType : GUID.Ptr
    lpServiceName : PWSTR
    lpComment : PWSTR
    lpLocale : PWSTR
    dwDisplayHint : RESOURCE_DISPLAY_TYPE
    dwVersion : UInt32
    dwTime : UInt32
    lpMachineName : PWSTR
    lpServiceAddress : SERVICE_ADDRESSES.Ptr
    ServiceSpecificInfo : BLOB
}
struct NS_SERVICE_INFOA {
    dwNameSpace : UInt32
    ServiceInfo : SERVICE_INFOA
}
struct NS_SERVICE_INFOW {
    dwNameSpace : UInt32
    ServiceInfo : SERVICE_INFOW
}
struct PROTOCOL_INFOA {
    dwServiceFlags : UInt32
    iAddressFamily : Int32
    iMaxSockAddr : Int32
    iMinSockAddr : Int32
    iSocketType : Int32
    iProtocol : Int32
    dwMessageSize : UInt32
    lpProtocol : PSTR
}
struct PROTOCOL_INFOW {
    dwServiceFlags : UInt32
    iAddressFamily : Int32
    iMaxSockAddr : Int32
    iMinSockAddr : Int32
    iSocketType : Int32
    iProtocol : Int32
    dwMessageSize : UInt32
    lpProtocol : PWSTR
}
struct NETRESOURCE2A {
    dwScope : UInt32
    dwType : UInt32
    dwUsage : UInt32
    dwDisplayType : UInt32
    lpLocalName : PSTR
    lpRemoteName : PSTR
    lpComment : PSTR
    ns_info : NS_INFOA
    ServiceType : GUID
    dwProtocols : UInt32
    lpiProtocols : Int32.Ptr
}
struct NETRESOURCE2W {
    dwScope : UInt32
    dwType : UInt32
    dwUsage : UInt32
    dwDisplayType : UInt32
    lpLocalName : PWSTR
    lpRemoteName : PWSTR
    lpComment : PWSTR
    ns_info : NS_INFOA
    ServiceType : GUID
    dwProtocols : UInt32
    lpiProtocols : Int32.Ptr
}
struct LPFN_NSPAPI extends FunctionPointer {
    static Types := [UInt32]
}
struct LPSERVICE_CALLBACK_PROC extends FunctionPointer {
    static Types := [LPARAM, HANDLE, "Void"]
}
struct SERVICE_ASYNC_INFO {
    lpServiceCallbackProc : LPSERVICE_CALLBACK_PROC
    lParam : LPARAM
    hAsyncTaskHandle : HANDLE
}
struct LPLOOKUPSERVICE_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [UInt32, UInt32, OVERLAPPED.Ptr, "Void"]
}
struct LPWSCWRITEPROVIDERORDER extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt32, Int32]
}
struct LPWSCWRITENAMESPACEORDER extends FunctionPointer {
    static Types := [GUID.Ptr, UInt32, Int32]
}
struct SOCKADDR_UN {
    sun_family : ADDRESS_FAMILY
    sun_path : CHAR[108]
}
struct SOCKADDR_IPX {
    sa_family : Int16
    sa_netnum : CHAR[4]
    sa_nodenum : CHAR[6]
    sa_socket : UInt16
}
struct SOCKADDR_TP {
    tp_family : UInt16
    tp_addr_type : UInt16
    tp_taddr_len : UInt16
    tp_tsel_len : UInt16
    tp_addr : UInt8[64]
}
struct SOCKADDR_NB {
    snb_family : Int16
    snb_type : UInt16
    snb_name : CHAR[16]
}
struct SOCKADDR_VNS {
    sin_family : UInt16
    net_address : UInt8[4]
    subnet_addr : UInt8[2]
    port : UInt8[2]
    hops : UInt8
    filler : UInt8[5]
}
struct DL_OUI {
    union {
        Byte : UInt8[3]
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct DL_EI48 {
    union {
        Byte : UInt8[3]
    }
}
struct DL_EUI48 {
    union {
        Byte : UInt8[6]
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        Oui : DL_OUI
        Ei48 : DL_EI48
    }
}
struct DL_EI64 {
    union {
        Byte : UInt8[5]
    }
}
struct DL_EUI64 {
    union {
        Byte : UInt8[8]
        Value : Int64
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        Oui : DL_OUI
        Anonymous : this._Anonymous_e__Union
        struct _Anonymous_e__Union {
            union {
                Ei64 : DL_EI64
                Anonymous : this._Anonymous_e__Struct
            }
            struct _Anonymous_e__Struct {
                Type : UInt8
                Tse : UInt8
                Ei48 : DL_EI48
            }
        }
    }
}
struct SNAP_HEADER {
    Dsap : UInt8
    Ssap : UInt8
    Control : UInt8
    Oui : UInt8[3]
    Type : UInt16
}
struct ETHERNET_HEADER {
    Destination : DL_EUI48
    Source : DL_EUI48
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Type : UInt16
            Length : UInt16
        }
    }
}
struct VLAN_TAG {
    Anonymous : this._Anonymous_e__Union
    Type : UInt16
    struct _Anonymous_e__Union {
        union {
            Tag : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct ICMP_HEADER {
    Type : UInt8
    Code : UInt8
    Checksum : UInt16
}
struct ICMP_MESSAGE {
    Header : ICMP_HEADER
    Data : this._Data_e__Union
    struct _Data_e__Union {
        union {
            Data32 : UInt32[1]
            Data16 : UInt16[2]
            Data8 : UInt8[4]
        }
    }
}
struct IPV4_HEADER {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    TotalLength : UInt16
    Identification : UInt16
    Anonymous3 : this._Anonymous3_e__Union
    TimeToLive : UInt8
    Protocol : UInt8
    HeaderChecksum : UInt16
    SourceAddress : IN_ADDR
    DestinationAddress : IN_ADDR
    struct _Anonymous1_e__Union {
        union {
            VersionAndHeaderLength : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            TypeOfServiceAndEcnField : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous3_e__Union {
        union {
            FlagsAndOffset : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct IPV4_OPTION_HEADER {
    Anonymous : this._Anonymous_e__Union
    OptionLength : UInt8
    struct _Anonymous_e__Union {
        union {
            OptionType : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct IPV4_OPTION_TYPE extends Int32 {
    static IP_OPT_EOL := 0
    static IP_OPT_NOP := 1
    static IP_OPT_SECURITY := 130
    static IP_OPT_LSRR := 131
    static IP_OPT_TS := 68
    static IP_OPT_RR := 7
    static IP_OPT_SSRR := 137
    static IP_OPT_SID := 136
    static IP_OPT_ROUTER_ALERT := 148
    static IP_OPT_MULTIDEST := 149
}
struct IPV4_TIMESTAMP_OPTION {
    OptionHeader : IPV4_OPTION_HEADER
    Pointer : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FlagsOverflow : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct IP_OPTION_TIMESTAMP_FLAGS extends Int32 {
    static IP_OPTION_TIMESTAMP_ONLY := 0
    static IP_OPTION_TIMESTAMP_ADDRESS := 1
    static IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS := 3
}
struct IPV4_ROUTING_HEADER {
    OptionHeader : IPV4_OPTION_HEADER
    Pointer : UInt8
}
struct ICMP4_UNREACH_CODE extends Int32 {
    static ICMP4_UNREACH_NET := 0
    static ICMP4_UNREACH_HOST := 1
    static ICMP4_UNREACH_PROTOCOL := 2
    static ICMP4_UNREACH_PORT := 3
    static ICMP4_UNREACH_FRAG_NEEDED := 4
    static ICMP4_UNREACH_SOURCEROUTE_FAILED := 5
    static ICMP4_UNREACH_NET_UNKNOWN := 6
    static ICMP4_UNREACH_HOST_UNKNOWN := 7
    static ICMP4_UNREACH_ISOLATED := 8
    static ICMP4_UNREACH_NET_ADMIN := 9
    static ICMP4_UNREACH_HOST_ADMIN := 10
    static ICMP4_UNREACH_NET_TOS := 11
    static ICMP4_UNREACH_HOST_TOS := 12
    static ICMP4_UNREACH_ADMIN := 13
}
struct ICMP4_TIME_EXCEED_CODE extends Int32 {
    static ICMP4_TIME_EXCEED_TRANSIT := 0
    static ICMP4_TIME_EXCEED_REASSEMBLY := 1
}
struct ICMPV4_ROUTER_SOLICIT {
    RsHeader : ICMP_MESSAGE
}
struct ICMPV4_ROUTER_ADVERT_HEADER {
    RaHeader : ICMP_MESSAGE
}
struct ICMPV4_ROUTER_ADVERT_ENTRY {
    RouterAdvertAddr : IN_ADDR
    PreferenceLevel : Int32
}
struct ICMPV4_TIMESTAMP_MESSAGE {
    Header : ICMP_MESSAGE
    OriginateTimestamp : UInt32
    ReceiveTimestamp : UInt32
    TransmitTimestamp : UInt32
}
struct ICMPV4_ADDRESS_MASK_MESSAGE {
    Header : ICMP_MESSAGE
    AddressMask : UInt32
}
struct ARP_HEADER {
    HardwareAddressSpace : UInt16
    ProtocolAddressSpace : UInt16
    HardwareAddressLength : UInt8
    ProtocolAddressLength : UInt8
    Opcode : UInt16
    SenderHardwareAddress : UInt8[1]
}
struct ARP_OPCODE extends Int32 {
    static ARP_REQUEST := 1
    static ARP_RESPONSE := 2
}
struct ARP_HARDWARE_TYPE extends Int32 {
    static ARP_HW_ENET := 1
    static ARP_HW_802 := 6
}
struct IGMP_HEADER {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Checksum : UInt16
    MulticastAddress : IN_ADDR
    struct _Anonymous1_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            VersionType : UInt8
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Reserved : UInt8
            MaxRespTime : UInt8
            Code : UInt8
        }
    }
}
struct IGMP_MAX_RESP_CODE_TYPE extends Int32 {
    static IGMP_MAX_RESP_CODE_TYPE_NORMAL := 0
    static IGMP_MAX_RESP_CODE_TYPE_FLOAT := 1
}
struct IGMPV3_QUERY_HEADER {
    Type : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    Checksum : UInt16
    MulticastAddress : IN_ADDR
    _bitfield : UInt8
    Anonymous2 : this._Anonymous2_e__Union
    SourceCount : UInt16
    struct _Anonymous1_e__Union {
        union {
            MaxRespCode : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            QueriersQueryInterfaceCode : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct IGMPV3_REPORT_RECORD_HEADER {
    Type : UInt8
    AuxillaryDataLength : UInt8
    SourceCount : UInt16
    MulticastAddress : IN_ADDR
}
struct IGMPV3_REPORT_HEADER {
    Type : UInt8
    Reserved : UInt8
    Checksum : UInt16
    Reserved2 : UInt16
    RecordCount : UInt16
}
struct IPV6_HEADER {
    Anonymous : this._Anonymous_e__Union
    PayloadLength : UInt16
    NextHeader : UInt8
    HopLimit : UInt8
    SourceAddress : IN6_ADDR
    DestinationAddress : IN6_ADDR
    struct _Anonymous_e__Union {
        union {
            VersionClassFlow : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct IPV6_FRAGMENT_HEADER {
    NextHeader : UInt8
    Reserved : UInt8
    Anonymous : this._Anonymous_e__Union
    Id : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            OffsetAndFlags : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct IPV6_EXTENSION_HEADER {
    NextHeader : UInt8
    Length : UInt8
}
struct IPV6_OPTION_HEADER {
    Type : UInt8
    DataLength : UInt8
}
struct IPV6_OPTION_TYPE extends Int32 {
    static IP6OPT_PAD1 := 0
    static IP6OPT_PADN := 1
    static IP6OPT_TUNNEL_LIMIT := 4
    static IP6OPT_ROUTER_ALERT := 5
    static IP6OPT_JUMBO := 194
    static IP6OPT_NSAP_ADDR := 195
}
struct IPV6_OPTION_JUMBOGRAM {
    Header : IPV6_OPTION_HEADER
    JumbogramLength : UInt8[4]
}
struct IPV6_OPTION_ROUTER_ALERT {
    Header : IPV6_OPTION_HEADER
    Value : UInt8[2]
}
struct IPV6_ROUTING_HEADER {
    NextHeader : UInt8
    Length : UInt8
    RoutingType : UInt8
    SegmentsLeft : UInt8
    Reserved : UInt8[4]
}
struct ND_ROUTER_SOLICIT_HEADER {
    nd_rs_hdr : ICMP_MESSAGE
}
struct ND_ROUTER_ADVERT_HEADER {
    nd_ra_hdr : ICMP_MESSAGE
    nd_ra_reachable : UInt32
    nd_ra_retransmit : UInt32
}
struct IPV6_ROUTER_ADVERTISEMENT_FLAGS {
    union {
        Anonymous : this._Anonymous_e__Struct
        Value : UInt8
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct ND_NEIGHBOR_SOLICIT_HEADER {
    nd_ns_hdr : ICMP_MESSAGE
    nd_ns_target : IN6_ADDR
}
struct ND_NEIGHBOR_ADVERT_HEADER {
    nd_na_hdr : ICMP_MESSAGE
    nd_na_target : IN6_ADDR
}
struct IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS {
    union {
        Anonymous : this._Anonymous_e__Struct
        Value : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
        Reserved2 : UInt8[3]
    }
}
struct ND_REDIRECT_HEADER {
    nd_rd_hdr : ICMP_MESSAGE
    nd_rd_target : IN6_ADDR
    nd_rd_dst : IN6_ADDR
}
struct ND_OPTION_HDR {
    nd_opt_type : UInt8
    nd_opt_len : UInt8
}
struct ND_OPTION_TYPE extends Int32 {
    static ND_OPT_SOURCE_LINKADDR := 1
    static ND_OPT_TARGET_LINKADDR := 2
    static ND_OPT_PREFIX_INFORMATION := 3
    static ND_OPT_REDIRECTED_HEADER := 4
    static ND_OPT_MTU := 5
    static ND_OPT_NBMA_SHORTCUT_LIMIT := 6
    static ND_OPT_ADVERTISEMENT_INTERVAL := 7
    static ND_OPT_HOME_AGENT_INFORMATION := 8
    static ND_OPT_SOURCE_ADDR_LIST := 9
    static ND_OPT_TARGET_ADDR_LIST := 10
    static ND_OPT_ROUTE_INFO := 24
    static ND_OPT_RDNSS := 25
    static ND_OPT_DNSSL := 31
    static ND_OPT_PREF64 := 38
}
struct ND_OPTION_PREFIX_INFO {
    nd_opt_pi_type : UInt8
    nd_opt_pi_len : UInt8
    nd_opt_pi_prefix_len : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    nd_opt_pi_valid_time : UInt32
    nd_opt_pi_preferred_time : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    nd_opt_pi_prefix : IN6_ADDR
    struct _Anonymous1_e__Union {
        union {
            nd_opt_pi_flags_reserved : UInt8
            Flags : this._Flags_e__Struct
        }
        struct _Flags_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            nd_opt_pi_reserved2 : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            nd_opt_pi_reserved3 : UInt8[3]
            nd_opt_pi_site_prefix_len : UInt8
        }
    }
}
struct ND_OPTION_RD_HDR {
    nd_opt_rh_type : UInt8
    nd_opt_rh_len : UInt8
    nd_opt_rh_reserved1 : UInt16
    nd_opt_rh_reserved2 : UInt32
}
struct ND_OPTION_MTU {
    nd_opt_mtu_type : UInt8
    nd_opt_mtu_len : UInt8
    nd_opt_mtu_reserved : UInt16
    nd_opt_mtu_mtu : UInt32
}
struct ND_OPTION_ROUTE_INFO {
    nd_opt_ri_type : UInt8
    nd_opt_ri_len : UInt8
    nd_opt_ri_prefix_len : UInt8
    Anonymous : this._Anonymous_e__Union
    nd_opt_ri_route_lifetime : UInt32
    nd_opt_ri_prefix : IN6_ADDR
    struct _Anonymous_e__Union {
        union {
            nd_opt_ri_flags_reserved : UInt8
            Flags : this._Flags_e__Struct
        }
        struct _Flags_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct ND_OPTION_RDNSS {
    nd_opt_rdnss_type : UInt8
    nd_opt_rdnss_len : UInt8
    nd_opt_rdnss_reserved : UInt16
    nd_opt_rdnss_lifetime : UInt32
}
struct ND_OPTION_DNSSL {
    nd_opt_dnssl_type : UInt8
    nd_opt_dnssl_len : UInt8
    nd_opt_dnssl_reserved : UInt16
    nd_opt_dnssl_lifetime : UInt32
}
struct ND_OPTION_PREF64 {
    nd_opt_p64_type : UInt8
    nd_opt_p64_len : UInt8
    Anonymous : this._Anonymous_e__Union
    nd_opt_p64_prefix : UInt8[12]
    struct _Anonymous_e__Union {
        union {
            nd_opt_p64_lifetime_plc : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct ND_OPT_PREF64_PREFIX_LENGTH_CODE extends Int32 {
    static ND_OPT_PREF64_PREFIX_LENGTH_96 := 0
    static ND_OPT_PREF64_PREFIX_LENGTH_64 := 1
    static ND_OPT_PREF64_PREFIX_LENGTH_56 := 2
    static ND_OPT_PREF64_PREFIX_LENGTH_48 := 3
    static ND_OPT_PREF64_PREFIX_LENGTH_40 := 4
    static ND_OPT_PREF64_PREFIX_LENGTH_32 := 5
}
struct MLD_HEADER {
    IcmpHeader : ICMP_HEADER
    MaxRespTime : UInt16
    Reserved : UInt16
    MulticastAddress : IN6_ADDR
}
struct MLD_MAX_RESP_CODE_TYPE extends Int32 {
    static MLD_MAX_RESP_CODE_TYPE_NORMAL := 0
    static MLD_MAX_RESP_CODE_TYPE_FLOAT := 1
}
struct MLDV2_QUERY_HEADER {
    IcmpHeader : ICMP_HEADER
    Anonymous1 : this._Anonymous1_e__Union
    Reserved : UInt16
    MulticastAddress : IN6_ADDR
    _bitfield : UInt8
    Anonymous2 : this._Anonymous2_e__Union
    SourceCount : UInt16
    struct _Anonymous1_e__Union {
        union {
            MaxRespCode : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            QueriersQueryInterfaceCode : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct MLDV2_REPORT_RECORD_HEADER {
    Type : UInt8
    AuxillaryDataLength : UInt8
    SourceCount : UInt16
    MulticastAddress : IN6_ADDR
}
struct MLDV2_REPORT_HEADER {
    IcmpHeader : ICMP_HEADER
    Reserved : UInt16
    RecordCount : UInt16
}
struct TCP_HDR {
    th_sport : UInt16
    th_dport : UInt16
    th_seq : UInt32
    th_ack : UInt32
    _bitfield : UInt8
    th_flags : UInt8
    th_win : UInt16
    th_sum : UInt16
    th_urp : UInt16
}
struct TCP_OPT_MSS {
    Kind : UInt8
    Length : UInt8
    Mss : UInt16
}
struct TCP_OPT_WS {
    Kind : UInt8
    Length : UInt8
    ShiftCnt : UInt8
}
struct TCP_OPT_SACK_PERMITTED {
    Kind : UInt8
    Length : UInt8
}
struct TCP_OPT_SACK {
    Kind : UInt8
    Length : UInt8
    Block : this.tcp_opt_sack_block[1]
    struct tcp_opt_sack_block {
        Left : UInt32
        Right : UInt32
    }
}
struct TCP_OPT_TS {
    Kind : UInt8
    Length : UInt8
    Val : UInt32
    EcR : UInt32
}
struct TCP_OPT_UNKNOWN {
    Kind : UInt8
    Length : UInt8
}
struct TCP_OPT_FASTOPEN {
    Kind : UInt8
    Length : UInt8
    Cookie : UInt8[1]
}
struct DL_TUNNEL_ADDRESS {
    CompartmentId : COMPARTMENT_ID
    ScopeId : SCOPE_ID
    IpAddress : UInt8[1]
}
struct TUNNEL_SUB_TYPE extends Int32 {
    static TUNNEL_SUB_TYPE_NONE := 0
    static TUNNEL_SUB_TYPE_CP := 1
    static TUNNEL_SUB_TYPE_IPTLS := 2
    static TUNNEL_SUB_TYPE_HA := 3
}
struct DL_TEREDO_ADDRESS {
    Reserved : UInt8[6]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Eui64 : DL_EUI64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Flags : UInt16
            MappedPort : UInt16
            MappedAddress : IN_ADDR
        }
    }
}
struct DL_TEREDO_ADDRESS_PRV {
    Reserved : UInt8[6]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Eui64 : DL_EUI64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Flags : UInt16
            MappedPort : UInt16
            MappedAddress : IN_ADDR
            LocalAddress : IN_ADDR
            InterfaceIndex : UInt32
            LocalPort : UInt16
            DlDestination : DL_EUI48
        }
    }
}
struct IPTLS_METADATA {
    SequenceNumber : Int64
}
struct NPI_MODULEID_TYPE extends Int32 {
    static MIT_GUID := 1
    static MIT_IF_LUID := 2
}
struct NPI_MODULEID {
    Length : UInt16
    Type : NPI_MODULEID_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Guid : GUID
            IfLuid : LUID
        }
    }
}
struct FALLBACK_INDEX extends Int32 {
    static FallbackIndexTcpFastopen := 0
    static FallbackIndexMax := 1
}
