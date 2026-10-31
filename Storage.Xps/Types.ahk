#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, POINT, PSTR, PWSTR, SYSTEMTIME}
#Import "..\Graphics.Gdi\Types.ahk" {HDC}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT}
#Import "..\Storage.Packaging.Opc\Types.ahk" {IOpcCertificateEnumerator, IOpcCertificateSet, IOpcPartUri, IOpcSignatureCustomObjectEnumerator, IOpcSignatureCustomObjectSet, IOpcSignatureReferenceEnumerator, IOpcSignatureReferenceSet, OPC_SIGNATURE_TIME_FORMAT}
#Import "..\System.Com\Types.ahk" {ISequentialStream, IStream, IUnknown, IUri}

struct PRINT_WINDOW_FLAGS extends UInt32 {
    static PW_CLIENTONLY := 1
}
struct PRINTER_DEVICE_CAPABILITIES extends UInt16 {
    static DC_BINNAMES := 12
    static DC_BINS := 6
    static DC_COLLATE := 22
    static DC_COLORDEVICE := 32
    static DC_COPIES := 18
    static DC_DRIVER := 11
    static DC_DUPLEX := 7
    static DC_ENUMRESOLUTIONS := 13
    static DC_EXTRA := 9
    static DC_FIELDS := 1
    static DC_FILEDEPENDENCIES := 14
    static DC_MAXEXTENT := 5
    static DC_MEDIAREADY := 29
    static DC_MEDIATYPENAMES := 34
    static DC_MEDIATYPES := 35
    static DC_MINEXTENT := 4
    static DC_ORIENTATION := 17
    static DC_NUP := 33
    static DC_PAPERNAMES := 16
    static DC_PAPERS := 2
    static DC_PAPERSIZE := 3
    static DC_PERSONALITY := 25
    static DC_PRINTERMEM := 28
    static DC_PRINTRATE := 26
    static DC_PRINTRATEPPM := 31
    static DC_PRINTRATEUNIT := 27
    static DC_SIZE := 8
    static DC_STAPLE := 30
    static DC_TRUETYPE := 15
    static DC_VERSION := 10
}
struct PSINJECT_POINT extends UInt16 {
    static PSINJECT_BEGINSTREAM := 1
    static PSINJECT_PSADOBE := 2
    static PSINJECT_PAGESATEND := 3
    static PSINJECT_PAGES := 4
    static PSINJECT_DOCNEEDEDRES := 5
    static PSINJECT_DOCSUPPLIEDRES := 6
    static PSINJECT_PAGEORDER := 7
    static PSINJECT_ORIENTATION := 8
    static PSINJECT_BOUNDINGBOX := 9
    static PSINJECT_DOCUMENTPROCESSCOLORS := 10
    static PSINJECT_COMMENTS := 11
    static PSINJECT_BEGINDEFAULTS := 12
    static PSINJECT_ENDDEFAULTS := 13
    static PSINJECT_BEGINPROLOG := 14
    static PSINJECT_ENDPROLOG := 15
    static PSINJECT_BEGINSETUP := 16
    static PSINJECT_ENDSETUP := 17
    static PSINJECT_TRAILER := 18
    static PSINJECT_EOF := 19
    static PSINJECT_ENDSTREAM := 20
    static PSINJECT_DOCUMENTPROCESSCOLORSATEND := 21
    static PSINJECT_PAGENUMBER := 100
    static PSINJECT_BEGINPAGESETUP := 101
    static PSINJECT_ENDPAGESETUP := 102
    static PSINJECT_PAGETRAILER := 103
    static PSINJECT_PLATECOLOR := 104
    static PSINJECT_SHOWPAGE := 105
    static PSINJECT_PAGEBBOX := 106
    static PSINJECT_ENDPAGECOMMENTS := 107
    static PSINJECT_VMSAVE := 200
    static PSINJECT_VMRESTORE := 201
}
struct DRAWPATRECT {
    ptPosition : POINT
    ptSize : POINT
    wStyle : UInt16
    wPattern : UInt16
}
struct PSINJECTDATA {
    DataBytes : UInt32
    InjectionPoint : PSINJECT_POINT
    PageNumber : UInt16
}
struct PSFEATURE_OUTPUT {
    bPageIndependent : BOOL
    bSetPageDevice : BOOL
}
struct PSFEATURE_CUSTPAPER {
    lOrientation : Int32
    lWidth : Int32
    lHeight : Int32
    lWidthOffset : Int32
    lHeightOffset : Int32
}
struct ABORTPROC extends FunctionPointer {
    static Types := [HDC, Int32, BOOL]
}
struct DOCINFOA {
    cbSize : Int32 := this.Size
    lpszDocName : PSTR
    lpszOutput : PSTR
    lpszDatatype : PSTR
    fwType : UInt32
}
struct DOCINFOW {
    cbSize : Int32 := this.Size
    lpszDocName : PWSTR
    lpszOutput : PWSTR
    lpszDatatype : PWSTR
    fwType : UInt32
}
struct XPS_TILE_MODE extends Int32 {
    static XPS_TILE_MODE_NONE := 1
    static XPS_TILE_MODE_TILE := 2
    static XPS_TILE_MODE_FLIPX := 3
    static XPS_TILE_MODE_FLIPY := 4
    static XPS_TILE_MODE_FLIPXY := 5
}
struct XPS_COLOR_INTERPOLATION extends Int32 {
    static XPS_COLOR_INTERPOLATION_SCRGBLINEAR := 1
    static XPS_COLOR_INTERPOLATION_SRGBLINEAR := 2
}
struct XPS_SPREAD_METHOD extends Int32 {
    static XPS_SPREAD_METHOD_PAD := 1
    static XPS_SPREAD_METHOD_REFLECT := 2
    static XPS_SPREAD_METHOD_REPEAT := 3
}
struct XPS_STYLE_SIMULATION extends Int32 {
    static XPS_STYLE_SIMULATION_NONE := 1
    static XPS_STYLE_SIMULATION_ITALIC := 2
    static XPS_STYLE_SIMULATION_BOLD := 3
    static XPS_STYLE_SIMULATION_BOLDITALIC := 4
}
struct XPS_LINE_CAP extends Int32 {
    static XPS_LINE_CAP_FLAT := 1
    static XPS_LINE_CAP_ROUND := 2
    static XPS_LINE_CAP_SQUARE := 3
    static XPS_LINE_CAP_TRIANGLE := 4
}
struct XPS_DASH_CAP extends Int32 {
    static XPS_DASH_CAP_FLAT := 1
    static XPS_DASH_CAP_ROUND := 2
    static XPS_DASH_CAP_SQUARE := 3
    static XPS_DASH_CAP_TRIANGLE := 4
}
struct XPS_LINE_JOIN extends Int32 {
    static XPS_LINE_JOIN_MITER := 1
    static XPS_LINE_JOIN_BEVEL := 2
    static XPS_LINE_JOIN_ROUND := 3
}
struct XPS_IMAGE_TYPE extends Int32 {
    static XPS_IMAGE_TYPE_JPEG := 1
    static XPS_IMAGE_TYPE_PNG := 2
    static XPS_IMAGE_TYPE_TIFF := 3
    static XPS_IMAGE_TYPE_WDP := 4
    static XPS_IMAGE_TYPE_JXR := 5
}
struct XPS_COLOR_TYPE extends Int32 {
    static XPS_COLOR_TYPE_SRGB := 1
    static XPS_COLOR_TYPE_SCRGB := 2
    static XPS_COLOR_TYPE_CONTEXT := 3
}
struct XPS_FILL_RULE extends Int32 {
    static XPS_FILL_RULE_EVENODD := 1
    static XPS_FILL_RULE_NONZERO := 2
}
struct XPS_SEGMENT_TYPE extends Int32 {
    static XPS_SEGMENT_TYPE_ARC_LARGE_CLOCKWISE := 1
    static XPS_SEGMENT_TYPE_ARC_LARGE_COUNTERCLOCKWISE := 2
    static XPS_SEGMENT_TYPE_ARC_SMALL_CLOCKWISE := 3
    static XPS_SEGMENT_TYPE_ARC_SMALL_COUNTERCLOCKWISE := 4
    static XPS_SEGMENT_TYPE_BEZIER := 5
    static XPS_SEGMENT_TYPE_LINE := 6
    static XPS_SEGMENT_TYPE_QUADRATIC_BEZIER := 7
}
struct XPS_SEGMENT_STROKE_PATTERN extends Int32 {
    static XPS_SEGMENT_STROKE_PATTERN_ALL := 1
    static XPS_SEGMENT_STROKE_PATTERN_NONE := 2
    static XPS_SEGMENT_STROKE_PATTERN_MIXED := 3
}
struct XPS_FONT_EMBEDDING extends Int32 {
    static XPS_FONT_EMBEDDING_NORMAL := 1
    static XPS_FONT_EMBEDDING_OBFUSCATED := 2
    static XPS_FONT_EMBEDDING_RESTRICTED := 3
    static XPS_FONT_EMBEDDING_RESTRICTED_UNOBFUSCATED := 4
}
struct XPS_OBJECT_TYPE extends Int32 {
    static XPS_OBJECT_TYPE_CANVAS := 1
    static XPS_OBJECT_TYPE_GLYPHS := 2
    static XPS_OBJECT_TYPE_PATH := 3
    static XPS_OBJECT_TYPE_MATRIX_TRANSFORM := 4
    static XPS_OBJECT_TYPE_GEOMETRY := 5
    static XPS_OBJECT_TYPE_SOLID_COLOR_BRUSH := 6
    static XPS_OBJECT_TYPE_IMAGE_BRUSH := 7
    static XPS_OBJECT_TYPE_LINEAR_GRADIENT_BRUSH := 8
    static XPS_OBJECT_TYPE_RADIAL_GRADIENT_BRUSH := 9
    static XPS_OBJECT_TYPE_VISUAL_BRUSH := 10
}
struct XPS_THUMBNAIL_SIZE extends Int32 {
    static XPS_THUMBNAIL_SIZE_VERYSMALL := 1
    static XPS_THUMBNAIL_SIZE_SMALL := 2
    static XPS_THUMBNAIL_SIZE_MEDIUM := 3
    static XPS_THUMBNAIL_SIZE_LARGE := 4
}
struct XPS_INTERLEAVING extends Int32 {
    static XPS_INTERLEAVING_OFF := 1
    static XPS_INTERLEAVING_ON := 2
}
struct XPS_POINT {
    x : Float32
    y : Float32
}
struct XPS_SIZE {
    width : Float32
    height : Float32
}
struct XPS_RECT {
    x : Float32
    y : Float32
    width : Float32
    height : Float32
}
struct XPS_DASH {
    length : Float32
    gap : Float32
}
struct XPS_GLYPH_INDEX {
    index : Int32
    advanceWidth : Float32
    horizontalOffset : Float32
    verticalOffset : Float32
}
struct XPS_GLYPH_MAPPING {
    unicodeStringStart : UInt32
    unicodeStringLength : UInt16
    glyphIndicesStart : UInt32
    glyphIndicesLength : UInt16
}
struct XPS_MATRIX {
    m11 : Float32
    m12 : Float32
    m21 : Float32
    m22 : Float32
    m31 : Float32
    m32 : Float32
}
struct XPS_COLOR {
    colorType : XPS_COLOR_TYPE
    value : this.XPS_COLOR_VALUE
    struct XPS_COLOR_VALUE {
        union {
            sRGB : this._sRGB_e__Struct
            scRGB : this._scRGB_e__Struct
            context : this._context_e__Struct
        }
        struct _sRGB_e__Struct {
            alpha : UInt8
            red : UInt8
            green : UInt8
            blue : UInt8
        }
        struct _scRGB_e__Struct {
            alpha : Float32
            red : Float32
            green : Float32
            blue : Float32
        }
        struct _context_e__Struct {
            channelCount : UInt8
            channels : Float32[9]
        }
    }
}
struct IXpsOMShareable extends IUnknown {
    static IID := "{7137398F-2FC1-454D-8C6A-2C3115A16ECE}"
    GetOwner(owner)
      => ComCall(3, this.p, IUnknown.Ptr, owner)
    GetType(type)
      => ComCall(4, this.p, XPS_OBJECT_TYPE.Ptr, type)
}
struct IXpsOMVisual extends IXpsOMShareable {
    static IID := "{BC3E7333-FB0B-4AF3-A819-0B4EAAD0D2FD}"
    GetTransform(matrixTransform)
      => ComCall(5, this.p, IXpsOMMatrixTransform.Ptr, matrixTransform)
    GetTransformLocal(matrixTransform)
      => ComCall(6, this.p, IXpsOMMatrixTransform.Ptr, matrixTransform)
    SetTransformLocal(matrixTransform)
      => ComCall(7, this.p, IXpsOMMatrixTransform, matrixTransform)
    GetTransformLookup(key)
      => ComCall(8, this.p, PWSTR.Ptr, key)
    SetTransformLookup(key)
      => ComCall(9, this.p, "Str", key)
    GetClipGeometry(clipGeometry)
      => ComCall(10, this.p, IXpsOMGeometry.Ptr, clipGeometry)
    GetClipGeometryLocal(clipGeometry)
      => ComCall(11, this.p, IXpsOMGeometry.Ptr, clipGeometry)
    SetClipGeometryLocal(clipGeometry)
      => ComCall(12, this.p, IXpsOMGeometry, clipGeometry)
    GetClipGeometryLookup(key)
      => ComCall(13, this.p, PWSTR.Ptr, key)
    SetClipGeometryLookup(key)
      => ComCall(14, this.p, "Str", key)
    GetOpacity(opacity)
      => ComCall(15, this.p, Float32.Ptr, opacity)
    SetOpacity(opacity)
      => ComCall(16, this.p, Float32, opacity)
    GetOpacityMaskBrush(opacityMaskBrush)
      => ComCall(17, this.p, IXpsOMBrush.Ptr, opacityMaskBrush)
    GetOpacityMaskBrushLocal(opacityMaskBrush)
      => ComCall(18, this.p, IXpsOMBrush.Ptr, opacityMaskBrush)
    SetOpacityMaskBrushLocal(opacityMaskBrush)
      => ComCall(19, this.p, IXpsOMBrush, opacityMaskBrush)
    GetOpacityMaskBrushLookup(key)
      => ComCall(20, this.p, PWSTR.Ptr, key)
    SetOpacityMaskBrushLookup(key)
      => ComCall(21, this.p, "Str", key)
    GetName(name)
      => ComCall(22, this.p, PWSTR.Ptr, name)
    SetName(name)
      => ComCall(23, this.p, "Str", name)
    GetIsHyperlinkTarget(isHyperlink)
      => ComCall(24, this.p, BOOL.Ptr, isHyperlink)
    SetIsHyperlinkTarget(isHyperlink)
      => ComCall(25, this.p, BOOL, isHyperlink)
    GetHyperlinkNavigateUri(hyperlinkUri)
      => ComCall(26, this.p, IUri.Ptr, hyperlinkUri)
    SetHyperlinkNavigateUri(hyperlinkUri)
      => ComCall(27, this.p, IUri, hyperlinkUri)
    GetLanguage(language)
      => ComCall(28, this.p, PWSTR.Ptr, language)
    SetLanguage(language)
      => ComCall(29, this.p, "Str", language)
}
struct IXpsOMPart extends IUnknown {
    static IID := "{74EB2F0B-A91E-4486-AFAC-0FABECA3DFC6}"
    GetPartName(partUri)
      => ComCall(3, this.p, IOpcPartUri.Ptr, partUri)
    SetPartName(partUri)
      => ComCall(4, this.p, IOpcPartUri, partUri)
}
struct IXpsOMGlyphsEditor extends IUnknown {
    static IID := "{A5AB8616-5B16-4B9F-9629-89B323ED7909}"
    ApplyEdits()
      => ComCall(3, this.p)
    GetUnicodeString(unicodeString)
      => ComCall(4, this.p, PWSTR.Ptr, unicodeString)
    SetUnicodeString(unicodeString)
      => ComCall(5, this.p, "Str", unicodeString)
    GetGlyphIndexCount(indexCount)
      => ComCall(6, this.p, UInt32.Ptr, indexCount)
    GetGlyphIndices(indexCount, glyphIndices)
      => ComCall(7, this.p, UInt32.Ptr, indexCount, XPS_GLYPH_INDEX.Ptr, glyphIndices)
    SetGlyphIndices(indexCount, glyphIndices)
      => ComCall(8, this.p, UInt32, indexCount, XPS_GLYPH_INDEX.Ptr, glyphIndices)
    GetGlyphMappingCount(glyphMappingCount)
      => ComCall(9, this.p, UInt32.Ptr, glyphMappingCount)
    GetGlyphMappings(glyphMappingCount, glyphMappings)
      => ComCall(10, this.p, UInt32.Ptr, glyphMappingCount, XPS_GLYPH_MAPPING.Ptr, glyphMappings)
    SetGlyphMappings(glyphMappingCount, glyphMappings)
      => ComCall(11, this.p, UInt32, glyphMappingCount, XPS_GLYPH_MAPPING.Ptr, glyphMappings)
    GetProhibitedCaretStopCount(prohibitedCaretStopCount)
      => ComCall(12, this.p, UInt32.Ptr, prohibitedCaretStopCount)
    GetProhibitedCaretStops(count, prohibitedCaretStops)
      => ComCall(13, this.p, UInt32.Ptr, count, UInt32.Ptr, prohibitedCaretStops)
    SetProhibitedCaretStops(count, prohibitedCaretStops)
      => ComCall(14, this.p, UInt32, count, UInt32.Ptr, prohibitedCaretStops)
    GetBidiLevel(bidiLevel)
      => ComCall(15, this.p, UInt32.Ptr, bidiLevel)
    SetBidiLevel(bidiLevel)
      => ComCall(16, this.p, UInt32, bidiLevel)
    GetIsSideways(isSideways)
      => ComCall(17, this.p, BOOL.Ptr, isSideways)
    SetIsSideways(isSideways)
      => ComCall(18, this.p, BOOL, isSideways)
    GetDeviceFontName(deviceFontName)
      => ComCall(19, this.p, PWSTR.Ptr, deviceFontName)
    SetDeviceFontName(deviceFontName)
      => ComCall(20, this.p, "Str", deviceFontName)
}
struct IXpsOMGlyphs extends IXpsOMVisual {
    static IID := "{819B3199-0A5A-4B64-BEC7-A9E17E780DE2}"
    GetUnicodeString(unicodeString)
      => ComCall(30, this.p, PWSTR.Ptr, unicodeString)
    GetGlyphIndexCount(indexCount)
      => ComCall(31, this.p, UInt32.Ptr, indexCount)
    GetGlyphIndices(indexCount, glyphIndices)
      => ComCall(32, this.p, UInt32.Ptr, indexCount, XPS_GLYPH_INDEX.Ptr, glyphIndices)
    GetGlyphMappingCount(glyphMappingCount)
      => ComCall(33, this.p, UInt32.Ptr, glyphMappingCount)
    GetGlyphMappings(glyphMappingCount, glyphMappings)
      => ComCall(34, this.p, UInt32.Ptr, glyphMappingCount, XPS_GLYPH_MAPPING.Ptr, glyphMappings)
    GetProhibitedCaretStopCount(prohibitedCaretStopCount)
      => ComCall(35, this.p, UInt32.Ptr, prohibitedCaretStopCount)
    GetProhibitedCaretStops(prohibitedCaretStopCount, prohibitedCaretStops)
      => ComCall(36, this.p, UInt32.Ptr, prohibitedCaretStopCount, UInt32.Ptr, prohibitedCaretStops)
    GetBidiLevel(bidiLevel)
      => ComCall(37, this.p, UInt32.Ptr, bidiLevel)
    GetIsSideways(isSideways)
      => ComCall(38, this.p, BOOL.Ptr, isSideways)
    GetDeviceFontName(deviceFontName)
      => ComCall(39, this.p, PWSTR.Ptr, deviceFontName)
    GetStyleSimulations(styleSimulations)
      => ComCall(40, this.p, XPS_STYLE_SIMULATION.Ptr, styleSimulations)
    SetStyleSimulations(styleSimulations)
      => ComCall(41, this.p, XPS_STYLE_SIMULATION, styleSimulations)
    GetOrigin(origin)
      => ComCall(42, this.p, XPS_POINT.Ptr, origin)
    SetOrigin(origin)
      => ComCall(43, this.p, XPS_POINT.Ptr, origin)
    GetFontRenderingEmSize(fontRenderingEmSize)
      => ComCall(44, this.p, Float32.Ptr, fontRenderingEmSize)
    SetFontRenderingEmSize(fontRenderingEmSize)
      => ComCall(45, this.p, Float32, fontRenderingEmSize)
    GetFontResource(fontResource)
      => ComCall(46, this.p, IXpsOMFontResource.Ptr, fontResource)
    SetFontResource(fontResource)
      => ComCall(47, this.p, IXpsOMFontResource, fontResource)
    GetFontFaceIndex(fontFaceIndex)
      => ComCall(48, this.p, Int16.Ptr, fontFaceIndex)
    SetFontFaceIndex(fontFaceIndex)
      => ComCall(49, this.p, Int16, fontFaceIndex)
    GetFillBrush(fillBrush)
      => ComCall(50, this.p, IXpsOMBrush.Ptr, fillBrush)
    GetFillBrushLocal(fillBrush)
      => ComCall(51, this.p, IXpsOMBrush.Ptr, fillBrush)
    SetFillBrushLocal(fillBrush)
      => ComCall(52, this.p, IXpsOMBrush, fillBrush)
    GetFillBrushLookup(key)
      => ComCall(53, this.p, PWSTR.Ptr, key)
    SetFillBrushLookup(key)
      => ComCall(54, this.p, "Str", key)
    GetGlyphsEditor(editor)
      => ComCall(55, this.p, IXpsOMGlyphsEditor.Ptr, editor)
    Clone(glyphs)
      => ComCall(56, this.p, IXpsOMGlyphs.Ptr, glyphs)
}
struct IXpsOMDashCollection extends IUnknown {
    static IID := "{081613F4-74EB-48F2-83B3-37A9CE2D7DC6}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, dash)
      => ComCall(4, this.p, UInt32, index, XPS_DASH.Ptr, dash)
    InsertAt(index, dash)
      => ComCall(5, this.p, UInt32, index, XPS_DASH.Ptr, dash)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, dash)
      => ComCall(7, this.p, UInt32, index, XPS_DASH.Ptr, dash)
    Append(dash)
      => ComCall(8, this.p, XPS_DASH.Ptr, dash)
}
struct IXpsOMMatrixTransform extends IXpsOMShareable {
    static IID := "{B77330FF-BB37-4501-A93E-F1B1E50BFC46}"
    GetMatrix(matrix)
      => ComCall(5, this.p, XPS_MATRIX.Ptr, matrix)
    SetMatrix(matrix)
      => ComCall(6, this.p, XPS_MATRIX.Ptr, matrix)
    Clone(matrixTransform)
      => ComCall(7, this.p, IXpsOMMatrixTransform.Ptr, matrixTransform)
}
struct IXpsOMGeometry extends IXpsOMShareable {
    static IID := "{64FCF3D7-4D58-44BA-AD73-A13AF6492072}"
    GetFigures(figures)
      => ComCall(5, this.p, IXpsOMGeometryFigureCollection.Ptr, figures)
    GetFillRule(fillRule)
      => ComCall(6, this.p, XPS_FILL_RULE.Ptr, fillRule)
    SetFillRule(fillRule)
      => ComCall(7, this.p, XPS_FILL_RULE, fillRule)
    GetTransform(transform)
      => ComCall(8, this.p, IXpsOMMatrixTransform.Ptr, transform)
    GetTransformLocal(transform)
      => ComCall(9, this.p, IXpsOMMatrixTransform.Ptr, transform)
    SetTransformLocal(transform)
      => ComCall(10, this.p, IXpsOMMatrixTransform, transform)
    GetTransformLookup(lookup)
      => ComCall(11, this.p, PWSTR.Ptr, lookup)
    SetTransformLookup(lookup)
      => ComCall(12, this.p, "Str", lookup)
    Clone(geometry)
      => ComCall(13, this.p, IXpsOMGeometry.Ptr, geometry)
}
struct IXpsOMGeometryFigure extends IUnknown {
    static IID := "{D410DC83-908C-443E-8947-B1795D3C165A}"
    GetOwner(owner)
      => ComCall(3, this.p, IXpsOMGeometry.Ptr, owner)
    GetSegmentData(dataCount, segmentData)
      => ComCall(4, this.p, UInt32.Ptr, dataCount, Float32.Ptr, segmentData)
    GetSegmentTypes(segmentCount, segmentTypes)
      => ComCall(5, this.p, UInt32.Ptr, segmentCount, XPS_SEGMENT_TYPE.Ptr, segmentTypes)
    GetSegmentStrokes(segmentCount, segmentStrokes)
      => ComCall(6, this.p, UInt32.Ptr, segmentCount, BOOL.Ptr, segmentStrokes)
    SetSegments(segmentCount, segmentDataCount, segmentTypes, segmentData, segmentStrokes)
      => ComCall(7, this.p, UInt32, segmentCount, UInt32, segmentDataCount, XPS_SEGMENT_TYPE.Ptr, segmentTypes, Float32.Ptr, segmentData, BOOL.Ptr, segmentStrokes)
    GetStartPoint(startPoint)
      => ComCall(8, this.p, XPS_POINT.Ptr, startPoint)
    SetStartPoint(startPoint)
      => ComCall(9, this.p, XPS_POINT.Ptr, startPoint)
    GetIsClosed(isClosed)
      => ComCall(10, this.p, BOOL.Ptr, isClosed)
    SetIsClosed(isClosed)
      => ComCall(11, this.p, BOOL, isClosed)
    GetIsFilled(isFilled)
      => ComCall(12, this.p, BOOL.Ptr, isFilled)
    SetIsFilled(isFilled)
      => ComCall(13, this.p, BOOL, isFilled)
    GetSegmentCount(segmentCount)
      => ComCall(14, this.p, UInt32.Ptr, segmentCount)
    GetSegmentDataCount(segmentDataCount)
      => ComCall(15, this.p, UInt32.Ptr, segmentDataCount)
    GetSegmentStrokePattern(segmentStrokePattern)
      => ComCall(16, this.p, XPS_SEGMENT_STROKE_PATTERN.Ptr, segmentStrokePattern)
    Clone(geometryFigure)
      => ComCall(17, this.p, IXpsOMGeometryFigure.Ptr, geometryFigure)
}
struct IXpsOMGeometryFigureCollection extends IUnknown {
    static IID := "{FD48C3F3-A58E-4B5A-8826-1DE54ABE72B2}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, geometryFigure)
      => ComCall(4, this.p, UInt32, index, IXpsOMGeometryFigure.Ptr, geometryFigure)
    InsertAt(index, geometryFigure)
      => ComCall(5, this.p, UInt32, index, IXpsOMGeometryFigure, geometryFigure)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, geometryFigure)
      => ComCall(7, this.p, UInt32, index, IXpsOMGeometryFigure, geometryFigure)
    Append(geometryFigure)
      => ComCall(8, this.p, IXpsOMGeometryFigure, geometryFigure)
}
struct IXpsOMPath extends IXpsOMVisual {
    static IID := "{37D38BB6-3EE9-4110-9312-14B194163337}"
    GetGeometry(geometry)
      => ComCall(30, this.p, IXpsOMGeometry.Ptr, geometry)
    GetGeometryLocal(geometry)
      => ComCall(31, this.p, IXpsOMGeometry.Ptr, geometry)
    SetGeometryLocal(geometry)
      => ComCall(32, this.p, IXpsOMGeometry, geometry)
    GetGeometryLookup(lookup)
      => ComCall(33, this.p, PWSTR.Ptr, lookup)
    SetGeometryLookup(lookup)
      => ComCall(34, this.p, "Str", lookup)
    GetAccessibilityShortDescription(shortDescription)
      => ComCall(35, this.p, PWSTR.Ptr, shortDescription)
    SetAccessibilityShortDescription(shortDescription)
      => ComCall(36, this.p, "Str", shortDescription)
    GetAccessibilityLongDescription(longDescription)
      => ComCall(37, this.p, PWSTR.Ptr, longDescription)
    SetAccessibilityLongDescription(longDescription)
      => ComCall(38, this.p, "Str", longDescription)
    GetSnapsToPixels(snapsToPixels)
      => ComCall(39, this.p, BOOL.Ptr, snapsToPixels)
    SetSnapsToPixels(snapsToPixels)
      => ComCall(40, this.p, BOOL, snapsToPixels)
    GetStrokeBrush(brush)
      => ComCall(41, this.p, IXpsOMBrush.Ptr, brush)
    GetStrokeBrushLocal(brush)
      => ComCall(42, this.p, IXpsOMBrush.Ptr, brush)
    SetStrokeBrushLocal(brush)
      => ComCall(43, this.p, IXpsOMBrush, brush)
    GetStrokeBrushLookup(lookup)
      => ComCall(44, this.p, PWSTR.Ptr, lookup)
    SetStrokeBrushLookup(lookup)
      => ComCall(45, this.p, "Str", lookup)
    GetStrokeDashes(strokeDashes)
      => ComCall(46, this.p, IXpsOMDashCollection.Ptr, strokeDashes)
    GetStrokeDashCap(strokeDashCap)
      => ComCall(47, this.p, XPS_DASH_CAP.Ptr, strokeDashCap)
    SetStrokeDashCap(strokeDashCap)
      => ComCall(48, this.p, XPS_DASH_CAP, strokeDashCap)
    GetStrokeDashOffset(strokeDashOffset)
      => ComCall(49, this.p, Float32.Ptr, strokeDashOffset)
    SetStrokeDashOffset(strokeDashOffset)
      => ComCall(50, this.p, Float32, strokeDashOffset)
    GetStrokeStartLineCap(strokeStartLineCap)
      => ComCall(51, this.p, XPS_LINE_CAP.Ptr, strokeStartLineCap)
    SetStrokeStartLineCap(strokeStartLineCap)
      => ComCall(52, this.p, XPS_LINE_CAP, strokeStartLineCap)
    GetStrokeEndLineCap(strokeEndLineCap)
      => ComCall(53, this.p, XPS_LINE_CAP.Ptr, strokeEndLineCap)
    SetStrokeEndLineCap(strokeEndLineCap)
      => ComCall(54, this.p, XPS_LINE_CAP, strokeEndLineCap)
    GetStrokeLineJoin(strokeLineJoin)
      => ComCall(55, this.p, XPS_LINE_JOIN.Ptr, strokeLineJoin)
    SetStrokeLineJoin(strokeLineJoin)
      => ComCall(56, this.p, XPS_LINE_JOIN, strokeLineJoin)
    GetStrokeMiterLimit(strokeMiterLimit)
      => ComCall(57, this.p, Float32.Ptr, strokeMiterLimit)
    SetStrokeMiterLimit(strokeMiterLimit)
      => ComCall(58, this.p, Float32, strokeMiterLimit)
    GetStrokeThickness(strokeThickness)
      => ComCall(59, this.p, Float32.Ptr, strokeThickness)
    SetStrokeThickness(strokeThickness)
      => ComCall(60, this.p, Float32, strokeThickness)
    GetFillBrush(brush)
      => ComCall(61, this.p, IXpsOMBrush.Ptr, brush)
    GetFillBrushLocal(brush)
      => ComCall(62, this.p, IXpsOMBrush.Ptr, brush)
    SetFillBrushLocal(brush)
      => ComCall(63, this.p, IXpsOMBrush, brush)
    GetFillBrushLookup(lookup)
      => ComCall(64, this.p, PWSTR.Ptr, lookup)
    SetFillBrushLookup(lookup)
      => ComCall(65, this.p, "Str", lookup)
    Clone(path)
      => ComCall(66, this.p, IXpsOMPath.Ptr, path)
}
struct IXpsOMBrush extends IXpsOMShareable {
    static IID := "{56A3F80C-EA4C-4187-A57B-A2A473B2B42B}"
    GetOpacity(opacity)
      => ComCall(5, this.p, Float32.Ptr, opacity)
    SetOpacity(opacity)
      => ComCall(6, this.p, Float32, opacity)
}
struct IXpsOMGradientStopCollection extends IUnknown {
    static IID := "{C9174C3A-3CD3-4319-BDA4-11A39392CEEF}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, stop)
      => ComCall(4, this.p, UInt32, index, IXpsOMGradientStop.Ptr, stop)
    InsertAt(index, stop)
      => ComCall(5, this.p, UInt32, index, IXpsOMGradientStop, stop)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, stop)
      => ComCall(7, this.p, UInt32, index, IXpsOMGradientStop, stop)
    Append(stop)
      => ComCall(8, this.p, IXpsOMGradientStop, stop)
}
struct IXpsOMSolidColorBrush extends IXpsOMBrush {
    static IID := "{A06F9F05-3BE9-4763-98A8-094FC672E488}"
    GetColor(color, colorProfile)
      => ComCall(7, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource.Ptr, colorProfile)
    SetColor(color, colorProfile)
      => ComCall(8, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource, colorProfile)
    Clone(solidColorBrush)
      => ComCall(9, this.p, IXpsOMSolidColorBrush.Ptr, solidColorBrush)
}
struct IXpsOMTileBrush extends IXpsOMBrush {
    static IID := "{0FC2328D-D722-4A54-B2EC-BE90218A789E}"
    GetTransform(transform)
      => ComCall(7, this.p, IXpsOMMatrixTransform.Ptr, transform)
    GetTransformLocal(transform)
      => ComCall(8, this.p, IXpsOMMatrixTransform.Ptr, transform)
    SetTransformLocal(transform)
      => ComCall(9, this.p, IXpsOMMatrixTransform, transform)
    GetTransformLookup(key)
      => ComCall(10, this.p, PWSTR.Ptr, key)
    SetTransformLookup(key)
      => ComCall(11, this.p, "Str", key)
    GetViewbox(viewbox)
      => ComCall(12, this.p, XPS_RECT.Ptr, viewbox)
    SetViewbox(viewbox)
      => ComCall(13, this.p, XPS_RECT.Ptr, viewbox)
    GetViewport(viewport)
      => ComCall(14, this.p, XPS_RECT.Ptr, viewport)
    SetViewport(viewport)
      => ComCall(15, this.p, XPS_RECT.Ptr, viewport)
    GetTileMode(tileMode)
      => ComCall(16, this.p, XPS_TILE_MODE.Ptr, tileMode)
    SetTileMode(tileMode)
      => ComCall(17, this.p, XPS_TILE_MODE, tileMode)
}
struct IXpsOMVisualBrush extends IXpsOMTileBrush {
    static IID := "{97E294AF-5B37-46B4-8057-874D2F64119B}"
    GetVisual(visual)
      => ComCall(18, this.p, IXpsOMVisual.Ptr, visual)
    GetVisualLocal(visual)
      => ComCall(19, this.p, IXpsOMVisual.Ptr, visual)
    SetVisualLocal(visual)
      => ComCall(20, this.p, IXpsOMVisual, visual)
    GetVisualLookup(lookup)
      => ComCall(21, this.p, PWSTR.Ptr, lookup)
    SetVisualLookup(lookup)
      => ComCall(22, this.p, "Str", lookup)
    Clone(visualBrush)
      => ComCall(23, this.p, IXpsOMVisualBrush.Ptr, visualBrush)
}
struct IXpsOMImageBrush extends IXpsOMTileBrush {
    static IID := "{3DF0B466-D382-49EF-8550-DD94C80242E4}"
    GetImageResource(imageResource)
      => ComCall(18, this.p, IXpsOMImageResource.Ptr, imageResource)
    SetImageResource(imageResource)
      => ComCall(19, this.p, IXpsOMImageResource, imageResource)
    GetColorProfileResource(colorProfileResource)
      => ComCall(20, this.p, IXpsOMColorProfileResource.Ptr, colorProfileResource)
    SetColorProfileResource(colorProfileResource)
      => ComCall(21, this.p, IXpsOMColorProfileResource, colorProfileResource)
    Clone(imageBrush)
      => ComCall(22, this.p, IXpsOMImageBrush.Ptr, imageBrush)
}
struct IXpsOMGradientStop extends IUnknown {
    static IID := "{5CF4F5CC-3969-49B5-A70A-5550B618FE49}"
    GetOwner(owner)
      => ComCall(3, this.p, IXpsOMGradientBrush.Ptr, owner)
    GetOffset(offset)
      => ComCall(4, this.p, Float32.Ptr, offset)
    SetOffset(offset)
      => ComCall(5, this.p, Float32, offset)
    GetColor(color, colorProfile)
      => ComCall(6, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource.Ptr, colorProfile)
    SetColor(color, colorProfile)
      => ComCall(7, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource, colorProfile)
    Clone(gradientStop)
      => ComCall(8, this.p, IXpsOMGradientStop.Ptr, gradientStop)
}
struct IXpsOMGradientBrush extends IXpsOMBrush {
    static IID := "{EDB59622-61A2-42C3-BACE-ACF2286C06BF}"
    GetGradientStops(gradientStops)
      => ComCall(7, this.p, IXpsOMGradientStopCollection.Ptr, gradientStops)
    GetTransform(transform)
      => ComCall(8, this.p, IXpsOMMatrixTransform.Ptr, transform)
    GetTransformLocal(transform)
      => ComCall(9, this.p, IXpsOMMatrixTransform.Ptr, transform)
    SetTransformLocal(transform)
      => ComCall(10, this.p, IXpsOMMatrixTransform, transform)
    GetTransformLookup(key)
      => ComCall(11, this.p, PWSTR.Ptr, key)
    SetTransformLookup(key)
      => ComCall(12, this.p, "Str", key)
    GetSpreadMethod(spreadMethod)
      => ComCall(13, this.p, XPS_SPREAD_METHOD.Ptr, spreadMethod)
    SetSpreadMethod(spreadMethod)
      => ComCall(14, this.p, XPS_SPREAD_METHOD, spreadMethod)
    GetColorInterpolationMode(colorInterpolationMode)
      => ComCall(15, this.p, XPS_COLOR_INTERPOLATION.Ptr, colorInterpolationMode)
    SetColorInterpolationMode(colorInterpolationMode)
      => ComCall(16, this.p, XPS_COLOR_INTERPOLATION, colorInterpolationMode)
}
struct IXpsOMLinearGradientBrush extends IXpsOMGradientBrush {
    static IID := "{005E279F-C30D-40FF-93EC-1950D3C528DB}"
    GetStartPoint(startPoint)
      => ComCall(17, this.p, XPS_POINT.Ptr, startPoint)
    SetStartPoint(startPoint)
      => ComCall(18, this.p, XPS_POINT.Ptr, startPoint)
    GetEndPoint(endPoint)
      => ComCall(19, this.p, XPS_POINT.Ptr, endPoint)
    SetEndPoint(endPoint)
      => ComCall(20, this.p, XPS_POINT.Ptr, endPoint)
    Clone(linearGradientBrush)
      => ComCall(21, this.p, IXpsOMLinearGradientBrush.Ptr, linearGradientBrush)
}
struct IXpsOMRadialGradientBrush extends IXpsOMGradientBrush {
    static IID := "{75F207E5-08BF-413C-96B1-B82B4064176B}"
    GetCenter(center)
      => ComCall(17, this.p, XPS_POINT.Ptr, center)
    SetCenter(center)
      => ComCall(18, this.p, XPS_POINT.Ptr, center)
    GetRadiiSizes(radiiSizes)
      => ComCall(19, this.p, XPS_SIZE.Ptr, radiiSizes)
    SetRadiiSizes(radiiSizes)
      => ComCall(20, this.p, XPS_SIZE.Ptr, radiiSizes)
    GetGradientOrigin(origin)
      => ComCall(21, this.p, XPS_POINT.Ptr, origin)
    SetGradientOrigin(origin)
      => ComCall(22, this.p, XPS_POINT.Ptr, origin)
    Clone(radialGradientBrush)
      => ComCall(23, this.p, IXpsOMRadialGradientBrush.Ptr, radialGradientBrush)
}
struct IXpsOMResource extends IXpsOMPart {
    static IID := "{DA2AC0A2-73A2-4975-AD14-74097C3FF3A5}"
}
struct IXpsOMPartResources extends IUnknown {
    static IID := "{F4CF7729-4864-4275-99B3-A8717163ECAF}"
    GetFontResources(fontResources)
      => ComCall(3, this.p, IXpsOMFontResourceCollection.Ptr, fontResources)
    GetImageResources(imageResources)
      => ComCall(4, this.p, IXpsOMImageResourceCollection.Ptr, imageResources)
    GetColorProfileResources(colorProfileResources)
      => ComCall(5, this.p, IXpsOMColorProfileResourceCollection.Ptr, colorProfileResources)
    GetRemoteDictionaryResources(dictionaryResources)
      => ComCall(6, this.p, IXpsOMRemoteDictionaryResourceCollection.Ptr, dictionaryResources)
}
struct IXpsOMDictionary extends IUnknown {
    static IID := "{897C86B8-8EAF-4AE3-BDDE-56419FCF4236}"
    GetOwner(owner)
      => ComCall(3, this.p, IUnknown.Ptr, owner)
    GetCount(count)
      => ComCall(4, this.p, UInt32.Ptr, count)
    GetAt(index, key, entry)
      => ComCall(5, this.p, UInt32, index, PWSTR.Ptr, key, IXpsOMShareable.Ptr, entry)
    GetByKey(key, beforeEntry, entry)
      => ComCall(6, this.p, "Str", key, IXpsOMShareable, beforeEntry, IXpsOMShareable.Ptr, entry)
    GetIndex(entry, index)
      => ComCall(7, this.p, IXpsOMShareable, entry, UInt32.Ptr, index)
    Append(key, entry)
      => ComCall(8, this.p, "Str", key, IXpsOMShareable, entry)
    InsertAt(index, key, entry)
      => ComCall(9, this.p, UInt32, index, "Str", key, IXpsOMShareable, entry)
    RemoveAt(index)
      => ComCall(10, this.p, UInt32, index)
    SetAt(index, key, entry)
      => ComCall(11, this.p, UInt32, index, "Str", key, IXpsOMShareable, entry)
    Clone(dictionary)
      => ComCall(12, this.p, IXpsOMDictionary.Ptr, dictionary)
}
struct IXpsOMFontResource extends IXpsOMResource {
    static IID := "{A8C45708-47D9-4AF4-8D20-33B48C9B8485}"
    GetStream(readerStream)
      => ComCall(5, this.p, IStream.Ptr, readerStream)
    SetContent(sourceStream, embeddingOption, partName)
      => ComCall(6, this.p, IStream, sourceStream, XPS_FONT_EMBEDDING, embeddingOption, IOpcPartUri, partName)
    GetEmbeddingOption(embeddingOption)
      => ComCall(7, this.p, XPS_FONT_EMBEDDING.Ptr, embeddingOption)
}
struct IXpsOMFontResourceCollection extends IUnknown {
    static IID := "{70B4A6BB-88D4-4FA8-AAF9-6D9C596FDBAD}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, value)
      => ComCall(4, this.p, UInt32, index, IXpsOMFontResource.Ptr, value)
    SetAt(index, value)
      => ComCall(5, this.p, UInt32, index, IXpsOMFontResource, value)
    InsertAt(index, value)
      => ComCall(6, this.p, UInt32, index, IXpsOMFontResource, value)
    Append(value)
      => ComCall(7, this.p, IXpsOMFontResource, value)
    RemoveAt(index)
      => ComCall(8, this.p, UInt32, index)
    GetByPartName(partName, part)
      => ComCall(9, this.p, IOpcPartUri, partName, IXpsOMFontResource.Ptr, part)
}
struct IXpsOMImageResource extends IXpsOMResource {
    static IID := "{3DB8417D-AE50-485E-9A44-D7758F78A23F}"
    GetStream(readerStream)
      => ComCall(5, this.p, IStream.Ptr, readerStream)
    SetContent(sourceStream, imageType, partName)
      => ComCall(6, this.p, IStream, sourceStream, XPS_IMAGE_TYPE, imageType, IOpcPartUri, partName)
    GetImageType(imageType)
      => ComCall(7, this.p, XPS_IMAGE_TYPE.Ptr, imageType)
}
struct IXpsOMImageResourceCollection extends IUnknown {
    static IID := "{7A4A1A71-9CDE-4B71-B33F-62DE843EABFE}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, object)
      => ComCall(4, this.p, UInt32, index, IXpsOMImageResource.Ptr, object)
    InsertAt(index, object)
      => ComCall(5, this.p, UInt32, index, IXpsOMImageResource, object)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, object)
      => ComCall(7, this.p, UInt32, index, IXpsOMImageResource, object)
    Append(object)
      => ComCall(8, this.p, IXpsOMImageResource, object)
    GetByPartName(partName, part)
      => ComCall(9, this.p, IOpcPartUri, partName, IXpsOMImageResource.Ptr, part)
}
struct IXpsOMColorProfileResource extends IXpsOMResource {
    static IID := "{67BD7D69-1EEF-4BB1-B5E7-6F4F87BE8ABE}"
    GetStream(stream)
      => ComCall(5, this.p, IStream.Ptr, stream)
    SetContent(sourceStream, partName)
      => ComCall(6, this.p, IStream, sourceStream, IOpcPartUri, partName)
}
struct IXpsOMColorProfileResourceCollection extends IUnknown {
    static IID := "{12759630-5FBA-4283-8F7D-CCA849809EDB}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, object)
      => ComCall(4, this.p, UInt32, index, IXpsOMColorProfileResource.Ptr, object)
    InsertAt(index, object)
      => ComCall(5, this.p, UInt32, index, IXpsOMColorProfileResource, object)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, object)
      => ComCall(7, this.p, UInt32, index, IXpsOMColorProfileResource, object)
    Append(object)
      => ComCall(8, this.p, IXpsOMColorProfileResource, object)
    GetByPartName(partName, part)
      => ComCall(9, this.p, IOpcPartUri, partName, IXpsOMColorProfileResource.Ptr, part)
}
struct IXpsOMPrintTicketResource extends IXpsOMResource {
    static IID := "{E7FF32D2-34AA-499B-BBE9-9CD4EE6C59F7}"
    GetStream(stream)
      => ComCall(5, this.p, IStream.Ptr, stream)
    SetContent(sourceStream, partName)
      => ComCall(6, this.p, IStream, sourceStream, IOpcPartUri, partName)
}
struct IXpsOMRemoteDictionaryResource extends IXpsOMResource {
    static IID := "{C9BD7CD4-E16A-4BF8-8C84-C950AF7A3061}"
    GetDictionary(dictionary)
      => ComCall(5, this.p, IXpsOMDictionary.Ptr, dictionary)
    SetDictionary(dictionary)
      => ComCall(6, this.p, IXpsOMDictionary, dictionary)
}
struct IXpsOMRemoteDictionaryResourceCollection extends IUnknown {
    static IID := "{5C38DB61-7FEC-464A-87BD-41E3BEF018BE}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, object)
      => ComCall(4, this.p, UInt32, index, IXpsOMRemoteDictionaryResource.Ptr, object)
    InsertAt(index, object)
      => ComCall(5, this.p, UInt32, index, IXpsOMRemoteDictionaryResource, object)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, object)
      => ComCall(7, this.p, UInt32, index, IXpsOMRemoteDictionaryResource, object)
    Append(object)
      => ComCall(8, this.p, IXpsOMRemoteDictionaryResource, object)
    GetByPartName(partName, remoteDictionaryResource)
      => ComCall(9, this.p, IOpcPartUri, partName, IXpsOMRemoteDictionaryResource.Ptr, remoteDictionaryResource)
}
struct IXpsOMSignatureBlockResourceCollection extends IUnknown {
    static IID := "{AB8F5D8E-351B-4D33-AAED-FA56F0022931}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, signatureBlockResource)
      => ComCall(4, this.p, UInt32, index, IXpsOMSignatureBlockResource.Ptr, signatureBlockResource)
    InsertAt(index, signatureBlockResource)
      => ComCall(5, this.p, UInt32, index, IXpsOMSignatureBlockResource, signatureBlockResource)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, signatureBlockResource)
      => ComCall(7, this.p, UInt32, index, IXpsOMSignatureBlockResource, signatureBlockResource)
    Append(signatureBlockResource)
      => ComCall(8, this.p, IXpsOMSignatureBlockResource, signatureBlockResource)
    GetByPartName(partName, signatureBlockResource)
      => ComCall(9, this.p, IOpcPartUri, partName, IXpsOMSignatureBlockResource.Ptr, signatureBlockResource)
}
struct IXpsOMDocumentStructureResource extends IXpsOMResource {
    static IID := "{85FEBC8A-6B63-48A9-AF07-7064E4ECFF30}"
    GetOwner(owner)
      => ComCall(5, this.p, IXpsOMDocument.Ptr, owner)
    GetStream(stream)
      => ComCall(6, this.p, IStream.Ptr, stream)
    SetContent(sourceStream, partName)
      => ComCall(7, this.p, IStream, sourceStream, IOpcPartUri, partName)
}
struct IXpsOMStoryFragmentsResource extends IXpsOMResource {
    static IID := "{C2B3CA09-0473-4282-87AE-1780863223F0}"
    GetOwner(owner)
      => ComCall(5, this.p, IXpsOMPageReference.Ptr, owner)
    GetStream(stream)
      => ComCall(6, this.p, IStream.Ptr, stream)
    SetContent(sourceStream, partName)
      => ComCall(7, this.p, IStream, sourceStream, IOpcPartUri, partName)
}
struct IXpsOMSignatureBlockResource extends IXpsOMResource {
    static IID := "{4776AD35-2E04-4357-8743-EBF6C171A905}"
    GetOwner(owner)
      => ComCall(5, this.p, IXpsOMDocument.Ptr, owner)
    GetStream(stream)
      => ComCall(6, this.p, IStream.Ptr, stream)
    SetContent(sourceStream, partName)
      => ComCall(7, this.p, IStream, sourceStream, IOpcPartUri, partName)
}
struct IXpsOMVisualCollection extends IUnknown {
    static IID := "{94D8ABDE-AB91-46A8-82B7-F5B05EF01A96}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, object)
      => ComCall(4, this.p, UInt32, index, IXpsOMVisual.Ptr, object)
    InsertAt(index, object)
      => ComCall(5, this.p, UInt32, index, IXpsOMVisual, object)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, object)
      => ComCall(7, this.p, UInt32, index, IXpsOMVisual, object)
    Append(object)
      => ComCall(8, this.p, IXpsOMVisual, object)
}
struct IXpsOMCanvas extends IXpsOMVisual {
    static IID := "{221D1452-331E-47C6-87E9-6CCEFB9B5BA3}"
    GetVisuals(visuals)
      => ComCall(30, this.p, IXpsOMVisualCollection.Ptr, visuals)
    GetUseAliasedEdgeMode(useAliasedEdgeMode)
      => ComCall(31, this.p, BOOL.Ptr, useAliasedEdgeMode)
    SetUseAliasedEdgeMode(useAliasedEdgeMode)
      => ComCall(32, this.p, BOOL, useAliasedEdgeMode)
    GetAccessibilityShortDescription(shortDescription)
      => ComCall(33, this.p, PWSTR.Ptr, shortDescription)
    SetAccessibilityShortDescription(shortDescription)
      => ComCall(34, this.p, "Str", shortDescription)
    GetAccessibilityLongDescription(longDescription)
      => ComCall(35, this.p, PWSTR.Ptr, longDescription)
    SetAccessibilityLongDescription(longDescription)
      => ComCall(36, this.p, "Str", longDescription)
    GetDictionary(resourceDictionary)
      => ComCall(37, this.p, IXpsOMDictionary.Ptr, resourceDictionary)
    GetDictionaryLocal(resourceDictionary)
      => ComCall(38, this.p, IXpsOMDictionary.Ptr, resourceDictionary)
    SetDictionaryLocal(resourceDictionary)
      => ComCall(39, this.p, IXpsOMDictionary, resourceDictionary)
    GetDictionaryResource(remoteDictionaryResource)
      => ComCall(40, this.p, IXpsOMRemoteDictionaryResource.Ptr, remoteDictionaryResource)
    SetDictionaryResource(remoteDictionaryResource)
      => ComCall(41, this.p, IXpsOMRemoteDictionaryResource, remoteDictionaryResource)
    Clone(canvas)
      => ComCall(42, this.p, IXpsOMCanvas.Ptr, canvas)
}
struct IXpsOMPage extends IXpsOMPart {
    static IID := "{D3E18888-F120-4FEE-8C68-35296EAE91D4}"
    GetOwner(pageReference)
      => ComCall(5, this.p, IXpsOMPageReference.Ptr, pageReference)
    GetVisuals(visuals)
      => ComCall(6, this.p, IXpsOMVisualCollection.Ptr, visuals)
    GetPageDimensions(pageDimensions)
      => ComCall(7, this.p, XPS_SIZE.Ptr, pageDimensions)
    SetPageDimensions(pageDimensions)
      => ComCall(8, this.p, XPS_SIZE.Ptr, pageDimensions)
    GetContentBox(contentBox)
      => ComCall(9, this.p, XPS_RECT.Ptr, contentBox)
    SetContentBox(contentBox)
      => ComCall(10, this.p, XPS_RECT.Ptr, contentBox)
    GetBleedBox(bleedBox)
      => ComCall(11, this.p, XPS_RECT.Ptr, bleedBox)
    SetBleedBox(bleedBox)
      => ComCall(12, this.p, XPS_RECT.Ptr, bleedBox)
    GetLanguage(language)
      => ComCall(13, this.p, PWSTR.Ptr, language)
    SetLanguage(language)
      => ComCall(14, this.p, "Str", language)
    GetName(name)
      => ComCall(15, this.p, PWSTR.Ptr, name)
    SetName(name)
      => ComCall(16, this.p, "Str", name)
    GetIsHyperlinkTarget(isHyperlinkTarget)
      => ComCall(17, this.p, BOOL.Ptr, isHyperlinkTarget)
    SetIsHyperlinkTarget(isHyperlinkTarget)
      => ComCall(18, this.p, BOOL, isHyperlinkTarget)
    GetDictionary(resourceDictionary)
      => ComCall(19, this.p, IXpsOMDictionary.Ptr, resourceDictionary)
    GetDictionaryLocal(resourceDictionary)
      => ComCall(20, this.p, IXpsOMDictionary.Ptr, resourceDictionary)
    SetDictionaryLocal(resourceDictionary)
      => ComCall(21, this.p, IXpsOMDictionary, resourceDictionary)
    GetDictionaryResource(remoteDictionaryResource)
      => ComCall(22, this.p, IXpsOMRemoteDictionaryResource.Ptr, remoteDictionaryResource)
    SetDictionaryResource(remoteDictionaryResource)
      => ComCall(23, this.p, IXpsOMRemoteDictionaryResource, remoteDictionaryResource)
    Write(stream, optimizeMarkupSize)
      => ComCall(24, this.p, ISequentialStream, stream, BOOL, optimizeMarkupSize)
    GenerateUnusedLookupKey(type, key)
      => ComCall(25, this.p, XPS_OBJECT_TYPE, type, PWSTR.Ptr, key)
    Clone(page)
      => ComCall(26, this.p, IXpsOMPage.Ptr, page)
}
struct IXpsOMPageReference extends IUnknown {
    static IID := "{ED360180-6F92-4998-890D-2F208531A0A0}"
    GetOwner(document)
      => ComCall(3, this.p, IXpsOMDocument.Ptr, document)
    GetPage(page)
      => ComCall(4, this.p, IXpsOMPage.Ptr, page)
    SetPage(page)
      => ComCall(5, this.p, IXpsOMPage, page)
    DiscardPage()
      => ComCall(6, this.p)
    IsPageLoaded(isPageLoaded)
      => ComCall(7, this.p, BOOL.Ptr, isPageLoaded)
    GetAdvisoryPageDimensions(pageDimensions)
      => ComCall(8, this.p, XPS_SIZE.Ptr, pageDimensions)
    SetAdvisoryPageDimensions(pageDimensions)
      => ComCall(9, this.p, XPS_SIZE.Ptr, pageDimensions)
    GetStoryFragmentsResource(storyFragmentsResource)
      => ComCall(10, this.p, IXpsOMStoryFragmentsResource.Ptr, storyFragmentsResource)
    SetStoryFragmentsResource(storyFragmentsResource)
      => ComCall(11, this.p, IXpsOMStoryFragmentsResource, storyFragmentsResource)
    GetPrintTicketResource(printTicketResource)
      => ComCall(12, this.p, IXpsOMPrintTicketResource.Ptr, printTicketResource)
    SetPrintTicketResource(printTicketResource)
      => ComCall(13, this.p, IXpsOMPrintTicketResource, printTicketResource)
    GetThumbnailResource(imageResource)
      => ComCall(14, this.p, IXpsOMImageResource.Ptr, imageResource)
    SetThumbnailResource(imageResource)
      => ComCall(15, this.p, IXpsOMImageResource, imageResource)
    CollectLinkTargets(linkTargets)
      => ComCall(16, this.p, IXpsOMNameCollection.Ptr, linkTargets)
    CollectPartResources(partResources)
      => ComCall(17, this.p, IXpsOMPartResources.Ptr, partResources)
    HasRestrictedFonts(restrictedFonts)
      => ComCall(18, this.p, BOOL.Ptr, restrictedFonts)
    Clone(pageReference)
      => ComCall(19, this.p, IXpsOMPageReference.Ptr, pageReference)
}
struct IXpsOMPageReferenceCollection extends IUnknown {
    static IID := "{CA16BA4D-E7B9-45C5-958B-F98022473745}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, pageReference)
      => ComCall(4, this.p, UInt32, index, IXpsOMPageReference.Ptr, pageReference)
    InsertAt(index, pageReference)
      => ComCall(5, this.p, UInt32, index, IXpsOMPageReference, pageReference)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, pageReference)
      => ComCall(7, this.p, UInt32, index, IXpsOMPageReference, pageReference)
    Append(pageReference)
      => ComCall(8, this.p, IXpsOMPageReference, pageReference)
}
struct IXpsOMDocument extends IXpsOMPart {
    static IID := "{2C2C94CB-AC5F-4254-8EE9-23948309D9F0}"
    GetOwner(documentSequence)
      => ComCall(5, this.p, IXpsOMDocumentSequence.Ptr, documentSequence)
    GetPageReferences(pageReferences)
      => ComCall(6, this.p, IXpsOMPageReferenceCollection.Ptr, pageReferences)
    GetPrintTicketResource(printTicketResource)
      => ComCall(7, this.p, IXpsOMPrintTicketResource.Ptr, printTicketResource)
    SetPrintTicketResource(printTicketResource)
      => ComCall(8, this.p, IXpsOMPrintTicketResource, printTicketResource)
    GetDocumentStructureResource(documentStructureResource)
      => ComCall(9, this.p, IXpsOMDocumentStructureResource.Ptr, documentStructureResource)
    SetDocumentStructureResource(documentStructureResource)
      => ComCall(10, this.p, IXpsOMDocumentStructureResource, documentStructureResource)
    GetSignatureBlockResources(signatureBlockResources)
      => ComCall(11, this.p, IXpsOMSignatureBlockResourceCollection.Ptr, signatureBlockResources)
    Clone(document)
      => ComCall(12, this.p, IXpsOMDocument.Ptr, document)
}
struct IXpsOMDocumentCollection extends IUnknown {
    static IID := "{D1C87F0D-E947-4754-8A25-971478F7E83E}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, document)
      => ComCall(4, this.p, UInt32, index, IXpsOMDocument.Ptr, document)
    InsertAt(index, document)
      => ComCall(5, this.p, UInt32, index, IXpsOMDocument, document)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, document)
      => ComCall(7, this.p, UInt32, index, IXpsOMDocument, document)
    Append(document)
      => ComCall(8, this.p, IXpsOMDocument, document)
}
struct IXpsOMDocumentSequence extends IXpsOMPart {
    static IID := "{56492EB4-D8D5-425E-8256-4C2B64AD0264}"
    GetOwner(package)
      => ComCall(5, this.p, IXpsOMPackage.Ptr, package)
    GetDocuments(documents)
      => ComCall(6, this.p, IXpsOMDocumentCollection.Ptr, documents)
    GetPrintTicketResource(printTicketResource)
      => ComCall(7, this.p, IXpsOMPrintTicketResource.Ptr, printTicketResource)
    SetPrintTicketResource(printTicketResource)
      => ComCall(8, this.p, IXpsOMPrintTicketResource, printTicketResource)
}
struct IXpsOMCoreProperties extends IXpsOMPart {
    static IID := "{3340FE8F-4027-4AA1-8F5F-D35AE45FE597}"
    GetOwner(package)
      => ComCall(5, this.p, IXpsOMPackage.Ptr, package)
    GetCategory(category)
      => ComCall(6, this.p, PWSTR.Ptr, category)
    SetCategory(category)
      => ComCall(7, this.p, "Str", category)
    GetContentStatus(contentStatus)
      => ComCall(8, this.p, PWSTR.Ptr, contentStatus)
    SetContentStatus(contentStatus)
      => ComCall(9, this.p, "Str", contentStatus)
    GetContentType(contentType)
      => ComCall(10, this.p, PWSTR.Ptr, contentType)
    SetContentType(contentType)
      => ComCall(11, this.p, "Str", contentType)
    GetCreated(created)
      => ComCall(12, this.p, SYSTEMTIME.Ptr, created)
    SetCreated(created)
      => ComCall(13, this.p, SYSTEMTIME.Ptr, created)
    GetCreator(creator)
      => ComCall(14, this.p, PWSTR.Ptr, creator)
    SetCreator(creator)
      => ComCall(15, this.p, "Str", creator)
    GetDescription(description)
      => ComCall(16, this.p, PWSTR.Ptr, description)
    SetDescription(description)
      => ComCall(17, this.p, "Str", description)
    GetIdentifier(identifier)
      => ComCall(18, this.p, PWSTR.Ptr, identifier)
    SetIdentifier(identifier)
      => ComCall(19, this.p, "Str", identifier)
    GetKeywords(keywords)
      => ComCall(20, this.p, PWSTR.Ptr, keywords)
    SetKeywords(keywords)
      => ComCall(21, this.p, "Str", keywords)
    GetLanguage(language)
      => ComCall(22, this.p, PWSTR.Ptr, language)
    SetLanguage(language)
      => ComCall(23, this.p, "Str", language)
    GetLastModifiedBy(lastModifiedBy)
      => ComCall(24, this.p, PWSTR.Ptr, lastModifiedBy)
    SetLastModifiedBy(lastModifiedBy)
      => ComCall(25, this.p, "Str", lastModifiedBy)
    GetLastPrinted(lastPrinted)
      => ComCall(26, this.p, SYSTEMTIME.Ptr, lastPrinted)
    SetLastPrinted(lastPrinted)
      => ComCall(27, this.p, SYSTEMTIME.Ptr, lastPrinted)
    GetModified(modified)
      => ComCall(28, this.p, SYSTEMTIME.Ptr, modified)
    SetModified(modified)
      => ComCall(29, this.p, SYSTEMTIME.Ptr, modified)
    GetRevision(revision)
      => ComCall(30, this.p, PWSTR.Ptr, revision)
    SetRevision(revision)
      => ComCall(31, this.p, "Str", revision)
    GetSubject(subject)
      => ComCall(32, this.p, PWSTR.Ptr, subject)
    SetSubject(subject)
      => ComCall(33, this.p, "Str", subject)
    GetTitle(title)
      => ComCall(34, this.p, PWSTR.Ptr, title)
    SetTitle(title)
      => ComCall(35, this.p, "Str", title)
    GetVersion(version)
      => ComCall(36, this.p, PWSTR.Ptr, version)
    SetVersion(version)
      => ComCall(37, this.p, "Str", version)
    Clone(coreProperties)
      => ComCall(38, this.p, IXpsOMCoreProperties.Ptr, coreProperties)
}
struct IXpsOMPackage extends IUnknown {
    static IID := "{18C3DF65-81E1-4674-91DC-FC452F5A416F}"
    GetDocumentSequence(documentSequence)
      => ComCall(3, this.p, IXpsOMDocumentSequence.Ptr, documentSequence)
    SetDocumentSequence(documentSequence)
      => ComCall(4, this.p, IXpsOMDocumentSequence, documentSequence)
    GetCoreProperties(coreProperties)
      => ComCall(5, this.p, IXpsOMCoreProperties.Ptr, coreProperties)
    SetCoreProperties(coreProperties)
      => ComCall(6, this.p, IXpsOMCoreProperties, coreProperties)
    GetDiscardControlPartName(discardControlPartUri)
      => ComCall(7, this.p, IOpcPartUri.Ptr, discardControlPartUri)
    SetDiscardControlPartName(discardControlPartUri)
      => ComCall(8, this.p, IOpcPartUri, discardControlPartUri)
    GetThumbnailResource(imageResource)
      => ComCall(9, this.p, IXpsOMImageResource.Ptr, imageResource)
    SetThumbnailResource(imageResource)
      => ComCall(10, this.p, IXpsOMImageResource, imageResource)
    WriteToFile(fileName, securityAttributes, flagsAndAttributes, optimizeMarkupSize)
      => ComCall(11, this.p, "Str", fileName, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, flagsAndAttributes, BOOL, optimizeMarkupSize)
    WriteToStream(stream, optimizeMarkupSize)
      => ComCall(12, this.p, ISequentialStream, stream, BOOL, optimizeMarkupSize)
}
struct IXpsOMObjectFactory extends IUnknown {
    static IID := "{F9B2A685-A50D-4FC2-B764-B56E093EA0CA}"
    CreatePackage(package)
      => ComCall(3, this.p, IXpsOMPackage.Ptr, package)
    CreatePackageFromFile(filename, reuseObjects, package)
      => ComCall(4, this.p, "Str", filename, BOOL, reuseObjects, IXpsOMPackage.Ptr, package)
    CreatePackageFromStream(stream, reuseObjects, package)
      => ComCall(5, this.p, IStream, stream, BOOL, reuseObjects, IXpsOMPackage.Ptr, package)
    CreateStoryFragmentsResource(acquiredStream, partUri, storyFragmentsResource)
      => ComCall(6, this.p, IStream, acquiredStream, IOpcPartUri, partUri, IXpsOMStoryFragmentsResource.Ptr, storyFragmentsResource)
    CreateDocumentStructureResource(acquiredStream, partUri, documentStructureResource)
      => ComCall(7, this.p, IStream, acquiredStream, IOpcPartUri, partUri, IXpsOMDocumentStructureResource.Ptr, documentStructureResource)
    CreateSignatureBlockResource(acquiredStream, partUri, signatureBlockResource)
      => ComCall(8, this.p, IStream, acquiredStream, IOpcPartUri, partUri, IXpsOMSignatureBlockResource.Ptr, signatureBlockResource)
    CreateRemoteDictionaryResource(dictionary, partUri, remoteDictionaryResource)
      => ComCall(9, this.p, IXpsOMDictionary, dictionary, IOpcPartUri, partUri, IXpsOMRemoteDictionaryResource.Ptr, remoteDictionaryResource)
    CreateRemoteDictionaryResourceFromStream(dictionaryMarkupStream, dictionaryPartUri, resources, dictionaryResource)
      => ComCall(10, this.p, IStream, dictionaryMarkupStream, IOpcPartUri, dictionaryPartUri, IXpsOMPartResources, resources, IXpsOMRemoteDictionaryResource.Ptr, dictionaryResource)
    CreatePartResources(partResources)
      => ComCall(11, this.p, IXpsOMPartResources.Ptr, partResources)
    CreateDocumentSequence(partUri, documentSequence)
      => ComCall(12, this.p, IOpcPartUri, partUri, IXpsOMDocumentSequence.Ptr, documentSequence)
    CreateDocument(partUri, document)
      => ComCall(13, this.p, IOpcPartUri, partUri, IXpsOMDocument.Ptr, document)
    CreatePageReference(advisoryPageDimensions, pageReference)
      => ComCall(14, this.p, XPS_SIZE.Ptr, advisoryPageDimensions, IXpsOMPageReference.Ptr, pageReference)
    CreatePage(pageDimensions, language, partUri, page)
      => ComCall(15, this.p, XPS_SIZE.Ptr, pageDimensions, "Str", language, IOpcPartUri, partUri, IXpsOMPage.Ptr, page)
    CreatePageFromStream(pageMarkupStream, partUri, resources, reuseObjects, page)
      => ComCall(16, this.p, IStream, pageMarkupStream, IOpcPartUri, partUri, IXpsOMPartResources, resources, BOOL, reuseObjects, IXpsOMPage.Ptr, page)
    CreateCanvas(canvas)
      => ComCall(17, this.p, IXpsOMCanvas.Ptr, canvas)
    CreateGlyphs(fontResource, glyphs)
      => ComCall(18, this.p, IXpsOMFontResource, fontResource, IXpsOMGlyphs.Ptr, glyphs)
    CreatePath(path)
      => ComCall(19, this.p, IXpsOMPath.Ptr, path)
    CreateGeometry(geometry)
      => ComCall(20, this.p, IXpsOMGeometry.Ptr, geometry)
    CreateGeometryFigure(startPoint, figure)
      => ComCall(21, this.p, XPS_POINT.Ptr, startPoint, IXpsOMGeometryFigure.Ptr, figure)
    CreateMatrixTransform(matrix, transform)
      => ComCall(22, this.p, XPS_MATRIX.Ptr, matrix, IXpsOMMatrixTransform.Ptr, transform)
    CreateSolidColorBrush(color, colorProfile, solidColorBrush)
      => ComCall(23, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource, colorProfile, IXpsOMSolidColorBrush.Ptr, solidColorBrush)
    CreateColorProfileResource(acquiredStream, partUri, colorProfileResource)
      => ComCall(24, this.p, IStream, acquiredStream, IOpcPartUri, partUri, IXpsOMColorProfileResource.Ptr, colorProfileResource)
    CreateImageBrush(image, viewBox, viewPort, imageBrush)
      => ComCall(25, this.p, IXpsOMImageResource, image, XPS_RECT.Ptr, viewBox, XPS_RECT.Ptr, viewPort, IXpsOMImageBrush.Ptr, imageBrush)
    CreateVisualBrush(viewBox, viewPort, visualBrush)
      => ComCall(26, this.p, XPS_RECT.Ptr, viewBox, XPS_RECT.Ptr, viewPort, IXpsOMVisualBrush.Ptr, visualBrush)
    CreateImageResource(acquiredStream, contentType, partUri, imageResource)
      => ComCall(27, this.p, IStream, acquiredStream, XPS_IMAGE_TYPE, contentType, IOpcPartUri, partUri, IXpsOMImageResource.Ptr, imageResource)
    CreatePrintTicketResource(acquiredStream, partUri, printTicketResource)
      => ComCall(28, this.p, IStream, acquiredStream, IOpcPartUri, partUri, IXpsOMPrintTicketResource.Ptr, printTicketResource)
    CreateFontResource(acquiredStream, fontEmbedding, partUri, isObfSourceStream, fontResource)
      => ComCall(29, this.p, IStream, acquiredStream, XPS_FONT_EMBEDDING, fontEmbedding, IOpcPartUri, partUri, BOOL, isObfSourceStream, IXpsOMFontResource.Ptr, fontResource)
    CreateGradientStop(color, colorProfile, offset, gradientStop)
      => ComCall(30, this.p, XPS_COLOR.Ptr, color, IXpsOMColorProfileResource, colorProfile, Float32, offset, IXpsOMGradientStop.Ptr, gradientStop)
    CreateLinearGradientBrush(gradStop1, gradStop2, startPoint, endPoint, linearGradientBrush)
      => ComCall(31, this.p, IXpsOMGradientStop, gradStop1, IXpsOMGradientStop, gradStop2, XPS_POINT.Ptr, startPoint, XPS_POINT.Ptr, endPoint, IXpsOMLinearGradientBrush.Ptr, linearGradientBrush)
    CreateRadialGradientBrush(gradStop1, gradStop2, centerPoint, gradientOrigin, radiiSizes, radialGradientBrush)
      => ComCall(32, this.p, IXpsOMGradientStop, gradStop1, IXpsOMGradientStop, gradStop2, XPS_POINT.Ptr, centerPoint, XPS_POINT.Ptr, gradientOrigin, XPS_SIZE.Ptr, radiiSizes, IXpsOMRadialGradientBrush.Ptr, radialGradientBrush)
    CreateCoreProperties(partUri, coreProperties)
      => ComCall(33, this.p, IOpcPartUri, partUri, IXpsOMCoreProperties.Ptr, coreProperties)
    CreateDictionary(dictionary)
      => ComCall(34, this.p, IXpsOMDictionary.Ptr, dictionary)
    CreatePartUriCollection(partUriCollection)
      => ComCall(35, this.p, IXpsOMPartUriCollection.Ptr, partUriCollection)
    CreatePackageWriterOnFile(fileName, securityAttributes, flagsAndAttributes, optimizeMarkupSize, interleaving, documentSequencePartName, coreProperties, packageThumbnail, documentSequencePrintTicket, discardControlPartName, packageWriter)
      => ComCall(36, this.p, "Str", fileName, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, flagsAndAttributes, BOOL, optimizeMarkupSize, XPS_INTERLEAVING, interleaving, IOpcPartUri, documentSequencePartName, IXpsOMCoreProperties, coreProperties, IXpsOMImageResource, packageThumbnail, IXpsOMPrintTicketResource, documentSequencePrintTicket, IOpcPartUri, discardControlPartName, IXpsOMPackageWriter.Ptr, packageWriter)
    CreatePackageWriterOnStream(outputStream, optimizeMarkupSize, interleaving, documentSequencePartName, coreProperties, packageThumbnail, documentSequencePrintTicket, discardControlPartName, packageWriter)
      => ComCall(37, this.p, ISequentialStream, outputStream, BOOL, optimizeMarkupSize, XPS_INTERLEAVING, interleaving, IOpcPartUri, documentSequencePartName, IXpsOMCoreProperties, coreProperties, IXpsOMImageResource, packageThumbnail, IXpsOMPrintTicketResource, documentSequencePrintTicket, IOpcPartUri, discardControlPartName, IXpsOMPackageWriter.Ptr, packageWriter)
    CreatePartUri(uri, partUri)
      => ComCall(38, this.p, "Str", uri, IOpcPartUri.Ptr, partUri)
    CreateReadOnlyStreamOnFile(filename, stream)
      => ComCall(39, this.p, "Str", filename, IStream.Ptr, stream)
}
struct IXpsOMNameCollection extends IUnknown {
    static IID := "{4BDDF8EC-C915-421B-A166-D173D25653D2}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, name)
      => ComCall(4, this.p, UInt32, index, PWSTR.Ptr, name)
}
struct IXpsOMPartUriCollection extends IUnknown {
    static IID := "{57C650D4-067C-4893-8C33-F62A0633730F}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, partUri)
      => ComCall(4, this.p, UInt32, index, IOpcPartUri.Ptr, partUri)
    InsertAt(index, partUri)
      => ComCall(5, this.p, UInt32, index, IOpcPartUri, partUri)
    RemoveAt(index)
      => ComCall(6, this.p, UInt32, index)
    SetAt(index, partUri)
      => ComCall(7, this.p, UInt32, index, IOpcPartUri, partUri)
    Append(partUri)
      => ComCall(8, this.p, IOpcPartUri, partUri)
}
struct IXpsOMPackageWriter extends IUnknown {
    static IID := "{4E2AA182-A443-42C6-B41B-4F8E9DE73FF9}"
    StartNewDocument(documentPartName, documentPrintTicket, documentStructure, signatureBlockResources, restrictedFonts)
      => ComCall(3, this.p, IOpcPartUri, documentPartName, IXpsOMPrintTicketResource, documentPrintTicket, IXpsOMDocumentStructureResource, documentStructure, IXpsOMSignatureBlockResourceCollection, signatureBlockResources, IXpsOMPartUriCollection, restrictedFonts)
    AddPage(page, advisoryPageDimensions, discardableResourceParts, storyFragments, pagePrintTicket, pageThumbnail)
      => ComCall(4, this.p, IXpsOMPage, page, XPS_SIZE.Ptr, advisoryPageDimensions, IXpsOMPartUriCollection, discardableResourceParts, IXpsOMStoryFragmentsResource, storyFragments, IXpsOMPrintTicketResource, pagePrintTicket, IXpsOMImageResource, pageThumbnail)
    AddResource(resource)
      => ComCall(5, this.p, IXpsOMResource, resource)
    Close()
      => ComCall(6, this.p)
    IsClosed(isClosed)
      => ComCall(7, this.p, BOOL.Ptr, isClosed)
}
struct IXpsOMPackageTarget extends IUnknown {
    static IID := "{219A9DB0-4959-47D0-8034-B1CE84F41A4D}"
    CreateXpsOMPackageWriter(documentSequencePartName, documentSequencePrintTicket, discardControlPartName, packageWriter)
      => ComCall(3, this.p, IOpcPartUri, documentSequencePartName, IXpsOMPrintTicketResource, documentSequencePrintTicket, IOpcPartUri, discardControlPartName, IXpsOMPackageWriter.Ptr, packageWriter)
}
struct IXpsOMThumbnailGenerator extends IUnknown {
    static IID := "{15B873D5-1971-41E8-83A3-6578403064C7}"
    GenerateThumbnail(page, thumbnailType, thumbnailSize, imageResourcePartName, imageResource)
      => ComCall(3, this.p, IXpsOMPage, page, XPS_IMAGE_TYPE, thumbnailType, XPS_THUMBNAIL_SIZE, thumbnailSize, IOpcPartUri, imageResourcePartName, IXpsOMImageResource.Ptr, imageResource)
}
struct XPS_DOCUMENT_TYPE extends Int32 {
    static XPS_DOCUMENT_TYPE_UNSPECIFIED := 1
    static XPS_DOCUMENT_TYPE_XPS := 2
    static XPS_DOCUMENT_TYPE_OPENXPS := 3
}
struct IXpsOMObjectFactory1 extends IXpsOMObjectFactory {
    static IID := "{0A91B617-D612-4181-BF7C-BE5824E9CC8F}"
    GetDocumentTypeFromFile(filename, documentType)
      => ComCall(40, this.p, "Str", filename, XPS_DOCUMENT_TYPE.Ptr, documentType)
    GetDocumentTypeFromStream(xpsDocumentStream, documentType)
      => ComCall(41, this.p, IStream, xpsDocumentStream, XPS_DOCUMENT_TYPE.Ptr, documentType)
    ConvertHDPhotoToJpegXR(imageResource)
      => ComCall(42, this.p, IXpsOMImageResource, imageResource)
    ConvertJpegXRToHDPhoto(imageResource)
      => ComCall(43, this.p, IXpsOMImageResource, imageResource)
    CreatePackageWriterOnFile1(fileName, securityAttributes, flagsAndAttributes, optimizeMarkupSize, interleaving, documentSequencePartName, coreProperties, packageThumbnail, documentSequencePrintTicket, discardControlPartName, documentType, packageWriter)
      => ComCall(44, this.p, "Str", fileName, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, flagsAndAttributes, BOOL, optimizeMarkupSize, XPS_INTERLEAVING, interleaving, IOpcPartUri, documentSequencePartName, IXpsOMCoreProperties, coreProperties, IXpsOMImageResource, packageThumbnail, IXpsOMPrintTicketResource, documentSequencePrintTicket, IOpcPartUri, discardControlPartName, XPS_DOCUMENT_TYPE, documentType, IXpsOMPackageWriter.Ptr, packageWriter)
    CreatePackageWriterOnStream1(outputStream, optimizeMarkupSize, interleaving, documentSequencePartName, coreProperties, packageThumbnail, documentSequencePrintTicket, discardControlPartName, documentType, packageWriter)
      => ComCall(45, this.p, ISequentialStream, outputStream, BOOL, optimizeMarkupSize, XPS_INTERLEAVING, interleaving, IOpcPartUri, documentSequencePartName, IXpsOMCoreProperties, coreProperties, IXpsOMImageResource, packageThumbnail, IXpsOMPrintTicketResource, documentSequencePrintTicket, IOpcPartUri, discardControlPartName, XPS_DOCUMENT_TYPE, documentType, IXpsOMPackageWriter.Ptr, packageWriter)
    CreatePackage1(package)
      => ComCall(46, this.p, IXpsOMPackage1.Ptr, package)
    CreatePackageFromStream1(stream, reuseObjects, package)
      => ComCall(47, this.p, IStream, stream, BOOL, reuseObjects, IXpsOMPackage1.Ptr, package)
    CreatePackageFromFile1(filename, reuseObjects, package)
      => ComCall(48, this.p, "Str", filename, BOOL, reuseObjects, IXpsOMPackage1.Ptr, package)
    CreatePage1(pageDimensions, language, partUri, page)
      => ComCall(49, this.p, XPS_SIZE.Ptr, pageDimensions, "Str", language, IOpcPartUri, partUri, IXpsOMPage1.Ptr, page)
    CreatePageFromStream1(pageMarkupStream, partUri, resources, reuseObjects, page)
      => ComCall(50, this.p, IStream, pageMarkupStream, IOpcPartUri, partUri, IXpsOMPartResources, resources, BOOL, reuseObjects, IXpsOMPage1.Ptr, page)
    CreateRemoteDictionaryResourceFromStream1(dictionaryMarkupStream, partUri, resources, dictionaryResource)
      => ComCall(51, this.p, IStream, dictionaryMarkupStream, IOpcPartUri, partUri, IXpsOMPartResources, resources, IXpsOMRemoteDictionaryResource.Ptr, dictionaryResource)
}
struct IXpsOMPackage1 extends IXpsOMPackage {
    static IID := "{95A9435E-12BB-461B-8E7F-C6ADB04CD96A}"
    GetDocumentType(documentType)
      => ComCall(13, this.p, XPS_DOCUMENT_TYPE.Ptr, documentType)
    WriteToFile1(fileName, securityAttributes, flagsAndAttributes, optimizeMarkupSize, documentType)
      => ComCall(14, this.p, "Str", fileName, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, flagsAndAttributes, BOOL, optimizeMarkupSize, XPS_DOCUMENT_TYPE, documentType)
    WriteToStream1(outputStream, optimizeMarkupSize, documentType)
      => ComCall(15, this.p, ISequentialStream, outputStream, BOOL, optimizeMarkupSize, XPS_DOCUMENT_TYPE, documentType)
}
struct IXpsOMPage1 extends IXpsOMPage {
    static IID := "{305B60EF-6892-4DDA-9CBB-3AA65974508A}"
    GetDocumentType(documentType)
      => ComCall(27, this.p, XPS_DOCUMENT_TYPE.Ptr, documentType)
    Write1(stream, optimizeMarkupSize, documentType)
      => ComCall(28, this.p, ISequentialStream, stream, BOOL, optimizeMarkupSize, XPS_DOCUMENT_TYPE, documentType)
}
struct IXpsDocumentPackageTarget extends IUnknown {
    static IID := "{3B0B6D38-53AD-41DA-B212-D37637A6714E}"
    GetXpsOMPackageWriter(documentSequencePartName, discardControlPartName, packageWriter)
      => ComCall(3, this.p, IOpcPartUri, documentSequencePartName, IOpcPartUri, discardControlPartName, IXpsOMPackageWriter.Ptr, packageWriter)
    GetXpsOMFactory(xpsFactory)
      => ComCall(4, this.p, IXpsOMObjectFactory.Ptr, xpsFactory)
    GetXpsType(documentType)
      => ComCall(5, this.p, XPS_DOCUMENT_TYPE.Ptr, documentType)
}
struct IXpsOMRemoteDictionaryResource1 extends IXpsOMRemoteDictionaryResource {
    static IID := "{BF8FC1D4-9D46-4141-BA5F-94BB9250D041}"
    GetDocumentType(documentType)
      => ComCall(7, this.p, XPS_DOCUMENT_TYPE.Ptr, documentType)
    Write1(stream, documentType)
      => ComCall(8, this.p, ISequentialStream, stream, XPS_DOCUMENT_TYPE, documentType)
}
struct IXpsOMPackageWriter3D extends IXpsOMPackageWriter {
    static IID := "{E8A45033-640E-43FA-9BDF-FDDEAA31C6A0}"
    AddModelTexture(texturePartName, textureData)
      => ComCall(8, this.p, IOpcPartUri, texturePartName, IStream, textureData)
    SetModelPrintTicket(printTicketPartName, printTicketData)
      => ComCall(9, this.p, IOpcPartUri, printTicketPartName, IStream, printTicketData)
}
struct IXpsDocumentPackageTarget3D extends IUnknown {
    static IID := "{60BA71B8-3101-4984-9199-F4EA775FF01D}"
    GetXpsOMPackageWriter3D(documentSequencePartName, discardControlPartName, modelPartName, modelData, packageWriter)
      => ComCall(3, this.p, IOpcPartUri, documentSequencePartName, IOpcPartUri, discardControlPartName, IOpcPartUri, modelPartName, IStream, modelData, IXpsOMPackageWriter3D.Ptr, packageWriter)
    GetXpsOMFactory(xpsFactory)
      => ComCall(4, this.p, IXpsOMObjectFactory.Ptr, xpsFactory)
}
struct XPS_SIGNATURE_STATUS extends Int32 {
    static XPS_SIGNATURE_STATUS_INCOMPLIANT := 1
    static XPS_SIGNATURE_STATUS_INCOMPLETE := 2
    static XPS_SIGNATURE_STATUS_BROKEN := 3
    static XPS_SIGNATURE_STATUS_QUESTIONABLE := 4
    static XPS_SIGNATURE_STATUS_VALID := 5
}
struct XPS_SIGN_POLICY extends Int32 {
    static XPS_SIGN_POLICY_NONE := 0
    static XPS_SIGN_POLICY_CORE_PROPERTIES := 1
    static XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS := 2
    static XPS_SIGN_POLICY_PRINT_TICKET := 4
    static XPS_SIGN_POLICY_DISCARD_CONTROL := 8
    static XPS_SIGN_POLICY_ALL := 15
}
struct XPS_SIGN_FLAGS extends Int32 {
    static XPS_SIGN_FLAGS_NONE := 0
    static XPS_SIGN_FLAGS_IGNORE_MARKUP_COMPATIBILITY := 1
}
struct IXpsSigningOptions extends IUnknown {
    static IID := "{7718EAE4-3215-49BE-AF5B-594FEF7FCFA6}"
    GetSignatureId(signatureId)
      => ComCall(3, this.p, PWSTR.Ptr, signatureId)
    SetSignatureId(signatureId)
      => ComCall(4, this.p, "Str", signatureId)
    GetSignatureMethod(signatureMethod)
      => ComCall(5, this.p, PWSTR.Ptr, signatureMethod)
    SetSignatureMethod(signatureMethod)
      => ComCall(6, this.p, "Str", signatureMethod)
    GetDigestMethod(digestMethod)
      => ComCall(7, this.p, PWSTR.Ptr, digestMethod)
    SetDigestMethod(digestMethod)
      => ComCall(8, this.p, "Str", digestMethod)
    GetSignaturePartName(signaturePartName)
      => ComCall(9, this.p, IOpcPartUri.Ptr, signaturePartName)
    SetSignaturePartName(signaturePartName)
      => ComCall(10, this.p, IOpcPartUri, signaturePartName)
    GetPolicy(policy)
      => ComCall(11, this.p, XPS_SIGN_POLICY.Ptr, policy)
    SetPolicy(policy)
      => ComCall(12, this.p, XPS_SIGN_POLICY, policy)
    GetSigningTimeFormat(timeFormat)
      => ComCall(13, this.p, OPC_SIGNATURE_TIME_FORMAT.Ptr, timeFormat)
    SetSigningTimeFormat(timeFormat)
      => ComCall(14, this.p, OPC_SIGNATURE_TIME_FORMAT, timeFormat)
    GetCustomObjects(customObjectSet)
      => ComCall(15, this.p, IOpcSignatureCustomObjectSet.Ptr, customObjectSet)
    GetCustomReferences(customReferenceSet)
      => ComCall(16, this.p, IOpcSignatureReferenceSet.Ptr, customReferenceSet)
    GetCertificateSet(certificateSet)
      => ComCall(17, this.p, IOpcCertificateSet.Ptr, certificateSet)
    GetFlags(flags)
      => ComCall(18, this.p, XPS_SIGN_FLAGS.Ptr, flags)
    SetFlags(flags)
      => ComCall(19, this.p, XPS_SIGN_FLAGS, flags)
}
struct IXpsSignatureCollection extends IUnknown {
    static IID := "{A2D1D95D-ADD2-4DFF-AB27-6B9C645FF322}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, signature)
      => ComCall(4, this.p, UInt32, index, IXpsSignature.Ptr, signature)
    RemoveAt(index)
      => ComCall(5, this.p, UInt32, index)
}
struct IXpsSignature extends IUnknown {
    static IID := "{6AE4C93E-1ADE-42FB-898B-3A5658284857}"
    GetSignatureId(sigId)
      => ComCall(3, this.p, PWSTR.Ptr, sigId)
    GetSignatureValue(signatureHashValue)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, signatureHashValue, UInt32.Ptr, signatureHashValue.Length)
    GetCertificateEnumerator(certificateEnumerator)
      => ComCall(5, this.p, IOpcCertificateEnumerator.Ptr, certificateEnumerator)
    GetSigningTime(sigDateTimeString)
      => ComCall(6, this.p, PWSTR.Ptr, sigDateTimeString)
    GetSigningTimeFormat(timeFormat)
      => ComCall(7, this.p, OPC_SIGNATURE_TIME_FORMAT.Ptr, timeFormat)
    GetSignaturePartName(signaturePartName)
      => ComCall(8, this.p, IOpcPartUri.Ptr, signaturePartName)
    Verify(x509Certificate, sigStatus)
      => ComCall(9, this.p, CERT_CONTEXT.Ptr, x509Certificate, XPS_SIGNATURE_STATUS.Ptr, sigStatus)
    GetPolicy(policy)
      => ComCall(10, this.p, XPS_SIGN_POLICY.Ptr, policy)
    GetCustomObjectEnumerator(customObjectEnumerator)
      => ComCall(11, this.p, IOpcSignatureCustomObjectEnumerator.Ptr, customObjectEnumerator)
    GetCustomReferenceEnumerator(customReferenceEnumerator)
      => ComCall(12, this.p, IOpcSignatureReferenceEnumerator.Ptr, customReferenceEnumerator)
    GetSignatureXml(signatureXml)
      => ComCall(13, this.p, UInt8.Ptr.Ptr, signatureXml, UInt32.Ptr, signatureXml.Length)
    SetSignatureXml(signatureXml)
      => ComCall(14, this.p, UInt8.Ptr, signatureXml, UInt32, signatureXml.Length)
}
struct IXpsSignatureBlockCollection extends IUnknown {
    static IID := "{23397050-FE99-467A-8DCE-9237F074FFE4}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, signatureBlock)
      => ComCall(4, this.p, UInt32, index, IXpsSignatureBlock.Ptr, signatureBlock)
    RemoveAt(index)
      => ComCall(5, this.p, UInt32, index)
}
struct IXpsSignatureBlock extends IUnknown {
    static IID := "{151FAC09-0B97-4AC6-A323-5E4297D4322B}"
    GetRequests(requests)
      => ComCall(3, this.p, IXpsSignatureRequestCollection.Ptr, requests)
    GetPartName(partName)
      => ComCall(4, this.p, IOpcPartUri.Ptr, partName)
    GetDocumentIndex(fixedDocumentIndex)
      => ComCall(5, this.p, UInt32.Ptr, fixedDocumentIndex)
    GetDocumentName(fixedDocumentName)
      => ComCall(6, this.p, IOpcPartUri.Ptr, fixedDocumentName)
    CreateRequest(requestId, signatureRequest)
      => ComCall(7, this.p, "Str", requestId, IXpsSignatureRequest.Ptr, signatureRequest)
}
struct IXpsSignatureRequestCollection extends IUnknown {
    static IID := "{F0253E68-9F19-412E-9B4F-54D3B0AC6CD9}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetAt(index, signatureRequest)
      => ComCall(4, this.p, UInt32, index, IXpsSignatureRequest.Ptr, signatureRequest)
    RemoveAt(index)
      => ComCall(5, this.p, UInt32, index)
}
struct IXpsSignatureRequest extends IUnknown {
    static IID := "{AC58950B-7208-4B2D-B2C4-951083D3B8EB}"
    GetIntent(intent)
      => ComCall(3, this.p, PWSTR.Ptr, intent)
    SetIntent(intent)
      => ComCall(4, this.p, "Str", intent)
    GetRequestedSigner(signerName)
      => ComCall(5, this.p, PWSTR.Ptr, signerName)
    SetRequestedSigner(signerName)
      => ComCall(6, this.p, "Str", signerName)
    GetRequestSignByDate(dateString)
      => ComCall(7, this.p, PWSTR.Ptr, dateString)
    SetRequestSignByDate(dateString)
      => ComCall(8, this.p, "Str", dateString)
    GetSigningLocale(place)
      => ComCall(9, this.p, PWSTR.Ptr, place)
    SetSigningLocale(place)
      => ComCall(10, this.p, "Str", place)
    GetSpotLocation(pageIndex, pagePartName, x, y)
      => ComCall(11, this.p, Int32.Ptr, pageIndex, IOpcPartUri.Ptr, pagePartName, Float32.Ptr, x, Float32.Ptr, y)
    SetSpotLocation(pageIndex, x, y)
      => ComCall(12, this.p, Int32, pageIndex, Float32, x, Float32, y)
    GetRequestId(requestId)
      => ComCall(13, this.p, PWSTR.Ptr, requestId)
    GetSignature(signature)
      => ComCall(14, this.p, IXpsSignature.Ptr, signature)
}
struct IXpsSignatureManager extends IUnknown {
    static IID := "{D3E8D338-FDC4-4AFC-80B5-D532A1782EE1}"
    LoadPackageFile(fileName)
      => ComCall(3, this.p, "Str", fileName)
    LoadPackageStream(stream)
      => ComCall(4, this.p, IStream, stream)
    Sign(signOptions, x509Certificate, signature)
      => ComCall(5, this.p, IXpsSigningOptions, signOptions, CERT_CONTEXT.Ptr, x509Certificate, IXpsSignature.Ptr, signature)
    GetSignatureOriginPartName(signatureOriginPartName)
      => ComCall(6, this.p, IOpcPartUri.Ptr, signatureOriginPartName)
    SetSignatureOriginPartName(signatureOriginPartName)
      => ComCall(7, this.p, IOpcPartUri, signatureOriginPartName)
    GetSignatures(signatures)
      => ComCall(8, this.p, IXpsSignatureCollection.Ptr, signatures)
    AddSignatureBlock(partName, fixedDocumentIndex, signatureBlock)
      => ComCall(9, this.p, IOpcPartUri, partName, UInt32, fixedDocumentIndex, IXpsSignatureBlock.Ptr, signatureBlock)
    GetSignatureBlocks(signatureBlocks)
      => ComCall(10, this.p, IXpsSignatureBlockCollection.Ptr, signatureBlocks)
    CreateSigningOptions(signingOptions)
      => ComCall(11, this.p, IXpsSigningOptions.Ptr, signingOptions)
    SavePackageToFile(fileName, securityAttributes, flagsAndAttributes)
      => ComCall(12, this.p, "Str", fileName, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, flagsAndAttributes)
    SavePackageToStream(stream)
      => ComCall(13, this.p, IStream, stream)
}
