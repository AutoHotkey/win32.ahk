#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, GENERIC_ACCESS_RIGHTS, HRESULT, PWSTR}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D1_PIXEL_FORMAT}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_FORMAT, DXGI_JPEG_AC_HUFFMAN_TABLE, DXGI_JPEG_DC_HUFFMAN_TABLE, DXGI_JPEG_QUANTIZATION_TABLE}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HPALETTE}
#Import "..\System.Com\Types.ahk" {IEnumString, IEnumUnknown, IPersistStream, IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag2, PROPBAG2, PROPVARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct WICRect {
    X : Int32
    Y : Int32
    Width : Int32
    Height : Int32
}
struct WICColorContextType extends Int32 {
    static WICColorContextUninitialized := 0
    static WICColorContextProfile := 1
    static WICColorContextExifColorSpace := 2
}
struct WICBitmapCreateCacheOption extends Int32 {
    static WICBitmapNoCache := 0
    static WICBitmapCacheOnDemand := 1
    static WICBitmapCacheOnLoad := 2
}
struct WICDecodeOptions extends Int32 {
    static WICDecodeMetadataCacheOnDemand := 0
    static WICDecodeMetadataCacheOnLoad := 1
}
struct WICBitmapEncoderCacheOption extends Int32 {
    static WICBitmapEncoderCacheInMemory := 0
    static WICBitmapEncoderCacheTempFile := 1
    static WICBitmapEncoderNoCache := 2
}
struct WICComponentType extends Int32 {
    static WICDecoder := 1
    static WICEncoder := 2
    static WICPixelFormatConverter := 4
    static WICMetadataReader := 8
    static WICMetadataWriter := 16
    static WICPixelFormat := 32
    static WICAllComponents := 63
}
struct WICComponentEnumerateOptions extends Int32 {
    static WICComponentEnumerateDefault := 0
    static WICComponentEnumerateRefresh := 1
    static WICComponentEnumerateDisabled := -2147483648
    static WICComponentEnumerateUnsigned := 1073741824
    static WICComponentEnumerateBuiltInOnly := 536870912
}
struct WICBitmapPattern {
    Position : Int64
    Length : UInt32
    Pattern : UInt8.Ptr
    Mask : UInt8.Ptr
    EndOfStream : BOOL
}
struct WICBitmapInterpolationMode extends Int32 {
    static WICBitmapInterpolationModeNearestNeighbor := 0
    static WICBitmapInterpolationModeLinear := 1
    static WICBitmapInterpolationModeCubic := 2
    static WICBitmapInterpolationModeFant := 3
    static WICBitmapInterpolationModeHighQualityCubic := 4
}
struct WICBitmapPaletteType extends Int32 {
    static WICBitmapPaletteTypeCustom := 0
    static WICBitmapPaletteTypeMedianCut := 1
    static WICBitmapPaletteTypeFixedBW := 2
    static WICBitmapPaletteTypeFixedHalftone8 := 3
    static WICBitmapPaletteTypeFixedHalftone27 := 4
    static WICBitmapPaletteTypeFixedHalftone64 := 5
    static WICBitmapPaletteTypeFixedHalftone125 := 6
    static WICBitmapPaletteTypeFixedHalftone216 := 7
    static WICBitmapPaletteTypeFixedWebPalette := 7
    static WICBitmapPaletteTypeFixedHalftone252 := 8
    static WICBitmapPaletteTypeFixedHalftone256 := 9
    static WICBitmapPaletteTypeFixedGray4 := 10
    static WICBitmapPaletteTypeFixedGray16 := 11
    static WICBitmapPaletteTypeFixedGray256 := 12
}
struct WICBitmapDitherType extends Int32 {
    static WICBitmapDitherTypeNone := 0
    static WICBitmapDitherTypeSolid := 0
    static WICBitmapDitherTypeOrdered4x4 := 1
    static WICBitmapDitherTypeOrdered8x8 := 2
    static WICBitmapDitherTypeOrdered16x16 := 3
    static WICBitmapDitherTypeSpiral4x4 := 4
    static WICBitmapDitherTypeSpiral8x8 := 5
    static WICBitmapDitherTypeDualSpiral4x4 := 6
    static WICBitmapDitherTypeDualSpiral8x8 := 7
    static WICBitmapDitherTypeErrorDiffusion := 8
}
struct WICBitmapAlphaChannelOption extends Int32 {
    static WICBitmapUseAlpha := 0
    static WICBitmapUsePremultipliedAlpha := 1
    static WICBitmapIgnoreAlpha := 2
}
struct WICBitmapTransformOptions extends Int32 {
    static WICBitmapTransformRotate0 := 0
    static WICBitmapTransformRotate90 := 1
    static WICBitmapTransformRotate180 := 2
    static WICBitmapTransformRotate270 := 3
    static WICBitmapTransformFlipHorizontal := 8
    static WICBitmapTransformFlipVertical := 16
}
struct WICBitmapLockFlags extends Int32 {
    static WICBitmapLockRead := 1
    static WICBitmapLockWrite := 2
}
struct WICBitmapDecoderCapabilities extends Int32 {
    static WICBitmapDecoderCapabilitySameEncoder := 1
    static WICBitmapDecoderCapabilityCanDecodeAllImages := 2
    static WICBitmapDecoderCapabilityCanDecodeSomeImages := 4
    static WICBitmapDecoderCapabilityCanEnumerateMetadata := 8
    static WICBitmapDecoderCapabilityCanDecodeThumbnail := 16
}
struct WICProgressOperation extends Int32 {
    static WICProgressOperationCopyPixels := 1
    static WICProgressOperationWritePixels := 2
    static WICProgressOperationAll := 65535
}
struct WICProgressNotification extends Int32 {
    static WICProgressNotificationBegin := 65536
    static WICProgressNotificationEnd := 131072
    static WICProgressNotificationFrequent := 262144
    static WICProgressNotificationAll := -65536
}
struct WICComponentSigning extends Int32 {
    static WICComponentSigned := 1
    static WICComponentUnsigned := 2
    static WICComponentSafe := 4
    static WICComponentDisabled := -2147483648
}
struct WICBitmapToneMappingMode extends Int32 {
    static WICBitmapToneMappingMode_None := 0
    static WICBitmapToneMappingMode_Default := 1
    static WICBitmapToneMappingMode_D2D := 2
    static WICBitmapToneMappingMode_GainMap := 3
}
struct WICBitmapChainType extends Int32 {
    static WICBitmapChainType_Alternate := 1
    static WICBitmapChainType_Layer := 2
    static WICBitmapChainType_Preview := 3
    static WICBitmapChainType_Thumbnail := 4
    static WICBitmapChainType_AlphaMap := 5
    static WICBitmapChainType_DepthMap := 6
    static WICBitmapChainType_GainMap := 7
}
struct WICGifLogicalScreenDescriptorProperties extends Int32 {
    static WICGifLogicalScreenSignature := 1
    static WICGifLogicalScreenDescriptorWidth := 2
    static WICGifLogicalScreenDescriptorHeight := 3
    static WICGifLogicalScreenDescriptorGlobalColorTableFlag := 4
    static WICGifLogicalScreenDescriptorColorResolution := 5
    static WICGifLogicalScreenDescriptorSortFlag := 6
    static WICGifLogicalScreenDescriptorGlobalColorTableSize := 7
    static WICGifLogicalScreenDescriptorBackgroundColorIndex := 8
    static WICGifLogicalScreenDescriptorPixelAspectRatio := 9
}
struct WICGifImageDescriptorProperties extends Int32 {
    static WICGifImageDescriptorLeft := 1
    static WICGifImageDescriptorTop := 2
    static WICGifImageDescriptorWidth := 3
    static WICGifImageDescriptorHeight := 4
    static WICGifImageDescriptorLocalColorTableFlag := 5
    static WICGifImageDescriptorInterlaceFlag := 6
    static WICGifImageDescriptorSortFlag := 7
    static WICGifImageDescriptorLocalColorTableSize := 8
}
struct WICGifGraphicControlExtensionProperties extends Int32 {
    static WICGifGraphicControlExtensionDisposal := 1
    static WICGifGraphicControlExtensionUserInputFlag := 2
    static WICGifGraphicControlExtensionTransparencyFlag := 3
    static WICGifGraphicControlExtensionDelay := 4
    static WICGifGraphicControlExtensionTransparentColorIndex := 5
}
struct WICGifApplicationExtensionProperties extends Int32 {
    static WICGifApplicationExtensionApplication := 1
    static WICGifApplicationExtensionData := 2
}
struct WICGifCommentExtensionProperties extends Int32 {
    static WICGifCommentExtensionText := 1
}
struct WICJpegCommentProperties extends Int32 {
    static WICJpegCommentText := 1
}
struct WICJpegLuminanceProperties extends Int32 {
    static WICJpegLuminanceTable := 1
}
struct WICJpegChrominanceProperties extends Int32 {
    static WICJpegChrominanceTable := 1
}
struct WIC8BIMIptcProperties extends Int32 {
    static WIC8BIMIptcPString := 0
    static WIC8BIMIptcEmbeddedIPTC := 1
}
struct WIC8BIMResolutionInfoProperties extends Int32 {
    static WIC8BIMResolutionInfoPString := 1
    static WIC8BIMResolutionInfoHResolution := 2
    static WIC8BIMResolutionInfoHResolutionUnit := 3
    static WIC8BIMResolutionInfoWidthUnit := 4
    static WIC8BIMResolutionInfoVResolution := 5
    static WIC8BIMResolutionInfoVResolutionUnit := 6
    static WIC8BIMResolutionInfoHeightUnit := 7
}
struct WIC8BIMIptcDigestProperties extends Int32 {
    static WIC8BIMIptcDigestPString := 1
    static WIC8BIMIptcDigestIptcDigest := 2
}
struct WICPngGamaProperties extends Int32 {
    static WICPngGamaGamma := 1
}
struct WICPngBkgdProperties extends Int32 {
    static WICPngBkgdBackgroundColor := 1
}
struct WICPngItxtProperties extends Int32 {
    static WICPngItxtKeyword := 1
    static WICPngItxtCompressionFlag := 2
    static WICPngItxtLanguageTag := 3
    static WICPngItxtTranslatedKeyword := 4
    static WICPngItxtText := 5
}
struct WICPngChrmProperties extends Int32 {
    static WICPngChrmWhitePointX := 1
    static WICPngChrmWhitePointY := 2
    static WICPngChrmRedX := 3
    static WICPngChrmRedY := 4
    static WICPngChrmGreenX := 5
    static WICPngChrmGreenY := 6
    static WICPngChrmBlueX := 7
    static WICPngChrmBlueY := 8
}
struct WICPngHistProperties extends Int32 {
    static WICPngHistFrequencies := 1
}
struct WICPngIccpProperties extends Int32 {
    static WICPngIccpProfileName := 1
    static WICPngIccpProfileData := 2
}
struct WICPngSrgbProperties extends Int32 {
    static WICPngSrgbRenderingIntent := 1
}
struct WICPngTimeProperties extends Int32 {
    static WICPngTimeYear := 1
    static WICPngTimeMonth := 2
    static WICPngTimeDay := 3
    static WICPngTimeHour := 4
    static WICPngTimeMinute := 5
    static WICPngTimeSecond := 6
}
struct WICHeifProperties extends Int32 {
    static WICHeifOrientation := 1
    static WICHeifLayeredImageCanvasColor := 2
    static WICHeifLayeredImageLayerPositions := 3
}
struct WICHeifHdrProperties extends Int32 {
    static WICHeifHdrMaximumLuminanceLevel := 1
    static WICHeifHdrMaximumFrameAverageLuminanceLevel := 2
    static WICHeifHdrMinimumMasteringDisplayLuminanceLevel := 3
    static WICHeifHdrMaximumMasteringDisplayLuminanceLevel := 4
    static WICHeifHdrCustomVideoPrimaries := 5
}
struct WICWebpAnimProperties extends Int32 {
    static WICWebpAnimLoopCount := 1
}
struct WICWebpAnmfProperties extends Int32 {
    static WICWebpAnmfFrameDuration := 1
}
struct WICJpegXLAnimProperties extends Int32 {
    static WICJpegXLAnimLoopCount := 1
    static WICJpegXLAnimFrameTicksPerSecondNumerator := 2
    static WICJpegXLAnimFrameTicksPerSecondDenominator := 3
}
struct WICJpegXLAnimFrameProperties extends Int32 {
    static WICJpegXLAnimFrameDurationInTicks := 1
    static WICJpegXLAnimFrameName := 2
}
struct WICGainMapProperties extends Int32 {
    static WICGainMapMetadata := 1
}
struct WICSectionAccessLevel extends Int32 {
    static WICSectionAccessLevelRead := 1
    static WICSectionAccessLevelReadWrite := 3
}
struct WICPixelFormatNumericRepresentation extends Int32 {
    static WICPixelFormatNumericRepresentationUnspecified := 0
    static WICPixelFormatNumericRepresentationIndexed := 1
    static WICPixelFormatNumericRepresentationUnsignedInteger := 2
    static WICPixelFormatNumericRepresentationSignedInteger := 3
    static WICPixelFormatNumericRepresentationFixed := 4
    static WICPixelFormatNumericRepresentationFloat := 5
}
struct WICPlanarOptions extends Int32 {
    static WICPlanarOptionsDefault := 0
    static WICPlanarOptionsPreserveSubsampling := 1
}
struct WICJpegIndexingOptions extends Int32 {
    static WICJpegIndexingOptionsGenerateOnDemand := 0
    static WICJpegIndexingOptionsGenerateOnLoad := 1
}
struct WICJpegTransferMatrix extends Int32 {
    static WICJpegTransferMatrixIdentity := 0
    static WICJpegTransferMatrixBT601 := 1
}
struct WICJpegScanType extends Int32 {
    static WICJpegScanTypeInterleaved := 0
    static WICJpegScanTypePlanarComponents := 1
    static WICJpegScanTypeProgressive := 2
}
struct WICImageParameters {
    PixelFormat : D2D1_PIXEL_FORMAT
    DpiX : Float32
    DpiY : Float32
    Top : Float32
    Left : Float32
    PixelWidth : UInt32
    PixelHeight : UInt32
}
struct WICBitmapPlaneDescription {
    Format : GUID
    Width : UInt32
    Height : UInt32
}
struct WICBitmapPlane {
    Format : GUID
    pbBuffer : UInt8.Ptr
    cbStride : UInt32
    cbBufferSize : UInt32
}
struct WICJpegFrameHeader {
    Width : UInt32
    Height : UInt32
    TransferMatrix : WICJpegTransferMatrix
    ScanType : WICJpegScanType
    cComponents : UInt32
    ComponentIdentifiers : UInt32
    SampleFactors : UInt32
    QuantizationTableIndices : UInt32
}
struct WICJpegScanHeader {
    cComponents : UInt32
    RestartInterval : UInt32
    ComponentSelectors : UInt32
    HuffmanTableIndices : UInt32
    StartSpectralSelection : UInt8
    EndSpectralSelection : UInt8
    SuccessiveApproximationHigh : UInt8
    SuccessiveApproximationLow : UInt8
}
struct IWICPalette extends IUnknown {
    static IID := "{00000040-A8F2-4877-BA0A-FD2B6645FB94}"
    InitializePredefined(ePaletteType, fAddTransparentColor)
      => ComCall(3, this.p, WICBitmapPaletteType, ePaletteType, BOOL, fAddTransparentColor)
    InitializeCustom(pColors)
      => ComCall(4, this.p, UInt32.Ptr, pColors, UInt32, pColors.Length)
    InitializeFromBitmap(pISurface, cCount, fAddTransparentColor)
      => ComCall(5, this.p, IWICBitmapSource, pISurface, UInt32, cCount, BOOL, fAddTransparentColor)
    InitializeFromPalette(pIPalette)
      => ComCall(6, this.p, IWICPalette, pIPalette)
    GetType(pePaletteType)
      => ComCall(7, this.p, WICBitmapPaletteType.Ptr, pePaletteType)
    GetColorCount(pcCount)
      => ComCall(8, this.p, UInt32.Ptr, pcCount)
    GetColors(pColors, pcActualColors)
      => ComCall(9, this.p, UInt32, pColors.Length, UInt32.Ptr, pColors, UInt32.Ptr, pcActualColors)
    IsBlackWhite(pfIsBlackWhite)
      => ComCall(10, this.p, BOOL.Ptr, pfIsBlackWhite)
    IsGrayscale(pfIsGrayscale)
      => ComCall(11, this.p, BOOL.Ptr, pfIsGrayscale)
    HasAlpha(pfHasAlpha)
      => ComCall(12, this.p, BOOL.Ptr, pfHasAlpha)
}
struct IWICBitmapSource extends IUnknown {
    static IID := "{00000120-A8F2-4877-BA0A-FD2B6645FB94}"
    GetSize(puiWidth, puiHeight)
      => ComCall(3, this.p, UInt32.Ptr, puiWidth, UInt32.Ptr, puiHeight)
    GetPixelFormat(pPixelFormat)
      => ComCall(4, this.p, GUID.Ptr, pPixelFormat)
    GetResolution(pDpiX, pDpiY)
      => ComCall(5, this.p, Float64.Ptr, pDpiX, Float64.Ptr, pDpiY)
    CopyPalette(pIPalette)
      => ComCall(6, this.p, IWICPalette, pIPalette)
    CopyPixels(prc?, cbStride, pbBuffer)
      => ComCall(7, this.p, WICRect.Ptr, prc?, UInt32, cbStride, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer)
}
struct IWICFormatConverter extends IWICBitmapSource {
    static IID := "{00000301-A8F2-4877-BA0A-FD2B6645FB94}"
    Initialize(pISource, dstFormat, dither, pIPalette, alphaThresholdPercent, paletteTranslate)
      => ComCall(8, this.p, IWICBitmapSource, pISource, GUID.Ptr, dstFormat, WICBitmapDitherType, dither, IWICPalette, pIPalette, Float64, alphaThresholdPercent, WICBitmapPaletteType, paletteTranslate)
    CanConvert(srcPixelFormat, dstPixelFormat, pfCanConvert)
      => ComCall(9, this.p, GUID.Ptr, srcPixelFormat, GUID.Ptr, dstPixelFormat, BOOL.Ptr, pfCanConvert)
}
struct IWICPlanarFormatConverter extends IWICBitmapSource {
    static IID := "{BEBEE9CB-83B0-4DCC-8132-B0AAA55EAC96}"
    Initialize(ppPlanes, dstFormat, dither, pIPalette, alphaThresholdPercent, paletteTranslate)
      => ComCall(8, this.p, IWICBitmapSource.Ptr, ppPlanes, UInt32, ppPlanes.Length, GUID.Ptr, dstFormat, WICBitmapDitherType, dither, IWICPalette, pIPalette, Float64, alphaThresholdPercent, WICBitmapPaletteType, paletteTranslate)
    CanConvert(pSrcPixelFormats, dstPixelFormat, pfCanConvert)
      => ComCall(9, this.p, GUID.Ptr, pSrcPixelFormats, UInt32, pSrcPixelFormats.Length, GUID.Ptr, dstPixelFormat, BOOL.Ptr, pfCanConvert)
}
struct IWICBitmapScaler extends IWICBitmapSource {
    static IID := "{00000302-A8F2-4877-BA0A-FD2B6645FB94}"
    Initialize(pISource, uiWidth, uiHeight, mode)
      => ComCall(8, this.p, IWICBitmapSource, pISource, UInt32, uiWidth, UInt32, uiHeight, WICBitmapInterpolationMode, mode)
}
struct IWICBitmapClipper extends IWICBitmapSource {
    static IID := "{E4FBCF03-223D-4E81-9333-D635556DD1B5}"
    Initialize(pISource, prc)
      => ComCall(8, this.p, IWICBitmapSource, pISource, WICRect.Ptr, prc)
}
struct IWICBitmapFlipRotator extends IWICBitmapSource {
    static IID := "{5009834F-2D6A-41CE-9E1B-17C5AFF7A782}"
    Initialize(pISource, options)
      => ComCall(8, this.p, IWICBitmapSource, pISource, WICBitmapTransformOptions, options)
}
struct IWICBitmapToneMapper extends IWICBitmapSource {
    static IID := "{44728DED-1EDF-4FE9-B50B-C89A264C9439}"
    InitializeForHdrTarget(pISource, guidDstFormat, fLuminanceInNits, fWhiteLevelInNits, mode)
      => ComCall(8, this.p, IWICBitmapSource, pISource, GUID.Ptr, guidDstFormat, Float32, fLuminanceInNits, Float32, fWhiteLevelInNits, WICBitmapToneMappingMode, mode)
    InitializeForSdrTarget(pISource, guidDstFormat, mode)
      => ComCall(9, this.p, IWICBitmapSource, pISource, GUID.Ptr, guidDstFormat, WICBitmapToneMappingMode, mode)
}
struct IWICBitmapLock extends IUnknown {
    static IID := "{00000123-A8F2-4877-BA0A-FD2B6645FB94}"
    GetSize(puiWidth, puiHeight)
      => ComCall(3, this.p, UInt32.Ptr, puiWidth, UInt32.Ptr, puiHeight)
    GetStride(pcbStride)
      => ComCall(4, this.p, UInt32.Ptr, pcbStride)
    GetDataPointer(ppbData)
      => ComCall(5, this.p, UInt32.Ptr, ppbData.Length, UInt8.Ptr.Ptr, ppbData)
    GetPixelFormat(pPixelFormat)
      => ComCall(6, this.p, GUID.Ptr, pPixelFormat)
}
struct IWICBitmap extends IWICBitmapSource {
    static IID := "{00000121-A8F2-4877-BA0A-FD2B6645FB94}"
    Lock(prcLock, flags, ppILock)
      => ComCall(8, this.p, WICRect.Ptr, prcLock, UInt32, flags, IWICBitmapLock.Ptr, ppILock)
    SetPalette(pIPalette)
      => ComCall(9, this.p, IWICPalette, pIPalette)
    SetResolution(dpiX, dpiY)
      => ComCall(10, this.p, Float64, dpiX, Float64, dpiY)
}
struct IWICColorContext extends IUnknown {
    static IID := "{3C613A02-34B2-44EA-9A7C-45AEA9C6FD6D}"
    InitializeFromFilename(wzFilename)
      => ComCall(3, this.p, "Str", wzFilename)
    InitializeFromMemory(pbBuffer)
      => ComCall(4, this.p, UInt8.Ptr, pbBuffer, UInt32, pbBuffer.Length)
    InitializeFromExifColorSpace(value)
      => ComCall(5, this.p, UInt32, value)
    GetType(pType)
      => ComCall(6, this.p, WICColorContextType.Ptr, pType)
    GetProfileBytes(pbBuffer, pcbActual)
      => ComCall(7, this.p, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer, UInt32.Ptr, pcbActual)
    GetExifColorSpace(pValue)
      => ComCall(8, this.p, UInt32.Ptr, pValue)
}
struct IWICColorTransform extends IWICBitmapSource {
    static IID := "{B66F034F-D0E2-40AB-B436-6DE39E321A94}"
    Initialize(pIBitmapSource, pIContextSource, pIContextDest, pixelFmtDest)
      => ComCall(8, this.p, IWICBitmapSource, pIBitmapSource, IWICColorContext, pIContextSource, IWICColorContext, pIContextDest, GUID.Ptr, pixelFmtDest)
}
struct IWICFastMetadataEncoder extends IUnknown {
    static IID := "{B84E2C09-78C9-4AC4-8BD3-524AE1663A2F}"
    Commit()
      => ComCall(3, this.p)
    GetMetadataQueryWriter(ppIMetadataQueryWriter)
      => ComCall(4, this.p, IWICMetadataQueryWriter.Ptr, ppIMetadataQueryWriter)
}
struct IWICStream extends IStream {
    static IID := "{135FF860-22B7-4DDF-B0F6-218F4F299A43}"
    InitializeFromIStream(pIStream)
      => ComCall(14, this.p, IStream, pIStream)
    InitializeFromFilename(wzFileName, dwDesiredAccess)
      => ComCall(15, this.p, "Str", wzFileName, UInt32, dwDesiredAccess)
    InitializeFromMemory(pbBuffer)
      => ComCall(16, this.p, UInt8.Ptr, pbBuffer, UInt32, pbBuffer.Length)
    InitializeFromIStreamRegion(pIStream, ulOffset, ulMaxSize)
      => ComCall(17, this.p, IStream, pIStream, Int64, ulOffset, Int64, ulMaxSize)
}
struct IWICEnumMetadataItem extends IUnknown {
    static IID := "{DC2BB46D-3F07-481E-8625-220C4AEDBB33}"
    Next(rgeltSchema, rgeltId, rgeltValue, pceltFetched)
      => ComCall(3, this.p, UInt32, rgeltValue.Length, PROPVARIANT.Ptr, rgeltSchema, PROPVARIANT.Ptr, rgeltId, PROPVARIANT.Ptr, rgeltValue, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnumMetadataItem)
      => ComCall(6, this.p, IWICEnumMetadataItem.Ptr, ppIEnumMetadataItem)
}
struct IWICMetadataQueryReader extends IUnknown {
    static IID := "{30989668-E1C9-4597-B395-458EEDB808DF}"
    GetContainerFormat(pguidContainerFormat)
      => ComCall(3, this.p, GUID.Ptr, pguidContainerFormat)
    GetLocation(wzNamespace, pcchActualLength)
      => ComCall(4, this.p, UInt32, wzNamespace.Length, PWSTR, wzNamespace, UInt32.Ptr, pcchActualLength)
    GetMetadataByName(wzName, pvarValue)
      => ComCall(5, this.p, "Str", wzName, PROPVARIANT.Ptr, pvarValue)
    GetEnumerator(ppIEnumString)
      => ComCall(6, this.p, IEnumString.Ptr, ppIEnumString)
}
struct IWICMetadataQueryWriter extends IWICMetadataQueryReader {
    static IID := "{A721791A-0DEF-4D06-BD91-2118BF1DB10B}"
    SetMetadataByName(wzName, pvarValue)
      => ComCall(7, this.p, "Str", wzName, PROPVARIANT.Ptr, pvarValue)
    RemoveMetadataByName(wzName)
      => ComCall(8, this.p, "Str", wzName)
}
struct IWICBitmapEncoder extends IUnknown {
    static IID := "{00000103-A8F2-4877-BA0A-FD2B6645FB94}"
    Initialize(pIStream, cacheOption)
      => ComCall(3, this.p, IStream, pIStream, WICBitmapEncoderCacheOption, cacheOption)
    GetContainerFormat(pguidContainerFormat)
      => ComCall(4, this.p, GUID.Ptr, pguidContainerFormat)
    GetEncoderInfo(ppIEncoderInfo)
      => ComCall(5, this.p, IWICBitmapEncoderInfo.Ptr, ppIEncoderInfo)
    SetColorContexts(ppIColorContext)
      => ComCall(6, this.p, UInt32, ppIColorContext.Length, IWICColorContext.Ptr, ppIColorContext)
    SetPalette(pIPalette)
      => ComCall(7, this.p, IWICPalette, pIPalette)
    SetThumbnail(pIThumbnail)
      => ComCall(8, this.p, IWICBitmapSource, pIThumbnail)
    SetPreview(pIPreview)
      => ComCall(9, this.p, IWICBitmapSource, pIPreview)
    CreateNewFrame(ppIFrameEncode, ppIEncoderOptions)
      => ComCall(10, this.p, IWICBitmapFrameEncode.Ptr, ppIFrameEncode, IPropertyBag2.Ptr, ppIEncoderOptions)
    Commit()
      => ComCall(11, this.p)
    GetMetadataQueryWriter(ppIMetadataQueryWriter)
      => ComCall(12, this.p, IWICMetadataQueryWriter.Ptr, ppIMetadataQueryWriter)
}
struct IWICBitmapFrameEncode extends IUnknown {
    static IID := "{00000105-A8F2-4877-BA0A-FD2B6645FB94}"
    Initialize(pIEncoderOptions)
      => ComCall(3, this.p, IPropertyBag2, pIEncoderOptions)
    SetSize(uiWidth, uiHeight)
      => ComCall(4, this.p, UInt32, uiWidth, UInt32, uiHeight)
    SetResolution(dpiX, dpiY)
      => ComCall(5, this.p, Float64, dpiX, Float64, dpiY)
    SetPixelFormat(pPixelFormat)
      => ComCall(6, this.p, GUID.Ptr, pPixelFormat)
    SetColorContexts(ppIColorContext)
      => ComCall(7, this.p, UInt32, ppIColorContext.Length, IWICColorContext.Ptr, ppIColorContext)
    SetPalette(pIPalette)
      => ComCall(8, this.p, IWICPalette, pIPalette)
    SetThumbnail(pIThumbnail)
      => ComCall(9, this.p, IWICBitmapSource, pIThumbnail)
    WritePixels(lineCount, cbStride, pbPixels)
      => ComCall(10, this.p, UInt32, lineCount, UInt32, cbStride, UInt32, pbPixels.Length, UInt8.Ptr, pbPixels)
    WriteSource(pIBitmapSource, prc)
      => ComCall(11, this.p, IWICBitmapSource, pIBitmapSource, WICRect.Ptr, prc)
    Commit()
      => ComCall(12, this.p)
    GetMetadataQueryWriter(ppIMetadataQueryWriter)
      => ComCall(13, this.p, IWICMetadataQueryWriter.Ptr, ppIMetadataQueryWriter)
}
struct IWICPlanarBitmapFrameEncode extends IUnknown {
    static IID := "{F928B7B8-2221-40C1-B72E-7E82F1974D1A}"
    WritePixels(lineCount, pPlanes)
      => ComCall(3, this.p, UInt32, lineCount, WICBitmapPlane.Ptr, pPlanes, UInt32, pPlanes.Length)
    WriteSource(ppPlanes, prcSource)
      => ComCall(4, this.p, IWICBitmapSource.Ptr, ppPlanes, UInt32, ppPlanes.Length, WICRect.Ptr, prcSource)
}
struct IWICBitmapDecoder extends IUnknown {
    static IID := "{9EDDE9E7-8DEE-47EA-99DF-E6FAF2ED44BF}"
    QueryCapability(pIStream, pdwCapability)
      => ComCall(3, this.p, IStream, pIStream, UInt32.Ptr, pdwCapability)
    Initialize(pIStream, cacheOptions)
      => ComCall(4, this.p, IStream, pIStream, WICDecodeOptions, cacheOptions)
    GetContainerFormat(pguidContainerFormat)
      => ComCall(5, this.p, GUID.Ptr, pguidContainerFormat)
    GetDecoderInfo(ppIDecoderInfo)
      => ComCall(6, this.p, IWICBitmapDecoderInfo.Ptr, ppIDecoderInfo)
    CopyPalette(pIPalette)
      => ComCall(7, this.p, IWICPalette, pIPalette)
    GetMetadataQueryReader(ppIMetadataQueryReader)
      => ComCall(8, this.p, IWICMetadataQueryReader.Ptr, ppIMetadataQueryReader)
    GetPreview(ppIBitmapSource)
      => ComCall(9, this.p, IWICBitmapSource.Ptr, ppIBitmapSource)
    GetColorContexts(ppIColorContexts, pcActualCount)
      => ComCall(10, this.p, UInt32, ppIColorContexts.Length, IWICColorContext.Ptr, ppIColorContexts, UInt32.Ptr, pcActualCount)
    GetThumbnail(ppIThumbnail)
      => ComCall(11, this.p, IWICBitmapSource.Ptr, ppIThumbnail)
    GetFrameCount(pCount)
      => ComCall(12, this.p, UInt32.Ptr, pCount)
    GetFrame(index, ppIBitmapFrame)
      => ComCall(13, this.p, UInt32, index, IWICBitmapFrameDecode.Ptr, ppIBitmapFrame)
}
struct IWICBitmapSourceTransform extends IUnknown {
    static IID := "{3B16811B-6A43-4EC9-B713-3D5A0C13B940}"
    CopyPixels(prc, uiWidth, uiHeight, pguidDstFormat, dstTransform, nStride, pbBuffer)
      => ComCall(3, this.p, WICRect.Ptr, prc, UInt32, uiWidth, UInt32, uiHeight, GUID.Ptr, pguidDstFormat, WICBitmapTransformOptions, dstTransform, UInt32, nStride, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer)
    GetClosestSize(puiWidth, puiHeight)
      => ComCall(4, this.p, UInt32.Ptr, puiWidth, UInt32.Ptr, puiHeight)
    GetClosestPixelFormat(pguidDstFormat)
      => ComCall(5, this.p, GUID.Ptr, pguidDstFormat)
    DoesSupportTransform(dstTransform, pfIsSupported)
      => ComCall(6, this.p, WICBitmapTransformOptions, dstTransform, BOOL.Ptr, pfIsSupported)
}
struct IWICBitmapSourceTransform2 extends IWICBitmapSourceTransform {
    static IID := "{C3373FDF-6D39-4E5F-8E79-BF40C0B7ED77}"
    GetColorContextsForPixelFormat(pPixelFormat, ppIColorContexts, pcActualCount)
      => ComCall(7, this.p, GUID.Ptr, pPixelFormat, UInt32, ppIColorContexts.Length, IWICColorContext.Ptr, ppIColorContexts, UInt32.Ptr, pcActualCount)
}
struct IWICPlanarBitmapSourceTransform extends IUnknown {
    static IID := "{3AFF9CCE-BE95-4303-B927-E7D16FF4A613}"
    DoesSupportTransform(puiWidth, puiHeight, dstTransform, dstPlanarOptions, pguidDstFormats, pPlaneDescriptions, pfIsSupported)
      => ComCall(3, this.p, UInt32.Ptr, puiWidth, UInt32.Ptr, puiHeight, WICBitmapTransformOptions, dstTransform, WICPlanarOptions, dstPlanarOptions, GUID.Ptr, pguidDstFormats, WICBitmapPlaneDescription.Ptr, pPlaneDescriptions, UInt32, pPlaneDescriptions.Length, BOOL.Ptr, pfIsSupported)
    CopyPixels(prcSource, uiWidth, uiHeight, dstTransform, dstPlanarOptions, pDstPlanes)
      => ComCall(4, this.p, WICRect.Ptr, prcSource, UInt32, uiWidth, UInt32, uiHeight, WICBitmapTransformOptions, dstTransform, WICPlanarOptions, dstPlanarOptions, WICBitmapPlane.Ptr, pDstPlanes, UInt32, pDstPlanes.Length)
}
struct IWICBitmapFrameDecode extends IWICBitmapSource {
    static IID := "{3B16811B-6A43-4EC9-A813-3D930C13B940}"
    GetMetadataQueryReader(ppIMetadataQueryReader)
      => ComCall(8, this.p, IWICMetadataQueryReader.Ptr, ppIMetadataQueryReader)
    GetColorContexts(ppIColorContexts, pcActualCount)
      => ComCall(9, this.p, UInt32, ppIColorContexts.Length, IWICColorContext.Ptr, ppIColorContexts, UInt32.Ptr, pcActualCount)
    GetThumbnail(ppIThumbnail)
      => ComCall(10, this.p, IWICBitmapSource.Ptr, ppIThumbnail)
}
struct IWICBitmapFrameChainReader extends IUnknown {
    static IID := "{0C599495-A120-4222-9130-A8C29410BD0B}"
    GetChainedFrameCount(chainType, pCount)
      => ComCall(3, this.p, WICBitmapChainType, chainType, UInt32.Ptr, pCount)
    GetChainedFrame(chainType, index, ppIBitmapFrame)
      => ComCall(4, this.p, WICBitmapChainType, chainType, UInt32, index, IWICBitmapFrameDecode.Ptr, ppIBitmapFrame)
}
struct IWICBitmapFrameChainWriter extends IUnknown {
    static IID := "{40D9EA28-4768-47B3-8C12-558A48E98E38}"
    AppendFrameToChain(chainType, ppIFrameEncode, ppIEncoderOptions)
      => ComCall(3, this.p, WICBitmapChainType, chainType, IWICBitmapFrameEncode.Ptr, ppIFrameEncode, IPropertyBag2.Ptr, ppIEncoderOptions)
    DoesSupportChainType(chainType, pfIsSupported)
      => ComCall(4, this.p, WICBitmapChainType, chainType, BOOL.Ptr, pfIsSupported)
}
struct IWICProgressiveLevelControl extends IUnknown {
    static IID := "{DAAC296F-7AA5-4DBF-8D15-225C5976F891}"
    GetLevelCount(pcLevels)
      => ComCall(3, this.p, UInt32.Ptr, pcLevels)
    GetCurrentLevel(pnLevel)
      => ComCall(4, this.p, UInt32.Ptr, pnLevel)
    SetCurrentLevel(nLevel)
      => ComCall(5, this.p, UInt32, nLevel)
}
struct IWICDisplayAdaptationControl extends IUnknown {
    static IID := "{DE9D91D2-70B4-4F41-836C-25FCD39626D3}"
    DoesSupportChangingMaxLuminance(pguidDstFormat, pfIsSupported)
      => ComCall(3, this.p, GUID.Ptr, pguidDstFormat, BOOL.Ptr, pfIsSupported)
    SetDisplayMaxLuminance(fLuminanceInNits)
      => ComCall(4, this.p, Float32, fLuminanceInNits)
    GetDisplayMaxLuminance(pfLuminanceInNits)
      => ComCall(5, this.p, Float32.Ptr, pfLuminanceInNits)
}
struct IWICDisplayAdaptationControl2 extends IWICDisplayAdaptationControl {
    static IID := "{D7508D29-3AB7-447E-A676-4D80D7DE726B}"
    SetSdrWhiteLevel(fWhiteLevelInNits)
      => ComCall(6, this.p, Float32, fWhiteLevelInNits)
    GetSdrWhiteLevel(pfWhiteLevelInNits)
      => ComCall(7, this.p, Float32.Ptr, pfWhiteLevelInNits)
    SetToneMappingMode(mode)
      => ComCall(8, this.p, WICBitmapToneMappingMode, mode)
    GetToneMappingMode(mode)
      => ComCall(9, this.p, WICBitmapToneMappingMode.Ptr, mode)
    DoesSupportToneMappingMode(mode, pfIsSupported)
      => ComCall(10, this.p, WICBitmapToneMappingMode, mode, BOOL.Ptr, pfIsSupported)
}
struct IWICD3DTextureSource extends IUnknown {
    static IID := "{CAF65CC4-8EBE-4718-A21F-8DBF40BB7E25}"
    GetTexture(pD3DDevice, pID3DTextureOptions?, riid, ppTexture)
      => ComCall(3, this.p, IUnknown, pD3DDevice, IPropertyBag2, pID3DTextureOptions?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppTexture)
    GetTransformedTexture(prc?, uiWidth, uiHeight, pguidDstFormat?, dstTransform, pD3DDevice, pID3DTextureOptions?, riid, ppTexture)
      => ComCall(4, this.p, WICRect.Ptr, prc?, UInt32, uiWidth, UInt32, uiHeight, GUID.Ptr, pguidDstFormat?, WICBitmapTransformOptions, dstTransform, IUnknown, pD3DDevice, IPropertyBag2, pID3DTextureOptions?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppTexture)
    DoesSupportD3DDeviceType(riid, pfIsSupported)
      => ComCall(5, this.p, GUID.Ptr, riid, BOOL.Ptr, pfIsSupported)
    GetD3DTextureOptions(ppID3DTextureOptions)
      => ComCall(6, this.p, IPropertyBag2.Ptr, ppID3DTextureOptions)
}
struct IWICProgressCallback extends IUnknown {
    static IID := "{4776F9CD-9517-45FA-BF24-E89C5EC5C60C}"
    Notify(uFrameNum, operation, dblProgress)
      => ComCall(3, this.p, UInt32, uFrameNum, WICProgressOperation, operation, Float64, dblProgress)
}
struct PFNProgressNotification extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, WICProgressOperation, Float64, HRESULT]
}
struct IWICBitmapCodecProgressNotification extends IUnknown {
    static IID := "{64C1024E-C3CF-4462-8078-88C2B11C46D9}"
    RegisterProgressNotification(pfnProgressNotification1?, pvData?, dwProgressFlags)
      => ComCall(3, this.p, PFNProgressNotification, pfnProgressNotification1?, Struct.Ptr, pvData?, UInt32, dwProgressFlags)
}
struct IWICComponentInfo extends IUnknown {
    static IID := "{23BC3F0A-698B-4357-886B-F24D50671334}"
    GetComponentType(pType)
      => ComCall(3, this.p, WICComponentType.Ptr, pType)
    GetCLSID(pclsid)
      => ComCall(4, this.p, GUID.Ptr, pclsid)
    GetSigningStatus(pStatus)
      => ComCall(5, this.p, UInt32.Ptr, pStatus)
    GetAuthor(wzAuthor, pcchActual)
      => ComCall(6, this.p, UInt32, wzAuthor.Length, PWSTR, wzAuthor, UInt32.Ptr, pcchActual)
    GetVendorGUID(pguidVendor)
      => ComCall(7, this.p, GUID.Ptr, pguidVendor)
    GetVersion(wzVersion, pcchActual)
      => ComCall(8, this.p, UInt32, wzVersion.Length, PWSTR, wzVersion, UInt32.Ptr, pcchActual)
    GetSpecVersion(wzSpecVersion, pcchActual)
      => ComCall(9, this.p, UInt32, wzSpecVersion.Length, PWSTR, wzSpecVersion, UInt32.Ptr, pcchActual)
    GetFriendlyName(wzFriendlyName, pcchActual)
      => ComCall(10, this.p, UInt32, wzFriendlyName.Length, PWSTR, wzFriendlyName, UInt32.Ptr, pcchActual)
}
struct IWICFormatConverterInfo extends IWICComponentInfo {
    static IID := "{9F34FB65-13F4-4F15-BC57-3726B5E53D9F}"
    GetPixelFormats(pPixelFormatGUIDs, pcActual)
      => ComCall(11, this.p, UInt32, pPixelFormatGUIDs.Length, GUID.Ptr, pPixelFormatGUIDs, UInt32.Ptr, pcActual)
    CreateInstance(ppIConverter)
      => ComCall(12, this.p, IWICFormatConverter.Ptr, ppIConverter)
}
struct IWICBitmapCodecInfo extends IWICComponentInfo {
    static IID := "{E87A44C4-B76E-4C47-8B09-298EB12A2714}"
    GetContainerFormat(pguidContainerFormat)
      => ComCall(11, this.p, GUID.Ptr, pguidContainerFormat)
    GetPixelFormats(pguidPixelFormats, pcActual)
      => ComCall(12, this.p, UInt32, pguidPixelFormats.Length, GUID.Ptr, pguidPixelFormats, UInt32.Ptr, pcActual)
    GetColorManagementVersion(wzColorManagementVersion, pcchActual)
      => ComCall(13, this.p, UInt32, wzColorManagementVersion.Length, PWSTR, wzColorManagementVersion, UInt32.Ptr, pcchActual)
    GetDeviceManufacturer(wzDeviceManufacturer, pcchActual)
      => ComCall(14, this.p, UInt32, wzDeviceManufacturer.Length, PWSTR, wzDeviceManufacturer, UInt32.Ptr, pcchActual)
    GetDeviceModels(wzDeviceModels, pcchActual)
      => ComCall(15, this.p, UInt32, wzDeviceModels.Length, PWSTR, wzDeviceModels, UInt32.Ptr, pcchActual)
    GetMimeTypes(wzMimeTypes, pcchActual)
      => ComCall(16, this.p, UInt32, wzMimeTypes.Length, PWSTR, wzMimeTypes, UInt32.Ptr, pcchActual)
    GetFileExtensions(wzFileExtensions, pcchActual)
      => ComCall(17, this.p, UInt32, wzFileExtensions.Length, PWSTR, wzFileExtensions, UInt32.Ptr, pcchActual)
    DoesSupportAnimation(pfSupportAnimation)
      => ComCall(18, this.p, BOOL.Ptr, pfSupportAnimation)
    DoesSupportChromakey(pfSupportChromakey)
      => ComCall(19, this.p, BOOL.Ptr, pfSupportChromakey)
    DoesSupportLossless(pfSupportLossless)
      => ComCall(20, this.p, BOOL.Ptr, pfSupportLossless)
    DoesSupportMultiframe(pfSupportMultiframe)
      => ComCall(21, this.p, BOOL.Ptr, pfSupportMultiframe)
    MatchesMimeType(wzMimeType, pfMatches)
      => ComCall(22, this.p, "Str", wzMimeType, BOOL.Ptr, pfMatches)
}
struct IWICBitmapEncoderInfo extends IWICBitmapCodecInfo {
    static IID := "{94C9B4EE-A09F-4F92-8A1E-4A9BCE7E76FB}"
    CreateInstance(ppIBitmapEncoder)
      => ComCall(23, this.p, IWICBitmapEncoder.Ptr, ppIBitmapEncoder)
}
struct IWICBitmapDecoderInfo extends IWICBitmapCodecInfo {
    static IID := "{D8CD007F-D08F-4191-9BFC-236EA7F0E4B5}"
    GetPatterns(pPatterns?, pcPatterns?, pcbPatternsActual)
      => ComCall(23, this.p, UInt32, pPatterns?.Size ?? 0, WICBitmapPattern.Ptr, pPatterns?, UInt32.Ptr, pcPatterns?, UInt32.Ptr, pcbPatternsActual)
    MatchesPattern(pIStream, pfMatches)
      => ComCall(24, this.p, IStream, pIStream, BOOL.Ptr, pfMatches)
    CreateInstance(ppIBitmapDecoder)
      => ComCall(25, this.p, IWICBitmapDecoder.Ptr, ppIBitmapDecoder)
}
struct IWICPixelFormatInfo extends IWICComponentInfo {
    static IID := "{E8EDA601-3D48-431A-AB44-69059BE88BBE}"
    GetFormatGUID(pFormat)
      => ComCall(11, this.p, GUID.Ptr, pFormat)
    GetColorContext(ppIColorContext)
      => ComCall(12, this.p, IWICColorContext.Ptr, ppIColorContext)
    GetBitsPerPixel(puiBitsPerPixel)
      => ComCall(13, this.p, UInt32.Ptr, puiBitsPerPixel)
    GetChannelCount(puiChannelCount)
      => ComCall(14, this.p, UInt32.Ptr, puiChannelCount)
    GetChannelMask(uiChannelIndex, pbMaskBuffer, pcbActual)
      => ComCall(15, this.p, UInt32, uiChannelIndex, UInt32, pbMaskBuffer.Length, UInt8.Ptr, pbMaskBuffer, UInt32.Ptr, pcbActual)
}
struct IWICPixelFormatInfo2 extends IWICPixelFormatInfo {
    static IID := "{A9DB33A2-AF5F-43C7-B679-74F5984B5AA4}"
    SupportsTransparency(pfSupportsTransparency)
      => ComCall(16, this.p, BOOL.Ptr, pfSupportsTransparency)
    GetNumericRepresentation(pNumericRepresentation)
      => ComCall(17, this.p, WICPixelFormatNumericRepresentation.Ptr, pNumericRepresentation)
}
struct IWICImagingFactory extends IUnknown {
    static IID := "{EC5EC8A9-C395-4314-9C77-54D7A935FF70}"
    CreateDecoderFromFilename(wzFilename, pguidVendor?, dwDesiredAccess, metadataOptions, ppIDecoder)
      => ComCall(3, this.p, "Str", wzFilename, GUID.Ptr, pguidVendor?, GENERIC_ACCESS_RIGHTS, dwDesiredAccess, WICDecodeOptions, metadataOptions, IWICBitmapDecoder.Ptr, ppIDecoder)
    CreateDecoderFromStream(pIStream, pguidVendor, metadataOptions, ppIDecoder)
      => ComCall(4, this.p, IStream, pIStream, GUID.Ptr, pguidVendor, WICDecodeOptions, metadataOptions, IWICBitmapDecoder.Ptr, ppIDecoder)
    CreateDecoderFromFileHandle(hFile, pguidVendor, metadataOptions, ppIDecoder)
      => ComCall(5, this.p, IntPtr, hFile, GUID.Ptr, pguidVendor, WICDecodeOptions, metadataOptions, IWICBitmapDecoder.Ptr, ppIDecoder)
    CreateComponentInfo(clsidComponent, ppIInfo)
      => ComCall(6, this.p, GUID.Ptr, clsidComponent, IWICComponentInfo.Ptr, ppIInfo)
    CreateDecoder(guidContainerFormat, pguidVendor, ppIDecoder)
      => ComCall(7, this.p, GUID.Ptr, guidContainerFormat, GUID.Ptr, pguidVendor, IWICBitmapDecoder.Ptr, ppIDecoder)
    CreateEncoder(guidContainerFormat, pguidVendor, ppIEncoder)
      => ComCall(8, this.p, GUID.Ptr, guidContainerFormat, GUID.Ptr, pguidVendor, IWICBitmapEncoder.Ptr, ppIEncoder)
    CreatePalette(ppIPalette)
      => ComCall(9, this.p, IWICPalette.Ptr, ppIPalette)
    CreateFormatConverter(ppIFormatConverter)
      => ComCall(10, this.p, IWICFormatConverter.Ptr, ppIFormatConverter)
    CreateBitmapScaler(ppIBitmapScaler)
      => ComCall(11, this.p, IWICBitmapScaler.Ptr, ppIBitmapScaler)
    CreateBitmapClipper(ppIBitmapClipper)
      => ComCall(12, this.p, IWICBitmapClipper.Ptr, ppIBitmapClipper)
    CreateBitmapFlipRotator(ppIBitmapFlipRotator)
      => ComCall(13, this.p, IWICBitmapFlipRotator.Ptr, ppIBitmapFlipRotator)
    CreateStream(ppIWICStream)
      => ComCall(14, this.p, IWICStream.Ptr, ppIWICStream)
    CreateColorContext(ppIWICColorContext)
      => ComCall(15, this.p, IWICColorContext.Ptr, ppIWICColorContext)
    CreateColorTransformer(ppIWICColorTransform)
      => ComCall(16, this.p, IWICColorTransform.Ptr, ppIWICColorTransform)
    CreateBitmap(uiWidth, uiHeight, pixelFormat, option, ppIBitmap)
      => ComCall(17, this.p, UInt32, uiWidth, UInt32, uiHeight, GUID.Ptr, pixelFormat, WICBitmapCreateCacheOption, option, IWICBitmap.Ptr, ppIBitmap)
    CreateBitmapFromSource(pIBitmapSource, option, ppIBitmap)
      => ComCall(18, this.p, IWICBitmapSource, pIBitmapSource, WICBitmapCreateCacheOption, option, IWICBitmap.Ptr, ppIBitmap)
    CreateBitmapFromSourceRect(pIBitmapSource, x, y, width, height, ppIBitmap)
      => ComCall(19, this.p, IWICBitmapSource, pIBitmapSource, UInt32, x, UInt32, y, UInt32, width, UInt32, height, IWICBitmap.Ptr, ppIBitmap)
    CreateBitmapFromMemory(uiWidth, uiHeight, pixelFormat, cbStride, pbBuffer, ppIBitmap)
      => ComCall(20, this.p, UInt32, uiWidth, UInt32, uiHeight, GUID.Ptr, pixelFormat, UInt32, cbStride, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer, IWICBitmap.Ptr, ppIBitmap)
    CreateBitmapFromHBITMAP(hBitmap1, hPalette1, options, ppIBitmap)
      => ComCall(21, this.p, HBITMAP, hBitmap1, HPALETTE, hPalette1, WICBitmapAlphaChannelOption, options, IWICBitmap.Ptr, ppIBitmap)
    CreateBitmapFromHICON(hIcon1, ppIBitmap)
      => ComCall(22, this.p, HICON, hIcon1, IWICBitmap.Ptr, ppIBitmap)
    CreateComponentEnumerator(componentTypes, options, ppIEnumUnknown)
      => ComCall(23, this.p, UInt32, componentTypes, UInt32, options, IEnumUnknown.Ptr, ppIEnumUnknown)
    CreateFastMetadataEncoderFromDecoder(pIDecoder, ppIFastEncoder)
      => ComCall(24, this.p, IWICBitmapDecoder, pIDecoder, IWICFastMetadataEncoder.Ptr, ppIFastEncoder)
    CreateFastMetadataEncoderFromFrameDecode(pIFrameDecoder, ppIFastEncoder)
      => ComCall(25, this.p, IWICBitmapFrameDecode, pIFrameDecoder, IWICFastMetadataEncoder.Ptr, ppIFastEncoder)
    CreateQueryWriter(guidMetadataFormat, pguidVendor, ppIQueryWriter)
      => ComCall(26, this.p, GUID.Ptr, guidMetadataFormat, GUID.Ptr, pguidVendor, IWICMetadataQueryWriter.Ptr, ppIQueryWriter)
    CreateQueryWriterFromReader(pIQueryReader, pguidVendor, ppIQueryWriter)
      => ComCall(27, this.p, IWICMetadataQueryReader, pIQueryReader, GUID.Ptr, pguidVendor, IWICMetadataQueryWriter.Ptr, ppIQueryWriter)
}
struct WICTiffCompressionOption extends Int32 {
    static WICTiffCompressionDontCare := 0
    static WICTiffCompressionNone := 1
    static WICTiffCompressionCCITT3 := 2
    static WICTiffCompressionCCITT4 := 3
    static WICTiffCompressionLZW := 4
    static WICTiffCompressionRLE := 5
    static WICTiffCompressionZIP := 6
    static WICTiffCompressionLZWHDifferencing := 7
}
struct WICJpegYCrCbSubsamplingOption extends Int32 {
    static WICJpegYCrCbSubsamplingDefault := 0
    static WICJpegYCrCbSubsampling420 := 1
    static WICJpegYCrCbSubsampling422 := 2
    static WICJpegYCrCbSubsampling444 := 3
    static WICJpegYCrCbSubsampling440 := 4
}
struct WICPngFilterOption extends Int32 {
    static WICPngFilterUnspecified := 0
    static WICPngFilterNone := 1
    static WICPngFilterSub := 2
    static WICPngFilterUp := 3
    static WICPngFilterAverage := 4
    static WICPngFilterPaeth := 5
    static WICPngFilterAdaptive := 6
}
struct WICHeifCompressionOption extends Int32 {
    static WICHeifCompressionDontCare := 0
    static WICHeifCompressionNone := 1
    static WICHeifCompressionHEVC := 2
    static WICHeifCompressionAV1 := 3
    static WICHeifCompressionJpegXL := 4
    static WICHeifCompressionBrotli := 5
    static WICHeifCompressionDeflate := 6
}
struct WICNamedWhitePoint extends Int32 {
    static WICWhitePointDefault := 1
    static WICWhitePointDaylight := 2
    static WICWhitePointCloudy := 4
    static WICWhitePointShade := 8
    static WICWhitePointTungsten := 16
    static WICWhitePointFluorescent := 32
    static WICWhitePointFlash := 64
    static WICWhitePointUnderwater := 128
    static WICWhitePointCustom := 256
    static WICWhitePointAutoWhiteBalance := 512
    static WICWhitePointAsShot := 1
}
struct WICRawCapabilities extends Int32 {
    static WICRawCapabilityNotSupported := 0
    static WICRawCapabilityGetSupported := 1
    static WICRawCapabilityFullySupported := 2
}
struct WICRawRotationCapabilities extends Int32 {
    static WICRawRotationCapabilityNotSupported := 0
    static WICRawRotationCapabilityGetSupported := 1
    static WICRawRotationCapabilityNinetyDegreesSupported := 2
    static WICRawRotationCapabilityFullySupported := 3
}
struct WICRawCapabilitiesInfo {
    cbSize : UInt32 := this.Size
    CodecMajorVersion : UInt32
    CodecMinorVersion : UInt32
    ExposureCompensationSupport : WICRawCapabilities
    ContrastSupport : WICRawCapabilities
    RGBWhitePointSupport : WICRawCapabilities
    NamedWhitePointSupport : WICRawCapabilities
    NamedWhitePointSupportMask : UInt32
    KelvinWhitePointSupport : WICRawCapabilities
    GammaSupport : WICRawCapabilities
    TintSupport : WICRawCapabilities
    SaturationSupport : WICRawCapabilities
    SharpnessSupport : WICRawCapabilities
    NoiseReductionSupport : WICRawCapabilities
    DestinationColorProfileSupport : WICRawCapabilities
    ToneCurveSupport : WICRawCapabilities
    RotationSupport : WICRawRotationCapabilities
    RenderModeSupport : WICRawCapabilities
}
struct WICRawParameterSet extends Int32 {
    static WICAsShotParameterSet := 1
    static WICUserAdjustedParameterSet := 2
    static WICAutoAdjustedParameterSet := 3
}
struct WICRawRenderMode extends Int32 {
    static WICRawRenderModeDraft := 1
    static WICRawRenderModeNormal := 2
    static WICRawRenderModeBestQuality := 3
}
struct WICRawToneCurvePoint {
    Input : Float64
    Output : Float64
}
struct WICRawToneCurve {
    cPoints : UInt32
    aPoints : WICRawToneCurvePoint[1]
}
struct IWICDevelopRawNotificationCallback extends IUnknown {
    static IID := "{95C75A6E-3E8C-4EC2-85A8-AEBCC551E59B}"
    Notify(NotificationMask)
      => ComCall(3, this.p, UInt32, NotificationMask)
}
struct IWICDevelopRaw extends IWICBitmapFrameDecode {
    static IID := "{FBEC5E44-F7BE-4B65-B7F8-C0C81FEF026D}"
    QueryRawCapabilitiesInfo(pInfo)
      => ComCall(11, this.p, WICRawCapabilitiesInfo.Ptr, pInfo)
    LoadParameterSet(ParameterSet)
      => ComCall(12, this.p, WICRawParameterSet, ParameterSet)
    GetCurrentParameterSet(ppCurrentParameterSet)
      => ComCall(13, this.p, IPropertyBag2.Ptr, ppCurrentParameterSet)
    SetExposureCompensation(ev)
      => ComCall(14, this.p, Float64, ev)
    GetExposureCompensation(pEV)
      => ComCall(15, this.p, Float64.Ptr, pEV)
    SetWhitePointRGB(Red, Green, Blue)
      => ComCall(16, this.p, UInt32, Red, UInt32, Green, UInt32, Blue)
    GetWhitePointRGB(pRed, pGreen, pBlue)
      => ComCall(17, this.p, UInt32.Ptr, pRed, UInt32.Ptr, pGreen, UInt32.Ptr, pBlue)
    SetNamedWhitePoint(WhitePoint)
      => ComCall(18, this.p, WICNamedWhitePoint, WhitePoint)
    GetNamedWhitePoint(pWhitePoint)
      => ComCall(19, this.p, WICNamedWhitePoint.Ptr, pWhitePoint)
    SetWhitePointKelvin(WhitePointKelvin)
      => ComCall(20, this.p, UInt32, WhitePointKelvin)
    GetWhitePointKelvin(pWhitePointKelvin)
      => ComCall(21, this.p, UInt32.Ptr, pWhitePointKelvin)
    GetKelvinRangeInfo(pMinKelvinTemp, pMaxKelvinTemp, pKelvinTempStepValue)
      => ComCall(22, this.p, UInt32.Ptr, pMinKelvinTemp, UInt32.Ptr, pMaxKelvinTemp, UInt32.Ptr, pKelvinTempStepValue)
    SetContrast(Contrast)
      => ComCall(23, this.p, Float64, Contrast)
    GetContrast(pContrast)
      => ComCall(24, this.p, Float64.Ptr, pContrast)
    SetGamma(Gamma)
      => ComCall(25, this.p, Float64, Gamma)
    GetGamma(pGamma)
      => ComCall(26, this.p, Float64.Ptr, pGamma)
    SetSharpness(Sharpness)
      => ComCall(27, this.p, Float64, Sharpness)
    GetSharpness(pSharpness)
      => ComCall(28, this.p, Float64.Ptr, pSharpness)
    SetSaturation(Saturation)
      => ComCall(29, this.p, Float64, Saturation)
    GetSaturation(pSaturation)
      => ComCall(30, this.p, Float64.Ptr, pSaturation)
    SetTint(Tint)
      => ComCall(31, this.p, Float64, Tint)
    GetTint(pTint)
      => ComCall(32, this.p, Float64.Ptr, pTint)
    SetNoiseReduction(NoiseReduction)
      => ComCall(33, this.p, Float64, NoiseReduction)
    GetNoiseReduction(pNoiseReduction)
      => ComCall(34, this.p, Float64.Ptr, pNoiseReduction)
    SetDestinationColorContext(pColorContext)
      => ComCall(35, this.p, IWICColorContext, pColorContext)
    SetToneCurve(pToneCurve)
      => ComCall(36, this.p, UInt32, pToneCurve.Size, WICRawToneCurve.Ptr, pToneCurve)
    GetToneCurve(pToneCurve?, pcbActualToneCurveBufferSize?)
      => ComCall(37, this.p, UInt32, pToneCurve?.Size ?? 0, WICRawToneCurve.Ptr, pToneCurve?, UInt32.Ptr, pcbActualToneCurveBufferSize?)
    SetRotation(Rotation)
      => ComCall(38, this.p, Float64, Rotation)
    GetRotation(pRotation)
      => ComCall(39, this.p, Float64.Ptr, pRotation)
    SetRenderMode(RenderMode)
      => ComCall(40, this.p, WICRawRenderMode, RenderMode)
    GetRenderMode(pRenderMode)
      => ComCall(41, this.p, WICRawRenderMode.Ptr, pRenderMode)
    SetNotificationCallback(pCallback)
      => ComCall(42, this.p, IWICDevelopRawNotificationCallback, pCallback)
}
struct WICDdsDimension extends Int32 {
    static WICDdsTexture1D := 0
    static WICDdsTexture2D := 1
    static WICDdsTexture3D := 2
    static WICDdsTextureCube := 3
}
struct WICDdsAlphaMode extends Int32 {
    static WICDdsAlphaModeUnknown := 0
    static WICDdsAlphaModeStraight := 1
    static WICDdsAlphaModePremultiplied := 2
    static WICDdsAlphaModeOpaque := 3
    static WICDdsAlphaModeCustom := 4
}
struct WICDdsParameters {
    Width : UInt32
    Height : UInt32
    Depth : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    DxgiFormat : DXGI_FORMAT
    Dimension : WICDdsDimension
    AlphaMode : WICDdsAlphaMode
}
struct IWICDdsDecoder extends IUnknown {
    static IID := "{409CD537-8532-40CB-9774-E2FEB2DF4E9C}"
    GetParameters(pParameters)
      => ComCall(3, this.p, WICDdsParameters.Ptr, pParameters)
    GetFrame(arrayIndex, mipLevel, sliceIndex, ppIBitmapFrame)
      => ComCall(4, this.p, UInt32, arrayIndex, UInt32, mipLevel, UInt32, sliceIndex, IWICBitmapFrameDecode.Ptr, ppIBitmapFrame)
}
struct IWICDdsEncoder extends IUnknown {
    static IID := "{5CACDB4C-407E-41B3-B936-D0F010CD6732}"
    SetParameters(pParameters)
      => ComCall(3, this.p, WICDdsParameters.Ptr, pParameters)
    GetParameters(pParameters)
      => ComCall(4, this.p, WICDdsParameters.Ptr, pParameters)
    CreateNewFrame(ppIFrameEncode, pArrayIndex, pMipLevel, pSliceIndex)
      => ComCall(5, this.p, IWICBitmapFrameEncode.Ptr, ppIFrameEncode, UInt32.Ptr, pArrayIndex, UInt32.Ptr, pMipLevel, UInt32.Ptr, pSliceIndex)
}
struct WICDdsFormatInfo {
    DxgiFormat : DXGI_FORMAT
    BytesPerBlock : UInt32
    BlockWidth : UInt32
    BlockHeight : UInt32
}
struct IWICDdsFrameDecode extends IUnknown {
    static IID := "{3D4C0C61-18A4-41E4-BD80-481A4FC9F464}"
    GetSizeInBlocks(pWidthInBlocks, pHeightInBlocks)
      => ComCall(3, this.p, UInt32.Ptr, pWidthInBlocks, UInt32.Ptr, pHeightInBlocks)
    GetFormatInfo(pFormatInfo)
      => ComCall(4, this.p, WICDdsFormatInfo.Ptr, pFormatInfo)
    CopyBlocks(prcBoundsInBlocks, cbStride, pbBuffer)
      => ComCall(5, this.p, WICRect.Ptr, prcBoundsInBlocks, UInt32, cbStride, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer)
}
struct IWICJpegFrameDecode extends IUnknown {
    static IID := "{8939F66E-C46A-4C21-A9D1-98B327CE1679}"
    DoesSupportIndexing(pfIndexingSupported)
      => ComCall(3, this.p, BOOL.Ptr, pfIndexingSupported)
    SetIndexing(options, horizontalIntervalSize)
      => ComCall(4, this.p, WICJpegIndexingOptions, options, UInt32, horizontalIntervalSize)
    ClearIndexing()
      => ComCall(5, this.p)
    GetAcHuffmanTable(scanIndex, tableIndex, pAcHuffmanTable)
      => ComCall(6, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE.Ptr, pAcHuffmanTable)
    GetDcHuffmanTable(scanIndex, tableIndex, pDcHuffmanTable)
      => ComCall(7, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE.Ptr, pDcHuffmanTable)
    GetQuantizationTable(scanIndex, tableIndex, pQuantizationTable)
      => ComCall(8, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_QUANTIZATION_TABLE.Ptr, pQuantizationTable)
    GetFrameHeader(pFrameHeader)
      => ComCall(9, this.p, WICJpegFrameHeader.Ptr, pFrameHeader)
    GetScanHeader(scanIndex, pScanHeader)
      => ComCall(10, this.p, UInt32, scanIndex, WICJpegScanHeader.Ptr, pScanHeader)
    CopyScan(scanIndex, scanOffset, pbScanData, pcbScanDataActual)
      => ComCall(11, this.p, UInt32, scanIndex, UInt32, scanOffset, UInt32, pbScanData.Length, UInt8.Ptr, pbScanData, UInt32.Ptr, pcbScanDataActual)
    CopyMinimalStream(streamOffset, pbStreamData, pcbStreamDataActual)
      => ComCall(12, this.p, UInt32, streamOffset, UInt32, pbStreamData.Length, UInt8.Ptr, pbStreamData, UInt32.Ptr, pcbStreamDataActual)
}
struct IWICJpegFrameEncode extends IUnknown {
    static IID := "{2F0C601F-D2C6-468C-ABFA-49495D983ED1}"
    GetAcHuffmanTable(scanIndex, tableIndex, pAcHuffmanTable)
      => ComCall(3, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_AC_HUFFMAN_TABLE.Ptr, pAcHuffmanTable)
    GetDcHuffmanTable(scanIndex, tableIndex, pDcHuffmanTable)
      => ComCall(4, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_DC_HUFFMAN_TABLE.Ptr, pDcHuffmanTable)
    GetQuantizationTable(scanIndex, tableIndex, pQuantizationTable)
      => ComCall(5, this.p, UInt32, scanIndex, UInt32, tableIndex, DXGI_JPEG_QUANTIZATION_TABLE.Ptr, pQuantizationTable)
    WriteScan(pbScanData)
      => ComCall(6, this.p, UInt32, pbScanData.Length, UInt8.Ptr, pbScanData)
}
struct WICMetadataCreationOptions extends Int32 {
    static WICMetadataCreationDefault := 0
    static WICMetadataCreationAllowUnknown := 0
    static WICMetadataCreationFailUnknown := 65536
    static WICMetadataCreationMask := -65536
}
struct WICPersistOptions extends Int32 {
    static WICPersistOptionDefault := 0
    static WICPersistOptionLittleEndian := 0
    static WICPersistOptionBigEndian := 1
    static WICPersistOptionStrictFormat := 2
    static WICPersistOptionNoCacheStream := 4
    static WICPersistOptionPreferUTF8 := 8
    static WICPersistOptionMask := 65535
}
struct IWICMetadataBlockReader extends IUnknown {
    static IID := "{FEAA2A8D-B3F3-43E4-B25C-D1DE990A1AE1}"
    GetContainerFormat(pguidContainerFormat)
      => ComCall(3, this.p, GUID.Ptr, pguidContainerFormat)
    GetCount(pcCount)
      => ComCall(4, this.p, UInt32.Ptr, pcCount)
    GetReaderByIndex(nIndex, ppIMetadataReader)
      => ComCall(5, this.p, UInt32, nIndex, IWICMetadataReader.Ptr, ppIMetadataReader)
    GetEnumerator(ppIEnumMetadata)
      => ComCall(6, this.p, IEnumUnknown.Ptr, ppIEnumMetadata)
}
struct IWICMetadataBlockWriter extends IWICMetadataBlockReader {
    static IID := "{08FB9676-B444-41E8-8DBE-6A53A542BFF1}"
    InitializeFromBlockReader(pIMDBlockReader)
      => ComCall(7, this.p, IWICMetadataBlockReader, pIMDBlockReader)
    GetWriterByIndex(nIndex, ppIMetadataWriter)
      => ComCall(8, this.p, UInt32, nIndex, IWICMetadataWriter.Ptr, ppIMetadataWriter)
    AddWriter(pIMetadataWriter)
      => ComCall(9, this.p, IWICMetadataWriter, pIMetadataWriter)
    SetWriterByIndex(nIndex, pIMetadataWriter)
      => ComCall(10, this.p, UInt32, nIndex, IWICMetadataWriter, pIMetadataWriter)
    RemoveWriterByIndex(nIndex)
      => ComCall(11, this.p, UInt32, nIndex)
}
struct IWICMetadataReader extends IUnknown {
    static IID := "{9204FE99-D8FC-4FD5-A001-9536B067A899}"
    GetMetadataFormat(pguidMetadataFormat)
      => ComCall(3, this.p, GUID.Ptr, pguidMetadataFormat)
    GetMetadataHandlerInfo(ppIHandler)
      => ComCall(4, this.p, IWICMetadataHandlerInfo.Ptr, ppIHandler)
    GetCount(pcCount)
      => ComCall(5, this.p, UInt32.Ptr, pcCount)
    GetValueByIndex(nIndex, pvarSchema, pvarId, pvarValue)
      => ComCall(6, this.p, UInt32, nIndex, PROPVARIANT.Ptr, pvarSchema, PROPVARIANT.Ptr, pvarId, PROPVARIANT.Ptr, pvarValue)
    GetValue(pvarSchema, pvarId, pvarValue)
      => ComCall(7, this.p, PROPVARIANT.Ptr, pvarSchema, PROPVARIANT.Ptr, pvarId, PROPVARIANT.Ptr, pvarValue)
    GetEnumerator(ppIEnumMetadata)
      => ComCall(8, this.p, IWICEnumMetadataItem.Ptr, ppIEnumMetadata)
}
struct IWICMetadataWriter extends IWICMetadataReader {
    static IID := "{F7836E16-3BE0-470B-86BB-160D0AECD7DE}"
    SetValue(pvarSchema, pvarId, pvarValue)
      => ComCall(9, this.p, PROPVARIANT.Ptr, pvarSchema, PROPVARIANT.Ptr, pvarId, PROPVARIANT.Ptr, pvarValue)
    SetValueByIndex(nIndex, pvarSchema, pvarId, pvarValue)
      => ComCall(10, this.p, UInt32, nIndex, PROPVARIANT.Ptr, pvarSchema, PROPVARIANT.Ptr, pvarId, PROPVARIANT.Ptr, pvarValue)
    RemoveValue(pvarSchema, pvarId)
      => ComCall(11, this.p, PROPVARIANT.Ptr, pvarSchema, PROPVARIANT.Ptr, pvarId)
    RemoveValueByIndex(nIndex)
      => ComCall(12, this.p, UInt32, nIndex)
}
struct IWICStreamProvider extends IUnknown {
    static IID := "{449494BC-B468-4927-96D7-BA90D31AB505}"
    GetStream(ppIStream)
      => ComCall(3, this.p, IStream.Ptr, ppIStream)
    GetPersistOptions(pdwPersistOptions)
      => ComCall(4, this.p, UInt32.Ptr, pdwPersistOptions)
    GetPreferredVendorGUID(pguidPreferredVendor)
      => ComCall(5, this.p, GUID.Ptr, pguidPreferredVendor)
    RefreshStream()
      => ComCall(6, this.p)
}
struct IWICPersistStream extends IPersistStream {
    static IID := "{00675040-6908-45F8-86A3-49C7DFD6D9AD}"
    LoadEx(pIStream, pguidPreferredVendor, dwPersistOptions)
      => ComCall(8, this.p, IStream, pIStream, GUID.Ptr, pguidPreferredVendor, UInt32, dwPersistOptions)
    SaveEx(pIStream, dwPersistOptions, fClearDirty)
      => ComCall(9, this.p, IStream, pIStream, UInt32, dwPersistOptions, BOOL, fClearDirty)
}
struct IWICMetadataHandlerInfo extends IWICComponentInfo {
    static IID := "{ABA958BF-C672-44D1-8D61-CE6DF2E682C2}"
    GetMetadataFormat(pguidMetadataFormat)
      => ComCall(11, this.p, GUID.Ptr, pguidMetadataFormat)
    GetContainerFormats(pguidContainerFormats, pcchActual)
      => ComCall(12, this.p, UInt32, pguidContainerFormats.Length, GUID.Ptr, pguidContainerFormats, UInt32.Ptr, pcchActual)
    GetDeviceManufacturer(wzDeviceManufacturer, pcchActual)
      => ComCall(13, this.p, UInt32, wzDeviceManufacturer.Length, PWSTR, wzDeviceManufacturer, UInt32.Ptr, pcchActual)
    GetDeviceModels(wzDeviceModels, pcchActual)
      => ComCall(14, this.p, UInt32, wzDeviceModels.Length, PWSTR, wzDeviceModels, UInt32.Ptr, pcchActual)
    DoesRequireFullStream(pfRequiresFullStream)
      => ComCall(15, this.p, BOOL.Ptr, pfRequiresFullStream)
    DoesSupportPadding(pfSupportsPadding)
      => ComCall(16, this.p, BOOL.Ptr, pfSupportsPadding)
    DoesRequireFixedSize(pfFixedSize)
      => ComCall(17, this.p, BOOL.Ptr, pfFixedSize)
}
struct WICMetadataPattern {
    Position : Int64
    Length : UInt32
    Pattern : UInt8.Ptr
    Mask : UInt8.Ptr
    DataOffset : Int64
}
struct IWICMetadataReaderInfo extends IWICMetadataHandlerInfo {
    static IID := "{EEBF1F5B-07C1-4447-A3AB-22ACAF78A804}"
    GetPatterns(guidContainerFormat, pPattern?, pcCount?, pcbActual?)
      => ComCall(18, this.p, GUID.Ptr, guidContainerFormat, UInt32, pPattern?.Size ?? 0, WICMetadataPattern.Ptr, pPattern?, UInt32.Ptr, pcCount?, UInt32.Ptr, pcbActual?)
    MatchesPattern(guidContainerFormat, pIStream, pfMatches)
      => ComCall(19, this.p, GUID.Ptr, guidContainerFormat, IStream, pIStream, BOOL.Ptr, pfMatches)
    CreateInstance(ppIReader)
      => ComCall(20, this.p, IWICMetadataReader.Ptr, ppIReader)
}
struct WICMetadataHeader {
    Position : Int64
    Length : UInt32
    Header : UInt8.Ptr
    DataOffset : Int64
}
struct IWICMetadataWriterInfo extends IWICMetadataHandlerInfo {
    static IID := "{B22E3FBA-3925-4323-B5C1-9EBFC430F236}"
    GetHeader(guidContainerFormat, pHeader?, pcbActual?)
      => ComCall(18, this.p, GUID.Ptr, guidContainerFormat, UInt32, pHeader?.Size ?? 0, WICMetadataHeader.Ptr, pHeader?, UInt32.Ptr, pcbActual?)
    CreateInstance(ppIWriter)
      => ComCall(19, this.p, IWICMetadataWriter.Ptr, ppIWriter)
}
struct IWICComponentFactory extends IWICImagingFactory {
    static IID := "{412D0C3A-9650-44FA-AF5B-DD2A06C8E8FB}"
    CreateMetadataReader(guidMetadataFormat, pguidVendor, dwOptions, pIStream, ppIReader)
      => ComCall(28, this.p, GUID.Ptr, guidMetadataFormat, GUID.Ptr, pguidVendor, UInt32, dwOptions, IStream, pIStream, IWICMetadataReader.Ptr, ppIReader)
    CreateMetadataReaderFromContainer(guidContainerFormat, pguidVendor, dwOptions, pIStream, ppIReader)
      => ComCall(29, this.p, GUID.Ptr, guidContainerFormat, GUID.Ptr, pguidVendor, UInt32, dwOptions, IStream, pIStream, IWICMetadataReader.Ptr, ppIReader)
    CreateMetadataWriter(guidMetadataFormat, pguidVendor, dwMetadataOptions, ppIWriter)
      => ComCall(30, this.p, GUID.Ptr, guidMetadataFormat, GUID.Ptr, pguidVendor, UInt32, dwMetadataOptions, IWICMetadataWriter.Ptr, ppIWriter)
    CreateMetadataWriterFromReader(pIReader, pguidVendor, ppIWriter)
      => ComCall(31, this.p, IWICMetadataReader, pIReader, GUID.Ptr, pguidVendor, IWICMetadataWriter.Ptr, ppIWriter)
    CreateQueryReaderFromBlockReader(pIBlockReader, ppIQueryReader)
      => ComCall(32, this.p, IWICMetadataBlockReader, pIBlockReader, IWICMetadataQueryReader.Ptr, ppIQueryReader)
    CreateQueryWriterFromBlockWriter(pIBlockWriter, ppIQueryWriter)
      => ComCall(33, this.p, IWICMetadataBlockWriter, pIBlockWriter, IWICMetadataQueryWriter.Ptr, ppIQueryWriter)
    CreateEncoderPropertyBag(ppropOptions, ppIPropertyBag)
      => ComCall(34, this.p, PROPBAG2.Ptr, ppropOptions, UInt32, ppropOptions.Length, IPropertyBag2.Ptr, ppIPropertyBag)
}
