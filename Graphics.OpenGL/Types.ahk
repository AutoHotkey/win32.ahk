#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {COLORREF}
#Import "..\Graphics.Gdi\Types.ahk" {EMR}

struct PFD_PIXEL_TYPE extends UInt8 {
    static PFD_TYPE_RGBA := 0
    static PFD_TYPE_COLORINDEX := 1
}
struct PFD_LAYER_TYPE extends Int8 {
    static PFD_UNDERLAY_PLANE := -1
    static PFD_MAIN_PLANE := 0
    static PFD_OVERLAY_PLANE := 1
}
struct PFD_FLAGS extends UInt32 {
    static PFD_DOUBLEBUFFER := 1
    static PFD_STEREO := 2
    static PFD_DRAW_TO_WINDOW := 4
    static PFD_DRAW_TO_BITMAP := 8
    static PFD_SUPPORT_GDI := 16
    static PFD_SUPPORT_OPENGL := 32
    static PFD_GENERIC_FORMAT := 64
    static PFD_NEED_PALETTE := 128
    static PFD_NEED_SYSTEM_PALETTE := 256
    static PFD_SWAP_EXCHANGE := 512
    static PFD_SWAP_COPY := 1024
    static PFD_SWAP_LAYER_BUFFERS := 2048
    static PFD_GENERIC_ACCELERATED := 4096
    static PFD_SUPPORT_DIRECTDRAW := 8192
    static PFD_DIRECT3D_ACCELERATED := 16384
    static PFD_SUPPORT_COMPOSITION := 32768
    static PFD_DEPTH_DONTCARE := 536870912
    static PFD_DOUBLEBUFFER_DONTCARE := 1073741824
    static PFD_STEREO_DONTCARE := 2147483648
}
struct HGLRC {
    Value : IntPtr
}
struct GLUnurbs {
    Value : IntPtr
}
struct GLUquadric {
    Value : IntPtr
}
struct GLUtesselator {
    Value : IntPtr
}
struct PIXELFORMATDESCRIPTOR {
    nSize : UInt16
    nVersion : UInt16
    dwFlags : PFD_FLAGS
    iPixelType : PFD_PIXEL_TYPE
    cColorBits : UInt8
    cRedBits : UInt8
    cRedShift : UInt8
    cGreenBits : UInt8
    cGreenShift : UInt8
    cBlueBits : UInt8
    cBlueShift : UInt8
    cAlphaBits : UInt8
    cAlphaShift : UInt8
    cAccumBits : UInt8
    cAccumRedBits : UInt8
    cAccumGreenBits : UInt8
    cAccumBlueBits : UInt8
    cAccumAlphaBits : UInt8
    cDepthBits : UInt8
    cStencilBits : UInt8
    cAuxBuffers : UInt8
    iLayerType : UInt8
    bReserved : UInt8
    dwLayerMask : UInt32
    dwVisibleMask : UInt32
    dwDamageMask : UInt32
}
struct EMRPIXELFORMAT {
    emr : EMR
    pfd : PIXELFORMATDESCRIPTOR
}
struct POINTFLOAT {
    x : Float32
    y : Float32
}
struct GLYPHMETRICSFLOAT {
    gmfBlackBoxX : Float32
    gmfBlackBoxY : Float32
    gmfptGlyphOrigin : POINTFLOAT
    gmfCellIncX : Float32
    gmfCellIncY : Float32
}
struct LAYERPLANEDESCRIPTOR {
    nSize : UInt16
    nVersion : UInt16
    dwFlags : UInt32
    iPixelType : UInt8
    cColorBits : UInt8
    cRedBits : UInt8
    cRedShift : UInt8
    cGreenBits : UInt8
    cGreenShift : UInt8
    cBlueBits : UInt8
    cBlueShift : UInt8
    cAlphaBits : UInt8
    cAlphaShift : UInt8
    cAccumBits : UInt8
    cAccumRedBits : UInt8
    cAccumGreenBits : UInt8
    cAccumBlueBits : UInt8
    cAccumAlphaBits : UInt8
    cDepthBits : UInt8
    cStencilBits : UInt8
    cAuxBuffers : UInt8
    iLayerPlane : UInt8
    bReserved : UInt8
    crTransparent : COLORREF
}
struct PFNGLARRAYELEMENTEXTPROC extends FunctionPointer {
    static Types := [Int32, "Void"]
}
struct PFNGLDRAWARRAYSEXTPROC extends FunctionPointer {
    static Types := [UInt32, Int32, Int32, "Void"]
}
struct PFNGLVERTEXPOINTEREXTPROC extends FunctionPointer {
    static Types := [Int32, UInt32, Int32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLNORMALPOINTEREXTPROC extends FunctionPointer {
    static Types := [UInt32, Int32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLCOLORPOINTEREXTPROC extends FunctionPointer {
    static Types := [Int32, UInt32, Int32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLINDEXPOINTEREXTPROC extends FunctionPointer {
    static Types := [UInt32, Int32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLTEXCOORDPOINTEREXTPROC extends FunctionPointer {
    static Types := [Int32, UInt32, Int32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLEDGEFLAGPOINTEREXTPROC extends FunctionPointer {
    static Types := [Int32, Int32, UInt8.Ptr, "Void"]
}
struct PFNGLGETPOINTERVEXTPROC extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr.Ptr, "Void"]
}
struct PFNGLARRAYELEMENTARRAYEXTPROC extends FunctionPointer {
    static Types := [UInt32, Int32, Struct.Ptr, "Void"]
}
struct PFNGLDRAWRANGEELEMENTSWINPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, Int32, UInt32, Struct.Ptr, "Void"]
}
struct PFNGLADDSWAPHINTRECTWINPROC extends FunctionPointer {
    static Types := [Int32, Int32, Int32, Int32, "Void"]
}
struct PFNGLCOLORTABLEEXTPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, Int32, UInt32, UInt32, Struct.Ptr, "Void"]
}
struct PFNGLCOLORSUBTABLEEXTPROC extends FunctionPointer {
    static Types := [UInt32, Int32, Int32, UInt32, UInt32, Struct.Ptr, "Void"]
}
struct PFNGLGETCOLORTABLEEXTPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, Struct.Ptr, "Void"]
}
struct PFNGLGETCOLORTABLEPARAMETERIVEXTPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, Int32.Ptr, "Void"]
}
struct PFNGLGETCOLORTABLEPARAMETERFVEXTPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, Float32.Ptr, "Void"]
}
struct GLUquadricErrorProc extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
struct GLUtessBeginProc extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
struct GLUtessEdgeFlagProc extends FunctionPointer {
    static Types := [UInt8, "Void"]
}
struct GLUtessVertexProc extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct GLUtessEndProc extends FunctionPointer {
    static Types := ["Void"]
}
struct GLUtessErrorProc extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
struct GLUtessCombineProc extends FunctionPointer {
    static Types := [Float64.Ptr, Struct.Ptr.Ptr, Float32.Ptr, Struct.Ptr.Ptr, "Void"]
}
struct GLUtessBeginDataProc extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, "Void"]
}
struct GLUtessEdgeFlagDataProc extends FunctionPointer {
    static Types := [UInt8, Struct.Ptr, "Void"]
}
struct GLUtessVertexDataProc extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct GLUtessEndDataProc extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct GLUtessErrorDataProc extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, "Void"]
}
struct GLUtessCombineDataProc extends FunctionPointer {
    static Types := [Float64.Ptr, Struct.Ptr.Ptr, Float32.Ptr, Struct.Ptr.Ptr, Struct.Ptr, "Void"]
}
struct GLUnurbsErrorProc extends FunctionPointer {
    static Types := [UInt32, "Void"]
}
