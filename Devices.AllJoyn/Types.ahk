#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PSTR}

struct alljoyn_about_announceflag extends Int32 {
    static UNANNOUNCED := 0
    static ANNOUNCED := 1
}
struct QStatus extends Int32 {
    static ER_OK := 0
    static ER_FAIL := 1
    static ER_UTF_CONVERSION_FAILED := 2
    static ER_BUFFER_TOO_SMALL := 3
    static ER_OS_ERROR := 4
    static ER_OUT_OF_MEMORY := 5
    static ER_SOCKET_BIND_ERROR := 6
    static ER_INIT_FAILED := 7
    static ER_WOULDBLOCK := 8
    static ER_NOT_IMPLEMENTED := 9
    static ER_TIMEOUT := 10
    static ER_SOCK_OTHER_END_CLOSED := 11
    static ER_BAD_ARG_1 := 12
    static ER_BAD_ARG_2 := 13
    static ER_BAD_ARG_3 := 14
    static ER_BAD_ARG_4 := 15
    static ER_BAD_ARG_5 := 16
    static ER_BAD_ARG_6 := 17
    static ER_BAD_ARG_7 := 18
    static ER_BAD_ARG_8 := 19
    static ER_INVALID_ADDRESS := 20
    static ER_INVALID_DATA := 21
    static ER_READ_ERROR := 22
    static ER_WRITE_ERROR := 23
    static ER_OPEN_FAILED := 24
    static ER_PARSE_ERROR := 25
    static ER_END_OF_DATA := 26
    static ER_CONN_REFUSED := 27
    static ER_BAD_ARG_COUNT := 28
    static ER_WARNING := 29
    static ER_EOF := 30
    static ER_DEADLOCK := 31
    static ER_COMMON_ERRORS := 4096
    static ER_STOPPING_THREAD := 4097
    static ER_ALERTED_THREAD := 4098
    static ER_XML_MALFORMED := 4099
    static ER_AUTH_FAIL := 4100
    static ER_AUTH_USER_REJECT := 4101
    static ER_NO_SUCH_ALARM := 4102
    static ER_TIMER_FALLBEHIND := 4103
    static ER_SSL_ERRORS := 4104
    static ER_SSL_INIT := 4105
    static ER_SSL_CONNECT := 4106
    static ER_SSL_VERIFY := 4107
    static ER_EXTERNAL_THREAD := 4108
    static ER_CRYPTO_ERROR := 4109
    static ER_CRYPTO_TRUNCATED := 4110
    static ER_CRYPTO_KEY_UNAVAILABLE := 4111
    static ER_BAD_HOSTNAME := 4112
    static ER_CRYPTO_KEY_UNUSABLE := 4113
    static ER_EMPTY_KEY_BLOB := 4114
    static ER_CORRUPT_KEYBLOB := 4115
    static ER_INVALID_KEY_ENCODING := 4116
    static ER_DEAD_THREAD := 4117
    static ER_THREAD_RUNNING := 4118
    static ER_THREAD_STOPPING := 4119
    static ER_BAD_STRING_ENCODING := 4120
    static ER_CRYPTO_INSUFFICIENT_SECURITY := 4121
    static ER_CRYPTO_ILLEGAL_PARAMETERS := 4122
    static ER_CRYPTO_HASH_UNINITIALIZED := 4123
    static ER_THREAD_NO_WAIT := 4124
    static ER_TIMER_EXITING := 4125
    static ER_INVALID_GUID := 4126
    static ER_THREADPOOL_EXHAUSTED := 4127
    static ER_THREADPOOL_STOPPING := 4128
    static ER_INVALID_STREAM := 4129
    static ER_TIMER_FULL := 4130
    static ER_IODISPATCH_STOPPING := 4131
    static ER_SLAP_INVALID_PACKET_LEN := 4132
    static ER_SLAP_HDR_CHECKSUM_ERROR := 4133
    static ER_SLAP_INVALID_PACKET_TYPE := 4134
    static ER_SLAP_LEN_MISMATCH := 4135
    static ER_SLAP_PACKET_TYPE_MISMATCH := 4136
    static ER_SLAP_CRC_ERROR := 4137
    static ER_SLAP_ERROR := 4138
    static ER_SLAP_OTHER_END_CLOSED := 4139
    static ER_TIMER_NOT_ALLOWED := 4140
    static ER_NOT_CONN := 4141
    static ER_XML_CONVERTER_ERROR := 8192
    static ER_XML_INVALID_RULES_COUNT := 8193
    static ER_XML_INTERFACE_MEMBERS_MISSING := 8194
    static ER_XML_INVALID_MEMBER_TYPE := 8195
    static ER_XML_INVALID_MEMBER_ACTION := 8196
    static ER_XML_MEMBER_DENY_ACTION_WITH_OTHER := 8197
    static ER_XML_INVALID_ANNOTATIONS_COUNT := 8198
    static ER_XML_INVALID_ELEMENT_NAME := 8199
    static ER_XML_INVALID_ATTRIBUTE_VALUE := 8200
    static ER_XML_INVALID_SECURITY_LEVEL_ANNOTATION_VALUE := 8201
    static ER_XML_INVALID_ELEMENT_CHILDREN_COUNT := 8202
    static ER_XML_INVALID_POLICY_VERSION := 8203
    static ER_XML_INVALID_POLICY_SERIAL_NUMBER := 8204
    static ER_XML_INVALID_ACL_PEER_TYPE := 8205
    static ER_XML_INVALID_ACL_PEER_CHILDREN_COUNT := 8206
    static ER_XML_ACL_ALL_TYPE_PEER_WITH_OTHERS := 8207
    static ER_XML_INVALID_ACL_PEER_PUBLIC_KEY := 8208
    static ER_XML_ACL_PEER_NOT_UNIQUE := 8209
    static ER_XML_ACL_PEER_PUBLIC_KEY_SET := 8210
    static ER_XML_ACLS_MISSING := 8211
    static ER_XML_ACL_PEERS_MISSING := 8212
    static ER_XML_INVALID_OBJECT_PATH := 8213
    static ER_XML_INVALID_INTERFACE_NAME := 8214
    static ER_XML_INVALID_MEMBER_NAME := 8215
    static ER_XML_INVALID_MANIFEST_VERSION := 8216
    static ER_XML_INVALID_OID := 8217
    static ER_XML_INVALID_BASE64 := 8218
    static ER_XML_INTERFACE_NAME_NOT_UNIQUE := 8219
    static ER_XML_MEMBER_NAME_NOT_UNIQUE := 8220
    static ER_XML_OBJECT_PATH_NOT_UNIQUE := 8221
    static ER_XML_ANNOTATION_NOT_UNIQUE := 8222
    static ER_NONE := 65535
    static ER_BUS_ERRORS := 36864
    static ER_BUS_READ_ERROR := 36865
    static ER_BUS_WRITE_ERROR := 36866
    static ER_BUS_BAD_VALUE_TYPE := 36867
    static ER_BUS_BAD_HEADER_FIELD := 36868
    static ER_BUS_BAD_SIGNATURE := 36869
    static ER_BUS_BAD_OBJ_PATH := 36870
    static ER_BUS_BAD_MEMBER_NAME := 36871
    static ER_BUS_BAD_INTERFACE_NAME := 36872
    static ER_BUS_BAD_ERROR_NAME := 36873
    static ER_BUS_BAD_BUS_NAME := 36874
    static ER_BUS_NAME_TOO_LONG := 36875
    static ER_BUS_BAD_LENGTH := 36876
    static ER_BUS_BAD_VALUE := 36877
    static ER_BUS_BAD_HDR_FLAGS := 36878
    static ER_BUS_BAD_BODY_LEN := 36879
    static ER_BUS_BAD_HEADER_LEN := 36880
    static ER_BUS_UNKNOWN_SERIAL := 36881
    static ER_BUS_UNKNOWN_PATH := 36882
    static ER_BUS_UNKNOWN_INTERFACE := 36883
    static ER_BUS_ESTABLISH_FAILED := 36884
    static ER_BUS_UNEXPECTED_SIGNATURE := 36885
    static ER_BUS_INTERFACE_MISSING := 36886
    static ER_BUS_PATH_MISSING := 36887
    static ER_BUS_MEMBER_MISSING := 36888
    static ER_BUS_REPLY_SERIAL_MISSING := 36889
    static ER_BUS_ERROR_NAME_MISSING := 36890
    static ER_BUS_INTERFACE_NO_SUCH_MEMBER := 36891
    static ER_BUS_NO_SUCH_OBJECT := 36892
    static ER_BUS_OBJECT_NO_SUCH_MEMBER := 36893
    static ER_BUS_OBJECT_NO_SUCH_INTERFACE := 36894
    static ER_BUS_NO_SUCH_INTERFACE := 36895
    static ER_BUS_MEMBER_NO_SUCH_SIGNATURE := 36896
    static ER_BUS_NOT_NUL_TERMINATED := 36897
    static ER_BUS_NO_SUCH_PROPERTY := 36898
    static ER_BUS_SET_WRONG_SIGNATURE := 36899
    static ER_BUS_PROPERTY_VALUE_NOT_SET := 36900
    static ER_BUS_PROPERTY_ACCESS_DENIED := 36901
    static ER_BUS_NO_TRANSPORTS := 36902
    static ER_BUS_BAD_TRANSPORT_ARGS := 36903
    static ER_BUS_NO_ROUTE := 36904
    static ER_BUS_NO_ENDPOINT := 36905
    static ER_BUS_BAD_SEND_PARAMETER := 36906
    static ER_BUS_UNMATCHED_REPLY_SERIAL := 36907
    static ER_BUS_BAD_SENDER_ID := 36908
    static ER_BUS_TRANSPORT_NOT_STARTED := 36909
    static ER_BUS_EMPTY_MESSAGE := 36910
    static ER_BUS_NOT_OWNER := 36911
    static ER_BUS_SET_PROPERTY_REJECTED := 36912
    static ER_BUS_CONNECT_FAILED := 36913
    static ER_BUS_REPLY_IS_ERROR_MESSAGE := 36914
    static ER_BUS_NOT_AUTHENTICATING := 36915
    static ER_BUS_NO_LISTENER := 36916
    static ER_BUS_NOT_ALLOWED := 36918
    static ER_BUS_WRITE_QUEUE_FULL := 36919
    static ER_BUS_ENDPOINT_CLOSING := 36920
    static ER_BUS_INTERFACE_MISMATCH := 36921
    static ER_BUS_MEMBER_ALREADY_EXISTS := 36922
    static ER_BUS_PROPERTY_ALREADY_EXISTS := 36923
    static ER_BUS_IFACE_ALREADY_EXISTS := 36924
    static ER_BUS_ERROR_RESPONSE := 36925
    static ER_BUS_BAD_XML := 36926
    static ER_BUS_BAD_CHILD_PATH := 36927
    static ER_BUS_OBJ_ALREADY_EXISTS := 36928
    static ER_BUS_OBJ_NOT_FOUND := 36929
    static ER_BUS_CANNOT_EXPAND_MESSAGE := 36930
    static ER_BUS_NOT_COMPRESSED := 36931
    static ER_BUS_ALREADY_CONNECTED := 36932
    static ER_BUS_NOT_CONNECTED := 36933
    static ER_BUS_ALREADY_LISTENING := 36934
    static ER_BUS_KEY_UNAVAILABLE := 36935
    static ER_BUS_TRUNCATED := 36936
    static ER_BUS_KEY_STORE_NOT_LOADED := 36937
    static ER_BUS_NO_AUTHENTICATION_MECHANISM := 36938
    static ER_BUS_BUS_ALREADY_STARTED := 36939
    static ER_BUS_BUS_NOT_STARTED := 36940
    static ER_BUS_KEYBLOB_OP_INVALID := 36941
    static ER_BUS_INVALID_HEADER_CHECKSUM := 36942
    static ER_BUS_MESSAGE_NOT_ENCRYPTED := 36943
    static ER_BUS_INVALID_HEADER_SERIAL := 36944
    static ER_BUS_TIME_TO_LIVE_EXPIRED := 36945
    static ER_BUS_HDR_EXPANSION_INVALID := 36946
    static ER_BUS_MISSING_COMPRESSION_TOKEN := 36947
    static ER_BUS_NO_PEER_GUID := 36948
    static ER_BUS_MESSAGE_DECRYPTION_FAILED := 36949
    static ER_BUS_SECURITY_FATAL := 36950
    static ER_BUS_KEY_EXPIRED := 36951
    static ER_BUS_CORRUPT_KEYSTORE := 36952
    static ER_BUS_NO_CALL_FOR_REPLY := 36953
    static ER_BUS_NOT_A_COMPLETE_TYPE := 36954
    static ER_BUS_POLICY_VIOLATION := 36955
    static ER_BUS_NO_SUCH_SERVICE := 36956
    static ER_BUS_TRANSPORT_NOT_AVAILABLE := 36957
    static ER_BUS_INVALID_AUTH_MECHANISM := 36958
    static ER_BUS_KEYSTORE_VERSION_MISMATCH := 36959
    static ER_BUS_BLOCKING_CALL_NOT_ALLOWED := 36960
    static ER_BUS_SIGNATURE_MISMATCH := 36961
    static ER_BUS_STOPPING := 36962
    static ER_BUS_METHOD_CALL_ABORTED := 36963
    static ER_BUS_CANNOT_ADD_INTERFACE := 36964
    static ER_BUS_CANNOT_ADD_HANDLER := 36965
    static ER_BUS_KEYSTORE_NOT_LOADED := 36966
    static ER_BUS_NO_SUCH_HANDLE := 36971
    static ER_BUS_HANDLES_NOT_ENABLED := 36972
    static ER_BUS_HANDLES_MISMATCH := 36973
    static ER_BUS_NO_SESSION := 36975
    static ER_BUS_ELEMENT_NOT_FOUND := 36976
    static ER_BUS_NOT_A_DICTIONARY := 36977
    static ER_BUS_WAIT_FAILED := 36978
    static ER_BUS_BAD_SESSION_OPTS := 36980
    static ER_BUS_CONNECTION_REJECTED := 36981
    static ER_DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER := 36982
    static ER_DBUS_REQUEST_NAME_REPLY_IN_QUEUE := 36983
    static ER_DBUS_REQUEST_NAME_REPLY_EXISTS := 36984
    static ER_DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER := 36985
    static ER_DBUS_RELEASE_NAME_REPLY_RELEASED := 36986
    static ER_DBUS_RELEASE_NAME_REPLY_NON_EXISTENT := 36987
    static ER_DBUS_RELEASE_NAME_REPLY_NOT_OWNER := 36988
    static ER_DBUS_START_REPLY_ALREADY_RUNNING := 36990
    static ER_ALLJOYN_BINDSESSIONPORT_REPLY_ALREADY_EXISTS := 36992
    static ER_ALLJOYN_BINDSESSIONPORT_REPLY_FAILED := 36993
    static ER_ALLJOYN_JOINSESSION_REPLY_NO_SESSION := 36995
    static ER_ALLJOYN_JOINSESSION_REPLY_UNREACHABLE := 36996
    static ER_ALLJOYN_JOINSESSION_REPLY_CONNECT_FAILED := 36997
    static ER_ALLJOYN_JOINSESSION_REPLY_REJECTED := 36998
    static ER_ALLJOYN_JOINSESSION_REPLY_BAD_SESSION_OPTS := 36999
    static ER_ALLJOYN_JOINSESSION_REPLY_FAILED := 37000
    static ER_ALLJOYN_LEAVESESSION_REPLY_NO_SESSION := 37002
    static ER_ALLJOYN_LEAVESESSION_REPLY_FAILED := 37003
    static ER_ALLJOYN_ADVERTISENAME_REPLY_TRANSPORT_NOT_AVAILABLE := 37004
    static ER_ALLJOYN_ADVERTISENAME_REPLY_ALREADY_ADVERTISING := 37005
    static ER_ALLJOYN_ADVERTISENAME_REPLY_FAILED := 37006
    static ER_ALLJOYN_CANCELADVERTISENAME_REPLY_FAILED := 37008
    static ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_TRANSPORT_NOT_AVAILABLE := 37009
    static ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_ALREADY_DISCOVERING := 37010
    static ER_ALLJOYN_FINDADVERTISEDNAME_REPLY_FAILED := 37011
    static ER_ALLJOYN_CANCELFINDADVERTISEDNAME_REPLY_FAILED := 37013
    static ER_BUS_UNEXPECTED_DISPOSITION := 37014
    static ER_BUS_INTERFACE_ACTIVATED := 37015
    static ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_BAD_PORT := 37016
    static ER_ALLJOYN_UNBINDSESSIONPORT_REPLY_FAILED := 37017
    static ER_ALLJOYN_BINDSESSIONPORT_REPLY_INVALID_OPTS := 37018
    static ER_ALLJOYN_JOINSESSION_REPLY_ALREADY_JOINED := 37019
    static ER_BUS_SELF_CONNECT := 37020
    static ER_BUS_SECURITY_NOT_ENABLED := 37021
    static ER_BUS_LISTENER_ALREADY_SET := 37022
    static ER_BUS_PEER_AUTH_VERSION_MISMATCH := 37023
    static ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NOT_SUPPORTED := 37024
    static ER_ALLJOYN_SETLINKTIMEOUT_REPLY_NO_DEST_SUPPORT := 37025
    static ER_ALLJOYN_SETLINKTIMEOUT_REPLY_FAILED := 37026
    static ER_ALLJOYN_ACCESS_PERMISSION_WARNING := 37027
    static ER_ALLJOYN_ACCESS_PERMISSION_ERROR := 37028
    static ER_BUS_DESTINATION_NOT_AUTHENTICATED := 37029
    static ER_BUS_ENDPOINT_REDIRECTED := 37030
    static ER_BUS_AUTHENTICATION_PENDING := 37031
    static ER_BUS_NOT_AUTHORIZED := 37032
    static ER_PACKET_BUS_NO_SUCH_CHANNEL := 37033
    static ER_PACKET_BAD_FORMAT := 37034
    static ER_PACKET_CONNECT_TIMEOUT := 37035
    static ER_PACKET_CHANNEL_FAIL := 37036
    static ER_PACKET_TOO_LARGE := 37037
    static ER_PACKET_BAD_PARAMETER := 37038
    static ER_PACKET_BAD_CRC := 37039
    static ER_RENDEZVOUS_SERVER_DEACTIVATED_USER := 37067
    static ER_RENDEZVOUS_SERVER_UNKNOWN_USER := 37068
    static ER_UNABLE_TO_CONNECT_TO_RENDEZVOUS_SERVER := 37069
    static ER_NOT_CONNECTED_TO_RENDEZVOUS_SERVER := 37070
    static ER_UNABLE_TO_SEND_MESSAGE_TO_RENDEZVOUS_SERVER := 37071
    static ER_INVALID_RENDEZVOUS_SERVER_INTERFACE_MESSAGE := 37072
    static ER_INVALID_PERSISTENT_CONNECTION_MESSAGE_RESPONSE := 37073
    static ER_INVALID_ON_DEMAND_CONNECTION_MESSAGE_RESPONSE := 37074
    static ER_INVALID_HTTP_METHOD_USED_FOR_RENDEZVOUS_SERVER_INTERFACE_MESSAGE := 37075
    static ER_RENDEZVOUS_SERVER_ERR500_INTERNAL_ERROR := 37076
    static ER_RENDEZVOUS_SERVER_ERR503_STATUS_UNAVAILABLE := 37077
    static ER_RENDEZVOUS_SERVER_ERR401_UNAUTHORIZED_REQUEST := 37078
    static ER_RENDEZVOUS_SERVER_UNRECOVERABLE_ERROR := 37079
    static ER_RENDEZVOUS_SERVER_ROOT_CERTIFICATE_UNINITIALIZED := 37080
    static ER_BUS_NO_SUCH_ANNOTATION := 37081
    static ER_BUS_ANNOTATION_ALREADY_EXISTS := 37082
    static ER_SOCK_CLOSING := 37083
    static ER_NO_SUCH_DEVICE := 37084
    static ER_P2P := 37085
    static ER_P2P_TIMEOUT := 37086
    static ER_P2P_NOT_CONNECTED := 37087
    static ER_BAD_TRANSPORT_MASK := 37088
    static ER_PROXIMITY_CONNECTION_ESTABLISH_FAIL := 37089
    static ER_PROXIMITY_NO_PEERS_FOUND := 37090
    static ER_BUS_OBJECT_NOT_REGISTERED := 37091
    static ER_P2P_DISABLED := 37092
    static ER_P2P_BUSY := 37093
    static ER_BUS_INCOMPATIBLE_DAEMON := 37094
    static ER_P2P_NO_GO := 37095
    static ER_P2P_NO_STA := 37096
    static ER_P2P_FORBIDDEN := 37097
    static ER_ALLJOYN_ONAPPSUSPEND_REPLY_FAILED := 37098
    static ER_ALLJOYN_ONAPPSUSPEND_REPLY_UNSUPPORTED := 37099
    static ER_ALLJOYN_ONAPPRESUME_REPLY_FAILED := 37100
    static ER_ALLJOYN_ONAPPRESUME_REPLY_UNSUPPORTED := 37101
    static ER_BUS_NO_SUCH_MESSAGE := 37102
    static ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_NO_SESSION := 37103
    static ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_BINDER := 37104
    static ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_MULTIPOINT := 37105
    static ER_ALLJOYN_REMOVESESSIONMEMBER_NOT_FOUND := 37106
    static ER_ALLJOYN_REMOVESESSIONMEMBER_INCOMPATIBLE_REMOTE_DAEMON := 37107
    static ER_ALLJOYN_REMOVESESSIONMEMBER_REPLY_FAILED := 37108
    static ER_BUS_REMOVED_BY_BINDER := 37109
    static ER_BUS_MATCH_RULE_NOT_FOUND := 37110
    static ER_ALLJOYN_PING_FAILED := 37111
    static ER_ALLJOYN_PING_REPLY_UNREACHABLE := 37112
    static ER_UDP_MSG_TOO_LONG := 37113
    static ER_UDP_DEMUX_NO_ENDPOINT := 37114
    static ER_UDP_NO_NETWORK := 37115
    static ER_UDP_UNEXPECTED_LENGTH := 37116
    static ER_UDP_UNEXPECTED_FLOW := 37117
    static ER_UDP_DISCONNECT := 37118
    static ER_UDP_NOT_IMPLEMENTED := 37119
    static ER_UDP_NO_LISTENER := 37120
    static ER_UDP_STOPPING := 37121
    static ER_ARDP_BACKPRESSURE := 37122
    static ER_UDP_BACKPRESSURE := 37123
    static ER_ARDP_INVALID_STATE := 37124
    static ER_ARDP_TTL_EXPIRED := 37125
    static ER_ARDP_PERSIST_TIMEOUT := 37126
    static ER_ARDP_PROBE_TIMEOUT := 37127
    static ER_ARDP_REMOTE_CONNECTION_RESET := 37128
    static ER_UDP_BUSHELLO := 37129
    static ER_UDP_MESSAGE := 37130
    static ER_UDP_INVALID := 37131
    static ER_UDP_UNSUPPORTED := 37132
    static ER_UDP_ENDPOINT_STALLED := 37133
    static ER_ARDP_INVALID_RESPONSE := 37134
    static ER_ARDP_INVALID_CONNECTION := 37135
    static ER_UDP_LOCAL_DISCONNECT := 37136
    static ER_UDP_EARLY_EXIT := 37137
    static ER_UDP_LOCAL_DISCONNECT_FAIL := 37138
    static ER_ARDP_DISCONNECTING := 37139
    static ER_ALLJOYN_PING_REPLY_INCOMPATIBLE_REMOTE_ROUTING_NODE := 37140
    static ER_ALLJOYN_PING_REPLY_TIMEOUT := 37141
    static ER_ALLJOYN_PING_REPLY_UNKNOWN_NAME := 37142
    static ER_ALLJOYN_PING_REPLY_FAILED := 37143
    static ER_TCP_MAX_UNTRUSTED := 37144
    static ER_ALLJOYN_PING_REPLY_IN_PROGRESS := 37145
    static ER_LANGUAGE_NOT_SUPPORTED := 37146
    static ER_ABOUT_FIELD_ALREADY_SPECIFIED := 37147
    static ER_UDP_NOT_DISCONNECTED := 37148
    static ER_UDP_ENDPOINT_NOT_STARTED := 37149
    static ER_UDP_ENDPOINT_REMOVED := 37150
    static ER_ARDP_VERSION_NOT_SUPPORTED := 37151
    static ER_CONNECTION_LIMIT_EXCEEDED := 37152
    static ER_ARDP_WRITE_BLOCKED := 37153
    static ER_PERMISSION_DENIED := 37154
    static ER_ABOUT_DEFAULT_LANGUAGE_NOT_SPECIFIED := 37155
    static ER_ABOUT_SESSIONPORT_NOT_BOUND := 37156
    static ER_ABOUT_ABOUTDATA_MISSING_REQUIRED_FIELD := 37157
    static ER_ABOUT_INVALID_ABOUTDATA_LISTENER := 37158
    static ER_BUS_PING_GROUP_NOT_FOUND := 37159
    static ER_BUS_REMOVED_BY_BINDER_SELF := 37160
    static ER_INVALID_CONFIG := 37161
    static ER_ABOUT_INVALID_ABOUTDATA_FIELD_VALUE := 37162
    static ER_ABOUT_INVALID_ABOUTDATA_FIELD_APPID_SIZE := 37163
    static ER_BUS_TRANSPORT_ACCESS_DENIED := 37164
    static ER_INVALID_CERTIFICATE := 37165
    static ER_CERTIFICATE_NOT_FOUND := 37166
    static ER_DUPLICATE_CERTIFICATE := 37167
    static ER_UNKNOWN_CERTIFICATE := 37168
    static ER_MISSING_DIGEST_IN_CERTIFICATE := 37169
    static ER_DIGEST_MISMATCH := 37170
    static ER_DUPLICATE_KEY := 37171
    static ER_NO_COMMON_TRUST := 37172
    static ER_MANIFEST_NOT_FOUND := 37173
    static ER_INVALID_CERT_CHAIN := 37174
    static ER_NO_TRUST_ANCHOR := 37175
    static ER_INVALID_APPLICATION_STATE := 37176
    static ER_FEATURE_NOT_AVAILABLE := 37177
    static ER_KEY_STORE_ALREADY_INITIALIZED := 37178
    static ER_KEY_STORE_ID_NOT_YET_SET := 37179
    static ER_POLICY_NOT_NEWER := 37180
    static ER_MANIFEST_REJECTED := 37181
    static ER_INVALID_CERTIFICATE_USAGE := 37182
    static ER_INVALID_SIGNAL_EMISSION_TYPE := 37183
    static ER_APPLICATION_STATE_LISTENER_ALREADY_EXISTS := 37184
    static ER_APPLICATION_STATE_LISTENER_NO_SUCH_LISTENER := 37185
    static ER_MANAGEMENT_ALREADY_STARTED := 37186
    static ER_MANAGEMENT_NOT_STARTED := 37187
    static ER_BUS_DESCRIPTION_ALREADY_EXISTS := 37188
}
struct alljoyn_typeid extends Int32 {
    static ALLJOYN_INVALID := 0
    static ALLJOYN_ARRAY := 97
    static ALLJOYN_BOOLEAN := 98
    static ALLJOYN_DOUBLE := 100
    static ALLJOYN_DICT_ENTRY := 101
    static ALLJOYN_SIGNATURE := 103
    static ALLJOYN_HANDLE := 104
    static ALLJOYN_INT32 := 105
    static ALLJOYN_INT16 := 110
    static ALLJOYN_OBJECT_PATH := 111
    static ALLJOYN_UINT16 := 113
    static ALLJOYN_STRUCT := 114
    static ALLJOYN_STRING := 115
    static ALLJOYN_UINT64 := 116
    static ALLJOYN_UINT32 := 117
    static ALLJOYN_VARIANT := 118
    static ALLJOYN_INT64 := 120
    static ALLJOYN_BYTE := 121
    static ALLJOYN_STRUCT_OPEN := 40
    static ALLJOYN_STRUCT_CLOSE := 41
    static ALLJOYN_DICT_ENTRY_OPEN := 123
    static ALLJOYN_DICT_ENTRY_CLOSE := 125
    static ALLJOYN_BOOLEAN_ARRAY := 25185
    static ALLJOYN_DOUBLE_ARRAY := 25697
    static ALLJOYN_INT32_ARRAY := 26977
    static ALLJOYN_INT16_ARRAY := 28257
    static ALLJOYN_UINT16_ARRAY := 29025
    static ALLJOYN_UINT64_ARRAY := 29793
    static ALLJOYN_UINT32_ARRAY := 30049
    static ALLJOYN_INT64_ARRAY := 30817
    static ALLJOYN_BYTE_ARRAY := 31073
    static ALLJOYN_WILDCARD := 42
}
struct alljoyn_applicationstate extends Int32 {
    static NOT_CLAIMABLE := 0
    static CLAIMABLE := 1
    static CLAIMED := 2
    static NEED_UPDATE := 3
}
struct alljoyn_claimcapability_masks extends Int32 {
    static CAPABLE_ECDHE_NULL := 1
    static CAPABLE_ECDHE_ECDSA := 4
    static CAPABLE_ECDHE_SPEKE := 8
}
struct alljoyn_claimcapabilityadditionalinfo_masks extends Int32 {
    static PASSWORD_GENERATED_BY_SECURITY_MANAGER := 1
    static PASSWORD_GENERATED_BY_APPLICATION := 2
}
struct alljoyn_certificateid {
    serial : UInt8.Ptr
    serialLen : IntPtr
    issuerPublicKey : Int8.Ptr
    issuerAki : UInt8.Ptr
    issuerAkiLen : IntPtr
}
struct alljoyn_certificateidarray {
    count : IntPtr
    ids : alljoyn_certificateid.Ptr
}
struct alljoyn_manifestarray {
    count : IntPtr
    xmls : Int8.Ptr.Ptr
}
struct alljoyn_applicationstatelistener_state_ptr extends FunctionPointer {
    static Types := [Int8.Ptr, Int8.Ptr, alljoyn_applicationstate, Struct.Ptr, "Void"]
}
struct alljoyn_applicationstatelistener_callbacks {
    state : alljoyn_applicationstatelistener_state_ptr
}
struct alljoyn_keystorelistener_loadrequest_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_keystorelistener, alljoyn_keystore, QStatus]
}
struct alljoyn_keystorelistener_storerequest_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_keystorelistener, alljoyn_keystore, QStatus]
}
struct alljoyn_keystorelistener_acquireexclusivelock_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_keystorelistener, QStatus]
}
struct alljoyn_keystorelistener_releaseexclusivelock_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_keystorelistener, "Void"]
}
struct alljoyn_keystorelistener_callbacks {
    load_request : alljoyn_keystorelistener_loadrequest_ptr
    store_request : alljoyn_keystorelistener_storerequest_ptr
}
struct alljoyn_keystorelistener_with_synchronization_callbacks {
    load_request : alljoyn_keystorelistener_loadrequest_ptr
    store_request : alljoyn_keystorelistener_storerequest_ptr
    acquire_exclusive_lock : alljoyn_keystorelistener_acquireexclusivelock_ptr
    release_exclusive_lock : alljoyn_keystorelistener_releaseexclusivelock_ptr
}
struct alljoyn_messagetype extends Int32 {
    static ALLJOYN_MESSAGE_INVALID := 0
    static ALLJOYN_MESSAGE_METHOD_CALL := 1
    static ALLJOYN_MESSAGE_METHOD_RET := 2
    static ALLJOYN_MESSAGE_ERROR := 3
    static ALLJOYN_MESSAGE_SIGNAL := 4
}
struct alljoyn_authlistener_requestcredentials_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, UInt16, PSTR, UInt16, alljoyn_credentials, Int32]
}
struct alljoyn_authlistener_requestcredentialsasync_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_authlistener, PSTR, PSTR, UInt16, PSTR, UInt16, Struct.Ptr, QStatus]
}
struct alljoyn_authlistener_verifycredentials_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, alljoyn_credentials, Int32]
}
struct alljoyn_authlistener_verifycredentialsasync_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_authlistener, PSTR, PSTR, alljoyn_credentials, Struct.Ptr, QStatus]
}
struct alljoyn_authlistener_securityviolation_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, QStatus, alljoyn_message, "Void"]
}
struct alljoyn_authlistener_authenticationcomplete_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, Int32, "Void"]
}
struct alljoyn_authlistener_callbacks {
    request_credentials : alljoyn_authlistener_requestcredentials_ptr
    verify_credentials : alljoyn_authlistener_verifycredentials_ptr
    security_violation : alljoyn_authlistener_securityviolation_ptr
    authentication_complete : alljoyn_authlistener_authenticationcomplete_ptr
}
struct alljoyn_authlistenerasync_callbacks {
    request_credentials : alljoyn_authlistener_requestcredentialsasync_ptr
    verify_credentials : alljoyn_authlistener_verifycredentialsasync_ptr
    security_violation : alljoyn_authlistener_securityviolation_ptr
    authentication_complete : alljoyn_authlistener_authenticationcomplete_ptr
}
struct alljoyn_buslistener_listener_registered_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_busattachment, "Void"]
}
struct alljoyn_buslistener_listener_unregistered_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_buslistener_found_advertised_name_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt16, PSTR, "Void"]
}
struct alljoyn_buslistener_lost_advertised_name_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt16, PSTR, "Void"]
}
struct alljoyn_buslistener_name_owner_changed_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, PSTR, "Void"]
}
struct alljoyn_buslistener_bus_stopping_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_buslistener_bus_disconnected_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_buslistener_bus_prop_changed_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, alljoyn_msgarg, "Void"]
}
struct alljoyn_buslistener_callbacks {
    listener_registered : alljoyn_buslistener_listener_registered_ptr
    listener_unregistered : alljoyn_buslistener_listener_unregistered_ptr
    found_advertised_name : alljoyn_buslistener_found_advertised_name_ptr
    lost_advertised_name : alljoyn_buslistener_lost_advertised_name_ptr
    name_owner_changed : alljoyn_buslistener_name_owner_changed_ptr
    bus_stopping : alljoyn_buslistener_bus_stopping_ptr
    bus_disconnected : alljoyn_buslistener_bus_disconnected_ptr
    property_changed : alljoyn_buslistener_bus_prop_changed_ptr
}
struct alljoyn_interfacedescription_securitypolicy extends Int32 {
    static AJ_IFC_SECURITY_INHERIT := 0
    static AJ_IFC_SECURITY_REQUIRED := 1
    static AJ_IFC_SECURITY_OFF := 2
}
struct alljoyn_interfacedescription_member {
    iface : alljoyn_interfacedescription
    memberType : alljoyn_messagetype
    name : PSTR
    signature : PSTR
    returnSignature : PSTR
    argNames : PSTR
    internal_member : Struct.Ptr
}
struct alljoyn_interfacedescription_translation_callback_ptr extends FunctionPointer {
    static Types := [PSTR, PSTR, PSTR, PSTR]
}
struct alljoyn_interfacedescription_property {
    name : PSTR
    signature : PSTR
    access : UInt8
    internal_property : Struct.Ptr
}
struct alljoyn_messagereceiver_methodhandler_ptr extends FunctionPointer {
    static Types := [alljoyn_busobject, alljoyn_interfacedescription_member.Ptr, alljoyn_message, "Void"]
}
struct alljoyn_messagereceiver_replyhandler_ptr extends FunctionPointer {
    static Types := [alljoyn_message, Struct.Ptr, "Void"]
}
struct alljoyn_messagereceiver_signalhandler_ptr extends FunctionPointer {
    static Types := [alljoyn_interfacedescription_member.Ptr, PSTR, alljoyn_message, "Void"]
}
struct alljoyn_busobject_prop_get_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, alljoyn_msgarg, QStatus]
}
struct alljoyn_busobject_prop_set_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, alljoyn_msgarg, QStatus]
}
struct alljoyn_busobject_object_registration_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_busobject_callbacks {
    property_get : alljoyn_busobject_prop_get_ptr
    property_set : alljoyn_busobject_prop_set_ptr
    object_registered : alljoyn_busobject_object_registration_ptr
    object_unregistered : alljoyn_busobject_object_registration_ptr
}
struct alljoyn_busobject_methodentry {
    member : alljoyn_interfacedescription_member.Ptr
    method_handler : alljoyn_messagereceiver_methodhandler_ptr
}
struct alljoyn_proxybusobject_listener_introspectcb_ptr extends FunctionPointer {
    static Types := [QStatus, alljoyn_proxybusobject, Struct.Ptr, "Void"]
}
struct alljoyn_proxybusobject_listener_getpropertycb_ptr extends FunctionPointer {
    static Types := [QStatus, alljoyn_proxybusobject, alljoyn_msgarg, Struct.Ptr, "Void"]
}
struct alljoyn_proxybusobject_listener_getallpropertiescb_ptr extends FunctionPointer {
    static Types := [QStatus, alljoyn_proxybusobject, alljoyn_msgarg, Struct.Ptr, "Void"]
}
struct alljoyn_proxybusobject_listener_setpropertycb_ptr extends FunctionPointer {
    static Types := [QStatus, alljoyn_proxybusobject, Struct.Ptr, "Void"]
}
struct alljoyn_proxybusobject_listener_propertieschanged_ptr extends FunctionPointer {
    static Types := [alljoyn_proxybusobject, PSTR, alljoyn_msgarg, alljoyn_msgarg, Struct.Ptr, "Void"]
}
struct alljoyn_permissionconfigurationlistener_factoryreset_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, QStatus]
}
struct alljoyn_permissionconfigurationlistener_policychanged_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_permissionconfigurationlistener_startmanagement_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_permissionconfigurationlistener_endmanagement_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct alljoyn_permissionconfigurationlistener_callbacks {
    factory_reset : alljoyn_permissionconfigurationlistener_factoryreset_ptr
    policy_changed : alljoyn_permissionconfigurationlistener_policychanged_ptr
    start_management : alljoyn_permissionconfigurationlistener_startmanagement_ptr
    end_management : alljoyn_permissionconfigurationlistener_endmanagement_ptr
}
struct alljoyn_sessionlostreason extends Int32 {
    static ALLJOYN_SESSIONLOST_INVALID := 0
    static ALLJOYN_SESSIONLOST_REMOTE_END_LEFT_SESSION := 1
    static ALLJOYN_SESSIONLOST_REMOTE_END_CLOSED_ABRUPTLY := 2
    static ALLJOYN_SESSIONLOST_REMOVED_BY_BINDER := 3
    static ALLJOYN_SESSIONLOST_LINK_TIMEOUT := 4
    static ALLJOYN_SESSIONLOST_REASON_OTHER := 5
}
struct alljoyn_sessionlistener_sessionlost_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, alljoyn_sessionlostreason, "Void"]
}
struct alljoyn_sessionlistener_sessionmemberadded_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PSTR, "Void"]
}
struct alljoyn_sessionlistener_sessionmemberremoved_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PSTR, "Void"]
}
struct alljoyn_sessionlistener_callbacks {
    session_lost : alljoyn_sessionlistener_sessionlost_ptr
    session_member_added : alljoyn_sessionlistener_sessionmemberadded_ptr
    session_member_removed : alljoyn_sessionlistener_sessionmemberremoved_ptr
}
struct alljoyn_sessionportlistener_acceptsessionjoiner_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16, PSTR, alljoyn_sessionopts, Int32]
}
struct alljoyn_sessionportlistener_sessionjoined_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16, UInt32, PSTR, "Void"]
}
struct alljoyn_sessionportlistener_callbacks {
    accept_session_joiner : alljoyn_sessionportlistener_acceptsessionjoiner_ptr
    session_joined : alljoyn_sessionportlistener_sessionjoined_ptr
}
struct alljoyn_about_announced_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt16, UInt16, alljoyn_msgarg, alljoyn_msgarg, "Void"]
}
struct alljoyn_aboutlistener_callback {
    about_listener_announced : alljoyn_about_announced_ptr
}
struct alljoyn_busattachment_joinsessioncb_ptr extends FunctionPointer {
    static Types := [QStatus, UInt32, alljoyn_sessionopts, Struct.Ptr, "Void"]
}
struct alljoyn_busattachment_setlinktimeoutcb_ptr extends FunctionPointer {
    static Types := [QStatus, UInt32, Struct.Ptr, "Void"]
}
struct alljoyn_aboutdatalistener_getaboutdata_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_msgarg, PSTR, QStatus]
}
struct alljoyn_aboutdatalistener_getannouncedaboutdata_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_msgarg, QStatus]
}
struct alljoyn_aboutdatalistener_callbacks {
    about_datalistener_getaboutdata : alljoyn_aboutdatalistener_getaboutdata_ptr
    about_datalistener_getannouncedaboutdata : alljoyn_aboutdatalistener_getannouncedaboutdata_ptr
}
struct alljoyn_autopinger_destination_lost_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, "Void"]
}
struct alljoyn_autopinger_destination_found_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, PSTR, "Void"]
}
struct alljoyn_pinglistener_callback {
    destination_found : alljoyn_autopinger_destination_found_ptr
    destination_lost : alljoyn_autopinger_destination_lost_ptr
}
struct alljoyn_observer_object_discovered_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_proxybusobject_ref, "Void"]
}
struct alljoyn_observer_object_lost_ptr extends FunctionPointer {
    static Types := [Struct.Ptr, alljoyn_proxybusobject_ref, "Void"]
}
struct alljoyn_observerlistener_callback {
    object_discovered : alljoyn_observer_object_discovered_ptr
    object_lost : alljoyn_observer_object_lost_ptr
}
struct alljoyn_aboutdata {
    Value : IntPtr
}
struct alljoyn_aboutdatalistener {
    Value : IntPtr
}
struct alljoyn_abouticon {
    Value : IntPtr
}
struct alljoyn_abouticonobj {
    Value : IntPtr
}
struct alljoyn_abouticonproxy {
    Value : IntPtr
}
struct alljoyn_aboutlistener {
    Value : IntPtr
}
struct alljoyn_aboutobj {
    Value : IntPtr
}
struct alljoyn_aboutobjectdescription {
    Value : IntPtr
}
struct alljoyn_aboutproxy {
    Value : IntPtr
}
struct alljoyn_applicationstatelistener {
    Value : IntPtr
}
struct alljoyn_authlistener {
    Value : IntPtr
}
struct alljoyn_autopinger {
    Value : IntPtr
}
struct alljoyn_busattachment {
    Value : IntPtr
}
struct alljoyn_buslistener {
    Value : IntPtr
}
struct alljoyn_busobject {
    Value : IntPtr
}
struct alljoyn_credentials {
    Value : IntPtr
}
struct alljoyn_interfacedescription {
    Value : IntPtr
}
struct alljoyn_keystore {
    Value : IntPtr
}
struct alljoyn_keystorelistener {
    Value : IntPtr
}
struct alljoyn_message {
    Value : IntPtr
}
struct alljoyn_msgarg {
    Value : IntPtr
}
struct alljoyn_observer {
    Value : IntPtr
}
struct alljoyn_observerlistener {
    Value : IntPtr
}
struct alljoyn_permissionconfigurationlistener {
    Value : IntPtr
}
struct alljoyn_permissionconfigurator {
    Value : IntPtr
}
struct alljoyn_pinglistener {
    Value : IntPtr
}
struct alljoyn_proxybusobject {
    Value : IntPtr
}
struct alljoyn_proxybusobject_ref {
    Value : IntPtr
}
struct alljoyn_securityapplicationproxy {
    Value : IntPtr
}
struct alljoyn_sessionlistener {
    Value : IntPtr
}
struct alljoyn_sessionopts {
    Value : IntPtr
}
struct alljoyn_sessionportlistener {
    Value : IntPtr
}
