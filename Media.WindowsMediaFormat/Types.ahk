#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, LPARAM, PWSTR, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {BITMAPINFOHEADER}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct AM_ASFWRITERCONFIG_PARAM extends Int32 {
    static AM_CONFIGASFWRITER_PARAM_AUTOINDEX := 1
    static AM_CONFIGASFWRITER_PARAM_MULTIPASS := 2
    static AM_CONFIGASFWRITER_PARAM_DONTCOMPRESS := 3
}
struct AM_WMT_EVENT_DATA {
    hrStatus : HRESULT
    pData : Struct.Ptr
}
struct INSSBuffer extends IUnknown {
    static IID := "{E1CD3524-03D7-11D2-9EED-006097D2D7CF}"
    GetLength(pdwLength)
      => ComCall(3, this.p, UInt32.Ptr, pdwLength)
    SetLength(dwLength)
      => ComCall(4, this.p, UInt32, dwLength)
    GetMaxLength(pdwLength)
      => ComCall(5, this.p, UInt32.Ptr, pdwLength)
    GetBuffer(ppdwBuffer)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, ppdwBuffer)
    GetBufferAndLength(ppdwBuffer, pdwLength)
      => ComCall(7, this.p, UInt8.Ptr.Ptr, ppdwBuffer, UInt32.Ptr, pdwLength)
}
struct INSSBuffer2 extends INSSBuffer {
    static IID := "{4F528693-1035-43FE-B428-757561AD3A68}"
    GetSampleProperties(cbProperties, pbProperties)
      => ComCall(8, this.p, UInt32, cbProperties, UInt8.Ptr, pbProperties)
    SetSampleProperties(cbProperties, pbProperties)
      => ComCall(9, this.p, UInt32, cbProperties, UInt8.Ptr, pbProperties)
}
struct INSSBuffer3 extends INSSBuffer2 {
    static IID := "{C87CEAAF-75BE-4BC4-84EB-AC2798507672}"
    SetProperty(guidBufferProperty, pvBufferProperty, dwBufferPropertySize)
      => ComCall(10, this.p, GUID, guidBufferProperty, Struct.Ptr, pvBufferProperty, UInt32, dwBufferPropertySize)
    GetProperty(guidBufferProperty, pvBufferProperty, pdwBufferPropertySize)
      => ComCall(11, this.p, GUID, guidBufferProperty, Struct.Ptr, pvBufferProperty, UInt32.Ptr, pdwBufferPropertySize)
}
struct INSSBuffer4 extends INSSBuffer3 {
    static IID := "{B6B8FD5A-32E2-49D4-A910-C26CC85465ED}"
    GetPropertyCount(pcBufferProperties)
      => ComCall(12, this.p, UInt32.Ptr, pcBufferProperties)
    GetPropertyByIndex(dwBufferPropertyIndex, pguidBufferProperty, pvBufferProperty, pdwBufferPropertySize)
      => ComCall(13, this.p, UInt32, dwBufferPropertyIndex, GUID.Ptr, pguidBufferProperty, Struct.Ptr, pvBufferProperty, UInt32.Ptr, pdwBufferPropertySize)
}
struct IWMSBufferAllocator extends IUnknown {
    static IID := "{61103CA4-2033-11D2-9EF1-006097D2D7CF}"
    AllocateBuffer(dwMaxBufferSize, ppBuffer)
      => ComCall(3, this.p, UInt32, dwMaxBufferSize, INSSBuffer.Ptr, ppBuffer)
    AllocatePageSizeBuffer(dwMaxBufferSize, ppBuffer)
      => ComCall(4, this.p, UInt32, dwMaxBufferSize, INSSBuffer.Ptr, ppBuffer)
}
struct WEBSTREAM_SAMPLE_TYPE extends Int32 {
    static WEBSTREAM_SAMPLE_TYPE_FILE := 1
    static WEBSTREAM_SAMPLE_TYPE_RENDER := 2
}
struct WM_SF_TYPE extends Int32 {
    static WM_SF_CLEANPOINT := 1
    static WM_SF_DISCONTINUITY := 2
    static WM_SF_DATALOSS := 4
}
struct WM_SFEX_TYPE extends Int32 {
    static WM_SFEX_NOTASYNCPOINT := 2
    static WM_SFEX_DATALOSS := 4
}
struct WMT_STATUS extends Int32 {
    static WMT_ERROR := 0
    static WMT_OPENED := 1
    static WMT_BUFFERING_START := 2
    static WMT_BUFFERING_STOP := 3
    static WMT_EOF := 4
    static WMT_END_OF_FILE := 4
    static WMT_END_OF_SEGMENT := 5
    static WMT_END_OF_STREAMING := 6
    static WMT_LOCATING := 7
    static WMT_CONNECTING := 8
    static WMT_NO_RIGHTS := 9
    static WMT_MISSING_CODEC := 10
    static WMT_STARTED := 11
    static WMT_STOPPED := 12
    static WMT_CLOSED := 13
    static WMT_STRIDING := 14
    static WMT_TIMER := 15
    static WMT_INDEX_PROGRESS := 16
    static WMT_SAVEAS_START := 17
    static WMT_SAVEAS_STOP := 18
    static WMT_NEW_SOURCEFLAGS := 19
    static WMT_NEW_METADATA := 20
    static WMT_BACKUPRESTORE_BEGIN := 21
    static WMT_SOURCE_SWITCH := 22
    static WMT_ACQUIRE_LICENSE := 23
    static WMT_INDIVIDUALIZE := 24
    static WMT_NEEDS_INDIVIDUALIZATION := 25
    static WMT_NO_RIGHTS_EX := 26
    static WMT_BACKUPRESTORE_END := 27
    static WMT_BACKUPRESTORE_CONNECTING := 28
    static WMT_BACKUPRESTORE_DISCONNECTING := 29
    static WMT_ERROR_WITHURL := 30
    static WMT_RESTRICTED_LICENSE := 31
    static WMT_CLIENT_CONNECT := 32
    static WMT_CLIENT_DISCONNECT := 33
    static WMT_NATIVE_OUTPUT_PROPS_CHANGED := 34
    static WMT_RECONNECT_START := 35
    static WMT_RECONNECT_END := 36
    static WMT_CLIENT_CONNECT_EX := 37
    static WMT_CLIENT_DISCONNECT_EX := 38
    static WMT_SET_FEC_SPAN := 39
    static WMT_PREROLL_READY := 40
    static WMT_PREROLL_COMPLETE := 41
    static WMT_CLIENT_PROPERTIES := 42
    static WMT_LICENSEURL_SIGNATURE_STATE := 43
    static WMT_INIT_PLAYLIST_BURN := 44
    static WMT_TRANSCRYPTOR_INIT := 45
    static WMT_TRANSCRYPTOR_SEEKED := 46
    static WMT_TRANSCRYPTOR_READ := 47
    static WMT_TRANSCRYPTOR_CLOSED := 48
    static WMT_PROXIMITY_RESULT := 49
    static WMT_PROXIMITY_COMPLETED := 50
    static WMT_CONTENT_ENABLER := 51
}
struct WMT_STREAM_SELECTION extends Int32 {
    static WMT_OFF := 0
    static WMT_CLEANPOINT_ONLY := 1
    static WMT_ON := 2
}
struct WMT_IMAGE_TYPE extends Int32 {
    static WMT_IT_NONE := 0
    static WMT_IT_BITMAP := 1
    static WMT_IT_JPEG := 2
    static WMT_IT_GIF := 3
}
struct WMT_ATTR_DATATYPE extends Int32 {
    static WMT_TYPE_DWORD := 0
    static WMT_TYPE_STRING := 1
    static WMT_TYPE_BINARY := 2
    static WMT_TYPE_BOOL := 3
    static WMT_TYPE_QWORD := 4
    static WMT_TYPE_WORD := 5
    static WMT_TYPE_GUID := 6
}
struct WMT_ATTR_IMAGETYPE extends Int32 {
    static WMT_IMAGETYPE_BITMAP := 1
    static WMT_IMAGETYPE_JPEG := 2
    static WMT_IMAGETYPE_GIF := 3
}
struct WMT_VERSION extends Int32 {
    static WMT_VER_4_0 := 262144
    static WMT_VER_7_0 := 458752
    static WMT_VER_8_0 := 524288
    static WMT_VER_9_0 := 589824
}
struct WMT_STORAGE_FORMAT extends Int32 {
    static WMT_Storage_Format_MP3 := 0
    static WMT_Storage_Format_V1 := 1
}
struct WMT_DRMLA_TRUST extends Int32 {
    static WMT_DRMLA_UNTRUSTED := 0
    static WMT_DRMLA_TRUSTED := 1
    static WMT_DRMLA_TAMPERED := 2
}
struct WMT_TRANSPORT_TYPE extends Int32 {
    static WMT_Transport_Type_Unreliable := 0
    static WMT_Transport_Type_Reliable := 1
}
struct WMT_NET_PROTOCOL extends Int32 {
    static WMT_PROTOCOL_HTTP := 0
}
struct WMT_PLAY_MODE extends Int32 {
    static WMT_PLAY_MODE_AUTOSELECT := 0
    static WMT_PLAY_MODE_LOCAL := 1
    static WMT_PLAY_MODE_DOWNLOAD := 2
    static WMT_PLAY_MODE_STREAMING := 3
}
struct WMT_PROXY_SETTINGS extends Int32 {
    static WMT_PROXY_SETTING_NONE := 0
    static WMT_PROXY_SETTING_MANUAL := 1
    static WMT_PROXY_SETTING_AUTO := 2
    static WMT_PROXY_SETTING_BROWSER := 3
    static WMT_PROXY_SETTING_MAX := 4
}
struct WMT_CODEC_INFO_TYPE extends Int32 {
    static WMT_CODECINFO_AUDIO := 0
    static WMT_CODECINFO_VIDEO := 1
    static WMT_CODECINFO_UNKNOWN := -1
}
struct WM_DM_INTERLACED_TYPE extends Int32 {
    static WM_DM_NOTINTERLACED := 0
    static WM_DM_DEINTERLACE_NORMAL := 1
    static WM_DM_DEINTERLACE_HALFSIZE := 2
    static WM_DM_DEINTERLACE_HALFSIZEDOUBLERATE := 3
    static WM_DM_DEINTERLACE_INVERSETELECINE := 4
    static WM_DM_DEINTERLACE_VERTICALHALFSIZEDOUBLERATE := 5
}
struct WM_DM_IT_FIRST_FRAME_COHERENCY extends Int32 {
    static WM_DM_IT_DISABLE_COHERENT_MODE := 0
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_TOP := 1
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_TOP := 2
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_TOP := 3
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_TOP := 4
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_TOP := 5
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_BOTTOM := 6
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_BOTTOM := 7
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_BOTTOM := 8
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_BOTTOM := 9
    static WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_BOTTOM := 10
}
struct WMT_OFFSET_FORMAT extends Int32 {
    static WMT_OFFSET_FORMAT_100NS := 0
    static WMT_OFFSET_FORMAT_FRAME_NUMBERS := 1
    static WMT_OFFSET_FORMAT_PLAYLIST_OFFSET := 2
    static WMT_OFFSET_FORMAT_TIMECODE := 3
    static WMT_OFFSET_FORMAT_100NS_APPROXIMATE := 4
}
struct WMT_INDEXER_TYPE extends Int32 {
    static WMT_IT_PRESENTATION_TIME := 0
    static WMT_IT_FRAME_NUMBERS := 1
    static WMT_IT_TIMECODE := 2
}
struct WMT_INDEX_TYPE extends Int32 {
    static WMT_IT_NEAREST_DATA_UNIT := 1
    static WMT_IT_NEAREST_OBJECT := 2
    static WMT_IT_NEAREST_CLEAN_POINT := 3
}
struct WMT_FILESINK_MODE extends Int32 {
    static WMT_FM_SINGLE_BUFFERS := 1
    static WMT_FM_FILESINK_DATA_UNITS := 2
    static WMT_FM_FILESINK_UNBUFFERED := 4
}
struct WMT_MUSICSPEECH_CLASS_MODE extends Int32 {
    static WMT_MS_CLASS_MUSIC := 0
    static WMT_MS_CLASS_SPEECH := 1
    static WMT_MS_CLASS_MIXED := 2
}
struct WMT_WATERMARK_ENTRY_TYPE extends Int32 {
    static WMT_WMETYPE_AUDIO := 1
    static WMT_WMETYPE_VIDEO := 2
}
struct WM_PLAYBACK_DRC_LEVEL extends Int32 {
    static WM_PLAYBACK_DRC_HIGH := 0
    static WM_PLAYBACK_DRC_MEDIUM := 1
    static WM_PLAYBACK_DRC_LOW := 2
}
struct WMT_TIMECODE_FRAMERATE extends Int32 {
    static WMT_TIMECODE_FRAMERATE_30 := 0
    static WMT_TIMECODE_FRAMERATE_30DROP := 1
    static WMT_TIMECODE_FRAMERATE_25 := 2
    static WMT_TIMECODE_FRAMERATE_24 := 3
}
struct WMT_CREDENTIAL_FLAGS extends Int32 {
    static WMT_CREDENTIAL_SAVE := 1
    static WMT_CREDENTIAL_DONT_CACHE := 2
    static WMT_CREDENTIAL_CLEAR_TEXT := 4
    static WMT_CREDENTIAL_PROXY := 8
    static WMT_CREDENTIAL_ENCRYPT := 16
}
struct WM_AETYPE extends Int32 {
    static WM_AETYPE_INCLUDE := 105
    static WM_AETYPE_EXCLUDE := 101
}
struct WMT_RIGHTS extends Int32 {
    static WMT_RIGHT_PLAYBACK := 1
    static WMT_RIGHT_COPY_TO_NON_SDMI_DEVICE := 2
    static WMT_RIGHT_COPY_TO_CD := 8
    static WMT_RIGHT_COPY_TO_SDMI_DEVICE := 16
    static WMT_RIGHT_ONE_TIME := 32
    static WMT_RIGHT_SAVE_STREAM_PROTECTED := 64
    static WMT_RIGHT_COPY := 128
    static WMT_RIGHT_COLLABORATIVE_PLAY := 256
    static WMT_RIGHT_SDMI_TRIGGER := 65536
    static WMT_RIGHT_SDMI_NOMORECOPIES := 131072
}
struct WM_STREAM_PRIORITY_RECORD {
    wStreamNumber : UInt16
    fMandatory : BOOL
}
struct WM_WRITER_STATISTICS {
    qwSampleCount : Int64
    qwByteCount : Int64
    qwDroppedSampleCount : Int64
    qwDroppedByteCount : Int64
    dwCurrentBitrate : UInt32
    dwAverageBitrate : UInt32
    dwExpectedBitrate : UInt32
    dwCurrentSampleRate : UInt32
    dwAverageSampleRate : UInt32
    dwExpectedSampleRate : UInt32
}
struct WM_WRITER_STATISTICS_EX {
    dwBitratePlusOverhead : UInt32
    dwCurrentSampleDropRateInQueue : UInt32
    dwCurrentSampleDropRateInCodec : UInt32
    dwCurrentSampleDropRateInMultiplexer : UInt32
    dwTotalSampleDropsInQueue : UInt32
    dwTotalSampleDropsInCodec : UInt32
    dwTotalSampleDropsInMultiplexer : UInt32
}
struct WM_READER_STATISTICS {
    cbSize : UInt32 := this.Size
    dwBandwidth : UInt32
    cPacketsReceived : UInt32
    cPacketsRecovered : UInt32
    cPacketsLost : UInt32
    wQuality : UInt16
}
struct WM_READER_CLIENTINFO {
    cbSize : UInt32 := this.Size
    wszLang : PWSTR
    wszBrowserUserAgent : PWSTR
    wszBrowserWebPage : PWSTR
    qwReserved : Int64
    pReserved : LPARAM.Ptr
    wszHostExe : PWSTR
    qwHostVersion : Int64
    wszPlayerUserAgent : PWSTR
}
struct WM_CLIENT_PROPERTIES {
    dwIPAddress : UInt32
    dwPort : UInt32
}
struct WM_CLIENT_PROPERTIES_EX {
    cbSize : UInt32 := this.Size
    pwszIPAddress : PWSTR
    pwszPort : PWSTR
    pwszDNSName : PWSTR
}
struct WM_PORT_NUMBER_RANGE {
    wPortBegin : UInt16
    wPortEnd : UInt16
}
struct WMT_BUFFER_SEGMENT {
    pBuffer : INSSBuffer
    cbOffset : UInt32
    cbLength : UInt32
}
struct WMT_PAYLOAD_FRAGMENT {
    dwPayloadIndex : UInt32
    segmentData : WMT_BUFFER_SEGMENT
}
struct WMT_FILESINK_DATA_UNIT {
    packetHeaderBuffer : WMT_BUFFER_SEGMENT
    cPayloads : UInt32
    pPayloadHeaderBuffers : WMT_BUFFER_SEGMENT.Ptr
    cPayloadDataFragments : UInt32
    pPayloadDataFragments : WMT_PAYLOAD_FRAGMENT.Ptr
}
struct WMT_WEBSTREAM_FORMAT {
    cbSize : UInt16 := this.Size
    cbSampleHeaderFixedData : UInt16
    wVersion : UInt16
    wReserved : UInt16
}
struct WMT_WEBSTREAM_SAMPLE_HEADER {
    cbLength : UInt16
    wPart : UInt16
    cTotalParts : UInt16
    wSampleType : UInt16
    wszURL : UInt16[1]
}
struct WM_ADDRESS_ACCESSENTRY {
    dwIPAddress : UInt32
    dwMask : UInt32
}
struct WM_PICTURE {
    pwszMIMEType : PWSTR
    bPictureType : UInt8
    pwszDescription : PWSTR
    dwDataLen : UInt32
    pbData : UInt8.Ptr
}
struct WM_SYNCHRONISED_LYRICS {
    bTimeStampFormat : UInt8
    bContentType : UInt8
    pwszContentDescriptor : PWSTR
    dwLyricsLen : UInt32
    pbLyrics : UInt8.Ptr
}
struct WM_USER_WEB_URL {
    pwszDescription : PWSTR
    pwszURL : PWSTR
}
struct WM_USER_TEXT {
    pwszDescription : PWSTR
    pwszText : PWSTR
}
struct WM_LEAKY_BUCKET_PAIR {
    dwBitrate : UInt32
    msBufferWindow : UInt32
}
struct WM_STREAM_TYPE_INFO {
    guidMajorType : GUID
    cbFormat : UInt32
}
struct WMT_WATERMARK_ENTRY {
    wmetType : WMT_WATERMARK_ENTRY_TYPE
    clsid : GUID
    cbDisplayName : UInt32
    pwszDisplayName : PWSTR
}
struct WMT_VIDEOIMAGE_SAMPLE {
    dwMagic : UInt32
    cbStruct : UInt32
    dwControlFlags : UInt32
    dwInputFlagsCur : UInt32
    lCurMotionXtoX : Int32
    lCurMotionYtoX : Int32
    lCurMotionXoffset : Int32
    lCurMotionXtoY : Int32
    lCurMotionYtoY : Int32
    lCurMotionYoffset : Int32
    lCurBlendCoef1 : Int32
    lCurBlendCoef2 : Int32
    dwInputFlagsPrev : UInt32
    lPrevMotionXtoX : Int32
    lPrevMotionYtoX : Int32
    lPrevMotionXoffset : Int32
    lPrevMotionXtoY : Int32
    lPrevMotionYtoY : Int32
    lPrevMotionYoffset : Int32
    lPrevBlendCoef1 : Int32
    lPrevBlendCoef2 : Int32
}
struct WMT_VIDEOIMAGE_SAMPLE2 {
    dwMagic : UInt32
    dwStructSize : UInt32
    dwControlFlags : UInt32
    dwViewportWidth : UInt32
    dwViewportHeight : UInt32
    dwCurrImageWidth : UInt32
    dwCurrImageHeight : UInt32
    fCurrRegionX0 : Float32
    fCurrRegionY0 : Float32
    fCurrRegionWidth : Float32
    fCurrRegionHeight : Float32
    fCurrBlendCoef : Float32
    dwPrevImageWidth : UInt32
    dwPrevImageHeight : UInt32
    fPrevRegionX0 : Float32
    fPrevRegionY0 : Float32
    fPrevRegionWidth : Float32
    fPrevRegionHeight : Float32
    fPrevBlendCoef : Float32
    dwEffectType : UInt32
    dwNumEffectParas : UInt32
    fEffectPara0 : Float32
    fEffectPara1 : Float32
    fEffectPara2 : Float32
    fEffectPara3 : Float32
    fEffectPara4 : Float32
    bKeepPrevImage : BOOL
}
struct WM_MEDIA_TYPE {
    majortype : GUID
    subtype : GUID
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    lSampleSize : UInt32
    formattype : GUID
    pUnk : IUnknown
    cbFormat : UInt32
    pbFormat : UInt8.Ptr
}
struct WMVIDEOINFOHEADER {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    bmiHeader : BITMAPINFOHEADER
}
struct WMVIDEOINFOHEADER2 {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    dwInterlaceFlags : UInt32
    dwCopyProtectFlags : UInt32
    dwPictAspectRatioX : UInt32
    dwPictAspectRatioY : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    bmiHeader : BITMAPINFOHEADER
}
struct WMMPEG2VIDEOINFO {
    hdr : WMVIDEOINFOHEADER2
    dwStartTimeCode : UInt32
    cbSequenceHeader : UInt32
    dwProfile : UInt32
    dwLevel : UInt32
    dwFlags : UInt32
    dwSequenceHeader : UInt32[1]
}
struct WMSCRIPTFORMAT {
    scriptType : GUID
}
struct WMT_COLORSPACEINFO_EXTENSION_DATA {
    ucColorPrimaries : UInt8
    ucColorTransferChar : UInt8
    ucColorMatrixCoef : UInt8
}
struct WMT_TIMECODE_EXTENSION_DATA {
    wRange : UInt16
    dwTimecode : UInt32
    dwUserbits : UInt32
    dwAmFlags : UInt32
}
struct DRM_VAL16 {
    val : UInt8[16]
}
struct IWMMediaProps extends IUnknown {
    static IID := "{96406BCE-2B2B-11D3-B36B-00C04F6108FF}"
    GetType(pguidType)
      => ComCall(3, this.p, GUID.Ptr, pguidType)
    GetMediaType(pType, pcbType)
      => ComCall(4, this.p, WM_MEDIA_TYPE.Ptr, pType, UInt32.Ptr, pcbType)
    SetMediaType(pType)
      => ComCall(5, this.p, WM_MEDIA_TYPE.Ptr, pType)
}
struct IWMVideoMediaProps extends IWMMediaProps {
    static IID := "{96406BCF-2B2B-11D3-B36B-00C04F6108FF}"
    GetMaxKeyFrameSpacing(pllTime)
      => ComCall(6, this.p, Int64.Ptr, pllTime)
    SetMaxKeyFrameSpacing(llTime)
      => ComCall(7, this.p, Int64, llTime)
    GetQuality(pdwQuality)
      => ComCall(8, this.p, UInt32.Ptr, pdwQuality)
    SetQuality(dwQuality)
      => ComCall(9, this.p, UInt32, dwQuality)
}
struct IWMWriter extends IUnknown {
    static IID := "{96406BD4-2B2B-11D3-B36B-00C04F6108FF}"
    SetProfileByID(guidProfile)
      => ComCall(3, this.p, GUID.Ptr, guidProfile)
    SetProfile(pProfile)
      => ComCall(4, this.p, IWMProfile, pProfile)
    SetOutputFilename(pwszFilename)
      => ComCall(5, this.p, "Str", pwszFilename)
    GetInputCount(pcInputs)
      => ComCall(6, this.p, UInt32.Ptr, pcInputs)
    GetInputProps(dwInputNum, ppInput)
      => ComCall(7, this.p, UInt32, dwInputNum, IWMInputMediaProps.Ptr, ppInput)
    SetInputProps(dwInputNum, pInput)
      => ComCall(8, this.p, UInt32, dwInputNum, IWMInputMediaProps, pInput)
    GetInputFormatCount(dwInputNumber, pcFormats)
      => ComCall(9, this.p, UInt32, dwInputNumber, UInt32.Ptr, pcFormats)
    GetInputFormat(dwInputNumber, dwFormatNumber, pProps)
      => ComCall(10, this.p, UInt32, dwInputNumber, UInt32, dwFormatNumber, IWMInputMediaProps.Ptr, pProps)
    BeginWriting()
      => ComCall(11, this.p)
    EndWriting()
      => ComCall(12, this.p)
    AllocateSample(dwSampleSize, ppSample)
      => ComCall(13, this.p, UInt32, dwSampleSize, INSSBuffer.Ptr, ppSample)
    WriteSample(dwInputNum, cnsSampleTime, dwFlags, pSample)
      => ComCall(14, this.p, UInt32, dwInputNum, Int64, cnsSampleTime, UInt32, dwFlags, INSSBuffer, pSample)
    Flush()
      => ComCall(15, this.p)
}
struct IWMDRMWriter extends IUnknown {
    static IID := "{D6EA5DD0-12A0-43F4-90AB-A3FD451E6A07}"
    GenerateKeySeed(pwszKeySeed)
      => ComCall(3, this.p, PWSTR, pwszKeySeed, UInt32.Ptr, pwszKeySeed.Length)
    GenerateKeyID(pwszKeyID)
      => ComCall(4, this.p, PWSTR, pwszKeyID, UInt32.Ptr, pwszKeyID.Length)
    GenerateSigningKeyPair(pwszPrivKey, pwszPubKey)
      => ComCall(5, this.p, PWSTR, pwszPrivKey, UInt32.Ptr, pwszPrivKey.Length, PWSTR, pwszPubKey, UInt32.Ptr, pwszPubKey.Length)
    SetDRMAttribute(wStreamNum, pszName, Type, pValue)
      => ComCall(6, this.p, UInt16, wStreamNum, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
}
struct WMDRM_IMPORT_INIT_STRUCT {
    dwVersion : UInt32
    cbEncryptedSessionKeyMessage : UInt32
    pbEncryptedSessionKeyMessage : UInt8.Ptr
    cbEncryptedKeyMessage : UInt32
    pbEncryptedKeyMessage : UInt8.Ptr
}
struct IWMDRMWriter2 extends IWMDRMWriter {
    static IID := "{38EE7A94-40E2-4E10-AA3F-33FD3210ED5B}"
    SetWMDRMNetEncryption(fSamplesEncrypted, pbKeyID, cbKeyID)
      => ComCall(7, this.p, BOOL, fSamplesEncrypted, UInt8.Ptr, pbKeyID, UInt32, cbKeyID)
}
struct IWMDRMWriter3 extends IWMDRMWriter2 {
    static IID := "{A7184082-A4AA-4DDE-AC9C-E75DBD1117CE}"
    SetProtectStreamSamples(pImportInitStruct)
      => ComCall(8, this.p, WMDRM_IMPORT_INIT_STRUCT.Ptr, pImportInitStruct)
}
struct IWMInputMediaProps extends IWMMediaProps {
    static IID := "{96406BD5-2B2B-11D3-B36B-00C04F6108FF}"
    GetConnectionName(pwszName)
      => ComCall(6, this.p, PWSTR, pwszName, UInt16.Ptr, pwszName.Length)
    GetGroupName(pwszName)
      => ComCall(7, this.p, PWSTR, pwszName, UInt16.Ptr, pwszName.Length)
}
struct IWMPropertyVault extends IUnknown {
    static IID := "{72995A79-5090-42A4-9C8C-D9D0B6D34BE5}"
    GetPropertyCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    GetPropertyByName(pszName, pType, pValue)
      => ComCall(4, this.p, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
    SetProperty(pszName, pType, pValue, dwSize)
      => ComCall(5, this.p, "Str", pszName, WMT_ATTR_DATATYPE, pType, UInt8.Ptr, pValue, UInt32, dwSize)
    GetPropertyByIndex(dwIndex, pszName, pType, pValue)
      => ComCall(6, this.p, UInt32, dwIndex, PWSTR, pszName, UInt32.Ptr, pszName.Length, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
    CopyPropertiesFrom(pIWMPropertyVault)
      => ComCall(7, this.p, IWMPropertyVault, pIWMPropertyVault)
    Clear()
      => ComCall(8, this.p)
}
struct IWMIStreamProps extends IUnknown {
    static IID := "{6816DAD3-2B4B-4C8E-8149-874C3483A753}"
    GetProperty(pszName, pType, pValue)
      => ComCall(3, this.p, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
}
struct IWMReader extends IUnknown {
    static IID := "{96406BD6-2B2B-11D3-B36B-00C04F6108FF}"
    Open(pwszURL, pCallback, pvContext)
      => ComCall(3, this.p, "Str", pwszURL, IWMReaderCallback, pCallback, Struct.Ptr, pvContext)
    Close()
      => ComCall(4, this.p)
    GetOutputCount(pcOutputs)
      => ComCall(5, this.p, UInt32.Ptr, pcOutputs)
    GetOutputProps(dwOutputNum, ppOutput)
      => ComCall(6, this.p, UInt32, dwOutputNum, IWMOutputMediaProps.Ptr, ppOutput)
    SetOutputProps(dwOutputNum, pOutput)
      => ComCall(7, this.p, UInt32, dwOutputNum, IWMOutputMediaProps, pOutput)
    GetOutputFormatCount(dwOutputNumber, pcFormats)
      => ComCall(8, this.p, UInt32, dwOutputNumber, UInt32.Ptr, pcFormats)
    GetOutputFormat(dwOutputNumber, dwFormatNumber, ppProps)
      => ComCall(9, this.p, UInt32, dwOutputNumber, UInt32, dwFormatNumber, IWMOutputMediaProps.Ptr, ppProps)
    Start(cnsStart, cnsDuration, fRate, pvContext)
      => ComCall(10, this.p, Int64, cnsStart, Int64, cnsDuration, Float32, fRate, Struct.Ptr, pvContext)
    Stop()
      => ComCall(11, this.p)
    Pause()
      => ComCall(12, this.p)
    Resume()
      => ComCall(13, this.p)
}
struct IWMSyncReader extends IUnknown {
    static IID := "{9397F121-7705-4DC9-B049-98B698188414}"
    Open(pwszFilename)
      => ComCall(3, this.p, "Str", pwszFilename)
    Close()
      => ComCall(4, this.p)
    SetRange(cnsStartTime, cnsDuration)
      => ComCall(5, this.p, Int64, cnsStartTime, Int64, cnsDuration)
    SetRangeByFrame(wStreamNum, qwFrameNumber, cFramesToRead)
      => ComCall(6, this.p, UInt16, wStreamNum, Int64, qwFrameNumber, Int64, cFramesToRead)
    GetNextSample(wStreamNum, ppSample, pcnsSampleTime, pcnsDuration, pdwFlags, pdwOutputNum, pwStreamNum)
      => ComCall(7, this.p, UInt16, wStreamNum, INSSBuffer.Ptr, ppSample, Int64.Ptr, pcnsSampleTime, Int64.Ptr, pcnsDuration, UInt32.Ptr, pdwFlags, UInt32.Ptr, pdwOutputNum, UInt16.Ptr, pwStreamNum)
    SetStreamsSelected(cStreamCount, pwStreamNumbers, pSelections)
      => ComCall(8, this.p, UInt16, cStreamCount, UInt16.Ptr, pwStreamNumbers, WMT_STREAM_SELECTION.Ptr, pSelections)
    GetStreamSelected(wStreamNum, pSelection)
      => ComCall(9, this.p, UInt16, wStreamNum, WMT_STREAM_SELECTION.Ptr, pSelection)
    SetReadStreamSamples(wStreamNum, fCompressed)
      => ComCall(10, this.p, UInt16, wStreamNum, BOOL, fCompressed)
    GetReadStreamSamples(wStreamNum, pfCompressed)
      => ComCall(11, this.p, UInt16, wStreamNum, BOOL.Ptr, pfCompressed)
    GetOutputSetting(dwOutputNum, pszName, pType, pValue)
      => ComCall(12, this.p, UInt32, dwOutputNum, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    SetOutputSetting(dwOutputNum, pszName, Type, pValue)
      => ComCall(13, this.p, UInt32, dwOutputNum, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
    GetOutputCount(pcOutputs)
      => ComCall(14, this.p, UInt32.Ptr, pcOutputs)
    GetOutputProps(dwOutputNum, ppOutput)
      => ComCall(15, this.p, UInt32, dwOutputNum, IWMOutputMediaProps.Ptr, ppOutput)
    SetOutputProps(dwOutputNum, pOutput)
      => ComCall(16, this.p, UInt32, dwOutputNum, IWMOutputMediaProps, pOutput)
    GetOutputFormatCount(dwOutputNum, pcFormats)
      => ComCall(17, this.p, UInt32, dwOutputNum, UInt32.Ptr, pcFormats)
    GetOutputFormat(dwOutputNum, dwFormatNum, ppProps)
      => ComCall(18, this.p, UInt32, dwOutputNum, UInt32, dwFormatNum, IWMOutputMediaProps.Ptr, ppProps)
    GetOutputNumberForStream(wStreamNum, pdwOutputNum)
      => ComCall(19, this.p, UInt16, wStreamNum, UInt32.Ptr, pdwOutputNum)
    GetStreamNumberForOutput(dwOutputNum, pwStreamNum)
      => ComCall(20, this.p, UInt32, dwOutputNum, UInt16.Ptr, pwStreamNum)
    GetMaxOutputSampleSize(dwOutput, pcbMax)
      => ComCall(21, this.p, UInt32, dwOutput, UInt32.Ptr, pcbMax)
    GetMaxStreamSampleSize(wStream, pcbMax)
      => ComCall(22, this.p, UInt16, wStream, UInt32.Ptr, pcbMax)
    OpenStream(pStream)
      => ComCall(23, this.p, IStream, pStream)
}
struct IWMSyncReader2 extends IWMSyncReader {
    static IID := "{FAED3D21-1B6B-4AF7-8CB6-3E189BBC187B}"
    SetRangeByTimecode(wStreamNum, pStart, pEnd)
      => ComCall(24, this.p, UInt16, wStreamNum, WMT_TIMECODE_EXTENSION_DATA.Ptr, pStart, WMT_TIMECODE_EXTENSION_DATA.Ptr, pEnd)
    SetRangeByFrameEx(wStreamNum, qwFrameNumber, cFramesToRead, pcnsStartTime)
      => ComCall(25, this.p, UInt16, wStreamNum, Int64, qwFrameNumber, Int64, cFramesToRead, Int64.Ptr, pcnsStartTime)
    SetAllocateForOutput(dwOutputNum, pAllocator)
      => ComCall(26, this.p, UInt32, dwOutputNum, IWMReaderAllocatorEx, pAllocator)
    GetAllocateForOutput(dwOutputNum, ppAllocator)
      => ComCall(27, this.p, UInt32, dwOutputNum, IWMReaderAllocatorEx.Ptr, ppAllocator)
    SetAllocateForStream(wStreamNum, pAllocator)
      => ComCall(28, this.p, UInt16, wStreamNum, IWMReaderAllocatorEx, pAllocator)
    GetAllocateForStream(dwSreamNum, ppAllocator)
      => ComCall(29, this.p, UInt16, dwSreamNum, IWMReaderAllocatorEx.Ptr, ppAllocator)
}
struct IWMOutputMediaProps extends IWMMediaProps {
    static IID := "{96406BD7-2B2B-11D3-B36B-00C04F6108FF}"
    GetStreamGroupName(pwszName)
      => ComCall(6, this.p, PWSTR, pwszName, UInt16.Ptr, pwszName.Length)
    GetConnectionName(pwszName)
      => ComCall(7, this.p, PWSTR, pwszName, UInt16.Ptr, pwszName.Length)
}
struct IWMStatusCallback extends IUnknown {
    static IID := "{6D7CDC70-9888-11D3-8EDC-00C04F6109CF}"
    OnStatus(Status, hr, dwType, pValue, pvContext)
      => ComCall(3, this.p, WMT_STATUS, Status, HRESULT, hr, WMT_ATTR_DATATYPE, dwType, UInt8.Ptr, pValue, Struct.Ptr, pvContext)
}
struct IWMReaderCallback extends IWMStatusCallback {
    static IID := "{96406BD8-2B2B-11D3-B36B-00C04F6108FF}"
    OnSample(dwOutputNum, cnsSampleTime, cnsSampleDuration, dwFlags, pSample, pvContext)
      => ComCall(4, this.p, UInt32, dwOutputNum, Int64, cnsSampleTime, Int64, cnsSampleDuration, UInt32, dwFlags, INSSBuffer, pSample, Struct.Ptr, pvContext)
}
struct IWMCredentialCallback extends IUnknown {
    static IID := "{342E0EB7-E651-450C-975B-2ACE2C90C48E}"
    AcquireCredentials(pwszRealm, pwszSite, pwszUser, pwszPassword, hrStatus, pdwFlags)
      => ComCall(3, this.p, "Str", pwszRealm, "Str", pwszSite, PWSTR, pwszUser, UInt32, pwszUser.Length, PWSTR, pwszPassword, UInt32, pwszPassword.Length, HRESULT, hrStatus, UInt32.Ptr, pdwFlags)
}
struct IWMMetadataEditor extends IUnknown {
    static IID := "{96406BD9-2B2B-11D3-B36B-00C04F6108FF}"
    Open(pwszFilename)
      => ComCall(3, this.p, "Str", pwszFilename)
    Close()
      => ComCall(4, this.p)
    Flush()
      => ComCall(5, this.p)
}
struct IWMMetadataEditor2 extends IWMMetadataEditor {
    static IID := "{203CFFE3-2E18-4FDF-B59D-6E71530534CF}"
    OpenEx(pwszFilename, dwDesiredAccess, dwShareMode)
      => ComCall(6, this.p, "Str", pwszFilename, UInt32, dwDesiredAccess, UInt32, dwShareMode)
}
struct IWMDRMEditor extends IUnknown {
    static IID := "{FF130EBC-A6C3-42A6-B401-C3382C3E08B3}"
    GetDRMProperty(pwstrName, pdwType, pValue)
      => ComCall(3, this.p, "Str", pwstrName, WMT_ATTR_DATATYPE.Ptr, pdwType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
}
struct IWMHeaderInfo extends IUnknown {
    static IID := "{96406BDA-2B2B-11D3-B36B-00C04F6108FF}"
    GetAttributeCount(wStreamNum, pcAttributes)
      => ComCall(3, this.p, UInt16, wStreamNum, UInt16.Ptr, pcAttributes)
    GetAttributeByIndex(wIndex, pwStreamNum, pwszName, pType, pValue)
      => ComCall(4, this.p, UInt16, wIndex, UInt16.Ptr, pwStreamNum, PWSTR, pwszName, UInt16.Ptr, pwszName.Length, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    GetAttributeByName(pwStreamNum, pszName, pType, pValue)
      => ComCall(5, this.p, UInt16.Ptr, pwStreamNum, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    SetAttribute(wStreamNum, pszName, Type, pValue)
      => ComCall(6, this.p, UInt16, wStreamNum, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
    GetMarkerCount(pcMarkers)
      => ComCall(7, this.p, UInt16.Ptr, pcMarkers)
    GetMarker(wIndex, pwszMarkerName, pcnsMarkerTime)
      => ComCall(8, this.p, UInt16, wIndex, PWSTR, pwszMarkerName, UInt16.Ptr, pwszMarkerName.Length, Int64.Ptr, pcnsMarkerTime)
    AddMarker(pwszMarkerName, cnsMarkerTime)
      => ComCall(9, this.p, "Str", pwszMarkerName, Int64, cnsMarkerTime)
    RemoveMarker(wIndex)
      => ComCall(10, this.p, UInt16, wIndex)
    GetScriptCount(pcScripts)
      => ComCall(11, this.p, UInt16.Ptr, pcScripts)
    GetScript(wIndex, pwszType, pwszCommand, pcnsScriptTime)
      => ComCall(12, this.p, UInt16, wIndex, PWSTR, pwszType, UInt16.Ptr, pwszType.Length, PWSTR, pwszCommand, UInt16.Ptr, pwszCommand.Length, Int64.Ptr, pcnsScriptTime)
    AddScript(pwszType, pwszCommand, cnsScriptTime)
      => ComCall(13, this.p, "Str", pwszType, "Str", pwszCommand, Int64, cnsScriptTime)
    RemoveScript(wIndex)
      => ComCall(14, this.p, UInt16, wIndex)
}
struct IWMHeaderInfo2 extends IWMHeaderInfo {
    static IID := "{15CF9781-454E-482E-B393-85FAE487A810}"
    GetCodecInfoCount(pcCodecInfos)
      => ComCall(15, this.p, UInt32.Ptr, pcCodecInfos)
    GetCodecInfo(wIndex, pwszName, pwszDescription, pCodecType, pbCodecInfo)
      => ComCall(16, this.p, UInt32, wIndex, UInt16.Ptr, pwszName.Length, PWSTR, pwszName, UInt16.Ptr, pwszDescription.Length, PWSTR, pwszDescription, WMT_CODEC_INFO_TYPE.Ptr, pCodecType, UInt16.Ptr, pbCodecInfo.Length, UInt8.Ptr, pbCodecInfo)
}
struct IWMHeaderInfo3 extends IWMHeaderInfo2 {
    static IID := "{15CC68E3-27CC-4ECD-B222-3F5D02D80BD5}"
    GetAttributeCountEx(wStreamNum, pcAttributes)
      => ComCall(17, this.p, UInt16, wStreamNum, UInt16.Ptr, pcAttributes)
    GetAttributeIndices(wStreamNum, pwszName, pwLangIndex, pwIndices)
      => ComCall(18, this.p, UInt16, wStreamNum, "Str", pwszName, UInt16.Ptr, pwLangIndex, UInt16.Ptr, pwIndices, UInt16.Ptr, pwIndices.Length)
    GetAttributeByIndexEx(wStreamNum, wIndex, pwszName, pType, pwLangIndex, pValue)
      => ComCall(19, this.p, UInt16, wStreamNum, UInt16, wIndex, PWSTR, pwszName, UInt16.Ptr, pwszName.Length, WMT_ATTR_DATATYPE.Ptr, pType, UInt16.Ptr, pwLangIndex, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
    ModifyAttribute(wStreamNum, wIndex, Type, wLangIndex, pValue)
      => ComCall(20, this.p, UInt16, wStreamNum, UInt16, wIndex, WMT_ATTR_DATATYPE, Type, UInt16, wLangIndex, UInt8.Ptr, pValue, UInt32, pValue.Length)
    AddAttribute(wStreamNum, pszName, pwIndex, Type, wLangIndex, pValue)
      => ComCall(21, this.p, UInt16, wStreamNum, "Str", pszName, UInt16.Ptr, pwIndex, WMT_ATTR_DATATYPE, Type, UInt16, wLangIndex, UInt8.Ptr, pValue, UInt32, pValue.Length)
    DeleteAttribute(wStreamNum, wIndex)
      => ComCall(22, this.p, UInt16, wStreamNum, UInt16, wIndex)
    AddCodecInfo(pwszName, pwszDescription, codecType, pbCodecInfo)
      => ComCall(23, this.p, "Str", pwszName, "Str", pwszDescription, WMT_CODEC_INFO_TYPE, codecType, UInt16, pbCodecInfo.Length, UInt8.Ptr, pbCodecInfo)
}
struct IWMProfileManager extends IUnknown {
    static IID := "{D16679F2-6CA0-472D-8D31-2F5D55AEE155}"
    CreateEmptyProfile(dwVersion, ppProfile)
      => ComCall(3, this.p, WMT_VERSION, dwVersion, IWMProfile.Ptr, ppProfile)
    LoadProfileByID(guidProfile, ppProfile)
      => ComCall(4, this.p, GUID.Ptr, guidProfile, IWMProfile.Ptr, ppProfile)
    LoadProfileByData(pwszProfile, ppProfile)
      => ComCall(5, this.p, "Str", pwszProfile, IWMProfile.Ptr, ppProfile)
    SaveProfile(pIWMProfile, pwszProfile, pdwLength)
      => ComCall(6, this.p, IWMProfile, pIWMProfile, "Str", pwszProfile, UInt32.Ptr, pdwLength)
    GetSystemProfileCount(pcProfiles)
      => ComCall(7, this.p, UInt32.Ptr, pcProfiles)
    LoadSystemProfile(dwProfileIndex, ppProfile)
      => ComCall(8, this.p, UInt32, dwProfileIndex, IWMProfile.Ptr, ppProfile)
}
struct IWMProfileManager2 extends IWMProfileManager {
    static IID := "{7A924E51-73C1-494D-8019-23D37ED9B89A}"
    GetSystemProfileVersion(pdwVersion)
      => ComCall(9, this.p, WMT_VERSION.Ptr, pdwVersion)
    SetSystemProfileVersion(dwVersion)
      => ComCall(10, this.p, WMT_VERSION, dwVersion)
}
struct IWMProfileManagerLanguage extends IUnknown {
    static IID := "{BA4DCC78-7EE0-4AB8-B27A-DBCE8BC51454}"
    GetUserLanguageID(wLangID)
      => ComCall(3, this.p, UInt16.Ptr, wLangID)
    SetUserLanguageID(wLangID)
      => ComCall(4, this.p, UInt16, wLangID)
}
struct IWMProfile extends IUnknown {
    static IID := "{96406BDB-2B2B-11D3-B36B-00C04F6108FF}"
    GetVersion(pdwVersion)
      => ComCall(3, this.p, WMT_VERSION.Ptr, pdwVersion)
    GetName(pwszName)
      => ComCall(4, this.p, PWSTR, pwszName, UInt32.Ptr, pwszName.Length)
    SetName(pwszName)
      => ComCall(5, this.p, "Str", pwszName)
    GetDescription(pwszDescription)
      => ComCall(6, this.p, PWSTR, pwszDescription, UInt32.Ptr, pwszDescription.Length)
    SetDescription(pwszDescription)
      => ComCall(7, this.p, "Str", pwszDescription)
    GetStreamCount(pcStreams)
      => ComCall(8, this.p, UInt32.Ptr, pcStreams)
    GetStream(dwStreamIndex, ppConfig)
      => ComCall(9, this.p, UInt32, dwStreamIndex, IWMStreamConfig.Ptr, ppConfig)
    GetStreamByNumber(wStreamNum, ppConfig)
      => ComCall(10, this.p, UInt16, wStreamNum, IWMStreamConfig.Ptr, ppConfig)
    RemoveStream(pConfig)
      => ComCall(11, this.p, IWMStreamConfig, pConfig)
    RemoveStreamByNumber(wStreamNum)
      => ComCall(12, this.p, UInt16, wStreamNum)
    AddStream(pConfig)
      => ComCall(13, this.p, IWMStreamConfig, pConfig)
    ReconfigStream(pConfig)
      => ComCall(14, this.p, IWMStreamConfig, pConfig)
    CreateNewStream(guidStreamType, ppConfig)
      => ComCall(15, this.p, GUID.Ptr, guidStreamType, IWMStreamConfig.Ptr, ppConfig)
    GetMutualExclusionCount(pcME)
      => ComCall(16, this.p, UInt32.Ptr, pcME)
    GetMutualExclusion(dwMEIndex, ppME)
      => ComCall(17, this.p, UInt32, dwMEIndex, IWMMutualExclusion.Ptr, ppME)
    RemoveMutualExclusion(pME)
      => ComCall(18, this.p, IWMMutualExclusion, pME)
    AddMutualExclusion(pME)
      => ComCall(19, this.p, IWMMutualExclusion, pME)
    CreateNewMutualExclusion(ppME)
      => ComCall(20, this.p, IWMMutualExclusion.Ptr, ppME)
}
struct IWMProfile2 extends IWMProfile {
    static IID := "{07E72D33-D94E-4BE7-8843-60AE5FF7E5F5}"
    GetProfileID(pguidID)
      => ComCall(21, this.p, GUID.Ptr, pguidID)
}
struct IWMProfile3 extends IWMProfile2 {
    static IID := "{00EF96CC-A461-4546-8BCD-C9A28F0E06F5}"
    GetStorageFormat(pnStorageFormat)
      => ComCall(22, this.p, WMT_STORAGE_FORMAT.Ptr, pnStorageFormat)
    SetStorageFormat(nStorageFormat)
      => ComCall(23, this.p, WMT_STORAGE_FORMAT, nStorageFormat)
    GetBandwidthSharingCount(pcBS)
      => ComCall(24, this.p, UInt32.Ptr, pcBS)
    GetBandwidthSharing(dwBSIndex, ppBS)
      => ComCall(25, this.p, UInt32, dwBSIndex, IWMBandwidthSharing.Ptr, ppBS)
    RemoveBandwidthSharing(pBS)
      => ComCall(26, this.p, IWMBandwidthSharing, pBS)
    AddBandwidthSharing(pBS)
      => ComCall(27, this.p, IWMBandwidthSharing, pBS)
    CreateNewBandwidthSharing(ppBS)
      => ComCall(28, this.p, IWMBandwidthSharing.Ptr, ppBS)
    GetStreamPrioritization(ppSP)
      => ComCall(29, this.p, IWMStreamPrioritization.Ptr, ppSP)
    SetStreamPrioritization(pSP)
      => ComCall(30, this.p, IWMStreamPrioritization, pSP)
    RemoveStreamPrioritization()
      => ComCall(31, this.p)
    CreateNewStreamPrioritization(ppSP)
      => ComCall(32, this.p, IWMStreamPrioritization.Ptr, ppSP)
    GetExpectedPacketCount(msDuration, pcPackets)
      => ComCall(33, this.p, Int64, msDuration, Int64.Ptr, pcPackets)
}
struct IWMStreamConfig extends IUnknown {
    static IID := "{96406BDC-2B2B-11D3-B36B-00C04F6108FF}"
    GetStreamType(pguidStreamType)
      => ComCall(3, this.p, GUID.Ptr, pguidStreamType)
    GetStreamNumber(pwStreamNum)
      => ComCall(4, this.p, UInt16.Ptr, pwStreamNum)
    SetStreamNumber(wStreamNum)
      => ComCall(5, this.p, UInt16, wStreamNum)
    GetStreamName(pwszStreamName)
      => ComCall(6, this.p, PWSTR, pwszStreamName, UInt16.Ptr, pwszStreamName.Length)
    SetStreamName(pwszStreamName)
      => ComCall(7, this.p, "Str", pwszStreamName)
    GetConnectionName(pwszInputName)
      => ComCall(8, this.p, PWSTR, pwszInputName, UInt16.Ptr, pwszInputName.Length)
    SetConnectionName(pwszInputName)
      => ComCall(9, this.p, "Str", pwszInputName)
    GetBitrate(pdwBitrate)
      => ComCall(10, this.p, UInt32.Ptr, pdwBitrate)
    SetBitrate(pdwBitrate)
      => ComCall(11, this.p, UInt32, pdwBitrate)
    GetBufferWindow(pmsBufferWindow)
      => ComCall(12, this.p, UInt32.Ptr, pmsBufferWindow)
    SetBufferWindow(msBufferWindow)
      => ComCall(13, this.p, UInt32, msBufferWindow)
}
struct IWMStreamConfig2 extends IWMStreamConfig {
    static IID := "{7688D8CB-FC0D-43BD-9459-5A8DEC200CFA}"
    GetTransportType(pnTransportType)
      => ComCall(14, this.p, WMT_TRANSPORT_TYPE.Ptr, pnTransportType)
    SetTransportType(nTransportType)
      => ComCall(15, this.p, WMT_TRANSPORT_TYPE, nTransportType)
    AddDataUnitExtension(guidExtensionSystemID, cbExtensionDataSize, pbExtensionSystemInfo)
      => ComCall(16, this.p, GUID, guidExtensionSystemID, UInt16, cbExtensionDataSize, UInt8.Ptr, pbExtensionSystemInfo, UInt32, pbExtensionSystemInfo.Length)
    GetDataUnitExtensionCount(pcDataUnitExtensions)
      => ComCall(17, this.p, UInt16.Ptr, pcDataUnitExtensions)
    GetDataUnitExtension(wDataUnitExtensionNumber, pguidExtensionSystemID, pcbExtensionDataSize, pbExtensionSystemInfo)
      => ComCall(18, this.p, UInt16, wDataUnitExtensionNumber, GUID.Ptr, pguidExtensionSystemID, UInt16.Ptr, pcbExtensionDataSize, UInt8.Ptr, pbExtensionSystemInfo, UInt32.Ptr, pbExtensionSystemInfo.Length)
    RemoveAllDataUnitExtensions()
      => ComCall(19, this.p)
}
struct IWMStreamConfig3 extends IWMStreamConfig2 {
    static IID := "{CB164104-3AA9-45A7-9AC9-4DAEE131D6E1}"
    GetLanguage(pwszLanguageString)
      => ComCall(20, this.p, PWSTR, pwszLanguageString, UInt16.Ptr, pwszLanguageString.Length)
    SetLanguage(pwszLanguageString)
      => ComCall(21, this.p, "Str", pwszLanguageString)
}
struct IWMPacketSize extends IUnknown {
    static IID := "{CDFB97AB-188F-40B3-B643-5B7903975C59}"
    GetMaxPacketSize(pdwMaxPacketSize)
      => ComCall(3, this.p, UInt32.Ptr, pdwMaxPacketSize)
    SetMaxPacketSize(dwMaxPacketSize)
      => ComCall(4, this.p, UInt32, dwMaxPacketSize)
}
struct IWMPacketSize2 extends IWMPacketSize {
    static IID := "{8BFC2B9E-B646-4233-A877-1C6A079669DC}"
    GetMinPacketSize(pdwMinPacketSize)
      => ComCall(5, this.p, UInt32.Ptr, pdwMinPacketSize)
    SetMinPacketSize(dwMinPacketSize)
      => ComCall(6, this.p, UInt32, dwMinPacketSize)
}
struct IWMStreamList extends IUnknown {
    static IID := "{96406BDD-2B2B-11D3-B36B-00C04F6108FF}"
    GetStreams(pwStreamNumArray)
      => ComCall(3, this.p, UInt16.Ptr, pwStreamNumArray, UInt16.Ptr, pwStreamNumArray.Length)
    AddStream(wStreamNum)
      => ComCall(4, this.p, UInt16, wStreamNum)
    RemoveStream(wStreamNum)
      => ComCall(5, this.p, UInt16, wStreamNum)
}
struct IWMMutualExclusion extends IWMStreamList {
    static IID := "{96406BDE-2B2B-11D3-B36B-00C04F6108FF}"
    GetType(pguidType)
      => ComCall(6, this.p, GUID.Ptr, pguidType)
    SetType(guidType)
      => ComCall(7, this.p, GUID.Ptr, guidType)
}
struct IWMMutualExclusion2 extends IWMMutualExclusion {
    static IID := "{0302B57D-89D1-4BA2-85C9-166F2C53EB91}"
    GetName(pwszName)
      => ComCall(8, this.p, PWSTR, pwszName, UInt16.Ptr, pwszName.Length)
    SetName(pwszName)
      => ComCall(9, this.p, "Str", pwszName)
    GetRecordCount(pwRecordCount)
      => ComCall(10, this.p, UInt16.Ptr, pwRecordCount)
    AddRecord()
      => ComCall(11, this.p)
    RemoveRecord(wRecordNumber)
      => ComCall(12, this.p, UInt16, wRecordNumber)
    GetRecordName(wRecordNumber, pwszRecordName)
      => ComCall(13, this.p, UInt16, wRecordNumber, PWSTR, pwszRecordName, UInt16.Ptr, pwszRecordName.Length)
    SetRecordName(wRecordNumber, pwszRecordName)
      => ComCall(14, this.p, UInt16, wRecordNumber, "Str", pwszRecordName)
    GetStreamsForRecord(wRecordNumber, pwStreamNumArray)
      => ComCall(15, this.p, UInt16, wRecordNumber, UInt16.Ptr, pwStreamNumArray, UInt16.Ptr, pwStreamNumArray.Length)
    AddStreamForRecord(wRecordNumber, wStreamNumber)
      => ComCall(16, this.p, UInt16, wRecordNumber, UInt16, wStreamNumber)
    RemoveStreamForRecord(wRecordNumber, wStreamNumber)
      => ComCall(17, this.p, UInt16, wRecordNumber, UInt16, wStreamNumber)
}
struct IWMBandwidthSharing extends IWMStreamList {
    static IID := "{AD694AF1-F8D9-42F8-BC47-70311B0C4F9E}"
    GetType(pguidType)
      => ComCall(6, this.p, GUID.Ptr, pguidType)
    SetType(guidType)
      => ComCall(7, this.p, GUID.Ptr, guidType)
    GetBandwidth(pdwBitrate, pmsBufferWindow)
      => ComCall(8, this.p, UInt32.Ptr, pdwBitrate, UInt32.Ptr, pmsBufferWindow)
    SetBandwidth(dwBitrate, msBufferWindow)
      => ComCall(9, this.p, UInt32, dwBitrate, UInt32, msBufferWindow)
}
struct IWMStreamPrioritization extends IUnknown {
    static IID := "{8C1C6090-F9A8-4748-8EC3-DD1108BA1E77}"
    GetPriorityRecords(pRecordArray)
      => ComCall(3, this.p, WM_STREAM_PRIORITY_RECORD.Ptr, pRecordArray, UInt16.Ptr, pRecordArray.Length)
    SetPriorityRecords(pRecordArray, cRecords)
      => ComCall(4, this.p, WM_STREAM_PRIORITY_RECORD.Ptr, pRecordArray, UInt16, cRecords)
}
struct IWMWriterAdvanced extends IUnknown {
    static IID := "{96406BE3-2B2B-11D3-B36B-00C04F6108FF}"
    GetSinkCount(pcSinks)
      => ComCall(3, this.p, UInt32.Ptr, pcSinks)
    GetSink(dwSinkNum, ppSink)
      => ComCall(4, this.p, UInt32, dwSinkNum, IWMWriterSink.Ptr, ppSink)
    AddSink(pSink)
      => ComCall(5, this.p, IWMWriterSink, pSink)
    RemoveSink(pSink)
      => ComCall(6, this.p, IWMWriterSink, pSink)
    WriteStreamSample(wStreamNum, cnsSampleTime, msSampleSendTime, cnsSampleDuration, dwFlags, pSample)
      => ComCall(7, this.p, UInt16, wStreamNum, Int64, cnsSampleTime, UInt32, msSampleSendTime, Int64, cnsSampleDuration, UInt32, dwFlags, INSSBuffer, pSample)
    SetLiveSource(fIsLiveSource)
      => ComCall(8, this.p, BOOL, fIsLiveSource)
    IsRealTime(pfRealTime)
      => ComCall(9, this.p, BOOL.Ptr, pfRealTime)
    GetWriterTime(pcnsCurrentTime)
      => ComCall(10, this.p, Int64.Ptr, pcnsCurrentTime)
    GetStatistics(wStreamNum, pStats)
      => ComCall(11, this.p, UInt16, wStreamNum, WM_WRITER_STATISTICS.Ptr, pStats)
    SetSyncTolerance(msWindow)
      => ComCall(12, this.p, UInt32, msWindow)
    GetSyncTolerance(pmsWindow)
      => ComCall(13, this.p, UInt32.Ptr, pmsWindow)
}
struct IWMWriterAdvanced2 extends IWMWriterAdvanced {
    static IID := "{962DC1EC-C046-4DB8-9CC7-26CEAE500817}"
    GetInputSetting(dwInputNum, pszName, pType, pValue)
      => ComCall(14, this.p, UInt32, dwInputNum, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    SetInputSetting(dwInputNum, pszName, Type, pValue)
      => ComCall(15, this.p, UInt32, dwInputNum, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
}
struct IWMWriterAdvanced3 extends IWMWriterAdvanced2 {
    static IID := "{2CD6492D-7C37-4E76-9D3B-59261183A22E}"
    GetStatisticsEx(wStreamNum, pStats)
      => ComCall(16, this.p, UInt16, wStreamNum, WM_WRITER_STATISTICS_EX.Ptr, pStats)
    SetNonBlocking()
      => ComCall(17, this.p)
}
struct IWMWriterPreprocess extends IUnknown {
    static IID := "{FC54A285-38C4-45B5-AA23-85B9F7CB424B}"
    GetMaxPreprocessingPasses(dwInputNum, dwFlags, pdwMaxNumPasses)
      => ComCall(3, this.p, UInt32, dwInputNum, UInt32, dwFlags, UInt32.Ptr, pdwMaxNumPasses)
    SetNumPreprocessingPasses(dwInputNum, dwFlags, dwNumPasses)
      => ComCall(4, this.p, UInt32, dwInputNum, UInt32, dwFlags, UInt32, dwNumPasses)
    BeginPreprocessingPass(dwInputNum, dwFlags)
      => ComCall(5, this.p, UInt32, dwInputNum, UInt32, dwFlags)
    PreprocessSample(dwInputNum, cnsSampleTime, dwFlags, pSample)
      => ComCall(6, this.p, UInt32, dwInputNum, Int64, cnsSampleTime, UInt32, dwFlags, INSSBuffer, pSample)
    EndPreprocessingPass(dwInputNum, dwFlags)
      => ComCall(7, this.p, UInt32, dwInputNum, UInt32, dwFlags)
}
struct IWMWriterPostViewCallback extends IWMStatusCallback {
    static IID := "{D9D6549D-A193-4F24-B308-03123D9B7F8D}"
    OnPostViewSample(wStreamNumber, cnsSampleTime, cnsSampleDuration, dwFlags, pSample, pvContext)
      => ComCall(4, this.p, UInt16, wStreamNumber, Int64, cnsSampleTime, Int64, cnsSampleDuration, UInt32, dwFlags, INSSBuffer, pSample, Struct.Ptr, pvContext)
    AllocateForPostView(wStreamNum, cbBuffer, ppBuffer, pvContext)
      => ComCall(5, this.p, UInt16, wStreamNum, UInt32, cbBuffer, INSSBuffer.Ptr, ppBuffer, Struct.Ptr, pvContext)
}
struct IWMWriterPostView extends IUnknown {
    static IID := "{81E20CE4-75EF-491A-8004-FC53C45BDC3E}"
    SetPostViewCallback(pCallback, pvContext)
      => ComCall(3, this.p, IWMWriterPostViewCallback, pCallback, Struct.Ptr, pvContext)
    SetReceivePostViewSamples(wStreamNum, fReceivePostViewSamples)
      => ComCall(4, this.p, UInt16, wStreamNum, BOOL, fReceivePostViewSamples)
    GetReceivePostViewSamples(wStreamNum, pfReceivePostViewSamples)
      => ComCall(5, this.p, UInt16, wStreamNum, BOOL.Ptr, pfReceivePostViewSamples)
    GetPostViewProps(wStreamNumber, ppOutput)
      => ComCall(6, this.p, UInt16, wStreamNumber, IWMMediaProps.Ptr, ppOutput)
    SetPostViewProps(wStreamNumber, pOutput)
      => ComCall(7, this.p, UInt16, wStreamNumber, IWMMediaProps, pOutput)
    GetPostViewFormatCount(wStreamNumber, pcFormats)
      => ComCall(8, this.p, UInt16, wStreamNumber, UInt32.Ptr, pcFormats)
    GetPostViewFormat(wStreamNumber, dwFormatNumber, ppProps)
      => ComCall(9, this.p, UInt16, wStreamNumber, UInt32, dwFormatNumber, IWMMediaProps.Ptr, ppProps)
    SetAllocateForPostView(wStreamNumber, fAllocate)
      => ComCall(10, this.p, UInt16, wStreamNumber, BOOL, fAllocate)
    GetAllocateForPostView(wStreamNumber, pfAllocate)
      => ComCall(11, this.p, UInt16, wStreamNumber, BOOL.Ptr, pfAllocate)
}
struct IWMWriterSink extends IUnknown {
    static IID := "{96406BE4-2B2B-11D3-B36B-00C04F6108FF}"
    OnHeader(pHeader)
      => ComCall(3, this.p, INSSBuffer, pHeader)
    IsRealTime(pfRealTime)
      => ComCall(4, this.p, BOOL.Ptr, pfRealTime)
    AllocateDataUnit(cbDataUnit, ppDataUnit)
      => ComCall(5, this.p, UInt32, cbDataUnit, INSSBuffer.Ptr, ppDataUnit)
    OnDataUnit(pDataUnit)
      => ComCall(6, this.p, INSSBuffer, pDataUnit)
    OnEndWriting()
      => ComCall(7, this.p)
}
struct IWMRegisterCallback extends IUnknown {
    static IID := "{CF4B1F99-4DE2-4E49-A363-252740D99BC1}"
    Advise(pCallback, pvContext)
      => ComCall(3, this.p, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
    Unadvise(pCallback, pvContext)
      => ComCall(4, this.p, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
}
struct IWMWriterFileSink extends IWMWriterSink {
    static IID := "{96406BE5-2B2B-11D3-B36B-00C04F6108FF}"
    Open(pwszFilename)
      => ComCall(8, this.p, "Str", pwszFilename)
}
struct IWMWriterFileSink2 extends IWMWriterFileSink {
    static IID := "{14282BA7-4AEF-4205-8CE5-C229035A05BC}"
    Start(cnsStartTime)
      => ComCall(9, this.p, Int64, cnsStartTime)
    Stop(cnsStopTime)
      => ComCall(10, this.p, Int64, cnsStopTime)
    IsStopped(pfStopped)
      => ComCall(11, this.p, BOOL.Ptr, pfStopped)
    GetFileDuration(pcnsDuration)
      => ComCall(12, this.p, Int64.Ptr, pcnsDuration)
    GetFileSize(pcbFile)
      => ComCall(13, this.p, Int64.Ptr, pcbFile)
    Close()
      => ComCall(14, this.p)
    IsClosed(pfClosed)
      => ComCall(15, this.p, BOOL.Ptr, pfClosed)
}
struct IWMWriterFileSink3 extends IWMWriterFileSink2 {
    static IID := "{3FEA4FEB-2945-47A7-A1DD-C53A8FC4C45C}"
    SetAutoIndexing(fDoAutoIndexing)
      => ComCall(16, this.p, BOOL, fDoAutoIndexing)
    GetAutoIndexing(pfAutoIndexing)
      => ComCall(17, this.p, BOOL.Ptr, pfAutoIndexing)
    SetControlStream(wStreamNumber, fShouldControlStartAndStop)
      => ComCall(18, this.p, UInt16, wStreamNumber, BOOL, fShouldControlStartAndStop)
    GetMode(pdwFileSinkMode)
      => ComCall(19, this.p, UInt32.Ptr, pdwFileSinkMode)
    OnDataUnitEx(pFileSinkDataUnit)
      => ComCall(20, this.p, WMT_FILESINK_DATA_UNIT.Ptr, pFileSinkDataUnit)
    SetUnbufferedIO(fUnbufferedIO, fRestrictMemUsage)
      => ComCall(21, this.p, BOOL, fUnbufferedIO, BOOL, fRestrictMemUsage)
    GetUnbufferedIO(pfUnbufferedIO)
      => ComCall(22, this.p, BOOL.Ptr, pfUnbufferedIO)
    CompleteOperations()
      => ComCall(23, this.p)
}
struct IWMWriterNetworkSink extends IWMWriterSink {
    static IID := "{96406BE7-2B2B-11D3-B36B-00C04F6108FF}"
    SetMaximumClients(dwMaxClients)
      => ComCall(8, this.p, UInt32, dwMaxClients)
    GetMaximumClients(pdwMaxClients)
      => ComCall(9, this.p, UInt32.Ptr, pdwMaxClients)
    SetNetworkProtocol(protocol)
      => ComCall(10, this.p, WMT_NET_PROTOCOL, protocol)
    GetNetworkProtocol(pProtocol)
      => ComCall(11, this.p, WMT_NET_PROTOCOL.Ptr, pProtocol)
    GetHostURL(pwszURL, pcchURL)
      => ComCall(12, this.p, PWSTR, pwszURL, UInt32.Ptr, pcchURL)
    Open(pdwPortNum)
      => ComCall(13, this.p, UInt32.Ptr, pdwPortNum)
    Disconnect()
      => ComCall(14, this.p)
    Close()
      => ComCall(15, this.p)
}
struct IWMClientConnections extends IUnknown {
    static IID := "{73C66010-A299-41DF-B1F0-CCF03B09C1C6}"
    GetClientCount(pcClients)
      => ComCall(3, this.p, UInt32.Ptr, pcClients)
    GetClientProperties(dwClientNum, pClientProperties)
      => ComCall(4, this.p, UInt32, dwClientNum, WM_CLIENT_PROPERTIES.Ptr, pClientProperties)
}
struct IWMClientConnections2 extends IWMClientConnections {
    static IID := "{4091571E-4701-4593-BB3D-D5F5F0C74246}"
    GetClientInfo(dwClientNum, pwszNetworkAddress, pwszPort, pwszDNSName)
      => ComCall(5, this.p, UInt32, dwClientNum, PWSTR, pwszNetworkAddress, UInt32.Ptr, pwszNetworkAddress.Length, PWSTR, pwszPort, UInt32.Ptr, pwszPort.Length, PWSTR, pwszDNSName, UInt32.Ptr, pwszDNSName.Length)
}
struct IWMReaderAdvanced extends IUnknown {
    static IID := "{96406BEA-2B2B-11D3-B36B-00C04F6108FF}"
    SetUserProvidedClock(fUserClock)
      => ComCall(3, this.p, BOOL, fUserClock)
    GetUserProvidedClock(pfUserClock)
      => ComCall(4, this.p, BOOL.Ptr, pfUserClock)
    DeliverTime(cnsTime)
      => ComCall(5, this.p, Int64, cnsTime)
    SetManualStreamSelection(fSelection)
      => ComCall(6, this.p, BOOL, fSelection)
    GetManualStreamSelection(pfSelection)
      => ComCall(7, this.p, BOOL.Ptr, pfSelection)
    SetStreamsSelected(cStreamCount, pwStreamNumbers, pSelections)
      => ComCall(8, this.p, UInt16, cStreamCount, UInt16.Ptr, pwStreamNumbers, WMT_STREAM_SELECTION.Ptr, pSelections)
    GetStreamSelected(wStreamNum, pSelection)
      => ComCall(9, this.p, UInt16, wStreamNum, WMT_STREAM_SELECTION.Ptr, pSelection)
    SetReceiveSelectionCallbacks(fGetCallbacks)
      => ComCall(10, this.p, BOOL, fGetCallbacks)
    GetReceiveSelectionCallbacks(pfGetCallbacks)
      => ComCall(11, this.p, BOOL.Ptr, pfGetCallbacks)
    SetReceiveStreamSamples(wStreamNum, fReceiveStreamSamples)
      => ComCall(12, this.p, UInt16, wStreamNum, BOOL, fReceiveStreamSamples)
    GetReceiveStreamSamples(wStreamNum, pfReceiveStreamSamples)
      => ComCall(13, this.p, UInt16, wStreamNum, BOOL.Ptr, pfReceiveStreamSamples)
    SetAllocateForOutput(dwOutputNum, fAllocate)
      => ComCall(14, this.p, UInt32, dwOutputNum, BOOL, fAllocate)
    GetAllocateForOutput(dwOutputNum, pfAllocate)
      => ComCall(15, this.p, UInt32, dwOutputNum, BOOL.Ptr, pfAllocate)
    SetAllocateForStream(wStreamNum, fAllocate)
      => ComCall(16, this.p, UInt16, wStreamNum, BOOL, fAllocate)
    GetAllocateForStream(dwSreamNum, pfAllocate)
      => ComCall(17, this.p, UInt16, dwSreamNum, BOOL.Ptr, pfAllocate)
    GetStatistics(pStatistics)
      => ComCall(18, this.p, WM_READER_STATISTICS.Ptr, pStatistics)
    SetClientInfo(pClientInfo)
      => ComCall(19, this.p, WM_READER_CLIENTINFO.Ptr, pClientInfo)
    GetMaxOutputSampleSize(dwOutput, pcbMax)
      => ComCall(20, this.p, UInt32, dwOutput, UInt32.Ptr, pcbMax)
    GetMaxStreamSampleSize(wStream, pcbMax)
      => ComCall(21, this.p, UInt16, wStream, UInt32.Ptr, pcbMax)
    NotifyLateDelivery(cnsLateness)
      => ComCall(22, this.p, Int64, cnsLateness)
}
struct IWMReaderAdvanced2 extends IWMReaderAdvanced {
    static IID := "{AE14A945-B90C-4D0D-9127-80D665F7D73E}"
    SetPlayMode(Mode)
      => ComCall(23, this.p, WMT_PLAY_MODE, Mode)
    GetPlayMode(pMode)
      => ComCall(24, this.p, WMT_PLAY_MODE.Ptr, pMode)
    GetBufferProgress(pdwPercent, pcnsBuffering)
      => ComCall(25, this.p, UInt32.Ptr, pdwPercent, Int64.Ptr, pcnsBuffering)
    GetDownloadProgress(pdwPercent, pqwBytesDownloaded, pcnsDownload)
      => ComCall(26, this.p, UInt32.Ptr, pdwPercent, Int64.Ptr, pqwBytesDownloaded, Int64.Ptr, pcnsDownload)
    GetSaveAsProgress(pdwPercent)
      => ComCall(27, this.p, UInt32.Ptr, pdwPercent)
    SaveFileAs(pwszFilename)
      => ComCall(28, this.p, "Str", pwszFilename)
    GetProtocolName(pwszProtocol)
      => ComCall(29, this.p, PWSTR, pwszProtocol, UInt32.Ptr, pwszProtocol.Length)
    StartAtMarker(wMarkerIndex, cnsDuration, fRate, pvContext)
      => ComCall(30, this.p, UInt16, wMarkerIndex, Int64, cnsDuration, Float32, fRate, Struct.Ptr, pvContext)
    GetOutputSetting(dwOutputNum, pszName, pType, pValue)
      => ComCall(31, this.p, UInt32, dwOutputNum, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    SetOutputSetting(dwOutputNum, pszName, Type, pValue)
      => ComCall(32, this.p, UInt32, dwOutputNum, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
    Preroll(cnsStart, cnsDuration, fRate)
      => ComCall(33, this.p, Int64, cnsStart, Int64, cnsDuration, Float32, fRate)
    SetLogClientID(fLogClientID)
      => ComCall(34, this.p, BOOL, fLogClientID)
    GetLogClientID(pfLogClientID)
      => ComCall(35, this.p, BOOL.Ptr, pfLogClientID)
    StopBuffering()
      => ComCall(36, this.p)
    OpenStream(pStream, pCallback, pvContext)
      => ComCall(37, this.p, IStream, pStream, IWMReaderCallback, pCallback, Struct.Ptr, pvContext)
}
struct IWMReaderAdvanced3 extends IWMReaderAdvanced2 {
    static IID := "{5DC0674B-F04B-4A4E-9F2A-B1AFDE2C8100}"
    StopNetStreaming()
      => ComCall(38, this.p)
    StartAtPosition(wStreamNum, pvOffsetStart, pvDuration, dwOffsetFormat, fRate, pvContext)
      => ComCall(39, this.p, UInt16, wStreamNum, Struct.Ptr, pvOffsetStart, Struct.Ptr, pvDuration, WMT_OFFSET_FORMAT, dwOffsetFormat, Float32, fRate, Struct.Ptr, pvContext)
}
struct IWMReaderAdvanced4 extends IWMReaderAdvanced3 {
    static IID := "{945A76A2-12AE-4D48-BD3C-CD1D90399B85}"
    GetLanguageCount(dwOutputNum, pwLanguageCount)
      => ComCall(40, this.p, UInt32, dwOutputNum, UInt16.Ptr, pwLanguageCount)
    GetLanguage(dwOutputNum, wLanguage, pwszLanguageString)
      => ComCall(41, this.p, UInt32, dwOutputNum, UInt16, wLanguage, PWSTR, pwszLanguageString, UInt16.Ptr, pwszLanguageString.Length)
    GetMaxSpeedFactor(pdblFactor)
      => ComCall(42, this.p, Float64.Ptr, pdblFactor)
    IsUsingFastCache(pfUsingFastCache)
      => ComCall(43, this.p, BOOL.Ptr, pfUsingFastCache)
    AddLogParam(wszNameSpace, wszName, wszValue)
      => ComCall(44, this.p, "Str", wszNameSpace, "Str", wszName, "Str", wszValue)
    SendLogParams()
      => ComCall(45, this.p)
    CanSaveFileAs(pfCanSave)
      => ComCall(46, this.p, BOOL.Ptr, pfCanSave)
    CancelSaveFileAs()
      => ComCall(47, this.p)
    GetURL(pwszURL)
      => ComCall(48, this.p, PWSTR, pwszURL, UInt32.Ptr, pwszURL.Length)
}
struct IWMReaderAdvanced5 extends IWMReaderAdvanced4 {
    static IID := "{24C44DB0-55D1-49AE-A5CC-F13815E36363}"
    SetPlayerHook(dwOutputNum, pHook)
      => ComCall(49, this.p, UInt32, dwOutputNum, IWMPlayerHook, pHook)
}
struct IWMReaderAdvanced6 extends IWMReaderAdvanced5 {
    static IID := "{18A2E7F8-428F-4ACD-8A00-E64639BC93DE}"
    SetProtectStreamSamples(pbCertificate, dwCertificateType, dwFlags, pbInitializationVector)
      => ComCall(50, this.p, UInt8.Ptr, pbCertificate, UInt32, pbCertificate.Length, UInt32, dwCertificateType, UInt32, dwFlags, UInt8.Ptr, pbInitializationVector, UInt32.Ptr, pbInitializationVector.Length)
}
struct IWMPlayerHook extends IUnknown {
    static IID := "{E5B7CA9A-0F1C-4F66-9002-74EC50D8B304}"
    PreDecode()
      => ComCall(3, this.p)
}
struct IWMReaderAllocatorEx extends IUnknown {
    static IID := "{9F762FA7-A22E-428D-93C9-AC82F3AAFE5A}"
    AllocateForStreamEx(wStreamNum, cbBuffer, ppBuffer, dwFlags, cnsSampleTime, cnsSampleDuration, pvContext)
      => ComCall(3, this.p, UInt16, wStreamNum, UInt32, cbBuffer, INSSBuffer.Ptr, ppBuffer, UInt32, dwFlags, Int64, cnsSampleTime, Int64, cnsSampleDuration, Struct.Ptr, pvContext)
    AllocateForOutputEx(dwOutputNum, cbBuffer, ppBuffer, dwFlags, cnsSampleTime, cnsSampleDuration, pvContext)
      => ComCall(4, this.p, UInt32, dwOutputNum, UInt32, cbBuffer, INSSBuffer.Ptr, ppBuffer, UInt32, dwFlags, Int64, cnsSampleTime, Int64, cnsSampleDuration, Struct.Ptr, pvContext)
}
struct IWMReaderTypeNegotiation extends IUnknown {
    static IID := "{FDBE5592-81A1-41EA-93BD-735CAD1ADC05}"
    TryOutputProps(dwOutputNum, pOutput)
      => ComCall(3, this.p, UInt32, dwOutputNum, IWMOutputMediaProps, pOutput)
}
struct IWMReaderCallbackAdvanced extends IUnknown {
    static IID := "{96406BEB-2B2B-11D3-B36B-00C04F6108FF}"
    OnStreamSample(wStreamNum, cnsSampleTime, cnsSampleDuration, dwFlags, pSample, pvContext)
      => ComCall(3, this.p, UInt16, wStreamNum, Int64, cnsSampleTime, Int64, cnsSampleDuration, UInt32, dwFlags, INSSBuffer, pSample, Struct.Ptr, pvContext)
    OnTime(cnsCurrentTime, pvContext)
      => ComCall(4, this.p, Int64, cnsCurrentTime, Struct.Ptr, pvContext)
    OnStreamSelection(wStreamCount, pStreamNumbers, pSelections, pvContext)
      => ComCall(5, this.p, UInt16, wStreamCount, UInt16.Ptr, pStreamNumbers, WMT_STREAM_SELECTION.Ptr, pSelections, Struct.Ptr, pvContext)
    OnOutputPropsChanged(dwOutputNum, pMediaType, pvContext)
      => ComCall(6, this.p, UInt32, dwOutputNum, WM_MEDIA_TYPE.Ptr, pMediaType, Struct.Ptr, pvContext)
    AllocateForStream(wStreamNum, cbBuffer, ppBuffer, pvContext)
      => ComCall(7, this.p, UInt16, wStreamNum, UInt32, cbBuffer, INSSBuffer.Ptr, ppBuffer, Struct.Ptr, pvContext)
    AllocateForOutput(dwOutputNum, cbBuffer, ppBuffer, pvContext)
      => ComCall(8, this.p, UInt32, dwOutputNum, UInt32, cbBuffer, INSSBuffer.Ptr, ppBuffer, Struct.Ptr, pvContext)
}
struct IWMDRMReader extends IUnknown {
    static IID := "{D2827540-3EE7-432C-B14C-DC17F085D3B3}"
    AcquireLicense(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
    CancelLicenseAcquisition()
      => ComCall(4, this.p)
    Individualize(dwFlags)
      => ComCall(5, this.p, UInt32, dwFlags)
    CancelIndividualization()
      => ComCall(6, this.p)
    MonitorLicenseAcquisition()
      => ComCall(7, this.p)
    CancelMonitorLicenseAcquisition()
      => ComCall(8, this.p)
    SetDRMProperty(pwstrName, dwType, pValue)
      => ComCall(9, this.p, "Str", pwstrName, WMT_ATTR_DATATYPE, dwType, UInt8.Ptr, pValue, UInt16, pValue.Length)
    GetDRMProperty(pwstrName, pdwType, pValue)
      => ComCall(10, this.p, "Str", pwstrName, WMT_ATTR_DATATYPE.Ptr, pdwType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
}
struct DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS {
    wCompressedDigitalVideo : UInt16
    wUncompressedDigitalVideo : UInt16
    wAnalogVideo : UInt16
    wCompressedDigitalAudio : UInt16
    wUncompressedDigitalAudio : UInt16
}
struct DRM_OPL_OUTPUT_IDS {
    cIds : UInt16
    rgIds : GUID.Ptr
}
struct DRM_OUTPUT_PROTECTION {
    guidId : GUID
    bConfigData : UInt8
}
struct DRM_VIDEO_OUTPUT_PROTECTION_IDS {
    cEntries : UInt16
    rgVop : DRM_OUTPUT_PROTECTION.Ptr
}
struct DRM_PLAY_OPL {
    minOPL : DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS
    oplIdReserved : DRM_OPL_OUTPUT_IDS
    vopi : DRM_VIDEO_OUTPUT_PROTECTION_IDS
}
struct DRM_COPY_OPL {
    wMinimumCopyLevel : UInt16
    oplIdIncludes : DRM_OPL_OUTPUT_IDS
    oplIdExcludes : DRM_OPL_OUTPUT_IDS
}
struct IWMDRMReader2 extends IWMDRMReader {
    static IID := "{BEFE7A75-9F1D-4075-B9D9-A3C37BDA49A0}"
    SetEvaluateOutputLevelLicenses(fEvaluate)
      => ComCall(11, this.p, BOOL, fEvaluate)
    GetPlayOutputLevels(pPlayOPL, pdwMinAppComplianceLevel)
      => ComCall(12, this.p, DRM_PLAY_OPL.Ptr, pPlayOPL, UInt32.Ptr, pPlayOPL.Length, UInt32.Ptr, pdwMinAppComplianceLevel)
    GetCopyOutputLevels(pCopyOPL, pdwMinAppComplianceLevel)
      => ComCall(13, this.p, DRM_COPY_OPL.Ptr, pCopyOPL, UInt32.Ptr, pCopyOPL.Length, UInt32.Ptr, pdwMinAppComplianceLevel)
    TryNextLicense()
      => ComCall(14, this.p)
}
struct IWMDRMReader3 extends IWMDRMReader2 {
    static IID := "{E08672DE-F1E7-4FF4-A0A3-FC4B08E4CAF8}"
    GetInclusionList(ppGuids, pcGuids)
      => ComCall(15, this.p, GUID.Ptr.Ptr, ppGuids, UInt32.Ptr, pcGuids)
}
struct IWMReaderPlaylistBurn extends IUnknown {
    static IID := "{F28C0300-9BAA-4477-A846-1744D9CBF533}"
    InitPlaylistBurn(cFiles, ppwszFilenames, pCallback, pvContext)
      => ComCall(3, this.p, UInt32, cFiles, PWSTR.Ptr, ppwszFilenames, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
    GetInitResults(cFiles, phrStati)
      => ComCall(4, this.p, UInt32, cFiles, HRESULT.Ptr, phrStati)
    Cancel()
      => ComCall(5, this.p)
    EndPlaylistBurn(hrBurnResult)
      => ComCall(6, this.p, HRESULT, hrBurnResult)
}
struct IWMReaderNetworkConfig extends IUnknown {
    static IID := "{96406BEC-2B2B-11D3-B36B-00C04F6108FF}"
    GetBufferingTime(pcnsBufferingTime)
      => ComCall(3, this.p, Int64.Ptr, pcnsBufferingTime)
    SetBufferingTime(cnsBufferingTime)
      => ComCall(4, this.p, Int64, cnsBufferingTime)
    GetUDPPortRanges(pRangeArray)
      => ComCall(5, this.p, WM_PORT_NUMBER_RANGE.Ptr, pRangeArray, UInt32.Ptr, pRangeArray.Length)
    SetUDPPortRanges(pRangeArray)
      => ComCall(6, this.p, WM_PORT_NUMBER_RANGE.Ptr, pRangeArray, UInt32, pRangeArray.Length)
    GetProxySettings(pwszProtocol, pProxySetting)
      => ComCall(7, this.p, "Str", pwszProtocol, WMT_PROXY_SETTINGS.Ptr, pProxySetting)
    SetProxySettings(pwszProtocol, ProxySetting)
      => ComCall(8, this.p, "Str", pwszProtocol, WMT_PROXY_SETTINGS, ProxySetting)
    GetProxyHostName(pwszProtocol, pwszHostName)
      => ComCall(9, this.p, "Str", pwszProtocol, PWSTR, pwszHostName, UInt32.Ptr, pwszHostName.Length)
    SetProxyHostName(pwszProtocol, pwszHostName)
      => ComCall(10, this.p, "Str", pwszProtocol, "Str", pwszHostName)
    GetProxyPort(pwszProtocol, pdwPort)
      => ComCall(11, this.p, "Str", pwszProtocol, UInt32.Ptr, pdwPort)
    SetProxyPort(pwszProtocol, dwPort)
      => ComCall(12, this.p, "Str", pwszProtocol, UInt32, dwPort)
    GetProxyExceptionList(pwszProtocol, pwszExceptionList)
      => ComCall(13, this.p, "Str", pwszProtocol, PWSTR, pwszExceptionList, UInt32.Ptr, pwszExceptionList.Length)
    SetProxyExceptionList(pwszProtocol, pwszExceptionList)
      => ComCall(14, this.p, "Str", pwszProtocol, "Str", pwszExceptionList)
    GetProxyBypassForLocal(pwszProtocol, pfBypassForLocal)
      => ComCall(15, this.p, "Str", pwszProtocol, BOOL.Ptr, pfBypassForLocal)
    SetProxyBypassForLocal(pwszProtocol, fBypassForLocal)
      => ComCall(16, this.p, "Str", pwszProtocol, BOOL, fBypassForLocal)
    GetForceRerunAutoProxyDetection(pfForceRerunDetection)
      => ComCall(17, this.p, BOOL.Ptr, pfForceRerunDetection)
    SetForceRerunAutoProxyDetection(fForceRerunDetection)
      => ComCall(18, this.p, BOOL, fForceRerunDetection)
    GetEnableMulticast(pfEnableMulticast)
      => ComCall(19, this.p, BOOL.Ptr, pfEnableMulticast)
    SetEnableMulticast(fEnableMulticast)
      => ComCall(20, this.p, BOOL, fEnableMulticast)
    GetEnableHTTP(pfEnableHTTP)
      => ComCall(21, this.p, BOOL.Ptr, pfEnableHTTP)
    SetEnableHTTP(fEnableHTTP)
      => ComCall(22, this.p, BOOL, fEnableHTTP)
    GetEnableUDP(pfEnableUDP)
      => ComCall(23, this.p, BOOL.Ptr, pfEnableUDP)
    SetEnableUDP(fEnableUDP)
      => ComCall(24, this.p, BOOL, fEnableUDP)
    GetEnableTCP(pfEnableTCP)
      => ComCall(25, this.p, BOOL.Ptr, pfEnableTCP)
    SetEnableTCP(fEnableTCP)
      => ComCall(26, this.p, BOOL, fEnableTCP)
    ResetProtocolRollover()
      => ComCall(27, this.p)
    GetConnectionBandwidth(pdwConnectionBandwidth)
      => ComCall(28, this.p, UInt32.Ptr, pdwConnectionBandwidth)
    SetConnectionBandwidth(dwConnectionBandwidth)
      => ComCall(29, this.p, UInt32, dwConnectionBandwidth)
    GetNumProtocolsSupported(pcProtocols)
      => ComCall(30, this.p, UInt32.Ptr, pcProtocols)
    GetSupportedProtocolName(dwProtocolNum, pwszProtocolName)
      => ComCall(31, this.p, UInt32, dwProtocolNum, PWSTR, pwszProtocolName, UInt32.Ptr, pwszProtocolName.Length)
    AddLoggingUrl(pwszUrl)
      => ComCall(32, this.p, "Str", pwszUrl)
    GetLoggingUrl(dwIndex, pwszUrl)
      => ComCall(33, this.p, UInt32, dwIndex, PWSTR, pwszUrl, UInt32.Ptr, pwszUrl.Length)
    GetLoggingUrlCount(pdwUrlCount)
      => ComCall(34, this.p, UInt32.Ptr, pdwUrlCount)
    ResetLoggingUrlList()
      => ComCall(35, this.p)
}
struct IWMReaderNetworkConfig2 extends IWMReaderNetworkConfig {
    static IID := "{D979A853-042B-4050-8387-C939DB22013F}"
    GetEnableContentCaching(pfEnableContentCaching)
      => ComCall(36, this.p, BOOL.Ptr, pfEnableContentCaching)
    SetEnableContentCaching(fEnableContentCaching)
      => ComCall(37, this.p, BOOL, fEnableContentCaching)
    GetEnableFastCache(pfEnableFastCache)
      => ComCall(38, this.p, BOOL.Ptr, pfEnableFastCache)
    SetEnableFastCache(fEnableFastCache)
      => ComCall(39, this.p, BOOL, fEnableFastCache)
    GetAcceleratedStreamingDuration(pcnsAccelDuration)
      => ComCall(40, this.p, Int64.Ptr, pcnsAccelDuration)
    SetAcceleratedStreamingDuration(cnsAccelDuration)
      => ComCall(41, this.p, Int64, cnsAccelDuration)
    GetAutoReconnectLimit(pdwAutoReconnectLimit)
      => ComCall(42, this.p, UInt32.Ptr, pdwAutoReconnectLimit)
    SetAutoReconnectLimit(dwAutoReconnectLimit)
      => ComCall(43, this.p, UInt32, dwAutoReconnectLimit)
    GetEnableResends(pfEnableResends)
      => ComCall(44, this.p, BOOL.Ptr, pfEnableResends)
    SetEnableResends(fEnableResends)
      => ComCall(45, this.p, BOOL, fEnableResends)
    GetEnableThinning(pfEnableThinning)
      => ComCall(46, this.p, BOOL.Ptr, pfEnableThinning)
    SetEnableThinning(fEnableThinning)
      => ComCall(47, this.p, BOOL, fEnableThinning)
    GetMaxNetPacketSize(pdwMaxNetPacketSize)
      => ComCall(48, this.p, UInt32.Ptr, pdwMaxNetPacketSize)
}
struct IWMReaderStreamClock extends IUnknown {
    static IID := "{96406BED-2B2B-11D3-B36B-00C04F6108FF}"
    GetTime(pcnsNow)
      => ComCall(3, this.p, Int64.Ptr, pcnsNow)
    SetTimer(cnsWhen, pvParam, pdwTimerId)
      => ComCall(4, this.p, Int64, cnsWhen, Struct.Ptr, pvParam, UInt32.Ptr, pdwTimerId)
    KillTimer(dwTimerId)
      => ComCall(5, this.p, UInt32, dwTimerId)
}
struct IWMIndexer extends IUnknown {
    static IID := "{6D7CDC71-9888-11D3-8EDC-00C04F6109CF}"
    StartIndexing(pwszURL, pCallback, pvContext)
      => ComCall(3, this.p, "Str", pwszURL, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
    Cancel()
      => ComCall(4, this.p)
}
struct IWMIndexer2 extends IWMIndexer {
    static IID := "{B70F1E42-6255-4DF0-A6B9-02B212D9E2BB}"
    Configure(wStreamNum, nIndexerType, pvInterval, pvIndexType)
      => ComCall(5, this.p, UInt16, wStreamNum, WMT_INDEXER_TYPE, nIndexerType, Struct.Ptr, pvInterval, Struct.Ptr, pvIndexType)
}
struct IWMLicenseBackup extends IUnknown {
    static IID := "{05E5AC9F-3FB6-4508-BB43-A4067BA1EBE8}"
    BackupLicenses(dwFlags, pCallback)
      => ComCall(3, this.p, UInt32, dwFlags, IWMStatusCallback, pCallback)
    CancelLicenseBackup()
      => ComCall(4, this.p)
}
struct IWMLicenseRestore extends IUnknown {
    static IID := "{C70B6334-A22E-4EFB-A245-15E65A004A13}"
    RestoreLicenses(dwFlags, pCallback)
      => ComCall(3, this.p, UInt32, dwFlags, IWMStatusCallback, pCallback)
    CancelLicenseRestore()
      => ComCall(4, this.p)
}
struct IWMBackupRestoreProps extends IUnknown {
    static IID := "{3C8E0DA6-996F-4FF3-A1AF-4838F9377E2E}"
    GetPropCount(pcProps)
      => ComCall(3, this.p, UInt16.Ptr, pcProps)
    GetPropByIndex(wIndex, pwszName, pType, pValue)
      => ComCall(4, this.p, UInt16, wIndex, PWSTR, pwszName, UInt16.Ptr, pwszName.Length, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    GetPropByName(pszName, pType, pValue)
      => ComCall(5, this.p, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt16.Ptr, pValue.Length)
    SetProp(pszName, Type, pValue)
      => ComCall(6, this.p, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt16, pValue.Length)
    RemoveProp(pcwszName)
      => ComCall(7, this.p, "Str", pcwszName)
    RemoveAllProps()
      => ComCall(8, this.p)
}
struct IWMCodecInfo extends IUnknown {
    static IID := "{A970F41E-34DE-4A98-B3BA-E4B3CA7528F0}"
    GetCodecInfoCount(guidType, pcCodecs)
      => ComCall(3, this.p, GUID.Ptr, guidType, UInt32.Ptr, pcCodecs)
    GetCodecFormatCount(guidType, dwCodecIndex, pcFormat)
      => ComCall(4, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, UInt32.Ptr, pcFormat)
    GetCodecFormat(guidType, dwCodecIndex, dwFormatIndex, ppIStreamConfig)
      => ComCall(5, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, UInt32, dwFormatIndex, IWMStreamConfig.Ptr, ppIStreamConfig)
}
struct IWMCodecInfo2 extends IWMCodecInfo {
    static IID := "{AA65E273-B686-4056-91EC-DD768D4DF710}"
    GetCodecName(guidType, dwCodecIndex, wszName)
      => ComCall(6, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, PWSTR, wszName, UInt32.Ptr, wszName.Length)
    GetCodecFormatDesc(guidType, dwCodecIndex, dwFormatIndex, ppIStreamConfig, wszDesc)
      => ComCall(7, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, UInt32, dwFormatIndex, IWMStreamConfig.Ptr, ppIStreamConfig, PWSTR, wszDesc, UInt32.Ptr, wszDesc.Length)
}
struct IWMCodecInfo3 extends IWMCodecInfo2 {
    static IID := "{7E51F487-4D93-4F98-8AB4-27D0565ADC51}"
    GetCodecFormatProp(guidType, dwCodecIndex, dwFormatIndex, pszName, pType, pValue)
      => ComCall(8, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, UInt32, dwFormatIndex, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
    GetCodecProp(guidType, dwCodecIndex, pszName, pType, pValue)
      => ComCall(9, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
    SetCodecEnumerationSetting(guidType, dwCodecIndex, pszName, Type, pValue)
      => ComCall(10, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, "Str", pszName, WMT_ATTR_DATATYPE, Type, UInt8.Ptr, pValue, UInt32, pValue.Length)
    GetCodecEnumerationSetting(guidType, dwCodecIndex, pszName, pType, pValue)
      => ComCall(11, this.p, GUID.Ptr, guidType, UInt32, dwCodecIndex, "Str", pszName, WMT_ATTR_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pValue.Length)
}
struct IWMLanguageList extends IUnknown {
    static IID := "{DF683F00-2D49-4D8E-92B7-FB19F6A0DC57}"
    GetLanguageCount(pwCount)
      => ComCall(3, this.p, UInt16.Ptr, pwCount)
    GetLanguageDetails(wIndex, pwszLanguageString)
      => ComCall(4, this.p, UInt16, wIndex, PWSTR, pwszLanguageString, UInt16.Ptr, pwszLanguageString.Length)
    AddLanguageByRFC1766String(pwszLanguageString, pwIndex)
      => ComCall(5, this.p, "Str", pwszLanguageString, UInt16.Ptr, pwIndex)
}
struct IWMWriterPushSink extends IWMWriterSink {
    static IID := "{DC10E6A5-072C-467D-BF57-6330A9DDE12A}"
    Connect(pwszURL, pwszTemplateURL, fAutoDestroy)
      => ComCall(8, this.p, "Str", pwszURL, "Str", pwszTemplateURL, BOOL, fAutoDestroy)
    Disconnect()
      => ComCall(9, this.p)
    EndSession()
      => ComCall(10, this.p)
}
struct IWMDeviceRegistration extends IUnknown {
    static IID := "{F6211F03-8D21-4E94-93E6-8510805F2D99}"
    RegisterDevice(dwRegisterType, pbCertificate, SerialNumber, ppDevice)
      => ComCall(3, this.p, UInt32, dwRegisterType, UInt8.Ptr, pbCertificate, UInt32, pbCertificate.Length, DRM_VAL16, SerialNumber, IWMRegisteredDevice.Ptr, ppDevice)
    UnregisterDevice(dwRegisterType, pbCertificate, SerialNumber)
      => ComCall(4, this.p, UInt32, dwRegisterType, UInt8.Ptr, pbCertificate, UInt32, pbCertificate.Length, DRM_VAL16, SerialNumber)
    GetRegistrationStats(dwRegisterType, pcRegisteredDevices)
      => ComCall(5, this.p, UInt32, dwRegisterType, UInt32.Ptr, pcRegisteredDevices)
    GetFirstRegisteredDevice(dwRegisterType, ppDevice)
      => ComCall(6, this.p, UInt32, dwRegisterType, IWMRegisteredDevice.Ptr, ppDevice)
    GetNextRegisteredDevice(ppDevice)
      => ComCall(7, this.p, IWMRegisteredDevice.Ptr, ppDevice)
    GetRegisteredDeviceByID(dwRegisterType, pbCertificate, SerialNumber, ppDevice)
      => ComCall(8, this.p, UInt32, dwRegisterType, UInt8.Ptr, pbCertificate, UInt32, pbCertificate.Length, DRM_VAL16, SerialNumber, IWMRegisteredDevice.Ptr, ppDevice)
}
struct IWMRegisteredDevice extends IUnknown {
    static IID := "{A4503BEC-5508-4148-97AC-BFA75760A70D}"
    GetDeviceSerialNumber(pSerialNumber)
      => ComCall(3, this.p, DRM_VAL16.Ptr, pSerialNumber)
    GetDeviceCertificate(ppCertificate)
      => ComCall(4, this.p, INSSBuffer.Ptr, ppCertificate)
    GetDeviceType(pdwType)
      => ComCall(5, this.p, UInt32.Ptr, pdwType)
    GetAttributeCount(pcAttributes)
      => ComCall(6, this.p, UInt32.Ptr, pcAttributes)
    GetAttributeByIndex(dwIndex, pbstrName, pbstrValue)
      => ComCall(7, this.p, UInt32, dwIndex, BSTR.Ptr, pbstrName, BSTR.Ptr, pbstrValue)
    GetAttributeByName(bstrName, pbstrValue)
      => ComCall(8, this.p, BSTR, bstrName, BSTR.Ptr, pbstrValue)
    SetAttributeByName(bstrName, bstrValue)
      => ComCall(9, this.p, BSTR, bstrName, BSTR, bstrValue)
    Approve(fApprove)
      => ComCall(10, this.p, BOOL, fApprove)
    IsValid(pfValid)
      => ComCall(11, this.p, BOOL.Ptr, pfValid)
    IsApproved(pfApproved)
      => ComCall(12, this.p, BOOL.Ptr, pfApproved)
    IsWmdrmCompliant(pfCompliant)
      => ComCall(13, this.p, BOOL.Ptr, pfCompliant)
    IsOpened(pfOpened)
      => ComCall(14, this.p, BOOL.Ptr, pfOpened)
    Open()
      => ComCall(15, this.p)
    Close()
      => ComCall(16, this.p)
}
struct IWMProximityDetection extends IUnknown {
    static IID := "{6A9FD8EE-B651-4BF0-B849-7D4ECE79A2B1}"
    StartDetection(pbRegistrationMsg, pbLocalAddress, dwExtraPortsAllowed, ppRegistrationResponseMsg, pCallback, pvContext)
      => ComCall(3, this.p, UInt8.Ptr, pbRegistrationMsg, UInt32, pbRegistrationMsg.Length, UInt8.Ptr, pbLocalAddress, UInt32, pbLocalAddress.Length, UInt32, dwExtraPortsAllowed, INSSBuffer.Ptr, ppRegistrationResponseMsg, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
}
struct IWMDRMMessageParser extends IUnknown {
    static IID := "{A73A0072-25A0-4C99-B4A5-EDE8101A6C39}"
    ParseRegistrationReqMsg(pbRegistrationReqMsg, ppDeviceCert, pDeviceSerialNumber)
      => ComCall(3, this.p, UInt8.Ptr, pbRegistrationReqMsg, UInt32, pbRegistrationReqMsg.Length, INSSBuffer.Ptr, ppDeviceCert, DRM_VAL16.Ptr, pDeviceSerialNumber)
    ParseLicenseRequestMsg(pbLicenseRequestMsg, ppDeviceCert, pDeviceSerialNumber, pbstrAction)
      => ComCall(4, this.p, UInt8.Ptr, pbLicenseRequestMsg, UInt32, pbLicenseRequestMsg.Length, INSSBuffer.Ptr, ppDeviceCert, DRM_VAL16.Ptr, pDeviceSerialNumber, BSTR.Ptr, pbstrAction)
}
struct IWMDRMTranscryptor extends IUnknown {
    static IID := "{69059850-6E6F-4BB2-806F-71863DDFC471}"
    Initialize(bstrFileName, pbLicenseRequestMsg, cbLicenseRequestMsg, ppLicenseResponseMsg, pCallback, pvContext)
      => ComCall(3, this.p, BSTR, bstrFileName, UInt8.Ptr, pbLicenseRequestMsg, UInt32, cbLicenseRequestMsg, INSSBuffer.Ptr, ppLicenseResponseMsg, IWMStatusCallback, pCallback, Struct.Ptr, pvContext)
    Seek(hnsTime)
      => ComCall(4, this.p, Int64, hnsTime)
    Read(pbData, pcbData)
      => ComCall(5, this.p, UInt8.Ptr, pbData, UInt32.Ptr, pcbData)
    Close()
      => ComCall(6, this.p)
}
struct IWMDRMTranscryptor2 extends IWMDRMTranscryptor {
    static IID := "{E0DA439F-D331-496A-BECE-18E5BAC5DD23}"
    SeekEx(cnsStartTime, cnsDuration, flRate, fIncludeFileHeader)
      => ComCall(7, this.p, Int64, cnsStartTime, Int64, cnsDuration, Float32, flRate, BOOL, fIncludeFileHeader)
    ZeroAdjustTimestamps(fEnable)
      => ComCall(8, this.p, BOOL, fEnable)
    GetSeekStartTime(pcnsTime)
      => ComCall(9, this.p, Int64.Ptr, pcnsTime)
    GetDuration(pcnsDuration)
      => ComCall(10, this.p, Int64.Ptr, pcnsDuration)
}
struct IWMDRMTranscryptionManager extends IUnknown {
    static IID := "{B1A887B2-A4F0-407A-B02E-EFBD23BBECDF}"
    CreateTranscryptor(ppTranscryptor)
      => ComCall(3, this.p, IWMDRMTranscryptor.Ptr, ppTranscryptor)
}
struct IWMWatermarkInfo extends IUnknown {
    static IID := "{6F497062-F2E2-4624-8EA7-9DD40D81FC8D}"
    GetWatermarkEntryCount(wmetType, pdwCount)
      => ComCall(3, this.p, WMT_WATERMARK_ENTRY_TYPE, wmetType, UInt32.Ptr, pdwCount)
    GetWatermarkEntry(wmetType, dwEntryNum, pEntry)
      => ComCall(4, this.p, WMT_WATERMARK_ENTRY_TYPE, wmetType, UInt32, dwEntryNum, WMT_WATERMARK_ENTRY.Ptr, pEntry)
}
struct IWMReaderAccelerator extends IUnknown {
    static IID := "{BDDC4D08-944D-4D52-A612-46C3FDA07DD4}"
    GetCodecInterface(dwOutputNum, riid, ppvCodecInterface)
      => ComCall(3, this.p, UInt32, dwOutputNum, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvCodecInterface)
    Notify(dwOutputNum, pSubtype)
      => ComCall(4, this.p, UInt32, dwOutputNum, WM_MEDIA_TYPE.Ptr, pSubtype)
}
struct IWMReaderTimecode extends IUnknown {
    static IID := "{F369E2F0-E081-4FE6-8450-B810B2F410D1}"
    GetTimecodeRangeCount(wStreamNum, pwRangeCount)
      => ComCall(3, this.p, UInt16, wStreamNum, UInt16.Ptr, pwRangeCount)
    GetTimecodeRangeBounds(wStreamNum, wRangeNum, pStartTimecode, pEndTimecode)
      => ComCall(4, this.p, UInt16, wStreamNum, UInt16, wRangeNum, UInt32.Ptr, pStartTimecode, UInt32.Ptr, pEndTimecode)
}
struct IWMAddressAccess extends IUnknown {
    static IID := "{BB3C6389-1633-4E92-AF14-9F3173BA39D0}"
    GetAccessEntryCount(aeType, pcEntries)
      => ComCall(3, this.p, WM_AETYPE, aeType, UInt32.Ptr, pcEntries)
    GetAccessEntry(aeType, dwEntryNum, pAddrAccessEntry)
      => ComCall(4, this.p, WM_AETYPE, aeType, UInt32, dwEntryNum, WM_ADDRESS_ACCESSENTRY.Ptr, pAddrAccessEntry)
    AddAccessEntry(aeType, pAddrAccessEntry)
      => ComCall(5, this.p, WM_AETYPE, aeType, WM_ADDRESS_ACCESSENTRY.Ptr, pAddrAccessEntry)
    RemoveAccessEntry(aeType, dwEntryNum)
      => ComCall(6, this.p, WM_AETYPE, aeType, UInt32, dwEntryNum)
}
struct IWMAddressAccess2 extends IWMAddressAccess {
    static IID := "{65A83FC2-3E98-4D4D-81B5-2A742886B33D}"
    GetAccessEntryEx(aeType, dwEntryNum, pbstrAddress, pbstrMask)
      => ComCall(7, this.p, WM_AETYPE, aeType, UInt32, dwEntryNum, BSTR.Ptr, pbstrAddress, BSTR.Ptr, pbstrMask)
    AddAccessEntryEx(aeType, bstrAddress, bstrMask)
      => ComCall(8, this.p, WM_AETYPE, aeType, BSTR, bstrAddress, BSTR, bstrMask)
}
struct IWMImageInfo extends IUnknown {
    static IID := "{9F0AA3B6-7267-4D89-88F2-BA915AA5C4C6}"
    GetImageCount(pcImages)
      => ComCall(3, this.p, UInt32.Ptr, pcImages)
    GetImage(wIndex, pwszMIMEType, pwszDescription, pImageType, pbImageData)
      => ComCall(4, this.p, UInt32, wIndex, UInt16.Ptr, pwszMIMEType.Length, PWSTR, pwszMIMEType, UInt16.Ptr, pwszDescription.Length, PWSTR, pwszDescription, UInt16.Ptr, pImageType, UInt32.Ptr, pbImageData.Length, UInt8.Ptr, pbImageData)
}
struct IWMLicenseRevocationAgent extends IUnknown {
    static IID := "{6967F2C9-4E26-4B57-8894-799880F7AC7B}"
    GetLRBChallenge(pMachineID, dwMachineIDLength, pChallenge, dwChallengeLength, pChallengeOutput, pdwChallengeOutputLength)
      => ComCall(3, this.p, UInt8.Ptr, pMachineID, UInt32, dwMachineIDLength, UInt8.Ptr, pChallenge, UInt32, dwChallengeLength, UInt8.Ptr, pChallengeOutput, UInt32.Ptr, pdwChallengeOutputLength)
    ProcessLRB(pSignedLRB, dwSignedLRBLength, pSignedACK, pdwSignedACKLength)
      => ComCall(4, this.p, UInt8.Ptr, pSignedLRB, UInt32, dwSignedLRBLength, UInt8.Ptr, pSignedACK, UInt32.Ptr, pdwSignedACKLength)
}
struct IWMAuthorizer extends IUnknown {
    static IID := "{D9B67D36-A9AD-4EB4-BAEF-DB284EF5504C}"
    GetCertCount(pcCerts)
      => ComCall(3, this.p, UInt32.Ptr, pcCerts)
    GetCert(dwIndex, ppbCertData)
      => ComCall(4, this.p, UInt32, dwIndex, UInt8.Ptr.Ptr, ppbCertData)
    GetSharedData(dwCertIndex, pbSharedData, pbCert, ppbSharedData)
      => ComCall(5, this.p, UInt32, dwCertIndex, UInt8.Ptr, pbSharedData, UInt8.Ptr, pbCert, UInt8.Ptr.Ptr, ppbSharedData)
}
struct IWMSecureChannel extends IWMAuthorizer {
    static IID := "{2720598A-D0F2-4189-BD10-91C46EF0936F}"
    WMSC_AddCertificate(pCert)
      => ComCall(6, this.p, IWMAuthorizer, pCert)
    WMSC_AddSignature(pbCertSig, cbCertSig)
      => ComCall(7, this.p, UInt8.Ptr, pbCertSig, UInt32, cbCertSig)
    WMSC_Connect(pOtherSide)
      => ComCall(8, this.p, IWMSecureChannel, pOtherSide)
    WMSC_IsConnected(pfIsConnected)
      => ComCall(9, this.p, BOOL.Ptr, pfIsConnected)
    WMSC_Disconnect()
      => ComCall(10, this.p)
    WMSC_GetValidCertificate(ppbCertificate, pdwSignature)
      => ComCall(11, this.p, UInt8.Ptr.Ptr, ppbCertificate, UInt32.Ptr, pdwSignature)
    WMSC_Encrypt(pbData, cbData)
      => ComCall(12, this.p, UInt8.Ptr, pbData, UInt32, cbData)
    WMSC_Decrypt(pbData, cbData)
      => ComCall(13, this.p, UInt8.Ptr, pbData, UInt32, cbData)
    WMSC_Lock()
      => ComCall(14, this.p)
    WMSC_Unlock()
      => ComCall(15, this.p)
    WMSC_SetSharedData(dwCertIndex, pbSharedData)
      => ComCall(16, this.p, UInt32, dwCertIndex, UInt8.Ptr, pbSharedData)
}
struct IWMGetSecureChannel extends IUnknown {
    static IID := "{94BC0598-C3D2-11D3-BEDF-00C04F612986}"
    GetPeerSecureChannelInterface(ppPeer)
      => ComCall(3, this.p, IWMSecureChannel.Ptr, ppPeer)
}
struct INSNetSourceCreator extends IUnknown {
    static IID := "{0C0E4080-9081-11D2-BEEC-0060082F2054}"
    Initialize()
      => ComCall(3, this.p)
    CreateNetSource(pszStreamName, pMonitor, pData, pUserContext, pCallback, qwContext)
      => ComCall(4, this.p, "Str", pszStreamName, IUnknown, pMonitor, UInt8.Ptr, pData, IUnknown, pUserContext, IUnknown, pCallback, Int64, qwContext)
    GetNetSourceProperties(pszStreamName, ppPropertiesNode)
      => ComCall(5, this.p, "Str", pszStreamName, IUnknown.Ptr, ppPropertiesNode)
    GetNetSourceSharedNamespace(ppSharedNamespace)
      => ComCall(6, this.p, IUnknown.Ptr, ppSharedNamespace)
    GetNetSourceAdminInterface(pszStreamName, pVal)
      => ComCall(7, this.p, "Str", pszStreamName, VARIANT.Ptr, pVal)
    GetNumProtocolsSupported(pcProtocols)
      => ComCall(8, this.p, UInt32.Ptr, pcProtocols)
    GetProtocolName(dwProtocolNum, pwszProtocolName, pcchProtocolName)
      => ComCall(9, this.p, UInt32, dwProtocolNum, PWSTR, pwszProtocolName, UInt16.Ptr, pcchProtocolName)
    Shutdown()
      => ComCall(10, this.p)
}
struct IWMPlayerTimestampHook extends IUnknown {
    static IID := "{28580DDA-D98E-48D0-B7AE-69E473A02825}"
    MapTimestamp(rtIn, prtOut)
      => ComCall(3, this.p, Int64, rtIn, Int64.Ptr, prtOut)
}
struct NETSOURCE_URLCREDPOLICY_SETTINGS extends Int32 {
    static NETSOURCE_URLCREDPOLICY_SETTING_SILENTLOGONOK := 0
    static NETSOURCE_URLCREDPOLICY_SETTING_MUSTPROMPTUSER := 1
    static NETSOURCE_URLCREDPOLICY_SETTING_ANONYMOUSONLY := 2
}
struct IWMSInternalAdminNetSource extends IUnknown {
    static IID := "{8BB23E5F-D127-4AFB-8D02-AE5B66D54C78}"
    Initialize(pSharedNamespace, pNamespaceNode, pNetSourceCreator, fEmbeddedInServer)
      => ComCall(3, this.p, IUnknown, pSharedNamespace, IUnknown, pNamespaceNode, INSNetSourceCreator, pNetSourceCreator, BOOL, fEmbeddedInServer)
    GetNetSourceCreator(ppNetSourceCreator)
      => ComCall(4, this.p, INSNetSourceCreator.Ptr, ppNetSourceCreator)
    SetCredentials(bstrRealm, bstrName, bstrPassword, fPersist, fConfirmedGood)
      => ComCall(5, this.p, BSTR, bstrRealm, BSTR, bstrName, BSTR, bstrPassword, BOOL, fPersist, BOOL, fConfirmedGood)
    GetCredentials(bstrRealm, pbstrName, pbstrPassword, pfConfirmedGood)
      => ComCall(6, this.p, BSTR, bstrRealm, BSTR.Ptr, pbstrName, BSTR.Ptr, pbstrPassword, BOOL.Ptr, pfConfirmedGood)
    DeleteCredentials(bstrRealm)
      => ComCall(7, this.p, BSTR, bstrRealm)
    GetCredentialFlags(lpdwFlags)
      => ComCall(8, this.p, UInt32.Ptr, lpdwFlags)
    SetCredentialFlags(dwFlags)
      => ComCall(9, this.p, UInt32, dwFlags)
    FindProxyForURL(bstrProtocol, bstrHost, pfProxyEnabled, pbstrProxyServer, pdwProxyPort, pdwProxyContext)
      => ComCall(10, this.p, BSTR, bstrProtocol, BSTR, bstrHost, BOOL.Ptr, pfProxyEnabled, BSTR.Ptr, pbstrProxyServer, UInt32.Ptr, pdwProxyPort, UInt32.Ptr, pdwProxyContext)
    RegisterProxyFailure(hrParam, dwProxyContext)
      => ComCall(11, this.p, HRESULT, hrParam, UInt32, dwProxyContext)
    ShutdownProxyContext(dwProxyContext)
      => ComCall(12, this.p, UInt32, dwProxyContext)
    IsUsingIE(dwProxyContext, pfIsUsingIE)
      => ComCall(13, this.p, UInt32, dwProxyContext, BOOL.Ptr, pfIsUsingIE)
}
struct IWMSInternalAdminNetSource2 extends IUnknown {
    static IID := "{E74D58C3-CF77-4B51-AF17-744687C43EAE}"
    SetCredentialsEx(bstrRealm, bstrUrl, fProxy, bstrName, bstrPassword, fPersist, fConfirmedGood)
      => ComCall(3, this.p, BSTR, bstrRealm, BSTR, bstrUrl, BOOL, fProxy, BSTR, bstrName, BSTR, bstrPassword, BOOL, fPersist, BOOL, fConfirmedGood)
    GetCredentialsEx(bstrRealm, bstrUrl, fProxy, pdwUrlPolicy, pbstrName, pbstrPassword, pfConfirmedGood)
      => ComCall(4, this.p, BSTR, bstrRealm, BSTR, bstrUrl, BOOL, fProxy, NETSOURCE_URLCREDPOLICY_SETTINGS.Ptr, pdwUrlPolicy, BSTR.Ptr, pbstrName, BSTR.Ptr, pbstrPassword, BOOL.Ptr, pfConfirmedGood)
    DeleteCredentialsEx(bstrRealm, bstrUrl, fProxy)
      => ComCall(5, this.p, BSTR, bstrRealm, BSTR, bstrUrl, BOOL, fProxy)
    FindProxyForURLEx(bstrProtocol, bstrHost, bstrUrl, pfProxyEnabled, pbstrProxyServer, pdwProxyPort, pdwProxyContext)
      => ComCall(6, this.p, BSTR, bstrProtocol, BSTR, bstrHost, BSTR, bstrUrl, BOOL.Ptr, pfProxyEnabled, BSTR.Ptr, pbstrProxyServer, UInt32.Ptr, pdwProxyPort, UInt32.Ptr, pdwProxyContext)
}
struct IWMSInternalAdminNetSource3 extends IWMSInternalAdminNetSource2 {
    static IID := "{6B63D08E-4590-44AF-9EB3-57FF1E73BF80}"
    GetNetSourceCreator2(ppNetSourceCreator)
      => ComCall(7, this.p, IUnknown.Ptr, ppNetSourceCreator)
    FindProxyForURLEx2(bstrProtocol, bstrHost, bstrUrl, pfProxyEnabled, pbstrProxyServer, pdwProxyPort, pqwProxyContext)
      => ComCall(8, this.p, BSTR, bstrProtocol, BSTR, bstrHost, BSTR, bstrUrl, BOOL.Ptr, pfProxyEnabled, BSTR.Ptr, pbstrProxyServer, UInt32.Ptr, pdwProxyPort, Int64.Ptr, pqwProxyContext)
    RegisterProxyFailure2(hrParam, qwProxyContext)
      => ComCall(9, this.p, HRESULT, hrParam, Int64, qwProxyContext)
    ShutdownProxyContext2(qwProxyContext)
      => ComCall(10, this.p, Int64, qwProxyContext)
    IsUsingIE2(qwProxyContext, pfIsUsingIE)
      => ComCall(11, this.p, Int64, qwProxyContext, BOOL.Ptr, pfIsUsingIE)
    SetCredentialsEx2(bstrRealm, bstrUrl, fProxy, bstrName, bstrPassword, fPersist, fConfirmedGood, fClearTextAuthentication)
      => ComCall(12, this.p, BSTR, bstrRealm, BSTR, bstrUrl, BOOL, fProxy, BSTR, bstrName, BSTR, bstrPassword, BOOL, fPersist, BOOL, fConfirmedGood, BOOL, fClearTextAuthentication)
    GetCredentialsEx2(bstrRealm, bstrUrl, fProxy, fClearTextAuthentication, pdwUrlPolicy, pbstrName, pbstrPassword, pfConfirmedGood)
      => ComCall(13, this.p, BSTR, bstrRealm, BSTR, bstrUrl, BOOL, fProxy, BOOL, fClearTextAuthentication, NETSOURCE_URLCREDPOLICY_SETTINGS.Ptr, pdwUrlPolicy, BSTR.Ptr, pbstrName, BSTR.Ptr, pbstrPassword, BOOL.Ptr, pfConfirmedGood)
}
