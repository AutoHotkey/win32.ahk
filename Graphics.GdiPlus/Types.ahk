#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR, RECT as _F_RECT, RECTL, SIZE as _F_SIZE}
#Import "..\Graphics.Gdi\Types.ahk" {METAHEADER}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct GpGraphics {
}
struct GpBrush {
}
struct GpTexture {
}
struct GpSolidFill {
}
struct GpLineGradient {
}
struct GpPathGradient {
}
struct GpHatch {
}
struct GpPen {
}
struct GpCustomLineCap {
}
struct GpAdjustableArrowCap {
}
struct GpImage {
}
struct GpBitmap {
}
struct GpMetafile {
}
struct GpImageAttributes {
}
struct GpPath {
}
struct GpRegion {
}
struct GpPathIterator {
}
struct GpFontFamily {
}
struct GpFont {
}
struct GpStringFormat {
}
struct GpFontCollection {
}
struct GpInstalledFontCollection {
}
struct GpPrivateFontCollection {
}
struct GpCachedBitmap {
}
struct PathData {
    Value : IntPtr
}
struct CGpEffect {
    Value : IntPtr
}
struct Matrix {
    Value : IntPtr
}
struct Font {
    Value : IntPtr
}
struct FontCollection {
    Value : IntPtr
}
struct InstalledFontCollection {
    Value : IntPtr
}
struct PrivateFontCollection {
    Value : IntPtr
}
struct Image {
    Value : IntPtr
}
struct Bitmap {
    Value : IntPtr
}
struct CustomLineCap {
    Value : IntPtr
}
struct CachedBitmap {
    Value : IntPtr
}
struct Metafile {
    Value : IntPtr
}
struct FontFamily {
    Value : IntPtr
}
struct Region {
    Value : IntPtr
}
struct FillMode extends Int32 {
    static FillModeAlternate := 0
    static FillModeWinding := 1
}
struct QualityMode extends Int32 {
    static QualityModeInvalid := -1
    static QualityModeDefault := 0
    static QualityModeLow := 1
    static QualityModeHigh := 2
}
struct CompositingMode extends Int32 {
    static CompositingModeSourceOver := 0
    static CompositingModeSourceCopy := 1
}
struct CompositingQuality extends Int32 {
    static CompositingQualityInvalid := -1
    static CompositingQualityDefault := 0
    static CompositingQualityHighSpeed := 1
    static CompositingQualityHighQuality := 2
    static CompositingQualityGammaCorrected := 3
    static CompositingQualityAssumeLinear := 4
}
struct Unit extends Int32 {
    static UnitWorld := 0
    static UnitDisplay := 1
    static UnitPixel := 2
    static UnitPoint := 3
    static UnitInch := 4
    static UnitDocument := 5
    static UnitMillimeter := 6
}
struct MetafileFrameUnit extends Int32 {
    static MetafileFrameUnitPixel := 2
    static MetafileFrameUnitPoint := 3
    static MetafileFrameUnitInch := 4
    static MetafileFrameUnitDocument := 5
    static MetafileFrameUnitMillimeter := 6
    static MetafileFrameUnitGdi := 7
}
struct CoordinateSpace extends Int32 {
    static CoordinateSpaceWorld := 0
    static CoordinateSpacePage := 1
    static CoordinateSpaceDevice := 2
}
struct WrapMode extends Int32 {
    static WrapModeTile := 0
    static WrapModeTileFlipX := 1
    static WrapModeTileFlipY := 2
    static WrapModeTileFlipXY := 3
    static WrapModeClamp := 4
}
struct HatchStyle extends Int32 {
    static HatchStyleHorizontal := 0
    static HatchStyleVertical := 1
    static HatchStyleForwardDiagonal := 2
    static HatchStyleBackwardDiagonal := 3
    static HatchStyleCross := 4
    static HatchStyleDiagonalCross := 5
    static HatchStyle05Percent := 6
    static HatchStyle10Percent := 7
    static HatchStyle20Percent := 8
    static HatchStyle25Percent := 9
    static HatchStyle30Percent := 10
    static HatchStyle40Percent := 11
    static HatchStyle50Percent := 12
    static HatchStyle60Percent := 13
    static HatchStyle70Percent := 14
    static HatchStyle75Percent := 15
    static HatchStyle80Percent := 16
    static HatchStyle90Percent := 17
    static HatchStyleLightDownwardDiagonal := 18
    static HatchStyleLightUpwardDiagonal := 19
    static HatchStyleDarkDownwardDiagonal := 20
    static HatchStyleDarkUpwardDiagonal := 21
    static HatchStyleWideDownwardDiagonal := 22
    static HatchStyleWideUpwardDiagonal := 23
    static HatchStyleLightVertical := 24
    static HatchStyleLightHorizontal := 25
    static HatchStyleNarrowVertical := 26
    static HatchStyleNarrowHorizontal := 27
    static HatchStyleDarkVertical := 28
    static HatchStyleDarkHorizontal := 29
    static HatchStyleDashedDownwardDiagonal := 30
    static HatchStyleDashedUpwardDiagonal := 31
    static HatchStyleDashedHorizontal := 32
    static HatchStyleDashedVertical := 33
    static HatchStyleSmallConfetti := 34
    static HatchStyleLargeConfetti := 35
    static HatchStyleZigZag := 36
    static HatchStyleWave := 37
    static HatchStyleDiagonalBrick := 38
    static HatchStyleHorizontalBrick := 39
    static HatchStyleWeave := 40
    static HatchStylePlaid := 41
    static HatchStyleDivot := 42
    static HatchStyleDottedGrid := 43
    static HatchStyleDottedDiamond := 44
    static HatchStyleShingle := 45
    static HatchStyleTrellis := 46
    static HatchStyleSphere := 47
    static HatchStyleSmallGrid := 48
    static HatchStyleSmallCheckerBoard := 49
    static HatchStyleLargeCheckerBoard := 50
    static HatchStyleOutlinedDiamond := 51
    static HatchStyleSolidDiamond := 52
    static HatchStyleTotal := 53
    static HatchStyleLargeGrid := 4
    static HatchStyleMin := 0
    static HatchStyleMax := 52
}
struct DashStyle extends Int32 {
    static DashStyleSolid := 0
    static DashStyleDash := 1
    static DashStyleDot := 2
    static DashStyleDashDot := 3
    static DashStyleDashDotDot := 4
    static DashStyleCustom := 5
}
struct DashCap extends Int32 {
    static DashCapFlat := 0
    static DashCapRound := 2
    static DashCapTriangle := 3
}
struct LineCap extends Int32 {
    static LineCapFlat := 0
    static LineCapSquare := 1
    static LineCapRound := 2
    static LineCapTriangle := 3
    static LineCapNoAnchor := 16
    static LineCapSquareAnchor := 17
    static LineCapRoundAnchor := 18
    static LineCapDiamondAnchor := 19
    static LineCapArrowAnchor := 20
    static LineCapCustom := 255
    static LineCapAnchorMask := 240
}
struct CustomLineCapType extends Int32 {
    static CustomLineCapTypeDefault := 0
    static CustomLineCapTypeAdjustableArrow := 1
}
struct LineJoin extends Int32 {
    static LineJoinMiter := 0
    static LineJoinBevel := 1
    static LineJoinRound := 2
    static LineJoinMiterClipped := 3
}
struct PathPointType extends Int32 {
    static PathPointTypeStart := 0
    static PathPointTypeLine := 1
    static PathPointTypeBezier := 3
    static PathPointTypePathTypeMask := 7
    static PathPointTypeDashMode := 16
    static PathPointTypePathMarker := 32
    static PathPointTypeCloseSubpath := 128
    static PathPointTypeBezier3 := 3
}
struct WarpMode extends Int32 {
    static WarpModePerspective := 0
    static WarpModeBilinear := 1
}
struct LinearGradientMode extends Int32 {
    static LinearGradientModeHorizontal := 0
    static LinearGradientModeVertical := 1
    static LinearGradientModeForwardDiagonal := 2
    static LinearGradientModeBackwardDiagonal := 3
}
struct CombineMode extends Int32 {
    static CombineModeReplace := 0
    static CombineModeIntersect := 1
    static CombineModeUnion := 2
    static CombineModeXor := 3
    static CombineModeExclude := 4
    static CombineModeComplement := 5
}
struct ImageType extends Int32 {
    static ImageTypeUnknown := 0
    static ImageTypeBitmap := 1
    static ImageTypeMetafile := 2
}
struct InterpolationMode extends Int32 {
    static InterpolationModeInvalid := -1
    static InterpolationModeDefault := 0
    static InterpolationModeLowQuality := 1
    static InterpolationModeHighQuality := 2
    static InterpolationModeBilinear := 3
    static InterpolationModeBicubic := 4
    static InterpolationModeNearestNeighbor := 5
    static InterpolationModeHighQualityBilinear := 6
    static InterpolationModeHighQualityBicubic := 7
}
struct PenAlignment extends Int32 {
    static PenAlignmentCenter := 0
    static PenAlignmentInset := 1
}
struct BrushType extends Int32 {
    static BrushTypeSolidColor := 0
    static BrushTypeHatchFill := 1
    static BrushTypeTextureFill := 2
    static BrushTypePathGradient := 3
    static BrushTypeLinearGradient := 4
}
struct PenType extends Int32 {
    static PenTypeSolidColor := 0
    static PenTypeHatchFill := 1
    static PenTypeTextureFill := 2
    static PenTypePathGradient := 3
    static PenTypeLinearGradient := 4
    static PenTypeUnknown := -1
}
struct MatrixOrder extends Int32 {
    static MatrixOrderPrepend := 0
    static MatrixOrderAppend := 1
}
struct GenericFontFamily extends Int32 {
    static GenericFontFamilySerif := 0
    static GenericFontFamilySansSerif := 1
    static GenericFontFamilyMonospace := 2
}
struct FontStyle extends Int32 {
    static FontStyleRegular := 0
    static FontStyleBold := 1
    static FontStyleItalic := 2
    static FontStyleBoldItalic := 3
    static FontStyleUnderline := 4
    static FontStyleStrikeout := 8
}
struct SmoothingMode extends Int32 {
    static SmoothingModeInvalid := -1
    static SmoothingModeDefault := 0
    static SmoothingModeHighSpeed := 1
    static SmoothingModeHighQuality := 2
    static SmoothingModeNone := 3
    static SmoothingModeAntiAlias := 4
    static SmoothingModeAntiAlias8x4 := 4
    static SmoothingModeAntiAlias8x8 := 5
}
struct PixelOffsetMode extends Int32 {
    static PixelOffsetModeInvalid := -1
    static PixelOffsetModeDefault := 0
    static PixelOffsetModeHighSpeed := 1
    static PixelOffsetModeHighQuality := 2
    static PixelOffsetModeNone := 3
    static PixelOffsetModeHalf := 4
}
struct TextRenderingHint extends Int32 {
    static TextRenderingHintSystemDefault := 0
    static TextRenderingHintSingleBitPerPixelGridFit := 1
    static TextRenderingHintSingleBitPerPixel := 2
    static TextRenderingHintAntiAliasGridFit := 3
    static TextRenderingHintAntiAlias := 4
    static TextRenderingHintClearTypeGridFit := 5
}
struct MetafileType extends Int32 {
    static MetafileTypeInvalid := 0
    static MetafileTypeWmf := 1
    static MetafileTypeWmfPlaceable := 2
    static MetafileTypeEmf := 3
    static MetafileTypeEmfPlusOnly := 4
    static MetafileTypeEmfPlusDual := 5
}
struct EmfType extends Int32 {
    static EmfTypeEmfOnly := 3
    static EmfTypeEmfPlusOnly := 4
    static EmfTypeEmfPlusDual := 5
}
struct ObjectType extends Int32 {
    static ObjectTypeInvalid := 0
    static ObjectTypeBrush := 1
    static ObjectTypePen := 2
    static ObjectTypePath := 3
    static ObjectTypeRegion := 4
    static ObjectTypeImage := 5
    static ObjectTypeFont := 6
    static ObjectTypeStringFormat := 7
    static ObjectTypeImageAttributes := 8
    static ObjectTypeCustomLineCap := 9
    static ObjectTypeGraphics := 10
    static ObjectTypeMax := 10
    static ObjectTypeMin := 1
}
struct EmfPlusRecordType extends Int32 {
    static WmfRecordTypeSetBkColor := 66049
    static WmfRecordTypeSetBkMode := 65794
    static WmfRecordTypeSetMapMode := 65795
    static WmfRecordTypeSetROP2 := 65796
    static WmfRecordTypeSetRelAbs := 65797
    static WmfRecordTypeSetPolyFillMode := 65798
    static WmfRecordTypeSetStretchBltMode := 65799
    static WmfRecordTypeSetTextCharExtra := 65800
    static WmfRecordTypeSetTextColor := 66057
    static WmfRecordTypeSetTextJustification := 66058
    static WmfRecordTypeSetWindowOrg := 66059
    static WmfRecordTypeSetWindowExt := 66060
    static WmfRecordTypeSetViewportOrg := 66061
    static WmfRecordTypeSetViewportExt := 66062
    static WmfRecordTypeOffsetWindowOrg := 66063
    static WmfRecordTypeScaleWindowExt := 66576
    static WmfRecordTypeOffsetViewportOrg := 66065
    static WmfRecordTypeScaleViewportExt := 66578
    static WmfRecordTypeLineTo := 66067
    static WmfRecordTypeMoveTo := 66068
    static WmfRecordTypeExcludeClipRect := 66581
    static WmfRecordTypeIntersectClipRect := 66582
    static WmfRecordTypeArc := 67607
    static WmfRecordTypeEllipse := 66584
    static WmfRecordTypeFloodFill := 66585
    static WmfRecordTypePie := 67610
    static WmfRecordTypeRectangle := 66587
    static WmfRecordTypeRoundRect := 67100
    static WmfRecordTypePatBlt := 67101
    static WmfRecordTypeSaveDC := 65566
    static WmfRecordTypeSetPixel := 66591
    static WmfRecordTypeOffsetClipRgn := 66080
    static WmfRecordTypeTextOut := 66849
    static WmfRecordTypeBitBlt := 67874
    static WmfRecordTypeStretchBlt := 68387
    static WmfRecordTypePolygon := 66340
    static WmfRecordTypePolyline := 66341
    static WmfRecordTypeEscape := 67110
    static WmfRecordTypeRestoreDC := 65831
    static WmfRecordTypeFillRegion := 66088
    static WmfRecordTypeFrameRegion := 66601
    static WmfRecordTypeInvertRegion := 65834
    static WmfRecordTypePaintRegion := 65835
    static WmfRecordTypeSelectClipRegion := 65836
    static WmfRecordTypeSelectObject := 65837
    static WmfRecordTypeSetTextAlign := 65838
    static WmfRecordTypeDrawText := 67119
    static WmfRecordTypeChord := 67632
    static WmfRecordTypeSetMapperFlags := 66097
    static WmfRecordTypeExtTextOut := 68146
    static WmfRecordTypeSetDIBToDev := 68915
    static WmfRecordTypeSelectPalette := 66100
    static WmfRecordTypeRealizePalette := 65589
    static WmfRecordTypeAnimatePalette := 66614
    static WmfRecordTypeSetPalEntries := 65591
    static WmfRecordTypePolyPolygon := 66872
    static WmfRecordTypeResizePalette := 65849
    static WmfRecordTypeDIBBitBlt := 67904
    static WmfRecordTypeDIBStretchBlt := 68417
    static WmfRecordTypeDIBCreatePatternBrush := 65858
    static WmfRecordTypeStretchDIB := 69443
    static WmfRecordTypeExtFloodFill := 66888
    static WmfRecordTypeSetLayout := 65865
    static WmfRecordTypeResetDC := 65868
    static WmfRecordTypeStartDoc := 65869
    static WmfRecordTypeStartPage := 65615
    static WmfRecordTypeEndPage := 65616
    static WmfRecordTypeAbortDoc := 65618
    static WmfRecordTypeEndDoc := 65630
    static WmfRecordTypeDeleteObject := 66032
    static WmfRecordTypeCreatePalette := 65783
    static WmfRecordTypeCreateBrush := 65784
    static WmfRecordTypeCreatePatternBrush := 66041
    static WmfRecordTypeCreatePenIndirect := 66298
    static WmfRecordTypeCreateFontIndirect := 66299
    static WmfRecordTypeCreateBrushIndirect := 66300
    static WmfRecordTypeCreateBitmapIndirect := 66301
    static WmfRecordTypeCreateBitmap := 67326
    static WmfRecordTypeCreateRegion := 67327
    static EmfRecordTypeHeader := 1
    static EmfRecordTypePolyBezier := 2
    static EmfRecordTypePolygon := 3
    static EmfRecordTypePolyline := 4
    static EmfRecordTypePolyBezierTo := 5
    static EmfRecordTypePolyLineTo := 6
    static EmfRecordTypePolyPolyline := 7
    static EmfRecordTypePolyPolygon := 8
    static EmfRecordTypeSetWindowExtEx := 9
    static EmfRecordTypeSetWindowOrgEx := 10
    static EmfRecordTypeSetViewportExtEx := 11
    static EmfRecordTypeSetViewportOrgEx := 12
    static EmfRecordTypeSetBrushOrgEx := 13
    static EmfRecordTypeEOF := 14
    static EmfRecordTypeSetPixelV := 15
    static EmfRecordTypeSetMapperFlags := 16
    static EmfRecordTypeSetMapMode := 17
    static EmfRecordTypeSetBkMode := 18
    static EmfRecordTypeSetPolyFillMode := 19
    static EmfRecordTypeSetROP2 := 20
    static EmfRecordTypeSetStretchBltMode := 21
    static EmfRecordTypeSetTextAlign := 22
    static EmfRecordTypeSetColorAdjustment := 23
    static EmfRecordTypeSetTextColor := 24
    static EmfRecordTypeSetBkColor := 25
    static EmfRecordTypeOffsetClipRgn := 26
    static EmfRecordTypeMoveToEx := 27
    static EmfRecordTypeSetMetaRgn := 28
    static EmfRecordTypeExcludeClipRect := 29
    static EmfRecordTypeIntersectClipRect := 30
    static EmfRecordTypeScaleViewportExtEx := 31
    static EmfRecordTypeScaleWindowExtEx := 32
    static EmfRecordTypeSaveDC := 33
    static EmfRecordTypeRestoreDC := 34
    static EmfRecordTypeSetWorldTransform := 35
    static EmfRecordTypeModifyWorldTransform := 36
    static EmfRecordTypeSelectObject := 37
    static EmfRecordTypeCreatePen := 38
    static EmfRecordTypeCreateBrushIndirect := 39
    static EmfRecordTypeDeleteObject := 40
    static EmfRecordTypeAngleArc := 41
    static EmfRecordTypeEllipse := 42
    static EmfRecordTypeRectangle := 43
    static EmfRecordTypeRoundRect := 44
    static EmfRecordTypeArc := 45
    static EmfRecordTypeChord := 46
    static EmfRecordTypePie := 47
    static EmfRecordTypeSelectPalette := 48
    static EmfRecordTypeCreatePalette := 49
    static EmfRecordTypeSetPaletteEntries := 50
    static EmfRecordTypeResizePalette := 51
    static EmfRecordTypeRealizePalette := 52
    static EmfRecordTypeExtFloodFill := 53
    static EmfRecordTypeLineTo := 54
    static EmfRecordTypeArcTo := 55
    static EmfRecordTypePolyDraw := 56
    static EmfRecordTypeSetArcDirection := 57
    static EmfRecordTypeSetMiterLimit := 58
    static EmfRecordTypeBeginPath := 59
    static EmfRecordTypeEndPath := 60
    static EmfRecordTypeCloseFigure := 61
    static EmfRecordTypeFillPath := 62
    static EmfRecordTypeStrokeAndFillPath := 63
    static EmfRecordTypeStrokePath := 64
    static EmfRecordTypeFlattenPath := 65
    static EmfRecordTypeWidenPath := 66
    static EmfRecordTypeSelectClipPath := 67
    static EmfRecordTypeAbortPath := 68
    static EmfRecordTypeReserved_069 := 69
    static EmfRecordTypeGdiComment := 70
    static EmfRecordTypeFillRgn := 71
    static EmfRecordTypeFrameRgn := 72
    static EmfRecordTypeInvertRgn := 73
    static EmfRecordTypePaintRgn := 74
    static EmfRecordTypeExtSelectClipRgn := 75
    static EmfRecordTypeBitBlt := 76
    static EmfRecordTypeStretchBlt := 77
    static EmfRecordTypeMaskBlt := 78
    static EmfRecordTypePlgBlt := 79
    static EmfRecordTypeSetDIBitsToDevice := 80
    static EmfRecordTypeStretchDIBits := 81
    static EmfRecordTypeExtCreateFontIndirect := 82
    static EmfRecordTypeExtTextOutA := 83
    static EmfRecordTypeExtTextOutW := 84
    static EmfRecordTypePolyBezier16 := 85
    static EmfRecordTypePolygon16 := 86
    static EmfRecordTypePolyline16 := 87
    static EmfRecordTypePolyBezierTo16 := 88
    static EmfRecordTypePolylineTo16 := 89
    static EmfRecordTypePolyPolyline16 := 90
    static EmfRecordTypePolyPolygon16 := 91
    static EmfRecordTypePolyDraw16 := 92
    static EmfRecordTypeCreateMonoBrush := 93
    static EmfRecordTypeCreateDIBPatternBrushPt := 94
    static EmfRecordTypeExtCreatePen := 95
    static EmfRecordTypePolyTextOutA := 96
    static EmfRecordTypePolyTextOutW := 97
    static EmfRecordTypeSetICMMode := 98
    static EmfRecordTypeCreateColorSpace := 99
    static EmfRecordTypeSetColorSpace := 100
    static EmfRecordTypeDeleteColorSpace := 101
    static EmfRecordTypeGLSRecord := 102
    static EmfRecordTypeGLSBoundedRecord := 103
    static EmfRecordTypePixelFormat := 104
    static EmfRecordTypeDrawEscape := 105
    static EmfRecordTypeExtEscape := 106
    static EmfRecordTypeStartDoc := 107
    static EmfRecordTypeSmallTextOut := 108
    static EmfRecordTypeForceUFIMapping := 109
    static EmfRecordTypeNamedEscape := 110
    static EmfRecordTypeColorCorrectPalette := 111
    static EmfRecordTypeSetICMProfileA := 112
    static EmfRecordTypeSetICMProfileW := 113
    static EmfRecordTypeAlphaBlend := 114
    static EmfRecordTypeSetLayout := 115
    static EmfRecordTypeTransparentBlt := 116
    static EmfRecordTypeReserved_117 := 117
    static EmfRecordTypeGradientFill := 118
    static EmfRecordTypeSetLinkedUFIs := 119
    static EmfRecordTypeSetTextJustification := 120
    static EmfRecordTypeColorMatchToTargetW := 121
    static EmfRecordTypeCreateColorSpaceW := 122
    static EmfRecordTypeMax := 122
    static EmfRecordTypeMin := 1
    static EmfPlusRecordTypeInvalid := 16384
    static EmfPlusRecordTypeHeader := 16385
    static EmfPlusRecordTypeEndOfFile := 16386
    static EmfPlusRecordTypeComment := 16387
    static EmfPlusRecordTypeGetDC := 16388
    static EmfPlusRecordTypeMultiFormatStart := 16389
    static EmfPlusRecordTypeMultiFormatSection := 16390
    static EmfPlusRecordTypeMultiFormatEnd := 16391
    static EmfPlusRecordTypeObject := 16392
    static EmfPlusRecordTypeClear := 16393
    static EmfPlusRecordTypeFillRects := 16394
    static EmfPlusRecordTypeDrawRects := 16395
    static EmfPlusRecordTypeFillPolygon := 16396
    static EmfPlusRecordTypeDrawLines := 16397
    static EmfPlusRecordTypeFillEllipse := 16398
    static EmfPlusRecordTypeDrawEllipse := 16399
    static EmfPlusRecordTypeFillPie := 16400
    static EmfPlusRecordTypeDrawPie := 16401
    static EmfPlusRecordTypeDrawArc := 16402
    static EmfPlusRecordTypeFillRegion := 16403
    static EmfPlusRecordTypeFillPath := 16404
    static EmfPlusRecordTypeDrawPath := 16405
    static EmfPlusRecordTypeFillClosedCurve := 16406
    static EmfPlusRecordTypeDrawClosedCurve := 16407
    static EmfPlusRecordTypeDrawCurve := 16408
    static EmfPlusRecordTypeDrawBeziers := 16409
    static EmfPlusRecordTypeDrawImage := 16410
    static EmfPlusRecordTypeDrawImagePoints := 16411
    static EmfPlusRecordTypeDrawString := 16412
    static EmfPlusRecordTypeSetRenderingOrigin := 16413
    static EmfPlusRecordTypeSetAntiAliasMode := 16414
    static EmfPlusRecordTypeSetTextRenderingHint := 16415
    static EmfPlusRecordTypeSetTextContrast := 16416
    static EmfPlusRecordTypeSetInterpolationMode := 16417
    static EmfPlusRecordTypeSetPixelOffsetMode := 16418
    static EmfPlusRecordTypeSetCompositingMode := 16419
    static EmfPlusRecordTypeSetCompositingQuality := 16420
    static EmfPlusRecordTypeSave := 16421
    static EmfPlusRecordTypeRestore := 16422
    static EmfPlusRecordTypeBeginContainer := 16423
    static EmfPlusRecordTypeBeginContainerNoParams := 16424
    static EmfPlusRecordTypeEndContainer := 16425
    static EmfPlusRecordTypeSetWorldTransform := 16426
    static EmfPlusRecordTypeResetWorldTransform := 16427
    static EmfPlusRecordTypeMultiplyWorldTransform := 16428
    static EmfPlusRecordTypeTranslateWorldTransform := 16429
    static EmfPlusRecordTypeScaleWorldTransform := 16430
    static EmfPlusRecordTypeRotateWorldTransform := 16431
    static EmfPlusRecordTypeSetPageTransform := 16432
    static EmfPlusRecordTypeResetClip := 16433
    static EmfPlusRecordTypeSetClipRect := 16434
    static EmfPlusRecordTypeSetClipPath := 16435
    static EmfPlusRecordTypeSetClipRegion := 16436
    static EmfPlusRecordTypeOffsetClip := 16437
    static EmfPlusRecordTypeDrawDriverString := 16438
    static EmfPlusRecordTypeStrokeFillPath := 16439
    static EmfPlusRecordTypeSerializableObject := 16440
    static EmfPlusRecordTypeSetTSGraphics := 16441
    static EmfPlusRecordTypeSetTSClip := 16442
    static EmfPlusRecordTotal := 16443
    static EmfPlusRecordTypeMax := 16442
    static EmfPlusRecordTypeMin := 16385
}
struct StringFormatFlags extends Int32 {
    static StringFormatFlagsDirectionRightToLeft := 1
    static StringFormatFlagsDirectionVertical := 2
    static StringFormatFlagsNoFitBlackBox := 4
    static StringFormatFlagsDisplayFormatControl := 32
    static StringFormatFlagsNoFontFallback := 1024
    static StringFormatFlagsMeasureTrailingSpaces := 2048
    static StringFormatFlagsNoWrap := 4096
    static StringFormatFlagsLineLimit := 8192
    static StringFormatFlagsNoClip := 16384
    static StringFormatFlagsBypassGDI := -2147483648
}
struct StringTrimming extends Int32 {
    static StringTrimmingNone := 0
    static StringTrimmingCharacter := 1
    static StringTrimmingWord := 2
    static StringTrimmingEllipsisCharacter := 3
    static StringTrimmingEllipsisWord := 4
    static StringTrimmingEllipsisPath := 5
}
struct StringDigitSubstitute extends Int32 {
    static StringDigitSubstituteUser := 0
    static StringDigitSubstituteNone := 1
    static StringDigitSubstituteNational := 2
    static StringDigitSubstituteTraditional := 3
}
struct HotkeyPrefix extends Int32 {
    static HotkeyPrefixNone := 0
    static HotkeyPrefixShow := 1
    static HotkeyPrefixHide := 2
}
struct StringAlignment extends Int32 {
    static StringAlignmentNear := 0
    static StringAlignmentCenter := 1
    static StringAlignmentFar := 2
}
struct DriverStringOptions extends Int32 {
    static DriverStringOptionsCmapLookup := 1
    static DriverStringOptionsVertical := 2
    static DriverStringOptionsRealizedAdvance := 4
    static DriverStringOptionsLimitSubpixel := 8
}
struct FlushIntention extends Int32 {
    static FlushIntentionFlush := 0
    static FlushIntentionSync := 1
}
struct EncoderParameterValueType extends Int32 {
    static EncoderParameterValueTypeByte := 1
    static EncoderParameterValueTypeASCII := 2
    static EncoderParameterValueTypeShort := 3
    static EncoderParameterValueTypeLong := 4
    static EncoderParameterValueTypeRational := 5
    static EncoderParameterValueTypeLongRange := 6
    static EncoderParameterValueTypeUndefined := 7
    static EncoderParameterValueTypeRationalRange := 8
    static EncoderParameterValueTypePointer := 9
}
struct EncoderValue extends Int32 {
    static EncoderValueColorTypeCMYK := 0
    static EncoderValueColorTypeYCCK := 1
    static EncoderValueCompressionLZW := 2
    static EncoderValueCompressionCCITT3 := 3
    static EncoderValueCompressionCCITT4 := 4
    static EncoderValueCompressionRle := 5
    static EncoderValueCompressionNone := 6
    static EncoderValueScanMethodInterlaced := 7
    static EncoderValueScanMethodNonInterlaced := 8
    static EncoderValueVersionGif87 := 9
    static EncoderValueVersionGif89 := 10
    static EncoderValueRenderProgressive := 11
    static EncoderValueRenderNonProgressive := 12
    static EncoderValueTransformRotate90 := 13
    static EncoderValueTransformRotate180 := 14
    static EncoderValueTransformRotate270 := 15
    static EncoderValueTransformFlipHorizontal := 16
    static EncoderValueTransformFlipVertical := 17
    static EncoderValueMultiFrame := 18
    static EncoderValueLastFrame := 19
    static EncoderValueFlush := 20
    static EncoderValueFrameDimensionTime := 21
    static EncoderValueFrameDimensionResolution := 22
    static EncoderValueFrameDimensionPage := 23
    static EncoderValueColorTypeGray := 24
    static EncoderValueColorTypeRGB := 25
}
struct EmfToWmfBitsFlags extends Int32 {
    static EmfToWmfBitsFlagsDefault := 0
    static EmfToWmfBitsFlagsEmbedEmf := 1
    static EmfToWmfBitsFlagsIncludePlaceable := 2
    static EmfToWmfBitsFlagsNoXORClip := 4
}
struct ConvertToEmfPlusFlags extends Int32 {
    static ConvertToEmfPlusFlagsDefault := 0
    static ConvertToEmfPlusFlagsRopUsed := 1
    static ConvertToEmfPlusFlagsText := 2
    static ConvertToEmfPlusFlagsInvalidRecord := 4
}
struct GpTestControlEnum extends Int32 {
    static TestControlForceBilinear := 0
    static TestControlNoICM := 1
    static TestControlGetBuildNumber := 2
}
struct ImageAbort extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL]
}
struct DrawImageAbort extends FunctionPointer {
    static Types := [BOOL]
}
struct GetThumbnailImageAbort extends FunctionPointer {
    static Types := [BOOL]
}
struct EnumerateMetafileProc extends FunctionPointer {
    static Types := [EmfPlusRecordType, UInt32, UInt32, UInt8.Ptr, Struct.Ptr, BOOL]
}
struct GdiplusAbort extends InterfacePointer {
    Abort()
      => ComCall(0, this.p)
}
struct Status extends Int32 {
    static Ok := 0
    static GenericError := 1
    static InvalidParameter := 2
    static OutOfMemory := 3
    static ObjectBusy := 4
    static InsufficientBuffer := 5
    static NotImplemented := 6
    static Win32Error := 7
    static WrongState := 8
    static Aborted := 9
    static FileNotFound := 10
    static ValueOverflow := 11
    static AccessDenied := 12
    static UnknownImageFormat := 13
    static FontFamilyNotFound := 14
    static FontStyleNotFound := 15
    static NotTrueTypeFont := 16
    static UnsupportedGdiplusVersion := 17
    static GdiplusNotInitialized := 18
    static PropertyNotFound := 19
    static PropertyNotSupported := 20
    static ProfileNotFound := 21
}
struct SizeF {
    Width : Float32
    Height : Float32
}
struct Size {
    Width : Int32
    Height : Int32
}
struct PointF {
    X : Float32
    Y : Float32
}
struct Point {
    X : Int32
    Y : Int32
}
struct RectF {
    X : Float32
    Y : Float32
    Width : Float32
    Height : Float32
}
struct Rect {
    X : Int32
    Y : Int32
    Width : Int32
    Height : Int32
}
struct CharacterRange {
    First : Int32
    Length : Int32
}
struct DebugEventLevel extends Int32 {
    static DebugEventLevelFatal := 0
    static DebugEventLevelWarning := 1
}
struct DebugEventProc extends FunctionPointer {
    static Types := [DebugEventLevel, PSTR, "Void"]
}
struct NotificationHookProc extends FunctionPointer {
    static Types := [IntPtr.Ptr, Status]
}
struct NotificationUnhookProc extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct GdiplusStartupInput {
    GdiplusVersion : UInt32
    DebugEventCallback : IntPtr
    SuppressBackgroundThread : BOOL
    SuppressExternalCodecs : BOOL
}
struct GdiplusStartupInputEx {
    Base : GdiplusStartupInput
    StartupParameters : Int32
}
struct Version extends UInt32 {
    static V2 := 2
    static V3 := 3
}
struct GdiplusStartupParams extends Int32 {
    static GdiplusStartupDefault := 0
    static GdiplusStartupNoSetRound := 1
    static GdiplusStartupSetPSValue := 2
    static GdiplusStartupReserved0 := 4
    static GdiplusStartupReserved1 := 8
    static GdiplusStartupReserved2 := 16
    static GdiplusStartupTransparencyMask := -16777216
}
struct GdiplusStartupOutput {
    NotificationHook : IntPtr
    NotificationUnhook : IntPtr
}
struct PaletteType extends Int32 {
    static PaletteTypeCustom := 0
    static PaletteTypeOptimal := 1
    static PaletteTypeFixedBW := 2
    static PaletteTypeFixedHalftone8 := 3
    static PaletteTypeFixedHalftone27 := 4
    static PaletteTypeFixedHalftone64 := 5
    static PaletteTypeFixedHalftone125 := 6
    static PaletteTypeFixedHalftone216 := 7
    static PaletteTypeFixedHalftone252 := 8
    static PaletteTypeFixedHalftone256 := 9
}
struct DitherType extends Int32 {
    static DitherTypeNone := 0
    static DitherTypeSolid := 1
    static DitherTypeOrdered4x4 := 2
    static DitherTypeOrdered8x8 := 3
    static DitherTypeOrdered16x16 := 4
    static DitherTypeSpiral4x4 := 5
    static DitherTypeSpiral8x8 := 6
    static DitherTypeDualSpiral4x4 := 7
    static DitherTypeDualSpiral8x8 := 8
    static DitherTypeErrorDiffusion := 9
    static DitherTypeMax := 10
}
struct PaletteFlags extends Int32 {
    static PaletteFlagsHasAlpha := 1
    static PaletteFlagsGrayScale := 2
    static PaletteFlagsHalftone := 4
}
struct ColorPalette {
    Flags : UInt32
    Count : UInt32
    Entries : UInt32[1]
}
struct ColorMode extends Int32 {
    static ColorModeARGB32 := 0
    static ColorModeARGB64 := 1
}
struct ColorChannelFlags extends Int32 {
    static ColorChannelFlagsC := 0
    static ColorChannelFlagsM := 1
    static ColorChannelFlagsY := 2
    static ColorChannelFlagsK := 3
    static ColorChannelFlagsLast := 4
}
struct Color {
    Argb : UInt32
}
struct ENHMETAHEADER3 {
    iType : UInt32
    nSize : UInt32
    rclBounds : RECTL
    rclFrame : RECTL
    dSignature : UInt32
    nVersion : UInt32
    nBytes : UInt32
    nRecords : UInt32
    nHandles : UInt16
    sReserved : UInt16
    nDescription : UInt32
    offDescription : UInt32
    nPalEntries : UInt32
    szlDevice : _F_SIZE
    szlMillimeters : _F_SIZE
}
struct PWMFRect16 {
    Left : Int16
    Top : Int16
    Right : Int16
    Bottom : Int16
}
struct WmfPlaceableFileHeader {
    Key : UInt32
    Hmf : Int16
    BoundingBox : PWMFRect16
    Inch : Int16
    Reserved : UInt32
    Checksum : Int16
}
struct MetafileHeader {
    Type : MetafileType
    Size : UInt32
    Version : UInt32
    EmfPlusFlags : UInt32
    DpiX : Float32
    DpiY : Float32
    X : Int32
    Y : Int32
    Width : Int32
    Height : Int32
    Anonymous : this._Anonymous_e__Union
    EmfPlusHeaderSize : Int32
    LogicalDpiX : Int32
    LogicalDpiY : Int32
    struct _Anonymous_e__Union {
        union {
            WmfHeader : METAHEADER
            EmfHeader : ENHMETAHEADER3
        }
    }
}
struct IImageBytes extends IUnknown {
    static IID := "{025D1823-6C7D-447B-BBDB-A3CBC3DFA2FC}"
    CountBytes(pcb)
      => ComCall(3, this.p, UInt32.Ptr, pcb)
    LockBytes(cb, ulOffset, ppvBytes)
      => ComCall(4, this.p, UInt32, cb, UInt32, ulOffset, Struct.Ptr.Ptr, ppvBytes)
    UnlockBytes(pvBytes, cb, ulOffset)
      => ComCall(5, this.p, Struct.Ptr, pvBytes, UInt32, cb, UInt32, ulOffset)
}
struct ImageCodecInfo {
    Clsid : GUID
    FormatID : GUID
    CodecName : PWSTR
    DllName : PWSTR
    FormatDescription : PWSTR
    FilenameExtension : PWSTR
    MimeType : PWSTR
    Flags : UInt32
    Version : UInt32
    SigCount : UInt32
    SigSize : UInt32
    SigPattern : UInt8.Ptr
    SigMask : UInt8.Ptr
}
struct ImageCodecFlags extends Int32 {
    static ImageCodecFlagsEncoder := 1
    static ImageCodecFlagsDecoder := 2
    static ImageCodecFlagsSupportBitmap := 4
    static ImageCodecFlagsSupportVector := 8
    static ImageCodecFlagsSeekableEncode := 16
    static ImageCodecFlagsBlockingDecode := 32
    static ImageCodecFlagsBuiltin := 65536
    static ImageCodecFlagsSystem := 131072
    static ImageCodecFlagsUser := 262144
}
struct ImageLockMode extends Int32 {
    static ImageLockModeRead := 1
    static ImageLockModeWrite := 2
    static ImageLockModeUserInputBuf := 4
}
struct BitmapData {
    Width : UInt32
    Height : UInt32
    Stride : Int32
    PixelFormat : Int32
    Scan0 : Struct.Ptr
    Reserved : IntPtr
}
struct ImageFlags extends Int32 {
    static ImageFlagsNone := 0
    static ImageFlagsScalable := 1
    static ImageFlagsHasAlpha := 2
    static ImageFlagsHasTranslucent := 4
    static ImageFlagsPartiallyScalable := 8
    static ImageFlagsColorSpaceRGB := 16
    static ImageFlagsColorSpaceCMYK := 32
    static ImageFlagsColorSpaceGRAY := 64
    static ImageFlagsColorSpaceYCBCR := 128
    static ImageFlagsColorSpaceYCCK := 256
    static ImageFlagsHasRealDPI := 4096
    static ImageFlagsHasRealPixelSize := 8192
    static ImageFlagsReadOnly := 65536
    static ImageFlagsCaching := 131072
}
struct RotateFlipType extends Int32 {
    static RotateNoneFlipNone := 0
    static Rotate90FlipNone := 1
    static Rotate180FlipNone := 2
    static Rotate270FlipNone := 3
    static RotateNoneFlipX := 4
    static Rotate90FlipX := 5
    static Rotate180FlipX := 6
    static Rotate270FlipX := 7
    static RotateNoneFlipY := 6
    static Rotate90FlipY := 7
    static Rotate180FlipY := 4
    static Rotate270FlipY := 5
    static RotateNoneFlipXY := 2
    static Rotate90FlipXY := 3
    static Rotate180FlipXY := 0
    static Rotate270FlipXY := 1
}
struct EncoderParameter {
    Guid : GUID
    NumberOfValues : UInt32
    Type : UInt32
    Value : Struct.Ptr
}
struct EncoderParameters {
    Count : UInt32
    Parameter : EncoderParameter[1]
}
struct ItemDataPosition extends Int32 {
    static ItemDataPositionAfterHeader := 0
    static ItemDataPositionAfterPalette := 1
    static ItemDataPositionAfterBits := 2
}
struct ImageItemData {
    Size : UInt32
    Position : UInt32
    Desc : Struct.Ptr
    DescSize : UInt32
    Data : Struct.Ptr
    DataSize : UInt32
    Cookie : UInt32
}
struct PropertyItem {
    id : UInt32
    length : UInt32
    type : UInt16
    value : Struct.Ptr
}
struct HistogramFormat extends Int32 {
    static HistogramFormatARGB := 0
    static HistogramFormatPARGB := 1
    static HistogramFormatRGB := 2
    static HistogramFormatGray := 3
    static HistogramFormatB := 4
    static HistogramFormatG := 5
    static HistogramFormatR := 6
    static HistogramFormatA := 7
}
struct ColorMatrix {
    m : Float32[25]
}
struct ColorMatrixFlags extends Int32 {
    static ColorMatrixFlagsDefault := 0
    static ColorMatrixFlagsSkipGrays := 1
    static ColorMatrixFlagsAltGray := 2
}
struct ColorAdjustType extends Int32 {
    static ColorAdjustTypeDefault := 0
    static ColorAdjustTypeBitmap := 1
    static ColorAdjustTypeBrush := 2
    static ColorAdjustTypePen := 3
    static ColorAdjustTypeText := 4
    static ColorAdjustTypeCount := 5
    static ColorAdjustTypeAny := 6
}
struct ColorMap {
    oldColor : Color
    newColor : Color
}
struct SharpenParams {
    radius : Float32
    amount : Float32
}
struct BlurParams {
    radius : Float32
    expandEdge : BOOL
}
struct BrightnessContrastParams {
    brightnessLevel : Int32
    contrastLevel : Int32
}
struct RedEyeCorrectionParams {
    numberOfAreas : UInt32
    areas : _F_RECT.Ptr
}
struct HueSaturationLightnessParams {
    hueLevel : Int32
    saturationLevel : Int32
    lightnessLevel : Int32
}
struct TintParams {
    hue : Int32
    amount : Int32
}
struct LevelsParams {
    highlight : Int32
    midtone : Int32
    shadow : Int32
}
struct ColorBalanceParams {
    cyanRed : Int32
    magentaGreen : Int32
    yellowBlue : Int32
}
struct ColorLUTParams {
    lutB : UInt8[256]
    lutG : UInt8[256]
    lutR : UInt8[256]
    lutA : UInt8[256]
}
struct CurveAdjustments extends Int32 {
    static AdjustExposure := 0
    static AdjustDensity := 1
    static AdjustContrast := 2
    static AdjustHighlight := 3
    static AdjustShadow := 4
    static AdjustMidtone := 5
    static AdjustWhiteSaturation := 6
    static AdjustBlackSaturation := 7
}
struct CurveChannel extends Int32 {
    static CurveChannelAll := 0
    static CurveChannelRed := 1
    static CurveChannelGreen := 2
    static CurveChannelBlue := 3
}
struct ColorCurveParams {
    adjustment : CurveAdjustments
    channel : CurveChannel
    adjustValue : Int32
}
struct Effect {
    lpVtbl : Struct.Ptr.Ptr
    nativeEffect : CGpEffect.Ptr
    auxDataSize : Int32
    auxData : Struct.Ptr
    useAuxData : BOOL
}
struct Blur {
    Base : Effect
}
struct Sharpen {
    Base : Effect
}
struct RedEyeCorrection {
    Base : Effect
}
struct BrightnessContrast {
    Base : Effect
}
struct HueSaturationLightness {
    Base : Effect
}
struct Levels {
    Base : Effect
}
struct Tint {
    Base : Effect
}
struct ColorBalance {
    Base : Effect
}
struct ColorMatrixEffect {
    Base : Effect
}
struct ColorLUT {
    Base : Effect
}
struct ColorCurve {
    Base : Effect
}
