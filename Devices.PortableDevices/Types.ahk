#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.Properties\Types.ahk" {DEVPROPTYPE}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, DEVPROPKEY, HRESULT, PROPERTYKEY, PWSTR}
#Import "..\System.Com\Types.ahk" {IDispatch, IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct DELETE_OBJECT_OPTIONS extends Int32 {
    static PORTABLE_DEVICE_DELETE_NO_RECURSION := 0
    static PORTABLE_DEVICE_DELETE_WITH_RECURSION := 1
}
struct WPD_DEVICE_TYPES extends Int32 {
    static WPD_DEVICE_TYPE_GENERIC := 0
    static WPD_DEVICE_TYPE_CAMERA := 1
    static WPD_DEVICE_TYPE_MEDIA_PLAYER := 2
    static WPD_DEVICE_TYPE_PHONE := 3
    static WPD_DEVICE_TYPE_VIDEO := 4
    static WPD_DEVICE_TYPE_PERSONAL_INFORMATION_MANAGER := 5
    static WPD_DEVICE_TYPE_AUDIO_RECORDER := 6
}
struct WpdAttributeForm extends Int32 {
    static WPD_PROPERTY_ATTRIBUTE_FORM_UNSPECIFIED := 0
    static WPD_PROPERTY_ATTRIBUTE_FORM_RANGE := 1
    static WPD_PROPERTY_ATTRIBUTE_FORM_ENUMERATION := 2
    static WPD_PROPERTY_ATTRIBUTE_FORM_REGULAR_EXPRESSION := 3
    static WPD_PROPERTY_ATTRIBUTE_FORM_OBJECT_IDENTIFIER := 4
}
struct WpdParameterAttributeForm extends Int32 {
    static WPD_PARAMETER_ATTRIBUTE_FORM_UNSPECIFIED := 0
    static WPD_PARAMETER_ATTRIBUTE_FORM_RANGE := 1
    static WPD_PARAMETER_ATTRIBUTE_FORM_ENUMERATION := 2
    static WPD_PARAMETER_ATTRIBUTE_FORM_REGULAR_EXPRESSION := 3
    static WPD_PARAMETER_ATTRIBUTE_FORM_OBJECT_IDENTIFIER := 4
}
struct WPD_DEVICE_TRANSPORTS extends Int32 {
    static WPD_DEVICE_TRANSPORT_UNSPECIFIED := 0
    static WPD_DEVICE_TRANSPORT_USB := 1
    static WPD_DEVICE_TRANSPORT_IP := 2
    static WPD_DEVICE_TRANSPORT_BLUETOOTH := 3
}
struct WPD_STORAGE_TYPE_VALUES extends Int32 {
    static WPD_STORAGE_TYPE_UNDEFINED := 0
    static WPD_STORAGE_TYPE_FIXED_ROM := 1
    static WPD_STORAGE_TYPE_REMOVABLE_ROM := 2
    static WPD_STORAGE_TYPE_FIXED_RAM := 3
    static WPD_STORAGE_TYPE_REMOVABLE_RAM := 4
}
struct WPD_STORAGE_ACCESS_CAPABILITY_VALUES extends Int32 {
    static WPD_STORAGE_ACCESS_CAPABILITY_READWRITE := 0
    static WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITHOUT_OBJECT_DELETION := 1
    static WPD_STORAGE_ACCESS_CAPABILITY_READ_ONLY_WITH_OBJECT_DELETION := 2
}
struct WPD_SMS_ENCODING_TYPES extends Int32 {
    static SMS_ENCODING_7_BIT := 0
    static SMS_ENCODING_8_BIT := 1
    static SMS_ENCODING_UTF_16 := 2
}
struct SMS_MESSAGE_TYPES extends Int32 {
    static SMS_TEXT_MESSAGE := 0
    static SMS_BINARY_MESSAGE := 1
}
struct WPD_POWER_SOURCES extends Int32 {
    static WPD_POWER_SOURCE_BATTERY := 0
    static WPD_POWER_SOURCE_EXTERNAL := 1
}
struct WPD_WHITE_BALANCE_SETTINGS extends Int32 {
    static WPD_WHITE_BALANCE_UNDEFINED := 0
    static WPD_WHITE_BALANCE_MANUAL := 1
    static WPD_WHITE_BALANCE_AUTOMATIC := 2
    static WPD_WHITE_BALANCE_ONE_PUSH_AUTOMATIC := 3
    static WPD_WHITE_BALANCE_DAYLIGHT := 4
    static WPD_WHITE_BALANCE_FLORESCENT := 5
    static WPD_WHITE_BALANCE_TUNGSTEN := 6
    static WPD_WHITE_BALANCE_FLASH := 7
}
struct WPD_FOCUS_MODES extends Int32 {
    static WPD_FOCUS_UNDEFINED := 0
    static WPD_FOCUS_MANUAL := 1
    static WPD_FOCUS_AUTOMATIC := 2
    static WPD_FOCUS_AUTOMATIC_MACRO := 3
}
struct WPD_EXPOSURE_METERING_MODES extends Int32 {
    static WPD_EXPOSURE_METERING_MODE_UNDEFINED := 0
    static WPD_EXPOSURE_METERING_MODE_AVERAGE := 1
    static WPD_EXPOSURE_METERING_MODE_CENTER_WEIGHTED_AVERAGE := 2
    static WPD_EXPOSURE_METERING_MODE_MULTI_SPOT := 3
    static WPD_EXPOSURE_METERING_MODE_CENTER_SPOT := 4
}
struct WPD_FLASH_MODES extends Int32 {
    static WPD_FLASH_MODE_UNDEFINED := 0
    static WPD_FLASH_MODE_AUTO := 1
    static WPD_FLASH_MODE_OFF := 2
    static WPD_FLASH_MODE_FILL := 3
    static WPD_FLASH_MODE_RED_EYE_AUTO := 4
    static WPD_FLASH_MODE_RED_EYE_FILL := 5
    static WPD_FLASH_MODE_EXTERNAL_SYNC := 6
}
struct WPD_EXPOSURE_PROGRAM_MODES extends Int32 {
    static WPD_EXPOSURE_PROGRAM_MODE_UNDEFINED := 0
    static WPD_EXPOSURE_PROGRAM_MODE_MANUAL := 1
    static WPD_EXPOSURE_PROGRAM_MODE_AUTO := 2
    static WPD_EXPOSURE_PROGRAM_MODE_APERTURE_PRIORITY := 3
    static WPD_EXPOSURE_PROGRAM_MODE_SHUTTER_PRIORITY := 4
    static WPD_EXPOSURE_PROGRAM_MODE_CREATIVE := 5
    static WPD_EXPOSURE_PROGRAM_MODE_ACTION := 6
    static WPD_EXPOSURE_PROGRAM_MODE_PORTRAIT := 7
}
struct WPD_CAPTURE_MODES extends Int32 {
    static WPD_CAPTURE_MODE_UNDEFINED := 0
    static WPD_CAPTURE_MODE_NORMAL := 1
    static WPD_CAPTURE_MODE_BURST := 2
    static WPD_CAPTURE_MODE_TIMELAPSE := 3
}
struct WPD_EFFECT_MODES extends Int32 {
    static WPD_EFFECT_MODE_UNDEFINED := 0
    static WPD_EFFECT_MODE_COLOR := 1
    static WPD_EFFECT_MODE_BLACK_AND_WHITE := 2
    static WPD_EFFECT_MODE_SEPIA := 3
}
struct WPD_FOCUS_METERING_MODES extends Int32 {
    static WPD_FOCUS_METERING_MODE_UNDEFINED := 0
    static WPD_FOCUS_METERING_MODE_CENTER_SPOT := 1
    static WPD_FOCUS_METERING_MODE_MULTI_SPOT := 2
}
struct WPD_BITRATE_TYPES extends Int32 {
    static WPD_BITRATE_TYPE_UNUSED := 0
    static WPD_BITRATE_TYPE_DISCRETE := 1
    static WPD_BITRATE_TYPE_VARIABLE := 2
    static WPD_BITRATE_TYPE_FREE := 3
}
struct WPD_META_GENRES extends Int32 {
    static WPD_META_GENRE_UNUSED := 0
    static WPD_META_GENRE_GENERIC_MUSIC_AUDIO_FILE := 1
    static WPD_META_GENRE_GENERIC_NON_MUSIC_AUDIO_FILE := 17
    static WPD_META_GENRE_SPOKEN_WORD_AUDIO_BOOK_FILES := 18
    static WPD_META_GENRE_SPOKEN_WORD_FILES_NON_AUDIO_BOOK := 19
    static WPD_META_GENRE_SPOKEN_WORD_NEWS := 20
    static WPD_META_GENRE_SPOKEN_WORD_TALK_SHOWS := 21
    static WPD_META_GENRE_GENERIC_VIDEO_FILE := 33
    static WPD_META_GENRE_NEWS_VIDEO_FILE := 34
    static WPD_META_GENRE_MUSIC_VIDEO_FILE := 35
    static WPD_META_GENRE_HOME_VIDEO_FILE := 36
    static WPD_META_GENRE_FEATURE_FILM_VIDEO_FILE := 37
    static WPD_META_GENRE_TELEVISION_VIDEO_FILE := 38
    static WPD_META_GENRE_TRAINING_EDUCATIONAL_VIDEO_FILE := 39
    static WPD_META_GENRE_PHOTO_MONTAGE_VIDEO_FILE := 40
    static WPD_META_GENRE_GENERIC_NON_AUDIO_NON_VIDEO := 48
    static WPD_META_GENRE_AUDIO_PODCAST := 64
    static WPD_META_GENRE_VIDEO_PODCAST := 65
    static WPD_META_GENRE_MIXED_PODCAST := 66
}
struct WPD_CROPPED_STATUS_VALUES extends Int32 {
    static WPD_CROPPED_STATUS_NOT_CROPPED := 0
    static WPD_CROPPED_STATUS_CROPPED := 1
    static WPD_CROPPED_STATUS_SHOULD_NOT_BE_CROPPED := 2
}
struct WPD_COLOR_CORRECTED_STATUS_VALUES extends Int32 {
    static WPD_COLOR_CORRECTED_STATUS_NOT_CORRECTED := 0
    static WPD_COLOR_CORRECTED_STATUS_CORRECTED := 1
    static WPD_COLOR_CORRECTED_STATUS_SHOULD_NOT_BE_CORRECTED := 2
}
struct WPD_VIDEO_SCAN_TYPES extends Int32 {
    static WPD_VIDEO_SCAN_TYPE_UNUSED := 0
    static WPD_VIDEO_SCAN_TYPE_PROGRESSIVE := 1
    static WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_UPPER_FIRST := 2
    static WPD_VIDEO_SCAN_TYPE_FIELD_INTERLEAVED_LOWER_FIRST := 3
    static WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_UPPER_FIRST := 4
    static WPD_VIDEO_SCAN_TYPE_FIELD_SINGLE_LOWER_FIRST := 5
    static WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE := 6
    static WPD_VIDEO_SCAN_TYPE_MIXED_INTERLACE_AND_PROGRESSIVE := 7
}
struct WPD_OPERATION_STATES extends Int32 {
    static WPD_OPERATION_STATE_UNSPECIFIED := 0
    static WPD_OPERATION_STATE_STARTED := 1
    static WPD_OPERATION_STATE_RUNNING := 2
    static WPD_OPERATION_STATE_PAUSED := 3
    static WPD_OPERATION_STATE_CANCELLED := 4
    static WPD_OPERATION_STATE_FINISHED := 5
    static WPD_OPERATION_STATE_ABORTED := 6
}
struct WPD_SECTION_DATA_UNITS_VALUES extends Int32 {
    static WPD_SECTION_DATA_UNITS_BYTES := 0
    static WPD_SECTION_DATA_UNITS_MILLISECONDS := 1
}
struct WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPES extends Int32 {
    static WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_OBJECT := 0
    static WPD_RENDERING_INFORMATION_PROFILE_ENTRY_TYPE_RESOURCE := 1
}
struct WPD_COMMAND_ACCESS_TYPES extends Int32 {
    static WPD_COMMAND_ACCESS_READ := 1
    static WPD_COMMAND_ACCESS_READWRITE := 3
    static WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_STGM_ACCESS := 4
    static WPD_COMMAND_ACCESS_FROM_PROPERTY_WITH_FILE_ACCESS := 8
    static WPD_COMMAND_ACCESS_FROM_ATTRIBUTE_WITH_METHOD_ACCESS := 16
}
struct WPD_SERVICE_INHERITANCE_TYPES extends Int32 {
    static WPD_SERVICE_INHERITANCE_IMPLEMENTATION := 0
}
struct WPD_PARAMETER_USAGE_TYPES extends Int32 {
    static WPD_PARAMETER_USAGE_RETURN := 0
    static WPD_PARAMETER_USAGE_IN := 1
    static WPD_PARAMETER_USAGE_OUT := 2
    static WPD_PARAMETER_USAGE_INOUT := 3
}
struct WPD_COMMAND_ACCESS_LOOKUP_ENTRY {
    Command : PROPERTYKEY
    AccessType : UInt32
    AccessProperty : PROPERTYKEY
}
struct WPD_STREAM_UNITS extends Int32 {
    static WPD_STREAM_UNITS_BYTES := 0
    static WPD_STREAM_UNITS_FRAMES := 1
    static WPD_STREAM_UNITS_ROWS := 2
    static WPD_STREAM_UNITS_MILLISECONDS := 4
    static WPD_STREAM_UNITS_MICROSECONDS := 8
}
struct IWpdSerializer extends IUnknown {
    static IID := "{B32F4002-BB27-45FF-AF4F-06631C1E8DAD}"
    GetIPortableDeviceValuesFromBuffer(pBuffer, ppParams)
      => ComCall(3, this.p, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length, IPortableDeviceValues.Ptr, ppParams)
    WriteIPortableDeviceValuesToBuffer(pResults, pBuffer, pdwBytesWritten)
      => ComCall(4, this.p, UInt32, pBuffer.Length, IPortableDeviceValues, pResults, UInt8.Ptr, pBuffer, UInt32.Ptr, pdwBytesWritten)
    GetBufferFromIPortableDeviceValues(pSource, ppBuffer)
      => ComCall(5, this.p, IPortableDeviceValues, pSource, UInt8.Ptr.Ptr, ppBuffer, UInt32.Ptr, ppBuffer.Length)
    GetSerializedSize(pSource, pdwSize)
      => ComCall(6, this.p, IPortableDeviceValues, pSource, UInt32.Ptr, pdwSize)
}
struct IPortableDeviceValues extends IUnknown {
    static IID := "{6848F6F2-3155-4F86-B6F5-263EEEAB3143}"
    GetCount(pcelt)
      => ComCall(3, this.p, UInt32.Ptr, pcelt)
    GetAt(index, pKey, pValue)
      => ComCall(4, this.p, UInt32, index, PROPERTYKEY.Ptr, pKey, PROPVARIANT.Ptr, pValue)
    SetValue(key, pValue)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pValue)
    GetValue(key, pValue)
      => ComCall(6, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pValue)
    SetStringValue(key, Value)
      => ComCall(7, this.p, PROPERTYKEY.Ptr, key, "Str", Value)
    GetStringValue(key, pValue)
      => ComCall(8, this.p, PROPERTYKEY.Ptr, key, PWSTR.Ptr, pValue)
    SetUnsignedIntegerValue(key, Value)
      => ComCall(9, this.p, PROPERTYKEY.Ptr, key, UInt32, Value)
    GetUnsignedIntegerValue(key, pValue)
      => ComCall(10, this.p, PROPERTYKEY.Ptr, key, UInt32.Ptr, pValue)
    SetSignedIntegerValue(key, Value)
      => ComCall(11, this.p, PROPERTYKEY.Ptr, key, Int32, Value)
    GetSignedIntegerValue(key, pValue)
      => ComCall(12, this.p, PROPERTYKEY.Ptr, key, Int32.Ptr, pValue)
    SetUnsignedLargeIntegerValue(key, Value)
      => ComCall(13, this.p, PROPERTYKEY.Ptr, key, Int64, Value)
    GetUnsignedLargeIntegerValue(key, pValue)
      => ComCall(14, this.p, PROPERTYKEY.Ptr, key, Int64.Ptr, pValue)
    SetSignedLargeIntegerValue(key, Value)
      => ComCall(15, this.p, PROPERTYKEY.Ptr, key, Int64, Value)
    GetSignedLargeIntegerValue(key, pValue)
      => ComCall(16, this.p, PROPERTYKEY.Ptr, key, Int64.Ptr, pValue)
    SetFloatValue(key, Value)
      => ComCall(17, this.p, PROPERTYKEY.Ptr, key, Float32, Value)
    GetFloatValue(key, pValue)
      => ComCall(18, this.p, PROPERTYKEY.Ptr, key, Float32.Ptr, pValue)
    SetErrorValue(key, Value)
      => ComCall(19, this.p, PROPERTYKEY.Ptr, key, HRESULT, Value)
    GetErrorValue(key, pValue)
      => ComCall(20, this.p, PROPERTYKEY.Ptr, key, HRESULT.Ptr, pValue)
    SetKeyValue(key, Value)
      => ComCall(21, this.p, PROPERTYKEY.Ptr, key, PROPERTYKEY.Ptr, Value)
    GetKeyValue(key, pValue)
      => ComCall(22, this.p, PROPERTYKEY.Ptr, key, PROPERTYKEY.Ptr, pValue)
    SetBoolValue(key, Value)
      => ComCall(23, this.p, PROPERTYKEY.Ptr, key, BOOL, Value)
    GetBoolValue(key, pValue)
      => ComCall(24, this.p, PROPERTYKEY.Ptr, key, BOOL.Ptr, pValue)
    SetIUnknownValue(key, pValue)
      => ComCall(25, this.p, PROPERTYKEY.Ptr, key, IUnknown, pValue)
    GetIUnknownValue(key, ppValue)
      => ComCall(26, this.p, PROPERTYKEY.Ptr, key, IUnknown.Ptr, ppValue)
    SetGuidValue(key, Value)
      => ComCall(27, this.p, PROPERTYKEY.Ptr, key, GUID.Ptr, Value)
    GetGuidValue(key, pValue)
      => ComCall(28, this.p, PROPERTYKEY.Ptr, key, GUID.Ptr, pValue)
    SetBufferValue(key, pValue)
      => ComCall(29, this.p, PROPERTYKEY.Ptr, key, UInt8.Ptr, pValue, UInt32, pValue.Length)
    GetBufferValue(key, ppValue)
      => ComCall(30, this.p, PROPERTYKEY.Ptr, key, UInt8.Ptr.Ptr, ppValue, UInt32.Ptr, ppValue.Length)
    SetIPortableDeviceValuesValue(key, pValue)
      => ComCall(31, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceValues, pValue)
    GetIPortableDeviceValuesValue(key, ppValue)
      => ComCall(32, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceValues.Ptr, ppValue)
    SetIPortableDevicePropVariantCollectionValue(key, pValue)
      => ComCall(33, this.p, PROPERTYKEY.Ptr, key, IPortableDevicePropVariantCollection, pValue)
    GetIPortableDevicePropVariantCollectionValue(key, ppValue)
      => ComCall(34, this.p, PROPERTYKEY.Ptr, key, IPortableDevicePropVariantCollection.Ptr, ppValue)
    SetIPortableDeviceKeyCollectionValue(key, pValue)
      => ComCall(35, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceKeyCollection, pValue)
    GetIPortableDeviceKeyCollectionValue(key, ppValue)
      => ComCall(36, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceKeyCollection.Ptr, ppValue)
    SetIPortableDeviceValuesCollectionValue(key, pValue)
      => ComCall(37, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceValuesCollection, pValue)
    GetIPortableDeviceValuesCollectionValue(key, ppValue)
      => ComCall(38, this.p, PROPERTYKEY.Ptr, key, IPortableDeviceValuesCollection.Ptr, ppValue)
    RemoveValue(key)
      => ComCall(39, this.p, PROPERTYKEY.Ptr, key)
    CopyValuesFromPropertyStore(pStore)
      => ComCall(40, this.p, IPropertyStore, pStore)
    CopyValuesToPropertyStore(pStore)
      => ComCall(41, this.p, IPropertyStore, pStore)
    Clear()
      => ComCall(42, this.p)
}
struct IPortableDeviceKeyCollection extends IUnknown {
    static IID := "{DADA2357-E0AD-492E-98DB-DD61C53BA353}"
    GetCount(pcElems)
      => ComCall(3, this.p, UInt32.Ptr, pcElems)
    GetAt(dwIndex, pKey)
      => ComCall(4, this.p, UInt32, dwIndex, PROPERTYKEY.Ptr, pKey)
    Add(Key)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, Key)
    Clear()
      => ComCall(6, this.p)
    RemoveAt(dwIndex)
      => ComCall(7, this.p, UInt32, dwIndex)
}
struct IPortableDevicePropVariantCollection extends IUnknown {
    static IID := "{89B2E422-4F1B-4316-BCEF-A44AFEA83EB3}"
    GetCount(pcElems)
      => ComCall(3, this.p, UInt32.Ptr, pcElems)
    GetAt(dwIndex, pValue)
      => ComCall(4, this.p, UInt32, dwIndex, PROPVARIANT.Ptr, pValue)
    Add(pValue)
      => ComCall(5, this.p, PROPVARIANT.Ptr, pValue)
    GetType(pvt)
      => ComCall(6, this.p, UInt16.Ptr, pvt)
    ChangeType(vt)
      => ComCall(7, this.p, UInt16, vt)
    Clear()
      => ComCall(8, this.p)
    RemoveAt(dwIndex)
      => ComCall(9, this.p, UInt32, dwIndex)
}
struct IPortableDeviceValuesCollection extends IUnknown {
    static IID := "{6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99}"
    GetCount(pcElems)
      => ComCall(3, this.p, UInt32.Ptr, pcElems)
    GetAt(dwIndex, ppValues)
      => ComCall(4, this.p, UInt32, dwIndex, IPortableDeviceValues.Ptr, ppValues)
    Add(pValues)
      => ComCall(5, this.p, IPortableDeviceValues, pValues)
    Clear()
      => ComCall(6, this.p)
    RemoveAt(dwIndex)
      => ComCall(7, this.p, UInt32, dwIndex)
}
struct IPortableDeviceManager extends IUnknown {
    static IID := "{A1567595-4C2F-4574-A6FA-ECEF917B9A40}"
    GetDevices(pPnPDeviceIDs, pcPnPDeviceIDs)
      => ComCall(3, this.p, PWSTR.Ptr, pPnPDeviceIDs, UInt32.Ptr, pcPnPDeviceIDs)
    RefreshDeviceList()
      => ComCall(4, this.p)
    GetDeviceFriendlyName(pszPnPDeviceID, pDeviceFriendlyName, pcchDeviceFriendlyName)
      => ComCall(5, this.p, "Str", pszPnPDeviceID, PWSTR, pDeviceFriendlyName, UInt32.Ptr, pcchDeviceFriendlyName)
    GetDeviceDescription(pszPnPDeviceID, pDeviceDescription, pcchDeviceDescription)
      => ComCall(6, this.p, "Str", pszPnPDeviceID, PWSTR, pDeviceDescription, UInt32.Ptr, pcchDeviceDescription)
    GetDeviceManufacturer(pszPnPDeviceID, pDeviceManufacturer, pcchDeviceManufacturer)
      => ComCall(7, this.p, "Str", pszPnPDeviceID, PWSTR, pDeviceManufacturer, UInt32.Ptr, pcchDeviceManufacturer)
    GetDeviceProperty(pszPnPDeviceID, pszDevicePropertyName, pData, pcbData, pdwType)
      => ComCall(8, this.p, "Str", pszPnPDeviceID, "Str", pszDevicePropertyName, UInt8.Ptr, pData, UInt32.Ptr, pcbData, UInt32.Ptr, pdwType)
    GetPrivateDevices(pPnPDeviceIDs, pcPnPDeviceIDs)
      => ComCall(9, this.p, PWSTR.Ptr, pPnPDeviceIDs, UInt32.Ptr, pcPnPDeviceIDs)
}
struct IPortableDevice extends IUnknown {
    static IID := "{625E2DF8-6392-4CF0-9AD1-3CFA5F17775C}"
    Open(pszPnPDeviceID, pClientInfo)
      => ComCall(3, this.p, "Str", pszPnPDeviceID, IPortableDeviceValues, pClientInfo)
    SendCommand(dwFlags, pParameters, ppResults)
      => ComCall(4, this.p, UInt32, dwFlags, IPortableDeviceValues, pParameters, IPortableDeviceValues.Ptr, ppResults)
    Content(ppContent)
      => ComCall(5, this.p, IPortableDeviceContent.Ptr, ppContent)
    Capabilities(ppCapabilities)
      => ComCall(6, this.p, IPortableDeviceCapabilities.Ptr, ppCapabilities)
    Cancel()
      => ComCall(7, this.p)
    Close()
      => ComCall(8, this.p)
    Advise(dwFlags, pCallback, pParameters, ppszCookie)
      => ComCall(9, this.p, UInt32, dwFlags, IPortableDeviceEventCallback, pCallback, IPortableDeviceValues, pParameters, PWSTR.Ptr, ppszCookie)
    Unadvise(pszCookie)
      => ComCall(10, this.p, "Str", pszCookie)
    GetPnPDeviceID(ppszPnPDeviceID)
      => ComCall(11, this.p, PWSTR.Ptr, ppszPnPDeviceID)
}
struct IPortableDeviceContent extends IUnknown {
    static IID := "{6A96ED84-7C73-4480-9938-BF5AF477D426}"
    EnumObjects(dwFlags, pszParentObjectID, pFilter, ppEnum)
      => ComCall(3, this.p, UInt32, dwFlags, "Str", pszParentObjectID, IPortableDeviceValues, pFilter, IEnumPortableDeviceObjectIDs.Ptr, ppEnum)
    Properties(ppProperties)
      => ComCall(4, this.p, IPortableDeviceProperties.Ptr, ppProperties)
    Transfer(ppResources)
      => ComCall(5, this.p, IPortableDeviceResources.Ptr, ppResources)
    CreateObjectWithPropertiesOnly(pValues, ppszObjectID)
      => ComCall(6, this.p, IPortableDeviceValues, pValues, PWSTR.Ptr, ppszObjectID)
    CreateObjectWithPropertiesAndData(pValues, ppData, pdwOptimalWriteBufferSize, ppszCookie)
      => ComCall(7, this.p, IPortableDeviceValues, pValues, IStream.Ptr, ppData, UInt32.Ptr, pdwOptimalWriteBufferSize, PWSTR.Ptr, ppszCookie)
    Delete(dwOptions, pObjectIDs, ppResults)
      => ComCall(8, this.p, UInt32, dwOptions, IPortableDevicePropVariantCollection, pObjectIDs, IPortableDevicePropVariantCollection.Ptr, ppResults)
    GetObjectIDsFromPersistentUniqueIDs(pPersistentUniqueIDs, ppObjectIDs)
      => ComCall(9, this.p, IPortableDevicePropVariantCollection, pPersistentUniqueIDs, IPortableDevicePropVariantCollection.Ptr, ppObjectIDs)
    Cancel()
      => ComCall(10, this.p)
    Move(pObjectIDs, pszDestinationFolderObjectID, ppResults)
      => ComCall(11, this.p, IPortableDevicePropVariantCollection, pObjectIDs, "Str", pszDestinationFolderObjectID, IPortableDevicePropVariantCollection.Ptr, ppResults)
    Copy(pObjectIDs, pszDestinationFolderObjectID, ppResults)
      => ComCall(12, this.p, IPortableDevicePropVariantCollection, pObjectIDs, "Str", pszDestinationFolderObjectID, IPortableDevicePropVariantCollection.Ptr, ppResults)
}
struct IPortableDeviceContent2 extends IPortableDeviceContent {
    static IID := "{9B4ADD96-F6BF-4034-8708-ECA72BF10554}"
    UpdateObjectWithPropertiesAndData(pszObjectID, pProperties, ppData, pdwOptimalWriteBufferSize)
      => ComCall(13, this.p, "Str", pszObjectID, IPortableDeviceValues, pProperties, IStream.Ptr, ppData, UInt32.Ptr, pdwOptimalWriteBufferSize)
}
struct IEnumPortableDeviceObjectIDs extends IUnknown {
    static IID := "{10ECE955-CF41-4728-BFA0-41EEDF1BBF19}"
    Next(pObjIDs, pcFetched)
      => ComCall(3, this.p, UInt32, pObjIDs.Length, PWSTR.Ptr, pObjIDs, UInt32.Ptr, pcFetched)
    Skip(cObjects)
      => ComCall(4, this.p, UInt32, cObjects)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPortableDeviceObjectIDs.Ptr, ppEnum)
    Cancel()
      => ComCall(7, this.p)
}
struct IPortableDeviceProperties extends IUnknown {
    static IID := "{7F6D695C-03DF-4439-A809-59266BEEE3A6}"
    GetSupportedProperties(pszObjectID, ppKeys)
      => ComCall(3, this.p, "Str", pszObjectID, IPortableDeviceKeyCollection.Ptr, ppKeys)
    GetPropertyAttributes(pszObjectID, Key, ppAttributes)
      => ComCall(4, this.p, "Str", pszObjectID, PROPERTYKEY.Ptr, Key, IPortableDeviceValues.Ptr, ppAttributes)
    GetValues(pszObjectID, pKeys, ppValues)
      => ComCall(5, this.p, "Str", pszObjectID, IPortableDeviceKeyCollection, pKeys, IPortableDeviceValues.Ptr, ppValues)
    SetValues(pszObjectID, pValues, ppResults)
      => ComCall(6, this.p, "Str", pszObjectID, IPortableDeviceValues, pValues, IPortableDeviceValues.Ptr, ppResults)
    Delete(pszObjectID, pKeys)
      => ComCall(7, this.p, "Str", pszObjectID, IPortableDeviceKeyCollection, pKeys)
    Cancel()
      => ComCall(8, this.p)
}
struct IPortableDeviceResources extends IUnknown {
    static IID := "{FD8878AC-D841-4D17-891C-E6829CDB6934}"
    GetSupportedResources(pszObjectID, ppKeys)
      => ComCall(3, this.p, "Str", pszObjectID, IPortableDeviceKeyCollection.Ptr, ppKeys)
    GetResourceAttributes(pszObjectID, Key, ppResourceAttributes)
      => ComCall(4, this.p, "Str", pszObjectID, PROPERTYKEY.Ptr, Key, IPortableDeviceValues.Ptr, ppResourceAttributes)
    GetStream(pszObjectID, Key, dwMode, pdwOptimalBufferSize, ppStream)
      => ComCall(5, this.p, "Str", pszObjectID, PROPERTYKEY.Ptr, Key, UInt32, dwMode, UInt32.Ptr, pdwOptimalBufferSize, IStream.Ptr, ppStream)
    Delete(pszObjectID, pKeys)
      => ComCall(6, this.p, "Str", pszObjectID, IPortableDeviceKeyCollection, pKeys)
    Cancel()
      => ComCall(7, this.p)
    CreateResource(pResourceAttributes, ppData, pdwOptimalWriteBufferSize, ppszCookie)
      => ComCall(8, this.p, IPortableDeviceValues, pResourceAttributes, IStream.Ptr, ppData, UInt32.Ptr, pdwOptimalWriteBufferSize, PWSTR.Ptr, ppszCookie)
}
struct IPortableDeviceCapabilities extends IUnknown {
    static IID := "{2C8C6DBF-E3DC-4061-BECC-8542E810D126}"
    GetSupportedCommands(ppCommands)
      => ComCall(3, this.p, IPortableDeviceKeyCollection.Ptr, ppCommands)
    GetCommandOptions(Command, ppOptions)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, Command, IPortableDeviceValues.Ptr, ppOptions)
    GetFunctionalCategories(ppCategories)
      => ComCall(5, this.p, IPortableDevicePropVariantCollection.Ptr, ppCategories)
    GetFunctionalObjects(Category, ppObjectIDs)
      => ComCall(6, this.p, GUID.Ptr, Category, IPortableDevicePropVariantCollection.Ptr, ppObjectIDs)
    GetSupportedContentTypes(Category, ppContentTypes)
      => ComCall(7, this.p, GUID.Ptr, Category, IPortableDevicePropVariantCollection.Ptr, ppContentTypes)
    GetSupportedFormats(ContentType, ppFormats)
      => ComCall(8, this.p, GUID.Ptr, ContentType, IPortableDevicePropVariantCollection.Ptr, ppFormats)
    GetSupportedFormatProperties(Format, ppKeys)
      => ComCall(9, this.p, GUID.Ptr, Format, IPortableDeviceKeyCollection.Ptr, ppKeys)
    GetFixedPropertyAttributes(Format, Key, ppAttributes)
      => ComCall(10, this.p, GUID.Ptr, Format, PROPERTYKEY.Ptr, Key, IPortableDeviceValues.Ptr, ppAttributes)
    Cancel()
      => ComCall(11, this.p)
    GetSupportedEvents(ppEvents)
      => ComCall(12, this.p, IPortableDevicePropVariantCollection.Ptr, ppEvents)
    GetEventOptions(Event, ppOptions)
      => ComCall(13, this.p, GUID.Ptr, Event, IPortableDeviceValues.Ptr, ppOptions)
}
struct IPortableDeviceEventCallback extends IUnknown {
    static IID := "{A8792A31-F385-493C-A893-40F64EB45F6E}"
    OnEvent(pEventParameters)
      => ComCall(3, this.p, IPortableDeviceValues, pEventParameters)
}
struct IPortableDeviceDataStream extends IStream {
    static IID := "{88E04DB3-1012-4D64-9996-F703A950D3F4}"
    GetObjectID(ppszObjectID)
      => ComCall(14, this.p, PWSTR.Ptr, ppszObjectID)
    Cancel()
      => ComCall(15, this.p)
}
struct IPortableDeviceUnitsStream extends IUnknown {
    static IID := "{5E98025F-BFC4-47A2-9A5F-BC900A507C67}"
    SeekInUnits(dlibMove, units, dwOrigin, plibNewPosition?)
      => ComCall(3, this.p, Int64, dlibMove, WPD_STREAM_UNITS, units, UInt32, dwOrigin, Int64.Ptr, plibNewPosition?)
    Cancel()
      => ComCall(4, this.p)
}
struct IPortableDevicePropertiesBulk extends IUnknown {
    static IID := "{482B05C0-4056-44ED-9E0F-5E23B009DA93}"
    QueueGetValuesByObjectList(pObjectIDs, pKeys, pCallback, pContext)
      => ComCall(3, this.p, IPortableDevicePropVariantCollection, pObjectIDs, IPortableDeviceKeyCollection, pKeys, IPortableDevicePropertiesBulkCallback, pCallback, GUID.Ptr, pContext)
    QueueGetValuesByObjectFormat(pguidObjectFormat, pszParentObjectID, dwDepth, pKeys, pCallback, pContext)
      => ComCall(4, this.p, GUID.Ptr, pguidObjectFormat, "Str", pszParentObjectID, UInt32, dwDepth, IPortableDeviceKeyCollection, pKeys, IPortableDevicePropertiesBulkCallback, pCallback, GUID.Ptr, pContext)
    QueueSetValuesByObjectList(pObjectValues, pCallback, pContext)
      => ComCall(5, this.p, IPortableDeviceValuesCollection, pObjectValues, IPortableDevicePropertiesBulkCallback, pCallback, GUID.Ptr, pContext)
    Start(pContext)
      => ComCall(6, this.p, GUID.Ptr, pContext)
    Cancel(pContext)
      => ComCall(7, this.p, GUID.Ptr, pContext)
}
struct IPortableDevicePropertiesBulkCallback extends IUnknown {
    static IID := "{9DEACB80-11E8-40E3-A9F3-F557986A7845}"
    OnStart(pContext)
      => ComCall(3, this.p, GUID.Ptr, pContext)
    OnProgress(pContext, pResults)
      => ComCall(4, this.p, GUID.Ptr, pContext, IPortableDeviceValuesCollection, pResults)
    OnEnd(pContext, hrStatus)
      => ComCall(5, this.p, GUID.Ptr, pContext, HRESULT, hrStatus)
}
struct IPortableDeviceServiceManager extends IUnknown {
    static IID := "{A8ABC4E9-A84A-47A9-80B3-C5D9B172A961}"
    GetDeviceServices(pszPnPDeviceID, guidServiceCategory, pServices, pcServices)
      => ComCall(3, this.p, "Str", pszPnPDeviceID, GUID.Ptr, guidServiceCategory, PWSTR.Ptr, pServices, UInt32.Ptr, pcServices)
    GetDeviceForService(pszPnPServiceID, ppszPnPDeviceID)
      => ComCall(4, this.p, "Str", pszPnPServiceID, PWSTR.Ptr, ppszPnPDeviceID)
}
struct IPortableDeviceService extends IUnknown {
    static IID := "{D3BD3A44-D7B5-40A9-98B7-2FA4D01DEC08}"
    Open(pszPnPServiceID, pClientInfo)
      => ComCall(3, this.p, "Str", pszPnPServiceID, IPortableDeviceValues, pClientInfo)
    Capabilities(ppCapabilities)
      => ComCall(4, this.p, IPortableDeviceServiceCapabilities.Ptr, ppCapabilities)
    Content(ppContent)
      => ComCall(5, this.p, IPortableDeviceContent2.Ptr, ppContent)
    Methods(ppMethods)
      => ComCall(6, this.p, IPortableDeviceServiceMethods.Ptr, ppMethods)
    Cancel()
      => ComCall(7, this.p)
    Close()
      => ComCall(8, this.p)
    GetServiceObjectID(ppszServiceObjectID)
      => ComCall(9, this.p, PWSTR.Ptr, ppszServiceObjectID)
    GetPnPServiceID(ppszPnPServiceID)
      => ComCall(10, this.p, PWSTR.Ptr, ppszPnPServiceID)
    Advise(dwFlags, pCallback, pParameters, ppszCookie)
      => ComCall(11, this.p, UInt32, dwFlags, IPortableDeviceEventCallback, pCallback, IPortableDeviceValues, pParameters, PWSTR.Ptr, ppszCookie)
    Unadvise(pszCookie)
      => ComCall(12, this.p, "Str", pszCookie)
    SendCommand(dwFlags, pParameters, ppResults)
      => ComCall(13, this.p, UInt32, dwFlags, IPortableDeviceValues, pParameters, IPortableDeviceValues.Ptr, ppResults)
}
struct IPortableDeviceServiceCapabilities extends IUnknown {
    static IID := "{24DBD89D-413E-43E0-BD5B-197F3C56C886}"
    GetSupportedMethods(ppMethods)
      => ComCall(3, this.p, IPortableDevicePropVariantCollection.Ptr, ppMethods)
    GetSupportedMethodsByFormat(Format, ppMethods)
      => ComCall(4, this.p, GUID.Ptr, Format, IPortableDevicePropVariantCollection.Ptr, ppMethods)
    GetMethodAttributes(Method, ppAttributes)
      => ComCall(5, this.p, GUID.Ptr, Method, IPortableDeviceValues.Ptr, ppAttributes)
    GetMethodParameterAttributes(Method, Parameter, ppAttributes)
      => ComCall(6, this.p, GUID.Ptr, Method, PROPERTYKEY.Ptr, Parameter, IPortableDeviceValues.Ptr, ppAttributes)
    GetSupportedFormats(ppFormats)
      => ComCall(7, this.p, IPortableDevicePropVariantCollection.Ptr, ppFormats)
    GetFormatAttributes(Format, ppAttributes)
      => ComCall(8, this.p, GUID.Ptr, Format, IPortableDeviceValues.Ptr, ppAttributes)
    GetSupportedFormatProperties(Format, ppKeys)
      => ComCall(9, this.p, GUID.Ptr, Format, IPortableDeviceKeyCollection.Ptr, ppKeys)
    GetFormatPropertyAttributes(Format, Property, ppAttributes)
      => ComCall(10, this.p, GUID.Ptr, Format, PROPERTYKEY.Ptr, Property, IPortableDeviceValues.Ptr, ppAttributes)
    GetSupportedEvents(ppEvents)
      => ComCall(11, this.p, IPortableDevicePropVariantCollection.Ptr, ppEvents)
    GetEventAttributes(Event, ppAttributes)
      => ComCall(12, this.p, GUID.Ptr, Event, IPortableDeviceValues.Ptr, ppAttributes)
    GetEventParameterAttributes(Event, Parameter, ppAttributes)
      => ComCall(13, this.p, GUID.Ptr, Event, PROPERTYKEY.Ptr, Parameter, IPortableDeviceValues.Ptr, ppAttributes)
    GetInheritedServices(dwInheritanceType, ppServices)
      => ComCall(14, this.p, UInt32, dwInheritanceType, IPortableDevicePropVariantCollection.Ptr, ppServices)
    GetFormatRenderingProfiles(Format, ppRenderingProfiles)
      => ComCall(15, this.p, GUID.Ptr, Format, IPortableDeviceValuesCollection.Ptr, ppRenderingProfiles)
    GetSupportedCommands(ppCommands)
      => ComCall(16, this.p, IPortableDeviceKeyCollection.Ptr, ppCommands)
    GetCommandOptions(Command, ppOptions)
      => ComCall(17, this.p, PROPERTYKEY.Ptr, Command, IPortableDeviceValues.Ptr, ppOptions)
    Cancel()
      => ComCall(18, this.p)
}
struct IPortableDeviceServiceMethods extends IUnknown {
    static IID := "{E20333C9-FD34-412D-A381-CC6F2D820DF7}"
    Invoke(Method, pParameters, ppResults)
      => ComCall(3, this.p, GUID.Ptr, Method, IPortableDeviceValues, pParameters, IPortableDeviceValues.Ptr, ppResults)
    InvokeAsync(Method, pParameters, pCallback)
      => ComCall(4, this.p, GUID.Ptr, Method, IPortableDeviceValues, pParameters, IPortableDeviceServiceMethodCallback, pCallback)
    Cancel(pCallback)
      => ComCall(5, this.p, IPortableDeviceServiceMethodCallback, pCallback)
}
struct IPortableDeviceServiceMethodCallback extends IUnknown {
    static IID := "{C424233C-AFCE-4828-A756-7ED7A2350083}"
    OnComplete(hrStatus, pResults)
      => ComCall(3, this.p, HRESULT, hrStatus, IPortableDeviceValues, pResults)
}
struct IPortableDeviceServiceActivation extends IUnknown {
    static IID := "{E56B0534-D9B9-425C-9B99-75F97CB3D7C8}"
    OpenAsync(pszPnPServiceID, pClientInfo, pCallback)
      => ComCall(3, this.p, "Str", pszPnPServiceID, IPortableDeviceValues, pClientInfo, IPortableDeviceServiceOpenCallback, pCallback)
    CancelOpenAsync()
      => ComCall(4, this.p)
}
struct IPortableDeviceServiceOpenCallback extends IUnknown {
    static IID := "{BCED49C8-8EFE-41ED-960B-61313ABD47A9}"
    OnComplete(hrStatus)
      => ComCall(3, this.p, HRESULT, hrStatus)
}
struct IPortableDeviceDispatchFactory extends IUnknown {
    static IID := "{5E1EAFC3-E3D7-4132-96FA-759C0F9D1E0F}"
    GetDeviceDispatch(pszPnPDeviceID, ppDeviceDispatch)
      => ComCall(3, this.p, "Str", pszPnPDeviceID, IDispatch.Ptr, ppDeviceDispatch)
}
struct IPortableDeviceWebControl extends IDispatch {
    static IID := "{94FC7953-5CA1-483A-8AEE-DF52E7747D00}"
    GetDeviceFromId(deviceId, ppDevice)
      => ComCall(7, this.p, BSTR, deviceId, IDispatch.Ptr, ppDevice)
    GetDeviceFromIdAsync(deviceId, pCompletionHandler, pErrorHandler?)
      => ComCall(8, this.p, BSTR, deviceId, IDispatch, pCompletionHandler, IDispatch, pErrorHandler?)
}
struct IEnumPortableDeviceConnectors extends IUnknown {
    static IID := "{BFDEF549-9247-454F-BD82-06FE80853FAA}"
    Next(pConnectors, pcFetched)
      => ComCall(3, this.p, UInt32, pConnectors.Length, IPortableDeviceConnector.Ptr, pConnectors, UInt32.Ptr, pcFetched)
    Skip(cConnectors)
      => ComCall(4, this.p, UInt32, cConnectors)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPortableDeviceConnectors.Ptr, ppEnum)
}
struct IPortableDeviceConnector extends IUnknown {
    static IID := "{625E2DF8-6392-4CF0-9AD1-3CFA5F17775C}"
    Connect(pCallback)
      => ComCall(3, this.p, IConnectionRequestCallback, pCallback)
    Disconnect(pCallback)
      => ComCall(4, this.p, IConnectionRequestCallback, pCallback)
    Cancel(pCallback)
      => ComCall(5, this.p, IConnectionRequestCallback, pCallback)
    GetProperty(pPropertyKey, pPropertyType, ppData)
      => ComCall(6, this.p, DEVPROPKEY.Ptr, pPropertyKey, DEVPROPTYPE.Ptr, pPropertyType, UInt8.Ptr.Ptr, ppData, UInt32.Ptr, ppData.Length)
    SetProperty(pPropertyKey, PropertyType, pData)
      => ComCall(7, this.p, DEVPROPKEY.Ptr, pPropertyKey, DEVPROPTYPE, PropertyType, UInt8.Ptr, pData, UInt32, pData.Length)
    GetPnPID(ppwszPnPID)
      => ComCall(8, this.p, PWSTR.Ptr, ppwszPnPID)
}
struct IConnectionRequestCallback extends IUnknown {
    static IID := "{272C9AE0-7161-4AE0-91BD-9F448EE9C427}"
    OnComplete(hrStatus)
      => ComCall(3, this.p, HRESULT, hrStatus)
}
struct DEVICE_RADIO_STATE extends Int32 {
    static DRS_RADIO_ON := 0
    static DRS_SW_RADIO_OFF := 1
    static DRS_HW_RADIO_OFF := 2
    static DRS_SW_HW_RADIO_OFF := 3
    static DRS_HW_RADIO_ON_UNCONTROLLABLE := 4
    static DRS_RADIO_INVALID := 5
    static DRS_HW_RADIO_OFF_UNCONTROLLABLE := 6
    static DRS_RADIO_MAX := 6
}
struct SYSTEM_RADIO_STATE extends Int32 {
    static SRS_RADIO_ENABLED := 0
    static SRS_RADIO_DISABLED := 1
}
struct IMediaRadioManager extends IUnknown {
    static IID := "{6CFDCAB5-FC47-42A5-9241-074B58830E73}"
    GetRadioInstances(ppCollection)
      => ComCall(3, this.p, IRadioInstanceCollection.Ptr, ppCollection)
    OnSystemRadioStateChange(sysRadioState, uTimeoutSec)
      => ComCall(4, this.p, SYSTEM_RADIO_STATE, sysRadioState, UInt32, uTimeoutSec)
}
struct IRadioInstanceCollection extends IUnknown {
    static IID := "{E5791FAE-5665-4E0C-95BE-5FDE31644185}"
    GetCount(pcInstance)
      => ComCall(3, this.p, UInt32.Ptr, pcInstance)
    GetAt(uIndex, ppRadioInstance)
      => ComCall(4, this.p, UInt32, uIndex, IRadioInstance.Ptr, ppRadioInstance)
}
struct IRadioInstance extends IUnknown {
    static IID := "{70AA1C9E-F2B4-4C61-86D3-6B9FB75FD1A2}"
    GetRadioManagerSignature(pguidSignature)
      => ComCall(3, this.p, GUID.Ptr, pguidSignature)
    GetInstanceSignature(pbstrId)
      => ComCall(4, this.p, BSTR.Ptr, pbstrId)
    GetFriendlyName(lcid, pbstrName)
      => ComCall(5, this.p, UInt32, lcid, BSTR.Ptr, pbstrName)
    GetRadioState(pRadioState)
      => ComCall(6, this.p, DEVICE_RADIO_STATE.Ptr, pRadioState)
    SetRadioState(radioState, uTimeoutSec)
      => ComCall(7, this.p, DEVICE_RADIO_STATE, radioState, UInt32, uTimeoutSec)
    IsMultiComm()
      => ComCall(8, this.p, BOOL)
    IsAssociatingDevice()
      => ComCall(9, this.p, BOOL)
}
struct IMediaRadioManagerNotifySink extends IUnknown {
    static IID := "{89D81F5F-C147-49ED-A11C-77B20C31E7C9}"
    OnInstanceAdd(pRadioInstance)
      => ComCall(3, this.p, IRadioInstance, pRadioInstance)
    OnInstanceRemove(bstrRadioInstanceId)
      => ComCall(4, this.p, BSTR, bstrRadioInstanceId)
    OnInstanceRadioChange(bstrRadioInstanceId, radioState)
      => ComCall(5, this.p, BSTR, bstrRadioInstanceId, DEVICE_RADIO_STATE, radioState)
}
