#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HANDLE, HWND, PSTR, PWSTR, SYSTEMTIME}
#Import "..\System.Com\Types.ahk" {IRpcChannelBuffer, RPC_C_IMP_LEVEL}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}

struct PFN_RPC_ALLOCATE extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PFN_RPC_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct RPC_C_QOS_CAPABILITIES extends UInt32 {
    static RPC_C_QOS_CAPABILITIES_DEFAULT := 0
    static RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH := 1
    static RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC := 2
    static RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY := 4
    static RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE := 8
    static RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT := 16
    static RPC_C_QOS_CAPABILITIES_SCHANNEL_FULL_AUTH_IDENTITY := 32
}
struct RPC_C_QOS_IDENTITY extends UInt32 {
    static RPC_C_QOS_IDENTITY_STATIC := 0
    static RPC_C_QOS_IDENTITY_DYNAMIC := 1
}
struct RPC_C_AUTHN_INFO_TYPE extends UInt32 {
    static RPC_C_AUTHN_INFO_NONE := 0
    static RPC_C_AUTHN_INFO_TYPE_HTTP := 1
}
struct RPC_C_HTTP_FLAGS extends UInt32 {
    static RPC_C_HTTP_FLAG_USE_SSL := 1
    static RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME := 2
    static RPC_C_HTTP_FLAG_IGNORE_CERT_CN_INVALID := 8
    static RPC_C_HTTP_FLAG_ENABLE_CERT_REVOCATION_CHECK := 16
}
struct RPC_C_HTTP_AUTHN_TARGET extends UInt32 {
    static RPC_C_HTTP_AUTHN_TARGET_SERVER := 1
    static RPC_C_HTTP_AUTHN_TARGET_PROXY := 2
}
struct RPC_STATUS extends Int32 {
    static RPC_S_OK := 0
    static RPC_S_ACCESS_DENIED := 5
    static RPC_S_INVALID_ARG := 87
    static RPC_S_OUT_OF_MEMORY := 14
    static RPC_S_OUT_OF_THREADS := 164
    static RPC_S_INVALID_LEVEL := 87
    static RPC_S_BUFFER_TOO_SMALL := 122
    static RPC_S_INVALID_SECURITY_DESC := 1338
    static RPC_S_SERVER_OUT_OF_MEMORY := 1130
    static RPC_S_ASYNC_CALL_PENDING := 997
    static RPC_S_UNKNOWN_PRINCIPAL := 1332
    static RPC_S_TIMEOUT := 1460
    static RPC_S_RUNTIME_UNINITIALIZED := 1
    static RPC_S_NOT_ENOUGH_QUOTA := 1816
    static RPC_S_INVALID_STRING_BINDING := 1700
    static RPC_S_WRONG_KIND_OF_BINDING := 1701
    static RPC_S_INVALID_BINDING := 1702
    static RPC_S_PROTSEQ_NOT_SUPPORTED := 1703
    static RPC_S_INVALID_RPC_PROTSEQ := 1704
    static RPC_S_INVALID_STRING_UUID := 1705
    static RPC_S_INVALID_ENDPOINT_FORMAT := 1706
    static RPC_S_INVALID_NET_ADDR := 1707
    static RPC_S_NO_ENDPOINT_FOUND := 1708
    static RPC_S_INVALID_TIMEOUT := 1709
    static RPC_S_OBJECT_NOT_FOUND := 1710
    static RPC_S_ALREADY_REGISTERED := 1711
    static RPC_S_TYPE_ALREADY_REGISTERED := 1712
    static RPC_S_ALREADY_LISTENING := 1713
    static RPC_S_NO_PROTSEQS_REGISTERED := 1714
    static RPC_S_NOT_LISTENING := 1715
    static RPC_S_UNKNOWN_MGR_TYPE := 1716
    static RPC_S_UNKNOWN_IF := 1717
    static RPC_S_NO_BINDINGS := 1718
    static RPC_S_NO_PROTSEQS := 1719
    static RPC_S_CANT_CREATE_ENDPOINT := 1720
    static RPC_S_OUT_OF_RESOURCES := 1721
    static RPC_S_SERVER_UNAVAILABLE := 1722
    static RPC_S_SERVER_TOO_BUSY := 1723
    static RPC_S_INVALID_NETWORK_OPTIONS := 1724
    static RPC_S_NO_CALL_ACTIVE := 1725
    static RPC_S_CALL_FAILED := 1726
    static RPC_S_CALL_FAILED_DNE := 1727
    static RPC_S_PROTOCOL_ERROR := 1728
    static RPC_S_PROXY_ACCESS_DENIED := 1729
    static RPC_S_UNSUPPORTED_TRANS_SYN := 1730
    static RPC_S_UNSUPPORTED_TYPE := 1732
    static RPC_S_INVALID_TAG := 1733
    static RPC_S_INVALID_BOUND := 1734
    static RPC_S_NO_ENTRY_NAME := 1735
    static RPC_S_INVALID_NAME_SYNTAX := 1736
    static RPC_S_UNSUPPORTED_NAME_SYNTAX := 1737
    static RPC_S_UUID_NO_ADDRESS := 1739
    static RPC_S_DUPLICATE_ENDPOINT := 1740
    static RPC_S_UNKNOWN_AUTHN_TYPE := 1741
    static RPC_S_MAX_CALLS_TOO_SMALL := 1742
    static RPC_S_STRING_TOO_LONG := 1743
    static RPC_S_PROTSEQ_NOT_FOUND := 1744
    static RPC_S_PROCNUM_OUT_OF_RANGE := 1745
    static RPC_S_BINDING_HAS_NO_AUTH := 1746
    static RPC_S_UNKNOWN_AUTHN_SERVICE := 1747
    static RPC_S_UNKNOWN_AUTHN_LEVEL := 1748
    static RPC_S_INVALID_AUTH_IDENTITY := 1749
    static RPC_S_UNKNOWN_AUTHZ_SERVICE := 1750
    static EPT_S_INVALID_ENTRY := 1751
    static EPT_S_CANT_PERFORM_OP := 1752
    static EPT_S_NOT_REGISTERED := 1753
    static RPC_S_NOTHING_TO_EXPORT := 1754
    static RPC_S_INCOMPLETE_NAME := 1755
    static RPC_S_INVALID_VERS_OPTION := 1756
    static RPC_S_NO_MORE_MEMBERS := 1757
    static RPC_S_NOT_ALL_OBJS_UNEXPORTED := 1758
    static RPC_S_INTERFACE_NOT_FOUND := 1759
    static RPC_S_ENTRY_ALREADY_EXISTS := 1760
    static RPC_S_ENTRY_NOT_FOUND := 1761
    static RPC_S_NAME_SERVICE_UNAVAILABLE := 1762
    static RPC_S_INVALID_NAF_ID := 1763
    static RPC_S_CANNOT_SUPPORT := 1764
    static RPC_S_NO_CONTEXT_AVAILABLE := 1765
    static RPC_S_INTERNAL_ERROR := 1766
    static RPC_S_ZERO_DIVIDE := 1767
    static RPC_S_ADDRESS_ERROR := 1768
    static RPC_S_FP_DIV_ZERO := 1769
    static RPC_S_FP_UNDERFLOW := 1770
    static RPC_S_FP_OVERFLOW := 1771
    static RPC_S_CALL_IN_PROGRESS := 1791
    static RPC_S_NO_MORE_BINDINGS := 1806
    static RPC_S_NO_INTERFACES := 1817
    static RPC_S_CALL_CANCELLED := 1818
    static RPC_S_BINDING_INCOMPLETE := 1819
    static RPC_S_COMM_FAILURE := 1820
    static RPC_S_UNSUPPORTED_AUTHN_LEVEL := 1821
    static RPC_S_NO_PRINC_NAME := 1822
    static RPC_S_NOT_RPC_ERROR := 1823
    static RPC_S_UUID_LOCAL_ONLY := 1824
    static RPC_S_SEC_PKG_ERROR := 1825
    static RPC_S_NOT_CANCELLED := 1826
    static RPC_S_COOKIE_AUTH_FAILED := 1833
    static RPC_S_DO_NOT_DISTURB := 1834
    static RPC_S_SYSTEM_HANDLE_COUNT_EXCEEDED := 1835
    static RPC_S_SYSTEM_HANDLE_TYPE_MISMATCH := 1836
    static RPC_S_GROUP_MEMBER_NOT_FOUND := 1898
    static EPT_S_CANT_CREATE := 1899
    static RPC_S_INVALID_OBJECT := 1900
    static RPC_S_SEND_INCOMPLETE := 1913
    static RPC_S_INVALID_ASYNC_HANDLE := 1914
    static RPC_S_INVALID_ASYNC_CALL := 1915
    static RPC_S_ENTRY_TYPE_MISMATCH := 1922
    static RPC_S_NOT_ALL_OBJS_EXPORTED := 1923
    static RPC_S_INTERFACE_NOT_EXPORTED := 1924
    static RPC_S_PROFILE_NOT_ADDED := 1925
    static RPC_S_PRF_ELT_NOT_ADDED := 1926
    static RPC_S_PRF_ELT_NOT_REMOVED := 1927
    static RPC_S_GRP_ELT_NOT_ADDED := 1928
    static RPC_S_GRP_ELT_NOT_REMOVED := 1929
}
struct GROUP_NAME_SYNTAX extends UInt32 {
    static RPC_C_NS_SYNTAX_DEFAULT := 0
    static RPC_C_NS_SYNTAX_DCE := 3
}
struct SEC_WINNT_AUTH_IDENTITY extends UInt32 {
    static SEC_WINNT_AUTH_IDENTITY_ANSI := 1
    static SEC_WINNT_AUTH_IDENTITY_UNICODE := 2
}
struct RPC_BINDING_HANDLE_OPTIONS_FLAGS extends UInt32 {
    static RPC_BHO_NONCAUSAL := 1
    static RPC_BHO_DONTLINGER := 2
}
struct PNDR_ASYNC_MESSAGE {
    Value : IntPtr
}
struct PNDR_CORRELATION_INFO {
    Value : IntPtr
}
struct NDR_PROC_CONTEXT {
    Value : IntPtr
}
struct NDR_ALLOC_ALL_NODES_CONTEXT {
    Value : IntPtr
}
struct NDR_POINTER_QUEUE_STATE {
    Value : IntPtr
}
struct RPC_BINDING_VECTOR {
    Count : UInt32
    BindingH : Struct.Ptr[1]
}
struct UUID_VECTOR {
    Count : UInt32
    Uuid : GUID.Ptr[1]
}
struct RPC_IF_ID {
    Uuid : GUID
    VersMajor : UInt16
    VersMinor : UInt16
}
struct RPC_PROTSEQ_VECTORA {
    Count : UInt32
    Protseq : UInt8.Ptr[1]
}
struct RPC_PROTSEQ_VECTORW {
    Count : UInt32
    Protseq : UInt16.Ptr[1]
}
struct RPC_POLICY {
    Length : UInt32
    EndpointFlags : UInt32
    NICFlags : UInt32
}
struct RPC_OBJECT_INQ_FN extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, RPC_STATUS.Ptr, "Void"]
}
struct RPC_IF_CALLBACK_FN extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, RPC_STATUS]
}
struct RPC_SECURITY_CALLBACK_FN extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct RPC_STATS_VECTOR {
    Count : UInt32
    Stats : UInt32[1]
}
struct RPC_IF_ID_VECTOR {
    Count : UInt32
    IfId : RPC_IF_ID.Ptr[1]
}
struct RPC_SECURITY_QOS {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
}
struct SEC_WINNT_AUTH_IDENTITY_W {
    User : UInt16.Ptr
    UserLength : UInt32
    Domain : UInt16.Ptr
    DomainLength : UInt32
    Password : UInt16.Ptr
    PasswordLength : UInt32
    Flags : SEC_WINNT_AUTH_IDENTITY
}
struct SEC_WINNT_AUTH_IDENTITY_A {
    User : UInt8.Ptr
    UserLength : UInt32
    Domain : UInt8.Ptr
    DomainLength : UInt32
    Password : UInt8.Ptr
    PasswordLength : UInt32
    Flags : SEC_WINNT_AUTH_IDENTITY
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_W {
    TransportCredentials : SEC_WINNT_AUTH_IDENTITY_W.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt16.Ptr
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_A {
    TransportCredentials : SEC_WINNT_AUTH_IDENTITY_A.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt8.Ptr
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_W {
    TransportCredentials : SEC_WINNT_AUTH_IDENTITY_W.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt16.Ptr
    ProxyCredentials : SEC_WINNT_AUTH_IDENTITY_W.Ptr
    NumberOfProxyAuthnSchemes : UInt32
    ProxyAuthnSchemes : UInt32.Ptr
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_A {
    TransportCredentials : SEC_WINNT_AUTH_IDENTITY_A.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt8.Ptr
    ProxyCredentials : SEC_WINNT_AUTH_IDENTITY_A.Ptr
    NumberOfProxyAuthnSchemes : UInt32
    ProxyAuthnSchemes : UInt32.Ptr
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_W {
    TransportCredentials : Struct.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt16.Ptr
    ProxyCredentials : Struct.Ptr
    NumberOfProxyAuthnSchemes : UInt32
    ProxyAuthnSchemes : UInt32.Ptr
}
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_A {
    TransportCredentials : Struct.Ptr
    Flags : RPC_C_HTTP_FLAGS
    AuthenticationTarget : RPC_C_HTTP_AUTHN_TARGET
    NumberOfAuthnSchemes : UInt32
    AuthnSchemes : UInt32.Ptr
    ServerCertificateSubject : UInt8.Ptr
    ProxyCredentials : Struct.Ptr
    NumberOfProxyAuthnSchemes : UInt32
    ProxyAuthnSchemes : UInt32.Ptr
}
struct RPC_SECURITY_QOS_V2_W {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_W.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V2_A {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_A.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V3_W {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_W.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V3_A {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_A.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V4_W {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    EffectiveOnly : UInt32
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_W.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V4_A {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    EffectiveOnly : UInt32
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_A.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V5_W {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    EffectiveOnly : UInt32
    ServerSecurityDescriptor : Struct.Ptr
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_W.Ptr
        }
    }
}
struct RPC_SECURITY_QOS_V5_A {
    Version : UInt32
    Capabilities : RPC_C_QOS_CAPABILITIES
    IdentityTracking : RPC_C_QOS_IDENTITY
    ImpersonationType : RPC_C_IMP_LEVEL
    AdditionalSecurityInfoType : RPC_C_AUTHN_INFO_TYPE
    u : this._u_e__Union
    Sid : Struct.Ptr
    EffectiveOnly : UInt32
    ServerSecurityDescriptor : Struct.Ptr
    struct _u_e__Union {
        union {
            HttpCredentials : RPC_HTTP_TRANSPORT_CREDENTIALS_A.Ptr
        }
    }
}
struct RPC_BINDING_HANDLE_TEMPLATE_V1_W {
    Version : UInt32
    Flags : UInt32
    ProtocolSequence : UInt32
    NetworkAddress : UInt16.Ptr
    StringEndpoint : UInt16.Ptr
    u1 : this._u1_e__Union
    ObjectUuid : GUID
    struct _u1_e__Union {
        union {
            Reserved : UInt16.Ptr
        }
    }
}
struct RPC_BINDING_HANDLE_TEMPLATE_V1_A {
    Version : UInt32
    Flags : UInt32
    ProtocolSequence : UInt32
    NetworkAddress : UInt8.Ptr
    StringEndpoint : UInt8.Ptr
    u1 : this._u1_e__Union
    ObjectUuid : GUID
    struct _u1_e__Union {
        union {
            Reserved : UInt8.Ptr
        }
    }
}
struct RPC_BINDING_HANDLE_SECURITY_V1_W {
    Version : UInt32
    ServerPrincName : UInt16.Ptr
    AuthnLevel : UInt32
    AuthnSvc : UInt32
    AuthIdentity : SEC_WINNT_AUTH_IDENTITY_W.Ptr
    SecurityQos : RPC_SECURITY_QOS.Ptr
}
struct RPC_BINDING_HANDLE_SECURITY_V1_A {
    Version : UInt32
    ServerPrincName : UInt8.Ptr
    AuthnLevel : UInt32
    AuthnSvc : UInt32
    AuthIdentity : SEC_WINNT_AUTH_IDENTITY_A.Ptr
    SecurityQos : RPC_SECURITY_QOS.Ptr
}
struct RPC_BINDING_HANDLE_OPTIONS_V1 {
    Version : UInt32
    Flags : RPC_BINDING_HANDLE_OPTIONS_FLAGS
    ComTimeout : UInt32
    CallTimeout : UInt32
}
struct RPC_HTTP_REDIRECTOR_STAGE extends Int32 {
    static RPCHTTP_RS_REDIRECT := 1
    static RPCHTTP_RS_ACCESS_1 := 2
    static RPCHTTP_RS_SESSION := 3
    static RPCHTTP_RS_ACCESS_2 := 4
    static RPCHTTP_RS_INTERFACE := 5
}
struct RPC_NEW_HTTP_PROXY_CHANNEL extends FunctionPointer {
    static Types := [RPC_HTTP_REDIRECTOR_STAGE, PWSTR, PWSTR, PWSTR, PWSTR, Struct.Ptr, Struct.Ptr, Struct.Ptr, Struct.Ptr, UInt32, PWSTR.Ptr, PWSTR.Ptr, RPC_STATUS]
}
struct RPC_HTTP_PROXY_FREE_STRING extends FunctionPointer {
    static Types := [PWSTR, "Void"]
}
struct RPC_AUTH_KEY_RETRIEVAL_FN extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, Struct.Ptr.Ptr, RPC_STATUS.Ptr, "Void"]
}
struct RPC_CLIENT_INFORMATION1 {
    UserName : UInt8.Ptr
    ComputerName : UInt8.Ptr
    Privilege : UInt16
    AuthFlags : UInt32
}
struct RPC_MGMT_AUTHORIZATION_FN extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, RPC_STATUS.Ptr, Int32]
}
struct RPC_ENDPOINT_TEMPLATEW {
    Version : UInt32
    ProtSeq : PWSTR
    Endpoint : PWSTR
    SecurityDescriptor : Struct.Ptr
    Backlog : UInt32
}
struct RPC_ENDPOINT_TEMPLATEA {
    Version : UInt32
    ProtSeq : PSTR
    Endpoint : PSTR
    SecurityDescriptor : Struct.Ptr
    Backlog : UInt32
}
struct RPC_INTERFACE_TEMPLATEA {
    Version : UInt32
    IfSpec : Struct.Ptr
    MgrTypeUuid : GUID.Ptr
    MgrEpv : Struct.Ptr
    Flags : UInt32
    MaxCalls : UInt32
    MaxRpcSize : UInt32
    IfCallback : RPC_IF_CALLBACK_FN
    UuidVector : UUID_VECTOR.Ptr
    Annotation : PSTR
    SecurityDescriptor : Struct.Ptr
}
struct RPC_INTERFACE_TEMPLATEW {
    Version : UInt32
    IfSpec : Struct.Ptr
    MgrTypeUuid : GUID.Ptr
    MgrEpv : Struct.Ptr
    Flags : UInt32
    MaxCalls : UInt32
    MaxRpcSize : UInt32
    IfCallback : RPC_IF_CALLBACK_FN
    UuidVector : UUID_VECTOR.Ptr
    Annotation : PWSTR
    SecurityDescriptor : Struct.Ptr
}
struct RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, "Void"]
}
struct RPC_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct RPC_SYNTAX_IDENTIFIER {
    SyntaxGUID : GUID
    SyntaxVersion : RPC_VERSION
}
struct RPC_MESSAGE {
    Handle : Struct.Ptr
    DataRepresentation : UInt32
    Buffer : Struct.Ptr
    BufferLength : UInt32
    ProcNum : UInt32
    TransferSyntax : RPC_SYNTAX_IDENTIFIER.Ptr
    RpcInterfaceInformation : Struct.Ptr
    ReservedForRuntime : Struct.Ptr
    ManagerEpv : Struct.Ptr
    ImportContext : Struct.Ptr
    RpcFlags : UInt32
}
struct RPC_FORWARD_FUNCTION extends FunctionPointer {
    static Types := [GUID.Ptr, RPC_VERSION.Ptr, GUID.Ptr, UInt8.Ptr, Struct.Ptr.Ptr, RPC_STATUS]
}
struct RPC_ADDRESS_CHANGE_TYPE extends Int32 {
    static PROTOCOL_NOT_LOADED := 1
    static PROTOCOL_LOADED := 2
    static PROTOCOL_ADDRESS_CHANGE := 3
}
struct RPC_ADDRESS_CHANGE_FN extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct RPC_DISPATCH_FUNCTION extends FunctionPointer {
    static Types := [RPC_MESSAGE.Ptr, "Void"]
}
struct RPC_DISPATCH_TABLE {
    DispatchTableCount : UInt32
    DispatchTable : RPC_DISPATCH_FUNCTION
    Reserved : IntPtr
}
struct RPC_PROTSEQ_ENDPOINT {
    RpcProtocolSequence : UInt8.Ptr
    Endpoint : UInt8.Ptr
}
struct RPC_SERVER_INTERFACE {
    Length : UInt32
    InterfaceId : RPC_SYNTAX_IDENTIFIER
    TransferSyntax : RPC_SYNTAX_IDENTIFIER
    DispatchTable : RPC_DISPATCH_TABLE.Ptr
    RpcProtseqEndpointCount : UInt32
    RpcProtseqEndpoint : RPC_PROTSEQ_ENDPOINT.Ptr
    DefaultManagerEpv : Struct.Ptr
    InterpreterInfo : Struct.Ptr
    Flags : UInt32
}
struct RPC_CLIENT_INTERFACE {
    Length : UInt32
    InterfaceId : RPC_SYNTAX_IDENTIFIER
    TransferSyntax : RPC_SYNTAX_IDENTIFIER
    DispatchTable : RPC_DISPATCH_TABLE.Ptr
    RpcProtseqEndpointCount : UInt32
    RpcProtseqEndpoint : RPC_PROTSEQ_ENDPOINT.Ptr
    Reserved : IntPtr
    InterpreterInfo : Struct.Ptr
    Flags : UInt32
}
struct LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION extends Int32 {
    static MarshalDirectionMarshal := 0
    static MarshalDirectionUnmarshal := 1
}
struct PRPC_RUNDOWN extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct RPC_SEC_CONTEXT_KEY_INFO {
    EncryptAlgorithm : UInt32
    KeySize : UInt32
    SignatureAlgorithm : UInt32
}
struct RPC_TRANSFER_SYNTAX {
    Uuid : GUID
    VersMajor : UInt16
    VersMinor : UInt16
}
struct RPCLT_PDU_FILTER_FUNC extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Int32, "Void"]
}
struct RPC_SETFILTER_FUNC extends FunctionPointer {
    static Types := [RPCLT_PDU_FILTER_FUNC, "Void"]
    static Options := "C"
}
struct RPC_BLOCKING_FN extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, Struct.Ptr, RPC_STATUS]
}
struct RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR {
    BufferSize : UInt32
    Buffer : PSTR
}
struct RDR_CALLOUT_STATE {
    LastError : RPC_STATUS
    LastEEInfo : Struct.Ptr
    LastCalledStage : RPC_HTTP_REDIRECTOR_STAGE
    ServerName : UInt16.Ptr
    ServerPort : UInt16.Ptr
    RemoteUser : UInt16.Ptr
    AuthType : UInt16.Ptr
    ResourceTypePresent : UInt8
    SessionIdPresent : UInt8
    InterfacePresent : UInt8
    ResourceType : GUID
    SessionId : GUID
    Interface : RPC_SYNTAX_IDENTIFIER
    CertContext : Struct.Ptr
}
struct I_RpcProxyIsValidMachineFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, RPC_STATUS]
}
struct I_RpcProxyGetClientAddressFn extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt32.Ptr, RPC_STATUS]
}
struct I_RpcProxyGetConnectionTimeoutFn extends FunctionPointer {
    static Types := [UInt32.Ptr, RPC_STATUS]
}
struct I_RpcPerformCalloutFn extends FunctionPointer {
    static Types := [Struct.Ptr, RDR_CALLOUT_STATE.Ptr, RPC_HTTP_REDIRECTOR_STAGE, RPC_STATUS]
}
struct I_RpcFreeCalloutStateFn extends FunctionPointer {
    static Types := [RDR_CALLOUT_STATE.Ptr, "Void"]
}
struct I_RpcProxyGetClientSessionAndResourceUUID extends FunctionPointer {
    static Types := [Struct.Ptr, Int32.Ptr, GUID.Ptr, Int32.Ptr, GUID.Ptr, RPC_STATUS]
}
struct I_RpcProxyFilterIfFn extends FunctionPointer {
    static Types := [Struct.Ptr, GUID.Ptr, UInt16, Int32.Ptr, RPC_STATUS]
}
struct RpcPerfCounters extends Int32 {
    static RpcCurrentUniqueUser := 1
    static RpcBackEndConnectionAttempts := 2
    static RpcBackEndConnectionFailed := 3
    static RpcRequestsPerSecond := 4
    static RpcIncomingConnections := 5
    static RpcIncomingBandwidth := 6
    static RpcOutgoingBandwidth := 7
    static RpcAttemptedLbsDecisions := 8
    static RpcFailedLbsDecisions := 9
    static RpcAttemptedLbsMessages := 10
    static RpcFailedLbsMessages := 11
    static RpcLastCounter := 12
}
struct I_RpcProxyUpdatePerfCounterFn extends FunctionPointer {
    static Types := [RpcPerfCounters, Int32, UInt32, "Void"]
}
struct I_RpcProxyUpdatePerfCounterBackendServerFn extends FunctionPointer {
    static Types := [UInt16.Ptr, Int32, "Void"]
}
struct I_RpcProxyCallbackInterface {
    IsValidMachineFn : I_RpcProxyIsValidMachineFn
    GetClientAddressFn : I_RpcProxyGetClientAddressFn
    GetConnectionTimeoutFn : I_RpcProxyGetConnectionTimeoutFn
    PerformCalloutFn : I_RpcPerformCalloutFn
    FreeCalloutStateFn : I_RpcFreeCalloutStateFn
    GetClientSessionAndResourceUUIDFn : I_RpcProxyGetClientSessionAndResourceUUID
    ProxyFilterIfFn : I_RpcProxyFilterIfFn
    RpcProxyUpdatePerfCounterFn : I_RpcProxyUpdatePerfCounterFn
    RpcProxyUpdatePerfCounterBackendServerFn : I_RpcProxyUpdatePerfCounterBackendServerFn
}
struct RPC_NOTIFICATION_TYPES extends Int32 {
    static RpcNotificationTypeNone := 0
    static RpcNotificationTypeEvent := 1
    static RpcNotificationTypeApc := 2
    static RpcNotificationTypeIoc := 3
    static RpcNotificationTypeHwnd := 4
    static RpcNotificationTypeCallback := 5
}
struct RPC_ASYNC_EVENT extends Int32 {
    static RpcCallComplete := 0
    static RpcSendComplete := 1
    static RpcReceiveComplete := 2
    static RpcClientDisconnect := 3
    static RpcClientCancel := 4
}
struct PFN_RPCNOTIFICATION_ROUTINE extends FunctionPointer {
    static Types := [RPC_ASYNC_STATE.Ptr, Struct.Ptr, RPC_ASYNC_EVENT, "Void"]
}
struct RPC_ASYNC_NOTIFICATION_INFO {
    union {
        APC : this._APC_e__Struct
        IOC : this._IOC_e__Struct
        IntPtr : this._IntPtr_e__Struct
        hEvent : HANDLE
        NotificationRoutine : PFN_RPCNOTIFICATION_ROUTINE
    }
    struct _APC_e__Struct {
        NotificationRoutine : PFN_RPCNOTIFICATION_ROUTINE
        hThread : HANDLE
    }
    struct _IOC_e__Struct {
        hIOPort : HANDLE
        dwNumberOfBytesTransferred : UInt32
        dwCompletionKey : IntPtr
        lpOverlapped : OVERLAPPED.Ptr
    }
    struct _IntPtr_e__Struct {
        hWnd : HWND
        Msg : UInt32
    }
}
struct RPC_ASYNC_STATE {
    Size : UInt32
    Signature : UInt32
    Lock : Int32
    Flags : UInt32
    StubInfo : Struct.Ptr
    UserInfo : Struct.Ptr
    RuntimeInfo : Struct.Ptr
    Event : RPC_ASYNC_EVENT
    NotificationType : RPC_NOTIFICATION_TYPES
    u : RPC_ASYNC_NOTIFICATION_INFO
    Reserved : IntPtr[4]
}
struct ExtendedErrorParamTypes extends Int32 {
    static eeptAnsiString := 1
    static eeptUnicodeString := 2
    static eeptLongVal := 3
    static eeptShortVal := 4
    static eeptPointerVal := 5
    static eeptNone := 6
    static eeptBinary := 7
}
struct BinaryParam {
    Buffer : Struct.Ptr
    Size : Int16
}
struct RPC_EE_INFO_PARAM {
    ParameterType : ExtendedErrorParamTypes
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            AnsiString : PSTR
            UnicodeString : PWSTR
            LVal : Int32
            SVal : Int16
            PVal : Int64
            BVal : BinaryParam
        }
    }
}
struct RPC_EXTENDED_ERROR_INFO {
    Version : UInt32
    ComputerName : PWSTR
    ProcessID : UInt32
    u : this._u_e__Union
    GeneratingComponent : UInt32
    Status : UInt32
    DetectionLocation : UInt16
    Flags : UInt16
    NumberOfParameters : Int32
    Parameters : RPC_EE_INFO_PARAM[4]
    struct _u_e__Union {
        union {
            SystemTime : SYSTEMTIME
            FileTime : FILETIME
        }
    }
}
struct RPC_ERROR_ENUM_HANDLE {
    Signature : UInt32
    CurrentPos : Struct.Ptr
    Head : Struct.Ptr
}
struct RpcLocalAddressFormat extends Int32 {
    static rlafInvalid := 0
    static rlafIPv4 := 1
    static rlafIPv6 := 2
}
struct RPC_CALL_LOCAL_ADDRESS_V1 {
    Version : UInt32
    Buffer : Struct.Ptr
    BufferSize : UInt32
    AddressFormat : RpcLocalAddressFormat
}
struct RPC_CALL_ATTRIBUTES_V1_W {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt16.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt16.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
}
struct RPC_CALL_ATTRIBUTES_V1_A {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt8.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt8.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
}
struct RpcCallType extends Int32 {
    static rctInvalid := 0
    static rctNormal := 1
    static rctTraining := 2
    static rctGuaranteed := 3
}
struct RpcCallClientLocality extends Int32 {
    static rcclInvalid := 0
    static rcclLocal := 1
    static rcclRemote := 2
    static rcclClientUnknownLocality := 3
}
struct RPC_CALL_ATTRIBUTES_V2_W {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt16.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt16.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
    KernelModeCaller : BOOL
    ProtocolSequence : UInt32
    IsClientLocal : RpcCallClientLocality
    ClientPID : HANDLE
    CallStatus : UInt32
    CallType : RpcCallType
    CallLocalAddress : RPC_CALL_LOCAL_ADDRESS_V1.Ptr
    OpNum : UInt16
    InterfaceUuid : GUID
}
struct RPC_CALL_ATTRIBUTES_V2_A {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt8.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt8.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
    KernelModeCaller : BOOL
    ProtocolSequence : UInt32
    IsClientLocal : UInt32
    ClientPID : HANDLE
    CallStatus : UInt32
    CallType : RpcCallType
    CallLocalAddress : RPC_CALL_LOCAL_ADDRESS_V1.Ptr
    OpNum : UInt16
    InterfaceUuid : GUID
}
struct RPC_CALL_ATTRIBUTES_V3_W {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt16.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt16.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
    KernelModeCaller : BOOL
    ProtocolSequence : UInt32
    IsClientLocal : RpcCallClientLocality
    ClientPID : HANDLE
    CallStatus : UInt32
    CallType : RpcCallType
    CallLocalAddress : RPC_CALL_LOCAL_ADDRESS_V1.Ptr
    OpNum : UInt16
    InterfaceUuid : GUID
    ClientIdentifierBufferLength : UInt32
    ClientIdentifier : UInt8.Ptr
}
struct RPC_CALL_ATTRIBUTES_V3_A {
    Version : UInt32
    Flags : UInt32
    ServerPrincipalNameBufferLength : UInt32
    ServerPrincipalName : UInt8.Ptr
    ClientPrincipalNameBufferLength : UInt32
    ClientPrincipalName : UInt8.Ptr
    AuthenticationLevel : UInt32
    AuthenticationService : UInt32
    NullSession : BOOL
    KernelModeCaller : BOOL
    ProtocolSequence : UInt32
    IsClientLocal : UInt32
    ClientPID : HANDLE
    CallStatus : UInt32
    CallType : RpcCallType
    CallLocalAddress : RPC_CALL_LOCAL_ADDRESS_V1.Ptr
    OpNum : UInt16
    InterfaceUuid : GUID
    ClientIdentifierBufferLength : UInt32
    ClientIdentifier : UInt8.Ptr
}
struct RPC_NOTIFICATIONS extends Int32 {
    static RpcNotificationCallNone := 0
    static RpcNotificationClientDisconnect := 1
    static RpcNotificationCallCancel := 2
}
struct RPC_IMPORT_CONTEXT_P {
    LookupContext : Struct.Ptr
    ProposedHandle : Struct.Ptr
    Bindings : RPC_BINDING_VECTOR.Ptr
}
struct NDR_SCONTEXT {
    pad : Struct.Ptr[2]
    userContext : Struct.Ptr
}
struct NDR_RUNDOWN extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct NDR_NOTIFY_ROUTINE extends FunctionPointer {
    static Types := ["Void"]
}
struct NDR_NOTIFY2_ROUTINE extends FunctionPointer {
    static Types := [UInt8, "Void"]
}
struct SCONTEXT_QUEUE {
    NumberOfObjects : UInt32
    ArrayOfObjects : NDR_SCONTEXT.Ptr.Ptr
}
struct EXPR_EVAL extends FunctionPointer {
    static Types := [MIDL_STUB_MESSAGE.Ptr, "Void"]
}
struct ARRAY_INFO {
    Dimension : Int32
    BufferConformanceMark : UInt32.Ptr
    BufferVarianceMark : UInt32.Ptr
    MaxCountArray : UInt32.Ptr
    OffsetArray : UInt32.Ptr
    ActualCountArray : UInt32.Ptr
}
struct MIDL_STUB_MESSAGE {
    RpcMsg : RPC_MESSAGE.Ptr
    Buffer : UInt8.Ptr
    BufferStart : UInt8.Ptr
    BufferEnd : UInt8.Ptr
    BufferMark : UInt8.Ptr
    BufferLength : UInt32
    MemorySize : UInt32
    Memory : UInt8.Ptr
    IsClient : UInt8
    Pad : UInt8
    uFlags2 : UInt16
    ReuseBuffer : Int32
    pAllocAllNodesContext : NDR_ALLOC_ALL_NODES_CONTEXT.Ptr
    pPointerQueueState : NDR_POINTER_QUEUE_STATE.Ptr
    IgnoreEmbeddedPointers : Int32
    PointerBufferMark : UInt8.Ptr
    CorrDespIncrement : UInt8
    uFlags : UInt8
    UniquePtrCount : UInt16
    MaxCount : IntPtr
    Offset : UInt32
    ActualCount : UInt32
    pfnAllocate : PFN_RPC_ALLOCATE
    pfnFree : PFN_RPC_FREE
    StackTop : UInt8.Ptr
    pPresentedType : UInt8.Ptr
    pTransmitType : UInt8.Ptr
    SavedHandle : Struct.Ptr
    StubDesc : MIDL_STUB_DESC.Ptr
    FullPtrXlatTables : FULL_PTR_XLAT_TABLES.Ptr
    FullPtrRefId : UInt32
    PointerLength : UInt32
    _bitfield : UInt32
    dwDestContext : UInt32
    pvDestContext : Struct.Ptr
    SavedContextHandles : NDR_SCONTEXT.Ptr.Ptr
    ParamNumber : Int32
    pRpcChannelBuffer : IRpcChannelBuffer
    pArrayInfo : ARRAY_INFO.Ptr
    SizePtrCountArray : UInt32.Ptr
    SizePtrOffsetArray : UInt32.Ptr
    SizePtrLengthArray : UInt32.Ptr
    pArgQueue : Struct.Ptr
    dwStubPhase : UInt32
    LowStackMark : Struct.Ptr
    pAsyncMsg : PNDR_ASYNC_MESSAGE
    pCorrInfo : PNDR_CORRELATION_INFO
    pCorrMemory : UInt8.Ptr
    pMemoryList : Struct.Ptr
    pCSInfo : IntPtr
    ConformanceMark : UInt8.Ptr
    VarianceMark : UInt8.Ptr
    Unused : IntPtr
    pContext : NDR_PROC_CONTEXT.Ptr
    ContextHandleHash : Struct.Ptr
    pUserMarshalList : Struct.Ptr
    pFullPtrFormat : UInt8.Ptr
    Reserved51_4 : IntPtr
    Reserved51_5 : IntPtr
}
struct GENERIC_BINDING_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr]
}
struct GENERIC_UNBIND_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, "Void"]
}
struct GENERIC_BINDING_ROUTINE_PAIR {
    pfnBind : GENERIC_BINDING_ROUTINE
    pfnUnbind : GENERIC_UNBIND_ROUTINE
}
struct GENERIC_BINDING_INFO {
    pObj : Struct.Ptr
    Size : UInt32
    pfnBind : GENERIC_BINDING_ROUTINE
    pfnUnbind : GENERIC_UNBIND_ROUTINE
}
struct XMIT_HELPER_ROUTINE extends FunctionPointer {
    static Types := [MIDL_STUB_MESSAGE.Ptr, "Void"]
}
struct XMIT_ROUTINE_QUINTUPLE {
    pfnTranslateToXmit : XMIT_HELPER_ROUTINE
    pfnTranslateFromXmit : XMIT_HELPER_ROUTINE
    pfnFreeXmit : XMIT_HELPER_ROUTINE
    pfnFreeInst : XMIT_HELPER_ROUTINE
}
struct USER_MARSHAL_SIZING_ROUTINE extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct USER_MARSHAL_MARSHALLING_ROUTINE extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt8.Ptr, Struct.Ptr, UInt8.Ptr]
}
struct USER_MARSHAL_UNMARSHALLING_ROUTINE extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt8.Ptr, Struct.Ptr, UInt8.Ptr]
}
struct USER_MARSHAL_FREEING_ROUTINE extends FunctionPointer {
    static Types := [UInt32.Ptr, Struct.Ptr, "Void"]
}
struct USER_MARSHAL_ROUTINE_QUADRUPLE {
    pfnBufferSize : USER_MARSHAL_SIZING_ROUTINE
    pfnMarshall : USER_MARSHAL_MARSHALLING_ROUTINE
    pfnUnmarshall : USER_MARSHAL_UNMARSHALLING_ROUTINE
    pfnFree : USER_MARSHAL_FREEING_ROUTINE
}
struct USER_MARSHAL_CB_TYPE extends Int32 {
    static USER_MARSHAL_CB_BUFFER_SIZE := 0
    static USER_MARSHAL_CB_MARSHALL := 1
    static USER_MARSHAL_CB_UNMARSHALL := 2
    static USER_MARSHAL_CB_FREE := 3
}
struct USER_MARSHAL_CB {
    Flags : UInt32
    pStubMsg : MIDL_STUB_MESSAGE.Ptr
    pReserve : UInt8.Ptr
    Signature : UInt32
    CBType : USER_MARSHAL_CB_TYPE
    pFormat : UInt8.Ptr
    pTypeFormat : UInt8.Ptr
}
struct MALLOC_FREE_STRUCT {
    pfnAllocate : IntPtr
    pfnFree : IntPtr
}
struct COMM_FAULT_OFFSETS {
    CommOffset : Int16
    FaultOffset : Int16
}
struct IDL_CS_CONVERT extends Int32 {
    static IDL_CS_NO_CONVERT := 0
    static IDL_CS_IN_PLACE_CONVERT := 1
    static IDL_CS_NEW_BUFFER_CONVERT := 2
}
struct CS_TYPE_NET_SIZE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, IDL_CS_CONVERT.Ptr, UInt32.Ptr, UInt32.Ptr, "Void"]
}
struct CS_TYPE_LOCAL_SIZE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, IDL_CS_CONVERT.Ptr, UInt32.Ptr, UInt32.Ptr, "Void"]
}
struct CS_TYPE_TO_NETCS_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt8.Ptr, UInt32.Ptr, UInt32.Ptr, "Void"]
}
struct CS_TYPE_FROM_NETCS_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, Struct.Ptr, UInt32.Ptr, UInt32.Ptr, "Void"]
}
struct CS_TAG_GETTING_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, "Void"]
}
struct NDR_CS_SIZE_CONVERT_ROUTINES {
    pfnNetSize : CS_TYPE_NET_SIZE_ROUTINE
    pfnToNetCs : CS_TYPE_TO_NETCS_ROUTINE
    pfnLocalSize : CS_TYPE_LOCAL_SIZE_ROUTINE
    pfnFromNetCs : CS_TYPE_FROM_NETCS_ROUTINE
}
struct NDR_CS_ROUTINES {
    pSizeConvertRoutines : NDR_CS_SIZE_CONVERT_ROUTINES.Ptr
    pTagGettingRoutines : CS_TAG_GETTING_ROUTINE.Ptr
}
struct NDR_EXPR_DESC {
    pOffset : UInt16.Ptr
    pFormatExpr : UInt8.Ptr
}
struct MIDL_STUB_DESC {
    RpcInterfaceInformation : Struct.Ptr
    pfnAllocate : PFN_RPC_ALLOCATE
    pfnFree : PFN_RPC_FREE
    IMPLICIT_HANDLE_INFO : this._IMPLICIT_HANDLE_INFO_e__Union
    apfnNdrRundownRoutines : NDR_RUNDOWN.Ptr
    aGenericBindingRoutinePairs : GENERIC_BINDING_ROUTINE_PAIR.Ptr
    apfnExprEval : EXPR_EVAL.Ptr
    aXmitQuintuple : XMIT_ROUTINE_QUINTUPLE.Ptr
    pFormatTypes : UInt8.Ptr
    fCheckBounds : Int32
    Version : UInt32
    pMallocFreeStruct : MALLOC_FREE_STRUCT.Ptr
    MIDLVersion : Int32
    CommFaultOffsets : COMM_FAULT_OFFSETS.Ptr
    aUserMarshalQuadruple : USER_MARSHAL_ROUTINE_QUADRUPLE.Ptr
    NotifyRoutineTable : NDR_NOTIFY_ROUTINE.Ptr
    mFlags : IntPtr
    CsRoutineTables : NDR_CS_ROUTINES.Ptr
    ProxyServerInfo : Struct.Ptr
    pExprInfo : NDR_EXPR_DESC.Ptr
    struct _IMPLICIT_HANDLE_INFO_e__Union {
        union {
            pAutoHandle : Struct.Ptr.Ptr
            pPrimitiveHandle : Struct.Ptr.Ptr
            pGenericBindingInfo : GENERIC_BINDING_INFO.Ptr
        }
    }
}
struct MIDL_FORMAT_STRING {
    Pad : Int16
    Format : UInt8[1]
}
struct STUB_THUNK extends FunctionPointer {
    static Types := [MIDL_STUB_MESSAGE.Ptr, "Void"]
}
struct SERVER_ROUTINE extends FunctionPointer {
    static Types := [Int32]
}
struct MIDL_METHOD_PROPERTY {
    Id : UInt32
    Value : IntPtr
}
struct MIDL_METHOD_PROPERTY_MAP {
    Count : UInt32
    Properties : MIDL_METHOD_PROPERTY.Ptr
}
struct MIDL_INTERFACE_METHOD_PROPERTIES {
    MethodCount : UInt16
    MethodProperties : MIDL_METHOD_PROPERTY_MAP.Ptr.Ptr
}
struct MIDL_SERVER_INFO {
    pStubDesc : MIDL_STUB_DESC.Ptr
    DispatchTable : SERVER_ROUTINE.Ptr
    ProcString : UInt8.Ptr
    FmtStringOffset : UInt16.Ptr
    ThunkTable : STUB_THUNK.Ptr
    pTransferSyntax : RPC_SYNTAX_IDENTIFIER.Ptr
    nCount : IntPtr
    pSyntaxInfo : MIDL_SYNTAX_INFO.Ptr
}
struct MIDL_STUBLESS_PROXY_INFO {
    pStubDesc : MIDL_STUB_DESC.Ptr
    ProcFormatString : UInt8.Ptr
    FormatStringOffset : UInt16.Ptr
    pTransferSyntax : RPC_SYNTAX_IDENTIFIER.Ptr
    nCount : IntPtr
    pSyntaxInfo : MIDL_SYNTAX_INFO.Ptr
}
struct MIDL_SYNTAX_INFO {
    TransferSyntax : RPC_SYNTAX_IDENTIFIER
    DispatchTable : RPC_DISPATCH_TABLE.Ptr
    ProcString : UInt8.Ptr
    FmtStringOffset : UInt16.Ptr
    TypeString : UInt8.Ptr
    aUserMarshalQuadruple : Struct.Ptr
    pMethodProperties : MIDL_INTERFACE_METHOD_PROPERTIES.Ptr
    pReserved2 : IntPtr
}
struct CLIENT_CALL_RETURN {
    union {
        Pointer : Struct.Ptr
        Simple : IntPtr
    }
}
struct XLAT_SIDE extends Int32 {
    static XLAT_SERVER := 1
    static XLAT_CLIENT := 2
}
struct FULL_PTR_XLAT_TABLES {
    RefIdToPointer : Struct.Ptr
    PointerToRefId : Struct.Ptr
    NextRefId : UInt32
    XlatSide : XLAT_SIDE
}
struct system_handle_t extends Int32 {
    static SYSTEM_HANDLE_FILE := 0
    static SYSTEM_HANDLE_SEMAPHORE := 1
    static SYSTEM_HANDLE_EVENT := 2
    static SYSTEM_HANDLE_MUTEX := 3
    static SYSTEM_HANDLE_PROCESS := 4
    static SYSTEM_HANDLE_TOKEN := 5
    static SYSTEM_HANDLE_SECTION := 6
    static SYSTEM_HANDLE_REG_KEY := 7
    static SYSTEM_HANDLE_THREAD := 8
    static SYSTEM_HANDLE_COMPOSITION_OBJECT := 9
    static SYSTEM_HANDLE_SOCKET := 10
    static SYSTEM_HANDLE_JOB := 11
    static SYSTEM_HANDLE_PIPE := 12
    static SYSTEM_HANDLE_MAX := 12
    static SYSTEM_HANDLE_INVALID := 255
}
struct MIDL_INTERCEPTION_INFO {
    Version : UInt32
    ProcString : UInt8.Ptr
    ProcFormatOffsetTable : UInt16.Ptr
    ProcCount : UInt32
    TypeString : UInt8.Ptr
}
struct MIDL_WINRT_TYPE_SERIALIZATION_INFO {
    Version : UInt32
    TypeFormatString : UInt8.Ptr
    FormatStringSize : UInt16
    TypeOffset : UInt16
    StubDesc : MIDL_STUB_DESC.Ptr
}
struct STUB_PHASE extends Int32 {
    static STUB_UNMARSHAL := 0
    static STUB_CALL_SERVER := 1
    static STUB_MARSHAL := 2
    static STUB_CALL_SERVER_NO_HRESULT := 3
}
struct PROXY_PHASE extends Int32 {
    static PROXY_CALCSIZE := 0
    static PROXY_GETBUFFER := 1
    static PROXY_MARSHAL := 2
    static PROXY_SENDRECEIVE := 3
    static PROXY_UNMARSHAL := 4
}
struct RPC_CLIENT_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct RPC_CLIENT_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct NDR_USER_MARSHAL_INFO_LEVEL1 {
    Buffer : Struct.Ptr
    BufferSize : UInt32
    pfnAllocate : IntPtr
    pfnFree : IntPtr
    pRpcChannelBuffer : IRpcChannelBuffer
    Reserved : IntPtr[5]
}
struct NDR_USER_MARSHAL_INFO {
    InformationLevel : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Level1 : NDR_USER_MARSHAL_INFO_LEVEL1
        }
    }
}
struct MIDL_ES_CODE extends Int32 {
    static MES_ENCODE := 0
    static MES_DECODE := 1
    static MES_ENCODE_NDR64 := 2
}
struct MIDL_ES_HANDLE_STYLE extends Int32 {
    static MES_INCREMENTAL_HANDLE := 0
    static MES_FIXED_BUFFER_HANDLE := 1
    static MES_DYNAMIC_BUFFER_HANDLE := 2
}
struct MIDL_ES_ALLOC extends FunctionPointer {
    static Types := [Struct.Ptr, Int8.Ptr.Ptr, UInt32.Ptr, "Void"]
}
struct MIDL_ES_WRITE extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt32, "Void"]
}
struct MIDL_ES_READ extends FunctionPointer {
    static Types := [Struct.Ptr, Int8.Ptr.Ptr, UInt32.Ptr, "Void"]
}
struct MIDL_TYPE_PICKLING_INFO {
    Version : UInt32
    Flags : UInt32
    Reserved : IntPtr[3]
}
struct NDR64_PROC_FLAGS {
    _bitfield : UInt32
}
struct NDR64_RPC_FLAGS {
    _bitfield : UInt16
}
struct NDR64_PROC_FORMAT {
    Flags : UInt32
    StackSize : UInt32
    ConstantClientBufferSize : UInt32
    ConstantServerBufferSize : UInt32
    RpcFlags : UInt16
    FloatDoubleMask : UInt16
    NumberOfParams : UInt16
    ExtensionSize : UInt16
}
struct NDR64_PARAM_FLAGS {
    _bitfield : UInt16
}
struct NDR64_PARAM_FORMAT {
    Type : Struct.Ptr
    Attributes : NDR64_PARAM_FLAGS
    Reserved : UInt16
    StackOffset : UInt32
}
struct NDR64_RANGE_FORMAT {
    FormatCode : UInt8
    RangeType : UInt8
    Reserved : UInt16
    MinValue : Int64
    MaxValue : Int64
}
struct NDR64_CONTEXT_HANDLE_FLAGS {
    _bitfield : UInt8
}
struct NDR64_CONTEXT_HANDLE_FORMAT {
    FormatCode : UInt8
    ContextFlags : UInt8
    RundownRoutineIndex : UInt8
    Ordinal : UInt8
}
struct NDR64_BIND_PRIMITIVE {
    HandleType : UInt8
    Flags : UInt8
    StackOffset : UInt16
    Reserved : UInt16
}
struct NDR64_BIND_GENERIC {
    HandleType : UInt8
    Flags : UInt8
    StackOffset : UInt16
    RoutineIndex : UInt8
    Size : UInt8
}
struct NDR64_BIND_CONTEXT {
    HandleType : UInt8
    Flags : UInt8
    StackOffset : UInt16
    RoutineIndex : UInt8
    Ordinal : UInt8
}
struct NDR64_BINDINGS {
    union {
        Primitive : NDR64_BIND_PRIMITIVE
        Generic : NDR64_BIND_GENERIC
        Context : NDR64_BIND_CONTEXT
    }
}
struct NDR64_BIND_AND_NOTIFY_EXTENSION {
    Binding : NDR64_BIND_CONTEXT
    NotifyIndex : UInt16
}
struct NDR64_SYSTEM_HANDLE_FORMAT {
    FormatCode : UInt8
    HandleType : UInt8
    DesiredAccess : UInt32
}
struct NDR64_POINTER_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Reserved : UInt16
    Pointee : Struct.Ptr
}
struct NDR64_NO_REPEAT_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Reserved1 : UInt16
    Reserved2 : UInt32
}
struct NDR64_POINTER_INSTANCE_HEADER_FORMAT {
    Offset : UInt32
    Reserved : UInt32
}
struct NDR64_POINTER_REPEAT_FLAGS {
    _bitfield : UInt8
}
struct NDR64_REPEAT_FORMAT {
    FormatCode : UInt8
    Flags : NDR64_POINTER_REPEAT_FLAGS
    Reserved : UInt16
    Increment : UInt32
    OffsetToArray : UInt32
    NumberOfPointers : UInt32
}
struct NDR64_FIXED_REPEAT_FORMAT {
    RepeatFormat : NDR64_REPEAT_FORMAT
    Iterations : UInt32
    Reserved : UInt32
}
struct NDR64_IID_FLAGS {
    _bitfield : UInt8
}
struct NDR64_CONSTANT_IID_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Reserved : UInt16
    Guid : GUID
}
struct NDR64_IID_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Reserved : UInt16
    IIDDescriptor : Struct.Ptr
}
struct NDR64_STRUCTURE_FLAGS {
    _bitfield : UInt8
}
struct NDR64_STRUCTURE_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_STRUCTURE_FLAGS
    Reserve : UInt8
    MemorySize : UInt32
}
struct NDR64_CONF_STRUCTURE_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_STRUCTURE_FLAGS
    Reserve : UInt8
    MemorySize : UInt32
    ArrayDescription : Struct.Ptr
}
struct NDR64_BOGUS_STRUCTURE_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_STRUCTURE_FLAGS
    Reserve : UInt8
    MemorySize : UInt32
    OriginalMemberLayout : Struct.Ptr
    OriginalPointerLayout : Struct.Ptr
    PointerLayout : Struct.Ptr
}
struct NDR64_CONF_BOGUS_STRUCTURE_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_STRUCTURE_FLAGS
    Dimensions : UInt8
    MemorySize : UInt32
    OriginalMemberLayout : Struct.Ptr
    OriginalPointerLayout : Struct.Ptr
    PointerLayout : Struct.Ptr
    ConfArrayDescription : Struct.Ptr
}
struct NDR64_SIMPLE_MEMBER_FORMAT {
    FormatCode : UInt8
    Reserved1 : UInt8
    Reserved2 : UInt16
    Reserved3 : UInt32
}
struct NDR64_MEMPAD_FORMAT {
    FormatCode : UInt8
    Reserve1 : UInt8
    MemPad : UInt16
    Reserved2 : UInt32
}
struct NDR64_EMBEDDED_COMPLEX_FORMAT {
    FormatCode : UInt8
    Reserve1 : UInt8
    Reserve2 : UInt16
    Type : Struct.Ptr
}
struct NDR64_BUFFER_ALIGN_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Reserved : UInt16
    Reserved2 : UInt32
}
struct NDR64_SIMPLE_REGION_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    RegionSize : UInt16
    Reserved : UInt32
}
struct NDR64_ENCAPSULATED_UNION {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : UInt8
    SwitchType : UInt8
    MemoryOffset : UInt32
    MemorySize : UInt32
    Reserved : UInt32
}
struct NDR64_NON_ENCAPSULATED_UNION {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : UInt8
    SwitchType : UInt8
    MemorySize : UInt32
    Switch : Struct.Ptr
    Reserved : UInt32
}
struct NDR64_UNION_ARM_SELECTOR {
    Reserved1 : UInt8
    Alignment : UInt8
    Reserved2 : UInt16
    Arms : UInt32
}
struct NDR64_UNION_ARM {
    CaseValue : Int64
    Type : Struct.Ptr
    Reserved : UInt32
}
struct NDR64_ARRAY_FLAGS {
    _bitfield : UInt8
}
struct NDR64_ARRAY_ELEMENT_INFO {
    ElementMemSize : UInt32
    Element : Struct.Ptr
}
struct NDR64_FIX_ARRAY_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_ARRAY_FLAGS
    Reserved : UInt8
    TotalSize : UInt32
}
struct NDR64_CONF_ARRAY_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_ARRAY_FLAGS
    Reserved : UInt8
    ElementSize : UInt32
    ConfDescriptor : Struct.Ptr
}
struct NDR64_CONF_VAR_ARRAY_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_ARRAY_FLAGS
    Reserved : UInt8
    ElementSize : UInt32
    ConfDescriptor : Struct.Ptr
    VarDescriptor : Struct.Ptr
}
struct NDR64_VAR_ARRAY_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_ARRAY_FLAGS
    Reserved : UInt8
    TotalSize : UInt32
    ElementSize : UInt32
    VarDescriptor : Struct.Ptr
}
struct NDR64_BOGUS_ARRAY_HEADER_FORMAT {
    FormatCode : UInt8
    Alignment : UInt8
    Flags : NDR64_ARRAY_FLAGS
    NumberDims : UInt8
    NumberElements : UInt32
    Element : Struct.Ptr
}
struct NDR64_CONF_VAR_BOGUS_ARRAY_HEADER_FORMAT {
    FixedArrayFormat : NDR64_BOGUS_ARRAY_HEADER_FORMAT
    ConfDescription : Struct.Ptr
    VarDescription : Struct.Ptr
    OffsetDescription : Struct.Ptr
}
struct NDR64_STRING_FLAGS {
    _bitfield : UInt8
}
struct NDR64_STRING_HEADER_FORMAT {
    FormatCode : UInt8
    Flags : NDR64_STRING_FLAGS
    ElementSize : UInt16
}
struct NDR64_NON_CONFORMANT_STRING_FORMAT {
    Header : NDR64_STRING_HEADER_FORMAT
    TotalSize : UInt32
}
struct NDR64_RANGED_STRING_FORMAT {
    Header : NDR64_STRING_HEADER_FORMAT
    Reserved : UInt32
    Min : Int64
    Max : Int64
}
struct NDR64_CONFORMANT_STRING_FORMAT {
    Header : NDR64_STRING_HEADER_FORMAT
}
struct NDR64_SIZED_CONFORMANT_STRING_FORMAT {
    Header : NDR64_STRING_HEADER_FORMAT
    SizeDescription : Struct.Ptr
}
struct EXPR_TOKEN extends Int32 {
    static FC_EXPR_START := 0
    static FC_EXPR_ILLEGAL := 0
    static FC_EXPR_CONST32 := 1
    static FC_EXPR_CONST64 := 2
    static FC_EXPR_VAR := 3
    static FC_EXPR_OPER := 4
    static FC_EXPR_NOOP := 5
    static FC_EXPR_END := 6
}
struct NDR64_EXPR_OPERATOR {
    ExprType : UInt8
    Operator : UInt8
    CastType : UInt8
    Reserved : UInt8
}
struct NDR64_EXPR_CONST32 {
    ExprType : UInt8
    Reserved : UInt8
    Reserved1 : UInt16
    ConstValue : UInt32
}
struct NDR64_EXPR_CONST64 {
    ExprType : UInt8
    Reserved : UInt8
    Reserved1 : UInt16
    ConstValue : Int64
}
struct NDR64_EXPR_VAR {
    ExprType : UInt8
    VarType : UInt8
    Reserved : UInt16
    Offset : UInt32
}
struct NDR64_EXPR_NOOP {
    ExprType : UInt8
    Size : UInt8
    Reserved : UInt16
}
struct NDR64_TRANSMIT_AS_FLAGS {
    _bitfield : UInt8
}
struct NDR64_TRANSMIT_AS_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    RoutineIndex : UInt16
    TransmittedTypeWireAlignment : UInt16
    MemoryAlignment : UInt16
    PresentedTypeMemorySize : UInt32
    TransmittedTypeBufferSize : UInt32
    TransmittedType : Struct.Ptr
}
struct NDR64_USER_MARSHAL_FLAGS {
    _bitfield : UInt8
}
struct NDR64_USER_MARSHAL_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    RoutineIndex : UInt16
    TransmittedTypeWireAlignment : UInt16
    MemoryAlignment : UInt16
    UserTypeMemorySize : UInt32
    TransmittedTypeBufferSize : UInt32
    TransmittedType : Struct.Ptr
}
struct NDR64_PIPE_FLAGS {
    _bitfield : UInt8
}
struct NDR64_PIPE_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Alignment : UInt8
    Reserved : UInt8
    Type : Struct.Ptr
    MemorySize : UInt32
    BufferSize : UInt32
}
struct NDR64_RANGE_PIPE_FORMAT {
    FormatCode : UInt8
    Flags : UInt8
    Alignment : UInt8
    Reserved : UInt8
    Type : Struct.Ptr
    MemorySize : UInt32
    BufferSize : UInt32
    MinValue : UInt32
    MaxValue : UInt32
}
struct NDR64_TYPE_STRICT_CONTEXT_HANDLE {
    FormatCode : UInt8
    RealFormatCode : UInt8
    Reserved : UInt16
    Type : Struct.Ptr
    CtxtFlags : UInt32
    CtxtID : UInt32
}
