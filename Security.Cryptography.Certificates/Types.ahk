#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, PWSTR, VARIANT_BOOL}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT, CERT_EXTENSIONS, CERT_RDN_ATTR_VALUE_TYPE, CRYPT_ATTRIBUTES, CRYPT_INTEGER_BLOB, HCERTSTORE}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct CERT_VIEW_COLUMN_INDEX extends Int32 {
    static CV_COLUMN_LOG_DEFAULT := -2
    static CV_COLUMN_LOG_FAILED_DEFAULT := -3
    static CV_COLUMN_QUEUE_DEFAULT := -1
}
struct CERT_DELETE_ROW_FLAGS extends Int32 {
    static CDR_EXPIRED := 1
    static CDR_REQUEST_LAST_CHANGED := 2
}
struct FULL_RESPONSE_PROPERTY_ID extends Int32 {
    static FR_PROP_NONE := 0
    static FR_PROP_FULLRESPONSE := 1
    static FR_PROP_STATUSINFOCOUNT := 2
    static FR_PROP_BODYPARTSTRING := 3
    static FR_PROP_STATUS := 4
    static FR_PROP_STATUSSTRING := 5
    static FR_PROP_OTHERINFOCHOICE := 6
    static FR_PROP_FAILINFO := 7
    static FR_PROP_PENDINFOTOKEN := 8
    static FR_PROP_PENDINFOTIME := 9
    static FR_PROP_ISSUEDCERTIFICATEHASH := 10
    static FR_PROP_ISSUEDCERTIFICATE := 11
    static FR_PROP_ISSUEDCERTIFICATECHAIN := 12
    static FR_PROP_ISSUEDCERTIFICATECRLCHAIN := 13
    static FR_PROP_ENCRYPTEDKEYHASH := 14
    static FR_PROP_FULLRESPONSENOPKCS7 := 15
    static FR_PROP_CAEXCHANGECERTIFICATEHASH := 16
    static FR_PROP_CAEXCHANGECERTIFICATE := 17
    static FR_PROP_CAEXCHANGECERTIFICATECHAIN := 18
    static FR_PROP_CAEXCHANGECERTIFICATECRLCHAIN := 19
    static FR_PROP_ATTESTATIONCHALLENGE := 20
    static FR_PROP_ATTESTATIONPROVIDERNAME := 21
}
struct CVRC_COLUMN extends Int32 {
    static CVRC_COLUMN_SCHEMA := 0
    static CVRC_COLUMN_RESULT := 1
    static CVRC_COLUMN_VALUE := 2
    static CVRC_COLUMN_MASK := 4095
}
struct CERT_IMPORT_FLAGS extends Int32 {
    static CR_IN_BASE64HEADER := 0
    static CR_IN_BASE64 := 1
    static CR_IN_BINARY := 2
}
struct CERT_GET_CONFIG_FLAGS extends Int32 {
    static CC_DEFAULTCONFIG := 0
    static CC_FIRSTCONFIG := 2
    static CC_LOCALACTIVECONFIG := 4
    static CC_LOCALCONFIG := 3
    static CC_UIPICKCONFIG := 1
    static CC_UIPICKCONFIGSKIPLOCALCA := 5
}
struct ENUM_CERT_COLUMN_VALUE_FLAGS extends Int32 {
    static CV_OUT_BASE64 := 1
    static CV_OUT_BASE64HEADER := 0
    static CV_OUT_BASE64REQUESTHEADER := 3
    static CV_OUT_BASE64X509CRLHEADER := 9
    static CV_OUT_BINARY := 2
    static CV_OUT_HEX := 4
    static CV_OUT_HEXADDR := 10
    static CV_OUT_HEXASCII := 5
    static CV_OUT_HEXASCIIADDR := 11
}
struct PENDING_REQUEST_DESIRED_PROPERTY extends Int32 {
    static XEPR_CADNS := 1
    static XEPR_CAFRIENDLYNAME := 3
    static XEPR_CANAME := 2
    static XEPR_HASH := 8
    static XEPR_REQUESTID := 4
}
struct CERTADMIN_GET_ROLES_FLAGS extends UInt32 {
    static CA_ACCESS_ADMIN := 1
    static CA_ACCESS_AUDITOR := 4
    static CA_ACCESS_ENROLL := 512
    static CA_ACCESS_OFFICER := 2
    static CA_ACCESS_OPERATOR := 8
    static CA_ACCESS_READ := 256
}
struct CR_DISP extends UInt32 {
    static CR_DISP_DENIED := 2
    static CR_DISP_ERROR := 1
    static CR_DISP_INCOMPLETE := 0
    static CR_DISP_ISSUED := 3
    static CR_DISP_ISSUED_OUT_OF_BAND := 4
    static CR_DISP_UNDER_SUBMISSION := 5
}
struct XEKL_KEYSIZE extends Int32 {
    static XEKL_KEYSIZE_MIN := 1
    static XEKL_KEYSIZE_MAX := 2
    static XEKL_KEYSIZE_INC := 3
}
struct CERT_CREATE_REQUEST_FLAGS extends Int32 {
    static XECR_CMC := 3
    static XECR_PKCS10_V1_5 := 4
    static XECR_PKCS10_V2_0 := 1
    static XECR_PKCS7 := 2
}
struct CERT_EXIT_EVENT_MASK extends UInt32 {
    static EXITEVENT_CERTDENIED := 4
    static EXITEVENT_CERTISSUED := 1
    static EXITEVENT_CERTPENDING := 2
    static EXITEVENT_CERTRETRIEVEPENDING := 16
    static EXITEVENT_CERTREVOKED := 8
    static EXITEVENT_CRLISSUED := 32
    static EXITEVENT_SHUTDOWN := 64
}
struct ADDED_CERT_TYPE extends Int32 {
    static XECT_EXTENSION_V1 := 1
    static XECT_EXTENSION_V2 := 2
}
struct CVRC_TABLE extends Int32 {
    static CVRC_TABLE_ATTRIBUTES := 16384
    static CVRC_TABLE_CRL := 20480
    static CVRC_TABLE_EXTENSIONS := 12288
    static CVRC_TABLE_REQCERT := 0
}
struct CERT_PROPERTY_TYPE extends Int32 {
    static PROPTYPE_BINARY := 3
    static PROPTYPE_DATE := 2
    static PROPTYPE_LONG := 1
    static PROPTYPE_STRING := 4
}
struct CERT_ALT_NAME extends Int32 {
    static CERT_ALT_NAME_RFC822_NAME := 2
    static CERT_ALT_NAME_DNS_NAME := 3
    static CERT_ALT_NAME_URL := 7
    static CERT_ALT_NAME_REGISTERED_ID := 9
    static CERT_ALT_NAME_DIRECTORY_NAME := 5
    static CERT_ALT_NAME_IP_ADDRESS := 8
    static CERT_ALT_NAME_OTHER_NAME := 1
}
struct CSBACKUP_TYPE extends UInt32 {
    static CSBACKUP_TYPE_FULL := 1
    static CSBACKUP_TYPE_LOGS_ONLY := 2
}
struct XEKL_KEYSPEC extends Int32 {
    static XEKL_KEYSPEC_KEYX := 1
    static XEKL_KEYSPEC_SIG := 2
}
struct CERT_REQUEST_OUT_TYPE extends Int32 {
    static CR_OUT_BASE64HEADER := 0
    static CR_OUT_BASE64 := 1
    static CR_OUT_BINARY := 2
}
struct CERT_VIEW_SEEK_OPERATOR_FLAGS extends Int32 {
    static CVR_SEEK_EQ := 1
    static CVR_SEEK_LE := 4
    static CVR_SEEK_LT := 2
    static CVR_SEEK_GE := 8
    static CVR_SEEK_GT := 16
}
struct IEnumCERTVIEWCOLUMN extends IDispatch {
    static IID := "{9C735BE2-57A5-11D1-9BDB-00C04FB683FA}"
    Next(pIndex)
      => ComCall(7, this.p, Int32.Ptr, pIndex)
    GetName(pstrOut)
      => ComCall(8, this.p, BSTR.Ptr, pstrOut)
    GetDisplayName(pstrOut)
      => ComCall(9, this.p, BSTR.Ptr, pstrOut)
    GetType(pType)
      => ComCall(10, this.p, Int32.Ptr, pType)
    IsIndexed(pIndexed)
      => ComCall(11, this.p, Int32.Ptr, pIndexed)
    GetMaxLength(pMaxLength)
      => ComCall(12, this.p, Int32.Ptr, pMaxLength)
    GetValue(Flags, pvarValue)
      => ComCall(13, this.p, ENUM_CERT_COLUMN_VALUE_FLAGS, Flags, VARIANT.Ptr, pvarValue)
    Skip(celt)
      => ComCall(14, this.p, Int32, celt)
    Reset()
      => ComCall(15, this.p)
    Clone(ppenum)
      => ComCall(16, this.p, IEnumCERTVIEWCOLUMN.Ptr, ppenum)
}
struct IEnumCERTVIEWATTRIBUTE extends IDispatch {
    static IID := "{E77DB656-7653-11D1-9BDE-00C04FB683FA}"
    Next(pIndex)
      => ComCall(7, this.p, Int32.Ptr, pIndex)
    GetName(pstrOut)
      => ComCall(8, this.p, BSTR.Ptr, pstrOut)
    GetValue(pstrOut)
      => ComCall(9, this.p, BSTR.Ptr, pstrOut)
    Skip(celt)
      => ComCall(10, this.p, Int32, celt)
    Reset()
      => ComCall(11, this.p)
    Clone(ppenum)
      => ComCall(12, this.p, IEnumCERTVIEWATTRIBUTE.Ptr, ppenum)
}
struct IEnumCERTVIEWEXTENSION extends IDispatch {
    static IID := "{E7DD1466-7653-11D1-9BDE-00C04FB683FA}"
    Next(pIndex)
      => ComCall(7, this.p, Int32.Ptr, pIndex)
    GetName(pstrOut)
      => ComCall(8, this.p, BSTR.Ptr, pstrOut)
    GetFlags(pFlags)
      => ComCall(9, this.p, Int32.Ptr, pFlags)
    GetValue(Type, Flags, pvarValue)
      => ComCall(10, this.p, CERT_PROPERTY_TYPE, Type, ENUM_CERT_COLUMN_VALUE_FLAGS, Flags, VARIANT.Ptr, pvarValue)
    Skip(celt)
      => ComCall(11, this.p, Int32, celt)
    Reset()
      => ComCall(12, this.p)
    Clone(ppenum)
      => ComCall(13, this.p, IEnumCERTVIEWEXTENSION.Ptr, ppenum)
}
struct IEnumCERTVIEWROW extends IDispatch {
    static IID := "{D1157F4C-5AF2-11D1-9BDC-00C04FB683FA}"
    Next(pIndex)
      => ComCall(7, this.p, Int32.Ptr, pIndex)
    EnumCertViewColumn(ppenum)
      => ComCall(8, this.p, IEnumCERTVIEWCOLUMN.Ptr, ppenum)
    EnumCertViewAttribute(Flags, ppenum)
      => ComCall(9, this.p, Int32, Flags, IEnumCERTVIEWATTRIBUTE.Ptr, ppenum)
    EnumCertViewExtension(Flags, ppenum)
      => ComCall(10, this.p, Int32, Flags, IEnumCERTVIEWEXTENSION.Ptr, ppenum)
    Skip(celt)
      => ComCall(11, this.p, Int32, celt)
    Reset()
      => ComCall(12, this.p)
    Clone(ppenum)
      => ComCall(13, this.p, IEnumCERTVIEWROW.Ptr, ppenum)
    GetMaxIndex(pIndex)
      => ComCall(14, this.p, Int32.Ptr, pIndex)
}
struct ICertView extends IDispatch {
    static IID := "{C3FAC344-1E84-11D1-9BD6-00C04FB683FA}"
    OpenConnection(strConfig)
      => ComCall(7, this.p, BSTR, strConfig)
    EnumCertViewColumn(fResultColumn, ppenum)
      => ComCall(8, this.p, CVRC_COLUMN, fResultColumn, IEnumCERTVIEWCOLUMN.Ptr, ppenum)
    GetColumnCount(fResultColumn, pcColumn)
      => ComCall(9, this.p, CVRC_COLUMN, fResultColumn, Int32.Ptr, pcColumn)
    GetColumnIndex(fResultColumn, strColumnName, pColumnIndex)
      => ComCall(10, this.p, CVRC_COLUMN, fResultColumn, BSTR, strColumnName, Int32.Ptr, pColumnIndex)
    SetResultColumnCount(cResultColumn)
      => ComCall(11, this.p, Int32, cResultColumn)
    SetResultColumn(ColumnIndex)
      => ComCall(12, this.p, Int32, ColumnIndex)
    SetRestriction(ColumnIndex, SeekOperator, SortOrder, pvarValue)
      => ComCall(13, this.p, CERT_VIEW_COLUMN_INDEX, ColumnIndex, CERT_VIEW_SEEK_OPERATOR_FLAGS, SeekOperator, Int32, SortOrder, VARIANT.Ptr, pvarValue)
    OpenView(ppenum)
      => ComCall(14, this.p, IEnumCERTVIEWROW.Ptr, ppenum)
}
struct ICertView2 extends ICertView {
    static IID := "{D594B282-8851-4B61-9C66-3EDADF848863}"
    SetTable(Table)
      => ComCall(15, this.p, CVRC_TABLE, Table)
}
struct ICertAdmin extends IDispatch {
    static IID := "{34DF6950-7FB6-11D0-8817-00A0C903B83C}"
    IsValidCertificate(strConfig, strSerialNumber, pDisposition)
      => ComCall(7, this.p, BSTR, strConfig, BSTR, strSerialNumber, Int32.Ptr, pDisposition)
    GetRevocationReason(pReason)
      => ComCall(8, this.p, Int32.Ptr, pReason)
    RevokeCertificate(strConfig, strSerialNumber, Reason, Date)
      => ComCall(9, this.p, BSTR, strConfig, BSTR, strSerialNumber, Int32, Reason, Float64, Date)
    SetRequestAttributes(strConfig, RequestId, strAttributes)
      => ComCall(10, this.p, BSTR, strConfig, Int32, RequestId, BSTR, strAttributes)
    SetCertificateExtension(strConfig, RequestId, strExtensionName, Type, Flags, pvarValue)
      => ComCall(11, this.p, BSTR, strConfig, Int32, RequestId, BSTR, strExtensionName, CERT_PROPERTY_TYPE, Type, Int32, Flags, VARIANT.Ptr, pvarValue)
    DenyRequest(strConfig, RequestId)
      => ComCall(12, this.p, BSTR, strConfig, Int32, RequestId)
    ResubmitRequest(strConfig, RequestId, pDisposition)
      => ComCall(13, this.p, BSTR, strConfig, Int32, RequestId, Int32.Ptr, pDisposition)
    PublishCRL(strConfig, Date)
      => ComCall(14, this.p, BSTR, strConfig, Float64, Date)
    GetCRL(strConfig, Flags, pstrCRL)
      => ComCall(15, this.p, BSTR, strConfig, Int32, Flags, BSTR.Ptr, pstrCRL)
    ImportCertificate(strConfig, strCertificate, Flags, pRequestId)
      => ComCall(16, this.p, BSTR, strConfig, BSTR, strCertificate, CERT_IMPORT_FLAGS, Flags, Int32.Ptr, pRequestId)
}
struct ICertAdmin2 extends ICertAdmin {
    static IID := "{F7C3AC41-B8CE-4FB4-AA58-3D1DC0E36B39}"
    PublishCRLs(strConfig, Date, CRLFlags)
      => ComCall(17, this.p, BSTR, strConfig, Float64, Date, Int32, CRLFlags)
    GetCAProperty(strConfig, PropId, PropIndex, PropType, Flags, pvarPropertyValue)
      => ComCall(18, this.p, BSTR, strConfig, Int32, PropId, Int32, PropIndex, Int32, PropType, Int32, Flags, VARIANT.Ptr, pvarPropertyValue)
    SetCAProperty(strConfig, PropId, PropIndex, PropType, pvarPropertyValue)
      => ComCall(19, this.p, BSTR, strConfig, Int32, PropId, Int32, PropIndex, CERT_PROPERTY_TYPE, PropType, VARIANT.Ptr, pvarPropertyValue)
    GetCAPropertyFlags(strConfig, PropId, pPropFlags)
      => ComCall(20, this.p, BSTR, strConfig, Int32, PropId, Int32.Ptr, pPropFlags)
    GetCAPropertyDisplayName(strConfig, PropId, pstrDisplayName)
      => ComCall(21, this.p, BSTR, strConfig, Int32, PropId, BSTR.Ptr, pstrDisplayName)
    GetArchivedKey(strConfig, RequestId, Flags, pstrArchivedKey)
      => ComCall(22, this.p, BSTR, strConfig, Int32, RequestId, Int32, Flags, BSTR.Ptr, pstrArchivedKey)
    GetConfigEntry(strConfig, strNodePath, strEntryName, pvarEntry)
      => ComCall(23, this.p, BSTR, strConfig, BSTR, strNodePath, BSTR, strEntryName, VARIANT.Ptr, pvarEntry)
    SetConfigEntry(strConfig, strNodePath, strEntryName, pvarEntry)
      => ComCall(24, this.p, BSTR, strConfig, BSTR, strNodePath, BSTR, strEntryName, VARIANT.Ptr, pvarEntry)
    ImportKey(strConfig, RequestId, strCertHash, Flags, strKey)
      => ComCall(25, this.p, BSTR, strConfig, Int32, RequestId, BSTR, strCertHash, CERT_IMPORT_FLAGS, Flags, BSTR, strKey)
    GetMyRoles(strConfig, pRoles)
      => ComCall(26, this.p, BSTR, strConfig, CERTADMIN_GET_ROLES_FLAGS.Ptr, pRoles)
    DeleteRow(strConfig, Flags, Date, Table, RowId, pcDeleted)
      => ComCall(27, this.p, BSTR, strConfig, CERT_DELETE_ROW_FLAGS, Flags, Float64, Date, CVRC_TABLE, Table, Int32, RowId, Int32.Ptr, pcDeleted)
}
struct IOCSPProperty extends IDispatch {
    static IID := "{66FB7839-5F04-4C25-AD18-9FF1A8376EE0}"
    get_Name(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_Value(pVal)
      => ComCall(8, this.p, VARIANT.Ptr, pVal)
    put_Value(newVal)
      => ComCall(9, this.p, VARIANT, newVal)
    get_Modified(pVal)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pVal)
}
struct IOCSPPropertyCollection extends IDispatch {
    static IID := "{2597C18D-54E6-4B74-9FA9-A6BFDA99CBBE}"
    get__NewEnum(ppVal)
      => ComCall(7, this.p, IUnknown.Ptr, ppVal)
    get_Item(Index, pVal)
      => ComCall(8, this.p, Int32, Index, VARIANT.Ptr, pVal)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    get_ItemByName(bstrPropName, pVal)
      => ComCall(10, this.p, BSTR, bstrPropName, VARIANT.Ptr, pVal)
    CreateProperty(bstrPropName, pVarPropValue, ppVal)
      => ComCall(11, this.p, BSTR, bstrPropName, VARIANT.Ptr, pVarPropValue, IOCSPProperty.Ptr, ppVal)
    DeleteProperty(bstrPropName)
      => ComCall(12, this.p, BSTR, bstrPropName)
    InitializeFromProperties(pVarProperties)
      => ComCall(13, this.p, VARIANT.Ptr, pVarProperties)
    GetAllProperties(pVarProperties)
      => ComCall(14, this.p, VARIANT.Ptr, pVarProperties)
}
struct IOCSPCAConfiguration extends IDispatch {
    static IID := "{AEC92B40-3D46-433F-87D1-B84D5C1E790D}"
    get_Identifier(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_CACertificate(pVal)
      => ComCall(8, this.p, VARIANT.Ptr, pVal)
    get_HashAlgorithm(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_HashAlgorithm(newVal)
      => ComCall(10, this.p, BSTR, newVal)
    get_SigningFlags(pVal)
      => ComCall(11, this.p, UInt32.Ptr, pVal)
    put_SigningFlags(newVal)
      => ComCall(12, this.p, UInt32, newVal)
    get_SigningCertificate(pVal)
      => ComCall(13, this.p, VARIANT.Ptr, pVal)
    put_SigningCertificate(newVal)
      => ComCall(14, this.p, VARIANT, newVal)
    get_ReminderDuration(pVal)
      => ComCall(15, this.p, UInt32.Ptr, pVal)
    put_ReminderDuration(newVal)
      => ComCall(16, this.p, UInt32, newVal)
    get_ErrorCode(pVal)
      => ComCall(17, this.p, UInt32.Ptr, pVal)
    get_CSPName(pVal)
      => ComCall(18, this.p, BSTR.Ptr, pVal)
    get_KeySpec(pVal)
      => ComCall(19, this.p, UInt32.Ptr, pVal)
    get_ProviderCLSID(pVal)
      => ComCall(20, this.p, BSTR.Ptr, pVal)
    put_ProviderCLSID(newVal)
      => ComCall(21, this.p, BSTR, newVal)
    get_ProviderProperties(pVal)
      => ComCall(22, this.p, VARIANT.Ptr, pVal)
    put_ProviderProperties(newVal)
      => ComCall(23, this.p, VARIANT, newVal)
    get_Modified(pVal)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, pVal)
    get_LocalRevocationInformation(pVal)
      => ComCall(25, this.p, VARIANT.Ptr, pVal)
    put_LocalRevocationInformation(newVal)
      => ComCall(26, this.p, VARIANT, newVal)
    get_SigningCertificateTemplate(pVal)
      => ComCall(27, this.p, BSTR.Ptr, pVal)
    put_SigningCertificateTemplate(newVal)
      => ComCall(28, this.p, BSTR, newVal)
    get_CAConfig(pVal)
      => ComCall(29, this.p, BSTR.Ptr, pVal)
    put_CAConfig(newVal)
      => ComCall(30, this.p, BSTR, newVal)
}
struct IOCSPCAConfigurationCollection extends IDispatch {
    static IID := "{2BEBEA0B-5ECE-4F28-A91C-86B4BB20F0D3}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Item(Index, pVal)
      => ComCall(8, this.p, Int32, Index, VARIANT.Ptr, pVal)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    get_ItemByName(bstrIdentifier, pVal)
      => ComCall(10, this.p, BSTR, bstrIdentifier, VARIANT.Ptr, pVal)
    CreateCAConfiguration(bstrIdentifier, varCACert, ppVal)
      => ComCall(11, this.p, BSTR, bstrIdentifier, VARIANT, varCACert, IOCSPCAConfiguration.Ptr, ppVal)
    DeleteCAConfiguration(bstrIdentifier)
      => ComCall(12, this.p, BSTR, bstrIdentifier)
}
struct IOCSPAdmin extends IDispatch {
    static IID := "{322E830D-67DB-4FE9-9577-4596D9F09294}"
    get_OCSPServiceProperties(ppVal)
      => ComCall(7, this.p, IOCSPPropertyCollection.Ptr, ppVal)
    get_OCSPCAConfigurationCollection(pVal)
      => ComCall(8, this.p, IOCSPCAConfigurationCollection.Ptr, pVal)
    GetConfiguration(bstrServerName, bForce)
      => ComCall(9, this.p, BSTR, bstrServerName, VARIANT_BOOL, bForce)
    SetConfiguration(bstrServerName, bForce)
      => ComCall(10, this.p, BSTR, bstrServerName, VARIANT_BOOL, bForce)
    GetMyRoles(bstrServerName, pRoles)
      => ComCall(11, this.p, BSTR, bstrServerName, Int32.Ptr, pRoles)
    Ping(bstrServerName)
      => ComCall(12, this.p, BSTR, bstrServerName)
    SetSecurity(bstrServerName, bstrVal)
      => ComCall(13, this.p, BSTR, bstrServerName, BSTR, bstrVal)
    GetSecurity(bstrServerName, pVal)
      => ComCall(14, this.p, BSTR, bstrServerName, BSTR.Ptr, pVal)
    GetSigningCertificates(bstrServerName, pCACertVar, pVal)
      => ComCall(15, this.p, BSTR, bstrServerName, VARIANT.Ptr, pCACertVar, VARIANT.Ptr, pVal)
    GetHashAlgorithms(bstrServerName, bstrCAId, pVal)
      => ComCall(16, this.p, BSTR, bstrServerName, BSTR, bstrCAId, VARIANT.Ptr, pVal)
}
struct OCSPSigningFlag extends Int32 {
    static OCSP_SF_SILENT := 1
    static OCSP_SF_USE_CACERT := 2
    static OCSP_SF_ALLOW_SIGNINGCERT_AUTORENEWAL := 4
    static OCSP_SF_FORCE_SIGNINGCERT_ISSUER_ISCA := 8
    static OCSP_SF_AUTODISCOVER_SIGNINGCERT := 16
    static OCSP_SF_MANUAL_ASSIGN_SIGNINGCERT := 32
    static OCSP_SF_RESPONDER_ID_KEYHASH := 64
    static OCSP_SF_RESPONDER_ID_NAME := 128
    static OCSP_SF_ALLOW_NONCE_EXTENSION := 256
    static OCSP_SF_ALLOW_SIGNINGCERT_AUTOENROLLMENT := 512
}
struct OCSPRequestFlag extends Int32 {
    static OCSP_RF_REJECT_SIGNED_REQUESTS := 1
}
struct CSEDB_RSTMAPW {
    pwszDatabaseName : PWSTR
    pwszNewDatabaseName : PWSTR
}
struct FNCERTSRVISSERVERONLINEW extends FunctionPointer {
    static Types := [PWSTR, BOOL.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPGETDYNAMICFILELISTW extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16.Ptr.Ptr, UInt32.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPPREPAREW extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32, Struct.Ptr.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPGETDATABASENAMESW extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16.Ptr.Ptr, UInt32.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPOPENFILEW extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, Int64.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPREAD extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPCLOSE extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPGETBACKUPLOGSW extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16.Ptr.Ptr, UInt32.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPTRUNCATELOGS extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPEND extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct FNCERTSRVBACKUPFREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct FNCERTSRVRESTOREGETDATABASELOCATIONSW extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16.Ptr.Ptr, UInt32.Ptr, HRESULT]
}
struct FNCERTSRVRESTOREPREPAREW extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr.Ptr, HRESULT]
}
struct FNCERTSRVRESTOREREGISTERW extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, PWSTR, CSEDB_RSTMAPW.Ptr, Int32, PWSTR, UInt32, UInt32, HRESULT]
}
struct FNCERTSRVRESTOREREGISTERCOMPLETE extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, HRESULT]
}
struct FNCERTSRVRESTOREEND extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct FNCERTSRVSERVERCONTROLW extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32.Ptr, UInt8.Ptr.Ptr, HRESULT]
}
struct ICertServerPolicy extends IDispatch {
    static IID := "{AA000922-FFBE-11CF-8800-00A0C903B83C}"
    SetContext(Context)
      => ComCall(7, this.p, Int32, Context)
    GetRequestProperty(strPropertyName, PropertyType, pvarPropertyValue)
      => ComCall(8, this.p, BSTR, strPropertyName, Int32, PropertyType, VARIANT.Ptr, pvarPropertyValue)
    GetRequestAttribute(strAttributeName, pstrAttributeValue)
      => ComCall(9, this.p, BSTR, strAttributeName, BSTR.Ptr, pstrAttributeValue)
    GetCertificateProperty(strPropertyName, PropertyType, pvarPropertyValue)
      => ComCall(10, this.p, BSTR, strPropertyName, CERT_PROPERTY_TYPE, PropertyType, VARIANT.Ptr, pvarPropertyValue)
    SetCertificateProperty(strPropertyName, PropertyType, pvarPropertyValue)
      => ComCall(11, this.p, BSTR, strPropertyName, Int32, PropertyType, VARIANT.Ptr, pvarPropertyValue)
    GetCertificateExtension(strExtensionName, Type, pvarValue)
      => ComCall(12, this.p, BSTR, strExtensionName, CERT_PROPERTY_TYPE, Type, VARIANT.Ptr, pvarValue)
    GetCertificateExtensionFlags(pExtFlags)
      => ComCall(13, this.p, Int32.Ptr, pExtFlags)
    SetCertificateExtension(strExtensionName, Type, ExtFlags, pvarValue)
      => ComCall(14, this.p, BSTR, strExtensionName, Int32, Type, Int32, ExtFlags, VARIANT.Ptr, pvarValue)
    EnumerateExtensionsSetup(Flags)
      => ComCall(15, this.p, Int32, Flags)
    EnumerateExtensions(pstrExtensionName)
      => ComCall(16, this.p, BSTR.Ptr, pstrExtensionName)
    EnumerateExtensionsClose()
      => ComCall(17, this.p)
    EnumerateAttributesSetup(Flags)
      => ComCall(18, this.p, Int32, Flags)
    EnumerateAttributes(pstrAttributeName)
      => ComCall(19, this.p, BSTR.Ptr, pstrAttributeName)
    EnumerateAttributesClose()
      => ComCall(20, this.p)
}
struct ICertServerExit extends IDispatch {
    static IID := "{4BA9EB90-732C-11D0-8816-00A0C903B83C}"
    SetContext(Context)
      => ComCall(7, this.p, Int32, Context)
    GetRequestProperty(strPropertyName, PropertyType, pvarPropertyValue)
      => ComCall(8, this.p, BSTR, strPropertyName, Int32, PropertyType, VARIANT.Ptr, pvarPropertyValue)
    GetRequestAttribute(strAttributeName, pstrAttributeValue)
      => ComCall(9, this.p, BSTR, strAttributeName, BSTR.Ptr, pstrAttributeValue)
    GetCertificateProperty(strPropertyName, PropertyType, pvarPropertyValue)
      => ComCall(10, this.p, BSTR, strPropertyName, Int32, PropertyType, VARIANT.Ptr, pvarPropertyValue)
    GetCertificateExtension(strExtensionName, Type, pvarValue)
      => ComCall(11, this.p, BSTR, strExtensionName, Int32, Type, VARIANT.Ptr, pvarValue)
    GetCertificateExtensionFlags(pExtFlags)
      => ComCall(12, this.p, Int32.Ptr, pExtFlags)
    EnumerateExtensionsSetup(Flags)
      => ComCall(13, this.p, Int32, Flags)
    EnumerateExtensions(pstrExtensionName)
      => ComCall(14, this.p, BSTR.Ptr, pstrExtensionName)
    EnumerateExtensionsClose()
      => ComCall(15, this.p)
    EnumerateAttributesSetup(Flags)
      => ComCall(16, this.p, Int32, Flags)
    EnumerateAttributes(pstrAttributeName)
      => ComCall(17, this.p, BSTR.Ptr, pstrAttributeName)
    EnumerateAttributesClose()
      => ComCall(18, this.p)
}
struct ICertGetConfig extends IDispatch {
    static IID := "{C7EA09C0-CE17-11D0-8833-00A0C903B83C}"
    GetConfig(Flags, pstrOut)
      => ComCall(7, this.p, CERT_GET_CONFIG_FLAGS, Flags, BSTR.Ptr, pstrOut)
}
struct ICertConfig extends IDispatch {
    static IID := "{372FCE34-4324-11D0-8810-00A0C903B83C}"
    Reset(Index, pCount)
      => ComCall(7, this.p, Int32, Index, Int32.Ptr, pCount)
    Next(pIndex)
      => ComCall(8, this.p, Int32.Ptr, pIndex)
    GetField(strFieldName, pstrOut)
      => ComCall(9, this.p, BSTR, strFieldName, BSTR.Ptr, pstrOut)
    GetConfig(Flags, pstrOut)
      => ComCall(10, this.p, Int32, Flags, BSTR.Ptr, pstrOut)
}
struct ICertConfig2 extends ICertConfig {
    static IID := "{7A18EDDE-7E78-4163-8DED-78E2C9CEE924}"
    SetSharedFolder(strSharedFolder)
      => ComCall(11, this.p, BSTR, strSharedFolder)
}
struct ICertRequest extends IDispatch {
    static IID := "{014E4840-5523-11D0-8812-00A0C903B83C}"
    Submit(Flags, strRequest, strAttributes, strConfig, pDisposition)
      => ComCall(7, this.p, Int32, Flags, BSTR, strRequest, BSTR, strAttributes, BSTR, strConfig, Int32.Ptr, pDisposition)
    RetrievePending(RequestId, strConfig, pDisposition)
      => ComCall(8, this.p, Int32, RequestId, BSTR, strConfig, Int32.Ptr, pDisposition)
    GetLastStatus(pStatus)
      => ComCall(9, this.p, Int32.Ptr, pStatus)
    GetRequestId(pRequestId)
      => ComCall(10, this.p, Int32.Ptr, pRequestId)
    GetDispositionMessage(pstrDispositionMessage)
      => ComCall(11, this.p, BSTR.Ptr, pstrDispositionMessage)
    GetCACertificate(fExchangeCertificate, strConfig, Flags, pstrCertificate)
      => ComCall(12, this.p, Int32, fExchangeCertificate, BSTR, strConfig, Int32, Flags, BSTR.Ptr, pstrCertificate)
    GetCertificate(Flags, pstrCertificate)
      => ComCall(13, this.p, Int32, Flags, BSTR.Ptr, pstrCertificate)
}
struct ICertRequest2 extends ICertRequest {
    static IID := "{A4772988-4A85-4FA9-824E-B5CF5C16405A}"
    GetIssuedCertificate(strConfig, RequestId, strSerialNumber, pDisposition)
      => ComCall(14, this.p, BSTR, strConfig, Int32, RequestId, BSTR, strSerialNumber, CR_DISP.Ptr, pDisposition)
    GetErrorMessageText(hrMessage, Flags, pstrErrorMessageText)
      => ComCall(15, this.p, Int32, hrMessage, Int32, Flags, BSTR.Ptr, pstrErrorMessageText)
    GetCAProperty(strConfig, PropId, PropIndex, PropType, Flags, pvarPropertyValue)
      => ComCall(16, this.p, BSTR, strConfig, Int32, PropId, Int32, PropIndex, Int32, PropType, Int32, Flags, VARIANT.Ptr, pvarPropertyValue)
    GetCAPropertyFlags(strConfig, PropId, pPropFlags)
      => ComCall(17, this.p, BSTR, strConfig, Int32, PropId, Int32.Ptr, pPropFlags)
    GetCAPropertyDisplayName(strConfig, PropId, pstrDisplayName)
      => ComCall(18, this.p, BSTR, strConfig, Int32, PropId, BSTR.Ptr, pstrDisplayName)
    GetFullResponseProperty(PropId, PropIndex, PropType, Flags, pvarPropertyValue)
      => ComCall(19, this.p, FULL_RESPONSE_PROPERTY_ID, PropId, Int32, PropIndex, CERT_PROPERTY_TYPE, PropType, CERT_REQUEST_OUT_TYPE, Flags, VARIANT.Ptr, pvarPropertyValue)
}
struct X509EnrollmentAuthFlags extends Int32 {
    static X509AuthNone := 0
    static X509AuthAnonymous := 1
    static X509AuthKerberos := 2
    static X509AuthUsername := 4
    static X509AuthCertificate := 8
}
struct ICertRequest3 extends ICertRequest2 {
    static IID := "{AFC8F92B-33A2-4861-BF36-2933B7CD67B3}"
    SetCredential(hWnd, AuthType, strCredential, strPassword)
      => ComCall(20, this.p, Int32, hWnd, X509EnrollmentAuthFlags, AuthType, BSTR, strCredential, BSTR, strPassword)
    GetRequestIdString(pstrRequestId)
      => ComCall(21, this.p, BSTR.Ptr, pstrRequestId)
    GetIssuedCertificate2(strConfig, strRequestId, strSerialNumber, pDisposition)
      => ComCall(22, this.p, BSTR, strConfig, BSTR, strRequestId, BSTR, strSerialNumber, CR_DISP.Ptr, pDisposition)
    GetRefreshPolicy(pValue)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pValue)
}
struct ICertManageModule extends IDispatch {
    static IID := "{E7D7AD42-BD3D-11D1-9A4D-00C04FC297EB}"
    GetProperty(strConfig, strStorageLocation, strPropertyName, Flags, pvarProperty)
      => ComCall(7, this.p, BSTR, strConfig, BSTR, strStorageLocation, BSTR, strPropertyName, Int32, Flags, VARIANT.Ptr, pvarProperty)
    SetProperty(strConfig, strStorageLocation, strPropertyName, Flags, pvarProperty)
      => ComCall(8, this.p, BSTR, strConfig, BSTR, strStorageLocation, BSTR, strPropertyName, Int32, Flags, VARIANT.Ptr, pvarProperty)
    Configure(strConfig, strStorageLocation, Flags)
      => ComCall(9, this.p, BSTR, strConfig, BSTR, strStorageLocation, Int32, Flags)
}
struct CERTTRANSBLOB {
    cb : UInt32
    pb : UInt8.Ptr
}
struct CERTVIEWRESTRICTION {
    ColumnIndex : UInt32
    SeekOperator : Int32
    SortOrder : Int32
    pbValue : UInt8.Ptr
    cbValue : UInt32
}
struct ICertPolicy extends IDispatch {
    static IID := "{38BB5A00-7636-11D0-B413-00A0C91BBF8C}"
    Initialize(strConfig)
      => ComCall(7, this.p, BSTR, strConfig)
    VerifyRequest(strConfig, Context, bNewRequest, Flags, pDisposition)
      => ComCall(8, this.p, BSTR, strConfig, Int32, Context, Int32, bNewRequest, Int32, Flags, Int32.Ptr, pDisposition)
    GetDescription(pstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pstrDescription)
    ShutDown()
      => ComCall(10, this.p)
}
struct ICertPolicy2 extends ICertPolicy {
    static IID := "{3DB4910E-8001-4BF1-AA1B-F43A808317A0}"
    GetManageModule(ppManageModule)
      => ComCall(11, this.p, ICertManageModule.Ptr, ppManageModule)
}
struct X509SCEPMessageType extends Int32 {
    static SCEPMessageUnknown := -1
    static SCEPMessageCertResponse := 3
    static SCEPMessagePKCSRequest := 19
    static SCEPMessageGetCertInitial := 20
    static SCEPMessageGetCert := 21
    static SCEPMessageGetCRL := 22
    static SCEPMessageClaimChallengeAnswer := 41
    static SCEPMessageGetCertifier := 198
}
struct X509SCEPDisposition extends Int32 {
    static SCEPDispositionUnknown := -1
    static SCEPDispositionSuccess := 0
    static SCEPDispositionFailure := 2
    static SCEPDispositionPending := 3
    static SCEPDispositionPendingChallenge := 11
}
struct X509SCEPFailInfo extends Int32 {
    static SCEPFailUnknown := -1
    static SCEPFailBadAlgorithm := 0
    static SCEPFailBadMessageCheck := 1
    static SCEPFailBadRequest := 2
    static SCEPFailBadTime := 3
    static SCEPFailBadCertId := 4
}
struct INDESPolicy extends IUnknown {
    static IID := "{13CA515D-431D-46CC-8C2E-1DA269BBD625}"
    Initialize()
      => ComCall(3, this.p)
    Uninitialize()
      => ComCall(4, this.p)
    GenerateChallenge(pwszTemplate, pwszParams, ppwszResponse)
      => ComCall(5, this.p, "Str", pwszTemplate, "Str", pwszParams, PWSTR.Ptr, ppwszResponse)
    VerifyRequest(pctbRequest, pctbSigningCertEncoded, pwszTemplate, pwszTransactionId, pfVerified)
      => ComCall(6, this.p, CERTTRANSBLOB.Ptr, pctbRequest, CERTTRANSBLOB.Ptr, pctbSigningCertEncoded, "Str", pwszTemplate, "Str", pwszTransactionId, BOOL.Ptr, pfVerified)
    Notify(pwszChallenge, pwszTransactionId, disposition, lastHResult, pctbIssuedCertEncoded)
      => ComCall(7, this.p, "Str", pwszChallenge, "Str", pwszTransactionId, X509SCEPDisposition, disposition, Int32, lastHResult, CERTTRANSBLOB.Ptr, pctbIssuedCertEncoded)
}
struct CERTENROLL_OBJECTID extends Int32 {
    static XCN_OID_NONE := 0
    static XCN_OID_RSA := 1
    static XCN_OID_PKCS := 2
    static XCN_OID_RSA_HASH := 3
    static XCN_OID_RSA_ENCRYPT := 4
    static XCN_OID_PKCS_1 := 5
    static XCN_OID_PKCS_2 := 6
    static XCN_OID_PKCS_3 := 7
    static XCN_OID_PKCS_4 := 8
    static XCN_OID_PKCS_5 := 9
    static XCN_OID_PKCS_6 := 10
    static XCN_OID_PKCS_7 := 11
    static XCN_OID_PKCS_8 := 12
    static XCN_OID_PKCS_9 := 13
    static XCN_OID_PKCS_10 := 14
    static XCN_OID_PKCS_12 := 15
    static XCN_OID_RSA_RSA := 16
    static XCN_OID_RSA_MD2RSA := 17
    static XCN_OID_RSA_MD4RSA := 18
    static XCN_OID_RSA_MD5RSA := 19
    static XCN_OID_RSA_SHA1RSA := 20
    static XCN_OID_RSA_SETOAEP_RSA := 21
    static XCN_OID_RSA_DH := 22
    static XCN_OID_RSA_data := 23
    static XCN_OID_RSA_signedData := 24
    static XCN_OID_RSA_envelopedData := 25
    static XCN_OID_RSA_signEnvData := 26
    static XCN_OID_RSA_digestedData := 27
    static XCN_OID_RSA_hashedData := 28
    static XCN_OID_RSA_encryptedData := 29
    static XCN_OID_RSA_emailAddr := 30
    static XCN_OID_RSA_unstructName := 31
    static XCN_OID_RSA_contentType := 32
    static XCN_OID_RSA_messageDigest := 33
    static XCN_OID_RSA_signingTime := 34
    static XCN_OID_RSA_counterSign := 35
    static XCN_OID_RSA_challengePwd := 36
    static XCN_OID_RSA_unstructAddr := 37
    static XCN_OID_RSA_extCertAttrs := 38
    static XCN_OID_RSA_certExtensions := 39
    static XCN_OID_RSA_SMIMECapabilities := 40
    static XCN_OID_RSA_preferSignedData := 41
    static XCN_OID_RSA_SMIMEalg := 42
    static XCN_OID_RSA_SMIMEalgESDH := 43
    static XCN_OID_RSA_SMIMEalgCMS3DESwrap := 44
    static XCN_OID_RSA_SMIMEalgCMSRC2wrap := 45
    static XCN_OID_RSA_MD2 := 46
    static XCN_OID_RSA_MD4 := 47
    static XCN_OID_RSA_MD5 := 48
    static XCN_OID_RSA_RC2CBC := 49
    static XCN_OID_RSA_RC4 := 50
    static XCN_OID_RSA_DES_EDE3_CBC := 51
    static XCN_OID_RSA_RC5_CBCPad := 52
    static XCN_OID_ANSI_X942 := 53
    static XCN_OID_ANSI_X942_DH := 54
    static XCN_OID_X957 := 55
    static XCN_OID_X957_DSA := 56
    static XCN_OID_X957_SHA1DSA := 57
    static XCN_OID_DS := 58
    static XCN_OID_DSALG := 59
    static XCN_OID_DSALG_CRPT := 60
    static XCN_OID_DSALG_HASH := 61
    static XCN_OID_DSALG_SIGN := 62
    static XCN_OID_DSALG_RSA := 63
    static XCN_OID_OIW := 64
    static XCN_OID_OIWSEC := 65
    static XCN_OID_OIWSEC_md4RSA := 66
    static XCN_OID_OIWSEC_md5RSA := 67
    static XCN_OID_OIWSEC_md4RSA2 := 68
    static XCN_OID_OIWSEC_desECB := 69
    static XCN_OID_OIWSEC_desCBC := 70
    static XCN_OID_OIWSEC_desOFB := 71
    static XCN_OID_OIWSEC_desCFB := 72
    static XCN_OID_OIWSEC_desMAC := 73
    static XCN_OID_OIWSEC_rsaSign := 74
    static XCN_OID_OIWSEC_dsa := 75
    static XCN_OID_OIWSEC_shaDSA := 76
    static XCN_OID_OIWSEC_mdc2RSA := 77
    static XCN_OID_OIWSEC_shaRSA := 78
    static XCN_OID_OIWSEC_dhCommMod := 79
    static XCN_OID_OIWSEC_desEDE := 80
    static XCN_OID_OIWSEC_sha := 81
    static XCN_OID_OIWSEC_mdc2 := 82
    static XCN_OID_OIWSEC_dsaComm := 83
    static XCN_OID_OIWSEC_dsaCommSHA := 84
    static XCN_OID_OIWSEC_rsaXchg := 85
    static XCN_OID_OIWSEC_keyHashSeal := 86
    static XCN_OID_OIWSEC_md2RSASign := 87
    static XCN_OID_OIWSEC_md5RSASign := 88
    static XCN_OID_OIWSEC_sha1 := 89
    static XCN_OID_OIWSEC_dsaSHA1 := 90
    static XCN_OID_OIWSEC_dsaCommSHA1 := 91
    static XCN_OID_OIWSEC_sha1RSASign := 92
    static XCN_OID_OIWDIR := 93
    static XCN_OID_OIWDIR_CRPT := 94
    static XCN_OID_OIWDIR_HASH := 95
    static XCN_OID_OIWDIR_SIGN := 96
    static XCN_OID_OIWDIR_md2 := 97
    static XCN_OID_OIWDIR_md2RSA := 98
    static XCN_OID_INFOSEC := 99
    static XCN_OID_INFOSEC_sdnsSignature := 100
    static XCN_OID_INFOSEC_mosaicSignature := 101
    static XCN_OID_INFOSEC_sdnsConfidentiality := 102
    static XCN_OID_INFOSEC_mosaicConfidentiality := 103
    static XCN_OID_INFOSEC_sdnsIntegrity := 104
    static XCN_OID_INFOSEC_mosaicIntegrity := 105
    static XCN_OID_INFOSEC_sdnsTokenProtection := 106
    static XCN_OID_INFOSEC_mosaicTokenProtection := 107
    static XCN_OID_INFOSEC_sdnsKeyManagement := 108
    static XCN_OID_INFOSEC_mosaicKeyManagement := 109
    static XCN_OID_INFOSEC_sdnsKMandSig := 110
    static XCN_OID_INFOSEC_mosaicKMandSig := 111
    static XCN_OID_INFOSEC_SuiteASignature := 112
    static XCN_OID_INFOSEC_SuiteAConfidentiality := 113
    static XCN_OID_INFOSEC_SuiteAIntegrity := 114
    static XCN_OID_INFOSEC_SuiteATokenProtection := 115
    static XCN_OID_INFOSEC_SuiteAKeyManagement := 116
    static XCN_OID_INFOSEC_SuiteAKMandSig := 117
    static XCN_OID_INFOSEC_mosaicUpdatedSig := 118
    static XCN_OID_INFOSEC_mosaicKMandUpdSig := 119
    static XCN_OID_INFOSEC_mosaicUpdatedInteg := 120
    static XCN_OID_COMMON_NAME := 121
    static XCN_OID_SUR_NAME := 122
    static XCN_OID_DEVICE_SERIAL_NUMBER := 123
    static XCN_OID_COUNTRY_NAME := 124
    static XCN_OID_LOCALITY_NAME := 125
    static XCN_OID_STATE_OR_PROVINCE_NAME := 126
    static XCN_OID_STREET_ADDRESS := 127
    static XCN_OID_ORGANIZATION_NAME := 128
    static XCN_OID_ORGANIZATIONAL_UNIT_NAME := 129
    static XCN_OID_TITLE := 130
    static XCN_OID_DESCRIPTION := 131
    static XCN_OID_SEARCH_GUIDE := 132
    static XCN_OID_BUSINESS_CATEGORY := 133
    static XCN_OID_POSTAL_ADDRESS := 134
    static XCN_OID_POSTAL_CODE := 135
    static XCN_OID_POST_OFFICE_BOX := 136
    static XCN_OID_PHYSICAL_DELIVERY_OFFICE_NAME := 137
    static XCN_OID_TELEPHONE_NUMBER := 138
    static XCN_OID_TELEX_NUMBER := 139
    static XCN_OID_TELETEXT_TERMINAL_IDENTIFIER := 140
    static XCN_OID_FACSIMILE_TELEPHONE_NUMBER := 141
    static XCN_OID_X21_ADDRESS := 142
    static XCN_OID_INTERNATIONAL_ISDN_NUMBER := 143
    static XCN_OID_REGISTERED_ADDRESS := 144
    static XCN_OID_DESTINATION_INDICATOR := 145
    static XCN_OID_PREFERRED_DELIVERY_METHOD := 146
    static XCN_OID_PRESENTATION_ADDRESS := 147
    static XCN_OID_SUPPORTED_APPLICATION_CONTEXT := 148
    static XCN_OID_MEMBER := 149
    static XCN_OID_OWNER := 150
    static XCN_OID_ROLE_OCCUPANT := 151
    static XCN_OID_SEE_ALSO := 152
    static XCN_OID_USER_PASSWORD := 153
    static XCN_OID_USER_CERTIFICATE := 154
    static XCN_OID_CA_CERTIFICATE := 155
    static XCN_OID_AUTHORITY_REVOCATION_LIST := 156
    static XCN_OID_CERTIFICATE_REVOCATION_LIST := 157
    static XCN_OID_CROSS_CERTIFICATE_PAIR := 158
    static XCN_OID_GIVEN_NAME := 159
    static XCN_OID_INITIALS := 160
    static XCN_OID_DN_QUALIFIER := 161
    static XCN_OID_DOMAIN_COMPONENT := 162
    static XCN_OID_PKCS_12_FRIENDLY_NAME_ATTR := 163
    static XCN_OID_PKCS_12_LOCAL_KEY_ID := 164
    static XCN_OID_PKCS_12_KEY_PROVIDER_NAME_ATTR := 165
    static XCN_OID_LOCAL_MACHINE_KEYSET := 166
    static XCN_OID_PKCS_12_EXTENDED_ATTRIBUTES := 167
    static XCN_OID_KEYID_RDN := 168
    static XCN_OID_AUTHORITY_KEY_IDENTIFIER := 169
    static XCN_OID_KEY_ATTRIBUTES := 170
    static XCN_OID_CERT_POLICIES_95 := 171
    static XCN_OID_KEY_USAGE_RESTRICTION := 172
    static XCN_OID_SUBJECT_ALT_NAME := 173
    static XCN_OID_ISSUER_ALT_NAME := 174
    static XCN_OID_BASIC_CONSTRAINTS := 175
    static XCN_OID_KEY_USAGE := 176
    static XCN_OID_PRIVATEKEY_USAGE_PERIOD := 177
    static XCN_OID_BASIC_CONSTRAINTS2 := 178
    static XCN_OID_CERT_POLICIES := 179
    static XCN_OID_ANY_CERT_POLICY := 180
    static XCN_OID_AUTHORITY_KEY_IDENTIFIER2 := 181
    static XCN_OID_SUBJECT_KEY_IDENTIFIER := 182
    static XCN_OID_SUBJECT_ALT_NAME2 := 183
    static XCN_OID_ISSUER_ALT_NAME2 := 184
    static XCN_OID_CRL_REASON_CODE := 185
    static XCN_OID_REASON_CODE_HOLD := 186
    static XCN_OID_CRL_DIST_POINTS := 187
    static XCN_OID_ENHANCED_KEY_USAGE := 188
    static XCN_OID_CRL_NUMBER := 189
    static XCN_OID_DELTA_CRL_INDICATOR := 190
    static XCN_OID_ISSUING_DIST_POINT := 191
    static XCN_OID_FRESHEST_CRL := 192
    static XCN_OID_NAME_CONSTRAINTS := 193
    static XCN_OID_POLICY_MAPPINGS := 194
    static XCN_OID_LEGACY_POLICY_MAPPINGS := 195
    static XCN_OID_POLICY_CONSTRAINTS := 196
    static XCN_OID_RENEWAL_CERTIFICATE := 197
    static XCN_OID_ENROLLMENT_NAME_VALUE_PAIR := 198
    static XCN_OID_ENROLLMENT_CSP_PROVIDER := 199
    static XCN_OID_OS_VERSION := 200
    static XCN_OID_ENROLLMENT_AGENT := 201
    static XCN_OID_PKIX := 202
    static XCN_OID_PKIX_PE := 203
    static XCN_OID_AUTHORITY_INFO_ACCESS := 204
    static XCN_OID_BIOMETRIC_EXT := 205
    static XCN_OID_LOGOTYPE_EXT := 206
    static XCN_OID_CERT_EXTENSIONS := 207
    static XCN_OID_NEXT_UPDATE_LOCATION := 208
    static XCN_OID_REMOVE_CERTIFICATE := 209
    static XCN_OID_CROSS_CERT_DIST_POINTS := 210
    static XCN_OID_CTL := 211
    static XCN_OID_SORTED_CTL := 212
    static XCN_OID_SERIALIZED := 213
    static XCN_OID_NT_PRINCIPAL_NAME := 214
    static XCN_OID_PRODUCT_UPDATE := 215
    static XCN_OID_ANY_APPLICATION_POLICY := 216
    static XCN_OID_AUTO_ENROLL_CTL_USAGE := 217
    static XCN_OID_ENROLL_CERTTYPE_EXTENSION := 218
    static XCN_OID_CERT_MANIFOLD := 219
    static XCN_OID_CERTSRV_CA_VERSION := 220
    static XCN_OID_CERTSRV_PREVIOUS_CERT_HASH := 221
    static XCN_OID_CRL_VIRTUAL_BASE := 222
    static XCN_OID_CRL_NEXT_PUBLISH := 223
    static XCN_OID_KP_CA_EXCHANGE := 224
    static XCN_OID_KP_KEY_RECOVERY_AGENT := 225
    static XCN_OID_CERTIFICATE_TEMPLATE := 226
    static XCN_OID_ENTERPRISE_OID_ROOT := 227
    static XCN_OID_RDN_DUMMY_SIGNER := 228
    static XCN_OID_APPLICATION_CERT_POLICIES := 229
    static XCN_OID_APPLICATION_POLICY_MAPPINGS := 230
    static XCN_OID_APPLICATION_POLICY_CONSTRAINTS := 231
    static XCN_OID_ARCHIVED_KEY_ATTR := 232
    static XCN_OID_CRL_SELF_CDP := 233
    static XCN_OID_REQUIRE_CERT_CHAIN_POLICY := 234
    static XCN_OID_ARCHIVED_KEY_CERT_HASH := 235
    static XCN_OID_ISSUED_CERT_HASH := 236
    static XCN_OID_DS_EMAIL_REPLICATION := 237
    static XCN_OID_REQUEST_CLIENT_INFO := 238
    static XCN_OID_ENCRYPTED_KEY_HASH := 239
    static XCN_OID_CERTSRV_CROSSCA_VERSION := 240
    static XCN_OID_NTDS_REPLICATION := 241
    static XCN_OID_SUBJECT_DIR_ATTRS := 242
    static XCN_OID_PKIX_KP := 243
    static XCN_OID_PKIX_KP_SERVER_AUTH := 244
    static XCN_OID_PKIX_KP_CLIENT_AUTH := 245
    static XCN_OID_PKIX_KP_CODE_SIGNING := 246
    static XCN_OID_PKIX_KP_EMAIL_PROTECTION := 247
    static XCN_OID_PKIX_KP_IPSEC_END_SYSTEM := 248
    static XCN_OID_PKIX_KP_IPSEC_TUNNEL := 249
    static XCN_OID_PKIX_KP_IPSEC_USER := 250
    static XCN_OID_PKIX_KP_TIMESTAMP_SIGNING := 251
    static XCN_OID_PKIX_KP_OCSP_SIGNING := 252
    static XCN_OID_PKIX_OCSP_NOCHECK := 253
    static XCN_OID_IPSEC_KP_IKE_INTERMEDIATE := 254
    static XCN_OID_KP_CTL_USAGE_SIGNING := 255
    static XCN_OID_KP_TIME_STAMP_SIGNING := 256
    static XCN_OID_SERVER_GATED_CRYPTO := 257
    static XCN_OID_SGC_NETSCAPE := 258
    static XCN_OID_KP_EFS := 259
    static XCN_OID_EFS_RECOVERY := 260
    static XCN_OID_WHQL_CRYPTO := 261
    static XCN_OID_NT5_CRYPTO := 262
    static XCN_OID_OEM_WHQL_CRYPTO := 263
    static XCN_OID_EMBEDDED_NT_CRYPTO := 264
    static XCN_OID_ROOT_LIST_SIGNER := 265
    static XCN_OID_KP_QUALIFIED_SUBORDINATION := 266
    static XCN_OID_KP_KEY_RECOVERY := 267
    static XCN_OID_KP_DOCUMENT_SIGNING := 268
    static XCN_OID_KP_LIFETIME_SIGNING := 269
    static XCN_OID_KP_MOBILE_DEVICE_SOFTWARE := 270
    static XCN_OID_KP_SMART_DISPLAY := 271
    static XCN_OID_KP_CSP_SIGNATURE := 272
    static XCN_OID_DRM := 273
    static XCN_OID_DRM_INDIVIDUALIZATION := 274
    static XCN_OID_LICENSES := 275
    static XCN_OID_LICENSE_SERVER := 276
    static XCN_OID_KP_SMARTCARD_LOGON := 277
    static XCN_OID_YESNO_TRUST_ATTR := 278
    static XCN_OID_PKIX_POLICY_QUALIFIER_CPS := 279
    static XCN_OID_PKIX_POLICY_QUALIFIER_USERNOTICE := 280
    static XCN_OID_CERT_POLICIES_95_QUALIFIER1 := 281
    static XCN_OID_PKIX_ACC_DESCR := 282
    static XCN_OID_PKIX_OCSP := 283
    static XCN_OID_PKIX_CA_ISSUERS := 284
    static XCN_OID_VERISIGN_PRIVATE_6_9 := 285
    static XCN_OID_VERISIGN_ONSITE_JURISDICTION_HASH := 286
    static XCN_OID_VERISIGN_BITSTRING_6_13 := 287
    static XCN_OID_VERISIGN_ISS_STRONG_CRYPTO := 288
    static XCN_OID_NETSCAPE := 289
    static XCN_OID_NETSCAPE_CERT_EXTENSION := 290
    static XCN_OID_NETSCAPE_CERT_TYPE := 291
    static XCN_OID_NETSCAPE_BASE_URL := 292
    static XCN_OID_NETSCAPE_REVOCATION_URL := 293
    static XCN_OID_NETSCAPE_CA_REVOCATION_URL := 294
    static XCN_OID_NETSCAPE_CERT_RENEWAL_URL := 295
    static XCN_OID_NETSCAPE_CA_POLICY_URL := 296
    static XCN_OID_NETSCAPE_SSL_SERVER_NAME := 297
    static XCN_OID_NETSCAPE_COMMENT := 298
    static XCN_OID_NETSCAPE_DATA_TYPE := 299
    static XCN_OID_NETSCAPE_CERT_SEQUENCE := 300
    static XCN_OID_CT_PKI_DATA := 301
    static XCN_OID_CT_PKI_RESPONSE := 302
    static XCN_OID_PKIX_NO_SIGNATURE := 303
    static XCN_OID_CMC := 304
    static XCN_OID_CMC_STATUS_INFO := 305
    static XCN_OID_CMC_IDENTIFICATION := 306
    static XCN_OID_CMC_IDENTITY_PROOF := 307
    static XCN_OID_CMC_DATA_RETURN := 308
    static XCN_OID_CMC_TRANSACTION_ID := 309
    static XCN_OID_CMC_SENDER_NONCE := 310
    static XCN_OID_CMC_RECIPIENT_NONCE := 311
    static XCN_OID_CMC_ADD_EXTENSIONS := 312
    static XCN_OID_CMC_ENCRYPTED_POP := 313
    static XCN_OID_CMC_DECRYPTED_POP := 314
    static XCN_OID_CMC_LRA_POP_WITNESS := 315
    static XCN_OID_CMC_GET_CERT := 316
    static XCN_OID_CMC_GET_CRL := 317
    static XCN_OID_CMC_REVOKE_REQUEST := 318
    static XCN_OID_CMC_REG_INFO := 319
    static XCN_OID_CMC_RESPONSE_INFO := 320
    static XCN_OID_CMC_QUERY_PENDING := 321
    static XCN_OID_CMC_ID_POP_LINK_RANDOM := 322
    static XCN_OID_CMC_ID_POP_LINK_WITNESS := 323
    static XCN_OID_CMC_ID_CONFIRM_CERT_ACCEPTANCE := 324
    static XCN_OID_CMC_ADD_ATTRIBUTES := 325
    static XCN_OID_LOYALTY_OTHER_LOGOTYPE := 326
    static XCN_OID_BACKGROUND_OTHER_LOGOTYPE := 327
    static XCN_OID_PKIX_OCSP_BASIC_SIGNED_RESPONSE := 328
    static XCN_OID_PKCS_7_DATA := 329
    static XCN_OID_PKCS_7_SIGNED := 330
    static XCN_OID_PKCS_7_ENVELOPED := 331
    static XCN_OID_PKCS_7_SIGNEDANDENVELOPED := 332
    static XCN_OID_PKCS_7_DIGESTED := 333
    static XCN_OID_PKCS_7_ENCRYPTED := 334
    static XCN_OID_PKCS_9_CONTENT_TYPE := 335
    static XCN_OID_PKCS_9_MESSAGE_DIGEST := 336
    static XCN_OID_CERT_PROP_ID_PREFIX := 337
    static XCN_OID_CERT_KEY_IDENTIFIER_PROP_ID := 338
    static XCN_OID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID := 339
    static XCN_OID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID := 340
    static XCN_OID_CERT_MD5_HASH_PROP_ID := 341
    static XCN_OID_RSA_SHA256RSA := 342
    static XCN_OID_RSA_SHA384RSA := 343
    static XCN_OID_RSA_SHA512RSA := 344
    static XCN_OID_NIST_sha256 := 345
    static XCN_OID_NIST_sha384 := 346
    static XCN_OID_NIST_sha512 := 347
    static XCN_OID_RSA_MGF1 := 348
    static XCN_OID_ECC_PUBLIC_KEY := 349
    static XCN_OID_ECDSA_SHA1 := 350
    static XCN_OID_ECDSA_SPECIFIED := 351
    static XCN_OID_ANY_ENHANCED_KEY_USAGE := 352
    static XCN_OID_RSA_SSA_PSS := 353
    static XCN_OID_ATTR_SUPPORTED_ALGORITHMS := 355
    static XCN_OID_ATTR_TPM_SECURITY_ASSERTIONS := 356
    static XCN_OID_ATTR_TPM_SPECIFICATION := 357
    static XCN_OID_CERT_DISALLOWED_FILETIME_PROP_ID := 358
    static XCN_OID_CERT_SIGNATURE_HASH_PROP_ID := 359
    static XCN_OID_CERT_STRONG_KEY_OS_1 := 360
    static XCN_OID_CERT_STRONG_KEY_OS_CURRENT := 361
    static XCN_OID_CERT_STRONG_KEY_OS_PREFIX := 362
    static XCN_OID_CERT_STRONG_SIGN_OS_1 := 363
    static XCN_OID_CERT_STRONG_SIGN_OS_CURRENT := 364
    static XCN_OID_CERT_STRONG_SIGN_OS_PREFIX := 365
    static XCN_OID_DH_SINGLE_PASS_STDDH_SHA1_KDF := 366
    static XCN_OID_DH_SINGLE_PASS_STDDH_SHA256_KDF := 367
    static XCN_OID_DH_SINGLE_PASS_STDDH_SHA384_KDF := 368
    static XCN_OID_DISALLOWED_HASH := 369
    static XCN_OID_DISALLOWED_LIST := 370
    static XCN_OID_ECC_CURVE_P256 := 371
    static XCN_OID_ECC_CURVE_P384 := 372
    static XCN_OID_ECC_CURVE_P521 := 373
    static XCN_OID_ECDSA_SHA256 := 374
    static XCN_OID_ECDSA_SHA384 := 375
    static XCN_OID_ECDSA_SHA512 := 376
    static XCN_OID_ENROLL_CAXCHGCERT_HASH := 377
    static XCN_OID_ENROLL_EK_INFO := 378
    static XCN_OID_ENROLL_EKPUB_CHALLENGE := 379
    static XCN_OID_ENROLL_EKVERIFYCERT := 380
    static XCN_OID_ENROLL_EKVERIFYCREDS := 381
    static XCN_OID_ENROLL_EKVERIFYKEY := 382
    static XCN_OID_EV_RDN_COUNTRY := 383
    static XCN_OID_EV_RDN_LOCALE := 384
    static XCN_OID_EV_RDN_STATE_OR_PROVINCE := 385
    static XCN_OID_INHIBIT_ANY_POLICY := 386
    static XCN_OID_INTERNATIONALIZED_EMAIL_ADDRESS := 387
    static XCN_OID_KP_KERNEL_MODE_CODE_SIGNING := 388
    static XCN_OID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING := 389
    static XCN_OID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING := 390
    static XCN_OID_KP_TPM_AIK_CERTIFICATE := 391
    static XCN_OID_KP_TPM_EK_CERTIFICATE := 392
    static XCN_OID_KP_TPM_PLATFORM_CERTIFICATE := 393
    static XCN_OID_NIST_AES128_CBC := 394
    static XCN_OID_NIST_AES128_WRAP := 395
    static XCN_OID_NIST_AES192_CBC := 396
    static XCN_OID_NIST_AES192_WRAP := 397
    static XCN_OID_NIST_AES256_CBC := 398
    static XCN_OID_NIST_AES256_WRAP := 399
    static XCN_OID_PKCS_12_PbeIds := 400
    static XCN_OID_PKCS_12_pbeWithSHA1And128BitRC2 := 401
    static XCN_OID_PKCS_12_pbeWithSHA1And128BitRC4 := 402
    static XCN_OID_PKCS_12_pbeWithSHA1And2KeyTripleDES := 403
    static XCN_OID_PKCS_12_pbeWithSHA1And3KeyTripleDES := 404
    static XCN_OID_PKCS_12_pbeWithSHA1And40BitRC2 := 405
    static XCN_OID_PKCS_12_pbeWithSHA1And40BitRC4 := 406
    static XCN_OID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID := 407
    static XCN_OID_PKINIT_KP_KDC := 408
    static XCN_OID_PKIX_CA_REPOSITORY := 409
    static XCN_OID_PKIX_OCSP_NONCE := 410
    static XCN_OID_PKIX_TIME_STAMPING := 411
    static XCN_OID_QC_EU_COMPLIANCE := 412
    static XCN_OID_QC_SSCD := 413
    static XCN_OID_QC_STATEMENTS_EXT := 414
    static XCN_OID_RDN_TPM_MANUFACTURER := 415
    static XCN_OID_RDN_TPM_MODEL := 416
    static XCN_OID_RDN_TPM_VERSION := 417
    static XCN_OID_REVOKED_LIST_SIGNER := 418
    static XCN_OID_RFC3161_counterSign := 419
    static XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION := 420
    static XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION := 421
    static XCN_OID_ROOT_PROGRAM_FLAGS := 422
    static XCN_OID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL := 423
    static XCN_OID_RSA_PSPECIFIED := 424
    static XCN_OID_RSAES_OAEP := 425
    static XCN_OID_SUBJECT_INFO_ACCESS := 426
    static XCN_OID_TIMESTAMP_TOKEN := 427
    static XCN_OID_ENROLL_SCEP_ERROR := 428
    static XCN_OIDVerisign_MessageType := 429
    static XCN_OIDVerisign_PkiStatus := 430
    static XCN_OIDVerisign_FailInfo := 431
    static XCN_OIDVerisign_SenderNonce := 432
    static XCN_OIDVerisign_RecipientNonce := 433
    static XCN_OIDVerisign_TransactionID := 434
    static XCN_OID_ENROLL_ATTESTATION_CHALLENGE := 435
    static XCN_OID_ENROLL_ATTESTATION_STATEMENT := 436
    static XCN_OID_ENROLL_ENCRYPTION_ALGORITHM := 437
    static XCN_OID_ENROLL_KSP_NAME := 438
}
struct WebSecurityLevel extends Int32 {
    static LevelUnsafe := 0
    static LevelSafe := 1
}
struct EncodingType extends Int32 {
    static XCN_CRYPT_STRING_BASE64HEADER := 0
    static XCN_CRYPT_STRING_BASE64 := 1
    static XCN_CRYPT_STRING_BINARY := 2
    static XCN_CRYPT_STRING_BASE64REQUESTHEADER := 3
    static XCN_CRYPT_STRING_HEX := 4
    static XCN_CRYPT_STRING_HEXASCII := 5
    static XCN_CRYPT_STRING_BASE64_ANY := 6
    static XCN_CRYPT_STRING_ANY := 7
    static XCN_CRYPT_STRING_HEX_ANY := 8
    static XCN_CRYPT_STRING_BASE64X509CRLHEADER := 9
    static XCN_CRYPT_STRING_HEXADDR := 10
    static XCN_CRYPT_STRING_HEXASCIIADDR := 11
    static XCN_CRYPT_STRING_HEXRAW := 12
    static XCN_CRYPT_STRING_BASE64URI := 13
    static XCN_CRYPT_STRING_ENCODEMASK := 255
    static XCN_CRYPT_STRING_CHAIN := 256
    static XCN_CRYPT_STRING_TEXT := 512
    static XCN_CRYPT_STRING_PERCENTESCAPE := 134217728
    static XCN_CRYPT_STRING_HASHDATA := 268435456
    static XCN_CRYPT_STRING_STRICT := 536870912
    static XCN_CRYPT_STRING_NOCRLF := 1073741824
    static XCN_CRYPT_STRING_NOCR := -2147483648
}
struct PFXExportOptions extends Int32 {
    static PFXExportEEOnly := 0
    static PFXExportChainNoRoot := 1
    static PFXExportChainWithRoot := 2
}
struct ObjectIdGroupId extends Int32 {
    static XCN_CRYPT_ANY_GROUP_ID := 0
    static XCN_CRYPT_HASH_ALG_OID_GROUP_ID := 1
    static XCN_CRYPT_ENCRYPT_ALG_OID_GROUP_ID := 2
    static XCN_CRYPT_PUBKEY_ALG_OID_GROUP_ID := 3
    static XCN_CRYPT_SIGN_ALG_OID_GROUP_ID := 4
    static XCN_CRYPT_RDN_ATTR_OID_GROUP_ID := 5
    static XCN_CRYPT_EXT_OR_ATTR_OID_GROUP_ID := 6
    static XCN_CRYPT_ENHKEY_USAGE_OID_GROUP_ID := 7
    static XCN_CRYPT_POLICY_OID_GROUP_ID := 8
    static XCN_CRYPT_TEMPLATE_OID_GROUP_ID := 9
    static XCN_CRYPT_KDF_OID_GROUP_ID := 10
    static XCN_CRYPT_LAST_OID_GROUP_ID := 10
    static XCN_CRYPT_FIRST_ALG_OID_GROUP_ID := 1
    static XCN_CRYPT_LAST_ALG_OID_GROUP_ID := 4
    static XCN_CRYPT_GROUP_ID_MASK := 65535
    static XCN_CRYPT_OID_PREFER_CNG_ALGID_FLAG := 1073741824
    static XCN_CRYPT_OID_DISABLE_SEARCH_DS_FLAG := -2147483648
    static XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK := 268369920
    static XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT := 16
    static XCN_CRYPT_KEY_LENGTH_MASK := 268369920
}
struct ObjectIdPublicKeyFlags extends Int32 {
    static XCN_CRYPT_OID_INFO_PUBKEY_ANY := 0
    static XCN_CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG := -2147483648
    static XCN_CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG := 1073741824
}
struct AlgorithmFlags extends Int32 {
    static AlgorithmFlagsNone := 0
    static AlgorithmFlagsWrap := 1
}
struct IObjectId extends IDispatch {
    static IID := "{728AB300-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromName(Name)
      => ComCall(7, this.p, CERTENROLL_OBJECTID, Name)
    InitializeFromValue(strValue)
      => ComCall(8, this.p, BSTR, strValue)
    InitializeFromAlgorithmName(GroupId, KeyFlags, AlgFlags, strAlgorithmName)
      => ComCall(9, this.p, ObjectIdGroupId, GroupId, ObjectIdPublicKeyFlags, KeyFlags, AlgorithmFlags, AlgFlags, BSTR, strAlgorithmName)
    get_Name(pValue)
      => ComCall(10, this.p, CERTENROLL_OBJECTID.Ptr, pValue)
    get_FriendlyName(pValue)
      => ComCall(11, this.p, BSTR.Ptr, pValue)
    put_FriendlyName(Value)
      => ComCall(12, this.p, BSTR, Value)
    get_Value(pValue)
      => ComCall(13, this.p, BSTR.Ptr, pValue)
    GetAlgorithmName(GroupId, KeyFlags, pstrAlgorithmName)
      => ComCall(14, this.p, ObjectIdGroupId, GroupId, ObjectIdPublicKeyFlags, KeyFlags, BSTR.Ptr, pstrAlgorithmName)
}
struct IObjectIds extends IDispatch {
    static IID := "{728AB301-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IObjectId.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IObjectId, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    AddRange(pValue?)
      => ComCall(13, this.p, IObjectIds, pValue?)
}
struct IBinaryConverter extends IDispatch {
    static IID := "{728AB302-217D-11DA-B2A4-000E7BBB2B09}"
    StringToString(strEncodedIn, EncodingIn, Encoding, pstrEncoded)
      => ComCall(7, this.p, BSTR, strEncodedIn, EncodingType, EncodingIn, EncodingType, Encoding, BSTR.Ptr, pstrEncoded)
    VariantByteArrayToString(pvarByteArray, Encoding, pstrEncoded)
      => ComCall(8, this.p, VARIANT.Ptr, pvarByteArray, EncodingType, Encoding, BSTR.Ptr, pstrEncoded)
    StringToVariantByteArray(strEncoded, Encoding, pvarByteArray)
      => ComCall(9, this.p, BSTR, strEncoded, EncodingType, Encoding, VARIANT.Ptr, pvarByteArray)
}
struct IBinaryConverter2 extends IBinaryConverter {
    static IID := "{8D7928B4-4E17-428D-9A17-728DF00D1B2B}"
    StringArrayToVariantArray(pvarStringArray, pvarVariantArray)
      => ComCall(10, this.p, VARIANT.Ptr, pvarStringArray, VARIANT.Ptr, pvarVariantArray)
    VariantArrayToStringArray(pvarVariantArray, pvarStringArray)
      => ComCall(11, this.p, VARIANT.Ptr, pvarVariantArray, VARIANT.Ptr, pvarStringArray)
}
struct X500NameFlags extends Int32 {
    static XCN_CERT_NAME_STR_NONE := 0
    static XCN_CERT_SIMPLE_NAME_STR := 1
    static XCN_CERT_OID_NAME_STR := 2
    static XCN_CERT_X500_NAME_STR := 3
    static XCN_CERT_XML_NAME_STR := 4
    static XCN_CERT_NAME_STR_SEMICOLON_FLAG := 1073741824
    static XCN_CERT_NAME_STR_NO_PLUS_FLAG := 536870912
    static XCN_CERT_NAME_STR_NO_QUOTING_FLAG := 268435456
    static XCN_CERT_NAME_STR_CRLF_FLAG := 134217728
    static XCN_CERT_NAME_STR_COMMA_FLAG := 67108864
    static XCN_CERT_NAME_STR_REVERSE_FLAG := 33554432
    static XCN_CERT_NAME_STR_FORWARD_FLAG := 16777216
    static XCN_CERT_NAME_STR_AMBIGUOUS_SEPARATOR_FLAGS := 1275068416
    static XCN_CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG := 65536
    static XCN_CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG := 131072
    static XCN_CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG := 262144
    static XCN_CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG := 524288
    static XCN_CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG := 1048576
    static XCN_CERT_NAME_STR_ENABLE_PUNYCODE_FLAG := 2097152
    static XCN_CERT_NAME_STR_DS_ESCAPED := 8388608
}
struct IX500DistinguishedName extends IDispatch {
    static IID := "{728AB303-217D-11DA-B2A4-000E7BBB2B09}"
    Decode(strEncodedName, Encoding, NameFlags)
      => ComCall(7, this.p, BSTR, strEncodedName, EncodingType, Encoding, X500NameFlags, NameFlags)
    Encode(strName, NameFlags)
      => ComCall(8, this.p, BSTR, strName, X500NameFlags, NameFlags)
    get_Name(pValue)
      => ComCall(9, this.p, BSTR.Ptr, pValue)
    get_EncodedName(Encoding, pValue)
      => ComCall(10, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct X509CertificateEnrollmentContext extends Int32 {
    static ContextNone := 0
    static ContextUser := 1
    static ContextMachine := 2
    static ContextAdministratorForceMachine := 3
}
struct EnrollmentEnrollStatus extends Int32 {
    static Enrolled := 1
    static EnrollPended := 2
    static EnrollUIDeferredEnrollmentRequired := 4
    static EnrollError := 16
    static EnrollUnknown := 32
    static EnrollSkipped := 64
    static EnrollDenied := 256
}
struct EnrollmentSelectionStatus extends Int32 {
    static SelectedNo := 0
    static SelectedYes := 1
}
struct EnrollmentDisplayStatus extends Int32 {
    static DisplayNo := 0
    static DisplayYes := 1
}
struct IX509EnrollmentStatus extends IDispatch {
    static IID := "{728AB304-217D-11DA-B2A4-000E7BBB2B09}"
    AppendText(strText)
      => ComCall(7, this.p, BSTR, strText)
    get_Text(pValue)
      => ComCall(8, this.p, BSTR.Ptr, pValue)
    put_Text(Value)
      => ComCall(9, this.p, BSTR, Value)
    get_Selected(pValue)
      => ComCall(10, this.p, EnrollmentSelectionStatus.Ptr, pValue)
    put_Selected(Value)
      => ComCall(11, this.p, EnrollmentSelectionStatus, Value)
    get_Display(pValue)
      => ComCall(12, this.p, EnrollmentDisplayStatus.Ptr, pValue)
    put_Display(Value)
      => ComCall(13, this.p, EnrollmentDisplayStatus, Value)
    get_Status(pValue)
      => ComCall(14, this.p, EnrollmentEnrollStatus.Ptr, pValue)
    put_Status(Value)
      => ComCall(15, this.p, EnrollmentEnrollStatus, Value)
    get_Error(pValue)
      => ComCall(16, this.p, HRESULT.Ptr, pValue)
    put_Error(Value)
      => ComCall(17, this.p, HRESULT, Value)
    get_ErrorText(pValue)
      => ComCall(18, this.p, BSTR.Ptr, pValue)
}
struct X509ProviderType extends Int32 {
    static XCN_PROV_NONE := 0
    static XCN_PROV_RSA_FULL := 1
    static XCN_PROV_RSA_SIG := 2
    static XCN_PROV_DSS := 3
    static XCN_PROV_FORTEZZA := 4
    static XCN_PROV_MS_EXCHANGE := 5
    static XCN_PROV_SSL := 6
    static XCN_PROV_RSA_SCHANNEL := 12
    static XCN_PROV_DSS_DH := 13
    static XCN_PROV_EC_ECDSA_SIG := 14
    static XCN_PROV_EC_ECNRA_SIG := 15
    static XCN_PROV_EC_ECDSA_FULL := 16
    static XCN_PROV_EC_ECNRA_FULL := 17
    static XCN_PROV_DH_SCHANNEL := 18
    static XCN_PROV_SPYRUS_LYNKS := 20
    static XCN_PROV_RNG := 21
    static XCN_PROV_INTEL_SEC := 22
    static XCN_PROV_REPLACE_OWF := 23
    static XCN_PROV_RSA_AES := 24
}
struct AlgorithmType extends Int32 {
    static XCN_BCRYPT_UNKNOWN_INTERFACE := 0
    static XCN_BCRYPT_CIPHER_INTERFACE := 1
    static XCN_BCRYPT_HASH_INTERFACE := 2
    static XCN_BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE := 3
    static XCN_BCRYPT_SIGNATURE_INTERFACE := 5
    static XCN_BCRYPT_SECRET_AGREEMENT_INTERFACE := 4
    static XCN_BCRYPT_RNG_INTERFACE := 6
    static XCN_BCRYPT_KEY_DERIVATION_INTERFACE := 7
}
struct AlgorithmOperationFlags extends Int32 {
    static XCN_NCRYPT_NO_OPERATION := 0
    static XCN_NCRYPT_CIPHER_OPERATION := 1
    static XCN_NCRYPT_HASH_OPERATION := 2
    static XCN_NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION := 4
    static XCN_NCRYPT_SECRET_AGREEMENT_OPERATION := 8
    static XCN_NCRYPT_SIGNATURE_OPERATION := 16
    static XCN_NCRYPT_RNG_OPERATION := 32
    static XCN_NCRYPT_KEY_DERIVATION_OPERATION := 64
    static XCN_NCRYPT_KEY_ENCAPSULATION_OPERATION := 128
    static XCN_NCRYPT_ANY_ASYMMETRIC_OPERATION := 156
    static XCN_NCRYPT_PREFER_SIGNATURE_ONLY_OPERATION := 2097152
    static XCN_NCRYPT_PREFER_NON_SIGNATURE_OPERATION := 4194304
    static XCN_NCRYPT_EXACT_MATCH_OPERATION := 8388608
    static XCN_NCRYPT_PREFERENCE_MASK_OPERATION := 14680064
}
struct ICspAlgorithm extends IDispatch {
    static IID := "{728AB305-217D-11DA-B2A4-000E7BBB2B09}"
    GetAlgorithmOid(Length, AlgFlags, ppValue)
      => ComCall(7, this.p, Int32, Length, AlgorithmFlags, AlgFlags, IObjectId.Ptr, ppValue)
    get_DefaultLength(pValue)
      => ComCall(8, this.p, Int32.Ptr, pValue)
    get_IncrementLength(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
    get_LongName(pValue)
      => ComCall(10, this.p, BSTR.Ptr, pValue)
    get_Valid(pValue)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pValue)
    get_MaxLength(pValue)
      => ComCall(12, this.p, Int32.Ptr, pValue)
    get_MinLength(pValue)
      => ComCall(13, this.p, Int32.Ptr, pValue)
    get_Name(pValue)
      => ComCall(14, this.p, BSTR.Ptr, pValue)
    get_Type(pValue)
      => ComCall(15, this.p, AlgorithmType.Ptr, pValue)
    get_Operations(pValue)
      => ComCall(16, this.p, AlgorithmOperationFlags.Ptr, pValue)
}
struct ICspAlgorithms extends IDispatch {
    static IID := "{728AB306-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICspAlgorithm.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICspAlgorithm, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_ItemByName(strName, ppValue)
      => ComCall(13, this.p, BSTR, strName, ICspAlgorithm.Ptr, ppValue)
    get_IndexByObjectId(pObjectId?, pIndex)
      => ComCall(14, this.p, IObjectId, pObjectId?, Int32.Ptr, pIndex)
}
struct X509KeySpec extends Int32 {
    static XCN_AT_NONE := 0
    static XCN_AT_KEYEXCHANGE := 1
    static XCN_AT_SIGNATURE := 2
}
struct ICspInformation extends IDispatch {
    static IID := "{728AB307-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromName(strName)
      => ComCall(7, this.p, BSTR, strName)
    InitializeFromType(Type, pAlgorithm?, MachineContext)
      => ComCall(8, this.p, X509ProviderType, Type, IObjectId, pAlgorithm?, VARIANT_BOOL, MachineContext)
    get_CspAlgorithms(ppValue)
      => ComCall(9, this.p, ICspAlgorithms.Ptr, ppValue)
    get_HasHardwareRandomNumberGenerator(pValue)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pValue)
    get_IsHardwareDevice(pValue)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pValue)
    get_IsRemovable(pValue)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pValue)
    get_IsSoftwareDevice(pValue)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pValue)
    get_Valid(pValue)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pValue)
    get_MaxKeyContainerNameLength(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
    get_Name(pValue)
      => ComCall(16, this.p, BSTR.Ptr, pValue)
    get_Type(pValue)
      => ComCall(17, this.p, X509ProviderType.Ptr, pValue)
    get_Version(pValue)
      => ComCall(18, this.p, Int32.Ptr, pValue)
    get_KeySpec(pValue)
      => ComCall(19, this.p, X509KeySpec.Ptr, pValue)
    get_IsSmartCard(pValue)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, pValue)
    GetDefaultSecurityDescriptor(MachineContext, pValue)
      => ComCall(21, this.p, VARIANT_BOOL, MachineContext, BSTR.Ptr, pValue)
    get_LegacyCsp(pValue)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, pValue)
    GetCspStatusFromOperations(pAlgorithm?, Operations, ppValue)
      => ComCall(23, this.p, IObjectId, pAlgorithm?, AlgorithmOperationFlags, Operations, ICspStatus.Ptr, ppValue)
}
struct ICspInformations extends IDispatch {
    static IID := "{728AB308-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICspInformation.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICspInformation, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    AddAvailableCsps()
      => ComCall(13, this.p)
    get_ItemByName(strName, ppCspInformation)
      => ComCall(14, this.p, BSTR, strName, ICspInformation.Ptr, ppCspInformation)
    GetCspStatusFromProviderName(strProviderName, LegacyKeySpec, ppValue)
      => ComCall(15, this.p, BSTR, strProviderName, X509KeySpec, LegacyKeySpec, ICspStatus.Ptr, ppValue)
    GetCspStatusesFromOperations(Operations, pCspInformation?, ppValue)
      => ComCall(16, this.p, AlgorithmOperationFlags, Operations, ICspInformation, pCspInformation?, ICspStatuses.Ptr, ppValue)
    GetEncryptionCspAlgorithms(pCspInformation?, ppValue)
      => ComCall(17, this.p, ICspInformation, pCspInformation?, ICspAlgorithms.Ptr, ppValue)
    GetHashAlgorithms(pCspInformation?, ppValue)
      => ComCall(18, this.p, ICspInformation, pCspInformation?, IObjectIds.Ptr, ppValue)
}
struct ICspStatus extends IDispatch {
    static IID := "{728AB309-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pCsp?, pAlgorithm?)
      => ComCall(7, this.p, ICspInformation, pCsp?, ICspAlgorithm, pAlgorithm?)
    get_Ordinal(pValue)
      => ComCall(8, this.p, Int32.Ptr, pValue)
    put_Ordinal(Value)
      => ComCall(9, this.p, Int32, Value)
    get_CspAlgorithm(ppValue)
      => ComCall(10, this.p, ICspAlgorithm.Ptr, ppValue)
    get_CspInformation(ppValue)
      => ComCall(11, this.p, ICspInformation.Ptr, ppValue)
    get_EnrollmentStatus(ppValue)
      => ComCall(12, this.p, IX509EnrollmentStatus.Ptr, ppValue)
    get_DisplayName(pValue)
      => ComCall(13, this.p, BSTR.Ptr, pValue)
}
struct ICspStatuses extends IDispatch {
    static IID := "{728AB30A-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICspStatus.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICspStatus, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_ItemByName(strCspName, strAlgorithmName, ppValue)
      => ComCall(13, this.p, BSTR, strCspName, BSTR, strAlgorithmName, ICspStatus.Ptr, ppValue)
    get_ItemByOrdinal(Ordinal, ppValue)
      => ComCall(14, this.p, Int32, Ordinal, ICspStatus.Ptr, ppValue)
    get_ItemByOperations(strCspName, strAlgorithmName, Operations, ppValue)
      => ComCall(15, this.p, BSTR, strCspName, BSTR, strAlgorithmName, AlgorithmOperationFlags, Operations, ICspStatus.Ptr, ppValue)
    get_ItemByProvider(pCspStatus?, ppValue)
      => ComCall(16, this.p, ICspStatus, pCspStatus?, ICspStatus.Ptr, ppValue)
}
struct KeyIdentifierHashAlgorithm extends Int32 {
    static SKIHashDefault := 0
    static SKIHashSha1 := 1
    static SKIHashCapiSha1 := 2
    static SKIHashSha256 := 3
    static SKIHashHPKP := 5
}
struct IX509PublicKey extends IDispatch {
    static IID := "{728AB30B-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pObjectId?, strEncodedKey, strEncodedParameters, Encoding)
      => ComCall(7, this.p, IObjectId, pObjectId?, BSTR, strEncodedKey, BSTR, strEncodedParameters, EncodingType, Encoding)
    InitializeFromEncodedPublicKeyInfo(strEncodedPublicKeyInfo, Encoding)
      => ComCall(8, this.p, BSTR, strEncodedPublicKeyInfo, EncodingType, Encoding)
    get_Algorithm(ppValue)
      => ComCall(9, this.p, IObjectId.Ptr, ppValue)
    get_Length(pValue)
      => ComCall(10, this.p, Int32.Ptr, pValue)
    get_EncodedKey(Encoding, pValue)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_EncodedParameters(Encoding, pValue)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    ComputeKeyIdentifier(Algorithm, Encoding, pValue)
      => ComCall(13, this.p, KeyIdentifierHashAlgorithm, Algorithm, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct X509PrivateKeyExportFlags extends Int32 {
    static XCN_NCRYPT_ALLOW_EXPORT_NONE := 0
    static XCN_NCRYPT_ALLOW_EXPORT_FLAG := 1
    static XCN_NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG := 2
    static XCN_NCRYPT_ALLOW_ARCHIVING_FLAG := 4
    static XCN_NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG := 8
}
struct X509PrivateKeyUsageFlags extends Int32 {
    static XCN_NCRYPT_ALLOW_USAGES_NONE := 0
    static XCN_NCRYPT_ALLOW_DECRYPT_FLAG := 1
    static XCN_NCRYPT_ALLOW_SIGNING_FLAG := 2
    static XCN_NCRYPT_ALLOW_KEY_AGREEMENT_FLAG := 4
    static XCN_NCRYPT_ALLOW_KEY_IMPORT_FLAG := 8
    static XCN_NCRYPT_ALLOW_ALL_USAGES := 16777215
}
struct X509PrivateKeyProtection extends Int32 {
    static XCN_NCRYPT_UI_NO_PROTECTION_FLAG := 0
    static XCN_NCRYPT_UI_PROTECT_KEY_FLAG := 1
    static XCN_NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG := 2
    static XCN_NCRYPT_UI_FINGERPRINT_PROTECTION_FLAG := 4
    static XCN_NCRYPT_UI_APPCONTAINER_ACCESS_MEDIUM_FLAG := 8
}
struct X509PrivateKeyVerify extends Int32 {
    static VerifyNone := 0
    static VerifySilent := 1
    static VerifySmartCardNone := 2
    static VerifySmartCardSilent := 3
    static VerifyAllowUI := 4
}
struct IX509PrivateKey extends IDispatch {
    static IID := "{728AB30C-217D-11DA-B2A4-000E7BBB2B09}"
    Open()
      => ComCall(7, this.p)
    Create()
      => ComCall(8, this.p)
    Close()
      => ComCall(9, this.p)
    Delete()
      => ComCall(10, this.p)
    Verify(VerifyType)
      => ComCall(11, this.p, X509PrivateKeyVerify, VerifyType)
    Import(strExportType, strEncodedKey, Encoding)
      => ComCall(12, this.p, BSTR, strExportType, BSTR, strEncodedKey, EncodingType, Encoding)
    Export(strExportType, Encoding, pstrEncodedKey)
      => ComCall(13, this.p, BSTR, strExportType, EncodingType, Encoding, BSTR.Ptr, pstrEncodedKey)
    ExportPublicKey(ppPublicKey)
      => ComCall(14, this.p, IX509PublicKey.Ptr, ppPublicKey)
    get_ContainerName(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
    put_ContainerName(Value)
      => ComCall(16, this.p, BSTR, Value)
    get_ContainerNamePrefix(pValue)
      => ComCall(17, this.p, BSTR.Ptr, pValue)
    put_ContainerNamePrefix(Value)
      => ComCall(18, this.p, BSTR, Value)
    get_ReaderName(pValue)
      => ComCall(19, this.p, BSTR.Ptr, pValue)
    put_ReaderName(Value)
      => ComCall(20, this.p, BSTR, Value)
    get_CspInformations(ppValue)
      => ComCall(21, this.p, ICspInformations.Ptr, ppValue)
    put_CspInformations(pValue?)
      => ComCall(22, this.p, ICspInformations, pValue?)
    get_CspStatus(ppValue)
      => ComCall(23, this.p, ICspStatus.Ptr, ppValue)
    put_CspStatus(pValue?)
      => ComCall(24, this.p, ICspStatus, pValue?)
    get_ProviderName(pValue)
      => ComCall(25, this.p, BSTR.Ptr, pValue)
    put_ProviderName(Value)
      => ComCall(26, this.p, BSTR, Value)
    get_ProviderType(pValue)
      => ComCall(27, this.p, X509ProviderType.Ptr, pValue)
    put_ProviderType(Value)
      => ComCall(28, this.p, X509ProviderType, Value)
    get_LegacyCsp(pValue)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pValue)
    put_LegacyCsp(Value)
      => ComCall(30, this.p, VARIANT_BOOL, Value)
    get_Algorithm(ppValue)
      => ComCall(31, this.p, IObjectId.Ptr, ppValue)
    put_Algorithm(pValue?)
      => ComCall(32, this.p, IObjectId, pValue?)
    get_KeySpec(pValue)
      => ComCall(33, this.p, X509KeySpec.Ptr, pValue)
    put_KeySpec(Value)
      => ComCall(34, this.p, X509KeySpec, Value)
    get_Length(pValue)
      => ComCall(35, this.p, Int32.Ptr, pValue)
    put_Length(Value)
      => ComCall(36, this.p, Int32, Value)
    get_ExportPolicy(pValue)
      => ComCall(37, this.p, X509PrivateKeyExportFlags.Ptr, pValue)
    put_ExportPolicy(Value)
      => ComCall(38, this.p, X509PrivateKeyExportFlags, Value)
    get_KeyUsage(pValue)
      => ComCall(39, this.p, X509PrivateKeyUsageFlags.Ptr, pValue)
    put_KeyUsage(Value)
      => ComCall(40, this.p, X509PrivateKeyUsageFlags, Value)
    get_KeyProtection(pValue)
      => ComCall(41, this.p, X509PrivateKeyProtection.Ptr, pValue)
    put_KeyProtection(Value)
      => ComCall(42, this.p, X509PrivateKeyProtection, Value)
    get_MachineContext(pValue)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pValue)
    put_MachineContext(Value)
      => ComCall(44, this.p, VARIANT_BOOL, Value)
    get_SecurityDescriptor(pValue)
      => ComCall(45, this.p, BSTR.Ptr, pValue)
    put_SecurityDescriptor(Value)
      => ComCall(46, this.p, BSTR, Value)
    get_Certificate(Encoding, pValue)
      => ComCall(47, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_Certificate(Encoding, Value)
      => ComCall(48, this.p, EncodingType, Encoding, BSTR, Value)
    get_UniqueContainerName(pValue)
      => ComCall(49, this.p, BSTR.Ptr, pValue)
    get_Opened(pValue)
      => ComCall(50, this.p, VARIANT_BOOL.Ptr, pValue)
    get_DefaultContainer(pValue)
      => ComCall(51, this.p, VARIANT_BOOL.Ptr, pValue)
    get_Existing(pValue)
      => ComCall(52, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Existing(Value)
      => ComCall(53, this.p, VARIANT_BOOL, Value)
    get_Silent(pValue)
      => ComCall(54, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Silent(Value)
      => ComCall(55, this.p, VARIANT_BOOL, Value)
    get_ParentWindow(pValue)
      => ComCall(56, this.p, Int32.Ptr, pValue)
    put_ParentWindow(Value)
      => ComCall(57, this.p, Int32, Value)
    get_UIContextMessage(pValue)
      => ComCall(58, this.p, BSTR.Ptr, pValue)
    put_UIContextMessage(Value)
      => ComCall(59, this.p, BSTR, Value)
    put_Pin(Value)
      => ComCall(60, this.p, BSTR, Value)
    get_FriendlyName(pValue)
      => ComCall(61, this.p, BSTR.Ptr, pValue)
    put_FriendlyName(Value)
      => ComCall(62, this.p, BSTR, Value)
    get_Description(pValue)
      => ComCall(63, this.p, BSTR.Ptr, pValue)
    put_Description(Value)
      => ComCall(64, this.p, BSTR, Value)
}
struct X509HardwareKeyUsageFlags extends Int32 {
    static XCN_NCRYPT_PCP_NONE := 0
    static XCN_NCRYPT_TPM12_PROVIDER := 65536
    static XCN_NCRYPT_PCP_SIGNATURE_KEY := 1
    static XCN_NCRYPT_PCP_ENCRYPTION_KEY := 2
    static XCN_NCRYPT_PCP_GENERIC_KEY := 3
    static XCN_NCRYPT_PCP_STORAGE_KEY := 4
    static XCN_NCRYPT_PCP_IDENTITY_KEY := 8
}
struct X509KeyParametersExportType extends Int32 {
    static XCN_CRYPT_OID_USE_CURVE_NONE := 0
    static XCN_CRYPT_OID_USE_CURVE_NAME_FOR_ENCODE_FLAG := 536870912
    static XCN_CRYPT_OID_USE_CURVE_PARAMETERS_FOR_ENCODE_FLAG := 268435456
}
struct IX509PrivateKey2 extends IX509PrivateKey {
    static IID := "{728AB362-217D-11DA-B2A4-000E7BBB2B09}"
    get_HardwareKeyUsage(pValue)
      => ComCall(65, this.p, X509HardwareKeyUsageFlags.Ptr, pValue)
    put_HardwareKeyUsage(Value)
      => ComCall(66, this.p, X509HardwareKeyUsageFlags, Value)
    get_AlternateStorageLocation(pValue)
      => ComCall(67, this.p, BSTR.Ptr, pValue)
    put_AlternateStorageLocation(Value)
      => ComCall(68, this.p, BSTR, Value)
    get_AlgorithmName(pValue)
      => ComCall(69, this.p, BSTR.Ptr, pValue)
    put_AlgorithmName(Value)
      => ComCall(70, this.p, BSTR, Value)
    get_AlgorithmParameters(Encoding, pValue)
      => ComCall(71, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_AlgorithmParameters(Encoding, Value)
      => ComCall(72, this.p, EncodingType, Encoding, BSTR, Value)
    get_ParametersExportType(pValue)
      => ComCall(73, this.p, X509KeyParametersExportType.Ptr, pValue)
    put_ParametersExportType(Value)
      => ComCall(74, this.p, X509KeyParametersExportType, Value)
}
struct IX509EndorsementKey extends IDispatch {
    static IID := "{B11CD855-F4C4-4FC6-B710-4422237F09E9}"
    get_ProviderName(pValue)
      => ComCall(7, this.p, BSTR.Ptr, pValue)
    put_ProviderName(Value)
      => ComCall(8, this.p, BSTR, Value)
    get_Length(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
    get_Opened(pValue)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pValue)
    AddCertificate(Encoding, strCertificate)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strCertificate)
    RemoveCertificate(Encoding, strCertificate)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR, strCertificate)
    GetCertificateByIndex(ManufacturerOnly, dwIndex, Encoding, pValue)
      => ComCall(13, this.p, VARIANT_BOOL, ManufacturerOnly, Int32, dwIndex, EncodingType, Encoding, BSTR.Ptr, pValue)
    GetCertificateCount(ManufacturerOnly, pCount)
      => ComCall(14, this.p, VARIANT_BOOL, ManufacturerOnly, Int32.Ptr, pCount)
    ExportPublicKey(ppPublicKey)
      => ComCall(15, this.p, IX509PublicKey.Ptr, ppPublicKey)
    Open()
      => ComCall(16, this.p)
    Close()
      => ComCall(17, this.p)
}
struct IX509Extension extends IDispatch {
    static IID := "{728AB30D-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pObjectId?, Encoding, strEncodedData)
      => ComCall(7, this.p, IObjectId, pObjectId?, EncodingType, Encoding, BSTR, strEncodedData)
    get_ObjectId(ppValue)
      => ComCall(8, this.p, IObjectId.Ptr, ppValue)
    get_RawData(Encoding, pValue)
      => ComCall(9, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Critical(pValue)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Critical(Value)
      => ComCall(11, this.p, VARIANT_BOOL, Value)
}
struct IX509Extensions extends IDispatch {
    static IID := "{728AB30E-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509Extension.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509Extension, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_IndexByObjectId(pObjectId?, pIndex)
      => ComCall(13, this.p, IObjectId, pObjectId?, Int32.Ptr, pIndex)
    AddRange(pValue?)
      => ComCall(14, this.p, IX509Extensions, pValue?)
}
struct X509KeyUsageFlags extends Int32 {
    static XCN_CERT_NO_KEY_USAGE := 0
    static XCN_CERT_DIGITAL_SIGNATURE_KEY_USAGE := 128
    static XCN_CERT_NON_REPUDIATION_KEY_USAGE := 64
    static XCN_CERT_KEY_ENCIPHERMENT_KEY_USAGE := 32
    static XCN_CERT_DATA_ENCIPHERMENT_KEY_USAGE := 16
    static XCN_CERT_KEY_AGREEMENT_KEY_USAGE := 8
    static XCN_CERT_KEY_CERT_SIGN_KEY_USAGE := 4
    static XCN_CERT_OFFLINE_CRL_SIGN_KEY_USAGE := 2
    static XCN_CERT_CRL_SIGN_KEY_USAGE := 2
    static XCN_CERT_ENCIPHER_ONLY_KEY_USAGE := 1
    static XCN_CERT_DECIPHER_ONLY_KEY_USAGE := 32768
}
struct IX509ExtensionKeyUsage extends IX509Extension {
    static IID := "{728AB30F-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(UsageFlags)
      => ComCall(12, this.p, X509KeyUsageFlags, UsageFlags)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_KeyUsage(pValue)
      => ComCall(14, this.p, X509KeyUsageFlags.Ptr, pValue)
}
struct IX509ExtensionEnhancedKeyUsage extends IX509Extension {
    static IID := "{728AB310-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pValue?)
      => ComCall(12, this.p, IObjectIds, pValue?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_EnhancedKeyUsage(ppValue)
      => ComCall(14, this.p, IObjectIds.Ptr, ppValue)
}
struct IX509ExtensionTemplateName extends IX509Extension {
    static IID := "{728AB311-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(strTemplateName)
      => ComCall(12, this.p, BSTR, strTemplateName)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_TemplateName(pValue)
      => ComCall(14, this.p, BSTR.Ptr, pValue)
}
struct IX509ExtensionTemplate extends IX509Extension {
    static IID := "{728AB312-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pTemplateOid?, MajorVersion, MinorVersion)
      => ComCall(12, this.p, IObjectId, pTemplateOid?, Int32, MajorVersion, Int32, MinorVersion)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_TemplateOid(ppValue)
      => ComCall(14, this.p, IObjectId.Ptr, ppValue)
    get_MajorVersion(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
    get_MinorVersion(pValue)
      => ComCall(16, this.p, Int32.Ptr, pValue)
}
struct AlternativeNameType extends Int32 {
    static XCN_CERT_ALT_NAME_UNKNOWN := 0
    static XCN_CERT_ALT_NAME_OTHER_NAME := 1
    static XCN_CERT_ALT_NAME_RFC822_NAME := 2
    static XCN_CERT_ALT_NAME_DNS_NAME := 3
    static XCN_CERT_ALT_NAME_X400_ADDRESS := 4
    static XCN_CERT_ALT_NAME_DIRECTORY_NAME := 5
    static XCN_CERT_ALT_NAME_EDI_PARTY_NAME := 6
    static XCN_CERT_ALT_NAME_URL := 7
    static XCN_CERT_ALT_NAME_IP_ADDRESS := 8
    static XCN_CERT_ALT_NAME_REGISTERED_ID := 9
    static XCN_CERT_ALT_NAME_GUID := 10
    static XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME := 11
}
struct IAlternativeName extends IDispatch {
    static IID := "{728AB313-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromString(Type, strValue)
      => ComCall(7, this.p, AlternativeNameType, Type, BSTR, strValue)
    InitializeFromRawData(Type, Encoding, strRawData)
      => ComCall(8, this.p, AlternativeNameType, Type, EncodingType, Encoding, BSTR, strRawData)
    InitializeFromOtherName(pObjectId?, Encoding, strRawData, ToBeWrapped)
      => ComCall(9, this.p, IObjectId, pObjectId?, EncodingType, Encoding, BSTR, strRawData, VARIANT_BOOL, ToBeWrapped)
    get_Type(pValue)
      => ComCall(10, this.p, AlternativeNameType.Ptr, pValue)
    get_StrValue(pValue)
      => ComCall(11, this.p, BSTR.Ptr, pValue)
    get_ObjectId(ppValue)
      => ComCall(12, this.p, IObjectId.Ptr, ppValue)
    get_RawData(Encoding, pValue)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IAlternativeNames extends IDispatch {
    static IID := "{728AB314-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IAlternativeName.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IAlternativeName, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
}
struct IX509ExtensionAlternativeNames extends IX509Extension {
    static IID := "{728AB315-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pValue?)
      => ComCall(12, this.p, IAlternativeNames, pValue?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_AlternativeNames(ppValue)
      => ComCall(14, this.p, IAlternativeNames.Ptr, ppValue)
}
struct IX509ExtensionBasicConstraints extends IX509Extension {
    static IID := "{728AB316-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(IsCA, PathLenConstraint)
      => ComCall(12, this.p, VARIANT_BOOL, IsCA, Int32, PathLenConstraint)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_IsCA(pValue)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pValue)
    get_PathLenConstraint(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
}
struct IX509ExtensionSubjectKeyIdentifier extends IX509Extension {
    static IID := "{728AB317-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(Encoding, strKeyIdentifier)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR, strKeyIdentifier)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_SubjectKeyIdentifier(Encoding, pValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IX509ExtensionAuthorityKeyIdentifier extends IX509Extension {
    static IID := "{728AB318-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(Encoding, strKeyIdentifier)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR, strKeyIdentifier)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_AuthorityKeyIdentifier(Encoding, pValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct ISmimeCapability extends IDispatch {
    static IID := "{728AB319-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pObjectId?, BitCount)
      => ComCall(7, this.p, IObjectId, pObjectId?, Int32, BitCount)
    get_ObjectId(ppValue)
      => ComCall(8, this.p, IObjectId.Ptr, ppValue)
    get_BitCount(pValue)
      => ComCall(9, this.p, Int32.Ptr, pValue)
}
struct ISmimeCapabilities extends IDispatch {
    static IID := "{728AB31A-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ISmimeCapability.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ISmimeCapability, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    AddFromCsp(pValue?)
      => ComCall(13, this.p, ICspInformation, pValue?)
    AddAvailableSmimeCapabilities(MachineContext)
      => ComCall(14, this.p, VARIANT_BOOL, MachineContext)
}
struct IX509ExtensionSmimeCapabilities extends IX509Extension {
    static IID := "{728AB31B-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pValue?)
      => ComCall(12, this.p, ISmimeCapabilities, pValue?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_SmimeCapabilities(ppValue)
      => ComCall(14, this.p, ISmimeCapabilities.Ptr, ppValue)
}
struct PolicyQualifierType extends Int32 {
    static PolicyQualifierTypeUnknown := 0
    static PolicyQualifierTypeUrl := 1
    static PolicyQualifierTypeUserNotice := 2
    static PolicyQualifierTypeFlags := 3
}
struct IPolicyQualifier extends IDispatch {
    static IID := "{728AB31C-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(strQualifier, Type)
      => ComCall(7, this.p, BSTR, strQualifier, PolicyQualifierType, Type)
    get_ObjectId(ppValue)
      => ComCall(8, this.p, IObjectId.Ptr, ppValue)
    get_Qualifier(pValue)
      => ComCall(9, this.p, BSTR.Ptr, pValue)
    get_Type(pValue)
      => ComCall(10, this.p, PolicyQualifierType.Ptr, pValue)
    get_RawData(Encoding, pValue)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IPolicyQualifiers extends IDispatch {
    static IID := "{728AB31D-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IPolicyQualifier.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IPolicyQualifier, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
}
struct ICertificatePolicy extends IDispatch {
    static IID := "{728AB31E-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pValue?)
      => ComCall(7, this.p, IObjectId, pValue?)
    get_ObjectId(ppValue)
      => ComCall(8, this.p, IObjectId.Ptr, ppValue)
    get_PolicyQualifiers(ppValue)
      => ComCall(9, this.p, IPolicyQualifiers.Ptr, ppValue)
}
struct ICertificatePolicies extends IDispatch {
    static IID := "{728AB31F-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICertificatePolicy.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICertificatePolicy, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
}
struct IX509ExtensionCertificatePolicies extends IX509Extension {
    static IID := "{728AB320-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pValue?)
      => ComCall(12, this.p, ICertificatePolicies, pValue?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_Policies(ppValue)
      => ComCall(14, this.p, ICertificatePolicies.Ptr, ppValue)
}
struct IX509ExtensionMSApplicationPolicies extends IX509Extension {
    static IID := "{728AB321-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pValue?)
      => ComCall(12, this.p, ICertificatePolicies, pValue?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_Policies(ppValue)
      => ComCall(14, this.p, ICertificatePolicies.Ptr, ppValue)
}
struct IX509Attribute extends IDispatch {
    static IID := "{728AB322-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pObjectId?, Encoding, strEncodedData)
      => ComCall(7, this.p, IObjectId, pObjectId?, EncodingType, Encoding, BSTR, strEncodedData)
    get_ObjectId(ppValue)
      => ComCall(8, this.p, IObjectId.Ptr, ppValue)
    get_RawData(Encoding, pValue)
      => ComCall(9, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IX509Attributes extends IDispatch {
    static IID := "{728AB323-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509Attribute.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509Attribute, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
}
struct IX509AttributeExtensions extends IX509Attribute {
    static IID := "{728AB324-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pExtensions?)
      => ComCall(10, this.p, IX509Extensions, pExtensions?)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_X509Extensions(ppValue)
      => ComCall(12, this.p, IX509Extensions.Ptr, ppValue)
}
struct RequestClientInfoClientId extends Int32 {
    static ClientIdNone := 0
    static ClientIdXEnroll2003 := 1
    static ClientIdAutoEnroll2003 := 2
    static ClientIdWizard2003 := 3
    static ClientIdCertReq2003 := 4
    static ClientIdDefaultRequest := 5
    static ClientIdAutoEnroll := 6
    static ClientIdRequestWizard := 7
    static ClientIdEOBO := 8
    static ClientIdCertReq := 9
    static ClientIdTest := 10
    static ClientIdWinRT := 11
    static ClientIdUserStart := 1000
}
struct IX509AttributeClientId extends IX509Attribute {
    static IID := "{728AB325-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(ClientId, strMachineDnsName, strUserSamName, strProcessName)
      => ComCall(10, this.p, RequestClientInfoClientId, ClientId, BSTR, strMachineDnsName, BSTR, strUserSamName, BSTR, strProcessName)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_ClientId(pValue)
      => ComCall(12, this.p, RequestClientInfoClientId.Ptr, pValue)
    get_MachineDnsName(pValue)
      => ComCall(13, this.p, BSTR.Ptr, pValue)
    get_UserSamName(pValue)
      => ComCall(14, this.p, BSTR.Ptr, pValue)
    get_ProcessName(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
}
struct IX509AttributeRenewalCertificate extends IX509Attribute {
    static IID := "{728AB326-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(Encoding, strCert)
      => ComCall(10, this.p, EncodingType, Encoding, BSTR, strCert)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_RenewalCertificate(Encoding, pValue)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IX509AttributeArchiveKey extends IX509Attribute {
    static IID := "{728AB327-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(pKey?, Encoding, strCAXCert, pAlgorithm?, EncryptionStrength)
      => ComCall(10, this.p, IX509PrivateKey, pKey?, EncodingType, Encoding, BSTR, strCAXCert, IObjectId, pAlgorithm?, Int32, EncryptionStrength)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_EncryptedKeyBlob(Encoding, pValue)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_EncryptionAlgorithm(ppValue)
      => ComCall(13, this.p, IObjectId.Ptr, ppValue)
    get_EncryptionStrength(pValue)
      => ComCall(14, this.p, Int32.Ptr, pValue)
}
struct IX509AttributeArchiveKeyHash extends IX509Attribute {
    static IID := "{728AB328-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncodeFromEncryptedKeyBlob(Encoding, strEncryptedKeyBlob)
      => ComCall(10, this.p, EncodingType, Encoding, BSTR, strEncryptedKeyBlob)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_EncryptedKeyHashBlob(Encoding, pValue)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct IX509AttributeOSVersion extends IX509Attribute {
    static IID := "{728AB32A-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(strOSVersion)
      => ComCall(10, this.p, BSTR, strOSVersion)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_OSVersion(pValue)
      => ComCall(12, this.p, BSTR.Ptr, pValue)
}
struct IX509AttributeCspProvider extends IX509Attribute {
    static IID := "{728AB32B-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeEncode(KeySpec, strProviderName, Encoding, strSignature)
      => ComCall(10, this.p, X509KeySpec, KeySpec, BSTR, strProviderName, EncodingType, Encoding, BSTR, strSignature)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_KeySpec(pValue)
      => ComCall(12, this.p, X509KeySpec.Ptr, pValue)
    get_ProviderName(pValue)
      => ComCall(13, this.p, BSTR.Ptr, pValue)
    get_Signature(Encoding, pValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct ICryptAttribute extends IDispatch {
    static IID := "{728AB32C-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromObjectId(pObjectId?)
      => ComCall(7, this.p, IObjectId, pObjectId?)
    InitializeFromValues(pAttributes?)
      => ComCall(8, this.p, IX509Attributes, pAttributes?)
    get_ObjectId(ppValue)
      => ComCall(9, this.p, IObjectId.Ptr, ppValue)
    get_Values(ppValue)
      => ComCall(10, this.p, IX509Attributes.Ptr, ppValue)
}
struct ICryptAttributes extends IDispatch {
    static IID := "{728AB32D-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICryptAttribute.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICryptAttribute, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_IndexByObjectId(pObjectId?, pIndex)
      => ComCall(13, this.p, IObjectId, pObjectId?, Int32.Ptr, pIndex)
    AddRange(pValue?)
      => ComCall(14, this.p, ICryptAttributes, pValue?)
}
struct CERTENROLL_PROPERTYID extends Int32 {
    static XCN_PROPERTYID_NONE := 0
    static XCN_CERT_KEY_PROV_HANDLE_PROP_ID := 1
    static XCN_CERT_KEY_PROV_INFO_PROP_ID := 2
    static XCN_CERT_SHA1_HASH_PROP_ID := 3
    static XCN_CERT_MD5_HASH_PROP_ID := 4
    static XCN_CERT_HASH_PROP_ID := 3
    static XCN_CERT_KEY_CONTEXT_PROP_ID := 5
    static XCN_CERT_KEY_SPEC_PROP_ID := 6
    static XCN_CERT_IE30_RESERVED_PROP_ID := 7
    static XCN_CERT_PUBKEY_HASH_RESERVED_PROP_ID := 8
    static XCN_CERT_ENHKEY_USAGE_PROP_ID := 9
    static XCN_CERT_CTL_USAGE_PROP_ID := 9
    static XCN_CERT_NEXT_UPDATE_LOCATION_PROP_ID := 10
    static XCN_CERT_FRIENDLY_NAME_PROP_ID := 11
    static XCN_CERT_PVK_FILE_PROP_ID := 12
    static XCN_CERT_DESCRIPTION_PROP_ID := 13
    static XCN_CERT_ACCESS_STATE_PROP_ID := 14
    static XCN_CERT_SIGNATURE_HASH_PROP_ID := 15
    static XCN_CERT_SMART_CARD_DATA_PROP_ID := 16
    static XCN_CERT_EFS_PROP_ID := 17
    static XCN_CERT_FORTEZZA_DATA_PROP_ID := 18
    static XCN_CERT_ARCHIVED_PROP_ID := 19
    static XCN_CERT_KEY_IDENTIFIER_PROP_ID := 20
    static XCN_CERT_AUTO_ENROLL_PROP_ID := 21
    static XCN_CERT_PUBKEY_ALG_PARA_PROP_ID := 22
    static XCN_CERT_CROSS_CERT_DIST_POINTS_PROP_ID := 23
    static XCN_CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID := 24
    static XCN_CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID := 25
    static XCN_CERT_ENROLLMENT_PROP_ID := 26
    static XCN_CERT_DATE_STAMP_PROP_ID := 27
    static XCN_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID := 28
    static XCN_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID := 29
    static XCN_CERT_EXTENDED_ERROR_INFO_PROP_ID := 30
    static XCN_CERT_RENEWAL_PROP_ID := 64
    static XCN_CERT_ARCHIVED_KEY_HASH_PROP_ID := 65
    static XCN_CERT_AUTO_ENROLL_RETRY_PROP_ID := 66
    static XCN_CERT_AIA_URL_RETRIEVED_PROP_ID := 67
    static XCN_CERT_AUTHORITY_INFO_ACCESS_PROP_ID := 68
    static XCN_CERT_BACKED_UP_PROP_ID := 69
    static XCN_CERT_OCSP_RESPONSE_PROP_ID := 70
    static XCN_CERT_REQUEST_ORIGINATOR_PROP_ID := 71
    static XCN_CERT_SOURCE_LOCATION_PROP_ID := 72
    static XCN_CERT_SOURCE_URL_PROP_ID := 73
    static XCN_CERT_NEW_KEY_PROP_ID := 74
    static XCN_CERT_OCSP_CACHE_PREFIX_PROP_ID := 75
    static XCN_CERT_SMART_CARD_ROOT_INFO_PROP_ID := 76
    static XCN_CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID := 77
    static XCN_CERT_NCRYPT_KEY_HANDLE_PROP_ID := 78
    static XCN_CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID := 79
    static XCN_CERT_SUBJECT_INFO_ACCESS_PROP_ID := 80
    static XCN_CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID := 81
    static XCN_CERT_CA_DISABLE_CRL_PROP_ID := 82
    static XCN_CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID := 83
    static XCN_CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID := 84
    static XCN_CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID := 85
    static XCN_CERT_SUBJECT_DISABLE_CRL_PROP_ID := 86
    static XCN_CERT_CEP_PROP_ID := 87
    static XCN_CERT_SIGN_HASH_CNG_ALG_PROP_ID := 89
    static XCN_CERT_SCARD_PIN_ID_PROP_ID := 90
    static XCN_CERT_SCARD_PIN_INFO_PROP_ID := 91
    static XCN_CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID := 92
    static XCN_CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID := 93
    static XCN_CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID := 94
    static XCN_CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID := 95
    static XCN_CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID := 96
    static XCN_CERT_NO_EXPIRE_NOTIFICATION_PROP_ID := 97
    static XCN_CERT_AUTH_ROOT_SHA256_HASH_PROP_ID := 98
    static XCN_CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID := 99
    static XCN_CERT_HCRYPTPROV_TRANSFER_PROP_ID := 100
    static XCN_CERT_SMART_CARD_READER_PROP_ID := 101
    static XCN_CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID := 102
    static XCN_CERT_KEY_REPAIR_ATTEMPTED_PROP_ID := 103
    static XCN_CERT_DISALLOWED_FILETIME_PROP_ID := 104
    static XCN_CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID := 105
    static XCN_CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID := 106
    static XCN_CERT_SHA256_HASH_PROP_ID := 107
    static XCN_CERT_SCEP_SERVER_CERTS_PROP_ID := 108
    static XCN_CERT_SCEP_RA_SIGNATURE_CERT_PROP_ID := 109
    static XCN_CERT_SCEP_RA_ENCRYPTION_CERT_PROP_ID := 110
    static XCN_CERT_SCEP_CA_CERT_PROP_ID := 111
    static XCN_CERT_SCEP_SIGNER_CERT_PROP_ID := 112
    static XCN_CERT_SCEP_NONCE_PROP_ID := 113
    static XCN_CERT_SCEP_ENCRYPT_HASH_CNG_ALG_PROP_ID := 114
    static XCN_CERT_SCEP_FLAGS_PROP_ID := 115
    static XCN_CERT_SCEP_GUID_PROP_ID := 116
    static XCN_CERT_SERIALIZABLE_KEY_CONTEXT_PROP_ID := 117
    static XCN_CERT_ISOLATED_KEY_PROP_ID := 118
    static XCN_CERT_SERIAL_CHAIN_PROP_ID := 119
    static XCN_CERT_KEY_CLASSIFICATION_PROP_ID := 120
    static XCN_CERT_DISALLOWED_ENHKEY_USAGE_PROP_ID := 122
    static XCN_CERT_NONCOMPLIANT_ROOT_URL_PROP_ID := 123
    static XCN_CERT_PIN_SHA256_HASH_PROP_ID := 124
    static XCN_CERT_CLR_DELETE_KEY_PROP_ID := 125
    static XCN_CERT_NOT_BEFORE_FILETIME_PROP_ID := 126
    static XCN_CERT_CERT_NOT_BEFORE_ENHKEY_USAGE_PROP_ID := 127
    static XCN_CERT_FIRST_RESERVED_PROP_ID := 130
    static XCN_CERT_LAST_RESERVED_PROP_ID := 32767
    static XCN_CERT_FIRST_USER_PROP_ID := 32768
    static XCN_CERT_LAST_USER_PROP_ID := 65535
    static XCN_CERT_STORE_LOCALIZED_NAME_PROP_ID := 4096
}
struct ICertProperty extends IDispatch {
    static IID := "{728AB32E-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromCertificate(MachineContext, Encoding, strCertificate)
      => ComCall(7, this.p, VARIANT_BOOL, MachineContext, EncodingType, Encoding, BSTR, strCertificate)
    InitializeDecode(Encoding, strEncodedData)
      => ComCall(8, this.p, EncodingType, Encoding, BSTR, strEncodedData)
    get_PropertyId(pValue)
      => ComCall(9, this.p, CERTENROLL_PROPERTYID.Ptr, pValue)
    put_PropertyId(Value)
      => ComCall(10, this.p, CERTENROLL_PROPERTYID, Value)
    get_RawData(Encoding, pValue)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    RemoveFromCertificate(MachineContext, Encoding, strCertificate)
      => ComCall(12, this.p, VARIANT_BOOL, MachineContext, EncodingType, Encoding, BSTR, strCertificate)
    SetValueOnCertificate(MachineContext, Encoding, strCertificate)
      => ComCall(13, this.p, VARIANT_BOOL, MachineContext, EncodingType, Encoding, BSTR, strCertificate)
}
struct ICertProperties extends IDispatch {
    static IID := "{728AB32F-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICertProperty.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICertProperty, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    InitializeFromCertificate(MachineContext, Encoding, strCertificate)
      => ComCall(13, this.p, VARIANT_BOOL, MachineContext, EncodingType, Encoding, BSTR, strCertificate)
}
struct ICertPropertyFriendlyName extends ICertProperty {
    static IID := "{728AB330-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strFriendlyName)
      => ComCall(14, this.p, BSTR, strFriendlyName)
    get_FriendlyName(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
}
struct ICertPropertyDescription extends ICertProperty {
    static IID := "{728AB331-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strDescription)
      => ComCall(14, this.p, BSTR, strDescription)
    get_Description(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
}
struct ICertPropertyAutoEnroll extends ICertProperty {
    static IID := "{728AB332-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strTemplateName)
      => ComCall(14, this.p, BSTR, strTemplateName)
    get_TemplateName(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
}
struct ICertPropertyRequestOriginator extends ICertProperty {
    static IID := "{728AB333-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strRequestOriginator)
      => ComCall(14, this.p, BSTR, strRequestOriginator)
    InitializeFromLocalRequestOriginator()
      => ComCall(15, this.p)
    get_RequestOriginator(pValue)
      => ComCall(16, this.p, BSTR.Ptr, pValue)
}
struct ICertPropertySHA1Hash extends ICertProperty {
    static IID := "{728AB334-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Encoding, strRenewalValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR, strRenewalValue)
    get_SHA1Hash(Encoding, pValue)
      => ComCall(15, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct ICertPropertyKeyProvInfo extends ICertProperty {
    static IID := "{728AB336-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pValue?)
      => ComCall(14, this.p, IX509PrivateKey, pValue?)
    get_PrivateKey(ppValue)
      => ComCall(15, this.p, IX509PrivateKey.Ptr, ppValue)
}
struct ICertPropertyArchived extends ICertProperty {
    static IID := "{728AB337-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(ArchivedValue)
      => ComCall(14, this.p, VARIANT_BOOL, ArchivedValue)
    get_Archived(pValue)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pValue)
}
struct ICertPropertyBackedUp extends ICertProperty {
    static IID := "{728AB338-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromCurrentTime(BackedUpValue)
      => ComCall(14, this.p, VARIANT_BOOL, BackedUpValue)
    Initialize(BackedUpValue, Date)
      => ComCall(15, this.p, VARIANT_BOOL, BackedUpValue, Float64, Date)
    get_BackedUpValue(pValue)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pValue)
    get_BackedUpTime(pDate)
      => ComCall(17, this.p, Float64.Ptr, pDate)
}
struct ICertPropertyEnrollment extends ICertProperty {
    static IID := "{728AB339-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(RequestId, strCADnsName, strCAName, strFriendlyName)
      => ComCall(14, this.p, Int32, RequestId, BSTR, strCADnsName, BSTR, strCAName, BSTR, strFriendlyName)
    get_RequestId(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
    get_CADnsName(pValue)
      => ComCall(16, this.p, BSTR.Ptr, pValue)
    get_CAName(pValue)
      => ComCall(17, this.p, BSTR.Ptr, pValue)
    get_FriendlyName(pValue)
      => ComCall(18, this.p, BSTR.Ptr, pValue)
}
struct ICertPropertyRenewal extends ICertProperty {
    static IID := "{728AB33A-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Encoding, strRenewalValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR, strRenewalValue)
    InitializeFromCertificateHash(MachineContext, Encoding, strCertificate)
      => ComCall(15, this.p, VARIANT_BOOL, MachineContext, EncodingType, Encoding, BSTR, strCertificate)
    get_Renewal(Encoding, pValue)
      => ComCall(16, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct ICertPropertyArchivedKeyHash extends ICertProperty {
    static IID := "{728AB33B-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Encoding, strArchivedKeyHashValue)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR, strArchivedKeyHashValue)
    get_ArchivedKeyHash(Encoding, pValue)
      => ComCall(15, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct EnrollmentPolicyServerPropertyFlags extends Int32 {
    static DefaultNone := 0
    static DefaultPolicyServer := 1
}
struct PolicyServerUrlFlags extends Int32 {
    static PsfNone := 0
    static PsfLocationGroupPolicy := 1
    static PsfLocationRegistry := 2
    static PsfUseClientId := 4
    static PsfAutoEnrollmentEnabled := 16
    static PsfAllowUnTrustedCA := 32
}
struct ICertPropertyEnrollmentPolicyServer extends ICertProperty {
    static IID := "{728AB34A-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(PropertyFlags, AuthFlags, EnrollmentServerAuthFlags, UrlFlags, strRequestId, strUrl, strId, strEnrollmentServerUrl)
      => ComCall(14, this.p, EnrollmentPolicyServerPropertyFlags, PropertyFlags, X509EnrollmentAuthFlags, AuthFlags, X509EnrollmentAuthFlags, EnrollmentServerAuthFlags, PolicyServerUrlFlags, UrlFlags, BSTR, strRequestId, BSTR, strUrl, BSTR, strId, BSTR, strEnrollmentServerUrl)
    GetPolicyServerUrl(pValue)
      => ComCall(15, this.p, BSTR.Ptr, pValue)
    GetPolicyServerId(pValue)
      => ComCall(16, this.p, BSTR.Ptr, pValue)
    GetEnrollmentServerUrl(pValue)
      => ComCall(17, this.p, BSTR.Ptr, pValue)
    GetRequestIdString(pValue)
      => ComCall(18, this.p, BSTR.Ptr, pValue)
    GetPropertyFlags(pValue)
      => ComCall(19, this.p, EnrollmentPolicyServerPropertyFlags.Ptr, pValue)
    GetUrlFlags(pValue)
      => ComCall(20, this.p, PolicyServerUrlFlags.Ptr, pValue)
    GetAuthentication(pValue)
      => ComCall(21, this.p, X509EnrollmentAuthFlags.Ptr, pValue)
    GetEnrollmentServerAuthentication(pValue)
      => ComCall(22, this.p, X509EnrollmentAuthFlags.Ptr, pValue)
}
struct IX509SignatureInformation extends IDispatch {
    static IID := "{728AB33C-217D-11DA-B2A4-000E7BBB2B09}"
    get_HashAlgorithm(ppValue)
      => ComCall(7, this.p, IObjectId.Ptr, ppValue)
    put_HashAlgorithm(pValue?)
      => ComCall(8, this.p, IObjectId, pValue?)
    get_PublicKeyAlgorithm(ppValue)
      => ComCall(9, this.p, IObjectId.Ptr, ppValue)
    put_PublicKeyAlgorithm(pValue?)
      => ComCall(10, this.p, IObjectId, pValue?)
    get_Parameters(Encoding, pValue)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_Parameters(Encoding, Value)
      => ComCall(12, this.p, EncodingType, Encoding, BSTR, Value)
    get_AlternateSignatureAlgorithm(pValue)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pValue)
    put_AlternateSignatureAlgorithm(Value)
      => ComCall(14, this.p, VARIANT_BOOL, Value)
    get_AlternateSignatureAlgorithmSet(pValue)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pValue)
    get_NullSigned(pValue)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pValue)
    put_NullSigned(Value)
      => ComCall(17, this.p, VARIANT_BOOL, Value)
    GetSignatureAlgorithm(Pkcs7Signature, SignatureKey, ppValue)
      => ComCall(18, this.p, VARIANT_BOOL, Pkcs7Signature, VARIANT_BOOL, SignatureKey, IObjectId.Ptr, ppValue)
    SetDefaultValues()
      => ComCall(19, this.p)
}
struct ISignerCertificate extends IDispatch {
    static IID := "{728AB33D-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(MachineContext, VerifyType, Encoding, strCertificate)
      => ComCall(7, this.p, VARIANT_BOOL, MachineContext, X509PrivateKeyVerify, VerifyType, EncodingType, Encoding, BSTR, strCertificate)
    get_Certificate(Encoding, pValue)
      => ComCall(8, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_PrivateKey(ppValue)
      => ComCall(9, this.p, IX509PrivateKey.Ptr, ppValue)
    get_Silent(pValue)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Silent(Value)
      => ComCall(11, this.p, VARIANT_BOOL, Value)
    get_ParentWindow(pValue)
      => ComCall(12, this.p, Int32.Ptr, pValue)
    put_ParentWindow(Value)
      => ComCall(13, this.p, Int32, Value)
    get_UIContextMessage(pValue)
      => ComCall(14, this.p, BSTR.Ptr, pValue)
    put_UIContextMessage(Value)
      => ComCall(15, this.p, BSTR, Value)
    put_Pin(Value)
      => ComCall(16, this.p, BSTR, Value)
    get_SignatureInformation(ppValue)
      => ComCall(17, this.p, IX509SignatureInformation.Ptr, ppValue)
}
struct ISignerCertificates extends IDispatch {
    static IID := "{728AB33E-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ISignerCertificate.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ISignerCertificate, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    Find(pSignerCert?, piSignerCert)
      => ComCall(13, this.p, ISignerCertificate, pSignerCert?, Int32.Ptr, piSignerCert)
}
struct IX509NameValuePair extends IDispatch {
    static IID := "{728AB33F-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strName, strValue)
      => ComCall(7, this.p, BSTR, strName, BSTR, strValue)
    get_Value(pValue)
      => ComCall(8, this.p, BSTR.Ptr, pValue)
    get_Name(pValue)
      => ComCall(9, this.p, BSTR.Ptr, pValue)
}
struct IX509NameValuePairs extends IDispatch {
    static IID := "{728AB340-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509NameValuePair.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509NameValuePair, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
}
struct EnrollmentTemplateProperty extends Int32 {
    static TemplatePropCommonName := 1
    static TemplatePropFriendlyName := 2
    static TemplatePropEKUs := 3
    static TemplatePropCryptoProviders := 4
    static TemplatePropMajorRevision := 5
    static TemplatePropDescription := 6
    static TemplatePropKeySpec := 7
    static TemplatePropSchemaVersion := 8
    static TemplatePropMinorRevision := 9
    static TemplatePropRASignatureCount := 10
    static TemplatePropMinimumKeySize := 11
    static TemplatePropOID := 12
    static TemplatePropSupersede := 13
    static TemplatePropRACertificatePolicies := 14
    static TemplatePropRAEKUs := 15
    static TemplatePropCertificatePolicies := 16
    static TemplatePropV1ApplicationPolicy := 17
    static TemplatePropAsymmetricAlgorithm := 18
    static TemplatePropKeySecurityDescriptor := 19
    static TemplatePropSymmetricAlgorithm := 20
    static TemplatePropSymmetricKeyLength := 21
    static TemplatePropHashAlgorithm := 22
    static TemplatePropKeyUsage := 23
    static TemplatePropEnrollmentFlags := 24
    static TemplatePropSubjectNameFlags := 25
    static TemplatePropPrivateKeyFlags := 26
    static TemplatePropGeneralFlags := 27
    static TemplatePropSecurityDescriptor := 28
    static TemplatePropExtensions := 29
    static TemplatePropValidityPeriod := 30
    static TemplatePropRenewalPeriod := 31
}
struct IX509CertificateTemplate extends IDispatch {
    static IID := "{54244A13-555A-4E22-896D-1B0E52F76406}"
    get_Property(property, pValue)
      => ComCall(7, this.p, EnrollmentTemplateProperty, property, VARIANT.Ptr, pValue)
}
struct IX509CertificateTemplates extends IDispatch {
    static IID := "{13B79003-2181-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509CertificateTemplate.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509CertificateTemplate, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_ItemByName(bstrName, ppValue)
      => ComCall(13, this.p, BSTR, bstrName, IX509CertificateTemplate.Ptr, ppValue)
    get_ItemByOid(pOid?, ppValue)
      => ComCall(14, this.p, IObjectId, pOid?, IX509CertificateTemplate.Ptr, ppValue)
}
struct CommitTemplateFlags extends Int32 {
    static CommitFlagSaveTemplateGenerateOID := 1
    static CommitFlagSaveTemplateUseCurrentOID := 2
    static CommitFlagSaveTemplateOverwrite := 3
    static CommitFlagDeleteTemplate := 4
}
struct IX509CertificateTemplateWritable extends IDispatch {
    static IID := "{F49466A7-395A-4E9E-B6E7-32B331600DC0}"
    Initialize(pValue?)
      => ComCall(7, this.p, IX509CertificateTemplate, pValue?)
    Commit(commitFlags, strServerContext)
      => ComCall(8, this.p, CommitTemplateFlags, commitFlags, BSTR, strServerContext)
    get_Property(property, pValue)
      => ComCall(9, this.p, EnrollmentTemplateProperty, property, VARIANT.Ptr, pValue)
    put_Property(property, value)
      => ComCall(10, this.p, EnrollmentTemplateProperty, property, VARIANT, value)
    get_Template(ppValue)
      => ComCall(11, this.p, IX509CertificateTemplate.Ptr, ppValue)
}
struct EnrollmentCAProperty extends Int32 {
    static CAPropCommonName := 1
    static CAPropDistinguishedName := 2
    static CAPropSanitizedName := 3
    static CAPropSanitizedShortName := 4
    static CAPropDNSName := 5
    static CAPropCertificateTypes := 6
    static CAPropCertificate := 7
    static CAPropDescription := 8
    static CAPropWebServers := 9
    static CAPropSiteName := 10
    static CAPropSecurity := 11
    static CAPropRenewalOnly := 12
}
struct ICertificationAuthority extends IDispatch {
    static IID := "{835D1F61-1E95-4BC8-B4D3-976C42B968F7}"
    get_Property(property, pValue)
      => ComCall(7, this.p, EnrollmentCAProperty, property, VARIANT.Ptr, pValue)
}
struct ICertificationAuthorities extends IDispatch {
    static IID := "{13B79005-2181-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, ICertificationAuthority.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, ICertificationAuthority, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    ComputeSiteCosts()
      => ComCall(13, this.p)
    get_ItemByName(strName, ppValue)
      => ComCall(14, this.p, BSTR, strName, ICertificationAuthority.Ptr, ppValue)
}
struct X509EnrollmentPolicyLoadOption extends Int32 {
    static LoadOptionDefault := 0
    static LoadOptionCacheOnly := 1
    static LoadOptionReload := 2
    static LoadOptionRegisterForADChanges := 4
}
struct EnrollmentPolicyFlags extends Int32 {
    static DisableGroupPolicyList := 2
    static DisableUserServerList := 4
}
struct PolicyServerUrlPropertyID extends Int32 {
    static PsPolicyID := 0
    static PsFriendlyName := 1
}
struct X509EnrollmentPolicyExportFlags extends Int32 {
    static ExportTemplates := 1
    static ExportOIDs := 2
    static ExportCAs := 4
}
struct IX509EnrollmentPolicyServer extends IDispatch {
    static IID := "{13B79026-2181-11DA-B2A4-000E7BBB2B09}"
    Initialize(bstrPolicyServerUrl, bstrPolicyServerId, authFlags, fIsUnTrusted, context)
      => ComCall(7, this.p, BSTR, bstrPolicyServerUrl, BSTR, bstrPolicyServerId, X509EnrollmentAuthFlags, authFlags, VARIANT_BOOL, fIsUnTrusted, X509CertificateEnrollmentContext, context)
    LoadPolicy(option)
      => ComCall(8, this.p, X509EnrollmentPolicyLoadOption, option)
    GetTemplates(pTemplates)
      => ComCall(9, this.p, IX509CertificateTemplates.Ptr, pTemplates)
    GetCAsForTemplate(pTemplate?, ppCAs)
      => ComCall(10, this.p, IX509CertificateTemplate, pTemplate?, ICertificationAuthorities.Ptr, ppCAs)
    GetCAs(ppCAs)
      => ComCall(11, this.p, ICertificationAuthorities.Ptr, ppCAs)
    Validate()
      => ComCall(12, this.p)
    GetCustomOids(ppObjectIds)
      => ComCall(13, this.p, IObjectIds.Ptr, ppObjectIds)
    GetNextUpdateTime(pDate)
      => ComCall(14, this.p, Float64.Ptr, pDate)
    GetLastUpdateTime(pDate)
      => ComCall(15, this.p, Float64.Ptr, pDate)
    GetPolicyServerUrl(pValue)
      => ComCall(16, this.p, BSTR.Ptr, pValue)
    GetPolicyServerId(pValue)
      => ComCall(17, this.p, BSTR.Ptr, pValue)
    GetFriendlyName(pValue)
      => ComCall(18, this.p, BSTR.Ptr, pValue)
    GetIsDefaultCEP(pValue)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pValue)
    GetUseClientId(pValue)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, pValue)
    GetAllowUnTrustedCA(pValue)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pValue)
    GetCachePath(pValue)
      => ComCall(22, this.p, BSTR.Ptr, pValue)
    GetCacheDir(pValue)
      => ComCall(23, this.p, BSTR.Ptr, pValue)
    GetAuthFlags(pValue)
      => ComCall(24, this.p, X509EnrollmentAuthFlags.Ptr, pValue)
    SetCredential(hWndParent, flag, strCredential, strPassword)
      => ComCall(25, this.p, Int32, hWndParent, X509EnrollmentAuthFlags, flag, BSTR, strCredential, BSTR, strPassword)
    QueryChanges(pValue)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pValue)
    InitializeImport(val)
      => ComCall(27, this.p, VARIANT, val)
    Export(exportFlags, pVal)
      => ComCall(28, this.p, X509EnrollmentPolicyExportFlags, exportFlags, VARIANT.Ptr, pVal)
    get_Cost(pValue)
      => ComCall(29, this.p, UInt32.Ptr, pValue)
    put_Cost(value)
      => ComCall(30, this.p, UInt32, value)
}
struct IX509PolicyServerUrl extends IDispatch {
    static IID := "{884E204A-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(context)
      => ComCall(7, this.p, X509CertificateEnrollmentContext, context)
    get_Url(ppValue)
      => ComCall(8, this.p, BSTR.Ptr, ppValue)
    put_Url(pValue)
      => ComCall(9, this.p, BSTR, pValue)
    get_Default(pValue)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Default(value)
      => ComCall(11, this.p, VARIANT_BOOL, value)
    get_Flags(pValue)
      => ComCall(12, this.p, PolicyServerUrlFlags.Ptr, pValue)
    put_Flags(Flags)
      => ComCall(13, this.p, PolicyServerUrlFlags, Flags)
    get_AuthFlags(pValue)
      => ComCall(14, this.p, X509EnrollmentAuthFlags.Ptr, pValue)
    put_AuthFlags(Flags)
      => ComCall(15, this.p, X509EnrollmentAuthFlags, Flags)
    get_Cost(pValue)
      => ComCall(16, this.p, UInt32.Ptr, pValue)
    put_Cost(value)
      => ComCall(17, this.p, UInt32, value)
    GetStringProperty(propertyId, ppValue)
      => ComCall(18, this.p, PolicyServerUrlPropertyID, propertyId, BSTR.Ptr, ppValue)
    SetStringProperty(propertyId, pValue)
      => ComCall(19, this.p, PolicyServerUrlPropertyID, propertyId, BSTR, pValue)
    UpdateRegistry(context)
      => ComCall(20, this.p, X509CertificateEnrollmentContext, context)
    RemoveFromRegistry(context)
      => ComCall(21, this.p, X509CertificateEnrollmentContext, context)
}
struct IX509PolicyServerListManager extends IDispatch {
    static IID := "{884E204B-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509PolicyServerUrl.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509PolicyServerUrl, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    Initialize(context, Flags)
      => ComCall(13, this.p, X509CertificateEnrollmentContext, context, PolicyServerUrlFlags, Flags)
}
struct X509RequestType extends Int32 {
    static TypeAny := 0
    static TypePkcs10 := 1
    static TypePkcs7 := 2
    static TypeCmc := 3
    static TypeCertificate := 4
}
struct X509RequestInheritOptions extends Int32 {
    static InheritDefault := 0
    static InheritNewDefaultKey := 1
    static InheritNewSimilarKey := 2
    static InheritPrivateKey := 3
    static InheritPublicKey := 4
    static InheritKeyMask := 15
    static InheritNone := 16
    static InheritRenewalCertificateFlag := 32
    static InheritTemplateFlag := 64
    static InheritSubjectFlag := 128
    static InheritExtensionsFlag := 256
    static InheritSubjectAltNameFlag := 512
    static InheritValidityPeriodFlag := 1024
    static InheritReserved80000000 := -2147483648
}
struct InnerRequestLevel extends Int32 {
    static LevelInnermost := 0
    static LevelNext := 1
}
struct IX509CertificateRequest extends IDispatch {
    static IID := "{728AB341-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Context)
      => ComCall(7, this.p, X509CertificateEnrollmentContext, Context)
    Encode()
      => ComCall(8, this.p)
    ResetForEncode()
      => ComCall(9, this.p)
    GetInnerRequest(Level, ppValue)
      => ComCall(10, this.p, InnerRequestLevel, Level, IX509CertificateRequest.Ptr, ppValue)
    get_Type(pValue)
      => ComCall(11, this.p, X509RequestType.Ptr, pValue)
    get_EnrollmentContext(pValue)
      => ComCall(12, this.p, X509CertificateEnrollmentContext.Ptr, pValue)
    get_Silent(pValue)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Silent(Value)
      => ComCall(14, this.p, VARIANT_BOOL, Value)
    get_ParentWindow(pValue)
      => ComCall(15, this.p, Int32.Ptr, pValue)
    put_ParentWindow(Value)
      => ComCall(16, this.p, Int32, Value)
    get_UIContextMessage(pValue)
      => ComCall(17, this.p, BSTR.Ptr, pValue)
    put_UIContextMessage(Value)
      => ComCall(18, this.p, BSTR, Value)
    get_SuppressDefaults(pValue)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pValue)
    put_SuppressDefaults(Value)
      => ComCall(20, this.p, VARIANT_BOOL, Value)
    get_RenewalCertificate(Encoding, pValue)
      => ComCall(21, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_RenewalCertificate(Encoding, Value)
      => ComCall(22, this.p, EncodingType, Encoding, BSTR, Value)
    get_ClientId(pValue)
      => ComCall(23, this.p, RequestClientInfoClientId.Ptr, pValue)
    put_ClientId(Value)
      => ComCall(24, this.p, RequestClientInfoClientId, Value)
    get_CspInformations(ppValue)
      => ComCall(25, this.p, ICspInformations.Ptr, ppValue)
    put_CspInformations(pValue?)
      => ComCall(26, this.p, ICspInformations, pValue?)
    get_HashAlgorithm(ppValue)
      => ComCall(27, this.p, IObjectId.Ptr, ppValue)
    put_HashAlgorithm(pValue?)
      => ComCall(28, this.p, IObjectId, pValue?)
    get_AlternateSignatureAlgorithm(pValue)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pValue)
    put_AlternateSignatureAlgorithm(Value)
      => ComCall(30, this.p, VARIANT_BOOL, Value)
    get_RawData(Encoding, pValue)
      => ComCall(31, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct Pkcs10AllowedSignatureTypes extends Int32 {
    static AllowedKeySignature := 1
    static AllowedNullSignature := 2
}
struct IX509CertificateRequestPkcs10 extends IX509CertificateRequest {
    static IID := "{728AB342-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplateName(Context, strTemplateName)
      => ComCall(32, this.p, X509CertificateEnrollmentContext, Context, BSTR, strTemplateName)
    InitializeFromPrivateKey(Context, pPrivateKey?, strTemplateName)
      => ComCall(33, this.p, X509CertificateEnrollmentContext, Context, IX509PrivateKey, pPrivateKey?, BSTR, strTemplateName)
    InitializeFromPublicKey(Context, pPublicKey?, strTemplateName)
      => ComCall(34, this.p, X509CertificateEnrollmentContext, Context, IX509PublicKey, pPublicKey?, BSTR, strTemplateName)
    InitializeFromCertificate(Context, strCertificate, Encoding, InheritOptions)
      => ComCall(35, this.p, X509CertificateEnrollmentContext, Context, BSTR, strCertificate, EncodingType, Encoding, X509RequestInheritOptions, InheritOptions)
    InitializeDecode(strEncodedData, Encoding)
      => ComCall(36, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    CheckSignature(AllowedSignatureTypes)
      => ComCall(37, this.p, Pkcs10AllowedSignatureTypes, AllowedSignatureTypes)
    IsSmartCard(pValue)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pValue)
    get_TemplateObjectId(ppValue)
      => ComCall(39, this.p, IObjectId.Ptr, ppValue)
    get_PublicKey(ppValue)
      => ComCall(40, this.p, IX509PublicKey.Ptr, ppValue)
    get_PrivateKey(ppValue)
      => ComCall(41, this.p, IX509PrivateKey.Ptr, ppValue)
    get_NullSigned(pValue)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, pValue)
    get_ReuseKey(pValue)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pValue)
    get_OldCertificate(Encoding, pValue)
      => ComCall(44, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Subject(ppValue)
      => ComCall(45, this.p, IX500DistinguishedName.Ptr, ppValue)
    put_Subject(pValue?)
      => ComCall(46, this.p, IX500DistinguishedName, pValue?)
    get_CspStatuses(ppValue)
      => ComCall(47, this.p, ICspStatuses.Ptr, ppValue)
    get_SmimeCapabilities(pValue)
      => ComCall(48, this.p, VARIANT_BOOL.Ptr, pValue)
    put_SmimeCapabilities(Value)
      => ComCall(49, this.p, VARIANT_BOOL, Value)
    get_SignatureInformation(ppValue)
      => ComCall(50, this.p, IX509SignatureInformation.Ptr, ppValue)
    get_KeyContainerNamePrefix(pValue)
      => ComCall(51, this.p, BSTR.Ptr, pValue)
    put_KeyContainerNamePrefix(Value)
      => ComCall(52, this.p, BSTR, Value)
    get_CryptAttributes(ppValue)
      => ComCall(53, this.p, ICryptAttributes.Ptr, ppValue)
    get_X509Extensions(ppValue)
      => ComCall(54, this.p, IX509Extensions.Ptr, ppValue)
    get_CriticalExtensions(ppValue)
      => ComCall(55, this.p, IObjectIds.Ptr, ppValue)
    get_SuppressOids(ppValue)
      => ComCall(56, this.p, IObjectIds.Ptr, ppValue)
    get_RawDataToBeSigned(Encoding, pValue)
      => ComCall(57, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Signature(Encoding, pValue)
      => ComCall(58, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    GetCspStatuses(KeySpec, ppCspStatuses)
      => ComCall(59, this.p, X509KeySpec, KeySpec, ICspStatuses.Ptr, ppCspStatuses)
}
struct IX509CertificateRequestPkcs10V2 extends IX509CertificateRequestPkcs10 {
    static IID := "{728AB35B-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplate(context, pPolicyServer?, pTemplate?)
      => ComCall(60, this.p, X509CertificateEnrollmentContext, context, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    InitializeFromPrivateKeyTemplate(Context, pPrivateKey?, pPolicyServer?, pTemplate?)
      => ComCall(61, this.p, X509CertificateEnrollmentContext, Context, IX509PrivateKey, pPrivateKey?, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    InitializeFromPublicKeyTemplate(Context, pPublicKey?, pPolicyServer?, pTemplate?)
      => ComCall(62, this.p, X509CertificateEnrollmentContext, Context, IX509PublicKey, pPublicKey?, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    get_PolicyServer(ppPolicyServer)
      => ComCall(63, this.p, IX509EnrollmentPolicyServer.Ptr, ppPolicyServer)
    get_Template(ppTemplate)
      => ComCall(64, this.p, IX509CertificateTemplate.Ptr, ppTemplate)
}
struct IX509CertificateRequestPkcs10V3 extends IX509CertificateRequestPkcs10V2 {
    static IID := "{54EA9942-3D66-4530-B76E-7C9170D3EC52}"
    get_AttestPrivateKey(pValue)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, pValue)
    put_AttestPrivateKey(Value)
      => ComCall(66, this.p, VARIANT_BOOL, Value)
    get_AttestationEncryptionCertificate(Encoding, pValue)
      => ComCall(67, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_AttestationEncryptionCertificate(Encoding, Value)
      => ComCall(68, this.p, EncodingType, Encoding, BSTR, Value)
    get_EncryptionAlgorithm(ppValue)
      => ComCall(69, this.p, IObjectId.Ptr, ppValue)
    put_EncryptionAlgorithm(pValue?)
      => ComCall(70, this.p, IObjectId, pValue?)
    get_EncryptionStrength(pValue)
      => ComCall(71, this.p, Int32.Ptr, pValue)
    put_EncryptionStrength(Value)
      => ComCall(72, this.p, Int32, Value)
    get_ChallengePassword(pValue)
      => ComCall(73, this.p, BSTR.Ptr, pValue)
    put_ChallengePassword(Value)
      => ComCall(74, this.p, BSTR, Value)
    get_NameValuePairs(ppValue)
      => ComCall(75, this.p, IX509NameValuePairs.Ptr, ppValue)
}
struct KeyAttestationClaimType extends Int32 {
    static XCN_NCRYPT_CLAIM_NONE := 0
    static XCN_NCRYPT_CLAIM_AUTHORITY_AND_SUBJECT := 3
    static XCN_NCRYPT_CLAIM_AUTHORITY_ONLY := 1
    static XCN_NCRYPT_CLAIM_SUBJECT_ONLY := 2
    static XCN_NCRYPT_CLAIM_UNKNOWN := 4096
}
struct IX509CertificateRequestPkcs10V4 extends IX509CertificateRequestPkcs10V3 {
    static IID := "{728AB363-217D-11DA-B2A4-000E7BBB2B09}"
    get_ClaimType(pValue)
      => ComCall(76, this.p, KeyAttestationClaimType.Ptr, pValue)
    put_ClaimType(Value)
      => ComCall(77, this.p, KeyAttestationClaimType, Value)
    get_AttestPrivateKeyPreferred(pValue)
      => ComCall(78, this.p, VARIANT_BOOL.Ptr, pValue)
    put_AttestPrivateKeyPreferred(Value)
      => ComCall(79, this.p, VARIANT_BOOL, Value)
}
struct IX509CertificateRequestCertificate extends IX509CertificateRequestPkcs10 {
    static IID := "{728AB343-217D-11DA-B2A4-000E7BBB2B09}"
    CheckPublicKeySignature(pPublicKey?)
      => ComCall(60, this.p, IX509PublicKey, pPublicKey?)
    get_Issuer(ppValue)
      => ComCall(61, this.p, IX500DistinguishedName.Ptr, ppValue)
    put_Issuer(pValue?)
      => ComCall(62, this.p, IX500DistinguishedName, pValue?)
    get_NotBefore(pValue)
      => ComCall(63, this.p, Float64.Ptr, pValue)
    put_NotBefore(Value)
      => ComCall(64, this.p, Float64, Value)
    get_NotAfter(pValue)
      => ComCall(65, this.p, Float64.Ptr, pValue)
    put_NotAfter(Value)
      => ComCall(66, this.p, Float64, Value)
    get_SerialNumber(Encoding, pValue)
      => ComCall(67, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_SerialNumber(Encoding, Value)
      => ComCall(68, this.p, EncodingType, Encoding, BSTR, Value)
    get_SignerCertificate(ppValue)
      => ComCall(69, this.p, ISignerCertificate.Ptr, ppValue)
    put_SignerCertificate(pValue?)
      => ComCall(70, this.p, ISignerCertificate, pValue?)
}
struct IX509CertificateRequestCertificate2 extends IX509CertificateRequestCertificate {
    static IID := "{728AB35A-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplate(context, pPolicyServer?, pTemplate?)
      => ComCall(71, this.p, X509CertificateEnrollmentContext, context, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    InitializeFromPrivateKeyTemplate(Context, pPrivateKey?, pPolicyServer?, pTemplate?)
      => ComCall(72, this.p, X509CertificateEnrollmentContext, Context, IX509PrivateKey, pPrivateKey?, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    get_PolicyServer(ppPolicyServer)
      => ComCall(73, this.p, IX509EnrollmentPolicyServer.Ptr, ppPolicyServer)
    get_Template(ppTemplate)
      => ComCall(74, this.p, IX509CertificateTemplate.Ptr, ppTemplate)
}
struct IX509CertificateRequestPkcs7 extends IX509CertificateRequest {
    static IID := "{728AB344-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplateName(Context, strTemplateName)
      => ComCall(32, this.p, X509CertificateEnrollmentContext, Context, BSTR, strTemplateName)
    InitializeFromCertificate(Context, RenewalRequest, strCertificate, Encoding, InheritOptions)
      => ComCall(33, this.p, X509CertificateEnrollmentContext, Context, VARIANT_BOOL, RenewalRequest, BSTR, strCertificate, EncodingType, Encoding, X509RequestInheritOptions, InheritOptions)
    InitializeFromInnerRequest(pInnerRequest?)
      => ComCall(34, this.p, IX509CertificateRequest, pInnerRequest?)
    InitializeDecode(strEncodedData, Encoding)
      => ComCall(35, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    get_RequesterName(pValue)
      => ComCall(36, this.p, BSTR.Ptr, pValue)
    put_RequesterName(Value)
      => ComCall(37, this.p, BSTR, Value)
    get_SignerCertificate(ppValue)
      => ComCall(38, this.p, ISignerCertificate.Ptr, ppValue)
    put_SignerCertificate(pValue?)
      => ComCall(39, this.p, ISignerCertificate, pValue?)
}
struct IX509CertificateRequestPkcs7V2 extends IX509CertificateRequestPkcs7 {
    static IID := "{728AB35C-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplate(context, pPolicyServer?, pTemplate?)
      => ComCall(40, this.p, X509CertificateEnrollmentContext, context, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    get_PolicyServer(ppPolicyServer)
      => ComCall(41, this.p, IX509EnrollmentPolicyServer.Ptr, ppPolicyServer)
    get_Template(ppTemplate)
      => ComCall(42, this.p, IX509CertificateTemplate.Ptr, ppTemplate)
    CheckCertificateSignature(ValidateCertificateChain)
      => ComCall(43, this.p, VARIANT_BOOL, ValidateCertificateChain)
}
struct IX509CertificateRequestCmc extends IX509CertificateRequestPkcs7 {
    static IID := "{728AB345-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromInnerRequestTemplateName(pInnerRequest?, strTemplateName)
      => ComCall(40, this.p, IX509CertificateRequest, pInnerRequest?, BSTR, strTemplateName)
    get_TemplateObjectId(ppValue)
      => ComCall(41, this.p, IObjectId.Ptr, ppValue)
    get_NullSigned(pValue)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, pValue)
    get_CryptAttributes(ppValue)
      => ComCall(43, this.p, ICryptAttributes.Ptr, ppValue)
    get_NameValuePairs(ppValue)
      => ComCall(44, this.p, IX509NameValuePairs.Ptr, ppValue)
    get_X509Extensions(ppValue)
      => ComCall(45, this.p, IX509Extensions.Ptr, ppValue)
    get_CriticalExtensions(ppValue)
      => ComCall(46, this.p, IObjectIds.Ptr, ppValue)
    get_SuppressOids(ppValue)
      => ComCall(47, this.p, IObjectIds.Ptr, ppValue)
    get_TransactionId(pValue)
      => ComCall(48, this.p, Int32.Ptr, pValue)
    put_TransactionId(Value)
      => ComCall(49, this.p, Int32, Value)
    get_SenderNonce(Encoding, pValue)
      => ComCall(50, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_SenderNonce(Encoding, Value)
      => ComCall(51, this.p, EncodingType, Encoding, BSTR, Value)
    get_SignatureInformation(ppValue)
      => ComCall(52, this.p, IX509SignatureInformation.Ptr, ppValue)
    get_ArchivePrivateKey(pValue)
      => ComCall(53, this.p, VARIANT_BOOL.Ptr, pValue)
    put_ArchivePrivateKey(Value)
      => ComCall(54, this.p, VARIANT_BOOL, Value)
    get_KeyArchivalCertificate(Encoding, pValue)
      => ComCall(55, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_KeyArchivalCertificate(Encoding, Value)
      => ComCall(56, this.p, EncodingType, Encoding, BSTR, Value)
    get_EncryptionAlgorithm(ppValue)
      => ComCall(57, this.p, IObjectId.Ptr, ppValue)
    put_EncryptionAlgorithm(pValue?)
      => ComCall(58, this.p, IObjectId, pValue?)
    get_EncryptionStrength(pValue)
      => ComCall(59, this.p, Int32.Ptr, pValue)
    put_EncryptionStrength(Value)
      => ComCall(60, this.p, Int32, Value)
    get_EncryptedKeyHash(Encoding, pValue)
      => ComCall(61, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_SignerCertificates(ppValue)
      => ComCall(62, this.p, ISignerCertificates.Ptr, ppValue)
}
struct IX509CertificateRequestCmc2 extends IX509CertificateRequestCmc {
    static IID := "{728AB35D-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplate(context, pPolicyServer?, pTemplate?)
      => ComCall(63, this.p, X509CertificateEnrollmentContext, context, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    InitializeFromInnerRequestTemplate(pInnerRequest?, pPolicyServer?, pTemplate?)
      => ComCall(64, this.p, IX509CertificateRequest, pInnerRequest?, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    get_PolicyServer(ppPolicyServer)
      => ComCall(65, this.p, IX509EnrollmentPolicyServer.Ptr, ppPolicyServer)
    get_Template(ppTemplate)
      => ComCall(66, this.p, IX509CertificateTemplate.Ptr, ppTemplate)
    CheckSignature(AllowedSignatureTypes)
      => ComCall(67, this.p, Pkcs10AllowedSignatureTypes, AllowedSignatureTypes)
    CheckCertificateSignature(pSignerCertificate?, ValidateCertificateChain)
      => ComCall(68, this.p, ISignerCertificate, pSignerCertificate?, VARIANT_BOOL, ValidateCertificateChain)
}
struct InstallResponseRestrictionFlags extends Int32 {
    static AllowNone := 0
    static AllowNoOutstandingRequest := 1
    static AllowUntrustedCertificate := 2
    static AllowUntrustedRoot := 4
}
struct IX509Enrollment extends IDispatch {
    static IID := "{728AB346-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Context)
      => ComCall(7, this.p, X509CertificateEnrollmentContext, Context)
    InitializeFromTemplateName(Context, strTemplateName)
      => ComCall(8, this.p, X509CertificateEnrollmentContext, Context, BSTR, strTemplateName)
    InitializeFromRequest(pRequest?)
      => ComCall(9, this.p, IX509CertificateRequest, pRequest?)
    CreateRequest(Encoding, pValue)
      => ComCall(10, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    Enroll()
      => ComCall(11, this.p)
    InstallResponse(Restrictions, strResponse, Encoding, strPassword)
      => ComCall(12, this.p, InstallResponseRestrictionFlags, Restrictions, BSTR, strResponse, EncodingType, Encoding, BSTR, strPassword)
    CreatePFX(strPassword, ExportOptions, Encoding, pValue)
      => ComCall(13, this.p, BSTR, strPassword, PFXExportOptions, ExportOptions, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Request(pValue)
      => ComCall(14, this.p, IX509CertificateRequest.Ptr, pValue)
    get_Silent(pValue)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Silent(Value)
      => ComCall(16, this.p, VARIANT_BOOL, Value)
    get_ParentWindow(pValue)
      => ComCall(17, this.p, Int32.Ptr, pValue)
    put_ParentWindow(Value)
      => ComCall(18, this.p, Int32, Value)
    get_NameValuePairs(ppValue)
      => ComCall(19, this.p, IX509NameValuePairs.Ptr, ppValue)
    get_EnrollmentContext(pValue)
      => ComCall(20, this.p, X509CertificateEnrollmentContext.Ptr, pValue)
    get_Status(ppValue)
      => ComCall(21, this.p, IX509EnrollmentStatus.Ptr, ppValue)
    get_Certificate(Encoding, pValue)
      => ComCall(22, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Response(Encoding, pValue)
      => ComCall(23, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_CertificateFriendlyName(pValue)
      => ComCall(24, this.p, BSTR.Ptr, pValue)
    put_CertificateFriendlyName(strValue)
      => ComCall(25, this.p, BSTR, strValue)
    get_CertificateDescription(pValue)
      => ComCall(26, this.p, BSTR.Ptr, pValue)
    put_CertificateDescription(strValue)
      => ComCall(27, this.p, BSTR, strValue)
    get_RequestId(pValue)
      => ComCall(28, this.p, Int32.Ptr, pValue)
    get_CAConfigString(pValue)
      => ComCall(29, this.p, BSTR.Ptr, pValue)
}
struct IX509Enrollment2 extends IX509Enrollment {
    static IID := "{728AB350-217D-11DA-B2A4-000E7BBB2B09}"
    InitializeFromTemplate(context, pPolicyServer?, pTemplate?)
      => ComCall(30, this.p, X509CertificateEnrollmentContext, context, IX509EnrollmentPolicyServer, pPolicyServer?, IX509CertificateTemplate, pTemplate?)
    InstallResponse2(Restrictions, strResponse, Encoding, strPassword, strEnrollmentPolicyServerUrl, strEnrollmentPolicyServerID, EnrollmentPolicyServerFlags, authFlags)
      => ComCall(31, this.p, InstallResponseRestrictionFlags, Restrictions, BSTR, strResponse, EncodingType, Encoding, BSTR, strPassword, BSTR, strEnrollmentPolicyServerUrl, BSTR, strEnrollmentPolicyServerID, PolicyServerUrlFlags, EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags, authFlags)
    get_PolicyServer(ppPolicyServer)
      => ComCall(32, this.p, IX509EnrollmentPolicyServer.Ptr, ppPolicyServer)
    get_Template(ppTemplate)
      => ComCall(33, this.p, IX509CertificateTemplate.Ptr, ppTemplate)
    get_RequestIdString(pValue)
      => ComCall(34, this.p, BSTR.Ptr, pValue)
}
struct WebEnrollmentFlags extends Int32 {
    static EnrollPrompt := 1
}
struct IX509EnrollmentHelper extends IDispatch {
    static IID := "{728AB351-217D-11DA-B2A4-000E7BBB2B09}"
    AddPolicyServer(strEnrollmentPolicyServerURI, strEnrollmentPolicyID, EnrollmentPolicyServerFlags, authFlags, strCredential, strPassword)
      => ComCall(7, this.p, BSTR, strEnrollmentPolicyServerURI, BSTR, strEnrollmentPolicyID, PolicyServerUrlFlags, EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags, authFlags, BSTR, strCredential, BSTR, strPassword)
    AddEnrollmentServer(strEnrollmentServerURI, authFlags, strCredential, strPassword)
      => ComCall(8, this.p, BSTR, strEnrollmentServerURI, X509EnrollmentAuthFlags, authFlags, BSTR, strCredential, BSTR, strPassword)
    Enroll(strEnrollmentPolicyServerURI, strTemplateName, Encoding, enrollFlags, pstrCertificate)
      => ComCall(9, this.p, BSTR, strEnrollmentPolicyServerURI, BSTR, strTemplateName, EncodingType, Encoding, WebEnrollmentFlags, enrollFlags, BSTR.Ptr, pstrCertificate)
    Initialize(Context)
      => ComCall(10, this.p, X509CertificateEnrollmentContext, Context)
}
struct IX509EnrollmentWebClassFactory extends IDispatch {
    static IID := "{728AB349-217D-11DA-B2A4-000E7BBB2B09}"
    CreateObject(strProgID, ppIUnknown)
      => ComCall(7, this.p, BSTR, strProgID, IUnknown.Ptr, ppIUnknown)
}
struct IX509MachineEnrollmentFactory extends IDispatch {
    static IID := "{728AB352-217D-11DA-B2A4-000E7BBB2B09}"
    CreateObject(strProgID, ppIHelper)
      => ComCall(7, this.p, BSTR, strProgID, IX509EnrollmentHelper.Ptr, ppIHelper)
}
struct CRLRevocationReason extends Int32 {
    static XCN_CRL_REASON_UNSPECIFIED := 0
    static XCN_CRL_REASON_KEY_COMPROMISE := 1
    static XCN_CRL_REASON_CA_COMPROMISE := 2
    static XCN_CRL_REASON_AFFILIATION_CHANGED := 3
    static XCN_CRL_REASON_SUPERSEDED := 4
    static XCN_CRL_REASON_CESSATION_OF_OPERATION := 5
    static XCN_CRL_REASON_CERTIFICATE_HOLD := 6
    static XCN_CRL_REASON_REMOVE_FROM_CRL := 8
    static XCN_CRL_REASON_PRIVILEGE_WITHDRAWN := 9
    static XCN_CRL_REASON_AA_COMPROMISE := 10
}
struct IX509CertificateRevocationListEntry extends IDispatch {
    static IID := "{728AB35E-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(Encoding, SerialNumber, RevocationDate)
      => ComCall(7, this.p, EncodingType, Encoding, BSTR, SerialNumber, Float64, RevocationDate)
    get_SerialNumber(Encoding, pValue)
      => ComCall(8, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_RevocationDate(pValue)
      => ComCall(9, this.p, Float64.Ptr, pValue)
    get_RevocationReason(pValue)
      => ComCall(10, this.p, CRLRevocationReason.Ptr, pValue)
    put_RevocationReason(Value)
      => ComCall(11, this.p, CRLRevocationReason, Value)
    get_X509Extensions(ppValue)
      => ComCall(12, this.p, IX509Extensions.Ptr, ppValue)
    get_CriticalExtensions(ppValue)
      => ComCall(13, this.p, IObjectIds.Ptr, ppValue)
}
struct IX509CertificateRevocationListEntries extends IDispatch {
    static IID := "{728AB35F-217D-11DA-B2A4-000E7BBB2B09}"
    get_ItemByIndex(Index, pVal)
      => ComCall(7, this.p, Int32, Index, IX509CertificateRevocationListEntry.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get__NewEnum(pVal)
      => ComCall(9, this.p, IUnknown.Ptr, pVal)
    Add(pVal?)
      => ComCall(10, this.p, IX509CertificateRevocationListEntry, pVal?)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
    Clear()
      => ComCall(12, this.p)
    get_IndexBySerialNumber(Encoding, SerialNumber, pIndex)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR, SerialNumber, Int32.Ptr, pIndex)
    AddRange(pValue?)
      => ComCall(14, this.p, IX509CertificateRevocationListEntries, pValue?)
}
struct IX509CertificateRevocationList extends IDispatch {
    static IID := "{728AB360-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize()
      => ComCall(7, this.p)
    InitializeDecode(strEncodedData, Encoding)
      => ComCall(8, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    Encode()
      => ComCall(9, this.p)
    ResetForEncode()
      => ComCall(10, this.p)
    CheckPublicKeySignature(pPublicKey?)
      => ComCall(11, this.p, IX509PublicKey, pPublicKey?)
    CheckSignature()
      => ComCall(12, this.p)
    get_Issuer(ppValue)
      => ComCall(13, this.p, IX500DistinguishedName.Ptr, ppValue)
    put_Issuer(pValue?)
      => ComCall(14, this.p, IX500DistinguishedName, pValue?)
    get_ThisUpdate(pValue)
      => ComCall(15, this.p, Float64.Ptr, pValue)
    put_ThisUpdate(Value)
      => ComCall(16, this.p, Float64, Value)
    get_NextUpdate(pValue)
      => ComCall(17, this.p, Float64.Ptr, pValue)
    put_NextUpdate(Value)
      => ComCall(18, this.p, Float64, Value)
    get_X509CRLEntries(ppValue)
      => ComCall(19, this.p, IX509CertificateRevocationListEntries.Ptr, ppValue)
    get_X509Extensions(ppValue)
      => ComCall(20, this.p, IX509Extensions.Ptr, ppValue)
    get_CriticalExtensions(ppValue)
      => ComCall(21, this.p, IObjectIds.Ptr, ppValue)
    get_SignerCertificate(ppValue)
      => ComCall(22, this.p, ISignerCertificate.Ptr, ppValue)
    put_SignerCertificate(pValue?)
      => ComCall(23, this.p, ISignerCertificate, pValue?)
    get_CRLNumber(Encoding, pValue)
      => ComCall(24, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_CRLNumber(Encoding, Value)
      => ComCall(25, this.p, EncodingType, Encoding, BSTR, Value)
    get_CAVersion(pValue)
      => ComCall(26, this.p, Int32.Ptr, pValue)
    put_CAVersion(pValue)
      => ComCall(27, this.p, Int32, pValue)
    get_BaseCRL(pValue)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pValue)
    get_NullSigned(pValue)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pValue)
    get_HashAlgorithm(ppValue)
      => ComCall(30, this.p, IObjectId.Ptr, ppValue)
    put_HashAlgorithm(pValue?)
      => ComCall(31, this.p, IObjectId, pValue?)
    get_AlternateSignatureAlgorithm(pValue)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, pValue)
    put_AlternateSignatureAlgorithm(Value)
      => ComCall(33, this.p, VARIANT_BOOL, Value)
    get_SignatureInformation(ppValue)
      => ComCall(34, this.p, IX509SignatureInformation.Ptr, ppValue)
    get_RawData(Encoding, pValue)
      => ComCall(35, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_RawDataToBeSigned(Encoding, pValue)
      => ComCall(36, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Signature(Encoding, pValue)
      => ComCall(37, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
}
struct ICertificateAttestationChallenge extends IDispatch {
    static IID := "{6F175A7C-4A3A-40AE-9DBA-592FD6BBF9B8}"
    Initialize(Encoding, strPendingFullCmcResponseWithChallenge)
      => ComCall(7, this.p, EncodingType, Encoding, BSTR, strPendingFullCmcResponseWithChallenge)
    DecryptChallenge(Encoding, pstrEnvelopedPkcs7ReencryptedToCA)
      => ComCall(8, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEnvelopedPkcs7ReencryptedToCA)
    get_RequestID(pstrRequestID)
      => ComCall(9, this.p, BSTR.Ptr, pstrRequestID)
}
struct ICertificateAttestationChallenge2 extends ICertificateAttestationChallenge {
    static IID := "{4631334D-E266-47D6-BD79-BE53CB2E2753}"
    put_KeyContainerName(Value)
      => ComCall(10, this.p, BSTR, Value)
    put_KeyBlob(Encoding, Value)
      => ComCall(11, this.p, EncodingType, Encoding, BSTR, Value)
}
struct IX509SCEPEnrollment extends IDispatch {
    static IID := "{728AB361-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(pRequest?, strThumbprint, ThumprintEncoding, strServerCertificates, Encoding)
      => ComCall(7, this.p, IX509CertificateRequestPkcs10, pRequest?, BSTR, strThumbprint, EncodingType, ThumprintEncoding, BSTR, strServerCertificates, EncodingType, Encoding)
    InitializeForPending(Context)
      => ComCall(8, this.p, X509CertificateEnrollmentContext, Context)
    CreateRequestMessage(Encoding, pValue)
      => ComCall(9, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    CreateRetrievePendingMessage(Encoding, pValue)
      => ComCall(10, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    CreateRetrieveCertificateMessage(Context, strIssuer, IssuerEncoding, strSerialNumber, SerialNumberEncoding, Encoding, pValue)
      => ComCall(11, this.p, X509CertificateEnrollmentContext, Context, BSTR, strIssuer, EncodingType, IssuerEncoding, BSTR, strSerialNumber, EncodingType, SerialNumberEncoding, EncodingType, Encoding, BSTR.Ptr, pValue)
    ProcessResponseMessage(strResponse, Encoding, pDisposition)
      => ComCall(12, this.p, BSTR, strResponse, EncodingType, Encoding, X509SCEPDisposition.Ptr, pDisposition)
    put_ServerCapabilities(Value)
      => ComCall(13, this.p, BSTR, Value)
    get_FailInfo(pValue)
      => ComCall(14, this.p, X509SCEPFailInfo.Ptr, pValue)
    get_SignerCertificate(ppValue)
      => ComCall(15, this.p, ISignerCertificate.Ptr, ppValue)
    put_SignerCertificate(pValue?)
      => ComCall(16, this.p, ISignerCertificate, pValue?)
    get_OldCertificate(ppValue)
      => ComCall(17, this.p, ISignerCertificate.Ptr, ppValue)
    put_OldCertificate(pValue?)
      => ComCall(18, this.p, ISignerCertificate, pValue?)
    get_TransactionId(Encoding, pValue)
      => ComCall(19, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    put_TransactionId(Encoding, Value)
      => ComCall(20, this.p, EncodingType, Encoding, BSTR, Value)
    get_Request(ppValue)
      => ComCall(21, this.p, IX509CertificateRequestPkcs10.Ptr, ppValue)
    get_CertificateFriendlyName(pValue)
      => ComCall(22, this.p, BSTR.Ptr, pValue)
    put_CertificateFriendlyName(Value)
      => ComCall(23, this.p, BSTR, Value)
    get_Status(ppValue)
      => ComCall(24, this.p, IX509EnrollmentStatus.Ptr, ppValue)
    get_Certificate(Encoding, pValue)
      => ComCall(25, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    get_Silent(pValue)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pValue)
    put_Silent(Value)
      => ComCall(27, this.p, VARIANT_BOOL, Value)
    DeleteRequest()
      => ComCall(28, this.p)
}
struct X509SCEPProcessMessageFlags extends Int32 {
    static SCEPProcessDefault := 0
    static SCEPProcessSkipCertInstall := 1
}
struct DelayRetryAction extends Int32 {
    static DelayRetryUnknown := 0
    static DelayRetryNone := 1
    static DelayRetryShort := 2
    static DelayRetryLong := 3
    static DelayRetrySuccess := 4
    static DelayRetryPastSuccess := 5
}
struct IX509SCEPEnrollment2 extends IX509SCEPEnrollment {
    static IID := "{728AB364-217D-11DA-B2A4-000E7BBB2B09}"
    CreateChallengeAnswerMessage(Encoding, pValue)
      => ComCall(29, this.p, EncodingType, Encoding, BSTR.Ptr, pValue)
    ProcessResponseMessage2(Flags, strResponse, Encoding, pDisposition)
      => ComCall(30, this.p, X509SCEPProcessMessageFlags, Flags, BSTR, strResponse, EncodingType, Encoding, X509SCEPDisposition.Ptr, pDisposition)
    get_ResultMessageText(pValue)
      => ComCall(31, this.p, BSTR.Ptr, pValue)
    get_DelayRetry(pValue)
      => ComCall(32, this.p, DelayRetryAction.Ptr, pValue)
    get_ActivityId(pValue)
      => ComCall(33, this.p, BSTR.Ptr, pValue)
    put_ActivityId(Value)
      => ComCall(34, this.p, BSTR, Value)
}
struct IX509SCEPEnrollmentHelper extends IDispatch {
    static IID := "{728AB365-217D-11DA-B2A4-000E7BBB2B09}"
    Initialize(strServerUrl, strRequestHeaders, pRequest?, strCACertificateThumbprint)
      => ComCall(7, this.p, BSTR, strServerUrl, BSTR, strRequestHeaders, IX509CertificateRequestPkcs10, pRequest?, BSTR, strCACertificateThumbprint)
    InitializeForPending(strServerUrl, strRequestHeaders, Context, strTransactionId)
      => ComCall(8, this.p, BSTR, strServerUrl, BSTR, strRequestHeaders, X509CertificateEnrollmentContext, Context, BSTR, strTransactionId)
    Enroll(ProcessFlags, pDisposition)
      => ComCall(9, this.p, X509SCEPProcessMessageFlags, ProcessFlags, X509SCEPDisposition.Ptr, pDisposition)
    FetchPending(ProcessFlags, pDisposition)
      => ComCall(10, this.p, X509SCEPProcessMessageFlags, ProcessFlags, X509SCEPDisposition.Ptr, pDisposition)
    get_X509SCEPEnrollment(ppValue)
      => ComCall(11, this.p, IX509SCEPEnrollment.Ptr, ppValue)
    get_ResultMessageText(pValue)
      => ComCall(12, this.p, BSTR.Ptr, pValue)
}
struct X509CertificateTemplateGeneralFlag extends Int32 {
    static GeneralMachineType := 64
    static GeneralCA := 128
    static GeneralCrossCA := 2048
    static GeneralDefault := 65536
    static GeneralModified := 131072
    static GeneralDonotPersist := 4096
}
struct X509CertificateTemplateEnrollmentFlag extends Int32 {
    static EnrollmentIncludeSymmetricAlgorithms := 1
    static EnrollmentPendAllRequests := 2
    static EnrollmentPublishToKRAContainer := 4
    static EnrollmentPublishToDS := 8
    static EnrollmentAutoEnrollmentCheckUserDSCertificate := 16
    static EnrollmentAutoEnrollment := 32
    static EnrollmentDomainAuthenticationNotRequired := 128
    static EnrollmentPreviousApprovalValidateReenrollment := 64
    static EnrollmentUserInteractionRequired := 256
    static EnrollmentAddTemplateName := 512
    static EnrollmentRemoveInvalidCertificateFromPersonalStore := 1024
    static EnrollmentAllowEnrollOnBehalfOf := 2048
    static EnrollmentAddOCSPNoCheck := 4096
    static EnrollmentReuseKeyOnFullSmartCard := 8192
    static EnrollmentNoRevocationInfoInCerts := 16384
    static EnrollmentIncludeBasicConstraintsForEECerts := 32768
    static EnrollmentPreviousApprovalKeyBasedValidateReenrollment := 65536
    static EnrollmentCertificateIssuancePoliciesFromRequest := 131072
    static EnrollmentSkipAutoRenewal := 262144
}
struct X509CertificateTemplateSubjectNameFlag extends Int32 {
    static SubjectNameEnrolleeSupplies := 1
    static SubjectNameRequireDirectoryPath := -2147483648
    static SubjectNameRequireCommonName := 1073741824
    static SubjectNameRequireEmail := 536870912
    static SubjectNameRequireDNS := 268435456
    static SubjectNameAndAlternativeNameOldCertSupplies := 8
    static SubjectAlternativeNameEnrolleeSupplies := 65536
    static SubjectAlternativeNameRequireDirectoryGUID := 16777216
    static SubjectAlternativeNameRequireUPN := 33554432
    static SubjectAlternativeNameRequireEmail := 67108864
    static SubjectAlternativeNameRequireSPN := 8388608
    static SubjectAlternativeNameRequireDNS := 134217728
    static SubjectAlternativeNameRequireDomainDNS := 4194304
}
struct X509CertificateTemplatePrivateKeyFlag extends Int32 {
    static PrivateKeyRequireArchival := 1
    static PrivateKeyExportable := 16
    static PrivateKeyRequireStrongKeyProtection := 32
    static PrivateKeyRequireAlternateSignatureAlgorithm := 64
    static PrivateKeyRequireSameKeyRenewal := 128
    static PrivateKeyUseLegacyProvider := 256
    static PrivateKeyEKTrustOnUse := 512
    static PrivateKeyEKValidateCert := 1024
    static PrivateKeyEKValidateKey := 2048
    static PrivateKeyAttestNone := 0
    static PrivateKeyAttestPreferred := 4096
    static PrivateKeyAttestRequired := 8192
    static PrivateKeyAttestMask := 12288
    static PrivateKeyAttestWithoutPolicy := 16384
    static PrivateKeyServerVersionMask := 983040
    static PrivateKeyServerVersionShift := 16
    static PrivateKeyHelloKspKey := 1048576
    static PrivateKeyHelloLogonKey := 2097152
    static PrivateKeyClientVersionMask := 251658240
    static PrivateKeyClientVersionShift := 24
}
struct ImportPFXFlags extends Int32 {
    static ImportNone := 0
    static ImportMachineContext := 1
    static ImportForceOverwrite := 2
    static ImportSilent := 4
    static ImportSaveProperties := 8
    static ImportExportable := 16
    static ImportExportableEncrypted := 32
    static ImportNoUserProtected := 64
    static ImportUserProtected := 128
    static ImportUserProtectedHigh := 256
    static ImportInstallCertificate := 512
    static ImportInstallChain := 1024
    static ImportInstallChainAndRoot := 2048
}
struct FNIMPORTPFXTOPROVIDER extends FunctionPointer {
    static Types := [HWND, UInt8.Ptr, UInt32, ImportPFXFlags, PWSTR, PWSTR, PWSTR, PWSTR, PWSTR, PWSTR, UInt32.Ptr, CERT_CONTEXT.Ptr.Ptr.Ptr, HRESULT]
}
struct FNIMPORTPFXTOPROVIDERFREEDATA extends FunctionPointer {
    static Types := [UInt32, CERT_CONTEXT.Ptr.Ptr, "Void"]
}
struct ICertEncodeStringArray extends IDispatch {
    static IID := "{12A88820-7494-11D0-8816-00A0C903B83C}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetStringType(pStringType)
      => ComCall(8, this.p, Int32.Ptr, pStringType)
    GetCount(pCount)
      => ComCall(9, this.p, Int32.Ptr, pCount)
    GetValue(Index, pstr)
      => ComCall(10, this.p, Int32, Index, BSTR.Ptr, pstr)
    Reset(Count, StringType)
      => ComCall(11, this.p, Int32, Count, CERT_RDN_ATTR_VALUE_TYPE, StringType)
    SetValue(Index, str)
      => ComCall(12, this.p, Int32, Index, BSTR, str)
    Encode(pstrBinary)
      => ComCall(13, this.p, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeStringArray2 extends ICertEncodeStringArray {
    static IID := "{9C680D93-9B7D-4E95-9018-4FFE10BA5ADA}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(14, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(Encoding, pstrEncodedData)
      => ComCall(15, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
}
struct ICertEncodeLongArray extends IDispatch {
    static IID := "{15E2F230-A0A2-11D0-8821-00A0C903B83C}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetCount(pCount)
      => ComCall(8, this.p, Int32.Ptr, pCount)
    GetValue(Index, pValue)
      => ComCall(9, this.p, Int32, Index, Int32.Ptr, pValue)
    Reset(Count)
      => ComCall(10, this.p, Int32, Count)
    SetValue(Index, Value)
      => ComCall(11, this.p, Int32, Index, Int32, Value)
    Encode(pstrBinary)
      => ComCall(12, this.p, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeLongArray2 extends ICertEncodeLongArray {
    static IID := "{4EFDE84A-BD9B-4FC2-A108-C347D478840F}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(13, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(Encoding, pstrEncodedData)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
}
struct ICertEncodeDateArray extends IDispatch {
    static IID := "{2F9469A0-A470-11D0-8821-00A0C903B83C}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetCount(pCount)
      => ComCall(8, this.p, Int32.Ptr, pCount)
    GetValue(Index, pValue)
      => ComCall(9, this.p, Int32, Index, Float64.Ptr, pValue)
    Reset(Count)
      => ComCall(10, this.p, Int32, Count)
    SetValue(Index, Value)
      => ComCall(11, this.p, Int32, Index, Float64, Value)
    Encode(pstrBinary)
      => ComCall(12, this.p, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeDateArray2 extends ICertEncodeDateArray {
    static IID := "{99A4EDB5-2B8E-448D-BF95-BBA8D7789DC8}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(13, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(Encoding, pstrEncodedData)
      => ComCall(14, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
}
struct ICertEncodeCRLDistInfo extends IDispatch {
    static IID := "{01958640-BBFF-11D0-8825-00A0C903B83C}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetDistPointCount(pDistPointCount)
      => ComCall(8, this.p, Int32.Ptr, pDistPointCount)
    GetNameCount(DistPointIndex, pNameCount)
      => ComCall(9, this.p, Int32, DistPointIndex, Int32.Ptr, pNameCount)
    GetNameChoice(DistPointIndex, NameIndex, pNameChoice)
      => ComCall(10, this.p, Int32, DistPointIndex, Int32, NameIndex, Int32.Ptr, pNameChoice)
    GetName(DistPointIndex, NameIndex, pstrName)
      => ComCall(11, this.p, Int32, DistPointIndex, Int32, NameIndex, BSTR.Ptr, pstrName)
    Reset(DistPointCount)
      => ComCall(12, this.p, Int32, DistPointCount)
    SetNameCount(DistPointIndex, NameCount)
      => ComCall(13, this.p, Int32, DistPointIndex, Int32, NameCount)
    SetNameEntry(DistPointIndex, NameIndex, NameChoice, strName)
      => ComCall(14, this.p, Int32, DistPointIndex, Int32, NameIndex, CERT_ALT_NAME, NameChoice, BSTR, strName)
    Encode(pstrBinary)
      => ComCall(15, this.p, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeCRLDistInfo2 extends ICertEncodeCRLDistInfo {
    static IID := "{B4275D4B-3E30-446F-AD36-09D03120B078}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(16, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(Encoding, pstrEncodedData)
      => ComCall(17, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
}
struct ICertEncodeAltName extends IDispatch {
    static IID := "{1C9A8C70-1271-11D1-9BD4-00C04FB683FA}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetNameCount(pNameCount)
      => ComCall(8, this.p, Int32.Ptr, pNameCount)
    GetNameChoice(NameIndex, pNameChoice)
      => ComCall(9, this.p, Int32, NameIndex, Int32.Ptr, pNameChoice)
    GetName(NameIndex, pstrName)
      => ComCall(10, this.p, Int32, NameIndex, BSTR.Ptr, pstrName)
    Reset(NameCount)
      => ComCall(11, this.p, Int32, NameCount)
    SetNameEntry(NameIndex, NameChoice, strName)
      => ComCall(12, this.p, Int32, NameIndex, CERT_ALT_NAME, NameChoice, BSTR, strName)
    Encode(pstrBinary)
      => ComCall(13, this.p, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeAltName2 extends ICertEncodeAltName {
    static IID := "{F67FE177-5EF1-4535-B4CE-29DF15E2E0C3}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(14, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(Encoding, pstrEncodedData)
      => ComCall(15, this.p, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
    GetNameBlob(NameIndex, Encoding, pstrName)
      => ComCall(16, this.p, Int32, NameIndex, EncodingType, Encoding, BSTR.Ptr, pstrName)
    SetNameEntryBlob(NameIndex, NameChoice, strName, Encoding)
      => ComCall(17, this.p, Int32, NameIndex, Int32, NameChoice, BSTR, strName, EncodingType, Encoding)
}
struct ICertEncodeBitString extends IDispatch {
    static IID := "{6DB525BE-1278-11D1-9BD4-00C04FB683FA}"
    Decode(strBinary)
      => ComCall(7, this.p, BSTR, strBinary)
    GetBitCount(pBitCount)
      => ComCall(8, this.p, Int32.Ptr, pBitCount)
    GetBitString(pstrBitString)
      => ComCall(9, this.p, BSTR.Ptr, pstrBitString)
    Encode(BitCount, strBitString, pstrBinary)
      => ComCall(10, this.p, Int32, BitCount, BSTR, strBitString, BSTR.Ptr, pstrBinary)
}
struct ICertEncodeBitString2 extends ICertEncodeBitString {
    static IID := "{E070D6E7-23EF-4DD2-8242-EBD9C928CB30}"
    DecodeBlob(strEncodedData, Encoding)
      => ComCall(11, this.p, BSTR, strEncodedData, EncodingType, Encoding)
    EncodeBlob(BitCount, strBitString, EncodingIn, Encoding, pstrEncodedData)
      => ComCall(12, this.p, Int32, BitCount, BSTR, strBitString, EncodingType, EncodingIn, EncodingType, Encoding, BSTR.Ptr, pstrEncodedData)
    GetBitStringBlob(Encoding, pstrBitString)
      => ComCall(13, this.p, EncodingType, Encoding, BSTR.Ptr, pstrBitString)
}
struct ICertExit extends IDispatch {
    static IID := "{E19AE1A0-7364-11D0-8816-00A0C903B83C}"
    Initialize(strConfig, pEventMask)
      => ComCall(7, this.p, BSTR, strConfig, CERT_EXIT_EVENT_MASK.Ptr, pEventMask)
    Notify(ExitEvent, Context)
      => ComCall(8, this.p, Int32, ExitEvent, Int32, Context)
    GetDescription(pstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pstrDescription)
}
struct ICertExit2 extends ICertExit {
    static IID := "{0ABF484B-D049-464D-A7ED-552E7529B0FF}"
    GetManageModule(ppManageModule)
      => ComCall(10, this.p, ICertManageModule.Ptr, ppManageModule)
}
struct ENUM_CATYPES extends Int32 {
    static ENUM_ENTERPRISE_ROOTCA := 0
    static ENUM_ENTERPRISE_SUBCA := 1
    static ENUM_STANDALONE_ROOTCA := 3
    static ENUM_STANDALONE_SUBCA := 4
    static ENUM_UNKNOWN_CA := 5
}
struct CAINFO {
    cbSize : UInt32 := this.Size
    CAType : ENUM_CATYPES
    cCASignatureCerts : UInt32
    cCAExchangeCerts : UInt32
    cExitModules : UInt32
    lPropIdMax : Int32
    lRoleSeparationEnabled : Int32
    cKRACertUsedCount : UInt32
    cKRACertCount : UInt32
    fAdvancedServer : UInt32
}
struct ICEnroll extends IDispatch {
    static IID := "{43F8F288-7A20-11D0-8F06-00C04FC295E1}"
    createFilePKCS10(DNName, Usage, wszPKCS10FileName)
      => ComCall(7, this.p, BSTR, DNName, BSTR, Usage, BSTR, wszPKCS10FileName)
    acceptFilePKCS7(wszPKCS7FileName)
      => ComCall(8, this.p, BSTR, wszPKCS7FileName)
    createPKCS10(DNName, Usage, pPKCS10)
      => ComCall(9, this.p, BSTR, DNName, BSTR, Usage, BSTR.Ptr, pPKCS10)
    acceptPKCS7(PKCS7)
      => ComCall(10, this.p, BSTR, PKCS7)
    getCertFromPKCS7(wszPKCS7, pbstrCert)
      => ComCall(11, this.p, BSTR, wszPKCS7, BSTR.Ptr, pbstrCert)
    enumProviders(dwIndex, dwFlags, pbstrProvName)
      => ComCall(12, this.p, Int32, dwIndex, Int32, dwFlags, BSTR.Ptr, pbstrProvName)
    enumContainers(dwIndex, pbstr)
      => ComCall(13, this.p, Int32, dwIndex, BSTR.Ptr, pbstr)
    freeRequestInfo(PKCS7OrPKCS10)
      => ComCall(14, this.p, BSTR, PKCS7OrPKCS10)
    get_MyStoreName(pbstrName)
      => ComCall(15, this.p, BSTR.Ptr, pbstrName)
    put_MyStoreName(bstrName)
      => ComCall(16, this.p, BSTR, bstrName)
    get_MyStoreType(pbstrType)
      => ComCall(17, this.p, BSTR.Ptr, pbstrType)
    put_MyStoreType(bstrType)
      => ComCall(18, this.p, BSTR, bstrType)
    get_MyStoreFlags(pdwFlags)
      => ComCall(19, this.p, Int32.Ptr, pdwFlags)
    put_MyStoreFlags(dwFlags)
      => ComCall(20, this.p, Int32, dwFlags)
    get_CAStoreName(pbstrName)
      => ComCall(21, this.p, BSTR.Ptr, pbstrName)
    put_CAStoreName(bstrName)
      => ComCall(22, this.p, BSTR, bstrName)
    get_CAStoreType(pbstrType)
      => ComCall(23, this.p, BSTR.Ptr, pbstrType)
    put_CAStoreType(bstrType)
      => ComCall(24, this.p, BSTR, bstrType)
    get_CAStoreFlags(pdwFlags)
      => ComCall(25, this.p, Int32.Ptr, pdwFlags)
    put_CAStoreFlags(dwFlags)
      => ComCall(26, this.p, Int32, dwFlags)
    get_RootStoreName(pbstrName)
      => ComCall(27, this.p, BSTR.Ptr, pbstrName)
    put_RootStoreName(bstrName)
      => ComCall(28, this.p, BSTR, bstrName)
    get_RootStoreType(pbstrType)
      => ComCall(29, this.p, BSTR.Ptr, pbstrType)
    put_RootStoreType(bstrType)
      => ComCall(30, this.p, BSTR, bstrType)
    get_RootStoreFlags(pdwFlags)
      => ComCall(31, this.p, Int32.Ptr, pdwFlags)
    put_RootStoreFlags(dwFlags)
      => ComCall(32, this.p, Int32, dwFlags)
    get_RequestStoreName(pbstrName)
      => ComCall(33, this.p, BSTR.Ptr, pbstrName)
    put_RequestStoreName(bstrName)
      => ComCall(34, this.p, BSTR, bstrName)
    get_RequestStoreType(pbstrType)
      => ComCall(35, this.p, BSTR.Ptr, pbstrType)
    put_RequestStoreType(bstrType)
      => ComCall(36, this.p, BSTR, bstrType)
    get_RequestStoreFlags(pdwFlags)
      => ComCall(37, this.p, Int32.Ptr, pdwFlags)
    put_RequestStoreFlags(dwFlags)
      => ComCall(38, this.p, Int32, dwFlags)
    get_ContainerName(pbstrContainer)
      => ComCall(39, this.p, BSTR.Ptr, pbstrContainer)
    put_ContainerName(bstrContainer)
      => ComCall(40, this.p, BSTR, bstrContainer)
    get_ProviderName(pbstrProvider)
      => ComCall(41, this.p, BSTR.Ptr, pbstrProvider)
    put_ProviderName(bstrProvider)
      => ComCall(42, this.p, BSTR, bstrProvider)
    get_ProviderType(pdwType)
      => ComCall(43, this.p, Int32.Ptr, pdwType)
    put_ProviderType(dwType)
      => ComCall(44, this.p, Int32, dwType)
    get_KeySpec(pdw)
      => ComCall(45, this.p, Int32.Ptr, pdw)
    put_KeySpec(dw)
      => ComCall(46, this.p, Int32, dw)
    get_ProviderFlags(pdwFlags)
      => ComCall(47, this.p, Int32.Ptr, pdwFlags)
    put_ProviderFlags(dwFlags)
      => ComCall(48, this.p, Int32, dwFlags)
    get_UseExistingKeySet(fUseExistingKeys)
      => ComCall(49, this.p, BOOL.Ptr, fUseExistingKeys)
    put_UseExistingKeySet(fUseExistingKeys)
      => ComCall(50, this.p, BOOL, fUseExistingKeys)
    get_GenKeyFlags(pdwFlags)
      => ComCall(51, this.p, Int32.Ptr, pdwFlags)
    put_GenKeyFlags(dwFlags)
      => ComCall(52, this.p, Int32, dwFlags)
    get_DeleteRequestCert(fDelete)
      => ComCall(53, this.p, BOOL.Ptr, fDelete)
    put_DeleteRequestCert(fDelete)
      => ComCall(54, this.p, BOOL, fDelete)
    get_WriteCertToCSP(fBool)
      => ComCall(55, this.p, BOOL.Ptr, fBool)
    put_WriteCertToCSP(fBool)
      => ComCall(56, this.p, BOOL, fBool)
    get_SPCFileName(pbstr)
      => ComCall(57, this.p, BSTR.Ptr, pbstr)
    put_SPCFileName(bstr1)
      => ComCall(58, this.p, BSTR, bstr1)
    get_PVKFileName(pbstr)
      => ComCall(59, this.p, BSTR.Ptr, pbstr)
    put_PVKFileName(bstr1)
      => ComCall(60, this.p, BSTR, bstr1)
    get_HashAlgorithm(pbstr)
      => ComCall(61, this.p, BSTR.Ptr, pbstr)
    put_HashAlgorithm(bstr1)
      => ComCall(62, this.p, BSTR, bstr1)
}
struct ICEnroll2 extends ICEnroll {
    static IID := "{704CA730-C90B-11D1-9BEC-00C04FC295E1}"
    addCertTypeToRequest(CertType)
      => ComCall(63, this.p, BSTR, CertType)
    addNameValuePairToSignature(Name, Value)
      => ComCall(64, this.p, BSTR, Name, BSTR, Value)
    get_WriteCertToUserDS(fBool)
      => ComCall(65, this.p, BOOL.Ptr, fBool)
    put_WriteCertToUserDS(fBool)
      => ComCall(66, this.p, BOOL, fBool)
    get_EnableT61DNEncoding(fBool)
      => ComCall(67, this.p, BOOL.Ptr, fBool)
    put_EnableT61DNEncoding(fBool)
      => ComCall(68, this.p, BOOL, fBool)
}
struct ICEnroll3 extends ICEnroll2 {
    static IID := "{C28C2D95-B7DE-11D2-A421-00C04F79FE8E}"
    InstallPKCS7(PKCS7)
      => ComCall(69, this.p, BSTR, PKCS7)
    Reset()
      => ComCall(70, this.p)
    GetSupportedKeySpec(pdwKeySpec)
      => ComCall(71, this.p, Int32.Ptr, pdwKeySpec)
    GetKeyLen(fMin, fExchange, pdwKeySize)
      => ComCall(72, this.p, BOOL, fMin, BOOL, fExchange, Int32.Ptr, pdwKeySize)
    EnumAlgs(dwIndex, algClass, pdwAlgID)
      => ComCall(73, this.p, Int32, dwIndex, Int32, algClass, Int32.Ptr, pdwAlgID)
    GetAlgName(algID, pbstr)
      => ComCall(74, this.p, Int32, algID, BSTR.Ptr, pbstr)
    put_ReuseHardwareKeyIfUnableToGenNew(fReuseHardwareKeyIfUnableToGenNew)
      => ComCall(75, this.p, BOOL, fReuseHardwareKeyIfUnableToGenNew)
    get_ReuseHardwareKeyIfUnableToGenNew(fReuseHardwareKeyIfUnableToGenNew)
      => ComCall(76, this.p, BOOL.Ptr, fReuseHardwareKeyIfUnableToGenNew)
    put_HashAlgID(hashAlgID)
      => ComCall(77, this.p, Int32, hashAlgID)
    get_HashAlgID(hashAlgID)
      => ComCall(78, this.p, Int32.Ptr, hashAlgID)
    put_LimitExchangeKeyToEncipherment(fLimitExchangeKeyToEncipherment)
      => ComCall(79, this.p, BOOL, fLimitExchangeKeyToEncipherment)
    get_LimitExchangeKeyToEncipherment(fLimitExchangeKeyToEncipherment)
      => ComCall(80, this.p, BOOL.Ptr, fLimitExchangeKeyToEncipherment)
    put_EnableSMIMECapabilities(fEnableSMIMECapabilities)
      => ComCall(81, this.p, BOOL, fEnableSMIMECapabilities)
    get_EnableSMIMECapabilities(fEnableSMIMECapabilities)
      => ComCall(82, this.p, BOOL.Ptr, fEnableSMIMECapabilities)
}
struct ICEnroll4 extends ICEnroll3 {
    static IID := "{C1F1188A-2EB5-4A80-841B-7E729A356D90}"
    put_PrivateKeyArchiveCertificate(bstrCert)
      => ComCall(83, this.p, BSTR, bstrCert)
    get_PrivateKeyArchiveCertificate(pbstrCert)
      => ComCall(84, this.p, BSTR.Ptr, pbstrCert)
    put_ThumbPrint(bstrThumbPrint)
      => ComCall(85, this.p, BSTR, bstrThumbPrint)
    get_ThumbPrint(pbstrThumbPrint)
      => ComCall(86, this.p, BSTR.Ptr, pbstrThumbPrint)
    binaryToString(Flags, strBinary, pstrEncoded)
      => ComCall(87, this.p, Int32, Flags, BSTR, strBinary, BSTR.Ptr, pstrEncoded)
    stringToBinary(Flags, strEncoded, pstrBinary)
      => ComCall(88, this.p, Int32, Flags, BSTR, strEncoded, BSTR.Ptr, pstrBinary)
    addExtensionToRequest(Flags, strName, strValue)
      => ComCall(89, this.p, Int32, Flags, BSTR, strName, BSTR, strValue)
    addAttributeToRequest(Flags, strName, strValue)
      => ComCall(90, this.p, Int32, Flags, BSTR, strName, BSTR, strValue)
    addNameValuePairToRequest(Flags, strName, strValue)
      => ComCall(91, this.p, Int32, Flags, BSTR, strName, BSTR, strValue)
    resetExtensions()
      => ComCall(92, this.p)
    resetAttributes()
      => ComCall(93, this.p)
    createRequest(Flags, strDNName, Usage, pstrRequest)
      => ComCall(94, this.p, CERT_CREATE_REQUEST_FLAGS, Flags, BSTR, strDNName, BSTR, Usage, BSTR.Ptr, pstrRequest)
    createFileRequest(Flags, strDNName, strUsage, strRequestFileName)
      => ComCall(95, this.p, CERT_CREATE_REQUEST_FLAGS, Flags, BSTR, strDNName, BSTR, strUsage, BSTR, strRequestFileName)
    acceptResponse(strResponse)
      => ComCall(96, this.p, BSTR, strResponse)
    acceptFileResponse(strResponseFileName)
      => ComCall(97, this.p, BSTR, strResponseFileName)
    getCertFromResponse(strResponse, pstrCert)
      => ComCall(98, this.p, BSTR, strResponse, BSTR.Ptr, pstrCert)
    getCertFromFileResponse(strResponseFileName, pstrCert)
      => ComCall(99, this.p, BSTR, strResponseFileName, BSTR.Ptr, pstrCert)
    createPFX(strPassword, pstrPFX)
      => ComCall(100, this.p, BSTR, strPassword, BSTR.Ptr, pstrPFX)
    createFilePFX(strPassword, strPFXFileName)
      => ComCall(101, this.p, BSTR, strPassword, BSTR, strPFXFileName)
    setPendingRequestInfo(lRequestID, strCADNS, strCAName, strFriendlyName)
      => ComCall(102, this.p, Int32, lRequestID, BSTR, strCADNS, BSTR, strCAName, BSTR, strFriendlyName)
    enumPendingRequest(lIndex, lDesiredProperty, pvarProperty)
      => ComCall(103, this.p, Int32, lIndex, PENDING_REQUEST_DESIRED_PROPERTY, lDesiredProperty, VARIANT.Ptr, pvarProperty)
    removePendingRequest(strThumbprint)
      => ComCall(104, this.p, BSTR, strThumbprint)
    GetKeyLenEx(lSizeSpec, lKeySpec, pdwKeySize)
      => ComCall(105, this.p, XEKL_KEYSIZE, lSizeSpec, XEKL_KEYSPEC, lKeySpec, Int32.Ptr, pdwKeySize)
    InstallPKCS7Ex(PKCS7, plCertInstalled)
      => ComCall(106, this.p, BSTR, PKCS7, Int32.Ptr, plCertInstalled)
    addCertTypeToRequestEx(lType, bstrOIDOrName, lMajorVersion, fMinorVersion, lMinorVersion)
      => ComCall(107, this.p, ADDED_CERT_TYPE, lType, BSTR, bstrOIDOrName, Int32, lMajorVersion, BOOL, fMinorVersion, Int32, lMinorVersion)
    getProviderType(strProvName, plProvType)
      => ComCall(108, this.p, BSTR, strProvName, Int32.Ptr, plProvType)
    put_SignerCertificate(bstrCert)
      => ComCall(109, this.p, BSTR, bstrCert)
    put_ClientId(lClientId)
      => ComCall(110, this.p, Int32, lClientId)
    get_ClientId(plClientId)
      => ComCall(111, this.p, Int32.Ptr, plClientId)
    addBlobPropertyToCertificate(lPropertyId, lReserved, bstrProperty)
      => ComCall(112, this.p, Int32, lPropertyId, Int32, lReserved, BSTR, bstrProperty)
    resetBlobProperties()
      => ComCall(113, this.p)
    put_IncludeSubjectKeyID(fInclude)
      => ComCall(114, this.p, BOOL, fInclude)
    get_IncludeSubjectKeyID(pfInclude)
      => ComCall(115, this.p, BOOL.Ptr, pfInclude)
}
struct IEnroll extends IUnknown {
    static IID := "{ACAA7838-4585-11D1-AB57-00C04FC295E1}"
    createFilePKCS10WStr(DNName, Usage, wszPKCS10FileName)
      => ComCall(3, this.p, "Str", DNName, "Str", Usage, "Str", wszPKCS10FileName)
    acceptFilePKCS7WStr(wszPKCS7FileName)
      => ComCall(4, this.p, "Str", wszPKCS7FileName)
    createPKCS10WStr(DNName, Usage, pPkcs10Blob)
      => ComCall(5, this.p, "Str", DNName, "Str", Usage, CRYPT_INTEGER_BLOB.Ptr, pPkcs10Blob)
    acceptPKCS7Blob(pBlobPKCS7)
      => ComCall(6, this.p, CRYPT_INTEGER_BLOB.Ptr, pBlobPKCS7)
    getCertContextFromPKCS7(pBlobPKCS7)
      => ComCall(7, this.p, CRYPT_INTEGER_BLOB.Ptr, pBlobPKCS7, CERT_CONTEXT.Ptr)
    getMyStore()
      => ComCall(8, this.p, HCERTSTORE)
    getCAStore()
      => ComCall(9, this.p, HCERTSTORE)
    getROOTHStore()
      => ComCall(10, this.p, HCERTSTORE)
    enumProvidersWStr(dwIndex, dwFlags, pbstrProvName)
      => ComCall(11, this.p, Int32, dwIndex, Int32, dwFlags, PWSTR.Ptr, pbstrProvName)
    enumContainersWStr(dwIndex, pbstr)
      => ComCall(12, this.p, Int32, dwIndex, PWSTR.Ptr, pbstr)
    freeRequestInfoBlob(pkcs7OrPkcs10)
      => ComCall(13, this.p, CRYPT_INTEGER_BLOB, pkcs7OrPkcs10)
    get_MyStoreNameWStr(szwName)
      => ComCall(14, this.p, PWSTR.Ptr, szwName)
    put_MyStoreNameWStr(szwName)
      => ComCall(15, this.p, "Str", szwName)
    get_MyStoreTypeWStr(szwType)
      => ComCall(16, this.p, PWSTR.Ptr, szwType)
    put_MyStoreTypeWStr(szwType)
      => ComCall(17, this.p, "Str", szwType)
    get_MyStoreFlags(pdwFlags)
      => ComCall(18, this.p, Int32.Ptr, pdwFlags)
    put_MyStoreFlags(dwFlags)
      => ComCall(19, this.p, Int32, dwFlags)
    get_CAStoreNameWStr(szwName)
      => ComCall(20, this.p, PWSTR.Ptr, szwName)
    put_CAStoreNameWStr(szwName)
      => ComCall(21, this.p, "Str", szwName)
    get_CAStoreTypeWStr(szwType)
      => ComCall(22, this.p, PWSTR.Ptr, szwType)
    put_CAStoreTypeWStr(szwType)
      => ComCall(23, this.p, "Str", szwType)
    get_CAStoreFlags(pdwFlags)
      => ComCall(24, this.p, Int32.Ptr, pdwFlags)
    put_CAStoreFlags(dwFlags)
      => ComCall(25, this.p, Int32, dwFlags)
    get_RootStoreNameWStr(szwName)
      => ComCall(26, this.p, PWSTR.Ptr, szwName)
    put_RootStoreNameWStr(szwName)
      => ComCall(27, this.p, "Str", szwName)
    get_RootStoreTypeWStr(szwType)
      => ComCall(28, this.p, PWSTR.Ptr, szwType)
    put_RootStoreTypeWStr(szwType)
      => ComCall(29, this.p, "Str", szwType)
    get_RootStoreFlags(pdwFlags)
      => ComCall(30, this.p, Int32.Ptr, pdwFlags)
    put_RootStoreFlags(dwFlags)
      => ComCall(31, this.p, Int32, dwFlags)
    get_RequestStoreNameWStr(szwName)
      => ComCall(32, this.p, PWSTR.Ptr, szwName)
    put_RequestStoreNameWStr(szwName)
      => ComCall(33, this.p, "Str", szwName)
    get_RequestStoreTypeWStr(szwType)
      => ComCall(34, this.p, PWSTR.Ptr, szwType)
    put_RequestStoreTypeWStr(szwType)
      => ComCall(35, this.p, "Str", szwType)
    get_RequestStoreFlags(pdwFlags)
      => ComCall(36, this.p, Int32.Ptr, pdwFlags)
    put_RequestStoreFlags(dwFlags)
      => ComCall(37, this.p, Int32, dwFlags)
    get_ContainerNameWStr(szwContainer)
      => ComCall(38, this.p, PWSTR.Ptr, szwContainer)
    put_ContainerNameWStr(szwContainer)
      => ComCall(39, this.p, "Str", szwContainer)
    get_ProviderNameWStr(szwProvider)
      => ComCall(40, this.p, PWSTR.Ptr, szwProvider)
    put_ProviderNameWStr(szwProvider)
      => ComCall(41, this.p, "Str", szwProvider)
    get_ProviderType(pdwType)
      => ComCall(42, this.p, Int32.Ptr, pdwType)
    put_ProviderType(dwType)
      => ComCall(43, this.p, Int32, dwType)
    get_KeySpec(pdw)
      => ComCall(44, this.p, Int32.Ptr, pdw)
    put_KeySpec(dw)
      => ComCall(45, this.p, Int32, dw)
    get_ProviderFlags(pdwFlags)
      => ComCall(46, this.p, Int32.Ptr, pdwFlags)
    put_ProviderFlags(dwFlags)
      => ComCall(47, this.p, Int32, dwFlags)
    get_UseExistingKeySet(fUseExistingKeys)
      => ComCall(48, this.p, BOOL.Ptr, fUseExistingKeys)
    put_UseExistingKeySet(fUseExistingKeys)
      => ComCall(49, this.p, BOOL, fUseExistingKeys)
    get_GenKeyFlags(pdwFlags)
      => ComCall(50, this.p, Int32.Ptr, pdwFlags)
    put_GenKeyFlags(dwFlags)
      => ComCall(51, this.p, Int32, dwFlags)
    get_DeleteRequestCert(fDelete)
      => ComCall(52, this.p, BOOL.Ptr, fDelete)
    put_DeleteRequestCert(fDelete)
      => ComCall(53, this.p, BOOL, fDelete)
    get_WriteCertToUserDS(fBool)
      => ComCall(54, this.p, BOOL.Ptr, fBool)
    put_WriteCertToUserDS(fBool)
      => ComCall(55, this.p, BOOL, fBool)
    get_EnableT61DNEncoding(fBool)
      => ComCall(56, this.p, BOOL.Ptr, fBool)
    put_EnableT61DNEncoding(fBool)
      => ComCall(57, this.p, BOOL, fBool)
    get_WriteCertToCSP(fBool)
      => ComCall(58, this.p, BOOL.Ptr, fBool)
    put_WriteCertToCSP(fBool)
      => ComCall(59, this.p, BOOL, fBool)
    get_SPCFileNameWStr(szw)
      => ComCall(60, this.p, PWSTR.Ptr, szw)
    put_SPCFileNameWStr(szw)
      => ComCall(61, this.p, "Str", szw)
    get_PVKFileNameWStr(szw)
      => ComCall(62, this.p, PWSTR.Ptr, szw)
    put_PVKFileNameWStr(szw)
      => ComCall(63, this.p, "Str", szw)
    get_HashAlgorithmWStr(szw)
      => ComCall(64, this.p, PWSTR.Ptr, szw)
    put_HashAlgorithmWStr(szw)
      => ComCall(65, this.p, "Str", szw)
    get_RenewalCertificate(ppCertContext)
      => ComCall(66, this.p, CERT_CONTEXT.Ptr.Ptr, ppCertContext)
    put_RenewalCertificate(pCertContext)
      => ComCall(67, this.p, CERT_CONTEXT.Ptr, pCertContext)
    AddCertTypeToRequestWStr(szw)
      => ComCall(68, this.p, "Str", szw)
    AddNameValuePairToSignatureWStr(Name, Value)
      => ComCall(69, this.p, "Str", Name, "Str", Value)
    AddExtensionsToRequest(pCertExtensions)
      => ComCall(70, this.p, CERT_EXTENSIONS.Ptr, pCertExtensions)
    AddAuthenticatedAttributesToPKCS7Request(pAttributes)
      => ComCall(71, this.p, CRYPT_ATTRIBUTES.Ptr, pAttributes)
    CreatePKCS7RequestFromRequest(pRequest, pSigningCertContext, pPkcs7Blob)
      => ComCall(72, this.p, CRYPT_INTEGER_BLOB.Ptr, pRequest, CERT_CONTEXT.Ptr, pSigningCertContext, CRYPT_INTEGER_BLOB.Ptr, pPkcs7Blob)
}
struct IEnroll2 extends IEnroll {
    static IID := "{C080E199-B7DF-11D2-A421-00C04F79FE8E}"
    InstallPKCS7Blob(pBlobPKCS7)
      => ComCall(73, this.p, CRYPT_INTEGER_BLOB.Ptr, pBlobPKCS7)
    Reset()
      => ComCall(74, this.p)
    GetSupportedKeySpec(pdwKeySpec)
      => ComCall(75, this.p, Int32.Ptr, pdwKeySpec)
    GetKeyLen(fMin, fExchange, pdwKeySize)
      => ComCall(76, this.p, BOOL, fMin, BOOL, fExchange, Int32.Ptr, pdwKeySize)
    EnumAlgs(dwIndex, algClass, pdwAlgID)
      => ComCall(77, this.p, Int32, dwIndex, Int32, algClass, Int32.Ptr, pdwAlgID)
    GetAlgNameWStr(algID, ppwsz)
      => ComCall(78, this.p, Int32, algID, PWSTR.Ptr, ppwsz)
    put_ReuseHardwareKeyIfUnableToGenNew(fReuseHardwareKeyIfUnableToGenNew)
      => ComCall(79, this.p, BOOL, fReuseHardwareKeyIfUnableToGenNew)
    get_ReuseHardwareKeyIfUnableToGenNew(fReuseHardwareKeyIfUnableToGenNew)
      => ComCall(80, this.p, BOOL.Ptr, fReuseHardwareKeyIfUnableToGenNew)
    put_HashAlgID(hashAlgID)
      => ComCall(81, this.p, Int32, hashAlgID)
    get_HashAlgID(hashAlgID)
      => ComCall(82, this.p, Int32.Ptr, hashAlgID)
    SetHStoreMy(hStore)
      => ComCall(83, this.p, HCERTSTORE, hStore)
    SetHStoreCA(hStore)
      => ComCall(84, this.p, HCERTSTORE, hStore)
    SetHStoreROOT(hStore)
      => ComCall(85, this.p, HCERTSTORE, hStore)
    SetHStoreRequest(hStore)
      => ComCall(86, this.p, HCERTSTORE, hStore)
    put_LimitExchangeKeyToEncipherment(fLimitExchangeKeyToEncipherment)
      => ComCall(87, this.p, BOOL, fLimitExchangeKeyToEncipherment)
    get_LimitExchangeKeyToEncipherment(fLimitExchangeKeyToEncipherment)
      => ComCall(88, this.p, BOOL.Ptr, fLimitExchangeKeyToEncipherment)
    put_EnableSMIMECapabilities(fEnableSMIMECapabilities)
      => ComCall(89, this.p, BOOL, fEnableSMIMECapabilities)
    get_EnableSMIMECapabilities(fEnableSMIMECapabilities)
      => ComCall(90, this.p, BOOL.Ptr, fEnableSMIMECapabilities)
}
struct IEnroll4 extends IEnroll2 {
    static IID := "{F8053FE5-78F4-448F-A0DB-41D61B73446B}"
    put_ThumbPrintWStr(thumbPrintBlob)
      => ComCall(91, this.p, CRYPT_INTEGER_BLOB, thumbPrintBlob)
    get_ThumbPrintWStr(thumbPrintBlob)
      => ComCall(92, this.p, CRYPT_INTEGER_BLOB.Ptr, thumbPrintBlob)
    SetPrivateKeyArchiveCertificate(pPrivateKeyArchiveCert)
      => ComCall(93, this.p, CERT_CONTEXT.Ptr, pPrivateKeyArchiveCert)
    GetPrivateKeyArchiveCertificate()
      => ComCall(94, this.p, CERT_CONTEXT.Ptr)
    binaryBlobToString(Flags, pblobBinary, ppwszString)
      => ComCall(95, this.p, Int32, Flags, CRYPT_INTEGER_BLOB.Ptr, pblobBinary, PWSTR.Ptr, ppwszString)
    stringToBinaryBlob(Flags, pwszString, pblobBinary, pdwSkip, pdwFlags)
      => ComCall(96, this.p, Int32, Flags, "Str", pwszString, CRYPT_INTEGER_BLOB.Ptr, pblobBinary, Int32.Ptr, pdwSkip, Int32.Ptr, pdwFlags)
    addExtensionToRequestWStr(Flags, pwszName, pblobValue)
      => ComCall(97, this.p, Int32, Flags, "Str", pwszName, CRYPT_INTEGER_BLOB.Ptr, pblobValue)
    addAttributeToRequestWStr(Flags, pwszName, pblobValue)
      => ComCall(98, this.p, Int32, Flags, "Str", pwszName, CRYPT_INTEGER_BLOB.Ptr, pblobValue)
    addNameValuePairToRequestWStr(Flags, pwszName, pwszValue)
      => ComCall(99, this.p, Int32, Flags, "Str", pwszName, "Str", pwszValue)
    resetExtensions()
      => ComCall(100, this.p)
    resetAttributes()
      => ComCall(101, this.p)
    createRequestWStr(Flags, pwszDNName, pwszUsage, pblobRequest)
      => ComCall(102, this.p, CERT_CREATE_REQUEST_FLAGS, Flags, "Str", pwszDNName, "Str", pwszUsage, CRYPT_INTEGER_BLOB.Ptr, pblobRequest)
    createFileRequestWStr(Flags, pwszDNName, pwszUsage, pwszRequestFileName)
      => ComCall(103, this.p, CERT_CREATE_REQUEST_FLAGS, Flags, "Str", pwszDNName, "Str", pwszUsage, "Str", pwszRequestFileName)
    acceptResponseBlob(pblobResponse)
      => ComCall(104, this.p, CRYPT_INTEGER_BLOB.Ptr, pblobResponse)
    acceptFileResponseWStr(pwszResponseFileName)
      => ComCall(105, this.p, "Str", pwszResponseFileName)
    getCertContextFromResponseBlob(pblobResponse, ppCertContext)
      => ComCall(106, this.p, CRYPT_INTEGER_BLOB.Ptr, pblobResponse, CERT_CONTEXT.Ptr.Ptr, ppCertContext)
    getCertContextFromFileResponseWStr(pwszResponseFileName, ppCertContext)
      => ComCall(107, this.p, "Str", pwszResponseFileName, CERT_CONTEXT.Ptr.Ptr, ppCertContext)
    createPFXWStr(pwszPassword, pblobPFX)
      => ComCall(108, this.p, "Str", pwszPassword, CRYPT_INTEGER_BLOB.Ptr, pblobPFX)
    createFilePFXWStr(pwszPassword, pwszPFXFileName)
      => ComCall(109, this.p, "Str", pwszPassword, "Str", pwszPFXFileName)
    setPendingRequestInfoWStr(lRequestID, pwszCADNS, pwszCAName, pwszFriendlyName)
      => ComCall(110, this.p, Int32, lRequestID, "Str", pwszCADNS, "Str", pwszCAName, "Str", pwszFriendlyName)
    enumPendingRequestWStr(lIndex, lDesiredProperty, ppProperty)
      => ComCall(111, this.p, Int32, lIndex, PENDING_REQUEST_DESIRED_PROPERTY, lDesiredProperty, Struct.Ptr, ppProperty)
    removePendingRequestWStr(thumbPrintBlob)
      => ComCall(112, this.p, CRYPT_INTEGER_BLOB, thumbPrintBlob)
    GetKeyLenEx(lSizeSpec, lKeySpec, pdwKeySize)
      => ComCall(113, this.p, XEKL_KEYSIZE, lSizeSpec, XEKL_KEYSPEC, lKeySpec, Int32.Ptr, pdwKeySize)
    InstallPKCS7BlobEx(pBlobPKCS7, plCertInstalled)
      => ComCall(114, this.p, CRYPT_INTEGER_BLOB.Ptr, pBlobPKCS7, Int32.Ptr, plCertInstalled)
    AddCertTypeToRequestWStrEx(lType, pwszOIDOrName, lMajorVersion, fMinorVersion, lMinorVersion)
      => ComCall(115, this.p, ADDED_CERT_TYPE, lType, "Str", pwszOIDOrName, Int32, lMajorVersion, BOOL, fMinorVersion, Int32, lMinorVersion)
    getProviderTypeWStr(pwszProvName, plProvType)
      => ComCall(116, this.p, "Str", pwszProvName, Int32.Ptr, plProvType)
    addBlobPropertyToCertificateWStr(lPropertyId, lReserved, pBlobProperty)
      => ComCall(117, this.p, Int32, lPropertyId, Int32, lReserved, CRYPT_INTEGER_BLOB.Ptr, pBlobProperty)
    SetSignerCertificate(pSignerCert)
      => ComCall(118, this.p, CERT_CONTEXT.Ptr, pSignerCert)
    put_ClientId(lClientId)
      => ComCall(119, this.p, Int32, lClientId)
    get_ClientId(plClientId)
      => ComCall(120, this.p, Int32.Ptr, plClientId)
    put_IncludeSubjectKeyID(fInclude)
      => ComCall(121, this.p, BOOL, fInclude)
    get_IncludeSubjectKeyID(pfInclude)
      => ComCall(122, this.p, BOOL.Ptr, pfInclude)
}
struct ICertRequestD extends IUnknown {
    static IID := "{D99E6E70-FC88-11D0-B498-00A0C90312F3}"
    Request(dwFlags, pwszAuthority?, pdwRequestId, pdwDisposition, pwszAttributes?, pctbRequest, pctbCertChain, pctbEncodedCert, pctbDispositionMessage)
      => ComCall(3, this.p, UInt32, dwFlags, "Str", pwszAuthority?, UInt32.Ptr, pdwRequestId, UInt32.Ptr, pdwDisposition, "Str", pwszAttributes?, CERTTRANSBLOB.Ptr, pctbRequest, CERTTRANSBLOB.Ptr, pctbCertChain, CERTTRANSBLOB.Ptr, pctbEncodedCert, CERTTRANSBLOB.Ptr, pctbDispositionMessage)
    GetCACert(fchain, pwszAuthority?, pctbOut)
      => ComCall(4, this.p, UInt32, fchain, "Str", pwszAuthority?, CERTTRANSBLOB.Ptr, pctbOut)
    Ping(pwszAuthority?)
      => ComCall(5, this.p, "Str", pwszAuthority?)
}
struct ICertRequestD2 extends ICertRequestD {
    static IID := "{5422FD3A-D4B8-4CEF-A12E-E87D4CA22E90}"
    Request2(pwszAuthority?, dwFlags, pwszSerialNumber?, pdwRequestId, pdwDisposition, pwszAttributes?, pctbRequest, pctbFullResponse, pctbEncodedCert, pctbDispositionMessage)
      => ComCall(6, this.p, "Str", pwszAuthority?, UInt32, dwFlags, "Str", pwszSerialNumber?, UInt32.Ptr, pdwRequestId, UInt32.Ptr, pdwDisposition, "Str", pwszAttributes?, CERTTRANSBLOB.Ptr, pctbRequest, CERTTRANSBLOB.Ptr, pctbFullResponse, CERTTRANSBLOB.Ptr, pctbEncodedCert, CERTTRANSBLOB.Ptr, pctbDispositionMessage)
    GetCAProperty(pwszAuthority?, PropId, PropIndex, PropType, pctbPropertyValue)
      => ComCall(7, this.p, "Str", pwszAuthority?, Int32, PropId, Int32, PropIndex, Int32, PropType, CERTTRANSBLOB.Ptr, pctbPropertyValue)
    GetCAPropertyInfo(pwszAuthority?, pcProperty, pctbPropInfo)
      => ComCall(8, this.p, "Str", pwszAuthority?, Int32.Ptr, pcProperty, CERTTRANSBLOB.Ptr, pctbPropInfo)
    Ping2(pwszAuthority?)
      => ComCall(9, this.p, "Str", pwszAuthority?)
}
