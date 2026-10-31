#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, BSTR, HRESULT, VARIANT_BOOL}
#Import "..\System.AddressBook\Types.ahk" {IMessage}
#Import "..\System.Com\Types.ahk" {IDispatch, IStream, IUnknown, SAFEARRAY}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyStorage, IStorage}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT}

struct DISC_RECORDER_STATE_FLAGS extends UInt32 {
    static RECORDER_BURNING := 2
    static RECORDER_DOING_NOTHING := 0
    static RECORDER_OPENED := 1
}
struct LPMSGSESS {
    Value : IntPtr
}
struct IMAPI_MEDIA_PHYSICAL_TYPE extends Int32 {
    static IMAPI_MEDIA_TYPE_UNKNOWN := 0
    static IMAPI_MEDIA_TYPE_CDROM := 1
    static IMAPI_MEDIA_TYPE_CDR := 2
    static IMAPI_MEDIA_TYPE_CDRW := 3
    static IMAPI_MEDIA_TYPE_DVDROM := 4
    static IMAPI_MEDIA_TYPE_DVDRAM := 5
    static IMAPI_MEDIA_TYPE_DVDPLUSR := 6
    static IMAPI_MEDIA_TYPE_DVDPLUSRW := 7
    static IMAPI_MEDIA_TYPE_DVDPLUSR_DUALLAYER := 8
    static IMAPI_MEDIA_TYPE_DVDDASHR := 9
    static IMAPI_MEDIA_TYPE_DVDDASHRW := 10
    static IMAPI_MEDIA_TYPE_DVDDASHR_DUALLAYER := 11
    static IMAPI_MEDIA_TYPE_DISK := 12
    static IMAPI_MEDIA_TYPE_DVDPLUSRW_DUALLAYER := 13
    static IMAPI_MEDIA_TYPE_HDDVDROM := 14
    static IMAPI_MEDIA_TYPE_HDDVDR := 15
    static IMAPI_MEDIA_TYPE_HDDVDRAM := 16
    static IMAPI_MEDIA_TYPE_BDROM := 17
    static IMAPI_MEDIA_TYPE_BDR := 18
    static IMAPI_MEDIA_TYPE_BDRE := 19
    static IMAPI_MEDIA_TYPE_MAX := 19
}
struct IMAPI_MEDIA_WRITE_PROTECT_STATE extends Int32 {
    static IMAPI_WRITEPROTECTED_UNTIL_POWERDOWN := 1
    static IMAPI_WRITEPROTECTED_BY_CARTRIDGE := 2
    static IMAPI_WRITEPROTECTED_BY_MEDIA_SPECIFIC_REASON := 4
    static IMAPI_WRITEPROTECTED_BY_SOFTWARE_WRITE_PROTECT := 8
    static IMAPI_WRITEPROTECTED_BY_DISC_CONTROL_BLOCK := 16
    static IMAPI_WRITEPROTECTED_READ_ONLY_MEDIA := 16384
}
struct IMAPI_READ_TRACK_ADDRESS_TYPE extends Int32 {
    static IMAPI_READ_TRACK_ADDRESS_TYPE_LBA := 0
    static IMAPI_READ_TRACK_ADDRESS_TYPE_TRACK := 1
    static IMAPI_READ_TRACK_ADDRESS_TYPE_SESSION := 2
}
struct IMAPI_MODE_PAGE_REQUEST_TYPE extends Int32 {
    static IMAPI_MODE_PAGE_REQUEST_TYPE_CURRENT_VALUES := 0
    static IMAPI_MODE_PAGE_REQUEST_TYPE_CHANGEABLE_VALUES := 1
    static IMAPI_MODE_PAGE_REQUEST_TYPE_DEFAULT_VALUES := 2
    static IMAPI_MODE_PAGE_REQUEST_TYPE_SAVED_VALUES := 3
}
struct IMAPI_MODE_PAGE_TYPE extends Int32 {
    static IMAPI_MODE_PAGE_TYPE_READ_WRITE_ERROR_RECOVERY := 1
    static IMAPI_MODE_PAGE_TYPE_MRW := 3
    static IMAPI_MODE_PAGE_TYPE_WRITE_PARAMETERS := 5
    static IMAPI_MODE_PAGE_TYPE_CACHING := 8
    static IMAPI_MODE_PAGE_TYPE_INFORMATIONAL_EXCEPTIONS := 28
    static IMAPI_MODE_PAGE_TYPE_TIMEOUT_AND_PROTECT := 29
    static IMAPI_MODE_PAGE_TYPE_POWER_CONDITION := 26
    static IMAPI_MODE_PAGE_TYPE_LEGACY_CAPABILITIES := 42
}
struct IMAPI_FEATURE_PAGE_TYPE extends Int32 {
    static IMAPI_FEATURE_PAGE_TYPE_PROFILE_LIST := 0
    static IMAPI_FEATURE_PAGE_TYPE_CORE := 1
    static IMAPI_FEATURE_PAGE_TYPE_MORPHING := 2
    static IMAPI_FEATURE_PAGE_TYPE_REMOVABLE_MEDIUM := 3
    static IMAPI_FEATURE_PAGE_TYPE_WRITE_PROTECT := 4
    static IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_READABLE := 16
    static IMAPI_FEATURE_PAGE_TYPE_CD_MULTIREAD := 29
    static IMAPI_FEATURE_PAGE_TYPE_CD_READ := 30
    static IMAPI_FEATURE_PAGE_TYPE_DVD_READ := 31
    static IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_WRITABLE := 32
    static IMAPI_FEATURE_PAGE_TYPE_INCREMENTAL_STREAMING_WRITABLE := 33
    static IMAPI_FEATURE_PAGE_TYPE_SECTOR_ERASABLE := 34
    static IMAPI_FEATURE_PAGE_TYPE_FORMATTABLE := 35
    static IMAPI_FEATURE_PAGE_TYPE_HARDWARE_DEFECT_MANAGEMENT := 36
    static IMAPI_FEATURE_PAGE_TYPE_WRITE_ONCE := 37
    static IMAPI_FEATURE_PAGE_TYPE_RESTRICTED_OVERWRITE := 38
    static IMAPI_FEATURE_PAGE_TYPE_CDRW_CAV_WRITE := 39
    static IMAPI_FEATURE_PAGE_TYPE_MRW := 40
    static IMAPI_FEATURE_PAGE_TYPE_ENHANCED_DEFECT_REPORTING := 41
    static IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_RW := 42
    static IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R := 43
    static IMAPI_FEATURE_PAGE_TYPE_RIGID_RESTRICTED_OVERWRITE := 44
    static IMAPI_FEATURE_PAGE_TYPE_CD_TRACK_AT_ONCE := 45
    static IMAPI_FEATURE_PAGE_TYPE_CD_MASTERING := 46
    static IMAPI_FEATURE_PAGE_TYPE_DVD_DASH_WRITE := 47
    static IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_READ := 48
    static IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_R_WRITE := 49
    static IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_RW_WRITE := 50
    static IMAPI_FEATURE_PAGE_TYPE_LAYER_JUMP_RECORDING := 51
    static IMAPI_FEATURE_PAGE_TYPE_CD_RW_MEDIA_WRITE_SUPPORT := 55
    static IMAPI_FEATURE_PAGE_TYPE_BD_PSEUDO_OVERWRITE := 56
    static IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R_DUAL_LAYER := 59
    static IMAPI_FEATURE_PAGE_TYPE_BD_READ := 64
    static IMAPI_FEATURE_PAGE_TYPE_BD_WRITE := 65
    static IMAPI_FEATURE_PAGE_TYPE_HD_DVD_READ := 80
    static IMAPI_FEATURE_PAGE_TYPE_HD_DVD_WRITE := 81
    static IMAPI_FEATURE_PAGE_TYPE_POWER_MANAGEMENT := 256
    static IMAPI_FEATURE_PAGE_TYPE_SMART := 257
    static IMAPI_FEATURE_PAGE_TYPE_EMBEDDED_CHANGER := 258
    static IMAPI_FEATURE_PAGE_TYPE_CD_ANALOG_PLAY := 259
    static IMAPI_FEATURE_PAGE_TYPE_MICROCODE_UPDATE := 260
    static IMAPI_FEATURE_PAGE_TYPE_TIMEOUT := 261
    static IMAPI_FEATURE_PAGE_TYPE_DVD_CSS := 262
    static IMAPI_FEATURE_PAGE_TYPE_REAL_TIME_STREAMING := 263
    static IMAPI_FEATURE_PAGE_TYPE_LOGICAL_UNIT_SERIAL_NUMBER := 264
    static IMAPI_FEATURE_PAGE_TYPE_MEDIA_SERIAL_NUMBER := 265
    static IMAPI_FEATURE_PAGE_TYPE_DISC_CONTROL_BLOCKS := 266
    static IMAPI_FEATURE_PAGE_TYPE_DVD_CPRM := 267
    static IMAPI_FEATURE_PAGE_TYPE_FIRMWARE_INFORMATION := 268
    static IMAPI_FEATURE_PAGE_TYPE_AACS := 269
    static IMAPI_FEATURE_PAGE_TYPE_VCPS := 272
}
struct IMAPI_PROFILE_TYPE extends Int32 {
    static IMAPI_PROFILE_TYPE_INVALID := 0
    static IMAPI_PROFILE_TYPE_NON_REMOVABLE_DISK := 1
    static IMAPI_PROFILE_TYPE_REMOVABLE_DISK := 2
    static IMAPI_PROFILE_TYPE_MO_ERASABLE := 3
    static IMAPI_PROFILE_TYPE_MO_WRITE_ONCE := 4
    static IMAPI_PROFILE_TYPE_AS_MO := 5
    static IMAPI_PROFILE_TYPE_CDROM := 8
    static IMAPI_PROFILE_TYPE_CD_RECORDABLE := 9
    static IMAPI_PROFILE_TYPE_CD_REWRITABLE := 10
    static IMAPI_PROFILE_TYPE_DVDROM := 16
    static IMAPI_PROFILE_TYPE_DVD_DASH_RECORDABLE := 17
    static IMAPI_PROFILE_TYPE_DVD_RAM := 18
    static IMAPI_PROFILE_TYPE_DVD_DASH_REWRITABLE := 19
    static IMAPI_PROFILE_TYPE_DVD_DASH_RW_SEQUENTIAL := 20
    static IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_SEQUENTIAL := 21
    static IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_LAYER_JUMP := 22
    static IMAPI_PROFILE_TYPE_DVD_PLUS_RW := 26
    static IMAPI_PROFILE_TYPE_DVD_PLUS_R := 27
    static IMAPI_PROFILE_TYPE_DDCDROM := 32
    static IMAPI_PROFILE_TYPE_DDCD_RECORDABLE := 33
    static IMAPI_PROFILE_TYPE_DDCD_REWRITABLE := 34
    static IMAPI_PROFILE_TYPE_DVD_PLUS_RW_DUAL := 42
    static IMAPI_PROFILE_TYPE_DVD_PLUS_R_DUAL := 43
    static IMAPI_PROFILE_TYPE_BD_ROM := 64
    static IMAPI_PROFILE_TYPE_BD_R_SEQUENTIAL := 65
    static IMAPI_PROFILE_TYPE_BD_R_RANDOM_RECORDING := 66
    static IMAPI_PROFILE_TYPE_BD_REWRITABLE := 67
    static IMAPI_PROFILE_TYPE_HD_DVD_ROM := 80
    static IMAPI_PROFILE_TYPE_HD_DVD_RECORDABLE := 81
    static IMAPI_PROFILE_TYPE_HD_DVD_RAM := 82
    static IMAPI_PROFILE_TYPE_NON_STANDARD := 65535
}
struct IMAPI_FORMAT2_DATA_WRITE_ACTION extends Int32 {
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_VALIDATING_MEDIA := 0
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_FORMATTING_MEDIA := 1
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_INITIALIZING_HARDWARE := 2
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_CALIBRATING_POWER := 3
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_WRITING_DATA := 4
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_FINALIZATION := 5
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_COMPLETED := 6
    static IMAPI_FORMAT2_DATA_WRITE_ACTION_VERIFYING := 7
}
struct IMAPI_FORMAT2_DATA_MEDIA_STATE extends Int32 {
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_UNKNOWN := 0
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_INFORMATIONAL_MASK := 15
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MASK := 64512
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY := 1
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_RANDOMLY_WRITABLE := 1
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_BLANK := 2
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_APPENDABLE := 4
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_FINAL_SESSION := 8
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_DAMAGED := 1024
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_ERASE_REQUIRED := 2048
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_NON_EMPTY_SESSION := 4096
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_WRITE_PROTECTED := 8192
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_FINALIZED := 16384
    static IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MEDIA := 32768
}
struct IMAPI_FORMAT2_TAO_WRITE_ACTION extends Int32 {
    static IMAPI_FORMAT2_TAO_WRITE_ACTION_UNKNOWN := 0
    static IMAPI_FORMAT2_TAO_WRITE_ACTION_PREPARING := 1
    static IMAPI_FORMAT2_TAO_WRITE_ACTION_WRITING := 2
    static IMAPI_FORMAT2_TAO_WRITE_ACTION_FINISHING := 3
    static IMAPI_FORMAT2_TAO_WRITE_ACTION_VERIFYING := 4
}
struct IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE extends Int32 {
    static IMAPI_FORMAT2_RAW_CD_SUBCODE_PQ_ONLY := 1
    static IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED := 2
    static IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_RAW := 3
}
struct IMAPI_FORMAT2_RAW_CD_WRITE_ACTION extends Int32 {
    static IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_UNKNOWN := 0
    static IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_PREPARING := 1
    static IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_WRITING := 2
    static IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_FINISHING := 3
}
struct IMAPI_CD_SECTOR_TYPE extends Int32 {
    static IMAPI_CD_SECTOR_AUDIO := 0
    static IMAPI_CD_SECTOR_MODE_ZERO := 1
    static IMAPI_CD_SECTOR_MODE1 := 2
    static IMAPI_CD_SECTOR_MODE2FORM0 := 3
    static IMAPI_CD_SECTOR_MODE2FORM1 := 4
    static IMAPI_CD_SECTOR_MODE2FORM2 := 5
    static IMAPI_CD_SECTOR_MODE1RAW := 6
    static IMAPI_CD_SECTOR_MODE2FORM0RAW := 7
    static IMAPI_CD_SECTOR_MODE2FORM1RAW := 8
    static IMAPI_CD_SECTOR_MODE2FORM2RAW := 9
}
struct IMAPI_CD_TRACK_DIGITAL_COPY_SETTING extends Int32 {
    static IMAPI_CD_TRACK_DIGITAL_COPY_PERMITTED := 0
    static IMAPI_CD_TRACK_DIGITAL_COPY_PROHIBITED := 1
    static IMAPI_CD_TRACK_DIGITAL_COPY_SCMS := 2
}
struct IMAPI_BURN_VERIFICATION_LEVEL extends Int32 {
    static IMAPI_BURN_VERIFICATION_NONE := 0
    static IMAPI_BURN_VERIFICATION_QUICK := 1
    static IMAPI_BURN_VERIFICATION_FULL := 2
}
struct IDiscMaster2 extends IDispatch {
    static IID := "{27354130-7F64-5B0F-8F00-5D77AFBE261E}"
    get__NewEnum(ppunk)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, ppunk)
    get_Item(index, value)
      => ComCall(8, this.p, Int32, index, BSTR.Ptr, value)
    get_Count(value)
      => ComCall(9, this.p, Int32.Ptr, value)
    get_IsSupportedEnvironment(value)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, value)
}
struct DDiscMaster2Events extends IDispatch {
    static IID := "{27354131-7F64-5B0F-8F00-5D77AFBE261E}"
    NotifyDeviceAdded(object, uniqueId)
      => ComCall(7, this.p, IDispatch, object, BSTR, uniqueId)
    NotifyDeviceRemoved(object, uniqueId)
      => ComCall(8, this.p, IDispatch, object, BSTR, uniqueId)
}
struct IDiscRecorder2Ex extends IUnknown {
    static IID := "{27354132-7F64-5B0F-8F00-5D77AFBE261E}"
    SendCommandNoData(Cdb, SenseBuffer, Timeout)
      => ComCall(3, this.p, UInt8.Ptr, Cdb, UInt32, Cdb.Length, UInt8.Ptr, SenseBuffer, UInt32, Timeout)
    SendCommandSendDataToDevice(Cdb, SenseBuffer, Timeout, Buffer)
      => ComCall(4, this.p, UInt8.Ptr, Cdb, UInt32, Cdb.Length, UInt8.Ptr, SenseBuffer, UInt32, Timeout, UInt8.Ptr, Buffer, UInt32, Buffer.Length)
    SendCommandGetDataFromDevice(Cdb, SenseBuffer, Timeout, Buffer, BufferFetched)
      => ComCall(5, this.p, UInt8.Ptr, Cdb, UInt32, Cdb.Length, UInt8.Ptr, SenseBuffer, UInt32, Timeout, UInt8.Ptr, Buffer, UInt32, Buffer.Length, UInt32.Ptr, BufferFetched)
    ReadDvdStructure(format, address, layer, agid, data, count)
      => ComCall(6, this.p, UInt32, format, UInt32, address, UInt32, layer, UInt32, agid, UInt8.Ptr.Ptr, data, UInt32.Ptr, count)
    SendDvdStructure(format, data)
      => ComCall(7, this.p, UInt32, format, UInt8.Ptr, data, UInt32, data.Length)
    GetAdapterDescriptor(data, byteSize)
      => ComCall(8, this.p, UInt8.Ptr.Ptr, data, UInt32.Ptr, byteSize)
    GetDeviceDescriptor(data, byteSize)
      => ComCall(9, this.p, UInt8.Ptr.Ptr, data, UInt32.Ptr, byteSize)
    GetDiscInformation(discInformation, byteSize)
      => ComCall(10, this.p, UInt8.Ptr.Ptr, discInformation, UInt32.Ptr, byteSize)
    GetTrackInformation(address, addressType, trackInformation, byteSize)
      => ComCall(11, this.p, UInt32, address, IMAPI_READ_TRACK_ADDRESS_TYPE, addressType, UInt8.Ptr.Ptr, trackInformation, UInt32.Ptr, byteSize)
    GetFeaturePage(requestedFeature, currentFeatureOnly, featureData, byteSize)
      => ComCall(12, this.p, IMAPI_FEATURE_PAGE_TYPE, requestedFeature, BOOLEAN, currentFeatureOnly, UInt8.Ptr.Ptr, featureData, UInt32.Ptr, byteSize)
    GetModePage(requestedModePage, requestType, modePageData, byteSize)
      => ComCall(13, this.p, IMAPI_MODE_PAGE_TYPE, requestedModePage, IMAPI_MODE_PAGE_REQUEST_TYPE, requestType, UInt8.Ptr.Ptr, modePageData, UInt32.Ptr, byteSize)
    SetModePage(requestType, data)
      => ComCall(14, this.p, IMAPI_MODE_PAGE_REQUEST_TYPE, requestType, UInt8.Ptr, data, UInt32, data.Length)
    GetSupportedFeaturePages(currentFeatureOnly, featureData, byteSize)
      => ComCall(15, this.p, BOOLEAN, currentFeatureOnly, IMAPI_FEATURE_PAGE_TYPE.Ptr.Ptr, featureData, UInt32.Ptr, byteSize)
    GetSupportedProfiles(currentOnly, profileTypes, validProfiles)
      => ComCall(16, this.p, BOOLEAN, currentOnly, IMAPI_PROFILE_TYPE.Ptr.Ptr, profileTypes, UInt32.Ptr, validProfiles)
    GetSupportedModePages(requestType, modePageTypes, validPages)
      => ComCall(17, this.p, IMAPI_MODE_PAGE_REQUEST_TYPE, requestType, IMAPI_MODE_PAGE_TYPE.Ptr.Ptr, modePageTypes, UInt32.Ptr, validPages)
    GetByteAlignmentMask(value)
      => ComCall(18, this.p, UInt32.Ptr, value)
    GetMaximumNonPageAlignedTransferSize(value)
      => ComCall(19, this.p, UInt32.Ptr, value)
    GetMaximumPageAlignedTransferSize(value)
      => ComCall(20, this.p, UInt32.Ptr, value)
}
struct IDiscRecorder2 extends IDispatch {
    static IID := "{27354133-7F64-5B0F-8F00-5D77AFBE261E}"
    EjectMedia()
      => ComCall(7, this.p)
    CloseTray()
      => ComCall(8, this.p)
    AcquireExclusiveAccess(force, __MIDL__IDiscRecorder20000)
      => ComCall(9, this.p, VARIANT_BOOL, force, BSTR, __MIDL__IDiscRecorder20000)
    ReleaseExclusiveAccess()
      => ComCall(10, this.p)
    DisableMcn()
      => ComCall(11, this.p)
    EnableMcn()
      => ComCall(12, this.p)
    InitializeDiscRecorder(recorderUniqueId)
      => ComCall(13, this.p, BSTR, recorderUniqueId)
    get_ActiveDiscRecorder(value)
      => ComCall(14, this.p, BSTR.Ptr, value)
    get_VendorId(value)
      => ComCall(15, this.p, BSTR.Ptr, value)
    get_ProductId(value)
      => ComCall(16, this.p, BSTR.Ptr, value)
    get_ProductRevision(value)
      => ComCall(17, this.p, BSTR.Ptr, value)
    get_VolumeName(value)
      => ComCall(18, this.p, BSTR.Ptr, value)
    get_VolumePathNames(value)
      => ComCall(19, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_DeviceCanLoadMedia(value)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, value)
    get_LegacyDeviceNumber(legacyDeviceNumber)
      => ComCall(21, this.p, Int32.Ptr, legacyDeviceNumber)
    get_SupportedFeaturePages(value)
      => ComCall(22, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_CurrentFeaturePages(value)
      => ComCall(23, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_SupportedProfiles(value)
      => ComCall(24, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_CurrentProfiles(value)
      => ComCall(25, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_SupportedModePages(value)
      => ComCall(26, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_ExclusiveAccessOwner(value)
      => ComCall(27, this.p, BSTR.Ptr, value)
}
struct IWriteEngine2 extends IDispatch {
    static IID := "{27354135-7F64-5B0F-8F00-5D77AFBE261E}"
    WriteSection(data, startingBlockAddress, numberOfBlocks)
      => ComCall(7, this.p, IStream, data, Int32, startingBlockAddress, Int32, numberOfBlocks)
    CancelWrite()
      => ComCall(8, this.p)
    put_Recorder(value)
      => ComCall(9, this.p, IDiscRecorder2Ex, value)
    get_Recorder(value)
      => ComCall(10, this.p, IDiscRecorder2Ex.Ptr, value)
    put_UseStreamingWrite12(value)
      => ComCall(11, this.p, VARIANT_BOOL, value)
    get_UseStreamingWrite12(value)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, value)
    put_StartingSectorsPerSecond(value)
      => ComCall(13, this.p, Int32, value)
    get_StartingSectorsPerSecond(value)
      => ComCall(14, this.p, Int32.Ptr, value)
    put_EndingSectorsPerSecond(value)
      => ComCall(15, this.p, Int32, value)
    get_EndingSectorsPerSecond(value)
      => ComCall(16, this.p, Int32.Ptr, value)
    put_BytesPerSector(value)
      => ComCall(17, this.p, Int32, value)
    get_BytesPerSector(value)
      => ComCall(18, this.p, Int32.Ptr, value)
    get_WriteInProgress(value)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, value)
}
struct IWriteEngine2EventArgs extends IDispatch {
    static IID := "{27354136-7F64-5B0F-8F00-5D77AFBE261E}"
    get_StartLba(value)
      => ComCall(7, this.p, Int32.Ptr, value)
    get_SectorCount(value)
      => ComCall(8, this.p, Int32.Ptr, value)
    get_LastReadLba(value)
      => ComCall(9, this.p, Int32.Ptr, value)
    get_LastWrittenLba(value)
      => ComCall(10, this.p, Int32.Ptr, value)
    get_TotalSystemBuffer(value)
      => ComCall(11, this.p, Int32.Ptr, value)
    get_UsedSystemBuffer(value)
      => ComCall(12, this.p, Int32.Ptr, value)
    get_FreeSystemBuffer(value)
      => ComCall(13, this.p, Int32.Ptr, value)
}
struct DWriteEngine2Events extends IDispatch {
    static IID := "{27354137-7F64-5B0F-8F00-5D77AFBE261E}"
    Update(object, progress)
      => ComCall(7, this.p, IDispatch, object, IDispatch, progress)
}
struct IDiscFormat2 extends IDispatch {
    static IID := "{27354152-8F64-5B0F-8F00-5D77AFBE261E}"
    IsRecorderSupported(recorder, value)
      => ComCall(7, this.p, IDiscRecorder2, recorder, VARIANT_BOOL.Ptr, value)
    IsCurrentMediaSupported(recorder, value)
      => ComCall(8, this.p, IDiscRecorder2, recorder, VARIANT_BOOL.Ptr, value)
    get_MediaPhysicallyBlank(value)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, value)
    get_MediaHeuristicallyBlank(value)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, value)
    get_SupportedMediaTypes(value)
      => ComCall(11, this.p, SAFEARRAY.Ptr.Ptr, value)
}
struct IDiscFormat2Erase extends IDiscFormat2 {
    static IID := "{27354156-8F64-5B0F-8F00-5D77AFBE261E}"
    put_Recorder(value)
      => ComCall(12, this.p, IDiscRecorder2, value)
    get_Recorder(value)
      => ComCall(13, this.p, IDiscRecorder2.Ptr, value)
    put_FullErase(value)
      => ComCall(14, this.p, VARIANT_BOOL, value)
    get_FullErase(value)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentPhysicalMediaType(value)
      => ComCall(16, this.p, IMAPI_MEDIA_PHYSICAL_TYPE.Ptr, value)
    put_ClientName(value)
      => ComCall(17, this.p, BSTR, value)
    get_ClientName(value)
      => ComCall(18, this.p, BSTR.Ptr, value)
    EraseMedia()
      => ComCall(19, this.p)
}
struct DDiscFormat2EraseEvents extends IDispatch {
    static IID := "{2735413A-7F64-5B0F-8F00-5D77AFBE261E}"
    Update(object, elapsedSeconds, estimatedTotalSeconds)
      => ComCall(7, this.p, IDispatch, object, Int32, elapsedSeconds, Int32, estimatedTotalSeconds)
}
struct IDiscFormat2Data extends IDiscFormat2 {
    static IID := "{27354153-9F64-5B0F-8F00-5D77AFBE261E}"
    put_Recorder(value)
      => ComCall(12, this.p, IDiscRecorder2, value)
    get_Recorder(value)
      => ComCall(13, this.p, IDiscRecorder2.Ptr, value)
    put_BufferUnderrunFreeDisabled(value)
      => ComCall(14, this.p, VARIANT_BOOL, value)
    get_BufferUnderrunFreeDisabled(value)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, value)
    put_PostgapAlreadyInImage(value)
      => ComCall(16, this.p, VARIANT_BOOL, value)
    get_PostgapAlreadyInImage(value)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentMediaStatus(value)
      => ComCall(18, this.p, IMAPI_FORMAT2_DATA_MEDIA_STATE.Ptr, value)
    get_WriteProtectStatus(value)
      => ComCall(19, this.p, IMAPI_MEDIA_WRITE_PROTECT_STATE.Ptr, value)
    get_TotalSectorsOnMedia(value)
      => ComCall(20, this.p, Int32.Ptr, value)
    get_FreeSectorsOnMedia(value)
      => ComCall(21, this.p, Int32.Ptr, value)
    get_NextWritableAddress(value)
      => ComCall(22, this.p, Int32.Ptr, value)
    get_StartAddressOfPreviousSession(value)
      => ComCall(23, this.p, Int32.Ptr, value)
    get_LastWrittenAddressOfPreviousSession(value)
      => ComCall(24, this.p, Int32.Ptr, value)
    put_ForceMediaToBeClosed(value)
      => ComCall(25, this.p, VARIANT_BOOL, value)
    get_ForceMediaToBeClosed(value)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, value)
    put_DisableConsumerDvdCompatibilityMode(value)
      => ComCall(27, this.p, VARIANT_BOOL, value)
    get_DisableConsumerDvdCompatibilityMode(value)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentPhysicalMediaType(value)
      => ComCall(29, this.p, IMAPI_MEDIA_PHYSICAL_TYPE.Ptr, value)
    put_ClientName(value)
      => ComCall(30, this.p, BSTR, value)
    get_ClientName(value)
      => ComCall(31, this.p, BSTR.Ptr, value)
    get_RequestedWriteSpeed(value)
      => ComCall(32, this.p, Int32.Ptr, value)
    get_RequestedRotationTypeIsPureCAV(value)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentWriteSpeed(value)
      => ComCall(34, this.p, Int32.Ptr, value)
    get_CurrentRotationTypeIsPureCAV(value)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, value)
    get_SupportedWriteSpeeds(supportedSpeeds)
      => ComCall(36, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeeds)
    get_SupportedWriteSpeedDescriptors(supportedSpeedDescriptors)
      => ComCall(37, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeedDescriptors)
    put_ForceOverwrite(value)
      => ComCall(38, this.p, VARIANT_BOOL, value)
    get_ForceOverwrite(value)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, value)
    get_MultisessionInterfaces(value)
      => ComCall(40, this.p, SAFEARRAY.Ptr.Ptr, value)
    Write(data)
      => ComCall(41, this.p, IStream, data)
    CancelWrite()
      => ComCall(42, this.p)
    SetWriteSpeed(RequestedSectorsPerSecond, RotationTypeIsPureCAV)
      => ComCall(43, this.p, Int32, RequestedSectorsPerSecond, VARIANT_BOOL, RotationTypeIsPureCAV)
}
struct DDiscFormat2DataEvents extends IDispatch {
    static IID := "{2735413C-7F64-5B0F-8F00-5D77AFBE261E}"
    Update(object, progress)
      => ComCall(7, this.p, IDispatch, object, IDispatch, progress)
}
struct IDiscFormat2DataEventArgs extends IWriteEngine2EventArgs {
    static IID := "{2735413D-7F64-5B0F-8F00-5D77AFBE261E}"
    get_ElapsedTime(value)
      => ComCall(14, this.p, Int32.Ptr, value)
    get_RemainingTime(value)
      => ComCall(15, this.p, Int32.Ptr, value)
    get_TotalTime(value)
      => ComCall(16, this.p, Int32.Ptr, value)
    get_CurrentAction(value)
      => ComCall(17, this.p, IMAPI_FORMAT2_DATA_WRITE_ACTION.Ptr, value)
}
struct IDiscFormat2TrackAtOnce extends IDiscFormat2 {
    static IID := "{27354154-8F64-5B0F-8F00-5D77AFBE261E}"
    PrepareMedia()
      => ComCall(12, this.p)
    AddAudioTrack(data)
      => ComCall(13, this.p, IStream, data)
    CancelAddTrack()
      => ComCall(14, this.p)
    ReleaseMedia()
      => ComCall(15, this.p)
    SetWriteSpeed(RequestedSectorsPerSecond, RotationTypeIsPureCAV)
      => ComCall(16, this.p, Int32, RequestedSectorsPerSecond, VARIANT_BOOL, RotationTypeIsPureCAV)
    put_Recorder(value)
      => ComCall(17, this.p, IDiscRecorder2, value)
    get_Recorder(value)
      => ComCall(18, this.p, IDiscRecorder2.Ptr, value)
    put_BufferUnderrunFreeDisabled(value)
      => ComCall(19, this.p, VARIANT_BOOL, value)
    get_BufferUnderrunFreeDisabled(value)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, value)
    get_NumberOfExistingTracks(value)
      => ComCall(21, this.p, Int32.Ptr, value)
    get_TotalSectorsOnMedia(value)
      => ComCall(22, this.p, Int32.Ptr, value)
    get_FreeSectorsOnMedia(value)
      => ComCall(23, this.p, Int32.Ptr, value)
    get_UsedSectorsOnMedia(value)
      => ComCall(24, this.p, Int32.Ptr, value)
    put_DoNotFinalizeMedia(value)
      => ComCall(25, this.p, VARIANT_BOOL, value)
    get_DoNotFinalizeMedia(value)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, value)
    get_ExpectedTableOfContents(value)
      => ComCall(27, this.p, SAFEARRAY.Ptr.Ptr, value)
    get_CurrentPhysicalMediaType(value)
      => ComCall(28, this.p, IMAPI_MEDIA_PHYSICAL_TYPE.Ptr, value)
    put_ClientName(value)
      => ComCall(29, this.p, BSTR, value)
    get_ClientName(value)
      => ComCall(30, this.p, BSTR.Ptr, value)
    get_RequestedWriteSpeed(value)
      => ComCall(31, this.p, Int32.Ptr, value)
    get_RequestedRotationTypeIsPureCAV(value)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentWriteSpeed(value)
      => ComCall(33, this.p, Int32.Ptr, value)
    get_CurrentRotationTypeIsPureCAV(value)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, value)
    get_SupportedWriteSpeeds(supportedSpeeds)
      => ComCall(35, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeeds)
    get_SupportedWriteSpeedDescriptors(supportedSpeedDescriptors)
      => ComCall(36, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeedDescriptors)
}
struct DDiscFormat2TrackAtOnceEvents extends IDispatch {
    static IID := "{2735413F-7F64-5B0F-8F00-5D77AFBE261E}"
    Update(object, progress)
      => ComCall(7, this.p, IDispatch, object, IDispatch, progress)
}
struct IDiscFormat2TrackAtOnceEventArgs extends IWriteEngine2EventArgs {
    static IID := "{27354140-7F64-5B0F-8F00-5D77AFBE261E}"
    get_CurrentTrackNumber(value)
      => ComCall(14, this.p, Int32.Ptr, value)
    get_CurrentAction(value)
      => ComCall(15, this.p, IMAPI_FORMAT2_TAO_WRITE_ACTION.Ptr, value)
    get_ElapsedTime(value)
      => ComCall(16, this.p, Int32.Ptr, value)
    get_RemainingTime(value)
      => ComCall(17, this.p, Int32.Ptr, value)
}
struct IDiscFormat2RawCD extends IDiscFormat2 {
    static IID := "{27354155-8F64-5B0F-8F00-5D77AFBE261E}"
    PrepareMedia()
      => ComCall(12, this.p)
    WriteMedia(data)
      => ComCall(13, this.p, IStream, data)
    WriteMedia2(data, streamLeadInSectors)
      => ComCall(14, this.p, IStream, data, Int32, streamLeadInSectors)
    CancelWrite()
      => ComCall(15, this.p)
    ReleaseMedia()
      => ComCall(16, this.p)
    SetWriteSpeed(RequestedSectorsPerSecond, RotationTypeIsPureCAV)
      => ComCall(17, this.p, Int32, RequestedSectorsPerSecond, VARIANT_BOOL, RotationTypeIsPureCAV)
    put_Recorder(value)
      => ComCall(18, this.p, IDiscRecorder2, value)
    get_Recorder(value)
      => ComCall(19, this.p, IDiscRecorder2.Ptr, value)
    put_BufferUnderrunFreeDisabled(value)
      => ComCall(20, this.p, VARIANT_BOOL, value)
    get_BufferUnderrunFreeDisabled(value)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, value)
    get_StartOfNextSession(value)
      => ComCall(22, this.p, Int32.Ptr, value)
    get_LastPossibleStartOfLeadout(value)
      => ComCall(23, this.p, Int32.Ptr, value)
    get_CurrentPhysicalMediaType(value)
      => ComCall(24, this.p, IMAPI_MEDIA_PHYSICAL_TYPE.Ptr, value)
    get_SupportedSectorTypes(value)
      => ComCall(25, this.p, SAFEARRAY.Ptr.Ptr, value)
    put_RequestedSectorType(value)
      => ComCall(26, this.p, IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE, value)
    get_RequestedSectorType(value)
      => ComCall(27, this.p, IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE.Ptr, value)
    put_ClientName(value)
      => ComCall(28, this.p, BSTR, value)
    get_ClientName(value)
      => ComCall(29, this.p, BSTR.Ptr, value)
    get_RequestedWriteSpeed(value)
      => ComCall(30, this.p, Int32.Ptr, value)
    get_RequestedRotationTypeIsPureCAV(value)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, value)
    get_CurrentWriteSpeed(value)
      => ComCall(32, this.p, Int32.Ptr, value)
    get_CurrentRotationTypeIsPureCAV(value)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, value)
    get_SupportedWriteSpeeds(supportedSpeeds)
      => ComCall(34, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeeds)
    get_SupportedWriteSpeedDescriptors(supportedSpeedDescriptors)
      => ComCall(35, this.p, SAFEARRAY.Ptr.Ptr, supportedSpeedDescriptors)
}
struct DDiscFormat2RawCDEvents extends IDispatch {
    static IID := "{27354142-7F64-5B0F-8F00-5D77AFBE261E}"
    Update(object, progress)
      => ComCall(7, this.p, IDispatch, object, IDispatch, progress)
}
struct IDiscFormat2RawCDEventArgs extends IWriteEngine2EventArgs {
    static IID := "{27354143-7F64-5B0F-8F00-5D77AFBE261E}"
    get_CurrentAction(value)
      => ComCall(14, this.p, IMAPI_FORMAT2_RAW_CD_WRITE_ACTION.Ptr, value)
    get_ElapsedTime(value)
      => ComCall(15, this.p, Int32.Ptr, value)
    get_RemainingTime(value)
      => ComCall(16, this.p, Int32.Ptr, value)
}
struct IBurnVerification extends IUnknown {
    static IID := "{D2FFD834-958B-426D-8470-2A13879C6A91}"
    put_BurnVerificationLevel(value)
      => ComCall(3, this.p, IMAPI_BURN_VERIFICATION_LEVEL, value)
    get_BurnVerificationLevel(value)
      => ComCall(4, this.p, IMAPI_BURN_VERIFICATION_LEVEL.Ptr, value)
}
struct IWriteSpeedDescriptor extends IDispatch {
    static IID := "{27354144-7F64-5B0F-8F00-5D77AFBE261E}"
    get_MediaType(value)
      => ComCall(7, this.p, IMAPI_MEDIA_PHYSICAL_TYPE.Ptr, value)
    get_RotationTypeIsPureCAV(value)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, value)
    get_WriteSpeed(value)
      => ComCall(9, this.p, Int32.Ptr, value)
}
struct IMultisession extends IDispatch {
    static IID := "{27354150-7F64-5B0F-8F00-5D77AFBE261E}"
    get_IsSupportedOnCurrentMediaState(value)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, value)
    put_InUse(value)
      => ComCall(8, this.p, VARIANT_BOOL, value)
    get_InUse(value)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, value)
    get_ImportRecorder(value)
      => ComCall(10, this.p, IDiscRecorder2.Ptr, value)
}
struct IMultisessionSequential extends IMultisession {
    static IID := "{27354151-7F64-5B0F-8F00-5D77AFBE261E}"
    get_IsFirstDataSession(value)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, value)
    get_StartAddressOfPreviousSession(value)
      => ComCall(12, this.p, Int32.Ptr, value)
    get_LastWrittenAddressOfPreviousSession(value)
      => ComCall(13, this.p, Int32.Ptr, value)
    get_NextWritableAddress(value)
      => ComCall(14, this.p, Int32.Ptr, value)
    get_FreeSectorsOnMedia(value)
      => ComCall(15, this.p, Int32.Ptr, value)
}
struct IMultisessionSequential2 extends IMultisessionSequential {
    static IID := "{B507CA22-2204-11DD-966A-001AA01BBC58}"
    get_WriteUnitSize(value)
      => ComCall(16, this.p, Int32.Ptr, value)
}
struct IMultisessionRandomWrite extends IMultisession {
    static IID := "{B507CA23-2204-11DD-966A-001AA01BBC58}"
    get_WriteUnitSize(value)
      => ComCall(11, this.p, Int32.Ptr, value)
    get_LastWrittenAddress(value)
      => ComCall(12, this.p, Int32.Ptr, value)
    get_TotalSectorsOnMedia(value)
      => ComCall(13, this.p, Int32.Ptr, value)
}
struct IStreamPseudoRandomBased extends IStream {
    static IID := "{27354145-7F64-5B0F-8F00-5D77AFBE261E}"
    put_Seed(value)
      => ComCall(14, this.p, UInt32, value)
    get_Seed(value)
      => ComCall(15, this.p, UInt32.Ptr, value)
    put_ExtendedSeed(values)
      => ComCall(16, this.p, UInt32.Ptr, values, UInt32, values.Length)
    get_ExtendedSeed(values)
      => ComCall(17, this.p, UInt32.Ptr.Ptr, values, UInt32.Ptr, values.Length)
}
struct IStreamConcatenate extends IStream {
    static IID := "{27354146-7F64-5B0F-8F00-5D77AFBE261E}"
    Initialize(stream1, stream2)
      => ComCall(14, this.p, IStream, stream1, IStream, stream2)
    Initialize2(streams)
      => ComCall(15, this.p, IStream.Ptr, streams, UInt32, streams.Length)
    Append(stream)
      => ComCall(16, this.p, IStream, stream)
    Append2(streams)
      => ComCall(17, this.p, IStream.Ptr, streams, UInt32, streams.Length)
}
struct IStreamInterleave extends IStream {
    static IID := "{27354147-7F64-5B0F-8F00-5D77AFBE261E}"
    Initialize(streams, interleaveSizes)
      => ComCall(14, this.p, IStream.Ptr, streams, UInt32.Ptr, interleaveSizes, UInt32, interleaveSizes.Length)
}
struct IRawCDImageCreator extends IDispatch {
    static IID := "{25983550-9D65-49CE-B335-40630D901227}"
    CreateResultImage(resultStream)
      => ComCall(7, this.p, IStream.Ptr, resultStream)
    AddTrack(dataType, data, trackIndex)
      => ComCall(8, this.p, IMAPI_CD_SECTOR_TYPE, dataType, IStream, data, Int32.Ptr, trackIndex)
    AddSpecialPregap(data)
      => ComCall(9, this.p, IStream, data)
    AddSubcodeRWGenerator(subcode)
      => ComCall(10, this.p, IStream, subcode)
    put_ResultingImageType(value)
      => ComCall(11, this.p, IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE, value)
    get_ResultingImageType(value)
      => ComCall(12, this.p, IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE.Ptr, value)
    get_StartOfLeadout(value)
      => ComCall(13, this.p, Int32.Ptr, value)
    put_StartOfLeadoutLimit(value)
      => ComCall(14, this.p, Int32, value)
    get_StartOfLeadoutLimit(value)
      => ComCall(15, this.p, Int32.Ptr, value)
    put_DisableGaplessAudio(value)
      => ComCall(16, this.p, VARIANT_BOOL, value)
    get_DisableGaplessAudio(value)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, value)
    put_MediaCatalogNumber(value)
      => ComCall(18, this.p, BSTR, value)
    get_MediaCatalogNumber(value)
      => ComCall(19, this.p, BSTR.Ptr, value)
    put_StartingTrackNumber(value)
      => ComCall(20, this.p, Int32, value)
    get_StartingTrackNumber(value)
      => ComCall(21, this.p, Int32.Ptr, value)
    get_TrackInfo(trackIndex, value)
      => ComCall(22, this.p, Int32, trackIndex, IRawCDImageTrackInfo.Ptr, value)
    get_NumberOfExistingTracks(value)
      => ComCall(23, this.p, Int32.Ptr, value)
    get_LastUsedUserSectorInImage(value)
      => ComCall(24, this.p, Int32.Ptr, value)
    get_ExpectedTableOfContents(value)
      => ComCall(25, this.p, SAFEARRAY.Ptr.Ptr, value)
}
struct IRawCDImageTrackInfo extends IDispatch {
    static IID := "{25983551-9D65-49CE-B335-40630D901227}"
    get_StartingLba(value)
      => ComCall(7, this.p, Int32.Ptr, value)
    get_SectorCount(value)
      => ComCall(8, this.p, Int32.Ptr, value)
    get_TrackNumber(value)
      => ComCall(9, this.p, Int32.Ptr, value)
    get_SectorType(value)
      => ComCall(10, this.p, IMAPI_CD_SECTOR_TYPE.Ptr, value)
    get_ISRC(value)
      => ComCall(11, this.p, BSTR.Ptr, value)
    put_ISRC(value)
      => ComCall(12, this.p, BSTR, value)
    get_DigitalAudioCopySetting(value)
      => ComCall(13, this.p, IMAPI_CD_TRACK_DIGITAL_COPY_SETTING.Ptr, value)
    put_DigitalAudioCopySetting(value)
      => ComCall(14, this.p, IMAPI_CD_TRACK_DIGITAL_COPY_SETTING, value)
    get_AudioHasPreemphasis(value)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, value)
    put_AudioHasPreemphasis(value)
      => ComCall(16, this.p, VARIANT_BOOL, value)
    get_TrackIndexes(value)
      => ComCall(17, this.p, SAFEARRAY.Ptr.Ptr, value)
    AddTrackIndex(lbaOffset)
      => ComCall(18, this.p, Int32, lbaOffset)
    ClearTrackIndex(lbaOffset)
      => ComCall(19, this.p, Int32, lbaOffset)
}
struct IBlockRange extends IDispatch {
    static IID := "{B507CA25-2204-11DD-966A-001AA01BBC58}"
    get_StartLba(value)
      => ComCall(7, this.p, Int32.Ptr, value)
    get_EndLba(value)
      => ComCall(8, this.p, Int32.Ptr, value)
}
struct IBlockRangeList extends IDispatch {
    static IID := "{B507CA26-2204-11DD-966A-001AA01BBC58}"
    get_BlockRanges(value)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, value)
}
struct FsiItemType extends Int32 {
    static FsiItemNotFound := 0
    static FsiItemDirectory := 1
    static FsiItemFile := 2
}
struct FsiFileSystems extends Int32 {
    static FsiFileSystemNone := 0
    static FsiFileSystemISO9660 := 1
    static FsiFileSystemJoliet := 2
    static FsiFileSystemUDF := 4
    static FsiFileSystemUnknown := 1073741824
}
struct EmulationType extends Int32 {
    static EmulationNone := 0
    static Emulation12MFloppy := 1
    static Emulation144MFloppy := 2
    static Emulation288MFloppy := 3
    static EmulationHardDisk := 4
}
struct PlatformId extends Int32 {
    static PlatformX86 := 0
    static PlatformPowerPC := 1
    static PlatformMac := 2
    static PlatformEFI := 239
}
struct IBootOptions extends IDispatch {
    static IID := "{2C941FD4-975B-59BE-A960-9A2A262853A5}"
    get_BootImage(pVal)
      => ComCall(7, this.p, IStream.Ptr, pVal)
    get_Manufacturer(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    put_Manufacturer(newVal)
      => ComCall(9, this.p, BSTR, newVal)
    get_PlatformId(pVal)
      => ComCall(10, this.p, PlatformId.Ptr, pVal)
    put_PlatformId(newVal)
      => ComCall(11, this.p, PlatformId, newVal)
    get_Emulation(pVal)
      => ComCall(12, this.p, EmulationType.Ptr, pVal)
    put_Emulation(newVal)
      => ComCall(13, this.p, EmulationType, newVal)
    get_ImageSize(pVal)
      => ComCall(14, this.p, UInt32.Ptr, pVal)
    AssignBootImage(newVal)
      => ComCall(15, this.p, IStream, newVal)
}
struct IProgressItem extends IDispatch {
    static IID := "{2C941FD5-975B-59BE-A960-9A2A262853A5}"
    get_Description(desc)
      => ComCall(7, this.p, BSTR.Ptr, desc)
    get_FirstBlock(block)
      => ComCall(8, this.p, UInt32.Ptr, block)
    get_LastBlock(block)
      => ComCall(9, this.p, UInt32.Ptr, block)
    get_BlockCount(blocks)
      => ComCall(10, this.p, UInt32.Ptr, blocks)
}
struct IEnumProgressItems extends IUnknown {
    static IID := "{2C941FD6-975B-59BE-A960-9A2A262853A5}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IProgressItem.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumProgressItems.Ptr, ppEnum)
}
struct IProgressItems extends IDispatch {
    static IID := "{2C941FD7-975B-59BE-A960-9A2A262853A5}"
    get__NewEnum(NewEnum)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, NewEnum)
    get_Item(Index, item)
      => ComCall(8, this.p, Int32, Index, IProgressItem.Ptr, item)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
    ProgressItemFromBlock(block, item)
      => ComCall(10, this.p, UInt32, block, IProgressItem.Ptr, item)
    ProgressItemFromDescription(description, item)
      => ComCall(11, this.p, BSTR, description, IProgressItem.Ptr, item)
    get_EnumProgressItems(NewEnum)
      => ComCall(12, this.p, IEnumProgressItems.Ptr, NewEnum)
}
struct IFileSystemImageResult extends IDispatch {
    static IID := "{2C941FD8-975B-59BE-A960-9A2A262853A5}"
    get_ImageStream(pVal)
      => ComCall(7, this.p, IStream.Ptr, pVal)
    get_ProgressItems(pVal)
      => ComCall(8, this.p, IProgressItems.Ptr, pVal)
    get_TotalBlocks(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    get_BlockSize(pVal)
      => ComCall(10, this.p, Int32.Ptr, pVal)
    get_DiscId(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
}
struct IFileSystemImageResult2 extends IFileSystemImageResult {
    static IID := "{B507CA29-2204-11DD-966A-001AA01BBC58}"
    get_ModifiedBlocks(pVal)
      => ComCall(12, this.p, IBlockRangeList.Ptr, pVal)
}
struct IFsiItem extends IDispatch {
    static IID := "{2C941FD9-975B-59BE-A960-9A2A262853A5}"
    get_Name(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_FullPath(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_CreationTime(pVal)
      => ComCall(9, this.p, Float64.Ptr, pVal)
    put_CreationTime(newVal)
      => ComCall(10, this.p, Float64, newVal)
    get_LastAccessedTime(pVal)
      => ComCall(11, this.p, Float64.Ptr, pVal)
    put_LastAccessedTime(newVal)
      => ComCall(12, this.p, Float64, newVal)
    get_LastModifiedTime(pVal)
      => ComCall(13, this.p, Float64.Ptr, pVal)
    put_LastModifiedTime(newVal)
      => ComCall(14, this.p, Float64, newVal)
    get_IsHidden(pVal)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pVal)
    put_IsHidden(newVal)
      => ComCall(16, this.p, VARIANT_BOOL, newVal)
    FileSystemName(fileSystem, pVal)
      => ComCall(17, this.p, FsiFileSystems, fileSystem, BSTR.Ptr, pVal)
    FileSystemPath(fileSystem, pVal)
      => ComCall(18, this.p, FsiFileSystems, fileSystem, BSTR.Ptr, pVal)
}
struct IEnumFsiItems extends IUnknown {
    static IID := "{2C941FDA-975B-59BE-A960-9A2A262853A5}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IFsiItem.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumFsiItems.Ptr, ppEnum)
}
struct IFsiFileItem extends IFsiItem {
    static IID := "{2C941FDB-975B-59BE-A960-9A2A262853A5}"
    get_DataSize(pVal)
      => ComCall(19, this.p, Int64.Ptr, pVal)
    get_DataSize32BitLow(pVal)
      => ComCall(20, this.p, Int32.Ptr, pVal)
    get_DataSize32BitHigh(pVal)
      => ComCall(21, this.p, Int32.Ptr, pVal)
    get_Data(pVal)
      => ComCall(22, this.p, IStream.Ptr, pVal)
    put_Data(newVal)
      => ComCall(23, this.p, IStream, newVal)
}
struct IFsiFileItem2 extends IFsiFileItem {
    static IID := "{199D0C19-11E1-40EB-8EC2-C8C822A07792}"
    get_FsiNamedStreams(streams)
      => ComCall(24, this.p, IFsiNamedStreams.Ptr, streams)
    get_IsNamedStream(pVal)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pVal)
    AddStream(name, streamData)
      => ComCall(26, this.p, BSTR, name, IStream, streamData)
    RemoveStream(name)
      => ComCall(27, this.p, BSTR, name)
    get_IsRealTime(pVal)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pVal)
    put_IsRealTime(newVal)
      => ComCall(29, this.p, VARIANT_BOOL, newVal)
}
struct IFsiNamedStreams extends IDispatch {
    static IID := "{ED79BA56-5294-4250-8D46-F9AECEE23459}"
    get__NewEnum(NewEnum)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, NewEnum)
    get_Item(index, item)
      => ComCall(8, this.p, Int32, index, IFsiFileItem2.Ptr, item)
    get_Count(count)
      => ComCall(9, this.p, Int32.Ptr, count)
    get_EnumNamedStreams(NewEnum)
      => ComCall(10, this.p, IEnumFsiItems.Ptr, NewEnum)
}
struct IFsiDirectoryItem extends IFsiItem {
    static IID := "{2C941FDC-975B-59BE-A960-9A2A262853A5}"
    get__NewEnum(NewEnum)
      => ComCall(19, this.p, IEnumVARIANT.Ptr, NewEnum)
    get_Item(path, item)
      => ComCall(20, this.p, BSTR, path, IFsiItem.Ptr, item)
    get_Count(Count)
      => ComCall(21, this.p, Int32.Ptr, Count)
    get_EnumFsiItems(NewEnum)
      => ComCall(22, this.p, IEnumFsiItems.Ptr, NewEnum)
    AddDirectory(path)
      => ComCall(23, this.p, BSTR, path)
    AddFile(path, fileData)
      => ComCall(24, this.p, BSTR, path, IStream, fileData)
    AddTree(sourceDirectory, includeBaseDirectory)
      => ComCall(25, this.p, BSTR, sourceDirectory, VARIANT_BOOL, includeBaseDirectory)
    Add(item)
      => ComCall(26, this.p, IFsiItem, item)
    Remove(path)
      => ComCall(27, this.p, BSTR, path)
    RemoveTree(path)
      => ComCall(28, this.p, BSTR, path)
}
struct IFsiDirectoryItem2 extends IFsiDirectoryItem {
    static IID := "{F7FB4B9B-6D96-4D7B-9115-201B144811EF}"
    AddTreeWithNamedStreams(sourceDirectory, includeBaseDirectory)
      => ComCall(29, this.p, BSTR, sourceDirectory, VARIANT_BOOL, includeBaseDirectory)
}
struct IFileSystemImage extends IDispatch {
    static IID := "{2C941FE1-975B-59BE-A960-9A2A262853A5}"
    get_Root(pVal)
      => ComCall(7, this.p, IFsiDirectoryItem.Ptr, pVal)
    get_SessionStartBlock(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    put_SessionStartBlock(newVal)
      => ComCall(9, this.p, Int32, newVal)
    get_FreeMediaBlocks(pVal)
      => ComCall(10, this.p, Int32.Ptr, pVal)
    put_FreeMediaBlocks(newVal)
      => ComCall(11, this.p, Int32, newVal)
    SetMaxMediaBlocksFromDevice(discRecorder)
      => ComCall(12, this.p, IDiscRecorder2, discRecorder)
    get_UsedBlocks(pVal)
      => ComCall(13, this.p, Int32.Ptr, pVal)
    get_VolumeName(pVal)
      => ComCall(14, this.p, BSTR.Ptr, pVal)
    put_VolumeName(newVal)
      => ComCall(15, this.p, BSTR, newVal)
    get_ImportedVolumeName(pVal)
      => ComCall(16, this.p, BSTR.Ptr, pVal)
    get_BootImageOptions(pVal)
      => ComCall(17, this.p, IBootOptions.Ptr, pVal)
    put_BootImageOptions(newVal)
      => ComCall(18, this.p, IBootOptions, newVal)
    get_FileCount(pVal)
      => ComCall(19, this.p, Int32.Ptr, pVal)
    get_DirectoryCount(pVal)
      => ComCall(20, this.p, Int32.Ptr, pVal)
    get_WorkingDirectory(pVal)
      => ComCall(21, this.p, BSTR.Ptr, pVal)
    put_WorkingDirectory(newVal)
      => ComCall(22, this.p, BSTR, newVal)
    get_ChangePoint(pVal)
      => ComCall(23, this.p, Int32.Ptr, pVal)
    get_StrictFileSystemCompliance(pVal)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, pVal)
    put_StrictFileSystemCompliance(newVal)
      => ComCall(25, this.p, VARIANT_BOOL, newVal)
    get_UseRestrictedCharacterSet(pVal)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pVal)
    put_UseRestrictedCharacterSet(newVal)
      => ComCall(27, this.p, VARIANT_BOOL, newVal)
    get_FileSystemsToCreate(pVal)
      => ComCall(28, this.p, FsiFileSystems.Ptr, pVal)
    put_FileSystemsToCreate(newVal)
      => ComCall(29, this.p, FsiFileSystems, newVal)
    get_FileSystemsSupported(pVal)
      => ComCall(30, this.p, FsiFileSystems.Ptr, pVal)
    put_UDFRevision(newVal)
      => ComCall(31, this.p, Int32, newVal)
    get_UDFRevision(pVal)
      => ComCall(32, this.p, Int32.Ptr, pVal)
    get_UDFRevisionsSupported(pVal)
      => ComCall(33, this.p, SAFEARRAY.Ptr.Ptr, pVal)
    ChooseImageDefaults(discRecorder)
      => ComCall(34, this.p, IDiscRecorder2, discRecorder)
    ChooseImageDefaultsForMediaType(value)
      => ComCall(35, this.p, IMAPI_MEDIA_PHYSICAL_TYPE, value)
    put_ISO9660InterchangeLevel(newVal)
      => ComCall(36, this.p, Int32, newVal)
    get_ISO9660InterchangeLevel(pVal)
      => ComCall(37, this.p, Int32.Ptr, pVal)
    get_ISO9660InterchangeLevelsSupported(pVal)
      => ComCall(38, this.p, SAFEARRAY.Ptr.Ptr, pVal)
    CreateResultImage(resultStream)
      => ComCall(39, this.p, IFileSystemImageResult.Ptr, resultStream)
    Exists(fullPath, itemType)
      => ComCall(40, this.p, BSTR, fullPath, FsiItemType.Ptr, itemType)
    CalculateDiscIdentifier(discIdentifier)
      => ComCall(41, this.p, BSTR.Ptr, discIdentifier)
    IdentifyFileSystemsOnDisc(discRecorder, fileSystems)
      => ComCall(42, this.p, IDiscRecorder2, discRecorder, FsiFileSystems.Ptr, fileSystems)
    GetDefaultFileSystemForImport(fileSystems, importDefault)
      => ComCall(43, this.p, FsiFileSystems, fileSystems, FsiFileSystems.Ptr, importDefault)
    ImportFileSystem(importedFileSystem)
      => ComCall(44, this.p, FsiFileSystems.Ptr, importedFileSystem)
    ImportSpecificFileSystem(fileSystemToUse)
      => ComCall(45, this.p, FsiFileSystems, fileSystemToUse)
    RollbackToChangePoint(changePoint)
      => ComCall(46, this.p, Int32, changePoint)
    LockInChangePoint()
      => ComCall(47, this.p)
    CreateDirectoryItem(name, newItem)
      => ComCall(48, this.p, BSTR, name, IFsiDirectoryItem.Ptr, newItem)
    CreateFileItem(name, newItem)
      => ComCall(49, this.p, BSTR, name, IFsiFileItem.Ptr, newItem)
    get_VolumeNameUDF(pVal)
      => ComCall(50, this.p, BSTR.Ptr, pVal)
    get_VolumeNameJoliet(pVal)
      => ComCall(51, this.p, BSTR.Ptr, pVal)
    get_VolumeNameISO9660(pVal)
      => ComCall(52, this.p, BSTR.Ptr, pVal)
    get_StageFiles(pVal)
      => ComCall(53, this.p, VARIANT_BOOL.Ptr, pVal)
    put_StageFiles(newVal)
      => ComCall(54, this.p, VARIANT_BOOL, newVal)
    get_MultisessionInterfaces(pVal)
      => ComCall(55, this.p, SAFEARRAY.Ptr.Ptr, pVal)
    put_MultisessionInterfaces(newVal)
      => ComCall(56, this.p, SAFEARRAY.Ptr, newVal)
}
struct IFileSystemImage2 extends IFileSystemImage {
    static IID := "{D7644B2C-1537-4767-B62F-F1387B02DDFD}"
    get_BootImageOptionsArray(pVal)
      => ComCall(57, this.p, SAFEARRAY.Ptr.Ptr, pVal)
    put_BootImageOptionsArray(newVal)
      => ComCall(58, this.p, SAFEARRAY.Ptr, newVal)
}
struct IFileSystemImage3 extends IFileSystemImage2 {
    static IID := "{7CFF842C-7E97-4807-8304-910DD8F7C051}"
    get_CreateRedundantUdfMetadataFiles(pVal)
      => ComCall(59, this.p, VARIANT_BOOL.Ptr, pVal)
    put_CreateRedundantUdfMetadataFiles(newVal)
      => ComCall(60, this.p, VARIANT_BOOL, newVal)
    ProbeSpecificFileSystem(fileSystemToProbe, isAppendable)
      => ComCall(61, this.p, FsiFileSystems, fileSystemToProbe, VARIANT_BOOL.Ptr, isAppendable)
}
struct DFileSystemImageEvents extends IDispatch {
    static IID := "{2C941FDF-975B-59BE-A960-9A2A262853A5}"
    Update(object, currentFile, copiedSectors, totalSectors)
      => ComCall(7, this.p, IDispatch, object, BSTR, currentFile, Int32, copiedSectors, Int32, totalSectors)
}
struct DFileSystemImageImportEvents extends IDispatch {
    static IID := "{D25C30F9-4087-4366-9E24-E55BE286424B}"
    UpdateImport(object, fileSystem, currentItem, importedDirectoryItems, totalDirectoryItems, importedFileItems, totalFileItems)
      => ComCall(7, this.p, IDispatch, object, FsiFileSystems, fileSystem, BSTR, currentItem, Int32, importedDirectoryItems, Int32, totalDirectoryItems, Int32, importedFileItems, Int32, totalFileItems)
}
struct IIsoImageManager extends IDispatch {
    static IID := "{6CA38BE5-FBBB-4800-95A1-A438865EB0D4}"
    get_Path(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_Stream(data)
      => ComCall(8, this.p, IStream.Ptr, data)
    SetPath(Val)
      => ComCall(9, this.p, BSTR, Val)
    SetStream(data)
      => ComCall(10, this.p, IStream, data)
    Validate()
      => ComCall(11, this.p)
}
struct MEDIA_TYPES extends Int32 {
    static MEDIA_CDDA_CDROM := 1
    static MEDIA_CD_ROM_XA := 2
    static MEDIA_CD_I := 3
    static MEDIA_CD_EXTRA := 4
    static MEDIA_CD_OTHER := 5
    static MEDIA_SPECIAL := 6
}
struct MEDIA_FLAGS extends Int32 {
    static MEDIA_BLANK := 1
    static MEDIA_RW := 2
    static MEDIA_WRITABLE := 4
    static MEDIA_FORMAT_UNUSABLE_BY_IMAPI := 8
}
struct RECORDER_TYPES extends Int32 {
    static RECORDER_CDR := 1
    static RECORDER_CDRW := 2
}
struct IDiscRecorder extends IUnknown {
    static IID := "{85AC9776-CA88-4CF2-894E-09598C078A41}"
    Init(pbyUniqueID, nulDriveNumber)
      => ComCall(3, this.p, UInt8.Ptr, pbyUniqueID, UInt32, pbyUniqueID.Length, UInt32, nulDriveNumber)
    GetRecorderGUID(pbyUniqueID?, pulReturnSizeRequired)
      => ComCall(4, this.p, UInt8.Ptr, pbyUniqueID?, UInt32, pbyUniqueID?.Length ?? 0, UInt32.Ptr, pulReturnSizeRequired)
    GetRecorderType(fTypeCode)
      => ComCall(5, this.p, RECORDER_TYPES.Ptr, fTypeCode)
    GetDisplayNames(pbstrVendorID?, pbstrProductID?, pbstrRevision?)
      => ComCall(6, this.p, BSTR.Ptr, pbstrVendorID?, BSTR.Ptr, pbstrProductID?, BSTR.Ptr, pbstrRevision?)
    GetBasePnPID(pbstrBasePnPID)
      => ComCall(7, this.p, BSTR.Ptr, pbstrBasePnPID)
    GetPath(pbstrPath)
      => ComCall(8, this.p, BSTR.Ptr, pbstrPath)
    GetRecorderProperties(ppPropStg)
      => ComCall(9, this.p, IPropertyStorage.Ptr, ppPropStg)
    SetRecorderProperties(pPropStg?)
      => ComCall(10, this.p, IPropertyStorage, pPropStg?)
    GetRecorderState(pulDevStateFlags)
      => ComCall(11, this.p, DISC_RECORDER_STATE_FLAGS.Ptr, pulDevStateFlags)
    OpenExclusive()
      => ComCall(12, this.p)
    QueryMediaType(fMediaType, fMediaFlags)
      => ComCall(13, this.p, MEDIA_TYPES.Ptr, fMediaType, MEDIA_FLAGS.Ptr, fMediaFlags)
    QueryMediaInfo(pbSessions, pbLastTrack, ulStartAddress, ulNextWritable, ulFreeBlocks)
      => ComCall(14, this.p, UInt8.Ptr, pbSessions, UInt8.Ptr, pbLastTrack, UInt32.Ptr, ulStartAddress, UInt32.Ptr, ulNextWritable, UInt32.Ptr, ulFreeBlocks)
    Eject()
      => ComCall(15, this.p)
    Erase(bFullErase)
      => ComCall(16, this.p, UInt8, bFullErase)
    Close()
      => ComCall(17, this.p)
}
struct IEnumDiscRecorders extends IUnknown {
    static IID := "{9B1921E1-54AC-11D3-9144-00104BA11C5E}"
    Next(ppRecorder, pcFetched)
      => ComCall(3, this.p, UInt32, ppRecorder.Length, IDiscRecorder.Ptr, ppRecorder, UInt32.Ptr, pcFetched)
    Skip(cRecorders)
      => ComCall(4, this.p, UInt32, cRecorders)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDiscRecorders.Ptr, ppEnum)
}
struct IEnumDiscMasterFormats extends IUnknown {
    static IID := "{DDF445E1-54BA-11D3-9144-00104BA11C5E}"
    Next(lpiidFormatID, pcFetched)
      => ComCall(3, this.p, UInt32, lpiidFormatID.Length, GUID.Ptr, lpiidFormatID, UInt32.Ptr, pcFetched)
    Skip(cFormats)
      => ComCall(4, this.p, UInt32, cFormats)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDiscMasterFormats.Ptr, ppEnum)
}
struct IRedbookDiscMaster extends IUnknown {
    static IID := "{E3BC42CD-4E5C-11D3-9144-00104BA11C5E}"
    GetTotalAudioTracks(pnTracks)
      => ComCall(3, this.p, Int32.Ptr, pnTracks)
    GetTotalAudioBlocks(pnBlocks)
      => ComCall(4, this.p, Int32.Ptr, pnBlocks)
    GetUsedAudioBlocks(pnBlocks)
      => ComCall(5, this.p, Int32.Ptr, pnBlocks)
    GetAvailableAudioTrackBlocks(pnBlocks)
      => ComCall(6, this.p, Int32.Ptr, pnBlocks)
    GetAudioBlockSize(pnBlockBytes)
      => ComCall(7, this.p, Int32.Ptr, pnBlockBytes)
    CreateAudioTrack(nBlocks)
      => ComCall(8, this.p, Int32, nBlocks)
    AddAudioTrackBlocks(pby)
      => ComCall(9, this.p, UInt8.Ptr, pby, Int32, pby.Length)
    CloseAudioTrack()
      => ComCall(10, this.p)
}
struct IJolietDiscMaster extends IUnknown {
    static IID := "{E3BC42CE-4E5C-11D3-9144-00104BA11C5E}"
    GetTotalDataBlocks(pnBlocks)
      => ComCall(3, this.p, Int32.Ptr, pnBlocks)
    GetUsedDataBlocks(pnBlocks)
      => ComCall(4, this.p, Int32.Ptr, pnBlocks)
    GetDataBlockSize(pnBlockBytes)
      => ComCall(5, this.p, Int32.Ptr, pnBlockBytes)
    AddData(pStorage?, lFileOverwrite)
      => ComCall(6, this.p, IStorage, pStorage?, Int32, lFileOverwrite)
    GetJolietProperties(ppPropStg)
      => ComCall(7, this.p, IPropertyStorage.Ptr, ppPropStg)
    SetJolietProperties(pPropStg?)
      => ComCall(8, this.p, IPropertyStorage, pPropStg?)
}
struct IDiscMasterProgressEvents extends IUnknown {
    static IID := "{EC9E51C1-4E5D-11D3-9144-00104BA11C5E}"
    QueryCancel(pbCancel)
      => ComCall(3, this.p, UInt8.Ptr, pbCancel)
    NotifyPnPActivity()
      => ComCall(4, this.p)
    NotifyAddProgress(nCompletedSteps, nTotalSteps)
      => ComCall(5, this.p, Int32, nCompletedSteps, Int32, nTotalSteps)
    NotifyBlockProgress(nCompleted, nTotal)
      => ComCall(6, this.p, Int32, nCompleted, Int32, nTotal)
    NotifyTrackProgress(nCurrentTrack, nTotalTracks)
      => ComCall(7, this.p, Int32, nCurrentTrack, Int32, nTotalTracks)
    NotifyPreparingBurn(nEstimatedSeconds)
      => ComCall(8, this.p, Int32, nEstimatedSeconds)
    NotifyClosingDisc(nEstimatedSeconds)
      => ComCall(9, this.p, Int32, nEstimatedSeconds)
    NotifyBurnComplete(status)
      => ComCall(10, this.p, HRESULT, status)
    NotifyEraseComplete(status)
      => ComCall(11, this.p, HRESULT, status)
}
struct IDiscMaster extends IUnknown {
    static IID := "{520CCA62-51A5-11D3-9144-00104BA11C5E}"
    Open()
      => ComCall(3, this.p)
    EnumDiscMasterFormats(ppEnum)
      => ComCall(4, this.p, IEnumDiscMasterFormats.Ptr, ppEnum)
    GetActiveDiscMasterFormat(lpiid)
      => ComCall(5, this.p, GUID.Ptr, lpiid)
    SetActiveDiscMasterFormat(riid, ppUnk)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    EnumDiscRecorders(ppEnum)
      => ComCall(7, this.p, IEnumDiscRecorders.Ptr, ppEnum)
    GetActiveDiscRecorder(ppRecorder)
      => ComCall(8, this.p, IDiscRecorder.Ptr, ppRecorder)
    SetActiveDiscRecorder(pRecorder?)
      => ComCall(9, this.p, IDiscRecorder, pRecorder?)
    ClearFormatContent()
      => ComCall(10, this.p)
    ProgressAdvise(pEvents?, pvCookie)
      => ComCall(11, this.p, IDiscMasterProgressEvents, pEvents?, IntPtr.Ptr, pvCookie)
    ProgressUnadvise(vCookie)
      => ComCall(12, this.p, IntPtr, vCookie)
    RecordDisc(bSimulate, bEjectAfterBurn)
      => ComCall(13, this.p, UInt8, bSimulate, UInt8, bEjectAfterBurn)
    Close()
      => ComCall(14, this.p)
}
struct MSGCALLRELEASE extends FunctionPointer {
    static Types := [UInt32, IMessage, "Void"]
}
struct SPropAttrArray {
    cValues : UInt32
    aPropAttr : UInt32[1]
}
struct IMMPID_MP_ENUM extends Int32 {
    static IMMPID_MP_BEFORE__ := 4095
    static IMMPID_MP_RECIPIENT_LIST := 4096
    static IMMPID_MP_CONTENT_FILE_NAME := 4097
    static IMMPID_MP_SENDER_ADDRESS_SMTP := 4098
    static IMMPID_MP_SENDER_ADDRESS_X500 := 4099
    static IMMPID_MP_SENDER_ADDRESS_X400 := 4100
    static IMMPID_MP_SENDER_ADDRESS_LEGACY_EX_DN := 4101
    static IMMPID_MP_DOMAIN_LIST := 4102
    static IMMPID_MP_PICKUP_FILE_NAME := 4103
    static IMMPID_MP_AUTHENTICATED_USER_NAME := 4104
    static IMMPID_MP_CONNECTION_IP_ADDRESS := 4105
    static IMMPID_MP_HELO_DOMAIN := 4106
    static IMMPID_MP_EIGHTBIT_MIME_OPTION := 4107
    static IMMPID_MP_CHUNKING_OPTION := 4108
    static IMMPID_MP_BINARYMIME_OPTION := 4109
    static IMMPID_MP_REMOTE_AUTHENTICATION_TYPE := 4110
    static IMMPID_MP_ERROR_CODE := 4111
    static IMMPID_MP_DSN_ENVID_VALUE := 4112
    static IMMPID_MP_DSN_RET_VALUE := 4113
    static IMMPID_MP_REMOTE_SERVER_DSN_CAPABLE := 4114
    static IMMPID_MP_ARRIVAL_TIME := 4115
    static IMMPID_MP_MESSAGE_STATUS := 4116
    static IMMPID_MP_EXPIRE_DELAY := 4117
    static IMMPID_MP_EXPIRE_NDR := 4118
    static IMMPID_MP_LOCAL_EXPIRE_DELAY := 4119
    static IMMPID_MP_LOCAL_EXPIRE_NDR := 4120
    static IMMPID_MP_ARRIVAL_FILETIME := 4121
    static IMMPID_MP_HR_CAT_STATUS := 4122
    static IMMPID_MP_MSG_GUID := 4123
    static IMMPID_MP_SUPERSEDES_MSG_GUID := 4124
    static IMMPID_MP_SCANNED_FOR_CRLF_DOT_CRLF := 4125
    static IMMPID_MP_FOUND_EMBEDDED_CRLF_DOT_CRLF := 4126
    static IMMPID_MP_MSG_SIZE_HINT := 4127
    static IMMPID_MP_RFC822_MSG_ID := 4128
    static IMMPID_MP_RFC822_MSG_SUBJECT := 4129
    static IMMPID_MP_RFC822_FROM_ADDRESS := 4130
    static IMMPID_MP_RFC822_TO_ADDRESS := 4131
    static IMMPID_MP_RFC822_CC_ADDRESS := 4132
    static IMMPID_MP_RFC822_BCC_ADDRESS := 4133
    static IMMPID_MP_CONNECTION_SERVER_IP_ADDRESS := 4134
    static IMMPID_MP_SERVER_NAME := 4135
    static IMMPID_MP_SERVER_VERSION := 4136
    static IMMPID_MP_NUM_RECIPIENTS := 4137
    static IMMPID_MP_X_PRIORITY := 4138
    static IMMPID_MP_FROM_ADDRESS := 4139
    static IMMPID_MP_SENDER_ADDRESS := 4140
    static IMMPID_MP_DEFERRED_DELIVERY_FILETIME := 4141
    static IMMPID_MP_SENDER_ADDRESS_OTHER := 4142
    static IMMPID_MP_ORIGINAL_ARRIVAL_TIME := 4143
    static IMMPID_MP_MSGCLASS := 4144
    static IMMPID_MP_CONTENT_TYPE := 4145
    static IMMPID_MP_ENCRYPTION_TYPE := 4146
    static IMMPID_MP_CONNECTION_SERVER_PORT := 4147
    static IMMPID_MP_CLIENT_AUTH_USER := 4148
    static IMMPID_MP_CLIENT_AUTH_TYPE := 4149
    static IMMPID_MP_CRC_GLOBAL := 4150
    static IMMPID_MP_CRC_RECIPS := 4151
    static IMMPID_MP_INBOUND_MAIL_FROM_AUTH := 4152
    static IMMPID_MP_AFTER__ := 4153
}
struct IMMPID_RP_ENUM extends Int32 {
    static IMMPID_RP_BEFORE__ := 8191
    static IMMPID_RP_DSN_NOTIFY_SUCCESS := 8192
    static IMMPID_RP_DSN_NOTIFY_INVALID := 8193
    static IMMPID_RP_ADDRESS_TYPE := 8194
    static IMMPID_RP_ADDRESS := 8195
    static IMMPID_RP_ADDRESS_TYPE_SMTP := 8196
    static IMMPID_RP_ERROR_CODE := 8197
    static IMMPID_RP_ERROR_STRING := 8198
    static IMMPID_RP_DSN_NOTIFY_VALUE := 8199
    static IMMPID_RP_DSN_ORCPT_VALUE := 8200
    static IMMPID_RP_ADDRESS_SMTP := 8201
    static IMMPID_RP_ADDRESS_X400 := 8202
    static IMMPID_RP_ADDRESS_X500 := 8203
    static IMMPID_RP_LEGACY_EX_DN := 8204
    static IMMPID_RP_RECIPIENT_FLAGS := 8205
    static IMMPID_RP_SMTP_STATUS_STRING := 8206
    static IMMPID_RP_DSN_PRE_CAT_ADDRESS := 8207
    static IMMPID_RP_MDB_GUID := 8208
    static IMMPID_RP_USER_GUID := 8209
    static IMMPID_RP_DOMAIN := 8210
    static IMMPID_RP_ADDRESS_OTHER := 8211
    static IMMPID_RP_DISPLAY_NAME := 8212
    static IMMPID_RP_AFTER__ := 8213
}
struct IMMPID_MPV_ENUM extends Int32 {
    static IMMPID_MPV_BEFORE__ := 12287
    static IMMPID_MPV_STORE_DRIVER_HANDLE := 12288
    static IMMPID_MPV_MESSAGE_CREATION_FLAGS := 12289
    static IMMPID_MPV_MESSAGE_OPEN_HANDLES := 12290
    static IMMPID_MPV_TOTAL_OPEN_HANDLES := 12291
    static IMMPID_MPV_TOTAL_OPEN_PROPERTY_STREAM_HANDLES := 12292
    static IMMPID_MPV_TOTAL_OPEN_CONTENT_HANDLES := 12293
    static IMMPID_MPV_AFTER__ := 12294
}
struct IMMP_MPV_STORE_DRIVER_HANDLE {
    guidSignature : GUID
}
struct IMMPID_RPV_ENUM extends Int32 {
    static IMMPID_RPV_BEFORE__ := 16383
    static IMMPID_RPV_DONT_DELIVER := 16384
    static IMMPID_RPV_NO_NAME_COLLISIONS := 16385
    static IMMPID_RPV_AFTER__ := 16386
}
struct IMMPID_NMP_ENUM extends Int32 {
    static IMMPID_NMP_BEFORE__ := 24575
    static IMMPID_NMP_SECONDARY_GROUPS := 24576
    static IMMPID_NMP_SECONDARY_ARTNUM := 24577
    static IMMPID_NMP_PRIMARY_GROUP := 24578
    static IMMPID_NMP_PRIMARY_ARTID := 24579
    static IMMPID_NMP_POST_TOKEN := 24580
    static IMMPID_NMP_NEWSGROUP_LIST := 24581
    static IMMPID_NMP_HEADERS := 24582
    static IMMPID_NMP_NNTP_PROCESSING := 24583
    static IMMPID_NMP_NNTP_APPROVED_HEADER := 24584
    static IMMPID_NMP_AFTER__ := 24585
}
struct IMMPID_CPV_ENUM extends Int32 {
    static IMMPID_CPV_BEFORE__ := 32767
    static IMMPID_CP_START := 32768
    static IMMPID_CPV_AFTER__ := 32769
}
struct tagIMMPID_GUIDLIST_ITEM {
    pguid : GUID.Ptr
    dwStart : UInt32
    dwLast : UInt32
}
