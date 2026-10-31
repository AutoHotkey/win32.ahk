#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\Media.Audio\Types.ahk" {WAVEFORMATEX}
#Import "..\Media.MediaFoundation\Types.ahk" {VIDEOINFOHEADER}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\System.Ole\Types.ahk" {ISpecifyPropertyPages}

struct MACINFO {
    fUsed : BOOL
    abMacState : UInt8[36]
}
struct WMDM_TAG_DATATYPE extends Int32 {
    static WMDM_TYPE_DWORD := 0
    static WMDM_TYPE_STRING := 1
    static WMDM_TYPE_BINARY := 2
    static WMDM_TYPE_BOOL := 3
    static WMDM_TYPE_QWORD := 4
    static WMDM_TYPE_WORD := 5
    static WMDM_TYPE_GUID := 6
    static WMDM_TYPE_DATE := 7
}
struct WMDM_SESSION_TYPE extends Int32 {
    static WMDM_SESSION_NONE := 0
    static WMDM_SESSION_TRANSFER_TO_DEVICE := 1
    static WMDM_SESSION_TRANSFER_FROM_DEVICE := 16
    static WMDM_SESSION_DELETE := 256
    static WMDM_SESSION_CUSTOM := 4096
}
struct WMFILECAPABILITIES {
    pwszMimeType : PWSTR
    dwReserved : UInt32
}
struct OPAQUECOMMAND {
    guidCommand : GUID
    dwDataLen : UInt32
    pData : UInt8.Ptr
    abMAC : UInt8[20]
}
struct WMDMID {
    cbSize : UInt32 := this.Size
    dwVendorID : UInt32
    pID : UInt8[128]
    SerialNumberLength : UInt32
}
struct WMDMDATETIME {
    wYear : UInt16
    wMonth : UInt16
    wDay : UInt16
    wHour : UInt16
    wMinute : UInt16
    wSecond : UInt16
}
struct WMDMRIGHTS {
    cbSize : UInt32 := this.Size
    dwContentType : UInt32
    fuFlags : UInt32
    fuRights : UInt32
    dwAppSec : UInt32
    dwPlaybackCount : UInt32
    ExpirationDate : WMDMDATETIME
}
struct WMDMMetadataView {
    pwszViewName : PWSTR
    nDepth : UInt32
    ppwszTags : UInt16.Ptr.Ptr
}
struct WMDM_STORAGE_ENUM_MODE extends Int32 {
    static ENUM_MODE_RAW := 0
    static ENUM_MODE_USE_DEVICE_PREF := 1
    static ENUM_MODE_METADATA_VIEWS := 2
}
struct WMDM_FORMATCODE extends Int32 {
    static WMDM_FORMATCODE_NOTUSED := 0
    static WMDM_FORMATCODE_ALLIMAGES := -1
    static WMDM_FORMATCODE_UNDEFINED := 12288
    static WMDM_FORMATCODE_ASSOCIATION := 12289
    static WMDM_FORMATCODE_SCRIPT := 12290
    static WMDM_FORMATCODE_EXECUTABLE := 12291
    static WMDM_FORMATCODE_TEXT := 12292
    static WMDM_FORMATCODE_HTML := 12293
    static WMDM_FORMATCODE_DPOF := 12294
    static WMDM_FORMATCODE_AIFF := 12295
    static WMDM_FORMATCODE_WAVE := 12296
    static WMDM_FORMATCODE_MP3 := 12297
    static WMDM_FORMATCODE_AVI := 12298
    static WMDM_FORMATCODE_MPEG := 12299
    static WMDM_FORMATCODE_ASF := 12300
    static WMDM_FORMATCODE_RESERVED_FIRST := 12301
    static WMDM_FORMATCODE_RESERVED_LAST := 14335
    static WMDM_FORMATCODE_IMAGE_UNDEFINED := 14336
    static WMDM_FORMATCODE_IMAGE_EXIF := 14337
    static WMDM_FORMATCODE_IMAGE_TIFFEP := 14338
    static WMDM_FORMATCODE_IMAGE_FLASHPIX := 14339
    static WMDM_FORMATCODE_IMAGE_BMP := 14340
    static WMDM_FORMATCODE_IMAGE_CIFF := 14341
    static WMDM_FORMATCODE_IMAGE_GIF := 14343
    static WMDM_FORMATCODE_IMAGE_JFIF := 14344
    static WMDM_FORMATCODE_IMAGE_PCD := 14345
    static WMDM_FORMATCODE_IMAGE_PICT := 14346
    static WMDM_FORMATCODE_IMAGE_PNG := 14347
    static WMDM_FORMATCODE_IMAGE_TIFF := 14349
    static WMDM_FORMATCODE_IMAGE_TIFFIT := 14350
    static WMDM_FORMATCODE_IMAGE_JP2 := 14351
    static WMDM_FORMATCODE_IMAGE_JPX := 14352
    static WMDM_FORMATCODE_IMAGE_RESERVED_FIRST := 14353
    static WMDM_FORMATCODE_IMAGE_RESERVED_LAST := 16383
    static WMDM_FORMATCODE_UNDEFINEDFIRMWARE := 47106
    static WMDM_FORMATCODE_WBMP := 47107
    static WMDM_FORMATCODE_JPEGXR := 47108
    static WMDM_FORMATCODE_WINDOWSIMAGEFORMAT := 47233
    static WMDM_FORMATCODE_UNDEFINEDAUDIO := 47360
    static WMDM_FORMATCODE_WMA := 47361
    static WMDM_FORMATCODE_OGG := 47362
    static WMDM_FORMATCODE_AAC := 47363
    static WMDM_FORMATCODE_AUDIBLE := 47364
    static WMDM_FORMATCODE_FLAC := 47366
    static WMDM_FORMATCODE_QCELP := 47367
    static WMDM_FORMATCODE_AMR := 47368
    static WMDM_FORMATCODE_UNDEFINEDVIDEO := 47488
    static WMDM_FORMATCODE_WMV := 47489
    static WMDM_FORMATCODE_MP4 := 47490
    static WMDM_FORMATCODE_MP2 := 47491
    static WMDM_FORMATCODE_3GP := 47492
    static WMDM_FORMATCODE_3G2 := 47493
    static WMDM_FORMATCODE_AVCHD := 47494
    static WMDM_FORMATCODE_ATSCTS := 47495
    static WMDM_FORMATCODE_DVBTS := 47496
    static WMDM_FORMATCODE_MKV := 47497
    static WMDM_FORMATCODE_MKA := 47498
    static WMDM_FORMATCODE_MK3D := 47499
    static WMDM_FORMATCODE_UNDEFINEDCOLLECTION := 47616
    static WMDM_FORMATCODE_ABSTRACTMULTIMEDIAALBUM := 47617
    static WMDM_FORMATCODE_ABSTRACTIMAGEALBUM := 47618
    static WMDM_FORMATCODE_ABSTRACTAUDIOALBUM := 47619
    static WMDM_FORMATCODE_ABSTRACTVIDEOALBUM := 47620
    static WMDM_FORMATCODE_ABSTRACTAUDIOVIDEOPLAYLIST := 47621
    static WMDM_FORMATCODE_ABSTRACTCONTACTGROUP := 47622
    static WMDM_FORMATCODE_ABSTRACTMESSAGEFOLDER := 47623
    static WMDM_FORMATCODE_ABSTRACTCHAPTEREDPRODUCTION := 47624
    static WMDM_FORMATCODE_MEDIA_CAST := 47627
    static WMDM_FORMATCODE_WPLPLAYLIST := 47632
    static WMDM_FORMATCODE_M3UPLAYLIST := 47633
    static WMDM_FORMATCODE_MPLPLAYLIST := 47634
    static WMDM_FORMATCODE_ASXPLAYLIST := 47635
    static WMDM_FORMATCODE_PLSPLAYLIST := 47636
    static WMDM_FORMATCODE_UNDEFINEDDOCUMENT := 47744
    static WMDM_FORMATCODE_ABSTRACTDOCUMENT := 47745
    static WMDM_FORMATCODE_XMLDOCUMENT := 47746
    static WMDM_FORMATCODE_MICROSOFTWORDDOCUMENT := 47747
    static WMDM_FORMATCODE_MHTCOMPILEDHTMLDOCUMENT := 47748
    static WMDM_FORMATCODE_MICROSOFTEXCELSPREADSHEET := 47749
    static WMDM_FORMATCODE_MICROSOFTPOWERPOINTDOCUMENT := 47750
    static WMDM_FORMATCODE_UNDEFINEDMESSAGE := 47872
    static WMDM_FORMATCODE_ABSTRACTMESSAGE := 47873
    static WMDM_FORMATCODE_UNDEFINEDCONTACT := 48000
    static WMDM_FORMATCODE_ABSTRACTCONTACT := 48001
    static WMDM_FORMATCODE_VCARD2 := 48002
    static WMDM_FORMATCODE_VCARD3 := 48003
    static WMDM_FORMATCODE_UNDEFINEDCALENDARITEM := 48640
    static WMDM_FORMATCODE_ABSTRACTCALENDARITEM := 48641
    static WMDM_FORMATCODE_VCALENDAR1 := 48642
    static WMDM_FORMATCODE_VCALENDAR2 := 48643
    static WMDM_FORMATCODE_UNDEFINEDWINDOWSEXECUTABLE := 48768
    static WMDM_FORMATCODE_M4A := 1297101889
    static WMDM_FORMATCODE_3GPA := 860311617
    static WMDM_FORMATCODE_3G2A := 860303937
    static WMDM_FORMATCODE_SECTION := 48770
}
struct WMDM_ENUM_PROP_VALID_VALUES_FORM extends Int32 {
    static WMDM_ENUM_PROP_VALID_VALUES_ANY := 0
    static WMDM_ENUM_PROP_VALID_VALUES_RANGE := 1
    static WMDM_ENUM_PROP_VALID_VALUES_ENUM := 2
}
struct WMDM_PROP_VALUES_RANGE {
    rangeMin : PROPVARIANT
    rangeMax : PROPVARIANT
    rangeStep : PROPVARIANT
}
struct WMDM_PROP_VALUES_ENUM {
    cEnumValues : UInt32
    pValues : PROPVARIANT.Ptr
}
struct WMDM_PROP_DESC {
    pwszPropName : PWSTR
    ValidValuesForm : WMDM_ENUM_PROP_VALID_VALUES_FORM
    ValidValues : this._ValidValues_e__Union
    struct _ValidValues_e__Union {
        union {
            ValidValuesRange : WMDM_PROP_VALUES_RANGE
            EnumeratedValidValues : WMDM_PROP_VALUES_ENUM
        }
    }
}
struct WMDM_PROP_CONFIG {
    nPreference : UInt32
    nPropDesc : UInt32
    pPropDesc : WMDM_PROP_DESC.Ptr
}
struct WMDM_FORMAT_CAPABILITY {
    nPropConfig : UInt32
    pConfigs : WMDM_PROP_CONFIG.Ptr
}
struct WMDM_FIND_SCOPE extends Int32 {
    static WMDM_FIND_SCOPE_GLOBAL := 0
    static WMDM_FIND_SCOPE_IMMEDIATE_CHILDREN := 1
}
struct WMDMMessage extends Int32 {
    static WMDM_MSG_DEVICE_ARRIVAL := 0
    static WMDM_MSG_DEVICE_REMOVAL := 1
    static WMDM_MSG_MEDIA_ARRIVAL := 2
    static WMDM_MSG_MEDIA_REMOVAL := 3
}
struct IWMDMMetaData extends IUnknown {
    static IID := "{EC3B0663-0951-460A-9A80-0DCEED3C043C}"
    AddItem(Type, pwszTagName, pValue?)
      => ComCall(3, this.p, WMDM_TAG_DATATYPE, Type, "Str", pwszTagName, UInt8.Ptr, pValue?, UInt32, pValue?.Length ?? 0)
    QueryByName(pwszTagName, pType, pValue, pcbLength)
      => ComCall(4, this.p, "Str", pwszTagName, WMDM_TAG_DATATYPE.Ptr, pType, UInt8.Ptr.Ptr, pValue, UInt32.Ptr, pcbLength)
    QueryByIndex(iIndex, ppwszName, pType, ppValue, pcbLength)
      => ComCall(5, this.p, UInt32, iIndex, UInt16.Ptr.Ptr, ppwszName, WMDM_TAG_DATATYPE.Ptr, pType, UInt8.Ptr.Ptr, ppValue, UInt32.Ptr, pcbLength)
    GetItemCount(iCount)
      => ComCall(6, this.p, UInt32.Ptr, iCount)
}
struct IWMDeviceManager extends IUnknown {
    static IID := "{1DCB3A00-33ED-11D3-8470-00C04F79DBC0}"
    GetRevision(pdwRevision)
      => ComCall(3, this.p, UInt32.Ptr, pdwRevision)
    GetDeviceCount(pdwCount)
      => ComCall(4, this.p, UInt32.Ptr, pdwCount)
    EnumDevices(ppEnumDevice)
      => ComCall(5, this.p, IWMDMEnumDevice.Ptr, ppEnumDevice)
}
struct IWMDeviceManager2 extends IWMDeviceManager {
    static IID := "{923E5249-8731-4C5B-9B1C-B8B60B6E46AF}"
    GetDeviceFromCanonicalName(pwszCanonicalName, ppDevice)
      => ComCall(6, this.p, "Str", pwszCanonicalName, IWMDMDevice.Ptr, ppDevice)
    EnumDevices2(ppEnumDevice)
      => ComCall(7, this.p, IWMDMEnumDevice.Ptr, ppEnumDevice)
    Reinitialize()
      => ComCall(8, this.p)
}
struct IWMDeviceManager3 extends IWMDeviceManager2 {
    static IID := "{AF185C41-100D-46ED-BE2E-9CE8C44594EF}"
    SetDeviceEnumPreference(dwEnumPref)
      => ComCall(9, this.p, UInt32, dwEnumPref)
}
struct IWMDMStorageGlobals extends IUnknown {
    static IID := "{1DCB3A07-33ED-11D3-8470-00C04F79DBC0}"
    GetCapabilities(pdwCapabilities)
      => ComCall(3, this.p, UInt32.Ptr, pdwCapabilities)
    GetSerialNumber(pSerialNum, abMac)
      => ComCall(4, this.p, WMDMID.Ptr, pSerialNum, UInt8.Ptr, abMac)
    GetTotalSize(pdwTotalSizeLow, pdwTotalSizeHigh)
      => ComCall(5, this.p, UInt32.Ptr, pdwTotalSizeLow, UInt32.Ptr, pdwTotalSizeHigh)
    GetTotalFree(pdwFreeLow, pdwFreeHigh)
      => ComCall(6, this.p, UInt32.Ptr, pdwFreeLow, UInt32.Ptr, pdwFreeHigh)
    GetTotalBad(pdwBadLow, pdwBadHigh)
      => ComCall(7, this.p, UInt32.Ptr, pdwBadLow, UInt32.Ptr, pdwBadHigh)
    GetStatus(pdwStatus)
      => ComCall(8, this.p, UInt32.Ptr, pdwStatus)
    Initialize(fuMode, pProgress?)
      => ComCall(9, this.p, UInt32, fuMode, IWMDMProgress, pProgress?)
}
struct IWMDMStorage extends IUnknown {
    static IID := "{1DCB3A06-33ED-11D3-8470-00C04F79DBC0}"
    SetAttributes(dwAttributes, pFormat?)
      => ComCall(3, this.p, UInt32, dwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    GetStorageGlobals(ppStorageGlobals)
      => ComCall(4, this.p, IWMDMStorageGlobals.Ptr, ppStorageGlobals)
    GetAttributes(pdwAttributes, pFormat?)
      => ComCall(5, this.p, UInt32.Ptr, pdwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    GetName(pwszName)
      => ComCall(6, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetDate(pDateTimeUTC)
      => ComCall(7, this.p, WMDMDATETIME.Ptr, pDateTimeUTC)
    GetSize(pdwSizeLow, pdwSizeHigh)
      => ComCall(8, this.p, UInt32.Ptr, pdwSizeLow, UInt32.Ptr, pdwSizeHigh)
    GetRights(ppRights, pnRightsCount, abMac)
      => ComCall(9, this.p, WMDMRIGHTS.Ptr.Ptr, ppRights, UInt32.Ptr, pnRightsCount, UInt8.Ptr, abMac)
    EnumStorage(pEnumStorage)
      => ComCall(10, this.p, IWMDMEnumStorage.Ptr, pEnumStorage)
    SendOpaqueCommand(pCommand)
      => ComCall(11, this.p, OPAQUECOMMAND.Ptr, pCommand)
}
struct IWMDMStorage2 extends IWMDMStorage {
    static IID := "{1ED5A144-5CD5-4683-9EFF-72CBDB2D9533}"
    GetStorage(pszStorageName, ppStorage)
      => ComCall(12, this.p, "Str", pszStorageName, IWMDMStorage.Ptr, ppStorage)
    SetAttributes2(dwAttributes, dwAttributesEx, pFormat?, pVideoFormat?)
      => ComCall(13, this.p, UInt32, dwAttributes, UInt32, dwAttributesEx, WAVEFORMATEX.Ptr, pFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
    GetAttributes2(pdwAttributes, pdwAttributesEx, pAudioFormat?, pVideoFormat?)
      => ComCall(14, this.p, UInt32.Ptr, pdwAttributes, UInt32.Ptr, pdwAttributesEx, WAVEFORMATEX.Ptr, pAudioFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
}
struct IWMDMStorage3 extends IWMDMStorage2 {
    static IID := "{97717EEA-926A-464E-96A4-247B0216026E}"
    GetMetadata(ppMetadata)
      => ComCall(15, this.p, IWMDMMetaData.Ptr, ppMetadata)
    SetMetadata(pMetadata?)
      => ComCall(16, this.p, IWMDMMetaData, pMetadata?)
    CreateEmptyMetadataObject(ppMetadata)
      => ComCall(17, this.p, IWMDMMetaData.Ptr, ppMetadata)
    SetEnumPreference(pMode, pViews?)
      => ComCall(18, this.p, WMDM_STORAGE_ENUM_MODE.Ptr, pMode, UInt32, pViews?.Length ?? 0, WMDMMetadataView.Ptr, pViews?)
}
struct IWMDMStorage4 extends IWMDMStorage3 {
    static IID := "{C225BAC5-A03A-40B8-9A23-91CF478C64A6}"
    SetReferences(ppIWMDMStorage?)
      => ComCall(19, this.p, UInt32, ppIWMDMStorage?.Length ?? 0, IWMDMStorage.Ptr, ppIWMDMStorage?)
    GetReferences(pdwRefs, pppIWMDMStorage)
      => ComCall(20, this.p, UInt32.Ptr, pdwRefs, IWMDMStorage.Ptr.Ptr, pppIWMDMStorage)
    GetRightsWithProgress(pIProgressCallback?, ppRights, pnRightsCount)
      => ComCall(21, this.p, IWMDMProgress3, pIProgressCallback?, WMDMRIGHTS.Ptr.Ptr, ppRights, UInt32.Ptr, pnRightsCount)
    GetSpecifiedMetadata(ppwszPropNames, ppMetadata)
      => ComCall(22, this.p, UInt32, ppwszPropNames.Length, PWSTR.Ptr, ppwszPropNames, IWMDMMetaData.Ptr, ppMetadata)
    FindStorage(findScope, pwszUniqueID, ppStorage)
      => ComCall(23, this.p, WMDM_FIND_SCOPE, findScope, "Str", pwszUniqueID, IWMDMStorage.Ptr, ppStorage)
    GetParent(ppStorage)
      => ComCall(24, this.p, IWMDMStorage.Ptr, ppStorage)
}
struct IWMDMOperation extends IUnknown {
    static IID := "{1DCB3A0B-33ED-11D3-8470-00C04F79DBC0}"
    BeginRead()
      => ComCall(3, this.p)
    BeginWrite()
      => ComCall(4, this.p)
    GetObjectName(pwszName)
      => ComCall(5, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    SetObjectName(pwszName)
      => ComCall(6, this.p, "Str", pwszName, UInt32, pwszName.Length)
    GetObjectAttributes(pdwAttributes, pFormat?)
      => ComCall(7, this.p, UInt32.Ptr, pdwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    SetObjectAttributes(dwAttributes, pFormat?)
      => ComCall(8, this.p, UInt32, dwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    GetObjectTotalSize(pdwSize, pdwSizeHigh)
      => ComCall(9, this.p, UInt32.Ptr, pdwSize, UInt32.Ptr, pdwSizeHigh)
    SetObjectTotalSize(dwSize, dwSizeHigh)
      => ComCall(10, this.p, UInt32, dwSize, UInt32, dwSizeHigh)
    TransferObjectData(pData, abMac)
      => ComCall(11, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length, UInt8.Ptr, abMac)
    End(phCompletionCode, pNewObject?)
      => ComCall(12, this.p, HRESULT.Ptr, phCompletionCode, IUnknown, pNewObject?)
}
struct IWMDMOperation2 extends IWMDMOperation {
    static IID := "{33445B48-7DF7-425C-AD8F-0FC6D82F9F75}"
    SetObjectAttributes2(dwAttributes, dwAttributesEx, pFormat?, pVideoFormat?)
      => ComCall(13, this.p, UInt32, dwAttributes, UInt32, dwAttributesEx, WAVEFORMATEX.Ptr, pFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
    GetObjectAttributes2(pdwAttributes, pdwAttributesEx, pAudioFormat?, pVideoFormat?)
      => ComCall(14, this.p, UInt32.Ptr, pdwAttributes, UInt32.Ptr, pdwAttributesEx, WAVEFORMATEX.Ptr, pAudioFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
}
struct IWMDMOperation3 extends IWMDMOperation {
    static IID := "{D1F9B46A-9CA8-46D8-9D0F-1EC9BAE54919}"
    TransferObjectDataOnClearChannel(pData)
      => ComCall(13, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length)
}
struct IWMDMProgress extends IUnknown {
    static IID := "{1DCB3A0C-33ED-11D3-8470-00C04F79DBC0}"
    Begin(dwEstimatedTicks)
      => ComCall(3, this.p, UInt32, dwEstimatedTicks)
    Progress(dwTranspiredTicks)
      => ComCall(4, this.p, UInt32, dwTranspiredTicks)
    End()
      => ComCall(5, this.p)
}
struct IWMDMProgress2 extends IWMDMProgress {
    static IID := "{3A43F550-B383-4E92-B04A-E6BBC660FEFC}"
    End2(hrCompletionCode)
      => ComCall(6, this.p, HRESULT, hrCompletionCode)
}
struct IWMDMProgress3 extends IWMDMProgress2 {
    static IID := "{21DE01CB-3BB4-4929-B21A-17AF3F80F658}"
    Begin3(EventId, dwEstimatedTicks, pContext?)
      => ComCall(7, this.p, GUID, EventId, UInt32, dwEstimatedTicks, OPAQUECOMMAND.Ptr, pContext?)
    Progress3(EventId, dwTranspiredTicks, pContext?)
      => ComCall(8, this.p, GUID, EventId, UInt32, dwTranspiredTicks, OPAQUECOMMAND.Ptr, pContext?)
    End3(EventId, hrCompletionCode, pContext?)
      => ComCall(9, this.p, GUID, EventId, HRESULT, hrCompletionCode, OPAQUECOMMAND.Ptr, pContext?)
}
struct IWMDMDevice extends IUnknown {
    static IID := "{1DCB3A02-33ED-11D3-8470-00C04F79DBC0}"
    GetName(pwszName)
      => ComCall(3, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetManufacturer(pwszName)
      => ComCall(4, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetVersion(pdwVersion)
      => ComCall(5, this.p, UInt32.Ptr, pdwVersion)
    GetType(pdwType)
      => ComCall(6, this.p, UInt32.Ptr, pdwType)
    GetSerialNumber(pSerialNumber, abMac)
      => ComCall(7, this.p, WMDMID.Ptr, pSerialNumber, UInt8.Ptr, abMac)
    GetPowerSource(pdwPowerSource, pdwPercentRemaining)
      => ComCall(8, this.p, UInt32.Ptr, pdwPowerSource, UInt32.Ptr, pdwPercentRemaining)
    GetStatus(pdwStatus)
      => ComCall(9, this.p, UInt32.Ptr, pdwStatus)
    GetDeviceIcon(hIcon)
      => ComCall(10, this.p, UInt32.Ptr, hIcon)
    EnumStorage(ppEnumStorage)
      => ComCall(11, this.p, IWMDMEnumStorage.Ptr, ppEnumStorage)
    GetFormatSupport(ppFormatEx, pnFormatCount, pppwszMimeType, pnMimeTypeCount)
      => ComCall(12, this.p, WAVEFORMATEX.Ptr.Ptr, ppFormatEx, UInt32.Ptr, pnFormatCount, PWSTR.Ptr.Ptr, pppwszMimeType, UInt32.Ptr, pnMimeTypeCount)
    SendOpaqueCommand(pCommand)
      => ComCall(13, this.p, OPAQUECOMMAND.Ptr, pCommand)
}
struct IWMDMDevice2 extends IWMDMDevice {
    static IID := "{E34F3D37-9D67-4FC1-9252-62D28B2F8B55}"
    GetStorage(pszStorageName, ppStorage)
      => ComCall(14, this.p, "Str", pszStorageName, IWMDMStorage.Ptr, ppStorage)
    GetFormatSupport2(dwFlags, ppAudioFormatEx, pnAudioFormatCount, ppVideoFormatEx, pnVideoFormatCount, ppFileType, pnFileTypeCount)
      => ComCall(15, this.p, UInt32, dwFlags, WAVEFORMATEX.Ptr.Ptr, ppAudioFormatEx, UInt32.Ptr, pnAudioFormatCount, VIDEOINFOHEADER.Ptr.Ptr, ppVideoFormatEx, UInt32.Ptr, pnVideoFormatCount, WMFILECAPABILITIES.Ptr.Ptr, ppFileType, UInt32.Ptr, pnFileTypeCount)
    GetSpecifyPropertyPages(ppSpecifyPropPages, pppUnknowns, pcUnks)
      => ComCall(16, this.p, ISpecifyPropertyPages.Ptr, ppSpecifyPropPages, IUnknown.Ptr.Ptr, pppUnknowns, UInt32.Ptr, pcUnks)
    GetCanonicalName(pwszPnPName)
      => ComCall(17, this.p, PWSTR, pwszPnPName, UInt32, pwszPnPName.Length)
}
struct IWMDMDevice3 extends IWMDMDevice2 {
    static IID := "{6C03E4FE-05DB-4DDA-9E3C-06233A6D5D65}"
    GetProperty(pwszPropName, pValue)
      => ComCall(18, this.p, "Str", pwszPropName, PROPVARIANT.Ptr, pValue)
    SetProperty(pwszPropName, pValue)
      => ComCall(19, this.p, "Str", pwszPropName, PROPVARIANT.Ptr, pValue)
    GetFormatCapability(format, pFormatSupport)
      => ComCall(20, this.p, WMDM_FORMATCODE, format, WMDM_FORMAT_CAPABILITY.Ptr, pFormatSupport)
    DeviceIoControl(dwIoControlCode, lpInBuffer, lpOutBuffer)
      => ComCall(21, this.p, UInt32, dwIoControlCode, UInt8.Ptr, lpInBuffer, UInt32, lpInBuffer.Length, UInt8.Ptr, lpOutBuffer, UInt32.Ptr, lpOutBuffer.Length)
    FindStorage(findScope, pwszUniqueID, ppStorage)
      => ComCall(22, this.p, WMDM_FIND_SCOPE, findScope, "Str", pwszUniqueID, IWMDMStorage.Ptr, ppStorage)
}
struct IWMDMDeviceSession extends IUnknown {
    static IID := "{82AF0A65-9D96-412C-83E5-3C43E4B06CC7}"
    BeginSession(type, pCtx?)
      => ComCall(3, this.p, WMDM_SESSION_TYPE, type, UInt8.Ptr, pCtx?, UInt32, pCtx?.Length ?? 0)
    EndSession(type, pCtx?)
      => ComCall(4, this.p, WMDM_SESSION_TYPE, type, UInt8.Ptr, pCtx?, UInt32, pCtx?.Length ?? 0)
}
struct IWMDMEnumDevice extends IUnknown {
    static IID := "{1DCB3A01-33ED-11D3-8470-00C04F79DBC0}"
    Next(ppDevice, pceltFetched)
      => ComCall(3, this.p, UInt32, ppDevice.Length, IWMDMDevice.Ptr, ppDevice, UInt32.Ptr, pceltFetched)
    Skip(celt, pceltFetched)
      => ComCall(4, this.p, UInt32, celt, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumDevice)
      => ComCall(6, this.p, IWMDMEnumDevice.Ptr, ppEnumDevice)
}
struct IWMDMDeviceControl extends IUnknown {
    static IID := "{1DCB3A04-33ED-11D3-8470-00C04F79DBC0}"
    GetStatus(pdwStatus)
      => ComCall(3, this.p, UInt32.Ptr, pdwStatus)
    GetCapabilities(pdwCapabilitiesMask)
      => ComCall(4, this.p, UInt32.Ptr, pdwCapabilitiesMask)
    Play()
      => ComCall(5, this.p)
    Record(pFormat)
      => ComCall(6, this.p, WAVEFORMATEX.Ptr, pFormat)
    Pause()
      => ComCall(7, this.p)
    Resume()
      => ComCall(8, this.p)
    Stop()
      => ComCall(9, this.p)
    Seek(fuMode, nOffset)
      => ComCall(10, this.p, UInt32, fuMode, Int32, nOffset)
}
struct IWMDMEnumStorage extends IUnknown {
    static IID := "{1DCB3A05-33ED-11D3-8470-00C04F79DBC0}"
    Next(ppStorage, pceltFetched)
      => ComCall(3, this.p, UInt32, ppStorage.Length, IWMDMStorage.Ptr, ppStorage, UInt32.Ptr, pceltFetched)
    Skip(celt, pceltFetched)
      => ComCall(4, this.p, UInt32, celt, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumStorage)
      => ComCall(6, this.p, IWMDMEnumStorage.Ptr, ppEnumStorage)
}
struct IWMDMStorageControl extends IUnknown {
    static IID := "{1DCB3A08-33ED-11D3-8470-00C04F79DBC0}"
    Insert(fuMode, pwszFile?, pOperation?, pProgress?, ppNewObject)
      => ComCall(3, this.p, UInt32, fuMode, "Str", pwszFile?, IWMDMOperation, pOperation?, IWMDMProgress, pProgress?, IWMDMStorage.Ptr, ppNewObject)
    Delete(fuMode, pProgress?)
      => ComCall(4, this.p, UInt32, fuMode, IWMDMProgress, pProgress?)
    Rename(fuMode, pwszNewName, pProgress?)
      => ComCall(5, this.p, UInt32, fuMode, "Str", pwszNewName, IWMDMProgress, pProgress?)
    Read(fuMode, pwszFile?, pProgress?, pOperation?)
      => ComCall(6, this.p, UInt32, fuMode, "Str", pwszFile?, IWMDMProgress, pProgress?, IWMDMOperation, pOperation?)
    Move(fuMode, pTargetObject?, pProgress?)
      => ComCall(7, this.p, UInt32, fuMode, IWMDMStorage, pTargetObject?, IWMDMProgress, pProgress?)
}
struct IWMDMStorageControl2 extends IWMDMStorageControl {
    static IID := "{972C2E88-BD6C-4125-8E09-84F837E637B6}"
    Insert2(fuMode, pwszFileSource?, pwszFileDest?, pOperation?, pProgress?, pUnknown?, ppNewObject?)
      => ComCall(8, this.p, UInt32, fuMode, "Str", pwszFileSource?, "Str", pwszFileDest?, IWMDMOperation, pOperation?, IWMDMProgress, pProgress?, IUnknown, pUnknown?, IWMDMStorage.Ptr, ppNewObject?)
}
struct IWMDMStorageControl3 extends IWMDMStorageControl2 {
    static IID := "{B3266365-D4F3-4696-8D53-BD27EC60993A}"
    Insert3(fuMode, fuType, pwszFileSource?, pwszFileDest?, pOperation?, pProgress?, pMetaData?, pUnknown?, ppNewObject?)
      => ComCall(9, this.p, UInt32, fuMode, UInt32, fuType, "Str", pwszFileSource?, "Str", pwszFileDest?, IWMDMOperation, pOperation?, IWMDMProgress, pProgress?, IWMDMMetaData, pMetaData?, IUnknown, pUnknown?, IWMDMStorage.Ptr, ppNewObject?)
}
struct IWMDMObjectInfo extends IUnknown {
    static IID := "{1DCB3A09-33ED-11D3-8470-00C04F79DBC0}"
    GetPlayLength(pdwLength)
      => ComCall(3, this.p, UInt32.Ptr, pdwLength)
    SetPlayLength(dwLength)
      => ComCall(4, this.p, UInt32, dwLength)
    GetPlayOffset(pdwOffset)
      => ComCall(5, this.p, UInt32.Ptr, pdwOffset)
    SetPlayOffset(dwOffset)
      => ComCall(6, this.p, UInt32, dwOffset)
    GetTotalLength(pdwLength)
      => ComCall(7, this.p, UInt32.Ptr, pdwLength)
    GetLastPlayPosition(pdwLastPos)
      => ComCall(8, this.p, UInt32.Ptr, pdwLastPos)
    GetLongestPlayPosition(pdwLongestPos)
      => ComCall(9, this.p, UInt32.Ptr, pdwLongestPos)
}
struct IWMDMRevoked extends IUnknown {
    static IID := "{EBECCEDB-88EE-4E55-B6A4-8D9F07D696AA}"
    GetRevocationURL(ppwszRevocationURL, pdwRevokedBitFlag)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszRevocationURL, UInt32.Ptr, ppwszRevocationURL.Length, UInt32.Ptr, pdwRevokedBitFlag)
}
struct IWMDMNotification extends IUnknown {
    static IID := "{3F5E95C0-0F43-4ED4-93D2-C89A45D59B81}"
    WMDMMessage(dwMessageType, pwszCanonicalName)
      => ComCall(3, this.p, UInt32, dwMessageType, "Str", pwszCanonicalName)
}
struct WMDMDetermineMaxPropStringLen {
    union {
        sz001 : UInt16[27]
        sz002 : UInt16[31]
        sz003 : UInt16[14]
        sz004 : UInt16[16]
        sz005 : UInt16[22]
        sz006 : UInt16[14]
        sz007 : UInt16[20]
        sz008 : UInt16[20]
        sz009 : UInt16[22]
        sz010 : UInt16[11]
        sz011 : UInt16[12]
        sz012 : UInt16[17]
        sz013 : UInt16[17]
        sz014 : UInt16[16]
        sz015 : UInt16[17]
        sz016 : UInt16[11]
        sz017 : UInt16[11]
        sz018 : UInt16[15]
        sz019 : UInt16[22]
        sz020 : UInt16[20]
        sz021 : UInt16[22]
        sz022 : UInt16[21]
        sz023 : UInt16[24]
        sz024 : UInt16[20]
        sz025 : UInt16[10]
        sz026 : UInt16[14]
        sz027 : UInt16[11]
        sz028 : UInt16[11]
        sz029 : UInt16[13]
        sz030 : UInt16[17]
        sz031 : UInt16[16]
        sz032 : UInt16[17]
        sz033 : UInt16[20]
        sz034 : UInt16[19]
        sz035 : UInt16[18]
        sz036 : UInt16[18]
        sz037 : UInt16[15]
        sz041 : UInt16[14]
        sz043 : UInt16[22]
        sz044 : UInt16[16]
        sz045 : UInt16[20]
        sz046 : UInt16[14]
        sz047 : UInt16[14]
        sz048 : UInt16[12]
        sz049 : UInt16[25]
        sz050 : UInt16[26]
        sz051 : UInt16[25]
        sz052 : UInt16[16]
        sz053 : UInt16[24]
        sz054 : UInt16[15]
        sz055 : UInt16[21]
        sz056 : UInt16[16]
        sz057 : UInt16[22]
        sz058 : UInt16[14]
        sz059 : UInt16[25]
        sz060 : UInt16[18]
        sz061 : UInt16[22]
        sz062 : UInt16[26]
        sz063 : UInt16[36]
        sz064 : UInt16[23]
        sz065 : UInt16[12]
        sz066 : UInt16[24]
        sz067 : UInt16[11]
        sz068 : UInt16[12]
        sz069 : UInt16[14]
        sz070 : UInt16[20]
        sz071 : UInt16[15]
        sz072 : UInt16[14]
        sz073 : UInt16[31]
        sz074 : UInt16[24]
        sz075 : UInt16[22]
        sz076 : UInt16[24]
        sz077 : UInt16[21]
        sz078 : UInt16[27]
        sz079 : UInt16[27]
        sz080 : UInt16[20]
        sz081 : UInt16[33]
        sz082 : UInt16[21]
        sz083 : UInt16[32]
        sz084 : UInt16[26]
        sz085 : UInt16[18]
        sz086 : UInt16[30]
    }
}
struct IMDServiceProvider extends IUnknown {
    static IID := "{1DCB3A10-33ED-11D3-8470-00C04F79DBC0}"
    GetDeviceCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    EnumDevices(ppEnumDevice)
      => ComCall(4, this.p, IMDSPEnumDevice.Ptr, ppEnumDevice)
}
struct IMDServiceProvider2 extends IMDServiceProvider {
    static IID := "{B2FA24B7-CDA3-4694-9862-413AE1A34819}"
    CreateDevice(pwszDevicePath, pdwCount, pppDeviceArray)
      => ComCall(5, this.p, "Str", pwszDevicePath, UInt32.Ptr, pdwCount, IMDSPDevice.Ptr.Ptr, pppDeviceArray)
}
struct IMDServiceProvider3 extends IMDServiceProvider2 {
    static IID := "{4ED13EF3-A971-4D19-9F51-0E1826B2DA57}"
    SetDeviceEnumPreference(dwEnumPref)
      => ComCall(6, this.p, UInt32, dwEnumPref)
}
struct IMDSPEnumDevice extends IUnknown {
    static IID := "{1DCB3A11-33ED-11D3-8470-00C04F79DBC0}"
    Next(ppDevice, pceltFetched)
      => ComCall(3, this.p, UInt32, ppDevice.Length, IMDSPDevice.Ptr, ppDevice, UInt32.Ptr, pceltFetched)
    Skip(celt, pceltFetched)
      => ComCall(4, this.p, UInt32, celt, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumDevice)
      => ComCall(6, this.p, IMDSPEnumDevice.Ptr, ppEnumDevice)
}
struct IMDSPDevice extends IUnknown {
    static IID := "{1DCB3A12-33ED-11D3-8470-00C04F79DBC0}"
    GetName(pwszName)
      => ComCall(3, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetManufacturer(pwszName)
      => ComCall(4, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetVersion(pdwVersion)
      => ComCall(5, this.p, UInt32.Ptr, pdwVersion)
    GetType(pdwType)
      => ComCall(6, this.p, UInt32.Ptr, pdwType)
    GetSerialNumber(pSerialNumber, abMac)
      => ComCall(7, this.p, WMDMID.Ptr, pSerialNumber, UInt8.Ptr, abMac)
    GetPowerSource(pdwPowerSource, pdwPercentRemaining)
      => ComCall(8, this.p, UInt32.Ptr, pdwPowerSource, UInt32.Ptr, pdwPercentRemaining)
    GetStatus(pdwStatus)
      => ComCall(9, this.p, UInt32.Ptr, pdwStatus)
    GetDeviceIcon(hIcon)
      => ComCall(10, this.p, UInt32.Ptr, hIcon)
    EnumStorage(ppEnumStorage)
      => ComCall(11, this.p, IMDSPEnumStorage.Ptr, ppEnumStorage)
    GetFormatSupport(pFormatEx, pnFormatCount, pppwszMimeType, pnMimeTypeCount)
      => ComCall(12, this.p, WAVEFORMATEX.Ptr.Ptr, pFormatEx, UInt32.Ptr, pnFormatCount, PWSTR.Ptr.Ptr, pppwszMimeType, UInt32.Ptr, pnMimeTypeCount)
    SendOpaqueCommand(pCommand)
      => ComCall(13, this.p, OPAQUECOMMAND.Ptr, pCommand)
}
struct IMDSPDevice2 extends IMDSPDevice {
    static IID := "{420D16AD-C97D-4E00-82AA-00E9F4335DDD}"
    GetStorage(pszStorageName, ppStorage)
      => ComCall(14, this.p, "Str", pszStorageName, IMDSPStorage.Ptr, ppStorage)
    GetFormatSupport2(dwFlags, ppAudioFormatEx, pnAudioFormatCount, ppVideoFormatEx, pnVideoFormatCount, ppFileType, pnFileTypeCount)
      => ComCall(15, this.p, UInt32, dwFlags, WAVEFORMATEX.Ptr.Ptr, ppAudioFormatEx, UInt32.Ptr, pnAudioFormatCount, VIDEOINFOHEADER.Ptr.Ptr, ppVideoFormatEx, UInt32.Ptr, pnVideoFormatCount, WMFILECAPABILITIES.Ptr.Ptr, ppFileType, UInt32.Ptr, pnFileTypeCount)
    GetSpecifyPropertyPages(ppSpecifyPropPages, pppUnknowns, pcUnks)
      => ComCall(16, this.p, ISpecifyPropertyPages.Ptr, ppSpecifyPropPages, IUnknown.Ptr.Ptr, pppUnknowns, UInt32.Ptr, pcUnks)
    GetCanonicalName(pwszPnPName)
      => ComCall(17, this.p, PWSTR, pwszPnPName, UInt32, pwszPnPName.Length)
}
struct IMDSPDevice3 extends IMDSPDevice2 {
    static IID := "{1A839845-FC55-487C-976F-EE38AC0E8C4E}"
    GetProperty(pwszPropName, pValue)
      => ComCall(18, this.p, "Str", pwszPropName, PROPVARIANT.Ptr, pValue)
    SetProperty(pwszPropName, pValue)
      => ComCall(19, this.p, "Str", pwszPropName, PROPVARIANT.Ptr, pValue)
    GetFormatCapability(format, pFormatSupport)
      => ComCall(20, this.p, WMDM_FORMATCODE, format, WMDM_FORMAT_CAPABILITY.Ptr, pFormatSupport)
    DeviceIoControl(dwIoControlCode, lpInBuffer, lpOutBuffer)
      => ComCall(21, this.p, UInt32, dwIoControlCode, UInt8.Ptr, lpInBuffer, UInt32, lpInBuffer.Length, UInt8.Ptr, lpOutBuffer, UInt32.Ptr, lpOutBuffer.Length)
    FindStorage(findScope, pwszUniqueID, ppStorage)
      => ComCall(22, this.p, WMDM_FIND_SCOPE, findScope, "Str", pwszUniqueID, IMDSPStorage.Ptr, ppStorage)
}
struct IMDSPDeviceControl extends IUnknown {
    static IID := "{1DCB3A14-33ED-11D3-8470-00C04F79DBC0}"
    GetDCStatus(pdwStatus)
      => ComCall(3, this.p, UInt32.Ptr, pdwStatus)
    GetCapabilities(pdwCapabilitiesMask)
      => ComCall(4, this.p, UInt32.Ptr, pdwCapabilitiesMask)
    Play()
      => ComCall(5, this.p)
    Record(pFormat)
      => ComCall(6, this.p, WAVEFORMATEX.Ptr, pFormat)
    Pause()
      => ComCall(7, this.p)
    Resume()
      => ComCall(8, this.p)
    Stop()
      => ComCall(9, this.p)
    Seek(fuMode, nOffset)
      => ComCall(10, this.p, UInt32, fuMode, Int32, nOffset)
}
struct IMDSPEnumStorage extends IUnknown {
    static IID := "{1DCB3A15-33ED-11D3-8470-00C04F79DBC0}"
    Next(ppStorage, pceltFetched)
      => ComCall(3, this.p, UInt32, ppStorage.Length, IMDSPStorage.Ptr, ppStorage, UInt32.Ptr, pceltFetched)
    Skip(celt, pceltFetched)
      => ComCall(4, this.p, UInt32, celt, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumStorage)
      => ComCall(6, this.p, IMDSPEnumStorage.Ptr, ppEnumStorage)
}
struct IMDSPStorage extends IUnknown {
    static IID := "{1DCB3A16-33ED-11D3-8470-00C04F79DBC0}"
    SetAttributes(dwAttributes, pFormat?)
      => ComCall(3, this.p, UInt32, dwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    GetStorageGlobals(ppStorageGlobals)
      => ComCall(4, this.p, IMDSPStorageGlobals.Ptr, ppStorageGlobals)
    GetAttributes(pdwAttributes, pFormat?)
      => ComCall(5, this.p, UInt32.Ptr, pdwAttributes, WAVEFORMATEX.Ptr, pFormat?)
    GetName(pwszName)
      => ComCall(6, this.p, PWSTR, pwszName, UInt32, pwszName.Length)
    GetDate(pDateTimeUTC)
      => ComCall(7, this.p, WMDMDATETIME.Ptr, pDateTimeUTC)
    GetSize(pdwSizeLow, pdwSizeHigh)
      => ComCall(8, this.p, UInt32.Ptr, pdwSizeLow, UInt32.Ptr, pdwSizeHigh)
    GetRights(ppRights, pnRightsCount, abMac)
      => ComCall(9, this.p, WMDMRIGHTS.Ptr.Ptr, ppRights, UInt32.Ptr, pnRightsCount, UInt8.Ptr, abMac)
    CreateStorage(dwAttributes, pFormat?, pwszName, ppNewStorage)
      => ComCall(10, this.p, UInt32, dwAttributes, WAVEFORMATEX.Ptr, pFormat?, "Str", pwszName, IMDSPStorage.Ptr, ppNewStorage)
    EnumStorage(ppEnumStorage)
      => ComCall(11, this.p, IMDSPEnumStorage.Ptr, ppEnumStorage)
    SendOpaqueCommand(pCommand)
      => ComCall(12, this.p, OPAQUECOMMAND.Ptr, pCommand)
}
struct IMDSPStorage2 extends IMDSPStorage {
    static IID := "{0A5E07A5-6454-4451-9C36-1C6AE7E2B1D6}"
    GetStorage(pszStorageName, ppStorage)
      => ComCall(13, this.p, "Str", pszStorageName, IMDSPStorage.Ptr, ppStorage)
    CreateStorage2(dwAttributes, dwAttributesEx, pAudioFormat?, pVideoFormat?, pwszName, qwFileSize, ppNewStorage)
      => ComCall(14, this.p, UInt32, dwAttributes, UInt32, dwAttributesEx, WAVEFORMATEX.Ptr, pAudioFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?, "Str", pwszName, Int64, qwFileSize, IMDSPStorage.Ptr, ppNewStorage)
    SetAttributes2(dwAttributes, dwAttributesEx, pAudioFormat?, pVideoFormat?)
      => ComCall(15, this.p, UInt32, dwAttributes, UInt32, dwAttributesEx, WAVEFORMATEX.Ptr, pAudioFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
    GetAttributes2(pdwAttributes, pdwAttributesEx, pAudioFormat?, pVideoFormat?)
      => ComCall(16, this.p, UInt32.Ptr, pdwAttributes, UInt32.Ptr, pdwAttributesEx, WAVEFORMATEX.Ptr, pAudioFormat?, VIDEOINFOHEADER.Ptr, pVideoFormat?)
}
struct IMDSPStorage3 extends IMDSPStorage2 {
    static IID := "{6C669867-97ED-4A67-9706-1C5529D2A414}"
    GetMetadata(pMetadata?)
      => ComCall(17, this.p, IWMDMMetaData, pMetadata?)
    SetMetadata(pMetadata?)
      => ComCall(18, this.p, IWMDMMetaData, pMetadata?)
}
struct IMDSPStorage4 extends IMDSPStorage3 {
    static IID := "{3133B2C4-515C-481B-B1CE-39327ECB4F74}"
    SetReferences(ppISPStorage?)
      => ComCall(19, this.p, UInt32, ppISPStorage?.Length ?? 0, IMDSPStorage.Ptr, ppISPStorage?)
    GetReferences(pdwRefs, pppISPStorage)
      => ComCall(20, this.p, UInt32.Ptr, pdwRefs, IMDSPStorage.Ptr.Ptr, pppISPStorage)
    CreateStorageWithMetadata(dwAttributes, pwszName, pMetadata?, qwFileSize, ppNewStorage)
      => ComCall(21, this.p, UInt32, dwAttributes, "Str", pwszName, IWMDMMetaData, pMetadata?, Int64, qwFileSize, IMDSPStorage.Ptr, ppNewStorage)
    GetSpecifiedMetadata(ppwszPropNames, pMetadata?)
      => ComCall(22, this.p, UInt32, ppwszPropNames.Length, PWSTR.Ptr, ppwszPropNames, IWMDMMetaData, pMetadata?)
    FindStorage(findScope, pwszUniqueID, ppStorage)
      => ComCall(23, this.p, WMDM_FIND_SCOPE, findScope, "Str", pwszUniqueID, IMDSPStorage.Ptr, ppStorage)
    GetParent(ppStorage)
      => ComCall(24, this.p, IMDSPStorage.Ptr, ppStorage)
}
struct IMDSPStorageGlobals extends IUnknown {
    static IID := "{1DCB3A17-33ED-11D3-8470-00C04F79DBC0}"
    GetCapabilities(pdwCapabilities)
      => ComCall(3, this.p, UInt32.Ptr, pdwCapabilities)
    GetSerialNumber(pSerialNum, abMac)
      => ComCall(4, this.p, WMDMID.Ptr, pSerialNum, UInt8.Ptr, abMac)
    GetTotalSize(pdwTotalSizeLow, pdwTotalSizeHigh)
      => ComCall(5, this.p, UInt32.Ptr, pdwTotalSizeLow, UInt32.Ptr, pdwTotalSizeHigh)
    GetTotalFree(pdwFreeLow, pdwFreeHigh)
      => ComCall(6, this.p, UInt32.Ptr, pdwFreeLow, UInt32.Ptr, pdwFreeHigh)
    GetTotalBad(pdwBadLow, pdwBadHigh)
      => ComCall(7, this.p, UInt32.Ptr, pdwBadLow, UInt32.Ptr, pdwBadHigh)
    GetStatus(pdwStatus)
      => ComCall(8, this.p, UInt32.Ptr, pdwStatus)
    Initialize(fuMode, pProgress?)
      => ComCall(9, this.p, UInt32, fuMode, IWMDMProgress, pProgress?)
    GetDevice(ppDevice)
      => ComCall(10, this.p, IMDSPDevice.Ptr, ppDevice)
    GetRootStorage(ppRoot)
      => ComCall(11, this.p, IMDSPStorage.Ptr, ppRoot)
}
struct IMDSPObjectInfo extends IUnknown {
    static IID := "{1DCB3A19-33ED-11D3-8470-00C04F79DBC0}"
    GetPlayLength(pdwLength)
      => ComCall(3, this.p, UInt32.Ptr, pdwLength)
    SetPlayLength(dwLength)
      => ComCall(4, this.p, UInt32, dwLength)
    GetPlayOffset(pdwOffset)
      => ComCall(5, this.p, UInt32.Ptr, pdwOffset)
    SetPlayOffset(dwOffset)
      => ComCall(6, this.p, UInt32, dwOffset)
    GetTotalLength(pdwLength)
      => ComCall(7, this.p, UInt32.Ptr, pdwLength)
    GetLastPlayPosition(pdwLastPos)
      => ComCall(8, this.p, UInt32.Ptr, pdwLastPos)
    GetLongestPlayPosition(pdwLongestPos)
      => ComCall(9, this.p, UInt32.Ptr, pdwLongestPos)
}
struct IMDSPObject extends IUnknown {
    static IID := "{1DCB3A18-33ED-11D3-8470-00C04F79DBC0}"
    Open(fuMode)
      => ComCall(3, this.p, UInt32, fuMode)
    Read(pData, abMac)
      => ComCall(4, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length, UInt8.Ptr, abMac)
    Write(pData, abMac)
      => ComCall(5, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length, UInt8.Ptr, abMac)
    Delete(fuMode, pProgress?)
      => ComCall(6, this.p, UInt32, fuMode, IWMDMProgress, pProgress?)
    Seek(fuFlags, dwOffset)
      => ComCall(7, this.p, UInt32, fuFlags, UInt32, dwOffset)
    Rename(pwszNewName, pProgress?)
      => ComCall(8, this.p, "Str", pwszNewName, IWMDMProgress, pProgress?)
    Move(fuMode, pProgress?, pTarget?)
      => ComCall(9, this.p, UInt32, fuMode, IWMDMProgress, pProgress?, IMDSPStorage, pTarget?)
    Close()
      => ComCall(10, this.p)
}
struct IMDSPObject2 extends IMDSPObject {
    static IID := "{3F34CD3E-5907-4341-9AF9-97F4187C3AA5}"
    ReadOnClearChannel(pData)
      => ComCall(11, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length)
    WriteOnClearChannel(pData)
      => ComCall(12, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length)
}
struct IMDSPDirectTransfer extends IUnknown {
    static IID := "{C2FE57A8-9304-478C-9EE4-47E397B912D7}"
    TransferToDevice(pwszSourceFilePath?, pSourceOperation?, fuFlags, pwszDestinationName?, pSourceMetaData?, pTransferProgress?, ppNewObject)
      => ComCall(3, this.p, "Str", pwszSourceFilePath?, IWMDMOperation, pSourceOperation?, UInt32, fuFlags, "Str", pwszDestinationName?, IWMDMMetaData, pSourceMetaData?, IWMDMProgress, pTransferProgress?, IMDSPStorage.Ptr, ppNewObject)
}
struct IMDSPRevoked extends IUnknown {
    static IID := "{A4E8F2D4-3F31-464D-B53D-4FC335998184}"
    GetRevocationURL(ppwszRevocationURL)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszRevocationURL, UInt32.Ptr, ppwszRevocationURL.Length)
}
struct ISCPSecureAuthenticate extends IUnknown {
    static IID := "{1DCB3A0F-33ED-11D3-8470-00C04F79DBC0}"
    GetSecureQuery(ppSecureQuery)
      => ComCall(3, this.p, ISCPSecureQuery.Ptr, ppSecureQuery)
}
struct ISCPSecureAuthenticate2 extends ISCPSecureAuthenticate {
    static IID := "{B580CFAE-1672-47E2-ACAA-44BBECBCAE5B}"
    GetSCPSession(ppSCPSession)
      => ComCall(4, this.p, ISCPSession.Ptr, ppSCPSession)
}
struct ISCPSecureQuery extends IUnknown {
    static IID := "{1DCB3A0D-33ED-11D3-8470-00C04F79DBC0}"
    GetDataDemands(pfuFlags, pdwMinRightsData, pdwMinExamineData, pdwMinDecideData, abMac)
      => ComCall(3, this.p, UInt32.Ptr, pfuFlags, UInt32.Ptr, pdwMinRightsData, UInt32.Ptr, pdwMinExamineData, UInt32.Ptr, pdwMinDecideData, UInt8.Ptr, abMac)
    ExamineData(fuFlags, pwszExtension?, pData, abMac)
      => ComCall(4, this.p, UInt32, fuFlags, "Str", pwszExtension?, UInt8.Ptr, pData, UInt32, pData.Length, UInt8.Ptr, abMac)
    MakeDecision(fuFlags, pData, dwAppSec, pbSPSessionKey, pStorageGlobals?, ppExchange, abMac)
      => ComCall(5, this.p, UInt32, fuFlags, UInt8.Ptr, pData, UInt32, pData.Length, UInt32, dwAppSec, UInt8.Ptr, pbSPSessionKey, UInt32, pbSPSessionKey.Length, IMDSPStorageGlobals, pStorageGlobals?, ISCPSecureExchange.Ptr, ppExchange, UInt8.Ptr, abMac)
    GetRights(pData, pbSPSessionKey, pStgGlobals?, ppRights, pnRightsCount, abMac)
      => ComCall(6, this.p, UInt8.Ptr, pData, UInt32, pData.Length, UInt8.Ptr, pbSPSessionKey, UInt32, pbSPSessionKey.Length, IMDSPStorageGlobals, pStgGlobals?, WMDMRIGHTS.Ptr.Ptr, ppRights, UInt32.Ptr, pnRightsCount, UInt8.Ptr, abMac)
}
struct ISCPSecureQuery2 extends ISCPSecureQuery {
    static IID := "{EBE17E25-4FD7-4632-AF46-6D93D4FCC72E}"
    MakeDecision2(fuFlags, pData, dwAppSec, pbSPSessionKey, pStorageGlobals?, pAppCertApp, pAppCertSP, pszRevocationURL, pdwRevocationBitFlag, pqwFileSize?, pUnknown?, ppExchange, abMac)
      => ComCall(7, this.p, UInt32, fuFlags, UInt8.Ptr, pData, UInt32, pData.Length, UInt32, dwAppSec, UInt8.Ptr, pbSPSessionKey, UInt32, pbSPSessionKey.Length, IMDSPStorageGlobals, pStorageGlobals?, UInt8.Ptr, pAppCertApp, UInt32, pAppCertApp.Length, UInt8.Ptr, pAppCertSP, UInt32, pAppCertSP.Length, PWSTR.Ptr, pszRevocationURL, UInt32.Ptr, pszRevocationURL.Length, UInt32.Ptr, pdwRevocationBitFlag, Int64.Ptr, pqwFileSize?, IUnknown, pUnknown?, ISCPSecureExchange.Ptr, ppExchange, UInt8.Ptr, abMac)
}
struct ISCPSecureExchange extends IUnknown {
    static IID := "{1DCB3A0E-33ED-11D3-8470-00C04F79DBC0}"
    TransferContainerData(pData, pfuReadyFlags, abMac)
      => ComCall(3, this.p, UInt8.Ptr, pData, UInt32, pData.Length, UInt32.Ptr, pfuReadyFlags, UInt8.Ptr, abMac)
    ObjectData(pData, abMac)
      => ComCall(4, this.p, UInt8.Ptr, pData, UInt32.Ptr, pData.Length, UInt8.Ptr, abMac)
    TransferComplete()
      => ComCall(5, this.p)
}
struct ISCPSecureExchange2 extends ISCPSecureExchange {
    static IID := "{6C62FC7B-2690-483F-9D44-0A20CB35577C}"
    TransferContainerData2(pData, pProgressCallback?, pfuReadyFlags, abMac)
      => ComCall(6, this.p, UInt8.Ptr, pData, UInt32, pData.Length, IWMDMProgress3, pProgressCallback?, UInt32.Ptr, pfuReadyFlags, UInt8.Ptr, abMac)
}
struct ISCPSecureExchange3 extends ISCPSecureExchange2 {
    static IID := "{AB4E77E4-8908-4B17-BD2A-B1DBE6DD69E1}"
    TransferContainerDataOnClearChannel(pDevice?, pData, pProgressCallback?, pfuReadyFlags)
      => ComCall(7, this.p, IMDSPDevice, pDevice?, UInt8.Ptr, pData, UInt32, pData.Length, IWMDMProgress3, pProgressCallback?, UInt32.Ptr, pfuReadyFlags)
    GetObjectDataOnClearChannel(pDevice?, pData)
      => ComCall(8, this.p, IMDSPDevice, pDevice?, UInt8.Ptr, pData, UInt32.Ptr, pData.Length)
    TransferCompleteForDevice(pDevice?)
      => ComCall(9, this.p, IMDSPDevice, pDevice?)
}
struct ISCPSession extends IUnknown {
    static IID := "{88A3E6ED-EEE4-4619-BBB3-FD4FB62715D1}"
    BeginSession(pIDevice?, pCtx)
      => ComCall(3, this.p, IMDSPDevice, pIDevice?, UInt8.Ptr, pCtx, UInt32, pCtx.Length)
    EndSession(pCtx)
      => ComCall(4, this.p, UInt8.Ptr, pCtx, UInt32, pCtx.Length)
    GetSecureQuery(ppSecureQuery)
      => ComCall(5, this.p, ISCPSecureQuery.Ptr, ppSecureQuery)
}
struct ISCPSecureQuery3 extends ISCPSecureQuery2 {
    static IID := "{B7EDD1A2-4DAB-484B-B3C5-AD39B8B4C0B1}"
    GetRightsOnClearChannel(pData, pbSPSessionKey, pStgGlobals?, pProgressCallback?, ppRights, pnRightsCount)
      => ComCall(8, this.p, UInt8.Ptr, pData, UInt32, pData.Length, UInt8.Ptr, pbSPSessionKey, UInt32, pbSPSessionKey.Length, IMDSPStorageGlobals, pStgGlobals?, IWMDMProgress3, pProgressCallback?, WMDMRIGHTS.Ptr.Ptr, ppRights, UInt32.Ptr, pnRightsCount)
    MakeDecisionOnClearChannel(fuFlags, pData, dwAppSec, pbSPSessionKey, pStorageGlobals?, pProgressCallback?, pAppCertApp, pAppCertSP, pszRevocationURL, pdwRevocationBitFlag, pqwFileSize?, pUnknown?, ppExchange)
      => ComCall(9, this.p, UInt32, fuFlags, UInt8.Ptr, pData, UInt32, pData.Length, UInt32, dwAppSec, UInt8.Ptr, pbSPSessionKey, UInt32, pbSPSessionKey.Length, IMDSPStorageGlobals, pStorageGlobals?, IWMDMProgress3, pProgressCallback?, UInt8.Ptr, pAppCertApp, UInt32, pAppCertApp.Length, UInt8.Ptr, pAppCertSP, UInt32, pAppCertSP.Length, PWSTR.Ptr, pszRevocationURL, UInt32.Ptr, pszRevocationURL.Length, UInt32.Ptr, pdwRevocationBitFlag, Int64.Ptr, pqwFileSize?, IUnknown, pUnknown?, ISCPSecureExchange.Ptr, ppExchange)
}
struct IComponentAuthenticate extends IUnknown {
    static IID := "{A9889C00-6D2B-11D3-8496-00C04F79DBC0}"
    SACAuth(dwProtocolID, dwPass, pbDataIn, ppbDataOut, pdwDataOutLen)
      => ComCall(3, this.p, UInt32, dwProtocolID, UInt32, dwPass, UInt8.Ptr, pbDataIn, UInt32, pbDataIn.Length, UInt8.Ptr.Ptr, ppbDataOut, UInt32.Ptr, pdwDataOutLen)
    SACGetProtocols(ppdwProtocols, pdwProtocolCount)
      => ComCall(4, this.p, UInt32.Ptr.Ptr, ppdwProtocols, UInt32.Ptr, pdwProtocolCount)
}
struct IWMDMLogger extends IUnknown {
    static IID := "{110A3200-5A79-11D3-8D78-444553540000}"
    IsEnabled(pfEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pfEnabled)
    Enable(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
    GetLogFileName(pszFilename, nMaxChars)
      => ComCall(5, this.p, PSTR, pszFilename, UInt32, nMaxChars)
    SetLogFileName(pszFilename)
      => ComCall(6, this.p, PSTR, pszFilename)
    LogString(dwFlags, pszSrcName, pszLog)
      => ComCall(7, this.p, UInt32, dwFlags, PSTR, pszSrcName, PSTR, pszLog)
    LogDword(dwFlags, pszSrcName, pszLogFormat, dwLog)
      => ComCall(8, this.p, UInt32, dwFlags, PSTR, pszSrcName, PSTR, pszLogFormat, UInt32, dwLog)
    Reset()
      => ComCall(9, this.p)
    GetSizeParams(pdwMaxSize, pdwShrinkToSize)
      => ComCall(10, this.p, UInt32.Ptr, pdwMaxSize, UInt32.Ptr, pdwShrinkToSize)
    SetSizeParams(dwMaxSize, dwShrinkToSize)
      => ComCall(11, this.p, UInt32, dwMaxSize, UInt32, dwShrinkToSize)
}
struct MTP_COMMAND_DATA_IN {
    OpCode : UInt16
    NumParams : UInt32
    Params : UInt32[5]
    NextPhase : UInt32
    CommandWriteDataSize : UInt32
    CommandWriteData : UInt8[1]
}
struct MTP_COMMAND_DATA_OUT {
    ResponseCode : UInt16
    NumParams : UInt32
    Params : UInt32[5]
    CommandReadDataSize : UInt32
    CommandReadData : UInt8[1]
}
