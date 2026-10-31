#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, COLORREF, FILETIME, HANDLE, HRESULT, POINT, PWSTR, RECT, SIZE}
#Import "..\Globalization\Types.ahk" {FONTSIGNATURE}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D1_GRADIENT_STOP, D2D_POINT_2F, D2D_RECT_F, D2D_SIZE_U, ID2D1SimplifiedGeometrySink}
#Import "..\Graphics.Gdi\Types.ahk" {HDC, HMONITOR, LOGFONTA, LOGFONTW}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DWRITE_FONT_AXIS_TAG extends UInt32 {
    static DWRITE_FONT_AXIS_TAG_WEIGHT := 1952999287
    static DWRITE_FONT_AXIS_TAG_WIDTH := 1752458359
    static DWRITE_FONT_AXIS_TAG_SLANT := 1953393779
    static DWRITE_FONT_AXIS_TAG_OPTICAL_SIZE := 2054385775
    static DWRITE_FONT_AXIS_TAG_ITALIC := 1818326121
}
struct DWRITE_COLOR_F {
    r : Float32
    g : Float32
    b : Float32
    a : Float32
}
struct DWRITE_MEASURING_MODE extends Int32 {
    static DWRITE_MEASURING_MODE_NATURAL := 0
    static DWRITE_MEASURING_MODE_GDI_CLASSIC := 1
    static DWRITE_MEASURING_MODE_GDI_NATURAL := 2
}
struct DWRITE_GLYPH_IMAGE_FORMATS extends Int32 {
    static DWRITE_GLYPH_IMAGE_FORMATS_NONE := 0
    static DWRITE_GLYPH_IMAGE_FORMATS_TRUETYPE := 1
    static DWRITE_GLYPH_IMAGE_FORMATS_CFF := 2
    static DWRITE_GLYPH_IMAGE_FORMATS_COLR := 4
    static DWRITE_GLYPH_IMAGE_FORMATS_SVG := 8
    static DWRITE_GLYPH_IMAGE_FORMATS_PNG := 16
    static DWRITE_GLYPH_IMAGE_FORMATS_JPEG := 32
    static DWRITE_GLYPH_IMAGE_FORMATS_TIFF := 64
    static DWRITE_GLYPH_IMAGE_FORMATS_PREMULTIPLIED_B8G8R8A8 := 128
    static DWRITE_GLYPH_IMAGE_FORMATS_COLR_PAINT_TREE := 256
}
struct DWRITE_FONT_FILE_TYPE extends Int32 {
    static DWRITE_FONT_FILE_TYPE_UNKNOWN := 0
    static DWRITE_FONT_FILE_TYPE_CFF := 1
    static DWRITE_FONT_FILE_TYPE_TRUETYPE := 2
    static DWRITE_FONT_FILE_TYPE_OPENTYPE_COLLECTION := 3
    static DWRITE_FONT_FILE_TYPE_TYPE1_PFM := 4
    static DWRITE_FONT_FILE_TYPE_TYPE1_PFB := 5
    static DWRITE_FONT_FILE_TYPE_VECTOR := 6
    static DWRITE_FONT_FILE_TYPE_BITMAP := 7
    static DWRITE_FONT_FILE_TYPE_TRUETYPE_COLLECTION := 3
}
struct DWRITE_FONT_FACE_TYPE extends Int32 {
    static DWRITE_FONT_FACE_TYPE_CFF := 0
    static DWRITE_FONT_FACE_TYPE_TRUETYPE := 1
    static DWRITE_FONT_FACE_TYPE_OPENTYPE_COLLECTION := 2
    static DWRITE_FONT_FACE_TYPE_TYPE1 := 3
    static DWRITE_FONT_FACE_TYPE_VECTOR := 4
    static DWRITE_FONT_FACE_TYPE_BITMAP := 5
    static DWRITE_FONT_FACE_TYPE_UNKNOWN := 6
    static DWRITE_FONT_FACE_TYPE_RAW_CFF := 7
    static DWRITE_FONT_FACE_TYPE_TRUETYPE_COLLECTION := 2
}
struct DWRITE_FONT_SIMULATIONS extends Int32 {
    static DWRITE_FONT_SIMULATIONS_NONE := 0
    static DWRITE_FONT_SIMULATIONS_BOLD := 1
    static DWRITE_FONT_SIMULATIONS_OBLIQUE := 2
}
struct DWRITE_FONT_WEIGHT extends Int32 {
    static DWRITE_FONT_WEIGHT_THIN := 100
    static DWRITE_FONT_WEIGHT_EXTRA_LIGHT := 200
    static DWRITE_FONT_WEIGHT_ULTRA_LIGHT := 200
    static DWRITE_FONT_WEIGHT_LIGHT := 300
    static DWRITE_FONT_WEIGHT_SEMI_LIGHT := 350
    static DWRITE_FONT_WEIGHT_NORMAL := 400
    static DWRITE_FONT_WEIGHT_REGULAR := 400
    static DWRITE_FONT_WEIGHT_MEDIUM := 500
    static DWRITE_FONT_WEIGHT_DEMI_BOLD := 600
    static DWRITE_FONT_WEIGHT_SEMI_BOLD := 600
    static DWRITE_FONT_WEIGHT_BOLD := 700
    static DWRITE_FONT_WEIGHT_EXTRA_BOLD := 800
    static DWRITE_FONT_WEIGHT_ULTRA_BOLD := 800
    static DWRITE_FONT_WEIGHT_BLACK := 900
    static DWRITE_FONT_WEIGHT_HEAVY := 900
    static DWRITE_FONT_WEIGHT_EXTRA_BLACK := 950
    static DWRITE_FONT_WEIGHT_ULTRA_BLACK := 950
}
struct DWRITE_FONT_STRETCH extends Int32 {
    static DWRITE_FONT_STRETCH_UNDEFINED := 0
    static DWRITE_FONT_STRETCH_ULTRA_CONDENSED := 1
    static DWRITE_FONT_STRETCH_EXTRA_CONDENSED := 2
    static DWRITE_FONT_STRETCH_CONDENSED := 3
    static DWRITE_FONT_STRETCH_SEMI_CONDENSED := 4
    static DWRITE_FONT_STRETCH_NORMAL := 5
    static DWRITE_FONT_STRETCH_MEDIUM := 5
    static DWRITE_FONT_STRETCH_SEMI_EXPANDED := 6
    static DWRITE_FONT_STRETCH_EXPANDED := 7
    static DWRITE_FONT_STRETCH_EXTRA_EXPANDED := 8
    static DWRITE_FONT_STRETCH_ULTRA_EXPANDED := 9
}
struct DWRITE_FONT_STYLE extends Int32 {
    static DWRITE_FONT_STYLE_NORMAL := 0
    static DWRITE_FONT_STYLE_OBLIQUE := 1
    static DWRITE_FONT_STYLE_ITALIC := 2
}
struct DWRITE_INFORMATIONAL_STRING_ID extends Int32 {
    static DWRITE_INFORMATIONAL_STRING_NONE := 0
    static DWRITE_INFORMATIONAL_STRING_COPYRIGHT_NOTICE := 1
    static DWRITE_INFORMATIONAL_STRING_VERSION_STRINGS := 2
    static DWRITE_INFORMATIONAL_STRING_TRADEMARK := 3
    static DWRITE_INFORMATIONAL_STRING_MANUFACTURER := 4
    static DWRITE_INFORMATIONAL_STRING_DESIGNER := 5
    static DWRITE_INFORMATIONAL_STRING_DESIGNER_URL := 6
    static DWRITE_INFORMATIONAL_STRING_DESCRIPTION := 7
    static DWRITE_INFORMATIONAL_STRING_FONT_VENDOR_URL := 8
    static DWRITE_INFORMATIONAL_STRING_LICENSE_DESCRIPTION := 9
    static DWRITE_INFORMATIONAL_STRING_LICENSE_INFO_URL := 10
    static DWRITE_INFORMATIONAL_STRING_WIN32_FAMILY_NAMES := 11
    static DWRITE_INFORMATIONAL_STRING_WIN32_SUBFAMILY_NAMES := 12
    static DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_FAMILY_NAMES := 13
    static DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_SUBFAMILY_NAMES := 14
    static DWRITE_INFORMATIONAL_STRING_SAMPLE_TEXT := 15
    static DWRITE_INFORMATIONAL_STRING_FULL_NAME := 16
    static DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_NAME := 17
    static DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_CID_NAME := 18
    static DWRITE_INFORMATIONAL_STRING_WEIGHT_STRETCH_STYLE_FAMILY_NAME := 19
    static DWRITE_INFORMATIONAL_STRING_DESIGN_SCRIPT_LANGUAGE_TAG := 20
    static DWRITE_INFORMATIONAL_STRING_SUPPORTED_SCRIPT_LANGUAGE_TAG := 21
    static DWRITE_INFORMATIONAL_STRING_PREFERRED_FAMILY_NAMES := 13
    static DWRITE_INFORMATIONAL_STRING_PREFERRED_SUBFAMILY_NAMES := 14
    static DWRITE_INFORMATIONAL_STRING_WWS_FAMILY_NAME := 19
}
struct DWRITE_FONT_METRICS {
    designUnitsPerEm : UInt16
    ascent : UInt16
    descent : UInt16
    lineGap : Int16
    capHeight : UInt16
    xHeight : UInt16
    underlinePosition : Int16
    underlineThickness : UInt16
    strikethroughPosition : Int16
    strikethroughThickness : UInt16
}
struct DWRITE_GLYPH_METRICS {
    leftSideBearing : Int32
    advanceWidth : UInt32
    rightSideBearing : Int32
    topSideBearing : Int32
    advanceHeight : UInt32
    bottomSideBearing : Int32
    verticalOriginY : Int32
}
struct DWRITE_GLYPH_OFFSET {
    advanceOffset : Float32
    ascenderOffset : Float32
}
struct DWRITE_FACTORY_TYPE extends Int32 {
    static DWRITE_FACTORY_TYPE_SHARED := 0
    static DWRITE_FACTORY_TYPE_ISOLATED := 1
}
struct IDWriteFontFileLoader extends IUnknown {
    static IID := "{727CAD4E-D6AF-4C9E-8A08-D695B11CAA49}"
    CreateStreamFromKey(fontFileReferenceKey, fontFileStream)
      => ComCall(3, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, IDWriteFontFileStream.Ptr, fontFileStream)
}
struct IDWriteLocalFontFileLoader extends IDWriteFontFileLoader {
    static IID := "{B2D9F3EC-C9FE-4A11-A2EC-D86208F7C0A2}"
    GetFilePathLengthFromKey(fontFileReferenceKey, filePathLength)
      => ComCall(4, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, UInt32.Ptr, filePathLength)
    GetFilePathFromKey(fontFileReferenceKey, filePath)
      => ComCall(5, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, PWSTR, filePath, UInt32, filePath.Length)
    GetLastWriteTimeFromKey(fontFileReferenceKey, lastWriteTime)
      => ComCall(6, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, FILETIME.Ptr, lastWriteTime)
}
struct IDWriteFontFileStream extends IUnknown {
    static IID := "{6D4865FE-0AB8-4D91-8F62-5DD6BE34A3E0}"
    ReadFileFragment(fragmentStart, fileOffset, fragmentSize, fragmentContext)
      => ComCall(3, this.p, Struct.Ptr.Ptr, fragmentStart, Int64, fileOffset, Int64, fragmentSize, Struct.Ptr.Ptr, fragmentContext)
    ReleaseFileFragment(fragmentContext)
      => ComCall(4, this.p, Struct.Ptr, fragmentContext, "void")
    GetFileSize(fileSize)
      => ComCall(5, this.p, Int64.Ptr, fileSize)
    GetLastWriteTime(lastWriteTime)
      => ComCall(6, this.p, Int64.Ptr, lastWriteTime)
}
struct IDWriteFontFile extends IUnknown {
    static IID := "{739D886A-CEF5-47DC-8769-1A8B41BEBBB0}"
    GetReferenceKey(fontFileReferenceKey, fontFileReferenceKeySize)
      => ComCall(3, this.p, Struct.Ptr.Ptr, fontFileReferenceKey, UInt32.Ptr, fontFileReferenceKeySize)
    GetLoader(fontFileLoader)
      => ComCall(4, this.p, IDWriteFontFileLoader.Ptr, fontFileLoader)
    Analyze(isSupportedFontType, fontFileType, fontFaceType?, numberOfFaces)
      => ComCall(5, this.p, BOOL.Ptr, isSupportedFontType, DWRITE_FONT_FILE_TYPE.Ptr, fontFileType, DWRITE_FONT_FACE_TYPE.Ptr, fontFaceType?, UInt32.Ptr, numberOfFaces)
}
struct DWRITE_PIXEL_GEOMETRY extends Int32 {
    static DWRITE_PIXEL_GEOMETRY_FLAT := 0
    static DWRITE_PIXEL_GEOMETRY_RGB := 1
    static DWRITE_PIXEL_GEOMETRY_BGR := 2
}
struct DWRITE_RENDERING_MODE extends Int32 {
    static DWRITE_RENDERING_MODE_DEFAULT := 0
    static DWRITE_RENDERING_MODE_ALIASED := 1
    static DWRITE_RENDERING_MODE_GDI_CLASSIC := 2
    static DWRITE_RENDERING_MODE_GDI_NATURAL := 3
    static DWRITE_RENDERING_MODE_NATURAL := 4
    static DWRITE_RENDERING_MODE_NATURAL_SYMMETRIC := 5
    static DWRITE_RENDERING_MODE_OUTLINE := 6
    static DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC := 2
    static DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL := 3
    static DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL := 4
    static DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL_SYMMETRIC := 5
}
struct DWRITE_MATRIX {
    m11 : Float32
    m12 : Float32
    m21 : Float32
    m22 : Float32
    dx : Float32
    dy : Float32
}
struct IDWriteRenderingParams extends IUnknown {
    static IID := "{2F0DA53A-2ADD-47CD-82EE-D9EC34688E75}"
    GetGamma()
      => ComCall(3, this.p, Float32)
    GetEnhancedContrast()
      => ComCall(4, this.p, Float32)
    GetClearTypeLevel()
      => ComCall(5, this.p, Float32)
    GetPixelGeometry()
      => ComCall(6, this.p, DWRITE_PIXEL_GEOMETRY)
    GetRenderingMode()
      => ComCall(7, this.p, DWRITE_RENDERING_MODE)
}
struct IDWriteFontFace extends IUnknown {
    static IID := "{5F49804D-7024-4D43-BFA9-D25984F53849}"
    GetType()
      => ComCall(3, this.p, DWRITE_FONT_FACE_TYPE)
    GetFiles(fontFiles?)
      => ComCall(4, this.p, UInt32.Ptr, fontFiles?.Length ?? 0, IDWriteFontFile.Ptr, fontFiles?)
    GetIndex()
      => ComCall(5, this.p, UInt32)
    GetSimulations()
      => ComCall(6, this.p, DWRITE_FONT_SIMULATIONS)
    IsSymbolFont()
      => ComCall(7, this.p, BOOL)
    GetMetrics(fontFaceMetrics)
      => ComCall(8, this.p, DWRITE_FONT_METRICS.Ptr, fontFaceMetrics, "void")
    GetGlyphCount()
      => ComCall(9, this.p, UInt16)
    GetDesignGlyphMetrics(glyphIndices, glyphMetrics, isSideways)
      => ComCall(10, this.p, UInt16.Ptr, glyphIndices, UInt32, glyphMetrics.Length, DWRITE_GLYPH_METRICS.Ptr, glyphMetrics, BOOL, isSideways)
    GetGlyphIndices(codePoints, glyphIndices)
      => ComCall(11, this.p, UInt32.Ptr, codePoints, UInt32, glyphIndices.Length, UInt16.Ptr, glyphIndices)
    TryGetFontTable(openTypeTableTag, tableData, tableSize, tableContext, exists)
      => ComCall(12, this.p, UInt32, openTypeTableTag, Struct.Ptr.Ptr, tableData, UInt32.Ptr, tableSize, Struct.Ptr.Ptr, tableContext, BOOL.Ptr, exists)
    ReleaseFontTable(tableContext)
      => ComCall(13, this.p, Struct.Ptr, tableContext, "void")
    GetGlyphRunOutline(emSize, glyphIndices, glyphAdvances?, glyphOffsets?, isSideways, isRightToLeft, geometrySink)
      => ComCall(14, this.p, Float32, emSize, UInt16.Ptr, glyphIndices, Float32.Ptr, glyphAdvances?, DWRITE_GLYPH_OFFSET.Ptr, glyphOffsets?, UInt32, glyphOffsets?.Length ?? 0, BOOL, isSideways, BOOL, isRightToLeft, ID2D1SimplifiedGeometrySink, geometrySink)
    GetRecommendedRenderingMode(emSize, pixelsPerDip, measuringMode, renderingParams, renderingMode)
      => ComCall(15, this.p, Float32, emSize, Float32, pixelsPerDip, DWRITE_MEASURING_MODE, measuringMode, IDWriteRenderingParams, renderingParams, DWRITE_RENDERING_MODE.Ptr, renderingMode)
    GetGdiCompatibleMetrics(emSize, pixelsPerDip, transform?, fontFaceMetrics)
      => ComCall(16, this.p, Float32, emSize, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, DWRITE_FONT_METRICS.Ptr, fontFaceMetrics)
    GetGdiCompatibleGlyphMetrics(emSize, pixelsPerDip, transform?, useGdiNatural, glyphIndices, glyphMetrics, isSideways)
      => ComCall(17, this.p, Float32, emSize, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, BOOL, useGdiNatural, UInt16.Ptr, glyphIndices, UInt32, glyphMetrics.Length, DWRITE_GLYPH_METRICS.Ptr, glyphMetrics, BOOL, isSideways)
}
struct IDWriteFontCollectionLoader extends IUnknown {
    static IID := "{CCA920E4-52F0-492B-BFA8-29C72EE0A468}"
    CreateEnumeratorFromKey(factory, collectionKey, fontFileEnumerator)
      => ComCall(3, this.p, IDWriteFactory, factory, Struct.Ptr, collectionKey, UInt32, collectionKey.Size, IDWriteFontFileEnumerator.Ptr, fontFileEnumerator)
}
struct IDWriteFontFileEnumerator extends IUnknown {
    static IID := "{72755049-5FF7-435D-8348-4BE97CFA6C7C}"
    MoveNext(hasCurrentFile)
      => ComCall(3, this.p, BOOL.Ptr, hasCurrentFile)
    GetCurrentFontFile(fontFile)
      => ComCall(4, this.p, IDWriteFontFile.Ptr, fontFile)
}
struct IDWriteLocalizedStrings extends IUnknown {
    static IID := "{08256209-099A-4B34-B86D-C22B110E7771}"
    GetCount()
      => ComCall(3, this.p, UInt32)
    FindLocaleName(localeName, index, exists)
      => ComCall(4, this.p, "Str", localeName, UInt32.Ptr, index, BOOL.Ptr, exists)
    GetLocaleNameLength(index, length)
      => ComCall(5, this.p, UInt32, index, UInt32.Ptr, length)
    GetLocaleName(index, localeName)
      => ComCall(6, this.p, UInt32, index, PWSTR, localeName, UInt32, localeName.Length)
    GetStringLength(index, length)
      => ComCall(7, this.p, UInt32, index, UInt32.Ptr, length)
    GetString(index, stringBuffer)
      => ComCall(8, this.p, UInt32, index, PWSTR, stringBuffer, UInt32, stringBuffer.Length)
}
struct IDWriteFontCollection extends IUnknown {
    static IID := "{A84CEE02-3EEA-4EEE-A827-87C1A02A0FCC}"
    GetFontFamilyCount()
      => ComCall(3, this.p, UInt32)
    GetFontFamily(index, fontFamily)
      => ComCall(4, this.p, UInt32, index, IDWriteFontFamily.Ptr, fontFamily)
    FindFamilyName(familyName, index, exists)
      => ComCall(5, this.p, "Str", familyName, UInt32.Ptr, index, BOOL.Ptr, exists)
    GetFontFromFontFace(fontFace, font)
      => ComCall(6, this.p, IDWriteFontFace, fontFace, IDWriteFont.Ptr, font)
}
struct IDWriteFontList extends IUnknown {
    static IID := "{1A0D8438-1D97-4EC1-AEF9-A2FB86ED6ACB}"
    GetFontCollection(fontCollection)
      => ComCall(3, this.p, IDWriteFontCollection.Ptr, fontCollection)
    GetFontCount()
      => ComCall(4, this.p, UInt32)
    GetFont(index, font)
      => ComCall(5, this.p, UInt32, index, IDWriteFont.Ptr, font)
}
struct IDWriteFontFamily extends IDWriteFontList {
    static IID := "{DA20D8EF-812A-4C43-9802-62EC4ABD7ADD}"
    GetFamilyNames(names)
      => ComCall(6, this.p, IDWriteLocalizedStrings.Ptr, names)
    GetFirstMatchingFont(weight, stretch, style, matchingFont)
      => ComCall(7, this.p, DWRITE_FONT_WEIGHT, weight, DWRITE_FONT_STRETCH, stretch, DWRITE_FONT_STYLE, style, IDWriteFont.Ptr, matchingFont)
    GetMatchingFonts(weight, stretch, style, matchingFonts)
      => ComCall(8, this.p, DWRITE_FONT_WEIGHT, weight, DWRITE_FONT_STRETCH, stretch, DWRITE_FONT_STYLE, style, IDWriteFontList.Ptr, matchingFonts)
}
struct IDWriteFont extends IUnknown {
    static IID := "{ACD16696-8C14-4F5D-877E-FE3FC1D32737}"
    GetFontFamily(fontFamily)
      => ComCall(3, this.p, IDWriteFontFamily.Ptr, fontFamily)
    GetWeight()
      => ComCall(4, this.p, DWRITE_FONT_WEIGHT)
    GetStretch()
      => ComCall(5, this.p, DWRITE_FONT_STRETCH)
    GetStyle()
      => ComCall(6, this.p, DWRITE_FONT_STYLE)
    IsSymbolFont()
      => ComCall(7, this.p, BOOL)
    GetFaceNames(names)
      => ComCall(8, this.p, IDWriteLocalizedStrings.Ptr, names)
    GetInformationalStrings(informationalStringID, informationalStrings, exists)
      => ComCall(9, this.p, DWRITE_INFORMATIONAL_STRING_ID, informationalStringID, IDWriteLocalizedStrings.Ptr, informationalStrings, BOOL.Ptr, exists)
    GetSimulations()
      => ComCall(10, this.p, DWRITE_FONT_SIMULATIONS)
    GetMetrics(fontMetrics)
      => ComCall(11, this.p, DWRITE_FONT_METRICS.Ptr, fontMetrics, "void")
    HasCharacter(unicodeValue, exists)
      => ComCall(12, this.p, UInt32, unicodeValue, BOOL.Ptr, exists)
    CreateFontFace(fontFace)
      => ComCall(13, this.p, IDWriteFontFace.Ptr, fontFace)
}
struct DWRITE_READING_DIRECTION extends Int32 {
    static DWRITE_READING_DIRECTION_LEFT_TO_RIGHT := 0
    static DWRITE_READING_DIRECTION_RIGHT_TO_LEFT := 1
    static DWRITE_READING_DIRECTION_TOP_TO_BOTTOM := 2
    static DWRITE_READING_DIRECTION_BOTTOM_TO_TOP := 3
}
struct DWRITE_FLOW_DIRECTION extends Int32 {
    static DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM := 0
    static DWRITE_FLOW_DIRECTION_BOTTOM_TO_TOP := 1
    static DWRITE_FLOW_DIRECTION_LEFT_TO_RIGHT := 2
    static DWRITE_FLOW_DIRECTION_RIGHT_TO_LEFT := 3
}
struct DWRITE_TEXT_ALIGNMENT extends Int32 {
    static DWRITE_TEXT_ALIGNMENT_LEADING := 0
    static DWRITE_TEXT_ALIGNMENT_TRAILING := 1
    static DWRITE_TEXT_ALIGNMENT_CENTER := 2
    static DWRITE_TEXT_ALIGNMENT_JUSTIFIED := 3
}
struct DWRITE_PARAGRAPH_ALIGNMENT extends Int32 {
    static DWRITE_PARAGRAPH_ALIGNMENT_NEAR := 0
    static DWRITE_PARAGRAPH_ALIGNMENT_FAR := 1
    static DWRITE_PARAGRAPH_ALIGNMENT_CENTER := 2
}
struct DWRITE_WORD_WRAPPING extends Int32 {
    static DWRITE_WORD_WRAPPING_WRAP := 0
    static DWRITE_WORD_WRAPPING_NO_WRAP := 1
    static DWRITE_WORD_WRAPPING_EMERGENCY_BREAK := 2
    static DWRITE_WORD_WRAPPING_WHOLE_WORD := 3
    static DWRITE_WORD_WRAPPING_CHARACTER := 4
}
struct DWRITE_LINE_SPACING_METHOD extends Int32 {
    static DWRITE_LINE_SPACING_METHOD_DEFAULT := 0
    static DWRITE_LINE_SPACING_METHOD_UNIFORM := 1
    static DWRITE_LINE_SPACING_METHOD_PROPORTIONAL := 2
}
struct DWRITE_TRIMMING_GRANULARITY extends Int32 {
    static DWRITE_TRIMMING_GRANULARITY_NONE := 0
    static DWRITE_TRIMMING_GRANULARITY_CHARACTER := 1
    static DWRITE_TRIMMING_GRANULARITY_WORD := 2
}
struct DWRITE_FONT_FEATURE_TAG extends UInt32 {
    static DWRITE_FONT_FEATURE_TAG_ALTERNATIVE_FRACTIONS := 1668441697
    static DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS_FROM_CAPITALS := 1668297315
    static DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS_FROM_CAPITALS := 1668493923
    static DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_ALTERNATES := 1953259875
    static DWRITE_FONT_FEATURE_TAG_CASE_SENSITIVE_FORMS := 1702060387
    static DWRITE_FONT_FEATURE_TAG_GLYPH_COMPOSITION_DECOMPOSITION := 1886217059
    static DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_LIGATURES := 1734962275
    static DWRITE_FONT_FEATURE_TAG_CAPITAL_SPACING := 1886613603
    static DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_SWASH := 1752658787
    static DWRITE_FONT_FEATURE_TAG_CURSIVE_POSITIONING := 1936880995
    static DWRITE_FONT_FEATURE_TAG_DEFAULT := 1953261156
    static DWRITE_FONT_FEATURE_TAG_DISCRETIONARY_LIGATURES := 1734962276
    static DWRITE_FONT_FEATURE_TAG_EXPERT_FORMS := 1953527909
    static DWRITE_FONT_FEATURE_TAG_FRACTIONS := 1667330662
    static DWRITE_FONT_FEATURE_TAG_FULL_WIDTH := 1684633446
    static DWRITE_FONT_FEATURE_TAG_HALF_FORMS := 1718378856
    static DWRITE_FONT_FEATURE_TAG_HALANT_FORMS := 1852596584
    static DWRITE_FONT_FEATURE_TAG_ALTERNATE_HALF_WIDTH := 1953259880
    static DWRITE_FONT_FEATURE_TAG_HISTORICAL_FORMS := 1953720680
    static DWRITE_FONT_FEATURE_TAG_HORIZONTAL_KANA_ALTERNATES := 1634626408
    static DWRITE_FONT_FEATURE_TAG_HISTORICAL_LIGATURES := 1734962280
    static DWRITE_FONT_FEATURE_TAG_HALF_WIDTH := 1684633448
    static DWRITE_FONT_FEATURE_TAG_HOJO_KANJI_FORMS := 1869246312
    static DWRITE_FONT_FEATURE_TAG_JIS04_FORMS := 875589738
    static DWRITE_FONT_FEATURE_TAG_JIS78_FORMS := 943157354
    static DWRITE_FONT_FEATURE_TAG_JIS83_FORMS := 859336810
    static DWRITE_FONT_FEATURE_TAG_JIS90_FORMS := 809070698
    static DWRITE_FONT_FEATURE_TAG_KERNING := 1852990827
    static DWRITE_FONT_FEATURE_TAG_STANDARD_LIGATURES := 1634167148
    static DWRITE_FONT_FEATURE_TAG_LINING_FIGURES := 1836412524
    static DWRITE_FONT_FEATURE_TAG_LOCALIZED_FORMS := 1818455916
    static DWRITE_FONT_FEATURE_TAG_MARK_POSITIONING := 1802658157
    static DWRITE_FONT_FEATURE_TAG_MATHEMATICAL_GREEK := 1802659693
    static DWRITE_FONT_FEATURE_TAG_MARK_TO_MARK_POSITIONING := 1802333037
    static DWRITE_FONT_FEATURE_TAG_ALTERNATE_ANNOTATION_FORMS := 1953259886
    static DWRITE_FONT_FEATURE_TAG_NLC_KANJI_FORMS := 1801677934
    static DWRITE_FONT_FEATURE_TAG_OLD_STYLE_FIGURES := 1836412527
    static DWRITE_FONT_FEATURE_TAG_ORDINALS := 1852076655
    static DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_ALTERNATE_WIDTH := 1953259888
    static DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS := 1885430640
    static DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_FIGURES := 1836412528
    static DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_WIDTHS := 1684633456
    static DWRITE_FONT_FEATURE_TAG_QUARTER_WIDTHS := 1684633457
    static DWRITE_FONT_FEATURE_TAG_REQUIRED_LIGATURES := 1734962290
    static DWRITE_FONT_FEATURE_TAG_RUBY_NOTATION_FORMS := 2036495730
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_ALTERNATES := 1953259891
    static DWRITE_FONT_FEATURE_TAG_SCIENTIFIC_INFERIORS := 1718511987
    static DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS := 1885564275
    static DWRITE_FONT_FEATURE_TAG_SIMPLIFIED_FORMS := 1819307379
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1 := 825258867
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_2 := 842036083
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_3 := 858813299
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_4 := 875590515
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_5 := 892367731
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_6 := 909144947
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_7 := 925922163
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_8 := 942699379
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_9 := 959476595
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_10 := 808547187
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_11 := 825324403
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_12 := 842101619
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_13 := 858878835
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_14 := 875656051
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_15 := 892433267
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_16 := 909210483
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_17 := 925987699
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_18 := 942764915
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_19 := 959542131
    static DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_20 := 808612723
    static DWRITE_FONT_FEATURE_TAG_SUBSCRIPT := 1935832435
    static DWRITE_FONT_FEATURE_TAG_SUPERSCRIPT := 1936749939
    static DWRITE_FONT_FEATURE_TAG_SWASH := 1752397683
    static DWRITE_FONT_FEATURE_TAG_TITLING := 1819568500
    static DWRITE_FONT_FEATURE_TAG_TRADITIONAL_NAME_FORMS := 1835101812
    static DWRITE_FONT_FEATURE_TAG_TABULAR_FIGURES := 1836412532
    static DWRITE_FONT_FEATURE_TAG_TRADITIONAL_FORMS := 1684107892
    static DWRITE_FONT_FEATURE_TAG_THIRD_WIDTHS := 1684633460
    static DWRITE_FONT_FEATURE_TAG_UNICASE := 1667853941
    static DWRITE_FONT_FEATURE_TAG_VERTICAL_WRITING := 1953654134
    static DWRITE_FONT_FEATURE_TAG_VERTICAL_ALTERNATES_AND_ROTATION := 846492278
    static DWRITE_FONT_FEATURE_TAG_SLASHED_ZERO := 1869768058
}
struct DWRITE_TEXT_RANGE {
    startPosition : UInt32
    length : UInt32
}
struct DWRITE_FONT_FEATURE {
    nameTag : DWRITE_FONT_FEATURE_TAG
    parameter : UInt32
}
struct DWRITE_TYPOGRAPHIC_FEATURES {
    features : DWRITE_FONT_FEATURE.Ptr
    featureCount : UInt32
}
struct DWRITE_TRIMMING {
    granularity : DWRITE_TRIMMING_GRANULARITY
    delimiter : UInt32
    delimiterCount : UInt32
}
struct IDWriteTextFormat extends IUnknown {
    static IID := "{9C906818-31D7-4FD3-A151-7C5E225DB55A}"
    SetTextAlignment(textAlignment)
      => ComCall(3, this.p, DWRITE_TEXT_ALIGNMENT, textAlignment)
    SetParagraphAlignment(paragraphAlignment)
      => ComCall(4, this.p, DWRITE_PARAGRAPH_ALIGNMENT, paragraphAlignment)
    SetWordWrapping(wordWrapping)
      => ComCall(5, this.p, DWRITE_WORD_WRAPPING, wordWrapping)
    SetReadingDirection(readingDirection)
      => ComCall(6, this.p, DWRITE_READING_DIRECTION, readingDirection)
    SetFlowDirection(flowDirection)
      => ComCall(7, this.p, DWRITE_FLOW_DIRECTION, flowDirection)
    SetIncrementalTabStop(incrementalTabStop)
      => ComCall(8, this.p, Float32, incrementalTabStop)
    SetTrimming(trimmingOptions, trimmingSign?)
      => ComCall(9, this.p, DWRITE_TRIMMING.Ptr, trimmingOptions, IDWriteInlineObject, trimmingSign?)
    SetLineSpacing(lineSpacingMethod, lineSpacing, baseline)
      => ComCall(10, this.p, DWRITE_LINE_SPACING_METHOD, lineSpacingMethod, Float32, lineSpacing, Float32, baseline)
    GetTextAlignment()
      => ComCall(11, this.p, DWRITE_TEXT_ALIGNMENT)
    GetParagraphAlignment()
      => ComCall(12, this.p, DWRITE_PARAGRAPH_ALIGNMENT)
    GetWordWrapping()
      => ComCall(13, this.p, DWRITE_WORD_WRAPPING)
    GetReadingDirection()
      => ComCall(14, this.p, DWRITE_READING_DIRECTION)
    GetFlowDirection()
      => ComCall(15, this.p, DWRITE_FLOW_DIRECTION)
    GetIncrementalTabStop()
      => ComCall(16, this.p, Float32)
    GetTrimming(trimmingOptions, trimmingSign)
      => ComCall(17, this.p, DWRITE_TRIMMING.Ptr, trimmingOptions, IDWriteInlineObject.Ptr, trimmingSign)
    GetLineSpacing(lineSpacingMethod, lineSpacing, baseline)
      => ComCall(18, this.p, DWRITE_LINE_SPACING_METHOD.Ptr, lineSpacingMethod, Float32.Ptr, lineSpacing, Float32.Ptr, baseline)
    GetFontCollection(fontCollection)
      => ComCall(19, this.p, IDWriteFontCollection.Ptr, fontCollection)
    GetFontFamilyNameLength()
      => ComCall(20, this.p, UInt32)
    GetFontFamilyName(fontFamilyName)
      => ComCall(21, this.p, PWSTR, fontFamilyName, UInt32, fontFamilyName.Length)
    GetFontWeight()
      => ComCall(22, this.p, DWRITE_FONT_WEIGHT)
    GetFontStyle()
      => ComCall(23, this.p, DWRITE_FONT_STYLE)
    GetFontStretch()
      => ComCall(24, this.p, DWRITE_FONT_STRETCH)
    GetFontSize()
      => ComCall(25, this.p, Float32)
    GetLocaleNameLength()
      => ComCall(26, this.p, UInt32)
    GetLocaleName(localeName)
      => ComCall(27, this.p, PWSTR, localeName, UInt32, localeName.Length)
}
struct IDWriteTypography extends IUnknown {
    static IID := "{55F1112B-1DC2-4B3C-9541-F46894ED85B6}"
    AddFontFeature(fontFeature)
      => ComCall(3, this.p, DWRITE_FONT_FEATURE, fontFeature)
    GetFontFeatureCount()
      => ComCall(4, this.p, UInt32)
    GetFontFeature(fontFeatureIndex, fontFeature)
      => ComCall(5, this.p, UInt32, fontFeatureIndex, DWRITE_FONT_FEATURE.Ptr, fontFeature)
}
struct DWRITE_SCRIPT_SHAPES extends Int32 {
    static DWRITE_SCRIPT_SHAPES_DEFAULT := 0
    static DWRITE_SCRIPT_SHAPES_NO_VISUAL := 1
}
struct DWRITE_SCRIPT_ANALYSIS {
    script : UInt16
    shapes : DWRITE_SCRIPT_SHAPES
}
struct DWRITE_BREAK_CONDITION extends Int32 {
    static DWRITE_BREAK_CONDITION_NEUTRAL := 0
    static DWRITE_BREAK_CONDITION_CAN_BREAK := 1
    static DWRITE_BREAK_CONDITION_MAY_NOT_BREAK := 2
    static DWRITE_BREAK_CONDITION_MUST_BREAK := 3
}
struct DWRITE_LINE_BREAKPOINT {
    _bitfield : UInt8
}
struct DWRITE_NUMBER_SUBSTITUTION_METHOD extends Int32 {
    static DWRITE_NUMBER_SUBSTITUTION_METHOD_FROM_CULTURE := 0
    static DWRITE_NUMBER_SUBSTITUTION_METHOD_CONTEXTUAL := 1
    static DWRITE_NUMBER_SUBSTITUTION_METHOD_NONE := 2
    static DWRITE_NUMBER_SUBSTITUTION_METHOD_NATIONAL := 3
    static DWRITE_NUMBER_SUBSTITUTION_METHOD_TRADITIONAL := 4
}
struct IDWriteNumberSubstitution extends IUnknown {
    static IID := "{14885CC9-BAB0-4F90-B6ED-5C366A2CD03D}"
}
struct DWRITE_SHAPING_TEXT_PROPERTIES {
    _bitfield : UInt16
}
struct DWRITE_SHAPING_GLYPH_PROPERTIES {
    _bitfield : UInt16
}
struct IDWriteTextAnalysisSource extends IUnknown {
    static IID := "{688E1A58-5094-47C8-ADC8-FBCEA60AE92B}"
    GetTextAtPosition(textPosition, textString, textLength)
      => ComCall(3, this.p, UInt32, textPosition, UInt16.Ptr.Ptr, textString, UInt32.Ptr, textLength)
    GetTextBeforePosition(textPosition, textString, textLength)
      => ComCall(4, this.p, UInt32, textPosition, UInt16.Ptr.Ptr, textString, UInt32.Ptr, textLength)
    GetParagraphReadingDirection()
      => ComCall(5, this.p, DWRITE_READING_DIRECTION)
    GetLocaleName(textPosition, textLength, localeName)
      => ComCall(6, this.p, UInt32, textPosition, UInt32.Ptr, textLength, UInt16.Ptr.Ptr, localeName)
    GetNumberSubstitution(textPosition, textLength, numberSubstitution)
      => ComCall(7, this.p, UInt32, textPosition, UInt32.Ptr, textLength, IDWriteNumberSubstitution.Ptr, numberSubstitution)
}
struct IDWriteTextAnalysisSink extends IUnknown {
    static IID := "{5810CD44-0CA0-4701-B3FA-BEC5182AE4F6}"
    SetScriptAnalysis(textPosition, textLength, scriptAnalysis)
      => ComCall(3, this.p, UInt32, textPosition, UInt32, textLength, DWRITE_SCRIPT_ANALYSIS.Ptr, scriptAnalysis)
    SetLineBreakpoints(textPosition, lineBreakpoints)
      => ComCall(4, this.p, UInt32, textPosition, UInt32, lineBreakpoints.Length, DWRITE_LINE_BREAKPOINT.Ptr, lineBreakpoints)
    SetBidiLevel(textPosition, textLength, explicitLevel, resolvedLevel)
      => ComCall(5, this.p, UInt32, textPosition, UInt32, textLength, UInt8, explicitLevel, UInt8, resolvedLevel)
    SetNumberSubstitution(textPosition, textLength, numberSubstitution)
      => ComCall(6, this.p, UInt32, textPosition, UInt32, textLength, IDWriteNumberSubstitution, numberSubstitution)
}
struct IDWriteTextAnalyzer extends IUnknown {
    static IID := "{B7E6163E-7F46-43B4-84B3-E4E6249C365D}"
    AnalyzeScript(analysisSource, textPosition, textLength, analysisSink)
      => ComCall(3, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteTextAnalysisSink, analysisSink)
    AnalyzeBidi(analysisSource, textPosition, textLength, analysisSink)
      => ComCall(4, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteTextAnalysisSink, analysisSink)
    AnalyzeNumberSubstitution(analysisSource, textPosition, textLength, analysisSink)
      => ComCall(5, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteTextAnalysisSink, analysisSink)
    AnalyzeLineBreakpoints(analysisSource, textPosition, textLength, analysisSink)
      => ComCall(6, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteTextAnalysisSink, analysisSink)
    GetGlyphs(textString, fontFace, isSideways, isRightToLeft, scriptAnalysis, localeName?, numberSubstitution?, features?, featureRangeLengths?, clusterMap, textProps, glyphIndices, glyphProps, actualGlyphCount)
      => ComCall(7, this.p, "Str", textString, UInt32, textProps.Length, IDWriteFontFace, fontFace, BOOL, isSideways, BOOL, isRightToLeft, DWRITE_SCRIPT_ANALYSIS.Ptr, scriptAnalysis, "Str", localeName?, IDWriteNumberSubstitution, numberSubstitution?, DWRITE_TYPOGRAPHIC_FEATURES.Ptr.Ptr, features?, UInt32.Ptr, featureRangeLengths?, UInt32, featureRangeLengths?.Length ?? 0, UInt32, glyphProps.Length, UInt16.Ptr, clusterMap, DWRITE_SHAPING_TEXT_PROPERTIES.Ptr, textProps, UInt16.Ptr, glyphIndices, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProps, UInt32.Ptr, actualGlyphCount)
    GetGlyphPlacements(textString, clusterMap, textProps, glyphIndices, glyphProps, fontFace, fontEmSize, isSideways, isRightToLeft, scriptAnalysis, localeName?, features?, featureRangeLengths?, glyphAdvances, glyphOffsets)
      => ComCall(8, this.p, "Str", textString, UInt16.Ptr, clusterMap, DWRITE_SHAPING_TEXT_PROPERTIES.Ptr, textProps, UInt32, textProps.Length, UInt16.Ptr, glyphIndices, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProps, UInt32, glyphOffsets.Length, IDWriteFontFace, fontFace, Float32, fontEmSize, BOOL, isSideways, BOOL, isRightToLeft, DWRITE_SCRIPT_ANALYSIS.Ptr, scriptAnalysis, "Str", localeName?, DWRITE_TYPOGRAPHIC_FEATURES.Ptr.Ptr, features?, UInt32.Ptr, featureRangeLengths?, UInt32, featureRangeLengths?.Length ?? 0, Float32.Ptr, glyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, glyphOffsets)
    GetGdiCompatibleGlyphPlacements(textString, clusterMap, textProps, glyphIndices, glyphProps, fontFace, fontEmSize, pixelsPerDip, transform?, useGdiNatural, isSideways, isRightToLeft, scriptAnalysis, localeName?, features?, featureRangeLengths?, glyphAdvances, glyphOffsets)
      => ComCall(9, this.p, "Str", textString, UInt16.Ptr, clusterMap, DWRITE_SHAPING_TEXT_PROPERTIES.Ptr, textProps, UInt32, textProps.Length, UInt16.Ptr, glyphIndices, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProps, UInt32, glyphOffsets.Length, IDWriteFontFace, fontFace, Float32, fontEmSize, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, BOOL, useGdiNatural, BOOL, isSideways, BOOL, isRightToLeft, DWRITE_SCRIPT_ANALYSIS.Ptr, scriptAnalysis, "Str", localeName?, DWRITE_TYPOGRAPHIC_FEATURES.Ptr.Ptr, features?, UInt32.Ptr, featureRangeLengths?, UInt32, featureRangeLengths?.Length ?? 0, Float32.Ptr, glyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, glyphOffsets)
}
struct DWRITE_GLYPH_RUN {
    fontFace : IDWriteFontFace
    fontEmSize : Float32
    glyphCount : UInt32
    glyphIndices : UInt16.Ptr
    glyphAdvances : Float32.Ptr
    glyphOffsets : DWRITE_GLYPH_OFFSET.Ptr
    isSideways : BOOL
    bidiLevel : UInt32
}
struct DWRITE_GLYPH_RUN_DESCRIPTION {
    localeName : PWSTR
    string : PWSTR
    stringLength : UInt32
    clusterMap : UInt16.Ptr
    textPosition : UInt32
}
struct DWRITE_UNDERLINE {
    width : Float32
    thickness : Float32
    offset : Float32
    runHeight : Float32
    readingDirection : DWRITE_READING_DIRECTION
    flowDirection : DWRITE_FLOW_DIRECTION
    localeName : PWSTR
    measuringMode : DWRITE_MEASURING_MODE
}
struct DWRITE_STRIKETHROUGH {
    width : Float32
    thickness : Float32
    offset : Float32
    readingDirection : DWRITE_READING_DIRECTION
    flowDirection : DWRITE_FLOW_DIRECTION
    localeName : PWSTR
    measuringMode : DWRITE_MEASURING_MODE
}
struct DWRITE_LINE_METRICS {
    length : UInt32
    trailingWhitespaceLength : UInt32
    newlineLength : UInt32
    height : Float32
    baseline : Float32
    isTrimmed : BOOL
}
struct DWRITE_CLUSTER_METRICS {
    width : Float32
    length : UInt16
    _bitfield : UInt16
}
struct DWRITE_TEXT_METRICS {
    left : Float32
    top : Float32
    width : Float32
    widthIncludingTrailingWhitespace : Float32
    height : Float32
    layoutWidth : Float32
    layoutHeight : Float32
    maxBidiReorderingDepth : UInt32
    lineCount : UInt32
}
struct DWRITE_INLINE_OBJECT_METRICS {
    width : Float32
    height : Float32
    baseline : Float32
    supportsSideways : BOOL
}
struct DWRITE_OVERHANG_METRICS {
    left : Float32
    top : Float32
    right : Float32
    bottom : Float32
}
struct DWRITE_HIT_TEST_METRICS {
    textPosition : UInt32
    length : UInt32
    left : Float32
    top : Float32
    width : Float32
    height : Float32
    bidiLevel : UInt32
    isText : BOOL
    isTrimmed : BOOL
}
struct IDWriteInlineObject extends IUnknown {
    static IID := "{8339FDE3-106F-47AB-8373-1C6295EB10B3}"
    Draw(clientDrawingContext?, renderer, originX, originY, isSideways, isRightToLeft, clientDrawingEffect?)
      => ComCall(3, this.p, Struct.Ptr, clientDrawingContext?, IDWriteTextRenderer, renderer, Float32, originX, Float32, originY, BOOL, isSideways, BOOL, isRightToLeft, IUnknown, clientDrawingEffect?)
    GetMetrics(metrics)
      => ComCall(4, this.p, DWRITE_INLINE_OBJECT_METRICS.Ptr, metrics)
    GetOverhangMetrics(overhangs)
      => ComCall(5, this.p, DWRITE_OVERHANG_METRICS.Ptr, overhangs)
    GetBreakConditions(breakConditionBefore, breakConditionAfter)
      => ComCall(6, this.p, DWRITE_BREAK_CONDITION.Ptr, breakConditionBefore, DWRITE_BREAK_CONDITION.Ptr, breakConditionAfter)
}
struct IDWritePixelSnapping extends IUnknown {
    static IID := "{EAF3A2DA-ECF4-4D24-B644-B34F6842024B}"
    IsPixelSnappingDisabled(clientDrawingContext?, isDisabled)
      => ComCall(3, this.p, Struct.Ptr, clientDrawingContext?, BOOL.Ptr, isDisabled)
    GetCurrentTransform(clientDrawingContext?, transform)
      => ComCall(4, this.p, Struct.Ptr, clientDrawingContext?, DWRITE_MATRIX.Ptr, transform)
    GetPixelsPerDip(clientDrawingContext?, pixelsPerDip)
      => ComCall(5, this.p, Struct.Ptr, clientDrawingContext?, Float32.Ptr, pixelsPerDip)
}
struct IDWriteTextRenderer extends IDWritePixelSnapping {
    static IID := "{EF8A8135-5CC6-45FE-8825-C5A0724EB819}"
    DrawGlyphRun(clientDrawingContext?, baselineOriginX, baselineOriginY, measuringMode, glyphRun, glyphRunDescription, clientDrawingEffect?)
      => ComCall(6, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription, IUnknown, clientDrawingEffect?)
    DrawUnderline(clientDrawingContext?, baselineOriginX, baselineOriginY, underline, clientDrawingEffect?)
      => ComCall(7, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_UNDERLINE.Ptr, underline, IUnknown, clientDrawingEffect?)
    DrawStrikethrough(clientDrawingContext?, baselineOriginX, baselineOriginY, strikethrough, clientDrawingEffect?)
      => ComCall(8, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_STRIKETHROUGH.Ptr, strikethrough, IUnknown, clientDrawingEffect?)
    DrawInlineObject(clientDrawingContext?, originX, originY, inlineObject, isSideways, isRightToLeft, clientDrawingEffect?)
      => ComCall(9, this.p, Struct.Ptr, clientDrawingContext?, Float32, originX, Float32, originY, IDWriteInlineObject, inlineObject, BOOL, isSideways, BOOL, isRightToLeft, IUnknown, clientDrawingEffect?)
}
struct IDWriteTextLayout extends IDWriteTextFormat {
    static IID := "{53737037-6D14-410B-9BFE-0B182BB70961}"
    SetMaxWidth(maxWidth)
      => ComCall(28, this.p, Float32, maxWidth)
    SetMaxHeight(maxHeight)
      => ComCall(29, this.p, Float32, maxHeight)
    SetFontCollection(fontCollection, textRange)
      => ComCall(30, this.p, IDWriteFontCollection, fontCollection, DWRITE_TEXT_RANGE, textRange)
    SetFontFamilyName(fontFamilyName, textRange)
      => ComCall(31, this.p, "Str", fontFamilyName, DWRITE_TEXT_RANGE, textRange)
    SetFontWeight(fontWeight, textRange)
      => ComCall(32, this.p, DWRITE_FONT_WEIGHT, fontWeight, DWRITE_TEXT_RANGE, textRange)
    SetFontStyle(fontStyle, textRange)
      => ComCall(33, this.p, DWRITE_FONT_STYLE, fontStyle, DWRITE_TEXT_RANGE, textRange)
    SetFontStretch(fontStretch, textRange)
      => ComCall(34, this.p, DWRITE_FONT_STRETCH, fontStretch, DWRITE_TEXT_RANGE, textRange)
    SetFontSize(fontSize, textRange)
      => ComCall(35, this.p, Float32, fontSize, DWRITE_TEXT_RANGE, textRange)
    SetUnderline(hasUnderline, textRange)
      => ComCall(36, this.p, BOOL, hasUnderline, DWRITE_TEXT_RANGE, textRange)
    SetStrikethrough(hasStrikethrough, textRange)
      => ComCall(37, this.p, BOOL, hasStrikethrough, DWRITE_TEXT_RANGE, textRange)
    SetDrawingEffect(drawingEffect, textRange)
      => ComCall(38, this.p, IUnknown, drawingEffect, DWRITE_TEXT_RANGE, textRange)
    SetInlineObject(inlineObject, textRange)
      => ComCall(39, this.p, IDWriteInlineObject, inlineObject, DWRITE_TEXT_RANGE, textRange)
    SetTypography(typography, textRange)
      => ComCall(40, this.p, IDWriteTypography, typography, DWRITE_TEXT_RANGE, textRange)
    SetLocaleName(localeName, textRange)
      => ComCall(41, this.p, "Str", localeName, DWRITE_TEXT_RANGE, textRange)
    GetMaxWidth()
      => ComCall(42, this.p, Float32)
    GetMaxHeight()
      => ComCall(43, this.p, Float32)
    GetFontCollection(currentPosition, fontCollection, textRange?)
      => ComCall(44, this.p, UInt32, currentPosition, IDWriteFontCollection.Ptr, fontCollection, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontFamilyNameLength(currentPosition, nameLength, textRange?)
      => ComCall(45, this.p, UInt32, currentPosition, UInt32.Ptr, nameLength, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontFamilyName(currentPosition, fontFamilyName, textRange?)
      => ComCall(46, this.p, UInt32, currentPosition, PWSTR, fontFamilyName, UInt32, fontFamilyName.Length, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontWeight(currentPosition, fontWeight, textRange?)
      => ComCall(47, this.p, UInt32, currentPosition, DWRITE_FONT_WEIGHT.Ptr, fontWeight, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontStyle(currentPosition, fontStyle, textRange?)
      => ComCall(48, this.p, UInt32, currentPosition, DWRITE_FONT_STYLE.Ptr, fontStyle, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontStretch(currentPosition, fontStretch, textRange?)
      => ComCall(49, this.p, UInt32, currentPosition, DWRITE_FONT_STRETCH.Ptr, fontStretch, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetFontSize(currentPosition, fontSize, textRange?)
      => ComCall(50, this.p, UInt32, currentPosition, Float32.Ptr, fontSize, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetUnderline(currentPosition, hasUnderline, textRange?)
      => ComCall(51, this.p, UInt32, currentPosition, BOOL.Ptr, hasUnderline, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetStrikethrough(currentPosition, hasStrikethrough, textRange?)
      => ComCall(52, this.p, UInt32, currentPosition, BOOL.Ptr, hasStrikethrough, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetDrawingEffect(currentPosition, drawingEffect, textRange?)
      => ComCall(53, this.p, UInt32, currentPosition, IUnknown.Ptr, drawingEffect, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetInlineObject(currentPosition, inlineObject, textRange?)
      => ComCall(54, this.p, UInt32, currentPosition, IDWriteInlineObject.Ptr, inlineObject, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetTypography(currentPosition, typography, textRange?)
      => ComCall(55, this.p, UInt32, currentPosition, IDWriteTypography.Ptr, typography, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetLocaleNameLength(currentPosition, nameLength, textRange?)
      => ComCall(56, this.p, UInt32, currentPosition, UInt32.Ptr, nameLength, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetLocaleName(currentPosition, localeName, textRange?)
      => ComCall(57, this.p, UInt32, currentPosition, PWSTR, localeName, UInt32, localeName.Length, DWRITE_TEXT_RANGE.Ptr, textRange?)
    Draw(clientDrawingContext?, renderer, originX, originY)
      => ComCall(58, this.p, Struct.Ptr, clientDrawingContext?, IDWriteTextRenderer, renderer, Float32, originX, Float32, originY)
    GetLineMetrics(lineMetrics?, actualLineCount)
      => ComCall(59, this.p, DWRITE_LINE_METRICS.Ptr, lineMetrics?, UInt32, lineMetrics?.Length ?? 0, UInt32.Ptr, actualLineCount)
    GetMetrics(textMetrics)
      => ComCall(60, this.p, DWRITE_TEXT_METRICS.Ptr, textMetrics)
    GetOverhangMetrics(overhangs)
      => ComCall(61, this.p, DWRITE_OVERHANG_METRICS.Ptr, overhangs)
    GetClusterMetrics(clusterMetrics?, actualClusterCount)
      => ComCall(62, this.p, DWRITE_CLUSTER_METRICS.Ptr, clusterMetrics?, UInt32, clusterMetrics?.Length ?? 0, UInt32.Ptr, actualClusterCount)
    DetermineMinWidth(minWidth)
      => ComCall(63, this.p, Float32.Ptr, minWidth)
    HitTestPoint(pointX, pointY, isTrailingHit, isInside, hitTestMetrics)
      => ComCall(64, this.p, Float32, pointX, Float32, pointY, BOOL.Ptr, isTrailingHit, BOOL.Ptr, isInside, DWRITE_HIT_TEST_METRICS.Ptr, hitTestMetrics)
    HitTestTextPosition(textPosition, isTrailingHit, pointX, pointY, hitTestMetrics)
      => ComCall(65, this.p, UInt32, textPosition, BOOL, isTrailingHit, Float32.Ptr, pointX, Float32.Ptr, pointY, DWRITE_HIT_TEST_METRICS.Ptr, hitTestMetrics)
    HitTestTextRange(textPosition, textLength, originX, originY, hitTestMetrics?, actualHitTestMetricsCount)
      => ComCall(66, this.p, UInt32, textPosition, UInt32, textLength, Float32, originX, Float32, originY, DWRITE_HIT_TEST_METRICS.Ptr, hitTestMetrics?, UInt32, hitTestMetrics?.Length ?? 0, UInt32.Ptr, actualHitTestMetricsCount)
}
struct IDWriteBitmapRenderTarget extends IUnknown {
    static IID := "{5E5A32A3-8DFF-4773-9FF6-0696EAB77267}"
    DrawGlyphRun(baselineOriginX, baselineOriginY, measuringMode, glyphRun, renderingParams, textColor, blackBoxRect?)
      => ComCall(3, this.p, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GLYPH_RUN.Ptr, glyphRun, IDWriteRenderingParams, renderingParams, COLORREF, textColor, RECT.Ptr, blackBoxRect?)
    GetMemoryDC()
      => ComCall(4, this.p, HDC)
    GetPixelsPerDip()
      => ComCall(5, this.p, Float32)
    SetPixelsPerDip(pixelsPerDip)
      => ComCall(6, this.p, Float32, pixelsPerDip)
    GetCurrentTransform(transform)
      => ComCall(7, this.p, DWRITE_MATRIX.Ptr, transform)
    SetCurrentTransform(transform?)
      => ComCall(8, this.p, DWRITE_MATRIX.Ptr, transform?)
    GetSize(size)
      => ComCall(9, this.p, SIZE.Ptr, size)
    Resize(width, height)
      => ComCall(10, this.p, UInt32, width, UInt32, height)
}
struct IDWriteGdiInterop extends IUnknown {
    static IID := "{1EDD9491-9853-4299-898F-6432983B6F3A}"
    CreateFontFromLOGFONT(logFont, font)
      => ComCall(3, this.p, LOGFONTW.Ptr, logFont, IDWriteFont.Ptr, font)
    ConvertFontToLOGFONT(font, logFont, isSystemFont)
      => ComCall(4, this.p, IDWriteFont, font, LOGFONTW.Ptr, logFont, BOOL.Ptr, isSystemFont)
    ConvertFontFaceToLOGFONT(font, logFont)
      => ComCall(5, this.p, IDWriteFontFace, font, LOGFONTW.Ptr, logFont)
    CreateFontFaceFromHdc(hdc1, fontFace)
      => ComCall(6, this.p, HDC, hdc1, IDWriteFontFace.Ptr, fontFace)
    CreateBitmapRenderTarget(hdc1?, width, height, renderTarget)
      => ComCall(7, this.p, HDC, hdc1?, UInt32, width, UInt32, height, IDWriteBitmapRenderTarget.Ptr, renderTarget)
}
struct DWRITE_TEXTURE_TYPE extends Int32 {
    static DWRITE_TEXTURE_ALIASED_1x1 := 0
    static DWRITE_TEXTURE_CLEARTYPE_3x1 := 1
}
struct IDWriteGlyphRunAnalysis extends IUnknown {
    static IID := "{7D97DBF7-E085-42D4-81E3-6A883BDED118}"
    GetAlphaTextureBounds(textureType, textureBounds)
      => ComCall(3, this.p, DWRITE_TEXTURE_TYPE, textureType, RECT.Ptr, textureBounds)
    CreateAlphaTexture(textureType, textureBounds, alphaValues)
      => ComCall(4, this.p, DWRITE_TEXTURE_TYPE, textureType, RECT.Ptr, textureBounds, UInt8.Ptr, alphaValues, UInt32, alphaValues.Size)
    GetAlphaBlendParams(renderingParams, blendGamma, blendEnhancedContrast, blendClearTypeLevel)
      => ComCall(5, this.p, IDWriteRenderingParams, renderingParams, Float32.Ptr, blendGamma, Float32.Ptr, blendEnhancedContrast, Float32.Ptr, blendClearTypeLevel)
}
struct IDWriteFactory extends IUnknown {
    static IID := "{B859EE5A-D838-4B5B-A2E8-1ADC7D93DB48}"
    GetSystemFontCollection(fontCollection, checkForUpdates)
      => ComCall(3, this.p, IDWriteFontCollection.Ptr, fontCollection, BOOL, checkForUpdates)
    CreateCustomFontCollection(collectionLoader, collectionKey, fontCollection)
      => ComCall(4, this.p, IDWriteFontCollectionLoader, collectionLoader, Struct.Ptr, collectionKey, UInt32, collectionKey.Size, IDWriteFontCollection.Ptr, fontCollection)
    RegisterFontCollectionLoader(fontCollectionLoader)
      => ComCall(5, this.p, IDWriteFontCollectionLoader, fontCollectionLoader)
    UnregisterFontCollectionLoader(fontCollectionLoader)
      => ComCall(6, this.p, IDWriteFontCollectionLoader, fontCollectionLoader)
    CreateFontFileReference(filePath, lastWriteTime?, fontFile)
      => ComCall(7, this.p, "Str", filePath, FILETIME.Ptr, lastWriteTime?, IDWriteFontFile.Ptr, fontFile)
    CreateCustomFontFileReference(fontFileReferenceKey, fontFileLoader, fontFile)
      => ComCall(8, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, IDWriteFontFileLoader, fontFileLoader, IDWriteFontFile.Ptr, fontFile)
    CreateFontFace(fontFaceType, fontFiles, faceIndex, fontFaceSimulationFlags, fontFace)
      => ComCall(9, this.p, DWRITE_FONT_FACE_TYPE, fontFaceType, UInt32, fontFiles.Length, IDWriteFontFile.Ptr, fontFiles, UInt32, faceIndex, DWRITE_FONT_SIMULATIONS, fontFaceSimulationFlags, IDWriteFontFace.Ptr, fontFace)
    CreateRenderingParams(renderingParams)
      => ComCall(10, this.p, IDWriteRenderingParams.Ptr, renderingParams)
    CreateMonitorRenderingParams(monitor, renderingParams)
      => ComCall(11, this.p, HMONITOR, monitor, IDWriteRenderingParams.Ptr, renderingParams)
    CreateCustomRenderingParams(gamma, enhancedContrast, clearTypeLevel, pixelGeometry, renderingMode, renderingParams)
      => ComCall(12, this.p, Float32, gamma, Float32, enhancedContrast, Float32, clearTypeLevel, DWRITE_PIXEL_GEOMETRY, pixelGeometry, DWRITE_RENDERING_MODE, renderingMode, IDWriteRenderingParams.Ptr, renderingParams)
    RegisterFontFileLoader(fontFileLoader)
      => ComCall(13, this.p, IDWriteFontFileLoader, fontFileLoader)
    UnregisterFontFileLoader(fontFileLoader)
      => ComCall(14, this.p, IDWriteFontFileLoader, fontFileLoader)
    CreateTextFormat(fontFamilyName, fontCollection?, fontWeight, fontStyle, fontStretch, fontSize, localeName, textFormat)
      => ComCall(15, this.p, "Str", fontFamilyName, IDWriteFontCollection, fontCollection?, DWRITE_FONT_WEIGHT, fontWeight, DWRITE_FONT_STYLE, fontStyle, DWRITE_FONT_STRETCH, fontStretch, Float32, fontSize, "Str", localeName, IDWriteTextFormat.Ptr, textFormat)
    CreateTypography(typography)
      => ComCall(16, this.p, IDWriteTypography.Ptr, typography)
    GetGdiInterop(gdiInterop)
      => ComCall(17, this.p, IDWriteGdiInterop.Ptr, gdiInterop)
    CreateTextLayout(string, textFormat, maxWidth, maxHeight, textLayout)
      => ComCall(18, this.p, "Str", string, UInt32, string.Length, IDWriteTextFormat, textFormat, Float32, maxWidth, Float32, maxHeight, IDWriteTextLayout.Ptr, textLayout)
    CreateGdiCompatibleTextLayout(string, textFormat, layoutWidth, layoutHeight, pixelsPerDip, transform?, useGdiNatural, textLayout)
      => ComCall(19, this.p, "Str", string, UInt32, string.Length, IDWriteTextFormat, textFormat, Float32, layoutWidth, Float32, layoutHeight, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, BOOL, useGdiNatural, IDWriteTextLayout.Ptr, textLayout)
    CreateEllipsisTrimmingSign(textFormat, trimmingSign)
      => ComCall(20, this.p, IDWriteTextFormat, textFormat, IDWriteInlineObject.Ptr, trimmingSign)
    CreateTextAnalyzer(textAnalyzer)
      => ComCall(21, this.p, IDWriteTextAnalyzer.Ptr, textAnalyzer)
    CreateNumberSubstitution(substitutionMethod, localeName, ignoreUserOverride, numberSubstitution)
      => ComCall(22, this.p, DWRITE_NUMBER_SUBSTITUTION_METHOD, substitutionMethod, "Str", localeName, BOOL, ignoreUserOverride, IDWriteNumberSubstitution.Ptr, numberSubstitution)
    CreateGlyphRunAnalysis(glyphRun, pixelsPerDip, transform?, renderingMode, measuringMode, baselineOriginX, baselineOriginY, glyphRunAnalysis)
      => ComCall(23, this.p, DWRITE_GLYPH_RUN.Ptr, glyphRun, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, DWRITE_RENDERING_MODE, renderingMode, DWRITE_MEASURING_MODE, measuringMode, Float32, baselineOriginX, Float32, baselineOriginY, IDWriteGlyphRunAnalysis.Ptr, glyphRunAnalysis)
}
struct DWRITE_PANOSE_FAMILY extends Int32 {
    static DWRITE_PANOSE_FAMILY_ANY := 0
    static DWRITE_PANOSE_FAMILY_NO_FIT := 1
    static DWRITE_PANOSE_FAMILY_TEXT_DISPLAY := 2
    static DWRITE_PANOSE_FAMILY_SCRIPT := 3
    static DWRITE_PANOSE_FAMILY_DECORATIVE := 4
    static DWRITE_PANOSE_FAMILY_SYMBOL := 5
    static DWRITE_PANOSE_FAMILY_PICTORIAL := 5
}
struct DWRITE_PANOSE_SERIF_STYLE extends Int32 {
    static DWRITE_PANOSE_SERIF_STYLE_ANY := 0
    static DWRITE_PANOSE_SERIF_STYLE_NO_FIT := 1
    static DWRITE_PANOSE_SERIF_STYLE_COVE := 2
    static DWRITE_PANOSE_SERIF_STYLE_OBTUSE_COVE := 3
    static DWRITE_PANOSE_SERIF_STYLE_SQUARE_COVE := 4
    static DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SQUARE_COVE := 5
    static DWRITE_PANOSE_SERIF_STYLE_SQUARE := 6
    static DWRITE_PANOSE_SERIF_STYLE_THIN := 7
    static DWRITE_PANOSE_SERIF_STYLE_OVAL := 8
    static DWRITE_PANOSE_SERIF_STYLE_EXAGGERATED := 9
    static DWRITE_PANOSE_SERIF_STYLE_TRIANGLE := 10
    static DWRITE_PANOSE_SERIF_STYLE_NORMAL_SANS := 11
    static DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SANS := 12
    static DWRITE_PANOSE_SERIF_STYLE_PERPENDICULAR_SANS := 13
    static DWRITE_PANOSE_SERIF_STYLE_FLARED := 14
    static DWRITE_PANOSE_SERIF_STYLE_ROUNDED := 15
    static DWRITE_PANOSE_SERIF_STYLE_SCRIPT := 16
    static DWRITE_PANOSE_SERIF_STYLE_PERP_SANS := 13
    static DWRITE_PANOSE_SERIF_STYLE_BONE := 8
}
struct DWRITE_PANOSE_WEIGHT extends Int32 {
    static DWRITE_PANOSE_WEIGHT_ANY := 0
    static DWRITE_PANOSE_WEIGHT_NO_FIT := 1
    static DWRITE_PANOSE_WEIGHT_VERY_LIGHT := 2
    static DWRITE_PANOSE_WEIGHT_LIGHT := 3
    static DWRITE_PANOSE_WEIGHT_THIN := 4
    static DWRITE_PANOSE_WEIGHT_BOOK := 5
    static DWRITE_PANOSE_WEIGHT_MEDIUM := 6
    static DWRITE_PANOSE_WEIGHT_DEMI := 7
    static DWRITE_PANOSE_WEIGHT_BOLD := 8
    static DWRITE_PANOSE_WEIGHT_HEAVY := 9
    static DWRITE_PANOSE_WEIGHT_BLACK := 10
    static DWRITE_PANOSE_WEIGHT_EXTRA_BLACK := 11
    static DWRITE_PANOSE_WEIGHT_NORD := 11
}
struct DWRITE_PANOSE_PROPORTION extends Int32 {
    static DWRITE_PANOSE_PROPORTION_ANY := 0
    static DWRITE_PANOSE_PROPORTION_NO_FIT := 1
    static DWRITE_PANOSE_PROPORTION_OLD_STYLE := 2
    static DWRITE_PANOSE_PROPORTION_MODERN := 3
    static DWRITE_PANOSE_PROPORTION_EVEN_WIDTH := 4
    static DWRITE_PANOSE_PROPORTION_EXPANDED := 5
    static DWRITE_PANOSE_PROPORTION_CONDENSED := 6
    static DWRITE_PANOSE_PROPORTION_VERY_EXPANDED := 7
    static DWRITE_PANOSE_PROPORTION_VERY_CONDENSED := 8
    static DWRITE_PANOSE_PROPORTION_MONOSPACED := 9
}
struct DWRITE_PANOSE_CONTRAST extends Int32 {
    static DWRITE_PANOSE_CONTRAST_ANY := 0
    static DWRITE_PANOSE_CONTRAST_NO_FIT := 1
    static DWRITE_PANOSE_CONTRAST_NONE := 2
    static DWRITE_PANOSE_CONTRAST_VERY_LOW := 3
    static DWRITE_PANOSE_CONTRAST_LOW := 4
    static DWRITE_PANOSE_CONTRAST_MEDIUM_LOW := 5
    static DWRITE_PANOSE_CONTRAST_MEDIUM := 6
    static DWRITE_PANOSE_CONTRAST_MEDIUM_HIGH := 7
    static DWRITE_PANOSE_CONTRAST_HIGH := 8
    static DWRITE_PANOSE_CONTRAST_VERY_HIGH := 9
    static DWRITE_PANOSE_CONTRAST_HORIZONTAL_LOW := 10
    static DWRITE_PANOSE_CONTRAST_HORIZONTAL_MEDIUM := 11
    static DWRITE_PANOSE_CONTRAST_HORIZONTAL_HIGH := 12
    static DWRITE_PANOSE_CONTRAST_BROKEN := 13
}
struct DWRITE_PANOSE_STROKE_VARIATION extends Int32 {
    static DWRITE_PANOSE_STROKE_VARIATION_ANY := 0
    static DWRITE_PANOSE_STROKE_VARIATION_NO_FIT := 1
    static DWRITE_PANOSE_STROKE_VARIATION_NO_VARIATION := 2
    static DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_DIAGONAL := 3
    static DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_TRANSITIONAL := 4
    static DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_VERTICAL := 5
    static DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_HORIZONTAL := 6
    static DWRITE_PANOSE_STROKE_VARIATION_RAPID_VERTICAL := 7
    static DWRITE_PANOSE_STROKE_VARIATION_RAPID_HORIZONTAL := 8
    static DWRITE_PANOSE_STROKE_VARIATION_INSTANT_VERTICAL := 9
    static DWRITE_PANOSE_STROKE_VARIATION_INSTANT_HORIZONTAL := 10
}
struct DWRITE_PANOSE_ARM_STYLE extends Int32 {
    static DWRITE_PANOSE_ARM_STYLE_ANY := 0
    static DWRITE_PANOSE_ARM_STYLE_NO_FIT := 1
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORIZONTAL := 2
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_WEDGE := 3
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERTICAL := 4
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_SINGLE_SERIF := 5
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_DOUBLE_SERIF := 6
    static DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_HORIZONTAL := 7
    static DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_WEDGE := 8
    static DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_VERTICAL := 9
    static DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_SINGLE_SERIF := 10
    static DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_DOUBLE_SERIF := 11
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORZ := 2
    static DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERT := 4
    static DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_HORZ := 7
    static DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_WEDGE := 8
    static DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_VERT := 9
    static DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_SINGLE_SERIF := 10
    static DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_DOUBLE_SERIF := 11
}
struct DWRITE_PANOSE_LETTERFORM extends Int32 {
    static DWRITE_PANOSE_LETTERFORM_ANY := 0
    static DWRITE_PANOSE_LETTERFORM_NO_FIT := 1
    static DWRITE_PANOSE_LETTERFORM_NORMAL_CONTACT := 2
    static DWRITE_PANOSE_LETTERFORM_NORMAL_WEIGHTED := 3
    static DWRITE_PANOSE_LETTERFORM_NORMAL_BOXED := 4
    static DWRITE_PANOSE_LETTERFORM_NORMAL_FLATTENED := 5
    static DWRITE_PANOSE_LETTERFORM_NORMAL_ROUNDED := 6
    static DWRITE_PANOSE_LETTERFORM_NORMAL_OFF_CENTER := 7
    static DWRITE_PANOSE_LETTERFORM_NORMAL_SQUARE := 8
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_CONTACT := 9
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_WEIGHTED := 10
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_BOXED := 11
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_FLATTENED := 12
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_ROUNDED := 13
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_OFF_CENTER := 14
    static DWRITE_PANOSE_LETTERFORM_OBLIQUE_SQUARE := 15
}
struct DWRITE_PANOSE_MIDLINE extends Int32 {
    static DWRITE_PANOSE_MIDLINE_ANY := 0
    static DWRITE_PANOSE_MIDLINE_NO_FIT := 1
    static DWRITE_PANOSE_MIDLINE_STANDARD_TRIMMED := 2
    static DWRITE_PANOSE_MIDLINE_STANDARD_POINTED := 3
    static DWRITE_PANOSE_MIDLINE_STANDARD_SERIFED := 4
    static DWRITE_PANOSE_MIDLINE_HIGH_TRIMMED := 5
    static DWRITE_PANOSE_MIDLINE_HIGH_POINTED := 6
    static DWRITE_PANOSE_MIDLINE_HIGH_SERIFED := 7
    static DWRITE_PANOSE_MIDLINE_CONSTANT_TRIMMED := 8
    static DWRITE_PANOSE_MIDLINE_CONSTANT_POINTED := 9
    static DWRITE_PANOSE_MIDLINE_CONSTANT_SERIFED := 10
    static DWRITE_PANOSE_MIDLINE_LOW_TRIMMED := 11
    static DWRITE_PANOSE_MIDLINE_LOW_POINTED := 12
    static DWRITE_PANOSE_MIDLINE_LOW_SERIFED := 13
}
struct DWRITE_PANOSE_XHEIGHT extends Int32 {
    static DWRITE_PANOSE_XHEIGHT_ANY := 0
    static DWRITE_PANOSE_XHEIGHT_NO_FIT := 1
    static DWRITE_PANOSE_XHEIGHT_CONSTANT_SMALL := 2
    static DWRITE_PANOSE_XHEIGHT_CONSTANT_STANDARD := 3
    static DWRITE_PANOSE_XHEIGHT_CONSTANT_LARGE := 4
    static DWRITE_PANOSE_XHEIGHT_DUCKING_SMALL := 5
    static DWRITE_PANOSE_XHEIGHT_DUCKING_STANDARD := 6
    static DWRITE_PANOSE_XHEIGHT_DUCKING_LARGE := 7
    static DWRITE_PANOSE_XHEIGHT_CONSTANT_STD := 3
    static DWRITE_PANOSE_XHEIGHT_DUCKING_STD := 6
}
struct DWRITE_PANOSE_TOOL_KIND extends Int32 {
    static DWRITE_PANOSE_TOOL_KIND_ANY := 0
    static DWRITE_PANOSE_TOOL_KIND_NO_FIT := 1
    static DWRITE_PANOSE_TOOL_KIND_FLAT_NIB := 2
    static DWRITE_PANOSE_TOOL_KIND_PRESSURE_POINT := 3
    static DWRITE_PANOSE_TOOL_KIND_ENGRAVED := 4
    static DWRITE_PANOSE_TOOL_KIND_BALL := 5
    static DWRITE_PANOSE_TOOL_KIND_BRUSH := 6
    static DWRITE_PANOSE_TOOL_KIND_ROUGH := 7
    static DWRITE_PANOSE_TOOL_KIND_FELT_PEN_BRUSH_TIP := 8
    static DWRITE_PANOSE_TOOL_KIND_WILD_BRUSH := 9
}
struct DWRITE_PANOSE_SPACING extends Int32 {
    static DWRITE_PANOSE_SPACING_ANY := 0
    static DWRITE_PANOSE_SPACING_NO_FIT := 1
    static DWRITE_PANOSE_SPACING_PROPORTIONAL_SPACED := 2
    static DWRITE_PANOSE_SPACING_MONOSPACED := 3
}
struct DWRITE_PANOSE_ASPECT_RATIO extends Int32 {
    static DWRITE_PANOSE_ASPECT_RATIO_ANY := 0
    static DWRITE_PANOSE_ASPECT_RATIO_NO_FIT := 1
    static DWRITE_PANOSE_ASPECT_RATIO_VERY_CONDENSED := 2
    static DWRITE_PANOSE_ASPECT_RATIO_CONDENSED := 3
    static DWRITE_PANOSE_ASPECT_RATIO_NORMAL := 4
    static DWRITE_PANOSE_ASPECT_RATIO_EXPANDED := 5
    static DWRITE_PANOSE_ASPECT_RATIO_VERY_EXPANDED := 6
}
struct DWRITE_PANOSE_SCRIPT_TOPOLOGY extends Int32 {
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_ANY := 0
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_NO_FIT := 1
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_DISCONNECTED := 2
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_TRAILING := 3
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_CONNECTED := 4
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_DISCONNECTED := 5
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_TRAILING := 6
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_CONNECTED := 7
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_DISCONNECTED := 8
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_TRAILING := 9
    static DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_CONNECTED := 10
}
struct DWRITE_PANOSE_SCRIPT_FORM extends Int32 {
    static DWRITE_PANOSE_SCRIPT_FORM_ANY := 0
    static DWRITE_PANOSE_SCRIPT_FORM_NO_FIT := 1
    static DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_NO_WRAPPING := 2
    static DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_SOME_WRAPPING := 3
    static DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_MORE_WRAPPING := 4
    static DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_EXTREME_WRAPPING := 5
    static DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_NO_WRAPPING := 6
    static DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_SOME_WRAPPING := 7
    static DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_MORE_WRAPPING := 8
    static DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_EXTREME_WRAPPING := 9
    static DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_NO_WRAPPING := 10
    static DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_SOME_WRAPPING := 11
    static DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_MORE_WRAPPING := 12
    static DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_EXTREME_WRAPPING := 13
}
struct DWRITE_PANOSE_FINIALS extends Int32 {
    static DWRITE_PANOSE_FINIALS_ANY := 0
    static DWRITE_PANOSE_FINIALS_NO_FIT := 1
    static DWRITE_PANOSE_FINIALS_NONE_NO_LOOPS := 2
    static DWRITE_PANOSE_FINIALS_NONE_CLOSED_LOOPS := 3
    static DWRITE_PANOSE_FINIALS_NONE_OPEN_LOOPS := 4
    static DWRITE_PANOSE_FINIALS_SHARP_NO_LOOPS := 5
    static DWRITE_PANOSE_FINIALS_SHARP_CLOSED_LOOPS := 6
    static DWRITE_PANOSE_FINIALS_SHARP_OPEN_LOOPS := 7
    static DWRITE_PANOSE_FINIALS_TAPERED_NO_LOOPS := 8
    static DWRITE_PANOSE_FINIALS_TAPERED_CLOSED_LOOPS := 9
    static DWRITE_PANOSE_FINIALS_TAPERED_OPEN_LOOPS := 10
    static DWRITE_PANOSE_FINIALS_ROUND_NO_LOOPS := 11
    static DWRITE_PANOSE_FINIALS_ROUND_CLOSED_LOOPS := 12
    static DWRITE_PANOSE_FINIALS_ROUND_OPEN_LOOPS := 13
}
struct DWRITE_PANOSE_XASCENT extends Int32 {
    static DWRITE_PANOSE_XASCENT_ANY := 0
    static DWRITE_PANOSE_XASCENT_NO_FIT := 1
    static DWRITE_PANOSE_XASCENT_VERY_LOW := 2
    static DWRITE_PANOSE_XASCENT_LOW := 3
    static DWRITE_PANOSE_XASCENT_MEDIUM := 4
    static DWRITE_PANOSE_XASCENT_HIGH := 5
    static DWRITE_PANOSE_XASCENT_VERY_HIGH := 6
}
struct DWRITE_PANOSE_DECORATIVE_CLASS extends Int32 {
    static DWRITE_PANOSE_DECORATIVE_CLASS_ANY := 0
    static DWRITE_PANOSE_DECORATIVE_CLASS_NO_FIT := 1
    static DWRITE_PANOSE_DECORATIVE_CLASS_DERIVATIVE := 2
    static DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_TOPOLOGY := 3
    static DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ELEMENTS := 4
    static DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ASPECT := 5
    static DWRITE_PANOSE_DECORATIVE_CLASS_INITIALS := 6
    static DWRITE_PANOSE_DECORATIVE_CLASS_CARTOON := 7
    static DWRITE_PANOSE_DECORATIVE_CLASS_PICTURE_STEMS := 8
    static DWRITE_PANOSE_DECORATIVE_CLASS_ORNAMENTED := 9
    static DWRITE_PANOSE_DECORATIVE_CLASS_TEXT_AND_BACKGROUND := 10
    static DWRITE_PANOSE_DECORATIVE_CLASS_COLLAGE := 11
    static DWRITE_PANOSE_DECORATIVE_CLASS_MONTAGE := 12
}
struct DWRITE_PANOSE_ASPECT extends Int32 {
    static DWRITE_PANOSE_ASPECT_ANY := 0
    static DWRITE_PANOSE_ASPECT_NO_FIT := 1
    static DWRITE_PANOSE_ASPECT_SUPER_CONDENSED := 2
    static DWRITE_PANOSE_ASPECT_VERY_CONDENSED := 3
    static DWRITE_PANOSE_ASPECT_CONDENSED := 4
    static DWRITE_PANOSE_ASPECT_NORMAL := 5
    static DWRITE_PANOSE_ASPECT_EXTENDED := 6
    static DWRITE_PANOSE_ASPECT_VERY_EXTENDED := 7
    static DWRITE_PANOSE_ASPECT_SUPER_EXTENDED := 8
    static DWRITE_PANOSE_ASPECT_MONOSPACED := 9
}
struct DWRITE_PANOSE_FILL extends Int32 {
    static DWRITE_PANOSE_FILL_ANY := 0
    static DWRITE_PANOSE_FILL_NO_FIT := 1
    static DWRITE_PANOSE_FILL_STANDARD_SOLID_FILL := 2
    static DWRITE_PANOSE_FILL_NO_FILL := 3
    static DWRITE_PANOSE_FILL_PATTERNED_FILL := 4
    static DWRITE_PANOSE_FILL_COMPLEX_FILL := 5
    static DWRITE_PANOSE_FILL_SHAPED_FILL := 6
    static DWRITE_PANOSE_FILL_DRAWN_DISTRESSED := 7
}
struct DWRITE_PANOSE_LINING extends Int32 {
    static DWRITE_PANOSE_LINING_ANY := 0
    static DWRITE_PANOSE_LINING_NO_FIT := 1
    static DWRITE_PANOSE_LINING_NONE := 2
    static DWRITE_PANOSE_LINING_INLINE := 3
    static DWRITE_PANOSE_LINING_OUTLINE := 4
    static DWRITE_PANOSE_LINING_ENGRAVED := 5
    static DWRITE_PANOSE_LINING_SHADOW := 6
    static DWRITE_PANOSE_LINING_RELIEF := 7
    static DWRITE_PANOSE_LINING_BACKDROP := 8
}
struct DWRITE_PANOSE_DECORATIVE_TOPOLOGY extends Int32 {
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ANY := 0
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_NO_FIT := 1
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_STANDARD := 2
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SQUARE := 3
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_MULTIPLE_SEGMENT := 4
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ART_DECO := 5
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UNEVEN_WEIGHTING := 6
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_ARMS := 7
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_FORMS := 8
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_LOMBARDIC_FORMS := 9
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UPPER_CASE_IN_LOWER_CASE := 10
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_IMPLIED_TOPOLOGY := 11
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_HORSESHOE_E_AND_A := 12
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_CURSIVE := 13
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_BLACKLETTER := 14
    static DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SWASH_VARIANCE := 15
}
struct DWRITE_PANOSE_CHARACTER_RANGES extends Int32 {
    static DWRITE_PANOSE_CHARACTER_RANGES_ANY := 0
    static DWRITE_PANOSE_CHARACTER_RANGES_NO_FIT := 1
    static DWRITE_PANOSE_CHARACTER_RANGES_EXTENDED_COLLECTION := 2
    static DWRITE_PANOSE_CHARACTER_RANGES_LITERALS := 3
    static DWRITE_PANOSE_CHARACTER_RANGES_NO_LOWER_CASE := 4
    static DWRITE_PANOSE_CHARACTER_RANGES_SMALL_CAPS := 5
}
struct DWRITE_PANOSE_SYMBOL_KIND extends Int32 {
    static DWRITE_PANOSE_SYMBOL_KIND_ANY := 0
    static DWRITE_PANOSE_SYMBOL_KIND_NO_FIT := 1
    static DWRITE_PANOSE_SYMBOL_KIND_MONTAGES := 2
    static DWRITE_PANOSE_SYMBOL_KIND_PICTURES := 3
    static DWRITE_PANOSE_SYMBOL_KIND_SHAPES := 4
    static DWRITE_PANOSE_SYMBOL_KIND_SCIENTIFIC := 5
    static DWRITE_PANOSE_SYMBOL_KIND_MUSIC := 6
    static DWRITE_PANOSE_SYMBOL_KIND_EXPERT := 7
    static DWRITE_PANOSE_SYMBOL_KIND_PATTERNS := 8
    static DWRITE_PANOSE_SYMBOL_KIND_BOARDERS := 9
    static DWRITE_PANOSE_SYMBOL_KIND_ICONS := 10
    static DWRITE_PANOSE_SYMBOL_KIND_LOGOS := 11
    static DWRITE_PANOSE_SYMBOL_KIND_INDUSTRY_SPECIFIC := 12
}
struct DWRITE_PANOSE_SYMBOL_ASPECT_RATIO extends Int32 {
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_ANY := 0
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_FIT := 1
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_WIDTH := 2
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_EXCEPTIONALLY_WIDE := 3
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_SUPER_WIDE := 4
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_WIDE := 5
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_WIDE := 6
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NORMAL := 7
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NARROW := 8
    static DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_NARROW := 9
}
struct DWRITE_OUTLINE_THRESHOLD extends Int32 {
    static DWRITE_OUTLINE_THRESHOLD_ANTIALIASED := 0
    static DWRITE_OUTLINE_THRESHOLD_ALIASED := 1
}
struct DWRITE_BASELINE extends Int32 {
    static DWRITE_BASELINE_DEFAULT := 0
    static DWRITE_BASELINE_ROMAN := 1
    static DWRITE_BASELINE_CENTRAL := 2
    static DWRITE_BASELINE_MATH := 3
    static DWRITE_BASELINE_HANGING := 4
    static DWRITE_BASELINE_IDEOGRAPHIC_BOTTOM := 5
    static DWRITE_BASELINE_IDEOGRAPHIC_TOP := 6
    static DWRITE_BASELINE_MINIMUM := 7
    static DWRITE_BASELINE_MAXIMUM := 8
}
struct DWRITE_VERTICAL_GLYPH_ORIENTATION extends Int32 {
    static DWRITE_VERTICAL_GLYPH_ORIENTATION_DEFAULT := 0
    static DWRITE_VERTICAL_GLYPH_ORIENTATION_STACKED := 1
}
struct DWRITE_GLYPH_ORIENTATION_ANGLE extends Int32 {
    static DWRITE_GLYPH_ORIENTATION_ANGLE_0_DEGREES := 0
    static DWRITE_GLYPH_ORIENTATION_ANGLE_90_DEGREES := 1
    static DWRITE_GLYPH_ORIENTATION_ANGLE_180_DEGREES := 2
    static DWRITE_GLYPH_ORIENTATION_ANGLE_270_DEGREES := 3
}
struct DWRITE_FONT_METRICS1 {
    Base : DWRITE_FONT_METRICS
    glyphBoxLeft : Int16
    glyphBoxTop : Int16
    glyphBoxRight : Int16
    glyphBoxBottom : Int16
    subscriptPositionX : Int16
    subscriptPositionY : Int16
    subscriptSizeX : Int16
    subscriptSizeY : Int16
    superscriptPositionX : Int16
    superscriptPositionY : Int16
    superscriptSizeX : Int16
    superscriptSizeY : Int16
    hasTypographicMetrics : BOOL
}
struct DWRITE_CARET_METRICS {
    slopeRise : Int16
    slopeRun : Int16
    offset : Int16
}
struct DWRITE_PANOSE {
    union {
        values : UInt8[10]
        familyKind : UInt8
        text : this._text_e__Struct
        script : this._script_e__Struct
        decorative : this._decorative_e__Struct
        symbol : this._symbol_e__Struct
    }
    struct _text_e__Struct {
        familyKind : UInt8
        serifStyle : UInt8
        weight : UInt8
        proportion : UInt8
        contrast : UInt8
        strokeVariation : UInt8
        armStyle : UInt8
        letterform : UInt8
        midline : UInt8
        xHeight : UInt8
    }
    struct _script_e__Struct {
        familyKind : UInt8
        toolKind : UInt8
        weight : UInt8
        spacing : UInt8
        aspectRatio : UInt8
        contrast : UInt8
        scriptTopology : UInt8
        scriptForm : UInt8
        finials : UInt8
        xAscent : UInt8
    }
    struct _decorative_e__Struct {
        familyKind : UInt8
        decorativeClass : UInt8
        weight : UInt8
        aspect : UInt8
        contrast : UInt8
        serifVariant : UInt8
        fill : UInt8
        lining : UInt8
        decorativeTopology : UInt8
        characterRange : UInt8
    }
    struct _symbol_e__Struct {
        familyKind : UInt8
        symbolKind : UInt8
        weight : UInt8
        spacing : UInt8
        aspectRatioAndContrast : UInt8
        aspectRatio94 : UInt8
        aspectRatio119 : UInt8
        aspectRatio157 : UInt8
        aspectRatio163 : UInt8
        aspectRatio211 : UInt8
    }
}
struct DWRITE_UNICODE_RANGE {
    first : UInt32
    last : UInt32
}
struct DWRITE_SCRIPT_PROPERTIES {
    isoScriptCode : UInt32
    isoScriptNumber : UInt32
    clusterLookahead : UInt32
    justificationCharacter : UInt32
    _bitfield : UInt32
}
struct DWRITE_JUSTIFICATION_OPPORTUNITY {
    expansionMinimum : Float32
    expansionMaximum : Float32
    compressionMaximum : Float32
    _bitfield : UInt32
}
struct IDWriteFactory1 extends IDWriteFactory {
    static IID := "{30572F99-DAC6-41DB-A16E-0486307E606A}"
    GetEudcFontCollection(fontCollection, checkForUpdates)
      => ComCall(24, this.p, IDWriteFontCollection.Ptr, fontCollection, BOOL, checkForUpdates)
    CreateCustomRenderingParams(gamma, enhancedContrast, enhancedContrastGrayscale, clearTypeLevel, pixelGeometry, renderingMode, renderingParams)
      => ComCall(25, this.p, Float32, gamma, Float32, enhancedContrast, Float32, enhancedContrastGrayscale, Float32, clearTypeLevel, DWRITE_PIXEL_GEOMETRY, pixelGeometry, DWRITE_RENDERING_MODE, renderingMode, IDWriteRenderingParams1.Ptr, renderingParams)
}
struct IDWriteFontFace1 extends IDWriteFontFace {
    static IID := "{A71EFDB4-9FDB-4838-AD90-CFC3BE8C3DAF}"
    GetMetrics(fontMetrics)
      => ComCall(18, this.p, DWRITE_FONT_METRICS1.Ptr, fontMetrics, "void")
    GetGdiCompatibleMetrics(emSize, pixelsPerDip, transform?, fontMetrics)
      => ComCall(19, this.p, Float32, emSize, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, DWRITE_FONT_METRICS1.Ptr, fontMetrics)
    GetCaretMetrics(caretMetrics)
      => ComCall(20, this.p, DWRITE_CARET_METRICS.Ptr, caretMetrics, "void")
    GetUnicodeRanges(unicodeRanges?, actualRangeCount)
      => ComCall(21, this.p, UInt32, unicodeRanges?.Length ?? 0, DWRITE_UNICODE_RANGE.Ptr, unicodeRanges?, UInt32.Ptr, actualRangeCount)
    IsMonospacedFont()
      => ComCall(22, this.p, BOOL)
    GetDesignGlyphAdvances(glyphIndices, glyphAdvances, isSideways)
      => ComCall(23, this.p, UInt32, glyphAdvances.Length, UInt16.Ptr, glyphIndices, Int32.Ptr, glyphAdvances, BOOL, isSideways)
    GetGdiCompatibleGlyphAdvances(emSize, pixelsPerDip, transform?, useGdiNatural, isSideways, glyphIndices, glyphAdvances)
      => ComCall(24, this.p, Float32, emSize, Float32, pixelsPerDip, DWRITE_MATRIX.Ptr, transform?, BOOL, useGdiNatural, BOOL, isSideways, UInt32, glyphAdvances.Length, UInt16.Ptr, glyphIndices, Int32.Ptr, glyphAdvances)
    GetKerningPairAdjustments(glyphIndices, glyphAdvanceAdjustments)
      => ComCall(25, this.p, UInt32, glyphAdvanceAdjustments.Length, UInt16.Ptr, glyphIndices, Int32.Ptr, glyphAdvanceAdjustments)
    HasKerningPairs()
      => ComCall(26, this.p, BOOL)
    GetRecommendedRenderingMode(fontEmSize, dpiX, dpiY, transform?, isSideways, outlineThreshold, measuringMode, renderingMode)
      => ComCall(27, this.p, Float32, fontEmSize, Float32, dpiX, Float32, dpiY, DWRITE_MATRIX.Ptr, transform?, BOOL, isSideways, DWRITE_OUTLINE_THRESHOLD, outlineThreshold, DWRITE_MEASURING_MODE, measuringMode, DWRITE_RENDERING_MODE.Ptr, renderingMode)
    GetVerticalGlyphVariants(nominalGlyphIndices, verticalGlyphIndices)
      => ComCall(28, this.p, UInt32, verticalGlyphIndices.Length, UInt16.Ptr, nominalGlyphIndices, UInt16.Ptr, verticalGlyphIndices)
    HasVerticalGlyphVariants()
      => ComCall(29, this.p, BOOL)
}
struct IDWriteFont1 extends IDWriteFont {
    static IID := "{ACD16696-8C14-4F5D-877E-FE3FC1D32738}"
    GetMetrics(fontMetrics)
      => ComCall(14, this.p, DWRITE_FONT_METRICS1.Ptr, fontMetrics, "void")
    GetPanose(panose)
      => ComCall(15, this.p, DWRITE_PANOSE.Ptr, panose, "void")
    GetUnicodeRanges(unicodeRanges?, actualRangeCount)
      => ComCall(16, this.p, UInt32, unicodeRanges?.Length ?? 0, DWRITE_UNICODE_RANGE.Ptr, unicodeRanges?, UInt32.Ptr, actualRangeCount)
    IsMonospacedFont()
      => ComCall(17, this.p, BOOL)
}
struct IDWriteRenderingParams1 extends IDWriteRenderingParams {
    static IID := "{94413CF4-A6FC-4248-8B50-6674348FCAD3}"
    GetGrayscaleEnhancedContrast()
      => ComCall(8, this.p, Float32)
}
struct IDWriteTextAnalyzer1 extends IDWriteTextAnalyzer {
    static IID := "{80DAD800-E21F-4E83-96CE-BFCCE500DB7C}"
    ApplyCharacterSpacing(leadingSpacing, trailingSpacing, minimumAdvanceWidth, clusterMap, glyphAdvances, glyphOffsets, glyphProperties, modifiedGlyphAdvances, modifiedGlyphOffsets)
      => ComCall(10, this.p, Float32, leadingSpacing, Float32, trailingSpacing, Float32, minimumAdvanceWidth, UInt32, clusterMap.Length, UInt32, modifiedGlyphOffsets.Length, UInt16.Ptr, clusterMap, Float32.Ptr, glyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, glyphOffsets, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProperties, Float32.Ptr, modifiedGlyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, modifiedGlyphOffsets)
    GetBaseline(fontFace, baseline, isVertical, isSimulationAllowed, scriptAnalysis, localeName?, baselineCoordinate, exists)
      => ComCall(11, this.p, IDWriteFontFace, fontFace, DWRITE_BASELINE, baseline, BOOL, isVertical, BOOL, isSimulationAllowed, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, "Str", localeName?, Int32.Ptr, baselineCoordinate, BOOL.Ptr, exists)
    AnalyzeVerticalGlyphOrientation(analysisSource, textPosition, textLength, analysisSink)
      => ComCall(12, this.p, IDWriteTextAnalysisSource1, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteTextAnalysisSink1, analysisSink)
    GetGlyphOrientationTransform(glyphOrientationAngle, isSideways, transform)
      => ComCall(13, this.p, DWRITE_GLYPH_ORIENTATION_ANGLE, glyphOrientationAngle, BOOL, isSideways, DWRITE_MATRIX.Ptr, transform)
    GetScriptProperties(scriptAnalysis, scriptProperties)
      => ComCall(14, this.p, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, DWRITE_SCRIPT_PROPERTIES.Ptr, scriptProperties)
    GetTextComplexity(textString, fontFace, isTextSimple, textLengthRead, glyphIndices?)
      => ComCall(15, this.p, "Str", textString, UInt32, glyphIndices?.Length ?? 0, IDWriteFontFace, fontFace, BOOL.Ptr, isTextSimple, UInt32.Ptr, textLengthRead, UInt16.Ptr, glyphIndices?)
    GetJustificationOpportunities(fontFace?, fontEmSize, scriptAnalysis, textString, clusterMap, glyphProperties, justificationOpportunities)
      => ComCall(16, this.p, IDWriteFontFace, fontFace?, Float32, fontEmSize, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, UInt32, clusterMap.Length, UInt32, justificationOpportunities.Length, "Str", textString, UInt16.Ptr, clusterMap, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProperties, DWRITE_JUSTIFICATION_OPPORTUNITY.Ptr, justificationOpportunities)
    JustifyGlyphAdvances(lineWidth, justificationOpportunities, glyphAdvances, glyphOffsets, justifiedGlyphAdvances, justifiedGlyphOffsets?)
      => ComCall(17, this.p, Float32, lineWidth, UInt32, justifiedGlyphOffsets?.Length ?? 0, DWRITE_JUSTIFICATION_OPPORTUNITY.Ptr, justificationOpportunities, Float32.Ptr, glyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, glyphOffsets, Float32.Ptr, justifiedGlyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, justifiedGlyphOffsets?)
    GetJustifiedGlyphs(fontFace?, fontEmSize, scriptAnalysis, clusterMap?, glyphIndices, glyphAdvances, justifiedGlyphAdvances, justifiedGlyphOffsets, glyphProperties, actualGlyphCount, modifiedClusterMap?, modifiedGlyphIndices, modifiedGlyphAdvances, modifiedGlyphOffsets)
      => ComCall(18, this.p, IDWriteFontFace, fontFace?, Float32, fontEmSize, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, UInt32, modifiedClusterMap?.Length ?? 0, UInt32, glyphProperties.Length, UInt32, modifiedGlyphOffsets.Length, UInt16.Ptr, clusterMap?, UInt16.Ptr, glyphIndices, Float32.Ptr, glyphAdvances, Float32.Ptr, justifiedGlyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, justifiedGlyphOffsets, DWRITE_SHAPING_GLYPH_PROPERTIES.Ptr, glyphProperties, UInt32.Ptr, actualGlyphCount, UInt16.Ptr, modifiedClusterMap?, UInt16.Ptr, modifiedGlyphIndices, Float32.Ptr, modifiedGlyphAdvances, DWRITE_GLYPH_OFFSET.Ptr, modifiedGlyphOffsets)
}
struct IDWriteTextAnalysisSource1 extends IDWriteTextAnalysisSource {
    static IID := "{639CFAD8-0FB4-4B21-A58A-067920120009}"
    GetVerticalGlyphOrientation(textPosition, textLength, glyphOrientation, bidiLevel)
      => ComCall(8, this.p, UInt32, textPosition, UInt32.Ptr, textLength, DWRITE_VERTICAL_GLYPH_ORIENTATION.Ptr, glyphOrientation, UInt8.Ptr, bidiLevel)
}
struct IDWriteTextAnalysisSink1 extends IDWriteTextAnalysisSink {
    static IID := "{B0D941A0-85E7-4D8B-9FD3-5CED9934482A}"
    SetGlyphOrientation(textPosition, textLength, glyphOrientationAngle, adjustedBidiLevel, isSideways, isRightToLeft)
      => ComCall(7, this.p, UInt32, textPosition, UInt32, textLength, DWRITE_GLYPH_ORIENTATION_ANGLE, glyphOrientationAngle, UInt8, adjustedBidiLevel, BOOL, isSideways, BOOL, isRightToLeft)
}
struct IDWriteTextLayout1 extends IDWriteTextLayout {
    static IID := "{9064D822-80A7-465C-A986-DF65F78B8FEB}"
    SetPairKerning(isPairKerningEnabled, textRange)
      => ComCall(67, this.p, BOOL, isPairKerningEnabled, DWRITE_TEXT_RANGE, textRange)
    GetPairKerning(currentPosition, isPairKerningEnabled, textRange?)
      => ComCall(68, this.p, UInt32, currentPosition, BOOL.Ptr, isPairKerningEnabled, DWRITE_TEXT_RANGE.Ptr, textRange?)
    SetCharacterSpacing(leadingSpacing, trailingSpacing, minimumAdvanceWidth, textRange)
      => ComCall(69, this.p, Float32, leadingSpacing, Float32, trailingSpacing, Float32, minimumAdvanceWidth, DWRITE_TEXT_RANGE, textRange)
    GetCharacterSpacing(currentPosition, leadingSpacing, trailingSpacing, minimumAdvanceWidth, textRange?)
      => ComCall(70, this.p, UInt32, currentPosition, Float32.Ptr, leadingSpacing, Float32.Ptr, trailingSpacing, Float32.Ptr, minimumAdvanceWidth, DWRITE_TEXT_RANGE.Ptr, textRange?)
}
struct DWRITE_TEXT_ANTIALIAS_MODE extends Int32 {
    static DWRITE_TEXT_ANTIALIAS_MODE_CLEARTYPE := 0
    static DWRITE_TEXT_ANTIALIAS_MODE_GRAYSCALE := 1
}
struct IDWriteBitmapRenderTarget1 extends IDWriteBitmapRenderTarget {
    static IID := "{791E8298-3EF3-4230-9880-C9BDECC42064}"
    GetTextAntialiasMode()
      => ComCall(11, this.p, DWRITE_TEXT_ANTIALIAS_MODE)
    SetTextAntialiasMode(antialiasMode)
      => ComCall(12, this.p, DWRITE_TEXT_ANTIALIAS_MODE, antialiasMode)
}
struct DWRITE_OPTICAL_ALIGNMENT extends Int32 {
    static DWRITE_OPTICAL_ALIGNMENT_NONE := 0
    static DWRITE_OPTICAL_ALIGNMENT_NO_SIDE_BEARINGS := 1
}
struct DWRITE_GRID_FIT_MODE extends Int32 {
    static DWRITE_GRID_FIT_MODE_DEFAULT := 0
    static DWRITE_GRID_FIT_MODE_DISABLED := 1
    static DWRITE_GRID_FIT_MODE_ENABLED := 2
}
struct DWRITE_TEXT_METRICS1 {
    Base : DWRITE_TEXT_METRICS
    heightIncludingTrailingWhitespace : Float32
}
struct IDWriteTextRenderer1 extends IDWriteTextRenderer {
    static IID := "{D3E0E934-22A0-427E-AAE4-7D9574B59DB1}"
    DrawGlyphRun(clientDrawingContext?, baselineOriginX, baselineOriginY, orientationAngle, measuringMode, glyphRun, glyphRunDescription, clientDrawingEffect?)
      => ComCall(10, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE, orientationAngle, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription, IUnknown, clientDrawingEffect?)
    DrawUnderline(clientDrawingContext?, baselineOriginX, baselineOriginY, orientationAngle, underline, clientDrawingEffect?)
      => ComCall(11, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE, orientationAngle, DWRITE_UNDERLINE.Ptr, underline, IUnknown, clientDrawingEffect?)
    DrawStrikethrough(clientDrawingContext?, baselineOriginX, baselineOriginY, orientationAngle, strikethrough, clientDrawingEffect?)
      => ComCall(12, this.p, Struct.Ptr, clientDrawingContext?, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE, orientationAngle, DWRITE_STRIKETHROUGH.Ptr, strikethrough, IUnknown, clientDrawingEffect?)
    DrawInlineObject(clientDrawingContext?, originX, originY, orientationAngle, inlineObject, isSideways, isRightToLeft, clientDrawingEffect?)
      => ComCall(13, this.p, Struct.Ptr, clientDrawingContext?, Float32, originX, Float32, originY, DWRITE_GLYPH_ORIENTATION_ANGLE, orientationAngle, IDWriteInlineObject, inlineObject, BOOL, isSideways, BOOL, isRightToLeft, IUnknown, clientDrawingEffect?)
}
struct IDWriteTextFormat1 extends IDWriteTextFormat {
    static IID := "{5F174B49-0D8B-4CFB-8BCA-F1CCE9D06C67}"
    SetVerticalGlyphOrientation(glyphOrientation)
      => ComCall(28, this.p, DWRITE_VERTICAL_GLYPH_ORIENTATION, glyphOrientation)
    GetVerticalGlyphOrientation()
      => ComCall(29, this.p, DWRITE_VERTICAL_GLYPH_ORIENTATION)
    SetLastLineWrapping(isLastLineWrappingEnabled)
      => ComCall(30, this.p, BOOL, isLastLineWrappingEnabled)
    GetLastLineWrapping()
      => ComCall(31, this.p, BOOL)
    SetOpticalAlignment(opticalAlignment)
      => ComCall(32, this.p, DWRITE_OPTICAL_ALIGNMENT, opticalAlignment)
    GetOpticalAlignment()
      => ComCall(33, this.p, DWRITE_OPTICAL_ALIGNMENT)
    SetFontFallback(fontFallback)
      => ComCall(34, this.p, IDWriteFontFallback, fontFallback)
    GetFontFallback(fontFallback)
      => ComCall(35, this.p, IDWriteFontFallback.Ptr, fontFallback)
}
struct IDWriteTextLayout2 extends IDWriteTextLayout1 {
    static IID := "{1093C18F-8D5E-43F0-B064-0917311B525E}"
    GetMetrics(textMetrics)
      => ComCall(71, this.p, DWRITE_TEXT_METRICS1.Ptr, textMetrics)
    SetVerticalGlyphOrientation(glyphOrientation)
      => ComCall(72, this.p, DWRITE_VERTICAL_GLYPH_ORIENTATION, glyphOrientation)
    GetVerticalGlyphOrientation()
      => ComCall(73, this.p, DWRITE_VERTICAL_GLYPH_ORIENTATION)
    SetLastLineWrapping(isLastLineWrappingEnabled)
      => ComCall(74, this.p, BOOL, isLastLineWrappingEnabled)
    GetLastLineWrapping()
      => ComCall(75, this.p, BOOL)
    SetOpticalAlignment(opticalAlignment)
      => ComCall(76, this.p, DWRITE_OPTICAL_ALIGNMENT, opticalAlignment)
    GetOpticalAlignment()
      => ComCall(77, this.p, DWRITE_OPTICAL_ALIGNMENT)
    SetFontFallback(fontFallback)
      => ComCall(78, this.p, IDWriteFontFallback, fontFallback)
    GetFontFallback(fontFallback)
      => ComCall(79, this.p, IDWriteFontFallback.Ptr, fontFallback)
}
struct IDWriteTextAnalyzer2 extends IDWriteTextAnalyzer1 {
    static IID := "{553A9FF3-5693-4DF7-B52B-74806F7F2EB9}"
    GetGlyphOrientationTransform(glyphOrientationAngle, isSideways, originX, originY, transform)
      => ComCall(19, this.p, DWRITE_GLYPH_ORIENTATION_ANGLE, glyphOrientationAngle, BOOL, isSideways, Float32, originX, Float32, originY, DWRITE_MATRIX.Ptr, transform)
    GetTypographicFeatures(fontFace, scriptAnalysis, localeName?, actualTagCount, tags)
      => ComCall(20, this.p, IDWriteFontFace, fontFace, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, "Str", localeName?, UInt32, tags.Length, UInt32.Ptr, actualTagCount, DWRITE_FONT_FEATURE_TAG.Ptr, tags)
    CheckTypographicFeature(fontFace, scriptAnalysis, localeName?, featureTag, glyphIndices, featureApplies)
      => ComCall(21, this.p, IDWriteFontFace, fontFace, DWRITE_SCRIPT_ANALYSIS, scriptAnalysis, "Str", localeName?, DWRITE_FONT_FEATURE_TAG, featureTag, UInt32, featureApplies.Length, UInt16.Ptr, glyphIndices, UInt8.Ptr, featureApplies)
}
struct IDWriteFontFallback extends IUnknown {
    static IID := "{EFA008F9-F7A1-48BF-B05C-F224713CC0FF}"
    MapCharacters(analysisSource, textPosition, textLength, baseFontCollection?, baseFamilyName?, baseWeight, baseStyle, baseStretch, mappedLength, mappedFont, scale)
      => ComCall(3, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteFontCollection, baseFontCollection?, "Str", baseFamilyName?, DWRITE_FONT_WEIGHT, baseWeight, DWRITE_FONT_STYLE, baseStyle, DWRITE_FONT_STRETCH, baseStretch, UInt32.Ptr, mappedLength, IDWriteFont.Ptr, mappedFont, Float32.Ptr, scale)
}
struct IDWriteFontFallbackBuilder extends IUnknown {
    static IID := "{FD882D06-8ABA-4FB8-B849-8BE8B73E14DE}"
    AddMapping(ranges, targetFamilyNames, fontCollection?, localeName?, baseFamilyName?, scale)
      => ComCall(3, this.p, DWRITE_UNICODE_RANGE.Ptr, ranges, UInt32, ranges.Length, UInt16.Ptr.Ptr, targetFamilyNames, UInt32, targetFamilyNames.Length, IDWriteFontCollection, fontCollection?, "Str", localeName?, "Str", baseFamilyName?, Float32, scale)
    AddMappings(fontFallback)
      => ComCall(4, this.p, IDWriteFontFallback, fontFallback)
    CreateFontFallback(fontFallback)
      => ComCall(5, this.p, IDWriteFontFallback.Ptr, fontFallback)
}
struct IDWriteFont2 extends IDWriteFont1 {
    static IID := "{29748ED6-8C9C-4A6A-BE0B-D912E8538944}"
    IsColorFont()
      => ComCall(18, this.p, BOOL)
}
struct IDWriteFontFace2 extends IDWriteFontFace1 {
    static IID := "{D8B768FF-64BC-4E66-982B-EC8E87F693F7}"
    IsColorFont()
      => ComCall(30, this.p, BOOL)
    GetColorPaletteCount()
      => ComCall(31, this.p, UInt32)
    GetPaletteEntryCount()
      => ComCall(32, this.p, UInt32)
    GetPaletteEntries(colorPaletteIndex, firstEntryIndex, paletteEntries)
      => ComCall(33, this.p, UInt32, colorPaletteIndex, UInt32, firstEntryIndex, UInt32, paletteEntries.Length, DWRITE_COLOR_F.Ptr, paletteEntries)
    GetRecommendedRenderingMode(fontEmSize, dpiX, dpiY, transform?, isSideways, outlineThreshold, measuringMode, renderingParams?, renderingMode, gridFitMode)
      => ComCall(34, this.p, Float32, fontEmSize, Float32, dpiX, Float32, dpiY, DWRITE_MATRIX.Ptr, transform?, BOOL, isSideways, DWRITE_OUTLINE_THRESHOLD, outlineThreshold, DWRITE_MEASURING_MODE, measuringMode, IDWriteRenderingParams, renderingParams?, DWRITE_RENDERING_MODE.Ptr, renderingMode, DWRITE_GRID_FIT_MODE.Ptr, gridFitMode)
}
struct DWRITE_COLOR_GLYPH_RUN {
    glyphRun : DWRITE_GLYPH_RUN
    glyphRunDescription : DWRITE_GLYPH_RUN_DESCRIPTION.Ptr
    baselineOriginX : Float32
    baselineOriginY : Float32
    runColor : DWRITE_COLOR_F
    paletteIndex : UInt16
}
struct IDWriteColorGlyphRunEnumerator extends IUnknown {
    static IID := "{D31FBE17-F157-41A2-8D24-CB779E0560E8}"
    MoveNext(hasRun)
      => ComCall(3, this.p, BOOL.Ptr, hasRun)
    GetCurrentRun(colorGlyphRun)
      => ComCall(4, this.p, DWRITE_COLOR_GLYPH_RUN.Ptr.Ptr, colorGlyphRun)
}
struct IDWriteRenderingParams2 extends IDWriteRenderingParams1 {
    static IID := "{F9D711C3-9777-40AE-87E8-3E5AF9BF0948}"
    GetGridFitMode()
      => ComCall(9, this.p, DWRITE_GRID_FIT_MODE)
}
struct IDWriteFactory2 extends IDWriteFactory1 {
    static IID := "{0439FC60-CA44-4994-8DEE-3A9AF7B732EC}"
    GetSystemFontFallback(fontFallback)
      => ComCall(26, this.p, IDWriteFontFallback.Ptr, fontFallback)
    CreateFontFallbackBuilder(fontFallbackBuilder)
      => ComCall(27, this.p, IDWriteFontFallbackBuilder.Ptr, fontFallbackBuilder)
    TranslateColorGlyphRun(baselineOriginX, baselineOriginY, glyphRun, glyphRunDescription?, measuringMode, worldToDeviceTransform?, colorPaletteIndex, colorLayers)
      => ComCall(28, this.p, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, DWRITE_MEASURING_MODE, measuringMode, DWRITE_MATRIX.Ptr, worldToDeviceTransform?, UInt32, colorPaletteIndex, IDWriteColorGlyphRunEnumerator.Ptr, colorLayers)
    CreateCustomRenderingParams(gamma, enhancedContrast, grayscaleEnhancedContrast, clearTypeLevel, pixelGeometry, renderingMode, gridFitMode, renderingParams)
      => ComCall(29, this.p, Float32, gamma, Float32, enhancedContrast, Float32, grayscaleEnhancedContrast, Float32, clearTypeLevel, DWRITE_PIXEL_GEOMETRY, pixelGeometry, DWRITE_RENDERING_MODE, renderingMode, DWRITE_GRID_FIT_MODE, gridFitMode, IDWriteRenderingParams2.Ptr, renderingParams)
    CreateGlyphRunAnalysis(glyphRun, transform?, renderingMode, measuringMode, gridFitMode, antialiasMode, baselineOriginX, baselineOriginY, glyphRunAnalysis)
      => ComCall(30, this.p, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_MATRIX.Ptr, transform?, DWRITE_RENDERING_MODE, renderingMode, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GRID_FIT_MODE, gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE, antialiasMode, Float32, baselineOriginX, Float32, baselineOriginY, IDWriteGlyphRunAnalysis.Ptr, glyphRunAnalysis)
}
struct DWRITE_FONT_PROPERTY_ID extends Int32 {
    static DWRITE_FONT_PROPERTY_ID_NONE := 0
    static DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FAMILY_NAME := 1
    static DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FAMILY_NAME := 2
    static DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FACE_NAME := 3
    static DWRITE_FONT_PROPERTY_ID_FULL_NAME := 4
    static DWRITE_FONT_PROPERTY_ID_WIN32_FAMILY_NAME := 5
    static DWRITE_FONT_PROPERTY_ID_POSTSCRIPT_NAME := 6
    static DWRITE_FONT_PROPERTY_ID_DESIGN_SCRIPT_LANGUAGE_TAG := 7
    static DWRITE_FONT_PROPERTY_ID_SUPPORTED_SCRIPT_LANGUAGE_TAG := 8
    static DWRITE_FONT_PROPERTY_ID_SEMANTIC_TAG := 9
    static DWRITE_FONT_PROPERTY_ID_WEIGHT := 10
    static DWRITE_FONT_PROPERTY_ID_STRETCH := 11
    static DWRITE_FONT_PROPERTY_ID_STYLE := 12
    static DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FACE_NAME := 13
    static DWRITE_FONT_PROPERTY_ID_TOTAL := 13
    static DWRITE_FONT_PROPERTY_ID_TOTAL_RS3 := 14
    static DWRITE_FONT_PROPERTY_ID_PREFERRED_FAMILY_NAME := 2
    static DWRITE_FONT_PROPERTY_ID_FAMILY_NAME := 1
    static DWRITE_FONT_PROPERTY_ID_FACE_NAME := 3
}
struct DWRITE_FONT_PROPERTY {
    propertyId : DWRITE_FONT_PROPERTY_ID
    propertyValue : PWSTR
    localeName : PWSTR
}
struct DWRITE_LOCALITY extends Int32 {
    static DWRITE_LOCALITY_REMOTE := 0
    static DWRITE_LOCALITY_PARTIAL := 1
    static DWRITE_LOCALITY_LOCAL := 2
}
struct DWRITE_RENDERING_MODE1 extends Int32 {
    static DWRITE_RENDERING_MODE1_DEFAULT := 0
    static DWRITE_RENDERING_MODE1_ALIASED := 1
    static DWRITE_RENDERING_MODE1_GDI_CLASSIC := 2
    static DWRITE_RENDERING_MODE1_GDI_NATURAL := 3
    static DWRITE_RENDERING_MODE1_NATURAL := 4
    static DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC := 5
    static DWRITE_RENDERING_MODE1_OUTLINE := 6
    static DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC_DOWNSAMPLED := 7
}
struct IDWriteRenderingParams3 extends IDWriteRenderingParams2 {
    static IID := "{B7924BAA-391B-412A-8C5C-E44CC2D867DC}"
    GetRenderingMode1()
      => ComCall(10, this.p, DWRITE_RENDERING_MODE1)
}
struct IDWriteFactory3 extends IDWriteFactory2 {
    static IID := "{9A1B41C3-D3BB-466A-87FC-FE67556A3B65}"
    CreateGlyphRunAnalysis(glyphRun, transform?, renderingMode, measuringMode, gridFitMode, antialiasMode, baselineOriginX, baselineOriginY, glyphRunAnalysis)
      => ComCall(31, this.p, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_MATRIX.Ptr, transform?, DWRITE_RENDERING_MODE1, renderingMode, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GRID_FIT_MODE, gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE, antialiasMode, Float32, baselineOriginX, Float32, baselineOriginY, IDWriteGlyphRunAnalysis.Ptr, glyphRunAnalysis)
    CreateCustomRenderingParams(gamma, enhancedContrast, grayscaleEnhancedContrast, clearTypeLevel, pixelGeometry, renderingMode, gridFitMode, renderingParams)
      => ComCall(32, this.p, Float32, gamma, Float32, enhancedContrast, Float32, grayscaleEnhancedContrast, Float32, clearTypeLevel, DWRITE_PIXEL_GEOMETRY, pixelGeometry, DWRITE_RENDERING_MODE1, renderingMode, DWRITE_GRID_FIT_MODE, gridFitMode, IDWriteRenderingParams3.Ptr, renderingParams)
    CreateFontFaceReference(fontFile, faceIndex, fontSimulations, fontFaceReference)
      => ComCall(33, this.p, IDWriteFontFile, fontFile, UInt32, faceIndex, DWRITE_FONT_SIMULATIONS, fontSimulations, IDWriteFontFaceReference.Ptr, fontFaceReference)
    CreateFontFaceReference_2(filePath, lastWriteTime?, faceIndex, fontSimulations, fontFaceReference)
      => ComCall(34, this.p, "Str", filePath, FILETIME.Ptr, lastWriteTime?, UInt32, faceIndex, DWRITE_FONT_SIMULATIONS, fontSimulations, IDWriteFontFaceReference.Ptr, fontFaceReference)
    GetSystemFontSet(fontSet)
      => ComCall(35, this.p, IDWriteFontSet.Ptr, fontSet)
    CreateFontSetBuilder(fontSetBuilder)
      => ComCall(36, this.p, IDWriteFontSetBuilder.Ptr, fontSetBuilder)
    CreateFontCollectionFromFontSet(fontSet, fontCollection)
      => ComCall(37, this.p, IDWriteFontSet, fontSet, IDWriteFontCollection1.Ptr, fontCollection)
    GetSystemFontCollection(includeDownloadableFonts, fontCollection, checkForUpdates)
      => ComCall(38, this.p, BOOL, includeDownloadableFonts, IDWriteFontCollection1.Ptr, fontCollection, BOOL, checkForUpdates)
    GetFontDownloadQueue(fontDownloadQueue)
      => ComCall(39, this.p, IDWriteFontDownloadQueue.Ptr, fontDownloadQueue)
}
struct IDWriteFontSet extends IUnknown {
    static IID := "{53585141-D9F8-4095-8321-D73CF6BD116B}"
    GetFontCount()
      => ComCall(3, this.p, UInt32)
    GetFontFaceReference(listIndex, fontFaceReference)
      => ComCall(4, this.p, UInt32, listIndex, IDWriteFontFaceReference.Ptr, fontFaceReference)
    FindFontFaceReference(fontFaceReference, listIndex, exists)
      => ComCall(5, this.p, IDWriteFontFaceReference, fontFaceReference, UInt32.Ptr, listIndex, BOOL.Ptr, exists)
    FindFontFace(fontFace, listIndex, exists)
      => ComCall(6, this.p, IDWriteFontFace, fontFace, UInt32.Ptr, listIndex, BOOL.Ptr, exists)
    GetPropertyValues(propertyID, values)
      => ComCall(7, this.p, DWRITE_FONT_PROPERTY_ID, propertyID, IDWriteStringList.Ptr, values)
    GetPropertyValues_2(propertyID, preferredLocaleNames, values)
      => ComCall(8, this.p, DWRITE_FONT_PROPERTY_ID, propertyID, "Str", preferredLocaleNames, IDWriteStringList.Ptr, values)
    GetPropertyValues_3(listIndex, propertyId, exists, values)
      => ComCall(9, this.p, UInt32, listIndex, DWRITE_FONT_PROPERTY_ID, propertyId, BOOL.Ptr, exists, IDWriteLocalizedStrings.Ptr, values)
    GetPropertyOccurrenceCount(property, propertyOccurrenceCount)
      => ComCall(10, this.p, DWRITE_FONT_PROPERTY.Ptr, property, UInt32.Ptr, propertyOccurrenceCount)
    GetMatchingFonts(familyName, fontWeight, fontStretch, fontStyle, filteredSet)
      => ComCall(11, this.p, "Str", familyName, DWRITE_FONT_WEIGHT, fontWeight, DWRITE_FONT_STRETCH, fontStretch, DWRITE_FONT_STYLE, fontStyle, IDWriteFontSet.Ptr, filteredSet)
    GetMatchingFonts_2(properties, filteredSet)
      => ComCall(12, this.p, DWRITE_FONT_PROPERTY.Ptr, properties, UInt32, properties.Length, IDWriteFontSet.Ptr, filteredSet)
}
struct IDWriteFontSetBuilder extends IUnknown {
    static IID := "{2F642AFE-9C68-4F40-B8BE-457401AFCB3D}"
    AddFontFaceReference(fontFaceReference, properties)
      => ComCall(3, this.p, IDWriteFontFaceReference, fontFaceReference, DWRITE_FONT_PROPERTY.Ptr, properties, UInt32, properties.Length)
    AddFontFaceReference_2(fontFaceReference)
      => ComCall(4, this.p, IDWriteFontFaceReference, fontFaceReference)
    AddFontSet(fontSet)
      => ComCall(5, this.p, IDWriteFontSet, fontSet)
    CreateFontSet(fontSet)
      => ComCall(6, this.p, IDWriteFontSet.Ptr, fontSet)
}
struct IDWriteFontCollection1 extends IDWriteFontCollection {
    static IID := "{53585141-D9F8-4095-8321-D73CF6BD116C}"
    GetFontSet(fontSet)
      => ComCall(7, this.p, IDWriteFontSet.Ptr, fontSet)
    GetFontFamily(index, fontFamily)
      => ComCall(8, this.p, UInt32, index, IDWriteFontFamily1.Ptr, fontFamily)
}
struct IDWriteFontFamily1 extends IDWriteFontFamily {
    static IID := "{DA20D8EF-812A-4C43-9802-62EC4ABD7ADF}"
    GetFontLocality(listIndex)
      => ComCall(9, this.p, UInt32, listIndex, DWRITE_LOCALITY)
    GetFont(listIndex, font)
      => ComCall(10, this.p, UInt32, listIndex, IDWriteFont3.Ptr, font)
    GetFontFaceReference(listIndex, fontFaceReference)
      => ComCall(11, this.p, UInt32, listIndex, IDWriteFontFaceReference.Ptr, fontFaceReference)
}
struct IDWriteFontList1 extends IDWriteFontList {
    static IID := "{DA20D8EF-812A-4C43-9802-62EC4ABD7ADE}"
    GetFontLocality(listIndex)
      => ComCall(6, this.p, UInt32, listIndex, DWRITE_LOCALITY)
    GetFont(listIndex, font)
      => ComCall(7, this.p, UInt32, listIndex, IDWriteFont3.Ptr, font)
    GetFontFaceReference(listIndex, fontFaceReference)
      => ComCall(8, this.p, UInt32, listIndex, IDWriteFontFaceReference.Ptr, fontFaceReference)
}
struct IDWriteFontFaceReference extends IUnknown {
    static IID := "{5E7FA7CA-DDE3-424C-89F0-9FCD6FED58CD}"
    CreateFontFace(fontFace)
      => ComCall(3, this.p, IDWriteFontFace3.Ptr, fontFace)
    CreateFontFaceWithSimulations(fontFaceSimulationFlags, fontFace)
      => ComCall(4, this.p, DWRITE_FONT_SIMULATIONS, fontFaceSimulationFlags, IDWriteFontFace3.Ptr, fontFace)
    Equals(fontFaceReference)
      => ComCall(5, this.p, IDWriteFontFaceReference, fontFaceReference, BOOL)
    GetFontFaceIndex()
      => ComCall(6, this.p, UInt32)
    GetSimulations()
      => ComCall(7, this.p, DWRITE_FONT_SIMULATIONS)
    GetFontFile(fontFile)
      => ComCall(8, this.p, IDWriteFontFile.Ptr, fontFile)
    GetLocalFileSize()
      => ComCall(9, this.p, Int64)
    GetFileSize()
      => ComCall(10, this.p, Int64)
    GetFileTime(lastWriteTime)
      => ComCall(11, this.p, FILETIME.Ptr, lastWriteTime)
    GetLocality()
      => ComCall(12, this.p, DWRITE_LOCALITY)
    EnqueueFontDownloadRequest()
      => ComCall(13, this.p)
    EnqueueCharacterDownloadRequest(characters)
      => ComCall(14, this.p, "Str", characters, UInt32, characters.Length)
    EnqueueGlyphDownloadRequest(glyphIndices)
      => ComCall(15, this.p, UInt16.Ptr, glyphIndices, UInt32, glyphIndices.Length)
    EnqueueFileFragmentDownloadRequest(fileOffset, fragmentSize)
      => ComCall(16, this.p, Int64, fileOffset, Int64, fragmentSize)
}
struct IDWriteFont3 extends IDWriteFont2 {
    static IID := "{29748ED6-8C9C-4A6A-BE0B-D912E8538944}"
    CreateFontFace(fontFace)
      => ComCall(19, this.p, IDWriteFontFace3.Ptr, fontFace)
    Equals(font)
      => ComCall(20, this.p, IDWriteFont, font, BOOL)
    GetFontFaceReference(fontFaceReference)
      => ComCall(21, this.p, IDWriteFontFaceReference.Ptr, fontFaceReference)
    HasCharacter(unicodeValue)
      => ComCall(22, this.p, UInt32, unicodeValue, BOOL)
    GetLocality()
      => ComCall(23, this.p, DWRITE_LOCALITY)
}
struct IDWriteFontFace3 extends IDWriteFontFace2 {
    static IID := "{D37D7598-09BE-4222-A236-2081341CC1F2}"
    GetFontFaceReference(fontFaceReference)
      => ComCall(35, this.p, IDWriteFontFaceReference.Ptr, fontFaceReference)
    GetPanose(panose)
      => ComCall(36, this.p, DWRITE_PANOSE.Ptr, panose, "void")
    GetWeight()
      => ComCall(37, this.p, DWRITE_FONT_WEIGHT)
    GetStretch()
      => ComCall(38, this.p, DWRITE_FONT_STRETCH)
    GetStyle()
      => ComCall(39, this.p, DWRITE_FONT_STYLE)
    GetFamilyNames(names)
      => ComCall(40, this.p, IDWriteLocalizedStrings.Ptr, names)
    GetFaceNames(names)
      => ComCall(41, this.p, IDWriteLocalizedStrings.Ptr, names)
    GetInformationalStrings(informationalStringID, informationalStrings, exists)
      => ComCall(42, this.p, DWRITE_INFORMATIONAL_STRING_ID, informationalStringID, IDWriteLocalizedStrings.Ptr, informationalStrings, BOOL.Ptr, exists)
    HasCharacter(unicodeValue)
      => ComCall(43, this.p, UInt32, unicodeValue, BOOL)
    GetRecommendedRenderingMode(fontEmSize, dpiX, dpiY, transform?, isSideways, outlineThreshold, measuringMode, renderingParams?, renderingMode, gridFitMode)
      => ComCall(44, this.p, Float32, fontEmSize, Float32, dpiX, Float32, dpiY, DWRITE_MATRIX.Ptr, transform?, BOOL, isSideways, DWRITE_OUTLINE_THRESHOLD, outlineThreshold, DWRITE_MEASURING_MODE, measuringMode, IDWriteRenderingParams, renderingParams?, DWRITE_RENDERING_MODE1.Ptr, renderingMode, DWRITE_GRID_FIT_MODE.Ptr, gridFitMode)
    IsCharacterLocal(unicodeValue)
      => ComCall(45, this.p, UInt32, unicodeValue, BOOL)
    IsGlyphLocal(glyphId)
      => ComCall(46, this.p, UInt16, glyphId, BOOL)
    AreCharactersLocal(characters, enqueueIfNotLocal, isLocal)
      => ComCall(47, this.p, "Str", characters, UInt32, characters.Length, BOOL, enqueueIfNotLocal, BOOL.Ptr, isLocal)
    AreGlyphsLocal(glyphIndices, enqueueIfNotLocal, isLocal)
      => ComCall(48, this.p, UInt16.Ptr, glyphIndices, UInt32, glyphIndices.Length, BOOL, enqueueIfNotLocal, BOOL.Ptr, isLocal)
}
struct IDWriteStringList extends IUnknown {
    static IID := "{CFEE3140-1157-47CA-8B85-31BFCF3F2D0E}"
    GetCount()
      => ComCall(3, this.p, UInt32)
    GetLocaleNameLength(listIndex, length)
      => ComCall(4, this.p, UInt32, listIndex, UInt32.Ptr, length)
    GetLocaleName(listIndex, localeName)
      => ComCall(5, this.p, UInt32, listIndex, PWSTR, localeName, UInt32, localeName.Length)
    GetStringLength(listIndex, length)
      => ComCall(6, this.p, UInt32, listIndex, UInt32.Ptr, length)
    GetString(listIndex, stringBuffer)
      => ComCall(7, this.p, UInt32, listIndex, PWSTR, stringBuffer, UInt32, stringBuffer.Length)
}
struct IDWriteFontDownloadListener extends IUnknown {
    static IID := "{B06FE5B9-43EC-4393-881B-DBE4DC72FDA7}"
    DownloadCompleted(downloadQueue, context?, downloadResult)
      => ComCall(3, this.p, IDWriteFontDownloadQueue, downloadQueue, IUnknown, context?, HRESULT, downloadResult, "void")
}
struct IDWriteFontDownloadQueue extends IUnknown {
    static IID := "{B71E6052-5AEA-4FA3-832E-F60D431F7E91}"
    AddListener(listener, token)
      => ComCall(3, this.p, IDWriteFontDownloadListener, listener, UInt32.Ptr, token)
    RemoveListener(token)
      => ComCall(4, this.p, UInt32, token)
    IsEmpty()
      => ComCall(5, this.p, BOOL)
    BeginDownload(context?)
      => ComCall(6, this.p, IUnknown, context?)
    CancelDownload()
      => ComCall(7, this.p)
    GetGenerationCount()
      => ComCall(8, this.p, Int64)
}
struct IDWriteGdiInterop1 extends IDWriteGdiInterop {
    static IID := "{4556BE70-3ABD-4F70-90BE-421780A6F515}"
    CreateFontFromLOGFONT(logFont, fontCollection?, font)
      => ComCall(8, this.p, LOGFONTW.Ptr, logFont, IDWriteFontCollection, fontCollection?, IDWriteFont.Ptr, font)
    GetFontSignature(fontFace, fontSignature)
      => ComCall(9, this.p, IDWriteFontFace, fontFace, FONTSIGNATURE.Ptr, fontSignature)
    GetFontSignature_2(font, fontSignature)
      => ComCall(10, this.p, IDWriteFont, font, FONTSIGNATURE.Ptr, fontSignature)
    GetMatchingFontsByLOGFONT(logFont, fontSet, filteredSet)
      => ComCall(11, this.p, LOGFONTA.Ptr, logFont, IDWriteFontSet, fontSet, IDWriteFontSet.Ptr, filteredSet)
}
struct DWRITE_LINE_METRICS1 {
    Base : DWRITE_LINE_METRICS
    leadingBefore : Float32
    leadingAfter : Float32
}
struct DWRITE_FONT_LINE_GAP_USAGE extends Int32 {
    static DWRITE_FONT_LINE_GAP_USAGE_DEFAULT := 0
    static DWRITE_FONT_LINE_GAP_USAGE_DISABLED := 1
    static DWRITE_FONT_LINE_GAP_USAGE_ENABLED := 2
}
struct DWRITE_LINE_SPACING {
    method : DWRITE_LINE_SPACING_METHOD
    height : Float32
    baseline : Float32
    leadingBefore : Float32
    fontLineGapUsage : DWRITE_FONT_LINE_GAP_USAGE
}
struct IDWriteTextFormat2 extends IDWriteTextFormat1 {
    static IID := "{F67E0EDD-9E3D-4ECC-8C32-4183253DFE70}"
    SetLineSpacing(lineSpacingOptions)
      => ComCall(36, this.p, DWRITE_LINE_SPACING.Ptr, lineSpacingOptions)
    GetLineSpacing(lineSpacingOptions)
      => ComCall(37, this.p, DWRITE_LINE_SPACING.Ptr, lineSpacingOptions)
}
struct IDWriteTextLayout3 extends IDWriteTextLayout2 {
    static IID := "{07DDCD52-020E-4DE8-AC33-6C953D83F92D}"
    InvalidateLayout()
      => ComCall(80, this.p)
    SetLineSpacing(lineSpacingOptions)
      => ComCall(81, this.p, DWRITE_LINE_SPACING.Ptr, lineSpacingOptions)
    GetLineSpacing(lineSpacingOptions)
      => ComCall(82, this.p, DWRITE_LINE_SPACING.Ptr, lineSpacingOptions)
    GetLineMetrics(lineMetrics?, actualLineCount)
      => ComCall(83, this.p, DWRITE_LINE_METRICS1.Ptr, lineMetrics?, UInt32, lineMetrics?.Length ?? 0, UInt32.Ptr, actualLineCount)
}
struct DWRITE_COLOR_GLYPH_RUN1 {
    Base : DWRITE_COLOR_GLYPH_RUN
    glyphImageFormat : DWRITE_GLYPH_IMAGE_FORMATS
    measuringMode : DWRITE_MEASURING_MODE
}
struct DWRITE_GLYPH_IMAGE_DATA {
    imageData : Struct.Ptr
    imageDataSize : UInt32
    uniqueDataId : UInt32
    pixelsPerEm : UInt32
    pixelSize : D2D_SIZE_U
    horizontalLeftOrigin : POINT
    horizontalRightOrigin : POINT
    verticalTopOrigin : POINT
    verticalBottomOrigin : POINT
}
struct IDWriteColorGlyphRunEnumerator1 extends IDWriteColorGlyphRunEnumerator {
    static IID := "{7C5F86DA-C7A1-4F05-B8E1-55A179FE5A35}"
    GetCurrentRun(colorGlyphRun)
      => ComCall(5, this.p, DWRITE_COLOR_GLYPH_RUN1.Ptr.Ptr, colorGlyphRun)
}
struct IDWriteFontFace4 extends IDWriteFontFace3 {
    static IID := "{27F2A904-4EB8-441D-9678-0563F53E3E2F}"
    GetGlyphImageFormats(glyphId, pixelsPerEmFirst, pixelsPerEmLast, glyphImageFormats)
      => ComCall(49, this.p, UInt16, glyphId, UInt32, pixelsPerEmFirst, UInt32, pixelsPerEmLast, DWRITE_GLYPH_IMAGE_FORMATS.Ptr, glyphImageFormats)
    GetGlyphImageFormats_2()
      => ComCall(50, this.p, DWRITE_GLYPH_IMAGE_FORMATS)
    GetGlyphImageData(glyphId, pixelsPerEm, glyphImageFormat, glyphData, glyphDataContext)
      => ComCall(51, this.p, UInt16, glyphId, UInt32, pixelsPerEm, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, DWRITE_GLYPH_IMAGE_DATA.Ptr, glyphData, Struct.Ptr.Ptr, glyphDataContext)
    ReleaseGlyphImageData(glyphDataContext)
      => ComCall(52, this.p, Struct.Ptr, glyphDataContext, "void")
}
struct IDWriteFactory4 extends IDWriteFactory3 {
    static IID := "{4B0B5BD3-0797-4549-8AC5-FE915CC53856}"
    TranslateColorGlyphRun(baselineOrigin, glyphRun, glyphRunDescription?, desiredGlyphImageFormats, measuringMode, worldAndDpiTransform?, colorPaletteIndex, colorLayers)
      => ComCall(40, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, DWRITE_GLYPH_IMAGE_FORMATS, desiredGlyphImageFormats, DWRITE_MEASURING_MODE, measuringMode, DWRITE_MATRIX.Ptr, worldAndDpiTransform?, UInt32, colorPaletteIndex, IDWriteColorGlyphRunEnumerator1.Ptr, colorLayers)
    ComputeGlyphOrigins(glyphRun, baselineOrigin, glyphOrigins)
      => ComCall(41, this.p, DWRITE_GLYPH_RUN.Ptr, glyphRun, D2D_POINT_2F, baselineOrigin, D2D_POINT_2F.Ptr, glyphOrigins)
    ComputeGlyphOrigins_2(glyphRun, measuringMode, baselineOrigin, worldAndDpiTransform?, glyphOrigins)
      => ComCall(42, this.p, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_MEASURING_MODE, measuringMode, D2D_POINT_2F, baselineOrigin, DWRITE_MATRIX.Ptr, worldAndDpiTransform?, D2D_POINT_2F.Ptr, glyphOrigins)
}
struct IDWriteFontSetBuilder1 extends IDWriteFontSetBuilder {
    static IID := "{3FF7715F-3CDC-4DC6-9B72-EC5621DCCAFD}"
    AddFontFile(fontFile)
      => ComCall(7, this.p, IDWriteFontFile, fontFile)
}
struct IDWriteAsyncResult extends IUnknown {
    static IID := "{CE25F8FD-863B-4D13-9651-C1F88DC73FE2}"
    GetWaitHandle()
      => ComCall(3, this.p, HANDLE)
    GetResult()
      => ComCall(4, this.p)
}
struct DWRITE_FILE_FRAGMENT {
    fileOffset : Int64
    fragmentSize : Int64
}
struct IDWriteRemoteFontFileStream extends IDWriteFontFileStream {
    static IID := "{4DB3757A-2C72-4ED9-B2B6-1ABABE1AFF9C}"
    GetLocalFileSize(localFileSize)
      => ComCall(7, this.p, Int64.Ptr, localFileSize)
    GetFileFragmentLocality(fileOffset, fragmentSize, isLocal, partialSize)
      => ComCall(8, this.p, Int64, fileOffset, Int64, fragmentSize, BOOL.Ptr, isLocal, Int64.Ptr, partialSize)
    GetLocality()
      => ComCall(9, this.p, DWRITE_LOCALITY)
    BeginDownload(downloadOperationID, fileFragments, asyncResult)
      => ComCall(10, this.p, GUID.Ptr, downloadOperationID, DWRITE_FILE_FRAGMENT.Ptr, fileFragments, UInt32, fileFragments.Length, IDWriteAsyncResult.Ptr, asyncResult)
}
struct DWRITE_CONTAINER_TYPE extends Int32 {
    static DWRITE_CONTAINER_TYPE_UNKNOWN := 0
    static DWRITE_CONTAINER_TYPE_WOFF := 1
    static DWRITE_CONTAINER_TYPE_WOFF2 := 2
}
struct IDWriteRemoteFontFileLoader extends IDWriteFontFileLoader {
    static IID := "{68648C83-6EDE-46C0-AB46-20083A887FDE}"
    CreateRemoteStreamFromKey(fontFileReferenceKey, fontFileStream)
      => ComCall(4, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, IDWriteRemoteFontFileStream.Ptr, fontFileStream)
    GetLocalityFromKey(fontFileReferenceKey, locality)
      => ComCall(5, this.p, Struct.Ptr, fontFileReferenceKey, UInt32, fontFileReferenceKey.Size, DWRITE_LOCALITY.Ptr, locality)
    CreateFontFileReferenceFromUrl(factory, baseUrl?, fontFileUrl, fontFile)
      => ComCall(6, this.p, IDWriteFactory, factory, "Str", baseUrl?, "Str", fontFileUrl, IDWriteFontFile.Ptr, fontFile)
}
struct IDWriteInMemoryFontFileLoader extends IDWriteFontFileLoader {
    static IID := "{DC102F47-A12D-4B1C-822D-9E117E33043F}"
    CreateInMemoryFontFileReference(factory, fontData, ownerObject?, fontFile)
      => ComCall(4, this.p, IDWriteFactory, factory, Struct.Ptr, fontData, UInt32, fontData.Size, IUnknown, ownerObject?, IDWriteFontFile.Ptr, fontFile)
    GetFileCount()
      => ComCall(5, this.p, UInt32)
}
struct IDWriteFactory5 extends IDWriteFactory4 {
    static IID := "{958DB99A-BE2A-4F09-AF7D-65189803D1D3}"
    CreateFontSetBuilder(fontSetBuilder)
      => ComCall(43, this.p, IDWriteFontSetBuilder1.Ptr, fontSetBuilder)
    CreateInMemoryFontFileLoader(newLoader)
      => ComCall(44, this.p, IDWriteInMemoryFontFileLoader.Ptr, newLoader)
    CreateHttpFontFileLoader(referrerUrl?, extraHeaders?, newLoader)
      => ComCall(45, this.p, "Str", referrerUrl?, "Str", extraHeaders?, IDWriteRemoteFontFileLoader.Ptr, newLoader)
    AnalyzeContainerType(fileData)
      => ComCall(46, this.p, Struct.Ptr, fileData, UInt32, fileData.Size, DWRITE_CONTAINER_TYPE)
    UnpackFontFile(containerType, fileData, unpackedFontStream)
      => ComCall(47, this.p, DWRITE_CONTAINER_TYPE, containerType, Struct.Ptr, fileData, UInt32, fileData.Size, IDWriteFontFileStream.Ptr, unpackedFontStream)
}
struct DWRITE_FONT_AXIS_VALUE {
    axisTag : DWRITE_FONT_AXIS_TAG
    value : Float32
}
struct DWRITE_FONT_AXIS_RANGE {
    axisTag : DWRITE_FONT_AXIS_TAG
    minValue : Float32
    maxValue : Float32
}
struct DWRITE_FONT_FAMILY_MODEL extends Int32 {
    static DWRITE_FONT_FAMILY_MODEL_TYPOGRAPHIC := 0
    static DWRITE_FONT_FAMILY_MODEL_WEIGHT_STRETCH_STYLE := 1
}
struct DWRITE_AUTOMATIC_FONT_AXES extends Int32 {
    static DWRITE_AUTOMATIC_FONT_AXES_NONE := 0
    static DWRITE_AUTOMATIC_FONT_AXES_OPTICAL_SIZE := 1
}
struct DWRITE_FONT_AXIS_ATTRIBUTES extends Int32 {
    static DWRITE_FONT_AXIS_ATTRIBUTES_NONE := 0
    static DWRITE_FONT_AXIS_ATTRIBUTES_VARIABLE := 1
    static DWRITE_FONT_AXIS_ATTRIBUTES_HIDDEN := 2
}
struct IDWriteFactory6 extends IDWriteFactory5 {
    static IID := "{F3744D80-21F7-42EB-B35D-995BC72FC223}"
    CreateFontFaceReference(fontFile, faceIndex, fontSimulations, fontAxisValues, fontFaceReference)
      => ComCall(48, this.p, IDWriteFontFile, fontFile, UInt32, faceIndex, DWRITE_FONT_SIMULATIONS, fontSimulations, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontFaceReference1.Ptr, fontFaceReference)
    CreateFontResource(fontFile, faceIndex, fontResource)
      => ComCall(49, this.p, IDWriteFontFile, fontFile, UInt32, faceIndex, IDWriteFontResource.Ptr, fontResource)
    GetSystemFontSet(includeDownloadableFonts, fontSet)
      => ComCall(50, this.p, BOOL, includeDownloadableFonts, IDWriteFontSet1.Ptr, fontSet)
    GetSystemFontCollection(includeDownloadableFonts, fontFamilyModel, fontCollection)
      => ComCall(51, this.p, BOOL, includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL, fontFamilyModel, IDWriteFontCollection2.Ptr, fontCollection)
    CreateFontCollectionFromFontSet(fontSet, fontFamilyModel, fontCollection)
      => ComCall(52, this.p, IDWriteFontSet, fontSet, DWRITE_FONT_FAMILY_MODEL, fontFamilyModel, IDWriteFontCollection2.Ptr, fontCollection)
    CreateFontSetBuilder(fontSetBuilder)
      => ComCall(53, this.p, IDWriteFontSetBuilder2.Ptr, fontSetBuilder)
    CreateTextFormat(fontFamilyName, fontCollection?, fontAxisValues, fontSize, localeName, textFormat)
      => ComCall(54, this.p, "Str", fontFamilyName, IDWriteFontCollection, fontCollection?, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, Float32, fontSize, "Str", localeName, IDWriteTextFormat3.Ptr, textFormat)
}
struct IDWriteFontFace5 extends IDWriteFontFace4 {
    static IID := "{98EFF3A5-B667-479A-B145-E2FA5B9FDC29}"
    GetFontAxisValueCount()
      => ComCall(53, this.p, UInt32)
    GetFontAxisValues(fontAxisValues)
      => ComCall(54, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length)
    HasVariations()
      => ComCall(55, this.p, BOOL)
    GetFontResource(fontResource)
      => ComCall(56, this.p, IDWriteFontResource.Ptr, fontResource)
    Equals(fontFace)
      => ComCall(57, this.p, IDWriteFontFace, fontFace, BOOL)
}
struct IDWriteFontResource extends IUnknown {
    static IID := "{1F803A76-6871-48E8-987F-B975551C50F2}"
    GetFontFile(fontFile)
      => ComCall(3, this.p, IDWriteFontFile.Ptr, fontFile)
    GetFontFaceIndex()
      => ComCall(4, this.p, UInt32)
    GetFontAxisCount()
      => ComCall(5, this.p, UInt32)
    GetDefaultFontAxisValues(fontAxisValues)
      => ComCall(6, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length)
    GetFontAxisRanges(fontAxisRanges)
      => ComCall(7, this.p, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length)
    GetFontAxisAttributes(axisIndex)
      => ComCall(8, this.p, UInt32, axisIndex, DWRITE_FONT_AXIS_ATTRIBUTES)
    GetAxisNames(axisIndex, names)
      => ComCall(9, this.p, UInt32, axisIndex, IDWriteLocalizedStrings.Ptr, names)
    GetAxisValueNameCount(axisIndex)
      => ComCall(10, this.p, UInt32, axisIndex, UInt32)
    GetAxisValueNames(axisIndex, axisValueIndex, fontAxisRange, names)
      => ComCall(11, this.p, UInt32, axisIndex, UInt32, axisValueIndex, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRange, IDWriteLocalizedStrings.Ptr, names)
    HasVariations()
      => ComCall(12, this.p, BOOL)
    CreateFontFace(fontSimulations, fontAxisValues, fontFace)
      => ComCall(13, this.p, DWRITE_FONT_SIMULATIONS, fontSimulations, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontFace5.Ptr, fontFace)
    CreateFontFaceReference(fontSimulations, fontAxisValues, fontFaceReference)
      => ComCall(14, this.p, DWRITE_FONT_SIMULATIONS, fontSimulations, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontFaceReference1.Ptr, fontFaceReference)
}
struct IDWriteFontFaceReference1 extends IDWriteFontFaceReference {
    static IID := "{C081FE77-2FD1-41AC-A5A3-34983C4BA61A}"
    CreateFontFace(fontFace)
      => ComCall(17, this.p, IDWriteFontFace5.Ptr, fontFace)
    GetFontAxisValueCount()
      => ComCall(18, this.p, UInt32)
    GetFontAxisValues(fontAxisValues)
      => ComCall(19, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length)
}
struct IDWriteFontSetBuilder2 extends IDWriteFontSetBuilder1 {
    static IID := "{EE5BA612-B131-463C-8F4F-3189B9401E45}"
    AddFont(fontFile, fontFaceIndex, fontSimulations, fontAxisValues, fontAxisRanges, properties)
      => ComCall(8, this.p, IDWriteFontFile, fontFile, UInt32, fontFaceIndex, DWRITE_FONT_SIMULATIONS, fontSimulations, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length, DWRITE_FONT_PROPERTY.Ptr, properties, UInt32, properties.Length)
    AddFontFile(filePath)
      => ComCall(9, this.p, "Str", filePath)
}
struct IDWriteFontSet1 extends IDWriteFontSet {
    static IID := "{7E9FDA85-6C92-4053-BC47-7AE3530DB4D3}"
    GetMatchingFonts(fontProperty?, fontAxisValues, matchingFonts)
      => ComCall(13, this.p, DWRITE_FONT_PROPERTY.Ptr, fontProperty?, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontSet1.Ptr, matchingFonts)
    GetFirstFontResources(filteredFontSet)
      => ComCall(14, this.p, IDWriteFontSet1.Ptr, filteredFontSet)
    GetFilteredFonts(indices, filteredFontSet)
      => ComCall(15, this.p, UInt32.Ptr, indices, UInt32, indices.Length, IDWriteFontSet1.Ptr, filteredFontSet)
    GetFilteredFonts_2(fontAxisRanges, selectAnyRange, filteredFontSet)
      => ComCall(16, this.p, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length, BOOL, selectAnyRange, IDWriteFontSet1.Ptr, filteredFontSet)
    GetFilteredFonts_3(properties?, selectAnyProperty, filteredFontSet)
      => ComCall(17, this.p, DWRITE_FONT_PROPERTY.Ptr, properties?, UInt32, properties?.Length ?? 0, BOOL, selectAnyProperty, IDWriteFontSet1.Ptr, filteredFontSet)
    GetFilteredFontIndices(fontAxisRanges, selectAnyRange, indices, actualIndexCount)
      => ComCall(18, this.p, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length, BOOL, selectAnyRange, UInt32.Ptr, indices, UInt32, indices.Length, UInt32.Ptr, actualIndexCount)
    GetFilteredFontIndices_2(properties, selectAnyProperty, indices, actualIndexCount)
      => ComCall(19, this.p, DWRITE_FONT_PROPERTY.Ptr, properties, UInt32, properties.Length, BOOL, selectAnyProperty, UInt32.Ptr, indices, UInt32, indices.Length, UInt32.Ptr, actualIndexCount)
    GetFontAxisRanges(listIndex, fontAxisRanges, actualFontAxisRangeCount)
      => ComCall(20, this.p, UInt32, listIndex, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length, UInt32.Ptr, actualFontAxisRangeCount)
    GetFontAxisRanges_2(fontAxisRanges, actualFontAxisRangeCount)
      => ComCall(21, this.p, DWRITE_FONT_AXIS_RANGE.Ptr, fontAxisRanges, UInt32, fontAxisRanges.Length, UInt32.Ptr, actualFontAxisRangeCount)
    GetFontFaceReference(listIndex, fontFaceReference)
      => ComCall(22, this.p, UInt32, listIndex, IDWriteFontFaceReference1.Ptr, fontFaceReference)
    CreateFontResource(listIndex, fontResource)
      => ComCall(23, this.p, UInt32, listIndex, IDWriteFontResource.Ptr, fontResource)
    CreateFontFace(listIndex, fontFace)
      => ComCall(24, this.p, UInt32, listIndex, IDWriteFontFace5.Ptr, fontFace)
    GetFontLocality(listIndex)
      => ComCall(25, this.p, UInt32, listIndex, DWRITE_LOCALITY)
}
struct IDWriteFontList2 extends IDWriteFontList1 {
    static IID := "{C0763A34-77AF-445A-B735-08C37B0A5BF5}"
    GetFontSet(fontSet)
      => ComCall(9, this.p, IDWriteFontSet1.Ptr, fontSet)
}
struct IDWriteFontFamily2 extends IDWriteFontFamily1 {
    static IID := "{3ED49E77-A398-4261-B9CF-C126C2131EF3}"
    GetMatchingFonts(fontAxisValues, matchingFonts)
      => ComCall(12, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontList2.Ptr, matchingFonts)
    GetFontSet(fontSet)
      => ComCall(13, this.p, IDWriteFontSet1.Ptr, fontSet)
}
struct IDWriteFontCollection2 extends IDWriteFontCollection1 {
    static IID := "{514039C6-4617-4064-BF8B-92EA83E506E0}"
    GetFontFamily(index, fontFamily)
      => ComCall(9, this.p, UInt32, index, IDWriteFontFamily2.Ptr, fontFamily)
    GetMatchingFonts(familyName, fontAxisValues, fontList)
      => ComCall(10, this.p, "Str", familyName, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, IDWriteFontList2.Ptr, fontList)
    GetFontFamilyModel()
      => ComCall(11, this.p, DWRITE_FONT_FAMILY_MODEL)
    GetFontSet(fontSet)
      => ComCall(12, this.p, IDWriteFontSet1.Ptr, fontSet)
}
struct IDWriteTextLayout4 extends IDWriteTextLayout3 {
    static IID := "{05A9BF42-223F-4441-B5FB-8263685F55E9}"
    SetFontAxisValues(fontAxisValues, textRange)
      => ComCall(84, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, DWRITE_TEXT_RANGE, textRange)
    GetFontAxisValueCount(currentPosition)
      => ComCall(85, this.p, UInt32, currentPosition, UInt32)
    GetFontAxisValues(currentPosition, fontAxisValues, textRange?)
      => ComCall(86, this.p, UInt32, currentPosition, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, DWRITE_TEXT_RANGE.Ptr, textRange?)
    GetAutomaticFontAxes()
      => ComCall(87, this.p, DWRITE_AUTOMATIC_FONT_AXES)
    SetAutomaticFontAxes(automaticFontAxes)
      => ComCall(88, this.p, DWRITE_AUTOMATIC_FONT_AXES, automaticFontAxes)
}
struct IDWriteTextFormat3 extends IDWriteTextFormat2 {
    static IID := "{6D3B5641-E550-430D-A85B-B7BF48A93427}"
    SetFontAxisValues(fontAxisValues)
      => ComCall(38, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length)
    GetFontAxisValueCount()
      => ComCall(39, this.p, UInt32)
    GetFontAxisValues(fontAxisValues)
      => ComCall(40, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length)
    GetAutomaticFontAxes()
      => ComCall(41, this.p, DWRITE_AUTOMATIC_FONT_AXES)
    SetAutomaticFontAxes(automaticFontAxes)
      => ComCall(42, this.p, DWRITE_AUTOMATIC_FONT_AXES, automaticFontAxes)
}
struct IDWriteFontFallback1 extends IDWriteFontFallback {
    static IID := "{2397599D-DD0D-4681-BD6A-F4F31EAADE77}"
    MapCharacters(analysisSource, textPosition, textLength, baseFontCollection?, baseFamilyName?, fontAxisValues, mappedLength, scale, mappedFontFace)
      => ComCall(4, this.p, IDWriteTextAnalysisSource, analysisSource, UInt32, textPosition, UInt32, textLength, IDWriteFontCollection, baseFontCollection?, "Str", baseFamilyName?, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, UInt32.Ptr, mappedLength, Float32.Ptr, scale, IDWriteFontFace5.Ptr, mappedFontFace)
}
struct IDWriteFontSet2 extends IDWriteFontSet1 {
    static IID := "{DC7EAD19-E54C-43AF-B2DA-4E2B79BA3F7F}"
    GetExpirationEvent()
      => ComCall(26, this.p, HANDLE)
}
struct IDWriteFontCollection3 extends IDWriteFontCollection2 {
    static IID := "{A4D055A6-F9E3-4E25-93B7-9E309F3AF8E9}"
    GetExpirationEvent()
      => ComCall(13, this.p, HANDLE)
}
struct IDWriteFactory7 extends IDWriteFactory6 {
    static IID := "{35D0E0B3-9076-4D2E-A016-A91B568A06B4}"
    GetSystemFontSet(includeDownloadableFonts, fontSet)
      => ComCall(55, this.p, BOOL, includeDownloadableFonts, IDWriteFontSet2.Ptr, fontSet)
    GetSystemFontCollection(includeDownloadableFonts, fontFamilyModel, fontCollection)
      => ComCall(56, this.p, BOOL, includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL, fontFamilyModel, IDWriteFontCollection3.Ptr, fontCollection)
}
struct DWRITE_FONT_SOURCE_TYPE extends Int32 {
    static DWRITE_FONT_SOURCE_TYPE_UNKNOWN := 0
    static DWRITE_FONT_SOURCE_TYPE_PER_MACHINE := 1
    static DWRITE_FONT_SOURCE_TYPE_PER_USER := 2
    static DWRITE_FONT_SOURCE_TYPE_APPX_PACKAGE := 3
    static DWRITE_FONT_SOURCE_TYPE_REMOTE_FONT_PROVIDER := 4
}
struct IDWriteFontSet3 extends IDWriteFontSet2 {
    static IID := "{7C073EF2-A7F4-4045-8C32-8AB8AE640F90}"
    GetFontSourceType(fontIndex)
      => ComCall(27, this.p, UInt32, fontIndex, DWRITE_FONT_SOURCE_TYPE)
    GetFontSourceNameLength(listIndex)
      => ComCall(28, this.p, UInt32, listIndex, UInt32)
    GetFontSourceName(listIndex, stringBuffer)
      => ComCall(29, this.p, UInt32, listIndex, PWSTR, stringBuffer, UInt32, stringBuffer.Length)
}
struct IDWriteFontFace6 extends IDWriteFontFace5 {
    static IID := "{C4B1FE1B-6E84-47D5-B54C-A597981B06AD}"
    GetFamilyNames(fontFamilyModel, names)
      => ComCall(58, this.p, DWRITE_FONT_FAMILY_MODEL, fontFamilyModel, IDWriteLocalizedStrings.Ptr, names)
    GetFaceNames(fontFamilyModel, names)
      => ComCall(59, this.p, DWRITE_FONT_FAMILY_MODEL, fontFamilyModel, IDWriteLocalizedStrings.Ptr, names)
}
struct IDWriteFontSet4 extends IDWriteFontSet3 {
    static IID := "{EEC175FC-BEA9-4C86-8B53-CCBDD7DF0C82}"
    ConvertWeightStretchStyleToFontAxisValues(inputAxisValues?, fontWeight, fontStretch, fontStyle, fontSize, outputAxisValues)
      => ComCall(30, this.p, DWRITE_FONT_AXIS_VALUE.Ptr, inputAxisValues?, UInt32, inputAxisValues?.Length ?? 0, DWRITE_FONT_WEIGHT, fontWeight, DWRITE_FONT_STRETCH, fontStretch, DWRITE_FONT_STYLE, fontStyle, Float32, fontSize, DWRITE_FONT_AXIS_VALUE.Ptr, outputAxisValues, UInt32)
    GetMatchingFonts(familyName, fontAxisValues, allowedSimulations, matchingFonts)
      => ComCall(31, this.p, "Str", familyName, DWRITE_FONT_AXIS_VALUE.Ptr, fontAxisValues, UInt32, fontAxisValues.Length, DWRITE_FONT_SIMULATIONS, allowedSimulations, IDWriteFontSet4.Ptr, matchingFonts)
}
struct DWRITE_BITMAP_DATA_BGRA32 {
    width : UInt32
    height : UInt32
    pixels : UInt32.Ptr
}
struct IDWriteBitmapRenderTarget2 extends IDWriteBitmapRenderTarget1 {
    static IID := "{C553A742-FC01-44DA-A66E-B8B9ED6C3995}"
    GetBitmapData(bitmapData)
      => ComCall(13, this.p, DWRITE_BITMAP_DATA_BGRA32.Ptr, bitmapData)
}
struct DWRITE_PAINT_FEATURE_LEVEL extends Int32 {
    static DWRITE_PAINT_FEATURE_LEVEL_NONE := 0
    static DWRITE_PAINT_FEATURE_LEVEL_COLR_V0 := 1
    static DWRITE_PAINT_FEATURE_LEVEL_COLR_V1 := 2
}
struct DWRITE_PAINT_ATTRIBUTES extends Int32 {
    static DWRITE_PAINT_ATTRIBUTES_NONE := 0
    static DWRITE_PAINT_ATTRIBUTES_USES_PALETTE := 1
    static DWRITE_PAINT_ATTRIBUTES_USES_TEXT_COLOR := 2
}
struct DWRITE_PAINT_COLOR {
    value : DWRITE_COLOR_F
    paletteEntryIndex : UInt16
    alphaMultiplier : Float32
    colorAttributes : DWRITE_PAINT_ATTRIBUTES
}
struct DWRITE_COLOR_COMPOSITE_MODE extends Int32 {
    static DWRITE_COLOR_COMPOSITE_CLEAR := 0
    static DWRITE_COLOR_COMPOSITE_SRC := 1
    static DWRITE_COLOR_COMPOSITE_DEST := 2
    static DWRITE_COLOR_COMPOSITE_SRC_OVER := 3
    static DWRITE_COLOR_COMPOSITE_DEST_OVER := 4
    static DWRITE_COLOR_COMPOSITE_SRC_IN := 5
    static DWRITE_COLOR_COMPOSITE_DEST_IN := 6
    static DWRITE_COLOR_COMPOSITE_SRC_OUT := 7
    static DWRITE_COLOR_COMPOSITE_DEST_OUT := 8
    static DWRITE_COLOR_COMPOSITE_SRC_ATOP := 9
    static DWRITE_COLOR_COMPOSITE_DEST_ATOP := 10
    static DWRITE_COLOR_COMPOSITE_XOR := 11
    static DWRITE_COLOR_COMPOSITE_PLUS := 12
    static DWRITE_COLOR_COMPOSITE_SCREEN := 13
    static DWRITE_COLOR_COMPOSITE_OVERLAY := 14
    static DWRITE_COLOR_COMPOSITE_DARKEN := 15
    static DWRITE_COLOR_COMPOSITE_LIGHTEN := 16
    static DWRITE_COLOR_COMPOSITE_COLOR_DODGE := 17
    static DWRITE_COLOR_COMPOSITE_COLOR_BURN := 18
    static DWRITE_COLOR_COMPOSITE_HARD_LIGHT := 19
    static DWRITE_COLOR_COMPOSITE_SOFT_LIGHT := 20
    static DWRITE_COLOR_COMPOSITE_DIFFERENCE := 21
    static DWRITE_COLOR_COMPOSITE_EXCLUSION := 22
    static DWRITE_COLOR_COMPOSITE_MULTIPLY := 23
    static DWRITE_COLOR_COMPOSITE_HSL_HUE := 24
    static DWRITE_COLOR_COMPOSITE_HSL_SATURATION := 25
    static DWRITE_COLOR_COMPOSITE_HSL_COLOR := 26
    static DWRITE_COLOR_COMPOSITE_HSL_LUMINOSITY := 27
}
struct DWRITE_PAINT_TYPE extends Int32 {
    static DWRITE_PAINT_TYPE_NONE := 0
    static DWRITE_PAINT_TYPE_LAYERS := 1
    static DWRITE_PAINT_TYPE_SOLID_GLYPH := 2
    static DWRITE_PAINT_TYPE_SOLID := 3
    static DWRITE_PAINT_TYPE_LINEAR_GRADIENT := 4
    static DWRITE_PAINT_TYPE_RADIAL_GRADIENT := 5
    static DWRITE_PAINT_TYPE_SWEEP_GRADIENT := 6
    static DWRITE_PAINT_TYPE_GLYPH := 7
    static DWRITE_PAINT_TYPE_COLOR_GLYPH := 8
    static DWRITE_PAINT_TYPE_TRANSFORM := 9
    static DWRITE_PAINT_TYPE_COMPOSITE := 10
}
struct DWRITE_PAINT_ELEMENT {
    paintType : DWRITE_PAINT_TYPE
    paint : this.PAINT_UNION
    struct PAINT_UNION {
        union {
            layers : this.PAINT_LAYERS
            solidGlyph : this.PAINT_SOLID_GLYPH
            solid : DWRITE_PAINT_COLOR
            linearGradient : this.PAINT_LINEAR_GRADIENT
            radialGradient : this.PAINT_RADIAL_GRADIENT
            sweepGradient : this.PAINT_SWEEP_GRADIENT
            glyph : this.PAINT_GLYPH
            colorGlyph : this.PAINT_COLOR_GLYPH
            transform : DWRITE_MATRIX
            composite : this.PAINT_COMPOSITE
        }
        struct PAINT_LAYERS {
            childCount : UInt32
        }
        struct PAINT_SOLID_GLYPH {
            glyphIndex : UInt32
            color : DWRITE_PAINT_COLOR
        }
        struct PAINT_LINEAR_GRADIENT {
            extendMode : UInt32
            gradientStopCount : UInt32
            x0 : Float32
            y0 : Float32
            x1 : Float32
            y1 : Float32
            x2 : Float32
            y2 : Float32
        }
        struct PAINT_RADIAL_GRADIENT {
            extendMode : UInt32
            gradientStopCount : UInt32
            x0 : Float32
            y0 : Float32
            radius0 : Float32
            x1 : Float32
            y1 : Float32
            radius1 : Float32
        }
        struct PAINT_SWEEP_GRADIENT {
            extendMode : UInt32
            gradientStopCount : UInt32
            centerX : Float32
            centerY : Float32
            startAngle : Float32
            endAngle : Float32
        }
        struct PAINT_GLYPH {
            glyphIndex : UInt32
        }
        struct PAINT_COLOR_GLYPH {
            glyphIndex : UInt32
            clipBox : D2D_RECT_F
        }
        struct PAINT_COMPOSITE {
            mode : DWRITE_COLOR_COMPOSITE_MODE
        }
    }
}
struct IDWritePaintReader extends IUnknown {
    static IID := "{8128E912-3B97-42A5-AB6C-24AAD3A86E54}"
    SetCurrentGlyph(glyphIndex, paintElement, clipBox, glyphAttributes?)
      => ComCall(3, this.p, UInt32, glyphIndex, DWRITE_PAINT_ELEMENT.Ptr, paintElement, UInt32, paintElement.Size, D2D_RECT_F.Ptr, clipBox, DWRITE_PAINT_ATTRIBUTES.Ptr, glyphAttributes?)
    SetTextColor(textColor)
      => ComCall(4, this.p, DWRITE_COLOR_F.Ptr, textColor)
    SetColorPaletteIndex(colorPaletteIndex)
      => ComCall(5, this.p, UInt32, colorPaletteIndex)
    SetCustomColorPalette(paletteEntries)
      => ComCall(6, this.p, DWRITE_COLOR_F.Ptr, paletteEntries, UInt32, paletteEntries.Length)
    MoveToFirstChild(paintElement)
      => ComCall(7, this.p, DWRITE_PAINT_ELEMENT.Ptr, paintElement, UInt32, paintElement.Size)
    MoveToNextSibling(paintElement)
      => ComCall(8, this.p, DWRITE_PAINT_ELEMENT.Ptr, paintElement, UInt32, paintElement.Size)
    MoveToParent()
      => ComCall(9, this.p)
    GetGradientStops(firstGradientStopIndex, gradientStops)
      => ComCall(10, this.p, UInt32, firstGradientStopIndex, UInt32, gradientStops.Length, D2D1_GRADIENT_STOP.Ptr, gradientStops)
    GetGradientStopColors(firstGradientStopIndex, gradientStopColors)
      => ComCall(11, this.p, UInt32, firstGradientStopIndex, UInt32, gradientStopColors.Length, DWRITE_PAINT_COLOR.Ptr, gradientStopColors)
}
struct IDWriteFontFace7 extends IDWriteFontFace6 {
    static IID := "{3945B85B-BC95-40F7-B72C-8B73BFC7E13B}"
    GetPaintFeatureLevel(glyphImageFormat)
      => ComCall(60, this.p, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, DWRITE_PAINT_FEATURE_LEVEL)
    CreatePaintReader(glyphImageFormat, paintFeatureLevel, paintReader)
      => ComCall(61, this.p, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, DWRITE_PAINT_FEATURE_LEVEL, paintFeatureLevel, IDWritePaintReader.Ptr, paintReader)
}
struct IDWriteFactory8 extends IDWriteFactory7 {
    static IID := "{EE0A7FB5-DEF4-4C23-A454-C9C7DC878398}"
    TranslateColorGlyphRun(baselineOrigin, glyphRun, glyphRunDescription?, desiredGlyphImageFormats, paintFeatureLevel, measuringMode, worldAndDpiTransform?, colorPaletteIndex, colorEnumerator)
      => ComCall(57, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, DWRITE_GLYPH_IMAGE_FORMATS, desiredGlyphImageFormats, DWRITE_PAINT_FEATURE_LEVEL, paintFeatureLevel, DWRITE_MEASURING_MODE, measuringMode, DWRITE_MATRIX.Ptr, worldAndDpiTransform?, UInt32, colorPaletteIndex, IDWriteColorGlyphRunEnumerator1.Ptr, colorEnumerator)
}
struct IDWriteBitmapRenderTarget3 extends IDWriteBitmapRenderTarget2 {
    static IID := "{AEEC37DB-C337-40F1-8E2A-9A41B167B238}"
    GetPaintFeatureLevel()
      => ComCall(14, this.p, DWRITE_PAINT_FEATURE_LEVEL)
    DrawPaintGlyphRun(baselineOriginX, baselineOriginY, measuringMode, glyphRun, glyphImageFormat, textColor, colorPaletteIndex, blackBoxRect?)
      => ComCall(15, this.p, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, COLORREF, textColor, UInt32, colorPaletteIndex, RECT.Ptr, blackBoxRect?)
    DrawGlyphRunWithColorSupport(baselineOriginX, baselineOriginY, measuringMode, glyphRun, renderingParams, textColor, colorPaletteIndex, blackBoxRect?)
      => ComCall(16, this.p, Float32, baselineOriginX, Float32, baselineOriginY, DWRITE_MEASURING_MODE, measuringMode, DWRITE_GLYPH_RUN.Ptr, glyphRun, IDWriteRenderingParams, renderingParams, COLORREF, textColor, UInt32, colorPaletteIndex, RECT.Ptr, blackBoxRect?)
}
