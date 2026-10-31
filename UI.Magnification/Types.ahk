#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HWND, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {HRGN}

struct MW_FILTERMODE extends UInt32 {
    static MW_FILTERMODE_EXCLUDE := 0
    static MW_FILTERMODE_INCLUDE := 1
}
struct MAGTRANSFORM {
    v : Float32[9]
}
struct MAGIMAGEHEADER {
    width : UInt32
    height : UInt32
    format : GUID
    stride : UInt32
    offset : UInt32
    cbSize : IntPtr := this.Size
}
struct MAGCOLOREFFECT {
    transform : Float32[25]
}
struct MagImageScalingCallback extends FunctionPointer {
    static Types := [HWND, Struct.Ptr, MAGIMAGEHEADER, Struct.Ptr, MAGIMAGEHEADER, RECT, RECT, HRGN, BOOL]
}
