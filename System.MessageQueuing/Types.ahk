#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HANDLE, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct MQQUEUEACCESSMASK extends UInt32 {
    static MQSEC_DELETE_QUEUE := 65536
    static MQSEC_GET_QUEUE_PERMISSIONS := 131072
    static MQSEC_CHANGE_QUEUE_PERMISSIONS := 262144
    static MQSEC_TAKE_QUEUE_OWNERSHIP := 524288
    static MQSEC_RECEIVE_MESSAGE := 3
    static MQSEC_RECEIVE_JOURNAL_MESSAGE := 10
    static MQSEC_QUEUE_GENERIC_READ := 131115
    static MQSEC_QUEUE_GENERIC_WRITE := 131108
    static MQSEC_QUEUE_GENERIC_ALL := 983103
    static MQSEC_DELETE_MESSAGE := 1
    static MQSEC_PEEK_MESSAGE := 2
    static MQSEC_WRITE_MESSAGE := 4
    static MQSEC_DELETE_JOURNAL_MESSAGE := 8
    static MQSEC_SET_QUEUE_PROPERTIES := 16
    static MQSEC_GET_QUEUE_PROPERTIES := 32
    static MQSEC_QUEUE_GENERIC_EXECUTE := 0
}
struct MQCALG extends Int32 {
    static MQMSG_CALG_MD2 := 32769
    static MQMSG_CALG_MD4 := 32770
    static MQMSG_CALG_MD5 := 32771
    static MQMSG_CALG_SHA := 32772
    static MQMSG_CALG_SHA1 := 32772
    static MQMSG_CALG_MAC := 32773
    static MQMSG_CALG_RSA_SIGN := 9216
    static MQMSG_CALG_DSS_SIGN := 8704
    static MQMSG_CALG_RSA_KEYX := 41984
    static MQMSG_CALG_DES := 26113
    static MQMSG_CALG_RC2 := 26114
    static MQMSG_CALG_RC4 := 26625
    static MQMSG_CALG_SEAL := 26626
}
struct MQTRANSACTION extends Int32 {
    static MQ_NO_TRANSACTION := 0
    static MQ_MTS_TRANSACTION := 1
    static MQ_XA_TRANSACTION := 2
    static MQ_SINGLE_MESSAGE := 3
}
struct RELOPS extends Int32 {
    static REL_NOP := 0
    static REL_EQ := 1
    static REL_NEQ := 2
    static REL_LT := 3
    static REL_GT := 4
    static REL_LE := 5
    static REL_GE := 6
}
struct MQCERT_REGISTER extends Int32 {
    static MQCERT_REGISTER_ALWAYS := 1
    static MQCERT_REGISTER_IF_NOT_EXIST := 2
}
struct MQMSGCURSOR extends Int32 {
    static MQMSG_FIRST := 0
    static MQMSG_CURRENT := 1
    static MQMSG_NEXT := 2
}
struct MQMSGCLASS extends Int32 {
    static MQMSG_CLASS_NORMAL := 0
    static MQMSG_CLASS_REPORT := 1
    static MQMSG_CLASS_ACK_REACH_QUEUE := 2
    static MQMSG_CLASS_ACK_RECEIVE := 16384
    static MQMSG_CLASS_NACK_BAD_DST_Q := 32768
    static MQMSG_CLASS_NACK_PURGED := 32769
    static MQMSG_CLASS_NACK_REACH_QUEUE_TIMEOUT := 32770
    static MQMSG_CLASS_NACK_Q_EXCEED_QUOTA := 32771
    static MQMSG_CLASS_NACK_ACCESS_DENIED := 32772
    static MQMSG_CLASS_NACK_HOP_COUNT_EXCEEDED := 32773
    static MQMSG_CLASS_NACK_BAD_SIGNATURE := 32774
    static MQMSG_CLASS_NACK_BAD_ENCRYPTION := 32775
    static MQMSG_CLASS_NACK_COULD_NOT_ENCRYPT := 32776
    static MQMSG_CLASS_NACK_NOT_TRANSACTIONAL_Q := 32777
    static MQMSG_CLASS_NACK_NOT_TRANSACTIONAL_MSG := 32778
    static MQMSG_CLASS_NACK_UNSUPPORTED_CRYPTO_PROVIDER := 32779
    static MQMSG_CLASS_NACK_SOURCE_COMPUTER_GUID_CHANGED := 32780
    static MQMSG_CLASS_NACK_Q_DELETED := 49152
    static MQMSG_CLASS_NACK_Q_PURGED := 49153
    static MQMSG_CLASS_NACK_RECEIVE_TIMEOUT := 49154
    static MQMSG_CLASS_NACK_RECEIVE_TIMEOUT_AT_SENDER := 49155
}
struct MQMSGDELIVERY extends Int32 {
    static MQMSG_DELIVERY_EXPRESS := 0
    static MQMSG_DELIVERY_RECOVERABLE := 1
}
struct MQMSGACKNOWLEDGEMENT extends Int32 {
    static MQMSG_ACKNOWLEDGMENT_NONE := 0
    static MQMSG_ACKNOWLEDGMENT_POS_ARRIVAL := 1
    static MQMSG_ACKNOWLEDGMENT_POS_RECEIVE := 2
    static MQMSG_ACKNOWLEDGMENT_NEG_ARRIVAL := 4
    static MQMSG_ACKNOWLEDGMENT_NEG_RECEIVE := 8
    static MQMSG_ACKNOWLEDGMENT_NACK_REACH_QUEUE := 4
    static MQMSG_ACKNOWLEDGMENT_FULL_REACH_QUEUE := 5
    static MQMSG_ACKNOWLEDGMENT_NACK_RECEIVE := 12
    static MQMSG_ACKNOWLEDGMENT_FULL_RECEIVE := 14
}
struct MQMSGJOURNAL extends Int32 {
    static MQMSG_JOURNAL_NONE := 0
    static MQMSG_DEADLETTER := 1
    static MQMSG_JOURNAL := 2
}
struct MQMSGTRACE extends Int32 {
    static MQMSG_TRACE_NONE := 0
    static MQMSG_SEND_ROUTE_TO_REPORT_QUEUE := 1
}
struct MQMSGSENDERIDTYPE extends Int32 {
    static MQMSG_SENDERID_TYPE_NONE := 0
    static MQMSG_SENDERID_TYPE_SID := 1
}
struct MQMSGPRIVLEVEL extends Int32 {
    static MQMSG_PRIV_LEVEL_NONE := 0
    static MQMSG_PRIV_LEVEL_BODY_BASE := 1
    static MQMSG_PRIV_LEVEL_BODY_ENHANCED := 3
}
struct MQMSGAUTHLEVEL extends Int32 {
    static MQMSG_AUTH_LEVEL_NONE := 0
    static MQMSG_AUTH_LEVEL_ALWAYS := 1
    static MQMSG_AUTH_LEVEL_MSMQ10 := 2
    static MQMSG_AUTH_LEVEL_SIG10 := 2
    static MQMSG_AUTH_LEVEL_MSMQ20 := 4
    static MQMSG_AUTH_LEVEL_SIG20 := 4
    static MQMSG_AUTH_LEVEL_SIG30 := 8
}
struct MQMSGIDSIZE extends Int32 {
    static MQMSG_MSGID_SIZE := 20
    static MQMSG_CORRELATIONID_SIZE := 20
    static MQMSG_XACTID_SIZE := 20
}
struct MQMSGMAX extends Int32 {
    static MQ_MAX_MSG_LABEL_LEN := 249
}
struct MQMSGAUTHENTICATION extends Int32 {
    static MQMSG_AUTHENTICATION_NOT_REQUESTED := 0
    static MQMSG_AUTHENTICATION_REQUESTED := 1
    static MQMSG_AUTHENTICATED_SIG10 := 1
    static MQMSG_AUTHENTICATION_REQUESTED_EX := 3
    static MQMSG_AUTHENTICATED_SIG20 := 3
    static MQMSG_AUTHENTICATED_SIG30 := 5
    static MQMSG_AUTHENTICATED_SIGXML := 9
}
struct MQSHARE extends Int32 {
    static MQ_DENY_NONE := 0
    static MQ_DENY_RECEIVE_SHARE := 1
}
struct MQACCESS extends Int32 {
    static MQ_RECEIVE_ACCESS := 1
    static MQ_SEND_ACCESS := 2
    static MQ_PEEK_ACCESS := 32
    static MQ_ADMIN_ACCESS := 128
}
struct MQJOURNAL extends Int32 {
    static MQ_JOURNAL_NONE := 0
    static MQ_JOURNAL := 1
}
struct MQTRANSACTIONAL extends Int32 {
    static MQ_TRANSACTIONAL_NONE := 0
    static MQ_TRANSACTIONAL := 1
}
struct MQAUTHENTICATE extends Int32 {
    static MQ_AUTHENTICATE_NONE := 0
    static MQ_AUTHENTICATE := 1
}
struct MQPRIVLEVEL extends Int32 {
    static MQ_PRIV_LEVEL_NONE := 0
    static MQ_PRIV_LEVEL_OPTIONAL := 1
    static MQ_PRIV_LEVEL_BODY := 2
}
struct MQPRIORITY extends Int32 {
    static MQ_MIN_PRIORITY := 0
    static MQ_MAX_PRIORITY := 7
}
struct MQMAX extends Int32 {
    static MQ_MAX_Q_NAME_LEN := 124
    static MQ_MAX_Q_LABEL_LEN := 124
}
struct QUEUE_TYPE extends Int32 {
    static MQ_TYPE_PUBLIC := 0
    static MQ_TYPE_PRIVATE := 1
    static MQ_TYPE_MACHINE := 2
    static MQ_TYPE_CONNECTOR := 3
    static MQ_TYPE_MULTICAST := 4
}
struct FOREIGN_STATUS extends Int32 {
    static MQ_STATUS_FOREIGN := 0
    static MQ_STATUS_NOT_FOREIGN := 1
    static MQ_STATUS_UNKNOWN := 2
}
struct XACT_STATUS extends Int32 {
    static MQ_XACT_STATUS_XACT := 0
    static MQ_XACT_STATUS_NOT_XACT := 1
    static MQ_XACT_STATUS_UNKNOWN := 2
}
struct QUEUE_STATE extends Int32 {
    static MQ_QUEUE_STATE_LOCAL_CONNECTION := 0
    static MQ_QUEUE_STATE_DISCONNECTED := 1
    static MQ_QUEUE_STATE_WAITING := 2
    static MQ_QUEUE_STATE_NEEDVALIDATE := 3
    static MQ_QUEUE_STATE_ONHOLD := 4
    static MQ_QUEUE_STATE_NONACTIVE := 5
    static MQ_QUEUE_STATE_CONNECTED := 6
    static MQ_QUEUE_STATE_DISCONNECTING := 7
    static MQ_QUEUE_STATE_LOCKED := 8
}
struct MQDEFAULT extends Int32 {
    static DEFAULT_M_PRIORITY := 3
    static DEFAULT_M_DELIVERY := 0
    static DEFAULT_M_ACKNOWLEDGE := 0
    static DEFAULT_M_JOURNAL := 0
    static DEFAULT_M_APPSPECIFIC := 0
    static DEFAULT_M_PRIV_LEVEL := 0
    static DEFAULT_M_AUTH_LEVEL := 0
    static DEFAULT_M_SENDERID_TYPE := 1
    static DEFAULT_Q_JOURNAL := 0
    static DEFAULT_Q_BASEPRIORITY := 0
    static DEFAULT_Q_QUOTA := -1
    static DEFAULT_Q_JOURNAL_QUOTA := -1
    static DEFAULT_Q_TRANSACTION := 0
    static DEFAULT_Q_AUTHENTICATE := 0
    static DEFAULT_Q_PRIV_LEVEL := 1
    static DEFAULT_M_LOOKUPID := 0
}
struct MQERROR extends Int32 {
    static MQ_ERROR := -1072824319
    static MQ_ERROR_PROPERTY := -1072824318
    static MQ_ERROR_QUEUE_NOT_FOUND := -1072824317
    static MQ_ERROR_QUEUE_NOT_ACTIVE := -1072824316
    static MQ_ERROR_QUEUE_EXISTS := -1072824315
    static MQ_ERROR_INVALID_PARAMETER := -1072824314
    static MQ_ERROR_INVALID_HANDLE := -1072824313
    static MQ_ERROR_OPERATION_CANCELLED := -1072824312
    static MQ_ERROR_SHARING_VIOLATION := -1072824311
    static MQ_ERROR_SERVICE_NOT_AVAILABLE := -1072824309
    static MQ_ERROR_MACHINE_NOT_FOUND := -1072824307
    static MQ_ERROR_ILLEGAL_SORT := -1072824304
    static MQ_ERROR_ILLEGAL_USER := -1072824303
    static MQ_ERROR_NO_DS := -1072824301
    static MQ_ERROR_ILLEGAL_QUEUE_PATHNAME := -1072824300
    static MQ_ERROR_ILLEGAL_PROPERTY_VALUE := -1072824296
    static MQ_ERROR_ILLEGAL_PROPERTY_VT := -1072824295
    static MQ_ERROR_BUFFER_OVERFLOW := -1072824294
    static MQ_ERROR_IO_TIMEOUT := -1072824293
    static MQ_ERROR_ILLEGAL_CURSOR_ACTION := -1072824292
    static MQ_ERROR_MESSAGE_ALREADY_RECEIVED := -1072824291
    static MQ_ERROR_ILLEGAL_FORMATNAME := -1072824290
    static MQ_ERROR_FORMATNAME_BUFFER_TOO_SMALL := -1072824289
    static MQ_ERROR_UNSUPPORTED_FORMATNAME_OPERATION := -1072824288
    static MQ_ERROR_ILLEGAL_SECURITY_DESCRIPTOR := -1072824287
    static MQ_ERROR_SENDERID_BUFFER_TOO_SMALL := -1072824286
    static MQ_ERROR_SECURITY_DESCRIPTOR_TOO_SMALL := -1072824285
    static MQ_ERROR_CANNOT_IMPERSONATE_CLIENT := -1072824284
    static MQ_ERROR_ACCESS_DENIED := -1072824283
    static MQ_ERROR_PRIVILEGE_NOT_HELD := -1072824282
    static MQ_ERROR_INSUFFICIENT_RESOURCES := -1072824281
    static MQ_ERROR_USER_BUFFER_TOO_SMALL := -1072824280
    static MQ_ERROR_MESSAGE_STORAGE_FAILED := -1072824278
    static MQ_ERROR_SENDER_CERT_BUFFER_TOO_SMALL := -1072824277
    static MQ_ERROR_INVALID_CERTIFICATE := -1072824276
    static MQ_ERROR_CORRUPTED_INTERNAL_CERTIFICATE := -1072824275
    static MQ_ERROR_INTERNAL_USER_CERT_EXIST := -1072824274
    static MQ_ERROR_NO_INTERNAL_USER_CERT := -1072824273
    static MQ_ERROR_CORRUPTED_SECURITY_DATA := -1072824272
    static MQ_ERROR_CORRUPTED_PERSONAL_CERT_STORE := -1072824271
    static MQ_ERROR_COMPUTER_DOES_NOT_SUPPORT_ENCRYPTION := -1072824269
    static MQ_ERROR_BAD_SECURITY_CONTEXT := -1072824267
    static MQ_ERROR_COULD_NOT_GET_USER_SID := -1072824266
    static MQ_ERROR_COULD_NOT_GET_ACCOUNT_INFO := -1072824265
    static MQ_ERROR_ILLEGAL_MQCOLUMNS := -1072824264
    static MQ_ERROR_ILLEGAL_PROPID := -1072824263
    static MQ_ERROR_ILLEGAL_RELATION := -1072824262
    static MQ_ERROR_ILLEGAL_PROPERTY_SIZE := -1072824261
    static MQ_ERROR_ILLEGAL_RESTRICTION_PROPID := -1072824260
    static MQ_ERROR_ILLEGAL_MQQUEUEPROPS := -1072824259
    static MQ_ERROR_PROPERTY_NOTALLOWED := -1072824258
    static MQ_ERROR_INSUFFICIENT_PROPERTIES := -1072824257
    static MQ_ERROR_MACHINE_EXISTS := -1072824256
    static MQ_ERROR_ILLEGAL_MQQMPROPS := -1072824255
    static MQ_ERROR_DS_IS_FULL := -1072824254
    static MQ_ERROR_DS_ERROR := -1072824253
    static MQ_ERROR_INVALID_OWNER := -1072824252
    static MQ_ERROR_UNSUPPORTED_ACCESS_MODE := -1072824251
    static MQ_ERROR_RESULT_BUFFER_TOO_SMALL := -1072824250
    static MQ_ERROR_DELETE_CN_IN_USE := -1072824248
    static MQ_ERROR_NO_RESPONSE_FROM_OBJECT_SERVER := -1072824247
    static MQ_ERROR_OBJECT_SERVER_NOT_AVAILABLE := -1072824246
    static MQ_ERROR_QUEUE_NOT_AVAILABLE := -1072824245
    static MQ_ERROR_DTC_CONNECT := -1072824244
    static MQ_ERROR_TRANSACTION_IMPORT := -1072824242
    static MQ_ERROR_TRANSACTION_USAGE := -1072824240
    static MQ_ERROR_TRANSACTION_SEQUENCE := -1072824239
    static MQ_ERROR_MISSING_CONNECTOR_TYPE := -1072824235
    static MQ_ERROR_STALE_HANDLE := -1072824234
    static MQ_ERROR_TRANSACTION_ENLIST := -1072824232
    static MQ_ERROR_QUEUE_DELETED := -1072824230
    static MQ_ERROR_ILLEGAL_CONTEXT := -1072824229
    static MQ_ERROR_ILLEGAL_SORT_PROPID := -1072824228
    static MQ_ERROR_LABEL_TOO_LONG := -1072824227
    static MQ_ERROR_LABEL_BUFFER_TOO_SMALL := -1072824226
    static MQ_ERROR_MQIS_SERVER_EMPTY := -1072824225
    static MQ_ERROR_MQIS_READONLY_MODE := -1072824224
    static MQ_ERROR_SYMM_KEY_BUFFER_TOO_SMALL := -1072824223
    static MQ_ERROR_SIGNATURE_BUFFER_TOO_SMALL := -1072824222
    static MQ_ERROR_PROV_NAME_BUFFER_TOO_SMALL := -1072824221
    static MQ_ERROR_ILLEGAL_OPERATION := -1072824220
    static MQ_ERROR_WRITE_NOT_ALLOWED := -1072824219
    static MQ_ERROR_WKS_CANT_SERVE_CLIENT := -1072824218
    static MQ_ERROR_DEPEND_WKS_LICENSE_OVERFLOW := -1072824217
    static MQ_CORRUPTED_QUEUE_WAS_DELETED := -1072824216
    static MQ_ERROR_REMOTE_MACHINE_NOT_AVAILABLE := -1072824215
    static MQ_ERROR_UNSUPPORTED_OPERATION := -1072824214
    static MQ_ERROR_ENCRYPTION_PROVIDER_NOT_SUPPORTED := -1072824213
    static MQ_ERROR_CANNOT_SET_CRYPTO_SEC_DESCR := -1072824212
    static MQ_ERROR_CERTIFICATE_NOT_PROVIDED := -1072824211
    static MQ_ERROR_Q_DNS_PROPERTY_NOT_SUPPORTED := -1072824210
    static MQ_ERROR_CANT_CREATE_CERT_STORE := -1072824209
    static MQ_ERROR_CANNOT_CREATE_CERT_STORE := -1072824209
    static MQ_ERROR_CANT_OPEN_CERT_STORE := -1072824208
    static MQ_ERROR_CANNOT_OPEN_CERT_STORE := -1072824208
    static MQ_ERROR_ILLEGAL_ENTERPRISE_OPERATION := -1072824207
    static MQ_ERROR_CANNOT_GRANT_ADD_GUID := -1072824206
    static MQ_ERROR_CANNOT_LOAD_MSMQOCM := -1072824205
    static MQ_ERROR_NO_ENTRY_POINT_MSMQOCM := -1072824204
    static MQ_ERROR_NO_MSMQ_SERVERS_ON_DC := -1072824203
    static MQ_ERROR_CANNOT_JOIN_DOMAIN := -1072824202
    static MQ_ERROR_CANNOT_CREATE_ON_GC := -1072824201
    static MQ_ERROR_GUID_NOT_MATCHING := -1072824200
    static MQ_ERROR_PUBLIC_KEY_NOT_FOUND := -1072824199
    static MQ_ERROR_PUBLIC_KEY_DOES_NOT_EXIST := -1072824198
    static MQ_ERROR_ILLEGAL_MQPRIVATEPROPS := -1072824197
    static MQ_ERROR_NO_GC_IN_DOMAIN := -1072824196
    static MQ_ERROR_NO_MSMQ_SERVERS_ON_GC := -1072824195
    static MQ_ERROR_CANNOT_GET_DN := -1072824194
    static MQ_ERROR_CANNOT_HASH_DATA_EX := -1072824193
    static MQ_ERROR_CANNOT_SIGN_DATA_EX := -1072824192
    static MQ_ERROR_CANNOT_CREATE_HASH_EX := -1072824191
    static MQ_ERROR_FAIL_VERIFY_SIGNATURE_EX := -1072824190
    static MQ_ERROR_CANNOT_DELETE_PSC_OBJECTS := -1072824189
    static MQ_ERROR_NO_MQUSER_OU := -1072824188
    static MQ_ERROR_CANNOT_LOAD_MQAD := -1072824187
    static MQ_ERROR_CANNOT_LOAD_MQDSSRV := -1072824186
    static MQ_ERROR_PROPERTIES_CONFLICT := -1072824185
    static MQ_ERROR_MESSAGE_NOT_FOUND := -1072824184
    static MQ_ERROR_CANT_RESOLVE_SITES := -1072824183
    static MQ_ERROR_NOT_SUPPORTED_BY_DEPENDENT_CLIENTS := -1072824182
    static MQ_ERROR_OPERATION_NOT_SUPPORTED_BY_REMOTE_COMPUTER := -1072824181
    static MQ_ERROR_NOT_A_CORRECT_OBJECT_CLASS := -1072824180
    static MQ_ERROR_MULTI_SORT_KEYS := -1072824179
    static MQ_ERROR_GC_NEEDED := -1072824178
    static MQ_ERROR_DS_BIND_ROOT_FOREST := -1072824177
    static MQ_ERROR_DS_LOCAL_USER := -1072824176
    static MQ_ERROR_Q_ADS_PROPERTY_NOT_SUPPORTED := -1072824175
    static MQ_ERROR_BAD_XML_FORMAT := -1072824174
    static MQ_ERROR_UNSUPPORTED_CLASS := -1072824173
    static MQ_ERROR_UNINITIALIZED_OBJECT := -1072824172
    static MQ_ERROR_CANNOT_CREATE_PSC_OBJECTS := -1072824171
    static MQ_ERROR_CANNOT_UPDATE_PSC_OBJECTS := -1072824170
}
struct MQWARNING extends Int32 {
    static MQ_INFORMATION_PROPERTY := 1074659329
    static MQ_INFORMATION_ILLEGAL_PROPERTY := 1074659330
    static MQ_INFORMATION_PROPERTY_IGNORED := 1074659331
    static MQ_INFORMATION_UNSUPPORTED_PROPERTY := 1074659332
    static MQ_INFORMATION_DUPLICATE_PROPERTY := 1074659333
    static MQ_INFORMATION_OPERATION_PENDING := 1074659334
    static MQ_INFORMATION_FORMATNAME_BUFFER_TOO_SMALL := 1074659337
    static MQ_INFORMATION_INTERNAL_USER_CERT_EXIST := 1074659338
    static MQ_INFORMATION_OWNER_IGNORED := 1074659339
}
struct IMSMQQuery extends IDispatch {
    static IID := "{D7D6E072-DCCD-11D0-AA4B-0060970DEBAE}"
    LookupQueue(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, ppqinfos)
      => ComCall(7, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, IMSMQQueueInfos.Ptr, ppqinfos)
}
struct IMSMQQueueInfo extends IDispatch {
    static IID := "{D7D6E07B-DCCD-11D0-AA4B-0060970DEBAE}"
    get_QueueGuid(pbstrGuidQueue)
      => ComCall(7, this.p, BSTR.Ptr, pbstrGuidQueue)
    get_ServiceTypeGuid(pbstrGuidServiceType)
      => ComCall(8, this.p, BSTR.Ptr, pbstrGuidServiceType)
    put_ServiceTypeGuid(bstrGuidServiceType)
      => ComCall(9, this.p, BSTR, bstrGuidServiceType)
    get_Label(pbstrLabel)
      => ComCall(10, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(11, this.p, BSTR, bstrLabel)
    get_PathName(pbstrPathName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrPathName)
    put_PathName(bstrPathName)
      => ComCall(13, this.p, BSTR, bstrPathName)
    get_FormatName(pbstrFormatName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrFormatName)
    put_FormatName(bstrFormatName)
      => ComCall(15, this.p, BSTR, bstrFormatName)
    get_IsTransactional(pisTransactional)
      => ComCall(16, this.p, Int16.Ptr, pisTransactional)
    get_PrivLevel(plPrivLevel)
      => ComCall(17, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(18, this.p, Int32, lPrivLevel)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_Quota(plQuota)
      => ComCall(21, this.p, Int32.Ptr, plQuota)
    put_Quota(lQuota)
      => ComCall(22, this.p, Int32, lQuota)
    get_BasePriority(plBasePriority)
      => ComCall(23, this.p, Int32.Ptr, plBasePriority)
    put_BasePriority(lBasePriority)
      => ComCall(24, this.p, Int32, lBasePriority)
    get_CreateTime(pvarCreateTime)
      => ComCall(25, this.p, VARIANT.Ptr, pvarCreateTime)
    get_ModifyTime(pvarModifyTime)
      => ComCall(26, this.p, VARIANT.Ptr, pvarModifyTime)
    get_Authenticate(plAuthenticate)
      => ComCall(27, this.p, Int32.Ptr, plAuthenticate)
    put_Authenticate(lAuthenticate)
      => ComCall(28, this.p, Int32, lAuthenticate)
    get_JournalQuota(plJournalQuota)
      => ComCall(29, this.p, Int32.Ptr, plJournalQuota)
    put_JournalQuota(lJournalQuota)
      => ComCall(30, this.p, Int32, lJournalQuota)
    get_IsWorldReadable(pisWorldReadable)
      => ComCall(31, this.p, Int16.Ptr, pisWorldReadable)
    Create(IsTransactional, IsWorldReadable)
      => ComCall(32, this.p, VARIANT.Ptr, IsTransactional, VARIANT.Ptr, IsWorldReadable)
    Delete()
      => ComCall(33, this.p)
    Open(Access, ShareMode, ppq)
      => ComCall(34, this.p, Int32, Access, Int32, ShareMode, IMSMQQueue.Ptr, ppq)
    Refresh()
      => ComCall(35, this.p)
    Update()
      => ComCall(36, this.p)
}
struct IMSMQQueueInfo2 extends IDispatch {
    static IID := "{FD174A80-89CF-11D2-B0F2-00E02C074F6B}"
    get_QueueGuid(pbstrGuidQueue)
      => ComCall(7, this.p, BSTR.Ptr, pbstrGuidQueue)
    get_ServiceTypeGuid(pbstrGuidServiceType)
      => ComCall(8, this.p, BSTR.Ptr, pbstrGuidServiceType)
    put_ServiceTypeGuid(bstrGuidServiceType)
      => ComCall(9, this.p, BSTR, bstrGuidServiceType)
    get_Label(pbstrLabel)
      => ComCall(10, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(11, this.p, BSTR, bstrLabel)
    get_PathName(pbstrPathName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrPathName)
    put_PathName(bstrPathName)
      => ComCall(13, this.p, BSTR, bstrPathName)
    get_FormatName(pbstrFormatName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrFormatName)
    put_FormatName(bstrFormatName)
      => ComCall(15, this.p, BSTR, bstrFormatName)
    get_IsTransactional(pisTransactional)
      => ComCall(16, this.p, Int16.Ptr, pisTransactional)
    get_PrivLevel(plPrivLevel)
      => ComCall(17, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(18, this.p, Int32, lPrivLevel)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_Quota(plQuota)
      => ComCall(21, this.p, Int32.Ptr, plQuota)
    put_Quota(lQuota)
      => ComCall(22, this.p, Int32, lQuota)
    get_BasePriority(plBasePriority)
      => ComCall(23, this.p, Int32.Ptr, plBasePriority)
    put_BasePriority(lBasePriority)
      => ComCall(24, this.p, Int32, lBasePriority)
    get_CreateTime(pvarCreateTime)
      => ComCall(25, this.p, VARIANT.Ptr, pvarCreateTime)
    get_ModifyTime(pvarModifyTime)
      => ComCall(26, this.p, VARIANT.Ptr, pvarModifyTime)
    get_Authenticate(plAuthenticate)
      => ComCall(27, this.p, Int32.Ptr, plAuthenticate)
    put_Authenticate(lAuthenticate)
      => ComCall(28, this.p, Int32, lAuthenticate)
    get_JournalQuota(plJournalQuota)
      => ComCall(29, this.p, Int32.Ptr, plJournalQuota)
    put_JournalQuota(lJournalQuota)
      => ComCall(30, this.p, Int32, lJournalQuota)
    get_IsWorldReadable(pisWorldReadable)
      => ComCall(31, this.p, Int16.Ptr, pisWorldReadable)
    Create(IsTransactional, IsWorldReadable)
      => ComCall(32, this.p, VARIANT.Ptr, IsTransactional, VARIANT.Ptr, IsWorldReadable)
    Delete()
      => ComCall(33, this.p)
    Open(Access, ShareMode, ppq)
      => ComCall(34, this.p, Int32, Access, Int32, ShareMode, IMSMQQueue2.Ptr, ppq)
    Refresh()
      => ComCall(35, this.p)
    Update()
      => ComCall(36, this.p)
    get_PathNameDNS(pbstrPathNameDNS)
      => ComCall(37, this.p, BSTR.Ptr, pbstrPathNameDNS)
    get_Properties(ppcolProperties)
      => ComCall(38, this.p, IDispatch.Ptr, ppcolProperties)
    get_Security(pvarSecurity)
      => ComCall(39, this.p, VARIANT.Ptr, pvarSecurity)
    put_Security(varSecurity)
      => ComCall(40, this.p, VARIANT, varSecurity)
}
struct IMSMQQueueInfo3 extends IDispatch {
    static IID := "{EBA96B1D-2168-11D3-898C-00E02C074F6B}"
    get_QueueGuid(pbstrGuidQueue)
      => ComCall(7, this.p, BSTR.Ptr, pbstrGuidQueue)
    get_ServiceTypeGuid(pbstrGuidServiceType)
      => ComCall(8, this.p, BSTR.Ptr, pbstrGuidServiceType)
    put_ServiceTypeGuid(bstrGuidServiceType)
      => ComCall(9, this.p, BSTR, bstrGuidServiceType)
    get_Label(pbstrLabel)
      => ComCall(10, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(11, this.p, BSTR, bstrLabel)
    get_PathName(pbstrPathName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrPathName)
    put_PathName(bstrPathName)
      => ComCall(13, this.p, BSTR, bstrPathName)
    get_FormatName(pbstrFormatName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrFormatName)
    put_FormatName(bstrFormatName)
      => ComCall(15, this.p, BSTR, bstrFormatName)
    get_IsTransactional(pisTransactional)
      => ComCall(16, this.p, Int16.Ptr, pisTransactional)
    get_PrivLevel(plPrivLevel)
      => ComCall(17, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(18, this.p, Int32, lPrivLevel)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_Quota(plQuota)
      => ComCall(21, this.p, Int32.Ptr, plQuota)
    put_Quota(lQuota)
      => ComCall(22, this.p, Int32, lQuota)
    get_BasePriority(plBasePriority)
      => ComCall(23, this.p, Int32.Ptr, plBasePriority)
    put_BasePriority(lBasePriority)
      => ComCall(24, this.p, Int32, lBasePriority)
    get_CreateTime(pvarCreateTime)
      => ComCall(25, this.p, VARIANT.Ptr, pvarCreateTime)
    get_ModifyTime(pvarModifyTime)
      => ComCall(26, this.p, VARIANT.Ptr, pvarModifyTime)
    get_Authenticate(plAuthenticate)
      => ComCall(27, this.p, Int32.Ptr, plAuthenticate)
    put_Authenticate(lAuthenticate)
      => ComCall(28, this.p, Int32, lAuthenticate)
    get_JournalQuota(plJournalQuota)
      => ComCall(29, this.p, Int32.Ptr, plJournalQuota)
    put_JournalQuota(lJournalQuota)
      => ComCall(30, this.p, Int32, lJournalQuota)
    get_IsWorldReadable(pisWorldReadable)
      => ComCall(31, this.p, Int16.Ptr, pisWorldReadable)
    Create(IsTransactional, IsWorldReadable)
      => ComCall(32, this.p, VARIANT.Ptr, IsTransactional, VARIANT.Ptr, IsWorldReadable)
    Delete()
      => ComCall(33, this.p)
    Open(Access, ShareMode, ppq)
      => ComCall(34, this.p, Int32, Access, Int32, ShareMode, IMSMQQueue3.Ptr, ppq)
    Refresh()
      => ComCall(35, this.p)
    Update()
      => ComCall(36, this.p)
    get_PathNameDNS(pbstrPathNameDNS)
      => ComCall(37, this.p, BSTR.Ptr, pbstrPathNameDNS)
    get_Properties(ppcolProperties)
      => ComCall(38, this.p, IDispatch.Ptr, ppcolProperties)
    get_Security(pvarSecurity)
      => ComCall(39, this.p, VARIANT.Ptr, pvarSecurity)
    put_Security(varSecurity)
      => ComCall(40, this.p, VARIANT, varSecurity)
    get_IsTransactional2(pisTransactional)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pisTransactional)
    get_IsWorldReadable2(pisWorldReadable)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, pisWorldReadable)
    get_MulticastAddress(pbstrMulticastAddress)
      => ComCall(43, this.p, BSTR.Ptr, pbstrMulticastAddress)
    put_MulticastAddress(bstrMulticastAddress)
      => ComCall(44, this.p, BSTR, bstrMulticastAddress)
    get_ADsPath(pbstrADsPath)
      => ComCall(45, this.p, BSTR.Ptr, pbstrADsPath)
}
struct IMSMQQueueInfo4 extends IDispatch {
    static IID := "{EBA96B21-2168-11D3-898C-00E02C074F6B}"
    get_QueueGuid(pbstrGuidQueue)
      => ComCall(7, this.p, BSTR.Ptr, pbstrGuidQueue)
    get_ServiceTypeGuid(pbstrGuidServiceType)
      => ComCall(8, this.p, BSTR.Ptr, pbstrGuidServiceType)
    put_ServiceTypeGuid(bstrGuidServiceType)
      => ComCall(9, this.p, BSTR, bstrGuidServiceType)
    get_Label(pbstrLabel)
      => ComCall(10, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(11, this.p, BSTR, bstrLabel)
    get_PathName(pbstrPathName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrPathName)
    put_PathName(bstrPathName)
      => ComCall(13, this.p, BSTR, bstrPathName)
    get_FormatName(pbstrFormatName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrFormatName)
    put_FormatName(bstrFormatName)
      => ComCall(15, this.p, BSTR, bstrFormatName)
    get_IsTransactional(pisTransactional)
      => ComCall(16, this.p, Int16.Ptr, pisTransactional)
    get_PrivLevel(plPrivLevel)
      => ComCall(17, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(18, this.p, Int32, lPrivLevel)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_Quota(plQuota)
      => ComCall(21, this.p, Int32.Ptr, plQuota)
    put_Quota(lQuota)
      => ComCall(22, this.p, Int32, lQuota)
    get_BasePriority(plBasePriority)
      => ComCall(23, this.p, Int32.Ptr, plBasePriority)
    put_BasePriority(lBasePriority)
      => ComCall(24, this.p, Int32, lBasePriority)
    get_CreateTime(pvarCreateTime)
      => ComCall(25, this.p, VARIANT.Ptr, pvarCreateTime)
    get_ModifyTime(pvarModifyTime)
      => ComCall(26, this.p, VARIANT.Ptr, pvarModifyTime)
    get_Authenticate(plAuthenticate)
      => ComCall(27, this.p, Int32.Ptr, plAuthenticate)
    put_Authenticate(lAuthenticate)
      => ComCall(28, this.p, Int32, lAuthenticate)
    get_JournalQuota(plJournalQuota)
      => ComCall(29, this.p, Int32.Ptr, plJournalQuota)
    put_JournalQuota(lJournalQuota)
      => ComCall(30, this.p, Int32, lJournalQuota)
    get_IsWorldReadable(pisWorldReadable)
      => ComCall(31, this.p, Int16.Ptr, pisWorldReadable)
    Create(IsTransactional, IsWorldReadable)
      => ComCall(32, this.p, VARIANT.Ptr, IsTransactional, VARIANT.Ptr, IsWorldReadable)
    Delete()
      => ComCall(33, this.p)
    Open(Access, ShareMode, ppq)
      => ComCall(34, this.p, Int32, Access, Int32, ShareMode, IMSMQQueue4.Ptr, ppq)
    Refresh()
      => ComCall(35, this.p)
    Update()
      => ComCall(36, this.p)
    get_PathNameDNS(pbstrPathNameDNS)
      => ComCall(37, this.p, BSTR.Ptr, pbstrPathNameDNS)
    get_Properties(ppcolProperties)
      => ComCall(38, this.p, IDispatch.Ptr, ppcolProperties)
    get_Security(pvarSecurity)
      => ComCall(39, this.p, VARIANT.Ptr, pvarSecurity)
    put_Security(varSecurity)
      => ComCall(40, this.p, VARIANT, varSecurity)
    get_IsTransactional2(pisTransactional)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pisTransactional)
    get_IsWorldReadable2(pisWorldReadable)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, pisWorldReadable)
    get_MulticastAddress(pbstrMulticastAddress)
      => ComCall(43, this.p, BSTR.Ptr, pbstrMulticastAddress)
    put_MulticastAddress(bstrMulticastAddress)
      => ComCall(44, this.p, BSTR, bstrMulticastAddress)
    get_ADsPath(pbstrADsPath)
      => ComCall(45, this.p, BSTR.Ptr, pbstrADsPath)
}
struct IMSMQQueue extends IDispatch {
    static IID := "{D7D6E076-DCCD-11D0-AA4B-0060970DEBAE}"
    get_Access(plAccess)
      => ComCall(7, this.p, Int32.Ptr, plAccess)
    get_ShareMode(plShareMode)
      => ComCall(8, this.p, Int32.Ptr, plShareMode)
    get_QueueInfo(ppqinfo)
      => ComCall(9, this.p, IMSMQQueueInfo.Ptr, ppqinfo)
    get_Handle(plHandle)
      => ComCall(10, this.p, Int32.Ptr, plHandle)
    get_IsOpen(pisOpen)
      => ComCall(11, this.p, Int16.Ptr, pisOpen)
    Close()
      => ComCall(12, this.p)
    Receive(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(13, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Peek(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(14, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    EnableNotification(Event?, Cursor, ReceiveTimeout)
      => ComCall(15, this.p, IMSMQEvent, Event?, VARIANT.Ptr, Cursor, VARIANT.Ptr, ReceiveTimeout)
    Reset()
      => ComCall(16, this.p)
    ReceiveCurrent(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(17, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekNext(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(18, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekCurrent(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(19, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
}
struct IMSMQQueue2 extends IDispatch {
    static IID := "{EF0574E0-06D8-11D3-B100-00E02C074F6B}"
    get_Access(plAccess)
      => ComCall(7, this.p, Int32.Ptr, plAccess)
    get_ShareMode(plShareMode)
      => ComCall(8, this.p, Int32.Ptr, plShareMode)
    get_QueueInfo(ppqinfo)
      => ComCall(9, this.p, IMSMQQueueInfo2.Ptr, ppqinfo)
    get_Handle(plHandle)
      => ComCall(10, this.p, Int32.Ptr, plHandle)
    get_IsOpen(pisOpen)
      => ComCall(11, this.p, Int16.Ptr, pisOpen)
    Close()
      => ComCall(12, this.p)
    Receive_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(13, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Peek_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(14, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    EnableNotification(Event?, Cursor, ReceiveTimeout)
      => ComCall(15, this.p, IMSMQEvent2, Event?, VARIANT.Ptr, Cursor, VARIANT.Ptr, ReceiveTimeout)
    Reset()
      => ComCall(16, this.p)
    ReceiveCurrent_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(17, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekNext_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(18, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekCurrent_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(19, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Receive(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(20, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage2.Ptr, ppmsg)
    Peek(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(21, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage2.Ptr, ppmsg)
    ReceiveCurrent(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(22, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage2.Ptr, ppmsg)
    PeekNext(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(23, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage2.Ptr, ppmsg)
    PeekCurrent(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(24, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage2.Ptr, ppmsg)
    get_Properties(ppcolProperties)
      => ComCall(25, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQQueue3 extends IDispatch {
    static IID := "{EBA96B1B-2168-11D3-898C-00E02C074F6B}"
    get_Access(plAccess)
      => ComCall(7, this.p, Int32.Ptr, plAccess)
    get_ShareMode(plShareMode)
      => ComCall(8, this.p, Int32.Ptr, plShareMode)
    get_QueueInfo(ppqinfo)
      => ComCall(9, this.p, IMSMQQueueInfo3.Ptr, ppqinfo)
    get_Handle(plHandle)
      => ComCall(10, this.p, Int32.Ptr, plHandle)
    get_IsOpen(pisOpen)
      => ComCall(11, this.p, Int16.Ptr, pisOpen)
    Close()
      => ComCall(12, this.p)
    Receive_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(13, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Peek_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(14, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    EnableNotification(Event?, Cursor, ReceiveTimeout)
      => ComCall(15, this.p, IMSMQEvent3, Event?, VARIANT.Ptr, Cursor, VARIANT.Ptr, ReceiveTimeout)
    Reset()
      => ComCall(16, this.p)
    ReceiveCurrent_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(17, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekNext_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(18, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekCurrent_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(19, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Receive(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(20, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    Peek(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(21, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    ReceiveCurrent(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(22, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekNext(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(23, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekCurrent(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(24, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    get_Properties(ppcolProperties)
      => ComCall(25, this.p, IDispatch.Ptr, ppcolProperties)
    get_Handle2(pvarHandle)
      => ComCall(26, this.p, VARIANT.Ptr, pvarHandle)
    ReceiveByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(27, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    ReceiveNextByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(28, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    ReceivePreviousByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(29, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    ReceiveFirstByLookupId(Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(30, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    ReceiveLastByLookupId(Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(31, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(32, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekNextByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(33, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekPreviousByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(34, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekFirstByLookupId(WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(35, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    PeekLastByLookupId(WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(36, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage3.Ptr, ppmsg)
    Purge()
      => ComCall(37, this.p)
    get_IsOpen2(pisOpen)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pisOpen)
}
struct IMSMQQueue4 extends IDispatch {
    static IID := "{EBA96B20-2168-11D3-898C-00E02C074F6B}"
    get_Access(plAccess)
      => ComCall(7, this.p, Int32.Ptr, plAccess)
    get_ShareMode(plShareMode)
      => ComCall(8, this.p, Int32.Ptr, plShareMode)
    get_QueueInfo(ppqinfo)
      => ComCall(9, this.p, IMSMQQueueInfo4.Ptr, ppqinfo)
    get_Handle(plHandle)
      => ComCall(10, this.p, Int32.Ptr, plHandle)
    get_IsOpen(pisOpen)
      => ComCall(11, this.p, Int16.Ptr, pisOpen)
    Close()
      => ComCall(12, this.p)
    Receive_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(13, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Peek_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(14, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    EnableNotification(Event?, Cursor, ReceiveTimeout)
      => ComCall(15, this.p, IMSMQEvent3, Event?, VARIANT.Ptr, Cursor, VARIANT.Ptr, ReceiveTimeout)
    Reset()
      => ComCall(16, this.p)
    ReceiveCurrent_v1(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(17, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekNext_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(18, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    PeekCurrent_v1(WantDestinationQueue, WantBody, ReceiveTimeout, ppmsg)
      => ComCall(19, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, IMSMQMessage.Ptr, ppmsg)
    Receive(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(20, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    Peek(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(21, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    ReceiveCurrent(Transaction, WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(22, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekNext(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(23, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekCurrent(WantDestinationQueue, WantBody, ReceiveTimeout, WantConnectorType, ppmsg)
      => ComCall(24, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, ReceiveTimeout, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    get_Properties(ppcolProperties)
      => ComCall(25, this.p, IDispatch.Ptr, ppcolProperties)
    get_Handle2(pvarHandle)
      => ComCall(26, this.p, VARIANT.Ptr, pvarHandle)
    ReceiveByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(27, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    ReceiveNextByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(28, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    ReceivePreviousByLookupId(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(29, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    ReceiveFirstByLookupId(Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(30, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    ReceiveLastByLookupId(Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(31, this.p, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(32, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekNextByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(33, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekPreviousByLookupId(LookupId, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(34, this.p, VARIANT, LookupId, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekFirstByLookupId(WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(35, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    PeekLastByLookupId(WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(36, this.p, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
    Purge()
      => ComCall(37, this.p)
    get_IsOpen2(pisOpen)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pisOpen)
    ReceiveByLookupIdAllowPeek(LookupId, Transaction, WantDestinationQueue, WantBody, WantConnectorType, ppmsg)
      => ComCall(39, this.p, VARIANT, LookupId, VARIANT.Ptr, Transaction, VARIANT.Ptr, WantDestinationQueue, VARIANT.Ptr, WantBody, VARIANT.Ptr, WantConnectorType, IMSMQMessage4.Ptr, ppmsg)
}
struct IMSMQMessage extends IDispatch {
    static IID := "{D7D6E074-DCCD-11D0-AA4B-0060970DEBAE}"
    get_Class(plClass)
      => ComCall(7, this.p, Int32.Ptr, plClass)
    get_PrivLevel(plPrivLevel)
      => ComCall(8, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(9, this.p, Int32, lPrivLevel)
    get_AuthLevel(plAuthLevel)
      => ComCall(10, this.p, Int32.Ptr, plAuthLevel)
    put_AuthLevel(lAuthLevel)
      => ComCall(11, this.p, Int32, lAuthLevel)
    get_IsAuthenticated(pisAuthenticated)
      => ComCall(12, this.p, Int16.Ptr, pisAuthenticated)
    get_Delivery(plDelivery)
      => ComCall(13, this.p, Int32.Ptr, plDelivery)
    put_Delivery(lDelivery)
      => ComCall(14, this.p, Int32, lDelivery)
    get_Trace(plTrace)
      => ComCall(15, this.p, Int32.Ptr, plTrace)
    put_Trace(lTrace)
      => ComCall(16, this.p, Int32, lTrace)
    get_Priority(plPriority)
      => ComCall(17, this.p, Int32.Ptr, plPriority)
    put_Priority(lPriority)
      => ComCall(18, this.p, Int32, lPriority)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_ResponseQueueInfo(ppqinfoResponse)
      => ComCall(21, this.p, IMSMQQueueInfo.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo(pqinfoResponse?)
      => ComCall(22, this.p, IMSMQQueueInfo, pqinfoResponse?)
    get_AppSpecific(plAppSpecific)
      => ComCall(23, this.p, Int32.Ptr, plAppSpecific)
    put_AppSpecific(lAppSpecific)
      => ComCall(24, this.p, Int32, lAppSpecific)
    get_SourceMachineGuid(pbstrGuidSrcMachine)
      => ComCall(25, this.p, BSTR.Ptr, pbstrGuidSrcMachine)
    get_BodyLength(pcbBody)
      => ComCall(26, this.p, Int32.Ptr, pcbBody)
    get_Body(pvarBody)
      => ComCall(27, this.p, VARIANT.Ptr, pvarBody)
    put_Body(varBody)
      => ComCall(28, this.p, VARIANT, varBody)
    get_AdminQueueInfo(ppqinfoAdmin)
      => ComCall(29, this.p, IMSMQQueueInfo.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo(pqinfoAdmin?)
      => ComCall(30, this.p, IMSMQQueueInfo, pqinfoAdmin?)
    get_Id(pvarMsgId)
      => ComCall(31, this.p, VARIANT.Ptr, pvarMsgId)
    get_CorrelationId(pvarMsgId)
      => ComCall(32, this.p, VARIANT.Ptr, pvarMsgId)
    put_CorrelationId(varMsgId)
      => ComCall(33, this.p, VARIANT, varMsgId)
    get_Ack(plAck)
      => ComCall(34, this.p, Int32.Ptr, plAck)
    put_Ack(lAck)
      => ComCall(35, this.p, Int32, lAck)
    get_Label(pbstrLabel)
      => ComCall(36, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(37, this.p, BSTR, bstrLabel)
    get_MaxTimeToReachQueue(plMaxTimeToReachQueue)
      => ComCall(38, this.p, Int32.Ptr, plMaxTimeToReachQueue)
    put_MaxTimeToReachQueue(lMaxTimeToReachQueue)
      => ComCall(39, this.p, Int32, lMaxTimeToReachQueue)
    get_MaxTimeToReceive(plMaxTimeToReceive)
      => ComCall(40, this.p, Int32.Ptr, plMaxTimeToReceive)
    put_MaxTimeToReceive(lMaxTimeToReceive)
      => ComCall(41, this.p, Int32, lMaxTimeToReceive)
    get_HashAlgorithm(plHashAlg)
      => ComCall(42, this.p, Int32.Ptr, plHashAlg)
    put_HashAlgorithm(lHashAlg)
      => ComCall(43, this.p, Int32, lHashAlg)
    get_EncryptAlgorithm(plEncryptAlg)
      => ComCall(44, this.p, Int32.Ptr, plEncryptAlg)
    put_EncryptAlgorithm(lEncryptAlg)
      => ComCall(45, this.p, Int32, lEncryptAlg)
    get_SentTime(pvarSentTime)
      => ComCall(46, this.p, VARIANT.Ptr, pvarSentTime)
    get_ArrivedTime(plArrivedTime)
      => ComCall(47, this.p, VARIANT.Ptr, plArrivedTime)
    get_DestinationQueueInfo(ppqinfoDest)
      => ComCall(48, this.p, IMSMQQueueInfo.Ptr, ppqinfoDest)
    get_SenderCertificate(pvarSenderCert)
      => ComCall(49, this.p, VARIANT.Ptr, pvarSenderCert)
    put_SenderCertificate(varSenderCert)
      => ComCall(50, this.p, VARIANT, varSenderCert)
    get_SenderId(pvarSenderId)
      => ComCall(51, this.p, VARIANT.Ptr, pvarSenderId)
    get_SenderIdType(plSenderIdType)
      => ComCall(52, this.p, Int32.Ptr, plSenderIdType)
    put_SenderIdType(lSenderIdType)
      => ComCall(53, this.p, Int32, lSenderIdType)
    Send(DestinationQueue?, Transaction)
      => ComCall(54, this.p, IMSMQQueue, DestinationQueue?, VARIANT.Ptr, Transaction)
    AttachCurrentSecurityContext()
      => ComCall(55, this.p)
}
struct IMSMQQueueInfos extends IDispatch {
    static IID := "{D7D6E07D-DCCD-11D0-AA4B-0060970DEBAE}"
    Reset()
      => ComCall(7, this.p)
    Next(ppqinfoNext)
      => ComCall(8, this.p, IMSMQQueueInfo.Ptr, ppqinfoNext)
}
struct IMSMQQueueInfos2 extends IDispatch {
    static IID := "{EBA96B0F-2168-11D3-898C-00E02C074F6B}"
    Reset()
      => ComCall(7, this.p)
    Next(ppqinfoNext)
      => ComCall(8, this.p, IMSMQQueueInfo2.Ptr, ppqinfoNext)
    get_Properties(ppcolProperties)
      => ComCall(9, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQQueueInfos3 extends IDispatch {
    static IID := "{EBA96B1E-2168-11D3-898C-00E02C074F6B}"
    Reset()
      => ComCall(7, this.p)
    Next(ppqinfoNext)
      => ComCall(8, this.p, IMSMQQueueInfo3.Ptr, ppqinfoNext)
    get_Properties(ppcolProperties)
      => ComCall(9, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQQueueInfos4 extends IDispatch {
    static IID := "{EBA96B22-2168-11D3-898C-00E02C074F6B}"
    Reset()
      => ComCall(7, this.p)
    Next(ppqinfoNext)
      => ComCall(8, this.p, IMSMQQueueInfo4.Ptr, ppqinfoNext)
    get_Properties(ppcolProperties)
      => ComCall(9, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQEvent extends IDispatch {
    static IID := "{D7D6E077-DCCD-11D0-AA4B-0060970DEBAE}"
}
struct IMSMQEvent2 extends IMSMQEvent {
    static IID := "{EBA96B12-2168-11D3-898C-00E02C074F6B}"
    get_Properties(ppcolProperties)
      => ComCall(7, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQEvent3 extends IMSMQEvent2 {
    static IID := "{EBA96B1C-2168-11D3-898C-00E02C074F6B}"
}
struct IMSMQTransaction extends IDispatch {
    static IID := "{D7D6E07F-DCCD-11D0-AA4B-0060970DEBAE}"
    get_Transaction(plTransaction)
      => ComCall(7, this.p, Int32.Ptr, plTransaction)
    Commit(fRetaining, grfTC, grfRM)
      => ComCall(8, this.p, VARIANT.Ptr, fRetaining, VARIANT.Ptr, grfTC, VARIANT.Ptr, grfRM)
    Abort(fRetaining, fAsync)
      => ComCall(9, this.p, VARIANT.Ptr, fRetaining, VARIANT.Ptr, fAsync)
}
struct IMSMQCoordinatedTransactionDispenser extends IDispatch {
    static IID := "{D7D6E081-DCCD-11D0-AA4B-0060970DEBAE}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction.Ptr, ptransaction)
}
struct IMSMQTransactionDispenser extends IDispatch {
    static IID := "{D7D6E083-DCCD-11D0-AA4B-0060970DEBAE}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction.Ptr, ptransaction)
}
struct IMSMQQuery2 extends IDispatch {
    static IID := "{EBA96B0E-2168-11D3-898C-00E02C074F6B}"
    LookupQueue(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, ppqinfos)
      => ComCall(7, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, IMSMQQueueInfos2.Ptr, ppqinfos)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQQuery3 extends IDispatch {
    static IID := "{EBA96B19-2168-11D3-898C-00E02C074F6B}"
    LookupQueue_v2(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, ppqinfos)
      => ComCall(7, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, IMSMQQueueInfos3.Ptr, ppqinfos)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
    LookupQueue(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, MulticastAddress, RelMulticastAddress, ppqinfos)
      => ComCall(9, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, VARIANT.Ptr, MulticastAddress, VARIANT.Ptr, RelMulticastAddress, IMSMQQueueInfos3.Ptr, ppqinfos)
}
struct IMSMQQuery4 extends IDispatch {
    static IID := "{EBA96B24-2168-11D3-898C-00E02C074F6B}"
    LookupQueue_v2(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, ppqinfos)
      => ComCall(7, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, IMSMQQueueInfos4.Ptr, ppqinfos)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
    LookupQueue(QueueGuid, ServiceTypeGuid, Label, CreateTime, ModifyTime, RelServiceType, RelLabel, RelCreateTime, RelModifyTime, MulticastAddress, RelMulticastAddress, ppqinfos)
      => ComCall(9, this.p, VARIANT.Ptr, QueueGuid, VARIANT.Ptr, ServiceTypeGuid, VARIANT.Ptr, Label, VARIANT.Ptr, CreateTime, VARIANT.Ptr, ModifyTime, VARIANT.Ptr, RelServiceType, VARIANT.Ptr, RelLabel, VARIANT.Ptr, RelCreateTime, VARIANT.Ptr, RelModifyTime, VARIANT.Ptr, MulticastAddress, VARIANT.Ptr, RelMulticastAddress, IMSMQQueueInfos4.Ptr, ppqinfos)
}
struct IMSMQMessage2 extends IDispatch {
    static IID := "{D9933BE0-A567-11D2-B0F3-00E02C074F6B}"
    get_Class(plClass)
      => ComCall(7, this.p, Int32.Ptr, plClass)
    get_PrivLevel(plPrivLevel)
      => ComCall(8, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(9, this.p, Int32, lPrivLevel)
    get_AuthLevel(plAuthLevel)
      => ComCall(10, this.p, Int32.Ptr, plAuthLevel)
    put_AuthLevel(lAuthLevel)
      => ComCall(11, this.p, Int32, lAuthLevel)
    get_IsAuthenticated(pisAuthenticated)
      => ComCall(12, this.p, Int16.Ptr, pisAuthenticated)
    get_Delivery(plDelivery)
      => ComCall(13, this.p, Int32.Ptr, plDelivery)
    put_Delivery(lDelivery)
      => ComCall(14, this.p, Int32, lDelivery)
    get_Trace(plTrace)
      => ComCall(15, this.p, Int32.Ptr, plTrace)
    put_Trace(lTrace)
      => ComCall(16, this.p, Int32, lTrace)
    get_Priority(plPriority)
      => ComCall(17, this.p, Int32.Ptr, plPriority)
    put_Priority(lPriority)
      => ComCall(18, this.p, Int32, lPriority)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_ResponseQueueInfo_v1(ppqinfoResponse)
      => ComCall(21, this.p, IMSMQQueueInfo.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo_v1(pqinfoResponse?)
      => ComCall(22, this.p, IMSMQQueueInfo, pqinfoResponse?)
    get_AppSpecific(plAppSpecific)
      => ComCall(23, this.p, Int32.Ptr, plAppSpecific)
    put_AppSpecific(lAppSpecific)
      => ComCall(24, this.p, Int32, lAppSpecific)
    get_SourceMachineGuid(pbstrGuidSrcMachine)
      => ComCall(25, this.p, BSTR.Ptr, pbstrGuidSrcMachine)
    get_BodyLength(pcbBody)
      => ComCall(26, this.p, Int32.Ptr, pcbBody)
    get_Body(pvarBody)
      => ComCall(27, this.p, VARIANT.Ptr, pvarBody)
    put_Body(varBody)
      => ComCall(28, this.p, VARIANT, varBody)
    get_AdminQueueInfo_v1(ppqinfoAdmin)
      => ComCall(29, this.p, IMSMQQueueInfo.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo_v1(pqinfoAdmin?)
      => ComCall(30, this.p, IMSMQQueueInfo, pqinfoAdmin?)
    get_Id(pvarMsgId)
      => ComCall(31, this.p, VARIANT.Ptr, pvarMsgId)
    get_CorrelationId(pvarMsgId)
      => ComCall(32, this.p, VARIANT.Ptr, pvarMsgId)
    put_CorrelationId(varMsgId)
      => ComCall(33, this.p, VARIANT, varMsgId)
    get_Ack(plAck)
      => ComCall(34, this.p, Int32.Ptr, plAck)
    put_Ack(lAck)
      => ComCall(35, this.p, Int32, lAck)
    get_Label(pbstrLabel)
      => ComCall(36, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(37, this.p, BSTR, bstrLabel)
    get_MaxTimeToReachQueue(plMaxTimeToReachQueue)
      => ComCall(38, this.p, Int32.Ptr, plMaxTimeToReachQueue)
    put_MaxTimeToReachQueue(lMaxTimeToReachQueue)
      => ComCall(39, this.p, Int32, lMaxTimeToReachQueue)
    get_MaxTimeToReceive(plMaxTimeToReceive)
      => ComCall(40, this.p, Int32.Ptr, plMaxTimeToReceive)
    put_MaxTimeToReceive(lMaxTimeToReceive)
      => ComCall(41, this.p, Int32, lMaxTimeToReceive)
    get_HashAlgorithm(plHashAlg)
      => ComCall(42, this.p, Int32.Ptr, plHashAlg)
    put_HashAlgorithm(lHashAlg)
      => ComCall(43, this.p, Int32, lHashAlg)
    get_EncryptAlgorithm(plEncryptAlg)
      => ComCall(44, this.p, Int32.Ptr, plEncryptAlg)
    put_EncryptAlgorithm(lEncryptAlg)
      => ComCall(45, this.p, Int32, lEncryptAlg)
    get_SentTime(pvarSentTime)
      => ComCall(46, this.p, VARIANT.Ptr, pvarSentTime)
    get_ArrivedTime(plArrivedTime)
      => ComCall(47, this.p, VARIANT.Ptr, plArrivedTime)
    get_DestinationQueueInfo(ppqinfoDest)
      => ComCall(48, this.p, IMSMQQueueInfo2.Ptr, ppqinfoDest)
    get_SenderCertificate(pvarSenderCert)
      => ComCall(49, this.p, VARIANT.Ptr, pvarSenderCert)
    put_SenderCertificate(varSenderCert)
      => ComCall(50, this.p, VARIANT, varSenderCert)
    get_SenderId(pvarSenderId)
      => ComCall(51, this.p, VARIANT.Ptr, pvarSenderId)
    get_SenderIdType(plSenderIdType)
      => ComCall(52, this.p, Int32.Ptr, plSenderIdType)
    put_SenderIdType(lSenderIdType)
      => ComCall(53, this.p, Int32, lSenderIdType)
    Send(DestinationQueue?, Transaction)
      => ComCall(54, this.p, IMSMQQueue2, DestinationQueue?, VARIANT.Ptr, Transaction)
    AttachCurrentSecurityContext()
      => ComCall(55, this.p)
    get_SenderVersion(plSenderVersion)
      => ComCall(56, this.p, Int32.Ptr, plSenderVersion)
    get_Extension(pvarExtension)
      => ComCall(57, this.p, VARIANT.Ptr, pvarExtension)
    put_Extension(varExtension)
      => ComCall(58, this.p, VARIANT, varExtension)
    get_ConnectorTypeGuid(pbstrGuidConnectorType)
      => ComCall(59, this.p, BSTR.Ptr, pbstrGuidConnectorType)
    put_ConnectorTypeGuid(bstrGuidConnectorType)
      => ComCall(60, this.p, BSTR, bstrGuidConnectorType)
    get_TransactionStatusQueueInfo(ppqinfoXactStatus)
      => ComCall(61, this.p, IMSMQQueueInfo2.Ptr, ppqinfoXactStatus)
    get_DestinationSymmetricKey(pvarDestSymmKey)
      => ComCall(62, this.p, VARIANT.Ptr, pvarDestSymmKey)
    put_DestinationSymmetricKey(varDestSymmKey)
      => ComCall(63, this.p, VARIANT, varDestSymmKey)
    get_Signature(pvarSignature)
      => ComCall(64, this.p, VARIANT.Ptr, pvarSignature)
    put_Signature(varSignature)
      => ComCall(65, this.p, VARIANT, varSignature)
    get_AuthenticationProviderType(plAuthProvType)
      => ComCall(66, this.p, Int32.Ptr, plAuthProvType)
    put_AuthenticationProviderType(lAuthProvType)
      => ComCall(67, this.p, Int32, lAuthProvType)
    get_AuthenticationProviderName(pbstrAuthProvName)
      => ComCall(68, this.p, BSTR.Ptr, pbstrAuthProvName)
    put_AuthenticationProviderName(bstrAuthProvName)
      => ComCall(69, this.p, BSTR, bstrAuthProvName)
    put_SenderId(varSenderId)
      => ComCall(70, this.p, VARIANT, varSenderId)
    get_MsgClass(plMsgClass)
      => ComCall(71, this.p, Int32.Ptr, plMsgClass)
    put_MsgClass(lMsgClass)
      => ComCall(72, this.p, Int32, lMsgClass)
    get_Properties(ppcolProperties)
      => ComCall(73, this.p, IDispatch.Ptr, ppcolProperties)
    get_TransactionId(pvarXactId)
      => ComCall(74, this.p, VARIANT.Ptr, pvarXactId)
    get_IsFirstInTransaction(pisFirstInXact)
      => ComCall(75, this.p, Int16.Ptr, pisFirstInXact)
    get_IsLastInTransaction(pisLastInXact)
      => ComCall(76, this.p, Int16.Ptr, pisLastInXact)
    get_ResponseQueueInfo(ppqinfoResponse)
      => ComCall(77, this.p, IMSMQQueueInfo2.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo(pqinfoResponse?)
      => ComCall(78, this.p, IMSMQQueueInfo2, pqinfoResponse?)
    get_AdminQueueInfo(ppqinfoAdmin)
      => ComCall(79, this.p, IMSMQQueueInfo2.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo(pqinfoAdmin?)
      => ComCall(80, this.p, IMSMQQueueInfo2, pqinfoAdmin?)
    get_ReceivedAuthenticationLevel(psReceivedAuthenticationLevel)
      => ComCall(81, this.p, Int16.Ptr, psReceivedAuthenticationLevel)
}
struct IMSMQMessage3 extends IDispatch {
    static IID := "{EBA96B1A-2168-11D3-898C-00E02C074F6B}"
    get_Class(plClass)
      => ComCall(7, this.p, Int32.Ptr, plClass)
    get_PrivLevel(plPrivLevel)
      => ComCall(8, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(9, this.p, Int32, lPrivLevel)
    get_AuthLevel(plAuthLevel)
      => ComCall(10, this.p, Int32.Ptr, plAuthLevel)
    put_AuthLevel(lAuthLevel)
      => ComCall(11, this.p, Int32, lAuthLevel)
    get_IsAuthenticated(pisAuthenticated)
      => ComCall(12, this.p, Int16.Ptr, pisAuthenticated)
    get_Delivery(plDelivery)
      => ComCall(13, this.p, Int32.Ptr, plDelivery)
    put_Delivery(lDelivery)
      => ComCall(14, this.p, Int32, lDelivery)
    get_Trace(plTrace)
      => ComCall(15, this.p, Int32.Ptr, plTrace)
    put_Trace(lTrace)
      => ComCall(16, this.p, Int32, lTrace)
    get_Priority(plPriority)
      => ComCall(17, this.p, Int32.Ptr, plPriority)
    put_Priority(lPriority)
      => ComCall(18, this.p, Int32, lPriority)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_ResponseQueueInfo_v1(ppqinfoResponse)
      => ComCall(21, this.p, IMSMQQueueInfo.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo_v1(pqinfoResponse?)
      => ComCall(22, this.p, IMSMQQueueInfo, pqinfoResponse?)
    get_AppSpecific(plAppSpecific)
      => ComCall(23, this.p, Int32.Ptr, plAppSpecific)
    put_AppSpecific(lAppSpecific)
      => ComCall(24, this.p, Int32, lAppSpecific)
    get_SourceMachineGuid(pbstrGuidSrcMachine)
      => ComCall(25, this.p, BSTR.Ptr, pbstrGuidSrcMachine)
    get_BodyLength(pcbBody)
      => ComCall(26, this.p, Int32.Ptr, pcbBody)
    get_Body(pvarBody)
      => ComCall(27, this.p, VARIANT.Ptr, pvarBody)
    put_Body(varBody)
      => ComCall(28, this.p, VARIANT, varBody)
    get_AdminQueueInfo_v1(ppqinfoAdmin)
      => ComCall(29, this.p, IMSMQQueueInfo.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo_v1(pqinfoAdmin?)
      => ComCall(30, this.p, IMSMQQueueInfo, pqinfoAdmin?)
    get_Id(pvarMsgId)
      => ComCall(31, this.p, VARIANT.Ptr, pvarMsgId)
    get_CorrelationId(pvarMsgId)
      => ComCall(32, this.p, VARIANT.Ptr, pvarMsgId)
    put_CorrelationId(varMsgId)
      => ComCall(33, this.p, VARIANT, varMsgId)
    get_Ack(plAck)
      => ComCall(34, this.p, Int32.Ptr, plAck)
    put_Ack(lAck)
      => ComCall(35, this.p, Int32, lAck)
    get_Label(pbstrLabel)
      => ComCall(36, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(37, this.p, BSTR, bstrLabel)
    get_MaxTimeToReachQueue(plMaxTimeToReachQueue)
      => ComCall(38, this.p, Int32.Ptr, plMaxTimeToReachQueue)
    put_MaxTimeToReachQueue(lMaxTimeToReachQueue)
      => ComCall(39, this.p, Int32, lMaxTimeToReachQueue)
    get_MaxTimeToReceive(plMaxTimeToReceive)
      => ComCall(40, this.p, Int32.Ptr, plMaxTimeToReceive)
    put_MaxTimeToReceive(lMaxTimeToReceive)
      => ComCall(41, this.p, Int32, lMaxTimeToReceive)
    get_HashAlgorithm(plHashAlg)
      => ComCall(42, this.p, Int32.Ptr, plHashAlg)
    put_HashAlgorithm(lHashAlg)
      => ComCall(43, this.p, Int32, lHashAlg)
    get_EncryptAlgorithm(plEncryptAlg)
      => ComCall(44, this.p, Int32.Ptr, plEncryptAlg)
    put_EncryptAlgorithm(lEncryptAlg)
      => ComCall(45, this.p, Int32, lEncryptAlg)
    get_SentTime(pvarSentTime)
      => ComCall(46, this.p, VARIANT.Ptr, pvarSentTime)
    get_ArrivedTime(plArrivedTime)
      => ComCall(47, this.p, VARIANT.Ptr, plArrivedTime)
    get_DestinationQueueInfo(ppqinfoDest)
      => ComCall(48, this.p, IMSMQQueueInfo3.Ptr, ppqinfoDest)
    get_SenderCertificate(pvarSenderCert)
      => ComCall(49, this.p, VARIANT.Ptr, pvarSenderCert)
    put_SenderCertificate(varSenderCert)
      => ComCall(50, this.p, VARIANT, varSenderCert)
    get_SenderId(pvarSenderId)
      => ComCall(51, this.p, VARIANT.Ptr, pvarSenderId)
    get_SenderIdType(plSenderIdType)
      => ComCall(52, this.p, Int32.Ptr, plSenderIdType)
    put_SenderIdType(lSenderIdType)
      => ComCall(53, this.p, Int32, lSenderIdType)
    Send(DestinationQueue?, Transaction)
      => ComCall(54, this.p, IDispatch, DestinationQueue?, VARIANT.Ptr, Transaction)
    AttachCurrentSecurityContext()
      => ComCall(55, this.p)
    get_SenderVersion(plSenderVersion)
      => ComCall(56, this.p, Int32.Ptr, plSenderVersion)
    get_Extension(pvarExtension)
      => ComCall(57, this.p, VARIANT.Ptr, pvarExtension)
    put_Extension(varExtension)
      => ComCall(58, this.p, VARIANT, varExtension)
    get_ConnectorTypeGuid(pbstrGuidConnectorType)
      => ComCall(59, this.p, BSTR.Ptr, pbstrGuidConnectorType)
    put_ConnectorTypeGuid(bstrGuidConnectorType)
      => ComCall(60, this.p, BSTR, bstrGuidConnectorType)
    get_TransactionStatusQueueInfo(ppqinfoXactStatus)
      => ComCall(61, this.p, IMSMQQueueInfo3.Ptr, ppqinfoXactStatus)
    get_DestinationSymmetricKey(pvarDestSymmKey)
      => ComCall(62, this.p, VARIANT.Ptr, pvarDestSymmKey)
    put_DestinationSymmetricKey(varDestSymmKey)
      => ComCall(63, this.p, VARIANT, varDestSymmKey)
    get_Signature(pvarSignature)
      => ComCall(64, this.p, VARIANT.Ptr, pvarSignature)
    put_Signature(varSignature)
      => ComCall(65, this.p, VARIANT, varSignature)
    get_AuthenticationProviderType(plAuthProvType)
      => ComCall(66, this.p, Int32.Ptr, plAuthProvType)
    put_AuthenticationProviderType(lAuthProvType)
      => ComCall(67, this.p, Int32, lAuthProvType)
    get_AuthenticationProviderName(pbstrAuthProvName)
      => ComCall(68, this.p, BSTR.Ptr, pbstrAuthProvName)
    put_AuthenticationProviderName(bstrAuthProvName)
      => ComCall(69, this.p, BSTR, bstrAuthProvName)
    put_SenderId(varSenderId)
      => ComCall(70, this.p, VARIANT, varSenderId)
    get_MsgClass(plMsgClass)
      => ComCall(71, this.p, Int32.Ptr, plMsgClass)
    put_MsgClass(lMsgClass)
      => ComCall(72, this.p, Int32, lMsgClass)
    get_Properties(ppcolProperties)
      => ComCall(73, this.p, IDispatch.Ptr, ppcolProperties)
    get_TransactionId(pvarXactId)
      => ComCall(74, this.p, VARIANT.Ptr, pvarXactId)
    get_IsFirstInTransaction(pisFirstInXact)
      => ComCall(75, this.p, Int16.Ptr, pisFirstInXact)
    get_IsLastInTransaction(pisLastInXact)
      => ComCall(76, this.p, Int16.Ptr, pisLastInXact)
    get_ResponseQueueInfo_v2(ppqinfoResponse)
      => ComCall(77, this.p, IMSMQQueueInfo2.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo_v2(pqinfoResponse?)
      => ComCall(78, this.p, IMSMQQueueInfo2, pqinfoResponse?)
    get_AdminQueueInfo_v2(ppqinfoAdmin)
      => ComCall(79, this.p, IMSMQQueueInfo2.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo_v2(pqinfoAdmin?)
      => ComCall(80, this.p, IMSMQQueueInfo2, pqinfoAdmin?)
    get_ReceivedAuthenticationLevel(psReceivedAuthenticationLevel)
      => ComCall(81, this.p, Int16.Ptr, psReceivedAuthenticationLevel)
    get_ResponseQueueInfo(ppqinfoResponse)
      => ComCall(82, this.p, IMSMQQueueInfo3.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo(pqinfoResponse?)
      => ComCall(83, this.p, IMSMQQueueInfo3, pqinfoResponse?)
    get_AdminQueueInfo(ppqinfoAdmin)
      => ComCall(84, this.p, IMSMQQueueInfo3.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo(pqinfoAdmin?)
      => ComCall(85, this.p, IMSMQQueueInfo3, pqinfoAdmin?)
    get_ResponseDestination(ppdestResponse)
      => ComCall(86, this.p, IDispatch.Ptr, ppdestResponse)
    putref_ResponseDestination(pdestResponse?)
      => ComCall(87, this.p, IDispatch, pdestResponse?)
    get_Destination(ppdestDestination)
      => ComCall(88, this.p, IDispatch.Ptr, ppdestDestination)
    get_LookupId(pvarLookupId)
      => ComCall(89, this.p, VARIANT.Ptr, pvarLookupId)
    get_IsAuthenticated2(pisAuthenticated)
      => ComCall(90, this.p, VARIANT_BOOL.Ptr, pisAuthenticated)
    get_IsFirstInTransaction2(pisFirstInXact)
      => ComCall(91, this.p, VARIANT_BOOL.Ptr, pisFirstInXact)
    get_IsLastInTransaction2(pisLastInXact)
      => ComCall(92, this.p, VARIANT_BOOL.Ptr, pisLastInXact)
    AttachCurrentSecurityContext2()
      => ComCall(93, this.p)
    get_SoapEnvelope(pbstrSoapEnvelope)
      => ComCall(94, this.p, BSTR.Ptr, pbstrSoapEnvelope)
    get_CompoundMessage(pvarCompoundMessage)
      => ComCall(95, this.p, VARIANT.Ptr, pvarCompoundMessage)
    put_SoapHeader(bstrSoapHeader)
      => ComCall(96, this.p, BSTR, bstrSoapHeader)
    put_SoapBody(bstrSoapBody)
      => ComCall(97, this.p, BSTR, bstrSoapBody)
}
struct IMSMQMessage4 extends IDispatch {
    static IID := "{EBA96B23-2168-11D3-898C-00E02C074F6B}"
    get_Class(plClass)
      => ComCall(7, this.p, Int32.Ptr, plClass)
    get_PrivLevel(plPrivLevel)
      => ComCall(8, this.p, Int32.Ptr, plPrivLevel)
    put_PrivLevel(lPrivLevel)
      => ComCall(9, this.p, Int32, lPrivLevel)
    get_AuthLevel(plAuthLevel)
      => ComCall(10, this.p, Int32.Ptr, plAuthLevel)
    put_AuthLevel(lAuthLevel)
      => ComCall(11, this.p, Int32, lAuthLevel)
    get_IsAuthenticated(pisAuthenticated)
      => ComCall(12, this.p, Int16.Ptr, pisAuthenticated)
    get_Delivery(plDelivery)
      => ComCall(13, this.p, Int32.Ptr, plDelivery)
    put_Delivery(lDelivery)
      => ComCall(14, this.p, Int32, lDelivery)
    get_Trace(plTrace)
      => ComCall(15, this.p, Int32.Ptr, plTrace)
    put_Trace(lTrace)
      => ComCall(16, this.p, Int32, lTrace)
    get_Priority(plPriority)
      => ComCall(17, this.p, Int32.Ptr, plPriority)
    put_Priority(lPriority)
      => ComCall(18, this.p, Int32, lPriority)
    get_Journal(plJournal)
      => ComCall(19, this.p, Int32.Ptr, plJournal)
    put_Journal(lJournal)
      => ComCall(20, this.p, Int32, lJournal)
    get_ResponseQueueInfo_v1(ppqinfoResponse)
      => ComCall(21, this.p, IMSMQQueueInfo.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo_v1(pqinfoResponse?)
      => ComCall(22, this.p, IMSMQQueueInfo, pqinfoResponse?)
    get_AppSpecific(plAppSpecific)
      => ComCall(23, this.p, Int32.Ptr, plAppSpecific)
    put_AppSpecific(lAppSpecific)
      => ComCall(24, this.p, Int32, lAppSpecific)
    get_SourceMachineGuid(pbstrGuidSrcMachine)
      => ComCall(25, this.p, BSTR.Ptr, pbstrGuidSrcMachine)
    get_BodyLength(pcbBody)
      => ComCall(26, this.p, Int32.Ptr, pcbBody)
    get_Body(pvarBody)
      => ComCall(27, this.p, VARIANT.Ptr, pvarBody)
    put_Body(varBody)
      => ComCall(28, this.p, VARIANT, varBody)
    get_AdminQueueInfo_v1(ppqinfoAdmin)
      => ComCall(29, this.p, IMSMQQueueInfo.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo_v1(pqinfoAdmin?)
      => ComCall(30, this.p, IMSMQQueueInfo, pqinfoAdmin?)
    get_Id(pvarMsgId)
      => ComCall(31, this.p, VARIANT.Ptr, pvarMsgId)
    get_CorrelationId(pvarMsgId)
      => ComCall(32, this.p, VARIANT.Ptr, pvarMsgId)
    put_CorrelationId(varMsgId)
      => ComCall(33, this.p, VARIANT, varMsgId)
    get_Ack(plAck)
      => ComCall(34, this.p, Int32.Ptr, plAck)
    put_Ack(lAck)
      => ComCall(35, this.p, Int32, lAck)
    get_Label(pbstrLabel)
      => ComCall(36, this.p, BSTR.Ptr, pbstrLabel)
    put_Label(bstrLabel)
      => ComCall(37, this.p, BSTR, bstrLabel)
    get_MaxTimeToReachQueue(plMaxTimeToReachQueue)
      => ComCall(38, this.p, Int32.Ptr, plMaxTimeToReachQueue)
    put_MaxTimeToReachQueue(lMaxTimeToReachQueue)
      => ComCall(39, this.p, Int32, lMaxTimeToReachQueue)
    get_MaxTimeToReceive(plMaxTimeToReceive)
      => ComCall(40, this.p, Int32.Ptr, plMaxTimeToReceive)
    put_MaxTimeToReceive(lMaxTimeToReceive)
      => ComCall(41, this.p, Int32, lMaxTimeToReceive)
    get_HashAlgorithm(plHashAlg)
      => ComCall(42, this.p, Int32.Ptr, plHashAlg)
    put_HashAlgorithm(lHashAlg)
      => ComCall(43, this.p, Int32, lHashAlg)
    get_EncryptAlgorithm(plEncryptAlg)
      => ComCall(44, this.p, Int32.Ptr, plEncryptAlg)
    put_EncryptAlgorithm(lEncryptAlg)
      => ComCall(45, this.p, Int32, lEncryptAlg)
    get_SentTime(pvarSentTime)
      => ComCall(46, this.p, VARIANT.Ptr, pvarSentTime)
    get_ArrivedTime(plArrivedTime)
      => ComCall(47, this.p, VARIANT.Ptr, plArrivedTime)
    get_DestinationQueueInfo(ppqinfoDest)
      => ComCall(48, this.p, IMSMQQueueInfo4.Ptr, ppqinfoDest)
    get_SenderCertificate(pvarSenderCert)
      => ComCall(49, this.p, VARIANT.Ptr, pvarSenderCert)
    put_SenderCertificate(varSenderCert)
      => ComCall(50, this.p, VARIANT, varSenderCert)
    get_SenderId(pvarSenderId)
      => ComCall(51, this.p, VARIANT.Ptr, pvarSenderId)
    get_SenderIdType(plSenderIdType)
      => ComCall(52, this.p, Int32.Ptr, plSenderIdType)
    put_SenderIdType(lSenderIdType)
      => ComCall(53, this.p, Int32, lSenderIdType)
    Send(DestinationQueue?, Transaction)
      => ComCall(54, this.p, IDispatch, DestinationQueue?, VARIANT.Ptr, Transaction)
    AttachCurrentSecurityContext()
      => ComCall(55, this.p)
    get_SenderVersion(plSenderVersion)
      => ComCall(56, this.p, Int32.Ptr, plSenderVersion)
    get_Extension(pvarExtension)
      => ComCall(57, this.p, VARIANT.Ptr, pvarExtension)
    put_Extension(varExtension)
      => ComCall(58, this.p, VARIANT, varExtension)
    get_ConnectorTypeGuid(pbstrGuidConnectorType)
      => ComCall(59, this.p, BSTR.Ptr, pbstrGuidConnectorType)
    put_ConnectorTypeGuid(bstrGuidConnectorType)
      => ComCall(60, this.p, BSTR, bstrGuidConnectorType)
    get_TransactionStatusQueueInfo(ppqinfoXactStatus)
      => ComCall(61, this.p, IMSMQQueueInfo4.Ptr, ppqinfoXactStatus)
    get_DestinationSymmetricKey(pvarDestSymmKey)
      => ComCall(62, this.p, VARIANT.Ptr, pvarDestSymmKey)
    put_DestinationSymmetricKey(varDestSymmKey)
      => ComCall(63, this.p, VARIANT, varDestSymmKey)
    get_Signature(pvarSignature)
      => ComCall(64, this.p, VARIANT.Ptr, pvarSignature)
    put_Signature(varSignature)
      => ComCall(65, this.p, VARIANT, varSignature)
    get_AuthenticationProviderType(plAuthProvType)
      => ComCall(66, this.p, Int32.Ptr, plAuthProvType)
    put_AuthenticationProviderType(lAuthProvType)
      => ComCall(67, this.p, Int32, lAuthProvType)
    get_AuthenticationProviderName(pbstrAuthProvName)
      => ComCall(68, this.p, BSTR.Ptr, pbstrAuthProvName)
    put_AuthenticationProviderName(bstrAuthProvName)
      => ComCall(69, this.p, BSTR, bstrAuthProvName)
    put_SenderId(varSenderId)
      => ComCall(70, this.p, VARIANT, varSenderId)
    get_MsgClass(plMsgClass)
      => ComCall(71, this.p, Int32.Ptr, plMsgClass)
    put_MsgClass(lMsgClass)
      => ComCall(72, this.p, Int32, lMsgClass)
    get_Properties(ppcolProperties)
      => ComCall(73, this.p, IDispatch.Ptr, ppcolProperties)
    get_TransactionId(pvarXactId)
      => ComCall(74, this.p, VARIANT.Ptr, pvarXactId)
    get_IsFirstInTransaction(pisFirstInXact)
      => ComCall(75, this.p, Int16.Ptr, pisFirstInXact)
    get_IsLastInTransaction(pisLastInXact)
      => ComCall(76, this.p, Int16.Ptr, pisLastInXact)
    get_ResponseQueueInfo_v2(ppqinfoResponse)
      => ComCall(77, this.p, IMSMQQueueInfo2.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo_v2(pqinfoResponse?)
      => ComCall(78, this.p, IMSMQQueueInfo2, pqinfoResponse?)
    get_AdminQueueInfo_v2(ppqinfoAdmin)
      => ComCall(79, this.p, IMSMQQueueInfo2.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo_v2(pqinfoAdmin?)
      => ComCall(80, this.p, IMSMQQueueInfo2, pqinfoAdmin?)
    get_ReceivedAuthenticationLevel(psReceivedAuthenticationLevel)
      => ComCall(81, this.p, Int16.Ptr, psReceivedAuthenticationLevel)
    get_ResponseQueueInfo(ppqinfoResponse)
      => ComCall(82, this.p, IMSMQQueueInfo4.Ptr, ppqinfoResponse)
    putref_ResponseQueueInfo(pqinfoResponse?)
      => ComCall(83, this.p, IMSMQQueueInfo4, pqinfoResponse?)
    get_AdminQueueInfo(ppqinfoAdmin)
      => ComCall(84, this.p, IMSMQQueueInfo4.Ptr, ppqinfoAdmin)
    putref_AdminQueueInfo(pqinfoAdmin?)
      => ComCall(85, this.p, IMSMQQueueInfo4, pqinfoAdmin?)
    get_ResponseDestination(ppdestResponse)
      => ComCall(86, this.p, IDispatch.Ptr, ppdestResponse)
    putref_ResponseDestination(pdestResponse?)
      => ComCall(87, this.p, IDispatch, pdestResponse?)
    get_Destination(ppdestDestination)
      => ComCall(88, this.p, IDispatch.Ptr, ppdestDestination)
    get_LookupId(pvarLookupId)
      => ComCall(89, this.p, VARIANT.Ptr, pvarLookupId)
    get_IsAuthenticated2(pisAuthenticated)
      => ComCall(90, this.p, VARIANT_BOOL.Ptr, pisAuthenticated)
    get_IsFirstInTransaction2(pisFirstInXact)
      => ComCall(91, this.p, VARIANT_BOOL.Ptr, pisFirstInXact)
    get_IsLastInTransaction2(pisLastInXact)
      => ComCall(92, this.p, VARIANT_BOOL.Ptr, pisLastInXact)
    AttachCurrentSecurityContext2()
      => ComCall(93, this.p)
    get_SoapEnvelope(pbstrSoapEnvelope)
      => ComCall(94, this.p, BSTR.Ptr, pbstrSoapEnvelope)
    get_CompoundMessage(pvarCompoundMessage)
      => ComCall(95, this.p, VARIANT.Ptr, pvarCompoundMessage)
    put_SoapHeader(bstrSoapHeader)
      => ComCall(96, this.p, BSTR, bstrSoapHeader)
    put_SoapBody(bstrSoapBody)
      => ComCall(97, this.p, BSTR, bstrSoapBody)
}
struct IMSMQPrivateEvent extends IDispatch {
    static IID := "{D7AB3341-C9D3-11D1-BB47-0080C7C5A2C0}"
    get_Hwnd(phwnd)
      => ComCall(7, this.p, Int32.Ptr, phwnd)
    FireArrivedEvent(pq?, msgcursor)
      => ComCall(8, this.p, IMSMQQueue, pq?, Int32, msgcursor)
    FireArrivedErrorEvent(pq?, hrStatus, msgcursor)
      => ComCall(9, this.p, IMSMQQueue, pq?, HRESULT, hrStatus, Int32, msgcursor)
}
struct DMSMQEventEvents extends IDispatch {
    static IID := "{D7D6E078-DCCD-11D0-AA4B-0060970DEBAE}"
}
struct IMSMQTransaction2 extends IMSMQTransaction {
    static IID := "{2CE0C5B0-6E67-11D2-B0E6-00E02C074F6B}"
    InitNew(varTransaction)
      => ComCall(10, this.p, VARIANT, varTransaction)
    get_Properties(ppcolProperties)
      => ComCall(11, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQTransaction3 extends IMSMQTransaction2 {
    static IID := "{EBA96B13-2168-11D3-898C-00E02C074F6B}"
    get_ITransaction(pvarITransaction)
      => ComCall(12, this.p, VARIANT.Ptr, pvarITransaction)
}
struct IMSMQCoordinatedTransactionDispenser2 extends IDispatch {
    static IID := "{EBA96B10-2168-11D3-898C-00E02C074F6B}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction2.Ptr, ptransaction)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQCoordinatedTransactionDispenser3 extends IDispatch {
    static IID := "{EBA96B14-2168-11D3-898C-00E02C074F6B}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction3.Ptr, ptransaction)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQTransactionDispenser2 extends IDispatch {
    static IID := "{EBA96B11-2168-11D3-898C-00E02C074F6B}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction2.Ptr, ptransaction)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQTransactionDispenser3 extends IDispatch {
    static IID := "{EBA96B15-2168-11D3-898C-00E02C074F6B}"
    BeginTransaction(ptransaction)
      => ComCall(7, this.p, IMSMQTransaction3.Ptr, ptransaction)
    get_Properties(ppcolProperties)
      => ComCall(8, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQApplication extends IDispatch {
    static IID := "{D7D6E085-DCCD-11D0-AA4B-0060970DEBAE}"
    MachineIdOfMachineName(MachineName, pbstrGuid)
      => ComCall(7, this.p, BSTR, MachineName, BSTR.Ptr, pbstrGuid)
}
struct IMSMQApplication2 extends IMSMQApplication {
    static IID := "{12A30900-7300-11D2-B0E6-00E02C074F6B}"
    RegisterCertificate(Flags, ExternalCertificate)
      => ComCall(8, this.p, VARIANT.Ptr, Flags, VARIANT.Ptr, ExternalCertificate)
    MachineNameOfMachineId(bstrGuid, pbstrMachineName)
      => ComCall(9, this.p, BSTR, bstrGuid, BSTR.Ptr, pbstrMachineName)
    get_MSMQVersionMajor(psMSMQVersionMajor)
      => ComCall(10, this.p, Int16.Ptr, psMSMQVersionMajor)
    get_MSMQVersionMinor(psMSMQVersionMinor)
      => ComCall(11, this.p, Int16.Ptr, psMSMQVersionMinor)
    get_MSMQVersionBuild(psMSMQVersionBuild)
      => ComCall(12, this.p, Int16.Ptr, psMSMQVersionBuild)
    get_IsDsEnabled(pfIsDsEnabled)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pfIsDsEnabled)
    get_Properties(ppcolProperties)
      => ComCall(14, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQApplication3 extends IMSMQApplication2 {
    static IID := "{EBA96B1F-2168-11D3-898C-00E02C074F6B}"
    get_ActiveQueues(pvActiveQueues)
      => ComCall(15, this.p, VARIANT.Ptr, pvActiveQueues)
    get_PrivateQueues(pvPrivateQueues)
      => ComCall(16, this.p, VARIANT.Ptr, pvPrivateQueues)
    get_DirectoryServiceServer(pbstrDirectoryServiceServer)
      => ComCall(17, this.p, BSTR.Ptr, pbstrDirectoryServiceServer)
    get_IsConnected(pfIsConnected)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pfIsConnected)
    get_BytesInAllQueues(pvBytesInAllQueues)
      => ComCall(19, this.p, VARIANT.Ptr, pvBytesInAllQueues)
    put_Machine(bstrMachine)
      => ComCall(20, this.p, BSTR, bstrMachine)
    get_Machine(pbstrMachine)
      => ComCall(21, this.p, BSTR.Ptr, pbstrMachine)
    Connect()
      => ComCall(22, this.p)
    Disconnect()
      => ComCall(23, this.p)
    Tidy()
      => ComCall(24, this.p)
}
struct IMSMQDestination extends IDispatch {
    static IID := "{EBA96B16-2168-11D3-898C-00E02C074F6B}"
    Open()
      => ComCall(7, this.p)
    Close()
      => ComCall(8, this.p)
    get_IsOpen(pfIsOpen)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pfIsOpen)
    get_IADs(ppIADs)
      => ComCall(10, this.p, IDispatch.Ptr, ppIADs)
    putref_IADs(pIADs?)
      => ComCall(11, this.p, IDispatch, pIADs?)
    get_ADsPath(pbstrADsPath)
      => ComCall(12, this.p, BSTR.Ptr, pbstrADsPath)
    put_ADsPath(bstrADsPath)
      => ComCall(13, this.p, BSTR, bstrADsPath)
    get_PathName(pbstrPathName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrPathName)
    put_PathName(bstrPathName)
      => ComCall(15, this.p, BSTR, bstrPathName)
    get_FormatName(pbstrFormatName)
      => ComCall(16, this.p, BSTR.Ptr, pbstrFormatName)
    put_FormatName(bstrFormatName)
      => ComCall(17, this.p, BSTR, bstrFormatName)
    get_Destinations(ppDestinations)
      => ComCall(18, this.p, IDispatch.Ptr, ppDestinations)
    putref_Destinations(pDestinations?)
      => ComCall(19, this.p, IDispatch, pDestinations?)
    get_Properties(ppcolProperties)
      => ComCall(20, this.p, IDispatch.Ptr, ppcolProperties)
}
struct IMSMQPrivateDestination extends IDispatch {
    static IID := "{EBA96B17-2168-11D3-898C-00E02C074F6B}"
    get_Handle(pvarHandle)
      => ComCall(7, this.p, VARIANT.Ptr, pvarHandle)
    put_Handle(varHandle)
      => ComCall(8, this.p, VARIANT, varHandle)
}
struct IMSMQCollection extends IDispatch {
    static IID := "{0188AC2F-ECB3-4173-9779-635CA2039C72}"
    Item(Index, pvarRet)
      => ComCall(7, this.p, VARIANT.Ptr, Index, VARIANT.Ptr, pvarRet)
    get_Count(pCount)
      => ComCall(8, this.p, Int32.Ptr, pCount)
    _NewEnum(ppunk)
      => ComCall(9, this.p, IUnknown.Ptr, ppunk)
}
struct IMSMQManagement extends IDispatch {
    static IID := "{BE5F0241-E489-4957-8CC4-A452FCF3E23E}"
    Init(Machine, Pathname, FormatName)
      => ComCall(7, this.p, VARIANT.Ptr, Machine, VARIANT.Ptr, Pathname, VARIANT.Ptr, FormatName)
    get_FormatName(pbstrFormatName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrFormatName)
    get_Machine(pbstrMachine)
      => ComCall(9, this.p, BSTR.Ptr, pbstrMachine)
    get_MessageCount(plMessageCount)
      => ComCall(10, this.p, Int32.Ptr, plMessageCount)
    get_ForeignStatus(plForeignStatus)
      => ComCall(11, this.p, Int32.Ptr, plForeignStatus)
    get_QueueType(plQueueType)
      => ComCall(12, this.p, Int32.Ptr, plQueueType)
    get_IsLocal(pfIsLocal)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pfIsLocal)
    get_TransactionalStatus(plTransactionalStatus)
      => ComCall(14, this.p, Int32.Ptr, plTransactionalStatus)
    get_BytesInQueue(pvBytesInQueue)
      => ComCall(15, this.p, VARIANT.Ptr, pvBytesInQueue)
}
struct IMSMQOutgoingQueueManagement extends IMSMQManagement {
    static IID := "{64C478FB-F9B0-4695-8A7F-439AC94326D3}"
    get_State(plState)
      => ComCall(16, this.p, Int32.Ptr, plState)
    get_NextHops(pvNextHops)
      => ComCall(17, this.p, VARIANT.Ptr, pvNextHops)
    EodGetSendInfo(ppCollection)
      => ComCall(18, this.p, IMSMQCollection.Ptr, ppCollection)
    Resume()
      => ComCall(19, this.p)
    Pause()
      => ComCall(20, this.p)
    EodResend()
      => ComCall(21, this.p)
}
struct IMSMQQueueManagement extends IMSMQManagement {
    static IID := "{7FBE7759-5760-444D-B8A5-5E7AB9A84CCE}"
    get_JournalMessageCount(plJournalMessageCount)
      => ComCall(16, this.p, Int32.Ptr, plJournalMessageCount)
    get_BytesInJournal(pvBytesInJournal)
      => ComCall(17, this.p, VARIANT.Ptr, pvBytesInJournal)
    EodGetReceiveInfo(pvCollection)
      => ComCall(18, this.p, VARIANT.Ptr, pvCollection)
}
struct MQPROPERTYRESTRICTION {
    rel : UInt32
    prop : UInt32
    prval : PROPVARIANT
}
struct MQRESTRICTION {
    cRes : UInt32
    paPropRes : MQPROPERTYRESTRICTION.Ptr
}
struct MQCOLUMNSET {
    cCol : UInt32
    aCol : UInt32.Ptr
}
struct MQSORTKEY {
    propColumn : UInt32
    dwOrder : UInt32
}
struct MQSORTSET {
    cCol : UInt32
    aCol : MQSORTKEY.Ptr
}
struct MQMSGPROPS {
    cProp : UInt32
    aPropID : UInt32.Ptr
    aPropVar : PROPVARIANT.Ptr
    aStatus : HRESULT.Ptr
}
struct MQQUEUEPROPS {
    cProp : UInt32
    aPropID : UInt32.Ptr
    aPropVar : PROPVARIANT.Ptr
    aStatus : HRESULT.Ptr
}
struct MQQMPROPS {
    cProp : UInt32
    aPropID : UInt32.Ptr
    aPropVar : PROPVARIANT.Ptr
    aStatus : HRESULT.Ptr
}
struct MQPRIVATEPROPS {
    cProp : UInt32
    aPropID : UInt32.Ptr
    aPropVar : PROPVARIANT.Ptr
    aStatus : HRESULT.Ptr
}
struct MQMGMTPROPS {
    cProp : UInt32
    aPropID : UInt32.Ptr
    aPropVar : PROPVARIANT.Ptr
    aStatus : HRESULT.Ptr
}
struct SEQUENCE_INFO {
    SeqID : Int64
    SeqNo : UInt32
    PrevNo : UInt32
}
struct MQConnectionState extends Int32 {
    static MQCONN_NOFAILURE := 0
    static MQCONN_ESTABLISH_PACKET_RECEIVED := 1
    static MQCONN_READY := 2
    static MQCONN_UNKNOWN_FAILURE := -2147483648
    static MQCONN_PING_FAILURE := -2147483647
    static MQCONN_CREATE_SOCKET_FAILURE := -2147483646
    static MQCONN_BIND_SOCKET_FAILURE := -2147483645
    static MQCONN_CONNECT_SOCKET_FAILURE := -2147483644
    static MQCONN_TCP_NOT_ENABLED := -2147483643
    static MQCONN_SEND_FAILURE := -2147483642
    static MQCONN_NOT_READY := -2147483641
    static MQCONN_NAME_RESOLUTION_FAILURE := -2147483640
    static MQCONN_INVALID_SERVER_CERT := -2147483639
    static MQCONN_LIMIT_REACHED := -2147483638
    static MQCONN_REFUSED_BY_OTHER_SIDE := -2147483637
    static MQCONN_ROUTING_FAILURE := -2147483636
    static MQCONN_OUT_OF_MEMORY := -2147483635
}
struct PMQRECEIVECALLBACK extends FunctionPointer {
    static Types := [HRESULT, IntPtr, UInt32, UInt32, MQMSGPROPS.Ptr, OVERLAPPED.Ptr, HANDLE, "Void"]
}
