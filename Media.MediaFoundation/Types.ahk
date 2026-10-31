#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.Properties\Types.ahk" {DEVPROPTYPE}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, COLORREF, DEVPROPKEY, FILETIME, HANDLE, HRESULT, HWND, POINT, PSTR, PWSTR, RECT, SIZE, VARIANT_BOOL}
#Import "..\Graphics.Direct3D12\Types.ahk" {D3D12_BARRIER_GROUP, D3D12_COMMAND_LIST_SUPPORT_FLAGS, D3D12_DISCARD_REGION, D3D12_PREDICATION_OP, D3D12_QUERY_TYPE, D3D12_RESOURCE_BARRIER, D3D12_WRITEBUFFERIMMEDIATE_MODE, D3D12_WRITEBUFFERIMMEDIATE_PARAMETER, ID3D12CommandAllocator, ID3D12CommandList, ID3D12CommandQueue, ID3D12Fence, ID3D12Pageable, ID3D12ProtectedResourceSession, ID3D12QueryHeap, ID3D12Resource}
#Import "..\Graphics.Direct3D9\Types.ahk" {D3DAUTHENTICATEDCHANNELTYPE, D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT, D3DDEVTYPE, D3DDISPLAYMODEEX, D3DDISPLAYROTATION, D3DENCRYPTED_BLOCK_INFO, D3DFORMAT, D3DPOOL, IDirect3DDevice9, IDirect3DDevice9Ex, IDirect3DSurface9}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_RATIONAL}
#Import "..\Graphics.Gdi\Types.ahk" {BITMAPINFOHEADER, HDC}
#Import "..\Media.Audio\Types.ahk" {AudioObjectType, ISpatialAudioMetadataItems, WAVEFORMATEX}
#Import "..\Media.DxMediaObjects\Types.ahk" {DMO_MEDIA_TYPE, IMediaBuffer}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\System.WinRT\Types.ahk" {IInspectable}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct MEDIA_EVENT_GENERATOR_GET_EVENT_FLAGS extends UInt32 {
    static MF_EVENT_FLAG_NONE := 0
    static MF_EVENT_FLAG_NO_WAIT := 1
}
struct MPEG2VIDEOINFO_FLAGS extends UInt32 {
    static AMMPEG2_DoPanScan := 1
    static AMMPEG2_DVDLine21Field1 := 2
    static AMMPEG2_DVDLine21Field2 := 4
    static AMMPEG2_SourceIsLetterboxed := 8
    static AMMPEG2_FilmCameraMode := 16
    static AMMPEG2_LetterboxAnalogOut := 32
    static AMMPEG2_DSS_UserData := 64
    static AMMPEG2_DVB_UserData := 128
    static AMMPEG2_27MhzTimebase := 256
    static AMMPEG2_WidescreenAnalogOut := 512
}
struct MF_Plugin_Type extends Int32 {
    static MF_Plugin_Type_MFT := 0
    static MF_Plugin_Type_MediaSource := 1
    static MF_Plugin_Type_MFT_MatchOutputType := 2
    static MF_Plugin_Type_Other := -1
}
struct AM_MEDIA_TYPE {
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
struct CodecAPIEventData {
    guid : GUID
    dataLength : UInt32
    reserved : UInt32[3]
}
struct ICodecAPI extends IUnknown {
    static IID := "{901DB4C7-31CE-41A2-85DC-8FA0BF41B8DA}"
    IsSupported(Api)
      => ComCall(3, this.p, GUID.Ptr, Api)
    IsModifiable(Api)
      => ComCall(4, this.p, GUID.Ptr, Api)
    GetParameterRange(Api, ValueMin, ValueMax, SteppingDelta)
      => ComCall(5, this.p, GUID.Ptr, Api, VARIANT.Ptr, ValueMin, VARIANT.Ptr, ValueMax, VARIANT.Ptr, SteppingDelta)
    GetParameterValues(Api, Values, ValuesCount)
      => ComCall(6, this.p, GUID.Ptr, Api, VARIANT.Ptr.Ptr, Values, UInt32.Ptr, ValuesCount)
    GetDefaultValue(Api, Value)
      => ComCall(7, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
    GetValue(Api, Value)
      => ComCall(8, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
    SetValue(Api, Value)
      => ComCall(9, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
    RegisterForEvent(Api, userData)
      => ComCall(10, this.p, GUID.Ptr, Api, IntPtr, userData)
    UnregisterForEvent(Api)
      => ComCall(11, this.p, GUID.Ptr, Api)
    SetAllDefaults()
      => ComCall(12, this.p)
    SetValueWithNotify(Api, Value, ChangedParam, ChangedParamCount)
      => ComCall(13, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value, GUID.Ptr.Ptr, ChangedParam, UInt32.Ptr, ChangedParamCount)
    SetAllDefaultsWithNotify(ChangedParam, ChangedParamCount)
      => ComCall(14, this.p, GUID.Ptr.Ptr, ChangedParam, UInt32.Ptr, ChangedParamCount)
    GetAllSettings(__MIDL__ICodecAPI0000)
      => ComCall(15, this.p, IStream, __MIDL__ICodecAPI0000)
    SetAllSettings(__MIDL__ICodecAPI0001)
      => ComCall(16, this.p, IStream, __MIDL__ICodecAPI0001)
    SetAllSettingsWithNotify(__MIDL__ICodecAPI0002, ChangedParam, ChangedParamCount)
      => ComCall(17, this.p, IStream, __MIDL__ICodecAPI0002, GUID.Ptr.Ptr, ChangedParam, UInt32.Ptr, ChangedParamCount)
}
struct VIDEOINFOHEADER {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    bmiHeader : BITMAPINFOHEADER
}
struct MPEG1VIDEOINFO {
    hdr : VIDEOINFOHEADER
    dwStartTimeCode : UInt32
    cbSequenceHeader : UInt32
    bSequenceHeader : UInt8[1]
}
struct VIDEOINFOHEADER2 {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    dwInterlaceFlags : UInt32
    dwCopyProtectFlags : UInt32
    dwPictAspectRatioX : UInt32
    dwPictAspectRatioY : UInt32
    Anonymous : this._Anonymous_e__Union
    dwReserved2 : UInt32
    bmiHeader : BITMAPINFOHEADER
    struct _Anonymous_e__Union {
        union {
            dwControlFlags : UInt32
            dwReserved1 : UInt32
        }
    }
}
struct MPEG2VIDEOINFO {
    hdr : VIDEOINFOHEADER2
    dwStartTimeCode : UInt32
    cbSequenceHeader : UInt32
    dwProfile : UInt32
    dwLevel : UInt32
    dwFlags : MPEG2VIDEOINFO_FLAGS
    dwSequenceHeader : UInt32[1]
}
struct D3DCONTENTPROTECTIONCAPS {
    Caps : UInt32
    KeyExchangeType : GUID
    BufferAlignmentStart : UInt32
    BlockAlignmentSize : UInt32
    ProtectedMemorySize : Int64
}
struct DXVA_VideoSample2 {
    Size : UInt32
    Reserved : UInt32
    rtStart : Int64
    rtEnd : Int64
    SampleFormat : UInt32
    SampleFlags : UInt32
    lpDDSSrcSurface : Struct.Ptr
    rcSrc : RECT
    rcDst : RECT
    Palette : DXVA_AYUVsample2[16]
}
struct DXVA_VideoSample32 {
    rtStart : Int64
    rtEnd : Int64
    SampleFormat : UInt32
    SampleFlags : UInt32
    lpDDSSrcSurface : UInt32
    rcSrc : RECT
    rcDst : RECT
    Palette : DXVA_AYUVsample2[16]
}
struct DXVA_DeinterlaceBltEx32 {
    Size : UInt32
    BackgroundColor : DXVA_AYUVsample2
    rcTarget : RECT
    rtTarget : Int64
    NumSourceSurfaces : UInt32
    Alpha : Float32
    Source : DXVA_VideoSample32[32]
    DestinationFormat : UInt32
    DestinationFlags : UInt32
}
struct D3DOVERLAYCAPS {
    Caps : UInt32
    MaxOverlayDisplayWidth : UInt32
    MaxOverlayDisplayHeight : UInt32
}
struct IDirect3D9ExOverlayExtension extends IUnknown {
    static IID := "{187AEB13-AAF5-4C59-876D-E059088C0DF8}"
    CheckDeviceOverlayType(Adapter, DevType, OverlayWidth, OverlayHeight, OverlayFormat, pDisplayMode, DisplayRotation, pOverlayCaps)
      => ComCall(3, this.p, UInt32, Adapter, D3DDEVTYPE, DevType, UInt32, OverlayWidth, UInt32, OverlayHeight, D3DFORMAT, OverlayFormat, D3DDISPLAYMODEEX.Ptr, pDisplayMode, D3DDISPLAYROTATION, DisplayRotation, D3DOVERLAYCAPS.Ptr, pOverlayCaps)
}
struct IDirect3DDevice9Video extends IUnknown {
    static IID := "{26DC4561-A1EE-4AE7-96DA-118A36C0EC95}"
    GetContentProtectionCaps(pCryptoType, pDecodeProfile, pCaps)
      => ComCall(3, this.p, GUID.Ptr, pCryptoType, GUID.Ptr, pDecodeProfile, D3DCONTENTPROTECTIONCAPS.Ptr, pCaps)
    CreateAuthenticatedChannel(ChannelType, ppAuthenticatedChannel, pChannelHandle)
      => ComCall(4, this.p, D3DAUTHENTICATEDCHANNELTYPE, ChannelType, IDirect3DAuthenticatedChannel9.Ptr, ppAuthenticatedChannel, HANDLE.Ptr, pChannelHandle)
    CreateCryptoSession(pCryptoType, pDecodeProfile, ppCryptoSession, pCryptoHandle)
      => ComCall(5, this.p, GUID.Ptr, pCryptoType, GUID.Ptr, pDecodeProfile, IDirect3DCryptoSession9.Ptr, ppCryptoSession, HANDLE.Ptr, pCryptoHandle)
}
struct IDirect3DAuthenticatedChannel9 extends IUnknown {
    static IID := "{FF24BEEE-DA21-4BEB-98B5-D2F899F98AF9}"
    GetCertificateSize(pCertificateSize)
      => ComCall(3, this.p, UInt32.Ptr, pCertificateSize)
    GetCertificate(CertifacteSize, ppCertificate)
      => ComCall(4, this.p, UInt32, CertifacteSize, UInt8.Ptr, ppCertificate)
    NegotiateKeyExchange(DataSize, pData)
      => ComCall(5, this.p, UInt32, DataSize, Struct.Ptr, pData)
    Query(InputSize, pInput, OutputSize, pOutput)
      => ComCall(6, this.p, UInt32, InputSize, Struct.Ptr, pInput, UInt32, OutputSize, Struct.Ptr, pOutput)
    Configure(InputSize, pInput, pOutput)
      => ComCall(7, this.p, UInt32, InputSize, Struct.Ptr, pInput, D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT.Ptr, pOutput)
}
struct IDirect3DCryptoSession9 extends IUnknown {
    static IID := "{FA0AB799-7A9C-48CA-8C5B-237E71A54434}"
    GetCertificateSize(pCertificateSize)
      => ComCall(3, this.p, UInt32.Ptr, pCertificateSize)
    GetCertificate(CertifacteSize, ppCertificate)
      => ComCall(4, this.p, UInt32, CertifacteSize, UInt8.Ptr, ppCertificate)
    NegotiateKeyExchange(DataSize, pData)
      => ComCall(5, this.p, UInt32, DataSize, Struct.Ptr, pData)
    EncryptionBlt(pSrcSurface, pDstSurface, DstSurfaceSize, pIV)
      => ComCall(6, this.p, IDirect3DSurface9, pSrcSurface, IDirect3DSurface9, pDstSurface, UInt32, DstSurfaceSize, Struct.Ptr, pIV)
    DecryptionBlt(pSrcSurface, pDstSurface, SrcSurfaceSize, pEncryptedBlockInfo, pContentKey, pIV)
      => ComCall(7, this.p, IDirect3DSurface9, pSrcSurface, IDirect3DSurface9, pDstSurface, UInt32, SrcSurfaceSize, D3DENCRYPTED_BLOCK_INFO.Ptr, pEncryptedBlockInfo, Struct.Ptr, pContentKey, Struct.Ptr, pIV)
    GetSurfacePitch(pSrcSurface, pSurfacePitch)
      => ComCall(8, this.p, IDirect3DSurface9, pSrcSurface, UInt32.Ptr, pSurfacePitch)
    StartSessionKeyRefresh(pRandomNumber, RandomNumberSize)
      => ComCall(9, this.p, Struct.Ptr, pRandomNumber, UInt32, RandomNumberSize)
    FinishSessionKeyRefresh()
      => ComCall(10, this.p)
    GetEncryptionBltKey(pReadbackKey, KeySize)
      => ComCall(11, this.p, Struct.Ptr, pReadbackKey, UInt32, KeySize)
}
struct D3D12_VIDEO_FIELD_TYPE extends Int32 {
    static D3D12_VIDEO_FIELD_TYPE_NONE := 0
    static D3D12_VIDEO_FIELD_TYPE_INTERLACED_TOP_FIELD_FIRST := 1
    static D3D12_VIDEO_FIELD_TYPE_INTERLACED_BOTTOM_FIELD_FIRST := 2
}
struct D3D12_VIDEO_FRAME_STEREO_FORMAT extends Int32 {
    static D3D12_VIDEO_FRAME_STEREO_FORMAT_NONE := 0
    static D3D12_VIDEO_FRAME_STEREO_FORMAT_MONO := 1
    static D3D12_VIDEO_FRAME_STEREO_FORMAT_HORIZONTAL := 2
    static D3D12_VIDEO_FRAME_STEREO_FORMAT_VERTICAL := 3
    static D3D12_VIDEO_FRAME_STEREO_FORMAT_SEPARATE := 4
}
struct D3D12_VIDEO_FORMAT {
    Format : DXGI_FORMAT
    ColorSpace : DXGI_COLOR_SPACE_TYPE
}
struct D3D12_VIDEO_SAMPLE {
    Width : UInt32
    Height : UInt32
    Format : D3D12_VIDEO_FORMAT
}
struct D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE extends Int32 {
    static D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_NONE := 0
    static D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_FIELD_BASED := 1
}
struct D3D12_FEATURE_VIDEO extends Int32 {
    static D3D12_FEATURE_VIDEO_DECODE_SUPPORT := 0
    static D3D12_FEATURE_VIDEO_DECODE_PROFILES := 1
    static D3D12_FEATURE_VIDEO_DECODE_FORMATS := 2
    static D3D12_FEATURE_VIDEO_DECODE_CONVERSION_SUPPORT := 3
    static D3D12_FEATURE_VIDEO_PROCESS_SUPPORT := 5
    static D3D12_FEATURE_VIDEO_PROCESS_MAX_INPUT_STREAMS := 6
    static D3D12_FEATURE_VIDEO_PROCESS_REFERENCE_INFO := 7
    static D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE := 8
    static D3D12_FEATURE_VIDEO_PROCESSOR_SIZE := 9
    static D3D12_FEATURE_VIDEO_DECODE_PROFILE_COUNT := 10
    static D3D12_FEATURE_VIDEO_DECODE_FORMAT_COUNT := 11
    static D3D12_FEATURE_VIDEO_ARCHITECTURE := 17
    static D3D12_FEATURE_VIDEO_DECODE_HISTOGRAM := 18
    static D3D12_FEATURE_VIDEO_FEATURE_AREA_SUPPORT := 19
    static D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR := 20
    static D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_SIZE := 21
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_COUNT := 22
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMANDS := 23
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETER_COUNT := 24
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_PARAMETERS := 25
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SUPPORT := 26
    static D3D12_FEATURE_VIDEO_EXTENSION_COMMAND_SIZE := 27
    static D3D12_FEATURE_VIDEO_DECODE_PROTECTED_RESOURCES := 28
    static D3D12_FEATURE_VIDEO_PROCESS_PROTECTED_RESOURCES := 29
    static D3D12_FEATURE_VIDEO_MOTION_ESTIMATOR_PROTECTED_RESOURCES := 30
    static D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE1 := 31
    static D3D12_FEATURE_VIDEO_PROCESSOR_SIZE1 := 32
    static D3D12_FEATURE_VIDEO_ENCODER_CODEC := 33
    static D3D12_FEATURE_VIDEO_ENCODER_PROFILE_LEVEL := 34
    static D3D12_FEATURE_VIDEO_ENCODER_OUTPUT_RESOLUTION_RATIOS_COUNT := 35
    static D3D12_FEATURE_VIDEO_ENCODER_OUTPUT_RESOLUTION := 36
    static D3D12_FEATURE_VIDEO_ENCODER_INPUT_FORMAT := 37
    static D3D12_FEATURE_VIDEO_ENCODER_RATE_CONTROL_MODE := 38
    static D3D12_FEATURE_VIDEO_ENCODER_INTRA_REFRESH_MODE := 39
    static D3D12_FEATURE_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE := 40
    static D3D12_FEATURE_VIDEO_ENCODER_HEAP_SIZE := 41
    static D3D12_FEATURE_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT := 42
    static D3D12_FEATURE_VIDEO_ENCODER_SUPPORT := 43
    static D3D12_FEATURE_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT := 44
    static D3D12_FEATURE_VIDEO_ENCODER_RESOURCE_REQUIREMENTS := 45
    static D3D12_FEATURE_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_CONFIG := 46
    static D3D12_FEATURE_VIDEO_ENCODER_SUPPORT1 := 47
    static D3D12_FEATURE_VIDEO_ENCODER_RESOURCE_REQUIREMENTS1 := 48
    static D3D12_FEATURE_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT := 49
    static D3D12_FEATURE_VIDEO_ENCODER_QPMAP_INPUT := 50
    static D3D12_FEATURE_VIDEO_ENCODER_DIRTY_REGIONS := 51
    static D3D12_FEATURE_VIDEO_ENCODER_MOTION_SEARCH := 52
    static D3D12_FEATURE_VIDEO_ENCODER_SUPPORT2 := 55
    static D3D12_FEATURE_VIDEO_ENCODER_HEAP_SIZE1 := 56
    static D3D12_FEATURE_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS := 57
}
struct D3D12_BITSTREAM_ENCRYPTION_TYPE extends Int32 {
    static D3D12_BITSTREAM_ENCRYPTION_TYPE_NONE := 0
}
struct D3D12_VIDEO_DECODE_CONFIGURATION {
    DecodeProfile : GUID
    BitstreamEncryption : D3D12_BITSTREAM_ENCRYPTION_TYPE
    InterlaceType : D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE
}
struct D3D12_VIDEO_DECODER_DESC {
    NodeMask : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
}
struct D3D12_VIDEO_DECODER_HEAP_DESC {
    NodeMask : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    DecodeWidth : UInt32
    DecodeHeight : UInt32
    Format : DXGI_FORMAT
    FrameRate : DXGI_RATIONAL
    BitRate : UInt32
    MaxDecodePictureBufferCount : UInt32
}
struct D3D12_VIDEO_SIZE_RANGE {
    MaxWidth : UInt32
    MaxHeight : UInt32
    MinWidth : UInt32
    MinHeight : UInt32
}
struct D3D12_VIDEO_PROCESS_FILTER extends Int32 {
    static D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS := 0
    static D3D12_VIDEO_PROCESS_FILTER_CONTRAST := 1
    static D3D12_VIDEO_PROCESS_FILTER_HUE := 2
    static D3D12_VIDEO_PROCESS_FILTER_SATURATION := 3
    static D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION := 4
    static D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT := 5
    static D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING := 6
    static D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT := 7
}
struct D3D12_VIDEO_PROCESS_FILTER_FLAGS extends Int32 {
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_BRIGHTNESS := 1
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_CONTRAST := 2
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_HUE := 4
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_SATURATION := 8
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_NOISE_REDUCTION := 16
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_EDGE_ENHANCEMENT := 32
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_ANAMORPHIC_SCALING := 64
    static D3D12_VIDEO_PROCESS_FILTER_FLAG_STEREO_ADJUSTMENT := 128
}
struct D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS extends UInt32 {
    static D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_BOB := 1
    static D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_CUSTOM := 2147483648
}
struct D3D12_VIDEO_PROCESS_ALPHA_BLENDING {
    Enable : BOOL
    Alpha : Float32
}
struct D3D12_VIDEO_PROCESS_LUMA_KEY {
    Enable : BOOL
    Lower : Float32
    Upper : Float32
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC {
    Format : DXGI_FORMAT
    ColorSpace : DXGI_COLOR_SPACE_TYPE
    SourceAspectRatio : DXGI_RATIONAL
    DestinationAspectRatio : DXGI_RATIONAL
    FrameRate : DXGI_RATIONAL
    SourceSizeRange : D3D12_VIDEO_SIZE_RANGE
    DestinationSizeRange : D3D12_VIDEO_SIZE_RANGE
    EnableOrientation : BOOL
    FilterFlags : D3D12_VIDEO_PROCESS_FILTER_FLAGS
    StereoFormat : D3D12_VIDEO_FRAME_STEREO_FORMAT
    FieldType : D3D12_VIDEO_FIELD_TYPE
    DeinterlaceMode : D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS
    EnableAlphaBlending : BOOL
    LumaKey : D3D12_VIDEO_PROCESS_LUMA_KEY
    NumPastFrames : UInt32
    NumFutureFrames : UInt32
    EnableAutoProcessing : BOOL
}
struct D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE extends Int32 {
    static D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_OPAQUE := 0
    static D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_BACKGROUND := 1
    static D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_DESTINATION := 2
    static D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_SOURCE_STREAM := 3
}
struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC {
    Format : DXGI_FORMAT
    ColorSpace : DXGI_COLOR_SPACE_TYPE
    AlphaFillMode : D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE
    AlphaFillModeSourceStreamIndex : UInt32
    BackgroundColor : Float32[4]
    FrameRate : DXGI_RATIONAL
    EnableStereo : BOOL
}
struct ID3D12VideoDecoderHeap extends ID3D12Pageable {
    static IID := "{0946B7C9-EBF6-4047-BB73-8683E27DBB1F}"
    GetDesc()
      => ComCall(8, this.p, D3D12_VIDEO_DECODER_HEAP_DESC)
}
struct ID3D12VideoDevice extends IUnknown {
    static IID := "{1F052807-0B46-4ACC-8A89-364F793718A4}"
    CheckFeatureSupport(FeatureVideo, pFeatureSupportData)
      => ComCall(3, this.p, D3D12_FEATURE_VIDEO, FeatureVideo, Struct.Ptr, pFeatureSupportData, UInt32, pFeatureSupportData.Size)
    CreateVideoDecoder(pDesc, riid, ppVideoDecoder)
      => ComCall(4, this.p, D3D12_VIDEO_DECODER_DESC.Ptr, pDesc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoDecoder)
    CreateVideoDecoderHeap(pVideoDecoderHeapDesc, riid, ppVideoDecoderHeap)
      => ComCall(5, this.p, D3D12_VIDEO_DECODER_HEAP_DESC.Ptr, pVideoDecoderHeapDesc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoDecoderHeap)
    CreateVideoProcessor(NodeMask, pOutputStreamDesc, pInputStreamDescs, riid, ppVideoProcessor)
      => ComCall(6, this.p, UInt32, NodeMask, D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC.Ptr, pOutputStreamDesc, UInt32, pInputStreamDescs.Length, D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC.Ptr, pInputStreamDescs, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoProcessor)
}
struct ID3D12VideoDecoder extends ID3D12Pageable {
    static IID := "{C59B6BDC-7720-4074-A136-17A156037470}"
    GetDesc()
      => ComCall(8, this.p, D3D12_VIDEO_DECODER_DESC)
}
struct D3D12_VIDEO_DECODE_TIER extends Int32 {
    static D3D12_VIDEO_DECODE_TIER_NOT_SUPPORTED := 0
    static D3D12_VIDEO_DECODE_TIER_1 := 1
    static D3D12_VIDEO_DECODE_TIER_2 := 2
    static D3D12_VIDEO_DECODE_TIER_3 := 3
}
struct D3D12_VIDEO_DECODE_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_DECODE_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_DECODE_SUPPORT_FLAG_SUPPORTED := 1
}
struct D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS extends Int32 {
    static D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_NONE := 0
    static D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_HEIGHT_ALIGNMENT_MULTIPLE_32_REQUIRED := 1
    static D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_POST_PROCESSING_SUPPORTED := 2
    static D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED := 4
    static D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_ALLOW_RESOLUTION_CHANGE_ON_NON_KEY_FRAME := 8
}
struct D3D12_VIDEO_DECODE_STATUS extends Int32 {
    static D3D12_VIDEO_DECODE_STATUS_OK := 0
    static D3D12_VIDEO_DECODE_STATUS_CONTINUE := 1
    static D3D12_VIDEO_DECODE_STATUS_CONTINUE_SKIP_DISPLAY := 2
    static D3D12_VIDEO_DECODE_STATUS_RESTART := 3
    static D3D12_VIDEO_DECODE_STATUS_RATE_EXCEEDED := 4
}
struct D3D12_VIDEO_DECODE_ARGUMENT_TYPE extends Int32 {
    static D3D12_VIDEO_DECODE_ARGUMENT_TYPE_PICTURE_PARAMETERS := 0
    static D3D12_VIDEO_DECODE_ARGUMENT_TYPE_INVERSE_QUANTIZATION_MATRIX := 1
    static D3D12_VIDEO_DECODE_ARGUMENT_TYPE_SLICE_CONTROL := 2
    static D3D12_VIDEO_DECODE_ARGUMENT_TYPE_HUFFMAN_TABLE := 3
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT {
    NodeIndex : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    Width : UInt32
    Height : UInt32
    DecodeFormat : DXGI_FORMAT
    FrameRate : DXGI_RATIONAL
    BitRate : UInt32
    SupportFlags : D3D12_VIDEO_DECODE_SUPPORT_FLAGS
    ConfigurationFlags : D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS
    DecodeTier : D3D12_VIDEO_DECODE_TIER
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT {
    NodeIndex : UInt32
    ProfileCount : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES {
    NodeIndex : UInt32
    ProfileCount : UInt32
    pProfiles : GUID.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT {
    NodeIndex : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    FormatCount : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS {
    NodeIndex : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    FormatCount : UInt32
    pOutputFormats : DXGI_FORMAT.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_ARCHITECTURE {
    IOCoherent : BOOL
}
struct D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT extends Int32 {
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_Y := 0
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_U := 1
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_V := 2
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_R := 0
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_G := 1
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_B := 2
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_A := 3
}
struct D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS extends Int32 {
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_NONE := 0
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_Y := 1
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_U := 2
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_V := 4
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_R := 1
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_G := 2
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_B := 4
    static D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_A := 8
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_HISTOGRAM {
    NodeIndex : UInt32
    DecodeProfile : GUID
    Width : UInt32
    Height : UInt32
    DecodeFormat : DXGI_FORMAT
    Components : D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS
    BinCount : UInt32
    CounterBitDepth : UInt32
}
struct D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_SUPPORTED := 1
}
struct D3D12_VIDEO_SCALE_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_SCALE_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_SCALE_SUPPORT_FLAG_POW2_ONLY := 1
    static D3D12_VIDEO_SCALE_SUPPORT_FLAG_EVEN_DIMENSIONS_ONLY := 2
    static D3D12_VIDEO_SCALE_SUPPORT_FLAG_DPB_ENCODER_RESOURCES := 4
}
struct D3D12_VIDEO_SCALE_SUPPORT {
    OutputSizeRange : D3D12_VIDEO_SIZE_RANGE
    Flags : D3D12_VIDEO_SCALE_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT {
    NodeIndex : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    DecodeSample : D3D12_VIDEO_SAMPLE
    OutputFormat : D3D12_VIDEO_FORMAT
    FrameRate : DXGI_RATIONAL
    BitRate : UInt32
    SupportFlags : D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS
    ScaleSupport : D3D12_VIDEO_SCALE_SUPPORT
}
struct D3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE {
    VideoDecoderHeapDesc : D3D12_VIDEO_DECODER_HEAP_DESC
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE {
    NodeMask : UInt32
    pOutputStreamDesc : D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC.Ptr
    NumInputStreamDescs : UInt32
    pInputStreamDescs : D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC.Ptr
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS {
    Status : Int64
    NumMacroblocksAffected : Int64
    FrameRate : DXGI_RATIONAL
    BitRate : UInt32
}
struct D3D12_VIDEO_DECODE_FRAME_ARGUMENT {
    Type : D3D12_VIDEO_DECODE_ARGUMENT_TYPE
    Size : UInt32
    pData : Struct.Ptr
}
struct D3D12_VIDEO_DECODE_REFERENCE_FRAMES {
    NumTexture2Ds : UInt32
    ppTexture2Ds : ID3D12Resource.Ptr
    pSubresources : UInt32.Ptr
    ppHeaps : ID3D12VideoDecoderHeap.Ptr
}
struct D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM {
    pBuffer : ID3D12Resource
    Offset : Int64
    Size : Int64
}
struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS {
    Enable : BOOL
    pReferenceTexture2D : ID3D12Resource
    ReferenceSubresource : UInt32
    OutputColorSpace : DXGI_COLOR_SPACE_TYPE
    DecodeColorSpace : DXGI_COLOR_SPACE_TYPE
}
struct D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS {
    NumFrameArguments : UInt32
    FrameArguments : D3D12_VIDEO_DECODE_FRAME_ARGUMENT[10]
    ReferenceFrames : D3D12_VIDEO_DECODE_REFERENCE_FRAMES
    CompressedBitstream : D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM
    pHeap : ID3D12VideoDecoderHeap
}
struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS {
    pOutputTexture2D : ID3D12Resource
    OutputSubresource : UInt32
    ConversionArguments : D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS
}
struct ID3D12VideoProcessor extends ID3D12Pageable {
    static IID := "{304FDB32-BEDE-410A-8545-943AC6A46138}"
    GetNodeMask()
      => ComCall(8, this.p, UInt32)
    GetNumInputStreamDescs()
      => ComCall(9, this.p, UInt32)
    GetInputStreamDescs(pInputStreamDescs)
      => ComCall(10, this.p, UInt32, pInputStreamDescs.Length, D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC.Ptr, pInputStreamDescs)
    GetOutputStreamDesc()
      => ComCall(11, this.p, D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC)
}
struct D3D12_VIDEO_PROCESS_FEATURE_FLAGS extends Int32 {
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_FILL := 1
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_LUMA_KEY := 2
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_STEREO := 4
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_ROTATION := 8
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_FLIP := 16
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_BLENDING := 32
    static D3D12_VIDEO_PROCESS_FEATURE_FLAG_PIXEL_ASPECT_RATIO := 64
}
struct D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS extends UInt32 {
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DENOISE := 1
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DERINGING := 2
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_EDGE_ENHANCEMENT := 4
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_COLOR_CORRECTION := 8
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_FLESH_TONE_MAPPING := 16
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_IMAGE_STABILIZATION := 32
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_SUPER_RESOLUTION := 64
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_ANAMORPHIC_SCALING := 128
    static D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_CUSTOM := 2147483648
}
struct D3D12_VIDEO_PROCESS_ORIENTATION extends Int32 {
    static D3D12_VIDEO_PROCESS_ORIENTATION_DEFAULT := 0
    static D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_HORIZONTAL := 1
    static D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90 := 2
    static D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90_FLIP_HORIZONTAL := 3
    static D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_180 := 4
    static D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_VERTICAL := 5
    static D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270 := 6
    static D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270_FLIP_HORIZONTAL := 7
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS extends Int32 {
    static D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_DISCONTINUITY := 1
    static D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_REPEAT := 2
}
struct D3D12_VIDEO_PROCESS_FILTER_RANGE {
    Minimum : Int32
    Maximum : Int32
    Default : Int32
    Multiplier : Float32
}
struct D3D12_VIDEO_PROCESS_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_PROCESS_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_PROCESS_SUPPORT_FLAG_SUPPORTED := 1
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT {
    NodeIndex : UInt32
    InputSample : D3D12_VIDEO_SAMPLE
    InputFieldType : D3D12_VIDEO_FIELD_TYPE
    InputStereoFormat : D3D12_VIDEO_FRAME_STEREO_FORMAT
    InputFrameRate : DXGI_RATIONAL
    OutputFormat : D3D12_VIDEO_FORMAT
    OutputStereoFormat : D3D12_VIDEO_FRAME_STEREO_FORMAT
    OutputFrameRate : DXGI_RATIONAL
    SupportFlags : D3D12_VIDEO_PROCESS_SUPPORT_FLAGS
    ScaleSupport : D3D12_VIDEO_SCALE_SUPPORT
    FeatureSupport : D3D12_VIDEO_PROCESS_FEATURE_FLAGS
    DeinterlaceSupport : D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS
    AutoProcessingSupport : D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS
    FilterSupport : D3D12_VIDEO_PROCESS_FILTER_FLAGS
    FilterRangeSupport : D3D12_VIDEO_PROCESS_FILTER_RANGE[32]
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS {
    NodeIndex : UInt32
    MaxInputStreams : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO {
    NodeIndex : UInt32
    DeinterlaceMode : D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS
    Filters : D3D12_VIDEO_PROCESS_FILTER_FLAGS
    FeatureSupport : D3D12_VIDEO_PROCESS_FEATURE_FLAGS
    InputFrameRate : DXGI_RATIONAL
    OutputFrameRate : DXGI_RATIONAL
    EnableAutoProcessing : BOOL
    PastFrames : UInt32
    FutureFrames : UInt32
}
struct D3D12_VIDEO_PROCESS_REFERENCE_SET {
    NumPastFrames : UInt32
    ppPastFrames : ID3D12Resource.Ptr
    pPastSubresources : UInt32.Ptr
    NumFutureFrames : UInt32
    ppFutureFrames : ID3D12Resource.Ptr
    pFutureSubresources : UInt32.Ptr
}
struct D3D12_VIDEO_PROCESS_TRANSFORM {
    SourceRectangle : RECT
    DestinationRectangle : RECT
    Orientation : D3D12_VIDEO_PROCESS_ORIENTATION
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE {
    OutputIndex : UInt32
    InputFrameOrField : UInt32
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM {
    pTexture2D : ID3D12Resource
    Subresource : UInt32
    ReferenceSet : D3D12_VIDEO_PROCESS_REFERENCE_SET
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS {
    InputStream : D3D12_VIDEO_PROCESS_INPUT_STREAM[2]
    Transform : D3D12_VIDEO_PROCESS_TRANSFORM
    Flags : D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS
    RateInfo : D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE
    FilterLevels : Int32[32]
    AlphaBlending : D3D12_VIDEO_PROCESS_ALPHA_BLENDING
}
struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM {
    pTexture2D : ID3D12Resource
    Subresource : UInt32
}
struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS {
    OutputStream : D3D12_VIDEO_PROCESS_OUTPUT_STREAM[2]
    TargetRectangle : RECT
}
struct ID3D12VideoDecodeCommandList extends ID3D12CommandList {
    static IID := "{3B60536E-AD29-4E64-A269-F853837E5E53}"
    Close()
      => ComCall(9, this.p)
    Reset(pAllocator)
      => ComCall(10, this.p, ID3D12CommandAllocator, pAllocator)
    ClearState()
      => ComCall(11, this.p, "void")
    ResourceBarrier(pBarriers)
      => ComCall(12, this.p, UInt32, pBarriers.Length, D3D12_RESOURCE_BARRIER.Ptr, pBarriers, "void")
    DiscardResource(pResource, pRegion?)
      => ComCall(13, this.p, ID3D12Resource, pResource, D3D12_DISCARD_REGION.Ptr, pRegion?, "void")
    BeginQuery(pQueryHeap, Type, Index)
      => ComCall(14, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    EndQuery(pQueryHeap, Type, Index)
      => ComCall(15, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    ResolveQueryData(pQueryHeap, Type, StartIndex, NumQueries, pDestinationBuffer, AlignedDestinationBufferOffset)
      => ComCall(16, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, StartIndex, UInt32, NumQueries, ID3D12Resource, pDestinationBuffer, Int64, AlignedDestinationBufferOffset, "void")
    SetPredication(pBuffer?, AlignedBufferOffset, Operation)
      => ComCall(17, this.p, ID3D12Resource, pBuffer?, Int64, AlignedBufferOffset, D3D12_PREDICATION_OP, Operation, "void")
    SetMarker(Metadata, pData?)
      => ComCall(18, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    BeginEvent(Metadata, pData?)
      => ComCall(19, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    EndEvent()
      => ComCall(20, this.p, "void")
    DecodeFrame(pDecoder, pOutputArguments, pInputArguments)
      => ComCall(21, this.p, ID3D12VideoDecoder, pDecoder, D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS.Ptr, pOutputArguments, D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS.Ptr, pInputArguments, "void")
    WriteBufferImmediate(pParams, pModes?)
      => ComCall(22, this.p, UInt32, pModes?.Length ?? 0, D3D12_WRITEBUFFERIMMEDIATE_PARAMETER.Ptr, pParams, D3D12_WRITEBUFFERIMMEDIATE_MODE.Ptr, pModes?, "void")
}
struct ID3D12VideoProcessCommandList extends ID3D12CommandList {
    static IID := "{AEB2543A-167F-4682-ACC8-D159ED4A6209}"
    Close()
      => ComCall(9, this.p)
    Reset(pAllocator)
      => ComCall(10, this.p, ID3D12CommandAllocator, pAllocator)
    ClearState()
      => ComCall(11, this.p, "void")
    ResourceBarrier(pBarriers)
      => ComCall(12, this.p, UInt32, pBarriers.Length, D3D12_RESOURCE_BARRIER.Ptr, pBarriers, "void")
    DiscardResource(pResource, pRegion?)
      => ComCall(13, this.p, ID3D12Resource, pResource, D3D12_DISCARD_REGION.Ptr, pRegion?, "void")
    BeginQuery(pQueryHeap, Type, Index)
      => ComCall(14, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    EndQuery(pQueryHeap, Type, Index)
      => ComCall(15, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    ResolveQueryData(pQueryHeap, Type, StartIndex, NumQueries, pDestinationBuffer, AlignedDestinationBufferOffset)
      => ComCall(16, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, StartIndex, UInt32, NumQueries, ID3D12Resource, pDestinationBuffer, Int64, AlignedDestinationBufferOffset, "void")
    SetPredication(pBuffer?, AlignedBufferOffset, Operation)
      => ComCall(17, this.p, ID3D12Resource, pBuffer?, Int64, AlignedBufferOffset, D3D12_PREDICATION_OP, Operation, "void")
    SetMarker(Metadata, pData?)
      => ComCall(18, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    BeginEvent(Metadata, pData?)
      => ComCall(19, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    EndEvent()
      => ComCall(20, this.p, "void")
    ProcessFrames(pVideoProcessor, pOutputArguments, pInputArguments)
      => ComCall(21, this.p, ID3D12VideoProcessor, pVideoProcessor, D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS.Ptr, pOutputArguments, UInt32, pInputArguments.Length, D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS.Ptr, pInputArguments, "void")
    WriteBufferImmediate(pParams, pModes?)
      => ComCall(22, this.p, UInt32, pModes?.Length ?? 0, D3D12_WRITEBUFFERIMMEDIATE_PARAMETER.Ptr, pParams, D3D12_WRITEBUFFERIMMEDIATE_MODE.Ptr, pModes?, "void")
}
struct D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM {
    Offset : Int64
    pBuffer : ID3D12Resource
}
struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1 {
    Enable : BOOL
    pReferenceTexture2D : ID3D12Resource
    ReferenceSubresource : UInt32
    OutputColorSpace : DXGI_COLOR_SPACE_TYPE
    DecodeColorSpace : DXGI_COLOR_SPACE_TYPE
    OutputWidth : UInt32
    OutputHeight : UInt32
}
struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1 {
    pOutputTexture2D : ID3D12Resource
    OutputSubresource : UInt32
    ConversionArguments : D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1
    Histograms : D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM[4]
}
struct ID3D12VideoDecodeCommandList1 extends ID3D12VideoDecodeCommandList {
    static IID := "{D52F011B-B56E-453C-A05A-A7F311C8F472}"
    DecodeFrame1(pDecoder, pOutputArguments, pInputArguments)
      => ComCall(23, this.p, ID3D12VideoDecoder, pDecoder, D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1.Ptr, pOutputArguments, D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS.Ptr, pInputArguments, "void")
}
struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1 {
    InputStream : D3D12_VIDEO_PROCESS_INPUT_STREAM[2]
    Transform : D3D12_VIDEO_PROCESS_TRANSFORM
    Flags : D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS
    RateInfo : D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE
    FilterLevels : Int32[32]
    AlphaBlending : D3D12_VIDEO_PROCESS_ALPHA_BLENDING
    FieldType : D3D12_VIDEO_FIELD_TYPE
}
struct ID3D12VideoProcessCommandList1 extends ID3D12VideoProcessCommandList {
    static IID := "{542C5C4D-7596-434F-8C93-4EFA6766F267}"
    ProcessFrames1(pVideoProcessor, pOutputArguments, pInputArguments)
      => ComCall(23, this.p, ID3D12VideoProcessor, pVideoProcessor, D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS.Ptr, pOutputArguments, UInt32, pInputArguments.Length, D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1.Ptr, pInputArguments, "void")
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE extends Int32 {
    static D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_8X8 := 0
    static D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_16X16 := 1
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS extends Int32 {
    static D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_NONE := 0
    static D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_8X8 := 1
    static D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAG_16X16 := 2
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION extends Int32 {
    static D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_QUARTER_PEL := 0
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS extends Int32 {
    static D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_NONE := 0
    static D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAG_QUARTER_PEL := 1
}
struct D3D12_FEATURE_DATA_VIDEO_FEATURE_AREA_SUPPORT {
    NodeIndex : UInt32
    VideoDecodeSupport : BOOL
    VideoProcessSupport : BOOL
    VideoEncodeSupport : BOOL
}
struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR {
    NodeIndex : UInt32
    InputFormat : DXGI_FORMAT
    BlockSizeFlags : D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE_FLAGS
    PrecisionFlags : D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION_FLAGS
    SizeRange : D3D12_VIDEO_SIZE_RANGE
}
struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR_SIZE {
    NodeIndex : UInt32
    InputFormat : DXGI_FORMAT
    BlockSize : D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE
    Precision : D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION
    SizeRange : D3D12_VIDEO_SIZE_RANGE
    Protected : BOOL
    MotionVectorHeapMemoryPoolL0Size : Int64
    MotionVectorHeapMemoryPoolL1Size : Int64
    MotionEstimatorMemoryPoolL0Size : Int64
    MotionEstimatorMemoryPoolL1Size : Int64
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_DESC {
    NodeMask : UInt32
    InputFormat : DXGI_FORMAT
    BlockSize : D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE
    Precision : D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION
    SizeRange : D3D12_VIDEO_SIZE_RANGE
}
struct ID3D12VideoMotionEstimator extends ID3D12Pageable {
    static IID := "{33FDAE0E-098B-428F-87BB-34B695DE08F8}"
    GetDesc()
      => ComCall(8, this.p, D3D12_VIDEO_MOTION_ESTIMATOR_DESC)
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC {
    NodeMask : UInt32
    InputFormat : DXGI_FORMAT
    BlockSize : D3D12_VIDEO_MOTION_ESTIMATOR_SEARCH_BLOCK_SIZE
    Precision : D3D12_VIDEO_MOTION_ESTIMATOR_VECTOR_PRECISION
    SizeRange : D3D12_VIDEO_SIZE_RANGE
}
struct ID3D12VideoMotionVectorHeap extends ID3D12Pageable {
    static IID := "{5BE17987-743A-4061-834B-23D22DAEA505}"
    GetDesc()
      => ComCall(8, this.p, D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC)
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct ID3D12VideoDevice1 extends ID3D12VideoDevice {
    static IID := "{981611AD-A144-4C83-9890-F30E26D658AB}"
    CreateVideoMotionEstimator(pDesc, pProtectedResourceSession?, riid, ppVideoMotionEstimator)
      => ComCall(7, this.p, D3D12_VIDEO_MOTION_ESTIMATOR_DESC.Ptr, pDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoMotionEstimator)
    CreateVideoMotionVectorHeap(pDesc, pProtectedResourceSession?, riid, ppVideoMotionVectorHeap)
      => ComCall(8, this.p, D3D12_VIDEO_MOTION_VECTOR_HEAP_DESC.Ptr, pDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoMotionVectorHeap)
}
struct D3D12_RESOURCE_COORDINATE {
    X : Int64
    Y : UInt32
    Z : UInt32
    SubresourceIndex : UInt32
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT {
    pMotionVectorHeap : ID3D12VideoMotionVectorHeap
}
struct D3D12_VIDEO_MOTION_ESTIMATOR_INPUT {
    pInputTexture2D : ID3D12Resource
    InputSubresourceIndex : UInt32
    pReferenceTexture2D : ID3D12Resource
    ReferenceSubresourceIndex : UInt32
    pHintMotionVectorHeap : ID3D12VideoMotionVectorHeap
}
struct D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_OUTPUT {
    pMotionVectorTexture2D : ID3D12Resource
    MotionVectorCoordinate : D3D12_RESOURCE_COORDINATE
}
struct D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_INPUT {
    pMotionVectorHeap : ID3D12VideoMotionVectorHeap
    PixelWidth : UInt32
    PixelHeight : UInt32
}
struct ID3D12VideoEncodeCommandList extends ID3D12CommandList {
    static IID := "{8455293A-0CBD-4831-9B39-FBDBAB724723}"
    Close()
      => ComCall(9, this.p)
    Reset(pAllocator)
      => ComCall(10, this.p, ID3D12CommandAllocator, pAllocator)
    ClearState()
      => ComCall(11, this.p, "void")
    ResourceBarrier(pBarriers)
      => ComCall(12, this.p, UInt32, pBarriers.Length, D3D12_RESOURCE_BARRIER.Ptr, pBarriers, "void")
    DiscardResource(pResource, pRegion?)
      => ComCall(13, this.p, ID3D12Resource, pResource, D3D12_DISCARD_REGION.Ptr, pRegion?, "void")
    BeginQuery(pQueryHeap, Type, Index)
      => ComCall(14, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    EndQuery(pQueryHeap, Type, Index)
      => ComCall(15, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, Index, "void")
    ResolveQueryData(pQueryHeap, Type, StartIndex, NumQueries, pDestinationBuffer, AlignedDestinationBufferOffset)
      => ComCall(16, this.p, ID3D12QueryHeap, pQueryHeap, D3D12_QUERY_TYPE, Type, UInt32, StartIndex, UInt32, NumQueries, ID3D12Resource, pDestinationBuffer, Int64, AlignedDestinationBufferOffset, "void")
    SetPredication(pBuffer?, AlignedBufferOffset, Operation)
      => ComCall(17, this.p, ID3D12Resource, pBuffer?, Int64, AlignedBufferOffset, D3D12_PREDICATION_OP, Operation, "void")
    SetMarker(Metadata, pData?)
      => ComCall(18, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    BeginEvent(Metadata, pData?)
      => ComCall(19, this.p, UInt32, Metadata, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, "void")
    EndEvent()
      => ComCall(20, this.p, "void")
    EstimateMotion(pMotionEstimator, pOutputArguments, pInputArguments)
      => ComCall(21, this.p, ID3D12VideoMotionEstimator, pMotionEstimator, D3D12_VIDEO_MOTION_ESTIMATOR_OUTPUT.Ptr, pOutputArguments, D3D12_VIDEO_MOTION_ESTIMATOR_INPUT.Ptr, pInputArguments, "void")
    ResolveMotionVectorHeap(pOutputArguments, pInputArguments)
      => ComCall(22, this.p, D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_OUTPUT.Ptr, pOutputArguments, D3D12_RESOLVE_VIDEO_MOTION_VECTOR_HEAP_INPUT.Ptr, pInputArguments, "void")
    WriteBufferImmediate(pParams, pModes?)
      => ComCall(23, this.p, UInt32, pModes?.Length ?? 0, D3D12_WRITEBUFFERIMMEDIATE_PARAMETER.Ptr, pParams, D3D12_WRITEBUFFERIMMEDIATE_MODE.Ptr, pModes?, "void")
    SetProtectedResourceSession(pProtectedResourceSession?)
      => ComCall(24, this.p, ID3D12ProtectedResourceSession, pProtectedResourceSession?, "void")
}
struct D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAG_SUPPORTED := 1
}
struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROTECTED_RESOURCES {
    NodeIndex : UInt32
    Configuration : D3D12_VIDEO_DECODE_CONFIGURATION
    SupportFlags : D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESS_PROTECTED_RESOURCES {
    NodeIndex : UInt32
    SupportFlags : D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_MOTION_ESTIMATOR_PROTECTED_RESOURCES {
    NodeIndex : UInt32
    SupportFlags : D3D12_VIDEO_PROTECTED_RESOURCE_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE1 {
    VideoDecoderHeapDesc : D3D12_VIDEO_DECODER_HEAP_DESC
    Protected : BOOL
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE1 {
    NodeMask : UInt32
    pOutputStreamDesc : D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC.Ptr
    NumInputStreamDescs : UInt32
    pInputStreamDescs : D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC.Ptr
    Protected : BOOL
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE extends Int32 {
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CREATION := 0
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_INITIALIZATION := 1
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_EXECUTION := 2
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_INPUT := 3
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_CAPS_OUTPUT := 4
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_INPUT := 5
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE_DEVICE_EXECUTE_OUTPUT := 6
}
struct D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE extends Int32 {
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT8 := 0
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT16 := 1
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT32 := 2
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_UINT64 := 3
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT8 := 4
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT16 := 5
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT32 := 6
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_SINT64 := 7
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_FLOAT := 8
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_DOUBLE := 9
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE_RESOURCE := 10
}
struct D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAGS extends Int32 {
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_NONE := 0
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_READ := 1
    static D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAG_WRITE := 2
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_COUNT {
    NodeIndex : UInt32
    CommandCount : UInt32
}
struct D3D12_VIDEO_EXTENSION_COMMAND_INFO {
    CommandId : GUID
    Name : PWSTR
    CommandListSupportFlags : D3D12_COMMAND_LIST_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMANDS {
    NodeIndex : UInt32
    CommandCount : UInt32
    pCommandInfos : D3D12_VIDEO_EXTENSION_COMMAND_INFO.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_PARAMETER_COUNT {
    CommandId : GUID
    Stage : D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE
    ParameterCount : UInt32
    ParameterPacking : UInt32
}
struct D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_INFO {
    Name : PWSTR
    Type : D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_TYPE
    Flags : D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_PARAMETERS {
    CommandId : GUID
    Stage : D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_STAGE
    ParameterCount : UInt32
    pParameterInfos : D3D12_VIDEO_EXTENSION_COMMAND_PARAMETER_INFO.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SUPPORT {
    NodeIndex : UInt32
    CommandId : GUID
    pInputData : Struct.Ptr
    InputDataSizeInBytes : IntPtr
    pOutputData : Struct.Ptr
    OutputDataSizeInBytes : IntPtr
}
struct D3D12_FEATURE_DATA_VIDEO_EXTENSION_COMMAND_SIZE {
    NodeIndex : UInt32
    CommandId : GUID
    pCreationParameters : Struct.Ptr
    CreationParametersSizeInBytes : IntPtr
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_VIDEO_EXTENSION_COMMAND_DESC {
    NodeMask : UInt32
    CommandId : GUID
}
struct ID3D12VideoDecoder1 extends ID3D12VideoDecoder {
    static IID := "{79A2E5FB-CCD2-469A-9FDE-195D10951F7E}"
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct ID3D12VideoDecoderHeap1 extends ID3D12VideoDecoderHeap {
    static IID := "{DA1D98C5-539F-41B2-BF6B-1198A03B6D26}"
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct ID3D12VideoProcessor1 extends ID3D12VideoProcessor {
    static IID := "{F3CFE615-553F-425C-86D8-EE8C1B1FB01C}"
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(12, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct ID3D12VideoExtensionCommand extends ID3D12Pageable {
    static IID := "{554E41E8-AE8E-4A8C-B7D2-5B4F274A30E4}"
    GetDesc()
      => ComCall(8, this.p, D3D12_VIDEO_EXTENSION_COMMAND_DESC)
    GetProtectedResourceSession(riid, ppProtectedSession?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppProtectedSession?)
}
struct ID3D12VideoDevice2 extends ID3D12VideoDevice1 {
    static IID := "{F019AC49-F838-4A95-9B17-579437C8F513}"
    CreateVideoDecoder1(pDesc, pProtectedResourceSession?, riid, ppVideoDecoder)
      => ComCall(9, this.p, D3D12_VIDEO_DECODER_DESC.Ptr, pDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoDecoder)
    CreateVideoDecoderHeap1(pVideoDecoderHeapDesc, pProtectedResourceSession?, riid, ppVideoDecoderHeap)
      => ComCall(10, this.p, D3D12_VIDEO_DECODER_HEAP_DESC.Ptr, pVideoDecoderHeapDesc, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoDecoderHeap)
    CreateVideoProcessor1(NodeMask, pOutputStreamDesc, pInputStreamDescs, pProtectedResourceSession?, riid, ppVideoProcessor)
      => ComCall(11, this.p, UInt32, NodeMask, D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC.Ptr, pOutputStreamDesc, UInt32, pInputStreamDescs.Length, D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC.Ptr, pInputStreamDescs, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoProcessor)
    CreateVideoExtensionCommand(pDesc, pCreationParameters, pProtectedResourceSession?, riid, ppVideoExtensionCommand)
      => ComCall(12, this.p, D3D12_VIDEO_EXTENSION_COMMAND_DESC.Ptr, pDesc, Struct.Ptr, pCreationParameters, IntPtr, pCreationParameters.Size, ID3D12ProtectedResourceSession, pProtectedResourceSession?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoExtensionCommand)
    ExecuteExtensionCommand(pExtensionCommand, pExecutionParameters, pOutputData)
      => ComCall(13, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pExecutionParameters, IntPtr, pExecutionParameters.Size, Struct.Ptr, pOutputData, IntPtr, pOutputData.Size)
}
struct ID3D12VideoDecodeCommandList2 extends ID3D12VideoDecodeCommandList1 {
    static IID := "{6E120880-C114-4153-8036-D247051E1729}"
    SetProtectedResourceSession(pProtectedResourceSession?)
      => ComCall(24, this.p, ID3D12ProtectedResourceSession, pProtectedResourceSession?, "void")
    InitializeExtensionCommand(pExtensionCommand, pInitializationParameters)
      => ComCall(25, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pInitializationParameters, IntPtr, pInitializationParameters.Size, "void")
    ExecuteExtensionCommand(pExtensionCommand, pExecutionParameters)
      => ComCall(26, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pExecutionParameters, IntPtr, pExecutionParameters.Size, "void")
}
struct ID3D12VideoDecodeCommandList3 extends ID3D12VideoDecodeCommandList2 {
    static IID := "{2AEE8C37-9562-42DA-8ABF-61EFEB2E4513}"
    Barrier(pBarrierGroups)
      => ComCall(27, this.p, UInt32, pBarrierGroups.Length, D3D12_BARRIER_GROUP.Ptr, pBarrierGroups, "void")
}
struct ID3D12VideoProcessCommandList2 extends ID3D12VideoProcessCommandList1 {
    static IID := "{DB525AE4-6AD6-473C-BAA7-59B2E37082E4}"
    SetProtectedResourceSession(pProtectedResourceSession?)
      => ComCall(24, this.p, ID3D12ProtectedResourceSession, pProtectedResourceSession?, "void")
    InitializeExtensionCommand(pExtensionCommand, pInitializationParameters)
      => ComCall(25, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pInitializationParameters, IntPtr, pInitializationParameters.Size, "void")
    ExecuteExtensionCommand(pExtensionCommand, pExecutionParameters)
      => ComCall(26, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pExecutionParameters, IntPtr, pExecutionParameters.Size, "void")
}
struct ID3D12VideoProcessCommandList3 extends ID3D12VideoProcessCommandList2 {
    static IID := "{1A0A4CA4-9F08-40CE-9558-B411FD2666FF}"
    Barrier(pBarrierGroups)
      => ComCall(27, this.p, UInt32, pBarrierGroups.Length, D3D12_BARRIER_GROUP.Ptr, pBarrierGroups, "void")
}
struct ID3D12VideoEncodeCommandList1 extends ID3D12VideoEncodeCommandList {
    static IID := "{94971ECA-2BDB-4769-88CF-3675EA757EBC}"
    InitializeExtensionCommand(pExtensionCommand, pInitializationParameters)
      => ComCall(25, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pInitializationParameters, IntPtr, pInitializationParameters.Size, "void")
    ExecuteExtensionCommand(pExtensionCommand, pExecutionParameters)
      => ComCall(26, this.p, ID3D12VideoExtensionCommand, pExtensionCommand, Struct.Ptr, pExecutionParameters, IntPtr, pExecutionParameters.Size, "void")
}
struct D3D12_VIDEO_ENCODER_AV1_PROFILE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_PROFILE_MAIN := 0
    static D3D12_VIDEO_ENCODER_AV1_PROFILE_HIGH := 1
    static D3D12_VIDEO_ENCODER_AV1_PROFILE_PROFESSIONAL := 2
}
struct D3D12_VIDEO_ENCODER_AV1_LEVELS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_2_0 := 0
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_2_1 := 1
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_2_2 := 2
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_2_3 := 3
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_3_0 := 4
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_3_1 := 5
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_3_2 := 6
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_3_3 := 7
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_4_0 := 8
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_4_1 := 9
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_4_2 := 10
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_4_3 := 11
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_5_0 := 12
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_5_1 := 13
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_5_2 := 14
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_5_3 := 15
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_6_0 := 16
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_6_1 := 17
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_6_2 := 18
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_6_3 := 19
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_7_0 := 20
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_7_1 := 21
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_7_2 := 22
    static D3D12_VIDEO_ENCODER_AV1_LEVELS_7_3 := 23
}
struct D3D12_VIDEO_ENCODER_AV1_TIER extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_TIER_MAIN := 0
    static D3D12_VIDEO_ENCODER_AV1_TIER_HIGH := 1
}
struct D3D12_VIDEO_ENCODER_AV1_LEVEL_TIER_CONSTRAINTS {
    Level : D3D12_VIDEO_ENCODER_AV1_LEVELS
    Tier : D3D12_VIDEO_ENCODER_AV1_TIER
}
struct D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_128x128_SUPERBLOCK := 1
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_FILTER_INTRA := 2
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_INTRA_EDGE_FILTER := 4
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_INTERINTRA_COMPOUND := 8
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_MASKED_COMPOUND := 16
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_WARPED_MOTION := 32
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_DUAL_FILTER := 64
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_JNT_COMP := 128
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_FORCED_INTEGER_MOTION_VECTORS := 256
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_SUPER_RESOLUTION := 512
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_LOOP_RESTORATION_FILTER := 1024
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_PALETTE_ENCODING := 2048
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_CDEF_FILTERING := 4096
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_INTRA_BLOCK_COPY := 8192
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_FRAME_REFERENCE_MOTION_VECTORS := 16384
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_ORDER_HINT_TOOLS := 32768
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_AUTO_SEGMENTATION := 65536
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_CUSTOM_SEGMENTATION := 131072
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_LOOP_FILTER_DELTAS := 262144
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_QUANTIZATION_DELTAS := 524288
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_QUANTIZATION_MATRIX := 1048576
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_REDUCED_TX_SET := 2097152
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_MOTION_MODE_SWITCHABLE := 4194304
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_ALLOW_HIGH_PRECISION_MV := 8388608
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_SKIP_MODE_PRESENT := 16777216
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_DELTA_LF_PARAMS := 33554432
    static D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAG_DISABLE_CDF_UPDATE_UNSUPPORTED := 67108864
}
struct D3D12_VIDEO_ENCODER_AV1_TX_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_ONLY4x4 := 0
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_LARGEST := 1
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_SELECT := 2
}
struct D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAG_ONLY4x4 := 1
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAG_LARGEST := 2
    static D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAG_SELECT := 4
}
struct D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_EIGHTTAP := 0
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_EIGHTTAP_SMOOTH := 1
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_EIGHTTAP_SHARP := 2
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_BILINEAR := 3
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_SWITCHABLE := 4
}
struct D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_EIGHTTAP := 1
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_EIGHTTAP_SMOOTH := 2
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_EIGHTTAP_SHARP := 4
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_BILINEAR := 8
    static D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAG_SWITCHABLE := 16
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE_4x4 := 0
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE_8x8 := 1
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE_16x16 := 2
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE_32x32 := 3
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE_64x64 := 4
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_DISABLED := 0
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_Q := 1
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_LF_Y_V := 2
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_LF_Y_H := 3
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_LF_U := 4
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_LF_V := 5
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_REF_FRAME := 6
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_SKIP := 7
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_ALT_GLOBALMV := 8
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_DISABLED := 1
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_Q := 2
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_LF_Y_V := 4
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_LF_Y_H := 8
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_LF_U := 16
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_LF_V := 32
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_REF_FRAME := 64
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_SKIP := 128
    static D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAG_ALT_GLOBALMV := 256
}
struct D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE_DISABLED := 0
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE_SWITCHABLE := 1
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE_WIENER := 2
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE_SGRPROJ := 3
}
struct D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE_DISABLED := 0
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE_32x32 := 1
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE_64x64 := 2
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE_128x128 := 3
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE_256x256 := 4
}
struct D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAG_NOT_SUPPORTED := 0
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAG_32x32 := 1
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAG_64x64 := 2
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAG_128x128 := 4
    static D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAG_256x256 := 8
}
struct D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_IDENTITY := 0
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_TRANSLATION := 1
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_ROTZOOM := 2
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_AFFINE := 3
}
struct D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAG_IDENTITY := 1
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAG_TRANSLATION := 2
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAG_ROTZOOM := 4
    static D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAG_AFFINE := 8
}
struct D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_QUANTIZATION := 1
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_QUANTIZATION_DELTA := 2
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_LOOP_FILTER := 4
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_LOOP_FILTER_DELTA := 8
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_CDEF_DATA := 16
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_CONTEXT_UPDATE_TILE_ID := 32
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_COMPOUND_PREDICTION_MODE := 64
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_PRIMARY_REF_FRAME := 128
    static D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAG_REFERENCE_INDICES := 256
}
struct D3D12_VIDEO_ENCODER_AV1_CODEC_CONFIGURATION_SUPPORT {
    SupportedFeatureFlags : D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAGS
    RequiredFeatureFlags : D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAGS
    SupportedInterpolationFilters : D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS_FLAGS
    SupportedRestorationParams : D3D12_VIDEO_ENCODER_AV1_RESTORATION_SUPPORT_FLAGS[9]
    SupportedSegmentationModes : D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MODE_FLAGS
    SupportedTxModes : D3D12_VIDEO_ENCODER_AV1_TX_MODE_FLAGS[4]
    SegmentationBlockSize : D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_BLOCK_SIZE
    PostEncodeValuesFlags : D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES_FLAGS
    MaxTemporalLayers : UInt32
    MaxSpatialLayers : UInt32
}
struct D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_KEY_FRAME := 0
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_INTER_FRAME := 1
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_INTRA_ONLY_FRAME := 2
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_SWITCH_FRAME := 3
}
struct D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAG_KEY_FRAME := 1
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAG_INTER_FRAME := 2
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAG_INTRA_ONLY_FRAME := 4
    static D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAG_SWITCH_FRAME := 8
}
struct D3D12_VIDEO_ENCODER_AV1_COMP_PREDICTION_TYPE extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_COMP_PREDICTION_TYPE_SINGLE_REFERENCE := 0
    static D3D12_VIDEO_ENCODER_AV1_COMP_PREDICTION_TYPE_COMPOUND_REFERENCE := 1
}
struct D3D12_VIDEO_ENCODER_CODEC_AV1_PICTURE_CONTROL_SUPPORT {
    PredictionMode : D3D12_VIDEO_ENCODER_AV1_COMP_PREDICTION_TYPE
    MaxUniqueReferencesPerFrame : UInt32
    SupportedFrameTypes : D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE_FLAGS
    SupportedReferenceWarpedMotionFlags : D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION_FLAGS
}
struct D3D12_VIDEO_ENCODER_AV1_CODEC_CONFIGURATION {
    FeatureFlags : D3D12_VIDEO_ENCODER_AV1_FEATURE_FLAGS
    OrderHintBitsMinus1 : UInt32
}
struct D3D12_VIDEO_ENCODER_AV1_SEQUENCE_STRUCTURE {
    IntraDistance : UInt32
    InterFramePeriod : UInt32
}
struct D3D12_VIDEO_ENCODER_AV1_REFERENCE_PICTURE_WARPED_MOTION_INFO {
    TransformationType : D3D12_VIDEO_ENCODER_AV1_REFERENCE_WARPED_MOTION_TRANSFORMATION
    TransformationMatrix : Int32[8]
    InvalidAffineSet : BOOL
}
struct D3D12_VIDEO_ENCODER_AV1_REFERENCE_PICTURE_DESCRIPTOR {
    ReconstructedPictureResourceIndex : UInt32
    TemporalLayerIndexPlus1 : UInt32
    SpatialLayerIndexPlus1 : UInt32
    FrameType : D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE
    WarpedMotionInfo : D3D12_VIDEO_ENCODER_AV1_REFERENCE_PICTURE_WARPED_MOTION_INFO
    OrderHint : UInt32
    PictureIndex : UInt32
}
struct D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_ERROR_RESILIENT_MODE := 1
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_DISABLE_CDF_UPDATE := 2
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_PALETTE_ENCODING := 4
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_SKIP_MODE := 8
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_FRAME_REFERENCE_MOTION_VECTORS := 16
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_FORCE_INTEGER_MOTION_VECTORS := 32
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ALLOW_INTRA_BLOCK_COPY := 64
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_USE_SUPER_RESOLUTION := 128
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_DISABLE_FRAME_END_UPDATE_CDF := 256
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_FRAME_SEGMENTATION_AUTO := 512
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_FRAME_SEGMENTATION_CUSTOM := 1024
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ENABLE_WARPED_MOTION := 2048
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_REDUCED_TX_SET := 4096
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_MOTION_MODE_SWITCHABLE := 8192
    static D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAG_ALLOW_HIGH_PRECISION_MV := 16384
}
struct D3D12_VIDEO_ENCODER_AV1_RESTORATION_CONFIG {
    FrameRestorationType : D3D12_VIDEO_ENCODER_AV1_RESTORATION_TYPE[3]
    LoopRestorationPixelSize : D3D12_VIDEO_ENCODER_AV1_RESTORATION_TILESIZE[3]
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENT_DATA {
    EnabledFeatures : Int64
    FeatureValue : Int64[8]
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_CONFIG {
    UpdateMap : Int64
    TemporalUpdate : Int64
    UpdateData : Int64
    NumSegments : Int64
    SegmentsData : D3D12_VIDEO_ENCODER_AV1_SEGMENT_DATA[8]
}
struct D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MAP {
    SegmentsMapByteSize : UInt32
    pSegmentsMap : UInt8.Ptr
}
struct D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_CONFIG {
    LoopFilterLevel : Int64[2]
    LoopFilterLevelU : Int64
    LoopFilterLevelV : Int64
    LoopFilterSharpnessLevel : Int64
    LoopFilterDeltaEnabled : Int64
    UpdateRefDelta : Int64
    RefDeltas : Int64[8]
    UpdateModeDelta : Int64
    ModeDeltas : Int64[2]
}
struct D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_DELTA_CONFIG {
    DeltaLFPresent : Int64
    DeltaLFMulti : Int64
    DeltaLFRes : Int64
}
struct D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_CONFIG {
    BaseQIndex : Int64
    YDCDeltaQ : Int64
    UDCDeltaQ : Int64
    UACDeltaQ : Int64
    VDCDeltaQ : Int64
    VACDeltaQ : Int64
    UsingQMatrix : Int64
    QMY : Int64
    QMU : Int64
    QMV : Int64
}
struct D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_DELTA_CONFIG {
    DeltaQPresent : Int64
    DeltaQRes : Int64
}
struct D3D12_VIDEO_ENCODER_AV1_CDEF_CONFIG {
    CdefBits : Int64
    CdefDampingMinus3 : Int64
    CdefYPriStrength : Int64[8]
    CdefUVPriStrength : Int64[8]
    CdefYSecStrength : Int64[8]
    CdefUVSecStrength : Int64[8]
}
struct D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_CODEC_DATA {
    Flags : D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_FLAGS
    FrameType : D3D12_VIDEO_ENCODER_AV1_FRAME_TYPE
    CompoundPredictionType : D3D12_VIDEO_ENCODER_AV1_COMP_PREDICTION_TYPE
    InterpolationFilter : D3D12_VIDEO_ENCODER_AV1_INTERPOLATION_FILTERS
    FrameRestorationConfig : D3D12_VIDEO_ENCODER_AV1_RESTORATION_CONFIG
    TxMode : D3D12_VIDEO_ENCODER_AV1_TX_MODE
    SuperResDenominator : UInt32
    OrderHint : UInt32
    PictureIndex : UInt32
    TemporalLayerIndexPlus1 : UInt32
    SpatialLayerIndexPlus1 : UInt32
    ReferenceFramesReconPictureDescriptors : D3D12_VIDEO_ENCODER_AV1_REFERENCE_PICTURE_DESCRIPTOR[8]
    ReferenceIndices : UInt32[7]
    PrimaryRefFrame : UInt32
    RefreshFrameFlags : UInt32
    LoopFilter : D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_CONFIG
    LoopFilterDelta : D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_DELTA_CONFIG
    Quantization : D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_CONFIG
    QuantizationDelta : D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_DELTA_CONFIG
    CDEF : D3D12_VIDEO_ENCODER_AV1_CDEF_CONFIG
    QPMapValuesCount : UInt32
    pRateControlQPMap : Int16.Ptr
    CustomSegmentation : D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_CONFIG
    CustomSegmentsMap : D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_MAP
}
struct D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_TILES {
    RowCount : Int64
    ColCount : Int64
    RowHeights : Int64[64]
    ColWidths : Int64[64]
    ContextUpdateTileId : Int64
}
struct D3D12_VIDEO_ENCODER_AV1_POST_ENCODE_VALUES {
    CompoundPredictionType : Int64
    LoopFilter : D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_CONFIG
    LoopFilterDelta : D3D12_VIDEO_ENCODER_CODEC_AV1_LOOP_FILTER_DELTA_CONFIG
    Quantization : D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_CONFIG
    QuantizationDelta : D3D12_VIDEO_ENCODER_CODEC_AV1_QUANTIZATION_DELTA_CONFIG
    CDEF : D3D12_VIDEO_ENCODER_AV1_CDEF_CONFIG
    SegmentationConfig : D3D12_VIDEO_ENCODER_AV1_SEGMENTATION_CONFIG
    PrimaryRefFrame : Int64
    ReferenceIndices : Int64[7]
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE_ABSOLUTE_QP_MAP := 0
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE_CQP := 1
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE_CBR := 2
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE_VBR := 3
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE_QVBR := 4
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_DELTA_QP := 1
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_FRAME_ANALYSIS := 2
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_QP_RANGE := 4
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_INITIAL_QP := 8
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_MAX_FRAME_SIZE := 16
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_VBV_SIZES := 32
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_EXTENSION1_SUPPORT := 64
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_QUALITY_VS_SPEED := 128
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAG_ENABLE_SPATIAL_ADAPTIVE_QP := 256
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_CQP {
    ConstantQP_FullIntracodedFrame : UInt32
    ConstantQP_InterPredictedFrame_PrevRefOnly : UInt32
    ConstantQP_InterPredictedFrame_BiDirectionalRef : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_CQP1 {
    ConstantQP_FullIntracodedFrame : UInt32
    ConstantQP_InterPredictedFrame_PrevRefOnly : UInt32
    ConstantQP_InterPredictedFrame_BiDirectionalRef : UInt32
    QualityVsSpeed : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_CBR {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetBitRate : Int64
    VBVCapacity : Int64
    InitialVBVFullness : Int64
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_CBR1 {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetBitRate : Int64
    VBVCapacity : Int64
    InitialVBVFullness : Int64
    QualityVsSpeed : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_VBR {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetAvgBitRate : Int64
    PeakBitRate : Int64
    VBVCapacity : Int64
    InitialVBVFullness : Int64
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_VBR1 {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetAvgBitRate : Int64
    PeakBitRate : Int64
    VBVCapacity : Int64
    InitialVBVFullness : Int64
    QualityVsSpeed : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_QVBR {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetAvgBitRate : Int64
    PeakBitRate : Int64
    ConstantQualityTarget : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_QVBR1 {
    InitialQP : UInt32
    MinQP : UInt32
    MaxQP : UInt32
    MaxFrameBitSize : Int64
    TargetAvgBitRate : Int64
    PeakBitRate : Int64
    ConstantQualityTarget : UInt32
    VBVCapacity : Int64
    InitialVBVFullness : Int64
    QualityVsSpeed : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_ABSOLUTE_QP_MAP {
    QualityVsSpeed : UInt32
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_CONFIGURATION_PARAMS {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pConfiguration_CQP : D3D12_VIDEO_ENCODER_RATE_CONTROL_CQP.Ptr
            pConfiguration_CBR : D3D12_VIDEO_ENCODER_RATE_CONTROL_CBR.Ptr
            pConfiguration_VBR : D3D12_VIDEO_ENCODER_RATE_CONTROL_VBR.Ptr
            pConfiguration_QVBR : D3D12_VIDEO_ENCODER_RATE_CONTROL_QVBR.Ptr
            pConfiguration_CQP1 : D3D12_VIDEO_ENCODER_RATE_CONTROL_CQP1.Ptr
            pConfiguration_CBR1 : D3D12_VIDEO_ENCODER_RATE_CONTROL_CBR1.Ptr
            pConfiguration_VBR1 : D3D12_VIDEO_ENCODER_RATE_CONTROL_VBR1.Ptr
            pConfiguration_QVBR1 : D3D12_VIDEO_ENCODER_RATE_CONTROL_QVBR1.Ptr
            pConfiguration_AbsoluteQPMap : D3D12_VIDEO_ENCODER_RATE_CONTROL_ABSOLUTE_QP_MAP.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL {
    Mode : D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE
    Flags : D3D12_VIDEO_ENCODER_RATE_CONTROL_FLAGS
    ConfigParams : D3D12_VIDEO_ENCODER_RATE_CONTROL_CONFIGURATION_PARAMS
    TargetFrameRate : DXGI_RATIONAL
}
struct D3D12_VIDEO_ENCODER_CODEC extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_H264 := 0
    static D3D12_VIDEO_ENCODER_CODEC_HEVC := 1
    static D3D12_VIDEO_ENCODER_CODEC_AV1 := 2
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_CODEC {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    IsSupported : BOOL
}
struct D3D12_VIDEO_ENCODER_PROFILE_H264 extends Int32 {
    static D3D12_VIDEO_ENCODER_PROFILE_H264_MAIN := 0
    static D3D12_VIDEO_ENCODER_PROFILE_H264_HIGH := 1
    static D3D12_VIDEO_ENCODER_PROFILE_H264_HIGH_10 := 2
}
struct D3D12_VIDEO_ENCODER_PROFILE_HEVC extends Int32 {
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN := 0
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN10 := 1
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN12 := 2
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN10_422 := 3
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN12_422 := 4
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN_444 := 5
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN10_444 := 6
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN12_444 := 7
    static D3D12_VIDEO_ENCODER_PROFILE_HEVC_MAIN16_444 := 8
}
struct D3D12_VIDEO_ENCODER_PROFILE_DESC {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264Profile : D3D12_VIDEO_ENCODER_PROFILE_H264.Ptr
            pHEVCProfile : D3D12_VIDEO_ENCODER_PROFILE_HEVC.Ptr
            pAV1Profile : D3D12_VIDEO_ENCODER_AV1_PROFILE.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_LEVELS_H264 extends Int32 {
    static D3D12_VIDEO_ENCODER_LEVELS_H264_1 := 0
    static D3D12_VIDEO_ENCODER_LEVELS_H264_1b := 1
    static D3D12_VIDEO_ENCODER_LEVELS_H264_11 := 2
    static D3D12_VIDEO_ENCODER_LEVELS_H264_12 := 3
    static D3D12_VIDEO_ENCODER_LEVELS_H264_13 := 4
    static D3D12_VIDEO_ENCODER_LEVELS_H264_2 := 5
    static D3D12_VIDEO_ENCODER_LEVELS_H264_21 := 6
    static D3D12_VIDEO_ENCODER_LEVELS_H264_22 := 7
    static D3D12_VIDEO_ENCODER_LEVELS_H264_3 := 8
    static D3D12_VIDEO_ENCODER_LEVELS_H264_31 := 9
    static D3D12_VIDEO_ENCODER_LEVELS_H264_32 := 10
    static D3D12_VIDEO_ENCODER_LEVELS_H264_4 := 11
    static D3D12_VIDEO_ENCODER_LEVELS_H264_41 := 12
    static D3D12_VIDEO_ENCODER_LEVELS_H264_42 := 13
    static D3D12_VIDEO_ENCODER_LEVELS_H264_5 := 14
    static D3D12_VIDEO_ENCODER_LEVELS_H264_51 := 15
    static D3D12_VIDEO_ENCODER_LEVELS_H264_52 := 16
    static D3D12_VIDEO_ENCODER_LEVELS_H264_6 := 17
    static D3D12_VIDEO_ENCODER_LEVELS_H264_61 := 18
    static D3D12_VIDEO_ENCODER_LEVELS_H264_62 := 19
}
struct D3D12_VIDEO_ENCODER_TIER_HEVC extends Int32 {
    static D3D12_VIDEO_ENCODER_TIER_HEVC_MAIN := 0
    static D3D12_VIDEO_ENCODER_TIER_HEVC_HIGH := 1
}
struct D3D12_VIDEO_ENCODER_LEVELS_HEVC extends Int32 {
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_1 := 0
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_2 := 1
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_21 := 2
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_3 := 3
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_31 := 4
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_4 := 5
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_41 := 6
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_5 := 7
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_51 := 8
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_52 := 9
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_6 := 10
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_61 := 11
    static D3D12_VIDEO_ENCODER_LEVELS_HEVC_62 := 12
}
struct D3D12_VIDEO_ENCODER_LEVEL_TIER_CONSTRAINTS_HEVC {
    Level : D3D12_VIDEO_ENCODER_LEVELS_HEVC
    Tier : D3D12_VIDEO_ENCODER_TIER_HEVC
}
struct D3D12_VIDEO_ENCODER_LEVEL_SETTING {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264LevelSetting : D3D12_VIDEO_ENCODER_LEVELS_H264.Ptr
            pHEVCLevelSetting : D3D12_VIDEO_ENCODER_LEVEL_TIER_CONSTRAINTS_HEVC.Ptr
            pAV1LevelSetting : D3D12_VIDEO_ENCODER_AV1_LEVEL_TIER_CONSTRAINTS.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_PROFILE_LEVEL {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    IsSupported : BOOL
    MinSupportedLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    MaxSupportedLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
}
struct D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC {
    Width : UInt32
    Height : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_RATIO_DESC {
    WidthRatio : UInt32
    HeightRatio : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_OUTPUT_RESOLUTION_RATIOS_COUNT {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    ResolutionRatiosCount : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_OUTPUT_RESOLUTION {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    ResolutionRatiosCount : UInt32
    IsSupported : BOOL
    MinResolutionSupported : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    MaxResolutionSupported : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    ResolutionWidthMultipleRequirement : UInt32
    ResolutionHeightMultipleRequirement : UInt32
    pResolutionRatios : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_RATIO_DESC.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_INPUT_FORMAT {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Format : DXGI_FORMAT
    IsSupported : BOOL
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RATE_CONTROL_MODE {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    RateControlMode : D3D12_VIDEO_ENCODER_RATE_CONTROL_MODE
    IsSupported : BOOL
}
struct D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE_NONE := 0
    static D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE_ROW_BASED := 1
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_INTRA_REFRESH_MODE {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Level : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    IntraRefreshMode : D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE
    IsSupported : BOOL
}
struct D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_FULL_FRAME := 0
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_BYTES_PER_SUBREGION := 1
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_SQUARE_UNITS_PER_SUBREGION_ROW_UNALIGNED := 2
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_UNIFORM_PARTITIONING_ROWS_PER_SUBREGION := 3
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_UNIFORM_PARTITIONING_SUBREGIONS_PER_FRAME := 4
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_UNIFORM_GRID_PARTITION := 5
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_CONFIGURABLE_GRID_PARTITION := 6
    static D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE_AUTO := 7
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Level : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    SubregionMode : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    IsSupported : BOOL
}
struct D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_NOT_SPECIFIED := 1
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_CODEC_CONSTRAINT := 2
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_HARDWARE_CONSTRAINT := 4
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_ROWS_COUNT := 8
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_COLS_COUNT := 16
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_WIDTH := 32
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_AREA := 64
    static D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAG_TOTAL_TILES := 128
}
struct D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_SUPPORT {
    Use128SuperBlocks : BOOL
    TilesConfiguration : D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_TILES
    ValidationFlags : D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_VALIDATION_FLAGS
    MinTileRows : UInt32
    MaxTileRows : UInt32
    MinTileCols : UInt32
    MaxTileCols : UInt32
    MinTileWidth : UInt32
    MaxTileWidth : UInt32
    MinTileArea : UInt32
    MaxTileArea : UInt32
    TileSizeBytesMinus1 : UInt32
}
struct D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_CONFIG_SUPPORT {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pAV1Support : D3D12_VIDEO_ENCODER_AV1_FRAME_SUBREGION_LAYOUT_CONFIG_SUPPORT.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_CONFIG {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Level : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    SubregionMode : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    FrameResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    CodecSupport : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_CONFIG_SUPPORT
    IsSupported : BOOL
}
struct D3D12_VIDEO_ENCODER_HEAP_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_HEAP_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_HEAP_FLAG_ALLOW_SUBREGION_NOTIFICATION_ARRAY_OF_BUFFERS := 1
    static D3D12_VIDEO_ENCODER_HEAP_FLAG_ALLOW_SUBREGION_NOTIFICATION_SINGLE_BUFFER := 2
    static D3D12_VIDEO_ENCODER_HEAP_FLAG_ALLOW_DIRTY_REGIONS := 4
    static D3D12_VIDEO_ENCODER_HEAP_FLAG_ALLOW_RATE_CONTROL_FRAME_ANALYSIS := 8
}
struct D3D12_VIDEO_ENCODER_HEAP_DESC {
    NodeMask : UInt32
    Flags : D3D12_VIDEO_ENCODER_HEAP_FLAGS
    EncodeCodec : D3D12_VIDEO_ENCODER_CODEC
    EncodeProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    EncodeLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    ResolutionsListCount : UInt32
    pResolutionList : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_HEAP_SIZE {
    HeapDesc : D3D12_VIDEO_ENCODER_HEAP_DESC
    IsSupported : BOOL
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_CABAC_ENCODING_SUPPORT := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_INTRA_SLICE_CONSTRAINED_ENCODING_SUPPORT := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_BFRAME_LTR_COMBINED_SUPPORT := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_ADAPTIVE_8x8_TRANSFORM_ENCODING_SUPPORT := 8
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_DIRECT_SPATIAL_ENCODING_SUPPORT := 16
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_DIRECT_TEMPORAL_ENCODING_SUPPORT := 32
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_CONSTRAINED_INTRAPREDICTION_SUPPORT := 64
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAG_NUM_REF_IDX_ACTIVE_OVERRIDE_FLAG_SLICE_SUPPORT := 128
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODES extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_0_ALL_LUMA_CHROMA_SLICE_BLOCK_EDGES_ALWAYS_FILTERED := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_1_DISABLE_ALL_SLICE_BLOCK_EDGES := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_2_DISABLE_SLICE_BOUNDARIES_BLOCKS := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_3_USE_TWO_STAGE_DEBLOCKING := 3
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_4_DISABLE_CHROMA_BLOCK_EDGES := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_5_DISABLE_CHROMA_BLOCK_EDGES_AND_LUMA_BOUNDARIES := 5
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_6_DISABLE_CHROMA_BLOCK_EDGES_AND_USE_LUMA_TWO_STAGE_DEBLOCKING := 6
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_0_ALL_LUMA_CHROMA_SLICE_BLOCK_EDGES_ALWAYS_FILTERED := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_1_DISABLE_ALL_SLICE_BLOCK_EDGES := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_2_DISABLE_SLICE_BOUNDARIES_BLOCKS := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_3_USE_TWO_STAGE_DEBLOCKING := 8
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_4_DISABLE_CHROMA_BLOCK_EDGES := 16
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_5_DISABLE_CHROMA_BLOCK_EDGES_AND_LUMA_BOUNDARIES := 32
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAG_6_DISABLE_CHROMA_BLOCK_EDGES_AND_USE_LUMA_TWO_STAGE_DEBLOCKING := 64
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264 {
    SupportFlags : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264_FLAGS
    DisableDeblockingFilterSupportedModes : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODE_FLAGS
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_BFRAME_LTR_COMBINED_SUPPORT := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_INTRA_SLICE_CONSTRAINED_ENCODING_SUPPORT := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CONSTRAINED_INTRAPREDICTION_SUPPORT := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_SAO_FILTER_SUPPORT := 8
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_ASYMETRIC_MOTION_PARTITION_SUPPORT := 16
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_ASYMETRIC_MOTION_PARTITION_REQUIRED := 32
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_TRANSFORM_SKIP_SUPPORT := 64
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_DISABLING_LOOP_FILTER_ACROSS_SLICES_SUPPORT := 128
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_P_FRAMES_IMPLEMENTED_AS_LOW_DELAY_B_FRAMES := 256
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_NUM_REF_IDX_ACTIVE_OVERRIDE_FLAG_SLICE_SUPPORT := 512
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_TRANSFORM_SKIP_ROTATION_ENABLED_SUPPORT := 1024
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_TRANSFORM_SKIP_ROTATION_ENABLED_REQUIRED := 2048
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_TRANSFORM_SKIP_CONTEXT_ENABLED_SUPPORT := 4096
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_TRANSFORM_SKIP_CONTEXT_ENABLED_REQUIRED := 8192
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_IMPLICIT_RDPCM_ENABLED_SUPPORT := 16384
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_IMPLICIT_RDPCM_ENABLED_REQUIRED := 32768
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_EXPLICIT_RDPCM_ENABLED_SUPPORT := 65536
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_EXPLICIT_RDPCM_ENABLED_REQUIRED := 131072
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_EXTENDED_PRECISION_PROCESSING_SUPPORT := 262144
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_EXTENDED_PRECISION_PROCESSING_REQUIRED := 524288
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_INTRA_SMOOTHING_DISABLED_SUPPORT := 1048576
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_INTRA_SMOOTHING_DISABLED_REQUIRED := 2097152
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_HIGH_PRECISION_OFFSETS_ENABLED_SUPPORT := 4194304
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_HIGH_PRECISION_OFFSETS_ENABLED_REQUIRED := 8388608
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_PERSISTENT_RICE_ADAPTATION_ENABLED_SUPPORT := 16777216
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_PERSISTENT_RICE_ADAPTATION_ENABLED_REQUIRED := 33554432
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CABAC_BYPASS_ALIGNMENT_ENABLED_SUPPORT := 67108864
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CABAC_BYPASS_ALIGNMENT_ENABLED_REQUIRED := 134217728
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CROSS_COMPONENT_PREDICTION_ENABLED_FLAG_SUPPORT := 268435456
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CROSS_COMPONENT_PREDICTION_ENABLED_FLAG_REQUIRED := 536870912
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CHROMA_QP_OFFSET_LIST_ENABLED_FLAG_SUPPORT := 1073741824
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG_CHROMA_QP_OFFSET_LIST_ENABLED_FLAG_REQUIRED := -2147483648
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE_8x8 := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE_16x16 := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE_32x32 := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE_64x64 := 3
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE_4x4 := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE_8x8 := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE_16x16 := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE_32x32 := 3
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC {
    SupportFlags : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAGS
    MinLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MaxLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MinLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    MaxLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    max_transform_hierarchy_depth_inter : UInt8
    max_transform_hierarchy_depth_intra : UInt8
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAGS1 extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_SEPARATE_COLOUR_PLANE_SUPPORT := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_SEPARATE_COLOUR_PLANE_REQUIRED := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_TEMPORAL_MVP_ENABLED_SUPPORT := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_TEMPORAL_MVP_ENABLED_REQUIRED := 8
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_STRONG_INTRA_SMOOTHING_ENABLED_SUPPORT := 16
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAG1_STRONG_INTRA_SMOOTHING_ENABLED_REQUIRED := 32
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC1 {
    SupportFlags : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAGS
    MinLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MaxLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MinLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    MaxLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    max_transform_hierarchy_depth_inter : UInt8
    max_transform_hierarchy_depth_intra : UInt8
    allowed_diff_cu_chroma_qp_offset_depth_values : UInt32
    allowed_log2_sao_offset_scale_luma_values : UInt32
    allowed_log2_sao_offset_scale_chroma_values : UInt32
    allowed_log2_max_transform_skip_block_size_minus2_values : UInt32
    allowed_chroma_qp_offset_list_len_minus1_values : UInt32
    allowed_cb_qp_offset_list_values : UInt32[6]
    allowed_cr_qp_offset_list_values : UInt32[6]
    SupportFlags1 : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC_FLAGS1
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264Support : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_H264.Ptr
            pHEVCSupport : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC.Ptr
            pHEVCSupport1 : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT_HEVC1.Ptr
            pAV1Support : D3D12_VIDEO_ENCODER_AV1_CODEC_CONFIGURATION_SUPPORT.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    IsSupported : BOOL
    CodecSupportLimits : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_SUPPORT
}
struct D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT_H264 {
    MaxL0ReferencesForP : UInt32
    MaxL0ReferencesForB : UInt32
    MaxL1ReferencesForB : UInt32
    MaxLongTermReferences : UInt32
    MaxDPBCapacity : UInt32
}
struct D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT_HEVC {
    MaxL0ReferencesForP : UInt32
    MaxL0ReferencesForB : UInt32
    MaxL1ReferencesForB : UInt32
    MaxLongTermReferences : UInt32
    MaxDPBCapacity : UInt32
}
struct D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264Support : D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT_H264.Ptr
            pHEVCSupport : D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT_HEVC.Ptr
            pAV1Support : D3D12_VIDEO_ENCODER_CODEC_AV1_PICTURE_CONTROL_SUPPORT.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    IsSupported : BOOL
    PictureSupport : D3D12_VIDEO_ENCODER_CODEC_PICTURE_CONTROL_SUPPORT
}
struct D3D12_VIDEO_ENCODER_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_GENERAL_SUPPORT_OK := 1
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_RECONFIGURATION_AVAILABLE := 2
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RESOLUTION_RECONFIGURATION_AVAILABLE := 4
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_VBV_SIZE_CONFIG_AVAILABLE := 8
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_FRAME_ANALYSIS_AVAILABLE := 16
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RECONSTRUCTED_FRAMES_REQUIRE_TEXTURE_ARRAYS := 32
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_DELTA_QP_AVAILABLE := 64
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_SUBREGION_LAYOUT_RECONFIGURATION_AVAILABLE := 128
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_ADJUSTABLE_QP_RANGE_AVAILABLE := 256
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_INITIAL_QP_AVAILABLE := 512
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_MAX_FRAME_SIZE_AVAILABLE := 1024
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_SEQUENCE_GOP_RECONFIGURATION_AVAILABLE := 2048
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_MOTION_ESTIMATION_PRECISION_MODE_LIMIT_AVAILABLE := 4096
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_EXTENSION1_SUPPORT := 8192
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_QUALITY_VS_SPEED_AVAILABLE := 16384
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_READABLE_RECONSTRUCTED_PICTURE_LAYOUT_AVAILABLE := 32768
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_PER_BLOCK_QP_MAP_METADATA_AVAILABLE := 65536
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_PER_BLOCK_SATD_MAP_METADATA_AVAILABLE := 131072
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_PER_BLOCK_RC_BIT_ALLOCATION_MAP_METADATA_AVAILABLE := 262144
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_SUBREGION_NOTIFICATION_ARRAY_OF_BUFFERS_AVAILABLE := 524288
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_SUBREGION_NOTIFICATION_SINGLE_BUFFER_AVAILABLE := 1048576
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_FRAME_PSNR_METADATA_AVAILABLE := 2097152
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_SUBREGIONS_PSNR_METADATA_AVAILABLE := 4194304
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_RATE_CONTROL_SPATIAL_ADAPTIVE_QP_AVAILABLE := 8388608
    static D3D12_VIDEO_ENCODER_SUPPORT_FLAG_INTRA_REFRESH_NO_SUBREGION_LAYOUT_CONSTRAINTS_AVAILABLE := 16777216
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAG_USE_CONSTRAINED_INTRAPREDICTION := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAG_USE_ADAPTIVE_8x8_TRANSFORM := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAG_ENABLE_CABAC_ENCODING := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAG_ALLOW_REQUEST_INTRA_CONSTRAINED_SLICES := 8
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_DIRECT_MODES extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_DIRECT_MODES_DISABLED := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_DIRECT_MODES_TEMPORAL := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_DIRECT_MODES_SPATIAL := 2
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264 {
    ConfigurationFlags : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_FLAGS
    DirectModeConfig : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_DIRECT_MODES
    DisableDeblockingFilterConfig : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264_SLICES_DEBLOCKING_MODES
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_DISABLE_LOOP_FILTER_ACROSS_SLICES := 1
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_ALLOW_REQUEST_INTRA_CONSTRAINED_SLICES := 2
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_ENABLE_SAO_FILTER := 4
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_ENABLE_LONG_TERM_REFERENCES := 8
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_USE_ASYMETRIC_MOTION_PARTITION := 16
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_ENABLE_TRANSFORM_SKIPPING := 32
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_USE_CONSTRAINED_INTRAPREDICTION := 64
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_TRANSFORM_SKIP_ROTATION := 128
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_TRANSFORM_SKIP_CONTEXT := 256
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_IMPLICIT_RDPCM := 512
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_EXPLICIT_RDPCM := 1024
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_EXTENDED_PRECISION_PROCESSING := 2048
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_INTRA_SMOOTHING_DISABLED := 4096
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_HIGH_PRECISION_OFFSETS := 8192
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_PERSISTENT_RICE_ADAPTATION := 16384
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_CABAC_BYPASS_ALIGNMENT := 32768
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_SEPARATE_COLOUR_PLANE := 65536
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_TEMPORAL_MVP_ENABLED := 131072
    static D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAG_STRONG_INTRA_SMOOTHING_ENABLED := 262144
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC {
    ConfigurationFlags : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_FLAGS
    MinLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MaxLumaCodingUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_CUSIZE
    MinLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    MaxLumaTransformUnitSize : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC_TUSIZE
    max_transform_hierarchy_depth_inter : UInt8
    max_transform_hierarchy_depth_intra : UInt8
}
struct D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264Config : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_H264.Ptr
            pHEVCConfig : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION_HEVC.Ptr
            pAV1Config : D3D12_VIDEO_ENCODER_AV1_CODEC_CONFIGURATION.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_INTRA_REFRESH {
    Mode : D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE
    IntraRefreshDuration : UInt32
}
struct D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE_MAXIMUM := 0
    static D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE_FULL_PIXEL := 1
    static D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE_HALF_PIXEL := 2
    static D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE_QUARTER_PIXEL := 3
    static D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE_EIGHTH_PIXEL := 4
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_LIMITS {
    MaxSubregionsNumber : UInt32
    MaxIntraRefreshFrameDuration : UInt32
    SubregionBlockPixelsSize : UInt32
    QPMapRegionPixelsSize : UInt32
}
struct D3D12_VIDEO_ENCODER_VALIDATION_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_CODEC_NOT_SUPPORTED := 1
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_INPUT_FORMAT_NOT_SUPPORTED := 8
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_CODEC_CONFIGURATION_NOT_SUPPORTED := 16
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_RATE_CONTROL_MODE_NOT_SUPPORTED := 32
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_RATE_CONTROL_CONFIGURATION_NOT_SUPPORTED := 64
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_INTRA_REFRESH_MODE_NOT_SUPPORTED := 128
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_SUBREGION_LAYOUT_MODE_NOT_SUPPORTED := 256
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_RESOLUTION_NOT_SUPPORTED_IN_LIST := 512
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_GOP_STRUCTURE_NOT_SUPPORTED := 2048
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_SUBREGION_LAYOUT_DATA_NOT_SUPPORTED := 4096
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_QPMAP_NOT_SUPPORTED := 8192
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_DIRTY_REGIONS_NOT_SUPPORTED := 16384
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_MOTION_SEARCH_NOT_SUPPORTED := 32768
    static D3D12_VIDEO_ENCODER_VALIDATION_FLAG_FRAME_ANALYSIS_NOT_SUPPORTED := 65536
}
struct D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE_H264 {
    GOPLength : UInt32
    PPicturePeriod : UInt32
    pic_order_cnt_type : UInt8
    log2_max_frame_num_minus4 : UInt8
    log2_max_pic_order_cnt_lsb_minus4 : UInt8
}
struct D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE_HEVC {
    GOPLength : UInt32
    PPicturePeriod : UInt32
    log2_max_pic_order_cnt_lsb_minus4 : UInt8
}
struct D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264GroupOfPictures : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE_H264.Ptr
            pHEVCGroupOfPictures : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE_HEVC.Ptr
            pAV1SequenceStructure : D3D12_VIDEO_ENCODER_AV1_SEQUENCE_STRUCTURE.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_SUPPORT {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    InputFormat : DXGI_FORMAT
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    CodecGopSequence : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE
    RateControl : D3D12_VIDEO_ENCODER_RATE_CONTROL
    IntraRefresh : D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE
    SubregionFrameEncoding : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    ResolutionsListCount : UInt32
    pResolutionList : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr
    MaxReferenceFramesInDPB : UInt32
    ValidationFlags : D3D12_VIDEO_ENCODER_VALIDATION_FLAGS
    SupportFlags : D3D12_VIDEO_ENCODER_SUPPORT_FLAGS
    SuggestedProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    SuggestedLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    pResolutionDependentSupport : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_LIMITS.Ptr
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_SLICES {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MaxBytesPerSlice : UInt32
            NumberOfCodingUnitsPerSlice : UInt32
            NumberOfRowsPerSlice : UInt32
            NumberOfSlicesPerFrame : UInt32
        }
    }
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pSlicesPartition_H264 : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_SLICES.Ptr
            pSlicesPartition_HEVC : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_SLICES.Ptr
            pTilesPartition_AV1 : D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA_TILES.Ptr
        }
    }
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_SUPPORT1 {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    InputFormat : DXGI_FORMAT
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    CodecGopSequence : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE
    RateControl : D3D12_VIDEO_ENCODER_RATE_CONTROL
    IntraRefresh : D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE
    SubregionFrameEncoding : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    ResolutionsListCount : UInt32
    pResolutionList : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr
    MaxReferenceFramesInDPB : UInt32
    ValidationFlags : D3D12_VIDEO_ENCODER_VALIDATION_FLAGS
    SupportFlags : D3D12_VIDEO_ENCODER_SUPPORT_FLAGS
    SuggestedProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    SuggestedLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    pResolutionDependentSupport : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_LIMITS.Ptr
    SubregionFrameEncodingData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA
    MaxQualityVsSpeed : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOURCE_REQUIREMENTS {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    InputFormat : DXGI_FORMAT
    PictureTargetResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    IsSupported : BOOL
    CompressedBitstreamBufferAccessAlignment : UInt32
    EncoderMetadataBufferAccessAlignment : UInt32
    MaxEncoderOutputMetadataBufferSize : UInt32
}
struct D3D12_VIDEO_ENCODER_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_FLAG_NONE := 0
}
struct D3D12_VIDEO_ENCODER_DESC {
    NodeMask : UInt32
    Flags : D3D12_VIDEO_ENCODER_FLAGS
    EncodeCodec : D3D12_VIDEO_ENCODER_CODEC
    EncodeProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    InputFormat : DXGI_FORMAT
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    MaxMotionEstimationPrecision : D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE
}
struct ID3D12VideoEncoder extends ID3D12Pageable {
    static IID := "{2E0D212D-8DF9-44A6-A770-BB289B182737}"
    GetNodeMask()
      => ComCall(8, this.p, UInt32)
    GetEncoderFlags()
      => ComCall(9, this.p, D3D12_VIDEO_ENCODER_FLAGS)
    GetCodec()
      => ComCall(10, this.p, D3D12_VIDEO_ENCODER_CODEC)
    GetCodecProfile(dstProfile)
      => ComCall(11, this.p, D3D12_VIDEO_ENCODER_PROFILE_DESC, dstProfile)
    GetCodecConfiguration(dstCodecConfig)
      => ComCall(12, this.p, D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION, dstCodecConfig)
    GetInputFormat()
      => ComCall(13, this.p, DXGI_FORMAT)
    GetMaxMotionEstimationPrecision()
      => ComCall(14, this.p, D3D12_VIDEO_ENCODER_MOTION_ESTIMATION_PRECISION_MODE)
}
struct ID3D12VideoEncoderHeap extends ID3D12Pageable {
    static IID := "{22B35D96-876A-44C0-B25E-FB8C9C7F1C4A}"
    GetNodeMask()
      => ComCall(8, this.p, UInt32)
    GetEncoderHeapFlags()
      => ComCall(9, this.p, D3D12_VIDEO_ENCODER_HEAP_FLAGS)
    GetCodec()
      => ComCall(10, this.p, D3D12_VIDEO_ENCODER_CODEC)
    GetCodecProfile(dstProfile)
      => ComCall(11, this.p, D3D12_VIDEO_ENCODER_PROFILE_DESC, dstProfile)
    GetCodecLevel(dstLevel)
      => ComCall(12, this.p, D3D12_VIDEO_ENCODER_LEVEL_SETTING, dstLevel)
    GetResolutionListCount()
      => ComCall(13, this.p, UInt32)
    GetResolutionList(pResolutionList)
      => ComCall(14, this.p, UInt32, pResolutionList.Length, D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr, pResolutionList)
}
struct ID3D12VideoDevice3 extends ID3D12VideoDevice2 {
    static IID := "{4243ADB4-3A32-4666-973C-0CCC5625DC44}"
    CreateVideoEncoder(pDesc, riid, ppVideoEncoder)
      => ComCall(14, this.p, D3D12_VIDEO_ENCODER_DESC.Ptr, pDesc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoEncoder)
    CreateVideoEncoderHeap(pDesc, riid, ppVideoEncoderHeap)
      => ComCall(15, this.p, D3D12_VIDEO_ENCODER_HEAP_DESC.Ptr, pDesc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoEncoderHeap)
}
struct D3D12_VIDEO_ENCODER_FRAME_TYPE_H264 extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_H264_I_FRAME := 0
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_H264_P_FRAME := 1
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_H264_B_FRAME := 2
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_H264_IDR_FRAME := 3
}
struct D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_H264 {
    ReconstructedPictureResourceIndex : UInt32
    IsLongTermReference : BOOL
    LongTermPictureIdx : UInt32
    PictureOrderCountNumber : UInt32
    FrameDecodingOrderNumber : UInt32
    TemporalLayerIndex : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_FLAG_REQUEST_INTRA_CONSTRAINED_SLICES := 1
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_FLAG_REQUEST_NUM_REF_IDX_ACTIVE_OVERRIDE_FLAG_SLICE := 2
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_REFERENCE_PICTURE_MARKING_OPERATION {
    memory_management_control_operation : UInt8
    difference_of_pic_nums_minus1 : UInt32
    long_term_pic_num : UInt32
    long_term_frame_idx : UInt32
    max_long_term_frame_idx_plus1 : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_REFERENCE_PICTURE_LIST_MODIFICATION_OPERATION {
    modification_of_pic_nums_idc : UInt8
    abs_diff_pic_num_minus1 : UInt32
    long_term_pic_num : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264 {
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_FLAGS
    FrameType : D3D12_VIDEO_ENCODER_FRAME_TYPE_H264
    pic_parameter_set_id : UInt32
    idr_pic_id : UInt32
    PictureOrderCountNumber : UInt32
    FrameDecodingOrderNumber : UInt32
    TemporalLayerIndex : UInt32
    List0ReferenceFramesCount : UInt32
    pList0ReferenceFrames : UInt32.Ptr
    List1ReferenceFramesCount : UInt32
    pList1ReferenceFrames : UInt32.Ptr
    ReferenceFramesReconPictureDescriptorsCount : UInt32
    pReferenceFramesReconPictureDescriptors : D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_H264.Ptr
    adaptive_ref_pic_marking_mode_flag : UInt8
    RefPicMarkingOperationsCommandsCount : UInt32
    pRefPicMarkingOperationsCommands : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_REFERENCE_PICTURE_MARKING_OPERATION.Ptr
    List0RefPicModificationsCount : UInt32
    pList0RefPicModifications : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_REFERENCE_PICTURE_LIST_MODIFICATION_OPERATION.Ptr
    List1RefPicModificationsCount : UInt32
    pList1RefPicModifications : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264_REFERENCE_PICTURE_LIST_MODIFICATION_OPERATION.Ptr
    QPMapValuesCount : UInt32
    pRateControlQPMap : Int8.Ptr
}
struct D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC_I_FRAME := 0
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC_P_FRAME := 1
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC_B_FRAME := 2
    static D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC_IDR_FRAME := 3
}
struct D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_HEVC {
    ReconstructedPictureResourceIndex : UInt32
    IsRefUsedByCurrentPic : BOOL
    IsLongTermReference : BOOL
    PictureOrderCountNumber : UInt32
    TemporalLayerIndex : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAG_REQUEST_INTRA_CONSTRAINED_SLICES := 1
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAG_REQUEST_NUM_REF_IDX_ACTIVE_OVERRIDE_FLAG_SLICE := 2
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAG_CROSS_COMPONENT_PREDICTION := 4
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAG_CHROMA_QP_OFFSET_LIST := 8
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC {
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAGS
    FrameType : D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC
    slice_pic_parameter_set_id : UInt32
    PictureOrderCountNumber : UInt32
    TemporalLayerIndex : UInt32
    List0ReferenceFramesCount : UInt32
    pList0ReferenceFrames : UInt32.Ptr
    List1ReferenceFramesCount : UInt32
    pList1ReferenceFrames : UInt32.Ptr
    ReferenceFramesReconPictureDescriptorsCount : UInt32
    pReferenceFramesReconPictureDescriptors : D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_HEVC.Ptr
    List0RefPicModificationsCount : UInt32
    pList0RefPicModifications : UInt32.Ptr
    List1RefPicModificationsCount : UInt32
    pList1RefPicModifications : UInt32.Ptr
    QPMapValuesCount : UInt32
    pRateControlQPMap : Int8.Ptr
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC1 {
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAGS
    FrameType : D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC
    slice_pic_parameter_set_id : UInt32
    PictureOrderCountNumber : UInt32
    TemporalLayerIndex : UInt32
    List0ReferenceFramesCount : UInt32
    pList0ReferenceFrames : UInt32.Ptr
    List1ReferenceFramesCount : UInt32
    pList1ReferenceFrames : UInt32.Ptr
    ReferenceFramesReconPictureDescriptorsCount : UInt32
    pReferenceFramesReconPictureDescriptors : D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_HEVC.Ptr
    List0RefPicModificationsCount : UInt32
    pList0RefPicModifications : UInt32.Ptr
    List1RefPicModificationsCount : UInt32
    pList1RefPicModifications : UInt32.Ptr
    QPMapValuesCount : UInt32
    pRateControlQPMap : Int8.Ptr
    diff_cu_chroma_qp_offset_depth : UInt8
    log2_sao_offset_scale_luma : UInt8
    log2_sao_offset_scale_chroma : UInt8
    log2_max_transform_skip_block_size_minus2 : UInt8
    chroma_qp_offset_list_len_minus1 : UInt8
    cb_qp_offset_list : CHAR[6]
    cr_qp_offset_list : CHAR[6]
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264PicData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264.Ptr
            pHEVCPicData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC.Ptr
            pHEVCPicData1 : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC1.Ptr
            pAV1PicData : D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_CODEC_DATA.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODE_REFERENCE_FRAMES {
    NumTexture2Ds : UInt32
    ppTexture2Ds : ID3D12Resource.Ptr
    pSubresources : UInt32.Ptr
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAG_USED_AS_REFERENCE_PICTURE := 1
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAG_ENABLE_QUANTIZATION_MATRIX_INPUT := 2
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAG_ENABLE_DIRTY_REGIONS_INPUT := 4
    static D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAG_ENABLE_MOTION_VECTORS_INPUT := 8
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_DESC {
    IntraRefreshFrameIndex : UInt32
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAGS
    PictureControlCodecData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA
    ReferenceFrames : D3D12_VIDEO_ENCODE_REFERENCE_FRAMES
}
struct D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_RESOLUTION_CHANGE := 1
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_RATE_CONTROL_CHANGE := 2
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_SUBREGION_LAYOUT_CHANGE := 4
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_REQUEST_INTRA_REFRESH := 8
    static D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAG_GOP_SEQUENCE_CHANGE := 16
}
struct D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_DESC {
    Flags : D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_FLAGS
    IntraRefreshConfig : D3D12_VIDEO_ENCODER_INTRA_REFRESH
    RateControl : D3D12_VIDEO_ENCODER_RATE_CONTROL
    PictureTargetResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    SelectedLayoutMode : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    FrameSubregionsLayoutData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA
    CodecGopSequence : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE
}
struct D3D12_VIDEO_ENCODER_ENCODEFRAME_INPUT_ARGUMENTS {
    SequenceControlDesc : D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_DESC
    PictureControlDesc : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_DESC
    pInputFrame : ID3D12Resource
    InputFrameSubresource : UInt32
    CurrentFrameBitstreamMetadataSize : UInt32
}
struct D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM {
    pBuffer : ID3D12Resource
    FrameStartOffset : Int64
}
struct D3D12_VIDEO_ENCODER_RECONSTRUCTED_PICTURE {
    pReconstructedPicture : ID3D12Resource
    ReconstructedPictureSubresource : UInt32
}
struct D3D12_VIDEO_ENCODER_FRAME_SUBREGION_METADATA {
    bSize : Int64
    bStartOffset : Int64
    bHeaderSize : Int64
}
struct D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_NO_ERROR := 0
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_CODEC_PICTURE_CONTROL_NOT_SUPPORTED := 1
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_SUBREGION_LAYOUT_CONFIGURATION_NOT_SUPPORTED := 2
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_INVALID_REFERENCE_PICTURES := 4
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_RECONFIGURATION_REQUEST_NOT_SUPPORTED := 8
    static D3D12_VIDEO_ENCODER_ENCODE_ERROR_FLAG_INVALID_METADATA_BUFFER_SOURCE := 16
}
struct D3D12_VIDEO_ENCODER_OUTPUT_METADATA_STATISTICS {
    AverageQP : Int64
    IntraCodingUnitsCount : Int64
    InterCodingUnitsCount : Int64
    SkipCodingUnitsCount : Int64
    AverageMotionEstimationXDirection : Int64
    AverageMotionEstimationYDirection : Int64
}
struct D3D12_VIDEO_ENCODER_OUTPUT_METADATA {
    EncodeErrorFlags : Int64
    EncodeStats : D3D12_VIDEO_ENCODER_OUTPUT_METADATA_STATISTICS
    EncodedBitstreamWrittenBytesCount : Int64
    WrittenSubregionsCount : Int64
}
struct D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER {
    pBuffer : ID3D12Resource
    Offset : Int64
}
struct D3D12_VIDEO_ENCODER_RESOLVE_METADATA_INPUT_ARGUMENTS {
    EncoderCodec : D3D12_VIDEO_ENCODER_CODEC
    EncoderProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    EncoderInputFormat : DXGI_FORMAT
    EncodedPictureEffectiveResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    HWLayoutMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
}
struct D3D12_VIDEO_ENCODER_RESOLVE_METADATA_OUTPUT_ARGUMENTS {
    ResolvedLayoutMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
}
struct D3D12_VIDEO_ENCODER_ENCODEFRAME_OUTPUT_ARGUMENTS {
    Bitstream : D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM
    ReconstructedPicture : D3D12_VIDEO_ENCODER_RECONSTRUCTED_PICTURE
    EncoderOutputMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
}
struct ID3D12VideoEncodeCommandList2 extends ID3D12VideoEncodeCommandList1 {
    static IID := "{895491E2-E701-46A9-9A1F-8D3480ED867A}"
    EncodeFrame(pEncoder, pHeap, pInputArguments, pOutputArguments)
      => ComCall(27, this.p, ID3D12VideoEncoder, pEncoder, ID3D12VideoEncoderHeap, pHeap, D3D12_VIDEO_ENCODER_ENCODEFRAME_INPUT_ARGUMENTS.Ptr, pInputArguments, D3D12_VIDEO_ENCODER_ENCODEFRAME_OUTPUT_ARGUMENTS.Ptr, pOutputArguments, "void")
    ResolveEncoderOutputMetadata(pInputArguments, pOutputArguments)
      => ComCall(28, this.p, D3D12_VIDEO_ENCODER_RESOLVE_METADATA_INPUT_ARGUMENTS.Ptr, pInputArguments, D3D12_VIDEO_ENCODER_RESOLVE_METADATA_OUTPUT_ARGUMENTS.Ptr, pOutputArguments, "void")
}
struct ID3D12VideoEncodeCommandList3 extends ID3D12VideoEncodeCommandList2 {
    static IID := "{7F027B22-1515-4E85-AA0D-026486580576}"
    Barrier(pBarrierGroups)
      => ComCall(29, this.p, UInt32, pBarrierGroups.Length, D3D12_BARRIER_GROUP.Ptr, pBarrierGroups, "void")
}
struct D3D12_VIDEO_ENCODER_HEAP_DESC1 {
    NodeMask : UInt32
    Flags : D3D12_VIDEO_ENCODER_HEAP_FLAGS
    EncodeCodec : D3D12_VIDEO_ENCODER_CODEC
    EncodeProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    EncodeLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    ResolutionsListCount : UInt32
    pResolutionList : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr
    Pow2DownscaleFactor : UInt32
}
struct ID3D12VideoEncoderHeap1 extends ID3D12VideoEncoderHeap {
    static IID := "{EA8F1968-4AA0-43A4-9D30-BA86EC84D4F9}"
    GetPow2DownscaleFactor()
      => ComCall(15, this.p, UInt32)
}
struct ID3D12VideoDevice4 extends ID3D12VideoDevice3 {
    static IID := "{E59AD09E-F1AE-42BB-8983-9F6E5586C4EB}"
    CreateVideoEncoderHeap1(pDesc, riid, ppVideoEncoderHeap)
      => ComCall(16, this.p, D3D12_VIDEO_ENCODER_HEAP_DESC1.Ptr, pDesc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppVideoEncoderHeap)
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_HEAP_SIZE1 {
    HeapDesc : D3D12_VIDEO_ENCODER_HEAP_DESC1
    IsSupported : BOOL
    MemoryPoolL0Size : Int64
    MemoryPoolL1Size : Int64
}
struct D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_QP_MAP := 1
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_SATD_MAP := 2
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_RC_BIT_ALLOCATION_MAP := 4
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_FRAME_PSNR := 8
    static D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAG_SUBREGIONS_PSNR := 16
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOURCE_REQUIREMENTS1 {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    InputFormat : DXGI_FORMAT
    PictureTargetResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    IsSupported : BOOL
    CompressedBitstreamBufferAccessAlignment : UInt32
    EncoderMetadataBufferAccessAlignment : UInt32
    MaxEncoderOutputMetadataBufferSize : UInt32
    OptionalMetadata : D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAGS
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    EncoderOutputMetadataQPMapTextureDimensions : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    EncoderOutputMetadataSATDMapTextureDimensions : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    EncoderOutputMetadataBitAllocationMapTextureDimensions : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    EncoderOutputMetadataFramePSNRComponentsNumber : UInt32
    EncoderOutputMetadataSubregionsPSNRComponentsNumber : UInt32
    EncoderOutputMetadataSubregionsPSNRResolvedMetadataBufferSize : UInt32
}
struct D3D12_VIDEO_ENCODER_RESOLVE_METADATA_OUTPUT_PSNR_RESOLVED_LAYOUT {
    PSNRY : Float32
    PSNRU : Float32
    PSNRV : Float32
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE extends Int32 {
    static D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE_CPU_BUFFER := 0
    static D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE_GPU_TEXTURE := 1
}
struct D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE_DIRTY := 0
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE_SKIP := 1
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO {
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Level : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    InputFormat : DXGI_FORMAT
    InputResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    SubregionFrameEncoding : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    SubregionFrameEncodingData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE extends Int32 {
    static D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE_QUANTIZATION_MATRIX := 0
    static D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE_DIRTY_REGIONS := 1
    static D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE_MOTION_VECTORS := 2
}
struct D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_FULL_SEARCH := 0
    static D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_START_HINT := 1
    static D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_START_HINT_LIMITED_DISTANCE := 2
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_QPMAP_INPUT {
    NodeIndex : UInt32
    SessionInfo : D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    IsSupported : BOOL
    MapSourcePreferenceRanking : UInt32
    BlockSize : UInt32
}
struct D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAG_REPEAT_FRAME := 1
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAG_DIRTY_REGIONS := 2
    static D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAG_DIRTY_REGIONS_REQUIRE_FULL_ROW := 4
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_DIRTY_REGIONS {
    NodeIndex : UInt32
    SessionInfo : D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    MapValuesType : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE
    SupportFlags : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAGS
    MapSourcePreferenceRanking : UInt32
}
struct D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_FULL_PIXEL := 0
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_HALF_PIXEL := 1
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_QUARTER_PIXEL := 2
}
struct D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAG_FULL_PIXEL := 1
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAG_HALF_PIXEL := 2
    static D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAG_QUARTER_PIXEL := 4
}
struct D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAG_SUPPORTED := 1
    static D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAG_MULTIPLE_HINTS := 2
    static D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAG_GPU_TEXTURE_MULTIPLE_REFERENCES := 4
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_MOTION_SEARCH {
    NodeIndex : UInt32
    SessionInfo : D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO
    MotionSearchMode : D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    BidirectionalRefFrameEnabled : BOOL
    SupportFlags : D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAGS
    MaxMotionHints : UInt32
    MinDeviation : UInt32
    MaxDeviation : UInt32
    MapSourcePreferenceRanking : UInt32
    MotionUnitPrecisionSupport : D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT {
    NodeIndex : UInt32
    SessionInfo : D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO
    MapType : D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE
    IsSupported : BOOL
    MaxResolvedBufferAllocationSize : Int64
}
struct D3D12_VIDEO_ENCODER_QPMAP_CONFIGURATION {
    Enabled : BOOL
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_QPMAP {
    MapSourcePreferenceRanking : UInt32
}
struct D3D12_VIDEO_ENCODER_DIRTY_REGIONS_CONFIGURATION {
    Enabled : BOOL
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    MapValuesType : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_DIRTY_REGIONS {
    DirtyRegionsSupportFlags : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_SUPPORT_FLAGS
    MapSourcePreferenceRanking : UInt32
}
struct D3D12_VIDEO_ENCODER_MOTION_SEARCH_CONFIGURATION {
    Enabled : BOOL
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    MotionSearchMode : D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE
    BidirectionalRefFrameEnabled : BOOL
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_MOTION_SEARCH {
    MaxMotionHints : UInt32
    MinDeviation : UInt32
    MaxDeviation : UInt32
    MapSourcePreferenceRanking : UInt32
    MotionUnitPrecisionSupportFlags : D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION_SUPPORT_FLAGS
    SupportFlags : D3D12_VIDEO_ENCODER_MOTION_SEARCH_SUPPORT_FLAGS
}
struct D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_INTRACODED_FRAME_SUPPORTED := 1
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_UNIDIR_INTER_FRAME_SUPPORTED := 2
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_BIDIR_INTER_FRAME_SUPPORTED := 4
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_EXTERNAL_DPB_DOWNSCALING := 8
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_DYNAMIC_1ST_PASS_SKIP := 16
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_DYNAMIC_DOWNSCALE_FACTOR_CHANGE_KEY_FRAME := 32
    static D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAG_SUPPORTED := 7
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    Profile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    Level : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    InputFormat : DXGI_FORMAT
    InputResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    SubregionFrameEncoding : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    SubregionFrameEncodingData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA
    QPMap : D3D12_VIDEO_ENCODER_QPMAP_CONFIGURATION
    DirtyRegions : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_CONFIGURATION
    MotionSearch : D3D12_VIDEO_ENCODER_MOTION_SEARCH_CONFIGURATION
    Pow2DownscaleFactor : UInt32
    SupportFlags : D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_FRAME_ANALYSIS {
    SupportFlags : D3D12_VIDEO_ENCODER_RATE_CONTROL_FRAME_ANALYSIS_SUPPORT_FLAGS
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_LIMITS1 {
    MaxSubregionsNumber : UInt32
    MaxIntraRefreshFrameDuration : UInt32
    SubregionBlockPixelsSize : UInt32
    QPMapRegionPixelsSize : UInt32
    QPMap : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_QPMAP
    DirtyRegions : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_DIRTY_REGIONS
    MotionSearch : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_MOTION_SEARCH
    FrameAnalysis : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_FRAME_ANALYSIS
}
struct D3D12_VIDEO_ENCODER_FRAME_ANALYSIS_CONFIGURATION {
    Enabled : BOOL
    Pow2DownscaleFactor : UInt32
}
struct D3D12_FEATURE_DATA_VIDEO_ENCODER_SUPPORT2 {
    NodeIndex : UInt32
    Codec : D3D12_VIDEO_ENCODER_CODEC
    InputFormat : DXGI_FORMAT
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
    CodecGopSequence : D3D12_VIDEO_ENCODER_SEQUENCE_GOP_STRUCTURE
    RateControl : D3D12_VIDEO_ENCODER_RATE_CONTROL
    IntraRefresh : D3D12_VIDEO_ENCODER_INTRA_REFRESH_MODE
    SubregionFrameEncoding : D3D12_VIDEO_ENCODER_FRAME_SUBREGION_LAYOUT_MODE
    ResolutionsListCount : UInt32
    pResolutionList : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC.Ptr
    MaxReferenceFramesInDPB : UInt32
    ValidationFlags : D3D12_VIDEO_ENCODER_VALIDATION_FLAGS
    SupportFlags : D3D12_VIDEO_ENCODER_SUPPORT_FLAGS
    SuggestedProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    SuggestedLevel : D3D12_VIDEO_ENCODER_LEVEL_SETTING
    pResolutionDependentSupport : D3D12_FEATURE_DATA_VIDEO_ENCODER_RESOLUTION_SUPPORT_LIMITS1.Ptr
    SubregionFrameEncodingData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_SUBREGIONS_LAYOUT_DATA
    MaxQualityVsSpeed : UInt32
    QPMap : D3D12_VIDEO_ENCODER_QPMAP_CONFIGURATION
    DirtyRegions : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_CONFIGURATION
    MotionSearch : D3D12_VIDEO_ENCODER_MOTION_SEARCH_CONFIGURATION
    FrameAnalysis : D3D12_VIDEO_ENCODER_FRAME_ANALYSIS_CONFIGURATION
}
struct D3D12_VIDEO_ENCODER_DIRTY_RECT_INFO {
    FullFrameIdentical : BOOL
    MapValuesType : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE
    NumDirtyRects : UInt32
    pDirtyRects : RECT.Ptr
    SourceDPBFrameReference : UInt32
}
struct D3D12_VIDEO_ENCODER_DIRTY_REGIONS {
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pOpaqueLayoutBuffer : ID3D12Resource
            pCPUBuffer : D3D12_VIDEO_ENCODER_DIRTY_RECT_INFO.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_QUANTIZATION_OPAQUE_MAP {
    pOpaqueQuantizationMap : ID3D12Resource
}
struct D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_CONFIG {
    MotionSearchMode : D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE
    SearchDeviationLimit : UInt32
}
struct D3D12_VIDEO_ENCODER_MOVE_RECT {
    SourcePoint : POINT
    DestRect : RECT
}
struct D3D12_VIDEO_ENCODER_MOVEREGION_INFO_FLAGS extends Int32 {
    static D3D12_VIDEO_ENCODER_MOVEREGION_INFO_FLAG_NONE := 0
    static D3D12_VIDEO_ENCODER_MOVEREGION_INFO_FLAG_MULTIPLE_HINTS := 1
}
struct D3D12_VIDEO_ENCODER_MOVEREGION_INFO {
    NumMoveRegions : UInt32
    pMoveRegions : D3D12_VIDEO_ENCODER_MOVE_RECT.Ptr
    MotionSearchModeConfiguration : D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_CONFIG
    SourceDPBFrameReference : UInt32
    MotionUnitPrecision : D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION
    Flags : D3D12_VIDEO_ENCODER_MOVEREGION_INFO_FLAGS
}
struct D3D12_VIDEO_ENCODER_FRAME_MOTION_VECTORS {
    MapSource : D3D12_VIDEO_ENCODER_INPUT_MAP_SOURCE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pOpaqueLayoutBuffer : ID3D12Resource
            pCPUBuffer : D3D12_VIDEO_ENCODER_MOVEREGION_INFO.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC2 {
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC_FLAGS
    FrameType : D3D12_VIDEO_ENCODER_FRAME_TYPE_HEVC
    slice_pic_parameter_set_id : UInt32
    PictureOrderCountNumber : UInt32
    TemporalLayerIndex : UInt32
    List0ReferenceFramesCount : UInt32
    pList0ReferenceFrames : UInt32.Ptr
    List1ReferenceFramesCount : UInt32
    pList1ReferenceFrames : UInt32.Ptr
    ReferenceFramesReconPictureDescriptorsCount : UInt32
    pReferenceFramesReconPictureDescriptors : D3D12_VIDEO_ENCODER_REFERENCE_PICTURE_DESCRIPTOR_HEVC.Ptr
    List0RefPicModificationsCount : UInt32
    pList0RefPicModifications : UInt32.Ptr
    List1RefPicModificationsCount : UInt32
    pList1RefPicModifications : UInt32.Ptr
    QPMapValuesCount : UInt32
    pRateControlQPMap : Int8.Ptr
    diff_cu_chroma_qp_offset_depth : UInt8
    log2_sao_offset_scale_luma : UInt8
    log2_sao_offset_scale_chroma : UInt8
    log2_max_transform_skip_block_size_minus2 : UInt8
    chroma_qp_offset_list_len_minus1 : UInt8
    cb_qp_offset_list : CHAR[6]
    cr_qp_offset_list : CHAR[6]
    num_ref_idx_l0_active_minus1 : UInt32
    num_ref_idx_l1_active_minus1 : UInt32
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA1 {
    DataSize : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pH264PicData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_H264.Ptr
            pHEVCPicData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA_HEVC2.Ptr
            pAV1PicData : D3D12_VIDEO_ENCODER_AV1_PICTURE_CONTROL_CODEC_DATA.Ptr
        }
    }
}
struct D3D12_VIDEO_ENCODER_FRAME_ANALYSIS {
    pDownscaledFrame : ID3D12Resource
    Subresource : Int64
    DownscaledReferences : D3D12_VIDEO_ENCODE_REFERENCE_FRAMES
}
struct D3D12_VIDEO_ENCODER_PICTURE_CONTROL_DESC1 {
    IntraRefreshFrameIndex : UInt32
    Flags : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_FLAGS
    PictureControlCodecData : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA1
    ReferenceFrames : D3D12_VIDEO_ENCODE_REFERENCE_FRAMES
    MotionVectors : D3D12_VIDEO_ENCODER_FRAME_MOTION_VECTORS
    DirtyRects : D3D12_VIDEO_ENCODER_DIRTY_REGIONS
    QuantizationTextureMap : D3D12_VIDEO_ENCODER_QUANTIZATION_OPAQUE_MAP
    FrameAnalysis : D3D12_VIDEO_ENCODER_FRAME_ANALYSIS
}
struct D3D12_VIDEO_ENCODER_ENCODEFRAME_INPUT_ARGUMENTS1 {
    SequenceControlDesc : D3D12_VIDEO_ENCODER_SEQUENCE_CONTROL_DESC
    PictureControlDesc : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_DESC1
    pInputFrame : ID3D12Resource
    InputFrameSubresource : UInt32
    CurrentFrameBitstreamMetadataSize : UInt32
    OptionalMetadata : D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAGS
}
struct D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM_BUFFER_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM_BUFFER_MODE_ARRAY_OF_BUFFERS := 0
    static D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM_BUFFER_MODE_SINGLE_BUFFER := 1
}
struct D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM {
    BufferMode : D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM_BUFFER_MODE
    ExpectedSubregionCount : UInt32
    pSubregionBitstreamsBaseOffsets : Int64.Ptr
    ppSubregionBitstreams : ID3D12Resource.Ptr
    ppSubregionSizes : ID3D12Resource.Ptr
    ppSubregionOffsets : ID3D12Resource.Ptr
    ppSubregionFences : ID3D12Fence.Ptr
    pSubregionFenceValues : Int64.Ptr
}
struct D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM_NOTIFICATION_MODE extends Int32 {
    static D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM_NOTIFICATION_MODE_FULL_FRAME := 0
    static D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM_NOTIFICATION_MODE_SUBREGIONS := 1
}
struct D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM1 {
    NotificationMode : D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM_NOTIFICATION_MODE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FrameOutputBuffer : D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM
            SubregionOutputBuffers : D3D12_VIDEO_ENCODER_SUBREGION_COMPRESSED_BITSTREAM
        }
    }
}
struct D3D12_VIDEO_ENCODER_ENCODEFRAME_OUTPUT_ARGUMENTS1 {
    Bitstream : D3D12_VIDEO_ENCODER_COMPRESSED_BITSTREAM1
    ReconstructedPicture : D3D12_VIDEO_ENCODER_RECONSTRUCTED_PICTURE
    EncoderOutputMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
    FrameAnalysisReconstructedPicture : D3D12_VIDEO_ENCODER_RECONSTRUCTED_PICTURE
}
struct D3D12_VIDEO_ENCODER_RESOLVE_METADATA_INPUT_ARGUMENTS1 {
    EncoderCodec : D3D12_VIDEO_ENCODER_CODEC
    EncoderProfile : D3D12_VIDEO_ENCODER_PROFILE_DESC
    EncoderInputFormat : DXGI_FORMAT
    EncodedPictureEffectiveResolution : D3D12_VIDEO_ENCODER_PICTURE_RESOLUTION_DESC
    HWLayoutMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
    OptionalMetadata : D3D12_VIDEO_ENCODER_OPTIONAL_METADATA_ENABLE_FLAGS
    CodecConfiguration : D3D12_VIDEO_ENCODER_CODEC_CONFIGURATION
}
struct D3D12_VIDEO_ENCODER_RESOLVE_METADATA_OUTPUT_ARGUMENTS1 {
    ResolvedLayoutMetadata : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
    pOutputQPMap : ID3D12Resource
    pOutputSATDMap : ID3D12Resource
    pOutputBitAllocationMap : ID3D12Resource
    ResolvedFramePSNRData : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
    ResolvedSubregionsPSNRData : D3D12_VIDEO_ENCODER_ENCODE_OPERATION_METADATA_BUFFER
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_QUANTIZATION_MATRIX {
    pQuantizationMap : ID3D12Resource
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_DIRTY_REGIONS {
    FullFrameIdentical : BOOL
    MapValuesType : D3D12_VIDEO_ENCODER_DIRTY_REGIONS_MAP_VALUES_MODE
    pDirtyRegionsMap : ID3D12Resource
    SourceDPBFrameReference : UInt32
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_MOTION_VECTORS {
    MotionSearchModeConfiguration : D3D12_VIDEO_ENCODER_FRAME_MOTION_SEARCH_MODE_CONFIG
    NumHintsPerPixel : UInt32
    ppMotionVectorMaps : ID3D12Resource.Ptr
    pMotionVectorMapsSubresources : UInt32.Ptr
    ppMotionVectorMapsMetadata : ID3D12Resource.Ptr
    pMotionVectorMapsMetadataSubresources : UInt32.Ptr
    MotionUnitPrecision : D3D12_VIDEO_ENCODER_FRAME_INPUT_MOTION_UNIT_PRECISION
    PictureControlConfiguration : D3D12_VIDEO_ENCODER_PICTURE_CONTROL_CODEC_DATA1
}
struct D3D12_VIDEO_ENCODER_INPUT_MAP_DATA {
    MapType : D3D12_VIDEO_ENCODER_INPUT_MAP_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Quantization : D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_QUANTIZATION_MATRIX
            DirtyRegions : D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_DIRTY_REGIONS
            MotionVectors : D3D12_VIDEO_ENCODER_INPUT_MAP_DATA_MOTION_VECTORS
        }
    }
}
struct D3D12_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT_INPUT_ARGUMENTS {
    SessionInfo : D3D12_VIDEO_ENCODER_INPUT_MAP_SESSION_INFO
    InputData : D3D12_VIDEO_ENCODER_INPUT_MAP_DATA
}
struct D3D12_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT_OUTPUT_ARGUMENTS {
    pOpaqueLayoutBuffer : ID3D12Resource
}
struct ID3D12VideoEncodeCommandList4 extends ID3D12VideoEncodeCommandList3 {
    static IID := "{69AEB5B7-55F2-4012-8B73-3A88D65A204C}"
    EncodeFrame1(pEncoder, pHeap, pInputArguments, pOutputArguments)
      => ComCall(30, this.p, ID3D12VideoEncoder, pEncoder, ID3D12VideoEncoderHeap1, pHeap, D3D12_VIDEO_ENCODER_ENCODEFRAME_INPUT_ARGUMENTS1.Ptr, pInputArguments, D3D12_VIDEO_ENCODER_ENCODEFRAME_OUTPUT_ARGUMENTS1.Ptr, pOutputArguments, "void")
    ResolveEncoderOutputMetadata1(pInputArguments, pOutputArguments)
      => ComCall(31, this.p, D3D12_VIDEO_ENCODER_RESOLVE_METADATA_INPUT_ARGUMENTS1.Ptr, pInputArguments, D3D12_VIDEO_ENCODER_RESOLVE_METADATA_OUTPUT_ARGUMENTS1.Ptr, pOutputArguments, "void")
    ResolveInputParamLayout(pInputArguments, pOutputArguments)
      => ComCall(32, this.p, D3D12_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT_INPUT_ARGUMENTS.Ptr, pInputArguments, D3D12_VIDEO_ENCODER_RESOLVE_INPUT_PARAM_LAYOUT_OUTPUT_ARGUMENTS.Ptr, pOutputArguments, "void")
}
struct WMT_PROP_DATATYPE extends Int32 {
    static WMT_PROP_TYPE_DWORD := 0
    static WMT_PROP_TYPE_STRING := 1
    static WMT_PROP_TYPE_BINARY := 2
    static WMT_PROP_TYPE_BOOL := 3
    static WMT_PROP_TYPE_QWORD := 4
    static WMT_PROP_TYPE_WORD := 5
    static WMT_PROP_TYPE_GUID := 6
}
struct IWMValidate extends IUnknown {
    static IID := "{CEE3DEF2-3808-414D-BE66-FAFD472210BC}"
    SetIdentifier(guidValidationID)
      => ComCall(3, this.p, GUID, guidValidationID)
}
struct IValidateBinding extends IUnknown {
    static IID := "{04A578B2-E778-422A-A805-B3EE54D90BD9}"
    GetIdentifier(guidLicensorID, pbEphemeron, ppbBlobValidationID, pcbBlobSize)
      => ComCall(3, this.p, GUID, guidLicensorID, UInt8.Ptr, pbEphemeron, UInt32, pbEphemeron.Length, UInt8.Ptr.Ptr, ppbBlobValidationID, UInt32.Ptr, pcbBlobSize)
}
struct IWMVideoDecoderHurryup extends IUnknown {
    static IID := "{352BB3BD-2D4D-4323-9E71-DCDCFBD53CA6}"
    SetHurryup(lHurryup)
      => ComCall(3, this.p, Int32, lHurryup)
    GetHurryup(plHurryup)
      => ComCall(4, this.p, Int32.Ptr, plHurryup)
}
struct IWMVideoForceKeyFrame extends IUnknown {
    static IID := "{9F8496BE-5B9A-41B9-A9E8-F21CD80596C2}"
    SetKeyFrame()
      => ComCall(3, this.p)
}
struct IWMCodecStrings extends IUnknown {
    static IID := "{A7B2504B-E58A-47FB-958B-CAC7165A057D}"
    GetName(pmt, szName?, pcchLength)
      => ComCall(3, this.p, DMO_MEDIA_TYPE.Ptr, pmt, UInt32, szName?.Length ?? 0, PWSTR, szName?, UInt32.Ptr, pcchLength)
    GetDescription(pmt, szDescription?, pcchLength)
      => ComCall(4, this.p, DMO_MEDIA_TYPE.Ptr, pmt, UInt32, szDescription?.Length ?? 0, PWSTR, szDescription?, UInt32.Ptr, pcchLength)
}
struct IWMCodecProps extends IUnknown {
    static IID := "{2573E11A-F01A-4FDD-A98D-63B8E0BA9589}"
    GetFormatProp(pmt, pszName, pType, pValue, pdwSize)
      => ComCall(3, this.p, DMO_MEDIA_TYPE.Ptr, pmt, "Str", pszName, WMT_PROP_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pdwSize)
    GetCodecProp(dwFormat, pszName, pType, pValue, pdwSize)
      => ComCall(4, this.p, UInt32, dwFormat, "Str", pszName, WMT_PROP_DATATYPE.Ptr, pType, UInt8.Ptr, pValue, UInt32.Ptr, pdwSize)
}
struct IWMCodecLeakyBucket extends IUnknown {
    static IID := "{A81BA647-6227-43B7-B231-C7B15135DD7D}"
    SetBufferSizeBits(ulBufferSize)
      => ComCall(3, this.p, UInt32, ulBufferSize)
    GetBufferSizeBits(pulBufferSize)
      => ComCall(4, this.p, UInt32.Ptr, pulBufferSize)
    SetBufferFullnessBits(ulBufferFullness)
      => ComCall(5, this.p, UInt32, ulBufferFullness)
    GetBufferFullnessBits(pulBufferFullness)
      => ComCall(6, this.p, UInt32.Ptr, pulBufferFullness)
}
struct IWMCodecOutputTimestamp extends IUnknown {
    static IID := "{B72ADF95-7ADC-4A72-BC05-577D8EA6BF68}"
    GetNextOutputTime(prtTime)
      => ComCall(3, this.p, Int64.Ptr, prtTime)
}
struct IWMVideoDecoderReconBuffer extends IUnknown {
    static IID := "{45BDA2AC-88E2-4923-98BA-3949080711A3}"
    GetReconstructedVideoFrameSize(pdwSize)
      => ComCall(3, this.p, UInt32.Ptr, pdwSize)
    GetReconstructedVideoFrame(pBuf)
      => ComCall(4, this.p, IMediaBuffer, pBuf)
    SetReconstructedVideoFrame(pBuf)
      => ComCall(5, this.p, IMediaBuffer, pBuf)
}
struct IWMCodecPrivateData extends IUnknown {
    static IID := "{73F0BE8E-57F7-4F01-AA66-9F57340CFE0E}"
    SetPartialOutputType(pmt)
      => ComCall(3, this.p, DMO_MEDIA_TYPE.Ptr, pmt)
    GetPrivateData(pbData, pcbData)
      => ComCall(4, this.p, UInt8.Ptr, pbData, UInt32.Ptr, pcbData)
}
struct IWMSampleExtensionSupport extends IUnknown {
    static IID := "{9BCA9884-0604-4C2A-87DA-793FF4D586C3}"
    SetUseSampleExtensions(fUseExtensions)
      => ComCall(3, this.p, BOOL, fUseExtensions)
}
struct IWMResamplerProps extends IUnknown {
    static IID := "{E7E9984F-F09F-4DA4-903F-6E2E0EFE56B5}"
    SetHalfFilterLength(lhalfFilterLen)
      => ComCall(3, this.p, Int32, lhalfFilterLen)
    SetUserChannelMtx(userChannelMtx)
      => ComCall(4, this.p, Float32.Ptr, userChannelMtx)
}
struct IWMResizerProps extends IUnknown {
    static IID := "{57665D4C-0414-4FAA-905B-10E546F81C33}"
    SetResizerQuality(lquality)
      => ComCall(3, this.p, Int32, lquality)
    SetInterlaceMode(lmode)
      => ComCall(4, this.p, Int32, lmode)
    SetClipRegion(lClipOriXSrc, lClipOriYSrc, lClipWidthSrc, lClipHeightSrc)
      => ComCall(5, this.p, Int32, lClipOriXSrc, Int32, lClipOriYSrc, Int32, lClipWidthSrc, Int32, lClipHeightSrc)
    SetFullCropRegion(lClipOriXSrc, lClipOriYSrc, lClipWidthSrc, lClipHeightSrc, lClipOriXDst, lClipOriYDst, lClipWidthDst, lClipHeightDst)
      => ComCall(6, this.p, Int32, lClipOriXSrc, Int32, lClipOriYSrc, Int32, lClipWidthSrc, Int32, lClipHeightSrc, Int32, lClipOriXDst, Int32, lClipOriYDst, Int32, lClipWidthDst, Int32, lClipHeightDst)
    GetFullCropRegion(lClipOriXSrc, lClipOriYSrc, lClipWidthSrc, lClipHeightSrc, lClipOriXDst, lClipOriYDst, lClipWidthDst, lClipHeightDst)
      => ComCall(7, this.p, Int32.Ptr, lClipOriXSrc, Int32.Ptr, lClipOriYSrc, Int32.Ptr, lClipWidthSrc, Int32.Ptr, lClipHeightSrc, Int32.Ptr, lClipOriXDst, Int32.Ptr, lClipOriYDst, Int32.Ptr, lClipWidthDst, Int32.Ptr, lClipHeightDst)
}
struct IWMColorLegalizerProps extends IUnknown {
    static IID := "{776C93B3-B72D-4508-B6D0-208785F553E7}"
    SetColorLegalizerQuality(lquality)
      => ComCall(3, this.p, Int32, lquality)
}
struct IWMInterlaceProps extends IUnknown {
    static IID := "{7B12E5D1-BD22-48EA-BC06-98E893221C89}"
    SetProcessType(iProcessType)
      => ComCall(3, this.p, Int32, iProcessType)
    SetInitInverseTeleCinePattern(iInitPattern)
      => ComCall(4, this.p, Int32, iInitPattern)
    SetLastFrame()
      => ComCall(5, this.p)
}
struct IWMFrameInterpProps extends IUnknown {
    static IID := "{4C06BB9B-626C-4614-8329-CC6A21B93FA0}"
    SetFrameRateIn(lFrameRate, lScale)
      => ComCall(3, this.p, Int32, lFrameRate, Int32, lScale)
    SetFrameRateOut(lFrameRate, lScale)
      => ComCall(4, this.p, Int32, lFrameRate, Int32, lScale)
    SetFrameInterpEnabled(bFIEnabled)
      => ComCall(5, this.p, BOOL, bFIEnabled)
    SetComplexityLevel(iComplexity)
      => ComCall(6, this.p, Int32, iComplexity)
}
struct IWMColorConvProps extends IUnknown {
    static IID := "{E6A49E22-C099-421D-AAD3-C061FB4AE85B}"
    SetMode(lMode)
      => ComCall(3, this.p, Int32, lMode)
    SetFullCroppingParam(lSrcCropLeft, lSrcCropTop, lDstCropLeft, lDstCropTop, lCropWidth, lCropHeight)
      => ComCall(4, this.p, Int32, lSrcCropLeft, Int32, lSrcCropTop, Int32, lDstCropLeft, Int32, lDstCropTop, Int32, lCropWidth, Int32, lCropHeight)
}
struct WMV_DYNAMIC_FLAGS extends Int32 {
    static WMV_DYNAMIC_BITRATE := 1
    static WMV_DYNAMIC_RESOLUTION := 2
    static WMV_DYNAMIC_COMPLEXITY := 4
}
struct MF_AUVRHP_ROOMMODEL extends Int32 {
    static VRHP_SMALLROOM := 0
    static VRHP_MEDIUMROOM := 1
    static VRHP_BIGROOM := 2
    static VRHP_CUSTUMIZEDROOM := 3
}
struct AEC_SYSTEM_MODE extends Int32 {
    static SINGLE_CHANNEL_AEC := 0
    static ADAPTIVE_ARRAY_ONLY := 1
    static OPTIBEAM_ARRAY_ONLY := 2
    static ADAPTIVE_ARRAY_AND_AEC := 3
    static OPTIBEAM_ARRAY_AND_AEC := 4
    static SINGLE_CHANNEL_NSAGC := 5
    static MODE_NOT_SET := 6
}
struct AecQualityMetrics_Struct {
    i64Timestamp : Int64
    ConvergenceFlag : UInt8
    MicClippedFlag : UInt8
    MicSilenceFlag : UInt8
    PstvFeadbackFlag : UInt8
    SpkClippedFlag : UInt8
    SpkMuteFlag : UInt8
    GlitchFlag : UInt8
    DoubleTalkFlag : UInt8
    uGlitchCount : UInt32
    uMicClipCount : UInt32
    fDuration : Float32
    fTSVariance : Float32
    fTSDriftRate : Float32
    fVoiceLevel : Float32
    fNoiseLevel : Float32
    fERLE : Float32
    fAvgERLE : Float32
    dwReserved : UInt32
}
struct AEC_VAD_MODE extends Int32 {
    static AEC_VAD_DISABLED := 0
    static AEC_VAD_NORMAL := 1
    static AEC_VAD_FOR_AGC := 2
    static AEC_VAD_FOR_SILENCE_SUPPRESSION := 3
}
struct AEC_INPUT_STREAM extends Int32 {
    static AEC_CAPTURE_STREAM := 0
    static AEC_REFERENCE_STREAM := 1
}
struct MIC_ARRAY_MODE extends Int32 {
    static MICARRAY_SINGLE_CHAN := 0
    static MICARRAY_SIMPLE_SUM := 256
    static MICARRAY_SINGLE_BEAM := 512
    static MICARRAY_FIXED_BEAM := 1024
    static MICARRAY_EXTERN_BEAM := 2048
}
struct MFVideoDSPMode extends Int32 {
    static MFVideoDSPMode_Passthrough := 1
    static MFVideoDSPMode_Stabilization := 4
}
struct TOC_DESCRIPTOR {
    guidID : GUID
    wStreamNumber : UInt16
    guidType : GUID
    wLanguageIndex : UInt16
}
struct TOC_ENTRY_DESCRIPTOR {
    qwStartTime : Int64
    qwEndTime : Int64
    qwStartPacketOffset : Int64
    qwEndPacketOffset : Int64
    qwRepresentativeFrameTime : Int64
}
struct TOC_POS_TYPE extends Int32 {
    static TOC_POS_INHEADER := 0
    static TOC_POS_TOPLEVELOBJECT := 1
}
struct ITocEntry extends IUnknown {
    static IID := "{F22F5E06-585C-4DEF-8523-6555CFBC0CB3}"
    SetTitle(pwszTitle)
      => ComCall(3, this.p, "Str", pwszTitle)
    GetTitle(pwszTitle?)
      => ComCall(4, this.p, UInt16.Ptr, pwszTitle?.Length ?? 0, PWSTR, pwszTitle?)
    SetDescriptor(pDescriptor)
      => ComCall(5, this.p, TOC_ENTRY_DESCRIPTOR.Ptr, pDescriptor)
    GetDescriptor(pDescriptor)
      => ComCall(6, this.p, TOC_ENTRY_DESCRIPTOR.Ptr, pDescriptor)
    SetSubEntries(dwNumSubEntries, pwSubEntryIndices)
      => ComCall(7, this.p, UInt32, dwNumSubEntries, UInt16.Ptr, pwSubEntryIndices)
    GetSubEntries(pdwNumSubEntries, pwSubEntryIndices)
      => ComCall(8, this.p, UInt32.Ptr, pdwNumSubEntries, UInt16.Ptr, pwSubEntryIndices)
    SetDescriptionData(dwDescriptionDataSize, pbtDescriptionData, pguidType)
      => ComCall(9, this.p, UInt32, dwDescriptionDataSize, UInt8.Ptr, pbtDescriptionData, GUID.Ptr, pguidType)
    GetDescriptionData(pdwDescriptionDataSize, pbtDescriptionData, pGuidType)
      => ComCall(10, this.p, UInt32.Ptr, pdwDescriptionDataSize, UInt8.Ptr, pbtDescriptionData, GUID.Ptr, pGuidType)
}
struct ITocEntryList extends IUnknown {
    static IID := "{3A8CCCBD-0EFD-43A3-B838-F38A552BA237}"
    GetEntryCount(pdwEntryCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwEntryCount)
    GetEntryByIndex(dwEntryIndex, ppEntry)
      => ComCall(4, this.p, UInt32, dwEntryIndex, ITocEntry.Ptr, ppEntry)
    AddEntry(pEntry, pdwEntryIndex)
      => ComCall(5, this.p, ITocEntry, pEntry, UInt32.Ptr, pdwEntryIndex)
    AddEntryByIndex(dwEntryIndex, pEntry)
      => ComCall(6, this.p, UInt32, dwEntryIndex, ITocEntry, pEntry)
    RemoveEntryByIndex(dwEntryIndex)
      => ComCall(7, this.p, UInt32, dwEntryIndex)
}
struct IToc extends IUnknown {
    static IID := "{D6F05441-A919-423B-91A0-89D5B4A8AB77}"
    SetDescriptor(pDescriptor)
      => ComCall(3, this.p, TOC_DESCRIPTOR.Ptr, pDescriptor)
    GetDescriptor(pDescriptor)
      => ComCall(4, this.p, TOC_DESCRIPTOR.Ptr, pDescriptor)
    SetDescription(pwszDescription)
      => ComCall(5, this.p, "Str", pwszDescription)
    GetDescription(pwszDescription?)
      => ComCall(6, this.p, UInt16.Ptr, pwszDescription?.Length ?? 0, PWSTR, pwszDescription?)
    SetContext(dwContextSize, pbtContext)
      => ComCall(7, this.p, UInt32, dwContextSize, UInt8.Ptr, pbtContext)
    GetContext(pdwContextSize, pbtContext)
      => ComCall(8, this.p, UInt32.Ptr, pdwContextSize, UInt8.Ptr, pbtContext)
    GetEntryListCount(pwCount)
      => ComCall(9, this.p, UInt16.Ptr, pwCount)
    GetEntryListByIndex(wEntryListIndex, ppEntryList)
      => ComCall(10, this.p, UInt16, wEntryListIndex, ITocEntryList.Ptr, ppEntryList)
    AddEntryList(pEntryList, pwEntryListIndex)
      => ComCall(11, this.p, ITocEntryList, pEntryList, UInt16.Ptr, pwEntryListIndex)
    AddEntryListByIndex(wEntryListIndex, pEntryList)
      => ComCall(12, this.p, UInt16, wEntryListIndex, ITocEntryList, pEntryList)
    RemoveEntryListByIndex(wEntryListIndex)
      => ComCall(13, this.p, UInt16, wEntryListIndex)
}
struct ITocCollection extends IUnknown {
    static IID := "{23FEE831-AE96-42DF-B170-25A04847A3CA}"
    GetEntryCount(pdwEntryCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwEntryCount)
    GetEntryByIndex(dwEntryIndex, ppToc)
      => ComCall(4, this.p, UInt32, dwEntryIndex, IToc.Ptr, ppToc)
    AddEntry(pToc, pdwEntryIndex)
      => ComCall(5, this.p, IToc, pToc, UInt32.Ptr, pdwEntryIndex)
    AddEntryByIndex(dwEntryIndex, pToc)
      => ComCall(6, this.p, UInt32, dwEntryIndex, IToc, pToc)
    RemoveEntryByIndex(dwEntryIndex)
      => ComCall(7, this.p, UInt32, dwEntryIndex)
}
struct ITocParser extends IUnknown {
    static IID := "{ECFB9A55-9298-4F49-887F-0B36206599D2}"
    Init(pwszFileName)
      => ComCall(3, this.p, "Str", pwszFileName)
    GetTocCount(enumTocPosType, pdwTocCount)
      => ComCall(4, this.p, TOC_POS_TYPE, enumTocPosType, UInt32.Ptr, pdwTocCount)
    GetTocByIndex(enumTocPosType, dwTocIndex, ppToc)
      => ComCall(5, this.p, TOC_POS_TYPE, enumTocPosType, UInt32, dwTocIndex, IToc.Ptr, ppToc)
    GetTocByType(enumTocPosType, guidTocType, ppTocs)
      => ComCall(6, this.p, TOC_POS_TYPE, enumTocPosType, GUID, guidTocType, ITocCollection.Ptr, ppTocs)
    AddToc(enumTocPosType, pToc, pdwTocIndex)
      => ComCall(7, this.p, TOC_POS_TYPE, enumTocPosType, IToc, pToc, UInt32.Ptr, pdwTocIndex)
    RemoveTocByIndex(enumTocPosType, dwTocIndex)
      => ComCall(8, this.p, TOC_POS_TYPE, enumTocPosType, UInt32, dwTocIndex)
    RemoveTocByType(enumTocPosType, guidTocType)
      => ComCall(9, this.p, TOC_POS_TYPE, enumTocPosType, GUID, guidTocType)
    Commit()
      => ComCall(10, this.p)
}
struct FILE_OPENMODE extends Int32 {
    static OPENMODE_FAIL_IF_NOT_EXIST := 0
    static OPENMODE_FAIL_IF_EXIST := 1
    static OPENMODE_RESET_IF_EXIST := 2
    static OPENMODE_APPEND_IF_EXIST := 3
    static OPENMODE_DELETE_IF_EXIST := 4
}
struct SEEK_ORIGIN extends Int32 {
    static _msoBegin := 0
    static _msoCurrent := 1
}
struct FILE_ACCESSMODE extends Int32 {
    static ACCESSMODE_READ := 1
    static ACCESSMODE_WRITE := 2
    static ACCESSMODE_READWRITE := 3
    static ACCESSMODE_WRITE_EXCLUSIVE := 4
}
struct IFileIo extends IUnknown {
    static IID := "{11993196-1244-4840-AB44-480975C4FFE4}"
    Initialize(eAccessMode, eOpenMode, pwszFileName)
      => ComCall(3, this.p, FILE_ACCESSMODE, eAccessMode, FILE_OPENMODE, eOpenMode, "Str", pwszFileName)
    GetLength(pqwLength)
      => ComCall(4, this.p, Int64.Ptr, pqwLength)
    SetLength(qwLength)
      => ComCall(5, this.p, Int64, qwLength)
    GetCurrentPosition(pqwPosition)
      => ComCall(6, this.p, Int64.Ptr, pqwPosition)
    SetCurrentPosition(qwPosition)
      => ComCall(7, this.p, Int64, qwPosition)
    IsEndOfStream(pbEndOfStream)
      => ComCall(8, this.p, BOOL.Ptr, pbEndOfStream)
    Read(pbt, ul, pulRead)
      => ComCall(9, this.p, UInt8.Ptr, pbt, UInt32, ul, UInt32.Ptr, pulRead)
    Write(pbt, ul, pulWritten)
      => ComCall(10, this.p, UInt8.Ptr, pbt, UInt32, ul, UInt32.Ptr, pulWritten)
    Seek(eSeekOrigin, qwSeekOffset, dwSeekFlags, pqwCurrentPosition)
      => ComCall(11, this.p, SEEK_ORIGIN, eSeekOrigin, Int64, qwSeekOffset, UInt32, dwSeekFlags, Int64.Ptr, pqwCurrentPosition)
    Close()
      => ComCall(12, this.p)
}
struct IFileClient extends IUnknown {
    static IID := "{BFCCD196-1244-4840-AB44-480975C4FFE4}"
    GetObjectDiskSize(pqwSize)
      => ComCall(3, this.p, Int64.Ptr, pqwSize)
    Write(pFio)
      => ComCall(4, this.p, IFileIo, pFio)
    Read(pFio)
      => ComCall(5, this.p, IFileIo, pFio)
}
struct IClusterDetector extends IUnknown {
    static IID := "{3F07F7B7-C680-41D9-9423-915107EC9FF9}"
    Initialize(wBaseEntryLevel, wClusterEntryLevel)
      => ComCall(3, this.p, UInt16, wBaseEntryLevel, UInt16, wClusterEntryLevel)
    Detect(dwMaxNumClusters, fMinClusterDuration, fMaxClusterDuration, pSrcToc, ppDstToc)
      => ComCall(4, this.p, UInt32, dwMaxNumClusters, Float32, fMinClusterDuration, Float32, fMaxClusterDuration, IToc, pSrcToc, IToc.Ptr, ppDstToc)
}
struct DXVA_AYUVsample2 {
    bCrValue : UInt8
    bCbValue : UInt8
    bY_Value : UInt8
    bSampleAlpha8 : UInt8
}
struct DXVA_BufferDescription {
    dwTypeIndex : UInt32
    dwBufferIndex : UInt32
    dwDataOffset : UInt32
    dwDataSize : UInt32
    dwFirstMBaddress : UInt32
    dwNumMBsInBuffer : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwStride : UInt32
    dwReservedBits : UInt32
}
struct DXVA_ConfigPictureDecode {
    dwFunction : UInt32
    dwReservedBits : UInt32[3]
    guidConfigBitstreamEncryption : GUID
    guidConfigMBcontrolEncryption : GUID
    guidConfigResidDiffEncryption : GUID
    bConfigBitstreamRaw : UInt8
    bConfigMBcontrolRasterOrder : UInt8
    bConfigResidDiffHost : UInt8
    bConfigSpatialResid8 : UInt8
    bConfigResid8Subtraction : UInt8
    bConfigSpatialHost8or9Clipping : UInt8
    bConfigSpatialResidInterleaved : UInt8
    bConfigIntraResidUnsigned : UInt8
    bConfigResidDiffAccelerator : UInt8
    bConfigHostInverseScan : UInt8
    bConfigSpecificIDCT : UInt8
    bConfig4GroupedCoefs : UInt8
}
struct DXVA_PictureParameters {
    wDecodedPictureIndex : UInt16
    wDeblockedPictureIndex : UInt16
    wForwardRefPictureIndex : UInt16
    wBackwardRefPictureIndex : UInt16
    wPicWidthInMBminus1 : UInt16
    wPicHeightInMBminus1 : UInt16
    bMacroblockWidthMinus1 : UInt8
    bMacroblockHeightMinus1 : UInt8
    bBlockWidthMinus1 : UInt8
    bBlockHeightMinus1 : UInt8
    bBPPminus1 : UInt8
    bPicStructure : UInt8
    bSecondField : UInt8
    bPicIntra : UInt8
    bPicBackwardPrediction : UInt8
    bBidirectionalAveragingMode : UInt8
    bMVprecisionAndChromaRelation : UInt8
    bChromaFormat : UInt8
    bPicScanFixed : UInt8
    bPicScanMethod : UInt8
    bPicReadbackRequests : UInt8
    bRcontrol : UInt8
    bPicSpatialResid8 : UInt8
    bPicOverflowBlocks : UInt8
    bPicExtrapolation : UInt8
    bPicDeblocked : UInt8
    bPicDeblockConfined : UInt8
    bPic4MVallowed : UInt8
    bPicOBMC : UInt8
    bPicBinPB : UInt8
    bMV_RPS : UInt8
    bReservedBits : UInt8
    wBitstreamFcodes : UInt16
    wBitstreamPCEelements : UInt16
    bBitstreamConcealmentNeed : UInt8
    bBitstreamConcealmentMethod : UInt8
}
struct DXVAUncompDataInfo {
    UncompWidth : UInt32
    UncompHeight : UInt32
    UncompFormat : D3DFORMAT
}
struct DXVACompBufferInfo {
    NumCompBuffers : UInt32
    WidthToCreate : UInt32
    HeightToCreate : UInt32
    BytesToAllocate : UInt32
    Usage : UInt32
    Pool : D3DPOOL
    Format : D3DFORMAT
}
struct DXVABufferInfo {
    pCompSurface : Struct.Ptr
    DataOffset : UInt32
    DataSize : UInt32
}
struct DXVA_SampleFormat extends Int32 {
    static DXVA_SampleFormatMask := 255
    static DXVA_SampleUnknown := 0
    static DXVA_SamplePreviousFrame := 1
    static DXVA_SampleProgressiveFrame := 2
    static DXVA_SampleFieldInterleavedEvenFirst := 3
    static DXVA_SampleFieldInterleavedOddFirst := 4
    static DXVA_SampleFieldSingleEven := 5
    static DXVA_SampleFieldSingleOdd := 6
    static DXVA_SampleSubStream := 7
}
struct DXVA_VideoTransferFunction extends Int32 {
    static DXVA_VideoTransFuncShift := 27
    static DXVA_VideoTransFuncMask := -134217728
    static DXVA_VideoTransFunc_Unknown := 0
    static DXVA_VideoTransFunc_10 := 1
    static DXVA_VideoTransFunc_18 := 2
    static DXVA_VideoTransFunc_20 := 3
    static DXVA_VideoTransFunc_22 := 4
    static DXVA_VideoTransFunc_22_709 := 5
    static DXVA_VideoTransFunc_22_240M := 6
    static DXVA_VideoTransFunc_22_8bit_sRGB := 7
    static DXVA_VideoTransFunc_28 := 8
}
struct DXVA_VideoPrimaries extends Int32 {
    static DXVA_VideoPrimariesShift := 22
    static DXVA_VideoPrimariesMask := 130023424
    static DXVA_VideoPrimaries_Unknown := 0
    static DXVA_VideoPrimaries_reserved := 1
    static DXVA_VideoPrimaries_BT709 := 2
    static DXVA_VideoPrimaries_BT470_2_SysM := 3
    static DXVA_VideoPrimaries_BT470_2_SysBG := 4
    static DXVA_VideoPrimaries_SMPTE170M := 5
    static DXVA_VideoPrimaries_SMPTE240M := 6
    static DXVA_VideoPrimaries_EBU3213 := 7
    static DXVA_VideoPrimaries_SMPTE_C := 8
}
struct DXVA_VideoLighting extends Int32 {
    static DXVA_VideoLightingShift := 18
    static DXVA_VideoLightingMask := 3932160
    static DXVA_VideoLighting_Unknown := 0
    static DXVA_VideoLighting_bright := 1
    static DXVA_VideoLighting_office := 2
    static DXVA_VideoLighting_dim := 3
    static DXVA_VideoLighting_dark := 4
}
struct DXVA_VideoTransferMatrix extends Int32 {
    static DXVA_VideoTransferMatrixShift := 15
    static DXVA_VideoTransferMatrixMask := 229376
    static DXVA_VideoTransferMatrix_Unknown := 0
    static DXVA_VideoTransferMatrix_BT709 := 1
    static DXVA_VideoTransferMatrix_BT601 := 2
    static DXVA_VideoTransferMatrix_SMPTE240M := 3
}
struct DXVA_NominalRange extends Int32 {
    static DXVA_NominalRangeShift := 12
    static DXVA_NominalRangeMask := 28672
    static DXVA_NominalRange_Unknown := 0
    static DXVA_NominalRange_Normal := 1
    static DXVA_NominalRange_Wide := 2
    static DXVA_NominalRange_0_255 := 1
    static DXVA_NominalRange_16_235 := 2
    static DXVA_NominalRange_48_208 := 3
}
struct DXVA_VideoChromaSubsampling extends Int32 {
    static DXVA_VideoChromaSubsamplingShift := 8
    static DXVA_VideoChromaSubsamplingMask := 3840
    static DXVA_VideoChromaSubsampling_Unknown := 0
    static DXVA_VideoChromaSubsampling_ProgressiveChroma := 8
    static DXVA_VideoChromaSubsampling_Horizontally_Cosited := 4
    static DXVA_VideoChromaSubsampling_Vertically_Cosited := 2
    static DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes := 1
    static DXVA_VideoChromaSubsampling_MPEG2 := 5
    static DXVA_VideoChromaSubsampling_MPEG1 := 1
    static DXVA_VideoChromaSubsampling_DV_PAL := 6
    static DXVA_VideoChromaSubsampling_Cosited := 7
}
struct DXVA_ExtendedFormat {
    _bitfield : UInt32
}
struct DXVA_Frequency {
    Numerator : UInt32
    Denominator : UInt32
}
struct DXVA_VideoDesc {
    Size : UInt32
    SampleWidth : UInt32
    SampleHeight : UInt32
    SampleFormat : UInt32
    d3dFormat : D3DFORMAT
    InputSampleFreq : DXVA_Frequency
    OutputFrameFreq : DXVA_Frequency
}
struct DXVA_VideoProcessCaps extends Int32 {
    static DXVA_VideoProcess_None := 0
    static DXVA_VideoProcess_YUV2RGB := 1
    static DXVA_VideoProcess_StretchX := 2
    static DXVA_VideoProcess_StretchY := 4
    static DXVA_VideoProcess_AlphaBlend := 8
    static DXVA_VideoProcess_SubRects := 16
    static DXVA_VideoProcess_SubStreams := 32
    static DXVA_VideoProcess_SubStreamsExtended := 64
    static DXVA_VideoProcess_YUV2RGBExtended := 128
    static DXVA_VideoProcess_AlphaBlendExtended := 256
}
struct DXVA_DeinterlaceTech extends Int32 {
    static DXVA_DeinterlaceTech_Unknown := 0
    static DXVA_DeinterlaceTech_BOBLineReplicate := 1
    static DXVA_DeinterlaceTech_BOBVerticalStretch := 2
    static DXVA_DeinterlaceTech_BOBVerticalStretch4Tap := 256
    static DXVA_DeinterlaceTech_MedianFiltering := 4
    static DXVA_DeinterlaceTech_EdgeFiltering := 16
    static DXVA_DeinterlaceTech_FieldAdaptive := 32
    static DXVA_DeinterlaceTech_PixelAdaptive := 64
    static DXVA_DeinterlaceTech_MotionVectorSteered := 128
}
struct DXVA_VideoSample {
    rtStart : Int64
    rtEnd : Int64
    SampleFormat : DXVA_SampleFormat
    lpDDSSrcSurface : Struct.Ptr
}
struct DXVA_SampleFlags extends Int32 {
    static DXVA_SampleFlagsMask := 15
    static DXVA_SampleFlag_Palette_Changed := 1
    static DXVA_SampleFlag_SrcRect_Changed := 2
    static DXVA_SampleFlag_DstRect_Changed := 4
    static DXVA_SampleFlag_ColorData_Changed := 8
}
struct DXVA_DestinationFlags extends Int32 {
    static DXVA_DestinationFlagMask := 15
    static DXVA_DestinationFlag_Background_Changed := 1
    static DXVA_DestinationFlag_TargetRect_Changed := 2
    static DXVA_DestinationFlag_ColorData_Changed := 4
    static DXVA_DestinationFlag_Alpha_Changed := 8
}
struct DXVA_DeinterlaceCaps {
    Size : UInt32
    NumPreviousOutputFrames : UInt32
    InputPool : UInt32
    NumForwardRefSamples : UInt32
    NumBackwardRefSamples : UInt32
    d3dOutputFormat : D3DFORMAT
    VideoProcessingCaps : DXVA_VideoProcessCaps
    DeinterlaceTechnology : DXVA_DeinterlaceTech
}
struct DXVA_DeinterlaceBlt {
    Size : UInt32
    Reserved : UInt32
    rtTarget : Int64
    DstRect : RECT
    SrcRect : RECT
    NumSourceSurfaces : UInt32
    Alpha : Float32
    Source : DXVA_VideoSample[32]
}
struct DXVA_DeinterlaceBltEx {
    Size : UInt32
    BackgroundColor : DXVA_AYUVsample2
    rcTarget : RECT
    rtTarget : Int64
    NumSourceSurfaces : UInt32
    Alpha : Float32
    Source : DXVA_VideoSample2[32]
    DestinationFormat : UInt32
    DestinationFlags : UInt32
}
struct DXVA_DeinterlaceQueryAvailableModes {
    Size : UInt32
    NumGuids : UInt32
    Guids : GUID[32]
}
struct DXVA_DeinterlaceQueryModeCaps {
    Size : UInt32
    Guid : GUID
    VideoDesc : DXVA_VideoDesc
}
struct DXVA_ProcAmpControlProp extends Int32 {
    static DXVA_ProcAmp_None := 0
    static DXVA_ProcAmp_Brightness := 1
    static DXVA_ProcAmp_Contrast := 2
    static DXVA_ProcAmp_Hue := 4
    static DXVA_ProcAmp_Saturation := 8
}
struct DXVA_ProcAmpControlCaps {
    Size : UInt32
    InputPool : UInt32
    d3dOutputFormat : D3DFORMAT
    ProcAmpControlProps : UInt32
    VideoProcessingCaps : UInt32
}
struct DXVA_ProcAmpControlQueryRange {
    Size : UInt32
    ProcAmpControlProp : DXVA_ProcAmpControlProp
    VideoDesc : DXVA_VideoDesc
}
struct DXVA_VideoPropertyRange {
    MinValue : Float32
    MaxValue : Float32
    DefaultValue : Float32
    StepSize : Float32
}
struct DXVA_ProcAmpControlBlt {
    Size : UInt32
    DstRect : RECT
    SrcRect : RECT
    Alpha : Float32
    Brightness : Float32
    Contrast : Float32
    Hue : Float32
    Saturation : Float32
}
struct DXVA_COPPSignature {
    Signature : UInt8[256]
}
struct DXVA_COPPCommand {
    macKDI : GUID
    guidCommandID : GUID
    dwSequence : UInt32
    cbSizeData : UInt32
    CommandData : UInt8[4056]
}
struct DXVA_COPPStatusInput {
    rApp : GUID
    guidStatusRequestID : GUID
    dwSequence : UInt32
    cbSizeData : UInt32
    StatusData : UInt8[4056]
}
struct DXVA_COPPStatusOutput {
    macKDI : GUID
    cbSizeData : UInt32
    COPPStatus : UInt8[4076]
}
struct eAVEncCommonRateControlMode extends Int32 {
    static eAVEncCommonRateControlMode_CBR := 0
    static eAVEncCommonRateControlMode_PeakConstrainedVBR := 1
    static eAVEncCommonRateControlMode_UnconstrainedVBR := 2
    static eAVEncCommonRateControlMode_Quality := 3
    static eAVEncCommonRateControlMode_LowDelayVBR := 4
    static eAVEncCommonRateControlMode_GlobalVBR := 5
    static eAVEncCommonRateControlMode_GlobalLowDelayVBR := 6
}
struct eAVEncCommonStreamEndHandling extends Int32 {
    static eAVEncCommonStreamEndHandling_DiscardPartial := 0
    static eAVEncCommonStreamEndHandling_EnsureComplete := 1
}
struct eAVEncVideoOutputFrameRateConversion extends Int32 {
    static eAVEncVideoOutputFrameRateConversion_Disable := 0
    static eAVEncVideoOutputFrameRateConversion_Enable := 1
    static eAVEncVideoOutputFrameRateConversion_Alias := 2
}
struct eAVDecVideoSoftwareDeinterlaceMode extends Int32 {
    static eAVDecVideoSoftwareDeinterlaceMode_NoDeinterlacing := 0
    static eAVDecVideoSoftwareDeinterlaceMode_ProgressiveDeinterlacing := 1
    static eAVDecVideoSoftwareDeinterlaceMode_BOBDeinterlacing := 2
    static eAVDecVideoSoftwareDeinterlaceMode_SmartBOBDeinterlacing := 3
}
struct eAVFastDecodeMode extends Int32 {
    static eVideoDecodeCompliant := 0
    static eVideoDecodeOptimalLF := 1
    static eVideoDecodeDisableLF := 2
    static eVideoDecodeFastest := 32
}
struct eAVDecVideoH264ErrorConcealment extends Int32 {
    static eErrorConcealmentTypeDrop := 0
    static eErrorConcealmentTypeBasic := 1
    static eErrorConcealmentTypeAdvanced := 2
    static eErrorConcealmentTypeDXVASetBlack := 3
}
struct eAVDecVideoMPEG2ErrorConcealment extends Int32 {
    static eErrorConcealmentOff := 0
    static eErrorConcealmentOn := 1
}
struct eAVDecVideoCodecType extends Int32 {
    static eAVDecVideoCodecType_NOTPLAYING := 0
    static eAVDecVideoCodecType_MPEG2 := 1
    static eAVDecVideoCodecType_H264 := 2
}
struct eAVDecVideoDXVAMode extends Int32 {
    static eAVDecVideoDXVAMode_NOTPLAYING := 0
    static eAVDecVideoDXVAMode_SW := 1
    static eAVDecVideoDXVAMode_MC := 2
    static eAVDecVideoDXVAMode_IDCT := 3
    static eAVDecVideoDXVAMode_VLD := 4
}
struct eAVDecVideoDXVABusEncryption extends Int32 {
    static eAVDecVideoDXVABusEncryption_NONE := 0
    static eAVDecVideoDXVABusEncryption_PRIVATE := 1
    static eAVDecVideoDXVABusEncryption_AES := 2
}
struct eAVEncVideoSourceScanType extends Int32 {
    static eAVEncVideoSourceScan_Automatic := 0
    static eAVEncVideoSourceScan_Interlaced := 1
    static eAVEncVideoSourceScan_Progressive := 2
}
struct eAVEncVideoOutputScanType extends Int32 {
    static eAVEncVideoOutputScan_Progressive := 0
    static eAVEncVideoOutputScan_Interlaced := 1
    static eAVEncVideoOutputScan_SameAsInput := 2
    static eAVEncVideoOutputScan_Automatic := 3
}
struct eAVEncVideoFilmContent extends Int32 {
    static eAVEncVideoFilmContent_VideoOnly := 0
    static eAVEncVideoFilmContent_FilmOnly := 1
    static eAVEncVideoFilmContent_Mixed := 2
}
struct eAVEncVideoChromaResolution extends Int32 {
    static eAVEncVideoChromaResolution_SameAsSource := 0
    static eAVEncVideoChromaResolution_444 := 1
    static eAVEncVideoChromaResolution_422 := 2
    static eAVEncVideoChromaResolution_420 := 3
    static eAVEncVideoChromaResolution_411 := 4
}
struct eAVEncVideoChromaSubsampling extends Int32 {
    static eAVEncVideoChromaSubsamplingFormat_SameAsSource := 0
    static eAVEncVideoChromaSubsamplingFormat_ProgressiveChroma := 8
    static eAVEncVideoChromaSubsamplingFormat_Horizontally_Cosited := 4
    static eAVEncVideoChromaSubsamplingFormat_Vertically_Cosited := 2
    static eAVEncVideoChromaSubsamplingFormat_Vertically_AlignedChromaPlanes := 1
}
struct eAVEncVideoColorPrimaries extends Int32 {
    static eAVEncVideoColorPrimaries_SameAsSource := 0
    static eAVEncVideoColorPrimaries_Reserved := 1
    static eAVEncVideoColorPrimaries_BT709 := 2
    static eAVEncVideoColorPrimaries_BT470_2_SysM := 3
    static eAVEncVideoColorPrimaries_BT470_2_SysBG := 4
    static eAVEncVideoColorPrimaries_SMPTE170M := 5
    static eAVEncVideoColorPrimaries_SMPTE240M := 6
    static eAVEncVideoColorPrimaries_EBU3231 := 7
    static eAVEncVideoColorPrimaries_SMPTE_C := 8
}
struct eAVEncVideoColorTransferFunction extends Int32 {
    static eAVEncVideoColorTransferFunction_SameAsSource := 0
    static eAVEncVideoColorTransferFunction_10 := 1
    static eAVEncVideoColorTransferFunction_18 := 2
    static eAVEncVideoColorTransferFunction_20 := 3
    static eAVEncVideoColorTransferFunction_22 := 4
    static eAVEncVideoColorTransferFunction_22_709 := 5
    static eAVEncVideoColorTransferFunction_22_240M := 6
    static eAVEncVideoColorTransferFunction_22_8bit_sRGB := 7
    static eAVEncVideoColorTransferFunction_28 := 8
}
struct eAVEncVideoColorTransferMatrix extends Int32 {
    static eAVEncVideoColorTransferMatrix_SameAsSource := 0
    static eAVEncVideoColorTransferMatrix_BT709 := 1
    static eAVEncVideoColorTransferMatrix_BT601 := 2
    static eAVEncVideoColorTransferMatrix_SMPTE240M := 3
}
struct eAVEncVideoColorLighting extends Int32 {
    static eAVEncVideoColorLighting_SameAsSource := 0
    static eAVEncVideoColorLighting_Unknown := 1
    static eAVEncVideoColorLighting_Bright := 2
    static eAVEncVideoColorLighting_Office := 3
    static eAVEncVideoColorLighting_Dim := 4
    static eAVEncVideoColorLighting_Dark := 5
}
struct eAVEncVideoColorNominalRange extends Int32 {
    static eAVEncVideoColorNominalRange_SameAsSource := 0
    static eAVEncVideoColorNominalRange_0_255 := 1
    static eAVEncVideoColorNominalRange_16_235 := 2
    static eAVEncVideoColorNominalRange_48_208 := 3
}
struct eAVEncInputVideoSystem extends Int32 {
    static eAVEncInputVideoSystem_Unspecified := 0
    static eAVEncInputVideoSystem_PAL := 1
    static eAVEncInputVideoSystem_NTSC := 2
    static eAVEncInputVideoSystem_SECAM := 3
    static eAVEncInputVideoSystem_MAC := 4
    static eAVEncInputVideoSystem_HDV := 5
    static eAVEncInputVideoSystem_Component := 6
}
struct eAVEncVideoContentType extends Int32 {
    static eAVEncVideoContentType_Unknown := 0
    static eAVEncVideoContentType_FixedCameraAngle := 1
}
struct eAVEncAdaptiveMode extends Int32 {
    static eAVEncAdaptiveMode_None := 0
    static eAVEncAdaptiveMode_Resolution := 1
    static eAVEncAdaptiveMode_FrameRate := 2
}
struct eAVScenarioInfo extends Int32 {
    static eAVScenarioInfo_Unknown := 0
    static eAVScenarioInfo_DisplayRemoting := 1
    static eAVScenarioInfo_VideoConference := 2
    static eAVScenarioInfo_Archive := 3
    static eAVScenarioInfo_LiveStreaming := 4
    static eAVScenarioInfo_CameraRecord := 5
    static eAVScenarioInfo_DisplayRemotingWithFeatureMap := 6
}
struct eVideoEncoderDisplayContentType extends Int32 {
    static eVideoEncoderDisplayContent_Unknown := 0
    static eVideoEncoderDisplayContent_FullScreenVideo := 1
}
struct eAVEncMuxOutput extends Int32 {
    static eAVEncMuxOutputAuto := 0
    static eAVEncMuxOutputPS := 1
    static eAVEncMuxOutputTS := 2
}
struct eAVEncAudioDualMono extends Int32 {
    static eAVEncAudioDualMono_SameAsInput := 0
    static eAVEncAudioDualMono_Off := 1
    static eAVEncAudioDualMono_On := 2
}
struct eAVEncAudioInputContent extends Int32 {
    static AVEncAudioInputContent_Unknown := 0
    static AVEncAudioInputContent_Voice := 1
    static AVEncAudioInputContent_Music := 2
}
struct eAVEncMPVProfile extends Int32 {
    static eAVEncMPVProfile_unknown := 0
    static eAVEncMPVProfile_Simple := 1
    static eAVEncMPVProfile_Main := 2
    static eAVEncMPVProfile_High := 3
    static eAVEncMPVProfile_422 := 4
}
struct eAVEncMPVLevel extends Int32 {
    static eAVEncMPVLevel_Low := 1
    static eAVEncMPVLevel_Main := 2
    static eAVEncMPVLevel_High1440 := 3
    static eAVEncMPVLevel_High := 4
}
struct eAVEncH263VProfile extends Int32 {
    static eAVEncH263VProfile_Base := 0
    static eAVEncH263VProfile_CompatibilityV2 := 1
    static eAVEncH263VProfile_CompatibilityV1 := 2
    static eAVEncH263VProfile_WirelessV2 := 3
    static eAVEncH263VProfile_WirelessV3 := 4
    static eAVEncH263VProfile_HighCompression := 5
    static eAVEncH263VProfile_Internet := 6
    static eAVEncH263VProfile_Interlace := 7
    static eAVEncH263VProfile_HighLatency := 8
}
struct eAVEncH264VProfile extends Int32 {
    static eAVEncH264VProfile_unknown := 0
    static eAVEncH264VProfile_Simple := 66
    static eAVEncH264VProfile_Base := 66
    static eAVEncH264VProfile_Main := 77
    static eAVEncH264VProfile_High := 100
    static eAVEncH264VProfile_422 := 122
    static eAVEncH264VProfile_High10 := 110
    static eAVEncH264VProfile_444 := 244
    static eAVEncH264VProfile_Extended := 88
    static eAVEncH264VProfile_ScalableBase := 83
    static eAVEncH264VProfile_ScalableHigh := 86
    static eAVEncH264VProfile_MultiviewHigh := 118
    static eAVEncH264VProfile_StereoHigh := 128
    static eAVEncH264VProfile_ConstrainedBase := 256
    static eAVEncH264VProfile_UCConstrainedHigh := 257
    static eAVEncH264VProfile_UCScalableConstrainedBase := 258
    static eAVEncH264VProfile_UCScalableConstrainedHigh := 259
}
struct eAVEncH265VProfile extends Int32 {
    static eAVEncH265VProfile_unknown := 0
    static eAVEncH265VProfile_Main_420_8 := 1
    static eAVEncH265VProfile_Main_420_10 := 2
    static eAVEncH265VProfile_Main_420_12 := 3
    static eAVEncH265VProfile_Main_422_10 := 4
    static eAVEncH265VProfile_Main_422_12 := 5
    static eAVEncH265VProfile_Main_444_8 := 6
    static eAVEncH265VProfile_Main_444_10 := 7
    static eAVEncH265VProfile_Main_444_12 := 8
    static eAVEncH265VProfile_Monochrome_12 := 9
    static eAVEncH265VProfile_Monochrome_16 := 10
    static eAVEncH265VProfile_MainIntra_420_8 := 11
    static eAVEncH265VProfile_MainIntra_420_10 := 12
    static eAVEncH265VProfile_MainIntra_420_12 := 13
    static eAVEncH265VProfile_MainIntra_422_10 := 14
    static eAVEncH265VProfile_MainIntra_422_12 := 15
    static eAVEncH265VProfile_MainIntra_444_8 := 16
    static eAVEncH265VProfile_MainIntra_444_10 := 17
    static eAVEncH265VProfile_MainIntra_444_12 := 18
    static eAVEncH265VProfile_MainIntra_444_16 := 19
    static eAVEncH265VProfile_MainStill_420_8 := 20
    static eAVEncH265VProfile_MainStill_444_8 := 21
    static eAVEncH265VProfile_MainStill_444_16 := 22
}
struct eAVEncVP9VProfile extends Int32 {
    static eAVEncVP9VProfile_unknown := 0
    static eAVEncVP9VProfile_420_8 := 1
    static eAVEncVP9VProfile_420_10 := 2
    static eAVEncVP9VProfile_420_12 := 3
}
struct eAVEncAV1VProfile extends Int32 {
    static eAVEncAV1VProfile_unknown := 0
    static eAVEncAV1VProfile_Main_420_8 := 1
    static eAVEncAV1VProfile_Main_420_10 := 2
    static eAVEncAV1VProfile_Main_400_8 := 3
    static eAVEncAV1VProfile_Main_400_10 := 4
    static eAVEncAV1VProfile_High_444_8 := 5
    static eAVEncAV1VProfile_High_444_10 := 6
    static eAVEncAV1VProfile_Professional_420_12 := 7
    static eAVEncAV1VProfile_Professional_400_12 := 8
    static eAVEncAV1VProfile_Professional_444_12 := 9
    static eAVEncAV1VProfile_Professional_422_8 := 10
    static eAVEncAV1VProfile_Professional_422_10 := 11
    static eAVEncAV1VProfile_Professional_422_12 := 12
}
struct eAVEncH263PictureType extends Int32 {
    static eAVEncH263PictureType_I := 0
    static eAVEncH263PictureType_P := 1
    static eAVEncH263PictureType_B := 2
}
struct eAVEncH264PictureType extends Int32 {
    static eAVEncH264PictureType_IDR := 0
    static eAVEncH264PictureType_P := 1
    static eAVEncH264PictureType_B := 2
}
struct eAVEncAV1PictureType extends Int32 {
    static eAVEncAV1PictureType_Key := 0
    static eAVEncAV1PictureType_Intra_Only := 1
    static eAVEncAV1PictureType_Inter := 2
    static eAVEncAV1PictureType_Switch := 3
}
struct eAVEncH263VLevel extends Int32 {
    static eAVEncH263VLevel1 := 10
    static eAVEncH263VLevel2 := 20
    static eAVEncH263VLevel3 := 30
    static eAVEncH263VLevel4 := 40
    static eAVEncH263VLevel4_5 := 45
    static eAVEncH263VLevel5 := 50
    static eAVEncH263VLevel6 := 60
    static eAVEncH263VLevel7 := 70
}
struct eAVEncH264VLevel extends Int32 {
    static eAVEncH264VLevel1 := 10
    static eAVEncH264VLevel1_b := 11
    static eAVEncH264VLevel1_1 := 11
    static eAVEncH264VLevel1_2 := 12
    static eAVEncH264VLevel1_3 := 13
    static eAVEncH264VLevel2 := 20
    static eAVEncH264VLevel2_1 := 21
    static eAVEncH264VLevel2_2 := 22
    static eAVEncH264VLevel3 := 30
    static eAVEncH264VLevel3_1 := 31
    static eAVEncH264VLevel3_2 := 32
    static eAVEncH264VLevel4 := 40
    static eAVEncH264VLevel4_1 := 41
    static eAVEncH264VLevel4_2 := 42
    static eAVEncH264VLevel5 := 50
    static eAVEncH264VLevel5_1 := 51
    static eAVEncH264VLevel5_2 := 52
    static eAVEncH264VLevel6 := 60
    static eAVEncH264VLevel6_1 := 61
    static eAVEncH264VLevel6_2 := 62
}
struct eAVEncH265VLevel extends Int32 {
    static eAVEncH265VLevel1 := 30
    static eAVEncH265VLevel2 := 60
    static eAVEncH265VLevel2_1 := 63
    static eAVEncH265VLevel3 := 90
    static eAVEncH265VLevel3_1 := 93
    static eAVEncH265VLevel4 := 120
    static eAVEncH265VLevel4_1 := 123
    static eAVEncH265VLevel5 := 150
    static eAVEncH265VLevel5_1 := 153
    static eAVEncH265VLevel5_2 := 156
    static eAVEncH265VLevel6 := 180
    static eAVEncH265VLevel6_1 := 183
    static eAVEncH265VLevel6_2 := 186
}
struct eAVEncAV1VLevel extends Int32 {
    static eAVEncAV1VLevel2 := 0
    static eAVEncAV1VLevel2_1 := 1
    static eAVEncAV1VLevel3 := 4
    static eAVEncAV1VLevel3_1 := 5
    static eAVEncAV1VLevel4 := 8
    static eAVEncAV1VLevel4_1 := 9
    static eAVEncAV1VLevel5 := 12
    static eAVEncAV1VLevel5_1 := 13
    static eAVEncAV1VLevel5_2 := 14
    static eAVEncAV1VLevel5_3 := 15
    static eAVEncAV1VLevel6 := 16
    static eAVEncAV1VLevel6_1 := 17
    static eAVEncAV1VLevel6_2 := 18
    static eAVEncAV1VLevel6_3 := 19
}
struct eAVEncMPVFrameFieldMode extends Int32 {
    static eAVEncMPVFrameFieldMode_FieldMode := 0
    static eAVEncMPVFrameFieldMode_FrameMode := 1
}
struct eAVEncMPVSceneDetection extends Int32 {
    static eAVEncMPVSceneDetection_None := 0
    static eAVEncMPVSceneDetection_InsertIPicture := 1
    static eAVEncMPVSceneDetection_StartNewGOP := 2
    static eAVEncMPVSceneDetection_StartNewLocatableGOP := 3
}
struct eAVEncMPVScanPattern extends Int32 {
    static eAVEncMPVScanPattern_Auto := 0
    static eAVEncMPVScanPattern_ZigZagScan := 1
    static eAVEncMPVScanPattern_AlternateScan := 2
}
struct eAVEncMPVQScaleType extends Int32 {
    static eAVEncMPVQScaleType_Auto := 0
    static eAVEncMPVQScaleType_Linear := 1
    static eAVEncMPVQScaleType_NonLinear := 2
}
struct eAVEncMPVIntraVLCTable extends Int32 {
    static eAVEncMPVIntraVLCTable_Auto := 0
    static eAVEncMPVIntraVLCTable_MPEG1 := 1
    static eAVEncMPVIntraVLCTable_Alternate := 2
}
struct eAVEncMPALayer extends Int32 {
    static eAVEncMPALayer_1 := 1
    static eAVEncMPALayer_2 := 2
    static eAVEncMPALayer_3 := 3
}
struct eAVEncMPACodingMode extends Int32 {
    static eAVEncMPACodingMode_Mono := 0
    static eAVEncMPACodingMode_Stereo := 1
    static eAVEncMPACodingMode_DualChannel := 2
    static eAVEncMPACodingMode_JointStereo := 3
    static eAVEncMPACodingMode_Surround := 4
}
struct eAVEncMPAEmphasisType extends Int32 {
    static eAVEncMPAEmphasisType_None := 0
    static eAVEncMPAEmphasisType_50_15 := 1
    static eAVEncMPAEmphasisType_Reserved := 2
    static eAVEncMPAEmphasisType_CCITT_J17 := 3
}
struct eAVEncDDService extends Int32 {
    static eAVEncDDService_CM := 0
    static eAVEncDDService_ME := 1
    static eAVEncDDService_VI := 2
    static eAVEncDDService_HI := 3
    static eAVEncDDService_D := 4
    static eAVEncDDService_C := 5
    static eAVEncDDService_E := 6
    static eAVEncDDService_VO := 7
}
struct eAVEncDDProductionRoomType extends Int32 {
    static eAVEncDDProductionRoomType_NotIndicated := 0
    static eAVEncDDProductionRoomType_Large := 1
    static eAVEncDDProductionRoomType_Small := 2
}
struct eAVEncDDDynamicRangeCompressionControl extends Int32 {
    static eAVEncDDDynamicRangeCompressionControl_None := 0
    static eAVEncDDDynamicRangeCompressionControl_FilmStandard := 1
    static eAVEncDDDynamicRangeCompressionControl_FilmLight := 2
    static eAVEncDDDynamicRangeCompressionControl_MusicStandard := 3
    static eAVEncDDDynamicRangeCompressionControl_MusicLight := 4
    static eAVEncDDDynamicRangeCompressionControl_Speech := 5
}
struct eAVEncDDSurroundExMode extends Int32 {
    static eAVEncDDSurroundExMode_NotIndicated := 0
    static eAVEncDDSurroundExMode_No := 1
    static eAVEncDDSurroundExMode_Yes := 2
}
struct eAVEncDDPreferredStereoDownMixMode extends Int32 {
    static eAVEncDDPreferredStereoDownMixMode_LtRt := 0
    static eAVEncDDPreferredStereoDownMixMode_LoRo := 1
}
struct eAVEncDDAtoDConverterType extends Int32 {
    static eAVEncDDAtoDConverterType_Standard := 0
    static eAVEncDDAtoDConverterType_HDCD := 1
}
struct eAVEncDDHeadphoneMode extends Int32 {
    static eAVEncDDHeadphoneMode_NotIndicated := 0
    static eAVEncDDHeadphoneMode_NotEncoded := 1
    static eAVEncDDHeadphoneMode_Encoded := 2
}
struct eAVDecVideoInputScanType extends Int32 {
    static eAVDecVideoInputScan_Unknown := 0
    static eAVDecVideoInputScan_Progressive := 1
    static eAVDecVideoInputScan_Interlaced_UpperFieldFirst := 2
    static eAVDecVideoInputScan_Interlaced_LowerFieldFirst := 3
}
struct eAVDecVideoSWPowerLevel extends Int32 {
    static eAVDecVideoSWPowerLevel_BatteryLife := 0
    static eAVDecVideoSWPowerLevel_Balanced := 50
    static eAVDecVideoSWPowerLevel_VideoQuality := 100
}
struct eAVDecAACDownmixMode extends Int32 {
    static eAVDecAACUseISODownmix := 0
    static eAVDecAACUseARIBDownmix := 1
}
struct eAVDecHEAACDynamicRangeControl extends Int32 {
    static eAVDecHEAACDynamicRangeControl_OFF := 0
    static eAVDecHEAACDynamicRangeControl_ON := 1
}
struct eAVDecAudioDualMono extends Int32 {
    static eAVDecAudioDualMono_IsNotDualMono := 0
    static eAVDecAudioDualMono_IsDualMono := 1
    static eAVDecAudioDualMono_UnSpecified := 2
}
struct eAVDecAudioDualMonoReproMode extends Int32 {
    static eAVDecAudioDualMonoReproMode_STEREO := 0
    static eAVDecAudioDualMonoReproMode_LEFT_MONO := 1
    static eAVDecAudioDualMonoReproMode_RIGHT_MONO := 2
    static eAVDecAudioDualMonoReproMode_MIX_MONO := 3
}
struct eAVAudioChannelConfig extends Int32 {
    static eAVAudioChannelConfig_FRONT_LEFT := 1
    static eAVAudioChannelConfig_FRONT_RIGHT := 2
    static eAVAudioChannelConfig_FRONT_CENTER := 4
    static eAVAudioChannelConfig_LOW_FREQUENCY := 8
    static eAVAudioChannelConfig_BACK_LEFT := 16
    static eAVAudioChannelConfig_BACK_RIGHT := 32
    static eAVAudioChannelConfig_FRONT_LEFT_OF_CENTER := 64
    static eAVAudioChannelConfig_FRONT_RIGHT_OF_CENTER := 128
    static eAVAudioChannelConfig_BACK_CENTER := 256
    static eAVAudioChannelConfig_SIDE_LEFT := 512
    static eAVAudioChannelConfig_SIDE_RIGHT := 1024
    static eAVAudioChannelConfig_TOP_CENTER := 2048
    static eAVAudioChannelConfig_TOP_FRONT_LEFT := 4096
    static eAVAudioChannelConfig_TOP_FRONT_CENTER := 8192
    static eAVAudioChannelConfig_TOP_FRONT_RIGHT := 16384
    static eAVAudioChannelConfig_TOP_BACK_LEFT := 32768
    static eAVAudioChannelConfig_TOP_BACK_CENTER := 65536
    static eAVAudioChannelConfig_TOP_BACK_RIGHT := 131072
}
struct eAVDDSurroundMode extends Int32 {
    static eAVDDSurroundMode_NotIndicated := 0
    static eAVDDSurroundMode_No := 1
    static eAVDDSurroundMode_Yes := 2
}
struct eAVDecDDOperationalMode extends Int32 {
    static eAVDecDDOperationalMode_NONE := 0
    static eAVDecDDOperationalMode_LINE := 1
    static eAVDecDDOperationalMode_RF := 2
    static eAVDecDDOperationalMode_CUSTOM0 := 3
    static eAVDecDDOperationalMode_CUSTOM1 := 4
    static eAVDecDDOperationalMode_PORTABLE8 := 5
    static eAVDecDDOperationalMode_PORTABLE11 := 6
    static eAVDecDDOperationalMode_PORTABLE14 := 7
    static eAVDecDDOperationalMode_PORTABLE16 := 8
}
struct eAVDecDDMatrixDecodingMode extends Int32 {
    static eAVDecDDMatrixDecodingMode_OFF := 0
    static eAVDecDDMatrixDecodingMode_ON := 1
    static eAVDecDDMatrixDecodingMode_AUTO := 2
}
struct eAVDecDDStereoDownMixMode extends Int32 {
    static eAVDecDDStereoDownMixMode_Auto := 0
    static eAVDecDDStereoDownMixMode_LtRt := 1
    static eAVDecDDStereoDownMixMode_LoRo := 2
}
struct eAVDSPLoudnessEqualization extends Int32 {
    static eAVDSPLoudnessEqualization_OFF := 0
    static eAVDSPLoudnessEqualization_ON := 1
    static eAVDSPLoudnessEqualization_AUTO := 2
}
struct eAVDSPSpeakerFill extends Int32 {
    static eAVDSPSpeakerFill_OFF := 0
    static eAVDSPSpeakerFill_ON := 1
    static eAVDSPSpeakerFill_AUTO := 2
}
struct eAVEncChromaEncodeMode extends Int32 {
    static eAVEncChromaEncodeMode_420 := 0
    static eAVEncChromaEncodeMode_444 := 1
    static eAVEncChromaEncodeMode_444_v2 := 2
}
struct eAVEncVideoD3D12ReconstructedPictureOutputMode extends Int32 {
    static eAVEncVideoEncodeD3D12ReconstructedPictureMode_None := 0
    static eAVEncVideoEncodeD3D12ReconstructedPictureMode_Copy := 1
    static eAVEncVideoEncodeD3D12ReconstructedPictureMode_Shared := 2
}
struct eAV1EncoderOperatingMode extends Int32 {
    static eAV1EncoderOperatingMode_Auto := 0
    static eAV1EncoderOperatingMode_Reference := 1
    static eAV1EncoderOperatingMode_Optimized := 2
}
struct DXVAHD_FRAME_FORMAT extends Int32 {
    static DXVAHD_FRAME_FORMAT_PROGRESSIVE := 0
    static DXVAHD_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST := 1
    static DXVAHD_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST := 2
}
struct DXVAHD_DEVICE_USAGE extends Int32 {
    static DXVAHD_DEVICE_USAGE_PLAYBACK_NORMAL := 0
    static DXVAHD_DEVICE_USAGE_OPTIMAL_SPEED := 1
    static DXVAHD_DEVICE_USAGE_OPTIMAL_QUALITY := 2
}
struct DXVAHD_SURFACE_TYPE extends Int32 {
    static DXVAHD_SURFACE_TYPE_VIDEO_INPUT := 0
    static DXVAHD_SURFACE_TYPE_VIDEO_INPUT_PRIVATE := 1
    static DXVAHD_SURFACE_TYPE_VIDEO_OUTPUT := 2
}
struct DXVAHD_DEVICE_TYPE extends Int32 {
    static DXVAHD_DEVICE_TYPE_HARDWARE := 0
    static DXVAHD_DEVICE_TYPE_SOFTWARE := 1
    static DXVAHD_DEVICE_TYPE_REFERENCE := 2
    static DXVAHD_DEVICE_TYPE_OTHER := 3
}
struct DXVAHD_DEVICE_CAPS extends Int32 {
    static DXVAHD_DEVICE_CAPS_LINEAR_SPACE := 1
    static DXVAHD_DEVICE_CAPS_xvYCC := 2
    static DXVAHD_DEVICE_CAPS_RGB_RANGE_CONVERSION := 4
    static DXVAHD_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION := 8
}
struct DXVAHD_FEATURE_CAPS extends Int32 {
    static DXVAHD_FEATURE_CAPS_ALPHA_FILL := 1
    static DXVAHD_FEATURE_CAPS_CONSTRICTION := 2
    static DXVAHD_FEATURE_CAPS_LUMA_KEY := 4
    static DXVAHD_FEATURE_CAPS_ALPHA_PALETTE := 8
}
struct DXVAHD_FILTER_CAPS extends Int32 {
    static DXVAHD_FILTER_CAPS_BRIGHTNESS := 1
    static DXVAHD_FILTER_CAPS_CONTRAST := 2
    static DXVAHD_FILTER_CAPS_HUE := 4
    static DXVAHD_FILTER_CAPS_SATURATION := 8
    static DXVAHD_FILTER_CAPS_NOISE_REDUCTION := 16
    static DXVAHD_FILTER_CAPS_EDGE_ENHANCEMENT := 32
    static DXVAHD_FILTER_CAPS_ANAMORPHIC_SCALING := 64
}
struct DXVAHD_INPUT_FORMAT_CAPS extends Int32 {
    static DXVAHD_INPUT_FORMAT_CAPS_RGB_INTERLACED := 1
    static DXVAHD_INPUT_FORMAT_CAPS_RGB_PROCAMP := 2
    static DXVAHD_INPUT_FORMAT_CAPS_RGB_LUMA_KEY := 4
    static DXVAHD_INPUT_FORMAT_CAPS_PALETTE_INTERLACED := 8
}
struct DXVAHD_PROCESSOR_CAPS extends Int32 {
    static DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BLEND := 1
    static DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BOB := 2
    static DXVAHD_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE := 4
    static DXVAHD_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION := 8
    static DXVAHD_PROCESSOR_CAPS_INVERSE_TELECINE := 16
    static DXVAHD_PROCESSOR_CAPS_FRAME_RATE_CONVERSION := 32
}
struct DXVAHD_ITELECINE_CAPS extends Int32 {
    static DXVAHD_ITELECINE_CAPS_32 := 1
    static DXVAHD_ITELECINE_CAPS_22 := 2
    static DXVAHD_ITELECINE_CAPS_2224 := 4
    static DXVAHD_ITELECINE_CAPS_2332 := 8
    static DXVAHD_ITELECINE_CAPS_32322 := 16
    static DXVAHD_ITELECINE_CAPS_55 := 32
    static DXVAHD_ITELECINE_CAPS_64 := 64
    static DXVAHD_ITELECINE_CAPS_87 := 128
    static DXVAHD_ITELECINE_CAPS_222222222223 := 256
    static DXVAHD_ITELECINE_CAPS_OTHER := -2147483648
}
struct DXVAHD_FILTER extends Int32 {
    static DXVAHD_FILTER_BRIGHTNESS := 0
    static DXVAHD_FILTER_CONTRAST := 1
    static DXVAHD_FILTER_HUE := 2
    static DXVAHD_FILTER_SATURATION := 3
    static DXVAHD_FILTER_NOISE_REDUCTION := 4
    static DXVAHD_FILTER_EDGE_ENHANCEMENT := 5
    static DXVAHD_FILTER_ANAMORPHIC_SCALING := 6
}
struct DXVAHD_BLT_STATE extends Int32 {
    static DXVAHD_BLT_STATE_TARGET_RECT := 0
    static DXVAHD_BLT_STATE_BACKGROUND_COLOR := 1
    static DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE := 2
    static DXVAHD_BLT_STATE_ALPHA_FILL := 3
    static DXVAHD_BLT_STATE_CONSTRICTION := 4
    static DXVAHD_BLT_STATE_PRIVATE := 1000
}
struct DXVAHD_ALPHA_FILL_MODE extends Int32 {
    static DXVAHD_ALPHA_FILL_MODE_OPAQUE := 0
    static DXVAHD_ALPHA_FILL_MODE_BACKGROUND := 1
    static DXVAHD_ALPHA_FILL_MODE_DESTINATION := 2
    static DXVAHD_ALPHA_FILL_MODE_SOURCE_STREAM := 3
}
struct DXVAHD_STREAM_STATE extends Int32 {
    static DXVAHD_STREAM_STATE_D3DFORMAT := 0
    static DXVAHD_STREAM_STATE_FRAME_FORMAT := 1
    static DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE := 2
    static DXVAHD_STREAM_STATE_OUTPUT_RATE := 3
    static DXVAHD_STREAM_STATE_SOURCE_RECT := 4
    static DXVAHD_STREAM_STATE_DESTINATION_RECT := 5
    static DXVAHD_STREAM_STATE_ALPHA := 6
    static DXVAHD_STREAM_STATE_PALETTE := 7
    static DXVAHD_STREAM_STATE_LUMA_KEY := 8
    static DXVAHD_STREAM_STATE_ASPECT_RATIO := 9
    static DXVAHD_STREAM_STATE_FILTER_BRIGHTNESS := 100
    static DXVAHD_STREAM_STATE_FILTER_CONTRAST := 101
    static DXVAHD_STREAM_STATE_FILTER_HUE := 102
    static DXVAHD_STREAM_STATE_FILTER_SATURATION := 103
    static DXVAHD_STREAM_STATE_FILTER_NOISE_REDUCTION := 104
    static DXVAHD_STREAM_STATE_FILTER_EDGE_ENHANCEMENT := 105
    static DXVAHD_STREAM_STATE_FILTER_ANAMORPHIC_SCALING := 106
    static DXVAHD_STREAM_STATE_PRIVATE := 1000
}
struct DXVAHD_OUTPUT_RATE extends Int32 {
    static DXVAHD_OUTPUT_RATE_NORMAL := 0
    static DXVAHD_OUTPUT_RATE_HALF := 1
    static DXVAHD_OUTPUT_RATE_CUSTOM := 2
}
struct DXVAHD_RATIONAL {
    Numerator : UInt32
    Denominator : UInt32
}
struct DXVAHD_COLOR_RGBA {
    R : Float32
    G : Float32
    B : Float32
    A : Float32
}
struct DXVAHD_COLOR_YCbCrA {
    Y : Float32
    Cb : Float32
    Cr : Float32
    A : Float32
}
struct DXVAHD_COLOR {
    union {
        RGB : DXVAHD_COLOR_RGBA
        YCbCr : DXVAHD_COLOR_YCbCrA
    }
}
struct DXVAHD_CONTENT_DESC {
    InputFrameFormat : DXVAHD_FRAME_FORMAT
    InputFrameRate : DXVAHD_RATIONAL
    InputWidth : UInt32
    InputHeight : UInt32
    OutputFrameRate : DXVAHD_RATIONAL
    OutputWidth : UInt32
    OutputHeight : UInt32
}
struct DXVAHD_VPDEVCAPS {
    DeviceType : DXVAHD_DEVICE_TYPE
    DeviceCaps : UInt32
    FeatureCaps : UInt32
    FilterCaps : UInt32
    InputFormatCaps : UInt32
    InputPool : D3DPOOL
    OutputFormatCount : UInt32
    InputFormatCount : UInt32
    VideoProcessorCount : UInt32
    MaxInputStreams : UInt32
    MaxStreamStates : UInt32
}
struct DXVAHD_VPCAPS {
    VPGuid : GUID
    PastFrames : UInt32
    FutureFrames : UInt32
    ProcessorCaps : UInt32
    ITelecineCaps : UInt32
    CustomRateCount : UInt32
}
struct DXVAHD_CUSTOM_RATE_DATA {
    CustomRate : DXVAHD_RATIONAL
    OutputFrames : UInt32
    InputInterlaced : BOOL
    InputFramesOrFields : UInt32
}
struct DXVAHD_FILTER_RANGE_DATA {
    Minimum : Int32
    Maximum : Int32
    Default : Int32
    Multiplier : Float32
}
struct DXVAHD_BLT_STATE_TARGET_RECT_DATA {
    Enable : BOOL
    TargetRect : RECT
}
struct DXVAHD_BLT_STATE_BACKGROUND_COLOR_DATA {
    YCbCr : BOOL
    BackgroundColor : DXVAHD_COLOR
}
struct DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE_DATA {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DXVAHD_BLT_STATE_ALPHA_FILL_DATA {
    Mode : DXVAHD_ALPHA_FILL_MODE
    StreamNumber : UInt32
}
struct DXVAHD_BLT_STATE_CONSTRICTION_DATA {
    Enable : BOOL
    Size : SIZE
}
struct DXVAHD_BLT_STATE_PRIVATE_DATA {
    Guid : GUID
    DataSize : UInt32
    pData : Struct.Ptr
}
struct DXVAHD_STREAM_STATE_D3DFORMAT_DATA {
    Format : D3DFORMAT
}
struct DXVAHD_STREAM_STATE_FRAME_FORMAT_DATA {
    FrameFormat : DXVAHD_FRAME_FORMAT
}
struct DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE_DATA {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DXVAHD_STREAM_STATE_OUTPUT_RATE_DATA {
    RepeatFrame : BOOL
    OutputRate : DXVAHD_OUTPUT_RATE
    CustomRate : DXVAHD_RATIONAL
}
struct DXVAHD_STREAM_STATE_SOURCE_RECT_DATA {
    Enable : BOOL
    SourceRect : RECT
}
struct DXVAHD_STREAM_STATE_DESTINATION_RECT_DATA {
    Enable : BOOL
    DestinationRect : RECT
}
struct DXVAHD_STREAM_STATE_ALPHA_DATA {
    Enable : BOOL
    Alpha : Float32
}
struct DXVAHD_STREAM_STATE_PALETTE_DATA {
    Count : UInt32
    pEntries : UInt32.Ptr
}
struct DXVAHD_STREAM_STATE_LUMA_KEY_DATA {
    Enable : BOOL
    Lower : Float32
    Upper : Float32
}
struct DXVAHD_STREAM_STATE_ASPECT_RATIO_DATA {
    Enable : BOOL
    SourceAspectRatio : DXVAHD_RATIONAL
    DestinationAspectRatio : DXVAHD_RATIONAL
}
struct DXVAHD_STREAM_STATE_FILTER_DATA {
    Enable : BOOL
    Level : Int32
}
struct DXVAHD_STREAM_STATE_PRIVATE_DATA {
    Guid : GUID
    DataSize : UInt32
    pData : Struct.Ptr
}
struct DXVAHD_STREAM_DATA {
    Enable : BOOL
    OutputIndex : UInt32
    InputFrameOrField : UInt32
    PastFrames : UInt32
    FutureFrames : UInt32
    ppPastSurfaces : IDirect3DSurface9.Ptr
    pInputSurface : IDirect3DSurface9
    ppFutureSurfaces : IDirect3DSurface9.Ptr
}
struct DXVAHD_STREAM_STATE_PRIVATE_IVTC_DATA {
    Enable : BOOL
    ITelecineFlags : UInt32
    Frames : UInt32
    InputField : UInt32
}
struct IDXVAHD_Device extends IUnknown {
    static IID := "{95F12DFD-D77E-49BE-815F-57D579634D6D}"
    CreateVideoSurface(Width, Height, Format, Pool, Usage, Type, ppSurfaces, pSharedHandle?)
      => ComCall(3, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DPOOL, Pool, UInt32, Usage, DXVAHD_SURFACE_TYPE, Type, UInt32, ppSurfaces.Length, IDirect3DSurface9.Ptr, ppSurfaces, HANDLE.Ptr, pSharedHandle?)
    GetVideoProcessorDeviceCaps(pCaps)
      => ComCall(4, this.p, DXVAHD_VPDEVCAPS.Ptr, pCaps)
    GetVideoProcessorOutputFormats(pFormats)
      => ComCall(5, this.p, UInt32, pFormats.Length, D3DFORMAT.Ptr, pFormats)
    GetVideoProcessorInputFormats(pFormats)
      => ComCall(6, this.p, UInt32, pFormats.Length, D3DFORMAT.Ptr, pFormats)
    GetVideoProcessorCaps(pCaps)
      => ComCall(7, this.p, UInt32, pCaps.Length, DXVAHD_VPCAPS.Ptr, pCaps)
    GetVideoProcessorCustomRates(pVPGuid, pRates)
      => ComCall(8, this.p, GUID.Ptr, pVPGuid, UInt32, pRates.Length, DXVAHD_CUSTOM_RATE_DATA.Ptr, pRates)
    GetVideoProcessorFilterRange(Filter, pRange)
      => ComCall(9, this.p, DXVAHD_FILTER, Filter, DXVAHD_FILTER_RANGE_DATA.Ptr, pRange)
    CreateVideoProcessor(pVPGuid, ppVideoProcessor)
      => ComCall(10, this.p, GUID.Ptr, pVPGuid, IDXVAHD_VideoProcessor.Ptr, ppVideoProcessor)
}
struct IDXVAHD_VideoProcessor extends IUnknown {
    static IID := "{95F4EDF4-6E03-4CD7-BE1B-3075D665AA52}"
    SetVideoProcessBltState(State, pData)
      => ComCall(3, this.p, DXVAHD_BLT_STATE, State, UInt32, pData.Size, Struct.Ptr, pData)
    GetVideoProcessBltState(State, pData)
      => ComCall(4, this.p, DXVAHD_BLT_STATE, State, UInt32, pData.Size, Struct.Ptr, pData)
    SetVideoProcessStreamState(StreamNumber, State, pData)
      => ComCall(5, this.p, UInt32, StreamNumber, DXVAHD_STREAM_STATE, State, UInt32, pData.Size, Struct.Ptr, pData)
    GetVideoProcessStreamState(StreamNumber, State, pData)
      => ComCall(6, this.p, UInt32, StreamNumber, DXVAHD_STREAM_STATE, State, UInt32, pData.Size, Struct.Ptr, pData)
    VideoProcessBltHD(pOutputSurface, OutputFrame, pStreams)
      => ComCall(7, this.p, IDirect3DSurface9, pOutputSurface, UInt32, OutputFrame, UInt32, pStreams.Length, DXVAHD_STREAM_DATA.Ptr, pStreams)
}
struct PDXVAHDSW_CreateDevice extends FunctionPointer {
    static Types := [IDirect3DDevice9Ex, HANDLE.Ptr, HRESULT]
}
struct PDXVAHDSW_ProposeVideoPrivateFormat extends FunctionPointer {
    static Types := [HANDLE, D3DFORMAT.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorDeviceCaps extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_CONTENT_DESC.Ptr, DXVAHD_DEVICE_USAGE, DXVAHD_VPDEVCAPS.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorOutputFormats extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_CONTENT_DESC.Ptr, DXVAHD_DEVICE_USAGE, UInt32, D3DFORMAT.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorInputFormats extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_CONTENT_DESC.Ptr, DXVAHD_DEVICE_USAGE, UInt32, D3DFORMAT.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorCaps extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_CONTENT_DESC.Ptr, DXVAHD_DEVICE_USAGE, UInt32, DXVAHD_VPCAPS.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorCustomRates extends FunctionPointer {
    static Types := [HANDLE, GUID.Ptr, UInt32, DXVAHD_CUSTOM_RATE_DATA.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessorFilterRange extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_FILTER, DXVAHD_FILTER_RANGE_DATA.Ptr, HRESULT]
}
struct PDXVAHDSW_DestroyDevice extends FunctionPointer {
    static Types := [HANDLE, HRESULT]
}
struct PDXVAHDSW_CreateVideoProcessor extends FunctionPointer {
    static Types := [HANDLE, GUID.Ptr, HANDLE.Ptr, HRESULT]
}
struct PDXVAHDSW_SetVideoProcessBltState extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_BLT_STATE, UInt32, Struct.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessBltStatePrivate extends FunctionPointer {
    static Types := [HANDLE, DXVAHD_BLT_STATE_PRIVATE_DATA.Ptr, HRESULT]
}
struct PDXVAHDSW_SetVideoProcessStreamState extends FunctionPointer {
    static Types := [HANDLE, UInt32, DXVAHD_STREAM_STATE, UInt32, Struct.Ptr, HRESULT]
}
struct PDXVAHDSW_GetVideoProcessStreamStatePrivate extends FunctionPointer {
    static Types := [HANDLE, UInt32, DXVAHD_STREAM_STATE_PRIVATE_DATA.Ptr, HRESULT]
}
struct PDXVAHDSW_VideoProcessBltHD extends FunctionPointer {
    static Types := [HANDLE, IDirect3DSurface9, UInt32, UInt32, DXVAHD_STREAM_DATA.Ptr, HRESULT]
}
struct PDXVAHDSW_DestroyVideoProcessor extends FunctionPointer {
    static Types := [HANDLE, HRESULT]
}
struct DXVAHDSW_CALLBACKS {
    CreateDevice : PDXVAHDSW_CreateDevice
    ProposeVideoPrivateFormat : PDXVAHDSW_ProposeVideoPrivateFormat
    GetVideoProcessorDeviceCaps : PDXVAHDSW_GetVideoProcessorDeviceCaps
    GetVideoProcessorOutputFormats : PDXVAHDSW_GetVideoProcessorOutputFormats
    GetVideoProcessorInputFormats : PDXVAHDSW_GetVideoProcessorInputFormats
    GetVideoProcessorCaps : PDXVAHDSW_GetVideoProcessorCaps
    GetVideoProcessorCustomRates : PDXVAHDSW_GetVideoProcessorCustomRates
    GetVideoProcessorFilterRange : PDXVAHDSW_GetVideoProcessorFilterRange
    DestroyDevice : PDXVAHDSW_DestroyDevice
    CreateVideoProcessor : PDXVAHDSW_CreateVideoProcessor
    SetVideoProcessBltState : PDXVAHDSW_SetVideoProcessBltState
    GetVideoProcessBltStatePrivate : PDXVAHDSW_GetVideoProcessBltStatePrivate
    SetVideoProcessStreamState : PDXVAHDSW_SetVideoProcessStreamState
    GetVideoProcessStreamStatePrivate : PDXVAHDSW_GetVideoProcessStreamStatePrivate
    VideoProcessBltHD : PDXVAHDSW_VideoProcessBltHD
    DestroyVideoProcessor : PDXVAHDSW_DestroyVideoProcessor
}
struct PDXVAHDSW_Plugin extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, HRESULT]
}
struct DXVAHDETW_CREATEVIDEOPROCESSOR {
    pObject : Int64
    pD3D9Ex : Int64
    VPGuid : GUID
}
struct DXVAHDETW_VIDEOPROCESSBLTSTATE {
    pObject : Int64
    State : DXVAHD_BLT_STATE
    DataSize : UInt32
    SetState : BOOL
}
struct DXVAHDETW_VIDEOPROCESSSTREAMSTATE {
    pObject : Int64
    StreamNumber : UInt32
    State : DXVAHD_STREAM_STATE
    DataSize : UInt32
    SetState : BOOL
}
struct DXVAHDETW_VIDEOPROCESSBLTHD {
    pObject : Int64
    pOutputSurface : Int64
    TargetRect : RECT
    OutputFormat : D3DFORMAT
    ColorSpace : UInt32
    OutputFrame : UInt32
    StreamCount : UInt32
    Enter : BOOL
}
struct DXVAHDETW_VIDEOPROCESSBLTHD_STREAM {
    pObject : Int64
    pInputSurface : Int64
    SourceRect : RECT
    DestinationRect : RECT
    InputFormat : D3DFORMAT
    FrameFormat : DXVAHD_FRAME_FORMAT
    ColorSpace : UInt32
    StreamNumber : UInt32
    OutputIndex : UInt32
    InputFrameOrField : UInt32
    PastFrames : UInt32
    FutureFrames : UInt32
}
struct DXVAHDETW_DESTROYVIDEOPROCESSOR {
    pObject : Int64
}
struct PDXVAHD_CreateDevice extends FunctionPointer {
    static Types := [IDirect3DDevice9Ex, DXVAHD_CONTENT_DESC.Ptr, DXVAHD_DEVICE_USAGE, PDXVAHDSW_Plugin, IDXVAHD_Device.Ptr, HRESULT]
}
struct DXVA2_ExtendedFormat {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DXVA2_SampleFormat extends Int32 {
    static DXVA2_SampleFormatMask := 255
    static DXVA2_SampleUnknown := 0
    static DXVA2_SampleProgressiveFrame := 2
    static DXVA2_SampleFieldInterleavedEvenFirst := 3
    static DXVA2_SampleFieldInterleavedOddFirst := 4
    static DXVA2_SampleFieldSingleEven := 5
    static DXVA2_SampleFieldSingleOdd := 6
    static DXVA2_SampleSubStream := 7
}
struct DXVA2_VideoChromaSubSampling extends Int32 {
    static DXVA2_VideoChromaSubsamplingMask := 15
    static DXVA2_VideoChromaSubsampling_Unknown := 0
    static DXVA2_VideoChromaSubsampling_ProgressiveChroma := 8
    static DXVA2_VideoChromaSubsampling_Horizontally_Cosited := 4
    static DXVA2_VideoChromaSubsampling_Vertically_Cosited := 2
    static DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes := 1
    static DXVA2_VideoChromaSubsampling_MPEG2 := 5
    static DXVA2_VideoChromaSubsampling_MPEG1 := 1
    static DXVA2_VideoChromaSubsampling_DV_PAL := 6
    static DXVA2_VideoChromaSubsampling_Cosited := 7
}
struct DXVA2_NominalRange extends Int32 {
    static DXVA2_NominalRangeMask := 7
    static DXVA2_NominalRange_Unknown := 0
    static DXVA2_NominalRange_Normal := 1
    static DXVA2_NominalRange_Wide := 2
    static DXVA2_NominalRange_0_255 := 1
    static DXVA2_NominalRange_16_235 := 2
    static DXVA2_NominalRange_48_208 := 3
}
struct DXVA2_VideoTransferMatrix extends Int32 {
    static DXVA2_VideoTransferMatrixMask := 7
    static DXVA2_VideoTransferMatrix_Unknown := 0
    static DXVA2_VideoTransferMatrix_BT709 := 1
    static DXVA2_VideoTransferMatrix_BT601 := 2
    static DXVA2_VideoTransferMatrix_SMPTE240M := 3
}
struct DXVA2_VideoLighting extends Int32 {
    static DXVA2_VideoLightingMask := 15
    static DXVA2_VideoLighting_Unknown := 0
    static DXVA2_VideoLighting_bright := 1
    static DXVA2_VideoLighting_office := 2
    static DXVA2_VideoLighting_dim := 3
    static DXVA2_VideoLighting_dark := 4
}
struct DXVA2_VideoPrimaries extends Int32 {
    static DXVA2_VideoPrimariesMask := 31
    static DXVA2_VideoPrimaries_Unknown := 0
    static DXVA2_VideoPrimaries_reserved := 1
    static DXVA2_VideoPrimaries_BT709 := 2
    static DXVA2_VideoPrimaries_BT470_2_SysM := 3
    static DXVA2_VideoPrimaries_BT470_2_SysBG := 4
    static DXVA2_VideoPrimaries_SMPTE170M := 5
    static DXVA2_VideoPrimaries_SMPTE240M := 6
    static DXVA2_VideoPrimaries_EBU3213 := 7
    static DXVA2_VideoPrimaries_SMPTE_C := 8
}
struct DXVA2_VideoTransferFunction extends Int32 {
    static DXVA2_VideoTransFuncMask := 31
    static DXVA2_VideoTransFunc_Unknown := 0
    static DXVA2_VideoTransFunc_10 := 1
    static DXVA2_VideoTransFunc_18 := 2
    static DXVA2_VideoTransFunc_20 := 3
    static DXVA2_VideoTransFunc_22 := 4
    static DXVA2_VideoTransFunc_709 := 5
    static DXVA2_VideoTransFunc_240M := 6
    static DXVA2_VideoTransFunc_sRGB := 7
    static DXVA2_VideoTransFunc_28 := 8
}
struct DXVA2_Frequency {
    Numerator : UInt32
    Denominator : UInt32
}
struct DXVA2_VideoDesc {
    SampleWidth : UInt32
    SampleHeight : UInt32
    SampleFormat : DXVA2_ExtendedFormat
    Format : D3DFORMAT
    InputSampleFreq : DXVA2_Frequency
    OutputFrameFreq : DXVA2_Frequency
    UABProtectionLevel : UInt32
    Reserved : UInt32
}
struct DXVA2_DeinterlaceTech extends Int32 {
    static DXVA2_DeinterlaceTech_Unknown := 0
    static DXVA2_DeinterlaceTech_BOBLineReplicate := 1
    static DXVA2_DeinterlaceTech_BOBVerticalStretch := 2
    static DXVA2_DeinterlaceTech_BOBVerticalStretch4Tap := 4
    static DXVA2_DeinterlaceTech_MedianFiltering := 8
    static DXVA2_DeinterlaceTech_EdgeFiltering := 16
    static DXVA2_DeinterlaceTech_FieldAdaptive := 32
    static DXVA2_DeinterlaceTech_PixelAdaptive := 64
    static DXVA2_DeinterlaceTech_MotionVectorSteered := 128
    static DXVA2_DeinterlaceTech_InverseTelecine := 256
    static DXVA2_DeinterlaceTech_Mask := 511
}
struct DXVA2_FilterType extends Int32 {
    static DXVA2_NoiseFilterLumaLevel := 1
    static DXVA2_NoiseFilterLumaThreshold := 2
    static DXVA2_NoiseFilterLumaRadius := 3
    static DXVA2_NoiseFilterChromaLevel := 4
    static DXVA2_NoiseFilterChromaThreshold := 5
    static DXVA2_NoiseFilterChromaRadius := 6
    static DXVA2_DetailFilterLumaLevel := 7
    static DXVA2_DetailFilterLumaThreshold := 8
    static DXVA2_DetailFilterLumaRadius := 9
    static DXVA2_DetailFilterChromaLevel := 10
    static DXVA2_DetailFilterChromaThreshold := 11
    static DXVA2_DetailFilterChromaRadius := 12
}
struct DXVA2_NoiseFilterTech extends Int32 {
    static DXVA2_NoiseFilterTech_Unsupported := 0
    static DXVA2_NoiseFilterTech_Unknown := 1
    static DXVA2_NoiseFilterTech_Median := 2
    static DXVA2_NoiseFilterTech_Temporal := 4
    static DXVA2_NoiseFilterTech_BlockNoise := 8
    static DXVA2_NoiseFilterTech_MosquitoNoise := 16
    static DXVA2_NoiseFilterTech_Mask := 31
}
struct DXVA2_DetailFilterTech extends Int32 {
    static DXVA2_DetailFilterTech_Unsupported := 0
    static DXVA2_DetailFilterTech_Unknown := 1
    static DXVA2_DetailFilterTech_Edge := 2
    static DXVA2_DetailFilterTech_Sharpening := 4
    static DXVA2_DetailFilterTech_Mask := 7
}
struct DXVA2_ProcAmp extends Int32 {
    static DXVA2_ProcAmp_None := 0
    static DXVA2_ProcAmp_Brightness := 1
    static DXVA2_ProcAmp_Contrast := 2
    static DXVA2_ProcAmp_Hue := 4
    static DXVA2_ProcAmp_Saturation := 8
    static DXVA2_ProcAmp_Mask := 15
}
struct DXVA2_VideoProcess extends Int32 {
    static DXVA2_VideoProcess_None := 0
    static DXVA2_VideoProcess_YUV2RGB := 1
    static DXVA2_VideoProcess_StretchX := 2
    static DXVA2_VideoProcess_StretchY := 4
    static DXVA2_VideoProcess_AlphaBlend := 8
    static DXVA2_VideoProcess_SubRects := 16
    static DXVA2_VideoProcess_SubStreams := 32
    static DXVA2_VideoProcess_SubStreamsExtended := 64
    static DXVA2_VideoProcess_YUV2RGBExtended := 128
    static DXVA2_VideoProcess_AlphaBlendExtended := 256
    static DXVA2_VideoProcess_Constriction := 512
    static DXVA2_VideoProcess_NoiseFilter := 1024
    static DXVA2_VideoProcess_DetailFilter := 2048
    static DXVA2_VideoProcess_PlanarAlpha := 4096
    static DXVA2_VideoProcess_LinearScaling := 8192
    static DXVA2_VideoProcess_GammaCompensated := 16384
    static DXVA2_VideoProcess_MaintainsOriginalFieldData := 32768
    static DXVA2_VideoProcess_Mask := 65535
}
struct DXVA2_VPDev extends Int32 {
    static DXVA2_VPDev_HardwareDevice := 1
    static DXVA2_VPDev_EmulatedDXVA1 := 2
    static DXVA2_VPDev_SoftwareDevice := 4
    static DXVA2_VPDev_Mask := 7
}
struct DXVA2_SampleData extends Int32 {
    static DXVA2_SampleData_RFF := 1
    static DXVA2_SampleData_TFF := 2
    static DXVA2_SampleData_RFF_TFF_Present := 4
    static DXVA2_SampleData_Mask := 65535
}
struct DXVA2_DestData extends Int32 {
    static DXVA2_DestData_RFF := 1
    static DXVA2_DestData_TFF := 2
    static DXVA2_DestData_RFF_TFF_Present := 4
    static DXVA2_DestData_Mask := 65535
}
struct DXVA2_VideoProcessorCaps {
    DeviceCaps : UInt32
    InputPool : D3DPOOL
    NumForwardRefSamples : UInt32
    NumBackwardRefSamples : UInt32
    Reserved : UInt32
    DeinterlaceTechnology : UInt32
    ProcAmpControlCaps : UInt32
    VideoProcessorOperations : UInt32
    NoiseFilterTechnology : UInt32
    DetailFilterTechnology : UInt32
}
struct DXVA2_Fixed32 {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ll : Int32
        }
        struct _Anonymous_e__Struct {
            Fraction : UInt16
            Value : Int16
        }
    }
}
struct DXVA2_AYUVSample8 {
    Cr : UInt8
    Cb : UInt8
    Y : UInt8
    Alpha : UInt8
}
struct DXVA2_AYUVSample16 {
    Cr : UInt16
    Cb : UInt16
    Y : UInt16
    Alpha : UInt16
}
struct DXVA2_VideoSample {
    Start : Int64
    End : Int64
    SampleFormat : DXVA2_ExtendedFormat
    SrcSurface : IDirect3DSurface9
    SrcRect : RECT
    DstRect : RECT
    Pal : DXVA2_AYUVSample8[16]
    PlanarAlpha : DXVA2_Fixed32
    SampleData : UInt32
}
struct DXVA2_ValueRange {
    MinValue : DXVA2_Fixed32
    MaxValue : DXVA2_Fixed32
    DefaultValue : DXVA2_Fixed32
    StepSize : DXVA2_Fixed32
}
struct DXVA2_ProcAmpValues {
    Brightness : DXVA2_Fixed32
    Contrast : DXVA2_Fixed32
    Hue : DXVA2_Fixed32
    Saturation : DXVA2_Fixed32
}
struct DXVA2_FilterValues {
    Level : DXVA2_Fixed32
    Threshold : DXVA2_Fixed32
    Radius : DXVA2_Fixed32
}
struct DXVA2_VideoProcessBltParams {
    TargetFrame : Int64
    TargetRect : RECT
    ConstrictionSize : SIZE
    StreamingFlags : UInt32
    BackgroundColor : DXVA2_AYUVSample16
    DestFormat : DXVA2_ExtendedFormat
    ProcAmpValues : DXVA2_ProcAmpValues
    Alpha : DXVA2_Fixed32
    NoiseFilterLuma : DXVA2_FilterValues
    NoiseFilterChroma : DXVA2_FilterValues
    DetailFilterLuma : DXVA2_FilterValues
    DetailFilterChroma : DXVA2_FilterValues
    DestData : UInt32
}
struct DXVA2_BufferfType extends Int32 {
    static DXVA2_PictureParametersBufferType := 0
    static DXVA2_MacroBlockControlBufferType := 1
    static DXVA2_ResidualDifferenceBufferType := 2
    static DXVA2_DeblockingControlBufferType := 3
    static DXVA2_InverseQuantizationMatrixBufferType := 4
    static DXVA2_SliceControlBufferType := 5
    static DXVA2_BitStreamDateBufferType := 6
    static DXVA2_MotionVectorBuffer := 7
    static DXVA2_FilmGrainBuffer := 8
}
struct DXVA2_VideoRenderTargetType extends Int32 {
    static DXVA2_VideoDecoderRenderTarget := 0
    static DXVA2_VideoProcessorRenderTarget := 1
    static DXVA2_VideoSoftwareRenderTarget := 2
}
struct DXVA2_ConfigPictureDecode {
    guidConfigBitstreamEncryption : GUID
    guidConfigMBcontrolEncryption : GUID
    guidConfigResidDiffEncryption : GUID
    ConfigBitstreamRaw : UInt32
    ConfigMBcontrolRasterOrder : UInt32
    ConfigResidDiffHost : UInt32
    ConfigSpatialResid8 : UInt32
    ConfigResid8Subtraction : UInt32
    ConfigSpatialHost8or9Clipping : UInt32
    ConfigSpatialResidInterleaved : UInt32
    ConfigIntraResidUnsigned : UInt32
    ConfigResidDiffAccelerator : UInt32
    ConfigHostInverseScan : UInt32
    ConfigSpecificIDCT : UInt32
    Config4GroupedCoefs : UInt32
    ConfigMinRenderTargetBuffCount : UInt16
    ConfigDecoderSpecific : UInt16
}
struct DXVA2_DecodeBufferDesc {
    CompressedBufferType : UInt32
    BufferIndex : UInt32
    DataOffset : UInt32
    DataSize : UInt32
    FirstMBaddress : UInt32
    NumMBsInBuffer : UInt32
    Width : UInt32
    Height : UInt32
    Stride : UInt32
    ReservedBits : UInt32
    pvPVPState : Struct.Ptr
}
struct DXVA2_AES_CTR_IV {
    IV : Int64
    Count : Int64
}
struct DXVA2_DecodeExtensionData {
    Function : UInt32
    pPrivateInputData : Struct.Ptr
    PrivateInputDataSize : UInt32
    pPrivateOutputData : Struct.Ptr
    PrivateOutputDataSize : UInt32
}
struct DXVA2_DecodeExecuteParams {
    NumCompBuffers : UInt32
    pCompressedBuffers : DXVA2_DecodeBufferDesc.Ptr
    pExtensionData : DXVA2_DecodeExtensionData.Ptr
}
struct IDirect3DDeviceManager9 extends IUnknown {
    static IID := "{A0CADE0F-06D5-4CF4-A1C7-F3CDD725AA75}"
    ResetDevice(pDevice, resetToken)
      => ComCall(3, this.p, IDirect3DDevice9, pDevice, UInt32, resetToken)
    OpenDeviceHandle(phDevice)
      => ComCall(4, this.p, HANDLE.Ptr, phDevice)
    CloseDeviceHandle(hDevice)
      => ComCall(5, this.p, HANDLE, hDevice)
    TestDevice(hDevice)
      => ComCall(6, this.p, HANDLE, hDevice)
    LockDevice(hDevice, ppDevice, fBlock)
      => ComCall(7, this.p, HANDLE, hDevice, IDirect3DDevice9.Ptr, ppDevice, BOOL, fBlock)
    UnlockDevice(hDevice, fSaveState)
      => ComCall(8, this.p, HANDLE, hDevice, BOOL, fSaveState)
    GetVideoService(hDevice, riid, ppService)
      => ComCall(9, this.p, HANDLE, hDevice, GUID.Ptr, riid, Struct.Ptr.Ptr, ppService)
}
struct IDirectXVideoAccelerationService extends IUnknown {
    static IID := "{FC51A550-D5E7-11D9-AF55-00054E43FF02}"
    CreateSurface(Width, Height, BackBuffers, Format, Pool, Usage, DxvaType, ppSurface, pSharedHandle?)
      => ComCall(3, this.p, UInt32, Width, UInt32, Height, UInt32, BackBuffers, D3DFORMAT, Format, D3DPOOL, Pool, UInt32, Usage, UInt32, DxvaType, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle?)
}
struct IDirectXVideoDecoderService extends IDirectXVideoAccelerationService {
    static IID := "{FC51A551-D5E7-11D9-AF55-00054E43FF02}"
    GetDecoderDeviceGuids(pCount, pGuids)
      => ComCall(4, this.p, UInt32.Ptr, pCount, GUID.Ptr.Ptr, pGuids)
    GetDecoderRenderTargets(Guid, pCount, pFormats)
      => ComCall(5, this.p, GUID.Ptr, Guid, UInt32.Ptr, pCount, D3DFORMAT.Ptr.Ptr, pFormats)
    GetDecoderConfigurations(Guid, pVideoDesc, pCount, ppConfigs)
      => ComCall(6, this.p, GUID.Ptr, Guid, DXVA2_VideoDesc.Ptr, pVideoDesc, "Ptr", 0, UInt32.Ptr, pCount, DXVA2_ConfigPictureDecode.Ptr.Ptr, ppConfigs)
    CreateVideoDecoder(Guid, pVideoDesc, pConfig, ppDecoderRenderTargets, ppDecode)
      => ComCall(7, this.p, GUID.Ptr, Guid, DXVA2_VideoDesc.Ptr, pVideoDesc, DXVA2_ConfigPictureDecode.Ptr, pConfig, IDirect3DSurface9.Ptr, ppDecoderRenderTargets, UInt32, ppDecoderRenderTargets.Length, IDirectXVideoDecoder.Ptr, ppDecode)
}
struct IDirectXVideoProcessorService extends IDirectXVideoAccelerationService {
    static IID := "{FC51A552-D5E7-11D9-AF55-00054E43FF02}"
    RegisterVideoProcessorSoftwareDevice(pCallbacks)
      => ComCall(4, this.p, Struct.Ptr, pCallbacks)
    GetVideoProcessorDeviceGuids(pVideoDesc, pCount, pGuids)
      => ComCall(5, this.p, DXVA2_VideoDesc.Ptr, pVideoDesc, UInt32.Ptr, pCount, GUID.Ptr.Ptr, pGuids)
    GetVideoProcessorRenderTargets(VideoProcDeviceGuid, pVideoDesc, pCount, pFormats)
      => ComCall(6, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, UInt32.Ptr, pCount, D3DFORMAT.Ptr.Ptr, pFormats)
    GetVideoProcessorSubStreamFormats(VideoProcDeviceGuid, pVideoDesc, RenderTargetFormat, pCount, pFormats)
      => ComCall(7, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, D3DFORMAT, RenderTargetFormat, UInt32.Ptr, pCount, D3DFORMAT.Ptr.Ptr, pFormats)
    GetVideoProcessorCaps(VideoProcDeviceGuid, pVideoDesc, RenderTargetFormat, pCaps)
      => ComCall(8, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, D3DFORMAT, RenderTargetFormat, DXVA2_VideoProcessorCaps.Ptr, pCaps)
    GetProcAmpRange(VideoProcDeviceGuid, pVideoDesc, RenderTargetFormat, ProcAmpCap, pRange)
      => ComCall(9, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, D3DFORMAT, RenderTargetFormat, UInt32, ProcAmpCap, DXVA2_ValueRange.Ptr, pRange)
    GetFilterPropertyRange(VideoProcDeviceGuid, pVideoDesc, RenderTargetFormat, FilterSetting, pRange)
      => ComCall(10, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, D3DFORMAT, RenderTargetFormat, UInt32, FilterSetting, DXVA2_ValueRange.Ptr, pRange)
    CreateVideoProcessor(VideoProcDeviceGuid, pVideoDesc, RenderTargetFormat, MaxNumSubStreams, ppVidProcess)
      => ComCall(11, this.p, GUID.Ptr, VideoProcDeviceGuid, DXVA2_VideoDesc.Ptr, pVideoDesc, D3DFORMAT, RenderTargetFormat, UInt32, MaxNumSubStreams, IDirectXVideoProcessor.Ptr, ppVidProcess)
}
struct IDirectXVideoDecoder extends IUnknown {
    static IID := "{F2B0810A-FD00-43C9-918C-DF94E2D8EF7D}"
    GetVideoDecoderService(ppService)
      => ComCall(3, this.p, IDirectXVideoDecoderService.Ptr, ppService)
    GetCreationParameters(pDeviceGuid?, pVideoDesc?, pConfig?, pDecoderRenderTargets)
      => ComCall(4, this.p, GUID.Ptr, pDeviceGuid?, DXVA2_VideoDesc.Ptr, pVideoDesc?, DXVA2_ConfigPictureDecode.Ptr, pConfig?, IDirect3DSurface9.Ptr.Ptr, pDecoderRenderTargets, UInt32.Ptr, pDecoderRenderTargets.Length)
    GetBuffer(BufferType, ppBuffer, pBufferSize)
      => ComCall(5, this.p, UInt32, BufferType, Struct.Ptr.Ptr, ppBuffer, UInt32.Ptr, pBufferSize)
    ReleaseBuffer(BufferType)
      => ComCall(6, this.p, UInt32, BufferType)
    BeginFrame(pRenderTarget, pvPVPData?)
      => ComCall(7, this.p, IDirect3DSurface9, pRenderTarget, Struct.Ptr, pvPVPData?)
    EndFrame(pHandleComplete?)
      => ComCall(8, this.p, HANDLE.Ptr, pHandleComplete?)
    Execute(pExecuteParams)
      => ComCall(9, this.p, DXVA2_DecodeExecuteParams.Ptr, pExecuteParams)
}
struct IDirectXVideoProcessor extends IUnknown {
    static IID := "{8C3A39F0-916E-4690-804F-4C8001355D25}"
    GetVideoProcessorService(ppService)
      => ComCall(3, this.p, IDirectXVideoProcessorService.Ptr, ppService)
    GetCreationParameters(pDeviceGuid?, pVideoDesc?, pRenderTargetFormat?, pMaxNumSubStreams?)
      => ComCall(4, this.p, GUID.Ptr, pDeviceGuid?, DXVA2_VideoDesc.Ptr, pVideoDesc?, D3DFORMAT.Ptr, pRenderTargetFormat?, UInt32.Ptr, pMaxNumSubStreams?)
    GetVideoProcessorCaps(pCaps)
      => ComCall(5, this.p, DXVA2_VideoProcessorCaps.Ptr, pCaps)
    GetProcAmpRange(ProcAmpCap, pRange)
      => ComCall(6, this.p, UInt32, ProcAmpCap, DXVA2_ValueRange.Ptr, pRange)
    GetFilterPropertyRange(FilterSetting, pRange)
      => ComCall(7, this.p, UInt32, FilterSetting, DXVA2_ValueRange.Ptr, pRange)
    VideoProcessBlt(pRenderTarget, pBltParams, pSamples, pHandleComplete?)
      => ComCall(8, this.p, IDirect3DSurface9, pRenderTarget, DXVA2_VideoProcessBltParams.Ptr, pBltParams, DXVA2_VideoSample.Ptr, pSamples, UInt32, pSamples.Length, HANDLE.Ptr, pHandleComplete?)
}
struct DXVA2_SurfaceType extends Int32 {
    static DXVA2_SurfaceType_DecoderRenderTarget := 0
    static DXVA2_SurfaceType_ProcessorRenderTarget := 1
    static DXVA2_SurfaceType_D3DRenderTargetTexture := 2
}
struct IDirectXVideoMemoryConfiguration extends IUnknown {
    static IID := "{B7F916DD-DB3B-49C1-84D7-E45EF99EC726}"
    GetAvailableSurfaceTypeByIndex(dwTypeIndex, pdwType)
      => ComCall(3, this.p, UInt32, dwTypeIndex, DXVA2_SurfaceType.Ptr, pdwType)
    SetSurfaceType(dwType)
      => ComCall(4, this.p, DXVA2_SurfaceType, dwType)
}
struct OPM_TYPE extends Int32 {
    static OPM_OMAC_SIZE := 16
    static OPM_128_BIT_RANDOM_NUMBER_SIZE := 16
    static OPM_ENCRYPTED_INITIALIZATION_PARAMETERS_SIZE := 256
    static OPM_CONFIGURE_SETTING_DATA_SIZE := 4056
    static OPM_GET_INFORMATION_PARAMETERS_SIZE := 4056
    static OPM_REQUESTED_INFORMATION_SIZE := 4076
    static OPM_HDCP_KEY_SELECTION_VECTOR_SIZE := 5
    static OPM_PROTECTION_TYPE_SIZE := 4
    static OPM_BUS_TYPE_MASK := 65535
    static OPM_BUS_IMPLEMENTATION_MODIFIER_MASK := 32767
}
struct OPM_VIDEO_OUTPUT_SEMANTICS extends Int32 {
    static OPM_VOS_COPP_SEMANTICS := 0
    static OPM_VOS_OPM_SEMANTICS := 1
    static OPM_VOS_OPM_INDIRECT_DISPLAY := 2
}
struct OPM_HDCP_FLAGS extends Int32 {
    static OPM_HDCP_FLAG_NONE := 0
    static OPM_HDCP_FLAG_REPEATER := 1
}
struct OPM_STATUS extends Int32 {
    static OPM_STATUS_NORMAL := 0
    static OPM_STATUS_LINK_LOST := 1
    static OPM_STATUS_RENEGOTIATION_REQUIRED := 2
    static OPM_STATUS_TAMPERING_DETECTED := 4
    static OPM_STATUS_REVOKED_HDCP_DEVICE_ATTACHED := 8
}
struct OPM_CONNECTOR_TYPE extends Int32 {
    static OPM_CONNECTOR_TYPE_OTHER := -1
    static OPM_CONNECTOR_TYPE_VGA := 0
    static OPM_CONNECTOR_TYPE_SVIDEO := 1
    static OPM_CONNECTOR_TYPE_COMPOSITE_VIDEO := 2
    static OPM_CONNECTOR_TYPE_COMPONENT_VIDEO := 3
    static OPM_CONNECTOR_TYPE_DVI := 4
    static OPM_CONNECTOR_TYPE_HDMI := 5
    static OPM_CONNECTOR_TYPE_LVDS := 6
    static OPM_CONNECTOR_TYPE_D_JPN := 8
    static OPM_CONNECTOR_TYPE_SDI := 9
    static OPM_CONNECTOR_TYPE_DISPLAYPORT_EXTERNAL := 10
    static OPM_CONNECTOR_TYPE_DISPLAYPORT_EMBEDDED := 11
    static OPM_CONNECTOR_TYPE_UDI_EXTERNAL := 12
    static OPM_CONNECTOR_TYPE_UDI_EMBEDDED := 13
    static OPM_CONNECTOR_TYPE_RESERVED := 14
    static OPM_CONNECTOR_TYPE_MIRACAST := 15
    static OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_A := 16
    static OPM_CONNECTOR_TYPE_TRANSPORT_AGNOSTIC_DIGITAL_MODE_B := 17
    static OPM_COPP_COMPATIBLE_CONNECTOR_TYPE_INTERNAL := -2147483648
}
struct OPM_DVI_CHARACTERISTIC extends Int32 {
    static OPM_DVI_CHARACTERISTIC_1_0 := 1
    static OPM_DVI_CHARACTERISTIC_1_1_OR_ABOVE := 2
}
struct OPM_OUTPUT_HARDWARE_PROTECTION extends Int32 {
    static OPM_OUTPUT_HARDWARE_PROTECTION_NOT_SUPPORTED := 0
    static OPM_OUTPUT_HARDWARE_PROTECTION_SUPPORTED := 1
}
struct OPM_BUS_TYPE extends Int32 {
    static OPM_BUS_TYPE_OTHER := 0
    static OPM_BUS_TYPE_PCI := 1
    static OPM_BUS_TYPE_PCIX := 2
    static OPM_BUS_TYPE_PCIEXPRESS := 3
    static OPM_BUS_TYPE_AGP := 4
    static OPM_BUS_IMPLEMENTATION_MODIFIER_INSIDE_OF_CHIPSET := 65536
    static OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP := 131072
    static OPM_BUS_IMPLEMENTATION_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET := 196608
    static OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR := 262144
    static OPM_BUS_IMPLEMENTATION_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE := 327680
    static OPM_BUS_IMPLEMENTATION_MODIFIER_NON_STANDARD := -2147483648
    static OPM_COPP_COMPATIBLE_BUS_TYPE_INTEGRATED := -2147483648
}
struct OPM_DPCP_PROTECTION_LEVEL extends Int32 {
    static OPM_DPCP_OFF := 0
    static OPM_DPCP_ON := 1
}
struct OPM_HDCP_PROTECTION_LEVEL extends Int32 {
    static OPM_HDCP_OFF := 0
    static OPM_HDCP_ON := 1
}
struct OPM_TYPE_ENFORCEMENT_HDCP_PROTECTION_LEVEL extends Int32 {
    static OPM_TYPE_ENFORCEMENT_HDCP_OFF := 0
    static OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_NO_TYPE_RESTRICTION := 1
    static OPM_TYPE_ENFORCEMENT_HDCP_ON_WITH_TYPE1_RESTRICTION := 2
}
struct OPM_CGMSA extends Int32 {
    static OPM_CGMSA_OFF := 0
    static OPM_CGMSA_COPY_FREELY := 1
    static OPM_CGMSA_COPY_NO_MORE := 2
    static OPM_CGMSA_COPY_ONE_GENERATION := 3
    static OPM_CGMSA_COPY_NEVER := 4
    static OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED := 8
}
struct OPM_ACP_PROTECTION_LEVEL extends Int32 {
    static OPM_ACP_OFF := 0
    static OPM_ACP_LEVEL_ONE := 1
    static OPM_ACP_LEVEL_TWO := 2
    static OPM_ACP_LEVEL_THREE := 3
}
struct OPM_PROTECTION_TYPE extends Int32 {
    static OPM_PROTECTION_TYPE_OTHER := -2147483648
    static OPM_PROTECTION_TYPE_NONE := 0
    static OPM_PROTECTION_TYPE_COPP_COMPATIBLE_HDCP := 1
    static OPM_PROTECTION_TYPE_ACP := 2
    static OPM_PROTECTION_TYPE_CGMSA := 4
    static OPM_PROTECTION_TYPE_HDCP := 8
    static OPM_PROTECTION_TYPE_DPCP := 16
    static OPM_PROTECTION_TYPE_TYPE_ENFORCEMENT_HDCP := 32
}
struct OPM_PROTECTION_STANDARD_TYPE extends UInt32 {
    static OPM_PROTECTION_STANDARD_OTHER := 2147483648
    static OPM_PROTECTION_STANDARD_NONE := 0
    static OPM_PROTECTION_STANDARD_IEC61880_525I := 1
    static OPM_PROTECTION_STANDARD_IEC61880_2_525I := 2
    static OPM_PROTECTION_STANDARD_IEC62375_625P := 4
    static OPM_PROTECTION_STANDARD_EIA608B_525 := 8
    static OPM_PROTECTION_STANDARD_EN300294_625I := 16
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEA_525P := 32
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEA_750P := 64
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEA_1125I := 128
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEB_525P := 256
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEB_750P := 512
    static OPM_PROTECTION_STANDARD_CEA805A_TYPEB_1125I := 1024
    static OPM_PROTECTION_STANDARD_ARIBTRB15_525I := 2048
    static OPM_PROTECTION_STANDARD_ARIBTRB15_525P := 4096
    static OPM_PROTECTION_STANDARD_ARIBTRB15_750P := 8192
    static OPM_PROTECTION_STANDARD_ARIBTRB15_1125I := 16384
}
struct OPM_IMAGE_ASPECT_RATIO_EN300294 extends Int32 {
    static OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3 := 0
    static OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_CENTER := 1
    static OPM_ASPECT_RATIO_EN300294_BOX_14_BY_9_TOP := 2
    static OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_CENTER := 3
    static OPM_ASPECT_RATIO_EN300294_BOX_16_BY_9_TOP := 4
    static OPM_ASPECT_RATIO_EN300294_BOX_GT_16_BY_9_CENTER := 5
    static OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_4_BY_3_PROTECTED_CENTER := 6
    static OPM_ASPECT_RATIO_EN300294_FULL_FORMAT_16_BY_9_ANAMORPHIC := 7
}
struct OPM_RANDOM_NUMBER {
    abRandomNumber : UInt8[16]
}
struct OPM_OMAC {
    abOMAC : UInt8[16]
}
struct OPM_ENCRYPTED_INITIALIZATION_PARAMETERS {
    abEncryptedInitializationParameters : UInt8[256]
}
struct OPM_GET_INFO_PARAMETERS {
    omac : OPM_OMAC
    rnRandomNumber : OPM_RANDOM_NUMBER
    guidInformation : GUID
    ulSequenceNumber : UInt32
    cbParametersSize : UInt32
    abParameters : UInt8[4056]
}
struct OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS {
    rnRandomNumber : OPM_RANDOM_NUMBER
    guidInformation : GUID
    ulSequenceNumber : UInt32
    cbParametersSize : UInt32
    abParameters : UInt8[4056]
}
struct OPM_HDCP_KEY_SELECTION_VECTOR {
    abKeySelectionVector : UInt8[5]
}
struct OPM_CONNECTED_HDCP_DEVICE_INFORMATION {
    rnRandomNumber : OPM_RANDOM_NUMBER
    ulStatusFlags : UInt32
    ulHDCPFlags : UInt32
    ksvB : OPM_HDCP_KEY_SELECTION_VECTOR
    Reserved : UInt8[11]
    Reserved2 : UInt8[16]
    Reserved3 : UInt8[16]
}
struct OPM_REQUESTED_INFORMATION {
    omac : OPM_OMAC
    cbRequestedInformationSize : UInt32
    abRequestedInformation : UInt8[4076]
}
struct OPM_STANDARD_INFORMATION {
    rnRandomNumber : OPM_RANDOM_NUMBER
    ulStatusFlags : UInt32
    ulInformation : UInt32
    ulReserved : UInt32
    ulReserved2 : UInt32
}
struct OPM_ACTUAL_OUTPUT_FORMAT {
    rnRandomNumber : OPM_RANDOM_NUMBER
    ulStatusFlags : UInt32
    ulDisplayWidth : UInt32
    ulDisplayHeight : UInt32
    dsfSampleInterleaveFormat : DXVA2_SampleFormat
    d3dFormat : D3DFORMAT
    ulFrequencyNumerator : UInt32
    ulFrequencyDenominator : UInt32
}
struct OPM_ACP_AND_CGMSA_SIGNALING {
    rnRandomNumber : OPM_RANDOM_NUMBER
    ulStatusFlags : UInt32
    ulAvailableTVProtectionStandards : UInt32
    ulActiveTVProtectionStandard : UInt32
    ulReserved : UInt32
    ulAspectRatioValidMask1 : UInt32
    ulAspectRatioData1 : UInt32
    ulAspectRatioValidMask2 : UInt32
    ulAspectRatioData2 : UInt32
    ulAspectRatioValidMask3 : UInt32
    ulAspectRatioData3 : UInt32
    ulReserved2 : UInt32[4]
    ulReserved3 : UInt32[4]
}
struct OPM_OUTPUT_ID_DATA {
    rnRandomNumber : OPM_RANDOM_NUMBER
    ulStatusFlags : UInt32
    OutputId : Int64
}
struct OPM_CONFIGURE_PARAMETERS {
    omac : OPM_OMAC
    guidSetting : GUID
    ulSequenceNumber : UInt32
    cbParametersSize : UInt32
    abParameters : UInt8[4056]
}
struct OPM_SET_PROTECTION_LEVEL_PARAMETERS {
    ulProtectionType : UInt32
    ulProtectionLevel : UInt32
    Reserved : UInt32
    Reserved2 : UInt32
}
struct OPM_SET_ACP_AND_CGMSA_SIGNALING_PARAMETERS {
    ulNewTVProtectionStandard : UInt32
    ulAspectRatioChangeMask1 : UInt32
    ulAspectRatioData1 : UInt32
    ulAspectRatioChangeMask2 : UInt32
    ulAspectRatioData2 : UInt32
    ulAspectRatioChangeMask3 : UInt32
    ulAspectRatioData3 : UInt32
    ulReserved : UInt32[4]
    ulReserved2 : UInt32[4]
    ulReserved3 : UInt32
}
struct OPM_SET_HDCP_SRM_PARAMETERS {
    ulSRMVersion : UInt32
}
struct OPM_GET_CODEC_INFO_PARAMETERS {
    cbVerifier : UInt32
    Verifier : UInt8[4052]
}
struct OPM_GET_CODEC_INFO_INFORMATION {
    rnRandomNumber : OPM_RANDOM_NUMBER
    Merit : UInt32
}
struct IOPMVideoOutput extends IUnknown {
    static IID := "{0A15159D-41C7-4456-93E1-284CD61D4E8D}"
    StartInitialization(prnRandomNumber, ppbCertificate, pulCertificateLength)
      => ComCall(3, this.p, OPM_RANDOM_NUMBER.Ptr, prnRandomNumber, UInt8.Ptr.Ptr, ppbCertificate, UInt32.Ptr, pulCertificateLength)
    FinishInitialization(pParameters)
      => ComCall(4, this.p, OPM_ENCRYPTED_INITIALIZATION_PARAMETERS.Ptr, pParameters)
    GetInformation(pParameters, pRequestedInformation)
      => ComCall(5, this.p, OPM_GET_INFO_PARAMETERS.Ptr, pParameters, OPM_REQUESTED_INFORMATION.Ptr, pRequestedInformation)
    COPPCompatibleGetInformation(pParameters, pRequestedInformation)
      => ComCall(6, this.p, OPM_COPP_COMPATIBLE_GET_INFO_PARAMETERS.Ptr, pParameters, OPM_REQUESTED_INFORMATION.Ptr, pRequestedInformation)
    Configure(pParameters, pbAdditionalParameters?)
      => ComCall(7, this.p, OPM_CONFIGURE_PARAMETERS.Ptr, pParameters, UInt32, pbAdditionalParameters?.Size ?? 0, UInt8.Ptr, pbAdditionalParameters?)
}
struct KSMETHOD_OPMVIDEOOUTPUT extends Int32 {
    static KSMETHOD_OPMVIDEOOUTPUT_STARTINITIALIZATION := 0
    static KSMETHOD_OPMVIDEOOUTPUT_FINISHINITIALIZATION := 1
    static KSMETHOD_OPMVIDEOOUTPUT_GETINFORMATION := 2
}
struct MF_ATTRIBUTE_TYPE extends Int32 {
    static MF_ATTRIBUTE_UINT32 := 19
    static MF_ATTRIBUTE_UINT64 := 21
    static MF_ATTRIBUTE_DOUBLE := 5
    static MF_ATTRIBUTE_GUID := 72
    static MF_ATTRIBUTE_STRING := 31
    static MF_ATTRIBUTE_BLOB := 4113
    static MF_ATTRIBUTE_IUNKNOWN := 13
}
struct MF_ATTRIBUTES_MATCH_TYPE extends Int32 {
    static MF_ATTRIBUTES_MATCH_OUR_ITEMS := 0
    static MF_ATTRIBUTES_MATCH_THEIR_ITEMS := 1
    static MF_ATTRIBUTES_MATCH_ALL_ITEMS := 2
    static MF_ATTRIBUTES_MATCH_INTERSECTION := 3
    static MF_ATTRIBUTES_MATCH_SMALLER := 4
}
struct IMFAttributes extends IUnknown {
    static IID := "{2CD2D921-C447-44A7-A13C-4ADABFC247E3}"
    GetItem(guidKey, pValue?)
      => ComCall(3, this.p, GUID.Ptr, guidKey, PROPVARIANT.Ptr, pValue?)
    GetItemType(guidKey, pType)
      => ComCall(4, this.p, GUID.Ptr, guidKey, MF_ATTRIBUTE_TYPE.Ptr, pType)
    CompareItem(guidKey, Value, pbResult)
      => ComCall(5, this.p, GUID.Ptr, guidKey, PROPVARIANT.Ptr, Value, BOOL.Ptr, pbResult)
    Compare(pTheirs?, MatchType, pbResult)
      => ComCall(6, this.p, IMFAttributes, pTheirs?, MF_ATTRIBUTES_MATCH_TYPE, MatchType, BOOL.Ptr, pbResult)
    GetUINT32(guidKey, punValue)
      => ComCall(7, this.p, GUID.Ptr, guidKey, UInt32.Ptr, punValue)
    GetUINT64(guidKey, punValue)
      => ComCall(8, this.p, GUID.Ptr, guidKey, Int64.Ptr, punValue)
    GetDouble(guidKey, pfValue)
      => ComCall(9, this.p, GUID.Ptr, guidKey, Float64.Ptr, pfValue)
    GetGUID(guidKey, pguidValue)
      => ComCall(10, this.p, GUID.Ptr, guidKey, GUID.Ptr, pguidValue)
    GetStringLength(guidKey, pcchLength)
      => ComCall(11, this.p, GUID.Ptr, guidKey, UInt32.Ptr, pcchLength)
    GetString(guidKey, pwszValue, pcchLength?)
      => ComCall(12, this.p, GUID.Ptr, guidKey, PWSTR, pwszValue, UInt32, pwszValue.Length, UInt32.Ptr, pcchLength?)
    GetAllocatedString(guidKey, ppwszValue, pcchLength)
      => ComCall(13, this.p, GUID.Ptr, guidKey, PWSTR.Ptr, ppwszValue, UInt32.Ptr, pcchLength)
    GetBlobSize(guidKey, pcbBlobSize)
      => ComCall(14, this.p, GUID.Ptr, guidKey, UInt32.Ptr, pcbBlobSize)
    GetBlob(guidKey, pBuf, pcbBlobSize?)
      => ComCall(15, this.p, GUID.Ptr, guidKey, UInt8.Ptr, pBuf, UInt32, pBuf.Length, UInt32.Ptr, pcbBlobSize?)
    GetAllocatedBlob(guidKey, ppBuf)
      => ComCall(16, this.p, GUID.Ptr, guidKey, UInt8.Ptr.Ptr, ppBuf, UInt32.Ptr, ppBuf.Length)
    GetUnknown(guidKey, riid, ppv)
      => ComCall(17, this.p, GUID.Ptr, guidKey, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    SetItem(guidKey, Value)
      => ComCall(18, this.p, GUID.Ptr, guidKey, PROPVARIANT.Ptr, Value)
    DeleteItem(guidKey)
      => ComCall(19, this.p, GUID.Ptr, guidKey)
    DeleteAllItems()
      => ComCall(20, this.p)
    SetUINT32(guidKey, unValue)
      => ComCall(21, this.p, GUID.Ptr, guidKey, UInt32, unValue)
    SetUINT64(guidKey, unValue)
      => ComCall(22, this.p, GUID.Ptr, guidKey, Int64, unValue)
    SetDouble(guidKey, fValue)
      => ComCall(23, this.p, GUID.Ptr, guidKey, Float64, fValue)
    SetGUID(guidKey, guidValue)
      => ComCall(24, this.p, GUID.Ptr, guidKey, GUID.Ptr, guidValue)
    SetString(guidKey, wszValue)
      => ComCall(25, this.p, GUID.Ptr, guidKey, "Str", wszValue)
    SetBlob(guidKey, pBuf)
      => ComCall(26, this.p, GUID.Ptr, guidKey, UInt8.Ptr, pBuf, UInt32, pBuf.Length)
    SetUnknown(guidKey, pUnknown)
      => ComCall(27, this.p, GUID.Ptr, guidKey, IUnknown, pUnknown)
    LockStore()
      => ComCall(28, this.p)
    UnlockStore()
      => ComCall(29, this.p)
    GetCount(pcItems)
      => ComCall(30, this.p, UInt32.Ptr, pcItems)
    GetItemByIndex(unIndex, pguidKey, pValue?)
      => ComCall(31, this.p, UInt32, unIndex, GUID.Ptr, pguidKey, PROPVARIANT.Ptr, pValue?)
    CopyAllItems(pDest)
      => ComCall(32, this.p, IMFAttributes, pDest)
}
struct MF_ATTRIBUTE_SERIALIZE_OPTIONS extends Int32 {
    static MF_ATTRIBUTE_SERIALIZE_UNKNOWN_BYREF := 1
}
struct IMFMediaBuffer extends IUnknown {
    static IID := "{045FA593-8799-42B8-BC8D-8968C6453507}"
    Lock(ppbBuffer, pcbMaxLength?, pcbCurrentLength?)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppbBuffer, UInt32.Ptr, pcbMaxLength?, UInt32.Ptr, pcbCurrentLength?)
    Unlock()
      => ComCall(4, this.p)
    GetCurrentLength(pcbCurrentLength)
      => ComCall(5, this.p, UInt32.Ptr, pcbCurrentLength)
    SetCurrentLength(cbCurrentLength)
      => ComCall(6, this.p, UInt32, cbCurrentLength)
    GetMaxLength(pcbMaxLength)
      => ComCall(7, this.p, UInt32.Ptr, pcbMaxLength)
}
struct IMFSample extends IMFAttributes {
    static IID := "{C40A00F2-B93A-4D80-AE8C-5A1C634F58E4}"
    GetSampleFlags(pdwSampleFlags)
      => ComCall(33, this.p, UInt32.Ptr, pdwSampleFlags)
    SetSampleFlags(dwSampleFlags)
      => ComCall(34, this.p, UInt32, dwSampleFlags)
    GetSampleTime(phnsSampleTime)
      => ComCall(35, this.p, Int64.Ptr, phnsSampleTime)
    SetSampleTime(hnsSampleTime)
      => ComCall(36, this.p, Int64, hnsSampleTime)
    GetSampleDuration(phnsSampleDuration)
      => ComCall(37, this.p, Int64.Ptr, phnsSampleDuration)
    SetSampleDuration(hnsSampleDuration)
      => ComCall(38, this.p, Int64, hnsSampleDuration)
    GetBufferCount(pdwBufferCount)
      => ComCall(39, this.p, UInt32.Ptr, pdwBufferCount)
    GetBufferByIndex(dwIndex, ppBuffer)
      => ComCall(40, this.p, UInt32, dwIndex, IMFMediaBuffer.Ptr, ppBuffer)
    ConvertToContiguousBuffer(ppBuffer)
      => ComCall(41, this.p, IMFMediaBuffer.Ptr, ppBuffer)
    AddBuffer(pBuffer)
      => ComCall(42, this.p, IMFMediaBuffer, pBuffer)
    RemoveBufferByIndex(dwIndex)
      => ComCall(43, this.p, UInt32, dwIndex)
    RemoveAllBuffers()
      => ComCall(44, this.p)
    GetTotalLength(pcbTotalLength)
      => ComCall(45, this.p, UInt32.Ptr, pcbTotalLength)
    CopyToBuffer(pBuffer)
      => ComCall(46, this.p, IMFMediaBuffer, pBuffer)
}
struct IMF2DBuffer extends IUnknown {
    static IID := "{7DC9D5F9-9ED9-44EC-9BBF-0600BB589FBB}"
    Lock2D(ppbScanline0, plPitch)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppbScanline0, Int32.Ptr, plPitch)
    Unlock2D()
      => ComCall(4, this.p)
    GetScanline0AndPitch(pbScanline0, plPitch)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, pbScanline0, Int32.Ptr, plPitch)
    IsContiguousFormat(pfIsContiguous)
      => ComCall(6, this.p, BOOL.Ptr, pfIsContiguous)
    GetContiguousLength(pcbLength)
      => ComCall(7, this.p, UInt32.Ptr, pcbLength)
    ContiguousCopyTo(pbDestBuffer)
      => ComCall(8, this.p, UInt8.Ptr, pbDestBuffer, UInt32, pbDestBuffer.Size)
    ContiguousCopyFrom(pbSrcBuffer)
      => ComCall(9, this.p, UInt8.Ptr, pbSrcBuffer, UInt32, pbSrcBuffer.Size)
}
struct MF2DBuffer_LockFlags extends Int32 {
    static MF2DBuffer_LockFlags_LockTypeMask := 3
    static MF2DBuffer_LockFlags_Read := 1
    static MF2DBuffer_LockFlags_Write := 2
    static MF2DBuffer_LockFlags_ReadWrite := 3
    static MF2DBuffer_LockFlags_ForceDWORD := 2147483647
}
struct IMF2DBuffer2 extends IMF2DBuffer {
    static IID := "{33AE5EA6-4316-436F-8DDD-D73D22F829EC}"
    Lock2DSize(lockFlags, ppbScanline0, plPitch, ppbBufferStart, pcbBufferLength)
      => ComCall(10, this.p, MF2DBuffer_LockFlags, lockFlags, UInt8.Ptr.Ptr, ppbScanline0, Int32.Ptr, plPitch, UInt8.Ptr.Ptr, ppbBufferStart, UInt32.Ptr, pcbBufferLength)
    Copy2DTo(pDestBuffer)
      => ComCall(11, this.p, IMF2DBuffer2, pDestBuffer)
}
struct IMFDXGIBuffer extends IUnknown {
    static IID := "{E7174CFA-1C9E-48B1-8866-626226BFC258}"
    GetResource(riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetSubresourceIndex(puSubresource)
      => ComCall(4, this.p, UInt32.Ptr, puSubresource)
    GetUnknown(guid, riid, ppvObject)
      => ComCall(5, this.p, GUID.Ptr, guid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    SetUnknown(guid, pUnkData?)
      => ComCall(6, this.p, GUID.Ptr, guid, IUnknown, pUnkData?)
}
struct IMFDXGICrossAdapterBuffer extends IUnknown {
    static IID := "{B25D03FB-D148-45EF-BFED-F778B7566C07}"
    GetResourceForDevice(pUnkDevice, riid, ppvObject)
      => ComCall(3, this.p, IUnknown, pUnkDevice, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetSubresourceIndexForDevice(pUnkDevice, puSubresource)
      => ComCall(4, this.p, IUnknown, pUnkDevice, UInt32.Ptr, puSubresource)
    GetUnknownForDevice(pUnkDevice, guid, riid, ppvObject)
      => ComCall(5, this.p, IUnknown, pUnkDevice, GUID.Ptr, guid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    SetUnknownForDevice(pUnkDevice, guid, pUnkData?)
      => ComCall(6, this.p, IUnknown, pUnkDevice, GUID.Ptr, guid, IUnknown, pUnkData?)
}
struct IMFMediaType extends IMFAttributes {
    static IID := "{44AE0FA8-EA31-4109-8D2E-4CAE4997C555}"
    GetMajorType(pguidMajorType)
      => ComCall(33, this.p, GUID.Ptr, pguidMajorType)
    IsCompressedFormat(pfCompressed)
      => ComCall(34, this.p, BOOL.Ptr, pfCompressed)
    IsEqual(pIMediaType, pdwFlags)
      => ComCall(35, this.p, IMFMediaType, pIMediaType, UInt32.Ptr, pdwFlags)
    GetRepresentation(guidRepresentation, ppvRepresentation)
      => ComCall(36, this.p, GUID, guidRepresentation, Struct.Ptr.Ptr, ppvRepresentation)
    FreeRepresentation(guidRepresentation, pvRepresentation)
      => ComCall(37, this.p, GUID, guidRepresentation, Struct.Ptr, pvRepresentation)
}
struct IMFAudioMediaType extends IMFMediaType {
    static IID := "{26A0ADC3-CE26-4672-9304-69552EDD3FAF}"
    GetAudioFormat()
      => ComCall(38, this.p, WAVEFORMATEX.Ptr)
}
struct MFT_REGISTER_TYPE_INFO {
    guidMajorType : GUID
    guidSubtype : GUID
}
struct MFVideoInterlaceMode extends Int32 {
    static MFVideoInterlace_Unknown := 0
    static MFVideoInterlace_Progressive := 2
    static MFVideoInterlace_FieldInterleavedUpperFirst := 3
    static MFVideoInterlace_FieldInterleavedLowerFirst := 4
    static MFVideoInterlace_FieldSingleUpper := 5
    static MFVideoInterlace_FieldSingleLower := 6
    static MFVideoInterlace_MixedInterlaceOrProgressive := 7
    static MFVideoInterlace_Last := 8
    static MFVideoInterlace_ForceDWORD := 2147483647
}
struct MFVideoTransferFunction extends Int32 {
    static MFVideoTransFunc_Unknown := 0
    static MFVideoTransFunc_10 := 1
    static MFVideoTransFunc_18 := 2
    static MFVideoTransFunc_20 := 3
    static MFVideoTransFunc_22 := 4
    static MFVideoTransFunc_709 := 5
    static MFVideoTransFunc_240M := 6
    static MFVideoTransFunc_sRGB := 7
    static MFVideoTransFunc_28 := 8
    static MFVideoTransFunc_Log_100 := 9
    static MFVideoTransFunc_Log_316 := 10
    static MFVideoTransFunc_709_sym := 11
    static MFVideoTransFunc_2020_const := 12
    static MFVideoTransFunc_2020 := 13
    static MFVideoTransFunc_26 := 14
    static MFVideoTransFunc_2084 := 15
    static MFVideoTransFunc_HLG := 16
    static MFVideoTransFunc_10_rel := 17
    static MFVideoTransFunc_BT1361_ECG := 18
    static MFVideoTransFunc_SMPTE428 := 19
    static MFVideoTransFunc_Last := 20
    static MFVideoTransFunc_ForceDWORD := 2147483647
}
struct MFVideoPrimaries extends Int32 {
    static MFVideoPrimaries_Unknown := 0
    static MFVideoPrimaries_reserved := 1
    static MFVideoPrimaries_BT709 := 2
    static MFVideoPrimaries_BT470_2_SysM := 3
    static MFVideoPrimaries_BT470_2_SysBG := 4
    static MFVideoPrimaries_SMPTE170M := 5
    static MFVideoPrimaries_SMPTE240M := 6
    static MFVideoPrimaries_EBU3213 := 7
    static MFVideoPrimaries_SMPTE_C := 8
    static MFVideoPrimaries_BT2020 := 9
    static MFVideoPrimaries_XYZ := 10
    static MFVideoPrimaries_DCI_P3 := 11
    static MFVideoPrimaries_ACES := 12
    static MFVideoPrimaries_Display_P3 := 13
    static MFVideoPrimaries_Last := 14
    static MFVideoPrimaries_ForceDWORD := 2147483647
}
struct MFVideoLighting extends Int32 {
    static MFVideoLighting_Unknown := 0
    static MFVideoLighting_bright := 1
    static MFVideoLighting_office := 2
    static MFVideoLighting_dim := 3
    static MFVideoLighting_dark := 4
    static MFVideoLighting_Last := 5
    static MFVideoLighting_ForceDWORD := 2147483647
}
struct MFVideoTransferMatrix extends Int32 {
    static MFVideoTransferMatrix_Unknown := 0
    static MFVideoTransferMatrix_BT709 := 1
    static MFVideoTransferMatrix_BT601 := 2
    static MFVideoTransferMatrix_SMPTE240M := 3
    static MFVideoTransferMatrix_BT2020_10 := 4
    static MFVideoTransferMatrix_BT2020_12 := 5
    static MFVideoTransferMatrix_Identity := 6
    static MFVideoTransferMatrix_FCC47 := 7
    static MFVideoTransferMatrix_YCgCo := 8
    static MFVideoTransferMatrix_SMPTE2085 := 9
    static MFVideoTransferMatrix_Chroma := 10
    static MFVideoTransferMatrix_Chroma_const := 11
    static MFVideoTransferMatrix_ICtCp := 12
    static MFVideoTransferMatrix_Last := 13
    static MFVideoTransferMatrix_ForceDWORD := 2147483647
}
struct MFVideoChromaSubsampling extends Int32 {
    static MFVideoChromaSubsampling_Unknown := 0
    static MFVideoChromaSubsampling_ProgressiveChroma := 8
    static MFVideoChromaSubsampling_Horizontally_Cosited := 4
    static MFVideoChromaSubsampling_Vertically_Cosited := 2
    static MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes := 1
    static MFVideoChromaSubsampling_MPEG2 := 5
    static MFVideoChromaSubsampling_MPEG1 := 1
    static MFVideoChromaSubsampling_DV_PAL := 6
    static MFVideoChromaSubsampling_Cosited := 7
    static MFVideoChromaSubsampling_Last := 8
    static MFVideoChromaSubsampling_ForceDWORD := 2147483647
}
struct MFNominalRange extends Int32 {
    static MFNominalRange_Unknown := 0
    static MFNominalRange_Normal := 1
    static MFNominalRange_Wide := 2
    static MFNominalRange_0_255 := 1
    static MFNominalRange_16_235 := 2
    static MFNominalRange_48_208 := 3
    static MFNominalRange_64_127 := 4
    static MFNominalRange_Last := 5
    static MFNominalRange_ForceDWORD := 2147483647
}
struct MFVideoFlags extends Int32 {
    static MFVideoFlag_PAD_TO_Mask := 3
    static MFVideoFlag_PAD_TO_None := 0
    static MFVideoFlag_PAD_TO_4x3 := 1
    static MFVideoFlag_PAD_TO_16x9 := 2
    static MFVideoFlag_SrcContentHintMask := 28
    static MFVideoFlag_SrcContentHintNone := 0
    static MFVideoFlag_SrcContentHint16x9 := 4
    static MFVideoFlag_SrcContentHint235_1 := 8
    static MFVideoFlag_AnalogProtected := 32
    static MFVideoFlag_DigitallyProtected := 64
    static MFVideoFlag_ProgressiveContent := 128
    static MFVideoFlag_FieldRepeatCountMask := 1792
    static MFVideoFlag_FieldRepeatCountShift := 8
    static MFVideoFlag_ProgressiveSeqReset := 2048
    static MFVideoFlag_PanScanEnabled := 131072
    static MFVideoFlag_LowerFieldFirst := 262144
    static MFVideoFlag_BottomUpLinearRep := 524288
    static MFVideoFlags_DXVASurface := 1048576
    static MFVideoFlags_RenderTargetSurface := 4194304
    static MFVideoFlags_ForceQWORD := 2147483647
}
struct MFRatio {
    Numerator : UInt32
    Denominator : UInt32
}
struct MFOffset {
    fract : UInt16
    value : Int16
}
struct MFVideoArea {
    OffsetX : MFOffset
    OffsetY : MFOffset
    Area : SIZE
}
struct MFVideoInfo {
    dwWidth : UInt32
    dwHeight : UInt32
    PixelAspectRatio : MFRatio
    SourceChromaSubsampling : MFVideoChromaSubsampling
    InterlaceMode : MFVideoInterlaceMode
    TransferFunction : MFVideoTransferFunction
    ColorPrimaries : MFVideoPrimaries
    TransferMatrix : MFVideoTransferMatrix
    SourceLighting : MFVideoLighting
    FramesPerSecond : MFRatio
    NominalRange : MFNominalRange
    GeometricAperture : MFVideoArea
    MinimumDisplayAperture : MFVideoArea
    PanScanAperture : MFVideoArea
    VideoFlags : Int64
}
struct MFAYUVSample {
    bCrValue : UInt8
    bCbValue : UInt8
    bYValue : UInt8
    bSampleAlpha8 : UInt8
}
struct MFARGB {
    rgbBlue : UInt8
    rgbGreen : UInt8
    rgbRed : UInt8
    rgbAlpha : UInt8
}
struct MFPaletteEntry {
    union {
        ARGB : MFARGB
        AYCbCr : MFAYUVSample
    }
}
struct MFVideoSurfaceInfo {
    Format : UInt32
    PaletteEntries : UInt32
    Palette : MFPaletteEntry[1]
}
struct MFVideoCompressedInfo {
    AvgBitrate : Int64
    AvgBitErrorRate : Int64
    MaxKeyFrameSpacing : UInt32
}
struct MFVIDEOFORMAT {
    dwSize : UInt32
    videoInfo : MFVideoInfo
    guidFormat : GUID
    compressedInfo : MFVideoCompressedInfo
    surfaceInfo : MFVideoSurfaceInfo
}
struct MFStandardVideoFormat extends Int32 {
    static MFStdVideoFormat_reserved := 0
    static MFStdVideoFormat_NTSC := 1
    static MFStdVideoFormat_PAL := 2
    static MFStdVideoFormat_DVD_NTSC := 3
    static MFStdVideoFormat_DVD_PAL := 4
    static MFStdVideoFormat_DV_PAL := 5
    static MFStdVideoFormat_DV_NTSC := 6
    static MFStdVideoFormat_ATSC_SD480i := 7
    static MFStdVideoFormat_ATSC_HD1080i := 8
    static MFStdVideoFormat_ATSC_HD720p := 9
}
struct IMFVideoMediaType extends IMFMediaType {
    static IID := "{B99F381F-A8F9-47A2-A5AF-CA3A225A3890}"
    GetVideoFormat()
      => ComCall(38, this.p, MFVIDEOFORMAT.Ptr)
    GetVideoRepresentation(guidRepresentation, ppvRepresentation, lStride)
      => ComCall(39, this.p, GUID, guidRepresentation, Struct.Ptr.Ptr, ppvRepresentation, Int32, lStride)
}
struct IMFAsyncResult extends IUnknown {
    static IID := "{AC6B7889-0740-4D51-8619-905994A55CC6}"
    GetState(ppunkState)
      => ComCall(3, this.p, IUnknown.Ptr, ppunkState)
    GetStatus()
      => ComCall(4, this.p)
    SetStatus(hrStatus)
      => ComCall(5, this.p, HRESULT, hrStatus)
    GetObject(ppObject)
      => ComCall(6, this.p, IUnknown.Ptr, ppObject)
    GetStateNoAddRef()
      => ComCall(7, this.p, IUnknown)
}
struct IMFAsyncCallback extends IUnknown {
    static IID := "{A27003CF-2354-4F2A-8D6A-AB7CFF15437E}"
    GetParameters(pdwFlags, pdwQueue)
      => ComCall(3, this.p, UInt32.Ptr, pdwFlags, UInt32.Ptr, pdwQueue)
    Invoke(pAsyncResult)
      => ComCall(4, this.p, IMFAsyncResult, pAsyncResult)
}
struct IMFAsyncCallbackLogging extends IMFAsyncCallback {
    static IID := "{C7A4DCA1-F5F0-47B6-B92B-BF0106D25791}"
    GetObjectPointer()
      => ComCall(5, this.p, Struct.Ptr)
    GetObjectTag()
      => ComCall(6, this.p, UInt32)
}
struct MIDL___MIDL_itf_mfobjects_0000_0013_0001 extends Int32 {
    static MEUnknown := 0
    static MEError := 1
    static MEExtendedType := 2
    static MENonFatalError := 3
    static MEGenericV1Anchor := 3
    static MESessionUnknown := 100
    static MESessionTopologySet := 101
    static MESessionTopologiesCleared := 102
    static MESessionStarted := 103
    static MESessionPaused := 104
    static MESessionStopped := 105
    static MESessionClosed := 106
    static MESessionEnded := 107
    static MESessionRateChanged := 108
    static MESessionScrubSampleComplete := 109
    static MESessionCapabilitiesChanged := 110
    static MESessionTopologyStatus := 111
    static MESessionNotifyPresentationTime := 112
    static MENewPresentation := 113
    static MELicenseAcquisitionStart := 114
    static MELicenseAcquisitionCompleted := 115
    static MEIndividualizationStart := 116
    static MEIndividualizationCompleted := 117
    static MEEnablerProgress := 118
    static MEEnablerCompleted := 119
    static MEPolicyError := 120
    static MEPolicyReport := 121
    static MEBufferingStarted := 122
    static MEBufferingStopped := 123
    static MEConnectStart := 124
    static MEConnectEnd := 125
    static MEReconnectStart := 126
    static MEReconnectEnd := 127
    static MERendererEvent := 128
    static MESessionStreamSinkFormatChanged := 129
    static MESessionV1Anchor := 129
    static MESourceUnknown := 200
    static MESourceStarted := 201
    static MEStreamStarted := 202
    static MESourceSeeked := 203
    static MEStreamSeeked := 204
    static MENewStream := 205
    static MEUpdatedStream := 206
    static MESourceStopped := 207
    static MEStreamStopped := 208
    static MESourcePaused := 209
    static MEStreamPaused := 210
    static MEEndOfPresentation := 211
    static MEEndOfStream := 212
    static MEMediaSample := 213
    static MEStreamTick := 214
    static MEStreamThinMode := 215
    static MEStreamFormatChanged := 216
    static MESourceRateChanged := 217
    static MEEndOfPresentationSegment := 218
    static MESourceCharacteristicsChanged := 219
    static MESourceRateChangeRequested := 220
    static MESourceMetadataChanged := 221
    static MESequencerSourceTopologyUpdated := 222
    static MESourceV1Anchor := 222
    static MESinkUnknown := 300
    static MEStreamSinkStarted := 301
    static MEStreamSinkStopped := 302
    static MEStreamSinkPaused := 303
    static MEStreamSinkRateChanged := 304
    static MEStreamSinkRequestSample := 305
    static MEStreamSinkMarker := 306
    static MEStreamSinkPrerolled := 307
    static MEStreamSinkScrubSampleComplete := 308
    static MEStreamSinkFormatChanged := 309
    static MEStreamSinkDeviceChanged := 310
    static MEQualityNotify := 311
    static MESinkInvalidated := 312
    static MEAudioSessionNameChanged := 313
    static MEAudioSessionVolumeChanged := 314
    static MEAudioSessionDeviceRemoved := 315
    static MEAudioSessionServerShutdown := 316
    static MEAudioSessionGroupingParamChanged := 317
    static MEAudioSessionIconChanged := 318
    static MEAudioSessionFormatChanged := 319
    static MEAudioSessionDisconnected := 320
    static MEAudioSessionExclusiveModeOverride := 321
    static MESinkV1Anchor := 321
    static MECaptureAudioSessionVolumeChanged := 322
    static MECaptureAudioSessionDeviceRemoved := 323
    static MECaptureAudioSessionFormatChanged := 324
    static MECaptureAudioSessionDisconnected := 325
    static MECaptureAudioSessionExclusiveModeOverride := 326
    static MECaptureAudioSessionServerShutdown := 327
    static MESinkV2Anchor := 327
    static METrustUnknown := 400
    static MEPolicyChanged := 401
    static MEContentProtectionMessage := 402
    static MEPolicySet := 403
    static METrustV1Anchor := 403
    static MEWMDRMLicenseBackupCompleted := 500
    static MEWMDRMLicenseBackupProgress := 501
    static MEWMDRMLicenseRestoreCompleted := 502
    static MEWMDRMLicenseRestoreProgress := 503
    static MEWMDRMLicenseAcquisitionCompleted := 506
    static MEWMDRMIndividualizationCompleted := 508
    static MEWMDRMIndividualizationProgress := 513
    static MEWMDRMProximityCompleted := 514
    static MEWMDRMLicenseStoreCleaned := 515
    static MEWMDRMRevocationDownloadCompleted := 516
    static MEWMDRMV1Anchor := 516
    static METransformUnknown := 600
    static METransformNeedInput := 601
    static METransformHaveOutput := 602
    static METransformDrainComplete := 603
    static METransformMarker := 604
    static METransformInputStreamStateChanged := 605
    static MEByteStreamCharacteristicsChanged := 700
    static MEVideoCaptureDeviceRemoved := 800
    static MEVideoCaptureDevicePreempted := 801
    static MEStreamSinkFormatInvalidated := 802
    static MEEncodingParameters := 803
    static MEContentProtectionMetadata := 900
    static MEDeviceThermalStateChanged := 950
    static MEReservedMax := 10000
}
struct IMFMediaEvent extends IMFAttributes {
    static IID := "{DF598932-F10C-4E39-BBA2-C308F101DAA3}"
    GetType(pmet)
      => ComCall(33, this.p, UInt32.Ptr, pmet)
    GetExtendedType(pguidExtendedType)
      => ComCall(34, this.p, GUID.Ptr, pguidExtendedType)
    GetStatus(phrStatus)
      => ComCall(35, this.p, HRESULT.Ptr, phrStatus)
    GetValue(pvValue)
      => ComCall(36, this.p, PROPVARIANT.Ptr, pvValue)
}
struct IMFMediaEventGenerator extends IUnknown {
    static IID := "{2CD0BD52-BCD5-4B89-B62C-EADC0C031E7D}"
    GetEvent(dwFlags, ppEvent)
      => ComCall(3, this.p, MEDIA_EVENT_GENERATOR_GET_EVENT_FLAGS, dwFlags, IMFMediaEvent.Ptr, ppEvent)
    BeginGetEvent(pCallback, punkState)
      => ComCall(4, this.p, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndGetEvent(pResult, ppEvent)
      => ComCall(5, this.p, IMFAsyncResult, pResult, IMFMediaEvent.Ptr, ppEvent)
    QueueEvent(met, guidExtendedType, hrStatus, pvValue)
      => ComCall(6, this.p, UInt32, met, GUID.Ptr, guidExtendedType, HRESULT, hrStatus, PROPVARIANT.Ptr, pvValue)
}
struct IMFRemoteAsyncCallback extends IUnknown {
    static IID := "{A27003D0-2354-4F2A-8D6A-AB7CFF15437E}"
    Invoke(hr, pRemoteResult)
      => ComCall(3, this.p, HRESULT, hr, IUnknown, pRemoteResult)
}
struct MFBYTESTREAM_SEEK_ORIGIN extends Int32 {
    static msoBegin := 0
    static msoCurrent := 1
}
struct IMFByteStream extends IUnknown {
    static IID := "{AD4C1B00-4BF7-422F-9175-756693D9130D}"
    GetCapabilities(pdwCapabilities)
      => ComCall(3, this.p, UInt32.Ptr, pdwCapabilities)
    GetLength(pqwLength)
      => ComCall(4, this.p, Int64.Ptr, pqwLength)
    SetLength(qwLength)
      => ComCall(5, this.p, Int64, qwLength)
    GetCurrentPosition(pqwPosition)
      => ComCall(6, this.p, Int64.Ptr, pqwPosition)
    SetCurrentPosition(qwPosition)
      => ComCall(7, this.p, Int64, qwPosition)
    IsEndOfStream(pfEndOfStream)
      => ComCall(8, this.p, BOOL.Ptr, pfEndOfStream)
    Read(pb, pcbRead)
      => ComCall(9, this.p, UInt8.Ptr, pb, UInt32, pb.Length, UInt32.Ptr, pcbRead)
    BeginRead(pb, pCallback, punkState)
      => ComCall(10, this.p, UInt8.Ptr, pb, UInt32, pb.Size, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndRead(pResult, pcbRead)
      => ComCall(11, this.p, IMFAsyncResult, pResult, UInt32.Ptr, pcbRead)
    Write(pb, pcbWritten)
      => ComCall(12, this.p, UInt8.Ptr, pb, UInt32, pb.Length, UInt32.Ptr, pcbWritten)
    BeginWrite(pb, pCallback, punkState)
      => ComCall(13, this.p, UInt8.Ptr, pb, UInt32, pb.Size, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndWrite(pResult, pcbWritten)
      => ComCall(14, this.p, IMFAsyncResult, pResult, UInt32.Ptr, pcbWritten)
    Seek(SeekOrigin, llSeekOffset, dwSeekFlags, pqwCurrentPosition)
      => ComCall(15, this.p, MFBYTESTREAM_SEEK_ORIGIN, SeekOrigin, Int64, llSeekOffset, UInt32, dwSeekFlags, Int64.Ptr, pqwCurrentPosition)
    Flush()
      => ComCall(16, this.p)
    Close()
      => ComCall(17, this.p)
}
struct IMFByteStreamProxyClassFactory extends IUnknown {
    static IID := "{A6B43F84-5C0A-42E8-A44D-B1857A76992F}"
    CreateByteStreamProxy(pByteStream, pAttributes, riid, ppvObject)
      => ComCall(3, this.p, IMFByteStream, pByteStream, IMFAttributes, pAttributes, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct MF_FILE_ACCESSMODE extends Int32 {
    static MF_ACCESSMODE_READ := 1
    static MF_ACCESSMODE_WRITE := 2
    static MF_ACCESSMODE_READWRITE := 3
}
struct MF_FILE_OPENMODE extends Int32 {
    static MF_OPENMODE_FAIL_IF_NOT_EXIST := 0
    static MF_OPENMODE_FAIL_IF_EXIST := 1
    static MF_OPENMODE_RESET_IF_EXIST := 2
    static MF_OPENMODE_APPEND_IF_EXIST := 3
    static MF_OPENMODE_DELETE_IF_EXIST := 4
}
struct MF_FILE_FLAGS extends Int32 {
    static MF_FILEFLAGS_NONE := 0
    static MF_FILEFLAGS_NOBUFFERING := 1
    static MF_FILEFLAGS_ALLOW_WRITE_SHARING := 2
}
struct IMFSampleOutputStream extends IUnknown {
    static IID := "{8FEED468-6F7E-440D-869A-49BDD283AD0D}"
    BeginWriteSample(pSample, pCallback, punkState)
      => ComCall(3, this.p, IMFSample, pSample, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndWriteSample(pResult)
      => ComCall(4, this.p, IMFAsyncResult, pResult)
    Close()
      => ComCall(5, this.p)
}
struct IMFCollection extends IUnknown {
    static IID := "{5BC8A76B-869A-46A3-9B03-FA218A66AEBE}"
    GetElementCount(pcElements)
      => ComCall(3, this.p, UInt32.Ptr, pcElements)
    GetElement(dwElementIndex, ppUnkElement)
      => ComCall(4, this.p, UInt32, dwElementIndex, IUnknown.Ptr, ppUnkElement)
    AddElement(pUnkElement)
      => ComCall(5, this.p, IUnknown, pUnkElement)
    RemoveElement(dwElementIndex, ppUnkElement)
      => ComCall(6, this.p, UInt32, dwElementIndex, IUnknown.Ptr, ppUnkElement)
    InsertElementAt(dwIndex, pUnknown)
      => ComCall(7, this.p, UInt32, dwIndex, IUnknown, pUnknown)
    RemoveAllElements()
      => ComCall(8, this.p)
}
struct IMFMediaEventQueue extends IUnknown {
    static IID := "{36F846FC-2256-48B6-B58E-E2B638316581}"
    GetEvent(dwFlags, ppEvent)
      => ComCall(3, this.p, UInt32, dwFlags, IMFMediaEvent.Ptr, ppEvent)
    BeginGetEvent(pCallback, punkState)
      => ComCall(4, this.p, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndGetEvent(pResult, ppEvent)
      => ComCall(5, this.p, IMFAsyncResult, pResult, IMFMediaEvent.Ptr, ppEvent)
    QueueEvent(pEvent)
      => ComCall(6, this.p, IMFMediaEvent, pEvent)
    QueueEventParamVar(met, guidExtendedType, hrStatus, pvValue)
      => ComCall(7, this.p, UInt32, met, GUID.Ptr, guidExtendedType, HRESULT, hrStatus, PROPVARIANT.Ptr, pvValue)
    QueueEventParamUnk(met, guidExtendedType, hrStatus, pUnk)
      => ComCall(8, this.p, UInt32, met, GUID.Ptr, guidExtendedType, HRESULT, hrStatus, IUnknown, pUnk)
    Shutdown()
      => ComCall(9, this.p)
}
struct IMFActivate extends IMFAttributes {
    static IID := "{7FEE9E9A-4A89-47A6-899C-B6A53A70FB67}"
    ActivateObject(riid, ppv)
      => ComCall(33, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ShutdownObject()
      => ComCall(34, this.p)
    DetachObject()
      => ComCall(35, this.p)
}
struct IMFPluginControl extends IUnknown {
    static IID := "{5C6C44BF-1DB6-435B-9249-E8CD10FDEC96}"
    GetPreferredClsid(pluginType, selector, clsid)
      => ComCall(3, this.p, UInt32, pluginType, "Str", selector, GUID.Ptr, clsid)
    GetPreferredClsidByIndex(pluginType, index, selector, clsid)
      => ComCall(4, this.p, UInt32, pluginType, UInt32, index, PWSTR.Ptr, selector, GUID.Ptr, clsid)
    SetPreferredClsid(pluginType, selector, clsid?)
      => ComCall(5, this.p, UInt32, pluginType, "Str", selector, GUID.Ptr, clsid?)
    IsDisabled(pluginType, clsid)
      => ComCall(6, this.p, UInt32, pluginType, GUID.Ptr, clsid)
    GetDisabledByIndex(pluginType, index, clsid)
      => ComCall(7, this.p, UInt32, pluginType, UInt32, index, GUID.Ptr, clsid)
    SetDisabled(pluginType, clsid, disabled)
      => ComCall(8, this.p, UInt32, pluginType, GUID.Ptr, clsid, BOOL, disabled)
}
struct MF_PLUGIN_CONTROL_POLICY extends Int32 {
    static MF_PLUGIN_CONTROL_POLICY_USE_ALL_PLUGINS := 0
    static MF_PLUGIN_CONTROL_POLICY_USE_APPROVED_PLUGINS := 1
    static MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS := 2
    static MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS_EDGEMODE := 3
}
struct IMFPluginControl2 extends IMFPluginControl {
    static IID := "{C6982083-3DDC-45CB-AF5E-0F7A8CE4DE77}"
    SetPolicy(policy)
      => ComCall(9, this.p, MF_PLUGIN_CONTROL_POLICY, policy)
}
struct IMFDXGIDeviceManager extends IUnknown {
    static IID := "{EB533D5D-2DB6-40F8-97A9-494692014F07}"
    CloseDeviceHandle(hDevice)
      => ComCall(3, this.p, HANDLE, hDevice)
    GetVideoService(hDevice, riid, ppService)
      => ComCall(4, this.p, HANDLE, hDevice, GUID.Ptr, riid, Struct.Ptr.Ptr, ppService)
    LockDevice(hDevice, riid, ppUnkDevice, fBlock)
      => ComCall(5, this.p, HANDLE, hDevice, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnkDevice, BOOL, fBlock)
    OpenDeviceHandle(phDevice)
      => ComCall(6, this.p, HANDLE.Ptr, phDevice)
    ResetDevice(pUnkDevice, resetToken)
      => ComCall(7, this.p, IUnknown, pUnkDevice, UInt32, resetToken)
    TestDevice(hDevice)
      => ComCall(8, this.p, HANDLE, hDevice)
    UnlockDevice(hDevice, fSaveState)
      => ComCall(9, this.p, HANDLE, hDevice, BOOL, fSaveState)
}
struct MF_DXGI_DEVICE_MANAGER_MODE extends Int32 {
    static MF_DXGI_DEVICE_MANAGER_MODE_INVALID := 0
    static MF_DXGI_DEVICE_MANAGER_MODE_D3D11 := 1
    static MF_DXGI_DEVICE_MANAGER_MODE_D3D12 := 2
}
struct MF_STREAM_STATE extends Int32 {
    static MF_STREAM_STATE_STOPPED := 0
    static MF_STREAM_STATE_PAUSED := 1
    static MF_STREAM_STATE_RUNNING := 2
}
struct IMFMuxStreamAttributesManager extends IUnknown {
    static IID := "{CE8BD576-E440-43B3-BE34-1E53F565F7E8}"
    GetStreamCount(pdwMuxStreamCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwMuxStreamCount)
    GetAttributes(dwMuxStreamIndex, ppStreamAttributes)
      => ComCall(4, this.p, UInt32, dwMuxStreamIndex, IMFAttributes.Ptr, ppStreamAttributes)
}
struct IMFMuxStreamMediaTypeManager extends IUnknown {
    static IID := "{505A2C72-42F7-4690-AEAB-8F513D0FFDB8}"
    GetStreamCount(pdwMuxStreamCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwMuxStreamCount)
    GetMediaType(dwMuxStreamIndex, ppMediaType)
      => ComCall(4, this.p, UInt32, dwMuxStreamIndex, IMFMediaType.Ptr, ppMediaType)
    GetStreamConfigurationCount(pdwCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwCount)
    AddStreamConfiguration(ullStreamMask)
      => ComCall(6, this.p, Int64, ullStreamMask)
    RemoveStreamConfiguration(ullStreamMask)
      => ComCall(7, this.p, Int64, ullStreamMask)
    GetStreamConfiguration(ulIndex, pullStreamMask)
      => ComCall(8, this.p, UInt32, ulIndex, Int64.Ptr, pullStreamMask)
}
struct IMFMuxStreamSampleManager extends IUnknown {
    static IID := "{74ABBC19-B1CC-4E41-BB8B-9D9B86A8F6CA}"
    GetStreamCount(pdwMuxStreamCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwMuxStreamCount)
    GetSample(dwMuxStreamIndex, ppSample)
      => ComCall(4, this.p, UInt32, dwMuxStreamIndex, IMFSample.Ptr, ppSample)
    GetStreamConfiguration()
      => ComCall(5, this.p, Int64)
}
struct IMFSecureBuffer extends IUnknown {
    static IID := "{C1209904-E584-4752-A2D6-7F21693F8B21}"
    GetIdentifier(pGuidIdentifier)
      => ComCall(3, this.p, GUID.Ptr, pGuidIdentifier)
}
struct MFT_INPUT_DATA_BUFFER_FLAGS extends Int32 {
    static MFT_INPUT_DATA_BUFFER_PLACEHOLDER := -1
}
struct MFT_OUTPUT_DATA_BUFFER_FLAGS extends Int32 {
    static MFT_OUTPUT_DATA_BUFFER_INCOMPLETE := 16777216
    static MFT_OUTPUT_DATA_BUFFER_FORMAT_CHANGE := 256
    static MFT_OUTPUT_DATA_BUFFER_STREAM_END := 512
    static MFT_OUTPUT_DATA_BUFFER_NO_SAMPLE := 768
}
struct MFT_INPUT_STATUS_FLAGS extends Int32 {
    static MFT_INPUT_STATUS_ACCEPT_DATA := 1
}
struct MFT_OUTPUT_STATUS_FLAGS extends Int32 {
    static MFT_OUTPUT_STATUS_SAMPLE_READY := 1
}
struct MFT_INPUT_STREAM_INFO_FLAGS extends Int32 {
    static MFT_INPUT_STREAM_WHOLE_SAMPLES := 1
    static MFT_INPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER := 2
    static MFT_INPUT_STREAM_FIXED_SAMPLE_SIZE := 4
    static MFT_INPUT_STREAM_HOLDS_BUFFERS := 8
    static MFT_INPUT_STREAM_DOES_NOT_ADDREF := 256
    static MFT_INPUT_STREAM_REMOVABLE := 512
    static MFT_INPUT_STREAM_OPTIONAL := 1024
    static MFT_INPUT_STREAM_PROCESSES_IN_PLACE := 2048
}
struct MFT_OUTPUT_STREAM_INFO_FLAGS extends Int32 {
    static MFT_OUTPUT_STREAM_WHOLE_SAMPLES := 1
    static MFT_OUTPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER := 2
    static MFT_OUTPUT_STREAM_FIXED_SAMPLE_SIZE := 4
    static MFT_OUTPUT_STREAM_DISCARDABLE := 8
    static MFT_OUTPUT_STREAM_OPTIONAL := 16
    static MFT_OUTPUT_STREAM_PROVIDES_SAMPLES := 256
    static MFT_OUTPUT_STREAM_CAN_PROVIDE_SAMPLES := 512
    static MFT_OUTPUT_STREAM_LAZY_READ := 1024
    static MFT_OUTPUT_STREAM_REMOVABLE := 2048
}
struct MFT_SET_TYPE_FLAGS extends Int32 {
    static MFT_SET_TYPE_TEST_ONLY := 1
}
struct MFT_PROCESS_OUTPUT_FLAGS extends Int32 {
    static MFT_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER := 1
    static MFT_PROCESS_OUTPUT_REGENERATE_LAST_OUTPUT := 2
}
struct MFT_PROCESS_OUTPUT_STATUS extends Int32 {
    static MFT_PROCESS_OUTPUT_STATUS_NEW_STREAMS := 256
}
struct MFT_DRAIN_TYPE extends Int32 {
    static MFT_DRAIN_PRODUCE_TAILS := 0
    static MFT_DRAIN_NO_TAILS := 1
}
struct MFT_MESSAGE_TYPE extends Int32 {
    static MFT_MESSAGE_COMMAND_FLUSH := 0
    static MFT_MESSAGE_COMMAND_DRAIN := 1
    static MFT_MESSAGE_SET_D3D_MANAGER := 2
    static MFT_MESSAGE_DROP_SAMPLES := 3
    static MFT_MESSAGE_COMMAND_TICK := 4
    static MFT_MESSAGE_NOTIFY_BEGIN_STREAMING := 268435456
    static MFT_MESSAGE_NOTIFY_END_STREAMING := 268435457
    static MFT_MESSAGE_NOTIFY_END_OF_STREAM := 268435458
    static MFT_MESSAGE_NOTIFY_START_OF_STREAM := 268435459
    static MFT_MESSAGE_NOTIFY_RELEASE_RESOURCES := 268435460
    static MFT_MESSAGE_NOTIFY_REACQUIRE_RESOURCES := 268435461
    static MFT_MESSAGE_NOTIFY_EVENT := 268435462
    static MFT_MESSAGE_COMMAND_SET_OUTPUT_STREAM_STATE := 268435463
    static MFT_MESSAGE_COMMAND_FLUSH_OUTPUT_STREAM := 268435464
    static MFT_MESSAGE_COMMAND_MARKER := 536870912
}
struct MFT_INPUT_STREAM_INFO {
    hnsMaxLatency : Int64
    dwFlags : UInt32
    cbSize : UInt32 := this.Size
    cbMaxLookahead : UInt32
    cbAlignment : UInt32
}
struct MFT_OUTPUT_STREAM_INFO {
    dwFlags : UInt32
    cbSize : UInt32 := this.Size
    cbAlignment : UInt32
}
struct MFT_OUTPUT_DATA_BUFFER {
    dwStreamID : UInt32
    pSample : IMFSample
    dwStatus : UInt32
    pEvents : IMFCollection
}
struct IMFTransform extends IUnknown {
    static IID := "{BF94C121-5B05-4E6F-8000-BA598961414D}"
    GetStreamLimits(pdwInputMinimum, pdwInputMaximum, pdwOutputMinimum, pdwOutputMaximum)
      => ComCall(3, this.p, UInt32.Ptr, pdwInputMinimum, UInt32.Ptr, pdwInputMaximum, UInt32.Ptr, pdwOutputMinimum, UInt32.Ptr, pdwOutputMaximum)
    GetStreamCount(pcInputStreams, pcOutputStreams)
      => ComCall(4, this.p, UInt32.Ptr, pcInputStreams, UInt32.Ptr, pcOutputStreams)
    GetStreamIDs(pdwInputIDs, pdwOutputIDs)
      => ComCall(5, this.p, UInt32, pdwInputIDs.Length, UInt32.Ptr, pdwInputIDs, UInt32, pdwOutputIDs.Length, UInt32.Ptr, pdwOutputIDs)
    GetInputStreamInfo(dwInputStreamID, pStreamInfo)
      => ComCall(6, this.p, UInt32, dwInputStreamID, MFT_INPUT_STREAM_INFO.Ptr, pStreamInfo)
    GetOutputStreamInfo(dwOutputStreamID, pStreamInfo)
      => ComCall(7, this.p, UInt32, dwOutputStreamID, MFT_OUTPUT_STREAM_INFO.Ptr, pStreamInfo)
    GetAttributes(pAttributes)
      => ComCall(8, this.p, IMFAttributes.Ptr, pAttributes)
    GetInputStreamAttributes(dwInputStreamID, pAttributes)
      => ComCall(9, this.p, UInt32, dwInputStreamID, IMFAttributes.Ptr, pAttributes)
    GetOutputStreamAttributes(dwOutputStreamID, pAttributes)
      => ComCall(10, this.p, UInt32, dwOutputStreamID, IMFAttributes.Ptr, pAttributes)
    DeleteInputStream(dwStreamID)
      => ComCall(11, this.p, UInt32, dwStreamID)
    AddInputStreams(cStreams, adwStreamIDs)
      => ComCall(12, this.p, UInt32, cStreams, UInt32.Ptr, adwStreamIDs)
    GetInputAvailableType(dwInputStreamID, dwTypeIndex, ppType)
      => ComCall(13, this.p, UInt32, dwInputStreamID, UInt32, dwTypeIndex, IMFMediaType.Ptr, ppType)
    GetOutputAvailableType(dwOutputStreamID, dwTypeIndex, ppType)
      => ComCall(14, this.p, UInt32, dwOutputStreamID, UInt32, dwTypeIndex, IMFMediaType.Ptr, ppType)
    SetInputType(dwInputStreamID, pType, dwFlags)
      => ComCall(15, this.p, UInt32, dwInputStreamID, IMFMediaType, pType, UInt32, dwFlags)
    SetOutputType(dwOutputStreamID, pType, dwFlags)
      => ComCall(16, this.p, UInt32, dwOutputStreamID, IMFMediaType, pType, UInt32, dwFlags)
    GetInputCurrentType(dwInputStreamID, ppType)
      => ComCall(17, this.p, UInt32, dwInputStreamID, IMFMediaType.Ptr, ppType)
    GetOutputCurrentType(dwOutputStreamID, ppType)
      => ComCall(18, this.p, UInt32, dwOutputStreamID, IMFMediaType.Ptr, ppType)
    GetInputStatus(dwInputStreamID, pdwFlags)
      => ComCall(19, this.p, UInt32, dwInputStreamID, UInt32.Ptr, pdwFlags)
    GetOutputStatus(pdwFlags)
      => ComCall(20, this.p, UInt32.Ptr, pdwFlags)
    SetOutputBounds(hnsLowerBound, hnsUpperBound)
      => ComCall(21, this.p, Int64, hnsLowerBound, Int64, hnsUpperBound)
    ProcessEvent(dwInputStreamID, pEvent)
      => ComCall(22, this.p, UInt32, dwInputStreamID, IMFMediaEvent, pEvent)
    ProcessMessage(eMessage, ulParam)
      => ComCall(23, this.p, MFT_MESSAGE_TYPE, eMessage, IntPtr, ulParam)
    ProcessInput(dwInputStreamID, pSample, dwFlags)
      => ComCall(24, this.p, UInt32, dwInputStreamID, IMFSample, pSample, UInt32, dwFlags)
    ProcessOutput(dwFlags, pOutputSamples, pdwStatus)
      => ComCall(25, this.p, UInt32, dwFlags, UInt32, pOutputSamples.Length, MFT_OUTPUT_DATA_BUFFER.Ptr, pOutputSamples, UInt32.Ptr, pdwStatus)
}
struct DeviceStreamState extends Int32 {
    static DeviceStreamState_Stop := 0
    static DeviceStreamState_Pause := 1
    static DeviceStreamState_Run := 2
    static DeviceStreamState_Disabled := 3
}
struct STREAM_MEDIUM {
    gidMedium : GUID
    unMediumInstance : UInt32
}
struct IMFDeviceTransform extends IUnknown {
    static IID := "{D818FBD8-FC46-42F2-87AC-1EA2D1F9BF32}"
    InitializeTransform(pAttributes)
      => ComCall(3, this.p, IMFAttributes, pAttributes)
    GetInputAvailableType(dwInputStreamID, dwTypeIndex, pMediaType)
      => ComCall(4, this.p, UInt32, dwInputStreamID, UInt32, dwTypeIndex, IMFMediaType.Ptr, pMediaType)
    GetInputCurrentType(dwInputStreamID, pMediaType)
      => ComCall(5, this.p, UInt32, dwInputStreamID, IMFMediaType.Ptr, pMediaType)
    GetInputStreamAttributes(dwInputStreamID, ppAttributes)
      => ComCall(6, this.p, UInt32, dwInputStreamID, IMFAttributes.Ptr, ppAttributes)
    GetOutputAvailableType(dwOutputStreamID, dwTypeIndex, pMediaType)
      => ComCall(7, this.p, UInt32, dwOutputStreamID, UInt32, dwTypeIndex, IMFMediaType.Ptr, pMediaType)
    GetOutputCurrentType(dwOutputStreamID, pMediaType)
      => ComCall(8, this.p, UInt32, dwOutputStreamID, IMFMediaType.Ptr, pMediaType)
    GetOutputStreamAttributes(dwOutputStreamID, ppAttributes)
      => ComCall(9, this.p, UInt32, dwOutputStreamID, IMFAttributes.Ptr, ppAttributes)
    GetStreamCount(pcInputStreams, pcOutputStreams)
      => ComCall(10, this.p, UInt32.Ptr, pcInputStreams, UInt32.Ptr, pcOutputStreams)
    GetStreamIDs(dwInputIDArraySize, pdwInputStreamIds, dwOutputIDArraySize, pdwOutputStreamIds)
      => ComCall(11, this.p, UInt32, dwInputIDArraySize, UInt32.Ptr, pdwInputStreamIds, UInt32, dwOutputIDArraySize, UInt32.Ptr, pdwOutputStreamIds)
    ProcessEvent(dwInputStreamID, pEvent)
      => ComCall(12, this.p, UInt32, dwInputStreamID, IMFMediaEvent, pEvent)
    ProcessInput(dwInputStreamID, pSample, dwFlags)
      => ComCall(13, this.p, UInt32, dwInputStreamID, IMFSample, pSample, UInt32, dwFlags)
    ProcessMessage(eMessage, ulParam)
      => ComCall(14, this.p, MFT_MESSAGE_TYPE, eMessage, IntPtr, ulParam)
    ProcessOutput(dwFlags, cOutputBufferCount, pOutputSample, pdwStatus)
      => ComCall(15, this.p, UInt32, dwFlags, UInt32, cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER.Ptr, pOutputSample, UInt32.Ptr, pdwStatus)
    SetInputStreamState(dwStreamID, pMediaType, value, dwFlags)
      => ComCall(16, this.p, UInt32, dwStreamID, IMFMediaType, pMediaType, DeviceStreamState, value, UInt32, dwFlags)
    GetInputStreamState(dwStreamID, value)
      => ComCall(17, this.p, UInt32, dwStreamID, DeviceStreamState.Ptr, value)
    SetOutputStreamState(dwStreamID, pMediaType, value, dwFlags)
      => ComCall(18, this.p, UInt32, dwStreamID, IMFMediaType, pMediaType, DeviceStreamState, value, UInt32, dwFlags)
    GetOutputStreamState(dwStreamID, value)
      => ComCall(19, this.p, UInt32, dwStreamID, DeviceStreamState.Ptr, value)
    GetInputStreamPreferredState(dwStreamID, value, ppMediaType)
      => ComCall(20, this.p, UInt32, dwStreamID, DeviceStreamState.Ptr, value, IMFMediaType.Ptr, ppMediaType)
    FlushInputStream(dwStreamIndex, dwFlags)
      => ComCall(21, this.p, UInt32, dwStreamIndex, UInt32, dwFlags)
    FlushOutputStream(dwStreamIndex, dwFlags)
      => ComCall(22, this.p, UInt32, dwStreamIndex, UInt32, dwFlags)
}
struct IMFDeviceTransform2 extends IMFDeviceTransform {
    static IID := "{F5980FED-B521-488F-909F-1A5FCECEDB14}"
    GetTransformAttributes(ppAttributes)
      => ComCall(23, this.p, IMFAttributes.Ptr, ppAttributes)
}
struct IMFDeviceTransformCallback extends IUnknown {
    static IID := "{6D5CB646-29EC-41FB-8179-8C4C6D750811}"
    OnBufferSent(pCallbackAttributes, pinId)
      => ComCall(3, this.p, IMFAttributes, pCallbackAttributes, UInt32, pinId)
}
struct MF3DVideoOutputType extends Int32 {
    static MF3DVideoOutputType_BaseView := 0
    static MF3DVideoOutputType_Stereo := 1
}
struct MFT_AUDIO_DECODER_DEGRADATION_REASON extends Int32 {
    static MFT_AUDIO_DECODER_DEGRADATION_REASON_NONE := 0
    static MFT_AUDIO_DECODER_DEGRADATION_REASON_LICENSING_REQUIREMENT := 1
}
struct MFT_AUDIO_DECODER_DEGRADATION_TYPE extends Int32 {
    static MFT_AUDIO_DECODER_DEGRADATION_TYPE_NONE := 0
    static MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX2CHANNEL := 1
    static MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX6CHANNEL := 2
    static MFT_AUDIO_DECODER_DEGRADATION_TYPE_DOWNMIX8CHANNEL := 3
}
struct MFAudioDecoderDegradationInfo {
    eDegradationReason : MFT_AUDIO_DECODER_DEGRADATION_REASON
    eType : MFT_AUDIO_DECODER_DEGRADATION_TYPE
}
struct MFT_STREAM_STATE_PARAM {
    StreamId : UInt32
    State : MF_STREAM_STATE
}
struct MFSESSION_SETTOPOLOGY_FLAGS extends Int32 {
    static MFSESSION_SETTOPOLOGY_IMMEDIATE := 1
    static MFSESSION_SETTOPOLOGY_NORESOLUTION := 2
    static MFSESSION_SETTOPOLOGY_CLEAR_CURRENT := 4
}
struct MFSESSION_GETFULLTOPOLOGY_FLAGS extends Int32 {
    static MFSESSION_GETFULLTOPOLOGY_CURRENT := 1
}
struct MFPMPSESSION_CREATION_FLAGS extends Int32 {
    static MFPMPSESSION_UNPROTECTED_PROCESS := 1
    static MFPMPSESSION_IN_PROCESS := 2
}
struct MFVideoNormalizedRect {
    left : Float32
    top : Float32
    right : Float32
    bottom : Float32
}
struct IMFMediaSession extends IMFMediaEventGenerator {
    static IID := "{90377834-21D0-4DEE-8214-BA2E3E6C1127}"
    SetTopology(dwSetTopologyFlags, pTopology)
      => ComCall(7, this.p, UInt32, dwSetTopologyFlags, IMFTopology, pTopology)
    ClearTopologies()
      => ComCall(8, this.p)
    Start(pguidTimeFormat, pvarStartPosition)
      => ComCall(9, this.p, GUID.Ptr, pguidTimeFormat, PROPVARIANT.Ptr, pvarStartPosition)
    Pause()
      => ComCall(10, this.p)
    Stop()
      => ComCall(11, this.p)
    Close()
      => ComCall(12, this.p)
    Shutdown()
      => ComCall(13, this.p)
    GetClock(ppClock)
      => ComCall(14, this.p, IMFClock.Ptr, ppClock)
    GetSessionCapabilities(pdwCaps)
      => ComCall(15, this.p, UInt32.Ptr, pdwCaps)
    GetFullTopology(dwGetFullTopologyFlags, TopoId, ppFullTopology)
      => ComCall(16, this.p, UInt32, dwGetFullTopologyFlags, Int64, TopoId, IMFTopology.Ptr, ppFullTopology)
}
struct MF_OBJECT_TYPE extends Int32 {
    static MF_OBJECT_MEDIASOURCE := 0
    static MF_OBJECT_BYTESTREAM := 1
    static MF_OBJECT_INVALID := 2
}
struct MF_RESOLUTION_FLAGS extends Int32 {
    static MF_RESOLUTION_MEDIASOURCE := 1
    static MF_RESOLUTION_BYTESTREAM := 2
    static MF_RESOLUTION_CONTENT_DOES_NOT_HAVE_TO_MATCH_EXTENSION_OR_MIME_TYPE := 16
    static MF_RESOLUTION_KEEP_BYTE_STREAM_ALIVE_ON_FAIL := 32
    static MF_RESOLUTION_DISABLE_LOCAL_PLUGINS := 64
    static MF_RESOLUTION_PLUGIN_CONTROL_POLICY_APPROVED_ONLY := 128
    static MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY := 256
    static MF_RESOLUTION_PLUGIN_CONTROL_POLICY_WEB_ONLY_EDGEMODE := 512
    static MF_RESOLUTION_ENABLE_STORE_PLUGINS := 1024
    static MF_RESOLUTION_READ := 65536
    static MF_RESOLUTION_WRITE := 131072
}
struct MF_CONNECT_METHOD extends Int32 {
    static MF_CONNECT_DIRECT := 0
    static MF_CONNECT_ALLOW_CONVERTER := 1
    static MF_CONNECT_ALLOW_DECODER := 3
    static MF_CONNECT_RESOLVE_INDEPENDENT_OUTPUTTYPES := 4
    static MF_CONNECT_AS_OPTIONAL := 65536
    static MF_CONNECT_AS_OPTIONAL_BRANCH := 131072
}
struct MF_TOPOLOGY_RESOLUTION_STATUS_FLAGS extends Int32 {
    static MF_TOPOLOGY_RESOLUTION_SUCCEEDED := 0
    static MF_OPTIONAL_NODE_REJECTED_MEDIA_TYPE := 1
    static MF_OPTIONAL_NODE_REJECTED_PROTECTED_PROCESS := 2
}
struct IMFSourceResolver extends IUnknown {
    static IID := "{FBE5A32D-A497-4B61-BB85-97B1A848A6E3}"
    CreateObjectFromURL(pwszURL, dwFlags, pProps, pObjectType, ppObject)
      => ComCall(3, this.p, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    CreateObjectFromByteStream(pByteStream, pwszURL, dwFlags, pProps, pObjectType, ppObject)
      => ComCall(4, this.p, IMFByteStream, pByteStream, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    BeginCreateObjectFromURL(pwszURL, dwFlags, pProps, ppIUnknownCancelCookie?, pCallback, punkState)
      => ComCall(5, this.p, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, IUnknown.Ptr, ppIUnknownCancelCookie?, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndCreateObjectFromURL(pResult, pObjectType, ppObject)
      => ComCall(6, this.p, IMFAsyncResult, pResult, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    BeginCreateObjectFromByteStream(pByteStream, pwszURL, dwFlags, pProps, ppIUnknownCancelCookie?, pCallback, punkState)
      => ComCall(7, this.p, IMFByteStream, pByteStream, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, IUnknown.Ptr, ppIUnknownCancelCookie?, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndCreateObjectFromByteStream(pResult, pObjectType, ppObject)
      => ComCall(8, this.p, IMFAsyncResult, pResult, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    CancelObjectCreation(pIUnknownCancelCookie)
      => ComCall(9, this.p, IUnknown, pIUnknownCancelCookie)
}
struct MFMEDIASOURCE_CHARACTERISTICS extends Int32 {
    static MFMEDIASOURCE_IS_LIVE := 1
    static MFMEDIASOURCE_CAN_SEEK := 2
    static MFMEDIASOURCE_CAN_PAUSE := 4
    static MFMEDIASOURCE_HAS_SLOW_SEEK := 8
    static MFMEDIASOURCE_HAS_MULTIPLE_PRESENTATIONS := 16
    static MFMEDIASOURCE_CAN_SKIPFORWARD := 32
    static MFMEDIASOURCE_CAN_SKIPBACKWARD := 64
    static MFMEDIASOURCE_DOES_NOT_USE_NETWORK := 128
}
struct IMFMediaSource extends IMFMediaEventGenerator {
    static IID := "{279A808D-AEC7-40C8-9C6B-A6B492C78A66}"
    GetCharacteristics(pdwCharacteristics)
      => ComCall(7, this.p, UInt32.Ptr, pdwCharacteristics)
    CreatePresentationDescriptor(ppPresentationDescriptor)
      => ComCall(8, this.p, IMFPresentationDescriptor.Ptr, ppPresentationDescriptor)
    Start(pPresentationDescriptor, pguidTimeFormat, pvarStartPosition)
      => ComCall(9, this.p, IMFPresentationDescriptor, pPresentationDescriptor, GUID.Ptr, pguidTimeFormat, PROPVARIANT.Ptr, pvarStartPosition)
    Stop()
      => ComCall(10, this.p)
    Pause()
      => ComCall(11, this.p)
    Shutdown()
      => ComCall(12, this.p)
}
struct IMFMediaSourceEx extends IMFMediaSource {
    static IID := "{3C9B2EB9-86D5-4514-A394-F56664F9F0D8}"
    GetSourceAttributes(ppAttributes)
      => ComCall(13, this.p, IMFAttributes.Ptr, ppAttributes)
    GetStreamAttributes(dwStreamIdentifier, ppAttributes)
      => ComCall(14, this.p, UInt32, dwStreamIdentifier, IMFAttributes.Ptr, ppAttributes)
    SetD3DManager(pManager)
      => ComCall(15, this.p, IUnknown, pManager)
}
struct IMFClockConsumer extends IUnknown {
    static IID := "{6EF2A662-47C0-4666-B13D-CBB717F2FA2C}"
    SetPresentationClock(pPresentationClock)
      => ComCall(3, this.p, IMFPresentationClock, pPresentationClock)
    GetPresentationClock(ppPresentationClock)
      => ComCall(4, this.p, IMFPresentationClock.Ptr, ppPresentationClock)
}
struct IMFMediaStream extends IMFMediaEventGenerator {
    static IID := "{D182108F-4EC6-443F-AA42-A71106EC825F}"
    GetMediaSource(ppMediaSource)
      => ComCall(7, this.p, IMFMediaSource.Ptr, ppMediaSource)
    GetStreamDescriptor(ppStreamDescriptor)
      => ComCall(8, this.p, IMFStreamDescriptor.Ptr, ppStreamDescriptor)
    RequestSample(pToken)
      => ComCall(9, this.p, IUnknown, pToken)
}
struct IMFMediaSink extends IUnknown {
    static IID := "{6EF2A660-47C0-4666-B13D-CBB717F2FA2C}"
    GetCharacteristics(pdwCharacteristics)
      => ComCall(3, this.p, UInt32.Ptr, pdwCharacteristics)
    AddStreamSink(dwStreamSinkIdentifier, pMediaType, ppStreamSink)
      => ComCall(4, this.p, UInt32, dwStreamSinkIdentifier, IMFMediaType, pMediaType, IMFStreamSink.Ptr, ppStreamSink)
    RemoveStreamSink(dwStreamSinkIdentifier)
      => ComCall(5, this.p, UInt32, dwStreamSinkIdentifier)
    GetStreamSinkCount(pcStreamSinkCount)
      => ComCall(6, this.p, UInt32.Ptr, pcStreamSinkCount)
    GetStreamSinkByIndex(dwIndex, ppStreamSink)
      => ComCall(7, this.p, UInt32, dwIndex, IMFStreamSink.Ptr, ppStreamSink)
    GetStreamSinkById(dwStreamSinkIdentifier, ppStreamSink)
      => ComCall(8, this.p, UInt32, dwStreamSinkIdentifier, IMFStreamSink.Ptr, ppStreamSink)
    SetPresentationClock(pPresentationClock)
      => ComCall(9, this.p, IMFPresentationClock, pPresentationClock)
    GetPresentationClock(ppPresentationClock)
      => ComCall(10, this.p, IMFPresentationClock.Ptr, ppPresentationClock)
    Shutdown()
      => ComCall(11, this.p)
}
struct MFSTREAMSINK_MARKER_TYPE extends Int32 {
    static MFSTREAMSINK_MARKER_DEFAULT := 0
    static MFSTREAMSINK_MARKER_ENDOFSEGMENT := 1
    static MFSTREAMSINK_MARKER_TICK := 2
    static MFSTREAMSINK_MARKER_EVENT := 3
}
struct IMFStreamSink extends IMFMediaEventGenerator {
    static IID := "{0A97B3CF-8E7C-4A3D-8F8C-0C843DC247FB}"
    GetMediaSink(ppMediaSink)
      => ComCall(7, this.p, IMFMediaSink.Ptr, ppMediaSink)
    GetIdentifier(pdwIdentifier)
      => ComCall(8, this.p, UInt32.Ptr, pdwIdentifier)
    GetMediaTypeHandler(ppHandler)
      => ComCall(9, this.p, IMFMediaTypeHandler.Ptr, ppHandler)
    ProcessSample(pSample)
      => ComCall(10, this.p, IMFSample, pSample)
    PlaceMarker(eMarkerType, pvarMarkerValue, pvarContextValue)
      => ComCall(11, this.p, MFSTREAMSINK_MARKER_TYPE, eMarkerType, PROPVARIANT.Ptr, pvarMarkerValue, PROPVARIANT.Ptr, pvarContextValue)
    Flush()
      => ComCall(12, this.p)
}
struct IMFVideoSampleAllocator extends IUnknown {
    static IID := "{86CBC910-E533-4751-8E3B-F19B5B806A03}"
    SetDirectXManager(pManager)
      => ComCall(3, this.p, IUnknown, pManager)
    UninitializeSampleAllocator()
      => ComCall(4, this.p)
    InitializeSampleAllocator(cRequestedFrames, pMediaType)
      => ComCall(5, this.p, UInt32, cRequestedFrames, IMFMediaType, pMediaType)
    AllocateSample(ppSample)
      => ComCall(6, this.p, IMFSample.Ptr, ppSample)
}
struct IMFVideoSampleAllocatorNotify extends IUnknown {
    static IID := "{A792CDBE-C374-4E89-8335-278E7B9956A4}"
    NotifyRelease()
      => ComCall(3, this.p)
}
struct IMFVideoSampleAllocatorNotifyEx extends IMFVideoSampleAllocatorNotify {
    static IID := "{3978AA1A-6D5B-4B7F-A340-90899189AE34}"
    NotifyPrune(__MIDL__IMFVideoSampleAllocatorNotifyEx0000)
      => ComCall(4, this.p, IMFSample, __MIDL__IMFVideoSampleAllocatorNotifyEx0000)
}
struct IMFVideoSampleAllocatorCallback extends IUnknown {
    static IID := "{992388B4-3372-4F67-8B6F-C84C071F4751}"
    SetCallback(pNotify)
      => ComCall(3, this.p, IMFVideoSampleAllocatorNotify, pNotify)
    GetFreeSampleCount(plSamples)
      => ComCall(4, this.p, Int32.Ptr, plSamples)
}
struct IMFVideoSampleAllocatorEx extends IMFVideoSampleAllocator {
    static IID := "{545B3A48-3283-4F62-866F-A62D8F598F9F}"
    InitializeSampleAllocatorEx(cInitialSamples, cMaximumSamples, pAttributes?, pMediaType)
      => ComCall(7, this.p, UInt32, cInitialSamples, UInt32, cMaximumSamples, IMFAttributes, pAttributes?, IMFMediaType, pMediaType)
}
struct IMFDXGIDeviceManagerSource extends IUnknown {
    static IID := "{20BC074B-7A8D-4609-8C3B-64A0A3B5D7CE}"
    GetManager(ppManager)
      => ComCall(3, this.p, IMFDXGIDeviceManager.Ptr, ppManager)
}
struct MF_VIDEO_PROCESSOR_ROTATION extends Int32 {
    static ROTATION_NONE := 0
    static ROTATION_NORMAL := 1
}
struct MF_VIDEO_PROCESSOR_MIRROR extends Int32 {
    static MIRROR_NONE := 0
    static MIRROR_HORIZONTAL := 1
    static MIRROR_VERTICAL := 2
}
struct IMFVideoProcessorControl extends IUnknown {
    static IID := "{A3F675D5-6119-4F7F-A100-1D8B280F0EFB}"
    SetBorderColor(pBorderColor?)
      => ComCall(3, this.p, MFARGB.Ptr, pBorderColor?)
    SetSourceRectangle(pSrcRect?)
      => ComCall(4, this.p, RECT.Ptr, pSrcRect?)
    SetDestinationRectangle(pDstRect?)
      => ComCall(5, this.p, RECT.Ptr, pDstRect?)
    SetMirror(eMirror)
      => ComCall(6, this.p, MF_VIDEO_PROCESSOR_MIRROR, eMirror)
    SetRotation(eRotation)
      => ComCall(7, this.p, MF_VIDEO_PROCESSOR_ROTATION, eRotation)
    SetConstrictionSize(pConstrictionSize?)
      => ComCall(8, this.p, SIZE.Ptr, pConstrictionSize?)
}
struct IMFVideoProcessorControl2 extends IMFVideoProcessorControl {
    static IID := "{BDE633D3-E1DC-4A7F-A693-BBAE399C4A20}"
    SetRotationOverride(uiRotation)
      => ComCall(9, this.p, UInt32, uiRotation)
    EnableHardwareEffects(fEnabled)
      => ComCall(10, this.p, BOOL, fEnabled)
    GetSupportedHardwareEffects(puiSupport)
      => ComCall(11, this.p, UInt32.Ptr, puiSupport)
}
struct MFVideoSphericalFormat extends Int32 {
    static MFVideoSphericalFormat_Unsupported := 0
    static MFVideoSphericalFormat_Equirectangular := 1
    static MFVideoSphericalFormat_CubeMap := 2
    static MFVideoSphericalFormat_3DMesh := 3
}
struct MFVideoSphericalProjectionMode extends Int32 {
    static MFVideoSphericalProjectionMode_Spherical := 0
    static MFVideoSphericalProjectionMode_Flat := 1
}
struct IMFVideoProcessorControl3 extends IMFVideoProcessorControl2 {
    static IID := "{2424B3F2-EB23-40F1-91AA-74BDDEEA0883}"
    GetNaturalOutputType(ppType)
      => ComCall(12, this.p, IMFMediaType.Ptr, ppType)
    EnableSphericalVideoProcessing(fEnable, eFormat, eProjectionMode)
      => ComCall(13, this.p, BOOL, fEnable, MFVideoSphericalFormat, eFormat, MFVideoSphericalProjectionMode, eProjectionMode)
    SetSphericalVideoProperties(X, Y, Z, W, fieldOfView)
      => ComCall(14, this.p, Float32, X, Float32, Y, Float32, Z, Float32, W, Float32, fieldOfView)
    SetOutputDevice(pOutputDevice)
      => ComCall(15, this.p, IUnknown, pOutputDevice)
}
struct IMFVideoRendererEffectControl extends IUnknown {
    static IID := "{604D33D7-CF23-41D5-8224-5BBBB1A87475}"
    OnAppServiceConnectionEstablished(pAppServiceConnection)
      => ComCall(3, this.p, IUnknown, pAppServiceConnection)
}
struct IMFTopology extends IMFAttributes {
    static IID := "{83CF873A-F6DA-4BC8-823F-BACFD55DC433}"
    GetTopologyID(pID)
      => ComCall(33, this.p, Int64.Ptr, pID)
    AddNode(pNode)
      => ComCall(34, this.p, IMFTopologyNode, pNode)
    RemoveNode(pNode)
      => ComCall(35, this.p, IMFTopologyNode, pNode)
    GetNodeCount(pwNodes)
      => ComCall(36, this.p, UInt16.Ptr, pwNodes)
    GetNode(wIndex, ppNode)
      => ComCall(37, this.p, UInt16, wIndex, IMFTopologyNode.Ptr, ppNode)
    Clear()
      => ComCall(38, this.p)
    CloneFrom(pTopology)
      => ComCall(39, this.p, IMFTopology, pTopology)
    GetNodeByID(qwTopoNodeID, ppNode)
      => ComCall(40, this.p, Int64, qwTopoNodeID, IMFTopologyNode.Ptr, ppNode)
    GetSourceNodeCollection(ppCollection)
      => ComCall(41, this.p, IMFCollection.Ptr, ppCollection)
    GetOutputNodeCollection(ppCollection)
      => ComCall(42, this.p, IMFCollection.Ptr, ppCollection)
}
struct MFTOPOLOGY_DXVA_MODE extends Int32 {
    static MFTOPOLOGY_DXVA_DEFAULT := 0
    static MFTOPOLOGY_DXVA_NONE := 1
    static MFTOPOLOGY_DXVA_FULL := 2
}
struct MFTOPOLOGY_HARDWARE_MODE extends Int32 {
    static MFTOPOLOGY_HWMODE_SOFTWARE_ONLY := 0
    static MFTOPOLOGY_HWMODE_USE_HARDWARE := 1
    static MFTOPOLOGY_HWMODE_USE_ONLY_HARDWARE := 2
}
struct MF_TOPOLOGY_TYPE extends Int32 {
    static MF_TOPOLOGY_OUTPUT_NODE := 0
    static MF_TOPOLOGY_SOURCESTREAM_NODE := 1
    static MF_TOPOLOGY_TRANSFORM_NODE := 2
    static MF_TOPOLOGY_TEE_NODE := 3
    static MF_TOPOLOGY_MAX := -1
}
struct IMFTopologyNode extends IMFAttributes {
    static IID := "{83CF873A-F6DA-4BC8-823F-BACFD55DC430}"
    SetObject(pObject)
      => ComCall(33, this.p, IUnknown, pObject)
    GetObject(ppObject)
      => ComCall(34, this.p, IUnknown.Ptr, ppObject)
    GetNodeType(pType)
      => ComCall(35, this.p, MF_TOPOLOGY_TYPE.Ptr, pType)
    GetTopoNodeID(pID)
      => ComCall(36, this.p, Int64.Ptr, pID)
    SetTopoNodeID(ullTopoID)
      => ComCall(37, this.p, Int64, ullTopoID)
    GetInputCount(pcInputs)
      => ComCall(38, this.p, UInt32.Ptr, pcInputs)
    GetOutputCount(pcOutputs)
      => ComCall(39, this.p, UInt32.Ptr, pcOutputs)
    ConnectOutput(dwOutputIndex, pDownstreamNode, dwInputIndexOnDownstreamNode)
      => ComCall(40, this.p, UInt32, dwOutputIndex, IMFTopologyNode, pDownstreamNode, UInt32, dwInputIndexOnDownstreamNode)
    DisconnectOutput(dwOutputIndex)
      => ComCall(41, this.p, UInt32, dwOutputIndex)
    GetInput(dwInputIndex, ppUpstreamNode, pdwOutputIndexOnUpstreamNode)
      => ComCall(42, this.p, UInt32, dwInputIndex, IMFTopologyNode.Ptr, ppUpstreamNode, UInt32.Ptr, pdwOutputIndexOnUpstreamNode)
    GetOutput(dwOutputIndex, ppDownstreamNode, pdwInputIndexOnDownstreamNode)
      => ComCall(43, this.p, UInt32, dwOutputIndex, IMFTopologyNode.Ptr, ppDownstreamNode, UInt32.Ptr, pdwInputIndexOnDownstreamNode)
    SetOutputPrefType(dwOutputIndex, pType)
      => ComCall(44, this.p, UInt32, dwOutputIndex, IMFMediaType, pType)
    GetOutputPrefType(dwOutputIndex, ppType)
      => ComCall(45, this.p, UInt32, dwOutputIndex, IMFMediaType.Ptr, ppType)
    SetInputPrefType(dwInputIndex, pType)
      => ComCall(46, this.p, UInt32, dwInputIndex, IMFMediaType, pType)
    GetInputPrefType(dwInputIndex, ppType)
      => ComCall(47, this.p, UInt32, dwInputIndex, IMFMediaType.Ptr, ppType)
    CloneFrom(pNode)
      => ComCall(48, this.p, IMFTopologyNode, pNode)
}
struct MF_TOPONODE_FLUSH_MODE extends Int32 {
    static MF_TOPONODE_FLUSH_ALWAYS := 0
    static MF_TOPONODE_FLUSH_SEEK := 1
    static MF_TOPONODE_FLUSH_NEVER := 2
}
struct MF_TOPONODE_DRAIN_MODE extends Int32 {
    static MF_TOPONODE_DRAIN_DEFAULT := 0
    static MF_TOPONODE_DRAIN_ALWAYS := 1
    static MF_TOPONODE_DRAIN_NEVER := 2
}
struct IMFGetService extends IUnknown {
    static IID := "{FA993888-4383-415A-A930-DD472A8CF6F7}"
    GetService(guidService, riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, guidService, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct MFCLOCK_CHARACTERISTICS_FLAGS extends Int32 {
    static MFCLOCK_CHARACTERISTICS_FLAG_FREQUENCY_10MHZ := 2
    static MFCLOCK_CHARACTERISTICS_FLAG_ALWAYS_RUNNING := 4
    static MFCLOCK_CHARACTERISTICS_FLAG_IS_SYSTEM_CLOCK := 8
}
struct MFCLOCK_STATE extends Int32 {
    static MFCLOCK_STATE_INVALID := 0
    static MFCLOCK_STATE_RUNNING := 1
    static MFCLOCK_STATE_STOPPED := 2
    static MFCLOCK_STATE_PAUSED := 3
}
struct MFCLOCK_RELATIONAL_FLAGS extends Int32 {
    static MFCLOCK_RELATIONAL_FLAG_JITTER_NEVER_AHEAD := 1
}
struct MFCLOCK_PROPERTIES {
    qwCorrelationRate : Int64
    guidClockId : GUID
    dwClockFlags : UInt32
    qwClockFrequency : Int64
    dwClockTolerance : UInt32
    dwClockJitter : UInt32
}
struct IMFClock extends IUnknown {
    static IID := "{2EB1E945-18B8-4139-9B1A-D5D584818530}"
    GetClockCharacteristics(pdwCharacteristics)
      => ComCall(3, this.p, UInt32.Ptr, pdwCharacteristics)
    GetCorrelatedTime(dwReserved, pllClockTime, phnsSystemTime)
      => ComCall(4, this.p, UInt32, dwReserved, Int64.Ptr, pllClockTime, Int64.Ptr, phnsSystemTime)
    GetContinuityKey(pdwContinuityKey)
      => ComCall(5, this.p, UInt32.Ptr, pdwContinuityKey)
    GetState(dwReserved, peClockState)
      => ComCall(6, this.p, UInt32, dwReserved, MFCLOCK_STATE.Ptr, peClockState)
    GetProperties(pClockProperties)
      => ComCall(7, this.p, MFCLOCK_PROPERTIES.Ptr, pClockProperties)
}
struct IMFPresentationClock extends IMFClock {
    static IID := "{868CE85C-8EA9-4F55-AB82-B009A910A805}"
    SetTimeSource(pTimeSource)
      => ComCall(8, this.p, IMFPresentationTimeSource, pTimeSource)
    GetTimeSource(ppTimeSource)
      => ComCall(9, this.p, IMFPresentationTimeSource.Ptr, ppTimeSource)
    GetTime(phnsClockTime)
      => ComCall(10, this.p, Int64.Ptr, phnsClockTime)
    AddClockStateSink(pStateSink)
      => ComCall(11, this.p, IMFClockStateSink, pStateSink)
    RemoveClockStateSink(pStateSink)
      => ComCall(12, this.p, IMFClockStateSink, pStateSink)
    Start(llClockStartOffset)
      => ComCall(13, this.p, Int64, llClockStartOffset)
    Stop()
      => ComCall(14, this.p)
    Pause()
      => ComCall(15, this.p)
}
struct IMFPresentationTimeSource extends IMFClock {
    static IID := "{7FF12CCE-F76F-41C2-863B-1666C8E5E139}"
    GetUnderlyingClock(ppClock)
      => ComCall(8, this.p, IMFClock.Ptr, ppClock)
}
struct IMFClockStateSink extends IUnknown {
    static IID := "{F6696E82-74F7-4F3D-A178-8A5E09C3659F}"
    OnClockStart(hnsSystemTime, llClockStartOffset)
      => ComCall(3, this.p, Int64, hnsSystemTime, Int64, llClockStartOffset)
    OnClockStop(hnsSystemTime)
      => ComCall(4, this.p, Int64, hnsSystemTime)
    OnClockPause(hnsSystemTime)
      => ComCall(5, this.p, Int64, hnsSystemTime)
    OnClockRestart(hnsSystemTime)
      => ComCall(6, this.p, Int64, hnsSystemTime)
    OnClockSetRate(hnsSystemTime, flRate)
      => ComCall(7, this.p, Int64, hnsSystemTime, Float32, flRate)
}
struct IMFPresentationDescriptor extends IMFAttributes {
    static IID := "{03CB2711-24D7-4DB6-A17F-F3A7A479A536}"
    GetStreamDescriptorCount(pdwDescriptorCount)
      => ComCall(33, this.p, UInt32.Ptr, pdwDescriptorCount)
    GetStreamDescriptorByIndex(dwIndex, pfSelected, ppDescriptor)
      => ComCall(34, this.p, UInt32, dwIndex, BOOL.Ptr, pfSelected, IMFStreamDescriptor.Ptr, ppDescriptor)
    SelectStream(dwDescriptorIndex)
      => ComCall(35, this.p, UInt32, dwDescriptorIndex)
    DeselectStream(dwDescriptorIndex)
      => ComCall(36, this.p, UInt32, dwDescriptorIndex)
    Clone(ppPresentationDescriptor)
      => ComCall(37, this.p, IMFPresentationDescriptor.Ptr, ppPresentationDescriptor)
}
struct IMFStreamDescriptor extends IMFAttributes {
    static IID := "{56C03D9C-9DBB-45F5-AB4B-D80F47C05938}"
    GetStreamIdentifier(pdwStreamIdentifier)
      => ComCall(33, this.p, UInt32.Ptr, pdwStreamIdentifier)
    GetMediaTypeHandler(ppMediaTypeHandler)
      => ComCall(34, this.p, IMFMediaTypeHandler.Ptr, ppMediaTypeHandler)
}
struct IMFMediaTypeHandler extends IUnknown {
    static IID := "{E93DCF6C-4B07-4E1E-8123-AA16ED6EADF5}"
    IsMediaTypeSupported(pMediaType, ppMediaType?)
      => ComCall(3, this.p, IMFMediaType, pMediaType, IMFMediaType.Ptr, ppMediaType?)
    GetMediaTypeCount(pdwTypeCount)
      => ComCall(4, this.p, UInt32.Ptr, pdwTypeCount)
    GetMediaTypeByIndex(dwIndex, ppType)
      => ComCall(5, this.p, UInt32, dwIndex, IMFMediaType.Ptr, ppType)
    SetCurrentMediaType(pMediaType)
      => ComCall(6, this.p, IMFMediaType, pMediaType)
    GetCurrentMediaType(ppMediaType)
      => ComCall(7, this.p, IMFMediaType.Ptr, ppMediaType)
    GetMajorType(pguidMajorType)
      => ComCall(8, this.p, GUID.Ptr, pguidMajorType)
}
struct MFTIMER_FLAGS extends Int32 {
    static MFTIMER_RELATIVE := 1
}
struct IMFTimer extends IUnknown {
    static IID := "{E56E4CBD-8F70-49D8-A0F8-EDB3D6AB9BF2}"
    SetTimer(dwFlags, llClockTime, pCallback, punkState, ppunkKey)
      => ComCall(3, this.p, UInt32, dwFlags, Int64, llClockTime, IMFAsyncCallback, pCallback, IUnknown, punkState, IUnknown.Ptr, ppunkKey)
    CancelTimer(punkKey)
      => ComCall(4, this.p, IUnknown, punkKey)
}
struct MF_ACTIVATE_CUSTOM_MIXER extends Int32 {
    static MF_ACTIVATE_CUSTOM_MIXER_ALLOWFAIL := 1
}
struct MF_ACTIVATE_CUSTOM_PRESENTER extends Int32 {
    static MF_ACTIVATE_CUSTOM_PRESENTER_ALLOWFAIL := 1
}
struct MFSHUTDOWN_STATUS extends Int32 {
    static MFSHUTDOWN_INITIATED := 0
    static MFSHUTDOWN_COMPLETED := 1
}
struct IMFShutdown extends IUnknown {
    static IID := "{97EC2EA4-0E42-4937-97AC-9D6D328824E1}"
    Shutdown()
      => ComCall(3, this.p)
    GetShutdownStatus(pStatus)
      => ComCall(4, this.p, MFSHUTDOWN_STATUS.Ptr, pStatus)
}
struct IMFTopoLoader extends IUnknown {
    static IID := "{DE9A6157-F660-4643-B56A-DF9F7998C7CD}"
    Load(pInputTopo, ppOutputTopo, pCurrentTopo)
      => ComCall(3, this.p, IMFTopology, pInputTopo, IMFTopology.Ptr, ppOutputTopo, IMFTopology, pCurrentTopo)
}
struct IMFContentProtectionManager extends IUnknown {
    static IID := "{ACF92459-6A61-42BD-B57C-B43E51203CB0}"
    BeginEnableContent(pEnablerActivate, pTopo, pCallback, punkState)
      => ComCall(3, this.p, IMFActivate, pEnablerActivate, IMFTopology, pTopo, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndEnableContent(pResult)
      => ComCall(4, this.p, IMFAsyncResult, pResult)
}
struct MF_URL_TRUST_STATUS extends Int32 {
    static MF_LICENSE_URL_UNTRUSTED := 0
    static MF_LICENSE_URL_TRUSTED := 1
    static MF_LICENSE_URL_TAMPERED := 2
}
struct IMFContentEnabler extends IUnknown {
    static IID := "{D3C4EF59-49CE-4381-9071-D5BCD044C770}"
    GetEnableType(pType)
      => ComCall(3, this.p, GUID.Ptr, pType)
    GetEnableURL(ppwszURL, pTrustStatus)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszURL, UInt32.Ptr, ppwszURL.Length, MF_URL_TRUST_STATUS.Ptr, pTrustStatus)
    GetEnableData(ppbData)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, ppbData.Length)
    IsAutomaticSupported(pfAutomatic)
      => ComCall(6, this.p, BOOL.Ptr, pfAutomatic)
    AutomaticEnable()
      => ComCall(7, this.p)
    MonitorEnable()
      => ComCall(8, this.p)
    Cancel()
      => ComCall(9, this.p)
}
struct MFRR_COMPONENT_HASH_INFO {
    ulReason : UInt32
    rgHeaderHash : UInt16[43]
    rgPublicKeyHash : UInt16[43]
    wszName : UInt16[260]
}
struct MFRR_COMPONENTS {
    dwRRInfoVersion : UInt32
    dwRRComponents : UInt32
    pRRComponents : MFRR_COMPONENT_HASH_INFO.Ptr
}
struct ASF_FLAT_PICTURE {
    bPictureType : UInt8
    dwDataLen : UInt32
}
struct ASF_FLAT_SYNCHRONISED_LYRICS {
    bTimeStampFormat : UInt8
    bContentType : UInt8
    dwLyricsLen : UInt32
}
struct IMFMetadata extends IUnknown {
    static IID := "{F88CFB8C-EF16-4991-B450-CB8C69E51704}"
    SetLanguage(pwszRFC1766)
      => ComCall(3, this.p, "Str", pwszRFC1766)
    GetLanguage(ppwszRFC1766)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszRFC1766)
    GetAllLanguages(ppvLanguages)
      => ComCall(5, this.p, PROPVARIANT.Ptr, ppvLanguages)
    SetProperty(pwszName, ppvValue)
      => ComCall(6, this.p, "Str", pwszName, PROPVARIANT.Ptr, ppvValue)
    GetProperty(pwszName, ppvValue)
      => ComCall(7, this.p, "Str", pwszName, PROPVARIANT.Ptr, ppvValue)
    DeleteProperty(pwszName)
      => ComCall(8, this.p, "Str", pwszName)
    GetAllPropertyNames(ppvNames)
      => ComCall(9, this.p, PROPVARIANT.Ptr, ppvNames)
}
struct IMFMetadataProvider extends IUnknown {
    static IID := "{56181D2D-E221-4ADB-B1C8-3CEE6A53F76F}"
    GetMFMetadata(pPresentationDescriptor, dwStreamIdentifier, dwFlags, ppMFMetadata)
      => ComCall(3, this.p, IMFPresentationDescriptor, pPresentationDescriptor, UInt32, dwStreamIdentifier, UInt32, dwFlags, IMFMetadata.Ptr, ppMFMetadata)
}
struct MFRATE_DIRECTION extends Int32 {
    static MFRATE_FORWARD := 0
    static MFRATE_REVERSE := 1
}
struct IMFRateSupport extends IUnknown {
    static IID := "{0A9CCDBC-D797-4563-9667-94EC5D79292D}"
    GetSlowestRate(eDirection, fThin, pflRate)
      => ComCall(3, this.p, MFRATE_DIRECTION, eDirection, BOOL, fThin, Float32.Ptr, pflRate)
    GetFastestRate(eDirection, fThin, pflRate)
      => ComCall(4, this.p, MFRATE_DIRECTION, eDirection, BOOL, fThin, Float32.Ptr, pflRate)
    IsRateSupported(fThin, flRate, pflNearestSupportedRate)
      => ComCall(5, this.p, BOOL, fThin, Float32, flRate, Float32.Ptr, pflNearestSupportedRate)
}
struct IMFRateControl extends IUnknown {
    static IID := "{88DDCD21-03C3-4275-91ED-55EE3929328F}"
    SetRate(fThin, flRate)
      => ComCall(3, this.p, BOOL, fThin, Float32, flRate)
    GetRate(pfThin, pflRate)
      => ComCall(4, this.p, BOOL.Ptr, pfThin, Float32.Ptr, pflRate)
}
struct IMFTimecodeTranslate extends IUnknown {
    static IID := "{AB9D8661-F7E8-4EF4-9861-89F334F94E74}"
    BeginConvertTimecodeToHNS(pPropVarTimecode, pCallback, punkState)
      => ComCall(3, this.p, PROPVARIANT.Ptr, pPropVarTimecode, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndConvertTimecodeToHNS(pResult, phnsTime)
      => ComCall(4, this.p, IMFAsyncResult, pResult, Int64.Ptr, phnsTime)
    BeginConvertHNSToTimecode(hnsTime, pCallback, punkState)
      => ComCall(5, this.p, Int64, hnsTime, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndConvertHNSToTimecode(pResult, pPropVarTimecode)
      => ComCall(6, this.p, IMFAsyncResult, pResult, PROPVARIANT.Ptr, pPropVarTimecode)
}
struct IMFSeekInfo extends IUnknown {
    static IID := "{26AFEA53-D9ED-42B5-AB80-E64F9EE34779}"
    GetNearestKeyFrames(pguidTimeFormat, pvarStartPosition, pvarPreviousKeyFrame, pvarNextKeyFrame)
      => ComCall(3, this.p, GUID.Ptr, pguidTimeFormat, PROPVARIANT.Ptr, pvarStartPosition, PROPVARIANT.Ptr, pvarPreviousKeyFrame, PROPVARIANT.Ptr, pvarNextKeyFrame)
}
struct IMFSimpleAudioVolume extends IUnknown {
    static IID := "{089EDF13-CF71-4338-8D13-9E569DBDC319}"
    SetMasterVolume(fLevel)
      => ComCall(3, this.p, Float32, fLevel)
    GetMasterVolume(pfLevel)
      => ComCall(4, this.p, Float32.Ptr, pfLevel)
    SetMute(bMute)
      => ComCall(5, this.p, BOOL, bMute)
    GetMute(pbMute)
      => ComCall(6, this.p, BOOL.Ptr, pbMute)
}
struct IMFAudioStreamVolume extends IUnknown {
    static IID := "{76B1BBDB-4EC8-4F36-B106-70A9316DF593}"
    GetChannelCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    SetChannelVolume(dwIndex, fLevel)
      => ComCall(4, this.p, UInt32, dwIndex, Float32, fLevel)
    GetChannelVolume(dwIndex, pfLevel)
      => ComCall(5, this.p, UInt32, dwIndex, Float32.Ptr, pfLevel)
    SetAllVolumes(pfVolumes)
      => ComCall(6, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes)
    GetAllVolumes(pfVolumes)
      => ComCall(7, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes)
}
struct IMFAudioPolicy extends IUnknown {
    static IID := "{A0638C2B-6465-4395-9AE7-A321A9FD2856}"
    SetGroupingParam(rguidClass)
      => ComCall(3, this.p, GUID.Ptr, rguidClass)
    GetGroupingParam(pguidClass)
      => ComCall(4, this.p, GUID.Ptr, pguidClass)
    SetDisplayName(pszName)
      => ComCall(5, this.p, "Str", pszName)
    GetDisplayName(pszName)
      => ComCall(6, this.p, PWSTR.Ptr, pszName)
    SetIconPath(pszPath)
      => ComCall(7, this.p, "Str", pszPath)
    GetIconPath(pszPath)
      => ComCall(8, this.p, PWSTR.Ptr, pszPath)
}
struct IMFSampleGrabberSinkCallback extends IMFClockStateSink {
    static IID := "{8C7B80BF-EE42-4B59-B1DF-55668E1BDCA8}"
    OnSetPresentationClock(pPresentationClock)
      => ComCall(8, this.p, IMFPresentationClock, pPresentationClock)
    OnProcessSample(guidMajorMediaType, dwSampleFlags, llSampleTime, llSampleDuration, pSampleBuffer)
      => ComCall(9, this.p, GUID.Ptr, guidMajorMediaType, UInt32, dwSampleFlags, Int64, llSampleTime, Int64, llSampleDuration, UInt8.Ptr, pSampleBuffer, UInt32, pSampleBuffer.Size)
    OnShutdown()
      => ComCall(10, this.p)
}
struct IMFSampleGrabberSinkCallback2 extends IMFSampleGrabberSinkCallback {
    static IID := "{CA86AA50-C46E-429E-AB27-16D6AC6844CB}"
    OnProcessSampleEx(guidMajorMediaType, dwSampleFlags, llSampleTime, llSampleDuration, pSampleBuffer, pAttributes)
      => ComCall(11, this.p, GUID.Ptr, guidMajorMediaType, UInt32, dwSampleFlags, Int64, llSampleTime, Int64, llSampleDuration, UInt8.Ptr, pSampleBuffer, UInt32, pSampleBuffer.Size, IMFAttributes, pAttributes)
}
struct IMFWorkQueueServices extends IUnknown {
    static IID := "{35FE1BB8-A3A9-40FE-BBEC-EB569C9CCCA3}"
    BeginRegisterTopologyWorkQueuesWithMMCSS(pCallback, pState)
      => ComCall(3, this.p, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndRegisterTopologyWorkQueuesWithMMCSS(pResult)
      => ComCall(4, this.p, IMFAsyncResult, pResult)
    BeginUnregisterTopologyWorkQueuesWithMMCSS(pCallback, pState)
      => ComCall(5, this.p, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndUnregisterTopologyWorkQueuesWithMMCSS(pResult)
      => ComCall(6, this.p, IMFAsyncResult, pResult)
    GetTopologyWorkQueueMMCSSClass(dwTopologyWorkQueueId, pwszClass)
      => ComCall(7, this.p, UInt32, dwTopologyWorkQueueId, PWSTR, pwszClass, UInt32.Ptr, pwszClass.Length)
    GetTopologyWorkQueueMMCSSTaskId(dwTopologyWorkQueueId, pdwTaskId)
      => ComCall(8, this.p, UInt32, dwTopologyWorkQueueId, UInt32.Ptr, pdwTaskId)
    BeginRegisterPlatformWorkQueueWithMMCSS(dwPlatformWorkQueue, wszClass, dwTaskId, pCallback, pState)
      => ComCall(9, this.p, UInt32, dwPlatformWorkQueue, "Str", wszClass, UInt32, dwTaskId, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndRegisterPlatformWorkQueueWithMMCSS(pResult, pdwTaskId)
      => ComCall(10, this.p, IMFAsyncResult, pResult, UInt32.Ptr, pdwTaskId)
    BeginUnregisterPlatformWorkQueueWithMMCSS(dwPlatformWorkQueue, pCallback, pState)
      => ComCall(11, this.p, UInt32, dwPlatformWorkQueue, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndUnregisterPlatformWorkQueueWithMMCSS(pResult)
      => ComCall(12, this.p, IMFAsyncResult, pResult)
    GetPlaftormWorkQueueMMCSSClass(dwPlatformWorkQueueId, pwszClass)
      => ComCall(13, this.p, UInt32, dwPlatformWorkQueueId, PWSTR, pwszClass, UInt32.Ptr, pwszClass.Length)
    GetPlatformWorkQueueMMCSSTaskId(dwPlatformWorkQueueId, pdwTaskId)
      => ComCall(14, this.p, UInt32, dwPlatformWorkQueueId, UInt32.Ptr, pdwTaskId)
}
struct IMFWorkQueueServicesEx extends IMFWorkQueueServices {
    static IID := "{96BF961B-40FE-42F1-BA9D-320238B49700}"
    GetTopologyWorkQueueMMCSSPriority(dwTopologyWorkQueueId, plPriority)
      => ComCall(15, this.p, UInt32, dwTopologyWorkQueueId, Int32.Ptr, plPriority)
    BeginRegisterPlatformWorkQueueWithMMCSSEx(dwPlatformWorkQueue, wszClass, dwTaskId, lPriority, pCallback, pState)
      => ComCall(16, this.p, UInt32, dwPlatformWorkQueue, "Str", wszClass, UInt32, dwTaskId, Int32, lPriority, IMFAsyncCallback, pCallback, IUnknown, pState)
    GetPlatformWorkQueueMMCSSPriority(dwPlatformWorkQueueId, plPriority)
      => ComCall(17, this.p, UInt32, dwPlatformWorkQueueId, Int32.Ptr, plPriority)
}
struct MF_QUALITY_DROP_MODE extends Int32 {
    static MF_DROP_MODE_NONE := 0
    static MF_DROP_MODE_1 := 1
    static MF_DROP_MODE_2 := 2
    static MF_DROP_MODE_3 := 3
    static MF_DROP_MODE_4 := 4
    static MF_DROP_MODE_5 := 5
    static MF_NUM_DROP_MODES := 6
}
struct MF_QUALITY_LEVEL extends Int32 {
    static MF_QUALITY_NORMAL := 0
    static MF_QUALITY_NORMAL_MINUS_1 := 1
    static MF_QUALITY_NORMAL_MINUS_2 := 2
    static MF_QUALITY_NORMAL_MINUS_3 := 3
    static MF_QUALITY_NORMAL_MINUS_4 := 4
    static MF_QUALITY_NORMAL_MINUS_5 := 5
    static MF_NUM_QUALITY_LEVELS := 6
}
struct MF_QUALITY_ADVISE_FLAGS extends Int32 {
    static MF_QUALITY_CANNOT_KEEP_UP := 1
}
struct IMFQualityManager extends IUnknown {
    static IID := "{8D009D86-5B9F-4115-B1FC-9F80D52AB8AB}"
    NotifyTopology(pTopology)
      => ComCall(3, this.p, IMFTopology, pTopology)
    NotifyPresentationClock(pClock)
      => ComCall(4, this.p, IMFPresentationClock, pClock)
    NotifyProcessInput(pNode, lInputIndex, pSample)
      => ComCall(5, this.p, IMFTopologyNode, pNode, Int32, lInputIndex, IMFSample, pSample)
    NotifyProcessOutput(pNode, lOutputIndex, pSample)
      => ComCall(6, this.p, IMFTopologyNode, pNode, Int32, lOutputIndex, IMFSample, pSample)
    NotifyQualityEvent(pObject, pEvent)
      => ComCall(7, this.p, IUnknown, pObject, IMFMediaEvent, pEvent)
    Shutdown()
      => ComCall(8, this.p)
}
struct IMFQualityAdvise extends IUnknown {
    static IID := "{EC15E2E9-E36B-4F7C-8758-77D452EF4CE7}"
    SetDropMode(eDropMode)
      => ComCall(3, this.p, MF_QUALITY_DROP_MODE, eDropMode)
    SetQualityLevel(eQualityLevel)
      => ComCall(4, this.p, MF_QUALITY_LEVEL, eQualityLevel)
    GetDropMode(peDropMode)
      => ComCall(5, this.p, MF_QUALITY_DROP_MODE.Ptr, peDropMode)
    GetQualityLevel(peQualityLevel)
      => ComCall(6, this.p, MF_QUALITY_LEVEL.Ptr, peQualityLevel)
    DropTime(hnsAmountToDrop)
      => ComCall(7, this.p, Int64, hnsAmountToDrop)
}
struct IMFQualityAdvise2 extends IMFQualityAdvise {
    static IID := "{F3706F0D-8EA2-4886-8000-7155E9EC2EAE}"
    NotifyQualityEvent(pEvent, pdwFlags)
      => ComCall(8, this.p, IMFMediaEvent, pEvent, UInt32.Ptr, pdwFlags)
}
struct IMFQualityAdviseLimits extends IUnknown {
    static IID := "{DFCD8E4D-30B5-4567-ACAA-8EB5B7853DC9}"
    GetMaximumDropMode(peDropMode)
      => ComCall(3, this.p, MF_QUALITY_DROP_MODE.Ptr, peDropMode)
    GetMinimumQualityLevel(peQualityLevel)
      => ComCall(4, this.p, MF_QUALITY_LEVEL.Ptr, peQualityLevel)
}
struct IMFRealTimeClient extends IUnknown {
    static IID := "{2347D60B-3FB5-480C-8803-8DF3ADCD3EF0}"
    RegisterThreads(dwTaskIndex, wszClass)
      => ComCall(3, this.p, UInt32, dwTaskIndex, "Str", wszClass)
    UnregisterThreads()
      => ComCall(4, this.p)
    SetWorkQueue(dwWorkQueueId)
      => ComCall(5, this.p, UInt32, dwWorkQueueId)
}
struct IMFRealTimeClientEx extends IUnknown {
    static IID := "{03910848-AB16-4611-B100-17B88AE2F248}"
    RegisterThreadsEx(pdwTaskIndex, wszClassName, lBasePriority)
      => ComCall(3, this.p, UInt32.Ptr, pdwTaskIndex, "Str", wszClassName, Int32, lBasePriority)
    UnregisterThreads()
      => ComCall(4, this.p)
    SetWorkQueueEx(dwMultithreadedWorkQueueId, lWorkItemBasePriority)
      => ComCall(5, this.p, UInt32, dwMultithreadedWorkQueueId, Int32, lWorkItemBasePriority)
}
struct MFSequencerTopologyFlags extends Int32 {
    static SequencerTopologyFlags_Last := 1
}
struct IMFSequencerSource extends IUnknown {
    static IID := "{197CD219-19CB-4DE1-A64C-ACF2EDCBE59E}"
    AppendTopology(pTopology, dwFlags, pdwId)
      => ComCall(3, this.p, IMFTopology, pTopology, UInt32, dwFlags, UInt32.Ptr, pdwId)
    DeleteTopology(dwId)
      => ComCall(4, this.p, UInt32, dwId)
    GetPresentationContext(pPD, pId?, ppTopology?)
      => ComCall(5, this.p, IMFPresentationDescriptor, pPD, UInt32.Ptr, pId?, IMFTopology.Ptr, ppTopology?)
    UpdateTopology(dwId, pTopology)
      => ComCall(6, this.p, UInt32, dwId, IMFTopology, pTopology)
    UpdateTopologyFlags(dwId, dwFlags)
      => ComCall(7, this.p, UInt32, dwId, UInt32, dwFlags)
}
struct IMFMediaSourceTopologyProvider extends IUnknown {
    static IID := "{0E1D6009-C9F3-442D-8C51-A42D2D49452F}"
    GetMediaSourceTopology(pPresentationDescriptor, ppTopology)
      => ComCall(3, this.p, IMFPresentationDescriptor, pPresentationDescriptor, IMFTopology.Ptr, ppTopology)
}
struct IMFMediaSourcePresentationProvider extends IUnknown {
    static IID := "{0E1D600A-C9F3-442D-8C51-A42D2D49452F}"
    ForceEndOfPresentation(pPresentationDescriptor)
      => ComCall(3, this.p, IMFPresentationDescriptor, pPresentationDescriptor)
}
struct MFTOPONODE_ATTRIBUTE_UPDATE {
    NodeId : Int64
    guidAttributeKey : GUID
    attrType : MF_ATTRIBUTE_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            u32 : UInt32
            u64 : Int64
            d : Float64
        }
    }
}
struct IMFTopologyNodeAttributeEditor extends IUnknown {
    static IID := "{676AA6DD-238A-410D-BB99-65668D01605A}"
    UpdateNodeAttributes(TopoId, pUpdates)
      => ComCall(3, this.p, Int64, TopoId, UInt32, pUpdates.Length, MFTOPONODE_ATTRIBUTE_UPDATE.Ptr, pUpdates)
}
struct MF_LEAKY_BUCKET_PAIR {
    dwBitrate : UInt32
    msBufferWindow : UInt32
}
struct MFBYTESTREAM_BUFFERING_PARAMS {
    cbTotalFileSize : Int64
    cbPlayableDataSize : Int64
    prgBuckets : MF_LEAKY_BUCKET_PAIR.Ptr
    cBuckets : UInt32
    qwNetBufferingTime : Int64
    qwExtraBufferingTimeDuringSeek : Int64
    qwPlayDuration : Int64
    dRate : Float32
}
struct IMFByteStreamBuffering extends IUnknown {
    static IID := "{6D66D782-1D4F-4DB7-8C63-CB8C77F1EF5E}"
    SetBufferingParams(pParams)
      => ComCall(3, this.p, MFBYTESTREAM_BUFFERING_PARAMS.Ptr, pParams)
    EnableBuffering(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
    StopBuffering()
      => ComCall(5, this.p)
}
struct IMFByteStreamCacheControl extends IUnknown {
    static IID := "{F5042EA4-7A96-4A75-AA7B-2BE1EF7F88D5}"
    StopBackgroundTransfer()
      => ComCall(3, this.p)
}
struct IMFByteStreamTimeSeek extends IUnknown {
    static IID := "{64976BFA-FB61-4041-9069-8C9A5F659BEB}"
    IsTimeSeekSupported(pfTimeSeekIsSupported)
      => ComCall(3, this.p, BOOL.Ptr, pfTimeSeekIsSupported)
    TimeSeek(qwTimePosition)
      => ComCall(4, this.p, Int64, qwTimePosition)
    GetTimeSeekResult(pqwStartTime, pqwStopTime, pqwDuration)
      => ComCall(5, this.p, Int64.Ptr, pqwStartTime, Int64.Ptr, pqwStopTime, Int64.Ptr, pqwDuration)
}
struct MF_BYTE_STREAM_CACHE_RANGE {
    qwStartOffset : Int64
    qwEndOffset : Int64
}
struct IMFByteStreamCacheControl2 extends IMFByteStreamCacheControl {
    static IID := "{71CE469C-F34B-49EA-A56B-2D2A10E51149}"
    GetByteRanges(ppRanges)
      => ComCall(4, this.p, UInt32.Ptr, ppRanges.Length, MF_BYTE_STREAM_CACHE_RANGE.Ptr.Ptr, ppRanges)
    SetCacheLimit(qwBytes)
      => ComCall(5, this.p, Int64, qwBytes)
    IsBackgroundTransferActive(pfActive)
      => ComCall(6, this.p, BOOL.Ptr, pfActive)
}
struct IMFNetCredential extends IUnknown {
    static IID := "{5B87EF6A-7ED8-434F-BA0E-184FAC1628D1}"
    SetUser(pbData, fDataIsEncrypted)
      => ComCall(3, this.p, UInt8.Ptr, pbData, UInt32, pbData.Size, BOOL, fDataIsEncrypted)
    SetPassword(pbData, fDataIsEncrypted)
      => ComCall(4, this.p, UInt8.Ptr, pbData, UInt32, pbData.Size, BOOL, fDataIsEncrypted)
    GetUser(pbData?, fEncryptData)
      => ComCall(5, this.p, UInt8.Ptr, pbData?, UInt32.Ptr, pbData?.Length ?? 0, BOOL, fEncryptData)
    GetPassword(pbData?, fEncryptData)
      => ComCall(6, this.p, UInt8.Ptr, pbData?, UInt32.Ptr, pbData?.Length ?? 0, BOOL, fEncryptData)
    LoggedOnUser(pfLoggedOnUser)
      => ComCall(7, this.p, BOOL.Ptr, pfLoggedOnUser)
}
struct MFNetCredentialManagerGetParam {
    hrOp : HRESULT
    fAllowLoggedOnUser : BOOL
    fClearTextPackage : BOOL
    pszUrl : PWSTR
    pszSite : PWSTR
    pszRealm : PWSTR
    pszPackage : PWSTR
    nRetries : Int32
}
struct IMFNetCredentialManager extends IUnknown {
    static IID := "{5B87EF6B-7ED8-434F-BA0E-184FAC1628D1}"
    BeginGetCredentials(pParam, pCallback, pState)
      => ComCall(3, this.p, MFNetCredentialManagerGetParam.Ptr, pParam, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndGetCredentials(pResult, ppCred)
      => ComCall(4, this.p, IMFAsyncResult, pResult, IMFNetCredential.Ptr, ppCred)
    SetGood(pCred, fGood)
      => ComCall(5, this.p, IMFNetCredential, pCred, BOOL, fGood)
}
struct MFNetCredentialRequirements extends Int32 {
    static REQUIRE_PROMPT := 1
    static REQUIRE_SAVE_SELECTED := 2
}
struct MFNetCredentialOptions extends Int32 {
    static MFNET_CREDENTIAL_SAVE := 1
    static MFNET_CREDENTIAL_DONT_CACHE := 2
    static MFNET_CREDENTIAL_ALLOW_CLEAR_TEXT := 4
}
struct MFNetAuthenticationFlags extends Int32 {
    static MFNET_AUTHENTICATION_PROXY := 1
    static MFNET_AUTHENTICATION_CLEAR_TEXT := 2
    static MFNET_AUTHENTICATION_LOGGED_ON_USER := 4
}
struct IMFNetCredentialCache extends IUnknown {
    static IID := "{5B87EF6C-7ED8-434F-BA0E-184FAC1628D1}"
    GetCredential(pszUrl, pszRealm, dwAuthenticationFlags, ppCred, pdwRequirementsFlags)
      => ComCall(3, this.p, "Str", pszUrl, "Str", pszRealm, UInt32, dwAuthenticationFlags, IMFNetCredential.Ptr, ppCred, UInt32.Ptr, pdwRequirementsFlags)
    SetGood(pCred, fGood)
      => ComCall(4, this.p, IMFNetCredential, pCred, BOOL, fGood)
    SetUserOptions(pCred, dwOptionsFlags)
      => ComCall(5, this.p, IMFNetCredential, pCred, UInt32, dwOptionsFlags)
}
struct IMFSSLCertificateManager extends IUnknown {
    static IID := "{61F7D887-1230-4A8B-AEBA-8AD434D1A64D}"
    GetClientCertificate(pszURL, ppbData, pcbData)
      => ComCall(3, this.p, "Str", pszURL, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbData)
    BeginGetClientCertificate(pszURL, pCallback, pState)
      => ComCall(4, this.p, "Str", pszURL, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndGetClientCertificate(pResult, ppbData, pcbData)
      => ComCall(5, this.p, IMFAsyncResult, pResult, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbData)
    GetCertificatePolicy(pszURL, pfOverrideAutomaticCheck, pfClientCertificateAvailable)
      => ComCall(6, this.p, "Str", pszURL, BOOL.Ptr, pfOverrideAutomaticCheck, BOOL.Ptr, pfClientCertificateAvailable)
    OnServerCertificate(pszURL, pbData, pfIsGood)
      => ComCall(7, this.p, "Str", pszURL, UInt8.Ptr, pbData, UInt32, pbData.Size, BOOL.Ptr, pfIsGood)
}
struct IMFNetResourceFilter extends IUnknown {
    static IID := "{091878A3-BF11-4A5C-BC9F-33995B06EF2D}"
    OnRedirect(pszUrl, pvbCancel)
      => ComCall(3, this.p, "Str", pszUrl, VARIANT_BOOL.Ptr, pvbCancel)
    OnSendingRequest(pszUrl)
      => ComCall(4, this.p, "Str", pszUrl)
}
struct IMFSourceOpenMonitor extends IUnknown {
    static IID := "{059054B3-027C-494C-A27D-9113291CF87F}"
    OnSourceEvent(pEvent)
      => ComCall(3, this.p, IMFMediaEvent, pEvent)
}
struct IMFNetProxyLocator extends IUnknown {
    static IID := "{E9CD0383-A268-4BB4-82DE-658D53574D41}"
    FindFirstProxy(pszHost, pszUrl, fReserved)
      => ComCall(3, this.p, "Str", pszHost, "Str", pszUrl, BOOL, fReserved)
    FindNextProxy()
      => ComCall(4, this.p)
    RegisterProxyResult(hrOp)
      => ComCall(5, this.p, HRESULT, hrOp)
    GetCurrentProxy(pszStr?)
      => ComCall(6, this.p, PWSTR, pszStr?, UInt32.Ptr, pszStr?.Length ?? 0)
    Clone(ppProxyLocator)
      => ComCall(7, this.p, IMFNetProxyLocator.Ptr, ppProxyLocator)
}
struct IMFNetProxyLocatorFactory extends IUnknown {
    static IID := "{E9CD0384-A268-4BB4-82DE-658D53574D41}"
    CreateProxyLocator(pszProtocol, ppProxyLocator)
      => ComCall(3, this.p, "Str", pszProtocol, IMFNetProxyLocator.Ptr, ppProxyLocator)
}
struct IMFSaveJob extends IUnknown {
    static IID := "{E9931663-80BF-4C6E-98AF-5DCF58747D1F}"
    BeginSave(pStream, pCallback, pState)
      => ComCall(3, this.p, IMFByteStream, pStream, IMFAsyncCallback, pCallback, IUnknown, pState)
    EndSave(pResult)
      => ComCall(4, this.p, IMFAsyncResult, pResult)
    CancelSave()
      => ComCall(5, this.p)
    GetProgress(pdwPercentComplete)
      => ComCall(6, this.p, UInt32.Ptr, pdwPercentComplete)
}
struct MFNETSOURCE_PROTOCOL_TYPE extends Int32 {
    static MFNETSOURCE_UNDEFINED := 0
    static MFNETSOURCE_HTTP := 1
    static MFNETSOURCE_RTSP := 2
    static MFNETSOURCE_FILE := 3
    static MFNETSOURCE_MULTICAST := 4
}
struct IMFNetSchemeHandlerConfig extends IUnknown {
    static IID := "{7BE19E73-C9BF-468A-AC5A-A5E8653BEC87}"
    GetNumberOfSupportedProtocols(pcProtocols)
      => ComCall(3, this.p, UInt32.Ptr, pcProtocols)
    GetSupportedProtocolType(nProtocolIndex, pnProtocolType)
      => ComCall(4, this.p, UInt32, nProtocolIndex, MFNETSOURCE_PROTOCOL_TYPE.Ptr, pnProtocolType)
    ResetProtocolRolloverSettings()
      => ComCall(5, this.p)
}
struct MFNETSOURCE_TRANSPORT_TYPE extends Int32 {
    static MFNETSOURCE_UDP := 0
    static MFNETSOURCE_TCP := 1
}
struct MFNETSOURCE_CACHE_STATE extends Int32 {
    static MFNETSOURCE_CACHE_UNAVAILABLE := 0
    static MFNETSOURCE_CACHE_ACTIVE_WRITING := 1
    static MFNETSOURCE_CACHE_ACTIVE_COMPLETE := 2
}
struct MFNETSOURCE_STATISTICS_IDS extends Int32 {
    static MFNETSOURCE_RECVPACKETS_ID := 0
    static MFNETSOURCE_LOSTPACKETS_ID := 1
    static MFNETSOURCE_RESENDSREQUESTED_ID := 2
    static MFNETSOURCE_RESENDSRECEIVED_ID := 3
    static MFNETSOURCE_RECOVEREDBYECCPACKETS_ID := 4
    static MFNETSOURCE_RECOVEREDBYRTXPACKETS_ID := 5
    static MFNETSOURCE_OUTPACKETS_ID := 6
    static MFNETSOURCE_RECVRATE_ID := 7
    static MFNETSOURCE_AVGBANDWIDTHBPS_ID := 8
    static MFNETSOURCE_BYTESRECEIVED_ID := 9
    static MFNETSOURCE_PROTOCOL_ID := 10
    static MFNETSOURCE_TRANSPORT_ID := 11
    static MFNETSOURCE_CACHE_STATE_ID := 12
    static MFNETSOURCE_LINKBANDWIDTH_ID := 13
    static MFNETSOURCE_CONTENTBITRATE_ID := 14
    static MFNETSOURCE_SPEEDFACTOR_ID := 15
    static MFNETSOURCE_BUFFERSIZE_ID := 16
    static MFNETSOURCE_BUFFERPROGRESS_ID := 17
    static MFNETSOURCE_LASTBWSWITCHTS_ID := 18
    static MFNETSOURCE_SEEKRANGESTART_ID := 19
    static MFNETSOURCE_SEEKRANGEEND_ID := 20
    static MFNETSOURCE_BUFFERINGCOUNT_ID := 21
    static MFNETSOURCE_INCORRECTLYSIGNEDPACKETS_ID := 22
    static MFNETSOURCE_SIGNEDSESSION_ID := 23
    static MFNETSOURCE_MAXBITRATE_ID := 24
    static MFNETSOURCE_RECEPTION_QUALITY_ID := 25
    static MFNETSOURCE_RECOVEREDPACKETS_ID := 26
    static MFNETSOURCE_VBR_ID := 27
    static MFNETSOURCE_DOWNLOADPROGRESS_ID := 28
    static MFNETSOURCE_UNPREDEFINEDPROTOCOLNAME_ID := 29
}
struct MFNET_PROXYSETTINGS extends Int32 {
    static MFNET_PROXYSETTING_NONE := 0
    static MFNET_PROXYSETTING_MANUAL := 1
    static MFNET_PROXYSETTING_AUTO := 2
    static MFNET_PROXYSETTING_BROWSER := 3
}
struct IMFSchemeHandler extends IUnknown {
    static IID := "{6D4C7B74-52A0-4BB7-B0DB-55F29F47A668}"
    BeginCreateObject(pwszURL, dwFlags, pProps, ppIUnknownCancelCookie?, pCallback, punkState)
      => ComCall(3, this.p, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, IUnknown.Ptr, ppIUnknownCancelCookie?, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndCreateObject(pResult, pObjectType, ppObject)
      => ComCall(4, this.p, IMFAsyncResult, pResult, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    CancelObjectCreation(pIUnknownCancelCookie)
      => ComCall(5, this.p, IUnknown, pIUnknownCancelCookie)
}
struct IMFByteStreamHandler extends IUnknown {
    static IID := "{BB420AA4-765B-4A1F-91FE-D6A8A143924C}"
    BeginCreateObject(pByteStream, pwszURL, dwFlags, pProps, ppIUnknownCancelCookie?, pCallback, punkState)
      => ComCall(3, this.p, IMFByteStream, pByteStream, "Str", pwszURL, UInt32, dwFlags, IPropertyStore, pProps, IUnknown.Ptr, ppIUnknownCancelCookie?, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndCreateObject(pResult, pObjectType, ppObject)
      => ComCall(4, this.p, IMFAsyncResult, pResult, MF_OBJECT_TYPE.Ptr, pObjectType, IUnknown.Ptr, ppObject)
    CancelObjectCreation(pIUnknownCancelCookie)
      => ComCall(5, this.p, IUnknown, pIUnknownCancelCookie)
    GetMaxNumberOfBytesRequiredForResolution(pqwBytes)
      => ComCall(6, this.p, Int64.Ptr, pqwBytes)
}
struct IMFTrustedInput extends IUnknown {
    static IID := "{542612C4-A1B8-4632-B521-DE11EA64A0B0}"
    GetInputTrustAuthority(dwStreamID, riid, ppunkObject)
      => ComCall(3, this.p, UInt32, dwStreamID, GUID.Ptr, riid, IUnknown.Ptr, ppunkObject)
}
struct MFPOLICYMANAGER_ACTION extends Int32 {
    static PEACTION_NO := 0
    static PEACTION_PLAY := 1
    static PEACTION_COPY := 2
    static PEACTION_EXPORT := 3
    static PEACTION_EXTRACT := 4
    static PEACTION_RESERVED1 := 5
    static PEACTION_RESERVED2 := 6
    static PEACTION_RESERVED3 := 7
    static PEACTION_LAST := 7
}
struct MFINPUTTRUSTAUTHORITY_ACCESS_ACTION {
    Action : MFPOLICYMANAGER_ACTION
    pbTicket : UInt8.Ptr
    cbTicket : UInt32
}
struct MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS {
    dwSize : UInt32
    dwVer : UInt32
    cbSignatureOffset : UInt32
    cbSignatureSize : UInt32
    cbExtensionOffset : UInt32
    cbExtensionSize : UInt32
    cActions : UInt32
    rgOutputActions : MFINPUTTRUSTAUTHORITY_ACCESS_ACTION[1]
}
struct IMFInputTrustAuthority extends IUnknown {
    static IID := "{D19F8E98-B126-4446-890C-5DCB7AD71453}"
    GetDecrypter(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    RequestAccess(Action, ppContentEnablerActivate)
      => ComCall(4, this.p, MFPOLICYMANAGER_ACTION, Action, IMFActivate.Ptr, ppContentEnablerActivate)
    GetPolicy(Action, ppPolicy)
      => ComCall(5, this.p, MFPOLICYMANAGER_ACTION, Action, IMFOutputPolicy.Ptr, ppPolicy)
    BindAccess(pParam)
      => ComCall(6, this.p, MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS.Ptr, pParam)
    UpdateAccess(pParam)
      => ComCall(7, this.p, MFINPUTTRUSTAUTHORITY_ACCESS_PARAMS.Ptr, pParam)
    Reset()
      => ComCall(8, this.p)
}
struct IMFTrustedOutput extends IUnknown {
    static IID := "{D19F8E95-B126-4446-890C-5DCB7AD71453}"
    GetOutputTrustAuthorityCount(pcOutputTrustAuthorities)
      => ComCall(3, this.p, UInt32.Ptr, pcOutputTrustAuthorities)
    GetOutputTrustAuthorityByIndex(dwIndex, ppauthority)
      => ComCall(4, this.p, UInt32, dwIndex, IMFOutputTrustAuthority.Ptr, ppauthority)
    IsFinal(pfIsFinal)
      => ComCall(5, this.p, BOOL.Ptr, pfIsFinal)
}
struct IMFOutputTrustAuthority extends IUnknown {
    static IID := "{D19F8E94-B126-4446-890C-5DCB7AD71453}"
    GetAction(pAction)
      => ComCall(3, this.p, MFPOLICYMANAGER_ACTION.Ptr, pAction)
    SetPolicy(ppPolicy?, ppbTicket?, pcbTicket?)
      => ComCall(4, this.p, IMFOutputPolicy.Ptr, ppPolicy?, UInt32, ppPolicy?.Length ?? 0, UInt8.Ptr.Ptr, ppbTicket?, UInt32.Ptr, pcbTicket?)
}
struct IMFOutputPolicy extends IMFAttributes {
    static IID := "{7F00F10A-DAED-41AF-AB26-5FDFA4DFBA3C}"
    GenerateRequiredSchemas(dwAttributes, guidOutputSubType, rgGuidProtectionSchemasSupported, cProtectionSchemasSupported, ppRequiredProtectionSchemas)
      => ComCall(33, this.p, UInt32, dwAttributes, GUID, guidOutputSubType, GUID.Ptr, rgGuidProtectionSchemasSupported, UInt32, cProtectionSchemasSupported, IMFCollection.Ptr, ppRequiredProtectionSchemas)
    GetOriginatorID(pguidOriginatorID)
      => ComCall(34, this.p, GUID.Ptr, pguidOriginatorID)
    GetMinimumGRLVersion(pdwMinimumGRLVersion)
      => ComCall(35, this.p, UInt32.Ptr, pdwMinimumGRLVersion)
}
struct IMFOutputSchema extends IMFAttributes {
    static IID := "{7BE0FC5B-ABD9-44FB-A5C8-F50136E71599}"
    GetSchemaType(pguidSchemaType)
      => ComCall(33, this.p, GUID.Ptr, pguidSchemaType)
    GetConfigurationData(pdwVal)
      => ComCall(34, this.p, UInt32.Ptr, pdwVal)
    GetOriginatorID(pguidOriginatorID)
      => ComCall(35, this.p, GUID.Ptr, pguidOriginatorID)
}
struct MF_OPM_CGMSA_PROTECTION_LEVEL extends Int32 {
    static MF_OPM_CGMSA_OFF := 0
    static MF_OPM_CGMSA_COPY_FREELY := 1
    static MF_OPM_CGMSA_COPY_NO_MORE := 2
    static MF_OPM_CGMSA_COPY_ONE_GENERATION := 3
    static MF_OPM_CGMSA_COPY_NEVER := 4
    static MF_OPM_CGMSA_REDISTRIBUTION_CONTROL_REQUIRED := 8
}
struct MF_OPM_ACP_PROTECTION_LEVEL extends Int32 {
    static MF_OPM_ACP_OFF := 0
    static MF_OPM_ACP_LEVEL_ONE := 1
    static MF_OPM_ACP_LEVEL_TWO := 2
    static MF_OPM_ACP_LEVEL_THREE := 3
}
struct MFAudioConstriction extends Int32 {
    static MFaudioConstrictionOff := 0
    static MFaudioConstriction48_16 := 1
    static MFaudioConstriction44_16 := 2
    static MFaudioConstriction14_14 := 3
    static MFaudioConstrictionMute := 4
}
struct IMFSecureChannel extends IUnknown {
    static IID := "{D0AE555D-3B12-4D97-B060-0990BC5AEB67}"
    GetCertificate(ppCert, pcbCert)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppCert, UInt32.Ptr, pcbCert)
    SetupSession(pbEncryptedSessionKey)
      => ComCall(4, this.p, UInt8.Ptr, pbEncryptedSessionKey, UInt32, pbEncryptedSessionKey.Size)
}
struct SAMPLE_PROTECTION_VERSION extends Int32 {
    static SAMPLE_PROTECTION_VERSION_NO := 0
    static SAMPLE_PROTECTION_VERSION_BASIC_LOKI := 1
    static SAMPLE_PROTECTION_VERSION_SCATTER := 2
    static SAMPLE_PROTECTION_VERSION_RC4 := 3
    static SAMPLE_PROTECTION_VERSION_AES128CTR := 4
}
struct IMFSampleProtection extends IUnknown {
    static IID := "{8E36395F-C7B9-43C4-A54D-512B4AF63C95}"
    GetInputProtectionVersion(pdwVersion)
      => ComCall(3, this.p, UInt32.Ptr, pdwVersion)
    GetOutputProtectionVersion(pdwVersion)
      => ComCall(4, this.p, UInt32.Ptr, pdwVersion)
    GetProtectionCertificate(dwVersion, ppCert, pcbCert)
      => ComCall(5, this.p, UInt32, dwVersion, UInt8.Ptr.Ptr, ppCert, UInt32.Ptr, pcbCert)
    InitOutputProtection(dwVersion, dwOutputId, pbCert, cbCert, ppbSeed, pcbSeed)
      => ComCall(6, this.p, UInt32, dwVersion, UInt32, dwOutputId, UInt8.Ptr, pbCert, UInt32, cbCert, UInt8.Ptr.Ptr, ppbSeed, UInt32.Ptr, pcbSeed)
    InitInputProtection(dwVersion, dwInputId, pbSeed, cbSeed)
      => ComCall(7, this.p, UInt32, dwVersion, UInt32, dwInputId, UInt8.Ptr, pbSeed, UInt32, cbSeed)
}
struct IMFMediaSinkPreroll extends IUnknown {
    static IID := "{5DFD4B2A-7674-4110-A4E6-8A68FD5F3688}"
    NotifyPreroll(hnsUpcomingStartTime)
      => ComCall(3, this.p, Int64, hnsUpcomingStartTime)
}
struct IMFFinalizableMediaSink extends IMFMediaSink {
    static IID := "{EAECB74A-9A50-42CE-9541-6A7F57AA4AD7}"
    BeginFinalize(pCallback, punkState)
      => ComCall(12, this.p, IMFAsyncCallback, pCallback, IUnknown, punkState)
    EndFinalize(pResult)
      => ComCall(13, this.p, IMFAsyncResult, pResult)
}
struct IMFStreamingSinkConfig extends IUnknown {
    static IID := "{9DB7AA41-3CC5-40D4-8509-555804AD34CC}"
    StartStreaming(fSeekOffsetIsByteOffset, qwSeekOffset)
      => ComCall(3, this.p, BOOL, fSeekOffsetIsByteOffset, Int64, qwSeekOffset)
}
struct IMFRemoteProxy extends IUnknown {
    static IID := "{994E23AD-1CC2-493C-B9FA-46F1CB040FA4}"
    GetRemoteObject(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetRemoteHost(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IMFObjectReferenceStream extends IUnknown {
    static IID := "{09EF5BE3-C8A7-469E-8B70-73BF25BB193F}"
    SaveReference(riid, pUnk)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, pUnk)
    LoadReference(riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IMFPMPHost extends IUnknown {
    static IID := "{F70CA1A9-FDC7-4782-B994-ADFFB1C98606}"
    LockProcess()
      => ComCall(3, this.p)
    UnlockProcess()
      => ComCall(4, this.p)
    CreateObjectByCLSID(clsid, pStream, riid, ppv)
      => ComCall(5, this.p, GUID.Ptr, clsid, IStream, pStream, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IMFPMPClient extends IUnknown {
    static IID := "{6C4E655D-EAD8-4421-B6B9-54DCDBBDF820}"
    SetPMPHost(pPMPHost)
      => ComCall(3, this.p, IMFPMPHost, pPMPHost)
}
struct IMFPMPServer extends IUnknown {
    static IID := "{994E23AF-1CC2-493C-B9FA-46F1CB040FA4}"
    LockProcess()
      => ComCall(3, this.p)
    UnlockProcess()
      => ComCall(4, this.p)
    CreateObjectByCLSID(clsid, riid, ppObject)
      => ComCall(5, this.p, GUID.Ptr, clsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppObject)
}
struct IMFRemoteDesktopPlugin extends IUnknown {
    static IID := "{1CDE6309-CAE0-4940-907E-C1EC9C3D1D4A}"
    UpdateTopology(pTopology)
      => ComCall(3, this.p, IMFTopology, pTopology)
}
struct IMFSAMIStyle extends IUnknown {
    static IID := "{A7E025DD-5303-4A62-89D6-E747E1EFAC73}"
    GetStyleCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    GetStyles(pPropVarStyleArray)
      => ComCall(4, this.p, PROPVARIANT.Ptr, pPropVarStyleArray)
    SetSelectedStyle(pwszStyle)
      => ComCall(5, this.p, "Str", pwszStyle)
    GetSelectedStyle(ppwszStyle)
      => ComCall(6, this.p, PWSTR.Ptr, ppwszStyle)
}
struct IMFTranscodeProfile extends IUnknown {
    static IID := "{4ADFDBA3-7AB0-4953-A62B-461E7FF3DA1E}"
    SetAudioAttributes(pAttrs?)
      => ComCall(3, this.p, IMFAttributes, pAttrs?)
    GetAudioAttributes(ppAttrs)
      => ComCall(4, this.p, IMFAttributes.Ptr, ppAttrs)
    SetVideoAttributes(pAttrs?)
      => ComCall(5, this.p, IMFAttributes, pAttrs?)
    GetVideoAttributes(ppAttrs)
      => ComCall(6, this.p, IMFAttributes.Ptr, ppAttrs)
    SetContainerAttributes(pAttrs?)
      => ComCall(7, this.p, IMFAttributes, pAttrs?)
    GetContainerAttributes(ppAttrs)
      => ComCall(8, this.p, IMFAttributes.Ptr, ppAttrs)
}
struct MF_TRANSCODE_TOPOLOGYMODE_FLAGS extends Int32 {
    static MF_TRANSCODE_TOPOLOGYMODE_SOFTWARE_ONLY := 0
    static MF_TRANSCODE_TOPOLOGYMODE_HARDWARE_ALLOWED := 1
}
struct MF_TRANSCODE_ADJUST_PROFILE_FLAGS extends Int32 {
    static MF_TRANSCODE_ADJUST_PROFILE_DEFAULT := 0
    static MF_TRANSCODE_ADJUST_PROFILE_USE_SOURCE_ATTRIBUTES := 1
}
struct MF_VIDEO_PROCESSOR_ALGORITHM_TYPE extends Int32 {
    static MF_VIDEO_PROCESSOR_ALGORITHM_DEFAULT := 0
    static MF_VIDEO_PROCESSOR_ALGORITHM_MRF_CRF_444 := 1
}
struct MF_TRANSCODE_SINK_INFO {
    dwVideoStreamID : UInt32
    pVideoMediaType : IMFMediaType
    dwAudioStreamID : UInt32
    pAudioMediaType : IMFMediaType
}
struct IMFTranscodeSinkInfoProvider extends IUnknown {
    static IID := "{8CFFCD2E-5A03-4A3A-AFF7-EDCD107C620E}"
    SetOutputFile(pwszFileName)
      => ComCall(3, this.p, "Str", pwszFileName)
    SetOutputByteStream(pByteStreamActivate)
      => ComCall(4, this.p, IMFActivate, pByteStreamActivate)
    SetProfile(pProfile)
      => ComCall(5, this.p, IMFTranscodeProfile, pProfile)
    GetSinkInfo(pSinkInfo)
      => ComCall(6, this.p, MF_TRANSCODE_SINK_INFO.Ptr, pSinkInfo)
}
struct IMFFieldOfUseMFTUnlock extends IUnknown {
    static IID := "{508E71D3-EC66-4FC3-8775-B4B9ED6BA847}"
    Unlock(pUnkMFT)
      => ComCall(3, this.p, IUnknown, pUnkMFT)
}
struct MFT_REGISTRATION_INFO {
    clsid : GUID
    guidCategory : GUID
    uiFlags : UInt32
    pszName : PWSTR
    cInTypes : UInt32
    pInTypes : MFT_REGISTER_TYPE_INFO.Ptr
    cOutTypes : UInt32
    pOutTypes : MFT_REGISTER_TYPE_INFO.Ptr
}
struct IMFLocalMFTRegistration extends IUnknown {
    static IID := "{149C4D73-B4BE-4F8D-8B87-079E926B6ADD}"
    RegisterMFTs(pMFTs)
      => ComCall(3, this.p, MFT_REGISTRATION_INFO.Ptr, pMFTs, UInt32, pMFTs.Length)
}
struct IMFCapturePhotoConfirmation extends IUnknown {
    static IID := "{19F68549-CA8A-4706-A4EF-481DBC95E12C}"
    SetPhotoConfirmationCallback(pNotificationCallback)
      => ComCall(3, this.p, IMFAsyncCallback, pNotificationCallback)
    SetPixelFormat(subtype)
      => ComCall(4, this.p, GUID, subtype)
    GetPixelFormat(subtype)
      => ComCall(5, this.p, GUID.Ptr, subtype)
}
struct IMFPMPHostApp extends IUnknown {
    static IID := "{84D2054A-3AA1-4728-A3B0-440A418CF49C}"
    LockProcess()
      => ComCall(3, this.p)
    UnlockProcess()
      => ComCall(4, this.p)
    ActivateClassById(id, pStream, riid, ppv)
      => ComCall(5, this.p, "Str", id, IStream, pStream, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IMFPMPClientApp extends IUnknown {
    static IID := "{C004F646-BE2C-48F3-93A2-A0983EBA1108}"
    SetPMPHost(pPMPHost)
      => ComCall(3, this.p, IMFPMPHostApp, pPMPHost)
}
struct IMFMediaStreamSourceSampleRequest extends IUnknown {
    static IID := "{380B9AF9-A85B-4E78-A2AF-EA5CE645C6B4}"
    SetSample(value)
      => ComCall(3, this.p, IMFSample, value)
}
struct IMFTrackedSample extends IUnknown {
    static IID := "{245BF8E9-0755-40F7-88A5-AE0F18D55E17}"
    SetAllocator(pSampleAllocator, pUnkState)
      => ComCall(3, this.p, IMFAsyncCallback, pSampleAllocator, IUnknown, pUnkState)
}
struct IMFProtectedEnvironmentAccess extends IUnknown {
    static IID := "{EF5DC845-F0D9-4EC9-B00C-CB5183D38434}"
    Call(input, output)
      => ComCall(3, this.p, UInt32, input.Size, UInt8.Ptr, input, UInt32, output.Size, UInt8.Ptr, output)
    ReadGRL(outputLength, output)
      => ComCall(4, this.p, UInt32.Ptr, outputLength, UInt8.Ptr.Ptr, output)
}
struct IMFSignedLibrary extends IUnknown {
    static IID := "{4A724BCA-FF6A-4C07-8E0D-7A358421CF06}"
    GetProcedureAddress(name, address)
      => ComCall(3, this.p, PSTR, name, Struct.Ptr.Ptr, address)
}
struct IMFSystemId extends IUnknown {
    static IID := "{FFF4AF3A-1FC1-4EF9-A29B-D26C49E2F31A}"
    GetData(size, data)
      => ComCall(3, this.p, UInt32.Ptr, size, UInt8.Ptr.Ptr, data)
    Setup(stage, pbIn, pcbOut, ppbOut)
      => ComCall(4, this.p, UInt32, stage, UInt32, pbIn.Size, UInt8.Ptr, pbIn, UInt32.Ptr, pcbOut, UInt8.Ptr.Ptr, ppbOut)
}
struct MFCONTENTPROTECTIONDEVICE_INPUT_DATA {
    HWProtectionFunctionID : UInt32
    PrivateDataByteCount : UInt32
    HWProtectionDataByteCount : UInt32
    Reserved : UInt32
    InputData : UInt8[4]
}
struct MFCONTENTPROTECTIONDEVICE_OUTPUT_DATA {
    PrivateDataByteCount : UInt32
    MaxHWProtectionDataByteCount : UInt32
    HWProtectionDataByteCount : UInt32
    Status : HRESULT
    TransportTimeInHundredsOfNanoseconds : Int64
    ExecutionTimeInHundredsOfNanoseconds : Int64
    OutputData : UInt8[4]
}
struct MFCONTENTPROTECTIONDEVICE_REALTIMECLIENT_DATA {
    TaskIndex : UInt32
    ClassName : UInt16[260]
    BasePriority : Int32
}
struct IMFContentProtectionDevice extends IUnknown {
    static IID := "{E6257174-A060-4C9A-A088-3B1B471CAD28}"
    InvokeFunction(FunctionId, InputBuffer, OutputBufferByteCount, OutputBuffer)
      => ComCall(3, this.p, UInt32, FunctionId, UInt32, InputBuffer.Size, UInt8.Ptr, InputBuffer, UInt32.Ptr, OutputBufferByteCount, UInt8.Ptr, OutputBuffer)
    GetPrivateDataByteCount(PrivateInputByteCount, PrivateOutputByteCount)
      => ComCall(4, this.p, UInt32.Ptr, PrivateInputByteCount, UInt32.Ptr, PrivateOutputByteCount)
}
struct IMFContentDecryptorContext extends IUnknown {
    static IID := "{7EC4B1BD-43FB-4763-85D2-64FCB5C5F4CB}"
    InitializeHardwareKey(InputPrivateData?, OutputPrivateData)
      => ComCall(3, this.p, UInt32, InputPrivateData?.Length ?? 0, Struct.Ptr, InputPrivateData?, Int64.Ptr, OutputPrivateData)
}
struct MF_MEDIAKEYSESSION_TYPE extends Int32 {
    static MF_MEDIAKEYSESSION_TYPE_TEMPORARY := 0
    static MF_MEDIAKEYSESSION_TYPE_PERSISTENT_LICENSE := 1
    static MF_MEDIAKEYSESSION_TYPE_PERSISTENT_RELEASE_MESSAGE := 2
    static MF_MEDIAKEYSESSION_TYPE_PERSISTENT_USAGE_RECORD := 3
}
struct MF_MEDIAKEY_STATUS extends Int32 {
    static MF_MEDIAKEY_STATUS_USABLE := 0
    static MF_MEDIAKEY_STATUS_EXPIRED := 1
    static MF_MEDIAKEY_STATUS_OUTPUT_DOWNSCALED := 2
    static MF_MEDIAKEY_STATUS_OUTPUT_NOT_ALLOWED := 3
    static MF_MEDIAKEY_STATUS_STATUS_PENDING := 4
    static MF_MEDIAKEY_STATUS_INTERNAL_ERROR := 5
    static MF_MEDIAKEY_STATUS_RELEASED := 6
    static MF_MEDIAKEY_STATUS_OUTPUT_RESTRICTED := 7
}
struct MFMediaKeyStatus {
    pbKeyId : UInt8.Ptr
    cbKeyId : UInt32
    eMediaKeyStatus : MF_MEDIAKEY_STATUS
}
struct MF_MEDIAKEYSESSION_MESSAGETYPE extends Int32 {
    static MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_REQUEST := 0
    static MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RENEWAL := 1
    static MF_MEDIAKEYSESSION_MESSAGETYPE_LICENSE_RELEASE := 2
    static MF_MEDIAKEYSESSION_MESSAGETYPE_INDIVIDUALIZATION_REQUEST := 3
}
struct MF_CROSS_ORIGIN_POLICY extends Int32 {
    static MF_CROSS_ORIGIN_POLICY_NONE := 0
    static MF_CROSS_ORIGIN_POLICY_ANONYMOUS := 1
    static MF_CROSS_ORIGIN_POLICY_USE_CREDENTIALS := 2
}
struct IMFNetCrossOriginSupport extends IUnknown {
    static IID := "{BC2B7D44-A72D-49D5-8376-1480DEE58B22}"
    GetCrossOriginPolicy(pPolicy)
      => ComCall(3, this.p, MF_CROSS_ORIGIN_POLICY.Ptr, pPolicy)
    GetSourceOrigin(wszSourceOrigin)
      => ComCall(4, this.p, PWSTR.Ptr, wszSourceOrigin)
    IsSameOrigin(wszURL, pfIsSameOrigin)
      => ComCall(5, this.p, "Str", wszURL, BOOL.Ptr, pfIsSameOrigin)
}
struct IMFHttpDownloadRequest extends IUnknown {
    static IID := "{F779FDDF-26E7-4270-8A8B-B983D1859DE0}"
    AddHeader(szHeader)
      => ComCall(3, this.p, "Str", szHeader)
    BeginSendRequest(pbPayload?, pCallback, punkState?)
      => ComCall(4, this.p, UInt8.Ptr, pbPayload?, UInt32, pbPayload?.Length ?? 0, IMFAsyncCallback, pCallback, IUnknown, punkState?)
    EndSendRequest(pResult)
      => ComCall(5, this.p, IMFAsyncResult, pResult)
    BeginReceiveResponse(pCallback, punkState?)
      => ComCall(6, this.p, IMFAsyncCallback, pCallback, IUnknown, punkState?)
    EndReceiveResponse(pResult)
      => ComCall(7, this.p, IMFAsyncResult, pResult)
    BeginReadPayload(pb, pCallback, punkState?)
      => ComCall(8, this.p, UInt8.Ptr, pb, UInt32, pb.Length, IMFAsyncCallback, pCallback, IUnknown, punkState?)
    EndReadPayload(pResult, pqwOffset, pcbRead)
      => ComCall(9, this.p, IMFAsyncResult, pResult, Int64.Ptr, pqwOffset, UInt32.Ptr, pcbRead)
    QueryHeader(szHeaderName, dwIndex, ppszHeaderValue)
      => ComCall(10, this.p, "Str", szHeaderName, UInt32, dwIndex, PWSTR.Ptr, ppszHeaderValue)
    GetURL(ppszURL)
      => ComCall(11, this.p, PWSTR.Ptr, ppszURL)
    HasNullSourceOrigin(pfNullSourceOrigin)
      => ComCall(12, this.p, BOOL.Ptr, pfNullSourceOrigin)
    GetTimeSeekResult(pqwStartTime, pqwStopTime, pqwDuration)
      => ComCall(13, this.p, Int64.Ptr, pqwStartTime, Int64.Ptr, pqwStopTime, Int64.Ptr, pqwDuration)
    GetHttpStatus(pdwHttpStatus)
      => ComCall(14, this.p, UInt32.Ptr, pdwHttpStatus)
    GetAtEndOfPayload(pfAtEndOfPayload)
      => ComCall(15, this.p, BOOL.Ptr, pfAtEndOfPayload)
    GetTotalLength(pqwTotalLength)
      => ComCall(16, this.p, Int64.Ptr, pqwTotalLength)
    GetRangeEndOffset(pqwRangeEnd)
      => ComCall(17, this.p, Int64.Ptr, pqwRangeEnd)
    Close()
      => ComCall(18, this.p)
}
struct IMFHttpDownloadSession extends IUnknown {
    static IID := "{71FA9A2C-53CE-4662-A132-1A7E8CBF62DB}"
    SetServer(szServerName, nPort)
      => ComCall(3, this.p, "Str", szServerName, UInt32, nPort)
    CreateRequest(szObjectName, fBypassProxyCache, fSecure, szVerb?, szReferrer?, ppRequest)
      => ComCall(4, this.p, "Str", szObjectName, BOOL, fBypassProxyCache, BOOL, fSecure, "Str", szVerb?, "Str", szReferrer?, IMFHttpDownloadRequest.Ptr, ppRequest)
    Close()
      => ComCall(5, this.p)
}
struct IMFHttpDownloadSessionProvider extends IUnknown {
    static IID := "{1B4CF4B9-3A16-4115-839D-03CC5C99DF01}"
    CreateHttpDownloadSession(wszScheme, ppDownloadSession)
      => ComCall(3, this.p, "Str", wszScheme, IMFHttpDownloadSession.Ptr, ppDownloadSession)
}
struct MF_VIDEO_SPHERICAL_VIEWDIRECTION {
    iHeading : Int32
    iPitch : Int32
    iRoll : Int32
}
struct IMFMediaSource2 extends IMFMediaSourceEx {
    static IID := "{FBB03414-D13B-4786-8319-5AC51FC0A136}"
    SetMediaType(dwStreamID, pMediaType)
      => ComCall(16, this.p, UInt32, dwStreamID, IMFMediaType, pMediaType)
}
struct IMFMediaStream2 extends IMFMediaStream {
    static IID := "{C5BC37D6-75C7-46A1-A132-81B5F723C20F}"
    SetStreamState(value)
      => ComCall(10, this.p, MF_STREAM_STATE, value)
    GetStreamState(value)
      => ComCall(11, this.p, MF_STREAM_STATE.Ptr, value)
}
struct MFSensorDeviceType extends Int32 {
    static MFSensorDeviceType_Unknown := 0
    static MFSensorDeviceType_Device := 1
    static MFSensorDeviceType_MediaSource := 2
    static MFSensorDeviceType_FrameProvider := 3
    static MFSensorDeviceType_SensorTransform := 4
}
struct MFSensorStreamType extends Int32 {
    static MFSensorStreamType_Unknown := 0
    static MFSensorStreamType_Input := 1
    static MFSensorStreamType_Output := 2
}
struct MFSensorDeviceMode extends Int32 {
    static MFSensorDeviceMode_Controller := 0
    static MFSensorDeviceMode_Shared := 1
}
struct IMFSensorDevice extends IUnknown {
    static IID := "{FB9F48F2-2A18-4E28-9730-786F30F04DC4}"
    GetDeviceId(pDeviceId)
      => ComCall(3, this.p, Int64.Ptr, pDeviceId)
    GetDeviceType(pType)
      => ComCall(4, this.p, MFSensorDeviceType.Ptr, pType)
    GetFlags(pFlags)
      => ComCall(5, this.p, Int64.Ptr, pFlags)
    GetSymbolicLink(SymbolicLink, pcchWritten)
      => ComCall(6, this.p, PWSTR, SymbolicLink, Int32, SymbolicLink.Length, Int32.Ptr, pcchWritten)
    GetDeviceAttributes(ppAttributes)
      => ComCall(7, this.p, IMFAttributes.Ptr, ppAttributes)
    GetStreamAttributesCount(eType, pdwCount)
      => ComCall(8, this.p, MFSensorStreamType, eType, UInt32.Ptr, pdwCount)
    GetStreamAttributes(eType, dwIndex, ppAttributes)
      => ComCall(9, this.p, MFSensorStreamType, eType, UInt32, dwIndex, IMFAttributes.Ptr, ppAttributes)
    SetSensorDeviceMode(eMode)
      => ComCall(10, this.p, MFSensorDeviceMode, eMode)
    GetSensorDeviceMode(peMode)
      => ComCall(11, this.p, MFSensorDeviceMode.Ptr, peMode)
}
struct IMFSensorGroup extends IUnknown {
    static IID := "{4110243A-9757-461F-89F1-F22345BCAB4E}"
    GetSymbolicLink(SymbolicLink, pcchWritten)
      => ComCall(3, this.p, PWSTR, SymbolicLink, Int32, SymbolicLink.Length, Int32.Ptr, pcchWritten)
    GetFlags(pFlags)
      => ComCall(4, this.p, Int64.Ptr, pFlags)
    GetSensorGroupAttributes(ppAttributes)
      => ComCall(5, this.p, IMFAttributes.Ptr, ppAttributes)
    GetSensorDeviceCount(pdwCount)
      => ComCall(6, this.p, UInt32.Ptr, pdwCount)
    GetSensorDevice(dwIndex, ppDevice)
      => ComCall(7, this.p, UInt32, dwIndex, IMFSensorDevice.Ptr, ppDevice)
    SetDefaultSensorDeviceIndex(dwIndex)
      => ComCall(8, this.p, UInt32, dwIndex)
    GetDefaultSensorDeviceIndex(pdwIndex)
      => ComCall(9, this.p, UInt32.Ptr, pdwIndex)
    CreateMediaSource(ppSource)
      => ComCall(10, this.p, IMFMediaSource.Ptr, ppSource)
}
struct IMFSensorStream extends IMFAttributes {
    static IID := "{E9A42171-C56E-498A-8B39-EDA5A070B7FC}"
    GetMediaTypeCount(pdwCount)
      => ComCall(33, this.p, UInt32.Ptr, pdwCount)
    GetMediaType(dwIndex, ppMediaType)
      => ComCall(34, this.p, UInt32, dwIndex, IMFMediaType.Ptr, ppMediaType)
    CloneSensorStream(ppStream)
      => ComCall(35, this.p, IMFSensorStream.Ptr, ppStream)
}
struct IMFSensorTransformFactory extends IUnknown {
    static IID := "{EED9C2EE-66B4-4F18-A697-AC7D3960215C}"
    GetFactoryAttributes(ppAttributes)
      => ComCall(3, this.p, IMFAttributes.Ptr, ppAttributes)
    InitializeFactory(dwMaxTransformCount, pSensorDevices, pAttributes?)
      => ComCall(4, this.p, UInt32, dwMaxTransformCount, IMFCollection, pSensorDevices, IMFAttributes, pAttributes?)
    GetTransformCount(pdwCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwCount)
    GetTransformInformation(TransformIndex, pguidTransformId, ppAttributes, ppStreamInformation)
      => ComCall(6, this.p, UInt32, TransformIndex, GUID.Ptr, pguidTransformId, IMFAttributes.Ptr, ppAttributes, IMFCollection.Ptr, ppStreamInformation)
    CreateTransform(guidSensorTransformID, pAttributes?, ppDeviceMFT)
      => ComCall(7, this.p, GUID.Ptr, guidSensorTransformID, IMFAttributes, pAttributes?, IMFDeviceTransform.Ptr, ppDeviceMFT)
}
struct SENSORPROFILEID {
    Type : GUID
    Index : UInt32
    Unused : UInt32
}
struct IMFSensorProfile extends IUnknown {
    static IID := "{22F765D1-8DAB-4107-846D-56BAF72215E7}"
    GetProfileId(pId)
      => ComCall(3, this.p, SENSORPROFILEID.Ptr, pId)
    AddProfileFilter(StreamId, wzFilterSetString)
      => ComCall(4, this.p, UInt32, StreamId, "Str", wzFilterSetString)
    IsMediaTypeSupported(StreamId, pMediaType, pfSupported)
      => ComCall(5, this.p, UInt32, StreamId, IMFMediaType, pMediaType, BOOL.Ptr, pfSupported)
    AddBlockedControl(wzBlockedControl)
      => ComCall(6, this.p, "Str", wzBlockedControl)
}
struct IMFSensorProfileCollection extends IUnknown {
    static IID := "{C95EA55B-0187-48BE-9353-8D2507662351}"
    GetProfileCount()
      => ComCall(3, this.p, UInt32)
    GetProfile(Index, ppProfile)
      => ComCall(4, this.p, UInt32, Index, IMFSensorProfile.Ptr, ppProfile)
    AddProfile(pProfile)
      => ComCall(5, this.p, IMFSensorProfile, pProfile)
    FindProfile(ProfileId, ppProfile)
      => ComCall(6, this.p, SENSORPROFILEID.Ptr, ProfileId, IMFSensorProfile.Ptr, ppProfile)
    RemoveProfileByIndex(Index)
      => ComCall(7, this.p, UInt32, Index, "void")
    RemoveProfile(ProfileId)
      => ComCall(8, this.p, SENSORPROFILEID.Ptr, ProfileId, "void")
}
struct IMFSensorProcessActivity extends IUnknown {
    static IID := "{39DC7F4A-B141-4719-813C-A7F46162A2B8}"
    GetProcessId(pPID)
      => ComCall(3, this.p, UInt32.Ptr, pPID)
    GetStreamingState(pfStreaming)
      => ComCall(4, this.p, BOOL.Ptr, pfStreaming)
    GetStreamingMode(pMode)
      => ComCall(5, this.p, MFSensorDeviceMode.Ptr, pMode)
    GetReportTime(pft)
      => ComCall(6, this.p, FILETIME.Ptr, pft)
}
struct IMFSensorActivityReport extends IUnknown {
    static IID := "{3E8C4BE1-A8C2-4528-90DE-2851BDE5FEAD}"
    GetFriendlyName(FriendlyName, pcchWritten)
      => ComCall(3, this.p, PWSTR, FriendlyName, UInt32, FriendlyName.Length, UInt32.Ptr, pcchWritten)
    GetSymbolicLink(SymbolicLink, pcchWritten)
      => ComCall(4, this.p, PWSTR, SymbolicLink, UInt32, SymbolicLink.Length, UInt32.Ptr, pcchWritten)
    GetProcessCount(pcCount)
      => ComCall(5, this.p, UInt32.Ptr, pcCount)
    GetProcessActivity(Index, ppProcessActivity)
      => ComCall(6, this.p, UInt32, Index, IMFSensorProcessActivity.Ptr, ppProcessActivity)
}
struct IMFSensorActivitiesReport extends IUnknown {
    static IID := "{683F7A5E-4A19-43CD-B1A9-DBF4AB3F7777}"
    GetCount(pcCount)
      => ComCall(3, this.p, UInt32.Ptr, pcCount)
    GetActivityReport(Index, sensorActivityReport)
      => ComCall(4, this.p, UInt32, Index, IMFSensorActivityReport.Ptr, sensorActivityReport)
    GetActivityReportByDeviceName(SymbolicName, sensorActivityReport)
      => ComCall(5, this.p, "Str", SymbolicName, IMFSensorActivityReport.Ptr, sensorActivityReport)
}
struct IMFSensorActivitiesReportCallback extends IUnknown {
    static IID := "{DE5072EE-DBE3-46DC-8A87-B6F631194751}"
    OnActivitiesReport(sensorActivitiesReport)
      => ComCall(3, this.p, IMFSensorActivitiesReport, sensorActivitiesReport)
}
struct IMFSensorActivityMonitor extends IUnknown {
    static IID := "{D0CEF145-B3F4-4340-A2E5-7A5080CA05CB}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
}
struct MFCameraIntrinsic_CameraModel {
    FocalLength_x : Float32
    FocalLength_y : Float32
    PrincipalPoint_x : Float32
    PrincipalPoint_y : Float32
}
struct MFCameraIntrinsic_DistortionModel6KT {
    Radial_k1 : Float32
    Radial_k2 : Float32
    Radial_k3 : Float32
    Radial_k4 : Float32
    Radial_k5 : Float32
    Radial_k6 : Float32
    Tangential_p1 : Float32
    Tangential_p2 : Float32
}
struct MFCameraIntrinsic_DistortionModelArcTan {
    Radial_k0 : Float32
    DistortionCenter_x : Float32
    DistortionCenter_y : Float32
    Tangential_x : Float32
    Tangential_y : Float32
}
struct MFCameraIntrinsic_DistortionModelType extends Int32 {
    static MFCameraIntrinsic_DistortionModelType_6KT := 0
    static MFCameraIntrinsic_DistortionModelType_ArcTan := 1
}
struct MFExtendedCameraIntrinsic_IntrinsicModel {
    Width : UInt32
    Height : UInt32
    SplitFrameId : UInt32
    CameraModel : MFCameraIntrinsic_CameraModel
}
struct IMFExtendedCameraIntrinsicModel extends IUnknown {
    static IID := "{5C595E64-4630-4231-855A-12842F733245}"
    GetModel(pIntrinsicModel)
      => ComCall(3, this.p, MFExtendedCameraIntrinsic_IntrinsicModel.Ptr, pIntrinsicModel)
    SetModel(pIntrinsicModel)
      => ComCall(4, this.p, MFExtendedCameraIntrinsic_IntrinsicModel.Ptr, pIntrinsicModel)
    GetDistortionModelType(pDistortionModelType)
      => ComCall(5, this.p, MFCameraIntrinsic_DistortionModelType.Ptr, pDistortionModelType)
}
struct IMFExtendedCameraIntrinsicsDistortionModel6KT extends IUnknown {
    static IID := "{74C2653B-5F55-4EB1-9F0F-18B8F68B7D3D}"
    GetDistortionModel(pDistortionModel)
      => ComCall(3, this.p, MFCameraIntrinsic_DistortionModel6KT.Ptr, pDistortionModel)
    SetDistortionModel(pDistortionModel)
      => ComCall(4, this.p, MFCameraIntrinsic_DistortionModel6KT.Ptr, pDistortionModel)
}
struct IMFExtendedCameraIntrinsicsDistortionModelArcTan extends IUnknown {
    static IID := "{812D5F95-B572-45DC-BAFC-AE24199DDDA8}"
    GetDistortionModel(pDistortionModel)
      => ComCall(3, this.p, MFCameraIntrinsic_DistortionModelArcTan.Ptr, pDistortionModel)
    SetDistortionModel(pDistortionModel)
      => ComCall(4, this.p, MFCameraIntrinsic_DistortionModelArcTan.Ptr, pDistortionModel)
}
struct IMFExtendedCameraIntrinsics extends IUnknown {
    static IID := "{687F6DAC-6987-4750-A16A-734D1E7A10FE}"
    InitializeFromBuffer(pbBuffer)
      => ComCall(3, this.p, UInt8.Ptr, pbBuffer, UInt32, pbBuffer.Size)
    GetBufferSize(pdwBufferSize)
      => ComCall(4, this.p, UInt32.Ptr, pdwBufferSize)
    SerializeToBuffer(pbBuffer, pdwBufferSize)
      => ComCall(5, this.p, UInt8.Ptr, pbBuffer, UInt32.Ptr, pdwBufferSize)
    GetIntrinsicModelCount(pdwCount)
      => ComCall(6, this.p, UInt32.Ptr, pdwCount)
    GetIntrinsicModelByIndex(dwIndex, ppIntrinsicModel)
      => ComCall(7, this.p, UInt32, dwIndex, IMFExtendedCameraIntrinsicModel.Ptr, ppIntrinsicModel)
    AddIntrinsicModel(pIntrinsicModel)
      => ComCall(8, this.p, IMFExtendedCameraIntrinsicModel, pIntrinsicModel)
}
struct IMFExtendedCameraControl extends IUnknown {
    static IID := "{38E33520-FCA1-4845-A27A-68B7C6AB3789}"
    GetCapabilities()
      => ComCall(3, this.p, Int64)
    SetFlags(ulFlags)
      => ComCall(4, this.p, Int64, ulFlags)
    GetFlags()
      => ComCall(5, this.p, Int64)
    LockPayload(ppPayload, pulPayload)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, ppPayload, UInt32.Ptr, pulPayload)
    UnlockPayload()
      => ComCall(7, this.p)
    CommitSettings()
      => ComCall(8, this.p)
}
struct IMFExtendedCameraController extends IUnknown {
    static IID := "{B91EBFEE-CA03-4AF4-8A82-A31752F4A0FC}"
    GetExtendedCameraControl(dwStreamIndex, ulPropertyId, ppControl)
      => ComCall(3, this.p, UInt32, dwStreamIndex, UInt32, ulPropertyId, IMFExtendedCameraControl.Ptr, ppControl)
}
struct IMFRelativePanelReport extends IUnknown {
    static IID := "{F25362EA-2C0E-447F-81E2-755914CDC0C3}"
    GetRelativePanel(panel)
      => ComCall(3, this.p, UInt32.Ptr, panel)
}
struct IMFRelativePanelWatcher extends IMFShutdown {
    static IID := "{421AF7F6-573E-4AD0-8FDA-2E57CEDB18C6}"
    BeginGetReport(pCallback, pState?)
      => ComCall(5, this.p, IMFAsyncCallback, pCallback, IUnknown, pState?)
    EndGetReport(pResult, ppRelativePanelReport)
      => ComCall(6, this.p, IMFAsyncResult, pResult, IMFRelativePanelReport.Ptr, ppRelativePanelReport)
    GetReport(ppRelativePanelReport)
      => ComCall(7, this.p, IMFRelativePanelReport.Ptr, ppRelativePanelReport)
}
struct IMFVideoCaptureSampleAllocator extends IMFVideoSampleAllocator {
    static IID := "{725B77C7-CA9F-4FE5-9D72-9946BF9B3C70}"
    InitializeCaptureSampleAllocator(cbSampleSize, cbCaptureMetadataSize, cbAlignment, cMinimumSamples, pAttributes?, pMediaType)
      => ComCall(7, this.p, UInt32, cbSampleSize, UInt32, cbCaptureMetadataSize, UInt32, cbAlignment, UInt32, cMinimumSamples, IMFAttributes, pAttributes?, IMFMediaType, pMediaType)
}
struct MFSampleAllocatorUsage extends Int32 {
    static MFSampleAllocatorUsage_UsesProvidedAllocator := 0
    static MFSampleAllocatorUsage_UsesCustomAllocator := 1
    static MFSampleAllocatorUsage_DoesNotAllocate := 2
}
struct IMFSampleAllocatorControl extends IUnknown {
    static IID := "{DA62B958-3A38-4A97-BD27-149C640C0771}"
    SetDefaultAllocator(dwOutputStreamID, pAllocator)
      => ComCall(3, this.p, UInt32, dwOutputStreamID, IUnknown, pAllocator)
    GetAllocatorUsage(dwOutputStreamID, pdwInputStreamID, peUsage)
      => ComCall(4, this.p, UInt32, dwOutputStreamID, UInt32.Ptr, pdwInputStreamID, MFSampleAllocatorUsage.Ptr, peUsage)
}
struct MFCameraOcclusionState extends Int32 {
    static MFCameraOcclusionState_Open := 0
    static MFCameraOcclusionState_OccludedByLid := 1
    static MFCameraOcclusionState_OccludedByCameraHardware := 2
}
struct IMFCameraOcclusionStateReport extends IUnknown {
    static IID := "{1640B2CF-74DA-4462-A43B-B76D3BDC1434}"
    GetOcclusionState(occlusionState)
      => ComCall(3, this.p, UInt32.Ptr, occlusionState)
}
struct IMFCameraOcclusionStateReportCallback extends IUnknown {
    static IID := "{6E5841C7-3889-4019-9035-783FB19B5948}"
    OnOcclusionStateReport(occlusionStateReport)
      => ComCall(3, this.p, IMFCameraOcclusionStateReport, occlusionStateReport)
}
struct IMFCameraOcclusionStateMonitor extends IUnknown {
    static IID := "{CC692F46-C697-47E2-A72D-7B064617749B}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
    GetSupportedStates()
      => ComCall(5, this.p, UInt32)
}
struct IMFCameraControlNotify extends IUnknown {
    static IID := "{E8F2540D-558A-4449-8B64-4863467A9FE8}"
    OnChange(controlSet, id)
      => ComCall(3, this.p, GUID.Ptr, controlSet, UInt32, id, "void")
    OnError(hrStatus)
      => ComCall(4, this.p, HRESULT, hrStatus, "void")
}
struct IMFCameraControlMonitor extends IUnknown {
    static IID := "{4D46F2C9-28BA-4970-8C7B-1F0C9D80AF69}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
    AddControlSubscription(controlSet, id)
      => ComCall(5, this.p, GUID, controlSet, UInt32, id)
    RemoveControlSubscription(controlSet, id)
      => ComCall(6, this.p, GUID, controlSet, UInt32, id)
    Shutdown()
      => ComCall(7, this.p, "void")
}
struct MF_CAMERA_CONTROL_CONFIGURATION_TYPE extends Int32 {
    static MF_CAMERA_CONTROL_CONFIGURATION_TYPE_PRESTART := 0
    static MF_CAMERA_CONTROL_CONFIGURATION_TYPE_POSTSTART := 1
}
struct MF_CAMERA_CONTROL_RANGE_INFO {
    minValue : Int32
    maxValue : Int32
    stepValue : Int32
    defaultValue : Int32
}
struct IMFCameraControlDefaults extends IUnknown {
    static IID := "{75510662-B034-48F4-88A7-8DE61DAA4AF9}"
    GetType()
      => ComCall(3, this.p, MF_CAMERA_CONTROL_CONFIGURATION_TYPE)
    GetRangeInfo(rangeInfo)
      => ComCall(4, this.p, MF_CAMERA_CONTROL_RANGE_INFO.Ptr, rangeInfo)
    LockControlData(control, controlSize, data?, dataSize?)
      => ComCall(5, this.p, Struct.Ptr.Ptr, control, UInt32.Ptr, controlSize, Struct.Ptr.Ptr, data?, UInt32.Ptr, dataSize?)
    UnlockControlData()
      => ComCall(6, this.p)
}
struct IMFCameraControlDefaultsCollection extends IMFAttributes {
    static IID := "{92D43D0F-54A8-4BAE-96DA-356D259A5C26}"
    GetControlCount()
      => ComCall(33, this.p, UInt32)
    GetControl(index, configuration)
      => ComCall(34, this.p, UInt32, index, IMFCameraControlDefaults.Ptr, configuration)
    GetOrAddExtendedControl(configType, constrolId, streamId, dataSize, defaults)
      => ComCall(35, this.p, MF_CAMERA_CONTROL_CONFIGURATION_TYPE, configType, UInt32, constrolId, UInt32, streamId, UInt32, dataSize, IMFCameraControlDefaults.Ptr, defaults)
    GetOrAddControl(configType, controlSet, constrolId, controlSize, dataSize, defaults)
      => ComCall(36, this.p, MF_CAMERA_CONTROL_CONFIGURATION_TYPE, configType, GUID.Ptr, controlSet, UInt32, constrolId, UInt32, controlSize, UInt32, dataSize, IMFCameraControlDefaults.Ptr, defaults)
    RemoveControl(controlSet, constrolId)
      => ComCall(37, this.p, GUID.Ptr, controlSet, UInt32, constrolId)
    RemoveAllControls()
      => ComCall(38, this.p)
}
struct IMFCameraConfigurationManager extends IUnknown {
    static IID := "{A624F617-4704-4206-8A6D-EBDA4A093985}"
    LoadDefaults(cameraAttributes, configurations)
      => ComCall(3, this.p, IMFAttributes, cameraAttributes, IMFCameraControlDefaultsCollection.Ptr, configurations)
    SaveDefaults(configurations)
      => ComCall(4, this.p, IMFCameraControlDefaultsCollection, configurations)
    Shutdown()
      => ComCall(5, this.p, "void")
}
struct DetectedFaceBound {
    sizeInBytes : UInt32
    normalizedXPosition : Float32
    normalizedYPosition : Float32
    normalizedWidth : Float32
    normalizedHeight : Float32
    confidenceValue : Int32
    flags : Int64
}
struct IMFFaceDetectionTransformCallback extends IUnknown {
    static IID := "{0BFD1ADE-0421-4909-ACB7-7A7125416881}"
    OnFaceDetectionResult(detectedFaceBounds)
      => ComCall(3, this.p, UInt32, detectedFaceBounds.Length, DetectedFaceBound.Ptr, detectedFaceBounds, "void")
}
struct IMFFaceDetectionTransform extends IUnknown {
    static IID := "{DDD59578-D0E7-46E2-BE8C-1CE76AD147C0}"
    SetDetectionCallback(callback, callbackToken)
      => ComCall(3, this.p, IMFFaceDetectionTransformCallback, callback, Struct.Ptr.Ptr, callbackToken)
    ClearDetectionCallback(callbackToken)
      => ComCall(4, this.p, Struct.Ptr, callbackToken)
}
struct IMFASFContentInfo extends IUnknown {
    static IID := "{B1DCA5CD-D5DA-4451-8E9E-DB5C59914EAD}"
    GetHeaderSize(pIStartOfContent, cbHeaderSize)
      => ComCall(3, this.p, IMFMediaBuffer, pIStartOfContent, Int64.Ptr, cbHeaderSize)
    ParseHeader(pIHeaderBuffer, cbOffsetWithinHeader)
      => ComCall(4, this.p, IMFMediaBuffer, pIHeaderBuffer, Int64, cbOffsetWithinHeader)
    GenerateHeader(pIHeader, pcbHeader)
      => ComCall(5, this.p, IMFMediaBuffer, pIHeader, UInt32.Ptr, pcbHeader)
    GetProfile(ppIProfile)
      => ComCall(6, this.p, IMFASFProfile.Ptr, ppIProfile)
    SetProfile(pIProfile)
      => ComCall(7, this.p, IMFASFProfile, pIProfile)
    GeneratePresentationDescriptor(ppIPresentationDescriptor)
      => ComCall(8, this.p, IMFPresentationDescriptor.Ptr, ppIPresentationDescriptor)
    GetEncodingConfigurationPropertyStore(wStreamNumber, ppIStore)
      => ComCall(9, this.p, UInt16, wStreamNumber, IPropertyStore.Ptr, ppIStore)
}
struct IMFASFProfile extends IMFAttributes {
    static IID := "{D267BF6A-028B-4E0D-903D-43F0EF82D0D4}"
    GetStreamCount(pcStreams)
      => ComCall(33, this.p, UInt32.Ptr, pcStreams)
    GetStream(dwStreamIndex, pwStreamNumber, ppIStream)
      => ComCall(34, this.p, UInt32, dwStreamIndex, UInt16.Ptr, pwStreamNumber, IMFASFStreamConfig.Ptr, ppIStream)
    GetStreamByNumber(wStreamNumber, ppIStream)
      => ComCall(35, this.p, UInt16, wStreamNumber, IMFASFStreamConfig.Ptr, ppIStream)
    SetStream(pIStream)
      => ComCall(36, this.p, IMFASFStreamConfig, pIStream)
    RemoveStream(wStreamNumber)
      => ComCall(37, this.p, UInt16, wStreamNumber)
    CreateStream(pIMediaType, ppIStream)
      => ComCall(38, this.p, IMFMediaType, pIMediaType, IMFASFStreamConfig.Ptr, ppIStream)
    GetMutualExclusionCount(pcMutexs)
      => ComCall(39, this.p, UInt32.Ptr, pcMutexs)
    GetMutualExclusion(dwMutexIndex, ppIMutex)
      => ComCall(40, this.p, UInt32, dwMutexIndex, IMFASFMutualExclusion.Ptr, ppIMutex)
    AddMutualExclusion(pIMutex)
      => ComCall(41, this.p, IMFASFMutualExclusion, pIMutex)
    RemoveMutualExclusion(dwMutexIndex)
      => ComCall(42, this.p, UInt32, dwMutexIndex)
    CreateMutualExclusion(ppIMutex)
      => ComCall(43, this.p, IMFASFMutualExclusion.Ptr, ppIMutex)
    GetStreamPrioritization(ppIStreamPrioritization)
      => ComCall(44, this.p, IMFASFStreamPrioritization.Ptr, ppIStreamPrioritization)
    AddStreamPrioritization(pIStreamPrioritization)
      => ComCall(45, this.p, IMFASFStreamPrioritization, pIStreamPrioritization)
    RemoveStreamPrioritization()
      => ComCall(46, this.p)
    CreateStreamPrioritization(ppIStreamPrioritization)
      => ComCall(47, this.p, IMFASFStreamPrioritization.Ptr, ppIStreamPrioritization)
    Clone(ppIProfile)
      => ComCall(48, this.p, IMFASFProfile.Ptr, ppIProfile)
}
struct IMFASFStreamConfig extends IMFAttributes {
    static IID := "{9E8AE8D2-DBBD-4200-9ACA-06E6DF484913}"
    GetStreamType(pguidStreamType)
      => ComCall(33, this.p, GUID.Ptr, pguidStreamType)
    GetStreamNumber()
      => ComCall(34, this.p, UInt16)
    SetStreamNumber(wStreamNum)
      => ComCall(35, this.p, UInt16, wStreamNum)
    GetMediaType(ppIMediaType)
      => ComCall(36, this.p, IMFMediaType.Ptr, ppIMediaType)
    SetMediaType(pIMediaType)
      => ComCall(37, this.p, IMFMediaType, pIMediaType)
    GetPayloadExtensionCount(pcPayloadExtensions)
      => ComCall(38, this.p, UInt16.Ptr, pcPayloadExtensions)
    GetPayloadExtension(wPayloadExtensionNumber, pguidExtensionSystemID, pcbExtensionDataSize, pbExtensionSystemInfo, pcbExtensionSystemInfo)
      => ComCall(39, this.p, UInt16, wPayloadExtensionNumber, GUID.Ptr, pguidExtensionSystemID, UInt16.Ptr, pcbExtensionDataSize, UInt8.Ptr, pbExtensionSystemInfo, UInt32.Ptr, pcbExtensionSystemInfo)
    AddPayloadExtension(guidExtensionSystemID, cbExtensionDataSize, pbExtensionSystemInfo)
      => ComCall(40, this.p, GUID, guidExtensionSystemID, UInt16, cbExtensionDataSize, UInt8.Ptr, pbExtensionSystemInfo, UInt32, pbExtensionSystemInfo.Length)
    RemoveAllPayloadExtensions()
      => ComCall(41, this.p)
    Clone(ppIStreamConfig)
      => ComCall(42, this.p, IMFASFStreamConfig.Ptr, ppIStreamConfig)
}
struct IMFASFMutualExclusion extends IUnknown {
    static IID := "{12558291-E399-11D5-BC2A-00B0D0F3F4AB}"
    GetType(pguidType)
      => ComCall(3, this.p, GUID.Ptr, pguidType)
    SetType(guidType)
      => ComCall(4, this.p, GUID.Ptr, guidType)
    GetRecordCount(pdwRecordCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwRecordCount)
    GetStreamsForRecord(dwRecordNumber, pwStreamNumArray, pcStreams)
      => ComCall(6, this.p, UInt32, dwRecordNumber, UInt16.Ptr, pwStreamNumArray, UInt32.Ptr, pcStreams)
    AddStreamForRecord(dwRecordNumber, wStreamNumber)
      => ComCall(7, this.p, UInt32, dwRecordNumber, UInt16, wStreamNumber)
    RemoveStreamFromRecord(dwRecordNumber, wStreamNumber)
      => ComCall(8, this.p, UInt32, dwRecordNumber, UInt16, wStreamNumber)
    RemoveRecord(dwRecordNumber)
      => ComCall(9, this.p, UInt32, dwRecordNumber)
    AddRecord(pdwRecordNumber)
      => ComCall(10, this.p, UInt32.Ptr, pdwRecordNumber)
    Clone(ppIMutex)
      => ComCall(11, this.p, IMFASFMutualExclusion.Ptr, ppIMutex)
}
struct IMFASFStreamPrioritization extends IUnknown {
    static IID := "{699BDC27-BBAF-49FF-8E38-9C39C9B5E088}"
    GetStreamCount(pdwStreamCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwStreamCount)
    GetStream(dwStreamIndex, pwStreamNumber, pwStreamFlags)
      => ComCall(4, this.p, UInt32, dwStreamIndex, UInt16.Ptr, pwStreamNumber, UInt16.Ptr, pwStreamFlags)
    AddStream(wStreamNumber, wStreamFlags)
      => ComCall(5, this.p, UInt16, wStreamNumber, UInt16, wStreamFlags)
    RemoveStream(dwStreamIndex)
      => ComCall(6, this.p, UInt32, dwStreamIndex)
    Clone(ppIStreamPrioritization)
      => ComCall(7, this.p, IMFASFStreamPrioritization.Ptr, ppIStreamPrioritization)
}
struct MFASF_INDEXER_FLAGS extends Int32 {
    static MFASF_INDEXER_WRITE_NEW_INDEX := 1
    static MFASF_INDEXER_READ_FOR_REVERSEPLAYBACK := 2
    static MFASF_INDEXER_WRITE_FOR_LIVEREAD := 4
}
struct ASF_INDEX_IDENTIFIER {
    guidIndexType : GUID
    wStreamNumber : UInt16
}
struct ASF_INDEX_DESCRIPTOR {
    Identifier : ASF_INDEX_IDENTIFIER
    cPerEntryBytes : UInt16
    szDescription : UInt16[32]
    dwInterval : UInt32
}
struct IMFASFIndexer extends IUnknown {
    static IID := "{53590F48-DC3B-4297-813F-787761AD7B3E}"
    SetFlags(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
    GetFlags(pdwFlags)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags)
    Initialize(pIContentInfo)
      => ComCall(5, this.p, IMFASFContentInfo, pIContentInfo)
    GetIndexPosition(pIContentInfo, pcbIndexOffset)
      => ComCall(6, this.p, IMFASFContentInfo, pIContentInfo, Int64.Ptr, pcbIndexOffset)
    SetIndexByteStreams(ppIByteStreams, cByteStreams)
      => ComCall(7, this.p, IMFByteStream.Ptr, ppIByteStreams, UInt32, cByteStreams)
    GetIndexByteStreamCount(pcByteStreams)
      => ComCall(8, this.p, UInt32.Ptr, pcByteStreams)
    GetIndexStatus(pIndexIdentifier, pfIsIndexed, pbIndexDescriptor, pcbIndexDescriptor)
      => ComCall(9, this.p, ASF_INDEX_IDENTIFIER.Ptr, pIndexIdentifier, BOOL.Ptr, pfIsIndexed, UInt8.Ptr, pbIndexDescriptor, UInt32.Ptr, pcbIndexDescriptor)
    SetIndexStatus(pbIndexDescriptor, cbIndexDescriptor, fGenerateIndex)
      => ComCall(10, this.p, UInt8.Ptr, pbIndexDescriptor, UInt32, cbIndexDescriptor, BOOL, fGenerateIndex)
    GetSeekPositionForValue(pvarValue, pIndexIdentifier, pcbOffsetWithinData, phnsApproxTime, pdwPayloadNumberOfStreamWithinPacket)
      => ComCall(11, this.p, PROPVARIANT.Ptr, pvarValue, ASF_INDEX_IDENTIFIER.Ptr, pIndexIdentifier, Int64.Ptr, pcbOffsetWithinData, Int64.Ptr, phnsApproxTime, UInt32.Ptr, pdwPayloadNumberOfStreamWithinPacket)
    GenerateIndexEntries(pIASFPacketSample)
      => ComCall(12, this.p, IMFSample, pIASFPacketSample)
    CommitIndex(pIContentInfo)
      => ComCall(13, this.p, IMFASFContentInfo, pIContentInfo)
    GetIndexWriteSpace(pcbIndexWriteSpace)
      => ComCall(14, this.p, Int64.Ptr, pcbIndexWriteSpace)
    GetCompletedIndex(pIIndexBuffer, cbOffsetWithinIndex)
      => ComCall(15, this.p, IMFMediaBuffer, pIIndexBuffer, Int64, cbOffsetWithinIndex)
}
struct IMFASFSplitter extends IUnknown {
    static IID := "{12558295-E399-11D5-BC2A-00B0D0F3F4AB}"
    Initialize(pIContentInfo)
      => ComCall(3, this.p, IMFASFContentInfo, pIContentInfo)
    SetFlags(dwFlags)
      => ComCall(4, this.p, UInt32, dwFlags)
    GetFlags(pdwFlags)
      => ComCall(5, this.p, UInt32.Ptr, pdwFlags)
    SelectStreams(pwStreamNumbers, wNumStreams)
      => ComCall(6, this.p, UInt16.Ptr, pwStreamNumbers, UInt16, wNumStreams)
    GetSelectedStreams(pwStreamNumbers, pwNumStreams)
      => ComCall(7, this.p, UInt16.Ptr, pwStreamNumbers, UInt16.Ptr, pwNumStreams)
    ParseData(pIBuffer, cbBufferOffset, cbLength)
      => ComCall(8, this.p, IMFMediaBuffer, pIBuffer, UInt32, cbBufferOffset, UInt32, cbLength)
    GetNextSample(pdwStatusFlags, pwStreamNumber, ppISample)
      => ComCall(9, this.p, ASF_STATUSFLAGS.Ptr, pdwStatusFlags, UInt16.Ptr, pwStreamNumber, IMFSample.Ptr, ppISample)
    Flush()
      => ComCall(10, this.p)
    GetLastSendTime(pdwLastSendTime)
      => ComCall(11, this.p, UInt32.Ptr, pdwLastSendTime)
}
struct MFASF_SPLITTERFLAGS extends Int32 {
    static MFASF_SPLITTER_REVERSE := 1
    static MFASF_SPLITTER_WMDRM := 2
}
struct ASF_STATUSFLAGS extends Int32 {
    static ASF_STATUSFLAGS_INCOMPLETE := 1
    static ASF_STATUSFLAGS_NONFATAL_ERROR := 2
}
struct MFASF_MULTIPLEXERFLAGS extends Int32 {
    static MFASF_MULTIPLEXER_AUTOADJUST_BITRATE := 1
}
struct ASF_MUX_STATISTICS {
    cFramesWritten : UInt32
    cFramesDropped : UInt32
}
struct IMFASFMultiplexer extends IUnknown {
    static IID := "{57BDD80A-9B38-4838-B737-C58F670D7D4F}"
    Initialize(pIContentInfo)
      => ComCall(3, this.p, IMFASFContentInfo, pIContentInfo)
    SetFlags(dwFlags)
      => ComCall(4, this.p, UInt32, dwFlags)
    GetFlags(pdwFlags)
      => ComCall(5, this.p, UInt32.Ptr, pdwFlags)
    ProcessSample(wStreamNumber, pISample, hnsTimestampAdjust)
      => ComCall(6, this.p, UInt16, wStreamNumber, IMFSample, pISample, Int64, hnsTimestampAdjust)
    GetNextPacket(pdwStatusFlags, ppIPacket)
      => ComCall(7, this.p, UInt32.Ptr, pdwStatusFlags, IMFSample.Ptr, ppIPacket)
    Flush()
      => ComCall(8, this.p)
    End(pIContentInfo)
      => ComCall(9, this.p, IMFASFContentInfo, pIContentInfo)
    GetStatistics(wStreamNumber, pMuxStats)
      => ComCall(10, this.p, UInt16, wStreamNumber, ASF_MUX_STATISTICS.Ptr, pMuxStats)
    SetSyncTolerance(msSyncTolerance)
      => ComCall(11, this.p, UInt32, msSyncTolerance)
}
struct MFASF_STREAMSELECTOR_FLAGS extends Int32 {
    static MFASF_STREAMSELECTOR_DISABLE_THINNING := 1
    static MFASF_STREAMSELECTOR_USE_AVERAGE_BITRATE := 2
}
struct ASF_SELECTION_STATUS extends Int32 {
    static ASF_STATUS_NOTSELECTED := 0
    static ASF_STATUS_CLEANPOINTSONLY := 1
    static ASF_STATUS_ALLDATAUNITS := 2
}
struct IMFASFStreamSelector extends IUnknown {
    static IID := "{D01BAD4A-4FA0-4A60-9349-C27E62DA9D41}"
    GetStreamCount(pcStreams)
      => ComCall(3, this.p, UInt32.Ptr, pcStreams)
    GetOutputCount(pcOutputs)
      => ComCall(4, this.p, UInt32.Ptr, pcOutputs)
    GetOutputStreamCount(dwOutputNum, pcStreams)
      => ComCall(5, this.p, UInt32, dwOutputNum, UInt32.Ptr, pcStreams)
    GetOutputStreamNumbers(dwOutputNum, rgwStreamNumbers)
      => ComCall(6, this.p, UInt32, dwOutputNum, UInt16.Ptr, rgwStreamNumbers)
    GetOutputFromStream(wStreamNum, pdwOutput)
      => ComCall(7, this.p, UInt16, wStreamNum, UInt32.Ptr, pdwOutput)
    GetOutputOverride(dwOutputNum, pSelection)
      => ComCall(8, this.p, UInt32, dwOutputNum, ASF_SELECTION_STATUS.Ptr, pSelection)
    SetOutputOverride(dwOutputNum, Selection)
      => ComCall(9, this.p, UInt32, dwOutputNum, ASF_SELECTION_STATUS, Selection)
    GetOutputMutexCount(dwOutputNum, pcMutexes)
      => ComCall(10, this.p, UInt32, dwOutputNum, UInt32.Ptr, pcMutexes)
    GetOutputMutex(dwOutputNum, dwMutexNum, ppMutex)
      => ComCall(11, this.p, UInt32, dwOutputNum, UInt32, dwMutexNum, IUnknown.Ptr, ppMutex)
    SetOutputMutexSelection(dwOutputNum, dwMutexNum, wSelectedRecord)
      => ComCall(12, this.p, UInt32, dwOutputNum, UInt32, dwMutexNum, UInt16, wSelectedRecord)
    GetBandwidthStepCount(pcStepCount)
      => ComCall(13, this.p, UInt32.Ptr, pcStepCount)
    GetBandwidthStep(dwStepNum, pdwBitrate, rgwStreamNumbers, rgSelections)
      => ComCall(14, this.p, UInt32, dwStepNum, UInt32.Ptr, pdwBitrate, UInt16.Ptr, rgwStreamNumbers, ASF_SELECTION_STATUS.Ptr, rgSelections)
    BitrateToStepNumber(dwBitrate, pdwStepNum)
      => ComCall(15, this.p, UInt32, dwBitrate, UInt32.Ptr, pdwStepNum)
    SetStreamSelectorFlags(dwStreamSelectorFlags)
      => ComCall(16, this.p, UInt32, dwStreamSelectorFlags)
}
struct MFSINK_WMDRMACTION extends Int32 {
    static MFSINK_WMDRMACTION_UNDEFINED := 0
    static MFSINK_WMDRMACTION_ENCODE := 1
    static MFSINK_WMDRMACTION_TRANSCODE := 2
    static MFSINK_WMDRMACTION_TRANSCRYPT := 3
    static MFSINK_WMDRMACTION_LAST := 3
}
struct IMFDRMNetHelper extends IUnknown {
    static IID := "{3D1FF0EA-679A-4190-8D46-7FA69E8C7E15}"
    ProcessLicenseRequest(pLicenseRequest, ppLicenseResponse, pbstrKID)
      => ComCall(3, this.p, UInt8.Ptr, pLicenseRequest, UInt32, pLicenseRequest.Length, UInt8.Ptr.Ptr, ppLicenseResponse, UInt32.Ptr, ppLicenseResponse.Length, BSTR.Ptr, pbstrKID)
    GetChainedLicenseResponse(ppLicenseResponse)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, ppLicenseResponse, UInt32.Ptr, ppLicenseResponse.Length)
}
struct MF_CAPTURE_ENGINE_DEVICE_TYPE extends Int32 {
    static MF_CAPTURE_ENGINE_DEVICE_TYPE_AUDIO := 0
    static MF_CAPTURE_ENGINE_DEVICE_TYPE_VIDEO := 1
}
struct MF_CAPTURE_ENGINE_SINK_TYPE extends Int32 {
    static MF_CAPTURE_ENGINE_SINK_TYPE_RECORD := 0
    static MF_CAPTURE_ENGINE_SINK_TYPE_PREVIEW := 1
    static MF_CAPTURE_ENGINE_SINK_TYPE_PHOTO := 2
}
struct MF_CAPTURE_ENGINE_SOURCE extends UInt32 {
    static MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_PREVIEW := 4294967290
    static MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_RECORD := 4294967289
    static MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_PHOTO := 4294967288
    static MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_AUDIO := 4294967287
    static MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_METADATA := 4294967286
    static MF_CAPTURE_ENGINE_MEDIASOURCE := 4294967295
}
struct MF_CAPTURE_ENGINE_STREAM_CATEGORY extends Int32 {
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_PREVIEW := 0
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_CAPTURE := 1
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_INDEPENDENT := 2
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_DEPENDENT := 3
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_AUDIO := 4
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_UNSUPPORTED := 5
    static MF_CAPTURE_ENGINE_STREAM_CATEGORY_METADATA := 6
}
struct MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE extends Int32 {
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_OTHER := 0
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_COMMUNICATIONS := 1
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_MEDIA := 2
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_GAMECHAT := 3
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_SPEECH := 4
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_FARFIELDSPEECH := 5
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_UNIFORMSPEECH := 6
    static MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_VOICETYPING := 7
}
struct MF_CAPTURE_ENGINE_AUDIO_PROCESSING_MODE extends Int32 {
    static MF_CAPTURE_ENGINE_AUDIO_PROCESSING_DEFAULT := 0
    static MF_CAPTURE_ENGINE_AUDIO_PROCESSING_RAW := 1
}
struct IMFCaptureEngineOnEventCallback extends IUnknown {
    static IID := "{AEDA51C0-9025-4983-9012-DE597B88B089}"
    OnEvent(pEvent)
      => ComCall(3, this.p, IMFMediaEvent, pEvent)
}
struct IMFCaptureEngineOnSampleCallback extends IUnknown {
    static IID := "{52150B82-AB39-4467-980F-E48BF0822ECD}"
    OnSample(pSample?)
      => ComCall(3, this.p, IMFSample, pSample?)
}
struct IMFCaptureSink extends IUnknown {
    static IID := "{72D6135B-35E9-412C-B926-FD5265F2A885}"
    GetOutputMediaType(dwSinkStreamIndex, ppMediaType?)
      => ComCall(3, this.p, UInt32, dwSinkStreamIndex, IMFMediaType.Ptr, ppMediaType?)
    GetService(dwSinkStreamIndex, rguidService, riid, ppUnknown?)
      => ComCall(4, this.p, UInt32, dwSinkStreamIndex, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppUnknown?)
    AddStream(dwSourceStreamIndex, pMediaType, pAttributes?, pdwSinkStreamIndex?)
      => ComCall(5, this.p, UInt32, dwSourceStreamIndex, IMFMediaType, pMediaType, IMFAttributes, pAttributes?, UInt32.Ptr, pdwSinkStreamIndex?)
    Prepare()
      => ComCall(6, this.p)
    RemoveAllStreams()
      => ComCall(7, this.p)
}
struct IMFCaptureRecordSink extends IMFCaptureSink {
    static IID := "{3323B55A-F92A-4FE2-8EDC-E9BFC0634D77}"
    SetOutputByteStream(pByteStream, guidContainerType)
      => ComCall(8, this.p, IMFByteStream, pByteStream, GUID.Ptr, guidContainerType)
    SetOutputFileName(fileName)
      => ComCall(9, this.p, "Str", fileName)
    SetSampleCallback(dwStreamSinkIndex, pCallback)
      => ComCall(10, this.p, UInt32, dwStreamSinkIndex, IMFCaptureEngineOnSampleCallback, pCallback)
    SetCustomSink(pMediaSink)
      => ComCall(11, this.p, IMFMediaSink, pMediaSink)
    GetRotation(dwStreamIndex, pdwRotationValue)
      => ComCall(12, this.p, UInt32, dwStreamIndex, UInt32.Ptr, pdwRotationValue)
    SetRotation(dwStreamIndex, dwRotationValue)
      => ComCall(13, this.p, UInt32, dwStreamIndex, UInt32, dwRotationValue)
}
struct IMFCapturePreviewSink extends IMFCaptureSink {
    static IID := "{77346CFD-5B49-4D73-ACE0-5B52A859F2E0}"
    SetRenderHandle(handle1)
      => ComCall(8, this.p, HANDLE, handle1)
    SetRenderSurface(pSurface)
      => ComCall(9, this.p, IUnknown, pSurface)
    UpdateVideo(pSrc?, pDst?, pBorderClr?)
      => ComCall(10, this.p, MFVideoNormalizedRect.Ptr, pSrc?, RECT.Ptr, pDst?, COLORREF.Ptr, pBorderClr?)
    SetSampleCallback(dwStreamSinkIndex, pCallback)
      => ComCall(11, this.p, UInt32, dwStreamSinkIndex, IMFCaptureEngineOnSampleCallback, pCallback)
    GetMirrorState(pfMirrorState)
      => ComCall(12, this.p, BOOL.Ptr, pfMirrorState)
    SetMirrorState(fMirrorState)
      => ComCall(13, this.p, BOOL, fMirrorState)
    GetRotation(dwStreamIndex, pdwRotationValue)
      => ComCall(14, this.p, UInt32, dwStreamIndex, UInt32.Ptr, pdwRotationValue)
    SetRotation(dwStreamIndex, dwRotationValue)
      => ComCall(15, this.p, UInt32, dwStreamIndex, UInt32, dwRotationValue)
    SetCustomSink(pMediaSink)
      => ComCall(16, this.p, IMFMediaSink, pMediaSink)
}
struct IMFCapturePhotoSink extends IMFCaptureSink {
    static IID := "{D2D43CC8-48BB-4AA7-95DB-10C06977E777}"
    SetOutputFileName(fileName)
      => ComCall(8, this.p, "Str", fileName)
    SetSampleCallback(pCallback)
      => ComCall(9, this.p, IMFCaptureEngineOnSampleCallback, pCallback)
    SetOutputByteStream(pByteStream)
      => ComCall(10, this.p, IMFByteStream, pByteStream)
}
struct IMFCaptureSource extends IUnknown {
    static IID := "{439A42A8-0D2C-4505-BE83-F79B2A05D5C4}"
    GetCaptureDeviceSource(mfCaptureEngineDeviceType, ppMediaSource?)
      => ComCall(3, this.p, MF_CAPTURE_ENGINE_DEVICE_TYPE, mfCaptureEngineDeviceType, IMFMediaSource.Ptr, ppMediaSource?)
    GetCaptureDeviceActivate(mfCaptureEngineDeviceType, ppActivate?)
      => ComCall(4, this.p, MF_CAPTURE_ENGINE_DEVICE_TYPE, mfCaptureEngineDeviceType, IMFActivate.Ptr, ppActivate?)
    GetService(rguidService, riid, ppUnknown?)
      => ComCall(5, this.p, GUID.Ptr, rguidService, GUID.Ptr, riid, IUnknown.Ptr, ppUnknown?)
    AddEffect(dwSourceStreamIndex, pUnknown)
      => ComCall(6, this.p, UInt32, dwSourceStreamIndex, IUnknown, pUnknown)
    RemoveEffect(dwSourceStreamIndex, pUnknown)
      => ComCall(7, this.p, UInt32, dwSourceStreamIndex, IUnknown, pUnknown)
    RemoveAllEffects(dwSourceStreamIndex)
      => ComCall(8, this.p, UInt32, dwSourceStreamIndex)
    GetAvailableDeviceMediaType(dwSourceStreamIndex, dwMediaTypeIndex, ppMediaType?)
      => ComCall(9, this.p, UInt32, dwSourceStreamIndex, UInt32, dwMediaTypeIndex, IMFMediaType.Ptr, ppMediaType?)
    SetCurrentDeviceMediaType(dwSourceStreamIndex, pMediaType)
      => ComCall(10, this.p, UInt32, dwSourceStreamIndex, IMFMediaType, pMediaType)
    GetCurrentDeviceMediaType(dwSourceStreamIndex, ppMediaType)
      => ComCall(11, this.p, UInt32, dwSourceStreamIndex, IMFMediaType.Ptr, ppMediaType)
    GetDeviceStreamCount(pdwStreamCount)
      => ComCall(12, this.p, UInt32.Ptr, pdwStreamCount)
    GetDeviceStreamCategory(dwSourceStreamIndex, pStreamCategory)
      => ComCall(13, this.p, UInt32, dwSourceStreamIndex, MF_CAPTURE_ENGINE_STREAM_CATEGORY.Ptr, pStreamCategory)
    GetMirrorState(dwStreamIndex, pfMirrorState)
      => ComCall(14, this.p, UInt32, dwStreamIndex, BOOL.Ptr, pfMirrorState)
    SetMirrorState(dwStreamIndex, fMirrorState)
      => ComCall(15, this.p, UInt32, dwStreamIndex, BOOL, fMirrorState)
    GetStreamIndexFromFriendlyName(uifriendlyName, pdwActualStreamIndex)
      => ComCall(16, this.p, UInt32, uifriendlyName, UInt32.Ptr, pdwActualStreamIndex)
}
struct IMFCaptureEngine extends IUnknown {
    static IID := "{A6BBA433-176B-48B2-B375-53AA03473207}"
    Initialize(pEventCallback, pAttributes?, pAudioSource?, pVideoSource?)
      => ComCall(3, this.p, IMFCaptureEngineOnEventCallback, pEventCallback, IMFAttributes, pAttributes?, IUnknown, pAudioSource?, IUnknown, pVideoSource?)
    StartPreview()
      => ComCall(4, this.p)
    StopPreview()
      => ComCall(5, this.p)
    StartRecord()
      => ComCall(6, this.p)
    StopRecord(bFinalize, bFlushUnprocessedSamples)
      => ComCall(7, this.p, BOOL, bFinalize, BOOL, bFlushUnprocessedSamples)
    TakePhoto()
      => ComCall(8, this.p)
    GetSink(mfCaptureEngineSinkType, ppSink)
      => ComCall(9, this.p, MF_CAPTURE_ENGINE_SINK_TYPE, mfCaptureEngineSinkType, IMFCaptureSink.Ptr, ppSink)
    GetSource(ppSource)
      => ComCall(10, this.p, IMFCaptureSource.Ptr, ppSource)
}
struct IMFCaptureEngineClassFactory extends IUnknown {
    static IID := "{8F02D140-56FC-4302-A705-3A97C78BE779}"
    CreateInstance(clsid, riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, clsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct IMFCaptureEngineOnSampleCallback2 extends IMFCaptureEngineOnSampleCallback {
    static IID := "{E37CEED7-340F-4514-9F4D-9C2AE026100B}"
    OnSynchronizedEvent(pEvent)
      => ComCall(4, this.p, IMFMediaEvent, pEvent)
}
struct IMFCaptureSink2 extends IMFCaptureSink {
    static IID := "{F9E4219E-6197-4B5E-B888-BEE310AB2C59}"
    SetOutputMediaType(dwStreamIndex, pMediaType, pEncodingAttributes?)
      => ComCall(8, this.p, UInt32, dwStreamIndex, IMFMediaType, pMediaType, IMFAttributes, pEncodingAttributes?)
}
struct IMFD3D12SynchronizationObjectCommands extends IUnknown {
    static IID := "{09D0F835-92FF-4E53-8EFA-40FAA551F233}"
    EnqueueResourceReady(pProducerCommandQueue)
      => ComCall(3, this.p, ID3D12CommandQueue, pProducerCommandQueue)
    EnqueueResourceReadyWait(pConsumerCommandQueue)
      => ComCall(4, this.p, ID3D12CommandQueue, pConsumerCommandQueue)
    SignalEventOnResourceReady(hEvent)
      => ComCall(5, this.p, HANDLE, hEvent)
    EnqueueResourceRelease(pConsumerCommandQueue)
      => ComCall(6, this.p, ID3D12CommandQueue, pConsumerCommandQueue)
}
struct IMFD3D12SynchronizationObject extends IUnknown {
    static IID := "{802302B0-82DE-45E1-B421-F19EE5BDAF23}"
    SignalEventOnFinalResourceRelease(hEvent)
      => ComCall(3, this.p, HANDLE, hEvent)
    Reset()
      => ComCall(4, this.p)
}
struct MF_MT_D3D_RESOURCE_VERSION_ENUM extends Int32 {
    static MF_D3D11_RESOURCE := 0
    static MF_D3D12_RESOURCE := 1
}
struct MFPERIODICCALLBACK extends FunctionPointer {
    static Types := [IUnknown, "Void"]
}
struct MFASYNC_WORKQUEUE_TYPE extends Int32 {
    static MF_STANDARD_WORKQUEUE := 0
    static MF_WINDOW_WORKQUEUE := 1
    static MF_MULTITHREADED_WORKQUEUE := 2
}
struct MFASYNCRESULT extends IMFAsyncResult {
}
struct MF_TOPOSTATUS extends Int32 {
    static MF_TOPOSTATUS_INVALID := 0
    static MF_TOPOSTATUS_READY := 100
    static MF_TOPOSTATUS_STARTED_SOURCE := 200
    static MF_TOPOSTATUS_DYNAMIC_CHANGED := 210
    static MF_TOPOSTATUS_SINK_SWITCHED := 300
    static MF_TOPOSTATUS_ENDED := 400
}
struct MFSampleEncryptionProtectionScheme extends Int32 {
    static MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_NONE := 0
    static MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CTR := 1
    static MF_SAMPLE_ENCRYPTION_PROTECTION_SCHEME_AES_CBC := 2
}
struct MOVE_RECT {
    SourcePoint : POINT
    DestRect : RECT
}
struct DIRTYRECT_INFO {
    FrameNumber : UInt32
    NumDirtyRects : UInt32
    DirtyRects : RECT[1]
}
struct MOVEREGION_INFO {
    FrameNumber : UInt32
    NumMoveRegions : UInt32
    MoveRegions : MOVE_RECT[1]
}
struct ROI_AREA {
    rect : RECT
    QPDelta : Int32
}
struct MACROBLOCK_DATA {
    flags : UInt32
    motionVectorX : Int16
    motionVectorY : Int16
    QPDelta : Int32
}
struct MFSampleExtensionPsnrYuv {
    psnrY : Float32
    psnrU : Float32
    psnrV : Float32
}
struct eAVEncVideoQPMapElementDataType extends Int32 {
    static CODEC_API_QP_MAP_INT8 := 0
    static CODEC_API_QP_MAP_INT16 := 1
    static CODEC_API_QP_MAP_INT32 := 2
    static CODEC_API_QP_MAP_UINT8 := -2147483648
    static CODEC_API_QP_MAP_UINT16 := -2147483647
    static CODEC_API_QP_MAP_UINT32 := -2147483646
}
struct InputQPSettings {
    minBlockSize : UInt32
    maxBlockSize : UInt32
    stepsBlockSize : UInt32
    dataType : eAVEncVideoQPMapElementDataType
    minValue : Int16
    maxValue : Int16
    step : UInt16
}
struct DigitalWindowSetting {
    OriginX : Float64
    OriginY : Float64
    WindowSize : Float64
}
struct MFT_ENUM_FLAG extends Int32 {
    static MFT_ENUM_FLAG_SYNCMFT := 1
    static MFT_ENUM_FLAG_ASYNCMFT := 2
    static MFT_ENUM_FLAG_HARDWARE := 4
    static MFT_ENUM_FLAG_FIELDOFUSE := 8
    static MFT_ENUM_FLAG_LOCALMFT := 16
    static MFT_ENUM_FLAG_TRANSCODE_ONLY := 32
    static MFT_ENUM_FLAG_SORTANDFILTER := 64
    static MFT_ENUM_FLAG_SORTANDFILTER_APPROVED_ONLY := 192
    static MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY := 320
    static MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY_EDGEMODE := 576
    static MFT_ENUM_FLAG_UNTRUSTED_STOREMFT := 1024
    static MFT_ENUM_FLAG_ALL := 63
}
struct MFFrameSourceTypes extends Int32 {
    static MFFrameSourceTypes_Color := 1
    static MFFrameSourceTypes_Infrared := 2
    static MFFrameSourceTypes_Depth := 4
    static MFFrameSourceTypes_Image := 8
    static MFFrameSourceTypes_Custom := 128
}
struct MFVideo3DFormat extends Int32 {
    static MFVideo3DSampleFormat_BaseView := 0
    static MFVideo3DSampleFormat_MultiView := 1
    static MFVideo3DSampleFormat_Packed_LeftRight := 2
    static MFVideo3DSampleFormat_Packed_TopBottom := 3
}
struct MFVideo3DSampleFormat extends Int32 {
    static MFSampleExtension_3DVideo_MultiView := 1
    static MFSampleExtension_3DVideo_Packed := 0
}
struct MFVideoRotationFormat extends Int32 {
    static MFVideoRotationFormat_0 := 0
    static MFVideoRotationFormat_90 := 90
    static MFVideoRotationFormat_180 := 180
    static MFVideoRotationFormat_270 := 270
}
struct MFDepthMeasurement extends Int32 {
    static DistanceToFocalPlane := 0
    static DistanceToOpticalCenter := 1
}
struct MF_CUSTOM_DECODE_UNIT_TYPE extends Int32 {
    static MF_DECODE_UNIT_NAL := 0
    static MF_DECODE_UNIT_SEI := 1
}
struct MFFOLDDOWN_MATRIX {
    cbSize : UInt32 := this.Size
    cSrcChannels : UInt32
    cDstChannels : UInt32
    dwChannelMask : UInt32
    Coeff : Int32[64]
}
struct MFVideoDRMFlags extends Int32 {
    static MFVideoDRMFlag_None := 0
    static MFVideoDRMFlag_AnalogProtected := 1
    static MFVideoDRMFlag_DigitallyProtected := 2
}
struct MFVideoPadFlags extends Int32 {
    static MFVideoPadFlag_PAD_TO_None := 0
    static MFVideoPadFlag_PAD_TO_4x3 := 1
    static MFVideoPadFlag_PAD_TO_16x9 := 2
}
struct MFVideoSrcContentHintFlags extends Int32 {
    static MFVideoSrcContentHintFlag_None := 0
    static MFVideoSrcContentHintFlag_16x9 := 1
    static MFVideoSrcContentHintFlag_235_1 := 2
}
struct MT_CUSTOM_VIDEO_PRIMARIES {
    fRx : Float32
    fRy : Float32
    fGx : Float32
    fGy : Float32
    fBx : Float32
    fBy : Float32
    fWx : Float32
    fWy : Float32
}
struct MT_ARBITRARY_HEADER {
    majortype : GUID
    subtype : GUID
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    lSampleSize : UInt32
    formattype : GUID
}
struct MF_FLOAT2 {
    x : Float32
    y : Float32
}
struct MF_FLOAT3 {
    x : Float32
    y : Float32
    z : Float32
}
struct MF_QUATERNION {
    x : Float32
    y : Float32
    z : Float32
    w : Float32
}
struct MFCameraExtrinsic_CalibratedTransform {
    CalibrationId : GUID
    Position : MF_FLOAT3
    Orientation : MF_QUATERNION
}
struct MFCameraExtrinsics {
    TransformCount : UInt32
    CalibratedTransforms : MFCameraExtrinsic_CalibratedTransform[1]
}
struct MFCameraIntrinsic_PinholeCameraModel {
    FocalLength : MF_FLOAT2
    PrincipalPoint : MF_FLOAT2
}
struct MFCameraIntrinsic_DistortionModel {
    Radial_k1 : Float32
    Radial_k2 : Float32
    Radial_k3 : Float32
    Tangential_p1 : Float32
    Tangential_p2 : Float32
}
struct MFPinholeCameraIntrinsic_IntrinsicModel {
    Width : UInt32
    Height : UInt32
    CameraModel : MFCameraIntrinsic_PinholeCameraModel
    DistortionModel : MFCameraIntrinsic_DistortionModel
}
struct MFPinholeCameraIntrinsics {
    IntrinsicModelCount : UInt32
    IntrinsicModels : MFPinholeCameraIntrinsic_IntrinsicModel[1]
}
struct MFWaveFormatExConvertFlags extends Int32 {
    static MFWaveFormatExConvertFlag_Normal := 0
    static MFWaveFormatExConvertFlag_ForceExtensible := 1
}
struct EAllocationType extends Int32 {
    static eAllocationTypeDynamic := 0
    static eAllocationTypeRT := 1
    static eAllocationTypePageable := 2
    static eAllocationTypeIgnore := 3
}
struct MF_MEDIA_ENGINE_ERR extends Int32 {
    static MF_MEDIA_ENGINE_ERR_NOERROR := 0
    static MF_MEDIA_ENGINE_ERR_ABORTED := 1
    static MF_MEDIA_ENGINE_ERR_NETWORK := 2
    static MF_MEDIA_ENGINE_ERR_DECODE := 3
    static MF_MEDIA_ENGINE_ERR_SRC_NOT_SUPPORTED := 4
    static MF_MEDIA_ENGINE_ERR_ENCRYPTED := 5
}
struct IMFMediaError extends IUnknown {
    static IID := "{FC0E10D2-AB2A-4501-A951-06BB1075184C}"
    GetErrorCode()
      => ComCall(3, this.p, UInt16)
    GetExtendedErrorCode()
      => ComCall(4, this.p)
    SetErrorCode(error)
      => ComCall(5, this.p, MF_MEDIA_ENGINE_ERR, error)
    SetExtendedErrorCode(error)
      => ComCall(6, this.p, HRESULT, error)
}
struct IMFMediaTimeRange extends IUnknown {
    static IID := "{DB71A2FC-078A-414E-9DF9-8C2531B0AA6C}"
    GetLength()
      => ComCall(3, this.p, UInt32)
    GetStart(index, pStart)
      => ComCall(4, this.p, UInt32, index, Float64.Ptr, pStart)
    GetEnd(index, pEnd)
      => ComCall(5, this.p, UInt32, index, Float64.Ptr, pEnd)
    ContainsTime(time)
      => ComCall(6, this.p, Float64, time, BOOL)
    AddRange(startTime, endTime)
      => ComCall(7, this.p, Float64, startTime, Float64, endTime)
    Clear()
      => ComCall(8, this.p)
}
struct MF_MEDIA_ENGINE_EVENT extends Int32 {
    static MF_MEDIA_ENGINE_EVENT_LOADSTART := 1
    static MF_MEDIA_ENGINE_EVENT_PROGRESS := 2
    static MF_MEDIA_ENGINE_EVENT_SUSPEND := 3
    static MF_MEDIA_ENGINE_EVENT_ABORT := 4
    static MF_MEDIA_ENGINE_EVENT_ERROR := 5
    static MF_MEDIA_ENGINE_EVENT_EMPTIED := 6
    static MF_MEDIA_ENGINE_EVENT_STALLED := 7
    static MF_MEDIA_ENGINE_EVENT_PLAY := 8
    static MF_MEDIA_ENGINE_EVENT_PAUSE := 9
    static MF_MEDIA_ENGINE_EVENT_LOADEDMETADATA := 10
    static MF_MEDIA_ENGINE_EVENT_LOADEDDATA := 11
    static MF_MEDIA_ENGINE_EVENT_WAITING := 12
    static MF_MEDIA_ENGINE_EVENT_PLAYING := 13
    static MF_MEDIA_ENGINE_EVENT_CANPLAY := 14
    static MF_MEDIA_ENGINE_EVENT_CANPLAYTHROUGH := 15
    static MF_MEDIA_ENGINE_EVENT_SEEKING := 16
    static MF_MEDIA_ENGINE_EVENT_SEEKED := 17
    static MF_MEDIA_ENGINE_EVENT_TIMEUPDATE := 18
    static MF_MEDIA_ENGINE_EVENT_ENDED := 19
    static MF_MEDIA_ENGINE_EVENT_RATECHANGE := 20
    static MF_MEDIA_ENGINE_EVENT_DURATIONCHANGE := 21
    static MF_MEDIA_ENGINE_EVENT_VOLUMECHANGE := 22
    static MF_MEDIA_ENGINE_EVENT_FORMATCHANGE := 1000
    static MF_MEDIA_ENGINE_EVENT_PURGEQUEUEDEVENTS := 1001
    static MF_MEDIA_ENGINE_EVENT_TIMELINE_MARKER := 1002
    static MF_MEDIA_ENGINE_EVENT_BALANCECHANGE := 1003
    static MF_MEDIA_ENGINE_EVENT_DOWNLOADCOMPLETE := 1004
    static MF_MEDIA_ENGINE_EVENT_BUFFERINGSTARTED := 1005
    static MF_MEDIA_ENGINE_EVENT_BUFFERINGENDED := 1006
    static MF_MEDIA_ENGINE_EVENT_FRAMESTEPCOMPLETED := 1007
    static MF_MEDIA_ENGINE_EVENT_NOTIFYSTABLESTATE := 1008
    static MF_MEDIA_ENGINE_EVENT_FIRSTFRAMEREADY := 1009
    static MF_MEDIA_ENGINE_EVENT_TRACKSCHANGE := 1010
    static MF_MEDIA_ENGINE_EVENT_OPMINFO := 1011
    static MF_MEDIA_ENGINE_EVENT_RESOURCELOST := 1012
    static MF_MEDIA_ENGINE_EVENT_DELAYLOADEVENT_CHANGED := 1013
    static MF_MEDIA_ENGINE_EVENT_STREAMRENDERINGERROR := 1014
    static MF_MEDIA_ENGINE_EVENT_SUPPORTEDRATES_CHANGED := 1015
    static MF_MEDIA_ENGINE_EVENT_AUDIOENDPOINTCHANGE := 1016
}
struct IMFMediaEngineNotify extends IUnknown {
    static IID := "{FEE7C112-E776-42B5-9BBF-0048524E2BD5}"
    EventNotify(event, param1, param2)
      => ComCall(3, this.p, UInt32, event, IntPtr, param1, UInt32, param2)
}
struct IMFMediaEngineSrcElements extends IUnknown {
    static IID := "{7A5E5354-B114-4C72-B991-3131D75032EA}"
    GetLength()
      => ComCall(3, this.p, UInt32)
    GetURL(index, pURL)
      => ComCall(4, this.p, UInt32, index, BSTR.Ptr, pURL)
    GetType(index, pType)
      => ComCall(5, this.p, UInt32, index, BSTR.Ptr, pType)
    GetMedia(index, pMedia)
      => ComCall(6, this.p, UInt32, index, BSTR.Ptr, pMedia)
    AddElement(pURL?, pType?, pMedia?)
      => ComCall(7, this.p, BSTR, pURL?, BSTR, pType?, BSTR, pMedia?)
    RemoveAllElements()
      => ComCall(8, this.p)
}
struct MF_MEDIA_ENGINE_NETWORK extends Int32 {
    static MF_MEDIA_ENGINE_NETWORK_EMPTY := 0
    static MF_MEDIA_ENGINE_NETWORK_IDLE := 1
    static MF_MEDIA_ENGINE_NETWORK_LOADING := 2
    static MF_MEDIA_ENGINE_NETWORK_NO_SOURCE := 3
}
struct MF_MEDIA_ENGINE_READY extends Int32 {
    static MF_MEDIA_ENGINE_READY_HAVE_NOTHING := 0
    static MF_MEDIA_ENGINE_READY_HAVE_METADATA := 1
    static MF_MEDIA_ENGINE_READY_HAVE_CURRENT_DATA := 2
    static MF_MEDIA_ENGINE_READY_HAVE_FUTURE_DATA := 3
    static MF_MEDIA_ENGINE_READY_HAVE_ENOUGH_DATA := 4
}
struct MF_MEDIA_ENGINE_CANPLAY extends Int32 {
    static MF_MEDIA_ENGINE_CANPLAY_NOT_SUPPORTED := 0
    static MF_MEDIA_ENGINE_CANPLAY_MAYBE := 1
    static MF_MEDIA_ENGINE_CANPLAY_PROBABLY := 2
}
struct MF_MEDIA_ENGINE_PRELOAD extends Int32 {
    static MF_MEDIA_ENGINE_PRELOAD_MISSING := 0
    static MF_MEDIA_ENGINE_PRELOAD_EMPTY := 1
    static MF_MEDIA_ENGINE_PRELOAD_NONE := 2
    static MF_MEDIA_ENGINE_PRELOAD_METADATA := 3
    static MF_MEDIA_ENGINE_PRELOAD_AUTOMATIC := 4
}
struct IMFMediaEngine extends IUnknown {
    static IID := "{98A1B0BB-03EB-4935-AE7C-93C1FA0E1C93}"
    GetError(ppError)
      => ComCall(3, this.p, IMFMediaError.Ptr, ppError)
    SetErrorCode(error)
      => ComCall(4, this.p, MF_MEDIA_ENGINE_ERR, error)
    SetSourceElements(pSrcElements)
      => ComCall(5, this.p, IMFMediaEngineSrcElements, pSrcElements)
    SetSource(pUrl)
      => ComCall(6, this.p, BSTR, pUrl)
    GetCurrentSource(ppUrl)
      => ComCall(7, this.p, BSTR.Ptr, ppUrl)
    GetNetworkState()
      => ComCall(8, this.p, UInt16)
    GetPreload()
      => ComCall(9, this.p, MF_MEDIA_ENGINE_PRELOAD)
    SetPreload(Preload)
      => ComCall(10, this.p, MF_MEDIA_ENGINE_PRELOAD, Preload)
    GetBuffered(ppBuffered)
      => ComCall(11, this.p, IMFMediaTimeRange.Ptr, ppBuffered)
    Load()
      => ComCall(12, this.p)
    CanPlayType(type, pAnswer)
      => ComCall(13, this.p, BSTR, type, MF_MEDIA_ENGINE_CANPLAY.Ptr, pAnswer)
    GetReadyState()
      => ComCall(14, this.p, UInt16)
    IsSeeking()
      => ComCall(15, this.p, BOOL)
    GetCurrentTime()
      => ComCall(16, this.p, Float64)
    SetCurrentTime(seekTime)
      => ComCall(17, this.p, Float64, seekTime)
    GetStartTime()
      => ComCall(18, this.p, Float64)
    GetDuration()
      => ComCall(19, this.p, Float64)
    IsPaused()
      => ComCall(20, this.p, BOOL)
    GetDefaultPlaybackRate()
      => ComCall(21, this.p, Float64)
    SetDefaultPlaybackRate(Rate)
      => ComCall(22, this.p, Float64, Rate)
    GetPlaybackRate()
      => ComCall(23, this.p, Float64)
    SetPlaybackRate(Rate)
      => ComCall(24, this.p, Float64, Rate)
    GetPlayed(ppPlayed)
      => ComCall(25, this.p, IMFMediaTimeRange.Ptr, ppPlayed)
    GetSeekable(ppSeekable)
      => ComCall(26, this.p, IMFMediaTimeRange.Ptr, ppSeekable)
    IsEnded()
      => ComCall(27, this.p, BOOL)
    GetAutoPlay()
      => ComCall(28, this.p, BOOL)
    SetAutoPlay(AutoPlay)
      => ComCall(29, this.p, BOOL, AutoPlay)
    GetLoop()
      => ComCall(30, this.p, BOOL)
    SetLoop(Loop1)
      => ComCall(31, this.p, BOOL, Loop1)
    Play()
      => ComCall(32, this.p)
    Pause()
      => ComCall(33, this.p)
    GetMuted()
      => ComCall(34, this.p, BOOL)
    SetMuted(Muted)
      => ComCall(35, this.p, BOOL, Muted)
    GetVolume()
      => ComCall(36, this.p, Float64)
    SetVolume(Volume)
      => ComCall(37, this.p, Float64, Volume)
    HasVideo()
      => ComCall(38, this.p, BOOL)
    HasAudio()
      => ComCall(39, this.p, BOOL)
    GetNativeVideoSize(cx?, cy?)
      => ComCall(40, this.p, UInt32.Ptr, cx?, UInt32.Ptr, cy?)
    GetVideoAspectRatio(cx?, cy?)
      => ComCall(41, this.p, UInt32.Ptr, cx?, UInt32.Ptr, cy?)
    Shutdown()
      => ComCall(42, this.p)
    TransferVideoFrame(pDstSurf, pSrc?, pDst, pBorderClr?)
      => ComCall(43, this.p, IUnknown, pDstSurf, MFVideoNormalizedRect.Ptr, pSrc?, RECT.Ptr, pDst, MFARGB.Ptr, pBorderClr?)
    OnVideoStreamTick(pPts)
      => ComCall(44, this.p, Int64.Ptr, pPts)
}
struct MF_MEDIA_ENGINE_S3D_PACKING_MODE extends Int32 {
    static MF_MEDIA_ENGINE_S3D_PACKING_MODE_NONE := 0
    static MF_MEDIA_ENGINE_S3D_PACKING_MODE_SIDE_BY_SIDE := 1
    static MF_MEDIA_ENGINE_S3D_PACKING_MODE_TOP_BOTTOM := 2
}
struct MF_MEDIA_ENGINE_STATISTIC extends Int32 {
    static MF_MEDIA_ENGINE_STATISTIC_FRAMES_RENDERED := 0
    static MF_MEDIA_ENGINE_STATISTIC_FRAMES_DROPPED := 1
    static MF_MEDIA_ENGINE_STATISTIC_BYTES_DOWNLOADED := 2
    static MF_MEDIA_ENGINE_STATISTIC_BUFFER_PROGRESS := 3
    static MF_MEDIA_ENGINE_STATISTIC_FRAMES_PER_SECOND := 4
    static MF_MEDIA_ENGINE_STATISTIC_PLAYBACK_JITTER := 5
    static MF_MEDIA_ENGINE_STATISTIC_FRAMES_CORRUPTED := 6
    static MF_MEDIA_ENGINE_STATISTIC_TOTAL_FRAME_DELAY := 7
}
struct MF_MEDIA_ENGINE_SEEK_MODE extends Int32 {
    static MF_MEDIA_ENGINE_SEEK_MODE_NORMAL := 0
    static MF_MEDIA_ENGINE_SEEK_MODE_APPROXIMATE := 1
}
struct IMFMediaEngineEx extends IMFMediaEngine {
    static IID := "{83015EAD-B1E6-40D0-A98A-37145FFE1AD1}"
    SetSourceFromByteStream(pByteStream, pURL)
      => ComCall(45, this.p, IMFByteStream, pByteStream, BSTR, pURL)
    GetStatistics(StatisticID, pStatistic)
      => ComCall(46, this.p, MF_MEDIA_ENGINE_STATISTIC, StatisticID, PROPVARIANT.Ptr, pStatistic)
    UpdateVideoStream(pSrc?, pDst?, pBorderClr?)
      => ComCall(47, this.p, MFVideoNormalizedRect.Ptr, pSrc?, RECT.Ptr, pDst?, MFARGB.Ptr, pBorderClr?)
    GetBalance()
      => ComCall(48, this.p, Float64)
    SetBalance(balance)
      => ComCall(49, this.p, Float64, balance)
    IsPlaybackRateSupported(rate)
      => ComCall(50, this.p, Float64, rate, BOOL)
    FrameStep(Forward)
      => ComCall(51, this.p, BOOL, Forward)
    GetResourceCharacteristics(pCharacteristics)
      => ComCall(52, this.p, UInt32.Ptr, pCharacteristics)
    GetPresentationAttribute(guidMFAttribute, pvValue)
      => ComCall(53, this.p, GUID.Ptr, guidMFAttribute, PROPVARIANT.Ptr, pvValue)
    GetNumberOfStreams(pdwStreamCount)
      => ComCall(54, this.p, UInt32.Ptr, pdwStreamCount)
    GetStreamAttribute(dwStreamIndex, guidMFAttribute, pvValue)
      => ComCall(55, this.p, UInt32, dwStreamIndex, GUID.Ptr, guidMFAttribute, PROPVARIANT.Ptr, pvValue)
    GetStreamSelection(dwStreamIndex, pEnabled)
      => ComCall(56, this.p, UInt32, dwStreamIndex, BOOL.Ptr, pEnabled)
    SetStreamSelection(dwStreamIndex, Enabled)
      => ComCall(57, this.p, UInt32, dwStreamIndex, BOOL, Enabled)
    ApplyStreamSelections()
      => ComCall(58, this.p)
    IsProtected(pProtected)
      => ComCall(59, this.p, BOOL.Ptr, pProtected)
    InsertVideoEffect(pEffect, fOptional)
      => ComCall(60, this.p, IUnknown, pEffect, BOOL, fOptional)
    InsertAudioEffect(pEffect, fOptional)
      => ComCall(61, this.p, IUnknown, pEffect, BOOL, fOptional)
    RemoveAllEffects()
      => ComCall(62, this.p)
    SetTimelineMarkerTimer(timeToFire)
      => ComCall(63, this.p, Float64, timeToFire)
    GetTimelineMarkerTimer(pTimeToFire)
      => ComCall(64, this.p, Float64.Ptr, pTimeToFire)
    CancelTimelineMarkerTimer()
      => ComCall(65, this.p)
    IsStereo3D()
      => ComCall(66, this.p, BOOL)
    GetStereo3DFramePackingMode(packMode)
      => ComCall(67, this.p, MF_MEDIA_ENGINE_S3D_PACKING_MODE.Ptr, packMode)
    SetStereo3DFramePackingMode(packMode)
      => ComCall(68, this.p, MF_MEDIA_ENGINE_S3D_PACKING_MODE, packMode)
    GetStereo3DRenderMode(outputType)
      => ComCall(69, this.p, MF3DVideoOutputType.Ptr, outputType)
    SetStereo3DRenderMode(outputType)
      => ComCall(70, this.p, MF3DVideoOutputType, outputType)
    EnableWindowlessSwapchainMode(fEnable)
      => ComCall(71, this.p, BOOL, fEnable)
    GetVideoSwapchainHandle(phSwapchain)
      => ComCall(72, this.p, HANDLE.Ptr, phSwapchain)
    EnableHorizontalMirrorMode(fEnable)
      => ComCall(73, this.p, BOOL, fEnable)
    GetAudioStreamCategory(pCategory)
      => ComCall(74, this.p, UInt32.Ptr, pCategory)
    SetAudioStreamCategory(category)
      => ComCall(75, this.p, UInt32, category)
    GetAudioEndpointRole(pRole)
      => ComCall(76, this.p, UInt32.Ptr, pRole)
    SetAudioEndpointRole(role)
      => ComCall(77, this.p, UInt32, role)
    GetRealTimeMode(pfEnabled)
      => ComCall(78, this.p, BOOL.Ptr, pfEnabled)
    SetRealTimeMode(fEnable)
      => ComCall(79, this.p, BOOL, fEnable)
    SetCurrentTimeEx(seekTime, seekMode)
      => ComCall(80, this.p, Float64, seekTime, MF_MEDIA_ENGINE_SEEK_MODE, seekMode)
    EnableTimeUpdateTimer(fEnableTimer)
      => ComCall(81, this.p, BOOL, fEnableTimer)
}
struct IMFMediaEngineAudioEndpointId extends IUnknown {
    static IID := "{7A3BAC98-0E76-49FB-8C20-8A86FD98EAF2}"
    SetAudioEndpointId(pszEndpointId?)
      => ComCall(3, this.p, "Str", pszEndpointId?)
    GetAudioEndpointId(ppszEndpointId)
      => ComCall(4, this.p, PWSTR.Ptr, ppszEndpointId)
}
struct IMFMediaEngineVideoRendererEffect extends IUnknown {
    static IID := "{6BDF1188-6EC8-44FF-8CCC-BFCA0D12AFA3}"
    SetEffect(pEffect)
      => ComCall(3, this.p, IUnknown, pEffect)
    ClearEffect()
      => ComCall(4, this.p)
}
struct MF_MEDIA_ENGINE_EXTENSION_TYPE extends Int32 {
    static MF_MEDIA_ENGINE_EXTENSION_TYPE_MEDIASOURCE := 0
    static MF_MEDIA_ENGINE_EXTENSION_TYPE_BYTESTREAM := 1
}
struct IMFMediaEngineExtension extends IUnknown {
    static IID := "{2F69D622-20B5-41E9-AFDF-89CED1DDA04E}"
    CanPlayType(AudioOnly, MimeType, pAnswer)
      => ComCall(3, this.p, BOOL, AudioOnly, BSTR, MimeType, MF_MEDIA_ENGINE_CANPLAY.Ptr, pAnswer)
    BeginCreateObject(bstrURL, pByteStream?, type, ppIUnknownCancelCookie, pCallback, punkState?)
      => ComCall(4, this.p, BSTR, bstrURL, IMFByteStream, pByteStream?, MF_OBJECT_TYPE, type, IUnknown.Ptr, ppIUnknownCancelCookie, IMFAsyncCallback, pCallback, IUnknown, punkState?)
    CancelObjectCreation(pIUnknownCancelCookie)
      => ComCall(5, this.p, IUnknown, pIUnknownCancelCookie)
    EndCreateObject(pResult, ppObject)
      => ComCall(6, this.p, IMFAsyncResult, pResult, IUnknown.Ptr, ppObject)
}
struct MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAGS extends Int32 {
    static MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_PROTECTED := 1
    static MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_SURFACE_PROTECTION := 2
    static MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_ANTI_SCREEN_SCRAPE_PROTECTION := 4
}
struct IMFMediaEngineProtectedContent extends IUnknown {
    static IID := "{9F8021E8-9C8C-487E-BB5C-79AA4779938C}"
    ShareResources(pUnkDeviceContext)
      => ComCall(3, this.p, IUnknown, pUnkDeviceContext)
    GetRequiredProtections(pFrameProtectionFlags)
      => ComCall(4, this.p, UInt32.Ptr, pFrameProtectionFlags)
    SetOPMWindow(hwnd1)
      => ComCall(5, this.p, HWND, hwnd1)
    TransferVideoFrame(pDstSurf, pSrc?, pDst, pBorderClr?, pFrameProtectionFlags)
      => ComCall(6, this.p, IUnknown, pDstSurf, MFVideoNormalizedRect.Ptr, pSrc?, RECT.Ptr, pDst, MFARGB.Ptr, pBorderClr?, UInt32.Ptr, pFrameProtectionFlags)
    SetContentProtectionManager(pCPM?)
      => ComCall(7, this.p, IMFContentProtectionManager, pCPM?)
    SetApplicationCertificate(pbBlob)
      => ComCall(8, this.p, UInt8.Ptr, pbBlob, UInt32, pbBlob.Size)
}
struct IAudioSourceProvider extends IUnknown {
    static IID := "{EBBAF249-AFC2-4582-91C6-B60DF2E84954}"
    ProvideInput(dwSampleCount, pdwChannelCount, pInterleavedAudioData?)
      => ComCall(3, this.p, UInt32, dwSampleCount, UInt32.Ptr, pdwChannelCount, Float32.Ptr, pInterleavedAudioData?)
}
struct IMFMediaEngineWebSupport extends IUnknown {
    static IID := "{BA2743A1-07E0-48EF-84B6-9A2ED023CA6C}"
    ShouldDelayTheLoadEvent()
      => ComCall(3, this.p, BOOL)
    ConnectWebAudio(dwSampleRate, ppSourceProvider)
      => ComCall(4, this.p, UInt32, dwSampleRate, IAudioSourceProvider.Ptr, ppSourceProvider)
    DisconnectWebAudio()
      => ComCall(5, this.p)
}
struct MF_MSE_VP9_SUPPORT_TYPE extends Int32 {
    static MF_MSE_VP9_SUPPORT_DEFAULT := 0
    static MF_MSE_VP9_SUPPORT_ON := 1
    static MF_MSE_VP9_SUPPORT_OFF := 2
}
struct MF_MSE_OPUS_SUPPORT_TYPE extends Int32 {
    static MF_MSE_OPUS_SUPPORT_ON := 0
    static MF_MSE_OPUS_SUPPORT_OFF := 1
}
struct IMFMediaSourceExtensionNotify extends IUnknown {
    static IID := "{A7901327-05DD-4469-A7B7-0E01979E361D}"
    OnSourceOpen()
      => ComCall(3, this.p, "void")
    OnSourceEnded()
      => ComCall(4, this.p, "void")
    OnSourceClose()
      => ComCall(5, this.p, "void")
}
struct IMFBufferListNotify extends IUnknown {
    static IID := "{24CD47F7-81D8-4785-ADB2-AF697A963CD2}"
    OnAddSourceBuffer()
      => ComCall(3, this.p, "void")
    OnRemoveSourceBuffer()
      => ComCall(4, this.p, "void")
}
struct IMFSourceBufferNotify extends IUnknown {
    static IID := "{87E47623-2CEB-45D6-9B88-D8520C4DCBBC}"
    OnUpdateStart()
      => ComCall(3, this.p, "void")
    OnAbort()
      => ComCall(4, this.p, "void")
    OnError(hr)
      => ComCall(5, this.p, HRESULT, hr, "void")
    OnUpdate()
      => ComCall(6, this.p, "void")
    OnUpdateEnd()
      => ComCall(7, this.p, "void")
}
struct IMFSourceBuffer extends IUnknown {
    static IID := "{E2CD3A4B-AF25-4D3D-9110-DA0E6F8EE877}"
    GetUpdating()
      => ComCall(3, this.p, BOOL)
    GetBuffered(ppBuffered)
      => ComCall(4, this.p, IMFMediaTimeRange.Ptr, ppBuffered)
    GetTimeStampOffset()
      => ComCall(5, this.p, Float64)
    SetTimeStampOffset(offset)
      => ComCall(6, this.p, Float64, offset)
    GetAppendWindowStart()
      => ComCall(7, this.p, Float64)
    SetAppendWindowStart(time)
      => ComCall(8, this.p, Float64, time)
    GetAppendWindowEnd()
      => ComCall(9, this.p, Float64)
    SetAppendWindowEnd(time)
      => ComCall(10, this.p, Float64, time)
    Append(pData)
      => ComCall(11, this.p, UInt8.Ptr, pData, UInt32, pData.Size)
    AppendByteStream(pStream, pMaxLen?)
      => ComCall(12, this.p, IMFByteStream, pStream, Int64.Ptr, pMaxLen?)
    Abort()
      => ComCall(13, this.p)
    Remove(start, end)
      => ComCall(14, this.p, Float64, start, Float64, end)
}
struct MF_MSE_APPEND_MODE extends Int32 {
    static MF_MSE_APPEND_MODE_SEGMENTS := 0
    static MF_MSE_APPEND_MODE_SEQUENCE := 1
}
struct IMFSourceBufferAppendMode extends IUnknown {
    static IID := "{19666FB4-BABE-4C55-BC03-0A074DA37E2A}"
    GetAppendMode()
      => ComCall(3, this.p, MF_MSE_APPEND_MODE)
    SetAppendMode(mode)
      => ComCall(4, this.p, MF_MSE_APPEND_MODE, mode)
}
struct IMFSourceBufferList extends IUnknown {
    static IID := "{249981F8-8325-41F3-B80C-3B9E3AAD0CBE}"
    GetLength()
      => ComCall(3, this.p, UInt32)
    GetSourceBuffer(index)
      => ComCall(4, this.p, UInt32, index, IMFSourceBuffer)
}
struct MF_MSE_READY extends Int32 {
    static MF_MSE_READY_CLOSED := 1
    static MF_MSE_READY_OPEN := 2
    static MF_MSE_READY_ENDED := 3
}
struct MF_MSE_ERROR extends Int32 {
    static MF_MSE_ERROR_NOERROR := 0
    static MF_MSE_ERROR_NETWORK := 1
    static MF_MSE_ERROR_DECODE := 2
    static MF_MSE_ERROR_UNKNOWN_ERROR := 3
}
struct IMFMediaSourceExtension extends IUnknown {
    static IID := "{E467B94E-A713-4562-A802-816A42E9008A}"
    GetSourceBuffers()
      => ComCall(3, this.p, IMFSourceBufferList)
    GetActiveSourceBuffers()
      => ComCall(4, this.p, IMFSourceBufferList)
    GetReadyState()
      => ComCall(5, this.p, MF_MSE_READY)
    GetDuration()
      => ComCall(6, this.p, Float64)
    SetDuration(duration)
      => ComCall(7, this.p, Float64, duration)
    AddSourceBuffer(type, pNotify, ppSourceBuffer)
      => ComCall(8, this.p, BSTR, type, IMFSourceBufferNotify, pNotify, IMFSourceBuffer.Ptr, ppSourceBuffer)
    RemoveSourceBuffer(pSourceBuffer)
      => ComCall(9, this.p, IMFSourceBuffer, pSourceBuffer)
    SetEndOfStream(error)
      => ComCall(10, this.p, MF_MSE_ERROR, error)
    IsTypeSupported(type)
      => ComCall(11, this.p, BSTR, type, BOOL)
    GetSourceBuffer(dwStreamIndex)
      => ComCall(12, this.p, UInt32, dwStreamIndex, IMFSourceBuffer)
}
struct IMFMediaSourceExtensionLiveSeekableRange extends IUnknown {
    static IID := "{5D1ABFD6-450A-4D92-9EFC-D6B6CBC1F4DA}"
    SetLiveSeekableRange(start, end)
      => ComCall(3, this.p, Float64, start, Float64, end)
    ClearLiveSeekableRange()
      => ComCall(4, this.p)
}
struct IMFMediaEngineEME extends IUnknown {
    static IID := "{50DC93E4-BA4F-4275-AE66-83E836E57469}"
    get_Keys(keys)
      => ComCall(3, this.p, IMFMediaKeys.Ptr, keys)
    SetMediaKeys(keys?)
      => ComCall(4, this.p, IMFMediaKeys, keys?)
}
struct IMFMediaEngineSrcElementsEx extends IMFMediaEngineSrcElements {
    static IID := "{654A6BB3-E1A3-424A-9908-53A43A0DFDA0}"
    AddElementEx(pURL?, pType?, pMedia?, keySystem?)
      => ComCall(9, this.p, BSTR, pURL?, BSTR, pType?, BSTR, pMedia?, BSTR, keySystem?)
    GetKeySystem(index, pType)
      => ComCall(10, this.p, UInt32, index, BSTR.Ptr, pType)
}
struct IMFMediaEngineNeedKeyNotify extends IUnknown {
    static IID := "{46A30204-A696-4B18-8804-246B8F031BB1}"
    NeedKey(initData?)
      => ComCall(3, this.p, UInt8.Ptr, initData?, UInt32, initData?.Size ?? 0, "void")
}
struct IMFMediaKeys extends IUnknown {
    static IID := "{5CB31C05-61FF-418F-AFDA-CAAF41421A38}"
    CreateSession(mimeType?, initData?, customData?, notify, ppSession)
      => ComCall(3, this.p, BSTR, mimeType?, UInt8.Ptr, initData?, UInt32, initData?.Size ?? 0, UInt8.Ptr, customData?, UInt32, customData?.Size ?? 0, IMFMediaKeySessionNotify, notify, IMFMediaKeySession.Ptr, ppSession)
    get_KeySystem(keySystem)
      => ComCall(4, this.p, BSTR.Ptr, keySystem)
    Shutdown()
      => ComCall(5, this.p)
    GetSuspendNotify(notify)
      => ComCall(6, this.p, IMFCdmSuspendNotify.Ptr, notify)
}
struct MF_MEDIA_ENGINE_KEYERR extends Int32 {
    static MF_MEDIAENGINE_KEYERR_UNKNOWN := 1
    static MF_MEDIAENGINE_KEYERR_CLIENT := 2
    static MF_MEDIAENGINE_KEYERR_SERVICE := 3
    static MF_MEDIAENGINE_KEYERR_OUTPUT := 4
    static MF_MEDIAENGINE_KEYERR_HARDWARECHANGE := 5
    static MF_MEDIAENGINE_KEYERR_DOMAIN := 6
}
struct IMFMediaKeySession extends IUnknown {
    static IID := "{24FA67D5-D1D0-4DC5-995C-C0EFDC191FB5}"
    GetError(code, systemCode)
      => ComCall(3, this.p, UInt16.Ptr, code, UInt32.Ptr, systemCode)
    get_KeySystem(keySystem)
      => ComCall(4, this.p, BSTR.Ptr, keySystem)
    get_SessionId(sessionId)
      => ComCall(5, this.p, BSTR.Ptr, sessionId)
    Update(key)
      => ComCall(6, this.p, UInt8.Ptr, key, UInt32, key.Size)
    Close()
      => ComCall(7, this.p)
}
struct IMFMediaKeySessionNotify extends IUnknown {
    static IID := "{6A0083F9-8947-4C1D-9CE0-CDEE22B23135}"
    KeyMessage(destinationURL?, message)
      => ComCall(3, this.p, BSTR, destinationURL?, UInt8.Ptr, message, UInt32, message.Size, "void")
    KeyAdded()
      => ComCall(4, this.p, "void")
    KeyError(code, systemCode)
      => ComCall(5, this.p, UInt16, code, UInt32, systemCode, "void")
}
struct IMFCdmSuspendNotify extends IUnknown {
    static IID := "{7A5645D2-43BD-47FD-87B7-DCD24CC7D692}"
    Begin()
      => ComCall(3, this.p)
    End()
      => ComCall(4, this.p)
}
struct MF_HDCP_STATUS extends Int32 {
    static MF_HDCP_STATUS_ON := 0
    static MF_HDCP_STATUS_OFF := 1
    static MF_HDCP_STATUS_ON_WITH_TYPE_ENFORCEMENT := 2
}
struct IMFHDCPStatus extends IUnknown {
    static IID := "{DE400F54-5BF1-40CF-8964-0BEA136B1E3D}"
    Query(pStatus, pfStatus)
      => ComCall(3, this.p, MF_HDCP_STATUS.Ptr, pStatus, BOOL.Ptr, pfStatus)
    Set(status)
      => ComCall(4, this.p, MF_HDCP_STATUS, status)
}
struct MF_MEDIA_ENGINE_OPM_STATUS extends Int32 {
    static MF_MEDIA_ENGINE_OPM_NOT_REQUESTED := 0
    static MF_MEDIA_ENGINE_OPM_ESTABLISHED := 1
    static MF_MEDIA_ENGINE_OPM_FAILED_VM := 2
    static MF_MEDIA_ENGINE_OPM_FAILED_BDA := 3
    static MF_MEDIA_ENGINE_OPM_FAILED_UNSIGNED_DRIVER := 4
    static MF_MEDIA_ENGINE_OPM_FAILED := 5
}
struct IMFMediaEngineOPMInfo extends IUnknown {
    static IID := "{765763E6-6C01-4B01-BB0F-B829F60ED28C}"
    GetOPMInfo(pStatus, pConstricted)
      => ComCall(3, this.p, MF_MEDIA_ENGINE_OPM_STATUS.Ptr, pStatus, BOOL.Ptr, pConstricted)
}
struct MF_MEDIA_ENGINE_CREATEFLAGS extends Int32 {
    static MF_MEDIA_ENGINE_AUDIOONLY := 1
    static MF_MEDIA_ENGINE_WAITFORSTABLE_STATE := 2
    static MF_MEDIA_ENGINE_FORCEMUTE := 4
    static MF_MEDIA_ENGINE_REAL_TIME_MODE := 8
    static MF_MEDIA_ENGINE_DISABLE_LOCAL_PLUGINS := 16
    static MF_MEDIA_ENGINE_CREATEFLAGS_MASK := 31
}
struct MF_MEDIA_ENGINE_PROTECTION_FLAGS extends Int32 {
    static MF_MEDIA_ENGINE_ENABLE_PROTECTED_CONTENT := 1
    static MF_MEDIA_ENGINE_USE_PMP_FOR_ALL_CONTENT := 2
    static MF_MEDIA_ENGINE_USE_UNPROTECTED_PMP := 4
}
struct IMFMediaEngineClassFactory extends IUnknown {
    static IID := "{4D645ACE-26AA-4688-9BE1-DF3516990B93}"
    CreateInstance(dwFlags, pAttr, ppPlayer)
      => ComCall(3, this.p, UInt32, dwFlags, IMFAttributes, pAttr, IMFMediaEngine.Ptr, ppPlayer)
    CreateTimeRange(ppTimeRange)
      => ComCall(4, this.p, IMFMediaTimeRange.Ptr, ppTimeRange)
    CreateError(ppError)
      => ComCall(5, this.p, IMFMediaError.Ptr, ppError)
}
struct IMFMediaEngineClassFactoryEx extends IMFMediaEngineClassFactory {
    static IID := "{C56156C6-EA5B-48A5-9DF8-FBE035D0929E}"
    CreateMediaSourceExtension(dwFlags, pAttr, ppMSE)
      => ComCall(6, this.p, UInt32, dwFlags, IMFAttributes, pAttr, IMFMediaSourceExtension.Ptr, ppMSE)
    CreateMediaKeys(keySystem, cdmStorePath?, ppKeys)
      => ComCall(7, this.p, BSTR, keySystem, BSTR, cdmStorePath?, IMFMediaKeys.Ptr, ppKeys)
    IsTypeSupported(type?, keySystem, isSupported)
      => ComCall(8, this.p, BSTR, type?, BSTR, keySystem, BOOL.Ptr, isSupported)
}
struct IMFMediaEngineClassFactory2 extends IUnknown {
    static IID := "{09083CEF-867F-4BF6-8776-DEE3A7B42FCA}"
    CreateMediaKeys2(keySystem, defaultCdmStorePath, inprivateCdmStorePath?, ppKeys)
      => ComCall(3, this.p, BSTR, keySystem, BSTR, defaultCdmStorePath, BSTR, inprivateCdmStorePath?, IMFMediaKeys.Ptr, ppKeys)
}
struct IMFExtendedDRMTypeSupport extends IUnknown {
    static IID := "{332EC562-3758-468D-A784-E38F23552128}"
    IsTypeSupportedEx(type?, keySystem, pAnswer)
      => ComCall(3, this.p, BSTR, type?, BSTR, keySystem, MF_MEDIA_ENGINE_CANPLAY.Ptr, pAnswer)
}
struct IMFMediaEngineSupportsSourceTransfer extends IUnknown {
    static IID := "{A724B056-1B2E-4642-A6F3-DB9420C52908}"
    ShouldTransferSource(pfShouldTransfer)
      => ComCall(3, this.p, BOOL.Ptr, pfShouldTransfer)
    DetachMediaSource(ppByteStream, ppMediaSource, ppMSE)
      => ComCall(4, this.p, IMFByteStream.Ptr, ppByteStream, IMFMediaSource.Ptr, ppMediaSource, IMFMediaSourceExtension.Ptr, ppMSE)
    AttachMediaSource(pByteStream?, pMediaSource, pMSE?)
      => ComCall(5, this.p, IMFByteStream, pByteStream?, IMFMediaSource, pMediaSource, IMFMediaSourceExtension, pMSE?)
}
struct IMFMediaEngineTransferSource extends IUnknown {
    static IID := "{24230452-FE54-40CC-94F3-FCC394C340D6}"
    TransferSourceToMediaEngine(destination)
      => ComCall(3, this.p, IMFMediaEngine, destination)
}
struct MF_TIMED_TEXT_TRACK_KIND extends Int32 {
    static MF_TIMED_TEXT_TRACK_KIND_UNKNOWN := 0
    static MF_TIMED_TEXT_TRACK_KIND_SUBTITLES := 1
    static MF_TIMED_TEXT_TRACK_KIND_CAPTIONS := 2
    static MF_TIMED_TEXT_TRACK_KIND_METADATA := 3
}
struct MF_TIMED_TEXT_UNIT_TYPE extends Int32 {
    static MF_TIMED_TEXT_UNIT_TYPE_PIXELS := 0
    static MF_TIMED_TEXT_UNIT_TYPE_PERCENTAGE := 1
}
struct MF_TIMED_TEXT_FONT_STYLE extends Int32 {
    static MF_TIMED_TEXT_FONT_STYLE_NORMAL := 0
    static MF_TIMED_TEXT_FONT_STYLE_OBLIQUE := 1
    static MF_TIMED_TEXT_FONT_STYLE_ITALIC := 2
}
struct MF_TIMED_TEXT_ALIGNMENT extends Int32 {
    static MF_TIMED_TEXT_ALIGNMENT_START := 0
    static MF_TIMED_TEXT_ALIGNMENT_END := 1
    static MF_TIMED_TEXT_ALIGNMENT_CENTER := 2
}
struct MF_TIMED_TEXT_DISPLAY_ALIGNMENT extends Int32 {
    static MF_TIMED_TEXT_DISPLAY_ALIGNMENT_BEFORE := 0
    static MF_TIMED_TEXT_DISPLAY_ALIGNMENT_AFTER := 1
    static MF_TIMED_TEXT_DISPLAY_ALIGNMENT_CENTER := 2
}
struct MF_TIMED_TEXT_DECORATION extends Int32 {
    static MF_TIMED_TEXT_DECORATION_NONE := 0
    static MF_TIMED_TEXT_DECORATION_UNDERLINE := 1
    static MF_TIMED_TEXT_DECORATION_LINE_THROUGH := 2
    static MF_TIMED_TEXT_DECORATION_OVERLINE := 4
}
struct MF_TIMED_TEXT_WRITING_MODE extends Int32 {
    static MF_TIMED_TEXT_WRITING_MODE_LRTB := 0
    static MF_TIMED_TEXT_WRITING_MODE_RLTB := 1
    static MF_TIMED_TEXT_WRITING_MODE_TBRL := 2
    static MF_TIMED_TEXT_WRITING_MODE_TBLR := 3
    static MF_TIMED_TEXT_WRITING_MODE_LR := 4
    static MF_TIMED_TEXT_WRITING_MODE_RL := 5
    static MF_TIMED_TEXT_WRITING_MODE_TB := 6
}
struct MF_TIMED_TEXT_SCROLL_MODE extends Int32 {
    static MF_TIMED_TEXT_SCROLL_MODE_POP_ON := 0
    static MF_TIMED_TEXT_SCROLL_MODE_ROLL_UP := 1
}
struct MF_TIMED_TEXT_ERROR_CODE extends Int32 {
    static MF_TIMED_TEXT_ERROR_CODE_NOERROR := 0
    static MF_TIMED_TEXT_ERROR_CODE_FATAL := 1
    static MF_TIMED_TEXT_ERROR_CODE_DATA_FORMAT := 2
    static MF_TIMED_TEXT_ERROR_CODE_NETWORK := 3
    static MF_TIMED_TEXT_ERROR_CODE_INTERNAL := 4
}
struct MF_TIMED_TEXT_CUE_EVENT extends Int32 {
    static MF_TIMED_TEXT_CUE_EVENT_ACTIVE := 0
    static MF_TIMED_TEXT_CUE_EVENT_INACTIVE := 1
    static MF_TIMED_TEXT_CUE_EVENT_CLEAR := 2
}
struct MF_TIMED_TEXT_TRACK_READY_STATE extends Int32 {
    static MF_TIMED_TEXT_TRACK_READY_STATE_NONE := 0
    static MF_TIMED_TEXT_TRACK_READY_STATE_LOADING := 1
    static MF_TIMED_TEXT_TRACK_READY_STATE_LOADED := 2
    static MF_TIMED_TEXT_TRACK_READY_STATE_ERROR := 3
}
struct MF_TIMED_TEXT_RUBY_POSITION extends Int32 {
    static MF_TIMED_TEXT_RUBY_POSITION_BEFORE := 0
    static MF_TIMED_TEXT_RUBY_POSITION_AFTER := 1
    static MF_TIMED_TEXT_RUBY_POSITION_OUTSIDE := 2
}
struct MF_TIMED_TEXT_RUBY_ALIGN extends Int32 {
    static MF_TIMED_TEXT_RUBY_ALIGN_CENTER := 0
    static MF_TIMED_TEXT_RUBY_ALIGN_START := 1
    static MF_TIMED_TEXT_RUBY_ALIGN_END := 2
    static MF_TIMED_TEXT_RUBY_ALIGN_SPACEAROUND := 3
    static MF_TIMED_TEXT_RUBY_ALIGN_SPACEBETWEEN := 4
    static MF_TIMED_TEXT_RUBY_ALIGN_WITHBASE := 5
}
struct MF_TIMED_TEXT_RUBY_RESERVE extends Int32 {
    static MF_TIMED_TEXT_RUBY_RESERVE_NONE := 0
    static MF_TIMED_TEXT_RUBY_RESERVE_BEFORE := 1
    static MF_TIMED_TEXT_RUBY_RESERVE_AFTER := 2
    static MF_TIMED_TEXT_RUBY_RESERVE_BOTH := 3
    static MF_TIMED_TEXT_RUBY_RESERVE_OUTSIDE := 4
}
struct MF_TIMED_TEXT_BOUTEN_TYPE extends Int32 {
    static MF_TIMED_TEXT_BOUTEN_TYPE_NONE := 0
    static MF_TIMED_TEXT_BOUTEN_TYPE_AUTO := 1
    static MF_TIMED_TEXT_BOUTEN_TYPE_FILLEDCIRCLE := 2
    static MF_TIMED_TEXT_BOUTEN_TYPE_OPENCIRCLE := 3
    static MF_TIMED_TEXT_BOUTEN_TYPE_FILLEDDOT := 4
    static MF_TIMED_TEXT_BOUTEN_TYPE_OPENDOT := 5
    static MF_TIMED_TEXT_BOUTEN_TYPE_FILLEDSESAME := 6
    static MF_TIMED_TEXT_BOUTEN_TYPE_OPENSESAME := 7
}
struct MF_TIMED_TEXT_BOUTEN_POSITION extends Int32 {
    static MF_TIMED_TEXT_BOUTEN_POSITION_BEFORE := 0
    static MF_TIMED_TEXT_BOUTEN_POSITION_AFTER := 1
    static MF_TIMED_TEXT_BOUTEN_POSITION_OUTSIDE := 2
}
struct IMFTimedText extends IUnknown {
    static IID := "{1F2A94C9-A3DF-430D-9D0F-ACD85DDC29AF}"
    RegisterNotifications(notify?)
      => ComCall(3, this.p, IMFTimedTextNotify, notify?)
    SelectTrack(trackId, selected)
      => ComCall(4, this.p, UInt32, trackId, BOOL, selected)
    AddDataSource(byteStream, label?, language?, kind, isDefault, trackId)
      => ComCall(5, this.p, IMFByteStream, byteStream, "Str", label?, "Str", language?, MF_TIMED_TEXT_TRACK_KIND, kind, BOOL, isDefault, UInt32.Ptr, trackId)
    AddDataSourceFromUrl(url, label?, language?, kind, isDefault, trackId)
      => ComCall(6, this.p, "Str", url, "Str", label?, "Str", language?, MF_TIMED_TEXT_TRACK_KIND, kind, BOOL, isDefault, UInt32.Ptr, trackId)
    AddTrack(label?, language?, kind, track)
      => ComCall(7, this.p, "Str", label?, "Str", language?, MF_TIMED_TEXT_TRACK_KIND, kind, IMFTimedTextTrack.Ptr, track)
    RemoveTrack(track)
      => ComCall(8, this.p, IMFTimedTextTrack, track)
    GetCueTimeOffset(offset)
      => ComCall(9, this.p, Float64.Ptr, offset)
    SetCueTimeOffset(offset)
      => ComCall(10, this.p, Float64, offset)
    GetTracks(tracks)
      => ComCall(11, this.p, IMFTimedTextTrackList.Ptr, tracks)
    GetActiveTracks(activeTracks)
      => ComCall(12, this.p, IMFTimedTextTrackList.Ptr, activeTracks)
    GetTextTracks(textTracks)
      => ComCall(13, this.p, IMFTimedTextTrackList.Ptr, textTracks)
    GetMetadataTracks(metadataTracks)
      => ComCall(14, this.p, IMFTimedTextTrackList.Ptr, metadataTracks)
    SetInBandEnabled(enabled)
      => ComCall(15, this.p, BOOL, enabled)
    IsInBandEnabled()
      => ComCall(16, this.p, BOOL)
}
struct IMFTimedTextNotify extends IUnknown {
    static IID := "{DF6B87B6-CE12-45DB-ABA7-432FE054E57D}"
    TrackAdded(trackId)
      => ComCall(3, this.p, UInt32, trackId, "void")
    TrackRemoved(trackId)
      => ComCall(4, this.p, UInt32, trackId, "void")
    TrackSelected(trackId, selected)
      => ComCall(5, this.p, UInt32, trackId, BOOL, selected, "void")
    TrackReadyStateChanged(trackId)
      => ComCall(6, this.p, UInt32, trackId, "void")
    Error(errorCode, extendedErrorCode, sourceTrackId)
      => ComCall(7, this.p, MF_TIMED_TEXT_ERROR_CODE, errorCode, HRESULT, extendedErrorCode, UInt32, sourceTrackId, "void")
    Cue(cueEvent, currentTime, cue?)
      => ComCall(8, this.p, MF_TIMED_TEXT_CUE_EVENT, cueEvent, Float64, currentTime, IMFTimedTextCue, cue?, "void")
    Reset()
      => ComCall(9, this.p, "void")
}
struct IMFTimedTextTrack extends IUnknown {
    static IID := "{8822C32D-654E-4233-BF21-D7F2E67D30D4}"
    GetId()
      => ComCall(3, this.p, UInt32)
    GetLabel(label)
      => ComCall(4, this.p, PWSTR.Ptr, label)
    SetLabel(label)
      => ComCall(5, this.p, "Str", label)
    GetLanguage(language)
      => ComCall(6, this.p, PWSTR.Ptr, language)
    GetTrackKind()
      => ComCall(7, this.p, MF_TIMED_TEXT_TRACK_KIND)
    IsInBand()
      => ComCall(8, this.p, BOOL)
    GetInBandMetadataTrackDispatchType(dispatchType)
      => ComCall(9, this.p, PWSTR.Ptr, dispatchType)
    IsActive()
      => ComCall(10, this.p, BOOL)
    GetErrorCode()
      => ComCall(11, this.p, MF_TIMED_TEXT_ERROR_CODE)
    GetExtendedErrorCode()
      => ComCall(12, this.p)
    GetDataFormat(format)
      => ComCall(13, this.p, GUID.Ptr, format)
    GetReadyState()
      => ComCall(14, this.p, MF_TIMED_TEXT_TRACK_READY_STATE)
    GetCueList(cues)
      => ComCall(15, this.p, IMFTimedTextCueList.Ptr, cues)
}
struct IMFTimedTextTrackList extends IUnknown {
    static IID := "{23FF334C-442C-445F-BCCC-EDC438AA11E2}"
    GetLength()
      => ComCall(3, this.p, UInt32)
    GetTrack(index, track)
      => ComCall(4, this.p, UInt32, index, IMFTimedTextTrack.Ptr, track)
    GetTrackById(trackId, track)
      => ComCall(5, this.p, UInt32, trackId, IMFTimedTextTrack.Ptr, track)
}
struct IMFTimedTextCue extends IUnknown {
    static IID := "{1E560447-9A2B-43E1-A94C-B0AAABFBFBC9}"
    GetId()
      => ComCall(3, this.p, UInt32)
    GetOriginalId(originalId)
      => ComCall(4, this.p, PWSTR.Ptr, originalId)
    GetCueKind()
      => ComCall(5, this.p, MF_TIMED_TEXT_TRACK_KIND)
    GetStartTime()
      => ComCall(6, this.p, Float64)
    GetDuration()
      => ComCall(7, this.p, Float64)
    GetTrackId()
      => ComCall(8, this.p, UInt32)
    GetData(data)
      => ComCall(9, this.p, IMFTimedTextBinary.Ptr, data)
    GetRegion(region)
      => ComCall(10, this.p, IMFTimedTextRegion.Ptr, region)
    GetStyle(style)
      => ComCall(11, this.p, IMFTimedTextStyle.Ptr, style)
    GetLineCount()
      => ComCall(12, this.p, UInt32)
    GetLine(index, line)
      => ComCall(13, this.p, UInt32, index, IMFTimedTextFormattedText.Ptr, line)
}
struct IMFTimedTextFormattedText extends IUnknown {
    static IID := "{E13AF3C1-4D47-4354-B1F5-E83AE0ECAE60}"
    GetText(text)
      => ComCall(3, this.p, PWSTR.Ptr, text)
    GetSubformattingCount()
      => ComCall(4, this.p, UInt32)
    GetSubformatting(index, firstChar, charLength, style)
      => ComCall(5, this.p, UInt32, index, UInt32.Ptr, firstChar, UInt32.Ptr, charLength, IMFTimedTextStyle.Ptr, style)
}
struct IMFTimedTextStyle extends IUnknown {
    static IID := "{09B2455D-B834-4F01-A347-9052E21C450E}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    IsExternal()
      => ComCall(4, this.p, BOOL)
    GetFontFamily(fontFamily)
      => ComCall(5, this.p, PWSTR.Ptr, fontFamily)
    GetFontSize(fontSize, unitType)
      => ComCall(6, this.p, Float64.Ptr, fontSize, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
    GetColor(color)
      => ComCall(7, this.p, MFARGB.Ptr, color)
    GetBackgroundColor(bgColor)
      => ComCall(8, this.p, MFARGB.Ptr, bgColor)
    GetShowBackgroundAlways(showBackgroundAlways)
      => ComCall(9, this.p, BOOL.Ptr, showBackgroundAlways)
    GetFontStyle(fontStyle)
      => ComCall(10, this.p, MF_TIMED_TEXT_FONT_STYLE.Ptr, fontStyle)
    GetBold(bold)
      => ComCall(11, this.p, BOOL.Ptr, bold)
    GetRightToLeft(rightToLeft)
      => ComCall(12, this.p, BOOL.Ptr, rightToLeft)
    GetTextAlignment(textAlign)
      => ComCall(13, this.p, MF_TIMED_TEXT_ALIGNMENT.Ptr, textAlign)
    GetTextDecoration(textDecoration)
      => ComCall(14, this.p, UInt32.Ptr, textDecoration)
    GetTextOutline(color, thickness, blurRadius, unitType)
      => ComCall(15, this.p, MFARGB.Ptr, color, Float64.Ptr, thickness, Float64.Ptr, blurRadius, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
}
struct IMFTimedTextRegion extends IUnknown {
    static IID := "{C8D22AFC-BC47-4BDF-9B04-787E49CE3F58}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetPosition(pX, pY, unitType)
      => ComCall(4, this.p, Float64.Ptr, pX, Float64.Ptr, pY, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
    GetExtent(pWidth, pHeight, unitType)
      => ComCall(5, this.p, Float64.Ptr, pWidth, Float64.Ptr, pHeight, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
    GetBackgroundColor(bgColor)
      => ComCall(6, this.p, MFARGB.Ptr, bgColor)
    GetWritingMode(writingMode)
      => ComCall(7, this.p, MF_TIMED_TEXT_WRITING_MODE.Ptr, writingMode)
    GetDisplayAlignment(displayAlign)
      => ComCall(8, this.p, MF_TIMED_TEXT_DISPLAY_ALIGNMENT.Ptr, displayAlign)
    GetLineHeight(pLineHeight, unitType)
      => ComCall(9, this.p, Float64.Ptr, pLineHeight, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
    GetClipOverflow(clipOverflow)
      => ComCall(10, this.p, BOOL.Ptr, clipOverflow)
    GetPadding(before, start, after, end, unitType)
      => ComCall(11, this.p, Float64.Ptr, before, Float64.Ptr, start, Float64.Ptr, after, Float64.Ptr, end, MF_TIMED_TEXT_UNIT_TYPE.Ptr, unitType)
    GetWrap(wrap)
      => ComCall(12, this.p, BOOL.Ptr, wrap)
    GetZIndex(zIndex)
      => ComCall(13, this.p, Int32.Ptr, zIndex)
    GetScrollMode(scrollMode)
      => ComCall(14, this.p, MF_TIMED_TEXT_SCROLL_MODE.Ptr, scrollMode)
}
struct IMFTimedTextBinary extends IUnknown {
    static IID := "{4AE3A412-0545-43C4-BF6F-6B97A5C6C432}"
    GetData(data, length)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, data, UInt32.Ptr, length)
}
struct IMFTimedTextCueList extends IUnknown {
    static IID := "{AD128745-211B-40A0-9981-FE65F166D0FD}"
    GetLength()
      => ComCall(3, this.p, UInt32)
    GetCueByIndex(index, cue)
      => ComCall(4, this.p, UInt32, index, IMFTimedTextCue.Ptr, cue)
    GetCueById(id, cue)
      => ComCall(5, this.p, UInt32, id, IMFTimedTextCue.Ptr, cue)
    GetCueByOriginalId(originalId, cue)
      => ComCall(6, this.p, "Str", originalId, IMFTimedTextCue.Ptr, cue)
    AddTextCue(start, duration, text, cue?)
      => ComCall(7, this.p, Float64, start, Float64, duration, "Str", text, IMFTimedTextCue.Ptr, cue?)
    AddDataCue(start, duration, data, cue?)
      => ComCall(8, this.p, Float64, start, Float64, duration, UInt8.Ptr, data, UInt32, data.Size, IMFTimedTextCue.Ptr, cue?)
    RemoveCue(cue)
      => ComCall(9, this.p, IMFTimedTextCue, cue)
}
struct IMFTimedTextRuby extends IUnknown {
    static IID := "{76C6A6F5-4955-4DE5-B27B-14B734CC14B4}"
    GetRubyText(rubyText)
      => ComCall(3, this.p, PWSTR.Ptr, rubyText)
    GetRubyPosition(value)
      => ComCall(4, this.p, MF_TIMED_TEXT_RUBY_POSITION.Ptr, value)
    GetRubyAlign(value)
      => ComCall(5, this.p, MF_TIMED_TEXT_RUBY_ALIGN.Ptr, value)
    GetRubyReserve(value)
      => ComCall(6, this.p, MF_TIMED_TEXT_RUBY_RESERVE.Ptr, value)
}
struct IMFTimedTextBouten extends IUnknown {
    static IID := "{3C5F3E8A-90C0-464E-8136-898D2975F847}"
    GetBoutenType(value)
      => ComCall(3, this.p, MF_TIMED_TEXT_BOUTEN_TYPE.Ptr, value)
    GetBoutenColor(value)
      => ComCall(4, this.p, MFARGB.Ptr, value)
    GetBoutenPosition(value)
      => ComCall(5, this.p, MF_TIMED_TEXT_BOUTEN_POSITION.Ptr, value)
}
struct IMFTimedTextStyle2 extends IUnknown {
    static IID := "{DB639199-C809-4C89-BFCA-D0BBB9729D6E}"
    GetRuby(ruby)
      => ComCall(3, this.p, IMFTimedTextRuby.Ptr, ruby)
    GetBouten(bouten)
      => ComCall(4, this.p, IMFTimedTextBouten.Ptr, bouten)
    IsTextCombined(value)
      => ComCall(5, this.p, BOOL.Ptr, value)
    GetFontAngleInDegrees(value)
      => ComCall(6, this.p, Float64.Ptr, value)
}
struct MF_MEDIA_ENGINE_STREAMTYPE_FAILED extends Int32 {
    static MF_MEDIA_ENGINE_STREAMTYPE_FAILED_UNKNOWN := 0
    static MF_MEDIA_ENGINE_STREAMTYPE_FAILED_AUDIO := 1
    static MF_MEDIA_ENGINE_STREAMTYPE_FAILED_VIDEO := 2
}
struct IMFMediaEngineEMENotify extends IUnknown {
    static IID := "{9E184D15-CDB7-4F86-B49E-566689F4A601}"
    Encrypted(pbInitData?, bstrInitDataType)
      => ComCall(3, this.p, UInt8.Ptr, pbInitData?, UInt32, pbInitData?.Size ?? 0, BSTR, bstrInitDataType, "void")
    WaitingForKey()
      => ComCall(4, this.p, "void")
}
struct MF_MEDIAKEYS_REQUIREMENT extends Int32 {
    static MF_MEDIAKEYS_REQUIREMENT_REQUIRED := 1
    static MF_MEDIAKEYS_REQUIREMENT_OPTIONAL := 2
    static MF_MEDIAKEYS_REQUIREMENT_NOT_ALLOWED := 3
}
struct IMFMediaKeySessionNotify2 extends IMFMediaKeySessionNotify {
    static IID := "{C3A9E92A-DA88-46B0-A110-6CF953026CB9}"
    KeyMessage2(eMessageType, destinationURL?, pbMessage)
      => ComCall(6, this.p, MF_MEDIAKEYSESSION_MESSAGETYPE, eMessageType, BSTR, destinationURL?, UInt8.Ptr, pbMessage, UInt32, pbMessage.Size, "void")
    KeyStatusChange()
      => ComCall(7, this.p, "void")
}
struct IMFMediaKeySystemAccess extends IUnknown {
    static IID := "{AEC63FDA-7A97-4944-B35C-6C6DF8085CC3}"
    CreateMediaKeys(pCdmCustomConfig?, ppKeys)
      => ComCall(3, this.p, IPropertyStore, pCdmCustomConfig?, IMFMediaKeys2.Ptr, ppKeys)
    get_SupportedConfiguration(ppSupportedConfiguration)
      => ComCall(4, this.p, IPropertyStore.Ptr, ppSupportedConfiguration)
    get_KeySystem(pKeySystem)
      => ComCall(5, this.p, BSTR.Ptr, pKeySystem)
}
struct IMFMediaEngineClassFactory3 extends IUnknown {
    static IID := "{3787614F-65F7-4003-B673-EAD8293A0E60}"
    CreateMediaKeySystemAccess(keySystem, ppSupportedConfigurationsArray, ppKeyAccess)
      => ComCall(3, this.p, BSTR, keySystem, IPropertyStore.Ptr, ppSupportedConfigurationsArray, UInt32, ppSupportedConfigurationsArray.Length, IMFMediaKeySystemAccess.Ptr, ppKeyAccess)
}
struct IMFMediaKeys2 extends IMFMediaKeys {
    static IID := "{45892507-AD66-4DE2-83A2-ACBB13CD8D43}"
    CreateSession2(eSessionType, pMFMediaKeySessionNotify2, ppSession)
      => ComCall(7, this.p, MF_MEDIAKEYSESSION_TYPE, eSessionType, IMFMediaKeySessionNotify2, pMFMediaKeySessionNotify2, IMFMediaKeySession2.Ptr, ppSession)
    SetServerCertificate(pbServerCertificate?)
      => ComCall(8, this.p, UInt8.Ptr, pbServerCertificate?, UInt32, pbServerCertificate?.Size ?? 0)
    GetDOMException(systemCode, code)
      => ComCall(9, this.p, HRESULT, systemCode, HRESULT.Ptr, code)
}
struct IMFMediaKeySession2 extends IMFMediaKeySession {
    static IID := "{E9707E05-6D55-4636-B185-3DE21210BD75}"
    get_KeyStatuses(pKeyStatusesArray, puSize)
      => ComCall(8, this.p, MFMediaKeyStatus.Ptr.Ptr, pKeyStatusesArray, UInt32.Ptr, puSize)
    Load(bstrSessionId, pfLoaded)
      => ComCall(9, this.p, BSTR, bstrSessionId, BOOL.Ptr, pfLoaded)
    GenerateRequest(initDataType, pbInitData)
      => ComCall(10, this.p, BSTR, initDataType, UInt8.Ptr, pbInitData, UInt32, pbInitData.Size)
    get_Expiration(dblExpiration)
      => ComCall(11, this.p, Float64.Ptr, dblExpiration)
    Remove()
      => ComCall(12, this.p)
    Shutdown()
      => ComCall(13, this.p)
}
struct IMFMediaEngineClassFactory4 extends IUnknown {
    static IID := "{FBE256C1-43CF-4A9B-8CB8-CE8632A34186}"
    CreateContentDecryptionModuleFactory(keySystem, riid, ppvObject)
      => ComCall(3, this.p, "Str", keySystem, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct IMFDLNASinkInit extends IUnknown {
    static IID := "{0C012799-1B61-4C10-BDA9-04445BE5F561}"
    Initialize(pByteStream, fPal)
      => ComCall(3, this.p, IMFByteStream, pByteStream, BOOL, fPal)
}
struct MFMPEG2DLNASINKSTATS {
    cBytesWritten : Int64
    fPAL : BOOL
    fccVideo : UInt32
    dwVideoWidth : UInt32
    dwVideoHeight : UInt32
    cVideoFramesReceived : Int64
    cVideoFramesEncoded : Int64
    cVideoFramesSkipped : Int64
    cBlackVideoFramesEncoded : Int64
    cVideoFramesDuplicated : Int64
    cAudioSamplesPerSec : UInt32
    cAudioChannels : UInt32
    cAudioBytesReceived : Int64
    cAudioFramesEncoded : Int64
}
struct IMFReadWriteClassFactory extends IUnknown {
    static IID := "{E7FE2E12-661C-40DA-92F9-4F002AB67627}"
    CreateInstanceFromURL(clsid, pwszURL, pAttributes?, riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, clsid, "Str", pwszURL, IMFAttributes, pAttributes?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    CreateInstanceFromObject(clsid, punkObject, pAttributes?, riid, ppvObject)
      => ComCall(4, this.p, GUID.Ptr, clsid, IUnknown, punkObject, IMFAttributes, pAttributes?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct MF_SOURCE_READER_FLAG extends Int32 {
    static MF_SOURCE_READERF_ERROR := 1
    static MF_SOURCE_READERF_ENDOFSTREAM := 2
    static MF_SOURCE_READERF_NEWSTREAM := 4
    static MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED := 16
    static MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED := 32
    static MF_SOURCE_READERF_STREAMTICK := 256
    static MF_SOURCE_READERF_ALLEFFECTSREMOVED := 512
}
struct MF_SOURCE_READER_CONTROL_FLAG extends Int32 {
    static MF_SOURCE_READER_CONTROLF_DRAIN := 1
}
struct MF_SOURCE_READER_CONSTANTS extends Int32 {
    static MF_SOURCE_READER_INVALID_STREAM_INDEX := -1
    static MF_SOURCE_READER_ALL_STREAMS := -2
    static MF_SOURCE_READER_ANY_STREAM := -2
    static MF_SOURCE_READER_FIRST_AUDIO_STREAM := -3
    static MF_SOURCE_READER_FIRST_VIDEO_STREAM := -4
    static MF_SOURCE_READER_MEDIASOURCE := -1
}
struct MF_SOURCE_READER_CURRENT_TYPE_CONSTANTS extends Int32 {
    static MF_SOURCE_READER_CURRENT_TYPE_INDEX := -1
}
struct IMFSourceReader extends IUnknown {
    static IID := "{70AE66F2-C809-4E4F-8915-BDCB406B7993}"
    GetStreamSelection(dwStreamIndex, pfSelected)
      => ComCall(3, this.p, UInt32, dwStreamIndex, BOOL.Ptr, pfSelected)
    SetStreamSelection(dwStreamIndex, fSelected)
      => ComCall(4, this.p, UInt32, dwStreamIndex, BOOL, fSelected)
    GetNativeMediaType(dwStreamIndex, dwMediaTypeIndex, ppMediaType)
      => ComCall(5, this.p, UInt32, dwStreamIndex, UInt32, dwMediaTypeIndex, IMFMediaType.Ptr, ppMediaType)
    GetCurrentMediaType(dwStreamIndex, ppMediaType)
      => ComCall(6, this.p, UInt32, dwStreamIndex, IMFMediaType.Ptr, ppMediaType)
    SetCurrentMediaType(dwStreamIndex, pMediaType)
      => ComCall(7, this.p, UInt32, dwStreamIndex, "Ptr", 0, IMFMediaType, pMediaType)
    SetCurrentPosition(guidTimeFormat, varPosition)
      => ComCall(8, this.p, GUID.Ptr, guidTimeFormat, PROPVARIANT.Ptr, varPosition)
    ReadSample(dwStreamIndex, dwControlFlags, pdwActualStreamIndex?, pdwStreamFlags?, pllTimestamp?, ppSample?)
      => ComCall(9, this.p, UInt32, dwStreamIndex, UInt32, dwControlFlags, UInt32.Ptr, pdwActualStreamIndex?, UInt32.Ptr, pdwStreamFlags?, Int64.Ptr, pllTimestamp?, IMFSample.Ptr, ppSample?)
    Flush(dwStreamIndex)
      => ComCall(10, this.p, UInt32, dwStreamIndex)
    GetServiceForStream(dwStreamIndex, guidService, riid, ppvObject)
      => ComCall(11, this.p, UInt32, dwStreamIndex, GUID.Ptr, guidService, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetPresentationAttribute(dwStreamIndex, guidAttribute, pvarAttribute)
      => ComCall(12, this.p, UInt32, dwStreamIndex, GUID.Ptr, guidAttribute, PROPVARIANT.Ptr, pvarAttribute)
}
struct IMFSourceReaderEx extends IMFSourceReader {
    static IID := "{7B981CF0-560E-4116-9875-B099895F23D7}"
    SetNativeMediaType(dwStreamIndex, pMediaType?, pdwStreamFlags)
      => ComCall(13, this.p, UInt32, dwStreamIndex, IMFMediaType, pMediaType?, UInt32.Ptr, pdwStreamFlags)
    AddTransformForStream(dwStreamIndex, pTransformOrActivate)
      => ComCall(14, this.p, UInt32, dwStreamIndex, IUnknown, pTransformOrActivate)
    RemoveAllTransformsForStream(dwStreamIndex)
      => ComCall(15, this.p, UInt32, dwStreamIndex)
    GetTransformForStream(dwStreamIndex, dwTransformIndex, pGuidCategory?, ppTransform)
      => ComCall(16, this.p, UInt32, dwStreamIndex, UInt32, dwTransformIndex, GUID.Ptr, pGuidCategory?, IMFTransform.Ptr, ppTransform)
}
struct IMFSourceReaderCallback extends IUnknown {
    static IID := "{DEEC8D99-FA1D-4D82-84C2-2C8969944867}"
    OnReadSample(hrStatus, dwStreamIndex, dwStreamFlags, llTimestamp, pSample?)
      => ComCall(3, this.p, HRESULT, hrStatus, UInt32, dwStreamIndex, UInt32, dwStreamFlags, Int64, llTimestamp, IMFSample, pSample?)
    OnFlush(dwStreamIndex)
      => ComCall(4, this.p, UInt32, dwStreamIndex)
    OnEvent(dwStreamIndex, pEvent)
      => ComCall(5, this.p, UInt32, dwStreamIndex, IMFMediaEvent, pEvent)
}
struct IMFSourceReaderCallback2 extends IMFSourceReaderCallback {
    static IID := "{CF839FE6-8C2A-4DD2-B6EA-C22D6961AF05}"
    OnTransformChange()
      => ComCall(6, this.p)
    OnStreamError(dwStreamIndex, hrStatus)
      => ComCall(7, this.p, UInt32, dwStreamIndex, HRESULT, hrStatus)
}
struct MF_SINK_WRITER_CONSTANTS extends UInt32 {
    static MF_SINK_WRITER_INVALID_STREAM_INDEX := 4294967295
    static MF_SINK_WRITER_ALL_STREAMS := 4294967294
    static MF_SINK_WRITER_MEDIASINK := 4294967295
}
struct MF_SINK_WRITER_STATISTICS {
    cb : UInt32
    llLastTimestampReceived : Int64
    llLastTimestampEncoded : Int64
    llLastTimestampProcessed : Int64
    llLastStreamTickReceived : Int64
    llLastSinkSampleRequest : Int64
    qwNumSamplesReceived : Int64
    qwNumSamplesEncoded : Int64
    qwNumSamplesProcessed : Int64
    qwNumStreamTicksReceived : Int64
    dwByteCountQueued : UInt32
    qwByteCountProcessed : Int64
    dwNumOutstandingSinkSampleRequests : UInt32
    dwAverageSampleRateReceived : UInt32
    dwAverageSampleRateEncoded : UInt32
    dwAverageSampleRateProcessed : UInt32
}
struct IMFSinkWriter extends IUnknown {
    static IID := "{3137F1CD-FE5E-4805-A5D8-FB477448CB3D}"
    AddStream(pTargetMediaType, pdwStreamIndex)
      => ComCall(3, this.p, IMFMediaType, pTargetMediaType, UInt32.Ptr, pdwStreamIndex)
    SetInputMediaType(dwStreamIndex, pInputMediaType, pEncodingParameters?)
      => ComCall(4, this.p, UInt32, dwStreamIndex, IMFMediaType, pInputMediaType, IMFAttributes, pEncodingParameters?)
    BeginWriting()
      => ComCall(5, this.p)
    WriteSample(dwStreamIndex, pSample)
      => ComCall(6, this.p, UInt32, dwStreamIndex, IMFSample, pSample)
    SendStreamTick(dwStreamIndex, llTimestamp)
      => ComCall(7, this.p, UInt32, dwStreamIndex, Int64, llTimestamp)
    PlaceMarker(dwStreamIndex, pvContext)
      => ComCall(8, this.p, UInt32, dwStreamIndex, Struct.Ptr, pvContext)
    NotifyEndOfSegment(dwStreamIndex)
      => ComCall(9, this.p, UInt32, dwStreamIndex)
    Flush(dwStreamIndex)
      => ComCall(10, this.p, UInt32, dwStreamIndex)
    Finalize()
      => ComCall(11, this.p)
    GetServiceForStream(dwStreamIndex, guidService, riid, ppvObject)
      => ComCall(12, this.p, UInt32, dwStreamIndex, GUID.Ptr, guidService, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetStatistics(dwStreamIndex, pStats)
      => ComCall(13, this.p, UInt32, dwStreamIndex, MF_SINK_WRITER_STATISTICS.Ptr, pStats)
}
struct IMFSinkWriterEx extends IMFSinkWriter {
    static IID := "{588D72AB-5BC1-496A-8714-B70617141B25}"
    GetTransformForStream(dwStreamIndex, dwTransformIndex, pGuidCategory?, ppTransform)
      => ComCall(14, this.p, UInt32, dwStreamIndex, UInt32, dwTransformIndex, GUID.Ptr, pGuidCategory?, IMFTransform.Ptr, ppTransform)
}
struct IMFSinkWriterEncoderConfig extends IUnknown {
    static IID := "{17C3779E-3CDE-4EDE-8C60-3899F5F53AD6}"
    SetTargetMediaType(dwStreamIndex, pTargetMediaType, pEncodingParameters?)
      => ComCall(3, this.p, UInt32, dwStreamIndex, IMFMediaType, pTargetMediaType, IMFAttributes, pEncodingParameters?)
    PlaceEncodingParameters(dwStreamIndex, pEncodingParameters)
      => ComCall(4, this.p, UInt32, dwStreamIndex, IMFAttributes, pEncodingParameters)
}
struct IMFSinkWriterCallback extends IUnknown {
    static IID := "{666F76DE-33D2-41B9-A458-29ED0A972C58}"
    OnFinalize(hrStatus)
      => ComCall(3, this.p, HRESULT, hrStatus)
    OnMarker(dwStreamIndex, pvContext)
      => ComCall(4, this.p, UInt32, dwStreamIndex, Struct.Ptr, pvContext)
}
struct IMFSinkWriterCallback2 extends IMFSinkWriterCallback {
    static IID := "{2456BD58-C067-4513-84FE-8D0C88FFDC61}"
    OnTransformChange()
      => ComCall(5, this.p)
    OnStreamError(dwStreamIndex, hrStatus)
      => ComCall(6, this.p, UInt32, dwStreamIndex, HRESULT, hrStatus)
}
struct IMFVideoPositionMapper extends IUnknown {
    static IID := "{1F6A9F17-E70B-4E24-8AE4-0B2C3BA7A4AE}"
    MapOutputCoordinateToInputStream(xOut, yOut, dwOutputStreamIndex, dwInputStreamIndex, pxIn, pyIn)
      => ComCall(3, this.p, Float32, xOut, Float32, yOut, UInt32, dwOutputStreamIndex, UInt32, dwInputStreamIndex, Float32.Ptr, pxIn, Float32.Ptr, pyIn)
}
struct IMFVideoDeviceID extends IUnknown {
    static IID := "{A38D9567-5A9C-4F3C-B293-8EB415B279BA}"
    GetDeviceID(pDeviceID)
      => ComCall(3, this.p, GUID.Ptr, pDeviceID)
}
struct MFVideoAspectRatioMode extends Int32 {
    static MFVideoARMode_None := 0
    static MFVideoARMode_PreservePicture := 1
    static MFVideoARMode_PreservePixel := 2
    static MFVideoARMode_NonLinearStretch := 4
    static MFVideoARMode_Mask := 7
}
struct MFVideoRenderPrefs extends Int32 {
    static MFVideoRenderPrefs_DoNotRenderBorder := 1
    static MFVideoRenderPrefs_DoNotClipToDevice := 2
    static MFVideoRenderPrefs_AllowOutputThrottling := 4
    static MFVideoRenderPrefs_ForceOutputThrottling := 8
    static MFVideoRenderPrefs_ForceBatching := 16
    static MFVideoRenderPrefs_AllowBatching := 32
    static MFVideoRenderPrefs_ForceScaling := 64
    static MFVideoRenderPrefs_AllowScaling := 128
    static MFVideoRenderPrefs_DoNotRepaintOnStop := 256
    static MFVideoRenderPrefs_Mask := 511
}
struct IMFVideoDisplayControl extends IUnknown {
    static IID := "{A490B1E4-AB84-4D31-A1B2-181E03B1077A}"
    GetNativeVideoSize(pszVideo, pszARVideo)
      => ComCall(3, this.p, SIZE.Ptr, pszVideo, SIZE.Ptr, pszARVideo)
    GetIdealVideoSize(pszMin, pszMax)
      => ComCall(4, this.p, SIZE.Ptr, pszMin, SIZE.Ptr, pszMax)
    SetVideoPosition(pnrcSource, prcDest)
      => ComCall(5, this.p, MFVideoNormalizedRect.Ptr, pnrcSource, RECT.Ptr, prcDest)
    GetVideoPosition(pnrcSource, prcDest)
      => ComCall(6, this.p, MFVideoNormalizedRect.Ptr, pnrcSource, RECT.Ptr, prcDest)
    SetAspectRatioMode(dwAspectRatioMode)
      => ComCall(7, this.p, UInt32, dwAspectRatioMode)
    GetAspectRatioMode(pdwAspectRatioMode)
      => ComCall(8, this.p, UInt32.Ptr, pdwAspectRatioMode)
    SetVideoWindow(hwndVideo)
      => ComCall(9, this.p, HWND, hwndVideo)
    GetVideoWindow(phwndVideo)
      => ComCall(10, this.p, HWND.Ptr, phwndVideo)
    RepaintVideo()
      => ComCall(11, this.p)
    GetCurrentImage(pBih, pDib, pTimeStamp)
      => ComCall(12, this.p, BITMAPINFOHEADER.Ptr, pBih, UInt8.Ptr.Ptr, pDib, UInt32.Ptr, pDib.Length, Int64.Ptr, pTimeStamp)
    SetBorderColor(Clr)
      => ComCall(13, this.p, COLORREF, Clr)
    GetBorderColor(pClr)
      => ComCall(14, this.p, COLORREF.Ptr, pClr)
    SetRenderingPrefs(dwRenderFlags)
      => ComCall(15, this.p, UInt32, dwRenderFlags)
    GetRenderingPrefs(pdwRenderFlags)
      => ComCall(16, this.p, UInt32.Ptr, pdwRenderFlags)
    SetFullscreen(fFullscreen)
      => ComCall(17, this.p, BOOL, fFullscreen)
    GetFullscreen(pfFullscreen)
      => ComCall(18, this.p, BOOL.Ptr, pfFullscreen)
}
struct MFVP_MESSAGE_TYPE extends Int32 {
    static MFVP_MESSAGE_FLUSH := 0
    static MFVP_MESSAGE_INVALIDATEMEDIATYPE := 1
    static MFVP_MESSAGE_PROCESSINPUTNOTIFY := 2
    static MFVP_MESSAGE_BEGINSTREAMING := 3
    static MFVP_MESSAGE_ENDSTREAMING := 4
    static MFVP_MESSAGE_ENDOFSTREAM := 5
    static MFVP_MESSAGE_STEP := 6
    static MFVP_MESSAGE_CANCELSTEP := 7
}
struct IMFVideoPresenter extends IMFClockStateSink {
    static IID := "{29AFF080-182A-4A5D-AF3B-448F3A6346CB}"
    ProcessMessage(eMessage, ulParam)
      => ComCall(8, this.p, MFVP_MESSAGE_TYPE, eMessage, IntPtr, ulParam)
    GetCurrentMediaType(ppMediaType)
      => ComCall(9, this.p, IMFVideoMediaType.Ptr, ppMediaType)
}
struct IMFDesiredSample extends IUnknown {
    static IID := "{56C294D0-753E-4260-8D61-A3D8820B1D54}"
    GetDesiredSampleTimeAndDuration(phnsSampleTime, phnsSampleDuration)
      => ComCall(3, this.p, Int64.Ptr, phnsSampleTime, Int64.Ptr, phnsSampleDuration)
    SetDesiredSampleTimeAndDuration(hnsSampleTime, hnsSampleDuration)
      => ComCall(4, this.p, Int64, hnsSampleTime, Int64, hnsSampleDuration, "void")
    Clear()
      => ComCall(5, this.p, "void")
}
struct IMFVideoMixerControl extends IUnknown {
    static IID := "{A5C6C53F-C202-4AA5-9695-175BA8C508A5}"
    SetStreamZOrder(dwStreamID, dwZ)
      => ComCall(3, this.p, UInt32, dwStreamID, UInt32, dwZ)
    GetStreamZOrder(dwStreamID, pdwZ)
      => ComCall(4, this.p, UInt32, dwStreamID, UInt32.Ptr, pdwZ)
    SetStreamOutputRect(dwStreamID, pnrcOutput)
      => ComCall(5, this.p, UInt32, dwStreamID, MFVideoNormalizedRect.Ptr, pnrcOutput)
    GetStreamOutputRect(dwStreamID, pnrcOutput)
      => ComCall(6, this.p, UInt32, dwStreamID, MFVideoNormalizedRect.Ptr, pnrcOutput)
}
struct MFVideoMixPrefs extends Int32 {
    static MFVideoMixPrefs_ForceHalfInterlace := 1
    static MFVideoMixPrefs_AllowDropToHalfInterlace := 2
    static MFVideoMixPrefs_AllowDropToBob := 4
    static MFVideoMixPrefs_ForceBob := 8
    static MFVideoMixPrefs_EnableRotation := 16
    static MFVideoMixPrefs_Mask := 31
}
struct IMFVideoMixerControl2 extends IMFVideoMixerControl {
    static IID := "{8459616D-966E-4930-B658-54FA7E5A16D3}"
    SetMixingPrefs(dwMixFlags)
      => ComCall(7, this.p, UInt32, dwMixFlags)
    GetMixingPrefs(pdwMixFlags)
      => ComCall(8, this.p, UInt32.Ptr, pdwMixFlags)
}
struct IMFVideoRenderer extends IUnknown {
    static IID := "{DFDFD197-A9CA-43D8-B341-6AF3503792CD}"
    InitializeRenderer(pVideoMixer?, pVideoPresenter?)
      => ComCall(3, this.p, IMFTransform, pVideoMixer?, IMFVideoPresenter, pVideoPresenter?)
}
struct IEVRFilterConfig extends IUnknown {
    static IID := "{83E91E85-82C1-4EA7-801D-85DC50B75086}"
    SetNumberOfStreams(dwMaxStreams)
      => ComCall(3, this.p, UInt32, dwMaxStreams)
    GetNumberOfStreams(pdwMaxStreams)
      => ComCall(4, this.p, UInt32.Ptr, pdwMaxStreams)
}
struct EVRFilterConfigPrefs extends Int32 {
    static EVRFilterConfigPrefs_EnableQoS := 1
    static EVRFilterConfigPrefs_Mask := 1
}
struct IEVRFilterConfigEx extends IEVRFilterConfig {
    static IID := "{AEA36028-796D-454F-BEEE-B48071E24304}"
    SetConfigPrefs(dwConfigFlags)
      => ComCall(5, this.p, UInt32, dwConfigFlags)
    GetConfigPrefs(pdwConfigFlags)
      => ComCall(6, this.p, UInt32.Ptr, pdwConfigFlags)
}
struct MF_SERVICE_LOOKUP_TYPE extends Int32 {
    static MF_SERVICE_LOOKUP_UPSTREAM := 0
    static MF_SERVICE_LOOKUP_UPSTREAM_DIRECT := 1
    static MF_SERVICE_LOOKUP_DOWNSTREAM := 2
    static MF_SERVICE_LOOKUP_DOWNSTREAM_DIRECT := 3
    static MF_SERVICE_LOOKUP_ALL := 4
    static MF_SERVICE_LOOKUP_GLOBAL := 5
}
struct IMFTopologyServiceLookup extends IUnknown {
    static IID := "{FA993889-4383-415A-A930-DD472A8CF6F7}"
    LookupService(Type, dwIndex, guidService, riid, ppvObjects, pnObjects)
      => ComCall(3, this.p, MF_SERVICE_LOOKUP_TYPE, Type, UInt32, dwIndex, GUID.Ptr, guidService, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObjects, UInt32.Ptr, pnObjects)
}
struct IMFTopologyServiceLookupClient extends IUnknown {
    static IID := "{FA99388A-4383-415A-A930-DD472A8CF6F7}"
    InitServicePointers(pLookup)
      => ComCall(3, this.p, IMFTopologyServiceLookup, pLookup)
    ReleaseServicePointers()
      => ComCall(4, this.p)
}
struct IEVRTrustedVideoPlugin extends IUnknown {
    static IID := "{83A4CE40-7710-494B-A893-A472049AF630}"
    IsInTrustedVideoMode(pYes)
      => ComCall(3, this.p, BOOL.Ptr, pYes)
    CanConstrict(pYes)
      => ComCall(4, this.p, BOOL.Ptr, pYes)
    SetConstriction(dwKPix)
      => ComCall(5, this.p, UInt32, dwKPix)
    DisableImageExport(bDisable)
      => ComCall(6, this.p, BOOL, bDisable)
}
struct MFP_CREATION_OPTIONS extends Int32 {
    static MFP_OPTION_NONE := 0
    static MFP_OPTION_FREE_THREADED_CALLBACK := 1
    static MFP_OPTION_NO_MMCSS := 2
    static MFP_OPTION_NO_REMOTE_DESKTOP_OPTIMIZATION := 4
}
struct MFP_MEDIAPLAYER_STATE extends Int32 {
    static MFP_MEDIAPLAYER_STATE_EMPTY := 0
    static MFP_MEDIAPLAYER_STATE_STOPPED := 1
    static MFP_MEDIAPLAYER_STATE_PLAYING := 2
    static MFP_MEDIAPLAYER_STATE_PAUSED := 3
    static MFP_MEDIAPLAYER_STATE_SHUTDOWN := 4
}
struct MFP_MEDIAITEM_CHARACTERISTICS extends Int32 {
    static MFP_MEDIAITEM_IS_LIVE := 1
    static MFP_MEDIAITEM_CAN_SEEK := 2
    static MFP_MEDIAITEM_CAN_PAUSE := 4
    static MFP_MEDIAITEM_HAS_SLOW_SEEK := 8
}
struct MFP_CREDENTIAL_FLAGS extends Int32 {
    static MFP_CREDENTIAL_PROMPT := 1
    static MFP_CREDENTIAL_SAVE := 2
    static MFP_CREDENTIAL_DO_NOT_CACHE := 4
    static MFP_CREDENTIAL_CLEAR_TEXT := 8
    static MFP_CREDENTIAL_PROXY := 16
    static MFP_CREDENTIAL_LOGGED_ON_USER := 32
}
struct IMFPMediaPlayer extends IUnknown {
    static IID := "{A714590A-58AF-430A-85BF-44F5EC838D85}"
    Play()
      => ComCall(3, this.p)
    Pause()
      => ComCall(4, this.p)
    Stop()
      => ComCall(5, this.p)
    FrameStep()
      => ComCall(6, this.p)
    SetPosition(guidPositionType, pvPositionValue)
      => ComCall(7, this.p, GUID.Ptr, guidPositionType, PROPVARIANT.Ptr, pvPositionValue)
    GetPosition(guidPositionType, pvPositionValue)
      => ComCall(8, this.p, GUID.Ptr, guidPositionType, PROPVARIANT.Ptr, pvPositionValue)
    GetDuration(guidPositionType, pvDurationValue)
      => ComCall(9, this.p, GUID.Ptr, guidPositionType, PROPVARIANT.Ptr, pvDurationValue)
    SetRate(flRate)
      => ComCall(10, this.p, Float32, flRate)
    GetRate(pflRate)
      => ComCall(11, this.p, Float32.Ptr, pflRate)
    GetSupportedRates(fForwardDirection, pflSlowestRate, pflFastestRate)
      => ComCall(12, this.p, BOOL, fForwardDirection, Float32.Ptr, pflSlowestRate, Float32.Ptr, pflFastestRate)
    GetState(peState)
      => ComCall(13, this.p, MFP_MEDIAPLAYER_STATE.Ptr, peState)
    CreateMediaItemFromURL(pwszURL, fSync, dwUserData, ppMediaItem?)
      => ComCall(14, this.p, "Str", pwszURL, BOOL, fSync, IntPtr, dwUserData, IMFPMediaItem.Ptr, ppMediaItem?)
    CreateMediaItemFromObject(pIUnknownObj, fSync, dwUserData, ppMediaItem?)
      => ComCall(15, this.p, IUnknown, pIUnknownObj, BOOL, fSync, IntPtr, dwUserData, IMFPMediaItem.Ptr, ppMediaItem?)
    SetMediaItem(pIMFPMediaItem)
      => ComCall(16, this.p, IMFPMediaItem, pIMFPMediaItem)
    ClearMediaItem()
      => ComCall(17, this.p)
    GetMediaItem(ppIMFPMediaItem)
      => ComCall(18, this.p, IMFPMediaItem.Ptr, ppIMFPMediaItem)
    GetVolume(pflVolume)
      => ComCall(19, this.p, Float32.Ptr, pflVolume)
    SetVolume(flVolume)
      => ComCall(20, this.p, Float32, flVolume)
    GetBalance(pflBalance)
      => ComCall(21, this.p, Float32.Ptr, pflBalance)
    SetBalance(flBalance)
      => ComCall(22, this.p, Float32, flBalance)
    GetMute(pfMute)
      => ComCall(23, this.p, BOOL.Ptr, pfMute)
    SetMute(fMute)
      => ComCall(24, this.p, BOOL, fMute)
    GetNativeVideoSize(pszVideo?, pszARVideo?)
      => ComCall(25, this.p, SIZE.Ptr, pszVideo?, SIZE.Ptr, pszARVideo?)
    GetIdealVideoSize(pszMin?, pszMax?)
      => ComCall(26, this.p, SIZE.Ptr, pszMin?, SIZE.Ptr, pszMax?)
    SetVideoSourceRect(pnrcSource)
      => ComCall(27, this.p, MFVideoNormalizedRect.Ptr, pnrcSource)
    GetVideoSourceRect(pnrcSource)
      => ComCall(28, this.p, MFVideoNormalizedRect.Ptr, pnrcSource)
    SetAspectRatioMode(dwAspectRatioMode)
      => ComCall(29, this.p, UInt32, dwAspectRatioMode)
    GetAspectRatioMode(pdwAspectRatioMode)
      => ComCall(30, this.p, UInt32.Ptr, pdwAspectRatioMode)
    GetVideoWindow(phwndVideo)
      => ComCall(31, this.p, HWND.Ptr, phwndVideo)
    UpdateVideo()
      => ComCall(32, this.p)
    SetBorderColor(Clr)
      => ComCall(33, this.p, COLORREF, Clr)
    GetBorderColor(pClr)
      => ComCall(34, this.p, COLORREF.Ptr, pClr)
    InsertEffect(pEffect, fOptional)
      => ComCall(35, this.p, IUnknown, pEffect, BOOL, fOptional)
    RemoveEffect(pEffect)
      => ComCall(36, this.p, IUnknown, pEffect)
    RemoveAllEffects()
      => ComCall(37, this.p)
    Shutdown()
      => ComCall(38, this.p)
}
struct IMFPMediaItem extends IUnknown {
    static IID := "{90EB3E6B-ECBF-45CC-B1DA-C6FE3EA70D57}"
    GetMediaPlayer(ppMediaPlayer)
      => ComCall(3, this.p, IMFPMediaPlayer.Ptr, ppMediaPlayer)
    GetURL(ppwszURL)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszURL)
    GetObject(ppIUnknown)
      => ComCall(5, this.p, IUnknown.Ptr, ppIUnknown)
    GetUserData(pdwUserData)
      => ComCall(6, this.p, IntPtr.Ptr, pdwUserData)
    SetUserData(dwUserData)
      => ComCall(7, this.p, IntPtr, dwUserData)
    GetStartStopPosition(pguidStartPositionType?, pvStartValue?, pguidStopPositionType?, pvStopValue?)
      => ComCall(8, this.p, GUID.Ptr, pguidStartPositionType?, PROPVARIANT.Ptr, pvStartValue?, GUID.Ptr, pguidStopPositionType?, PROPVARIANT.Ptr, pvStopValue?)
    SetStartStopPosition(pguidStartPositionType?, pvStartValue?, pguidStopPositionType?, pvStopValue?)
      => ComCall(9, this.p, GUID.Ptr, pguidStartPositionType?, PROPVARIANT.Ptr, pvStartValue?, GUID.Ptr, pguidStopPositionType?, PROPVARIANT.Ptr, pvStopValue?)
    HasVideo(pfHasVideo?, pfSelected?)
      => ComCall(10, this.p, BOOL.Ptr, pfHasVideo?, BOOL.Ptr, pfSelected?)
    HasAudio(pfHasAudio?, pfSelected?)
      => ComCall(11, this.p, BOOL.Ptr, pfHasAudio?, BOOL.Ptr, pfSelected?)
    IsProtected(pfProtected)
      => ComCall(12, this.p, BOOL.Ptr, pfProtected)
    GetDuration(guidPositionType, pvDurationValue)
      => ComCall(13, this.p, GUID.Ptr, guidPositionType, PROPVARIANT.Ptr, pvDurationValue)
    GetNumberOfStreams(pdwStreamCount)
      => ComCall(14, this.p, UInt32.Ptr, pdwStreamCount)
    GetStreamSelection(dwStreamIndex, pfEnabled)
      => ComCall(15, this.p, UInt32, dwStreamIndex, BOOL.Ptr, pfEnabled)
    SetStreamSelection(dwStreamIndex, fEnabled)
      => ComCall(16, this.p, UInt32, dwStreamIndex, BOOL, fEnabled)
    GetStreamAttribute(dwStreamIndex, guidMFAttribute, pvValue)
      => ComCall(17, this.p, UInt32, dwStreamIndex, GUID.Ptr, guidMFAttribute, PROPVARIANT.Ptr, pvValue)
    GetPresentationAttribute(guidMFAttribute, pvValue)
      => ComCall(18, this.p, GUID.Ptr, guidMFAttribute, PROPVARIANT.Ptr, pvValue)
    GetCharacteristics(pCharacteristics)
      => ComCall(19, this.p, UInt32.Ptr, pCharacteristics)
    SetStreamSink(dwStreamIndex, pMediaSink?)
      => ComCall(20, this.p, UInt32, dwStreamIndex, IUnknown, pMediaSink?)
    GetMetadata(ppMetadataStore)
      => ComCall(21, this.p, IPropertyStore.Ptr, ppMetadataStore)
}
struct MFP_EVENT_TYPE extends Int32 {
    static MFP_EVENT_TYPE_PLAY := 0
    static MFP_EVENT_TYPE_PAUSE := 1
    static MFP_EVENT_TYPE_STOP := 2
    static MFP_EVENT_TYPE_POSITION_SET := 3
    static MFP_EVENT_TYPE_RATE_SET := 4
    static MFP_EVENT_TYPE_MEDIAITEM_CREATED := 5
    static MFP_EVENT_TYPE_MEDIAITEM_SET := 6
    static MFP_EVENT_TYPE_FRAME_STEP := 7
    static MFP_EVENT_TYPE_MEDIAITEM_CLEARED := 8
    static MFP_EVENT_TYPE_MF := 9
    static MFP_EVENT_TYPE_ERROR := 10
    static MFP_EVENT_TYPE_PLAYBACK_ENDED := 11
    static MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL := 12
}
struct MFP_EVENT_HEADER {
    eEventType : MFP_EVENT_TYPE
    hrEvent : HRESULT
    pMediaPlayer : IMFPMediaPlayer
    eState : MFP_MEDIAPLAYER_STATE
    pPropertyStore : IPropertyStore
}
struct MFP_PLAY_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_PAUSE_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_STOP_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_POSITION_SET_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_RATE_SET_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
    flRate : Float32
}
struct MFP_MEDIAITEM_CREATED_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
    dwUserData : IntPtr
}
struct MFP_MEDIAITEM_SET_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_FRAME_STEP_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_MEDIAITEM_CLEARED_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_MF_EVENT {
    header : MFP_EVENT_HEADER
    MFEventType : UInt32
    pMFMediaEvent : IMFMediaEvent
    pMediaItem : IMFPMediaItem
}
struct MFP_ERROR_EVENT {
    header : MFP_EVENT_HEADER
}
struct MFP_PLAYBACK_ENDED_EVENT {
    header : MFP_EVENT_HEADER
    pMediaItem : IMFPMediaItem
}
struct MFP_ACQUIRE_USER_CREDENTIAL_EVENT {
    header : MFP_EVENT_HEADER
    dwUserData : IntPtr
    fProceedWithAuthentication : BOOL
    hrAuthenticationStatus : HRESULT
    pwszURL : PWSTR
    pwszSite : PWSTR
    pwszRealm : PWSTR
    pwszPackage : PWSTR
    nRetries : Int32
    flags : UInt32
    pCredential : IMFNetCredential
}
struct IMFPMediaPlayerCallback extends IUnknown {
    static IID := "{766C8FFB-5FDB-4FEA-A28D-B912996F51BD}"
    OnMediaPlayerEvent(pEventHeader)
      => ComCall(3, this.p, MFP_EVENT_HEADER.Ptr, pEventHeader, "void")
}
struct DEVICE_INFO {
    pFriendlyDeviceName : BSTR
    pUniqueDeviceName : BSTR
    pManufacturerName : BSTR
    pModelName : BSTR
    pIconURL : BSTR
}
struct MF_SHARING_ENGINE_EVENT extends Int32 {
    static MF_SHARING_ENGINE_EVENT_DISCONNECT := 2000
    static MF_SHARING_ENGINE_EVENT_LOCALRENDERINGSTARTED := 2001
    static MF_SHARING_ENGINE_EVENT_LOCALRENDERINGENDED := 2002
    static MF_SHARING_ENGINE_EVENT_STOPPED := 2003
    static MF_SHARING_ENGINE_EVENT_ERROR := 2501
}
struct MF_MEDIA_SHARING_ENGINE_EVENT extends Int32 {
    static MF_MEDIA_SHARING_ENGINE_EVENT_DISCONNECT := 2000
}
struct IMFSharingEngineClassFactory extends IUnknown {
    static IID := "{2BA61F92-8305-413B-9733-FAF15F259384}"
    CreateInstance(dwFlags, pAttr?, ppEngine)
      => ComCall(3, this.p, UInt32, dwFlags, IMFAttributes, pAttr?, IUnknown.Ptr, ppEngine)
}
struct IMFMediaSharingEngine extends IMFMediaEngine {
    static IID := "{8D3CE1BF-2367-40E0-9EEE-40D377CC1B46}"
    GetDevice(pDevice)
      => ComCall(45, this.p, DEVICE_INFO.Ptr, pDevice)
}
struct IMFMediaSharingEngineClassFactory extends IUnknown {
    static IID := "{524D2BC4-B2B1-4FE5-8FAC-FA4E4512B4E0}"
    CreateInstance(dwFlags, pAttr, ppEngine)
      => ComCall(3, this.p, UInt32, dwFlags, IMFAttributes, pAttr, IMFMediaSharingEngine.Ptr, ppEngine)
}
struct IMFImageSharingEngine extends IUnknown {
    static IID := "{CFA0AE8E-7E1C-44D2-AE68-FC4C148A6354}"
    SetSource(pStream)
      => ComCall(3, this.p, IUnknown, pStream)
    GetDevice(pDevice)
      => ComCall(4, this.p, DEVICE_INFO.Ptr, pDevice)
    Shutdown()
      => ComCall(5, this.p)
}
struct IMFImageSharingEngineClassFactory extends IUnknown {
    static IID := "{1FC55727-A7FB-4FC8-83AE-8AF024990AF1}"
    CreateInstanceFromUDN(pUniqueDeviceName, ppEngine)
      => ComCall(3, this.p, BSTR, pUniqueDeviceName, IMFImageSharingEngine.Ptr, ppEngine)
}
struct PLAYTO_SOURCE_CREATEFLAGS extends Int32 {
    static PLAYTO_SOURCE_NONE := 0
    static PLAYTO_SOURCE_IMAGE := 1
    static PLAYTO_SOURCE_AUDIO := 2
    static PLAYTO_SOURCE_VIDEO := 4
    static PLAYTO_SOURCE_PROTECTED := 8
}
struct IPlayToControl extends IUnknown {
    static IID := "{607574EB-F4B6-45C1-B08C-CB715122901D}"
    Connect(pFactory)
      => ComCall(3, this.p, IMFSharingEngineClassFactory, pFactory)
    Disconnect()
      => ComCall(4, this.p)
}
struct IPlayToControlWithCapabilities extends IPlayToControl {
    static IID := "{AA9DD80F-C50A-4220-91C1-332287F82A34}"
    GetCapabilities(pCapabilities)
      => ComCall(5, this.p, PLAYTO_SOURCE_CREATEFLAGS.Ptr, pCapabilities)
}
struct IPlayToSourceClassFactory extends IUnknown {
    static IID := "{842B32A3-9B9B-4D1C-B3F3-49193248A554}"
    CreateInstance(dwFlags, pControl, ppSource)
      => ComCall(3, this.p, UInt32, dwFlags, IPlayToControl, pControl, IInspectable.Ptr, ppSource)
}
struct IEVRVideoStreamControl extends IUnknown {
    static IID := "{D0CFE38B-93E7-4772-8957-0400C49A4485}"
    SetStreamActiveState(fActive)
      => ComCall(3, this.p, BOOL, fActive)
    GetStreamActiveState(lpfActive)
      => ComCall(4, this.p, BOOL.Ptr, lpfActive)
}
struct IMFVideoProcessor extends IUnknown {
    static IID := "{6AB0000C-FECE-4D1F-A2AC-A9573530656E}"
    GetAvailableVideoProcessorModes(lpdwNumProcessingModes, ppVideoProcessingModes)
      => ComCall(3, this.p, UInt32.Ptr, lpdwNumProcessingModes, GUID.Ptr.Ptr, ppVideoProcessingModes)
    GetVideoProcessorCaps(lpVideoProcessorMode, lpVideoProcessorCaps)
      => ComCall(4, this.p, GUID.Ptr, lpVideoProcessorMode, DXVA2_VideoProcessorCaps.Ptr, lpVideoProcessorCaps)
    GetVideoProcessorMode(lpMode)
      => ComCall(5, this.p, GUID.Ptr, lpMode)
    SetVideoProcessorMode(lpMode)
      => ComCall(6, this.p, GUID.Ptr, lpMode)
    GetProcAmpRange(dwProperty, pPropRange)
      => ComCall(7, this.p, UInt32, dwProperty, DXVA2_ValueRange.Ptr, pPropRange)
    GetProcAmpValues(dwFlags, Values)
      => ComCall(8, this.p, UInt32, dwFlags, DXVA2_ProcAmpValues.Ptr, Values)
    SetProcAmpValues(dwFlags, pValues)
      => ComCall(9, this.p, UInt32, dwFlags, DXVA2_ProcAmpValues.Ptr, pValues)
    GetFilteringRange(dwProperty, pPropRange)
      => ComCall(10, this.p, UInt32, dwProperty, DXVA2_ValueRange.Ptr, pPropRange)
    GetFilteringValue(dwProperty, pValue)
      => ComCall(11, this.p, UInt32, dwProperty, DXVA2_Fixed32.Ptr, pValue)
    SetFilteringValue(dwProperty, pValue)
      => ComCall(12, this.p, UInt32, dwProperty, DXVA2_Fixed32.Ptr, pValue)
    GetBackgroundColor(lpClrBkg)
      => ComCall(13, this.p, COLORREF.Ptr, lpClrBkg)
    SetBackgroundColor(ClrBkg)
      => ComCall(14, this.p, COLORREF, ClrBkg)
}
struct MFVideoAlphaBitmapParams {
    dwFlags : UInt32
    clrSrcKey : COLORREF
    rcSrc : RECT
    nrcDest : MFVideoNormalizedRect
    fAlpha : Float32
    dwFilterMode : UInt32
}
struct MFVideoAlphaBitmap {
    GetBitmapFromDC : BOOL
    bitmap : this._bitmap_e__Union
    params : MFVideoAlphaBitmapParams
    struct _bitmap_e__Union {
        union {
            hdc : HDC
            pDDS : IDirect3DSurface9
        }
    }
}
struct MFVideoAlphaBitmapFlags extends Int32 {
    static MFVideoAlphaBitmap_EntireDDS := 1
    static MFVideoAlphaBitmap_SrcColorKey := 2
    static MFVideoAlphaBitmap_SrcRect := 4
    static MFVideoAlphaBitmap_DestRect := 8
    static MFVideoAlphaBitmap_FilterMode := 16
    static MFVideoAlphaBitmap_Alpha := 32
    static MFVideoAlphaBitmap_BitMask := 63
}
struct IMFVideoMixerBitmap extends IUnknown {
    static IID := "{814C7B20-0FDB-4EEC-AF8F-F957C8F69EDC}"
    SetAlphaBitmap(pBmpParms)
      => ComCall(3, this.p, MFVideoAlphaBitmap.Ptr, pBmpParms)
    ClearAlphaBitmap()
      => ComCall(4, this.p)
    UpdateAlphaBitmapParameters(pBmpParms)
      => ComCall(5, this.p, MFVideoAlphaBitmapParams.Ptr, pBmpParms)
    GetAlphaBitmapParameters(pBmpParms)
      => ComCall(6, this.p, MFVideoAlphaBitmapParams.Ptr, pBmpParms)
}
struct IAdvancedMediaCaptureInitializationSettings extends IUnknown {
    static IID := "{3DE21209-8BA6-4F2A-A577-2819B56FF14D}"
    SetDirectxDeviceManager(value)
      => ComCall(3, this.p, IMFDXGIDeviceManager, value)
}
struct IAdvancedMediaCaptureSettings extends IUnknown {
    static IID := "{24E0485F-A33E-4AA1-B564-6019B1D14F65}"
    GetDirectxDeviceManager(value)
      => ComCall(3, this.p, IMFDXGIDeviceManager.Ptr, value)
}
struct IAdvancedMediaCapture extends IUnknown {
    static IID := "{D0751585-D216-4344-B5BF-463B68F977BB}"
    GetAdvancedMediaCaptureSettings(value)
      => ComCall(3, this.p, IAdvancedMediaCaptureSettings.Ptr, value)
}
struct IMFSpatialAudioObjectBuffer extends IMFMediaBuffer {
    static IID := "{D396EC8C-605E-4249-978D-72AD1C312872}"
    SetID(u32ID)
      => ComCall(8, this.p, UInt32, u32ID)
    GetID(pu32ID)
      => ComCall(9, this.p, UInt32.Ptr, pu32ID)
    SetType(type)
      => ComCall(10, this.p, AudioObjectType, type)
    GetType(pType)
      => ComCall(11, this.p, AudioObjectType.Ptr, pType)
    GetMetadataItems(ppMetadataItems)
      => ComCall(12, this.p, ISpatialAudioMetadataItems.Ptr, ppMetadataItems)
}
struct IMFSpatialAudioSample extends IMFSample {
    static IID := "{ABF28A9B-3393-4290-BA79-5FFC46D986B2}"
    GetObjectCount(pdwObjectCount)
      => ComCall(47, this.p, UInt32.Ptr, pdwObjectCount)
    AddSpatialAudioObject(pAudioObjBuffer)
      => ComCall(48, this.p, IMFSpatialAudioObjectBuffer, pAudioObjBuffer)
    GetSpatialAudioObjectByIndex(dwIndex, ppAudioObjBuffer)
      => ComCall(49, this.p, UInt32, dwIndex, IMFSpatialAudioObjectBuffer.Ptr, ppAudioObjBuffer)
}
struct IMFContentDecryptionModuleSession extends IUnknown {
    static IID := "{4E233EFD-1DD2-49E8-B577-D63EEE4C0D33}"
    GetSessionId(sessionId)
      => ComCall(3, this.p, PWSTR.Ptr, sessionId)
    GetExpiration(expiration)
      => ComCall(4, this.p, Float64.Ptr, expiration)
    GetKeyStatuses(keyStatuses)
      => ComCall(5, this.p, MFMediaKeyStatus.Ptr.Ptr, keyStatuses, UInt32.Ptr, keyStatuses.Length)
    Load(sessionId, loaded)
      => ComCall(6, this.p, "Str", sessionId, BOOL.Ptr, loaded)
    GenerateRequest(initDataType, initData)
      => ComCall(7, this.p, "Str", initDataType, UInt8.Ptr, initData, UInt32, initData.Length)
    Update(response)
      => ComCall(8, this.p, UInt8.Ptr, response, UInt32, response.Length)
    Close()
      => ComCall(9, this.p)
    Remove()
      => ComCall(10, this.p)
}
struct IMFContentDecryptionModuleSessionCallbacks extends IUnknown {
    static IID := "{3F96EE40-AD81-4096-8470-59A4B770F89A}"
    KeyMessage(messageType, message, destinationURL)
      => ComCall(3, this.p, MF_MEDIAKEYSESSION_MESSAGETYPE, messageType, UInt8.Ptr, message, UInt32, message.Length, "Str", destinationURL)
    KeyStatusChanged()
      => ComCall(4, this.p)
}
struct IMFContentDecryptionModule extends IUnknown {
    static IID := "{87BE986C-10BE-4943-BF48-4B54CE1983A2}"
    SetContentEnabler(contentEnabler, result)
      => ComCall(3, this.p, IMFContentEnabler, contentEnabler, IMFAsyncResult, result)
    GetSuspendNotify(notify)
      => ComCall(4, this.p, IMFCdmSuspendNotify.Ptr, notify)
    SetPMPHostApp(pmpHostApp)
      => ComCall(5, this.p, IMFPMPHostApp, pmpHostApp)
    CreateSession(sessionType, callbacks, session)
      => ComCall(6, this.p, MF_MEDIAKEYSESSION_TYPE, sessionType, IMFContentDecryptionModuleSessionCallbacks, callbacks, IMFContentDecryptionModuleSession.Ptr, session)
    SetServerCertificate(certificate)
      => ComCall(7, this.p, UInt8.Ptr, certificate, UInt32, certificate.Length)
    CreateTrustedInput(contentInitData, trustedInput)
      => ComCall(8, this.p, UInt8.Ptr, contentInitData, UInt32, contentInitData.Length, IMFTrustedInput.Ptr, trustedInput)
    GetProtectionSystemIds(systemIds)
      => ComCall(9, this.p, GUID.Ptr.Ptr, systemIds, UInt32.Ptr, systemIds.Length)
}
struct IMFContentDecryptionModuleAccess extends IUnknown {
    static IID := "{A853D1F4-E2A0-4303-9EDC-F1A68EE43136}"
    CreateContentDecryptionModule(contentDecryptionModuleProperties, contentDecryptionModule)
      => ComCall(3, this.p, IPropertyStore, contentDecryptionModuleProperties, IMFContentDecryptionModule.Ptr, contentDecryptionModule)
    GetConfiguration(configuration)
      => ComCall(4, this.p, IPropertyStore.Ptr, configuration)
    GetKeySystem(keySystem)
      => ComCall(5, this.p, PWSTR.Ptr, keySystem)
}
struct IMFContentDecryptionModuleFactory extends IUnknown {
    static IID := "{7D5ABF16-4CBB-4E08-B977-9BA59049943E}"
    IsTypeSupported(keySystem, contentType)
      => ComCall(3, this.p, "Str", keySystem, "Str", contentType, BOOL)
    CreateContentDecryptionModuleAccess(keySystem, configurations, contentDecryptionModuleAccess)
      => ComCall(4, this.p, "Str", keySystem, IPropertyStore.Ptr, configurations, UInt32, configurations.Length, IMFContentDecryptionModuleAccess.Ptr, contentDecryptionModuleAccess)
}
struct MFVirtualCameraType extends Int32 {
    static MFVirtualCameraType_SoftwareCameraSource := 0
}
struct MFVirtualCameraLifetime extends Int32 {
    static MFVirtualCameraLifetime_Session := 0
    static MFVirtualCameraLifetime_System := 1
}
struct MFVirtualCameraAccess extends Int32 {
    static MFVirtualCameraAccess_CurrentUser := 0
    static MFVirtualCameraAccess_AllUsers := 1
}
struct IMFCameraSyncObject extends IUnknown {
    static IID := "{6338B23A-3042-49D2-A3EA-EC0FED815407}"
    WaitOnSignal(timeOutInMs)
      => ComCall(3, this.p, UInt32, timeOutInMs)
    Shutdown()
      => ComCall(4, this.p, "void")
}
struct IMFVirtualCamera extends IMFAttributes {
    static IID := "{1C08A864-EF6C-4C75-AF59-5F2D68DA9563}"
    AddDeviceSourceInfo(DeviceSourceInfo)
      => ComCall(33, this.p, "Str", DeviceSourceInfo)
    AddProperty(pKey, Type, pbData)
      => ComCall(34, this.p, DEVPROPKEY.Ptr, pKey, DEVPROPTYPE, Type, UInt8.Ptr, pbData, UInt32, pbData.Size)
    AddRegistryEntry(EntryName, SubkeyPath?, dwRegType, pbData)
      => ComCall(35, this.p, "Str", EntryName, "Str", SubkeyPath?, UInt32, dwRegType, UInt8.Ptr, pbData, UInt32, pbData.Size)
    Start(pCallback?)
      => ComCall(36, this.p, IMFAsyncCallback, pCallback?)
    Stop()
      => ComCall(37, this.p)
    Remove()
      => ComCall(38, this.p)
    GetMediaSource(ppMediaSource)
      => ComCall(39, this.p, IMFMediaSource.Ptr, ppMediaSource)
    SendCameraProperty(propertySet, propertyId, propertyFlags, propertyPayload?, data?, dataWritten)
      => ComCall(40, this.p, GUID.Ptr, propertySet, UInt32, propertyId, UInt32, propertyFlags, Struct.Ptr, propertyPayload?, UInt32, propertyPayload?.Size ?? 0, Struct.Ptr, data?, UInt32, data?.Size ?? 0, UInt32.Ptr, dataWritten)
    CreateSyncEvent(kseventSet, kseventId, kseventFlags, eventHandle, cameraSyncObject)
      => ComCall(41, this.p, GUID.Ptr, kseventSet, UInt32, kseventId, UInt32, kseventFlags, HANDLE, eventHandle, IMFCameraSyncObject.Ptr, cameraSyncObject)
    CreateSyncSemaphore(kseventSet, kseventId, kseventFlags, semaphoreHandle, semaphoreAdjustment, cameraSyncObject)
      => ComCall(42, this.p, GUID.Ptr, kseventSet, UInt32, kseventId, UInt32, kseventFlags, HANDLE, semaphoreHandle, Int32, semaphoreAdjustment, IMFCameraSyncObject.Ptr, cameraSyncObject)
    Shutdown()
      => ComCall(43, this.p)
}
struct OPM_HDCP_TYPE extends Int32 {
    static OPM_HDCP_TYPE_0 := 0
    static OPM_HDCP_TYPE_1 := 1
}
struct OPM_HDCP_STATUS extends Int32 {
    static OPM_HDCP_STATUS_ON := 0
    static OPM_HDCP_STATUS_OFF := 1
}
