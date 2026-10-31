#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, POINT, PSTR, PWSTR, RECT}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D1_ALPHA_MODE, D2D1_BEZIER_SEGMENT, D2D1_BLEND_MODE, D2D1_COLOR_F, D2D1_COMPOSITE_MODE, D2D1_FILL_MODE, D2D1_GRADIENT_STOP, D2D1_PIXEL_FORMAT, D2D_MATRIX_3X2_F, D2D_MATRIX_4X4_F, D2D_POINT_2F, D2D_POINT_2U, D2D_RECT_F, D2D_RECT_U, D2D_SIZE_F, D2D_SIZE_U, ID2D1SimplifiedGeometrySink}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_FEATURE_LEVEL}
#Import "..\Graphics.DirectWrite\Types.ahk" {DWRITE_GLYPH_IMAGE_FORMATS, DWRITE_GLYPH_RUN, DWRITE_GLYPH_RUN_DESCRIPTION, DWRITE_MEASURING_MODE, DWRITE_PAINT_FEATURE_LEVEL, IDWriteFontFace, IDWriteRenderingParams, IDWriteTextFormat, IDWriteTextLayout}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice, IDXGISurface}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT}
#Import "..\Graphics.Gdi\Types.ahk" {HDC}
#Import "..\Graphics.Imaging\Types.ahk" {IWICBitmap, IWICBitmapSource, IWICColorContext, IWICImagingFactory}
#Import "..\Storage.Xps.Printing\Types.ahk" {IPrintDocumentPackageTarget}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}

struct D2D1_INTERPOLATION_MODE_DEFINITION extends Int32 {
    static D2D1_INTERPOLATION_MODE_DEFINITION_NEAREST_NEIGHBOR := 0
    static D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR := 1
    static D2D1_INTERPOLATION_MODE_DEFINITION_CUBIC := 2
    static D2D1_INTERPOLATION_MODE_DEFINITION_MULTI_SAMPLE_LINEAR := 3
    static D2D1_INTERPOLATION_MODE_DEFINITION_ANISOTROPIC := 4
    static D2D1_INTERPOLATION_MODE_DEFINITION_HIGH_QUALITY_CUBIC := 5
    static D2D1_INTERPOLATION_MODE_DEFINITION_FANT := 6
    static D2D1_INTERPOLATION_MODE_DEFINITION_MIPMAP_LINEAR := 7
}
struct D2D1_GAMMA extends Int32 {
    static D2D1_GAMMA_2_2 := 0
    static D2D1_GAMMA_1_0 := 1
}
struct D2D1_OPACITY_MASK_CONTENT extends Int32 {
    static D2D1_OPACITY_MASK_CONTENT_GRAPHICS := 0
    static D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL := 1
    static D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE := 2
}
struct D2D1_EXTEND_MODE extends Int32 {
    static D2D1_EXTEND_MODE_CLAMP := 0
    static D2D1_EXTEND_MODE_WRAP := 1
    static D2D1_EXTEND_MODE_MIRROR := 2
}
struct D2D1_ANTIALIAS_MODE extends Int32 {
    static D2D1_ANTIALIAS_MODE_PER_PRIMITIVE := 0
    static D2D1_ANTIALIAS_MODE_ALIASED := 1
}
struct D2D1_TEXT_ANTIALIAS_MODE extends Int32 {
    static D2D1_TEXT_ANTIALIAS_MODE_DEFAULT := 0
    static D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE := 1
    static D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE := 2
    static D2D1_TEXT_ANTIALIAS_MODE_ALIASED := 3
}
struct D2D1_BITMAP_INTERPOLATION_MODE extends Int32 {
    static D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_BITMAP_INTERPOLATION_MODE_LINEAR := 1
}
struct D2D1_DRAW_TEXT_OPTIONS extends Int32 {
    static D2D1_DRAW_TEXT_OPTIONS_NO_SNAP := 1
    static D2D1_DRAW_TEXT_OPTIONS_CLIP := 2
    static D2D1_DRAW_TEXT_OPTIONS_ENABLE_COLOR_FONT := 4
    static D2D1_DRAW_TEXT_OPTIONS_DISABLE_COLOR_BITMAP_SNAPPING := 8
    static D2D1_DRAW_TEXT_OPTIONS_NONE := 0
}
struct D2D1_BITMAP_PROPERTIES {
    pixelFormat : D2D1_PIXEL_FORMAT
    dpiX : Float32
    dpiY : Float32
}
struct D2D1_BRUSH_PROPERTIES {
    opacity : Float32
    transform : D2D_MATRIX_3X2_F
}
struct D2D1_BITMAP_BRUSH_PROPERTIES {
    extendModeX : D2D1_EXTEND_MODE
    extendModeY : D2D1_EXTEND_MODE
    interpolationMode : D2D1_BITMAP_INTERPOLATION_MODE
}
struct D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES {
    startPoint : D2D_POINT_2F
    endPoint : D2D_POINT_2F
}
struct D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES {
    center : D2D_POINT_2F
    gradientOriginOffset : D2D_POINT_2F
    radiusX : Float32
    radiusY : Float32
}
struct D2D1_ARC_SIZE extends Int32 {
    static D2D1_ARC_SIZE_SMALL := 0
    static D2D1_ARC_SIZE_LARGE := 1
}
struct D2D1_CAP_STYLE extends Int32 {
    static D2D1_CAP_STYLE_FLAT := 0
    static D2D1_CAP_STYLE_SQUARE := 1
    static D2D1_CAP_STYLE_ROUND := 2
    static D2D1_CAP_STYLE_TRIANGLE := 3
}
struct D2D1_DASH_STYLE extends Int32 {
    static D2D1_DASH_STYLE_SOLID := 0
    static D2D1_DASH_STYLE_DASH := 1
    static D2D1_DASH_STYLE_DOT := 2
    static D2D1_DASH_STYLE_DASH_DOT := 3
    static D2D1_DASH_STYLE_DASH_DOT_DOT := 4
    static D2D1_DASH_STYLE_CUSTOM := 5
}
struct D2D1_LINE_JOIN extends Int32 {
    static D2D1_LINE_JOIN_MITER := 0
    static D2D1_LINE_JOIN_BEVEL := 1
    static D2D1_LINE_JOIN_ROUND := 2
    static D2D1_LINE_JOIN_MITER_OR_BEVEL := 3
}
struct D2D1_COMBINE_MODE extends Int32 {
    static D2D1_COMBINE_MODE_UNION := 0
    static D2D1_COMBINE_MODE_INTERSECT := 1
    static D2D1_COMBINE_MODE_XOR := 2
    static D2D1_COMBINE_MODE_EXCLUDE := 3
}
struct D2D1_GEOMETRY_RELATION extends Int32 {
    static D2D1_GEOMETRY_RELATION_UNKNOWN := 0
    static D2D1_GEOMETRY_RELATION_DISJOINT := 1
    static D2D1_GEOMETRY_RELATION_IS_CONTAINED := 2
    static D2D1_GEOMETRY_RELATION_CONTAINS := 3
    static D2D1_GEOMETRY_RELATION_OVERLAP := 4
}
struct D2D1_GEOMETRY_SIMPLIFICATION_OPTION extends Int32 {
    static D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES := 0
    static D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES := 1
}
struct D2D1_TRIANGLE {
    point1 : D2D_POINT_2F
    point2 : D2D_POINT_2F
    point3 : D2D_POINT_2F
}
struct D2D1_SWEEP_DIRECTION extends Int32 {
    static D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE := 0
    static D2D1_SWEEP_DIRECTION_CLOCKWISE := 1
}
struct D2D1_ARC_SEGMENT {
    point : D2D_POINT_2F
    size : D2D_SIZE_F
    rotationAngle : Float32
    sweepDirection : D2D1_SWEEP_DIRECTION
    arcSize : D2D1_ARC_SIZE
}
struct D2D1_QUADRATIC_BEZIER_SEGMENT {
    point1 : D2D_POINT_2F
    point2 : D2D_POINT_2F
}
struct D2D1_ELLIPSE {
    point : D2D_POINT_2F
    radiusX : Float32
    radiusY : Float32
}
struct D2D1_ROUNDED_RECT {
    rect : D2D_RECT_F
    radiusX : Float32
    radiusY : Float32
}
struct D2D1_STROKE_STYLE_PROPERTIES {
    startCap : D2D1_CAP_STYLE
    endCap : D2D1_CAP_STYLE
    dashCap : D2D1_CAP_STYLE
    lineJoin : D2D1_LINE_JOIN
    miterLimit : Float32
    dashStyle : D2D1_DASH_STYLE
    dashOffset : Float32
}
struct D2D1_LAYER_OPTIONS extends Int32 {
    static D2D1_LAYER_OPTIONS_NONE := 0
    static D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE := 1
}
struct D2D1_LAYER_PARAMETERS {
    contentBounds : D2D_RECT_F
    geometricMask : ID2D1Geometry
    maskAntialiasMode : D2D1_ANTIALIAS_MODE
    maskTransform : D2D_MATRIX_3X2_F
    opacity : Float32
    opacityBrush : ID2D1Brush
    layerOptions : D2D1_LAYER_OPTIONS
}
struct D2D1_WINDOW_STATE extends Int32 {
    static D2D1_WINDOW_STATE_NONE := 0
    static D2D1_WINDOW_STATE_OCCLUDED := 1
}
struct D2D1_RENDER_TARGET_TYPE extends Int32 {
    static D2D1_RENDER_TARGET_TYPE_DEFAULT := 0
    static D2D1_RENDER_TARGET_TYPE_SOFTWARE := 1
    static D2D1_RENDER_TARGET_TYPE_HARDWARE := 2
}
struct D2D1_FEATURE_LEVEL extends Int32 {
    static D2D1_FEATURE_LEVEL_DEFAULT := 0
    static D2D1_FEATURE_LEVEL_9 := 37120
    static D2D1_FEATURE_LEVEL_10 := 40960
}
struct D2D1_RENDER_TARGET_USAGE extends Int32 {
    static D2D1_RENDER_TARGET_USAGE_NONE := 0
    static D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING := 1
    static D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE := 2
}
struct D2D1_PRESENT_OPTIONS extends Int32 {
    static D2D1_PRESENT_OPTIONS_NONE := 0
    static D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS := 1
    static D2D1_PRESENT_OPTIONS_IMMEDIATELY := 2
}
struct D2D1_RENDER_TARGET_PROPERTIES {
    type : D2D1_RENDER_TARGET_TYPE
    pixelFormat : D2D1_PIXEL_FORMAT
    dpiX : Float32
    dpiY : Float32
    usage : D2D1_RENDER_TARGET_USAGE
    minLevel : D2D1_FEATURE_LEVEL
}
struct D2D1_HWND_RENDER_TARGET_PROPERTIES {
    hwnd : HWND
    pixelSize : D2D_SIZE_U
    presentOptions : D2D1_PRESENT_OPTIONS
}
struct D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS extends Int32 {
    static D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE := 0
    static D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE := 1
}
struct D2D1_DRAWING_STATE_DESCRIPTION {
    antialiasMode : D2D1_ANTIALIAS_MODE
    textAntialiasMode : D2D1_TEXT_ANTIALIAS_MODE
    tag1 : Int64
    tag2 : Int64
    transform : D2D_MATRIX_3X2_F
}
struct D2D1_DC_INITIALIZE_MODE extends Int32 {
    static D2D1_DC_INITIALIZE_MODE_COPY := 0
    static D2D1_DC_INITIALIZE_MODE_CLEAR := 1
}
struct D2D1_DEBUG_LEVEL extends Int32 {
    static D2D1_DEBUG_LEVEL_NONE := 0
    static D2D1_DEBUG_LEVEL_ERROR := 1
    static D2D1_DEBUG_LEVEL_WARNING := 2
    static D2D1_DEBUG_LEVEL_INFORMATION := 3
}
struct D2D1_FACTORY_TYPE extends Int32 {
    static D2D1_FACTORY_TYPE_SINGLE_THREADED := 0
    static D2D1_FACTORY_TYPE_MULTI_THREADED := 1
}
struct D2D1_FACTORY_OPTIONS {
    debugLevel : D2D1_DEBUG_LEVEL
}
struct ID2D1Resource extends IUnknown {
    static IID := "{2CD90691-12E2-11DC-9FED-001143A055F9}"
    GetFactory(factory)
      => ComCall(3, this.p, ID2D1Factory.Ptr, factory, "void")
}
struct ID2D1Image extends ID2D1Resource {
    static IID := "{65019F75-8DA2-497C-B32C-DFA34E48EDE6}"
}
struct ID2D1Bitmap extends ID2D1Image {
    static IID := "{A2296057-EA42-4099-983B-539FB6505426}"
    GetSize()
      => ComCall(4, this.p, D2D_SIZE_F)
    GetPixelSize()
      => ComCall(5, this.p, D2D_SIZE_U)
    GetPixelFormat()
      => ComCall(6, this.p, D2D1_PIXEL_FORMAT)
    GetDpi(dpiX, dpiY)
      => ComCall(7, this.p, Float32.Ptr, dpiX, Float32.Ptr, dpiY, "void")
    CopyFromBitmap(destPoint?, bitmap, srcRect?)
      => ComCall(8, this.p, D2D_POINT_2U.Ptr, destPoint?, ID2D1Bitmap, bitmap, D2D_RECT_U.Ptr, srcRect?)
    CopyFromRenderTarget(destPoint?, renderTarget, srcRect?)
      => ComCall(9, this.p, D2D_POINT_2U.Ptr, destPoint?, ID2D1RenderTarget, renderTarget, D2D_RECT_U.Ptr, srcRect?)
    CopyFromMemory(dstRect?, srcData, pitch)
      => ComCall(10, this.p, D2D_RECT_U.Ptr, dstRect?, Struct.Ptr, srcData, UInt32, pitch)
}
struct ID2D1GradientStopCollection extends ID2D1Resource {
    static IID := "{2CD906A7-12E2-11DC-9FED-001143A055F9}"
    GetGradientStopCount()
      => ComCall(4, this.p, UInt32)
    GetGradientStops(gradientStops)
      => ComCall(5, this.p, D2D1_GRADIENT_STOP.Ptr, gradientStops, UInt32, gradientStops.Length, "void")
    GetColorInterpolationGamma()
      => ComCall(6, this.p, D2D1_GAMMA)
    GetExtendMode()
      => ComCall(7, this.p, D2D1_EXTEND_MODE)
}
struct ID2D1Brush extends ID2D1Resource {
    static IID := "{2CD906A8-12E2-11DC-9FED-001143A055F9}"
    SetOpacity(opacity)
      => ComCall(4, this.p, Float32, opacity, "void")
    SetTransform(transform)
      => ComCall(5, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
    GetOpacity()
      => ComCall(6, this.p, Float32)
    GetTransform(transform)
      => ComCall(7, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
}
struct ID2D1BitmapBrush extends ID2D1Brush {
    static IID := "{2CD906AA-12E2-11DC-9FED-001143A055F9}"
    SetExtendModeX(extendModeX)
      => ComCall(8, this.p, D2D1_EXTEND_MODE, extendModeX, "void")
    SetExtendModeY(extendModeY)
      => ComCall(9, this.p, D2D1_EXTEND_MODE, extendModeY, "void")
    SetInterpolationMode(interpolationMode)
      => ComCall(10, this.p, D2D1_BITMAP_INTERPOLATION_MODE, interpolationMode, "void")
    SetBitmap(bitmap?)
      => ComCall(11, this.p, ID2D1Bitmap, bitmap?, "void")
    GetExtendModeX()
      => ComCall(12, this.p, D2D1_EXTEND_MODE)
    GetExtendModeY()
      => ComCall(13, this.p, D2D1_EXTEND_MODE)
    GetInterpolationMode()
      => ComCall(14, this.p, D2D1_BITMAP_INTERPOLATION_MODE)
    GetBitmap(bitmap)
      => ComCall(15, this.p, ID2D1Bitmap.Ptr, bitmap, "void")
}
struct ID2D1SolidColorBrush extends ID2D1Brush {
    static IID := "{2CD906A9-12E2-11DC-9FED-001143A055F9}"
    SetColor(color)
      => ComCall(8, this.p, D2D1_COLOR_F.Ptr, color, "void")
    GetColor()
      => ComCall(9, this.p, D2D1_COLOR_F)
}
struct ID2D1LinearGradientBrush extends ID2D1Brush {
    static IID := "{2CD906AB-12E2-11DC-9FED-001143A055F9}"
    SetStartPoint(startPoint)
      => ComCall(8, this.p, D2D_POINT_2F, startPoint, "void")
    SetEndPoint(endPoint)
      => ComCall(9, this.p, D2D_POINT_2F, endPoint, "void")
    GetStartPoint()
      => ComCall(10, this.p, D2D_POINT_2F)
    GetEndPoint()
      => ComCall(11, this.p, D2D_POINT_2F)
    GetGradientStopCollection(gradientStopCollection)
      => ComCall(12, this.p, ID2D1GradientStopCollection.Ptr, gradientStopCollection, "void")
}
struct ID2D1RadialGradientBrush extends ID2D1Brush {
    static IID := "{2CD906AC-12E2-11DC-9FED-001143A055F9}"
    SetCenter(center)
      => ComCall(8, this.p, D2D_POINT_2F, center, "void")
    SetGradientOriginOffset(gradientOriginOffset)
      => ComCall(9, this.p, D2D_POINT_2F, gradientOriginOffset, "void")
    SetRadiusX(radiusX)
      => ComCall(10, this.p, Float32, radiusX, "void")
    SetRadiusY(radiusY)
      => ComCall(11, this.p, Float32, radiusY, "void")
    GetCenter()
      => ComCall(12, this.p, D2D_POINT_2F)
    GetGradientOriginOffset()
      => ComCall(13, this.p, D2D_POINT_2F)
    GetRadiusX()
      => ComCall(14, this.p, Float32)
    GetRadiusY()
      => ComCall(15, this.p, Float32)
    GetGradientStopCollection(gradientStopCollection)
      => ComCall(16, this.p, ID2D1GradientStopCollection.Ptr, gradientStopCollection, "void")
}
struct ID2D1StrokeStyle extends ID2D1Resource {
    static IID := "{2CD9069D-12E2-11DC-9FED-001143A055F9}"
    GetStartCap()
      => ComCall(4, this.p, D2D1_CAP_STYLE)
    GetEndCap()
      => ComCall(5, this.p, D2D1_CAP_STYLE)
    GetDashCap()
      => ComCall(6, this.p, D2D1_CAP_STYLE)
    GetMiterLimit()
      => ComCall(7, this.p, Float32)
    GetLineJoin()
      => ComCall(8, this.p, D2D1_LINE_JOIN)
    GetDashOffset()
      => ComCall(9, this.p, Float32)
    GetDashStyle()
      => ComCall(10, this.p, D2D1_DASH_STYLE)
    GetDashesCount()
      => ComCall(11, this.p, UInt32)
    GetDashes(dashes)
      => ComCall(12, this.p, Float32.Ptr, dashes, UInt32, dashes.Length, "void")
}
struct ID2D1Geometry extends ID2D1Resource {
    static IID := "{2CD906A1-12E2-11DC-9FED-001143A055F9}"
    GetBounds(worldTransform?, bounds)
      => ComCall(4, this.p, D2D_MATRIX_3X2_F.Ptr, worldTransform?, D2D_RECT_F.Ptr, bounds)
    GetWidenedBounds(strokeWidth, strokeStyle?, worldTransform?, flatteningTolerance, bounds)
      => ComCall(5, this.p, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, D2D_RECT_F.Ptr, bounds)
    StrokeContainsPoint(point, strokeWidth, strokeStyle?, worldTransform?, flatteningTolerance, contains1)
      => ComCall(6, this.p, D2D_POINT_2F, point, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, BOOL.Ptr, contains1)
    FillContainsPoint(point, worldTransform?, flatteningTolerance, contains1)
      => ComCall(7, this.p, D2D_POINT_2F, point, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, BOOL.Ptr, contains1)
    CompareWithGeometry(inputGeometry, inputGeometryTransform?, flatteningTolerance, relation)
      => ComCall(8, this.p, ID2D1Geometry, inputGeometry, D2D_MATRIX_3X2_F.Ptr, inputGeometryTransform?, Float32, flatteningTolerance, D2D1_GEOMETRY_RELATION.Ptr, relation)
    Simplify(simplificationOption, worldTransform?, flatteningTolerance, geometrySink)
      => ComCall(9, this.p, D2D1_GEOMETRY_SIMPLIFICATION_OPTION, simplificationOption, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, ID2D1SimplifiedGeometrySink, geometrySink)
    Tessellate(worldTransform?, flatteningTolerance, tessellationSink)
      => ComCall(10, this.p, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, ID2D1TessellationSink, tessellationSink)
    CombineWithGeometry(inputGeometry, combineMode, inputGeometryTransform?, flatteningTolerance, geometrySink)
      => ComCall(11, this.p, ID2D1Geometry, inputGeometry, D2D1_COMBINE_MODE, combineMode, D2D_MATRIX_3X2_F.Ptr, inputGeometryTransform?, Float32, flatteningTolerance, ID2D1SimplifiedGeometrySink, geometrySink)
    Outline(worldTransform?, flatteningTolerance, geometrySink)
      => ComCall(12, this.p, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, ID2D1SimplifiedGeometrySink, geometrySink)
    ComputeArea(worldTransform?, flatteningTolerance, area)
      => ComCall(13, this.p, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, Float32.Ptr, area)
    ComputeLength(worldTransform?, flatteningTolerance, length)
      => ComCall(14, this.p, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, Float32.Ptr, length)
    ComputePointAtLength(length, worldTransform?, flatteningTolerance, point?, unitTangentVector?)
      => ComCall(15, this.p, Float32, length, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, D2D_POINT_2F.Ptr, point?, D2D_POINT_2F.Ptr, unitTangentVector?)
    Widen(strokeWidth, strokeStyle?, worldTransform?, flatteningTolerance, geometrySink)
      => ComCall(16, this.p, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, ID2D1SimplifiedGeometrySink, geometrySink)
}
struct ID2D1RectangleGeometry extends ID2D1Geometry {
    static IID := "{2CD906A2-12E2-11DC-9FED-001143A055F9}"
    GetRect(rect)
      => ComCall(17, this.p, D2D_RECT_F.Ptr, rect, "void")
}
struct ID2D1RoundedRectangleGeometry extends ID2D1Geometry {
    static IID := "{2CD906A3-12E2-11DC-9FED-001143A055F9}"
    GetRoundedRect(roundedRect)
      => ComCall(17, this.p, D2D1_ROUNDED_RECT.Ptr, roundedRect, "void")
}
struct ID2D1EllipseGeometry extends ID2D1Geometry {
    static IID := "{2CD906A4-12E2-11DC-9FED-001143A055F9}"
    GetEllipse(ellipse)
      => ComCall(17, this.p, D2D1_ELLIPSE.Ptr, ellipse, "void")
}
struct ID2D1GeometryGroup extends ID2D1Geometry {
    static IID := "{2CD906A6-12E2-11DC-9FED-001143A055F9}"
    GetFillMode()
      => ComCall(17, this.p, D2D1_FILL_MODE)
    GetSourceGeometryCount()
      => ComCall(18, this.p, UInt32)
    GetSourceGeometries(geometries)
      => ComCall(19, this.p, ID2D1Geometry.Ptr, geometries, UInt32, geometries.Length, "void")
}
struct ID2D1TransformedGeometry extends ID2D1Geometry {
    static IID := "{2CD906BB-12E2-11DC-9FED-001143A055F9}"
    GetSourceGeometry(sourceGeometry)
      => ComCall(17, this.p, ID2D1Geometry.Ptr, sourceGeometry, "void")
    GetTransform(transform)
      => ComCall(18, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
}
struct ID2D1GeometrySink extends ID2D1SimplifiedGeometrySink {
    static IID := "{2CD9069F-12E2-11DC-9FED-001143A055F9}"
    AddLine(point)
      => ComCall(10, this.p, D2D_POINT_2F, point, "void")
    AddBezier(bezier)
      => ComCall(11, this.p, D2D1_BEZIER_SEGMENT.Ptr, bezier, "void")
    AddQuadraticBezier(bezier)
      => ComCall(12, this.p, D2D1_QUADRATIC_BEZIER_SEGMENT.Ptr, bezier, "void")
    AddQuadraticBeziers(beziers)
      => ComCall(13, this.p, D2D1_QUADRATIC_BEZIER_SEGMENT.Ptr, beziers, UInt32, beziers.Length, "void")
    AddArc(arc)
      => ComCall(14, this.p, D2D1_ARC_SEGMENT.Ptr, arc, "void")
}
struct ID2D1TessellationSink extends IUnknown {
    static IID := "{2CD906C1-12E2-11DC-9FED-001143A055F9}"
    AddTriangles(triangles)
      => ComCall(3, this.p, D2D1_TRIANGLE.Ptr, triangles, UInt32, triangles.Length, "void")
    Close()
      => ComCall(4, this.p)
}
struct ID2D1PathGeometry extends ID2D1Geometry {
    static IID := "{2CD906A5-12E2-11DC-9FED-001143A055F9}"
    Open(geometrySink)
      => ComCall(17, this.p, ID2D1GeometrySink.Ptr, geometrySink)
    Stream(geometrySink)
      => ComCall(18, this.p, ID2D1GeometrySink, geometrySink)
    GetSegmentCount(count)
      => ComCall(19, this.p, UInt32.Ptr, count)
    GetFigureCount(count)
      => ComCall(20, this.p, UInt32.Ptr, count)
}
struct ID2D1Mesh extends ID2D1Resource {
    static IID := "{2CD906C2-12E2-11DC-9FED-001143A055F9}"
    Open(tessellationSink)
      => ComCall(4, this.p, ID2D1TessellationSink.Ptr, tessellationSink)
}
struct ID2D1Layer extends ID2D1Resource {
    static IID := "{2CD9069B-12E2-11DC-9FED-001143A055F9}"
    GetSize()
      => ComCall(4, this.p, D2D_SIZE_F)
}
struct ID2D1DrawingStateBlock extends ID2D1Resource {
    static IID := "{28506E39-EBF6-46A1-BB47-FD85565AB957}"
    GetDescription(stateDescription)
      => ComCall(4, this.p, D2D1_DRAWING_STATE_DESCRIPTION.Ptr, stateDescription, "void")
    SetDescription(stateDescription)
      => ComCall(5, this.p, D2D1_DRAWING_STATE_DESCRIPTION.Ptr, stateDescription, "void")
    SetTextRenderingParams(textRenderingParams?)
      => ComCall(6, this.p, IDWriteRenderingParams, textRenderingParams?, "void")
    GetTextRenderingParams(textRenderingParams)
      => ComCall(7, this.p, IDWriteRenderingParams.Ptr, textRenderingParams, "void")
}
struct ID2D1RenderTarget extends ID2D1Resource {
    static IID := "{2CD90694-12E2-11DC-9FED-001143A055F9}"
    CreateBitmap(size, srcData?, pitch, bitmapProperties, bitmap)
      => ComCall(4, this.p, D2D_SIZE_U, size, Struct.Ptr, srcData?, UInt32, pitch, D2D1_BITMAP_PROPERTIES.Ptr, bitmapProperties, ID2D1Bitmap.Ptr, bitmap)
    CreateBitmapFromWicBitmap(wicBitmapSource, bitmapProperties?, bitmap)
      => ComCall(5, this.p, IWICBitmapSource, wicBitmapSource, D2D1_BITMAP_PROPERTIES.Ptr, bitmapProperties?, ID2D1Bitmap.Ptr, bitmap)
    CreateSharedBitmap(riid, data, bitmapProperties?, bitmap)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr, data, D2D1_BITMAP_PROPERTIES.Ptr, bitmapProperties?, ID2D1Bitmap.Ptr, bitmap)
    CreateBitmapBrush(bitmap?, bitmapBrushProperties?, brushProperties?, bitmapBrush)
      => ComCall(7, this.p, ID2D1Bitmap, bitmap?, D2D1_BITMAP_BRUSH_PROPERTIES.Ptr, bitmapBrushProperties?, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1BitmapBrush.Ptr, bitmapBrush)
    CreateSolidColorBrush(color, brushProperties?, solidColorBrush)
      => ComCall(8, this.p, D2D1_COLOR_F.Ptr, color, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1SolidColorBrush.Ptr, solidColorBrush)
    CreateGradientStopCollection(gradientStops, colorInterpolationGamma, extendMode, gradientStopCollection)
      => ComCall(9, this.p, D2D1_GRADIENT_STOP.Ptr, gradientStops, UInt32, gradientStops.Length, D2D1_GAMMA, colorInterpolationGamma, D2D1_EXTEND_MODE, extendMode, ID2D1GradientStopCollection.Ptr, gradientStopCollection)
    CreateLinearGradientBrush(linearGradientBrushProperties, brushProperties?, gradientStopCollection, linearGradientBrush)
      => ComCall(10, this.p, D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES.Ptr, linearGradientBrushProperties, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1GradientStopCollection, gradientStopCollection, ID2D1LinearGradientBrush.Ptr, linearGradientBrush)
    CreateRadialGradientBrush(radialGradientBrushProperties, brushProperties?, gradientStopCollection, radialGradientBrush)
      => ComCall(11, this.p, D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES.Ptr, radialGradientBrushProperties, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1GradientStopCollection, gradientStopCollection, ID2D1RadialGradientBrush.Ptr, radialGradientBrush)
    CreateCompatibleRenderTarget(desiredSize?, desiredPixelSize?, desiredFormat?, options, bitmapRenderTarget)
      => ComCall(12, this.p, D2D_SIZE_F.Ptr, desiredSize?, D2D_SIZE_U.Ptr, desiredPixelSize?, D2D1_PIXEL_FORMAT.Ptr, desiredFormat?, D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS, options, ID2D1BitmapRenderTarget.Ptr, bitmapRenderTarget)
    CreateLayer(size?, layer)
      => ComCall(13, this.p, D2D_SIZE_F.Ptr, size?, ID2D1Layer.Ptr, layer)
    CreateMesh(mesh)
      => ComCall(14, this.p, ID2D1Mesh.Ptr, mesh)
    DrawLine(point0, point1, brush, strokeWidth, strokeStyle?)
      => ComCall(15, this.p, D2D_POINT_2F, point0, D2D_POINT_2F, point1, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, "void")
    DrawRectangle(rect, brush, strokeWidth, strokeStyle?)
      => ComCall(16, this.p, D2D_RECT_F.Ptr, rect, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, "void")
    FillRectangle(rect, brush)
      => ComCall(17, this.p, D2D_RECT_F.Ptr, rect, ID2D1Brush, brush, "void")
    DrawRoundedRectangle(roundedRect, brush, strokeWidth, strokeStyle?)
      => ComCall(18, this.p, D2D1_ROUNDED_RECT.Ptr, roundedRect, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, "void")
    FillRoundedRectangle(roundedRect, brush)
      => ComCall(19, this.p, D2D1_ROUNDED_RECT.Ptr, roundedRect, ID2D1Brush, brush, "void")
    DrawEllipse(ellipse, brush, strokeWidth, strokeStyle?)
      => ComCall(20, this.p, D2D1_ELLIPSE.Ptr, ellipse, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, "void")
    FillEllipse(ellipse, brush)
      => ComCall(21, this.p, D2D1_ELLIPSE.Ptr, ellipse, ID2D1Brush, brush, "void")
    DrawGeometry(geometry, brush, strokeWidth, strokeStyle?)
      => ComCall(22, this.p, ID2D1Geometry, geometry, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, "void")
    FillGeometry(geometry, brush, opacityBrush?)
      => ComCall(23, this.p, ID2D1Geometry, geometry, ID2D1Brush, brush, ID2D1Brush, opacityBrush?, "void")
    FillMesh(mesh, brush)
      => ComCall(24, this.p, ID2D1Mesh, mesh, ID2D1Brush, brush, "void")
    FillOpacityMask(opacityMask, brush, content, destinationRectangle?, sourceRectangle?)
      => ComCall(25, this.p, ID2D1Bitmap, opacityMask, ID2D1Brush, brush, D2D1_OPACITY_MASK_CONTENT, content, D2D_RECT_F.Ptr, destinationRectangle?, D2D_RECT_F.Ptr, sourceRectangle?, "void")
    DrawBitmap(bitmap, destinationRectangle?, opacity, interpolationMode, sourceRectangle?)
      => ComCall(26, this.p, ID2D1Bitmap, bitmap, D2D_RECT_F.Ptr, destinationRectangle?, Float32, opacity, D2D1_BITMAP_INTERPOLATION_MODE, interpolationMode, D2D_RECT_F.Ptr, sourceRectangle?, "void")
    DrawText(string, textFormat, layoutRect, defaultFillBrush, options, measuringMode)
      => ComCall(27, this.p, "Str", string, UInt32, string.Length, IDWriteTextFormat, textFormat, D2D_RECT_F.Ptr, layoutRect, ID2D1Brush, defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS, options, DWRITE_MEASURING_MODE, measuringMode, "void")
    DrawTextLayout(origin, textLayout, defaultFillBrush, options)
      => ComCall(28, this.p, D2D_POINT_2F, origin, IDWriteTextLayout, textLayout, ID2D1Brush, defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS, options, "void")
    DrawGlyphRun(baselineOrigin, glyphRun, foregroundBrush, measuringMode)
      => ComCall(29, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, ID2D1Brush, foregroundBrush, DWRITE_MEASURING_MODE, measuringMode, "void")
    SetTransform(transform)
      => ComCall(30, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
    GetTransform(transform)
      => ComCall(31, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
    SetAntialiasMode(antialiasMode)
      => ComCall(32, this.p, D2D1_ANTIALIAS_MODE, antialiasMode, "void")
    GetAntialiasMode()
      => ComCall(33, this.p, D2D1_ANTIALIAS_MODE)
    SetTextAntialiasMode(textAntialiasMode)
      => ComCall(34, this.p, D2D1_TEXT_ANTIALIAS_MODE, textAntialiasMode, "void")
    GetTextAntialiasMode()
      => ComCall(35, this.p, D2D1_TEXT_ANTIALIAS_MODE)
    SetTextRenderingParams(textRenderingParams?)
      => ComCall(36, this.p, IDWriteRenderingParams, textRenderingParams?, "void")
    GetTextRenderingParams(textRenderingParams)
      => ComCall(37, this.p, IDWriteRenderingParams.Ptr, textRenderingParams, "void")
    SetTags(tag1, tag2)
      => ComCall(38, this.p, Int64, tag1, Int64, tag2, "void")
    GetTags(tag1?, tag2?)
      => ComCall(39, this.p, Int64.Ptr, tag1?, Int64.Ptr, tag2?, "void")
    PushLayer(layerParameters, layer?)
      => ComCall(40, this.p, D2D1_LAYER_PARAMETERS.Ptr, layerParameters, ID2D1Layer, layer?, "void")
    PopLayer()
      => ComCall(41, this.p, "void")
    Flush(tag1?, tag2?)
      => ComCall(42, this.p, Int64.Ptr, tag1?, Int64.Ptr, tag2?)
    SaveDrawingState(drawingStateBlock)
      => ComCall(43, this.p, ID2D1DrawingStateBlock, drawingStateBlock, "void")
    RestoreDrawingState(drawingStateBlock)
      => ComCall(44, this.p, ID2D1DrawingStateBlock, drawingStateBlock, "void")
    PushAxisAlignedClip(clipRect, antialiasMode)
      => ComCall(45, this.p, D2D_RECT_F.Ptr, clipRect, D2D1_ANTIALIAS_MODE, antialiasMode, "void")
    PopAxisAlignedClip()
      => ComCall(46, this.p, "void")
    Clear(clearColor?)
      => ComCall(47, this.p, D2D1_COLOR_F.Ptr, clearColor?, "void")
    BeginDraw()
      => ComCall(48, this.p, "void")
    EndDraw(tag1?, tag2?)
      => ComCall(49, this.p, Int64.Ptr, tag1?, Int64.Ptr, tag2?, HRESULT)
    GetPixelFormat()
      => ComCall(50, this.p, D2D1_PIXEL_FORMAT)
    SetDpi(dpiX, dpiY)
      => ComCall(51, this.p, Float32, dpiX, Float32, dpiY, "void")
    GetDpi(dpiX, dpiY)
      => ComCall(52, this.p, Float32.Ptr, dpiX, Float32.Ptr, dpiY, "void")
    GetSize()
      => ComCall(53, this.p, D2D_SIZE_F)
    GetPixelSize()
      => ComCall(54, this.p, D2D_SIZE_U)
    GetMaximumBitmapSize()
      => ComCall(55, this.p, UInt32)
    IsSupported(renderTargetProperties)
      => ComCall(56, this.p, D2D1_RENDER_TARGET_PROPERTIES.Ptr, renderTargetProperties, BOOL)
}
struct ID2D1BitmapRenderTarget extends ID2D1RenderTarget {
    static IID := "{2CD90695-12E2-11DC-9FED-001143A055F9}"
    GetBitmap(bitmap)
      => ComCall(57, this.p, ID2D1Bitmap.Ptr, bitmap)
}
struct ID2D1HwndRenderTarget extends ID2D1RenderTarget {
    static IID := "{2CD90698-12E2-11DC-9FED-001143A055F9}"
    CheckWindowState()
      => ComCall(57, this.p, D2D1_WINDOW_STATE)
    Resize(pixelSize)
      => ComCall(58, this.p, D2D_SIZE_U.Ptr, pixelSize)
    GetHwnd()
      => ComCall(59, this.p, HWND)
}
struct ID2D1GdiInteropRenderTarget extends IUnknown {
    static IID := "{E0DB51C3-6F77-4BAE-B3D5-E47509B35838}"
    GetDC(mode, hdc)
      => ComCall(3, this.p, D2D1_DC_INITIALIZE_MODE, mode, HDC.Ptr, hdc)
    ReleaseDC(update?)
      => ComCall(4, this.p, RECT.Ptr, update?)
}
struct ID2D1DCRenderTarget extends ID2D1RenderTarget {
    static IID := "{1C51BC64-DE61-46FD-9899-63A5D8F03950}"
    BindDC(hDC1, pSubRect)
      => ComCall(57, this.p, HDC, hDC1, RECT.Ptr, pSubRect)
}
struct ID2D1Factory extends IUnknown {
    static IID := "{06152247-6F50-465A-9245-118BFD3B6007}"
    ReloadSystemMetrics()
      => ComCall(3, this.p)
    GetDesktopDpi(dpiX, dpiY)
      => ComCall(4, this.p, Float32.Ptr, dpiX, Float32.Ptr, dpiY, "void")
    CreateRectangleGeometry(rectangle, rectangleGeometry)
      => ComCall(5, this.p, D2D_RECT_F.Ptr, rectangle, ID2D1RectangleGeometry.Ptr, rectangleGeometry)
    CreateRoundedRectangleGeometry(roundedRectangle, roundedRectangleGeometry)
      => ComCall(6, this.p, D2D1_ROUNDED_RECT.Ptr, roundedRectangle, ID2D1RoundedRectangleGeometry.Ptr, roundedRectangleGeometry)
    CreateEllipseGeometry(ellipse, ellipseGeometry)
      => ComCall(7, this.p, D2D1_ELLIPSE.Ptr, ellipse, ID2D1EllipseGeometry.Ptr, ellipseGeometry)
    CreateGeometryGroup(fillMode, geometries, geometryGroup)
      => ComCall(8, this.p, D2D1_FILL_MODE, fillMode, ID2D1Geometry.Ptr, geometries, UInt32, geometries.Length, ID2D1GeometryGroup.Ptr, geometryGroup)
    CreateTransformedGeometry(sourceGeometry, transform, transformedGeometry)
      => ComCall(9, this.p, ID2D1Geometry, sourceGeometry, D2D_MATRIX_3X2_F.Ptr, transform, ID2D1TransformedGeometry.Ptr, transformedGeometry)
    CreatePathGeometry(pathGeometry)
      => ComCall(10, this.p, ID2D1PathGeometry.Ptr, pathGeometry)
    CreateStrokeStyle(strokeStyleProperties, dashes?, strokeStyle)
      => ComCall(11, this.p, D2D1_STROKE_STYLE_PROPERTIES.Ptr, strokeStyleProperties, Float32.Ptr, dashes?, UInt32, dashes?.Length ?? 0, ID2D1StrokeStyle.Ptr, strokeStyle)
    CreateDrawingStateBlock(drawingStateDescription?, textRenderingParams?, drawingStateBlock)
      => ComCall(12, this.p, D2D1_DRAWING_STATE_DESCRIPTION.Ptr, drawingStateDescription?, IDWriteRenderingParams, textRenderingParams?, ID2D1DrawingStateBlock.Ptr, drawingStateBlock)
    CreateWicBitmapRenderTarget(target, renderTargetProperties, renderTarget)
      => ComCall(13, this.p, IWICBitmap, target, D2D1_RENDER_TARGET_PROPERTIES.Ptr, renderTargetProperties, ID2D1RenderTarget.Ptr, renderTarget)
    CreateHwndRenderTarget(renderTargetProperties, hwndRenderTargetProperties, hwndRenderTarget)
      => ComCall(14, this.p, D2D1_RENDER_TARGET_PROPERTIES.Ptr, renderTargetProperties, D2D1_HWND_RENDER_TARGET_PROPERTIES.Ptr, hwndRenderTargetProperties, ID2D1HwndRenderTarget.Ptr, hwndRenderTarget)
    CreateDxgiSurfaceRenderTarget(dxgiSurface, renderTargetProperties, renderTarget)
      => ComCall(15, this.p, IDXGISurface, dxgiSurface, D2D1_RENDER_TARGET_PROPERTIES.Ptr, renderTargetProperties, ID2D1RenderTarget.Ptr, renderTarget)
    CreateDCRenderTarget(renderTargetProperties, dcRenderTarget)
      => ComCall(16, this.p, D2D1_RENDER_TARGET_PROPERTIES.Ptr, renderTargetProperties, ID2D1DCRenderTarget.Ptr, dcRenderTarget)
}
struct D2D1_CHANNEL_SELECTOR extends Int32 {
    static D2D1_CHANNEL_SELECTOR_R := 0
    static D2D1_CHANNEL_SELECTOR_G := 1
    static D2D1_CHANNEL_SELECTOR_B := 2
    static D2D1_CHANNEL_SELECTOR_A := 3
}
struct D2D1_BITMAPSOURCE_ORIENTATION extends Int32 {
    static D2D1_BITMAPSOURCE_ORIENTATION_DEFAULT := 1
    static D2D1_BITMAPSOURCE_ORIENTATION_FLIP_HORIZONTAL := 2
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180 := 3
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL := 4
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL := 5
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90 := 6
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL := 7
    static D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270 := 8
}
struct D2D1_GAUSSIANBLUR_PROP extends Int32 {
    static D2D1_GAUSSIANBLUR_PROP_STANDARD_DEVIATION := 0
    static D2D1_GAUSSIANBLUR_PROP_OPTIMIZATION := 1
    static D2D1_GAUSSIANBLUR_PROP_BORDER_MODE := 2
}
struct D2D1_GAUSSIANBLUR_OPTIMIZATION extends Int32 {
    static D2D1_GAUSSIANBLUR_OPTIMIZATION_SPEED := 0
    static D2D1_GAUSSIANBLUR_OPTIMIZATION_BALANCED := 1
    static D2D1_GAUSSIANBLUR_OPTIMIZATION_QUALITY := 2
}
struct D2D1_DIRECTIONALBLUR_PROP extends Int32 {
    static D2D1_DIRECTIONALBLUR_PROP_STANDARD_DEVIATION := 0
    static D2D1_DIRECTIONALBLUR_PROP_ANGLE := 1
    static D2D1_DIRECTIONALBLUR_PROP_OPTIMIZATION := 2
    static D2D1_DIRECTIONALBLUR_PROP_BORDER_MODE := 3
}
struct D2D1_DIRECTIONALBLUR_OPTIMIZATION extends Int32 {
    static D2D1_DIRECTIONALBLUR_OPTIMIZATION_SPEED := 0
    static D2D1_DIRECTIONALBLUR_OPTIMIZATION_BALANCED := 1
    static D2D1_DIRECTIONALBLUR_OPTIMIZATION_QUALITY := 2
}
struct D2D1_SHADOW_PROP extends Int32 {
    static D2D1_SHADOW_PROP_BLUR_STANDARD_DEVIATION := 0
    static D2D1_SHADOW_PROP_COLOR := 1
    static D2D1_SHADOW_PROP_OPTIMIZATION := 2
}
struct D2D1_SHADOW_OPTIMIZATION extends Int32 {
    static D2D1_SHADOW_OPTIMIZATION_SPEED := 0
    static D2D1_SHADOW_OPTIMIZATION_BALANCED := 1
    static D2D1_SHADOW_OPTIMIZATION_QUALITY := 2
}
struct D2D1_BLEND_PROP extends Int32 {
    static D2D1_BLEND_PROP_MODE := 0
}
struct D2D1_SATURATION_PROP extends Int32 {
    static D2D1_SATURATION_PROP_SATURATION := 0
}
struct D2D1_HUEROTATION_PROP extends Int32 {
    static D2D1_HUEROTATION_PROP_ANGLE := 0
}
struct D2D1_COLORMATRIX_PROP extends Int32 {
    static D2D1_COLORMATRIX_PROP_COLOR_MATRIX := 0
    static D2D1_COLORMATRIX_PROP_ALPHA_MODE := 1
    static D2D1_COLORMATRIX_PROP_CLAMP_OUTPUT := 2
}
struct D2D1_BITMAPSOURCE_PROP extends Int32 {
    static D2D1_BITMAPSOURCE_PROP_WIC_BITMAP_SOURCE := 0
    static D2D1_BITMAPSOURCE_PROP_SCALE := 1
    static D2D1_BITMAPSOURCE_PROP_INTERPOLATION_MODE := 2
    static D2D1_BITMAPSOURCE_PROP_ENABLE_DPI_CORRECTION := 3
    static D2D1_BITMAPSOURCE_PROP_ALPHA_MODE := 4
    static D2D1_BITMAPSOURCE_PROP_ORIENTATION := 5
}
struct D2D1_BITMAPSOURCE_INTERPOLATION_MODE extends Int32 {
    static D2D1_BITMAPSOURCE_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_BITMAPSOURCE_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_BITMAPSOURCE_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FANT := 6
    static D2D1_BITMAPSOURCE_INTERPOLATION_MODE_MIPMAP_LINEAR := 7
}
struct D2D1_BITMAPSOURCE_ALPHA_MODE extends Int32 {
    static D2D1_BITMAPSOURCE_ALPHA_MODE_PREMULTIPLIED := 1
    static D2D1_BITMAPSOURCE_ALPHA_MODE_STRAIGHT := 2
}
struct D2D1_COMPOSITE_PROP extends Int32 {
    static D2D1_COMPOSITE_PROP_MODE := 0
}
struct D2D1_3DTRANSFORM_PROP extends Int32 {
    static D2D1_3DTRANSFORM_PROP_INTERPOLATION_MODE := 0
    static D2D1_3DTRANSFORM_PROP_BORDER_MODE := 1
    static D2D1_3DTRANSFORM_PROP_TRANSFORM_MATRIX := 2
}
struct D2D1_3DTRANSFORM_INTERPOLATION_MODE extends Int32 {
    static D2D1_3DTRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_3DTRANSFORM_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_3DTRANSFORM_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_3DTRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_3DTRANSFORM_INTERPOLATION_MODE_ANISOTROPIC := 4
}
struct D2D1_3DPERSPECTIVETRANSFORM_PROP extends Int32 {
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_INTERPOLATION_MODE := 0
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_BORDER_MODE := 1
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_DEPTH := 2
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_PERSPECTIVE_ORIGIN := 3
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_LOCAL_OFFSET := 4
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_GLOBAL_OFFSET := 5
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION_ORIGIN := 6
    static D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION := 7
}
struct D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE extends Int32 {
    static D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC := 4
}
struct D2D1_2DAFFINETRANSFORM_PROP extends Int32 {
    static D2D1_2DAFFINETRANSFORM_PROP_INTERPOLATION_MODE := 0
    static D2D1_2DAFFINETRANSFORM_PROP_BORDER_MODE := 1
    static D2D1_2DAFFINETRANSFORM_PROP_TRANSFORM_MATRIX := 2
    static D2D1_2DAFFINETRANSFORM_PROP_SHARPNESS := 3
}
struct D2D1_DPICOMPENSATION_PROP extends Int32 {
    static D2D1_DPICOMPENSATION_PROP_INTERPOLATION_MODE := 0
    static D2D1_DPICOMPENSATION_PROP_BORDER_MODE := 1
    static D2D1_DPICOMPENSATION_PROP_INPUT_DPI := 2
}
struct D2D1_DPICOMPENSATION_INTERPOLATION_MODE extends Int32 {
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_ANISOTROPIC := 4
    static D2D1_DPICOMPENSATION_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_SCALE_PROP extends Int32 {
    static D2D1_SCALE_PROP_SCALE := 0
    static D2D1_SCALE_PROP_CENTER_POINT := 1
    static D2D1_SCALE_PROP_INTERPOLATION_MODE := 2
    static D2D1_SCALE_PROP_BORDER_MODE := 3
    static D2D1_SCALE_PROP_SHARPNESS := 4
}
struct D2D1_SCALE_INTERPOLATION_MODE extends Int32 {
    static D2D1_SCALE_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_SCALE_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_SCALE_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_SCALE_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_SCALE_INTERPOLATION_MODE_ANISOTROPIC := 4
    static D2D1_SCALE_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_TURBULENCE_PROP extends Int32 {
    static D2D1_TURBULENCE_PROP_OFFSET := 0
    static D2D1_TURBULENCE_PROP_SIZE := 1
    static D2D1_TURBULENCE_PROP_BASE_FREQUENCY := 2
    static D2D1_TURBULENCE_PROP_NUM_OCTAVES := 3
    static D2D1_TURBULENCE_PROP_SEED := 4
    static D2D1_TURBULENCE_PROP_NOISE := 5
    static D2D1_TURBULENCE_PROP_STITCHABLE := 6
}
struct D2D1_DISPLACEMENTMAP_PROP extends Int32 {
    static D2D1_DISPLACEMENTMAP_PROP_SCALE := 0
    static D2D1_DISPLACEMENTMAP_PROP_X_CHANNEL_SELECT := 1
    static D2D1_DISPLACEMENTMAP_PROP_Y_CHANNEL_SELECT := 2
}
struct D2D1_COLORMANAGEMENT_PROP extends Int32 {
    static D2D1_COLORMANAGEMENT_PROP_SOURCE_COLOR_CONTEXT := 0
    static D2D1_COLORMANAGEMENT_PROP_SOURCE_RENDERING_INTENT := 1
    static D2D1_COLORMANAGEMENT_PROP_DESTINATION_COLOR_CONTEXT := 2
    static D2D1_COLORMANAGEMENT_PROP_DESTINATION_RENDERING_INTENT := 3
    static D2D1_COLORMANAGEMENT_PROP_ALPHA_MODE := 4
    static D2D1_COLORMANAGEMENT_PROP_QUALITY := 5
}
struct D2D1_COLORMANAGEMENT_ALPHA_MODE extends Int32 {
    static D2D1_COLORMANAGEMENT_ALPHA_MODE_PREMULTIPLIED := 1
    static D2D1_COLORMANAGEMENT_ALPHA_MODE_STRAIGHT := 2
}
struct D2D1_COLORMANAGEMENT_QUALITY extends Int32 {
    static D2D1_COLORMANAGEMENT_QUALITY_PROOF := 0
    static D2D1_COLORMANAGEMENT_QUALITY_NORMAL := 1
    static D2D1_COLORMANAGEMENT_QUALITY_BEST := 2
}
struct D2D1_COLORMANAGEMENT_RENDERING_INTENT extends Int32 {
    static D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL := 0
    static D2D1_COLORMANAGEMENT_RENDERING_INTENT_RELATIVE_COLORIMETRIC := 1
    static D2D1_COLORMANAGEMENT_RENDERING_INTENT_SATURATION := 2
    static D2D1_COLORMANAGEMENT_RENDERING_INTENT_ABSOLUTE_COLORIMETRIC := 3
}
struct D2D1_HISTOGRAM_PROP extends Int32 {
    static D2D1_HISTOGRAM_PROP_NUM_BINS := 0
    static D2D1_HISTOGRAM_PROP_CHANNEL_SELECT := 1
    static D2D1_HISTOGRAM_PROP_HISTOGRAM_OUTPUT := 2
}
struct D2D1_POINTSPECULAR_PROP extends Int32 {
    static D2D1_POINTSPECULAR_PROP_LIGHT_POSITION := 0
    static D2D1_POINTSPECULAR_PROP_SPECULAR_EXPONENT := 1
    static D2D1_POINTSPECULAR_PROP_SPECULAR_CONSTANT := 2
    static D2D1_POINTSPECULAR_PROP_SURFACE_SCALE := 3
    static D2D1_POINTSPECULAR_PROP_COLOR := 4
    static D2D1_POINTSPECULAR_PROP_KERNEL_UNIT_LENGTH := 5
    static D2D1_POINTSPECULAR_PROP_SCALE_MODE := 6
}
struct D2D1_POINTSPECULAR_SCALE_MODE extends Int32 {
    static D2D1_POINTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_POINTSPECULAR_SCALE_MODE_LINEAR := 1
    static D2D1_POINTSPECULAR_SCALE_MODE_CUBIC := 2
    static D2D1_POINTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_POINTSPECULAR_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_POINTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_SPOTSPECULAR_PROP extends Int32 {
    static D2D1_SPOTSPECULAR_PROP_LIGHT_POSITION := 0
    static D2D1_SPOTSPECULAR_PROP_POINTS_AT := 1
    static D2D1_SPOTSPECULAR_PROP_FOCUS := 2
    static D2D1_SPOTSPECULAR_PROP_LIMITING_CONE_ANGLE := 3
    static D2D1_SPOTSPECULAR_PROP_SPECULAR_EXPONENT := 4
    static D2D1_SPOTSPECULAR_PROP_SPECULAR_CONSTANT := 5
    static D2D1_SPOTSPECULAR_PROP_SURFACE_SCALE := 6
    static D2D1_SPOTSPECULAR_PROP_COLOR := 7
    static D2D1_SPOTSPECULAR_PROP_KERNEL_UNIT_LENGTH := 8
    static D2D1_SPOTSPECULAR_PROP_SCALE_MODE := 9
}
struct D2D1_SPOTSPECULAR_SCALE_MODE extends Int32 {
    static D2D1_SPOTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_SPOTSPECULAR_SCALE_MODE_LINEAR := 1
    static D2D1_SPOTSPECULAR_SCALE_MODE_CUBIC := 2
    static D2D1_SPOTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_SPOTSPECULAR_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_SPOTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_DISTANTSPECULAR_PROP extends Int32 {
    static D2D1_DISTANTSPECULAR_PROP_AZIMUTH := 0
    static D2D1_DISTANTSPECULAR_PROP_ELEVATION := 1
    static D2D1_DISTANTSPECULAR_PROP_SPECULAR_EXPONENT := 2
    static D2D1_DISTANTSPECULAR_PROP_SPECULAR_CONSTANT := 3
    static D2D1_DISTANTSPECULAR_PROP_SURFACE_SCALE := 4
    static D2D1_DISTANTSPECULAR_PROP_COLOR := 5
    static D2D1_DISTANTSPECULAR_PROP_KERNEL_UNIT_LENGTH := 6
    static D2D1_DISTANTSPECULAR_PROP_SCALE_MODE := 7
}
struct D2D1_DISTANTSPECULAR_SCALE_MODE extends Int32 {
    static D2D1_DISTANTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_DISTANTSPECULAR_SCALE_MODE_LINEAR := 1
    static D2D1_DISTANTSPECULAR_SCALE_MODE_CUBIC := 2
    static D2D1_DISTANTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_DISTANTSPECULAR_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_DISTANTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_POINTDIFFUSE_PROP extends Int32 {
    static D2D1_POINTDIFFUSE_PROP_LIGHT_POSITION := 0
    static D2D1_POINTDIFFUSE_PROP_DIFFUSE_CONSTANT := 1
    static D2D1_POINTDIFFUSE_PROP_SURFACE_SCALE := 2
    static D2D1_POINTDIFFUSE_PROP_COLOR := 3
    static D2D1_POINTDIFFUSE_PROP_KERNEL_UNIT_LENGTH := 4
    static D2D1_POINTDIFFUSE_PROP_SCALE_MODE := 5
}
struct D2D1_POINTDIFFUSE_SCALE_MODE extends Int32 {
    static D2D1_POINTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_POINTDIFFUSE_SCALE_MODE_LINEAR := 1
    static D2D1_POINTDIFFUSE_SCALE_MODE_CUBIC := 2
    static D2D1_POINTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_POINTDIFFUSE_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_POINTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_SPOTDIFFUSE_PROP extends Int32 {
    static D2D1_SPOTDIFFUSE_PROP_LIGHT_POSITION := 0
    static D2D1_SPOTDIFFUSE_PROP_POINTS_AT := 1
    static D2D1_SPOTDIFFUSE_PROP_FOCUS := 2
    static D2D1_SPOTDIFFUSE_PROP_LIMITING_CONE_ANGLE := 3
    static D2D1_SPOTDIFFUSE_PROP_DIFFUSE_CONSTANT := 4
    static D2D1_SPOTDIFFUSE_PROP_SURFACE_SCALE := 5
    static D2D1_SPOTDIFFUSE_PROP_COLOR := 6
    static D2D1_SPOTDIFFUSE_PROP_KERNEL_UNIT_LENGTH := 7
    static D2D1_SPOTDIFFUSE_PROP_SCALE_MODE := 8
}
struct D2D1_SPOTDIFFUSE_SCALE_MODE extends Int32 {
    static D2D1_SPOTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_SPOTDIFFUSE_SCALE_MODE_LINEAR := 1
    static D2D1_SPOTDIFFUSE_SCALE_MODE_CUBIC := 2
    static D2D1_SPOTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_SPOTDIFFUSE_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_SPOTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_DISTANTDIFFUSE_PROP extends Int32 {
    static D2D1_DISTANTDIFFUSE_PROP_AZIMUTH := 0
    static D2D1_DISTANTDIFFUSE_PROP_ELEVATION := 1
    static D2D1_DISTANTDIFFUSE_PROP_DIFFUSE_CONSTANT := 2
    static D2D1_DISTANTDIFFUSE_PROP_SURFACE_SCALE := 3
    static D2D1_DISTANTDIFFUSE_PROP_COLOR := 4
    static D2D1_DISTANTDIFFUSE_PROP_KERNEL_UNIT_LENGTH := 5
    static D2D1_DISTANTDIFFUSE_PROP_SCALE_MODE := 6
}
struct D2D1_DISTANTDIFFUSE_SCALE_MODE extends Int32 {
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_LINEAR := 1
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_CUBIC := 2
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_DISTANTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_FLOOD_PROP extends Int32 {
    static D2D1_FLOOD_PROP_COLOR := 0
}
struct D2D1_LINEARTRANSFER_PROP extends Int32 {
    static D2D1_LINEARTRANSFER_PROP_RED_Y_INTERCEPT := 0
    static D2D1_LINEARTRANSFER_PROP_RED_SLOPE := 1
    static D2D1_LINEARTRANSFER_PROP_RED_DISABLE := 2
    static D2D1_LINEARTRANSFER_PROP_GREEN_Y_INTERCEPT := 3
    static D2D1_LINEARTRANSFER_PROP_GREEN_SLOPE := 4
    static D2D1_LINEARTRANSFER_PROP_GREEN_DISABLE := 5
    static D2D1_LINEARTRANSFER_PROP_BLUE_Y_INTERCEPT := 6
    static D2D1_LINEARTRANSFER_PROP_BLUE_SLOPE := 7
    static D2D1_LINEARTRANSFER_PROP_BLUE_DISABLE := 8
    static D2D1_LINEARTRANSFER_PROP_ALPHA_Y_INTERCEPT := 9
    static D2D1_LINEARTRANSFER_PROP_ALPHA_SLOPE := 10
    static D2D1_LINEARTRANSFER_PROP_ALPHA_DISABLE := 11
    static D2D1_LINEARTRANSFER_PROP_CLAMP_OUTPUT := 12
}
struct D2D1_GAMMATRANSFER_PROP extends Int32 {
    static D2D1_GAMMATRANSFER_PROP_RED_AMPLITUDE := 0
    static D2D1_GAMMATRANSFER_PROP_RED_EXPONENT := 1
    static D2D1_GAMMATRANSFER_PROP_RED_OFFSET := 2
    static D2D1_GAMMATRANSFER_PROP_RED_DISABLE := 3
    static D2D1_GAMMATRANSFER_PROP_GREEN_AMPLITUDE := 4
    static D2D1_GAMMATRANSFER_PROP_GREEN_EXPONENT := 5
    static D2D1_GAMMATRANSFER_PROP_GREEN_OFFSET := 6
    static D2D1_GAMMATRANSFER_PROP_GREEN_DISABLE := 7
    static D2D1_GAMMATRANSFER_PROP_BLUE_AMPLITUDE := 8
    static D2D1_GAMMATRANSFER_PROP_BLUE_EXPONENT := 9
    static D2D1_GAMMATRANSFER_PROP_BLUE_OFFSET := 10
    static D2D1_GAMMATRANSFER_PROP_BLUE_DISABLE := 11
    static D2D1_GAMMATRANSFER_PROP_ALPHA_AMPLITUDE := 12
    static D2D1_GAMMATRANSFER_PROP_ALPHA_EXPONENT := 13
    static D2D1_GAMMATRANSFER_PROP_ALPHA_OFFSET := 14
    static D2D1_GAMMATRANSFER_PROP_ALPHA_DISABLE := 15
    static D2D1_GAMMATRANSFER_PROP_CLAMP_OUTPUT := 16
}
struct D2D1_TABLETRANSFER_PROP extends Int32 {
    static D2D1_TABLETRANSFER_PROP_RED_TABLE := 0
    static D2D1_TABLETRANSFER_PROP_RED_DISABLE := 1
    static D2D1_TABLETRANSFER_PROP_GREEN_TABLE := 2
    static D2D1_TABLETRANSFER_PROP_GREEN_DISABLE := 3
    static D2D1_TABLETRANSFER_PROP_BLUE_TABLE := 4
    static D2D1_TABLETRANSFER_PROP_BLUE_DISABLE := 5
    static D2D1_TABLETRANSFER_PROP_ALPHA_TABLE := 6
    static D2D1_TABLETRANSFER_PROP_ALPHA_DISABLE := 7
    static D2D1_TABLETRANSFER_PROP_CLAMP_OUTPUT := 8
}
struct D2D1_DISCRETETRANSFER_PROP extends Int32 {
    static D2D1_DISCRETETRANSFER_PROP_RED_TABLE := 0
    static D2D1_DISCRETETRANSFER_PROP_RED_DISABLE := 1
    static D2D1_DISCRETETRANSFER_PROP_GREEN_TABLE := 2
    static D2D1_DISCRETETRANSFER_PROP_GREEN_DISABLE := 3
    static D2D1_DISCRETETRANSFER_PROP_BLUE_TABLE := 4
    static D2D1_DISCRETETRANSFER_PROP_BLUE_DISABLE := 5
    static D2D1_DISCRETETRANSFER_PROP_ALPHA_TABLE := 6
    static D2D1_DISCRETETRANSFER_PROP_ALPHA_DISABLE := 7
    static D2D1_DISCRETETRANSFER_PROP_CLAMP_OUTPUT := 8
}
struct D2D1_CONVOLVEMATRIX_PROP extends Int32 {
    static D2D1_CONVOLVEMATRIX_PROP_KERNEL_UNIT_LENGTH := 0
    static D2D1_CONVOLVEMATRIX_PROP_SCALE_MODE := 1
    static D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_X := 2
    static D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_Y := 3
    static D2D1_CONVOLVEMATRIX_PROP_KERNEL_MATRIX := 4
    static D2D1_CONVOLVEMATRIX_PROP_DIVISOR := 5
    static D2D1_CONVOLVEMATRIX_PROP_BIAS := 6
    static D2D1_CONVOLVEMATRIX_PROP_KERNEL_OFFSET := 7
    static D2D1_CONVOLVEMATRIX_PROP_PRESERVE_ALPHA := 8
    static D2D1_CONVOLVEMATRIX_PROP_BORDER_MODE := 9
    static D2D1_CONVOLVEMATRIX_PROP_CLAMP_OUTPUT := 10
}
struct D2D1_CONVOLVEMATRIX_SCALE_MODE extends Int32 {
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_LINEAR := 1
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_CUBIC := 2
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_ANISOTROPIC := 4
    static D2D1_CONVOLVEMATRIX_SCALE_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_BRIGHTNESS_PROP extends Int32 {
    static D2D1_BRIGHTNESS_PROP_WHITE_POINT := 0
    static D2D1_BRIGHTNESS_PROP_BLACK_POINT := 1
}
struct D2D1_ARITHMETICCOMPOSITE_PROP extends Int32 {
    static D2D1_ARITHMETICCOMPOSITE_PROP_COEFFICIENTS := 0
    static D2D1_ARITHMETICCOMPOSITE_PROP_CLAMP_OUTPUT := 1
}
struct D2D1_CROP_PROP extends Int32 {
    static D2D1_CROP_PROP_RECT := 0
    static D2D1_CROP_PROP_BORDER_MODE := 1
}
struct D2D1_BORDER_PROP extends Int32 {
    static D2D1_BORDER_PROP_EDGE_MODE_X := 0
    static D2D1_BORDER_PROP_EDGE_MODE_Y := 1
}
struct D2D1_BORDER_EDGE_MODE extends Int32 {
    static D2D1_BORDER_EDGE_MODE_CLAMP := 0
    static D2D1_BORDER_EDGE_MODE_WRAP := 1
    static D2D1_BORDER_EDGE_MODE_MIRROR := 2
}
struct D2D1_MORPHOLOGY_PROP extends Int32 {
    static D2D1_MORPHOLOGY_PROP_MODE := 0
    static D2D1_MORPHOLOGY_PROP_WIDTH := 1
    static D2D1_MORPHOLOGY_PROP_HEIGHT := 2
}
struct D2D1_MORPHOLOGY_MODE extends Int32 {
    static D2D1_MORPHOLOGY_MODE_ERODE := 0
    static D2D1_MORPHOLOGY_MODE_DILATE := 1
}
struct D2D1_TILE_PROP extends Int32 {
    static D2D1_TILE_PROP_RECT := 0
}
struct D2D1_ATLAS_PROP extends Int32 {
    static D2D1_ATLAS_PROP_INPUT_RECT := 0
    static D2D1_ATLAS_PROP_INPUT_PADDING_RECT := 1
}
struct D2D1_OPACITYMETADATA_PROP extends Int32 {
    static D2D1_OPACITYMETADATA_PROP_INPUT_OPAQUE_RECT := 0
}
struct PD2D1_EFFECT_FACTORY extends FunctionPointer {
    static Types := [IUnknown.Ptr, HRESULT]
}
struct D2D1_PROPERTY_TYPE extends Int32 {
    static D2D1_PROPERTY_TYPE_UNKNOWN := 0
    static D2D1_PROPERTY_TYPE_STRING := 1
    static D2D1_PROPERTY_TYPE_BOOL := 2
    static D2D1_PROPERTY_TYPE_UINT32 := 3
    static D2D1_PROPERTY_TYPE_INT32 := 4
    static D2D1_PROPERTY_TYPE_FLOAT := 5
    static D2D1_PROPERTY_TYPE_VECTOR2 := 6
    static D2D1_PROPERTY_TYPE_VECTOR3 := 7
    static D2D1_PROPERTY_TYPE_VECTOR4 := 8
    static D2D1_PROPERTY_TYPE_BLOB := 9
    static D2D1_PROPERTY_TYPE_IUNKNOWN := 10
    static D2D1_PROPERTY_TYPE_ENUM := 11
    static D2D1_PROPERTY_TYPE_ARRAY := 12
    static D2D1_PROPERTY_TYPE_CLSID := 13
    static D2D1_PROPERTY_TYPE_MATRIX_3X2 := 14
    static D2D1_PROPERTY_TYPE_MATRIX_4X3 := 15
    static D2D1_PROPERTY_TYPE_MATRIX_4X4 := 16
    static D2D1_PROPERTY_TYPE_MATRIX_5X4 := 17
    static D2D1_PROPERTY_TYPE_COLOR_CONTEXT := 18
}
struct D2D1_PROPERTY extends Int32 {
    static D2D1_PROPERTY_CLSID := -2147483648
    static D2D1_PROPERTY_DISPLAYNAME := -2147483647
    static D2D1_PROPERTY_AUTHOR := -2147483646
    static D2D1_PROPERTY_CATEGORY := -2147483645
    static D2D1_PROPERTY_DESCRIPTION := -2147483644
    static D2D1_PROPERTY_INPUTS := -2147483643
    static D2D1_PROPERTY_CACHED := -2147483642
    static D2D1_PROPERTY_PRECISION := -2147483641
    static D2D1_PROPERTY_MIN_INPUTS := -2147483640
    static D2D1_PROPERTY_MAX_INPUTS := -2147483639
}
struct D2D1_SUBPROPERTY extends Int32 {
    static D2D1_SUBPROPERTY_DISPLAYNAME := -2147483648
    static D2D1_SUBPROPERTY_ISREADONLY := -2147483647
    static D2D1_SUBPROPERTY_MIN := -2147483646
    static D2D1_SUBPROPERTY_MAX := -2147483645
    static D2D1_SUBPROPERTY_DEFAULT := -2147483644
    static D2D1_SUBPROPERTY_FIELDS := -2147483643
    static D2D1_SUBPROPERTY_INDEX := -2147483642
}
struct D2D1_BITMAP_OPTIONS extends Int32 {
    static D2D1_BITMAP_OPTIONS_NONE := 0
    static D2D1_BITMAP_OPTIONS_TARGET := 1
    static D2D1_BITMAP_OPTIONS_CANNOT_DRAW := 2
    static D2D1_BITMAP_OPTIONS_CPU_READ := 4
    static D2D1_BITMAP_OPTIONS_GDI_COMPATIBLE := 8
}
struct D2D1_BUFFER_PRECISION extends Int32 {
    static D2D1_BUFFER_PRECISION_UNKNOWN := 0
    static D2D1_BUFFER_PRECISION_8BPC_UNORM := 1
    static D2D1_BUFFER_PRECISION_8BPC_UNORM_SRGB := 2
    static D2D1_BUFFER_PRECISION_16BPC_UNORM := 3
    static D2D1_BUFFER_PRECISION_16BPC_FLOAT := 4
    static D2D1_BUFFER_PRECISION_32BPC_FLOAT := 5
}
struct D2D1_MAP_OPTIONS extends Int32 {
    static D2D1_MAP_OPTIONS_NONE := 0
    static D2D1_MAP_OPTIONS_READ := 1
    static D2D1_MAP_OPTIONS_WRITE := 2
    static D2D1_MAP_OPTIONS_DISCARD := 4
}
struct D2D1_INTERPOLATION_MODE extends Int32 {
    static D2D1_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_INTERPOLATION_MODE_ANISOTROPIC := 4
    static D2D1_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_UNIT_MODE extends Int32 {
    static D2D1_UNIT_MODE_DIPS := 0
    static D2D1_UNIT_MODE_PIXELS := 1
}
struct D2D1_COLOR_SPACE extends Int32 {
    static D2D1_COLOR_SPACE_CUSTOM := 0
    static D2D1_COLOR_SPACE_SRGB := 1
    static D2D1_COLOR_SPACE_SCRGB := 2
}
struct D2D1_DEVICE_CONTEXT_OPTIONS extends Int32 {
    static D2D1_DEVICE_CONTEXT_OPTIONS_NONE := 0
    static D2D1_DEVICE_CONTEXT_OPTIONS_ENABLE_MULTITHREADED_OPTIMIZATIONS := 1
}
struct D2D1_STROKE_TRANSFORM_TYPE extends Int32 {
    static D2D1_STROKE_TRANSFORM_TYPE_NORMAL := 0
    static D2D1_STROKE_TRANSFORM_TYPE_FIXED := 1
    static D2D1_STROKE_TRANSFORM_TYPE_HAIRLINE := 2
}
struct D2D1_PRIMITIVE_BLEND extends Int32 {
    static D2D1_PRIMITIVE_BLEND_SOURCE_OVER := 0
    static D2D1_PRIMITIVE_BLEND_COPY := 1
    static D2D1_PRIMITIVE_BLEND_MIN := 2
    static D2D1_PRIMITIVE_BLEND_ADD := 3
    static D2D1_PRIMITIVE_BLEND_MAX := 4
}
struct D2D1_THREADING_MODE extends Int32 {
    static D2D1_THREADING_MODE_SINGLE_THREADED := 0
    static D2D1_THREADING_MODE_MULTI_THREADED := 1
}
struct D2D1_COLOR_INTERPOLATION_MODE extends Int32 {
    static D2D1_COLOR_INTERPOLATION_MODE_STRAIGHT := 0
    static D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED := 1
}
struct D2D1_BITMAP_PROPERTIES1 {
    pixelFormat : D2D1_PIXEL_FORMAT
    dpiX : Float32
    dpiY : Float32
    bitmapOptions : D2D1_BITMAP_OPTIONS
    colorContext : ID2D1ColorContext
}
struct D2D1_MAPPED_RECT {
    pitch : UInt32
    bits : UInt8.Ptr
}
struct D2D1_RENDERING_CONTROLS {
    bufferPrecision : D2D1_BUFFER_PRECISION
    tileSize : D2D_SIZE_U
}
struct D2D1_EFFECT_INPUT_DESCRIPTION {
    effect : ID2D1Effect
    inputIndex : UInt32
    inputRectangle : D2D_RECT_F
}
struct D2D1_POINT_DESCRIPTION {
    point : D2D_POINT_2F
    unitTangentVector : D2D_POINT_2F
    endSegment : UInt32
    endFigure : UInt32
    lengthToEndSegment : Float32
}
struct D2D1_IMAGE_BRUSH_PROPERTIES {
    sourceRectangle : D2D_RECT_F
    extendModeX : D2D1_EXTEND_MODE
    extendModeY : D2D1_EXTEND_MODE
    interpolationMode : D2D1_INTERPOLATION_MODE
}
struct D2D1_BITMAP_BRUSH_PROPERTIES1 {
    extendModeX : D2D1_EXTEND_MODE
    extendModeY : D2D1_EXTEND_MODE
    interpolationMode : D2D1_INTERPOLATION_MODE
}
struct D2D1_STROKE_STYLE_PROPERTIES1 {
    startCap : D2D1_CAP_STYLE
    endCap : D2D1_CAP_STYLE
    dashCap : D2D1_CAP_STYLE
    lineJoin : D2D1_LINE_JOIN
    miterLimit : Float32
    dashStyle : D2D1_DASH_STYLE
    dashOffset : Float32
    transformType : D2D1_STROKE_TRANSFORM_TYPE
}
struct D2D1_LAYER_OPTIONS1 extends Int32 {
    static D2D1_LAYER_OPTIONS1_NONE := 0
    static D2D1_LAYER_OPTIONS1_INITIALIZE_FROM_BACKGROUND := 1
    static D2D1_LAYER_OPTIONS1_IGNORE_ALPHA := 2
}
struct D2D1_LAYER_PARAMETERS1 {
    contentBounds : D2D_RECT_F
    geometricMask : ID2D1Geometry
    maskAntialiasMode : D2D1_ANTIALIAS_MODE
    maskTransform : D2D_MATRIX_3X2_F
    opacity : Float32
    opacityBrush : ID2D1Brush
    layerOptions : D2D1_LAYER_OPTIONS1
}
struct D2D1_PRINT_FONT_SUBSET_MODE extends Int32 {
    static D2D1_PRINT_FONT_SUBSET_MODE_DEFAULT := 0
    static D2D1_PRINT_FONT_SUBSET_MODE_EACHPAGE := 1
    static D2D1_PRINT_FONT_SUBSET_MODE_NONE := 2
}
struct D2D1_DRAWING_STATE_DESCRIPTION1 {
    antialiasMode : D2D1_ANTIALIAS_MODE
    textAntialiasMode : D2D1_TEXT_ANTIALIAS_MODE
    tag1 : Int64
    tag2 : Int64
    transform : D2D_MATRIX_3X2_F
    primitiveBlend : D2D1_PRIMITIVE_BLEND
    unitMode : D2D1_UNIT_MODE
}
struct D2D1_PRINT_CONTROL_PROPERTIES {
    fontSubset : D2D1_PRINT_FONT_SUBSET_MODE
    rasterDPI : Float32
    colorSpace : D2D1_COLOR_SPACE
}
struct D2D1_CREATION_PROPERTIES {
    threadingMode : D2D1_THREADING_MODE
    debugLevel : D2D1_DEBUG_LEVEL
    options : D2D1_DEVICE_CONTEXT_OPTIONS
}
struct ID2D1GdiMetafileSink extends IUnknown {
    static IID := "{82237326-8111-4F7C-BCF4-B5C1175564FE}"
    ProcessRecord(recordType, recordData?, recordDataSize)
      => ComCall(3, this.p, UInt32, recordType, Struct.Ptr, recordData?, UInt32, recordDataSize)
}
struct ID2D1GdiMetafile extends ID2D1Resource {
    static IID := "{2F543DC3-CFC1-4211-864F-CFD91C6F3395}"
    Stream(sink)
      => ComCall(4, this.p, ID2D1GdiMetafileSink, sink)
    GetBounds(bounds)
      => ComCall(5, this.p, D2D_RECT_F.Ptr, bounds)
}
struct ID2D1CommandSink extends IUnknown {
    static IID := "{54D7898A-A061-40A7-BEC7-E465BCBA2C4F}"
    BeginDraw()
      => ComCall(3, this.p)
    EndDraw()
      => ComCall(4, this.p)
    SetAntialiasMode(antialiasMode)
      => ComCall(5, this.p, D2D1_ANTIALIAS_MODE, antialiasMode)
    SetTags(tag1, tag2)
      => ComCall(6, this.p, Int64, tag1, Int64, tag2)
    SetTextAntialiasMode(textAntialiasMode)
      => ComCall(7, this.p, D2D1_TEXT_ANTIALIAS_MODE, textAntialiasMode)
    SetTextRenderingParams(textRenderingParams?)
      => ComCall(8, this.p, IDWriteRenderingParams, textRenderingParams?)
    SetTransform(transform)
      => ComCall(9, this.p, D2D_MATRIX_3X2_F.Ptr, transform)
    SetPrimitiveBlend(primitiveBlend)
      => ComCall(10, this.p, D2D1_PRIMITIVE_BLEND, primitiveBlend)
    SetUnitMode(unitMode)
      => ComCall(11, this.p, D2D1_UNIT_MODE, unitMode)
    Clear(color?)
      => ComCall(12, this.p, D2D1_COLOR_F.Ptr, color?)
    DrawGlyphRun(baselineOrigin, glyphRun, glyphRunDescription?, foregroundBrush, measuringMode)
      => ComCall(13, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, ID2D1Brush, foregroundBrush, DWRITE_MEASURING_MODE, measuringMode)
    DrawLine(point0, point1, brush, strokeWidth, strokeStyle?)
      => ComCall(14, this.p, D2D_POINT_2F, point0, D2D_POINT_2F, point1, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?)
    DrawGeometry(geometry, brush, strokeWidth, strokeStyle?)
      => ComCall(15, this.p, ID2D1Geometry, geometry, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?)
    DrawRectangle(rect, brush, strokeWidth, strokeStyle?)
      => ComCall(16, this.p, D2D_RECT_F.Ptr, rect, ID2D1Brush, brush, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?)
    DrawBitmap(bitmap, destinationRectangle?, opacity, interpolationMode, sourceRectangle?, perspectiveTransform?)
      => ComCall(17, this.p, ID2D1Bitmap, bitmap, D2D_RECT_F.Ptr, destinationRectangle?, Float32, opacity, D2D1_INTERPOLATION_MODE, interpolationMode, D2D_RECT_F.Ptr, sourceRectangle?, D2D_MATRIX_4X4_F.Ptr, perspectiveTransform?)
    DrawImage(image, targetOffset?, imageRectangle?, interpolationMode, compositeMode)
      => ComCall(18, this.p, ID2D1Image, image, D2D_POINT_2F.Ptr, targetOffset?, D2D_RECT_F.Ptr, imageRectangle?, D2D1_INTERPOLATION_MODE, interpolationMode, D2D1_COMPOSITE_MODE, compositeMode)
    DrawGdiMetafile(gdiMetafile, targetOffset?)
      => ComCall(19, this.p, ID2D1GdiMetafile, gdiMetafile, D2D_POINT_2F.Ptr, targetOffset?)
    FillMesh(mesh, brush)
      => ComCall(20, this.p, ID2D1Mesh, mesh, ID2D1Brush, brush)
    FillOpacityMask(opacityMask, brush, destinationRectangle?, sourceRectangle?)
      => ComCall(21, this.p, ID2D1Bitmap, opacityMask, ID2D1Brush, brush, D2D_RECT_F.Ptr, destinationRectangle?, D2D_RECT_F.Ptr, sourceRectangle?)
    FillGeometry(geometry, brush, opacityBrush?)
      => ComCall(22, this.p, ID2D1Geometry, geometry, ID2D1Brush, brush, ID2D1Brush, opacityBrush?)
    FillRectangle(rect, brush)
      => ComCall(23, this.p, D2D_RECT_F.Ptr, rect, ID2D1Brush, brush)
    PushAxisAlignedClip(clipRect, antialiasMode)
      => ComCall(24, this.p, D2D_RECT_F.Ptr, clipRect, D2D1_ANTIALIAS_MODE, antialiasMode)
    PushLayer(layerParameters1, layer?)
      => ComCall(25, this.p, D2D1_LAYER_PARAMETERS1.Ptr, layerParameters1, ID2D1Layer, layer?)
    PopAxisAlignedClip()
      => ComCall(26, this.p)
    PopLayer()
      => ComCall(27, this.p)
}
struct ID2D1CommandList extends ID2D1Image {
    static IID := "{B4F34A19-2383-4D76-94F6-EC343657C3DC}"
    Stream(sink)
      => ComCall(4, this.p, ID2D1CommandSink, sink)
    Close()
      => ComCall(5, this.p)
}
struct ID2D1PrintControl extends IUnknown {
    static IID := "{2C1D867D-C290-41C8-AE7E-34A98702E9A5}"
    AddPage(commandList, pageSize, pagePrintTicketStream?, tag1?, tag2?)
      => ComCall(3, this.p, ID2D1CommandList, commandList, D2D_SIZE_F, pageSize, IStream, pagePrintTicketStream?, Int64.Ptr, tag1?, Int64.Ptr, tag2?)
    Close()
      => ComCall(4, this.p)
}
struct ID2D1ImageBrush extends ID2D1Brush {
    static IID := "{FE9E984D-3F95-407C-B5DB-CB94D4E8F87C}"
    SetImage(image?)
      => ComCall(8, this.p, ID2D1Image, image?, "void")
    SetExtendModeX(extendModeX)
      => ComCall(9, this.p, D2D1_EXTEND_MODE, extendModeX, "void")
    SetExtendModeY(extendModeY)
      => ComCall(10, this.p, D2D1_EXTEND_MODE, extendModeY, "void")
    SetInterpolationMode(interpolationMode)
      => ComCall(11, this.p, D2D1_INTERPOLATION_MODE, interpolationMode, "void")
    SetSourceRectangle(sourceRectangle)
      => ComCall(12, this.p, D2D_RECT_F.Ptr, sourceRectangle, "void")
    GetImage(image)
      => ComCall(13, this.p, ID2D1Image.Ptr, image, "void")
    GetExtendModeX()
      => ComCall(14, this.p, D2D1_EXTEND_MODE)
    GetExtendModeY()
      => ComCall(15, this.p, D2D1_EXTEND_MODE)
    GetInterpolationMode()
      => ComCall(16, this.p, D2D1_INTERPOLATION_MODE)
    GetSourceRectangle(sourceRectangle)
      => ComCall(17, this.p, D2D_RECT_F.Ptr, sourceRectangle, "void")
}
struct ID2D1BitmapBrush1 extends ID2D1BitmapBrush {
    static IID := "{41343A53-E41A-49A2-91CD-21793BBB62E5}"
    SetInterpolationMode1(interpolationMode)
      => ComCall(16, this.p, D2D1_INTERPOLATION_MODE, interpolationMode, "void")
    GetInterpolationMode1()
      => ComCall(17, this.p, D2D1_INTERPOLATION_MODE)
}
struct ID2D1StrokeStyle1 extends ID2D1StrokeStyle {
    static IID := "{10A72A66-E91C-43F4-993F-DDF4B82B0B4A}"
    GetStrokeTransformType()
      => ComCall(13, this.p, D2D1_STROKE_TRANSFORM_TYPE)
}
struct ID2D1PathGeometry1 extends ID2D1PathGeometry {
    static IID := "{62BAA2D2-AB54-41B7-B872-787E0106A421}"
    ComputePointAndSegmentAtLength(length, startSegment, worldTransform?, flatteningTolerance, pointDescription)
      => ComCall(21, this.p, Float32, length, UInt32, startSegment, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, D2D1_POINT_DESCRIPTION.Ptr, pointDescription)
}
struct ID2D1Properties extends IUnknown {
    static IID := "{483473D7-CD46-4F9D-9D3A-3112AA80159D}"
    GetPropertyCount()
      => ComCall(3, this.p, UInt32)
    GetPropertyName(index, name)
      => ComCall(4, this.p, UInt32, index, PWSTR, name, UInt32, name.Length)
    GetPropertyNameLength(index)
      => ComCall(5, this.p, UInt32, index, UInt32)
    GetType(index)
      => ComCall(6, this.p, UInt32, index, D2D1_PROPERTY_TYPE)
    GetPropertyIndex(name)
      => ComCall(7, this.p, "Str", name, UInt32)
    SetValueByName(name, type, data)
      => ComCall(8, this.p, "Str", name, D2D1_PROPERTY_TYPE, type, UInt8.Ptr, data, UInt32, data.Length)
    SetValue(index, type, data)
      => ComCall(9, this.p, UInt32, index, D2D1_PROPERTY_TYPE, type, UInt8.Ptr, data, UInt32, data.Length)
    GetValueByName(name, type, data)
      => ComCall(10, this.p, "Str", name, D2D1_PROPERTY_TYPE, type, UInt8.Ptr, data, UInt32, data.Length)
    GetValue(index, type, data)
      => ComCall(11, this.p, UInt32, index, D2D1_PROPERTY_TYPE, type, UInt8.Ptr, data, UInt32, data.Length)
    GetValueSize(index)
      => ComCall(12, this.p, UInt32, index, UInt32)
    GetSubProperties(index, subProperties)
      => ComCall(13, this.p, UInt32, index, ID2D1Properties.Ptr, subProperties)
}
struct ID2D1Effect extends ID2D1Properties {
    static IID := "{28211A43-7D89-476F-8181-2D6159B220AD}"
    SetInput(index, input?, invalidate)
      => ComCall(14, this.p, UInt32, index, ID2D1Image, input?, BOOL, invalidate, "void")
    SetInputCount(inputCount)
      => ComCall(15, this.p, UInt32, inputCount)
    GetInput(index, input)
      => ComCall(16, this.p, UInt32, index, ID2D1Image.Ptr, input, "void")
    GetInputCount()
      => ComCall(17, this.p, UInt32)
    GetOutput(outputImage)
      => ComCall(18, this.p, ID2D1Image.Ptr, outputImage, "void")
}
struct ID2D1Bitmap1 extends ID2D1Bitmap {
    static IID := "{A898A84C-3873-4588-B08B-EBBF978DF041}"
    GetColorContext(colorContext)
      => ComCall(11, this.p, ID2D1ColorContext.Ptr, colorContext, "void")
    GetOptions()
      => ComCall(12, this.p, D2D1_BITMAP_OPTIONS)
    GetSurface(dxgiSurface)
      => ComCall(13, this.p, IDXGISurface.Ptr, dxgiSurface)
    Map(options, mappedRect)
      => ComCall(14, this.p, D2D1_MAP_OPTIONS, options, D2D1_MAPPED_RECT.Ptr, mappedRect)
    Unmap()
      => ComCall(15, this.p)
}
struct ID2D1ColorContext extends ID2D1Resource {
    static IID := "{1C4820BB-5771-4518-A581-2FE4DD0EC657}"
    GetColorSpace()
      => ComCall(4, this.p, D2D1_COLOR_SPACE)
    GetProfileSize()
      => ComCall(5, this.p, UInt32)
    GetProfile(profile)
      => ComCall(6, this.p, UInt8.Ptr, profile, UInt32, profile.Length)
}
struct ID2D1GradientStopCollection1 extends ID2D1GradientStopCollection {
    static IID := "{AE1572F4-5DD0-4777-998B-9279472AE63B}"
    GetGradientStops1(gradientStops)
      => ComCall(8, this.p, D2D1_GRADIENT_STOP.Ptr, gradientStops, UInt32, gradientStops.Length, "void")
    GetPreInterpolationSpace()
      => ComCall(9, this.p, D2D1_COLOR_SPACE)
    GetPostInterpolationSpace()
      => ComCall(10, this.p, D2D1_COLOR_SPACE)
    GetBufferPrecision()
      => ComCall(11, this.p, D2D1_BUFFER_PRECISION)
    GetColorInterpolationMode()
      => ComCall(12, this.p, D2D1_COLOR_INTERPOLATION_MODE)
}
struct ID2D1DrawingStateBlock1 extends ID2D1DrawingStateBlock {
    static IID := "{689F1F85-C72E-4E33-8F19-85754EFD5ACE}"
    GetDescription(stateDescription)
      => ComCall(8, this.p, D2D1_DRAWING_STATE_DESCRIPTION1.Ptr, stateDescription, "void")
    SetDescription(stateDescription)
      => ComCall(9, this.p, D2D1_DRAWING_STATE_DESCRIPTION1.Ptr, stateDescription, "void")
}
struct ID2D1DeviceContext extends ID2D1RenderTarget {
    static IID := "{E8F7FE7A-191C-466D-AD95-975678BDA998}"
    CreateBitmap(size, sourceData?, pitch, bitmapProperties, bitmap)
      => ComCall(57, this.p, D2D_SIZE_U, size, Struct.Ptr, sourceData?, UInt32, pitch, D2D1_BITMAP_PROPERTIES1.Ptr, bitmapProperties, ID2D1Bitmap1.Ptr, bitmap)
    CreateBitmapFromWicBitmap(wicBitmapSource, bitmapProperties?, bitmap)
      => ComCall(58, this.p, IWICBitmapSource, wicBitmapSource, D2D1_BITMAP_PROPERTIES1.Ptr, bitmapProperties?, ID2D1Bitmap1.Ptr, bitmap)
    CreateColorContext(space, profile?, colorContext)
      => ComCall(59, this.p, D2D1_COLOR_SPACE, space, UInt8.Ptr, profile?, UInt32, profile?.Length ?? 0, ID2D1ColorContext.Ptr, colorContext)
    CreateColorContextFromFilename(filename, colorContext)
      => ComCall(60, this.p, "Str", filename, ID2D1ColorContext.Ptr, colorContext)
    CreateColorContextFromWicColorContext(wicColorContext, colorContext)
      => ComCall(61, this.p, IWICColorContext, wicColorContext, ID2D1ColorContext.Ptr, colorContext)
    CreateBitmapFromDxgiSurface(surface, bitmapProperties?, bitmap)
      => ComCall(62, this.p, IDXGISurface, surface, D2D1_BITMAP_PROPERTIES1.Ptr, bitmapProperties?, ID2D1Bitmap1.Ptr, bitmap)
    CreateEffect(effectId, effect)
      => ComCall(63, this.p, GUID.Ptr, effectId, ID2D1Effect.Ptr, effect)
    CreateGradientStopCollection(straightAlphaGradientStops, preInterpolationSpace, postInterpolationSpace, bufferPrecision, extendMode, colorInterpolationMode, gradientStopCollection1)
      => ComCall(64, this.p, D2D1_GRADIENT_STOP.Ptr, straightAlphaGradientStops, UInt32, straightAlphaGradientStops.Length, D2D1_COLOR_SPACE, preInterpolationSpace, D2D1_COLOR_SPACE, postInterpolationSpace, D2D1_BUFFER_PRECISION, bufferPrecision, D2D1_EXTEND_MODE, extendMode, D2D1_COLOR_INTERPOLATION_MODE, colorInterpolationMode, ID2D1GradientStopCollection1.Ptr, gradientStopCollection1)
    CreateImageBrush(image?, imageBrushProperties, brushProperties?, imageBrush)
      => ComCall(65, this.p, ID2D1Image, image?, D2D1_IMAGE_BRUSH_PROPERTIES.Ptr, imageBrushProperties, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1ImageBrush.Ptr, imageBrush)
    CreateBitmapBrush(bitmap?, bitmapBrushProperties?, brushProperties?, bitmapBrush)
      => ComCall(66, this.p, ID2D1Bitmap, bitmap?, D2D1_BITMAP_BRUSH_PROPERTIES1.Ptr, bitmapBrushProperties?, D2D1_BRUSH_PROPERTIES.Ptr, brushProperties?, ID2D1BitmapBrush1.Ptr, bitmapBrush)
    CreateCommandList(commandList)
      => ComCall(67, this.p, ID2D1CommandList.Ptr, commandList)
    IsDxgiFormatSupported(format)
      => ComCall(68, this.p, DXGI_FORMAT, format, BOOL)
    IsBufferPrecisionSupported(bufferPrecision)
      => ComCall(69, this.p, D2D1_BUFFER_PRECISION, bufferPrecision, BOOL)
    GetImageLocalBounds(image, localBounds)
      => ComCall(70, this.p, ID2D1Image, image, D2D_RECT_F.Ptr, localBounds)
    GetImageWorldBounds(image, worldBounds)
      => ComCall(71, this.p, ID2D1Image, image, D2D_RECT_F.Ptr, worldBounds)
    GetGlyphRunWorldBounds(baselineOrigin, glyphRun, measuringMode, bounds)
      => ComCall(72, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_MEASURING_MODE, measuringMode, D2D_RECT_F.Ptr, bounds)
    GetDevice(device)
      => ComCall(73, this.p, ID2D1Device.Ptr, device, "void")
    SetTarget(image?)
      => ComCall(74, this.p, ID2D1Image, image?, "void")
    GetTarget(image)
      => ComCall(75, this.p, ID2D1Image.Ptr, image, "void")
    SetRenderingControls(renderingControls)
      => ComCall(76, this.p, D2D1_RENDERING_CONTROLS.Ptr, renderingControls, "void")
    GetRenderingControls(renderingControls)
      => ComCall(77, this.p, D2D1_RENDERING_CONTROLS.Ptr, renderingControls, "void")
    SetPrimitiveBlend(primitiveBlend)
      => ComCall(78, this.p, D2D1_PRIMITIVE_BLEND, primitiveBlend, "void")
    GetPrimitiveBlend()
      => ComCall(79, this.p, D2D1_PRIMITIVE_BLEND)
    SetUnitMode(unitMode)
      => ComCall(80, this.p, D2D1_UNIT_MODE, unitMode, "void")
    GetUnitMode()
      => ComCall(81, this.p, D2D1_UNIT_MODE)
    DrawGlyphRun(baselineOrigin, glyphRun, glyphRunDescription?, foregroundBrush, measuringMode)
      => ComCall(82, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, ID2D1Brush, foregroundBrush, DWRITE_MEASURING_MODE, measuringMode, "void")
    DrawImage(image, targetOffset?, imageRectangle?, interpolationMode, compositeMode)
      => ComCall(83, this.p, ID2D1Image, image, D2D_POINT_2F.Ptr, targetOffset?, D2D_RECT_F.Ptr, imageRectangle?, D2D1_INTERPOLATION_MODE, interpolationMode, D2D1_COMPOSITE_MODE, compositeMode, "void")
    DrawGdiMetafile(gdiMetafile, targetOffset?)
      => ComCall(84, this.p, ID2D1GdiMetafile, gdiMetafile, D2D_POINT_2F.Ptr, targetOffset?, "void")
    DrawBitmap(bitmap, destinationRectangle?, opacity, interpolationMode, sourceRectangle?, perspectiveTransform?)
      => ComCall(85, this.p, ID2D1Bitmap, bitmap, D2D_RECT_F.Ptr, destinationRectangle?, Float32, opacity, D2D1_INTERPOLATION_MODE, interpolationMode, D2D_RECT_F.Ptr, sourceRectangle?, D2D_MATRIX_4X4_F.Ptr, perspectiveTransform?, "void")
    PushLayer(layerParameters, layer?)
      => ComCall(86, this.p, D2D1_LAYER_PARAMETERS1.Ptr, layerParameters, ID2D1Layer, layer?, "void")
    InvalidateEffectInputRectangle(effect, input, inputRectangle)
      => ComCall(87, this.p, ID2D1Effect, effect, UInt32, input, D2D_RECT_F.Ptr, inputRectangle)
    GetEffectInvalidRectangleCount(effect, rectangleCount)
      => ComCall(88, this.p, ID2D1Effect, effect, UInt32.Ptr, rectangleCount)
    GetEffectInvalidRectangles(effect, rectangles)
      => ComCall(89, this.p, ID2D1Effect, effect, D2D_RECT_F.Ptr, rectangles, UInt32, rectangles.Length)
    GetEffectRequiredInputRectangles(renderEffect, renderImageRectangle?, inputDescriptions, requiredInputRects)
      => ComCall(90, this.p, ID2D1Effect, renderEffect, D2D_RECT_F.Ptr, renderImageRectangle?, D2D1_EFFECT_INPUT_DESCRIPTION.Ptr, inputDescriptions, D2D_RECT_F.Ptr, requiredInputRects, UInt32, requiredInputRects.Length)
    FillOpacityMask(opacityMask, brush, destinationRectangle?, sourceRectangle?)
      => ComCall(91, this.p, ID2D1Bitmap, opacityMask, ID2D1Brush, brush, D2D_RECT_F.Ptr, destinationRectangle?, D2D_RECT_F.Ptr, sourceRectangle?, "void")
}
struct ID2D1Device extends ID2D1Resource {
    static IID := "{47DD575D-AC05-4CDD-8049-9B02CD16F44C}"
    CreateDeviceContext(options, deviceContext)
      => ComCall(4, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext.Ptr, deviceContext)
    CreatePrintControl(wicFactory, documentTarget, printControlProperties?, printControl)
      => ComCall(5, this.p, IWICImagingFactory, wicFactory, IPrintDocumentPackageTarget, documentTarget, D2D1_PRINT_CONTROL_PROPERTIES.Ptr, printControlProperties?, ID2D1PrintControl.Ptr, printControl)
    SetMaximumTextureMemory(maximumInBytes)
      => ComCall(6, this.p, Int64, maximumInBytes, "void")
    GetMaximumTextureMemory()
      => ComCall(7, this.p, Int64)
    ClearResources(millisecondsSinceUse)
      => ComCall(8, this.p, UInt32, millisecondsSinceUse, "void")
}
struct ID2D1Factory1 extends ID2D1Factory {
    static IID := "{BB12D362-DAEE-4B9A-AA1D-14BA401CFA1F}"
    CreateDevice(dxgiDevice, d2dDevice)
      => ComCall(17, this.p, IDXGIDevice, dxgiDevice, ID2D1Device.Ptr, d2dDevice)
    CreateStrokeStyle(strokeStyleProperties, dashes?, strokeStyle)
      => ComCall(18, this.p, D2D1_STROKE_STYLE_PROPERTIES1.Ptr, strokeStyleProperties, Float32.Ptr, dashes?, UInt32, dashes?.Length ?? 0, ID2D1StrokeStyle1.Ptr, strokeStyle)
    CreatePathGeometry(pathGeometry)
      => ComCall(19, this.p, ID2D1PathGeometry1.Ptr, pathGeometry)
    CreateDrawingStateBlock(drawingStateDescription?, textRenderingParams?, drawingStateBlock)
      => ComCall(20, this.p, D2D1_DRAWING_STATE_DESCRIPTION1.Ptr, drawingStateDescription?, IDWriteRenderingParams, textRenderingParams?, ID2D1DrawingStateBlock1.Ptr, drawingStateBlock)
    CreateGdiMetafile(metafileStream, metafile)
      => ComCall(21, this.p, IStream, metafileStream, ID2D1GdiMetafile.Ptr, metafile)
    RegisterEffectFromStream(classId, propertyXml, bindings?, effectFactory)
      => ComCall(22, this.p, GUID.Ptr, classId, IStream, propertyXml, D2D1_PROPERTY_BINDING.Ptr, bindings?, UInt32, bindings?.Length ?? 0, PD2D1_EFFECT_FACTORY, effectFactory)
    RegisterEffectFromString(classId, propertyXml, bindings?, effectFactory)
      => ComCall(23, this.p, GUID.Ptr, classId, "Str", propertyXml, D2D1_PROPERTY_BINDING.Ptr, bindings?, UInt32, bindings?.Length ?? 0, PD2D1_EFFECT_FACTORY, effectFactory)
    UnregisterEffect(classId)
      => ComCall(24, this.p, GUID.Ptr, classId)
    GetRegisteredEffects(effects?, effectsReturned?, effectsRegistered?)
      => ComCall(25, this.p, GUID.Ptr, effects?, UInt32, effects?.Length ?? 0, UInt32.Ptr, effectsReturned?, UInt32.Ptr, effectsRegistered?)
    GetEffectProperties(effectId, properties)
      => ComCall(26, this.p, GUID.Ptr, effectId, ID2D1Properties.Ptr, properties)
}
struct ID2D1Multithread extends IUnknown {
    static IID := "{31E6E7BC-E0FF-4D46-8C64-A0A8C41C15D3}"
    GetMultithreadProtected()
      => ComCall(3, this.p, BOOL)
    Enter()
      => ComCall(4, this.p, "void")
    Leave()
      => ComCall(5, this.p, "void")
}
struct PD2D1_PROPERTY_SET_FUNCTION extends FunctionPointer {
    static Types := [IUnknown, UInt8.Ptr, UInt32, HRESULT]
}
struct PD2D1_PROPERTY_GET_FUNCTION extends FunctionPointer {
    static Types := [IUnknown, UInt8.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct D2D1_CHANGE_TYPE extends Int32 {
    static D2D1_CHANGE_TYPE_NONE := 0
    static D2D1_CHANGE_TYPE_PROPERTIES := 1
    static D2D1_CHANGE_TYPE_CONTEXT := 2
    static D2D1_CHANGE_TYPE_GRAPH := 3
}
struct D2D1_PIXEL_OPTIONS extends Int32 {
    static D2D1_PIXEL_OPTIONS_NONE := 0
    static D2D1_PIXEL_OPTIONS_TRIVIAL_SAMPLING := 1
}
struct D2D1_VERTEX_OPTIONS extends Int32 {
    static D2D1_VERTEX_OPTIONS_NONE := 0
    static D2D1_VERTEX_OPTIONS_DO_NOT_CLEAR := 1
    static D2D1_VERTEX_OPTIONS_USE_DEPTH_BUFFER := 2
    static D2D1_VERTEX_OPTIONS_ASSUME_NO_OVERLAP := 4
}
struct D2D1_VERTEX_USAGE extends Int32 {
    static D2D1_VERTEX_USAGE_STATIC := 0
    static D2D1_VERTEX_USAGE_DYNAMIC := 1
}
struct D2D1_BLEND_OPERATION extends Int32 {
    static D2D1_BLEND_OPERATION_ADD := 1
    static D2D1_BLEND_OPERATION_SUBTRACT := 2
    static D2D1_BLEND_OPERATION_REV_SUBTRACT := 3
    static D2D1_BLEND_OPERATION_MIN := 4
    static D2D1_BLEND_OPERATION_MAX := 5
}
struct D2D1_BLEND extends Int32 {
    static D2D1_BLEND_ZERO := 1
    static D2D1_BLEND_ONE := 2
    static D2D1_BLEND_SRC_COLOR := 3
    static D2D1_BLEND_INV_SRC_COLOR := 4
    static D2D1_BLEND_SRC_ALPHA := 5
    static D2D1_BLEND_INV_SRC_ALPHA := 6
    static D2D1_BLEND_DEST_ALPHA := 7
    static D2D1_BLEND_INV_DEST_ALPHA := 8
    static D2D1_BLEND_DEST_COLOR := 9
    static D2D1_BLEND_INV_DEST_COLOR := 10
    static D2D1_BLEND_SRC_ALPHA_SAT := 11
    static D2D1_BLEND_BLEND_FACTOR := 14
    static D2D1_BLEND_INV_BLEND_FACTOR := 15
}
struct D2D1_CHANNEL_DEPTH extends Int32 {
    static D2D1_CHANNEL_DEPTH_DEFAULT := 0
    static D2D1_CHANNEL_DEPTH_1 := 1
    static D2D1_CHANNEL_DEPTH_4 := 4
}
struct D2D1_FILTER extends Int32 {
    static D2D1_FILTER_MIN_MAG_MIP_POINT := 0
    static D2D1_FILTER_MIN_MAG_POINT_MIP_LINEAR := 1
    static D2D1_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT := 4
    static D2D1_FILTER_MIN_POINT_MAG_MIP_LINEAR := 5
    static D2D1_FILTER_MIN_LINEAR_MAG_MIP_POINT := 16
    static D2D1_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 17
    static D2D1_FILTER_MIN_MAG_LINEAR_MIP_POINT := 20
    static D2D1_FILTER_MIN_MAG_MIP_LINEAR := 21
    static D2D1_FILTER_ANISOTROPIC := 85
}
struct D2D1_FEATURE extends Int32 {
    static D2D1_FEATURE_DOUBLES := 0
    static D2D1_FEATURE_D3D10_X_HARDWARE_OPTIONS := 1
}
struct D2D1_PROPERTY_BINDING {
    propertyName : PWSTR
    setFunction : PD2D1_PROPERTY_SET_FUNCTION
    getFunction : PD2D1_PROPERTY_GET_FUNCTION
}
struct D2D1_RESOURCE_TEXTURE_PROPERTIES {
    extents : UInt32.Ptr
    dimensions : UInt32
    bufferPrecision : D2D1_BUFFER_PRECISION
    channelDepth : D2D1_CHANNEL_DEPTH
    filter : D2D1_FILTER
    extendModes : D2D1_EXTEND_MODE.Ptr
}
struct D2D1_INPUT_ELEMENT_DESC {
    semanticName : PSTR
    semanticIndex : UInt32
    format : DXGI_FORMAT
    inputSlot : UInt32
    alignedByteOffset : UInt32
}
struct D2D1_VERTEX_BUFFER_PROPERTIES {
    inputCount : UInt32
    usage : D2D1_VERTEX_USAGE
    data : UInt8.Ptr
    byteWidth : UInt32
}
struct D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES {
    shaderBufferWithInputSignature : UInt8.Ptr
    shaderBufferSize : UInt32
    inputElements : D2D1_INPUT_ELEMENT_DESC.Ptr
    elementCount : UInt32
    stride : UInt32
}
struct D2D1_VERTEX_RANGE {
    startVertex : UInt32
    vertexCount : UInt32
}
struct D2D1_BLEND_DESCRIPTION {
    sourceBlend : D2D1_BLEND
    destinationBlend : D2D1_BLEND
    blendOperation : D2D1_BLEND_OPERATION
    sourceBlendAlpha : D2D1_BLEND
    destinationBlendAlpha : D2D1_BLEND
    blendOperationAlpha : D2D1_BLEND_OPERATION
    blendFactor : Float32[4]
}
struct D2D1_INPUT_DESCRIPTION {
    filter : D2D1_FILTER
    levelOfDetailCount : UInt32
}
struct D2D1_FEATURE_DATA_DOUBLES {
    doublePrecisionFloatShaderOps : BOOL
}
struct D2D1_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS {
    computeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x : BOOL
}
struct ID2D1VertexBuffer extends IUnknown {
    static IID := "{9B8B1336-00A5-4668-92B7-CED5D8BF9B7B}"
    Map(data, bufferSize)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, data, UInt32, bufferSize)
    Unmap()
      => ComCall(4, this.p)
}
struct ID2D1ResourceTexture extends IUnknown {
    static IID := "{688D15C3-02B0-438D-B13A-D1B44C32C39A}"
    Update(minimumExtents?, maximimumExtents?, strides?, data)
      => ComCall(3, this.p, UInt32.Ptr, minimumExtents?, UInt32.Ptr, maximimumExtents?, UInt32.Ptr, strides?, UInt32, maximimumExtents?.Length ?? 0, UInt8.Ptr, data, UInt32, data.Length)
}
struct ID2D1RenderInfo extends IUnknown {
    static IID := "{519AE1BD-D19A-420D-B849-364F594776B7}"
    SetInputDescription(inputIndex, inputDescription)
      => ComCall(3, this.p, UInt32, inputIndex, D2D1_INPUT_DESCRIPTION, inputDescription)
    SetOutputBuffer(bufferPrecision, channelDepth)
      => ComCall(4, this.p, D2D1_BUFFER_PRECISION, bufferPrecision, D2D1_CHANNEL_DEPTH, channelDepth)
    SetCached(isCached)
      => ComCall(5, this.p, BOOL, isCached, "void")
    SetInstructionCountHint(instructionCount)
      => ComCall(6, this.p, UInt32, instructionCount, "void")
}
struct ID2D1DrawInfo extends ID2D1RenderInfo {
    static IID := "{693CE632-7F2F-45DE-93FE-18D88B37AA21}"
    SetPixelShaderConstantBuffer(buffer)
      => ComCall(7, this.p, UInt8.Ptr, buffer, UInt32, buffer.Length)
    SetResourceTexture(textureIndex, resourceTexture)
      => ComCall(8, this.p, UInt32, textureIndex, ID2D1ResourceTexture, resourceTexture)
    SetVertexShaderConstantBuffer(buffer)
      => ComCall(9, this.p, UInt8.Ptr, buffer, UInt32, buffer.Length)
    SetPixelShader(shaderId, pixelOptions)
      => ComCall(10, this.p, GUID.Ptr, shaderId, D2D1_PIXEL_OPTIONS, pixelOptions)
    SetVertexProcessing(vertexBuffer?, vertexOptions, blendDescription?, vertexRange?, vertexShader?)
      => ComCall(11, this.p, ID2D1VertexBuffer, vertexBuffer?, D2D1_VERTEX_OPTIONS, vertexOptions, D2D1_BLEND_DESCRIPTION.Ptr, blendDescription?, D2D1_VERTEX_RANGE.Ptr, vertexRange?, GUID.Ptr, vertexShader?)
}
struct ID2D1ComputeInfo extends ID2D1RenderInfo {
    static IID := "{5598B14B-9FD7-48B7-9BDB-8F0964EB38BC}"
    SetComputeShaderConstantBuffer(buffer)
      => ComCall(7, this.p, UInt8.Ptr, buffer, UInt32, buffer.Length)
    SetComputeShader(shaderId)
      => ComCall(8, this.p, GUID.Ptr, shaderId)
    SetResourceTexture(textureIndex, resourceTexture)
      => ComCall(9, this.p, UInt32, textureIndex, ID2D1ResourceTexture, resourceTexture)
}
struct ID2D1TransformNode extends IUnknown {
    static IID := "{B2EFE1E7-729F-4102-949F-505FA21BF666}"
    GetInputCount()
      => ComCall(3, this.p, UInt32)
}
struct ID2D1TransformGraph extends IUnknown {
    static IID := "{13D29038-C3E6-4034-9081-13B53A417992}"
    GetInputCount()
      => ComCall(3, this.p, UInt32)
    SetSingleTransformNode(node)
      => ComCall(4, this.p, ID2D1TransformNode, node)
    AddNode(node)
      => ComCall(5, this.p, ID2D1TransformNode, node)
    RemoveNode(node)
      => ComCall(6, this.p, ID2D1TransformNode, node)
    SetOutputNode(node)
      => ComCall(7, this.p, ID2D1TransformNode, node)
    ConnectNode(fromNode, toNode, toNodeInputIndex)
      => ComCall(8, this.p, ID2D1TransformNode, fromNode, ID2D1TransformNode, toNode, UInt32, toNodeInputIndex)
    ConnectToEffectInput(toEffectInputIndex, node, toNodeInputIndex)
      => ComCall(9, this.p, UInt32, toEffectInputIndex, ID2D1TransformNode, node, UInt32, toNodeInputIndex)
    Clear()
      => ComCall(10, this.p, "void")
    SetPassthroughGraph(effectInputIndex)
      => ComCall(11, this.p, UInt32, effectInputIndex)
}
struct ID2D1Transform extends ID2D1TransformNode {
    static IID := "{EF1A287D-342A-4F76-8FDB-DA0D6EA9F92B}"
    MapOutputRectToInputRects(outputRect, inputRects)
      => ComCall(4, this.p, RECT.Ptr, outputRect, RECT.Ptr, inputRects, UInt32, inputRects.Length)
    MapInputRectsToOutputRect(inputRects, inputOpaqueSubRects, outputRect, outputOpaqueSubRect)
      => ComCall(5, this.p, RECT.Ptr, inputRects, RECT.Ptr, inputOpaqueSubRects, UInt32, inputOpaqueSubRects.Length, RECT.Ptr, outputRect, RECT.Ptr, outputOpaqueSubRect)
    MapInvalidRect(inputIndex, invalidInputRect, invalidOutputRect)
      => ComCall(6, this.p, UInt32, inputIndex, RECT, invalidInputRect, RECT.Ptr, invalidOutputRect)
}
struct ID2D1DrawTransform extends ID2D1Transform {
    static IID := "{36BFDCB6-9739-435D-A30D-A653BEFF6A6F}"
    SetDrawInfo(drawInfo)
      => ComCall(7, this.p, ID2D1DrawInfo, drawInfo)
}
struct ID2D1ComputeTransform extends ID2D1Transform {
    static IID := "{0D85573C-01E3-4F7D-BFD9-0D60608BF3C3}"
    SetComputeInfo(computeInfo)
      => ComCall(7, this.p, ID2D1ComputeInfo, computeInfo)
    CalculateThreadgroups(outputRect, dimensionX, dimensionY, dimensionZ)
      => ComCall(8, this.p, RECT.Ptr, outputRect, UInt32.Ptr, dimensionX, UInt32.Ptr, dimensionY, UInt32.Ptr, dimensionZ)
}
struct ID2D1AnalysisTransform extends IUnknown {
    static IID := "{0359DC30-95E6-4568-9055-27720D130E93}"
    ProcessAnalysisResults(analysisData)
      => ComCall(3, this.p, UInt8.Ptr, analysisData, UInt32, analysisData.Length)
}
struct ID2D1SourceTransform extends ID2D1Transform {
    static IID := "{DB1800DD-0C34-4CF9-BE90-31CC0A5653E1}"
    SetRenderInfo(renderInfo)
      => ComCall(7, this.p, ID2D1RenderInfo, renderInfo)
    Draw(target, drawRect, targetOrigin)
      => ComCall(8, this.p, ID2D1Bitmap1, target, RECT.Ptr, drawRect, D2D_POINT_2U, targetOrigin)
}
struct ID2D1ConcreteTransform extends ID2D1TransformNode {
    static IID := "{1A799D8A-69F7-4E4C-9FED-437CCC6684CC}"
    SetOutputBuffer(bufferPrecision, channelDepth)
      => ComCall(4, this.p, D2D1_BUFFER_PRECISION, bufferPrecision, D2D1_CHANNEL_DEPTH, channelDepth)
    SetCached(isCached)
      => ComCall(5, this.p, BOOL, isCached, "void")
}
struct ID2D1BlendTransform extends ID2D1ConcreteTransform {
    static IID := "{63AC0B32-BA44-450F-8806-7F4CA1FF2F1B}"
    SetDescription(description)
      => ComCall(6, this.p, D2D1_BLEND_DESCRIPTION.Ptr, description, "void")
    GetDescription(description)
      => ComCall(7, this.p, D2D1_BLEND_DESCRIPTION.Ptr, description, "void")
}
struct ID2D1BorderTransform extends ID2D1ConcreteTransform {
    static IID := "{4998735C-3A19-473C-9781-656847E3A347}"
    SetExtendModeX(extendMode)
      => ComCall(6, this.p, D2D1_EXTEND_MODE, extendMode, "void")
    SetExtendModeY(extendMode)
      => ComCall(7, this.p, D2D1_EXTEND_MODE, extendMode, "void")
    GetExtendModeX()
      => ComCall(8, this.p, D2D1_EXTEND_MODE)
    GetExtendModeY()
      => ComCall(9, this.p, D2D1_EXTEND_MODE)
}
struct ID2D1OffsetTransform extends ID2D1TransformNode {
    static IID := "{3FE6ADEA-7643-4F53-BD14-A0CE63F24042}"
    SetOffset(offset)
      => ComCall(4, this.p, POINT, offset, "void")
    GetOffset()
      => ComCall(5, this.p, POINT)
}
struct ID2D1BoundsAdjustmentTransform extends ID2D1TransformNode {
    static IID := "{90F732E2-5092-4606-A819-8651970BACCD}"
    SetOutputBounds(outputBounds)
      => ComCall(4, this.p, RECT.Ptr, outputBounds, "void")
    GetOutputBounds(outputBounds)
      => ComCall(5, this.p, RECT.Ptr, outputBounds, "void")
}
struct ID2D1EffectImpl extends IUnknown {
    static IID := "{A248FD3F-3E6C-4E63-9F03-7F68ECC91DB9}"
    Initialize(effectContext, transformGraph)
      => ComCall(3, this.p, ID2D1EffectContext, effectContext, ID2D1TransformGraph, transformGraph)
    PrepareForRender(changeType)
      => ComCall(4, this.p, D2D1_CHANGE_TYPE, changeType)
    SetGraph(transformGraph)
      => ComCall(5, this.p, ID2D1TransformGraph, transformGraph)
}
struct ID2D1EffectContext extends IUnknown {
    static IID := "{3D9F916B-27DC-4AD7-B4F1-64945340F563}"
    GetDpi(dpiX, dpiY)
      => ComCall(3, this.p, Float32.Ptr, dpiX, Float32.Ptr, dpiY, "void")
    CreateEffect(effectId, effect)
      => ComCall(4, this.p, GUID.Ptr, effectId, ID2D1Effect.Ptr, effect)
    GetMaximumSupportedFeatureLevel(featureLevels, maximumSupportedFeatureLevel)
      => ComCall(5, this.p, D3D_FEATURE_LEVEL.Ptr, featureLevels, UInt32, featureLevels.Length, D3D_FEATURE_LEVEL.Ptr, maximumSupportedFeatureLevel)
    CreateTransformNodeFromEffect(effect, transformNode)
      => ComCall(6, this.p, ID2D1Effect, effect, ID2D1TransformNode.Ptr, transformNode)
    CreateBlendTransform(numInputs, blendDescription, transform)
      => ComCall(7, this.p, UInt32, numInputs, D2D1_BLEND_DESCRIPTION.Ptr, blendDescription, ID2D1BlendTransform.Ptr, transform)
    CreateBorderTransform(extendModeX, extendModeY, transform)
      => ComCall(8, this.p, D2D1_EXTEND_MODE, extendModeX, D2D1_EXTEND_MODE, extendModeY, ID2D1BorderTransform.Ptr, transform)
    CreateOffsetTransform(offset, transform)
      => ComCall(9, this.p, POINT, offset, ID2D1OffsetTransform.Ptr, transform)
    CreateBoundsAdjustmentTransform(outputRectangle, transform)
      => ComCall(10, this.p, RECT.Ptr, outputRectangle, ID2D1BoundsAdjustmentTransform.Ptr, transform)
    LoadPixelShader(shaderId, shaderBuffer)
      => ComCall(11, this.p, GUID.Ptr, shaderId, UInt8.Ptr, shaderBuffer, UInt32, shaderBuffer.Length)
    LoadVertexShader(resourceId, shaderBuffer)
      => ComCall(12, this.p, GUID.Ptr, resourceId, UInt8.Ptr, shaderBuffer, UInt32, shaderBuffer.Length)
    LoadComputeShader(resourceId, shaderBuffer)
      => ComCall(13, this.p, GUID.Ptr, resourceId, UInt8.Ptr, shaderBuffer, UInt32, shaderBuffer.Length)
    IsShaderLoaded(shaderId)
      => ComCall(14, this.p, GUID.Ptr, shaderId, BOOL)
    CreateResourceTexture(resourceId?, resourceTextureProperties, data?, strides?, resourceTexture)
      => ComCall(15, this.p, GUID.Ptr, resourceId?, D2D1_RESOURCE_TEXTURE_PROPERTIES.Ptr, resourceTextureProperties, UInt8.Ptr, data?, UInt32.Ptr, strides?, UInt32, data?.Length ?? 0, ID2D1ResourceTexture.Ptr, resourceTexture)
    FindResourceTexture(resourceId, resourceTexture)
      => ComCall(16, this.p, GUID.Ptr, resourceId, ID2D1ResourceTexture.Ptr, resourceTexture)
    CreateVertexBuffer(vertexBufferProperties, resourceId?, customVertexBufferProperties?, buffer)
      => ComCall(17, this.p, D2D1_VERTEX_BUFFER_PROPERTIES.Ptr, vertexBufferProperties, GUID.Ptr, resourceId?, D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES.Ptr, customVertexBufferProperties?, ID2D1VertexBuffer.Ptr, buffer)
    FindVertexBuffer(resourceId, buffer)
      => ComCall(18, this.p, GUID.Ptr, resourceId, ID2D1VertexBuffer.Ptr, buffer)
    CreateColorContext(space, profile?, colorContext)
      => ComCall(19, this.p, D2D1_COLOR_SPACE, space, UInt8.Ptr, profile?, UInt32, profile?.Length ?? 0, ID2D1ColorContext.Ptr, colorContext)
    CreateColorContextFromFilename(filename, colorContext)
      => ComCall(20, this.p, "Str", filename, ID2D1ColorContext.Ptr, colorContext)
    CreateColorContextFromWicColorContext(wicColorContext, colorContext)
      => ComCall(21, this.p, IWICColorContext, wicColorContext, ID2D1ColorContext.Ptr, colorContext)
    CheckFeatureSupport(feature, featureSupportData)
      => ComCall(22, this.p, D2D1_FEATURE, feature, Struct.Ptr, featureSupportData, UInt32, featureSupportData.Size)
    IsBufferPrecisionSupported(bufferPrecision)
      => ComCall(23, this.p, D2D1_BUFFER_PRECISION, bufferPrecision, BOOL)
}
struct D2D1_YCBCR_PROP extends Int32 {
    static D2D1_YCBCR_PROP_CHROMA_SUBSAMPLING := 0
    static D2D1_YCBCR_PROP_TRANSFORM_MATRIX := 1
    static D2D1_YCBCR_PROP_INTERPOLATION_MODE := 2
}
struct D2D1_YCBCR_CHROMA_SUBSAMPLING extends Int32 {
    static D2D1_YCBCR_CHROMA_SUBSAMPLING_AUTO := 0
    static D2D1_YCBCR_CHROMA_SUBSAMPLING_420 := 1
    static D2D1_YCBCR_CHROMA_SUBSAMPLING_422 := 2
    static D2D1_YCBCR_CHROMA_SUBSAMPLING_444 := 3
    static D2D1_YCBCR_CHROMA_SUBSAMPLING_440 := 4
}
struct D2D1_YCBCR_INTERPOLATION_MODE extends Int32 {
    static D2D1_YCBCR_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_YCBCR_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_YCBCR_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_YCBCR_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_YCBCR_INTERPOLATION_MODE_ANISOTROPIC := 4
    static D2D1_YCBCR_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_CONTRAST_PROP extends Int32 {
    static D2D1_CONTRAST_PROP_CONTRAST := 0
    static D2D1_CONTRAST_PROP_CLAMP_INPUT := 1
}
struct D2D1_RGBTOHUE_PROP extends Int32 {
    static D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE := 0
}
struct D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE extends Int32 {
    static D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_VALUE := 0
    static D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS := 1
}
struct D2D1_HUETORGB_PROP extends Int32 {
    static D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE := 0
}
struct D2D1_HUETORGB_INPUT_COLOR_SPACE extends Int32 {
    static D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_VALUE := 0
    static D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS := 1
}
struct D2D1_CHROMAKEY_PROP extends Int32 {
    static D2D1_CHROMAKEY_PROP_COLOR := 0
    static D2D1_CHROMAKEY_PROP_TOLERANCE := 1
    static D2D1_CHROMAKEY_PROP_INVERT_ALPHA := 2
    static D2D1_CHROMAKEY_PROP_FEATHER := 3
}
struct D2D1_EMBOSS_PROP extends Int32 {
    static D2D1_EMBOSS_PROP_HEIGHT := 0
    static D2D1_EMBOSS_PROP_DIRECTION := 1
}
struct D2D1_EXPOSURE_PROP extends Int32 {
    static D2D1_EXPOSURE_PROP_EXPOSURE_VALUE := 0
}
struct D2D1_POSTERIZE_PROP extends Int32 {
    static D2D1_POSTERIZE_PROP_RED_VALUE_COUNT := 0
    static D2D1_POSTERIZE_PROP_GREEN_VALUE_COUNT := 1
    static D2D1_POSTERIZE_PROP_BLUE_VALUE_COUNT := 2
}
struct D2D1_SEPIA_PROP extends Int32 {
    static D2D1_SEPIA_PROP_INTENSITY := 0
    static D2D1_SEPIA_PROP_ALPHA_MODE := 1
}
struct D2D1_SHARPEN_PROP extends Int32 {
    static D2D1_SHARPEN_PROP_SHARPNESS := 0
    static D2D1_SHARPEN_PROP_THRESHOLD := 1
}
struct D2D1_STRAIGHTEN_PROP extends Int32 {
    static D2D1_STRAIGHTEN_PROP_ANGLE := 0
    static D2D1_STRAIGHTEN_PROP_MAINTAIN_SIZE := 1
    static D2D1_STRAIGHTEN_PROP_SCALE_MODE := 2
}
struct D2D1_STRAIGHTEN_SCALE_MODE extends Int32 {
    static D2D1_STRAIGHTEN_SCALE_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_STRAIGHTEN_SCALE_MODE_LINEAR := 1
    static D2D1_STRAIGHTEN_SCALE_MODE_CUBIC := 2
    static D2D1_STRAIGHTEN_SCALE_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_STRAIGHTEN_SCALE_MODE_ANISOTROPIC := 4
}
struct D2D1_TEMPERATUREANDTINT_PROP extends Int32 {
    static D2D1_TEMPERATUREANDTINT_PROP_TEMPERATURE := 0
    static D2D1_TEMPERATUREANDTINT_PROP_TINT := 1
}
struct D2D1_VIGNETTE_PROP extends Int32 {
    static D2D1_VIGNETTE_PROP_COLOR := 0
    static D2D1_VIGNETTE_PROP_TRANSITION_SIZE := 1
    static D2D1_VIGNETTE_PROP_STRENGTH := 2
}
struct D2D1_EDGEDETECTION_PROP extends Int32 {
    static D2D1_EDGEDETECTION_PROP_STRENGTH := 0
    static D2D1_EDGEDETECTION_PROP_BLUR_RADIUS := 1
    static D2D1_EDGEDETECTION_PROP_MODE := 2
    static D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES := 3
    static D2D1_EDGEDETECTION_PROP_ALPHA_MODE := 4
}
struct D2D1_EDGEDETECTION_MODE extends Int32 {
    static D2D1_EDGEDETECTION_MODE_SOBEL := 0
    static D2D1_EDGEDETECTION_MODE_PREWITT := 1
}
struct D2D1_HIGHLIGHTSANDSHADOWS_PROP extends Int32 {
    static D2D1_HIGHLIGHTSANDSHADOWS_PROP_HIGHLIGHTS := 0
    static D2D1_HIGHLIGHTSANDSHADOWS_PROP_SHADOWS := 1
    static D2D1_HIGHLIGHTSANDSHADOWS_PROP_CLARITY := 2
    static D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA := 3
    static D2D1_HIGHLIGHTSANDSHADOWS_PROP_MASK_BLUR_RADIUS := 4
}
struct D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA extends Int32 {
    static D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_LINEAR := 0
    static D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_SRGB := 1
}
struct D2D1_LOOKUPTABLE3D_PROP extends Int32 {
    static D2D1_LOOKUPTABLE3D_PROP_LUT := 0
    static D2D1_LOOKUPTABLE3D_PROP_ALPHA_MODE := 1
}
struct D2D1_OPACITY_PROP extends Int32 {
    static D2D1_OPACITY_PROP_OPACITY := 0
}
struct D2D1_CROSSFADE_PROP extends Int32 {
    static D2D1_CROSSFADE_PROP_WEIGHT := 0
}
struct D2D1_TINT_PROP extends Int32 {
    static D2D1_TINT_PROP_COLOR := 0
    static D2D1_TINT_PROP_CLAMP_OUTPUT := 1
}
struct D2D1_WHITELEVELADJUSTMENT_PROP extends Int32 {
    static D2D1_WHITELEVELADJUSTMENT_PROP_INPUT_WHITE_LEVEL := 0
    static D2D1_WHITELEVELADJUSTMENT_PROP_OUTPUT_WHITE_LEVEL := 1
}
struct D2D1_HDRTONEMAP_PROP extends Int32 {
    static D2D1_HDRTONEMAP_PROP_INPUT_MAX_LUMINANCE := 0
    static D2D1_HDRTONEMAP_PROP_OUTPUT_MAX_LUMINANCE := 1
    static D2D1_HDRTONEMAP_PROP_DISPLAY_MODE := 2
}
struct D2D1_HDRTONEMAP_DISPLAY_MODE extends Int32 {
    static D2D1_HDRTONEMAP_DISPLAY_MODE_SDR := 0
    static D2D1_HDRTONEMAP_DISPLAY_MODE_HDR := 1
}
struct D2D1_RENDERING_PRIORITY extends Int32 {
    static D2D1_RENDERING_PRIORITY_NORMAL := 0
    static D2D1_RENDERING_PRIORITY_LOW := 1
}
struct ID2D1GeometryRealization extends ID2D1Resource {
    static IID := "{A16907D7-BC02-4801-99E8-8CF7F485F774}"
}
struct ID2D1DeviceContext1 extends ID2D1DeviceContext {
    static IID := "{D37F57E4-6908-459F-A199-E72F24F79987}"
    CreateFilledGeometryRealization(geometry, flatteningTolerance, geometryRealization)
      => ComCall(92, this.p, ID2D1Geometry, geometry, Float32, flatteningTolerance, ID2D1GeometryRealization.Ptr, geometryRealization)
    CreateStrokedGeometryRealization(geometry, flatteningTolerance, strokeWidth, strokeStyle?, geometryRealization)
      => ComCall(93, this.p, ID2D1Geometry, geometry, Float32, flatteningTolerance, Float32, strokeWidth, ID2D1StrokeStyle, strokeStyle?, ID2D1GeometryRealization.Ptr, geometryRealization)
    DrawGeometryRealization(geometryRealization, brush)
      => ComCall(94, this.p, ID2D1GeometryRealization, geometryRealization, ID2D1Brush, brush, "void")
}
struct ID2D1Device1 extends ID2D1Device {
    static IID := "{D21768E1-23A4-4823-A14B-7C3EBA85D658}"
    GetRenderingPriority()
      => ComCall(9, this.p, D2D1_RENDERING_PRIORITY)
    SetRenderingPriority(renderingPriority)
      => ComCall(10, this.p, D2D1_RENDERING_PRIORITY, renderingPriority, "void")
    CreateDeviceContext(options, deviceContext1)
      => ComCall(11, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext1.Ptr, deviceContext1)
}
struct ID2D1Factory2 extends ID2D1Factory1 {
    static IID := "{94F81A73-9212-4376-9C58-B16A3A0D3992}"
    CreateDevice(dxgiDevice, d2dDevice1)
      => ComCall(27, this.p, IDXGIDevice, dxgiDevice, ID2D1Device1.Ptr, d2dDevice1)
}
struct ID2D1CommandSink1 extends ID2D1CommandSink {
    static IID := "{9EB767FD-4269-4467-B8C2-EB30CB305743}"
    SetPrimitiveBlend1(primitiveBlend)
      => ComCall(28, this.p, D2D1_PRIMITIVE_BLEND, primitiveBlend)
}
struct D2D1_SVG_PAINT_TYPE extends Int32 {
    static D2D1_SVG_PAINT_TYPE_NONE := 0
    static D2D1_SVG_PAINT_TYPE_COLOR := 1
    static D2D1_SVG_PAINT_TYPE_CURRENT_COLOR := 2
    static D2D1_SVG_PAINT_TYPE_URI := 3
    static D2D1_SVG_PAINT_TYPE_URI_NONE := 4
    static D2D1_SVG_PAINT_TYPE_URI_COLOR := 5
    static D2D1_SVG_PAINT_TYPE_URI_CURRENT_COLOR := 6
}
struct D2D1_SVG_LENGTH_UNITS extends Int32 {
    static D2D1_SVG_LENGTH_UNITS_NUMBER := 0
    static D2D1_SVG_LENGTH_UNITS_PERCENTAGE := 1
}
struct D2D1_SVG_DISPLAY extends Int32 {
    static D2D1_SVG_DISPLAY_INLINE := 0
    static D2D1_SVG_DISPLAY_NONE := 1
}
struct D2D1_SVG_VISIBILITY extends Int32 {
    static D2D1_SVG_VISIBILITY_VISIBLE := 0
    static D2D1_SVG_VISIBILITY_HIDDEN := 1
}
struct D2D1_SVG_OVERFLOW extends Int32 {
    static D2D1_SVG_OVERFLOW_VISIBLE := 0
    static D2D1_SVG_OVERFLOW_HIDDEN := 1
}
struct D2D1_SVG_LINE_CAP extends Int32 {
    static D2D1_SVG_LINE_CAP_BUTT := 0
    static D2D1_SVG_LINE_CAP_SQUARE := 1
    static D2D1_SVG_LINE_CAP_ROUND := 2
}
struct D2D1_SVG_LINE_JOIN extends Int32 {
    static D2D1_SVG_LINE_JOIN_BEVEL := 1
    static D2D1_SVG_LINE_JOIN_MITER := 3
    static D2D1_SVG_LINE_JOIN_ROUND := 2
}
struct D2D1_SVG_ASPECT_ALIGN extends Int32 {
    static D2D1_SVG_ASPECT_ALIGN_NONE := 0
    static D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MIN := 1
    static D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MIN := 2
    static D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MIN := 3
    static D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MID := 4
    static D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MID := 5
    static D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MID := 6
    static D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MAX := 7
    static D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MAX := 8
    static D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MAX := 9
}
struct D2D1_SVG_ASPECT_SCALING extends Int32 {
    static D2D1_SVG_ASPECT_SCALING_MEET := 0
    static D2D1_SVG_ASPECT_SCALING_SLICE := 1
}
struct D2D1_SVG_PATH_COMMAND extends Int32 {
    static D2D1_SVG_PATH_COMMAND_CLOSE_PATH := 0
    static D2D1_SVG_PATH_COMMAND_MOVE_ABSOLUTE := 1
    static D2D1_SVG_PATH_COMMAND_MOVE_RELATIVE := 2
    static D2D1_SVG_PATH_COMMAND_LINE_ABSOLUTE := 3
    static D2D1_SVG_PATH_COMMAND_LINE_RELATIVE := 4
    static D2D1_SVG_PATH_COMMAND_CUBIC_ABSOLUTE := 5
    static D2D1_SVG_PATH_COMMAND_CUBIC_RELATIVE := 6
    static D2D1_SVG_PATH_COMMAND_QUADRADIC_ABSOLUTE := 7
    static D2D1_SVG_PATH_COMMAND_QUADRADIC_RELATIVE := 8
    static D2D1_SVG_PATH_COMMAND_ARC_ABSOLUTE := 9
    static D2D1_SVG_PATH_COMMAND_ARC_RELATIVE := 10
    static D2D1_SVG_PATH_COMMAND_HORIZONTAL_ABSOLUTE := 11
    static D2D1_SVG_PATH_COMMAND_HORIZONTAL_RELATIVE := 12
    static D2D1_SVG_PATH_COMMAND_VERTICAL_ABSOLUTE := 13
    static D2D1_SVG_PATH_COMMAND_VERTICAL_RELATIVE := 14
    static D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_ABSOLUTE := 15
    static D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_RELATIVE := 16
    static D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_ABSOLUTE := 17
    static D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_RELATIVE := 18
}
struct D2D1_SVG_UNIT_TYPE extends Int32 {
    static D2D1_SVG_UNIT_TYPE_USER_SPACE_ON_USE := 0
    static D2D1_SVG_UNIT_TYPE_OBJECT_BOUNDING_BOX := 1
}
struct D2D1_SVG_ATTRIBUTE_STRING_TYPE extends Int32 {
    static D2D1_SVG_ATTRIBUTE_STRING_TYPE_SVG := 0
    static D2D1_SVG_ATTRIBUTE_STRING_TYPE_ID := 1
}
struct D2D1_SVG_ATTRIBUTE_POD_TYPE extends Int32 {
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_FLOAT := 0
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_COLOR := 1
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_FILL_MODE := 2
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_DISPLAY := 3
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_OVERFLOW := 4
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_CAP := 5
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_JOIN := 6
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_VISIBILITY := 7
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_MATRIX := 8
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_UNIT_TYPE := 9
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_EXTEND_MODE := 10
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_PRESERVE_ASPECT_RATIO := 11
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_VIEWBOX := 12
    static D2D1_SVG_ATTRIBUTE_POD_TYPE_LENGTH := 13
}
struct D2D1_SVG_LENGTH {
    value : Float32
    units : D2D1_SVG_LENGTH_UNITS
}
struct D2D1_SVG_PRESERVE_ASPECT_RATIO {
    defer : BOOL
    align : D2D1_SVG_ASPECT_ALIGN
    meetOrSlice : D2D1_SVG_ASPECT_SCALING
}
struct D2D1_SVG_VIEWBOX {
    x : Float32
    y : Float32
    width : Float32
    height : Float32
}
struct ID2D1SvgAttribute extends ID2D1Resource {
    static IID := "{C9CDB0DD-F8C9-4E70-B7C2-301C80292C5E}"
    GetElement(element)
      => ComCall(4, this.p, ID2D1SvgElement.Ptr, element, "void")
    Clone(attribute)
      => ComCall(5, this.p, ID2D1SvgAttribute.Ptr, attribute)
}
struct ID2D1SvgPaint extends ID2D1SvgAttribute {
    static IID := "{D59BAB0A-68A2-455B-A5DC-9EB2854E2490}"
    SetPaintType(paintType)
      => ComCall(6, this.p, D2D1_SVG_PAINT_TYPE, paintType)
    GetPaintType()
      => ComCall(7, this.p, D2D1_SVG_PAINT_TYPE)
    SetColor(color)
      => ComCall(8, this.p, D2D1_COLOR_F.Ptr, color)
    GetColor(color)
      => ComCall(9, this.p, D2D1_COLOR_F.Ptr, color, "void")
    SetId(id)
      => ComCall(10, this.p, "Str", id)
    GetId(id)
      => ComCall(11, this.p, PWSTR, id, UInt32, id.Length)
    GetIdLength()
      => ComCall(12, this.p, UInt32)
}
struct ID2D1SvgStrokeDashArray extends ID2D1SvgAttribute {
    static IID := "{F1C0CA52-92A3-4F00-B4CE-F35691EFD9D9}"
    RemoveDashesAtEnd(dashesCount)
      => ComCall(6, this.p, UInt32, dashesCount)
    UpdateDashes(dashes, startIndex)
      => ComCall(7, this.p, D2D1_SVG_LENGTH.Ptr, dashes, UInt32, dashes.Length, UInt32, startIndex)
    UpdateDashes_2(dashes, startIndex)
      => ComCall(8, this.p, Float32.Ptr, dashes, UInt32, dashes.Length, UInt32, startIndex)
    GetDashes(dashes, startIndex)
      => ComCall(9, this.p, D2D1_SVG_LENGTH.Ptr, dashes, UInt32, dashes.Length, UInt32, startIndex)
    GetDashes_2(dashes, startIndex)
      => ComCall(10, this.p, Float32.Ptr, dashes, UInt32, dashes.Length, UInt32, startIndex)
    GetDashesCount()
      => ComCall(11, this.p, UInt32)
}
struct ID2D1SvgPointCollection extends ID2D1SvgAttribute {
    static IID := "{9DBE4C0D-3572-4DD9-9825-5530813BB712}"
    RemovePointsAtEnd(pointsCount)
      => ComCall(6, this.p, UInt32, pointsCount)
    UpdatePoints(points, startIndex)
      => ComCall(7, this.p, D2D_POINT_2F.Ptr, points, UInt32, points.Length, UInt32, startIndex)
    GetPoints(points, startIndex)
      => ComCall(8, this.p, D2D_POINT_2F.Ptr, points, UInt32, points.Length, UInt32, startIndex)
    GetPointsCount()
      => ComCall(9, this.p, UInt32)
}
struct ID2D1SvgPathData extends ID2D1SvgAttribute {
    static IID := "{C095E4F4-BB98-43D6-9745-4D1B84EC9888}"
    RemoveSegmentDataAtEnd(dataCount)
      => ComCall(6, this.p, UInt32, dataCount)
    UpdateSegmentData(data, startIndex)
      => ComCall(7, this.p, Float32.Ptr, data, UInt32, data.Length, UInt32, startIndex)
    GetSegmentData(data, startIndex)
      => ComCall(8, this.p, Float32.Ptr, data, UInt32, data.Length, UInt32, startIndex)
    GetSegmentDataCount()
      => ComCall(9, this.p, UInt32)
    RemoveCommandsAtEnd(commandsCount)
      => ComCall(10, this.p, UInt32, commandsCount)
    UpdateCommands(commands, startIndex)
      => ComCall(11, this.p, D2D1_SVG_PATH_COMMAND.Ptr, commands, UInt32, commands.Length, UInt32, startIndex)
    GetCommands(commands, startIndex)
      => ComCall(12, this.p, D2D1_SVG_PATH_COMMAND.Ptr, commands, UInt32, commands.Length, UInt32, startIndex)
    GetCommandsCount()
      => ComCall(13, this.p, UInt32)
    CreatePathGeometry(fillMode, pathGeometry)
      => ComCall(14, this.p, D2D1_FILL_MODE, fillMode, ID2D1PathGeometry1.Ptr, pathGeometry)
}
struct ID2D1SvgElement extends ID2D1Resource {
    static IID := "{AC7B67A6-183E-49C1-A823-0EBE40B0DB29}"
    GetDocument(document)
      => ComCall(4, this.p, ID2D1SvgDocument.Ptr, document, "void")
    GetTagName(name)
      => ComCall(5, this.p, PWSTR, name, UInt32, name.Length)
    GetTagNameLength()
      => ComCall(6, this.p, UInt32)
    IsTextContent()
      => ComCall(7, this.p, BOOL)
    GetParent(parent)
      => ComCall(8, this.p, ID2D1SvgElement.Ptr, parent, "void")
    HasChildren()
      => ComCall(9, this.p, BOOL)
    GetFirstChild(child)
      => ComCall(10, this.p, ID2D1SvgElement.Ptr, child, "void")
    GetLastChild(child)
      => ComCall(11, this.p, ID2D1SvgElement.Ptr, child, "void")
    GetPreviousChild(referenceChild, previousChild)
      => ComCall(12, this.p, ID2D1SvgElement, referenceChild, ID2D1SvgElement.Ptr, previousChild)
    GetNextChild(referenceChild, nextChild)
      => ComCall(13, this.p, ID2D1SvgElement, referenceChild, ID2D1SvgElement.Ptr, nextChild)
    InsertChildBefore(newChild, referenceChild?)
      => ComCall(14, this.p, ID2D1SvgElement, newChild, ID2D1SvgElement, referenceChild?)
    AppendChild(newChild)
      => ComCall(15, this.p, ID2D1SvgElement, newChild)
    ReplaceChild(newChild, oldChild)
      => ComCall(16, this.p, ID2D1SvgElement, newChild, ID2D1SvgElement, oldChild)
    RemoveChild(oldChild)
      => ComCall(17, this.p, ID2D1SvgElement, oldChild)
    CreateChild(tagName, newChild)
      => ComCall(18, this.p, "Str", tagName, ID2D1SvgElement.Ptr, newChild)
    IsAttributeSpecified(name, inherited?)
      => ComCall(19, this.p, "Str", name, BOOL.Ptr, inherited?, BOOL)
    GetSpecifiedAttributeCount()
      => ComCall(20, this.p, UInt32)
    GetSpecifiedAttributeName(index, name, inherited?)
      => ComCall(21, this.p, UInt32, index, PWSTR, name, UInt32, name.Length, BOOL.Ptr, inherited?)
    GetSpecifiedAttributeNameLength(index, nameLength, inherited?)
      => ComCall(22, this.p, UInt32, index, UInt32.Ptr, nameLength, BOOL.Ptr, inherited?)
    RemoveAttribute(name)
      => ComCall(23, this.p, "Str", name)
    SetTextValue(name)
      => ComCall(24, this.p, "Str", name, UInt32, name.Length)
    GetTextValue(name)
      => ComCall(25, this.p, PWSTR, name, UInt32, name.Length)
    GetTextValueLength()
      => ComCall(26, this.p, UInt32)
    SetAttributeValue(name, value)
      => ComCall(27, this.p, "Str", name, ID2D1SvgAttribute, value)
    SetAttributeValue_2(name, type, value)
      => ComCall(28, this.p, "Str", name, D2D1_SVG_ATTRIBUTE_POD_TYPE, type, Struct.Ptr, value, UInt32, value.Size)
    SetAttributeValue_3(name, type, value)
      => ComCall(29, this.p, "Str", name, D2D1_SVG_ATTRIBUTE_STRING_TYPE, type, "Str", value)
    GetAttributeValue(name, riid, value)
      => ComCall(30, this.p, "Str", name, GUID.Ptr, riid, Struct.Ptr.Ptr, value)
    GetAttributeValue_2(name, type, value)
      => ComCall(31, this.p, "Str", name, D2D1_SVG_ATTRIBUTE_POD_TYPE, type, Struct.Ptr, value, UInt32, value.Size)
    GetAttributeValue_3(name, type, value)
      => ComCall(32, this.p, "Str", name, D2D1_SVG_ATTRIBUTE_STRING_TYPE, type, PWSTR, value, UInt32, value.Length)
    GetAttributeValueLength(name, type, valueLength)
      => ComCall(33, this.p, "Str", name, D2D1_SVG_ATTRIBUTE_STRING_TYPE, type, UInt32.Ptr, valueLength)
}
struct ID2D1SvgDocument extends ID2D1Resource {
    static IID := "{86B88E4D-AFA4-4D7B-88E4-68A51C4A0AEC}"
    SetViewportSize(viewportSize)
      => ComCall(4, this.p, D2D_SIZE_F, viewportSize)
    GetViewportSize()
      => ComCall(5, this.p, D2D_SIZE_F)
    SetRoot(root?)
      => ComCall(6, this.p, ID2D1SvgElement, root?)
    GetRoot(root)
      => ComCall(7, this.p, ID2D1SvgElement.Ptr, root, "void")
    FindElementById(id, svgElement)
      => ComCall(8, this.p, "Str", id, ID2D1SvgElement.Ptr, svgElement)
    Serialize(outputXmlStream, subtree?)
      => ComCall(9, this.p, IStream, outputXmlStream, ID2D1SvgElement, subtree?)
    Deserialize(inputXmlStream, subtree)
      => ComCall(10, this.p, IStream, inputXmlStream, ID2D1SvgElement.Ptr, subtree)
    CreatePaint(paintType, color?, id?, paint)
      => ComCall(11, this.p, D2D1_SVG_PAINT_TYPE, paintType, D2D1_COLOR_F.Ptr, color?, "Str", id?, ID2D1SvgPaint.Ptr, paint)
    CreateStrokeDashArray(dashes?, strokeDashArray)
      => ComCall(12, this.p, D2D1_SVG_LENGTH.Ptr, dashes?, UInt32, dashes?.Length ?? 0, ID2D1SvgStrokeDashArray.Ptr, strokeDashArray)
    CreatePointCollection(points?, pointCollection)
      => ComCall(13, this.p, D2D_POINT_2F.Ptr, points?, UInt32, points?.Length ?? 0, ID2D1SvgPointCollection.Ptr, pointCollection)
    CreatePathData(segmentData?, commands?, pathData)
      => ComCall(14, this.p, Float32.Ptr, segmentData?, UInt32, segmentData?.Length ?? 0, D2D1_SVG_PATH_COMMAND.Ptr, commands?, UInt32, commands?.Length ?? 0, ID2D1SvgPathData.Ptr, pathData)
}
struct D2D1_INK_NIB_SHAPE extends Int32 {
    static D2D1_INK_NIB_SHAPE_ROUND := 0
    static D2D1_INK_NIB_SHAPE_SQUARE := 1
}
struct D2D1_ORIENTATION extends Int32 {
    static D2D1_ORIENTATION_DEFAULT := 1
    static D2D1_ORIENTATION_FLIP_HORIZONTAL := 2
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE180 := 3
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL := 4
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL := 5
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE270 := 6
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL := 7
    static D2D1_ORIENTATION_ROTATE_CLOCKWISE90 := 8
}
struct D2D1_IMAGE_SOURCE_LOADING_OPTIONS extends Int32 {
    static D2D1_IMAGE_SOURCE_LOADING_OPTIONS_NONE := 0
    static D2D1_IMAGE_SOURCE_LOADING_OPTIONS_RELEASE_SOURCE := 1
    static D2D1_IMAGE_SOURCE_LOADING_OPTIONS_CACHE_ON_DEMAND := 2
}
struct D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS extends Int32 {
    static D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_NONE := 0
    static D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_LOW_QUALITY_PRIMARY_CONVERSION := 1
}
struct D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS extends Int32 {
    static D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_NONE := 0
    static D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_DISABLE_DPI_SCALE := 1
}
struct D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES {
    orientation : D2D1_ORIENTATION
    scaleX : Float32
    scaleY : Float32
    interpolationMode : D2D1_INTERPOLATION_MODE
    options : D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS
}
struct D2D1_INK_POINT {
    x : Float32
    y : Float32
    radius : Float32
}
struct D2D1_INK_BEZIER_SEGMENT {
    point1 : D2D1_INK_POINT
    point2 : D2D1_INK_POINT
    point3 : D2D1_INK_POINT
}
struct D2D1_INK_STYLE_PROPERTIES {
    nibShape : D2D1_INK_NIB_SHAPE
    nibTransform : D2D_MATRIX_3X2_F
}
struct D2D1_PATCH_EDGE_MODE extends Int32 {
    static D2D1_PATCH_EDGE_MODE_ALIASED := 0
    static D2D1_PATCH_EDGE_MODE_ANTIALIASED := 1
    static D2D1_PATCH_EDGE_MODE_ALIASED_INFLATED := 2
}
struct D2D1_GRADIENT_MESH_PATCH {
    point00 : D2D_POINT_2F
    point01 : D2D_POINT_2F
    point02 : D2D_POINT_2F
    point03 : D2D_POINT_2F
    point10 : D2D_POINT_2F
    point11 : D2D_POINT_2F
    point12 : D2D_POINT_2F
    point13 : D2D_POINT_2F
    point20 : D2D_POINT_2F
    point21 : D2D_POINT_2F
    point22 : D2D_POINT_2F
    point23 : D2D_POINT_2F
    point30 : D2D_POINT_2F
    point31 : D2D_POINT_2F
    point32 : D2D_POINT_2F
    point33 : D2D_POINT_2F
    color00 : D2D1_COLOR_F
    color03 : D2D1_COLOR_F
    color30 : D2D1_COLOR_F
    color33 : D2D1_COLOR_F
    topEdgeMode : D2D1_PATCH_EDGE_MODE
    leftEdgeMode : D2D1_PATCH_EDGE_MODE
    bottomEdgeMode : D2D1_PATCH_EDGE_MODE
    rightEdgeMode : D2D1_PATCH_EDGE_MODE
}
struct D2D1_SPRITE_OPTIONS extends Int32 {
    static D2D1_SPRITE_OPTIONS_NONE := 0
    static D2D1_SPRITE_OPTIONS_CLAMP_TO_SOURCE_RECTANGLE := 1
}
struct D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION extends Int32 {
    static D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DEFAULT := 0
    static D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DISABLE := 1
}
struct D2D1_GAMMA1 extends Int32 {
    static D2D1_GAMMA1_G22 := 0
    static D2D1_GAMMA1_G10 := 1
    static D2D1_GAMMA1_G2084 := 2
}
struct D2D1_SIMPLE_COLOR_PROFILE {
    redPrimary : D2D_POINT_2F
    greenPrimary : D2D_POINT_2F
    bluePrimary : D2D_POINT_2F
    whitePointXZ : D2D_POINT_2F
    gamma : D2D1_GAMMA1
}
struct D2D1_COLOR_CONTEXT_TYPE extends Int32 {
    static D2D1_COLOR_CONTEXT_TYPE_ICC := 0
    static D2D1_COLOR_CONTEXT_TYPE_SIMPLE := 1
    static D2D1_COLOR_CONTEXT_TYPE_DXGI := 2
}
struct ID2D1InkStyle extends ID2D1Resource {
    static IID := "{BAE8B344-23FC-4071-8CB5-D05D6F073848}"
    SetNibTransform(transform)
      => ComCall(4, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
    GetNibTransform(transform)
      => ComCall(5, this.p, D2D_MATRIX_3X2_F.Ptr, transform, "void")
    SetNibShape(nibShape)
      => ComCall(6, this.p, D2D1_INK_NIB_SHAPE, nibShape, "void")
    GetNibShape()
      => ComCall(7, this.p, D2D1_INK_NIB_SHAPE)
}
struct ID2D1Ink extends ID2D1Resource {
    static IID := "{B499923B-7029-478F-A8B3-432C7C5F5312}"
    SetStartPoint(startPoint)
      => ComCall(4, this.p, D2D1_INK_POINT.Ptr, startPoint, "void")
    GetStartPoint()
      => ComCall(5, this.p, D2D1_INK_POINT)
    AddSegments(segments)
      => ComCall(6, this.p, D2D1_INK_BEZIER_SEGMENT.Ptr, segments, UInt32, segments.Length)
    RemoveSegmentsAtEnd(segmentsCount)
      => ComCall(7, this.p, UInt32, segmentsCount)
    SetSegments(startSegment, segments)
      => ComCall(8, this.p, UInt32, startSegment, D2D1_INK_BEZIER_SEGMENT.Ptr, segments, UInt32, segments.Length)
    SetSegmentAtEnd(segment)
      => ComCall(9, this.p, D2D1_INK_BEZIER_SEGMENT.Ptr, segment)
    GetSegmentCount()
      => ComCall(10, this.p, UInt32)
    GetSegments(startSegment, segments)
      => ComCall(11, this.p, UInt32, startSegment, D2D1_INK_BEZIER_SEGMENT.Ptr, segments, UInt32, segments.Length)
    StreamAsGeometry(inkStyle?, worldTransform?, flatteningTolerance, geometrySink)
      => ComCall(12, this.p, ID2D1InkStyle, inkStyle?, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, flatteningTolerance, ID2D1SimplifiedGeometrySink, geometrySink)
    GetBounds(inkStyle?, worldTransform?, bounds)
      => ComCall(13, this.p, ID2D1InkStyle, inkStyle?, D2D_MATRIX_3X2_F.Ptr, worldTransform?, D2D_RECT_F.Ptr, bounds)
}
struct ID2D1GradientMesh extends ID2D1Resource {
    static IID := "{F292E401-C050-4CDE-83D7-04962D3B23C2}"
    GetPatchCount()
      => ComCall(4, this.p, UInt32)
    GetPatches(startIndex, patches)
      => ComCall(5, this.p, UInt32, startIndex, D2D1_GRADIENT_MESH_PATCH.Ptr, patches, UInt32, patches.Length)
}
struct ID2D1ImageSource extends ID2D1Image {
    static IID := "{C9B664E5-74A1-4378-9AC2-EEFC37A3F4D8}"
    OfferResources()
      => ComCall(4, this.p)
    TryReclaimResources(resourcesDiscarded)
      => ComCall(5, this.p, BOOL.Ptr, resourcesDiscarded)
}
struct ID2D1ImageSourceFromWic extends ID2D1ImageSource {
    static IID := "{77395441-1C8F-4555-8683-F50DAB0FE792}"
    EnsureCached(rectangleToFill?)
      => ComCall(6, this.p, D2D_RECT_U.Ptr, rectangleToFill?)
    TrimCache(rectangleToPreserve?)
      => ComCall(7, this.p, D2D_RECT_U.Ptr, rectangleToPreserve?)
    GetSource(wicBitmapSource)
      => ComCall(8, this.p, IWICBitmapSource.Ptr, wicBitmapSource, "void")
}
struct ID2D1TransformedImageSource extends ID2D1Image {
    static IID := "{7F1F79E5-2796-416C-8F55-700F911445E5}"
    GetSource(imageSource)
      => ComCall(4, this.p, ID2D1ImageSource.Ptr, imageSource, "void")
    GetProperties(properties)
      => ComCall(5, this.p, D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES.Ptr, properties, "void")
}
struct ID2D1LookupTable3D extends ID2D1Resource {
    static IID := "{53DD9855-A3B0-4D5B-82E1-26E25C5E5797}"
}
struct ID2D1DeviceContext2 extends ID2D1DeviceContext1 {
    static IID := "{394EA6A3-0C34-4321-950B-6CA20F0BE6C7}"
    CreateInk(startPoint, ink)
      => ComCall(95, this.p, D2D1_INK_POINT.Ptr, startPoint, ID2D1Ink.Ptr, ink)
    CreateInkStyle(inkStyleProperties?, inkStyle)
      => ComCall(96, this.p, D2D1_INK_STYLE_PROPERTIES.Ptr, inkStyleProperties?, ID2D1InkStyle.Ptr, inkStyle)
    CreateGradientMesh(patches, gradientMesh)
      => ComCall(97, this.p, D2D1_GRADIENT_MESH_PATCH.Ptr, patches, UInt32, patches.Length, ID2D1GradientMesh.Ptr, gradientMesh)
    CreateImageSourceFromWic(wicBitmapSource, loadingOptions, alphaMode, imageSource)
      => ComCall(98, this.p, IWICBitmapSource, wicBitmapSource, D2D1_IMAGE_SOURCE_LOADING_OPTIONS, loadingOptions, D2D1_ALPHA_MODE, alphaMode, ID2D1ImageSourceFromWic.Ptr, imageSource)
    CreateLookupTable3D(precision, extents, data, strides, lookupTable)
      => ComCall(99, this.p, D2D1_BUFFER_PRECISION, precision, UInt32.Ptr, extents, UInt8.Ptr, data, UInt32, data.Length, UInt32.Ptr, strides, ID2D1LookupTable3D.Ptr, lookupTable)
    CreateImageSourceFromDxgi(surfaces, colorSpace, options, imageSource)
      => ComCall(100, this.p, IDXGISurface.Ptr, surfaces, UInt32, surfaces.Length, DXGI_COLOR_SPACE_TYPE, colorSpace, D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS, options, ID2D1ImageSource.Ptr, imageSource)
    GetGradientMeshWorldBounds(gradientMesh, pBounds)
      => ComCall(101, this.p, ID2D1GradientMesh, gradientMesh, D2D_RECT_F.Ptr, pBounds)
    DrawInk(ink, brush, inkStyle?)
      => ComCall(102, this.p, ID2D1Ink, ink, ID2D1Brush, brush, ID2D1InkStyle, inkStyle?, "void")
    DrawGradientMesh(gradientMesh)
      => ComCall(103, this.p, ID2D1GradientMesh, gradientMesh, "void")
    DrawGdiMetafile(gdiMetafile, destinationRectangle?, sourceRectangle?)
      => ComCall(104, this.p, ID2D1GdiMetafile, gdiMetafile, D2D_RECT_F.Ptr, destinationRectangle?, D2D_RECT_F.Ptr, sourceRectangle?, "void")
    CreateTransformedImageSource(imageSource, properties, transformedImageSource)
      => ComCall(105, this.p, ID2D1ImageSource, imageSource, D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES.Ptr, properties, ID2D1TransformedImageSource.Ptr, transformedImageSource)
}
struct ID2D1Device2 extends ID2D1Device1 {
    static IID := "{A44472E1-8DFB-4E60-8492-6E2861C9CA8B}"
    CreateDeviceContext(options, deviceContext2)
      => ComCall(12, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext2.Ptr, deviceContext2)
    FlushDeviceContexts(bitmap)
      => ComCall(13, this.p, ID2D1Bitmap, bitmap, "void")
    GetDxgiDevice(dxgiDevice)
      => ComCall(14, this.p, IDXGIDevice.Ptr, dxgiDevice)
}
struct ID2D1Factory3 extends ID2D1Factory2 {
    static IID := "{0869759F-4F00-413F-B03E-2BDA45404D0F}"
    CreateDevice(dxgiDevice, d2dDevice2)
      => ComCall(28, this.p, IDXGIDevice, dxgiDevice, ID2D1Device2.Ptr, d2dDevice2)
}
struct ID2D1CommandSink2 extends ID2D1CommandSink1 {
    static IID := "{3BAB440E-417E-47DF-A2E2-BC0BE6A00916}"
    DrawInk(ink, brush, inkStyle?)
      => ComCall(29, this.p, ID2D1Ink, ink, ID2D1Brush, brush, ID2D1InkStyle, inkStyle?)
    DrawGradientMesh(gradientMesh)
      => ComCall(30, this.p, ID2D1GradientMesh, gradientMesh)
    DrawGdiMetafile(gdiMetafile, destinationRectangle?, sourceRectangle?)
      => ComCall(31, this.p, ID2D1GdiMetafile, gdiMetafile, D2D_RECT_F.Ptr, destinationRectangle?, D2D_RECT_F.Ptr, sourceRectangle?)
}
struct ID2D1GdiMetafile1 extends ID2D1GdiMetafile {
    static IID := "{2E69F9E8-DD3F-4BF9-95BA-C04F49D788DF}"
    GetDpi(dpiX, dpiY)
      => ComCall(6, this.p, Float32.Ptr, dpiX, Float32.Ptr, dpiY)
    GetSourceBounds(bounds)
      => ComCall(7, this.p, D2D_RECT_F.Ptr, bounds)
}
struct ID2D1GdiMetafileSink1 extends ID2D1GdiMetafileSink {
    static IID := "{FD0ECB6B-91E6-411E-8655-395E760F91B4}"
    ProcessRecord(recordType, recordData?, recordDataSize, flags)
      => ComCall(4, this.p, UInt32, recordType, Struct.Ptr, recordData?, UInt32, recordDataSize, UInt32, flags)
}
struct ID2D1SpriteBatch extends ID2D1Resource {
    static IID := "{4DC583BF-3A10-438A-8722-E9765224F1F1}"
    AddSprites(spriteCount, destinationRectangles, sourceRectangles?, colors?, transforms?, destinationRectanglesStride, sourceRectanglesStride, colorsStride, transformsStride)
      => ComCall(4, this.p, UInt32, spriteCount, D2D_RECT_F.Ptr, destinationRectangles, D2D_RECT_U.Ptr, sourceRectangles?, D2D1_COLOR_F.Ptr, colors?, D2D_MATRIX_3X2_F.Ptr, transforms?, UInt32, destinationRectanglesStride, UInt32, sourceRectanglesStride, UInt32, colorsStride, UInt32, transformsStride)
    SetSprites(startIndex, spriteCount, destinationRectangles?, sourceRectangles?, colors?, transforms?, destinationRectanglesStride, sourceRectanglesStride, colorsStride, transformsStride)
      => ComCall(5, this.p, UInt32, startIndex, UInt32, spriteCount, D2D_RECT_F.Ptr, destinationRectangles?, D2D_RECT_U.Ptr, sourceRectangles?, D2D1_COLOR_F.Ptr, colors?, D2D_MATRIX_3X2_F.Ptr, transforms?, UInt32, destinationRectanglesStride, UInt32, sourceRectanglesStride, UInt32, colorsStride, UInt32, transformsStride)
    GetSprites(startIndex, destinationRectangles?, sourceRectangles?, colors?, transforms?)
      => ComCall(6, this.p, UInt32, startIndex, UInt32, transforms?.Length ?? 0, D2D_RECT_F.Ptr, destinationRectangles?, D2D_RECT_U.Ptr, sourceRectangles?, D2D1_COLOR_F.Ptr, colors?, D2D_MATRIX_3X2_F.Ptr, transforms?)
    GetSpriteCount()
      => ComCall(7, this.p, UInt32)
    Clear()
      => ComCall(8, this.p, "void")
}
struct ID2D1DeviceContext3 extends ID2D1DeviceContext2 {
    static IID := "{235A7496-8351-414C-BCD4-6672AB2D8E00}"
    CreateSpriteBatch(spriteBatch)
      => ComCall(106, this.p, ID2D1SpriteBatch.Ptr, spriteBatch)
    DrawSpriteBatch(spriteBatch, startIndex, spriteCount, bitmap, interpolationMode, spriteOptions)
      => ComCall(107, this.p, ID2D1SpriteBatch, spriteBatch, UInt32, startIndex, UInt32, spriteCount, ID2D1Bitmap, bitmap, D2D1_BITMAP_INTERPOLATION_MODE, interpolationMode, D2D1_SPRITE_OPTIONS, spriteOptions, "void")
}
struct ID2D1Device3 extends ID2D1Device2 {
    static IID := "{852F2087-802C-4037-AB60-FF2E7EE6FC01}"
    CreateDeviceContext(options, deviceContext3)
      => ComCall(15, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext3.Ptr, deviceContext3)
}
struct ID2D1Factory4 extends ID2D1Factory3 {
    static IID := "{BD4EC2D2-0662-4BEE-BA8E-6F29F032E096}"
    CreateDevice(dxgiDevice, d2dDevice3)
      => ComCall(29, this.p, IDXGIDevice, dxgiDevice, ID2D1Device3.Ptr, d2dDevice3)
}
struct ID2D1CommandSink3 extends ID2D1CommandSink2 {
    static IID := "{18079135-4CF3-4868-BC8E-06067E6D242D}"
    DrawSpriteBatch(spriteBatch, startIndex, spriteCount, bitmap, interpolationMode, spriteOptions)
      => ComCall(32, this.p, ID2D1SpriteBatch, spriteBatch, UInt32, startIndex, UInt32, spriteCount, ID2D1Bitmap, bitmap, D2D1_BITMAP_INTERPOLATION_MODE, interpolationMode, D2D1_SPRITE_OPTIONS, spriteOptions)
}
struct ID2D1SvgGlyphStyle extends ID2D1Resource {
    static IID := "{AF671749-D241-4DB8-8E41-DCC2E5C1A438}"
    SetFill(brush?)
      => ComCall(4, this.p, ID2D1Brush, brush?)
    GetFill(brush)
      => ComCall(5, this.p, ID2D1Brush.Ptr, brush, "void")
    SetStroke(brush?, strokeWidth, dashes?, dashOffset)
      => ComCall(6, this.p, ID2D1Brush, brush?, Float32, strokeWidth, Float32.Ptr, dashes?, UInt32, dashes?.Length ?? 0, Float32, dashOffset)
    GetStrokeDashesCount()
      => ComCall(7, this.p, UInt32)
    GetStroke(brush?, strokeWidth?, dashes?, dashOffset?)
      => ComCall(8, this.p, ID2D1Brush.Ptr, brush?, Float32.Ptr, strokeWidth?, Float32.Ptr, dashes?, UInt32, dashes?.Length ?? 0, Float32.Ptr, dashOffset?, "void")
}
struct ID2D1DeviceContext4 extends ID2D1DeviceContext3 {
    static IID := "{8C427831-3D90-4476-B647-C4FAE349E4DB}"
    CreateSvgGlyphStyle(svgGlyphStyle)
      => ComCall(108, this.p, ID2D1SvgGlyphStyle.Ptr, svgGlyphStyle)
    DrawText(string, textFormat, layoutRect, defaultFillBrush?, svgGlyphStyle?, colorPaletteIndex, options, measuringMode)
      => ComCall(109, this.p, "Str", string, UInt32, string.Length, IDWriteTextFormat, textFormat, D2D_RECT_F.Ptr, layoutRect, ID2D1Brush, defaultFillBrush?, ID2D1SvgGlyphStyle, svgGlyphStyle?, UInt32, colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS, options, DWRITE_MEASURING_MODE, measuringMode, "void")
    DrawTextLayout(origin, textLayout, defaultFillBrush?, svgGlyphStyle?, colorPaletteIndex, options)
      => ComCall(110, this.p, D2D_POINT_2F, origin, IDWriteTextLayout, textLayout, ID2D1Brush, defaultFillBrush?, ID2D1SvgGlyphStyle, svgGlyphStyle?, UInt32, colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS, options, "void")
    DrawColorBitmapGlyphRun(glyphImageFormat, baselineOrigin, glyphRun, measuringMode, bitmapSnapOption)
      => ComCall(111, this.p, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_MEASURING_MODE, measuringMode, D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION, bitmapSnapOption, "void")
    DrawSvgGlyphRun(baselineOrigin, glyphRun, defaultFillBrush?, svgGlyphStyle?, colorPaletteIndex, measuringMode)
      => ComCall(112, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, ID2D1Brush, defaultFillBrush?, ID2D1SvgGlyphStyle, svgGlyphStyle?, UInt32, colorPaletteIndex, DWRITE_MEASURING_MODE, measuringMode, "void")
    GetColorBitmapGlyphImage(glyphImageFormat, glyphOrigin, fontFace, fontEmSize, glyphIndex, isSideways, worldTransform?, dpiX, dpiY, glyphTransform, glyphImage)
      => ComCall(113, this.p, DWRITE_GLYPH_IMAGE_FORMATS, glyphImageFormat, D2D_POINT_2F, glyphOrigin, IDWriteFontFace, fontFace, Float32, fontEmSize, UInt16, glyphIndex, BOOL, isSideways, D2D_MATRIX_3X2_F.Ptr, worldTransform?, Float32, dpiX, Float32, dpiY, D2D_MATRIX_3X2_F.Ptr, glyphTransform, ID2D1Image.Ptr, glyphImage)
    GetSvgGlyphImage(glyphOrigin, fontFace, fontEmSize, glyphIndex, isSideways, worldTransform?, defaultFillBrush?, svgGlyphStyle?, colorPaletteIndex, glyphTransform, glyphImage)
      => ComCall(114, this.p, D2D_POINT_2F, glyphOrigin, IDWriteFontFace, fontFace, Float32, fontEmSize, UInt16, glyphIndex, BOOL, isSideways, D2D_MATRIX_3X2_F.Ptr, worldTransform?, ID2D1Brush, defaultFillBrush?, ID2D1SvgGlyphStyle, svgGlyphStyle?, UInt32, colorPaletteIndex, D2D_MATRIX_3X2_F.Ptr, glyphTransform, ID2D1CommandList.Ptr, glyphImage)
}
struct ID2D1Device4 extends ID2D1Device3 {
    static IID := "{D7BDB159-5683-4A46-BC9C-72DC720B858B}"
    CreateDeviceContext(options, deviceContext4)
      => ComCall(16, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext4.Ptr, deviceContext4)
    SetMaximumColorGlyphCacheMemory(maximumInBytes)
      => ComCall(17, this.p, Int64, maximumInBytes, "void")
    GetMaximumColorGlyphCacheMemory()
      => ComCall(18, this.p, Int64)
}
struct ID2D1Factory5 extends ID2D1Factory4 {
    static IID := "{C4349994-838E-4B0F-8CAB-44997D9EEACC}"
    CreateDevice(dxgiDevice, d2dDevice4)
      => ComCall(30, this.p, IDXGIDevice, dxgiDevice, ID2D1Device4.Ptr, d2dDevice4)
}
struct ID2D1CommandSink4 extends ID2D1CommandSink3 {
    static IID := "{C78A6519-40D6-4218-B2DE-BEEEB744BB3E}"
    SetPrimitiveBlend2(primitiveBlend)
      => ComCall(33, this.p, D2D1_PRIMITIVE_BLEND, primitiveBlend)
}
struct ID2D1ColorContext1 extends ID2D1ColorContext {
    static IID := "{1AB42875-C57F-4BE9-BD85-9CD78D6F55EE}"
    GetColorContextType()
      => ComCall(7, this.p, D2D1_COLOR_CONTEXT_TYPE)
    GetDXGIColorSpace()
      => ComCall(8, this.p, DXGI_COLOR_SPACE_TYPE)
    GetSimpleColorProfile(simpleProfile)
      => ComCall(9, this.p, D2D1_SIMPLE_COLOR_PROFILE.Ptr, simpleProfile)
}
struct ID2D1DeviceContext5 extends ID2D1DeviceContext4 {
    static IID := "{7836D248-68CC-4DF6-B9E8-DE991BF62EB7}"
    CreateSvgDocument(inputXmlStream?, viewportSize, svgDocument)
      => ComCall(115, this.p, IStream, inputXmlStream?, D2D_SIZE_F, viewportSize, ID2D1SvgDocument.Ptr, svgDocument)
    DrawSvgDocument(svgDocument)
      => ComCall(116, this.p, ID2D1SvgDocument, svgDocument, "void")
    CreateColorContextFromDxgiColorSpace(colorSpace, colorContext)
      => ComCall(117, this.p, DXGI_COLOR_SPACE_TYPE, colorSpace, ID2D1ColorContext1.Ptr, colorContext)
    CreateColorContextFromSimpleColorProfile(simpleProfile, colorContext)
      => ComCall(118, this.p, D2D1_SIMPLE_COLOR_PROFILE.Ptr, simpleProfile, ID2D1ColorContext1.Ptr, colorContext)
}
struct ID2D1Device5 extends ID2D1Device4 {
    static IID := "{D55BA0A4-6405-4694-AEF5-08EE1A4358B4}"
    CreateDeviceContext(options, deviceContext5)
      => ComCall(19, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext5.Ptr, deviceContext5)
}
struct ID2D1Factory6 extends ID2D1Factory5 {
    static IID := "{F9976F46-F642-44C1-97CA-DA32EA2A2635}"
    CreateDevice(dxgiDevice, d2dDevice5)
      => ComCall(31, this.p, IDXGIDevice, dxgiDevice, ID2D1Device5.Ptr, d2dDevice5)
}
struct ID2D1CommandSink5 extends ID2D1CommandSink4 {
    static IID := "{7047DD26-B1E7-44A7-959A-8349E2144FA8}"
    BlendImage(image, blendMode, targetOffset?, imageRectangle?, interpolationMode)
      => ComCall(34, this.p, ID2D1Image, image, D2D1_BLEND_MODE, blendMode, D2D_POINT_2F.Ptr, targetOffset?, D2D_RECT_F.Ptr, imageRectangle?, D2D1_INTERPOLATION_MODE, interpolationMode)
}
struct ID2D1DeviceContext6 extends ID2D1DeviceContext5 {
    static IID := "{985F7E37-4ED0-4A19-98A3-15B0EDFDE306}"
    BlendImage(image, blendMode, targetOffset?, imageRectangle?, interpolationMode)
      => ComCall(119, this.p, ID2D1Image, image, D2D1_BLEND_MODE, blendMode, D2D_POINT_2F.Ptr, targetOffset?, D2D_RECT_F.Ptr, imageRectangle?, D2D1_INTERPOLATION_MODE, interpolationMode, "void")
}
struct ID2D1Device6 extends ID2D1Device5 {
    static IID := "{7BFEF914-2D75-4BAD-BE87-E18DDB077B6D}"
    CreateDeviceContext(options, deviceContext6)
      => ComCall(20, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext6.Ptr, deviceContext6)
}
struct ID2D1Factory7 extends ID2D1Factory6 {
    static IID := "{BDC2BDD3-B96C-4DE6-BDF7-99D4745454DE}"
    CreateDevice(dxgiDevice, d2dDevice6)
      => ComCall(32, this.p, IDXGIDevice, dxgiDevice, ID2D1Device6.Ptr, d2dDevice6)
}
struct ID2D1DeviceContext7 extends ID2D1DeviceContext6 {
    static IID := "{EC891CF7-9B69-4851-9DEF-4E0915771E62}"
    GetPaintFeatureLevel()
      => ComCall(120, this.p, DWRITE_PAINT_FEATURE_LEVEL)
    DrawPaintGlyphRun(baselineOrigin, glyphRun, defaultFillBrush?, colorPaletteIndex, measuringMode)
      => ComCall(121, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, ID2D1Brush, defaultFillBrush?, UInt32, colorPaletteIndex, DWRITE_MEASURING_MODE, measuringMode, "void")
    DrawGlyphRunWithColorSupport(baselineOrigin, glyphRun, glyphRunDescription?, foregroundBrush?, svgGlyphStyle?, colorPaletteIndex, measuringMode, bitmapSnapOption)
      => ComCall(122, this.p, D2D_POINT_2F, baselineOrigin, DWRITE_GLYPH_RUN.Ptr, glyphRun, DWRITE_GLYPH_RUN_DESCRIPTION.Ptr, glyphRunDescription?, ID2D1Brush, foregroundBrush?, ID2D1SvgGlyphStyle, svgGlyphStyle?, UInt32, colorPaletteIndex, DWRITE_MEASURING_MODE, measuringMode, D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION, bitmapSnapOption, "void")
}
struct ID2D1Device7 extends ID2D1Device6 {
    static IID := "{F07C8968-DD4E-4BA6-9CBD-EB6D3752DCBB}"
    CreateDeviceContext(options, deviceContext)
      => ComCall(21, this.p, D2D1_DEVICE_CONTEXT_OPTIONS, options, ID2D1DeviceContext7.Ptr, deviceContext)
}
struct ID2D1Factory8 extends ID2D1Factory7 {
    static IID := "{677C9311-F36D-4B1F-AE86-86D1223FFD3A}"
    CreateDevice(dxgiDevice, d2dDevice6)
      => ComCall(33, this.p, IDXGIDevice, dxgiDevice, ID2D1Device7.Ptr, d2dDevice6)
}
struct ID2D1EffectContext1 extends ID2D1EffectContext {
    static IID := "{84AB595A-FC81-4546-BACD-E8EF4D8ABE7A}"
    CreateLookupTable3D(precision, extents, data, strides, lookupTable)
      => ComCall(24, this.p, D2D1_BUFFER_PRECISION, precision, UInt32.Ptr, extents, UInt8.Ptr, data, UInt32, data.Length, UInt32.Ptr, strides, ID2D1LookupTable3D.Ptr, lookupTable)
}
struct ID2D1EffectContext2 extends ID2D1EffectContext1 {
    static IID := "{577AD2A0-9FC7-4DDA-8B18-DAB810140052}"
    CreateColorContextFromDxgiColorSpace(colorSpace, colorContext)
      => ComCall(25, this.p, DXGI_COLOR_SPACE_TYPE, colorSpace, ID2D1ColorContext1.Ptr, colorContext)
    CreateColorContextFromSimpleColorProfile(simpleProfile, colorContext)
      => ComCall(26, this.p, D2D1_SIMPLE_COLOR_PROFILE.Ptr, simpleProfile, ID2D1ColorContext1.Ptr, colorContext)
}
