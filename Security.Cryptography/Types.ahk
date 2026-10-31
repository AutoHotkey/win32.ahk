#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FILETIME, HANDLE, HRESULT, HWND, NTSTATUS, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\Security\Types.ahk" {NCRYPT_DESCRIPTOR_HANDLE}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct BCRYPT_OPERATION extends UInt32 {
    static BCRYPT_CIPHER_OPERATION := 1
    static BCRYPT_HASH_OPERATION := 2
    static BCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION := 4
    static BCRYPT_SECRET_AGREEMENT_OPERATION := 8
    static BCRYPT_SIGNATURE_OPERATION := 16
    static BCRYPT_RNG_OPERATION := 32
}
struct NCRYPT_OPERATION extends UInt32 {
    static NCRYPT_CIPHER_OPERATION := 1
    static NCRYPT_HASH_OPERATION := 2
    static NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION := 4
    static NCRYPT_SECRET_AGREEMENT_OPERATION := 8
    static NCRYPT_SIGNATURE_OPERATION := 16
}
struct CERT_FIND_FLAGS extends UInt32 {
    static CERT_FIND_ANY := 0
    static CERT_FIND_CERT_ID := 1048576
    static CERT_FIND_CTL_USAGE := 655360
    static CERT_FIND_ENHKEY_USAGE := 655360
    static CERT_FIND_EXISTING := 851968
    static CERT_FIND_HASH := 65536
    static CERT_FIND_HAS_PRIVATE_KEY := 1376256
    static CERT_FIND_ISSUER_ATTR := 196612
    static CERT_FIND_ISSUER_NAME := 131076
    static CERT_FIND_ISSUER_OF := 786432
    static CERT_FIND_ISSUER_STR := 524292
    static CERT_FIND_KEY_IDENTIFIER := 983040
    static CERT_FIND_KEY_SPEC := 589824
    static CERT_FIND_MD5_HASH := 262144
    static CERT_FIND_PROPERTY := 327680
    static CERT_FIND_PUBLIC_KEY := 393216
    static CERT_FIND_SHA1_HASH := 65536
    static CERT_FIND_SIGNATURE_HASH := 917504
    static CERT_FIND_SUBJECT_ATTR := 196615
    static CERT_FIND_SUBJECT_CERT := 720896
    static CERT_FIND_SUBJECT_NAME := 131079
    static CERT_FIND_SUBJECT_STR := 524295
    static CERT_FIND_CROSS_CERT_DIST_POINTS := 1114112
    static CERT_FIND_PUBKEY_MD5_HASH := 1179648
    static CERT_FIND_SHA256_HASH := 1441792
    static CERT_FIND_SHA1_SHA256_HASH := 1507328
    static CERT_FIND_SUBJECT_STR_A := 458759
    static CERT_FIND_SUBJECT_STR_W := 524295
    static CERT_FIND_ISSUER_STR_A := 458756
    static CERT_FIND_ISSUER_STR_W := 524292
    static CERT_FIND_SUBJECT_INFO_ACCESS := 1245184
    static CERT_FIND_HASH_STR := 1310720
    static CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG := 1
    static CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG := 2
    static CERT_FIND_PROP_ONLY_ENHKEY_USAGE_FLAG := 4
    static CERT_FIND_NO_ENHKEY_USAGE_FLAG := 8
    static CERT_FIND_OR_ENHKEY_USAGE_FLAG := 16
    static CERT_FIND_VALID_ENHKEY_USAGE_FLAG := 32
    static CERT_FIND_OPTIONAL_CTL_USAGE_FLAG := 1
    static CERT_FIND_EXT_ONLY_CTL_USAGE_FLAG := 2
    static CERT_FIND_PROP_ONLY_CTL_USAGE_FLAG := 4
    static CERT_FIND_NO_CTL_USAGE_FLAG := 8
    static CERT_FIND_OR_CTL_USAGE_FLAG := 16
    static CERT_FIND_VALID_CTL_USAGE_FLAG := 32
}
struct CERT_QUERY_OBJECT_TYPE extends UInt32 {
    static CERT_QUERY_OBJECT_FILE := 1
    static CERT_QUERY_OBJECT_BLOB := 2
}
struct CERT_QUERY_CONTENT_TYPE extends UInt32 {
    static CERT_QUERY_CONTENT_CERT := 1
    static CERT_QUERY_CONTENT_CTL := 2
    static CERT_QUERY_CONTENT_CRL := 3
    static CERT_QUERY_CONTENT_SERIALIZED_STORE := 4
    static CERT_QUERY_CONTENT_SERIALIZED_CERT := 5
    static CERT_QUERY_CONTENT_SERIALIZED_CTL := 6
    static CERT_QUERY_CONTENT_SERIALIZED_CRL := 7
    static CERT_QUERY_CONTENT_PKCS7_SIGNED := 8
    static CERT_QUERY_CONTENT_PKCS7_UNSIGNED := 9
    static CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED := 10
    static CERT_QUERY_CONTENT_PKCS10 := 11
    static CERT_QUERY_CONTENT_PFX := 12
    static CERT_QUERY_CONTENT_CERT_PAIR := 13
    static CERT_QUERY_CONTENT_PFX_AND_LOAD := 14
}
struct CERT_QUERY_CONTENT_TYPE_FLAGS extends UInt32 {
    static CERT_QUERY_CONTENT_FLAG_CERT := 2
    static CERT_QUERY_CONTENT_FLAG_CTL := 4
    static CERT_QUERY_CONTENT_FLAG_CRL := 8
    static CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE := 16
    static CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT := 32
    static CERT_QUERY_CONTENT_FLAG_SERIALIZED_CTL := 64
    static CERT_QUERY_CONTENT_FLAG_SERIALIZED_CRL := 128
    static CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED := 256
    static CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED := 512
    static CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED := 1024
    static CERT_QUERY_CONTENT_FLAG_PKCS10 := 2048
    static CERT_QUERY_CONTENT_FLAG_PFX := 4096
    static CERT_QUERY_CONTENT_FLAG_CERT_PAIR := 8192
    static CERT_QUERY_CONTENT_FLAG_PFX_AND_LOAD := 16384
    static CERT_QUERY_CONTENT_FLAG_ALL := 16382
    static CERT_QUERY_CONTENT_FLAG_ALL_ISSUER_CERT := 818
}
struct CERT_QUERY_FORMAT_TYPE extends UInt32 {
    static CERT_QUERY_FORMAT_BINARY := 1
    static CERT_QUERY_FORMAT_BASE64_ENCODED := 2
    static CERT_QUERY_FORMAT_ASN_ASCII_HEX_ENCODED := 3
}
struct CERT_QUERY_FORMAT_TYPE_FLAGS extends UInt32 {
    static CERT_QUERY_FORMAT_FLAG_BINARY := 2
    static CERT_QUERY_FORMAT_FLAG_BASE64_ENCODED := 4
    static CERT_QUERY_FORMAT_FLAG_ASN_ASCII_HEX_ENCODED := 8
    static CERT_QUERY_FORMAT_FLAG_ALL := 14
}
struct CERT_QUERY_ENCODING_TYPE extends UInt32 {
    static X509_ASN_ENCODING := 1
    static PKCS_7_ASN_ENCODING := 65536
}
struct CERT_RDN_ATTR_VALUE_TYPE extends Int32 {
    static CERT_RDN_ANY_TYPE := 0
    static CERT_RDN_NUMERIC_STRING := 3
    static CERT_RDN_PRINTABLE_STRING := 4
    static CERT_RDN_T61_STRING := 5
    static CERT_RDN_VIDEOTEX_STRING := 6
    static CERT_RDN_IA5_STRING := 7
    static CERT_RDN_GRAPHIC_STRING := 8
    static CERT_RDN_ISO646_STRING := 9
    static CERT_RDN_GENERAL_STRING := 10
    static CERT_RDN_INT4_STRING := 11
    static CERT_RDN_UNICODE_STRING := 12
    static CERT_RDN_BMP_STRING := 12
    static CERT_RDN_ENCODED_BLOB := 1
    static CERT_RDN_OCTET_STRING := 2
    static CERT_RDN_TELETEX_STRING := 5
    static CERT_RDN_UNIVERSAL_STRING := 11
    static CERT_RDN_UTF8_STRING := 13
    static CERT_RDN_VISIBLE_STRING := 9
}
struct CERT_STRING_TYPE extends UInt32 {
    static CERT_SIMPLE_NAME_STR := 1
    static CERT_OID_NAME_STR := 2
    static CERT_X500_NAME_STR := 3
}
struct BCRYPT_TABLE extends UInt32 {
    static CRYPT_LOCAL := 1
    static CRYPT_DOMAIN := 2
}
struct CERT_KEY_SPEC extends UInt32 {
    static AT_KEYEXCHANGE := 1
    static AT_SIGNATURE := 2
    static CERT_NCRYPT_KEY_SPEC := 4294967295
}
struct BCRYPT_INTERFACE extends UInt32 {
    static BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE := 3
    static BCRYPT_CIPHER_INTERFACE := 1
    static BCRYPT_HASH_INTERFACE := 2
    static BCRYPT_RNG_INTERFACE := 6
    static BCRYPT_SECRET_AGREEMENT_INTERFACE := 4
    static BCRYPT_SIGNATURE_INTERFACE := 5
    static NCRYPT_KEY_STORAGE_INTERFACE := 65537
    static NCRYPT_SCHANNEL_INTERFACE := 65538
    static NCRYPT_SCHANNEL_SIGNATURE_INTERFACE := 65539
}
struct BCRYPT_FLAGS extends UInt32 {
    static BCRYPT_BLOCK_PADDING := 1
    static BCRYPT_PAD_NONE := 1
    static BCRYPT_PAD_OAEP := 4
    static BCRYPT_PAD_PKCS1 := 2
    static BCRYPT_PAD_PSS := 8
}
struct NCRYPT_FLAGS extends UInt32 {
    static NCRYPT_SILENT_FLAG := 64
    static NCRYPT_NO_PADDING_FLAG := 1
    static NCRYPT_PAD_OAEP_FLAG := 4
    static NCRYPT_PAD_PKCS1_FLAG := 2
    static NCRYPT_REGISTER_NOTIFY_FLAG := 1
    static NCRYPT_UNREGISTER_NOTIFY_FLAG := 2
    static NCRYPT_MACHINE_KEY_FLAG := 32
    static NCRYPT_UNPROTECT_NO_DECRYPT := 1
    static NCRYPT_OVERWRITE_KEY_FLAG := 128
    static NCRYPT_NO_KEY_VALIDATION := 8
    static NCRYPT_WRITE_KEY_TO_LEGACY_STORE_FLAG := 512
    static NCRYPT_PAD_PSS_FLAG := 8
    static NCRYPT_PERSIST_FLAG := 2147483648
    static NCRYPT_PERSIST_ONLY_FLAG := 1073741824
}
struct CRYPT_STRING extends UInt32 {
    static CRYPT_STRING_BASE64HEADER := 0
    static CRYPT_STRING_BASE64 := 1
    static CRYPT_STRING_BINARY := 2
    static CRYPT_STRING_BASE64REQUESTHEADER := 3
    static CRYPT_STRING_HEX := 4
    static CRYPT_STRING_HEXASCII := 5
    static CRYPT_STRING_BASE64X509CRLHEADER := 9
    static CRYPT_STRING_HEXADDR := 10
    static CRYPT_STRING_HEXASCIIADDR := 11
    static CRYPT_STRING_HEXRAW := 12
    static CRYPT_STRING_STRICT := 536870912
    static CRYPT_STRING_BASE64_ANY := 6
    static CRYPT_STRING_ANY := 7
    static CRYPT_STRING_HEX_ANY := 8
}
struct CRYPT_IMPORT_PUBLIC_KEY_FLAGS extends UInt32 {
    static CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG := 2147483648
    static CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG := 1073741824
}
struct CRYPT_XML_FLAGS extends UInt32 {
    static CRYPT_XML_FLAG_DISABLE_EXTENSIONS := 268435456
    static CRYPT_XML_FLAG_NO_SERIALIZE := 2147483648
    static CRYPT_XML_SIGN_ADD_KEYVALUE := 1
}
struct CRYPT_ENCODE_OBJECT_FLAGS extends UInt32 {
    static CRYPT_ENCODE_ALLOC_FLAG := 32768
    static CRYPT_ENCODE_ENABLE_PUNYCODE_FLAG := 131072
    static CRYPT_UNICODE_NAME_ENCODE_DISABLE_CHECK_TYPE_FLAG := 1073741824
    static CRYPT_UNICODE_NAME_ENCODE_ENABLE_T61_UNICODE_FLAG := 2147483648
    static CRYPT_UNICODE_NAME_ENCODE_ENABLE_UTF8_UNICODE_FLAG := 536870912
}
struct CRYPT_OBJECT_LOCATOR_RELEASE_REASON extends UInt32 {
    static CRYPT_OBJECT_LOCATOR_RELEASE_SYSTEM_SHUTDOWN := 1
    static CRYPT_OBJECT_LOCATOR_RELEASE_SERVICE_STOP := 2
    static CRYPT_OBJECT_LOCATOR_RELEASE_PROCESS_EXIT := 3
    static CRYPT_OBJECT_LOCATOR_RELEASE_DLL_UNLOAD := 4
}
struct CRYPT_ACQUIRE_FLAGS extends UInt32 {
    static CRYPT_ACQUIRE_CACHE_FLAG := 1
    static CRYPT_ACQUIRE_USE_PROV_INFO_FLAG := 2
    static CRYPT_ACQUIRE_COMPARE_KEY_FLAG := 4
    static CRYPT_ACQUIRE_NO_HEALING := 8
    static CRYPT_ACQUIRE_SILENT_FLAG := 64
    static CRYPT_ACQUIRE_WINDOW_HANDLE_FLAG := 128
    static CRYPT_ACQUIRE_NCRYPT_KEY_FLAGS_MASK := 458752
    static CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG := 65536
    static CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG := 131072
    static CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG := 262144
}
struct CRYPT_GET_URL_FLAGS extends UInt32 {
    static CRYPT_GET_URL_FROM_PROPERTY := 1
    static CRYPT_GET_URL_FROM_EXTENSION := 2
    static CRYPT_GET_URL_FROM_UNAUTH_ATTRIBUTE := 4
    static CRYPT_GET_URL_FROM_AUTH_ATTRIBUTE := 8
}
struct CERT_STORE_SAVE_AS extends UInt32 {
    static CERT_STORE_SAVE_AS_PKCS7 := 2
    static CERT_STORE_SAVE_AS_STORE := 1
}
struct BCRYPT_QUERY_PROVIDER_MODE extends UInt32 {
    static CRYPT_ANY := 4
    static CRYPT_UM := 1
    static CRYPT_KM := 2
    static CRYPT_MM := 3
}
struct CERT_FIND_CHAIN_IN_STORE_FLAGS extends UInt32 {
    static CERT_CHAIN_FIND_BY_ISSUER_COMPARE_KEY_FLAG := 1
    static CERT_CHAIN_FIND_BY_ISSUER_COMPLEX_CHAIN_FLAG := 2
    static CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_FLAG := 32768
    static CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_URL_FLAG := 4
    static CERT_CHAIN_FIND_BY_ISSUER_LOCAL_MACHINE_FLAG := 8
    static CERT_CHAIN_FIND_BY_ISSUER_NO_KEY_FLAG := 16384
}
struct CERT_CONTROL_STORE_FLAGS extends UInt32 {
    static CERT_STORE_CTRL_COMMIT_FORCE_FLAG := 1
    static CERT_STORE_CTRL_COMMIT_CLEAR_FLAG := 2
    static CERT_STORE_CTRL_INHIBIT_DUPLICATE_HANDLE_FLAG := 1
}
struct BCRYPT_OPEN_ALGORITHM_PROVIDER_FLAGS extends UInt32 {
    static BCRYPT_ALG_HANDLE_HMAC_FLAG := 8
    static BCRYPT_PROV_DISPATCH := 1
    static BCRYPT_HASH_REUSABLE_FLAG := 32
}
struct CERT_STORE_SAVE_TO extends UInt32 {
    static CERT_STORE_SAVE_TO_FILE := 1
    static CERT_STORE_SAVE_TO_FILENAME := 4
    static CERT_STORE_SAVE_TO_FILENAME_A := 3
    static CERT_STORE_SAVE_TO_FILENAME_W := 4
    static CERT_STORE_SAVE_TO_MEMORY := 2
}
struct CRYPT_SET_PROV_PARAM_ID extends UInt32 {
    static PP_CLIENT_HWND := 1
    static PP_DELETEKEY := 24
    static PP_KEYEXCHANGE_ALG := 14
    static PP_KEYEXCHANGE_PIN := 32
    static PP_KEYEXCHANGE_KEYSIZE := 12
    static PP_KEYSET_SEC_DESCR := 8
    static PP_PIN_PROMPT_STRING := 44
    static PP_ROOT_CERTSTORE := 46
    static PP_SIGNATURE_ALG := 15
    static PP_SIGNATURE_PIN := 33
    static PP_SIGNATURE_KEYSIZE := 13
    static PP_UI_PROMPT := 21
    static PP_USE_HARDWARE_RNG := 38
    static PP_USER_CERTSTORE := 42
    static PP_SECURE_KEYEXCHANGE_PIN := 47
    static PP_SECURE_SIGNATURE_PIN := 48
    static PP_SMARTCARD_READER := 43
}
struct CRYPT_KEY_PARAM_ID extends UInt32 {
    static KP_ALGID := 7
    static KP_CERTIFICATE := 26
    static KP_PERMISSIONS := 6
    static KP_SALT := 2
    static KP_SALT_EX := 10
    static KP_BLOCKLEN := 8
    static KP_GET_USE_COUNT := 42
    static KP_KEYLEN := 9
}
struct CRYPT_KEY_FLAGS extends UInt32 {
    static CRYPT_EXPORTABLE := 1
    static CRYPT_USER_PROTECTED := 2
    static CRYPT_ARCHIVABLE := 16384
    static CRYPT_CREATE_IV := 512
    static CRYPT_CREATE_SALT := 4
    static CRYPT_DATA_KEY := 2048
    static CRYPT_FORCE_KEY_PROTECTION_HIGH := 32768
    static CRYPT_KEK := 1024
    static CRYPT_INITIATOR := 64
    static CRYPT_NO_SALT := 16
    static CRYPT_ONLINE := 128
    static CRYPT_PREGEN := 64
    static CRYPT_RECIPIENT := 16
    static CRYPT_SF := 256
    static CRYPT_SGCKEY := 8192
    static CRYPT_VOLATILE := 4096
    static CRYPT_MACHINE_KEYSET := 32
    static CRYPT_USER_KEYSET := 4096
    static PKCS12_PREFER_CNG_KSP := 256
    static PKCS12_ALWAYS_CNG_KSP := 512
    static PKCS12_ALLOW_OVERWRITE_KEY := 16384
    static PKCS12_NO_PERSIST_KEY := 32768
    static PKCS12_INCLUDE_EXTENDED_PROPERTIES := 16
    static CRYPT_OAEP := 64
    static CRYPT_BLOB_VER3 := 128
    static CRYPT_DESTROYKEY := 4
    static CRYPT_SSL2_FALLBACK := 2
    static CRYPT_Y_ONLY := 1
    static CRYPT_IPSEC_HMAC_KEY := 256
    static CERT_SET_KEY_PROV_HANDLE_PROP_ID := 1
    static CERT_SET_KEY_CONTEXT_PROP_ID := 1
}
struct CRYPT_MSG_TYPE extends UInt32 {
    static CMSG_DATA := 1
    static CMSG_SIGNED := 2
    static CMSG_ENVELOPED := 3
    static CMSG_SIGNED_AND_ENVELOPED := 4
    static CMSG_HASHED := 5
}
struct CERT_OPEN_STORE_FLAGS extends UInt32 {
    static CERT_STORE_BACKUP_RESTORE_FLAG := 2048
    static CERT_STORE_CREATE_NEW_FLAG := 8192
    static CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG := 4
    static CERT_STORE_DELETE_FLAG := 16
    static CERT_STORE_ENUM_ARCHIVED_FLAG := 512
    static CERT_STORE_MAXIMUM_ALLOWED_FLAG := 4096
    static CERT_STORE_NO_CRYPT_RELEASE_FLAG := 1
    static CERT_STORE_OPEN_EXISTING_FLAG := 16384
    static CERT_STORE_READONLY_FLAG := 32768
    static CERT_STORE_SET_LOCALIZED_NAME_FLAG := 2
    static CERT_STORE_SHARE_CONTEXT_FLAG := 128
    static CERT_STORE_UPDATE_KEYID_FLAG := 1024
}
struct CRYPT_DEFAULT_CONTEXT_FLAGS extends UInt32 {
    static CRYPT_DEFAULT_CONTEXT_AUTO_RELEASE_FLAG := 1
    static CRYPT_DEFAULT_CONTEXT_PROCESS_FLAG := 2
}
struct CRYPT_VERIFY_CERT_FLAGS extends UInt32 {
    static CRYPT_VERIFY_CERT_SIGN_DISABLE_MD2_MD4_FLAG := 1
    static CRYPT_VERIFY_CERT_SIGN_SET_STRONG_PROPERTIES_FLAG := 2
    static CRYPT_VERIFY_CERT_SIGN_RETURN_STRONG_PROPERTIES_FLAG := 4
}
struct CRYPT_SET_HASH_PARAM extends UInt32 {
    static HP_HMAC_INFO := 5
    static HP_HASHVAL := 2
}
struct CERT_SYSTEM_STORE_FLAGS extends UInt32 {
    static CERT_SYSTEM_STORE_LOCATION_MASK := 16711680
    static CERT_SYSTEM_STORE_RELOCATE_FLAG := 2147483648
}
struct CERT_CREATE_SELFSIGN_FLAGS extends UInt32 {
    static CERT_CREATE_SELFSIGN_NO_KEY_INFO := 2
    static CERT_CREATE_SELFSIGN_NO_SIGN := 1
}
struct CRYPT_DEFAULT_CONTEXT_TYPE extends UInt32 {
    static CRYPT_DEFAULT_CONTEXT_CERT_SIGN_OID := 1
    static CRYPT_DEFAULT_CONTEXT_MULTI_CERT_SIGN_OID := 2
}
struct BCRYPT_RESOLVE_PROVIDERS_FLAGS extends UInt32 {
    static CRYPT_ALL_FUNCTIONS := 1
    static CRYPT_ALL_PROVIDERS := 2
}
struct CERT_FIND_TYPE extends UInt32 {
    static CTL_FIND_ANY := 0
    static CTL_FIND_SHA1_HASH := 1
    static CTL_FIND_MD5_HASH := 2
    static CTL_FIND_USAGE := 3
    static CTL_FIND_SAME_USAGE_FLAG := 1
    static CTL_FIND_EXISTING := 5
    static CTL_FIND_SUBJECT := 4
}
struct CRYPT_FIND_FLAGS extends UInt32 {
    static CRYPT_FIND_USER_KEYSET_FLAG := 1
    static CRYPT_FIND_MACHINE_KEYSET_FLAG := 2
    static CRYPT_FIND_SILENT_KEYSET_FLAG := 64
}
struct CRYPT_IMAGE_REF_FLAGS extends UInt32 {
    static CRYPT_MIN_DEPENDENCIES := 1
    static CRYPT_PROCESS_ISOLATE := 65536
}
struct CERT_REVOCATION_STATUS_REASON extends UInt32 {
    static CRL_REASON_UNSPECIFIED := 0
    static CRL_REASON_KEY_COMPROMISE := 1
    static CRL_REASON_CA_COMPROMISE := 2
    static CRL_REASON_AFFILIATION_CHANGED := 3
    static CRL_REASON_SUPERSEDED := 4
    static CRL_REASON_CESSATION_OF_OPERATION := 5
    static CRL_REASON_CERTIFICATE_HOLD := 6
    static CRL_REASON_REMOVE_FROM_CRL := 8
}
struct CERT_ROOT_PROGRAM_FLAGS extends UInt32 {
    static CERT_ROOT_PROGRAM_FLAG_LSC := 64
    static CERT_ROOT_PROGRAM_FLAG_ORG := 128
    static CERT_ROOT_PROGRAM_FLAG_SUBJECT_LOGO := 32
}
struct CRYPT_XML_KEY_VALUE_TYPE extends UInt32 {
    static CRYPT_XML_KEY_VALUE_TYPE_DSA := 1
    static CRYPT_XML_KEY_VALUE_TYPE_RSA := 2
    static CRYPT_XML_KEY_VALUE_TYPE_ECDSA := 3
    static CRYPT_XML_KEY_VALUE_TYPE_CUSTOM := 4
}
struct CERT_LOGOTYPE_CHOICE extends UInt32 {
    static CERT_LOGOTYPE_NO_IMAGE_RESOLUTION_CHOICE := 0
    static CERT_LOGOTYPE_BITS_IMAGE_RESOLUTION_CHOICE := 1
    static CERT_LOGOTYPE_TABLE_SIZE_IMAGE_RESOLUTION_CHOICE := 2
}
struct CMSG_KEY_AGREE_OPTION extends UInt32 {
    static CMSG_KEY_AGREE_EPHEMERAL_KEY_CHOICE := 1
    static CMSG_KEY_AGREE_STATIC_KEY_CHOICE := 2
}
struct CERT_LOGOTYPE_OPTION extends UInt32 {
    static CERT_LOGOTYPE_DIRECT_INFO_CHOICE := 1
    static CERT_LOGOTYPE_INDIRECT_INFO_CHOICE := 2
}
struct CERT_STORE_PROV_FLAGS extends UInt32 {
    static CERT_STORE_PROV_EXTERNAL_FLAG := 1
    static CERT_STORE_PROV_DELETED_FLAG := 2
    static CERT_STORE_PROV_NO_PERSIST_FLAG := 4
    static CERT_STORE_PROV_SYSTEM_STORE_FLAG := 8
    static CERT_STORE_PROV_LM_SYSTEM_STORE_FLAG := 16
}
struct CMSG_KEY_AGREE_ORIGINATOR extends UInt32 {
    static CMSG_KEY_AGREE_ORIGINATOR_CERT := 1
    static CMSG_KEY_AGREE_ORIGINATOR_PUBLIC_KEY := 2
}
struct CRYPT_CONTEXT_CONFIG_FLAGS extends UInt32 {
    static CRYPT_EXCLUSIVE := 1
    static CRYPT_OVERRIDE := 65536
}
struct BCRYPT_DSA_MAGIC extends UInt32 {
    static BCRYPT_DSA_PUBLIC_MAGIC := 1112560452
    static BCRYPT_DSA_PRIVATE_MAGIC := 1448104772
}
struct CRYPT_XML_X509DATA_TYPE extends UInt32 {
    static CRYPT_XML_X509DATA_TYPE_ISSUER_SERIAL := 1
    static CRYPT_XML_X509DATA_TYPE_SKI := 2
    static CRYPT_XML_X509DATA_TYPE_SUBJECT_NAME := 3
    static CRYPT_XML_X509DATA_TYPE_CERTIFICATE := 4
    static CRYPT_XML_X509DATA_TYPE_CRL := 5
    static CRYPT_XML_X509DATA_TYPE_CUSTOM := 6
}
struct CERT_BIOMETRIC_DATA_TYPE extends UInt32 {
    static CERT_BIOMETRIC_PREDEFINED_DATA_CHOICE := 1
    static CERT_BIOMETRIC_OID_DATA_CHOICE := 2
}
struct CERT_CHAIN_POLICY_FLAGS extends UInt32 {
    static CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG := 1
    static CERT_CHAIN_POLICY_IGNORE_CTL_NOT_TIME_VALID_FLAG := 2
    static CERT_CHAIN_POLICY_IGNORE_NOT_TIME_NESTED_FLAG := 4
    static CERT_CHAIN_POLICY_IGNORE_INVALID_BASIC_CONSTRAINTS_FLAG := 8
    static CERT_CHAIN_POLICY_IGNORE_ALL_NOT_TIME_VALID_FLAGS := 7
    static CERT_CHAIN_POLICY_ALLOW_UNKNOWN_CA_FLAG := 16
    static CERT_CHAIN_POLICY_IGNORE_WRONG_USAGE_FLAG := 32
    static CERT_CHAIN_POLICY_IGNORE_INVALID_NAME_FLAG := 64
    static CERT_CHAIN_POLICY_IGNORE_INVALID_POLICY_FLAG := 128
    static CERT_CHAIN_POLICY_IGNORE_END_REV_UNKNOWN_FLAG := 256
    static CERT_CHAIN_POLICY_IGNORE_CTL_SIGNER_REV_UNKNOWN_FLAG := 512
    static CERT_CHAIN_POLICY_IGNORE_CA_REV_UNKNOWN_FLAG := 1024
    static CERT_CHAIN_POLICY_IGNORE_ROOT_REV_UNKNOWN_FLAG := 2048
    static CERT_CHAIN_POLICY_IGNORE_ALL_REV_UNKNOWN_FLAGS := 3840
    static CERT_CHAIN_POLICY_ALLOW_TESTROOT_FLAG := 32768
    static CERT_CHAIN_POLICY_TRUST_TESTROOT_FLAG := 16384
    static CERT_CHAIN_POLICY_IGNORE_NOT_SUPPORTED_CRITICAL_EXT_FLAG := 8192
    static CERT_CHAIN_POLICY_IGNORE_PEER_TRUST_FLAG := 4096
    static CERT_CHAIN_POLICY_IGNORE_WEAK_SIGNATURE_FLAG := 134217728
    static BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_CA_FLAG := 2147483648
    static BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_END_ENTITY_FLAG := 1073741824
    static MICROSOFT_ROOT_CERT_CHAIN_POLICY_ENABLE_TEST_ROOT_FLAG := 65536
    static MICROSOFT_ROOT_CERT_CHAIN_POLICY_CHECK_APPLICATION_ROOT_FLAG := 131072
    static MICROSOFT_ROOT_CERT_CHAIN_POLICY_DISABLE_FLIGHT_ROOT_FLAG := 262144
}
struct CERT_STRONG_SIGN_FLAGS extends UInt32 {
    static CERT_STRONG_SIGN_ENABLE_CRL_CHECK := 1
    static CERT_STRONG_SIGN_ENABLE_OCSP_CHECK := 2
}
struct CERT_LOGOTYPE_IMAGE_INFO_TYPE extends UInt32 {
    static CERT_LOGOTYPE_GRAY_SCALE_IMAGE_INFO_CHOICE := 1
    static CERT_LOGOTYPE_COLOR_IMAGE_INFO_CHOICE := 2
}
struct CRYPT_XML_STATUS_INFO_STATUS extends UInt32 {
    static CRYPT_XML_STATUS_INTERNAL_REFERENCE := 1
    static CRYPT_XML_STATUS_KEY_AVAILABLE := 2
    static CRYPT_XML_STATUS_DIGESTING := 4
    static CRYPT_XML_STATUS_DIGEST_VALID := 8
    static CRYPT_XML_STATUS_SIGNATURE_VALID := 65536
    static CRYPT_XML_STATUS_OPENED_TO_ENCODE := 2147483648
}
struct CRYPT_XML_TRANSFORM_FLAGS extends UInt32 {
    static CRYPT_XML_TRANSFORM_ON_STREAM := 1
    static CRYPT_XML_TRANSFORM_ON_NODESET := 2
    static CRYPT_XML_TRANSFORM_URI_QUERY_STRING := 3
}
struct CRYPT_XML_GROUP_ID extends UInt32 {
    static CRYPT_XML_GROUP_ID_HASH := 1
    static CRYPT_XML_GROUP_ID_SIGN := 2
}
struct CERT_SELECT_CRITERIA_TYPE extends UInt32 {
    static CERT_SELECT_BY_ENHKEY_USAGE := 1
    static CERT_SELECT_BY_KEY_USAGE := 2
    static CERT_SELECT_BY_POLICY_OID := 3
    static CERT_SELECT_BY_PROV_NAME := 4
    static CERT_SELECT_BY_EXTENSION := 5
    static CERT_SELECT_BY_SUBJECT_HOST_NAME := 6
    static CERT_SELECT_BY_ISSUER_ATTR := 7
    static CERT_SELECT_BY_SUBJECT_ATTR := 8
    static CERT_SELECT_BY_ISSUER_NAME := 9
    static CERT_SELECT_BY_PUBLIC_KEY := 10
    static CERT_SELECT_BY_TLS_SIGNATURES := 11
}
struct BCRYPT_RSAKEY_BLOB_MAGIC extends UInt32 {
    static BCRYPT_RSAPUBLIC_MAGIC := 826364754
    static BCRYPT_RSAPRIVATE_MAGIC := 843141970
    static BCRYPT_RSAFULLPRIVATE_MAGIC := 859919186
}
struct CRYPT_XML_KEYINFO_TYPE extends UInt32 {
    static CRYPT_XML_KEYINFO_TYPE_KEYNAME := 1
    static CRYPT_XML_KEYINFO_TYPE_KEYVALUE := 2
    static CRYPT_XML_KEYINFO_TYPE_RETRIEVAL := 3
    static CRYPT_XML_KEYINFO_TYPE_X509DATA := 4
    static CRYPT_XML_KEYINFO_TYPE_CUSTOM := 5
}
struct CRYPT_TIMESTAMP_VERSION extends UInt32 {
    static TIMESTAMP_VERSION := 1
}
struct CERT_ID_OPTION extends UInt32 {
    static CERT_ID_ISSUER_SERIAL_NUMBER := 1
    static CERT_ID_KEY_IDENTIFIER := 2
    static CERT_ID_SHA1_HASH := 3
}
struct HTTPSPOLICY_CALLBACK_DATA_AUTH_TYPE extends UInt32 {
    static AUTHTYPE_CLIENT := 1
    static AUTHTYPE_SERVER := 2
}
struct BCRYPT_DH_KEY_BLOB_MAGIC extends UInt32 {
    static BCRYPT_DH_PUBLIC_MAGIC := 1112557636
    static BCRYPT_DH_PRIVATE_MAGIC := 1448101956
}
struct CRYPT_XML_STATUS_ERROR_STATUS extends UInt32 {
    static CRYPT_XML_STATUS_ERROR_NOT_RESOLVED := 1
    static CRYPT_XML_STATUS_ERROR_DIGEST_INVALID := 2
    static CRYPT_XML_STATUS_ERROR_NOT_SUPPORTED_ALGORITHM := 5
    static CRYPT_XML_STATUS_ERROR_NOT_SUPPORTED_TRANSFORM := 8
    static CRYPT_XML_STATUS_ERROR_SIGNATURE_INVALID := 65536
    static CRYPT_XML_STATUS_ERROR_KEYINFO_NOT_PARSED := 131072
}
struct CRYPT_TIMESTAMP_RESPONSE_STATUS extends UInt32 {
    static TIMESTAMP_STATUS_GRANTED := 0
    static TIMESTAMP_STATUS_GRANTED_WITH_MODS := 1
    static TIMESTAMP_STATUS_REJECTED := 2
    static TIMESTAMP_STATUS_WAITING := 3
    static TIMESTAMP_STATUS_REVOCATION_WARNING := 4
    static TIMESTAMP_STATUS_REVOKED := 5
}
struct NCRYPT_ALGORITHM_NAME_CLASS extends UInt32 {
    static NCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE := 3
    static NCRYPT_SECRET_AGREEMENT_INTERFACE := 4
    static NCRYPT_SIGNATURE_INTERFACE := 5
}
struct BCRYPTGENRANDOM_FLAGS extends UInt32 {
    static BCRYPT_RNG_USE_ENTROPY_IN_BUFFER := 1
    static BCRYPT_USE_SYSTEM_PREFERRED_RNG := 2
}
struct SIGNER_SIGN_FLAGS extends UInt32 {
    static SIG_APPEND := 4096
    static SPC_INC_PE_RESOURCES_FLAG := 128
    static SPC_INC_PE_DEBUG_INFO_FLAG := 64
    static SPC_INC_PE_IMPORT_ADDR_TABLE_FLAG := 32
    static SPC_EXC_PE_PAGE_HASHES_FLAG := 16
    static SPC_INC_PE_PAGE_HASHES_FLAG := 256
    static SPC_DIGEST_GENERATE_FLAG := 512
    static SPC_DIGEST_SIGN_FLAG := 1024
    static SPC_DIGEST_SIGN_EX_FLAG := 16384
}
struct SIGNER_TIMESTAMP_FLAGS extends UInt32 {
    static SIGNER_TIMESTAMP_AUTHENTICODE := 1
    static SIGNER_TIMESTAMP_RFC3161 := 2
}
struct SIGNER_SUBJECT_CHOICE extends UInt32 {
    static SIGNER_SUBJECT_FILE := 1
    static SIGNER_SUBJECT_BLOB := 2
}
struct SIGNER_SIGNATURE_ATTRIBUTE_CHOICE extends UInt32 {
    static SIGNER_NO_ATTR := 0
    static SIGNER_AUTHCODE_ATTR := 1
}
struct SIGNER_PRIVATE_KEY_CHOICE extends UInt32 {
    static PVK_TYPE_FILE_NAME := 1
    static PVK_TYPE_KEYCONTAINER := 2
}
struct SIGNER_CERT_POLICY extends UInt32 {
    static SIGNER_CERT_POLICY_STORE := 1
    static SIGNER_CERT_POLICY_CHAIN := 2
    static SIGNER_CERT_POLICY_SPC := 4
    static SIGNER_CERT_POLICY_CHAIN_NO_ROOT := 8
}
struct SIGNER_CERT_CHOICE extends UInt32 {
    static SIGNER_CERT_SPC_FILE := 1
    static SIGNER_CERT_STORE := 2
    static SIGNER_CERT_SPC_CHAIN := 3
}
struct ALG_ID extends UInt32 {
    static CALG_MD2 := 32769
    static CALG_MD4 := 32770
    static CALG_MD5 := 32771
    static CALG_SHA := 32772
    static CALG_SHA1 := 32772
    static CALG_MAC := 32773
    static CALG_RSA_SIGN := 9216
    static CALG_DSS_SIGN := 8704
    static CALG_NO_SIGN := 8192
    static CALG_RSA_KEYX := 41984
    static CALG_DES := 26113
    static CALG_3DES_112 := 26121
    static CALG_3DES := 26115
    static CALG_DESX := 26116
    static CALG_RC2 := 26114
    static CALG_RC4 := 26625
    static CALG_SEAL := 26626
    static CALG_DH_SF := 43521
    static CALG_DH_EPHEM := 43522
    static CALG_AGREEDKEY_ANY := 43523
    static CALG_KEA_KEYX := 43524
    static CALG_HUGHES_MD5 := 40963
    static CALG_SKIPJACK := 26122
    static CALG_TEK := 26123
    static CALG_CYLINK_MEK := 26124
    static CALG_SSL3_SHAMD5 := 32776
    static CALG_SSL3_MASTER := 19457
    static CALG_SCHANNEL_MASTER_HASH := 19458
    static CALG_SCHANNEL_MAC_KEY := 19459
    static CALG_SCHANNEL_ENC_KEY := 19463
    static CALG_PCT1_MASTER := 19460
    static CALG_SSL2_MASTER := 19461
    static CALG_TLS1_MASTER := 19462
    static CALG_RC5 := 26125
    static CALG_HMAC := 32777
    static CALG_TLS1PRF := 32778
    static CALG_HASH_REPLACE_OWF := 32779
    static CALG_AES_128 := 26126
    static CALG_AES_192 := 26127
    static CALG_AES_256 := 26128
    static CALG_AES := 26129
    static CALG_SHA_256 := 32780
    static CALG_SHA_384 := 32781
    static CALG_SHA_512 := 32782
    static CALG_ECDH := 43525
    static CALG_ECDH_EPHEM := 44550
    static CALG_ECMQV := 40961
    static CALG_ECDSA := 8707
    static CALG_NULLCIPHER := 24576
    static CALG_THIRDPARTY_KEY_EXCHANGE := 45056
    static CALG_THIRDPARTY_SIGNATURE := 12288
    static CALG_THIRDPARTY_CIPHER := 28672
    static CALG_THIRDPARTY_HASH := 36864
}
struct SslGetCipherSuitePRFHashAlgorithmFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, UInt32, UInt32, UInt32, PWSTR, UInt32, HRESULT]
}
struct HCRYPTASYNC {
    Value : IntPtr
}
struct HCERTCHAINENGINE {
    Value : IntPtr
}
struct BCRYPT_ALG_HANDLE {
    Value : Struct.Ptr
}
struct BCRYPT_KEY_HANDLE {
    Value : Struct.Ptr
}
struct BCRYPT_HASH_HANDLE {
    Value : Struct.Ptr
}
struct BCRYPT_SECRET_HANDLE {
    Value : Struct.Ptr
}
struct NCRYPT_PROV_HANDLE {
    Value : IntPtr
}
struct NCRYPT_KEY_HANDLE {
    Value : IntPtr
}
struct BCRYPT_HANDLE {
    Value : Struct.Ptr
}
struct NCRYPT_HANDLE {
    Value : IntPtr
}
struct NCRYPT_HASH_HANDLE {
    Value : IntPtr
}
struct NCRYPT_SECRET_HANDLE {
    Value : IntPtr
}
struct HCRYPTPROV_LEGACY {
    Value : IntPtr
}
struct HCRYPTPROV_OR_NCRYPT_KEY_HANDLE {
    Value : IntPtr
}
struct HCERTSTORE {
    Value : IntPtr
}
struct HCERTSTOREPROV {
    Value : IntPtr
}
struct CMS_KEY_INFO {
    dwVersion : UInt32
    Algid : ALG_ID
    pbOID : UInt8.Ptr
    cbOID : UInt32
}
struct HMAC_INFO {
    HashAlgid : ALG_ID
    pbInnerString : UInt8.Ptr
    cbInnerString : UInt32
    pbOuterString : UInt8.Ptr
    cbOuterString : UInt32
}
struct SCHANNEL_ALG {
    dwUse : UInt32
    Algid : ALG_ID
    cBits : UInt32
    dwFlags : UInt32
    dwReserved : UInt32
}
struct PROV_ENUMALGS {
    aiAlgid : ALG_ID
    dwBitLen : UInt32
    dwNameLen : UInt32
    szName : CHAR[20]
}
struct PROV_ENUMALGS_EX {
    aiAlgid : ALG_ID
    dwDefaultLen : UInt32
    dwMinLen : UInt32
    dwMaxLen : UInt32
    dwProtocols : UInt32
    dwNameLen : UInt32
    szName : CHAR[20]
    dwLongNameLen : UInt32
    szLongName : CHAR[40]
}
struct PUBLICKEYSTRUC {
    bType : UInt8
    bVersion : UInt8
    reserved : UInt16
    aiKeyAlg : ALG_ID
}
struct RSAPUBKEY {
    magic : UInt32
    bitlen : UInt32
    pubexp : UInt32
}
struct PUBKEY {
    magic : UInt32
    bitlen : UInt32
}
struct DSSSEED {
    counter : UInt32
    seed : UInt8[20]
}
struct PUBKEYVER3 {
    magic : UInt32
    bitlenP : UInt32
    bitlenQ : UInt32
    bitlenJ : UInt32
    DSSSeed : DSSSEED
}
struct PRIVKEYVER3 {
    magic : UInt32
    bitlenP : UInt32
    bitlenQ : UInt32
    bitlenJ : UInt32
    bitlenX : UInt32
    DSSSeed : DSSSEED
}
struct KEY_TYPE_SUBTYPE {
    dwKeySpec : UInt32
    Type : GUID
    Subtype : GUID
}
struct CERT_FORTEZZA_DATA_PROP {
    SerialNumber : UInt8[8]
    CertIndex : Int32
    CertLabel : UInt8[36]
}
struct CRYPT_RC4_KEY_STATE {
    Key : UInt8[16]
    SBox : UInt8[256]
    i : UInt8
    j : UInt8
}
struct CRYPT_DES_KEY_STATE {
    Key : UInt8[8]
    IV : UInt8[8]
    Feedback : UInt8[8]
}
struct CRYPT_3DES_KEY_STATE {
    Key : UInt8[24]
    IV : UInt8[8]
    Feedback : UInt8[8]
}
struct CRYPT_AES_128_KEY_STATE {
    Key : UInt8[16]
    IV : UInt8[16]
    EncryptionState : UInt8[176]
    DecryptionState : UInt8[176]
    Feedback : UInt8[16]
}
struct CRYPT_AES_256_KEY_STATE {
    Key : UInt8[32]
    IV : UInt8[16]
    EncryptionState : UInt8[240]
    DecryptionState : UInt8[240]
    Feedback : UInt8[16]
}
struct CRYPT_INTEGER_BLOB {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct CMS_DH_KEY_INFO {
    dwVersion : UInt32
    Algid : ALG_ID
    pszContentEncObjId : PSTR
    PubInfo : CRYPT_INTEGER_BLOB
    pReserved : Struct.Ptr
}
struct BCRYPT_KEY_LENGTHS_STRUCT {
    dwMinLength : UInt32
    dwMaxLength : UInt32
    dwIncrement : UInt32
}
struct BCRYPT_OID {
    cbOID : UInt32
    pbOID : UInt8.Ptr
}
struct BCRYPT_OID_LIST {
    dwOIDCount : UInt32
    pOIDs : BCRYPT_OID.Ptr
}
struct BCRYPT_PKCS1_PADDING_INFO {
    pszAlgId : PWSTR
}
struct BCRYPT_PSS_PADDING_INFO {
    pszAlgId : PWSTR
    cbSalt : UInt32
}
struct BCRYPT_OAEP_PADDING_INFO {
    pszAlgId : PWSTR
    pbLabel : UInt8.Ptr
    cbLabel : UInt32
}
struct BCRYPT_PQDSA_PADDING_INFO {
    pbCtx : UInt8.Ptr
    cbCtx : UInt32
    pszPrehashAlgId : PWSTR
}
struct BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO {
    cbSize : UInt32 := this.Size
    dwInfoVersion : UInt32
    pbNonce : UInt8.Ptr
    cbNonce : UInt32
    pbAuthData : UInt8.Ptr
    cbAuthData : UInt32
    pbTag : UInt8.Ptr
    cbTag : UInt32
    pbMacContext : UInt8.Ptr
    cbMacContext : UInt32
    cbAAD : UInt32
    cbData : Int64
    dwFlags : UInt32
}
struct BCRYPT_PKCS11_RSA_AES_WRAP_BLOB {
    dwMagic : UInt32
    cbKey : UInt32
    cbPaddingAlgId : UInt32
    cbPaddingLabel : UInt32
}
struct BCRYPT_PARAMETER_SET_NAMES {
    dwParameterSetNames : UInt32
    ppszParameterSetNames : PWSTR.Ptr
}
struct BCryptBuffer {
    cbBuffer : UInt32
    BufferType : UInt32
    pvBuffer : Struct.Ptr
}
struct BCryptBufferDesc {
    ulVersion : UInt32
    cBuffers : UInt32
    pBuffers : BCryptBuffer.Ptr
}
struct BCRYPT_KEY_BLOB {
    Magic : UInt32
}
struct BCRYPT_RSAKEY_BLOB {
    Magic : BCRYPT_RSAKEY_BLOB_MAGIC
    BitLength : UInt32
    cbPublicExp : UInt32
    cbModulus : UInt32
    cbPrime1 : UInt32
    cbPrime2 : UInt32
}
struct BCRYPT_ECCKEY_BLOB {
    dwMagic : UInt32
    cbKey : UInt32
}
struct SSL_ECCKEY_BLOB {
    dwCurveType : UInt32
    cbKey : UInt32
}
struct TLS_KEM_CIPHERTEXT_BLOB {
    dwMagic : UInt32
    cbLength : UInt32
}
struct TLS_HYBRID_KEYEXCHANGE_BLOB {
    dwMagic : UInt32
    dwKeyType : UInt32
    NumBlobs : UInt8
    rgwszBlobTypes : PWSTR[4]
    rgbBlobs : UInt8.Ptr[4]
}
struct ECC_CURVE_TYPE_ENUM extends Int32 {
    static BCRYPT_ECC_PRIME_SHORT_WEIERSTRASS_CURVE := 1
    static BCRYPT_ECC_PRIME_TWISTED_EDWARDS_CURVE := 2
    static BCRYPT_ECC_PRIME_MONTGOMERY_CURVE := 3
}
struct ECC_CURVE_ALG_ID_ENUM extends Int32 {
    static BCRYPT_NO_CURVE_GENERATION_ALG_ID := 0
}
struct BCRYPT_ECCFULLKEY_BLOB {
    dwMagic : UInt32
    dwVersion : UInt32
    dwCurveType : ECC_CURVE_TYPE_ENUM
    dwCurveGenerationAlgId : ECC_CURVE_ALG_ID_ENUM
    cbFieldLength : UInt32
    cbSubgroupOrder : UInt32
    cbCofactor : UInt32
    cbSeed : UInt32
}
struct BCRYPT_DH_KEY_BLOB {
    dwMagic : BCRYPT_DH_KEY_BLOB_MAGIC
    cbKey : UInt32
}
struct BCRYPT_DH_PARAMETER_HEADER {
    cbLength : UInt32
    dwMagic : UInt32
    cbKeyLength : UInt32
}
struct BCRYPT_DSA_KEY_BLOB {
    dwMagic : BCRYPT_DSA_MAGIC
    cbKey : UInt32
    Count : UInt8[4]
    Seed : UInt8[20]
    q : UInt8[20]
}
struct HASHALGORITHM_ENUM extends Int32 {
    static DSA_HASH_ALGORITHM_SHA1 := 0
    static DSA_HASH_ALGORITHM_SHA256 := 1
    static DSA_HASH_ALGORITHM_SHA512 := 2
}
struct DSAFIPSVERSION_ENUM extends Int32 {
    static DSA_FIPS186_2 := 0
    static DSA_FIPS186_3 := 1
}
struct BCRYPT_DSA_KEY_BLOB_V2 {
    dwMagic : BCRYPT_DSA_MAGIC
    cbKey : UInt32
    hashAlgorithm : HASHALGORITHM_ENUM
    standardVersion : DSAFIPSVERSION_ENUM
    cbSeedLength : UInt32
    cbGroupSize : UInt32
    Count : UInt8[4]
}
struct BCRYPT_KEY_DATA_BLOB_HEADER {
    dwMagic : UInt32
    dwVersion : UInt32
    cbKeyData : UInt32
}
struct BCRYPT_PARAMETER_SET_KEY_BLOB {
    dwMagic : UInt32
    cbParameterSet : UInt32
    cbKey : UInt32
}
struct BCRYPT_DSA_PARAMETER_HEADER {
    cbLength : UInt32
    dwMagic : UInt32
    cbKeyLength : UInt32
    Count : UInt8[4]
    Seed : UInt8[20]
    q : UInt8[20]
}
struct BCRYPT_DSA_PARAMETER_HEADER_V2 {
    cbLength : UInt32
    dwMagic : UInt32
    cbKeyLength : UInt32
    hashAlgorithm : HASHALGORITHM_ENUM
    standardVersion : DSAFIPSVERSION_ENUM
    cbSeedLength : UInt32
    cbGroupSize : UInt32
    Count : UInt8[4]
}
struct BCRYPT_ECC_CURVE_NAMES {
    dwEccCurveNames : UInt32
    pEccCurveNames : PWSTR.Ptr
}
struct BCRYPT_HASH_OPERATION_TYPE extends Int32 {
    static BCRYPT_HASH_OPERATION_HASH_DATA := 1
    static BCRYPT_HASH_OPERATION_FINISH_HASH := 2
}
struct BCRYPT_MULTI_HASH_OPERATION {
    iHash : UInt32
    hashOperation : BCRYPT_HASH_OPERATION_TYPE
    pbBuffer : UInt8.Ptr
    cbBuffer : UInt32
}
struct BCRYPT_MULTI_OPERATION_TYPE extends Int32 {
    static BCRYPT_OPERATION_TYPE_HASH := 1
}
struct BCRYPT_MULTI_OBJECT_LENGTH_STRUCT {
    cbPerObject : UInt32
    cbPerElement : UInt32
}
struct BCRYPT_ALGORITHM_IDENTIFIER {
    pszName : PWSTR
    dwClass : UInt32
    dwFlags : UInt32
}
struct BCRYPT_PROVIDER_NAME {
    pszProviderName : PWSTR
}
struct BCRYPT_INTERFACE_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct CRYPT_INTERFACE_REG {
    dwInterface : BCRYPT_INTERFACE
    dwFlags : BCRYPT_TABLE
    cFunctions : UInt32
    rgpszFunctions : PWSTR.Ptr
}
struct CRYPT_IMAGE_REG {
    pszImage : PWSTR
    cInterfaces : UInt32
    rgpInterfaces : CRYPT_INTERFACE_REG.Ptr.Ptr
}
struct CRYPT_PROVIDER_REG {
    cAliases : UInt32
    rgpszAliases : PWSTR.Ptr
    pUM : CRYPT_IMAGE_REG.Ptr
    pKM : CRYPT_IMAGE_REG.Ptr
}
struct CRYPT_PROVIDERS {
    cProviders : UInt32
    rgpszProviders : PWSTR.Ptr
}
struct CRYPT_CONTEXT_CONFIG {
    dwFlags : CRYPT_CONTEXT_CONFIG_FLAGS
    dwReserved : UInt32
}
struct CRYPT_CONTEXT_FUNCTION_CONFIG {
    dwFlags : UInt32
    dwReserved : UInt32
}
struct CRYPT_CONTEXTS {
    cContexts : UInt32
    rgpszContexts : PWSTR.Ptr
}
struct CRYPT_CONTEXT_FUNCTIONS {
    cFunctions : UInt32
    rgpszFunctions : PWSTR.Ptr
}
struct CRYPT_CONTEXT_FUNCTION_PROVIDERS {
    cProviders : UInt32
    rgpszProviders : PWSTR.Ptr
}
struct CRYPT_PROPERTY_REF {
    pszProperty : PWSTR
    cbValue : UInt32
    pbValue : UInt8.Ptr
}
struct CRYPT_IMAGE_REF {
    pszImage : PWSTR
    dwFlags : CRYPT_IMAGE_REF_FLAGS
}
struct CRYPT_PROVIDER_REF {
    dwInterface : UInt32
    pszFunction : PWSTR
    pszProvider : PWSTR
    cProperties : UInt32
    rgpProperties : CRYPT_PROPERTY_REF.Ptr.Ptr
    pUM : CRYPT_IMAGE_REF.Ptr
    pKM : CRYPT_IMAGE_REF.Ptr
}
struct CRYPT_PROVIDER_REFS {
    cProviders : UInt32
    rgpProviders : CRYPT_PROVIDER_REF.Ptr.Ptr
}
struct PFN_NCRYPT_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PFN_NCRYPT_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct NCRYPT_ALLOC_PARA {
    cbSize : UInt32 := this.Size
    pfnAlloc : PFN_NCRYPT_ALLOC
    pfnFree : PFN_NCRYPT_FREE
}
struct NCRYPT_CIPHER_PADDING_INFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    pbIV : UInt8.Ptr
    cbIV : UInt32
    pbOtherInfo : UInt8.Ptr
    cbOtherInfo : UInt32
}
struct NCRYPT_PLATFORM_ATTEST_PADDING_INFO {
    magic : UInt32
    pcrMask : UInt32
}
struct NCRYPT_KEY_ATTEST_PADDING_INFO {
    magic : UInt32
    pbKeyBlob : UInt8.Ptr
    cbKeyBlob : UInt32
    pbKeyAuth : UInt8.Ptr
    cbKeyAuth : UInt32
}
struct NCRYPT_ISOLATED_KEY_ATTESTED_ATTRIBUTES {
    Version : UInt32
    Flags : UInt32
    cbPublicKeyBlob : UInt32
}
struct NCRYPT_EXPORTED_ISOLATED_KEY_HEADER {
    Version : UInt32
    KeyUsage : UInt32
    _bitfield : UInt32
    cbAlgName : UInt32
    cbNonce : UInt32
    cbAuthTag : UInt32
    cbWrappingKey : UInt32
    cbIsolatedKey : UInt32
}
struct NCRYPT_EXPORTED_ISOLATED_KEY_ENVELOPE {
    Header : NCRYPT_EXPORTED_ISOLATED_KEY_HEADER
}
struct NCRYPT_VBS_ROOT_ATTESTATION_HEADER {
    Magic : UInt32
    Version : UInt32
    cbAttributes : UInt32
    cbNonce : UInt32
    cbReport : UInt32
    cbSignature : UInt32
}
struct NCRYPT_VBS_IDENTITY_ATTESTATION_PADDING {
    Version : UInt32
    ulPaddingScheme : UInt32
    cbHashAlg : UInt32
    ulSalt : UInt32
}
struct NCRYPT_VBS_IDENTITY_ATTESTATION_HEADER {
    Magic : UInt32
    Version : UInt32
    cbAttributes : UInt32
    cbNonce : UInt32
    cbHashAlg : UInt32
    cbPadding : UInt32
    cbSignatureAlg : UInt32
    cbSignature : UInt32
}
struct NCRYPT_VBS_KEY_ATTESTATION_STATEMENT {
    Magic : UInt32
    Version : UInt32
    ClaimType : UInt32
}
struct NCRYPT_VBS_ROOT_KEY_ATTESTATION_CLAIM_DETAILS {
    ulKeyFlags : UInt32
    ullTrustletId : Int64
    ulTrustletSecurityVersion : UInt32
    ulTrustletDebuggable : UInt32
}
struct NCRYPT_VBS_IDENTITY_KEY_ATTESTATION_CLAIM_DETAILS {
    ulKeyFlags : UInt32
    pszSignatureHashAlg : PWSTR
    ulPaddingScheme : UInt32
    pszPaddingHashAlg : PWSTR
    ulPaddingSalt : UInt32
}
struct NCRYPT_PCP_TPM_WEB_AUTHN_ATTESTATION_STATEMENT {
    Magic : UInt32
    Version : UInt32
    HeaderSize : UInt32
    cbCertifyInfo : UInt32
    cbSignature : UInt32
    cbTpmPublic : UInt32
}
struct NCRYPT_TPM_PLATFORM_ATTESTATION_STATEMENT {
    Magic : UInt32
    Version : UInt32
    pcrAlg : UInt32
    cbSignature : UInt32
    cbQuote : UInt32
    cbPcrs : UInt32
}
struct NCryptAlgorithmName {
    pszName : PWSTR
    dwClass : NCRYPT_ALGORITHM_NAME_CLASS
    dwAlgOperations : NCRYPT_OPERATION
    dwFlags : UInt32
}
struct NCryptKeyName {
    pszName : PWSTR
    pszAlgid : PWSTR
    dwLegacyKeySpec : CERT_KEY_SPEC
    dwFlags : UInt32
}
struct NCryptProviderName {
    pszName : PWSTR
    pszComment : PWSTR
}
struct NCRYPT_UI_POLICY {
    dwVersion : UInt32
    dwFlags : UInt32
    pszCreationTitle : PWSTR
    pszFriendlyName : PWSTR
    pszDescription : PWSTR
}
struct NCRYPT_KEY_ACCESS_POLICY_BLOB {
    dwVersion : UInt32
    dwPolicyFlags : UInt32
    cbUserSid : UInt32
    cbApplicationSid : UInt32
}
struct NCRYPT_SUPPORTED_LENGTHS {
    dwMinLength : UInt32
    dwMaxLength : UInt32
    dwIncrement : UInt32
    dwDefaultLength : UInt32
}
struct NCRYPT_PCP_HMAC_AUTH_SIGNATURE_INFO {
    dwVersion : UInt32
    iExpiration : Int32
    pabNonce : UInt8[32]
    pabPolicyRef : UInt8[32]
    pabHMAC : UInt8[32]
}
struct NCRYPT_PCP_TPM_FW_VERSION_INFO {
    major1 : UInt16
    major2 : UInt16
    minor1 : UInt16
    minor2 : UInt16
}
struct NCRYPT_PCP_RAW_POLICYDIGEST_INFO {
    dwVersion : UInt32
    cbDigest : UInt32
}
struct NCRYPT_KEY_BLOB_HEADER {
    cbSize : UInt32 := this.Size
    dwMagic : UInt32
    cbAlgName : UInt32
    cbKeyData : UInt32
}
struct NCRYPT_TPM_LOADABLE_KEY_BLOB_HEADER {
    magic : UInt32
    cbHeader : UInt32
    cbPublic : UInt32
    cbPrivate : UInt32
    cbName : UInt32
}
struct NCRYPT_TPM_PERSISTENT_KEY_BLOB_HEADER {
    magic : UInt32
    cbHeader : UInt32
    tpmHandle : UInt32
}
struct NCRYPT_PQ_BLOB {
    dwMagic : UInt32
    cbBCryptType : UInt32
    cbBCryptBlob : UInt32
}
struct CRYPT_BIT_BLOB {
    cbData : UInt32
    pbData : UInt8.Ptr
    cUnusedBits : UInt32
}
struct CRYPT_ALGORITHM_IDENTIFIER {
    pszObjId : PSTR
    Parameters : CRYPT_INTEGER_BLOB
}
struct CRYPT_OBJID_TABLE {
    dwAlgId : UInt32
    pszObjId : PSTR
}
struct CRYPT_HASH_INFO {
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Hash : CRYPT_INTEGER_BLOB
}
struct CERT_EXTENSION {
    pszObjId : PSTR
    fCritical : BOOL
    Value : CRYPT_INTEGER_BLOB
}
struct CRYPT_ATTRIBUTE_TYPE_VALUE {
    pszObjId : PSTR
    Value : CRYPT_INTEGER_BLOB
}
struct CRYPT_ATTRIBUTE {
    pszObjId : PSTR
    cValue : UInt32
    rgValue : CRYPT_INTEGER_BLOB.Ptr
}
struct CRYPT_ATTRIBUTES {
    cAttr : UInt32
    rgAttr : CRYPT_ATTRIBUTE.Ptr
}
struct CERT_RDN_ATTR {
    pszObjId : PSTR
    dwValueType : UInt32
    Value : CRYPT_INTEGER_BLOB
}
struct CERT_RDN {
    cRDNAttr : UInt32
    rgRDNAttr : CERT_RDN_ATTR.Ptr
}
struct CERT_NAME_INFO {
    cRDN : UInt32
    rgRDN : CERT_RDN.Ptr
}
struct CERT_NAME_VALUE {
    dwValueType : UInt32
    Value : CRYPT_INTEGER_BLOB
}
struct CERT_PUBLIC_KEY_INFO {
    Algorithm : CRYPT_ALGORITHM_IDENTIFIER
    PublicKey : CRYPT_BIT_BLOB
}
struct CRYPT_ECC_PRIVATE_KEY_INFO {
    dwVersion : UInt32
    PrivateKey : CRYPT_INTEGER_BLOB
    szCurveOid : PSTR
    PublicKey : CRYPT_BIT_BLOB
}
struct CRYPT_PRIVATE_KEY_INFO {
    Version : UInt32
    Algorithm : CRYPT_ALGORITHM_IDENTIFIER
    PrivateKey : CRYPT_INTEGER_BLOB
    pAttributes : CRYPT_ATTRIBUTES.Ptr
}
struct CRYPT_ENCRYPTED_PRIVATE_KEY_INFO {
    EncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedPrivateKey : CRYPT_INTEGER_BLOB
}
struct PCRYPT_DECRYPT_PRIVATE_KEY_FUNC extends FunctionPointer {
    static Types := [CRYPT_ALGORITHM_IDENTIFIER, CRYPT_INTEGER_BLOB, UInt8.Ptr, UInt32.Ptr, Struct.Ptr, BOOL]
}
struct PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC extends FunctionPointer {
    static Types := [CRYPT_ALGORITHM_IDENTIFIER.Ptr, CRYPT_INTEGER_BLOB.Ptr, UInt8.Ptr, UInt32.Ptr, Struct.Ptr, BOOL]
}
struct PCRYPT_RESOLVE_HCRYPTPROV_FUNC extends FunctionPointer {
    static Types := [CRYPT_PRIVATE_KEY_INFO.Ptr, IntPtr.Ptr, Struct.Ptr, BOOL]
}
struct CRYPT_PKCS8_IMPORT_PARAMS {
    PrivateKey : CRYPT_INTEGER_BLOB
    pResolvehCryptProvFunc : PCRYPT_RESOLVE_HCRYPTPROV_FUNC
    pVoidResolveFunc : Struct.Ptr
    pDecryptPrivateKeyFunc : PCRYPT_DECRYPT_PRIVATE_KEY_FUNC
    pVoidDecryptFunc : Struct.Ptr
}
struct CRYPT_PKCS8_EXPORT_PARAMS {
    hCryptProv : IntPtr
    dwKeySpec : UInt32
    pszPrivateKeyObjId : PSTR
    pEncryptPrivateKeyFunc : PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC
    pVoidEncryptFunc : Struct.Ptr
}
struct CERT_INFO {
    dwVersion : UInt32
    SerialNumber : CRYPT_INTEGER_BLOB
    SignatureAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Issuer : CRYPT_INTEGER_BLOB
    NotBefore : FILETIME
    NotAfter : FILETIME
    Subject : CRYPT_INTEGER_BLOB
    SubjectPublicKeyInfo : CERT_PUBLIC_KEY_INFO
    IssuerUniqueId : CRYPT_BIT_BLOB
    SubjectUniqueId : CRYPT_BIT_BLOB
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CRL_ENTRY {
    SerialNumber : CRYPT_INTEGER_BLOB
    RevocationDate : FILETIME
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CRL_INFO {
    dwVersion : UInt32
    SignatureAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Issuer : CRYPT_INTEGER_BLOB
    ThisUpdate : FILETIME
    NextUpdate : FILETIME
    cCRLEntry : UInt32
    rgCRLEntry : CRL_ENTRY.Ptr
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CERT_OR_CRL_BLOB {
    dwChoice : UInt32
    cbEncoded : UInt32
    pbEncoded : UInt8.Ptr
}
struct CERT_OR_CRL_BUNDLE {
    cItem : UInt32
    rgItem : CERT_OR_CRL_BLOB.Ptr
}
struct CERT_REQUEST_INFO {
    dwVersion : UInt32
    Subject : CRYPT_INTEGER_BLOB
    SubjectPublicKeyInfo : CERT_PUBLIC_KEY_INFO
    cAttribute : UInt32
    rgAttribute : CRYPT_ATTRIBUTE.Ptr
}
struct CERT_KEYGEN_REQUEST_INFO {
    dwVersion : UInt32
    SubjectPublicKeyInfo : CERT_PUBLIC_KEY_INFO
    pwszChallengeString : PWSTR
}
struct CERT_SIGNED_CONTENT_INFO {
    ToBeSigned : CRYPT_INTEGER_BLOB
    SignatureAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Signature : CRYPT_BIT_BLOB
}
struct CTL_USAGE {
    cUsageIdentifier : UInt32
    rgpszUsageIdentifier : PSTR.Ptr
}
struct CTL_ENTRY {
    SubjectIdentifier : CRYPT_INTEGER_BLOB
    cAttribute : UInt32
    rgAttribute : CRYPT_ATTRIBUTE.Ptr
}
struct CTL_INFO {
    dwVersion : UInt32
    SubjectUsage : CTL_USAGE
    ListIdentifier : CRYPT_INTEGER_BLOB
    SequenceNumber : CRYPT_INTEGER_BLOB
    ThisUpdate : FILETIME
    NextUpdate : FILETIME
    SubjectAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    cCTLEntry : UInt32
    rgCTLEntry : CTL_ENTRY.Ptr
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CRYPT_TIME_STAMP_REQUEST_INFO {
    pszTimeStampAlgorithm : PSTR
    pszContentType : PSTR
    Content : CRYPT_INTEGER_BLOB
    cAttribute : UInt32
    rgAttribute : CRYPT_ATTRIBUTE.Ptr
}
struct CRYPT_ENROLLMENT_NAME_VALUE_PAIR {
    pwszName : PWSTR
    pwszValue : PWSTR
}
struct CRYPT_CSP_PROVIDER {
    dwKeySpec : UInt32
    pwszProviderName : PWSTR
    Signature : CRYPT_BIT_BLOB
}
struct PFN_CRYPT_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PFN_CRYPT_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct CRYPT_ENCODE_PARA {
    cbSize : UInt32 := this.Size
    pfnAlloc : PFN_CRYPT_ALLOC
    pfnFree : PFN_CRYPT_FREE
}
struct CRYPT_DECODE_PARA {
    cbSize : UInt32 := this.Size
    pfnAlloc : PFN_CRYPT_ALLOC
    pfnFree : PFN_CRYPT_FREE
}
struct CERT_EXTENSIONS {
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CERT_AUTHORITY_KEY_ID_INFO {
    KeyId : CRYPT_INTEGER_BLOB
    CertIssuer : CRYPT_INTEGER_BLOB
    CertSerialNumber : CRYPT_INTEGER_BLOB
}
struct CERT_PRIVATE_KEY_VALIDITY {
    NotBefore : FILETIME
    NotAfter : FILETIME
}
struct CERT_KEY_ATTRIBUTES_INFO {
    KeyId : CRYPT_INTEGER_BLOB
    IntendedKeyUsage : CRYPT_BIT_BLOB
    pPrivateKeyUsagePeriod : CERT_PRIVATE_KEY_VALIDITY.Ptr
}
struct CERT_POLICY_ID {
    cCertPolicyElementId : UInt32
    rgpszCertPolicyElementId : PSTR.Ptr
}
struct CERT_KEY_USAGE_RESTRICTION_INFO {
    cCertPolicyId : UInt32
    rgCertPolicyId : CERT_POLICY_ID.Ptr
    RestrictedKeyUsage : CRYPT_BIT_BLOB
}
struct CERT_OTHER_NAME {
    pszObjId : PSTR
    Value : CRYPT_INTEGER_BLOB
}
struct CERT_ALT_NAME_ENTRY {
    dwAltNameChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pOtherName : CERT_OTHER_NAME.Ptr
            pwszRfc822Name : PWSTR
            pwszDNSName : PWSTR
            DirectoryName : CRYPT_INTEGER_BLOB
            pwszURL : PWSTR
            IPAddress : CRYPT_INTEGER_BLOB
            pszRegisteredID : PSTR
        }
    }
}
struct CERT_ALT_NAME_INFO {
    cAltEntry : UInt32
    rgAltEntry : CERT_ALT_NAME_ENTRY.Ptr
}
struct CERT_BASIC_CONSTRAINTS_INFO {
    SubjectType : CRYPT_BIT_BLOB
    fPathLenConstraint : BOOL
    dwPathLenConstraint : UInt32
    cSubtreesConstraint : UInt32
    rgSubtreesConstraint : CRYPT_INTEGER_BLOB.Ptr
}
struct CERT_BASIC_CONSTRAINTS2_INFO {
    fCA : BOOL
    fPathLenConstraint : BOOL
    dwPathLenConstraint : UInt32
}
struct CERT_POLICY_QUALIFIER_INFO {
    pszPolicyQualifierId : PSTR
    Qualifier : CRYPT_INTEGER_BLOB
}
struct CERT_POLICY_INFO {
    pszPolicyIdentifier : PSTR
    cPolicyQualifier : UInt32
    rgPolicyQualifier : CERT_POLICY_QUALIFIER_INFO.Ptr
}
struct CERT_POLICIES_INFO {
    cPolicyInfo : UInt32
    rgPolicyInfo : CERT_POLICY_INFO.Ptr
}
struct CERT_POLICY_QUALIFIER_NOTICE_REFERENCE {
    pszOrganization : PSTR
    cNoticeNumbers : UInt32
    rgNoticeNumbers : Int32.Ptr
}
struct CERT_POLICY_QUALIFIER_USER_NOTICE {
    pNoticeReference : CERT_POLICY_QUALIFIER_NOTICE_REFERENCE.Ptr
    pszDisplayText : PWSTR
}
struct CPS_URLS {
    pszURL : PWSTR
    pAlgorithm : CRYPT_ALGORITHM_IDENTIFIER.Ptr
    pDigest : CRYPT_INTEGER_BLOB.Ptr
}
struct CERT_POLICY95_QUALIFIER1 {
    pszPracticesReference : PWSTR
    pszNoticeIdentifier : PSTR
    pszNSINoticeIdentifier : PSTR
    cCPSURLs : UInt32
    rgCPSURLs : CPS_URLS.Ptr
}
struct CERT_POLICY_MAPPING {
    pszIssuerDomainPolicy : PSTR
    pszSubjectDomainPolicy : PSTR
}
struct CERT_POLICY_MAPPINGS_INFO {
    cPolicyMapping : UInt32
    rgPolicyMapping : CERT_POLICY_MAPPING.Ptr
}
struct CERT_POLICY_CONSTRAINTS_INFO {
    fRequireExplicitPolicy : BOOL
    dwRequireExplicitPolicySkipCerts : UInt32
    fInhibitPolicyMapping : BOOL
    dwInhibitPolicyMappingSkipCerts : UInt32
}
struct CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY {
    pszObjId : PSTR
    cValue : UInt32
    rgValue : CRYPT_INTEGER_BLOB.Ptr
}
struct CRYPT_CONTENT_INFO {
    pszObjId : PSTR
    Content : CRYPT_INTEGER_BLOB
}
struct CRYPT_SEQUENCE_OF_ANY {
    cValue : UInt32
    rgValue : CRYPT_INTEGER_BLOB.Ptr
}
struct CERT_AUTHORITY_KEY_ID2_INFO {
    KeyId : CRYPT_INTEGER_BLOB
    AuthorityCertIssuer : CERT_ALT_NAME_INFO
    AuthorityCertSerialNumber : CRYPT_INTEGER_BLOB
}
struct CERT_ACCESS_DESCRIPTION {
    pszAccessMethod : PSTR
    AccessLocation : CERT_ALT_NAME_ENTRY
}
struct CERT_AUTHORITY_INFO_ACCESS {
    cAccDescr : UInt32
    rgAccDescr : CERT_ACCESS_DESCRIPTION.Ptr
}
struct CRL_DIST_POINT_NAME {
    dwDistPointNameChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FullName : CERT_ALT_NAME_INFO
        }
    }
}
struct CRL_DIST_POINT {
    DistPointName : CRL_DIST_POINT_NAME
    ReasonFlags : CRYPT_BIT_BLOB
    CRLIssuer : CERT_ALT_NAME_INFO
}
struct CRL_DIST_POINTS_INFO {
    cDistPoint : UInt32
    rgDistPoint : CRL_DIST_POINT.Ptr
}
struct CROSS_CERT_DIST_POINTS_INFO {
    dwSyncDeltaTime : UInt32
    cDistPoint : UInt32
    rgDistPoint : CERT_ALT_NAME_INFO.Ptr
}
struct CERT_PAIR {
    Forward : CRYPT_INTEGER_BLOB
    Reverse : CRYPT_INTEGER_BLOB
}
struct CRL_ISSUING_DIST_POINT {
    DistPointName : CRL_DIST_POINT_NAME
    fOnlyContainsUserCerts : BOOL
    fOnlyContainsCACerts : BOOL
    OnlySomeReasonFlags : CRYPT_BIT_BLOB
    fIndirectCRL : BOOL
}
struct CERT_GENERAL_SUBTREE {
    Base : CERT_ALT_NAME_ENTRY
    dwMinimum : UInt32
    fMaximum : BOOL
    dwMaximum : UInt32
}
struct CERT_NAME_CONSTRAINTS_INFO {
    cPermittedSubtree : UInt32
    rgPermittedSubtree : CERT_GENERAL_SUBTREE.Ptr
    cExcludedSubtree : UInt32
    rgExcludedSubtree : CERT_GENERAL_SUBTREE.Ptr
}
struct CERT_DSS_PARAMETERS {
    p : CRYPT_INTEGER_BLOB
    q : CRYPT_INTEGER_BLOB
    g : CRYPT_INTEGER_BLOB
}
struct CERT_DH_PARAMETERS {
    p : CRYPT_INTEGER_BLOB
    g : CRYPT_INTEGER_BLOB
}
struct CERT_ECC_SIGNATURE {
    r : CRYPT_INTEGER_BLOB
    s : CRYPT_INTEGER_BLOB
}
struct CERT_X942_DH_VALIDATION_PARAMS {
    seed : CRYPT_BIT_BLOB
    pgenCounter : UInt32
}
struct CERT_X942_DH_PARAMETERS {
    p : CRYPT_INTEGER_BLOB
    g : CRYPT_INTEGER_BLOB
    q : CRYPT_INTEGER_BLOB
    j : CRYPT_INTEGER_BLOB
    pValidationParams : CERT_X942_DH_VALIDATION_PARAMS.Ptr
}
struct CRYPT_X942_OTHER_INFO {
    pszContentEncryptionObjId : PSTR
    rgbCounter : UInt8[4]
    rgbKeyLength : UInt8[4]
    PubInfo : CRYPT_INTEGER_BLOB
}
struct CRYPT_ECC_CMS_SHARED_INFO {
    Algorithm : CRYPT_ALGORITHM_IDENTIFIER
    EntityUInfo : CRYPT_INTEGER_BLOB
    rgbSuppPubInfo : UInt8[4]
}
struct CRYPT_RC2_CBC_PARAMETERS {
    dwVersion : UInt32
    fIV : BOOL
    rgbIV : UInt8[8]
}
struct CRYPT_SMIME_CAPABILITY {
    pszObjId : PSTR
    Parameters : CRYPT_INTEGER_BLOB
}
struct CRYPT_SMIME_CAPABILITIES {
    cCapability : UInt32
    rgCapability : CRYPT_SMIME_CAPABILITY.Ptr
}
struct CERT_QC_STATEMENT {
    pszStatementId : PSTR
    StatementInfo : CRYPT_INTEGER_BLOB
}
struct CERT_QC_STATEMENTS_EXT_INFO {
    cStatement : UInt32
    rgStatement : CERT_QC_STATEMENT.Ptr
}
struct CRYPT_MASK_GEN_ALGORITHM {
    pszObjId : PSTR
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
}
struct CRYPT_RSA_SSA_PSS_PARAMETERS {
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    MaskGenAlgorithm : CRYPT_MASK_GEN_ALGORITHM
    dwSaltLength : UInt32
    dwTrailerField : UInt32
}
struct CRYPT_PSOURCE_ALGORITHM {
    pszObjId : PSTR
    EncodingParameters : CRYPT_INTEGER_BLOB
}
struct CRYPT_RSAES_OAEP_PARAMETERS {
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    MaskGenAlgorithm : CRYPT_MASK_GEN_ALGORITHM
    PSourceAlgorithm : CRYPT_PSOURCE_ALGORITHM
}
struct CMC_TAGGED_ATTRIBUTE {
    dwBodyPartID : UInt32
    Attribute : CRYPT_ATTRIBUTE
}
struct CMC_TAGGED_CERT_REQUEST {
    dwBodyPartID : UInt32
    SignedCertRequest : CRYPT_INTEGER_BLOB
}
struct CMC_TAGGED_REQUEST {
    dwTaggedRequestChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pTaggedCertRequest : CMC_TAGGED_CERT_REQUEST.Ptr
        }
    }
}
struct CMC_TAGGED_CONTENT_INFO {
    dwBodyPartID : UInt32
    EncodedContentInfo : CRYPT_INTEGER_BLOB
}
struct CMC_TAGGED_OTHER_MSG {
    dwBodyPartID : UInt32
    pszObjId : PSTR
    Value : CRYPT_INTEGER_BLOB
}
struct CMC_DATA_INFO {
    cTaggedAttribute : UInt32
    rgTaggedAttribute : CMC_TAGGED_ATTRIBUTE.Ptr
    cTaggedRequest : UInt32
    rgTaggedRequest : CMC_TAGGED_REQUEST.Ptr
    cTaggedContentInfo : UInt32
    rgTaggedContentInfo : CMC_TAGGED_CONTENT_INFO.Ptr
    cTaggedOtherMsg : UInt32
    rgTaggedOtherMsg : CMC_TAGGED_OTHER_MSG.Ptr
}
struct CMC_RESPONSE_INFO {
    cTaggedAttribute : UInt32
    rgTaggedAttribute : CMC_TAGGED_ATTRIBUTE.Ptr
    cTaggedContentInfo : UInt32
    rgTaggedContentInfo : CMC_TAGGED_CONTENT_INFO.Ptr
    cTaggedOtherMsg : UInt32
    rgTaggedOtherMsg : CMC_TAGGED_OTHER_MSG.Ptr
}
struct CMC_PEND_INFO {
    PendToken : CRYPT_INTEGER_BLOB
    PendTime : FILETIME
}
struct CMC_STATUS_INFO {
    dwStatus : UInt32
    cBodyList : UInt32
    rgdwBodyList : UInt32.Ptr
    pwszStatusString : PWSTR
    dwOtherInfoChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwFailInfo : UInt32
            pPendInfo : CMC_PEND_INFO.Ptr
        }
    }
}
struct CMC_ADD_EXTENSIONS_INFO {
    dwCmcDataReference : UInt32
    cCertReference : UInt32
    rgdwCertReference : UInt32.Ptr
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CMC_ADD_ATTRIBUTES_INFO {
    dwCmcDataReference : UInt32
    cCertReference : UInt32
    rgdwCertReference : UInt32.Ptr
    cAttribute : UInt32
    rgAttribute : CRYPT_ATTRIBUTE.Ptr
}
struct CERT_TEMPLATE_EXT {
    pszObjId : PSTR
    dwMajorVersion : UInt32
    fMinorVersion : BOOL
    dwMinorVersion : UInt32
}
struct CERT_HASHED_URL {
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Hash : CRYPT_INTEGER_BLOB
    pwszUrl : PWSTR
}
struct CERT_LOGOTYPE_DETAILS {
    pwszMimeType : PWSTR
    cHashedUrl : UInt32
    rgHashedUrl : CERT_HASHED_URL.Ptr
}
struct CERT_LOGOTYPE_REFERENCE {
    cHashedUrl : UInt32
    rgHashedUrl : CERT_HASHED_URL.Ptr
}
struct CERT_LOGOTYPE_IMAGE_INFO {
    dwLogotypeImageInfoChoice : CERT_LOGOTYPE_IMAGE_INFO_TYPE
    dwFileSize : UInt32
    dwXSize : UInt32
    dwYSize : UInt32
    dwLogotypeImageResolutionChoice : CERT_LOGOTYPE_CHOICE
    Anonymous : this._Anonymous_e__Union
    pwszLanguage : PWSTR
    struct _Anonymous_e__Union {
        union {
            dwNumBits : UInt32
            dwTableSize : UInt32
        }
    }
}
struct CERT_LOGOTYPE_IMAGE {
    LogotypeDetails : CERT_LOGOTYPE_DETAILS
    pLogotypeImageInfo : CERT_LOGOTYPE_IMAGE_INFO.Ptr
}
struct CERT_LOGOTYPE_AUDIO_INFO {
    dwFileSize : UInt32
    dwPlayTime : UInt32
    dwChannels : UInt32
    dwSampleRate : UInt32
    pwszLanguage : PWSTR
}
struct CERT_LOGOTYPE_AUDIO {
    LogotypeDetails : CERT_LOGOTYPE_DETAILS
    pLogotypeAudioInfo : CERT_LOGOTYPE_AUDIO_INFO.Ptr
}
struct CERT_LOGOTYPE_DATA {
    cLogotypeImage : UInt32
    rgLogotypeImage : CERT_LOGOTYPE_IMAGE.Ptr
    cLogotypeAudio : UInt32
    rgLogotypeAudio : CERT_LOGOTYPE_AUDIO.Ptr
}
struct CERT_LOGOTYPE_INFO {
    dwLogotypeInfoChoice : CERT_LOGOTYPE_OPTION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pLogotypeDirectInfo : CERT_LOGOTYPE_DATA.Ptr
            pLogotypeIndirectInfo : CERT_LOGOTYPE_REFERENCE.Ptr
        }
    }
}
struct CERT_OTHER_LOGOTYPE_INFO {
    pszObjId : PSTR
    LogotypeInfo : CERT_LOGOTYPE_INFO
}
struct CERT_LOGOTYPE_EXT_INFO {
    cCommunityLogo : UInt32
    rgCommunityLogo : CERT_LOGOTYPE_INFO.Ptr
    pIssuerLogo : CERT_LOGOTYPE_INFO.Ptr
    pSubjectLogo : CERT_LOGOTYPE_INFO.Ptr
    cOtherLogo : UInt32
    rgOtherLogo : CERT_OTHER_LOGOTYPE_INFO.Ptr
}
struct CERT_BIOMETRIC_DATA {
    dwTypeOfBiometricDataChoice : CERT_BIOMETRIC_DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    HashedUrl : CERT_HASHED_URL
    struct _Anonymous_e__Union {
        union {
            dwPredefined : UInt32
            pszObjId : PSTR
        }
    }
}
struct CERT_BIOMETRIC_EXT_INFO {
    cBiometricData : UInt32
    rgBiometricData : CERT_BIOMETRIC_DATA.Ptr
}
struct OCSP_SIGNATURE_INFO {
    SignatureAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Signature : CRYPT_BIT_BLOB
    cCertEncoded : UInt32
    rgCertEncoded : CRYPT_INTEGER_BLOB.Ptr
}
struct OCSP_SIGNED_REQUEST_INFO {
    ToBeSigned : CRYPT_INTEGER_BLOB
    pOptionalSignatureInfo : OCSP_SIGNATURE_INFO.Ptr
}
struct OCSP_CERT_ID {
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    IssuerNameHash : CRYPT_INTEGER_BLOB
    IssuerKeyHash : CRYPT_INTEGER_BLOB
    SerialNumber : CRYPT_INTEGER_BLOB
}
struct OCSP_REQUEST_ENTRY {
    CertId : OCSP_CERT_ID
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct OCSP_REQUEST_INFO {
    dwVersion : UInt32
    pRequestorName : CERT_ALT_NAME_ENTRY.Ptr
    cRequestEntry : UInt32
    rgRequestEntry : OCSP_REQUEST_ENTRY.Ptr
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct OCSP_RESPONSE_INFO {
    dwStatus : UInt32
    pszObjId : PSTR
    Value : CRYPT_INTEGER_BLOB
}
struct OCSP_BASIC_SIGNED_RESPONSE_INFO {
    ToBeSigned : CRYPT_INTEGER_BLOB
    SignatureInfo : OCSP_SIGNATURE_INFO
}
struct OCSP_BASIC_REVOKED_INFO {
    RevocationDate : FILETIME
    dwCrlReasonCode : CERT_REVOCATION_STATUS_REASON
}
struct OCSP_BASIC_RESPONSE_ENTRY {
    CertId : OCSP_CERT_ID
    dwCertStatus : UInt32
    Anonymous : this._Anonymous_e__Union
    ThisUpdate : FILETIME
    NextUpdate : FILETIME
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
    struct _Anonymous_e__Union {
        union {
            pRevokedInfo : OCSP_BASIC_REVOKED_INFO.Ptr
        }
    }
}
struct OCSP_BASIC_RESPONSE_INFO {
    dwVersion : UInt32
    dwResponderIdChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    ProducedAt : FILETIME
    cResponseEntry : UInt32
    rgResponseEntry : OCSP_BASIC_RESPONSE_ENTRY.Ptr
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
    struct _Anonymous_e__Union {
        union {
            ByNameResponderId : CRYPT_INTEGER_BLOB
            ByKeyResponderId : CRYPT_INTEGER_BLOB
        }
    }
}
struct CERT_SUPPORTED_ALGORITHM_INFO {
    Algorithm : CRYPT_ALGORITHM_IDENTIFIER
    IntendedKeyUsage : CRYPT_BIT_BLOB
    IntendedCertPolicies : CERT_POLICIES_INFO
}
struct CERT_TPM_SPECIFICATION_INFO {
    pwszFamily : PWSTR
    dwLevel : UInt32
    dwRevision : UInt32
}
struct CRYPT_OID_FUNC_ENTRY {
    pszOID : PSTR
    pvFuncAddr : Struct.Ptr
}
struct PFN_CRYPT_ENUM_OID_FUNC extends FunctionPointer {
    static Types := [UInt32, PSTR, PSTR, UInt32, UInt32.Ptr, PWSTR.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, Struct.Ptr, BOOL]
}
struct CRYPT_OID_INFO {
    cbSize : UInt32 := this.Size
    pszOID : PSTR
    pwszName : PWSTR
    dwGroupId : UInt32
    Anonymous : this._Anonymous_e__Union
    ExtraInfo : CRYPT_INTEGER_BLOB
    struct _Anonymous_e__Union {
        union {
            dwValue : UInt32
            Algid : ALG_ID
            dwLength : UInt32
        }
    }
}
struct PFN_CRYPT_ENUM_OID_INFO extends FunctionPointer {
    static Types := [CRYPT_OID_INFO.Ptr, Struct.Ptr, BOOL]
}
struct CERT_STRONG_SIGN_SERIALIZED_INFO {
    dwFlags : CERT_STRONG_SIGN_FLAGS
    pwszCNGSignHashAlgids : PWSTR
    pwszCNGPubKeyMinBitLengths : PWSTR
}
struct CERT_STRONG_SIGN_PARA {
    cbSize : UInt32 := this.Size
    dwInfoChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pvInfo : Struct.Ptr
            pSerializedInfo : CERT_STRONG_SIGN_SERIALIZED_INFO.Ptr
            pszOID : PSTR
        }
    }
}
struct CERT_ISSUER_SERIAL_NUMBER {
    Issuer : CRYPT_INTEGER_BLOB
    SerialNumber : CRYPT_INTEGER_BLOB
}
struct CERT_ID {
    dwIdChoice : CERT_ID_OPTION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            IssuerSerialNumber : CERT_ISSUER_SERIAL_NUMBER
            KeyId : CRYPT_INTEGER_BLOB
            HashId : CRYPT_INTEGER_BLOB
        }
    }
}
struct CMSG_SIGNER_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    pCertInfo : CERT_INFO.Ptr
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : UInt32
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo : Struct.Ptr
    cAuthAttr : UInt32
    rgAuthAttr : CRYPT_ATTRIBUTE.Ptr
    cUnauthAttr : UInt32
    rgUnauthAttr : CRYPT_ATTRIBUTE.Ptr
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct CMSG_SIGNED_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    cSigners : UInt32
    rgSigners : CMSG_SIGNER_ENCODE_INFO.Ptr
    cCertEncoded : UInt32
    rgCertEncoded : CRYPT_INTEGER_BLOB.Ptr
    cCrlEncoded : UInt32
    rgCrlEncoded : CRYPT_INTEGER_BLOB.Ptr
}
struct CMSG_ENVELOPED_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    hCryptProv : HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo : Struct.Ptr
    cRecipients : UInt32
    rgpRecipients : CERT_INFO.Ptr.Ptr
}
struct CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo : Struct.Ptr
    hCryptProv : HCRYPTPROV_LEGACY
    RecipientPublicKey : CRYPT_BIT_BLOB
    RecipientId : CERT_ID
}
struct CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    RecipientPublicKey : CRYPT_BIT_BLOB
    RecipientId : CERT_ID
    Date : FILETIME
    pOtherAttr : CRYPT_ATTRIBUTE_TYPE_VALUE.Ptr
}
struct CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo : Struct.Ptr
    KeyWrapAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvKeyWrapAuxInfo : Struct.Ptr
    hCryptProv : HCRYPTPROV_LEGACY
    dwKeySpec : UInt32
    dwKeyChoice : CMSG_KEY_AGREE_OPTION
    Anonymous : this._Anonymous_e__Union
    UserKeyingMaterial : CRYPT_INTEGER_BLOB
    cRecipientEncryptedKeys : UInt32
    rgpRecipientEncryptedKeys : CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO.Ptr.Ptr
    struct _Anonymous_e__Union {
        union {
            pEphemeralAlgorithm : CRYPT_ALGORITHM_IDENTIFIER.Ptr
            pSenderId : CERT_ID.Ptr
        }
    }
}
struct CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvKeyEncryptionAuxInfo : Struct.Ptr
    hCryptProv : IntPtr
    dwKeyChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    KeyId : CRYPT_INTEGER_BLOB
    Date : FILETIME
    pOtherAttr : CRYPT_ATTRIBUTE_TYPE_VALUE.Ptr
    struct _Anonymous_e__Union {
        union {
            hKeyEncryptionKey : IntPtr
            pvKeyEncryptionKey : Struct.Ptr
        }
    }
}
struct CMSG_RECIPIENT_ENCODE_INFO {
    dwRecipientChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pKeyTrans : CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO.Ptr
            pKeyAgree : CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO.Ptr
            pMailList : CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO.Ptr
        }
    }
}
struct CMSG_RC2_AUX_INFO {
    cbSize : UInt32 := this.Size
    dwBitLen : UInt32
}
struct CMSG_SP3_COMPATIBLE_AUX_INFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
}
struct CMSG_RC4_AUX_INFO {
    cbSize : UInt32 := this.Size
    dwBitLen : UInt32
}
struct CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    SignedInfo : CMSG_SIGNED_ENCODE_INFO
    EnvelopedInfo : CMSG_ENVELOPED_ENCODE_INFO
}
struct CMSG_HASHED_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    hCryptProv : HCRYPTPROV_LEGACY
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo : Struct.Ptr
}
struct CMSG_ENCRYPTED_ENCODE_INFO {
    cbSize : UInt32 := this.Size
    ContentEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo : Struct.Ptr
}
struct PFN_CMSG_STREAM_OUTPUT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, UInt32, BOOL, BOOL]
}
struct CMSG_STREAM_INFO {
    cbContent : UInt32
    pfnStreamOutput : PFN_CMSG_STREAM_OUTPUT
    pvArg : Struct.Ptr
}
struct CMSG_SIGNER_INFO {
    dwVersion : UInt32
    Issuer : CRYPT_INTEGER_BLOB
    SerialNumber : CRYPT_INTEGER_BLOB
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    HashEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedHash : CRYPT_INTEGER_BLOB
    AuthAttrs : CRYPT_ATTRIBUTES
    UnauthAttrs : CRYPT_ATTRIBUTES
}
struct CMSG_CMS_SIGNER_INFO {
    dwVersion : UInt32
    SignerId : CERT_ID
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    HashEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedHash : CRYPT_INTEGER_BLOB
    AuthAttrs : CRYPT_ATTRIBUTES
    UnauthAttrs : CRYPT_ATTRIBUTES
}
struct CMSG_KEY_TRANS_RECIPIENT_INFO {
    dwVersion : UInt32
    RecipientId : CERT_ID
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey : CRYPT_INTEGER_BLOB
}
struct CMSG_RECIPIENT_ENCRYPTED_KEY_INFO {
    RecipientId : CERT_ID
    EncryptedKey : CRYPT_INTEGER_BLOB
    Date : FILETIME
    pOtherAttr : CRYPT_ATTRIBUTE_TYPE_VALUE.Ptr
}
struct CMSG_KEY_AGREE_RECIPIENT_INFO {
    dwVersion : UInt32
    dwOriginatorChoice : CMSG_KEY_AGREE_ORIGINATOR
    Anonymous : this._Anonymous_e__Union
    UserKeyingMaterial : CRYPT_INTEGER_BLOB
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    cRecipientEncryptedKeys : UInt32
    rgpRecipientEncryptedKeys : CMSG_RECIPIENT_ENCRYPTED_KEY_INFO.Ptr.Ptr
    struct _Anonymous_e__Union {
        union {
            OriginatorCertId : CERT_ID
            OriginatorPublicKeyInfo : CERT_PUBLIC_KEY_INFO
        }
    }
}
struct CMSG_MAIL_LIST_RECIPIENT_INFO {
    dwVersion : UInt32
    KeyId : CRYPT_INTEGER_BLOB
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey : CRYPT_INTEGER_BLOB
    Date : FILETIME
    pOtherAttr : CRYPT_ATTRIBUTE_TYPE_VALUE.Ptr
}
struct CMSG_CMS_RECIPIENT_INFO {
    dwRecipientChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pKeyTrans : CMSG_KEY_TRANS_RECIPIENT_INFO.Ptr
            pKeyAgree : CMSG_KEY_AGREE_RECIPIENT_INFO.Ptr
            pMailList : CMSG_MAIL_LIST_RECIPIENT_INFO.Ptr
        }
    }
}
struct CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA {
    cbSize : UInt32 := this.Size
    hCryptProv : HCRYPTPROV_LEGACY
    dwSignerIndex : UInt32
    dwSignerType : UInt32
    pvSigner : Struct.Ptr
}
struct CMSG_CTRL_DECRYPT_PARA {
    cbSize : UInt32 := this.Size
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : UInt32
    dwRecipientIndex : UInt32
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct CMSG_CTRL_KEY_TRANS_DECRYPT_PARA {
    cbSize : UInt32 := this.Size
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : UInt32
    pKeyTrans : CMSG_KEY_TRANS_RECIPIENT_INFO.Ptr
    dwRecipientIndex : UInt32
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct CMSG_CTRL_KEY_AGREE_DECRYPT_PARA {
    cbSize : UInt32 := this.Size
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : UInt32
    pKeyAgree : CMSG_KEY_AGREE_RECIPIENT_INFO.Ptr
    dwRecipientIndex : UInt32
    dwRecipientEncryptedKeyIndex : UInt32
    OriginatorPublicKey : CRYPT_BIT_BLOB
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct CMSG_CTRL_MAIL_LIST_DECRYPT_PARA {
    cbSize : UInt32 := this.Size
    hCryptProv : IntPtr
    pMailList : CMSG_MAIL_LIST_RECIPIENT_INFO.Ptr
    dwRecipientIndex : UInt32
    dwKeyChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            hKeyEncryptionKey : IntPtr
            pvKeyEncryptionKey : Struct.Ptr
        }
    }
}
struct CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA {
    cbSize : UInt32 := this.Size
    dwSignerIndex : UInt32
    blob : CRYPT_INTEGER_BLOB
}
struct CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA {
    cbSize : UInt32 := this.Size
    dwSignerIndex : UInt32
    dwUnauthAttrIndex : UInt32
}
struct PFN_CMSG_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PFN_CMSG_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PFN_CMSG_GEN_ENCRYPT_KEY extends FunctionPointer {
    static Types := [IntPtr.Ptr, CRYPT_ALGORITHM_IDENTIFIER.Ptr, Struct.Ptr, CERT_PUBLIC_KEY_INFO.Ptr, PFN_CMSG_ALLOC, IntPtr.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CMSG_EXPORT_ENCRYPT_KEY extends FunctionPointer {
    static Types := [IntPtr, IntPtr, CERT_PUBLIC_KEY_INFO.Ptr, UInt8.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CMSG_IMPORT_ENCRYPT_KEY extends FunctionPointer {
    static Types := [IntPtr, UInt32, CRYPT_ALGORITHM_IDENTIFIER.Ptr, CRYPT_ALGORITHM_IDENTIFIER.Ptr, UInt8.Ptr, UInt32, IntPtr.Ptr, BOOL]
}
struct CMSG_CONTENT_ENCRYPT_INFO {
    cbSize : UInt32 := this.Size
    hCryptProv : HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo : Struct.Ptr
    cRecipients : UInt32
    rgCmsRecipients : CMSG_RECIPIENT_ENCODE_INFO.Ptr
    pfnAlloc : PFN_CMSG_ALLOC
    pfnFree : PFN_CMSG_FREE
    dwEncryptFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    dwFlags : UInt32
    fCNG : BOOL
    pbCNGContentEncryptKeyObject : UInt8.Ptr
    pbContentEncryptKey : UInt8.Ptr
    cbContentEncryptKey : UInt32
    struct _Anonymous_e__Union {
        union {
            hContentEncryptKey : IntPtr
            hCNGContentEncryptKey : BCRYPT_KEY_HANDLE
        }
    }
}
struct PFN_CMSG_GEN_CONTENT_ENCRYPT_KEY extends FunctionPointer {
    static Types := [CMSG_CONTENT_ENCRYPT_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct CMSG_KEY_TRANS_ENCRYPT_INFO {
    cbSize : UInt32 := this.Size
    dwRecipientIndex : UInt32
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey : CRYPT_INTEGER_BLOB
    dwFlags : UInt32
}
struct PFN_CMSG_EXPORT_KEY_TRANS extends FunctionPointer {
    static Types := [CMSG_CONTENT_ENCRYPT_INFO.Ptr, CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO.Ptr, CMSG_KEY_TRANS_ENCRYPT_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct CMSG_KEY_AGREE_KEY_ENCRYPT_INFO {
    cbSize : UInt32 := this.Size
    EncryptedKey : CRYPT_INTEGER_BLOB
}
struct CMSG_KEY_AGREE_ENCRYPT_INFO {
    cbSize : UInt32 := this.Size
    dwRecipientIndex : UInt32
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    UserKeyingMaterial : CRYPT_INTEGER_BLOB
    dwOriginatorChoice : CMSG_KEY_AGREE_ORIGINATOR
    Anonymous : this._Anonymous_e__Union
    cKeyAgreeKeyEncryptInfo : UInt32
    rgpKeyAgreeKeyEncryptInfo : CMSG_KEY_AGREE_KEY_ENCRYPT_INFO.Ptr.Ptr
    dwFlags : UInt32
    struct _Anonymous_e__Union {
        union {
            OriginatorCertId : CERT_ID
            OriginatorPublicKeyInfo : CERT_PUBLIC_KEY_INFO
        }
    }
}
struct PFN_CMSG_EXPORT_KEY_AGREE extends FunctionPointer {
    static Types := [CMSG_CONTENT_ENCRYPT_INFO.Ptr, CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO.Ptr, CMSG_KEY_AGREE_ENCRYPT_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct CMSG_MAIL_LIST_ENCRYPT_INFO {
    cbSize : UInt32 := this.Size
    dwRecipientIndex : UInt32
    KeyEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    EncryptedKey : CRYPT_INTEGER_BLOB
    dwFlags : UInt32
}
struct PFN_CMSG_EXPORT_MAIL_LIST extends FunctionPointer {
    static Types := [CMSG_CONTENT_ENCRYPT_INFO.Ptr, CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO.Ptr, CMSG_MAIL_LIST_ENCRYPT_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CMSG_IMPORT_KEY_TRANS extends FunctionPointer {
    static Types := [CRYPT_ALGORITHM_IDENTIFIER.Ptr, CMSG_CTRL_KEY_TRANS_DECRYPT_PARA.Ptr, UInt32, Struct.Ptr, IntPtr.Ptr, BOOL]
}
struct PFN_CMSG_IMPORT_KEY_AGREE extends FunctionPointer {
    static Types := [CRYPT_ALGORITHM_IDENTIFIER.Ptr, CMSG_CTRL_KEY_AGREE_DECRYPT_PARA.Ptr, UInt32, Struct.Ptr, IntPtr.Ptr, BOOL]
}
struct PFN_CMSG_IMPORT_MAIL_LIST extends FunctionPointer {
    static Types := [CRYPT_ALGORITHM_IDENTIFIER.Ptr, CMSG_CTRL_MAIL_LIST_DECRYPT_PARA.Ptr, UInt32, Struct.Ptr, IntPtr.Ptr, BOOL]
}
struct CMSG_CNG_CONTENT_DECRYPT_INFO {
    cbSize : UInt32 := this.Size
    ContentEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pfnAlloc : PFN_CMSG_ALLOC
    pfnFree : PFN_CMSG_FREE
    hNCryptKey : NCRYPT_KEY_HANDLE
    pbContentEncryptKey : UInt8.Ptr
    cbContentEncryptKey : UInt32
    hCNGContentEncryptKey : BCRYPT_KEY_HANDLE
    pbCNGContentEncryptKeyObject : UInt8.Ptr
}
struct PFN_CMSG_CNG_IMPORT_KEY_TRANS extends FunctionPointer {
    static Types := [CMSG_CNG_CONTENT_DECRYPT_INFO.Ptr, CMSG_CTRL_KEY_TRANS_DECRYPT_PARA.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CMSG_CNG_IMPORT_KEY_AGREE extends FunctionPointer {
    static Types := [CMSG_CNG_CONTENT_DECRYPT_INFO.Ptr, CMSG_CTRL_KEY_AGREE_DECRYPT_PARA.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CMSG_CNG_IMPORT_CONTENT_ENCRYPT_KEY extends FunctionPointer {
    static Types := [CMSG_CNG_CONTENT_DECRYPT_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct CERT_CONTEXT {
    dwCertEncodingType : CERT_QUERY_ENCODING_TYPE
    pbCertEncoded : UInt8.Ptr
    cbCertEncoded : UInt32
    pCertInfo : CERT_INFO.Ptr
    hCertStore : HCERTSTORE
}
struct CRL_CONTEXT {
    dwCertEncodingType : CERT_QUERY_ENCODING_TYPE
    pbCrlEncoded : UInt8.Ptr
    cbCrlEncoded : UInt32
    pCrlInfo : CRL_INFO.Ptr
    hCertStore : HCERTSTORE
}
struct CTL_CONTEXT {
    dwMsgAndCertEncodingType : UInt32
    pbCtlEncoded : UInt8.Ptr
    cbCtlEncoded : UInt32
    pCtlInfo : CTL_INFO.Ptr
    hCertStore : HCERTSTORE
    hCryptMsg : Struct.Ptr
    pbCtlContent : UInt8.Ptr
    cbCtlContent : UInt32
}
struct CertKeyType extends UInt32 {
    static KeyTypeOther := 0
    static KeyTypeVirtualSmartCard := 1
    static KeyTypePhysicalSmartCard := 2
    static KeyTypePassport := 3
    static KeyTypePassportRemote := 4
    static KeyTypePassportSmartCard := 5
    static KeyTypeHardware := 6
    static KeyTypeSoftware := 7
    static KeyTypeSelfSigned := 8
}
struct CRYPT_KEY_PROV_PARAM {
    dwParam : UInt32
    pbData : UInt8.Ptr
    cbData : UInt32
    dwFlags : UInt32
}
struct CRYPT_KEY_PROV_INFO {
    pwszContainerName : PWSTR
    pwszProvName : PWSTR
    dwProvType : UInt32
    dwFlags : CRYPT_KEY_FLAGS
    cProvParam : UInt32
    rgProvParam : CRYPT_KEY_PROV_PARAM.Ptr
    dwKeySpec : UInt32
}
struct CERT_KEY_CONTEXT {
    cbSize : UInt32 := this.Size
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : UInt32
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct ROOT_INFO_LUID {
    LowPart : UInt32
    HighPart : Int32
}
struct CRYPT_SMART_CARD_ROOT_INFO {
    rgbCardID : UInt8[16]
    luid : ROOT_INFO_LUID
}
struct CERT_SYSTEM_STORE_RELOCATE_PARA {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            hKeyBase : HKEY
            pvBase : Struct.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pvSystemStore : Struct.Ptr
            pszSystemStore : PSTR
            pwszSystemStore : PWSTR
        }
    }
}
struct CERT_REGISTRY_STORE_CLIENT_GPT_PARA {
    hKeyBase : HKEY
    pwszRegPath : PWSTR
}
struct CERT_REGISTRY_STORE_ROAMING_PARA {
    hKey : HKEY
    pwszStoreDirectory : PWSTR
}
struct CERT_LDAP_STORE_OPENED_PARA {
    pvLdapSessionHandle : Struct.Ptr
    pwszLdapUrl : PWSTR
}
struct CERT_STORE_PROV_INFO {
    cbSize : UInt32 := this.Size
    cStoreProvFunc : UInt32
    rgpvStoreProvFunc : Struct.Ptr.Ptr
    hStoreProv : HCERTSTOREPROV
    dwStoreProvFlags : CERT_STORE_PROV_FLAGS
    hStoreProvFuncAddr2 : Struct.Ptr
}
struct PFN_CERT_DLL_OPEN_STORE_PROV_FUNC extends FunctionPointer {
    static Types := [PSTR, CERT_QUERY_ENCODING_TYPE, HCRYPTPROV_LEGACY, CERT_OPEN_STORE_FLAGS, Struct.Ptr, HCERTSTORE, CERT_STORE_PROV_INFO.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_CLOSE extends FunctionPointer {
    static Types := [HCERTSTOREPROV, UInt32, "Void"]
}
struct PFN_CERT_STORE_PROV_READ_CERT extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, UInt32, CERT_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_WRITE_CERT extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_DELETE_CERT extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_SET_CERT_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_READ_CRL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, UInt32, CRL_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_WRITE_CRL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_DELETE_CRL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_SET_CRL_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_READ_CTL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, UInt32, CTL_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_WRITE_CTL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_DELETE_CTL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_SET_CTL_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_CONTROL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct CERT_STORE_PROV_FIND_INFO {
    cbSize : UInt32 := this.Size
    dwMsgAndCertEncodingType : UInt32
    dwFindFlags : UInt32
    dwFindType : UInt32
    pvFindPara : Struct.Ptr
}
struct PFN_CERT_STORE_PROV_FIND_CERT extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_STORE_PROV_FIND_INFO.Ptr, CERT_CONTEXT.Ptr, UInt32, Struct.Ptr.Ptr, CERT_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_FREE_FIND_CERT extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, Struct.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_GET_CERT_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_FIND_CRL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_STORE_PROV_FIND_INFO.Ptr, CRL_CONTEXT.Ptr, UInt32, Struct.Ptr.Ptr, CRL_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_FREE_FIND_CRL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, Struct.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_GET_CRL_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CRL_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_FIND_CTL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CERT_STORE_PROV_FIND_INFO.Ptr, CTL_CONTEXT.Ptr, UInt32, Struct.Ptr.Ptr, CTL_CONTEXT.Ptr.Ptr, BOOL]
}
struct PFN_CERT_STORE_PROV_FREE_FIND_CTL extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, Struct.Ptr, UInt32, BOOL]
}
struct PFN_CERT_STORE_PROV_GET_CTL_PROPERTY extends FunctionPointer {
    static Types := [HCERTSTOREPROV, CTL_CONTEXT.Ptr, UInt32, UInt32, Struct.Ptr, UInt32.Ptr, BOOL]
}
struct CRL_FIND_ISSUED_FOR_PARA {
    pSubjectCert : CERT_CONTEXT.Ptr
    pIssuerCert : CERT_CONTEXT.Ptr
}
struct CTL_ANY_SUBJECT_INFO {
    SubjectAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    SubjectIdentifier : CRYPT_INTEGER_BLOB
}
struct CTL_FIND_USAGE_PARA {
    cbSize : UInt32 := this.Size
    SubjectUsage : CTL_USAGE
    ListIdentifier : CRYPT_INTEGER_BLOB
    pSigner : CERT_INFO.Ptr
}
struct CTL_FIND_SUBJECT_PARA {
    cbSize : UInt32 := this.Size
    pUsagePara : CTL_FIND_USAGE_PARA.Ptr
    dwSubjectType : UInt32
    pvSubject : Struct.Ptr
}
struct PFN_CERT_CREATE_CONTEXT_SORT_FUNC extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct CERT_CREATE_CONTEXT_PARA {
    cbSize : UInt32 := this.Size
    pfnFree : PFN_CRYPT_FREE
    pvFree : Struct.Ptr
    pfnSort : PFN_CERT_CREATE_CONTEXT_SORT_FUNC
    pvSort : Struct.Ptr
}
struct CERT_SYSTEM_STORE_INFO {
    cbSize : UInt32 := this.Size
}
struct CERT_PHYSICAL_STORE_INFO {
    cbSize : UInt32 := this.Size
    pszOpenStoreProvider : PSTR
    dwOpenEncodingType : UInt32
    dwOpenFlags : UInt32
    OpenParameters : CRYPT_INTEGER_BLOB
    dwFlags : UInt32
    dwPriority : UInt32
}
struct PFN_CERT_ENUM_SYSTEM_STORE_LOCATION extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr, Struct.Ptr, BOOL]
}
struct PFN_CERT_ENUM_SYSTEM_STORE extends FunctionPointer {
    static Types := [Struct.Ptr, CERT_SYSTEM_STORE_FLAGS, CERT_SYSTEM_STORE_INFO.Ptr, Struct.Ptr, Struct.Ptr, BOOL]
}
struct PFN_CERT_ENUM_PHYSICAL_STORE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, CERT_PHYSICAL_STORE_INFO.Ptr, Struct.Ptr, Struct.Ptr, BOOL]
}
struct CTL_VERIFY_USAGE_PARA {
    cbSize : UInt32 := this.Size
    ListIdentifier : CRYPT_INTEGER_BLOB
    cCtlStore : UInt32
    rghCtlStore : HCERTSTORE.Ptr
    cSignerStore : UInt32
    rghSignerStore : HCERTSTORE.Ptr
}
struct CTL_VERIFY_USAGE_STATUS {
    cbSize : UInt32 := this.Size
    dwError : UInt32
    dwFlags : UInt32
    ppCtl : CTL_CONTEXT.Ptr.Ptr
    dwCtlEntryIndex : UInt32
    ppSigner : CERT_CONTEXT.Ptr.Ptr
    dwSignerIndex : UInt32
}
struct CERT_REVOCATION_CRL_INFO {
    cbSize : UInt32 := this.Size
    pBaseCrlContext : CRL_CONTEXT.Ptr
    pDeltaCrlContext : CRL_CONTEXT.Ptr
    pCrlEntry : CRL_ENTRY.Ptr
    fDeltaCrlEntry : BOOL
}
struct CERT_REVOCATION_PARA {
    cbSize : UInt32 := this.Size
    pIssuerCert : CERT_CONTEXT.Ptr
    cCertStore : UInt32
    rgCertStore : HCERTSTORE.Ptr
    hCrlStore : HCERTSTORE
    pftTimeToUse : FILETIME.Ptr
}
struct CERT_REVOCATION_STATUS {
    cbSize : UInt32 := this.Size
    dwIndex : UInt32
    dwError : UInt32
    dwReason : CERT_REVOCATION_STATUS_REASON
    fHasFreshnessTime : BOOL
    dwFreshnessTime : UInt32
}
struct CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO {
    CertSignHashCNGAlgPropData : CRYPT_INTEGER_BLOB
    CertIssuerPubKeyBitLengthPropData : CRYPT_INTEGER_BLOB
}
struct CRYPT_VERIFY_CERT_SIGN_WEAK_HASH_INFO {
    cCNGHashAlgid : UInt32
    rgpwszCNGHashAlgid : PWSTR.Ptr
    dwWeakIndex : UInt32
}
struct PFN_CRYPT_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC extends FunctionPointer {
    static Types := [CERT_QUERY_ENCODING_TYPE, CRYPT_ALGORITHM_IDENTIFIER.Ptr, Struct.Ptr.Ptr, PWSTR.Ptr, BOOL]
}
struct PFN_CRYPT_SIGN_AND_ENCODE_HASH_FUNC extends FunctionPointer {
    static Types := [NCRYPT_KEY_HANDLE, CERT_QUERY_ENCODING_TYPE, CRYPT_ALGORITHM_IDENTIFIER.Ptr, Struct.Ptr, PWSTR, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CRYPT_VERIFY_ENCODED_SIGNATURE_FUNC extends FunctionPointer {
    static Types := [CERT_QUERY_ENCODING_TYPE, CERT_PUBLIC_KEY_INFO.Ptr, CRYPT_ALGORITHM_IDENTIFIER.Ptr, Struct.Ptr, PWSTR, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, BOOL]
}
struct CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA {
    cOID : UInt32
    rgpszOID : PSTR.Ptr
}
struct PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC extends FunctionPointer {
    static Types := [NCRYPT_KEY_HANDLE, CERT_QUERY_ENCODING_TYPE, PSTR, UInt32, Struct.Ptr, CERT_PUBLIC_KEY_INFO.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, CERT_QUERY_ENCODING_TYPE, PSTR, UInt32, Struct.Ptr, CERT_PUBLIC_KEY_INFO.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC extends FunctionPointer {
    static Types := [CERT_QUERY_ENCODING_TYPE, CERT_PUBLIC_KEY_INFO.Ptr, UInt32, Struct.Ptr, BCRYPT_KEY_HANDLE.Ptr, BOOL]
}
struct PFN_IMPORT_PRIV_KEY_FUNC extends FunctionPointer {
    static Types := [IntPtr, CRYPT_PRIVATE_KEY_INFO.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct PFN_EXPORT_PRIV_KEY_FUNC extends FunctionPointer {
    static Types := [IntPtr, UInt32, PSTR, UInt32, Struct.Ptr, CRYPT_PRIVATE_KEY_INFO.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_CRYPT_GET_SIGNER_CERTIFICATE extends FunctionPointer {
    static Types := [Struct.Ptr, CERT_QUERY_ENCODING_TYPE, CERT_INFO.Ptr, HCERTSTORE, CERT_CONTEXT.Ptr]
}
struct CRYPT_SIGN_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgEncodingType : UInt32
    pSigningCert : CERT_CONTEXT.Ptr
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo : Struct.Ptr
    cMsgCert : UInt32
    rgpMsgCert : CERT_CONTEXT.Ptr.Ptr
    cMsgCrl : UInt32
    rgpMsgCrl : CRL_CONTEXT.Ptr.Ptr
    cAuthAttr : UInt32
    rgAuthAttr : CRYPT_ATTRIBUTE.Ptr
    cUnauthAttr : UInt32
    rgUnauthAttr : CRYPT_ATTRIBUTE.Ptr
    dwFlags : UInt32
    dwInnerContentType : UInt32
}
struct CRYPT_VERIFY_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgAndCertEncodingType : UInt32
    hCryptProv : HCRYPTPROV_LEGACY
    pfnGetSignerCertificate : PFN_CRYPT_GET_SIGNER_CERTIFICATE
    pvGetArg : Struct.Ptr
}
struct CRYPT_ENCRYPT_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgEncodingType : UInt32
    hCryptProv : HCRYPTPROV_LEGACY
    ContentEncryptionAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvEncryptionAuxInfo : Struct.Ptr
    dwFlags : UInt32
    dwInnerContentType : UInt32
}
struct CRYPT_DECRYPT_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgAndCertEncodingType : UInt32
    cCertStore : UInt32
    rghCertStore : HCERTSTORE.Ptr
}
struct CRYPT_HASH_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgEncodingType : UInt32
    hCryptProv : HCRYPTPROV_LEGACY
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo : Struct.Ptr
}
struct CRYPT_KEY_SIGN_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgAndCertEncodingType : CERT_QUERY_ENCODING_TYPE
    Anonymous : this._Anonymous_e__Union
    dwKeySpec : CERT_KEY_SPEC
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    pvHashAuxInfo : Struct.Ptr
    PubKeyAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    struct _Anonymous_e__Union {
        union {
            hCryptProv : IntPtr
            hNCryptKey : NCRYPT_KEY_HANDLE
        }
    }
}
struct CRYPT_KEY_VERIFY_MESSAGE_PARA {
    cbSize : UInt32 := this.Size
    dwMsgEncodingType : UInt32
    hCryptProv : HCRYPTPROV_LEGACY
}
struct CERT_CHAIN {
    cCerts : UInt32
    certs : CRYPT_INTEGER_BLOB.Ptr
    keyLocatorInfo : CRYPT_KEY_PROV_INFO
}
struct PFN_CRYPT_ASYNC_PARAM_FREE_FUNC extends FunctionPointer {
    static Types := [PSTR, Struct.Ptr, "Void"]
}
struct CRYPT_BLOB_ARRAY {
    cBlob : UInt32
    rgBlob : CRYPT_INTEGER_BLOB.Ptr
}
struct CRYPT_CREDENTIALS {
    cbSize : UInt32 := this.Size
    pszCredentialsOid : PSTR
    pvCredentials : Struct.Ptr
}
struct CRYPT_PASSWORD_CREDENTIALSA {
    cbSize : UInt32 := this.Size
    pszUsername : PSTR
    pszPassword : PSTR
}
struct CRYPT_PASSWORD_CREDENTIALSW {
    cbSize : UInt32 := this.Size
    pszUsername : PWSTR
    pszPassword : PWSTR
}
struct PFN_FREE_ENCODED_OBJECT_FUNC extends FunctionPointer {
    static Types := [PSTR, CRYPT_BLOB_ARRAY.Ptr, Struct.Ptr, "Void"]
}
struct CRYPTNET_URL_CACHE_PRE_FETCH_INFO {
    cbSize : UInt32 := this.Size
    dwObjectType : UInt32
    dwError : UInt32
    dwReserved : UInt32
    ThisUpdateTime : FILETIME
    NextUpdateTime : FILETIME
    PublishTime : FILETIME
}
struct CRYPTNET_URL_CACHE_FLUSH_INFO {
    cbSize : UInt32 := this.Size
    dwExemptSeconds : UInt32
    ExpireTime : FILETIME
}
struct CRYPTNET_URL_CACHE_RESPONSE_INFO {
    cbSize : UInt32 := this.Size
    wResponseType : UInt16
    wResponseFlags : UInt16
    LastModifiedTime : FILETIME
    dwMaxAge : UInt32
    pwszETag : PWSTR
    dwProxyId : UInt32
}
struct CRYPT_RETRIEVE_AUX_INFO {
    cbSize : UInt32 := this.Size
    pLastSyncTime : FILETIME.Ptr
    dwMaxUrlRetrievalByteCount : UInt32
    pPreFetchInfo : CRYPTNET_URL_CACHE_PRE_FETCH_INFO.Ptr
    pFlushInfo : CRYPTNET_URL_CACHE_FLUSH_INFO.Ptr
    ppResponseInfo : CRYPTNET_URL_CACHE_RESPONSE_INFO.Ptr.Ptr
    pwszCacheFileNamePrefix : PWSTR
    pftCacheResync : FILETIME.Ptr
    fProxyCacheRetrieval : BOOL
    dwHttpStatusCode : UInt32
    ppwszErrorResponseHeaders : PWSTR.Ptr
    ppErrorContentBlob : CRYPT_INTEGER_BLOB.Ptr.Ptr
}
struct PFN_CRYPT_CANCEL_RETRIEVAL extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, BOOL]
}
struct PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PSTR, PSTR, Struct.Ptr, "Void"]
}
struct CRYPT_ASYNC_RETRIEVAL_COMPLETION {
    pfnCompletion : PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC
    pvCompletion : Struct.Ptr
}
struct PFN_CANCEL_ASYNC_RETRIEVAL_FUNC extends FunctionPointer {
    static Types := [HCRYPTASYNC, BOOL]
}
struct CRYPT_URL_ARRAY {
    cUrl : UInt32
    rgwszUrl : PWSTR.Ptr
}
struct CRYPT_URL_INFO {
    cbSize : UInt32 := this.Size
    dwSyncDeltaTime : UInt32
    cGroup : UInt32
    rgcGroupEntry : UInt32.Ptr
}
struct CERT_CRL_CONTEXT_PAIR {
    pCertContext : CERT_CONTEXT.Ptr
    pCrlContext : CRL_CONTEXT.Ptr
}
struct CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO {
    cbSize : UInt32 := this.Size
    iDeltaCrlIndicator : Int32
    pftCacheResync : FILETIME.Ptr
    pLastSyncTime : FILETIME.Ptr
    pMaxAgeTime : FILETIME.Ptr
    pChainPara : CERT_REVOCATION_CHAIN_PARA.Ptr
    pDeltaCrlIndicator : CRYPT_INTEGER_BLOB.Ptr
}
struct PFN_CRYPT_ENUM_KEYID_PROP extends FunctionPointer {
    static Types := [CRYPT_INTEGER_BLOB.Ptr, UInt32, Struct.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct CERT_CHAIN_ENGINE_CONFIG {
    cbSize : UInt32 := this.Size
    hRestrictedRoot : HCERTSTORE
    hRestrictedTrust : HCERTSTORE
    hRestrictedOther : HCERTSTORE
    cAdditionalStore : UInt32
    rghAdditionalStore : HCERTSTORE.Ptr
    dwFlags : UInt32
    dwUrlRetrievalTimeout : UInt32
    MaximumCachedCertificates : UInt32
    CycleDetectionModulus : UInt32
    hExclusiveRoot : HCERTSTORE
    hExclusiveTrustedPeople : HCERTSTORE
    dwExclusiveFlags : UInt32
}
struct CERT_TRUST_STATUS {
    dwErrorStatus : UInt32
    dwInfoStatus : UInt32
}
struct CERT_REVOCATION_INFO {
    cbSize : UInt32 := this.Size
    dwRevocationResult : UInt32
    pszRevocationOid : PSTR
    pvOidSpecificInfo : Struct.Ptr
    fHasFreshnessTime : BOOL
    dwFreshnessTime : UInt32
    pCrlInfo : CERT_REVOCATION_CRL_INFO.Ptr
}
struct CERT_TRUST_LIST_INFO {
    cbSize : UInt32 := this.Size
    pCtlEntry : CTL_ENTRY.Ptr
    pCtlContext : CTL_CONTEXT.Ptr
}
struct CERT_CHAIN_ELEMENT {
    cbSize : UInt32 := this.Size
    pCertContext : CERT_CONTEXT.Ptr
    TrustStatus : CERT_TRUST_STATUS
    pRevocationInfo : CERT_REVOCATION_INFO.Ptr
    pIssuanceUsage : CTL_USAGE.Ptr
    pApplicationUsage : CTL_USAGE.Ptr
    pwszExtendedErrorInfo : PWSTR
}
struct CERT_SIMPLE_CHAIN {
    cbSize : UInt32 := this.Size
    TrustStatus : CERT_TRUST_STATUS
    cElement : UInt32
    rgpElement : CERT_CHAIN_ELEMENT.Ptr.Ptr
    pTrustListInfo : CERT_TRUST_LIST_INFO.Ptr
    fHasRevocationFreshnessTime : BOOL
    dwRevocationFreshnessTime : UInt32
}
struct CERT_CHAIN_CONTEXT {
    cbSize : UInt32 := this.Size
    TrustStatus : CERT_TRUST_STATUS
    cChain : UInt32
    rgpChain : CERT_SIMPLE_CHAIN.Ptr.Ptr
    cLowerQualityChainContext : UInt32
    rgpLowerQualityChainContext : CERT_CHAIN_CONTEXT.Ptr.Ptr
    fHasRevocationFreshnessTime : BOOL
    dwRevocationFreshnessTime : UInt32
    dwCreateFlags : UInt32
    ChainId : GUID
}
struct CERT_USAGE_MATCH {
    dwType : UInt32
    Usage : CTL_USAGE
}
struct CTL_USAGE_MATCH {
    dwType : UInt32
    Usage : CTL_USAGE
}
struct CERT_CHAIN_PARA {
    cbSize : UInt32 := this.Size
    RequestedUsage : CERT_USAGE_MATCH
    RequestedIssuancePolicy : CERT_USAGE_MATCH
    dwUrlRetrievalTimeout : UInt32
    fCheckRevocationFreshnessTime : BOOL
    dwRevocationFreshnessTime : UInt32
    pftCacheResync : FILETIME.Ptr
    pStrongSignPara : CERT_STRONG_SIGN_PARA.Ptr
    dwStrongSignFlags : UInt32
}
struct CERT_REVOCATION_CHAIN_PARA {
    cbSize : UInt32 := this.Size
    hChainEngine : HCERTCHAINENGINE
    hAdditionalStore : HCERTSTORE
    dwChainFlags : UInt32
    dwUrlRetrievalTimeout : UInt32
    pftCurrentTime : FILETIME.Ptr
    pftCacheResync : FILETIME.Ptr
    cbMaxUrlRetrievalByteCount : UInt32
}
struct CRL_REVOCATION_INFO {
    pCrlEntry : CRL_ENTRY.Ptr
    pCrlContext : CRL_CONTEXT.Ptr
    pCrlIssuerChain : CERT_CHAIN_CONTEXT.Ptr
}
struct PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, Struct.Ptr, BOOL]
}
struct CERT_CHAIN_FIND_BY_ISSUER_PARA {
    cbSize : UInt32 := this.Size
    pszUsageIdentifier : PSTR
    dwKeySpec : UInt32
    dwAcquirePrivateKeyFlags : UInt32
    cIssuer : UInt32
    rgIssuer : CRYPT_INTEGER_BLOB.Ptr
    pfnFindCallback : PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK
    pvFindArg : Struct.Ptr
}
struct CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwFlags : CERT_CHAIN_POLICY_FLAGS
    pvExtraPolicyPara : Struct.Ptr
}
struct CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    dwError : UInt32
    lChainIndex : Int32
    lElementIndex : Int32
    pvExtraPolicyStatus : Struct.Ptr
}
struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwRegPolicySettings : UInt32
    pSignerInfo : CMSG_SIGNER_INFO.Ptr
}
struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    fCommercial : BOOL
}
struct AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwRegPolicySettings : UInt32
    fCommercial : BOOL
}
struct HTTPSPolicyCallbackData {
    Anonymous : this._Anonymous_e__Union
    dwAuthType : HTTPSPOLICY_CALLBACK_DATA_AUTH_TYPE
    fdwChecks : UInt32
    pwszServerName : PWSTR
    struct _Anonymous_e__Union {
        union {
            cbStruct : UInt32
            cbSize : UInt32 := this.Size
        }
    }
}
struct EV_EXTRA_CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwRootProgramQualifierFlags : CERT_ROOT_PROGRAM_FLAGS
}
struct EV_EXTRA_CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    dwQualifiers : UInt32
    dwIssuanceUsageIndex : UInt32
}
struct SSL_F12_EXTRA_CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    dwErrorLevel : UInt32
    dwErrorCategory : UInt32
    dwReserved : UInt32
    wszErrorText : UInt16[256]
}
struct SSL_HPKP_HEADER_EXTRA_CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwReserved : UInt32
    pwszServerName : PWSTR
    rgpszHpkpValue : PSTR[2]
}
struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_PARA {
    cbSize : UInt32 := this.Size
    dwReserved : UInt32
    pwszServerName : PWSTR
}
struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    lError : Int32
    wszErrorText : UInt16[512]
}
struct CT_EXTRA_CERT_CHAIN_POLICY_STATUS {
    cbSize : UInt32 := this.Size
    lErrorStatus : Int32
    lErrorSubStatus : Int32
    cEntries : UInt32
    cValidated : UInt32
}
struct CRYPT_PKCS12_PBE_PARAMS {
    iIterations : Int32
    cbSalt : UInt32
}
struct PKCS12_PBES2_EXPORT_PARAMS {
    dwSize : UInt32
    hNcryptDescriptor : Struct.Ptr
    pwszPbes2Alg : PWSTR
}
struct CERT_SERVER_OCSP_RESPONSE_CONTEXT {
    cbSize : UInt32 := this.Size
    pbEncodedOcspResponse : UInt8.Ptr
    cbEncodedOcspResponse : UInt32
}
struct PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK extends FunctionPointer {
    static Types := [CERT_CHAIN_CONTEXT.Ptr, CERT_SERVER_OCSP_RESPONSE_CONTEXT.Ptr, CRL_CONTEXT.Ptr, CRL_CONTEXT.Ptr, Struct.Ptr, UInt32, "Void"]
}
struct CERT_SERVER_OCSP_RESPONSE_OPEN_PARA {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    pcbUsedSize : UInt32.Ptr
    pwszOcspDirectory : PWSTR
    pfnUpdateCallback : PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK
    pvUpdateCallbackArg : Struct.Ptr
}
struct CERT_SELECT_CHAIN_PARA {
    hChainEngine : HCERTCHAINENGINE
    pTime : FILETIME.Ptr
    hAdditionalStore : HCERTSTORE
    pChainPara : CERT_CHAIN_PARA.Ptr
    dwFlags : UInt32
}
struct CERT_SELECT_CRITERIA {
    dwType : CERT_SELECT_CRITERIA_TYPE
    cPara : UInt32
    ppPara : Struct.Ptr.Ptr
}
struct CRYPT_TIMESTAMP_REQUEST {
    dwVersion : CRYPT_TIMESTAMP_VERSION
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    HashedMessage : CRYPT_INTEGER_BLOB
    pszTSAPolicyId : PSTR
    Nonce : CRYPT_INTEGER_BLOB
    fCertReq : BOOL
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CRYPT_TIMESTAMP_RESPONSE {
    dwStatus : CRYPT_TIMESTAMP_RESPONSE_STATUS
    cFreeText : UInt32
    rgFreeText : PWSTR.Ptr
    FailureInfo : CRYPT_BIT_BLOB
    ContentInfo : CRYPT_INTEGER_BLOB
}
struct CRYPT_TIMESTAMP_ACCURACY {
    dwSeconds : UInt32
    dwMillis : UInt32
    dwMicros : UInt32
}
struct CRYPT_TIMESTAMP_INFO {
    dwVersion : UInt32
    pszTSAPolicyId : PSTR
    HashAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    HashedMessage : CRYPT_INTEGER_BLOB
    SerialNumber : CRYPT_INTEGER_BLOB
    ftTime : FILETIME
    pvAccuracy : CRYPT_TIMESTAMP_ACCURACY.Ptr
    fOrdering : BOOL
    Nonce : CRYPT_INTEGER_BLOB
    Tsa : CRYPT_INTEGER_BLOB
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct CRYPT_TIMESTAMP_CONTEXT {
    cbEncoded : UInt32
    pbEncoded : UInt8.Ptr
    pTimeStamp : CRYPT_TIMESTAMP_INFO.Ptr
}
struct CRYPT_TIMESTAMP_PARA {
    pszTSAPolicyId : PSTR
    fRequestCerts : BOOL
    Nonce : CRYPT_INTEGER_BLOB
    cExtension : UInt32
    rgExtension : CERT_EXTENSION.Ptr
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH extends FunctionPointer {
    static Types := [Struct.Ptr, CRYPT_INTEGER_BLOB.Ptr.Ptr, UInt32, BOOL]
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET extends FunctionPointer {
    static Types := [Struct.Ptr, CRYPT_INTEGER_BLOB.Ptr, UInt32, CRYPT_INTEGER_BLOB.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, PWSTR.Ptr, CRYPT_INTEGER_BLOB.Ptr.Ptr, BOOL]
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE extends FunctionPointer {
    static Types := [CRYPT_OBJECT_LOCATOR_RELEASE_REASON, Struct.Ptr, "Void"]
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, "Void"]
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, "Void"]
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER extends FunctionPointer {
    static Types := [Struct.Ptr, CRYPT_INTEGER_BLOB.Ptr, "Void"]
}
struct CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE {
    cbSize : UInt32 := this.Size
    pfnGet : PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET
    pfnRelease : PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE
    pfnFreePassword : PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD
    pfnFree : PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE
    pfnFreeIdentifier : PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER
}
struct PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_INITIALIZE extends FunctionPointer {
    static Types := [PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH, Struct.Ptr, UInt32.Ptr, CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE.Ptr.Ptr, Struct.Ptr.Ptr, BOOL]
}
struct PFN_CERT_IS_WEAK_HASH extends FunctionPointer {
    static Types := [UInt32, PWSTR, UInt32, CERT_CHAIN_CONTEXT.Ptr, FILETIME.Ptr, PWSTR, BOOL]
}
struct CRYPTPROTECT_PROMPTSTRUCT {
    cbSize : UInt32 := this.Size
    dwPromptFlags : UInt32
    hwndApp : HWND
    szPrompt : PWSTR
}
struct PFNCryptStreamOutputCallback extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, IntPtr, BOOL, HRESULT]
}
struct NCRYPT_PROTECT_STREAM_INFO {
    pfnStreamOutput : PFNCryptStreamOutputCallback
    pvCallbackCtxt : Struct.Ptr
}
struct PFNCryptStreamOutputCallbackEx extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, IntPtr, NCRYPT_DESCRIPTOR_HANDLE, BOOL, HRESULT]
}
struct NCRYPT_PROTECT_STREAM_INFO_EX {
    pfnStreamOutput : PFNCryptStreamOutputCallbackEx
    pvCallbackCtxt : Struct.Ptr
}
struct PFN_AUTHENTICODE_DIGEST_SIGN extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, CRYPT_INTEGER_BLOB.Ptr, ALG_ID, UInt8.Ptr, UInt32, CRYPT_INTEGER_BLOB.Ptr, HRESULT]
}
struct PFN_AUTHENTICODE_DIGEST_SIGN_EX extends FunctionPointer {
    static Types := [CRYPT_INTEGER_BLOB.Ptr, ALG_ID, UInt8.Ptr, UInt32, CRYPT_INTEGER_BLOB.Ptr, CERT_CONTEXT.Ptr.Ptr, HCERTSTORE, HRESULT]
}
struct PFN_AUTHENTICODE_DIGEST_SIGN_EX_WITHFILEHANDLE extends FunctionPointer {
    static Types := [CRYPT_INTEGER_BLOB.Ptr, ALG_ID, UInt8.Ptr, UInt32, HANDLE, CRYPT_INTEGER_BLOB.Ptr, CERT_CONTEXT.Ptr.Ptr, HCERTSTORE, HRESULT]
}
struct PFN_AUTHENTICODE_DIGEST_SIGN_WITHFILEHANDLE extends FunctionPointer {
    static Types := [CERT_CONTEXT.Ptr, CRYPT_INTEGER_BLOB.Ptr, ALG_ID, UInt8.Ptr, UInt32, HANDLE, CRYPT_INTEGER_BLOB.Ptr, HRESULT]
}
struct SIGNER_ATTR_AUTHCODE {
    cbSize : UInt32 := this.Size
    fCommercial : BOOL
    fIndividual : BOOL
    pwszName : PWSTR
    pwszInfo : PWSTR
}
struct SIGNER_BLOB_INFO {
    cbSize : UInt32 := this.Size
    pGuidSubject : GUID.Ptr
    cbBlob : UInt32
    pbBlob : UInt8.Ptr
    pwszDisplayName : PWSTR
}
struct SIGNER_CERT_STORE_INFO {
    cbSize : UInt32 := this.Size
    pSigningCert : CERT_CONTEXT.Ptr
    dwCertPolicy : SIGNER_CERT_POLICY
    hCertStore : HCERTSTORE
}
struct SIGNER_SPC_CHAIN_INFO {
    cbSize : UInt32 := this.Size
    pwszSpcFile : PWSTR
    dwCertPolicy : UInt32
    hCertStore : HCERTSTORE
}
struct SIGNER_CERT {
    cbSize : UInt32 := this.Size
    dwCertChoice : SIGNER_CERT_CHOICE
    Anonymous : this._Anonymous_e__Union
    hwnd : HWND
    struct _Anonymous_e__Union {
        union {
            pwszSpcFile : PWSTR
            pCertStoreInfo : SIGNER_CERT_STORE_INFO.Ptr
            pSpcChainInfo : SIGNER_SPC_CHAIN_INFO.Ptr
        }
    }
}
struct SIGNER_CONTEXT {
    cbSize : UInt32 := this.Size
    cbBlob : UInt32
    pbBlob : UInt8.Ptr
}
struct SIGNER_DIGEST_SIGN_INFO {
    cbSize : UInt32 := this.Size
    dwDigestSignChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    pMetadataBlob : CRYPT_INTEGER_BLOB.Ptr
    dwReserved : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    struct _Anonymous_e__Union {
        union {
            pfnAuthenticodeDigestSign : PFN_AUTHENTICODE_DIGEST_SIGN
            pfnAuthenticodeDigestSignWithFileHandle : PFN_AUTHENTICODE_DIGEST_SIGN_WITHFILEHANDLE
            pfnAuthenticodeDigestSignEx : PFN_AUTHENTICODE_DIGEST_SIGN_EX
            pfnAuthenticodeDigestSignExWithFileHandle : PFN_AUTHENTICODE_DIGEST_SIGN_EX_WITHFILEHANDLE
        }
    }
}
struct SIGNER_DIGEST_SIGN_INFO_V1 {
    cbSize : UInt32 := this.Size
    pfnAuthenticodeDigestSign : PFN_AUTHENTICODE_DIGEST_SIGN
    pMetadataBlob : CRYPT_INTEGER_BLOB.Ptr
}
struct SIGNER_DIGEST_SIGN_INFO_V2 {
    cbSize : UInt32 := this.Size
    pfnAuthenticodeDigestSign : PFN_AUTHENTICODE_DIGEST_SIGN
    pfnAuthenticodeDigestSignEx : PFN_AUTHENTICODE_DIGEST_SIGN_EX
    pMetadataBlob : CRYPT_INTEGER_BLOB.Ptr
}
struct SIGNER_FILE_INFO {
    cbSize : UInt32 := this.Size
    pwszFileName : PWSTR
    hFile : HANDLE
}
struct SIGNER_PROVIDER_INFO {
    cbSize : UInt32 := this.Size
    pwszProviderName : PWSTR
    dwProviderType : UInt32
    dwKeySpec : UInt32
    dwPvkChoice : SIGNER_PRIVATE_KEY_CHOICE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pwszPvkFileName : PWSTR
            pwszKeyContainer : PWSTR
        }
    }
}
struct SIGNER_SIGNATURE_INFO {
    cbSize : UInt32 := this.Size
    algidHash : ALG_ID
    dwAttrChoice : SIGNER_SIGNATURE_ATTRIBUTE_CHOICE
    Anonymous : this._Anonymous_e__Union
    psAuthenticated : CRYPT_ATTRIBUTES.Ptr
    psUnauthenticated : CRYPT_ATTRIBUTES.Ptr
    struct _Anonymous_e__Union {
        union {
            pAttrAuthcode : SIGNER_ATTR_AUTHCODE.Ptr
        }
    }
}
struct SIGNER_SUBJECT_INFO {
    cbSize : UInt32 := this.Size
    pdwIndex : UInt32.Ptr
    dwSubjectChoice : SIGNER_SUBJECT_CHOICE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pSignerFileInfo : SIGNER_FILE_INFO.Ptr
            pSignerBlobInfo : SIGNER_BLOB_INFO.Ptr
        }
    }
}
struct CRYPT_XML_CHARSET extends Int32 {
    static CRYPT_XML_CHARSET_AUTO := 0
    static CRYPT_XML_CHARSET_UTF8 := 1
    static CRYPT_XML_CHARSET_UTF16LE := 2
    static CRYPT_XML_CHARSET_UTF16BE := 3
}
struct CRYPT_XML_BLOB {
    dwCharset : CRYPT_XML_CHARSET
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct CRYPT_XML_DATA_BLOB {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct CRYPT_XML_PROPERTY_ID extends Int32 {
    static CRYPT_XML_PROPERTY_MAX_HEAP_SIZE := 1
    static CRYPT_XML_PROPERTY_SIGNATURE_LOCATION := 2
    static CRYPT_XML_PROPERTY_MAX_SIGNATURES := 3
    static CRYPT_XML_PROPERTY_DOC_DECLARATION := 4
    static CRYPT_XML_PROPERTY_XML_OUTPUT_CHARSET := 5
}
struct CRYPT_XML_PROPERTY {
    dwPropId : CRYPT_XML_PROPERTY_ID
    pvValue : Struct.Ptr
    cbValue : UInt32
}
struct PFN_CRYPT_XML_WRITE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, UInt32, HRESULT]
}
struct PFN_CRYPT_XML_DATA_PROVIDER_READ extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct PFN_CRYPT_XML_DATA_PROVIDER_CLOSE extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct CRYPT_XML_DATA_PROVIDER {
    pvCallbackState : Struct.Ptr
    cbBufferSize : UInt32
    pfnRead : PFN_CRYPT_XML_DATA_PROVIDER_READ
    pfnClose : PFN_CRYPT_XML_DATA_PROVIDER_CLOSE
}
struct PFN_CRYPT_XML_CREATE_TRANSFORM extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM.Ptr, CRYPT_XML_DATA_PROVIDER.Ptr, CRYPT_XML_DATA_PROVIDER.Ptr, HRESULT]
}
struct CRYPT_XML_STATUS {
    cbSize : UInt32 := this.Size
    dwErrorStatus : CRYPT_XML_STATUS_ERROR_STATUS
    dwInfoStatus : CRYPT_XML_STATUS_INFO_STATUS
}
struct CRYPT_XML_ALGORITHM {
    cbSize : UInt32 := this.Size
    wszAlgorithm : PWSTR
    Encoded : CRYPT_XML_BLOB
}
struct CRYPT_XML_TRANSFORM_INFO {
    cbSize : UInt32 := this.Size
    wszAlgorithm : PWSTR
    cbBufferSize : UInt32
    dwFlags : CRYPT_XML_TRANSFORM_FLAGS
    pfnCreateTransform : PFN_CRYPT_XML_CREATE_TRANSFORM
}
struct CRYPT_XML_TRANSFORM_CHAIN_CONFIG {
    cbSize : UInt32 := this.Size
    cTransformInfo : UInt32
    rgpTransformInfo : CRYPT_XML_TRANSFORM_INFO.Ptr.Ptr
}
struct CRYPT_XML_KEY_DSA_KEY_VALUE {
    P : CRYPT_XML_DATA_BLOB
    Q : CRYPT_XML_DATA_BLOB
    G : CRYPT_XML_DATA_BLOB
    Y : CRYPT_XML_DATA_BLOB
    J : CRYPT_XML_DATA_BLOB
    Seed : CRYPT_XML_DATA_BLOB
    Counter : CRYPT_XML_DATA_BLOB
}
struct CRYPT_XML_KEY_ECDSA_KEY_VALUE {
    wszNamedCurve : PWSTR
    X : CRYPT_XML_DATA_BLOB
    Y : CRYPT_XML_DATA_BLOB
    ExplicitPara : CRYPT_XML_BLOB
}
struct CRYPT_XML_KEY_RSA_KEY_VALUE {
    Modulus : CRYPT_XML_DATA_BLOB
    Exponent : CRYPT_XML_DATA_BLOB
}
struct CRYPT_XML_KEY_VALUE {
    dwType : CRYPT_XML_KEY_VALUE_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            DSAKeyValue : CRYPT_XML_KEY_DSA_KEY_VALUE
            RSAKeyValue : CRYPT_XML_KEY_RSA_KEY_VALUE
            ECDSAKeyValue : CRYPT_XML_KEY_ECDSA_KEY_VALUE
            Custom : CRYPT_XML_BLOB
        }
    }
}
struct CRYPT_XML_ISSUER_SERIAL {
    wszIssuer : PWSTR
    wszSerial : PWSTR
}
struct CRYPT_XML_X509DATA_ITEM {
    dwType : CRYPT_XML_X509DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            IssuerSerial : CRYPT_XML_ISSUER_SERIAL
            SKI : CRYPT_XML_DATA_BLOB
            wszSubjectName : PWSTR
            Certificate : CRYPT_XML_DATA_BLOB
            CRL : CRYPT_XML_DATA_BLOB
            Custom : CRYPT_XML_BLOB
        }
    }
}
struct CRYPT_XML_X509DATA {
    cX509Data : UInt32
    rgX509Data : CRYPT_XML_X509DATA_ITEM.Ptr
}
struct CRYPT_XML_KEY_INFO_ITEM {
    dwType : CRYPT_XML_KEYINFO_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            wszKeyName : PWSTR
            KeyValue : CRYPT_XML_KEY_VALUE
            RetrievalMethod : CRYPT_XML_BLOB
            X509Data : CRYPT_XML_X509DATA
            Custom : CRYPT_XML_BLOB
        }
    }
}
struct CRYPT_XML_KEY_INFO {
    cbSize : UInt32 := this.Size
    wszId : PWSTR
    cKeyInfo : UInt32
    rgKeyInfo : CRYPT_XML_KEY_INFO_ITEM.Ptr
    hVerifyKey : BCRYPT_KEY_HANDLE
}
struct CRYPT_XML_REFERENCE {
    cbSize : UInt32 := this.Size
    hReference : Struct.Ptr
    wszId : PWSTR
    wszUri : PWSTR
    wszType : PWSTR
    DigestMethod : CRYPT_XML_ALGORITHM
    DigestValue : CRYPT_INTEGER_BLOB
    cTransform : UInt32
    rgTransform : CRYPT_XML_ALGORITHM.Ptr
}
struct CRYPT_XML_REFERENCES {
    cReference : UInt32
    rgpReference : CRYPT_XML_REFERENCE.Ptr.Ptr
}
struct CRYPT_XML_SIGNED_INFO {
    cbSize : UInt32 := this.Size
    wszId : PWSTR
    Canonicalization : CRYPT_XML_ALGORITHM
    SignatureMethod : CRYPT_XML_ALGORITHM
    cReference : UInt32
    rgpReference : CRYPT_XML_REFERENCE.Ptr.Ptr
    Encoded : CRYPT_XML_BLOB
}
struct CRYPT_XML_OBJECT {
    cbSize : UInt32 := this.Size
    hObject : Struct.Ptr
    wszId : PWSTR
    wszMimeType : PWSTR
    wszEncoding : PWSTR
    Manifest : CRYPT_XML_REFERENCES
    Encoded : CRYPT_XML_BLOB
}
struct CRYPT_XML_SIGNATURE {
    cbSize : UInt32 := this.Size
    hSignature : Struct.Ptr
    wszId : PWSTR
    SignedInfo : CRYPT_XML_SIGNED_INFO
    SignatureValue : CRYPT_INTEGER_BLOB
    pKeyInfo : CRYPT_XML_KEY_INFO.Ptr
    cObject : UInt32
    rgpObject : CRYPT_XML_OBJECT.Ptr.Ptr
}
struct CRYPT_XML_DOC_CTXT {
    cbSize : UInt32 := this.Size
    hDocCtxt : Struct.Ptr
    pTransformsConfig : CRYPT_XML_TRANSFORM_CHAIN_CONFIG.Ptr
    cSignature : UInt32
    rgpSignature : CRYPT_XML_SIGNATURE.Ptr.Ptr
}
struct CRYPT_XML_KEYINFO_PARAM {
    wszId : PWSTR
    wszKeyName : PWSTR
    SKI : CRYPT_INTEGER_BLOB
    wszSubjectName : PWSTR
    cCertificate : UInt32
    rgCertificate : CRYPT_INTEGER_BLOB.Ptr
    cCRL : UInt32
    rgCRL : CRYPT_INTEGER_BLOB.Ptr
}
struct CRYPT_XML_KEYINFO_SPEC extends Int32 {
    static CRYPT_XML_KEYINFO_SPEC_NONE := 0
    static CRYPT_XML_KEYINFO_SPEC_ENCODED := 1
    static CRYPT_XML_KEYINFO_SPEC_PARAM := 2
}
struct CRYPT_XML_ALGORITHM_INFO {
    cbSize : UInt32 := this.Size
    wszAlgorithmURI : PWSTR
    wszName : PWSTR
    dwGroupId : CRYPT_XML_GROUP_ID
    wszCNGAlgid : PWSTR
    wszCNGExtraAlgid : PWSTR
    dwSignFlags : UInt32
    dwVerifyFlags : UInt32
    pvPaddingInfo : Struct.Ptr
    pvExtraInfo : Struct.Ptr
}
struct PFN_CRYPT_XML_ENUM_ALG_INFO extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM_INFO.Ptr, Struct.Ptr, BOOL]
}
struct CryptXmlDllGetInterface extends FunctionPointer {
    static Types := [UInt32, CRYPT_XML_ALGORITHM_INFO.Ptr, CRYPT_XML_CRYPTOGRAPHIC_INTERFACE.Ptr, HRESULT]
}
struct CryptXmlDllEncodeAlgorithm extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM_INFO.Ptr, CRYPT_XML_CHARSET, Struct.Ptr, PFN_CRYPT_XML_WRITE_CALLBACK, HRESULT]
}
struct CryptXmlDllCreateDigest extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct CryptXmlDllDigestData extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, UInt32, HRESULT]
}
struct CryptXmlDllFinalizeDigest extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8.Ptr, UInt32, HRESULT]
}
struct CryptXmlDllCloseDigest extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct CryptXmlDllSignData extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM.Ptr, HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, UInt32, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct CryptXmlDllVerifySignature extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM.Ptr, BCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, HRESULT]
}
struct CryptXmlDllGetAlgorithmInfo extends FunctionPointer {
    static Types := [CRYPT_XML_ALGORITHM.Ptr, CRYPT_XML_ALGORITHM_INFO.Ptr.Ptr, HRESULT]
}
struct CRYPT_XML_CRYPTOGRAPHIC_INTERFACE {
    cbSize : UInt32 := this.Size
    fpCryptXmlEncodeAlgorithm : CryptXmlDllEncodeAlgorithm
    fpCryptXmlCreateDigest : CryptXmlDllCreateDigest
    fpCryptXmlDigestData : CryptXmlDllDigestData
    fpCryptXmlFinalizeDigest : CryptXmlDllFinalizeDigest
    fpCryptXmlCloseDigest : CryptXmlDllCloseDigest
    fpCryptXmlSignData : CryptXmlDllSignData
    fpCryptXmlVerifySignature : CryptXmlDllVerifySignature
    fpCryptXmlGetAlgorithmInfo : CryptXmlDllGetAlgorithmInfo
}
struct CryptXmlDllEncodeKeyValue extends FunctionPointer {
    static Types := [NCRYPT_KEY_HANDLE, CRYPT_XML_CHARSET, Struct.Ptr, PFN_CRYPT_XML_WRITE_CALLBACK, HRESULT]
}
struct CryptXmlDllCreateKey extends FunctionPointer {
    static Types := [CRYPT_XML_BLOB.Ptr, BCRYPT_KEY_HANDLE.Ptr, HRESULT]
}
struct HandleType extends Int32 {
    static Asymmetric := 1
    static Symmetric := 2
    static Transform := 3
    static Hash := 4
}
struct PaddingMode extends Int32 {
    static None := 1
    static PKCS7 := 2
    static Zeros := 3
    static ANSIX923 := 4
    static ISO10126 := 5
}
struct Direction extends Int32 {
    static DirectionEncrypt := 1
    static DirectionDecrypt := 2
}
struct INFORMATIONCARD_ASYMMETRIC_CRYPTO_PARAMETERS {
    keySize : Int32
    keyExchangeAlgorithm : PWSTR
    signatureAlgorithm : PWSTR
}
struct INFORMATIONCARD_SYMMETRIC_CRYPTO_PARAMETERS {
    keySize : Int32
    blockSize : Int32
    feedbackSize : Int32
}
struct INFORMATIONCARD_TRANSFORM_CRYPTO_PARAMETERS {
    inputBlockSize : Int32
    outputBlockSize : Int32
    canTransformMultipleBlocks : BOOL
    canReuseTransform : BOOL
}
struct INFORMATIONCARD_HASH_CRYPTO_PARAMETERS {
    hashSize : Int32
    transform : INFORMATIONCARD_TRANSFORM_CRYPTO_PARAMETERS
}
struct INFORMATIONCARD_CRYPTO_HANDLE {
    type : HandleType
    expiration : Int64
    cryptoParameters : Struct.Ptr
}
struct GENERIC_XML_TOKEN {
    createDate : FILETIME
    expiryDate : FILETIME
    xmlToken : PWSTR
    internalTokenReference : PWSTR
    externalTokenReference : PWSTR
}
struct POLICY_ELEMENT {
    targetEndpointAddress : PWSTR
    issuerEndpointAddress : PWSTR
    issuedTokenParameters : PWSTR
    privacyNoticeLink : PWSTR
    privacyNoticeVersion : UInt32
    useManagedPresentation : BOOL
}
struct ENDPOINTADDRESS {
    serviceUrl : PWSTR
    policyUrl : PWSTR
    rawCertificate : CRYPT_INTEGER_BLOB
}
struct ENDPOINTADDRESS2 {
    serviceUrl : PWSTR
    policyUrl : PWSTR
    identityType : UInt32
    identityBytes : Struct.Ptr
}
struct CERTIFICATE_CHAIN_BLOB {
    certCount : UInt32
    rawCertificates : CRYPT_INTEGER_BLOB.Ptr
}
struct CLAIMLIST {
    count : UInt32
    claims : PWSTR.Ptr
}
struct RECIPIENTPOLICY {
    recipient : ENDPOINTADDRESS
    issuer : ENDPOINTADDRESS
    tokenType : PWSTR
    requiredClaims : CLAIMLIST
    optionalClaims : CLAIMLIST
    privacyUrl : PWSTR
    privacyVersion : UInt32
}
struct RECIPIENTPOLICY2 {
    recipient : ENDPOINTADDRESS2
    issuer : ENDPOINTADDRESS2
    tokenType : PWSTR
    requiredClaims : CLAIMLIST
    optionalClaims : CLAIMLIST
    privacyUrl : PWSTR
    privacyVersion : UInt32
}
struct ICertSrvSetupKeyInformation extends IDispatch {
    static IID := "{6BA73778-36DA-4C39-8A85-BCFA7D000793}"
    get_ProviderName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_ProviderName(bstrVal)
      => ComCall(8, this.p, BSTR, bstrVal)
    get_Length(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    put_Length(lVal)
      => ComCall(10, this.p, Int32, lVal)
    get_Existing(pVal)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pVal)
    put_Existing(bVal)
      => ComCall(12, this.p, VARIANT_BOOL, bVal)
    get_ContainerName(pVal)
      => ComCall(13, this.p, BSTR.Ptr, pVal)
    put_ContainerName(bstrVal)
      => ComCall(14, this.p, BSTR, bstrVal)
    get_HashAlgorithm(pVal)
      => ComCall(15, this.p, BSTR.Ptr, pVal)
    put_HashAlgorithm(bstrVal)
      => ComCall(16, this.p, BSTR, bstrVal)
    get_ExistingCACertificate(pVal)
      => ComCall(17, this.p, VARIANT.Ptr, pVal)
    put_ExistingCACertificate(varVal)
      => ComCall(18, this.p, VARIANT, varVal)
}
struct ICertSrvSetupKeyInformationCollection extends IDispatch {
    static IID := "{E65C8B00-E58F-41F9-A9EC-A28D7427C844}"
    get__NewEnum(ppVal)
      => ComCall(7, this.p, IUnknown.Ptr, ppVal)
    get_Item(Index, pVal)
      => ComCall(8, this.p, Int32, Index, VARIANT.Ptr, pVal)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    Add(pIKeyInformation)
      => ComCall(10, this.p, ICertSrvSetupKeyInformation, pIKeyInformation)
}
struct CASetupProperty extends Int32 {
    static ENUM_SETUPPROP_INVALID := -1
    static ENUM_SETUPPROP_CATYPE := 0
    static ENUM_SETUPPROP_CAKEYINFORMATION := 1
    static ENUM_SETUPPROP_INTERACTIVE := 2
    static ENUM_SETUPPROP_CANAME := 3
    static ENUM_SETUPPROP_CADSSUFFIX := 4
    static ENUM_SETUPPROP_VALIDITYPERIOD := 5
    static ENUM_SETUPPROP_VALIDITYPERIODUNIT := 6
    static ENUM_SETUPPROP_EXPIRATIONDATE := 7
    static ENUM_SETUPPROP_PRESERVEDATABASE := 8
    static ENUM_SETUPPROP_DATABASEDIRECTORY := 9
    static ENUM_SETUPPROP_LOGDIRECTORY := 10
    static ENUM_SETUPPROP_SHAREDFOLDER := 11
    static ENUM_SETUPPROP_PARENTCAMACHINE := 12
    static ENUM_SETUPPROP_PARENTCANAME := 13
    static ENUM_SETUPPROP_REQUESTFILE := 14
    static ENUM_SETUPPROP_WEBCAMACHINE := 15
    static ENUM_SETUPPROP_WEBCANAME := 16
}
struct ICertSrvSetup extends IDispatch {
    static IID := "{B760A1BB-4784-44C0-8F12-555F0780FF25}"
    get_CAErrorId(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_CAErrorString(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    InitializeDefaults(bServer, bClient)
      => ComCall(9, this.p, VARIANT_BOOL, bServer, VARIANT_BOOL, bClient)
    GetCASetupProperty(propertyId, pPropertyValue)
      => ComCall(10, this.p, CASetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    SetCASetupProperty(propertyId, pPropertyValue)
      => ComCall(11, this.p, CASetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    IsPropertyEditable(propertyId, pbEditable)
      => ComCall(12, this.p, CASetupProperty, propertyId, VARIANT_BOOL.Ptr, pbEditable)
    GetSupportedCATypes(pCATypes)
      => ComCall(13, this.p, VARIANT.Ptr, pCATypes)
    GetProviderNameList(pVal)
      => ComCall(14, this.p, VARIANT.Ptr, pVal)
    GetKeyLengthList(bstrProviderName, pVal)
      => ComCall(15, this.p, BSTR, bstrProviderName, VARIANT.Ptr, pVal)
    GetHashAlgorithmList(bstrProviderName, pVal)
      => ComCall(16, this.p, BSTR, bstrProviderName, VARIANT.Ptr, pVal)
    GetPrivateKeyContainerList(bstrProviderName, pVal)
      => ComCall(17, this.p, BSTR, bstrProviderName, VARIANT.Ptr, pVal)
    GetExistingCACertificates(ppVal)
      => ComCall(18, this.p, ICertSrvSetupKeyInformationCollection.Ptr, ppVal)
    CAImportPFX(bstrFileName, bstrPasswd, bOverwriteExistingKey, ppVal)
      => ComCall(19, this.p, BSTR, bstrFileName, BSTR, bstrPasswd, VARIANT_BOOL, bOverwriteExistingKey, ICertSrvSetupKeyInformation.Ptr, ppVal)
    SetCADistinguishedName(bstrCADN, bIgnoreUnicode, bOverwriteExistingKey, bOverwriteExistingCAInDS)
      => ComCall(20, this.p, BSTR, bstrCADN, VARIANT_BOOL, bIgnoreUnicode, VARIANT_BOOL, bOverwriteExistingKey, VARIANT_BOOL, bOverwriteExistingCAInDS)
    SetDatabaseInformation(bstrDBDirectory, bstrLogDirectory, bstrSharedFolder, bForceOverwrite)
      => ComCall(21, this.p, BSTR, bstrDBDirectory, BSTR, bstrLogDirectory, BSTR, bstrSharedFolder, VARIANT_BOOL, bForceOverwrite)
    SetParentCAInformation(bstrCAConfiguration)
      => ComCall(22, this.p, BSTR, bstrCAConfiguration)
    SetWebCAInformation(bstrCAConfiguration)
      => ComCall(23, this.p, BSTR, bstrCAConfiguration)
    Install()
      => ComCall(24, this.p)
    PreUnInstall(bClientOnly)
      => ComCall(25, this.p, VARIANT_BOOL, bClientOnly)
    PostUnInstall()
      => ComCall(26, this.p)
}
struct MSCEPSetupProperty extends Int32 {
    static ENUM_CEPSETUPPROP_USELOCALSYSTEM := 0
    static ENUM_CEPSETUPPROP_USECHALLENGE := 1
    static ENUM_CEPSETUPPROP_RANAME_CN := 2
    static ENUM_CEPSETUPPROP_RANAME_EMAIL := 3
    static ENUM_CEPSETUPPROP_RANAME_COMPANY := 4
    static ENUM_CEPSETUPPROP_RANAME_DEPT := 5
    static ENUM_CEPSETUPPROP_RANAME_CITY := 6
    static ENUM_CEPSETUPPROP_RANAME_STATE := 7
    static ENUM_CEPSETUPPROP_RANAME_COUNTRY := 8
    static ENUM_CEPSETUPPROP_SIGNINGKEYINFORMATION := 9
    static ENUM_CEPSETUPPROP_EXCHANGEKEYINFORMATION := 10
    static ENUM_CEPSETUPPROP_CAINFORMATION := 11
    static ENUM_CEPSETUPPROP_MSCEPURL := 12
    static ENUM_CEPSETUPPROP_CHALLENGEURL := 13
}
struct IMSCEPSetup extends IDispatch {
    static IID := "{4F7761BB-9F3B-4592-9EE0-9A73259C313E}"
    get_MSCEPErrorId(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    get_MSCEPErrorString(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    InitializeDefaults()
      => ComCall(9, this.p)
    GetMSCEPSetupProperty(propertyId, pVal)
      => ComCall(10, this.p, MSCEPSetupProperty, propertyId, VARIANT.Ptr, pVal)
    SetMSCEPSetupProperty(propertyId, pPropertyValue)
      => ComCall(11, this.p, MSCEPSetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    SetAccountInformation(bstrUserName, bstrPassword)
      => ComCall(12, this.p, BSTR, bstrUserName, BSTR, bstrPassword)
    IsMSCEPStoreEmpty(pbEmpty)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pbEmpty)
    GetProviderNameList(bExchange, pVal)
      => ComCall(14, this.p, VARIANT_BOOL, bExchange, VARIANT.Ptr, pVal)
    GetKeyLengthList(bExchange, bstrProviderName, pVal)
      => ComCall(15, this.p, VARIANT_BOOL, bExchange, BSTR, bstrProviderName, VARIANT.Ptr, pVal)
    Install()
      => ComCall(16, this.p)
    PreUnInstall()
      => ComCall(17, this.p)
    PostUnInstall()
      => ComCall(18, this.p)
}
struct CESSetupProperty extends Int32 {
    static ENUM_CESSETUPPROP_USE_IISAPPPOOLIDENTITY := 0
    static ENUM_CESSETUPPROP_CACONFIG := 1
    static ENUM_CESSETUPPROP_AUTHENTICATION := 2
    static ENUM_CESSETUPPROP_SSLCERTHASH := 3
    static ENUM_CESSETUPPROP_URL := 4
    static ENUM_CESSETUPPROP_RENEWALONLY := 5
    static ENUM_CESSETUPPROP_ALLOW_KEYBASED_RENEWAL := 6
}
struct ICertificateEnrollmentServerSetup extends IDispatch {
    static IID := "{70027FDB-9DD9-4921-8944-B35CB31BD2EC}"
    get_ErrorString(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    InitializeInstallDefaults()
      => ComCall(8, this.p)
    GetProperty(propertyId, pPropertyValue)
      => ComCall(9, this.p, CESSetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    SetProperty(propertyId, pPropertyValue)
      => ComCall(10, this.p, CESSetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    SetApplicationPoolCredentials(bstrUsername, bstrPassword)
      => ComCall(11, this.p, BSTR, bstrUsername, BSTR, bstrPassword)
    Install()
      => ComCall(12, this.p)
    UnInstall(pCAConfig, pAuthentication)
      => ComCall(13, this.p, VARIANT.Ptr, pCAConfig, VARIANT.Ptr, pAuthentication)
}
struct CEPSetupProperty extends Int32 {
    static ENUM_CEPSETUPPROP_AUTHENTICATION := 0
    static ENUM_CEPSETUPPROP_SSLCERTHASH := 1
    static ENUM_CEPSETUPPROP_URL := 2
    static ENUM_CEPSETUPPROP_KEYBASED_RENEWAL := 3
}
struct ICertificateEnrollmentPolicyServerSetup extends IDispatch {
    static IID := "{859252CC-238C-4A88-B8FD-A37E7D04E68B}"
    get_ErrorString(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    InitializeInstallDefaults()
      => ComCall(8, this.p)
    GetProperty(propertyId, pPropertyValue)
      => ComCall(9, this.p, CEPSetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    SetProperty(propertyId, pPropertyValue)
      => ComCall(10, this.p, CEPSetupProperty, propertyId, VARIANT.Ptr, pPropertyValue)
    Install()
      => ComCall(11, this.p)
    UnInstall(pAuthKeyBasedRenewal)
      => ComCall(12, this.p, VARIANT.Ptr, pAuthKeyBasedRenewal)
}
struct BCRYPT_ECC_PARAMETER_HEADER {
    dwVersion : UInt32
    dwCurveType : ECC_CURVE_TYPE_ENUM
    dwCurveGenerationAlgId : ECC_CURVE_ALG_ID_ENUM
    cbFieldLength : UInt32
    cbSubgroupOrder : UInt32
    cbCofactor : UInt32
    cbSeed : UInt32
}
struct BCryptOpenAlgorithmProviderFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE.Ptr, PWSTR, UInt32, NTSTATUS]
}
struct BCryptGetPropertyFn extends FunctionPointer {
    static Types := [BCRYPT_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptSetPropertyFn extends FunctionPointer {
    static Types := [BCRYPT_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptCloseAlgorithmProviderFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, UInt32, NTSTATUS]
}
struct BCryptFreeBufferFn extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct BCryptGenerateSymmetricKeyFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_KEY_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptGenerateKeyPairFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptEncryptFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptDecryptFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptExportKeyFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, BCRYPT_KEY_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptImportKeyFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_KEY_HANDLE, PWSTR, BCRYPT_KEY_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptImportKeyPairFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_KEY_HANDLE, PWSTR, BCRYPT_KEY_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptDuplicateKeyFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, BCRYPT_KEY_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptFinalizeKeyPairFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, UInt32, NTSTATUS]
}
struct BCryptDestroyKeyFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, NTSTATUS]
}
struct BCryptDestroySecretFn extends FunctionPointer {
    static Types := [BCRYPT_SECRET_HANDLE, NTSTATUS]
}
struct BCryptSignHashFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptVerifySignatureFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptSecretAgreementFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, BCRYPT_KEY_HANDLE, BCRYPT_SECRET_HANDLE.Ptr, UInt32, NTSTATUS]
}
struct BCryptDeriveKeyFn extends FunctionPointer {
    static Types := [BCRYPT_SECRET_HANDLE, PWSTR, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptKeyDerivationFn extends FunctionPointer {
    static Types := [BCRYPT_KEY_HANDLE, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, NTSTATUS]
}
struct BCryptCreateHashFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_HASH_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptHashDataFn extends FunctionPointer {
    static Types := [BCRYPT_HASH_HANDLE, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptFinishHashFn extends FunctionPointer {
    static Types := [BCRYPT_HASH_HANDLE, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptCreateMultiHashFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, BCRYPT_HASH_HANDLE.Ptr, UInt32, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptProcessMultiOperationsFn extends FunctionPointer {
    static Types := [BCRYPT_HANDLE, BCRYPT_MULTI_OPERATION_TYPE, Struct.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptDuplicateHashFn extends FunctionPointer {
    static Types := [BCRYPT_HASH_HANDLE, BCRYPT_HASH_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptDestroyHashFn extends FunctionPointer {
    static Types := [BCRYPT_HASH_HANDLE, NTSTATUS]
}
struct BCryptGenRandomFn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptDeriveKeyCapiFn extends FunctionPointer {
    static Types := [BCRYPT_HASH_HANDLE, BCRYPT_ALG_HANDLE, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCryptDeriveKeyPBKDF2Fn extends FunctionPointer {
    static Types := [BCRYPT_ALG_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, Int64, UInt8.Ptr, UInt32, UInt32, NTSTATUS]
}
struct BCRYPT_CIPHER_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    GenerateKey : BCryptGenerateSymmetricKeyFn
    Encrypt : BCryptEncryptFn
    Decrypt : BCryptDecryptFn
    ImportKey : BCryptImportKeyFn
    ExportKey : BCryptExportKeyFn
    DuplicateKey : BCryptDuplicateKeyFn
    DestroyKey : BCryptDestroyKeyFn
}
struct GetCipherInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_CIPHER_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_HASH_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    CreateHash : BCryptCreateHashFn
    HashData : BCryptHashDataFn
    FinishHash : BCryptFinishHashFn
    DuplicateHash : BCryptDuplicateHashFn
    DestroyHash : BCryptDestroyHashFn
    CreateMultiHash : BCryptCreateMultiHashFn
    ProcessMultiOperations : BCryptProcessMultiOperationsFn
}
struct GetHashInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_HASH_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_ASYMMETRIC_ENCRYPTION_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    GenerateKeyPair : BCryptGenerateKeyPairFn
    FinalizeKeyPair : BCryptFinalizeKeyPairFn
    Encrypt : BCryptEncryptFn
    Decrypt : BCryptDecryptFn
    ImportKeyPair : BCryptImportKeyPairFn
    ExportKey : BCryptExportKeyFn
    DestroyKey : BCryptDestroyKeyFn
    SignHash : BCryptSignHashFn
    VerifySignature : BCryptVerifySignatureFn
}
struct GetAsymmetricEncryptionInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_ASYMMETRIC_ENCRYPTION_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_SECRET_AGREEMENT_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    SecretAgreement : BCryptSecretAgreementFn
    DeriveKey : BCryptDeriveKeyFn
    DestroySecret : BCryptDestroySecretFn
    GenerateKeyPair : BCryptGenerateKeyPairFn
    FinalizeKeyPair : BCryptFinalizeKeyPairFn
    ImportKeyPair : BCryptImportKeyPairFn
    ExportKey : BCryptExportKeyFn
    DestroyKey : BCryptDestroyKeyFn
}
struct GetSecretAgreementInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_SECRET_AGREEMENT_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_SIGNATURE_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    GenerateKeyPair : BCryptGenerateKeyPairFn
    FinalizeKeyPair : BCryptFinalizeKeyPairFn
    SignHash : BCryptSignHashFn
    VerifySignature : BCryptVerifySignatureFn
    ImportKeyPair : BCryptImportKeyPairFn
    ExportKey : BCryptExportKeyFn
    DestroyKey : BCryptDestroyKeyFn
}
struct GetSignatureInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_SIGNATURE_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_RNG_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    GenRandom : BCryptGenRandomFn
}
struct GetRngInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, BCRYPT_RNG_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct BCRYPT_KEY_DERIVATION_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenAlgorithmProvider : BCryptOpenAlgorithmProviderFn
    GetProperty : BCryptGetPropertyFn
    SetProperty : BCryptSetPropertyFn
    CloseAlgorithmProvider : BCryptCloseAlgorithmProviderFn
    GenerateKey : BCryptGenerateSymmetricKeyFn
    DestroyKey : BCryptDestroyKeyFn
    KeyDerivation : BCryptKeyDerivationFn
    ExportKey : BCryptExportKeyFn
    ImportKey : BCryptImportKeyFn
    DuplicateKey : BCryptDuplicateKeyFn
}
struct GetKeyDerivationInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BCRYPT_KEY_DERIVATION_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct NCryptOpenStorageProviderFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE.Ptr, PWSTR, UInt32, HRESULT]
}
struct NCryptEnumAlgorithmsFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, UInt32, UInt32.Ptr, NCryptAlgorithmName.Ptr.Ptr, UInt32, HRESULT]
}
struct NCryptIsAlgSupportedFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, PWSTR, UInt32, HRESULT]
}
struct NCryptEnumKeysFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, PWSTR, NCryptKeyName.Ptr.Ptr, Struct.Ptr.Ptr, UInt32, HRESULT]
}
struct NCryptEnumStorageProvidersFn extends FunctionPointer {
    static Types := [UInt32.Ptr, NCryptProviderName.Ptr.Ptr, UInt32, HRESULT]
}
struct NCryptFreeBufferFn extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct NCryptOpenKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE.Ptr, PWSTR, UInt32, UInt32, HRESULT]
}
struct NCryptCreatePersistedKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE.Ptr, PWSTR, PWSTR, UInt32, UInt32, HRESULT]
}
struct NCRYPT_UI_POLICY_BLOB {
    dwVersion : UInt32
    dwFlags : UInt32
    cbCreationTitle : UInt32
    cbFriendlyName : UInt32
    cbDescription : UInt32
}
struct NCryptGetProviderPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptGetKeyPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptSetProviderPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct NCryptSetKeyPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct NCryptFinalizeKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt32, HRESULT]
}
struct NCryptEncryptFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptDecryptFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptImportKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, BCryptBufferDesc.Ptr, NCRYPT_KEY_HANDLE.Ptr, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct NCryptExportKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptSignHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptVerifySignatureFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct NCryptDeleteKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt32, HRESULT]
}
struct NCryptFreeProviderFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, HRESULT]
}
struct NCryptFreeKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, HRESULT]
}
struct NCryptFreeSecretFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_SECRET_HANDLE, HRESULT]
}
struct NCryptPromptUserFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, UInt32, HRESULT]
}
struct NCryptNotifyChangeKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, HANDLE.Ptr, UInt32, HRESULT]
}
struct NCryptSecretAgreementFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_SECRET_HANDLE.Ptr, UInt32, HRESULT]
}
struct NCryptDeriveKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_SECRET_HANDLE, PWSTR, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptKeyDerivationFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptCreateClaimFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, UInt32, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct NCryptVerifyClaimFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, UInt32, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct NCRYPT_KEY_STORAGE_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    OpenProvider : NCryptOpenStorageProviderFn
    OpenKey : NCryptOpenKeyFn
    CreatePersistedKey : NCryptCreatePersistedKeyFn
    GetProviderProperty : NCryptGetProviderPropertyFn
    GetKeyProperty : NCryptGetKeyPropertyFn
    SetProviderProperty : NCryptSetProviderPropertyFn
    SetKeyProperty : NCryptSetKeyPropertyFn
    FinalizeKey : NCryptFinalizeKeyFn
    DeleteKey : NCryptDeleteKeyFn
    FreeProvider : NCryptFreeProviderFn
    FreeKey : NCryptFreeKeyFn
    FreeBuffer : NCryptFreeBufferFn
    Encrypt : NCryptEncryptFn
    Decrypt : NCryptDecryptFn
    IsAlgSupported : NCryptIsAlgSupportedFn
    EnumAlgorithms : NCryptEnumAlgorithmsFn
    EnumKeys : NCryptEnumKeysFn
    ImportKey : NCryptImportKeyFn
    ExportKey : NCryptExportKeyFn
    SignHash : NCryptSignHashFn
    VerifySignature : NCryptVerifySignatureFn
    PromptUser : NCryptPromptUserFn
    NotifyChangeKey : NCryptNotifyChangeKeyFn
    SecretAgreement : NCryptSecretAgreementFn
    DeriveKey : NCryptDeriveKeyFn
    FreeSecret : NCryptFreeSecretFn
    KeyDerivation : NCryptKeyDerivationFn
    CreateClaim : NCryptCreateClaimFn
    VerifyClaim : NCryptVerifyClaimFn
}
struct GetKeyStorageInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, NCRYPT_KEY_STORAGE_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct NCRYPT_SSL_CIPHER_SUITE {
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
struct NCRYPT_SSL_CIPHER_SUITE_EX {
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
    szCipherMode : UInt16[64]
}
struct NCRYPT_SSL_CIPHER_LENGTHS {
    cbLength : UInt32
    dwHeaderLen : UInt32
    dwFixedTrailerLen : UInt32
    dwMaxVariableTrailerLen : UInt32
    dwFlags : UInt32
}
struct NCRYPT_SSL_ECC_CURVE {
    szCurveName : UInt16[255]
    szOID : CHAR[255]
    dwPublicKeyLength : UInt32
    dwCurveType : UInt32
    dwFlags : UInt32
}
struct SslComputeClientAuthHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_HASH_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslComputeEapKeyBlockFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslComputeFinishedHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_HASH_HANDLE, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslCreateEphemeralKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, UInt32, UInt32, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslCreateHandshakeHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_HASH_HANDLE.Ptr, UInt32, UInt32, UInt32, HRESULT]
}
struct SslDecryptPacketFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, Int64, UInt32, HRESULT]
}
struct SslEncryptPacketFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, Int64, UInt32, UInt32, HRESULT]
}
struct SslEnumCipherSuitesFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_SSL_CIPHER_SUITE.Ptr.Ptr, Struct.Ptr.Ptr, UInt32, HRESULT]
}
struct SslEnumCipherSuitesExFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_SSL_CIPHER_SUITE_EX.Ptr.Ptr, Struct.Ptr.Ptr, UInt32, HRESULT]
}
struct SslEnumEccCurvesFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, UInt32.Ptr, NCRYPT_SSL_ECC_CURVE.Ptr.Ptr, UInt32, HRESULT]
}
struct SslExportKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslFreeBufferFn extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct SslFreeObjectFn extends FunctionPointer {
    static Types := [NCRYPT_HANDLE, UInt32, HRESULT]
}
struct SslGenerateMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslGenerateSessionKeysFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslGetKeyPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_KEY_HANDLE, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32, HRESULT]
}
struct SslGetProviderPropertyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, Struct.Ptr.Ptr, UInt32, HRESULT]
}
struct SslHashHandshakeFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_HASH_HANDLE, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslImportKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslImportMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslLookupCipherSuiteInfoFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, UInt32, UInt32, UInt32, NCRYPT_SSL_CIPHER_SUITE.Ptr, UInt32, HRESULT]
}
struct SslOpenPrivateKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE.Ptr, CERT_CONTEXT.Ptr, UInt32, HRESULT]
}
struct SslOpenProviderFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE.Ptr, PWSTR, UInt32, HRESULT]
}
struct SslSignHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslVerifySignatureFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslLookupCipherLengthsFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, UInt32, UInt32, UInt32, NCRYPT_SSL_CIPHER_LENGTHS.Ptr, UInt32, UInt32, HRESULT]
}
struct SslCreateClientAuthHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_HASH_HANDLE.Ptr, UInt32, UInt32, PWSTR, UInt32, HRESULT]
}
struct SslComputeSessionHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_HASH_HANDLE, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslGeneratePreMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, BCryptBufferDesc.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, HRESULT]
}
struct SslExportKeyingMaterialFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, PSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt16, UInt8.Ptr, UInt32, UInt32, HRESULT]
}
struct SslExtractEarlyKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, UInt32, UInt32, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExtractHandshakeKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExtractMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExpandTrafficKeysFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_HASH_HANDLE, NCRYPT_KEY_HANDLE.Ptr, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExpandWriteKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExpandExporterMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_HASH_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExpandResumptionMasterKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_HASH_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslDuplicateTranscriptHashFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_HASH_HANDLE, NCRYPT_HASH_HANDLE.Ptr, UInt32, HRESULT]
}
struct SslExpandBinderKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct SslExpandPreSharedKeyFn extends FunctionPointer {
    static Types := [NCRYPT_PROV_HANDLE, NCRYPT_KEY_HANDLE, UInt8.Ptr, UInt32, NCRYPT_KEY_HANDLE.Ptr, BCryptBufferDesc.Ptr, UInt32, HRESULT]
}
struct NCRYPT_SSL_FUNCTION_TABLE {
    Version : BCRYPT_INTERFACE_VERSION
    ComputeClientAuthHash : SslComputeClientAuthHashFn
    ComputeEapKeyBlock : SslComputeEapKeyBlockFn
    ComputeFinishedHash : SslComputeFinishedHashFn
    CreateEphemeralKey : SslCreateEphemeralKeyFn
    CreateHandshakeHash : SslCreateHandshakeHashFn
    DecryptPacket : SslDecryptPacketFn
    EncryptPacket : SslEncryptPacketFn
    EnumCipherSuites : SslEnumCipherSuitesFn
    ExportKey : SslExportKeyFn
    FreeBuffer : SslFreeBufferFn
    FreeObject : SslFreeObjectFn
    GenerateMasterKey : SslGenerateMasterKeyFn
    GenerateSessionKeys : SslGenerateSessionKeysFn
    GetKeyProperty : SslGetKeyPropertyFn
    GetProviderProperty : SslGetProviderPropertyFn
    HashHandshake : SslHashHandshakeFn
    ImportMasterKey : SslImportMasterKeyFn
    ImportKey : SslImportKeyFn
    LookupCipherSuiteInfo : SslLookupCipherSuiteInfoFn
    OpenPrivateKey : SslOpenPrivateKeyFn
    OpenProvider : SslOpenProviderFn
    SignHash : SslSignHashFn
    VerifySignature : SslVerifySignatureFn
    LookupCipherLengths : SslLookupCipherLengthsFn
    CreateClientAuthHash : SslCreateClientAuthHashFn
    GetCipherSuitePRFHashAlgorithm : SslGetCipherSuitePRFHashAlgorithmFn
    ComputeSessionHash : SslComputeSessionHashFn
    GeneratePreMasterKey : SslGeneratePreMasterKeyFn
    EnumEccCurves : SslEnumEccCurvesFn
    ExportKeyingMaterial : SslExportKeyingMaterialFn
    ExtractEarlyKey : SslExtractEarlyKeyFn
    ExtractHandshakeKey : SslExtractHandshakeKeyFn
    ExtractMasterKey : SslExtractMasterKeyFn
    ExpandTrafficKeys : SslExpandTrafficKeysFn
    ExpandWriteKey : SslExpandWriteKeyFn
    ExpandExporterMasterKey : SslExpandExporterMasterKeyFn
    EnumCipherSuitesEx : SslEnumCipherSuitesExFn
    ExpandResumptionMasterKey : SslExpandResumptionMasterKeyFn
    DuplicateTranscriptHash : SslDuplicateTranscriptHashFn
    ExpandBinderKey : SslExpandBinderKeyFn
    ExpandPreSharedKey : SslExpandPreSharedKeyFn
}
struct GetSChannelInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, NCRYPT_SSL_FUNCTION_TABLE.Ptr.Ptr, UInt32, NTSTATUS]
}
struct SslInitializeInterfaceFn extends FunctionPointer {
    static Types := [PWSTR, NCRYPT_SSL_FUNCTION_TABLE.Ptr, UInt32, HRESULT]
}
struct OFFLOAD_PRIVATE_KEY {
    dwVersion : UInt32
    cbPrime1 : UInt32
    cbPrime2 : UInt32
    pbPrime1 : UInt8.Ptr
    pbPrime2 : UInt8.Ptr
}
struct PFN_OFFLOAD_MOD_EXPO extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt8.Ptr, Struct.Ptr, UInt32, BOOL]
}
struct CRYPT_VERIFY_IMAGE_A extends FunctionPointer {
    static Types := [PSTR, UInt8.Ptr, BOOL]
}
struct CRYPT_VERIFY_IMAGE_W extends FunctionPointer {
    static Types := [PWSTR, UInt8.Ptr, BOOL]
}
struct CRYPT_RETURN_HWND extends FunctionPointer {
    static Types := [HWND.Ptr, "Void"]
}
struct VTableProvStruc {
    Version : UInt32
    FuncVerifyImage : CRYPT_VERIFY_IMAGE_A
    FuncReturnhWnd : CRYPT_RETURN_HWND
    dwProvType : UInt32
    pbContextInfo : UInt8.Ptr
    cbContextInfo : UInt32
    pszProvName : PSTR
}
struct VTableProvStrucW {
    Version : UInt32
    FuncVerifyImage : CRYPT_VERIFY_IMAGE_W
    FuncReturnhWnd : CRYPT_RETURN_HWND
    dwProvType : UInt32
    pbContextInfo : UInt8.Ptr
    cbContextInfo : UInt32
    pszProvName : PWSTR
}
struct InFileSignatureResource {
    dwVersion : UInt32
    dwCrcOffset : UInt32
    rgbSignature : UInt8[88]
}
struct CARD_CACHE_FILE_FORMAT {
    bVersion : UInt8
    bPinsFreshness : UInt8
    wContainersFreshness : UInt16
    wFilesFreshness : UInt16
}
struct CONTAINER_MAP_RECORD {
    wszGuid : UInt16[40]
    bFlags : UInt8
    bReserved : UInt8
    wSigKeySizeBits : UInt16
    wKeyExchangeKeySizeBits : UInt16
}
struct CARD_DIRECTORY_ACCESS_CONDITION extends Int32 {
    static InvalidDirAc := 0
    static UserCreateDeleteDirAc := 1
    static AdminCreateDeleteDirAc := 2
}
struct CARD_FILE_ACCESS_CONDITION extends Int32 {
    static InvalidAc := 0
    static EveryoneReadUserWriteAc := 1
    static UserWriteExecuteAc := 2
    static EveryoneReadAdminWriteAc := 3
    static UnknownAc := 4
    static UserReadWriteAc := 5
    static AdminReadWriteAc := 6
}
struct PFN_CARD_ACQUIRE_CONTEXT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt32]
}
struct PFN_CARD_DELETE_CONTEXT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32]
}
struct CARD_CAPABILITIES {
    dwVersion : UInt32
    fCertificateCompression : BOOL
    fKeyGen : BOOL
}
struct PFN_CARD_QUERY_CAPABILITIES extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, CARD_CAPABILITIES.Ptr, UInt32]
}
struct SECRET_TYPE extends Int32 {
    static AlphaNumericPinType := 0
    static ExternalPinType := 1
    static ChallengeResponsePinType := 2
    static EmptyPinType := 3
}
struct SECRET_PURPOSE extends Int32 {
    static AuthenticationPin := 0
    static DigitalSignaturePin := 1
    static EncryptionPin := 2
    static NonRepudiationPin := 3
    static AdministratorPin := 4
    static PrimaryCardPin := 5
    static UnblockOnlyPin := 6
}
struct PIN_CACHE_POLICY_TYPE extends Int32 {
    static PinCacheNormal := 0
    static PinCacheTimed := 1
    static PinCacheNone := 2
    static PinCacheAlwaysPrompt := 3
}
struct PIN_CACHE_POLICY {
    dwVersion : UInt32
    PinCachePolicyType : PIN_CACHE_POLICY_TYPE
    dwPinCachePolicyInfo : UInt32
}
struct PIN_INFO {
    dwVersion : UInt32
    PinType : SECRET_TYPE
    PinPurpose : SECRET_PURPOSE
    dwChangePermission : UInt32
    dwUnblockPermission : UInt32
    PinCachePolicy : PIN_CACHE_POLICY
    dwFlags : UInt32
}
struct PFN_CARD_GET_CHALLENGE_EX extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32, UInt32]
}
struct PFN_CARD_AUTHENTICATE_EX extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt32, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PFN_CARD_CHANGE_AUTHENTICATOR_EX extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt32, UInt8.Ptr, UInt32, UInt32, UInt8.Ptr, UInt32, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_CARD_DEAUTHENTICATE_EX extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt32, UInt32]
}
struct PFN_CARD_DELETE_CONTAINER extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, UInt32, UInt32]
}
struct PFN_CARD_CREATE_CONTAINER extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, UInt32, UInt32, UInt32, UInt8.Ptr, UInt32]
}
struct PFN_CARD_CREATE_CONTAINER_EX extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, UInt32, UInt32, UInt32, UInt8.Ptr, UInt32, UInt32]
}
struct CONTAINER_INFO {
    dwVersion : UInt32
    dwReserved : UInt32
    cbSigPublicKey : UInt32
    pbSigPublicKey : UInt8.Ptr
    cbKeyExPublicKey : UInt32
    pbKeyExPublicKey : UInt8.Ptr
}
struct PFN_CARD_GET_CONTAINER_INFO extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, UInt32, CONTAINER_INFO.Ptr, UInt32]
}
struct PFN_CARD_AUTHENTICATE_PIN extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_CARD_GET_CHALLENGE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFN_CARD_AUTHENTICATE_CHALLENGE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_CARD_UNBLOCK_PIN extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, UInt32, UInt32]
}
struct PFN_CARD_CHANGE_AUTHENTICATOR extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_CARD_DEAUTHENTICATE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt32, UInt32]
}
struct PFN_CARD_CREATE_DIRECTORY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, CARD_DIRECTORY_ACCESS_CONDITION, UInt32]
}
struct PFN_CARD_DELETE_DIRECTORY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, UInt32]
}
struct PFN_CARD_CREATE_FILE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR, UInt32, CARD_FILE_ACCESS_CONDITION, UInt32]
}
struct PFN_CARD_READ_FILE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFN_CARD_WRITE_FILE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR, UInt32, UInt8.Ptr, UInt32, UInt32]
}
struct PFN_CARD_DELETE_FILE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR, UInt32, UInt32]
}
struct PFN_CARD_ENUM_FILES extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR.Ptr, UInt32.Ptr, UInt32, UInt32]
}
struct CARD_FILE_INFO {
    dwVersion : UInt32
    cbFileSize : UInt32
    AccessCondition : CARD_FILE_ACCESS_CONDITION
}
struct PFN_CARD_GET_FILE_INFO extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PSTR, PSTR, CARD_FILE_INFO.Ptr, UInt32]
}
struct CARD_FREE_SPACE_INFO {
    dwVersion : UInt32
    dwBytesAvailable : UInt32
    dwKeyContainersAvailable : UInt32
    dwMaxKeyContainers : UInt32
}
struct PFN_CARD_QUERY_FREE_SPACE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, CARD_FREE_SPACE_INFO.Ptr, UInt32]
}
struct CARD_KEY_SIZES {
    dwVersion : UInt32
    dwMinimumBitlen : UInt32
    dwDefaultBitlen : UInt32
    dwMaximumBitlen : UInt32
    dwIncrementalBitlen : UInt32
}
struct PFN_CARD_QUERY_KEY_SIZES extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt32, UInt32, CARD_KEY_SIZES.Ptr, UInt32]
}
struct CARD_RSA_DECRYPT_INFO {
    dwVersion : UInt32
    bContainerIndex : UInt8
    dwKeySpec : UInt32
    pbData : UInt8.Ptr
    cbData : UInt32
    pPaddingInfo : Struct.Ptr
    dwPaddingType : UInt32
}
struct PFN_CARD_RSA_DECRYPT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, CARD_RSA_DECRYPT_INFO.Ptr, UInt32]
}
struct CARD_SIGNING_INFO {
    dwVersion : UInt32
    bContainerIndex : UInt8
    dwKeySpec : UInt32
    dwSigningFlags : UInt32
    aiHashAlg : ALG_ID
    pbData : UInt8.Ptr
    cbData : UInt32
    pbSignedData : UInt8.Ptr
    cbSignedData : UInt32
    pPaddingInfo : Struct.Ptr
    dwPaddingType : UInt32
}
struct PFN_CARD_SIGN_DATA extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, CARD_SIGNING_INFO.Ptr, UInt32]
}
struct CARD_DH_AGREEMENT_INFO {
    dwVersion : UInt32
    bContainerIndex : UInt8
    dwFlags : UInt32
    dwPublicKey : UInt32
    pbPublicKey : UInt8.Ptr
    pbReserved : UInt8.Ptr
    cbReserved : UInt32
    bSecretAgreementIndex : UInt8
}
struct PFN_CARD_CONSTRUCT_DH_AGREEMENT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, CARD_DH_AGREEMENT_INFO.Ptr, UInt32]
}
struct CARD_DERIVE_KEY {
    dwVersion : UInt32
    dwFlags : UInt32
    pwszKDF : PWSTR
    bSecretAgreementIndex : UInt8
    pParameterList : Struct.Ptr
    pbDerivedKey : UInt8.Ptr
    cbDerivedKey : UInt32
    pwszAlgId : PWSTR
    dwKeyLen : UInt32
    hKey : IntPtr
}
struct PFN_CARD_DERIVE_KEY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, CARD_DERIVE_KEY.Ptr, UInt32]
}
struct PFN_CARD_DESTROY_DH_AGREEMENT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, UInt32, UInt32]
}
struct PFN_CSP_GET_DH_AGREEMENT extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, Struct.Ptr, UInt8.Ptr, UInt32, UInt32]
}
struct PFN_CSP_ALLOC extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr]
}
struct PFN_CSP_REALLOC extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Struct.Ptr]
}
struct PFN_CSP_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PFN_CSP_CACHE_ADD_FILE extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, UInt8.Ptr, UInt32, UInt32]
}
struct PFN_CSP_CACHE_LOOKUP_FILE extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFN_CSP_CACHE_DELETE_FILE extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, UInt32]
}
struct PFN_CSP_PAD_DATA extends FunctionPointer {
    static Types := [CARD_SIGNING_INFO.Ptr, UInt32, UInt32.Ptr, UInt8.Ptr.Ptr, UInt32]
}
struct PFN_CSP_UNPAD_DATA extends FunctionPointer {
    static Types := [CARD_RSA_DECRYPT_INFO.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, UInt32]
}
struct PFN_CARD_GET_CONTAINER_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, UInt32]
}
struct PFN_CARD_SET_CONTAINER_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, PWSTR, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct PFN_CARD_GET_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, UInt32]
}
struct PFN_CARD_SET_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct CARD_ENCRYPTED_DATA {
    pbEncryptedData : UInt8.Ptr
    cbEncryptedData : UInt32
}
struct CARD_IMPORT_KEYPAIR {
    dwVersion : UInt32
    bContainerIndex : UInt8
    PinId : UInt32
    dwKeySpec : UInt32
    dwKeySize : UInt32
    cbInput : UInt32
    pbInput : UInt8[1]
}
struct CARD_CHANGE_AUTHENTICATOR {
    dwVersion : UInt32
    dwFlags : UInt32
    dwAuthenticatingPinId : UInt32
    cbAuthenticatingPinData : UInt32
    dwTargetPinId : UInt32
    cbTargetData : UInt32
    cRetryCount : UInt32
    pbData : UInt8[1]
}
struct CARD_CHANGE_AUTHENTICATOR_RESPONSE {
    dwVersion : UInt32
    cAttemptsRemaining : UInt32
}
struct CARD_AUTHENTICATE {
    dwVersion : UInt32
    dwFlags : UInt32
    PinId : UInt32
    cbPinData : UInt32
    pbPinData : UInt8[1]
}
struct CARD_AUTHENTICATE_RESPONSE {
    dwVersion : UInt32
    cbSessionPin : UInt32
    cAttemptsRemaining : UInt32
    pbSessionPin : UInt8[1]
}
struct PFN_MD_IMPORT_SESSION_KEY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, PWSTR, IntPtr.Ptr, UInt8.Ptr, UInt32, UInt32]
}
struct PFN_MD_ENCRYPT_DATA extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, IntPtr, PWSTR, UInt8.Ptr, UInt32, UInt32, CARD_ENCRYPTED_DATA.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFN_CARD_GET_SHARED_KEY_HANDLE extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, IntPtr.Ptr, UInt32]
}
struct PFN_CARD_DESTROY_KEY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, IntPtr, UInt32]
}
struct PFN_CARD_GET_ALGORITHM_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, PWSTR, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, UInt32]
}
struct PFN_CARD_GET_KEY_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, IntPtr, PWSTR, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, UInt32]
}
struct PFN_CARD_SET_KEY_PROPERTY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, IntPtr, PWSTR, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct PFN_CARD_IMPORT_SESSION_KEY extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, UInt8, Struct.Ptr, PWSTR, PWSTR, IntPtr.Ptr, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct PFN_CARD_PROCESS_ENCRYPTED_DATA extends FunctionPointer {
    static Types := [CARD_DATA.Ptr, IntPtr, PWSTR, CARD_ENCRYPTED_DATA.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32.Ptr, UInt32, UInt32]
}
struct CARD_DATA {
    dwVersion : UInt32
    pbAtr : UInt8.Ptr
    cbAtr : UInt32
    pwszCardName : PWSTR
    pfnCspAlloc : PFN_CSP_ALLOC
    pfnCspReAlloc : PFN_CSP_REALLOC
    pfnCspFree : PFN_CSP_FREE
    pfnCspCacheAddFile : PFN_CSP_CACHE_ADD_FILE
    pfnCspCacheLookupFile : PFN_CSP_CACHE_LOOKUP_FILE
    pfnCspCacheDeleteFile : PFN_CSP_CACHE_DELETE_FILE
    pvCacheContext : Struct.Ptr
    pfnCspPadData : PFN_CSP_PAD_DATA
    hSCardCtx : IntPtr
    hScard : IntPtr
    pvVendorSpecific : Struct.Ptr
    pfnCardDeleteContext : PFN_CARD_DELETE_CONTEXT
    pfnCardQueryCapabilities : PFN_CARD_QUERY_CAPABILITIES
    pfnCardDeleteContainer : PFN_CARD_DELETE_CONTAINER
    pfnCardCreateContainer : PFN_CARD_CREATE_CONTAINER
    pfnCardGetContainerInfo : PFN_CARD_GET_CONTAINER_INFO
    pfnCardAuthenticatePin : PFN_CARD_AUTHENTICATE_PIN
    pfnCardGetChallenge : PFN_CARD_GET_CHALLENGE
    pfnCardAuthenticateChallenge : PFN_CARD_AUTHENTICATE_CHALLENGE
    pfnCardUnblockPin : PFN_CARD_UNBLOCK_PIN
    pfnCardChangeAuthenticator : PFN_CARD_CHANGE_AUTHENTICATOR
    pfnCardDeauthenticate : PFN_CARD_DEAUTHENTICATE
    pfnCardCreateDirectory : PFN_CARD_CREATE_DIRECTORY
    pfnCardDeleteDirectory : PFN_CARD_DELETE_DIRECTORY
    pvUnused3 : Struct.Ptr
    pvUnused4 : Struct.Ptr
    pfnCardCreateFile : PFN_CARD_CREATE_FILE
    pfnCardReadFile : PFN_CARD_READ_FILE
    pfnCardWriteFile : PFN_CARD_WRITE_FILE
    pfnCardDeleteFile : PFN_CARD_DELETE_FILE
    pfnCardEnumFiles : PFN_CARD_ENUM_FILES
    pfnCardGetFileInfo : PFN_CARD_GET_FILE_INFO
    pfnCardQueryFreeSpace : PFN_CARD_QUERY_FREE_SPACE
    pfnCardQueryKeySizes : PFN_CARD_QUERY_KEY_SIZES
    pfnCardSignData : PFN_CARD_SIGN_DATA
    pfnCardRSADecrypt : PFN_CARD_RSA_DECRYPT
    pfnCardConstructDHAgreement : PFN_CARD_CONSTRUCT_DH_AGREEMENT
    pfnCardDeriveKey : PFN_CARD_DERIVE_KEY
    pfnCardDestroyDHAgreement : PFN_CARD_DESTROY_DH_AGREEMENT
    pfnCspGetDHAgreement : PFN_CSP_GET_DH_AGREEMENT
    pfnCardGetChallengeEx : PFN_CARD_GET_CHALLENGE_EX
    pfnCardAuthenticateEx : PFN_CARD_AUTHENTICATE_EX
    pfnCardChangeAuthenticatorEx : PFN_CARD_CHANGE_AUTHENTICATOR_EX
    pfnCardDeauthenticateEx : PFN_CARD_DEAUTHENTICATE_EX
    pfnCardGetContainerProperty : PFN_CARD_GET_CONTAINER_PROPERTY
    pfnCardSetContainerProperty : PFN_CARD_SET_CONTAINER_PROPERTY
    pfnCardGetProperty : PFN_CARD_GET_PROPERTY
    pfnCardSetProperty : PFN_CARD_SET_PROPERTY
    pfnCspUnpadData : PFN_CSP_UNPAD_DATA
    pfnMDImportSessionKey : PFN_MD_IMPORT_SESSION_KEY
    pfnMDEncryptData : PFN_MD_ENCRYPT_DATA
    pfnCardImportSessionKey : PFN_CARD_IMPORT_SESSION_KEY
    pfnCardGetSharedKeyHandle : PFN_CARD_GET_SHARED_KEY_HANDLE
    pfnCardGetAlgorithmProperty : PFN_CARD_GET_ALGORITHM_PROPERTY
    pfnCardGetKeyProperty : PFN_CARD_GET_KEY_PROPERTY
    pfnCardSetKeyProperty : PFN_CARD_SET_KEY_PROPERTY
    pfnCardDestroyKey : PFN_CARD_DESTROY_KEY
    pfnCardProcessEncryptedData : PFN_CARD_PROCESS_ENCRYPTED_DATA
    pfnCardCreateContainerEx : PFN_CARD_CREATE_CONTAINER_EX
}
struct CLMD_PIV_CERT_DATA {
    dwVersion : UInt32
    dwCertTag : UInt32
    pbCert : UInt8.Ptr
    cbCert : UInt32
}
struct CLMD_PIV_GENERATE_ASYMMETRIC_KEY {
    dwVersion : UInt32
    bAlgorithmId : UInt8
    bKeyId : UInt8
    pbKey : UInt8.Ptr
    cbKey : UInt32
}
struct CLMD_PIV_PUBLIC_KEY_DATA {
    dwVersion : UInt32
    bKeyId : UInt8
    pbPublicKey : UInt8.Ptr
    cbPublicKey : UInt32
}
