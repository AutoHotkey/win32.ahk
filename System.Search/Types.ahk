#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HANDLE, HRESULT, HWND, PROPERTYKEY, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\Security.Authorization\Types.ahk" {EXPLICIT_ACCESS_W, TRUSTEE_W}
#Import "..\Storage.IndexServer\Types.ahk" {DBID, FILTERREGION, FULLPROPSPEC, IFilter, IPhraseSink, WORDREP_BREAK_TYPE}
#Import "..\System.Com\Types.ahk" {BLOB, COSERVERINFO, CY, DISPPARAMS, IAuthenticate, IDispatch, IEnumString, IEnumUnknown, IErrorInfo, IMoniker, IPersistStream, ISequentialStream, IStream, ITypeInfo, IUnknown, MULTI_QI}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage, PROPSPEC, PROPVARIANT}
#Import "..\System.DistributedTransactionCoordinator\Types.ahk" {ITransaction, ITransactionOptions}
#Import "..\System.Search.Common\Types.ahk" {CONDITION_OPERATION, CONDITION_TYPE}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}
#Import "..\UI.Shell.Common\Types.ahk" {IObjectArray}

struct HACCESSOR {
    Value : IntPtr
}
struct DBVECTOR {
    size : IntPtr
    ptr : Struct.Ptr
}
struct DBTIMESTAMP {
    year : Int16
    month : UInt16
    day : UInt16
    hour : UInt16
    minute : UInt16
    second : UInt16
    fraction : UInt32
}
struct SEC_OBJECT_ELEMENT {
    guidObjectType : GUID
    ObjectID : DBID
}
struct SEC_OBJECT {
    cObjects : UInt32
    prgObjects : SEC_OBJECT_ELEMENT.Ptr
}
struct DBIMPLICITSESSION {
    pUnkOuter : IUnknown
    piid : GUID.Ptr
    pSession : IUnknown
}
struct DBOBJECT {
    dwFlags : UInt32
    iid : GUID
}
struct DBBINDEXT {
    pExtension : UInt8.Ptr
    ulExtension : IntPtr
}
struct DBBINDING {
    iOrdinal : IntPtr
    obValue : IntPtr
    obLength : IntPtr
    obStatus : IntPtr
    pTypeInfo : ITypeInfo
    pObject : DBOBJECT.Ptr
    pBindExt : DBBINDEXT.Ptr
    dwPart : UInt32
    dwMemOwner : UInt32
    eParamIO : UInt32
    cbMaxLen : IntPtr
    dwFlags : UInt32
    wType : UInt16
    bPrecision : UInt8
    bScale : UInt8
}
struct DBFAILUREINFO {
    hRow : IntPtr
    iColumn : IntPtr
    failure : HRESULT
}
struct DBCOLUMNINFO {
    pwszName : PWSTR
    pTypeInfo : ITypeInfo
    iOrdinal : IntPtr
    dwFlags : UInt32
    ulColumnSize : IntPtr
    wType : UInt16
    bPrecision : UInt8
    bScale : UInt8
    columnid : DBID
}
struct DBPARAMS {
    pData : Struct.Ptr
    cParamSets : IntPtr
    hAccessor : HACCESSOR
}
struct DBPARAMINFO {
    dwFlags : UInt32
    iOrdinal : IntPtr
    pwszName : PWSTR
    pTypeInfo : ITypeInfo
    ulParamSize : IntPtr
    wType : UInt16
    bPrecision : UInt8
    bScale : UInt8
}
struct DBPROPIDSET {
    rgPropertyIDs : UInt32.Ptr
    cPropertyIDs : UInt32
    guidPropertySet : GUID
}
struct DBPROPINFO {
    pwszDescription : PWSTR
    dwPropertyID : UInt32
    dwFlags : UInt32
    vtType : VARENUM
    vValues : VARIANT
}
struct DBPROPINFOSET {
    rgPropertyInfos : DBPROPINFO.Ptr
    cPropertyInfos : UInt32
    guidPropertySet : GUID
}
struct DBPROP {
    dwPropertyID : UInt32
    dwOptions : UInt32
    dwStatus : UInt32
    colid : DBID
    vValue : VARIANT
}
struct DBPROPSET {
    rgProperties : DBPROP.Ptr
    cProperties : UInt32
    guidPropertySet : GUID
}
struct DBINDEXCOLUMNDESC {
    pColumnID : DBID.Ptr
    eIndexColOrder : UInt32
}
struct DBCOLUMNDESC {
    pwszTypeName : PWSTR
    pTypeInfo : ITypeInfo
    rgPropertySets : DBPROPSET.Ptr
    pclsid : GUID.Ptr
    cPropertySets : UInt32
    ulColumnSize : IntPtr
    dbcid : DBID
    wType : UInt16
    bPrecision : UInt8
    bScale : UInt8
}
struct DBCOLUMNACCESS {
    pData : Struct.Ptr
    columnid : DBID
    cbDataLen : IntPtr
    dwStatus : UInt32
    cbMaxLen : IntPtr
    dwReserved : IntPtr
    wType : UInt16
    bPrecision : UInt8
    bScale : UInt8
}
struct DBCONSTRAINTDESC {
    pConstraintID : DBID.Ptr
    ConstraintType : UInt32
    cColumns : IntPtr
    rgColumnList : DBID.Ptr
    pReferencedTableID : DBID.Ptr
    cForeignKeyColumns : IntPtr
    rgForeignKeyColumnList : DBID.Ptr
    pwszConstraintText : PWSTR
    UpdateRule : UInt32
    DeleteRule : UInt32
    MatchType : UInt32
    Deferrability : UInt32
    cReserved : IntPtr
    rgReserved : DBPROPSET.Ptr
}
struct MDAXISINFO {
    cbSize : IntPtr := this.Size
    iAxis : IntPtr
    cDimensions : IntPtr
    cCoordinates : IntPtr
    rgcColumns : IntPtr.Ptr
    rgpwszDimensionNames : PWSTR.Ptr
}
struct RMTPACK {
    pISeqStream : ISequentialStream
    cbData : UInt32
    cBSTR : UInt32
    rgBSTR : BSTR.Ptr
    cVARIANT : UInt32
    rgVARIANT : VARIANT.Ptr
    cIDISPATCH : UInt32
    rgIDISPATCH : IDispatch.Ptr
    cIUNKNOWN : UInt32
    rgIUNKNOWN : IUnknown.Ptr
    cPROPVARIANT : UInt32
    rgPROPVARIANT : PROPVARIANT.Ptr
    cArray : UInt32
    rgArray : VARIANT.Ptr
}
struct DBPARAMBINDINFO {
    pwszDataSourceType : PWSTR
    pwszName : PWSTR
    ulParamSize : IntPtr
    dwFlags : UInt32
    bPrecision : UInt8
    bScale : UInt8
}
struct DBLITERALINFO {
    pwszLiteralValue : PWSTR
    pwszInvalidChars : PWSTR
    pwszInvalidStartingChars : PWSTR
    lt : UInt32
    fSupported : BOOL
    cchMaxLen : UInt32
}
struct ERRORINFO {
    hrError : HRESULT
    dwMinor : UInt32
    clsid : GUID
    iid : GUID
    dispid : Int32
}
struct DBROWWATCHCHANGE {
    hRegion : IntPtr
    eChangeKind : UInt32
    hRow : IntPtr
    iRow : IntPtr
}
struct DBCOST {
    eKind : UInt32
    dwUnits : UInt32
    lValue : Int32
}
struct IWordSink extends IUnknown {
    static IID := "{CC907054-C058-101A-B554-08002B33B0E6}"
    PutWord(cwc, pwcInBuf, cwcSrcLen, cwcSrcPos)
      => ComCall(3, this.p, UInt32, cwc, "Str", pwcInBuf, UInt32, cwcSrcLen, UInt32, cwcSrcPos)
    PutAltWord(cwc, pwcInBuf, cwcSrcLen, cwcSrcPos)
      => ComCall(4, this.p, UInt32, cwc, "Str", pwcInBuf, UInt32, cwcSrcLen, UInt32, cwcSrcPos)
    StartAltPhrase()
      => ComCall(5, this.p)
    EndAltPhrase()
      => ComCall(6, this.p)
    PutBreak(breakType)
      => ComCall(7, this.p, WORDREP_BREAK_TYPE, breakType)
}
struct PFNFILLTEXTBUFFER extends FunctionPointer {
    static Types := [TEXT_SOURCE.Ptr, HRESULT]
}
struct TEXT_SOURCE {
    pfnFillTextBuffer : PFNFILLTEXTBUFFER
    awcBuffer : PWSTR
    iEnd : UInt32
    iCur : UInt32
}
struct IWordBreaker extends IUnknown {
    static IID := "{D53552C8-77E3-101A-B552-08002B33B0E6}"
    Init(fQuery, ulMaxTokenSize, pfLicense)
      => ComCall(3, this.p, BOOL, fQuery, UInt32, ulMaxTokenSize, BOOL.Ptr, pfLicense)
    BreakText(pTextSource, pWordSink, pPhraseSink)
      => ComCall(4, this.p, TEXT_SOURCE.Ptr, pTextSource, IWordSink, pWordSink, IPhraseSink, pPhraseSink)
    ComposePhrase(pwcNoun, cwcNoun, pwcModifier, cwcModifier, ulAttachmentType, pwcPhrase, pcwcPhrase)
      => ComCall(5, this.p, "Str", pwcNoun, UInt32, cwcNoun, "Str", pwcModifier, UInt32, cwcModifier, UInt32, ulAttachmentType, "Str", pwcPhrase, UInt32.Ptr, pcwcPhrase)
    GetLicenseToUse(ppwcsLicense)
      => ComCall(6, this.p, UInt16.Ptr.Ptr, ppwcsLicense)
}
struct IWordFormSink extends IUnknown {
    static IID := "{FE77C330-7F42-11CE-BE57-00AA0051FE20}"
    PutAltWord(pwcInBuf, cwc)
      => ComCall(3, this.p, "Str", pwcInBuf, UInt32, cwc)
    PutWord(pwcInBuf, cwc)
      => ComCall(4, this.p, "Str", pwcInBuf, UInt32, cwc)
}
struct IStemmer extends IUnknown {
    static IID := "{EFBAF140-7F42-11CE-BE57-00AA0051FE20}"
    Init(ulMaxTokenSize, pfLicense)
      => ComCall(3, this.p, UInt32, ulMaxTokenSize, BOOL.Ptr, pfLicense)
    GenerateWordForms(pwcInBuf, cwc, pStemSink)
      => ComCall(4, this.p, "Str", pwcInBuf, UInt32, cwc, IWordFormSink, pStemSink)
    GetLicenseToUse(ppwcsLicense)
      => ComCall(5, this.p, UInt16.Ptr.Ptr, ppwcsLicense)
}
struct ISimpleCommandCreator extends IUnknown {
    static IID := "{5E341AB7-02D0-11D1-900C-00A0C9063796}"
    CreateICommand(ppIUnknown, pOuterUnk)
      => ComCall(3, this.p, IUnknown.Ptr, ppIUnknown, IUnknown, pOuterUnk)
    VerifyCatalog(pwszMachine, pwszCatalogName)
      => ComCall(4, this.p, "Str", pwszMachine, "Str", pwszCatalogName)
    GetDefaultCatalog(pwszCatalogName, cwcIn, pcwcOut)
      => ComCall(5, this.p, "Str", pwszCatalogName, UInt32, cwcIn, UInt32.Ptr, pcwcOut)
}
struct IColumnMapper extends IUnknown {
    static IID := "{0B63E37A-9CCC-11D0-BCDB-00805FCCCE04}"
    GetPropInfoFromName(wcsPropName, ppPropId, pPropType, puiWidth)
      => ComCall(3, this.p, "Str", wcsPropName, DBID.Ptr.Ptr, ppPropId, UInt16.Ptr, pPropType, UInt32.Ptr, puiWidth)
    GetPropInfoFromId(pPropId, pwcsName, pPropType, puiWidth)
      => ComCall(4, this.p, DBID.Ptr, pPropId, UInt16.Ptr.Ptr, pwcsName, UInt16.Ptr, pPropType, UInt32.Ptr, puiWidth)
    EnumPropInfo(iEntry, pwcsName, ppPropId, pPropType, puiWidth)
      => ComCall(5, this.p, UInt32, iEntry, UInt16.Ptr.Ptr, pwcsName, DBID.Ptr.Ptr, ppPropId, UInt16.Ptr, pPropType, UInt32.Ptr, puiWidth)
    IsMapUpToDate()
      => ComCall(6, this.p)
}
struct IColumnMapperCreator extends IUnknown {
    static IID := "{0B63E37B-9CCC-11D0-BCDB-00805FCCCE04}"
    GetColumnMapper(wcsMachineName, wcsCatalogName, ppColumnMapper)
      => ComCall(3, this.p, "Str", wcsMachineName, "Str", wcsCatalogName, IColumnMapper.Ptr, ppColumnMapper)
}
struct FILTERED_DATA_SOURCES {
    pwcsExtension : PWSTR
    pwcsMime : PWSTR
    pClsid : GUID.Ptr
    pwcsOverride : PWSTR
}
struct ILoadFilter extends IUnknown {
    static IID := "{C7310722-AC80-11D1-8DF3-00C04FB6EF4F}"
    LoadIFilter(pwcsPath, pFilteredSources, pUnkOuter, fUseDefault, pFilterClsid, SearchDecSize, pwcsSearchDesc, ppIFilt)
      => ComCall(3, this.p, "Str", pwcsPath, FILTERED_DATA_SOURCES.Ptr, pFilteredSources, IUnknown, pUnkOuter, BOOL, fUseDefault, GUID.Ptr, pFilterClsid, Int32.Ptr, SearchDecSize, UInt16.Ptr.Ptr, pwcsSearchDesc, IFilter.Ptr, ppIFilt)
    LoadIFilterFromStorage(pStg, pUnkOuter, pwcsOverride, fUseDefault, pFilterClsid, SearchDecSize, pwcsSearchDesc, ppIFilt)
      => ComCall(4, this.p, IStorage, pStg, IUnknown, pUnkOuter, "Str", pwcsOverride, BOOL, fUseDefault, GUID.Ptr, pFilterClsid, Int32.Ptr, SearchDecSize, UInt16.Ptr.Ptr, pwcsSearchDesc, IFilter.Ptr, ppIFilt)
    LoadIFilterFromStream(pStm, pFilteredSources, pUnkOuter, fUseDefault, pFilterClsid, SearchDecSize, pwcsSearchDesc, ppIFilt)
      => ComCall(5, this.p, IStream, pStm, FILTERED_DATA_SOURCES.Ptr, pFilteredSources, IUnknown, pUnkOuter, BOOL, fUseDefault, GUID.Ptr, pFilterClsid, Int32.Ptr, SearchDecSize, UInt16.Ptr.Ptr, pwcsSearchDesc, IFilter.Ptr, ppIFilt)
}
struct ILoadFilterWithPrivateComActivation extends ILoadFilter {
    static IID := "{40BDBD34-780B-48D3-9BB6-12EBD4AD2E75}"
    LoadIFilterWithPrivateComActivation(filteredSources, useDefault, filterClsid, isFilterPrivateComActivated, filterObj)
      => ComCall(6, this.p, FILTERED_DATA_SOURCES.Ptr, filteredSources, BOOL, useDefault, GUID.Ptr, filterClsid, BOOL.Ptr, isFilterPrivateComActivated, IFilter.Ptr, filterObj)
}
struct IRichChunk extends IUnknown {
    static IID := "{4FDEF69C-DBC9-454E-9910-B34F3C64B510}"
    GetData(pFirstPos?, pLength?, ppsz?, pValue?)
      => ComCall(3, this.p, UInt32.Ptr, pFirstPos?, UInt32.Ptr, pLength?, PWSTR.Ptr, ppsz?, PROPVARIANT.Ptr, pValue?)
}
struct ICondition extends IPersistStream {
    static IID := "{0FC988D4-C935-4B97-A973-46282EA175C8}"
    GetConditionType(pNodeType)
      => ComCall(8, this.p, CONDITION_TYPE.Ptr, pNodeType)
    GetSubConditions(riid, ppv)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetComparisonInfo(ppszPropertyName?, pcop?, ppropvar?)
      => ComCall(10, this.p, PWSTR.Ptr, ppszPropertyName?, CONDITION_OPERATION.Ptr, pcop?, PROPVARIANT.Ptr, ppropvar?)
    GetValueType(ppszValueTypeName)
      => ComCall(11, this.p, PWSTR.Ptr, ppszValueTypeName)
    GetValueNormalization(ppszNormalization)
      => ComCall(12, this.p, PWSTR.Ptr, ppszNormalization)
    GetInputTerms(ppPropertyTerm?, ppOperationTerm?, ppValueTerm?)
      => ComCall(13, this.p, IRichChunk.Ptr, ppPropertyTerm?, IRichChunk.Ptr, ppOperationTerm?, IRichChunk.Ptr, ppValueTerm?)
    Clone(ppc)
      => ComCall(14, this.p, ICondition.Ptr, ppc)
}
struct ICondition2 extends ICondition {
    static IID := "{0DB8851D-2E5B-47EB-9208-D28C325A01D7}"
    GetLocale(ppszLocaleName)
      => ComCall(15, this.p, PWSTR.Ptr, ppszLocaleName)
    GetLeafConditionInfo(ppropkey?, pcop?, ppropvar?)
      => ComCall(16, this.p, PROPERTYKEY.Ptr, ppropkey?, CONDITION_OPERATION.Ptr, pcop?, PROPVARIANT.Ptr, ppropvar?)
}
struct DB_NUMERIC {
    precision : UInt8
    scale : UInt8
    sign : UInt8
    val : UInt8[16]
}
struct DBDATE {
    year : Int16
    month : UInt16
    day : UInt16
}
struct DBTIME {
    hour : UInt16
    minute : UInt16
    second : UInt16
}
struct DB_VARNUMERIC {
    precision : UInt8
    scale : Int8
    sign : UInt8
    val : UInt8[1]
}
struct DBTYPEENUM extends Int32 {
    static DBTYPE_EMPTY := 0
    static DBTYPE_NULL := 1
    static DBTYPE_I2 := 2
    static DBTYPE_I4 := 3
    static DBTYPE_R4 := 4
    static DBTYPE_R8 := 5
    static DBTYPE_CY := 6
    static DBTYPE_DATE := 7
    static DBTYPE_BSTR := 8
    static DBTYPE_IDISPATCH := 9
    static DBTYPE_ERROR := 10
    static DBTYPE_BOOL := 11
    static DBTYPE_VARIANT := 12
    static DBTYPE_IUNKNOWN := 13
    static DBTYPE_DECIMAL := 14
    static DBTYPE_UI1 := 17
    static DBTYPE_ARRAY := 8192
    static DBTYPE_BYREF := 16384
    static DBTYPE_I1 := 16
    static DBTYPE_UI2 := 18
    static DBTYPE_UI4 := 19
    static DBTYPE_I8 := 20
    static DBTYPE_UI8 := 21
    static DBTYPE_GUID := 72
    static DBTYPE_VECTOR := 4096
    static DBTYPE_RESERVED := 32768
    static DBTYPE_BYTES := 128
    static DBTYPE_STR := 129
    static DBTYPE_WSTR := 130
    static DBTYPE_NUMERIC := 131
    static DBTYPE_UDT := 132
    static DBTYPE_DBDATE := 133
    static DBTYPE_DBTIME := 134
    static DBTYPE_DBTIMESTAMP := 135
}
struct DBTYPEENUM15 extends Int32 {
    static DBTYPE_HCHAPTER := 136
}
struct DBTYPEENUM20 extends Int32 {
    static DBTYPE_FILETIME := 64
    static DBTYPE_PROPVARIANT := 138
    static DBTYPE_VARNUMERIC := 139
}
struct DBPARTENUM extends Int32 {
    static DBPART_INVALID := 0
    static DBPART_VALUE := 1
    static DBPART_LENGTH := 2
    static DBPART_STATUS := 4
}
struct DBPARAMIOENUM extends Int32 {
    static DBPARAMIO_NOTPARAM := 0
    static DBPARAMIO_INPUT := 1
    static DBPARAMIO_OUTPUT := 2
}
struct DBBINDFLAGENUM extends Int32 {
    static DBBINDFLAG_HTML := 1
}
struct DBMEMOWNERENUM extends Int32 {
    static DBMEMOWNER_CLIENTOWNED := 0
    static DBMEMOWNER_PROVIDEROWNED := 1
}
struct DBSTATUSENUM extends Int32 {
    static DBSTATUS_S_OK := 0
    static DBSTATUS_E_BADACCESSOR := 1
    static DBSTATUS_E_CANTCONVERTVALUE := 2
    static DBSTATUS_S_ISNULL := 3
    static DBSTATUS_S_TRUNCATED := 4
    static DBSTATUS_E_SIGNMISMATCH := 5
    static DBSTATUS_E_DATAOVERFLOW := 6
    static DBSTATUS_E_CANTCREATE := 7
    static DBSTATUS_E_UNAVAILABLE := 8
    static DBSTATUS_E_PERMISSIONDENIED := 9
    static DBSTATUS_E_INTEGRITYVIOLATION := 10
    static DBSTATUS_E_SCHEMAVIOLATION := 11
    static DBSTATUS_E_BADSTATUS := 12
    static DBSTATUS_S_DEFAULT := 13
}
struct DBSTATUSENUM20 extends Int32 {
    static MDSTATUS_S_CELLEMPTY := 14
    static DBSTATUS_S_IGNORE := 15
}
struct DBSTATUSENUM21 extends Int32 {
    static DBSTATUS_E_DOESNOTEXIST := 16
    static DBSTATUS_E_INVALIDURL := 17
    static DBSTATUS_E_RESOURCELOCKED := 18
    static DBSTATUS_E_RESOURCEEXISTS := 19
    static DBSTATUS_E_CANNOTCOMPLETE := 20
    static DBSTATUS_E_VOLUMENOTFOUND := 21
    static DBSTATUS_E_OUTOFSPACE := 22
    static DBSTATUS_S_CANNOTDELETESOURCE := 23
    static DBSTATUS_E_READONLY := 24
    static DBSTATUS_E_RESOURCEOUTOFSCOPE := 25
    static DBSTATUS_S_ALREADYEXISTS := 26
}
struct DBBINDURLFLAGENUM extends Int32 {
    static DBBINDURLFLAG_READ := 1
    static DBBINDURLFLAG_WRITE := 2
    static DBBINDURLFLAG_READWRITE := 3
    static DBBINDURLFLAG_SHARE_DENY_READ := 4
    static DBBINDURLFLAG_SHARE_DENY_WRITE := 8
    static DBBINDURLFLAG_SHARE_EXCLUSIVE := 12
    static DBBINDURLFLAG_SHARE_DENY_NONE := 16
    static DBBINDURLFLAG_ASYNCHRONOUS := 4096
    static DBBINDURLFLAG_COLLECTION := 8192
    static DBBINDURLFLAG_DELAYFETCHSTREAM := 16384
    static DBBINDURLFLAG_DELAYFETCHCOLUMNS := 32768
    static DBBINDURLFLAG_RECURSIVE := 4194304
    static DBBINDURLFLAG_OUTPUT := 8388608
    static DBBINDURLFLAG_WAITFORINIT := 16777216
    static DBBINDURLFLAG_OPENIFEXISTS := 33554432
    static DBBINDURLFLAG_OVERWRITE := 67108864
    static DBBINDURLFLAG_ISSTRUCTUREDDOCUMENT := 134217728
}
struct DBBINDURLSTATUSENUM extends Int32 {
    static DBBINDURLSTATUS_S_OK := 0
    static DBBINDURLSTATUS_S_DENYNOTSUPPORTED := 1
    static DBBINDURLSTATUS_S_DENYTYPENOTSUPPORTED := 4
    static DBBINDURLSTATUS_S_REDIRECTED := 8
}
struct DBSTATUSENUM25 extends Int32 {
    static DBSTATUS_E_CANCELED := 27
    static DBSTATUS_E_NOTCOLLECTION := 28
}
struct DBROWSTATUSENUM extends Int32 {
    static DBROWSTATUS_S_OK := 0
    static DBROWSTATUS_S_MULTIPLECHANGES := 2
    static DBROWSTATUS_S_PENDINGCHANGES := 3
    static DBROWSTATUS_E_CANCELED := 4
    static DBROWSTATUS_E_CANTRELEASE := 6
    static DBROWSTATUS_E_CONCURRENCYVIOLATION := 7
    static DBROWSTATUS_E_DELETED := 8
    static DBROWSTATUS_E_PENDINGINSERT := 9
    static DBROWSTATUS_E_NEWLYINSERTED := 10
    static DBROWSTATUS_E_INTEGRITYVIOLATION := 11
    static DBROWSTATUS_E_INVALID := 12
    static DBROWSTATUS_E_MAXPENDCHANGESEXCEEDED := 13
    static DBROWSTATUS_E_OBJECTOPEN := 14
    static DBROWSTATUS_E_OUTOFMEMORY := 15
    static DBROWSTATUS_E_PERMISSIONDENIED := 16
    static DBROWSTATUS_E_LIMITREACHED := 17
    static DBROWSTATUS_E_SCHEMAVIOLATION := 18
    static DBROWSTATUS_E_FAIL := 19
}
struct DBROWSTATUSENUM20 extends Int32 {
    static DBROWSTATUS_S_NOCHANGE := 20
}
struct DBSTATUSENUM26 extends Int32 {
    static DBSTATUS_S_ROWSETCOLUMN := 29
}
struct DBCOLUMNFLAGSENUM extends Int32 {
    static DBCOLUMNFLAGS_ISBOOKMARK := 1
    static DBCOLUMNFLAGS_MAYDEFER := 2
    static DBCOLUMNFLAGS_WRITE := 4
    static DBCOLUMNFLAGS_WRITEUNKNOWN := 8
    static DBCOLUMNFLAGS_ISFIXEDLENGTH := 16
    static DBCOLUMNFLAGS_ISNULLABLE := 32
    static DBCOLUMNFLAGS_MAYBENULL := 64
    static DBCOLUMNFLAGS_ISLONG := 128
    static DBCOLUMNFLAGS_ISROWID := 256
    static DBCOLUMNFLAGS_ISROWVER := 512
    static DBCOLUMNFLAGS_CACHEDEFERRED := 4096
}
struct DBCOLUMNFLAGSENUM20 extends Int32 {
    static DBCOLUMNFLAGS_SCALEISNEGATIVE := 16384
    static DBCOLUMNFLAGS_RESERVED := 32768
}
struct DBCOLUMNFLAGSDEPRECATED extends Int32 {
    static DBCOLUMNFLAGS_KEYCOLUMN := 32768
}
struct DBCOLUMNFLAGS15ENUM extends Int32 {
    static DBCOLUMNFLAGS_ISCHAPTER := 8192
}
struct DBCOLUMNFLAGSENUM21 extends Int32 {
    static DBCOLUMNFLAGS_ISROWURL := 65536
    static DBCOLUMNFLAGS_ISDEFAULTSTREAM := 131072
    static DBCOLUMNFLAGS_ISCOLLECTION := 262144
}
struct DBCOLUMNFLAGSENUM26 extends Int32 {
    static DBCOLUMNFLAGS_ISSTREAM := 524288
    static DBCOLUMNFLAGS_ISROWSET := 1048576
    static DBCOLUMNFLAGS_ISROW := 2097152
    static DBCOLUMNFLAGS_ROWSPECIFICCOLUMN := 4194304
}
struct DBTABLESTATISTICSTYPE26 extends Int32 {
    static DBSTAT_HISTOGRAM := 1
    static DBSTAT_COLUMN_CARDINALITY := 2
    static DBSTAT_TUPLE_CARDINALITY := 4
}
struct DBBOOKMARK extends Int32 {
    static DBBMK_INVALID := 0
    static DBBMK_FIRST := 1
    static DBBMK_LAST := 2
}
struct DBPROPENUM extends Int32 {
    static DBPROP_ABORTPRESERVE := 2
    static DBPROP_ACTIVESESSIONS := 3
    static DBPROP_APPENDONLY := 187
    static DBPROP_ASYNCTXNABORT := 168
    static DBPROP_ASYNCTXNCOMMIT := 4
    static DBPROP_AUTH_CACHE_AUTHINFO := 5
    static DBPROP_AUTH_ENCRYPT_PASSWORD := 6
    static DBPROP_AUTH_INTEGRATED := 7
    static DBPROP_AUTH_MASK_PASSWORD := 8
    static DBPROP_AUTH_PASSWORD := 9
    static DBPROP_AUTH_PERSIST_ENCRYPTED := 10
    static DBPROP_AUTH_PERSIST_SENSITIVE_AUTHINFO := 11
    static DBPROP_AUTH_USERID := 12
    static DBPROP_BLOCKINGSTORAGEOBJECTS := 13
    static DBPROP_BOOKMARKS := 14
    static DBPROP_BOOKMARKSKIPPED := 15
    static DBPROP_BOOKMARKTYPE := 16
    static DBPROP_BYREFACCESSORS := 120
    static DBPROP_CACHEDEFERRED := 17
    static DBPROP_CANFETCHBACKWARDS := 18
    static DBPROP_CANHOLDROWS := 19
    static DBPROP_CANSCROLLBACKWARDS := 21
    static DBPROP_CATALOGLOCATION := 22
    static DBPROP_CATALOGTERM := 23
    static DBPROP_CATALOGUSAGE := 24
    static DBPROP_CHANGEINSERTEDROWS := 188
    static DBPROP_COL_AUTOINCREMENT := 26
    static DBPROP_COL_DEFAULT := 27
    static DBPROP_COL_DESCRIPTION := 28
    static DBPROP_COL_FIXEDLENGTH := 167
    static DBPROP_COL_NULLABLE := 29
    static DBPROP_COL_PRIMARYKEY := 30
    static DBPROP_COL_UNIQUE := 31
    static DBPROP_COLUMNDEFINITION := 32
    static DBPROP_COLUMNRESTRICT := 33
    static DBPROP_COMMANDTIMEOUT := 34
    static DBPROP_COMMITPRESERVE := 35
    static DBPROP_CONCATNULLBEHAVIOR := 36
    static DBPROP_CURRENTCATALOG := 37
    static DBPROP_DATASOURCENAME := 38
    static DBPROP_DATASOURCEREADONLY := 39
    static DBPROP_DBMSNAME := 40
    static DBPROP_DBMSVER := 41
    static DBPROP_DEFERRED := 42
    static DBPROP_DELAYSTORAGEOBJECTS := 43
    static DBPROP_DSOTHREADMODEL := 169
    static DBPROP_GROUPBY := 44
    static DBPROP_HETEROGENEOUSTABLES := 45
    static DBPROP_IAccessor := 121
    static DBPROP_IColumnsInfo := 122
    static DBPROP_IColumnsRowset := 123
    static DBPROP_IConnectionPointContainer := 124
    static DBPROP_IConvertType := 194
    static DBPROP_IRowset := 126
    static DBPROP_IRowsetChange := 127
    static DBPROP_IRowsetIdentity := 128
    static DBPROP_IRowsetIndex := 159
    static DBPROP_IRowsetInfo := 129
    static DBPROP_IRowsetLocate := 130
    static DBPROP_IRowsetResynch := 132
    static DBPROP_IRowsetScroll := 133
    static DBPROP_IRowsetUpdate := 134
    static DBPROP_ISupportErrorInfo := 135
    static DBPROP_ILockBytes := 136
    static DBPROP_ISequentialStream := 137
    static DBPROP_IStorage := 138
    static DBPROP_IStream := 139
    static DBPROP_IDENTIFIERCASE := 46
    static DBPROP_IMMOBILEROWS := 47
    static DBPROP_INDEX_AUTOUPDATE := 48
    static DBPROP_INDEX_CLUSTERED := 49
    static DBPROP_INDEX_FILLFACTOR := 50
    static DBPROP_INDEX_INITIALSIZE := 51
    static DBPROP_INDEX_NULLCOLLATION := 52
    static DBPROP_INDEX_NULLS := 53
    static DBPROP_INDEX_PRIMARYKEY := 54
    static DBPROP_INDEX_SORTBOOKMARKS := 55
    static DBPROP_INDEX_TEMPINDEX := 163
    static DBPROP_INDEX_TYPE := 56
    static DBPROP_INDEX_UNIQUE := 57
    static DBPROP_INIT_DATASOURCE := 59
    static DBPROP_INIT_HWND := 60
    static DBPROP_INIT_IMPERSONATION_LEVEL := 61
    static DBPROP_INIT_LCID := 186
    static DBPROP_INIT_LOCATION := 62
    static DBPROP_INIT_MODE := 63
    static DBPROP_INIT_PROMPT := 64
    static DBPROP_INIT_PROTECTION_LEVEL := 65
    static DBPROP_INIT_PROVIDERSTRING := 160
    static DBPROP_INIT_TIMEOUT := 66
    static DBPROP_LITERALBOOKMARKS := 67
    static DBPROP_LITERALIDENTITY := 68
    static DBPROP_MAXINDEXSIZE := 70
    static DBPROP_MAXOPENROWS := 71
    static DBPROP_MAXPENDINGROWS := 72
    static DBPROP_MAXROWS := 73
    static DBPROP_MAXROWSIZE := 74
    static DBPROP_MAXROWSIZEINCLUDESBLOB := 75
    static DBPROP_MAXTABLESINSELECT := 76
    static DBPROP_MAYWRITECOLUMN := 77
    static DBPROP_MEMORYUSAGE := 78
    static DBPROP_MULTIPLEPARAMSETS := 191
    static DBPROP_MULTIPLERESULTS := 196
    static DBPROP_MULTIPLESTORAGEOBJECTS := 80
    static DBPROP_MULTITABLEUPDATE := 81
    static DBPROP_NOTIFICATIONGRANULARITY := 198
    static DBPROP_NOTIFICATIONPHASES := 82
    static DBPROP_NOTIFYCOLUMNSET := 171
    static DBPROP_NOTIFYROWDELETE := 173
    static DBPROP_NOTIFYROWFIRSTCHANGE := 174
    static DBPROP_NOTIFYROWINSERT := 175
    static DBPROP_NOTIFYROWRESYNCH := 177
    static DBPROP_NOTIFYROWSETCHANGED := 211
    static DBPROP_NOTIFYROWSETRELEASE := 178
    static DBPROP_NOTIFYROWSETFETCHPOSITIONCHANGE := 179
    static DBPROP_NOTIFYROWUNDOCHANGE := 180
    static DBPROP_NOTIFYROWUNDODELETE := 181
    static DBPROP_NOTIFYROWUNDOINSERT := 182
    static DBPROP_NOTIFYROWUPDATE := 183
    static DBPROP_NULLCOLLATION := 83
    static DBPROP_OLEOBJECTS := 84
    static DBPROP_ORDERBYCOLUMNSINSELECT := 85
    static DBPROP_ORDEREDBOOKMARKS := 86
    static DBPROP_OTHERINSERT := 87
    static DBPROP_OTHERUPDATEDELETE := 88
    static DBPROP_OUTPUTPARAMETERAVAILABILITY := 184
    static DBPROP_OWNINSERT := 89
    static DBPROP_OWNUPDATEDELETE := 90
    static DBPROP_PERSISTENTIDTYPE := 185
    static DBPROP_PREPAREABORTBEHAVIOR := 91
    static DBPROP_PREPARECOMMITBEHAVIOR := 92
    static DBPROP_PROCEDURETERM := 93
    static DBPROP_PROVIDERNAME := 96
    static DBPROP_PROVIDEROLEDBVER := 97
    static DBPROP_PROVIDERVER := 98
    static DBPROP_QUICKRESTART := 99
    static DBPROP_QUOTEDIDENTIFIERCASE := 100
    static DBPROP_REENTRANTEVENTS := 101
    static DBPROP_REMOVEDELETED := 102
    static DBPROP_REPORTMULTIPLECHANGES := 103
    static DBPROP_RETURNPENDINGINSERTS := 189
    static DBPROP_ROWRESTRICT := 104
    static DBPROP_ROWSETCONVERSIONSONCOMMAND := 192
    static DBPROP_ROWTHREADMODEL := 105
    static DBPROP_SCHEMATERM := 106
    static DBPROP_SCHEMAUSAGE := 107
    static DBPROP_SERVERCURSOR := 108
    static DBPROP_SESS_AUTOCOMMITISOLEVELS := 190
    static DBPROP_SQLSUPPORT := 109
    static DBPROP_STRONGIDENTITY := 119
    static DBPROP_STRUCTUREDSTORAGE := 111
    static DBPROP_SUBQUERIES := 112
    static DBPROP_SUPPORTEDTXNDDL := 161
    static DBPROP_SUPPORTEDTXNISOLEVELS := 113
    static DBPROP_SUPPORTEDTXNISORETAIN := 114
    static DBPROP_TABLETERM := 115
    static DBPROP_TBL_TEMPTABLE := 140
    static DBPROP_TRANSACTEDOBJECT := 116
    static DBPROP_UPDATABILITY := 117
    static DBPROP_USERNAME := 118
}
struct DBPROPENUM15 extends Int32 {
    static DBPROP_FILTERCOMPAREOPS := 209
    static DBPROP_FINDCOMPAREOPS := 210
    static DBPROP_IChapteredRowset := 202
    static DBPROP_IDBAsynchStatus := 203
    static DBPROP_IRowsetFind := 204
    static DBPROP_IRowsetView := 212
    static DBPROP_IViewChapter := 213
    static DBPROP_IViewFilter := 214
    static DBPROP_IViewRowset := 215
    static DBPROP_IViewSort := 216
    static DBPROP_INIT_ASYNCH := 200
    static DBPROP_MAXOPENCHAPTERS := 199
    static DBPROP_MAXORSINFILTER := 205
    static DBPROP_MAXSORTCOLUMNS := 206
    static DBPROP_ROWSET_ASYNCH := 201
    static DBPROP_SORTONINDEX := 207
}
struct DBPROPENUM20 extends Int32 {
    static DBPROP_IMultipleResults := 217
    static DBPROP_DATASOURCE_TYPE := 251
    static MDPROP_AXES := 252
    static MDPROP_FLATTENING_SUPPORT := 253
    static MDPROP_MDX_JOINCUBES := 254
    static MDPROP_NAMED_LEVELS := 255
    static MDPROP_RANGEROWSET := 256
    static MDPROP_MDX_SLICER := 218
    static MDPROP_MDX_CUBEQUALIFICATION := 219
    static MDPROP_MDX_OUTERREFERENCE := 220
    static MDPROP_MDX_QUERYBYPROPERTY := 221
    static MDPROP_MDX_CASESUPPORT := 222
    static MDPROP_MDX_STRING_COMPOP := 224
    static MDPROP_MDX_DESCFLAGS := 225
    static MDPROP_MDX_SET_FUNCTIONS := 226
    static MDPROP_MDX_MEMBER_FUNCTIONS := 227
    static MDPROP_MDX_NUMERIC_FUNCTIONS := 228
    static MDPROP_MDX_FORMULAS := 229
    static MDPROP_AGGREGATECELL_UPDATE := 230
    static MDPROP_MDX_AGGREGATECELL_UPDATE := 230
    static MDPROP_MDX_OBJQUALIFICATION := 261
    static MDPROP_MDX_NONMEASURE_EXPRESSIONS := 262
    static DBPROP_ACCESSORDER := 231
    static DBPROP_BOOKMARKINFO := 232
    static DBPROP_INIT_CATALOG := 233
    static DBPROP_ROW_BULKOPS := 234
    static DBPROP_PROVIDERFRIENDLYNAME := 235
    static DBPROP_LOCKMODE := 236
    static DBPROP_MULTIPLECONNECTIONS := 237
    static DBPROP_UNIQUEROWS := 238
    static DBPROP_SERVERDATAONINSERT := 239
    static DBPROP_STORAGEFLAGS := 240
    static DBPROP_CONNECTIONSTATUS := 244
    static DBPROP_ALTERCOLUMN := 245
    static DBPROP_COLUMNLCID := 246
    static DBPROP_RESETDATASOURCE := 247
    static DBPROP_INIT_OLEDBSERVICES := 248
    static DBPROP_IRowsetRefresh := 249
    static DBPROP_SERVERNAME := 250
    static DBPROP_IParentRowset := 257
    static DBPROP_HIDDENCOLUMNS := 258
    static DBPROP_PROVIDERMEMORY := 259
    static DBPROP_CLIENTCURSOR := 260
}
struct DBPROPENUM21 extends Int32 {
    static DBPROP_TRUSTEE_USERNAME := 241
    static DBPROP_TRUSTEE_AUTHENTICATION := 242
    static DBPROP_TRUSTEE_NEWAUTHENTICATION := 243
    static DBPROP_IRow := 263
    static DBPROP_IRowChange := 264
    static DBPROP_IRowSchemaChange := 265
    static DBPROP_IGetRow := 266
    static DBPROP_IScopedOperations := 267
    static DBPROP_IBindResource := 268
    static DBPROP_ICreateRow := 269
    static DBPROP_INIT_BINDFLAGS := 270
    static DBPROP_INIT_LOCKOWNER := 271
    static DBPROP_GENERATEURL := 273
    static DBPROP_IDBBinderProperties := 274
    static DBPROP_IColumnsInfo2 := 275
    static DBPROP_IRegisterProvider := 276
    static DBPROP_IGetSession := 277
    static DBPROP_IGetSourceRow := 278
    static DBPROP_IRowsetCurrentIndex := 279
    static DBPROP_OPENROWSETSUPPORT := 280
    static DBPROP_COL_ISLONG := 281
}
struct DBPROPENUM25 extends Int32 {
    static DBPROP_COL_SEED := 282
    static DBPROP_COL_INCREMENT := 283
    static DBPROP_INIT_GENERALTIMEOUT := 284
    static DBPROP_COMSERVICES := 285
}
struct DBPROPENUM26 extends Int32 {
    static DBPROP_OUTPUTSTREAM := 286
    static DBPROP_OUTPUTENCODING := 287
    static DBPROP_TABLESTATISTICS := 288
    static DBPROP_SKIPROWCOUNTRESULTS := 291
    static DBPROP_IRowsetBookmark := 292
    static MDPROP_VISUALMODE := 293
}
struct DBPROPENUMDEPRECATED extends Int32 {
    static DBPROP_IRowsetExactScroll := 154
    static DBPROP_MARSHALLABLE := 197
    static DBPROP_FILTEROPS := 208
}
struct DBPARAMFLAGSENUM extends Int32 {
    static DBPARAMFLAGS_ISINPUT := 1
    static DBPARAMFLAGS_ISOUTPUT := 2
    static DBPARAMFLAGS_ISSIGNED := 16
    static DBPARAMFLAGS_ISNULLABLE := 64
    static DBPARAMFLAGS_ISLONG := 128
}
struct DBPARAMFLAGSENUM20 extends Int32 {
    static DBPARAMFLAGS_SCALEISNEGATIVE := 256
}
struct DBPROPFLAGSENUM extends Int32 {
    static DBPROPFLAGS_NOTSUPPORTED := 0
    static DBPROPFLAGS_COLUMN := 1
    static DBPROPFLAGS_DATASOURCE := 2
    static DBPROPFLAGS_DATASOURCECREATE := 4
    static DBPROPFLAGS_DATASOURCEINFO := 8
    static DBPROPFLAGS_DBINIT := 16
    static DBPROPFLAGS_INDEX := 32
    static DBPROPFLAGS_ROWSET := 64
    static DBPROPFLAGS_TABLE := 128
    static DBPROPFLAGS_COLUMNOK := 256
    static DBPROPFLAGS_READ := 512
    static DBPROPFLAGS_WRITE := 1024
    static DBPROPFLAGS_REQUIRED := 2048
    static DBPROPFLAGS_SESSION := 4096
}
struct DBPROPFLAGSENUM21 extends Int32 {
    static DBPROPFLAGS_TRUSTEE := 8192
}
struct DBPROPFLAGSENUM25 extends Int32 {
    static DBPROPFLAGS_VIEW := 16384
}
struct DBPROPFLAGSENUM26 extends Int32 {
    static DBPROPFLAGS_STREAM := 32768
}
struct DBPROPOPTIONSENUM extends Int32 {
    static DBPROPOPTIONS_REQUIRED := 0
    static DBPROPOPTIONS_SETIFCHEAP := 1
    static DBPROPOPTIONS_OPTIONAL := 1
}
struct DBPROPSTATUSENUM extends Int32 {
    static DBPROPSTATUS_OK := 0
    static DBPROPSTATUS_NOTSUPPORTED := 1
    static DBPROPSTATUS_BADVALUE := 2
    static DBPROPSTATUS_BADOPTION := 3
    static DBPROPSTATUS_BADCOLUMN := 4
    static DBPROPSTATUS_NOTALLSETTABLE := 5
    static DBPROPSTATUS_NOTSETTABLE := 6
    static DBPROPSTATUS_NOTSET := 7
    static DBPROPSTATUS_CONFLICTING := 8
}
struct DBPROPSTATUSENUM21 extends Int32 {
    static DBPROPSTATUS_NOTAVAILABLE := 9
}
struct DBINDEX_COL_ORDERENUM extends Int32 {
    static DBINDEX_COL_ORDER_ASC := 0
    static DBINDEX_COL_ORDER_DESC := 1
}
struct DBCOLUMNDESCFLAGSENUM extends Int32 {
    static DBCOLUMNDESCFLAGS_TYPENAME := 1
    static DBCOLUMNDESCFLAGS_ITYPEINFO := 2
    static DBCOLUMNDESCFLAGS_PROPERTIES := 4
    static DBCOLUMNDESCFLAGS_CLSID := 8
    static DBCOLUMNDESCFLAGS_COLSIZE := 16
    static DBCOLUMNDESCFLAGS_DBCID := 32
    static DBCOLUMNDESCFLAGS_WTYPE := 64
    static DBCOLUMNDESCFLAGS_PRECISION := 128
    static DBCOLUMNDESCFLAGS_SCALE := 256
}
struct DBEVENTPHASEENUM extends Int32 {
    static DBEVENTPHASE_OKTODO := 0
    static DBEVENTPHASE_ABOUTTODO := 1
    static DBEVENTPHASE_SYNCHAFTER := 2
    static DBEVENTPHASE_FAILEDTODO := 3
    static DBEVENTPHASE_DIDEVENT := 4
}
struct DBREASONENUM extends Int32 {
    static DBREASON_ROWSET_FETCHPOSITIONCHANGE := 0
    static DBREASON_ROWSET_RELEASE := 1
    static DBREASON_COLUMN_SET := 2
    static DBREASON_COLUMN_RECALCULATED := 3
    static DBREASON_ROW_ACTIVATE := 4
    static DBREASON_ROW_RELEASE := 5
    static DBREASON_ROW_DELETE := 6
    static DBREASON_ROW_FIRSTCHANGE := 7
    static DBREASON_ROW_INSERT := 8
    static DBREASON_ROW_RESYNCH := 9
    static DBREASON_ROW_UNDOCHANGE := 10
    static DBREASON_ROW_UNDOINSERT := 11
    static DBREASON_ROW_UNDODELETE := 12
    static DBREASON_ROW_UPDATE := 13
    static DBREASON_ROWSET_CHANGED := 14
}
struct DBREASONENUM15 extends Int32 {
    static DBREASON_ROWPOSITION_CHANGED := 15
    static DBREASON_ROWPOSITION_CHAPTERCHANGED := 16
    static DBREASON_ROWPOSITION_CLEARED := 17
    static DBREASON_ROW_ASYNCHINSERT := 18
}
struct DBCOMPAREOPSENUM extends Int32 {
    static DBCOMPAREOPS_LT := 0
    static DBCOMPAREOPS_LE := 1
    static DBCOMPAREOPS_EQ := 2
    static DBCOMPAREOPS_GE := 3
    static DBCOMPAREOPS_GT := 4
    static DBCOMPAREOPS_BEGINSWITH := 5
    static DBCOMPAREOPS_CONTAINS := 6
    static DBCOMPAREOPS_NE := 7
    static DBCOMPAREOPS_IGNORE := 8
    static DBCOMPAREOPS_CASESENSITIVE := 4096
    static DBCOMPAREOPS_CASEINSENSITIVE := 8192
}
struct DBCOMPAREOPSENUM20 extends Int32 {
    static DBCOMPAREOPS_NOTBEGINSWITH := 9
    static DBCOMPAREOPS_NOTCONTAINS := 10
}
struct DBASYNCHOPENUM extends Int32 {
    static DBASYNCHOP_OPEN := 0
}
struct DBASYNCHPHASEENUM extends Int32 {
    static DBASYNCHPHASE_INITIALIZATION := 0
    static DBASYNCHPHASE_POPULATION := 1
    static DBASYNCHPHASE_COMPLETE := 2
    static DBASYNCHPHASE_CANCELED := 3
}
struct DBSORTENUM extends Int32 {
    static DBSORT_ASCENDING := 0
    static DBSORT_DESCENDING := 1
}
struct DBCOMMANDPERSISTFLAGENUM extends Int32 {
    static DBCOMMANDPERSISTFLAG_NOSAVE := 1
}
struct DBCOMMANDPERSISTFLAGENUM21 extends Int32 {
    static DBCOMMANDPERSISTFLAG_DEFAULT := 0
    static DBCOMMANDPERSISTFLAG_PERSISTVIEW := 2
    static DBCOMMANDPERSISTFLAG_PERSISTPROCEDURE := 4
}
struct DBCONSTRAINTTYPEENUM extends Int32 {
    static DBCONSTRAINTTYPE_UNIQUE := 0
    static DBCONSTRAINTTYPE_FOREIGNKEY := 1
    static DBCONSTRAINTTYPE_PRIMARYKEY := 2
    static DBCONSTRAINTTYPE_CHECK := 3
}
struct DBUPDELRULEENUM extends Int32 {
    static DBUPDELRULE_NOACTION := 0
    static DBUPDELRULE_CASCADE := 1
    static DBUPDELRULE_SETNULL := 2
    static DBUPDELRULE_SETDEFAULT := 3
}
struct DBMATCHTYPEENUM extends Int32 {
    static DBMATCHTYPE_FULL := 0
    static DBMATCHTYPE_NONE := 1
    static DBMATCHTYPE_PARTIAL := 2
}
struct DBDEFERRABILITYENUM extends Int32 {
    static DBDEFERRABILITY_DEFERRED := 1
    static DBDEFERRABILITY_DEFERRABLE := 2
}
struct DBACCESSORFLAGSENUM extends Int32 {
    static DBACCESSOR_INVALID := 0
    static DBACCESSOR_PASSBYREF := 1
    static DBACCESSOR_ROWDATA := 2
    static DBACCESSOR_PARAMETERDATA := 4
    static DBACCESSOR_OPTIMIZED := 8
    static DBACCESSOR_INHERITED := 16
}
struct DBBINDSTATUSENUM extends Int32 {
    static DBBINDSTATUS_OK := 0
    static DBBINDSTATUS_BADORDINAL := 1
    static DBBINDSTATUS_UNSUPPORTEDCONVERSION := 2
    static DBBINDSTATUS_BADBINDINFO := 3
    static DBBINDSTATUS_BADSTORAGEFLAGS := 4
    static DBBINDSTATUS_NOINTERFACE := 5
    static DBBINDSTATUS_MULTIPLESTORAGE := 6
}
struct IAccessor extends IUnknown {
    static IID := "{0C733A8C-2A1C-11CE-ADE5-00AA0044773D}"
    AddRefAccessor(hAccessor1, pcRefCount?)
      => ComCall(3, this.p, HACCESSOR, hAccessor1, UInt32.Ptr, pcRefCount?)
    CreateAccessor(dwAccessorFlags, rgBindings, cbRowSize, phAccessor, rgStatus?)
      => ComCall(4, this.p, UInt32, dwAccessorFlags, IntPtr, rgStatus?.Length ?? 0, DBBINDING.Ptr, rgBindings, IntPtr, cbRowSize, HACCESSOR.Ptr, phAccessor, UInt32.Ptr, rgStatus?)
    GetBindings(hAccessor1, pdwAccessorFlags, pcBindings?, prgBindings)
      => ComCall(5, this.p, HACCESSOR, hAccessor1, UInt32.Ptr, pdwAccessorFlags, IntPtr.Ptr, pcBindings?, DBBINDING.Ptr.Ptr, prgBindings)
    ReleaseAccessor(hAccessor1, pcRefCount?)
      => ComCall(6, this.p, HACCESSOR, hAccessor1, UInt32.Ptr, pcRefCount?)
}
struct IRowset extends IUnknown {
    static IID := "{0C733A7C-2A1C-11CE-ADE5-00AA0044773D}"
    AddRefRows(rghRows, rgRefCounts, rgRowStatus)
      => ComCall(3, this.p, IntPtr, rgRowStatus.Length, IntPtr.Ptr, rghRows, UInt32.Ptr, rgRefCounts, UInt32.Ptr, rgRowStatus)
    GetData(hRow, hAccessor1, pData)
      => ComCall(4, this.p, IntPtr, hRow, HACCESSOR, hAccessor1, Struct.Ptr, pData)
    GetNextRows(hReserved, lRowsOffset, pcRowsObtained, prghRows)
      => ComCall(5, this.p, IntPtr, hReserved, IntPtr, lRowsOffset, IntPtr, prghRows.Length, IntPtr.Ptr, pcRowsObtained, IntPtr.Ptr.Ptr, prghRows)
    ReleaseRows(rghRows, rgRowOptions, rgRefCounts, rgRowStatus)
      => ComCall(6, this.p, IntPtr, rgRowStatus.Length, IntPtr.Ptr, rghRows, UInt32.Ptr, rgRowOptions, UInt32.Ptr, rgRefCounts, UInt32.Ptr, rgRowStatus)
    RestartPosition(hReserved)
      => ComCall(7, this.p, IntPtr, hReserved)
}
struct IRowsetInfo extends IUnknown {
    static IID := "{0C733A55-2A1C-11CE-ADE5-00AA0044773D}"
    GetProperties(rgPropertyIDSets?, pcPropertySets, prgPropertySets)
      => ComCall(3, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertySets, DBPROPSET.Ptr.Ptr, prgPropertySets)
    GetReferencedRowset(iOrdinal, riid, ppReferencedRowset)
      => ComCall(4, this.p, IntPtr, iOrdinal, GUID.Ptr, riid, IUnknown.Ptr, ppReferencedRowset)
    GetSpecification(riid, ppSpecification)
      => ComCall(5, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppSpecification)
}
struct DBCOMPAREENUM extends Int32 {
    static DBCOMPARE_LT := 0
    static DBCOMPARE_EQ := 1
    static DBCOMPARE_GT := 2
    static DBCOMPARE_NE := 3
    static DBCOMPARE_NOTCOMPARABLE := 4
}
struct IRowsetLocate extends IRowset {
    static IID := "{0C733A7D-2A1C-11CE-ADE5-00AA0044773D}"
    Compare(hReserved, pBookmark1, pBookmark2, pComparison)
      => ComCall(8, this.p, IntPtr, hReserved, IntPtr, pBookmark1.Length, UInt8.Ptr, pBookmark1, IntPtr, pBookmark2.Length, UInt8.Ptr, pBookmark2, UInt32.Ptr, pComparison)
    GetRowsAt(hReserved1, hReserved2, pBookmark, lRowsOffset, pcRowsObtained, prghRows)
      => ComCall(9, this.p, IntPtr, hReserved1, IntPtr, hReserved2, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr, lRowsOffset, IntPtr, prghRows.Length, IntPtr.Ptr, pcRowsObtained, IntPtr.Ptr.Ptr, prghRows)
    GetRowsByBookmark(hReserved, rgcbBookmarks, rgpBookmarks, rghRows, rgRowStatus)
      => ComCall(10, this.p, IntPtr, hReserved, IntPtr, rgRowStatus.Length, IntPtr.Ptr, rgcbBookmarks, UInt8.Ptr.Ptr, rgpBookmarks, IntPtr.Ptr, rghRows, UInt32.Ptr, rgRowStatus)
    Hash(hReserved, rgcbBookmarks, rgpBookmarks, rgHashedValues, rgBookmarkStatus)
      => ComCall(11, this.p, IntPtr, hReserved, IntPtr, rgBookmarkStatus.Length, IntPtr.Ptr, rgcbBookmarks, UInt8.Ptr.Ptr, rgpBookmarks, IntPtr.Ptr, rgHashedValues, UInt32.Ptr, rgBookmarkStatus)
}
struct IRowsetResynch extends IUnknown {
    static IID := "{0C733A84-2A1C-11CE-ADE5-00AA0044773D}"
    GetVisibleData(hRow, hAccessor1, pData)
      => ComCall(3, this.p, IntPtr, hRow, HACCESSOR, hAccessor1, Struct.Ptr, pData)
    ResynchRows(rghRows, pcRowsResynched, prghRowsResynched, prgRowStatus)
      => ComCall(4, this.p, IntPtr, prgRowStatus.Length, IntPtr.Ptr, rghRows, IntPtr.Ptr, pcRowsResynched, IntPtr.Ptr.Ptr, prghRowsResynched, UInt32.Ptr.Ptr, prgRowStatus)
}
struct IRowsetScroll extends IRowsetLocate {
    static IID := "{0C733A7E-2A1C-11CE-ADE5-00AA0044773D}"
    GetApproximatePosition(hReserved, pBookmark, pulPosition, pcRows)
      => ComCall(12, this.p, IntPtr, hReserved, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr.Ptr, pulPosition, IntPtr.Ptr, pcRows)
    GetRowsAtRatio(hReserved1, hReserved2, ulNumerator, ulDenominator, pcRowsObtained, prghRows)
      => ComCall(13, this.p, IntPtr, hReserved1, IntPtr, hReserved2, IntPtr, ulNumerator, IntPtr, ulDenominator, IntPtr, prghRows.Length, IntPtr.Ptr, pcRowsObtained, IntPtr.Ptr.Ptr, prghRows)
}
struct IChapteredRowset extends IUnknown {
    static IID := "{0C733A93-2A1C-11CE-ADE5-00AA0044773D}"
    AddRefChapter(hChapter, pcRefCount?)
      => ComCall(3, this.p, IntPtr, hChapter, UInt32.Ptr, pcRefCount?)
    ReleaseChapter(hChapter, pcRefCount?)
      => ComCall(4, this.p, IntPtr, hChapter, UInt32.Ptr, pcRefCount?)
}
struct IRowsetFind extends IUnknown {
    static IID := "{0C733A9D-2A1C-11CE-ADE5-00AA0044773D}"
    FindNextRow(hChapter, hAccessor1, pFindValue, CompareOp, pBookmark, lRowsOffset, cRows, prghRows)
      => ComCall(3, this.p, IntPtr, hChapter, HACCESSOR, hAccessor1, Struct.Ptr, pFindValue, UInt32, CompareOp, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr, lRowsOffset, IntPtr, cRows, IntPtr.Ptr, prghRows.Length, IntPtr.Ptr.Ptr, prghRows)
}
struct DBPOSITIONFLAGSENUM extends Int32 {
    static DBPOSITION_OK := 0
    static DBPOSITION_NOROW := 1
    static DBPOSITION_BOF := 2
    static DBPOSITION_EOF := 3
}
struct IRowPosition extends IUnknown {
    static IID := "{0C733A94-2A1C-11CE-ADE5-00AA0044773D}"
    ClearRowPosition()
      => ComCall(3, this.p)
    GetRowPosition(phChapter?, phRow, pdwPositionFlags?)
      => ComCall(4, this.p, IntPtr.Ptr, phChapter?, IntPtr.Ptr, phRow, UInt32.Ptr, pdwPositionFlags?)
    GetRowset(riid, ppRowset)
      => ComCall(5, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppRowset)
    Initialize(pRowset)
      => ComCall(6, this.p, IUnknown, pRowset)
    SetRowPosition(hChapter, hRow, dwPositionFlags)
      => ComCall(7, this.p, IntPtr, hChapter, IntPtr, hRow, UInt32, dwPositionFlags)
}
struct IRowPositionChange extends IUnknown {
    static IID := "{0997A571-126E-11D0-9F8A-00A0C9A0631E}"
    OnRowPositionChange(eReason, ePhase, fCantDeny)
      => ComCall(3, this.p, UInt32, eReason, UInt32, ePhase, BOOL, fCantDeny)
}
struct IViewRowset extends IUnknown {
    static IID := "{0C733A97-2A1C-11CE-ADE5-00AA0044773D}"
    GetSpecification(riid, ppObject)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppObject)
    OpenViewRowset(pUnkOuter?, riid, ppRowset)
      => ComCall(4, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, IUnknown.Ptr, ppRowset)
}
struct IViewChapter extends IUnknown {
    static IID := "{0C733A98-2A1C-11CE-ADE5-00AA0044773D}"
    GetSpecification(riid, ppRowset)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppRowset)
    OpenViewChapter(hSource, phViewChapter?)
      => ComCall(4, this.p, IntPtr, hSource, IntPtr.Ptr, phViewChapter?)
}
struct IViewSort extends IUnknown {
    static IID := "{0C733A9A-2A1C-11CE-ADE5-00AA0044773D}"
    GetSortOrder(pcValues, prgColumns, prgOrders)
      => ComCall(3, this.p, IntPtr.Ptr, pcValues, IntPtr.Ptr.Ptr, prgColumns, UInt32.Ptr.Ptr, prgOrders)
    SetSortOrder(rgColumns, rgOrders)
      => ComCall(4, this.p, IntPtr, rgOrders.Length, IntPtr.Ptr, rgColumns, UInt32.Ptr, rgOrders)
}
struct IViewFilter extends IUnknown {
    static IID := "{0C733A9B-2A1C-11CE-ADE5-00AA0044773D}"
    GetFilter(hAccessor1, pCompareOps, pCriteriaData)
      => ComCall(3, this.p, HACCESSOR, hAccessor1, IntPtr.Ptr, pCompareOps.Length, UInt32.Ptr.Ptr, pCompareOps, Struct.Ptr, pCriteriaData)
    GetFilterBindings(pcBindings, prgBindings)
      => ComCall(4, this.p, IntPtr.Ptr, pcBindings, DBBINDING.Ptr.Ptr, prgBindings)
    SetFilter(hAccessor1, CompareOps, pCriteriaData)
      => ComCall(5, this.p, HACCESSOR, hAccessor1, IntPtr, CompareOps.Length, UInt32.Ptr, CompareOps, Struct.Ptr, pCriteriaData)
}
struct IRowsetView extends IUnknown {
    static IID := "{0C733A99-2A1C-11CE-ADE5-00AA0044773D}"
    CreateView(pUnkOuter?, riid, ppView)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, IUnknown.Ptr, ppView)
    GetView(hChapter, riid, phChapterSource, ppView)
      => ComCall(4, this.p, IntPtr, hChapter, GUID.Ptr, riid, IntPtr.Ptr, phChapterSource, IUnknown.Ptr, ppView)
}
struct IRowsetExactScroll extends IRowsetScroll {
    static IID := "{0C733A7F-2A1C-11CE-ADE5-00AA0044773D}"
    GetExactPosition(hChapter, pBookmark, pulPosition, pcRows)
      => ComCall(14, this.p, IntPtr, hChapter, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr.Ptr, pulPosition, IntPtr.Ptr, pcRows)
}
struct IRowsetChange extends IUnknown {
    static IID := "{0C733A05-2A1C-11CE-ADE5-00AA0044773D}"
    DeleteRows(hReserved, rghRows, rgRowStatus)
      => ComCall(3, this.p, IntPtr, hReserved, IntPtr, rgRowStatus.Length, IntPtr.Ptr, rghRows, UInt32.Ptr, rgRowStatus)
    SetData(hRow, hAccessor1, pData)
      => ComCall(4, this.p, IntPtr, hRow, HACCESSOR, hAccessor1, Struct.Ptr, pData)
    InsertRow(hReserved, hAccessor1, pData, phRow)
      => ComCall(5, this.p, IntPtr, hReserved, HACCESSOR, hAccessor1, Struct.Ptr, pData, IntPtr.Ptr, phRow)
}
struct DBPENDINGSTATUSENUM extends Int32 {
    static DBPENDINGSTATUS_NEW := 1
    static DBPENDINGSTATUS_CHANGED := 2
    static DBPENDINGSTATUS_DELETED := 4
    static DBPENDINGSTATUS_UNCHANGED := 8
    static DBPENDINGSTATUS_INVALIDROW := 16
}
struct IRowsetUpdate extends IRowsetChange {
    static IID := "{0C733A6D-2A1C-11CE-ADE5-00AA0044773D}"
    GetOriginalData(hRow, hAccessor1, pData)
      => ComCall(6, this.p, IntPtr, hRow, HACCESSOR, hAccessor1, Struct.Ptr, pData)
    GetPendingRows(hReserved, dwRowStatus, prgPendingRows, prgPendingStatus)
      => ComCall(7, this.p, IntPtr, hReserved, UInt32, dwRowStatus, IntPtr.Ptr, prgPendingStatus.Length, IntPtr.Ptr.Ptr, prgPendingRows, UInt32.Ptr.Ptr, prgPendingStatus)
    GetRowStatus(hReserved, rghRows, rgPendingStatus)
      => ComCall(8, this.p, IntPtr, hReserved, IntPtr, rgPendingStatus.Length, IntPtr.Ptr, rghRows, UInt32.Ptr, rgPendingStatus)
    Undo(hReserved, rghRows, prgRowsUndone, prgRowStatus)
      => ComCall(9, this.p, IntPtr, hReserved, IntPtr, rghRows.Length, IntPtr.Ptr, rghRows, IntPtr.Ptr, prgRowStatus.Length, IntPtr.Ptr.Ptr, prgRowsUndone, UInt32.Ptr.Ptr, prgRowStatus)
    Update(hReserved, rghRows, prgRows, prgRowStatus)
      => ComCall(10, this.p, IntPtr, hReserved, IntPtr, rghRows.Length, IntPtr.Ptr, rghRows, IntPtr.Ptr, prgRowStatus.Length, IntPtr.Ptr.Ptr, prgRows, UInt32.Ptr.Ptr, prgRowStatus)
}
struct IRowsetIdentity extends IUnknown {
    static IID := "{0C733A09-2A1C-11CE-ADE5-00AA0044773D}"
    IsSameRow(hThisRow, hThatRow)
      => ComCall(3, this.p, IntPtr, hThisRow, IntPtr, hThatRow)
}
struct IRowsetNotify extends IUnknown {
    static IID := "{0C733A83-2A1C-11CE-ADE5-00AA0044773D}"
    OnFieldChange(pRowset, hRow, rgColumns, eReason, ePhase, fCantDeny)
      => ComCall(3, this.p, IRowset, pRowset, IntPtr, hRow, IntPtr, rgColumns.Length, IntPtr.Ptr, rgColumns, UInt32, eReason, UInt32, ePhase, BOOL, fCantDeny)
    OnRowChange(pRowset, rghRows, eReason, ePhase, fCantDeny)
      => ComCall(4, this.p, IRowset, pRowset, IntPtr, rghRows.Length, IntPtr.Ptr, rghRows, UInt32, eReason, UInt32, ePhase, BOOL, fCantDeny)
    OnRowsetChange(pRowset, eReason, ePhase, fCantDeny)
      => ComCall(5, this.p, IRowset, pRowset, UInt32, eReason, UInt32, ePhase, BOOL, fCantDeny)
}
struct DBSEEKENUM extends Int32 {
    static DBSEEK_INVALID := 0
    static DBSEEK_FIRSTEQ := 1
    static DBSEEK_LASTEQ := 2
    static DBSEEK_AFTEREQ := 4
    static DBSEEK_AFTER := 8
    static DBSEEK_BEFOREEQ := 16
    static DBSEEK_BEFORE := 32
}
struct DBRANGEENUM extends Int32 {
    static DBRANGE_INCLUSIVESTART := 0
    static DBRANGE_INCLUSIVEEND := 0
    static DBRANGE_EXCLUSIVESTART := 1
    static DBRANGE_EXCLUSIVEEND := 2
    static DBRANGE_EXCLUDENULLS := 4
    static DBRANGE_PREFIX := 8
    static DBRANGE_MATCH := 16
}
struct DBRANGEENUM20 extends Int32 {
    static DBRANGE_MATCH_N_SHIFT := 24
    static DBRANGE_MATCH_N_MASK := 255
}
struct IRowsetIndex extends IUnknown {
    static IID := "{0C733A82-2A1C-11CE-ADE5-00AA0044773D}"
    GetIndexInfo(prgIndexColumnDesc, prgIndexPropertySets)
      => ComCall(3, this.p, IntPtr.Ptr, prgIndexColumnDesc.Length, DBINDEXCOLUMNDESC.Ptr.Ptr, prgIndexColumnDesc, UInt32.Ptr, prgIndexPropertySets.Length, DBPROPSET.Ptr.Ptr, prgIndexPropertySets)
    Seek(hAccessor1, cKeyValues, pData, dwSeekOptions)
      => ComCall(4, this.p, HACCESSOR, hAccessor1, IntPtr, cKeyValues, Struct.Ptr, pData, UInt32, dwSeekOptions)
    SetRange(hAccessor1, cStartKeyColumns, pStartData, cEndKeyColumns, pEndData, dwRangeOptions)
      => ComCall(5, this.p, HACCESSOR, hAccessor1, IntPtr, cStartKeyColumns, Struct.Ptr, pStartData, IntPtr, cEndKeyColumns, Struct.Ptr, pEndData, UInt32, dwRangeOptions)
}
struct ICommand extends IUnknown {
    static IID := "{0C733A63-2A1C-11CE-ADE5-00AA0044773D}"
    Cancel()
      => ComCall(3, this.p)
    Execute(pUnkOuter?, riid, pParams?, pcRowsAffected?, ppRowset?)
      => ComCall(4, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, DBPARAMS.Ptr, pParams?, IntPtr.Ptr, pcRowsAffected?, IUnknown.Ptr, ppRowset?)
    GetDBSession(riid, ppSession)
      => ComCall(5, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppSession)
}
struct DBRESULTFLAGENUM extends Int32 {
    static DBRESULTFLAG_DEFAULT := 0
    static DBRESULTFLAG_ROWSET := 1
    static DBRESULTFLAG_ROW := 2
}
struct IMultipleResults extends IUnknown {
    static IID := "{0C733A90-2A1C-11CE-ADE5-00AA0044773D}"
    GetResult(pUnkOuter?, lResultFlag, riid, pcRowsAffected?, ppRowset?)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, IntPtr, lResultFlag, GUID.Ptr, riid, IntPtr.Ptr, pcRowsAffected?, IUnknown.Ptr, ppRowset?)
}
struct DBCONVERTFLAGSENUM extends Int32 {
    static DBCONVERTFLAGS_COLUMN := 0
    static DBCONVERTFLAGS_PARAMETER := 1
}
struct DBCONVERTFLAGSENUM20 extends Int32 {
    static DBCONVERTFLAGS_ISLONG := 2
    static DBCONVERTFLAGS_ISFIXEDLENGTH := 4
    static DBCONVERTFLAGS_FROMVARIANT := 8
}
struct IConvertType extends IUnknown {
    static IID := "{0C733A88-2A1C-11CE-ADE5-00AA0044773D}"
    CanConvert(wFromType, wToType, dwConvertFlags)
      => ComCall(3, this.p, UInt16, wFromType, UInt16, wToType, UInt32, dwConvertFlags)
}
struct ICommandPrepare extends IUnknown {
    static IID := "{0C733A26-2A1C-11CE-ADE5-00AA0044773D}"
    Prepare(cExpectedRuns)
      => ComCall(3, this.p, UInt32, cExpectedRuns)
    Unprepare()
      => ComCall(4, this.p)
}
struct ICommandProperties extends IUnknown {
    static IID := "{0C733A79-2A1C-11CE-ADE5-00AA0044773D}"
    GetProperties(rgPropertyIDSets?, pcPropertySets, prgPropertySets)
      => ComCall(3, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertySets, DBPROPSET.Ptr.Ptr, prgPropertySets)
    SetProperties(rgPropertySets)
      => ComCall(4, this.p, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets)
}
struct ICommandText extends ICommand {
    static IID := "{0C733A27-2A1C-11CE-ADE5-00AA0044773D}"
    GetCommandText(pguidDialect?, ppwszCommand)
      => ComCall(6, this.p, GUID.Ptr, pguidDialect?, PWSTR.Ptr, ppwszCommand)
    SetCommandText(rguidDialect, pwszCommand?)
      => ComCall(7, this.p, GUID.Ptr, rguidDialect, "Str", pwszCommand?)
}
struct ICommandWithParameters extends IUnknown {
    static IID := "{0C733A64-2A1C-11CE-ADE5-00AA0044773D}"
    GetParameterInfo(pcParams, prgParamInfo, ppNamesBuffer?)
      => ComCall(3, this.p, IntPtr.Ptr, pcParams, DBPARAMINFO.Ptr.Ptr, prgParamInfo, UInt16.Ptr.Ptr, ppNamesBuffer?)
    MapParameterNames(rgParamNames, rgParamOrdinals)
      => ComCall(4, this.p, IntPtr, rgParamOrdinals.Length, PWSTR.Ptr, rgParamNames, IntPtr.Ptr, rgParamOrdinals)
    SetParameterInfo(rgParamOrdinals?, rgParamBindInfo?)
      => ComCall(5, this.p, IntPtr, rgParamBindInfo?.Length ?? 0, IntPtr.Ptr, rgParamOrdinals?, DBPARAMBINDINFO.Ptr, rgParamBindInfo?)
}
struct IColumnsRowset extends IUnknown {
    static IID := "{0C733A10-2A1C-11CE-ADE5-00AA0044773D}"
    GetAvailableColumns(pcOptColumns, prgOptColumns)
      => ComCall(3, this.p, IntPtr.Ptr, pcOptColumns, DBID.Ptr.Ptr, prgOptColumns)
    GetColumnsRowset(pUnkOuter?, rgOptColumns, riid, rgPropertySets?, ppColRowset)
      => ComCall(4, this.p, IUnknown, pUnkOuter?, IntPtr, rgOptColumns.Length, DBID.Ptr, rgOptColumns, GUID.Ptr, riid, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?, IUnknown.Ptr, ppColRowset)
}
struct IColumnsInfo extends IUnknown {
    static IID := "{0C733A11-2A1C-11CE-ADE5-00AA0044773D}"
    GetColumnInfo(pcColumns?, prgInfo, ppStringsBuffer?)
      => ComCall(3, this.p, IntPtr.Ptr, pcColumns?, DBCOLUMNINFO.Ptr.Ptr, prgInfo, UInt16.Ptr.Ptr, ppStringsBuffer?)
    MapColumnIDs(rgColumnIDs?, rgColumns?)
      => ComCall(4, this.p, IntPtr, rgColumns?.Length ?? 0, DBID.Ptr, rgColumnIDs?, IntPtr.Ptr, rgColumns?)
}
struct IDBCreateCommand extends IUnknown {
    static IID := "{0C733A1D-2A1C-11CE-ADE5-00AA0044773D}"
    CreateCommand(pUnkOuter?, riid, ppCommand)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, IUnknown.Ptr, ppCommand)
}
struct IDBCreateSession extends IUnknown {
    static IID := "{0C733A5D-2A1C-11CE-ADE5-00AA0044773D}"
    CreateSession(pUnkOuter?, riid, ppDBSession)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, IUnknown.Ptr, ppDBSession)
}
struct DBSOURCETYPEENUM extends Int32 {
    static DBSOURCETYPE_DATASOURCE := 1
    static DBSOURCETYPE_ENUMERATOR := 2
}
struct DBSOURCETYPEENUM20 extends Int32 {
    static DBSOURCETYPE_DATASOURCE_TDP := 1
    static DBSOURCETYPE_DATASOURCE_MDP := 3
}
struct DBSOURCETYPEENUM25 extends Int32 {
    static DBSOURCETYPE_BINDER := 4
}
struct ISourcesRowset extends IUnknown {
    static IID := "{0C733A1E-2A1C-11CE-ADE5-00AA0044773D}"
    GetSourcesRowset(pUnkOuter?, riid, rgProperties?, ppSourcesRowset)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, UInt32, rgProperties?.Length ?? 0, DBPROPSET.Ptr, rgProperties?, IUnknown.Ptr, ppSourcesRowset)
}
struct IDBProperties extends IUnknown {
    static IID := "{0C733A8A-2A1C-11CE-ADE5-00AA0044773D}"
    GetProperties(rgPropertyIDSets?, pcPropertySets, prgPropertySets)
      => ComCall(3, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertySets, DBPROPSET.Ptr.Ptr, prgPropertySets)
    GetPropertyInfo(rgPropertyIDSets?, pcPropertyInfoSets, prgPropertyInfoSets, ppDescBuffer?)
      => ComCall(4, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertyInfoSets, DBPROPINFOSET.Ptr.Ptr, prgPropertyInfoSets, UInt16.Ptr.Ptr, ppDescBuffer?)
    SetProperties(rgPropertySets?)
      => ComCall(5, this.p, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?)
}
struct IDBInitialize extends IUnknown {
    static IID := "{0C733A8B-2A1C-11CE-ADE5-00AA0044773D}"
    Initialize()
      => ComCall(3, this.p)
    Uninitialize()
      => ComCall(4, this.p)
}
struct DBLITERALENUM extends Int32 {
    static DBLITERAL_INVALID := 0
    static DBLITERAL_BINARY_LITERAL := 1
    static DBLITERAL_CATALOG_NAME := 2
    static DBLITERAL_CATALOG_SEPARATOR := 3
    static DBLITERAL_CHAR_LITERAL := 4
    static DBLITERAL_COLUMN_ALIAS := 5
    static DBLITERAL_COLUMN_NAME := 6
    static DBLITERAL_CORRELATION_NAME := 7
    static DBLITERAL_CURSOR_NAME := 8
    static DBLITERAL_ESCAPE_PERCENT := 9
    static DBLITERAL_ESCAPE_UNDERSCORE := 10
    static DBLITERAL_INDEX_NAME := 11
    static DBLITERAL_LIKE_PERCENT := 12
    static DBLITERAL_LIKE_UNDERSCORE := 13
    static DBLITERAL_PROCEDURE_NAME := 14
    static DBLITERAL_QUOTE := 15
    static DBLITERAL_SCHEMA_NAME := 16
    static DBLITERAL_TABLE_NAME := 17
    static DBLITERAL_TEXT_COMMAND := 18
    static DBLITERAL_USER_NAME := 19
    static DBLITERAL_VIEW_NAME := 20
}
struct DBLITERALENUM20 extends Int32 {
    static DBLITERAL_CUBE_NAME := 21
    static DBLITERAL_DIMENSION_NAME := 22
    static DBLITERAL_HIERARCHY_NAME := 23
    static DBLITERAL_LEVEL_NAME := 24
    static DBLITERAL_MEMBER_NAME := 25
    static DBLITERAL_PROPERTY_NAME := 26
    static DBLITERAL_SCHEMA_SEPARATOR := 27
    static DBLITERAL_QUOTE_SUFFIX := 28
}
struct DBLITERALENUM21 extends Int32 {
    static DBLITERAL_ESCAPE_PERCENT_SUFFIX := 29
    static DBLITERAL_ESCAPE_UNDERSCORE_SUFFIX := 30
}
struct IDBInfo extends IUnknown {
    static IID := "{0C733A89-2A1C-11CE-ADE5-00AA0044773D}"
    GetKeywords(ppwszKeywords)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszKeywords)
    GetLiteralInfo(rgLiterals?, pcLiteralInfo, prgLiteralInfo, ppCharBuffer)
      => ComCall(4, this.p, UInt32, rgLiterals?.Length ?? 0, UInt32.Ptr, rgLiterals?, UInt32.Ptr, pcLiteralInfo, DBLITERALINFO.Ptr.Ptr, prgLiteralInfo, UInt16.Ptr.Ptr, ppCharBuffer)
}
struct IDBDataSourceAdmin extends IUnknown {
    static IID := "{0C733A7A-2A1C-11CE-ADE5-00AA0044773D}"
    CreateDataSource(rgPropertySets?, pUnkOuter?, riid, ppDBSession?)
      => ComCall(3, this.p, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?, IUnknown, pUnkOuter?, GUID.Ptr, riid, IUnknown.Ptr, ppDBSession?)
    DestroyDataSource()
      => ComCall(4, this.p)
    GetCreationProperties(rgPropertyIDSets?, pcPropertyInfoSets, prgPropertyInfoSets, ppDescBuffer?)
      => ComCall(5, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertyInfoSets, DBPROPINFOSET.Ptr.Ptr, prgPropertyInfoSets, UInt16.Ptr.Ptr, ppDescBuffer?)
    ModifyDataSource(rgPropertySets?)
      => ComCall(6, this.p, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?)
}
struct IDBAsynchNotify extends IUnknown {
    static IID := "{0C733A96-2A1C-11CE-ADE5-00AA0044773D}"
    OnLowResource(dwReserved)
      => ComCall(3, this.p, IntPtr, dwReserved)
    OnProgress(hChapter, eOperation, ulProgress, ulProgressMax, eAsynchPhase, pwszStatusText?)
      => ComCall(4, this.p, IntPtr, hChapter, UInt32, eOperation, IntPtr, ulProgress, IntPtr, ulProgressMax, UInt32, eAsynchPhase, "Str", pwszStatusText?)
    OnStop(hChapter, eOperation, hrStatus, pwszStatusText?)
      => ComCall(5, this.p, IntPtr, hChapter, UInt32, eOperation, HRESULT, hrStatus, "Str", pwszStatusText?)
}
struct IDBAsynchStatus extends IUnknown {
    static IID := "{0C733A95-2A1C-11CE-ADE5-00AA0044773D}"
    Abort(hChapter, eOperation)
      => ComCall(3, this.p, IntPtr, hChapter, UInt32, eOperation)
    GetStatus(hChapter, eOperation, pulProgress?, pulProgressMax?, peAsynchPhase, ppwszStatusText?)
      => ComCall(4, this.p, IntPtr, hChapter, UInt32, eOperation, IntPtr.Ptr, pulProgress?, IntPtr.Ptr, pulProgressMax?, UInt32.Ptr, peAsynchPhase, PWSTR.Ptr, ppwszStatusText?)
}
struct ISessionProperties extends IUnknown {
    static IID := "{0C733A85-2A1C-11CE-ADE5-00AA0044773D}"
    GetProperties(rgPropertyIDSets?, pcPropertySets, prgPropertySets)
      => ComCall(3, this.p, UInt32, rgPropertyIDSets?.Length ?? 0, DBPROPIDSET.Ptr, rgPropertyIDSets?, UInt32.Ptr, pcPropertySets, DBPROPSET.Ptr.Ptr, prgPropertySets)
    SetProperties(rgPropertySets?)
      => ComCall(4, this.p, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?)
}
struct IIndexDefinition extends IUnknown {
    static IID := "{0C733A68-2A1C-11CE-ADE5-00AA0044773D}"
    CreateIndex(pTableID, pIndexID?, rgIndexColumnDescs, rgPropertySets, ppIndexID?)
      => ComCall(3, this.p, DBID.Ptr, pTableID, DBID.Ptr, pIndexID?, IntPtr, rgIndexColumnDescs.Length, DBINDEXCOLUMNDESC.Ptr, rgIndexColumnDescs, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets, DBID.Ptr.Ptr, ppIndexID?)
    DropIndex(pTableID, pIndexID?)
      => ComCall(4, this.p, DBID.Ptr, pTableID, DBID.Ptr, pIndexID?)
}
struct ITableDefinition extends IUnknown {
    static IID := "{0C733A86-2A1C-11CE-ADE5-00AA0044773D}"
    CreateTable(pUnkOuter?, pTableID?, rgColumnDescs?, riid, rgPropertySets?, ppTableID?, ppRowset?)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, DBID.Ptr, pTableID?, IntPtr, rgColumnDescs?.Length ?? 0, DBCOLUMNDESC.Ptr, rgColumnDescs?, GUID.Ptr, riid, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?, DBID.Ptr.Ptr, ppTableID?, IUnknown.Ptr, ppRowset?)
    DropTable(pTableID)
      => ComCall(4, this.p, DBID.Ptr, pTableID)
    AddColumn(pTableID, pColumnDesc, ppColumnID?)
      => ComCall(5, this.p, DBID.Ptr, pTableID, DBCOLUMNDESC.Ptr, pColumnDesc, DBID.Ptr.Ptr, ppColumnID?)
    DropColumn(pTableID, pColumnID)
      => ComCall(6, this.p, DBID.Ptr, pTableID, DBID.Ptr, pColumnID)
}
struct IOpenRowset extends IUnknown {
    static IID := "{0C733A69-2A1C-11CE-ADE5-00AA0044773D}"
    OpenRowset(pUnkOuter?, pTableID?, pIndexID?, riid, rgPropertySets?, ppRowset?)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, DBID.Ptr, pTableID?, DBID.Ptr, pIndexID?, GUID.Ptr, riid, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?, IUnknown.Ptr, ppRowset?)
}
struct IDBSchemaRowset extends IUnknown {
    static IID := "{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}"
    GetRowset(pUnkOuter?, rguidSchema, rgRestrictions?, riid, rgPropertySets?, ppRowset)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, rguidSchema, UInt32, rgRestrictions?.Length ?? 0, VARIANT.Ptr, rgRestrictions?, GUID.Ptr, riid, UInt32, rgPropertySets?.Length ?? 0, DBPROPSET.Ptr, rgPropertySets?, IUnknown.Ptr, ppRowset)
    GetSchemas(pcSchemas, prgSchemas, prgRestrictionSupport)
      => ComCall(4, this.p, UInt32.Ptr, pcSchemas, GUID.Ptr.Ptr, prgSchemas, UInt32.Ptr.Ptr, prgRestrictionSupport)
}
struct IMDDataset extends IUnknown {
    static IID := "{A07CCCD1-8148-11D0-87BB-00C04FC33942}"
    FreeAxisInfo(rgAxisInfo)
      => ComCall(3, this.p, IntPtr, rgAxisInfo.Length, MDAXISINFO.Ptr, rgAxisInfo)
    GetAxisInfo(prgAxisInfo)
      => ComCall(4, this.p, IntPtr.Ptr, prgAxisInfo.Length, MDAXISINFO.Ptr.Ptr, prgAxisInfo)
    GetAxisRowset(pUnkOuter, iAxis, riid, rgPropertySets, ppRowset)
      => ComCall(5, this.p, IUnknown, pUnkOuter, IntPtr, iAxis, GUID.Ptr, riid, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets, IUnknown.Ptr, ppRowset)
    GetCellData(hAccessor1, ulStartCell, ulEndCell, pData)
      => ComCall(6, this.p, HACCESSOR, hAccessor1, IntPtr, ulStartCell, IntPtr, ulEndCell, Struct.Ptr, pData)
    GetSpecification(riid, ppSpecification)
      => ComCall(7, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppSpecification)
}
struct IMDFind extends IUnknown {
    static IID := "{A07CCCD2-8148-11D0-87BB-00C04FC33942}"
    FindCell(ulStartingOrdinal, rgpwszMember, pulCellOrdinal)
      => ComCall(3, this.p, IntPtr, ulStartingOrdinal, IntPtr, rgpwszMember.Length, PWSTR.Ptr, rgpwszMember, IntPtr.Ptr, pulCellOrdinal)
    FindTuple(ulAxisIdentifier, ulStartingOrdinal, rgpwszMember, pulTupleOrdinal)
      => ComCall(4, this.p, UInt32, ulAxisIdentifier, IntPtr, ulStartingOrdinal, IntPtr, rgpwszMember.Length, PWSTR.Ptr, rgpwszMember, UInt32.Ptr, pulTupleOrdinal)
}
struct IMDRangeRowset extends IUnknown {
    static IID := "{0C733AA0-2A1C-11CE-ADE5-00AA0044773D}"
    GetRangeRowset(pUnkOuter, ulStartCell, ulEndCell, riid, rgPropertySets, ppRowset)
      => ComCall(3, this.p, IUnknown, pUnkOuter, IntPtr, ulStartCell, IntPtr, ulEndCell, GUID.Ptr, riid, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets, IUnknown.Ptr, ppRowset)
}
struct IAlterTable extends IUnknown {
    static IID := "{0C733AA5-2A1C-11CE-ADE5-00AA0044773D}"
    AlterColumn(pTableId, pColumnId, dwColumnDescFlags, pColumnDesc)
      => ComCall(3, this.p, DBID.Ptr, pTableId, DBID.Ptr, pColumnId, UInt32, dwColumnDescFlags, DBCOLUMNDESC.Ptr, pColumnDesc)
    AlterTable(pTableId, pNewTableId, rgPropertySets)
      => ComCall(4, this.p, DBID.Ptr, pTableId, DBID.Ptr, pNewTableId, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets)
}
struct IAlterIndex extends IUnknown {
    static IID := "{0C733AA6-2A1C-11CE-ADE5-00AA0044773D}"
    AlterIndex(pTableId, pIndexId, pNewIndexId, rgPropertySets)
      => ComCall(3, this.p, DBID.Ptr, pTableId, DBID.Ptr, pIndexId, DBID.Ptr, pNewIndexId, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets)
}
struct IRowsetChapterMember extends IUnknown {
    static IID := "{0C733AA8-2A1C-11CE-ADE5-00AA0044773D}"
    IsRowInChapter(hChapter, hRow)
      => ComCall(3, this.p, IntPtr, hChapter, IntPtr, hRow)
}
struct ICommandPersist extends IUnknown {
    static IID := "{0C733AA7-2A1C-11CE-ADE5-00AA0044773D}"
    DeleteCommand(pCommandID)
      => ComCall(3, this.p, DBID.Ptr, pCommandID)
    GetCurrentCommand(ppCommandID)
      => ComCall(4, this.p, DBID.Ptr.Ptr, ppCommandID)
    LoadCommand(pCommandID, dwFlags)
      => ComCall(5, this.p, DBID.Ptr, pCommandID, UInt32, dwFlags)
    SaveCommand(pCommandID, dwFlags)
      => ComCall(6, this.p, DBID.Ptr, pCommandID, UInt32, dwFlags)
}
struct IRowsetRefresh extends IUnknown {
    static IID := "{0C733AA9-2A1C-11CE-ADE5-00AA0044773D}"
    RefreshVisibleData(hChapter, cRows, rghRows, fOverWrite, pcRowsRefreshed, prghRowsRefreshed, prgRowStatus)
      => ComCall(3, this.p, IntPtr, hChapter, IntPtr, cRows, IntPtr.Ptr, rghRows, BOOL, fOverWrite, IntPtr.Ptr, pcRowsRefreshed, IntPtr.Ptr.Ptr, prghRowsRefreshed, UInt32.Ptr.Ptr, prgRowStatus)
    GetLastVisibleData(hRow, hAccessor1, pData)
      => ComCall(4, this.p, IntPtr, hRow, HACCESSOR, hAccessor1, Struct.Ptr, pData)
}
struct IParentRowset extends IUnknown {
    static IID := "{0C733AAA-2A1C-11CE-ADE5-00AA0044773D}"
    GetChildRowset(pUnkOuter, iOrdinal, riid, ppRowset)
      => ComCall(3, this.p, IUnknown, pUnkOuter, IntPtr, iOrdinal, GUID.Ptr, riid, IUnknown.Ptr, ppRowset)
}
struct IErrorRecords extends IUnknown {
    static IID := "{0C733A67-2A1C-11CE-ADE5-00AA0044773D}"
    AddErrorRecord(pErrorInfo, dwLookupID, pdispparams?, punkCustomError?, dwDynamicErrorID)
      => ComCall(3, this.p, ERRORINFO.Ptr, pErrorInfo, UInt32, dwLookupID, DISPPARAMS.Ptr, pdispparams?, IUnknown, punkCustomError?, UInt32, dwDynamicErrorID)
    GetBasicErrorInfo(ulRecordNum, pErrorInfo)
      => ComCall(4, this.p, UInt32, ulRecordNum, ERRORINFO.Ptr, pErrorInfo)
    GetCustomErrorObject(ulRecordNum, riid, ppObject)
      => ComCall(5, this.p, UInt32, ulRecordNum, GUID.Ptr, riid, IUnknown.Ptr, ppObject)
    GetErrorInfo(ulRecordNum, lcid, ppErrorInfo)
      => ComCall(6, this.p, UInt32, ulRecordNum, UInt32, lcid, IErrorInfo.Ptr, ppErrorInfo)
    GetErrorParameters(ulRecordNum, pdispparams)
      => ComCall(7, this.p, UInt32, ulRecordNum, DISPPARAMS.Ptr, pdispparams)
    GetRecordCount(pcRecords)
      => ComCall(8, this.p, UInt32.Ptr, pcRecords)
}
struct IErrorLookup extends IUnknown {
    static IID := "{0C733A66-2A1C-11CE-ADE5-00AA0044773D}"
    GetErrorDescription(hrError, dwLookupID, pdispparams, lcid, pbstrSource?, pbstrDescription?)
      => ComCall(3, this.p, HRESULT, hrError, UInt32, dwLookupID, DISPPARAMS.Ptr, pdispparams, UInt32, lcid, BSTR.Ptr, pbstrSource?, BSTR.Ptr, pbstrDescription?)
    GetHelpInfo(hrError, dwLookupID, lcid, pbstrHelpFile, pdwHelpContext)
      => ComCall(4, this.p, HRESULT, hrError, UInt32, dwLookupID, UInt32, lcid, BSTR.Ptr, pbstrHelpFile, UInt32.Ptr, pdwHelpContext)
    ReleaseErrors(dwDynamicErrorID)
      => ComCall(5, this.p, UInt32, dwDynamicErrorID)
}
struct ISQLErrorInfo extends IUnknown {
    static IID := "{0C733A74-2A1C-11CE-ADE5-00AA0044773D}"
    GetSQLInfo(pbstrSQLState, plNativeError)
      => ComCall(3, this.p, BSTR.Ptr, pbstrSQLState, Int32.Ptr, plNativeError)
}
struct IGetDataSource extends IUnknown {
    static IID := "{0C733A75-2A1C-11CE-ADE5-00AA0044773D}"
    GetDataSource(riid, ppDataSource)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppDataSource)
}
struct ITransactionLocal extends ITransaction {
    static IID := "{0C733A5F-2A1C-11CE-ADE5-00AA0044773D}"
    GetOptionsObject(ppOptions)
      => ComCall(6, this.p, ITransactionOptions.Ptr, ppOptions)
    StartTransaction(isoLevel, isoFlags, pOtherOptions?, pulTransactionLevel?)
      => ComCall(7, this.p, Int32, isoLevel, UInt32, isoFlags, ITransactionOptions, pOtherOptions?, UInt32.Ptr, pulTransactionLevel?)
}
struct ITransactionJoin extends IUnknown {
    static IID := "{0C733A5E-2A1C-11CE-ADE5-00AA0044773D}"
    GetOptionsObject(ppOptions)
      => ComCall(3, this.p, ITransactionOptions.Ptr, ppOptions)
    JoinTransaction(punkTransactionCoord?, isoLevel, isoFlags, pOtherOptions?)
      => ComCall(4, this.p, IUnknown, punkTransactionCoord?, Int32, isoLevel, UInt32, isoFlags, ITransactionOptions, pOtherOptions?)
}
struct ITransactionObject extends IUnknown {
    static IID := "{0C733A60-2A1C-11CE-ADE5-00AA0044773D}"
    GetTransactionObject(ulTransactionLevel, ppTransactionObject)
      => ComCall(3, this.p, UInt32, ulTransactionLevel, ITransaction.Ptr, ppTransactionObject)
}
struct ITrusteeAdmin extends IUnknown {
    static IID := "{0C733AA1-2A1C-11CE-ADE5-00AA0044773D}"
    CompareTrustees(pTrustee1, pTrustee2)
      => ComCall(3, this.p, TRUSTEE_W.Ptr, pTrustee1, TRUSTEE_W.Ptr, pTrustee2)
    CreateTrustee(pTrustee, rgPropertySets)
      => ComCall(4, this.p, TRUSTEE_W.Ptr, pTrustee, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets)
    DeleteTrustee(pTrustee)
      => ComCall(5, this.p, TRUSTEE_W.Ptr, pTrustee)
    SetTrusteeProperties(pTrustee, rgPropertySets)
      => ComCall(6, this.p, TRUSTEE_W.Ptr, pTrustee, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets)
    GetTrusteeProperties(pTrustee, rgPropertyIDSets, prgPropertySets)
      => ComCall(7, this.p, TRUSTEE_W.Ptr, pTrustee, UInt32, rgPropertyIDSets.Length, DBPROPIDSET.Ptr, rgPropertyIDSets, UInt32.Ptr, prgPropertySets.Length, DBPROPSET.Ptr.Ptr, prgPropertySets)
}
struct ITrusteeGroupAdmin extends IUnknown {
    static IID := "{0C733AA2-2A1C-11CE-ADE5-00AA0044773D}"
    AddMember(pMembershipTrustee, pMemberTrustee)
      => ComCall(3, this.p, TRUSTEE_W.Ptr, pMembershipTrustee, TRUSTEE_W.Ptr, pMemberTrustee)
    DeleteMember(pMembershipTrustee, pMemberTrustee)
      => ComCall(4, this.p, TRUSTEE_W.Ptr, pMembershipTrustee, TRUSTEE_W.Ptr, pMemberTrustee)
    IsMember(pMembershipTrustee, pMemberTrustee, pfStatus)
      => ComCall(5, this.p, TRUSTEE_W.Ptr, pMembershipTrustee, TRUSTEE_W.Ptr, pMemberTrustee, BOOL.Ptr, pfStatus)
    GetMembers(pMembershipTrustee, pcMembers, prgMembers)
      => ComCall(6, this.p, TRUSTEE_W.Ptr, pMembershipTrustee, UInt32.Ptr, pcMembers, TRUSTEE_W.Ptr.Ptr, prgMembers)
    GetMemberships(pTrustee, pcMemberships, prgMemberships)
      => ComCall(7, this.p, TRUSTEE_W.Ptr, pTrustee, UInt32.Ptr, pcMemberships, TRUSTEE_W.Ptr.Ptr, prgMemberships)
}
struct IObjectAccessControl extends IUnknown {
    static IID := "{0C733AA3-2A1C-11CE-ADE5-00AA0044773D}"
    GetObjectAccessRights(pObject, pcAccessEntries, prgAccessEntries)
      => ComCall(3, this.p, SEC_OBJECT.Ptr, pObject, UInt32.Ptr, pcAccessEntries, EXPLICIT_ACCESS_W.Ptr.Ptr, prgAccessEntries)
    GetObjectOwner(pObject, ppOwner)
      => ComCall(4, this.p, SEC_OBJECT.Ptr, pObject, TRUSTEE_W.Ptr.Ptr, ppOwner)
    IsObjectAccessAllowed(pObject, pAccessEntry, pfResult)
      => ComCall(5, this.p, SEC_OBJECT.Ptr, pObject, EXPLICIT_ACCESS_W.Ptr, pAccessEntry, BOOL.Ptr, pfResult)
    SetObjectAccessRights(pObject, cAccessEntries, prgAccessEntries)
      => ComCall(6, this.p, SEC_OBJECT.Ptr, pObject, UInt32, cAccessEntries, EXPLICIT_ACCESS_W.Ptr, prgAccessEntries)
    SetObjectOwner(pObject, pOwner)
      => ComCall(7, this.p, SEC_OBJECT.Ptr, pObject, TRUSTEE_W.Ptr, pOwner)
}
struct ACCESS_MASKENUM extends Int32 {
    static PERM_EXCLUSIVE := 512
    static PERM_READDESIGN := 1024
    static PERM_WRITEDESIGN := 2048
    static PERM_WITHGRANT := 4096
    static PERM_REFERENCE := 8192
    static PERM_CREATE := 16384
    static PERM_INSERT := 32768
    static PERM_DELETE := 65536
    static PERM_READCONTROL := 131072
    static PERM_WRITEPERMISSIONS := 262144
    static PERM_WRITEOWNER := 524288
    static PERM_MAXIMUM_ALLOWED := 33554432
    static PERM_ALL := 268435456
    static PERM_EXECUTE := 536870912
    static PERM_READ := -2147483648
    static PERM_UPDATE := 1073741824
    static PERM_DROP := 256
}
struct ISecurityInfo extends IUnknown {
    static IID := "{0C733AA4-2A1C-11CE-ADE5-00AA0044773D}"
    GetCurrentTrustee(ppTrustee)
      => ComCall(3, this.p, TRUSTEE_W.Ptr.Ptr, ppTrustee)
    GetObjectTypes(cObjectTypes, rgObjectTypes)
      => ComCall(4, this.p, UInt32.Ptr, cObjectTypes, GUID.Ptr.Ptr, rgObjectTypes)
    GetPermissions(ObjectType, pPermissions)
      => ComCall(5, this.p, GUID, ObjectType, UInt32.Ptr, pPermissions)
}
struct ITableCreation extends ITableDefinition {
    static IID := "{0C733ABC-2A1C-11CE-ADE5-00AA0044773D}"
    GetTableDefinition(pTableID, prgColumnDescs?, prgPropertySets?, prgConstraintDescs?, ppwszStringBuffer?)
      => ComCall(7, this.p, DBID.Ptr, pTableID, IntPtr.Ptr, prgColumnDescs?.Length ?? 0, DBCOLUMNDESC.Ptr.Ptr, prgColumnDescs?, UInt32.Ptr, prgPropertySets?.Length ?? 0, DBPROPSET.Ptr.Ptr, prgPropertySets?, UInt32.Ptr, prgConstraintDescs?.Length ?? 0, DBCONSTRAINTDESC.Ptr.Ptr, prgConstraintDescs?, UInt16.Ptr.Ptr, ppwszStringBuffer?)
}
struct ITableDefinitionWithConstraints extends ITableCreation {
    static IID := "{0C733AAB-2A1C-11CE-ADE5-00AA0044773D}"
    AddConstraint(pTableID, pConstraintDesc)
      => ComCall(8, this.p, DBID.Ptr, pTableID, DBCONSTRAINTDESC.Ptr, pConstraintDesc)
    CreateTableWithConstraints(pUnkOuter, pTableID, rgColumnDescs, rgConstraintDescs, riid, rgPropertySets, ppTableID, ppRowset)
      => ComCall(9, this.p, IUnknown, pUnkOuter, DBID.Ptr, pTableID, IntPtr, rgColumnDescs.Length, DBCOLUMNDESC.Ptr, rgColumnDescs, UInt32, rgConstraintDescs.Length, DBCONSTRAINTDESC.Ptr, rgConstraintDescs, GUID.Ptr, riid, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets, DBID.Ptr.Ptr, ppTableID, IUnknown.Ptr, ppRowset)
    DropConstraint(pTableID, pConstraintID)
      => ComCall(10, this.p, DBID.Ptr, pTableID, DBID.Ptr, pConstraintID)
}
struct IRow extends IUnknown {
    static IID := "{0C733AB4-2A1C-11CE-ADE5-00AA0044773D}"
    GetColumns(rgColumns)
      => ComCall(3, this.p, IntPtr, rgColumns.Length, DBCOLUMNACCESS.Ptr, rgColumns)
    GetSourceRowset(riid, ppRowset?, phRow?)
      => ComCall(4, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppRowset?, IntPtr.Ptr, phRow?)
    Open(pUnkOuter?, pColumnID, rguidColumnType, dwBindFlags, riid, ppUnk?)
      => ComCall(5, this.p, IUnknown, pUnkOuter?, DBID.Ptr, pColumnID, GUID.Ptr, rguidColumnType, UInt32, dwBindFlags, GUID.Ptr, riid, IUnknown.Ptr, ppUnk?)
}
struct IRowChange extends IUnknown {
    static IID := "{0C733AB5-2A1C-11CE-ADE5-00AA0044773D}"
    SetColumns(rgColumns)
      => ComCall(3, this.p, IntPtr, rgColumns.Length, DBCOLUMNACCESS.Ptr, rgColumns)
}
struct IRowSchemaChange extends IRowChange {
    static IID := "{0C733AAE-2A1C-11CE-ADE5-00AA0044773D}"
    DeleteColumns(rgColumnIDs, rgdwStatus)
      => ComCall(4, this.p, IntPtr, rgdwStatus.Length, DBID.Ptr, rgColumnIDs, UInt32.Ptr, rgdwStatus)
    AddColumns(rgNewColumnInfo, rgColumns)
      => ComCall(5, this.p, IntPtr, rgColumns.Length, DBCOLUMNINFO.Ptr, rgNewColumnInfo, DBCOLUMNACCESS.Ptr, rgColumns)
}
struct IGetRow extends IUnknown {
    static IID := "{0C733AAF-2A1C-11CE-ADE5-00AA0044773D}"
    GetRowFromHROW(pUnkOuter, hRow, riid, ppUnk)
      => ComCall(3, this.p, IUnknown, pUnkOuter, IntPtr, hRow, GUID.Ptr, riid, IUnknown.Ptr, ppUnk)
    GetURLFromHROW(hRow, ppwszURL)
      => ComCall(4, this.p, IntPtr, hRow, PWSTR.Ptr, ppwszURL)
}
struct IBindResource extends IUnknown {
    static IID := "{0C733AB1-2A1C-11CE-ADE5-00AA0044773D}"
    Bind(pUnkOuter?, pwszURL, dwBindURLFlags, rguid, riid, pAuthenticate?, pImplSession?, pdwBindStatus?, ppUnk)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, "Str", pwszURL, UInt32, dwBindURLFlags, GUID.Ptr, rguid, GUID.Ptr, riid, IAuthenticate, pAuthenticate?, DBIMPLICITSESSION.Ptr, pImplSession?, UInt32.Ptr, pdwBindStatus?, IUnknown.Ptr, ppUnk)
}
struct DBCOPYFLAGSENUM extends Int32 {
    static DBCOPY_ASYNC := 256
    static DBCOPY_REPLACE_EXISTING := 512
    static DBCOPY_ALLOW_EMULATION := 1024
    static DBCOPY_NON_RECURSIVE := 2048
    static DBCOPY_ATOMIC := 4096
}
struct DBMOVEFLAGSENUM extends Int32 {
    static DBMOVE_REPLACE_EXISTING := 1
    static DBMOVE_ASYNC := 256
    static DBMOVE_DONT_UPDATE_LINKS := 512
    static DBMOVE_ALLOW_EMULATION := 1024
    static DBMOVE_ATOMIC := 4096
}
struct DBDELETEFLAGSENUM extends Int32 {
    static DBDELETE_ASYNC := 256
    static DBDELETE_ATOMIC := 4096
}
struct IScopedOperations extends IBindResource {
    static IID := "{0C733AB0-2A1C-11CE-ADE5-00AA0044773D}"
    Copy(rgpwszSourceURLs?, rgpwszDestURLs, dwCopyFlags, pAuthenticate?, rgdwStatus, rgpwszNewURLs?, ppStringsBuffer?)
      => ComCall(4, this.p, IntPtr, rgpwszNewURLs?.Length ?? 0, PWSTR.Ptr, rgpwszSourceURLs?, PWSTR.Ptr, rgpwszDestURLs, UInt32, dwCopyFlags, IAuthenticate, pAuthenticate?, UInt32.Ptr, rgdwStatus, PWSTR.Ptr, rgpwszNewURLs?, UInt16.Ptr.Ptr, ppStringsBuffer?)
    Move(rgpwszSourceURLs?, rgpwszDestURLs, dwMoveFlags, pAuthenticate?, rgdwStatus, rgpwszNewURLs?, ppStringsBuffer?)
      => ComCall(5, this.p, IntPtr, rgpwszNewURLs?.Length ?? 0, PWSTR.Ptr, rgpwszSourceURLs?, PWSTR.Ptr, rgpwszDestURLs, UInt32, dwMoveFlags, IAuthenticate, pAuthenticate?, UInt32.Ptr, rgdwStatus, PWSTR.Ptr, rgpwszNewURLs?, UInt16.Ptr.Ptr, ppStringsBuffer?)
    Delete(rgpwszURLs, dwDeleteFlags, rgdwStatus)
      => ComCall(6, this.p, IntPtr, rgdwStatus.Length, PWSTR.Ptr, rgpwszURLs, UInt32, dwDeleteFlags, UInt32.Ptr, rgdwStatus)
    OpenRowset(pUnkOuter?, pTableID?, pIndexID?, riid, rgPropertySets, ppRowset?)
      => ComCall(7, this.p, IUnknown, pUnkOuter?, DBID.Ptr, pTableID?, DBID.Ptr, pIndexID?, GUID.Ptr, riid, UInt32, rgPropertySets.Length, DBPROPSET.Ptr, rgPropertySets, IUnknown.Ptr, ppRowset?)
}
struct ICreateRow extends IUnknown {
    static IID := "{0C733AB2-2A1C-11CE-ADE5-00AA0044773D}"
    CreateRow(pUnkOuter?, pwszURL, dwBindURLFlags, rguid, riid, pAuthenticate?, pImplSession?, pdwBindStatus, ppwszNewURL?, ppUnk)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, "Str", pwszURL, UInt32, dwBindURLFlags, GUID.Ptr, rguid, GUID.Ptr, riid, IAuthenticate, pAuthenticate?, DBIMPLICITSESSION.Ptr, pImplSession?, UInt32.Ptr, pdwBindStatus, PWSTR.Ptr, ppwszNewURL?, IUnknown.Ptr, ppUnk)
}
struct IDBBinderProperties extends IDBProperties {
    static IID := "{0C733AB3-2A1C-11CE-ADE5-00AA0044773D}"
    Reset()
      => ComCall(6, this.p)
}
struct IColumnsInfo2 extends IColumnsInfo {
    static IID := "{0C733AB8-2A1C-11CE-ADE5-00AA0044773D}"
    GetRestrictedColumnInfo(rgColumnIDMasks, dwFlags, pcColumns, prgColumnIDs, prgColumnInfo, ppStringsBuffer?)
      => ComCall(5, this.p, IntPtr, rgColumnIDMasks.Length, DBID.Ptr, rgColumnIDMasks, UInt32, dwFlags, IntPtr.Ptr, pcColumns, DBID.Ptr.Ptr, prgColumnIDs, DBCOLUMNINFO.Ptr.Ptr, prgColumnInfo, UInt16.Ptr.Ptr, ppStringsBuffer?)
}
struct IRegisterProvider extends IUnknown {
    static IID := "{0C733AB9-2A1C-11CE-ADE5-00AA0044773D}"
    GetURLMapping(pwszURL, dwReserved, pclsidProvider)
      => ComCall(3, this.p, "Str", pwszURL, IntPtr, dwReserved, GUID.Ptr, pclsidProvider)
    SetURLMapping(pwszURL, dwReserved, rclsidProvider)
      => ComCall(4, this.p, "Str", pwszURL, IntPtr, dwReserved, GUID.Ptr, rclsidProvider)
    UnregisterProvider(pwszURL, dwReserved, rclsidProvider)
      => ComCall(5, this.p, "Str", pwszURL, IntPtr, dwReserved, GUID.Ptr, rclsidProvider)
}
struct IGetSession extends IUnknown {
    static IID := "{0C733ABA-2A1C-11CE-ADE5-00AA0044773D}"
    GetSession(riid, ppSession)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppSession)
}
struct IGetSourceRow extends IUnknown {
    static IID := "{0C733ABB-2A1C-11CE-ADE5-00AA0044773D}"
    GetSourceRow(riid, ppRow)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppRow)
}
struct IRowsetCurrentIndex extends IRowsetIndex {
    static IID := "{0C733ABD-2A1C-11CE-ADE5-00AA0044773D}"
    GetIndex(ppIndexID)
      => ComCall(6, this.p, DBID.Ptr.Ptr, ppIndexID)
    SetIndex(pIndexID)
      => ComCall(7, this.p, DBID.Ptr, pIndexID)
}
struct ICommandStream extends IUnknown {
    static IID := "{0C733ABF-2A1C-11CE-ADE5-00AA0044773D}"
    GetCommandStream(piid?, pguidDialect?, ppCommandStream)
      => ComCall(3, this.p, GUID.Ptr, piid?, GUID.Ptr, pguidDialect?, IUnknown.Ptr, ppCommandStream)
    SetCommandStream(riid, rguidDialect, pCommandStream?)
      => ComCall(4, this.p, GUID.Ptr, riid, GUID.Ptr, rguidDialect, IUnknown, pCommandStream?)
}
struct IRowsetBookmark extends IUnknown {
    static IID := "{0C733AC2-2A1C-11CE-ADE5-00AA0044773D}"
    PositionOnBookmark(hChapter, pBookmark)
      => ComCall(3, this.p, IntPtr, hChapter, IntPtr, pBookmark.Size, UInt8.Ptr, pBookmark)
}
struct STRUCTURED_QUERY_SYNTAX extends Int32 {
    static SQS_NO_SYNTAX := 0
    static SQS_ADVANCED_QUERY_SYNTAX := 1
    static SQS_NATURAL_QUERY_SYNTAX := 2
}
struct STRUCTURED_QUERY_SINGLE_OPTION extends Int32 {
    static SQSO_SCHEMA := 0
    static SQSO_LOCALE_WORD_BREAKING := 1
    static SQSO_WORD_BREAKER := 2
    static SQSO_NATURAL_SYNTAX := 3
    static SQSO_AUTOMATIC_WILDCARD := 4
    static SQSO_TRACE_LEVEL := 5
    static SQSO_LANGUAGE_KEYWORDS := 6
    static SQSO_SYNTAX := 7
    static SQSO_TIME_ZONE := 8
    static SQSO_IMPLICIT_CONNECTOR := 9
    static SQSO_CONNECTOR_CASE := 10
}
struct STRUCTURED_QUERY_MULTIOPTION extends Int32 {
    static SQMO_VIRTUAL_PROPERTY := 0
    static SQMO_DEFAULT_PROPERTY := 1
    static SQMO_GENERATOR_FOR_TYPE := 2
    static SQMO_MAP_PROPERTY := 3
}
struct STRUCTURED_QUERY_PARSE_ERROR extends Int32 {
    static SQPE_NONE := 0
    static SQPE_EXTRA_OPENING_PARENTHESIS := 1
    static SQPE_EXTRA_CLOSING_PARENTHESIS := 2
    static SQPE_IGNORED_MODIFIER := 3
    static SQPE_IGNORED_CONNECTOR := 4
    static SQPE_IGNORED_KEYWORD := 5
    static SQPE_UNHANDLED := 6
}
struct STRUCTURED_QUERY_RESOLVE_OPTION extends Int32 {
    static SQRO_DEFAULT := 0
    static SQRO_DONT_RESOLVE_DATETIME := 1
    static SQRO_ALWAYS_ONE_INTERVAL := 2
    static SQRO_DONT_SIMPLIFY_CONDITION_TREES := 4
    static SQRO_DONT_MAP_RELATIONS := 8
    static SQRO_DONT_RESOLVE_RANGES := 16
    static SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS := 32
    static SQRO_DONT_SPLIT_WORDS := 64
    static SQRO_IGNORE_PHRASE_ORDER := 128
    static SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES := 256
    static SQRO_ADD_ROBUST_ITEM_NAME := 512
}
struct CASE_REQUIREMENT extends Int32 {
    static CASE_REQUIREMENT_ANY := 0
    static CASE_REQUIREMENT_UPPER_IF_AQS := 1
}
struct INTERVAL_LIMIT_KIND extends Int32 {
    static ILK_EXPLICIT_INCLUDED := 0
    static ILK_EXPLICIT_EXCLUDED := 1
    static ILK_NEGATIVE_INFINITY := 2
    static ILK_POSITIVE_INFINITY := 3
}
struct QUERY_PARSER_MANAGER_OPTION extends Int32 {
    static QPMO_SCHEMA_BINARY_NAME := 0
    static QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH := 1
    static QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH := 2
    static QPMO_LOCALIZED_SCHEMA_BINARY_PATH := 3
    static QPMO_APPEND_LCID_TO_LOCALIZED_PATH := 4
    static QPMO_LOCALIZER_SUPPORT := 5
}
struct IQueryParser extends IUnknown {
    static IID := "{2EBDEE67-3505-43F8-9946-EA44ABC8E5B0}"
    Parse(pszInputString, pCustomProperties, ppSolution)
      => ComCall(3, this.p, "Str", pszInputString, IEnumUnknown, pCustomProperties, IQuerySolution.Ptr, ppSolution)
    SetOption(option, pOptionValue)
      => ComCall(4, this.p, STRUCTURED_QUERY_SINGLE_OPTION, option, PROPVARIANT.Ptr, pOptionValue)
    GetOption(option, pOptionValue)
      => ComCall(5, this.p, STRUCTURED_QUERY_SINGLE_OPTION, option, PROPVARIANT.Ptr, pOptionValue)
    SetMultiOption(option, pszOptionKey, pOptionValue)
      => ComCall(6, this.p, STRUCTURED_QUERY_MULTIOPTION, option, "Str", pszOptionKey, PROPVARIANT.Ptr, pOptionValue)
    GetSchemaProvider(ppSchemaProvider)
      => ComCall(7, this.p, ISchemaProvider.Ptr, ppSchemaProvider)
    RestateToString(pCondition, fUseEnglish, ppszQueryString)
      => ComCall(8, this.p, ICondition, pCondition, BOOL, fUseEnglish, PWSTR.Ptr, ppszQueryString)
    ParsePropertyValue(pszPropertyName, pszInputString, ppSolution)
      => ComCall(9, this.p, "Str", pszPropertyName, "Str", pszInputString, IQuerySolution.Ptr, ppSolution)
    RestatePropertyValueToString(pCondition, fUseEnglish, ppszPropertyName, ppszQueryString)
      => ComCall(10, this.p, ICondition, pCondition, BOOL, fUseEnglish, PWSTR.Ptr, ppszPropertyName, PWSTR.Ptr, ppszQueryString)
}
struct IConditionFactory extends IUnknown {
    static IID := "{A5EFE073-B16F-474F-9F3E-9F8B497A3E08}"
    MakeNot(pcSub, fSimplify, ppcResult)
      => ComCall(3, this.p, ICondition, pcSub, BOOL, fSimplify, ICondition.Ptr, ppcResult)
    MakeAndOr(ct, peuSubs, fSimplify, ppcResult)
      => ComCall(4, this.p, CONDITION_TYPE, ct, IEnumUnknown, peuSubs, BOOL, fSimplify, ICondition.Ptr, ppcResult)
    MakeLeaf(pszPropertyName, cop, pszValueType, ppropvar, pPropertyNameTerm, pOperationTerm, pValueTerm, fExpand, ppcResult)
      => ComCall(5, this.p, "Str", pszPropertyName, CONDITION_OPERATION, cop, "Str", pszValueType, PROPVARIANT.Ptr, ppropvar, IRichChunk, pPropertyNameTerm, IRichChunk, pOperationTerm, IRichChunk, pValueTerm, BOOL, fExpand, ICondition.Ptr, ppcResult)
    Resolve(pc, sqro, pstReferenceTime?, ppcResolved)
      => ComCall(6, this.p, ICondition, pc, STRUCTURED_QUERY_RESOLVE_OPTION, sqro, SYSTEMTIME.Ptr, pstReferenceTime?, ICondition.Ptr, ppcResolved)
}
struct IQuerySolution extends IConditionFactory {
    static IID := "{D6EBC66B-8921-4193-AFDD-A1789FB7FF57}"
    GetQuery(ppQueryNode?, ppMainType?)
      => ComCall(7, this.p, ICondition.Ptr, ppQueryNode?, IEntity.Ptr, ppMainType?)
    GetErrors(riid, ppParseErrors)
      => ComCall(8, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppParseErrors)
    GetLexicalData(ppszInputString?, ppTokens?, plcid?, ppWordBreaker?)
      => ComCall(9, this.p, PWSTR.Ptr, ppszInputString?, ITokenCollection.Ptr, ppTokens?, UInt32.Ptr, plcid?, IUnknown.Ptr, ppWordBreaker?)
}
struct CONDITION_CREATION_OPTIONS extends Int32 {
    static CONDITION_CREATION_DEFAULT := 0
    static CONDITION_CREATION_NONE := 0
    static CONDITION_CREATION_SIMPLIFY := 1
    static CONDITION_CREATION_VECTOR_AND := 2
    static CONDITION_CREATION_VECTOR_OR := 4
    static CONDITION_CREATION_VECTOR_LEAF := 8
    static CONDITION_CREATION_USE_CONTENT_LOCALE := 16
}
struct IConditionFactory2 extends IConditionFactory {
    static IID := "{71D222E1-432F-429E-8C13-B6DAFDE5077A}"
    CreateTrueFalse(fVal, cco, riid, ppv)
      => ComCall(7, this.p, BOOL, fVal, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateNegation(pcSub, cco, riid, ppv)
      => ComCall(8, this.p, ICondition, pcSub, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateCompoundFromObjectArray(ct, poaSubs?, cco, riid, ppv)
      => ComCall(9, this.p, CONDITION_TYPE, ct, IObjectArray, poaSubs?, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateCompoundFromArray(ct, ppcondSubs, cco, riid, ppv)
      => ComCall(10, this.p, CONDITION_TYPE, ct, ICondition.Ptr, ppcondSubs, UInt32, ppcondSubs.Length, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateStringLeaf(propkey, cop, pszValue, pszLocaleName?, cco, riid, ppv)
      => ComCall(11, this.p, PROPERTYKEY.Ptr, propkey, CONDITION_OPERATION, cop, "Str", pszValue, "Str", pszLocaleName?, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateIntegerLeaf(propkey, cop, lValue, cco, riid, ppv)
      => ComCall(12, this.p, PROPERTYKEY.Ptr, propkey, CONDITION_OPERATION, cop, Int32, lValue, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateBooleanLeaf(propkey, cop, fValue, cco, riid, ppv)
      => ComCall(13, this.p, PROPERTYKEY.Ptr, propkey, CONDITION_OPERATION, cop, BOOL, fValue, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateLeaf(propkey, cop, propvar, pszSemanticType?, pszLocaleName?, pPropertyNameTerm?, pOperationTerm?, pValueTerm?, cco, riid, ppv)
      => ComCall(14, this.p, PROPERTYKEY.Ptr, propkey, CONDITION_OPERATION, cop, PROPVARIANT.Ptr, propvar, "Str", pszSemanticType?, "Str", pszLocaleName?, IRichChunk, pPropertyNameTerm?, IRichChunk, pOperationTerm?, IRichChunk, pValueTerm?, CONDITION_CREATION_OPTIONS, cco, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ResolveCondition(pc, sqro, pstReferenceTime?, riid, ppv)
      => ComCall(15, this.p, ICondition, pc, STRUCTURED_QUERY_RESOLVE_OPTION, sqro, SYSTEMTIME.Ptr, pstReferenceTime?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IConditionGenerator extends IUnknown {
    static IID := "{92D2CC58-4386-45A3-B98C-7E0CE64A4117}"
    Initialize(pSchemaProvider)
      => ComCall(3, this.p, ISchemaProvider, pSchemaProvider)
    RecognizeNamedEntities(pszInputString, lcidUserLocale, pTokenCollection, pNamedEntities)
      => ComCall(4, this.p, "Str", pszInputString, UInt32, lcidUserLocale, ITokenCollection, pTokenCollection, INamedEntityCollector, pNamedEntities)
    GenerateForLeaf(pConditionFactory, pszPropertyName, cop, pszValueType, pszValue, pszValue2, pPropertyNameTerm, pOperationTerm, pValueTerm, automaticWildcard, pNoStringQuery, ppQueryExpression)
      => ComCall(5, this.p, IConditionFactory, pConditionFactory, "Str", pszPropertyName, CONDITION_OPERATION, cop, "Str", pszValueType, "Str", pszValue, "Str", pszValue2, IRichChunk, pPropertyNameTerm, IRichChunk, pOperationTerm, IRichChunk, pValueTerm, BOOL, automaticWildcard, BOOL.Ptr, pNoStringQuery, ICondition.Ptr, ppQueryExpression)
    DefaultPhrase(pszValueType, ppropvar, fUseEnglish, ppszPhrase?)
      => ComCall(6, this.p, "Str", pszValueType, PROPVARIANT.Ptr, ppropvar, BOOL, fUseEnglish, PWSTR.Ptr, ppszPhrase?)
}
struct IInterval extends IUnknown {
    static IID := "{6BF0A714-3C18-430B-8B5D-83B1C234D3DB}"
    GetLimits(pilkLower, ppropvarLower, pilkUpper, ppropvarUpper)
      => ComCall(3, this.p, INTERVAL_LIMIT_KIND.Ptr, pilkLower, PROPVARIANT.Ptr, ppropvarLower, INTERVAL_LIMIT_KIND.Ptr, pilkUpper, PROPVARIANT.Ptr, ppropvarUpper)
}
struct IMetaData extends IUnknown {
    static IID := "{780102B0-C43B-4876-BC7B-5E9BA5C88794}"
    GetData(ppszKey?, ppszValue?)
      => ComCall(3, this.p, PWSTR.Ptr, ppszKey?, PWSTR.Ptr, ppszValue?)
}
struct IEntity extends IUnknown {
    static IID := "{24264891-E80B-4FD3-B7CE-4FF2FAE8931F}"
    Name(ppszName?)
      => ComCall(3, this.p, PWSTR.Ptr, ppszName?)
    Base(pBaseEntity)
      => ComCall(4, this.p, IEntity.Ptr, pBaseEntity)
    Relationships(riid, pRelationships)
      => ComCall(5, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pRelationships)
    GetRelationship(pszRelationName, pRelationship)
      => ComCall(6, this.p, "Str", pszRelationName, IRelationship.Ptr, pRelationship)
    MetaData(riid, pMetaData)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pMetaData)
    NamedEntities(riid, pNamedEntities)
      => ComCall(8, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pNamedEntities)
    GetNamedEntity(pszValue, ppNamedEntity)
      => ComCall(9, this.p, "Str", pszValue, INamedEntity.Ptr, ppNamedEntity)
    DefaultPhrase(ppszPhrase?)
      => ComCall(10, this.p, PWSTR.Ptr, ppszPhrase?)
}
struct IRelationship extends IUnknown {
    static IID := "{2769280B-5108-498C-9C7F-A51239B63147}"
    Name(ppszName?)
      => ComCall(3, this.p, PWSTR.Ptr, ppszName?)
    IsReal(pIsReal)
      => ComCall(4, this.p, BOOL.Ptr, pIsReal)
    Destination(pDestinationEntity)
      => ComCall(5, this.p, IEntity.Ptr, pDestinationEntity)
    MetaData(riid, pMetaData)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pMetaData)
    DefaultPhrase(ppszPhrase?)
      => ComCall(7, this.p, PWSTR.Ptr, ppszPhrase?)
}
struct INamedEntity extends IUnknown {
    static IID := "{ABDBD0B1-7D54-49FB-AB5C-BFF4130004CD}"
    GetValue(ppszValue)
      => ComCall(3, this.p, PWSTR.Ptr, ppszValue)
    DefaultPhrase(ppszPhrase?)
      => ComCall(4, this.p, PWSTR.Ptr, ppszPhrase?)
}
struct ISchemaProvider extends IUnknown {
    static IID := "{8CF89BCB-394C-49B2-AE28-A59DD4ED7F68}"
    Entities(riid, pEntities)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pEntities)
    RootEntity(pRootEntity)
      => ComCall(4, this.p, IEntity.Ptr, pRootEntity)
    GetEntity(pszEntityName, pEntity)
      => ComCall(5, this.p, "Str", pszEntityName, IEntity.Ptr, pEntity)
    MetaData(riid, pMetaData)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pMetaData)
    Localize(lcid, pSchemaLocalizerSupport)
      => ComCall(7, this.p, UInt32, lcid, ISchemaLocalizerSupport, pSchemaLocalizerSupport)
    SaveBinary(pszSchemaBinaryPath)
      => ComCall(8, this.p, "Str", pszSchemaBinaryPath)
    LookupAuthoredNamedEntity(pEntity, pszInputString, pTokenCollection, cTokensBegin, pcTokensLength, ppszValue)
      => ComCall(9, this.p, IEntity, pEntity, "Str", pszInputString, ITokenCollection, pTokenCollection, UInt32, cTokensBegin, UInt32.Ptr, pcTokensLength, PWSTR.Ptr, ppszValue)
}
struct ITokenCollection extends IUnknown {
    static IID := "{22D8B4F2-F577-4ADB-A335-C2AE88416FAB}"
    NumberOfTokens(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetToken(i, pBegin?, pLength?, ppsz?)
      => ComCall(4, this.p, UInt32, i, UInt32.Ptr, pBegin?, UInt32.Ptr, pLength?, PWSTR.Ptr, ppsz?)
}
struct NAMED_ENTITY_CERTAINTY extends Int32 {
    static NEC_LOW := 0
    static NEC_MEDIUM := 1
    static NEC_HIGH := 2
}
struct INamedEntityCollector extends IUnknown {
    static IID := "{AF2440F6-8AFC-47D0-9A7F-396A0ACFB43D}"
    Add(beginSpan, endSpan, beginActual, endActual, pType, pszValue, certainty)
      => ComCall(3, this.p, UInt32, beginSpan, UInt32, endSpan, UInt32, beginActual, UInt32, endActual, IEntity, pType, "Str", pszValue, NAMED_ENTITY_CERTAINTY, certainty)
}
struct ISchemaLocalizerSupport extends IUnknown {
    static IID := "{CA3FDCA2-BFBE-4EED-90D7-0CAEF0A1BDA1}"
    Localize(pszGlobalString, ppszLocalString)
      => ComCall(3, this.p, "Str", pszGlobalString, PWSTR.Ptr, ppszLocalString)
}
struct IQueryParserManager extends IUnknown {
    static IID := "{A879E3C4-AF77-44FB-8F37-EBD1487CF920}"
    CreateLoadedParser(pszCatalog, langidForKeywords, riid, ppQueryParser)
      => ComCall(3, this.p, "Str", pszCatalog, UInt16, langidForKeywords, GUID.Ptr, riid, Struct.Ptr.Ptr, ppQueryParser)
    InitializeOptions(fUnderstandNQS, fAutoWildCard, pQueryParser)
      => ComCall(4, this.p, BOOL, fUnderstandNQS, BOOL, fAutoWildCard, IQueryParser, pQueryParser)
    SetOption(option, pOptionValue)
      => ComCall(5, this.p, QUERY_PARSER_MANAGER_OPTION, option, PROPVARIANT.Ptr, pOptionValue)
}
struct HITRANGE {
    iPosition : UInt32
    cLength : UInt32
}
struct IUrlAccessor extends IUnknown {
    static IID := "{0B63E318-9CCC-11D0-BCDB-00805FCCCE04}"
    AddRequestParameter(pSpec, pVar)
      => ComCall(3, this.p, PROPSPEC.Ptr, pSpec, PROPVARIANT.Ptr, pVar)
    GetDocFormat(wszDocFormat, pdwLength)
      => ComCall(4, this.p, PWSTR, wszDocFormat, UInt32, wszDocFormat.Length, UInt32.Ptr, pdwLength)
    GetCLSID(pClsid)
      => ComCall(5, this.p, GUID.Ptr, pClsid)
    GetHost(wszHost, pdwLength)
      => ComCall(6, this.p, PWSTR, wszHost, UInt32, wszHost.Length, UInt32.Ptr, pdwLength)
    IsDirectory()
      => ComCall(7, this.p)
    GetSize(pllSize)
      => ComCall(8, this.p, Int64.Ptr, pllSize)
    GetLastModified(pftLastModified)
      => ComCall(9, this.p, FILETIME.Ptr, pftLastModified)
    GetFileName(wszFileName, pdwLength)
      => ComCall(10, this.p, PWSTR, wszFileName, UInt32, wszFileName.Length, UInt32.Ptr, pdwLength)
    GetSecurityDescriptor(pSD, pdwLength)
      => ComCall(11, this.p, UInt8.Ptr, pSD, UInt32, pSD.Length, UInt32.Ptr, pdwLength)
    GetRedirectedURL(wszRedirectedURL, pdwLength)
      => ComCall(12, this.p, PWSTR, wszRedirectedURL, UInt32, wszRedirectedURL.Length, UInt32.Ptr, pdwLength)
    GetSecurityProvider(pSPClsid)
      => ComCall(13, this.p, GUID.Ptr, pSPClsid)
    BindToStream(ppStream)
      => ComCall(14, this.p, IStream.Ptr, ppStream)
    BindToFilter(ppFilter)
      => ComCall(15, this.p, IFilter.Ptr, ppFilter)
}
struct IUrlAccessor2 extends IUrlAccessor {
    static IID := "{C7310734-AC80-11D1-8DF3-00C04FB6EF4F}"
    GetDisplayUrl(wszDocUrl, pdwLength)
      => ComCall(16, this.p, PWSTR, wszDocUrl, UInt32, wszDocUrl.Length, UInt32.Ptr, pdwLength)
    IsDocument()
      => ComCall(17, this.p)
    GetCodePage(wszCodePage, pdwLength)
      => ComCall(18, this.p, PWSTR, wszCodePage, UInt32, wszCodePage.Length, UInt32.Ptr, pdwLength)
}
struct IUrlAccessor3 extends IUrlAccessor2 {
    static IID := "{6FBC7005-0455-4874-B8FF-7439450241A3}"
    GetImpersonationSidBlobs(pcwszURL, pcSidCount, ppSidBlobs)
      => ComCall(19, this.p, "Str", pcwszURL, UInt32.Ptr, pcSidCount, BLOB.Ptr.Ptr, ppSidBlobs)
}
struct IUrlAccessor4 extends IUrlAccessor3 {
    static IID := "{5CC51041-C8D2-41D7-BCA3-9E9E286297DC}"
    ShouldIndexItemContent(pfIndexContent)
      => ComCall(20, this.p, BOOL.Ptr, pfIndexContent)
    ShouldIndexProperty(key, pfIndexProperty)
      => ComCall(21, this.p, PROPERTYKEY.Ptr, key, BOOL.Ptr, pfIndexProperty)
}
struct IOpLockStatus extends IUnknown {
    static IID := "{C731065D-AC80-11D1-8DF3-00C04FB6EF4F}"
    IsOplockValid(pfIsOplockValid)
      => ComCall(3, this.p, BOOL.Ptr, pfIsOplockValid)
    IsOplockBroken(pfIsOplockBroken)
      => ComCall(4, this.p, BOOL.Ptr, pfIsOplockBroken)
    GetOplockEventHandle(phOplockEv)
      => ComCall(5, this.p, HANDLE.Ptr, phOplockEv)
}
struct ISearchProtocolThreadContext extends IUnknown {
    static IID := "{C73106E1-AC80-11D1-8DF3-00C04FB6EF4F}"
    ThreadInit()
      => ComCall(3, this.p)
    ThreadShutdown()
      => ComCall(4, this.p)
    ThreadIdle(dwTimeElaspedSinceLastCallInMS)
      => ComCall(5, this.p, UInt32, dwTimeElaspedSinceLastCallInMS)
}
struct TIMEOUT_INFO {
    dwSize : UInt32
    dwConnectTimeout : UInt32
    dwDataTimeout : UInt32
}
struct PROXY_ACCESS extends Int32 {
    static PROXY_ACCESS_PRECONFIG := 0
    static PROXY_ACCESS_DIRECT := 1
    static PROXY_ACCESS_PROXY := 2
}
struct PROXY_INFO {
    dwSize : UInt32
    pcwszUserAgent : PWSTR
    paUseProxy : PROXY_ACCESS
    fLocalBypass : BOOL
    dwPortNumber : UInt32
    pcwszProxyName : PWSTR
    pcwszBypassList : PWSTR
}
struct AUTH_TYPE extends Int32 {
    static eAUTH_TYPE_ANONYMOUS := 0
    static eAUTH_TYPE_NTLM := 1
    static eAUTH_TYPE_BASIC := 2
}
struct AUTHENTICATION_INFO {
    dwSize : UInt32
    atAuthenticationType : AUTH_TYPE
    pcwszUser : PWSTR
    pcwszPassword : PWSTR
}
struct INCREMENTAL_ACCESS_INFO {
    dwSize : UInt32
    ftLastModifiedTime : FILETIME
}
struct ITEM_INFO {
    dwSize : UInt32
    pcwszFromEMail : PWSTR
    pcwszApplicationName : PWSTR
    pcwszCatalogName : PWSTR
    pcwszContentClass : PWSTR
}
struct ISearchProtocol extends IUnknown {
    static IID := "{C73106BA-AC80-11D1-8DF3-00C04FB6EF4F}"
    Init(pTimeoutInfo, pProtocolHandlerSite, pProxyInfo)
      => ComCall(3, this.p, TIMEOUT_INFO.Ptr, pTimeoutInfo, IProtocolHandlerSite, pProtocolHandlerSite, PROXY_INFO.Ptr, pProxyInfo)
    CreateAccessor(pcwszURL, pAuthenticationInfo, pIncrementalAccessInfo, pItemInfo, ppAccessor)
      => ComCall(4, this.p, "Str", pcwszURL, AUTHENTICATION_INFO.Ptr, pAuthenticationInfo, INCREMENTAL_ACCESS_INFO.Ptr, pIncrementalAccessInfo, ITEM_INFO.Ptr, pItemInfo, IUrlAccessor.Ptr, ppAccessor)
    CloseAccessor(pAccessor)
      => ComCall(5, this.p, IUrlAccessor, pAccessor)
    ShutDown()
      => ComCall(6, this.p)
}
struct ISearchProtocol2 extends ISearchProtocol {
    static IID := "{7789F0B2-B5B2-4722-8B65-5DBD150697A9}"
    CreateAccessorEx(pcwszURL, pAuthenticationInfo, pIncrementalAccessInfo, pItemInfo, pUserData, ppAccessor)
      => ComCall(7, this.p, "Str", pcwszURL, AUTHENTICATION_INFO.Ptr, pAuthenticationInfo, INCREMENTAL_ACCESS_INFO.Ptr, pIncrementalAccessInfo, ITEM_INFO.Ptr, pItemInfo, BLOB.Ptr, pUserData, IUrlAccessor.Ptr, ppAccessor)
}
struct IProtocolHandlerSite extends IUnknown {
    static IID := "{0B63E385-9CCC-11D0-BCDB-00805FCCCE04}"
    GetFilter(pclsidObj, pcwszContentType, pcwszExtension, ppFilter)
      => ComCall(3, this.p, GUID.Ptr, pclsidObj, "Str", pcwszContentType, "Str", pcwszExtension, IFilter.Ptr, ppFilter)
}
struct ISearchRoot extends IUnknown {
    static IID := "{04C18CCF-1F57-4CBD-88CC-3900F5195CE3}"
    put_Schedule(pszTaskArg)
      => ComCall(3, this.p, "Str", pszTaskArg)
    get_Schedule(ppszTaskArg)
      => ComCall(4, this.p, PWSTR.Ptr, ppszTaskArg)
    put_RootURL(pszURL)
      => ComCall(5, this.p, "Str", pszURL)
    get_RootURL(ppszURL)
      => ComCall(6, this.p, PWSTR.Ptr, ppszURL)
    put_IsHierarchical(fIsHierarchical)
      => ComCall(7, this.p, BOOL, fIsHierarchical)
    get_IsHierarchical(pfIsHierarchical)
      => ComCall(8, this.p, BOOL.Ptr, pfIsHierarchical)
    put_ProvidesNotifications(fProvidesNotifications)
      => ComCall(9, this.p, BOOL, fProvidesNotifications)
    get_ProvidesNotifications(pfProvidesNotifications)
      => ComCall(10, this.p, BOOL.Ptr, pfProvidesNotifications)
    put_UseNotificationsOnly(fUseNotificationsOnly)
      => ComCall(11, this.p, BOOL, fUseNotificationsOnly)
    get_UseNotificationsOnly(pfUseNotificationsOnly)
      => ComCall(12, this.p, BOOL.Ptr, pfUseNotificationsOnly)
    put_EnumerationDepth(dwDepth)
      => ComCall(13, this.p, UInt32, dwDepth)
    get_EnumerationDepth(pdwDepth)
      => ComCall(14, this.p, UInt32.Ptr, pdwDepth)
    put_HostDepth(dwDepth)
      => ComCall(15, this.p, UInt32, dwDepth)
    get_HostDepth(pdwDepth)
      => ComCall(16, this.p, UInt32.Ptr, pdwDepth)
    put_FollowDirectories(fFollowDirectories)
      => ComCall(17, this.p, BOOL, fFollowDirectories)
    get_FollowDirectories(pfFollowDirectories)
      => ComCall(18, this.p, BOOL.Ptr, pfFollowDirectories)
    put_AuthenticationType(authType)
      => ComCall(19, this.p, AUTH_TYPE, authType)
    get_AuthenticationType(pAuthType)
      => ComCall(20, this.p, AUTH_TYPE.Ptr, pAuthType)
    put_User(pszUser)
      => ComCall(21, this.p, "Str", pszUser)
    get_User(ppszUser)
      => ComCall(22, this.p, PWSTR.Ptr, ppszUser)
    put_Password(pszPassword)
      => ComCall(23, this.p, "Str", pszPassword)
    get_Password(ppszPassword)
      => ComCall(24, this.p, PWSTR.Ptr, ppszPassword)
}
struct IEnumSearchRoots extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF52}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ISearchRoot.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSearchRoots.Ptr, ppenum)
}
struct FOLLOW_FLAGS extends Int32 {
    static FF_INDEXCOMPLEXURLS := 1
    static FF_SUPPRESSINDEXING := 2
}
struct ISearchScopeRule extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF53}"
    get_PatternOrURL(ppszPatternOrURL)
      => ComCall(3, this.p, PWSTR.Ptr, ppszPatternOrURL)
    get_IsIncluded(pfIsIncluded)
      => ComCall(4, this.p, BOOL.Ptr, pfIsIncluded)
    get_IsDefault(pfIsDefault)
      => ComCall(5, this.p, BOOL.Ptr, pfIsDefault)
    get_FollowFlags(pFollowFlags)
      => ComCall(6, this.p, UInt32.Ptr, pFollowFlags)
}
struct IEnumSearchScopeRules extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF54}"
    Next(pprgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, pprgelt.Length, ISearchScopeRule.Ptr, pprgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSearchScopeRules.Ptr, ppenum)
}
struct CLUSION_REASON extends Int32 {
    static CLUSIONREASON_UNKNOWNSCOPE := 0
    static CLUSIONREASON_DEFAULT := 1
    static CLUSIONREASON_USER := 2
    static CLUSIONREASON_GROUPPOLICY := 3
    static CLUSIONREASON_USAGE := 4
}
struct ISearchCrawlScopeManager extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF55}"
    AddDefaultScopeRule(pszURL, fInclude, fFollowFlags)
      => ComCall(3, this.p, "Str", pszURL, BOOL, fInclude, UInt32, fFollowFlags)
    AddRoot(pSearchRoot)
      => ComCall(4, this.p, ISearchRoot, pSearchRoot)
    RemoveRoot(pszURL)
      => ComCall(5, this.p, "Str", pszURL)
    EnumerateRoots(ppSearchRoots)
      => ComCall(6, this.p, IEnumSearchRoots.Ptr, ppSearchRoots)
    AddHierarchicalScope(pszURL, fInclude, fDefault, fOverrideChildren)
      => ComCall(7, this.p, "Str", pszURL, BOOL, fInclude, BOOL, fDefault, BOOL, fOverrideChildren)
    AddUserScopeRule(pszURL, fInclude, fOverrideChildren, fFollowFlags)
      => ComCall(8, this.p, "Str", pszURL, BOOL, fInclude, BOOL, fOverrideChildren, UInt32, fFollowFlags)
    RemoveScopeRule(pszRule)
      => ComCall(9, this.p, "Str", pszRule)
    EnumerateScopeRules(ppSearchScopeRules)
      => ComCall(10, this.p, IEnumSearchScopeRules.Ptr, ppSearchScopeRules)
    HasParentScopeRule(pszURL, pfHasParentRule)
      => ComCall(11, this.p, "Str", pszURL, BOOL.Ptr, pfHasParentRule)
    HasChildScopeRule(pszURL, pfHasChildRule)
      => ComCall(12, this.p, "Str", pszURL, BOOL.Ptr, pfHasChildRule)
    IncludedInCrawlScope(pszURL, pfIsIncluded)
      => ComCall(13, this.p, "Str", pszURL, BOOL.Ptr, pfIsIncluded)
    IncludedInCrawlScopeEx(pszURL, pfIsIncluded, pReason)
      => ComCall(14, this.p, "Str", pszURL, BOOL.Ptr, pfIsIncluded, CLUSION_REASON.Ptr, pReason)
    RevertToDefaultScopes()
      => ComCall(15, this.p)
    SaveAll()
      => ComCall(16, this.p)
    GetParentScopeVersionId(pszURL, plScopeId)
      => ComCall(17, this.p, "Str", pszURL, Int32.Ptr, plScopeId)
    RemoveDefaultScopeRule(pszURL)
      => ComCall(18, this.p, "Str", pszURL)
}
struct ISearchCrawlScopeManager2 extends ISearchCrawlScopeManager {
    static IID := "{6292F7AD-4E19-4717-A534-8FC22BCD5CCD}"
    GetVersion(plVersion, phFileMapping)
      => ComCall(19, this.p, Int32.Ptr.Ptr, plVersion, HANDLE.Ptr, phFileMapping)
}
struct SEARCH_KIND_OF_CHANGE extends Int32 {
    static SEARCH_CHANGE_ADD := 0
    static SEARCH_CHANGE_DELETE := 1
    static SEARCH_CHANGE_MODIFY := 2
    static SEARCH_CHANGE_MOVE_RENAME := 3
    static SEARCH_CHANGE_SEMANTICS_DIRECTORY := 262144
    static SEARCH_CHANGE_SEMANTICS_SHALLOW := 524288
    static SEARCH_CHANGE_SEMANTICS_UPDATE_SECURITY := 4194304
}
struct SEARCH_NOTIFICATION_PRIORITY extends Int32 {
    static SEARCH_NORMAL_PRIORITY := 0
    static SEARCH_HIGH_PRIORITY := 1
}
struct SEARCH_ITEM_CHANGE {
    Change : SEARCH_KIND_OF_CHANGE
    Priority : SEARCH_NOTIFICATION_PRIORITY
    pUserData : BLOB.Ptr
    lpwszURL : PWSTR
    lpwszOldURL : PWSTR
}
struct ISearchItemsChangedSink extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF58}"
    StartedMonitoringScope(pszURL)
      => ComCall(3, this.p, "Str", pszURL)
    StoppedMonitoringScope(pszURL)
      => ComCall(4, this.p, "Str", pszURL)
    OnItemsChanged(rgDataChangeEntries, rgdwDocIds, rghrCompletionCodes)
      => ComCall(5, this.p, UInt32, rghrCompletionCodes.Length, SEARCH_ITEM_CHANGE.Ptr, rgDataChangeEntries, UInt32.Ptr, rgdwDocIds, HRESULT.Ptr, rghrCompletionCodes)
}
struct SEARCH_ITEM_PERSISTENT_CHANGE {
    Change : SEARCH_KIND_OF_CHANGE
    URL : PWSTR
    OldURL : PWSTR
    Priority : SEARCH_NOTIFICATION_PRIORITY
}
struct ISearchPersistentItemsChangedSink extends IUnknown {
    static IID := "{A2FFDF9B-4758-4F84-B729-DF81A1A0612F}"
    StartedMonitoringScope(pszURL)
      => ComCall(3, this.p, "Str", pszURL)
    StoppedMonitoringScope(pszURL)
      => ComCall(4, this.p, "Str", pszURL)
    OnItemsChanged(DataChangeEntries, hrCompletionCodes)
      => ComCall(5, this.p, UInt32, hrCompletionCodes.Length, SEARCH_ITEM_PERSISTENT_CHANGE.Ptr, DataChangeEntries, HRESULT.Ptr, hrCompletionCodes)
}
struct ISearchViewChangedSink extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF65}"
    OnChange(pdwDocID, pChange, pfInView)
      => ComCall(3, this.p, Int32.Ptr, pdwDocID, SEARCH_ITEM_CHANGE.Ptr, pChange, BOOL.Ptr, pfInView)
}
struct SEARCH_INDEXING_PHASE extends Int32 {
    static SEARCH_INDEXING_PHASE_GATHERER := 0
    static SEARCH_INDEXING_PHASE_QUERYABLE := 1
    static SEARCH_INDEXING_PHASE_PERSISTED := 2
}
struct SEARCH_ITEM_INDEXING_STATUS {
    dwDocID : UInt32
    hrIndexingStatus : HRESULT
}
struct ISearchNotifyInlineSite extends IUnknown {
    static IID := "{B5702E61-E75C-4B64-82A1-6CB4F832FCCF}"
    OnItemIndexedStatusChange(sipStatus, rgItemStatusEntries)
      => ComCall(3, this.p, SEARCH_INDEXING_PHASE, sipStatus, UInt32, rgItemStatusEntries.Length, SEARCH_ITEM_INDEXING_STATUS.Ptr, rgItemStatusEntries)
    OnCatalogStatusChange(guidCatalogResetSignature, guidCheckPointSignature, dwLastCheckPointNumber)
      => ComCall(4, this.p, GUID.Ptr, guidCatalogResetSignature, GUID.Ptr, guidCheckPointSignature, UInt32, dwLastCheckPointNumber)
}
struct CatalogStatus extends Int32 {
    static CATALOG_STATUS_IDLE := 0
    static CATALOG_STATUS_PAUSED := 1
    static CATALOG_STATUS_RECOVERING := 2
    static CATALOG_STATUS_FULL_CRAWL := 3
    static CATALOG_STATUS_INCREMENTAL_CRAWL := 4
    static CATALOG_STATUS_PROCESSING_NOTIFICATIONS := 5
    static CATALOG_STATUS_SHUTTING_DOWN := 6
}
struct CatalogPausedReason extends Int32 {
    static CATALOG_PAUSED_REASON_NONE := 0
    static CATALOG_PAUSED_REASON_HIGH_IO := 1
    static CATALOG_PAUSED_REASON_HIGH_CPU := 2
    static CATALOG_PAUSED_REASON_HIGH_NTF_RATE := 3
    static CATALOG_PAUSED_REASON_LOW_BATTERY := 4
    static CATALOG_PAUSED_REASON_LOW_MEMORY := 5
    static CATALOG_PAUSED_REASON_LOW_DISK := 6
    static CATALOG_PAUSED_REASON_DELAYED_RECOVERY := 7
    static CATALOG_PAUSED_REASON_USER_ACTIVE := 8
    static CATALOG_PAUSED_REASON_EXTERNAL := 9
    static CATALOG_PAUSED_REASON_UPGRADING := 10
}
struct ISearchCatalogManager extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF50}"
    get_Name(pszName)
      => ComCall(3, this.p, PWSTR.Ptr, pszName)
    GetParameter(pszName, ppValue)
      => ComCall(4, this.p, "Str", pszName, PROPVARIANT.Ptr.Ptr, ppValue)
    SetParameter(pszName, pValue)
      => ComCall(5, this.p, "Str", pszName, PROPVARIANT.Ptr, pValue)
    GetCatalogStatus(pStatus, pPausedReason)
      => ComCall(6, this.p, CatalogStatus.Ptr, pStatus, CatalogPausedReason.Ptr, pPausedReason)
    Reset()
      => ComCall(7, this.p)
    Reindex()
      => ComCall(8, this.p)
    ReindexMatchingURLs(pszPattern)
      => ComCall(9, this.p, "Str", pszPattern)
    ReindexSearchRoot(pszRootURL)
      => ComCall(10, this.p, "Str", pszRootURL)
    put_ConnectTimeout(dwConnectTimeout)
      => ComCall(11, this.p, UInt32, dwConnectTimeout)
    get_ConnectTimeout(pdwConnectTimeout)
      => ComCall(12, this.p, UInt32.Ptr, pdwConnectTimeout)
    put_DataTimeout(dwDataTimeout)
      => ComCall(13, this.p, UInt32, dwDataTimeout)
    get_DataTimeout(pdwDataTimeout)
      => ComCall(14, this.p, UInt32.Ptr, pdwDataTimeout)
    NumberOfItems(plCount)
      => ComCall(15, this.p, Int32.Ptr, plCount)
    NumberOfItemsToIndex(plIncrementalCount, plNotificationQueue, plHighPriorityQueue)
      => ComCall(16, this.p, Int32.Ptr, plIncrementalCount, Int32.Ptr, plNotificationQueue, Int32.Ptr, plHighPriorityQueue)
    URLBeingIndexed(pszUrl)
      => ComCall(17, this.p, PWSTR.Ptr, pszUrl)
    GetURLIndexingState(pszURL, pdwState)
      => ComCall(18, this.p, "Str", pszURL, UInt32.Ptr, pdwState)
    GetPersistentItemsChangedSink(ppISearchPersistentItemsChangedSink)
      => ComCall(19, this.p, ISearchPersistentItemsChangedSink.Ptr, ppISearchPersistentItemsChangedSink)
    RegisterViewForNotification(pszView, pViewChangedSink, pdwCookie)
      => ComCall(20, this.p, "Str", pszView, ISearchViewChangedSink, pViewChangedSink, UInt32.Ptr, pdwCookie)
    GetItemsChangedSink(pISearchNotifyInlineSite, riid, ppv, pGUIDCatalogResetSignature, pGUIDCheckPointSignature, pdwLastCheckPointNumber)
      => ComCall(21, this.p, ISearchNotifyInlineSite, pISearchNotifyInlineSite, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv, GUID.Ptr, pGUIDCatalogResetSignature, GUID.Ptr, pGUIDCheckPointSignature, UInt32.Ptr, pdwLastCheckPointNumber)
    UnregisterViewForNotification(dwCookie)
      => ComCall(22, this.p, UInt32, dwCookie)
    SetExtensionClusion(pszExtension, fExclude)
      => ComCall(23, this.p, "Str", pszExtension, BOOL, fExclude)
    EnumerateExcludedExtensions(ppExtensions)
      => ComCall(24, this.p, IEnumString.Ptr, ppExtensions)
    GetQueryHelper(ppSearchQueryHelper)
      => ComCall(25, this.p, ISearchQueryHelper.Ptr, ppSearchQueryHelper)
    put_DiacriticSensitivity(fDiacriticSensitive)
      => ComCall(26, this.p, BOOL, fDiacriticSensitive)
    get_DiacriticSensitivity(pfDiacriticSensitive)
      => ComCall(27, this.p, BOOL.Ptr, pfDiacriticSensitive)
    GetCrawlScopeManager(ppCrawlScopeManager)
      => ComCall(28, this.p, ISearchCrawlScopeManager.Ptr, ppCrawlScopeManager)
}
struct PRIORITIZE_FLAGS extends Int32 {
    static PRIORITIZE_FLAG_RETRYFAILEDITEMS := 1
    static PRIORITIZE_FLAG_IGNOREFAILURECOUNT := 2
}
struct ISearchCatalogManager2 extends ISearchCatalogManager {
    static IID := "{7AC3286D-4D1D-4817-84FC-C1C85E3AF0D9}"
    PrioritizeMatchingURLs(pszPattern, dwPrioritizeFlags)
      => ComCall(29, this.p, "Str", pszPattern, PRIORITIZE_FLAGS, dwPrioritizeFlags)
}
struct ISearchCatalogManager3 extends ISearchCatalogManager2 {
    static IID := "{DE837E8F-634F-4AB0-BDFC-9FC3A1FC50DC}"
    IsContainsSemanticSupported(isContainsSemanticSupported)
      => ComCall(30, this.p, BOOL.Ptr, isContainsSemanticSupported)
}
struct SEARCH_TERM_EXPANSION extends Int32 {
    static SEARCH_TERM_NO_EXPANSION := 0
    static SEARCH_TERM_PREFIX_ALL := 1
    static SEARCH_TERM_STEM_ALL := 2
}
struct SEARCH_QUERY_SYNTAX extends Int32 {
    static SEARCH_NO_QUERY_SYNTAX := 0
    static SEARCH_ADVANCED_QUERY_SYNTAX := 1
    static SEARCH_NATURAL_QUERY_SYNTAX := 2
}
struct SEARCH_COLUMN_PROPERTIES {
    Value : PROPVARIANT
    lcid : UInt32
}
struct ISearchQueryHelper extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF63}"
    get_ConnectionString(pszConnectionString)
      => ComCall(3, this.p, PWSTR.Ptr, pszConnectionString)
    put_QueryContentLocale(lcid)
      => ComCall(4, this.p, UInt32, lcid)
    get_QueryContentLocale(plcid)
      => ComCall(5, this.p, UInt32.Ptr, plcid)
    put_QueryKeywordLocale(lcid)
      => ComCall(6, this.p, UInt32, lcid)
    get_QueryKeywordLocale(plcid)
      => ComCall(7, this.p, UInt32.Ptr, plcid)
    put_QueryTermExpansion(expandTerms)
      => ComCall(8, this.p, SEARCH_TERM_EXPANSION, expandTerms)
    get_QueryTermExpansion(pExpandTerms)
      => ComCall(9, this.p, SEARCH_TERM_EXPANSION.Ptr, pExpandTerms)
    put_QuerySyntax(querySyntax)
      => ComCall(10, this.p, SEARCH_QUERY_SYNTAX, querySyntax)
    get_QuerySyntax(pQuerySyntax)
      => ComCall(11, this.p, SEARCH_QUERY_SYNTAX.Ptr, pQuerySyntax)
    put_QueryContentProperties(pszContentProperties)
      => ComCall(12, this.p, "Str", pszContentProperties)
    get_QueryContentProperties(ppszContentProperties)
      => ComCall(13, this.p, PWSTR.Ptr, ppszContentProperties)
    put_QuerySelectColumns(pszSelectColumns)
      => ComCall(14, this.p, "Str", pszSelectColumns)
    get_QuerySelectColumns(ppszSelectColumns)
      => ComCall(15, this.p, PWSTR.Ptr, ppszSelectColumns)
    put_QueryWhereRestrictions(pszRestrictions)
      => ComCall(16, this.p, "Str", pszRestrictions)
    get_QueryWhereRestrictions(ppszRestrictions)
      => ComCall(17, this.p, PWSTR.Ptr, ppszRestrictions)
    put_QuerySorting(pszSorting)
      => ComCall(18, this.p, "Str", pszSorting)
    get_QuerySorting(ppszSorting)
      => ComCall(19, this.p, PWSTR.Ptr, ppszSorting)
    GenerateSQLFromUserQuery(pszQuery, ppszSQL)
      => ComCall(20, this.p, "Str", pszQuery, PWSTR.Ptr, ppszSQL)
    WriteProperties(itemID, pColumns, pValues, pftGatherModifiedTime)
      => ComCall(21, this.p, Int32, itemID, UInt32, pValues.Length, PROPERTYKEY.Ptr, pColumns, SEARCH_COLUMN_PROPERTIES.Ptr, pValues, FILETIME.Ptr, pftGatherModifiedTime)
    put_QueryMaxResults(cMaxResults)
      => ComCall(22, this.p, Int32, cMaxResults)
    get_QueryMaxResults(pcMaxResults)
      => ComCall(23, this.p, Int32.Ptr, pcMaxResults)
}
struct PRIORITY_LEVEL extends Int32 {
    static PRIORITY_LEVEL_FOREGROUND := 0
    static PRIORITY_LEVEL_HIGH := 1
    static PRIORITY_LEVEL_LOW := 2
    static PRIORITY_LEVEL_DEFAULT := 3
}
struct IRowsetPrioritization extends IUnknown {
    static IID := "{42811652-079D-481B-87A2-09A69ECC5F44}"
    SetScopePriority(priority, scopeStatisticsEventFrequency)
      => ComCall(3, this.p, PRIORITY_LEVEL, priority, UInt32, scopeStatisticsEventFrequency)
    GetScopePriority(priority, scopeStatisticsEventFrequency)
      => ComCall(4, this.p, PRIORITY_LEVEL.Ptr, priority, UInt32.Ptr, scopeStatisticsEventFrequency)
    GetScopeStatistics(indexedDocumentCount, oustandingAddCount, oustandingModifyCount)
      => ComCall(5, this.p, UInt32.Ptr, indexedDocumentCount, UInt32.Ptr, oustandingAddCount, UInt32.Ptr, oustandingModifyCount)
}
struct ROWSETEVENT_ITEMSTATE extends Int32 {
    static ROWSETEVENT_ITEMSTATE_NOTINROWSET := 0
    static ROWSETEVENT_ITEMSTATE_INROWSET := 1
    static ROWSETEVENT_ITEMSTATE_UNKNOWN := 2
}
struct ROWSETEVENT_TYPE extends Int32 {
    static ROWSETEVENT_TYPE_DATAEXPIRED := 0
    static ROWSETEVENT_TYPE_FOREGROUNDLOST := 1
    static ROWSETEVENT_TYPE_SCOPESTATISTICS := 2
}
struct IRowsetEvents extends IUnknown {
    static IID := "{1551AEA5-5D66-4B11-86F5-D5634CB211B9}"
    OnNewItem(itemID, newItemState)
      => ComCall(3, this.p, PROPVARIANT.Ptr, itemID, ROWSETEVENT_ITEMSTATE, newItemState)
    OnChangedItem(itemID, rowsetItemState, changedItemState)
      => ComCall(4, this.p, PROPVARIANT.Ptr, itemID, ROWSETEVENT_ITEMSTATE, rowsetItemState, ROWSETEVENT_ITEMSTATE, changedItemState)
    OnDeletedItem(itemID, deletedItemState)
      => ComCall(5, this.p, PROPVARIANT.Ptr, itemID, ROWSETEVENT_ITEMSTATE, deletedItemState)
    OnRowsetEvent(eventType, eventData)
      => ComCall(6, this.p, ROWSETEVENT_TYPE, eventType, PROPVARIANT.Ptr, eventData)
}
struct ISearchManager extends IUnknown {
    static IID := "{AB310581-AC80-11D1-8DF3-00C04FB6EF69}"
    GetIndexerVersionStr(ppszVersionString)
      => ComCall(3, this.p, PWSTR.Ptr, ppszVersionString)
    GetIndexerVersion(pdwMajor, pdwMinor)
      => ComCall(4, this.p, UInt32.Ptr, pdwMajor, UInt32.Ptr, pdwMinor)
    GetParameter(pszName, ppValue)
      => ComCall(5, this.p, "Str", pszName, PROPVARIANT.Ptr.Ptr, ppValue)
    SetParameter(pszName, pValue)
      => ComCall(6, this.p, "Str", pszName, PROPVARIANT.Ptr, pValue)
    get_ProxyName(ppszProxyName)
      => ComCall(7, this.p, PWSTR.Ptr, ppszProxyName)
    get_BypassList(ppszBypassList)
      => ComCall(8, this.p, PWSTR.Ptr, ppszBypassList)
    SetProxy(sUseProxy, fLocalByPassProxy, dwPortNumber, pszProxyName, pszByPassList)
      => ComCall(9, this.p, PROXY_ACCESS, sUseProxy, BOOL, fLocalByPassProxy, UInt32, dwPortNumber, "Str", pszProxyName, "Str", pszByPassList)
    GetCatalog(pszCatalog, ppCatalogManager)
      => ComCall(10, this.p, "Str", pszCatalog, ISearchCatalogManager.Ptr, ppCatalogManager)
    get_UserAgent(ppszUserAgent)
      => ComCall(11, this.p, PWSTR.Ptr, ppszUserAgent)
    put_UserAgent(pszUserAgent)
      => ComCall(12, this.p, "Str", pszUserAgent)
    get_UseProxy(pUseProxy)
      => ComCall(13, this.p, PROXY_ACCESS.Ptr, pUseProxy)
    get_LocalBypass(pfLocalBypass)
      => ComCall(14, this.p, BOOL.Ptr, pfLocalBypass)
    get_PortNumber(pdwPortNumber)
      => ComCall(15, this.p, UInt32.Ptr, pdwPortNumber)
}
struct ISearchManager2 extends ISearchManager {
    static IID := "{DBAB3F73-DB19-4A79-BFC0-A61A93886DDF}"
    CreateCatalog(pszCatalog, ppCatalogManager)
      => ComCall(16, this.p, "Str", pszCatalog, ISearchCatalogManager.Ptr, ppCatalogManager)
    DeleteCatalog(pszCatalog)
      => ComCall(17, this.p, "Str", pszCatalog)
}
struct ISearchLanguageSupport extends IUnknown {
    static IID := "{24C3CBAA-EBC1-491A-9EF1-9F6D8DEB1B8F}"
    SetDiacriticSensitivity(fDiacriticSensitive)
      => ComCall(3, this.p, BOOL, fDiacriticSensitive)
    GetDiacriticSensitivity(pfDiacriticSensitive)
      => ComCall(4, this.p, BOOL.Ptr, pfDiacriticSensitive)
    LoadWordBreaker(lcid, riid, ppWordBreaker, pLcidUsed)
      => ComCall(5, this.p, UInt32, lcid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppWordBreaker, UInt32.Ptr, pLcidUsed)
    LoadStemmer(lcid, riid, ppStemmer, pLcidUsed)
      => ComCall(6, this.p, UInt32, lcid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppStemmer, UInt32.Ptr, pLcidUsed)
    IsPrefixNormalized(pwcsQueryToken, pwcsDocumentToken, pulPrefixLength)
      => ComCall(7, this.p, "Str", pwcsQueryToken, UInt32, pwcsQueryToken.Length, "Str", pwcsDocumentToken, UInt32, pwcsDocumentToken.Length, UInt32.Ptr, pulPrefixLength)
}
struct ITEMPROP {
    variantValue : VARIANT
    pwszName : PWSTR
}
struct IEnumItemProperties extends IUnknown {
    static IID := "{F72C8D96-6DBD-11D1-A1E8-00C04FC2FBE1}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ITEMPROP.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumItemProperties.Ptr, ppenum)
    GetCount(pnCount)
      => ComCall(7, this.p, UInt32.Ptr, pnCount)
}
struct SUBSCRIPTIONITEMINFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwPriority : UInt32
    ScheduleGroup : GUID
    clsidAgent : GUID
}
struct ISubscriptionItem extends IUnknown {
    static IID := "{A97559F8-6C4A-11D1-A1E8-00C04FC2FBE1}"
    GetCookie(pCookie)
      => ComCall(3, this.p, GUID.Ptr, pCookie)
    GetSubscriptionItemInfo(pSubscriptionItemInfo)
      => ComCall(4, this.p, SUBSCRIPTIONITEMINFO.Ptr, pSubscriptionItemInfo)
    SetSubscriptionItemInfo(pSubscriptionItemInfo)
      => ComCall(5, this.p, SUBSCRIPTIONITEMINFO.Ptr, pSubscriptionItemInfo)
    ReadProperties(rgwszName, rgValue)
      => ComCall(6, this.p, UInt32, rgValue.Length, PWSTR.Ptr, rgwszName, VARIANT.Ptr, rgValue)
    WriteProperties(rgwszName, rgValue)
      => ComCall(7, this.p, UInt32, rgValue.Length, PWSTR.Ptr, rgwszName, VARIANT.Ptr, rgValue)
    EnumProperties(ppEnumItemProperties)
      => ComCall(8, this.p, IEnumItemProperties.Ptr, ppEnumItemProperties)
    NotifyChanged()
      => ComCall(9, this.p)
}
struct IEnumSubscription extends IUnknown {
    static IID := "{F72C8D97-6DBD-11D1-A1E8-00C04FC2FBE1}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, GUID.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSubscription.Ptr, ppenum)
    GetCount(pnCount)
      => ComCall(7, this.p, UInt32.Ptr, pnCount)
}
struct SUBSCRIPTIONTYPE extends Int32 {
    static SUBSTYPE_URL := 0
    static SUBSTYPE_CHANNEL := 1
    static SUBSTYPE_DESKTOPURL := 2
    static SUBSTYPE_EXTERNAL := 3
    static SUBSTYPE_DESKTOPCHANNEL := 4
}
struct SUBSCRIPTIONINFOFLAGS extends Int32 {
    static SUBSINFO_SCHEDULE := 1
    static SUBSINFO_RECURSE := 2
    static SUBSINFO_WEBCRAWL := 4
    static SUBSINFO_MAILNOT := 8
    static SUBSINFO_MAXSIZEKB := 16
    static SUBSINFO_USER := 32
    static SUBSINFO_PASSWORD := 64
    static SUBSINFO_TASKFLAGS := 256
    static SUBSINFO_GLEAM := 512
    static SUBSINFO_CHANGESONLY := 1024
    static SUBSINFO_CHANNELFLAGS := 2048
    static SUBSINFO_FRIENDLYNAME := 8192
    static SUBSINFO_NEEDPASSWORD := 16384
    static SUBSINFO_TYPE := 32768
}
struct CREATESUBSCRIPTIONFLAGS extends Int32 {
    static CREATESUBS_ADDTOFAVORITES := 1
    static CREATESUBS_FROMFAVORITES := 2
    static CREATESUBS_NOUI := 4
    static CREATESUBS_NOSAVE := 8
    static CREATESUBS_SOFTWAREUPDATE := 16
}
struct SUBSCRIPTIONSCHEDULE extends Int32 {
    static SUBSSCHED_AUTO := 0
    static SUBSSCHED_DAILY := 1
    static SUBSSCHED_WEEKLY := 2
    static SUBSSCHED_CUSTOM := 3
    static SUBSSCHED_MANUAL := 4
}
struct SUBSCRIPTIONINFO {
    cbSize : UInt32 := this.Size
    fUpdateFlags : UInt32
    schedule : SUBSCRIPTIONSCHEDULE
    customGroupCookie : GUID
    pTrigger : Struct.Ptr
    dwRecurseLevels : UInt32
    fWebcrawlerFlags : UInt32
    bMailNotification : BOOL
    bGleam : BOOL
    bChangesOnly : BOOL
    bNeedPassword : BOOL
    fChannelFlags : UInt32
    bstrUserName : BSTR
    bstrPassword : BSTR
    bstrFriendlyName : BSTR
    dwMaxSizeKB : UInt32
    subType : SUBSCRIPTIONTYPE
    fTaskFlags : UInt32
    dwReserved : UInt32
}
struct ISubscriptionMgr extends IUnknown {
    static IID := "{085FB2C0-0DF8-11D1-8F4B-00A0C905413F}"
    DeleteSubscription(pwszURL, hwnd1)
      => ComCall(3, this.p, "Str", pwszURL, HWND, hwnd1)
    UpdateSubscription(pwszURL)
      => ComCall(4, this.p, "Str", pwszURL)
    UpdateAll()
      => ComCall(5, this.p)
    IsSubscribed(pwszURL, pfSubscribed)
      => ComCall(6, this.p, "Str", pwszURL, BOOL.Ptr, pfSubscribed)
    GetSubscriptionInfo(pwszURL, pInfo)
      => ComCall(7, this.p, "Str", pwszURL, SUBSCRIPTIONINFO.Ptr, pInfo)
    GetDefaultInfo(subType, pInfo)
      => ComCall(8, this.p, SUBSCRIPTIONTYPE, subType, SUBSCRIPTIONINFO.Ptr, pInfo)
    ShowSubscriptionProperties(pwszURL, hwnd1)
      => ComCall(9, this.p, "Str", pwszURL, HWND, hwnd1)
    CreateSubscription(hwnd1, pwszURL, pwszFriendlyName, dwFlags, subsType, pInfo)
      => ComCall(10, this.p, HWND, hwnd1, "Str", pwszURL, "Str", pwszFriendlyName, UInt32, dwFlags, SUBSCRIPTIONTYPE, subsType, SUBSCRIPTIONINFO.Ptr, pInfo)
}
struct ISubscriptionMgr2 extends ISubscriptionMgr {
    static IID := "{614BC270-AEDF-11D1-A1F9-00C04FC2FBE1}"
    GetItemFromURL(pwszURL, ppSubscriptionItem)
      => ComCall(11, this.p, "Str", pwszURL, ISubscriptionItem.Ptr, ppSubscriptionItem)
    GetItemFromCookie(pSubscriptionCookie, ppSubscriptionItem)
      => ComCall(12, this.p, GUID.Ptr, pSubscriptionCookie, ISubscriptionItem.Ptr, ppSubscriptionItem)
    GetSubscriptionRunState(pCookies, pdwRunState)
      => ComCall(13, this.p, UInt32, pdwRunState.Length, GUID.Ptr, pCookies, UInt32.Ptr, pdwRunState)
    EnumSubscriptions(dwFlags, ppEnumSubscriptions)
      => ComCall(14, this.p, UInt32, dwFlags, IEnumSubscription.Ptr, ppEnumSubscriptions)
    UpdateItems(dwFlags, pCookies)
      => ComCall(15, this.p, UInt32, dwFlags, UInt32, pCookies.Length, GUID.Ptr, pCookies)
    AbortItems(pCookies)
      => ComCall(16, this.p, UInt32, pCookies.Length, GUID.Ptr, pCookies)
    AbortAll()
      => ComCall(17, this.p)
}
struct DELIVERY_AGENT_FLAGS extends Int32 {
    static DELIVERY_AGENT_FLAG_NO_BROADCAST := 4
    static DELIVERY_AGENT_FLAG_NO_RESTRICTIONS := 8
    static DELIVERY_AGENT_FLAG_SILENT_DIAL := 16
}
struct WEBCRAWL_RECURSEFLAGS extends Int32 {
    static WEBCRAWL_DONT_MAKE_STICKY := 1
    static WEBCRAWL_GET_IMAGES := 2
    static WEBCRAWL_GET_VIDEOS := 4
    static WEBCRAWL_GET_BGSOUNDS := 8
    static WEBCRAWL_GET_CONTROLS := 16
    static WEBCRAWL_LINKS_ELSEWHERE := 32
    static WEBCRAWL_IGNORE_ROBOTSTXT := 128
    static WEBCRAWL_ONLY_LINKS_TO_HTML := 256
}
struct CHANNEL_AGENT_FLAGS extends Int32 {
    static CHANNEL_AGENT_DYNAMIC_SCHEDULE := 1
    static CHANNEL_AGENT_PRECACHE_SOME := 2
    static CHANNEL_AGENT_PRECACHE_ALL := 4
    static CHANNEL_AGENT_PRECACHE_SCRNSAVER := 8
}
struct DBDATACONVERTENUM extends Int32 {
    static DBDATACONVERT_DEFAULT := 0
    static DBDATACONVERT_SETDATABEHAVIOR := 1
    static DBDATACONVERT_LENGTHFROMNTS := 2
    static DBDATACONVERT_DSTISFIXEDLENGTH := 4
    static DBDATACONVERT_DECIMALSCALE := 8
}
struct IDataConvert extends IUnknown {
    static IID := "{0C733A8D-2A1C-11CE-ADE5-00AA0044773D}"
    DataConvert(wSrcType, wDstType, pcbDstLength?, pSrc, pDst, cbDstMaxLength, dbsSrcStatus, pdbsStatus?, bPrecision, bScale, dwFlags)
      => ComCall(3, this.p, UInt16, wSrcType, UInt16, wDstType, IntPtr, pSrc.Size, IntPtr.Ptr, pcbDstLength?, Struct.Ptr, pSrc, Struct.Ptr, pDst, IntPtr, cbDstMaxLength, UInt32, dbsSrcStatus, UInt32.Ptr, pdbsStatus?, UInt8, bPrecision, UInt8, bScale, UInt32, dwFlags)
    CanConvert(wSrcType, wDstType)
      => ComCall(4, this.p, UInt16, wSrcType, UInt16, wDstType)
    GetConversionSize(wSrcType, wDstType, pcbDstLength?, pSrc?)
      => ComCall(5, this.p, UInt16, wSrcType, UInt16, wDstType, IntPtr.Ptr, pSrc?.Size ?? 0, IntPtr.Ptr, pcbDstLength?, Struct.Ptr, pSrc?)
}
struct DCINFOTYPEENUM extends Int32 {
    static DCINFOTYPE_VERSION := 1
}
struct DCINFO {
    eInfoType : UInt32
    vData : VARIANT
}
struct IDCInfo extends IUnknown {
    static IID := "{0C733A9C-2A1C-11CE-ADE5-00AA0044773D}"
    GetInfo(rgeInfoType, prgInfo)
      => ComCall(3, this.p, UInt32, prgInfo.Length, UInt32.Ptr, rgeInfoType, DCINFO.Ptr.Ptr, prgInfo)
    SetInfo(rgInfo)
      => ComCall(4, this.p, UInt32, rgInfo.Length, DCINFO.Ptr, rgInfo)
}
struct DataSourceListener extends IUnknown {
    static IID := "{7C0FFAB2-CD84-11D0-949A-00A0C91110ED}"
    dataMemberChanged(bstrDM)
      => ComCall(3, this.p, UInt16.Ptr, bstrDM)
    dataMemberAdded(bstrDM)
      => ComCall(4, this.p, UInt16.Ptr, bstrDM)
    dataMemberRemoved(bstrDM)
      => ComCall(5, this.p, UInt16.Ptr, bstrDM)
}
struct DataSource extends IUnknown {
    static IID := "{7C0FFAB3-CD84-11D0-949A-00A0C91110ED}"
    getDataMember(bstrDM, riid, ppunk)
      => ComCall(3, this.p, UInt16.Ptr, bstrDM, GUID.Ptr, riid, IUnknown.Ptr, ppunk)
    getDataMemberName(lIndex, pbstrDM)
      => ComCall(4, this.p, Int32, lIndex, UInt16.Ptr.Ptr, pbstrDM)
    getDataMemberCount(plCount)
      => ComCall(5, this.p, Int32.Ptr, plCount)
    addDataSourceListener(pDSL)
      => ComCall(6, this.p, DataSourceListener, pDSL)
    removeDataSourceListener(pDSL)
      => ComCall(7, this.p, DataSourceListener, pDSL)
}
struct OSPFORMAT extends Int32 {
    static OSPFORMAT_RAW := 0
    static OSPFORMAT_DEFAULT := 0
    static OSPFORMAT_FORMATTED := 1
    static OSPFORMAT_HTML := 2
}
struct OSPRW extends Int32 {
    static OSPRW_DEFAULT := 1
    static OSPRW_READONLY := 0
    static OSPRW_READWRITE := 1
    static OSPRW_MIXED := 2
}
struct OSPFIND extends Int32 {
    static OSPFIND_DEFAULT := 0
    static OSPFIND_UP := 1
    static OSPFIND_CASESENSITIVE := 2
    static OSPFIND_UPCASESENSITIVE := 3
}
struct OSPCOMP extends Int32 {
    static OSPCOMP_EQ := 1
    static OSPCOMP_DEFAULT := 1
    static OSPCOMP_LT := 2
    static OSPCOMP_LE := 3
    static OSPCOMP_GE := 4
    static OSPCOMP_GT := 5
    static OSPCOMP_NE := 6
}
struct OSPXFER extends Int32 {
    static OSPXFER_COMPLETE := 0
    static OSPXFER_ABORT := 1
    static OSPXFER_ERROR := 2
}
struct OLEDBSimpleProviderListener extends IUnknown {
    static IID := "{E0E270C1-C0BE-11D0-8FE4-00A0C90A6341}"
    aboutToChangeCell(iRow, iColumn)
      => ComCall(3, this.p, IntPtr, iRow, IntPtr, iColumn)
    cellChanged(iRow, iColumn)
      => ComCall(4, this.p, IntPtr, iRow, IntPtr, iColumn)
    aboutToDeleteRows(iRow, cRows)
      => ComCall(5, this.p, IntPtr, iRow, IntPtr, cRows)
    deletedRows(iRow, cRows)
      => ComCall(6, this.p, IntPtr, iRow, IntPtr, cRows)
    aboutToInsertRows(iRow, cRows)
      => ComCall(7, this.p, IntPtr, iRow, IntPtr, cRows)
    insertedRows(iRow, cRows)
      => ComCall(8, this.p, IntPtr, iRow, IntPtr, cRows)
    rowsAvailable(iRow, cRows)
      => ComCall(9, this.p, IntPtr, iRow, IntPtr, cRows)
    transferComplete(xfer)
      => ComCall(10, this.p, OSPXFER, xfer)
}
struct OLEDBSimpleProvider extends IUnknown {
    static IID := "{E0E270C0-C0BE-11D0-8FE4-00A0C90A6341}"
    getRowCount(pcRows)
      => ComCall(3, this.p, IntPtr.Ptr, pcRows)
    getColumnCount(pcColumns)
      => ComCall(4, this.p, IntPtr.Ptr, pcColumns)
    getRWStatus(iRow, iColumn, prwStatus)
      => ComCall(5, this.p, IntPtr, iRow, IntPtr, iColumn, OSPRW.Ptr, prwStatus)
    getVariant(iRow, iColumn, format, pVar)
      => ComCall(6, this.p, IntPtr, iRow, IntPtr, iColumn, OSPFORMAT, format, VARIANT.Ptr, pVar)
    setVariant(iRow, iColumn, format, Var)
      => ComCall(7, this.p, IntPtr, iRow, IntPtr, iColumn, OSPFORMAT, format, VARIANT, Var)
    getLocale(pbstrLocale)
      => ComCall(8, this.p, BSTR.Ptr, pbstrLocale)
    deleteRows(iRow, cRows, pcRowsDeleted)
      => ComCall(9, this.p, IntPtr, iRow, IntPtr, cRows, IntPtr.Ptr, pcRowsDeleted)
    insertRows(iRow, cRows, pcRowsInserted)
      => ComCall(10, this.p, IntPtr, iRow, IntPtr, cRows, IntPtr.Ptr, pcRowsInserted)
    find(iRowStart, iColumn, val, findFlags, compType, piRowFound)
      => ComCall(11, this.p, IntPtr, iRowStart, IntPtr, iColumn, VARIANT, val, OSPFIND, findFlags, OSPCOMP, compType, IntPtr.Ptr, piRowFound)
    addOLEDBSimpleProviderListener(pospIListener)
      => ComCall(12, this.p, OLEDBSimpleProviderListener, pospIListener)
    removeOLEDBSimpleProviderListener(pospIListener)
      => ComCall(13, this.p, OLEDBSimpleProviderListener, pospIListener)
    isAsync(pbAsynch)
      => ComCall(14, this.p, BOOL.Ptr, pbAsynch)
    getEstimatedRows(piRows)
      => ComCall(15, this.p, IntPtr.Ptr, piRows)
    stopTransfer()
      => ComCall(16, this.p)
}
struct DataSourceObject extends IDispatch {
    static IID := "{0AE9A4E4-18D4-11D1-B3B3-00AA00C1A924}"
}
struct EBindInfoOptions extends Int32 {
    static BIO_BINDER := 1
}
struct IService extends IUnknown {
    static IID := "{06210E88-01F5-11D1-B512-0080C781C384}"
    InvokeService(pUnkInner)
      => ComCall(3, this.p, IUnknown, pUnkInner)
}
struct DBPROMPTOPTIONSENUM extends Int32 {
    static DBPROMPTOPTIONS_NONE := 0
    static DBPROMPTOPTIONS_WIZARDSHEET := 1
    static DBPROMPTOPTIONS_PROPERTYSHEET := 2
    static DBPROMPTOPTIONS_BROWSEONLY := 8
    static DBPROMPTOPTIONS_DISABLE_PROVIDER_SELECTION := 16
    static DBPROMPTOPTIONS_DISABLESAVEPASSWORD := 32
}
struct IDBPromptInitialize extends IUnknown {
    static IID := "{2206CCB0-19C1-11D1-89E0-00C04FD7A829}"
    PromptDataSource(pUnkOuter?, hWndParent, dwPromptOptions, rgSourceTypeFilter?, pwszszzProviderFilter?, riid, ppDataSource)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, HWND, hWndParent, UInt32, dwPromptOptions, UInt32, rgSourceTypeFilter?.Length ?? 0, UInt32.Ptr, rgSourceTypeFilter?, "Str", pwszszzProviderFilter?, GUID.Ptr, riid, IUnknown.Ptr, ppDataSource)
    PromptFileName(hWndParent, dwPromptOptions, pwszInitialDirectory, pwszInitialFile, ppwszSelectedFile)
      => ComCall(4, this.p, HWND, hWndParent, UInt32, dwPromptOptions, "Str", pwszInitialDirectory, "Str", pwszInitialFile, PWSTR.Ptr, ppwszSelectedFile)
}
struct IDataInitialize extends IUnknown {
    static IID := "{2206CCB1-19C1-11D1-89E0-00C04FD7A829}"
    GetDataSource(pUnkOuter?, dwClsCtx, pwszInitializationString?, riid, ppDataSource)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, UInt32, dwClsCtx, "Str", pwszInitializationString?, GUID.Ptr, riid, IUnknown.Ptr, ppDataSource)
    GetInitializationString(pDataSource?, fIncludePassword, ppwszInitString)
      => ComCall(4, this.p, IUnknown, pDataSource?, UInt8, fIncludePassword, PWSTR.Ptr, ppwszInitString)
    CreateDBInstance(clsidProvider, pUnkOuter?, dwClsCtx, pwszReserved?, riid, ppDataSource)
      => ComCall(5, this.p, GUID.Ptr, clsidProvider, IUnknown, pUnkOuter?, UInt32, dwClsCtx, "Str", pwszReserved?, GUID.Ptr, riid, IUnknown.Ptr, ppDataSource)
    CreateDBInstanceEx(clsidProvider, pUnkOuter?, dwClsCtx, pwszReserved?, pServerInfo, rgmqResults)
      => ComCall(6, this.p, GUID.Ptr, clsidProvider, IUnknown, pUnkOuter?, UInt32, dwClsCtx, "Str", pwszReserved?, COSERVERINFO.Ptr, pServerInfo, UInt32, rgmqResults.Length, MULTI_QI.Ptr, rgmqResults)
    LoadStringFromStorage(pwszFileName?, ppwszInitializationString)
      => ComCall(7, this.p, "Str", pwszFileName?, PWSTR.Ptr, ppwszInitializationString)
    WriteStringToStorage(pwszFileName?, pwszInitializationString?, dwCreationDisposition)
      => ComCall(8, this.p, "Str", pwszFileName?, "Str", pwszInitializationString?, UInt32, dwCreationDisposition)
}
struct IDataSourceLocator extends IDispatch {
    static IID := "{2206CCB2-19C1-11D1-89E0-00C04FD7A829}"
    get_hWnd(phwndParent)
      => ComCall(7, this.p, HWND.Ptr, phwndParent)
    put_hWnd(hwndParent)
      => ComCall(8, this.p, HWND, hwndParent)
    PromptNew(ppADOConnection)
      => ComCall(9, this.p, IDispatch.Ptr, ppADOConnection)
    PromptEdit(ppADOConnection, pbSuccess)
      => ComCall(10, this.p, IDispatch.Ptr, ppADOConnection, VARIANT_BOOL.Ptr, pbSuccess)
}
struct KAGREQDIAGFLAGSENUM extends Int32 {
    static KAGREQDIAGFLAGS_HEADER := 1
    static KAGREQDIAGFLAGS_RECORD := 2
}
struct IRowsetChangeExtInfo extends IUnknown {
    static IID := "{0C733A8F-2A1C-11CE-ADE5-00AA0044773D}"
    GetOriginalRow(hReserved, hRow, phRowOriginal)
      => ComCall(3, this.p, IntPtr, hReserved, IntPtr, hRow, IntPtr.Ptr, phRowOriginal)
    GetPendingColumns(hReserved, hRow, cColumnOrdinals, rgiOrdinals, rgColumnStatus)
      => ComCall(4, this.p, IntPtr, hReserved, IntPtr, hRow, UInt32, cColumnOrdinals, UInt32.Ptr, rgiOrdinals, UInt32.Ptr, rgColumnStatus)
}
struct KAGREQDIAG {
    ulDiagFlags : UInt32
    vt : VARENUM
    sDiagField : Int16
}
struct KAGGETDIAG {
    ulSize : UInt32
    vDiagInfo : VARIANT
    sDiagField : Int16
}
struct ISQLRequestDiagFields extends IUnknown {
    static IID := "{228972F0-B5FF-11D0-8A80-00C04FD611CD}"
    RequestDiagFields(rgDiagFields)
      => ComCall(3, this.p, UInt32, rgDiagFields.Length, KAGREQDIAG.Ptr, rgDiagFields)
}
struct ISQLGetDiagField extends IUnknown {
    static IID := "{228972F1-B5FF-11D0-8A80-00C04FD611CD}"
    GetDiagField(pDiagInfo?)
      => ComCall(3, this.p, KAGGETDIAG.Ptr, pDiagInfo?)
}
struct MSDSDBINITPROPENUM extends Int32 {
    static DBPROP_MSDS_DBINIT_DATAPROVIDER := 2
}
struct MSDSSESSIONPROPENUM extends Int32 {
    static DBPROP_MSDS_SESS_UNIQUENAMES := 2
}
struct DATE_STRUCT {
    year : Int16
    month : UInt16
    day : UInt16
}
struct TIME_STRUCT {
    hour : UInt16
    minute : UInt16
    second : UInt16
}
struct TIMESTAMP_STRUCT {
    year : Int16
    month : UInt16
    day : UInt16
    hour : UInt16
    minute : UInt16
    second : UInt16
    fraction : UInt32
}
struct SQLINTERVAL extends Int32 {
    static SQL_IS_YEAR := 1
    static SQL_IS_MONTH := 2
    static SQL_IS_DAY := 3
    static SQL_IS_HOUR := 4
    static SQL_IS_MINUTE := 5
    static SQL_IS_SECOND := 6
    static SQL_IS_YEAR_TO_MONTH := 7
    static SQL_IS_DAY_TO_HOUR := 8
    static SQL_IS_DAY_TO_MINUTE := 9
    static SQL_IS_DAY_TO_SECOND := 10
    static SQL_IS_HOUR_TO_MINUTE := 11
    static SQL_IS_HOUR_TO_SECOND := 12
    static SQL_IS_MINUTE_TO_SECOND := 13
}
struct SQL_YEAR_MONTH_STRUCT {
    year : UInt32
    month : UInt32
}
struct SQL_DAY_SECOND_STRUCT {
    day : UInt32
    hour : UInt32
    minute : UInt32
    second : UInt32
    fraction : UInt32
}
struct SQL_INTERVAL_STRUCT {
    interval_type : SQLINTERVAL
    interval_sign : Int16
    intval : this._intval_e__Union
    struct _intval_e__Union {
        union {
            year_month : SQL_YEAR_MONTH_STRUCT
            day_second : SQL_DAY_SECOND_STRUCT
        }
    }
}
struct SQL_NUMERIC_STRUCT {
    precision : UInt8
    scale : Int8
    sign : UInt8
    val : UInt8[16]
}
struct DBVARYCHAR {
    len : Int16
    str : Int8[8001]
}
struct DBVARYBIN {
    len : Int16
    array : UInt8[8001]
}
struct DBMONEY {
    mnyhigh : Int32
    mnylow : UInt32
}
struct DBDATETIME {
    dtdays : Int32
    dttime : UInt32
}
struct DBDATETIM4 {
    numdays : UInt16
    nummins : UInt16
}
struct SQLPERF {
    TimerResolution : UInt32
    SQLidu : UInt32
    SQLiduRows : UInt32
    SQLSelects : UInt32
    SQLSelectRows : UInt32
    Transactions : UInt32
    SQLPrepares : UInt32
    ExecDirects : UInt32
    SQLExecutes : UInt32
    CursorOpens : UInt32
    CursorSize : UInt32
    CursorUsed : UInt32
    PercentCursorUsed : Float64
    AvgFetchTime : Float64
    AvgCursorSize : Float64
    AvgCursorUsed : Float64
    SQLFetchTime : UInt32
    SQLFetchCount : UInt32
    CurrentStmtCount : UInt32
    MaxOpenStmt : UInt32
    SumOpenStmt : UInt32
    CurrentConnectionCount : UInt32
    MaxConnectionsOpened : UInt32
    SumConnectionsOpened : UInt32
    SumConnectiontime : UInt32
    AvgTimeOpened : Float64
    ServerRndTrips : UInt32
    BuffersSent : UInt32
    BuffersRec : UInt32
    BytesSent : UInt32
    BytesRec : UInt32
    msExecutionTime : UInt32
    msNetWorkServerTime : UInt32
}
struct DBPROPENUM25_DEPRECATED extends Int32 {
    static DBPROP_ICommandCost := 141
    static DBPROP_ICommandTree := 142
    static DBPROP_ICommandValidate := 143
    static DBPROP_IDBSchemaCommand := 144
    static DBPROP_IProvideMoniker := 125
    static DBPROP_IQuery := 146
    static DBPROP_IReadData := 147
    static DBPROP_IRowsetAsynch := 148
    static DBPROP_IRowsetCopyRows := 149
    static DBPROP_IRowsetKeys := 151
    static DBPROP_IRowsetNewRowAfter := 152
    static DBPROP_IRowsetNextRowset := 153
    static DBPROP_IRowsetWatchAll := 155
    static DBPROP_IRowsetWatchNotify := 156
    static DBPROP_IRowsetWatchRegion := 157
    static DBPROP_IRowsetWithParameters := 158
}
struct DBREASONENUM25 extends Int32 {
    static DBREASON_ROWSET_ROWSADDED := 19
    static DBREASON_ROWSET_POPULATIONCOMPLETE := 20
    static DBREASON_ROWSET_POPULATIONSTOPPED := 21
}
struct IRowsetNextRowset extends IUnknown {
    static IID := "{0C733A72-2A1C-11CE-ADE5-00AA0044773D}"
    GetNextRowset(pUnkOuter, riid, ppNextRowset)
      => ComCall(3, this.p, IUnknown, pUnkOuter, GUID.Ptr, riid, IUnknown.Ptr, ppNextRowset)
}
struct IRowsetNewRowAfter extends IUnknown {
    static IID := "{0C733A71-2A1C-11CE-ADE5-00AA0044773D}"
    SetNewDataAfter(hChapter, pbmPrevious, hAccessor1, pData, phRow)
      => ComCall(3, this.p, IntPtr, hChapter, UInt32, pbmPrevious.Length, UInt8.Ptr, pbmPrevious, HACCESSOR, hAccessor1, UInt8.Ptr, pData, IntPtr.Ptr, phRow)
}
struct IRowsetWithParameters extends IUnknown {
    static IID := "{0C733A6E-2A1C-11CE-ADE5-00AA0044773D}"
    GetParameterInfo(prgParamInfo, ppNamesBuffer)
      => ComCall(3, this.p, IntPtr.Ptr, prgParamInfo.Length, DBPARAMINFO.Ptr.Ptr, prgParamInfo, UInt16.Ptr.Ptr, ppNamesBuffer)
    Requery(pParams, pulErrorParam, phReserved)
      => ComCall(4, this.p, DBPARAMS.Ptr, pParams, UInt32.Ptr, pulErrorParam, IntPtr.Ptr, phReserved)
}
struct IRowsetAsynch extends IUnknown {
    static IID := "{0C733A0F-2A1C-11CE-ADE5-00AA0044773D}"
    RatioFinished(pulDenominator, pulNumerator, pcRows, pfNewRows)
      => ComCall(3, this.p, IntPtr.Ptr, pulDenominator, IntPtr.Ptr, pulNumerator, IntPtr.Ptr, pcRows, BOOL.Ptr, pfNewRows)
    Stop()
      => ComCall(4, this.p)
}
struct IRowsetKeys extends IUnknown {
    static IID := "{0C733A12-2A1C-11CE-ADE5-00AA0044773D}"
    ListKeys(prgColumns)
      => ComCall(3, this.p, IntPtr.Ptr, prgColumns.Length, IntPtr.Ptr.Ptr, prgColumns)
}
struct IRowsetWatchAll extends IUnknown {
    static IID := "{0C733A73-2A1C-11CE-ADE5-00AA0044773D}"
    Acknowledge()
      => ComCall(3, this.p)
    Start()
      => ComCall(4, this.p)
    StopWatching()
      => ComCall(5, this.p)
}
struct DBWATCHNOTIFYENUM extends Int32 {
    static DBWATCHNOTIFY_ROWSCHANGED := 1
    static DBWATCHNOTIFY_QUERYDONE := 2
    static DBWATCHNOTIFY_QUERYREEXECUTED := 3
}
struct IRowsetWatchNotify extends IUnknown {
    static IID := "{0C733A44-2A1C-11CE-ADE5-00AA0044773D}"
    OnChange(pRowset, eChangeReason)
      => ComCall(3, this.p, IRowset, pRowset, UInt32, eChangeReason)
}
struct DBWATCHMODEENUM extends Int32 {
    static DBWATCHMODE_ALL := 1
    static DBWATCHMODE_EXTEND := 2
    static DBWATCHMODE_MOVE := 4
    static DBWATCHMODE_COUNT := 8
}
struct DBROWCHANGEKINDENUM extends Int32 {
    static DBROWCHANGEKIND_INSERT := 0
    static DBROWCHANGEKIND_DELETE := 1
    static DBROWCHANGEKIND_UPDATE := 2
    static DBROWCHANGEKIND_COUNT := 3
}
struct IRowsetWatchRegion extends IRowsetWatchAll {
    static IID := "{0C733A45-2A1C-11CE-ADE5-00AA0044773D}"
    CreateWatchRegion(dwWatchMode, phRegion)
      => ComCall(6, this.p, UInt32, dwWatchMode, IntPtr.Ptr, phRegion)
    ChangeWatchMode(hRegion, dwWatchMode)
      => ComCall(7, this.p, IntPtr, hRegion, UInt32, dwWatchMode)
    DeleteWatchRegion(hRegion)
      => ComCall(8, this.p, IntPtr, hRegion)
    GetWatchRegionInfo(hRegion, pdwWatchMode, phChapter, ppBookmark, pcRows)
      => ComCall(9, this.p, IntPtr, hRegion, UInt32.Ptr, pdwWatchMode, IntPtr.Ptr, phChapter, IntPtr.Ptr, ppBookmark.Length, UInt8.Ptr.Ptr, ppBookmark, IntPtr.Ptr, pcRows)
    Refresh(prgChanges)
      => ComCall(10, this.p, IntPtr.Ptr, prgChanges.Length, DBROWWATCHCHANGE.Ptr.Ptr, prgChanges)
    ShrinkWatchRegion(hRegion, hChapter, pBookmark, cRows)
      => ComCall(11, this.p, IntPtr, hRegion, IntPtr, hChapter, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr, cRows)
}
struct IRowsetCopyRows extends IUnknown {
    static IID := "{0C733A6B-2A1C-11CE-ADE5-00AA0044773D}"
    CloseSource(hSourceID)
      => ComCall(3, this.p, UInt16, hSourceID)
    CopyByHROWS(hSourceID, hReserved, rghRows, bFlags)
      => ComCall(4, this.p, UInt16, hSourceID, IntPtr, hReserved, IntPtr, rghRows.Length, IntPtr.Ptr, rghRows, UInt32, bFlags)
    CopyRows(hSourceID, hReserved, cRows, bFlags, pcRowsCopied)
      => ComCall(5, this.p, UInt16, hSourceID, IntPtr, hReserved, IntPtr, cRows, UInt32, bFlags, IntPtr.Ptr, pcRowsCopied)
    DefineSource(pRowsetSource, rgSourceColumns, rgTargetColumns, phSourceID)
      => ComCall(6, this.p, IRowset, pRowsetSource, IntPtr, rgTargetColumns.Length, IntPtr.Ptr, rgSourceColumns, IntPtr.Ptr, rgTargetColumns, UInt16.Ptr, phSourceID)
}
struct IReadData extends IUnknown {
    static IID := "{0C733A6A-2A1C-11CE-ADE5-00AA0044773D}"
    ReadData(hChapter, pBookmark, lRowsOffset, hAccessor1, cRows, pcRowsObtained, ppFixedData, pcbVariableTotal, ppVariableData)
      => ComCall(3, this.p, IntPtr, hChapter, IntPtr, pBookmark.Length, UInt8.Ptr, pBookmark, IntPtr, lRowsOffset, HACCESSOR, hAccessor1, IntPtr, cRows, IntPtr.Ptr, pcRowsObtained, UInt8.Ptr.Ptr, ppFixedData, IntPtr.Ptr, pcbVariableTotal, UInt8.Ptr.Ptr, ppVariableData)
    ReleaseChapter(hChapter)
      => ComCall(4, this.p, IntPtr, hChapter)
}
struct DBRESOURCEKINDENUM extends Int32 {
    static DBRESOURCE_INVALID := 0
    static DBRESOURCE_TOTAL := 1
    static DBRESOURCE_CPU := 2
    static DBRESOURCE_MEMORY := 3
    static DBRESOURCE_DISK := 4
    static DBRESOURCE_NETWORK := 5
    static DBRESOURCE_RESPONSE := 6
    static DBRESOURCE_ROWS := 7
    static DBRESOURCE_OTHER := 8
}
struct DBCOSTUNITENUM extends Int32 {
    static DBUNIT_INVALID := 0
    static DBUNIT_WEIGHT := 1
    static DBUNIT_PERCENT := 2
    static DBUNIT_MAXIMUM := 4
    static DBUNIT_MINIMUM := 8
    static DBUNIT_MICRO_SECOND := 16
    static DBUNIT_MILLI_SECOND := 32
    static DBUNIT_SECOND := 64
    static DBUNIT_MINUTE := 128
    static DBUNIT_HOUR := 256
    static DBUNIT_BYTE := 512
    static DBUNIT_KILO_BYTE := 1024
    static DBUNIT_MEGA_BYTE := 2048
    static DBUNIT_GIGA_BYTE := 4096
    static DBUNIT_NUM_MSGS := 8192
    static DBUNIT_NUM_LOCKS := 16384
    static DBUNIT_NUM_ROWS := 32768
    static DBUNIT_OTHER := 65536
}
struct DBEXECLIMITSENUM extends Int32 {
    static DBEXECLIMITS_ABORT := 1
    static DBEXECLIMITS_STOP := 2
    static DBEXECLIMITS_SUSPEND := 3
}
struct ICommandCost extends IUnknown {
    static IID := "{0C733A4E-2A1C-11CE-ADE5-00AA0044773D}"
    GetAccumulatedCost(pwszRowsetName, prgCostLimits)
      => ComCall(3, this.p, "Str", pwszRowsetName, UInt32.Ptr, prgCostLimits.Length, DBCOST.Ptr.Ptr, prgCostLimits)
    GetCostEstimate(pwszRowsetName, pcCostEstimates, prgCostEstimates)
      => ComCall(4, this.p, "Str", pwszRowsetName, UInt32.Ptr, pcCostEstimates, DBCOST.Ptr, prgCostEstimates)
    GetCostGoals(pwszRowsetName, pcCostGoals, prgCostGoals)
      => ComCall(5, this.p, "Str", pwszRowsetName, UInt32.Ptr, pcCostGoals, DBCOST.Ptr, prgCostGoals)
    GetCostLimits(pwszRowsetName, pcCostLimits, prgCostLimits)
      => ComCall(6, this.p, "Str", pwszRowsetName, UInt32.Ptr, pcCostLimits, DBCOST.Ptr, prgCostLimits)
    SetCostGoals(pwszRowsetName, rgCostGoals)
      => ComCall(7, this.p, "Str", pwszRowsetName, UInt32, rgCostGoals.Length, DBCOST.Ptr, rgCostGoals)
    SetCostLimits(pwszRowsetName, cCostLimits, prgCostLimits, dwExecutionFlags)
      => ComCall(8, this.p, "Str", pwszRowsetName, UInt32, cCostLimits, DBCOST.Ptr, prgCostLimits, UInt32, dwExecutionFlags)
}
struct ICommandValidate extends IUnknown {
    static IID := "{0C733A18-2A1C-11CE-ADE5-00AA0044773D}"
    ValidateCompletely()
      => ComCall(3, this.p)
    ValidateSyntax()
      => ComCall(4, this.p)
}
struct ITableRename extends IUnknown {
    static IID := "{0C733A77-2A1C-11CE-ADE5-00AA0044773D}"
    RenameColumn(pTableId, pOldColumnId, pNewColumnId)
      => ComCall(3, this.p, DBID.Ptr, pTableId, DBID.Ptr, pOldColumnId, DBID.Ptr, pNewColumnId)
    RenameTable(pOldTableId, pOldIndexId, pNewTableId, pNewIndexId)
      => ComCall(4, this.p, DBID.Ptr, pOldTableId, DBID.Ptr, pOldIndexId, DBID.Ptr, pNewTableId, DBID.Ptr, pNewIndexId)
}
struct IDBSchemaCommand extends IUnknown {
    static IID := "{0C733A50-2A1C-11CE-ADE5-00AA0044773D}"
    GetCommand(pUnkOuter, rguidSchema, ppCommand)
      => ComCall(3, this.p, IUnknown, pUnkOuter, GUID.Ptr, rguidSchema, ICommand.Ptr, ppCommand)
    GetSchemas(prgSchemas)
      => ComCall(4, this.p, UInt32.Ptr, prgSchemas.Length, GUID.Ptr.Ptr, prgSchemas)
}
struct IProvideMoniker extends IUnknown {
    static IID := "{0C733A4D-2A1C-11CE-ADE5-00AA0044773D}"
    GetMoniker(ppIMoniker)
      => ComCall(3, this.p, IMoniker.Ptr, ppIMoniker)
}
struct NOTRESTRICTION {
    pRes : RESTRICTION.Ptr
}
struct NODERESTRICTION {
    cRes : UInt32
    paRes : RESTRICTION.Ptr.Ptr
    reserved : UInt32
}
struct VECTORRESTRICTION {
    Node : NODERESTRICTION
    RankMethod : UInt32
}
struct CONTENTRESTRICTION {
    prop : FULLPROPSPEC
    pwcsPhrase : PWSTR
    lcid : UInt32
    ulGenerateMethod : UInt32
}
struct NATLANGUAGERESTRICTION {
    prop : FULLPROPSPEC
    pwcsPhrase : PWSTR
    lcid : UInt32
}
struct PROPERTYRESTRICTION {
    rel : UInt32
    prop : FULLPROPSPEC
    prval : PROPVARIANT
}
struct RESTRICTION {
    rt : UInt32
    weight : UInt32
    res : this._URes
    struct _URes {
        union {
            ar : NODERESTRICTION
            orRestriction : NODERESTRICTION
            pxr : NODERESTRICTION
            vr : VECTORRESTRICTION
            nr : NOTRESTRICTION
            cr : CONTENTRESTRICTION
            nlr : NATLANGUAGERESTRICTION
            pr : PROPERTYRESTRICTION
        }
    }
}
struct COLUMNSET {
    cCol : UInt32
    aCol : FULLPROPSPEC.Ptr
}
struct SORTKEY {
    propColumn : FULLPROPSPEC
    dwOrder : UInt32
    locale : UInt32
}
struct SORTSET {
    cCol : UInt32
    aCol : SORTKEY.Ptr
}
struct BUCKETCATEGORIZE {
    cBuckets : UInt32
    Distribution : UInt32
}
struct RANGECATEGORIZE {
    cRange : UInt32
    aRangeBegin : PROPVARIANT.Ptr
}
struct CATEGORIZATION {
    ulCatType : UInt32
    Anonymous : this._Anonymous_e__Union
    csColumns : COLUMNSET
    struct _Anonymous_e__Union {
        union {
            cClusters : UInt32
            bucket : BUCKETCATEGORIZE
            range : RANGECATEGORIZE
        }
    }
}
struct CATEGORIZATIONSET {
    cCat : UInt32
    aCat : CATEGORIZATION.Ptr
}
struct ISearchQueryHits extends IUnknown {
    static IID := "{ED8CE7E0-106C-11CE-84E2-00AA004B9986}"
    Init(pflt, ulFlags)
      => ComCall(3, this.p, IFilter, pflt, UInt32, ulFlags, Int32)
    NextHitMoniker(pcMnk, papMnk)
      => ComCall(4, this.p, UInt32.Ptr, pcMnk, IMoniker.Ptr.Ptr, papMnk, Int32)
    NextHitOffset(pcRegion, paRegion)
      => ComCall(5, this.p, UInt32.Ptr, pcRegion, FILTERREGION.Ptr.Ptr, paRegion, Int32)
}
struct IRowsetQueryStatus extends IUnknown {
    static IID := "{A7AC77ED-F8D7-11CE-A798-0020F8008024}"
    GetStatus(pdwStatus)
      => ComCall(3, this.p, UInt32.Ptr, pdwStatus)
    GetStatusEx(pdwStatus, pcFilteredDocuments, pcDocumentsToFilter, pdwRatioFinishedDenominator, pdwRatioFinishedNumerator, cbBmk, pBmk, piRowBmk, pcRowsTotal)
      => ComCall(4, this.p, UInt32.Ptr, pdwStatus, UInt32.Ptr, pcFilteredDocuments, UInt32.Ptr, pcDocumentsToFilter, IntPtr.Ptr, pdwRatioFinishedDenominator, IntPtr.Ptr, pdwRatioFinishedNumerator, IntPtr, cbBmk, UInt8.Ptr, pBmk, IntPtr.Ptr, piRowBmk, IntPtr.Ptr, pcRowsTotal)
}
struct ODBC_VS_ARGS {
    pguidEvent : GUID.Ptr
    dwFlags : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    RetCode : Int16
    struct _Anonymous1_e__Union {
        union {
            wszArg : PWSTR
            szArg : PSTR
        }
    }
    struct _Anonymous2_e__Union {
        union {
            wszCorrelation : PWSTR
            szCorrelation : PSTR
        }
    }
}
struct SQLVARENUM extends Int32 {
    static VT_SS_EMPTY := 0
    static VT_SS_NULL := 1
    static VT_SS_UI1 := 17
    static VT_SS_I2 := 2
    static VT_SS_I4 := 3
    static VT_SS_I8 := 20
    static VT_SS_R4 := 4
    static VT_SS_R8 := 5
    static VT_SS_MONEY := 6
    static VT_SS_SMALLMONEY := 200
    static VT_SS_WSTRING := 201
    static VT_SS_WVARSTRING := 202
    static VT_SS_STRING := 203
    static VT_SS_VARSTRING := 204
    static VT_SS_BIT := 11
    static VT_SS_GUID := 72
    static VT_SS_NUMERIC := 131
    static VT_SS_DECIMAL := 205
    static VT_SS_DATETIME := 135
    static VT_SS_SMALLDATETIME := 206
    static VT_SS_BINARY := 207
    static VT_SS_VARBINARY := 208
    static VT_SS_UNKNOWN := 209
}
struct SSVARIANT {
    vt : UInt16
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bTinyIntVal : UInt8
            sShortIntVal : Int16
            lIntVal : Int32
            llBigIntVal : Int64
            fltRealVal : Float32
            dblFloatVal : Float64
            cyMoneyVal : CY
            NCharVal : this._NCharVal
            CharVal : this._CharVal
            fBitVal : VARIANT_BOOL
            rgbGuidVal : UInt8[16]
            numNumericVal : DB_NUMERIC
            BinaryVal : this._BinaryVal
            tsDateTimeVal : DBTIMESTAMP
            UnknownType : this._UnknownType
            BLOBType : this._BLOBType
        }
        struct _NCharVal {
            sActualLength : Int16
            sMaxLength : Int16
            pwchNCharVal : PWSTR
            rgbReserved : UInt8[5]
            dwReserved : UInt32
            pwchReserved : PWSTR
        }
        struct _CharVal {
            sActualLength : Int16
            sMaxLength : Int16
            pchCharVal : PSTR
            rgbReserved : UInt8[5]
            dwReserved : UInt32
            pwchReserved : PWSTR
        }
        struct _BinaryVal {
            sActualLength : Int16
            sMaxLength : Int16
            prgbBinaryVal : UInt8.Ptr
            dwReserved : UInt32
        }
        struct _UnknownType {
            dwActualLength : UInt32
            rgMetadata : UInt8[16]
            pUnknownData : UInt8.Ptr
        }
        struct _BLOBType {
            dbobj : DBOBJECT
            pUnk : IUnknown
        }
    }
}
struct IUMSInitialize extends IUnknown {
    static IID := "{5CF4CA14-EF21-11D0-97E7-00C04FC2AD98}"
    Initialize(pUMS)
      => ComCall(3, this.p, Struct.Ptr, pUMS)
}
struct IUMS extends InterfacePointer {
    SqlUmsSuspend(ticks)
      => ComCall(0, this.p, UInt32, ticks, "void")
    SqlUmsYield(ticks)
      => ComCall(1, this.p, UInt32, ticks, "void")
    SqlUmsSwitchPremptive()
      => ComCall(2, this.p, "void")
    SqlUmsSwitchNonPremptive()
      => ComCall(3, this.p, "void")
    SqlUmsFIsPremptive()
      => ComCall(4, this.p, BOOL)
}
struct SSERRORINFO {
    pwszMessage : PWSTR
    pwszServer : PWSTR
    pwszProcedure : PWSTR
    lNative : Int32
    bState : UInt8
    bClass : UInt8
    wLineNumber : UInt16
}
struct ISQLServerErrorInfo extends IUnknown {
    static IID := "{5CF4CA12-EF21-11D0-97E7-00C04FC2AD98}"
    GetErrorInfo(ppErrorInfo, ppStringsBuffer)
      => ComCall(3, this.p, SSERRORINFO.Ptr.Ptr, ppErrorInfo, UInt16.Ptr.Ptr, ppStringsBuffer)
}
struct IRowsetFastLoad extends IUnknown {
    static IID := "{5CF4CA13-EF21-11D0-97E7-00C04FC2AD98}"
    InsertRow(hAccessor1, pData)
      => ComCall(3, this.p, HACCESSOR, hAccessor1, Struct.Ptr, pData)
    Commit(fDone)
      => ComCall(4, this.p, BOOL, fDone)
}
struct LOCKMODEENUM extends Int32 {
    static LOCKMODE_INVALID := 0
    static LOCKMODE_EXCLUSIVE := 1
    static LOCKMODE_SHARED := 2
}
struct ISchemaLock extends IUnknown {
    static IID := "{4C2389FB-2511-11D4-B258-00C04F7971CE}"
    GetSchemaLock(pTableID, lmMode, phLockHandle, pTableVersion)
      => ComCall(3, this.p, DBID.Ptr, pTableID, UInt32, lmMode, HANDLE.Ptr, phLockHandle, Int64.Ptr, pTableVersion)
    ReleaseSchemaLock(hLockHandle)
      => ComCall(4, this.p, HANDLE, hLockHandle)
}
struct SQL_ASYNC_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL, Int16]
}
