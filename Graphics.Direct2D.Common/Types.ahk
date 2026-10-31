#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_FORMAT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct D2D_COLOR_F {
    r : Float32
    g : Float32
    b : Float32
    a : Float32
}
struct D2D1_COLOR_F {
    r : Float32
    g : Float32
    b : Float32
    a : Float32
}
struct D2D1_ALPHA_MODE extends Int32 {
    static D2D1_ALPHA_MODE_UNKNOWN := 0
    static D2D1_ALPHA_MODE_PREMULTIPLIED := 1
    static D2D1_ALPHA_MODE_STRAIGHT := 2
    static D2D1_ALPHA_MODE_IGNORE := 3
}
struct D2D1_PIXEL_FORMAT {
    format : DXGI_FORMAT
    alphaMode : D2D1_ALPHA_MODE
}
struct D2D_POINT_2U {
    x : UInt32
    y : UInt32
}
struct D2D_POINT_2F {
    x : Float32
    y : Float32
}
struct D2D_VECTOR_2F {
    x : Float32
    y : Float32
}
struct D2D_VECTOR_3F {
    x : Float32
    y : Float32
    z : Float32
}
struct D2D_VECTOR_4F {
    x : Float32
    y : Float32
    z : Float32
    w : Float32
}
struct D2D_RECT_F {
    left : Float32
    top : Float32
    right : Float32
    bottom : Float32
}
struct D2D_RECT_U {
    left : UInt32
    top : UInt32
    right : UInt32
    bottom : UInt32
}
struct D2D_SIZE_F {
    width : Float32
    height : Float32
}
struct D2D_SIZE_U {
    width : UInt32
    height : UInt32
}
struct D2D_MATRIX_3X2_F {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            m : Float32[6]
        }
        struct _Anonymous1_e__Struct {
            m11 : Float32
            m12 : Float32
            m21 : Float32
            m22 : Float32
            dx : Float32
            dy : Float32
        }
        struct _Anonymous2_e__Struct {
            _11 : Float32
            _12 : Float32
            _21 : Float32
            _22 : Float32
            _31 : Float32
            _32 : Float32
        }
    }
}
struct D2D_MATRIX_4X3_F {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            m : Float32[12]
        }
        struct _Anonymous_e__Struct {
            _11 : Float32
            _12 : Float32
            _13 : Float32
            _21 : Float32
            _22 : Float32
            _23 : Float32
            _31 : Float32
            _32 : Float32
            _33 : Float32
            _41 : Float32
            _42 : Float32
            _43 : Float32
        }
    }
}
struct D2D_MATRIX_4X4_F {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            m : Float32[16]
        }
        struct _Anonymous_e__Struct {
            _11 : Float32
            _12 : Float32
            _13 : Float32
            _14 : Float32
            _21 : Float32
            _22 : Float32
            _23 : Float32
            _24 : Float32
            _31 : Float32
            _32 : Float32
            _33 : Float32
            _34 : Float32
            _41 : Float32
            _42 : Float32
            _43 : Float32
            _44 : Float32
        }
    }
}
struct D2D_MATRIX_5X4_F {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            m : Float32[20]
        }
        struct _Anonymous_e__Struct {
            _11 : Float32
            _12 : Float32
            _13 : Float32
            _14 : Float32
            _21 : Float32
            _22 : Float32
            _23 : Float32
            _24 : Float32
            _31 : Float32
            _32 : Float32
            _33 : Float32
            _34 : Float32
            _41 : Float32
            _42 : Float32
            _43 : Float32
            _44 : Float32
            _51 : Float32
            _52 : Float32
            _53 : Float32
            _54 : Float32
        }
    }
}
struct D2D1_GRADIENT_STOP {
    position : Float32
    color : D2D1_COLOR_F
}
struct D2D1_FIGURE_BEGIN extends Int32 {
    static D2D1_FIGURE_BEGIN_FILLED := 0
    static D2D1_FIGURE_BEGIN_HOLLOW := 1
}
struct D2D1_FIGURE_END extends Int32 {
    static D2D1_FIGURE_END_OPEN := 0
    static D2D1_FIGURE_END_CLOSED := 1
}
struct D2D1_BEZIER_SEGMENT {
    point1 : D2D_POINT_2F
    point2 : D2D_POINT_2F
    point3 : D2D_POINT_2F
}
struct D2D1_PATH_SEGMENT extends Int32 {
    static D2D1_PATH_SEGMENT_NONE := 0
    static D2D1_PATH_SEGMENT_FORCE_UNSTROKED := 1
    static D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN := 2
}
struct D2D1_FILL_MODE extends Int32 {
    static D2D1_FILL_MODE_ALTERNATE := 0
    static D2D1_FILL_MODE_WINDING := 1
}
struct ID2D1SimplifiedGeometrySink extends IUnknown {
    static IID := "{2CD9069E-12E2-11DC-9FED-001143A055F9}"
    SetFillMode(fillMode)
      => ComCall(3, this.p, D2D1_FILL_MODE, fillMode, "void")
    SetSegmentFlags(vertexFlags)
      => ComCall(4, this.p, D2D1_PATH_SEGMENT, vertexFlags, "void")
    BeginFigure(startPoint, figureBegin)
      => ComCall(5, this.p, D2D_POINT_2F, startPoint, D2D1_FIGURE_BEGIN, figureBegin, "void")
    AddLines(points)
      => ComCall(6, this.p, D2D_POINT_2F.Ptr, points, UInt32, points.Length, "void")
    AddBeziers(beziers)
      => ComCall(7, this.p, D2D1_BEZIER_SEGMENT.Ptr, beziers, UInt32, beziers.Length, "void")
    EndFigure(figureEnd)
      => ComCall(8, this.p, D2D1_FIGURE_END, figureEnd, "void")
    Close()
      => ComCall(9, this.p)
}
struct D2D1_BORDER_MODE extends Int32 {
    static D2D1_BORDER_MODE_SOFT := 0
    static D2D1_BORDER_MODE_HARD := 1
}
struct D2D1_BLEND_MODE extends Int32 {
    static D2D1_BLEND_MODE_MULTIPLY := 0
    static D2D1_BLEND_MODE_SCREEN := 1
    static D2D1_BLEND_MODE_DARKEN := 2
    static D2D1_BLEND_MODE_LIGHTEN := 3
    static D2D1_BLEND_MODE_DISSOLVE := 4
    static D2D1_BLEND_MODE_COLOR_BURN := 5
    static D2D1_BLEND_MODE_LINEAR_BURN := 6
    static D2D1_BLEND_MODE_DARKER_COLOR := 7
    static D2D1_BLEND_MODE_LIGHTER_COLOR := 8
    static D2D1_BLEND_MODE_COLOR_DODGE := 9
    static D2D1_BLEND_MODE_LINEAR_DODGE := 10
    static D2D1_BLEND_MODE_OVERLAY := 11
    static D2D1_BLEND_MODE_SOFT_LIGHT := 12
    static D2D1_BLEND_MODE_HARD_LIGHT := 13
    static D2D1_BLEND_MODE_VIVID_LIGHT := 14
    static D2D1_BLEND_MODE_LINEAR_LIGHT := 15
    static D2D1_BLEND_MODE_PIN_LIGHT := 16
    static D2D1_BLEND_MODE_HARD_MIX := 17
    static D2D1_BLEND_MODE_DIFFERENCE := 18
    static D2D1_BLEND_MODE_EXCLUSION := 19
    static D2D1_BLEND_MODE_HUE := 20
    static D2D1_BLEND_MODE_SATURATION := 21
    static D2D1_BLEND_MODE_COLOR := 22
    static D2D1_BLEND_MODE_LUMINOSITY := 23
    static D2D1_BLEND_MODE_SUBTRACT := 24
    static D2D1_BLEND_MODE_DIVISION := 25
}
struct D2D1_COLORMATRIX_ALPHA_MODE extends Int32 {
    static D2D1_COLORMATRIX_ALPHA_MODE_PREMULTIPLIED := 1
    static D2D1_COLORMATRIX_ALPHA_MODE_STRAIGHT := 2
}
struct D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE extends Int32 {
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_LINEAR := 1
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_CUBIC := 2
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR := 3
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC := 4
    static D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC := 5
}
struct D2D1_TURBULENCE_NOISE extends Int32 {
    static D2D1_TURBULENCE_NOISE_FRACTAL_SUM := 0
    static D2D1_TURBULENCE_NOISE_TURBULENCE := 1
}
struct D2D1_COMPOSITE_MODE extends Int32 {
    static D2D1_COMPOSITE_MODE_SOURCE_OVER := 0
    static D2D1_COMPOSITE_MODE_DESTINATION_OVER := 1
    static D2D1_COMPOSITE_MODE_SOURCE_IN := 2
    static D2D1_COMPOSITE_MODE_DESTINATION_IN := 3
    static D2D1_COMPOSITE_MODE_SOURCE_OUT := 4
    static D2D1_COMPOSITE_MODE_DESTINATION_OUT := 5
    static D2D1_COMPOSITE_MODE_SOURCE_ATOP := 6
    static D2D1_COMPOSITE_MODE_DESTINATION_ATOP := 7
    static D2D1_COMPOSITE_MODE_XOR := 8
    static D2D1_COMPOSITE_MODE_PLUS := 9
    static D2D1_COMPOSITE_MODE_SOURCE_COPY := 10
    static D2D1_COMPOSITE_MODE_BOUNDED_SOURCE_COPY := 11
    static D2D1_COMPOSITE_MODE_MASK_INVERT := 12
}
