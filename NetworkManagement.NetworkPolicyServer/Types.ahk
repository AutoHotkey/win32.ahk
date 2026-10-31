#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct ATTRIBUTEID extends UInt32 {
    static ATTRIBUTE_UNDEFINED := 0
    static ATTRIBUTE_MIN_VALUE := 1
    static RADIUS_ATTRIBUTE_USER_NAME := 1
    static RADIUS_ATTRIBUTE_USER_PASSWORD := 2
    static RADIUS_ATTRIBUTE_CHAP_PASSWORD := 3
    static RADIUS_ATTRIBUTE_NAS_IP_ADDRESS := 4
    static RADIUS_ATTRIBUTE_NAS_PORT := 5
    static RADIUS_ATTRIBUTE_SERVICE_TYPE := 6
    static RADIUS_ATTRIBUTE_FRAMED_PROTOCOL := 7
    static RADIUS_ATTRIBUTE_FRAMED_IP_ADDRESS := 8
    static RADIUS_ATTRIBUTE_FRAMED_IP_NETMASK := 9
    static RADIUS_ATTRIBUTE_FRAMED_ROUTING := 10
    static RADIUS_ATTRIBUTE_FILTER_ID := 11
    static RADIUS_ATTRIBUTE_FRAMED_MTU := 12
    static RADIUS_ATTRIBUTE_FRAMED_COMPRESSION := 13
    static RADIUS_ATTRIBUTE_LOGIN_IP_HOST := 14
    static RADIUS_ATTRIBUTE_LOGIN_SERVICE := 15
    static RADIUS_ATTRIBUTE_LOGIN_TCP_PORT := 16
    static RADIUS_ATTRIBUTE_UNASSIGNED1 := 17
    static RADIUS_ATTRIBUTE_REPLY_MESSAGE := 18
    static RADIUS_ATTRIBUTE_CALLBACK_NUMBER := 19
    static RADIUS_ATTRIBUTE_CALLBACK_ID := 20
    static RADIUS_ATTRIBUTE_UNASSIGNED2 := 21
    static RADIUS_ATTRIBUTE_FRAMED_ROUTE := 22
    static RADIUS_ATTRIBUTE_FRAMED_IPX_NETWORK := 23
    static RADIUS_ATTRIBUTE_STATE := 24
    static RADIUS_ATTRIBUTE_CLASS := 25
    static RADIUS_ATTRIBUTE_VENDOR_SPECIFIC := 26
    static RADIUS_ATTRIBUTE_SESSION_TIMEOUT := 27
    static RADIUS_ATTRIBUTE_IDLE_TIMEOUT := 28
    static RADIUS_ATTRIBUTE_TERMINATION_ACTION := 29
    static RADIUS_ATTRIBUTE_CALLED_STATION_ID := 30
    static RADIUS_ATTRIBUTE_CALLING_STATION_ID := 31
    static RADIUS_ATTRIBUTE_NAS_IDENTIFIER := 32
    static RADIUS_ATTRIBUTE_PROXY_STATE := 33
    static RADIUS_ATTRIBUTE_LOGIN_LAT_SERVICE := 34
    static RADIUS_ATTRIBUTE_LOGIN_LAT_NODE := 35
    static RADIUS_ATTRIBUTE_LOGIN_LAT_GROUP := 36
    static RADIUS_ATTRIBUTE_FRAMED_APPLETALK_LINK := 37
    static RADIUS_ATTRIBUTE_FRAMED_APPLETALK_NET := 38
    static RADIUS_ATTRIBUTE_FRAMED_APPLETALK_ZONE := 39
    static RADIUS_ATTRIBUTE_ACCT_STATUS_TYPE := 40
    static RADIUS_ATTRIBUTE_ACCT_DELAY_TIME := 41
    static RADIUS_ATTRIBUTE_ACCT_INPUT_OCTETS := 42
    static RADIUS_ATTRIBUTE_ACCT_OUTPUT_OCTETS := 43
    static RADIUS_ATTRIBUTE_ACCT_SESSION_ID := 44
    static RADIUS_ATTRIBUTE_ACCT_AUTHENTIC := 45
    static RADIUS_ATTRIBUTE_ACCT_SESSION_TIME := 46
    static RADIUS_ATTRIBUTE_ACCT_INPUT_PACKETS := 47
    static RADIUS_ATTRIBUTE_ACCT_OUTPUT_PACKETS := 48
    static RADIUS_ATTRIBUTE_ACCT_TERMINATE_CAUSE := 49
    static RADIUS_ATTRIBUTE_ACCT_MULTI_SSN_ID := 50
    static RADIUS_ATTRIBUTE_ACCT_LINK_COUNT := 51
    static RADIUS_ATTRIBUTE_CHAP_CHALLENGE := 60
    static RADIUS_ATTRIBUTE_NAS_PORT_TYPE := 61
    static RADIUS_ATTRIBUTE_PORT_LIMIT := 62
    static RADIUS_ATTRIBUTE_LOGIN_LAT_PORT := 63
    static RADIUS_ATTRIBUTE_TUNNEL_TYPE := 64
    static RADIUS_ATTRIBUTE_TUNNEL_MEDIUM_TYPE := 65
    static RADIUS_ATTRIBUTE_TUNNEL_CLIENT_ENDPT := 66
    static RADIUS_ATTRIBUTE_TUNNEL_SERVER_ENDPT := 67
    static RADIUS_ATTRIBUTE_ACCT_TUNNEL_CONN := 68
    static RADIUS_ATTRIBUTE_TUNNEL_PASSWORD := 69
    static RADIUS_ATTRIBUTE_ARAP_PASSWORD := 70
    static RADIUS_ATTRIBUTE_ARAP_FEATURES := 71
    static RADIUS_ATTRIBUTE_ARAP_ZONE_ACCESS := 72
    static RADIUS_ATTRIBUTE_ARAP_SECURITY := 73
    static RADIUS_ATTRIBUTE_ARAP_SECURITY_DATA := 74
    static RADIUS_ATTRIBUTE_PASSWORD_RETRY := 75
    static RADIUS_ATTRIBUTE_PROMPT := 76
    static RADIUS_ATTRIBUTE_CONNECT_INFO := 77
    static RADIUS_ATTRIBUTE_CONFIGURATION_TOKEN := 78
    static RADIUS_ATTRIBUTE_EAP_MESSAGE := 79
    static RADIUS_ATTRIBUTE_SIGNATURE := 80
    static RADIUS_ATTRIBUTE_TUNNEL_PVT_GROUP_ID := 81
    static RADIUS_ATTRIBUTE_TUNNEL_ASSIGNMENT_ID := 82
    static RADIUS_ATTRIBUTE_TUNNEL_PREFERENCE := 83
    static RADIUS_ATTRIBUTE_ARAP_CHALLENGE_RESPONSE := 84
    static RADIUS_ATTRIBUTE_ACCT_INTERIM_INTERVAL := 85
    static RADIUS_ATTRIBUTE_NAS_IPv6_ADDRESS := 95
    static RADIUS_ATTRIBUTE_FRAMED_INTERFACE_ID := 96
    static RADIUS_ATTRIBUTE_FRAMED_IPv6_PREFIX := 97
    static RADIUS_ATTRIBUTE_LOGIN_IPv6_HOST := 98
    static RADIUS_ATTRIBUTE_FRAMED_IPv6_ROUTE := 99
    static RADIUS_ATTRIBUTE_FRAMED_IPv6_POOL := 100
    static IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IP_ADDRESS := 4096
    static IAS_ATTRIBUTE_SAVED_RADIUS_CALLBACK_NUMBER := 4097
    static IAS_ATTRIBUTE_NP_CALLING_STATION_ID := 4098
    static IAS_ATTRIBUTE_SAVED_NP_CALLING_STATION_ID := 4099
    static IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_ROUTE := 4100
    static IAS_ATTRIBUTE_IGNORE_USER_DIALIN_PROPERTIES := 4101
    static IAS_ATTRIBUTE_NP_TIME_OF_DAY := 4102
    static IAS_ATTRIBUTE_NP_CALLED_STATION_ID := 4103
    static IAS_ATTRIBUTE_NP_ALLOWED_PORT_TYPES := 4104
    static IAS_ATTRIBUTE_NP_AUTHENTICATION_TYPE := 4105
    static IAS_ATTRIBUTE_NP_ALLOWED_EAP_TYPE := 4106
    static IAS_ATTRIBUTE_SHARED_SECRET := 4107
    static IAS_ATTRIBUTE_CLIENT_IP_ADDRESS := 4108
    static IAS_ATTRIBUTE_CLIENT_PACKET_HEADER := 4109
    static IAS_ATTRIBUTE_TOKEN_GROUPS := 4110
    static IAS_ATTRIBUTE_ALLOW_DIALIN := 4111
    static IAS_ATTRIBUTE_REQUEST_ID := 4112
    static IAS_ATTRIBUTE_MANIPULATION_TARGET := 4113
    static IAS_ATTRIBUTE_MANIPULATION_RULE := 4114
    static IAS_ATTRIBUTE_ORIGINAL_USER_NAME := 4115
    static IAS_ATTRIBUTE_CLIENT_VENDOR_TYPE := 4116
    static IAS_ATTRIBUTE_CLIENT_UDP_PORT := 4117
    static MS_ATTRIBUTE_CHAP_CHALLENGE := 4118
    static MS_ATTRIBUTE_CHAP_RESPONSE := 4119
    static MS_ATTRIBUTE_CHAP_DOMAIN := 4120
    static MS_ATTRIBUTE_CHAP_ERROR := 4121
    static MS_ATTRIBUTE_CHAP_CPW1 := 4122
    static MS_ATTRIBUTE_CHAP_CPW2 := 4123
    static MS_ATTRIBUTE_CHAP_LM_ENC_PW := 4124
    static MS_ATTRIBUTE_CHAP_NT_ENC_PW := 4125
    static MS_ATTRIBUTE_CHAP_MPPE_KEYS := 4126
    static IAS_ATTRIBUTE_AUTHENTICATION_TYPE := 4127
    static IAS_ATTRIBUTE_CLIENT_NAME := 4128
    static IAS_ATTRIBUTE_NT4_ACCOUNT_NAME := 4129
    static IAS_ATTRIBUTE_FULLY_QUALIFIED_USER_NAME := 4130
    static IAS_ATTRIBUTE_NTGROUPS := 4131
    static IAS_ATTRIBUTE_EAP_FRIENDLY_NAME := 4132
    static IAS_ATTRIBUTE_AUTH_PROVIDER_TYPE := 4133
    static MS_ATTRIBUTE_ACCT_AUTH_TYPE := 4134
    static MS_ATTRIBUTE_ACCT_EAP_TYPE := 4135
    static IAS_ATTRIBUTE_PACKET_TYPE := 4136
    static IAS_ATTRIBUTE_AUTH_PROVIDER_NAME := 4137
    static IAS_ATTRIBUTE_ACCT_PROVIDER_TYPE := 4138
    static IAS_ATTRIBUTE_ACCT_PROVIDER_NAME := 4139
    static MS_ATTRIBUTE_MPPE_SEND_KEY := 4140
    static MS_ATTRIBUTE_MPPE_RECV_KEY := 4141
    static IAS_ATTRIBUTE_REASON_CODE := 4142
    static MS_ATTRIBUTE_FILTER := 4143
    static MS_ATTRIBUTE_CHAP2_RESPONSE := 4144
    static MS_ATTRIBUTE_CHAP2_SUCCESS := 4145
    static MS_ATTRIBUTE_CHAP2_CPW := 4146
    static MS_ATTRIBUTE_RAS_VENDOR := 4147
    static MS_ATTRIBUTE_RAS_VERSION := 4148
    static IAS_ATTRIBUTE_NP_NAME := 4149
    static MS_ATTRIBUTE_PRIMARY_DNS_SERVER := 4150
    static MS_ATTRIBUTE_SECONDARY_DNS_SERVER := 4151
    static MS_ATTRIBUTE_PRIMARY_NBNS_SERVER := 4152
    static MS_ATTRIBUTE_SECONDARY_NBNS_SERVER := 4153
    static IAS_ATTRIBUTE_PROXY_POLICY_NAME := 4154
    static IAS_ATTRIBUTE_PROVIDER_TYPE := 4155
    static IAS_ATTRIBUTE_PROVIDER_NAME := 4156
    static IAS_ATTRIBUTE_REMOTE_SERVER_ADDRESS := 4157
    static IAS_ATTRIBUTE_GENERATE_CLASS_ATTRIBUTE := 4158
    static MS_ATTRIBUTE_RAS_CLIENT_NAME := 4159
    static MS_ATTRIBUTE_RAS_CLIENT_VERSION := 4160
    static IAS_ATTRIBUTE_ALLOWED_CERTIFICATE_EKU := 4161
    static IAS_ATTRIBUTE_EXTENSION_STATE := 4162
    static IAS_ATTRIBUTE_GENERATE_SESSION_TIMEOUT := 4163
    static IAS_ATTRIBUTE_SESSION_TIMEOUT := 4164
    static MS_ATTRIBUTE_QUARANTINE_IPFILTER := 4165
    static MS_ATTRIBUTE_QUARANTINE_SESSION_TIMEOUT := 4166
    static MS_ATTRIBUTE_USER_SECURITY_IDENTITY := 4167
    static IAS_ATTRIBUTE_REMOTE_RADIUS_TO_WINDOWS_USER_MAPPING := 4168
    static IAS_ATTRIBUTE_PASSPORT_USER_MAPPING_UPN_SUFFIX := 4169
    static IAS_ATTRIBUTE_TUNNEL_TAG := 4170
    static IAS_ATTRIBUTE_NP_PEAPUPFRONT_ENABLED := 4171
    static IAS_ATTRIBUTE_CERTIFICATE_EKU := 8097
    static IAS_ATTRIBUTE_EAP_CONFIG := 8098
    static IAS_ATTRIBUTE_PEAP_EMBEDDED_EAP_TYPEID := 8099
    static IAS_ATTRIBUTE_PEAP_FAST_ROAMED_SESSION := 8100
    static IAS_ATTRIBUTE_EAP_TYPEID := 8101
    static MS_ATTRIBUTE_EAP_TLV := 8102
    static IAS_ATTRIBUTE_REJECT_REASON_CODE := 8103
    static IAS_ATTRIBUTE_PROXY_EAP_CONFIG := 8104
    static IAS_ATTRIBUTE_EAP_SESSION := 8105
    static IAS_ATTRIBUTE_IS_REPLAY := 8106
    static IAS_ATTRIBUTE_CLEAR_TEXT_PASSWORD := 8107
    static MS_ATTRIBUTE_IDENTITY_TYPE := 8108
    static MS_ATTRIBUTE_SERVICE_CLASS := 8109
    static MS_ATTRIBUTE_QUARANTINE_USER_CLASS := 8110
    static MS_ATTRIBUTE_QUARANTINE_STATE := 8111
    static IAS_ATTRIBUTE_OVERRIDE_RAP_AUTH := 8112
    static IAS_ATTRIBUTE_PEAP_CHANNEL_UP := 8113
    static IAS_ATTRIBUTE_NAME_MAPPED := 8114
    static IAS_ATTRIBUTE_POLICY_ENFORCED := 8115
    static IAS_ATTRIBUTE_MACHINE_NTGROUPS := 8116
    static IAS_ATTRIBUTE_USER_NTGROUPS := 8117
    static IAS_ATTRIBUTE_MACHINE_TOKEN_GROUPS := 8118
    static IAS_ATTRIBUTE_USER_TOKEN_GROUPS := 8119
    static MS_ATTRIBUTE_QUARANTINE_GRACE_TIME := 8120
    static IAS_ATTRIBUTE_QUARANTINE_URL := 8121
    static IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS := 8122
    static MS_ATTRIBUTE_NOT_QUARANTINE_CAPABLE := 8123
    static IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_RESULT := 8124
    static IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_VALIDATORS := 8125
    static IAS_ATTRIBUTE_MACHINE_NAME := 8126
    static IAS_ATTRIBUTE_NT4_MACHINE_NAME := 8127
    static IAS_ATTRIBUTE_QUARANTINE_SESSION_HANDLE := 8128
    static IAS_ATTRIBUTE_FULLY_QUALIFIED_MACHINE_NAME := 8129
    static IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS_CONFIGURATION := 8130
    static IAS_ATTRIBUTE_CLIENT_QUARANTINE_COMPATIBLE := 8131
    static MS_ATTRIBUTE_NETWORK_ACCESS_SERVER_TYPE := 8132
    static IAS_ATTRIBUTE_QUARANTINE_SESSION_ID := 8133
    static MS_ATTRIBUTE_AFW_QUARANTINE_ZONE := 8134
    static MS_ATTRIBUTE_AFW_PROTECTION_LEVEL := 8135
    static IAS_ATTRIBUTE_QUARANTINE_UPDATE_NON_COMPLIANT := 8136
    static IAS_ATTRIBUTE_REQUEST_START_TIME := 8137
    static MS_ATTRIBUTE_MACHINE_NAME := 8138
    static IAS_ATTRIBUTE_CLIENT_IPv6_ADDRESS := 8139
    static IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_INTERFACE_ID := 8140
    static IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_PREFIX := 8141
    static IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_ROUTE := 8142
    static MS_ATTRIBUTE_QUARANTINE_GRACE_TIME_CONFIGURATION := 8143
    static MS_ATTRIBUTE_IPv6_FILTER := 8144
    static MS_ATTRIBUTE_IPV4_REMEDIATION_SERVERS := 8145
    static MS_ATTRIBUTE_IPV6_REMEDIATION_SERVERS := 8146
    static IAS_ATTRIBUTE_PROXY_RETRY_COUNT := 8147
    static IAS_ATTRIBUTE_MACHINE_INVENTORY := 8148
    static IAS_ATTRIBUTE_ABSOLUTE_TIME := 8149
    static MS_ATTRIBUTE_QUARANTINE_SOH := 8150
    static IAS_ATTRIBUTE_EAP_TYPES_CONFIGURED_IN_PROXYPOLICY := 8151
    static MS_ATTRIBUTE_HCAP_LOCATION_GROUP_NAME := 8152
    static MS_ATTRIBUTE_EXTENDED_QUARANTINE_STATE := 8153
    static IAS_ATTRIBUTE_SOH_CARRIER_EAPTLV := 8154
    static MS_ATTRIBUTE_HCAP_USER_GROUPS := 8155
    static IAS_ATTRIBUTE_SAVED_MACHINE_HEALTHCHECK_ONLY := 8156
    static IAS_ATTRIBUTE_POLICY_EVALUATED_SHV := 8157
    static MS_ATTRIBUTE_RAS_CORRELATION_ID := 8158
    static MS_ATTRIBUTE_HCAP_USER_NAME := 8159
    static IAS_ATTRIBUTE_NT4_HCAP_ACCOUNT_NAME := 8160
    static IAS_ATTRIBUTE_USER_TOKEN_SID := 8161
    static IAS_ATTRIBUTE_MACHINE_TOKEN_SID := 8162
    static IAS_ATTRIBUTE_MACHINE_VALIDATED := 8163
    static MS_ATTRIBUTE_USER_IPv4_ADDRESS := 8164
    static MS_ATTRIBUTE_USER_IPv6_ADDRESS := 8165
    static MS_ATTRIBUTE_TSG_DEVICE_REDIRECTION := 8166
    static IAS_ATTRIBUTE_ACCEPT_REASON_CODE := 8167
    static IAS_ATTRIBUTE_LOGGING_RESULT := 8168
    static IAS_ATTRIBUTE_SERVER_IP_ADDRESS := 8169
    static IAS_ATTRIBUTE_SERVER_IPv6_ADDRESS := 8170
    static IAS_ATTRIBUTE_RADIUS_USERNAME_ENCODING_ASCII := 8171
    static MS_ATTRIBUTE_RAS_ROUTING_DOMAIN_ID := 8172
    static MS_ATTRIBUTE_AZURE_POLICY_ID := 8173
    static IAS_ATTRIBUTE_CERTIFICATE_THUMBPRINT := 8250
    static RAS_ATTRIBUTE_ENCRYPTION_TYPE := 4294967206
    static RAS_ATTRIBUTE_ENCRYPTION_POLICY := 4294967207
    static RAS_ATTRIBUTE_BAP_REQUIRED := 4294967208
    static RAS_ATTRIBUTE_BAP_LINE_DOWN_TIME := 4294967209
    static RAS_ATTRIBUTE_BAP_LINE_DOWN_LIMIT := 4294967210
}
struct NEW_LOG_FILE_FREQUENCY extends Int32 {
    static IAS_LOGGING_UNLIMITED_SIZE := 0
    static IAS_LOGGING_DAILY := 1
    static IAS_LOGGING_WEEKLY := 2
    static IAS_LOGGING_MONTHLY := 3
    static IAS_LOGGING_WHEN_FILE_SIZE_REACHES := 4
}
struct AUTHENTICATION_TYPE extends Int32 {
    static IAS_AUTH_INVALID := 0
    static IAS_AUTH_PAP := 1
    static IAS_AUTH_MD5CHAP := 2
    static IAS_AUTH_MSCHAP := 3
    static IAS_AUTH_MSCHAP2 := 4
    static IAS_AUTH_EAP := 5
    static IAS_AUTH_ARAP := 6
    static IAS_AUTH_NONE := 7
    static IAS_AUTH_CUSTOM := 8
    static IAS_AUTH_MSCHAP_CPW := 9
    static IAS_AUTH_MSCHAP2_CPW := 10
    static IAS_AUTH_PEAP := 11
}
struct IDENTITY_TYPE extends Int32 {
    static IAS_IDENTITY_NO_DEFAULT := 1
}
struct ATTRIBUTESYNTAX extends Int32 {
    static IAS_SYNTAX_BOOLEAN := 1
    static IAS_SYNTAX_INTEGER := 2
    static IAS_SYNTAX_ENUMERATOR := 3
    static IAS_SYNTAX_INETADDR := 4
    static IAS_SYNTAX_STRING := 5
    static IAS_SYNTAX_OCTETSTRING := 6
    static IAS_SYNTAX_UTCTIME := 7
    static IAS_SYNTAX_PROVIDERSPECIFIC := 8
    static IAS_SYNTAX_UNSIGNEDINTEGER := 9
    static IAS_SYNTAX_INETADDR6 := 10
}
struct ATTRIBUTERESTRICTIONS extends Int32 {
    static MULTIVALUED := 1
    static ALLOWEDINPROFILE := 2
    static ALLOWEDINCONDITION := 4
    static ALLOWEDINPROXYPROFILE := 8
    static ALLOWEDINPROXYCONDITION := 16
    static ALLOWEDINVPNDIALUP := 32
    static ALLOWEDIN8021X := 64
}
struct ATTRIBUTEFILTER extends Int32 {
    static ATTRIBUTE_FILTER_NONE := 0
    static ATTRIBUTE_FILTER_VPN_DIALUP := 1
    static ATTRIBUTE_FILTER_IEEE_802_1x := 2
}
struct ATTRIBUTEINFO extends Int32 {
    static NAME := 1
    static SYNTAX := 2
    static RESTRICTIONS := 3
    static DESCRIPTION := 4
    static VENDORID := 5
    static LDAPNAME := 6
    static VENDORTYPE := 7
}
struct IASCOMMONPROPERTIES extends Int32 {
    static PROPERTY_SDO_RESERVED := 0
    static PROPERTY_SDO_CLASS := 1
    static PROPERTY_SDO_NAME := 2
    static PROPERTY_SDO_DESCRIPTION := 3
    static PROPERTY_SDO_ID := 4
    static PROPERTY_SDO_DATASTORE_NAME := 5
    static PROPERTY_SDO_TEMPLATE_GUID := 6
    static PROPERTY_SDO_OPAQUE := 7
    static PROPERTY_SDO_START := 1024
}
struct USERPROPERTIES extends Int32 {
    static PROPERTY_USER_CALLING_STATION_ID := 1024
    static PROPERTY_USER_SAVED_CALLING_STATION_ID := 1025
    static PROPERTY_USER_RADIUS_CALLBACK_NUMBER := 1026
    static PROPERTY_USER_RADIUS_FRAMED_ROUTE := 1027
    static PROPERTY_USER_RADIUS_FRAMED_IP_ADDRESS := 1028
    static PROPERTY_USER_SAVED_RADIUS_CALLBACK_NUMBER := 1029
    static PROPERTY_USER_SAVED_RADIUS_FRAMED_ROUTE := 1030
    static PROPERTY_USER_SAVED_RADIUS_FRAMED_IP_ADDRESS := 1031
    static PROPERTY_USER_ALLOW_DIALIN := 1032
    static PROPERTY_USER_SERVICE_TYPE := 1033
    static PROPERTY_USER_RADIUS_FRAMED_IPV6_ROUTE := 1034
    static PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_ROUTE := 1035
    static PROPERTY_USER_RADIUS_FRAMED_INTERFACE_ID := 1036
    static PROPERTY_USER_SAVED_RADIUS_FRAMED_INTERFACE_ID := 1037
    static PROPERTY_USER_RADIUS_FRAMED_IPV6_PREFIX := 1038
    static PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_PREFIX := 1039
}
struct DICTIONARYPROPERTIES extends Int32 {
    static PROPERTY_DICTIONARY_ATTRIBUTES_COLLECTION := 1024
    static PROPERTY_DICTIONARY_LOCATION := 1025
}
struct ATTRIBUTEPROPERTIES extends Int32 {
    static PROPERTY_ATTRIBUTE_ID := 1024
    static PROPERTY_ATTRIBUTE_VENDOR_ID := 1025
    static PROPERTY_ATTRIBUTE_VENDOR_TYPE_ID := 1026
    static PROPERTY_ATTRIBUTE_IS_ENUMERABLE := 1027
    static PROPERTY_ATTRIBUTE_ENUM_NAMES := 1028
    static PROPERTY_ATTRIBUTE_ENUM_VALUES := 1029
    static PROPERTY_ATTRIBUTE_SYNTAX := 1030
    static PROPERTY_ATTRIBUTE_ALLOW_MULTIPLE := 1031
    static PROPERTY_ATTRIBUTE_ALLOW_LOG_ORDINAL := 1032
    static PROPERTY_ATTRIBUTE_ALLOW_IN_PROFILE := 1033
    static PROPERTY_ATTRIBUTE_ALLOW_IN_CONDITION := 1034
    static PROPERTY_ATTRIBUTE_DISPLAY_NAME := 1035
    static PROPERTY_ATTRIBUTE_VALUE := 1036
    static PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_PROFILE := 1037
    static PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_CONDITION := 1038
    static PROPERTY_ATTRIBUTE_ALLOW_IN_VPNDIALUP := 1039
    static PROPERTY_ATTRIBUTE_ALLOW_IN_8021X := 1040
    static PROPERTY_ATTRIBUTE_ENUM_FILTERS := 1041
}
struct IASPROPERTIES extends Int32 {
    static PROPERTY_IAS_RADIUSSERVERGROUPS_COLLECTION := 1024
    static PROPERTY_IAS_POLICIES_COLLECTION := 1025
    static PROPERTY_IAS_PROFILES_COLLECTION := 1026
    static PROPERTY_IAS_PROTOCOLS_COLLECTION := 1027
    static PROPERTY_IAS_AUDITORS_COLLECTION := 1028
    static PROPERTY_IAS_REQUESTHANDLERS_COLLECTION := 1029
    static PROPERTY_IAS_PROXYPOLICIES_COLLECTION := 1030
    static PROPERTY_IAS_PROXYPROFILES_COLLECTION := 1031
    static PROPERTY_IAS_REMEDIATIONSERVERGROUPS_COLLECTION := 1032
    static PROPERTY_IAS_SHVTEMPLATES_COLLECTION := 1033
}
struct TEMPLATESPROPERTIES extends Int32 {
    static PROPERTY_TEMPLATES_POLICIES_TEMPLATES := 1024
    static PROPERTY_TEMPLATES_PROFILES_TEMPLATES := 1025
    static PROPERTY_TEMPLATES_PROFILES_COLLECTION := 1026
    static PROPERTY_TEMPLATES_PROXYPOLICIES_TEMPLATES := 1027
    static PROPERTY_TEMPLATES_PROXYPROFILES_TEMPLATES := 1028
    static PROPERTY_TEMPLATES_PROXYPROFILES_COLLECTION := 1029
    static PROPERTY_TEMPLATES_REMEDIATIONSERVERGROUPS_TEMPLATES := 1030
    static PROPERTY_TEMPLATES_SHVTEMPLATES_TEMPLATES := 1031
    static PROPERTY_TEMPLATES_CLIENTS_TEMPLATES := 1032
    static PROPERTY_TEMPLATES_RADIUSSERVERS_TEMPLATES := 1033
    static PROPERTY_TEMPLATES_SHAREDSECRETS_TEMPLATES := 1034
    static PROPERTY_TEMPLATES_IPFILTERS_TEMPLATES := 1035
}
struct CLIENTPROPERTIES extends Int32 {
    static PROPERTY_CLIENT_REQUIRE_SIGNATURE := 1024
    static PROPERTY_CLIENT_UNUSED := 1025
    static PROPERTY_CLIENT_SHARED_SECRET := 1026
    static PROPERTY_CLIENT_NAS_MANUFACTURER := 1027
    static PROPERTY_CLIENT_ADDRESS := 1028
    static PROPERTY_CLIENT_QUARANTINE_COMPATIBLE := 1029
    static PROPERTY_CLIENT_ENABLED := 1030
    static PROPERTY_CLIENT_SECRET_TEMPLATE_GUID := 1031
}
struct VENDORPROPERTIES extends Int32 {
    static PROPERTY_NAS_VENDOR_ID := 1024
}
struct PROFILEPROPERTIES extends Int32 {
    static PROPERTY_PROFILE_ATTRIBUTES_COLLECTION := 1024
    static PROPERTY_PROFILE_IPFILTER_TEMPLATE_GUID := 1025
}
struct POLICYPROPERTIES extends Int32 {
    static PROPERTY_POLICY_CONSTRAINT := 1024
    static PROPERTY_POLICY_MERIT := 1025
    static PROPERTY_POLICY_UNUSED0 := 1026
    static PROPERTY_POLICY_UNUSED1 := 1027
    static PROPERTY_POLICY_PROFILE_NAME := 1028
    static PROPERTY_POLICY_ACTION := 1029
    static PROPERTY_POLICY_CONDITIONS_COLLECTION := 1030
    static PROPERTY_POLICY_ENABLED := 1031
    static PROPERTY_POLICY_SOURCETAG := 1032
}
struct CONDITIONPROPERTIES extends Int32 {
    static PROPERTY_CONDITION_TEXT := 1024
}
struct RADIUSSERVERGROUPPROPERTIES extends Int32 {
    static PROPERTY_RADIUSSERVERGROUP_SERVERS_COLLECTION := 1024
}
struct RADIUSSERVERPROPERTIES extends Int32 {
    static PROPERTY_RADIUSSERVER_AUTH_PORT := 1024
    static PROPERTY_RADIUSSERVER_AUTH_SECRET := 1025
    static PROPERTY_RADIUSSERVER_ACCT_PORT := 1026
    static PROPERTY_RADIUSSERVER_ACCT_SECRET := 1027
    static PROPERTY_RADIUSSERVER_ADDRESS := 1028
    static PROPERTY_RADIUSSERVER_FORWARD_ACCT_ONOFF := 1029
    static PROPERTY_RADIUSSERVER_PRIORITY := 1030
    static PROPERTY_RADIUSSERVER_WEIGHT := 1031
    static PROPERTY_RADIUSSERVER_TIMEOUT := 1032
    static PROPERTY_RADIUSSERVER_MAX_LOST := 1033
    static PROPERTY_RADIUSSERVER_BLACKOUT := 1034
    static PROPERTY_RADIUSSERVER_SEND_SIGNATURE := 1035
    static PROPERTY_RADIUSSERVER_AUTH_SECRET_TEMPLATE_GUID := 1036
    static PROPERTY_RADIUSSERVER_ACCT_SECRET_TEMPLATE_GUID := 1037
}
struct REMEDIATIONSERVERGROUPPROPERTIES extends Int32 {
    static PROPERTY_REMEDIATIONSERVERGROUP_SERVERS_COLLECTION := 1024
}
struct REMEDIATIONSERVERPROPERTIES extends Int32 {
    static PROPERTY_REMEDIATIONSERVER_ADDRESS := 1024
    static PROPERTY_REMEDIATIONSERVER_FRIENDLY_NAME := 1025
}
struct SHVTEMPLATEPROPERTIES extends Int32 {
    static PROPERTY_SHV_COMBINATION_TYPE := 1024
    static PROPERTY_SHV_LIST := 1025
    static PROPERTY_SHVCONFIG_LIST := 1026
}
struct IPFILTERPROPERTIES extends Int32 {
    static PROPERTY_IPFILTER_ATTRIBUTES_COLLECTION := 1024
}
struct SHAREDSECRETPROPERTIES extends Int32 {
    static PROPERTY_SHAREDSECRET_STRING := 1024
}
struct IASCOMPONENTPROPERTIES extends Int32 {
    static PROPERTY_COMPONENT_ID := 1024
    static PROPERTY_COMPONENT_PROG_ID := 1025
    static PROPERTY_COMPONENT_START := 1026
}
struct PROTOCOLPROPERTIES extends Int32 {
    static PROPERTY_PROTOCOL_REQUEST_HANDLER := 1026
    static PROPERTY_PROTOCOL_START := 1027
}
struct RADIUSPROPERTIES extends Int32 {
    static PROPERTY_RADIUS_ACCOUNTING_PORT := 1027
    static PROPERTY_RADIUS_AUTHENTICATION_PORT := 1028
    static PROPERTY_RADIUS_CLIENTS_COLLECTION := 1029
    static PROPERTY_RADIUS_VENDORS_COLLECTION := 1030
}
struct NTEVENTLOGPROPERTIES extends Int32 {
    static PROPERTY_EVENTLOG_LOG_APPLICATION_EVENTS := 1026
    static PROPERTY_EVENTLOG_LOG_MALFORMED := 1027
    static PROPERTY_EVENTLOG_LOG_DEBUG := 1028
}
struct NAMESPROPERTIES extends Int32 {
    static PROPERTY_NAMES_REALMS := 1026
}
struct NTSAMPROPERTIES extends Int32 {
    static PROPERTY_NTSAM_ALLOW_LM_AUTHENTICATION := 1026
}
struct ACCOUNTINGPROPERTIES extends Int32 {
    static PROPERTY_ACCOUNTING_LOG_ACCOUNTING := 1026
    static PROPERTY_ACCOUNTING_LOG_ACCOUNTING_INTERIM := 1027
    static PROPERTY_ACCOUNTING_LOG_AUTHENTICATION := 1028
    static PROPERTY_ACCOUNTING_LOG_OPEN_NEW_FREQUENCY := 1029
    static PROPERTY_ACCOUNTING_LOG_OPEN_NEW_SIZE := 1030
    static PROPERTY_ACCOUNTING_LOG_FILE_DIRECTORY := 1031
    static PROPERTY_ACCOUNTING_LOG_IAS1_FORMAT := 1032
    static PROPERTY_ACCOUNTING_LOG_ENABLE_LOGGING := 1033
    static PROPERTY_ACCOUNTING_LOG_DELETE_IF_FULL := 1034
    static PROPERTY_ACCOUNTING_SQL_MAX_SESSIONS := 1035
    static PROPERTY_ACCOUNTING_LOG_AUTHENTICATION_INTERIM := 1036
    static PROPERTY_ACCOUNTING_LOG_FILE_IS_BACKUP := 1037
    static PROPERTY_ACCOUNTING_DISCARD_REQUEST_ON_FAILURE := 1038
}
struct NAPPROPERTIES extends Int32 {
    static PROPERTY_NAP_POLICIES_COLLECTION := 1026
    static PROPERTY_SHV_TEMPLATES_COLLECTION := 1027
}
struct RADIUSPROXYPROPERTIES extends Int32 {
    static PROPERTY_RADIUSPROXY_SERVERGROUPS := 1026
}
struct REMEDIATIONSERVERSPROPERTIES extends Int32 {
    static PROPERTY_REMEDIATIONSERVERS_SERVERGROUPS := 1026
}
struct SHV_COMBINATION_TYPE extends Int32 {
    static SHV_COMBINATION_TYPE_ALL_PASS := 0
    static SHV_COMBINATION_TYPE_ALL_FAIL := 1
    static SHV_COMBINATION_TYPE_ONE_OR_MORE_PASS := 2
    static SHV_COMBINATION_TYPE_ONE_OR_MORE_FAIL := 3
    static SHV_COMBINATION_TYPE_ONE_OR_MORE_INFECTED := 4
    static SHV_COMBINATION_TYPE_ONE_OR_MORE_TRANSITIONAL := 5
    static SHV_COMBINATION_TYPE_ONE_OR_MORE_UNKNOWN := 6
    static SHV_COMBINATION_TYPE_MAX := 7
}
struct SERVICE_TYPE extends Int32 {
    static SERVICE_TYPE_IAS := 0
    static SERVICE_TYPE_RAS := 1
    static SERVICE_TYPE_RAMGMTSVC := 2
    static SERVICE_TYPE_MAX := 3
}
struct IASOSTYPE extends Int32 {
    static SYSTEM_TYPE_NT4_WORKSTATION := 0
    static SYSTEM_TYPE_NT5_WORKSTATION := 1
    static SYSTEM_TYPE_NT6_WORKSTATION := 2
    static SYSTEM_TYPE_NT6_1_WORKSTATION := 3
    static SYSTEM_TYPE_NT6_2_WORKSTATION := 4
    static SYSTEM_TYPE_NT6_3_WORKSTATION := 5
    static SYSTEM_TYPE_NT10_0_WORKSTATION := 6
    static SYSTEM_TYPE_NT4_SERVER := 7
    static SYSTEM_TYPE_NT5_SERVER := 8
    static SYSTEM_TYPE_NT6_SERVER := 9
    static SYSTEM_TYPE_NT6_1_SERVER := 10
    static SYSTEM_TYPE_NT6_2_SERVER := 11
    static SYSTEM_TYPE_NT6_3_SERVER := 12
    static SYSTEM_TYPE_NT10_0_SERVER := 13
}
struct IASDOMAINTYPE extends Int32 {
    static DOMAIN_TYPE_NONE := 0
    static DOMAIN_TYPE_NT4 := 1
    static DOMAIN_TYPE_NT5 := 2
    static DOMAIN_TYPE_MIXED := 3
}
struct IASDATASTORE extends Int32 {
    static DATA_STORE_LOCAL := 0
    static DATA_STORE_DIRECTORY := 1
}
struct ISdoMachine extends IDispatch {
    static IID := "{479F6E75-49A2-11D2-8ECA-00C04FC2F519}"
    Attach(bstrComputerName)
      => ComCall(7, this.p, BSTR, bstrComputerName)
    GetDictionarySDO(ppDictionarySDO)
      => ComCall(8, this.p, IUnknown.Ptr, ppDictionarySDO)
    GetServiceSDO(eDataStore, bstrServiceName, ppServiceSDO)
      => ComCall(9, this.p, IASDATASTORE, eDataStore, BSTR, bstrServiceName, IUnknown.Ptr, ppServiceSDO)
    GetUserSDO(eDataStore, bstrUserName, ppUserSDO)
      => ComCall(10, this.p, IASDATASTORE, eDataStore, BSTR, bstrUserName, IUnknown.Ptr, ppUserSDO)
    GetOSType(eOSType)
      => ComCall(11, this.p, IASOSTYPE.Ptr, eOSType)
    GetDomainType(eDomainType)
      => ComCall(12, this.p, IASDOMAINTYPE.Ptr, eDomainType)
    IsDirectoryAvailable(boolDirectoryAvailable)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, boolDirectoryAvailable)
    GetAttachedComputer(bstrComputerName)
      => ComCall(14, this.p, BSTR.Ptr, bstrComputerName)
    GetSDOSchema(ppSDOSchema)
      => ComCall(15, this.p, IUnknown.Ptr, ppSDOSchema)
}
struct ISdoMachine2 extends ISdoMachine {
    static IID := "{518E5FFE-D8CE-4F7E-A5DB-B40A35419D3B}"
    GetTemplatesSDO(bstrServiceName, ppTemplatesSDO)
      => ComCall(16, this.p, BSTR, bstrServiceName, IUnknown.Ptr, ppTemplatesSDO)
    EnableTemplates()
      => ComCall(17, this.p)
    SyncConfigAgainstTemplates(bstrServiceName, ppConfigRoot, ppTemplatesRoot, bForcedSync)
      => ComCall(18, this.p, BSTR, bstrServiceName, IUnknown.Ptr, ppConfigRoot, IUnknown.Ptr, ppTemplatesRoot, VARIANT_BOOL, bForcedSync)
    ImportRemoteTemplates(pLocalTemplatesRoot?, bstrRemoteMachineName)
      => ComCall(19, this.p, IUnknown, pLocalTemplatesRoot?, BSTR, bstrRemoteMachineName)
    Reload()
      => ComCall(20, this.p)
}
struct ISdoServiceControl extends IDispatch {
    static IID := "{479F6E74-49A2-11D2-8ECA-00C04FC2F519}"
    StartService()
      => ComCall(7, this.p)
    StopService()
      => ComCall(8, this.p)
    GetServiceStatus(status)
      => ComCall(9, this.p, Int32.Ptr, status)
    ResetService()
      => ComCall(10, this.p)
}
struct ISdo extends IDispatch {
    static IID := "{56BC53DE-96DB-11D1-BF3F-000000000000}"
    GetPropertyInfo(Id, ppPropertyInfo)
      => ComCall(7, this.p, Int32, Id, IUnknown.Ptr, ppPropertyInfo)
    GetProperty(Id, pValue)
      => ComCall(8, this.p, Int32, Id, VARIANT.Ptr, pValue)
    PutProperty(Id, pValue)
      => ComCall(9, this.p, Int32, Id, VARIANT.Ptr, pValue)
    ResetProperty(Id)
      => ComCall(10, this.p, Int32, Id)
    Apply()
      => ComCall(11, this.p)
    Restore()
      => ComCall(12, this.p)
    get__NewEnum(ppEnumVARIANT)
      => ComCall(13, this.p, IUnknown.Ptr, ppEnumVARIANT)
}
struct ISdoCollection extends IDispatch {
    static IID := "{56BC53E2-96DB-11D1-BF3F-000000000000}"
    get_Count(pCount)
      => ComCall(7, this.p, Int32.Ptr, pCount)
    Add(bstrName, ppItem)
      => ComCall(8, this.p, BSTR, bstrName, IDispatch.Ptr, ppItem)
    Remove(pItem)
      => ComCall(9, this.p, IDispatch, pItem)
    RemoveAll()
      => ComCall(10, this.p)
    Reload()
      => ComCall(11, this.p)
    IsNameUnique(bstrName, pBool)
      => ComCall(12, this.p, BSTR, bstrName, VARIANT_BOOL.Ptr, pBool)
    Item(Name, pItem)
      => ComCall(13, this.p, VARIANT.Ptr, Name, IDispatch.Ptr, pItem)
    get__NewEnum(ppEnumVARIANT)
      => ComCall(14, this.p, IUnknown.Ptr, ppEnumVARIANT)
}
struct ITemplateSdo extends ISdo {
    static IID := "{8AA85302-D2E2-4E20-8B1F-A571E437D6C9}"
    AddToCollection(bstrName, pCollection, ppItem)
      => ComCall(14, this.p, BSTR, bstrName, IDispatch, pCollection, IDispatch.Ptr, ppItem)
    AddToSdo(bstrName, pSdoTarget, ppItem)
      => ComCall(15, this.p, BSTR, bstrName, IDispatch, pSdoTarget, IDispatch.Ptr, ppItem)
    AddToSdoAsProperty(pSdoTarget, id)
      => ComCall(16, this.p, IDispatch, pSdoTarget, Int32, id)
}
struct ISdoDictionaryOld extends IDispatch {
    static IID := "{D432E5F4-53D8-11D2-9A3A-00C04FB998AC}"
    EnumAttributes(Id, pValues)
      => ComCall(7, this.p, VARIANT.Ptr, Id, VARIANT.Ptr, pValues)
    GetAttributeInfo(Id, pInfoIDs, pInfoValues)
      => ComCall(8, this.p, ATTRIBUTEID, Id, VARIANT.Ptr, pInfoIDs, VARIANT.Ptr, pInfoValues)
    EnumAttributeValues(Id, pValueIds, pValuesDesc)
      => ComCall(9, this.p, ATTRIBUTEID, Id, VARIANT.Ptr, pValueIds, VARIANT.Ptr, pValuesDesc)
    CreateAttribute(Id, ppAttributeObject)
      => ComCall(10, this.p, ATTRIBUTEID, Id, IDispatch.Ptr, ppAttributeObject)
    GetAttributeID(bstrAttributeName, pId)
      => ComCall(11, this.p, BSTR, bstrAttributeName, ATTRIBUTEID.Ptr, pId)
}
struct RADIUS_ATTRIBUTE_TYPE extends Int32 {
    static ratMinimum := 0
    static ratUserName := 1
    static ratUserPassword := 2
    static ratCHAPPassword := 3
    static ratNASIPAddress := 4
    static ratNASPort := 5
    static ratServiceType := 6
    static ratFramedProtocol := 7
    static ratFramedIPAddress := 8
    static ratFramedIPNetmask := 9
    static ratFramedRouting := 10
    static ratFilterId := 11
    static ratFramedMTU := 12
    static ratFramedCompression := 13
    static ratLoginIPHost := 14
    static ratLoginService := 15
    static ratLoginPort := 16
    static ratReplyMessage := 18
    static ratCallbackNumber := 19
    static ratCallbackId := 20
    static ratFramedRoute := 22
    static ratFramedIPXNetwork := 23
    static ratState := 24
    static ratClass := 25
    static ratVendorSpecific := 26
    static ratSessionTimeout := 27
    static ratIdleTimeout := 28
    static ratTerminationAction := 29
    static ratCalledStationId := 30
    static ratCallingStationId := 31
    static ratNASIdentifier := 32
    static ratProxyState := 33
    static ratLoginLATService := 34
    static ratLoginLATNode := 35
    static ratLoginLATGroup := 36
    static ratFramedAppleTalkLink := 37
    static ratFramedAppleTalkNetwork := 38
    static ratFramedAppleTalkZone := 39
    static ratAcctStatusType := 40
    static ratAcctDelayTime := 41
    static ratAcctInputOctets := 42
    static ratAcctOutputOctets := 43
    static ratAcctSessionId := 44
    static ratAcctAuthentic := 45
    static ratAcctSessionTime := 46
    static ratAcctInputPackets := 47
    static ratAcctOutputPackets := 48
    static ratAcctTerminationCause := 49
    static ratCHAPChallenge := 60
    static ratNASPortType := 61
    static ratPortLimit := 62
    static ratTunnelType := 64
    static ratMediumType := 65
    static ratTunnelPassword := 69
    static ratTunnelPrivateGroupID := 81
    static ratNASIPv6Address := 95
    static ratFramedInterfaceId := 96
    static ratFramedIPv6Prefix := 97
    static ratLoginIPv6Host := 98
    static ratFramedIPv6Route := 99
    static ratFramedIPv6Pool := 100
    static ratCode := 262
    static ratIdentifier := 263
    static ratAuthenticator := 264
    static ratSrcIPAddress := 265
    static ratSrcPort := 266
    static ratProvider := 267
    static ratStrippedUserName := 268
    static ratFQUserName := 269
    static ratPolicyName := 270
    static ratUniqueId := 271
    static ratExtensionState := 272
    static ratEAPTLV := 273
    static ratRejectReasonCode := 274
    static ratCRPPolicyName := 275
    static ratProviderName := 276
    static ratClearTextPassword := 277
    static ratSrcIPv6Address := 278
    static ratCertificateThumbprint := 279
}
struct RADIUS_CODE extends Int32 {
    static rcUnknown := 0
    static rcAccessRequest := 1
    static rcAccessAccept := 2
    static rcAccessReject := 3
    static rcAccountingRequest := 4
    static rcAccountingResponse := 5
    static rcAccessChallenge := 11
    static rcDiscard := 256
}
struct RADIUS_AUTHENTICATION_PROVIDER extends Int32 {
    static rapUnknown := 0
    static rapUsersFile := 1
    static rapProxy := 2
    static rapWindowsNT := 3
    static rapMCIS := 4
    static rapODBC := 5
    static rapNone := 6
}
struct RADIUS_REJECT_REASON_CODE extends Int32 {
    static rrrcUndefined := 0
    static rrrcAccountUnknown := 1
    static rrrcAccountDisabled := 2
    static rrrcAccountExpired := 3
    static rrrcAuthenticationFailure := 4
}
struct RADIUS_DATA_TYPE extends Int32 {
    static rdtUnknown := 0
    static rdtString := 1
    static rdtAddress := 2
    static rdtInteger := 3
    static rdtTime := 4
    static rdtIpv6Address := 5
}
struct RADIUS_ATTRIBUTE {
    dwAttrType : UInt32
    fDataType : RADIUS_DATA_TYPE
    cbDataLength : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwValue : UInt32
            lpValue : UInt8.Ptr
        }
    }
}
struct RADIUS_VSA_FORMAT {
    VendorId : UInt8[4]
    VendorType : UInt8
    VendorLength : UInt8
    AttributeSpecific : UInt8[1]
}
struct RADIUS_ACTION extends Int32 {
    static raContinue := 0
    static raReject := 1
    static raAccept := 2
}
struct PRADIUS_EXTENSION_INIT extends FunctionPointer {
    static Types := [UInt32]
}
struct PRADIUS_EXTENSION_TERM extends FunctionPointer {
    static Types := ["Void"]
}
struct PRADIUS_EXTENSION_PROCESS extends FunctionPointer {
    static Types := [RADIUS_ATTRIBUTE.Ptr, RADIUS_ACTION.Ptr, UInt32]
}
struct PRADIUS_EXTENSION_PROCESS_EX extends FunctionPointer {
    static Types := [RADIUS_ATTRIBUTE.Ptr, RADIUS_ATTRIBUTE.Ptr.Ptr, RADIUS_ACTION.Ptr, UInt32]
}
struct PRADIUS_EXTENSION_FREE_ATTRIBUTES extends FunctionPointer {
    static Types := [RADIUS_ATTRIBUTE.Ptr, "Void"]
}
struct RADIUS_EXTENSION_POINT extends Int32 {
    static repAuthentication := 0
    static repAuthorization := 1
}
struct RADIUS_ATTRIBUTE_ARRAY {
    cbSize : UInt32 := this.Size
    Add : IntPtr
    AttributeAt : IntPtr
    GetSize : IntPtr
    InsertAt : IntPtr
    RemoveAt : IntPtr
    SetAt : IntPtr
}
struct RADIUS_EXTENSION_CONTROL_BLOCK {
    cbSize : UInt32 := this.Size
    dwVersion : UInt32
    repPoint : RADIUS_EXTENSION_POINT
    rcRequestType : RADIUS_CODE
    rcResponseType : RADIUS_CODE
    GetRequest : IntPtr
    GetResponse : IntPtr
    SetResponseType : IntPtr
}
struct PRADIUS_EXTENSION_PROCESS_2 extends FunctionPointer {
    static Types := [RADIUS_EXTENSION_CONTROL_BLOCK.Ptr, UInt32]
}
