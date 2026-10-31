#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HRESULT, HWND, LPARAM, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {CIEXYZ, CIEXYZTRIPLE, EMR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {DLGPROC}

struct ICM_COMMAND extends UInt32 {
    static ICM_ADDPROFILE := 1
    static ICM_DELETEPROFILE := 2
    static ICM_QUERYPROFILE := 3
    static ICM_SETDEFAULTPROFILE := 4
    static ICM_REGISTERICMATCHER := 5
    static ICM_UNREGISTERICMATCHER := 6
    static ICM_QUERYMATCH := 7
}
struct ICM_MODE extends Int32 {
    static ICM_OFF := 1
    static ICM_ON := 2
    static ICM_QUERY := 3
    static ICM_DONE_OUTSIDEDC := 4
}
struct COLOR_MATCH_TO_TARGET_ACTION extends UInt32 {
    static CS_ENABLE := 1
    static CS_DISABLE := 2
    static CS_DELETE_TRANSFORM := 3
}
struct LCSCSTYPE extends Int32 {
    static LCS_CALIBRATED_RGB := 0
    static LCS_sRGB := 1934772034
    static LCS_WINDOWS_COLOR_SPACE := 1466527264
}
struct HCOLORSPACE {
    Value : IntPtr
}
struct LOGCOLORSPACEA {
    lcsSignature : UInt32
    lcsVersion : UInt32
    lcsSize : UInt32
    lcsCSType : LCSCSTYPE
    lcsIntent : Int32
    lcsEndpoints : CIEXYZTRIPLE
    lcsGammaRed : UInt32
    lcsGammaGreen : UInt32
    lcsGammaBlue : UInt32
    lcsFilename : CHAR[260]
}
struct LOGCOLORSPACEW {
    lcsSignature : UInt32
    lcsVersion : UInt32
    lcsSize : UInt32
    lcsCSType : LCSCSTYPE
    lcsIntent : Int32
    lcsEndpoints : CIEXYZTRIPLE
    lcsGammaRed : UInt32
    lcsGammaGreen : UInt32
    lcsGammaBlue : UInt32
    lcsFilename : UInt16[260]
}
struct ICMENUMPROCA extends FunctionPointer {
    static Types := [PSTR, LPARAM, Int32]
}
struct ICMENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, LPARAM, Int32]
}
struct EMRCREATECOLORSPACE {
    emr : EMR
    ihCS : UInt32
    lcs : LOGCOLORSPACEA
}
struct EMRCREATECOLORSPACEW {
    emr : EMR
    ihCS : UInt32
    lcs : LOGCOLORSPACEW
    dwFlags : UInt32
    cbData : UInt32
    Data : UInt8[1]
}
struct XYZColorF {
    X : Float32
    Y : Float32
    Z : Float32
}
struct JChColorF {
    J : Float32
    C : Float32
    h : Float32
}
struct JabColorF {
    J : Float32
    a : Float32
    b : Float32
}
struct GamutShellTriangle {
    aVertexIndex : UInt32[3]
}
struct GamutShell {
    JMin : Float32
    JMax : Float32
    cVertices : UInt32
    cTriangles : UInt32
    pVertices : JabColorF.Ptr
    pTriangles : GamutShellTriangle.Ptr
}
struct PrimaryJabColors {
    red : JabColorF
    yellow : JabColorF
    green : JabColorF
    cyan : JabColorF
    blue : JabColorF
    magenta : JabColorF
    black : JabColorF
    white : JabColorF
}
struct PrimaryXYZColors {
    red : XYZColorF
    yellow : XYZColorF
    green : XYZColorF
    cyan : XYZColorF
    blue : XYZColorF
    magenta : XYZColorF
    black : XYZColorF
    white : XYZColorF
}
struct GamutBoundaryDescription {
    pPrimaries : PrimaryJabColors.Ptr
    cNeutralSamples : UInt32
    pNeutralSamples : JabColorF.Ptr
    pReferenceShell : GamutShell.Ptr
    pPlausibleShell : GamutShell.Ptr
    pPossibleShell : GamutShell.Ptr
}
struct BlackInformation {
    fBlackOnly : BOOL
    blackWeight : Float32
}
struct IDeviceModelPlugIn extends IUnknown {
    static IID := "{1CD63475-07C4-46FE-A903-D655316D11FD}"
    Initialize(bstrXml, cNumModels, iModelPosition)
      => ComCall(3, this.p, BSTR, bstrXml, UInt32, cNumModels, UInt32, iModelPosition)
    GetNumChannels(pNumChannels)
      => ComCall(4, this.p, UInt32.Ptr, pNumChannels)
    DeviceToColorimetricColors(cChannels, pDeviceValues, pXYZColors)
      => ComCall(5, this.p, UInt32, pXYZColors.Length, UInt32, cChannels, Float32.Ptr, pDeviceValues, XYZColorF.Ptr, pXYZColors)
    ColorimetricToDeviceColors(cChannels, pXYZColors, pDeviceValues)
      => ComCall(6, this.p, UInt32, pXYZColors.Length, UInt32, cChannels, XYZColorF.Ptr, pXYZColors, Float32.Ptr, pDeviceValues)
    ColorimetricToDeviceColorsWithBlack(cChannels, pXYZColors, pBlackInformation, pDeviceValues)
      => ComCall(7, this.p, UInt32, pBlackInformation.Length, UInt32, cChannels, XYZColorF.Ptr, pXYZColors, BlackInformation.Ptr, pBlackInformation, Float32.Ptr, pDeviceValues)
    SetTransformDeviceModelInfo(iModelPosition, pIDeviceModelOther)
      => ComCall(8, this.p, UInt32, iModelPosition, IDeviceModelPlugIn, pIDeviceModelOther)
    GetPrimarySamples(pPrimaryColor)
      => ComCall(9, this.p, PrimaryXYZColors.Ptr, pPrimaryColor)
    GetGamutBoundaryMeshSize(pNumVertices, pNumTriangles)
      => ComCall(10, this.p, UInt32.Ptr, pNumVertices, UInt32.Ptr, pNumTriangles)
    GetGamutBoundaryMesh(cChannels, cVertices, pVertices, pTriangles)
      => ComCall(11, this.p, UInt32, cChannels, UInt32, cVertices, UInt32, pTriangles.Length, Float32.Ptr, pVertices, GamutShellTriangle.Ptr, pTriangles)
    GetNeutralAxisSize(pcColors)
      => ComCall(12, this.p, UInt32.Ptr, pcColors)
    GetNeutralAxis(pXYZColors)
      => ComCall(13, this.p, UInt32, pXYZColors.Length, XYZColorF.Ptr, pXYZColors)
}
struct IGamutMapModelPlugIn extends IUnknown {
    static IID := "{2DD80115-AD1E-41F6-A219-A4F4B583D1F9}"
    Initialize(bstrXml, pSrcPlugIn, pDestPlugIn, pSrcGBD, pDestGBD)
      => ComCall(3, this.p, BSTR, bstrXml, IDeviceModelPlugIn, pSrcPlugIn, IDeviceModelPlugIn, pDestPlugIn, GamutBoundaryDescription.Ptr, pSrcGBD, GamutBoundaryDescription.Ptr, pDestGBD)
    SourceToDestinationAppearanceColors(pInputColors, pOutputColors)
      => ComCall(4, this.p, UInt32, pOutputColors.Length, JChColorF.Ptr, pInputColors, JChColorF.Ptr, pOutputColors)
}
struct NAMED_PROFILE_INFO {
    dwFlags : UInt32
    dwCount : UInt32
    dwCountDevCoordinates : UInt32
    szPrefix : Int8[32]
    szSuffix : Int8[32]
}
struct GRAYCOLOR {
    gray : UInt16
}
struct RGBCOLOR {
    red : UInt16
    green : UInt16
    blue : UInt16
}
struct CMYKCOLOR {
    cyan : UInt16
    magenta : UInt16
    yellow : UInt16
    black : UInt16
}
struct XYZCOLOR {
    X : UInt16
    Y : UInt16
    Z : UInt16
}
struct YxyCOLOR {
    Y_1 : UInt16
    x : UInt16
    y_2 : UInt16
}
struct LabCOLOR {
    L : UInt16
    a : UInt16
    b : UInt16
}
struct GENERIC3CHANNEL {
    ch1 : UInt16
    ch2 : UInt16
    ch3 : UInt16
}
struct NAMEDCOLOR {
    dwIndex : UInt32
}
struct HiFiCOLOR {
    channel : UInt8[8]
}
struct COLOR {
    union {
        gray : GRAYCOLOR
        rgb : RGBCOLOR
        cmyk : CMYKCOLOR
        XYZ : XYZCOLOR
        Yxy : YxyCOLOR
        Lab : LabCOLOR
        gen3ch : GENERIC3CHANNEL
        named : NAMEDCOLOR
        hifi : HiFiCOLOR
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        reserved1 : UInt32
        reserved2 : Struct.Ptr
    }
}
struct COLORTYPE extends Int32 {
    static COLOR_GRAY := 1
    static COLOR_RGB := 2
    static COLOR_XYZ := 3
    static COLOR_Yxy := 4
    static COLOR_Lab := 5
    static COLOR_3_CHANNEL := 6
    static COLOR_CMYK := 7
    static COLOR_5_CHANNEL := 8
    static COLOR_6_CHANNEL := 9
    static COLOR_7_CHANNEL := 10
    static COLOR_8_CHANNEL := 11
    static COLOR_NAMED := 12
}
struct COLORPROFILETYPE extends Int32 {
    static CPT_ICC := 0
    static CPT_DMP := 1
    static CPT_CAMP := 2
    static CPT_GMMP := 3
}
struct COLORPROFILESUBTYPE extends Int32 {
    static CPST_PERCEPTUAL := 0
    static CPST_RELATIVE_COLORIMETRIC := 1
    static CPST_SATURATION := 2
    static CPST_ABSOLUTE_COLORIMETRIC := 3
    static CPST_NONE := 4
    static CPST_RGB_WORKING_SPACE := 5
    static CPST_CUSTOM_WORKING_SPACE := 6
    static CPST_STANDARD_DISPLAY_COLOR_MODE := 7
    static CPST_EXTENDED_DISPLAY_COLOR_MODE := 8
}
struct COLORDATATYPE extends Int32 {
    static COLOR_BYTE := 1
    static COLOR_WORD := 2
    static COLOR_FLOAT := 3
    static COLOR_S2DOT13FIXED := 4
    static COLOR_10b_R10G10B10A2 := 5
    static COLOR_10b_R10G10B10A2_XR := 6
    static COLOR_FLOAT16 := 7
}
struct BMFORMAT extends Int32 {
    static BM_x555RGB := 0
    static BM_x555XYZ := 257
    static BM_x555Yxy := 258
    static BM_x555Lab := 259
    static BM_x555G3CH := 260
    static BM_RGBTRIPLETS := 2
    static BM_BGRTRIPLETS := 4
    static BM_XYZTRIPLETS := 513
    static BM_YxyTRIPLETS := 514
    static BM_LabTRIPLETS := 515
    static BM_G3CHTRIPLETS := 516
    static BM_5CHANNEL := 517
    static BM_6CHANNEL := 518
    static BM_7CHANNEL := 519
    static BM_8CHANNEL := 520
    static BM_GRAY := 521
    static BM_xRGBQUADS := 8
    static BM_xBGRQUADS := 16
    static BM_xG3CHQUADS := 772
    static BM_KYMCQUADS := 773
    static BM_CMYKQUADS := 32
    static BM_10b_RGB := 9
    static BM_10b_XYZ := 1025
    static BM_10b_Yxy := 1026
    static BM_10b_Lab := 1027
    static BM_10b_G3CH := 1028
    static BM_NAMED_INDEX := 1029
    static BM_16b_RGB := 10
    static BM_16b_XYZ := 1281
    static BM_16b_Yxy := 1282
    static BM_16b_Lab := 1283
    static BM_16b_G3CH := 1284
    static BM_16b_GRAY := 1285
    static BM_565RGB := 1
    static BM_32b_scRGB := 1537
    static BM_32b_scARGB := 1538
    static BM_S2DOT13FIXED_scRGB := 1539
    static BM_S2DOT13FIXED_scARGB := 1540
    static BM_R10G10B10A2 := 1793
    static BM_R10G10B10A2_XR := 1794
    static BM_R16G16B16A16_FLOAT := 1795
}
struct LPBMCALLBACKFN extends FunctionPointer {
    static Types := [UInt32, UInt32, LPARAM, BOOL]
}
struct PROFILEHEADER {
    phSize : UInt32
    phCMMType : UInt32
    phVersion : UInt32
    phClass : UInt32
    phDataColorSpace : UInt32
    phConnectionSpace : UInt32
    phDateTime : UInt32[3]
    phSignature : UInt32
    phPlatform : UInt32
    phProfileFlags : UInt32
    phManufacturer : UInt32
    phModel : UInt32
    phAttributes : UInt32[2]
    phRenderingIntent : UInt32
    phIlluminant : CIEXYZ
    phCreator : UInt32
    phReserved : UInt8[44]
}
struct PROFILE {
    dwType : UInt32
    pProfileData : Struct.Ptr
    cbDataSize : UInt32
}
struct ENUMTYPEA {
    dwSize : UInt32
    dwVersion : UInt32
    dwFields : UInt32
    pDeviceName : PSTR
    dwMediaType : UInt32
    dwDitheringMode : UInt32
    dwResolution : UInt32[2]
    dwCMMType : UInt32
    dwClass : UInt32
    dwDataColorSpace : UInt32
    dwConnectionSpace : UInt32
    dwSignature : UInt32
    dwPlatform : UInt32
    dwProfileFlags : UInt32
    dwManufacturer : UInt32
    dwModel : UInt32
    dwAttributes : UInt32[2]
    dwRenderingIntent : UInt32
    dwCreator : UInt32
    dwDeviceClass : UInt32
}
struct ENUMTYPEW {
    dwSize : UInt32
    dwVersion : UInt32
    dwFields : UInt32
    pDeviceName : PWSTR
    dwMediaType : UInt32
    dwDitheringMode : UInt32
    dwResolution : UInt32[2]
    dwCMMType : UInt32
    dwClass : UInt32
    dwDataColorSpace : UInt32
    dwConnectionSpace : UInt32
    dwSignature : UInt32
    dwPlatform : UInt32
    dwProfileFlags : UInt32
    dwManufacturer : UInt32
    dwModel : UInt32
    dwAttributes : UInt32[2]
    dwRenderingIntent : UInt32
    dwCreator : UInt32
    dwDeviceClass : UInt32
}
struct WCS_PROFILE_MANAGEMENT_SCOPE extends Int32 {
    static WCS_PROFILE_MANAGEMENT_SCOPE_SYSTEM_WIDE := 0
    static WCS_PROFILE_MANAGEMENT_SCOPE_CURRENT_USER := 1
}
struct PCMSCALLBACKW extends FunctionPointer {
    static Types := [COLORMATCHSETUPW.Ptr, LPARAM, BOOL]
}
struct PCMSCALLBACKA extends FunctionPointer {
    static Types := [COLORMATCHSETUPA.Ptr, LPARAM, BOOL]
}
struct COLORMATCHSETUPW {
    dwSize : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    hwndOwner : HWND
    pSourceName : PWSTR
    pDisplayName : PWSTR
    pPrinterName : PWSTR
    dwRenderIntent : UInt32
    dwProofingIntent : UInt32
    pMonitorProfile : PWSTR
    ccMonitorProfile : UInt32
    pPrinterProfile : PWSTR
    ccPrinterProfile : UInt32
    pTargetProfile : PWSTR
    ccTargetProfile : UInt32
    lpfnHook : DLGPROC
    lParam : LPARAM
    lpfnApplyCallback : PCMSCALLBACKW
    lParamApplyCallback : LPARAM
}
struct COLORMATCHSETUPA {
    dwSize : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    hwndOwner : HWND
    pSourceName : PSTR
    pDisplayName : PSTR
    pPrinterName : PSTR
    dwRenderIntent : UInt32
    dwProofingIntent : UInt32
    pMonitorProfile : PSTR
    ccMonitorProfile : UInt32
    pPrinterProfile : PSTR
    ccPrinterProfile : UInt32
    pTargetProfile : PSTR
    ccTargetProfile : UInt32
    lpfnHook : DLGPROC
    lParam : LPARAM
    lpfnApplyCallback : PCMSCALLBACKA
    lParamApplyCallback : LPARAM
}
struct WCS_DEVICE_VCGT_CAPABILITIES {
    Size : UInt32
    SupportsVcgt : BOOL
}
struct WCS_DEVICE_MHC2_CAPABILITIES {
    Size : UInt32
    SupportsMhc2 : BOOL
    RegammaLutEntryCount : UInt32
    CscXyzMatrixRows : UInt32
    CscXyzMatrixColumns : UInt32
}
struct WCS_DEVICE_CAPABILITIES_TYPE extends Int32 {
    static VideoCardGammaTable := 1
    static MicrosoftHardwareColorV2 := 2
}
