#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, HRESULT, HWND, LUID, NTSTATUS, PSTR, PWSTR}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR, PSID, QUOTA_LIMITS, SECURITY_ATTRIBUTES, SECURITY_IMPERSONATION_LEVEL, SID_NAME_USE, TOKEN_DEFAULT_DACL, TOKEN_DEVICE_CLAIMS, TOKEN_GROUPS, TOKEN_OWNER, TOKEN_PRIMARY_GROUP, TOKEN_PRIVILEGES, TOKEN_SOURCE, TOKEN_USER, TOKEN_USER_CLAIMS}
#Import "..\Security.Credentials\Types.ahk" {CREDENTIALW, CREDENTIAL_TARGET_INFORMATIONW, SecHandle}
#Import "..\Security.Cryptography\Types.ahk" {ALG_ID, CERT_CONTEXT, CRYPT_INTEGER_BLOB, HCERTSTORE}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Kernel\Types.ahk" {LIST_ENTRY}
#Import "..\System.PasswordManagement\Types.ahk" {CYPHER_BLOCK, LM_OWF_PASSWORD}
#Import "..\System.Rpc\Types.ahk" {SEC_WINNT_AUTH_IDENTITY_A, SEC_WINNT_AUTH_IDENTITY_W}
#Import "..\System.Threading\Types.ahk" {LPTHREAD_START_ROUTINE}

struct SECPKG_ATTR extends UInt32 {
    static SECPKG_ATTR_C_ACCESS_TOKEN := 2147483666
    static SECPKG_ATTR_C_FULL_ACCESS_TOKEN := 2147483778
    static SECPKG_ATTR_CERT_TRUST_STATUS := 2147483780
    static SECPKG_ATTR_CREDS := 2147483776
    static SECPKG_ATTR_CREDS_2 := 2147483782
    static SECPKG_ATTR_NEGOTIATION_PACKAGE := 2147483777
    static SECPKG_ATTR_PACKAGE_INFO := 10
    static SECPKG_ATTR_SERVER_AUTH_FLAGS := 2147483779
    static SECPKG_ATTR_SIZES := 0
    static SECPKG_ATTR_SUBJECT_SECURITY_ATTRIBUTES := 124
    static SECPKG_ATTR_APP_DATA := 94
    static SECPKG_ATTR_EAP_PRF_INFO := 101
    static SECPKG_ATTR_EARLY_START := 105
    static SECPKG_ATTR_DTLS_MTU := 34
    static SECPKG_ATTR_KEYING_MATERIAL_INFO := 106
    static SECPKG_ATTR_ACCESS_TOKEN := 18
    static SECPKG_ATTR_AUTHORITY := 6
    static SECPKG_ATTR_CLIENT_SPECIFIED_TARGET := 27
    static SECPKG_ATTR_CONNECTION_INFO := 90
    static SECPKG_ATTR_DCE_INFO := 3
    static SECPKG_ATTR_ENDPOINT_BINDINGS := 26
    static SECPKG_ATTR_EAP_KEY_BLOCK := 91
    static SECPKG_ATTR_FLAGS := 14
    static SECPKG_ATTR_ISSUER_LIST_EX := 89
    static SECPKG_ATTR_KEY_INFO := 5
    static SECPKG_ATTR_LAST_CLIENT_TOKEN_STATUS := 30
    static SECPKG_ATTR_LIFESPAN := 2
    static SECPKG_ATTR_LOCAL_CERT_CONTEXT := 84
    static SECPKG_ATTR_LOCAL_CRED := 82
    static SECPKG_ATTR_NAMES := 1
    static SECPKG_ATTR_NATIVE_NAMES := 13
    static SECPKG_ATTR_NEGOTIATION_INFO := 12
    static SECPKG_ATTR_PASSWORD_EXPIRY := 8
    static SECPKG_ATTR_REMOTE_CERT_CONTEXT := 83
    static SECPKG_ATTR_ROOT_STORE := 85
    static SECPKG_ATTR_SESSION_KEY := 9
    static SECPKG_ATTR_SESSION_INFO := 93
    static SECPKG_ATTR_STREAM_SIZES := 4
    static SECPKG_ATTR_SUPPORTED_SIGNATURES := 102
    static SECPKG_ATTR_TARGET_INFORMATION := 17
    static SECPKG_ATTR_UNIQUE_BINDINGS := 25
}
struct MSV1_0 extends UInt32 {
    static MSV1_0_PASSTHRU := 1
    static MSV1_0_GUEST_LOGON := 2
}
struct SECPKG_CRED extends UInt32 {
    static SECPKG_CRED_INBOUND := 1
    static SECPKG_CRED_OUTBOUND := 2
}
struct MSV_SUB_AUTHENTICATION_FILTER extends UInt32 {
    static LOGON_GUEST := 1
    static LOGON_NOENCRYPTION := 2
    static LOGON_CACHED_ACCOUNT := 4
    static LOGON_USED_LM_PASSWORD := 8
    static LOGON_EXTRA_SIDS := 32
    static LOGON_SUBAUTH_SESSION_KEY := 64
    static LOGON_SERVER_TRUST_ACCOUNT := 128
    static LOGON_PROFILE_PATH_RETURNED := 1024
    static LOGON_RESOURCE_GROUPS := 512
}
struct EXPORT_SECURITY_CONTEXT_FLAGS extends UInt32 {
    static SECPKG_CONTEXT_EXPORT_RESET_NEW := 1
    static SECPKG_CONTEXT_EXPORT_DELETE_OLD := 2
    static SECPKG_CONTEXT_EXPORT_TO_KERNEL := 4
}
struct KERB_TICKET_FLAGS extends UInt32 {
    static KERB_TICKET_FLAGS_forwardable := 1073741824
    static KERB_TICKET_FLAGS_forwarded := 536870912
    static KERB_TICKET_FLAGS_hw_authent := 1048576
    static KERB_TICKET_FLAGS_initial := 4194304
    static KERB_TICKET_FLAGS_invalid := 16777216
    static KERB_TICKET_FLAGS_may_postdate := 67108864
    static KERB_TICKET_FLAGS_ok_as_delegate := 262144
    static KERB_TICKET_FLAGS_postdated := 33554432
    static KERB_TICKET_FLAGS_pre_authent := 2097152
    static KERB_TICKET_FLAGS_proxiable := 268435456
    static KERB_TICKET_FLAGS_proxy := 134217728
    static KERB_TICKET_FLAGS_renewable := 8388608
    static KERB_TICKET_FLAGS_reserved := 2147483648
    static KERB_TICKET_FLAGS_reserved1 := 1
}
struct KERB_ADDRESS_TYPE extends UInt32 {
    static DS_INET_ADDRESS := 1
    static DS_NETBIOS_ADDRESS := 2
}
struct SCHANNEL_CRED_FLAGS extends UInt32 {
    static SCH_CRED_AUTO_CRED_VALIDATION := 32
    static SCH_CRED_CACHE_ONLY_URL_RETRIEVAL_ON_CREATE := 131072
    static SCH_DISABLE_RECONNECTS := 128
    static SCH_CRED_IGNORE_NO_REVOCATION_CHECK := 2048
    static SCH_CRED_IGNORE_REVOCATION_OFFLINE := 4096
    static SCH_CRED_MANUAL_CRED_VALIDATION := 8
    static SCH_CRED_NO_DEFAULT_CREDS := 16
    static SCH_CRED_NO_SERVERNAME_CHECK := 4
    static SCH_CRED_NO_SYSTEM_MAPPER := 2
    static SCH_CRED_REVOCATION_CHECK_CHAIN := 512
    static SCH_CRED_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT := 1024
    static SCH_CRED_REVOCATION_CHECK_END_CERT := 256
    static SCH_CRED_USE_DEFAULT_CREDS := 64
    static SCH_SEND_AUX_RECORD := 2097152
    static SCH_SEND_ROOT_CERT := 262144
    static SCH_USE_STRONG_CRYPTO := 4194304
    static SCH_USE_PRESHAREDKEY_ONLY := 8388608
}
struct DOMAIN_PASSWORD_PROPERTIES extends UInt32 {
    static DOMAIN_PASSWORD_COMPLEX := 1
    static DOMAIN_PASSWORD_NO_ANON_CHANGE := 2
    static DOMAIN_PASSWORD_NO_CLEAR_CHANGE := 4
    static DOMAIN_LOCKOUT_ADMINS := 8
    static DOMAIN_PASSWORD_STORE_CLEARTEXT := 16
    static DOMAIN_REFUSE_PASSWORD_CHANGE := 32
}
struct SCHANNEL_ALERT_TOKEN_ALERT_TYPE extends UInt32 {
    static TLS1_ALERT_WARNING := 1
    static TLS1_ALERT_FATAL := 2
}
struct TRUSTED_DOMAIN_TRUST_TYPE extends UInt32 {
    static TRUST_TYPE_DOWNLEVEL := 1
    static TRUST_TYPE_UPLEVEL := 2
    static TRUST_TYPE_MIT := 3
    static TRUST_TYPE_DCE := 4
}
struct MSV_SUBAUTH_LOGON_PARAMETER_CONTROL extends UInt32 {
    static MSV1_0_CLEARTEXT_PASSWORD_ALLOWED := 2
    static MSV1_0_UPDATE_LOGON_STATISTICS := 4
    static MSV1_0_RETURN_USER_PARAMETERS := 8
    static MSV1_0_DONT_TRY_GUEST_ACCOUNT := 16
    static MSV1_0_ALLOW_SERVER_TRUST_ACCOUNT := 32
    static MSV1_0_RETURN_PASSWORD_EXPIRY := 64
    static MSV1_0_ALLOW_WORKSTATION_TRUST_ACCOUNT := 2048
    static MSV1_0_TRY_GUEST_ACCOUNT_ONLY := 256
    static MSV1_0_RETURN_PROFILE_PATH := 512
    static MSV1_0_TRY_SPECIFIED_DOMAIN_ONLY := 1024
}
struct KERB_REQUEST_FLAGS extends UInt32 {
    static KERB_REQUEST_ADD_CREDENTIAL := 1
    static KERB_REQUEST_REPLACE_CREDENTIAL := 2
    static KERB_REQUEST_REMOVE_CREDENTIAL := 4
}
struct TRUSTED_DOMAIN_TRUST_DIRECTION extends UInt32 {
    static TRUST_DIRECTION_DISABLED := 0
    static TRUST_DIRECTION_INBOUND := 1
    static TRUST_DIRECTION_OUTBOUND := 2
    static TRUST_DIRECTION_BIDIRECTIONAL := 3
}
struct MSV_SUPPLEMENTAL_CREDENTIAL_FLAGS extends UInt32 {
    static MSV1_0_CRED_LM_PRESENT := 1
    static MSV1_0_CRED_NT_PRESENT := 2
    static MSV1_0_CRED_VERSION := 0
}
struct SECURITY_PACKAGE_OPTIONS_TYPE extends UInt32 {
    static SECPKG_OPTIONS_TYPE_UNKNOWN := 0
    static SECPKG_OPTIONS_TYPE_LSA := 1
    static SECPKG_OPTIONS_TYPE_SSPI := 2
}
struct SCHANNEL_SESSION_TOKEN_FLAGS extends UInt32 {
    static SSL_SESSION_ENABLE_RECONNECTS := 1
    static SSL_SESSION_DISABLE_RECONNECTS := 2
}
struct KERB_CRYPTO_KEY_TYPE extends Int32 {
    static KERB_ETYPE_DES_CBC_CRC := 1
    static KERB_ETYPE_DES_CBC_MD4 := 2
    static KERB_ETYPE_DES_CBC_MD5 := 3
    static KERB_ETYPE_NULL := 0
    static KERB_ETYPE_RC4_HMAC_NT := 23
    static KERB_ETYPE_RC4_MD4 := -128
}
struct LSA_AUTH_INFORMATION_AUTH_TYPE extends UInt32 {
    static TRUST_AUTH_TYPE_NONE := 0
    static TRUST_AUTH_TYPE_NT4OWF := 1
    static TRUST_AUTH_TYPE_CLEAR := 2
    static TRUST_AUTH_TYPE_VERSION := 3
}
struct SECPKG_PACKAGE_CHANGE_TYPE extends UInt32 {
    static SECPKG_PACKAGE_CHANGE_LOAD := 0
    static SECPKG_PACKAGE_CHANGE_UNLOAD := 1
    static SECPKG_PACKAGE_CHANGE_SELECT := 2
}
struct TRUSTED_DOMAIN_TRUST_ATTRIBUTES extends UInt32 {
    static TRUST_ATTRIBUTE_NON_TRANSITIVE := 1
    static TRUST_ATTRIBUTE_UPLEVEL_ONLY := 2
    static TRUST_ATTRIBUTE_FILTER_SIDS := 4
    static TRUST_ATTRIBUTE_FOREST_TRANSITIVE := 8
    static TRUST_ATTRIBUTE_CROSS_ORGANIZATION := 16
    static TRUST_ATTRIBUTE_TREAT_AS_EXTERNAL := 64
    static TRUST_ATTRIBUTE_WITHIN_FOREST := 32
}
struct ISC_REQ_HIGH_FLAGS extends Int64 {
    static ISC_REQ_MESSAGES := 4294967296
    static ISC_REQ_DEFERRED_CRED_VALIDATION := 8589934592
    static ISC_REQ_NO_POST_HANDSHAKE_AUTH := 17179869184
    static ISC_REQ_REUSE_SESSION_TICKETS := 34359738368
    static ISC_REQ_EXPLICIT_SESSION := 68719476736
}
struct ISC_REQ_FLAGS extends UInt32 {
    static ISC_REQ_DELEGATE := 1
    static ISC_REQ_MUTUAL_AUTH := 2
    static ISC_REQ_REPLAY_DETECT := 4
    static ISC_REQ_SEQUENCE_DETECT := 8
    static ISC_REQ_CONFIDENTIALITY := 16
    static ISC_REQ_USE_SESSION_KEY := 32
    static ISC_REQ_PROMPT_FOR_CREDS := 64
    static ISC_REQ_USE_SUPPLIED_CREDS := 128
    static ISC_REQ_ALLOCATE_MEMORY := 256
    static ISC_REQ_USE_DCE_STYLE := 512
    static ISC_REQ_DATAGRAM := 1024
    static ISC_REQ_CONNECTION := 2048
    static ISC_REQ_CALL_LEVEL := 4096
    static ISC_REQ_FRAGMENT_SUPPLIED := 8192
    static ISC_REQ_EXTENDED_ERROR := 16384
    static ISC_REQ_STREAM := 32768
    static ISC_REQ_INTEGRITY := 65536
    static ISC_REQ_IDENTIFY := 131072
    static ISC_REQ_NULL_SESSION := 262144
    static ISC_REQ_MANUAL_CRED_VALIDATION := 524288
    static ISC_REQ_RESERVED1 := 1048576
    static ISC_REQ_FRAGMENT_TO_FIT := 2097152
    static ISC_REQ_FORWARD_CREDENTIALS := 4194304
    static ISC_REQ_NO_INTEGRITY := 8388608
    static ISC_REQ_USE_HTTP_STYLE := 16777216
    static ISC_REQ_UNVERIFIED_TARGET_NAME := 536870912
    static ISC_REQ_CONFIDENTIALITY_ONLY := 1073741824
}
struct ASC_REQ_HIGH_FLAGS extends Int64 {
    static ASC_REQ_MESSAGES := 4294967296
    static ASC_REQ_EXPLICIT_SESSION := 68719476736
}
struct ASC_REQ_FLAGS extends UInt32 {
    static ASC_REQ_DELEGATE := 1
    static ASC_REQ_MUTUAL_AUTH := 2
    static ASC_REQ_REPLAY_DETECT := 4
    static ASC_REQ_SEQUENCE_DETECT := 8
    static ASC_REQ_CONFIDENTIALITY := 16
    static ASC_REQ_USE_SESSION_KEY := 32
    static ASC_REQ_SESSION_TICKET := 64
    static ASC_REQ_ALLOCATE_MEMORY := 256
    static ASC_REQ_USE_DCE_STYLE := 512
    static ASC_REQ_DATAGRAM := 1024
    static ASC_REQ_CONNECTION := 2048
    static ASC_REQ_CALL_LEVEL := 4096
    static ASC_REQ_FRAGMENT_SUPPLIED := 8192
    static ASC_REQ_EXTENDED_ERROR := 32768
    static ASC_REQ_STREAM := 65536
    static ASC_REQ_INTEGRITY := 131072
    static ASC_REQ_LICENSING := 262144
    static ASC_REQ_IDENTIFY := 524288
    static ASC_REQ_ALLOW_NULL_SESSION := 1048576
    static ASC_REQ_ALLOW_NON_USER_LOGONS := 2097152
    static ASC_REQ_ALLOW_CONTEXT_REPLAY := 4194304
    static ASC_REQ_FRAGMENT_TO_FIT := 8388608
    static ASC_REQ_NO_TOKEN := 16777216
    static ASC_REQ_PROXY_BINDINGS := 67108864
    static ASC_REQ_ALLOW_MISSING_BINDINGS := 268435456
}
struct LSA_HANDLE {
    Value : IntPtr
}
struct HMAPPER {
    Value : IntPtr
}
struct LSA_UNICODE_STRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : PWSTR
}
struct LSA_STRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : PSTR
}
struct LSA_OBJECT_ATTRIBUTES {
    Length : UInt32
    RootDirectory : HANDLE
    ObjectName : LSA_UNICODE_STRING.Ptr
    Attributes : UInt32
    SecurityDescriptor : Struct.Ptr
    SecurityQualityOfService : Struct.Ptr
}
struct LSA_TRUST_INFORMATION {
    Name : LSA_UNICODE_STRING
    Sid : PSID
}
struct LSA_REFERENCED_DOMAIN_LIST {
    Entries : UInt32
    Domains : LSA_TRUST_INFORMATION.Ptr
}
struct LSA_TRANSLATED_SID2 {
    Use : SID_NAME_USE
    Sid : PSID
    DomainIndex : Int32
    Flags : UInt32
}
struct LSA_TRANSLATED_NAME {
    Use : SID_NAME_USE
    Name : LSA_UNICODE_STRING
    DomainIndex : Int32
}
struct POLICY_ACCOUNT_DOMAIN_INFO {
    DomainName : LSA_UNICODE_STRING
    DomainSid : PSID
}
struct POLICY_DNS_DOMAIN_INFO {
    Name : LSA_UNICODE_STRING
    DnsDomainName : LSA_UNICODE_STRING
    DnsForestName : LSA_UNICODE_STRING
    DomainGuid : GUID
    Sid : PSID
}
struct LSA_LOOKUP_DOMAIN_INFO_CLASS extends Int32 {
    static AccountDomainInformation := 5
    static DnsDomainInformation := 12
}
struct SECURITY_LOGON_TYPE extends Int32 {
    static UndefinedLogonType := 0
    static Interactive := 2
    static Network := 3
    static Batch := 4
    static Service := 5
    static Proxy := 6
    static Unlock := 7
    static NetworkCleartext := 8
    static NewCredentials := 9
    static RemoteInteractive := 10
    static CachedInteractive := 11
    static CachedRemoteInteractive := 12
    static CachedUnlock := 13
}
struct SE_ADT_PARAMETER_TYPE extends Int32 {
    static SeAdtParmTypeNone := 0
    static SeAdtParmTypeString := 1
    static SeAdtParmTypeFileSpec := 2
    static SeAdtParmTypeUlong := 3
    static SeAdtParmTypeSid := 4
    static SeAdtParmTypeLogonId := 5
    static SeAdtParmTypeNoLogonId := 6
    static SeAdtParmTypeAccessMask := 7
    static SeAdtParmTypePrivs := 8
    static SeAdtParmTypeObjectTypes := 9
    static SeAdtParmTypeHexUlong := 10
    static SeAdtParmTypePtr := 11
    static SeAdtParmTypeTime := 12
    static SeAdtParmTypeGuid := 13
    static SeAdtParmTypeLuid := 14
    static SeAdtParmTypeHexInt64 := 15
    static SeAdtParmTypeStringList := 16
    static SeAdtParmTypeSidList := 17
    static SeAdtParmTypeDuration := 18
    static SeAdtParmTypeUserAccountControl := 19
    static SeAdtParmTypeNoUac := 20
    static SeAdtParmTypeMessage := 21
    static SeAdtParmTypeDateTime := 22
    static SeAdtParmTypeSockAddr := 23
    static SeAdtParmTypeSD := 24
    static SeAdtParmTypeLogonHours := 25
    static SeAdtParmTypeLogonIdNoSid := 26
    static SeAdtParmTypeUlongNoConv := 27
    static SeAdtParmTypeSockAddrNoPort := 28
    static SeAdtParmTypeAccessReason := 29
    static SeAdtParmTypeStagingReason := 30
    static SeAdtParmTypeResourceAttribute := 31
    static SeAdtParmTypeClaims := 32
    static SeAdtParmTypeLogonIdAsSid := 33
    static SeAdtParmTypeMultiSzString := 34
    static SeAdtParmTypeLogonIdEx := 35
}
struct SE_ADT_OBJECT_TYPE {
    ObjectType : GUID
    Flags : UInt16
    Level : UInt16
    AccessMask : UInt32
}
struct SE_ADT_PARAMETER_ARRAY_ENTRY {
    Type : SE_ADT_PARAMETER_TYPE
    Length : UInt32
    Data : IntPtr[2]
    Address : Struct.Ptr
}
struct SE_ADT_ACCESS_REASON {
    AccessMask : UInt32
    AccessReasons : UInt32[32]
    ObjectTypeIndex : UInt32
    AccessGranted : UInt32
    SecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct SE_ADT_CLAIMS {
    Length : UInt32
    Claims : Struct.Ptr
}
struct SE_ADT_PARAMETER_ARRAY {
    CategoryId : UInt32
    AuditId : UInt32
    ParameterCount : UInt32
    Length : UInt32
    FlatSubCategoryId : UInt16
    Type : UInt16
    Flags : UInt32
    Parameters : SE_ADT_PARAMETER_ARRAY_ENTRY[32]
}
struct SE_ADT_PARAMETER_ARRAY_EX {
    CategoryId : UInt32
    AuditId : UInt32
    Version : UInt32
    ParameterCount : UInt32
    Length : UInt32
    FlatSubCategoryId : UInt16
    Type : UInt16
    Flags : UInt32
    Parameters : SE_ADT_PARAMETER_ARRAY_ENTRY[32]
}
struct POLICY_AUDIT_EVENT_TYPE extends Int32 {
    static AuditCategorySystem := 0
    static AuditCategoryLogon := 1
    static AuditCategoryObjectAccess := 2
    static AuditCategoryPrivilegeUse := 3
    static AuditCategoryDetailedTracking := 4
    static AuditCategoryPolicyChange := 5
    static AuditCategoryAccountManagement := 6
    static AuditCategoryDirectoryServiceAccess := 7
    static AuditCategoryAccountLogon := 8
}
struct LSA_TRANSLATED_SID {
    Use : SID_NAME_USE
    RelativeId : UInt32
    DomainIndex : Int32
}
struct POLICY_LSA_SERVER_ROLE extends Int32 {
    static PolicyServerRoleBackup := 2
    static PolicyServerRolePrimary := 3
}
struct POLICY_INFORMATION_CLASS extends Int32 {
    static PolicyAuditLogInformation := 1
    static PolicyAuditEventsInformation := 2
    static PolicyPrimaryDomainInformation := 3
    static PolicyPdAccountInformation := 4
    static PolicyAccountDomainInformation := 5
    static PolicyLsaServerRoleInformation := 6
    static PolicyReplicaSourceInformation := 7
    static PolicyDefaultQuotaInformation := 8
    static PolicyModificationInformation := 9
    static PolicyAuditFullSetInformation := 10
    static PolicyAuditFullQueryInformation := 11
    static PolicyDnsDomainInformation := 12
    static PolicyDnsDomainInformationInt := 13
    static PolicyLocalAccountDomainInformation := 14
    static PolicyMachineAccountInformation := 15
    static PolicyMachineAccountInformation2 := 16
    static PolicyLastEntry := 17
}
struct POLICY_AUDIT_LOG_INFO {
    AuditLogPercentFull : UInt32
    MaximumLogSize : UInt32
    AuditRetentionPeriod : Int64
    AuditLogFullShutdownInProgress : BOOLEAN
    TimeToShutdown : Int64
    NextAuditRecordId : UInt32
}
struct POLICY_AUDIT_EVENTS_INFO {
    AuditingMode : BOOLEAN
    EventAuditingOptions : UInt32.Ptr
    MaximumAuditEventCount : UInt32
}
struct POLICY_AUDIT_SUBCATEGORIES_INFO {
    MaximumSubCategoryCount : UInt32
    EventAuditingOptions : UInt32.Ptr
}
struct POLICY_AUDIT_CATEGORIES_INFO {
    MaximumCategoryCount : UInt32
    SubCategoriesInfo : POLICY_AUDIT_SUBCATEGORIES_INFO.Ptr
}
struct POLICY_PRIMARY_DOMAIN_INFO {
    Name : LSA_UNICODE_STRING
    Sid : PSID
}
struct POLICY_PD_ACCOUNT_INFO {
    Name : LSA_UNICODE_STRING
}
struct POLICY_LSA_SERVER_ROLE_INFO {
    LsaServerRole : POLICY_LSA_SERVER_ROLE
}
struct POLICY_REPLICA_SOURCE_INFO {
    ReplicaSource : LSA_UNICODE_STRING
    ReplicaAccountName : LSA_UNICODE_STRING
}
struct POLICY_DEFAULT_QUOTA_INFO {
    QuotaLimits : QUOTA_LIMITS
}
struct POLICY_MODIFICATION_INFO {
    ModifiedId : Int64
    DatabaseCreationTime : Int64
}
struct POLICY_AUDIT_FULL_SET_INFO {
    ShutDownOnFull : BOOLEAN
}
struct POLICY_AUDIT_FULL_QUERY_INFO {
    ShutDownOnFull : BOOLEAN
    LogIsFull : BOOLEAN
}
struct POLICY_DOMAIN_INFORMATION_CLASS extends Int32 {
    static PolicyDomainEfsInformation := 2
    static PolicyDomainKerberosTicketInformation := 3
}
struct POLICY_DOMAIN_EFS_INFO {
    InfoLength : UInt32
    EfsBlob : UInt8.Ptr
}
struct POLICY_DOMAIN_KERBEROS_TICKET_INFO {
    AuthenticationOptions : UInt32
    MaxServiceTicketAge : Int64
    MaxTicketAge : Int64
    MaxRenewAge : Int64
    MaxClockSkew : Int64
    Reserved : Int64
}
struct POLICY_MACHINE_ACCT_INFO {
    Rid : UInt32
    Sid : PSID
}
struct POLICY_MACHINE_ACCT_INFO2 {
    Rid : UInt32
    Sid : PSID
    ObjectGuid : GUID
}
struct POLICY_NOTIFICATION_INFORMATION_CLASS extends Int32 {
    static PolicyNotifyAuditEventsInformation := 1
    static PolicyNotifyAccountDomainInformation := 2
    static PolicyNotifyServerRoleInformation := 3
    static PolicyNotifyDnsDomainInformation := 4
    static PolicyNotifyDomainEfsInformation := 5
    static PolicyNotifyDomainKerberosTicketInformation := 6
    static PolicyNotifyMachineAccountPasswordInformation := 7
    static PolicyNotifyGlobalSaclInformation := 8
    static PolicyNotifyMax := 9
}
struct TRUSTED_INFORMATION_CLASS extends Int32 {
    static TrustedDomainNameInformation := 1
    static TrustedControllersInformation := 2
    static TrustedPosixOffsetInformation := 3
    static TrustedPasswordInformation := 4
    static TrustedDomainInformationBasic := 5
    static TrustedDomainInformationEx := 6
    static TrustedDomainAuthInformation := 7
    static TrustedDomainFullInformation := 8
    static TrustedDomainAuthInformationInternal := 9
    static TrustedDomainFullInformationInternal := 10
    static TrustedDomainInformationEx2Internal := 11
    static TrustedDomainFullInformation2Internal := 12
    static TrustedDomainSupportedEncryptionTypes := 13
    static TrustedDomainAuthInformationInternalAes := 14
    static TrustedDomainFullInformationInternalAes := 15
}
struct TRUSTED_DOMAIN_NAME_INFO {
    Name : LSA_UNICODE_STRING
}
struct TRUSTED_CONTROLLERS_INFO {
    Entries : UInt32
    Names : LSA_UNICODE_STRING.Ptr
}
struct TRUSTED_POSIX_OFFSET_INFO {
    Offset : UInt32
}
struct TRUSTED_PASSWORD_INFO {
    Password : LSA_UNICODE_STRING
    OldPassword : LSA_UNICODE_STRING
}
struct TRUSTED_DOMAIN_INFORMATION_EX {
    Name : LSA_UNICODE_STRING
    FlatName : LSA_UNICODE_STRING
    Sid : PSID
    TrustDirection : TRUSTED_DOMAIN_TRUST_DIRECTION
    TrustType : TRUSTED_DOMAIN_TRUST_TYPE
    TrustAttributes : TRUSTED_DOMAIN_TRUST_ATTRIBUTES
}
struct TRUSTED_DOMAIN_INFORMATION_EX2 {
    Name : LSA_UNICODE_STRING
    FlatName : LSA_UNICODE_STRING
    Sid : PSID
    TrustDirection : UInt32
    TrustType : UInt32
    TrustAttributes : UInt32
    ForestTrustLength : UInt32
    ForestTrustInfo : UInt8.Ptr
}
struct LSA_AUTH_INFORMATION {
    LastUpdateTime : Int64
    AuthType : LSA_AUTH_INFORMATION_AUTH_TYPE
    AuthInfoLength : UInt32
    AuthInfo : UInt8.Ptr
}
struct TRUSTED_DOMAIN_AUTH_INFORMATION {
    IncomingAuthInfos : UInt32
    IncomingAuthenticationInformation : LSA_AUTH_INFORMATION.Ptr
    IncomingPreviousAuthenticationInformation : LSA_AUTH_INFORMATION.Ptr
    OutgoingAuthInfos : UInt32
    OutgoingAuthenticationInformation : LSA_AUTH_INFORMATION.Ptr
    OutgoingPreviousAuthenticationInformation : LSA_AUTH_INFORMATION.Ptr
}
struct TRUSTED_DOMAIN_FULL_INFORMATION {
    Information : TRUSTED_DOMAIN_INFORMATION_EX
    PosixOffset : TRUSTED_POSIX_OFFSET_INFO
    AuthInformation : TRUSTED_DOMAIN_AUTH_INFORMATION
}
struct TRUSTED_DOMAIN_FULL_INFORMATION2 {
    Information : TRUSTED_DOMAIN_INFORMATION_EX2
    PosixOffset : TRUSTED_POSIX_OFFSET_INFO
    AuthInformation : TRUSTED_DOMAIN_AUTH_INFORMATION
}
struct TRUSTED_DOMAIN_SUPPORTED_ENCRYPTION_TYPES {
    SupportedEncryptionTypes : UInt32
}
struct LSA_FOREST_TRUST_RECORD_TYPE extends Int32 {
    static ForestTrustTopLevelName := 0
    static ForestTrustTopLevelNameEx := 1
    static ForestTrustDomainInfo := 2
    static ForestTrustBinaryInfo := 3
    static ForestTrustScannerInfo := 4
    static ForestTrustRecordTypeLast := 4
}
struct LSA_FOREST_TRUST_DOMAIN_INFO {
    Sid : PSID
    DnsName : LSA_UNICODE_STRING
    NetbiosName : LSA_UNICODE_STRING
}
struct LSA_FOREST_TRUST_SCANNER_INFO {
    DomainSid : PSID
    DnsName : LSA_UNICODE_STRING
    NetbiosName : LSA_UNICODE_STRING
}
struct LSA_FOREST_TRUST_BINARY_DATA {
    Length : UInt32
    Buffer : UInt8.Ptr
}
struct LSA_FOREST_TRUST_RECORD {
    Flags : UInt32
    ForestTrustType : LSA_FOREST_TRUST_RECORD_TYPE
    Time : Int64
    ForestTrustData : this._ForestTrustData_e__Union
    struct _ForestTrustData_e__Union {
        union {
            TopLevelName : LSA_UNICODE_STRING
            DomainInfo : LSA_FOREST_TRUST_DOMAIN_INFO
            Data : LSA_FOREST_TRUST_BINARY_DATA
        }
    }
}
struct LSA_FOREST_TRUST_RECORD2 {
    Flags : UInt32
    ForestTrustType : LSA_FOREST_TRUST_RECORD_TYPE
    Time : Int64
    ForestTrustData : this._ForestTrustData_e__Union
    struct _ForestTrustData_e__Union {
        union {
            TopLevelName : LSA_UNICODE_STRING
            DomainInfo : LSA_FOREST_TRUST_DOMAIN_INFO
            BinaryData : LSA_FOREST_TRUST_BINARY_DATA
            ScannerInfo : LSA_FOREST_TRUST_SCANNER_INFO
        }
    }
}
struct LSA_FOREST_TRUST_INFORMATION {
    RecordCount : UInt32
    Entries : LSA_FOREST_TRUST_RECORD.Ptr.Ptr
}
struct LSA_FOREST_TRUST_INFORMATION2 {
    RecordCount : UInt32
    Entries : LSA_FOREST_TRUST_RECORD2.Ptr.Ptr
}
struct LSA_FOREST_TRUST_COLLISION_RECORD_TYPE extends Int32 {
    static CollisionTdo := 0
    static CollisionXref := 1
    static CollisionOther := 2
}
struct LSA_FOREST_TRUST_COLLISION_RECORD {
    Index : UInt32
    Type : LSA_FOREST_TRUST_COLLISION_RECORD_TYPE
    Flags : UInt32
    Name : LSA_UNICODE_STRING
}
struct LSA_FOREST_TRUST_COLLISION_INFORMATION {
    RecordCount : UInt32
    Entries : LSA_FOREST_TRUST_COLLISION_RECORD.Ptr.Ptr
}
struct LSA_ENUMERATION_INFORMATION {
    Sid : PSID
}
struct LSA_LAST_INTER_LOGON_INFO {
    LastSuccessfulLogon : Int64
    LastFailedLogon : Int64
    FailedAttemptCountSinceLastSuccessfulLogon : UInt32
}
struct SECURITY_LOGON_SESSION_DATA {
    Size : UInt32
    LogonId : LUID
    UserName : LSA_UNICODE_STRING
    LogonDomain : LSA_UNICODE_STRING
    AuthenticationPackage : LSA_UNICODE_STRING
    LogonType : UInt32
    Session : UInt32
    Sid : PSID
    LogonTime : Int64
    LogonServer : LSA_UNICODE_STRING
    DnsDomainName : LSA_UNICODE_STRING
    Upn : LSA_UNICODE_STRING
    UserFlags : UInt32
    LastLogonInfo : LSA_LAST_INTER_LOGON_INFO
    LogonScript : LSA_UNICODE_STRING
    ProfilePath : LSA_UNICODE_STRING
    HomeDirectory : LSA_UNICODE_STRING
    HomeDirectoryDrive : LSA_UNICODE_STRING
    LogoffTime : Int64
    KickOffTime : Int64
    PasswordLastSet : Int64
    PasswordCanChange : Int64
    PasswordMustChange : Int64
}
struct CENTRAL_ACCESS_POLICY_ENTRY {
    Name : LSA_UNICODE_STRING
    Description : LSA_UNICODE_STRING
    ChangeId : LSA_UNICODE_STRING
    LengthAppliesTo : UInt32
    AppliesTo : UInt8.Ptr
    LengthSD : UInt32
    SD : PSECURITY_DESCRIPTOR
    LengthStagedSD : UInt32
    StagedSD : PSECURITY_DESCRIPTOR
    Flags : UInt32
}
struct CENTRAL_ACCESS_POLICY {
    CAPID : PSID
    Name : LSA_UNICODE_STRING
    Description : LSA_UNICODE_STRING
    ChangeId : LSA_UNICODE_STRING
    Flags : UInt32
    CAPECount : UInt32
    CAPEs : CENTRAL_ACCESS_POLICY_ENTRY.Ptr.Ptr
}
struct NEGOTIATE_MESSAGES extends Int32 {
    static NegEnumPackagePrefixes := 0
    static NegGetCallerName := 1
    static NegTransferCredentials := 2
    static NegMsgReserved1 := 3
    static NegCallPackageMax := 4
}
struct NEGOTIATE_PACKAGE_PREFIX {
    PackageId : IntPtr
    PackageDataA : Struct.Ptr
    PackageDataW : Struct.Ptr
    PrefixLen : IntPtr
    Prefix : UInt8[32]
}
struct NEGOTIATE_PACKAGE_PREFIXES {
    MessageType : UInt32
    PrefixCount : UInt32
    Offset : UInt32
    Pad : UInt32
}
struct NEGOTIATE_CALLER_NAME_REQUEST {
    MessageType : UInt32
    LogonId : LUID
}
struct NEGOTIATE_CALLER_NAME_RESPONSE {
    MessageType : UInt32
    CallerName : PWSTR
}
struct DOMAIN_PASSWORD_INFORMATION {
    MinPasswordLength : UInt16
    PasswordHistoryLength : UInt16
    PasswordProperties : DOMAIN_PASSWORD_PROPERTIES
    MaxPasswordAge : Int64
    MinPasswordAge : Int64
}
struct PSAM_PASSWORD_NOTIFICATION_ROUTINE extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, UInt32, LSA_UNICODE_STRING.Ptr, NTSTATUS]
}
struct PSAM_INIT_NOTIFICATION_ROUTINE extends FunctionPointer {
    static Types := [BOOLEAN]
}
struct PSAM_PASSWORD_FILTER_ROUTINE extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, BOOLEAN, BOOLEAN]
}
struct MSV1_0_LOGON_SUBMIT_TYPE extends Int32 {
    static MsV1_0InteractiveLogon := 2
    static MsV1_0Lm20Logon := 3
    static MsV1_0NetworkLogon := 4
    static MsV1_0SubAuthLogon := 5
    static MsV1_0WorkstationUnlockLogon := 7
    static MsV1_0S4ULogon := 12
    static MsV1_0VirtualLogon := 82
    static MsV1_0NoElevationLogon := 83
    static MsV1_0LuidLogon := 84
}
struct MSV1_0_PROFILE_BUFFER_TYPE extends Int32 {
    static MsV1_0InteractiveProfile := 2
    static MsV1_0Lm20LogonProfile := 3
    static MsV1_0SmartCardProfile := 4
}
struct MSV1_0_INTERACTIVE_LOGON {
    MessageType : MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName : LSA_UNICODE_STRING
    UserName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
}
struct MSV1_0_INTERACTIVE_PROFILE {
    MessageType : MSV1_0_PROFILE_BUFFER_TYPE
    LogonCount : UInt16
    BadPasswordCount : UInt16
    LogonTime : Int64
    LogoffTime : Int64
    KickOffTime : Int64
    PasswordLastSet : Int64
    PasswordCanChange : Int64
    PasswordMustChange : Int64
    LogonScript : LSA_UNICODE_STRING
    HomeDirectory : LSA_UNICODE_STRING
    FullName : LSA_UNICODE_STRING
    ProfilePath : LSA_UNICODE_STRING
    HomeDirectoryDrive : LSA_UNICODE_STRING
    LogonServer : LSA_UNICODE_STRING
    UserFlags : UInt32
}
struct MSV1_0_LM20_LOGON {
    MessageType : MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName : LSA_UNICODE_STRING
    UserName : LSA_UNICODE_STRING
    Workstation : LSA_UNICODE_STRING
    ChallengeToClient : UInt8[8]
    CaseSensitiveChallengeResponse : LSA_STRING
    CaseInsensitiveChallengeResponse : LSA_STRING
    ParameterControl : UInt32
}
struct MSV1_0_SUBAUTH_LOGON {
    MessageType : MSV1_0_LOGON_SUBMIT_TYPE
    LogonDomainName : LSA_UNICODE_STRING
    UserName : LSA_UNICODE_STRING
    Workstation : LSA_UNICODE_STRING
    ChallengeToClient : UInt8[8]
    AuthenticationInfo1 : LSA_STRING
    AuthenticationInfo2 : LSA_STRING
    ParameterControl : MSV_SUBAUTH_LOGON_PARAMETER_CONTROL
    SubAuthPackageId : UInt32
}
struct MSV1_0_S4U_LOGON {
    MessageType : MSV1_0_LOGON_SUBMIT_TYPE
    Flags : UInt32
    UserPrincipalName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
}
struct MSV1_0_LM20_LOGON_PROFILE {
    MessageType : MSV1_0_PROFILE_BUFFER_TYPE
    KickOffTime : Int64
    LogoffTime : Int64
    UserFlags : MSV_SUB_AUTHENTICATION_FILTER
    UserSessionKey : UInt8[16]
    LogonDomainName : LSA_UNICODE_STRING
    LanmanSessionKey : UInt8[8]
    LogonServer : LSA_UNICODE_STRING
    UserParameters : LSA_UNICODE_STRING
}
struct MSV1_0_CREDENTIAL_KEY_TYPE extends Int32 {
    static InvalidCredKey := 0
    static DeprecatedIUMCredKey := 1
    static DomainUserCredKey := 2
    static LocalUserCredKey := 3
    static ExternallySuppliedCredKey := 4
}
struct MSV1_0_CREDENTIAL_KEY {
    Data : UInt8[20]
}
struct MSV1_0_SUPPLEMENTAL_CREDENTIAL {
    Version : UInt32
    Flags : MSV_SUPPLEMENTAL_CREDENTIAL_FLAGS
    LmPassword : UInt8[16]
    NtPassword : UInt8[16]
}
struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V2 {
    Version : UInt32
    Flags : UInt32
    NtPassword : UInt8[16]
    CredentialKey : MSV1_0_CREDENTIAL_KEY
}
struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V3 {
    Version : UInt32
    Flags : UInt32
    CredentialKeyType : MSV1_0_CREDENTIAL_KEY_TYPE
    NtPassword : UInt8[16]
    CredentialKey : MSV1_0_CREDENTIAL_KEY
    ShaPassword : UInt8[20]
}
struct MSV1_0_IUM_SUPPLEMENTAL_CREDENTIAL {
    Version : UInt32
    EncryptedCredsSize : UInt32
    EncryptedCreds : UInt8[1]
}
struct MSV1_0_REMOTE_SUPPLEMENTAL_CREDENTIAL {
    Version : UInt32
    Flags : UInt32
    CredentialKey : MSV1_0_CREDENTIAL_KEY
    CredentialKeyType : MSV1_0_CREDENTIAL_KEY_TYPE
    EncryptedCredsSize : UInt32
    EncryptedCreds : UInt8[1]
}
struct MSV1_0_NTLM3_RESPONSE {
    Response : UInt8[16]
    RespType : UInt8
    HiRespType : UInt8
    Flags : UInt16
    MsgWord : UInt32
    TimeStamp : Int64
    ChallengeFromClient : UInt8[8]
    AvPairsOff : UInt32
    Buffer : UInt8[1]
}
struct MSV1_0_AVID extends Int32 {
    static MsvAvEOL := 0
    static MsvAvNbComputerName := 1
    static MsvAvNbDomainName := 2
    static MsvAvDnsComputerName := 3
    static MsvAvDnsDomainName := 4
    static MsvAvDnsTreeName := 5
    static MsvAvFlags := 6
    static MsvAvTimestamp := 7
    static MsvAvRestrictions := 8
    static MsvAvTargetName := 9
    static MsvAvChannelBindings := 10
}
struct MSV1_0_AV_PAIR {
    AvId : UInt16
    AvLen : UInt16
}
struct MSV1_0_PROTOCOL_MESSAGE_TYPE extends Int32 {
    static MsV1_0Lm20ChallengeRequest := 0
    static MsV1_0Lm20GetChallengeResponse := 1
    static MsV1_0EnumerateUsers := 2
    static MsV1_0GetUserInfo := 3
    static MsV1_0ReLogonUsers := 4
    static MsV1_0ChangePassword := 5
    static MsV1_0ChangeCachedPassword := 6
    static MsV1_0GenericPassthrough := 7
    static MsV1_0CacheLogon := 8
    static MsV1_0SubAuth := 9
    static MsV1_0DeriveCredential := 10
    static MsV1_0CacheLookup := 11
    static MsV1_0SetProcessOption := 12
    static MsV1_0ConfigLocalAliases := 13
    static MsV1_0ClearCachedCredentials := 14
    static MsV1_0LookupToken := 15
    static MsV1_0ValidateAuth := 16
    static MsV1_0CacheLookupEx := 17
    static MsV1_0GetCredentialKey := 18
    static MsV1_0SetThreadOption := 19
    static MsV1_0DecryptDpapiMasterKey := 20
    static MsV1_0GetStrongCredentialKey := 21
    static MsV1_0TransferCred := 22
    static MsV1_0ProvisionTbal := 23
    static MsV1_0DeleteTbalSecrets := 24
}
struct MSV1_0_CHANGEPASSWORD_REQUEST {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    DomainName : LSA_UNICODE_STRING
    AccountName : LSA_UNICODE_STRING
    OldPassword : LSA_UNICODE_STRING
    NewPassword : LSA_UNICODE_STRING
    Impersonating : BOOLEAN
}
struct MSV1_0_CHANGEPASSWORD_RESPONSE {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    PasswordInfoValid : BOOLEAN
    DomainPasswordInfo : DOMAIN_PASSWORD_INFORMATION
}
struct MSV1_0_PASSTHROUGH_REQUEST {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    DomainName : LSA_UNICODE_STRING
    PackageName : LSA_UNICODE_STRING
    DataLength : UInt32
    LogonData : UInt8.Ptr
    Pad : UInt32
}
struct MSV1_0_PASSTHROUGH_RESPONSE {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    Pad : UInt32
    DataLength : UInt32
    ValidationData : UInt8.Ptr
}
struct MSV1_0_SUBAUTH_REQUEST {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    SubAuthPackageId : UInt32
    SubAuthInfoLength : UInt32
    SubAuthSubmitBuffer : UInt8.Ptr
}
struct MSV1_0_SUBAUTH_RESPONSE {
    MessageType : MSV1_0_PROTOCOL_MESSAGE_TYPE
    SubAuthInfoLength : UInt32
    SubAuthReturnBuffer : UInt8.Ptr
}
struct KERB_LOGON_SUBMIT_TYPE extends Int32 {
    static KerbInteractiveLogon := 2
    static KerbSmartCardLogon := 6
    static KerbWorkstationUnlockLogon := 7
    static KerbSmartCardUnlockLogon := 8
    static KerbProxyLogon := 9
    static KerbTicketLogon := 10
    static KerbTicketUnlockLogon := 11
    static KerbS4ULogon := 12
    static KerbCertificateLogon := 13
    static KerbCertificateS4ULogon := 14
    static KerbCertificateUnlockLogon := 15
    static KerbNoElevationLogon := 83
    static KerbLuidLogon := 84
}
struct KERB_INTERACTIVE_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    LogonDomainName : LSA_UNICODE_STRING
    UserName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
}
struct KERB_INTERACTIVE_UNLOCK_LOGON {
    Logon : KERB_INTERACTIVE_LOGON
    LogonId : LUID
}
struct KERB_SMART_CARD_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    Pin : LSA_UNICODE_STRING
    CspDataLength : UInt32
    CspData : UInt8.Ptr
}
struct KERB_SMART_CARD_UNLOCK_LOGON {
    Logon : KERB_SMART_CARD_LOGON
    LogonId : LUID
}
struct KERB_CERTIFICATE_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    DomainName : LSA_UNICODE_STRING
    UserName : LSA_UNICODE_STRING
    Pin : LSA_UNICODE_STRING
    Flags : UInt32
    CspDataLength : UInt32
    CspData : UInt8.Ptr
}
struct KERB_CERTIFICATE_UNLOCK_LOGON {
    Logon : KERB_CERTIFICATE_LOGON
    LogonId : LUID
}
struct KERB_CERTIFICATE_S4U_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    Flags : UInt32
    UserPrincipalName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    CertificateLength : UInt32
    Certificate : UInt8.Ptr
}
struct KERB_TICKET_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    Flags : UInt32
    ServiceTicketLength : UInt32
    TicketGrantingTicketLength : UInt32
    ServiceTicket : UInt8.Ptr
    TicketGrantingTicket : UInt8.Ptr
}
struct KERB_TICKET_UNLOCK_LOGON {
    Logon : KERB_TICKET_LOGON
    LogonId : LUID
}
struct KERB_S4U_LOGON {
    MessageType : KERB_LOGON_SUBMIT_TYPE
    Flags : UInt32
    ClientUpn : LSA_UNICODE_STRING
    ClientRealm : LSA_UNICODE_STRING
}
struct KERB_PROFILE_BUFFER_TYPE extends Int32 {
    static KerbInteractiveProfile := 2
    static KerbSmartCardProfile := 4
    static KerbTicketProfile := 6
}
struct KERB_INTERACTIVE_PROFILE {
    MessageType : KERB_PROFILE_BUFFER_TYPE
    LogonCount : UInt16
    BadPasswordCount : UInt16
    LogonTime : Int64
    LogoffTime : Int64
    KickOffTime : Int64
    PasswordLastSet : Int64
    PasswordCanChange : Int64
    PasswordMustChange : Int64
    LogonScript : LSA_UNICODE_STRING
    HomeDirectory : LSA_UNICODE_STRING
    FullName : LSA_UNICODE_STRING
    ProfilePath : LSA_UNICODE_STRING
    HomeDirectoryDrive : LSA_UNICODE_STRING
    LogonServer : LSA_UNICODE_STRING
    UserFlags : UInt32
}
struct KERB_SMART_CARD_PROFILE {
    Profile : KERB_INTERACTIVE_PROFILE
    CertificateSize : UInt32
    CertificateData : UInt8.Ptr
}
struct KERB_CRYPTO_KEY {
    KeyType : KERB_CRYPTO_KEY_TYPE
    Length : UInt32
    Value : UInt8.Ptr
}
struct KERB_CRYPTO_KEY32 {
    KeyType : Int32
    Length : UInt32
    Offset : UInt32
}
struct KERB_TICKET_PROFILE {
    Profile : KERB_INTERACTIVE_PROFILE
    SessionKey : KERB_CRYPTO_KEY
}
struct KERB_PROTOCOL_MESSAGE_TYPE extends Int32 {
    static KerbDebugRequestMessage := 0
    static KerbQueryTicketCacheMessage := 1
    static KerbChangeMachinePasswordMessage := 2
    static KerbVerifyPacMessage := 3
    static KerbRetrieveTicketMessage := 4
    static KerbUpdateAddressesMessage := 5
    static KerbPurgeTicketCacheMessage := 6
    static KerbChangePasswordMessage := 7
    static KerbRetrieveEncodedTicketMessage := 8
    static KerbDecryptDataMessage := 9
    static KerbAddBindingCacheEntryMessage := 10
    static KerbSetPasswordMessage := 11
    static KerbSetPasswordExMessage := 12
    static KerbVerifyCredentialsMessage := 13
    static KerbQueryTicketCacheExMessage := 14
    static KerbPurgeTicketCacheExMessage := 15
    static KerbRefreshSmartcardCredentialsMessage := 16
    static KerbAddExtraCredentialsMessage := 17
    static KerbQuerySupplementalCredentialsMessage := 18
    static KerbTransferCredentialsMessage := 19
    static KerbQueryTicketCacheEx2Message := 20
    static KerbSubmitTicketMessage := 21
    static KerbAddExtraCredentialsExMessage := 22
    static KerbQueryKdcProxyCacheMessage := 23
    static KerbPurgeKdcProxyCacheMessage := 24
    static KerbQueryTicketCacheEx3Message := 25
    static KerbCleanupMachinePkinitCredsMessage := 26
    static KerbAddBindingCacheEntryExMessage := 27
    static KerbQueryBindingCacheMessage := 28
    static KerbPurgeBindingCacheMessage := 29
    static KerbPinKdcMessage := 30
    static KerbUnpinAllKdcsMessage := 31
    static KerbQueryDomainExtendedPoliciesMessage := 32
    static KerbQueryS4U2ProxyCacheMessage := 33
    static KerbRetrieveKeyTabMessage := 34
    static KerbRefreshPolicyMessage := 35
    static KerbPrintCloudKerberosDebugMessage := 36
    static KerbNetworkTicketLogonMessage := 37
    static KerbNlChangeMachinePasswordMessage := 38
}
struct KERB_QUERY_TKT_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
}
struct KERB_TICKET_CACHE_INFO {
    ServerName : LSA_UNICODE_STRING
    RealmName : LSA_UNICODE_STRING
    StartTime : Int64
    EndTime : Int64
    RenewTime : Int64
    EncryptionType : Int32
    TicketFlags : KERB_TICKET_FLAGS
}
struct KERB_TICKET_CACHE_INFO_EX {
    ClientName : LSA_UNICODE_STRING
    ClientRealm : LSA_UNICODE_STRING
    ServerName : LSA_UNICODE_STRING
    ServerRealm : LSA_UNICODE_STRING
    StartTime : Int64
    EndTime : Int64
    RenewTime : Int64
    EncryptionType : Int32
    TicketFlags : UInt32
}
struct KERB_TICKET_CACHE_INFO_EX2 {
    ClientName : LSA_UNICODE_STRING
    ClientRealm : LSA_UNICODE_STRING
    ServerName : LSA_UNICODE_STRING
    ServerRealm : LSA_UNICODE_STRING
    StartTime : Int64
    EndTime : Int64
    RenewTime : Int64
    EncryptionType : Int32
    TicketFlags : UInt32
    SessionKeyType : UInt32
    BranchId : UInt32
}
struct KERB_TICKET_CACHE_INFO_EX3 {
    ClientName : LSA_UNICODE_STRING
    ClientRealm : LSA_UNICODE_STRING
    ServerName : LSA_UNICODE_STRING
    ServerRealm : LSA_UNICODE_STRING
    StartTime : Int64
    EndTime : Int64
    RenewTime : Int64
    EncryptionType : Int32
    TicketFlags : UInt32
    SessionKeyType : UInt32
    BranchId : UInt32
    CacheFlags : UInt32
    KdcCalled : LSA_UNICODE_STRING
}
struct KERB_QUERY_TKT_CACHE_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets : UInt32
    Tickets : KERB_TICKET_CACHE_INFO[1]
}
struct KERB_QUERY_TKT_CACHE_EX_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets : UInt32
    Tickets : KERB_TICKET_CACHE_INFO_EX[1]
}
struct KERB_QUERY_TKT_CACHE_EX2_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets : UInt32
    Tickets : KERB_TICKET_CACHE_INFO_EX2[1]
}
struct KERB_QUERY_TKT_CACHE_EX3_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfTickets : UInt32
    Tickets : KERB_TICKET_CACHE_INFO_EX3[1]
}
struct KERB_AUTH_DATA {
    Type : UInt32
    Length : UInt32
    Data : UInt8.Ptr
}
struct KERB_NET_ADDRESS {
    Family : UInt32
    Length : UInt32
    Address : PSTR
}
struct KERB_NET_ADDRESSES {
    Number : UInt32
    Addresses : KERB_NET_ADDRESS[1]
}
struct KERB_EXTERNAL_NAME {
    NameType : Int16
    NameCount : UInt16
    Names : LSA_UNICODE_STRING[1]
}
struct KERB_EXTERNAL_TICKET {
    ServiceName : KERB_EXTERNAL_NAME.Ptr
    TargetName : KERB_EXTERNAL_NAME.Ptr
    ClientName : KERB_EXTERNAL_NAME.Ptr
    DomainName : LSA_UNICODE_STRING
    TargetDomainName : LSA_UNICODE_STRING
    AltTargetDomainName : LSA_UNICODE_STRING
    SessionKey : KERB_CRYPTO_KEY
    TicketFlags : KERB_TICKET_FLAGS
    Flags : UInt32
    KeyExpirationTime : Int64
    StartTime : Int64
    EndTime : Int64
    RenewUntil : Int64
    TimeSkew : Int64
    EncodedTicketSize : UInt32
    EncodedTicket : UInt8.Ptr
}
struct KERB_RETRIEVE_TKT_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    TargetName : LSA_UNICODE_STRING
    TicketFlags : UInt32
    CacheOptions : UInt32
    EncryptionType : KERB_CRYPTO_KEY_TYPE
    CredentialsHandle : SecHandle
}
struct KERB_RETRIEVE_TKT_RESPONSE {
    Ticket : KERB_EXTERNAL_TICKET
}
struct KERB_PURGE_TKT_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    ServerName : LSA_UNICODE_STRING
    RealmName : LSA_UNICODE_STRING
}
struct KERB_PURGE_TKT_CACHE_EX_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    Flags : UInt32
    TicketTemplate : KERB_TICKET_CACHE_INFO_EX
}
struct KERB_SUBMIT_TKT_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    Flags : UInt32
    Key : KERB_CRYPTO_KEY32
    KerbCredSize : UInt32
    KerbCredOffset : UInt32
}
struct KERB_QUERY_KDC_PROXY_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    LogonId : LUID
}
struct KDC_PROXY_CACHE_ENTRY_DATA {
    SinceLastUsed : Int64
    DomainName : LSA_UNICODE_STRING
    ProxyServerName : LSA_UNICODE_STRING
    ProxyServerVdir : LSA_UNICODE_STRING
    ProxyServerPort : UInt16
    LogonId : LUID
    CredUserName : LSA_UNICODE_STRING
    CredDomainName : LSA_UNICODE_STRING
    GlobalCache : BOOLEAN
}
struct KERB_QUERY_KDC_PROXY_CACHE_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfEntries : UInt32
    Entries : KDC_PROXY_CACHE_ENTRY_DATA.Ptr
}
struct KERB_PURGE_KDC_PROXY_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    LogonId : LUID
}
struct KERB_PURGE_KDC_PROXY_CACHE_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfPurged : UInt32
}
struct KERB_S4U2PROXY_CACHE_ENTRY_INFO {
    ServerName : LSA_UNICODE_STRING
    Flags : UInt32
    LastStatus : NTSTATUS
    Expiry : Int64
}
struct KERB_S4U2PROXY_CRED {
    UserName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    Flags : UInt32
    LastStatus : NTSTATUS
    Expiry : Int64
    CountOfEntries : UInt32
    Entries : KERB_S4U2PROXY_CACHE_ENTRY_INFO.Ptr
}
struct KERB_QUERY_S4U2PROXY_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    LogonId : LUID
}
struct KERB_QUERY_S4U2PROXY_CACHE_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfCreds : UInt32
    Creds : KERB_S4U2PROXY_CRED.Ptr
}
struct KERB_RETRIEVE_KEY_TAB_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    UserName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
}
struct KERB_RETRIEVE_KEY_TAB_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    KeyTabLength : UInt32
    KeyTab : UInt8.Ptr
}
struct KERB_REFRESH_POLICY_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
}
struct KERB_REFRESH_POLICY_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
}
struct KERB_CLOUD_KERBEROS_DEBUG_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
}
struct KERB_CLOUD_KERBEROS_DEBUG_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Version : UInt32
    Length : UInt32
    Data : UInt32[1]
}
struct KERB_CLOUD_KERBEROS_DEBUG_DATA_V0 {
    _bitfield : UInt32
}
struct KERB_CLOUD_KERBEROS_DEBUG_DATA {
    _bitfield : UInt32
}
struct KERB_CHANGEPASSWORD_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    DomainName : LSA_UNICODE_STRING
    AccountName : LSA_UNICODE_STRING
    OldPassword : LSA_UNICODE_STRING
    NewPassword : LSA_UNICODE_STRING
    Impersonating : BOOLEAN
}
struct KERB_SETPASSWORD_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    CredentialsHandle : SecHandle
    Flags : UInt32
    DomainName : LSA_UNICODE_STRING
    AccountName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
}
struct KERB_SETPASSWORD_EX_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    CredentialsHandle : SecHandle
    Flags : UInt32
    AccountRealm : LSA_UNICODE_STRING
    AccountName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
    ClientRealm : LSA_UNICODE_STRING
    ClientName : LSA_UNICODE_STRING
    Impersonating : BOOLEAN
    KdcAddress : LSA_UNICODE_STRING
    KdcAddressType : UInt32
}
struct KERB_CHANGEMACHINEPASSWORD_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    ForcePasswordChange : BOOLEAN
}
struct KERB_DECRYPT_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
    Flags : UInt32
    CryptoType : Int32
    KeyUsage : Int32
    Key : KERB_CRYPTO_KEY
    EncryptedDataSize : UInt32
    InitialVectorSize : UInt32
    InitialVector : UInt8.Ptr
    EncryptedData : UInt8.Ptr
}
struct KERB_DECRYPT_RESPONSE {
    DecryptedData : UInt8[1]
}
struct KERB_ADD_BINDING_CACHE_ENTRY_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    RealmName : LSA_UNICODE_STRING
    KdcAddress : LSA_UNICODE_STRING
    AddressType : KERB_ADDRESS_TYPE
}
struct KERB_REFRESH_SCCRED_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CredentialBlob : LSA_UNICODE_STRING
    LogonId : LUID
    Flags : UInt32
}
struct KERB_ADD_CREDENTIALS_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    UserName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
    LogonId : LUID
    Flags : KERB_REQUEST_FLAGS
}
struct KERB_ADD_CREDENTIALS_REQUEST_EX {
    Credentials : KERB_ADD_CREDENTIALS_REQUEST
    PrincipalNameCount : UInt32
    PrincipalNames : LSA_UNICODE_STRING[1]
}
struct KERB_TRANSFER_CRED_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    OriginLogonId : LUID
    DestinationLogonId : LUID
    Flags : UInt32
}
struct KERB_CLEANUP_MACHINE_PKINIT_CREDS_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    LogonId : LUID
}
struct KERB_BINDING_CACHE_ENTRY_DATA {
    DiscoveryTime : Int64
    RealmName : LSA_UNICODE_STRING
    KdcAddress : LSA_UNICODE_STRING
    AddressType : KERB_ADDRESS_TYPE
    Flags : UInt32
    DcFlags : UInt32
    CacheFlags : UInt32
    KdcName : LSA_UNICODE_STRING
}
struct KERB_QUERY_BINDING_CACHE_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    CountOfEntries : UInt32
    Entries : KERB_BINDING_CACHE_ENTRY_DATA.Ptr
}
struct KERB_ADD_BINDING_CACHE_ENTRY_EX_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    RealmName : LSA_UNICODE_STRING
    KdcAddress : LSA_UNICODE_STRING
    AddressType : KERB_ADDRESS_TYPE
    DcFlags : UInt32
}
struct KERB_QUERY_BINDING_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
}
struct KERB_PURGE_BINDING_CACHE_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
}
struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_REQUEST {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    DomainName : LSA_UNICODE_STRING
}
struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_RESPONSE {
    MessageType : KERB_PROTOCOL_MESSAGE_TYPE
    Flags : UInt32
    ExtendedPolicies : UInt32
    DsFlags : UInt32
}
struct KERB_CERTIFICATE_INFO_TYPE extends Int32 {
    static CertHashInfo := 1
}
struct KERB_CERTIFICATE_HASHINFO {
    StoreNameLength : UInt16
    HashLength : UInt16
}
struct KERB_CERTIFICATE_INFO {
    CertInfoSize : UInt32
    InfoType : UInt32
}
struct POLICY_AUDIT_SID_ARRAY {
    UsersCount : UInt32
    UserSidArray : PSID.Ptr
}
struct AUDIT_POLICY_INFORMATION {
    AuditSubCategoryGuid : GUID
    AuditingInformation : UInt32
    AuditCategoryGuid : GUID
}
struct PKU2U_CERT_BLOB {
    CertOffset : UInt32
    CertLength : UInt16
}
struct PKU2U_CREDUI_CONTEXT {
    Version : Int64
    cbHeaderLength : UInt16
    cbStructureLength : UInt32
    CertArrayCount : UInt16
    CertArrayOffset : UInt32
}
struct PKU2U_LOGON_SUBMIT_TYPE extends Int32 {
    static Pku2uCertificateS4ULogon := 14
}
struct PKU2U_CERTIFICATE_S4U_LOGON {
    MessageType : PKU2U_LOGON_SUBMIT_TYPE
    Flags : UInt32
    UserPrincipalName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    CertificateLength : UInt32
    Certificate : UInt8.Ptr
}
struct SECURITY_STRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : UInt16.Ptr
}
struct SecPkgInfoW {
    fCapabilities : UInt32
    wVersion : UInt16
    wRPCID : UInt16
    cbMaxToken : UInt32
    Name : UInt16.Ptr
    Comment : UInt16.Ptr
}
struct SecPkgInfoA {
    fCapabilities : UInt32
    wVersion : UInt16
    wRPCID : UInt16
    cbMaxToken : UInt32
    Name : Int8.Ptr
    Comment : Int8.Ptr
}
struct SecBuffer {
    cbBuffer : UInt32
    BufferType : UInt32
    pvBuffer : Struct.Ptr
}
struct SecBufferDesc {
    ulVersion : UInt32
    cBuffers : UInt32
    pBuffers : SecBuffer.Ptr
}
struct SEC_NEGOTIATION_INFO {
    Size : UInt32
    NameLength : UInt32
    Name : UInt16.Ptr
    Reserved : Struct.Ptr
}
struct SEC_CHANNEL_BINDINGS {
    dwInitiatorAddrType : UInt32
    cbInitiatorLength : UInt32
    dwInitiatorOffset : UInt32
    dwAcceptorAddrType : UInt32
    cbAcceptorLength : UInt32
    dwAcceptorOffset : UInt32
    cbApplicationDataLength : UInt32
    dwApplicationDataOffset : UInt32
}
struct SEC_CHANNEL_BINDINGS_EX {
    magicNumber : UInt32
    flags : UInt32
    cbHeaderLength : UInt32
    cbStructureLength : UInt32
    dwInitiatorAddrType : UInt32
    cbInitiatorLength : UInt32
    dwInitiatorOffset : UInt32
    dwAcceptorAddrType : UInt32
    cbAcceptorLength : UInt32
    dwAcceptorOffset : UInt32
    cbApplicationDataLength : UInt32
    dwApplicationDataOffset : UInt32
}
struct SEC_CHANNEL_BINDINGS_RESULT {
    flags : UInt32
}
struct SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT extends Int32 {
    static SecApplicationProtocolNegotiationExt_None := 0
    static SecApplicationProtocolNegotiationExt_NPN := 1
    static SecApplicationProtocolNegotiationExt_ALPN := 2
}
struct SEC_APPLICATION_PROTOCOL_LIST {
    ProtoNegoExt : SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT
    ProtocolListSize : UInt16
    ProtocolList : UInt8[1]
}
struct SEC_APPLICATION_PROTOCOLS {
    ProtocolListsSize : UInt32
    ProtocolLists : SEC_APPLICATION_PROTOCOL_LIST[1]
}
struct SEC_SRTP_PROTECTION_PROFILES {
    ProfilesSize : UInt16
    ProfilesList : UInt16[1]
}
struct SEC_SRTP_MASTER_KEY_IDENTIFIER {
    MasterKeyIdentifierSize : UInt8
    MasterKeyIdentifier : UInt8[1]
}
struct SEC_TOKEN_BINDING {
    MajorVersion : UInt8
    MinorVersion : UInt8
    KeyParametersSize : UInt16
    KeyParameters : UInt8[1]
}
struct SEC_PRESHAREDKEY {
    KeySize : UInt16
    Key : UInt8[1]
}
struct SEC_PRESHAREDKEY_IDENTITY {
    KeyIdentitySize : UInt16
    KeyIdentity : UInt8[1]
}
struct SEC_DTLS_MTU {
    PathMTU : UInt16
}
struct SEC_FLAGS {
    Flags : Int64
}
struct SEC_CERTIFICATE_REQUEST_CONTEXT {
    cbCertificateRequestContext : UInt8
    rgCertificateRequestContext : UInt8[1]
}
struct SEC_APP_SESSION_STATE {
    AppSessionStateSize : UInt16
    AppSessionState : UInt8[1]
}
struct SEC_SESSION_TICKET {
    SessionTicketSize : UInt16
    SessionTicket : UInt8[1]
}
struct SEC_TRAFFIC_SECRET_TYPE extends Int32 {
    static SecTrafficSecret_None := 0
    static SecTrafficSecret_Client := 1
    static SecTrafficSecret_Server := 2
}
struct SEC_TRAFFIC_SECRETS {
    SymmetricAlgId : UInt16[64]
    ChainingMode : UInt16[64]
    HashAlgId : UInt16[64]
    KeySize : UInt16
    IvSize : UInt16
    MsgSequenceStart : UInt16
    MsgSequenceEnd : UInt16
    TrafficSecretType : SEC_TRAFFIC_SECRET_TYPE
    TrafficSecretSize : UInt16
    TrafficSecret : UInt8[1]
}
struct SecPkgCredentials_NamesW {
    sUserName : UInt16.Ptr
}
struct SecPkgCredentials_NamesA {
    sUserName : Int8.Ptr
}
struct SecPkgCredentials_SSIProviderW {
    sProviderName : UInt16.Ptr
    ProviderInfoLength : UInt32
    ProviderInfo : PSTR
}
struct SecPkgCredentials_SSIProviderA {
    sProviderName : Int8.Ptr
    ProviderInfoLength : UInt32
    ProviderInfo : PSTR
}
struct SecPkgCredentials_KdcProxySettingsW {
    Version : UInt32
    Flags : UInt32
    ProxyServerOffset : UInt16
    ProxyServerLength : UInt16
    ClientTlsCredOffset : UInt16
    ClientTlsCredLength : UInt16
}
struct SecPkgCredentials_KdcNetworkSettingsW {
    Version : UInt32
    Flags : UInt32
    ProxyServerOffset : UInt16
    ProxyServerLength : UInt16
    ClientTlsCredOffset : UInt16
    ClientTlsCredLength : UInt16
    DcDiscoveryFlags : UInt32
}
struct SecPkgCredentials_Cert {
    EncodedCertSize : UInt32
    EncodedCert : UInt8.Ptr
}
struct SecPkgContext_SubjectAttributes {
    AttributeInfo : Struct.Ptr
}
struct SECPKG_CRED_CLASS extends Int32 {
    static SecPkgCredClass_None := 0
    static SecPkgCredClass_Ephemeral := 10
    static SecPkgCredClass_PersistedGeneric := 20
    static SecPkgCredClass_PersistedSpecific := 30
    static SecPkgCredClass_Explicit := 40
}
struct SecPkgContext_CredInfo {
    CredClass : SECPKG_CRED_CLASS
    IsPromptingNeeded : UInt32
}
struct SecPkgContext_NegoPackageInfo {
    PackageMask : UInt32
}
struct SecPkgContext_NegoStatus {
    LastStatus : UInt32
}
struct SecPkgContext_Sizes {
    cbMaxToken : UInt32
    cbMaxSignature : UInt32
    cbBlockSize : UInt32
    cbSecurityTrailer : UInt32
}
struct SecPkgContext_StreamSizes {
    cbHeader : UInt32
    cbTrailer : UInt32
    cbMaximumMessage : UInt32
    cBuffers : UInt32
    cbBlockSize : UInt32
}
struct SecPkgContext_NamesW {
    sUserName : UInt16.Ptr
}
struct SECPKG_ATTR_LCT_STATUS extends Int32 {
    static SecPkgAttrLastClientTokenYes := 0
    static SecPkgAttrLastClientTokenNo := 1
    static SecPkgAttrLastClientTokenMaybe := 2
}
struct SecPkgContext_LastClientTokenStatus {
    LastClientTokenStatus : SECPKG_ATTR_LCT_STATUS
}
struct SecPkgContext_NamesA {
    sUserName : Int8.Ptr
}
struct SecPkgContext_Lifespan {
    tsStart : Int64
    tsExpiry : Int64
}
struct SecPkgContext_DceInfo {
    AuthzSvc : UInt32
    pPac : Struct.Ptr
}
struct SecPkgContext_KeyInfoA {
    sSignatureAlgorithmName : Int8.Ptr
    sEncryptAlgorithmName : Int8.Ptr
    KeySize : UInt32
    SignatureAlgorithm : UInt32
    EncryptAlgorithm : UInt32
}
struct SecPkgContext_KeyInfoW {
    sSignatureAlgorithmName : UInt16.Ptr
    sEncryptAlgorithmName : UInt16.Ptr
    KeySize : UInt32
    SignatureAlgorithm : UInt32
    EncryptAlgorithm : UInt32
}
struct SecPkgContext_AuthorityA {
    sAuthorityName : Int8.Ptr
}
struct SecPkgContext_AuthorityW {
    sAuthorityName : UInt16.Ptr
}
struct SecPkgContext_ProtoInfoA {
    sProtocolName : Int8.Ptr
    majorVersion : UInt32
    minorVersion : UInt32
}
struct SecPkgContext_ProtoInfoW {
    sProtocolName : UInt16.Ptr
    majorVersion : UInt32
    minorVersion : UInt32
}
struct SecPkgContext_PasswordExpiry {
    tsPasswordExpires : Int64
}
struct SecPkgContext_LogoffTime {
    tsLogoffTime : Int64
}
struct SecPkgContext_SessionKey {
    SessionKeyLength : UInt32
    SessionKey : UInt8.Ptr
}
struct SecPkgContext_NegoKeys {
    KeyType : UInt32
    KeyLength : UInt16
    KeyValue : UInt8.Ptr
    VerifyKeyType : UInt32
    VerifyKeyLength : UInt16
    VerifyKeyValue : UInt8.Ptr
}
struct SecPkgContext_PackageInfoW {
    PackageInfo : SecPkgInfoW.Ptr
}
struct SecPkgContext_PackageInfoA {
    PackageInfo : SecPkgInfoA.Ptr
}
struct SecPkgContext_UserFlags {
    UserFlags : UInt32
}
struct SecPkgContext_Flags {
    Flags : UInt32
}
struct SecPkgContext_NegotiationInfoA {
    PackageInfo : SecPkgInfoA.Ptr
    NegotiationState : UInt32
}
struct SecPkgContext_NegotiationInfoW {
    PackageInfo : SecPkgInfoW.Ptr
    NegotiationState : UInt32
}
struct SecPkgContext_NativeNamesW {
    sClientName : UInt16.Ptr
    sServerName : UInt16.Ptr
}
struct SecPkgContext_NativeNamesA {
    sClientName : Int8.Ptr
    sServerName : Int8.Ptr
}
struct SecPkgContext_CredentialNameW {
    CredentialType : UInt32
    sCredentialName : UInt16.Ptr
}
struct SecPkgContext_CredentialNameA {
    CredentialType : UInt32
    sCredentialName : Int8.Ptr
}
struct SecPkgContext_AccessToken {
    AccessToken : Struct.Ptr
}
struct SecPkgContext_TargetInformation {
    MarshalledTargetInfoLength : UInt32
    MarshalledTargetInfo : UInt8.Ptr
}
struct SecPkgContext_AuthzID {
    AuthzIDLength : UInt32
    AuthzID : PSTR
}
struct SecPkgContext_Target {
    TargetLength : UInt32
    Target : PSTR
}
struct SecPkgContext_ClientSpecifiedTarget {
    sTargetName : UInt16.Ptr
}
struct SecPkgContext_Bindings {
    BindingsLength : UInt32
    Bindings : SEC_CHANNEL_BINDINGS.Ptr
}
struct SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS extends Int32 {
    static SecApplicationProtocolNegotiationStatus_None := 0
    static SecApplicationProtocolNegotiationStatus_Success := 1
    static SecApplicationProtocolNegotiationStatus_SelectedClientOnly := 2
}
struct SecPkgContext_ApplicationProtocol {
    ProtoNegoStatus : SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS
    ProtoNegoExt : SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT
    ProtocolIdSize : UInt8
    ProtocolId : UInt8[255]
}
struct SecPkgContext_NegotiatedTlsExtensions {
    ExtensionsCount : UInt32
    Extensions : UInt16.Ptr
}
struct SECPKG_APP_MODE_INFO {
    UserFunction : UInt32
    Argument1 : IntPtr
    Argument2 : IntPtr
    UserData : SecBuffer
    ReturnToLsa : BOOLEAN
}
struct SEC_GET_KEY_FN extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, HRESULT.Ptr, "Void"]
}
struct ACQUIRE_CREDENTIALS_HANDLE_FN_W extends FunctionPointer {
    static Types := [UInt16.Ptr, UInt16.Ptr, UInt32, Struct.Ptr, Struct.Ptr, SEC_GET_KEY_FN, Struct.Ptr, SecHandle.Ptr, Int64.Ptr, HRESULT]
}
struct ACQUIRE_CREDENTIALS_HANDLE_FN_A extends FunctionPointer {
    static Types := [Int8.Ptr, Int8.Ptr, UInt32, Struct.Ptr, Struct.Ptr, SEC_GET_KEY_FN, Struct.Ptr, SecHandle.Ptr, Int64.Ptr, HRESULT]
}
struct FREE_CREDENTIALS_HANDLE_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, HRESULT]
}
struct ADD_CREDENTIALS_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt16.Ptr, UInt16.Ptr, UInt32, Struct.Ptr, SEC_GET_KEY_FN, Struct.Ptr, Int64.Ptr, HRESULT]
}
struct ADD_CREDENTIALS_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, Int8.Ptr, Int8.Ptr, UInt32, Struct.Ptr, SEC_GET_KEY_FN, Struct.Ptr, Int64.Ptr, HRESULT]
}
struct CHANGE_PASSWORD_FN_W extends FunctionPointer {
    static Types := [UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, BOOLEAN, UInt32, SecBufferDesc.Ptr, HRESULT]
}
struct CHANGE_PASSWORD_FN_A extends FunctionPointer {
    static Types := [Int8.Ptr, Int8.Ptr, Int8.Ptr, Int8.Ptr, Int8.Ptr, BOOLEAN, UInt32, SecBufferDesc.Ptr, HRESULT]
}
struct INITIALIZE_SECURITY_CONTEXT_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecHandle.Ptr, UInt16.Ptr, UInt32, UInt32, UInt32, SecBufferDesc.Ptr, UInt32, SecHandle.Ptr, SecBufferDesc.Ptr, UInt32.Ptr, Int64.Ptr, HRESULT]
}
struct INITIALIZE_SECURITY_CONTEXT_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecHandle.Ptr, Int8.Ptr, UInt32, UInt32, UInt32, SecBufferDesc.Ptr, UInt32, SecHandle.Ptr, SecBufferDesc.Ptr, UInt32.Ptr, Int64.Ptr, HRESULT]
}
struct ACCEPT_SECURITY_CONTEXT_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecHandle.Ptr, SecBufferDesc.Ptr, UInt32, UInt32, SecHandle.Ptr, SecBufferDesc.Ptr, UInt32.Ptr, Int64.Ptr, HRESULT]
}
struct COMPLETE_AUTH_TOKEN_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecBufferDesc.Ptr, HRESULT]
}
struct IMPERSONATE_SECURITY_CONTEXT_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, HRESULT]
}
struct REVERT_SECURITY_CONTEXT_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, HRESULT]
}
struct QUERY_SECURITY_CONTEXT_TOKEN_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct DELETE_SECURITY_CONTEXT_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, HRESULT]
}
struct APPLY_CONTROL_TOKEN_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecBufferDesc.Ptr, HRESULT]
}
struct QUERY_CONTEXT_ATTRIBUTES_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, HRESULT]
}
struct QUERY_CONTEXT_ATTRIBUTES_EX_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct QUERY_CONTEXT_ATTRIBUTES_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, HRESULT]
}
struct QUERY_CONTEXT_ATTRIBUTES_EX_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct SET_CONTEXT_ATTRIBUTES_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct SET_CONTEXT_ATTRIBUTES_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct QUERY_CREDENTIALS_ATTRIBUTES_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, HRESULT]
}
struct QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct QUERY_CREDENTIALS_ATTRIBUTES_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, HRESULT]
}
struct QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct SET_CREDENTIALS_ATTRIBUTES_FN_W extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct SET_CREDENTIALS_ATTRIBUTES_FN_A extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct FREE_CONTEXT_BUFFER_FN extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct MAKE_SIGNATURE_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, SecBufferDesc.Ptr, UInt32, HRESULT]
}
struct VERIFY_SIGNATURE_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct ENCRYPT_MESSAGE_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, SecBufferDesc.Ptr, UInt32, HRESULT]
}
struct DECRYPT_MESSAGE_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct ENUMERATE_SECURITY_PACKAGES_FN_W extends FunctionPointer {
    static Types := [UInt32.Ptr, SecPkgInfoW.Ptr.Ptr, HRESULT]
}
struct ENUMERATE_SECURITY_PACKAGES_FN_A extends FunctionPointer {
    static Types := [UInt32.Ptr, SecPkgInfoA.Ptr.Ptr, HRESULT]
}
struct QUERY_SECURITY_PACKAGE_INFO_FN_W extends FunctionPointer {
    static Types := [UInt16.Ptr, SecPkgInfoW.Ptr.Ptr, HRESULT]
}
struct QUERY_SECURITY_PACKAGE_INFO_FN_A extends FunctionPointer {
    static Types := [Int8.Ptr, SecPkgInfoA.Ptr.Ptr, HRESULT]
}
struct SecDelegationType extends Int32 {
    static SecFull := 0
    static SecService := 1
    static SecTree := 2
    static SecDirectory := 3
    static SecObject := 4
}
struct EXPORT_SECURITY_CONTEXT_FN extends FunctionPointer {
    static Types := [SecHandle.Ptr, UInt32, SecBuffer.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct IMPORT_SECURITY_CONTEXT_FN_W extends FunctionPointer {
    static Types := [UInt16.Ptr, SecBuffer.Ptr, Struct.Ptr, SecHandle.Ptr, HRESULT]
}
struct IMPORT_SECURITY_CONTEXT_FN_A extends FunctionPointer {
    static Types := [Int8.Ptr, SecBuffer.Ptr, Struct.Ptr, SecHandle.Ptr, HRESULT]
}
struct SecurityFunctionTableW {
    dwVersion : UInt32
    EnumerateSecurityPackagesW : ENUMERATE_SECURITY_PACKAGES_FN_W
    QueryCredentialsAttributesW : QUERY_CREDENTIALS_ATTRIBUTES_FN_W
    AcquireCredentialsHandleW : ACQUIRE_CREDENTIALS_HANDLE_FN_W
    FreeCredentialsHandle : FREE_CREDENTIALS_HANDLE_FN
    Reserved2 : Struct.Ptr
    InitializeSecurityContextW : INITIALIZE_SECURITY_CONTEXT_FN_W
    AcceptSecurityContext : ACCEPT_SECURITY_CONTEXT_FN
    CompleteAuthToken : COMPLETE_AUTH_TOKEN_FN
    DeleteSecurityContext : DELETE_SECURITY_CONTEXT_FN
    ApplyControlToken : APPLY_CONTROL_TOKEN_FN
    QueryContextAttributesW : QUERY_CONTEXT_ATTRIBUTES_FN_W
    ImpersonateSecurityContext : IMPERSONATE_SECURITY_CONTEXT_FN
    RevertSecurityContext : REVERT_SECURITY_CONTEXT_FN
    MakeSignature : MAKE_SIGNATURE_FN
    VerifySignature : VERIFY_SIGNATURE_FN
    FreeContextBuffer : FREE_CONTEXT_BUFFER_FN
    QuerySecurityPackageInfoW : QUERY_SECURITY_PACKAGE_INFO_FN_W
    Reserved3 : Struct.Ptr
    Reserved4 : Struct.Ptr
    ExportSecurityContext : EXPORT_SECURITY_CONTEXT_FN
    ImportSecurityContextW : IMPORT_SECURITY_CONTEXT_FN_W
    AddCredentialsW : ADD_CREDENTIALS_FN_W
    Reserved8 : Struct.Ptr
    QuerySecurityContextToken : QUERY_SECURITY_CONTEXT_TOKEN_FN
    EncryptMessage : ENCRYPT_MESSAGE_FN
    DecryptMessage : DECRYPT_MESSAGE_FN
    SetContextAttributesW : SET_CONTEXT_ATTRIBUTES_FN_W
    SetCredentialsAttributesW : SET_CREDENTIALS_ATTRIBUTES_FN_W
    ChangeAccountPasswordW : CHANGE_PASSWORD_FN_W
    QueryContextAttributesExW : QUERY_CONTEXT_ATTRIBUTES_EX_FN_W
    QueryCredentialsAttributesExW : QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W
}
struct SecurityFunctionTableA {
    dwVersion : UInt32
    EnumerateSecurityPackagesA : ENUMERATE_SECURITY_PACKAGES_FN_A
    QueryCredentialsAttributesA : QUERY_CREDENTIALS_ATTRIBUTES_FN_A
    AcquireCredentialsHandleA : ACQUIRE_CREDENTIALS_HANDLE_FN_A
    FreeCredentialsHandle : FREE_CREDENTIALS_HANDLE_FN
    Reserved2 : Struct.Ptr
    InitializeSecurityContextA : INITIALIZE_SECURITY_CONTEXT_FN_A
    AcceptSecurityContext : ACCEPT_SECURITY_CONTEXT_FN
    CompleteAuthToken : COMPLETE_AUTH_TOKEN_FN
    DeleteSecurityContext : DELETE_SECURITY_CONTEXT_FN
    ApplyControlToken : APPLY_CONTROL_TOKEN_FN
    QueryContextAttributesA : QUERY_CONTEXT_ATTRIBUTES_FN_A
    ImpersonateSecurityContext : IMPERSONATE_SECURITY_CONTEXT_FN
    RevertSecurityContext : REVERT_SECURITY_CONTEXT_FN
    MakeSignature : MAKE_SIGNATURE_FN
    VerifySignature : VERIFY_SIGNATURE_FN
    FreeContextBuffer : FREE_CONTEXT_BUFFER_FN
    QuerySecurityPackageInfoA : QUERY_SECURITY_PACKAGE_INFO_FN_A
    Reserved3 : Struct.Ptr
    Reserved4 : Struct.Ptr
    ExportSecurityContext : EXPORT_SECURITY_CONTEXT_FN
    ImportSecurityContextA : IMPORT_SECURITY_CONTEXT_FN_A
    AddCredentialsA : ADD_CREDENTIALS_FN_A
    Reserved8 : Struct.Ptr
    QuerySecurityContextToken : QUERY_SECURITY_CONTEXT_TOKEN_FN
    EncryptMessage : ENCRYPT_MESSAGE_FN
    DecryptMessage : DECRYPT_MESSAGE_FN
    SetContextAttributesA : SET_CONTEXT_ATTRIBUTES_FN_A
    SetCredentialsAttributesA : SET_CREDENTIALS_ATTRIBUTES_FN_A
    ChangeAccountPasswordA : CHANGE_PASSWORD_FN_A
    QueryContextAttributesExA : QUERY_CONTEXT_ATTRIBUTES_EX_FN_A
    QueryCredentialsAttributesExA : QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A
}
struct INIT_SECURITY_INTERFACE_A extends FunctionPointer {
    static Types := [SecurityFunctionTableA.Ptr]
}
struct INIT_SECURITY_INTERFACE_W extends FunctionPointer {
    static Types := [SecurityFunctionTableW.Ptr]
}
struct SASL_AUTHZID_STATE extends Int32 {
    static Sasl_AuthZIDForbidden := 0
    static Sasl_AuthZIDProcessed := 1
}
struct SEC_WINNT_AUTH_IDENTITY_EX2 {
    Version : UInt32
    cbHeaderLength : UInt16
    cbStructureLength : UInt32
    UserOffset : UInt32
    UserLength : UInt16
    DomainOffset : UInt32
    DomainLength : UInt16
    PackedCredentialsOffset : UInt32
    PackedCredentialsLength : UInt16
    Flags : UInt32
    PackageListOffset : UInt32
    PackageListLength : UInt16
}
struct SEC_WINNT_AUTH_IDENTITY_EXW {
    Version : UInt32
    Length : UInt32
    User : UInt16.Ptr
    UserLength : UInt32
    Domain : UInt16.Ptr
    DomainLength : UInt32
    Password : UInt16.Ptr
    PasswordLength : UInt32
    Flags : UInt32
    PackageList : UInt16.Ptr
    PackageListLength : UInt32
}
struct SEC_WINNT_AUTH_IDENTITY_EXA {
    Version : UInt32
    Length : UInt32
    User : UInt8.Ptr
    UserLength : UInt32
    Domain : UInt8.Ptr
    DomainLength : UInt32
    Password : UInt8.Ptr
    PasswordLength : UInt32
    Flags : UInt32
    PackageList : UInt8.Ptr
    PackageListLength : UInt32
}
struct SEC_WINNT_AUTH_IDENTITY_INFO {
    union {
        AuthIdExw : SEC_WINNT_AUTH_IDENTITY_EXW
        AuthIdExa : SEC_WINNT_AUTH_IDENTITY_EXA
        AuthId_a : SEC_WINNT_AUTH_IDENTITY_A
        AuthId_w : SEC_WINNT_AUTH_IDENTITY_W
        AuthIdEx2 : SEC_WINNT_AUTH_IDENTITY_EX2
    }
}
struct SECURITY_PACKAGE_OPTIONS {
    Size : UInt32
    Type : SECURITY_PACKAGE_OPTIONS_TYPE
    Flags : UInt32
    SignatureSize : UInt32
    Signature : Struct.Ptr
}
struct LSA_TOKEN_INFORMATION_TYPE extends Int32 {
    static LsaTokenInformationNull := 0
    static LsaTokenInformationV1 := 1
    static LsaTokenInformationV2 := 2
    static LsaTokenInformationV3 := 3
}
struct LSA_TOKEN_INFORMATION_NULL {
    ExpirationTime : Int64
    Groups : TOKEN_GROUPS.Ptr
}
struct LSA_TOKEN_INFORMATION_V1 {
    ExpirationTime : Int64
    User : TOKEN_USER
    Groups : TOKEN_GROUPS.Ptr
    PrimaryGroup : TOKEN_PRIMARY_GROUP
    Privileges : TOKEN_PRIVILEGES.Ptr
    Owner : TOKEN_OWNER
    DefaultDacl : TOKEN_DEFAULT_DACL
}
struct LSA_TOKEN_INFORMATION_V3 {
    ExpirationTime : Int64
    User : TOKEN_USER
    Groups : TOKEN_GROUPS.Ptr
    PrimaryGroup : TOKEN_PRIMARY_GROUP
    Privileges : TOKEN_PRIVILEGES.Ptr
    Owner : TOKEN_OWNER
    DefaultDacl : TOKEN_DEFAULT_DACL
    UserClaims : TOKEN_USER_CLAIMS
    DeviceClaims : TOKEN_DEVICE_CLAIMS
    DeviceGroups : TOKEN_GROUPS.Ptr
}
struct PLSA_CREATE_LOGON_SESSION extends FunctionPointer {
    static Types := [LUID.Ptr, NTSTATUS]
}
struct PLSA_DELETE_LOGON_SESSION extends FunctionPointer {
    static Types := [LUID.Ptr, NTSTATUS]
}
struct PLSA_ADD_CREDENTIAL extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, LSA_STRING.Ptr, LSA_STRING.Ptr, NTSTATUS]
}
struct PLSA_GET_CREDENTIALS extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, UInt32.Ptr, BOOLEAN, LSA_STRING.Ptr, UInt32.Ptr, LSA_STRING.Ptr, NTSTATUS]
}
struct PLSA_DELETE_CREDENTIAL extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, LSA_STRING.Ptr, NTSTATUS]
}
struct PLSA_ALLOCATE_LSA_HEAP extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
}
struct PLSA_FREE_LSA_HEAP extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PLSA_ALLOCATE_PRIVATE_HEAP extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PLSA_FREE_PRIVATE_HEAP extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PLSA_ALLOCATE_CLIENT_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, UInt32, Struct.Ptr.Ptr, NTSTATUS]
}
struct PLSA_FREE_CLIENT_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, NTSTATUS]
}
struct PLSA_COPY_TO_CLIENT_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, UInt32, Struct.Ptr, Struct.Ptr, NTSTATUS]
}
struct PLSA_COPY_FROM_CLIENT_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, UInt32, Struct.Ptr, Struct.Ptr, NTSTATUS]
}
struct LSA_DISPATCH_TABLE {
    CreateLogonSession : PLSA_CREATE_LOGON_SESSION
    DeleteLogonSession : PLSA_DELETE_LOGON_SESSION
    AddCredential : PLSA_ADD_CREDENTIAL
    GetCredentials : PLSA_GET_CREDENTIALS
    DeleteCredential : PLSA_DELETE_CREDENTIAL
    AllocateLsaHeap : PLSA_ALLOCATE_LSA_HEAP
    FreeLsaHeap : PLSA_FREE_LSA_HEAP
    AllocateClientBuffer : PLSA_ALLOCATE_CLIENT_BUFFER
    FreeClientBuffer : PLSA_FREE_CLIENT_BUFFER
    CopyToClientBuffer : PLSA_COPY_TO_CLIENT_BUFFER
    CopyFromClientBuffer : PLSA_COPY_FROM_CLIENT_BUFFER
}
struct PLSA_AP_INITIALIZE_PACKAGE extends FunctionPointer {
    static Types := [UInt32, LSA_DISPATCH_TABLE.Ptr, LSA_STRING.Ptr, LSA_STRING.Ptr, LSA_STRING.Ptr.Ptr, NTSTATUS]
}
struct PLSA_AP_LOGON_USER extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, LUID.Ptr, Int32.Ptr, LSA_TOKEN_INFORMATION_TYPE.Ptr, Struct.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, NTSTATUS]
}
struct PLSA_AP_LOGON_USER_EX extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, LUID.Ptr, Int32.Ptr, LSA_TOKEN_INFORMATION_TYPE.Ptr, Struct.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, NTSTATUS]
}
struct PLSA_AP_CALL_PACKAGE extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_AP_CALL_PACKAGE_PASSTHROUGH extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_AP_LOGON_TERMINATED extends FunctionPointer {
    static Types := [LUID.Ptr, "Void"]
}
struct PSAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, Struct.Ptr, UInt32, UInt32, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PSAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, BOOLEAN]
}
struct PSAM_CREDENTIAL_UPDATE_FREE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct SAM_REGISTER_MAPPING_ELEMENT {
    Original : PSTR
    Mapped : PSTR
    Continuable : BOOLEAN
}
struct SAM_REGISTER_MAPPING_LIST {
    Count : UInt32
    Elements : SAM_REGISTER_MAPPING_ELEMENT.Ptr
}
struct SAM_REGISTER_MAPPING_TABLE {
    Count : UInt32
    Lists : SAM_REGISTER_MAPPING_LIST.Ptr
}
struct PSAM_CREDENTIAL_UPDATE_REGISTER_MAPPED_ENTRYPOINTS_ROUTINE extends FunctionPointer {
    static Types := [SAM_REGISTER_MAPPING_TABLE.Ptr, NTSTATUS]
}
struct SECPKG_CLIENT_INFO {
    LogonId : LUID
    ProcessID : UInt32
    ThreadID : UInt32
    HasTcbPrivilege : BOOLEAN
    Impersonating : BOOLEAN
    Restricted : BOOLEAN
    ClientFlags : UInt8
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    ClientToken : HANDLE
}
struct SECPKG_CLIENT_INFO_EX {
    LogonId : LUID
    ProcessID : UInt32
    ThreadID : UInt32
    HasTcbPrivilege : BOOLEAN
    Impersonating : BOOLEAN
    Restricted : BOOLEAN
    ClientFlags : UInt8
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    ClientToken : HANDLE
    IdentificationLogonId : LUID
    IdentificationToken : HANDLE
}
struct SECPKG_CALL_INFO {
    ProcessId : UInt32
    ThreadId : UInt32
    Attributes : UInt32
    CallCount : UInt32
    MechOid : Struct.Ptr
}
struct SECPKG_FAILURE_SPECIAL_REASON extends Int32 {
    static SecpkgFailureReason_Unknown := 0
    static SecpkgFailureReason_NoFailure := 1
    static SecpkgFailureReason_LocalAccount := 2
    static SecpkgFailureReason_DomainAccount := 3
    static SecpkgFailureReason_CloudAccount := 4
    static SecpkgFailureReason_NullTarget := 5
    static SecpkgFailureReason_UnknownTarget := 6
    static SecpkgFailureReason_IpAddress := 7
    static SecpkgFailureReason_DupTarget := 8
    static SecpkgFailureReason_NoLineOfSight := 9
    static SecpkgFailureReason_Loopback := 10
    static SecpkgFailureReason_NullSession := 11
    static SecpkgFailureReason_GlobalSPN := 12
}
struct SECPKG_FAILURE_REASON {
    Status : NTSTATUS
    Reason : SECPKG_FAILURE_SPECIAL_REASON
}
struct SECPKG_SUPPLEMENTAL_CRED {
    PackageName : LSA_UNICODE_STRING
    CredentialSize : UInt32
    Credentials : UInt8.Ptr
}
struct SECPKG_BYTE_VECTOR {
    ByteArrayOffset : UInt32
    ByteArrayLength : UInt16
}
struct SECPKG_SHORT_VECTOR {
    ShortArrayOffset : UInt32
    ShortArrayCount : UInt16
}
struct SECPKG_SUPPLIED_CREDENTIAL {
    cbHeaderLength : UInt16
    cbStructureLength : UInt16
    UserName : SECPKG_SHORT_VECTOR
    DomainName : SECPKG_SHORT_VECTOR
    PackedCredentials : SECPKG_BYTE_VECTOR
    CredFlags : UInt32
}
struct SECPKG_CREDENTIAL {
    Version : Int64
    cbHeaderLength : UInt16
    cbStructureLength : UInt32
    ClientProcess : UInt32
    ClientThread : UInt32
    LogonId : LUID
    ClientToken : HANDLE
    SessionId : UInt32
    ModifiedId : LUID
    fCredentials : UInt32
    Flags : UInt32
    PrincipalName : SECPKG_BYTE_VECTOR
    PackageList : SECPKG_BYTE_VECTOR
    MarshaledSuppliedCreds : SECPKG_BYTE_VECTOR
}
struct SECPKG_SUPPLEMENTAL_CRED_ARRAY {
    CredentialCount : UInt32
    Credentials : SECPKG_SUPPLEMENTAL_CRED[1]
}
struct SECPKG_SURROGATE_LOGON_ENTRY {
    Type : GUID
    Data : Struct.Ptr
}
struct SECPKG_SURROGATE_LOGON {
    Version : UInt32
    SurrogateLogonID : LUID
    EntryCount : UInt32
    Entries : SECPKG_SURROGATE_LOGON_ENTRY.Ptr
}
struct PLSA_CALLBACK_FUNCTION extends FunctionPointer {
    static Types := [IntPtr, IntPtr, SecBuffer.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct SECPKG_PRIMARY_CRED {
    LogonId : LUID
    DownlevelName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
    OldPassword : LSA_UNICODE_STRING
    UserSid : PSID
    Flags : UInt32
    DnsDomainName : LSA_UNICODE_STRING
    Upn : LSA_UNICODE_STRING
    LogonServer : LSA_UNICODE_STRING
    Spare1 : LSA_UNICODE_STRING
    Spare2 : LSA_UNICODE_STRING
    Spare3 : LSA_UNICODE_STRING
    Spare4 : LSA_UNICODE_STRING
}
struct SECPKG_PRIMARY_CRED_EX {
    LogonId : LUID
    DownlevelName : LSA_UNICODE_STRING
    DomainName : LSA_UNICODE_STRING
    Password : LSA_UNICODE_STRING
    OldPassword : LSA_UNICODE_STRING
    UserSid : PSID
    Flags : UInt32
    DnsDomainName : LSA_UNICODE_STRING
    Upn : LSA_UNICODE_STRING
    LogonServer : LSA_UNICODE_STRING
    Spare1 : LSA_UNICODE_STRING
    Spare2 : LSA_UNICODE_STRING
    Spare3 : LSA_UNICODE_STRING
    Spare4 : LSA_UNICODE_STRING
    PackageId : IntPtr
    PrevLogonId : LUID
    FlagsEx : UInt32
}
struct SECPKG_PARAMETERS {
    Version : UInt32
    MachineState : UInt32
    SetupMode : UInt32
    DomainSid : PSID
    DomainName : LSA_UNICODE_STRING
    DnsDomainName : LSA_UNICODE_STRING
    DomainGuid : GUID
}
struct SECPKG_EXTENDED_INFORMATION_CLASS extends Int32 {
    static SecpkgGssInfo := 1
    static SecpkgContextThunks := 2
    static SecpkgMutualAuthLevel := 3
    static SecpkgWowClientDll := 4
    static SecpkgExtraOids := 5
    static SecpkgMaxInfo := 6
    static SecpkgNego2Info := 7
}
struct SECPKG_GSS_INFO {
    EncodedIdLength : UInt32
    EncodedId : UInt8[4]
}
struct SECPKG_CONTEXT_THUNKS {
    InfoLevelCount : UInt32
    Levels : UInt32[1]
}
struct SECPKG_MUTUAL_AUTH_LEVEL {
    MutualAuthLevel : UInt32
}
struct SECPKG_WOW_CLIENT_DLL {
    WowClientDllPath : SECURITY_STRING
}
struct SECPKG_SERIALIZED_OID {
    OidLength : UInt32
    OidAttributes : UInt32
    OidValue : UInt8[32]
}
struct SECPKG_EXTRA_OIDS {
    OidCount : UInt32
    Oids : SECPKG_SERIALIZED_OID[1]
}
struct SECPKG_NEGO2_INFO {
    AuthScheme : UInt8[16]
    PackageFlags : UInt32
}
struct SECPKG_EXTENDED_INFORMATION {
    Class : SECPKG_EXTENDED_INFORMATION_CLASS
    Info : this._Info_e__Union
    struct _Info_e__Union {
        union {
            GssInfo : SECPKG_GSS_INFO
            ContextThunks : SECPKG_CONTEXT_THUNKS
            MutualAuthLevel : SECPKG_MUTUAL_AUTH_LEVEL
            WowClientDll : SECPKG_WOW_CLIENT_DLL
            ExtraOids : SECPKG_EXTRA_OIDS
            Nego2Info : SECPKG_NEGO2_INFO
        }
    }
}
struct SECPKG_TARGETINFO {
    DomainSid : PSID
    ComputerName : PWSTR
}
struct SECPKG_NTLM_TARGETINFO {
    Flags : UInt32
    MsvAvNbComputerName : PWSTR
    MsvAvNbDomainName : PWSTR
    MsvAvDnsComputerName : PWSTR
    MsvAvDnsDomainName : PWSTR
    MsvAvDnsTreeName : PWSTR
    MsvAvFlags : UInt32
    MsvAvTimestamp : FILETIME
    MsvAvTargetName : PWSTR
}
struct SecPkgContext_SaslContext {
    SaslContext : Struct.Ptr
}
struct SECURITY_USER_DATA {
    UserName : SECURITY_STRING
    LogonDomainName : SECURITY_STRING
    LogonServer : SECURITY_STRING
    pSid : PSID
}
struct SECPKG_CALL_PACKAGE_MESSAGE_TYPE extends Int32 {
    static SecPkgCallPackageMinMessage := 1024
    static SecPkgCallPackagePinDcMessage := 1024
    static SecPkgCallPackageUnpinAllDcsMessage := 1025
    static SecPkgCallPackageTransferCredMessage := 1026
    static SecPkgCallPackageMaxMessage := 1026
}
struct SECPKG_CALL_PACKAGE_PIN_DC_REQUEST {
    MessageType : UInt32
    Flags : UInt32
    DomainName : LSA_UNICODE_STRING
    DcName : LSA_UNICODE_STRING
    DcFlags : UInt32
}
struct SECPKG_CALL_PACKAGE_UNPIN_ALL_DCS_REQUEST {
    MessageType : UInt32
    Flags : UInt32
}
struct SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST {
    MessageType : UInt32
    OriginLogonId : LUID
    DestinationLogonId : LUID
    Flags : UInt32
}
struct PLSA_REDIRECTED_LOGON_INIT extends FunctionPointer {
    static Types := [HANDLE, LSA_UNICODE_STRING.Ptr, UInt32, LUID.Ptr, NTSTATUS]
}
struct PLSA_REDIRECTED_LOGON_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, "Void"]
}
struct PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS extends FunctionPointer {
    static Types := [HANDLE, SECPKG_SUPPLEMENTAL_CRED_ARRAY.Ptr.Ptr, NTSTATUS]
}
struct PLSA_REDIRECTED_LOGON_GET_SID extends FunctionPointer {
    static Types := [HANDLE, PSID.Ptr, NTSTATUS]
}
struct SECPKG_REDIRECTED_LOGON_BUFFER {
    RedirectedLogonGuid : GUID
    RedirectedLogonHandle : HANDLE
    Init : PLSA_REDIRECTED_LOGON_INIT
    Callback : PLSA_REDIRECTED_LOGON_CALLBACK
    CleanupCallback : PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK
    GetLogonCreds : PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS
    GetSupplementalCreds : PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS
    GetRedirectedLogonSid : PLSA_REDIRECTED_LOGON_GET_SID
}
struct SECPKG_POST_LOGON_USER_INFO {
    Flags : UInt32
    LogonId : LUID
    LinkedLogonId : LUID
}
struct PLSA_IMPERSONATE_CLIENT extends FunctionPointer {
    static Types := [NTSTATUS]
}
struct PLSA_UNLOAD_PACKAGE extends FunctionPointer {
    static Types := [NTSTATUS]
}
struct PLSA_DUPLICATE_HANDLE extends FunctionPointer {
    static Types := [HANDLE, HANDLE.Ptr, NTSTATUS]
}
struct PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, Struct.Ptr, BOOLEAN, NTSTATUS]
}
struct PLSA_CREATE_THREAD extends FunctionPointer {
    static Types := [SECURITY_ATTRIBUTES.Ptr, UInt32, LPTHREAD_START_ROUTINE, Struct.Ptr, UInt32, UInt32.Ptr, HANDLE]
}
struct PLSA_GET_CLIENT_INFO extends FunctionPointer {
    static Types := [SECPKG_CLIENT_INFO.Ptr, NTSTATUS]
}
struct PLSA_GET_CLIENT_INFO_EX extends FunctionPointer {
    static Types := [SECPKG_CLIENT_INFO_EX.Ptr, UInt32, NTSTATUS]
}
struct PLSA_REGISTER_NOTIFICATION extends FunctionPointer {
    static Types := [LPTHREAD_START_ROUTINE, Struct.Ptr, UInt32, UInt32, UInt32, UInt32, HANDLE, HANDLE]
}
struct PLSA_CANCEL_NOTIFICATION extends FunctionPointer {
    static Types := [HANDLE, NTSTATUS]
}
struct PLSA_MAP_BUFFER extends FunctionPointer {
    static Types := [SecBuffer.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct PLSA_CREATE_TOKEN extends FunctionPointer {
    static Types := [LUID.Ptr, TOKEN_SOURCE.Ptr, SECURITY_LOGON_TYPE, SECURITY_IMPERSONATION_LEVEL, LSA_TOKEN_INFORMATION_TYPE, Struct.Ptr, TOKEN_GROUPS.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, HANDLE.Ptr, Int32.Ptr, NTSTATUS]
}
struct SECPKG_SESSIONINFO_TYPE extends Int32 {
    static SecSessionPrimaryCred := 0
}
struct PLSA_CREATE_TOKEN_EX extends FunctionPointer {
    static Types := [LUID.Ptr, TOKEN_SOURCE.Ptr, SECURITY_LOGON_TYPE, SECURITY_IMPERSONATION_LEVEL, LSA_TOKEN_INFORMATION_TYPE, Struct.Ptr, TOKEN_GROUPS.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, Struct.Ptr, SECPKG_SESSIONINFO_TYPE, HANDLE.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_AUDIT_LOGON extends FunctionPointer {
    static Types := [NTSTATUS, NTSTATUS, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, PSID, SECURITY_LOGON_TYPE, TOKEN_SOURCE.Ptr, LUID.Ptr, "Void"]
}
struct PLSA_CALL_PACKAGE extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_CALL_PACKAGEEX extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_CALL_PACKAGE_PASSTHROUGH extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_GET_CALL_INFO extends FunctionPointer {
    static Types := [SECPKG_CALL_INFO.Ptr, BOOLEAN]
}
struct PLSA_CREATE_SHARED_MEMORY extends FunctionPointer {
    static Types := [UInt32, UInt32, Struct.Ptr]
}
struct PLSA_ALLOCATE_SHARED_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr]
}
struct PLSA_FREE_SHARED_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct PLSA_DELETE_SHARED_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, BOOLEAN]
}
struct PLSA_GET_APP_MODE_INFO extends FunctionPointer {
    static Types := [UInt32.Ptr, IntPtr.Ptr, IntPtr.Ptr, SecBuffer.Ptr, BOOLEAN.Ptr, NTSTATUS]
}
struct PLSA_SET_APP_MODE_INFO extends FunctionPointer {
    static Types := [UInt32, IntPtr, IntPtr, SecBuffer.Ptr, BOOLEAN, NTSTATUS]
}
struct PLSA_GET_SECPKG_FAILURE_REASON extends FunctionPointer {
    static Types := [IntPtr, SECPKG_FAILURE_REASON.Ptr, NTSTATUS]
}
struct PLSA_SET_SECPKG_FAILURE_REASON extends FunctionPointer {
    static Types := [SECPKG_FAILURE_REASON, NTSTATUS]
}
struct SECPKG_NAME_TYPE extends Int32 {
    static SecNameSamCompatible := 0
    static SecNameAlternateId := 1
    static SecNameFlat := 2
    static SecNameDN := 3
    static SecNameSPN := 4
}
struct PLSA_OPEN_SAM_USER extends FunctionPointer {
    static Types := [SECURITY_STRING.Ptr, SECPKG_NAME_TYPE, SECURITY_STRING.Ptr, BOOLEAN, UInt32, Struct.Ptr.Ptr, NTSTATUS]
}
struct PLSA_GET_USER_CREDENTIALS extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PLSA_GET_USER_AUTH_DATA extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PLSA_CLOSE_SAM_USER extends FunctionPointer {
    static Types := [Struct.Ptr, NTSTATUS]
}
struct PLSA_GET_AUTH_DATA_FOR_USER extends FunctionPointer {
    static Types := [SECURITY_STRING.Ptr, SECPKG_NAME_TYPE, SECURITY_STRING.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, LSA_UNICODE_STRING.Ptr, NTSTATUS]
}
struct PLSA_CONVERT_AUTH_DATA_TO_TOKEN extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, SECURITY_IMPERSONATION_LEVEL, TOKEN_SOURCE.Ptr, SECURITY_LOGON_TYPE, LSA_UNICODE_STRING.Ptr, HANDLE.Ptr, LUID.Ptr, LSA_UNICODE_STRING.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_CRACK_SINGLE_NAME extends FunctionPointer {
    static Types := [UInt32, BOOLEAN, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, UInt32, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, UInt32.Ptr, NTSTATUS]
}
struct PLSA_AUDIT_ACCOUNT_LOGON extends FunctionPointer {
    static Types := [UInt32, BOOLEAN, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, NTSTATUS, NTSTATUS]
}
struct PLSA_CLIENT_CALLBACK extends FunctionPointer {
    static Types := [PSTR, IntPtr, IntPtr, SecBuffer.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct PLSA_REGISTER_CALLBACK extends FunctionPointer {
    static Types := [UInt32, PLSA_CALLBACK_FUNCTION, NTSTATUS]
}
struct PLSA_GET_EXTENDED_CALL_FLAGS extends FunctionPointer {
    static Types := [UInt32.Ptr, NTSTATUS]
}
struct SECPKG_EVENT_PACKAGE_CHANGE {
    ChangeType : SECPKG_PACKAGE_CHANGE_TYPE
    PackageId : IntPtr
    PackageName : SECURITY_STRING
}
struct SECPKG_EVENT_ROLE_CHANGE {
    PreviousRole : UInt32
    NewRole : UInt32
}
struct SECPKG_EVENT_NOTIFY {
    EventClass : UInt32
    Reserved : UInt32
    EventDataSize : UInt32
    EventData : Struct.Ptr
    PackageParameter : Struct.Ptr
}
struct PLSA_UPDATE_PRIMARY_CREDENTIALS extends FunctionPointer {
    static Types := [SECPKG_PRIMARY_CRED.Ptr, SECPKG_SUPPLEMENTAL_CRED_ARRAY.Ptr, NTSTATUS]
}
struct PLSA_PROTECT_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, "Void"]
}
struct PLSA_OPEN_TOKEN_BY_LOGON_ID extends FunctionPointer {
    static Types := [LUID.Ptr, HANDLE.Ptr, NTSTATUS]
}
struct PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, Struct.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct CRED_FETCH extends Int32 {
    static CredFetchDefault := 0
    static CredFetchDPAPI := 1
    static CredFetchForced := 2
}
struct PLSA_GET_SERVICE_ACCOUNT_PASSWORD extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, CRED_FETCH, FILETIME.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, FILETIME.Ptr, NTSTATUS]
}
struct PLSA_AUDIT_LOGON_EX extends FunctionPointer {
    static Types := [NTSTATUS, NTSTATUS, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, PSID, SECURITY_LOGON_TYPE, SECURITY_IMPERSONATION_LEVEL, TOKEN_SOURCE.Ptr, LUID.Ptr, "Void"]
}
struct PLSA_CHECK_PROTECTED_USER_BY_TOKEN extends FunctionPointer {
    static Types := [HANDLE, BOOLEAN.Ptr, NTSTATUS]
}
struct PLSA_QUERY_CLIENT_REQUEST extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, UInt32, Struct.Ptr.Ptr, NTSTATUS]
}
struct ENCRYPTED_CREDENTIALW {
    Cred : CREDENTIALW
    ClearCredentialBlobSize : UInt32
}
struct CredReadFn extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, PWSTR, UInt32, UInt32, ENCRYPTED_CREDENTIALW.Ptr.Ptr, NTSTATUS]
}
struct CredReadDomainCredentialsFn extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, CREDENTIAL_TARGET_INFORMATIONW.Ptr, UInt32, UInt32.Ptr, ENCRYPTED_CREDENTIALW.Ptr.Ptr.Ptr, NTSTATUS]
}
struct CredFreeCredentialsFn extends FunctionPointer {
    static Types := [UInt32, ENCRYPTED_CREDENTIALW.Ptr.Ptr, "Void"]
}
struct CredWriteFn extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, ENCRYPTED_CREDENTIALW.Ptr, UInt32, NTSTATUS]
}
struct CrediUnmarshalandDecodeStringFn extends FunctionPointer {
    static Types := [PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt8.Ptr, NTSTATUS]
}
struct SEC_WINNT_AUTH_IDENTITY32 {
    User : UInt32
    UserLength : UInt32
    Domain : UInt32
    DomainLength : UInt32
    Password : UInt32
    PasswordLength : UInt32
    Flags : UInt32
}
struct SEC_WINNT_AUTH_IDENTITY_EX32 {
    Version : UInt32
    Length : UInt32
    User : UInt32
    UserLength : UInt32
    Domain : UInt32
    DomainLength : UInt32
    Password : UInt32
    PasswordLength : UInt32
    Flags : UInt32
    PackageList : UInt32
    PackageListLength : UInt32
}
struct LSA_SECPKG_FUNCTION_TABLE {
    CreateLogonSession : PLSA_CREATE_LOGON_SESSION
    DeleteLogonSession : PLSA_DELETE_LOGON_SESSION
    AddCredential : PLSA_ADD_CREDENTIAL
    GetCredentials : PLSA_GET_CREDENTIALS
    DeleteCredential : PLSA_DELETE_CREDENTIAL
    AllocateLsaHeap : PLSA_ALLOCATE_LSA_HEAP
    FreeLsaHeap : PLSA_FREE_LSA_HEAP
    AllocateClientBuffer : PLSA_ALLOCATE_CLIENT_BUFFER
    FreeClientBuffer : PLSA_FREE_CLIENT_BUFFER
    CopyToClientBuffer : PLSA_COPY_TO_CLIENT_BUFFER
    CopyFromClientBuffer : PLSA_COPY_FROM_CLIENT_BUFFER
    ImpersonateClient : PLSA_IMPERSONATE_CLIENT
    UnloadPackage : PLSA_UNLOAD_PACKAGE
    DuplicateHandle : PLSA_DUPLICATE_HANDLE
    SaveSupplementalCredentials : PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS
    CreateThread : PLSA_CREATE_THREAD
    GetClientInfo : PLSA_GET_CLIENT_INFO
    RegisterNotification : PLSA_REGISTER_NOTIFICATION
    CancelNotification : PLSA_CANCEL_NOTIFICATION
    MapBuffer : PLSA_MAP_BUFFER
    CreateToken : PLSA_CREATE_TOKEN
    AuditLogon : PLSA_AUDIT_LOGON
    CallPackage : PLSA_CALL_PACKAGE
    FreeReturnBuffer : PLSA_FREE_LSA_HEAP
    GetCallInfo : PLSA_GET_CALL_INFO
    CallPackageEx : PLSA_CALL_PACKAGEEX
    CreateSharedMemory : PLSA_CREATE_SHARED_MEMORY
    AllocateSharedMemory : PLSA_ALLOCATE_SHARED_MEMORY
    FreeSharedMemory : PLSA_FREE_SHARED_MEMORY
    DeleteSharedMemory : PLSA_DELETE_SHARED_MEMORY
    OpenSamUser : PLSA_OPEN_SAM_USER
    GetUserCredentials : PLSA_GET_USER_CREDENTIALS
    GetUserAuthData : PLSA_GET_USER_AUTH_DATA
    CloseSamUser : PLSA_CLOSE_SAM_USER
    ConvertAuthDataToToken : PLSA_CONVERT_AUTH_DATA_TO_TOKEN
    ClientCallback : PLSA_CLIENT_CALLBACK
    UpdateCredentials : PLSA_UPDATE_PRIMARY_CREDENTIALS
    GetAuthDataForUser : PLSA_GET_AUTH_DATA_FOR_USER
    CrackSingleName : PLSA_CRACK_SINGLE_NAME
    AuditAccountLogon : PLSA_AUDIT_ACCOUNT_LOGON
    CallPackagePassthrough : PLSA_CALL_PACKAGE_PASSTHROUGH
    CrediRead : CredReadFn
    CrediReadDomainCredentials : CredReadDomainCredentialsFn
    CrediFreeCredentials : CredFreeCredentialsFn
    LsaProtectMemory : PLSA_PROTECT_MEMORY
    LsaUnprotectMemory : PLSA_PROTECT_MEMORY
    OpenTokenByLogonId : PLSA_OPEN_TOKEN_BY_LOGON_ID
    ExpandAuthDataForDomain : PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN
    AllocatePrivateHeap : PLSA_ALLOCATE_PRIVATE_HEAP
    FreePrivateHeap : PLSA_FREE_PRIVATE_HEAP
    CreateTokenEx : PLSA_CREATE_TOKEN_EX
    CrediWrite : CredWriteFn
    CrediUnmarshalandDecodeString : CrediUnmarshalandDecodeStringFn
    DummyFunction6 : PLSA_PROTECT_MEMORY
    GetExtendedCallFlags : PLSA_GET_EXTENDED_CALL_FLAGS
    DuplicateTokenHandle : PLSA_DUPLICATE_HANDLE
    GetServiceAccountPassword : PLSA_GET_SERVICE_ACCOUNT_PASSWORD
    DummyFunction7 : PLSA_PROTECT_MEMORY
    AuditLogonEx : PLSA_AUDIT_LOGON_EX
    CheckProtectedUserByToken : PLSA_CHECK_PROTECTED_USER_BY_TOKEN
    QueryClientRequest : PLSA_QUERY_CLIENT_REQUEST
    GetAppModeInfo : PLSA_GET_APP_MODE_INFO
    SetAppModeInfo : PLSA_SET_APP_MODE_INFO
    GetClientInfoEx : PLSA_GET_CLIENT_INFO_EX
    GetSecpkgFailureReason : PLSA_GET_SECPKG_FAILURE_REASON
    SetSecpkgFailureReason : PLSA_SET_SECPKG_FAILURE_REASON
}
struct PLSA_LOCATE_PKG_BY_ID extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
}
struct SECPKG_DLL_FUNCTIONS {
    AllocateHeap : PLSA_ALLOCATE_LSA_HEAP
    FreeHeap : PLSA_FREE_LSA_HEAP
    RegisterCallback : PLSA_REGISTER_CALLBACK
    LocatePackageById : PLSA_LOCATE_PKG_BY_ID
}
struct SpInitializeFn extends FunctionPointer {
    static Types := [IntPtr, SECPKG_PARAMETERS.Ptr, LSA_SECPKG_FUNCTION_TABLE.Ptr, NTSTATUS]
}
struct SpShutdownFn extends FunctionPointer {
    static Types := [NTSTATUS]
}
struct SpGetInfoFn extends FunctionPointer {
    static Types := [SecPkgInfoA.Ptr, NTSTATUS]
}
struct SpGetExtendedInformationFn extends FunctionPointer {
    static Types := [SECPKG_EXTENDED_INFORMATION_CLASS, SECPKG_EXTENDED_INFORMATION.Ptr.Ptr, NTSTATUS]
}
struct SpSetExtendedInformationFn extends FunctionPointer {
    static Types := [SECPKG_EXTENDED_INFORMATION_CLASS, SECPKG_EXTENDED_INFORMATION.Ptr, NTSTATUS]
}
struct PLSA_AP_LOGON_USER_EX2 extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, LUID.Ptr, Int32.Ptr, LSA_TOKEN_INFORMATION_TYPE.Ptr, Struct.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, SECPKG_PRIMARY_CRED.Ptr, SECPKG_SUPPLEMENTAL_CRED_ARRAY.Ptr.Ptr, NTSTATUS]
}
struct PLSA_AP_LOGON_USER_EX3 extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, SECPKG_SURROGATE_LOGON.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, LUID.Ptr, Int32.Ptr, LSA_TOKEN_INFORMATION_TYPE.Ptr, Struct.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, LSA_UNICODE_STRING.Ptr.Ptr, SECPKG_PRIMARY_CRED.Ptr, SECPKG_SUPPLEMENTAL_CRED_ARRAY.Ptr.Ptr, NTSTATUS]
}
struct PLSA_AP_PRE_LOGON_USER_SURROGATE extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, SECPKG_SURROGATE_LOGON.Ptr, Int32.Ptr, NTSTATUS]
}
struct PLSA_AP_POST_LOGON_USER_SURROGATE extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, SECURITY_LOGON_TYPE, Struct.Ptr, Struct.Ptr, UInt32, SECPKG_SURROGATE_LOGON.Ptr, Struct.Ptr, UInt32, LUID.Ptr, NTSTATUS, NTSTATUS, LSA_TOKEN_INFORMATION_TYPE, Struct.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, SECPKG_PRIMARY_CRED.Ptr, SECPKG_SUPPLEMENTAL_CRED_ARRAY.Ptr, NTSTATUS]
}
struct SpAcceptCredentialsFn extends FunctionPointer {
    static Types := [SECURITY_LOGON_TYPE, LSA_UNICODE_STRING.Ptr, SECPKG_PRIMARY_CRED.Ptr, SECPKG_SUPPLEMENTAL_CRED.Ptr, NTSTATUS]
}
struct SpAcquireCredentialsHandleFn extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, UInt32, LUID.Ptr, Struct.Ptr, Struct.Ptr, Struct.Ptr, IntPtr.Ptr, Int64.Ptr, NTSTATUS]
}
struct SpFreeCredentialsHandleFn extends FunctionPointer {
    static Types := [IntPtr, NTSTATUS]
}
struct SpQueryCredentialsAttributesFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, NTSTATUS]
}
struct SpSetCredentialsAttributesFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, UInt32, NTSTATUS]
}
struct SpAddCredentialsFn extends FunctionPointer {
    static Types := [IntPtr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, UInt32, Struct.Ptr, Struct.Ptr, Struct.Ptr, Int64.Ptr, NTSTATUS]
}
struct SpSaveCredentialsFn extends FunctionPointer {
    static Types := [IntPtr, SecBuffer.Ptr, NTSTATUS]
}
struct SpGetCredentialsFn extends FunctionPointer {
    static Types := [IntPtr, SecBuffer.Ptr, NTSTATUS]
}
struct SpDeleteCredentialsFn extends FunctionPointer {
    static Types := [IntPtr, SecBuffer.Ptr, NTSTATUS]
}
struct SpInitLsaModeContextFn extends FunctionPointer {
    static Types := [IntPtr, IntPtr, LSA_UNICODE_STRING.Ptr, UInt32, UInt32, SecBufferDesc.Ptr, IntPtr.Ptr, SecBufferDesc.Ptr, UInt32.Ptr, Int64.Ptr, BOOLEAN.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct SpDeleteContextFn extends FunctionPointer {
    static Types := [IntPtr, NTSTATUS]
}
struct SpApplyControlTokenFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, NTSTATUS]
}
struct SpAcceptLsaModeContextFn extends FunctionPointer {
    static Types := [IntPtr, IntPtr, SecBufferDesc.Ptr, UInt32, UInt32, IntPtr.Ptr, SecBufferDesc.Ptr, UInt32.Ptr, Int64.Ptr, BOOLEAN.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct SpGetUserInfoFn extends FunctionPointer {
    static Types := [LUID.Ptr, UInt32, SECURITY_USER_DATA.Ptr.Ptr, NTSTATUS]
}
struct SpQueryContextAttributesFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, NTSTATUS]
}
struct SpSetContextAttributesFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, UInt32, NTSTATUS]
}
struct SpChangeAccountPasswordFn extends FunctionPointer {
    static Types := [LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, LSA_UNICODE_STRING.Ptr, BOOLEAN, SecBufferDesc.Ptr, NTSTATUS]
}
struct SpQueryMetaDataFn extends FunctionPointer {
    static Types := [IntPtr, LSA_UNICODE_STRING.Ptr, UInt32, UInt32.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, NTSTATUS]
}
struct SpExchangeMetaDataFn extends FunctionPointer {
    static Types := [IntPtr, LSA_UNICODE_STRING.Ptr, UInt32, UInt32, UInt8.Ptr, IntPtr.Ptr, NTSTATUS]
}
struct SpGetCredUIContextFn extends FunctionPointer {
    static Types := [IntPtr, GUID.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, NTSTATUS]
}
struct SpUpdateCredentialsFn extends FunctionPointer {
    static Types := [IntPtr, GUID.Ptr, UInt32, UInt8.Ptr, NTSTATUS]
}
struct SpValidateTargetInfoFn extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, Struct.Ptr, UInt32, SECPKG_TARGETINFO.Ptr, NTSTATUS]
}
struct SpExtractTargetInfoFn extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct LSA_AP_POST_LOGON_USER extends FunctionPointer {
    static Types := [SECPKG_POST_LOGON_USER_INFO.Ptr, NTSTATUS]
}
struct SpGetRemoteCredGuardLogonBufferFn extends FunctionPointer {
    static Types := [IntPtr, IntPtr, LSA_UNICODE_STRING.Ptr, HANDLE.Ptr, PLSA_REDIRECTED_LOGON_CALLBACK.Ptr, PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SpGetRemoteCredGuardSupplementalCredsFn extends FunctionPointer {
    static Types := [IntPtr, LSA_UNICODE_STRING.Ptr, HANDLE.Ptr, PLSA_REDIRECTED_LOGON_CALLBACK.Ptr, PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SpGetTbalSupplementalCredsFn extends FunctionPointer {
    static Types := [LUID, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SECPKG_FUNCTION_TABLE {
    InitializePackage : PLSA_AP_INITIALIZE_PACKAGE
    LogonUserA : PLSA_AP_LOGON_USER
    CallPackage : PLSA_AP_CALL_PACKAGE
    LogonTerminated : PLSA_AP_LOGON_TERMINATED
    CallPackageUntrusted : PLSA_AP_CALL_PACKAGE
    CallPackagePassthrough : PLSA_AP_CALL_PACKAGE_PASSTHROUGH
    LogonUserExA : PLSA_AP_LOGON_USER_EX
    LogonUserEx2 : PLSA_AP_LOGON_USER_EX2
    Initialize : SpInitializeFn
    Shutdown : SpShutdownFn
    GetInfo : SpGetInfoFn
    AcceptCredentials : SpAcceptCredentialsFn
    AcquireCredentialsHandleA : SpAcquireCredentialsHandleFn
    QueryCredentialsAttributesA : SpQueryCredentialsAttributesFn
    FreeCredentialsHandle : SpFreeCredentialsHandleFn
    SaveCredentials : SpSaveCredentialsFn
    GetCredentials : SpGetCredentialsFn
    DeleteCredentials : SpDeleteCredentialsFn
    InitLsaModeContext : SpInitLsaModeContextFn
    AcceptLsaModeContext : SpAcceptLsaModeContextFn
    DeleteContext : SpDeleteContextFn
    ApplyControlToken : SpApplyControlTokenFn
    GetUserInfo : SpGetUserInfoFn
    GetExtendedInformation : SpGetExtendedInformationFn
    QueryContextAttributesA : SpQueryContextAttributesFn
    AddCredentialsA : SpAddCredentialsFn
    SetExtendedInformation : SpSetExtendedInformationFn
    SetContextAttributesA : SpSetContextAttributesFn
    SetCredentialsAttributesA : SpSetCredentialsAttributesFn
    ChangeAccountPasswordA : SpChangeAccountPasswordFn
    QueryMetaData : SpQueryMetaDataFn
    ExchangeMetaData : SpExchangeMetaDataFn
    GetCredUIContext : SpGetCredUIContextFn
    UpdateCredentials : SpUpdateCredentialsFn
    ValidateTargetInfo : SpValidateTargetInfoFn
    PostLogonUser : LSA_AP_POST_LOGON_USER
    GetRemoteCredGuardLogonBuffer : SpGetRemoteCredGuardLogonBufferFn
    GetRemoteCredGuardSupplementalCreds : SpGetRemoteCredGuardSupplementalCredsFn
    GetTbalSupplementalCreds : SpGetTbalSupplementalCredsFn
    LogonUserEx3 : PLSA_AP_LOGON_USER_EX3
    PreLogonUserSurrogate : PLSA_AP_PRE_LOGON_USER_SURROGATE
    PostLogonUserSurrogate : PLSA_AP_POST_LOGON_USER_SURROGATE
    ExtractTargetInfo : SpExtractTargetInfoFn
}
struct SpInstanceInitFn extends FunctionPointer {
    static Types := [UInt32, SECPKG_DLL_FUNCTIONS.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SpInitUserModeContextFn extends FunctionPointer {
    static Types := [IntPtr, SecBuffer.Ptr, NTSTATUS]
}
struct SpMakeSignatureFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, SecBufferDesc.Ptr, UInt32, NTSTATUS]
}
struct SpVerifySignatureFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, NTSTATUS]
}
struct SpSealMessageFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, SecBufferDesc.Ptr, UInt32, NTSTATUS]
}
struct SpUnsealMessageFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, NTSTATUS]
}
struct SpGetContextTokenFn extends FunctionPointer {
    static Types := [IntPtr, HANDLE.Ptr, NTSTATUS]
}
struct SpExportSecurityContextFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, SecBuffer.Ptr, HANDLE.Ptr, NTSTATUS]
}
struct SpImportSecurityContextFn extends FunctionPointer {
    static Types := [SecBuffer.Ptr, HANDLE, IntPtr.Ptr, NTSTATUS]
}
struct SpCompleteAuthTokenFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, NTSTATUS]
}
struct SpFormatCredentialsFn extends FunctionPointer {
    static Types := [SecBuffer.Ptr, SecBuffer.Ptr, NTSTATUS]
}
struct SpMarshallSupplementalCredsFn extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SpMarshalAttributeDataFn extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt8.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, NTSTATUS]
}
struct SECPKG_USER_FUNCTION_TABLE {
    InstanceInit : SpInstanceInitFn
    InitUserModeContext : SpInitUserModeContextFn
    MakeSignature : SpMakeSignatureFn
    VerifySignature : SpVerifySignatureFn
    SealMessage : SpSealMessageFn
    UnsealMessage : SpUnsealMessageFn
    GetContextToken : SpGetContextTokenFn
    QueryContextAttributesA : SpQueryContextAttributesFn
    CompleteAuthToken : SpCompleteAuthTokenFn
    DeleteUserModeContext : SpDeleteContextFn
    FormatCredentials : SpFormatCredentialsFn
    MarshallSupplementalCreds : SpMarshallSupplementalCredsFn
    ExportContext : SpExportSecurityContextFn
    ImportContext : SpImportSecurityContextFn
    MarshalAttributeData : SpMarshalAttributeDataFn
}
struct SpLsaModeInitializeFn extends FunctionPointer {
    static Types := [UInt32, UInt32.Ptr, SECPKG_FUNCTION_TABLE.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct SpUserModeInitializeFn extends FunctionPointer {
    static Types := [UInt32, UInt32.Ptr, SECPKG_USER_FUNCTION_TABLE.Ptr.Ptr, UInt32.Ptr, NTSTATUS]
}
struct KSEC_CONTEXT_TYPE extends Int32 {
    static KSecPaged := 0
    static KSecNonPaged := 1
}
struct KSEC_LIST_ENTRY {
    List : LIST_ENTRY
    RefCount : Int32
    Signature : UInt32
    OwningList : Struct.Ptr
    Reserved : Struct.Ptr
}
struct PKSEC_CREATE_CONTEXT_LIST extends FunctionPointer {
    static Types := [KSEC_CONTEXT_TYPE, Struct.Ptr]
}
struct PKSEC_INSERT_LIST_ENTRY extends FunctionPointer {
    static Types := [Struct.Ptr, KSEC_LIST_ENTRY.Ptr, "Void"]
}
struct PKSEC_REFERENCE_LIST_ENTRY extends FunctionPointer {
    static Types := [KSEC_LIST_ENTRY.Ptr, UInt32, BOOLEAN, NTSTATUS]
}
struct PKSEC_DEREFERENCE_LIST_ENTRY extends FunctionPointer {
    static Types := [KSEC_LIST_ENTRY.Ptr, UInt8.Ptr, "Void"]
}
struct PKSEC_SERIALIZE_WINNT_AUTH_DATA extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct PKSEC_LOCATE_PKG_BY_ID extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
}
struct SECPKG_KERNEL_FUNCTIONS {
    AllocateHeap : PLSA_ALLOCATE_LSA_HEAP
    FreeHeap : PLSA_FREE_LSA_HEAP
    CreateContextList : PKSEC_CREATE_CONTEXT_LIST
    InsertListEntry : PKSEC_INSERT_LIST_ENTRY
    ReferenceListEntry : PKSEC_REFERENCE_LIST_ENTRY
    DereferenceListEntry : PKSEC_DEREFERENCE_LIST_ENTRY
    SerializeWinntAuthData : PKSEC_SERIALIZE_WINNT_AUTH_DATA
    SerializeSchannelAuthData : PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA
    LocatePackageById : PKSEC_LOCATE_PKG_BY_ID
}
struct KspInitPackageFn extends FunctionPointer {
    static Types := [SECPKG_KERNEL_FUNCTIONS.Ptr, NTSTATUS]
}
struct KspDeleteContextFn extends FunctionPointer {
    static Types := [IntPtr, IntPtr.Ptr, NTSTATUS]
}
struct KspInitContextFn extends FunctionPointer {
    static Types := [IntPtr, SecBuffer.Ptr, IntPtr.Ptr, NTSTATUS]
}
struct KspMakeSignatureFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, SecBufferDesc.Ptr, UInt32, NTSTATUS]
}
struct KspVerifySignatureFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, NTSTATUS]
}
struct KspSealMessageFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, SecBufferDesc.Ptr, UInt32, NTSTATUS]
}
struct KspUnsealMessageFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, UInt32, UInt32.Ptr, NTSTATUS]
}
struct KspGetTokenFn extends FunctionPointer {
    static Types := [IntPtr, HANDLE.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct KspQueryAttributesFn extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, NTSTATUS]
}
struct KspCompleteTokenFn extends FunctionPointer {
    static Types := [IntPtr, SecBufferDesc.Ptr, NTSTATUS]
}
struct KspMapHandleFn extends FunctionPointer {
    static Types := [IntPtr, IntPtr.Ptr, NTSTATUS]
}
struct KspSetPagingModeFn extends FunctionPointer {
    static Types := [BOOLEAN, NTSTATUS]
}
struct KspSerializeAuthDataFn extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, NTSTATUS]
}
struct SECPKG_KERNEL_FUNCTION_TABLE {
    Initialize : KspInitPackageFn
    DeleteContext : KspDeleteContextFn
    InitContext : KspInitContextFn
    MapHandle : KspMapHandleFn
    Sign : KspMakeSignatureFn
    Verify : KspVerifySignatureFn
    Seal : KspSealMessageFn
    Unseal : KspUnsealMessageFn
    GetToken : KspGetTokenFn
    QueryAttributes : KspQueryAttributesFn
    CompleteToken : KspCompleteTokenFn
    ExportContext : SpExportSecurityContextFn
    ImportContext : SpImportSecurityContextFn
    SetPackagePagingMode : KspSetPagingModeFn
    SerializeAuthData : KspSerializeAuthDataFn
}
struct SecPkgCred_SupportedAlgs {
    cSupportedAlgs : UInt32
    palgSupportedAlgs : ALG_ID.Ptr
}
struct SecPkgCred_CipherStrengths {
    dwMinimumCipherStrength : UInt32
    dwMaximumCipherStrength : UInt32
}
struct SecPkgCred_SupportedProtocols {
    grbitProtocol : UInt32
}
struct SecPkgCred_ClientCertPolicy {
    dwFlags : UInt32
    guidPolicyId : GUID
    dwCertFlags : UInt32
    dwUrlRetrievalTimeout : UInt32
    fCheckRevocationFreshnessTime : BOOL
    dwRevocationFreshnessTime : UInt32
    fOmitUsageCheck : BOOL
    pwszSslCtlStoreName : PWSTR
    pwszSslCtlIdentifier : PWSTR
}
struct SecPkgCred_SessionTicketKey {
    TicketInfoVersion : UInt32
    KeyId : UInt8[16]
    KeyingMaterial : UInt8[64]
    KeyingMaterialSize : UInt8
}
struct SecPkgCred_SessionTicketKeys {
    cSessionTicketKeys : UInt32
    pSessionTicketKeys : SecPkgCred_SessionTicketKey.Ptr
}
struct eTlsSignatureAlgorithm extends Int32 {
    static TlsSignatureAlgorithm_Anonymous := 0
    static TlsSignatureAlgorithm_Rsa := 1
    static TlsSignatureAlgorithm_Dsa := 2
    static TlsSignatureAlgorithm_Ecdsa := 3
}
struct eTlsHashAlgorithm extends Int32 {
    static TlsHashAlgorithm_None := 0
    static TlsHashAlgorithm_Md5 := 1
    static TlsHashAlgorithm_Sha1 := 2
    static TlsHashAlgorithm_Sha224 := 3
    static TlsHashAlgorithm_Sha256 := 4
    static TlsHashAlgorithm_Sha384 := 5
    static TlsHashAlgorithm_Sha512 := 6
}
struct SecPkgContext_RemoteCredentialInfo {
    cbCertificateChain : UInt32
    pbCertificateChain : UInt8.Ptr
    cCertificates : UInt32
    fFlags : UInt32
    dwBits : UInt32
}
struct SecPkgContext_LocalCredentialInfo {
    cbCertificateChain : UInt32
    pbCertificateChain : UInt8.Ptr
    cCertificates : UInt32
    fFlags : UInt32
    dwBits : UInt32
}
struct SecPkgContext_ClientCertPolicyResult {
    dwPolicyResult : HRESULT
    guidPolicyId : GUID
}
struct SecPkgContext_IssuerListInfoEx {
    aIssuers : CRYPT_INTEGER_BLOB.Ptr
    cIssuers : UInt32
}
struct SecPkgContext_ConnectionInfo {
    dwProtocol : UInt32
    aiCipher : ALG_ID
    dwCipherStrength : UInt32
    aiHash : ALG_ID
    dwHashStrength : UInt32
    aiExch : ALG_ID
    dwExchStrength : UInt32
}
struct SecPkgContext_ConnectionInfoEx {
    dwVersion : UInt32
    dwProtocol : UInt32
    szCipher : UInt16[64]
    dwCipherStrength : UInt32
    szHash : UInt16[64]
    dwHashStrength : UInt32
    szExchange : UInt16[64]
    dwExchStrength : UInt32
}
struct SecPkgContext_CipherInfo {
    dwVersion : UInt32
    dwProtocol : UInt32
    dwCipherSuite : UInt32
    dwBaseCipherSuite : UInt32
    szCipherSuite : UInt16[64]
    szCipher : UInt16[64]
    dwCipherLen : UInt32
    dwCipherBlockLen : UInt32
    szHash : UInt16[64]
    dwHashLen : UInt32
    szExchange : UInt16[64]
    dwMinExchangeLen : UInt32
    dwMaxExchangeLen : UInt32
    szCertificate : UInt16[64]
    dwKeyType : UInt32
}
struct SecPkgContext_EapKeyBlock {
    rgbKeys : UInt8[128]
    rgbIVs : UInt8[64]
}
struct SecPkgContext_MappedCredAttr {
    dwAttribute : UInt32
    pvBuffer : Struct.Ptr
}
struct SecPkgContext_SessionInfo {
    dwFlags : UInt32
    cbSessionId : UInt32
    rgbSessionId : UInt8[32]
}
struct SecPkgContext_SessionAppData {
    dwFlags : UInt32
    cbAppData : UInt32
    pbAppData : UInt8.Ptr
}
struct SecPkgContext_EapPrfInfo {
    dwVersion : UInt32
    cbPrfData : UInt32
    pbPrfData : UInt8.Ptr
}
struct SecPkgContext_SupportedSignatures {
    cSignatureAndHashAlgorithms : UInt16
    pSignatureAndHashAlgorithms : UInt16.Ptr
}
struct SecPkgContext_Certificates {
    cCertificates : UInt32
    cbCertificateChain : UInt32
    pbCertificateChain : UInt8.Ptr
}
struct SecPkgContext_CertInfo {
    dwVersion : UInt32
    cbSubjectName : UInt32
    pwszSubjectName : PWSTR
    cbIssuerName : UInt32
    pwszIssuerName : PWSTR
    dwKeySize : UInt32
}
struct SecPkgContext_UiInfo {
    hParentWindow : HWND
}
struct SecPkgContext_EarlyStart {
    dwEarlyStartFlags : UInt32
}
struct SecPkgContext_KeyingMaterialInfo {
    cbLabel : UInt16
    pszLabel : PSTR
    cbContextValue : UInt16
    pbContextValue : UInt8.Ptr
    cbKeyingMaterial : UInt32
}
struct SecPkgContext_KeyingMaterial {
    cbKeyingMaterial : UInt32
    pbKeyingMaterial : UInt8.Ptr
}
struct SecPkgContext_KeyingMaterial_Inproc {
    cbLabel : UInt16
    pszLabel : PSTR
    cbContextValue : UInt16
    pbContextValue : UInt8.Ptr
    cbKeyingMaterial : UInt32
    pbKeyingMaterial : UInt8.Ptr
}
struct SecPkgContext_SrtpParameters {
    ProtectionProfile : UInt16
    MasterKeyIdentifierSize : UInt8
    MasterKeyIdentifier : UInt8.Ptr
}
struct SecPkgContext_TokenBinding {
    MajorVersion : UInt8
    MinorVersion : UInt8
    KeyParametersSize : UInt16
    KeyParameters : UInt8.Ptr
}
struct SecPkgContext_CertificateValidationResult {
    dwChainErrorStatus : UInt32
    hrVerifyChainStatus : HRESULT
}
struct SCHANNEL_CRED {
    dwVersion : UInt32
    cCreds : UInt32
    paCred : CERT_CONTEXT.Ptr.Ptr
    hRootStore : HCERTSTORE
    cMappers : UInt32
    aphMappers : HMAPPER.Ptr.Ptr
    cSupportedAlgs : UInt32
    palgSupportedAlgs : ALG_ID.Ptr
    grbitEnabledProtocols : UInt32
    dwMinimumCipherStrength : UInt32
    dwMaximumCipherStrength : UInt32
    dwSessionLifespan : UInt32
    dwFlags : SCHANNEL_CRED_FLAGS
    dwCredFormat : UInt32
}
struct eTlsAlgorithmUsage extends Int32 {
    static TlsParametersCngAlgUsageKeyExchange := 0
    static TlsParametersCngAlgUsageSignature := 1
    static TlsParametersCngAlgUsageCipher := 2
    static TlsParametersCngAlgUsageDigest := 3
    static TlsParametersCngAlgUsageCertSig := 4
}
struct CRYPTO_SETTINGS {
    eAlgorithmUsage : eTlsAlgorithmUsage
    strCngAlgId : LSA_UNICODE_STRING
    cChainingModes : UInt32
    rgstrChainingModes : LSA_UNICODE_STRING.Ptr
    dwMinBitLength : UInt32
    dwMaxBitLength : UInt32
}
struct TLS_PARAMETERS {
    cAlpnIds : UInt32
    rgstrAlpnIds : LSA_UNICODE_STRING.Ptr
    grbitDisabledProtocols : UInt32
    cDisabledCrypto : UInt32
    pDisabledCrypto : CRYPTO_SETTINGS.Ptr
    dwFlags : UInt32
}
struct SCH_CREDENTIALS {
    dwVersion : UInt32
    dwCredFormat : UInt32
    cCreds : UInt32
    paCred : CERT_CONTEXT.Ptr.Ptr
    hRootStore : HCERTSTORE
    cMappers : UInt32
    aphMappers : HMAPPER.Ptr.Ptr
    dwSessionLifespan : UInt32
    dwFlags : UInt32
    cTlsParameters : UInt32
    pTlsParameters : TLS_PARAMETERS.Ptr
}
struct SEND_GENERIC_TLS_EXTENSION {
    ExtensionType : UInt16
    HandshakeType : UInt16
    Flags : UInt32
    BufferSize : UInt16
    Buffer : UInt8[1]
}
struct TLS_EXTENSION_SUBSCRIPTION {
    ExtensionType : UInt16
    HandshakeType : UInt16
}
struct SUBSCRIBE_GENERIC_TLS_EXTENSION {
    Flags : UInt32
    SubscriptionsCount : UInt32
    Subscriptions : TLS_EXTENSION_SUBSCRIPTION[1]
}
struct SCHANNEL_CERT_HASH {
    dwLength : UInt32
    dwFlags : UInt32
    hProv : IntPtr
    ShaHash : UInt8[20]
}
struct SCHANNEL_CERT_HASH_STORE {
    dwLength : UInt32
    dwFlags : UInt32
    hProv : IntPtr
    ShaHash : UInt8[20]
    pwszStoreName : UInt16[128]
}
struct SCHANNEL_ALERT_TOKEN {
    dwTokenType : UInt32
    dwAlertType : SCHANNEL_ALERT_TOKEN_ALERT_TYPE
    dwAlertNumber : UInt32
}
struct SCHANNEL_SESSION_TOKEN {
    dwTokenType : UInt32
    dwFlags : SCHANNEL_SESSION_TOKEN_FLAGS
}
struct SCHANNEL_CLIENT_SIGNATURE {
    cbLength : UInt32
    aiHash : ALG_ID
    cbHash : UInt32
    HashValue : UInt8[36]
    CertThumbprint : UInt8[20]
}
struct SSL_EMPTY_CACHE_FN_A extends FunctionPointer {
    static Types := [PSTR, UInt32, BOOL]
}
struct SSL_EMPTY_CACHE_FN_W extends FunctionPointer {
    static Types := [PWSTR, UInt32, BOOL]
}
struct SSL_CREDENTIAL_CERTIFICATE {
    cbPrivateKey : UInt32
    pPrivateKey : UInt8.Ptr
    cbCertificate : UInt32
    pCertificate : UInt8.Ptr
    pszPassword : PSTR
}
struct SCH_CRED {
    dwVersion : UInt32
    cCreds : UInt32
    paSecret : Struct.Ptr.Ptr
    paPublic : Struct.Ptr.Ptr
    cMappers : UInt32
    aphMappers : HMAPPER.Ptr.Ptr
}
struct SCH_CRED_SECRET_CAPI {
    dwType : UInt32
    hProv : IntPtr
}
struct SCH_CRED_SECRET_PRIVKEY {
    dwType : UInt32
    pPrivateKey : UInt8.Ptr
    cbPrivateKey : UInt32
    pszPassword : PSTR
}
struct SCH_CRED_PUBLIC_CERTCHAIN {
    dwType : UInt32
    cbCertChain : UInt32
    pCertChain : UInt8.Ptr
}
struct PctPublicKey {
    Type : UInt32
    cbKey : UInt32
    pKey : UInt8[1]
}
struct X509Certificate {
    Version : UInt32
    SerialNumber : UInt32[4]
    SignatureAlgorithm : ALG_ID
    ValidFrom : FILETIME
    ValidUntil : FILETIME
    pszIssuer : PSTR
    pszSubject : PSTR
    pPublicKey : PctPublicKey.Ptr
}
struct SSL_CRACK_CERTIFICATE_FN extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, BOOL, X509Certificate.Ptr.Ptr, BOOL]
}
struct SSL_FREE_CERTIFICATE_FN extends FunctionPointer {
    static Types := [X509Certificate.Ptr, "Void"]
}
struct SslGetServerIdentityFn extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32, HRESULT]
}
struct SCH_EXTENSION_DATA {
    ExtensionType : UInt16
    pExtData : UInt8.Ptr
    cbExtData : UInt32
}
struct SchGetExtensionsOptions extends Int32 {
    static SCH_EXTENSIONS_OPTIONS_NONE := 0
    static SCH_NO_RECORD_HEADER := 1
}
struct SslGetExtensionsFn extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, SCH_EXTENSION_DATA.Ptr, UInt8, UInt32.Ptr, SchGetExtensionsOptions, HRESULT]
}
struct SslDeserializeCertificateStoreFn extends FunctionPointer {
    static Types := [CRYPT_INTEGER_BLOB, CERT_CONTEXT.Ptr.Ptr, HRESULT]
}
struct LOGON_HOURS {
    UnitsPerWeek : UInt16
    LogonHours : UInt8.Ptr
}
struct SR_SECURITY_DESCRIPTOR {
    Length : UInt32
    SecurityDescriptor : UInt8.Ptr
}
struct USER_ALL_INFORMATION {
    LastLogon : Int64
    LastLogoff : Int64
    PasswordLastSet : Int64
    AccountExpires : Int64
    PasswordCanChange : Int64
    PasswordMustChange : Int64
    UserName : LSA_UNICODE_STRING
    FullName : LSA_UNICODE_STRING
    HomeDirectory : LSA_UNICODE_STRING
    HomeDirectoryDrive : LSA_UNICODE_STRING
    ScriptPath : LSA_UNICODE_STRING
    ProfilePath : LSA_UNICODE_STRING
    AdminComment : LSA_UNICODE_STRING
    WorkStations : LSA_UNICODE_STRING
    UserComment : LSA_UNICODE_STRING
    Parameters : LSA_UNICODE_STRING
    LmPassword : LSA_UNICODE_STRING
    NtPassword : LSA_UNICODE_STRING
    PrivateData : LSA_UNICODE_STRING
    SecurityDescriptor : SR_SECURITY_DESCRIPTOR
    UserId : UInt32
    PrimaryGroupId : UInt32
    UserAccountControl : UInt32
    WhichFields : UInt32
    LogonHours : LOGON_HOURS
    BadPasswordCount : UInt16
    LogonCount : UInt16
    CountryCode : UInt16
    CodePage : UInt16
    LmPasswordPresent : BOOLEAN
    NtPasswordPresent : BOOLEAN
    PasswordExpired : BOOLEAN
    PrivateDataSensitive : BOOLEAN
}
struct CLEAR_BLOCK {
    data : CHAR[8]
}
struct USER_SESSION_KEY {
    data : CYPHER_BLOCK[2]
}
struct NETLOGON_LOGON_INFO_CLASS extends Int32 {
    static NetlogonInteractiveInformation := 1
    static NetlogonNetworkInformation := 2
    static NetlogonServiceInformation := 3
    static NetlogonGenericInformation := 4
    static NetlogonInteractiveTransitiveInformation := 5
    static NetlogonNetworkTransitiveInformation := 6
    static NetlogonServiceTransitiveInformation := 7
    static NetlogonTicketLogonInformation := 8
}
struct NETLOGON_LOGON_IDENTITY_INFO {
    LogonDomainName : LSA_UNICODE_STRING
    ParameterControl : UInt32
    LogonId : Int64
    UserName : LSA_UNICODE_STRING
    Workstation : LSA_UNICODE_STRING
}
struct NETLOGON_INTERACTIVE_INFO {
    Identity : NETLOGON_LOGON_IDENTITY_INFO
    LmOwfPassword : LM_OWF_PASSWORD
    NtOwfPassword : LM_OWF_PASSWORD
}
struct NETLOGON_SERVICE_INFO {
    Identity : NETLOGON_LOGON_IDENTITY_INFO
    LmOwfPassword : LM_OWF_PASSWORD
    NtOwfPassword : LM_OWF_PASSWORD
}
struct NETLOGON_NETWORK_INFO {
    Identity : NETLOGON_LOGON_IDENTITY_INFO
    LmChallenge : CLEAR_BLOCK
    NtChallengeResponse : LSA_STRING
    LmChallengeResponse : LSA_STRING
}
struct NETLOGON_GENERIC_INFO {
    Identity : NETLOGON_LOGON_IDENTITY_INFO
    PackageName : LSA_UNICODE_STRING
    DataLength : UInt32
    LogonData : UInt8.Ptr
}
struct NETLOGON_TARGET_INFO {
    Type : UInt32
    NbComputerName : LSA_UNICODE_STRING
    NbDomainName : LSA_UNICODE_STRING
    DnsComputerName : LSA_UNICODE_STRING
    DnsDomainName : LSA_UNICODE_STRING
    DnsTreeName : LSA_UNICODE_STRING
    TargetName : LSA_UNICODE_STRING
}
struct MSV1_0_VALIDATION_INFO {
    LogoffTime : Int64
    KickoffTime : Int64
    LogonServer : LSA_UNICODE_STRING
    LogonDomainName : LSA_UNICODE_STRING
    SessionKey : USER_SESSION_KEY
    Authoritative : BOOLEAN
    UserFlags : UInt32
    WhichFields : UInt32
    UserId : UInt32
}
struct TOKENBINDING_TYPE extends Int32 {
    static TOKENBINDING_TYPE_PROVIDED := 0
    static TOKENBINDING_TYPE_REFERRED := 1
}
struct TOKENBINDING_EXTENSION_FORMAT extends Int32 {
    static TOKENBINDING_EXTENSION_FORMAT_UNDEFINED := 0
}
struct TOKENBINDING_KEY_PARAMETERS_TYPE extends Int32 {
    static TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PKCS := 0
    static TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PSS := 1
    static TOKENBINDING_KEY_PARAMETERS_TYPE_ECDSAP256 := 2
    static TOKENBINDING_KEY_PARAMETERS_TYPE_ANYEXISTING := 255
}
struct TOKENBINDING_IDENTIFIER {
    keyType : UInt8
}
struct TOKENBINDING_RESULT_DATA {
    bindingType : TOKENBINDING_TYPE
    identifierSize : UInt32
    identifierData : TOKENBINDING_IDENTIFIER.Ptr
    extensionFormat : TOKENBINDING_EXTENSION_FORMAT
    extensionSize : UInt32
    extensionData : Struct.Ptr
}
struct TOKENBINDING_RESULT_LIST {
    resultCount : UInt32
    resultData : TOKENBINDING_RESULT_DATA.Ptr
}
struct TOKENBINDING_KEY_TYPES {
    keyCount : UInt32
    keyType : TOKENBINDING_KEY_PARAMETERS_TYPE.Ptr
}
struct EXTENDED_NAME_FORMAT extends Int32 {
    static NameUnknown := 0
    static NameFullyQualifiedDN := 1
    static NameSamCompatible := 2
    static NameDisplay := 3
    static NameUniqueId := 6
    static NameCanonical := 7
    static NameUserPrincipal := 8
    static NameCanonicalEx := 9
    static NameServicePrincipal := 10
    static NameDnsDomain := 12
    static NameGivenName := 13
    static NameSurname := 14
}
struct SLDATATYPE extends UInt32 {
    static SL_DATA_NONE := 0
    static SL_DATA_SZ := 1
    static SL_DATA_DWORD := 4
    static SL_DATA_BINARY := 3
    static SL_DATA_MULTI_SZ := 7
    static SL_DATA_SUM := 100
}
struct SLIDTYPE extends Int32 {
    static SL_ID_APPLICATION := 0
    static SL_ID_PRODUCT_SKU := 1
    static SL_ID_LICENSE_FILE := 2
    static SL_ID_LICENSE := 3
    static SL_ID_PKEY := 4
    static SL_ID_ALL_LICENSES := 5
    static SL_ID_ALL_LICENSE_FILES := 6
    static SL_ID_STORE_TOKEN := 7
    static SL_ID_LAST := 8
}
struct SLLICENSINGSTATUS extends Int32 {
    static SL_LICENSING_STATUS_UNLICENSED := 0
    static SL_LICENSING_STATUS_LICENSED := 1
    static SL_LICENSING_STATUS_IN_GRACE_PERIOD := 2
    static SL_LICENSING_STATUS_NOTIFICATION := 3
    static SL_LICENSING_STATUS_LAST := 4
}
struct SL_LICENSING_STATUS {
    SkuId : GUID
    eStatus : SLLICENSINGSTATUS
    dwGraceTime : UInt32
    dwTotalGraceDays : UInt32
    hrReason : HRESULT
    qwValidityExpiration : Int64
}
struct SL_ACTIVATION_TYPE extends Int32 {
    static SL_ACTIVATION_TYPE_DEFAULT := 0
    static SL_ACTIVATION_TYPE_ACTIVE_DIRECTORY := 1
}
struct SL_ACTIVATION_INFO_HEADER {
    cbSize : UInt32 := this.Size
    type : SL_ACTIVATION_TYPE
}
struct SL_AD_ACTIVATION_INFO {
    header : SL_ACTIVATION_INFO_HEADER
    pwszProductKey : PWSTR
    pwszActivationObjectName : PWSTR
}
struct SLREFERRALTYPE extends Int32 {
    static SL_REFERRALTYPE_SKUID := 0
    static SL_REFERRALTYPE_APPID := 1
    static SL_REFERRALTYPE_OVERRIDE_SKUID := 2
    static SL_REFERRALTYPE_OVERRIDE_APPID := 3
    static SL_REFERRALTYPE_BEST_MATCH := 4
}
struct SL_GENUINE_STATE extends Int32 {
    static SL_GEN_STATE_IS_GENUINE := 0
    static SL_GEN_STATE_INVALID_LICENSE := 1
    static SL_GEN_STATE_TAMPERED := 2
    static SL_GEN_STATE_OFFLINE := 3
    static SL_GEN_STATE_LAST := 4
}
struct SL_NONGENUINE_UI_OPTIONS {
    cbSize : UInt32 := this.Size
    pComponentId : GUID.Ptr
    hResultUI : HRESULT
}
struct SL_SYSTEM_POLICY_INFORMATION {
    Reserved1 : Struct.Ptr[2]
    Reserved2 : UInt32[3]
}
struct ICcgDomainAuthCredentials extends IUnknown {
    static IID := "{6ECDA518-2010-4437-8BC3-46E752B7B172}"
    GetPasswordCredentials(pluginInput, domainName, username, password)
      => ComCall(3, this.p, "Str", pluginInput, PWSTR.Ptr, domainName, PWSTR.Ptr, username, PWSTR.Ptr, password)
}
