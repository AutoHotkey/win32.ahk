#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\Graphics.Direct2D\Types.ahk" {ID2D1Factory, ID2D1Geometry}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct GRAPHICS_EFFECT_PROPERTY_MAPPING extends Int32 {
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_UNKNOWN := 0
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_DIRECT := 1
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORX := 2
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORY := 3
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORZ := 4
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_VECTORW := 5
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_RECT_TO_VECTOR4 := 6
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_RADIANS_TO_DEGREES := 7
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_COLORMATRIX_ALPHA_MODE := 8
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR3 := 9
    static GRAPHICS_EFFECT_PROPERTY_MAPPING_COLOR_TO_VECTOR4 := 10
}
struct IGraphicsEffectD2D1Interop extends IUnknown {
    static IID := "{2FC57384-A068-44D7-A331-30982FCF7177}"
    GetEffectId(id)
      => ComCall(3, this.p, GUID.Ptr, id)
    GetNamedPropertyMapping(name, index, mapping)
      => ComCall(4, this.p, "Str", name, UInt32.Ptr, index, GRAPHICS_EFFECT_PROPERTY_MAPPING.Ptr, mapping)
    GetPropertyCount(count)
      => ComCall(5, this.p, UInt32.Ptr, count)
    GetProperty(index, value)
      => ComCall(6, this.p, UInt32, index, UnsupportedType("Windows.Foundation.IPropertyValue").Ptr, value)
    GetSource(index, source)
      => ComCall(7, this.p, UInt32, index, UnsupportedType("Windows.Graphics.Effects.IGraphicsEffectSource").Ptr, source)
    GetSourceCount(count)
      => ComCall(8, this.p, UInt32.Ptr, count)
}
struct IGeometrySource2DInterop extends IUnknown {
    static IID := "{0657AF73-53FD-47CF-84FF-C8492D2A80A3}"
    GetGeometry(value)
      => ComCall(3, this.p, ID2D1Geometry.Ptr, value)
    TryGetGeometryUsingFactory(factory, value)
      => ComCall(4, this.p, ID2D1Factory, factory, ID2D1Geometry.Ptr, value)
}
