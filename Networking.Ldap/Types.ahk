#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, PSTR, PWSTR}
#Import "..\Security.Authentication.Identity\Types.ahk" {SecPkgContext_IssuerListInfoEx}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT}

struct PLDAPSearch {
    Value : IntPtr
}
struct LDAP_RETCODE extends Int32 {
    static LDAP_SUCCESS := 0
    static LDAP_OPERATIONS_ERROR := 1
    static LDAP_PROTOCOL_ERROR := 2
    static LDAP_TIMELIMIT_EXCEEDED := 3
    static LDAP_SIZELIMIT_EXCEEDED := 4
    static LDAP_COMPARE_FALSE := 5
    static LDAP_COMPARE_TRUE := 6
    static LDAP_AUTH_METHOD_NOT_SUPPORTED := 7
    static LDAP_STRONG_AUTH_REQUIRED := 8
    static LDAP_REFERRAL_V2 := 9
    static LDAP_PARTIAL_RESULTS := 9
    static LDAP_REFERRAL := 10
    static LDAP_ADMIN_LIMIT_EXCEEDED := 11
    static LDAP_UNAVAILABLE_CRIT_EXTENSION := 12
    static LDAP_CONFIDENTIALITY_REQUIRED := 13
    static LDAP_SASL_BIND_IN_PROGRESS := 14
    static LDAP_NO_SUCH_ATTRIBUTE := 16
    static LDAP_UNDEFINED_TYPE := 17
    static LDAP_INAPPROPRIATE_MATCHING := 18
    static LDAP_CONSTRAINT_VIOLATION := 19
    static LDAP_ATTRIBUTE_OR_VALUE_EXISTS := 20
    static LDAP_INVALID_SYNTAX := 21
    static LDAP_NO_SUCH_OBJECT := 32
    static LDAP_ALIAS_PROBLEM := 33
    static LDAP_INVALID_DN_SYNTAX := 34
    static LDAP_IS_LEAF := 35
    static LDAP_ALIAS_DEREF_PROBLEM := 36
    static LDAP_INAPPROPRIATE_AUTH := 48
    static LDAP_INVALID_CREDENTIALS := 49
    static LDAP_INSUFFICIENT_RIGHTS := 50
    static LDAP_BUSY := 51
    static LDAP_UNAVAILABLE := 52
    static LDAP_UNWILLING_TO_PERFORM := 53
    static LDAP_LOOP_DETECT := 54
    static LDAP_SORT_CONTROL_MISSING := 60
    static LDAP_OFFSET_RANGE_ERROR := 61
    static LDAP_NAMING_VIOLATION := 64
    static LDAP_OBJECT_CLASS_VIOLATION := 65
    static LDAP_NOT_ALLOWED_ON_NONLEAF := 66
    static LDAP_NOT_ALLOWED_ON_RDN := 67
    static LDAP_ALREADY_EXISTS := 68
    static LDAP_NO_OBJECT_CLASS_MODS := 69
    static LDAP_RESULTS_TOO_LARGE := 70
    static LDAP_AFFECTS_MULTIPLE_DSAS := 71
    static LDAP_VIRTUAL_LIST_VIEW_ERROR := 76
    static LDAP_OTHER := 80
    static LDAP_SERVER_DOWN := 81
    static LDAP_LOCAL_ERROR := 82
    static LDAP_ENCODING_ERROR := 83
    static LDAP_DECODING_ERROR := 84
    static LDAP_TIMEOUT := 85
    static LDAP_AUTH_UNKNOWN := 86
    static LDAP_FILTER_ERROR := 87
    static LDAP_USER_CANCELLED := 88
    static LDAP_PARAM_ERROR := 89
    static LDAP_NO_MEMORY := 90
    static LDAP_CONNECT_ERROR := 91
    static LDAP_NOT_SUPPORTED := 92
    static LDAP_NO_RESULTS_RETURNED := 94
    static LDAP_CONTROL_NOT_FOUND := 93
    static LDAP_MORE_RESULTS_TO_RETURN := 95
    static LDAP_CLIENT_LOOP := 96
    static LDAP_REFERRAL_LIMIT_EXCEEDED := 97
}
struct LDAP {
    ld_sb : this._ld_sb_e__Struct
    ld_host : PSTR
    ld_version : UInt32
    ld_lberoptions : UInt8
    ld_deref : UInt32
    ld_timelimit : UInt32
    ld_sizelimit : UInt32
    ld_errno : UInt32
    ld_matched : PSTR
    ld_error : PSTR
    ld_msgid : UInt32
    Reserved3 : UInt8[25]
    ld_cldaptries : UInt32
    ld_cldaptimeout : UInt32
    ld_refhoplimit : UInt32
    ld_options : UInt32
    ld_anonymousmaxvalrange : UInt32
    struct _ld_sb_e__Struct {
        sb_sd : IntPtr
        Reserved1 : UInt8[41]
        sb_naddr : IntPtr
        Reserved2 : UInt8[24]
    }
}
struct LDAP_TIMEVAL {
    tv_sec : Int32
    tv_usec : Int32
}
struct LDAP_BERVAL {
    bv_len : UInt32
    bv_val : PSTR
}
struct LDAPMessage {
    lm_msgid : UInt32
    lm_msgtype : UInt32
    lm_ber : Struct.Ptr
    lm_chain : LDAPMessage.Ptr
    lm_next : LDAPMessage.Ptr
    lm_time : UInt32
    Connection : LDAP.Ptr
    Request : Struct.Ptr
    lm_returncode : UInt32
    lm_referral : UInt16
    lm_chased : BOOLEAN
    lm_eom : BOOLEAN
    ConnectionReferenced : BOOLEAN
}
struct LDAPControlA {
    ldctl_oid : PSTR
    ldctl_value : LDAP_BERVAL
    ldctl_iscritical : BOOLEAN
}
struct LDAPControlW {
    ldctl_oid : PWSTR
    ldctl_value : LDAP_BERVAL
    ldctl_iscritical : BOOLEAN
}
struct LDAPModW {
    mod_op : UInt32
    mod_type : PWSTR
    mod_vals : this._mod_vals_e__Union
    struct _mod_vals_e__Union {
        union {
            modv_strvals : PWSTR.Ptr
            modv_bvals : LDAP_BERVAL.Ptr.Ptr
        }
    }
}
struct LDAPModA {
    mod_op : UInt32
    mod_type : PSTR
    mod_vals : this._mod_vals_e__Union
    struct _mod_vals_e__Union {
        union {
            modv_strvals : PSTR.Ptr
            modv_bvals : LDAP_BERVAL.Ptr.Ptr
        }
    }
}
struct BerElement {
    opaque : PSTR
}
struct LDAP_VERSION_INFO {
    lv_size : UInt32
    lv_major : UInt32
    lv_minor : UInt32
}
struct LDAPAPIInfoA {
    ldapai_info_version : Int32
    ldapai_api_version : Int32
    ldapai_protocol_version : Int32
    ldapai_extensions : Int8.Ptr.Ptr
    ldapai_vendor_name : PSTR
    ldapai_vendor_version : Int32
}
struct LDAPAPIInfoW {
    ldapai_info_version : Int32
    ldapai_api_version : Int32
    ldapai_protocol_version : Int32
    ldapai_extensions : PWSTR.Ptr
    ldapai_vendor_name : PWSTR
    ldapai_vendor_version : Int32
}
struct LDAPAPIFeatureInfoA {
    ldapaif_info_version : Int32
    ldapaif_name : PSTR
    ldapaif_version : Int32
}
struct LDAPAPIFeatureInfoW {
    ldapaif_info_version : Int32
    ldapaif_name : PWSTR
    ldapaif_version : Int32
}
struct DBGPRINT extends FunctionPointer {
    static Types := [PSTR, UInt32]
    static Options := "C"
}
struct LDAPSortKeyW {
    sk_attrtype : PWSTR
    sk_matchruleoid : PWSTR
    sk_reverseorder : BOOLEAN
}
struct LDAPSortKeyA {
    sk_attrtype : PSTR
    sk_matchruleoid : PSTR
    sk_reverseorder : BOOLEAN
}
struct LDAPVLVInfo {
    ldvlv_version : Int32
    ldvlv_before_count : UInt32
    ldvlv_after_count : UInt32
    ldvlv_offset : UInt32
    ldvlv_count : UInt32
    ldvlv_attrvalue : LDAP_BERVAL.Ptr
    ldvlv_context : LDAP_BERVAL.Ptr
    ldvlv_extradata : Struct.Ptr
}
struct QUERYFORCONNECTION extends FunctionPointer {
    static Types := [LDAP.Ptr, LDAP.Ptr, PWSTR, PSTR, UInt32, Struct.Ptr, Struct.Ptr, LDAP.Ptr.Ptr, UInt32]
    static Options := "C"
}
struct NOTIFYOFNEWCONNECTION extends FunctionPointer {
    static Types := [LDAP.Ptr, LDAP.Ptr, PWSTR, PSTR, LDAP.Ptr, UInt32, Struct.Ptr, Struct.Ptr, UInt32, BOOLEAN]
    static Options := "C"
}
struct DEREFERENCECONNECTION extends FunctionPointer {
    static Types := [LDAP.Ptr, LDAP.Ptr, UInt32]
    static Options := "C"
}
struct LDAP_REFERRAL_CALLBACK {
    SizeOfCallbacks : UInt32
    QueryForConnection : QUERYFORCONNECTION
    NotifyRoutine : NOTIFYOFNEWCONNECTION
    DereferenceRoutine : DEREFERENCECONNECTION
}
struct QUERYCLIENTCERT extends FunctionPointer {
    static Types := [LDAP.Ptr, SecPkgContext_IssuerListInfoEx.Ptr, CERT_CONTEXT.Ptr.Ptr, BOOLEAN]
    static Options := "C"
}
struct VERIFYSERVERCERT extends FunctionPointer {
    static Types := [LDAP.Ptr, CERT_CONTEXT.Ptr.Ptr, BOOLEAN]
    static Options := "C"
}
