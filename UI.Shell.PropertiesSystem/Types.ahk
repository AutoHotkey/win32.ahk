#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HRESULT, PROPERTYKEY, PWSTR}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\System.Search.Common\Types.ahk" {CONDITION_OPERATION}

struct SERIALIZEDPROPSTORAGE {
    Value : IntPtr
}
struct PCUSERIALIZEDPROPSTORAGE {
    Value : IntPtr
}
struct IInitializeWithFile extends IUnknown {
    static IID := "{B7D14566-0509-4CCE-A71F-0A554233BD9B}"
    Initialize(pszFilePath, grfMode)
      => ComCall(3, this.p, "Str", pszFilePath, UInt32, grfMode)
}
struct IInitializeWithStream extends IUnknown {
    static IID := "{B824B49D-22AC-4161-AC8A-9916E8FA3F7F}"
    Initialize(pstream, grfMode)
      => ComCall(3, this.p, IStream, pstream, UInt32, grfMode)
}
struct IPropertyStore extends IUnknown {
    static IID := "{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}"
    GetCount(cProps)
      => ComCall(3, this.p, UInt32.Ptr, cProps)
    GetAt(iProp, pkey)
      => ComCall(4, this.p, UInt32, iProp, PROPERTYKEY.Ptr, pkey)
    GetValue(key, pv)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pv)
    SetValue(key, propvar)
      => ComCall(6, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, propvar)
    Commit()
      => ComCall(7, this.p)
}
struct INamedPropertyStore extends IUnknown {
    static IID := "{71604B0F-97B0-4764-8577-2F13E98A1422}"
    GetNamedValue(pszName, ppropvar)
      => ComCall(3, this.p, "Str", pszName, PROPVARIANT.Ptr, ppropvar)
    SetNamedValue(pszName, propvar)
      => ComCall(4, this.p, "Str", pszName, PROPVARIANT.Ptr, propvar)
    GetNameCount(pdwCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwCount)
    GetNameAt(iProp, pbstrName)
      => ComCall(6, this.p, UInt32, iProp, BSTR.Ptr, pbstrName)
}
struct GETPROPERTYSTOREFLAGS extends Int32 {
    static GPS_DEFAULT := 0
    static GPS_HANDLERPROPERTIESONLY := 1
    static GPS_READWRITE := 2
    static GPS_TEMPORARY := 4
    static GPS_FASTPROPERTIESONLY := 8
    static GPS_OPENSLOWITEM := 16
    static GPS_DELAYCREATION := 32
    static GPS_BESTEFFORT := 64
    static GPS_NO_OPLOCK := 128
    static GPS_PREFERQUERYPROPERTIES := 256
    static GPS_EXTRINSICPROPERTIES := 512
    static GPS_EXTRINSICPROPERTIESONLY := 1024
    static GPS_VOLATILEPROPERTIES := 2048
    static GPS_VOLATILEPROPERTIESONLY := 4096
    static GPS_MASK_VALID := 8191
}
struct IObjectWithPropertyKey extends IUnknown {
    static IID := "{FC0CA0A7-C316-4FD2-9031-3E628E6D4F23}"
    SetPropertyKey(key)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, key)
    GetPropertyKey(pkey)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, pkey)
}
struct PKA_FLAGS extends Int32 {
    static PKA_SET := 0
    static PKA_APPEND := 1
    static PKA_DELETE := 2
}
struct IPropertyChange extends IObjectWithPropertyKey {
    static IID := "{F917BC8A-1BBA-4478-A245-1BDE03EB9431}"
    ApplyToPropVariant(propvarIn, ppropvarOut)
      => ComCall(5, this.p, PROPVARIANT.Ptr, propvarIn, PROPVARIANT.Ptr, ppropvarOut)
}
struct IPropertyChangeArray extends IUnknown {
    static IID := "{380F5CAD-1B5E-42F2-805D-637FD392D31E}"
    GetCount(pcOperations)
      => ComCall(3, this.p, UInt32.Ptr, pcOperations)
    GetAt(iIndex, riid, ppv)
      => ComCall(4, this.p, UInt32, iIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    InsertAt(iIndex, ppropChange)
      => ComCall(5, this.p, UInt32, iIndex, IPropertyChange, ppropChange)
    Append(ppropChange)
      => ComCall(6, this.p, IPropertyChange, ppropChange)
    AppendOrReplace(ppropChange)
      => ComCall(7, this.p, IPropertyChange, ppropChange)
    RemoveAt(iIndex)
      => ComCall(8, this.p, UInt32, iIndex)
    IsKeyInArray(key)
      => ComCall(9, this.p, PROPERTYKEY.Ptr, key)
}
struct IPropertyStoreCapabilities extends IUnknown {
    static IID := "{C8E2D566-186E-4D49-BF41-6909EAD56ACC}"
    IsPropertyWritable(key)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, key)
}
struct PSC_STATE extends Int32 {
    static PSC_NORMAL := 0
    static PSC_NOTINSOURCE := 1
    static PSC_DIRTY := 2
    static PSC_READONLY := 3
}
struct IPropertyStoreCache extends IPropertyStore {
    static IID := "{3017056D-9A91-4E90-937D-746C72ABBF4F}"
    GetState(key, pstate)
      => ComCall(8, this.p, PROPERTYKEY.Ptr, key, PSC_STATE.Ptr, pstate)
    GetValueAndState(key, ppropvar, pstate)
      => ComCall(9, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, ppropvar, PSC_STATE.Ptr, pstate)
    SetState(key, state)
      => ComCall(10, this.p, PROPERTYKEY.Ptr, key, PSC_STATE, state)
    SetValueAndState(key, ppropvar, state)
      => ComCall(11, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, ppropvar, PSC_STATE, state)
}
struct PROPENUMTYPE extends Int32 {
    static PET_DISCRETEVALUE := 0
    static PET_RANGEDVALUE := 1
    static PET_DEFAULTVALUE := 2
    static PET_ENDRANGE := 3
}
struct IPropertyEnumType extends IUnknown {
    static IID := "{11E1FBF9-2D56-4A6B-8DB3-7CD193A471F2}"
    GetEnumType(penumtype)
      => ComCall(3, this.p, PROPENUMTYPE.Ptr, penumtype)
    GetValue(ppropvar)
      => ComCall(4, this.p, PROPVARIANT.Ptr, ppropvar)
    GetRangeMinValue(ppropvarMin)
      => ComCall(5, this.p, PROPVARIANT.Ptr, ppropvarMin)
    GetRangeSetValue(ppropvarSet)
      => ComCall(6, this.p, PROPVARIANT.Ptr, ppropvarSet)
    GetDisplayText(ppszDisplay)
      => ComCall(7, this.p, PWSTR.Ptr, ppszDisplay)
}
struct IPropertyEnumType2 extends IPropertyEnumType {
    static IID := "{9B6E051C-5DDD-4321-9070-FE2ACB55E794}"
    GetImageReference(ppszImageRes)
      => ComCall(8, this.p, PWSTR.Ptr, ppszImageRes)
}
struct IPropertyEnumTypeList extends IUnknown {
    static IID := "{A99400F4-3D84-4557-94BA-1242FB2CC9A6}"
    GetCount(pctypes)
      => ComCall(3, this.p, UInt32.Ptr, pctypes)
    GetAt(itype, riid, ppv)
      => ComCall(4, this.p, UInt32, itype, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetConditionAt(nIndex, riid, ppv)
      => ComCall(5, this.p, UInt32, nIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    FindMatchingIndex(propvarCmp, pnIndex)
      => ComCall(6, this.p, PROPVARIANT.Ptr, propvarCmp, UInt32.Ptr, pnIndex)
}
struct PROPDESC_TYPE_FLAGS extends UInt32 {
    static PDTF_DEFAULT := 0
    static PDTF_MULTIPLEVALUES := 1
    static PDTF_ISINNATE := 2
    static PDTF_ISGROUP := 4
    static PDTF_CANGROUPBY := 8
    static PDTF_CANSTACKBY := 16
    static PDTF_ISTREEPROPERTY := 32
    static PDTF_INCLUDEINFULLTEXTQUERY := 64
    static PDTF_ISVIEWABLE := 128
    static PDTF_ISQUERYABLE := 256
    static PDTF_CANBEPURGED := 512
    static PDTF_SEARCHRAWVALUE := 1024
    static PDTF_DONTCOERCEEMPTYSTRINGS := 2048
    static PDTF_ALWAYSINSUPPLEMENTALSTORE := 4096
    static PDTF_ISSYSTEMPROPERTY := 2147483648
    static PDTF_MASK_ALL := 2147491839
}
struct PROPDESC_VIEW_FLAGS extends Int32 {
    static PDVF_DEFAULT := 0
    static PDVF_CENTERALIGN := 1
    static PDVF_RIGHTALIGN := 2
    static PDVF_BEGINNEWGROUP := 4
    static PDVF_FILLAREA := 8
    static PDVF_SORTDESCENDING := 16
    static PDVF_SHOWONLYIFPRESENT := 32
    static PDVF_SHOWBYDEFAULT := 64
    static PDVF_SHOWINPRIMARYLIST := 128
    static PDVF_SHOWINSECONDARYLIST := 256
    static PDVF_HIDELABEL := 512
    static PDVF_HIDDEN := 2048
    static PDVF_CANWRAP := 4096
    static PDVF_MASK_ALL := 7167
}
struct PROPDESC_DISPLAYTYPE extends Int32 {
    static PDDT_STRING := 0
    static PDDT_NUMBER := 1
    static PDDT_BOOLEAN := 2
    static PDDT_DATETIME := 3
    static PDDT_ENUMERATED := 4
}
struct PROPDESC_GROUPING_RANGE extends Int32 {
    static PDGR_DISCRETE := 0
    static PDGR_ALPHANUMERIC := 1
    static PDGR_SIZE := 2
    static PDGR_DYNAMIC := 3
    static PDGR_DATE := 4
    static PDGR_PERCENT := 5
    static PDGR_ENUMERATED := 6
}
struct PROPDESC_FORMAT_FLAGS extends Int32 {
    static PDFF_DEFAULT := 0
    static PDFF_PREFIXNAME := 1
    static PDFF_FILENAME := 2
    static PDFF_ALWAYSKB := 4
    static PDFF_RESERVED_RIGHTTOLEFT := 8
    static PDFF_SHORTTIME := 16
    static PDFF_LONGTIME := 32
    static PDFF_HIDETIME := 64
    static PDFF_SHORTDATE := 128
    static PDFF_LONGDATE := 256
    static PDFF_HIDEDATE := 512
    static PDFF_RELATIVEDATE := 1024
    static PDFF_USEEDITINVITATION := 2048
    static PDFF_READONLY := 4096
    static PDFF_NOAUTOREADINGORDER := 8192
}
struct PROPDESC_SORTDESCRIPTION extends Int32 {
    static PDSD_GENERAL := 0
    static PDSD_A_Z := 1
    static PDSD_LOWEST_HIGHEST := 2
    static PDSD_SMALLEST_BIGGEST := 3
    static PDSD_OLDEST_NEWEST := 4
}
struct PROPDESC_RELATIVEDESCRIPTION_TYPE extends Int32 {
    static PDRDT_GENERAL := 0
    static PDRDT_DATE := 1
    static PDRDT_SIZE := 2
    static PDRDT_COUNT := 3
    static PDRDT_REVISION := 4
    static PDRDT_LENGTH := 5
    static PDRDT_DURATION := 6
    static PDRDT_SPEED := 7
    static PDRDT_RATE := 8
    static PDRDT_RATING := 9
    static PDRDT_PRIORITY := 10
}
struct PROPDESC_AGGREGATION_TYPE extends Int32 {
    static PDAT_DEFAULT := 0
    static PDAT_FIRST := 1
    static PDAT_SUM := 2
    static PDAT_AVERAGE := 3
    static PDAT_DATERANGE := 4
    static PDAT_UNION := 5
    static PDAT_MAX := 6
    static PDAT_MIN := 7
}
struct PROPDESC_CONDITION_TYPE extends Int32 {
    static PDCOT_NONE := 0
    static PDCOT_STRING := 1
    static PDCOT_SIZE := 2
    static PDCOT_DATETIME := 3
    static PDCOT_BOOLEAN := 4
    static PDCOT_NUMBER := 5
}
struct IPropertyDescription extends IUnknown {
    static IID := "{6F79D558-3E96-4549-A1D1-7D75D2288814}"
    GetPropertyKey(pkey)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, pkey)
    GetCanonicalName(ppszName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszName)
    GetPropertyType(pvartype)
      => ComCall(5, this.p, UInt16.Ptr, pvartype)
    GetDisplayName(ppszName)
      => ComCall(6, this.p, PWSTR.Ptr, ppszName)
    GetEditInvitation(ppszInvite)
      => ComCall(7, this.p, PWSTR.Ptr, ppszInvite)
    GetTypeFlags(mask, ppdtFlags)
      => ComCall(8, this.p, PROPDESC_TYPE_FLAGS, mask, PROPDESC_TYPE_FLAGS.Ptr, ppdtFlags)
    GetViewFlags(ppdvFlags)
      => ComCall(9, this.p, PROPDESC_VIEW_FLAGS.Ptr, ppdvFlags)
    GetDefaultColumnWidth(pcxChars)
      => ComCall(10, this.p, UInt32.Ptr, pcxChars)
    GetDisplayType(pdisplaytype)
      => ComCall(11, this.p, PROPDESC_DISPLAYTYPE.Ptr, pdisplaytype)
    GetColumnState(pcsFlags)
      => ComCall(12, this.p, UInt32.Ptr, pcsFlags)
    GetGroupingRange(pgr)
      => ComCall(13, this.p, PROPDESC_GROUPING_RANGE.Ptr, pgr)
    GetRelativeDescriptionType(prdt)
      => ComCall(14, this.p, PROPDESC_RELATIVEDESCRIPTION_TYPE.Ptr, prdt)
    GetRelativeDescription(propvar1, propvar2, ppszDesc1, ppszDesc2)
      => ComCall(15, this.p, PROPVARIANT.Ptr, propvar1, PROPVARIANT.Ptr, propvar2, PWSTR.Ptr, ppszDesc1, PWSTR.Ptr, ppszDesc2)
    GetSortDescription(psd)
      => ComCall(16, this.p, PROPDESC_SORTDESCRIPTION.Ptr, psd)
    GetSortDescriptionLabel(fDescending, ppszDescription)
      => ComCall(17, this.p, BOOL, fDescending, PWSTR.Ptr, ppszDescription)
    GetAggregationType(paggtype)
      => ComCall(18, this.p, PROPDESC_AGGREGATION_TYPE.Ptr, paggtype)
    GetConditionType(pcontype, popDefault)
      => ComCall(19, this.p, PROPDESC_CONDITION_TYPE.Ptr, pcontype, CONDITION_OPERATION.Ptr, popDefault)
    GetEnumTypeList(riid, ppv)
      => ComCall(20, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CoerceToCanonicalValue(ppropvar)
      => ComCall(21, this.p, PROPVARIANT.Ptr, ppropvar)
    FormatForDisplay(propvar, pdfFlags, ppszDisplay)
      => ComCall(22, this.p, PROPVARIANT.Ptr, propvar, PROPDESC_FORMAT_FLAGS, pdfFlags, PWSTR.Ptr, ppszDisplay)
    IsValueCanonical(propvar)
      => ComCall(23, this.p, PROPVARIANT.Ptr, propvar)
}
struct IPropertyDescription2 extends IPropertyDescription {
    static IID := "{57D2EDED-5062-400E-B107-5DAE79FE57A6}"
    GetImageReferenceForValue(propvar, ppszImageRes)
      => ComCall(24, this.p, PROPVARIANT.Ptr, propvar, PWSTR.Ptr, ppszImageRes)
}
struct IPropertyDescriptionAliasInfo extends IPropertyDescription {
    static IID := "{F67104FC-2AF9-46FD-B32D-243C1404F3D1}"
    GetSortByAlias(riid, ppv)
      => ComCall(24, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetAdditionalSortByAliases(riid, ppv)
      => ComCall(25, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct PROPDESC_SEARCHINFO_FLAGS extends Int32 {
    static PDSIF_DEFAULT := 0
    static PDSIF_ININVERTEDINDEX := 1
    static PDSIF_ISCOLUMN := 2
    static PDSIF_ISCOLUMNSPARSE := 4
    static PDSIF_ALWAYSINCLUDE := 8
    static PDSIF_USEFORTYPEAHEAD := 16
}
struct PROPDESC_COLUMNINDEX_TYPE extends Int32 {
    static PDCIT_NONE := 0
    static PDCIT_ONDISK := 1
    static PDCIT_INMEMORY := 2
    static PDCIT_ONDEMAND := 3
    static PDCIT_ONDISKALL := 4
    static PDCIT_ONDISKVECTOR := 5
}
struct IPropertyDescriptionSearchInfo extends IPropertyDescription {
    static IID := "{078F91BD-29A2-440F-924E-46A291524520}"
    GetSearchInfoFlags(ppdsiFlags)
      => ComCall(24, this.p, PROPDESC_SEARCHINFO_FLAGS.Ptr, ppdsiFlags)
    GetColumnIndexType(ppdciType)
      => ComCall(25, this.p, PROPDESC_COLUMNINDEX_TYPE.Ptr, ppdciType)
    GetProjectionString(ppszProjection)
      => ComCall(26, this.p, PWSTR.Ptr, ppszProjection)
    GetMaxSize(pcbMaxSize)
      => ComCall(27, this.p, UInt32.Ptr, pcbMaxSize)
}
struct IPropertyDescriptionRelatedPropertyInfo extends IPropertyDescription {
    static IID := "{507393F4-2A3D-4A60-B59E-D9C75716C2DD}"
    GetRelatedProperty(pszRelationshipName, riid, ppv)
      => ComCall(24, this.p, "Str", pszRelationshipName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct PROPDESC_ENUMFILTER extends Int32 {
    static PDEF_ALL := 0
    static PDEF_SYSTEM := 1
    static PDEF_NONSYSTEM := 2
    static PDEF_VIEWABLE := 3
    static PDEF_QUERYABLE := 4
    static PDEF_INFULLTEXTQUERY := 5
    static PDEF_COLUMN := 6
}
struct IPropertySystem extends IUnknown {
    static IID := "{CA724E8A-C3E6-442B-88A4-6FB0DB8035A3}"
    GetPropertyDescription(propkey, riid, ppv)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, propkey, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyDescriptionByName(pszCanonicalName, riid, ppv)
      => ComCall(4, this.p, "Str", pszCanonicalName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyDescriptionListFromString(pszPropList, riid, ppv)
      => ComCall(5, this.p, "Str", pszPropList, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    EnumeratePropertyDescriptions(filterOn, riid, ppv)
      => ComCall(6, this.p, PROPDESC_ENUMFILTER, filterOn, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    FormatForDisplay(key, propvar, pdff, pszText)
      => ComCall(7, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, propvar, PROPDESC_FORMAT_FLAGS, pdff, PWSTR, pszText, UInt32, pszText.Length)
    FormatForDisplayAlloc(key, propvar, pdff, ppszDisplay)
      => ComCall(8, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, propvar, PROPDESC_FORMAT_FLAGS, pdff, PWSTR.Ptr, ppszDisplay)
    RegisterPropertySchema(pszPath)
      => ComCall(9, this.p, "Str", pszPath)
    UnregisterPropertySchema(pszPath)
      => ComCall(10, this.p, "Str", pszPath)
    RefreshPropertySchema()
      => ComCall(11, this.p)
}
struct IPropertyDescriptionList extends IUnknown {
    static IID := "{1F9FC1D0-C39B-4B26-817F-011967D3440E}"
    GetCount(pcElem)
      => ComCall(3, this.p, UInt32.Ptr, pcElem)
    GetAt(iElem, riid, ppv)
      => ComCall(4, this.p, UInt32, iElem, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IPropertyStoreFactory extends IUnknown {
    static IID := "{BC110B6D-57E8-4148-A9C6-91015AB2F3A5}"
    GetPropertyStore(flags, pUnkFactory, riid, ppv)
      => ComCall(3, this.p, GETPROPERTYSTOREFLAGS, flags, IUnknown, pUnkFactory, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetPropertyStoreForKeys(rgKeys, cKeys, flags, riid, ppv)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, rgKeys, UInt32, cKeys, GETPROPERTYSTOREFLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IDelayedPropertyStoreFactory extends IPropertyStoreFactory {
    static IID := "{40D4577F-E237-4BDB-BD69-58F089431B6A}"
    GetDelayedPropertyStore(flags, dwStoreId, riid, ppv)
      => ComCall(5, this.p, GETPROPERTYSTOREFLAGS, flags, UInt32, dwStoreId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct PERSIST_SPROPSTORE_FLAGS extends Int32 {
    static FPSPS_DEFAULT := 0
    static FPSPS_READONLY := 1
    static FPSPS_TREAT_NEW_VALUES_AS_DIRTY := 2
}
struct IPersistSerializedPropStorage extends IUnknown {
    static IID := "{E318AD57-0AA0-450F-ACA5-6FAB7103D917}"
    SetFlags(flags)
      => ComCall(3, this.p, Int32, flags)
    SetPropertyStorage(psps)
      => ComCall(4, this.p, PCUSERIALIZEDPROPSTORAGE, psps, UInt32, psps.Size)
    GetPropertyStorage(ppsps, pcb)
      => ComCall(5, this.p, SERIALIZEDPROPSTORAGE.Ptr.Ptr, ppsps, UInt32.Ptr, pcb)
}
struct IPersistSerializedPropStorage2 extends IPersistSerializedPropStorage {
    static IID := "{77EFFA68-4F98-4366-BA72-573B3D880571}"
    GetPropertyStorageSize(pcb)
      => ComCall(6, this.p, UInt32.Ptr, pcb)
    GetPropertyStorageBuffer(psps, pcbWritten)
      => ComCall(7, this.p, SERIALIZEDPROPSTORAGE.Ptr, psps, UInt32, psps.Size, UInt32.Ptr, pcbWritten)
}
struct IPropertySystemChangeNotify extends IUnknown {
    static IID := "{FA955FD9-38BE-4879-A6CE-824CF52D609F}"
    SchemaRefreshed()
      => ComCall(3, this.p)
}
struct ICreateObject extends IUnknown {
    static IID := "{75121952-E0D0-43E5-9380-1D80483ACF72}"
    CreateObject(clsid, pUnkOuter, riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, clsid, IUnknown, pUnkOuter, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct SYNC_TRANSFER_STATUS extends Int32 {
    static STS_NONE := 0
    static STS_NEEDSUPLOAD := 1
    static STS_NEEDSDOWNLOAD := 2
    static STS_TRANSFERRING := 4
    static STS_PAUSED := 8
    static STS_HASERROR := 16
    static STS_FETCHING_METADATA := 32
    static STS_USER_REQUESTED_REFRESH := 64
    static STS_HASWARNING := 128
    static STS_EXCLUDED := 256
    static STS_INCOMPLETE := 512
    static STS_PLACEHOLDER_IFEMPTY := 1024
}
struct PLACEHOLDER_STATES extends Int32 {
    static PS_NONE := 0
    static PS_MARKED_FOR_OFFLINE_AVAILABILITY := 1
    static PS_FULL_PRIMARY_STREAM_AVAILABLE := 2
    static PS_CREATE_FILE_ACCESSIBLE := 4
    static PS_CLOUDFILE_PLACEHOLDER := 8
    static PS_DEFAULT := 7
    static PS_ALL := 15
}
struct PROPERTYUI_NAME_FLAGS extends Int32 {
    static PUIFNF_DEFAULT := 0
    static PUIFNF_MNEMONIC := 1
}
struct PROPERTYUI_FLAGS extends Int32 {
    static PUIF_DEFAULT := 0
    static PUIF_RIGHTALIGN := 1
    static PUIF_NOLABELININFOTIP := 2
}
struct PROPERTYUI_FORMAT_FLAGS extends Int32 {
    static PUIFFDF_DEFAULT := 0
    static PUIFFDF_RIGHTTOLEFT := 1
    static PUIFFDF_SHORTFORMAT := 2
    static PUIFFDF_NOTIME := 4
    static PUIFFDF_FRIENDLYDATE := 8
}
struct IPropertyUI extends IUnknown {
    static IID := "{757A7D9F-919A-4118-99D7-DBB208C8CC66}"
    ParsePropertyName(pszName, pfmtid, ppid, pchEaten)
      => ComCall(3, this.p, "Str", pszName, GUID.Ptr, pfmtid, UInt32.Ptr, ppid, UInt32.Ptr, pchEaten)
    GetCannonicalName(fmtid, pid, pwszText)
      => ComCall(4, this.p, GUID.Ptr, fmtid, UInt32, pid, PWSTR, pwszText, UInt32, pwszText.Length)
    GetDisplayName(fmtid, pid, flags, pwszText)
      => ComCall(5, this.p, GUID.Ptr, fmtid, UInt32, pid, PROPERTYUI_NAME_FLAGS, flags, PWSTR, pwszText, UInt32, pwszText.Length)
    GetPropertyDescription(fmtid, pid, pwszText)
      => ComCall(6, this.p, GUID.Ptr, fmtid, UInt32, pid, PWSTR, pwszText, UInt32, pwszText.Length)
    GetDefaultWidth(fmtid, pid, pcxChars)
      => ComCall(7, this.p, GUID.Ptr, fmtid, UInt32, pid, UInt32.Ptr, pcxChars)
    GetFlags(fmtid, pid, pflags)
      => ComCall(8, this.p, GUID.Ptr, fmtid, UInt32, pid, PROPERTYUI_FLAGS.Ptr, pflags)
    FormatForDisplay(fmtid, pid, ppropvar, puiff, pwszText)
      => ComCall(9, this.p, GUID.Ptr, fmtid, UInt32, pid, PROPVARIANT.Ptr, ppropvar, PROPERTYUI_FORMAT_FLAGS, puiff, PWSTR, pwszText, UInt32, pwszText.Length)
    GetHelpInfo(fmtid, pid, pwszHelpFile, puHelpID)
      => ComCall(10, this.p, GUID.Ptr, fmtid, UInt32, pid, PWSTR, pwszHelpFile, UInt32, pwszHelpFile.Length, UInt32.Ptr, puHelpID)
}
struct PDOPSTATUS extends Int32 {
    static PDOPS_RUNNING := 1
    static PDOPS_PAUSED := 2
    static PDOPS_CANCELLED := 3
    static PDOPS_STOPPED := 4
    static PDOPS_ERRORS := 5
}
struct SYNC_ENGINE_STATE_FLAGS extends Int32 {
    static SESF_NONE := 0
    static SESF_SERVICE_QUOTA_NEARING_LIMIT := 1
    static SESF_SERVICE_QUOTA_EXCEEDED_LIMIT := 2
    static SESF_AUTHENTICATION_ERROR := 4
    static SESF_PAUSED_DUE_TO_METERED_NETWORK := 8
    static SESF_PAUSED_DUE_TO_DISK_SPACE_FULL := 16
    static SESF_PAUSED_DUE_TO_CLIENT_POLICY := 32
    static SESF_PAUSED_DUE_TO_SERVICE_POLICY := 64
    static SESF_SERVICE_UNAVAILABLE := 128
    static SESF_PAUSED_DUE_TO_USER_REQUEST := 256
    static SESF_ALL_FLAGS := 511
}
struct PROPPRG {
    flPrg : UInt16
    flPrgInit : UInt16
    achTitle : CHAR[30]
    achCmdLine : CHAR[128]
    achWorkDir : CHAR[64]
    wHotKey : UInt16
    achIconFile : CHAR[80]
    wIconIndex : UInt16
    dwEnhModeFlags : UInt32
    dwRealModeFlags : UInt32
    achOtherFile : CHAR[80]
    achPIFFile : CHAR[260]
}
