#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, PSTR, PWSTR}

struct DNS_QUERY_OPTIONS extends UInt32 {
    static DNS_QUERY_PARSE_ALL_RECORDS := 0
    static DNS_QUERY_STANDARD := 0
    static DNS_QUERY_ACCEPT_TRUNCATED_RESPONSE := 1
    static DNS_QUERY_USE_TCP_ONLY := 2
    static DNS_QUERY_NO_RECURSION := 4
    static DNS_QUERY_BYPASS_CACHE := 8
    static DNS_QUERY_NO_WIRE_QUERY := 16
    static DNS_QUERY_NO_LOCAL_NAME := 32
    static DNS_QUERY_NO_HOSTS_FILE := 64
    static DNS_QUERY_NO_NETBT := 128
    static DNS_QUERY_WIRE_ONLY := 256
    static DNS_QUERY_RETURN_MESSAGE := 512
    static DNS_QUERY_MULTICAST_ONLY := 1024
    static DNS_QUERY_NO_MULTICAST := 2048
    static DNS_QUERY_TREAT_AS_FQDN := 4096
    static DNS_QUERY_ADDRCONFIG := 8192
    static DNS_QUERY_DUAL_ADDR := 16384
    static DNS_QUERY_DONT_RESET_TTL_VALUES := 1048576
    static DNS_QUERY_DISABLE_IDN_ENCODING := 2097152
    static DNS_QUERY_APPEND_MULTILABEL := 8388608
    static DNS_QUERY_DNSSEC_OK := 16777216
    static DNS_QUERY_DNSSEC_CHECKING_DISABLED := 33554432
    static DNS_QUERY_DNSSEC_REQUIRED := 67108864
    static DNS_QUERY_RESERVED := 4026531840
    static DNS_QUERY_CACHE_ONLY := 16
    static DNS_QUERY_REQUEST_VERSION1 := 1
    static DNS_QUERY_REQUEST_VERSION2 := 2
    static DNS_QUERY_RESULTS_VERSION1 := 1
    static DNS_QUERY_REQUEST_VERSION3 := 3
    static DNS_QUERY_RAW_RESULTS_VERSION1 := 1
    static DNS_QUERY_RAW_REQUEST_VERSION1 := 1
    static DNS_QUERY_RAW_OPTION_BEST_EFFORT_PARSE := 1
}
struct IP6_ADDRESS {
    union {
        IP6Qword : Int64[2]
        IP6Dword : UInt32[4]
        IP6Word : UInt16[8]
        IP6Byte : UInt8[16]
    }
}
struct DNS_HEADER_EXT {
    _bitfield : UInt16
    chRcode : UInt8
    chVersion : UInt8
}
struct DNS_A_DATA {
    IpAddress : UInt32
}
struct DNS_PTR_DATAW {
    pNameHost : PWSTR
}
struct DNS_PTR_DATAA {
    pNameHost : PSTR
}
struct DNS_SOA_DATAW {
    pNamePrimaryServer : PWSTR
    pNameAdministrator : PWSTR
    dwSerialNo : UInt32
    dwRefresh : UInt32
    dwRetry : UInt32
    dwExpire : UInt32
    dwDefaultTtl : UInt32
}
struct DNS_SOA_DATAA {
    pNamePrimaryServer : PSTR
    pNameAdministrator : PSTR
    dwSerialNo : UInt32
    dwRefresh : UInt32
    dwRetry : UInt32
    dwExpire : UInt32
    dwDefaultTtl : UInt32
}
struct DNS_MINFO_DATAW {
    pNameMailbox : PWSTR
    pNameErrorsMailbox : PWSTR
}
struct DNS_MINFO_DATAA {
    pNameMailbox : PSTR
    pNameErrorsMailbox : PSTR
}
struct DNS_MX_DATAW {
    pNameExchange : PWSTR
    wPreference : UInt16
    Pad : UInt16
}
struct DNS_MX_DATAA {
    pNameExchange : PSTR
    wPreference : UInt16
    Pad : UInt16
}
struct DNS_TXT_DATAW {
    dwStringCount : UInt32
    pStringArray : PWSTR[1]
}
struct DNS_TXT_DATAA {
    dwStringCount : UInt32
    pStringArray : PSTR[1]
}
struct DNS_NULL_DATA {
    dwByteCount : UInt32
    Data : UInt8[1]
}
struct DNS_WKS_DATA {
    IpAddress : UInt32
    chProtocol : UInt8
    BitMask : UInt8[1]
}
struct DNS_AAAA_DATA {
    Ip6Address : IP6_ADDRESS
}
struct DNS_SIG_DATAW {
    wTypeCovered : UInt16
    chAlgorithm : UInt8
    chLabelCount : UInt8
    dwOriginalTtl : UInt32
    dwExpiration : UInt32
    dwTimeSigned : UInt32
    wKeyTag : UInt16
    wSignatureLength : UInt16
    pNameSigner : PWSTR
    Signature : UInt8[1]
}
struct DNS_SIG_DATAA {
    wTypeCovered : UInt16
    chAlgorithm : UInt8
    chLabelCount : UInt8
    dwOriginalTtl : UInt32
    dwExpiration : UInt32
    dwTimeSigned : UInt32
    wKeyTag : UInt16
    wSignatureLength : UInt16
    pNameSigner : PSTR
    Signature : UInt8[1]
}
struct DNS_KEY_DATA {
    wFlags : UInt16
    chProtocol : UInt8
    chAlgorithm : UInt8
    wKeyLength : UInt16
    wPad : UInt16
    Key : UInt8[1]
}
struct DNS_DHCID_DATA {
    dwByteCount : UInt32
    DHCID : UInt8[1]
}
struct DNS_NSEC_DATAW {
    pNextDomainName : PWSTR
    wTypeBitMapsLength : UInt16
    wPad : UInt16
    TypeBitMaps : UInt8[1]
}
struct DNS_NSEC_DATAA {
    pNextDomainName : PSTR
    wTypeBitMapsLength : UInt16
    wPad : UInt16
    TypeBitMaps : UInt8[1]
}
struct DNS_NSEC3_DATA {
    chAlgorithm : UInt8
    bFlags : UInt8
    wIterations : UInt16
    bSaltLength : UInt8
    bHashLength : UInt8
    wTypeBitMapsLength : UInt16
    chData : UInt8[1]
}
struct DNS_NSEC3PARAM_DATA {
    chAlgorithm : UInt8
    bFlags : UInt8
    wIterations : UInt16
    bSaltLength : UInt8
    bPad : UInt8[3]
    pbSalt : UInt8[1]
}
struct DNS_TLSA_DATA {
    bCertUsage : UInt8
    bSelector : UInt8
    bMatchingType : UInt8
    bCertificateAssociationDataLength : UInt16
    bPad : UInt8[3]
    bCertificateAssociationData : UInt8[1]
}
struct DNS_DS_DATA {
    wKeyTag : UInt16
    chAlgorithm : UInt8
    chDigestType : UInt8
    wDigestLength : UInt16
    wPad : UInt16
    Digest : UInt8[1]
}
struct DNS_OPT_DATA {
    wDataLength : UInt16
    wPad : UInt16
    Data : UInt8[1]
}
struct DNS_LOC_DATA {
    wVersion : UInt16
    wSize : UInt16
    wHorPrec : UInt16
    wVerPrec : UInt16
    dwLatitude : UInt32
    dwLongitude : UInt32
    dwAltitude : UInt32
}
struct DNS_NXT_DATAW {
    pNameNext : PWSTR
    wNumTypes : UInt16
    wTypes : UInt16[1]
}
struct DNS_NXT_DATAA {
    pNameNext : PSTR
    wNumTypes : UInt16
    wTypes : UInt16[1]
}
struct DNS_SRV_DATAW {
    pNameTarget : PWSTR
    wPriority : UInt16
    wWeight : UInt16
    wPort : UInt16
    Pad : UInt16
}
struct DNS_SRV_DATAA {
    pNameTarget : PSTR
    wPriority : UInt16
    wWeight : UInt16
    wPort : UInt16
    Pad : UInt16
}
struct DNS_NAPTR_DATAW {
    wOrder : UInt16
    wPreference : UInt16
    pFlags : PWSTR
    pService : PWSTR
    pRegularExpression : PWSTR
    pReplacement : PWSTR
}
struct DNS_NAPTR_DATAA {
    wOrder : UInt16
    wPreference : UInt16
    pFlags : PSTR
    pService : PSTR
    pRegularExpression : PSTR
    pReplacement : PSTR
}
struct DNS_ATMA_DATA {
    AddressType : UInt8
    Address : UInt8[20]
}
struct DNS_TKEY_DATAW {
    pNameAlgorithm : PWSTR
    pAlgorithmPacket : UInt8.Ptr
    pKey : UInt8.Ptr
    pOtherData : UInt8.Ptr
    dwCreateTime : UInt32
    dwExpireTime : UInt32
    wMode : UInt16
    wError : UInt16
    wKeyLength : UInt16
    wOtherLength : UInt16
    cAlgNameLength : UInt8
    bPacketPointers : BOOL
}
struct DNS_TKEY_DATAA {
    pNameAlgorithm : PSTR
    pAlgorithmPacket : UInt8.Ptr
    pKey : UInt8.Ptr
    pOtherData : UInt8.Ptr
    dwCreateTime : UInt32
    dwExpireTime : UInt32
    wMode : UInt16
    wError : UInt16
    wKeyLength : UInt16
    wOtherLength : UInt16
    cAlgNameLength : UInt8
    bPacketPointers : BOOL
}
struct DNS_TSIG_DATAW {
    pNameAlgorithm : PWSTR
    pAlgorithmPacket : UInt8.Ptr
    pSignature : UInt8.Ptr
    pOtherData : UInt8.Ptr
    i64CreateTime : Int64
    wFudgeTime : UInt16
    wOriginalXid : UInt16
    wError : UInt16
    wSigLength : UInt16
    wOtherLength : UInt16
    cAlgNameLength : UInt8
    bPacketPointers : BOOL
}
struct DNS_TSIG_DATAA {
    pNameAlgorithm : PSTR
    pAlgorithmPacket : UInt8.Ptr
    pSignature : UInt8.Ptr
    pOtherData : UInt8.Ptr
    i64CreateTime : Int64
    wFudgeTime : UInt16
    wOriginalXid : UInt16
    wError : UInt16
    wSigLength : UInt16
    wOtherLength : UInt16
    cAlgNameLength : UInt8
    bPacketPointers : BOOL
}
struct DNS_UNKNOWN_DATA {
    dwByteCount : UInt32
    bData : UInt8[1]
}
struct DNS_WINS_DATA {
    dwMappingFlag : UInt32
    dwLookupTimeout : UInt32
    dwCacheTimeout : UInt32
    cWinsServerCount : UInt32
    WinsServers : UInt32[1]
}
struct DNS_WINSR_DATAW {
    dwMappingFlag : UInt32
    dwLookupTimeout : UInt32
    dwCacheTimeout : UInt32
    pNameResultDomain : PWSTR
}
struct DNS_WINSR_DATAA {
    dwMappingFlag : UInt32
    dwLookupTimeout : UInt32
    dwCacheTimeout : UInt32
    pNameResultDomain : PSTR
}
struct DNS_SVCB_PARAM_TYPE extends Int32 {
    static DnsSvcbParamMandatory := 0
    static DnsSvcbParamAlpn := 1
    static DnsSvcbParamNoDefaultAlpn := 2
    static DnsSvcbParamPort := 3
    static DnsSvcbParamIpv4Hint := 4
    static DnsSvcbParamEch := 5
    static DnsSvcbParamIpv6Hint := 6
    static DnsSvcbParamDohPath := 7
    static DnsSvcbParamDohPathOpenDns := 65432
}
struct DNS_SVCB_PARAM_MANDATORY {
    cMandatoryKeys : UInt16
    rgwMandatoryKeys : UInt16[1]
}
struct DNS_SVCB_PARAM_ALPN_ID {
    cBytes : UInt8
    pbId : UInt8.Ptr
}
struct DNS_SVCB_PARAM_ALPN {
    cIds : UInt16
    rgIds : DNS_SVCB_PARAM_ALPN_ID[1]
}
struct DNS_SVCB_PARAM_IPV4 {
    cIps : UInt16
    rgIps : UInt32[1]
}
struct DNS_SVCB_PARAM_IPV6 {
    cIps : UInt16
    rgIps : IP6_ADDRESS[1]
}
struct DNS_SVCB_PARAM_UNKNOWN {
    cBytes : UInt16
    pbSvcParamValue : UInt8[1]
}
struct DNS_SVCB_PARAM {
    wSvcParamKey : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pIpv4Hints : DNS_SVCB_PARAM_IPV4.Ptr
            pIpv6Hints : DNS_SVCB_PARAM_IPV6.Ptr
            pMandatory : DNS_SVCB_PARAM_MANDATORY.Ptr
            pAlpn : DNS_SVCB_PARAM_ALPN.Ptr
            wPort : UInt16
            pUnknown : DNS_SVCB_PARAM_UNKNOWN.Ptr
            pszDohPath : PSTR
            pReserved : Struct.Ptr
        }
    }
}
struct DNS_SVCB_DATA {
    wSvcPriority : UInt16
    pszTargetName : PSTR
    cSvcParams : UInt16
    pSvcParams : DNS_SVCB_PARAM.Ptr
}
struct DNS_RECORD_FLAGS {
    _bitfield : UInt32
}
struct DNS_SECTION extends Int32 {
    static DnsSectionQuestion := 0
    static DnsSectionAnswer := 1
    static DnsSectionAuthority := 2
    static DnsSectionAddtional := 3
}
struct DNS_RECORDW {
    pNext : DNS_RECORDW.Ptr
    pName : PWSTR
    wType : UInt16
    wDataLength : UInt16
    Flags : this._Flags_e__Union
    dwTtl : UInt32
    dwReserved : UInt32
    Data : this._Data_e__Union
    struct _Flags_e__Union {
        union {
            DW : UInt32
            S : DNS_RECORD_FLAGS
        }
    }
    struct _Data_e__Union {
        union {
            A : DNS_A_DATA
            SOA_1 : DNS_SOA_DATAW
            Soa_2 : DNS_SOA_DATAW
            PTR_1 : DNS_PTR_DATAW
            Ptr_2 : DNS_PTR_DATAW
            NS_1 : DNS_PTR_DATAW
            Ns_2 : DNS_PTR_DATAW
            CNAME_1 : DNS_PTR_DATAW
            Cname_2 : DNS_PTR_DATAW
            DNAME_1 : DNS_PTR_DATAW
            Dname_2 : DNS_PTR_DATAW
            MB_1 : DNS_PTR_DATAW
            Mb_2 : DNS_PTR_DATAW
            MD_1 : DNS_PTR_DATAW
            Md_2 : DNS_PTR_DATAW
            MF_1 : DNS_PTR_DATAW
            Mf_2 : DNS_PTR_DATAW
            MG_1 : DNS_PTR_DATAW
            Mg_2 : DNS_PTR_DATAW
            MR_1 : DNS_PTR_DATAW
            Mr_2 : DNS_PTR_DATAW
            MINFO_1 : DNS_MINFO_DATAW
            Minfo_2 : DNS_MINFO_DATAW
            RP_1 : DNS_MINFO_DATAW
            Rp_2 : DNS_MINFO_DATAW
            MX_1 : DNS_MX_DATAW
            Mx_2 : DNS_MX_DATAW
            AFSDB_1 : DNS_MX_DATAW
            Afsdb_2 : DNS_MX_DATAW
            RT_1 : DNS_MX_DATAW
            Rt_2 : DNS_MX_DATAW
            HINFO_1 : DNS_TXT_DATAW
            Hinfo_2 : DNS_TXT_DATAW
            ISDN_1 : DNS_TXT_DATAW
            Isdn_2 : DNS_TXT_DATAW
            TXT_1 : DNS_TXT_DATAW
            Txt_2 : DNS_TXT_DATAW
            X25 : DNS_TXT_DATAW
            Null : DNS_NULL_DATA
            WKS_1 : DNS_WKS_DATA
            Wks_2 : DNS_WKS_DATA
            AAAA : DNS_AAAA_DATA
            KEY_1 : DNS_KEY_DATA
            Key_2 : DNS_KEY_DATA
            SIG_1 : DNS_SIG_DATAW
            Sig_2 : DNS_SIG_DATAW
            ATMA_1 : DNS_ATMA_DATA
            Atma_2 : DNS_ATMA_DATA
            NXT_1 : DNS_NXT_DATAW
            Nxt_2 : DNS_NXT_DATAW
            SRV_1 : DNS_SRV_DATAW
            Srv_2 : DNS_SRV_DATAW
            NAPTR_1 : DNS_NAPTR_DATAW
            Naptr_2 : DNS_NAPTR_DATAW
            OPT_1 : DNS_OPT_DATA
            Opt_2 : DNS_OPT_DATA
            DS_1 : DNS_DS_DATA
            Ds_2 : DNS_DS_DATA
            RRSIG_1 : DNS_SIG_DATAW
            Rrsig_2 : DNS_SIG_DATAW
            NSEC_1 : DNS_NSEC_DATAW
            Nsec_2 : DNS_NSEC_DATAW
            DNSKEY_1 : DNS_KEY_DATA
            Dnskey_2 : DNS_KEY_DATA
            TKEY_1 : DNS_TKEY_DATAW
            Tkey_2 : DNS_TKEY_DATAW
            TSIG_1 : DNS_TSIG_DATAW
            Tsig_2 : DNS_TSIG_DATAW
            WINS_1 : DNS_WINS_DATA
            Wins_2 : DNS_WINS_DATA
            WINSR_1 : DNS_WINSR_DATAW
            WinsR_2 : DNS_WINSR_DATAW
            NBSTAT_1 : DNS_WINSR_DATAW
            Nbstat_2 : DNS_WINSR_DATAW
            DHCID : DNS_DHCID_DATA
            NSEC3_1 : DNS_NSEC3_DATA
            Nsec3_2 : DNS_NSEC3_DATA
            NSEC3PARAM_1 : DNS_NSEC3PARAM_DATA
            Nsec3Param_2 : DNS_NSEC3PARAM_DATA
            TLSA_1 : DNS_TLSA_DATA
            Tlsa_2 : DNS_TLSA_DATA
            SVCB_1 : DNS_SVCB_DATA
            Svcb_2 : DNS_SVCB_DATA
            UNKNOWN_1 : DNS_UNKNOWN_DATA
            Unknown_2 : DNS_UNKNOWN_DATA
            pDataPtr : UInt8.Ptr
        }
    }
}
struct DNS_RECORD_OPTW {
    pNext : DNS_RECORDW.Ptr
    pName : PWSTR
    wType : UInt16
    wDataLength : UInt16
    Flags : this._Flags_e__Union
    ExtHeader : DNS_HEADER_EXT
    wPayloadSize : UInt16
    wReserved : UInt16
    Data : this._Data_e__Union
    struct _Flags_e__Union {
        union {
            DW : UInt32
            S : DNS_RECORD_FLAGS
        }
    }
    struct _Data_e__Union {
        union {
            OPT_1 : DNS_OPT_DATA
            Opt_2 : DNS_OPT_DATA
        }
    }
}
struct DNS_RECORDA {
    pNext : DNS_RECORDA.Ptr
    pName : PSTR
    wType : UInt16
    wDataLength : UInt16
    Flags : this._Flags_e__Union
    dwTtl : UInt32
    dwReserved : UInt32
    Data : this._Data_e__Union
    struct _Flags_e__Union {
        union {
            DW : UInt32
            S : DNS_RECORD_FLAGS
        }
    }
    struct _Data_e__Union {
        union {
            A : DNS_A_DATA
            SOA_1 : DNS_SOA_DATAA
            Soa_2 : DNS_SOA_DATAA
            PTR_1 : DNS_PTR_DATAA
            Ptr_2 : DNS_PTR_DATAA
            NS_1 : DNS_PTR_DATAA
            Ns_2 : DNS_PTR_DATAA
            CNAME_1 : DNS_PTR_DATAA
            Cname_2 : DNS_PTR_DATAA
            DNAME_1 : DNS_PTR_DATAA
            Dname_2 : DNS_PTR_DATAA
            MB_1 : DNS_PTR_DATAA
            Mb_2 : DNS_PTR_DATAA
            MD_1 : DNS_PTR_DATAA
            Md_2 : DNS_PTR_DATAA
            MF_1 : DNS_PTR_DATAA
            Mf_2 : DNS_PTR_DATAA
            MG_1 : DNS_PTR_DATAA
            Mg_2 : DNS_PTR_DATAA
            MR_1 : DNS_PTR_DATAA
            Mr_2 : DNS_PTR_DATAA
            MINFO_1 : DNS_MINFO_DATAA
            Minfo_2 : DNS_MINFO_DATAA
            RP_1 : DNS_MINFO_DATAA
            Rp_2 : DNS_MINFO_DATAA
            MX_1 : DNS_MX_DATAA
            Mx_2 : DNS_MX_DATAA
            AFSDB_1 : DNS_MX_DATAA
            Afsdb_2 : DNS_MX_DATAA
            RT_1 : DNS_MX_DATAA
            Rt_2 : DNS_MX_DATAA
            HINFO_1 : DNS_TXT_DATAA
            Hinfo_2 : DNS_TXT_DATAA
            ISDN_1 : DNS_TXT_DATAA
            Isdn_2 : DNS_TXT_DATAA
            TXT_1 : DNS_TXT_DATAA
            Txt_2 : DNS_TXT_DATAA
            X25 : DNS_TXT_DATAA
            Null : DNS_NULL_DATA
            WKS_1 : DNS_WKS_DATA
            Wks_2 : DNS_WKS_DATA
            AAAA : DNS_AAAA_DATA
            KEY_1 : DNS_KEY_DATA
            Key_2 : DNS_KEY_DATA
            SIG_1 : DNS_SIG_DATAA
            Sig_2 : DNS_SIG_DATAA
            ATMA_1 : DNS_ATMA_DATA
            Atma_2 : DNS_ATMA_DATA
            NXT_1 : DNS_NXT_DATAA
            Nxt_2 : DNS_NXT_DATAA
            SRV_1 : DNS_SRV_DATAA
            Srv_2 : DNS_SRV_DATAA
            NAPTR_1 : DNS_NAPTR_DATAA
            Naptr_2 : DNS_NAPTR_DATAA
            OPT_1 : DNS_OPT_DATA
            Opt_2 : DNS_OPT_DATA
            DS_1 : DNS_DS_DATA
            Ds_2 : DNS_DS_DATA
            RRSIG_1 : DNS_SIG_DATAA
            Rrsig_2 : DNS_SIG_DATAA
            NSEC_1 : DNS_NSEC_DATAA
            Nsec_2 : DNS_NSEC_DATAA
            DNSKEY_1 : DNS_KEY_DATA
            Dnskey_2 : DNS_KEY_DATA
            TKEY_1 : DNS_TKEY_DATAA
            Tkey_2 : DNS_TKEY_DATAA
            TSIG_1 : DNS_TSIG_DATAA
            Tsig_2 : DNS_TSIG_DATAA
            WINS_1 : DNS_WINS_DATA
            Wins_2 : DNS_WINS_DATA
            WINSR_1 : DNS_WINSR_DATAA
            WinsR_2 : DNS_WINSR_DATAA
            NBSTAT_1 : DNS_WINSR_DATAA
            Nbstat_2 : DNS_WINSR_DATAA
            DHCID : DNS_DHCID_DATA
            NSEC3_1 : DNS_NSEC3_DATA
            Nsec3_2 : DNS_NSEC3_DATA
            NSEC3PARAM_1 : DNS_NSEC3PARAM_DATA
            Nsec3Param_2 : DNS_NSEC3PARAM_DATA
            TLSA_1 : DNS_TLSA_DATA
            Tlsa_2 : DNS_TLSA_DATA
            SVCB_1 : DNS_SVCB_DATA
            Svcb_2 : DNS_SVCB_DATA
            UNKNOWN_1 : DNS_UNKNOWN_DATA
            Unknown_2 : DNS_UNKNOWN_DATA
            pDataPtr : UInt8.Ptr
        }
    }
}
struct DnsRecordOptA {
    pNext : DNS_RECORDA.Ptr
    pName : PSTR
    wType : UInt16
    wDataLength : UInt16
    Flags : this._Flags_e__Union
    ExtHeader : DNS_HEADER_EXT
    wPayloadSize : UInt16
    wReserved : UInt16
    Data : this._Data_e__Union
    struct _Flags_e__Union {
        union {
            DW : UInt32
            S : DNS_RECORD_FLAGS
        }
    }
    struct _Data_e__Union {
        union {
            OPT_1 : DNS_OPT_DATA
            Opt_2 : DNS_OPT_DATA
        }
    }
}
struct DNS_ADDR {
    MaxSa : CHAR[32]
    Data : this._Data_e__Union
    struct _Data_e__Union {
        union {
            DnsAddrUserDword : UInt32[8]
        }
    }
}
struct DNS_ADDR_ARRAY {
    MaxCount : UInt32
    AddrCount : UInt32
    Tag : UInt32
    Family : UInt16
    WordReserved : UInt16
    Flags : UInt32
    MatchFlag : UInt32
    Reserved1 : UInt32
    Reserved2 : UInt32
    AddrArray : DNS_ADDR[1]
}
struct DNS_HEADER {
    Xid : UInt16
    _bitfield1 : UInt8
    _bitfield2 : UInt8
    QuestionCount : UInt16
    AnswerCount : UInt16
    NameServerCount : UInt16
    AdditionalCount : UInt16
}
struct DNS_CHARSET extends Int32 {
    static DnsCharSetUnknown := 0
    static DnsCharSetUnicode := 1
    static DnsCharSetUtf8 := 2
    static DnsCharSetAnsi := 3
}
struct DNS_MESSAGE_BUFFER {
    MessageHead : DNS_HEADER
    MessageBody : CHAR[1]
}
struct DNS_CUSTOM_SERVER {
    dwServerType : UInt32
    ullFlags : Int64
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            pwszTemplate : PWSTR
            pwszHostname : PWSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            MaxSa : CHAR[32]
        }
    }
}
struct IP4_ARRAY {
    AddrCount : UInt32
    AddrArray : UInt32[1]
}
struct DNS_WIRE_QUESTION {
    QuestionType : UInt16
    QuestionClass : UInt16
}
struct DNS_WIRE_RECORD {
    RecordType : UInt16
    RecordClass : UInt16
    TimeToLive : UInt32
    DataLength : UInt16
}
struct DNS_CONFIG_TYPE extends Int32 {
    static DnsConfigPrimaryDomainName_W := 0
    static DnsConfigPrimaryDomainName_A := 1
    static DnsConfigPrimaryDomainName_UTF8 := 2
    static DnsConfigAdapterDomainName_W := 3
    static DnsConfigAdapterDomainName_A := 4
    static DnsConfigAdapterDomainName_UTF8 := 5
    static DnsConfigDnsServerList := 6
    static DnsConfigSearchList := 7
    static DnsConfigAdapterInfo := 8
    static DnsConfigPrimaryHostNameRegistrationEnabled := 9
    static DnsConfigAdapterHostNameRegistrationEnabled := 10
    static DnsConfigAddressRegistrationMaxCount := 11
    static DnsConfigHostName_W := 12
    static DnsConfigHostName_A := 13
    static DnsConfigHostName_UTF8 := 14
    static DnsConfigFullHostName_W := 15
    static DnsConfigFullHostName_A := 16
    static DnsConfigFullHostName_UTF8 := 17
    static DnsConfigNameServer := 18
}
struct DNS_RRSET {
    pFirstRR : DNS_RECORDA.Ptr
    pLastRR : DNS_RECORDA.Ptr
}
struct DNS_PROXY_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, "Void"]
}
struct DNS_PROXY_INFORMATION_TYPE extends Int32 {
    static DNS_PROXY_INFORMATION_DIRECT := 0
    static DNS_PROXY_INFORMATION_DEFAULT_SETTINGS := 1
    static DNS_PROXY_INFORMATION_PROXY_NAME := 2
    static DNS_PROXY_INFORMATION_DOES_NOT_EXIST := 3
}
struct DNS_PROXY_INFORMATION {
    version : UInt32
    proxyInformationType : DNS_PROXY_INFORMATION_TYPE
    proxyName : PWSTR
}
struct DNS_FREE_TYPE extends Int32 {
    static DnsFreeFlat := 0
    static DnsFreeRecordList := 1
    static DnsFreeParsedMessageFields := 2
}
struct DNS_QUERY_RESULT {
    Version : UInt32
    QueryStatus : Int32
    QueryOptions : Int64
    pQueryRecords : DNS_RECORDA.Ptr
    Reserved : Struct.Ptr
}
struct PDNS_QUERY_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, DNS_QUERY_RESULT.Ptr, "Void"]
}
struct DNS_APPLICATION_SETTINGS {
    Version : UInt32
    Flags : Int64
}
struct DNS_QUERY_REQUEST {
    Version : UInt32
    QueryName : PWSTR
    QueryType : UInt16
    QueryOptions : Int64
    pDnsServerList : DNS_ADDR_ARRAY.Ptr
    InterfaceIndex : UInt32
    pQueryCompletionCallback : PDNS_QUERY_COMPLETION_ROUTINE
    pQueryContext : Struct.Ptr
}
struct DNS_QUERY_CANCEL {
    Reserved : CHAR[32]
}
struct DNS_QUERY_REQUEST3 {
    Version : UInt32
    QueryName : PWSTR
    QueryType : UInt16
    QueryOptions : Int64
    pDnsServerList : DNS_ADDR_ARRAY.Ptr
    InterfaceIndex : UInt32
    pQueryCompletionCallback : PDNS_QUERY_COMPLETION_ROUTINE
    pQueryContext : Struct.Ptr
    IsNetworkQueryRequired : BOOL
    RequiredNetworkIndex : UInt32
    cCustomServers : UInt32
    pCustomServers : DNS_CUSTOM_SERVER.Ptr
}
struct DNS_QUERY_RAW_RESULT {
    version : UInt32
    queryStatus : Int32
    queryOptions : Int64
    queryRawOptions : Int64
    responseFlags : Int64
    queryRawResponseSize : UInt32
    queryRawResponse : UInt8.Ptr
    queryRecords : DNS_RECORDA.Ptr
    protocol : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            maxSa : CHAR[32]
        }
    }
}
struct DNS_QUERY_RAW_COMPLETION_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, DNS_QUERY_RAW_RESULT.Ptr, "Void"]
}
struct DNS_QUERY_RAW_REQUEST {
    version : UInt32
    resultsVersion : UInt32
    dnsQueryRawSize : UInt32
    dnsQueryRaw : UInt8.Ptr
    dnsQueryName : PWSTR
    dnsQueryType : UInt16
    queryOptions : Int64
    interfaceIndex : UInt32
    queryCompletionCallback : DNS_QUERY_RAW_COMPLETION_ROUTINE
    queryContext : Struct.Ptr
    queryRawOptions : Int64
    customServersSize : UInt32
    customServers : DNS_CUSTOM_SERVER.Ptr
    protocol : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            maxSa : CHAR[32]
        }
    }
}
struct DNS_QUERY_RAW_CANCEL {
    reserved : CHAR[32]
}
struct DNS_NAME_FORMAT extends Int32 {
    static DnsNameDomain := 0
    static DnsNameDomainLabel := 1
    static DnsNameHostnameFull := 2
    static DnsNameHostnameLabel := 3
    static DnsNameWildcard := 4
    static DnsNameSrvRecord := 5
    static DnsNameValidateTld := 6
}
struct DNS_CONNECTION_PROXY_TYPE extends Int32 {
    static DNS_CONNECTION_PROXY_TYPE_NULL := 0
    static DNS_CONNECTION_PROXY_TYPE_HTTP := 1
    static DNS_CONNECTION_PROXY_TYPE_WAP := 2
    static DNS_CONNECTION_PROXY_TYPE_SOCKS4 := 4
    static DNS_CONNECTION_PROXY_TYPE_SOCKS5 := 5
}
struct DNS_CONNECTION_PROXY_INFO_SWITCH extends Int32 {
    static DNS_CONNECTION_PROXY_INFO_SWITCH_CONFIG := 0
    static DNS_CONNECTION_PROXY_INFO_SWITCH_SCRIPT := 1
    static DNS_CONNECTION_PROXY_INFO_SWITCH_WPAD := 2
}
struct DNS_CONNECTION_PROXY_INFO {
    Version : UInt32
    pwszFriendlyName : PWSTR
    Flags : UInt32
    Switch : DNS_CONNECTION_PROXY_INFO_SWITCH
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Config : this._DNS_CONNECTION_PROXY_INFO_CONFIG
            Script : this._DNS_CONNECTION_PROXY_INFO_SCRIPT
        }
        struct _DNS_CONNECTION_PROXY_INFO_CONFIG {
            pwszServer : PWSTR
            pwszUsername : PWSTR
            pwszPassword : PWSTR
            pwszException : PWSTR
            pwszExtraInfo : PWSTR
            Port : UInt16
        }
        struct _DNS_CONNECTION_PROXY_INFO_SCRIPT {
            pwszScript : PWSTR
            pwszUsername : PWSTR
            pwszPassword : PWSTR
        }
    }
}
struct DNS_CONNECTION_PROXY_INFO_EX {
    ProxyInfo : DNS_CONNECTION_PROXY_INFO
    dwInterfaceIndex : UInt32
    pwszConnectionName : PWSTR
    fDirectConfiguration : BOOL
    hConnection : HANDLE
}
struct DNS_CONNECTION_PROXY_ELEMENT {
    Type : DNS_CONNECTION_PROXY_TYPE
    Info : DNS_CONNECTION_PROXY_INFO
}
struct DNS_CONNECTION_PROXY_LIST {
    cProxies : UInt32
    pProxies : DNS_CONNECTION_PROXY_ELEMENT.Ptr
}
struct DNS_CONNECTION_NAME {
    wszName : UInt16[65]
}
struct DNS_CONNECTION_NAME_LIST {
    cNames : UInt32
    pNames : DNS_CONNECTION_NAME.Ptr
}
struct DNS_CONNECTION_IFINDEX_ENTRY {
    pwszConnectionName : PWSTR
    dwIfIndex : UInt32
}
struct DNS_CONNECTION_IFINDEX_LIST {
    pConnectionIfIndexEntries : DNS_CONNECTION_IFINDEX_ENTRY.Ptr
    nEntries : UInt32
}
struct DNS_CONNECTION_POLICY_ENTRY {
    pwszHost : PWSTR
    pwszAppId : PWSTR
    cbAppSid : UInt32
    pbAppSid : UInt8.Ptr
    nConnections : UInt32
    ppwszConnections : PWSTR.Ptr
    dwPolicyEntryFlags : UInt32
}
struct DNS_CONNECTION_POLICY_ENTRY_LIST {
    pPolicyEntries : DNS_CONNECTION_POLICY_ENTRY.Ptr
    nEntries : UInt32
}
struct DNS_CONNECTION_POLICY_TAG extends Int32 {
    static TAG_DNS_CONNECTION_POLICY_TAG_DEFAULT := 0
    static TAG_DNS_CONNECTION_POLICY_TAG_CONNECTION_MANAGER := 1
    static TAG_DNS_CONNECTION_POLICY_TAG_WWWPT := 2
}
struct DNS_SERVICE_INSTANCE {
    pszInstanceName : PWSTR
    pszHostName : PWSTR
    ip4Address : UInt32.Ptr
    ip6Address : IP6_ADDRESS.Ptr
    wPort : UInt16
    wPriority : UInt16
    wWeight : UInt16
    dwPropertyCount : UInt32
    keys : PWSTR.Ptr
    values : PWSTR.Ptr
    dwInterfaceIndex : UInt32
}
struct DNS_SERVICE_CANCEL {
    reserved : Struct.Ptr
}
struct PDNS_SERVICE_BROWSE_CALLBACK extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, DNS_RECORDW.Ptr, "Void"]
}
struct DNS_SERVICE_BROWSE_REQUEST {
    Version : UInt32
    InterfaceIndex : UInt32
    QueryName : PWSTR
    Anonymous : this._Anonymous_e__Union
    pQueryContext : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            pBrowseCallback : PDNS_SERVICE_BROWSE_CALLBACK
            pBrowseCallbackV2 : PDNS_QUERY_COMPLETION_ROUTINE
        }
    }
}
struct PDNS_SERVICE_RESOLVE_COMPLETE extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, DNS_SERVICE_INSTANCE.Ptr, "Void"]
}
struct DNS_SERVICE_RESOLVE_REQUEST {
    Version : UInt32
    InterfaceIndex : UInt32
    QueryName : PWSTR
    pResolveCompletionCallback : PDNS_SERVICE_RESOLVE_COMPLETE
    pQueryContext : Struct.Ptr
}
struct PDNS_SERVICE_REGISTER_COMPLETE extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, DNS_SERVICE_INSTANCE.Ptr, "Void"]
}
struct DNS_SERVICE_REGISTER_REQUEST {
    Version : UInt32
    InterfaceIndex : UInt32
    pServiceInstance : DNS_SERVICE_INSTANCE.Ptr
    pRegisterCompletionCallback : PDNS_SERVICE_REGISTER_COMPLETE
    pQueryContext : Struct.Ptr
    hCredentials : HANDLE
    unicastEnabled : BOOL
}
struct MDNS_QUERY_HANDLE {
    nameBuf : UInt16[256]
    wType : UInt16
    pSubscription : Struct.Ptr
    pWnfCallbackParams : Struct.Ptr
    stateNameData : UInt32[2]
}
struct PMDNS_QUERY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, MDNS_QUERY_HANDLE.Ptr, DNS_QUERY_RESULT.Ptr, "Void"]
}
struct MDNS_QUERY_REQUEST {
    Version : UInt32
    ulRefCount : UInt32
    Query : PWSTR
    QueryType : UInt16
    QueryOptions : Int64
    InterfaceIndex : UInt32
    pQueryCallback : PMDNS_QUERY_CALLBACK
    pQueryContext : Struct.Ptr
    fAnswerReceived : BOOL
    ulResendCount : UInt32
}
