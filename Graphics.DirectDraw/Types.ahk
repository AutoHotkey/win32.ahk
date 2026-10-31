#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HINSTANCE, HRESULT, HWND, PSTR, PWSTR, RECT, RECTL, SIZE}
#Import "..\Graphics.Gdi\Types.ahk" {HDC, HMONITOR, HPALETTE, PALETTEENTRY, RGNDATA}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct PDD_DESTROYDRIVERDATA {
    Value : IntPtr
}
struct PDD_GETVPORTAUTOFLIPSURFACEDATA {
    Value : IntPtr
}
struct PDD_SETMODEDATA {
    Value : IntPtr
}
struct LPDDFXROP {
    Value : IntPtr
}
struct LPDDENUMCALLBACKA extends FunctionPointer {
    static Types := [GUID.Ptr, PSTR, PSTR, Struct.Ptr, BOOL]
}
struct LPDDENUMCALLBACKW extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, PWSTR, Struct.Ptr, BOOL]
}
struct LPDDENUMCALLBACKEXA extends FunctionPointer {
    static Types := [GUID.Ptr, PSTR, PSTR, Struct.Ptr, HMONITOR, BOOL]
}
struct LPDDENUMCALLBACKEXW extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, PWSTR, Struct.Ptr, HMONITOR, BOOL]
}
struct LPDIRECTDRAWENUMERATEEXA extends FunctionPointer {
    static Types := [LPDDENUMCALLBACKEXA, Struct.Ptr, UInt32, HRESULT]
}
struct LPDIRECTDRAWENUMERATEEXW extends FunctionPointer {
    static Types := [LPDDENUMCALLBACKEXW, Struct.Ptr, UInt32, HRESULT]
}
struct LPDDENUMMODESCALLBACK extends FunctionPointer {
    static Types := [DDSURFACEDESC.Ptr, Struct.Ptr, HRESULT]
}
struct LPDDENUMMODESCALLBACK2 extends FunctionPointer {
    static Types := [DDSURFACEDESC2.Ptr, Struct.Ptr, HRESULT]
}
struct LPDDENUMSURFACESCALLBACK extends FunctionPointer {
    static Types := [IDirectDrawSurface, DDSURFACEDESC.Ptr, Struct.Ptr, HRESULT]
}
struct LPDDENUMSURFACESCALLBACK2 extends FunctionPointer {
    static Types := [IDirectDrawSurface4, DDSURFACEDESC2.Ptr, Struct.Ptr, HRESULT]
}
struct LPDDENUMSURFACESCALLBACK7 extends FunctionPointer {
    static Types := [IDirectDrawSurface7, DDSURFACEDESC2.Ptr, Struct.Ptr, HRESULT]
}
struct DDARGB {
    blue : UInt8
    green : UInt8
    red : UInt8
    alpha : UInt8
}
struct DDRGBA {
    red : UInt8
    green : UInt8
    blue : UInt8
    alpha : UInt8
}
struct DDCOLORKEY {
    dwColorSpaceLowValue : UInt32
    dwColorSpaceHighValue : UInt32
}
struct DDBLTFX {
    dwSize : UInt32
    dwDDFX : UInt32
    dwROP : UInt32
    dwDDROP : UInt32
    dwRotationAngle : UInt32
    dwZBufferOpCode : UInt32
    dwZBufferLow : UInt32
    dwZBufferHigh : UInt32
    dwZBufferBaseDest : UInt32
    dwZDestConstBitDepth : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    dwZSrcConstBitDepth : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    dwAlphaEdgeBlendBitDepth : UInt32
    dwAlphaEdgeBlend : UInt32
    dwReserved : UInt32
    dwAlphaDestConstBitDepth : UInt32
    Anonymous3 : this._Anonymous3_e__Union
    dwAlphaSrcConstBitDepth : UInt32
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    ddckDestColorkey : DDCOLORKEY
    ddckSrcColorkey : DDCOLORKEY
    struct _Anonymous1_e__Union {
        union {
            dwZDestConst : UInt32
            lpDDSZBufferDest : IDirectDrawSurface
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwZSrcConst : UInt32
            lpDDSZBufferSrc : IDirectDrawSurface
        }
    }
    struct _Anonymous3_e__Union {
        union {
            dwAlphaDestConst : UInt32
            lpDDSAlphaDest : IDirectDrawSurface
        }
    }
    struct _Anonymous4_e__Union {
        union {
            dwAlphaSrcConst : UInt32
            lpDDSAlphaSrc : IDirectDrawSurface
        }
    }
    struct _Anonymous5_e__Union {
        union {
            dwFillColor : UInt32
            dwFillDepth : UInt32
            dwFillPixel : UInt32
            lpDDSPattern : IDirectDrawSurface
        }
    }
}
struct DDSCAPS {
    dwCaps : UInt32
}
struct DDOSCAPS {
    dwCaps : UInt32
}
struct DDSCAPSEX {
    dwCaps2 : UInt32
    dwCaps3 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwCaps4 : UInt32
            dwVolumeDepth : UInt32
        }
    }
}
struct DDSCAPS2 {
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCaps3 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwCaps4 : UInt32
            dwVolumeDepth : UInt32
        }
    }
}
struct DDCAPS_DX1 {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
}
struct DDCAPS_DX3 {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwReserved4 : UInt32
    dwReserved5 : UInt32
    dwReserved6 : UInt32
}
struct DDCAPS_DX5 {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwMaxVideoPorts : UInt32
    dwCurrVideoPorts : UInt32
    dwSVBCaps2 : UInt32
    dwNLVBCaps : UInt32
    dwNLVBCaps2 : UInt32
    dwNLVBCKeyCaps : UInt32
    dwNLVBFXCaps : UInt32
    dwNLVBRops : UInt32[8]
}
struct DDCAPS_DX6 {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsOldCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwMaxVideoPorts : UInt32
    dwCurrVideoPorts : UInt32
    dwSVBCaps2 : UInt32
    dwNLVBCaps : UInt32
    dwNLVBCaps2 : UInt32
    dwNLVBCKeyCaps : UInt32
    dwNLVBFXCaps : UInt32
    dwNLVBRops : UInt32[8]
    ddsCaps : DDSCAPS2
}
struct DDCAPS_DX7 {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsOldCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwMaxVideoPorts : UInt32
    dwCurrVideoPorts : UInt32
    dwSVBCaps2 : UInt32
    dwNLVBCaps : UInt32
    dwNLVBCaps2 : UInt32
    dwNLVBCKeyCaps : UInt32
    dwNLVBFXCaps : UInt32
    dwNLVBRops : UInt32[8]
    ddsCaps : DDSCAPS2
}
struct DDPIXELFORMAT {
    dwSize : UInt32
    dwFlags : UInt32
    dwFourCC : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    struct _Anonymous1_e__Union {
        union {
            dwRGBBitCount : UInt32
            dwYUVBitCount : UInt32
            dwZBufferBitDepth : UInt32
            dwAlphaBitDepth : UInt32
            dwLuminanceBitCount : UInt32
            dwBumpBitCount : UInt32
            dwPrivateFormatBitCount : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwRBitMask : UInt32
            dwYBitMask : UInt32
            dwStencilBitDepth : UInt32
            dwLuminanceBitMask : UInt32
            dwBumpDuBitMask : UInt32
            dwOperations : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            dwGBitMask : UInt32
            dwUBitMask : UInt32
            dwZBitMask : UInt32
            dwBumpDvBitMask : UInt32
            MultiSampleCaps : this._MultiSampleCaps_e__Struct
        }
        struct _MultiSampleCaps_e__Struct {
            wFlipMSTypes : UInt16
            wBltMSTypes : UInt16
        }
    }
    struct _Anonymous4_e__Union {
        union {
            dwBBitMask : UInt32
            dwVBitMask : UInt32
            dwStencilBitMask : UInt32
            dwBumpLuminanceBitMask : UInt32
        }
    }
    struct _Anonymous5_e__Union {
        union {
            dwRGBAlphaBitMask : UInt32
            dwYUVAlphaBitMask : UInt32
            dwLuminanceAlphaBitMask : UInt32
            dwRGBZBitMask : UInt32
            dwYUVZBitMask : UInt32
        }
    }
}
struct DDOVERLAYFX {
    dwSize : UInt32
    dwAlphaEdgeBlendBitDepth : UInt32
    dwAlphaEdgeBlend : UInt32
    dwReserved : UInt32
    dwAlphaDestConstBitDepth : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    dwAlphaSrcConstBitDepth : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    dckDestColorkey : DDCOLORKEY
    dckSrcColorkey : DDCOLORKEY
    dwDDFX : UInt32
    dwFlags : UInt32
    struct _Anonymous1_e__Union {
        union {
            dwAlphaDestConst : UInt32
            lpDDSAlphaDest : IDirectDrawSurface
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwAlphaSrcConst : UInt32
            lpDDSAlphaSrc : IDirectDrawSurface
        }
    }
}
struct DDBLTBATCH {
    lprDest : RECT.Ptr
    lpDDSSrc : IDirectDrawSurface
    lprSrc : RECT.Ptr
    dwFlags : UInt32
    lpDDBltFx : DDBLTFX.Ptr
}
struct DDGAMMARAMP {
    red : UInt16[256]
    green : UInt16[256]
    blue : UInt16[256]
}
struct DDDEVICEIDENTIFIER {
    szDriver : CHAR[512]
    szDescription : CHAR[512]
    liDriverVersion : Int64
    dwVendorId : UInt32
    dwDeviceId : UInt32
    dwSubSysId : UInt32
    dwRevision : UInt32
    guidDeviceIdentifier : GUID
}
struct DDDEVICEIDENTIFIER2 {
    szDriver : CHAR[512]
    szDescription : CHAR[512]
    liDriverVersion : Int64
    dwVendorId : UInt32
    dwDeviceId : UInt32
    dwSubSysId : UInt32
    dwRevision : UInt32
    guidDeviceIdentifier : GUID
    dwWHQLLevel : UInt32
}
struct LPCLIPPERCALLBACK extends FunctionPointer {
    static Types := [IDirectDrawClipper, HWND, UInt32, Struct.Ptr, UInt32]
}
struct IDirectDraw extends IUnknown {
    static IID := "{6C14DB80-A733-11CE-A521-0020AF0BE560}"
    Compact()
      => ComCall(3, this.p)
    CreateClipper(param0, param1, param2)
      => ComCall(4, this.p, UInt32, param0, IDirectDrawClipper.Ptr, param1, IUnknown, param2)
    CreatePalette(param0, param1, param2, param3)
      => ComCall(5, this.p, UInt32, param0, PALETTEENTRY.Ptr, param1, IDirectDrawPalette.Ptr, param2, IUnknown, param3)
    CreateSurface(param0, param1, param2)
      => ComCall(6, this.p, DDSURFACEDESC.Ptr, param0, IDirectDrawSurface.Ptr, param1, IUnknown, param2)
    DuplicateSurface(param0, param1)
      => ComCall(7, this.p, IDirectDrawSurface, param0, IDirectDrawSurface.Ptr, param1)
    EnumDisplayModes(param0, param1, param2, param3)
      => ComCall(8, this.p, UInt32, param0, DDSURFACEDESC.Ptr, param1, Struct.Ptr, param2, LPDDENUMMODESCALLBACK, param3)
    EnumSurfaces(param0, param1, param2, param3)
      => ComCall(9, this.p, UInt32, param0, DDSURFACEDESC.Ptr, param1, Struct.Ptr, param2, LPDDENUMSURFACESCALLBACK, param3)
    FlipToGDISurface()
      => ComCall(10, this.p)
    GetCaps(param0, param1)
      => ComCall(11, this.p, DDCAPS_DX7.Ptr, param0, DDCAPS_DX7.Ptr, param1)
    GetDisplayMode(param0)
      => ComCall(12, this.p, DDSURFACEDESC.Ptr, param0)
    GetFourCCCodes(param0, param1)
      => ComCall(13, this.p, UInt32.Ptr, param0, UInt32.Ptr, param1)
    GetGDISurface(param0)
      => ComCall(14, this.p, IDirectDrawSurface.Ptr, param0)
    GetMonitorFrequency(param0)
      => ComCall(15, this.p, UInt32.Ptr, param0)
    GetScanLine(param0)
      => ComCall(16, this.p, UInt32.Ptr, param0)
    GetVerticalBlankStatus(param0)
      => ComCall(17, this.p, BOOL.Ptr, param0)
    Initialize(param0)
      => ComCall(18, this.p, GUID.Ptr, param0)
    RestoreDisplayMode()
      => ComCall(19, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(20, this.p, HWND, param0, UInt32, param1)
    SetDisplayMode(param0, param1, param2)
      => ComCall(21, this.p, UInt32, param0, UInt32, param1, UInt32, param2)
    WaitForVerticalBlank(param0, param1)
      => ComCall(22, this.p, UInt32, param0, HANDLE, param1)
}
struct IDirectDraw2 extends IUnknown {
    static IID := "{B3A6F3E0-2B43-11CF-A2DE-00AA00B93356}"
    Compact()
      => ComCall(3, this.p)
    CreateClipper(param0, param1, param2)
      => ComCall(4, this.p, UInt32, param0, IDirectDrawClipper.Ptr, param1, IUnknown, param2)
    CreatePalette(param0, param1, param2, param3)
      => ComCall(5, this.p, UInt32, param0, PALETTEENTRY.Ptr, param1, IDirectDrawPalette.Ptr, param2, IUnknown, param3)
    CreateSurface(param0, param1, param2)
      => ComCall(6, this.p, DDSURFACEDESC.Ptr, param0, IDirectDrawSurface.Ptr, param1, IUnknown, param2)
    DuplicateSurface(param0, param1)
      => ComCall(7, this.p, IDirectDrawSurface, param0, IDirectDrawSurface.Ptr, param1)
    EnumDisplayModes(param0, param1, param2, param3)
      => ComCall(8, this.p, UInt32, param0, DDSURFACEDESC.Ptr, param1, Struct.Ptr, param2, LPDDENUMMODESCALLBACK, param3)
    EnumSurfaces(param0, param1, param2, param3)
      => ComCall(9, this.p, UInt32, param0, DDSURFACEDESC.Ptr, param1, Struct.Ptr, param2, LPDDENUMSURFACESCALLBACK, param3)
    FlipToGDISurface()
      => ComCall(10, this.p)
    GetCaps(param0, param1)
      => ComCall(11, this.p, DDCAPS_DX7.Ptr, param0, DDCAPS_DX7.Ptr, param1)
    GetDisplayMode(param0)
      => ComCall(12, this.p, DDSURFACEDESC.Ptr, param0)
    GetFourCCCodes(param0, param1)
      => ComCall(13, this.p, UInt32.Ptr, param0, UInt32.Ptr, param1)
    GetGDISurface(param0)
      => ComCall(14, this.p, IDirectDrawSurface.Ptr, param0)
    GetMonitorFrequency(param0)
      => ComCall(15, this.p, UInt32.Ptr, param0)
    GetScanLine(param0)
      => ComCall(16, this.p, UInt32.Ptr, param0)
    GetVerticalBlankStatus(param0)
      => ComCall(17, this.p, BOOL.Ptr, param0)
    Initialize(param0)
      => ComCall(18, this.p, GUID.Ptr, param0)
    RestoreDisplayMode()
      => ComCall(19, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(20, this.p, HWND, param0, UInt32, param1)
    SetDisplayMode(param0, param1, param2, param3, param4)
      => ComCall(21, this.p, UInt32, param0, UInt32, param1, UInt32, param2, UInt32, param3, UInt32, param4)
    WaitForVerticalBlank(param0, param1)
      => ComCall(22, this.p, UInt32, param0, HANDLE, param1)
    GetAvailableVidMem(param0, param1, param2)
      => ComCall(23, this.p, DDSCAPS.Ptr, param0, UInt32.Ptr, param1, UInt32.Ptr, param2)
}
struct IDirectDraw4 extends IUnknown {
    static IID := "{9C59509A-39BD-11D1-8C4A-00C04FD930C5}"
    Compact()
      => ComCall(3, this.p)
    CreateClipper(param0, param1, param2)
      => ComCall(4, this.p, UInt32, param0, IDirectDrawClipper.Ptr, param1, IUnknown, param2)
    CreatePalette(param0, param1, param2, param3)
      => ComCall(5, this.p, UInt32, param0, PALETTEENTRY.Ptr, param1, IDirectDrawPalette.Ptr, param2, IUnknown, param3)
    CreateSurface(param0, param1, param2)
      => ComCall(6, this.p, DDSURFACEDESC2.Ptr, param0, IDirectDrawSurface4.Ptr, param1, IUnknown, param2)
    DuplicateSurface(param0, param1)
      => ComCall(7, this.p, IDirectDrawSurface4, param0, IDirectDrawSurface4.Ptr, param1)
    EnumDisplayModes(param0, param1, param2, param3)
      => ComCall(8, this.p, UInt32, param0, DDSURFACEDESC2.Ptr, param1, Struct.Ptr, param2, LPDDENUMMODESCALLBACK2, param3)
    EnumSurfaces(param0, param1, param2, param3)
      => ComCall(9, this.p, UInt32, param0, DDSURFACEDESC2.Ptr, param1, Struct.Ptr, param2, LPDDENUMSURFACESCALLBACK2, param3)
    FlipToGDISurface()
      => ComCall(10, this.p)
    GetCaps(param0, param1)
      => ComCall(11, this.p, DDCAPS_DX7.Ptr, param0, DDCAPS_DX7.Ptr, param1)
    GetDisplayMode(param0)
      => ComCall(12, this.p, DDSURFACEDESC2.Ptr, param0)
    GetFourCCCodes(param0, param1)
      => ComCall(13, this.p, UInt32.Ptr, param0, UInt32.Ptr, param1)
    GetGDISurface(param0)
      => ComCall(14, this.p, IDirectDrawSurface4.Ptr, param0)
    GetMonitorFrequency(param0)
      => ComCall(15, this.p, UInt32.Ptr, param0)
    GetScanLine(param0)
      => ComCall(16, this.p, UInt32.Ptr, param0)
    GetVerticalBlankStatus(param0)
      => ComCall(17, this.p, BOOL.Ptr, param0)
    Initialize(param0)
      => ComCall(18, this.p, GUID.Ptr, param0)
    RestoreDisplayMode()
      => ComCall(19, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(20, this.p, HWND, param0, UInt32, param1)
    SetDisplayMode(param0, param1, param2, param3, param4)
      => ComCall(21, this.p, UInt32, param0, UInt32, param1, UInt32, param2, UInt32, param3, UInt32, param4)
    WaitForVerticalBlank(param0, param1)
      => ComCall(22, this.p, UInt32, param0, HANDLE, param1)
    GetAvailableVidMem(param0, param1, param2)
      => ComCall(23, this.p, DDSCAPS2.Ptr, param0, UInt32.Ptr, param1, UInt32.Ptr, param2)
    GetSurfaceFromDC(param0, param1)
      => ComCall(24, this.p, HDC, param0, IDirectDrawSurface4.Ptr, param1)
    RestoreAllSurfaces()
      => ComCall(25, this.p)
    TestCooperativeLevel()
      => ComCall(26, this.p)
    GetDeviceIdentifier(param0, param1)
      => ComCall(27, this.p, DDDEVICEIDENTIFIER.Ptr, param0, UInt32, param1)
}
struct IDirectDraw7 extends IUnknown {
    static IID := "{15E65EC0-3B9C-11D2-B92F-00609797EA5B}"
    Compact()
      => ComCall(3, this.p)
    CreateClipper(param0, param1, param2)
      => ComCall(4, this.p, UInt32, param0, IDirectDrawClipper.Ptr, param1, IUnknown, param2)
    CreatePalette(param0, param1, param2, param3)
      => ComCall(5, this.p, UInt32, param0, PALETTEENTRY.Ptr, param1, IDirectDrawPalette.Ptr, param2, IUnknown, param3)
    CreateSurface(param0, param1, param2)
      => ComCall(6, this.p, DDSURFACEDESC2.Ptr, param0, IDirectDrawSurface7.Ptr, param1, IUnknown, param2)
    DuplicateSurface(param0, param1)
      => ComCall(7, this.p, IDirectDrawSurface7, param0, IDirectDrawSurface7.Ptr, param1)
    EnumDisplayModes(param0, param1, param2, param3)
      => ComCall(8, this.p, UInt32, param0, DDSURFACEDESC2.Ptr, param1, Struct.Ptr, param2, LPDDENUMMODESCALLBACK2, param3)
    EnumSurfaces(param0, param1, param2, param3)
      => ComCall(9, this.p, UInt32, param0, DDSURFACEDESC2.Ptr, param1, Struct.Ptr, param2, LPDDENUMSURFACESCALLBACK7, param3)
    FlipToGDISurface()
      => ComCall(10, this.p)
    GetCaps(param0, param1)
      => ComCall(11, this.p, DDCAPS_DX7.Ptr, param0, DDCAPS_DX7.Ptr, param1)
    GetDisplayMode(param0)
      => ComCall(12, this.p, DDSURFACEDESC2.Ptr, param0)
    GetFourCCCodes(param0, param1)
      => ComCall(13, this.p, UInt32.Ptr, param0, UInt32.Ptr, param1)
    GetGDISurface(param0)
      => ComCall(14, this.p, IDirectDrawSurface7.Ptr, param0)
    GetMonitorFrequency(param0)
      => ComCall(15, this.p, UInt32.Ptr, param0)
    GetScanLine(param0)
      => ComCall(16, this.p, UInt32.Ptr, param0)
    GetVerticalBlankStatus(param0)
      => ComCall(17, this.p, BOOL.Ptr, param0)
    Initialize(param0)
      => ComCall(18, this.p, GUID.Ptr, param0)
    RestoreDisplayMode()
      => ComCall(19, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(20, this.p, HWND, param0, UInt32, param1)
    SetDisplayMode(param0, param1, param2, param3, param4)
      => ComCall(21, this.p, UInt32, param0, UInt32, param1, UInt32, param2, UInt32, param3, UInt32, param4)
    WaitForVerticalBlank(param0, param1)
      => ComCall(22, this.p, UInt32, param0, HANDLE, param1)
    GetAvailableVidMem(param0, param1, param2)
      => ComCall(23, this.p, DDSCAPS2.Ptr, param0, UInt32.Ptr, param1, UInt32.Ptr, param2)
    GetSurfaceFromDC(param0, param1)
      => ComCall(24, this.p, HDC, param0, IDirectDrawSurface7.Ptr, param1)
    RestoreAllSurfaces()
      => ComCall(25, this.p)
    TestCooperativeLevel()
      => ComCall(26, this.p)
    GetDeviceIdentifier(param0, param1)
      => ComCall(27, this.p, DDDEVICEIDENTIFIER2.Ptr, param0, UInt32, param1)
    StartModeTest(param0, param1, param2)
      => ComCall(28, this.p, SIZE.Ptr, param0, UInt32, param1, UInt32, param2)
    EvaluateMode(param0, param1)
      => ComCall(29, this.p, UInt32, param0, UInt32.Ptr, param1)
}
struct IDirectDrawPalette extends IUnknown {
    static IID := "{6C14DB84-A733-11CE-A521-0020AF0BE560}"
    GetCaps(param0)
      => ComCall(3, this.p, UInt32.Ptr, param0)
    GetEntries(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, UInt32, param1, UInt32, param2, PALETTEENTRY.Ptr, param3)
    Initialize(param0, param1, param2)
      => ComCall(5, this.p, IDirectDraw, param0, UInt32, param1, PALETTEENTRY.Ptr, param2)
    SetEntries(param0, param1, param2, param3)
      => ComCall(6, this.p, UInt32, param0, UInt32, param1, UInt32, param2, PALETTEENTRY.Ptr, param3)
}
struct IDirectDrawClipper extends IUnknown {
    static IID := "{6C14DB85-A733-11CE-A521-0020AF0BE560}"
    GetClipList(param0, param1, param2)
      => ComCall(3, this.p, RECT.Ptr, param0, RGNDATA.Ptr, param1, UInt32.Ptr, param2)
    GetHWnd(param0)
      => ComCall(4, this.p, HWND.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(5, this.p, IDirectDraw, param0, UInt32, param1)
    IsClipListChanged(param0)
      => ComCall(6, this.p, BOOL.Ptr, param0)
    SetClipList(param0, param1)
      => ComCall(7, this.p, RGNDATA.Ptr, param0, UInt32, param1)
    SetHWnd(param0, param1)
      => ComCall(8, this.p, UInt32, param0, HWND, param1)
}
struct IDirectDrawSurface extends IUnknown {
    static IID := "{6C14DB81-A733-11CE-A521-0020AF0BE560}"
    AddAttachedSurface(param0)
      => ComCall(3, this.p, IDirectDrawSurface, param0)
    AddOverlayDirtyRect(param0)
      => ComCall(4, this.p, RECT.Ptr, param0)
    Blt(param0, param1, param2, param3, param4)
      => ComCall(5, this.p, RECT.Ptr, param0, IDirectDrawSurface, param1, RECT.Ptr, param2, UInt32, param3, DDBLTFX.Ptr, param4)
    BltBatch(param0, param1, param2)
      => ComCall(6, this.p, DDBLTBATCH.Ptr, param0, UInt32, param1, UInt32, param2)
    BltFast(param0, param1, param2, param3, param4)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1, IDirectDrawSurface, param2, RECT.Ptr, param3, UInt32, param4)
    DeleteAttachedSurface(param0, param1)
      => ComCall(8, this.p, UInt32, param0, IDirectDrawSurface, param1)
    EnumAttachedSurfaces(param0, param1)
      => ComCall(9, this.p, Struct.Ptr, param0, LPDDENUMSURFACESCALLBACK, param1)
    EnumOverlayZOrders(param0, param1, param2)
      => ComCall(10, this.p, UInt32, param0, Struct.Ptr, param1, LPDDENUMSURFACESCALLBACK, param2)
    Flip(param0, param1)
      => ComCall(11, this.p, IDirectDrawSurface, param0, UInt32, param1)
    GetAttachedSurface(param0, param1)
      => ComCall(12, this.p, DDSCAPS.Ptr, param0, IDirectDrawSurface.Ptr, param1)
    GetBltStatus(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetCaps(param0)
      => ComCall(14, this.p, DDSCAPS.Ptr, param0)
    GetClipper(param0)
      => ComCall(15, this.p, IDirectDrawClipper.Ptr, param0)
    GetColorKey(param0, param1)
      => ComCall(16, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    GetDC(param0)
      => ComCall(17, this.p, HDC.Ptr, param0)
    GetFlipStatus(param0)
      => ComCall(18, this.p, UInt32, param0)
    GetOverlayPosition(param0, param1)
      => ComCall(19, this.p, Int32.Ptr, param0, Int32.Ptr, param1)
    GetPalette(param0)
      => ComCall(20, this.p, IDirectDrawPalette.Ptr, param0)
    GetPixelFormat(param0)
      => ComCall(21, this.p, DDPIXELFORMAT.Ptr, param0)
    GetSurfaceDesc(param0)
      => ComCall(22, this.p, DDSURFACEDESC.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(23, this.p, IDirectDraw, param0, DDSURFACEDESC.Ptr, param1)
    IsLost()
      => ComCall(24, this.p)
    Lock(param0, param1, param2, param3)
      => ComCall(25, this.p, RECT.Ptr, param0, DDSURFACEDESC.Ptr, param1, UInt32, param2, HANDLE, param3)
    ReleaseDC(param0)
      => ComCall(26, this.p, HDC, param0)
    Restore()
      => ComCall(27, this.p)
    SetClipper(param0)
      => ComCall(28, this.p, IDirectDrawClipper, param0)
    SetColorKey(param0, param1)
      => ComCall(29, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    SetOverlayPosition(param0, param1)
      => ComCall(30, this.p, Int32, param0, Int32, param1)
    SetPalette(param0)
      => ComCall(31, this.p, IDirectDrawPalette, param0)
    Unlock(param0)
      => ComCall(32, this.p, Struct.Ptr, param0)
    UpdateOverlay(param0, param1, param2, param3, param4)
      => ComCall(33, this.p, RECT.Ptr, param0, IDirectDrawSurface, param1, RECT.Ptr, param2, UInt32, param3, DDOVERLAYFX.Ptr, param4)
    UpdateOverlayDisplay(param0)
      => ComCall(34, this.p, UInt32, param0)
    UpdateOverlayZOrder(param0, param1)
      => ComCall(35, this.p, UInt32, param0, IDirectDrawSurface, param1)
}
struct IDirectDrawSurface2 extends IUnknown {
    static IID := "{57805885-6EEC-11CF-9441-A82303C10E27}"
    AddAttachedSurface(param0)
      => ComCall(3, this.p, IDirectDrawSurface2, param0)
    AddOverlayDirtyRect(param0)
      => ComCall(4, this.p, RECT.Ptr, param0)
    Blt(param0, param1, param2, param3, param4)
      => ComCall(5, this.p, RECT.Ptr, param0, IDirectDrawSurface2, param1, RECT.Ptr, param2, UInt32, param3, DDBLTFX.Ptr, param4)
    BltBatch(param0, param1, param2)
      => ComCall(6, this.p, DDBLTBATCH.Ptr, param0, UInt32, param1, UInt32, param2)
    BltFast(param0, param1, param2, param3, param4)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1, IDirectDrawSurface2, param2, RECT.Ptr, param3, UInt32, param4)
    DeleteAttachedSurface(param0, param1)
      => ComCall(8, this.p, UInt32, param0, IDirectDrawSurface2, param1)
    EnumAttachedSurfaces(param0, param1)
      => ComCall(9, this.p, Struct.Ptr, param0, LPDDENUMSURFACESCALLBACK, param1)
    EnumOverlayZOrders(param0, param1, param2)
      => ComCall(10, this.p, UInt32, param0, Struct.Ptr, param1, LPDDENUMSURFACESCALLBACK, param2)
    Flip(param0, param1)
      => ComCall(11, this.p, IDirectDrawSurface2, param0, UInt32, param1)
    GetAttachedSurface(param0, param1)
      => ComCall(12, this.p, DDSCAPS.Ptr, param0, IDirectDrawSurface2.Ptr, param1)
    GetBltStatus(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetCaps(param0)
      => ComCall(14, this.p, DDSCAPS.Ptr, param0)
    GetClipper(param0)
      => ComCall(15, this.p, IDirectDrawClipper.Ptr, param0)
    GetColorKey(param0, param1)
      => ComCall(16, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    GetDC(param0)
      => ComCall(17, this.p, HDC.Ptr, param0)
    GetFlipStatus(param0)
      => ComCall(18, this.p, UInt32, param0)
    GetOverlayPosition(param0, param1)
      => ComCall(19, this.p, Int32.Ptr, param0, Int32.Ptr, param1)
    GetPalette(param0)
      => ComCall(20, this.p, IDirectDrawPalette.Ptr, param0)
    GetPixelFormat(param0)
      => ComCall(21, this.p, DDPIXELFORMAT.Ptr, param0)
    GetSurfaceDesc(param0)
      => ComCall(22, this.p, DDSURFACEDESC.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(23, this.p, IDirectDraw, param0, DDSURFACEDESC.Ptr, param1)
    IsLost()
      => ComCall(24, this.p)
    Lock(param0, param1, param2, param3)
      => ComCall(25, this.p, RECT.Ptr, param0, DDSURFACEDESC.Ptr, param1, UInt32, param2, HANDLE, param3)
    ReleaseDC(param0)
      => ComCall(26, this.p, HDC, param0)
    Restore()
      => ComCall(27, this.p)
    SetClipper(param0)
      => ComCall(28, this.p, IDirectDrawClipper, param0)
    SetColorKey(param0, param1)
      => ComCall(29, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    SetOverlayPosition(param0, param1)
      => ComCall(30, this.p, Int32, param0, Int32, param1)
    SetPalette(param0)
      => ComCall(31, this.p, IDirectDrawPalette, param0)
    Unlock(param0)
      => ComCall(32, this.p, Struct.Ptr, param0)
    UpdateOverlay(param0, param1, param2, param3, param4)
      => ComCall(33, this.p, RECT.Ptr, param0, IDirectDrawSurface2, param1, RECT.Ptr, param2, UInt32, param3, DDOVERLAYFX.Ptr, param4)
    UpdateOverlayDisplay(param0)
      => ComCall(34, this.p, UInt32, param0)
    UpdateOverlayZOrder(param0, param1)
      => ComCall(35, this.p, UInt32, param0, IDirectDrawSurface2, param1)
    GetDDInterface(param0)
      => ComCall(36, this.p, Struct.Ptr.Ptr, param0)
    PageLock(param0)
      => ComCall(37, this.p, UInt32, param0)
    PageUnlock(param0)
      => ComCall(38, this.p, UInt32, param0)
}
struct IDirectDrawSurface3 extends IUnknown {
    static IID := "{DA044E00-69B2-11D0-A1D5-00AA00B8DFBB}"
    AddAttachedSurface(param0)
      => ComCall(3, this.p, IDirectDrawSurface3, param0)
    AddOverlayDirtyRect(param0)
      => ComCall(4, this.p, RECT.Ptr, param0)
    Blt(param0, param1, param2, param3, param4)
      => ComCall(5, this.p, RECT.Ptr, param0, IDirectDrawSurface3, param1, RECT.Ptr, param2, UInt32, param3, DDBLTFX.Ptr, param4)
    BltBatch(param0, param1, param2)
      => ComCall(6, this.p, DDBLTBATCH.Ptr, param0, UInt32, param1, UInt32, param2)
    BltFast(param0, param1, param2, param3, param4)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1, IDirectDrawSurface3, param2, RECT.Ptr, param3, UInt32, param4)
    DeleteAttachedSurface(param0, param1)
      => ComCall(8, this.p, UInt32, param0, IDirectDrawSurface3, param1)
    EnumAttachedSurfaces(param0, param1)
      => ComCall(9, this.p, Struct.Ptr, param0, LPDDENUMSURFACESCALLBACK, param1)
    EnumOverlayZOrders(param0, param1, param2)
      => ComCall(10, this.p, UInt32, param0, Struct.Ptr, param1, LPDDENUMSURFACESCALLBACK, param2)
    Flip(param0, param1)
      => ComCall(11, this.p, IDirectDrawSurface3, param0, UInt32, param1)
    GetAttachedSurface(param0, param1)
      => ComCall(12, this.p, DDSCAPS.Ptr, param0, IDirectDrawSurface3.Ptr, param1)
    GetBltStatus(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetCaps(param0)
      => ComCall(14, this.p, DDSCAPS.Ptr, param0)
    GetClipper(param0)
      => ComCall(15, this.p, IDirectDrawClipper.Ptr, param0)
    GetColorKey(param0, param1)
      => ComCall(16, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    GetDC(param0)
      => ComCall(17, this.p, HDC.Ptr, param0)
    GetFlipStatus(param0)
      => ComCall(18, this.p, UInt32, param0)
    GetOverlayPosition(param0, param1)
      => ComCall(19, this.p, Int32.Ptr, param0, Int32.Ptr, param1)
    GetPalette(param0)
      => ComCall(20, this.p, IDirectDrawPalette.Ptr, param0)
    GetPixelFormat(param0)
      => ComCall(21, this.p, DDPIXELFORMAT.Ptr, param0)
    GetSurfaceDesc(param0)
      => ComCall(22, this.p, DDSURFACEDESC.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(23, this.p, IDirectDraw, param0, DDSURFACEDESC.Ptr, param1)
    IsLost()
      => ComCall(24, this.p)
    Lock(param0, param1, param2, param3)
      => ComCall(25, this.p, RECT.Ptr, param0, DDSURFACEDESC.Ptr, param1, UInt32, param2, HANDLE, param3)
    ReleaseDC(param0)
      => ComCall(26, this.p, HDC, param0)
    Restore()
      => ComCall(27, this.p)
    SetClipper(param0)
      => ComCall(28, this.p, IDirectDrawClipper, param0)
    SetColorKey(param0, param1)
      => ComCall(29, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    SetOverlayPosition(param0, param1)
      => ComCall(30, this.p, Int32, param0, Int32, param1)
    SetPalette(param0)
      => ComCall(31, this.p, IDirectDrawPalette, param0)
    Unlock(param0)
      => ComCall(32, this.p, Struct.Ptr, param0)
    UpdateOverlay(param0, param1, param2, param3, param4)
      => ComCall(33, this.p, RECT.Ptr, param0, IDirectDrawSurface3, param1, RECT.Ptr, param2, UInt32, param3, DDOVERLAYFX.Ptr, param4)
    UpdateOverlayDisplay(param0)
      => ComCall(34, this.p, UInt32, param0)
    UpdateOverlayZOrder(param0, param1)
      => ComCall(35, this.p, UInt32, param0, IDirectDrawSurface3, param1)
    GetDDInterface(param0)
      => ComCall(36, this.p, Struct.Ptr.Ptr, param0)
    PageLock(param0)
      => ComCall(37, this.p, UInt32, param0)
    PageUnlock(param0)
      => ComCall(38, this.p, UInt32, param0)
    SetSurfaceDesc(param0, param1)
      => ComCall(39, this.p, DDSURFACEDESC.Ptr, param0, UInt32, param1)
}
struct IDirectDrawSurface4 extends IUnknown {
    static IID := "{0B2B8630-AD35-11D0-8EA6-00609797EA5B}"
    AddAttachedSurface(param0)
      => ComCall(3, this.p, IDirectDrawSurface4, param0)
    AddOverlayDirtyRect(param0)
      => ComCall(4, this.p, RECT.Ptr, param0)
    Blt(param0, param1, param2, param3, param4)
      => ComCall(5, this.p, RECT.Ptr, param0, IDirectDrawSurface4, param1, RECT.Ptr, param2, UInt32, param3, DDBLTFX.Ptr, param4)
    BltBatch(param0, param1, param2)
      => ComCall(6, this.p, DDBLTBATCH.Ptr, param0, UInt32, param1, UInt32, param2)
    BltFast(param0, param1, param2, param3, param4)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1, IDirectDrawSurface4, param2, RECT.Ptr, param3, UInt32, param4)
    DeleteAttachedSurface(param0, param1)
      => ComCall(8, this.p, UInt32, param0, IDirectDrawSurface4, param1)
    EnumAttachedSurfaces(param0, param1)
      => ComCall(9, this.p, Struct.Ptr, param0, LPDDENUMSURFACESCALLBACK2, param1)
    EnumOverlayZOrders(param0, param1, param2)
      => ComCall(10, this.p, UInt32, param0, Struct.Ptr, param1, LPDDENUMSURFACESCALLBACK2, param2)
    Flip(param0, param1)
      => ComCall(11, this.p, IDirectDrawSurface4, param0, UInt32, param1)
    GetAttachedSurface(param0, param1)
      => ComCall(12, this.p, DDSCAPS2.Ptr, param0, IDirectDrawSurface4.Ptr, param1)
    GetBltStatus(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetCaps(param0)
      => ComCall(14, this.p, DDSCAPS2.Ptr, param0)
    GetClipper(param0)
      => ComCall(15, this.p, IDirectDrawClipper.Ptr, param0)
    GetColorKey(param0, param1)
      => ComCall(16, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    GetDC(param0)
      => ComCall(17, this.p, HDC.Ptr, param0)
    GetFlipStatus(param0)
      => ComCall(18, this.p, UInt32, param0)
    GetOverlayPosition(param0, param1)
      => ComCall(19, this.p, Int32.Ptr, param0, Int32.Ptr, param1)
    GetPalette(param0)
      => ComCall(20, this.p, IDirectDrawPalette.Ptr, param0)
    GetPixelFormat(param0)
      => ComCall(21, this.p, DDPIXELFORMAT.Ptr, param0)
    GetSurfaceDesc(param0)
      => ComCall(22, this.p, DDSURFACEDESC2.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(23, this.p, IDirectDraw, param0, DDSURFACEDESC2.Ptr, param1)
    IsLost()
      => ComCall(24, this.p)
    Lock(param0, param1, param2, param3)
      => ComCall(25, this.p, RECT.Ptr, param0, DDSURFACEDESC2.Ptr, param1, UInt32, param2, HANDLE, param3)
    ReleaseDC(param0)
      => ComCall(26, this.p, HDC, param0)
    Restore()
      => ComCall(27, this.p)
    SetClipper(param0)
      => ComCall(28, this.p, IDirectDrawClipper, param0)
    SetColorKey(param0, param1)
      => ComCall(29, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    SetOverlayPosition(param0, param1)
      => ComCall(30, this.p, Int32, param0, Int32, param1)
    SetPalette(param0)
      => ComCall(31, this.p, IDirectDrawPalette, param0)
    Unlock(param0)
      => ComCall(32, this.p, RECT.Ptr, param0)
    UpdateOverlay(param0, param1, param2, param3, param4)
      => ComCall(33, this.p, RECT.Ptr, param0, IDirectDrawSurface4, param1, RECT.Ptr, param2, UInt32, param3, DDOVERLAYFX.Ptr, param4)
    UpdateOverlayDisplay(param0)
      => ComCall(34, this.p, UInt32, param0)
    UpdateOverlayZOrder(param0, param1)
      => ComCall(35, this.p, UInt32, param0, IDirectDrawSurface4, param1)
    GetDDInterface(param0)
      => ComCall(36, this.p, Struct.Ptr.Ptr, param0)
    PageLock(param0)
      => ComCall(37, this.p, UInt32, param0)
    PageUnlock(param0)
      => ComCall(38, this.p, UInt32, param0)
    SetSurfaceDesc(param0, param1)
      => ComCall(39, this.p, DDSURFACEDESC2.Ptr, param0, UInt32, param1)
    SetPrivateData(param0, param1, param2, param3)
      => ComCall(40, this.p, GUID.Ptr, param0, Struct.Ptr, param1, UInt32, param2, UInt32, param3)
    GetPrivateData(param0, param1, param2)
      => ComCall(41, this.p, GUID.Ptr, param0, Struct.Ptr, param1, UInt32.Ptr, param2)
    FreePrivateData(param0)
      => ComCall(42, this.p, GUID.Ptr, param0)
    GetUniquenessValue(param0)
      => ComCall(43, this.p, UInt32.Ptr, param0)
    ChangeUniquenessValue()
      => ComCall(44, this.p)
}
struct IDirectDrawSurface7 extends IUnknown {
    static IID := "{06675A80-3B9B-11D2-B92F-00609797EA5B}"
    AddAttachedSurface(param0)
      => ComCall(3, this.p, IDirectDrawSurface7, param0)
    AddOverlayDirtyRect(param0)
      => ComCall(4, this.p, RECT.Ptr, param0)
    Blt(param0, param1, param2, param3, param4)
      => ComCall(5, this.p, RECT.Ptr, param0, IDirectDrawSurface7, param1, RECT.Ptr, param2, UInt32, param3, DDBLTFX.Ptr, param4)
    BltBatch(param0, param1, param2)
      => ComCall(6, this.p, DDBLTBATCH.Ptr, param0, UInt32, param1, UInt32, param2)
    BltFast(param0, param1, param2, param3, param4)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1, IDirectDrawSurface7, param2, RECT.Ptr, param3, UInt32, param4)
    DeleteAttachedSurface(param0, param1)
      => ComCall(8, this.p, UInt32, param0, IDirectDrawSurface7, param1)
    EnumAttachedSurfaces(param0, param1)
      => ComCall(9, this.p, Struct.Ptr, param0, LPDDENUMSURFACESCALLBACK7, param1)
    EnumOverlayZOrders(param0, param1, param2)
      => ComCall(10, this.p, UInt32, param0, Struct.Ptr, param1, LPDDENUMSURFACESCALLBACK7, param2)
    Flip(param0, param1)
      => ComCall(11, this.p, IDirectDrawSurface7, param0, UInt32, param1)
    GetAttachedSurface(param0, param1)
      => ComCall(12, this.p, DDSCAPS2.Ptr, param0, IDirectDrawSurface7.Ptr, param1)
    GetBltStatus(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetCaps(param0)
      => ComCall(14, this.p, DDSCAPS2.Ptr, param0)
    GetClipper(param0)
      => ComCall(15, this.p, IDirectDrawClipper.Ptr, param0)
    GetColorKey(param0, param1)
      => ComCall(16, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    GetDC(param0)
      => ComCall(17, this.p, HDC.Ptr, param0)
    GetFlipStatus(param0)
      => ComCall(18, this.p, UInt32, param0)
    GetOverlayPosition(param0, param1)
      => ComCall(19, this.p, Int32.Ptr, param0, Int32.Ptr, param1)
    GetPalette(param0)
      => ComCall(20, this.p, IDirectDrawPalette.Ptr, param0)
    GetPixelFormat(param0)
      => ComCall(21, this.p, DDPIXELFORMAT.Ptr, param0)
    GetSurfaceDesc(param0)
      => ComCall(22, this.p, DDSURFACEDESC2.Ptr, param0)
    Initialize(param0, param1)
      => ComCall(23, this.p, IDirectDraw, param0, DDSURFACEDESC2.Ptr, param1)
    IsLost()
      => ComCall(24, this.p)
    Lock(param0, param1, param2, param3)
      => ComCall(25, this.p, RECT.Ptr, param0, DDSURFACEDESC2.Ptr, param1, UInt32, param2, HANDLE, param3)
    ReleaseDC(param0)
      => ComCall(26, this.p, HDC, param0)
    Restore()
      => ComCall(27, this.p)
    SetClipper(param0)
      => ComCall(28, this.p, IDirectDrawClipper, param0)
    SetColorKey(param0, param1)
      => ComCall(29, this.p, UInt32, param0, DDCOLORKEY.Ptr, param1)
    SetOverlayPosition(param0, param1)
      => ComCall(30, this.p, Int32, param0, Int32, param1)
    SetPalette(param0)
      => ComCall(31, this.p, IDirectDrawPalette, param0)
    Unlock(param0)
      => ComCall(32, this.p, RECT.Ptr, param0)
    UpdateOverlay(param0, param1, param2, param3, param4)
      => ComCall(33, this.p, RECT.Ptr, param0, IDirectDrawSurface7, param1, RECT.Ptr, param2, UInt32, param3, DDOVERLAYFX.Ptr, param4)
    UpdateOverlayDisplay(param0)
      => ComCall(34, this.p, UInt32, param0)
    UpdateOverlayZOrder(param0, param1)
      => ComCall(35, this.p, UInt32, param0, IDirectDrawSurface7, param1)
    GetDDInterface(param0)
      => ComCall(36, this.p, Struct.Ptr.Ptr, param0)
    PageLock(param0)
      => ComCall(37, this.p, UInt32, param0)
    PageUnlock(param0)
      => ComCall(38, this.p, UInt32, param0)
    SetSurfaceDesc(param0, param1)
      => ComCall(39, this.p, DDSURFACEDESC2.Ptr, param0, UInt32, param1)
    SetPrivateData(param0, param1, param2, param3)
      => ComCall(40, this.p, GUID.Ptr, param0, Struct.Ptr, param1, UInt32, param2, UInt32, param3)
    GetPrivateData(param0, param1, param2)
      => ComCall(41, this.p, GUID.Ptr, param0, Struct.Ptr, param1, UInt32.Ptr, param2)
    FreePrivateData(param0)
      => ComCall(42, this.p, GUID.Ptr, param0)
    GetUniquenessValue(param0)
      => ComCall(43, this.p, UInt32.Ptr, param0)
    ChangeUniquenessValue()
      => ComCall(44, this.p)
    SetPriority(param0)
      => ComCall(45, this.p, UInt32, param0)
    GetPriority(param0)
      => ComCall(46, this.p, UInt32.Ptr, param0)
    SetLOD(param0)
      => ComCall(47, this.p, UInt32, param0)
    GetLOD(param0)
      => ComCall(48, this.p, UInt32.Ptr, param0)
}
struct IDirectDrawColorControl extends IUnknown {
    static IID := "{4B9F0EE0-0D7E-11D0-9B06-00A0C903A3B8}"
    GetColorControls(param0)
      => ComCall(3, this.p, DDCOLORCONTROL.Ptr, param0)
    SetColorControls(param0)
      => ComCall(4, this.p, DDCOLORCONTROL.Ptr, param0)
}
struct IDirectDrawGammaControl extends IUnknown {
    static IID := "{69C11C3E-B46B-11D1-AD7A-00C04FC29B4E}"
    GetGammaRamp(param0, param1)
      => ComCall(3, this.p, UInt32, param0, DDGAMMARAMP.Ptr, param1)
    SetGammaRamp(param0, param1)
      => ComCall(4, this.p, UInt32, param0, DDGAMMARAMP.Ptr, param1)
}
struct DDSURFACEDESC {
    dwSize : UInt32
    dwFlags : UInt32
    dwHeight : UInt32
    dwWidth : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    dwBackBufferCount : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    dwAlphaBitDepth : UInt32
    dwReserved : UInt32
    lpSurface : Struct.Ptr
    ddckCKDestOverlay : DDCOLORKEY
    ddckCKDestBlt : DDCOLORKEY
    ddckCKSrcOverlay : DDCOLORKEY
    ddckCKSrcBlt : DDCOLORKEY
    ddpfPixelFormat : DDPIXELFORMAT
    ddsCaps : DDSCAPS
    struct _Anonymous1_e__Union {
        union {
            lPitch : Int32
            dwLinearSize : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwMipMapCount : UInt32
            dwZBufferBitDepth : UInt32
            dwRefreshRate : UInt32
        }
    }
}
struct DDSURFACEDESC2 {
    dwSize : UInt32
    dwFlags : UInt32
    dwHeight : UInt32
    dwWidth : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    dwAlphaBitDepth : UInt32
    dwReserved : UInt32
    lpSurface : Struct.Ptr
    Anonymous4 : this._Anonymous4_e__Union
    ddckCKDestBlt : DDCOLORKEY
    ddckCKSrcOverlay : DDCOLORKEY
    ddckCKSrcBlt : DDCOLORKEY
    Anonymous5 : this._Anonymous5_e__Union
    ddsCaps : DDSCAPS2
    dwTextureStage : UInt32
    struct _Anonymous1_e__Union {
        union {
            lPitch : Int32
            dwLinearSize : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwBackBufferCount : UInt32
            dwDepth : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            dwMipMapCount : UInt32
            dwRefreshRate : UInt32
            dwSrcVBHandle : UInt32
        }
    }
    struct _Anonymous4_e__Union {
        union {
            ddckCKDestOverlay : DDCOLORKEY
            dwEmptyFaceColor : UInt32
        }
    }
    struct _Anonymous5_e__Union {
        union {
            ddpfPixelFormat : DDPIXELFORMAT
            dwFVF : UInt32
        }
    }
}
struct DDOPTSURFACEDESC {
    dwSize : UInt32
    dwFlags : UInt32
    ddSCaps : DDSCAPS2
    ddOSCaps : DDOSCAPS
    guid : GUID
    dwCompressionRatio : UInt32
}
struct DDCOLORCONTROL {
    dwSize : UInt32
    dwFlags : UInt32
    lBrightness : Int32
    lContrast : Int32
    lHue : Int32
    lSaturation : Int32
    lSharpness : Int32
    lGamma : Int32
    lColorEnable : Int32
    dwReserved1 : UInt32
}
struct LPDDENUMVIDEOCALLBACK extends FunctionPointer {
    static Types := [DDVIDEOPORTCAPS.Ptr, Struct.Ptr, HRESULT]
}
struct IDDVideoPortContainer extends IUnknown {
    static IID := "{6C142760-A733-11CE-A521-0020AF0BE560}"
    CreateVideoPort(param0, param1, param2, param3)
      => ComCall(3, this.p, UInt32, param0, DDVIDEOPORTDESC.Ptr, param1, IDirectDrawVideoPort.Ptr, param2, IUnknown, param3)
    EnumVideoPorts(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, DDVIDEOPORTCAPS.Ptr, param1, Struct.Ptr, param2, LPDDENUMVIDEOCALLBACK, param3)
    GetVideoPortConnectInfo(param0, param2?)
      => ComCall(5, this.p, UInt32, param0, UInt32.Ptr, param2?.Length ?? 0, DDVIDEOPORTCONNECT.Ptr, param2?)
    QueryVideoPortStatus(param0, param1)
      => ComCall(6, this.p, UInt32, param0, DDVIDEOPORTSTATUS.Ptr, param1)
}
struct IDirectDrawVideoPort extends IUnknown {
    static IID := "{B36D93E0-2B43-11CF-A2DE-00AA00B93356}"
    Flip(param0, param1)
      => ComCall(3, this.p, IDirectDrawSurface, param0, UInt32, param1)
    GetBandwidthInfo(param0, param1, param2, param3, param4)
      => ComCall(4, this.p, DDPIXELFORMAT.Ptr, param0, UInt32, param1, UInt32, param2, UInt32, param3, DDVIDEOPORTBANDWIDTH.Ptr, param4)
    GetColorControls(param0)
      => ComCall(5, this.p, DDCOLORCONTROL.Ptr, param0)
    GetInputFormats(param1?, param2)
      => ComCall(6, this.p, UInt32.Ptr, param1?.Length ?? 0, DDPIXELFORMAT.Ptr, param1?, UInt32, param2)
    GetOutputFormats(param0, param2?, param3)
      => ComCall(7, this.p, DDPIXELFORMAT.Ptr, param0, UInt32.Ptr, param2?.Length ?? 0, DDPIXELFORMAT.Ptr, param2?, UInt32, param3)
    GetFieldPolarity(param0)
      => ComCall(8, this.p, BOOL.Ptr, param0)
    GetVideoLine(param0)
      => ComCall(9, this.p, UInt32.Ptr, param0)
    GetVideoSignalStatus(param0)
      => ComCall(10, this.p, UInt32.Ptr, param0)
    SetColorControls(param0)
      => ComCall(11, this.p, DDCOLORCONTROL.Ptr, param0)
    SetTargetSurface(param0, param1)
      => ComCall(12, this.p, IDirectDrawSurface, param0, UInt32, param1)
    StartVideo(param0)
      => ComCall(13, this.p, DDVIDEOPORTINFO.Ptr, param0)
    StopVideo()
      => ComCall(14, this.p)
    UpdateVideo(param0)
      => ComCall(15, this.p, DDVIDEOPORTINFO.Ptr, param0)
    WaitForSync(param0, param1, param2)
      => ComCall(16, this.p, UInt32, param0, UInt32, param1, UInt32, param2)
}
struct IDirectDrawVideoPortNotify extends IUnknown {
    static IID := "{A655FB94-0589-4E57-B333-567A89468C88}"
    AcquireNotification(param0, param1)
      => ComCall(3, this.p, HANDLE.Ptr, param0, DDVIDEOPORTNOTIFY.Ptr, param1)
    ReleaseNotification(param0)
      => ComCall(4, this.p, HANDLE, param0)
}
struct DDVIDEOPORTCONNECT {
    dwSize : UInt32
    dwPortWidth : UInt32
    guidTypeID : GUID
    dwFlags : UInt32
    dwReserved1 : IntPtr
}
struct DDVIDEOPORTCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwMaxWidth : UInt32
    dwMaxVBIWidth : UInt32
    dwMaxHeight : UInt32
    dwVideoPortID : UInt32
    dwCaps : UInt32
    dwFX : UInt32
    dwNumAutoFlipSurfaces : UInt32
    dwAlignVideoPortBoundary : UInt32
    dwAlignVideoPortPrescaleWidth : UInt32
    dwAlignVideoPortCropBoundary : UInt32
    dwAlignVideoPortCropWidth : UInt32
    dwPreshrinkXStep : UInt32
    dwPreshrinkYStep : UInt32
    dwNumVBIAutoFlipSurfaces : UInt32
    dwNumPreferredAutoflip : UInt32
    wNumFilterTapsX : UInt16
    wNumFilterTapsY : UInt16
}
struct DDVIDEOPORTDESC {
    dwSize : UInt32
    dwFieldWidth : UInt32
    dwVBIWidth : UInt32
    dwFieldHeight : UInt32
    dwMicrosecondsPerField : UInt32
    dwMaxPixelsPerSecond : UInt32
    dwVideoPortID : UInt32
    dwReserved1 : UInt32
    VideoPortType : DDVIDEOPORTCONNECT
    dwReserved2 : IntPtr
    dwReserved3 : IntPtr
}
struct DDVIDEOPORTINFO {
    dwSize : UInt32
    dwOriginX : UInt32
    dwOriginY : UInt32
    dwVPFlags : UInt32
    rCrop : RECT
    dwPrescaleWidth : UInt32
    dwPrescaleHeight : UInt32
    lpddpfInputFormat : DDPIXELFORMAT.Ptr
    lpddpfVBIInputFormat : DDPIXELFORMAT.Ptr
    lpddpfVBIOutputFormat : DDPIXELFORMAT.Ptr
    dwVBIHeight : UInt32
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
}
struct DDVIDEOPORTBANDWIDTH {
    dwSize : UInt32
    dwCaps : UInt32
    dwOverlay : UInt32
    dwColorkey : UInt32
    dwYInterpolate : UInt32
    dwYInterpAndColorkey : UInt32
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
}
struct DDVIDEOPORTSTATUS {
    dwSize : UInt32
    bInUse : BOOL
    dwFlags : UInt32
    dwReserved1 : UInt32
    VideoPortType : DDVIDEOPORTCONNECT
    dwReserved2 : IntPtr
    dwReserved3 : IntPtr
}
struct DDVIDEOPORTNOTIFY {
    ApproximateTimeStamp : Int64
    lField : Int32
    dwSurfaceIndex : UInt32
    lDone : Int32
}
struct IDirectDrawKernel extends IUnknown {
    static IID := "{8D56C120-6A08-11D0-9B06-00A0C903A3B8}"
    GetCaps(param0)
      => ComCall(3, this.p, DDKERNELCAPS.Ptr, param0)
    GetKernelHandle(param0)
      => ComCall(4, this.p, IntPtr.Ptr, param0)
    ReleaseKernelHandle()
      => ComCall(5, this.p)
}
struct IDirectDrawSurfaceKernel extends IUnknown {
    static IID := "{60755DA0-6A40-11D0-9B06-00A0C903A3B8}"
    GetKernelHandle(param0)
      => ComCall(3, this.p, IntPtr.Ptr, param0)
    ReleaseKernelHandle()
      => ComCall(4, this.p)
}
struct DDKERNELCAPS {
    dwSize : UInt32
    dwCaps : UInt32
    dwIRQCaps : UInt32
}
struct SURFACEALIGNMENT {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Linear : this._Linear_e__Struct
            Rectangular : this._Rectangular_e__Struct
        }
        struct _Linear_e__Struct {
            dwStartAlignment : UInt32
            dwPitchAlignment : UInt32
            dwFlags : UInt32
            dwReserved2 : UInt32
        }
        struct _Rectangular_e__Struct {
            dwXAlignment : UInt32
            dwYAlignment : UInt32
            dwFlags : UInt32
            dwReserved2 : UInt32
        }
    }
}
struct HEAPALIGNMENT {
    dwSize : UInt32
    ddsCaps : DDSCAPS
    dwReserved : UInt32
    ExecuteBuffer : SURFACEALIGNMENT
    Overlay : SURFACEALIGNMENT
    Texture : SURFACEALIGNMENT
    ZBuffer : SURFACEALIGNMENT
    AlphaBuffer : SURFACEALIGNMENT
    Offscreen : SURFACEALIGNMENT
    FlipTarget : SURFACEALIGNMENT
}
struct DD_GETHEAPALIGNMENTDATA {
    dwInstance : IntPtr
    dwHeap : UInt32
    ddRVal : HRESULT
    GetHeapAlignment : Struct.Ptr
    Alignment : HEAPALIGNMENT
}
struct VMEML {
    next : VMEML.Ptr
    ptr : IntPtr
    size : UInt32
    bDiscardable : BOOL
}
struct VMEMR {
    next : VMEMR.Ptr
    prev : VMEMR.Ptr
    pUp : VMEMR.Ptr
    pDown : VMEMR.Ptr
    pLeft : VMEMR.Ptr
    pRight : VMEMR.Ptr
    ptr : IntPtr
    size : UInt32
    x : UInt32
    y : UInt32
    cx : UInt32
    cy : UInt32
    flags : UInt32
    pBits : IntPtr
    bDiscardable : BOOL
}
struct VMEMHEAP {
    dwFlags : UInt32
    stride : UInt32
    freeList : Struct.Ptr
    allocList : Struct.Ptr
    dwTotalSize : UInt32
    fpGARTLin : IntPtr
    fpGARTDev : IntPtr
    dwCommitedSize : UInt32
    dwCoalesceCount : UInt32
    Alignment : HEAPALIGNMENT
    ddsCapsEx : DDSCAPSEX
    ddsCapsExAlt : DDSCAPSEX
    liPhysAGPBase : Int64
    hdevAGP : HANDLE
    pvPhysRsrv : Struct.Ptr
    pAgpCommitMask : UInt8.Ptr
    dwAgpCommitMaskSize : UInt32
}
struct PROCESS_LIST {
    lpLink : PROCESS_LIST.Ptr
    dwProcessId : UInt32
    dwRefCnt : UInt32
    dwAlphaDepth : UInt32
    dwZDepth : UInt32
}
struct DDMONITORINFO {
    Manufacturer : UInt16
    Product : UInt16
    SerialNumber : UInt32
    DeviceIdentifier : GUID
    Mode640x480 : Int32
    Mode800x600 : Int32
    Mode1024x768 : Int32
    Mode1280x1024 : Int32
    Mode1600x1200 : Int32
    ModeReserved1 : Int32
    ModeReserved2 : Int32
    ModeReserved3 : Int32
}
struct DD32BITDRIVERDATA {
    szName : CHAR[260]
    szEntryPoint : CHAR[64]
    dwContext : UInt32
}
struct DDVERSIONDATA {
    dwHALVersion : UInt32
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
}
struct LPDD32BITDRIVERINIT extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct VIDMEM {
    dwFlags : UInt32
    fpStart : IntPtr
    Anonymous1 : this._Anonymous1_e__Union
    ddsCaps : DDSCAPS
    ddsCapsAlt : DDSCAPS
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            fpEnd : IntPtr
            dwWidth : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            lpHeap : VMEMHEAP.Ptr
            dwHeight : UInt32
        }
    }
}
struct VIDMEMINFO {
    fpPrimary : IntPtr
    dwFlags : UInt32
    dwDisplayWidth : UInt32
    dwDisplayHeight : UInt32
    lDisplayPitch : Int32
    ddpfDisplay : DDPIXELFORMAT
    dwOffscreenAlign : UInt32
    dwOverlayAlign : UInt32
    dwTextureAlign : UInt32
    dwZBufferAlign : UInt32
    dwAlphaAlign : UInt32
    dwNumHeaps : UInt32
    pvmList : VIDMEM.Ptr
}
struct HEAPALIAS {
    fpVidMem : IntPtr
    lpAlias : Struct.Ptr
    dwAliasSize : UInt32
}
struct HEAPALIASINFO {
    dwRefCnt : UInt32
    dwFlags : UInt32
    dwNumHeaps : UInt32
    lpAliases : HEAPALIAS.Ptr
}
struct IUNKNOWN_LIST {
    lpLink : IUNKNOWN_LIST.Ptr
    lpGuid : GUID.Ptr
    lpIUnknown : IUnknown
}
struct LPDDHEL_INIT extends FunctionPointer {
    static Types := [DDRAWI_DIRECTDRAW_GBL.Ptr, BOOL, BOOL]
}
struct LPDDHAL_SETCOLORKEY extends FunctionPointer {
    static Types := [DDHAL_DRVSETCOLORKEYDATA.Ptr, UInt32]
}
struct LPDDHAL_CANCREATESURFACE extends FunctionPointer {
    static Types := [DDHAL_CANCREATESURFACEDATA.Ptr, UInt32]
}
struct LPDDHAL_WAITFORVERTICALBLANK extends FunctionPointer {
    static Types := [DDHAL_WAITFORVERTICALBLANKDATA.Ptr, UInt32]
}
struct LPDDHAL_CREATESURFACE extends FunctionPointer {
    static Types := [DDHAL_CREATESURFACEDATA.Ptr, UInt32]
}
struct LPDDHAL_DESTROYDRIVER extends FunctionPointer {
    static Types := [DDHAL_DESTROYDRIVERDATA.Ptr, UInt32]
}
struct LPDDHAL_SETMODE extends FunctionPointer {
    static Types := [DDHAL_SETMODEDATA.Ptr, UInt32]
}
struct LPDDHAL_CREATEPALETTE extends FunctionPointer {
    static Types := [DDHAL_CREATEPALETTEDATA.Ptr, UInt32]
}
struct LPDDHAL_GETSCANLINE extends FunctionPointer {
    static Types := [DDHAL_GETSCANLINEDATA.Ptr, UInt32]
}
struct LPDDHAL_SETEXCLUSIVEMODE extends FunctionPointer {
    static Types := [DDHAL_SETEXCLUSIVEMODEDATA.Ptr, UInt32]
}
struct LPDDHAL_FLIPTOGDISURFACE extends FunctionPointer {
    static Types := [DDHAL_FLIPTOGDISURFACEDATA.Ptr, UInt32]
}
struct LPDDHAL_GETDRIVERINFO extends FunctionPointer {
    static Types := [DDHAL_GETDRIVERINFODATA.Ptr, UInt32]
}
struct DDHAL_DDCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroyDriver : LPDDHAL_DESTROYDRIVER
    CreateSurface : LPDDHAL_CREATESURFACE
    SetColorKey : LPDDHAL_SETCOLORKEY
    SetMode : LPDDHAL_SETMODE
    WaitForVerticalBlank : LPDDHAL_WAITFORVERTICALBLANK
    CanCreateSurface : LPDDHAL_CANCREATESURFACE
    CreatePalette : LPDDHAL_CREATEPALETTE
    GetScanLine : LPDDHAL_GETSCANLINE
    SetExclusiveMode : LPDDHAL_SETEXCLUSIVEMODE
    FlipToGDISurface : LPDDHAL_FLIPTOGDISURFACE
}
struct LPDDHALPALCB_DESTROYPALETTE extends FunctionPointer {
    static Types := [DDHAL_DESTROYPALETTEDATA.Ptr, UInt32]
}
struct LPDDHALPALCB_SETENTRIES extends FunctionPointer {
    static Types := [DDHAL_SETENTRIESDATA.Ptr, UInt32]
}
struct DDHAL_DDPALETTECALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroyPalette : LPDDHALPALCB_DESTROYPALETTE
    SetEntries : LPDDHALPALCB_SETENTRIES
}
struct LPDDHALSURFCB_LOCK extends FunctionPointer {
    static Types := [DDHAL_LOCKDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_UNLOCK extends FunctionPointer {
    static Types := [DDHAL_UNLOCKDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_BLT extends FunctionPointer {
    static Types := [DDHAL_BLTDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_UPDATEOVERLAY extends FunctionPointer {
    static Types := [DDHAL_UPDATEOVERLAYDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_SETOVERLAYPOSITION extends FunctionPointer {
    static Types := [DDHAL_SETOVERLAYPOSITIONDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_SETPALETTE extends FunctionPointer {
    static Types := [DDHAL_SETPALETTEDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_FLIP extends FunctionPointer {
    static Types := [DDHAL_FLIPDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_DESTROYSURFACE extends FunctionPointer {
    static Types := [DDHAL_DESTROYSURFACEDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_SETCLIPLIST extends FunctionPointer {
    static Types := [DDHAL_SETCLIPLISTDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_ADDATTACHEDSURFACE extends FunctionPointer {
    static Types := [DDHAL_ADDATTACHEDSURFACEDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_SETCOLORKEY extends FunctionPointer {
    static Types := [DDHAL_SETCOLORKEYDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_GETBLTSTATUS extends FunctionPointer {
    static Types := [DDHAL_GETBLTSTATUSDATA.Ptr, UInt32]
}
struct LPDDHALSURFCB_GETFLIPSTATUS extends FunctionPointer {
    static Types := [DDHAL_GETFLIPSTATUSDATA.Ptr, UInt32]
}
struct DDHAL_DDSURFACECALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroySurface : LPDDHALSURFCB_DESTROYSURFACE
    Flip : LPDDHALSURFCB_FLIP
    SetClipList : LPDDHALSURFCB_SETCLIPLIST
    Lock : LPDDHALSURFCB_LOCK
    Unlock : LPDDHALSURFCB_UNLOCK
    Blt : LPDDHALSURFCB_BLT
    SetColorKey : LPDDHALSURFCB_SETCOLORKEY
    AddAttachedSurface : LPDDHALSURFCB_ADDATTACHEDSURFACE
    GetBltStatus : LPDDHALSURFCB_GETBLTSTATUS
    GetFlipStatus : LPDDHALSURFCB_GETFLIPSTATUS
    UpdateOverlay : LPDDHALSURFCB_UPDATEOVERLAY
    SetOverlayPosition : LPDDHALSURFCB_SETOVERLAYPOSITION
    reserved4 : Struct.Ptr
    SetPalette : LPDDHALSURFCB_SETPALETTE
}
struct LPDDHAL_GETAVAILDRIVERMEMORY extends FunctionPointer {
    static Types := [DDHAL_GETAVAILDRIVERMEMORYDATA.Ptr, UInt32]
}
struct LPDDHAL_UPDATENONLOCALHEAP extends FunctionPointer {
    static Types := [DDHAL_UPDATENONLOCALHEAPDATA.Ptr, UInt32]
}
struct LPDDHAL_GETHEAPALIGNMENT extends FunctionPointer {
    static Types := [DDHAL_GETHEAPALIGNMENTDATA.Ptr, UInt32]
}
struct DDHAL_DDMISCELLANEOUSCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    GetAvailDriverMemory : LPDDHAL_GETAVAILDRIVERMEMORY
    UpdateNonLocalHeap : LPDDHAL_UPDATENONLOCALHEAP
    GetHeapAlignment : LPDDHAL_GETHEAPALIGNMENT
    GetSysmemBltStatus : LPDDHALSURFCB_GETBLTSTATUS
}
struct LPDDHAL_CREATESURFACEEX extends FunctionPointer {
    static Types := [DDHAL_CREATESURFACEEXDATA.Ptr, UInt32]
}
struct LPDDHAL_GETDRIVERSTATE extends FunctionPointer {
    static Types := [DDHAL_GETDRIVERSTATEDATA.Ptr, UInt32]
}
struct LPDDHAL_DESTROYDDLOCAL extends FunctionPointer {
    static Types := [DDHAL_DESTROYDDLOCALDATA.Ptr, UInt32]
}
struct DDHAL_DDMISCELLANEOUS2CALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    Reserved : Struct.Ptr
    CreateSurfaceEx : LPDDHAL_CREATESURFACEEX
    GetDriverState : LPDDHAL_GETDRIVERSTATE
    DestroyDDLocal : LPDDHAL_DESTROYDDLOCAL
}
struct LPDDHALEXEBUFCB_CANCREATEEXEBUF extends FunctionPointer {
    static Types := [DDHAL_CANCREATESURFACEDATA.Ptr, UInt32]
}
struct LPDDHALEXEBUFCB_CREATEEXEBUF extends FunctionPointer {
    static Types := [DDHAL_CREATESURFACEDATA.Ptr, UInt32]
}
struct LPDDHALEXEBUFCB_DESTROYEXEBUF extends FunctionPointer {
    static Types := [DDHAL_DESTROYSURFACEDATA.Ptr, UInt32]
}
struct LPDDHALEXEBUFCB_LOCKEXEBUF extends FunctionPointer {
    static Types := [DDHAL_LOCKDATA.Ptr, UInt32]
}
struct LPDDHALEXEBUFCB_UNLOCKEXEBUF extends FunctionPointer {
    static Types := [DDHAL_UNLOCKDATA.Ptr, UInt32]
}
struct DDHAL_DDEXEBUFCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    CanCreateExecuteBuffer : LPDDHALEXEBUFCB_CANCREATEEXEBUF
    CreateExecuteBuffer : LPDDHALEXEBUFCB_CREATEEXEBUF
    DestroyExecuteBuffer : LPDDHALEXEBUFCB_DESTROYEXEBUF
    LockExecuteBuffer : LPDDHALEXEBUFCB_LOCKEXEBUF
    UnlockExecuteBuffer : LPDDHALEXEBUFCB_UNLOCKEXEBUF
}
struct LPDDHALVPORTCB_CANCREATEVIDEOPORT extends FunctionPointer {
    static Types := [DDHAL_CANCREATEVPORTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_CREATEVIDEOPORT extends FunctionPointer {
    static Types := [DDHAL_CREATEVPORTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_FLIP extends FunctionPointer {
    static Types := [DDHAL_FLIPVPORTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETBANDWIDTH extends FunctionPointer {
    static Types := [DDHAL_GETVPORTBANDWIDTHDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETINPUTFORMATS extends FunctionPointer {
    static Types := [DDHAL_GETVPORTINPUTFORMATDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETOUTPUTFORMATS extends FunctionPointer {
    static Types := [DDHAL_GETVPORTOUTPUTFORMATDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETFIELD extends FunctionPointer {
    static Types := [DDHAL_GETVPORTFIELDDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETLINE extends FunctionPointer {
    static Types := [DDHAL_GETVPORTLINEDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETVPORTCONNECT extends FunctionPointer {
    static Types := [DDHAL_GETVPORTCONNECTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_DESTROYVPORT extends FunctionPointer {
    static Types := [DDHAL_DESTROYVPORTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETFLIPSTATUS extends FunctionPointer {
    static Types := [DDHAL_GETVPORTFLIPSTATUSDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_UPDATE extends FunctionPointer {
    static Types := [DDHAL_UPDATEVPORTDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_WAITFORSYNC extends FunctionPointer {
    static Types := [DDHAL_WAITFORVPORTSYNCDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_GETSIGNALSTATUS extends FunctionPointer {
    static Types := [DDHAL_GETVPORTSIGNALDATA.Ptr, UInt32]
}
struct LPDDHALVPORTCB_COLORCONTROL extends FunctionPointer {
    static Types := [DDHAL_VPORTCOLORDATA.Ptr, UInt32]
}
struct DDHAL_DDVIDEOPORTCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    CanCreateVideoPort : LPDDHALVPORTCB_CANCREATEVIDEOPORT
    CreateVideoPort : LPDDHALVPORTCB_CREATEVIDEOPORT
    FlipVideoPort : LPDDHALVPORTCB_FLIP
    GetVideoPortBandwidth : LPDDHALVPORTCB_GETBANDWIDTH
    GetVideoPortInputFormats : LPDDHALVPORTCB_GETINPUTFORMATS
    GetVideoPortOutputFormats : LPDDHALVPORTCB_GETOUTPUTFORMATS
    lpReserved1 : Struct.Ptr
    GetVideoPortField : LPDDHALVPORTCB_GETFIELD
    GetVideoPortLine : LPDDHALVPORTCB_GETLINE
    GetVideoPortConnectInfo : LPDDHALVPORTCB_GETVPORTCONNECT
    DestroyVideoPort : LPDDHALVPORTCB_DESTROYVPORT
    GetVideoPortFlipStatus : LPDDHALVPORTCB_GETFLIPSTATUS
    UpdateVideoPort : LPDDHALVPORTCB_UPDATE
    WaitForVideoPortSync : LPDDHALVPORTCB_WAITFORSYNC
    GetVideoSignalStatus : LPDDHALVPORTCB_GETSIGNALSTATUS
    ColorControl : LPDDHALVPORTCB_COLORCONTROL
}
struct LPDDHALCOLORCB_COLORCONTROL extends FunctionPointer {
    static Types := [DDHAL_COLORCONTROLDATA.Ptr, UInt32]
}
struct DDHAL_DDCOLORCONTROLCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    ColorControl : LPDDHALCOLORCB_COLORCONTROL
}
struct LPDDHALKERNELCB_SYNCSURFACE extends FunctionPointer {
    static Types := [DDHAL_SYNCSURFACEDATA.Ptr, UInt32]
}
struct LPDDHALKERNELCB_SYNCVIDEOPORT extends FunctionPointer {
    static Types := [DDHAL_SYNCVIDEOPORTDATA.Ptr, UInt32]
}
struct DDHAL_DDKERNELCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    SyncSurfaceData : LPDDHALKERNELCB_SYNCSURFACE
    SyncVideoPortData : LPDDHALKERNELCB_SYNCVIDEOPORT
}
struct LPDDGAMMACALIBRATORPROC extends FunctionPointer {
    static Types := [DDGAMMARAMP.Ptr, UInt8.Ptr, HRESULT]
}
struct LPDDHALMOCOMPCB_GETGUIDS extends FunctionPointer {
    static Types := [DDHAL_GETMOCOMPGUIDSDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_GETFORMATS extends FunctionPointer {
    static Types := [DDHAL_GETMOCOMPFORMATSDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_CREATE extends FunctionPointer {
    static Types := [DDHAL_CREATEMOCOMPDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_GETCOMPBUFFINFO extends FunctionPointer {
    static Types := [DDHAL_GETMOCOMPCOMPBUFFDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_GETINTERNALINFO extends FunctionPointer {
    static Types := [DDHAL_GETINTERNALMOCOMPDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_BEGINFRAME extends FunctionPointer {
    static Types := [DDHAL_BEGINMOCOMPFRAMEDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_ENDFRAME extends FunctionPointer {
    static Types := [DDHAL_ENDMOCOMPFRAMEDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_RENDER extends FunctionPointer {
    static Types := [DDHAL_RENDERMOCOMPDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_QUERYSTATUS extends FunctionPointer {
    static Types := [DDHAL_QUERYMOCOMPSTATUSDATA.Ptr, UInt32]
}
struct LPDDHALMOCOMPCB_DESTROY extends FunctionPointer {
    static Types := [DDHAL_DESTROYMOCOMPDATA.Ptr, UInt32]
}
struct DDHAL_DDMOTIONCOMPCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    GetMoCompGuids : LPDDHALMOCOMPCB_GETGUIDS
    GetMoCompFormats : LPDDHALMOCOMPCB_GETFORMATS
    CreateMoComp : LPDDHALMOCOMPCB_CREATE
    GetMoCompBuffInfo : LPDDHALMOCOMPCB_GETCOMPBUFFINFO
    GetInternalMoCompInfo : LPDDHALMOCOMPCB_GETINTERNALINFO
    BeginMoCompFrame : LPDDHALMOCOMPCB_BEGINFRAME
    EndMoCompFrame : LPDDHALMOCOMPCB_ENDFRAME
    RenderMoComp : LPDDHALMOCOMPCB_RENDER
    QueryMoCompStatus : LPDDHALMOCOMPCB_QUERYSTATUS
    DestroyMoComp : LPDDHALMOCOMPCB_DESTROY
}
struct DDNONLOCALVIDMEMCAPS {
    dwSize : UInt32
    dwNLVBCaps : UInt32
    dwNLVBCaps2 : UInt32
    dwNLVBCKeyCaps : UInt32
    dwNLVBFXCaps : UInt32
    dwNLVBRops : UInt32[8]
}
struct DDMORESURFACECAPS {
    dwSize : UInt32
    ddsCapsMore : DDSCAPSEX
    ddsExtendedHeapRestrictions : this.ExtendedHeapRestrictions[1]
    struct ExtendedHeapRestrictions {
        ddsCapsEx : DDSCAPSEX
        ddsCapsExAlt : DDSCAPSEX
    }
}
struct DDSTEREOMODE {
    dwSize : UInt32
    dwHeight : UInt32
    dwWidth : UInt32
    dwBpp : UInt32
    dwRefreshRate : UInt32
    bSupported : BOOL
}
struct DDRAWI_DDRAWPALETTE_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DDRAWPALETTE_LCL.Ptr
    lpLink : DDRAWI_DDRAWPALETTE_INT.Ptr
    dwIntRefCnt : UInt32
}
struct DDRAWI_DDRAWPALETTE_GBL {
    dwRefCnt : UInt32
    dwFlags : UInt32
    lpDD_lcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwProcessId : UInt32
    lpColorTable : PALETTEENTRY.Ptr
    Anonymous : this._Anonymous_e__Union
    dwDriverReserved : UInt32
    dwContentsStamp : UInt32
    dwSaveStamp : UInt32
    dwHandle : UInt32
    struct _Anonymous_e__Union {
        union {
            dwReserved1 : IntPtr
            hHELGDIPalette : HPALETTE
        }
    }
}
struct DDRAWI_DDRAWPALETTE_LCL {
    lpPalMore : UInt32
    lpGbl : DDRAWI_DDRAWPALETTE_GBL.Ptr
    dwUnused0 : IntPtr
    dwLocalRefCnt : UInt32
    pUnkOuter : IUnknown
    lpDD_lcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwReserved1 : IntPtr
    dwDDRAWReserved1 : IntPtr
    dwDDRAWReserved2 : IntPtr
    dwDDRAWReserved3 : IntPtr
}
struct DDRAWI_DDRAWCLIPPER_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DDRAWCLIPPER_LCL.Ptr
    lpLink : DDRAWI_DDRAWCLIPPER_INT.Ptr
    dwIntRefCnt : UInt32
}
struct DDRAWI_DDRAWCLIPPER_GBL {
    dwRefCnt : UInt32
    dwFlags : UInt32
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwProcessId : UInt32
    dwReserved1 : IntPtr
    hWnd : IntPtr
    lpStaticClipList : RGNDATA.Ptr
}
struct DDRAWI_DDRAWCLIPPER_LCL {
    lpClipMore : UInt32
    lpGbl : DDRAWI_DDRAWCLIPPER_GBL.Ptr
    lpDD_lcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwLocalRefCnt : UInt32
    pUnkOuter : IUnknown
    lpDD_int : DDRAWI_DIRECTDRAW_INT.Ptr
    dwReserved1 : IntPtr
    pAddrefedThisOwner : IUnknown
}
struct ATTACHLIST {
    dwFlags : UInt32
    lpLink : ATTACHLIST.Ptr
    lpAttached : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpIAttached : DDRAWI_DDRAWSURFACE_INT.Ptr
}
struct DBLNODE {
    next : DBLNODE.Ptr
    prev : DBLNODE.Ptr
    object : DDRAWI_DDRAWSURFACE_LCL.Ptr
    object_int : DDRAWI_DDRAWSURFACE_INT.Ptr
}
struct ACCESSRECTLIST {
    lpLink : ACCESSRECTLIST.Ptr
    rDest : RECT
    lpOwner : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpSurfaceData : Struct.Ptr
    dwFlags : UInt32
    lpHeapAliasInfo : HEAPALIASINFO.Ptr
}
struct DDRAWI_DDRAWSURFACE_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpLink : DDRAWI_DDRAWSURFACE_INT.Ptr
    dwIntRefCnt : UInt32
}
struct DDRAWI_DDRAWSURFACE_GBL {
    dwRefCnt : UInt32
    dwGlobalFlags : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    fpVidMem : IntPtr
    Anonymous4 : this._Anonymous4_e__Union
    wHeight : UInt16
    wWidth : UInt16
    dwUsageCount : UInt32
    dwReserved1 : IntPtr
    ddpfSurface : DDPIXELFORMAT
    struct _Anonymous1_e__Union {
        union {
            lpRectList : ACCESSRECTLIST.Ptr
            dwBlockSizeY : UInt32
            lSlicePitch : Int32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            lpVidMemHeap : VMEMHEAP.Ptr
            dwBlockSizeX : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
            lpDDHandle : Struct.Ptr
        }
    }
    struct _Anonymous4_e__Union {
        union {
            lPitch : Int32
            dwLinearSize : UInt32
        }
    }
}
struct DDRAWI_DDRAWSURFACE_GBL_MORE {
    dwSize : UInt32
    Anonymous : this._Anonymous_e__Union
    pPageTable : UInt32.Ptr
    cPages : UInt32
    dwSavedDCContext : IntPtr
    fpAliasedVidMem : IntPtr
    dwDriverReserved : IntPtr
    dwHELReserved : IntPtr
    cPageUnlocks : UInt32
    hKernelSurface : IntPtr
    dwKernelRefCnt : UInt32
    lpColorInfo : DDCOLORCONTROL.Ptr
    fpNTAlias : IntPtr
    dwContentsStamp : UInt32
    lpvUnswappedDriverReserved : Struct.Ptr
    lpDDRAWReserved2 : Struct.Ptr
    dwDDRAWReserved1 : UInt32
    dwDDRAWReserved2 : UInt32
    fpAliasOfVidMem : IntPtr
    struct _Anonymous_e__Union {
        union {
            dwPhysicalPageTable : UInt32
            fpPhysicalVidMem : IntPtr
        }
    }
}
struct DDRAWI_DDRAWSURFACE_MORE {
    dwSize : UInt32
    lpIUnknowns : IUNKNOWN_LIST.Ptr
    lpDD_lcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwPageLockCount : UInt32
    dwBytesAllocated : UInt32
    lpDD_int : DDRAWI_DIRECTDRAW_INT.Ptr
    dwMipMapCount : UInt32
    lpDDIClipper : DDRAWI_DDRAWCLIPPER_INT.Ptr
    lpHeapAliasInfo : HEAPALIASINFO.Ptr
    dwOverlayFlags : UInt32
    rgjunc : Struct.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    lpddOverlayFX : DDOVERLAYFX.Ptr
    ddsCapsEx : DDSCAPSEX
    dwTextureStage : UInt32
    lpDDRAWReserved : Struct.Ptr
    lpDDRAWReserved2 : Struct.Ptr
    lpDDrawReserved3 : Struct.Ptr
    dwDDrawReserved4 : UInt32
    lpDDrawReserved5 : Struct.Ptr
    lpGammaRamp : UInt32.Ptr
    lpOriginalGammaRamp : UInt32.Ptr
    lpDDrawReserved6 : Struct.Ptr
    dwSurfaceHandle : UInt32
    qwDDrawReserved8 : UInt32[2]
    lpDDrawReserved9 : Struct.Ptr
    cSurfaces : UInt32
    pCreatedDDSurfaceDesc2 : DDSURFACEDESC2.Ptr
    slist : DDRAWI_DDRAWSURFACE_LCL.Ptr.Ptr
    dwFVF : UInt32
    lpVB : Struct.Ptr
}
struct DDRAWI_DDRAWSURFACE_LCL {
    lpSurfMore : DDRAWI_DDRAWSURFACE_MORE.Ptr
    lpGbl : DDRAWI_DDRAWSURFACE_GBL.Ptr
    hDDSurface : IntPtr
    lpAttachList : ATTACHLIST.Ptr
    lpAttachListFrom : ATTACHLIST.Ptr
    dwLocalRefCnt : UInt32
    dwProcessId : UInt32
    dwFlags : UInt32
    ddsCaps : DDSCAPS
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    dwModeCreatedIn : UInt32
    dwBackBufferCount : UInt32
    ddckCKDestBlt : DDCOLORKEY
    ddckCKSrcBlt : DDCOLORKEY
    hDC : IntPtr
    dwReserved1 : IntPtr
    ddckCKSrcOverlay : DDCOLORKEY
    ddckCKDestOverlay : DDCOLORKEY
    lpSurfaceOverlaying : DDRAWI_DDRAWSURFACE_INT.Ptr
    dbnOverlayNode : DBLNODE
    rcOverlaySrc : RECT
    rcOverlayDest : RECT
    dwClrXparent : UInt32
    dwAlpha : UInt32
    lOverlayX : Int32
    lOverlayY : Int32
    struct _Anonymous1_e__Union {
        union {
            lpDDPalette : DDRAWI_DDRAWPALETTE_INT.Ptr
            lp16DDPalette : DDRAWI_DDRAWPALETTE_INT.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            lpDDClipper : DDRAWI_DDRAWCLIPPER_LCL.Ptr
            lp16DDClipper : DDRAWI_DDRAWCLIPPER_INT.Ptr
        }
    }
}
struct DDHALMODEINFO {
    dwWidth : UInt32
    dwHeight : UInt32
    lPitch : Int32
    dwBPP : UInt32
    wFlags : UInt16
    wRefreshRate : UInt16
    dwRBitMask : UInt32
    dwGBitMask : UInt32
    dwBBitMask : UInt32
    dwAlphaBitMask : UInt32
}
struct DDRAWI_DIRECTDRAW_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpLink : DDRAWI_DIRECTDRAW_INT.Ptr
    dwIntRefCnt : UInt32
}
struct DDHAL_CALLBACKS {
    cbDDCallbacks : DDHAL_DDCALLBACKS
    cbDDSurfaceCallbacks : DDHAL_DDSURFACECALLBACKS
    cbDDPaletteCallbacks : DDHAL_DDPALETTECALLBACKS
    HALDD : DDHAL_DDCALLBACKS
    HALDDSurface : DDHAL_DDSURFACECALLBACKS
    HALDDPalette : DDHAL_DDPALETTECALLBACKS
    HELDD : DDHAL_DDCALLBACKS
    HELDDSurface : DDHAL_DDSURFACECALLBACKS
    HELDDPalette : DDHAL_DDPALETTECALLBACKS
    cbDDExeBufCallbacks : DDHAL_DDEXEBUFCALLBACKS
    HALDDExeBuf : DDHAL_DDEXEBUFCALLBACKS
    HELDDExeBuf : DDHAL_DDEXEBUFCALLBACKS
    cbDDVideoPortCallbacks : DDHAL_DDVIDEOPORTCALLBACKS
    HALDDVideoPort : DDHAL_DDVIDEOPORTCALLBACKS
    cbDDColorControlCallbacks : DDHAL_DDCOLORCONTROLCALLBACKS
    HALDDColorControl : DDHAL_DDCOLORCONTROLCALLBACKS
    cbDDMiscellaneousCallbacks : DDHAL_DDMISCELLANEOUSCALLBACKS
    HALDDMiscellaneous : DDHAL_DDMISCELLANEOUSCALLBACKS
    cbDDKernelCallbacks : DDHAL_DDKERNELCALLBACKS
    HALDDKernel : DDHAL_DDKERNELCALLBACKS
    cbDDMotionCompCallbacks : DDHAL_DDMOTIONCOMPCALLBACKS
    HALDDMotionComp : DDHAL_DDMOTIONCOMPCALLBACKS
}
struct DDCORECAPS {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwMaxVideoPorts : UInt32
    dwCurrVideoPorts : UInt32
    dwSVBCaps2 : UInt32
}
struct DDRAWI_DIRECTDRAW_GBL {
    dwRefCnt : UInt32
    dwFlags : UInt32
    fpPrimaryOrig : IntPtr
    ddCaps : DDCORECAPS
    dwInternal1 : UInt32
    dwUnused1 : UInt32[9]
    lpDDCBtmp : DDHAL_CALLBACKS.Ptr
    dsList : DDRAWI_DDRAWSURFACE_INT.Ptr
    palList : DDRAWI_DDRAWPALETTE_INT.Ptr
    clipperList : DDRAWI_DDRAWCLIPPER_INT.Ptr
    lp16DD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwMaxOverlays : UInt32
    dwCurrOverlays : UInt32
    dwMonitorFrequency : UInt32
    ddHELCaps : DDCORECAPS
    dwUnused2 : UInt32[50]
    ddckCKDestOverlay : DDCOLORKEY
    ddckCKSrcOverlay : DDCOLORKEY
    vmiData : VIDMEMINFO
    lpDriverHandle : Struct.Ptr
    lpExclusiveOwner : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwModeIndex : UInt32
    dwModeIndexOrig : UInt32
    dwNumFourCC : UInt32
    lpdwFourCC : UInt32.Ptr
    dwNumModes : UInt32
    lpModeInfo : DDHALMODEINFO.Ptr
    plProcessList : PROCESS_LIST
    dwSurfaceLockCount : UInt32
    dwAliasedLockCnt : UInt32
    dwReserved3 : IntPtr
    hDD : IntPtr
    cObsolete : CHAR[12]
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dbnOverlayRoot : DBLNODE
    lpwPDeviceFlags : UInt16.Ptr
    dwPDevice : UInt32
    dwWin16LockCnt : UInt32
    dwUnused3 : UInt32
    hInstance : UInt32
    dwEvent16 : UInt32
    dwSaveNumModes : UInt32
    lpD3DGlobalDriverData : IntPtr
    lpD3DHALCallbacks : IntPtr
    ddBothCaps : DDCORECAPS
    lpDDVideoPortCaps : DDVIDEOPORTCAPS.Ptr
    dvpList : DDRAWI_DDVIDEOPORT_INT.Ptr
    lpD3DHALCallbacks2 : IntPtr
    rectDevice : RECT
    cMonitors : UInt32
    gpbmiSrc : Struct.Ptr
    gpbmiDest : Struct.Ptr
    phaiHeapAliases : HEAPALIASINFO.Ptr
    hKernelHandle : IntPtr
    pfnNotifyProc : IntPtr
    lpDDKernelCaps : DDKERNELCAPS.Ptr
    lpddNLVCaps : DDNONLOCALVIDMEMCAPS.Ptr
    lpddNLVHELCaps : DDNONLOCALVIDMEMCAPS.Ptr
    lpddNLVBothCaps : DDNONLOCALVIDMEMCAPS.Ptr
    lpD3DExtendedCaps : IntPtr
    dwDOSBoxEvent : UInt32
    rectDesktop : RECT
    cDriverName : CHAR[32]
    lpD3DHALCallbacks3 : IntPtr
    dwNumZPixelFormats : UInt32
    lpZPixelFormats : DDPIXELFORMAT.Ptr
    mcList : DDRAWI_DDMOTIONCOMP_INT.Ptr
    hDDVxd : UInt32
    ddsCapsMore : DDSCAPSEX
}
struct DDRAWI_DIRECTDRAW_LCL {
    lpDDMore : UInt32
    lpGbl : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwUnused0 : UInt32
    dwLocalFlags : UInt32
    dwLocalRefCnt : UInt32
    dwProcessId : UInt32
    pUnkOuter : IUnknown
    dwObsolete1 : UInt32
    hWnd : IntPtr
    hDC : IntPtr
    dwErrorMode : UInt32
    lpPrimary : DDRAWI_DDRAWSURFACE_INT.Ptr
    lpCB : DDRAWI_DDRAWSURFACE_INT.Ptr
    dwPreferredMode : UInt32
    hD3DInstance : HINSTANCE
    pD3DIUnknown : IUnknown
    lpDDCB : DDHAL_CALLBACKS.Ptr
    hDDVxd : IntPtr
    dwAppHackFlags : UInt32
    hFocusWnd : IntPtr
    dwHotTracking : UInt32
    dwIMEState : UInt32
    hWndPopup : IntPtr
    hDD : IntPtr
    hGammaCalibrator : IntPtr
    lpGammaCalibrator : LPDDGAMMACALIBRATORPROC
}
struct DDRAWI_DDVIDEOPORT_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DDVIDEOPORT_LCL.Ptr
    lpLink : DDRAWI_DDVIDEOPORT_INT.Ptr
    dwIntRefCnt : UInt32
    dwFlags : UInt32
}
struct DDRAWI_DDVIDEOPORT_LCL {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    ddvpDesc : DDVIDEOPORTDESC
    ddvpInfo : DDVIDEOPORTINFO
    lpSurface : DDRAWI_DDRAWSURFACE_INT.Ptr
    lpVBISurface : DDRAWI_DDRAWSURFACE_INT.Ptr
    lpFlipInts : DDRAWI_DDRAWSURFACE_INT.Ptr.Ptr
    dwNumAutoflip : UInt32
    dwProcessID : UInt32
    dwStateFlags : UInt32
    dwFlags : UInt32
    dwRefCnt : UInt32
    fpLastFlip : IntPtr
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
    hDDVideoPort : HANDLE
    dwNumVBIAutoflip : UInt32
    lpVBIDesc : DDVIDEOPORTDESC.Ptr
    lpVideoDesc : DDVIDEOPORTDESC.Ptr
    lpVBIInfo : DDVIDEOPORTINFO.Ptr
    lpVideoInfo : DDVIDEOPORTINFO.Ptr
    dwVBIProcessID : UInt32
    lpVPNotify : DDRAWI_DDVIDEOPORT_INT.Ptr
}
struct DDRAWI_DDMOTIONCOMP_INT {
    lpVtbl : Struct.Ptr
    lpLcl : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    lpLink : DDRAWI_DDMOTIONCOMP_INT.Ptr
    dwIntRefCnt : UInt32
}
struct DDRAWI_DDMOTIONCOMP_LCL {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    guid : GUID
    dwUncompWidth : UInt32
    dwUncompHeight : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
    dwInternalFlags : UInt32
    dwRefCnt : UInt32
    dwProcessId : UInt32
    hMoComp : HANDLE
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
    lpDriverReserved1 : Struct.Ptr
    lpDriverReserved2 : Struct.Ptr
    lpDriverReserved3 : Struct.Ptr
}
struct DDHALINFO {
    dwSize : UInt32
    lpDDCallbacks : DDHAL_DDCALLBACKS.Ptr
    lpDDSurfaceCallbacks : DDHAL_DDSURFACECALLBACKS.Ptr
    lpDDPaletteCallbacks : DDHAL_DDPALETTECALLBACKS.Ptr
    vmiData : VIDMEMINFO
    ddCaps : DDCORECAPS
    dwMonitorFrequency : UInt32
    GetDriverInfo : LPDDHAL_GETDRIVERINFO
    dwModeIndex : UInt32
    lpdwFourCC : UInt32.Ptr
    dwNumModes : UInt32
    lpModeInfo : DDHALMODEINFO.Ptr
    dwFlags : UInt32
    lpPDevice : Struct.Ptr
    hInstance : UInt32
    lpD3DGlobalDriverData : IntPtr
    lpD3DHALCallbacks : IntPtr
    lpDDExeBufCallbacks : DDHAL_DDEXEBUFCALLBACKS.Ptr
}
struct LPDDHAL_SETINFO extends FunctionPointer {
    static Types := [DDHALINFO.Ptr, BOOL, BOOL]
}
struct LPDDHAL_VIDMEMALLOC extends FunctionPointer {
    static Types := [DDRAWI_DIRECTDRAW_GBL.Ptr, Int32, UInt32, UInt32, IntPtr]
}
struct LPDDHAL_VIDMEMFREE extends FunctionPointer {
    static Types := [DDRAWI_DIRECTDRAW_GBL.Ptr, Int32, IntPtr, "Void"]
}
struct DDHALDDRAWFNS {
    dwSize : UInt32
    lpSetInfo : LPDDHAL_SETINFO
    lpVidMemAlloc : LPDDHAL_VIDMEMALLOC
    lpVidMemFree : LPDDHAL_VIDMEMFREE
}
struct DDHAL_BLTDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDDestSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    rDest : RECTL
    lpDDSrcSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    rSrc : RECTL
    dwFlags : UInt32
    dwROPFlags : UInt32
    bltFX : DDBLTFX
    ddRVal : HRESULT
    Blt : LPDDHALSURFCB_BLT
    IsClipped : BOOL
    rOrigDest : RECTL
    rOrigSrc : RECTL
    dwRectCnt : UInt32
    prDestRects : RECT.Ptr
}
struct DDHAL_LOCKDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    bHasRect : UInt32
    rArea : RECTL
    lpSurfData : Struct.Ptr
    ddRVal : HRESULT
    Lock : LPDDHALSURFCB_LOCK
    dwFlags : UInt32
}
struct DDHAL_UNLOCKDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
    Unlock : LPDDHALSURFCB_UNLOCK
}
struct DDHAL_UPDATEOVERLAYDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDDestSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    rDest : RECTL
    lpDDSrcSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    rSrc : RECTL
    dwFlags : UInt32
    overlayFX : DDOVERLAYFX
    ddRVal : HRESULT
    UpdateOverlay : LPDDHALSURFCB_UPDATEOVERLAY
}
struct DDHAL_SETOVERLAYPOSITIONDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSrcSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpDDDestSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lXPos : Int32
    lYPos : Int32
    ddRVal : HRESULT
    SetOverlayPosition : LPDDHALSURFCB_SETOVERLAYPOSITION
}
struct DDHAL_SETPALETTEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpDDPalette : DDRAWI_DDRAWPALETTE_GBL.Ptr
    ddRVal : HRESULT
    SetPalette : LPDDHALSURFCB_SETPALETTE
    Attach : BOOL
}
struct DDHAL_FLIPDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpSurfCurr : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpSurfTarg : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    Flip : LPDDHALSURFCB_FLIP
    lpSurfCurrLeft : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpSurfTargLeft : DDRAWI_DDRAWSURFACE_LCL.Ptr
}
struct DDHAL_DESTROYSURFACEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
    DestroySurface : LPDDHALSURFCB_DESTROYSURFACE
}
struct DDHAL_SETCLIPLISTDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
    SetClipList : LPDDHALSURFCB_SETCLIPLIST
}
struct DDHAL_ADDATTACHEDSURFACEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpSurfAttached : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
    AddAttachedSurface : LPDDHALSURFCB_ADDATTACHEDSURFACE
}
struct DDHAL_SETCOLORKEYDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ckNew : DDCOLORKEY
    ddRVal : HRESULT
    SetColorKey : LPDDHALSURFCB_SETCOLORKEY
}
struct DDHAL_GETBLTSTATUSDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    GetBltStatus : LPDDHALSURFCB_GETBLTSTATUS
}
struct DDHAL_GETFLIPSTATUSDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    GetFlipStatus : LPDDHALSURFCB_GETFLIPSTATUS
}
struct DDHAL_DESTROYPALETTEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDPalette : DDRAWI_DDRAWPALETTE_GBL.Ptr
    ddRVal : HRESULT
    DestroyPalette : LPDDHALPALCB_DESTROYPALETTE
}
struct DDHAL_SETENTRIESDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDPalette : DDRAWI_DDRAWPALETTE_GBL.Ptr
    dwBase : UInt32
    dwNumEntries : UInt32
    lpEntries : PALETTEENTRY.Ptr
    ddRVal : HRESULT
    SetEntries : LPDDHALPALCB_SETENTRIES
}
struct DDHAL_CREATESURFACEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurfaceDesc : DDSURFACEDESC.Ptr
    lplpSList : DDRAWI_DDRAWSURFACE_LCL.Ptr.Ptr
    dwSCnt : UInt32
    ddRVal : HRESULT
    CreateSurface : LPDDHAL_CREATESURFACE
}
struct DDHAL_CANCREATESURFACEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurfaceDesc : DDSURFACEDESC.Ptr
    bIsDifferentPixelFormat : UInt32
    ddRVal : HRESULT
    CanCreateSurface : LPDDHAL_CANCREATESURFACE
}
struct DDHAL_CREATEPALETTEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDPalette : DDRAWI_DDRAWPALETTE_GBL.Ptr
    lpColorTable : PALETTEENTRY.Ptr
    ddRVal : HRESULT
    CreatePalette : LPDDHAL_CREATEPALETTE
    is_excl : BOOL
}
struct DDHAL_WAITFORVERTICALBLANKDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwFlags : UInt32
    bIsInVB : UInt32
    hEvent : IntPtr
    ddRVal : HRESULT
    WaitForVerticalBlank : LPDDHAL_WAITFORVERTICALBLANK
}
struct DDHAL_DESTROYDRIVERDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    ddRVal : HRESULT
    DestroyDriver : LPDDHAL_DESTROYDRIVER
}
struct DDHAL_SETMODEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwModeIndex : UInt32
    ddRVal : HRESULT
    SetMode : LPDDHAL_SETMODE
    inexcl : BOOL
    useRefreshRate : BOOL
}
struct DDHAL_DRVSETCOLORKEYDATA {
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ckNew : DDCOLORKEY
    ddRVal : HRESULT
    SetColorKey : LPDDHAL_SETCOLORKEY
}
struct DDHAL_GETSCANLINEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwScanLine : UInt32
    ddRVal : HRESULT
    GetScanLine : LPDDHAL_GETSCANLINE
}
struct DDHAL_SETEXCLUSIVEMODEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwEnterExcl : UInt32
    dwReserved : UInt32
    ddRVal : HRESULT
    SetExclusiveMode : LPDDHAL_SETEXCLUSIVEMODE
}
struct DDHAL_FLIPTOGDISURFACEDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwToGDI : UInt32
    dwReserved : UInt32
    ddRVal : HRESULT
    FlipToGDISurface : LPDDHAL_FLIPTOGDISURFACE
}
struct DDHAL_CANCREATEVPORTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpDDVideoPortDesc : DDVIDEOPORTDESC.Ptr
    ddRVal : HRESULT
    CanCreateVideoPort : LPDDHALVPORTCB_CANCREATEVIDEOPORT
}
struct DDHAL_CREATEVPORTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpDDVideoPortDesc : DDVIDEOPORTDESC.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    ddRVal : HRESULT
    CreateVideoPort : LPDDHALVPORTCB_CREATEVIDEOPORT
}
struct DDHAL_FLIPVPORTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    lpSurfCurr : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpSurfTarg : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
    FlipVideoPort : LPDDHALVPORTCB_FLIP
}
struct DDHAL_GETVPORTBANDWIDTHDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    lpddpfFormat : DDPIXELFORMAT.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    dwFlags : UInt32
    lpBandwidth : DDVIDEOPORTBANDWIDTH.Ptr
    ddRVal : HRESULT
    GetVideoPortBandwidth : LPDDHALVPORTCB_GETBANDWIDTH
}
struct DDHAL_GETVPORTINPUTFORMATDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwFlags : UInt32
    lpddpfFormat : DDPIXELFORMAT.Ptr
    dwNumFormats : UInt32
    ddRVal : HRESULT
    GetVideoPortInputFormats : LPDDHALVPORTCB_GETINPUTFORMATS
}
struct DDHAL_GETVPORTOUTPUTFORMATDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwFlags : UInt32
    lpddpfInputFormat : DDPIXELFORMAT.Ptr
    lpddpfOutputFormats : DDPIXELFORMAT.Ptr
    dwNumFormats : UInt32
    ddRVal : HRESULT
    GetVideoPortOutputFormats : LPDDHALVPORTCB_GETOUTPUTFORMATS
}
struct DDHAL_GETVPORTFIELDDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    bField : BOOL
    ddRVal : HRESULT
    GetVideoPortField : LPDDHALVPORTCB_GETFIELD
}
struct DDHAL_GETVPORTLINEDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwLine : UInt32
    ddRVal : HRESULT
    GetVideoPortLine : LPDDHALVPORTCB_GETLINE
}
struct DDHAL_GETVPORTCONNECTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwPortId : UInt32
    lpConnect : DDVIDEOPORTCONNECT.Ptr
    dwNumEntries : UInt32
    ddRVal : HRESULT
    GetVideoPortConnectInfo : LPDDHALVPORTCB_GETVPORTCONNECT
}
struct DDHAL_DESTROYVPORTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    ddRVal : HRESULT
    DestroyVideoPort : LPDDHALVPORTCB_DESTROYVPORT
}
struct DDHAL_GETVPORTFLIPSTATUSDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    fpSurface : IntPtr
    ddRVal : HRESULT
    GetVideoPortFlipStatus : LPDDHALVPORTCB_GETFLIPSTATUS
}
struct DDHAL_UPDATEVPORTDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    lplpDDSurface : DDRAWI_DDRAWSURFACE_INT.Ptr.Ptr
    lplpDDVBISurface : DDRAWI_DDRAWSURFACE_INT.Ptr.Ptr
    lpVideoInfo : DDVIDEOPORTINFO.Ptr
    dwFlags : UInt32
    dwNumAutoflip : UInt32
    dwNumVBIAutoflip : UInt32
    ddRVal : HRESULT
    UpdateVideoPort : LPDDHALVPORTCB_UPDATE
}
struct DDHAL_WAITFORVPORTSYNCDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwFlags : UInt32
    dwLine : UInt32
    dwTimeOut : UInt32
    ddRVal : HRESULT
    WaitForVideoPortSync : LPDDHALVPORTCB_WAITFORSYNC
}
struct DDHAL_GETVPORTSIGNALDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwStatus : UInt32
    ddRVal : HRESULT
    GetVideoSignalStatus : LPDDHALVPORTCB_GETSIGNALSTATUS
}
struct DDHAL_VPORTCOLORDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwFlags : UInt32
    lpColorData : DDCOLORCONTROL.Ptr
    ddRVal : HRESULT
    ColorControl : LPDDHALVPORTCB_COLORCONTROL
}
struct DDHAL_COLORCONTROLDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    lpColorData : DDCOLORCONTROL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    ColorControl : LPDDHALCOLORCB_COLORCONTROL
}
struct DDHAL_GETDRIVERINFODATA {
    dwSize : UInt32
    dwFlags : UInt32
    guidInfo : GUID
    dwExpectedSize : UInt32
    lpvData : Struct.Ptr
    dwActualSize : UInt32
    ddRVal : HRESULT
    dwContext : IntPtr
}
struct DDHAL_GETAVAILDRIVERMEMORYDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    DDSCaps : DDSCAPS
    dwTotal : UInt32
    dwFree : UInt32
    ddRVal : HRESULT
    GetAvailDriverMemory : LPDDHAL_GETAVAILDRIVERMEMORY
    ddsCapsEx : DDSCAPSEX
}
struct DDHAL_UPDATENONLOCALHEAPDATA {
    lpDD : DDRAWI_DIRECTDRAW_GBL.Ptr
    dwHeap : UInt32
    fpGARTLin : IntPtr
    fpGARTDev : IntPtr
    ulPolicyMaxBytes : IntPtr
    ddRVal : HRESULT
    UpdateNonLocalHeap : LPDDHAL_UPDATENONLOCALHEAP
}
struct DDHAL_GETHEAPALIGNMENTDATA {
    dwInstance : IntPtr
    dwHeap : UInt32
    ddRVal : HRESULT
    GetHeapAlignment : LPDDHAL_GETHEAPALIGNMENT
    Alignment : HEAPALIGNMENT
}
struct DDHAL_CREATESURFACEEXDATA {
    dwFlags : UInt32
    lpDDLcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpDDSLcl : DDRAWI_DDRAWSURFACE_LCL.Ptr
    ddRVal : HRESULT
}
struct DDHAL_GETDRIVERSTATEDATA {
    dwFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    lpdwStates : UInt32.Ptr
    dwLength : UInt32
    ddRVal : HRESULT
    struct _Anonymous_e__Union {
        union {
            dwhContext : IntPtr
        }
    }
}
struct DDHAL_DESTROYDDLOCALDATA {
    dwFlags : UInt32
    pDDLcl : DDRAWI_DIRECTDRAW_LCL.Ptr
    ddRVal : HRESULT
}
struct DDHAL_SYNCSURFACEDATA {
    dwSize : UInt32
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpDDSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwSurfaceOffset : UInt32
    fpLockPtr : IntPtr
    lPitch : Int32
    dwOverlayOffset : UInt32
    dwOverlaySrcWidth : UInt32
    dwOverlaySrcHeight : UInt32
    dwOverlayDestWidth : UInt32
    dwOverlayDestHeight : UInt32
    dwDriverReserved1 : IntPtr
    dwDriverReserved2 : IntPtr
    dwDriverReserved3 : IntPtr
    ddRVal : HRESULT
}
struct DDHAL_SYNCVIDEOPORTDATA {
    dwSize : UInt32
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpVideoPort : DDRAWI_DDVIDEOPORT_LCL.Ptr
    dwOriginOffset : UInt32
    dwHeight : UInt32
    dwVBIHeight : UInt32
    dwDriverReserved1 : IntPtr
    dwDriverReserved2 : IntPtr
    dwDriverReserved3 : IntPtr
    ddRVal : HRESULT
}
struct DDHAL_GETMOCOMPGUIDSDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    dwNumGuids : UInt32
    lpGuids : GUID.Ptr
    ddRVal : HRESULT
    GetMoCompGuids : LPDDHALMOCOMPCB_GETGUIDS
}
struct DDHAL_GETMOCOMPFORMATSDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpGuid : GUID.Ptr
    dwNumFormats : UInt32
    lpFormats : DDPIXELFORMAT.Ptr
    ddRVal : HRESULT
    GetMoCompFormats : LPDDHALMOCOMPCB_GETFORMATS
}
struct DDHAL_CREATEMOCOMPDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    lpGuid : GUID.Ptr
    dwUncompWidth : UInt32
    dwUncompHeight : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
    lpData : Struct.Ptr
    dwDataSize : UInt32
    ddRVal : HRESULT
    CreateMoComp : LPDDHALMOCOMPCB_CREATE
}
struct DDMCCOMPBUFFERINFO {
    dwSize : UInt32
    dwNumCompBuffers : UInt32
    dwWidthToCreate : UInt32
    dwHeightToCreate : UInt32
    dwBytesToAllocate : UInt32
    ddCompCaps : DDSCAPS2
    ddPixelFormat : DDPIXELFORMAT
}
struct DDHAL_GETMOCOMPCOMPBUFFDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpGuid : GUID.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    ddPixelFormat : DDPIXELFORMAT
    dwNumTypesCompBuffs : UInt32
    lpCompBuffInfo : DDMCCOMPBUFFERINFO.Ptr
    ddRVal : HRESULT
    GetMoCompBuffInfo : LPDDHALMOCOMPCB_GETCOMPBUFFINFO
}
struct DDHAL_GETINTERNALMOCOMPDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpGuid : GUID.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    ddPixelFormat : DDPIXELFORMAT
    dwScratchMemAlloc : UInt32
    ddRVal : HRESULT
    GetInternalMoCompInfo : LPDDHALMOCOMPCB_GETINTERNALINFO
}
struct DDHAL_BEGINMOCOMPFRAMEDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    lpDestSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwInputDataSize : UInt32
    lpInputData : Struct.Ptr
    dwOutputDataSize : UInt32
    lpOutputData : Struct.Ptr
    ddRVal : HRESULT
    BeginMoCompFrame : LPDDHALMOCOMPCB_BEGINFRAME
}
struct DDHAL_ENDMOCOMPFRAMEDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    lpInputData : Struct.Ptr
    dwInputDataSize : UInt32
    ddRVal : HRESULT
    EndMoCompFrame : LPDDHALMOCOMPCB_ENDFRAME
}
struct DDMCBUFFERINFO {
    dwSize : UInt32
    lpCompSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwDataOffset : UInt32
    dwDataSize : UInt32
    lpPrivate : Struct.Ptr
}
struct DDHAL_RENDERMOCOMPDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    dwNumBuffers : UInt32
    lpBufferInfo : DDMCBUFFERINFO.Ptr
    dwFunction : UInt32
    lpInputData : Struct.Ptr
    dwInputDataSize : UInt32
    lpOutputData : Struct.Ptr
    dwOutputDataSize : UInt32
    ddRVal : HRESULT
    RenderMoComp : LPDDHALMOCOMPCB_RENDER
}
struct DDHAL_QUERYMOCOMPSTATUSDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    lpSurface : DDRAWI_DDRAWSURFACE_LCL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    QueryMoCompStatus : LPDDHALMOCOMPCB_QUERYSTATUS
}
struct DDHAL_DESTROYMOCOMPDATA {
    lpDD : DDRAWI_DIRECTDRAW_LCL.Ptr
    lpMoComp : DDRAWI_DDMOTIONCOMP_LCL.Ptr
    ddRVal : HRESULT
    DestroyMoComp : LPDDHALMOCOMPCB_DESTROY
}
struct VIDEOMEMORY {
    dwFlags : UInt32
    fpStart : IntPtr
    Anonymous1 : this._Anonymous1_e__Union
    ddsCaps : DDSCAPS
    ddsCapsAlt : DDSCAPS
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            fpEnd : IntPtr
            dwWidth : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            lpHeap : VMEMHEAP.Ptr
            dwHeight : UInt32
        }
    }
}
struct VIDEOMEMORYINFO {
    fpPrimary : IntPtr
    dwFlags : UInt32
    dwDisplayWidth : UInt32
    dwDisplayHeight : UInt32
    lDisplayPitch : Int32
    ddpfDisplay : DDPIXELFORMAT
    dwOffscreenAlign : UInt32
    dwOverlayAlign : UInt32
    dwTextureAlign : UInt32
    dwZBufferAlign : UInt32
    dwAlphaAlign : UInt32
    pvPrimary : Struct.Ptr
}
struct PDD_SETCOLORKEY extends FunctionPointer {
    static Types := [DD_DRVSETCOLORKEYDATA.Ptr, UInt32]
}
struct PDD_CANCREATESURFACE extends FunctionPointer {
    static Types := [DD_CANCREATESURFACEDATA.Ptr, UInt32]
}
struct PDD_WAITFORVERTICALBLANK extends FunctionPointer {
    static Types := [DD_WAITFORVERTICALBLANKDATA.Ptr, UInt32]
}
struct PDD_CREATESURFACE extends FunctionPointer {
    static Types := [DD_CREATESURFACEDATA.Ptr, UInt32]
}
struct PDD_DESTROYDRIVER extends FunctionPointer {
    static Types := [PDD_DESTROYDRIVERDATA, UInt32]
}
struct PDD_SETMODE extends FunctionPointer {
    static Types := [PDD_SETMODEDATA, UInt32]
}
struct PDD_CREATEPALETTE extends FunctionPointer {
    static Types := [DD_CREATEPALETTEDATA.Ptr, UInt32]
}
struct PDD_GETSCANLINE extends FunctionPointer {
    static Types := [DD_GETSCANLINEDATA.Ptr, UInt32]
}
struct PDD_MAPMEMORY extends FunctionPointer {
    static Types := [DD_MAPMEMORYDATA.Ptr, UInt32]
}
struct PDD_GETDRIVERINFO extends FunctionPointer {
    static Types := [DD_GETDRIVERINFODATA.Ptr, UInt32]
}
struct DD_CALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroyDriver : PDD_DESTROYDRIVER
    CreateSurface : PDD_CREATESURFACE
    SetColorKey : PDD_SETCOLORKEY
    SetMode : PDD_SETMODE
    WaitForVerticalBlank : PDD_WAITFORVERTICALBLANK
    CanCreateSurface : PDD_CANCREATESURFACE
    CreatePalette : PDD_CREATEPALETTE
    GetScanLine : PDD_GETSCANLINE
    MapMemory : PDD_MAPMEMORY
}
struct PDD_GETAVAILDRIVERMEMORY extends FunctionPointer {
    static Types := [DD_GETAVAILDRIVERMEMORYDATA.Ptr, UInt32]
}
struct DD_MISCELLANEOUSCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    GetAvailDriverMemory : PDD_GETAVAILDRIVERMEMORY
}
struct PDD_ALPHABLT extends FunctionPointer {
    static Types := [DD_BLTDATA.Ptr, UInt32]
}
struct PDD_CREATESURFACEEX extends FunctionPointer {
    static Types := [DD_CREATESURFACEEXDATA.Ptr, UInt32]
}
struct PDD_GETDRIVERSTATE extends FunctionPointer {
    static Types := [DD_GETDRIVERSTATEDATA.Ptr, UInt32]
}
struct PDD_DESTROYDDLOCAL extends FunctionPointer {
    static Types := [DD_DESTROYDDLOCALDATA.Ptr, UInt32]
}
struct DD_MISCELLANEOUS2CALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    AlphaBlt : PDD_ALPHABLT
    CreateSurfaceEx : PDD_CREATESURFACEEX
    GetDriverState : PDD_GETDRIVERSTATE
    DestroyDDLocal : PDD_DESTROYDDLOCAL
}
struct PDD_FREEDRIVERMEMORY extends FunctionPointer {
    static Types := [DD_FREEDRIVERMEMORYDATA.Ptr, UInt32]
}
struct PDD_SETEXCLUSIVEMODE extends FunctionPointer {
    static Types := [DD_SETEXCLUSIVEMODEDATA.Ptr, UInt32]
}
struct PDD_FLIPTOGDISURFACE extends FunctionPointer {
    static Types := [DD_FLIPTOGDISURFACEDATA.Ptr, UInt32]
}
struct DD_NTCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    FreeDriverMemory : PDD_FREEDRIVERMEMORY
    SetExclusiveMode : PDD_SETEXCLUSIVEMODE
    FlipToGDISurface : PDD_FLIPTOGDISURFACE
}
struct PDD_PALCB_DESTROYPALETTE extends FunctionPointer {
    static Types := [DD_DESTROYPALETTEDATA.Ptr, UInt32]
}
struct PDD_PALCB_SETENTRIES extends FunctionPointer {
    static Types := [DD_SETENTRIESDATA.Ptr, UInt32]
}
struct DD_PALETTECALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroyPalette : PDD_PALCB_DESTROYPALETTE
    SetEntries : PDD_PALCB_SETENTRIES
}
struct PDD_SURFCB_LOCK extends FunctionPointer {
    static Types := [DD_LOCKDATA.Ptr, UInt32]
}
struct PDD_SURFCB_UNLOCK extends FunctionPointer {
    static Types := [DD_UNLOCKDATA.Ptr, UInt32]
}
struct PDD_SURFCB_BLT extends FunctionPointer {
    static Types := [DD_BLTDATA.Ptr, UInt32]
}
struct PDD_SURFCB_UPDATEOVERLAY extends FunctionPointer {
    static Types := [DD_UPDATEOVERLAYDATA.Ptr, UInt32]
}
struct PDD_SURFCB_SETOVERLAYPOSITION extends FunctionPointer {
    static Types := [DD_SETOVERLAYPOSITIONDATA.Ptr, UInt32]
}
struct PDD_SURFCB_SETPALETTE extends FunctionPointer {
    static Types := [DD_SETPALETTEDATA.Ptr, UInt32]
}
struct PDD_SURFCB_FLIP extends FunctionPointer {
    static Types := [DD_FLIPDATA.Ptr, UInt32]
}
struct PDD_SURFCB_DESTROYSURFACE extends FunctionPointer {
    static Types := [DD_DESTROYSURFACEDATA.Ptr, UInt32]
}
struct PDD_SURFCB_SETCLIPLIST extends FunctionPointer {
    static Types := [DD_SETCLIPLISTDATA.Ptr, UInt32]
}
struct PDD_SURFCB_ADDATTACHEDSURFACE extends FunctionPointer {
    static Types := [DD_ADDATTACHEDSURFACEDATA.Ptr, UInt32]
}
struct PDD_SURFCB_SETCOLORKEY extends FunctionPointer {
    static Types := [DD_SETCOLORKEYDATA.Ptr, UInt32]
}
struct PDD_SURFCB_GETBLTSTATUS extends FunctionPointer {
    static Types := [DD_GETBLTSTATUSDATA.Ptr, UInt32]
}
struct PDD_SURFCB_GETFLIPSTATUS extends FunctionPointer {
    static Types := [DD_GETFLIPSTATUSDATA.Ptr, UInt32]
}
struct DD_SURFACECALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    DestroySurface : PDD_SURFCB_DESTROYSURFACE
    Flip : PDD_SURFCB_FLIP
    SetClipList : PDD_SURFCB_SETCLIPLIST
    Lock : PDD_SURFCB_LOCK
    Unlock : PDD_SURFCB_UNLOCK
    Blt : PDD_SURFCB_BLT
    SetColorKey : PDD_SURFCB_SETCOLORKEY
    AddAttachedSurface : PDD_SURFCB_ADDATTACHEDSURFACE
    GetBltStatus : PDD_SURFCB_GETBLTSTATUS
    GetFlipStatus : PDD_SURFCB_GETFLIPSTATUS
    UpdateOverlay : PDD_SURFCB_UPDATEOVERLAY
    SetOverlayPosition : PDD_SURFCB_SETOVERLAYPOSITION
    reserved4 : Struct.Ptr
    SetPalette : PDD_SURFCB_SETPALETTE
}
struct PDD_VPORTCB_CANCREATEVIDEOPORT extends FunctionPointer {
    static Types := [DD_CANCREATEVPORTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_CREATEVIDEOPORT extends FunctionPointer {
    static Types := [DD_CREATEVPORTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_FLIP extends FunctionPointer {
    static Types := [DD_FLIPVPORTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETBANDWIDTH extends FunctionPointer {
    static Types := [DD_GETVPORTBANDWIDTHDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETINPUTFORMATS extends FunctionPointer {
    static Types := [DD_GETVPORTINPUTFORMATDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETOUTPUTFORMATS extends FunctionPointer {
    static Types := [DD_GETVPORTOUTPUTFORMATDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETAUTOFLIPSURF extends FunctionPointer {
    static Types := [PDD_GETVPORTAUTOFLIPSURFACEDATA, UInt32]
}
struct PDD_VPORTCB_GETFIELD extends FunctionPointer {
    static Types := [DD_GETVPORTFIELDDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETLINE extends FunctionPointer {
    static Types := [DD_GETVPORTLINEDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETVPORTCONNECT extends FunctionPointer {
    static Types := [DD_GETVPORTCONNECTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_DESTROYVPORT extends FunctionPointer {
    static Types := [DD_DESTROYVPORTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETFLIPSTATUS extends FunctionPointer {
    static Types := [DD_GETVPORTFLIPSTATUSDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_UPDATE extends FunctionPointer {
    static Types := [DD_UPDATEVPORTDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_WAITFORSYNC extends FunctionPointer {
    static Types := [DD_WAITFORVPORTSYNCDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_GETSIGNALSTATUS extends FunctionPointer {
    static Types := [DD_GETVPORTSIGNALDATA.Ptr, UInt32]
}
struct PDD_VPORTCB_COLORCONTROL extends FunctionPointer {
    static Types := [DD_VPORTCOLORDATA.Ptr, UInt32]
}
struct DD_VIDEOPORTCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    CanCreateVideoPort : PDD_VPORTCB_CANCREATEVIDEOPORT
    CreateVideoPort : PDD_VPORTCB_CREATEVIDEOPORT
    FlipVideoPort : PDD_VPORTCB_FLIP
    GetVideoPortBandwidth : PDD_VPORTCB_GETBANDWIDTH
    GetVideoPortInputFormats : PDD_VPORTCB_GETINPUTFORMATS
    GetVideoPortOutputFormats : PDD_VPORTCB_GETOUTPUTFORMATS
    lpReserved1 : Struct.Ptr
    GetVideoPortField : PDD_VPORTCB_GETFIELD
    GetVideoPortLine : PDD_VPORTCB_GETLINE
    GetVideoPortConnectInfo : PDD_VPORTCB_GETVPORTCONNECT
    DestroyVideoPort : PDD_VPORTCB_DESTROYVPORT
    GetVideoPortFlipStatus : PDD_VPORTCB_GETFLIPSTATUS
    UpdateVideoPort : PDD_VPORTCB_UPDATE
    WaitForVideoPortSync : PDD_VPORTCB_WAITFORSYNC
    GetVideoSignalStatus : PDD_VPORTCB_GETSIGNALSTATUS
    ColorControl : PDD_VPORTCB_COLORCONTROL
}
struct PDD_COLORCB_COLORCONTROL extends FunctionPointer {
    static Types := [DD_COLORCONTROLDATA.Ptr, UInt32]
}
struct DD_COLORCONTROLCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    ColorControl : PDD_COLORCB_COLORCONTROL
}
struct PDD_KERNELCB_SYNCSURFACE extends FunctionPointer {
    static Types := [DD_SYNCSURFACEDATA.Ptr, UInt32]
}
struct PDD_KERNELCB_SYNCVIDEOPORT extends FunctionPointer {
    static Types := [DD_SYNCVIDEOPORTDATA.Ptr, UInt32]
}
struct DD_KERNELCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    SyncSurfaceData : PDD_KERNELCB_SYNCSURFACE
    SyncVideoPortData : PDD_KERNELCB_SYNCVIDEOPORT
}
struct PDD_MOCOMPCB_GETGUIDS extends FunctionPointer {
    static Types := [DD_GETMOCOMPGUIDSDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_GETFORMATS extends FunctionPointer {
    static Types := [DD_GETMOCOMPFORMATSDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_CREATE extends FunctionPointer {
    static Types := [DD_CREATEMOCOMPDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_GETCOMPBUFFINFO extends FunctionPointer {
    static Types := [DD_GETMOCOMPCOMPBUFFDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_GETINTERNALINFO extends FunctionPointer {
    static Types := [DD_GETINTERNALMOCOMPDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_BEGINFRAME extends FunctionPointer {
    static Types := [DD_BEGINMOCOMPFRAMEDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_ENDFRAME extends FunctionPointer {
    static Types := [DD_ENDMOCOMPFRAMEDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_RENDER extends FunctionPointer {
    static Types := [DD_RENDERMOCOMPDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_QUERYSTATUS extends FunctionPointer {
    static Types := [DD_QUERYMOCOMPSTATUSDATA.Ptr, UInt32]
}
struct PDD_MOCOMPCB_DESTROY extends FunctionPointer {
    static Types := [DD_DESTROYMOCOMPDATA.Ptr, UInt32]
}
struct DD_MOTIONCOMPCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    GetMoCompGuids : PDD_MOCOMPCB_GETGUIDS
    GetMoCompFormats : PDD_MOCOMPCB_GETFORMATS
    CreateMoComp : PDD_MOCOMPCB_CREATE
    GetMoCompBuffInfo : PDD_MOCOMPCB_GETCOMPBUFFINFO
    GetInternalMoCompInfo : PDD_MOCOMPCB_GETINTERNALINFO
    BeginMoCompFrame : PDD_MOCOMPCB_BEGINFRAME
    EndMoCompFrame : PDD_MOCOMPCB_ENDFRAME
    RenderMoComp : PDD_MOCOMPCB_RENDER
    QueryMoCompStatus : PDD_MOCOMPCB_QUERYSTATUS
    DestroyMoComp : PDD_MOCOMPCB_DESTROY
}
struct DD_NONLOCALVIDMEMCAPS {
    dwSize : UInt32
    dwNLVBCaps : UInt32
    dwNLVBCaps2 : UInt32
    dwNLVBCKeyCaps : UInt32
    dwNLVBFXCaps : UInt32
    dwNLVBRops : UInt32[8]
}
struct DD_PALETTE_GLOBAL {
    dwReserved1 : IntPtr
}
struct DD_PALETTE_LOCAL {
    dwReserved0 : UInt32
    dwReserved1 : IntPtr
}
struct DD_CLIPPER_GLOBAL {
    dwReserved1 : IntPtr
}
struct DD_CLIPPER_LOCAL {
    dwReserved1 : IntPtr
}
struct DD_ATTACHLIST {
    lpLink : DD_ATTACHLIST.Ptr
    lpAttached : DD_SURFACE_LOCAL.Ptr
}
struct DD_SURFACE_INT {
    lpLcl : DD_SURFACE_LOCAL.Ptr
}
struct DD_SURFACE_GLOBAL {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    fpVidMem : IntPtr
    Anonymous3 : this._Anonymous3_e__Union
    yHint : Int32
    xHint : Int32
    wHeight : UInt32
    wWidth : UInt32
    dwReserved1 : IntPtr
    ddpfSurface : DDPIXELFORMAT
    fpHeapOffset : IntPtr
    hCreatorProcess : HANDLE
    struct _Anonymous1_e__Union {
        union {
            dwBlockSizeY : UInt32
            lSlicePitch : Int32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            lpVidMemHeap : VIDEOMEMORY.Ptr
            dwBlockSizeX : UInt32
            dwUserMemSize : UInt32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            lPitch : Int32
            dwLinearSize : UInt32
        }
    }
}
struct DD_SURFACE_MORE {
    dwMipMapCount : UInt32
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwOverlayFlags : UInt32
    ddsCapsEx : DDSCAPSEX
    dwSurfaceHandle : UInt32
}
struct DD_SURFACE_LOCAL {
    lpGbl : DD_SURFACE_GLOBAL.Ptr
    dwFlags : UInt32
    ddsCaps : DDSCAPS
    dwReserved1 : IntPtr
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    lpSurfMore : DD_SURFACE_MORE.Ptr
    lpAttachList : DD_ATTACHLIST.Ptr
    lpAttachListFrom : DD_ATTACHLIST.Ptr
    rcOverlaySrc : RECT
    struct _Anonymous1_e__Union {
        union {
            ddckCKSrcOverlay : DDCOLORKEY
            ddckCKSrcBlt : DDCOLORKEY
        }
    }
    struct _Anonymous2_e__Union {
        union {
            ddckCKDestOverlay : DDCOLORKEY
            ddckCKDestBlt : DDCOLORKEY
        }
    }
}
struct DD_MORECAPS {
    dwSize : UInt32
    dwAlphaCaps : UInt32
    dwSVBAlphaCaps : UInt32
    dwVSBAlphaCaps : UInt32
    dwSSBAlphaCaps : UInt32
    dwFilterCaps : UInt32
    dwSVBFilterCaps : UInt32
    dwVSBFilterCaps : UInt32
    dwSSBFilterCaps : UInt32
}
struct DDNTCORECAPS {
    dwSize : UInt32
    dwCaps : UInt32
    dwCaps2 : UInt32
    dwCKeyCaps : UInt32
    dwFXCaps : UInt32
    dwFXAlphaCaps : UInt32
    dwPalCaps : UInt32
    dwSVCaps : UInt32
    dwAlphaBltConstBitDepths : UInt32
    dwAlphaBltPixelBitDepths : UInt32
    dwAlphaBltSurfaceBitDepths : UInt32
    dwAlphaOverlayConstBitDepths : UInt32
    dwAlphaOverlayPixelBitDepths : UInt32
    dwAlphaOverlaySurfaceBitDepths : UInt32
    dwZBufferBitDepths : UInt32
    dwVidMemTotal : UInt32
    dwVidMemFree : UInt32
    dwMaxVisibleOverlays : UInt32
    dwCurrVisibleOverlays : UInt32
    dwNumFourCCCodes : UInt32
    dwAlignBoundarySrc : UInt32
    dwAlignSizeSrc : UInt32
    dwAlignBoundaryDest : UInt32
    dwAlignSizeDest : UInt32
    dwAlignStrideAlign : UInt32
    dwRops : UInt32[8]
    ddsCaps : DDSCAPS
    dwMinOverlayStretch : UInt32
    dwMaxOverlayStretch : UInt32
    dwMinLiveVideoStretch : UInt32
    dwMaxLiveVideoStretch : UInt32
    dwMinHwCodecStretch : UInt32
    dwMaxHwCodecStretch : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwSVBCaps : UInt32
    dwSVBCKeyCaps : UInt32
    dwSVBFXCaps : UInt32
    dwSVBRops : UInt32[8]
    dwVSBCaps : UInt32
    dwVSBCKeyCaps : UInt32
    dwVSBFXCaps : UInt32
    dwVSBRops : UInt32[8]
    dwSSBCaps : UInt32
    dwSSBCKeyCaps : UInt32
    dwSSBFXCaps : UInt32
    dwSSBRops : UInt32[8]
    dwMaxVideoPorts : UInt32
    dwCurrVideoPorts : UInt32
    dwSVBCaps2 : UInt32
}
struct DD_D3DBUFCALLBACKS {
    dwSize : UInt32
    dwFlags : UInt32
    CanCreateD3DBuffer : PDD_CANCREATESURFACE
    CreateD3DBuffer : PDD_CREATESURFACE
    DestroyD3DBuffer : PDD_SURFCB_DESTROYSURFACE
    LockD3DBuffer : PDD_SURFCB_LOCK
    UnlockD3DBuffer : PDD_SURFCB_UNLOCK
}
struct DD_HALINFO_V4 {
    dwSize : UInt32
    vmiData : VIDEOMEMORYINFO
    ddCaps : DDNTCORECAPS
    GetDriverInfo : PDD_GETDRIVERINFO
    dwFlags : UInt32
}
struct DD_HALINFO {
    dwSize : UInt32
    vmiData : VIDEOMEMORYINFO
    ddCaps : DDNTCORECAPS
    GetDriverInfo : PDD_GETDRIVERINFO
    dwFlags : UInt32
    lpD3DGlobalDriverData : Struct.Ptr
    lpD3DHALCallbacks : Struct.Ptr
    lpD3DBufCallbacks : DD_D3DBUFCALLBACKS.Ptr
}
struct DD_DIRECTDRAW_GLOBAL {
    dhpdev : Struct.Ptr
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
    lpDDVideoPortCaps : DDVIDEOPORTCAPS.Ptr
}
struct DD_DIRECTDRAW_LOCAL {
    lpGbl : DD_DIRECTDRAW_GLOBAL.Ptr
}
struct DD_VIDEOPORT_LOCAL {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    ddvpDesc : DDVIDEOPORTDESC
    ddvpInfo : DDVIDEOPORTINFO
    lpSurface : DD_SURFACE_INT.Ptr
    lpVBISurface : DD_SURFACE_INT.Ptr
    dwNumAutoflip : UInt32
    dwNumVBIAutoflip : UInt32
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
    dwReserved3 : IntPtr
}
struct DD_MOTIONCOMP_LOCAL {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    guid : GUID
    dwUncompWidth : UInt32
    dwUncompHeight : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
    lpDriverReserved1 : Struct.Ptr
    lpDriverReserved2 : Struct.Ptr
    lpDriverReserved3 : Struct.Ptr
}
struct DD_MORESURFACECAPS {
    dwSize : UInt32
    ddsCapsMore : DDSCAPSEX
    ddsExtendedHeapRestrictions : this.NTExtendedHeapRestrictions[1]
    struct NTExtendedHeapRestrictions {
        ddsCapsEx : DDSCAPSEX
        ddsCapsExAlt : DDSCAPSEX
    }
}
struct DD_STEREOMODE {
    dwSize : UInt32
    dwHeight : UInt32
    dwWidth : UInt32
    dwBpp : UInt32
    dwRefreshRate : UInt32
    bSupported : BOOL
}
struct DD_UPDATENONLOCALHEAPDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    dwHeap : UInt32
    fpGARTLin : IntPtr
    fpGARTDev : IntPtr
    ulPolicyMaxBytes : IntPtr
    ddRVal : HRESULT
    UpdateNonLocalHeap : Struct.Ptr
}
struct DD_NTPRIVATEDRIVERCAPS {
    dwSize : UInt32
    dwPrivateCaps : UInt32
}
struct DD_BLTDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDDestSurface : DD_SURFACE_LOCAL.Ptr
    rDest : RECTL
    lpDDSrcSurface : DD_SURFACE_LOCAL.Ptr
    rSrc : RECTL
    dwFlags : UInt32
    dwROPFlags : UInt32
    bltFX : DDBLTFX
    ddRVal : HRESULT
    Blt : Struct.Ptr
    IsClipped : BOOL
    rOrigDest : RECTL
    rOrigSrc : RECTL
    dwRectCnt : UInt32
    prDestRects : RECT.Ptr
    dwAFlags : UInt32
    ddargbScaleFactors : DDARGB
}
struct DD_LOCKDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    bHasRect : UInt32
    rArea : RECTL
    lpSurfData : Struct.Ptr
    ddRVal : HRESULT
    Lock : Struct.Ptr
    dwFlags : UInt32
    fpProcess : IntPtr
}
struct DD_UNLOCKDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    Unlock : Struct.Ptr
}
struct DD_UPDATEOVERLAYDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDDestSurface : DD_SURFACE_LOCAL.Ptr
    rDest : RECTL
    lpDDSrcSurface : DD_SURFACE_LOCAL.Ptr
    rSrc : RECTL
    dwFlags : UInt32
    overlayFX : DDOVERLAYFX
    ddRVal : HRESULT
    UpdateOverlay : Struct.Ptr
}
struct DD_SETOVERLAYPOSITIONDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSrcSurface : DD_SURFACE_LOCAL.Ptr
    lpDDDestSurface : DD_SURFACE_LOCAL.Ptr
    lXPos : Int32
    lYPos : Int32
    ddRVal : HRESULT
    SetOverlayPosition : Struct.Ptr
}
struct DD_SETPALETTEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    lpDDPalette : DD_PALETTE_GLOBAL.Ptr
    ddRVal : HRESULT
    SetPalette : Struct.Ptr
    Attach : BOOL
}
struct DD_FLIPDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpSurfCurr : DD_SURFACE_LOCAL.Ptr
    lpSurfTarg : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    Flip : Struct.Ptr
    lpSurfCurrLeft : DD_SURFACE_LOCAL.Ptr
    lpSurfTargLeft : DD_SURFACE_LOCAL.Ptr
}
struct DD_DESTROYSURFACEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    DestroySurface : Struct.Ptr
}
struct DD_SETCLIPLISTDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    SetClipList : Struct.Ptr
}
struct DD_ADDATTACHEDSURFACEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    lpSurfAttached : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    AddAttachedSurface : Struct.Ptr
}
struct DD_SETCOLORKEYDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ckNew : DDCOLORKEY
    ddRVal : HRESULT
    SetColorKey : Struct.Ptr
}
struct DD_GETBLTSTATUSDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    GetBltStatus : Struct.Ptr
}
struct DD_GETFLIPSTATUSDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    GetFlipStatus : Struct.Ptr
}
struct DD_DESTROYPALETTEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDPalette : DD_PALETTE_GLOBAL.Ptr
    ddRVal : HRESULT
    DestroyPalette : Struct.Ptr
}
struct DD_SETENTRIESDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDPalette : DD_PALETTE_GLOBAL.Ptr
    dwBase : UInt32
    dwNumEntries : UInt32
    lpEntries : PALETTEENTRY.Ptr
    ddRVal : HRESULT
    SetEntries : Struct.Ptr
}
struct DD_CREATESURFACEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurfaceDesc : DDSURFACEDESC.Ptr
    lplpSList : DD_SURFACE_LOCAL.Ptr.Ptr
    dwSCnt : UInt32
    ddRVal : HRESULT
    CreateSurface : Struct.Ptr
}
struct DD_CANCREATESURFACEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurfaceDesc : DDSURFACEDESC.Ptr
    bIsDifferentPixelFormat : UInt32
    ddRVal : HRESULT
    CanCreateSurface : Struct.Ptr
}
struct DD_CREATEPALETTEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDPalette : DD_PALETTE_GLOBAL.Ptr
    lpColorTable : PALETTEENTRY.Ptr
    ddRVal : HRESULT
    CreatePalette : Struct.Ptr
    is_excl : BOOL
}
struct DD_WAITFORVERTICALBLANKDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    dwFlags : UInt32
    bIsInVB : UInt32
    hEvent : IntPtr
    ddRVal : HRESULT
    WaitForVerticalBlank : Struct.Ptr
}
struct DD_DRVSETCOLORKEYDATA {
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ckNew : DDCOLORKEY
    ddRVal : HRESULT
    SetColorKey : Struct.Ptr
}
struct DD_GETSCANLINEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    dwScanLine : UInt32
    ddRVal : HRESULT
    GetScanLine : Struct.Ptr
}
struct DD_MAPMEMORYDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    bMap : BOOL
    hProcess : HANDLE
    fpProcess : IntPtr
    ddRVal : HRESULT
}
struct DD_CANCREATEVPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpDDVideoPortDesc : DDVIDEOPORTDESC.Ptr
    ddRVal : HRESULT
    CanCreateVideoPort : Struct.Ptr
}
struct DD_CREATEVPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpDDVideoPortDesc : DDVIDEOPORTDESC.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    ddRVal : HRESULT
    CreateVideoPort : Struct.Ptr
}
struct DD_FLIPVPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    lpSurfCurr : DD_SURFACE_LOCAL.Ptr
    lpSurfTarg : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    FlipVideoPort : Struct.Ptr
}
struct DD_GETVPORTBANDWIDTHDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    lpddpfFormat : DDPIXELFORMAT.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    dwFlags : UInt32
    lpBandwidth : DDVIDEOPORTBANDWIDTH.Ptr
    ddRVal : HRESULT
    GetVideoPortBandwidth : Struct.Ptr
}
struct DD_GETVPORTINPUTFORMATDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwFlags : UInt32
    lpddpfFormat : DDPIXELFORMAT.Ptr
    dwNumFormats : UInt32
    ddRVal : HRESULT
    GetVideoPortInputFormats : Struct.Ptr
}
struct DD_GETVPORTOUTPUTFORMATDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwFlags : UInt32
    lpddpfInputFormat : DDPIXELFORMAT.Ptr
    lpddpfOutputFormats : DDPIXELFORMAT.Ptr
    dwNumFormats : UInt32
    ddRVal : HRESULT
    GetVideoPortInputFormats : Struct.Ptr
}
struct DD_GETVPORTFIELDDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    bField : BOOL
    ddRVal : HRESULT
    GetVideoPortField : Struct.Ptr
}
struct DD_GETVPORTLINEDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwLine : UInt32
    ddRVal : HRESULT
    GetVideoPortLine : Struct.Ptr
}
struct DD_GETVPORTCONNECTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    dwPortId : UInt32
    lpConnect : DDVIDEOPORTCONNECT.Ptr
    dwNumEntries : UInt32
    ddRVal : HRESULT
    GetVideoPortConnectInfo : Struct.Ptr
}
struct DD_DESTROYVPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    ddRVal : HRESULT
    DestroyVideoPort : Struct.Ptr
}
struct DD_GETVPORTFLIPSTATUSDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    fpSurface : IntPtr
    ddRVal : HRESULT
    GetVideoPortFlipStatus : Struct.Ptr
}
struct DD_UPDATEVPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    lplpDDSurface : DD_SURFACE_INT.Ptr.Ptr
    lplpDDVBISurface : DD_SURFACE_INT.Ptr.Ptr
    lpVideoInfo : DDVIDEOPORTINFO.Ptr
    dwFlags : UInt32
    dwNumAutoflip : UInt32
    dwNumVBIAutoflip : UInt32
    ddRVal : HRESULT
    UpdateVideoPort : Struct.Ptr
}
struct DD_WAITFORVPORTSYNCDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwFlags : UInt32
    dwLine : UInt32
    dwTimeOut : UInt32
    ddRVal : HRESULT
    UpdateVideoPort : Struct.Ptr
}
struct DD_GETVPORTSIGNALDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwStatus : UInt32
    ddRVal : HRESULT
    GetVideoSignalStatus : Struct.Ptr
}
struct DD_VPORTCOLORDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwFlags : UInt32
    lpColorData : DDCOLORCONTROL.Ptr
    ddRVal : HRESULT
    ColorControl : Struct.Ptr
}
struct DD_COLORCONTROLDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    lpColorData : DDCOLORCONTROL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
    ColorControl : Struct.Ptr
}
struct DD_GETDRIVERINFODATA {
    dhpdev : Struct.Ptr
    dwSize : UInt32
    dwFlags : UInt32
    guidInfo : GUID
    dwExpectedSize : UInt32
    lpvData : Struct.Ptr
    dwActualSize : UInt32
    ddRVal : HRESULT
}
struct DD_GETAVAILDRIVERMEMORYDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    DDSCaps : DDSCAPS
    dwTotal : UInt32
    dwFree : UInt32
    ddRVal : HRESULT
    GetAvailDriverMemory : Struct.Ptr
}
struct DD_FREEDRIVERMEMORYDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
    FreeDriverMemory : Struct.Ptr
}
struct DD_SETEXCLUSIVEMODEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    dwEnterExcl : UInt32
    dwReserved : UInt32
    ddRVal : HRESULT
    SetExclusiveMode : Struct.Ptr
}
struct DD_FLIPTOGDISURFACEDATA {
    lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
    dwToGDI : UInt32
    dwReserved : UInt32
    ddRVal : HRESULT
    FlipToGDISurface : Struct.Ptr
}
struct DD_SYNCSURFACEDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpDDSurface : DD_SURFACE_LOCAL.Ptr
    dwSurfaceOffset : UInt32
    fpLockPtr : IntPtr
    lPitch : Int32
    dwOverlayOffset : UInt32
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
    dwDriverReserved4 : UInt32
    ddRVal : HRESULT
}
struct DD_SYNCVIDEOPORTDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpVideoPort : DD_VIDEOPORT_LOCAL.Ptr
    dwOriginOffset : UInt32
    dwHeight : UInt32
    dwVBIHeight : UInt32
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
    ddRVal : HRESULT
}
struct DD_GETMOCOMPGUIDSDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    dwNumGuids : UInt32
    lpGuids : GUID.Ptr
    ddRVal : HRESULT
}
struct DD_GETMOCOMPFORMATSDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpGuid : GUID.Ptr
    dwNumFormats : UInt32
    lpFormats : DDPIXELFORMAT.Ptr
    ddRVal : HRESULT
}
struct DD_CREATEMOCOMPDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    lpGuid : GUID.Ptr
    dwUncompWidth : UInt32
    dwUncompHeight : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
    lpData : Struct.Ptr
    dwDataSize : UInt32
    ddRVal : HRESULT
}
struct DDCOMPBUFFERINFO {
    dwSize : UInt32
    dwNumCompBuffers : UInt32
    dwWidthToCreate : UInt32
    dwHeightToCreate : UInt32
    dwBytesToAllocate : UInt32
    ddCompCaps : DDSCAPS2
    ddPixelFormat : DDPIXELFORMAT
}
struct DD_GETMOCOMPCOMPBUFFDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpGuid : GUID.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    ddPixelFormat : DDPIXELFORMAT
    dwNumTypesCompBuffs : UInt32
    lpCompBuffInfo : DDCOMPBUFFERINFO.Ptr
    ddRVal : HRESULT
}
struct DD_GETINTERNALMOCOMPDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpGuid : GUID.Ptr
    dwWidth : UInt32
    dwHeight : UInt32
    ddPixelFormat : DDPIXELFORMAT
    dwScratchMemAlloc : UInt32
    ddRVal : HRESULT
}
struct DD_BEGINMOCOMPFRAMEDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    lpDestSurface : DD_SURFACE_LOCAL.Ptr
    dwInputDataSize : UInt32
    lpInputData : Struct.Ptr
    dwOutputDataSize : UInt32
    lpOutputData : Struct.Ptr
    ddRVal : HRESULT
}
struct DD_ENDMOCOMPFRAMEDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    lpInputData : Struct.Ptr
    dwInputDataSize : UInt32
    ddRVal : HRESULT
}
struct DDMOCOMPBUFFERINFO {
    dwSize : UInt32
    lpCompSurface : DD_SURFACE_LOCAL.Ptr
    dwDataOffset : UInt32
    dwDataSize : UInt32
    lpPrivate : Struct.Ptr
}
struct DD_RENDERMOCOMPDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    dwNumBuffers : UInt32
    lpBufferInfo : DDMOCOMPBUFFERINFO.Ptr
    dwFunction : UInt32
    lpInputData : Struct.Ptr
    dwInputDataSize : UInt32
    lpOutputData : Struct.Ptr
    dwOutputDataSize : UInt32
    ddRVal : HRESULT
}
struct DD_QUERYMOCOMPSTATUSDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    lpSurface : DD_SURFACE_LOCAL.Ptr
    dwFlags : UInt32
    ddRVal : HRESULT
}
struct DD_DESTROYMOCOMPDATA {
    lpDD : DD_DIRECTDRAW_LOCAL.Ptr
    lpMoComp : DD_MOTIONCOMP_LOCAL.Ptr
    ddRVal : HRESULT
}
struct DD_CREATESURFACEEXDATA {
    dwFlags : UInt32
    lpDDLcl : DD_DIRECTDRAW_LOCAL.Ptr
    lpDDSLcl : DD_SURFACE_LOCAL.Ptr
    ddRVal : HRESULT
}
struct DD_GETDRIVERSTATEDATA {
    dwFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    lpdwStates : UInt32.Ptr
    dwLength : UInt32
    ddRVal : HRESULT
    struct _Anonymous_e__Union {
        union {
            lpDD : DD_DIRECTDRAW_GLOBAL.Ptr
            dwhContext : IntPtr
        }
    }
}
struct DD_DESTROYDDLOCALDATA {
    dwFlags : UInt32
    pDDLcl : DD_DIRECTDRAW_LOCAL.Ptr
    ddRVal : HRESULT
}
struct DDMDL {
    MdlNext : DDMDL.Ptr
    MdlSize : Int16
    MdlFlags : Int16
    Process : IntPtr
    lpMappedSystemVa : UInt32.Ptr
    lpStartVa : UInt32.Ptr
    ByteCount : UInt32
    ByteOffset : UInt32
}
struct DDSURFACEDATA {
    ddsCaps : UInt32
    dwSurfaceOffset : UInt32
    fpLockPtr : IntPtr
    dwWidth : UInt32
    dwHeight : UInt32
    lPitch : Int32
    dwOverlayFlags : UInt32
    dwOverlayOffset : UInt32
    dwOverlaySrcWidth : UInt32
    dwOverlaySrcHeight : UInt32
    dwOverlayDestWidth : UInt32
    dwOverlayDestHeight : UInt32
    dwVideoPortId : UInt32
    dwFormatFlags : UInt32
    dwFormatFourCC : UInt32
    dwFormatBitCount : UInt32
    dwRBitMask : UInt32
    dwGBitMask : UInt32
    dwBBitMask : UInt32
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
    dwDriverReserved4 : UInt32
}
struct DDVIDEOPORTDATA {
    dwVideoPortId : UInt32
    dwVPFlags : UInt32
    dwOriginOffset : UInt32
    dwHeight : UInt32
    dwVBIHeight : UInt32
    dwDriverReserved1 : UInt32
    dwDriverReserved2 : UInt32
    dwDriverReserved3 : UInt32
}
struct DX_IRQDATA {
    dwIrqFlags : UInt32
}
struct PDX_IRQCALLBACK extends FunctionPointer {
    static Types := [DX_IRQDATA.Ptr, "Void"]
}
struct DDGETIRQINFO {
    dwFlags : UInt32
}
struct DDENABLEIRQINFO {
    dwIRQSources : UInt32
    dwLine : UInt32
    IRQCallback : PDX_IRQCALLBACK
    lpIRQData : DX_IRQDATA.Ptr
}
struct DDSKIPNEXTFIELDINFO {
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
    dwSkipFlags : UInt32
}
struct DDBOBNEXTFIELDINFO {
    lpSurface : DDSURFACEDATA.Ptr
}
struct DDSETSTATEININFO {
    lpSurfaceData : DDSURFACEDATA.Ptr
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
}
struct DDSETSTATEOUTINFO {
    bSoftwareAutoflip : BOOL
    dwSurfaceIndex : UInt32
    dwVBISurfaceIndex : UInt32
}
struct DDLOCKININFO {
    lpSurfaceData : DDSURFACEDATA.Ptr
}
struct DDLOCKOUTINFO {
    dwSurfacePtr : IntPtr
}
struct DDFLIPOVERLAYINFO {
    lpCurrentSurface : DDSURFACEDATA.Ptr
    lpTargetSurface : DDSURFACEDATA.Ptr
    dwFlags : UInt32
}
struct DDFLIPVIDEOPORTINFO {
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
    lpCurrentSurface : DDSURFACEDATA.Ptr
    lpTargetSurface : DDSURFACEDATA.Ptr
    dwFlipVPFlags : UInt32
}
struct DDGETPOLARITYININFO {
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
}
struct DDGETPOLARITYOUTINFO {
    bPolarity : UInt32
}
struct DDGETCURRENTAUTOFLIPININFO {
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
}
struct DDGETCURRENTAUTOFLIPOUTINFO {
    dwSurfaceIndex : UInt32
    dwVBISurfaceIndex : UInt32
}
struct DDGETPREVIOUSAUTOFLIPININFO {
    lpVideoPortData : DDVIDEOPORTDATA.Ptr
}
struct DDGETPREVIOUSAUTOFLIPOUTINFO {
    dwSurfaceIndex : UInt32
    dwVBISurfaceIndex : UInt32
}
struct DDTRANSFERININFO {
    lpSurfaceData : DDSURFACEDATA.Ptr
    dwStartLine : UInt32
    dwEndLine : UInt32
    dwTransferID : IntPtr
    dwTransferFlags : UInt32
    lpDestMDL : DDMDL.Ptr
}
struct DDTRANSFEROUTINFO {
    dwBufferPolarity : UInt32
}
struct DDGETTRANSFERSTATUSOUTINFO {
    dwTransferID : IntPtr
}
struct PDX_GETIRQINFO extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, DDGETIRQINFO.Ptr, UInt32]
}
struct PDX_ENABLEIRQ extends FunctionPointer {
    static Types := [Struct.Ptr, DDENABLEIRQINFO.Ptr, Struct.Ptr, UInt32]
}
struct PDX_SKIPNEXTFIELD extends FunctionPointer {
    static Types := [Struct.Ptr, DDSKIPNEXTFIELDINFO.Ptr, Struct.Ptr, UInt32]
}
struct PDX_BOBNEXTFIELD extends FunctionPointer {
    static Types := [Struct.Ptr, DDBOBNEXTFIELDINFO.Ptr, Struct.Ptr, UInt32]
}
struct PDX_SETSTATE extends FunctionPointer {
    static Types := [Struct.Ptr, DDSETSTATEININFO.Ptr, DDSETSTATEOUTINFO.Ptr, UInt32]
}
struct PDX_LOCK extends FunctionPointer {
    static Types := [Struct.Ptr, DDLOCKININFO.Ptr, DDLOCKOUTINFO.Ptr, UInt32]
}
struct PDX_FLIPOVERLAY extends FunctionPointer {
    static Types := [Struct.Ptr, DDFLIPOVERLAYINFO.Ptr, Struct.Ptr, UInt32]
}
struct PDX_FLIPVIDEOPORT extends FunctionPointer {
    static Types := [Struct.Ptr, DDFLIPVIDEOPORTINFO.Ptr, Struct.Ptr, UInt32]
}
struct PDX_GETPOLARITY extends FunctionPointer {
    static Types := [Struct.Ptr, DDGETPOLARITYININFO.Ptr, DDGETPOLARITYOUTINFO.Ptr, UInt32]
}
struct PDX_GETCURRENTAUTOFLIP extends FunctionPointer {
    static Types := [Struct.Ptr, DDGETCURRENTAUTOFLIPININFO.Ptr, DDGETCURRENTAUTOFLIPOUTINFO.Ptr, UInt32]
}
struct PDX_GETPREVIOUSAUTOFLIP extends FunctionPointer {
    static Types := [Struct.Ptr, DDGETPREVIOUSAUTOFLIPININFO.Ptr, DDGETPREVIOUSAUTOFLIPOUTINFO.Ptr, UInt32]
}
struct PDX_TRANSFER extends FunctionPointer {
    static Types := [Struct.Ptr, DDTRANSFERININFO.Ptr, DDTRANSFEROUTINFO.Ptr, UInt32]
}
struct PDX_GETTRANSFERSTATUS extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, DDGETTRANSFERSTATUSOUTINFO.Ptr, UInt32]
}
struct DXAPI_INTERFACE {
    Size : UInt16
    Version : UInt16
    Context : Struct.Ptr
    InterfaceReference : Struct.Ptr
    InterfaceDereference : Struct.Ptr
    DxGetIrqInfo : PDX_GETIRQINFO
    DxEnableIrq : PDX_ENABLEIRQ
    DxSkipNextField : PDX_SKIPNEXTFIELD
    DxBobNextField : PDX_BOBNEXTFIELD
    DxSetState : PDX_SETSTATE
    DxLock : PDX_LOCK
    DxFlipOverlay : PDX_FLIPOVERLAY
    DxFlipVideoPort : PDX_FLIPVIDEOPORT
    DxGetPolarity : PDX_GETPOLARITY
    DxGetCurrentAutoflip : PDX_GETCURRENTAUTOFLIP
    DxGetPreviousAutoflip : PDX_GETPREVIOUSAUTOFLIP
    DxTransfer : PDX_TRANSFER
    DxGetTransferStatus : PDX_GETTRANSFERSTATUS
}
