#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, HANDLE, HRESULT, HWND, LUID, NTSTATUS, POINTL, PWSTR, RECT, RECTL, SIZE}
#Import "..\Graphics.DirectDraw\Types.ahk" {DD_CALLBACKS, DD_DIRECTDRAW_GLOBAL, DD_HALINFO, DD_PALETTECALLBACKS, DD_SURFACECALLBACKS, DD_SURFACE_LOCAL, VIDEOMEMORY}
#Import "..\Graphics.Gdi\Types.ahk" {BLENDFUNCTION, COLORADJUSTMENT, DESIGNVECTOR, DEVMODEW, DISPLAYCONFIG_ADVANCED_COLOR_MODE, DISPLAYCONFIG_COLOR_ENCODING, HBITMAP, HDC, HPALETTE, LOGFONTW, PANOSE, TRIVERTEX, TTPOLYGONHEADER}
#Import "..\Graphics.OpenGL\Types.ahk" {PIXELFORMATDESCRIPTOR}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Console\Types.ahk" {CHAR_INFO, COORD}
#Import "..\UI.ColorSystem\Types.ahk" {LOGCOLORSPACEW}

struct SET_DISPLAY_CONFIG_FLAGS extends UInt32 {
    static SDC_USE_DATABASE_CURRENT := 15
    static SDC_TOPOLOGY_INTERNAL := 1
    static SDC_TOPOLOGY_CLONE := 2
    static SDC_TOPOLOGY_EXTEND := 4
    static SDC_TOPOLOGY_EXTERNAL := 8
    static SDC_TOPOLOGY_SUPPLIED := 16
    static SDC_USE_SUPPLIED_DISPLAY_CONFIG := 32
    static SDC_VALIDATE := 64
    static SDC_APPLY := 128
    static SDC_NO_OPTIMIZATION := 256
    static SDC_SAVE_TO_DATABASE := 512
    static SDC_ALLOW_CHANGES := 1024
    static SDC_PATH_PERSIST_IF_REQUIRED := 2048
    static SDC_FORCE_MODE_ENUMERATION := 4096
    static SDC_ALLOW_PATH_ORDER_CHANGES := 8192
    static SDC_VIRTUAL_MODE_AWARE := 32768
    static SDC_VIRTUAL_REFRESH_RATE_AWARE := 131072
}
struct QUERY_DISPLAY_CONFIG_FLAGS extends UInt32 {
    static QDC_ALL_PATHS := 1
    static QDC_ONLY_ACTIVE_PATHS := 2
    static QDC_DATABASE_CURRENT := 4
    static QDC_VIRTUAL_MODE_AWARE := 16
    static QDC_INCLUDE_HMD := 32
    static QDC_VIRTUAL_REFRESH_RATE_AWARE := 64
}
struct HSEMAPHORE {
    Value : IntPtr
}
struct HSURF {
    Value : IntPtr
}
struct HFASTMUTEX {
    Value : IntPtr
}
struct HDRVOBJ {
    Value : IntPtr
}
struct HDEV {
    Value : IntPtr
}
struct HBM {
    Value : IntPtr
}
struct DHSURF {
    Value : Struct.Ptr
}
struct DHPDEV {
    Value : Struct.Ptr
}
struct DISPLAYCONFIG_RATIONAL {
    Numerator : UInt32
    Denominator : UInt32
}
struct DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY extends Int32 {
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_OTHER := -1
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HD15 := 0
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SVIDEO := 1
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPOSITE_VIDEO := 2
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPONENT_VIDEO := 3
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DVI := 4
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HDMI := 5
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_LVDS := 6
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_D_JPN := 8
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDI := 9
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EXTERNAL := 10
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EMBEDDED := 11
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EXTERNAL := 12
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EMBEDDED := 13
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDTVDONGLE := 14
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_MIRACAST := 15
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_WIRED := 16
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_VIRTUAL := 17
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_USB_TUNNEL := 18
    static DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INTERNAL := -2147483648
}
struct DISPLAYCONFIG_SCANLINE_ORDERING extends Int32 {
    static DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED := 0
    static DISPLAYCONFIG_SCANLINE_ORDERING_PROGRESSIVE := 1
    static DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED := 2
    static DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_UPPERFIELDFIRST := 2
    static DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_LOWERFIELDFIRST := 3
}
struct DISPLAYCONFIG_2DREGION {
    cx : UInt32
    cy : UInt32
}
struct DISPLAYCONFIG_VIDEO_SIGNAL_INFO {
    pixelRate : Int64
    hSyncFreq : DISPLAYCONFIG_RATIONAL
    vSyncFreq : DISPLAYCONFIG_RATIONAL
    activeSize : DISPLAYCONFIG_2DREGION
    totalSize : DISPLAYCONFIG_2DREGION
    Anonymous : this._Anonymous_e__Union
    scanLineOrdering : DISPLAYCONFIG_SCANLINE_ORDERING
    struct _Anonymous_e__Union {
        union {
            AdditionalSignalInfo : this._AdditionalSignalInfo_e__Struct
            videoStandard : UInt32
        }
        struct _AdditionalSignalInfo_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SCALING extends Int32 {
    static DISPLAYCONFIG_SCALING_IDENTITY := 1
    static DISPLAYCONFIG_SCALING_CENTERED := 2
    static DISPLAYCONFIG_SCALING_STRETCHED := 3
    static DISPLAYCONFIG_SCALING_ASPECTRATIOCENTEREDMAX := 4
    static DISPLAYCONFIG_SCALING_CUSTOM := 5
    static DISPLAYCONFIG_SCALING_PREFERRED := 128
}
struct DISPLAYCONFIG_ROTATION extends Int32 {
    static DISPLAYCONFIG_ROTATION_IDENTITY := 1
    static DISPLAYCONFIG_ROTATION_ROTATE90 := 2
    static DISPLAYCONFIG_ROTATION_ROTATE180 := 3
    static DISPLAYCONFIG_ROTATION_ROTATE270 := 4
}
struct DISPLAYCONFIG_MODE_INFO_TYPE extends Int32 {
    static DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE := 1
    static DISPLAYCONFIG_MODE_INFO_TYPE_TARGET := 2
    static DISPLAYCONFIG_MODE_INFO_TYPE_DESKTOP_IMAGE := 3
}
struct DISPLAYCONFIG_PIXELFORMAT extends Int32 {
    static DISPLAYCONFIG_PIXELFORMAT_8BPP := 1
    static DISPLAYCONFIG_PIXELFORMAT_16BPP := 2
    static DISPLAYCONFIG_PIXELFORMAT_24BPP := 3
    static DISPLAYCONFIG_PIXELFORMAT_32BPP := 4
    static DISPLAYCONFIG_PIXELFORMAT_NONGDI := 5
}
struct DISPLAYCONFIG_SOURCE_MODE {
    width : UInt32
    height : UInt32
    pixelFormat : DISPLAYCONFIG_PIXELFORMAT
    position : POINTL
}
struct DISPLAYCONFIG_TARGET_MODE {
    targetVideoSignalInfo : DISPLAYCONFIG_VIDEO_SIGNAL_INFO
}
struct DISPLAYCONFIG_DESKTOP_IMAGE_INFO {
    PathSourceSize : POINTL
    DesktopImageRegion : RECTL
    DesktopImageClip : RECTL
}
struct DISPLAYCONFIG_MODE_INFO {
    infoType : DISPLAYCONFIG_MODE_INFO_TYPE
    id : UInt32
    adapterId : LUID
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            targetMode : DISPLAYCONFIG_TARGET_MODE
            sourceMode : DISPLAYCONFIG_SOURCE_MODE
            desktopImageInfo : DISPLAYCONFIG_DESKTOP_IMAGE_INFO
        }
    }
}
struct DISPLAYCONFIG_PATH_SOURCE_INFO {
    adapterId : LUID
    id : UInt32
    Anonymous : this._Anonymous_e__Union
    statusFlags : UInt32
    struct _Anonymous_e__Union {
        union {
            modeInfoIdx : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_PATH_TARGET_INFO {
    adapterId : LUID
    id : UInt32
    Anonymous : this._Anonymous_e__Union
    outputTechnology : DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
    rotation : DISPLAYCONFIG_ROTATION
    scaling : DISPLAYCONFIG_SCALING
    refreshRate : DISPLAYCONFIG_RATIONAL
    scanLineOrdering : DISPLAYCONFIG_SCANLINE_ORDERING
    targetAvailable : BOOL
    statusFlags : UInt32
    struct _Anonymous_e__Union {
        union {
            modeInfoIdx : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_PATH_INFO {
    sourceInfo : DISPLAYCONFIG_PATH_SOURCE_INFO
    targetInfo : DISPLAYCONFIG_PATH_TARGET_INFO
    flags : UInt32
}
struct DISPLAYCONFIG_TOPOLOGY_ID extends Int32 {
    static DISPLAYCONFIG_TOPOLOGY_INTERNAL := 1
    static DISPLAYCONFIG_TOPOLOGY_CLONE := 2
    static DISPLAYCONFIG_TOPOLOGY_EXTEND := 4
    static DISPLAYCONFIG_TOPOLOGY_EXTERNAL := 8
}
struct DISPLAYCONFIG_DEVICE_INFO_TYPE extends Int32 {
    static DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME := 1
    static DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_NAME := 2
    static DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_PREFERRED_MODE := 3
    static DISPLAYCONFIG_DEVICE_INFO_GET_ADAPTER_NAME := 4
    static DISPLAYCONFIG_DEVICE_INFO_SET_TARGET_PERSISTENCE := 5
    static DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_BASE_TYPE := 6
    static DISPLAYCONFIG_DEVICE_INFO_GET_SUPPORT_VIRTUAL_RESOLUTION := 7
    static DISPLAYCONFIG_DEVICE_INFO_SET_SUPPORT_VIRTUAL_RESOLUTION := 8
    static DISPLAYCONFIG_DEVICE_INFO_GET_ADVANCED_COLOR_INFO := 9
    static DISPLAYCONFIG_DEVICE_INFO_SET_ADVANCED_COLOR_STATE := 10
    static DISPLAYCONFIG_DEVICE_INFO_GET_SDR_WHITE_LEVEL := 11
    static DISPLAYCONFIG_DEVICE_INFO_GET_MONITOR_SPECIALIZATION := 12
    static DISPLAYCONFIG_DEVICE_INFO_SET_MONITOR_SPECIALIZATION := 13
    static DISPLAYCONFIG_DEVICE_INFO_SET_RESERVED1 := 14
    static DISPLAYCONFIG_DEVICE_INFO_GET_ADVANCED_COLOR_INFO_2 := 15
    static DISPLAYCONFIG_DEVICE_INFO_SET_HDR_STATE := 16
    static DISPLAYCONFIG_DEVICE_INFO_SET_WCG_STATE := 17
}
struct DISPLAYCONFIG_DEVICE_INFO_HEADER {
    type : DISPLAYCONFIG_DEVICE_INFO_TYPE
    size : UInt32
    adapterId : LUID
    id : UInt32
}
struct DISPLAYCONFIG_SOURCE_DEVICE_NAME {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    viewGdiDeviceName : UInt16[32]
}
struct DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_TARGET_DEVICE_NAME {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    flags : DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS
    outputTechnology : DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
    edidManufactureId : UInt16
    edidProductCodeId : UInt16
    connectorInstance : UInt32
    monitorFriendlyDeviceName : UInt16[64]
    monitorDevicePath : UInt16[128]
}
struct DISPLAYCONFIG_TARGET_PREFERRED_MODE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    width : UInt32
    height : UInt32
    targetMode : DISPLAYCONFIG_TARGET_MODE
}
struct DISPLAYCONFIG_ADAPTER_NAME {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    adapterDevicePath : UInt16[128]
}
struct DISPLAYCONFIG_TARGET_BASE_TYPE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    baseOutputTechnology : DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
}
struct DISPLAYCONFIG_SET_TARGET_PERSISTENCE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_GET_ADVANCED_COLOR_INFO {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    colorEncoding : DISPLAYCONFIG_COLOR_ENCODING
    bitsPerColorChannel : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SET_ADVANCED_COLOR_STATE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_GET_ADVANCED_COLOR_INFO_2 {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    colorEncoding : DISPLAYCONFIG_COLOR_ENCODING
    bitsPerColorChannel : UInt32
    activeColorMode : DISPLAYCONFIG_ADVANCED_COLOR_MODE
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SET_HDR_STATE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SET_WCG_STATE {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SDR_WHITE_LEVEL {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    SDRWhiteLevel : UInt32
}
struct DISPLAYCONFIG_GET_MONITOR_SPECIALIZATION {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct DISPLAYCONFIG_SET_MONITOR_SPECIALIZATION {
    header : DISPLAYCONFIG_DEVICE_INFO_HEADER
    Anonymous : this._Anonymous_e__Union
    specializationType : GUID
    specializationSubType : GUID
    specializationApplicationName : UInt16[128]
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PHYSICAL_MONITOR {
    hPhysicalMonitor : HANDLE
    szPhysicalMonitorDescription : UInt16[128]
}
struct MC_TIMING_REPORT {
    dwHorizontalFrequencyInHZ : UInt32
    dwVerticalFrequencyInHZ : UInt32
    bTimingStatusByte : UInt8
}
struct MC_VCP_CODE_TYPE extends Int32 {
    static MC_MOMENTARY := 0
    static MC_SET_PARAMETER := 1
}
struct MC_DISPLAY_TECHNOLOGY_TYPE extends Int32 {
    static MC_SHADOW_MASK_CATHODE_RAY_TUBE := 0
    static MC_APERTURE_GRILL_CATHODE_RAY_TUBE := 1
    static MC_THIN_FILM_TRANSISTOR := 2
    static MC_LIQUID_CRYSTAL_ON_SILICON := 3
    static MC_PLASMA := 4
    static MC_ORGANIC_LIGHT_EMITTING_DIODE := 5
    static MC_ELECTROLUMINESCENT := 6
    static MC_MICROELECTROMECHANICAL := 7
    static MC_FIELD_EMISSION_DEVICE := 8
}
struct MC_DRIVE_TYPE extends Int32 {
    static MC_RED_DRIVE := 0
    static MC_GREEN_DRIVE := 1
    static MC_BLUE_DRIVE := 2
}
struct MC_GAIN_TYPE extends Int32 {
    static MC_RED_GAIN := 0
    static MC_GREEN_GAIN := 1
    static MC_BLUE_GAIN := 2
}
struct MC_POSITION_TYPE extends Int32 {
    static MC_HORIZONTAL_POSITION := 0
    static MC_VERTICAL_POSITION := 1
}
struct MC_SIZE_TYPE extends Int32 {
    static MC_WIDTH := 0
    static MC_HEIGHT := 1
}
struct MC_COLOR_TEMPERATURE extends Int32 {
    static MC_COLOR_TEMPERATURE_UNKNOWN := 0
    static MC_COLOR_TEMPERATURE_4000K := 1
    static MC_COLOR_TEMPERATURE_5000K := 2
    static MC_COLOR_TEMPERATURE_6500K := 3
    static MC_COLOR_TEMPERATURE_7500K := 4
    static MC_COLOR_TEMPERATURE_8200K := 5
    static MC_COLOR_TEMPERATURE_9300K := 6
    static MC_COLOR_TEMPERATURE_10000K := 7
    static MC_COLOR_TEMPERATURE_11500K := 8
}
struct Sources {
    sourceId : UInt32
    numTargets : Int32
    aTargets : UInt32[1]
}
struct Adapter {
    AdapterName : UInt16[128]
    numSources : Int32
    sources : Sources[1]
}
struct Adapters {
    numAdapters : Int32
    adapter : Adapter[1]
}
struct DisplayMode {
    DeviceName : UInt16[32]
    devMode : DEVMODEW
}
struct DisplayModes {
    numDisplayModes : Int32
    displayMode : DisplayMode[1]
}
struct ICloneViewHelper extends IUnknown {
    static IID := "{F6A3D4C4-5632-4D83-B0A1-FB88712B1EB7}"
    GetConnectedIDs(wszAdaptorName, pulCount, pulID, ulFlags)
      => ComCall(3, this.p, "Str", wszAdaptorName, UInt32.Ptr, pulCount, UInt32.Ptr, pulID, UInt32, ulFlags)
    GetActiveTopology(wszAdaptorName, ulSourceID, pulCount, pulTargetID)
      => ComCall(4, this.p, "Str", wszAdaptorName, UInt32, ulSourceID, UInt32.Ptr, pulCount, UInt32.Ptr, pulTargetID)
    SetActiveTopology(wszAdaptorName, ulSourceID, ulCount, pulTargetID)
      => ComCall(5, this.p, "Str", wszAdaptorName, UInt32, ulSourceID, UInt32, ulCount, UInt32.Ptr, pulTargetID)
    Commit(fFinalCall)
      => ComCall(6, this.p, BOOL, fFinalCall)
}
struct IViewHelper extends IUnknown {
    static IID := "{E85CCEF5-AAAA-47F0-B5E3-61F7AECDC4C1}"
    GetConnectedIDs(wszAdaptorName, pulCount, pulID, ulFlags)
      => ComCall(3, this.p, "Str", wszAdaptorName, UInt32.Ptr, pulCount, UInt32.Ptr, pulID, UInt32, ulFlags)
    GetActiveTopology(wszAdaptorName, ulSourceID, pulCount, pulTargetID)
      => ComCall(4, this.p, "Str", wszAdaptorName, UInt32, ulSourceID, UInt32.Ptr, pulCount, UInt32.Ptr, pulTargetID)
    SetActiveTopology(wszAdaptorName, ulSourceID, ulCount, pulTargetID)
      => ComCall(5, this.p, "Str", wszAdaptorName, UInt32, ulSourceID, UInt32, ulCount, UInt32.Ptr, pulTargetID)
    Commit()
      => ComCall(6, this.p)
    SetConfiguration(pIStream, pulStatus)
      => ComCall(7, this.p, IStream, pIStream, UInt32.Ptr, pulStatus)
    GetProceedOnNewConfiguration()
      => ComCall(8, this.p)
}
struct VIDEOPARAMETERS {
    Guid : GUID
    dwOffset : UInt32
    dwCommand : UInt32
    dwFlags : UInt32
    dwMode : UInt32
    dwTVStandard : UInt32
    dwAvailableModes : UInt32
    dwAvailableTVStandard : UInt32
    dwFlickerFilter : UInt32
    dwOverScanX : UInt32
    dwOverScanY : UInt32
    dwMaxUnscaledX : UInt32
    dwMaxUnscaledY : UInt32
    dwPositionX : UInt32
    dwPositionY : UInt32
    dwBrightness : UInt32
    dwContrast : UInt32
    dwCPType : UInt32
    dwCPCommand : UInt32
    dwCPStandard : UInt32
    dwCPKey : UInt32
    bCP_APSTriggerBits : UInt32
    bOEMCopyProtection : UInt8[256]
}
struct POINTE {
    x : Float32
    y : Float32
}
struct FLOAT_LONG {
    union {
        e : Float32
        l : Int32
    }
}
struct FD_XFORM {
    eXX : Float32
    eXY : Float32
    eYX : Float32
    eYY : Float32
}
struct IFIMETRICS {
    cjThis : UInt32
    cjIfiExtra : UInt32
    dpwszFamilyName : Int32
    dpwszStyleName : Int32
    dpwszFaceName : Int32
    dpwszUniqueName : Int32
    dpFontSim : Int32
    lEmbedId : Int32
    lItalicAngle : Int32
    lCharBias : Int32
    dpCharSets : Int32
    jWinCharSet : UInt8
    jWinPitchAndFamily : UInt8
    usWinWeight : UInt16
    flInfo : UInt32
    fsSelection : UInt16
    fsType : UInt16
    fwdUnitsPerEm : Int16
    fwdLowestPPEm : Int16
    fwdWinAscender : Int16
    fwdWinDescender : Int16
    fwdMacAscender : Int16
    fwdMacDescender : Int16
    fwdMacLineGap : Int16
    fwdTypoAscender : Int16
    fwdTypoDescender : Int16
    fwdTypoLineGap : Int16
    fwdAveCharWidth : Int16
    fwdMaxCharInc : Int16
    fwdCapHeight : Int16
    fwdXHeight : Int16
    fwdSubscriptXSize : Int16
    fwdSubscriptYSize : Int16
    fwdSubscriptXOffset : Int16
    fwdSubscriptYOffset : Int16
    fwdSuperscriptXSize : Int16
    fwdSuperscriptYSize : Int16
    fwdSuperscriptXOffset : Int16
    fwdSuperscriptYOffset : Int16
    fwdUnderscoreSize : Int16
    fwdUnderscorePosition : Int16
    fwdStrikeoutSize : Int16
    fwdStrikeoutPosition : Int16
    chFirstChar : UInt8
    chLastChar : UInt8
    chDefaultChar : UInt8
    chBreakChar : UInt8
    wcFirstChar : UInt16
    wcLastChar : UInt16
    wcDefaultChar : UInt16
    wcBreakChar : UInt16
    ptlBaseline : POINTL
    ptlAspect : POINTL
    ptlCaret : POINTL
    rclFontBox : RECTL
    achVendId : UInt8[4]
    cKerningPairs : UInt32
    ulPanoseCulture : UInt32
    panose : PANOSE
    Align : Struct.Ptr
}
struct LINEATTRS {
    fl : UInt32
    iJoin : UInt32
    iEndCap : UInt32
    elWidth : FLOAT_LONG
    eMiterLimit : Float32
    cstyle : UInt32
    pstyle : FLOAT_LONG.Ptr
    elStyleState : FLOAT_LONG
}
struct XFORML {
    eM11 : Float32
    eM12 : Float32
    eM21 : Float32
    eM22 : Float32
    eDx : Float32
    eDy : Float32
}
struct FLOATOBJ_XFORM {
    eM11 : Float32
    eM12 : Float32
    eM21 : Float32
    eM22 : Float32
    eDx : Float32
    eDy : Float32
}
struct POINTFIX {
    x : Int32
    y : Int32
}
struct RECTFX {
    xLeft : Int32
    yTop : Int32
    xRight : Int32
    yBottom : Int32
}
struct FD_DEVICEMETRICS {
    flRealizedType : UInt32
    pteBase : POINTE
    pteSide : POINTE
    lD : Int32
    fxMaxAscender : Int32
    fxMaxDescender : Int32
    ptlUnderline1 : POINTL
    ptlStrikeOut : POINTL
    ptlULThickness : POINTL
    ptlSOThickness : POINTL
    cxMax : UInt32
    cyMax : UInt32
    cjGlyphMax : UInt32
    fdxQuantized : FD_XFORM
    lNonLinearExtLeading : Int32
    lNonLinearIntLeading : Int32
    lNonLinearMaxCharWidth : Int32
    lNonLinearAvgCharWidth : Int32
    lMinA : Int32
    lMinC : Int32
    lMinD : Int32
    alReserved : Int32[1]
}
struct LIGATURE {
    culSize : UInt32
    pwsz : PWSTR
    chglyph : UInt32
    ahglyph : UInt32[1]
}
struct FD_LIGATURE {
    culThis : UInt32
    ulType : UInt32
    cLigatures : UInt32
    alig : LIGATURE[1]
}
struct POINTQF {
    x : Int64
    y : Int64
}
struct WCRUN {
    wcLow : UInt16
    cGlyphs : UInt16
    phg : UInt32.Ptr
}
struct FD_GLYPHSET {
    cjThis : UInt32
    flAccel : UInt32
    cGlyphsSupported : UInt32
    cRuns : UInt32
    awcrun : WCRUN[1]
}
struct FD_GLYPHATTR {
    cjThis : UInt32
    cGlyphs : UInt32
    iMode : UInt32
    aGlyphAttr : UInt8[1]
}
struct FD_KERNINGPAIR {
    wcFirst : UInt16
    wcSecond : UInt16
    fwdKern : Int16
}
struct FONTDIFF {
    jReserved1 : UInt8
    jReserved2 : UInt8
    jReserved3 : UInt8
    bWeight : UInt8
    usWinWeight : UInt16
    fsSelection : UInt16
    fwdAveCharWidth : Int16
    fwdMaxCharInc : Int16
    ptlCaret : POINTL
}
struct FONTSIM {
    dpBold : Int32
    dpItalic : Int32
    dpBoldItalic : Int32
}
struct IFIEXTRA {
    ulIdentifier : UInt32
    dpFontSig : Int32
    cig : UInt32
    dpDesignVector : Int32
    dpAxesInfoW : Int32
    aulReserved : UInt32[1]
}
struct PFN extends FunctionPointer {
    static Types := [IntPtr]
}
struct DRVFN {
    iFunc : UInt32
    pfn : PFN
}
struct DRVENABLEDATA {
    iDriverVersion : UInt32
    c : UInt32
    pdrvfn : DRVFN.Ptr
}
struct DEVINFO {
    flGraphicsCaps : UInt32
    lfDefaultFont : LOGFONTW
    lfAnsiVarFont : LOGFONTW
    lfAnsiFixFont : LOGFONTW
    cFonts : UInt32
    iDitherFormat : UInt32
    cxDither : UInt16
    cyDither : UInt16
    hpalDefault : HPALETTE
    flGraphicsCaps2 : UInt32
}
struct CIECHROMA {
    x : Int32
    y_1 : Int32
    Y_2 : Int32
}
struct COLORINFO {
    Red : CIECHROMA
    Green : CIECHROMA
    Blue : CIECHROMA
    Cyan : CIECHROMA
    Magenta : CIECHROMA
    Yellow : CIECHROMA
    AlignmentWhite : CIECHROMA
    RedGamma : Int32
    GreenGamma : Int32
    BlueGamma : Int32
    MagentaInCyanDye : Int32
    YellowInCyanDye : Int32
    CyanInMagentaDye : Int32
    YellowInMagentaDye : Int32
    CyanInYellowDye : Int32
    MagentaInYellowDye : Int32
}
struct CDDDXGK_REDIRBITMAPPRESENTINFO {
    NumDirtyRects : UInt32
    DirtyRect : RECT.Ptr
    NumContexts : UInt32
    hContext : HANDLE[65]
    bDoNotSynchronizeWithDxContent : BOOLEAN
}
struct GDIINFO {
    ulVersion : UInt32
    ulTechnology : UInt32
    ulHorzSize : UInt32
    ulVertSize : UInt32
    ulHorzRes : UInt32
    ulVertRes : UInt32
    cBitsPixel : UInt32
    cPlanes : UInt32
    ulNumColors : UInt32
    flRaster : UInt32
    ulLogPixelsX : UInt32
    ulLogPixelsY : UInt32
    flTextCaps : UInt32
    ulDACRed : UInt32
    ulDACGreen : UInt32
    ulDACBlue : UInt32
    ulAspectX : UInt32
    ulAspectY : UInt32
    ulAspectXY : UInt32
    xStyleStep : Int32
    yStyleStep : Int32
    denStyleStep : Int32
    ptlPhysOffset : POINTL
    szlPhysSize : SIZE
    ulNumPalReg : UInt32
    ciDevice : COLORINFO
    ulDevicePelsDPI : UInt32
    ulPrimaryOrder : UInt32
    ulHTPatternSize : UInt32
    ulHTOutputFormat : UInt32
    flHTFlags : UInt32
    ulVRefresh : UInt32
    ulBltAlignment : UInt32
    ulPanningHorzRes : UInt32
    ulPanningVertRes : UInt32
    xPanningAlignment : UInt32
    yPanningAlignment : UInt32
    cxHTPat : UInt32
    cyHTPat : UInt32
    pHTPatA : UInt8.Ptr
    pHTPatB : UInt8.Ptr
    pHTPatC : UInt8.Ptr
    flShadeBlend : UInt32
    ulPhysicalPixelCharacteristics : UInt32
    ulPhysicalPixelGamma : UInt32
}
struct BRUSHOBJ {
    iSolidColor : UInt32
    pvRbrush : Struct.Ptr
    flColorType : UInt32
}
struct CLIPOBJ {
    iUniq : UInt32
    rclBounds : RECTL
    iDComplexity : UInt8
    iFComplexity : UInt8
    iMode : UInt8
    fjOptions : UInt8
}
struct FREEOBJPROC extends FunctionPointer {
    static Types := [DRIVEROBJ.Ptr, BOOL]
}
struct DRIVEROBJ {
    pvObj : Struct.Ptr
    pFreeProc : FREEOBJPROC
    hdev : HDEV
    dhpdev : DHPDEV
}
struct FONTOBJ {
    iUniq : UInt32
    iFace : UInt32
    cxMax : UInt32
    flFontType : UInt32
    iTTUniq : IntPtr
    iFile : IntPtr
    sizLogResPpi : SIZE
    ulStyleSize : UInt32
    pvConsumer : Struct.Ptr
    pvProducer : Struct.Ptr
}
struct BLENDOBJ {
    BlendFunction : BLENDFUNCTION
}
struct PALOBJ {
    ulReserved : UInt32
}
struct PATHOBJ {
    fl : UInt32
    cCurves : UInt32
}
struct SURFOBJ {
    dhsurf : DHSURF
    hsurf : HSURF
    dhpdev : DHPDEV
    hdev : HDEV
    sizlBitmap : SIZE
    cjBits : UInt32
    pvBits : Struct.Ptr
    pvScan0 : Struct.Ptr
    lDelta : Int32
    iUniq : UInt32
    iBitmapFormat : UInt32
    iType : UInt16
    fjBitmap : UInt16
}
struct WNDOBJ {
    coClient : CLIPOBJ
    pvConsumer : Struct.Ptr
    rclClient : RECTL
    psoOwner : SURFOBJ.Ptr
}
struct XFORMOBJ {
    ulReserved : UInt32
}
struct XLATEOBJ {
    iUniq : UInt32
    flXlate : UInt32
    iSrcType : UInt16
    iDstType : UInt16
    cEntries : UInt32
    pulXlate : UInt32.Ptr
}
struct ENUMRECTS {
    c : UInt32
    arcl : RECTL[1]
}
struct GLYPHBITS {
    ptlOrigin : POINTL
    sizlBitmap : SIZE
    aj : UInt8[1]
}
struct GLYPHDEF {
    union {
        pgb : GLYPHBITS.Ptr
        ppo : PATHOBJ.Ptr
    }
}
struct GLYPHPOS {
    hg : UInt32
    pgdf : GLYPHDEF.Ptr
    ptl : POINTL
}
struct GLYPHDATA {
    gdf : GLYPHDEF
    hg : UInt32
    fxD : Int32
    fxA : Int32
    fxAB : Int32
    fxInkTop : Int32
    fxInkBottom : Int32
    rclInk : RECTL
    ptqD : POINTQF
}
struct STROBJ {
    cGlyphs : UInt32
    flAccel : UInt32
    ulCharInc : UInt32
    rclBkGround : RECTL
    pgp : GLYPHPOS.Ptr
    pwszOrg : PWSTR
}
struct FONTINFO {
    cjThis : UInt32
    flCaps : UInt32
    cGlyphsSupported : UInt32
    cjMaxGlyph1 : UInt32
    cjMaxGlyph4 : UInt32
    cjMaxGlyph8 : UInt32
    cjMaxGlyph32 : UInt32
}
struct PATHDATA {
    flags : UInt32
    count : UInt32
    pptfx : POINTFIX.Ptr
}
struct RUN {
    iStart : Int32
    iStop : Int32
}
struct CLIPLINE {
    ptfxA : POINTFIX
    ptfxB : POINTFIX
    lStyleState : Int32
    c : UInt32
    arun : RUN[1]
}
struct PERBANDINFO {
    bRepeatThisBand : BOOL
    szlBand : SIZE
    ulHorzRes : UInt32
    ulVertRes : UInt32
}
struct GAMMARAMP {
    Red : UInt16[256]
    Green : UInt16[256]
    Blue : UInt16[256]
}
struct WNDOBJCHANGEPROC extends FunctionPointer {
    static Types := [WNDOBJ.Ptr, UInt32, "Void"]
}
struct DEVHTINFO {
    HTFlags : UInt32
    HTPatternSize : UInt32
    DevPelsDPI : UInt32
    ColorInfo : COLORINFO
}
struct DEVHTADJDATA {
    DeviceFlags : UInt32
    DeviceXDPI : UInt32
    DeviceYDPI : UInt32
    pDefHTInfo : DEVHTINFO.Ptr
    pAdjHTInfo : DEVHTINFO.Ptr
}
struct TYPE1_FONT {
    hPFM : HANDLE
    hPFB : HANDLE
    ulIdentifier : UInt32
}
struct ENGSAFESEMAPHORE {
    hsem : HSEMAPHORE
    lCount : Int32
}
struct SORTCOMP extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, Int32]
    static Options := "C"
}
struct ENG_TIME_FIELDS {
    usYear : UInt16
    usMonth : UInt16
    usDay : UInt16
    usHour : UInt16
    usMinute : UInt16
    usSecond : UInt16
    usMilliseconds : UInt16
    usWeekday : UInt16
}
struct ENG_SYSTEM_ATTRIBUTE extends Int32 {
    static EngProcessorFeature := 1
    static EngNumberOfProcessors := 2
    static EngOptimumAvailableUserMemory := 3
    static EngOptimumAvailableSystemMemory := 4
}
struct ENG_DEVICE_ATTRIBUTE extends Int32 {
    static QDA_RESERVED := 0
    static QDA_ACCELERATION_LEVEL := 1
}
struct EMFINFO {
    nSize : UInt32
    hdc : HDC
    pvEMF : UInt8.Ptr
    pvCurrentRecord : UInt8.Ptr
}
struct PFN_DrvEnableDriver extends FunctionPointer {
    static Types := [UInt32, UInt32, DRVENABLEDATA.Ptr, BOOL]
}
struct PFN_DrvEnablePDEV extends FunctionPointer {
    static Types := [DEVMODEW.Ptr, PWSTR, UInt32, HSURF.Ptr, UInt32, GDIINFO.Ptr, UInt32, DEVINFO.Ptr, HDEV, PWSTR, HANDLE, DHPDEV]
}
struct PFN_DrvCompletePDEV extends FunctionPointer {
    static Types := [DHPDEV, HDEV, "Void"]
}
struct PFN_DrvResetDevice extends FunctionPointer {
    static Types := [DHPDEV, Struct.Ptr, UInt32]
}
struct PFN_DrvDisablePDEV extends FunctionPointer {
    static Types := [DHPDEV, "Void"]
}
struct PFN_DrvSynchronize extends FunctionPointer {
    static Types := [DHPDEV, RECTL.Ptr, "Void"]
}
struct PFN_DrvEnableSurface extends FunctionPointer {
    static Types := [DHPDEV, HSURF]
}
struct PFN_DrvDisableDriver extends FunctionPointer {
    static Types := ["Void"]
}
struct PFN_DrvDisableSurface extends FunctionPointer {
    static Types := [DHPDEV, "Void"]
}
struct PFN_DrvAssertMode extends FunctionPointer {
    static Types := [DHPDEV, BOOL, BOOL]
}
struct PFN_DrvTextOut extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, STROBJ.Ptr, FONTOBJ.Ptr, CLIPOBJ.Ptr, RECTL.Ptr, RECTL.Ptr, BRUSHOBJ.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvStretchBlt extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, COLORADJUSTMENT.Ptr, POINTL.Ptr, RECTL.Ptr, RECTL.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvStretchBltROP extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, COLORADJUSTMENT.Ptr, POINTL.Ptr, RECTL.Ptr, RECTL.Ptr, POINTL.Ptr, UInt32, BRUSHOBJ.Ptr, UInt32, BOOL]
}
struct PFN_DrvTransparentBlt extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, RECTL.Ptr, RECTL.Ptr, UInt32, UInt32, BOOL]
}
struct PFN_DrvPlgBlt extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, COLORADJUSTMENT.Ptr, POINTL.Ptr, POINTFIX.Ptr, RECTL.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvBitBlt extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, RECTL.Ptr, POINTL.Ptr, POINTL.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvRealizeBrush extends FunctionPointer {
    static Types := [BRUSHOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, XLATEOBJ.Ptr, UInt32, BOOL]
}
struct PFN_DrvCopyBits extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, RECTL.Ptr, POINTL.Ptr, BOOL]
}
struct PFN_DrvDitherColor extends FunctionPointer {
    static Types := [DHPDEV, UInt32, UInt32, UInt32.Ptr, UInt32]
}
struct PFN_DrvCreateDeviceBitmap extends FunctionPointer {
    static Types := [DHPDEV, SIZE, UInt32, HBITMAP]
}
struct PFN_DrvDeleteDeviceBitmap extends FunctionPointer {
    static Types := [DHSURF, "Void"]
}
struct PFN_DrvSetPalette extends FunctionPointer {
    static Types := [DHPDEV, PALOBJ.Ptr, UInt32, UInt32, UInt32, BOOL]
}
struct PFN_DrvEscape extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, UInt32, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct PFN_DrvDrawEscape extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, UInt32, CLIPOBJ.Ptr, RECTL.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct PFN_DrvQueryFont extends FunctionPointer {
    static Types := [DHPDEV, IntPtr, UInt32, IntPtr.Ptr, IFIMETRICS.Ptr]
}
struct PFN_DrvQueryFontTree extends FunctionPointer {
    static Types := [DHPDEV, IntPtr, UInt32, UInt32, IntPtr.Ptr, Struct.Ptr]
}
struct PFN_DrvQueryFontData extends FunctionPointer {
    static Types := [DHPDEV, FONTOBJ.Ptr, UInt32, UInt32, GLYPHDATA.Ptr, Struct.Ptr, UInt32, Int32]
}
struct PFN_DrvFree extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, "Void"]
}
struct PFN_DrvDestroyFont extends FunctionPointer {
    static Types := [FONTOBJ.Ptr, "Void"]
}
struct PFN_DrvQueryFontCaps extends FunctionPointer {
    static Types := [UInt32, UInt32.Ptr, Int32]
}
struct PFN_DrvLoadFontFile extends FunctionPointer {
    static Types := [UInt32, IntPtr.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, DESIGNVECTOR.Ptr, UInt32, UInt32, IntPtr]
}
struct PFN_DrvUnloadFontFile extends FunctionPointer {
    static Types := [IntPtr, BOOL]
}
struct PFN_DrvSetPointerShape extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, SURFOBJ.Ptr, XLATEOBJ.Ptr, Int32, Int32, Int32, Int32, RECTL.Ptr, UInt32, UInt32]
}
struct PFN_DrvMovePointer extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, Int32, Int32, RECTL.Ptr, "Void"]
}
struct PFN_DrvSendPage extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, BOOL]
}
struct PFN_DrvStartPage extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, BOOL]
}
struct PFN_DrvStartDoc extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, PWSTR, UInt32, BOOL]
}
struct PFN_DrvEndDoc extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, UInt32, BOOL]
}
struct PFN_DrvQuerySpoolType extends FunctionPointer {
    static Types := [DHPDEV, PWSTR, BOOL]
}
struct PFN_DrvLineTo extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, CLIPOBJ.Ptr, BRUSHOBJ.Ptr, Int32, Int32, Int32, Int32, RECTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvStrokePath extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, PATHOBJ.Ptr, CLIPOBJ.Ptr, XFORMOBJ.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, LINEATTRS.Ptr, UInt32, BOOL]
}
struct PFN_DrvFillPath extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, PATHOBJ.Ptr, CLIPOBJ.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, UInt32, UInt32, BOOL]
}
struct PFN_DrvStrokeAndFillPath extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, PATHOBJ.Ptr, CLIPOBJ.Ptr, XFORMOBJ.Ptr, BRUSHOBJ.Ptr, LINEATTRS.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, UInt32, UInt32, BOOL]
}
struct PFN_DrvPaint extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, CLIPOBJ.Ptr, BRUSHOBJ.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvGetGlyphMode extends FunctionPointer {
    static Types := [DHPDEV, FONTOBJ.Ptr, UInt32]
}
struct PFN_DrvResetPDEV extends FunctionPointer {
    static Types := [DHPDEV, DHPDEV, BOOL]
}
struct PFN_DrvSaveScreenBits extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, UInt32, IntPtr, RECTL.Ptr, IntPtr]
}
struct PFN_DrvGetModes extends FunctionPointer {
    static Types := [HANDLE, UInt32, DEVMODEW.Ptr, UInt32]
}
struct PFN_DrvQueryTrueTypeTable extends FunctionPointer {
    static Types := [IntPtr, UInt32, UInt32, Int32, UInt32, UInt8.Ptr, UInt8.Ptr.Ptr, UInt32.Ptr, Int32]
}
struct PFN_DrvQueryTrueTypeSection extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, HANDLE.Ptr, Int32.Ptr, Int32]
}
struct PFN_DrvQueryTrueTypeOutline extends FunctionPointer {
    static Types := [DHPDEV, FONTOBJ.Ptr, UInt32, BOOL, GLYPHDATA.Ptr, UInt32, TTPOLYGONHEADER.Ptr, Int32]
}
struct PFN_DrvGetTrueTypeFile extends FunctionPointer {
    static Types := [IntPtr, UInt32.Ptr, Struct.Ptr]
}
struct PFN_DrvQueryFontFile extends FunctionPointer {
    static Types := [IntPtr, UInt32, UInt32, UInt32.Ptr, Int32]
}
struct PFN_DrvQueryGlyphAttrs extends FunctionPointer {
    static Types := [FONTOBJ.Ptr, UInt32, FD_GLYPHATTR.Ptr]
}
struct PFN_DrvQueryAdvanceWidths extends FunctionPointer {
    static Types := [DHPDEV, FONTOBJ.Ptr, UInt32, UInt32.Ptr, Struct.Ptr, UInt32, BOOL]
}
struct PFN_DrvFontManagement extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, FONTOBJ.Ptr, UInt32, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct PFN_DrvSetPixelFormat extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, Int32, HWND, BOOL]
}
struct PFN_DrvDescribePixelFormat extends FunctionPointer {
    static Types := [DHPDEV, Int32, UInt32, PIXELFORMATDESCRIPTOR.Ptr, Int32]
}
struct PFN_DrvSwapBuffers extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, WNDOBJ.Ptr, BOOL]
}
struct PFN_DrvStartBanding extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, POINTL.Ptr, BOOL]
}
struct PFN_DrvNextBand extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, POINTL.Ptr, BOOL]
}
struct PFN_DrvQueryPerBandInfo extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, PERBANDINFO.Ptr, BOOL]
}
struct PFN_DrvEnableDirectDraw extends FunctionPointer {
    static Types := [DHPDEV, DD_CALLBACKS.Ptr, DD_SURFACECALLBACKS.Ptr, DD_PALETTECALLBACKS.Ptr, BOOL]
}
struct PFN_DrvDisableDirectDraw extends FunctionPointer {
    static Types := [DHPDEV, "Void"]
}
struct PFN_DrvGetDirectDrawInfo extends FunctionPointer {
    static Types := [DHPDEV, DD_HALINFO.Ptr, UInt32.Ptr, VIDEOMEMORY.Ptr, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_DrvIcmCreateColorTransform extends FunctionPointer {
    static Types := [DHPDEV, LOGCOLORSPACEW.Ptr, Struct.Ptr, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32, HANDLE]
}
struct PFN_DrvIcmDeleteColorTransform extends FunctionPointer {
    static Types := [DHPDEV, HANDLE, BOOL]
}
struct PFN_DrvIcmCheckBitmapBits extends FunctionPointer {
    static Types := [DHPDEV, HANDLE, SURFOBJ.Ptr, UInt8.Ptr, BOOL]
}
struct PFN_DrvIcmSetDeviceGammaRamp extends FunctionPointer {
    static Types := [DHPDEV, UInt32, Struct.Ptr, BOOL]
}
struct PFN_DrvAlphaBlend extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, RECTL.Ptr, RECTL.Ptr, BLENDOBJ.Ptr, BOOL]
}
struct PFN_DrvGradientFill extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, CLIPOBJ.Ptr, XLATEOBJ.Ptr, TRIVERTEX.Ptr, UInt32, Struct.Ptr, UInt32, RECTL.Ptr, POINTL.Ptr, UInt32, BOOL]
}
struct PFN_DrvQueryDeviceSupport extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, XLATEOBJ.Ptr, XFORMOBJ.Ptr, UInt32, UInt32, Struct.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct PFN_DrvDeriveSurface extends FunctionPointer {
    static Types := [DD_DIRECTDRAW_GLOBAL.Ptr, DD_SURFACE_LOCAL.Ptr, HBITMAP]
}
struct PFN_DrvSynchronizeSurface extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, RECTL.Ptr, UInt32, "Void"]
}
struct PFN_DrvNotify extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, UInt32, Struct.Ptr, "Void"]
}
struct PFN_DrvRenderHint extends FunctionPointer {
    static Types := [DHPDEV, UInt32, IntPtr, Struct.Ptr, Int32]
}
struct DRH_APIBITMAPDATA {
    pso : SURFOBJ.Ptr
    b : BOOL
}
struct PFN_DrvCreateDeviceBitmapEx extends FunctionPointer {
    static Types := [DHPDEV, SIZE, UInt32, UInt32, DHSURF, UInt32, UInt32, HANDLE.Ptr, HBITMAP]
}
struct PFN_DrvDeleteDeviceBitmapEx extends FunctionPointer {
    static Types := [DHSURF, "Void"]
}
struct PFN_DrvAssociateSharedSurface extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, HANDLE, HANDLE, SIZE, BOOL]
}
struct PFN_DrvSynchronizeRedirectionBitmaps extends FunctionPointer {
    static Types := [DHPDEV, Int64.Ptr, NTSTATUS]
}
struct PFN_DrvAccumulateD3DDirtyRect extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, CDDDXGK_REDIRBITMAPPRESENTINFO.Ptr, BOOL]
}
struct PFN_DrvStartDxInterop extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, BOOL, Struct.Ptr, BOOL]
}
struct PFN_DrvEndDxInterop extends FunctionPointer {
    static Types := [SURFOBJ.Ptr, BOOL, BOOL.Ptr, Struct.Ptr, BOOL]
}
struct PFN_DrvLockDisplayArea extends FunctionPointer {
    static Types := [DHPDEV, RECTL.Ptr, "Void"]
}
struct PFN_DrvUnlockDisplayArea extends FunctionPointer {
    static Types := [DHPDEV, RECTL.Ptr, "Void"]
}
struct PFN_DrvSurfaceComplete extends FunctionPointer {
    static Types := [DHPDEV, HANDLE, BOOL]
}
struct INDIRECT_DISPLAY_INFO {
    DisplayAdapterLuid : LUID
    Flags : UInt32
    NumMonitors : UInt32
    DisplayAdapterTargetBase : UInt32
    DriverVersionMajor : UInt32
    DriverVersionMinor : UInt32
}
struct VIDEO_VDM {
    ProcessHandle : HANDLE
}
struct VIDEO_REGISTER_VDM {
    MinimumStateSize : UInt32
}
struct VIDEO_MONITOR_DESCRIPTOR {
    DescriptorSize : UInt32
    Descriptor : UInt8[1]
}
struct VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE extends Int32 {
    static VideoPowerNotifyCallout := 1
    static VideoEnumChildPdoNotifyCallout := 3
    static VideoFindAdapterCallout := 4
    static VideoPnpNotifyCallout := 7
    static VideoDxgkDisplaySwitchCallout := 8
    static VideoDxgkFindAdapterTdrCallout := 10
    static VideoDxgkHardwareProtectionTeardown := 11
    static VideoRepaintDesktop := 12
    static VideoUpdateCursor := 13
    static VideoDisableMultiPlaneOverlay := 14
    static VideoDesktopDuplicationChange := 15
    static VideoBlackScreenDiagnostics := 16
    static VideoForceCompositionRender := 17
}
struct BlackScreenDiagnosticsCalloutParam extends Int32 {
    static BlackScreenDiagnosticsData := 1
    static BlackScreenDisplayRecovery := 2
}
struct DXGK_WIN32K_PARAM_DATA {
    PathsArray : Struct.Ptr
    ModesArray : Struct.Ptr
    NumPathArrayElements : UInt32
    NumModeArrayElements : UInt32
    SDCFlags : UInt32
}
struct VIDEO_WIN32K_CALLBACKS_PARAMS {
    CalloutType : VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE
    PhysDisp : Struct.Ptr
    Param : IntPtr
    Status : Int32
    LockUserSession : BOOLEAN
    IsPostDevice : BOOLEAN
    SurpriseRemoval : BOOLEAN
    WaitForQueueReady : BOOLEAN
}
struct PVIDEO_WIN32K_CALLOUT extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct VIDEO_WIN32K_CALLBACKS {
    PhysDisp : Struct.Ptr
    Callout : PVIDEO_WIN32K_CALLOUT
    bACPI : UInt32
    pPhysDeviceObject : HANDLE
    DualviewFlags : UInt32
}
struct VIDEO_DEVICE_SESSION_STATUS {
    bEnable : UInt32
    bSuccess : UInt32
}
struct VIDEO_HARDWARE_STATE_HEADER {
    Length : UInt32
    PortValue : UInt8[48]
    AttribIndexDataState : UInt32
    BasicSequencerOffset : UInt32
    BasicCrtContOffset : UInt32
    BasicGraphContOffset : UInt32
    BasicAttribContOffset : UInt32
    BasicDacOffset : UInt32
    BasicLatchesOffset : UInt32
    ExtendedSequencerOffset : UInt32
    ExtendedCrtContOffset : UInt32
    ExtendedGraphContOffset : UInt32
    ExtendedAttribContOffset : UInt32
    ExtendedDacOffset : UInt32
    ExtendedValidatorStateOffset : UInt32
    ExtendedMiscDataOffset : UInt32
    PlaneLength : UInt32
    Plane1Offset : UInt32
    Plane2Offset : UInt32
    Plane3Offset : UInt32
    Plane4Offset : UInt32
    VGAStateFlags : UInt32
    DIBOffset : UInt32
    DIBBitsPerPixel : UInt32
    DIBXResolution : UInt32
    DIBYResolution : UInt32
    DIBXlatOffset : UInt32
    DIBXlatLength : UInt32
    VesaInfoOffset : UInt32
    FrameBufferData : Struct.Ptr
}
struct VIDEO_HARDWARE_STATE {
    StateHeader : VIDEO_HARDWARE_STATE_HEADER.Ptr
    StateLength : UInt32
}
struct VIDEO_NUM_MODES {
    NumModes : UInt32
    ModeInformationLength : UInt32
}
struct VIDEO_MODE {
    RequestedMode : UInt32
}
struct VIDEO_MODE_INFORMATION {
    Length : UInt32
    ModeIndex : UInt32
    VisScreenWidth : UInt32
    VisScreenHeight : UInt32
    ScreenStride : UInt32
    NumberOfPlanes : UInt32
    BitsPerPlane : UInt32
    Frequency : UInt32
    XMillimeter : UInt32
    YMillimeter : UInt32
    NumberRedBits : UInt32
    NumberGreenBits : UInt32
    NumberBlueBits : UInt32
    RedMask : UInt32
    GreenMask : UInt32
    BlueMask : UInt32
    AttributeFlags : UInt32
    VideoMemoryBitmapWidth : UInt32
    VideoMemoryBitmapHeight : UInt32
    DriverSpecificAttributeFlags : UInt32
}
struct VIDEO_LOAD_FONT_INFORMATION {
    WidthInPixels : UInt16
    HeightInPixels : UInt16
    FontSize : UInt32
    Font : UInt8[1]
}
struct VIDEO_PALETTE_DATA {
    NumEntries : UInt16
    FirstEntry : UInt16
    Colors : UInt16[1]
}
struct VIDEO_CLUTDATA {
    Red : UInt8
    Green : UInt8
    Blue : UInt8
    Unused : UInt8
}
struct VIDEO_CLUT {
    NumEntries : UInt16
    FirstEntry : UInt16
    LookupTable : this._Anonymous_e__Union[1]
    struct _Anonymous_e__Union {
        union {
            RgbArray : VIDEO_CLUTDATA
            RgbLong : UInt32
        }
    }
}
struct VIDEO_CURSOR_POSITION {
    Column : Int16
    Row : Int16
}
struct VIDEO_CURSOR_ATTRIBUTES {
    Width : UInt16
    Height : UInt16
    Column : Int16
    Row : Int16
    Rate : UInt8
    Enable : UInt8
}
struct VIDEO_POINTER_POSITION {
    Column : Int16
    Row : Int16
}
struct VIDEO_POINTER_ATTRIBUTES {
    Flags : UInt32
    Width : UInt32
    Height : UInt32
    WidthInBytes : UInt32
    Enable : UInt32
    Column : Int16
    Row : Int16
    Pixels : UInt8[1]
}
struct VIDEO_POINTER_CAPABILITIES {
    Flags : UInt32
    MaxWidth : UInt32
    MaxHeight : UInt32
    HWPtrBitmapStart : UInt32
    HWPtrBitmapEnd : UInt32
}
struct VIDEO_BANK_SELECT {
    Length : UInt32
    Size : UInt32
    BankingFlags : UInt32
    BankingType : UInt32
    PlanarHCBankingType : UInt32
    BitmapWidthInBytes : UInt32
    BitmapSize : UInt32
    Granularity : UInt32
    PlanarHCGranularity : UInt32
    CodeOffset : UInt32
    PlanarHCBankCodeOffset : UInt32
    PlanarHCEnableCodeOffset : UInt32
    PlanarHCDisableCodeOffset : UInt32
}
struct VIDEO_BANK_TYPE extends Int32 {
    static VideoNotBanked := 0
    static VideoBanked1RW := 1
    static VideoBanked1R1W := 2
    static VideoBanked2RW := 3
    static NumVideoBankTypes := 4
}
struct VIDEO_MEMORY {
    RequestedVirtualAddress : Struct.Ptr
}
struct VIDEO_SHARE_MEMORY {
    ProcessHandle : HANDLE
    ViewOffset : UInt32
    ViewSize : UInt32
    RequestedVirtualAddress : Struct.Ptr
}
struct VIDEO_SHARE_MEMORY_INFORMATION {
    SharedViewOffset : UInt32
    SharedViewSize : UInt32
    VirtualAddress : Struct.Ptr
}
struct VIDEO_MEMORY_INFORMATION {
    VideoRamBase : Struct.Ptr
    VideoRamLength : UInt32
    FrameBufferBase : Struct.Ptr
    FrameBufferLength : UInt32
}
struct VIDEO_PUBLIC_ACCESS_RANGES {
    InIoSpace : UInt32
    MappedInIoSpace : UInt32
    VirtualAddress : Struct.Ptr
}
struct VIDEO_COLOR_CAPABILITIES {
    Length : UInt32
    AttributeFlags : UInt32
    RedPhosphoreDecay : Int32
    GreenPhosphoreDecay : Int32
    BluePhosphoreDecay : Int32
    WhiteChromaticity_x : Int32
    WhiteChromaticity_y_1 : Int32
    WhiteChromaticity_Y_2 : Int32
    RedChromaticity_x : Int32
    RedChromaticity_y : Int32
    GreenChromaticity_x : Int32
    GreenChromaticity_y : Int32
    BlueChromaticity_x : Int32
    BlueChromaticity_y : Int32
    WhiteGamma : Int32
    RedGamma : Int32
    GreenGamma : Int32
    BlueGamma : Int32
}
struct VIDEO_POWER_STATE extends Int32 {
    static VideoPowerUnspecified := 0
    static VideoPowerOn := 1
    static VideoPowerStandBy := 2
    static VideoPowerSuspend := 3
    static VideoPowerOff := 4
    static VideoPowerHibernate := 5
    static VideoPowerShutdown := 6
    static VideoPowerMaximum := 7
}
struct VIDEO_POWER_MANAGEMENT {
    Length : UInt32
    DPMSVersion : UInt32
    PowerState : UInt32
}
struct VIDEO_COLOR_LUT_DATA {
    Length : UInt32
    LutDataFormat : UInt32
    LutData : UInt8[1]
}
struct VIDEO_LUT_RGB256WORDS {
    Red : UInt16[256]
    Green : UInt16[256]
    Blue : UInt16[256]
}
struct BANK_POSITION {
    ReadBankPosition : UInt32
    WriteBankPosition : UInt32
}
struct DISPLAY_BRIGHTNESS {
    ucDisplayPolicy : UInt8
    ucACBrightness : UInt8
    ucDCBrightness : UInt8
}
struct VIDEO_BRIGHTNESS_POLICY {
    DefaultToBiosPolicy : BOOLEAN
    LevelCount : UInt8
    Level : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        BatteryLevel : UInt8
        Brightness : UInt8
    }
}
struct FSCNTL_SCREEN_INFO {
    Position : COORD
    ScreenSize : COORD
    nNumberOfChars : UInt32
}
struct FONT_IMAGE_INFO {
    FontSize : COORD
    ImageBits : UInt8.Ptr
}
struct CHAR_IMAGE_INFO {
    CharInfo : CHAR_INFO
    FontImageInfo : FONT_IMAGE_INFO
}
struct VGA_CHAR {
    Char : CHAR
    Attributes : CHAR
}
struct FSVIDEO_COPY_FRAME_BUFFER {
    SrcScreen : FSCNTL_SCREEN_INFO
    DestScreen : FSCNTL_SCREEN_INFO
}
struct FSVIDEO_WRITE_TO_FRAME_BUFFER {
    SrcBuffer : CHAR_IMAGE_INFO.Ptr
    DestScreen : FSCNTL_SCREEN_INFO
}
struct FSVIDEO_REVERSE_MOUSE_POINTER {
    Screen : FSCNTL_SCREEN_INFO
    dwType : UInt32
}
struct FSVIDEO_MODE_INFORMATION {
    VideoMode : VIDEO_MODE_INFORMATION
    VideoMemory : VIDEO_MEMORY_INFORMATION
}
struct FSVIDEO_SCREEN_INFORMATION {
    ScreenSize : COORD
    FontSize : COORD
}
struct FSVIDEO_CURSOR_POSITION {
    Coord : VIDEO_CURSOR_POSITION
    dwType : UInt32
}
struct ENG_EVENT {
    pKEvent : Struct.Ptr
    fFlags : UInt32
}
struct VIDEO_PERFORMANCE_COUNTER {
    NbOfAllocationEvicted : Int64[10]
    NbOfAllocationMarked : Int64[10]
    NbOfAllocationRestored : Int64[10]
    KBytesEvicted : Int64[10]
    KBytesMarked : Int64[10]
    KBytesRestored : Int64[10]
    NbProcessCommited : Int64
    NbAllocationCommited : Int64
    NbAllocationMarked : Int64
    KBytesAllocated : Int64
    KBytesAvailable : Int64
    KBytesCurMarked : Int64
    Reference : Int64
    Unreference : Int64
    TrueReference : Int64
    NbOfPageIn : Int64
    KBytesPageIn : Int64
    NbOfPageOut : Int64
    KBytesPageOut : Int64
    NbOfRotateOut : Int64
    KBytesRotateOut : Int64
}
struct VIDEO_QUERY_PERFORMANCE_COUNTER {
    BufferSize : UInt32
    Buffer : VIDEO_PERFORMANCE_COUNTER.Ptr
}
struct BRIGHTNESS_INTERFACE_VERSION extends Int32 {
    static BRIGHTNESS_INTERFACE_VERSION_1 := 1
    static BRIGHTNESS_INTERFACE_VERSION_2 := 2
    static BRIGHTNESS_INTERFACE_VERSION_3 := 3
}
struct PANEL_QUERY_BRIGHTNESS_CAPS {
    Version : BRIGHTNESS_INTERFACE_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct BRIGHTNESS_LEVEL {
    Count : UInt8
    Level : UInt8[103]
}
struct BRIGHTNESS_NIT_RANGE {
    MinLevelInMillinit : UInt32
    MaxLevelInMillinit : UInt32
    StepSizeInMillinit : UInt32
}
struct BRIGHTNESS_NIT_RANGES {
    NormalRangeCount : UInt32
    RangeCount : UInt32
    PreferredMaximumBrightness : UInt32
    SupportedRanges : BRIGHTNESS_NIT_RANGE[16]
}
struct PANEL_QUERY_BRIGHTNESS_RANGES {
    Version : BRIGHTNESS_INTERFACE_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            BrightnessLevel : BRIGHTNESS_LEVEL
            NitRanges : BRIGHTNESS_NIT_RANGES
        }
    }
}
struct PANEL_GET_BRIGHTNESS {
    Version : BRIGHTNESS_INTERFACE_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Level : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            CurrentInMillinits : UInt32
            TargetInMillinits : UInt32
        }
    }
}
struct CHROMATICITY_COORDINATE {
    x : Float32
    y : Float32
}
struct PANEL_BRIGHTNESS_SENSOR_DATA {
    Anonymous : this._Anonymous_e__Union
    AlsReading : Float32
    ChromaticityCoordinate : CHROMATICITY_COORDINATE
    ColorTemperature : Float32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PANEL_SET_BRIGHTNESS {
    Version : BRIGHTNESS_INTERFACE_VERSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Level : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Millinits : UInt32
            TransitionTimeInMs : UInt32
            SensorData : PANEL_BRIGHTNESS_SENSOR_DATA
        }
    }
}
struct PANEL_SET_BRIGHTNESS_STATE {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct BACKLIGHT_OPTIMIZATION_LEVEL extends Int32 {
    static BacklightOptimizationDisable := 0
    static BacklightOptimizationDesktop := 1
    static BacklightOptimizationDynamic := 2
    static BacklightOptimizationDimmed := 3
    static BacklightOptimizationEDR := 4
}
struct PANEL_SET_BACKLIGHT_OPTIMIZATION {
    Level : BACKLIGHT_OPTIMIZATION_LEVEL
}
struct BACKLIGHT_REDUCTION_GAMMA_RAMP {
    R : UInt16[256]
    G : UInt16[256]
    B : UInt16[256]
}
struct PANEL_GET_BACKLIGHT_REDUCTION {
    BacklightUsersetting : UInt16
    BacklightEffective : UInt16
    GammaRamp : BACKLIGHT_REDUCTION_GAMMA_RAMP
}
struct COLORSPACE_TRANSFORM_DATA_TYPE extends Int32 {
    static COLORSPACE_TRANSFORM_DATA_TYPE_FIXED_POINT := 0
    static COLORSPACE_TRANSFORM_DATA_TYPE_FLOAT := 1
}
struct COLORSPACE_TRANSFORM_DATA_CAP {
    DataType : COLORSPACE_TRANSFORM_DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    NumericRangeMin : Float32
    NumericRangeMax : Float32
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            Value : UInt32
        }
        struct _Anonymous1_e__Struct {
            _bitfield : UInt32
        }
        struct _Anonymous2_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct COLORSPACE_TRANSFORM_1DLUT_CAP {
    NumberOfLUTEntries : UInt32
    DataCap : COLORSPACE_TRANSFORM_DATA_CAP
}
struct COLORSPACE_TRANSFORM_MATRIX_CAP {
    Anonymous : this._Anonymous_e__Union
    DataCap : COLORSPACE_TRANSFORM_DATA_CAP
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION extends Int32 {
    static COLORSPACE_TRANSFORM_VERSION_DEFAULT := 0
    static COLORSPACE_TRANSFORM_VERSION_1 := 1
    static COLORSPACE_TRANSFORM_VERSION_NOT_SUPPORTED := 0
}
struct COLORSPACE_SCALAR_MULTIPLIER_CAPS {
    Valid : BOOLEAN
    NumericRangeMin : Float32
    NumericRangeMax : Float32
}
struct COLORSPACE_TRANSFORM_TARGET_CAPS {
    Version : COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION
    LookupTable1DDegammaCap : COLORSPACE_TRANSFORM_1DLUT_CAP
    ColorMatrix3x3Cap : COLORSPACE_TRANSFORM_MATRIX_CAP
    LookupTable1DRegammaCap : COLORSPACE_TRANSFORM_1DLUT_CAP
}
struct COLORSPACE_TRANSFORM_TYPE extends Int32 {
    static COLORSPACE_TRANSFORM_TYPE_UNINITIALIZED := 0
    static COLORSPACE_TRANSFORM_TYPE_DEFAULT := 1
    static COLORSPACE_TRANSFORM_TYPE_RGB256x3x16 := 2
    static COLORSPACE_TRANSFORM_TYPE_DXGI_1 := 3
    static COLORSPACE_TRANSFORM_TYPE_MATRIX_3x4 := 4
    static COLORSPACE_TRANSFORM_TYPE_MATRIX_V2 := 5
}
struct GAMMA_RAMP_RGB256x3x16 {
    Red : UInt16[256]
    Green : UInt16[256]
    Blue : UInt16[256]
}
struct GAMMA_RAMP_RGB {
    Red : Float32
    Green : Float32
    Blue : Float32
}
struct GAMMA_RAMP_DXGI_1 {
    Scale : GAMMA_RAMP_RGB
    Offset : GAMMA_RAMP_RGB
    GammaCurve : GAMMA_RAMP_RGB[1025]
}
struct COLORSPACE_TRANSFORM_3x4 {
    ColorMatrix3x4 : Float32[12]
    ScalarMultiplier : Float32
    LookupTable1D : GAMMA_RAMP_RGB[4096]
}
struct OUTPUT_WIRE_COLOR_SPACE_TYPE extends Int32 {
    static OUTPUT_WIRE_COLOR_SPACE_G22_P709 := 0
    static OUTPUT_WIRE_COLOR_SPACE_RESERVED := 4
    static OUTPUT_WIRE_COLOR_SPACE_G2084_P2020 := 12
    static OUTPUT_WIRE_COLOR_SPACE_G22_P709_WCG := 30
    static OUTPUT_WIRE_COLOR_SPACE_G22_P2020 := 31
    static OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_HDR10PLUS := 32
    static OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_DVLL := 33
}
struct OUTPUT_COLOR_ENCODING extends Int32 {
    static OUTPUT_COLOR_ENCODING_RGB := 0
    static OUTPUT_COLOR_ENCODING_YCBCR444 := 1
    static OUTPUT_COLOR_ENCODING_YCBCR422 := 2
    static OUTPUT_COLOR_ENCODING_YCBCR420 := 3
    static OUTPUT_COLOR_ENCODING_INTENSITY := 4
}
struct OUTPUT_WIRE_FORMAT {
    ColorEncoding : OUTPUT_COLOR_ENCODING
    BitsPerPixel : UInt32
}
struct COLORSPACE_TRANSFORM_STAGE_CONTROL extends Int32 {
    static ColorSpaceTransformStageControl_No_Change := 0
    static ColorSpaceTransformStageControl_Enable := 1
    static ColorSpaceTransformStageControl_Bypass := 2
}
struct COLORSPACE_TRANSFORM_MATRIX_V2 {
    StageControlLookupTable1DDegamma : COLORSPACE_TRANSFORM_STAGE_CONTROL
    LookupTable1DDegamma : GAMMA_RAMP_RGB[4096]
    StageControlColorMatrix3x3 : COLORSPACE_TRANSFORM_STAGE_CONTROL
    ColorMatrix3x3 : Float32[9]
    StageControlLookupTable1DRegamma : COLORSPACE_TRANSFORM_STAGE_CONTROL
    LookupTable1DRegamma : GAMMA_RAMP_RGB[4096]
}
struct COLORSPACE_TRANSFORM {
    Type : COLORSPACE_TRANSFORM_TYPE
    Data : this._Data_e__Union
    struct _Data_e__Union {
        union {
            Rgb256x3x16 : GAMMA_RAMP_RGB256x3x16
            Dxgi1 : GAMMA_RAMP_DXGI_1
            T3x4 : COLORSPACE_TRANSFORM_3x4
            MatrixV2 : COLORSPACE_TRANSFORM_MATRIX_V2
        }
    }
}
struct COLORSPACE_TRANSFORM_SET_INPUT {
    OutputWireColorSpaceExpected : OUTPUT_WIRE_COLOR_SPACE_TYPE
    OutputWireFormatExpected : OUTPUT_WIRE_FORMAT
    ColorSpaceTransform : COLORSPACE_TRANSFORM
}
struct SET_ACTIVE_COLOR_PROFILE_NAME {
    ColorProfileName : UInt16[1]
}
struct MIPI_DSI_CAPS {
    DSITypeMajor : UInt8
    DSITypeMinor : UInt8
    SpecVersionMajor : UInt8
    SpecVersionMinor : UInt8
    SpecVersionPatch : UInt8
    TargetMaximumReturnPacketSize : UInt16
    ResultCodeFlags : UInt8
    ResultCodeStatus : UInt8
    Revision : UInt8
    Level : UInt8
    DeviceClassHi : UInt8
    DeviceClassLo : UInt8
    ManufacturerHi : UInt8
    ManufacturerLo : UInt8
    ProductHi : UInt8
    ProductLo : UInt8
    LengthHi : UInt8
    LengthLo : UInt8
}
struct DSI_CONTROL_TRANSMISSION_MODE extends Int32 {
    static DCT_DEFAULT := 0
    static DCT_FORCE_LOW_POWER := 1
    static DCT_FORCE_HIGH_PERFORMANCE := 2
}
struct MIPI_DSI_PACKET {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    EccFiller : UInt8
    Payload : UInt8[8]
    struct _Anonymous1_e__Union {
        union {
            DataId : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            LongWriteWordCount : UInt16
        }
        struct _Anonymous_e__Struct {
            Data0 : UInt8
            Data1 : UInt8
        }
    }
}
struct MIPI_DSI_TRANSMISSION {
    TotalBufferSize : UInt32
    PacketCount : UInt8
    FailedPacket : UInt8
    Anonymous : this._Anonymous_e__Struct
    ReadWordCount : UInt16
    FinalCommandExtraPayload : UInt16
    MipiErrors : UInt16
    HostErrors : UInt16
    Packets : MIPI_DSI_PACKET[1]
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct MIPI_DSI_RESET {
    Flags : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Results : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct AR_STATE extends Int32 {
    static AR_ENABLED := 0
    static AR_DISABLED := 1
    static AR_SUPPRESSED := 2
    static AR_REMOTESESSION := 4
    static AR_MULTIMON := 8
    static AR_NOSENSOR := 16
    static AR_NOT_SUPPORTED := 32
    static AR_DOCKED := 64
    static AR_LAPTOP := 128
}
struct ORIENTATION_PREFERENCE extends Int32 {
    static ORIENTATION_PREFERENCE_NONE := 0
    static ORIENTATION_PREFERENCE_LANDSCAPE := 1
    static ORIENTATION_PREFERENCE_PORTRAIT := 2
    static ORIENTATION_PREFERENCE_LANDSCAPE_FLIPPED := 4
    static ORIENTATION_PREFERENCE_PORTRAIT_FLIPPED := 8
}
