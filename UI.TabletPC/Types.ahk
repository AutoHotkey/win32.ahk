#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, COLORREF, HANDLE_PTR, HRESULT, HWND, POINT, PWSTR, RECT, VARIANT_BOOL}
#Import "..\Graphics.Gdi\Types.ahk" {XFORM}
#Import "..\System.Com\Types.ahk" {IDataObject, IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Ole\Types.ahk" {IFontDisp, IPictureDisp, OLE_HANDLE}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {NMHDR}

struct PfnRecoCallback extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, HRECOCONTEXT, HRESULT]
}
struct HRECOALT {
    Value : IntPtr
}
struct HRECOCONTEXT {
    Value : IntPtr
}
struct HRECOGNIZER {
    Value : IntPtr
}
struct HRECOLATTICE {
    Value : IntPtr
}
struct HRECOWORDLIST {
    Value : IntPtr
}
struct PROPERTY_UNITS extends Int32 {
    static PROPERTY_UNITS_DEFAULT := 0
    static PROPERTY_UNITS_INCHES := 1
    static PROPERTY_UNITS_CENTIMETERS := 2
    static PROPERTY_UNITS_DEGREES := 3
    static PROPERTY_UNITS_RADIANS := 4
    static PROPERTY_UNITS_SECONDS := 5
    static PROPERTY_UNITS_POUNDS := 6
    static PROPERTY_UNITS_GRAMS := 7
    static PROPERTY_UNITS_SILINEAR := 8
    static PROPERTY_UNITS_SIROTATION := 9
    static PROPERTY_UNITS_ENGLINEAR := 10
    static PROPERTY_UNITS_ENGROTATION := 11
    static PROPERTY_UNITS_SLUGS := 12
    static PROPERTY_UNITS_KELVIN := 13
    static PROPERTY_UNITS_FAHRENHEIT := 14
    static PROPERTY_UNITS_AMPERE := 15
    static PROPERTY_UNITS_CANDELA := 16
}
struct SYSTEM_EVENT_DATA {
    bModifier : UInt8
    wKey : UInt16
    xPos : Int32
    yPos : Int32
    bCursorMode : UInt8
    dwButtonState : UInt32
}
struct STROKE_RANGE {
    iStrokeBegin : UInt32
    iStrokeEnd : UInt32
}
struct PROPERTY_METRICS {
    nLogicalMin : Int32
    nLogicalMax : Int32
    Units : PROPERTY_UNITS
    fResolution : Float32
}
struct PACKET_PROPERTY {
    guid : GUID
    PropertyMetrics : PROPERTY_METRICS
}
struct PACKET_DESCRIPTION {
    cbPacketSize : UInt32
    cPacketProperties : UInt32
    pPacketProperties : PACKET_PROPERTY.Ptr
    cButtons : UInt32
    pguidButtons : GUID.Ptr
}
struct INK_METRIC_FLAGS extends Int32 {
    static IMF_FONT_SELECTED_IN_HDC := 1
    static IMF_ITALIC := 2
    static IMF_BOLD := 4
}
struct GET_DANDIDATE_FLAGS extends Int32 {
    static TCF_ALLOW_RECOGNITION := 1
    static TCF_FORCE_RECOGNITION := 2
}
struct INKMETRIC {
    iHeight : Int32
    iFontAscent : Int32
    iFontDescent : Int32
    dwFlags : UInt32
    color : COLORREF
}
struct InkSelectionConstants extends Int32 {
    static ISC_FirstElement := 0
    static ISC_AllElements := -1
}
struct InkBoundingBoxMode extends Int32 {
    static IBBM_Default := 0
    static IBBM_NoCurveFit := 1
    static IBBM_CurveFit := 2
    static IBBM_PointsOnly := 3
    static IBBM_Union := 4
}
struct InkExtractFlags extends Int32 {
    static IEF_CopyFromOriginal := 0
    static IEF_RemoveFromOriginal := 1
    static IEF_Default := 1
}
struct InkPersistenceFormat extends Int32 {
    static IPF_InkSerializedFormat := 0
    static IPF_Base64InkSerializedFormat := 1
    static IPF_GIF := 2
    static IPF_Base64GIF := 3
}
struct InkPersistenceCompressionMode extends Int32 {
    static IPCM_Default := 0
    static IPCM_MaximumCompression := 1
    static IPCM_NoCompression := 2
}
struct InkPenTip extends Int32 {
    static IPT_Ball := 0
    static IPT_Rectangle := 1
}
struct InkRasterOperation extends Int32 {
    static IRO_Black := 1
    static IRO_NotMergePen := 2
    static IRO_MaskNotPen := 3
    static IRO_NotCopyPen := 4
    static IRO_MaskPenNot := 5
    static IRO_Not := 6
    static IRO_XOrPen := 7
    static IRO_NotMaskPen := 8
    static IRO_MaskPen := 9
    static IRO_NotXOrPen := 10
    static IRO_NoOperation := 11
    static IRO_MergeNotPen := 12
    static IRO_CopyPen := 13
    static IRO_MergePenNot := 14
    static IRO_MergePen := 15
    static IRO_White := 16
}
struct InkMousePointer extends Int32 {
    static IMP_Default := 0
    static IMP_Arrow := 1
    static IMP_Crosshair := 2
    static IMP_Ibeam := 3
    static IMP_SizeNESW := 4
    static IMP_SizeNS := 5
    static IMP_SizeNWSE := 6
    static IMP_SizeWE := 7
    static IMP_UpArrow := 8
    static IMP_Hourglass := 9
    static IMP_NoDrop := 10
    static IMP_ArrowHourglass := 11
    static IMP_ArrowQuestion := 12
    static IMP_SizeAll := 13
    static IMP_Hand := 14
    static IMP_Custom := 99
}
struct InkClipboardModes extends Int32 {
    static ICB_Copy := 0
    static ICB_Cut := 1
    static ICB_ExtractOnly := 48
    static ICB_DelayedCopy := 32
    static ICB_Default := 0
}
struct InkClipboardFormats extends Int32 {
    static ICF_None := 0
    static ICF_InkSerializedFormat := 1
    static ICF_SketchInk := 2
    static ICF_TextInk := 6
    static ICF_EnhancedMetafile := 8
    static ICF_Metafile := 32
    static ICF_Bitmap := 64
    static ICF_PasteMask := 7
    static ICF_CopyMask := 127
    static ICF_Default := 127
}
struct SelectionHitResult extends Int32 {
    static SHR_None := 0
    static SHR_NW := 1
    static SHR_SE := 2
    static SHR_NE := 3
    static SHR_SW := 4
    static SHR_E := 5
    static SHR_W := 6
    static SHR_N := 7
    static SHR_S := 8
    static SHR_Selection := 9
}
struct InkRecognitionStatus extends Int32 {
    static IRS_NoError := 0
    static IRS_Interrupted := 1
    static IRS_ProcessFailed := 2
    static IRS_InkAddedFailed := 4
    static IRS_SetAutoCompletionModeFailed := 8
    static IRS_SetStrokesFailed := 16
    static IRS_SetGuideFailed := 32
    static IRS_SetFlagsFailed := 64
    static IRS_SetFactoidFailed := 128
    static IRS_SetPrefixSuffixFailed := 256
    static IRS_SetWordListFailed := 512
}
struct DISPID_InkRectangle extends Int32 {
    static DISPID_IRTop := 1
    static DISPID_IRLeft := 2
    static DISPID_IRBottom := 3
    static DISPID_IRRight := 4
    static DISPID_IRGetRectangle := 5
    static DISPID_IRSetRectangle := 6
    static DISPID_IRData := 7
}
struct DISPID_InkExtendedProperty extends Int32 {
    static DISPID_IEPGuid := 1
    static DISPID_IEPData := 2
}
struct DISPID_InkExtendedProperties extends Int32 {
    static DISPID_IEPs_NewEnum := -4
    static DISPID_IEPsItem := 0
    static DISPID_IEPsCount := 1
    static DISPID_IEPsAdd := 2
    static DISPID_IEPsRemove := 3
    static DISPID_IEPsClear := 4
    static DISPID_IEPsDoesPropertyExist := 5
}
struct DISPID_InkDrawingAttributes extends Int32 {
    static DISPID_DAHeight := 1
    static DISPID_DAColor := 2
    static DISPID_DAWidth := 3
    static DISPID_DAFitToCurve := 4
    static DISPID_DAIgnorePressure := 5
    static DISPID_DAAntiAliased := 6
    static DISPID_DATransparency := 7
    static DISPID_DARasterOperation := 8
    static DISPID_DAPenTip := 9
    static DISPID_DAClone := 10
    static DISPID_DAExtendedProperties := 11
}
struct DISPID_InkTransform extends Int32 {
    static DISPID_ITReset := 1
    static DISPID_ITTranslate := 2
    static DISPID_ITRotate := 3
    static DISPID_ITReflect := 4
    static DISPID_ITShear := 5
    static DISPID_ITScale := 6
    static DISPID_ITeM11 := 7
    static DISPID_ITeM12 := 8
    static DISPID_ITeM21 := 9
    static DISPID_ITeM22 := 10
    static DISPID_ITeDx := 11
    static DISPID_ITeDy := 12
    static DISPID_ITGetTransform := 13
    static DISPID_ITSetTransform := 14
    static DISPID_ITData := 15
}
struct InkApplicationGesture extends Int32 {
    static IAG_AllGestures := 0
    static IAG_NoGesture := 61440
    static IAG_Scratchout := 61441
    static IAG_Triangle := 61442
    static IAG_Square := 61443
    static IAG_Star := 61444
    static IAG_Check := 61445
    static IAG_Curlicue := 61456
    static IAG_DoubleCurlicue := 61457
    static IAG_Circle := 61472
    static IAG_DoubleCircle := 61473
    static IAG_SemiCircleLeft := 61480
    static IAG_SemiCircleRight := 61481
    static IAG_ChevronUp := 61488
    static IAG_ChevronDown := 61489
    static IAG_ChevronLeft := 61490
    static IAG_ChevronRight := 61491
    static IAG_ArrowUp := 61496
    static IAG_ArrowDown := 61497
    static IAG_ArrowLeft := 61498
    static IAG_ArrowRight := 61499
    static IAG_Up := 61528
    static IAG_Down := 61529
    static IAG_Left := 61530
    static IAG_Right := 61531
    static IAG_UpDown := 61536
    static IAG_DownUp := 61537
    static IAG_LeftRight := 61538
    static IAG_RightLeft := 61539
    static IAG_UpLeftLong := 61540
    static IAG_UpRightLong := 61541
    static IAG_DownLeftLong := 61542
    static IAG_DownRightLong := 61543
    static IAG_UpLeft := 61544
    static IAG_UpRight := 61545
    static IAG_DownLeft := 61546
    static IAG_DownRight := 61547
    static IAG_LeftUp := 61548
    static IAG_LeftDown := 61549
    static IAG_RightUp := 61550
    static IAG_RightDown := 61551
    static IAG_Exclamation := 61604
    static IAG_Tap := 61680
    static IAG_DoubleTap := 61681
}
struct InkSystemGesture extends Int32 {
    static ISG_Tap := 16
    static ISG_DoubleTap := 17
    static ISG_RightTap := 18
    static ISG_Drag := 19
    static ISG_RightDrag := 20
    static ISG_HoldEnter := 21
    static ISG_HoldLeave := 22
    static ISG_HoverEnter := 23
    static ISG_HoverLeave := 24
    static ISG_Flick := 31
}
struct InkRecognitionConfidence extends Int32 {
    static IRC_Strong := 0
    static IRC_Intermediate := 1
    static IRC_Poor := 2
}
struct DISPID_InkGesture extends Int32 {
    static DISPID_IGId := 0
    static DISPID_IGGetHotPoint := 1
    static DISPID_IGConfidence := 2
}
struct DISPID_InkCursor extends Int32 {
    static DISPID_ICsrName := 0
    static DISPID_ICsrId := 1
    static DISPID_ICsrDrawingAttributes := 2
    static DISPID_ICsrButtons := 3
    static DISPID_ICsrInverted := 4
    static DISPID_ICsrTablet := 5
}
struct DISPID_InkCursors extends Int32 {
    static DISPID_ICs_NewEnum := -4
    static DISPID_ICsItem := 0
    static DISPID_ICsCount := 1
}
struct InkCursorButtonState extends Int32 {
    static ICBS_Unavailable := 0
    static ICBS_Up := 1
    static ICBS_Down := 2
}
struct DISPID_InkCursorButton extends Int32 {
    static DISPID_ICBName := 0
    static DISPID_ICBId := 1
    static DISPID_ICBState := 2
}
struct DISPID_InkCursorButtons extends Int32 {
    static DISPID_ICBs_NewEnum := -4
    static DISPID_ICBsItem := 0
    static DISPID_ICBsCount := 1
}
struct TabletHardwareCapabilities extends Int32 {
    static THWC_Integrated := 1
    static THWC_CursorMustTouch := 2
    static THWC_HardProximity := 4
    static THWC_CursorsHavePhysicalIds := 8
}
struct TabletPropertyMetricUnit extends Int32 {
    static TPMU_Default := 0
    static TPMU_Inches := 1
    static TPMU_Centimeters := 2
    static TPMU_Degrees := 3
    static TPMU_Radians := 4
    static TPMU_Seconds := 5
    static TPMU_Pounds := 6
    static TPMU_Grams := 7
}
struct DISPID_InkTablet extends Int32 {
    static DISPID_ITName := 0
    static DISPID_ITPlugAndPlayId := 1
    static DISPID_ITPropertyMetrics := 2
    static DISPID_ITIsPacketPropertySupported := 3
    static DISPID_ITMaximumInputRectangle := 4
    static DISPID_ITHardwareCapabilities := 5
}
struct TabletDeviceKind extends Int32 {
    static TDK_Mouse := 0
    static TDK_Pen := 1
    static TDK_Touch := 2
}
struct DISPID_InkTablet2 extends Int32 {
    static DISPID_IT2DeviceKind := 0
}
struct DISPID_InkTablet3 extends Int32 {
    static DISPID_IT3IsMultiTouch := 0
    static DISPID_IT3MaximumCursors := 1
}
struct DISPID_InkTablets extends Int32 {
    static DISPID_ITs_NewEnum := -4
    static DISPID_ITsItem := 0
    static DISPID_ITsDefaultTablet := 1
    static DISPID_ITsCount := 2
    static DISPID_ITsIsPacketPropertySupported := 3
}
struct DISPID_InkStrokeDisp extends Int32 {
    static DISPID_ISDInkIndex := 1
    static DISPID_ISDID := 2
    static DISPID_ISDGetBoundingBox := 3
    static DISPID_ISDDrawingAttributes := 4
    static DISPID_ISDFindIntersections := 5
    static DISPID_ISDGetRectangleIntersections := 6
    static DISPID_ISDClip := 7
    static DISPID_ISDHitTestCircle := 8
    static DISPID_ISDNearestPoint := 9
    static DISPID_ISDSplit := 10
    static DISPID_ISDExtendedProperties := 11
    static DISPID_ISDInk := 12
    static DISPID_ISDBezierPoints := 13
    static DISPID_ISDPolylineCusps := 14
    static DISPID_ISDBezierCusps := 15
    static DISPID_ISDSelfIntersections := 16
    static DISPID_ISDPacketCount := 17
    static DISPID_ISDPacketSize := 18
    static DISPID_ISDPacketDescription := 19
    static DISPID_ISDDeleted := 20
    static DISPID_ISDGetPacketDescriptionPropertyMetrics := 21
    static DISPID_ISDGetPoints := 22
    static DISPID_ISDSetPoints := 23
    static DISPID_ISDGetPacketData := 24
    static DISPID_ISDGetPacketValuesByProperty := 25
    static DISPID_ISDSetPacketValuesByProperty := 26
    static DISPID_ISDGetFlattenedBezierPoints := 27
    static DISPID_ISDScaleToRectangle := 28
    static DISPID_ISDTransform := 29
    static DISPID_ISDMove := 30
    static DISPID_ISDRotate := 31
    static DISPID_ISDShear := 32
    static DISPID_ISDScale := 33
}
struct DISPID_InkStrokes extends Int32 {
    static DISPID_ISs_NewEnum := -4
    static DISPID_ISsItem := 0
    static DISPID_ISsCount := 1
    static DISPID_ISsValid := 2
    static DISPID_ISsInk := 3
    static DISPID_ISsAdd := 4
    static DISPID_ISsAddStrokes := 5
    static DISPID_ISsRemove := 6
    static DISPID_ISsRemoveStrokes := 7
    static DISPID_ISsToString := 8
    static DISPID_ISsModifyDrawingAttributes := 9
    static DISPID_ISsGetBoundingBox := 10
    static DISPID_ISsScaleToRectangle := 11
    static DISPID_ISsTransform := 12
    static DISPID_ISsMove := 13
    static DISPID_ISsRotate := 14
    static DISPID_ISsShear := 15
    static DISPID_ISsScale := 16
    static DISPID_ISsClip := 17
    static DISPID_ISsRecognitionResult := 18
    static DISPID_ISsRemoveRecognitionResult := 19
}
struct DISPID_InkCustomStrokes extends Int32 {
    static DISPID_ICSs_NewEnum := -4
    static DISPID_ICSsItem := 0
    static DISPID_ICSsCount := 1
    static DISPID_ICSsAdd := 2
    static DISPID_ICSsRemove := 3
    static DISPID_ICSsClear := 4
}
struct DISPID_StrokeEvent extends Int32 {
    static DISPID_SEStrokesAdded := 1
    static DISPID_SEStrokesRemoved := 2
}
struct DISPID_Ink extends Int32 {
    static DISPID_IStrokes := 1
    static DISPID_IExtendedProperties := 2
    static DISPID_IGetBoundingBox := 3
    static DISPID_IDeleteStrokes := 4
    static DISPID_IDeleteStroke := 5
    static DISPID_IExtractStrokes := 6
    static DISPID_IExtractWithRectangle := 7
    static DISPID_IDirty := 8
    static DISPID_ICustomStrokes := 9
    static DISPID_IClone := 10
    static DISPID_IHitTestCircle := 11
    static DISPID_IHitTestWithRectangle := 12
    static DISPID_IHitTestWithLasso := 13
    static DISPID_INearestPoint := 14
    static DISPID_ICreateStrokes := 15
    static DISPID_ICreateStroke := 16
    static DISPID_IAddStrokesAtRectangle := 17
    static DISPID_IClip := 18
    static DISPID_ISave := 19
    static DISPID_ILoad := 20
    static DISPID_ICreateStrokeFromPoints := 21
    static DISPID_IClipboardCopyWithRectangle := 22
    static DISPID_IClipboardCopy := 23
    static DISPID_ICanPaste := 24
    static DISPID_IClipboardPaste := 25
}
struct DISPID_InkEvent extends Int32 {
    static DISPID_IEInkAdded := 1
    static DISPID_IEInkDeleted := 2
}
struct DISPID_InkRenderer extends Int32 {
    static DISPID_IRGetViewTransform := 1
    static DISPID_IRSetViewTransform := 2
    static DISPID_IRGetObjectTransform := 3
    static DISPID_IRSetObjectTransform := 4
    static DISPID_IRDraw := 5
    static DISPID_IRDrawStroke := 6
    static DISPID_IRPixelToInkSpace := 7
    static DISPID_IRInkSpaceToPixel := 8
    static DISPID_IRPixelToInkSpaceFromPoints := 9
    static DISPID_IRInkSpaceToPixelFromPoints := 10
    static DISPID_IRMeasure := 11
    static DISPID_IRMeasureStroke := 12
    static DISPID_IRMove := 13
    static DISPID_IRRotate := 14
    static DISPID_IRScale := 15
}
struct InkCollectorEventInterest extends Int32 {
    static ICEI_DefaultEvents := -1
    static ICEI_CursorDown := 0
    static ICEI_Stroke := 1
    static ICEI_NewPackets := 2
    static ICEI_NewInAirPackets := 3
    static ICEI_CursorButtonDown := 4
    static ICEI_CursorButtonUp := 5
    static ICEI_CursorInRange := 6
    static ICEI_CursorOutOfRange := 7
    static ICEI_SystemGesture := 8
    static ICEI_TabletAdded := 9
    static ICEI_TabletRemoved := 10
    static ICEI_MouseDown := 11
    static ICEI_MouseMove := 12
    static ICEI_MouseUp := 13
    static ICEI_MouseWheel := 14
    static ICEI_DblClick := 15
    static ICEI_AllEvents := 16
}
struct InkMouseButton extends Int32 {
    static IMF_Left := 1
    static IMF_Right := 2
    static IMF_Middle := 4
}
struct InkShiftKeyModifierFlags extends Int32 {
    static IKM_Shift := 1
    static IKM_Control := 2
    static IKM_Alt := 4
}
struct DISPID_InkCollectorEvent extends Int32 {
    static DISPID_ICEStroke := 1
    static DISPID_ICECursorDown := 2
    static DISPID_ICENewPackets := 3
    static DISPID_ICENewInAirPackets := 4
    static DISPID_ICECursorButtonDown := 5
    static DISPID_ICECursorButtonUp := 6
    static DISPID_ICECursorInRange := 7
    static DISPID_ICECursorOutOfRange := 8
    static DISPID_ICESystemGesture := 9
    static DISPID_ICEGesture := 10
    static DISPID_ICETabletAdded := 11
    static DISPID_ICETabletRemoved := 12
    static DISPID_IOEPainting := 13
    static DISPID_IOEPainted := 14
    static DISPID_IOESelectionChanging := 15
    static DISPID_IOESelectionChanged := 16
    static DISPID_IOESelectionMoving := 17
    static DISPID_IOESelectionMoved := 18
    static DISPID_IOESelectionResizing := 19
    static DISPID_IOESelectionResized := 20
    static DISPID_IOEStrokesDeleting := 21
    static DISPID_IOEStrokesDeleted := 22
    static DISPID_IPEChangeUICues := 23
    static DISPID_IPEClick := 24
    static DISPID_IPEDblClick := 25
    static DISPID_IPEInvalidated := 26
    static DISPID_IPEMouseDown := 27
    static DISPID_IPEMouseEnter := 28
    static DISPID_IPEMouseHover := 29
    static DISPID_IPEMouseLeave := 30
    static DISPID_IPEMouseMove := 31
    static DISPID_IPEMouseUp := 32
    static DISPID_IPEMouseWheel := 33
    static DISPID_IPESizeModeChanged := 34
    static DISPID_IPEStyleChanged := 35
    static DISPID_IPESystemColorsChanged := 36
    static DISPID_IPEKeyDown := 37
    static DISPID_IPEKeyPress := 38
    static DISPID_IPEKeyUp := 39
    static DISPID_IPEResize := 40
    static DISPID_IPESizeChanged := 41
}
struct InkOverlayEditingMode extends Int32 {
    static IOEM_Ink := 0
    static IOEM_Delete := 1
    static IOEM_Select := 2
}
struct InkOverlayAttachMode extends Int32 {
    static IOAM_Behind := 0
    static IOAM_InFront := 1
}
struct InkPictureSizeMode extends Int32 {
    static IPSM_AutoSize := 0
    static IPSM_CenterImage := 1
    static IPSM_Normal := 2
    static IPSM_StretchImage := 3
}
struct InkOverlayEraserMode extends Int32 {
    static IOERM_StrokeErase := 0
    static IOERM_PointErase := 1
}
struct InkCollectionMode extends Int32 {
    static ICM_InkOnly := 0
    static ICM_GestureOnly := 1
    static ICM_InkAndGesture := 2
}
struct DISPID_InkCollector extends Int32 {
    static DISPID_ICEnabled := 1
    static DISPID_ICHwnd := 2
    static DISPID_ICPaint := 3
    static DISPID_ICText := 4
    static DISPID_ICDefaultDrawingAttributes := 5
    static DISPID_ICRenderer := 6
    static DISPID_ICInk := 7
    static DISPID_ICAutoRedraw := 8
    static DISPID_ICCollectingInk := 9
    static DISPID_ICSetEventInterest := 10
    static DISPID_ICGetEventInterest := 11
    static DISPID_IOEditingMode := 12
    static DISPID_IOSelection := 13
    static DISPID_IOAttachMode := 14
    static DISPID_IOHitTestSelection := 15
    static DISPID_IODraw := 16
    static DISPID_IPPicture := 17
    static DISPID_IPSizeMode := 18
    static DISPID_IPBackColor := 19
    static DISPID_ICCursors := 20
    static DISPID_ICMarginX := 21
    static DISPID_ICMarginY := 22
    static DISPID_ICSetWindowInputRectangle := 23
    static DISPID_ICGetWindowInputRectangle := 24
    static DISPID_ICTablet := 25
    static DISPID_ICSetAllTabletsMode := 26
    static DISPID_ICSetSingleTabletIntegratedMode := 27
    static DISPID_ICCollectionMode := 28
    static DISPID_ICSetGestureStatus := 29
    static DISPID_ICGetGestureStatus := 30
    static DISPID_ICDynamicRendering := 31
    static DISPID_ICDesiredPacketDescription := 32
    static DISPID_IOEraserMode := 33
    static DISPID_IOEraserWidth := 34
    static DISPID_ICMouseIcon := 35
    static DISPID_ICMousePointer := 36
    static DISPID_IPInkEnabled := 37
    static DISPID_ICSupportHighContrastInk := 38
    static DISPID_IOSupportHighContrastSelectionUI := 39
}
struct DISPID_InkRecognizer extends Int32 {
    static DISPID_RecoClsid := 1
    static DISPID_RecoName := 2
    static DISPID_RecoVendor := 3
    static DISPID_RecoCapabilities := 4
    static DISPID_RecoLanguageID := 5
    static DISPID_RecoPreferredPacketDescription := 6
    static DISPID_RecoCreateRecognizerContext := 7
    static DISPID_RecoSupportedProperties := 8
}
struct InkRecognizerCapabilities extends Int32 {
    static IRC_DontCare := 1
    static IRC_Object := 2
    static IRC_FreeInput := 4
    static IRC_LinedInput := 8
    static IRC_BoxedInput := 16
    static IRC_CharacterAutoCompletionInput := 32
    static IRC_RightAndDown := 64
    static IRC_LeftAndDown := 128
    static IRC_DownAndLeft := 256
    static IRC_DownAndRight := 512
    static IRC_ArbitraryAngle := 1024
    static IRC_Lattice := 2048
    static IRC_AdviseInkChange := 4096
    static IRC_StrokeReorder := 8192
    static IRC_Personalizable := 16384
    static IRC_PrefersArbitraryAngle := 32768
    static IRC_PrefersParagraphBreaking := 65536
    static IRC_PrefersSegmentation := 131072
    static IRC_Cursive := 262144
    static IRC_TextPrediction := 524288
    static IRC_Alpha := 1048576
    static IRC_Beta := 2097152
}
struct DISPID_InkRecognizer2 extends Int32 {
    static DISPID_RecoId := 0
    static DISPID_RecoUnicodeRanges := 1
}
struct DISPID_InkRecognizers extends Int32 {
    static DISPID_IRecos_NewEnum := -4
    static DISPID_IRecosItem := 0
    static DISPID_IRecosCount := 1
    static DISPID_IRecosGetDefaultRecognizer := 2
}
struct InkRecognizerCharacterAutoCompletionMode extends Int32 {
    static IRCACM_Full := 0
    static IRCACM_Prefix := 1
    static IRCACM_Random := 2
}
struct InkRecognitionModes extends Int32 {
    static IRM_None := 0
    static IRM_WordModeOnly := 1
    static IRM_Coerce := 2
    static IRM_TopInkBreaksOnly := 4
    static IRM_PrefixOk := 8
    static IRM_LineMode := 16
    static IRM_DisablePersonalization := 32
    static IRM_AutoSpace := 64
    static IRM_Max := 128
}
struct DISPID_InkRecognitionEvent extends Int32 {
    static DISPID_IRERecognitionWithAlternates := 1
    static DISPID_IRERecognition := 2
}
struct DISPID_InkRecoContext extends Int32 {
    static DISPID_IRecoCtx_Strokes := 1
    static DISPID_IRecoCtx_CharacterAutoCompletionMode := 2
    static DISPID_IRecoCtx_Factoid := 3
    static DISPID_IRecoCtx_WordList := 4
    static DISPID_IRecoCtx_Recognizer := 5
    static DISPID_IRecoCtx_Guide := 6
    static DISPID_IRecoCtx_Flags := 7
    static DISPID_IRecoCtx_PrefixText := 8
    static DISPID_IRecoCtx_SuffixText := 9
    static DISPID_IRecoCtx_StopRecognition := 10
    static DISPID_IRecoCtx_Clone := 11
    static DISPID_IRecoCtx_Recognize := 12
    static DISPID_IRecoCtx_StopBackgroundRecognition := 13
    static DISPID_IRecoCtx_EndInkInput := 14
    static DISPID_IRecoCtx_BackgroundRecognize := 15
    static DISPID_IRecoCtx_BackgroundRecognizeWithAlternates := 16
    static DISPID_IRecoCtx_IsStringSupported := 17
}
struct DISPID_InkRecoContext2 extends Int32 {
    static DISPID_IRecoCtx2_EnabledUnicodeRanges := 0
}
struct InkRecognitionAlternatesSelection extends Int32 {
    static IRAS_Start := 0
    static IRAS_DefaultCount := 10
    static IRAS_All := -1
}
struct DISPID_InkRecognitionResult extends Int32 {
    static DISPID_InkRecognitionResult_TopString := 1
    static DISPID_InkRecognitionResult_TopAlternate := 2
    static DISPID_InkRecognitionResult_Strokes := 3
    static DISPID_InkRecognitionResult_TopConfidence := 4
    static DISPID_InkRecognitionResult_AlternatesFromSelection := 5
    static DISPID_InkRecognitionResult_ModifyTopAlternate := 6
    static DISPID_InkRecognitionResult_SetResultOnStrokes := 7
}
struct DISPID_InkRecoAlternate extends Int32 {
    static DISPID_InkRecoAlternate_String := 1
    static DISPID_InkRecoAlternate_LineNumber := 2
    static DISPID_InkRecoAlternate_Baseline := 3
    static DISPID_InkRecoAlternate_Midline := 4
    static DISPID_InkRecoAlternate_Ascender := 5
    static DISPID_InkRecoAlternate_Descender := 6
    static DISPID_InkRecoAlternate_Confidence := 7
    static DISPID_InkRecoAlternate_Strokes := 8
    static DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges := 9
    static DISPID_InkRecoAlternate_GetStrokesFromTextRange := 10
    static DISPID_InkRecoAlternate_GetTextRangeFromStrokes := 11
    static DISPID_InkRecoAlternate_GetPropertyValue := 12
    static DISPID_InkRecoAlternate_LineAlternates := 13
    static DISPID_InkRecoAlternate_ConfidenceAlternates := 14
    static DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues := 15
}
struct DISPID_InkRecognitionAlternates extends Int32 {
    static DISPID_InkRecognitionAlternates_NewEnum := -4
    static DISPID_InkRecognitionAlternates_Item := 0
    static DISPID_InkRecognitionAlternates_Count := 1
    static DISPID_InkRecognitionAlternates_Strokes := 2
}
struct InkRecoGuide {
    rectWritingBox : RECT
    rectDrawnBox : RECT
    cRows : Int32
    cColumns : Int32
    midline : Int32
}
struct DISPID_InkRecognizerGuide extends Int32 {
    static DISPID_IRGWritingBox := 1
    static DISPID_IRGDrawnBox := 2
    static DISPID_IRGRows := 3
    static DISPID_IRGColumns := 4
    static DISPID_IRGMidline := 5
    static DISPID_IRGGuideData := 6
}
struct DISPID_InkWordList extends Int32 {
    static DISPID_InkWordList_AddWord := 0
    static DISPID_InkWordList_RemoveWord := 1
    static DISPID_InkWordList_Merge := 2
}
struct DISPID_InkWordList2 extends Int32 {
    static DISPID_InkWordList2_AddWords := 3
}
struct IInkRectangle extends IDispatch {
    static IID := "{9794FF82-6071-4717-8A8B-6AC7C64A686E}"
    get_Top(Units)
      => ComCall(7, this.p, Int32.Ptr, Units)
    put_Top(Units)
      => ComCall(8, this.p, Int32, Units)
    get_Left(Units)
      => ComCall(9, this.p, Int32.Ptr, Units)
    put_Left(Units)
      => ComCall(10, this.p, Int32, Units)
    get_Bottom(Units)
      => ComCall(11, this.p, Int32.Ptr, Units)
    put_Bottom(Units)
      => ComCall(12, this.p, Int32, Units)
    get_Right(Units)
      => ComCall(13, this.p, Int32.Ptr, Units)
    put_Right(Units)
      => ComCall(14, this.p, Int32, Units)
    get_Data(Rect)
      => ComCall(15, this.p, RECT.Ptr, Rect)
    put_Data(Rect1)
      => ComCall(16, this.p, RECT, Rect1)
    GetRectangle(Top, Left, Bottom, Right)
      => ComCall(17, this.p, Int32.Ptr, Top, Int32.Ptr, Left, Int32.Ptr, Bottom, Int32.Ptr, Right)
    SetRectangle(Top, Left, Bottom, Right)
      => ComCall(18, this.p, Int32, Top, Int32, Left, Int32, Bottom, Int32, Right)
}
struct IInkExtendedProperty extends IDispatch {
    static IID := "{DB489209-B7C3-411D-90F6-1548CFFF271E}"
    get_Guid(Guid)
      => ComCall(7, this.p, BSTR.Ptr, Guid)
    get_Data(Data)
      => ComCall(8, this.p, VARIANT.Ptr, Data)
    put_Data(Data)
      => ComCall(9, this.p, VARIANT, Data)
}
struct IInkExtendedProperties extends IDispatch {
    static IID := "{89F2A8BE-95A9-4530-8B8F-88E971E3E25F}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    Item(Identifier, Item)
      => ComCall(9, this.p, VARIANT, Identifier, IInkExtendedProperty.Ptr, Item)
    Add(Guid, Data, InkExtendedProperty)
      => ComCall(10, this.p, BSTR, Guid, VARIANT, Data, IInkExtendedProperty.Ptr, InkExtendedProperty)
    Remove(Identifier)
      => ComCall(11, this.p, VARIANT, Identifier)
    Clear()
      => ComCall(12, this.p)
    DoesPropertyExist(Guid, DoesPropertyExist)
      => ComCall(13, this.p, BSTR, Guid, VARIANT_BOOL.Ptr, DoesPropertyExist)
}
struct IInkDrawingAttributes extends IDispatch {
    static IID := "{BF519B75-0A15-4623-ADC9-C00D436A8092}"
    get_Color(CurrentColor)
      => ComCall(7, this.p, Int32.Ptr, CurrentColor)
    put_Color(NewColor)
      => ComCall(8, this.p, Int32, NewColor)
    get_Width(CurrentWidth)
      => ComCall(9, this.p, Float32.Ptr, CurrentWidth)
    put_Width(NewWidth)
      => ComCall(10, this.p, Float32, NewWidth)
    get_Height(CurrentHeight)
      => ComCall(11, this.p, Float32.Ptr, CurrentHeight)
    put_Height(NewHeight)
      => ComCall(12, this.p, Float32, NewHeight)
    get_FitToCurve(Flag)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, Flag)
    put_FitToCurve(Flag)
      => ComCall(14, this.p, VARIANT_BOOL, Flag)
    get_IgnorePressure(Flag)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, Flag)
    put_IgnorePressure(Flag)
      => ComCall(16, this.p, VARIANT_BOOL, Flag)
    get_AntiAliased(Flag)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, Flag)
    put_AntiAliased(Flag)
      => ComCall(18, this.p, VARIANT_BOOL, Flag)
    get_Transparency(CurrentTransparency)
      => ComCall(19, this.p, Int32.Ptr, CurrentTransparency)
    put_Transparency(NewTransparency)
      => ComCall(20, this.p, Int32, NewTransparency)
    get_RasterOperation(CurrentRasterOperation)
      => ComCall(21, this.p, InkRasterOperation.Ptr, CurrentRasterOperation)
    put_RasterOperation(NewRasterOperation)
      => ComCall(22, this.p, InkRasterOperation, NewRasterOperation)
    get_PenTip(CurrentPenTip)
      => ComCall(23, this.p, InkPenTip.Ptr, CurrentPenTip)
    put_PenTip(NewPenTip)
      => ComCall(24, this.p, InkPenTip, NewPenTip)
    get_ExtendedProperties(Properties)
      => ComCall(25, this.p, IInkExtendedProperties.Ptr, Properties)
    Clone(DrawingAttributes)
      => ComCall(26, this.p, IInkDrawingAttributes.Ptr, DrawingAttributes)
}
struct IInkTransform extends IDispatch {
    static IID := "{615F1D43-8703-4565-88E2-8201D2ECD7B7}"
    Reset()
      => ComCall(7, this.p)
    Translate(HorizontalComponent, VerticalComponent)
      => ComCall(8, this.p, Float32, HorizontalComponent, Float32, VerticalComponent)
    Rotate(Degrees, x, y)
      => ComCall(9, this.p, Float32, Degrees, Float32, x, Float32, y)
    Reflect(Horizontally, Vertically)
      => ComCall(10, this.p, VARIANT_BOOL, Horizontally, VARIANT_BOOL, Vertically)
    Shear(HorizontalComponent, VerticalComponent)
      => ComCall(11, this.p, Float32, HorizontalComponent, Float32, VerticalComponent)
    ScaleTransform(HorizontalMultiplier, VerticalMultiplier)
      => ComCall(12, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier)
    GetTransform(eM11, eM12, eM21, eM22, eDx, eDy)
      => ComCall(13, this.p, Float32.Ptr, eM11, Float32.Ptr, eM12, Float32.Ptr, eM21, Float32.Ptr, eM22, Float32.Ptr, eDx, Float32.Ptr, eDy)
    SetTransform(eM11, eM12, eM21, eM22, eDx, eDy)
      => ComCall(14, this.p, Float32, eM11, Float32, eM12, Float32, eM21, Float32, eM22, Float32, eDx, Float32, eDy)
    get_eM11(Value)
      => ComCall(15, this.p, Float32.Ptr, Value)
    put_eM11(Value)
      => ComCall(16, this.p, Float32, Value)
    get_eM12(Value)
      => ComCall(17, this.p, Float32.Ptr, Value)
    put_eM12(Value)
      => ComCall(18, this.p, Float32, Value)
    get_eM21(Value)
      => ComCall(19, this.p, Float32.Ptr, Value)
    put_eM21(Value)
      => ComCall(20, this.p, Float32, Value)
    get_eM22(Value)
      => ComCall(21, this.p, Float32.Ptr, Value)
    put_eM22(Value)
      => ComCall(22, this.p, Float32, Value)
    get_eDx(Value)
      => ComCall(23, this.p, Float32.Ptr, Value)
    put_eDx(Value)
      => ComCall(24, this.p, Float32, Value)
    get_eDy(Value)
      => ComCall(25, this.p, Float32.Ptr, Value)
    put_eDy(Value)
      => ComCall(26, this.p, Float32, Value)
    get_Data(XForm)
      => ComCall(27, this.p, XFORM.Ptr, XForm)
    put_Data(XForm1)
      => ComCall(28, this.p, XFORM, XForm1)
}
struct IInkGesture extends IDispatch {
    static IID := "{3BDC0A97-04E5-4E26-B813-18F052D41DEF}"
    get_Confidence(Confidence)
      => ComCall(7, this.p, InkRecognitionConfidence.Ptr, Confidence)
    get_Id(Id)
      => ComCall(8, this.p, InkApplicationGesture.Ptr, Id)
    GetHotPoint(X, Y)
      => ComCall(9, this.p, Int32.Ptr, X, Int32.Ptr, Y)
}
struct IInkCursor extends IDispatch {
    static IID := "{AD30C630-40C5-4350-8405-9C71012FC558}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Id(Id)
      => ComCall(8, this.p, Int32.Ptr, Id)
    get_Inverted(Status)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, Status)
    get_DrawingAttributes(Attributes)
      => ComCall(10, this.p, IInkDrawingAttributes.Ptr, Attributes)
    putref_DrawingAttributes(Attributes?)
      => ComCall(11, this.p, IInkDrawingAttributes, Attributes?)
    get_Tablet(Tablet)
      => ComCall(12, this.p, IInkTablet.Ptr, Tablet)
    get_Buttons(Buttons)
      => ComCall(13, this.p, IInkCursorButtons.Ptr, Buttons)
}
struct IInkCursors extends IDispatch {
    static IID := "{A248C1AC-C698-4E06-9E5C-D57F77C7E647}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    Item(Index, Cursor)
      => ComCall(9, this.p, Int32, Index, IInkCursor.Ptr, Cursor)
}
struct IInkCursorButton extends IDispatch {
    static IID := "{85EF9417-1D59-49B2-A13C-702C85430894}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Id(Id)
      => ComCall(8, this.p, BSTR.Ptr, Id)
    get_State(CurrentState)
      => ComCall(9, this.p, InkCursorButtonState.Ptr, CurrentState)
}
struct IInkCursorButtons extends IDispatch {
    static IID := "{3671CC40-B624-4671-9FA0-DB119D952D54}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    Item(Identifier, Button)
      => ComCall(9, this.p, VARIANT, Identifier, IInkCursorButton.Ptr, Button)
}
struct IInkTablet extends IDispatch {
    static IID := "{2DE25EAA-6EF8-42D5-AEE9-185BC81B912D}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_PlugAndPlayId(Id)
      => ComCall(8, this.p, BSTR.Ptr, Id)
    get_MaximumInputRectangle(Rectangle)
      => ComCall(9, this.p, IInkRectangle.Ptr, Rectangle)
    get_HardwareCapabilities(Capabilities)
      => ComCall(10, this.p, TabletHardwareCapabilities.Ptr, Capabilities)
    IsPacketPropertySupported(packetPropertyName, Supported)
      => ComCall(11, this.p, BSTR, packetPropertyName, VARIANT_BOOL.Ptr, Supported)
    GetPropertyMetrics(propertyName, Minimum, Maximum, Units, Resolution)
      => ComCall(12, this.p, BSTR, propertyName, Int32.Ptr, Minimum, Int32.Ptr, Maximum, TabletPropertyMetricUnit.Ptr, Units, Float32.Ptr, Resolution)
}
struct IInkTablet2 extends IDispatch {
    static IID := "{90C91AD2-FA36-49D6-9516-CE8D570F6F85}"
    get_DeviceKind(Kind)
      => ComCall(7, this.p, TabletDeviceKind.Ptr, Kind)
}
struct IInkTablet3 extends IDispatch {
    static IID := "{7E313997-1327-41DD-8CA9-79F24BE17250}"
    get_IsMultiTouch(pIsMultiTouch)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pIsMultiTouch)
    get_MaximumCursors(pMaximumCursors)
      => ComCall(8, this.p, UInt32.Ptr, pMaximumCursors)
}
struct IInkTablets extends IDispatch {
    static IID := "{112086D9-7779-4535-A699-862B43AC1863}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    get_DefaultTablet(DefaultTablet)
      => ComCall(9, this.p, IInkTablet.Ptr, DefaultTablet)
    Item(Index, Tablet)
      => ComCall(10, this.p, Int32, Index, IInkTablet.Ptr, Tablet)
    IsPacketPropertySupported(packetPropertyName, Supported)
      => ComCall(11, this.p, BSTR, packetPropertyName, VARIANT_BOOL.Ptr, Supported)
}
struct IInkStrokeDisp extends IDispatch {
    static IID := "{43242FEA-91D1-4A72-963E-FBB91829CFA2}"
    get_ID(ID)
      => ComCall(7, this.p, Int32.Ptr, ID)
    get_BezierPoints(Points)
      => ComCall(8, this.p, VARIANT.Ptr, Points)
    get_DrawingAttributes(DrawAttrs)
      => ComCall(9, this.p, IInkDrawingAttributes.Ptr, DrawAttrs)
    putref_DrawingAttributes(DrawAttrs?)
      => ComCall(10, this.p, IInkDrawingAttributes, DrawAttrs?)
    get_Ink(Ink)
      => ComCall(11, this.p, IInkDisp.Ptr, Ink)
    get_ExtendedProperties(Properties)
      => ComCall(12, this.p, IInkExtendedProperties.Ptr, Properties)
    get_PolylineCusps(Cusps)
      => ComCall(13, this.p, VARIANT.Ptr, Cusps)
    get_BezierCusps(Cusps)
      => ComCall(14, this.p, VARIANT.Ptr, Cusps)
    get_SelfIntersections(Intersections)
      => ComCall(15, this.p, VARIANT.Ptr, Intersections)
    get_PacketCount(plCount)
      => ComCall(16, this.p, Int32.Ptr, plCount)
    get_PacketSize(plSize)
      => ComCall(17, this.p, Int32.Ptr, plSize)
    get_PacketDescription(PacketDescription)
      => ComCall(18, this.p, VARIANT.Ptr, PacketDescription)
    get_Deleted(Deleted)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, Deleted)
    GetBoundingBox(BoundingBoxMode, Rectangle)
      => ComCall(20, this.p, InkBoundingBoxMode, BoundingBoxMode, IInkRectangle.Ptr, Rectangle)
    FindIntersections(Strokes?, Intersections)
      => ComCall(21, this.p, IInkStrokes, Strokes?, VARIANT.Ptr, Intersections)
    GetRectangleIntersections(Rectangle?, Intersections)
      => ComCall(22, this.p, IInkRectangle, Rectangle?, VARIANT.Ptr, Intersections)
    Clip(Rectangle?)
      => ComCall(23, this.p, IInkRectangle, Rectangle?)
    HitTestCircle(X, Y, Radius, Intersects)
      => ComCall(24, this.p, Int32, X, Int32, Y, Float32, Radius, VARIANT_BOOL.Ptr, Intersects)
    NearestPoint(X, Y, Distance, Point)
      => ComCall(25, this.p, Int32, X, Int32, Y, Float32.Ptr, Distance, Float32.Ptr, Point)
    Split(SplitAt, NewStroke)
      => ComCall(26, this.p, Float32, SplitAt, IInkStrokeDisp.Ptr, NewStroke)
    GetPacketDescriptionPropertyMetrics(PropertyName, Minimum, Maximum, Units, Resolution)
      => ComCall(27, this.p, BSTR, PropertyName, Int32.Ptr, Minimum, Int32.Ptr, Maximum, TabletPropertyMetricUnit.Ptr, Units, Float32.Ptr, Resolution)
    GetPoints(Index, Count, Points)
      => ComCall(28, this.p, Int32, Index, Int32, Count, VARIANT.Ptr, Points)
    SetPoints(Points, Index, Count, NumberOfPointsSet)
      => ComCall(29, this.p, VARIANT, Points, Int32, Index, Int32, Count, Int32.Ptr, NumberOfPointsSet)
    GetPacketData(Index, Count, PacketData)
      => ComCall(30, this.p, Int32, Index, Int32, Count, VARIANT.Ptr, PacketData)
    GetPacketValuesByProperty(PropertyName, Index, Count, PacketValues)
      => ComCall(31, this.p, BSTR, PropertyName, Int32, Index, Int32, Count, VARIANT.Ptr, PacketValues)
    SetPacketValuesByProperty(bstrPropertyName, PacketValues, Index, Count, NumberOfPacketsSet)
      => ComCall(32, this.p, BSTR, bstrPropertyName, VARIANT, PacketValues, Int32, Index, Int32, Count, Int32.Ptr, NumberOfPacketsSet)
    GetFlattenedBezierPoints(FittingError, FlattenedBezierPoints)
      => ComCall(33, this.p, Int32, FittingError, VARIANT.Ptr, FlattenedBezierPoints)
    Transform(Transform?, ApplyOnPenWidth)
      => ComCall(34, this.p, IInkTransform, Transform?, VARIANT_BOOL, ApplyOnPenWidth)
    ScaleToRectangle(Rectangle?)
      => ComCall(35, this.p, IInkRectangle, Rectangle?)
    Move(HorizontalComponent, VerticalComponent)
      => ComCall(36, this.p, Float32, HorizontalComponent, Float32, VerticalComponent)
    Rotate(Degrees, x, y)
      => ComCall(37, this.p, Float32, Degrees, Float32, x, Float32, y)
    Shear(HorizontalMultiplier, VerticalMultiplier)
      => ComCall(38, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier)
    ScaleTransform(HorizontalMultiplier, VerticalMultiplier)
      => ComCall(39, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier)
}
struct IInkStrokes extends IDispatch {
    static IID := "{F1F4C9D8-590A-4963-B3AE-1935671BB6F3}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    get_Ink(Ink)
      => ComCall(9, this.p, IInkDisp.Ptr, Ink)
    get_RecognitionResult(RecognitionResult)
      => ComCall(10, this.p, IInkRecognitionResult.Ptr, RecognitionResult)
    ToString(ToString)
      => ComCall(11, this.p, BSTR.Ptr, ToString)
    Item(Index, Stroke)
      => ComCall(12, this.p, Int32, Index, IInkStrokeDisp.Ptr, Stroke)
    Add(InkStroke?)
      => ComCall(13, this.p, IInkStrokeDisp, InkStroke?)
    AddStrokes(InkStrokes?)
      => ComCall(14, this.p, IInkStrokes, InkStrokes?)
    Remove(InkStroke?)
      => ComCall(15, this.p, IInkStrokeDisp, InkStroke?)
    RemoveStrokes(InkStrokes?)
      => ComCall(16, this.p, IInkStrokes, InkStrokes?)
    ModifyDrawingAttributes(DrawAttrs?)
      => ComCall(17, this.p, IInkDrawingAttributes, DrawAttrs?)
    GetBoundingBox(BoundingBoxMode, BoundingBox)
      => ComCall(18, this.p, InkBoundingBoxMode, BoundingBoxMode, IInkRectangle.Ptr, BoundingBox)
    Transform(Transform?, ApplyOnPenWidth)
      => ComCall(19, this.p, IInkTransform, Transform?, VARIANT_BOOL, ApplyOnPenWidth)
    ScaleToRectangle(Rectangle?)
      => ComCall(20, this.p, IInkRectangle, Rectangle?)
    Move(HorizontalComponent, VerticalComponent)
      => ComCall(21, this.p, Float32, HorizontalComponent, Float32, VerticalComponent)
    Rotate(Degrees, x, y)
      => ComCall(22, this.p, Float32, Degrees, Float32, x, Float32, y)
    Shear(HorizontalMultiplier, VerticalMultiplier)
      => ComCall(23, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier)
    ScaleTransform(HorizontalMultiplier, VerticalMultiplier)
      => ComCall(24, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier)
    Clip(Rectangle?)
      => ComCall(25, this.p, IInkRectangle, Rectangle?)
    RemoveRecognitionResult()
      => ComCall(26, this.p)
}
struct IInkCustomStrokes extends IDispatch {
    static IID := "{7E23A88F-C30E-420F-9BDB-28902543F0C1}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    Item(Identifier, Strokes)
      => ComCall(9, this.p, VARIANT, Identifier, IInkStrokes.Ptr, Strokes)
    Add(Name, Strokes?)
      => ComCall(10, this.p, BSTR, Name, IInkStrokes, Strokes?)
    Remove(Identifier)
      => ComCall(11, this.p, VARIANT, Identifier)
    Clear()
      => ComCall(12, this.p)
}
struct IInkStrokesEvents extends IDispatch {
    static IID := "{F33053EC-5D25-430A-928F-76A6491DDE15}"
}
struct IInkDisp extends IDispatch {
    static IID := "{9D398FA0-C4E2-4FCD-9973-975CAAF47EA6}"
    get_Strokes(Strokes)
      => ComCall(7, this.p, IInkStrokes.Ptr, Strokes)
    get_ExtendedProperties(Properties)
      => ComCall(8, this.p, IInkExtendedProperties.Ptr, Properties)
    get_Dirty(Dirty)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, Dirty)
    put_Dirty(Dirty)
      => ComCall(10, this.p, VARIANT_BOOL, Dirty)
    get_CustomStrokes(ppunkInkCustomStrokes)
      => ComCall(11, this.p, IInkCustomStrokes.Ptr, ppunkInkCustomStrokes)
    GetBoundingBox(BoundingBoxMode, Rectangle)
      => ComCall(12, this.p, InkBoundingBoxMode, BoundingBoxMode, IInkRectangle.Ptr, Rectangle)
    DeleteStrokes(Strokes?)
      => ComCall(13, this.p, IInkStrokes, Strokes?)
    DeleteStroke(Stroke?)
      => ComCall(14, this.p, IInkStrokeDisp, Stroke?)
    ExtractStrokes(Strokes?, ExtractFlags, ExtractedInk)
      => ComCall(15, this.p, IInkStrokes, Strokes?, InkExtractFlags, ExtractFlags, IInkDisp.Ptr, ExtractedInk)
    ExtractWithRectangle(Rectangle?, extractFlags, ExtractedInk)
      => ComCall(16, this.p, IInkRectangle, Rectangle?, InkExtractFlags, extractFlags, IInkDisp.Ptr, ExtractedInk)
    Clip(Rectangle?)
      => ComCall(17, this.p, IInkRectangle, Rectangle?)
    Clone(NewInk)
      => ComCall(18, this.p, IInkDisp.Ptr, NewInk)
    HitTestCircle(X, Y, radius, Strokes)
      => ComCall(19, this.p, Int32, X, Int32, Y, Float32, radius, IInkStrokes.Ptr, Strokes)
    HitTestWithRectangle(SelectionRectangle?, IntersectPercent, Strokes)
      => ComCall(20, this.p, IInkRectangle, SelectionRectangle?, Float32, IntersectPercent, IInkStrokes.Ptr, Strokes)
    HitTestWithLasso(Points, IntersectPercent, LassoPoints?, Strokes)
      => ComCall(21, this.p, VARIANT, Points, Float32, IntersectPercent, VARIANT.Ptr, LassoPoints?, IInkStrokes.Ptr, Strokes)
    NearestPoint(X, Y, PointOnStroke, DistanceFromPacket, Stroke)
      => ComCall(22, this.p, Int32, X, Int32, Y, Float32.Ptr, PointOnStroke, Float32.Ptr, DistanceFromPacket, IInkStrokeDisp.Ptr, Stroke)
    CreateStrokes(StrokeIds, Strokes)
      => ComCall(23, this.p, VARIANT, StrokeIds, IInkStrokes.Ptr, Strokes)
    AddStrokesAtRectangle(SourceStrokes?, TargetRectangle?)
      => ComCall(24, this.p, IInkStrokes, SourceStrokes?, IInkRectangle, TargetRectangle?)
    Save(PersistenceFormat, CompressionMode, Data)
      => ComCall(25, this.p, InkPersistenceFormat, PersistenceFormat, InkPersistenceCompressionMode, CompressionMode, VARIANT.Ptr, Data)
    Load(Data)
      => ComCall(26, this.p, VARIANT, Data)
    CreateStroke(PacketData, PacketDescription, Stroke)
      => ComCall(27, this.p, VARIANT, PacketData, VARIANT, PacketDescription, IInkStrokeDisp.Ptr, Stroke)
    ClipboardCopyWithRectangle(Rectangle?, ClipboardFormats, ClipboardModes, DataObject)
      => ComCall(28, this.p, IInkRectangle, Rectangle?, InkClipboardFormats, ClipboardFormats, InkClipboardModes, ClipboardModes, IDataObject.Ptr, DataObject)
    ClipboardCopy(strokes?, ClipboardFormats, ClipboardModes, DataObject)
      => ComCall(29, this.p, IInkStrokes, strokes?, InkClipboardFormats, ClipboardFormats, InkClipboardModes, ClipboardModes, IDataObject.Ptr, DataObject)
    CanPaste(DataObject?, CanPaste)
      => ComCall(30, this.p, IDataObject, DataObject?, VARIANT_BOOL.Ptr, CanPaste)
    ClipboardPaste(x, y, DataObject?, Strokes)
      => ComCall(31, this.p, Int32, x, Int32, y, IDataObject, DataObject?, IInkStrokes.Ptr, Strokes)
}
struct IInkEvents extends IDispatch {
    static IID := "{427B1865-CA3F-479A-83A9-0F420F2A0073}"
}
struct IInkRenderer extends IDispatch {
    static IID := "{E6257A9C-B511-4F4C-A8B0-A7DBC9506B83}"
    GetViewTransform(ViewTransform?)
      => ComCall(7, this.p, IInkTransform, ViewTransform?)
    SetViewTransform(ViewTransform?)
      => ComCall(8, this.p, IInkTransform, ViewTransform?)
    GetObjectTransform(ObjectTransform?)
      => ComCall(9, this.p, IInkTransform, ObjectTransform?)
    SetObjectTransform(ObjectTransform?)
      => ComCall(10, this.p, IInkTransform, ObjectTransform?)
    Draw(hDC, Strokes?)
      => ComCall(11, this.p, IntPtr, hDC, IInkStrokes, Strokes?)
    DrawStroke(hDC, Stroke?, DrawingAttributes?)
      => ComCall(12, this.p, IntPtr, hDC, IInkStrokeDisp, Stroke?, IInkDrawingAttributes, DrawingAttributes?)
    PixelToInkSpace(hDC, x, y)
      => ComCall(13, this.p, IntPtr, hDC, Int32.Ptr, x, Int32.Ptr, y)
    InkSpaceToPixel(hdcDisplay, x, y)
      => ComCall(14, this.p, IntPtr, hdcDisplay, Int32.Ptr, x, Int32.Ptr, y)
    PixelToInkSpaceFromPoints(hDC, Points)
      => ComCall(15, this.p, IntPtr, hDC, VARIANT.Ptr, Points)
    InkSpaceToPixelFromPoints(hDC, Points)
      => ComCall(16, this.p, IntPtr, hDC, VARIANT.Ptr, Points)
    Measure(Strokes?, Rectangle)
      => ComCall(17, this.p, IInkStrokes, Strokes?, IInkRectangle.Ptr, Rectangle)
    MeasureStroke(Stroke?, DrawingAttributes?, Rectangle)
      => ComCall(18, this.p, IInkStrokeDisp, Stroke?, IInkDrawingAttributes, DrawingAttributes?, IInkRectangle.Ptr, Rectangle)
    Move(HorizontalComponent, VerticalComponent)
      => ComCall(19, this.p, Float32, HorizontalComponent, Float32, VerticalComponent)
    Rotate(Degrees, x, y)
      => ComCall(20, this.p, Float32, Degrees, Float32, x, Float32, y)
    ScaleTransform(HorizontalMultiplier, VerticalMultiplier, ApplyOnPenWidth)
      => ComCall(21, this.p, Float32, HorizontalMultiplier, Float32, VerticalMultiplier, VARIANT_BOOL, ApplyOnPenWidth)
}
struct IInkCollector extends IDispatch {
    static IID := "{F0F060B5-8B1F-4A7C-89EC-880692588A4F}"
    get_hWnd(CurrentWindow)
      => ComCall(7, this.p, IntPtr.Ptr, CurrentWindow)
    put_hWnd(NewWindow)
      => ComCall(8, this.p, IntPtr, NewWindow)
    get_Enabled(Collecting)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, Collecting)
    put_Enabled(Collecting)
      => ComCall(10, this.p, VARIANT_BOOL, Collecting)
    get_DefaultDrawingAttributes(CurrentAttributes)
      => ComCall(11, this.p, IInkDrawingAttributes.Ptr, CurrentAttributes)
    putref_DefaultDrawingAttributes(NewAttributes?)
      => ComCall(12, this.p, IInkDrawingAttributes, NewAttributes?)
    get_Renderer(CurrentInkRenderer)
      => ComCall(13, this.p, IInkRenderer.Ptr, CurrentInkRenderer)
    putref_Renderer(NewInkRenderer?)
      => ComCall(14, this.p, IInkRenderer, NewInkRenderer?)
    get_Ink(Ink)
      => ComCall(15, this.p, IInkDisp.Ptr, Ink)
    putref_Ink(NewInk?)
      => ComCall(16, this.p, IInkDisp, NewInk?)
    get_AutoRedraw(AutoRedraw)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, AutoRedraw)
    put_AutoRedraw(AutoRedraw)
      => ComCall(18, this.p, VARIANT_BOOL, AutoRedraw)
    get_CollectingInk(Collecting)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, Collecting)
    get_CollectionMode(Mode)
      => ComCall(20, this.p, InkCollectionMode.Ptr, Mode)
    put_CollectionMode(Mode)
      => ComCall(21, this.p, InkCollectionMode, Mode)
    get_DynamicRendering(Enabled)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, Enabled)
    put_DynamicRendering(Enabled)
      => ComCall(23, this.p, VARIANT_BOOL, Enabled)
    get_DesiredPacketDescription(PacketGuids)
      => ComCall(24, this.p, VARIANT.Ptr, PacketGuids)
    put_DesiredPacketDescription(PacketGuids)
      => ComCall(25, this.p, VARIANT, PacketGuids)
    get_MouseIcon(MouseIcon)
      => ComCall(26, this.p, IPictureDisp.Ptr, MouseIcon)
    put_MouseIcon(MouseIcon?)
      => ComCall(27, this.p, IPictureDisp, MouseIcon?)
    putref_MouseIcon(MouseIcon?)
      => ComCall(28, this.p, IPictureDisp, MouseIcon?)
    get_MousePointer(MousePointer)
      => ComCall(29, this.p, InkMousePointer.Ptr, MousePointer)
    put_MousePointer(MousePointer)
      => ComCall(30, this.p, InkMousePointer, MousePointer)
    get_Cursors(Cursors)
      => ComCall(31, this.p, IInkCursors.Ptr, Cursors)
    get_MarginX(MarginX)
      => ComCall(32, this.p, Int32.Ptr, MarginX)
    put_MarginX(MarginX)
      => ComCall(33, this.p, Int32, MarginX)
    get_MarginY(MarginY)
      => ComCall(34, this.p, Int32.Ptr, MarginY)
    put_MarginY(MarginY)
      => ComCall(35, this.p, Int32, MarginY)
    get_Tablet(SingleTablet)
      => ComCall(36, this.p, IInkTablet.Ptr, SingleTablet)
    get_SupportHighContrastInk(Support)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, Support)
    put_SupportHighContrastInk(Support)
      => ComCall(38, this.p, VARIANT_BOOL, Support)
    SetGestureStatus(Gesture, Listen)
      => ComCall(39, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL, Listen)
    GetGestureStatus(Gesture, Listening)
      => ComCall(40, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL.Ptr, Listening)
    GetWindowInputRectangle(WindowInputRectangle)
      => ComCall(41, this.p, IInkRectangle.Ptr, WindowInputRectangle)
    SetWindowInputRectangle(WindowInputRectangle?)
      => ComCall(42, this.p, IInkRectangle, WindowInputRectangle?)
    SetAllTabletsMode(UseMouseForInput)
      => ComCall(43, this.p, VARIANT_BOOL, UseMouseForInput)
    SetSingleTabletIntegratedMode(Tablet?)
      => ComCall(44, this.p, IInkTablet, Tablet?)
    GetEventInterest(EventId, Listen)
      => ComCall(45, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL.Ptr, Listen)
    SetEventInterest(EventId, Listen)
      => ComCall(46, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL, Listen)
}
struct IInkCollectorEvents extends IDispatch {
    static IID := "{11A583F2-712D-4FEA-ABCF-AB4AF38EA06B}"
}
struct IInkOverlay extends IDispatch {
    static IID := "{B82A463B-C1C5-45A3-997C-DEAB5651B67A}"
    get_hWnd(CurrentWindow)
      => ComCall(7, this.p, IntPtr.Ptr, CurrentWindow)
    put_hWnd(NewWindow)
      => ComCall(8, this.p, IntPtr, NewWindow)
    get_Enabled(Collecting)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, Collecting)
    put_Enabled(Collecting)
      => ComCall(10, this.p, VARIANT_BOOL, Collecting)
    get_DefaultDrawingAttributes(CurrentAttributes)
      => ComCall(11, this.p, IInkDrawingAttributes.Ptr, CurrentAttributes)
    putref_DefaultDrawingAttributes(NewAttributes?)
      => ComCall(12, this.p, IInkDrawingAttributes, NewAttributes?)
    get_Renderer(CurrentInkRenderer)
      => ComCall(13, this.p, IInkRenderer.Ptr, CurrentInkRenderer)
    putref_Renderer(NewInkRenderer?)
      => ComCall(14, this.p, IInkRenderer, NewInkRenderer?)
    get_Ink(Ink)
      => ComCall(15, this.p, IInkDisp.Ptr, Ink)
    putref_Ink(NewInk?)
      => ComCall(16, this.p, IInkDisp, NewInk?)
    get_AutoRedraw(AutoRedraw)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, AutoRedraw)
    put_AutoRedraw(AutoRedraw)
      => ComCall(18, this.p, VARIANT_BOOL, AutoRedraw)
    get_CollectingInk(Collecting)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, Collecting)
    get_CollectionMode(Mode)
      => ComCall(20, this.p, InkCollectionMode.Ptr, Mode)
    put_CollectionMode(Mode)
      => ComCall(21, this.p, InkCollectionMode, Mode)
    get_DynamicRendering(Enabled)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, Enabled)
    put_DynamicRendering(Enabled)
      => ComCall(23, this.p, VARIANT_BOOL, Enabled)
    get_DesiredPacketDescription(PacketGuids)
      => ComCall(24, this.p, VARIANT.Ptr, PacketGuids)
    put_DesiredPacketDescription(PacketGuids)
      => ComCall(25, this.p, VARIANT, PacketGuids)
    get_MouseIcon(MouseIcon)
      => ComCall(26, this.p, IPictureDisp.Ptr, MouseIcon)
    put_MouseIcon(MouseIcon?)
      => ComCall(27, this.p, IPictureDisp, MouseIcon?)
    putref_MouseIcon(MouseIcon?)
      => ComCall(28, this.p, IPictureDisp, MouseIcon?)
    get_MousePointer(MousePointer)
      => ComCall(29, this.p, InkMousePointer.Ptr, MousePointer)
    put_MousePointer(MousePointer)
      => ComCall(30, this.p, InkMousePointer, MousePointer)
    get_EditingMode(EditingMode)
      => ComCall(31, this.p, InkOverlayEditingMode.Ptr, EditingMode)
    put_EditingMode(EditingMode)
      => ComCall(32, this.p, InkOverlayEditingMode, EditingMode)
    get_Selection(Selection)
      => ComCall(33, this.p, IInkStrokes.Ptr, Selection)
    put_Selection(Selection?)
      => ComCall(34, this.p, IInkStrokes, Selection?)
    get_EraserMode(EraserMode)
      => ComCall(35, this.p, InkOverlayEraserMode.Ptr, EraserMode)
    put_EraserMode(EraserMode)
      => ComCall(36, this.p, InkOverlayEraserMode, EraserMode)
    get_EraserWidth(EraserWidth)
      => ComCall(37, this.p, Int32.Ptr, EraserWidth)
    put_EraserWidth(newEraserWidth)
      => ComCall(38, this.p, Int32, newEraserWidth)
    get_AttachMode(AttachMode)
      => ComCall(39, this.p, InkOverlayAttachMode.Ptr, AttachMode)
    put_AttachMode(AttachMode)
      => ComCall(40, this.p, InkOverlayAttachMode, AttachMode)
    get_Cursors(Cursors)
      => ComCall(41, this.p, IInkCursors.Ptr, Cursors)
    get_MarginX(MarginX)
      => ComCall(42, this.p, Int32.Ptr, MarginX)
    put_MarginX(MarginX)
      => ComCall(43, this.p, Int32, MarginX)
    get_MarginY(MarginY)
      => ComCall(44, this.p, Int32.Ptr, MarginY)
    put_MarginY(MarginY)
      => ComCall(45, this.p, Int32, MarginY)
    get_Tablet(SingleTablet)
      => ComCall(46, this.p, IInkTablet.Ptr, SingleTablet)
    get_SupportHighContrastInk(Support)
      => ComCall(47, this.p, VARIANT_BOOL.Ptr, Support)
    put_SupportHighContrastInk(Support)
      => ComCall(48, this.p, VARIANT_BOOL, Support)
    get_SupportHighContrastSelectionUI(Support)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, Support)
    put_SupportHighContrastSelectionUI(Support)
      => ComCall(50, this.p, VARIANT_BOOL, Support)
    HitTestSelection(x, y, SelArea)
      => ComCall(51, this.p, Int32, x, Int32, y, SelectionHitResult.Ptr, SelArea)
    Draw(Rect?)
      => ComCall(52, this.p, IInkRectangle, Rect?)
    SetGestureStatus(Gesture, Listen)
      => ComCall(53, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL, Listen)
    GetGestureStatus(Gesture, Listening)
      => ComCall(54, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL.Ptr, Listening)
    GetWindowInputRectangle(WindowInputRectangle)
      => ComCall(55, this.p, IInkRectangle.Ptr, WindowInputRectangle)
    SetWindowInputRectangle(WindowInputRectangle?)
      => ComCall(56, this.p, IInkRectangle, WindowInputRectangle?)
    SetAllTabletsMode(UseMouseForInput)
      => ComCall(57, this.p, VARIANT_BOOL, UseMouseForInput)
    SetSingleTabletIntegratedMode(Tablet?)
      => ComCall(58, this.p, IInkTablet, Tablet?)
    GetEventInterest(EventId, Listen)
      => ComCall(59, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL.Ptr, Listen)
    SetEventInterest(EventId, Listen)
      => ComCall(60, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL, Listen)
}
struct IInkOverlayEvents extends IDispatch {
    static IID := "{31179B69-E563-489E-B16F-712F1E8A0651}"
}
struct IInkPicture extends IDispatch {
    static IID := "{E85662E0-379A-40D7-9B5C-757D233F9923}"
    get_hWnd(CurrentWindow)
      => ComCall(7, this.p, IntPtr.Ptr, CurrentWindow)
    get_DefaultDrawingAttributes(CurrentAttributes)
      => ComCall(8, this.p, IInkDrawingAttributes.Ptr, CurrentAttributes)
    putref_DefaultDrawingAttributes(NewAttributes?)
      => ComCall(9, this.p, IInkDrawingAttributes, NewAttributes?)
    get_Renderer(CurrentInkRenderer)
      => ComCall(10, this.p, IInkRenderer.Ptr, CurrentInkRenderer)
    putref_Renderer(NewInkRenderer?)
      => ComCall(11, this.p, IInkRenderer, NewInkRenderer?)
    get_Ink(Ink)
      => ComCall(12, this.p, IInkDisp.Ptr, Ink)
    putref_Ink(NewInk?)
      => ComCall(13, this.p, IInkDisp, NewInk?)
    get_AutoRedraw(AutoRedraw)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, AutoRedraw)
    put_AutoRedraw(AutoRedraw)
      => ComCall(15, this.p, VARIANT_BOOL, AutoRedraw)
    get_CollectingInk(Collecting)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, Collecting)
    get_CollectionMode(Mode)
      => ComCall(17, this.p, InkCollectionMode.Ptr, Mode)
    put_CollectionMode(Mode)
      => ComCall(18, this.p, InkCollectionMode, Mode)
    get_DynamicRendering(Enabled)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, Enabled)
    put_DynamicRendering(Enabled)
      => ComCall(20, this.p, VARIANT_BOOL, Enabled)
    get_DesiredPacketDescription(PacketGuids)
      => ComCall(21, this.p, VARIANT.Ptr, PacketGuids)
    put_DesiredPacketDescription(PacketGuids)
      => ComCall(22, this.p, VARIANT, PacketGuids)
    get_MouseIcon(MouseIcon)
      => ComCall(23, this.p, IPictureDisp.Ptr, MouseIcon)
    put_MouseIcon(MouseIcon?)
      => ComCall(24, this.p, IPictureDisp, MouseIcon?)
    putref_MouseIcon(MouseIcon?)
      => ComCall(25, this.p, IPictureDisp, MouseIcon?)
    get_MousePointer(MousePointer)
      => ComCall(26, this.p, InkMousePointer.Ptr, MousePointer)
    put_MousePointer(MousePointer)
      => ComCall(27, this.p, InkMousePointer, MousePointer)
    get_EditingMode(EditingMode)
      => ComCall(28, this.p, InkOverlayEditingMode.Ptr, EditingMode)
    put_EditingMode(EditingMode)
      => ComCall(29, this.p, InkOverlayEditingMode, EditingMode)
    get_Selection(Selection)
      => ComCall(30, this.p, IInkStrokes.Ptr, Selection)
    put_Selection(Selection?)
      => ComCall(31, this.p, IInkStrokes, Selection?)
    get_EraserMode(EraserMode)
      => ComCall(32, this.p, InkOverlayEraserMode.Ptr, EraserMode)
    put_EraserMode(EraserMode)
      => ComCall(33, this.p, InkOverlayEraserMode, EraserMode)
    get_EraserWidth(EraserWidth)
      => ComCall(34, this.p, Int32.Ptr, EraserWidth)
    put_EraserWidth(newEraserWidth)
      => ComCall(35, this.p, Int32, newEraserWidth)
    putref_Picture(pPicture?)
      => ComCall(36, this.p, IPictureDisp, pPicture?)
    put_Picture(pPicture?)
      => ComCall(37, this.p, IPictureDisp, pPicture?)
    get_Picture(ppPicture)
      => ComCall(38, this.p, IPictureDisp.Ptr, ppPicture)
    put_SizeMode(smNewSizeMode)
      => ComCall(39, this.p, InkPictureSizeMode, smNewSizeMode)
    get_SizeMode(smSizeMode)
      => ComCall(40, this.p, InkPictureSizeMode.Ptr, smSizeMode)
    put_BackColor(newColor)
      => ComCall(41, this.p, UInt32, newColor)
    get_BackColor(pColor)
      => ComCall(42, this.p, UInt32.Ptr, pColor)
    get_Cursors(Cursors)
      => ComCall(43, this.p, IInkCursors.Ptr, Cursors)
    get_MarginX(MarginX)
      => ComCall(44, this.p, Int32.Ptr, MarginX)
    put_MarginX(MarginX)
      => ComCall(45, this.p, Int32, MarginX)
    get_MarginY(MarginY)
      => ComCall(46, this.p, Int32.Ptr, MarginY)
    put_MarginY(MarginY)
      => ComCall(47, this.p, Int32, MarginY)
    get_Tablet(SingleTablet)
      => ComCall(48, this.p, IInkTablet.Ptr, SingleTablet)
    get_SupportHighContrastInk(Support)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, Support)
    put_SupportHighContrastInk(Support)
      => ComCall(50, this.p, VARIANT_BOOL, Support)
    get_SupportHighContrastSelectionUI(Support)
      => ComCall(51, this.p, VARIANT_BOOL.Ptr, Support)
    put_SupportHighContrastSelectionUI(Support)
      => ComCall(52, this.p, VARIANT_BOOL, Support)
    HitTestSelection(x, y, SelArea)
      => ComCall(53, this.p, Int32, x, Int32, y, SelectionHitResult.Ptr, SelArea)
    SetGestureStatus(Gesture, Listen)
      => ComCall(54, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL, Listen)
    GetGestureStatus(Gesture, Listening)
      => ComCall(55, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL.Ptr, Listening)
    GetWindowInputRectangle(WindowInputRectangle)
      => ComCall(56, this.p, IInkRectangle.Ptr, WindowInputRectangle)
    SetWindowInputRectangle(WindowInputRectangle?)
      => ComCall(57, this.p, IInkRectangle, WindowInputRectangle?)
    SetAllTabletsMode(UseMouseForInput)
      => ComCall(58, this.p, VARIANT_BOOL, UseMouseForInput)
    SetSingleTabletIntegratedMode(Tablet?)
      => ComCall(59, this.p, IInkTablet, Tablet?)
    GetEventInterest(EventId, Listen)
      => ComCall(60, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL.Ptr, Listen)
    SetEventInterest(EventId, Listen)
      => ComCall(61, this.p, InkCollectorEventInterest, EventId, VARIANT_BOOL, Listen)
    get_InkEnabled(Collecting)
      => ComCall(62, this.p, VARIANT_BOOL.Ptr, Collecting)
    put_InkEnabled(Collecting)
      => ComCall(63, this.p, VARIANT_BOOL, Collecting)
    get_Enabled(pbool)
      => ComCall(64, this.p, VARIANT_BOOL.Ptr, pbool)
    put_Enabled(vbool)
      => ComCall(65, this.p, VARIANT_BOOL, vbool)
}
struct IInkPictureEvents extends IDispatch {
    static IID := "{60FF4FEE-22FF-4484-ACC1-D308D9CD7EA3}"
}
struct IInkRecognizer extends IDispatch {
    static IID := "{782BF7CF-034B-4396-8A32-3A1833CF6B56}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Vendor(Vendor)
      => ComCall(8, this.p, BSTR.Ptr, Vendor)
    get_Capabilities(CapabilitiesFlags)
      => ComCall(9, this.p, InkRecognizerCapabilities.Ptr, CapabilitiesFlags)
    get_Languages(Languages)
      => ComCall(10, this.p, VARIANT.Ptr, Languages)
    get_SupportedProperties(SupportedProperties)
      => ComCall(11, this.p, VARIANT.Ptr, SupportedProperties)
    get_PreferredPacketDescription(PreferredPacketDescription)
      => ComCall(12, this.p, VARIANT.Ptr, PreferredPacketDescription)
    CreateRecognizerContext(Context)
      => ComCall(13, this.p, IInkRecognizerContext.Ptr, Context)
}
struct IInkRecognizer2 extends IDispatch {
    static IID := "{6110118A-3A75-4AD6-B2AA-04B2B72BBE65}"
    get_Id(pbstrId)
      => ComCall(7, this.p, BSTR.Ptr, pbstrId)
    get_UnicodeRanges(UnicodeRanges)
      => ComCall(8, this.p, VARIANT.Ptr, UnicodeRanges)
}
struct IInkRecognizers extends IDispatch {
    static IID := "{9CCC4F12-B0B7-4A8B-BF58-4AECA4E8CEFD}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    GetDefaultRecognizer(lcid, DefaultRecognizer)
      => ComCall(9, this.p, Int32, lcid, IInkRecognizer.Ptr, DefaultRecognizer)
    Item(Index, InkRecognizer)
      => ComCall(10, this.p, Int32, Index, IInkRecognizer.Ptr, InkRecognizer)
}
struct IInkRecognitionEvents extends IDispatch {
    static IID := "{17BCE92F-2E21-47FD-9D33-3C6AFBFD8C59}"
}
struct IInkRecognizerContext extends IDispatch {
    static IID := "{C68F52F9-32A3-4625-906C-44FC23B40958}"
    get_Strokes(Strokes)
      => ComCall(7, this.p, IInkStrokes.Ptr, Strokes)
    putref_Strokes(Strokes?)
      => ComCall(8, this.p, IInkStrokes, Strokes?)
    get_CharacterAutoCompletionMode(Mode)
      => ComCall(9, this.p, InkRecognizerCharacterAutoCompletionMode.Ptr, Mode)
    put_CharacterAutoCompletionMode(Mode)
      => ComCall(10, this.p, InkRecognizerCharacterAutoCompletionMode, Mode)
    get_Factoid(Factoid)
      => ComCall(11, this.p, BSTR.Ptr, Factoid)
    put_Factoid(factoid)
      => ComCall(12, this.p, BSTR, factoid)
    get_Guide(RecognizerGuide)
      => ComCall(13, this.p, IInkRecognizerGuide.Ptr, RecognizerGuide)
    putref_Guide(RecognizerGuide?)
      => ComCall(14, this.p, IInkRecognizerGuide, RecognizerGuide?)
    get_PrefixText(Prefix)
      => ComCall(15, this.p, BSTR.Ptr, Prefix)
    put_PrefixText(Prefix)
      => ComCall(16, this.p, BSTR, Prefix)
    get_SuffixText(Suffix)
      => ComCall(17, this.p, BSTR.Ptr, Suffix)
    put_SuffixText(Suffix)
      => ComCall(18, this.p, BSTR, Suffix)
    get_RecognitionFlags(Modes)
      => ComCall(19, this.p, InkRecognitionModes.Ptr, Modes)
    put_RecognitionFlags(Modes)
      => ComCall(20, this.p, InkRecognitionModes, Modes)
    get_WordList(WordList)
      => ComCall(21, this.p, IInkWordList.Ptr, WordList)
    putref_WordList(WordList?)
      => ComCall(22, this.p, IInkWordList, WordList?)
    get_Recognizer(Recognizer)
      => ComCall(23, this.p, IInkRecognizer.Ptr, Recognizer)
    Recognize(RecognitionStatus, RecognitionResult)
      => ComCall(24, this.p, InkRecognitionStatus.Ptr, RecognitionStatus, IInkRecognitionResult.Ptr, RecognitionResult)
    StopBackgroundRecognition()
      => ComCall(25, this.p)
    EndInkInput()
      => ComCall(26, this.p)
    BackgroundRecognize(CustomData)
      => ComCall(27, this.p, VARIANT, CustomData)
    BackgroundRecognizeWithAlternates(CustomData)
      => ComCall(28, this.p, VARIANT, CustomData)
    Clone(RecoContext)
      => ComCall(29, this.p, IInkRecognizerContext.Ptr, RecoContext)
    IsStringSupported(String, Supported)
      => ComCall(30, this.p, BSTR, String, VARIANT_BOOL.Ptr, Supported)
}
struct IInkRecognizerContext2 extends IDispatch {
    static IID := "{D6F0E32F-73D8-408E-8E9F-5FEA592C363F}"
    get_EnabledUnicodeRanges(UnicodeRanges)
      => ComCall(7, this.p, VARIANT.Ptr, UnicodeRanges)
    put_EnabledUnicodeRanges(UnicodeRanges)
      => ComCall(8, this.p, VARIANT, UnicodeRanges)
}
struct IInkRecognitionResult extends IDispatch {
    static IID := "{3BC129A8-86CD-45AD-BDE8-E0D32D61C16D}"
    get_TopString(TopString)
      => ComCall(7, this.p, BSTR.Ptr, TopString)
    get_TopAlternate(TopAlternate)
      => ComCall(8, this.p, IInkRecognitionAlternate.Ptr, TopAlternate)
    get_TopConfidence(TopConfidence)
      => ComCall(9, this.p, InkRecognitionConfidence.Ptr, TopConfidence)
    get_Strokes(Strokes)
      => ComCall(10, this.p, IInkStrokes.Ptr, Strokes)
    AlternatesFromSelection(selectionStart, selectionLength, maximumAlternates, AlternatesFromSelection)
      => ComCall(11, this.p, Int32, selectionStart, Int32, selectionLength, Int32, maximumAlternates, IInkRecognitionAlternates.Ptr, AlternatesFromSelection)
    ModifyTopAlternate(Alternate?)
      => ComCall(12, this.p, IInkRecognitionAlternate, Alternate?)
    SetResultOnStrokes()
      => ComCall(13, this.p)
}
struct IInkRecognitionAlternate extends IDispatch {
    static IID := "{B7E660AD-77E4-429B-ADDA-873780D1FC4A}"
    get_String(RecoString)
      => ComCall(7, this.p, BSTR.Ptr, RecoString)
    get_Confidence(Confidence)
      => ComCall(8, this.p, InkRecognitionConfidence.Ptr, Confidence)
    get_Baseline(Baseline)
      => ComCall(9, this.p, VARIANT.Ptr, Baseline)
    get_Midline(Midline)
      => ComCall(10, this.p, VARIANT.Ptr, Midline)
    get_Ascender(Ascender)
      => ComCall(11, this.p, VARIANT.Ptr, Ascender)
    get_Descender(Descender)
      => ComCall(12, this.p, VARIANT.Ptr, Descender)
    get_LineNumber(LineNumber)
      => ComCall(13, this.p, Int32.Ptr, LineNumber)
    get_Strokes(Strokes)
      => ComCall(14, this.p, IInkStrokes.Ptr, Strokes)
    get_LineAlternates(LineAlternates)
      => ComCall(15, this.p, IInkRecognitionAlternates.Ptr, LineAlternates)
    get_ConfidenceAlternates(ConfidenceAlternates)
      => ComCall(16, this.p, IInkRecognitionAlternates.Ptr, ConfidenceAlternates)
    GetStrokesFromStrokeRanges(Strokes?, GetStrokesFromStrokeRanges)
      => ComCall(17, this.p, IInkStrokes, Strokes?, IInkStrokes.Ptr, GetStrokesFromStrokeRanges)
    GetStrokesFromTextRange(selectionStart, selectionLength, GetStrokesFromTextRange)
      => ComCall(18, this.p, Int32.Ptr, selectionStart, Int32.Ptr, selectionLength, IInkStrokes.Ptr, GetStrokesFromTextRange)
    GetTextRangeFromStrokes(Strokes?, selectionStart, selectionLength)
      => ComCall(19, this.p, IInkStrokes, Strokes?, Int32.Ptr, selectionStart, Int32.Ptr, selectionLength)
    AlternatesWithConstantPropertyValues(PropertyType, AlternatesWithConstantPropertyValues)
      => ComCall(20, this.p, BSTR, PropertyType, IInkRecognitionAlternates.Ptr, AlternatesWithConstantPropertyValues)
    GetPropertyValue(PropertyType, PropertyValue)
      => ComCall(21, this.p, BSTR, PropertyType, VARIANT.Ptr, PropertyValue)
}
struct IInkRecognitionAlternates extends IDispatch {
    static IID := "{286A167F-9F19-4C61-9D53-4F07BE622B84}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    get_Strokes(Strokes)
      => ComCall(9, this.p, IInkStrokes.Ptr, Strokes)
    Item(Index, InkRecoAlternate)
      => ComCall(10, this.p, Int32, Index, IInkRecognitionAlternate.Ptr, InkRecoAlternate)
}
struct IInkRecognizerGuide extends IDispatch {
    static IID := "{D934BE07-7B84-4208-9136-83C20994E905}"
    get_WritingBox(Rectangle)
      => ComCall(7, this.p, IInkRectangle.Ptr, Rectangle)
    put_WritingBox(Rectangle?)
      => ComCall(8, this.p, IInkRectangle, Rectangle?)
    get_DrawnBox(Rectangle)
      => ComCall(9, this.p, IInkRectangle.Ptr, Rectangle)
    put_DrawnBox(Rectangle?)
      => ComCall(10, this.p, IInkRectangle, Rectangle?)
    get_Rows(Units)
      => ComCall(11, this.p, Int32.Ptr, Units)
    put_Rows(Units)
      => ComCall(12, this.p, Int32, Units)
    get_Columns(Units)
      => ComCall(13, this.p, Int32.Ptr, Units)
    put_Columns(Units)
      => ComCall(14, this.p, Int32, Units)
    get_Midline(Units)
      => ComCall(15, this.p, Int32.Ptr, Units)
    put_Midline(Units)
      => ComCall(16, this.p, Int32, Units)
    get_GuideData(pRecoGuide)
      => ComCall(17, this.p, InkRecoGuide.Ptr, pRecoGuide)
    put_GuideData(recoGuide)
      => ComCall(18, this.p, InkRecoGuide, recoGuide)
}
struct IInkWordList extends IDispatch {
    static IID := "{76BA3491-CB2F-406B-9961-0E0C4CDAAEF2}"
    AddWord(NewWord)
      => ComCall(7, this.p, BSTR, NewWord)
    RemoveWord(RemoveWord)
      => ComCall(8, this.p, BSTR, RemoveWord)
    Merge(MergeWordList?)
      => ComCall(9, this.p, IInkWordList, MergeWordList?)
}
struct IInkWordList2 extends IDispatch {
    static IID := "{14542586-11BF-4F5F-B6E7-49D0744AAB6E}"
    AddWords(NewWords)
      => ComCall(7, this.p, BSTR, NewWords)
}
struct IInk extends IDispatch {
    static IID := "{03F8E511-43A1-11D3-8BB6-0080C7D6BAD5}"
}
struct IInkLineInfo extends IUnknown {
    static IID := "{9C1C5AD6-F22F-4DE4-B453-A2CC482E7C33}"
    SetFormat(pim)
      => ComCall(3, this.p, INKMETRIC.Ptr, pim)
    GetFormat(pim)
      => ComCall(4, this.p, INKMETRIC.Ptr, pim)
    GetInkExtent(pim, pnWidth)
      => ComCall(5, this.p, INKMETRIC.Ptr, pim, UInt32.Ptr, pnWidth)
    GetCandidate(nCandidateNum, pwcRecogWord, pcwcRecogWord, dwFlags)
      => ComCall(6, this.p, UInt32, nCandidateNum, "Str", pwcRecogWord, UInt32.Ptr, pcwcRecogWord, UInt32, dwFlags)
    SetCandidate(nCandidateNum, strRecogWord)
      => ComCall(7, this.p, UInt32, nCandidateNum, "Str", strRecogWord)
    Recognize()
      => ComCall(8, this.p)
}
struct ISketchInk extends IDispatch {
    static IID := "{B4563688-98EB-4646-B279-44DA14D45748}"
}
struct InkDivisionType extends Int32 {
    static IDT_Segment := 0
    static IDT_Line := 1
    static IDT_Paragraph := 2
    static IDT_Drawing := 3
}
struct DISPID_InkDivider extends Int32 {
    static DISPID_IInkDivider_Strokes := 1
    static DISPID_IInkDivider_RecognizerContext := 2
    static DISPID_IInkDivider_LineHeight := 3
    static DISPID_IInkDivider_Divide := 4
}
struct DISPID_InkDivisionResult extends Int32 {
    static DISPID_IInkDivisionResult_Strokes := 1
    static DISPID_IInkDivisionResult_ResultByType := 2
}
struct DISPID_InkDivisionUnit extends Int32 {
    static DISPID_IInkDivisionUnit_Strokes := 1
    static DISPID_IInkDivisionUnit_DivisionType := 2
    static DISPID_IInkDivisionUnit_RecognizedString := 3
    static DISPID_IInkDivisionUnit_RotationTransform := 4
}
struct DISPID_InkDivisionUnits extends Int32 {
    static DISPID_IInkDivisionUnits_NewEnum := -4
    static DISPID_IInkDivisionUnits_Item := 0
    static DISPID_IInkDivisionUnits_Count := 1
}
struct IInkDivider extends IDispatch {
    static IID := "{5DE00405-F9A4-4651-B0C5-C317DEFD58B9}"
    get_Strokes(Strokes)
      => ComCall(7, this.p, IInkStrokes.Ptr, Strokes)
    putref_Strokes(Strokes?)
      => ComCall(8, this.p, IInkStrokes, Strokes?)
    get_RecognizerContext(RecognizerContext)
      => ComCall(9, this.p, IInkRecognizerContext.Ptr, RecognizerContext)
    putref_RecognizerContext(RecognizerContext?)
      => ComCall(10, this.p, IInkRecognizerContext, RecognizerContext?)
    get_LineHeight(LineHeight)
      => ComCall(11, this.p, Int32.Ptr, LineHeight)
    put_LineHeight(LineHeight)
      => ComCall(12, this.p, Int32, LineHeight)
    Divide(InkDivisionResult)
      => ComCall(13, this.p, IInkDivisionResult.Ptr, InkDivisionResult)
}
struct IInkDivisionResult extends IDispatch {
    static IID := "{2DBEC0A7-74C7-4B38-81EB-AA8EF0C24900}"
    get_Strokes(Strokes)
      => ComCall(7, this.p, IInkStrokes.Ptr, Strokes)
    ResultByType(divisionType, InkDivisionUnits)
      => ComCall(8, this.p, InkDivisionType, divisionType, IInkDivisionUnits.Ptr, InkDivisionUnits)
}
struct IInkDivisionUnit extends IDispatch {
    static IID := "{85AEE342-48B0-4244-9DD5-1ED435410FAB}"
    get_Strokes(Strokes)
      => ComCall(7, this.p, IInkStrokes.Ptr, Strokes)
    get_DivisionType(divisionType)
      => ComCall(8, this.p, InkDivisionType.Ptr, divisionType)
    get_RecognizedString(RecoString)
      => ComCall(9, this.p, BSTR.Ptr, RecoString)
    get_RotationTransform(RotationTransform)
      => ComCall(10, this.p, IInkTransform.Ptr, RotationTransform)
}
struct IInkDivisionUnits extends IDispatch {
    static IID := "{1BB5DDC2-31CC-4135-AB82-2C66C9F00C41}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(_NewEnum)
      => ComCall(8, this.p, IUnknown.Ptr, _NewEnum)
    Item(Index, InkDivisionUnit)
      => ComCall(9, this.p, Int32, Index, IInkDivisionUnit.Ptr, InkDivisionUnit)
}
struct DISPID_PenInputPanel extends Int32 {
    static DISPID_PIPAttachedEditWindow := 0
    static DISPID_PIPFactoid := 1
    static DISPID_PIPCurrentPanel := 2
    static DISPID_PIPDefaultPanel := 3
    static DISPID_PIPVisible := 4
    static DISPID_PIPTop := 5
    static DISPID_PIPLeft := 6
    static DISPID_PIPWidth := 7
    static DISPID_PIPHeight := 8
    static DISPID_PIPMoveTo := 9
    static DISPID_PIPCommitPendingInput := 10
    static DISPID_PIPRefresh := 11
    static DISPID_PIPBusy := 12
    static DISPID_PIPVerticalOffset := 13
    static DISPID_PIPHorizontalOffset := 14
    static DISPID_PIPEnableTsf := 15
    static DISPID_PIPAutoShow := 16
}
struct DISPID_PenInputPanelEvents extends Int32 {
    static DISPID_PIPEVisibleChanged := 0
    static DISPID_PIPEPanelChanged := 1
    static DISPID_PIPEInputFailed := 2
    static DISPID_PIPEPanelMoving := 3
}
struct VisualState extends Int32 {
    static InPlace := 0
    static Floating := 1
    static DockedTop := 2
    static DockedBottom := 3
    static Closed := 4
}
struct InteractionMode extends Int32 {
    static InteractionMode_InPlace := 0
    static InteractionMode_Floating := 1
    static InteractionMode_DockedTop := 2
    static InteractionMode_DockedBottom := 3
}
struct InPlaceState extends Int32 {
    static InPlaceState_Auto := 0
    static InPlaceState_HoverTarget := 1
    static InPlaceState_Expanded := 2
}
struct PanelInputArea extends Int32 {
    static PanelInputArea_Auto := 0
    static PanelInputArea_Keyboard := 1
    static PanelInputArea_WritingPad := 2
    static PanelInputArea_CharacterPad := 3
}
struct CorrectionMode extends Int32 {
    static CorrectionMode_NotVisible := 0
    static CorrectionMode_PreInsertion := 1
    static CorrectionMode_PostInsertionCollapsed := 2
    static CorrectionMode_PostInsertionExpanded := 3
}
struct CorrectionPosition extends Int32 {
    static CorrectionPosition_Auto := 0
    static CorrectionPosition_Bottom := 1
    static CorrectionPosition_Top := 2
}
struct InPlaceDirection extends Int32 {
    static InPlaceDirection_Auto := 0
    static InPlaceDirection_Bottom := 1
    static InPlaceDirection_Top := 2
}
struct EventMask extends Int32 {
    static EventMask_InPlaceStateChanging := 1
    static EventMask_InPlaceStateChanged := 2
    static EventMask_InPlaceSizeChanging := 4
    static EventMask_InPlaceSizeChanged := 8
    static EventMask_InputAreaChanging := 16
    static EventMask_InputAreaChanged := 32
    static EventMask_CorrectionModeChanging := 64
    static EventMask_CorrectionModeChanged := 128
    static EventMask_InPlaceVisibilityChanging := 256
    static EventMask_InPlaceVisibilityChanged := 512
    static EventMask_TextInserting := 1024
    static EventMask_TextInserted := 2048
    static EventMask_All := 4095
}
struct PanelType extends Int32 {
    static PT_Default := 0
    static PT_Inactive := 1
    static PT_Handwriting := 2
    static PT_Keyboard := 3
}
struct IPenInputPanel extends IDispatch {
    static IID := "{FA7A4083-5747-4040-A182-0B0E9FD4FAC7}"
    get_Busy(Busy)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, Busy)
    get_Factoid(Factoid)
      => ComCall(8, this.p, BSTR.Ptr, Factoid)
    put_Factoid(Factoid)
      => ComCall(9, this.p, BSTR, Factoid)
    get_AttachedEditWindow(AttachedEditWindow)
      => ComCall(10, this.p, Int32.Ptr, AttachedEditWindow)
    put_AttachedEditWindow(AttachedEditWindow)
      => ComCall(11, this.p, Int32, AttachedEditWindow)
    get_CurrentPanel(CurrentPanel)
      => ComCall(12, this.p, PanelType.Ptr, CurrentPanel)
    put_CurrentPanel(CurrentPanel)
      => ComCall(13, this.p, PanelType, CurrentPanel)
    get_DefaultPanel(pDefaultPanel)
      => ComCall(14, this.p, PanelType.Ptr, pDefaultPanel)
    put_DefaultPanel(DefaultPanel)
      => ComCall(15, this.p, PanelType, DefaultPanel)
    get_Visible(Visible)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, Visible)
    put_Visible(Visible)
      => ComCall(17, this.p, VARIANT_BOOL, Visible)
    get_Top(Top)
      => ComCall(18, this.p, Int32.Ptr, Top)
    get_Left(Left)
      => ComCall(19, this.p, Int32.Ptr, Left)
    get_Width(Width)
      => ComCall(20, this.p, Int32.Ptr, Width)
    get_Height(Height)
      => ComCall(21, this.p, Int32.Ptr, Height)
    get_VerticalOffset(VerticalOffset)
      => ComCall(22, this.p, Int32.Ptr, VerticalOffset)
    put_VerticalOffset(VerticalOffset)
      => ComCall(23, this.p, Int32, VerticalOffset)
    get_HorizontalOffset(HorizontalOffset)
      => ComCall(24, this.p, Int32.Ptr, HorizontalOffset)
    put_HorizontalOffset(HorizontalOffset)
      => ComCall(25, this.p, Int32, HorizontalOffset)
    get_AutoShow(pAutoShow)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pAutoShow)
    put_AutoShow(AutoShow)
      => ComCall(27, this.p, VARIANT_BOOL, AutoShow)
    MoveTo(Left, Top)
      => ComCall(28, this.p, Int32, Left, Int32, Top)
    CommitPendingInput()
      => ComCall(29, this.p)
    Refresh()
      => ComCall(30, this.p)
    EnableTsf(Enable)
      => ComCall(31, this.p, VARIANT_BOOL, Enable)
}
struct IPenInputPanelEvents extends IDispatch {
    static IID := "{B7E489DA-3719-439F-848F-E7ACBD820F17}"
}
struct IHandwrittenTextInsertion extends IUnknown {
    static IID := "{56FDEA97-ECD6-43E7-AA3A-816BE7785860}"
    InsertRecognitionResultsArray(psaAlternates, locale, fAlternateContainsAutoSpacingInformation)
      => ComCall(3, this.p, SAFEARRAY.Ptr, psaAlternates, UInt32, locale, BOOL, fAlternateContainsAutoSpacingInformation)
    InsertInkRecognitionResult(pIInkRecoResult?, locale, fAlternateContainsAutoSpacingInformation)
      => ComCall(4, this.p, IInkRecognitionResult, pIInkRecoResult?, UInt32, locale, BOOL, fAlternateContainsAutoSpacingInformation)
}
struct ITextInputPanelEventSink extends IUnknown {
    static IID := "{27560408-8E64-4FE1-804E-421201584B31}"
    InPlaceStateChanging(oldInPlaceState, newInPlaceState)
      => ComCall(3, this.p, InPlaceState, oldInPlaceState, InPlaceState, newInPlaceState)
    InPlaceStateChanged(oldInPlaceState, newInPlaceState)
      => ComCall(4, this.p, InPlaceState, oldInPlaceState, InPlaceState, newInPlaceState)
    InPlaceSizeChanging(oldBoundingRectangle, newBoundingRectangle)
      => ComCall(5, this.p, RECT, oldBoundingRectangle, RECT, newBoundingRectangle)
    InPlaceSizeChanged(oldBoundingRectangle, newBoundingRectangle)
      => ComCall(6, this.p, RECT, oldBoundingRectangle, RECT, newBoundingRectangle)
    InputAreaChanging(oldInputArea, newInputArea)
      => ComCall(7, this.p, PanelInputArea, oldInputArea, PanelInputArea, newInputArea)
    InputAreaChanged(oldInputArea, newInputArea)
      => ComCall(8, this.p, PanelInputArea, oldInputArea, PanelInputArea, newInputArea)
    CorrectionModeChanging(oldCorrectionMode, newCorrectionMode)
      => ComCall(9, this.p, CorrectionMode, oldCorrectionMode, CorrectionMode, newCorrectionMode)
    CorrectionModeChanged(oldCorrectionMode, newCorrectionMode)
      => ComCall(10, this.p, CorrectionMode, oldCorrectionMode, CorrectionMode, newCorrectionMode)
    InPlaceVisibilityChanging(oldVisible, newVisible)
      => ComCall(11, this.p, BOOL, oldVisible, BOOL, newVisible)
    InPlaceVisibilityChanged(oldVisible, newVisible)
      => ComCall(12, this.p, BOOL, oldVisible, BOOL, newVisible)
    TextInserting(Ink)
      => ComCall(13, this.p, SAFEARRAY.Ptr, Ink)
    TextInserted(Ink)
      => ComCall(14, this.p, SAFEARRAY.Ptr, Ink)
}
struct ITextInputPanel extends IUnknown {
    static IID := "{6B6A65A5-6AF3-46C2-B6EA-56CD1F80DF71}"
    get_AttachedEditWindow(AttachedEditWindow)
      => ComCall(3, this.p, HWND.Ptr, AttachedEditWindow)
    put_AttachedEditWindow(AttachedEditWindow)
      => ComCall(4, this.p, HWND, AttachedEditWindow)
    get_CurrentInteractionMode(CurrentInteractionMode)
      => ComCall(5, this.p, InteractionMode.Ptr, CurrentInteractionMode)
    get_DefaultInPlaceState(State)
      => ComCall(6, this.p, InPlaceState.Ptr, State)
    put_DefaultInPlaceState(State)
      => ComCall(7, this.p, InPlaceState, State)
    get_CurrentInPlaceState(State)
      => ComCall(8, this.p, InPlaceState.Ptr, State)
    get_DefaultInputArea(Area)
      => ComCall(9, this.p, PanelInputArea.Ptr, Area)
    put_DefaultInputArea(Area)
      => ComCall(10, this.p, PanelInputArea, Area)
    get_CurrentInputArea(Area)
      => ComCall(11, this.p, PanelInputArea.Ptr, Area)
    get_CurrentCorrectionMode(Mode)
      => ComCall(12, this.p, CorrectionMode.Ptr, Mode)
    get_PreferredInPlaceDirection(Direction)
      => ComCall(13, this.p, InPlaceDirection.Ptr, Direction)
    put_PreferredInPlaceDirection(Direction)
      => ComCall(14, this.p, InPlaceDirection, Direction)
    get_ExpandPostInsertionCorrection(Expand)
      => ComCall(15, this.p, BOOL.Ptr, Expand)
    put_ExpandPostInsertionCorrection(Expand)
      => ComCall(16, this.p, BOOL, Expand)
    get_InPlaceVisibleOnFocus(Visible)
      => ComCall(17, this.p, BOOL.Ptr, Visible)
    put_InPlaceVisibleOnFocus(Visible)
      => ComCall(18, this.p, BOOL, Visible)
    get_InPlaceBoundingRectangle(BoundingRectangle)
      => ComCall(19, this.p, RECT.Ptr, BoundingRectangle)
    get_PopUpCorrectionHeight(Height)
      => ComCall(20, this.p, Int32.Ptr, Height)
    get_PopDownCorrectionHeight(Height)
      => ComCall(21, this.p, Int32.Ptr, Height)
    CommitPendingInput()
      => ComCall(22, this.p)
    SetInPlaceVisibility(Visible)
      => ComCall(23, this.p, BOOL, Visible)
    SetInPlacePosition(xPosition, yPosition, position)
      => ComCall(24, this.p, Int32, xPosition, Int32, yPosition, CorrectionPosition, position)
    SetInPlaceHoverTargetPosition(xPosition, yPosition)
      => ComCall(25, this.p, Int32, xPosition, Int32, yPosition)
    Advise(EventSink?, EventMask)
      => ComCall(26, this.p, ITextInputPanelEventSink, EventSink?, UInt32, EventMask)
    Unadvise(EventSink?)
      => ComCall(27, this.p, ITextInputPanelEventSink, EventSink?)
}
struct IInputPanelWindowHandle extends IUnknown {
    static IID := "{4AF81847-FDC4-4FC3-AD0B-422479C1B935}"
    get_AttachedEditWindow32(AttachedEditWindow)
      => ComCall(3, this.p, Int32.Ptr, AttachedEditWindow)
    put_AttachedEditWindow32(AttachedEditWindow)
      => ComCall(4, this.p, Int32, AttachedEditWindow)
    get_AttachedEditWindow64(AttachedEditWindow)
      => ComCall(5, this.p, Int64.Ptr, AttachedEditWindow)
    put_AttachedEditWindow64(AttachedEditWindow)
      => ComCall(6, this.p, Int64, AttachedEditWindow)
}
struct ITextInputPanelRunInfo extends IUnknown {
    static IID := "{9F424568-1920-48CC-9811-A993CBF5ADBA}"
    IsTipRunning(pfRunning)
      => ComCall(3, this.p, BOOL.Ptr, pfRunning)
}
struct FLICKDIRECTION extends Int32 {
    static FLICKDIRECTION_MIN := 0
    static FLICKDIRECTION_RIGHT := 0
    static FLICKDIRECTION_UPRIGHT := 1
    static FLICKDIRECTION_UP := 2
    static FLICKDIRECTION_UPLEFT := 3
    static FLICKDIRECTION_LEFT := 4
    static FLICKDIRECTION_DOWNLEFT := 5
    static FLICKDIRECTION_DOWN := 6
    static FLICKDIRECTION_DOWNRIGHT := 7
    static FLICKDIRECTION_INVALID := 8
}
struct FLICKMODE extends Int32 {
    static FLICKMODE_MIN := 0
    static FLICKMODE_OFF := 0
    static FLICKMODE_ON := 1
    static FLICKMODE_LEARNING := 2
    static FLICKMODE_MAX := 2
    static FLICKMODE_DEFAULT := 1
}
struct FLICKACTION_COMMANDCODE extends Int32 {
    static FLICKACTION_COMMANDCODE_NULL := 0
    static FLICKACTION_COMMANDCODE_SCROLL := 1
    static FLICKACTION_COMMANDCODE_APPCOMMAND := 2
    static FLICKACTION_COMMANDCODE_CUSTOMKEY := 3
    static FLICKACTION_COMMANDCODE_KEYMODIFIER := 4
}
struct FLICK_POINT {
    _bitfield : Int32
}
struct FLICK_DATA {
    _bitfield : Int32
}
struct SCROLLDIRECTION extends Int32 {
    static SCROLLDIRECTION_UP := 0
    static SCROLLDIRECTION_DOWN := 1
}
struct KEYMODIFIER extends Int32 {
    static KEYMODIFIER_CONTROL := 1
    static KEYMODIFIER_MENU := 2
    static KEYMODIFIER_SHIFT := 4
    static KEYMODIFIER_WIN := 8
    static KEYMODIFIER_ALTGR := 16
    static KEYMODIFIER_EXT := 32
}
struct IEC_STROKEINFO {
    nmhdr : NMHDR
    Cursor : IInkCursor
    Stroke : IInkStrokeDisp
}
struct IEC_GESTUREINFO {
    nmhdr : NMHDR
    Cursor : IInkCursor
    Strokes : IInkStrokes
    Gestures : VARIANT
}
struct IEC_RECOGNITIONRESULTINFO {
    nmhdr : NMHDR
    RecognitionResult : IInkRecognitionResult
}
struct MouseButton extends Int32 {
    static NO_BUTTON := 0
    static LEFT_BUTTON := 1
    static RIGHT_BUTTON := 2
    static MIDDLE_BUTTON := 4
}
struct SelAlignmentConstants extends Int32 {
    static rtfLeft := 0
    static rtfRight := 1
    static rtfCenter := 2
}
struct DISPID_InkEdit extends Int32 {
    static DISPID_Text := 0
    static DISPID_TextRTF := 1
    static DISPID_Hwnd := 2
    static DISPID_DisableNoScroll := 3
    static DISPID_Locked := 4
    static DISPID_Enabled := 5
    static DISPID_MaxLength := 6
    static DISPID_MultiLine := 7
    static DISPID_ScrollBars := 8
    static DISPID_RTSelStart := 9
    static DISPID_RTSelLength := 10
    static DISPID_RTSelText := 11
    static DISPID_SelAlignment := 12
    static DISPID_SelBold := 13
    static DISPID_SelCharOffset := 14
    static DISPID_SelColor := 15
    static DISPID_SelFontName := 16
    static DISPID_SelFontSize := 17
    static DISPID_SelItalic := 18
    static DISPID_SelRTF := 19
    static DISPID_SelUnderline := 20
    static DISPID_DragIcon := 21
    static DISPID_Status := 22
    static DISPID_UseMouseForInput := 23
    static DISPID_InkMode := 24
    static DISPID_InkInsertMode := 25
    static DISPID_RecoTimeout := 26
    static DISPID_DrawAttr := 27
    static DISPID_Recognizer := 28
    static DISPID_Factoid := 29
    static DISPID_SelInk := 30
    static DISPID_SelInksDisplayMode := 31
    static DISPID_Recognize := 32
    static DISPID_GetGestStatus := 33
    static DISPID_SetGestStatus := 34
    static DISPID_Refresh := 35
}
struct DISPID_InkEditEvents extends Int32 {
    static DISPID_IeeChange := 1
    static DISPID_IeeSelChange := 2
    static DISPID_IeeKeyDown := 3
    static DISPID_IeeKeyUp := 4
    static DISPID_IeeMouseUp := 5
    static DISPID_IeeMouseDown := 6
    static DISPID_IeeKeyPress := 7
    static DISPID_IeeDblClick := 8
    static DISPID_IeeClick := 9
    static DISPID_IeeMouseMove := 10
    static DISPID_IeeCursorDown := 21
    static DISPID_IeeStroke := 22
    static DISPID_IeeGesture := 23
    static DISPID_IeeRecognitionResult := 24
}
struct InkMode extends Int32 {
    static IEM_Disabled := 0
    static IEM_Ink := 1
    static IEM_InkAndGesture := 2
}
struct InkInsertMode extends Int32 {
    static IEM_InsertText := 0
    static IEM_InsertInk := 1
}
struct InkEditStatus extends Int32 {
    static IES_Idle := 0
    static IES_Collecting := 1
    static IES_Recognizing := 2
}
struct InkDisplayMode extends Int32 {
    static IDM_Ink := 0
    static IDM_Text := 1
}
struct AppearanceConstants extends Int32 {
    static rtfFlat := 0
    static rtfThreeD := 1
}
struct BorderStyleConstants extends Int32 {
    static rtfNoBorder := 0
    static rtfFixedSingle := 1
}
struct ScrollBarsConstants extends Int32 {
    static rtfNone := 0
    static rtfHorizontal := 1
    static rtfVertical := 2
    static rtfBoth := 3
}
struct IInkEdit extends IDispatch {
    static IID := "{F2127A19-FBFB-4AED-8464-3F36D78CFEFB}"
    get_Status(pStatus)
      => ComCall(7, this.p, InkEditStatus.Ptr, pStatus)
    get_UseMouseForInput(pVal)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pVal)
    put_UseMouseForInput(newVal)
      => ComCall(9, this.p, VARIANT_BOOL, newVal)
    get_InkMode(pVal)
      => ComCall(10, this.p, InkMode.Ptr, pVal)
    put_InkMode(newVal)
      => ComCall(11, this.p, InkMode, newVal)
    get_InkInsertMode(pVal)
      => ComCall(12, this.p, InkInsertMode.Ptr, pVal)
    put_InkInsertMode(newVal)
      => ComCall(13, this.p, InkInsertMode, newVal)
    get_DrawingAttributes(pVal)
      => ComCall(14, this.p, IInkDrawingAttributes.Ptr, pVal)
    putref_DrawingAttributes(newVal?)
      => ComCall(15, this.p, IInkDrawingAttributes, newVal?)
    get_RecognitionTimeout(pVal)
      => ComCall(16, this.p, Int32.Ptr, pVal)
    put_RecognitionTimeout(newVal)
      => ComCall(17, this.p, Int32, newVal)
    get_Recognizer(pVal)
      => ComCall(18, this.p, IInkRecognizer.Ptr, pVal)
    putref_Recognizer(newVal?)
      => ComCall(19, this.p, IInkRecognizer, newVal?)
    get_Factoid(pVal)
      => ComCall(20, this.p, BSTR.Ptr, pVal)
    put_Factoid(newVal)
      => ComCall(21, this.p, BSTR, newVal)
    get_SelInks(pSelInk)
      => ComCall(22, this.p, VARIANT.Ptr, pSelInk)
    put_SelInks(SelInk)
      => ComCall(23, this.p, VARIANT, SelInk)
    get_SelInksDisplayMode(pInkDisplayMode)
      => ComCall(24, this.p, InkDisplayMode.Ptr, pInkDisplayMode)
    put_SelInksDisplayMode(InkDisplayMode1)
      => ComCall(25, this.p, InkDisplayMode, InkDisplayMode1)
    Recognize()
      => ComCall(26, this.p)
    GetGestureStatus(Gesture, pListen)
      => ComCall(27, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL.Ptr, pListen)
    SetGestureStatus(Gesture, Listen)
      => ComCall(28, this.p, InkApplicationGesture, Gesture, VARIANT_BOOL, Listen)
    put_BackColor(clr)
      => ComCall(29, this.p, UInt32, clr)
    get_BackColor(pclr)
      => ComCall(30, this.p, UInt32.Ptr, pclr)
    get_Appearance(pAppearance)
      => ComCall(31, this.p, AppearanceConstants.Ptr, pAppearance)
    put_Appearance(pAppearance)
      => ComCall(32, this.p, AppearanceConstants, pAppearance)
    get_BorderStyle(pBorderStyle)
      => ComCall(33, this.p, BorderStyleConstants.Ptr, pBorderStyle)
    put_BorderStyle(pBorderStyle)
      => ComCall(34, this.p, BorderStyleConstants, pBorderStyle)
    get_Hwnd(pohHwnd)
      => ComCall(35, this.p, OLE_HANDLE.Ptr, pohHwnd)
    get_Font(ppFont)
      => ComCall(36, this.p, IFontDisp.Ptr, ppFont)
    putref_Font(ppFont?)
      => ComCall(37, this.p, IFontDisp, ppFont?)
    get_Text(pbstrText)
      => ComCall(38, this.p, BSTR.Ptr, pbstrText)
    put_Text(pbstrText)
      => ComCall(39, this.p, BSTR, pbstrText)
    get_MouseIcon(MouseIcon)
      => ComCall(40, this.p, IPictureDisp.Ptr, MouseIcon)
    put_MouseIcon(MouseIcon?)
      => ComCall(41, this.p, IPictureDisp, MouseIcon?)
    putref_MouseIcon(MouseIcon?)
      => ComCall(42, this.p, IPictureDisp, MouseIcon?)
    get_MousePointer(MousePointer)
      => ComCall(43, this.p, InkMousePointer.Ptr, MousePointer)
    put_MousePointer(MousePointer)
      => ComCall(44, this.p, InkMousePointer, MousePointer)
    get_Locked(pVal)
      => ComCall(45, this.p, VARIANT_BOOL.Ptr, pVal)
    put_Locked(newVal)
      => ComCall(46, this.p, VARIANT_BOOL, newVal)
    get_Enabled(pVal)
      => ComCall(47, this.p, VARIANT_BOOL.Ptr, pVal)
    put_Enabled(newVal)
      => ComCall(48, this.p, VARIANT_BOOL, newVal)
    get_MaxLength(plMaxLength)
      => ComCall(49, this.p, Int32.Ptr, plMaxLength)
    put_MaxLength(lMaxLength)
      => ComCall(50, this.p, Int32, lMaxLength)
    get_MultiLine(pVal)
      => ComCall(51, this.p, VARIANT_BOOL.Ptr, pVal)
    put_MultiLine(newVal)
      => ComCall(52, this.p, VARIANT_BOOL, newVal)
    get_ScrollBars(pVal)
      => ComCall(53, this.p, ScrollBarsConstants.Ptr, pVal)
    put_ScrollBars(newVal)
      => ComCall(54, this.p, ScrollBarsConstants, newVal)
    get_DisableNoScroll(pVal)
      => ComCall(55, this.p, VARIANT_BOOL.Ptr, pVal)
    put_DisableNoScroll(newVal)
      => ComCall(56, this.p, VARIANT_BOOL, newVal)
    get_SelAlignment(pvarSelAlignment)
      => ComCall(57, this.p, VARIANT.Ptr, pvarSelAlignment)
    put_SelAlignment(pvarSelAlignment)
      => ComCall(58, this.p, VARIANT, pvarSelAlignment)
    get_SelBold(pvarSelBold)
      => ComCall(59, this.p, VARIANT.Ptr, pvarSelBold)
    put_SelBold(pvarSelBold)
      => ComCall(60, this.p, VARIANT, pvarSelBold)
    get_SelItalic(pvarSelItalic)
      => ComCall(61, this.p, VARIANT.Ptr, pvarSelItalic)
    put_SelItalic(pvarSelItalic)
      => ComCall(62, this.p, VARIANT, pvarSelItalic)
    get_SelUnderline(pvarSelUnderline)
      => ComCall(63, this.p, VARIANT.Ptr, pvarSelUnderline)
    put_SelUnderline(pvarSelUnderline)
      => ComCall(64, this.p, VARIANT, pvarSelUnderline)
    get_SelColor(pvarSelColor)
      => ComCall(65, this.p, VARIANT.Ptr, pvarSelColor)
    put_SelColor(pvarSelColor)
      => ComCall(66, this.p, VARIANT, pvarSelColor)
    get_SelFontName(pvarSelFontName)
      => ComCall(67, this.p, VARIANT.Ptr, pvarSelFontName)
    put_SelFontName(pvarSelFontName)
      => ComCall(68, this.p, VARIANT, pvarSelFontName)
    get_SelFontSize(pvarSelFontSize)
      => ComCall(69, this.p, VARIANT.Ptr, pvarSelFontSize)
    put_SelFontSize(pvarSelFontSize)
      => ComCall(70, this.p, VARIANT, pvarSelFontSize)
    get_SelCharOffset(pvarSelCharOffset)
      => ComCall(71, this.p, VARIANT.Ptr, pvarSelCharOffset)
    put_SelCharOffset(pvarSelCharOffset)
      => ComCall(72, this.p, VARIANT, pvarSelCharOffset)
    get_TextRTF(pbstrTextRTF)
      => ComCall(73, this.p, BSTR.Ptr, pbstrTextRTF)
    put_TextRTF(pbstrTextRTF)
      => ComCall(74, this.p, BSTR, pbstrTextRTF)
    get_SelStart(plSelStart)
      => ComCall(75, this.p, Int32.Ptr, plSelStart)
    put_SelStart(plSelStart)
      => ComCall(76, this.p, Int32, plSelStart)
    get_SelLength(plSelLength)
      => ComCall(77, this.p, Int32.Ptr, plSelLength)
    put_SelLength(plSelLength)
      => ComCall(78, this.p, Int32, plSelLength)
    get_SelText(pbstrSelText)
      => ComCall(79, this.p, BSTR.Ptr, pbstrSelText)
    put_SelText(pbstrSelText)
      => ComCall(80, this.p, BSTR, pbstrSelText)
    get_SelRTF(pbstrSelRTF)
      => ComCall(81, this.p, BSTR.Ptr, pbstrSelRTF)
    put_SelRTF(pbstrSelRTF)
      => ComCall(82, this.p, BSTR, pbstrSelRTF)
    Refresh()
      => ComCall(83, this.p)
}
struct IInkEditEvents extends IDispatch {
    static IID := "{E3B0B797-A72E-46DB-A0D7-6C9EBA8E9BBC}"
}
struct MICUIELEMENT extends Int32 {
    static MICUIELEMENT_BUTTON_WRITE := 1
    static MICUIELEMENT_BUTTON_ERASE := 2
    static MICUIELEMENT_BUTTON_CORRECT := 4
    static MICUIELEMENT_BUTTON_CLEAR := 8
    static MICUIELEMENT_BUTTON_UNDO := 16
    static MICUIELEMENT_BUTTON_REDO := 32
    static MICUIELEMENT_BUTTON_INSERT := 64
    static MICUIELEMENT_BUTTON_CANCEL := 128
    static MICUIELEMENT_INKPANEL_BACKGROUND := 256
    static MICUIELEMENT_RESULTPANEL_BACKGROUND := 512
}
struct MICUIELEMENTSTATE extends Int32 {
    static MICUIELEMENTSTATE_NORMAL := 1
    static MICUIELEMENTSTATE_HOT := 2
    static MICUIELEMENTSTATE_PRESSED := 3
    static MICUIELEMENTSTATE_DISABLED := 4
}
struct DISPID_MathInputControlEvents extends Int32 {
    static DISPID_MICInsert := 0
    static DISPID_MICClose := 1
    static DISPID_MICPaint := 2
    static DISPID_MICClear := 3
}
struct IMathInputControl extends IDispatch {
    static IID := "{EBA615AA-FAC6-4738-BA5F-FF09E9FE473E}"
    Show()
      => ComCall(7, this.p)
    Hide()
      => ComCall(8, this.p)
    IsVisible(pvbShown)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pvbShown)
    GetPosition(Left, Top, Right, Bottom)
      => ComCall(10, this.p, Int32.Ptr, Left, Int32.Ptr, Top, Int32.Ptr, Right, Int32.Ptr, Bottom)
    SetPosition(Left, Top, Right, Bottom)
      => ComCall(11, this.p, Int32, Left, Int32, Top, Int32, Right, Int32, Bottom)
    Clear()
      => ComCall(12, this.p)
    SetCustomPaint(Element, Paint)
      => ComCall(13, this.p, Int32, Element, VARIANT_BOOL, Paint)
    SetCaptionText(CaptionText)
      => ComCall(14, this.p, BSTR, CaptionText)
    LoadInk(Ink?)
      => ComCall(15, this.p, IInkDisp, Ink?)
    SetOwnerWindow(OwnerWindow)
      => ComCall(16, this.p, IntPtr, OwnerWindow)
    EnableExtendedButtons(Extended)
      => ComCall(17, this.p, VARIANT_BOOL, Extended)
    GetPreviewHeight(Height)
      => ComCall(18, this.p, Int32.Ptr, Height)
    SetPreviewHeight(Height)
      => ComCall(19, this.p, Int32, Height)
    EnableAutoGrow(AutoGrow)
      => ComCall(20, this.p, VARIANT_BOOL, AutoGrow)
    AddFunctionName(FunctionName)
      => ComCall(21, this.p, BSTR, FunctionName)
    RemoveFunctionName(FunctionName)
      => ComCall(22, this.p, BSTR, FunctionName)
    GetHoverIcon(HoverImage)
      => ComCall(23, this.p, IPictureDisp.Ptr, HoverImage)
}
struct IMathInputControlEvents extends IDispatch {
    static IID := "{683336B5-A47D-4358-96F9-875A472AE70A}"
}
struct RealTimeStylusDataInterest extends Int32 {
    static RTSDI_AllData := -1
    static RTSDI_None := 0
    static RTSDI_Error := 1
    static RTSDI_RealTimeStylusEnabled := 2
    static RTSDI_RealTimeStylusDisabled := 4
    static RTSDI_StylusNew := 8
    static RTSDI_StylusInRange := 16
    static RTSDI_InAirPackets := 32
    static RTSDI_StylusOutOfRange := 64
    static RTSDI_StylusDown := 128
    static RTSDI_Packets := 256
    static RTSDI_StylusUp := 512
    static RTSDI_StylusButtonUp := 1024
    static RTSDI_StylusButtonDown := 2048
    static RTSDI_SystemEvents := 4096
    static RTSDI_TabletAdded := 8192
    static RTSDI_TabletRemoved := 16384
    static RTSDI_CustomStylusDataAdded := 32768
    static RTSDI_UpdateMapping := 65536
    static RTSDI_DefaultEvents := 37766
}
struct StylusInfo {
    tcid : UInt32
    cid : UInt32
    bIsInvertedCursor : BOOL
}
struct StylusQueue extends Int32 {
    static SyncStylusQueue := 1
    static AsyncStylusQueueImmediate := 2
    static AsyncStylusQueue := 3
}
struct RealTimeStylusLockType extends Int32 {
    static RTSLT_ObjLock := 1
    static RTSLT_SyncEventLock := 2
    static RTSLT_AsyncEventLock := 4
    static RTSLT_ExcludeCallback := 8
    static RTSLT_SyncObjLock := 11
    static RTSLT_AsyncObjLock := 13
}
struct GESTURE_DATA {
    gestureId : Int32
    recoConfidence : Int32
    strokeCount : Int32
}
struct DYNAMIC_RENDERER_CACHED_DATA {
    strokeId : Int32
    dynamicRenderer : IDynamicRenderer
}
struct IRealTimeStylus extends IUnknown {
    static IID := "{A8BB5D22-3144-4A7B-93CD-F34A16BE513A}"
    get_Enabled(pfEnable)
      => ComCall(3, this.p, BOOL.Ptr, pfEnable)
    put_Enabled(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
    get_HWND(phwnd)
      => ComCall(5, this.p, HANDLE_PTR.Ptr, phwnd)
    put_HWND(hwnd)
      => ComCall(6, this.p, HANDLE_PTR, hwnd)
    get_WindowInputRectangle(prcWndInputRect)
      => ComCall(7, this.p, RECT.Ptr, prcWndInputRect)
    put_WindowInputRectangle(prcWndInputRect)
      => ComCall(8, this.p, RECT.Ptr, prcWndInputRect)
    AddStylusSyncPlugin(iIndex, piPlugin?)
      => ComCall(9, this.p, UInt32, iIndex, IStylusSyncPlugin, piPlugin?)
    RemoveStylusSyncPlugin(iIndex, ppiPlugin)
      => ComCall(10, this.p, UInt32, iIndex, IStylusSyncPlugin.Ptr, ppiPlugin)
    RemoveAllStylusSyncPlugins()
      => ComCall(11, this.p)
    GetStylusSyncPlugin(iIndex, ppiPlugin)
      => ComCall(12, this.p, UInt32, iIndex, IStylusSyncPlugin.Ptr, ppiPlugin)
    GetStylusSyncPluginCount(pcPlugins)
      => ComCall(13, this.p, UInt32.Ptr, pcPlugins)
    AddStylusAsyncPlugin(iIndex, piPlugin?)
      => ComCall(14, this.p, UInt32, iIndex, IStylusAsyncPlugin, piPlugin?)
    RemoveStylusAsyncPlugin(iIndex, ppiPlugin)
      => ComCall(15, this.p, UInt32, iIndex, IStylusAsyncPlugin.Ptr, ppiPlugin)
    RemoveAllStylusAsyncPlugins()
      => ComCall(16, this.p)
    GetStylusAsyncPlugin(iIndex, ppiPlugin)
      => ComCall(17, this.p, UInt32, iIndex, IStylusAsyncPlugin.Ptr, ppiPlugin)
    GetStylusAsyncPluginCount(pcPlugins)
      => ComCall(18, this.p, UInt32.Ptr, pcPlugins)
    get_ChildRealTimeStylusPlugin(ppiRTS)
      => ComCall(19, this.p, IRealTimeStylus.Ptr, ppiRTS)
    putref_ChildRealTimeStylusPlugin(piRTS?)
      => ComCall(20, this.p, IRealTimeStylus, piRTS?)
    AddCustomStylusDataToQueue(sq, pGuidId, pbData?)
      => ComCall(21, this.p, StylusQueue, sq, GUID.Ptr, pGuidId, UInt32, pbData?.Length ?? 0, UInt8.Ptr, pbData?)
    ClearStylusQueues()
      => ComCall(22, this.p)
    SetAllTabletsMode(fUseMouseForInput)
      => ComCall(23, this.p, BOOL, fUseMouseForInput)
    SetSingleTabletMode(piTablet?)
      => ComCall(24, this.p, IInkTablet, piTablet?)
    GetTablet(ppiSingleTablet)
      => ComCall(25, this.p, IInkTablet.Ptr, ppiSingleTablet)
    GetTabletContextIdFromTablet(piTablet?, ptcid)
      => ComCall(26, this.p, IInkTablet, piTablet?, UInt32.Ptr, ptcid)
    GetTabletFromTabletContextId(tcid, ppiTablet)
      => ComCall(27, this.p, UInt32, tcid, IInkTablet.Ptr, ppiTablet)
    GetAllTabletContextIds(pcTcidCount, ppTcids)
      => ComCall(28, this.p, UInt32.Ptr, pcTcidCount, UInt32.Ptr.Ptr, ppTcids)
    GetStyluses(ppiInkCursors)
      => ComCall(29, this.p, IInkCursors.Ptr, ppiInkCursors)
    GetStylusForId(sid, ppiInkCursor)
      => ComCall(30, this.p, UInt32, sid, IInkCursor.Ptr, ppiInkCursor)
    SetDesiredPacketDescription(pPropertyGuids)
      => ComCall(31, this.p, UInt32, pPropertyGuids.Length, GUID.Ptr, pPropertyGuids)
    GetDesiredPacketDescription(pcProperties, ppPropertyGuids)
      => ComCall(32, this.p, UInt32.Ptr, pcProperties, GUID.Ptr.Ptr, ppPropertyGuids)
    GetPacketDescriptionData(tcid, pfInkToDeviceScaleX?, pfInkToDeviceScaleY?, pcPacketProperties, ppPacketProperties)
      => ComCall(33, this.p, UInt32, tcid, Float32.Ptr, pfInkToDeviceScaleX?, Float32.Ptr, pfInkToDeviceScaleY?, UInt32.Ptr, pcPacketProperties, PACKET_PROPERTY.Ptr.Ptr, ppPacketProperties)
}
struct IRealTimeStylus2 extends IUnknown {
    static IID := "{B5F2A6CD-3179-4A3E-B9C4-BB5865962BE2}"
    get_FlicksEnabled(pfEnable)
      => ComCall(3, this.p, BOOL.Ptr, pfEnable)
    put_FlicksEnabled(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
}
struct IRealTimeStylus3 extends IUnknown {
    static IID := "{D70230A3-6986-4051-B57A-1CF69F4D9DB5}"
    get_MultiTouchEnabled(pfEnable)
      => ComCall(3, this.p, BOOL.Ptr, pfEnable)
    put_MultiTouchEnabled(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
}
struct IRealTimeStylusSynchronization extends IUnknown {
    static IID := "{AA87EAB8-AB4A-4CEA-B5CB-46D84C6A2509}"
    AcquireLock(lock)
      => ComCall(3, this.p, RealTimeStylusLockType, lock)
    ReleaseLock(lock)
      => ComCall(4, this.p, RealTimeStylusLockType, lock)
}
struct IStrokeBuilder extends IUnknown {
    static IID := "{A5FD4E2D-C44B-4092-9177-260905EB672B}"
    CreateStroke(pPackets, pPacketProperties, fInkToDeviceScaleX, fInkToDeviceScaleY, ppIInkStroke)
      => ComCall(3, this.p, UInt32, pPackets.Length, Int32.Ptr, pPackets, UInt32, pPacketProperties.Length, PACKET_PROPERTY.Ptr, pPacketProperties, Float32, fInkToDeviceScaleX, Float32, fInkToDeviceScaleY, IInkStrokeDisp.Ptr, ppIInkStroke)
    BeginStroke(tcid, sid, pPacket, pPacketProperties, fInkToDeviceScaleX, fInkToDeviceScaleY, ppIInkStroke?)
      => ComCall(4, this.p, UInt32, tcid, UInt32, sid, Int32.Ptr, pPacket, UInt32, pPacketProperties.Length, PACKET_PROPERTY.Ptr, pPacketProperties, Float32, fInkToDeviceScaleX, Float32, fInkToDeviceScaleY, IInkStrokeDisp.Ptr, ppIInkStroke?)
    AppendPackets(tcid, sid, pPackets)
      => ComCall(5, this.p, UInt32, tcid, UInt32, sid, UInt32, pPackets.Length, Int32.Ptr, pPackets)
    EndStroke(tcid, sid, ppIInkStroke, pDirtyRect)
      => ComCall(6, this.p, UInt32, tcid, UInt32, sid, IInkStrokeDisp.Ptr, ppIInkStroke, RECT.Ptr, pDirtyRect)
    get_Ink(ppiInkObj)
      => ComCall(7, this.p, IInkDisp.Ptr, ppiInkObj)
    putref_Ink(piInkObj?)
      => ComCall(8, this.p, IInkDisp, piInkObj?)
}
struct IStylusPlugin extends IUnknown {
    static IID := "{A81436D8-4757-4FD1-A185-133F97C6C545}"
    RealTimeStylusEnabled(piRtsSrc?, pTcids)
      => ComCall(3, this.p, IRealTimeStylus, piRtsSrc?, UInt32, pTcids.Length, UInt32.Ptr, pTcids)
    RealTimeStylusDisabled(piRtsSrc?, pTcids)
      => ComCall(4, this.p, IRealTimeStylus, piRtsSrc?, UInt32, pTcids.Length, UInt32.Ptr, pTcids)
    StylusInRange(piRtsSrc?, tcid, sid)
      => ComCall(5, this.p, IRealTimeStylus, piRtsSrc?, UInt32, tcid, UInt32, sid)
    StylusOutOfRange(piRtsSrc?, tcid, sid)
      => ComCall(6, this.p, IRealTimeStylus, piRtsSrc?, UInt32, tcid, UInt32, sid)
    StylusDown(piRtsSrc?, pStylusInfo, pPacket, ppInOutPkt)
      => ComCall(7, this.p, IRealTimeStylus, piRtsSrc?, StylusInfo.Ptr, pStylusInfo, UInt32, pPacket.Length, Int32.Ptr, pPacket, Int32.Ptr.Ptr, ppInOutPkt)
    StylusUp(piRtsSrc?, pStylusInfo, pPacket, ppInOutPkt)
      => ComCall(8, this.p, IRealTimeStylus, piRtsSrc?, StylusInfo.Ptr, pStylusInfo, UInt32, pPacket.Length, Int32.Ptr, pPacket, Int32.Ptr.Ptr, ppInOutPkt)
    StylusButtonDown(piRtsSrc?, sid, pGuidStylusButton, pStylusPos)
      => ComCall(9, this.p, IRealTimeStylus, piRtsSrc?, UInt32, sid, GUID.Ptr, pGuidStylusButton, POINT.Ptr, pStylusPos)
    StylusButtonUp(piRtsSrc?, sid, pGuidStylusButton, pStylusPos)
      => ComCall(10, this.p, IRealTimeStylus, piRtsSrc?, UInt32, sid, GUID.Ptr, pGuidStylusButton, POINT.Ptr, pStylusPos)
    InAirPackets(piRtsSrc?, pStylusInfo, cPktCount, pPackets, pcInOutPkts, ppInOutPkts)
      => ComCall(11, this.p, IRealTimeStylus, piRtsSrc?, StylusInfo.Ptr, pStylusInfo, UInt32, cPktCount, UInt32, pPackets.Length, Int32.Ptr, pPackets, UInt32.Ptr, pcInOutPkts, Int32.Ptr.Ptr, ppInOutPkts)
    Packets(piRtsSrc?, pStylusInfo, cPktCount, pPackets, pcInOutPkts, ppInOutPkts)
      => ComCall(12, this.p, IRealTimeStylus, piRtsSrc?, StylusInfo.Ptr, pStylusInfo, UInt32, cPktCount, UInt32, pPackets.Length, Int32.Ptr, pPackets, UInt32.Ptr, pcInOutPkts, Int32.Ptr.Ptr, ppInOutPkts)
    CustomStylusDataAdded(piRtsSrc?, pGuidId, pbData?)
      => ComCall(13, this.p, IRealTimeStylus, piRtsSrc?, GUID.Ptr, pGuidId, UInt32, pbData?.Length ?? 0, UInt8.Ptr, pbData?)
    SystemEvent(piRtsSrc?, tcid, sid, event, eventdata)
      => ComCall(14, this.p, IRealTimeStylus, piRtsSrc?, UInt32, tcid, UInt32, sid, UInt16, event, SYSTEM_EVENT_DATA, eventdata)
    TabletAdded(piRtsSrc?, piTablet?)
      => ComCall(15, this.p, IRealTimeStylus, piRtsSrc?, IInkTablet, piTablet?)
    TabletRemoved(piRtsSrc?, iTabletIndex)
      => ComCall(16, this.p, IRealTimeStylus, piRtsSrc?, Int32, iTabletIndex)
    Error(piRtsSrc?, piPlugin?, dataInterest, hrErrorCode, lptrKey)
      => ComCall(17, this.p, IRealTimeStylus, piRtsSrc?, IStylusPlugin, piPlugin?, RealTimeStylusDataInterest, dataInterest, HRESULT, hrErrorCode, IntPtr.Ptr, lptrKey)
    UpdateMapping(piRtsSrc?)
      => ComCall(18, this.p, IRealTimeStylus, piRtsSrc?)
    DataInterest(pDataInterest)
      => ComCall(19, this.p, RealTimeStylusDataInterest.Ptr, pDataInterest)
}
struct IStylusSyncPlugin extends IStylusPlugin {
    static IID := "{A157B174-482F-4D71-A3F6-3A41DDD11BE9}"
}
struct IStylusAsyncPlugin extends IStylusPlugin {
    static IID := "{A7CCA85A-31BC-4CD2-AADC-3289A3AF11C8}"
}
struct IDynamicRenderer extends IUnknown {
    static IID := "{A079468E-7165-46F9-B7AF-98AD01A93009}"
    get_Enabled(bEnabled)
      => ComCall(3, this.p, BOOL.Ptr, bEnabled)
    put_Enabled(bEnabled)
      => ComCall(4, this.p, BOOL, bEnabled)
    get_HWND(hwnd)
      => ComCall(5, this.p, HANDLE_PTR.Ptr, hwnd)
    put_HWND(hwnd)
      => ComCall(6, this.p, HANDLE_PTR, hwnd)
    get_ClipRectangle(prcClipRect)
      => ComCall(7, this.p, RECT.Ptr, prcClipRect)
    put_ClipRectangle(prcClipRect)
      => ComCall(8, this.p, RECT.Ptr, prcClipRect)
    get_ClipRegion(phClipRgn)
      => ComCall(9, this.p, HANDLE_PTR.Ptr, phClipRgn)
    put_ClipRegion(hClipRgn)
      => ComCall(10, this.p, HANDLE_PTR, hClipRgn)
    get_DrawingAttributes(ppiDA)
      => ComCall(11, this.p, IInkDrawingAttributes.Ptr, ppiDA)
    putref_DrawingAttributes(piDA?)
      => ComCall(12, this.p, IInkDrawingAttributes, piDA?)
    get_DataCacheEnabled(pfCacheData)
      => ComCall(13, this.p, BOOL.Ptr, pfCacheData)
    put_DataCacheEnabled(fCacheData)
      => ComCall(14, this.p, BOOL, fCacheData)
    ReleaseCachedData(strokeId)
      => ComCall(15, this.p, UInt32, strokeId)
    Refresh()
      => ComCall(16, this.p)
    Draw(hDC)
      => ComCall(17, this.p, HANDLE_PTR, hDC)
}
struct IGestureRecognizer extends IUnknown {
    static IID := "{AE9EF86B-7054-45E3-AE22-3174DC8811B7}"
    get_Enabled(pfEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pfEnabled)
    put_Enabled(fEnabled)
      => ComCall(4, this.p, BOOL, fEnabled)
    get_MaxStrokeCount(pcStrokes)
      => ComCall(5, this.p, Int32.Ptr, pcStrokes)
    put_MaxStrokeCount(cStrokes)
      => ComCall(6, this.p, Int32, cStrokes)
    EnableGestures(pGestures)
      => ComCall(7, this.p, UInt32, pGestures.Length, Int32.Ptr, pGestures)
    Reset()
      => ComCall(8, this.p)
}
struct RECO_GUIDE {
    xOrigin : Int32
    yOrigin : Int32
    cxBox : Int32
    cyBox : Int32
    cxBase : Int32
    cyBase : Int32
    cHorzBox : Int32
    cVertBox : Int32
    cyMid : Int32
}
struct RECO_ATTRS {
    dwRecoCapabilityFlags : UInt32
    awcVendorName : UInt16[32]
    awcFriendlyName : UInt16[64]
    awLanguageId : UInt16[64]
}
struct RECO_RANGE {
    iwcBegin : UInt32
    cCount : UInt32
}
struct LINE_SEGMENT {
    PtA : POINT
    PtB : POINT
}
struct LATTICE_METRICS {
    lsBaseline : LINE_SEGMENT
    iMidlineOffset : Int16
}
struct LINE_METRICS extends Int32 {
    static LM_BASELINE := 0
    static LM_MIDLINE := 1
    static LM_ASCENDER := 2
    static LM_DESCENDER := 3
}
struct CONFIDENCE_LEVEL extends Int32 {
    static CFL_STRONG := 0
    static CFL_INTERMEDIATE := 1
    static CFL_POOR := 2
}
struct ALT_BREAKS extends Int32 {
    static ALT_BREAKS_SAME := 0
    static ALT_BREAKS_UNIQUE := 1
    static ALT_BREAKS_FULL := 2
}
struct RECO_TYPE extends Int32 {
    static RECO_TYPE_WSTRING := 0
    static RECO_TYPE_WCHAR := 1
}
struct RECO_LATTICE_PROPERTY {
    guidProperty : GUID
    cbPropertyValue : UInt16
    pPropertyValue : UInt8.Ptr
}
struct RECO_LATTICE_PROPERTIES {
    cProperties : UInt32
    apProps : RECO_LATTICE_PROPERTY.Ptr.Ptr
}
struct RECO_LATTICE_ELEMENT {
    score : Int32
    type : UInt16
    pData : UInt8.Ptr
    ulNextColumn : UInt32
    ulStrokeNumber : UInt32
    epProp : RECO_LATTICE_PROPERTIES
}
struct RECO_LATTICE_COLUMN {
    key : UInt32
    cpProp : RECO_LATTICE_PROPERTIES
    cStrokes : UInt32
    pStrokes : UInt32.Ptr
    cLatticeElements : UInt32
    pLatticeElements : RECO_LATTICE_ELEMENT.Ptr
}
struct RECO_LATTICE {
    ulColumnCount : UInt32
    pLatticeColumns : RECO_LATTICE_COLUMN.Ptr
    ulPropertyCount : UInt32
    pGuidProperties : GUID.Ptr
    ulBestResultColumnCount : UInt32
    pulBestResultColumns : UInt32.Ptr
    pulBestResultIndexes : UInt32.Ptr
}
struct CHARACTER_RANGE {
    wcLow : UInt16
    cChars : UInt16
}
struct ITipAutoCompleteProvider extends IUnknown {
    static IID := "{7C6CF46D-8404-46B9-AD33-F5B6036D4007}"
    UpdatePendingText(bstrPendingText)
      => ComCall(3, this.p, BSTR, bstrPendingText)
    Show(fShow)
      => ComCall(4, this.p, BOOL, fShow)
}
struct ITipAutoCompleteClient extends IUnknown {
    static IID := "{5E078E03-8265-4BBE-9487-D242EDBEF910}"
    AdviseProvider(hWndField, pIProvider?)
      => ComCall(3, this.p, HWND, hWndField, ITipAutoCompleteProvider, pIProvider?)
    UnadviseProvider(hWndField, pIProvider?)
      => ComCall(4, this.p, HWND, hWndField, ITipAutoCompleteProvider, pIProvider?)
    UserSelection()
      => ComCall(5, this.p)
    PreferredRects(prcACList, prcField, prcModifiedACList, pfShownAboveTip)
      => ComCall(6, this.p, RECT.Ptr, prcACList, RECT.Ptr, prcField, RECT.Ptr, prcModifiedACList, BOOL.Ptr, pfShownAboveTip)
    RequestShowUI(hWndList, pfAllowShowing)
      => ComCall(7, this.p, HWND, hWndList, BOOL.Ptr, pfAllowShowing)
}
