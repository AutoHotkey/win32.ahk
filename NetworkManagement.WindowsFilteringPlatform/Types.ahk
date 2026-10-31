#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, PSTR, PWSTR}
#Import "..\Security\Types.ahk" {SID, SID_AND_ATTRIBUTES}

struct IPSEC_SA_BUNDLE_FLAGS extends UInt32 {
    static IPSEC_SA_BUNDLE_FLAG_ND_SECURE := 1
    static IPSEC_SA_BUNDLE_FLAG_ND_BOUNDARY := 2
    static IPSEC_SA_BUNDLE_FLAG_ND_PEER_NAT_BOUNDARY := 4
    static IPSEC_SA_BUNDLE_FLAG_GUARANTEE_ENCRYPTION := 8
    static IPSEC_SA_BUNDLE_FLAG_ALLOW_NULL_TARGET_NAME_MATCH := 512
    static IPSEC_SA_BUNDLE_FLAG_CLEAR_DF_ON_TUNNEL := 1024
    static IPSEC_SA_BUNDLE_FLAG_ASSUME_UDP_CONTEXT_OUTBOUND := 2048
    static IPSEC_SA_BUNDLE_FLAG_ND_PEER_BOUNDARY := 4096
    static IPSEC_SA_BUNDLE_FLAG_SUPPRESS_DUPLICATE_DELETION := 8192
    static IPSEC_SA_BUNDLE_FLAG_PEER_SUPPORTS_GUARANTEE_ENCRYPTION := 16384
}
struct IPSEC_POLICY_FLAG extends UInt32 {
    static IPSEC_POLICY_FLAG_ND_SECURE := 2
    static IPSEC_POLICY_FLAG_ND_BOUNDARY := 4
    static IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_PEER_BEHIND_NAT := 16
    static IPSEC_POLICY_FLAG_NAT_ENCAP_ALLOW_GENERAL_NAT_TRAVERSAL := 32
    static IPSEC_POLICY_FLAG_DONT_NEGOTIATE_SECOND_LIFETIME := 64
    static IPSEC_POLICY_FLAG_DONT_NEGOTIATE_BYTE_LIFETIME := 128
    static IPSEC_POLICY_FLAG_CLEAR_DF_ON_TUNNEL := 8
    static IPSEC_POLICY_FLAG_ENABLE_V6_IN_V4_TUNNELING := 256
    static IPSEC_POLICY_FLAG_ENABLE_SERVER_ADDR_ASSIGNMENT := 512
    static IPSEC_POLICY_FLAG_TUNNEL_ALLOW_OUTBOUND_CLEAR_CONNECTION := 1024
    static IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ALREADY_SECURE_CONNECTION := 2048
    static IPSEC_POLICY_FLAG_TUNNEL_BYPASS_ICMPV6 := 4096
    static IPSEC_POLICY_FLAG_KEY_MANAGER_ALLOW_DICTATE_KEY := 8192
}
struct IKEEXT_CERT_AUTH extends UInt32 {
    static IKEEXT_CERT_AUTH_FLAG_SSL_ONE_WAY := 1
    static IKEEXT_CERT_AUTH_ENABLE_CRL_CHECK_STRONG := 4
    static IKEEXT_CERT_AUTH_DISABLE_SSL_CERT_VALIDATION := 8
    static IKEEXT_CERT_AUTH_ALLOW_HTTP_CERT_LOOKUP := 16
    static IKEEXT_CERT_AUTH_URL_CONTAINS_BUNDLE := 32
}
struct IKEEXT_PRESHARED_KEY_AUTHENTICATION_FLAGS extends UInt32 {
    static IKEEXT_PSK_FLAG_LOCAL_AUTH_ONLY := 1
    static IKEEXT_PSK_FLAG_REMOTE_AUTH_ONLY := 2
}
struct IKEEXT_POLICY_FLAG extends UInt32 {
    static IKEEXT_POLICY_FLAG_DISABLE_DIAGNOSTICS := 1
    static IKEEXT_POLICY_FLAG_NO_MACHINE_LUID_VERIFY := 2
    static IKEEXT_POLICY_FLAG_NO_IMPERSONATION_LUID_VERIFY := 4
    static IKEEXT_POLICY_FLAG_ENABLE_OPTIONAL_DH := 8
}
struct FWPM_SUBSCRIPTION_FLAGS extends UInt32 {
    static FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_ADD := 1
    static FWPM_SUBSCRIPTION_FLAG_NOTIFY_ON_DELETE := 2
}
struct IKEEXT_CERT_FLAGS extends UInt32 {
    static IKEEXT_CERT_FLAG_ENABLE_ACCOUNT_MAPPING := 1
    static IKEEXT_CERT_FLAG_DISABLE_REQUEST_PAYLOAD := 2
    static IKEEXT_CERT_FLAG_USE_NAP_CERTIFICATE := 4
    static IKEEXT_CERT_FLAG_INTERMEDIATE_CA := 8
    static IKEEXT_CERT_FLAG_IGNORE_INIT_CERT_MAP_FAILURE := 16
    static IKEEXT_CERT_FLAG_PREFER_NAP_CERTIFICATE_OUTBOUND := 32
    static IKEEXT_CERT_FLAG_SELECT_NAP_CERTIFICATE := 64
    static IKEEXT_CERT_FLAG_VERIFY_NAP_CERTIFICATE := 128
    static IKEEXT_CERT_FLAG_FOLLOW_RENEWAL_CERTIFICATE := 256
}
struct IPSEC_DOSP_FLAGS extends UInt32 {
    static IPSEC_DOSP_FLAG_ENABLE_IKEV1 := 1
    static IPSEC_DOSP_FLAG_ENABLE_IKEV2 := 2
    static IPSEC_DOSP_FLAG_DISABLE_AUTHIP := 4
    static IPSEC_DOSP_FLAG_DISABLE_DEFAULT_BLOCK := 8
    static IPSEC_DOSP_FLAG_FILTER_BLOCK := 16
    static IPSEC_DOSP_FLAG_FILTER_EXEMPT := 32
}
struct IKEEXT_KERBEROS_AUTHENTICATION_FLAGS extends UInt32 {
    static IKEEXT_KERB_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION := 1
    static IKEEXT_KERB_AUTH_DONT_ACCEPT_EXPLICIT_CREDENTIALS := 2
}
struct IKEEXT_RESERVED_AUTHENTICATION_FLAGS extends UInt32 {
    static IKEEXT_RESERVED_AUTH_DISABLE_INITIATOR_TOKEN_GENERATION := 1
}
struct IKEEXT_EAP_AUTHENTICATION_FLAGS extends UInt32 {
    static IKEEXT_EAP_FLAG_LOCAL_AUTH_ONLY := 1
    static IKEEXT_EAP_FLAG_REMOTE_AUTH_ONLY := 2
}
struct FWPM_FILTER_FLAGS extends UInt32 {
    static FWPM_FILTER_FLAG_NONE := 0
    static FWPM_FILTER_FLAG_PERSISTENT := 1
    static FWPM_FILTER_FLAG_BOOTTIME := 2
    static FWPM_FILTER_FLAG_HAS_PROVIDER_CONTEXT := 4
    static FWPM_FILTER_FLAG_CLEAR_ACTION_RIGHT := 8
    static FWPM_FILTER_FLAG_PERMIT_IF_CALLOUT_UNREGISTERED := 16
    static FWPM_FILTER_FLAG_DISABLED := 32
    static FWPM_FILTER_FLAG_INDEXED := 64
}
struct FWP_ACTION_TYPE extends UInt32 {
    static FWP_ACTION_BLOCK := 4097
    static FWP_ACTION_PERMIT := 4098
    static FWP_ACTION_CALLOUT_TERMINATING := 20483
    static FWP_ACTION_CALLOUT_INSPECTION := 24580
    static FWP_ACTION_CALLOUT_UNKNOWN := 16389
    static FWP_ACTION_CONTINUE := 8198
    static FWP_ACTION_NONE := 7
    static FWP_ACTION_NONE_NO_MATCH := 8
}
struct FWPM_ENGINE_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_CALLOUT_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_CONNECTION_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_FILTER_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_LAYER_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_NET_EVENT_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_PROVIDER_CONTEXT_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_PROVIDER_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_SESSION_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWPM_SUBLAYER_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct IKEEXT_SA_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct IPSEC_DOSP_STATE_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct IPSEC_SA_CONTEXT_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct IPSEC_SA_ENUM_HANDLE {
    Value : Struct.Ptr
}
struct FWP_DIRECTION extends Int32 {
    static FWP_DIRECTION_OUTBOUND := 0
    static FWP_DIRECTION_INBOUND := 1
    static FWP_DIRECTION_MAX := 2
}
struct FWP_IP_VERSION extends Int32 {
    static FWP_IP_VERSION_V4 := 0
    static FWP_IP_VERSION_V6 := 1
    static FWP_IP_VERSION_NONE := 2
    static FWP_IP_VERSION_MAX := 3
}
struct FWP_AF extends Int32 {
    static FWP_AF_INET := 0
    static FWP_AF_INET6 := 1
    static FWP_AF_ETHER := 2
    static FWP_AF_NONE := 3
}
struct FWP_ETHER_ENCAP_METHOD extends Int32 {
    static FWP_ETHER_ENCAP_METHOD_ETHER_V2 := 0
    static FWP_ETHER_ENCAP_METHOD_SNAP := 1
    static FWP_ETHER_ENCAP_METHOD_SNAP_W_OUI_ZERO := 3
}
struct FWP_DATA_TYPE extends Int32 {
    static FWP_EMPTY := 0
    static FWP_UINT8 := 1
    static FWP_UINT16 := 2
    static FWP_UINT32 := 3
    static FWP_UINT64 := 4
    static FWP_INT8 := 5
    static FWP_INT16 := 6
    static FWP_INT32 := 7
    static FWP_INT64 := 8
    static FWP_FLOAT := 9
    static FWP_DOUBLE := 10
    static FWP_BYTE_ARRAY16_TYPE := 11
    static FWP_BYTE_BLOB_TYPE := 12
    static FWP_SID := 13
    static FWP_SECURITY_DESCRIPTOR_TYPE := 14
    static FWP_TOKEN_INFORMATION_TYPE := 15
    static FWP_TOKEN_ACCESS_INFORMATION_TYPE := 16
    static FWP_UNICODE_STRING_TYPE := 17
    static FWP_BYTE_ARRAY6_TYPE := 18
    static FWP_SINGLE_DATA_TYPE_MAX := 255
    static FWP_V4_ADDR_MASK := 256
    static FWP_V6_ADDR_MASK := 257
    static FWP_RANGE_TYPE := 258
    static FWP_DATA_TYPE_MAX := 259
}
struct FWP_BYTE_ARRAY6 {
    byteArray6 : UInt8[6]
}
struct FWP_BYTE_ARRAY16 {
    byteArray16 : UInt8[16]
}
struct FWP_BYTE_BLOB {
    size : UInt32
    data : UInt8.Ptr
}
struct FWP_TOKEN_INFORMATION {
    sidCount : UInt32
    sids : SID_AND_ATTRIBUTES.Ptr
    restrictedSidCount : UInt32
    restrictedSids : SID_AND_ATTRIBUTES.Ptr
}
struct FWP_VALUE0 {
    type : FWP_DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            uint8 : UInt8
            uint16 : UInt16
            uint32 : UInt32
            uint64 : Int64.Ptr
            int8 : Int8
            int16 : Int16
            int32 : Int32
            int64 : Int64.Ptr
            float32 : Float32
            double64 : Float64.Ptr
            byteArray16 : FWP_BYTE_ARRAY16.Ptr
            byteBlob : FWP_BYTE_BLOB.Ptr
            sid : SID.Ptr
            sd : FWP_BYTE_BLOB.Ptr
            tokenInformation : FWP_TOKEN_INFORMATION.Ptr
            tokenAccessInformation : FWP_BYTE_BLOB.Ptr
            unicodeString : PWSTR
            byteArray6 : FWP_BYTE_ARRAY6.Ptr
        }
    }
}
struct FWP_MATCH_TYPE extends Int32 {
    static FWP_MATCH_EQUAL := 0
    static FWP_MATCH_GREATER := 1
    static FWP_MATCH_LESS := 2
    static FWP_MATCH_GREATER_OR_EQUAL := 3
    static FWP_MATCH_LESS_OR_EQUAL := 4
    static FWP_MATCH_RANGE := 5
    static FWP_MATCH_FLAGS_ALL_SET := 6
    static FWP_MATCH_FLAGS_ANY_SET := 7
    static FWP_MATCH_FLAGS_NONE_SET := 8
    static FWP_MATCH_EQUAL_CASE_INSENSITIVE := 9
    static FWP_MATCH_NOT_EQUAL := 10
    static FWP_MATCH_PREFIX := 11
    static FWP_MATCH_NOT_PREFIX := 12
    static FWP_MATCH_TYPE_MAX := 13
}
struct FWP_V4_ADDR_AND_MASK {
    addr : UInt32
    mask : UInt32
}
struct FWP_V6_ADDR_AND_MASK {
    addr : UInt8[16]
    prefixLength : UInt8
}
struct FWP_RANGE0 {
    valueLow : FWP_VALUE0
    valueHigh : FWP_VALUE0
}
struct FWP_CONDITION_VALUE0 {
    type : FWP_DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            uint8 : UInt8
            uint16 : UInt16
            uint32 : UInt32
            uint64 : Int64.Ptr
            int8 : Int8
            int16 : Int16
            int32 : Int32
            int64 : Int64.Ptr
            float32 : Float32
            double64 : Float64.Ptr
            byteArray16 : FWP_BYTE_ARRAY16.Ptr
            byteBlob : FWP_BYTE_BLOB.Ptr
            sid : SID.Ptr
            sd : FWP_BYTE_BLOB.Ptr
            tokenInformation : FWP_TOKEN_INFORMATION.Ptr
            tokenAccessInformation : FWP_BYTE_BLOB.Ptr
            unicodeString : PWSTR
            byteArray6 : FWP_BYTE_ARRAY6.Ptr
            v4AddrMask : FWP_V4_ADDR_AND_MASK.Ptr
            v6AddrMask : FWP_V6_ADDR_AND_MASK.Ptr
            rangeValue : FWP_RANGE0.Ptr
        }
    }
}
struct FWP_NETWORK_CONNECTION_POLICY_SETTING_TYPE extends Int32 {
    static FWP_NETWORK_CONNECTION_POLICY_SOURCE_ADDRESS := 0
    static FWP_NETWORK_CONNECTION_POLICY_NEXT_HOP_INTERFACE := 1
    static FWP_NETWORK_CONNECTION_POLICY_NEXT_HOP := 2
    static FWP_NETWORK_CONNECTION_POLICY_MAX := 3
}
struct FWP_CLASSIFY_OPTION_TYPE extends Int32 {
    static FWP_CLASSIFY_OPTION_MULTICAST_STATE := 0
    static FWP_CLASSIFY_OPTION_LOOSE_SOURCE_MAPPING := 1
    static FWP_CLASSIFY_OPTION_UNICAST_LIFETIME := 2
    static FWP_CLASSIFY_OPTION_MCAST_BCAST_LIFETIME := 3
    static FWP_CLASSIFY_OPTION_SECURE_SOCKET_SECURITY_FLAGS := 4
    static FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_MM_POLICY_KEY := 5
    static FWP_CLASSIFY_OPTION_SECURE_SOCKET_AUTHIP_QM_POLICY_KEY := 6
    static FWP_CLASSIFY_OPTION_LOCAL_ONLY_MAPPING := 7
    static FWP_CLASSIFY_OPTION_MAX := 8
}
struct FWP_VSWITCH_NETWORK_TYPE extends Int32 {
    static FWP_VSWITCH_NETWORK_TYPE_UNKNOWN := 0
    static FWP_VSWITCH_NETWORK_TYPE_PRIVATE := 1
    static FWP_VSWITCH_NETWORK_TYPE_INTERNAL := 2
    static FWP_VSWITCH_NETWORK_TYPE_EXTERNAL := 3
}
struct FWP_FILTER_ENUM_TYPE extends Int32 {
    static FWP_FILTER_ENUM_FULLY_CONTAINED := 0
    static FWP_FILTER_ENUM_OVERLAPPING := 1
    static FWP_FILTER_ENUM_TYPE_MAX := 2
}
struct FWPM_DISPLAY_DATA0 {
    name : PWSTR
    description : PWSTR
}
struct IPSEC_VIRTUAL_IF_TUNNEL_INFO0 {
    virtualIfTunnelId : Int64
    trafficSelectorId : Int64
}
struct IKEEXT_KEY_MODULE_TYPE extends Int32 {
    static IKEEXT_KEY_MODULE_IKE := 0
    static IKEEXT_KEY_MODULE_AUTHIP := 1
    static IKEEXT_KEY_MODULE_IKEV2 := 2
    static IKEEXT_KEY_MODULE_MAX := 3
}
struct IKEEXT_AUTHENTICATION_METHOD_TYPE extends Int32 {
    static IKEEXT_PRESHARED_KEY := 0
    static IKEEXT_CERTIFICATE := 1
    static IKEEXT_KERBEROS := 2
    static IKEEXT_ANONYMOUS := 3
    static IKEEXT_SSL := 4
    static IKEEXT_NTLM_V2 := 5
    static IKEEXT_IPV6_CGA := 6
    static IKEEXT_CERTIFICATE_ECDSA_P256 := 7
    static IKEEXT_CERTIFICATE_ECDSA_P384 := 8
    static IKEEXT_SSL_ECDSA_P256 := 9
    static IKEEXT_SSL_ECDSA_P384 := 10
    static IKEEXT_EAP := 11
    static IKEEXT_RESERVED := 12
    static IKEEXT_AUTHENTICATION_METHOD_TYPE_MAX := 13
}
struct IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE extends Int32 {
    static IKEEXT_IMPERSONATION_NONE := 0
    static IKEEXT_IMPERSONATION_SOCKET_PRINCIPAL := 1
    static IKEEXT_IMPERSONATION_MAX := 2
}
struct IKEEXT_PRESHARED_KEY_AUTHENTICATION0 {
    presharedKey : FWP_BYTE_BLOB
}
struct IKEEXT_PRESHARED_KEY_AUTHENTICATION1 {
    presharedKey : FWP_BYTE_BLOB
    flags : IKEEXT_PRESHARED_KEY_AUTHENTICATION_FLAGS
}
struct IKEEXT_CERT_ROOT_CONFIG0 {
    certData : FWP_BYTE_BLOB
    flags : IKEEXT_CERT_FLAGS
}
struct IKEEXT_CERT_CONFIG_TYPE extends Int32 {
    static IKEEXT_CERT_CONFIG_EXPLICIT_TRUST_LIST := 0
    static IKEEXT_CERT_CONFIG_ENTERPRISE_STORE := 1
    static IKEEXT_CERT_CONFIG_TRUSTED_ROOT_STORE := 2
    static IKEEXT_CERT_CONFIG_UNSPECIFIED := 3
    static IKEEXT_CERT_CONFIG_TYPE_MAX := 4
}
struct IKEEXT_CERTIFICATE_AUTHENTICATION0 {
    inboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    outboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous2 : this._Anonymous2_e__Union
    flags : IKEEXT_CERT_AUTH
    struct _Anonymous1_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            inboundEnterpriseStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
            inboundTrustedRootStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
        struct _Anonymous_e__Struct {
            inboundRootArraySize : UInt32
            inboundRootArray : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            outboundEnterpriseStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
            outboundTrustedRootStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
        struct _Anonymous_e__Struct {
            outboundRootArraySize : UInt32
            outboundRootArray : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
    }
}
struct IKEEXT_CERTIFICATE_AUTHENTICATION1 {
    inboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    outboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous2 : this._Anonymous2_e__Union
    flags : IKEEXT_CERT_AUTH
    localCertLocationUrl : FWP_BYTE_BLOB
    struct _Anonymous1_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            inboundEnterpriseStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
            inboundTrustedRootStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
        struct _Anonymous_e__Struct {
            inboundRootArraySize : UInt32
            inboundRootArray : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            outboundEnterpriseStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
            outboundTrustedRootStoreConfig : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
        struct _Anonymous_e__Struct {
            outboundRootArraySize : UInt32
            outboundRootArray : IKEEXT_CERT_ROOT_CONFIG0.Ptr
        }
    }
}
struct IKEEXT_CERT_CRITERIA_NAME_TYPE extends Int32 {
    static IKEEXT_CERT_CRITERIA_DNS := 0
    static IKEEXT_CERT_CRITERIA_UPN := 1
    static IKEEXT_CERT_CRITERIA_RFC822 := 2
    static IKEEXT_CERT_CRITERIA_CN := 3
    static IKEEXT_CERT_CRITERIA_OU := 4
    static IKEEXT_CERT_CRITERIA_O := 5
    static IKEEXT_CERT_CRITERIA_DC := 6
    static IKEEXT_CERT_CRITERIA_NAME_TYPE_MAX := 7
}
struct IKEEXT_CERT_EKUS0 {
    numEku : UInt32
    eku : PSTR.Ptr
}
struct IKEEXT_CERT_NAME0 {
    nameType : IKEEXT_CERT_CRITERIA_NAME_TYPE
    certName : PWSTR
}
struct IKEEXT_CERTIFICATE_CRITERIA0 {
    certData : FWP_BYTE_BLOB
    certHash : FWP_BYTE_BLOB
    eku : IKEEXT_CERT_EKUS0.Ptr
    name : IKEEXT_CERT_NAME0.Ptr
    flags : UInt32
}
struct IKEEXT_CERTIFICATE_AUTHENTICATION2 {
    inboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    outboundConfigType : IKEEXT_CERT_CONFIG_TYPE
    Anonymous2 : this._Anonymous2_e__Union
    flags : IKEEXT_CERT_AUTH
    localCertLocationUrl : FWP_BYTE_BLOB
    struct _Anonymous1_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            Anonymous3 : this._Anonymous3_e__Struct
        }
        struct _Anonymous1_e__Struct {
            inboundRootArraySize : UInt32
            inboundRootCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
        struct _Anonymous2_e__Struct {
            inboundEnterpriseStoreArraySize : UInt32
            inboundEnterpriseStoreCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
        struct _Anonymous3_e__Struct {
            inboundRootStoreArraySize : UInt32
            inboundTrustedRootStoreCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            Anonymous3 : this._Anonymous3_e__Struct
        }
        struct _Anonymous1_e__Struct {
            outboundRootArraySize : UInt32
            outboundRootCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
        struct _Anonymous2_e__Struct {
            outboundEnterpriseStoreArraySize : UInt32
            outboundEnterpriseStoreCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
        struct _Anonymous3_e__Struct {
            outboundRootStoreArraySize : UInt32
            outboundTrustedRootStoreCriteria : IKEEXT_CERTIFICATE_CRITERIA0.Ptr
        }
    }
}
struct IKEEXT_IPV6_CGA_AUTHENTICATION0 {
    keyContainerName : PWSTR
    cspName : PWSTR
    cspType : UInt32
    cgaModifier : FWP_BYTE_ARRAY16
    cgaCollisionCount : UInt8
}
struct IKEEXT_KERBEROS_AUTHENTICATION0 {
    flags : IKEEXT_KERBEROS_AUTHENTICATION_FLAGS
}
struct IKEEXT_KERBEROS_AUTHENTICATION1 {
    flags : IKEEXT_KERBEROS_AUTHENTICATION_FLAGS
    proxyServer : PWSTR
}
struct IKEEXT_RESERVED_AUTHENTICATION0 {
    flags : IKEEXT_RESERVED_AUTHENTICATION_FLAGS
}
struct IKEEXT_NTLM_V2_AUTHENTICATION0 {
    flags : UInt32
}
struct IKEEXT_EAP_AUTHENTICATION0 {
    flags : IKEEXT_EAP_AUTHENTICATION_FLAGS
}
struct IKEEXT_AUTHENTICATION_METHOD0 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKeyAuthentication : IKEEXT_PRESHARED_KEY_AUTHENTICATION0
            certificateAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION0
            kerberosAuthentication : IKEEXT_KERBEROS_AUTHENTICATION0
            ntlmV2Authentication : IKEEXT_NTLM_V2_AUTHENTICATION0
            sslAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION0
            cgaAuthentication : IKEEXT_IPV6_CGA_AUTHENTICATION0
        }
    }
}
struct IKEEXT_AUTHENTICATION_METHOD1 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKeyAuthentication : IKEEXT_PRESHARED_KEY_AUTHENTICATION1
            certificateAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION1
            kerberosAuthentication : IKEEXT_KERBEROS_AUTHENTICATION0
            ntlmV2Authentication : IKEEXT_NTLM_V2_AUTHENTICATION0
            sslAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION1
            cgaAuthentication : IKEEXT_IPV6_CGA_AUTHENTICATION0
            eapAuthentication : IKEEXT_EAP_AUTHENTICATION0
        }
    }
}
struct IKEEXT_AUTHENTICATION_METHOD2 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKeyAuthentication : IKEEXT_PRESHARED_KEY_AUTHENTICATION1
            certificateAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION2
            kerberosAuthentication : IKEEXT_KERBEROS_AUTHENTICATION1
            reservedAuthentication : IKEEXT_RESERVED_AUTHENTICATION0
            ntlmV2Authentication : IKEEXT_NTLM_V2_AUTHENTICATION0
            sslAuthentication : IKEEXT_CERTIFICATE_AUTHENTICATION2
            cgaAuthentication : IKEEXT_IPV6_CGA_AUTHENTICATION0
            eapAuthentication : IKEEXT_EAP_AUTHENTICATION0
        }
    }
}
struct IKEEXT_CIPHER_TYPE extends Int32 {
    static IKEEXT_CIPHER_DES := 0
    static IKEEXT_CIPHER_3DES := 1
    static IKEEXT_CIPHER_AES_128 := 2
    static IKEEXT_CIPHER_AES_192 := 3
    static IKEEXT_CIPHER_AES_256 := 4
    static IKEEXT_CIPHER_AES_GCM_128_16ICV := 5
    static IKEEXT_CIPHER_AES_GCM_256_16ICV := 6
    static IKEEXT_CIPHER_TYPE_MAX := 7
}
struct IKEEXT_CIPHER_ALGORITHM0 {
    algoIdentifier : IKEEXT_CIPHER_TYPE
    keyLen : UInt32
    rounds : UInt32
}
struct IKEEXT_INTEGRITY_TYPE extends Int32 {
    static IKEEXT_INTEGRITY_MD5 := 0
    static IKEEXT_INTEGRITY_SHA1 := 1
    static IKEEXT_INTEGRITY_SHA_256 := 2
    static IKEEXT_INTEGRITY_SHA_384 := 3
    static IKEEXT_INTEGRITY_TYPE_MAX := 4
}
struct IKEEXT_INTEGRITY_ALGORITHM0 {
    algoIdentifier : IKEEXT_INTEGRITY_TYPE
}
struct IKEEXT_DH_GROUP extends Int32 {
    static IKEEXT_DH_GROUP_NONE := 0
    static IKEEXT_DH_GROUP_1 := 1
    static IKEEXT_DH_GROUP_2 := 2
    static IKEEXT_DH_GROUP_14 := 3
    static IKEEXT_DH_GROUP_2048 := 3
    static IKEEXT_DH_ECP_256 := 4
    static IKEEXT_DH_ECP_384 := 5
    static IKEEXT_DH_GROUP_24 := 6
    static IKEEXT_DH_GROUP_MAX := 7
}
struct IKEEXT_PROPOSAL0 {
    cipherAlgorithm : IKEEXT_CIPHER_ALGORITHM0
    integrityAlgorithm : IKEEXT_INTEGRITY_ALGORITHM0
    maxLifetimeSeconds : UInt32
    dhGroup : IKEEXT_DH_GROUP
    quickModeLimit : UInt32
}
struct IKEEXT_POLICY0 {
    softExpirationTime : UInt32
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD0.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    numIkeProposals : UInt32
    ikeProposals : IKEEXT_PROPOSAL0.Ptr
    flags : IKEEXT_POLICY_FLAG
    maxDynamicFilters : UInt32
}
struct IKEEXT_POLICY1 {
    softExpirationTime : UInt32
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD1.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    numIkeProposals : UInt32
    ikeProposals : IKEEXT_PROPOSAL0.Ptr
    flags : IKEEXT_POLICY_FLAG
    maxDynamicFilters : UInt32
    retransmitDurationSecs : UInt32
}
struct IKEEXT_POLICY2 {
    softExpirationTime : UInt32
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD2.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    numIkeProposals : UInt32
    ikeProposals : IKEEXT_PROPOSAL0.Ptr
    flags : IKEEXT_POLICY_FLAG
    maxDynamicFilters : UInt32
    retransmitDurationSecs : UInt32
}
struct IKEEXT_EM_POLICY0 {
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD0.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
}
struct IKEEXT_EM_POLICY1 {
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD1.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
}
struct IKEEXT_EM_POLICY2 {
    numAuthenticationMethods : UInt32
    authenticationMethods : IKEEXT_AUTHENTICATION_METHOD2.Ptr
    initiatorImpersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
}
struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0 {
    currentActiveMainModes : UInt32
    totalMainModesStarted : UInt32
    totalSuccessfulMainModes : UInt32
    totalFailedMainModes : UInt32
    totalResponderMainModes : UInt32
    currentNewResponderMainModes : UInt32
    currentActiveQuickModes : UInt32
    totalQuickModesStarted : UInt32
    totalSuccessfulQuickModes : UInt32
    totalFailedQuickModes : UInt32
    totalAcquires : UInt32
    totalReinitAcquires : UInt32
    currentActiveExtendedModes : UInt32
    totalExtendedModesStarted : UInt32
    totalSuccessfulExtendedModes : UInt32
    totalFailedExtendedModes : UInt32
    totalImpersonationExtendedModes : UInt32
    totalImpersonationMainModes : UInt32
}
struct IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1 {
    currentActiveMainModes : UInt32
    totalMainModesStarted : UInt32
    totalSuccessfulMainModes : UInt32
    totalFailedMainModes : UInt32
    totalResponderMainModes : UInt32
    currentNewResponderMainModes : UInt32
    currentActiveQuickModes : UInt32
    totalQuickModesStarted : UInt32
    totalSuccessfulQuickModes : UInt32
    totalFailedQuickModes : UInt32
    totalAcquires : UInt32
    totalReinitAcquires : UInt32
    currentActiveExtendedModes : UInt32
    totalExtendedModesStarted : UInt32
    totalSuccessfulExtendedModes : UInt32
    totalFailedExtendedModes : UInt32
    totalImpersonationExtendedModes : UInt32
    totalImpersonationMainModes : UInt32
}
struct IKEEXT_KEYMODULE_STATISTICS0 {
    v4Statistics : IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0
    v6Statistics : IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS0
    errorFrequencyTable : UInt32[97]
    mainModeNegotiationTime : UInt32
    quickModeNegotiationTime : UInt32
    extendedModeNegotiationTime : UInt32
}
struct IKEEXT_KEYMODULE_STATISTICS1 {
    v4Statistics : IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1
    v6Statistics : IKEEXT_IP_VERSION_SPECIFIC_KEYMODULE_STATISTICS1
    errorFrequencyTable : UInt32[97]
    mainModeNegotiationTime : UInt32
    quickModeNegotiationTime : UInt32
    extendedModeNegotiationTime : UInt32
}
struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0 {
    totalSocketReceiveFailures : UInt32
    totalSocketSendFailures : UInt32
}
struct IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1 {
    totalSocketReceiveFailures : UInt32
    totalSocketSendFailures : UInt32
}
struct IKEEXT_COMMON_STATISTICS0 {
    v4Statistics : IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0
    v6Statistics : IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS0
    totalPacketsReceived : UInt32
    totalInvalidPacketsReceived : UInt32
    currentQueuedWorkitems : UInt32
}
struct IKEEXT_COMMON_STATISTICS1 {
    v4Statistics : IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1
    v6Statistics : IKEEXT_IP_VERSION_SPECIFIC_COMMON_STATISTICS1
    totalPacketsReceived : UInt32
    totalInvalidPacketsReceived : UInt32
    currentQueuedWorkitems : UInt32
}
struct IKEEXT_STATISTICS0 {
    ikeStatistics : IKEEXT_KEYMODULE_STATISTICS0
    authipStatistics : IKEEXT_KEYMODULE_STATISTICS0
    commonStatistics : IKEEXT_COMMON_STATISTICS0
}
struct IKEEXT_STATISTICS1 {
    ikeStatistics : IKEEXT_KEYMODULE_STATISTICS1
    authipStatistics : IKEEXT_KEYMODULE_STATISTICS1
    ikeV2Statistics : IKEEXT_KEYMODULE_STATISTICS1
    commonStatistics : IKEEXT_COMMON_STATISTICS1
}
struct IKEEXT_TRAFFIC0 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    authIpFilterId : Int64
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
}
struct IKEEXT_COOKIE_PAIR0 {
    initiator : Int64
    responder : Int64
}
struct IKEEXT_CERTIFICATE_CREDENTIAL0 {
    subjectName : FWP_BYTE_BLOB
    certHash : FWP_BYTE_BLOB
    flags : UInt32
}
struct IKEEXT_NAME_CREDENTIAL0 {
    principalName : PWSTR
}
struct IKEEXT_CREDENTIAL0 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    impersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKey : IKEEXT_PRESHARED_KEY_AUTHENTICATION0.Ptr
            certificate : IKEEXT_CERTIFICATE_CREDENTIAL0.Ptr
            name : IKEEXT_NAME_CREDENTIAL0.Ptr
        }
    }
}
struct IKEEXT_CREDENTIAL_PAIR0 {
    localCredentials : IKEEXT_CREDENTIAL0
    peerCredentials : IKEEXT_CREDENTIAL0
}
struct IKEEXT_CREDENTIALS0 {
    numCredentials : UInt32
    credentials : IKEEXT_CREDENTIAL_PAIR0.Ptr
}
struct IKEEXT_SA_DETAILS0 {
    saId : Int64
    keyModuleType : IKEEXT_KEY_MODULE_TYPE
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    ikeTraffic : IKEEXT_TRAFFIC0
    ikeProposal : IKEEXT_PROPOSAL0
    cookiePair : IKEEXT_COOKIE_PAIR0
    ikeCredentials : IKEEXT_CREDENTIALS0
    ikePolicyKey : GUID
    virtualIfTunnelId : Int64
    struct _Anonymous_e__Union {
        union {
            v4UdpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IKEEXT_CERTIFICATE_CREDENTIAL1 {
    subjectName : FWP_BYTE_BLOB
    certHash : FWP_BYTE_BLOB
    flags : UInt32
    certificate : FWP_BYTE_BLOB
}
struct IKEEXT_CREDENTIAL1 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    impersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKey : IKEEXT_PRESHARED_KEY_AUTHENTICATION1.Ptr
            certificate : IKEEXT_CERTIFICATE_CREDENTIAL1.Ptr
            name : IKEEXT_NAME_CREDENTIAL0.Ptr
        }
    }
}
struct IKEEXT_CREDENTIAL_PAIR1 {
    localCredentials : IKEEXT_CREDENTIAL1
    peerCredentials : IKEEXT_CREDENTIAL1
}
struct IKEEXT_CREDENTIALS1 {
    numCredentials : UInt32
    credentials : IKEEXT_CREDENTIAL_PAIR1.Ptr
}
struct IKEEXT_SA_DETAILS1 {
    saId : Int64
    keyModuleType : IKEEXT_KEY_MODULE_TYPE
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    ikeTraffic : IKEEXT_TRAFFIC0
    ikeProposal : IKEEXT_PROPOSAL0
    cookiePair : IKEEXT_COOKIE_PAIR0
    ikeCredentials : IKEEXT_CREDENTIALS1
    ikePolicyKey : GUID
    virtualIfTunnelId : Int64
    correlationKey : FWP_BYTE_BLOB
    struct _Anonymous_e__Union {
        union {
            v4UdpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IKEEXT_CREDENTIAL2 {
    authenticationMethodType : IKEEXT_AUTHENTICATION_METHOD_TYPE
    impersonationType : IKEEXT_AUTHENTICATION_IMPERSONATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            presharedKey : IKEEXT_PRESHARED_KEY_AUTHENTICATION1.Ptr
            certificate : IKEEXT_CERTIFICATE_CREDENTIAL1.Ptr
            name : IKEEXT_NAME_CREDENTIAL0.Ptr
        }
    }
}
struct IKEEXT_CREDENTIAL_PAIR2 {
    localCredentials : IKEEXT_CREDENTIAL2
    peerCredentials : IKEEXT_CREDENTIAL2
}
struct IKEEXT_CREDENTIALS2 {
    numCredentials : UInt32
    credentials : IKEEXT_CREDENTIAL_PAIR2.Ptr
}
struct IKEEXT_SA_DETAILS2 {
    saId : Int64
    keyModuleType : IKEEXT_KEY_MODULE_TYPE
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    ikeTraffic : IKEEXT_TRAFFIC0
    ikeProposal : IKEEXT_PROPOSAL0
    cookiePair : IKEEXT_COOKIE_PAIR0
    ikeCredentials : IKEEXT_CREDENTIALS2
    ikePolicyKey : GUID
    virtualIfTunnelId : Int64
    correlationKey : FWP_BYTE_BLOB
    struct _Anonymous_e__Union {
        union {
            v4UdpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IKEEXT_SA_ENUM_TEMPLATE0 {
    localSubNet : FWP_CONDITION_VALUE0
    remoteSubNet : FWP_CONDITION_VALUE0
    localMainModeCertHash : FWP_BYTE_BLOB
}
struct IKEEXT_MM_SA_STATE extends Int32 {
    static IKEEXT_MM_SA_STATE_NONE := 0
    static IKEEXT_MM_SA_STATE_SA_SENT := 1
    static IKEEXT_MM_SA_STATE_SSPI_SENT := 2
    static IKEEXT_MM_SA_STATE_FINAL := 3
    static IKEEXT_MM_SA_STATE_FINAL_SENT := 4
    static IKEEXT_MM_SA_STATE_COMPLETE := 5
    static IKEEXT_MM_SA_STATE_MAX := 6
}
struct IKEEXT_QM_SA_STATE extends Int32 {
    static IKEEXT_QM_SA_STATE_NONE := 0
    static IKEEXT_QM_SA_STATE_INITIAL := 1
    static IKEEXT_QM_SA_STATE_FINAL := 2
    static IKEEXT_QM_SA_STATE_COMPLETE := 3
    static IKEEXT_QM_SA_STATE_MAX := 4
}
struct IKEEXT_EM_SA_STATE extends Int32 {
    static IKEEXT_EM_SA_STATE_NONE := 0
    static IKEEXT_EM_SA_STATE_SENT_ATTS := 1
    static IKEEXT_EM_SA_STATE_SSPI_SENT := 2
    static IKEEXT_EM_SA_STATE_AUTH_COMPLETE := 3
    static IKEEXT_EM_SA_STATE_FINAL := 4
    static IKEEXT_EM_SA_STATE_COMPLETE := 5
    static IKEEXT_EM_SA_STATE_MAX := 6
}
struct IKEEXT_SA_ROLE extends Int32 {
    static IKEEXT_SA_ROLE_INITIATOR := 0
    static IKEEXT_SA_ROLE_RESPONDER := 1
    static IKEEXT_SA_ROLE_MAX := 2
}
struct IPSEC_SA_LIFETIME0 {
    lifetimeSeconds : UInt32
    lifetimeKilobytes : UInt32
    lifetimePackets : UInt32
}
struct IPSEC_TRANSFORM_TYPE extends Int32 {
    static IPSEC_TRANSFORM_AH := 1
    static IPSEC_TRANSFORM_ESP_AUTH := 2
    static IPSEC_TRANSFORM_ESP_CIPHER := 3
    static IPSEC_TRANSFORM_ESP_AUTH_AND_CIPHER := 4
    static IPSEC_TRANSFORM_ESP_AUTH_FW := 5
    static IPSEC_TRANSFORM_TYPE_MAX := 6
}
struct IPSEC_AUTH_TYPE extends Int32 {
    static IPSEC_AUTH_MD5 := 0
    static IPSEC_AUTH_SHA_1 := 1
    static IPSEC_AUTH_SHA_256 := 2
    static IPSEC_AUTH_AES_128 := 3
    static IPSEC_AUTH_AES_192 := 4
    static IPSEC_AUTH_AES_256 := 5
    static IPSEC_AUTH_MAX := 6
}
struct IPSEC_AUTH_TRANSFORM_ID0 {
    authType : IPSEC_AUTH_TYPE
    authConfig : UInt8
}
struct IPSEC_AUTH_TRANSFORM0 {
    authTransformId : IPSEC_AUTH_TRANSFORM_ID0
    cryptoModuleId : GUID.Ptr
}
struct IPSEC_CIPHER_TYPE extends Int32 {
    static IPSEC_CIPHER_TYPE_DES := 1
    static IPSEC_CIPHER_TYPE_3DES := 2
    static IPSEC_CIPHER_TYPE_AES_128 := 3
    static IPSEC_CIPHER_TYPE_AES_192 := 4
    static IPSEC_CIPHER_TYPE_AES_256 := 5
    static IPSEC_CIPHER_TYPE_MAX := 6
}
struct IPSEC_CIPHER_TRANSFORM_ID0 {
    cipherType : IPSEC_CIPHER_TYPE
    cipherConfig : UInt8
}
struct IPSEC_CIPHER_TRANSFORM0 {
    cipherTransformId : IPSEC_CIPHER_TRANSFORM_ID0
    cryptoModuleId : GUID.Ptr
}
struct IPSEC_AUTH_AND_CIPHER_TRANSFORM0 {
    authTransform : IPSEC_AUTH_TRANSFORM0
    cipherTransform : IPSEC_CIPHER_TRANSFORM0
}
struct IPSEC_SA_TRANSFORM0 {
    ipsecTransformType : IPSEC_TRANSFORM_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ahTransform : IPSEC_AUTH_TRANSFORM0.Ptr
            espAuthTransform : IPSEC_AUTH_TRANSFORM0.Ptr
            espCipherTransform : IPSEC_CIPHER_TRANSFORM0.Ptr
            espAuthAndCipherTransform : IPSEC_AUTH_AND_CIPHER_TRANSFORM0.Ptr
            espAuthFwTransform : IPSEC_AUTH_TRANSFORM0.Ptr
        }
    }
}
struct IPSEC_PFS_GROUP extends Int32 {
    static IPSEC_PFS_NONE := 0
    static IPSEC_PFS_1 := 1
    static IPSEC_PFS_2 := 2
    static IPSEC_PFS_2048 := 3
    static IPSEC_PFS_14 := 3
    static IPSEC_PFS_ECP_256 := 4
    static IPSEC_PFS_ECP_384 := 5
    static IPSEC_PFS_MM := 6
    static IPSEC_PFS_24 := 7
    static IPSEC_PFS_MAX := 8
}
struct IPSEC_PROPOSAL0 {
    lifetime : IPSEC_SA_LIFETIME0
    numSaTransforms : UInt32
    saTransforms : IPSEC_SA_TRANSFORM0.Ptr
    pfsGroup : IPSEC_PFS_GROUP
}
struct IPSEC_SA_IDLE_TIMEOUT0 {
    idleTimeoutSeconds : UInt32
    idleTimeoutSecondsFailOver : UInt32
}
struct IPSEC_TRAFFIC_SELECTOR0 {
    protocolId : UInt8
    portStart : UInt16
    portEnd : UInt16
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            startV4Address : UInt32
            startV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            endV4Address : UInt32
            endV6Address : UInt8[16]
        }
    }
}
struct IPSEC_TRAFFIC_SELECTOR_POLICY0 {
    flags : UInt32
    numLocalTrafficSelectors : UInt32
    localTrafficSelectors : IPSEC_TRAFFIC_SELECTOR0.Ptr
    numRemoteTrafficSelectors : UInt32
    remoteTrafficSelectors : IPSEC_TRAFFIC_SELECTOR0.Ptr
}
struct IPSEC_TRANSPORT_POLICY0 {
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    flags : IPSEC_POLICY_FLAG
    ndAllowClearTimeoutSeconds : UInt32
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY0.Ptr
}
struct IPSEC_TRANSPORT_POLICY1 {
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    flags : IPSEC_POLICY_FLAG
    ndAllowClearTimeoutSeconds : UInt32
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY1.Ptr
}
struct IPSEC_TRANSPORT_POLICY2 {
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    flags : IPSEC_POLICY_FLAG
    ndAllowClearTimeoutSeconds : UInt32
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY2.Ptr
}
struct IPSEC_TUNNEL_ENDPOINTS0 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
}
struct IPSEC_TUNNEL_ENDPOINT0 {
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            v4Address : UInt32
            v6Address : UInt8[16]
        }
    }
}
struct IPSEC_TUNNEL_ENDPOINTS2 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localIfLuid : Int64
    remoteFqdn : PWSTR
    numAddresses : UInt32
    remoteAddresses : IPSEC_TUNNEL_ENDPOINT0.Ptr
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
}
struct IPSEC_TUNNEL_ENDPOINTS1 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localIfLuid : Int64
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
}
struct IPSEC_TUNNEL_POLICY0 {
    flags : IPSEC_POLICY_FLAG
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    tunnelEndpoints : IPSEC_TUNNEL_ENDPOINTS0
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY0.Ptr
}
struct IPSEC_TUNNEL_POLICY1 {
    flags : IPSEC_POLICY_FLAG
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    tunnelEndpoints : IPSEC_TUNNEL_ENDPOINTS1
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY1.Ptr
}
struct IPSEC_TUNNEL_POLICY2 {
    flags : IPSEC_POLICY_FLAG
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    tunnelEndpoints : IPSEC_TUNNEL_ENDPOINTS2
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY2.Ptr
    fwdPathSaLifetime : UInt32
}
struct IPSEC_TUNNEL_POLICY3 {
    flags : UInt32
    numIpsecProposals : UInt32
    ipsecProposals : IPSEC_PROPOSAL0.Ptr
    tunnelEndpoints : IPSEC_TUNNEL_ENDPOINTS2
    saIdleTimeout : IPSEC_SA_IDLE_TIMEOUT0
    emPolicy : IKEEXT_EM_POLICY2.Ptr
    fwdPathSaLifetime : UInt32
    compartmentId : UInt32
    numTrafficSelectorPolicy : UInt32
    trafficSelectorPolicies : IPSEC_TRAFFIC_SELECTOR_POLICY0.Ptr
}
struct IPSEC_KEYING_POLICY0 {
    numKeyMods : UInt32
    keyModKeys : GUID.Ptr
}
struct IPSEC_KEYING_POLICY1 {
    numKeyMods : UInt32
    keyModKeys : GUID.Ptr
    flags : UInt32
}
struct IPSEC_AGGREGATE_SA_STATISTICS0 {
    activeSas : UInt32
    pendingSaNegotiations : UInt32
    totalSasAdded : UInt32
    totalSasDeleted : UInt32
    successfulRekeys : UInt32
    activeTunnels : UInt32
    offloadedSas : UInt32
}
struct IPSEC_ESP_DROP_PACKET_STATISTICS0 {
    invalidSpisOnInbound : UInt32
    decryptionFailuresOnInbound : UInt32
    authenticationFailuresOnInbound : UInt32
    replayCheckFailuresOnInbound : UInt32
    saNotInitializedOnInbound : UInt32
}
struct IPSEC_AH_DROP_PACKET_STATISTICS0 {
    invalidSpisOnInbound : UInt32
    authenticationFailuresOnInbound : UInt32
    replayCheckFailuresOnInbound : UInt32
    saNotInitializedOnInbound : UInt32
}
struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0 {
    invalidSpisOnInbound : UInt32
    decryptionFailuresOnInbound : UInt32
    authenticationFailuresOnInbound : UInt32
    udpEspValidationFailuresOnInbound : UInt32
    replayCheckFailuresOnInbound : UInt32
    invalidClearTextInbound : UInt32
    saNotInitializedOnInbound : UInt32
    receiveOverIncorrectSaInbound : UInt32
    secureReceivesNotMatchingFilters : UInt32
}
struct IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1 {
    invalidSpisOnInbound : UInt32
    decryptionFailuresOnInbound : UInt32
    authenticationFailuresOnInbound : UInt32
    udpEspValidationFailuresOnInbound : UInt32
    replayCheckFailuresOnInbound : UInt32
    invalidClearTextInbound : UInt32
    saNotInitializedOnInbound : UInt32
    receiveOverIncorrectSaInbound : UInt32
    secureReceivesNotMatchingFilters : UInt32
    totalDropPacketsInbound : UInt32
}
struct IPSEC_TRAFFIC_STATISTICS0 {
    encryptedByteCount : Int64
    authenticatedAHByteCount : Int64
    authenticatedESPByteCount : Int64
    transportByteCount : Int64
    tunnelByteCount : Int64
    offloadByteCount : Int64
}
struct IPSEC_TRAFFIC_STATISTICS1 {
    encryptedByteCount : Int64
    authenticatedAHByteCount : Int64
    authenticatedESPByteCount : Int64
    transportByteCount : Int64
    tunnelByteCount : Int64
    offloadByteCount : Int64
    totalSuccessfulPackets : Int64
}
struct IPSEC_STATISTICS0 {
    aggregateSaStatistics : IPSEC_AGGREGATE_SA_STATISTICS0
    espDropPacketStatistics : IPSEC_ESP_DROP_PACKET_STATISTICS0
    ahDropPacketStatistics : IPSEC_AH_DROP_PACKET_STATISTICS0
    aggregateDropPacketStatistics : IPSEC_AGGREGATE_DROP_PACKET_STATISTICS0
    inboundTrafficStatistics : IPSEC_TRAFFIC_STATISTICS0
    outboundTrafficStatistics : IPSEC_TRAFFIC_STATISTICS0
}
struct IPSEC_STATISTICS1 {
    aggregateSaStatistics : IPSEC_AGGREGATE_SA_STATISTICS0
    espDropPacketStatistics : IPSEC_ESP_DROP_PACKET_STATISTICS0
    ahDropPacketStatistics : IPSEC_AH_DROP_PACKET_STATISTICS0
    aggregateDropPacketStatistics : IPSEC_AGGREGATE_DROP_PACKET_STATISTICS1
    inboundTrafficStatistics : IPSEC_TRAFFIC_STATISTICS1
    outboundTrafficStatistics : IPSEC_TRAFFIC_STATISTICS1
}
struct IPSEC_SA_AUTH_INFORMATION0 {
    authTransform : IPSEC_AUTH_TRANSFORM0
    authKey : FWP_BYTE_BLOB
}
struct IPSEC_SA_CIPHER_INFORMATION0 {
    cipherTransform : IPSEC_CIPHER_TRANSFORM0
    cipherKey : FWP_BYTE_BLOB
}
struct IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0 {
    saCipherInformation : IPSEC_SA_CIPHER_INFORMATION0
    saAuthInformation : IPSEC_SA_AUTH_INFORMATION0
}
struct IPSEC_SA0 {
    spi : UInt32
    saTransformType : IPSEC_TRANSFORM_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ahInformation : IPSEC_SA_AUTH_INFORMATION0.Ptr
            espAuthInformation : IPSEC_SA_AUTH_INFORMATION0.Ptr
            espCipherInformation : IPSEC_SA_CIPHER_INFORMATION0.Ptr
            espAuthAndCipherInformation : IPSEC_SA_AUTH_AND_CIPHER_INFORMATION0.Ptr
            espAuthFwInformation : IPSEC_SA_AUTH_INFORMATION0.Ptr
        }
    }
}
struct IPSEC_KEYMODULE_STATE0 {
    keyModuleKey : GUID
    stateBlob : FWP_BYTE_BLOB
}
struct IPSEC_TOKEN_TYPE extends Int32 {
    static IPSEC_TOKEN_TYPE_MACHINE := 0
    static IPSEC_TOKEN_TYPE_IMPERSONATION := 1
    static IPSEC_TOKEN_TYPE_MAX := 2
}
struct IPSEC_TOKEN_PRINCIPAL extends Int32 {
    static IPSEC_TOKEN_PRINCIPAL_LOCAL := 0
    static IPSEC_TOKEN_PRINCIPAL_PEER := 1
    static IPSEC_TOKEN_PRINCIPAL_MAX := 2
}
struct IPSEC_TOKEN_MODE extends Int32 {
    static IPSEC_TOKEN_MODE_MAIN := 0
    static IPSEC_TOKEN_MODE_EXTENDED := 1
    static IPSEC_TOKEN_MODE_MAX := 2
}
struct IPSEC_TOKEN0 {
    type : IPSEC_TOKEN_TYPE
    principal : IPSEC_TOKEN_PRINCIPAL
    mode : IPSEC_TOKEN_MODE
    token : Int64
}
struct IPSEC_ID0 {
    mmTargetName : PWSTR
    emTargetName : PWSTR
    numTokens : UInt32
    tokens : IPSEC_TOKEN0.Ptr
    explicitCredentials : Int64
    logonId : Int64
}
struct IPSEC_SA_BUNDLE0 {
    flags : IPSEC_SA_BUNDLE_FLAGS
    lifetime : IPSEC_SA_LIFETIME0
    idleTimeoutSeconds : UInt32
    ndAllowClearTimeoutSeconds : UInt32
    ipsecId : IPSEC_ID0.Ptr
    napContext : UInt32
    qmSaId : UInt32
    numSAs : UInt32
    saList : IPSEC_SA0.Ptr
    keyModuleState : IPSEC_KEYMODULE_STATE0.Ptr
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    mmSaId : Int64
    pfsGroup : IPSEC_PFS_GROUP
    struct _Anonymous_e__Union {
        union {
            peerV4PrivateAddress : UInt32
        }
    }
}
struct IPSEC_SA_BUNDLE1 {
    flags : IPSEC_SA_BUNDLE_FLAGS
    lifetime : IPSEC_SA_LIFETIME0
    idleTimeoutSeconds : UInt32
    ndAllowClearTimeoutSeconds : UInt32
    ipsecId : IPSEC_ID0.Ptr
    napContext : UInt32
    qmSaId : UInt32
    numSAs : UInt32
    saList : IPSEC_SA0.Ptr
    keyModuleState : IPSEC_KEYMODULE_STATE0.Ptr
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    mmSaId : Int64
    pfsGroup : IPSEC_PFS_GROUP
    saLookupContext : GUID
    qmFilterId : Int64
    struct _Anonymous_e__Union {
        union {
            peerV4PrivateAddress : UInt32
        }
    }
}
struct IPSEC_TRAFFIC_TYPE extends Int32 {
    static IPSEC_TRAFFIC_TYPE_TRANSPORT := 0
    static IPSEC_TRAFFIC_TYPE_TUNNEL := 1
    static IPSEC_TRAFFIC_TYPE_MAX := 2
}
struct IPSEC_TRAFFIC0 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    trafficType : IPSEC_TRAFFIC_TYPE
    Anonymous3 : this._Anonymous3_e__Union
    remotePort : UInt16
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ipsecFilterId : Int64
            tunnelPolicyId : Int64
        }
    }
}
struct IPSEC_TRAFFIC1 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    trafficType : IPSEC_TRAFFIC_TYPE
    Anonymous3 : this._Anonymous3_e__Union
    remotePort : UInt16
    localPort : UInt16
    ipProtocol : UInt8
    localIfLuid : Int64
    realIfProfileId : UInt32
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
    struct _Anonymous3_e__Union {
        union {
            ipsecFilterId : Int64
            tunnelPolicyId : Int64
        }
    }
}
struct IPSEC_V4_UDP_ENCAPSULATION0 {
    localUdpEncapPort : UInt16
    remoteUdpEncapPort : UInt16
}
struct IPSEC_GETSPI0 {
    inboundIpsecTraffic : IPSEC_TRAFFIC0
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    rngCryptoModuleID : GUID.Ptr
    struct _Anonymous_e__Union {
        union {
            inboundUdpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IPSEC_GETSPI1 {
    inboundIpsecTraffic : IPSEC_TRAFFIC1
    ipVersion : FWP_IP_VERSION
    Anonymous : this._Anonymous_e__Union
    rngCryptoModuleID : GUID.Ptr
    struct _Anonymous_e__Union {
        union {
            inboundUdpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IPSEC_SA_DETAILS0 {
    ipVersion : FWP_IP_VERSION
    saDirection : FWP_DIRECTION
    traffic : IPSEC_TRAFFIC0
    saBundle : IPSEC_SA_BUNDLE0
    Anonymous : this._Anonymous_e__Union
    transportFilter : FWPM_FILTER0.Ptr
    struct _Anonymous_e__Union {
        union {
            udpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IPSEC_SA_DETAILS1 {
    ipVersion : FWP_IP_VERSION
    saDirection : FWP_DIRECTION
    traffic : IPSEC_TRAFFIC1
    saBundle : IPSEC_SA_BUNDLE1
    Anonymous : this._Anonymous_e__Union
    transportFilter : FWPM_FILTER0.Ptr
    virtualIfTunnelInfo : IPSEC_VIRTUAL_IF_TUNNEL_INFO0
    struct _Anonymous_e__Union {
        union {
            udpEncapsulation : IPSEC_V4_UDP_ENCAPSULATION0.Ptr
        }
    }
}
struct IPSEC_SA_CONTEXT0 {
    saContextId : Int64
    inboundSa : IPSEC_SA_DETAILS0.Ptr
    outboundSa : IPSEC_SA_DETAILS0.Ptr
}
struct IPSEC_SA_CONTEXT1 {
    saContextId : Int64
    inboundSa : IPSEC_SA_DETAILS1.Ptr
    outboundSa : IPSEC_SA_DETAILS1.Ptr
}
struct IPSEC_SA_CONTEXT_ENUM_TEMPLATE0 {
    localSubNet : FWP_CONDITION_VALUE0
    remoteSubNet : FWP_CONDITION_VALUE0
}
struct IPSEC_SA_ENUM_TEMPLATE0 {
    saDirection : FWP_DIRECTION
}
struct IPSEC_SA_CONTEXT_SUBSCRIPTION0 {
    enumTemplate : IPSEC_SA_CONTEXT_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct IPSEC_SA_CONTEXT_EVENT_TYPE0 extends Int32 {
    static IPSEC_SA_CONTEXT_EVENT_ADD := 1
    static IPSEC_SA_CONTEXT_EVENT_DELETE := 2
    static IPSEC_SA_CONTEXT_EVENT_MAX := 3
}
struct IPSEC_SA_CONTEXT_CHANGE0 {
    changeType : IPSEC_SA_CONTEXT_EVENT_TYPE0
    saContextId : Int64
}
struct IPSEC_FAILURE_POINT extends Int32 {
    static IPSEC_FAILURE_NONE := 0
    static IPSEC_FAILURE_ME := 1
    static IPSEC_FAILURE_PEER := 2
    static IPSEC_FAILURE_POINT_MAX := 3
}
struct IPSEC_ADDRESS_INFO0 {
    numV4Addresses : UInt32
    v4Addresses : UInt32.Ptr
    numV6Addresses : UInt32
    v6Addresses : FWP_BYTE_ARRAY16.Ptr
}
struct IPSEC_DOSP_OPTIONS0 {
    stateIdleTimeoutSeconds : UInt32
    perIPRateLimitQueueIdleTimeoutSeconds : UInt32
    ipV6IPsecUnauthDscp : UInt8
    ipV6IPsecUnauthRateLimitBytesPerSec : UInt32
    ipV6IPsecUnauthPerIPRateLimitBytesPerSec : UInt32
    ipV6IPsecAuthDscp : UInt8
    ipV6IPsecAuthRateLimitBytesPerSec : UInt32
    icmpV6Dscp : UInt8
    icmpV6RateLimitBytesPerSec : UInt32
    ipV6FilterExemptDscp : UInt8
    ipV6FilterExemptRateLimitBytesPerSec : UInt32
    defBlockExemptDscp : UInt8
    defBlockExemptRateLimitBytesPerSec : UInt32
    maxStateEntries : UInt32
    maxPerIPRateLimitQueues : UInt32
    flags : IPSEC_DOSP_FLAGS
    numPublicIFLuids : UInt32
    publicIFLuids : Int64.Ptr
    numInternalIFLuids : UInt32
    internalIFLuids : Int64.Ptr
    publicV6AddrMask : FWP_V6_ADDR_AND_MASK
    internalV6AddrMask : FWP_V6_ADDR_AND_MASK
}
struct IPSEC_DOSP_STATISTICS0 {
    totalStateEntriesCreated : Int64
    currentStateEntries : Int64
    totalInboundAllowedIPv6IPsecUnauthPkts : Int64
    totalInboundRatelimitDiscardedIPv6IPsecUnauthPkts : Int64
    totalInboundPerIPRatelimitDiscardedIPv6IPsecUnauthPkts : Int64
    totalInboundOtherDiscardedIPv6IPsecUnauthPkts : Int64
    totalInboundAllowedIPv6IPsecAuthPkts : Int64
    totalInboundRatelimitDiscardedIPv6IPsecAuthPkts : Int64
    totalInboundOtherDiscardedIPv6IPsecAuthPkts : Int64
    totalInboundAllowedICMPv6Pkts : Int64
    totalInboundRatelimitDiscardedICMPv6Pkts : Int64
    totalInboundAllowedIPv6FilterExemptPkts : Int64
    totalInboundRatelimitDiscardedIPv6FilterExemptPkts : Int64
    totalInboundDiscardedIPv6FilterBlockPkts : Int64
    totalInboundAllowedDefBlockExemptPkts : Int64
    totalInboundRatelimitDiscardedDefBlockExemptPkts : Int64
    totalInboundDiscardedDefBlockPkts : Int64
    currentInboundIPv6IPsecUnauthPerIPRateLimitQueues : Int64
}
struct IPSEC_DOSP_STATE0 {
    publicHostV6Addr : UInt8[16]
    internalHostV6Addr : UInt8[16]
    totalInboundIPv6IPsecAuthPackets : Int64
    totalOutboundIPv6IPsecAuthPackets : Int64
    durationSecs : UInt32
}
struct IPSEC_DOSP_STATE_ENUM_TEMPLATE0 {
    publicV6AddrMask : FWP_V6_ADDR_AND_MASK
    internalV6AddrMask : FWP_V6_ADDR_AND_MASK
}
struct IPSEC_KEY_MANAGER0 {
    keyManagerKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    keyDictationTimeoutHint : UInt8
}
struct DL_ADDRESS_TYPE extends Int32 {
    static DlUnicast := 0
    static DlMulticast := 1
    static DlBroadcast := 2
}
struct FWPM_CHANGE_TYPE extends Int32 {
    static FWPM_CHANGE_ADD := 1
    static FWPM_CHANGE_DELETE := 2
    static FWPM_CHANGE_TYPE_MAX := 3
}
struct FWPM_SERVICE_STATE extends Int32 {
    static FWPM_SERVICE_STOPPED := 0
    static FWPM_SERVICE_START_PENDING := 1
    static FWPM_SERVICE_STOP_PENDING := 2
    static FWPM_SERVICE_RUNNING := 3
    static FWPM_SERVICE_STATE_MAX := 4
}
struct FWPM_ENGINE_OPTION extends Int32 {
    static FWPM_ENGINE_COLLECT_NET_EVENTS := 0
    static FWPM_ENGINE_NET_EVENT_MATCH_ANY_KEYWORDS := 1
    static FWPM_ENGINE_NAME_CACHE := 2
    static FWPM_ENGINE_MONITOR_IPSEC_CONNECTIONS := 3
    static FWPM_ENGINE_PACKET_QUEUING := 4
    static FWPM_ENGINE_TXN_WATCHDOG_TIMEOUT_IN_MSEC := 5
    static FWPM_ENGINE_OPTION_MAX := 6
}
struct FWPM_SESSION0 {
    sessionKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    txnWaitTimeoutInMSec : UInt32
    processId : UInt32
    sid : SID.Ptr
    username : PWSTR
    kernelMode : BOOL
}
struct FWPM_SESSION_ENUM_TEMPLATE0 {
    reserved : Int64
}
struct FWPM_PROVIDER0 {
    providerKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerData : FWP_BYTE_BLOB
    serviceName : PWSTR
}
struct FWPM_PROVIDER_ENUM_TEMPLATE0 {
    reserved : Int64
}
struct FWPM_PROVIDER_CHANGE0 {
    changeType : FWPM_CHANGE_TYPE
    providerKey : GUID
}
struct FWPM_PROVIDER_SUBSCRIPTION0 {
    enumTemplate : FWPM_PROVIDER_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_CLASSIFY_OPTION0 {
    type : FWP_CLASSIFY_OPTION_TYPE
    value : FWP_VALUE0
}
struct FWPM_CLASSIFY_OPTIONS0 {
    numOptions : UInt32
    options : FWPM_CLASSIFY_OPTION0.Ptr
}
struct FWPM_NETWORK_CONNECTION_POLICY_SETTING0 {
    type : FWP_NETWORK_CONNECTION_POLICY_SETTING_TYPE
    value : FWP_VALUE0
}
struct FWPM_NETWORK_CONNECTION_POLICY_SETTINGS0 {
    numSettings : UInt32
    settings : FWPM_NETWORK_CONNECTION_POLICY_SETTING0.Ptr
}
struct FWPM_PROVIDER_CONTEXT_TYPE extends Int32 {
    static FWPM_IPSEC_KEYING_CONTEXT := 0
    static FWPM_IPSEC_IKE_QM_TRANSPORT_CONTEXT := 1
    static FWPM_IPSEC_IKE_QM_TUNNEL_CONTEXT := 2
    static FWPM_IPSEC_AUTHIP_QM_TRANSPORT_CONTEXT := 3
    static FWPM_IPSEC_AUTHIP_QM_TUNNEL_CONTEXT := 4
    static FWPM_IPSEC_IKE_MM_CONTEXT := 5
    static FWPM_IPSEC_AUTHIP_MM_CONTEXT := 6
    static FWPM_CLASSIFY_OPTIONS_CONTEXT := 7
    static FWPM_GENERAL_CONTEXT := 8
    static FWPM_IPSEC_IKEV2_QM_TUNNEL_CONTEXT := 9
    static FWPM_IPSEC_IKEV2_MM_CONTEXT := 10
    static FWPM_IPSEC_DOSP_CONTEXT := 11
    static FWPM_IPSEC_IKEV2_QM_TRANSPORT_CONTEXT := 12
    static FWPM_NETWORK_CONNECTION_POLICY_CONTEXT := 13
    static FWPM_PROVIDER_CONTEXT_TYPE_MAX := 14
}
struct FWPM_PROVIDER_CONTEXT0 {
    providerContextKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    type : FWPM_PROVIDER_CONTEXT_TYPE
    Anonymous : this._Anonymous_e__Union
    providerContextId : Int64
    struct _Anonymous_e__Union {
        union {
            keyingPolicy : IPSEC_KEYING_POLICY0.Ptr
            ikeQmTransportPolicy : IPSEC_TRANSPORT_POLICY0.Ptr
            ikeQmTunnelPolicy : IPSEC_TUNNEL_POLICY0.Ptr
            authipQmTransportPolicy : IPSEC_TRANSPORT_POLICY0.Ptr
            authipQmTunnelPolicy : IPSEC_TUNNEL_POLICY0.Ptr
            ikeMmPolicy : IKEEXT_POLICY0.Ptr
            authIpMmPolicy : IKEEXT_POLICY0.Ptr
            dataBuffer : FWP_BYTE_BLOB.Ptr
            classifyOptions : FWPM_CLASSIFY_OPTIONS0.Ptr
        }
    }
}
struct FWPM_PROVIDER_CONTEXT1 {
    providerContextKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    type : FWPM_PROVIDER_CONTEXT_TYPE
    Anonymous : this._Anonymous_e__Union
    providerContextId : Int64
    struct _Anonymous_e__Union {
        union {
            keyingPolicy : IPSEC_KEYING_POLICY0.Ptr
            ikeQmTransportPolicy : IPSEC_TRANSPORT_POLICY1.Ptr
            ikeQmTunnelPolicy : IPSEC_TUNNEL_POLICY1.Ptr
            authipQmTransportPolicy : IPSEC_TRANSPORT_POLICY1.Ptr
            authipQmTunnelPolicy : IPSEC_TUNNEL_POLICY1.Ptr
            ikeMmPolicy : IKEEXT_POLICY1.Ptr
            authIpMmPolicy : IKEEXT_POLICY1.Ptr
            dataBuffer : FWP_BYTE_BLOB.Ptr
            classifyOptions : FWPM_CLASSIFY_OPTIONS0.Ptr
            ikeV2QmTunnelPolicy : IPSEC_TUNNEL_POLICY1.Ptr
            ikeV2MmPolicy : IKEEXT_POLICY1.Ptr
            idpOptions : IPSEC_DOSP_OPTIONS0.Ptr
        }
    }
}
struct FWPM_PROVIDER_CONTEXT2 {
    providerContextKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    type : FWPM_PROVIDER_CONTEXT_TYPE
    Anonymous : this._Anonymous_e__Union
    providerContextId : Int64
    struct _Anonymous_e__Union {
        union {
            keyingPolicy : IPSEC_KEYING_POLICY1.Ptr
            ikeQmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            ikeQmTunnelPolicy : IPSEC_TUNNEL_POLICY2.Ptr
            authipQmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            authipQmTunnelPolicy : IPSEC_TUNNEL_POLICY2.Ptr
            ikeMmPolicy : IKEEXT_POLICY2.Ptr
            authIpMmPolicy : IKEEXT_POLICY2.Ptr
            dataBuffer : FWP_BYTE_BLOB.Ptr
            classifyOptions : FWPM_CLASSIFY_OPTIONS0.Ptr
            ikeV2QmTunnelPolicy : IPSEC_TUNNEL_POLICY2.Ptr
            ikeV2QmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            ikeV2MmPolicy : IKEEXT_POLICY2.Ptr
            idpOptions : IPSEC_DOSP_OPTIONS0.Ptr
        }
    }
}
struct FWPM_PROVIDER_CONTEXT3 {
    providerContextKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    type : FWPM_PROVIDER_CONTEXT_TYPE
    Anonymous : this._Anonymous_e__Union
    providerContextId : Int64
    struct _Anonymous_e__Union {
        union {
            keyingPolicy : IPSEC_KEYING_POLICY1.Ptr
            ikeQmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            ikeQmTunnelPolicy : IPSEC_TUNNEL_POLICY3.Ptr
            authipQmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            authipQmTunnelPolicy : IPSEC_TUNNEL_POLICY3.Ptr
            ikeMmPolicy : IKEEXT_POLICY2.Ptr
            authIpMmPolicy : IKEEXT_POLICY2.Ptr
            dataBuffer : FWP_BYTE_BLOB.Ptr
            classifyOptions : FWPM_CLASSIFY_OPTIONS0.Ptr
            ikeV2QmTunnelPolicy : IPSEC_TUNNEL_POLICY3.Ptr
            ikeV2QmTransportPolicy : IPSEC_TRANSPORT_POLICY2.Ptr
            ikeV2MmPolicy : IKEEXT_POLICY2.Ptr
            idpOptions : IPSEC_DOSP_OPTIONS0.Ptr
            networkConnectionPolicy : FWPM_NETWORK_CONNECTION_POLICY_SETTINGS0.Ptr
        }
    }
}
struct FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0 {
    providerKey : GUID.Ptr
    providerContextType : FWPM_PROVIDER_CONTEXT_TYPE
}
struct FWPM_PROVIDER_CONTEXT_CHANGE0 {
    changeType : FWPM_CHANGE_TYPE
    providerContextKey : GUID
    providerContextId : Int64
}
struct FWPM_PROVIDER_CONTEXT_SUBSCRIPTION0 {
    enumTemplate : FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0.Ptr
    flags : FWPM_SUBSCRIPTION_FLAGS
    sessionKey : GUID
}
struct FWPM_SUBLAYER0 {
    subLayerKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    weight : UInt16
}
struct FWPM_SUBLAYER_ENUM_TEMPLATE0 {
    providerKey : GUID.Ptr
}
struct FWPM_SUBLAYER_CHANGE0 {
    changeType : FWPM_CHANGE_TYPE
    subLayerKey : GUID
}
struct FWPM_SUBLAYER_SUBSCRIPTION0 {
    enumTemplate : FWPM_SUBLAYER_ENUM_TEMPLATE0.Ptr
    flags : FWPM_SUBSCRIPTION_FLAGS
    sessionKey : GUID
}
struct FWPM_FIELD_TYPE extends Int32 {
    static FWPM_FIELD_RAW_DATA := 0
    static FWPM_FIELD_IP_ADDRESS := 1
    static FWPM_FIELD_FLAGS := 2
    static FWPM_FIELD_TYPE_MAX := 3
}
struct FWPM_FIELD0 {
    fieldKey : GUID.Ptr
    type : FWPM_FIELD_TYPE
    dataType : FWP_DATA_TYPE
}
struct FWPM_LAYER0 {
    layerKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    numFields : UInt32
    field : FWPM_FIELD0.Ptr
    defaultSubLayerKey : GUID
    layerId : UInt16
}
struct FWPM_LAYER_ENUM_TEMPLATE0 {
    reserved : Int64
}
struct FWPM_CALLOUT0 {
    calloutKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : UInt32
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    applicableLayer : GUID
    calloutId : UInt32
}
struct FWPM_CALLOUT_ENUM_TEMPLATE0 {
    providerKey : GUID.Ptr
    layerKey : GUID
}
struct FWPM_CALLOUT_CHANGE0 {
    changeType : FWPM_CHANGE_TYPE
    calloutKey : GUID
    calloutId : UInt32
}
struct FWPM_CALLOUT_SUBSCRIPTION0 {
    enumTemplate : FWPM_CALLOUT_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_ACTION0 {
    type : FWP_ACTION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            filterType : GUID
            calloutKey : GUID
        }
    }
}
struct FWPM_FILTER_CONDITION0 {
    fieldKey : GUID
    matchType : FWP_MATCH_TYPE
    conditionValue : FWP_CONDITION_VALUE0
}
struct FWPM_FILTER0 {
    filterKey : GUID
    displayData : FWPM_DISPLAY_DATA0
    flags : FWPM_FILTER_FLAGS
    providerKey : GUID.Ptr
    providerData : FWP_BYTE_BLOB
    layerKey : GUID
    subLayerKey : GUID
    weight : FWP_VALUE0
    numFilterConditions : UInt32
    filterCondition : FWPM_FILTER_CONDITION0.Ptr
    action : FWPM_ACTION0
    Anonymous : this._Anonymous_e__Union
    reserved : GUID.Ptr
    filterId : Int64
    effectiveWeight : FWP_VALUE0
    struct _Anonymous_e__Union {
        union {
            rawContext : Int64
            providerContextKey : GUID
        }
    }
}
struct FWPM_FILTER_ENUM_TEMPLATE0 {
    providerKey : GUID.Ptr
    layerKey : GUID
    enumType : FWP_FILTER_ENUM_TYPE
    flags : UInt32
    providerContextTemplate : FWPM_PROVIDER_CONTEXT_ENUM_TEMPLATE0.Ptr
    numFilterConditions : UInt32
    filterCondition : FWPM_FILTER_CONDITION0.Ptr
    actionMask : UInt32
    calloutKey : GUID.Ptr
}
struct FWPM_FILTER_CHANGE0 {
    changeType : FWPM_CHANGE_TYPE
    filterKey : GUID
    filterId : Int64
}
struct FWPM_FILTER_SUBSCRIPTION0 {
    enumTemplate : FWPM_FILTER_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_LAYER_STATISTICS1 {
    layerId : GUID
    classifyPermitCount : UInt32
    classifyBlockCount : UInt32
    classifyVetoCount : UInt32
    numCacheEntries : UInt32
    filterCount : UInt32
    totalFilterSize : UInt32
}
struct FWPM_STATISTICS1 {
    numLayerStatistics : UInt32
    layerStatistics : FWPM_LAYER_STATISTICS1.Ptr
    inboundAllowedConnectionsV4 : UInt32
    inboundBlockedConnectionsV4 : UInt32
    outboundAllowedConnectionsV4 : UInt32
    outboundBlockedConnectionsV4 : UInt32
    inboundAllowedConnectionsV6 : UInt32
    inboundBlockedConnectionsV6 : UInt32
    outboundAllowedConnectionsV6 : UInt32
    outboundBlockedConnectionsV6 : UInt32
    inboundActiveConnectionsV4 : UInt32
    outboundActiveConnectionsV4 : UInt32
    inboundActiveConnectionsV6 : UInt32
    outboundActiveConnectionsV6 : UInt32
    reauthDirInbound : Int64
    reauthDirOutbound : Int64
    reauthFamilyV4 : Int64
    reauthFamilyV6 : Int64
    reauthProtoOther : Int64
    reauthProtoIPv4 : Int64
    reauthProtoIPv6 : Int64
    reauthProtoICMP : Int64
    reauthProtoICMP6 : Int64
    reauthProtoUDP : Int64
    reauthProtoTCP : Int64
    reauthReasonPolicyChange : Int64
    reauthReasonNewArrivalInterface : Int64
    reauthReasonNewNextHopInterface : Int64
    reauthReasonProfileCrossing : Int64
    reauthReasonClassifyCompletion : Int64
    reauthReasonIPSecPropertiesChanged : Int64
    reauthReasonMidStreamInspection : Int64
    reauthReasonSocketPropertyChanged : Int64
    reauthReasonNewInboundMCastBCastPacket : Int64
    reauthReasonEDPPolicyChanged : Int64
    reauthReasonProxyHandleChanged : Int64
}
struct FWPM_NET_EVENT_HEADER0 {
    timeStamp : FILETIME
    flags : UInt32
    ipVersion : FWP_IP_VERSION
    ipProtocol : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localPort : UInt16
    remotePort : UInt16
    scopeId : UInt32
    appId : FWP_BYTE_BLOB
    userId : SID.Ptr
    struct _Anonymous1_e__Union {
        union {
            localAddrV4 : UInt32
            localAddrV6 : FWP_BYTE_ARRAY16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteAddrV4 : UInt32
            remoteAddrV6 : FWP_BYTE_ARRAY16
        }
    }
}
struct FWPM_NET_EVENT_HEADER1 {
    timeStamp : FILETIME
    flags : UInt32
    ipVersion : FWP_IP_VERSION
    ipProtocol : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localPort : UInt16
    remotePort : UInt16
    scopeId : UInt32
    appId : FWP_BYTE_BLOB
    userId : SID.Ptr
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            localAddrV4 : UInt32
            localAddrV6 : FWP_BYTE_ARRAY16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteAddrV4 : UInt32
            remoteAddrV6 : FWP_BYTE_ARRAY16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            reserved1 : FWP_AF
            Anonymous : this._Anonymous_e__Union
            struct _Anonymous_e__Union {
                union {
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    reserved2 : FWP_BYTE_ARRAY6
                    reserved3 : FWP_BYTE_ARRAY6
                    reserved4 : UInt32
                    reserved5 : UInt32
                    reserved6 : UInt16
                    reserved7 : UInt32
                    reserved8 : UInt32
                    reserved9 : UInt16
                    reserved10 : Int64
                }
            }
        }
    }
}
struct FWPM_NET_EVENT_HEADER2 {
    timeStamp : FILETIME
    flags : UInt32
    ipVersion : FWP_IP_VERSION
    ipProtocol : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localPort : UInt16
    remotePort : UInt16
    scopeId : UInt32
    appId : FWP_BYTE_BLOB
    userId : SID.Ptr
    addressFamily : FWP_AF
    packageSid : SID.Ptr
    struct _Anonymous1_e__Union {
        union {
            localAddrV4 : UInt32
            localAddrV6 : FWP_BYTE_ARRAY16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteAddrV4 : UInt32
            remoteAddrV6 : FWP_BYTE_ARRAY16
        }
    }
}
struct FWPM_NET_EVENT_HEADER3 {
    timeStamp : FILETIME
    flags : UInt32
    ipVersion : FWP_IP_VERSION
    ipProtocol : UInt8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    localPort : UInt16
    remotePort : UInt16
    scopeId : UInt32
    appId : FWP_BYTE_BLOB
    userId : SID.Ptr
    addressFamily : FWP_AF
    packageSid : SID.Ptr
    enterpriseId : PWSTR
    policyFlags : Int64
    effectiveName : FWP_BYTE_BLOB
    struct _Anonymous1_e__Union {
        union {
            localAddrV4 : UInt32
            localAddrV6 : FWP_BYTE_ARRAY16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteAddrV4 : UInt32
            remoteAddrV6 : FWP_BYTE_ARRAY16
        }
    }
}
struct FWPM_NET_EVENT_TYPE extends Int32 {
    static FWPM_NET_EVENT_TYPE_IKEEXT_MM_FAILURE := 0
    static FWPM_NET_EVENT_TYPE_IKEEXT_QM_FAILURE := 1
    static FWPM_NET_EVENT_TYPE_IKEEXT_EM_FAILURE := 2
    static FWPM_NET_EVENT_TYPE_CLASSIFY_DROP := 3
    static FWPM_NET_EVENT_TYPE_IPSEC_KERNEL_DROP := 4
    static FWPM_NET_EVENT_TYPE_IPSEC_DOSP_DROP := 5
    static FWPM_NET_EVENT_TYPE_CLASSIFY_ALLOW := 6
    static FWPM_NET_EVENT_TYPE_CAPABILITY_DROP := 7
    static FWPM_NET_EVENT_TYPE_CAPABILITY_ALLOW := 8
    static FWPM_NET_EVENT_TYPE_CLASSIFY_DROP_MAC := 9
    static FWPM_NET_EVENT_TYPE_LPM_PACKET_ARRIVAL := 10
    static FWPM_NET_EVENT_TYPE_MAX := 11
}
struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE0 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    flags : UInt32
    keyingModuleType : IKEEXT_KEY_MODULE_TYPE
    mmState : IKEEXT_MM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    mmAuthMethod : IKEEXT_AUTHENTICATION_METHOD_TYPE
    endCertHash : UInt8[20]
    mmId : Int64
    mmFilterId : Int64
}
struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE1 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    flags : UInt32
    keyingModuleType : IKEEXT_KEY_MODULE_TYPE
    mmState : IKEEXT_MM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    mmAuthMethod : IKEEXT_AUTHENTICATION_METHOD_TYPE
    endCertHash : UInt8[20]
    mmId : Int64
    mmFilterId : Int64
    localPrincipalNameForAuth : PWSTR
    remotePrincipalNameForAuth : PWSTR
    numLocalPrincipalGroupSids : UInt32
    localPrincipalGroupSids : PWSTR.Ptr
    numRemotePrincipalGroupSids : UInt32
    remotePrincipalGroupSids : PWSTR.Ptr
}
struct FWPM_NET_EVENT_IKEEXT_MM_FAILURE2 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    flags : UInt32
    keyingModuleType : IKEEXT_KEY_MODULE_TYPE
    mmState : IKEEXT_MM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    mmAuthMethod : IKEEXT_AUTHENTICATION_METHOD_TYPE
    endCertHash : UInt8[20]
    mmId : Int64
    mmFilterId : Int64
    localPrincipalNameForAuth : PWSTR
    remotePrincipalNameForAuth : PWSTR
    numLocalPrincipalGroupSids : UInt32
    localPrincipalGroupSids : PWSTR.Ptr
    numRemotePrincipalGroupSids : UInt32
    remotePrincipalGroupSids : PWSTR.Ptr
    providerContextKey : GUID.Ptr
}
struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE0 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    keyingModuleType : IKEEXT_KEY_MODULE_TYPE
    qmState : IKEEXT_QM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    saTrafficType : IPSEC_TRAFFIC_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    qmFilterId : Int64
    struct _Anonymous1_e__Union {
        union {
            localSubNet : FWP_CONDITION_VALUE0
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteSubNet : FWP_CONDITION_VALUE0
        }
    }
}
struct FWPM_NET_EVENT_IKEEXT_QM_FAILURE1 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    keyingModuleType : IKEEXT_KEY_MODULE_TYPE
    qmState : IKEEXT_QM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    saTrafficType : IPSEC_TRAFFIC_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    qmFilterId : Int64
    mmSaLuid : Int64
    mmProviderContextKey : GUID
    struct _Anonymous1_e__Union {
        union {
            localSubNet : FWP_CONDITION_VALUE0
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteSubNet : FWP_CONDITION_VALUE0
        }
    }
}
struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE0 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    flags : UInt32
    emState : IKEEXT_EM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    emAuthMethod : IKEEXT_AUTHENTICATION_METHOD_TYPE
    endCertHash : UInt8[20]
    mmId : Int64
    qmFilterId : Int64
}
struct FWPM_NET_EVENT_IKEEXT_EM_FAILURE1 {
    failureErrorCode : UInt32
    failurePoint : IPSEC_FAILURE_POINT
    flags : UInt32
    emState : IKEEXT_EM_SA_STATE
    saRole : IKEEXT_SA_ROLE
    emAuthMethod : IKEEXT_AUTHENTICATION_METHOD_TYPE
    endCertHash : UInt8[20]
    mmId : Int64
    qmFilterId : Int64
    localPrincipalNameForAuth : PWSTR
    remotePrincipalNameForAuth : PWSTR
    numLocalPrincipalGroupSids : UInt32
    localPrincipalGroupSids : PWSTR.Ptr
    numRemotePrincipalGroupSids : UInt32
    remotePrincipalGroupSids : PWSTR.Ptr
    saTrafficType : IPSEC_TRAFFIC_TYPE
}
struct FWPM_NET_EVENT_CLASSIFY_DROP0 {
    filterId : Int64
    layerId : UInt16
}
struct FWPM_NET_EVENT_CLASSIFY_DROP1 {
    filterId : Int64
    layerId : UInt16
    reauthReason : UInt32
    originalProfile : UInt32
    currentProfile : UInt32
    msFwpDirection : UInt32
    isLoopback : BOOL
}
struct FWPM_NET_EVENT_CLASSIFY_DROP2 {
    filterId : Int64
    layerId : UInt16
    reauthReason : UInt32
    originalProfile : UInt32
    currentProfile : UInt32
    msFwpDirection : UInt32
    isLoopback : BOOL
    vSwitchId : FWP_BYTE_BLOB
    vSwitchSourcePort : UInt32
    vSwitchDestinationPort : UInt32
}
struct FWPM_NET_EVENT_CLASSIFY_DROP_MAC0 {
    localMacAddr : FWP_BYTE_ARRAY6
    remoteMacAddr : FWP_BYTE_ARRAY6
    mediaType : UInt32
    ifType : UInt32
    etherType : UInt16
    ndisPortNumber : UInt32
    reserved : UInt32
    vlanTag : UInt16
    ifLuid : Int64
    filterId : Int64
    layerId : UInt16
    reauthReason : UInt32
    originalProfile : UInt32
    currentProfile : UInt32
    msFwpDirection : UInt32
    isLoopback : BOOL
    vSwitchId : FWP_BYTE_BLOB
    vSwitchSourcePort : UInt32
    vSwitchDestinationPort : UInt32
}
struct FWPM_NET_EVENT_CLASSIFY_ALLOW0 {
    filterId : Int64
    layerId : UInt16
    reauthReason : UInt32
    originalProfile : UInt32
    currentProfile : UInt32
    msFwpDirection : UInt32
    isLoopback : BOOL
}
struct FWPM_NET_EVENT_IPSEC_KERNEL_DROP0 {
    failureStatus : Int32
    direction : FWP_DIRECTION
    spi : UInt32
    filterId : Int64
    layerId : UInt16
}
struct FWPM_NET_EVENT_IPSEC_DOSP_DROP0 {
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    failureStatus : Int32
    direction : FWP_DIRECTION
    struct _Anonymous1_e__Union {
        union {
            publicHostV4Addr : UInt32
            publicHostV6Addr : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            internalHostV4Addr : UInt32
            internalHostV6Addr : UInt8[16]
        }
    }
}
struct FWPM_APPC_NETWORK_CAPABILITY_TYPE extends Int32 {
    static FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT := 0
    static FWPM_APPC_NETWORK_CAPABILITY_INTERNET_CLIENT_SERVER := 1
    static FWPM_APPC_NETWORK_CAPABILITY_INTERNET_PRIVATE_NETWORK := 2
}
struct FWPM_NET_EVENT_CAPABILITY_DROP0 {
    networkCapabilityId : FWPM_APPC_NETWORK_CAPABILITY_TYPE
    filterId : Int64
    isLoopback : BOOL
}
struct FWPM_NET_EVENT_CAPABILITY_ALLOW0 {
    networkCapabilityId : FWPM_APPC_NETWORK_CAPABILITY_TYPE
    filterId : Int64
    isLoopback : BOOL
}
struct FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0 {
    spi : UInt32
}
struct FWPM_NET_EVENT0 {
    header : FWPM_NET_EVENT_HEADER0
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE0.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE0.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE0.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP0.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
        }
    }
}
struct FWPM_NET_EVENT1 {
    header : FWPM_NET_EVENT_HEADER1
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE1.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE0.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE1.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP1.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
        }
    }
}
struct FWPM_NET_EVENT2 {
    header : FWPM_NET_EVENT_HEADER2
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE1.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE0.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE1.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP2.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
            classifyAllow : FWPM_NET_EVENT_CLASSIFY_ALLOW0.Ptr
            capabilityDrop : FWPM_NET_EVENT_CAPABILITY_DROP0.Ptr
            capabilityAllow : FWPM_NET_EVENT_CAPABILITY_ALLOW0.Ptr
            classifyDropMac : FWPM_NET_EVENT_CLASSIFY_DROP_MAC0.Ptr
        }
    }
}
struct FWPM_NET_EVENT3 {
    header : FWPM_NET_EVENT_HEADER3
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE1.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE0.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE1.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP2.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
            classifyAllow : FWPM_NET_EVENT_CLASSIFY_ALLOW0.Ptr
            capabilityDrop : FWPM_NET_EVENT_CAPABILITY_DROP0.Ptr
            capabilityAllow : FWPM_NET_EVENT_CAPABILITY_ALLOW0.Ptr
            classifyDropMac : FWPM_NET_EVENT_CLASSIFY_DROP_MAC0.Ptr
        }
    }
}
struct FWPM_NET_EVENT4 {
    header : FWPM_NET_EVENT_HEADER3
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE2.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE1.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE1.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP2.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
            classifyAllow : FWPM_NET_EVENT_CLASSIFY_ALLOW0.Ptr
            capabilityDrop : FWPM_NET_EVENT_CAPABILITY_DROP0.Ptr
            capabilityAllow : FWPM_NET_EVENT_CAPABILITY_ALLOW0.Ptr
            classifyDropMac : FWPM_NET_EVENT_CLASSIFY_DROP_MAC0.Ptr
        }
    }
}
struct FWPM_NET_EVENT5 {
    header : FWPM_NET_EVENT_HEADER3
    type : FWPM_NET_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ikeMmFailure : FWPM_NET_EVENT_IKEEXT_MM_FAILURE2.Ptr
            ikeQmFailure : FWPM_NET_EVENT_IKEEXT_QM_FAILURE1.Ptr
            ikeEmFailure : FWPM_NET_EVENT_IKEEXT_EM_FAILURE1.Ptr
            classifyDrop : FWPM_NET_EVENT_CLASSIFY_DROP2.Ptr
            ipsecDrop : FWPM_NET_EVENT_IPSEC_KERNEL_DROP0.Ptr
            idpDrop : FWPM_NET_EVENT_IPSEC_DOSP_DROP0.Ptr
            classifyAllow : FWPM_NET_EVENT_CLASSIFY_ALLOW0.Ptr
            capabilityDrop : FWPM_NET_EVENT_CAPABILITY_DROP0.Ptr
            capabilityAllow : FWPM_NET_EVENT_CAPABILITY_ALLOW0.Ptr
            classifyDropMac : FWPM_NET_EVENT_CLASSIFY_DROP_MAC0.Ptr
            lpmPacketArrival : FWPM_NET_EVENT_LPM_PACKET_ARRIVAL0.Ptr
        }
    }
}
struct FWPM_NET_EVENT_ENUM_TEMPLATE0 {
    startTime : FILETIME
    endTime : FILETIME
    numFilterConditions : UInt32
    filterCondition : FWPM_FILTER_CONDITION0.Ptr
}
struct FWPM_NET_EVENT_SUBSCRIPTION0 {
    enumTemplate : FWPM_NET_EVENT_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_SYSTEM_PORT_TYPE extends Int32 {
    static FWPM_SYSTEM_PORT_RPC_EPMAP := 0
    static FWPM_SYSTEM_PORT_TEREDO := 1
    static FWPM_SYSTEM_PORT_IPHTTPS_IN := 2
    static FWPM_SYSTEM_PORT_IPHTTPS_OUT := 3
    static FWPM_SYSTEM_PORT_TYPE_MAX := 4
}
struct FWPM_SYSTEM_PORTS_BY_TYPE0 {
    type : FWPM_SYSTEM_PORT_TYPE
    numPorts : UInt32
    ports : UInt16.Ptr
}
struct FWPM_SYSTEM_PORTS0 {
    numTypes : UInt32
    types : FWPM_SYSTEM_PORTS_BY_TYPE0.Ptr
}
struct FWPM_CONNECTION0 {
    connectionId : Int64
    ipVersion : FWP_IP_VERSION
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    providerKey : GUID.Ptr
    ipsecTrafficModeType : IPSEC_TRAFFIC_TYPE
    keyModuleType : IKEEXT_KEY_MODULE_TYPE
    mmCrypto : IKEEXT_PROPOSAL0
    mmPeer : IKEEXT_CREDENTIAL2
    emPeer : IKEEXT_CREDENTIAL2
    bytesTransferredIn : Int64
    bytesTransferredOut : Int64
    bytesTransferredTotal : Int64
    startSysTime : FILETIME
    struct _Anonymous1_e__Union {
        union {
            localV4Address : UInt32
            localV6Address : UInt8[16]
        }
    }
    struct _Anonymous2_e__Union {
        union {
            remoteV4Address : UInt32
            remoteV6Address : UInt8[16]
        }
    }
}
struct FWPM_CONNECTION_ENUM_TEMPLATE0 {
    connectionId : Int64
    flags : UInt32
}
struct FWPM_CONNECTION_SUBSCRIPTION0 {
    enumTemplate : FWPM_CONNECTION_ENUM_TEMPLATE0.Ptr
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_CONNECTION_EVENT_TYPE extends Int32 {
    static FWPM_CONNECTION_EVENT_ADD := 0
    static FWPM_CONNECTION_EVENT_DELETE := 1
    static FWPM_CONNECTION_EVENT_MAX := 2
}
struct FWPM_VSWITCH_EVENT_TYPE extends Int32 {
    static FWPM_VSWITCH_EVENT_FILTER_ADD_TO_INCOMPLETE_LAYER := 0
    static FWPM_VSWITCH_EVENT_FILTER_ENGINE_NOT_IN_REQUIRED_POSITION := 1
    static FWPM_VSWITCH_EVENT_ENABLED_FOR_INSPECTION := 2
    static FWPM_VSWITCH_EVENT_DISABLED_FOR_INSPECTION := 3
    static FWPM_VSWITCH_EVENT_FILTER_ENGINE_REORDER := 4
    static FWPM_VSWITCH_EVENT_MAX := 5
}
struct FWPM_VSWITCH_EVENT0 {
    eventType : FWPM_VSWITCH_EVENT_TYPE
    vSwitchId : PWSTR
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            positionInfo : this._positionInfo_e__Struct
            reorderInfo : this._reorderInfo_e__Struct
        }
        struct _positionInfo_e__Struct {
            numvSwitchFilterExtensions : UInt32
            vSwitchFilterExtensions : PWSTR.Ptr
        }
        struct _reorderInfo_e__Struct {
            inRequiredPosition : BOOL
            numvSwitchFilterExtensions : UInt32
            vSwitchFilterExtensions : PWSTR.Ptr
        }
    }
}
struct FWPM_VSWITCH_EVENT_SUBSCRIPTION0 {
    flags : UInt32
    sessionKey : GUID
}
struct FWPM_PROVIDER_CHANGE_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_PROVIDER_CHANGE0.Ptr, "Void"]
}
struct FWPM_PROVIDER_CONTEXT_CHANGE_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_PROVIDER_CONTEXT_CHANGE0.Ptr, "Void"]
}
struct FWPM_SUBLAYER_CHANGE_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_SUBLAYER_CHANGE0.Ptr, "Void"]
}
struct FWPM_CALLOUT_CHANGE_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_CALLOUT_CHANGE0.Ptr, "Void"]
}
struct FWPM_FILTER_CHANGE_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_FILTER_CHANGE0.Ptr, "Void"]
}
struct IPSEC_SA_CONTEXT_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, IPSEC_SA_CONTEXT_CHANGE0.Ptr, "Void"]
}
struct IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0 extends FunctionPointer {
    static Types := [IKEEXT_TRAFFIC0.Ptr, BOOL.Ptr, UInt32.Ptr, "Void"]
}
struct IPSEC_KEY_MANAGER_DICTATE_KEY0 extends FunctionPointer {
    static Types := [IPSEC_SA_DETAILS1.Ptr, IPSEC_SA_DETAILS1.Ptr, BOOL.Ptr, UInt32]
}
struct IPSEC_KEY_MANAGER_NOTIFY_KEY0 extends FunctionPointer {
    static Types := [IPSEC_SA_DETAILS1.Ptr, IPSEC_SA_DETAILS1.Ptr, "Void"]
}
struct IPSEC_KEY_MANAGER_CALLBACKS0 {
    reserved : GUID
    flags : UInt32
    keyDictationCheck : IPSEC_KEY_MANAGER_KEY_DICTATION_CHECK0
    keyDictation : IPSEC_KEY_MANAGER_DICTATE_KEY0
    keyNotify : IPSEC_KEY_MANAGER_NOTIFY_KEY0
}
struct FWPM_NET_EVENT_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_NET_EVENT1.Ptr, "Void"]
}
struct FWPM_NET_EVENT_CALLBACK1 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_NET_EVENT2.Ptr, "Void"]
}
struct FWPM_NET_EVENT_CALLBACK2 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_NET_EVENT3.Ptr, "Void"]
}
struct FWPM_NET_EVENT_CALLBACK3 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_NET_EVENT4.Ptr, "Void"]
}
struct FWPM_NET_EVENT_CALLBACK4 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_NET_EVENT5.Ptr, "Void"]
}
struct FWPM_DYNAMIC_KEYWORD_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct FWPM_SYSTEM_PORTS_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_SYSTEM_PORTS0.Ptr, "Void"]
}
struct FWPM_CONNECTION_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_CONNECTION_EVENT_TYPE, FWPM_CONNECTION0.Ptr, "Void"]
}
struct FWPM_VSWITCH_EVENT_CALLBACK0 extends FunctionPointer {
    static Types := [Struct.Ptr, FWPM_VSWITCH_EVENT0.Ptr, UInt32]
}
