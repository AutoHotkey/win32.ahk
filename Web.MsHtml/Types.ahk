#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HGLOBAL, HRESULT, HWND, LRESULT, POINT, PWSTR, RECT, SIZE, VARIANT_BOOL}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_FORMAT}
#Import "..\Graphics.Gdi\Types.ahk" {HDC, HRGN, LOGFONTW}
#Import "..\System.Com\Types.ahk" {IClassFactory, IDataObject, IDispatch, IEnumUnknown, IMoniker, IUnknown, SAFEARRAY}
#Import "..\System.Diagnostics.Debug.ActiveScript\Types.ahk" {IActiveScriptError}
#Import "..\System.Ole\Types.ahk" {IDispatchEx, IDropTarget, IOleCommandTarget, IOleInPlaceActiveObject, IOleInPlaceFrame, IOleInPlaceUIWindow}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Input.Ime\Types.ahk" {IActiveIMMApp}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {MSG}

struct HostDialogHelper {
    Value : IntPtr
}
struct IHTMLFiltersCollection extends IDispatch {
    static IID := "{3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(pvarIndex, pvarResult)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarResult)
}
struct IIE70DispatchEx extends IDispatchEx {
    static IID := "{3051046B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IIE80DispatchEx extends IDispatchEx {
    static IID := "{3051046C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct htmlDesignMode extends Int32 {
    static htmlDesignModeInherit := -2
    static htmlDesignModeOn := -1
    static htmlDesignModeOff := 0
    static htmlDesignMode_Max := 2147483647
}
struct htmlZOrder extends Int32 {
    static htmlZOrderFront := 0
    static htmlZOrderBack := 1
    static htmlZOrder_Max := 2147483647
}
struct htmlClear extends Int32 {
    static htmlClearNotSet := 0
    static htmlClearAll := 1
    static htmlClearLeft := 2
    static htmlClearRight := 3
    static htmlClearBoth := 4
    static htmlClearNone := 5
    static htmlClear_Max := 2147483647
}
struct htmlControlAlign extends Int32 {
    static htmlControlAlignNotSet := 0
    static htmlControlAlignLeft := 1
    static htmlControlAlignCenter := 2
    static htmlControlAlignRight := 3
    static htmlControlAlignTextTop := 4
    static htmlControlAlignAbsMiddle := 5
    static htmlControlAlignBaseline := 6
    static htmlControlAlignAbsBottom := 7
    static htmlControlAlignBottom := 8
    static htmlControlAlignMiddle := 9
    static htmlControlAlignTop := 10
    static htmlControlAlign_Max := 2147483647
}
struct htmlBlockAlign extends Int32 {
    static htmlBlockAlignNotSet := 0
    static htmlBlockAlignLeft := 1
    static htmlBlockAlignCenter := 2
    static htmlBlockAlignRight := 3
    static htmlBlockAlignJustify := 4
    static htmlBlockAlign_Max := 2147483647
}
struct htmlReadyState extends Int32 {
    static htmlReadyStateuninitialized := 0
    static htmlReadyStateloading := 1
    static htmlReadyStateloaded := 2
    static htmlReadyStateinteractive := 3
    static htmlReadyStatecomplete := 4
    static htmlReadyState_Max := 2147483647
}
struct htmlLoop extends Int32 {
    static htmlLoopLoopInfinite := -1
    static htmlLoop_Max := 2147483647
}
struct mediaType extends Int32 {
    static mediaTypeNotSet := 0
    static mediaTypeAll := 511
    static mediaTypeAural := 1
    static mediaTypeBraille := 2
    static mediaTypeEmbossed := 4
    static mediaTypeHandheld := 8
    static mediaTypePrint := 16
    static mediaTypeProjection := 32
    static mediaTypeScreen := 64
    static mediaTypeTty := 128
    static mediaTypeTv := 256
    static mediaType_Max := 2147483647
}
struct DomConstructor extends Int32 {
    static DomConstructorObject := 0
    static DomConstructorAttr := 1
    static DomConstructorBehaviorUrnsCollection := 2
    static DomConstructorBookmarkCollection := 3
    static DomConstructorCompatibleInfo := 4
    static DomConstructorCompatibleInfoCollection := 5
    static DomConstructorControlRangeCollection := 6
    static DomConstructorCSSCurrentStyleDeclaration := 7
    static DomConstructorCSSRuleList := 8
    static DomConstructorCSSRuleStyleDeclaration := 9
    static DomConstructorCSSStyleDeclaration := 10
    static DomConstructorCSSStyleRule := 11
    static DomConstructorCSSStyleSheet := 12
    static DomConstructorDataTransfer := 13
    static DomConstructorDOMImplementation := 14
    static DomConstructorElement := 15
    static DomConstructorEvent := 16
    static DomConstructorHistory := 17
    static DomConstructorHTCElementBehaviorDefaults := 18
    static DomConstructorHTMLAnchorElement := 19
    static DomConstructorHTMLAreaElement := 20
    static DomConstructorHTMLAreasCollection := 21
    static DomConstructorHTMLBaseElement := 22
    static DomConstructorHTMLBaseFontElement := 23
    static DomConstructorHTMLBGSoundElement := 24
    static DomConstructorHTMLBlockElement := 25
    static DomConstructorHTMLBodyElement := 26
    static DomConstructorHTMLBRElement := 27
    static DomConstructorHTMLButtonElement := 28
    static DomConstructorHTMLCollection := 29
    static DomConstructorHTMLCommentElement := 30
    static DomConstructorHTMLDDElement := 31
    static DomConstructorHTMLDivElement := 32
    static DomConstructorHTMLDocument := 33
    static DomConstructorHTMLDListElement := 34
    static DomConstructorHTMLDTElement := 35
    static DomConstructorHTMLEmbedElement := 36
    static DomConstructorHTMLFieldSetElement := 37
    static DomConstructorHTMLFontElement := 38
    static DomConstructorHTMLFormElement := 39
    static DomConstructorHTMLFrameElement := 40
    static DomConstructorHTMLFrameSetElement := 41
    static DomConstructorHTMLGenericElement := 42
    static DomConstructorHTMLHeadElement := 43
    static DomConstructorHTMLHeadingElement := 44
    static DomConstructorHTMLHRElement := 45
    static DomConstructorHTMLHtmlElement := 46
    static DomConstructorHTMLIFrameElement := 47
    static DomConstructorHTMLImageElement := 48
    static DomConstructorHTMLInputElement := 49
    static DomConstructorHTMLIsIndexElement := 50
    static DomConstructorHTMLLabelElement := 51
    static DomConstructorHTMLLegendElement := 52
    static DomConstructorHTMLLIElement := 53
    static DomConstructorHTMLLinkElement := 54
    static DomConstructorHTMLMapElement := 55
    static DomConstructorHTMLMarqueeElement := 56
    static DomConstructorHTMLMetaElement := 57
    static DomConstructorHTMLModelessDialog := 58
    static DomConstructorHTMLNamespaceInfo := 59
    static DomConstructorHTMLNamespaceInfoCollection := 60
    static DomConstructorHTMLNextIdElement := 61
    static DomConstructorHTMLNoShowElement := 62
    static DomConstructorHTMLObjectElement := 63
    static DomConstructorHTMLOListElement := 64
    static DomConstructorHTMLOptionElement := 65
    static DomConstructorHTMLParagraphElement := 66
    static DomConstructorHTMLParamElement := 67
    static DomConstructorHTMLPhraseElement := 68
    static DomConstructorHTMLPluginsCollection := 69
    static DomConstructorHTMLPopup := 70
    static DomConstructorHTMLScriptElement := 71
    static DomConstructorHTMLSelectElement := 72
    static DomConstructorHTMLSpanElement := 73
    static DomConstructorHTMLStyleElement := 74
    static DomConstructorHTMLTableCaptionElement := 75
    static DomConstructorHTMLTableCellElement := 76
    static DomConstructorHTMLTableColElement := 77
    static DomConstructorHTMLTableElement := 78
    static DomConstructorHTMLTableRowElement := 79
    static DomConstructorHTMLTableSectionElement := 80
    static DomConstructorHTMLTextAreaElement := 81
    static DomConstructorHTMLTextElement := 82
    static DomConstructorHTMLTitleElement := 83
    static DomConstructorHTMLUListElement := 84
    static DomConstructorHTMLUnknownElement := 85
    static DomConstructorImage := 86
    static DomConstructorLocation := 87
    static DomConstructorNamedNodeMap := 88
    static DomConstructorNavigator := 89
    static DomConstructorNodeList := 90
    static DomConstructorOption := 91
    static DomConstructorScreen := 92
    static DomConstructorSelection := 93
    static DomConstructorStaticNodeList := 94
    static DomConstructorStorage := 95
    static DomConstructorStyleSheetList := 96
    static DomConstructorStyleSheetPage := 97
    static DomConstructorStyleSheetPageList := 98
    static DomConstructorText := 99
    static DomConstructorTextRange := 100
    static DomConstructorTextRangeCollection := 101
    static DomConstructorTextRectangle := 102
    static DomConstructorTextRectangleList := 103
    static DomConstructorWindow := 104
    static DomConstructorXDomainRequest := 105
    static DomConstructorXMLHttpRequest := 106
    static DomConstructorMax := 107
    static DomConstructor_Max := 2147483647
}
struct styleTextTransform extends Int32 {
    static styleTextTransformNotSet := 0
    static styleTextTransformCapitalize := 1
    static styleTextTransformLowercase := 2
    static styleTextTransformUppercase := 3
    static styleTextTransformNone := 4
    static styleTextTransform_Max := 2147483647
}
struct styleDataRepeat extends Int32 {
    static styleDataRepeatNone := 0
    static styleDataRepeatInner := 1
    static styleDataRepeat_Max := 2147483647
}
struct styleOverflow extends Int32 {
    static styleOverflowNotSet := 0
    static styleOverflowAuto := 1
    static styleOverflowHidden := 2
    static styleOverflowVisible := 3
    static styleOverflowScroll := 4
    static styleOverflow_Max := 2147483647
}
struct styleMsOverflowStyle extends Int32 {
    static styleMsOverflowStyleNotSet := 0
    static styleMsOverflowStyleAuto := 1
    static styleMsOverflowStyleNone := 2
    static styleMsOverflowStyleScrollbar := 3
    static styleMsOverflowStyleMsAutoHidingScrollbar := 4
    static styleMsOverflowStyle_Max := 2147483647
}
struct styleTableLayout extends Int32 {
    static styleTableLayoutNotSet := 0
    static styleTableLayoutAuto := 1
    static styleTableLayoutFixed := 2
    static styleTableLayout_Max := 2147483647
}
struct styleBorderCollapse extends Int32 {
    static styleBorderCollapseNotSet := 0
    static styleBorderCollapseSeparate := 1
    static styleBorderCollapseCollapse := 2
    static styleBorderCollapse_Max := 2147483647
}
struct styleCaptionSide extends Int32 {
    static styleCaptionSideNotSet := 0
    static styleCaptionSideTop := 1
    static styleCaptionSideBottom := 2
    static styleCaptionSideLeft := 3
    static styleCaptionSideRight := 4
    static styleCaptionSide_Max := 2147483647
}
struct styleEmptyCells extends Int32 {
    static styleEmptyCellsNotSet := 0
    static styleEmptyCellsShow := 1
    static styleEmptyCellsHide := 2
    static styleEmptyCells_Max := 2147483647
}
struct styleFontStyle extends Int32 {
    static styleFontStyleNotSet := 0
    static styleFontStyleItalic := 1
    static styleFontStyleOblique := 2
    static styleFontStyleNormal := 3
    static styleFontStyle_Max := 2147483647
}
struct styleFontVariant extends Int32 {
    static styleFontVariantNotSet := 0
    static styleFontVariantSmallCaps := 1
    static styleFontVariantNormal := 2
    static styleFontVariant_Max := 2147483647
}
struct styleBackgroundRepeat extends Int32 {
    static styleBackgroundRepeatRepeat := 0
    static styleBackgroundRepeatRepeatX := 1
    static styleBackgroundRepeatRepeatY := 2
    static styleBackgroundRepeatNoRepeat := 3
    static styleBackgroundRepeatNotSet := 4
    static styleBackgroundRepeat_Max := 2147483647
}
struct styleBackgroundAttachment extends Int32 {
    static styleBackgroundAttachmentFixed := 0
    static styleBackgroundAttachmentScroll := 1
    static styleBackgroundAttachmentNotSet := 2
    static styleBackgroundAttachment_Max := 2147483647
}
struct styleBackgroundAttachment3 extends Int32 {
    static styleBackgroundAttachment3Fixed := 0
    static styleBackgroundAttachment3Scroll := 1
    static styleBackgroundAttachment3Local := 2
    static styleBackgroundAttachment3NotSet := 3
    static styleBackgroundAttachment3_Max := 2147483647
}
struct styleBackgroundClip extends Int32 {
    static styleBackgroundClipBorderBox := 0
    static styleBackgroundClipPaddingBox := 1
    static styleBackgroundClipContentBox := 2
    static styleBackgroundClipNotSet := 3
    static styleBackgroundClip_Max := 2147483647
}
struct styleBackgroundOrigin extends Int32 {
    static styleBackgroundOriginBorderBox := 0
    static styleBackgroundOriginPaddingBox := 1
    static styleBackgroundOriginContentBox := 2
    static styleBackgroundOriginNotSet := 3
    static styleBackgroundOrigin_Max := 2147483647
}
struct styleVerticalAlign extends Int32 {
    static styleVerticalAlignAuto := 0
    static styleVerticalAlignBaseline := 1
    static styleVerticalAlignSub := 2
    static styleVerticalAlignSuper := 3
    static styleVerticalAlignTop := 4
    static styleVerticalAlignTextTop := 5
    static styleVerticalAlignMiddle := 6
    static styleVerticalAlignBottom := 7
    static styleVerticalAlignTextBottom := 8
    static styleVerticalAlignInherit := 9
    static styleVerticalAlignNotSet := 10
    static styleVerticalAlign_Max := 2147483647
}
struct styleFontWeight extends Int32 {
    static styleFontWeightNotSet := 0
    static styleFontWeight100 := 1
    static styleFontWeight200 := 2
    static styleFontWeight300 := 3
    static styleFontWeight400 := 4
    static styleFontWeight500 := 5
    static styleFontWeight600 := 6
    static styleFontWeight700 := 7
    static styleFontWeight800 := 8
    static styleFontWeight900 := 9
    static styleFontWeightNormal := 10
    static styleFontWeightBold := 11
    static styleFontWeightBolder := 12
    static styleFontWeightLighter := 13
    static styleFontWeight_Max := 2147483647
}
struct styleFontSize extends Int32 {
    static styleFontSizeXXSmall := 0
    static styleFontSizeXSmall := 1
    static styleFontSizeSmall := 2
    static styleFontSizeMedium := 3
    static styleFontSizeLarge := 4
    static styleFontSizeXLarge := 5
    static styleFontSizeXXLarge := 6
    static styleFontSizeSmaller := 7
    static styleFontSizeLarger := 8
    static styleFontSize_Max := 2147483647
}
struct styleZIndex extends Int32 {
    static styleZIndexAuto := -2147483647
    static styleZIndex_Max := 2147483647
}
struct styleWidowsOrphans extends Int32 {
    static styleWidowsOrphansNotSet := -2147483647
    static styleWidowsOrphans_Max := 2147483647
}
struct styleAuto extends Int32 {
    static styleAutoAuto := 0
    static styleAuto_Max := 2147483647
}
struct styleNone extends Int32 {
    static styleNoneNone := 0
    static styleNone_Max := 2147483647
}
struct styleNormal extends Int32 {
    static styleNormalNormal := 0
    static styleNormal_Max := 2147483647
}
struct styleBorderWidth extends Int32 {
    static styleBorderWidthThin := 0
    static styleBorderWidthMedium := 1
    static styleBorderWidthThick := 2
    static styleBorderWidth_Max := 2147483647
}
struct stylePosition extends Int32 {
    static stylePositionNotSet := 0
    static stylePositionstatic := 1
    static stylePositionrelative := 2
    static stylePositionabsolute := 3
    static stylePositionfixed := 4
    static stylePositionMsPage := 5
    static stylePositionMsDeviceFixed := 6
    static stylePosition_Max := 2147483647
}
struct styleBorderStyle extends Int32 {
    static styleBorderStyleNotSet := 0
    static styleBorderStyleDotted := 1
    static styleBorderStyleDashed := 2
    static styleBorderStyleSolid := 3
    static styleBorderStyleDouble := 4
    static styleBorderStyleGroove := 5
    static styleBorderStyleRidge := 6
    static styleBorderStyleInset := 7
    static styleBorderStyleOutset := 8
    static styleBorderStyleWindowInset := 9
    static styleBorderStyleNone := 10
    static styleBorderStyleHidden := 11
    static styleBorderStyle_Max := 2147483647
}
struct styleOutlineStyle extends Int32 {
    static styleOutlineStyleNotSet := 0
    static styleOutlineStyleDotted := 1
    static styleOutlineStyleDashed := 2
    static styleOutlineStyleSolid := 3
    static styleOutlineStyleDouble := 4
    static styleOutlineStyleGroove := 5
    static styleOutlineStyleRidge := 6
    static styleOutlineStyleInset := 7
    static styleOutlineStyleOutset := 8
    static styleOutlineStyleWindowInset := 9
    static styleOutlineStyleNone := 10
    static styleOutlineStyle_Max := 2147483647
}
struct styleStyleFloat extends Int32 {
    static styleStyleFloatNotSet := 0
    static styleStyleFloatLeft := 1
    static styleStyleFloatRight := 2
    static styleStyleFloatNone := 3
    static styleStyleFloat_Max := 2147483647
}
struct styleDisplay extends Int32 {
    static styleDisplayNotSet := 0
    static styleDisplayBlock := 1
    static styleDisplayInline := 2
    static styleDisplayListItem := 3
    static styleDisplayNone := 4
    static styleDisplayTableHeaderGroup := 5
    static styleDisplayTableFooterGroup := 6
    static styleDisplayInlineBlock := 7
    static styleDisplayTable := 8
    static styleDisplayInlineTable := 9
    static styleDisplayTableRow := 10
    static styleDisplayTableRowGroup := 11
    static styleDisplayTableColumn := 12
    static styleDisplayTableColumnGroup := 13
    static styleDisplayTableCell := 14
    static styleDisplayTableCaption := 15
    static styleDisplayRunIn := 16
    static styleDisplayRuby := 17
    static styleDisplayRubyBase := 18
    static styleDisplayRubyText := 19
    static styleDisplayRubyBaseContainer := 20
    static styleDisplayRubyTextContainer := 21
    static styleDisplayMsFlexbox := 22
    static styleDisplayMsInlineFlexbox := 23
    static styleDisplayMsGrid := 24
    static styleDisplayMsInlineGrid := 25
    static styleDisplayFlex := 26
    static styleDisplayInlineFlex := 27
    static styleDisplayWebkitBox := 28
    static styleDisplayWebkitInlineBox := 29
    static styleDisplay_Max := 2147483647
}
struct styleVisibility extends Int32 {
    static styleVisibilityNotSet := 0
    static styleVisibilityInherit := 1
    static styleVisibilityVisible := 2
    static styleVisibilityHidden := 3
    static styleVisibilityCollapse := 4
    static styleVisibility_Max := 2147483647
}
struct styleListStyleType extends Int32 {
    static styleListStyleTypeNotSet := 0
    static styleListStyleTypeDisc := 1
    static styleListStyleTypeCircle := 2
    static styleListStyleTypeSquare := 3
    static styleListStyleTypeDecimal := 4
    static styleListStyleTypeLowerRoman := 5
    static styleListStyleTypeUpperRoman := 6
    static styleListStyleTypeLowerAlpha := 7
    static styleListStyleTypeUpperAlpha := 8
    static styleListStyleTypeNone := 9
    static styleListStyleTypeDecimalLeadingZero := 10
    static styleListStyleTypeGeorgian := 11
    static styleListStyleTypeArmenian := 12
    static styleListStyleTypeUpperLatin := 13
    static styleListStyleTypeLowerLatin := 14
    static styleListStyleTypeUpperGreek := 15
    static styleListStyleTypeLowerGreek := 16
    static styleListStyleType_Max := 2147483647
}
struct styleListStylePosition extends Int32 {
    static styleListStylePositionNotSet := 0
    static styleListStylePositionInside := 1
    static styleListStylePositionOutSide := 2
    static styleListStylePosition_Max := 2147483647
}
struct styleWhiteSpace extends Int32 {
    static styleWhiteSpaceNotSet := 0
    static styleWhiteSpaceNormal := 1
    static styleWhiteSpacePre := 2
    static styleWhiteSpaceNowrap := 3
    static styleWhiteSpacePreline := 4
    static styleWhiteSpacePrewrap := 5
    static styleWhiteSpace_Max := 2147483647
}
struct stylePageBreak extends Int32 {
    static stylePageBreakNotSet := 0
    static stylePageBreakAuto := 1
    static stylePageBreakAlways := 2
    static stylePageBreakLeft := 3
    static stylePageBreakRight := 4
    static stylePageBreakAvoid := 5
    static stylePageBreak_Max := 2147483647
}
struct stylePageBreakInside extends Int32 {
    static stylePageBreakInsideNotSet := 0
    static stylePageBreakInsideAuto := 1
    static stylePageBreakInsideAvoid := 2
    static stylePageBreakInside_Max := 2147483647
}
struct styleCursor extends Int32 {
    static styleCursorAuto := 0
    static styleCursorCrosshair := 1
    static styleCursorDefault := 2
    static styleCursorHand := 3
    static styleCursorMove := 4
    static styleCursorE_resize := 5
    static styleCursorNe_resize := 6
    static styleCursorNw_resize := 7
    static styleCursorN_resize := 8
    static styleCursorSe_resize := 9
    static styleCursorSw_resize := 10
    static styleCursorS_resize := 11
    static styleCursorW_resize := 12
    static styleCursorText := 13
    static styleCursorWait := 14
    static styleCursorHelp := 15
    static styleCursorPointer := 16
    static styleCursorProgress := 17
    static styleCursorNot_allowed := 18
    static styleCursorNo_drop := 19
    static styleCursorVertical_text := 20
    static styleCursorall_scroll := 21
    static styleCursorcol_resize := 22
    static styleCursorrow_resize := 23
    static styleCursorNone := 24
    static styleCursorContext_menu := 25
    static styleCursorEw_resize := 26
    static styleCursorNs_resize := 27
    static styleCursorNesw_resize := 28
    static styleCursorNwse_resize := 29
    static styleCursorCell := 30
    static styleCursorCopy := 31
    static styleCursorAlias := 32
    static styleCursorcustom := 33
    static styleCursorNotSet := 34
    static styleCursor_Max := 2147483647
}
struct styleDir extends Int32 {
    static styleDirNotSet := 0
    static styleDirLeftToRight := 1
    static styleDirRightToLeft := 2
    static styleDirInherit := 3
    static styleDir_Max := 2147483647
}
struct styleBidi extends Int32 {
    static styleBidiNotSet := 0
    static styleBidiNormal := 1
    static styleBidiEmbed := 2
    static styleBidiOverride := 3
    static styleBidiInherit := 4
    static styleBidi_Max := 2147483647
}
struct styleImeMode extends Int32 {
    static styleImeModeAuto := 0
    static styleImeModeActive := 1
    static styleImeModeInactive := 2
    static styleImeModeDisabled := 3
    static styleImeModeNotSet := 4
    static styleImeMode_Max := 2147483647
}
struct styleRubyAlign extends Int32 {
    static styleRubyAlignNotSet := 0
    static styleRubyAlignAuto := 1
    static styleRubyAlignLeft := 2
    static styleRubyAlignCenter := 3
    static styleRubyAlignRight := 4
    static styleRubyAlignDistributeLetter := 5
    static styleRubyAlignDistributeSpace := 6
    static styleRubyAlignLineEdge := 7
    static styleRubyAlign_Max := 2147483647
}
struct styleRubyPosition extends Int32 {
    static styleRubyPositionNotSet := 0
    static styleRubyPositionAbove := 1
    static styleRubyPositionInline := 2
    static styleRubyPosition_Max := 2147483647
}
struct styleRubyOverhang extends Int32 {
    static styleRubyOverhangNotSet := 0
    static styleRubyOverhangAuto := 1
    static styleRubyOverhangWhitespace := 2
    static styleRubyOverhangNone := 3
    static styleRubyOverhang_Max := 2147483647
}
struct styleLayoutGridChar extends Int32 {
    static styleLayoutGridCharNotSet := 0
    static styleLayoutGridCharAuto := 1
    static styleLayoutGridCharNone := 2
    static styleLayoutGridChar_Max := 2147483647
}
struct styleLayoutGridLine extends Int32 {
    static styleLayoutGridLineNotSet := 0
    static styleLayoutGridLineAuto := 1
    static styleLayoutGridLineNone := 2
    static styleLayoutGridLine_Max := 2147483647
}
struct styleLayoutGridMode extends Int32 {
    static styleLayoutGridModeNotSet := 0
    static styleLayoutGridModeChar := 1
    static styleLayoutGridModeLine := 2
    static styleLayoutGridModeBoth := 3
    static styleLayoutGridModeNone := 4
    static styleLayoutGridMode_Max := 2147483647
}
struct styleLayoutGridType extends Int32 {
    static styleLayoutGridTypeNotSet := 0
    static styleLayoutGridTypeLoose := 1
    static styleLayoutGridTypeStrict := 2
    static styleLayoutGridTypeFixed := 3
    static styleLayoutGridType_Max := 2147483647
}
struct styleLineBreak extends Int32 {
    static styleLineBreakNotSet := 0
    static styleLineBreakNormal := 1
    static styleLineBreakStrict := 2
    static styleLineBreak_Max := 2147483647
}
struct styleWordBreak extends Int32 {
    static styleWordBreakNotSet := 0
    static styleWordBreakNormal := 1
    static styleWordBreakBreakAll := 2
    static styleWordBreakKeepAll := 3
    static styleWordBreak_Max := 2147483647
}
struct styleWordWrap extends Int32 {
    static styleWordWrapNotSet := 0
    static styleWordWrapOff := 1
    static styleWordWrapOn := 2
    static styleWordWrap_Max := 2147483647
}
struct styleTextJustify extends Int32 {
    static styleTextJustifyNotSet := 0
    static styleTextJustifyInterWord := 1
    static styleTextJustifyNewspaper := 2
    static styleTextJustifyDistribute := 3
    static styleTextJustifyDistributeAllLines := 4
    static styleTextJustifyInterIdeograph := 5
    static styleTextJustifyInterCluster := 6
    static styleTextJustifyKashida := 7
    static styleTextJustifyAuto := 8
    static styleTextJustify_Max := 2147483647
}
struct styleTextAlignLast extends Int32 {
    static styleTextAlignLastNotSet := 0
    static styleTextAlignLastLeft := 1
    static styleTextAlignLastCenter := 2
    static styleTextAlignLastRight := 3
    static styleTextAlignLastJustify := 4
    static styleTextAlignLastAuto := 5
    static styleTextAlignLast_Max := 2147483647
}
struct styleTextJustifyTrim extends Int32 {
    static styleTextJustifyTrimNotSet := 0
    static styleTextJustifyTrimNone := 1
    static styleTextJustifyTrimPunctuation := 2
    static styleTextJustifyTrimPunctAndKana := 3
    static styleTextJustifyTrim_Max := 2147483647
}
struct styleAccelerator extends Int32 {
    static styleAcceleratorFalse := 0
    static styleAcceleratorTrue := 1
    static styleAccelerator_Max := 2147483647
}
struct styleLayoutFlow extends Int32 {
    static styleLayoutFlowHorizontal := 0
    static styleLayoutFlowVerticalIdeographic := 1
    static styleLayoutFlowNotSet := 2
    static styleLayoutFlow_Max := 2147483647
}
struct styleBlockProgression extends Int32 {
    static styleBlockProgressionTb := 0
    static styleBlockProgressionRl := 1
    static styleBlockProgressionBt := 2
    static styleBlockProgressionLr := 3
    static styleBlockProgressionNotSet := 4
    static styleBlockProgression_Max := 2147483647
}
struct styleWritingMode extends Int32 {
    static styleWritingModeLrtb := 0
    static styleWritingModeTbrl := 1
    static styleWritingModeRltb := 2
    static styleWritingModeBtrl := 3
    static styleWritingModeNotSet := 4
    static styleWritingModeTblr := 5
    static styleWritingModeBtlr := 6
    static styleWritingModeLrbt := 7
    static styleWritingModeRlbt := 8
    static styleWritingModeLr := 9
    static styleWritingModeRl := 10
    static styleWritingModeTb := 11
    static styleWritingMode_Max := 2147483647
}
struct styleBool extends Int32 {
    static styleBoolFalse := 0
    static styleBoolTrue := 1
    static styleBool_Max := 2147483647
}
struct styleTextUnderlinePosition extends Int32 {
    static styleTextUnderlinePositionBelow := 0
    static styleTextUnderlinePositionAbove := 1
    static styleTextUnderlinePositionAuto := 2
    static styleTextUnderlinePositionNotSet := 3
    static styleTextUnderlinePosition_Max := 2147483647
}
struct styleTextOverflow extends Int32 {
    static styleTextOverflowClip := 0
    static styleTextOverflowEllipsis := 1
    static styleTextOverflowNotSet := 2
    static styleTextOverflow_Max := 2147483647
}
struct styleInterpolation extends Int32 {
    static styleInterpolationNotSet := 0
    static styleInterpolationNN := 1
    static styleInterpolationBCH := 2
    static styleInterpolation_Max := 2147483647
}
struct styleBoxSizing extends Int32 {
    static styleBoxSizingNotSet := 0
    static styleBoxSizingContentBox := 1
    static styleBoxSizingBorderBox := 2
    static styleBoxSizing_Max := 2147483647
}
struct styleFlex extends Int32 {
    static styleFlexNone := 0
    static styleFlexNotSet := 1
    static styleFlex_Max := 2147483647
}
struct styleFlexBasis extends Int32 {
    static styleFlexBasisAuto := 0
    static styleFlexBasisNotSet := 1
    static styleFlexBasis_Max := 2147483647
}
struct styleFlexDirection extends Int32 {
    static styleFlexDirectionRow := 0
    static styleFlexDirectionRowReverse := 1
    static styleFlexDirectionColumn := 2
    static styleFlexDirectionColumnReverse := 3
    static styleFlexDirectionNotSet := 4
    static styleFlexDirection_Max := 2147483647
}
struct styleWebkitBoxOrient extends Int32 {
    static styleWebkitBoxOrientHorizontal := 0
    static styleWebkitBoxOrientInlineAxis := 1
    static styleWebkitBoxOrientVertical := 2
    static styleWebkitBoxOrientBlockAxis := 3
    static styleWebkitBoxOrientNotSet := 4
    static styleWebkitBoxOrient_Max := 2147483647
}
struct styleWebkitBoxDirection extends Int32 {
    static styleWebkitBoxDirectionNormal := 0
    static styleWebkitBoxDirectionReverse := 1
    static styleWebkitBoxDirectionNotSet := 2
    static styleWebkitBoxDirection_Max := 2147483647
}
struct styleFlexWrap extends Int32 {
    static styleFlexWrapNowrap := 0
    static styleFlexWrapWrap := 1
    static styleFlexWrapWrapReverse := 2
    static styleFlexWrapNotSet := 3
    static styleFlexWrap_Max := 2147483647
}
struct styleAlignItems extends Int32 {
    static styleAlignItemsFlexStart := 0
    static styleAlignItemsFlexEnd := 1
    static styleAlignItemsCenter := 2
    static styleAlignItemsBaseline := 3
    static styleAlignItemsStretch := 4
    static styleAlignItemsNotSet := 5
    static styleAlignItems_Max := 2147483647
}
struct styleMsFlexAlign extends Int32 {
    static styleMsFlexAlignStart := 0
    static styleMsFlexAlignEnd := 1
    static styleMsFlexAlignCenter := 2
    static styleMsFlexAlignBaseline := 3
    static styleMsFlexAlignStretch := 4
    static styleMsFlexAlignNotSet := 5
    static styleMsFlexAlign_Max := 2147483647
}
struct styleMsFlexItemAlign extends Int32 {
    static styleMsFlexItemAlignStart := 0
    static styleMsFlexItemAlignEnd := 1
    static styleMsFlexItemAlignCenter := 2
    static styleMsFlexItemAlignBaseline := 3
    static styleMsFlexItemAlignStretch := 4
    static styleMsFlexItemAlignAuto := 5
    static styleMsFlexItemAlignNotSet := 6
    static styleMsFlexItemAlign_Max := 2147483647
}
struct styleAlignSelf extends Int32 {
    static styleAlignSelfFlexStart := 0
    static styleAlignSelfFlexEnd := 1
    static styleAlignSelfCenter := 2
    static styleAlignSelfBaseline := 3
    static styleAlignSelfStretch := 4
    static styleAlignSelfAuto := 5
    static styleAlignSelfNotSet := 6
    static styleAlignSelf_Max := 2147483647
}
struct styleJustifyContent extends Int32 {
    static styleJustifyContentFlexStart := 0
    static styleJustifyContentFlexEnd := 1
    static styleJustifyContentCenter := 2
    static styleJustifyContentSpaceBetween := 3
    static styleJustifyContentSpaceAround := 4
    static styleJustifyContentNotSet := 5
    static styleJustifyContent_Max := 2147483647
}
struct styleMsFlexPack extends Int32 {
    static styleMsFlexPackStart := 0
    static styleMsFlexPackEnd := 1
    static styleMsFlexPackCenter := 2
    static styleMsFlexPackJustify := 3
    static styleMsFlexPackDistribute := 4
    static styleMsFlexPackNotSet := 5
    static styleMsFlexPack_Max := 2147483647
}
struct styleWebkitBoxPack extends Int32 {
    static styleWebkitBoxPackStart := 0
    static styleWebkitBoxPackEnd := 1
    static styleWebkitBoxPackCenter := 2
    static styleWebkitBoxPackJustify := 3
    static styleWebkitBoxPackNotSet := 5
    static styleWebkitBoxPack_Max := 2147483647
}
struct styleMsFlexLinePack extends Int32 {
    static styleMsFlexLinePackStart := 0
    static styleMsFlexLinePackEnd := 1
    static styleMsFlexLinePackCenter := 2
    static styleMsFlexLinePackJustify := 3
    static styleMsFlexLinePackDistribute := 4
    static styleMsFlexLinePackStretch := 5
    static styleMsFlexLinePackNotSet := 6
    static styleMsFlexLinePack_Max := 2147483647
}
struct styleAlignContent extends Int32 {
    static styleAlignContentFlexStart := 0
    static styleAlignContentFlexEnd := 1
    static styleAlignContentCenter := 2
    static styleAlignContentSpaceBetween := 3
    static styleAlignContentSpaceAround := 4
    static styleAlignContentStretch := 5
    static styleAlignContentNotSet := 6
    static styleAlignContent_Max := 2147483647
}
struct styleColumnFill extends Int32 {
    static styleColumnFillAuto := 0
    static styleColumnFillBalance := 1
    static styleColumnFillNotSet := 2
    static styleColumnFill_Max := 2147483647
}
struct styleColumnSpan extends Int32 {
    static styleColumnSpanNone := 0
    static styleColumnSpanAll := 1
    static styleColumnSpanOne := 2
    static styleColumnSpanNotSet := 3
    static styleColumnSpan_Max := 2147483647
}
struct styleBreak extends Int32 {
    static styleBreakNotSet := 0
    static styleBreakAuto := 1
    static styleBreakAlways := 2
    static styleBreakAvoid := 3
    static styleBreakLeft := 4
    static styleBreakRight := 5
    static styleBreakPage := 6
    static styleBreakColumn := 7
    static styleBreakAvoidPage := 8
    static styleBreakAvoidColumn := 9
    static styleBreak_Max := 2147483647
}
struct styleBreakInside extends Int32 {
    static styleBreakInsideNotSet := 0
    static styleBreakInsideAuto := 1
    static styleBreakInsideAvoid := 2
    static styleBreakInsideAvoidPage := 3
    static styleBreakInsideAvoidColumn := 4
    static styleBreakInside_Max := 2147483647
}
struct styleMsScrollChaining extends Int32 {
    static styleMsScrollChainingNotSet := 0
    static styleMsScrollChainingNone := 1
    static styleMsScrollChainingChained := 2
    static styleMsScrollChaining_Max := 2147483647
}
struct styleMsContentZooming extends Int32 {
    static styleMsContentZoomingNotSet := 0
    static styleMsContentZoomingNone := 1
    static styleMsContentZoomingZoom := 2
    static styleMsContentZooming_Max := 2147483647
}
struct styleMsContentZoomSnapType extends Int32 {
    static styleMsContentZoomSnapTypeNotSet := 0
    static styleMsContentZoomSnapTypeNone := 1
    static styleMsContentZoomSnapTypeMandatory := 2
    static styleMsContentZoomSnapTypeProximity := 3
    static styleMsContentZoomSnapType_Max := 2147483647
}
struct styleMsScrollRails extends Int32 {
    static styleMsScrollRailsNotSet := 0
    static styleMsScrollRailsNone := 1
    static styleMsScrollRailsRailed := 2
    static styleMsScrollRails_Max := 2147483647
}
struct styleMsContentZoomChaining extends Int32 {
    static styleMsContentZoomChainingNotSet := 0
    static styleMsContentZoomChainingNone := 1
    static styleMsContentZoomChainingChained := 2
    static styleMsContentZoomChaining_Max := 2147483647
}
struct styleMsScrollSnapType extends Int32 {
    static styleMsScrollSnapTypeNotSet := 0
    static styleMsScrollSnapTypeNone := 1
    static styleMsScrollSnapTypeMandatory := 2
    static styleMsScrollSnapTypeProximity := 3
    static styleMsScrollSnapType_Max := 2147483647
}
struct styleGridColumn extends Int32 {
    static styleGridColumnNotSet := 0
    static styleGridColumn_Max := 2147483647
}
struct styleGridColumnAlign extends Int32 {
    static styleGridColumnAlignCenter := 0
    static styleGridColumnAlignEnd := 1
    static styleGridColumnAlignStart := 2
    static styleGridColumnAlignStretch := 3
    static styleGridColumnAlignNotSet := 4
    static styleGridColumnAlign_Max := 2147483647
}
struct styleGridColumnSpan extends Int32 {
    static styleGridColumnSpanNotSet := 0
    static styleGridColumnSpan_Max := 2147483647
}
struct styleGridRow extends Int32 {
    static styleGridRowNotSet := 0
    static styleGridRow_Max := 2147483647
}
struct styleGridRowAlign extends Int32 {
    static styleGridRowAlignCenter := 0
    static styleGridRowAlignEnd := 1
    static styleGridRowAlignStart := 2
    static styleGridRowAlignStretch := 3
    static styleGridRowAlignNotSet := 4
    static styleGridRowAlign_Max := 2147483647
}
struct styleGridRowSpan extends Int32 {
    static styleGridRowSpanNotSet := 0
    static styleGridRowSpan_Max := 2147483647
}
struct styleWrapThrough extends Int32 {
    static styleWrapThroughNotSet := 0
    static styleWrapThroughWrap := 1
    static styleWrapThroughNone := 2
    static styleWrapThrough_Max := 2147483647
}
struct styleWrapFlow extends Int32 {
    static styleWrapFlowNotSet := 0
    static styleWrapFlowAuto := 1
    static styleWrapFlowBoth := 2
    static styleWrapFlowStart := 3
    static styleWrapFlowEnd := 4
    static styleWrapFlowClear := 5
    static styleWrapFlowMinimum := 6
    static styleWrapFlowMaximum := 7
    static styleWrapFlow_Max := 2147483647
}
struct styleAlignmentBaseline extends Int32 {
    static styleAlignmentBaselineNotSet := 0
    static styleAlignmentBaselineAfterEdge := 1
    static styleAlignmentBaselineAlphabetic := 2
    static styleAlignmentBaselineAuto := 3
    static styleAlignmentBaselineBaseline := 4
    static styleAlignmentBaselineBeforeEdge := 5
    static styleAlignmentBaselineCentral := 6
    static styleAlignmentBaselineHanging := 7
    static styleAlignmentBaselineMathematical := 8
    static styleAlignmentBaselineMiddle := 9
    static styleAlignmentBaselineTextAfterEdge := 10
    static styleAlignmentBaselineTextBeforeEdge := 11
    static styleAlignmentBaselineIdeographic := 12
    static styleAlignmentBaseline_Max := 2147483647
}
struct styleBaselineShift extends Int32 {
    static styleBaselineShiftBaseline := 0
    static styleBaselineShiftSub := 1
    static styleBaselineShiftSuper := 2
    static styleBaselineShift_Max := 2147483647
}
struct styleClipRule extends Int32 {
    static styleClipRuleNotSet := 0
    static styleClipRuleNonZero := 1
    static styleClipRuleEvenOdd := 2
    static styleClipRule_Max := 2147483647
}
struct styleDominantBaseline extends Int32 {
    static styleDominantBaselineNotSet := 0
    static styleDominantBaselineAlphabetic := 1
    static styleDominantBaselineAuto := 2
    static styleDominantBaselineCentral := 3
    static styleDominantBaselineHanging := 4
    static styleDominantBaselineIdeographic := 5
    static styleDominantBaselineMathematical := 6
    static styleDominantBaselineMiddle := 7
    static styleDominantBaselineNoChange := 8
    static styleDominantBaselineResetSize := 9
    static styleDominantBaselineTextAfterEdge := 10
    static styleDominantBaselineTextBeforeEdge := 11
    static styleDominantBaselineUseScript := 12
    static styleDominantBaseline_Max := 2147483647
}
struct styleFillRule extends Int32 {
    static styleFillRuleNotSet := 0
    static styleFillRuleNonZero := 1
    static styleFillRuleEvenOdd := 2
    static styleFillRule_Max := 2147483647
}
struct styleFontStretch extends Int32 {
    static styleFontStretchNotSet := 0
    static styleFontStretchWider := 1
    static styleFontStretchNarrower := 2
    static styleFontStretchUltraCondensed := 3
    static styleFontStretchExtraCondensed := 4
    static styleFontStretchCondensed := 5
    static styleFontStretchSemiCondensed := 6
    static styleFontStretchNormal := 7
    static styleFontStretchSemiExpanded := 8
    static styleFontStretchExpanded := 9
    static styleFontStretchExtraExpanded := 10
    static styleFontStretchUltraExpanded := 11
    static styleFontStretch_Max := 2147483647
}
struct stylePointerEvents extends Int32 {
    static stylePointerEventsNotSet := 0
    static stylePointerEventsVisiblePainted := 1
    static stylePointerEventsVisibleFill := 2
    static stylePointerEventsVisibleStroke := 3
    static stylePointerEventsVisible := 4
    static stylePointerEventsPainted := 5
    static stylePointerEventsFill := 6
    static stylePointerEventsStroke := 7
    static stylePointerEventsAll := 8
    static stylePointerEventsNone := 9
    static stylePointerEventsInitial := 10
    static stylePointerEventsAuto := 11
    static stylePointerEvents_Max := 2147483647
}
struct styleEnableBackground extends Int32 {
    static styleEnableBackgroundNotSet := 0
    static styleEnableBackgroundAccumulate := 1
    static styleEnableBackgroundNew := 2
    static styleEnableBackgroundInherit := 3
    static styleEnableBackground_Max := 2147483647
}
struct styleStrokeLinecap extends Int32 {
    static styleStrokeLinecapNotSet := 0
    static styleStrokeLinecapButt := 1
    static styleStrokeLinecapRound := 2
    static styleStrokeLinecapSquare := 3
    static styleStrokeLinecap_Max := 2147483647
}
struct styleStrokeLinejoin extends Int32 {
    static styleStrokeLinejoinNotSet := 0
    static styleStrokeLinejoinMiter := 1
    static styleStrokeLinejoinRound := 2
    static styleStrokeLinejoinBevel := 3
    static styleStrokeLinejoin_Max := 2147483647
}
struct styleTextAnchor extends Int32 {
    static styleTextAnchorNotSet := 0
    static styleTextAnchorStart := 1
    static styleTextAnchorMiddle := 2
    static styleTextAnchorEnd := 3
    static styleTextAnchor_Max := 2147483647
}
struct styleAttrType extends Int32 {
    static styleAttrTypeString := 0
    static styleAttrTypeColor := 1
    static styleAttrTypeUrl := 2
    static styleAttrTypeInteger := 3
    static styleAttrTypeNumber := 4
    static styleAttrTypeLength := 5
    static styleAttrTypePx := 6
    static styleAttrTypeEm := 7
    static styleAttrTypeEx := 8
    static styleAttrTypeIn := 9
    static styleAttrTypeCm := 10
    static styleAttrTypeMm := 11
    static styleAttrTypePt := 12
    static styleAttrTypePc := 13
    static styleAttrTypeRem := 14
    static styleAttrTypeCh := 15
    static styleAttrTypeVh := 16
    static styleAttrTypeVw := 17
    static styleAttrTypeVmin := 18
    static styleAttrTypePercentage := 19
    static styleAttrTypeAngle := 20
    static styleAttrTypeDeg := 21
    static styleAttrTypeRad := 22
    static styleAttrTypeGrad := 23
    static styleAttrTypeTime := 24
    static styleAttrTypeS := 25
    static styleAttrTypeMs := 26
    static styleAttrType_Max := 2147483647
}
struct styleInitialColor extends Int32 {
    static styleInitialColorNoInitial := 0
    static styleInitialColorColorProperty := 1
    static styleInitialColorTransparent := 2
    static styleInitialColorInvert := 3
    static styleInitialColor_Max := 2147483647
}
struct styleInitialString extends Int32 {
    static styleInitialStringNoInitial := 0
    static styleInitialStringNone := 1
    static styleInitialStringAuto := 2
    static styleInitialStringNormal := 3
    static styleInitialString_Max := 2147483647
}
struct styleTransformOriginX extends Int32 {
    static styleTransformOriginXNotSet := 0
    static styleTransformOriginXLeft := 1
    static styleTransformOriginXCenter := 2
    static styleTransformOriginXRight := 3
    static styleTransformOriginX_Max := 2147483647
}
struct styleTransformOriginY extends Int32 {
    static styleTransformOriginYNotSet := 0
    static styleTransformOriginYTop := 1
    static styleTransformOriginYCenter := 2
    static styleTransformOriginYBottom := 3
    static styleTransformOriginY_Max := 2147483647
}
struct stylePerspectiveOriginX extends Int32 {
    static stylePerspectiveOriginXNotSet := 0
    static stylePerspectiveOriginXLeft := 1
    static stylePerspectiveOriginXCenter := 2
    static stylePerspectiveOriginXRight := 3
    static stylePerspectiveOriginX_Max := 2147483647
}
struct stylePerspectiveOriginY extends Int32 {
    static stylePerspectiveOriginYNotSet := 0
    static stylePerspectiveOriginYTop := 1
    static stylePerspectiveOriginYCenter := 2
    static stylePerspectiveOriginYBottom := 3
    static stylePerspectiveOriginY_Max := 2147483647
}
struct styleTransformStyle extends Int32 {
    static styleTransformStyleFlat := 0
    static styleTransformStylePreserve3D := 1
    static styleTransformStyleNotSet := 2
    static styleTransformStyle_Max := 2147483647
}
struct styleBackfaceVisibility extends Int32 {
    static styleBackfaceVisibilityVisible := 0
    static styleBackfaceVisibilityHidden := 1
    static styleBackfaceVisibilityNotSet := 2
    static styleBackfaceVisibility_Max := 2147483647
}
struct styleTextSizeAdjust extends Int32 {
    static styleTextSizeAdjustNone := 0
    static styleTextSizeAdjustAuto := 1
    static styleTextSizeAdjust_Max := 2147483647
}
struct styleColorInterpolationFilters extends Int32 {
    static styleColorInterpolationFiltersAuto := 0
    static styleColorInterpolationFiltersSRgb := 1
    static styleColorInterpolationFiltersLinearRgb := 2
    static styleColorInterpolationFiltersNotSet := 3
    static styleColorInterpolationFilters_Max := 2147483647
}
struct styleHyphens extends Int32 {
    static styleHyphensNone := 0
    static styleHyphensManual := 1
    static styleHyphensAuto := 2
    static styleHyphensNotSet := 3
    static styleHyphens_Max := 2147483647
}
struct styleHyphenateLimitLines extends Int32 {
    static styleHyphenateLimitLinesNoLimit := 0
    static styleHyphenateLimitLines_Max := 2147483647
}
struct styleMsAnimationPlayState extends Int32 {
    static styleMsAnimationPlayStateRunning := 0
    static styleMsAnimationPlayStatePaused := 1
    static styleMsAnimationPlayStateNotSet := 2
    static styleMsAnimationPlayState_Max := 2147483647
}
struct styleMsAnimationDirection extends Int32 {
    static styleMsAnimationDirectionNormal := 0
    static styleMsAnimationDirectionAlternate := 1
    static styleMsAnimationDirectionReverse := 2
    static styleMsAnimationDirectionAlternateReverse := 3
    static styleMsAnimationDirectionNotSet := 4
    static styleMsAnimationDirection_Max := 2147483647
}
struct styleMsAnimationFillMode extends Int32 {
    static styleMsAnimationFillModeNone := 0
    static styleMsAnimationFillModeForwards := 1
    static styleMsAnimationFillModeBackwards := 2
    static styleMsAnimationFillModeBoth := 3
    static styleMsAnimationFillModeNotSet := 4
    static styleMsAnimationFillMode_Max := 2147483647
}
struct styleMsHighContrastAdjust extends Int32 {
    static styleMsHighContrastAdjustNotSet := 0
    static styleMsHighContrastAdjustAuto := 1
    static styleMsHighContrastAdjustNone := 2
    static styleMsHighContrastAdjust_Max := 2147483647
}
struct styleMsUserSelect extends Int32 {
    static styleMsUserSelectAuto := 0
    static styleMsUserSelectText := 1
    static styleMsUserSelectElement := 2
    static styleMsUserSelectNone := 3
    static styleMsUserSelectNotSet := 4
    static styleMsUserSelect_Max := 2147483647
}
struct styleMsTouchAction extends Int32 {
    static styleMsTouchActionNotSet := -1
    static styleMsTouchActionNone := 0
    static styleMsTouchActionAuto := 1
    static styleMsTouchActionManipulation := 2
    static styleMsTouchActionDoubleTapZoom := 4
    static styleMsTouchActionPanX := 8
    static styleMsTouchActionPanY := 16
    static styleMsTouchActionPinchZoom := 32
    static styleMsTouchActionCrossSlideX := 64
    static styleMsTouchActionCrossSlideY := 128
    static styleMsTouchAction_Max := 2147483647
}
struct styleMsTouchSelect extends Int32 {
    static styleMsTouchSelectGrippers := 0
    static styleMsTouchSelectNone := 1
    static styleMsTouchSelectNotSet := 2
    static styleMsTouchSelect_Max := 2147483647
}
struct styleMsScrollTranslation extends Int32 {
    static styleMsScrollTranslationNotSet := 0
    static styleMsScrollTranslationNone := 1
    static styleMsScrollTranslationVtoH := 2
    static styleMsScrollTranslation_Max := 2147483647
}
struct styleBorderImageRepeat extends Int32 {
    static styleBorderImageRepeatStretch := 0
    static styleBorderImageRepeatRepeat := 1
    static styleBorderImageRepeatRound := 2
    static styleBorderImageRepeatSpace := 3
    static styleBorderImageRepeatNotSet := 4
    static styleBorderImageRepeat_Max := 2147483647
}
struct styleBorderImageSliceFill extends Int32 {
    static styleBorderImageSliceFillNotSet := 0
    static styleBorderImageSliceFillFill := 1
    static styleBorderImageSliceFill_Max := 2147483647
}
struct styleMsImeAlign extends Int32 {
    static styleMsImeAlignAuto := 0
    static styleMsImeAlignAfter := 1
    static styleMsImeAlignNotSet := 2
    static styleMsImeAlign_Max := 2147483647
}
struct styleMsTextCombineHorizontal extends Int32 {
    static styleMsTextCombineHorizontalNone := 0
    static styleMsTextCombineHorizontalAll := 1
    static styleMsTextCombineHorizontalDigits := 2
    static styleMsTextCombineHorizontalNotSet := 3
    static styleMsTextCombineHorizontal_Max := 2147483647
}
struct styleWebkitAppearance extends Int32 {
    static styleWebkitAppearanceNone := 0
    static styleWebkitAppearanceCapsLockIndicator := 1
    static styleWebkitAppearanceButton := 2
    static styleWebkitAppearanceButtonBevel := 3
    static styleWebkitAppearanceCaret := 4
    static styleWebkitAppearanceCheckbox := 5
    static styleWebkitAppearanceDefaultButton := 6
    static styleWebkitAppearanceListbox := 7
    static styleWebkitAppearanceListitem := 8
    static styleWebkitAppearanceMediaFullscreenButton := 9
    static styleWebkitAppearanceMediaMuteButton := 10
    static styleWebkitAppearanceMediaPlayButton := 11
    static styleWebkitAppearanceMediaSeekBackButton := 12
    static styleWebkitAppearanceMediaSeekForwardButton := 13
    static styleWebkitAppearanceMediaSlider := 14
    static styleWebkitAppearanceMediaSliderthumb := 15
    static styleWebkitAppearanceMenulist := 16
    static styleWebkitAppearanceMenulistButton := 17
    static styleWebkitAppearanceMenulistText := 18
    static styleWebkitAppearanceMenulistTextfield := 19
    static styleWebkitAppearancePushButton := 20
    static styleWebkitAppearanceRadio := 21
    static styleWebkitAppearanceSearchfield := 22
    static styleWebkitAppearanceSearchfieldCancelButton := 23
    static styleWebkitAppearanceSearchfieldDecoration := 24
    static styleWebkitAppearanceSearchfieldResultsButton := 25
    static styleWebkitAppearanceSearchfieldResultsDecoration := 26
    static styleWebkitAppearanceSliderHorizontal := 27
    static styleWebkitAppearanceSliderVertical := 28
    static styleWebkitAppearanceSliderthumbHorizontal := 29
    static styleWebkitAppearanceSliderthumbVertical := 30
    static styleWebkitAppearanceSquareButton := 31
    static styleWebkitAppearanceTextarea := 32
    static styleWebkitAppearanceTextfield := 33
    static styleWebkitAppearanceNotSet := 34
    static styleWebkitAppearance_Max := 2147483647
}
struct styleViewportSize extends Int32 {
    static styleViewportSizeAuto := 0
    static styleViewportSizeDeviceWidth := 1
    static styleViewportSizeDeviceHeight := 2
    static styleViewportSize_Max := 2147483647
}
struct styleUserZoom extends Int32 {
    static styleUserZoomNotSet := 0
    static styleUserZoomZoom := 1
    static styleUserZoomFixed := 2
    static styleUserZoom_Max := 2147483647
}
struct styleTextLineThroughStyle extends Int32 {
    static styleTextLineThroughStyleUndefined := 0
    static styleTextLineThroughStyleSingle := 1
    static styleTextLineThroughStyleDouble := 2
    static styleTextLineThroughStyle_Max := 2147483647
}
struct styleTextUnderlineStyle extends Int32 {
    static styleTextUnderlineStyleUndefined := 0
    static styleTextUnderlineStyleSingle := 1
    static styleTextUnderlineStyleDouble := 2
    static styleTextUnderlineStyleWords := 3
    static styleTextUnderlineStyleDotted := 4
    static styleTextUnderlineStyleThick := 5
    static styleTextUnderlineStyleDash := 6
    static styleTextUnderlineStyleDotDash := 7
    static styleTextUnderlineStyleDotDotDash := 8
    static styleTextUnderlineStyleWave := 9
    static styleTextUnderlineStyleSingleAccounting := 10
    static styleTextUnderlineStyleDoubleAccounting := 11
    static styleTextUnderlineStyleThickDash := 12
    static styleTextUnderlineStyle_Max := 2147483647
}
struct styleTextEffect extends Int32 {
    static styleTextEffectNone := 0
    static styleTextEffectEmboss := 1
    static styleTextEffectEngrave := 2
    static styleTextEffectOutline := 3
    static styleTextEffect_Max := 2147483647
}
struct styleDefaultTextSelection extends Int32 {
    static styleDefaultTextSelectionFalse := 0
    static styleDefaultTextSelectionTrue := 1
    static styleDefaultTextSelection_Max := 2147483647
}
struct styleTextDecoration extends Int32 {
    static styleTextDecorationNone := 0
    static styleTextDecorationUnderline := 1
    static styleTextDecorationOverline := 2
    static styleTextDecorationLineThrough := 3
    static styleTextDecorationBlink := 4
    static styleTextDecoration_Max := 2147483647
}
struct textDecoration extends Int32 {
    static textDecorationNone := 0
    static textDecorationUnderline := 1
    static textDecorationOverline := 2
    static textDecorationLineThrough := 3
    static textDecorationBlink := 4
    static textDecoration_Max := 2147483647
}
struct htmlListType extends Int32 {
    static htmlListTypeNotSet := 0
    static htmlListTypeLargeAlpha := 1
    static htmlListTypeSmallAlpha := 2
    static htmlListTypeLargeRoman := 3
    static htmlListTypeSmallRoman := 4
    static htmlListTypeNumbers := 5
    static htmlListTypeDisc := 6
    static htmlListTypeCircle := 7
    static htmlListTypeSquare := 8
    static htmlListType_Max := 2147483647
}
struct htmlMethod extends Int32 {
    static htmlMethodNotSet := 0
    static htmlMethodGet := 1
    static htmlMethodPost := 2
    static htmlMethod_Max := 2147483647
}
struct htmlWrap extends Int32 {
    static htmlWrapOff := 1
    static htmlWrapSoft := 2
    static htmlWrapHard := 3
    static htmlWrap_Max := 2147483647
}
struct htmlDir extends Int32 {
    static htmlDirNotSet := 0
    static htmlDirLeftToRight := 1
    static htmlDirRightToLeft := 2
    static htmlDir_Max := 2147483647
}
struct htmlEditable extends Int32 {
    static htmlEditableInherit := 0
    static htmlEditableTrue := 1
    static htmlEditableFalse := 2
    static htmlEditable_Max := 2147483647
}
struct htmlInput extends Int32 {
    static htmlInputNotSet := 0
    static htmlInputButton := 1
    static htmlInputCheckbox := 2
    static htmlInputFile := 3
    static htmlInputHidden := 4
    static htmlInputImage := 5
    static htmlInputPassword := 6
    static htmlInputRadio := 7
    static htmlInputReset := 8
    static htmlInputSelectOne := 9
    static htmlInputSelectMultiple := 10
    static htmlInputSubmit := 11
    static htmlInputText := 12
    static htmlInputTextarea := 13
    static htmlInputRichtext := 14
    static htmlInputRange := 15
    static htmlInputUrl := 16
    static htmlInputEmail := 17
    static htmlInputNumber := 18
    static htmlInputTel := 19
    static htmlInputSearch := 20
    static htmlInput_Max := 2147483647
}
struct htmlSpellCheck extends Int32 {
    static htmlSpellCheckNotSet := 0
    static htmlSpellCheckTrue := 1
    static htmlSpellCheckFalse := 2
    static htmlSpellCheckDefault := 3
    static htmlSpellCheck_Max := 2147483647
}
struct htmlEncoding extends Int32 {
    static htmlEncodingURL := 0
    static htmlEncodingMultipart := 1
    static htmlEncodingText := 2
    static htmlEncoding_Max := 2147483647
}
struct htmlAdjacency extends Int32 {
    static htmlAdjacencyBeforeBegin := 1
    static htmlAdjacencyAfterBegin := 2
    static htmlAdjacencyBeforeEnd := 3
    static htmlAdjacencyAfterEnd := 4
    static htmlAdjacency_Max := 2147483647
}
struct htmlTabIndex extends Int32 {
    static htmlTabIndexNotSet := -32768
    static htmlTabIndex_Max := 2147483647
}
struct htmlComponent extends Int32 {
    static htmlComponentClient := 0
    static htmlComponentSbLeft := 1
    static htmlComponentSbPageLeft := 2
    static htmlComponentSbHThumb := 3
    static htmlComponentSbPageRight := 4
    static htmlComponentSbRight := 5
    static htmlComponentSbUp := 6
    static htmlComponentSbPageUp := 7
    static htmlComponentSbVThumb := 8
    static htmlComponentSbPageDown := 9
    static htmlComponentSbDown := 10
    static htmlComponentSbLeft2 := 11
    static htmlComponentSbPageLeft2 := 12
    static htmlComponentSbRight2 := 13
    static htmlComponentSbPageRight2 := 14
    static htmlComponentSbUp2 := 15
    static htmlComponentSbPageUp2 := 16
    static htmlComponentSbDown2 := 17
    static htmlComponentSbPageDown2 := 18
    static htmlComponentSbTop := 19
    static htmlComponentSbBottom := 20
    static htmlComponentOutside := 21
    static htmlComponentGHTopLeft := 22
    static htmlComponentGHLeft := 23
    static htmlComponentGHTop := 24
    static htmlComponentGHBottomLeft := 25
    static htmlComponentGHTopRight := 26
    static htmlComponentGHBottom := 27
    static htmlComponentGHRight := 28
    static htmlComponentGHBottomRight := 29
    static htmlComponent_Max := 2147483647
}
struct htmlApplyLocation extends Int32 {
    static htmlApplyLocationInside := 0
    static htmlApplyLocationOutside := 1
    static htmlApplyLocation_Max := 2147483647
}
struct htmlGlyphMode extends Int32 {
    static htmlGlyphModeNone := 0
    static htmlGlyphModeBegin := 1
    static htmlGlyphModeEnd := 2
    static htmlGlyphModeBoth := 3
    static htmlGlyphMode_Max := 2147483647
}
struct htmlDraggable extends Int32 {
    static htmlDraggableAuto := 0
    static htmlDraggableTrue := 1
    static htmlDraggableFalse := 2
    static htmlDraggable_Max := 2147483647
}
struct htmlUnit extends Int32 {
    static htmlUnitCharacter := 1
    static htmlUnitWord := 2
    static htmlUnitSentence := 3
    static htmlUnitTextEdit := 6
    static htmlUnit_Max := 2147483647
}
struct htmlEndPoints extends Int32 {
    static htmlEndPointsStartToStart := 1
    static htmlEndPointsStartToEnd := 2
    static htmlEndPointsEndToStart := 3
    static htmlEndPointsEndToEnd := 4
    static htmlEndPoints_Max := 2147483647
}
struct htmlDirection extends Int32 {
    static htmlDirectionForward := 99999
    static htmlDirectionBackward := -99999
    static htmlDirection_Max := 2147483647
}
struct htmlStart extends Int32 {
    static htmlStartfileopen := 0
    static htmlStartmouseover := 1
    static htmlStart_Max := 2147483647
}
struct bodyScroll extends Int32 {
    static bodyScrollyes := 1
    static bodyScrollno := 2
    static bodyScrollauto := 4
    static bodyScrolldefault := 3
    static bodyScroll_Max := 2147483647
}
struct htmlSelectType extends Int32 {
    static htmlSelectTypeSelectOne := 1
    static htmlSelectTypeSelectMultiple := 2
    static htmlSelectType_Max := 2147483647
}
struct htmlSelectExFlag extends Int32 {
    static htmlSelectExFlagNone := 0
    static htmlSelectExFlagHideSelectionInDesign := 1
    static htmlSelectExFlag_Max := 2147483647
}
struct htmlSelection extends Int32 {
    static htmlSelectionNone := 0
    static htmlSelectionText := 1
    static htmlSelectionControl := 2
    static htmlSelectionTable := 3
    static htmlSelection_Max := 2147483647
}
struct htmlMarqueeBehavior extends Int32 {
    static htmlMarqueeBehaviorscroll := 1
    static htmlMarqueeBehaviorslide := 2
    static htmlMarqueeBehavioralternate := 3
    static htmlMarqueeBehavior_Max := 2147483647
}
struct htmlMarqueeDirection extends Int32 {
    static htmlMarqueeDirectionleft := 1
    static htmlMarqueeDirectionright := 3
    static htmlMarqueeDirectionup := 5
    static htmlMarqueeDirectiondown := 7
    static htmlMarqueeDirection_Max := 2147483647
}
struct htmlPersistState extends Int32 {
    static htmlPersistStateNormal := 0
    static htmlPersistStateFavorite := 1
    static htmlPersistStateHistory := 2
    static htmlPersistStateSnapshot := 3
    static htmlPersistStateUserData := 4
    static htmlPersistState_Max := 2147483647
}
struct htmlDropEffect extends Int32 {
    static htmlDropEffectCopy := 0
    static htmlDropEffectLink := 1
    static htmlDropEffectMove := 2
    static htmlDropEffectNone := 3
    static htmlDropEffect_Max := 2147483647
}
struct htmlEffectAllowed extends Int32 {
    static htmlEffectAllowedCopy := 0
    static htmlEffectAllowedLink := 1
    static htmlEffectAllowedMove := 2
    static htmlEffectAllowedCopyLink := 3
    static htmlEffectAllowedCopyMove := 4
    static htmlEffectAllowedLinkMove := 5
    static htmlEffectAllowedAll := 6
    static htmlEffectAllowedNone := 7
    static htmlEffectAllowedUninitialized := 8
    static htmlEffectAllowed_Max := 2147483647
}
struct htmlCompatMode extends Int32 {
    static htmlCompatModeBackCompat := 0
    static htmlCompatModeCSS1Compat := 1
    static htmlCompatMode_Max := 2147483647
}
struct htmlCaptionAlign extends Int32 {
    static htmlCaptionAlignNotSet := 0
    static htmlCaptionAlignLeft := 1
    static htmlCaptionAlignCenter := 2
    static htmlCaptionAlignRight := 3
    static htmlCaptionAlignJustify := 4
    static htmlCaptionAlignTop := 5
    static htmlCaptionAlignBottom := 6
    static htmlCaptionAlign_Max := 2147483647
}
struct htmlCaptionVAlign extends Int32 {
    static htmlCaptionVAlignNotSet := 0
    static htmlCaptionVAlignTop := 1
    static htmlCaptionVAlignBottom := 2
    static htmlCaptionVAlign_Max := 2147483647
}
struct htmlFrame extends Int32 {
    static htmlFrameNotSet := 0
    static htmlFramevoid := 1
    static htmlFrameabove := 2
    static htmlFramebelow := 3
    static htmlFramehsides := 4
    static htmlFramelhs := 5
    static htmlFramerhs := 6
    static htmlFramevsides := 7
    static htmlFramebox := 8
    static htmlFrameborder := 9
    static htmlFrame_Max := 2147483647
}
struct htmlRules extends Int32 {
    static htmlRulesNotSet := 0
    static htmlRulesnone := 1
    static htmlRulesgroups := 2
    static htmlRulesrows := 3
    static htmlRulescols := 4
    static htmlRulesall := 5
    static htmlRules_Max := 2147483647
}
struct htmlCellAlign extends Int32 {
    static htmlCellAlignNotSet := 0
    static htmlCellAlignLeft := 1
    static htmlCellAlignCenter := 2
    static htmlCellAlignRight := 3
    static htmlCellAlignMiddle := 2
    static htmlCellAlign_Max := 2147483647
}
struct htmlCellVAlign extends Int32 {
    static htmlCellVAlignNotSet := 0
    static htmlCellVAlignTop := 1
    static htmlCellVAlignMiddle := 2
    static htmlCellVAlignBottom := 3
    static htmlCellVAlignBaseline := 4
    static htmlCellVAlignCenter := 2
    static htmlCellVAlign_Max := 2147483647
}
struct frameScrolling extends Int32 {
    static frameScrollingyes := 1
    static frameScrollingno := 2
    static frameScrollingauto := 4
    static frameScrolling_Max := 2147483647
}
struct sandboxAllow extends Int32 {
    static sandboxAllowScripts := 0
    static sandboxAllowSameOrigin := 1
    static sandboxAllowTopNavigation := 2
    static sandboxAllowForms := 3
    static sandboxAllowPopups := 4
    static sandboxAllow_Max := 2147483647
}
struct svgAngleType extends Int32 {
    static SVG_ANGLETYPE_UNKNOWN := 0
    static SVG_ANGLETYPE_UNSPECIFIED := 1
    static SVG_ANGLETYPE_DEG := 2
    static SVG_ANGLETYPE_RAD := 3
    static SVG_ANGLETYPE_GRAD := 4
    static svgAngleType_Max := 2147483647
}
struct svgExternalResourcesRequired extends Int32 {
    static svgExternalResourcesRequiredFalse := 0
    static svgExternalResourcesRequiredTrue := 1
    static svgExternalResourcesRequired_Max := 2147483647
}
struct svgFocusable extends Int32 {
    static svgFocusableNotSet := 0
    static svgFocusableAuto := 1
    static svgFocusableTrue := 2
    static svgFocusableFalse := 3
    static svgFocusable_Max := 2147483647
}
struct svgLengthType extends Int32 {
    static SVG_LENGTHTYPE_UNKNOWN := 0
    static SVG_LENGTHTYPE_NUMBER := 1
    static SVG_LENGTHTYPE_PERCENTAGE := 2
    static SVG_LENGTHTYPE_EMS := 3
    static SVG_LENGTHTYPE_EXS := 4
    static SVG_LENGTHTYPE_PX := 5
    static SVG_LENGTHTYPE_CM := 6
    static SVG_LENGTHTYPE_MM := 7
    static SVG_LENGTHTYPE_IN := 8
    static SVG_LENGTHTYPE_PT := 9
    static SVG_LENGTHTYPE_PC := 10
    static svgLengthType_Max := 2147483647
}
struct svgPathSegType extends Int32 {
    static PATHSEG_UNKNOWN := 0
    static PATHSEG_CLOSEPATH := 1
    static PATHSEG_MOVETO_ABS := 2
    static PATHSEG_MOVETO_REL := 3
    static PATHSEG_LINETO_ABS := 4
    static PATHSEG_LINETO_REL := 5
    static PATHSEG_CURVETO_CUBIC_ABS := 6
    static PATHSEG_CURVETO_CUBIC_REL := 7
    static PATHSEG_CURVETO_QUADRATIC_ABS := 8
    static PATHSEG_CURVETO_QUADRATIC_REL := 9
    static PATHSEG_ARC_ABS := 10
    static PATHSEG_ARC_REL := 11
    static PATHSEG_LINETO_HORIZONTAL_ABS := 12
    static PATHSEG_LINETO_HORIZONTAL_REL := 13
    static PATHSEG_LINETO_VERTICAL_ABS := 14
    static PATHSEG_LINETO_VERTICAL_REL := 15
    static PATHSEG_CURVETO_CUBIC_SMOOTH_ABS := 16
    static PATHSEG_CURVETO_CUBIC_SMOOTH_REL := 17
    static PATHSEG_CURVETO_QUADRATIC_SMOOTH_ABS := 18
    static PATHSEG_CURVETO_QUADRATIC_SMOOTH_REL := 19
    static svgPathSegType_Max := 2147483647
}
struct svgTransformType extends Int32 {
    static SVG_TRANSFORM_UNKNOWN := 0
    static SVG_TRANSFORM_MATRIX := 1
    static SVG_TRANSFORM_TRANSLATE := 2
    static SVG_TRANSFORM_SCALE := 3
    static SVG_TRANSFORM_ROTATE := 4
    static SVG_TRANSFORM_SKEWX := 5
    static SVG_TRANSFORM_SKEWY := 6
    static svgTransformType_Max := 2147483647
}
struct svgPreserveAspectRatioAlignType extends Int32 {
    static SVG_PRESERVEASPECTRATIO_UNKNOWN := 0
    static SVG_PRESERVEASPECTRATIO_NONE := 1
    static SVG_PRESERVEASPECTRATIO_XMINYMIN := 2
    static SVG_PRESERVEASPECTRATIO_XMIDYMIN := 3
    static SVG_PRESERVEASPECTRATIO_XMAXYMIN := 4
    static SVG_PRESERVEASPECTRATIO_XMINYMID := 5
    static SVG_PRESERVEASPECTRATIO_XMIDYMID := 6
    static SVG_PRESERVEASPECTRATIO_XMAXYMID := 7
    static SVG_PRESERVEASPECTRATIO_XMINYMAX := 8
    static SVG_PRESERVEASPECTRATIO_XMIDYMAX := 9
    static SVG_PRESERVEASPECTRATIO_XMAXYMAX := 10
    static svgPreserveAspectRatioAlignType_Max := 2147483647
}
struct svgPreserveAspectMeetOrSliceType extends Int32 {
    static SVG_MEETORSLICE_UNKNOWN := 0
    static SVG_MEETORSLICE_MEET := 1
    static SVG_MEETORSLICE_SLICE := 2
    static svgPreserveAspectMeetOrSliceType_Max := 2147483647
}
struct svgUnitTypes extends Int32 {
    static SVG_UNITTYPE_UNKNOWN := 0
    static SVG_UNITTYPE_USERSPACEONUSE := 1
    static SVG_UNITTYPE_OBJECTBOUNDINGBOX := 2
    static svgUnitTypes_Max := 2147483647
}
struct svgSpreadMethod extends Int32 {
    static SVG_SPREADMETHOD_UNKNOWN := 0
    static SVG_SPREADMETHOD_PAD := 1
    static SVG_SPREADMETHOD_REFLECT := 2
    static SVG_SPREADMETHOD_REPEAT := 3
    static svgSpreadMethod_Max := 2147483647
}
struct svgFeblendMode extends Int32 {
    static SVG_FEBLEND_MODE_UNKNOWN := 0
    static SVG_FEBLEND_MODE_NORMAL := 1
    static SVG_FEBLEND_MODE_MULTIPLY := 2
    static SVG_FEBLEND_MODE_SCREEN := 3
    static SVG_FEBLEND_MODE_DARKEN := 4
    static SVG_FEBLEND_MODE_LIGHTEN := 5
    static svgFeblendMode_Max := 2147483647
}
struct svgFecolormatrixType extends Int32 {
    static SVG_FECOLORMATRIX_TYPE_UNKNOWN := 0
    static SVG_FECOLORMATRIX_TYPE_MATRIX := 1
    static SVG_FECOLORMATRIX_TYPE_SATURATE := 2
    static SVG_FECOLORMATRIX_TYPE_HUEROTATE := 3
    static SVG_FECOLORMATRIX_TYPE_LUMINANCETOALPHA := 4
    static svgFecolormatrixType_Max := 2147483647
}
struct svgFecomponenttransferType extends Int32 {
    static SVG_FECOMPONENTTRANSFER_TYPE_UNKNOWN := 0
    static SVG_FECOMPONENTTRANSFER_TYPE_IDENTITY := 1
    static SVG_FECOMPONENTTRANSFER_TYPE_TABLE := 2
    static SVG_FECOMPONENTTRANSFER_TYPE_DISCRETE := 3
    static SVG_FECOMPONENTTRANSFER_TYPE_LINEAR := 4
    static SVG_FECOMPONENTTRANSFER_TYPE_GAMMA := 5
    static svgFecomponenttransferType_Max := 2147483647
}
struct svgFecompositeOperator extends Int32 {
    static SVG_FECOMPOSITE_OPERATOR_UNKNOWN := 0
    static SVG_FECOMPOSITE_OPERATOR_OVER := 1
    static SVG_FECOMPOSITE_OPERATOR_IN := 2
    static SVG_FECOMPOSITE_OPERATOR_OUT := 3
    static SVG_FECOMPOSITE_OPERATOR_ATOP := 4
    static SVG_FECOMPOSITE_OPERATOR_XOR := 5
    static SVG_FECOMPOSITE_OPERATOR_ARITHMETIC := 6
    static svgFecompositeOperator_Max := 2147483647
}
struct svgEdgemode extends Int32 {
    static SVG_EDGEMODE_UNKNOWN := 0
    static SVG_EDGEMODE_DUPLICATE := 1
    static SVG_EDGEMODE_WRAP := 2
    static SVG_EDGEMODE_NONE := 3
    static svgEdgemode_Max := 2147483647
}
struct svgPreserveAlpha extends Int32 {
    static SVG_PRESERVEALPHA_FALSE := 0
    static SVG_PRESERVEALPHA_TRUE := 1
    static svgPreserveAlpha_Max := 2147483647
}
struct svgChannel extends Int32 {
    static SVG_CHANNEL_UNKNOWN := 0
    static SVG_CHANNEL_R := 1
    static SVG_CHANNEL_G := 2
    static SVG_CHANNEL_B := 3
    static SVG_CHANNEL_A := 4
    static svgChannel_Max := 2147483647
}
struct svgMorphologyOperator extends Int32 {
    static SVG_MORPHOLOGY_OPERATOR_UNKNOWN := 0
    static SVG_MORPHOLOGY_OPERATOR_ERODE := 1
    static SVG_MORPHOLOGY_OPERATOR_DILATE := 2
    static svgMorphologyOperator_Max := 2147483647
}
struct svgTurbulenceType extends Int32 {
    static SVG_TURBULENCE_TYPE_UNKNOWN := 0
    static SVG_TURBULENCE_TYPE_FACTALNOISE := 1
    static SVG_TURBULENCE_TYPE_TURBULENCE := 2
    static svgTurbulenceType_Max := 2147483647
}
struct svgStitchtype extends Int32 {
    static SVG_STITCHTYPE_UNKNOWN := 0
    static SVG_STITCHTYPE_STITCH := 1
    static SVG_STITCHTYPE_NOSTITCH := 2
    static svgStitchtype_Max := 2147483647
}
struct svgMarkerUnits extends Int32 {
    static SVG_MARKERUNITS_UNKNOWN := 0
    static SVG_MARKERUNITS_USERSPACEONUSE := 1
    static SVG_MARKERUNITS_STROKEWIDTH := 2
    static svgMarkerUnits_Max := 2147483647
}
struct svgMarkerOrient extends Int32 {
    static SVG_MARKER_ORIENT_UNKNOWN := 0
    static SVG_MARKER_ORIENT_AUTO := 1
    static SVG_MARKER_ORIENT_ANGLE := 2
    static svgMarkerOrient_Max := 2147483647
}
struct svgMarkerOrientAttribute extends Int32 {
    static svgMarkerOrientAttributeAuto := 0
    static svgMarkerOrientAttribute_Max := 2147483647
}
struct htmlMediaNetworkState extends Int32 {
    static htmlMediaNetworkStateEmpty := 0
    static htmlMediaNetworkStateIdle := 1
    static htmlMediaNetworkStateLoading := 2
    static htmlMediaNetworkStateNoSource := 3
    static htmlMediaNetworkState_Max := 2147483647
}
struct htmlMediaReadyState extends Int32 {
    static htmlMediaReadyStateHaveNothing := 0
    static htmlMediaReadyStateHaveMetadata := 1
    static htmlMediaReadyStateHaveCurrentData := 2
    static htmlMediaReadyStateHaveFutureData := 3
    static htmlMediaReadyStateHaveEnoughData := 4
    static htmlMediaReadyState_Max := 2147483647
}
struct htmlMediaErr extends Int32 {
    static htmlMediaErrAborted := 0
    static htmlMediaErrNetwork := 1
    static htmlMediaErrDecode := 2
    static htmlMediaErrSrcNotSupported := 3
    static htmlMediaErr_Max := 2147483647
}
struct lengthAdjust extends Int32 {
    static LENGTHADJUST_UNKNOWN := 0
    static LENGTHADJUST_SPACING := 1
    static LENGTHADJUST_SPACINGANDGLYPHS := 2
    static lengthAdjust_Max := 2147483647
}
struct textpathMethodtype extends Int32 {
    static TEXTPATH_METHODTYPE_UNKNOWN := 0
    static TEXTPATH_METHODTYPE_ALIGN := 1
    static TEXTPATH_METHODTYPE_STRETCH := 2
    static textpathMethodtype_Max := 2147483647
}
struct textpathSpacingtype extends Int32 {
    static TEXTPATH_SPACINGTYPE_UNKNOWN := 0
    static TEXTPATH_SPACINGTYPE_AUTO := 1
    static TEXTPATH_SPACINGTYPE_EXACT := 2
    static textpathSpacingtype_Max := 2147483647
}
struct ELEMENT_CORNER extends Int32 {
    static ELEMENT_CORNER_NONE := 0
    static ELEMENT_CORNER_TOP := 1
    static ELEMENT_CORNER_LEFT := 2
    static ELEMENT_CORNER_BOTTOM := 3
    static ELEMENT_CORNER_RIGHT := 4
    static ELEMENT_CORNER_TOPLEFT := 5
    static ELEMENT_CORNER_TOPRIGHT := 6
    static ELEMENT_CORNER_BOTTOMLEFT := 7
    static ELEMENT_CORNER_BOTTOMRIGHT := 8
    static ELEMENT_CORNER_Max := 2147483647
}
struct SECUREURLHOSTVALIDATE_FLAGS extends Int32 {
    static SUHV_PROMPTBEFORENO := 1
    static SUHV_SILENTYES := 2
    static SUHV_UNSECURESOURCE := 4
    static SECUREURLHOSTVALIDATE_FLAGS_Max := 2147483647
}
struct POINTER_GRAVITY extends Int32 {
    static POINTER_GRAVITY_Left := 0
    static POINTER_GRAVITY_Right := 1
    static POINTER_GRAVITY_Max := 2147483647
}
struct ELEMENT_ADJACENCY extends Int32 {
    static ELEM_ADJ_BeforeBegin := 0
    static ELEM_ADJ_AfterBegin := 1
    static ELEM_ADJ_BeforeEnd := 2
    static ELEM_ADJ_AfterEnd := 3
    static ELEMENT_ADJACENCY_Max := 2147483647
}
struct MARKUP_CONTEXT_TYPE extends Int32 {
    static CONTEXT_TYPE_None := 0
    static CONTEXT_TYPE_Text := 1
    static CONTEXT_TYPE_EnterScope := 2
    static CONTEXT_TYPE_ExitScope := 3
    static CONTEXT_TYPE_NoScope := 4
    static MARKUP_CONTEXT_TYPE_Max := 2147483647
}
struct FINDTEXT_FLAGS extends Int32 {
    static FINDTEXT_BACKWARDS := 1
    static FINDTEXT_WHOLEWORD := 2
    static FINDTEXT_MATCHCASE := 4
    static FINDTEXT_RAW := 131072
    static FINDTEXT_MATCHREPEATEDWHITESPACE := 262144
    static FINDTEXT_MATCHDIAC := 536870912
    static FINDTEXT_MATCHKASHIDA := 1073741824
    static FINDTEXT_MATCHALEFHAMZA := -2147483648
    static FINDTEXT_FLAGS_Max := 2147483647
}
struct MOVEUNIT_ACTION extends Int32 {
    static MOVEUNIT_PREVCHAR := 0
    static MOVEUNIT_NEXTCHAR := 1
    static MOVEUNIT_PREVCLUSTERBEGIN := 2
    static MOVEUNIT_NEXTCLUSTERBEGIN := 3
    static MOVEUNIT_PREVCLUSTEREND := 4
    static MOVEUNIT_NEXTCLUSTEREND := 5
    static MOVEUNIT_PREVWORDBEGIN := 6
    static MOVEUNIT_NEXTWORDBEGIN := 7
    static MOVEUNIT_PREVWORDEND := 8
    static MOVEUNIT_NEXTWORDEND := 9
    static MOVEUNIT_PREVPROOFWORD := 10
    static MOVEUNIT_NEXTPROOFWORD := 11
    static MOVEUNIT_NEXTURLBEGIN := 12
    static MOVEUNIT_PREVURLBEGIN := 13
    static MOVEUNIT_NEXTURLEND := 14
    static MOVEUNIT_PREVURLEND := 15
    static MOVEUNIT_PREVSENTENCE := 16
    static MOVEUNIT_NEXTSENTENCE := 17
    static MOVEUNIT_PREVBLOCK := 18
    static MOVEUNIT_NEXTBLOCK := 19
    static MOVEUNIT_ACTION_Max := 2147483647
}
struct PARSE_FLAGS extends Int32 {
    static PARSE_ABSOLUTIFYIE40URLS := 1
    static PARSE_DISABLEVML := 2
    static PARSE_FLAGS_Max := 2147483647
}
struct ELEMENT_TAG_ID extends Int32 {
    static TAGID_NULL := 0
    static TAGID_UNKNOWN := 1
    static TAGID_A := 2
    static TAGID_ACRONYM := 3
    static TAGID_ADDRESS := 4
    static TAGID_APPLET := 5
    static TAGID_AREA := 6
    static TAGID_B := 7
    static TAGID_BASE := 8
    static TAGID_BASEFONT := 9
    static TAGID_BDO := 10
    static TAGID_BGSOUND := 11
    static TAGID_BIG := 12
    static TAGID_BLINK := 13
    static TAGID_BLOCKQUOTE := 14
    static TAGID_BODY := 15
    static TAGID_BR := 16
    static TAGID_BUTTON := 17
    static TAGID_CAPTION := 18
    static TAGID_CENTER := 19
    static TAGID_CITE := 20
    static TAGID_CODE := 21
    static TAGID_COL := 22
    static TAGID_COLGROUP := 23
    static TAGID_COMMENT := 24
    static TAGID_COMMENT_RAW := 25
    static TAGID_DD := 26
    static TAGID_DEL := 27
    static TAGID_DFN := 28
    static TAGID_DIR := 29
    static TAGID_DIV := 30
    static TAGID_DL := 31
    static TAGID_DT := 32
    static TAGID_EM := 33
    static TAGID_EMBED := 34
    static TAGID_FIELDSET := 35
    static TAGID_FONT := 36
    static TAGID_FORM := 37
    static TAGID_FRAME := 38
    static TAGID_FRAMESET := 39
    static TAGID_GENERIC := 40
    static TAGID_H1 := 41
    static TAGID_H2 := 42
    static TAGID_H3 := 43
    static TAGID_H4 := 44
    static TAGID_H5 := 45
    static TAGID_H6 := 46
    static TAGID_HEAD := 47
    static TAGID_HR := 48
    static TAGID_HTML := 49
    static TAGID_I := 50
    static TAGID_IFRAME := 51
    static TAGID_IMG := 52
    static TAGID_INPUT := 53
    static TAGID_INS := 54
    static TAGID_KBD := 55
    static TAGID_LABEL := 56
    static TAGID_LEGEND := 57
    static TAGID_LI := 58
    static TAGID_LINK := 59
    static TAGID_LISTING := 60
    static TAGID_MAP := 61
    static TAGID_MARQUEE := 62
    static TAGID_MENU := 63
    static TAGID_META := 64
    static TAGID_NEXTID := 65
    static TAGID_NOBR := 66
    static TAGID_NOEMBED := 67
    static TAGID_NOFRAMES := 68
    static TAGID_NOSCRIPT := 69
    static TAGID_OBJECT := 70
    static TAGID_OL := 71
    static TAGID_OPTION := 72
    static TAGID_P := 73
    static TAGID_PARAM := 74
    static TAGID_PLAINTEXT := 75
    static TAGID_PRE := 76
    static TAGID_Q := 77
    static TAGID_RP := 78
    static TAGID_RT := 79
    static TAGID_RUBY := 80
    static TAGID_S := 81
    static TAGID_SAMP := 82
    static TAGID_SCRIPT := 83
    static TAGID_SELECT := 84
    static TAGID_SMALL := 85
    static TAGID_SPAN := 86
    static TAGID_STRIKE := 87
    static TAGID_STRONG := 88
    static TAGID_STYLE := 89
    static TAGID_SUB := 90
    static TAGID_SUP := 91
    static TAGID_TABLE := 92
    static TAGID_TBODY := 93
    static TAGID_TC := 94
    static TAGID_TD := 95
    static TAGID_TEXTAREA := 96
    static TAGID_TFOOT := 97
    static TAGID_TH := 98
    static TAGID_THEAD := 99
    static TAGID_TITLE := 100
    static TAGID_TR := 101
    static TAGID_TT := 102
    static TAGID_U := 103
    static TAGID_UL := 104
    static TAGID_VAR := 105
    static TAGID_WBR := 106
    static TAGID_XMP := 107
    static TAGID_ROOT := 108
    static TAGID_OPTGROUP := 109
    static TAGID_ABBR := 110
    static TAGID_SVG_A := 111
    static TAGID_SVG_ALTGLYPH := 112
    static TAGID_SVG_ALTGLYPHDEF := 113
    static TAGID_SVG_ALTGLYPHITEM := 114
    static TAGID_SVG_ANIMATE := 115
    static TAGID_SVG_ANIMATECOLOR := 116
    static TAGID_SVG_ANIMATEMOTION := 117
    static TAGID_SVG_ANIMATETRANSFORM := 118
    static TAGID_SVG_CIRCLE := 119
    static TAGID_SVG_CLIPPATH := 120
    static TAGID_SVG_COLOR_PROFILE := 121
    static TAGID_SVG_CURSOR := 122
    static TAGID_SVG_DEFINITION_SRC := 123
    static TAGID_SVG_DEFS := 124
    static TAGID_SVG_DESC := 125
    static TAGID_SVG_ELLIPSE := 126
    static TAGID_SVG_FEBLEND := 127
    static TAGID_SVG_FECOLORMATRIX := 128
    static TAGID_SVG_FECOMPONENTTRANSFER := 129
    static TAGID_SVG_FECOMPOSITE := 130
    static TAGID_SVG_FECONVOLVEMATRIX := 131
    static TAGID_SVG_FEDIFFUSELIGHTING := 132
    static TAGID_SVG_FEDISPLACEMENTMAP := 133
    static TAGID_SVG_FEDISTANTLIGHT := 134
    static TAGID_SVG_FEFLOOD := 135
    static TAGID_SVG_FEFUNCA := 136
    static TAGID_SVG_FEFUNCB := 137
    static TAGID_SVG_FEFUNCG := 138
    static TAGID_SVG_FEFUNCR := 139
    static TAGID_SVG_FEGAUSSIANBLUR := 140
    static TAGID_SVG_FEIMAGE := 141
    static TAGID_SVG_FEMERGE := 142
    static TAGID_SVG_FEMERGENODE := 143
    static TAGID_SVG_FEMORPHOLOGY := 144
    static TAGID_SVG_FEOFFSET := 145
    static TAGID_SVG_FEPOINTLIGHT := 146
    static TAGID_SVG_FESPECULARLIGHTING := 147
    static TAGID_SVG_FESPOTLIGHT := 148
    static TAGID_SVG_FETILE := 149
    static TAGID_SVG_FETURBULENCE := 150
    static TAGID_SVG_FILTER := 151
    static TAGID_SVG_FONT := 152
    static TAGID_SVG_FONT_FACE := 153
    static TAGID_SVG_FONT_FACE_FORMAT := 154
    static TAGID_SVG_FONT_FACE_NAME := 155
    static TAGID_SVG_FONT_FACE_SRC := 156
    static TAGID_SVG_FONT_FACE_URI := 157
    static TAGID_SVG_FOREIGNOBJECT := 158
    static TAGID_SVG_G := 159
    static TAGID_SVG_GLYPH := 160
    static TAGID_SVG_GLYPHREF := 161
    static TAGID_SVG_HKERN := 162
    static TAGID_SVG_IMAGE := 163
    static TAGID_SVG_LINE := 164
    static TAGID_SVG_LINEARGRADIENT := 165
    static TAGID_SVG_MARKER := 166
    static TAGID_SVG_MASK := 167
    static TAGID_SVG_METADATA := 168
    static TAGID_SVG_MISSING_GLYPH := 169
    static TAGID_SVG_MPATH := 170
    static TAGID_SVG_PATH := 171
    static TAGID_SVG_PATTERN := 172
    static TAGID_SVG_POLYGON := 173
    static TAGID_SVG_POLYLINE := 174
    static TAGID_SVG_RADIALGRADIENT := 175
    static TAGID_SVG_RECT := 176
    static TAGID_SVG_SCRIPT := 177
    static TAGID_SVG_SET := 178
    static TAGID_SVG_STOP := 179
    static TAGID_SVG_STYLE := 180
    static TAGID_SVG_SVG := 181
    static TAGID_SVG_SWITCH := 182
    static TAGID_SVG_SYMBOL := 183
    static TAGID_SVG_TEXT := 184
    static TAGID_SVG_TEXTPATH := 185
    static TAGID_SVG_TITLE := 186
    static TAGID_SVG_TREF := 187
    static TAGID_SVG_TSPAN := 188
    static TAGID_SVG_USE := 189
    static TAGID_SVG_VIEW := 190
    static TAGID_SVG_VKERN := 191
    static TAGID_AUDIO := 192
    static TAGID_SOURCE := 193
    static TAGID_VIDEO := 194
    static TAGID_CANVAS := 195
    static TAGID_DOCTYPE := 196
    static TAGID_KEYGEN := 197
    static TAGID_PROCESSINGINSTRUCTION := 198
    static TAGID_ARTICLE := 199
    static TAGID_ASIDE := 200
    static TAGID_FIGCAPTION := 201
    static TAGID_FIGURE := 202
    static TAGID_FOOTER := 203
    static TAGID_HEADER := 204
    static TAGID_HGROUP := 205
    static TAGID_MARK := 206
    static TAGID_NAV := 207
    static TAGID_SECTION := 208
    static TAGID_PROGRESS := 209
    static TAGID_MATHML_ANNOTATION_XML := 210
    static TAGID_MATHML_MATH := 211
    static TAGID_MATHML_MI := 212
    static TAGID_MATHML_MN := 213
    static TAGID_MATHML_MO := 214
    static TAGID_MATHML_MS := 215
    static TAGID_MATHML_MTEXT := 216
    static TAGID_DATALIST := 217
    static TAGID_TRACK := 218
    static TAGID_ISINDEX := 219
    static TAGID_COMMAND := 220
    static TAGID_DETAILS := 221
    static TAGID_SUMMARY := 222
    static TAGID_X_MS_WEBVIEW := 223
    static TAGID_COUNT := 224
    static TAGID_LAST_PREDEFINED := 10000
    static ELEMENT_TAG_ID_Max := 2147483647
}
struct SELECTION_TYPE extends Int32 {
    static SELECTION_TYPE_None := 0
    static SELECTION_TYPE_Caret := 1
    static SELECTION_TYPE_Text := 2
    static SELECTION_TYPE_Control := 3
    static SELECTION_TYPE_Max := 2147483647
}
struct SAVE_SEGMENTS_FLAGS extends Int32 {
    static SAVE_SEGMENTS_NoIE4SelectionCompat := 1
    static SAVE_SEGMENTS_FLAGS_Max := 2147483647
}
struct CARET_DIRECTION extends Int32 {
    static CARET_DIRECTION_INDETERMINATE := 0
    static CARET_DIRECTION_SAME := 1
    static CARET_DIRECTION_BACKWARD := 2
    static CARET_DIRECTION_FORWARD := 3
    static CARET_DIRECTION_Max := 2147483647
}
struct LINE_DIRECTION extends Int32 {
    static LINE_DIRECTION_RightToLeft := 1
    static LINE_DIRECTION_LeftToRight := 2
    static LINE_DIRECTION_Max := 2147483647
}
struct HT_OPTIONS extends Int32 {
    static HT_OPT_AllowAfterEOL := 1
    static HT_OPTIONS_Max := 2147483647
}
struct HT_RESULTS extends Int32 {
    static HT_RESULTS_Glyph := 1
    static HT_RESULTS_Max := 2147483647
}
struct DISPLAY_MOVEUNIT extends Int32 {
    static DISPLAY_MOVEUNIT_PreviousLine := 1
    static DISPLAY_MOVEUNIT_NextLine := 2
    static DISPLAY_MOVEUNIT_CurrentLineStart := 3
    static DISPLAY_MOVEUNIT_CurrentLineEnd := 4
    static DISPLAY_MOVEUNIT_TopOfWindow := 5
    static DISPLAY_MOVEUNIT_BottomOfWindow := 6
    static DISPLAY_MOVEUNIT_Max := 2147483647
}
struct DISPLAY_GRAVITY extends Int32 {
    static DISPLAY_GRAVITY_PreviousLine := 1
    static DISPLAY_GRAVITY_NextLine := 2
    static DISPLAY_GRAVITY_Max := 2147483647
}
struct DISPLAY_BREAK extends Int32 {
    static DISPLAY_BREAK_None := 0
    static DISPLAY_BREAK_Block := 1
    static DISPLAY_BREAK_Break := 2
    static DISPLAY_BREAK_Max := 2147483647
}
struct COORD_SYSTEM extends Int32 {
    static COORD_SYSTEM_GLOBAL := 0
    static COORD_SYSTEM_PARENT := 1
    static COORD_SYSTEM_CONTAINER := 2
    static COORD_SYSTEM_CONTENT := 3
    static COORD_SYSTEM_FRAME := 4
    static COORD_SYSTEM_CLIENT := 5
    static COORD_SYSTEM_Max := 2147483647
}
struct DEV_CONSOLE_MESSAGE_LEVEL extends Int32 {
    static DCML_INFORMATIONAL := 0
    static DCML_WARNING := 1
    static DCML_ERROR := 2
    static DEV_CONSOLE_MESSAGE_LEVEL_Max := 2147483647
}
struct DOM_EVENT_PHASE extends Int32 {
    static DEP_CAPTURING_PHASE := 1
    static DEP_AT_TARGET := 2
    static DEP_BUBBLING_PHASE := 3
    static DOM_EVENT_PHASE_Max := 2147483647
}
struct SCRIPT_TIMER_TYPE extends Int32 {
    static STT_TIMEOUT := 0
    static STT_INTERVAL := 1
    static STT_IMMEDIATE := 2
    static STT_ANIMATION_FRAME := 3
    static SCRIPT_TIMER_TYPE_Max := 2147483647
}
struct HTML_PAINTER extends Int32 {
    static HTMLPAINTER_OPAQUE := 1
    static HTMLPAINTER_TRANSPARENT := 2
    static HTMLPAINTER_ALPHA := 4
    static HTMLPAINTER_COMPLEX := 8
    static HTMLPAINTER_OVERLAY := 16
    static HTMLPAINTER_HITTEST := 32
    static HTMLPAINTER_SURFACE := 256
    static HTMLPAINTER_3DSURFACE := 512
    static HTMLPAINTER_NOBAND := 1024
    static HTMLPAINTER_NODC := 4096
    static HTMLPAINTER_NOPHYSICALCLIP := 8192
    static HTMLPAINTER_NOSAVEDC := 16384
    static HTMLPAINTER_SUPPORTS_XFORM := 32768
    static HTMLPAINTER_EXPAND := 65536
    static HTMLPAINTER_NOSCROLLBITS := 131072
    static HTML_PAINTER_Max := 2147483647
}
struct HTML_PAINT_ZORDER extends Int32 {
    static HTMLPAINT_ZORDER_NONE := 0
    static HTMLPAINT_ZORDER_REPLACE_ALL := 1
    static HTMLPAINT_ZORDER_REPLACE_CONTENT := 2
    static HTMLPAINT_ZORDER_REPLACE_BACKGROUND := 3
    static HTMLPAINT_ZORDER_BELOW_CONTENT := 4
    static HTMLPAINT_ZORDER_BELOW_FLOW := 5
    static HTMLPAINT_ZORDER_ABOVE_FLOW := 6
    static HTMLPAINT_ZORDER_ABOVE_CONTENT := 7
    static HTMLPAINT_ZORDER_WINDOW_TOP := 8
    static HTML_PAINT_ZORDER_Max := 2147483647
}
struct HTML_PAINT_DRAW_FLAGS extends Int32 {
    static HTMLPAINT_DRAW_UPDATEREGION := 1
    static HTMLPAINT_DRAW_USE_XFORM := 2
    static HTML_PAINT_DRAW_FLAGS_Max := 2147483647
}
struct HTML_PAINT_EVENT_FLAGS extends Int32 {
    static HTMLPAINT_EVENT_TARGET := 1
    static HTMLPAINT_EVENT_SETCURSOR := 2
    static HTML_PAINT_EVENT_FLAGS_Max := 2147483647
}
struct HTML_PAINT_DRAW_INFO_FLAGS extends Int32 {
    static HTMLPAINT_DRAWINFO_VIEWPORT := 1
    static HTMLPAINT_DRAWINFO_UPDATEREGION := 2
    static HTMLPAINT_DRAWINFO_XFORM := 4
    static HTML_PAINT_DRAW_INFO_FLAGS_Max := 2147483647
}
struct HTML_PAINTER_INFO {
    lFlags : Int32
    lZOrder : Int32
    iidDrawObject : GUID
    rcExpand : RECT
}
struct HTML_PAINT_XFORM {
    eM11 : Float32
    eM12 : Float32
    eM21 : Float32
    eM22 : Float32
    eDx : Float32
    eDy : Float32
}
struct HTML_PAINT_DRAW_INFO {
    rcViewport : RECT
    hrgnUpdate : HRGN
    xform : HTML_PAINT_XFORM
}
struct HTMLDlgFlag extends Int32 {
    static HTMLDlgFlagNo := 0
    static HTMLDlgFlagOff := 0
    static HTMLDlgFlag0 := 0
    static HTMLDlgFlagYes := 1
    static HTMLDlgFlagOn := 1
    static HTMLDlgFlag1 := 1
    static HTMLDlgFlagNotSet := -1
    static HTMLDlgFlag_Max := 2147483647
}
struct HTMLDlgBorder extends Int32 {
    static HTMLDlgBorderThin := 0
    static HTMLDlgBorderThick := 262144
    static HTMLDlgBorder_Max := 2147483647
}
struct HTMLDlgEdge extends Int32 {
    static HTMLDlgEdgeSunken := 0
    static HTMLDlgEdgeRaised := 16
    static HTMLDlgEdge_Max := 2147483647
}
struct HTMLDlgCenter extends Int32 {
    static HTMLDlgCenterNo := 0
    static HTMLDlgCenterOff := 0
    static HTMLDlgCenter0 := 0
    static HTMLDlgCenterYes := 1
    static HTMLDlgCenterOn := 1
    static HTMLDlgCenter1 := 1
    static HTMLDlgCenterParent := 1
    static HTMLDlgCenterDesktop := 2
    static HTMLDlgCenter_Max := 2147483647
}
struct HTMLAppFlag extends Int32 {
    static HTMLAppFlagNo := 0
    static HTMLAppFlagOff := 0
    static HTMLAppFlag0 := 0
    static HTMLAppFlagYes := 1
    static HTMLAppFlagOn := 1
    static HTMLAppFlag1 := 1
    static HTMLAppFlag_Max := 2147483647
}
struct HTMLMinimizeFlag extends Int32 {
    static HTMLMinimizeFlagNo := 0
    static HTMLMinimizeFlagYes := 131072
    static HTMLMinimizeFlag_Max := 2147483647
}
struct HTMLMaximizeFlag extends Int32 {
    static HTMLMaximizeFlagNo := 0
    static HTMLMaximizeFlagYes := 65536
    static HTMLMaximizeFlag_Max := 2147483647
}
struct HTMLCaptionFlag extends Int32 {
    static HTMLCaptionFlagNo := 0
    static HTMLCaptionFlagYes := 12582912
    static HTMLCaptionFlag_Max := 2147483647
}
struct HTMLSysMenuFlag extends Int32 {
    static HTMLSysMenuFlagNo := 0
    static HTMLSysMenuFlagYes := 524288
    static HTMLSysMenuFlag_Max := 2147483647
}
struct HTMLBorder extends Int32 {
    static HTMLBorderNone := 0
    static HTMLBorderThick := 262144
    static HTMLBorderDialog := 4194304
    static HTMLBorderThin := 8388608
    static HTMLBorder_Max := 2147483647
}
struct HTMLBorderStyle extends Int32 {
    static HTMLBorderStyleNormal := 0
    static HTMLBorderStyleRaised := 256
    static HTMLBorderStyleSunken := 512
    static HTMLBorderStylecombined := 768
    static HTMLBorderStyleStatic := 131072
    static HTMLBorderStyle_Max := 2147483647
}
struct HTMLWindowState extends Int32 {
    static HTMLWindowStateNormal := 1
    static HTMLWindowStateMaximize := 3
    static HTMLWindowStateMinimize := 6
    static HTMLWindowState_Max := 2147483647
}
struct BEHAVIOR_EVENT extends Int32 {
    static BEHAVIOREVENT_FIRST := 0
    static BEHAVIOREVENT_CONTENTREADY := 0
    static BEHAVIOREVENT_DOCUMENTREADY := 1
    static BEHAVIOREVENT_APPLYSTYLE := 2
    static BEHAVIOREVENT_DOCUMENTCONTEXTCHANGE := 3
    static BEHAVIOREVENT_CONTENTSAVE := 4
    static BEHAVIOREVENT_LAST := 4
    static BEHAVIOR_EVENT_Max := 2147483647
}
struct BEHAVIOR_EVENT_FLAGS extends Int32 {
    static BEHAVIOREVENTFLAGS_BUBBLE := 1
    static BEHAVIOREVENTFLAGS_STANDARDADDITIVE := 2
    static BEHAVIOR_EVENT_FLAGS_Max := 2147483647
}
struct BEHAVIOR_RENDER_INFO extends Int32 {
    static BEHAVIORRENDERINFO_BEFOREBACKGROUND := 1
    static BEHAVIORRENDERINFO_AFTERBACKGROUND := 2
    static BEHAVIORRENDERINFO_BEFORECONTENT := 4
    static BEHAVIORRENDERINFO_AFTERCONTENT := 8
    static BEHAVIORRENDERINFO_AFTERFOREGROUND := 32
    static BEHAVIORRENDERINFO_ABOVECONTENT := 40
    static BEHAVIORRENDERINFO_ALLLAYERS := 255
    static BEHAVIORRENDERINFO_DISABLEBACKGROUND := 256
    static BEHAVIORRENDERINFO_DISABLENEGATIVEZ := 512
    static BEHAVIORRENDERINFO_DISABLECONTENT := 1024
    static BEHAVIORRENDERINFO_DISABLEPOSITIVEZ := 2048
    static BEHAVIORRENDERINFO_DISABLEALLLAYERS := 3840
    static BEHAVIORRENDERINFO_HITTESTING := 4096
    static BEHAVIORRENDERINFO_SURFACE := 1048576
    static BEHAVIORRENDERINFO_3DSURFACE := 2097152
    static BEHAVIOR_RENDER_INFO_Max := 2147483647
}
struct BEHAVIOR_RELATION extends Int32 {
    static BEHAVIOR_FIRSTRELATION := 0
    static BEHAVIOR_SAMEELEMENT := 0
    static BEHAVIOR_PARENT := 1
    static BEHAVIOR_CHILD := 2
    static BEHAVIOR_SIBLING := 3
    static BEHAVIOR_LASTRELATION := 3
    static BEHAVIOR_RELATION_Max := 2147483647
}
struct BEHAVIOR_LAYOUT_INFO extends Int32 {
    static BEHAVIORLAYOUTINFO_FULLDELEGATION := 1
    static BEHAVIORLAYOUTINFO_MODIFYNATURAL := 2
    static BEHAVIORLAYOUTINFO_MAPSIZE := 4
    static BEHAVIOR_LAYOUT_INFO_Max := 2147483647
}
struct BEHAVIOR_LAYOUT_MODE extends Int32 {
    static BEHAVIORLAYOUTMODE_NATURAL := 1
    static BEHAVIORLAYOUTMODE_MINWIDTH := 2
    static BEHAVIORLAYOUTMODE_MAXWIDTH := 4
    static BEHAVIORLAYOUTMODE_MEDIA_RESOLUTION := 16384
    static BEHAVIORLAYOUTMODE_FINAL_PERCENT := 32768
    static BEHAVIOR_LAYOUT_MODE_Max := 2147483647
}
struct ELEMENTDESCRIPTOR_FLAGS extends Int32 {
    static ELEMENTDESCRIPTORFLAGS_LITERAL := 1
    static ELEMENTDESCRIPTORFLAGS_NESTED_LITERAL := 2
    static ELEMENTDESCRIPTOR_FLAGS_Max := 2147483647
}
struct ELEMENTNAMESPACE_FLAGS extends Int32 {
    static ELEMENTNAMESPACEFLAGS_ALLOWANYTAG := 1
    static ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS := 2
    static ELEMENTNAMESPACE_FLAGS_Max := 2147483647
}
struct VIEW_OBJECT_ALPHA_MODE extends Int32 {
    static VIEW_OBJECT_ALPHA_MODE_IGNORE := 0
    static VIEW_OBJECT_ALPHA_MODE_PREMULTIPLIED := 1
    static VIEW_OBJECT_ALPHA_MODE_Max := 2147483647
}
struct VIEW_OBJECT_COMPOSITION_MODE extends Int32 {
    static VIEW_OBJECT_COMPOSITION_MODE_LEGACY := 0
    static VIEW_OBJECT_COMPOSITION_MODE_SURFACEPRESENTER := 1
    static VIEW_OBJECT_COMPOSITION_MODE_Max := 2147483647
}
struct IHTMLEventObj extends IDispatch {
    static IID := "{3050F32D-98B5-11CF-BB82-00AA00BDCE0B}"
    get_srcElement(p)
      => ComCall(7, this.p, IHTMLElement.Ptr, p)
    get_altKey(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_ctrlKey(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    get_shiftKey(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    put_returnValue(v)
      => ComCall(11, this.p, VARIANT, v)
    get_returnValue(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_cancelBubble(v)
      => ComCall(13, this.p, VARIANT_BOOL, v)
    get_cancelBubble(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_fromElement(p)
      => ComCall(15, this.p, IHTMLElement.Ptr, p)
    get_toElement(p)
      => ComCall(16, this.p, IHTMLElement.Ptr, p)
    put_keyCode(v)
      => ComCall(17, this.p, Int32, v)
    get_keyCode(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    get_button(p)
      => ComCall(19, this.p, Int32.Ptr, p)
    get_type(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    get_qualifier(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    get_reason(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    get_x(p)
      => ComCall(23, this.p, Int32.Ptr, p)
    get_y(p)
      => ComCall(24, this.p, Int32.Ptr, p)
    get_clientX(p)
      => ComCall(25, this.p, Int32.Ptr, p)
    get_clientY(p)
      => ComCall(26, this.p, Int32.Ptr, p)
    get_offsetX(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    get_offsetY(p)
      => ComCall(28, this.p, Int32.Ptr, p)
    get_screenX(p)
      => ComCall(29, this.p, Int32.Ptr, p)
    get_screenY(p)
      => ComCall(30, this.p, Int32.Ptr, p)
    get_srcFilter(p)
      => ComCall(31, this.p, IDispatch.Ptr, p)
}
struct IElementBehaviorSite extends IUnknown {
    static IID := "{3050F427-98B5-11CF-BB82-00AA00BDCE0B}"
    GetElement(ppElement)
      => ComCall(3, this.p, IHTMLElement.Ptr, ppElement)
    RegisterNotification(lEvent)
      => ComCall(4, this.p, Int32, lEvent)
}
struct IElementBehavior extends IUnknown {
    static IID := "{3050F425-98B5-11CF-BB82-00AA00BDCE0B}"
    Init(pBehaviorSite)
      => ComCall(3, this.p, IElementBehaviorSite, pBehaviorSite)
    Notify(lEvent, pVar)
      => ComCall(4, this.p, Int32, lEvent, VARIANT.Ptr, pVar)
    Detach()
      => ComCall(5, this.p)
}
struct IElementBehaviorFactory extends IUnknown {
    static IID := "{3050F429-98B5-11CF-BB82-00AA00BDCE0B}"
    FindBehavior(bstrBehavior, bstrBehaviorUrl, pSite, ppBehavior)
      => ComCall(3, this.p, BSTR, bstrBehavior, BSTR, bstrBehaviorUrl, IElementBehaviorSite, pSite, IElementBehavior.Ptr, ppBehavior)
}
struct IElementBehaviorSiteOM extends IUnknown {
    static IID := "{3050F489-98B5-11CF-BB82-00AA00BDCE0B}"
    RegisterEvent(pchEvent, lFlags, plCookie)
      => ComCall(3, this.p, "Str", pchEvent, Int32, lFlags, Int32.Ptr, plCookie)
    GetEventCookie(pchEvent, plCookie)
      => ComCall(4, this.p, "Str", pchEvent, Int32.Ptr, plCookie)
    FireEvent(lCookie, pEventObject)
      => ComCall(5, this.p, Int32, lCookie, IHTMLEventObj, pEventObject)
    CreateEventObject(ppEventObject)
      => ComCall(6, this.p, IHTMLEventObj.Ptr, ppEventObject)
    RegisterName(pchName)
      => ComCall(7, this.p, "Str", pchName)
    RegisterUrn(pchUrn)
      => ComCall(8, this.p, "Str", pchUrn)
}
struct IElementBehaviorRender extends IUnknown {
    static IID := "{3050F4AA-98B5-11CF-BB82-00AA00BDCE0B}"
    Draw(hdc1, lLayer, pRect, pReserved)
      => ComCall(3, this.p, HDC, hdc1, Int32, lLayer, RECT.Ptr, pRect, IUnknown, pReserved)
    GetRenderInfo(plRenderInfo)
      => ComCall(4, this.p, Int32.Ptr, plRenderInfo)
    HitTestPoint(pPoint, pReserved, pbHit)
      => ComCall(5, this.p, POINT.Ptr, pPoint, IUnknown, pReserved, BOOL.Ptr, pbHit)
}
struct IElementBehaviorSiteRender extends IUnknown {
    static IID := "{3050F4A7-98B5-11CF-BB82-00AA00BDCE0B}"
    Invalidate(pRect)
      => ComCall(3, this.p, RECT.Ptr, pRect)
    InvalidateRenderInfo()
      => ComCall(4, this.p)
    InvalidateStyle()
      => ComCall(5, this.p)
}
struct IDOMEvent extends IDispatch {
    static IID := "{305104BA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_bubbles(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    get_cancelable(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_currentTarget(p)
      => ComCall(9, this.p, IEventTarget.Ptr, p)
    get_defaultPrevented(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    get_eventPhase(p)
      => ComCall(11, this.p, UInt16.Ptr, p)
    get_target(p)
      => ComCall(12, this.p, IEventTarget.Ptr, p)
    get_timeStamp(p)
      => ComCall(13, this.p, Int64.Ptr, p)
    get_type(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    initEvent(eventType, canBubble, cancelable)
      => ComCall(15, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable)
    preventDefault()
      => ComCall(16, this.p)
    stopPropagation()
      => ComCall(17, this.p)
    stopImmediatePropagation()
      => ComCall(18, this.p)
    get_isTrusted(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
    put_cancelBubble(v)
      => ComCall(20, this.p, VARIANT_BOOL, v)
    get_cancelBubble(p)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, p)
    get_srcElement(p)
      => ComCall(22, this.p, IHTMLElement.Ptr, p)
}
struct IHTMLDOMConstructor extends IDispatch {
    static IID := "{3051049B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_constructor(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    LookupGetter(propname, ppDispHandler)
      => ComCall(8, this.p, BSTR, propname, VARIANT.Ptr, ppDispHandler)
    LookupSetter(propname, ppDispHandler)
      => ComCall(9, this.p, BSTR, propname, VARIANT.Ptr, ppDispHandler)
    DefineGetter(propname, pdispHandler)
      => ComCall(10, this.p, BSTR, propname, VARIANT.Ptr, pdispHandler)
    DefineSetter(propname, pdispHandler)
      => ComCall(11, this.p, BSTR, propname, VARIANT.Ptr, pdispHandler)
}
struct IHTMLStyleSheetRule extends IDispatch {
    static IID := "{3050F357-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectorText(v)
      => ComCall(7, this.p, BSTR, v)
    get_selectorText(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_style(p)
      => ComCall(9, this.p, IHTMLRuleStyle.Ptr, p)
    get_readOnly(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLCSSStyleDeclaration extends IDispatch {
    static IID := "{30510740-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_parentRule(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    getPropertyValue(bstrPropertyName, pbstrPropertyValue)
      => ComCall(9, this.p, BSTR, bstrPropertyName, BSTR.Ptr, pbstrPropertyValue)
    getPropertyPriority(bstrPropertyName, pbstrPropertyPriority)
      => ComCall(10, this.p, BSTR, bstrPropertyName, BSTR.Ptr, pbstrPropertyPriority)
    removeProperty(bstrPropertyName, pbstrPropertyValue)
      => ComCall(11, this.p, BSTR, bstrPropertyName, BSTR.Ptr, pbstrPropertyValue)
    setProperty(bstrPropertyName, pvarPropertyValue, pvarPropertyPriority)
      => ComCall(12, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, pvarPropertyValue, VARIANT.Ptr, pvarPropertyPriority)
    item(index, pbstrPropertyName)
      => ComCall(13, this.p, Int32, index, BSTR.Ptr, pbstrPropertyName)
    put_fontFamily(v)
      => ComCall(14, this.p, BSTR, v)
    get_fontFamily(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_fontStyle(v)
      => ComCall(16, this.p, BSTR, v)
    get_fontStyle(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_fontVariant(v)
      => ComCall(18, this.p, BSTR, v)
    get_fontVariant(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_fontWeight(v)
      => ComCall(20, this.p, BSTR, v)
    get_fontWeight(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    put_fontSize(v)
      => ComCall(22, this.p, VARIANT, v)
    get_fontSize(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_font(v)
      => ComCall(24, this.p, BSTR, v)
    get_font(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
    put_color(v)
      => ComCall(26, this.p, VARIANT, v)
    get_color(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_background(v)
      => ComCall(28, this.p, BSTR, v)
    get_background(p)
      => ComCall(29, this.p, BSTR.Ptr, p)
    put_backgroundColor(v)
      => ComCall(30, this.p, VARIANT, v)
    get_backgroundColor(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    put_backgroundImage(v)
      => ComCall(32, this.p, BSTR, v)
    get_backgroundImage(p)
      => ComCall(33, this.p, BSTR.Ptr, p)
    put_backgroundRepeat(v)
      => ComCall(34, this.p, BSTR, v)
    get_backgroundRepeat(p)
      => ComCall(35, this.p, BSTR.Ptr, p)
    put_backgroundAttachment(v)
      => ComCall(36, this.p, BSTR, v)
    get_backgroundAttachment(p)
      => ComCall(37, this.p, BSTR.Ptr, p)
    put_backgroundPosition(v)
      => ComCall(38, this.p, BSTR, v)
    get_backgroundPosition(p)
      => ComCall(39, this.p, BSTR.Ptr, p)
    put_backgroundPositionX(v)
      => ComCall(40, this.p, VARIANT, v)
    get_backgroundPositionX(p)
      => ComCall(41, this.p, VARIANT.Ptr, p)
    put_backgroundPositionY(v)
      => ComCall(42, this.p, VARIANT, v)
    get_backgroundPositionY(p)
      => ComCall(43, this.p, VARIANT.Ptr, p)
    put_wordSpacing(v)
      => ComCall(44, this.p, VARIANT, v)
    get_wordSpacing(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    put_letterSpacing(v)
      => ComCall(46, this.p, VARIANT, v)
    get_letterSpacing(p)
      => ComCall(47, this.p, VARIANT.Ptr, p)
    put_textDecoration(v)
      => ComCall(48, this.p, BSTR, v)
    get_textDecoration(p)
      => ComCall(49, this.p, BSTR.Ptr, p)
    put_verticalAlign(v)
      => ComCall(50, this.p, VARIANT, v)
    get_verticalAlign(p)
      => ComCall(51, this.p, VARIANT.Ptr, p)
    put_textTransform(v)
      => ComCall(52, this.p, BSTR, v)
    get_textTransform(p)
      => ComCall(53, this.p, BSTR.Ptr, p)
    put_textAlign(v)
      => ComCall(54, this.p, BSTR, v)
    get_textAlign(p)
      => ComCall(55, this.p, BSTR.Ptr, p)
    put_textIndent(v)
      => ComCall(56, this.p, VARIANT, v)
    get_textIndent(p)
      => ComCall(57, this.p, VARIANT.Ptr, p)
    put_lineHeight(v)
      => ComCall(58, this.p, VARIANT, v)
    get_lineHeight(p)
      => ComCall(59, this.p, VARIANT.Ptr, p)
    put_marginTop(v)
      => ComCall(60, this.p, VARIANT, v)
    get_marginTop(p)
      => ComCall(61, this.p, VARIANT.Ptr, p)
    put_marginRight(v)
      => ComCall(62, this.p, VARIANT, v)
    get_marginRight(p)
      => ComCall(63, this.p, VARIANT.Ptr, p)
    put_marginBottom(v)
      => ComCall(64, this.p, VARIANT, v)
    get_marginBottom(p)
      => ComCall(65, this.p, VARIANT.Ptr, p)
    put_marginLeft(v)
      => ComCall(66, this.p, VARIANT, v)
    get_marginLeft(p)
      => ComCall(67, this.p, VARIANT.Ptr, p)
    put_margin(v)
      => ComCall(68, this.p, BSTR, v)
    get_margin(p)
      => ComCall(69, this.p, BSTR.Ptr, p)
    put_paddingTop(v)
      => ComCall(70, this.p, VARIANT, v)
    get_paddingTop(p)
      => ComCall(71, this.p, VARIANT.Ptr, p)
    put_paddingRight(v)
      => ComCall(72, this.p, VARIANT, v)
    get_paddingRight(p)
      => ComCall(73, this.p, VARIANT.Ptr, p)
    put_paddingBottom(v)
      => ComCall(74, this.p, VARIANT, v)
    get_paddingBottom(p)
      => ComCall(75, this.p, VARIANT.Ptr, p)
    put_paddingLeft(v)
      => ComCall(76, this.p, VARIANT, v)
    get_paddingLeft(p)
      => ComCall(77, this.p, VARIANT.Ptr, p)
    put_padding(v)
      => ComCall(78, this.p, BSTR, v)
    get_padding(p)
      => ComCall(79, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(80, this.p, BSTR, v)
    get_border(p)
      => ComCall(81, this.p, BSTR.Ptr, p)
    put_borderTop(v)
      => ComCall(82, this.p, BSTR, v)
    get_borderTop(p)
      => ComCall(83, this.p, BSTR.Ptr, p)
    put_borderRight(v)
      => ComCall(84, this.p, BSTR, v)
    get_borderRight(p)
      => ComCall(85, this.p, BSTR.Ptr, p)
    put_borderBottom(v)
      => ComCall(86, this.p, BSTR, v)
    get_borderBottom(p)
      => ComCall(87, this.p, BSTR.Ptr, p)
    put_borderLeft(v)
      => ComCall(88, this.p, BSTR, v)
    get_borderLeft(p)
      => ComCall(89, this.p, BSTR.Ptr, p)
    put_borderColor(v)
      => ComCall(90, this.p, BSTR, v)
    get_borderColor(p)
      => ComCall(91, this.p, BSTR.Ptr, p)
    put_borderTopColor(v)
      => ComCall(92, this.p, VARIANT, v)
    get_borderTopColor(p)
      => ComCall(93, this.p, VARIANT.Ptr, p)
    put_borderRightColor(v)
      => ComCall(94, this.p, VARIANT, v)
    get_borderRightColor(p)
      => ComCall(95, this.p, VARIANT.Ptr, p)
    put_borderBottomColor(v)
      => ComCall(96, this.p, VARIANT, v)
    get_borderBottomColor(p)
      => ComCall(97, this.p, VARIANT.Ptr, p)
    put_borderLeftColor(v)
      => ComCall(98, this.p, VARIANT, v)
    get_borderLeftColor(p)
      => ComCall(99, this.p, VARIANT.Ptr, p)
    put_borderWidth(v)
      => ComCall(100, this.p, BSTR, v)
    get_borderWidth(p)
      => ComCall(101, this.p, BSTR.Ptr, p)
    put_borderTopWidth(v)
      => ComCall(102, this.p, VARIANT, v)
    get_borderTopWidth(p)
      => ComCall(103, this.p, VARIANT.Ptr, p)
    put_borderRightWidth(v)
      => ComCall(104, this.p, VARIANT, v)
    get_borderRightWidth(p)
      => ComCall(105, this.p, VARIANT.Ptr, p)
    put_borderBottomWidth(v)
      => ComCall(106, this.p, VARIANT, v)
    get_borderBottomWidth(p)
      => ComCall(107, this.p, VARIANT.Ptr, p)
    put_borderLeftWidth(v)
      => ComCall(108, this.p, VARIANT, v)
    get_borderLeftWidth(p)
      => ComCall(109, this.p, VARIANT.Ptr, p)
    put_borderStyle(v)
      => ComCall(110, this.p, BSTR, v)
    get_borderStyle(p)
      => ComCall(111, this.p, BSTR.Ptr, p)
    put_borderTopStyle(v)
      => ComCall(112, this.p, BSTR, v)
    get_borderTopStyle(p)
      => ComCall(113, this.p, BSTR.Ptr, p)
    put_borderRightStyle(v)
      => ComCall(114, this.p, BSTR, v)
    get_borderRightStyle(p)
      => ComCall(115, this.p, BSTR.Ptr, p)
    put_borderBottomStyle(v)
      => ComCall(116, this.p, BSTR, v)
    get_borderBottomStyle(p)
      => ComCall(117, this.p, BSTR.Ptr, p)
    put_borderLeftStyle(v)
      => ComCall(118, this.p, BSTR, v)
    get_borderLeftStyle(p)
      => ComCall(119, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(120, this.p, VARIANT, v)
    get_width(p)
      => ComCall(121, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(122, this.p, VARIANT, v)
    get_height(p)
      => ComCall(123, this.p, VARIANT.Ptr, p)
    put_styleFloat(v)
      => ComCall(124, this.p, BSTR, v)
    get_styleFloat(p)
      => ComCall(125, this.p, BSTR.Ptr, p)
    put_clear(v)
      => ComCall(126, this.p, BSTR, v)
    get_clear(p)
      => ComCall(127, this.p, BSTR.Ptr, p)
    put_display(v)
      => ComCall(128, this.p, BSTR, v)
    get_display(p)
      => ComCall(129, this.p, BSTR.Ptr, p)
    put_visibility(v)
      => ComCall(130, this.p, BSTR, v)
    get_visibility(p)
      => ComCall(131, this.p, BSTR.Ptr, p)
    put_listStyleType(v)
      => ComCall(132, this.p, BSTR, v)
    get_listStyleType(p)
      => ComCall(133, this.p, BSTR.Ptr, p)
    put_listStylePosition(v)
      => ComCall(134, this.p, BSTR, v)
    get_listStylePosition(p)
      => ComCall(135, this.p, BSTR.Ptr, p)
    put_listStyleImage(v)
      => ComCall(136, this.p, BSTR, v)
    get_listStyleImage(p)
      => ComCall(137, this.p, BSTR.Ptr, p)
    put_listStyle(v)
      => ComCall(138, this.p, BSTR, v)
    get_listStyle(p)
      => ComCall(139, this.p, BSTR.Ptr, p)
    put_whiteSpace(v)
      => ComCall(140, this.p, BSTR, v)
    get_whiteSpace(p)
      => ComCall(141, this.p, BSTR.Ptr, p)
    put_top(v)
      => ComCall(142, this.p, VARIANT, v)
    get_top(p)
      => ComCall(143, this.p, VARIANT.Ptr, p)
    put_left(v)
      => ComCall(144, this.p, VARIANT, v)
    get_left(p)
      => ComCall(145, this.p, VARIANT.Ptr, p)
    put_zIndex(v)
      => ComCall(146, this.p, VARIANT, v)
    get_zIndex(p)
      => ComCall(147, this.p, VARIANT.Ptr, p)
    put_overflow(v)
      => ComCall(148, this.p, BSTR, v)
    get_overflow(p)
      => ComCall(149, this.p, BSTR.Ptr, p)
    put_pageBreakBefore(v)
      => ComCall(150, this.p, BSTR, v)
    get_pageBreakBefore(p)
      => ComCall(151, this.p, BSTR.Ptr, p)
    put_pageBreakAfter(v)
      => ComCall(152, this.p, BSTR, v)
    get_pageBreakAfter(p)
      => ComCall(153, this.p, BSTR.Ptr, p)
    put_cssText(v)
      => ComCall(154, this.p, BSTR, v)
    get_cssText(p)
      => ComCall(155, this.p, BSTR.Ptr, p)
    put_cursor(v)
      => ComCall(156, this.p, BSTR, v)
    get_cursor(p)
      => ComCall(157, this.p, BSTR.Ptr, p)
    put_clip(v)
      => ComCall(158, this.p, BSTR, v)
    get_clip(p)
      => ComCall(159, this.p, BSTR.Ptr, p)
    put_filter(v)
      => ComCall(160, this.p, BSTR, v)
    get_filter(p)
      => ComCall(161, this.p, BSTR.Ptr, p)
    put_tableLayout(v)
      => ComCall(162, this.p, BSTR, v)
    get_tableLayout(p)
      => ComCall(163, this.p, BSTR.Ptr, p)
    put_borderCollapse(v)
      => ComCall(164, this.p, BSTR, v)
    get_borderCollapse(p)
      => ComCall(165, this.p, BSTR.Ptr, p)
    put_direction(v)
      => ComCall(166, this.p, BSTR, v)
    get_direction(p)
      => ComCall(167, this.p, BSTR.Ptr, p)
    put_behavior(v)
      => ComCall(168, this.p, BSTR, v)
    get_behavior(p)
      => ComCall(169, this.p, BSTR.Ptr, p)
    put_position(v)
      => ComCall(170, this.p, BSTR, v)
    get_position(p)
      => ComCall(171, this.p, BSTR.Ptr, p)
    put_unicodeBidi(v)
      => ComCall(172, this.p, BSTR, v)
    get_unicodeBidi(p)
      => ComCall(173, this.p, BSTR.Ptr, p)
    put_bottom(v)
      => ComCall(174, this.p, VARIANT, v)
    get_bottom(p)
      => ComCall(175, this.p, VARIANT.Ptr, p)
    put_right(v)
      => ComCall(176, this.p, VARIANT, v)
    get_right(p)
      => ComCall(177, this.p, VARIANT.Ptr, p)
    put_imeMode(v)
      => ComCall(178, this.p, BSTR, v)
    get_imeMode(p)
      => ComCall(179, this.p, BSTR.Ptr, p)
    put_rubyAlign(v)
      => ComCall(180, this.p, BSTR, v)
    get_rubyAlign(p)
      => ComCall(181, this.p, BSTR.Ptr, p)
    put_rubyPosition(v)
      => ComCall(182, this.p, BSTR, v)
    get_rubyPosition(p)
      => ComCall(183, this.p, BSTR.Ptr, p)
    put_rubyOverhang(v)
      => ComCall(184, this.p, BSTR, v)
    get_rubyOverhang(p)
      => ComCall(185, this.p, BSTR.Ptr, p)
    put_layoutGridChar(v)
      => ComCall(186, this.p, VARIANT, v)
    get_layoutGridChar(p)
      => ComCall(187, this.p, VARIANT.Ptr, p)
    put_layoutGridLine(v)
      => ComCall(188, this.p, VARIANT, v)
    get_layoutGridLine(p)
      => ComCall(189, this.p, VARIANT.Ptr, p)
    put_layoutGridMode(v)
      => ComCall(190, this.p, BSTR, v)
    get_layoutGridMode(p)
      => ComCall(191, this.p, BSTR.Ptr, p)
    put_layoutGridType(v)
      => ComCall(192, this.p, BSTR, v)
    get_layoutGridType(p)
      => ComCall(193, this.p, BSTR.Ptr, p)
    put_layoutGrid(v)
      => ComCall(194, this.p, BSTR, v)
    get_layoutGrid(p)
      => ComCall(195, this.p, BSTR.Ptr, p)
    put_textAutospace(v)
      => ComCall(196, this.p, BSTR, v)
    get_textAutospace(p)
      => ComCall(197, this.p, BSTR.Ptr, p)
    put_wordBreak(v)
      => ComCall(198, this.p, BSTR, v)
    get_wordBreak(p)
      => ComCall(199, this.p, BSTR.Ptr, p)
    put_lineBreak(v)
      => ComCall(200, this.p, BSTR, v)
    get_lineBreak(p)
      => ComCall(201, this.p, BSTR.Ptr, p)
    put_textJustify(v)
      => ComCall(202, this.p, BSTR, v)
    get_textJustify(p)
      => ComCall(203, this.p, BSTR.Ptr, p)
    put_textJustifyTrim(v)
      => ComCall(204, this.p, BSTR, v)
    get_textJustifyTrim(p)
      => ComCall(205, this.p, BSTR.Ptr, p)
    put_textKashida(v)
      => ComCall(206, this.p, VARIANT, v)
    get_textKashida(p)
      => ComCall(207, this.p, VARIANT.Ptr, p)
    put_overflowX(v)
      => ComCall(208, this.p, BSTR, v)
    get_overflowX(p)
      => ComCall(209, this.p, BSTR.Ptr, p)
    put_overflowY(v)
      => ComCall(210, this.p, BSTR, v)
    get_overflowY(p)
      => ComCall(211, this.p, BSTR.Ptr, p)
    put_accelerator(v)
      => ComCall(212, this.p, BSTR, v)
    get_accelerator(p)
      => ComCall(213, this.p, BSTR.Ptr, p)
    put_layoutFlow(v)
      => ComCall(214, this.p, BSTR, v)
    get_layoutFlow(p)
      => ComCall(215, this.p, BSTR.Ptr, p)
    put_zoom(v)
      => ComCall(216, this.p, VARIANT, v)
    get_zoom(p)
      => ComCall(217, this.p, VARIANT.Ptr, p)
    put_wordWrap(v)
      => ComCall(218, this.p, BSTR, v)
    get_wordWrap(p)
      => ComCall(219, this.p, BSTR.Ptr, p)
    put_textUnderlinePosition(v)
      => ComCall(220, this.p, BSTR, v)
    get_textUnderlinePosition(p)
      => ComCall(221, this.p, BSTR.Ptr, p)
    put_scrollbarBaseColor(v)
      => ComCall(222, this.p, VARIANT, v)
    get_scrollbarBaseColor(p)
      => ComCall(223, this.p, VARIANT.Ptr, p)
    put_scrollbarFaceColor(v)
      => ComCall(224, this.p, VARIANT, v)
    get_scrollbarFaceColor(p)
      => ComCall(225, this.p, VARIANT.Ptr, p)
    put_scrollbar3dLightColor(v)
      => ComCall(226, this.p, VARIANT, v)
    get_scrollbar3dLightColor(p)
      => ComCall(227, this.p, VARIANT.Ptr, p)
    put_scrollbarShadowColor(v)
      => ComCall(228, this.p, VARIANT, v)
    get_scrollbarShadowColor(p)
      => ComCall(229, this.p, VARIANT.Ptr, p)
    put_scrollbarHighlightColor(v)
      => ComCall(230, this.p, VARIANT, v)
    get_scrollbarHighlightColor(p)
      => ComCall(231, this.p, VARIANT.Ptr, p)
    put_scrollbarDarkShadowColor(v)
      => ComCall(232, this.p, VARIANT, v)
    get_scrollbarDarkShadowColor(p)
      => ComCall(233, this.p, VARIANT.Ptr, p)
    put_scrollbarArrowColor(v)
      => ComCall(234, this.p, VARIANT, v)
    get_scrollbarArrowColor(p)
      => ComCall(235, this.p, VARIANT.Ptr, p)
    put_scrollbarTrackColor(v)
      => ComCall(236, this.p, VARIANT, v)
    get_scrollbarTrackColor(p)
      => ComCall(237, this.p, VARIANT.Ptr, p)
    put_writingMode(v)
      => ComCall(238, this.p, BSTR, v)
    get_writingMode(p)
      => ComCall(239, this.p, BSTR.Ptr, p)
    put_textAlignLast(v)
      => ComCall(240, this.p, BSTR, v)
    get_textAlignLast(p)
      => ComCall(241, this.p, BSTR.Ptr, p)
    put_textKashidaSpace(v)
      => ComCall(242, this.p, VARIANT, v)
    get_textKashidaSpace(p)
      => ComCall(243, this.p, VARIANT.Ptr, p)
    put_textOverflow(v)
      => ComCall(244, this.p, BSTR, v)
    get_textOverflow(p)
      => ComCall(245, this.p, BSTR.Ptr, p)
    put_minHeight(v)
      => ComCall(246, this.p, VARIANT, v)
    get_minHeight(p)
      => ComCall(247, this.p, VARIANT.Ptr, p)
    put_msInterpolationMode(v)
      => ComCall(248, this.p, BSTR, v)
    get_msInterpolationMode(p)
      => ComCall(249, this.p, BSTR.Ptr, p)
    put_maxHeight(v)
      => ComCall(250, this.p, VARIANT, v)
    get_maxHeight(p)
      => ComCall(251, this.p, VARIANT.Ptr, p)
    put_minWidth(v)
      => ComCall(252, this.p, VARIANT, v)
    get_minWidth(p)
      => ComCall(253, this.p, VARIANT.Ptr, p)
    put_maxWidth(v)
      => ComCall(254, this.p, VARIANT, v)
    get_maxWidth(p)
      => ComCall(255, this.p, VARIANT.Ptr, p)
    put_content(v)
      => ComCall(256, this.p, BSTR, v)
    get_content(p)
      => ComCall(257, this.p, BSTR.Ptr, p)
    put_captionSide(v)
      => ComCall(258, this.p, BSTR, v)
    get_captionSide(p)
      => ComCall(259, this.p, BSTR.Ptr, p)
    put_counterIncrement(v)
      => ComCall(260, this.p, BSTR, v)
    get_counterIncrement(p)
      => ComCall(261, this.p, BSTR.Ptr, p)
    put_counterReset(v)
      => ComCall(262, this.p, BSTR, v)
    get_counterReset(p)
      => ComCall(263, this.p, BSTR.Ptr, p)
    put_outline(v)
      => ComCall(264, this.p, BSTR, v)
    get_outline(p)
      => ComCall(265, this.p, BSTR.Ptr, p)
    put_outlineWidth(v)
      => ComCall(266, this.p, VARIANT, v)
    get_outlineWidth(p)
      => ComCall(267, this.p, VARIANT.Ptr, p)
    put_outlineStyle(v)
      => ComCall(268, this.p, BSTR, v)
    get_outlineStyle(p)
      => ComCall(269, this.p, BSTR.Ptr, p)
    put_outlineColor(v)
      => ComCall(270, this.p, VARIANT, v)
    get_outlineColor(p)
      => ComCall(271, this.p, VARIANT.Ptr, p)
    put_boxSizing(v)
      => ComCall(272, this.p, BSTR, v)
    get_boxSizing(p)
      => ComCall(273, this.p, BSTR.Ptr, p)
    put_borderSpacing(v)
      => ComCall(274, this.p, BSTR, v)
    get_borderSpacing(p)
      => ComCall(275, this.p, BSTR.Ptr, p)
    put_orphans(v)
      => ComCall(276, this.p, VARIANT, v)
    get_orphans(p)
      => ComCall(277, this.p, VARIANT.Ptr, p)
    put_widows(v)
      => ComCall(278, this.p, VARIANT, v)
    get_widows(p)
      => ComCall(279, this.p, VARIANT.Ptr, p)
    put_pageBreakInside(v)
      => ComCall(280, this.p, BSTR, v)
    get_pageBreakInside(p)
      => ComCall(281, this.p, BSTR.Ptr, p)
    put_emptyCells(v)
      => ComCall(282, this.p, BSTR, v)
    get_emptyCells(p)
      => ComCall(283, this.p, BSTR.Ptr, p)
    put_msBlockProgression(v)
      => ComCall(284, this.p, BSTR, v)
    get_msBlockProgression(p)
      => ComCall(285, this.p, BSTR.Ptr, p)
    put_quotes(v)
      => ComCall(286, this.p, BSTR, v)
    get_quotes(p)
      => ComCall(287, this.p, BSTR.Ptr, p)
    put_alignmentBaseline(v)
      => ComCall(288, this.p, BSTR, v)
    get_alignmentBaseline(p)
      => ComCall(289, this.p, BSTR.Ptr, p)
    put_baselineShift(v)
      => ComCall(290, this.p, VARIANT, v)
    get_baselineShift(p)
      => ComCall(291, this.p, VARIANT.Ptr, p)
    put_dominantBaseline(v)
      => ComCall(292, this.p, BSTR, v)
    get_dominantBaseline(p)
      => ComCall(293, this.p, BSTR.Ptr, p)
    put_fontSizeAdjust(v)
      => ComCall(294, this.p, VARIANT, v)
    get_fontSizeAdjust(p)
      => ComCall(295, this.p, VARIANT.Ptr, p)
    put_fontStretch(v)
      => ComCall(296, this.p, BSTR, v)
    get_fontStretch(p)
      => ComCall(297, this.p, BSTR.Ptr, p)
    put_opacity(v)
      => ComCall(298, this.p, VARIANT, v)
    get_opacity(p)
      => ComCall(299, this.p, VARIANT.Ptr, p)
    put_clipPath(v)
      => ComCall(300, this.p, BSTR, v)
    get_clipPath(p)
      => ComCall(301, this.p, BSTR.Ptr, p)
    put_clipRule(v)
      => ComCall(302, this.p, BSTR, v)
    get_clipRule(p)
      => ComCall(303, this.p, BSTR.Ptr, p)
    put_fill(v)
      => ComCall(304, this.p, BSTR, v)
    get_fill(p)
      => ComCall(305, this.p, BSTR.Ptr, p)
    put_fillOpacity(v)
      => ComCall(306, this.p, VARIANT, v)
    get_fillOpacity(p)
      => ComCall(307, this.p, VARIANT.Ptr, p)
    put_fillRule(v)
      => ComCall(308, this.p, BSTR, v)
    get_fillRule(p)
      => ComCall(309, this.p, BSTR.Ptr, p)
    put_kerning(v)
      => ComCall(310, this.p, VARIANT, v)
    get_kerning(p)
      => ComCall(311, this.p, VARIANT.Ptr, p)
    put_marker(v)
      => ComCall(312, this.p, BSTR, v)
    get_marker(p)
      => ComCall(313, this.p, BSTR.Ptr, p)
    put_markerEnd(v)
      => ComCall(314, this.p, BSTR, v)
    get_markerEnd(p)
      => ComCall(315, this.p, BSTR.Ptr, p)
    put_markerMid(v)
      => ComCall(316, this.p, BSTR, v)
    get_markerMid(p)
      => ComCall(317, this.p, BSTR.Ptr, p)
    put_markerStart(v)
      => ComCall(318, this.p, BSTR, v)
    get_markerStart(p)
      => ComCall(319, this.p, BSTR.Ptr, p)
    put_mask(v)
      => ComCall(320, this.p, BSTR, v)
    get_mask(p)
      => ComCall(321, this.p, BSTR.Ptr, p)
    put_pointerEvents(v)
      => ComCall(322, this.p, BSTR, v)
    get_pointerEvents(p)
      => ComCall(323, this.p, BSTR.Ptr, p)
    put_stopColor(v)
      => ComCall(324, this.p, VARIANT, v)
    get_stopColor(p)
      => ComCall(325, this.p, VARIANT.Ptr, p)
    put_stopOpacity(v)
      => ComCall(326, this.p, VARIANT, v)
    get_stopOpacity(p)
      => ComCall(327, this.p, VARIANT.Ptr, p)
    put_stroke(v)
      => ComCall(328, this.p, BSTR, v)
    get_stroke(p)
      => ComCall(329, this.p, BSTR.Ptr, p)
    put_strokeDasharray(v)
      => ComCall(330, this.p, BSTR, v)
    get_strokeDasharray(p)
      => ComCall(331, this.p, BSTR.Ptr, p)
    put_strokeDashoffset(v)
      => ComCall(332, this.p, VARIANT, v)
    get_strokeDashoffset(p)
      => ComCall(333, this.p, VARIANT.Ptr, p)
    put_strokeLinecap(v)
      => ComCall(334, this.p, BSTR, v)
    get_strokeLinecap(p)
      => ComCall(335, this.p, BSTR.Ptr, p)
    put_strokeLinejoin(v)
      => ComCall(336, this.p, BSTR, v)
    get_strokeLinejoin(p)
      => ComCall(337, this.p, BSTR.Ptr, p)
    put_strokeMiterlimit(v)
      => ComCall(338, this.p, VARIANT, v)
    get_strokeMiterlimit(p)
      => ComCall(339, this.p, VARIANT.Ptr, p)
    put_strokeOpacity(v)
      => ComCall(340, this.p, VARIANT, v)
    get_strokeOpacity(p)
      => ComCall(341, this.p, VARIANT.Ptr, p)
    put_strokeWidth(v)
      => ComCall(342, this.p, VARIANT, v)
    get_strokeWidth(p)
      => ComCall(343, this.p, VARIANT.Ptr, p)
    put_textAnchor(v)
      => ComCall(344, this.p, BSTR, v)
    get_textAnchor(p)
      => ComCall(345, this.p, BSTR.Ptr, p)
    put_glyphOrientationHorizontal(v)
      => ComCall(346, this.p, VARIANT, v)
    get_glyphOrientationHorizontal(p)
      => ComCall(347, this.p, VARIANT.Ptr, p)
    put_glyphOrientationVertical(v)
      => ComCall(348, this.p, VARIANT, v)
    get_glyphOrientationVertical(p)
      => ComCall(349, this.p, VARIANT.Ptr, p)
    put_borderRadius(v)
      => ComCall(350, this.p, BSTR, v)
    get_borderRadius(p)
      => ComCall(351, this.p, BSTR.Ptr, p)
    put_borderTopLeftRadius(v)
      => ComCall(352, this.p, BSTR, v)
    get_borderTopLeftRadius(p)
      => ComCall(353, this.p, BSTR.Ptr, p)
    put_borderTopRightRadius(v)
      => ComCall(354, this.p, BSTR, v)
    get_borderTopRightRadius(p)
      => ComCall(355, this.p, BSTR.Ptr, p)
    put_borderBottomRightRadius(v)
      => ComCall(356, this.p, BSTR, v)
    get_borderBottomRightRadius(p)
      => ComCall(357, this.p, BSTR.Ptr, p)
    put_borderBottomLeftRadius(v)
      => ComCall(358, this.p, BSTR, v)
    get_borderBottomLeftRadius(p)
      => ComCall(359, this.p, BSTR.Ptr, p)
    put_clipTop(v)
      => ComCall(360, this.p, VARIANT, v)
    get_clipTop(p)
      => ComCall(361, this.p, VARIANT.Ptr, p)
    put_clipRight(v)
      => ComCall(362, this.p, VARIANT, v)
    get_clipRight(p)
      => ComCall(363, this.p, VARIANT.Ptr, p)
    get_clipBottom(p)
      => ComCall(364, this.p, VARIANT.Ptr, p)
    put_clipLeft(v)
      => ComCall(365, this.p, VARIANT, v)
    get_clipLeft(p)
      => ComCall(366, this.p, VARIANT.Ptr, p)
    put_cssFloat(v)
      => ComCall(367, this.p, BSTR, v)
    get_cssFloat(p)
      => ComCall(368, this.p, BSTR.Ptr, p)
    put_backgroundClip(v)
      => ComCall(369, this.p, BSTR, v)
    get_backgroundClip(p)
      => ComCall(370, this.p, BSTR.Ptr, p)
    put_backgroundOrigin(v)
      => ComCall(371, this.p, BSTR, v)
    get_backgroundOrigin(p)
      => ComCall(372, this.p, BSTR.Ptr, p)
    put_backgroundSize(v)
      => ComCall(373, this.p, BSTR, v)
    get_backgroundSize(p)
      => ComCall(374, this.p, BSTR.Ptr, p)
    put_boxShadow(v)
      => ComCall(375, this.p, BSTR, v)
    get_boxShadow(p)
      => ComCall(376, this.p, BSTR.Ptr, p)
    put_msTransform(v)
      => ComCall(377, this.p, BSTR, v)
    get_msTransform(p)
      => ComCall(378, this.p, BSTR.Ptr, p)
    put_msTransformOrigin(v)
      => ComCall(379, this.p, BSTR, v)
    get_msTransformOrigin(p)
      => ComCall(380, this.p, BSTR.Ptr, p)
}
struct IHTMLCSSStyleDeclaration2 extends IDispatch {
    static IID := "{305107D1-98B5-11CF-BB82-00AA00BDCE0B}"
    put_msScrollChaining(v)
      => ComCall(7, this.p, BSTR, v)
    get_msScrollChaining(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_msContentZooming(v)
      => ComCall(9, this.p, BSTR, v)
    get_msContentZooming(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_msContentZoomSnapType(v)
      => ComCall(11, this.p, BSTR, v)
    get_msContentZoomSnapType(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_msScrollRails(v)
      => ComCall(13, this.p, BSTR, v)
    get_msScrollRails(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_msContentZoomChaining(v)
      => ComCall(15, this.p, BSTR, v)
    get_msContentZoomChaining(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_msScrollSnapType(v)
      => ComCall(17, this.p, BSTR, v)
    get_msScrollSnapType(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_msContentZoomLimit(v)
      => ComCall(19, this.p, BSTR, v)
    get_msContentZoomLimit(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_msContentZoomSnap(v)
      => ComCall(21, this.p, BSTR, v)
    get_msContentZoomSnap(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_msContentZoomSnapPoints(v)
      => ComCall(23, this.p, BSTR, v)
    get_msContentZoomSnapPoints(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_msContentZoomLimitMin(v)
      => ComCall(25, this.p, VARIANT, v)
    get_msContentZoomLimitMin(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_msContentZoomLimitMax(v)
      => ComCall(27, this.p, VARIANT, v)
    get_msContentZoomLimitMax(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_msScrollSnapX(v)
      => ComCall(29, this.p, BSTR, v)
    get_msScrollSnapX(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_msScrollSnapY(v)
      => ComCall(31, this.p, BSTR, v)
    get_msScrollSnapY(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_msScrollSnapPointsX(v)
      => ComCall(33, this.p, BSTR, v)
    get_msScrollSnapPointsX(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_msScrollSnapPointsY(v)
      => ComCall(35, this.p, BSTR, v)
    get_msScrollSnapPointsY(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_msGridColumn(v)
      => ComCall(37, this.p, VARIANT, v)
    get_msGridColumn(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_msGridColumnAlign(v)
      => ComCall(39, this.p, BSTR, v)
    get_msGridColumnAlign(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    put_msGridColumns(v)
      => ComCall(41, this.p, BSTR, v)
    get_msGridColumns(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_msGridColumnSpan(v)
      => ComCall(43, this.p, VARIANT, v)
    get_msGridColumnSpan(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    put_msGridRow(v)
      => ComCall(45, this.p, VARIANT, v)
    get_msGridRow(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    put_msGridRowAlign(v)
      => ComCall(47, this.p, BSTR, v)
    get_msGridRowAlign(p)
      => ComCall(48, this.p, BSTR.Ptr, p)
    put_msGridRows(v)
      => ComCall(49, this.p, BSTR, v)
    get_msGridRows(p)
      => ComCall(50, this.p, BSTR.Ptr, p)
    put_msGridRowSpan(v)
      => ComCall(51, this.p, VARIANT, v)
    get_msGridRowSpan(p)
      => ComCall(52, this.p, VARIANT.Ptr, p)
    put_msWrapThrough(v)
      => ComCall(53, this.p, BSTR, v)
    get_msWrapThrough(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    put_msWrapMargin(v)
      => ComCall(55, this.p, VARIANT, v)
    get_msWrapMargin(p)
      => ComCall(56, this.p, VARIANT.Ptr, p)
    put_msWrapFlow(v)
      => ComCall(57, this.p, BSTR, v)
    get_msWrapFlow(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_msAnimationName(v)
      => ComCall(59, this.p, BSTR, v)
    get_msAnimationName(p)
      => ComCall(60, this.p, BSTR.Ptr, p)
    put_msAnimationDuration(v)
      => ComCall(61, this.p, BSTR, v)
    get_msAnimationDuration(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    put_msAnimationTimingFunction(v)
      => ComCall(63, this.p, BSTR, v)
    get_msAnimationTimingFunction(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    put_msAnimationDelay(v)
      => ComCall(65, this.p, BSTR, v)
    get_msAnimationDelay(p)
      => ComCall(66, this.p, BSTR.Ptr, p)
    put_msAnimationDirection(v)
      => ComCall(67, this.p, BSTR, v)
    get_msAnimationDirection(p)
      => ComCall(68, this.p, BSTR.Ptr, p)
    put_msAnimationPlayState(v)
      => ComCall(69, this.p, BSTR, v)
    get_msAnimationPlayState(p)
      => ComCall(70, this.p, BSTR.Ptr, p)
    put_msAnimationIterationCount(v)
      => ComCall(71, this.p, BSTR, v)
    get_msAnimationIterationCount(p)
      => ComCall(72, this.p, BSTR.Ptr, p)
    put_msAnimation(v)
      => ComCall(73, this.p, BSTR, v)
    get_msAnimation(p)
      => ComCall(74, this.p, BSTR.Ptr, p)
    put_msAnimationFillMode(v)
      => ComCall(75, this.p, BSTR, v)
    get_msAnimationFillMode(p)
      => ComCall(76, this.p, BSTR.Ptr, p)
    put_colorInterpolationFilters(v)
      => ComCall(77, this.p, BSTR, v)
    get_colorInterpolationFilters(p)
      => ComCall(78, this.p, BSTR.Ptr, p)
    put_columnCount(v)
      => ComCall(79, this.p, VARIANT, v)
    get_columnCount(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_columnWidth(v)
      => ComCall(81, this.p, VARIANT, v)
    get_columnWidth(p)
      => ComCall(82, this.p, VARIANT.Ptr, p)
    put_columnGap(v)
      => ComCall(83, this.p, VARIANT, v)
    get_columnGap(p)
      => ComCall(84, this.p, VARIANT.Ptr, p)
    put_columnFill(v)
      => ComCall(85, this.p, BSTR, v)
    get_columnFill(p)
      => ComCall(86, this.p, BSTR.Ptr, p)
    put_columnSpan(v)
      => ComCall(87, this.p, BSTR, v)
    get_columnSpan(p)
      => ComCall(88, this.p, BSTR.Ptr, p)
    put_columns(v)
      => ComCall(89, this.p, BSTR, v)
    get_columns(p)
      => ComCall(90, this.p, BSTR.Ptr, p)
    put_columnRule(v)
      => ComCall(91, this.p, BSTR, v)
    get_columnRule(p)
      => ComCall(92, this.p, BSTR.Ptr, p)
    put_columnRuleColor(v)
      => ComCall(93, this.p, VARIANT, v)
    get_columnRuleColor(p)
      => ComCall(94, this.p, VARIANT.Ptr, p)
    put_columnRuleStyle(v)
      => ComCall(95, this.p, BSTR, v)
    get_columnRuleStyle(p)
      => ComCall(96, this.p, BSTR.Ptr, p)
    put_columnRuleWidth(v)
      => ComCall(97, this.p, VARIANT, v)
    get_columnRuleWidth(p)
      => ComCall(98, this.p, VARIANT.Ptr, p)
    put_breakBefore(v)
      => ComCall(99, this.p, BSTR, v)
    get_breakBefore(p)
      => ComCall(100, this.p, BSTR.Ptr, p)
    put_breakAfter(v)
      => ComCall(101, this.p, BSTR, v)
    get_breakAfter(p)
      => ComCall(102, this.p, BSTR.Ptr, p)
    put_breakInside(v)
      => ComCall(103, this.p, BSTR, v)
    get_breakInside(p)
      => ComCall(104, this.p, BSTR.Ptr, p)
    put_floodColor(v)
      => ComCall(105, this.p, VARIANT, v)
    get_floodColor(p)
      => ComCall(106, this.p, VARIANT.Ptr, p)
    put_floodOpacity(v)
      => ComCall(107, this.p, VARIANT, v)
    get_floodOpacity(p)
      => ComCall(108, this.p, VARIANT.Ptr, p)
    put_lightingColor(v)
      => ComCall(109, this.p, VARIANT, v)
    get_lightingColor(p)
      => ComCall(110, this.p, VARIANT.Ptr, p)
    put_msScrollLimitXMin(v)
      => ComCall(111, this.p, VARIANT, v)
    get_msScrollLimitXMin(p)
      => ComCall(112, this.p, VARIANT.Ptr, p)
    put_msScrollLimitYMin(v)
      => ComCall(113, this.p, VARIANT, v)
    get_msScrollLimitYMin(p)
      => ComCall(114, this.p, VARIANT.Ptr, p)
    put_msScrollLimitXMax(v)
      => ComCall(115, this.p, VARIANT, v)
    get_msScrollLimitXMax(p)
      => ComCall(116, this.p, VARIANT.Ptr, p)
    put_msScrollLimitYMax(v)
      => ComCall(117, this.p, VARIANT, v)
    get_msScrollLimitYMax(p)
      => ComCall(118, this.p, VARIANT.Ptr, p)
    put_msScrollLimit(v)
      => ComCall(119, this.p, BSTR, v)
    get_msScrollLimit(p)
      => ComCall(120, this.p, BSTR.Ptr, p)
    put_textShadow(v)
      => ComCall(121, this.p, BSTR, v)
    get_textShadow(p)
      => ComCall(122, this.p, BSTR.Ptr, p)
    put_msFlowFrom(v)
      => ComCall(123, this.p, BSTR, v)
    get_msFlowFrom(p)
      => ComCall(124, this.p, BSTR.Ptr, p)
    put_msFlowInto(v)
      => ComCall(125, this.p, BSTR, v)
    get_msFlowInto(p)
      => ComCall(126, this.p, BSTR.Ptr, p)
    put_msHyphens(v)
      => ComCall(127, this.p, BSTR, v)
    get_msHyphens(p)
      => ComCall(128, this.p, BSTR.Ptr, p)
    put_msHyphenateLimitZone(v)
      => ComCall(129, this.p, VARIANT, v)
    get_msHyphenateLimitZone(p)
      => ComCall(130, this.p, VARIANT.Ptr, p)
    put_msHyphenateLimitChars(v)
      => ComCall(131, this.p, BSTR, v)
    get_msHyphenateLimitChars(p)
      => ComCall(132, this.p, BSTR.Ptr, p)
    put_msHyphenateLimitLines(v)
      => ComCall(133, this.p, VARIANT, v)
    get_msHyphenateLimitLines(p)
      => ComCall(134, this.p, VARIANT.Ptr, p)
    put_msHighContrastAdjust(v)
      => ComCall(135, this.p, BSTR, v)
    get_msHighContrastAdjust(p)
      => ComCall(136, this.p, BSTR.Ptr, p)
    put_enableBackground(v)
      => ComCall(137, this.p, BSTR, v)
    get_enableBackground(p)
      => ComCall(138, this.p, BSTR.Ptr, p)
    put_msFontFeatureSettings(v)
      => ComCall(139, this.p, BSTR, v)
    get_msFontFeatureSettings(p)
      => ComCall(140, this.p, BSTR.Ptr, p)
    put_msUserSelect(v)
      => ComCall(141, this.p, BSTR, v)
    get_msUserSelect(p)
      => ComCall(142, this.p, BSTR.Ptr, p)
    put_msOverflowStyle(v)
      => ComCall(143, this.p, BSTR, v)
    get_msOverflowStyle(p)
      => ComCall(144, this.p, BSTR.Ptr, p)
    put_msTransformStyle(v)
      => ComCall(145, this.p, BSTR, v)
    get_msTransformStyle(p)
      => ComCall(146, this.p, BSTR.Ptr, p)
    put_msBackfaceVisibility(v)
      => ComCall(147, this.p, BSTR, v)
    get_msBackfaceVisibility(p)
      => ComCall(148, this.p, BSTR.Ptr, p)
    put_msPerspective(v)
      => ComCall(149, this.p, VARIANT, v)
    get_msPerspective(p)
      => ComCall(150, this.p, VARIANT.Ptr, p)
    put_msPerspectiveOrigin(v)
      => ComCall(151, this.p, BSTR, v)
    get_msPerspectiveOrigin(p)
      => ComCall(152, this.p, BSTR.Ptr, p)
    put_msTransitionProperty(v)
      => ComCall(153, this.p, BSTR, v)
    get_msTransitionProperty(p)
      => ComCall(154, this.p, BSTR.Ptr, p)
    put_msTransitionDuration(v)
      => ComCall(155, this.p, BSTR, v)
    get_msTransitionDuration(p)
      => ComCall(156, this.p, BSTR.Ptr, p)
    put_msTransitionTimingFunction(v)
      => ComCall(157, this.p, BSTR, v)
    get_msTransitionTimingFunction(p)
      => ComCall(158, this.p, BSTR.Ptr, p)
    put_msTransitionDelay(v)
      => ComCall(159, this.p, BSTR, v)
    get_msTransitionDelay(p)
      => ComCall(160, this.p, BSTR.Ptr, p)
    put_msTransition(v)
      => ComCall(161, this.p, BSTR, v)
    get_msTransition(p)
      => ComCall(162, this.p, BSTR.Ptr, p)
    put_msTouchAction(v)
      => ComCall(163, this.p, BSTR, v)
    get_msTouchAction(p)
      => ComCall(164, this.p, BSTR.Ptr, p)
    put_msScrollTranslation(v)
      => ComCall(165, this.p, BSTR, v)
    get_msScrollTranslation(p)
      => ComCall(166, this.p, BSTR.Ptr, p)
    put_msFlex(v)
      => ComCall(167, this.p, BSTR, v)
    get_msFlex(p)
      => ComCall(168, this.p, BSTR.Ptr, p)
    put_msFlexPositive(v)
      => ComCall(169, this.p, VARIANT, v)
    get_msFlexPositive(p)
      => ComCall(170, this.p, VARIANT.Ptr, p)
    put_msFlexNegative(v)
      => ComCall(171, this.p, VARIANT, v)
    get_msFlexNegative(p)
      => ComCall(172, this.p, VARIANT.Ptr, p)
    put_msFlexPreferredSize(v)
      => ComCall(173, this.p, VARIANT, v)
    get_msFlexPreferredSize(p)
      => ComCall(174, this.p, VARIANT.Ptr, p)
    put_msFlexFlow(v)
      => ComCall(175, this.p, BSTR, v)
    get_msFlexFlow(p)
      => ComCall(176, this.p, BSTR.Ptr, p)
    put_msFlexDirection(v)
      => ComCall(177, this.p, BSTR, v)
    get_msFlexDirection(p)
      => ComCall(178, this.p, BSTR.Ptr, p)
    put_msFlexWrap(v)
      => ComCall(179, this.p, BSTR, v)
    get_msFlexWrap(p)
      => ComCall(180, this.p, BSTR.Ptr, p)
    put_msFlexAlign(v)
      => ComCall(181, this.p, BSTR, v)
    get_msFlexAlign(p)
      => ComCall(182, this.p, BSTR.Ptr, p)
    put_msFlexItemAlign(v)
      => ComCall(183, this.p, BSTR, v)
    get_msFlexItemAlign(p)
      => ComCall(184, this.p, BSTR.Ptr, p)
    put_msFlexPack(v)
      => ComCall(185, this.p, BSTR, v)
    get_msFlexPack(p)
      => ComCall(186, this.p, BSTR.Ptr, p)
    put_msFlexLinePack(v)
      => ComCall(187, this.p, BSTR, v)
    get_msFlexLinePack(p)
      => ComCall(188, this.p, BSTR.Ptr, p)
    put_msFlexOrder(v)
      => ComCall(189, this.p, VARIANT, v)
    get_msFlexOrder(p)
      => ComCall(190, this.p, VARIANT.Ptr, p)
    put_msTouchSelect(v)
      => ComCall(191, this.p, BSTR, v)
    get_msTouchSelect(p)
      => ComCall(192, this.p, BSTR.Ptr, p)
    put_transform(v)
      => ComCall(193, this.p, BSTR, v)
    get_transform(p)
      => ComCall(194, this.p, BSTR.Ptr, p)
    put_transformOrigin(v)
      => ComCall(195, this.p, BSTR, v)
    get_transformOrigin(p)
      => ComCall(196, this.p, BSTR.Ptr, p)
    put_transformStyle(v)
      => ComCall(197, this.p, BSTR, v)
    get_transformStyle(p)
      => ComCall(198, this.p, BSTR.Ptr, p)
    put_backfaceVisibility(v)
      => ComCall(199, this.p, BSTR, v)
    get_backfaceVisibility(p)
      => ComCall(200, this.p, BSTR.Ptr, p)
    put_perspective(v)
      => ComCall(201, this.p, VARIANT, v)
    get_perspective(p)
      => ComCall(202, this.p, VARIANT.Ptr, p)
    put_perspectiveOrigin(v)
      => ComCall(203, this.p, BSTR, v)
    get_perspectiveOrigin(p)
      => ComCall(204, this.p, BSTR.Ptr, p)
    put_transitionProperty(v)
      => ComCall(205, this.p, BSTR, v)
    get_transitionProperty(p)
      => ComCall(206, this.p, BSTR.Ptr, p)
    put_transitionDuration(v)
      => ComCall(207, this.p, BSTR, v)
    get_transitionDuration(p)
      => ComCall(208, this.p, BSTR.Ptr, p)
    put_transitionTimingFunction(v)
      => ComCall(209, this.p, BSTR, v)
    get_transitionTimingFunction(p)
      => ComCall(210, this.p, BSTR.Ptr, p)
    put_transitionDelay(v)
      => ComCall(211, this.p, BSTR, v)
    get_transitionDelay(p)
      => ComCall(212, this.p, BSTR.Ptr, p)
    put_transition(v)
      => ComCall(213, this.p, BSTR, v)
    get_transition(p)
      => ComCall(214, this.p, BSTR.Ptr, p)
    put_fontFeatureSettings(v)
      => ComCall(215, this.p, BSTR, v)
    get_fontFeatureSettings(p)
      => ComCall(216, this.p, BSTR.Ptr, p)
    put_animationName(v)
      => ComCall(217, this.p, BSTR, v)
    get_animationName(p)
      => ComCall(218, this.p, BSTR.Ptr, p)
    put_animationDuration(v)
      => ComCall(219, this.p, BSTR, v)
    get_animationDuration(p)
      => ComCall(220, this.p, BSTR.Ptr, p)
    put_animationTimingFunction(v)
      => ComCall(221, this.p, BSTR, v)
    get_animationTimingFunction(p)
      => ComCall(222, this.p, BSTR.Ptr, p)
    put_animationDelay(v)
      => ComCall(223, this.p, BSTR, v)
    get_animationDelay(p)
      => ComCall(224, this.p, BSTR.Ptr, p)
    put_animationDirection(v)
      => ComCall(225, this.p, BSTR, v)
    get_animationDirection(p)
      => ComCall(226, this.p, BSTR.Ptr, p)
    put_animationPlayState(v)
      => ComCall(227, this.p, BSTR, v)
    get_animationPlayState(p)
      => ComCall(228, this.p, BSTR.Ptr, p)
    put_animationIterationCount(v)
      => ComCall(229, this.p, BSTR, v)
    get_animationIterationCount(p)
      => ComCall(230, this.p, BSTR.Ptr, p)
    put_animation(v)
      => ComCall(231, this.p, BSTR, v)
    get_animation(p)
      => ComCall(232, this.p, BSTR.Ptr, p)
    put_animationFillMode(v)
      => ComCall(233, this.p, BSTR, v)
    get_animationFillMode(p)
      => ComCall(234, this.p, BSTR.Ptr, p)
}
struct IHTMLCSSStyleDeclaration3 extends IDispatch {
    static IID := "{3051085C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_flex(v)
      => ComCall(7, this.p, BSTR, v)
    get_flex(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_flexDirection(v)
      => ComCall(9, this.p, BSTR, v)
    get_flexDirection(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_flexWrap(v)
      => ComCall(11, this.p, BSTR, v)
    get_flexWrap(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_flexFlow(v)
      => ComCall(13, this.p, BSTR, v)
    get_flexFlow(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_flexGrow(v)
      => ComCall(15, this.p, VARIANT, v)
    get_flexGrow(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_flexShrink(v)
      => ComCall(17, this.p, VARIANT, v)
    get_flexShrink(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_flexBasis(v)
      => ComCall(19, this.p, VARIANT, v)
    get_flexBasis(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_justifyContent(v)
      => ComCall(21, this.p, BSTR, v)
    get_justifyContent(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_alignItems(v)
      => ComCall(23, this.p, BSTR, v)
    get_alignItems(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_alignSelf(v)
      => ComCall(25, this.p, BSTR, v)
    get_alignSelf(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_alignContent(v)
      => ComCall(27, this.p, BSTR, v)
    get_alignContent(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_borderImage(v)
      => ComCall(29, this.p, BSTR, v)
    get_borderImage(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_borderImageSource(v)
      => ComCall(31, this.p, BSTR, v)
    get_borderImageSource(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_borderImageSlice(v)
      => ComCall(33, this.p, BSTR, v)
    get_borderImageSlice(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_borderImageWidth(v)
      => ComCall(35, this.p, BSTR, v)
    get_borderImageWidth(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_borderImageOutset(v)
      => ComCall(37, this.p, BSTR, v)
    get_borderImageOutset(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
    put_borderImageRepeat(v)
      => ComCall(39, this.p, BSTR, v)
    get_borderImageRepeat(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    put_msImeAlign(v)
      => ComCall(41, this.p, BSTR, v)
    get_msImeAlign(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_msTextCombineHorizontal(v)
      => ComCall(43, this.p, BSTR, v)
    get_msTextCombineHorizontal(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_touchAction(v)
      => ComCall(45, this.p, BSTR, v)
    get_touchAction(p)
      => ComCall(46, this.p, BSTR.Ptr, p)
}
struct IHTMLCSSStyleDeclaration4 extends IDispatch {
    static IID := "{D6100F3B-27C8-4132-AFEA-F0E4B1E00060}"
    put_webkitAppearance(v)
      => ComCall(7, this.p, BSTR, v)
    get_webkitAppearance(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_webkitUserSelect(v)
      => ComCall(9, this.p, BSTR, v)
    get_webkitUserSelect(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_webkitBoxAlign(v)
      => ComCall(11, this.p, BSTR, v)
    get_webkitBoxAlign(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_webkitBoxOrdinalGroup(v)
      => ComCall(13, this.p, VARIANT, v)
    get_webkitBoxOrdinalGroup(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_webkitBoxPack(v)
      => ComCall(15, this.p, BSTR, v)
    get_webkitBoxPack(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_webkitBoxFlex(v)
      => ComCall(17, this.p, VARIANT, v)
    get_webkitBoxFlex(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_webkitBoxOrient(v)
      => ComCall(19, this.p, BSTR, v)
    get_webkitBoxOrient(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_webkitBoxDirection(v)
      => ComCall(21, this.p, BSTR, v)
    get_webkitBoxDirection(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_webkitTransform(v)
      => ComCall(23, this.p, BSTR, v)
    get_webkitTransform(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_webkitBackgroundSize(v)
      => ComCall(25, this.p, BSTR, v)
    get_webkitBackgroundSize(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_webkitBackfaceVisibility(v)
      => ComCall(27, this.p, BSTR, v)
    get_webkitBackfaceVisibility(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_webkitAnimation(v)
      => ComCall(29, this.p, BSTR, v)
    get_webkitAnimation(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_webkitTransition(v)
      => ComCall(31, this.p, BSTR, v)
    get_webkitTransition(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_webkitAnimationName(v)
      => ComCall(33, this.p, BSTR, v)
    get_webkitAnimationName(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_webkitAnimationDuration(v)
      => ComCall(35, this.p, BSTR, v)
    get_webkitAnimationDuration(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_webkitAnimationTimingFunction(v)
      => ComCall(37, this.p, BSTR, v)
    get_webkitAnimationTimingFunction(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
    put_webkitAnimationDelay(v)
      => ComCall(39, this.p, BSTR, v)
    get_webkitAnimationDelay(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    put_webkitAnimationIterationCount(v)
      => ComCall(41, this.p, BSTR, v)
    get_webkitAnimationIterationCount(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_webkitAnimationDirection(v)
      => ComCall(43, this.p, BSTR, v)
    get_webkitAnimationDirection(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_webkitAnimationPlayState(v)
      => ComCall(45, this.p, BSTR, v)
    get_webkitAnimationPlayState(p)
      => ComCall(46, this.p, BSTR.Ptr, p)
    put_webkitTransitionProperty(v)
      => ComCall(47, this.p, BSTR, v)
    get_webkitTransitionProperty(p)
      => ComCall(48, this.p, BSTR.Ptr, p)
    put_webkitTransitionDuration(v)
      => ComCall(49, this.p, BSTR, v)
    get_webkitTransitionDuration(p)
      => ComCall(50, this.p, BSTR.Ptr, p)
    put_webkitTransitionTimingFunction(v)
      => ComCall(51, this.p, BSTR, v)
    get_webkitTransitionTimingFunction(p)
      => ComCall(52, this.p, BSTR.Ptr, p)
    put_webkitTransitionDelay(v)
      => ComCall(53, this.p, BSTR, v)
    get_webkitTransitionDelay(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    put_webkitBackgroundAttachment(v)
      => ComCall(55, this.p, BSTR, v)
    get_webkitBackgroundAttachment(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    put_webkitBackgroundColor(v)
      => ComCall(57, this.p, VARIANT, v)
    get_webkitBackgroundColor(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    put_webkitBackgroundClip(v)
      => ComCall(59, this.p, BSTR, v)
    get_webkitBackgroundClip(p)
      => ComCall(60, this.p, BSTR.Ptr, p)
    put_webkitBackgroundImage(v)
      => ComCall(61, this.p, BSTR, v)
    get_webkitBackgroundImage(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    put_webkitBackgroundRepeat(v)
      => ComCall(63, this.p, BSTR, v)
    get_webkitBackgroundRepeat(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    put_webkitBackgroundOrigin(v)
      => ComCall(65, this.p, BSTR, v)
    get_webkitBackgroundOrigin(p)
      => ComCall(66, this.p, BSTR.Ptr, p)
    put_webkitBackgroundPosition(v)
      => ComCall(67, this.p, BSTR, v)
    get_webkitBackgroundPosition(p)
      => ComCall(68, this.p, BSTR.Ptr, p)
    put_webkitBackgroundPositionX(v)
      => ComCall(69, this.p, VARIANT, v)
    get_webkitBackgroundPositionX(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_webkitBackgroundPositionY(v)
      => ComCall(71, this.p, VARIANT, v)
    get_webkitBackgroundPositionY(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    put_webkitBackground(v)
      => ComCall(73, this.p, BSTR, v)
    get_webkitBackground(p)
      => ComCall(74, this.p, BSTR.Ptr, p)
    put_webkitTransformOrigin(v)
      => ComCall(75, this.p, BSTR, v)
    get_webkitTransformOrigin(p)
      => ComCall(76, this.p, BSTR.Ptr, p)
    put_msTextSizeAdjust(v)
      => ComCall(77, this.p, VARIANT, v)
    get_msTextSizeAdjust(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_webkitTextSizeAdjust(v)
      => ComCall(79, this.p, VARIANT, v)
    get_webkitTextSizeAdjust(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_webkitBorderImage(v)
      => ComCall(81, this.p, BSTR, v)
    get_webkitBorderImage(p)
      => ComCall(82, this.p, BSTR.Ptr, p)
    put_webkitBorderImageSource(v)
      => ComCall(83, this.p, BSTR, v)
    get_webkitBorderImageSource(p)
      => ComCall(84, this.p, BSTR.Ptr, p)
    put_webkitBorderImageSlice(v)
      => ComCall(85, this.p, BSTR, v)
    get_webkitBorderImageSlice(p)
      => ComCall(86, this.p, BSTR.Ptr, p)
    put_webkitBorderImageWidth(v)
      => ComCall(87, this.p, BSTR, v)
    get_webkitBorderImageWidth(p)
      => ComCall(88, this.p, BSTR.Ptr, p)
    put_webkitBorderImageOutset(v)
      => ComCall(89, this.p, BSTR, v)
    get_webkitBorderImageOutset(p)
      => ComCall(90, this.p, BSTR.Ptr, p)
    put_webkitBorderImageRepeat(v)
      => ComCall(91, this.p, BSTR, v)
    get_webkitBorderImageRepeat(p)
      => ComCall(92, this.p, BSTR.Ptr, p)
    put_webkitBoxSizing(v)
      => ComCall(93, this.p, BSTR, v)
    get_webkitBoxSizing(p)
      => ComCall(94, this.p, BSTR.Ptr, p)
    put_webkitAnimationFillMode(v)
      => ComCall(95, this.p, BSTR, v)
    get_webkitAnimationFillMode(p)
      => ComCall(96, this.p, BSTR.Ptr, p)
}
struct IHTMLStyleEnabled extends IDispatch {
    static IID := "{305104C2-98B5-11CF-BB82-00AA00BDCE0B}"
    msGetPropertyEnabled(name, p)
      => ComCall(7, this.p, BSTR, name, VARIANT_BOOL.Ptr, p)
    msPutPropertyEnabled(name, b)
      => ComCall(8, this.p, BSTR, name, VARIANT_BOOL, b)
}
struct DispHTMLCSSStyleDeclaration extends IDispatch {
    static IID := "{3059009A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyle extends IDispatch {
    static IID := "{3050F25E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_fontFamily(v)
      => ComCall(7, this.p, BSTR, v)
    get_fontFamily(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_fontStyle(v)
      => ComCall(9, this.p, BSTR, v)
    get_fontStyle(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_fontVariant(v)
      => ComCall(11, this.p, BSTR, v)
    get_fontVariant(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_fontWeight(v)
      => ComCall(13, this.p, BSTR, v)
    get_fontWeight(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_fontSize(v)
      => ComCall(15, this.p, VARIANT, v)
    get_fontSize(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_font(v)
      => ComCall(17, this.p, BSTR, v)
    get_font(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_color(v)
      => ComCall(19, this.p, VARIANT, v)
    get_color(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_background(v)
      => ComCall(21, this.p, BSTR, v)
    get_background(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_backgroundColor(v)
      => ComCall(23, this.p, VARIANT, v)
    get_backgroundColor(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_backgroundImage(v)
      => ComCall(25, this.p, BSTR, v)
    get_backgroundImage(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_backgroundRepeat(v)
      => ComCall(27, this.p, BSTR, v)
    get_backgroundRepeat(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_backgroundAttachment(v)
      => ComCall(29, this.p, BSTR, v)
    get_backgroundAttachment(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_backgroundPosition(v)
      => ComCall(31, this.p, BSTR, v)
    get_backgroundPosition(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_backgroundPositionX(v)
      => ComCall(33, this.p, VARIANT, v)
    get_backgroundPositionX(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_backgroundPositionY(v)
      => ComCall(35, this.p, VARIANT, v)
    get_backgroundPositionY(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_wordSpacing(v)
      => ComCall(37, this.p, VARIANT, v)
    get_wordSpacing(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_letterSpacing(v)
      => ComCall(39, this.p, VARIANT, v)
    get_letterSpacing(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_textDecoration(v)
      => ComCall(41, this.p, BSTR, v)
    get_textDecoration(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_textDecorationNone(v)
      => ComCall(43, this.p, VARIANT_BOOL, v)
    get_textDecorationNone(p)
      => ComCall(44, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationUnderline(v)
      => ComCall(45, this.p, VARIANT_BOOL, v)
    get_textDecorationUnderline(p)
      => ComCall(46, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationOverline(v)
      => ComCall(47, this.p, VARIANT_BOOL, v)
    get_textDecorationOverline(p)
      => ComCall(48, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationLineThrough(v)
      => ComCall(49, this.p, VARIANT_BOOL, v)
    get_textDecorationLineThrough(p)
      => ComCall(50, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationBlink(v)
      => ComCall(51, this.p, VARIANT_BOOL, v)
    get_textDecorationBlink(p)
      => ComCall(52, this.p, VARIANT_BOOL.Ptr, p)
    put_verticalAlign(v)
      => ComCall(53, this.p, VARIANT, v)
    get_verticalAlign(p)
      => ComCall(54, this.p, VARIANT.Ptr, p)
    put_textTransform(v)
      => ComCall(55, this.p, BSTR, v)
    get_textTransform(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    put_textAlign(v)
      => ComCall(57, this.p, BSTR, v)
    get_textAlign(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_textIndent(v)
      => ComCall(59, this.p, VARIANT, v)
    get_textIndent(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    put_lineHeight(v)
      => ComCall(61, this.p, VARIANT, v)
    get_lineHeight(p)
      => ComCall(62, this.p, VARIANT.Ptr, p)
    put_marginTop(v)
      => ComCall(63, this.p, VARIANT, v)
    get_marginTop(p)
      => ComCall(64, this.p, VARIANT.Ptr, p)
    put_marginRight(v)
      => ComCall(65, this.p, VARIANT, v)
    get_marginRight(p)
      => ComCall(66, this.p, VARIANT.Ptr, p)
    put_marginBottom(v)
      => ComCall(67, this.p, VARIANT, v)
    get_marginBottom(p)
      => ComCall(68, this.p, VARIANT.Ptr, p)
    put_marginLeft(v)
      => ComCall(69, this.p, VARIANT, v)
    get_marginLeft(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_margin(v)
      => ComCall(71, this.p, BSTR, v)
    get_margin(p)
      => ComCall(72, this.p, BSTR.Ptr, p)
    put_paddingTop(v)
      => ComCall(73, this.p, VARIANT, v)
    get_paddingTop(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_paddingRight(v)
      => ComCall(75, this.p, VARIANT, v)
    get_paddingRight(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_paddingBottom(v)
      => ComCall(77, this.p, VARIANT, v)
    get_paddingBottom(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_paddingLeft(v)
      => ComCall(79, this.p, VARIANT, v)
    get_paddingLeft(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_padding(v)
      => ComCall(81, this.p, BSTR, v)
    get_padding(p)
      => ComCall(82, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(83, this.p, BSTR, v)
    get_border(p)
      => ComCall(84, this.p, BSTR.Ptr, p)
    put_borderTop(v)
      => ComCall(85, this.p, BSTR, v)
    get_borderTop(p)
      => ComCall(86, this.p, BSTR.Ptr, p)
    put_borderRight(v)
      => ComCall(87, this.p, BSTR, v)
    get_borderRight(p)
      => ComCall(88, this.p, BSTR.Ptr, p)
    put_borderBottom(v)
      => ComCall(89, this.p, BSTR, v)
    get_borderBottom(p)
      => ComCall(90, this.p, BSTR.Ptr, p)
    put_borderLeft(v)
      => ComCall(91, this.p, BSTR, v)
    get_borderLeft(p)
      => ComCall(92, this.p, BSTR.Ptr, p)
    put_borderColor(v)
      => ComCall(93, this.p, BSTR, v)
    get_borderColor(p)
      => ComCall(94, this.p, BSTR.Ptr, p)
    put_borderTopColor(v)
      => ComCall(95, this.p, VARIANT, v)
    get_borderTopColor(p)
      => ComCall(96, this.p, VARIANT.Ptr, p)
    put_borderRightColor(v)
      => ComCall(97, this.p, VARIANT, v)
    get_borderRightColor(p)
      => ComCall(98, this.p, VARIANT.Ptr, p)
    put_borderBottomColor(v)
      => ComCall(99, this.p, VARIANT, v)
    get_borderBottomColor(p)
      => ComCall(100, this.p, VARIANT.Ptr, p)
    put_borderLeftColor(v)
      => ComCall(101, this.p, VARIANT, v)
    get_borderLeftColor(p)
      => ComCall(102, this.p, VARIANT.Ptr, p)
    put_borderWidth(v)
      => ComCall(103, this.p, BSTR, v)
    get_borderWidth(p)
      => ComCall(104, this.p, BSTR.Ptr, p)
    put_borderTopWidth(v)
      => ComCall(105, this.p, VARIANT, v)
    get_borderTopWidth(p)
      => ComCall(106, this.p, VARIANT.Ptr, p)
    put_borderRightWidth(v)
      => ComCall(107, this.p, VARIANT, v)
    get_borderRightWidth(p)
      => ComCall(108, this.p, VARIANT.Ptr, p)
    put_borderBottomWidth(v)
      => ComCall(109, this.p, VARIANT, v)
    get_borderBottomWidth(p)
      => ComCall(110, this.p, VARIANT.Ptr, p)
    put_borderLeftWidth(v)
      => ComCall(111, this.p, VARIANT, v)
    get_borderLeftWidth(p)
      => ComCall(112, this.p, VARIANT.Ptr, p)
    put_borderStyle(v)
      => ComCall(113, this.p, BSTR, v)
    get_borderStyle(p)
      => ComCall(114, this.p, BSTR.Ptr, p)
    put_borderTopStyle(v)
      => ComCall(115, this.p, BSTR, v)
    get_borderTopStyle(p)
      => ComCall(116, this.p, BSTR.Ptr, p)
    put_borderRightStyle(v)
      => ComCall(117, this.p, BSTR, v)
    get_borderRightStyle(p)
      => ComCall(118, this.p, BSTR.Ptr, p)
    put_borderBottomStyle(v)
      => ComCall(119, this.p, BSTR, v)
    get_borderBottomStyle(p)
      => ComCall(120, this.p, BSTR.Ptr, p)
    put_borderLeftStyle(v)
      => ComCall(121, this.p, BSTR, v)
    get_borderLeftStyle(p)
      => ComCall(122, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(123, this.p, VARIANT, v)
    get_width(p)
      => ComCall(124, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(125, this.p, VARIANT, v)
    get_height(p)
      => ComCall(126, this.p, VARIANT.Ptr, p)
    put_styleFloat(v)
      => ComCall(127, this.p, BSTR, v)
    get_styleFloat(p)
      => ComCall(128, this.p, BSTR.Ptr, p)
    put_clear(v)
      => ComCall(129, this.p, BSTR, v)
    get_clear(p)
      => ComCall(130, this.p, BSTR.Ptr, p)
    put_display(v)
      => ComCall(131, this.p, BSTR, v)
    get_display(p)
      => ComCall(132, this.p, BSTR.Ptr, p)
    put_visibility(v)
      => ComCall(133, this.p, BSTR, v)
    get_visibility(p)
      => ComCall(134, this.p, BSTR.Ptr, p)
    put_listStyleType(v)
      => ComCall(135, this.p, BSTR, v)
    get_listStyleType(p)
      => ComCall(136, this.p, BSTR.Ptr, p)
    put_listStylePosition(v)
      => ComCall(137, this.p, BSTR, v)
    get_listStylePosition(p)
      => ComCall(138, this.p, BSTR.Ptr, p)
    put_listStyleImage(v)
      => ComCall(139, this.p, BSTR, v)
    get_listStyleImage(p)
      => ComCall(140, this.p, BSTR.Ptr, p)
    put_listStyle(v)
      => ComCall(141, this.p, BSTR, v)
    get_listStyle(p)
      => ComCall(142, this.p, BSTR.Ptr, p)
    put_whiteSpace(v)
      => ComCall(143, this.p, BSTR, v)
    get_whiteSpace(p)
      => ComCall(144, this.p, BSTR.Ptr, p)
    put_top(v)
      => ComCall(145, this.p, VARIANT, v)
    get_top(p)
      => ComCall(146, this.p, VARIANT.Ptr, p)
    put_left(v)
      => ComCall(147, this.p, VARIANT, v)
    get_left(p)
      => ComCall(148, this.p, VARIANT.Ptr, p)
    get_position(p)
      => ComCall(149, this.p, BSTR.Ptr, p)
    put_zIndex(v)
      => ComCall(150, this.p, VARIANT, v)
    get_zIndex(p)
      => ComCall(151, this.p, VARIANT.Ptr, p)
    put_overflow(v)
      => ComCall(152, this.p, BSTR, v)
    get_overflow(p)
      => ComCall(153, this.p, BSTR.Ptr, p)
    put_pageBreakBefore(v)
      => ComCall(154, this.p, BSTR, v)
    get_pageBreakBefore(p)
      => ComCall(155, this.p, BSTR.Ptr, p)
    put_pageBreakAfter(v)
      => ComCall(156, this.p, BSTR, v)
    get_pageBreakAfter(p)
      => ComCall(157, this.p, BSTR.Ptr, p)
    put_cssText(v)
      => ComCall(158, this.p, BSTR, v)
    get_cssText(p)
      => ComCall(159, this.p, BSTR.Ptr, p)
    put_pixelTop(v)
      => ComCall(160, this.p, Int32, v)
    get_pixelTop(p)
      => ComCall(161, this.p, Int32.Ptr, p)
    put_pixelLeft(v)
      => ComCall(162, this.p, Int32, v)
    get_pixelLeft(p)
      => ComCall(163, this.p, Int32.Ptr, p)
    put_pixelWidth(v)
      => ComCall(164, this.p, Int32, v)
    get_pixelWidth(p)
      => ComCall(165, this.p, Int32.Ptr, p)
    put_pixelHeight(v)
      => ComCall(166, this.p, Int32, v)
    get_pixelHeight(p)
      => ComCall(167, this.p, Int32.Ptr, p)
    put_posTop(v)
      => ComCall(168, this.p, Float32, v)
    get_posTop(p)
      => ComCall(169, this.p, Float32.Ptr, p)
    put_posLeft(v)
      => ComCall(170, this.p, Float32, v)
    get_posLeft(p)
      => ComCall(171, this.p, Float32.Ptr, p)
    put_posWidth(v)
      => ComCall(172, this.p, Float32, v)
    get_posWidth(p)
      => ComCall(173, this.p, Float32.Ptr, p)
    put_posHeight(v)
      => ComCall(174, this.p, Float32, v)
    get_posHeight(p)
      => ComCall(175, this.p, Float32.Ptr, p)
    put_cursor(v)
      => ComCall(176, this.p, BSTR, v)
    get_cursor(p)
      => ComCall(177, this.p, BSTR.Ptr, p)
    put_clip(v)
      => ComCall(178, this.p, BSTR, v)
    get_clip(p)
      => ComCall(179, this.p, BSTR.Ptr, p)
    put_filter(v)
      => ComCall(180, this.p, BSTR, v)
    get_filter(p)
      => ComCall(181, this.p, BSTR.Ptr, p)
    setAttribute(strAttributeName, AttributeValue, lFlags)
      => ComCall(182, this.p, BSTR, strAttributeName, VARIANT, AttributeValue, Int32, lFlags)
    getAttribute(strAttributeName, lFlags, AttributeValue)
      => ComCall(183, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT.Ptr, AttributeValue)
    removeAttribute(strAttributeName, lFlags, pfSuccess)
      => ComCall(184, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT_BOOL.Ptr, pfSuccess)
    toString(String)
      => ComCall(185, this.p, BSTR.Ptr, String)
}
struct IHTMLStyle2 extends IDispatch {
    static IID := "{3050F4A2-98B5-11CF-BB82-00AA00BDCE0B}"
    put_tableLayout(v)
      => ComCall(7, this.p, BSTR, v)
    get_tableLayout(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_borderCollapse(v)
      => ComCall(9, this.p, BSTR, v)
    get_borderCollapse(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_direction(v)
      => ComCall(11, this.p, BSTR, v)
    get_direction(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_behavior(v)
      => ComCall(13, this.p, BSTR, v)
    get_behavior(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    setExpression(propname, expression, language)
      => ComCall(15, this.p, BSTR, propname, BSTR, expression, BSTR, language)
    getExpression(propname, expression)
      => ComCall(16, this.p, BSTR, propname, VARIANT.Ptr, expression)
    removeExpression(propname, pfSuccess)
      => ComCall(17, this.p, BSTR, propname, VARIANT_BOOL.Ptr, pfSuccess)
    put_position(v)
      => ComCall(18, this.p, BSTR, v)
    get_position(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_unicodeBidi(v)
      => ComCall(20, this.p, BSTR, v)
    get_unicodeBidi(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    put_bottom(v)
      => ComCall(22, this.p, VARIANT, v)
    get_bottom(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_right(v)
      => ComCall(24, this.p, VARIANT, v)
    get_right(p)
      => ComCall(25, this.p, VARIANT.Ptr, p)
    put_pixelBottom(v)
      => ComCall(26, this.p, Int32, v)
    get_pixelBottom(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    put_pixelRight(v)
      => ComCall(28, this.p, Int32, v)
    get_pixelRight(p)
      => ComCall(29, this.p, Int32.Ptr, p)
    put_posBottom(v)
      => ComCall(30, this.p, Float32, v)
    get_posBottom(p)
      => ComCall(31, this.p, Float32.Ptr, p)
    put_posRight(v)
      => ComCall(32, this.p, Float32, v)
    get_posRight(p)
      => ComCall(33, this.p, Float32.Ptr, p)
    put_imeMode(v)
      => ComCall(34, this.p, BSTR, v)
    get_imeMode(p)
      => ComCall(35, this.p, BSTR.Ptr, p)
    put_rubyAlign(v)
      => ComCall(36, this.p, BSTR, v)
    get_rubyAlign(p)
      => ComCall(37, this.p, BSTR.Ptr, p)
    put_rubyPosition(v)
      => ComCall(38, this.p, BSTR, v)
    get_rubyPosition(p)
      => ComCall(39, this.p, BSTR.Ptr, p)
    put_rubyOverhang(v)
      => ComCall(40, this.p, BSTR, v)
    get_rubyOverhang(p)
      => ComCall(41, this.p, BSTR.Ptr, p)
    put_layoutGridChar(v)
      => ComCall(42, this.p, VARIANT, v)
    get_layoutGridChar(p)
      => ComCall(43, this.p, VARIANT.Ptr, p)
    put_layoutGridLine(v)
      => ComCall(44, this.p, VARIANT, v)
    get_layoutGridLine(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    put_layoutGridMode(v)
      => ComCall(46, this.p, BSTR, v)
    get_layoutGridMode(p)
      => ComCall(47, this.p, BSTR.Ptr, p)
    put_layoutGridType(v)
      => ComCall(48, this.p, BSTR, v)
    get_layoutGridType(p)
      => ComCall(49, this.p, BSTR.Ptr, p)
    put_layoutGrid(v)
      => ComCall(50, this.p, BSTR, v)
    get_layoutGrid(p)
      => ComCall(51, this.p, BSTR.Ptr, p)
    put_wordBreak(v)
      => ComCall(52, this.p, BSTR, v)
    get_wordBreak(p)
      => ComCall(53, this.p, BSTR.Ptr, p)
    put_lineBreak(v)
      => ComCall(54, this.p, BSTR, v)
    get_lineBreak(p)
      => ComCall(55, this.p, BSTR.Ptr, p)
    put_textJustify(v)
      => ComCall(56, this.p, BSTR, v)
    get_textJustify(p)
      => ComCall(57, this.p, BSTR.Ptr, p)
    put_textJustifyTrim(v)
      => ComCall(58, this.p, BSTR, v)
    get_textJustifyTrim(p)
      => ComCall(59, this.p, BSTR.Ptr, p)
    put_textKashida(v)
      => ComCall(60, this.p, VARIANT, v)
    get_textKashida(p)
      => ComCall(61, this.p, VARIANT.Ptr, p)
    put_textAutospace(v)
      => ComCall(62, this.p, BSTR, v)
    get_textAutospace(p)
      => ComCall(63, this.p, BSTR.Ptr, p)
    put_overflowX(v)
      => ComCall(64, this.p, BSTR, v)
    get_overflowX(p)
      => ComCall(65, this.p, BSTR.Ptr, p)
    put_overflowY(v)
      => ComCall(66, this.p, BSTR, v)
    get_overflowY(p)
      => ComCall(67, this.p, BSTR.Ptr, p)
    put_accelerator(v)
      => ComCall(68, this.p, BSTR, v)
    get_accelerator(p)
      => ComCall(69, this.p, BSTR.Ptr, p)
}
struct IHTMLStyle3 extends IDispatch {
    static IID := "{3050F656-98B5-11CF-BB82-00AA00BDCE0B}"
    put_layoutFlow(v)
      => ComCall(7, this.p, BSTR, v)
    get_layoutFlow(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_zoom(v)
      => ComCall(9, this.p, VARIANT, v)
    get_zoom(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_wordWrap(v)
      => ComCall(11, this.p, BSTR, v)
    get_wordWrap(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_textUnderlinePosition(v)
      => ComCall(13, this.p, BSTR, v)
    get_textUnderlinePosition(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_scrollbarBaseColor(v)
      => ComCall(15, this.p, VARIANT, v)
    get_scrollbarBaseColor(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_scrollbarFaceColor(v)
      => ComCall(17, this.p, VARIANT, v)
    get_scrollbarFaceColor(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_scrollbar3dLightColor(v)
      => ComCall(19, this.p, VARIANT, v)
    get_scrollbar3dLightColor(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_scrollbarShadowColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_scrollbarShadowColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_scrollbarHighlightColor(v)
      => ComCall(23, this.p, VARIANT, v)
    get_scrollbarHighlightColor(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_scrollbarDarkShadowColor(v)
      => ComCall(25, this.p, VARIANT, v)
    get_scrollbarDarkShadowColor(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_scrollbarArrowColor(v)
      => ComCall(27, this.p, VARIANT, v)
    get_scrollbarArrowColor(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_scrollbarTrackColor(v)
      => ComCall(29, this.p, VARIANT, v)
    get_scrollbarTrackColor(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_writingMode(v)
      => ComCall(31, this.p, BSTR, v)
    get_writingMode(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_textAlignLast(v)
      => ComCall(33, this.p, BSTR, v)
    get_textAlignLast(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_textKashidaSpace(v)
      => ComCall(35, this.p, VARIANT, v)
    get_textKashidaSpace(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
}
struct IHTMLStyle4 extends IDispatch {
    static IID := "{3050F816-98B5-11CF-BB82-00AA00BDCE0B}"
    put_textOverflow(v)
      => ComCall(7, this.p, BSTR, v)
    get_textOverflow(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_minHeight(v)
      => ComCall(9, this.p, VARIANT, v)
    get_minHeight(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLStyle5 extends IDispatch {
    static IID := "{3050F33A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_msInterpolationMode(v)
      => ComCall(7, this.p, BSTR, v)
    get_msInterpolationMode(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_maxHeight(v)
      => ComCall(9, this.p, VARIANT, v)
    get_maxHeight(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_minWidth(v)
      => ComCall(11, this.p, VARIANT, v)
    get_minWidth(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_maxWidth(v)
      => ComCall(13, this.p, VARIANT, v)
    get_maxWidth(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
}
struct IHTMLStyle6 extends IDispatch {
    static IID := "{30510480-98B5-11CF-BB82-00AA00BDCE0B}"
    put_content(v)
      => ComCall(7, this.p, BSTR, v)
    get_content(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_captionSide(v)
      => ComCall(9, this.p, BSTR, v)
    get_captionSide(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_counterIncrement(v)
      => ComCall(11, this.p, BSTR, v)
    get_counterIncrement(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_counterReset(v)
      => ComCall(13, this.p, BSTR, v)
    get_counterReset(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_outline(v)
      => ComCall(15, this.p, BSTR, v)
    get_outline(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_outlineWidth(v)
      => ComCall(17, this.p, VARIANT, v)
    get_outlineWidth(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_outlineStyle(v)
      => ComCall(19, this.p, BSTR, v)
    get_outlineStyle(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_outlineColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_outlineColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_boxSizing(v)
      => ComCall(23, this.p, BSTR, v)
    get_boxSizing(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_borderSpacing(v)
      => ComCall(25, this.p, BSTR, v)
    get_borderSpacing(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_orphans(v)
      => ComCall(27, this.p, VARIANT, v)
    get_orphans(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_widows(v)
      => ComCall(29, this.p, VARIANT, v)
    get_widows(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_pageBreakInside(v)
      => ComCall(31, this.p, BSTR, v)
    get_pageBreakInside(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_emptyCells(v)
      => ComCall(33, this.p, BSTR, v)
    get_emptyCells(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_msBlockProgression(v)
      => ComCall(35, this.p, BSTR, v)
    get_msBlockProgression(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_quotes(v)
      => ComCall(37, this.p, BSTR, v)
    get_quotes(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
}
struct IHTMLRuleStyle extends IDispatch {
    static IID := "{3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}"
    put_fontFamily(v)
      => ComCall(7, this.p, BSTR, v)
    get_fontFamily(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_fontStyle(v)
      => ComCall(9, this.p, BSTR, v)
    get_fontStyle(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_fontVariant(v)
      => ComCall(11, this.p, BSTR, v)
    get_fontVariant(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_fontWeight(v)
      => ComCall(13, this.p, BSTR, v)
    get_fontWeight(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_fontSize(v)
      => ComCall(15, this.p, VARIANT, v)
    get_fontSize(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_font(v)
      => ComCall(17, this.p, BSTR, v)
    get_font(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_color(v)
      => ComCall(19, this.p, VARIANT, v)
    get_color(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_background(v)
      => ComCall(21, this.p, BSTR, v)
    get_background(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_backgroundColor(v)
      => ComCall(23, this.p, VARIANT, v)
    get_backgroundColor(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_backgroundImage(v)
      => ComCall(25, this.p, BSTR, v)
    get_backgroundImage(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_backgroundRepeat(v)
      => ComCall(27, this.p, BSTR, v)
    get_backgroundRepeat(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_backgroundAttachment(v)
      => ComCall(29, this.p, BSTR, v)
    get_backgroundAttachment(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_backgroundPosition(v)
      => ComCall(31, this.p, BSTR, v)
    get_backgroundPosition(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_backgroundPositionX(v)
      => ComCall(33, this.p, VARIANT, v)
    get_backgroundPositionX(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_backgroundPositionY(v)
      => ComCall(35, this.p, VARIANT, v)
    get_backgroundPositionY(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_wordSpacing(v)
      => ComCall(37, this.p, VARIANT, v)
    get_wordSpacing(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_letterSpacing(v)
      => ComCall(39, this.p, VARIANT, v)
    get_letterSpacing(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_textDecoration(v)
      => ComCall(41, this.p, BSTR, v)
    get_textDecoration(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_textDecorationNone(v)
      => ComCall(43, this.p, VARIANT_BOOL, v)
    get_textDecorationNone(p)
      => ComCall(44, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationUnderline(v)
      => ComCall(45, this.p, VARIANT_BOOL, v)
    get_textDecorationUnderline(p)
      => ComCall(46, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationOverline(v)
      => ComCall(47, this.p, VARIANT_BOOL, v)
    get_textDecorationOverline(p)
      => ComCall(48, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationLineThrough(v)
      => ComCall(49, this.p, VARIANT_BOOL, v)
    get_textDecorationLineThrough(p)
      => ComCall(50, this.p, VARIANT_BOOL.Ptr, p)
    put_textDecorationBlink(v)
      => ComCall(51, this.p, VARIANT_BOOL, v)
    get_textDecorationBlink(p)
      => ComCall(52, this.p, VARIANT_BOOL.Ptr, p)
    put_verticalAlign(v)
      => ComCall(53, this.p, VARIANT, v)
    get_verticalAlign(p)
      => ComCall(54, this.p, VARIANT.Ptr, p)
    put_textTransform(v)
      => ComCall(55, this.p, BSTR, v)
    get_textTransform(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    put_textAlign(v)
      => ComCall(57, this.p, BSTR, v)
    get_textAlign(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_textIndent(v)
      => ComCall(59, this.p, VARIANT, v)
    get_textIndent(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    put_lineHeight(v)
      => ComCall(61, this.p, VARIANT, v)
    get_lineHeight(p)
      => ComCall(62, this.p, VARIANT.Ptr, p)
    put_marginTop(v)
      => ComCall(63, this.p, VARIANT, v)
    get_marginTop(p)
      => ComCall(64, this.p, VARIANT.Ptr, p)
    put_marginRight(v)
      => ComCall(65, this.p, VARIANT, v)
    get_marginRight(p)
      => ComCall(66, this.p, VARIANT.Ptr, p)
    put_marginBottom(v)
      => ComCall(67, this.p, VARIANT, v)
    get_marginBottom(p)
      => ComCall(68, this.p, VARIANT.Ptr, p)
    put_marginLeft(v)
      => ComCall(69, this.p, VARIANT, v)
    get_marginLeft(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_margin(v)
      => ComCall(71, this.p, BSTR, v)
    get_margin(p)
      => ComCall(72, this.p, BSTR.Ptr, p)
    put_paddingTop(v)
      => ComCall(73, this.p, VARIANT, v)
    get_paddingTop(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_paddingRight(v)
      => ComCall(75, this.p, VARIANT, v)
    get_paddingRight(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_paddingBottom(v)
      => ComCall(77, this.p, VARIANT, v)
    get_paddingBottom(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_paddingLeft(v)
      => ComCall(79, this.p, VARIANT, v)
    get_paddingLeft(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_padding(v)
      => ComCall(81, this.p, BSTR, v)
    get_padding(p)
      => ComCall(82, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(83, this.p, BSTR, v)
    get_border(p)
      => ComCall(84, this.p, BSTR.Ptr, p)
    put_borderTop(v)
      => ComCall(85, this.p, BSTR, v)
    get_borderTop(p)
      => ComCall(86, this.p, BSTR.Ptr, p)
    put_borderRight(v)
      => ComCall(87, this.p, BSTR, v)
    get_borderRight(p)
      => ComCall(88, this.p, BSTR.Ptr, p)
    put_borderBottom(v)
      => ComCall(89, this.p, BSTR, v)
    get_borderBottom(p)
      => ComCall(90, this.p, BSTR.Ptr, p)
    put_borderLeft(v)
      => ComCall(91, this.p, BSTR, v)
    get_borderLeft(p)
      => ComCall(92, this.p, BSTR.Ptr, p)
    put_borderColor(v)
      => ComCall(93, this.p, BSTR, v)
    get_borderColor(p)
      => ComCall(94, this.p, BSTR.Ptr, p)
    put_borderTopColor(v)
      => ComCall(95, this.p, VARIANT, v)
    get_borderTopColor(p)
      => ComCall(96, this.p, VARIANT.Ptr, p)
    put_borderRightColor(v)
      => ComCall(97, this.p, VARIANT, v)
    get_borderRightColor(p)
      => ComCall(98, this.p, VARIANT.Ptr, p)
    put_borderBottomColor(v)
      => ComCall(99, this.p, VARIANT, v)
    get_borderBottomColor(p)
      => ComCall(100, this.p, VARIANT.Ptr, p)
    put_borderLeftColor(v)
      => ComCall(101, this.p, VARIANT, v)
    get_borderLeftColor(p)
      => ComCall(102, this.p, VARIANT.Ptr, p)
    put_borderWidth(v)
      => ComCall(103, this.p, BSTR, v)
    get_borderWidth(p)
      => ComCall(104, this.p, BSTR.Ptr, p)
    put_borderTopWidth(v)
      => ComCall(105, this.p, VARIANT, v)
    get_borderTopWidth(p)
      => ComCall(106, this.p, VARIANT.Ptr, p)
    put_borderRightWidth(v)
      => ComCall(107, this.p, VARIANT, v)
    get_borderRightWidth(p)
      => ComCall(108, this.p, VARIANT.Ptr, p)
    put_borderBottomWidth(v)
      => ComCall(109, this.p, VARIANT, v)
    get_borderBottomWidth(p)
      => ComCall(110, this.p, VARIANT.Ptr, p)
    put_borderLeftWidth(v)
      => ComCall(111, this.p, VARIANT, v)
    get_borderLeftWidth(p)
      => ComCall(112, this.p, VARIANT.Ptr, p)
    put_borderStyle(v)
      => ComCall(113, this.p, BSTR, v)
    get_borderStyle(p)
      => ComCall(114, this.p, BSTR.Ptr, p)
    put_borderTopStyle(v)
      => ComCall(115, this.p, BSTR, v)
    get_borderTopStyle(p)
      => ComCall(116, this.p, BSTR.Ptr, p)
    put_borderRightStyle(v)
      => ComCall(117, this.p, BSTR, v)
    get_borderRightStyle(p)
      => ComCall(118, this.p, BSTR.Ptr, p)
    put_borderBottomStyle(v)
      => ComCall(119, this.p, BSTR, v)
    get_borderBottomStyle(p)
      => ComCall(120, this.p, BSTR.Ptr, p)
    put_borderLeftStyle(v)
      => ComCall(121, this.p, BSTR, v)
    get_borderLeftStyle(p)
      => ComCall(122, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(123, this.p, VARIANT, v)
    get_width(p)
      => ComCall(124, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(125, this.p, VARIANT, v)
    get_height(p)
      => ComCall(126, this.p, VARIANT.Ptr, p)
    put_styleFloat(v)
      => ComCall(127, this.p, BSTR, v)
    get_styleFloat(p)
      => ComCall(128, this.p, BSTR.Ptr, p)
    put_clear(v)
      => ComCall(129, this.p, BSTR, v)
    get_clear(p)
      => ComCall(130, this.p, BSTR.Ptr, p)
    put_display(v)
      => ComCall(131, this.p, BSTR, v)
    get_display(p)
      => ComCall(132, this.p, BSTR.Ptr, p)
    put_visibility(v)
      => ComCall(133, this.p, BSTR, v)
    get_visibility(p)
      => ComCall(134, this.p, BSTR.Ptr, p)
    put_listStyleType(v)
      => ComCall(135, this.p, BSTR, v)
    get_listStyleType(p)
      => ComCall(136, this.p, BSTR.Ptr, p)
    put_listStylePosition(v)
      => ComCall(137, this.p, BSTR, v)
    get_listStylePosition(p)
      => ComCall(138, this.p, BSTR.Ptr, p)
    put_listStyleImage(v)
      => ComCall(139, this.p, BSTR, v)
    get_listStyleImage(p)
      => ComCall(140, this.p, BSTR.Ptr, p)
    put_listStyle(v)
      => ComCall(141, this.p, BSTR, v)
    get_listStyle(p)
      => ComCall(142, this.p, BSTR.Ptr, p)
    put_whiteSpace(v)
      => ComCall(143, this.p, BSTR, v)
    get_whiteSpace(p)
      => ComCall(144, this.p, BSTR.Ptr, p)
    put_top(v)
      => ComCall(145, this.p, VARIANT, v)
    get_top(p)
      => ComCall(146, this.p, VARIANT.Ptr, p)
    put_left(v)
      => ComCall(147, this.p, VARIANT, v)
    get_left(p)
      => ComCall(148, this.p, VARIANT.Ptr, p)
    get_position(p)
      => ComCall(149, this.p, BSTR.Ptr, p)
    put_zIndex(v)
      => ComCall(150, this.p, VARIANT, v)
    get_zIndex(p)
      => ComCall(151, this.p, VARIANT.Ptr, p)
    put_overflow(v)
      => ComCall(152, this.p, BSTR, v)
    get_overflow(p)
      => ComCall(153, this.p, BSTR.Ptr, p)
    put_pageBreakBefore(v)
      => ComCall(154, this.p, BSTR, v)
    get_pageBreakBefore(p)
      => ComCall(155, this.p, BSTR.Ptr, p)
    put_pageBreakAfter(v)
      => ComCall(156, this.p, BSTR, v)
    get_pageBreakAfter(p)
      => ComCall(157, this.p, BSTR.Ptr, p)
    put_cssText(v)
      => ComCall(158, this.p, BSTR, v)
    get_cssText(p)
      => ComCall(159, this.p, BSTR.Ptr, p)
    put_cursor(v)
      => ComCall(160, this.p, BSTR, v)
    get_cursor(p)
      => ComCall(161, this.p, BSTR.Ptr, p)
    put_clip(v)
      => ComCall(162, this.p, BSTR, v)
    get_clip(p)
      => ComCall(163, this.p, BSTR.Ptr, p)
    put_filter(v)
      => ComCall(164, this.p, BSTR, v)
    get_filter(p)
      => ComCall(165, this.p, BSTR.Ptr, p)
    setAttribute(strAttributeName, AttributeValue, lFlags)
      => ComCall(166, this.p, BSTR, strAttributeName, VARIANT, AttributeValue, Int32, lFlags)
    getAttribute(strAttributeName, lFlags, AttributeValue)
      => ComCall(167, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT.Ptr, AttributeValue)
    removeAttribute(strAttributeName, lFlags, pfSuccess)
      => ComCall(168, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT_BOOL.Ptr, pfSuccess)
}
struct IHTMLRuleStyle2 extends IDispatch {
    static IID := "{3050F4AC-98B5-11CF-BB82-00AA00BDCE0B}"
    put_tableLayout(v)
      => ComCall(7, this.p, BSTR, v)
    get_tableLayout(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_borderCollapse(v)
      => ComCall(9, this.p, BSTR, v)
    get_borderCollapse(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_direction(v)
      => ComCall(11, this.p, BSTR, v)
    get_direction(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_behavior(v)
      => ComCall(13, this.p, BSTR, v)
    get_behavior(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_position(v)
      => ComCall(15, this.p, BSTR, v)
    get_position(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_unicodeBidi(v)
      => ComCall(17, this.p, BSTR, v)
    get_unicodeBidi(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_bottom(v)
      => ComCall(19, this.p, VARIANT, v)
    get_bottom(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_right(v)
      => ComCall(21, this.p, VARIANT, v)
    get_right(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_pixelBottom(v)
      => ComCall(23, this.p, Int32, v)
    get_pixelBottom(p)
      => ComCall(24, this.p, Int32.Ptr, p)
    put_pixelRight(v)
      => ComCall(25, this.p, Int32, v)
    get_pixelRight(p)
      => ComCall(26, this.p, Int32.Ptr, p)
    put_posBottom(v)
      => ComCall(27, this.p, Float32, v)
    get_posBottom(p)
      => ComCall(28, this.p, Float32.Ptr, p)
    put_posRight(v)
      => ComCall(29, this.p, Float32, v)
    get_posRight(p)
      => ComCall(30, this.p, Float32.Ptr, p)
    put_imeMode(v)
      => ComCall(31, this.p, BSTR, v)
    get_imeMode(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_rubyAlign(v)
      => ComCall(33, this.p, BSTR, v)
    get_rubyAlign(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_rubyPosition(v)
      => ComCall(35, this.p, BSTR, v)
    get_rubyPosition(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_rubyOverhang(v)
      => ComCall(37, this.p, BSTR, v)
    get_rubyOverhang(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
    put_layoutGridChar(v)
      => ComCall(39, this.p, VARIANT, v)
    get_layoutGridChar(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_layoutGridLine(v)
      => ComCall(41, this.p, VARIANT, v)
    get_layoutGridLine(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    put_layoutGridMode(v)
      => ComCall(43, this.p, BSTR, v)
    get_layoutGridMode(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_layoutGridType(v)
      => ComCall(45, this.p, BSTR, v)
    get_layoutGridType(p)
      => ComCall(46, this.p, BSTR.Ptr, p)
    put_layoutGrid(v)
      => ComCall(47, this.p, BSTR, v)
    get_layoutGrid(p)
      => ComCall(48, this.p, BSTR.Ptr, p)
    put_textAutospace(v)
      => ComCall(49, this.p, BSTR, v)
    get_textAutospace(p)
      => ComCall(50, this.p, BSTR.Ptr, p)
    put_wordBreak(v)
      => ComCall(51, this.p, BSTR, v)
    get_wordBreak(p)
      => ComCall(52, this.p, BSTR.Ptr, p)
    put_lineBreak(v)
      => ComCall(53, this.p, BSTR, v)
    get_lineBreak(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    put_textJustify(v)
      => ComCall(55, this.p, BSTR, v)
    get_textJustify(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    put_textJustifyTrim(v)
      => ComCall(57, this.p, BSTR, v)
    get_textJustifyTrim(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_textKashida(v)
      => ComCall(59, this.p, VARIANT, v)
    get_textKashida(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    put_overflowX(v)
      => ComCall(61, this.p, BSTR, v)
    get_overflowX(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    put_overflowY(v)
      => ComCall(63, this.p, BSTR, v)
    get_overflowY(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    put_accelerator(v)
      => ComCall(65, this.p, BSTR, v)
    get_accelerator(p)
      => ComCall(66, this.p, BSTR.Ptr, p)
}
struct IHTMLRuleStyle3 extends IDispatch {
    static IID := "{3050F657-98B5-11CF-BB82-00AA00BDCE0B}"
    put_layoutFlow(v)
      => ComCall(7, this.p, BSTR, v)
    get_layoutFlow(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_zoom(v)
      => ComCall(9, this.p, VARIANT, v)
    get_zoom(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_wordWrap(v)
      => ComCall(11, this.p, BSTR, v)
    get_wordWrap(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_textUnderlinePosition(v)
      => ComCall(13, this.p, BSTR, v)
    get_textUnderlinePosition(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_scrollbarBaseColor(v)
      => ComCall(15, this.p, VARIANT, v)
    get_scrollbarBaseColor(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_scrollbarFaceColor(v)
      => ComCall(17, this.p, VARIANT, v)
    get_scrollbarFaceColor(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_scrollbar3dLightColor(v)
      => ComCall(19, this.p, VARIANT, v)
    get_scrollbar3dLightColor(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_scrollbarShadowColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_scrollbarShadowColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_scrollbarHighlightColor(v)
      => ComCall(23, this.p, VARIANT, v)
    get_scrollbarHighlightColor(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_scrollbarDarkShadowColor(v)
      => ComCall(25, this.p, VARIANT, v)
    get_scrollbarDarkShadowColor(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_scrollbarArrowColor(v)
      => ComCall(27, this.p, VARIANT, v)
    get_scrollbarArrowColor(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_scrollbarTrackColor(v)
      => ComCall(29, this.p, VARIANT, v)
    get_scrollbarTrackColor(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_writingMode(v)
      => ComCall(31, this.p, BSTR, v)
    get_writingMode(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_textAlignLast(v)
      => ComCall(33, this.p, BSTR, v)
    get_textAlignLast(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_textKashidaSpace(v)
      => ComCall(35, this.p, VARIANT, v)
    get_textKashidaSpace(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
}
struct IHTMLRuleStyle4 extends IDispatch {
    static IID := "{3050F817-98B5-11CF-BB82-00AA00BDCE0B}"
    put_textOverflow(v)
      => ComCall(7, this.p, BSTR, v)
    get_textOverflow(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_minHeight(v)
      => ComCall(9, this.p, VARIANT, v)
    get_minHeight(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLRuleStyle5 extends IDispatch {
    static IID := "{3050F335-98B5-11CF-BB82-00AA00BDCE0B}"
    put_msInterpolationMode(v)
      => ComCall(7, this.p, BSTR, v)
    get_msInterpolationMode(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_maxHeight(v)
      => ComCall(9, this.p, VARIANT, v)
    get_maxHeight(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_minWidth(v)
      => ComCall(11, this.p, VARIANT, v)
    get_minWidth(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_maxWidth(v)
      => ComCall(13, this.p, VARIANT, v)
    get_maxWidth(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
}
struct IHTMLRuleStyle6 extends IDispatch {
    static IID := "{30510471-98B5-11CF-BB82-00AA00BDCE0B}"
    put_content(v)
      => ComCall(7, this.p, BSTR, v)
    get_content(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_captionSide(v)
      => ComCall(9, this.p, BSTR, v)
    get_captionSide(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_counterIncrement(v)
      => ComCall(11, this.p, BSTR, v)
    get_counterIncrement(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_counterReset(v)
      => ComCall(13, this.p, BSTR, v)
    get_counterReset(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_outline(v)
      => ComCall(15, this.p, BSTR, v)
    get_outline(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_outlineWidth(v)
      => ComCall(17, this.p, VARIANT, v)
    get_outlineWidth(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_outlineStyle(v)
      => ComCall(19, this.p, BSTR, v)
    get_outlineStyle(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_outlineColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_outlineColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_boxSizing(v)
      => ComCall(23, this.p, BSTR, v)
    get_boxSizing(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_borderSpacing(v)
      => ComCall(25, this.p, BSTR, v)
    get_borderSpacing(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_orphans(v)
      => ComCall(27, this.p, VARIANT, v)
    get_orphans(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_widows(v)
      => ComCall(29, this.p, VARIANT, v)
    get_widows(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_pageBreakInside(v)
      => ComCall(31, this.p, BSTR, v)
    get_pageBreakInside(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_emptyCells(v)
      => ComCall(33, this.p, BSTR, v)
    get_emptyCells(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_msBlockProgression(v)
      => ComCall(35, this.p, BSTR, v)
    get_msBlockProgression(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_quotes(v)
      => ComCall(37, this.p, BSTR, v)
    get_quotes(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
}
struct DispHTMLStyle extends IDispatch {
    static IID := "{3050F55A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLRuleStyle extends IDispatch {
    static IID := "{3050F55C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetRulesCollection extends IDispatch {
    static IID := "{3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppHTMLStyleSheetRule)
      => ComCall(8, this.p, Int32, index, IHTMLStyleSheetRule.Ptr, ppHTMLStyleSheetRule)
}
struct IHTMLStyleSheet extends IDispatch {
    static IID := "{3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_title(v)
      => ComCall(7, this.p, BSTR, v)
    get_title(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_parentStyleSheet(p)
      => ComCall(9, this.p, IHTMLStyleSheet.Ptr, p)
    get_owningElement(p)
      => ComCall(10, this.p, IHTMLElement.Ptr, p)
    put_disabled(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    get_readOnly(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    get_imports(p)
      => ComCall(14, this.p, IHTMLStyleSheetsCollection.Ptr, p)
    put_href(v)
      => ComCall(15, this.p, BSTR, v)
    get_href(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    get_type(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_id(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    addImport(bstrURL, lIndex, plIndex)
      => ComCall(19, this.p, BSTR, bstrURL, Int32, lIndex, Int32.Ptr, plIndex)
    addRule(bstrSelector, bstrStyle, lIndex, plNewIndex)
      => ComCall(20, this.p, BSTR, bstrSelector, BSTR, bstrStyle, Int32, lIndex, Int32.Ptr, plNewIndex)
    removeImport(lIndex)
      => ComCall(21, this.p, Int32, lIndex)
    removeRule(lIndex)
      => ComCall(22, this.p, Int32, lIndex)
    put_media(v)
      => ComCall(23, this.p, BSTR, v)
    get_media(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_cssText(v)
      => ComCall(25, this.p, BSTR, v)
    get_cssText(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    get_rules(p)
      => ComCall(27, this.p, IHTMLStyleSheetRulesCollection.Ptr, p)
}
struct IHTMLCSSRule extends IDispatch {
    static IID := "{305106E9-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, UInt16.Ptr, p)
    put_cssText(v)
      => ComCall(8, this.p, BSTR, v)
    get_cssText(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_parentRule(p)
      => ComCall(10, this.p, IHTMLCSSRule.Ptr, p)
    get_parentStyleSheet(p)
      => ComCall(11, this.p, IHTMLStyleSheet.Ptr, p)
}
struct IHTMLCSSImportRule extends IDispatch {
    static IID := "{305106EA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_href(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_media(v)
      => ComCall(8, this.p, VARIANT, v)
    get_media(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_styleSheet(p)
      => ComCall(10, this.p, IHTMLStyleSheet.Ptr, p)
}
struct IHTMLCSSMediaRule extends IDispatch {
    static IID := "{305106EB-98B5-11CF-BB82-00AA00BDCE0B}"
    put_media(v)
      => ComCall(7, this.p, VARIANT, v)
    get_media(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_cssRules(p)
      => ComCall(9, this.p, IHTMLStyleSheetRulesCollection.Ptr, p)
    insertRule(bstrRule, lIndex, plNewIndex)
      => ComCall(10, this.p, BSTR, bstrRule, Int32, lIndex, Int32.Ptr, plNewIndex)
    deleteRule(lIndex)
      => ComCall(11, this.p, Int32, lIndex)
}
struct IHTMLCSSMediaList extends IDispatch {
    static IID := "{30510731-98B5-11CF-BB82-00AA00BDCE0B}"
    put_mediaText(v)
      => ComCall(7, this.p, BSTR, v)
    get_mediaText(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_length(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    item(index, pbstrMedium)
      => ComCall(10, this.p, Int32, index, BSTR.Ptr, pbstrMedium)
    appendMedium(bstrMedium)
      => ComCall(11, this.p, BSTR, bstrMedium)
    deleteMedium(bstrMedium)
      => ComCall(12, this.p, BSTR, bstrMedium)
}
struct IHTMLCSSNamespaceRule extends IDispatch {
    static IID := "{305106EE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_namespaceURI(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_prefix(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLMSCSSKeyframeRule extends IDispatch {
    static IID := "{3051080C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_keyText(v)
      => ComCall(7, this.p, BSTR, v)
    get_keyText(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_style(p)
      => ComCall(9, this.p, IHTMLRuleStyle.Ptr, p)
}
struct IHTMLMSCSSKeyframesRule extends IDispatch {
    static IID := "{3051080D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_name(v)
      => ComCall(7, this.p, BSTR, v)
    get_name(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_cssRules(p)
      => ComCall(9, this.p, IHTMLStyleSheetRulesCollection.Ptr, p)
    appendRule(bstrRule)
      => ComCall(10, this.p, BSTR, bstrRule)
    deleteRule(bstrKey)
      => ComCall(11, this.p, BSTR, bstrKey)
    findRule(bstrKey, ppMSKeyframeRule)
      => ComCall(12, this.p, BSTR, bstrKey, IHTMLMSCSSKeyframeRule.Ptr, ppMSKeyframeRule)
}
struct DispHTMLCSSRule extends IDispatch {
    static IID := "{3059007D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLCSSImportRule extends IDispatch {
    static IID := "{3059007E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLCSSMediaRule extends IDispatch {
    static IID := "{3059007F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLCSSMediaList extends IDispatch {
    static IID := "{30590097-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLCSSNamespaceRule extends IDispatch {
    static IID := "{30590080-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLMSCSSKeyframeRule extends IDispatch {
    static IID := "{305900DE-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLMSCSSKeyframesRule extends IDispatch {
    static IID := "{305900DF-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLRenderStyle extends IDispatch {
    static IID := "{3050F6AE-98B5-11CF-BB82-00AA00BDCE0B}"
    put_textLineThroughStyle(v)
      => ComCall(7, this.p, BSTR, v)
    get_textLineThroughStyle(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_textUnderlineStyle(v)
      => ComCall(9, this.p, BSTR, v)
    get_textUnderlineStyle(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_textEffect(v)
      => ComCall(11, this.p, BSTR, v)
    get_textEffect(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_textColor(v)
      => ComCall(13, this.p, VARIANT, v)
    get_textColor(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_textBackgroundColor(v)
      => ComCall(15, this.p, VARIANT, v)
    get_textBackgroundColor(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_textDecorationColor(v)
      => ComCall(17, this.p, VARIANT, v)
    get_textDecorationColor(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_renderingPriority(v)
      => ComCall(19, this.p, Int32, v)
    get_renderingPriority(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    put_defaultTextSelection(v)
      => ComCall(21, this.p, BSTR, v)
    get_defaultTextSelection(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_textDecoration(v)
      => ComCall(23, this.p, BSTR, v)
    get_textDecoration(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
}
struct DispHTMLRenderStyle extends IDispatch {
    static IID := "{3050F58B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLCurrentStyle extends IDispatch {
    static IID := "{3050F3DB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_position(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_styleFloat(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_color(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_backgroundColor(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    get_fontFamily(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    get_fontStyle(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_fontVariant(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_fontWeight(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    get_fontSize(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    get_backgroundImage(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    get_backgroundPositionX(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    get_backgroundPositionY(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    get_backgroundRepeat(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    get_borderLeftColor(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    get_borderTopColor(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    get_borderRightColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    get_borderBottomColor(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    get_borderTopStyle(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    get_borderRightStyle(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
    get_borderBottomStyle(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    get_borderLeftStyle(p)
      => ComCall(27, this.p, BSTR.Ptr, p)
    get_borderTopWidth(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    get_borderRightWidth(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    get_borderBottomWidth(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    get_borderLeftWidth(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    get_left(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    get_top(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    get_width(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    get_height(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    get_paddingLeft(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    get_paddingTop(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    get_paddingRight(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    get_paddingBottom(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    get_textAlign(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    get_textDecoration(p)
      => ComCall(41, this.p, BSTR.Ptr, p)
    get_display(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    get_visibility(p)
      => ComCall(43, this.p, BSTR.Ptr, p)
    get_zIndex(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    get_letterSpacing(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    get_lineHeight(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    get_textIndent(p)
      => ComCall(47, this.p, VARIANT.Ptr, p)
    get_verticalAlign(p)
      => ComCall(48, this.p, VARIANT.Ptr, p)
    get_backgroundAttachment(p)
      => ComCall(49, this.p, BSTR.Ptr, p)
    get_marginTop(p)
      => ComCall(50, this.p, VARIANT.Ptr, p)
    get_marginRight(p)
      => ComCall(51, this.p, VARIANT.Ptr, p)
    get_marginBottom(p)
      => ComCall(52, this.p, VARIANT.Ptr, p)
    get_marginLeft(p)
      => ComCall(53, this.p, VARIANT.Ptr, p)
    get_clear(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    get_listStyleType(p)
      => ComCall(55, this.p, BSTR.Ptr, p)
    get_listStylePosition(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    get_listStyleImage(p)
      => ComCall(57, this.p, BSTR.Ptr, p)
    get_clipTop(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    get_clipRight(p)
      => ComCall(59, this.p, VARIANT.Ptr, p)
    get_clipBottom(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    get_clipLeft(p)
      => ComCall(61, this.p, VARIANT.Ptr, p)
    get_overflow(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    get_pageBreakBefore(p)
      => ComCall(63, this.p, BSTR.Ptr, p)
    get_pageBreakAfter(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    get_cursor(p)
      => ComCall(65, this.p, BSTR.Ptr, p)
    get_tableLayout(p)
      => ComCall(66, this.p, BSTR.Ptr, p)
    get_borderCollapse(p)
      => ComCall(67, this.p, BSTR.Ptr, p)
    get_direction(p)
      => ComCall(68, this.p, BSTR.Ptr, p)
    get_behavior(p)
      => ComCall(69, this.p, BSTR.Ptr, p)
    getAttribute(strAttributeName, lFlags, AttributeValue)
      => ComCall(70, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT.Ptr, AttributeValue)
    get_unicodeBidi(p)
      => ComCall(71, this.p, BSTR.Ptr, p)
    get_right(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    get_bottom(p)
      => ComCall(73, this.p, VARIANT.Ptr, p)
    get_imeMode(p)
      => ComCall(74, this.p, BSTR.Ptr, p)
    get_rubyAlign(p)
      => ComCall(75, this.p, BSTR.Ptr, p)
    get_rubyPosition(p)
      => ComCall(76, this.p, BSTR.Ptr, p)
    get_rubyOverhang(p)
      => ComCall(77, this.p, BSTR.Ptr, p)
    get_textAutospace(p)
      => ComCall(78, this.p, BSTR.Ptr, p)
    get_lineBreak(p)
      => ComCall(79, this.p, BSTR.Ptr, p)
    get_wordBreak(p)
      => ComCall(80, this.p, BSTR.Ptr, p)
    get_textJustify(p)
      => ComCall(81, this.p, BSTR.Ptr, p)
    get_textJustifyTrim(p)
      => ComCall(82, this.p, BSTR.Ptr, p)
    get_textKashida(p)
      => ComCall(83, this.p, VARIANT.Ptr, p)
    get_blockDirection(p)
      => ComCall(84, this.p, BSTR.Ptr, p)
    get_layoutGridChar(p)
      => ComCall(85, this.p, VARIANT.Ptr, p)
    get_layoutGridLine(p)
      => ComCall(86, this.p, VARIANT.Ptr, p)
    get_layoutGridMode(p)
      => ComCall(87, this.p, BSTR.Ptr, p)
    get_layoutGridType(p)
      => ComCall(88, this.p, BSTR.Ptr, p)
    get_borderStyle(p)
      => ComCall(89, this.p, BSTR.Ptr, p)
    get_borderColor(p)
      => ComCall(90, this.p, BSTR.Ptr, p)
    get_borderWidth(p)
      => ComCall(91, this.p, BSTR.Ptr, p)
    get_padding(p)
      => ComCall(92, this.p, BSTR.Ptr, p)
    get_margin(p)
      => ComCall(93, this.p, BSTR.Ptr, p)
    get_accelerator(p)
      => ComCall(94, this.p, BSTR.Ptr, p)
    get_overflowX(p)
      => ComCall(95, this.p, BSTR.Ptr, p)
    get_overflowY(p)
      => ComCall(96, this.p, BSTR.Ptr, p)
    get_textTransform(p)
      => ComCall(97, this.p, BSTR.Ptr, p)
}
struct IHTMLCurrentStyle2 extends IDispatch {
    static IID := "{3050F658-98B5-11CF-BB82-00AA00BDCE0B}"
    get_layoutFlow(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_wordWrap(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_textUnderlinePosition(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_hasLayout(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    get_scrollbarBaseColor(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_scrollbarFaceColor(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    get_scrollbar3dLightColor(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    get_scrollbarShadowColor(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    get_scrollbarHighlightColor(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    get_scrollbarDarkShadowColor(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    get_scrollbarArrowColor(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    get_scrollbarTrackColor(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    get_writingMode(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    get_zoom(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    get_filter(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    get_textAlignLast(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    get_textKashidaSpace(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    get_isBlock(p)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLCurrentStyle3 extends IDispatch {
    static IID := "{3050F818-98B5-11CF-BB82-00AA00BDCE0B}"
    get_textOverflow(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_minHeight(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_wordSpacing(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_whiteSpace(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLCurrentStyle4 extends IDispatch {
    static IID := "{3050F33B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_msInterpolationMode(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_maxHeight(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_minWidth(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_maxWidth(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLCurrentStyle5 extends IDispatch {
    static IID := "{30510481-98B5-11CF-BB82-00AA00BDCE0B}"
    get_captionSide(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_outline(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_outlineWidth(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_outlineStyle(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_outlineColor(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_boxSizing(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_borderSpacing(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_orphans(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    get_widows(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    get_pageBreakInside(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    get_emptyCells(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_msBlockProgression(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    get_quotes(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
}
struct DispHTMLCurrentStyle extends IDispatch {
    static IID := "{3050F557-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLElement extends IDispatch {
    static IID := "{3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}"
    setAttribute(strAttributeName, AttributeValue, lFlags)
      => ComCall(7, this.p, BSTR, strAttributeName, VARIANT, AttributeValue, Int32, lFlags)
    getAttribute(strAttributeName, lFlags, AttributeValue)
      => ComCall(8, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT.Ptr, AttributeValue)
    removeAttribute(strAttributeName, lFlags, pfSuccess)
      => ComCall(9, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT_BOOL.Ptr, pfSuccess)
    put_className(v)
      => ComCall(10, this.p, BSTR, v)
    get_className(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_id(v)
      => ComCall(12, this.p, BSTR, v)
    get_id(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_tagName(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    get_parentElement(p)
      => ComCall(15, this.p, IHTMLElement.Ptr, p)
    get_style(p)
      => ComCall(16, this.p, IHTMLStyle.Ptr, p)
    put_onhelp(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onhelp(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_onclick(v)
      => ComCall(19, this.p, VARIANT, v)
    get_onclick(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_ondblclick(v)
      => ComCall(21, this.p, VARIANT, v)
    get_ondblclick(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onkeydown(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onkeydown(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onkeyup(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onkeyup(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_onkeypress(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onkeypress(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_onmouseout(v)
      => ComCall(29, this.p, VARIANT, v)
    get_onmouseout(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onmouseover(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onmouseover(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onmousemove(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onmousemove(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_onmousedown(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onmousedown(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_onmouseup(v)
      => ComCall(37, this.p, VARIANT, v)
    get_onmouseup(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    get_document(p)
      => ComCall(39, this.p, IDispatch.Ptr, p)
    put_title(v)
      => ComCall(40, this.p, BSTR, v)
    get_title(p)
      => ComCall(41, this.p, BSTR.Ptr, p)
    put_language(v)
      => ComCall(42, this.p, BSTR, v)
    get_language(p)
      => ComCall(43, this.p, BSTR.Ptr, p)
    put_onselectstart(v)
      => ComCall(44, this.p, VARIANT, v)
    get_onselectstart(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    scrollIntoView(varargStart)
      => ComCall(46, this.p, VARIANT, varargStart)
    contains(pChild, pfResult)
      => ComCall(47, this.p, IHTMLElement, pChild, VARIANT_BOOL.Ptr, pfResult)
    get_sourceIndex(p)
      => ComCall(48, this.p, Int32.Ptr, p)
    get_recordNumber(p)
      => ComCall(49, this.p, VARIANT.Ptr, p)
    put_lang(v)
      => ComCall(50, this.p, BSTR, v)
    get_lang(p)
      => ComCall(51, this.p, BSTR.Ptr, p)
    get_offsetLeft(p)
      => ComCall(52, this.p, Int32.Ptr, p)
    get_offsetTop(p)
      => ComCall(53, this.p, Int32.Ptr, p)
    get_offsetWidth(p)
      => ComCall(54, this.p, Int32.Ptr, p)
    get_offsetHeight(p)
      => ComCall(55, this.p, Int32.Ptr, p)
    get_offsetParent(p)
      => ComCall(56, this.p, IHTMLElement.Ptr, p)
    put_innerHTML(v)
      => ComCall(57, this.p, BSTR, v)
    get_innerHTML(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_innerText(v)
      => ComCall(59, this.p, BSTR, v)
    get_innerText(p)
      => ComCall(60, this.p, BSTR.Ptr, p)
    put_outerHTML(v)
      => ComCall(61, this.p, BSTR, v)
    get_outerHTML(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    put_outerText(v)
      => ComCall(63, this.p, BSTR, v)
    get_outerText(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    insertAdjacentHTML(where, html)
      => ComCall(65, this.p, BSTR, where, BSTR, html)
    insertAdjacentText(where, text)
      => ComCall(66, this.p, BSTR, where, BSTR, text)
    get_parentTextEdit(p)
      => ComCall(67, this.p, IHTMLElement.Ptr, p)
    get_isTextEdit(p)
      => ComCall(68, this.p, VARIANT_BOOL.Ptr, p)
    click()
      => ComCall(69, this.p)
    get_filters(p)
      => ComCall(70, this.p, IHTMLFiltersCollection.Ptr, p)
    put_ondragstart(v)
      => ComCall(71, this.p, VARIANT, v)
    get_ondragstart(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    toString(String)
      => ComCall(73, this.p, BSTR.Ptr, String)
    put_onbeforeupdate(v)
      => ComCall(74, this.p, VARIANT, v)
    get_onbeforeupdate(p)
      => ComCall(75, this.p, VARIANT.Ptr, p)
    put_onafterupdate(v)
      => ComCall(76, this.p, VARIANT, v)
    get_onafterupdate(p)
      => ComCall(77, this.p, VARIANT.Ptr, p)
    put_onerrorupdate(v)
      => ComCall(78, this.p, VARIANT, v)
    get_onerrorupdate(p)
      => ComCall(79, this.p, VARIANT.Ptr, p)
    put_onrowexit(v)
      => ComCall(80, this.p, VARIANT, v)
    get_onrowexit(p)
      => ComCall(81, this.p, VARIANT.Ptr, p)
    put_onrowenter(v)
      => ComCall(82, this.p, VARIANT, v)
    get_onrowenter(p)
      => ComCall(83, this.p, VARIANT.Ptr, p)
    put_ondatasetchanged(v)
      => ComCall(84, this.p, VARIANT, v)
    get_ondatasetchanged(p)
      => ComCall(85, this.p, VARIANT.Ptr, p)
    put_ondataavailable(v)
      => ComCall(86, this.p, VARIANT, v)
    get_ondataavailable(p)
      => ComCall(87, this.p, VARIANT.Ptr, p)
    put_ondatasetcomplete(v)
      => ComCall(88, this.p, VARIANT, v)
    get_ondatasetcomplete(p)
      => ComCall(89, this.p, VARIANT.Ptr, p)
    put_onfilterchange(v)
      => ComCall(90, this.p, VARIANT, v)
    get_onfilterchange(p)
      => ComCall(91, this.p, VARIANT.Ptr, p)
    get_children(p)
      => ComCall(92, this.p, IDispatch.Ptr, p)
    get_all(p)
      => ComCall(93, this.p, IDispatch.Ptr, p)
}
struct IHTMLRect extends IDispatch {
    static IID := "{3050F4A3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_left(v)
      => ComCall(7, this.p, Int32, v)
    get_left(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_top(v)
      => ComCall(9, this.p, Int32, v)
    get_top(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    put_right(v)
      => ComCall(11, this.p, Int32, v)
    get_right(p)
      => ComCall(12, this.p, Int32.Ptr, p)
    put_bottom(v)
      => ComCall(13, this.p, Int32, v)
    get_bottom(p)
      => ComCall(14, this.p, Int32.Ptr, p)
}
struct IHTMLRect2 extends IDispatch {
    static IID := "{3051076C-98B5-11CF-BB82-00AA00BDCE0B}"
    get_width(p)
      => ComCall(7, this.p, Float32.Ptr, p)
    get_height(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct IHTMLRectCollection extends IDispatch {
    static IID := "{3050F4A4-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(pvarIndex, pvarResult)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarResult)
}
struct IHTMLElementCollection extends IDispatch {
    static IID := "{3050F21F-98B5-11CF-BB82-00AA00BDCE0B}"
    toString(String)
      => ComCall(7, this.p, BSTR.Ptr, String)
    put_length(v)
      => ComCall(8, this.p, Int32, v)
    get_length(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(10, this.p, IUnknown.Ptr, p)
    item(name, index, pdisp)
      => ComCall(11, this.p, VARIANT, name, VARIANT, index, IDispatch.Ptr, pdisp)
    tags(tagName, pdisp)
      => ComCall(12, this.p, VARIANT, tagName, IDispatch.Ptr, pdisp)
}
struct IHTMLElement2 extends IDispatch {
    static IID := "{3050F434-98B5-11CF-BB82-00AA00BDCE0B}"
    get_scopeName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    setCapture(containerCapture)
      => ComCall(8, this.p, VARIANT_BOOL, containerCapture)
    releaseCapture()
      => ComCall(9, this.p)
    put_onlosecapture(v)
      => ComCall(10, this.p, VARIANT, v)
    get_onlosecapture(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    componentFromPoint(x, y, component)
      => ComCall(12, this.p, Int32, x, Int32, y, BSTR.Ptr, component)
    doScroll(component)
      => ComCall(13, this.p, VARIANT, component)
    put_onscroll(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onscroll(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_ondrag(v)
      => ComCall(16, this.p, VARIANT, v)
    get_ondrag(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    put_ondragend(v)
      => ComCall(18, this.p, VARIANT, v)
    get_ondragend(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    put_ondragenter(v)
      => ComCall(20, this.p, VARIANT, v)
    get_ondragenter(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_ondragover(v)
      => ComCall(22, this.p, VARIANT, v)
    get_ondragover(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_ondragleave(v)
      => ComCall(24, this.p, VARIANT, v)
    get_ondragleave(p)
      => ComCall(25, this.p, VARIANT.Ptr, p)
    put_ondrop(v)
      => ComCall(26, this.p, VARIANT, v)
    get_ondrop(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_onbeforecut(v)
      => ComCall(28, this.p, VARIANT, v)
    get_onbeforecut(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    put_oncut(v)
      => ComCall(30, this.p, VARIANT, v)
    get_oncut(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    put_onbeforecopy(v)
      => ComCall(32, this.p, VARIANT, v)
    get_onbeforecopy(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    put_oncopy(v)
      => ComCall(34, this.p, VARIANT, v)
    get_oncopy(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    put_onbeforepaste(v)
      => ComCall(36, this.p, VARIANT, v)
    get_onbeforepaste(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    put_onpaste(v)
      => ComCall(38, this.p, VARIANT, v)
    get_onpaste(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    get_currentStyle(p)
      => ComCall(40, this.p, IHTMLCurrentStyle.Ptr, p)
    put_onpropertychange(v)
      => ComCall(41, this.p, VARIANT, v)
    get_onpropertychange(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    getClientRects(pRectCol)
      => ComCall(43, this.p, IHTMLRectCollection.Ptr, pRectCol)
    getBoundingClientRect(pRect)
      => ComCall(44, this.p, IHTMLRect.Ptr, pRect)
    setExpression(propname, expression, language)
      => ComCall(45, this.p, BSTR, propname, BSTR, expression, BSTR, language)
    getExpression(propname, expression)
      => ComCall(46, this.p, BSTR, propname, VARIANT.Ptr, expression)
    removeExpression(propname, pfSuccess)
      => ComCall(47, this.p, BSTR, propname, VARIANT_BOOL.Ptr, pfSuccess)
    put_tabIndex(v)
      => ComCall(48, this.p, Int16, v)
    get_tabIndex(p)
      => ComCall(49, this.p, Int16.Ptr, p)
    focus()
      => ComCall(50, this.p)
    put_accessKey(v)
      => ComCall(51, this.p, BSTR, v)
    get_accessKey(p)
      => ComCall(52, this.p, BSTR.Ptr, p)
    put_onblur(v)
      => ComCall(53, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(54, this.p, VARIANT.Ptr, p)
    put_onfocus(v)
      => ComCall(55, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(56, this.p, VARIANT.Ptr, p)
    put_onresize(v)
      => ComCall(57, this.p, VARIANT, v)
    get_onresize(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    blur()
      => ComCall(59, this.p)
    addFilter(pUnk)
      => ComCall(60, this.p, IUnknown, pUnk)
    removeFilter(pUnk)
      => ComCall(61, this.p, IUnknown, pUnk)
    get_clientHeight(p)
      => ComCall(62, this.p, Int32.Ptr, p)
    get_clientWidth(p)
      => ComCall(63, this.p, Int32.Ptr, p)
    get_clientTop(p)
      => ComCall(64, this.p, Int32.Ptr, p)
    get_clientLeft(p)
      => ComCall(65, this.p, Int32.Ptr, p)
    attachEvent(event, pDisp, pfResult)
      => ComCall(66, this.p, BSTR, event, IDispatch, pDisp, VARIANT_BOOL.Ptr, pfResult)
    detachEvent(event, pDisp)
      => ComCall(67, this.p, BSTR, event, IDispatch, pDisp)
    get_readyState(p)
      => ComCall(68, this.p, VARIANT.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(69, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_onrowsdelete(v)
      => ComCall(71, this.p, VARIANT, v)
    get_onrowsdelete(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    put_onrowsinserted(v)
      => ComCall(73, this.p, VARIANT, v)
    get_onrowsinserted(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_oncellchange(v)
      => ComCall(75, this.p, VARIANT, v)
    get_oncellchange(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_dir(v)
      => ComCall(77, this.p, BSTR, v)
    get_dir(p)
      => ComCall(78, this.p, BSTR.Ptr, p)
    createControlRange(range)
      => ComCall(79, this.p, IDispatch.Ptr, range)
    get_scrollHeight(p)
      => ComCall(80, this.p, Int32.Ptr, p)
    get_scrollWidth(p)
      => ComCall(81, this.p, Int32.Ptr, p)
    put_scrollTop(v)
      => ComCall(82, this.p, Int32, v)
    get_scrollTop(p)
      => ComCall(83, this.p, Int32.Ptr, p)
    put_scrollLeft(v)
      => ComCall(84, this.p, Int32, v)
    get_scrollLeft(p)
      => ComCall(85, this.p, Int32.Ptr, p)
    clearAttributes()
      => ComCall(86, this.p)
    mergeAttributes(mergeThis)
      => ComCall(87, this.p, IHTMLElement, mergeThis)
    put_oncontextmenu(v)
      => ComCall(88, this.p, VARIANT, v)
    get_oncontextmenu(p)
      => ComCall(89, this.p, VARIANT.Ptr, p)
    insertAdjacentElement(where, insertedElement, inserted)
      => ComCall(90, this.p, BSTR, where, IHTMLElement, insertedElement, IHTMLElement.Ptr, inserted)
    applyElement(apply, where, applied)
      => ComCall(91, this.p, IHTMLElement, apply, BSTR, where, IHTMLElement.Ptr, applied)
    getAdjacentText(where, text)
      => ComCall(92, this.p, BSTR, where, BSTR.Ptr, text)
    replaceAdjacentText(where, newText, oldText)
      => ComCall(93, this.p, BSTR, where, BSTR, newText, BSTR.Ptr, oldText)
    get_canHaveChildren(p)
      => ComCall(94, this.p, VARIANT_BOOL.Ptr, p)
    addBehavior(bstrUrl, pvarFactory, pCookie)
      => ComCall(95, this.p, BSTR, bstrUrl, VARIANT.Ptr, pvarFactory, Int32.Ptr, pCookie)
    removeBehavior(cookie, pfResult)
      => ComCall(96, this.p, Int32, cookie, VARIANT_BOOL.Ptr, pfResult)
    get_runtimeStyle(p)
      => ComCall(97, this.p, IHTMLStyle.Ptr, p)
    get_behaviorUrns(p)
      => ComCall(98, this.p, IDispatch.Ptr, p)
    put_tagUrn(v)
      => ComCall(99, this.p, BSTR, v)
    get_tagUrn(p)
      => ComCall(100, this.p, BSTR.Ptr, p)
    put_onbeforeeditfocus(v)
      => ComCall(101, this.p, VARIANT, v)
    get_onbeforeeditfocus(p)
      => ComCall(102, this.p, VARIANT.Ptr, p)
    get_readyStateValue(p)
      => ComCall(103, this.p, Int32.Ptr, p)
    getElementsByTagName(v, pelColl)
      => ComCall(104, this.p, BSTR, v, IHTMLElementCollection.Ptr, pelColl)
}
struct IHTMLAttributeCollection3 extends IDispatch {
    static IID := "{30510469-98B5-11CF-BB82-00AA00BDCE0B}"
    getNamedItem(bstrName, ppNodeOut)
      => ComCall(7, this.p, BSTR, bstrName, IHTMLDOMAttribute.Ptr, ppNodeOut)
    setNamedItem(pNodeIn, ppNodeOut)
      => ComCall(8, this.p, IHTMLDOMAttribute, pNodeIn, IHTMLDOMAttribute.Ptr, ppNodeOut)
    removeNamedItem(bstrName, ppNodeOut)
      => ComCall(9, this.p, BSTR, bstrName, IHTMLDOMAttribute.Ptr, ppNodeOut)
    item(index, ppNodeOut)
      => ComCall(10, this.p, Int32, index, IHTMLDOMAttribute.Ptr, ppNodeOut)
    get_length(p)
      => ComCall(11, this.p, Int32.Ptr, p)
}
struct IDOMDocumentType extends IDispatch {
    static IID := "{30510738-98B5-11CF-BB82-00AA00BDCE0B}"
    get_name(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_entities(p)
      => ComCall(8, this.p, IDispatch.Ptr, p)
    get_notations(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_publicId(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    get_systemId(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_internalSubset(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
}
struct IHTMLDocument7 extends IDispatch {
    static IID := "{305104B8-98B5-11CF-BB82-00AA00BDCE0B}"
    get_defaultView(p)
      => ComCall(7, this.p, IHTMLWindow2.Ptr, p)
    createCDATASection(text, newCDATASectionNode)
      => ComCall(8, this.p, BSTR, text, IHTMLDOMNode.Ptr, newCDATASectionNode)
    getSelection(ppIHTMLSelection)
      => ComCall(9, this.p, IHTMLSelection.Ptr, ppIHTMLSelection)
    getElementsByTagNameNS(pvarNS, bstrLocalName, pelColl)
      => ComCall(10, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrLocalName, IHTMLElementCollection.Ptr, pelColl)
    createElementNS(pvarNS, bstrTag, newElem)
      => ComCall(11, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrTag, IHTMLElement.Ptr, newElem)
    createAttributeNS(pvarNS, bstrAttrName, ppAttribute)
      => ComCall(12, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrAttrName, IHTMLDOMAttribute.Ptr, ppAttribute)
    put_onmsthumbnailclick(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onmsthumbnailclick(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    get_characterSet(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    createElement(bstrTag, newElem)
      => ComCall(16, this.p, BSTR, bstrTag, IHTMLElement.Ptr, newElem)
    createAttribute(bstrAttrName, ppAttribute)
      => ComCall(17, this.p, BSTR, bstrAttrName, IHTMLDOMAttribute.Ptr, ppAttribute)
    getElementsByClassName(v, pel)
      => ComCall(18, this.p, BSTR, v, IHTMLElementCollection.Ptr, pel)
    createProcessingInstruction(bstrTarget, bstrData, newProcessingInstruction)
      => ComCall(19, this.p, BSTR, bstrTarget, BSTR, bstrData, IDOMProcessingInstruction.Ptr, newProcessingInstruction)
    adoptNode(pNodeSource, ppNodeDest)
      => ComCall(20, this.p, IHTMLDOMNode, pNodeSource, IHTMLDOMNode3.Ptr, ppNodeDest)
    put_onmssitemodejumplistitemremoved(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onmssitemodejumplistitemremoved(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    get_all(p)
      => ComCall(23, this.p, IHTMLElementCollection.Ptr, p)
    get_inputEncoding(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    get_xmlEncoding(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
    put_xmlStandalone(v)
      => ComCall(26, this.p, VARIANT_BOOL, v)
    get_xmlStandalone(p)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, p)
    put_xmlVersion(v)
      => ComCall(28, this.p, BSTR, v)
    get_xmlVersion(p)
      => ComCall(29, this.p, BSTR.Ptr, p)
    hasAttributes(pfHasAttributes)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, pfHasAttributes)
    put_onabort(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onblur(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_oncanplay(v)
      => ComCall(35, this.p, VARIANT, v)
    get_oncanplay(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_oncanplaythrough(v)
      => ComCall(37, this.p, VARIANT, v)
    get_oncanplaythrough(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_onchange(v)
      => ComCall(39, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_ondrag(v)
      => ComCall(41, this.p, VARIANT, v)
    get_ondrag(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    put_ondragend(v)
      => ComCall(43, this.p, VARIANT, v)
    get_ondragend(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    put_ondragenter(v)
      => ComCall(45, this.p, VARIANT, v)
    get_ondragenter(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    put_ondragleave(v)
      => ComCall(47, this.p, VARIANT, v)
    get_ondragleave(p)
      => ComCall(48, this.p, VARIANT.Ptr, p)
    put_ondragover(v)
      => ComCall(49, this.p, VARIANT, v)
    get_ondragover(p)
      => ComCall(50, this.p, VARIANT.Ptr, p)
    put_ondrop(v)
      => ComCall(51, this.p, VARIANT, v)
    get_ondrop(p)
      => ComCall(52, this.p, VARIANT.Ptr, p)
    put_ondurationchange(v)
      => ComCall(53, this.p, VARIANT, v)
    get_ondurationchange(p)
      => ComCall(54, this.p, VARIANT.Ptr, p)
    put_onemptied(v)
      => ComCall(55, this.p, VARIANT, v)
    get_onemptied(p)
      => ComCall(56, this.p, VARIANT.Ptr, p)
    put_onended(v)
      => ComCall(57, this.p, VARIANT, v)
    get_onended(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(59, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    put_onfocus(v)
      => ComCall(61, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(62, this.p, VARIANT.Ptr, p)
    put_oninput(v)
      => ComCall(63, this.p, VARIANT, v)
    get_oninput(p)
      => ComCall(64, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(65, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(66, this.p, VARIANT.Ptr, p)
    put_onloadeddata(v)
      => ComCall(67, this.p, VARIANT, v)
    get_onloadeddata(p)
      => ComCall(68, this.p, VARIANT.Ptr, p)
    put_onloadedmetadata(v)
      => ComCall(69, this.p, VARIANT, v)
    get_onloadedmetadata(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_onloadstart(v)
      => ComCall(71, this.p, VARIANT, v)
    get_onloadstart(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    put_onpause(v)
      => ComCall(73, this.p, VARIANT, v)
    get_onpause(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_onplay(v)
      => ComCall(75, this.p, VARIANT, v)
    get_onplay(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_onplaying(v)
      => ComCall(77, this.p, VARIANT, v)
    get_onplaying(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_onprogress(v)
      => ComCall(79, this.p, VARIANT, v)
    get_onprogress(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_onratechange(v)
      => ComCall(81, this.p, VARIANT, v)
    get_onratechange(p)
      => ComCall(82, this.p, VARIANT.Ptr, p)
    put_onreset(v)
      => ComCall(83, this.p, VARIANT, v)
    get_onreset(p)
      => ComCall(84, this.p, VARIANT.Ptr, p)
    put_onscroll(v)
      => ComCall(85, this.p, VARIANT, v)
    get_onscroll(p)
      => ComCall(86, this.p, VARIANT.Ptr, p)
    put_onseeked(v)
      => ComCall(87, this.p, VARIANT, v)
    get_onseeked(p)
      => ComCall(88, this.p, VARIANT.Ptr, p)
    put_onseeking(v)
      => ComCall(89, this.p, VARIANT, v)
    get_onseeking(p)
      => ComCall(90, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(91, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(92, this.p, VARIANT.Ptr, p)
    put_onstalled(v)
      => ComCall(93, this.p, VARIANT, v)
    get_onstalled(p)
      => ComCall(94, this.p, VARIANT.Ptr, p)
    put_onsubmit(v)
      => ComCall(95, this.p, VARIANT, v)
    get_onsubmit(p)
      => ComCall(96, this.p, VARIANT.Ptr, p)
    put_onsuspend(v)
      => ComCall(97, this.p, VARIANT, v)
    get_onsuspend(p)
      => ComCall(98, this.p, VARIANT.Ptr, p)
    put_ontimeupdate(v)
      => ComCall(99, this.p, VARIANT, v)
    get_ontimeupdate(p)
      => ComCall(100, this.p, VARIANT.Ptr, p)
    put_onvolumechange(v)
      => ComCall(101, this.p, VARIANT, v)
    get_onvolumechange(p)
      => ComCall(102, this.p, VARIANT.Ptr, p)
    put_onwaiting(v)
      => ComCall(103, this.p, VARIANT, v)
    get_onwaiting(p)
      => ComCall(104, this.p, VARIANT.Ptr, p)
    normalize()
      => ComCall(105, this.p)
    importNode(pNodeSource, fDeep, ppNodeDest)
      => ComCall(106, this.p, IHTMLDOMNode, pNodeSource, VARIANT_BOOL, fDeep, IHTMLDOMNode3.Ptr, ppNodeDest)
    get_parentWindow(p)
      => ComCall(107, this.p, IHTMLWindow2.Ptr, p)
    putref_body(v)
      => ComCall(108, this.p, IHTMLElement, v)
    get_body(p)
      => ComCall(109, this.p, IHTMLElement.Ptr, p)
    get_head(p)
      => ComCall(110, this.p, IHTMLElement.Ptr, p)
}
struct IHTMLDOMNode extends IDispatch {
    static IID := "{3050F5DA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_nodeType(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_parentNode(p)
      => ComCall(8, this.p, IHTMLDOMNode.Ptr, p)
    hasChildNodes(fChildren)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, fChildren)
    get_childNodes(p)
      => ComCall(10, this.p, IDispatch.Ptr, p)
    get_attributes(p)
      => ComCall(11, this.p, IDispatch.Ptr, p)
    insertBefore(newChild, refChild, node)
      => ComCall(12, this.p, IHTMLDOMNode, newChild, VARIANT, refChild, IHTMLDOMNode.Ptr, node)
    removeChild(oldChild, node)
      => ComCall(13, this.p, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    replaceChild(newChild, oldChild, node)
      => ComCall(14, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    cloneNode(fDeep, clonedNode)
      => ComCall(15, this.p, VARIANT_BOOL, fDeep, IHTMLDOMNode.Ptr, clonedNode)
    removeNode(fDeep, removed)
      => ComCall(16, this.p, VARIANT_BOOL, fDeep, IHTMLDOMNode.Ptr, removed)
    swapNode(otherNode, swappedNode)
      => ComCall(17, this.p, IHTMLDOMNode, otherNode, IHTMLDOMNode.Ptr, swappedNode)
    replaceNode(replacement, replaced)
      => ComCall(18, this.p, IHTMLDOMNode, replacement, IHTMLDOMNode.Ptr, replaced)
    appendChild(newChild, node)
      => ComCall(19, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode.Ptr, node)
    get_nodeName(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_nodeValue(v)
      => ComCall(21, this.p, VARIANT, v)
    get_nodeValue(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    get_firstChild(p)
      => ComCall(23, this.p, IHTMLDOMNode.Ptr, p)
    get_lastChild(p)
      => ComCall(24, this.p, IHTMLDOMNode.Ptr, p)
    get_previousSibling(p)
      => ComCall(25, this.p, IHTMLDOMNode.Ptr, p)
    get_nextSibling(p)
      => ComCall(26, this.p, IHTMLDOMNode.Ptr, p)
}
struct IHTMLDOMNode2 extends IDispatch {
    static IID := "{3050F80B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_ownerDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
}
struct IHTMLDOMNode3 extends IDispatch {
    static IID := "{305106E0-98B5-11CF-BB82-00AA00BDCE0B}"
    put_prefix(v)
      => ComCall(7, this.p, VARIANT, v)
    get_prefix(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_localName(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_namespaceURI(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_textContent(v)
      => ComCall(11, this.p, VARIANT, v)
    get_textContent(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    isEqualNode(otherNode, isEqual)
      => ComCall(13, this.p, IHTMLDOMNode3, otherNode, VARIANT_BOOL.Ptr, isEqual)
    lookupNamespaceURI(pvarPrefix, pvarNamespaceURI)
      => ComCall(14, this.p, VARIANT.Ptr, pvarPrefix, VARIANT.Ptr, pvarNamespaceURI)
    lookupPrefix(pvarNamespaceURI, pvarPrefix)
      => ComCall(15, this.p, VARIANT.Ptr, pvarNamespaceURI, VARIANT.Ptr, pvarPrefix)
    isDefaultNamespace(pvarNamespace, pfDefaultNamespace)
      => ComCall(16, this.p, VARIANT.Ptr, pvarNamespace, VARIANT_BOOL.Ptr, pfDefaultNamespace)
    appendChild(newChild, node)
      => ComCall(17, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode.Ptr, node)
    insertBefore(newChild, refChild, node)
      => ComCall(18, this.p, IHTMLDOMNode, newChild, VARIANT, refChild, IHTMLDOMNode.Ptr, node)
    removeChild(oldChild, node)
      => ComCall(19, this.p, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    replaceChild(newChild, oldChild, node)
      => ComCall(20, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    isSameNode(otherNode, isSame)
      => ComCall(21, this.p, IHTMLDOMNode3, otherNode, VARIANT_BOOL.Ptr, isSame)
    compareDocumentPosition(otherNode, flags)
      => ComCall(22, this.p, IHTMLDOMNode, otherNode, UInt16.Ptr, flags)
    isSupported(feature, version, pfisSupported)
      => ComCall(23, this.p, BSTR, feature, VARIANT, version, VARIANT_BOOL.Ptr, pfisSupported)
}
struct IHTMLDOMAttribute extends IDispatch {
    static IID := "{3050F4B0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_nodeName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_nodeValue(v)
      => ComCall(8, this.p, VARIANT, v)
    get_nodeValue(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_specified(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLDOMAttribute2 extends IDispatch {
    static IID := "{3050F810-98B5-11CF-BB82-00AA00BDCE0B}"
    get_name(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_expando(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    get_nodeType(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    get_parentNode(p)
      => ComCall(12, this.p, IHTMLDOMNode.Ptr, p)
    get_childNodes(p)
      => ComCall(13, this.p, IDispatch.Ptr, p)
    get_firstChild(p)
      => ComCall(14, this.p, IHTMLDOMNode.Ptr, p)
    get_lastChild(p)
      => ComCall(15, this.p, IHTMLDOMNode.Ptr, p)
    get_previousSibling(p)
      => ComCall(16, this.p, IHTMLDOMNode.Ptr, p)
    get_nextSibling(p)
      => ComCall(17, this.p, IHTMLDOMNode.Ptr, p)
    get_attributes(p)
      => ComCall(18, this.p, IDispatch.Ptr, p)
    get_ownerDocument(p)
      => ComCall(19, this.p, IDispatch.Ptr, p)
    insertBefore(newChild, refChild, node)
      => ComCall(20, this.p, IHTMLDOMNode, newChild, VARIANT, refChild, IHTMLDOMNode.Ptr, node)
    replaceChild(newChild, oldChild, node)
      => ComCall(21, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    removeChild(oldChild, node)
      => ComCall(22, this.p, IHTMLDOMNode, oldChild, IHTMLDOMNode.Ptr, node)
    appendChild(newChild, node)
      => ComCall(23, this.p, IHTMLDOMNode, newChild, IHTMLDOMNode.Ptr, node)
    hasChildNodes(fChildren)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, fChildren)
    cloneNode(fDeep, clonedNode)
      => ComCall(25, this.p, VARIANT_BOOL, fDeep, IHTMLDOMAttribute.Ptr, clonedNode)
}
struct IHTMLDOMAttribute3 extends IDispatch {
    static IID := "{30510468-98B5-11CF-BB82-00AA00BDCE0B}"
    put_nodeValue(v)
      => ComCall(7, this.p, VARIANT, v)
    get_nodeValue(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, BSTR, v)
    get_value(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_specified(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    get_ownerElement(p)
      => ComCall(12, this.p, IHTMLElement2.Ptr, p)
}
struct IHTMLDOMAttribute4 extends IDispatch {
    static IID := "{305106F9-98B5-11CF-BB82-00AA00BDCE0B}"
    put_nodeValue(v)
      => ComCall(7, this.p, VARIANT, v)
    get_nodeValue(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_nodeName(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_name(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(11, this.p, BSTR, v)
    get_value(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_firstChild(p)
      => ComCall(13, this.p, IHTMLDOMNode.Ptr, p)
    get_lastChild(p)
      => ComCall(14, this.p, IHTMLDOMNode.Ptr, p)
    get_childNodes(p)
      => ComCall(15, this.p, IDispatch.Ptr, p)
    hasAttributes(pfHasAttributes)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pfHasAttributes)
    hasChildNodes(fChildren)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, fChildren)
    normalize()
      => ComCall(18, this.p)
    get_specified(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLDOMTextNode extends IDispatch {
    static IID := "{3050F4B1-98B5-11CF-BB82-00AA00BDCE0B}"
    put_data(v)
      => ComCall(7, this.p, BSTR, v)
    get_data(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    toString(String)
      => ComCall(9, this.p, BSTR.Ptr, String)
    get_length(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    splitText(offset, pRetNode)
      => ComCall(11, this.p, Int32, offset, IHTMLDOMNode.Ptr, pRetNode)
}
struct IHTMLDOMTextNode2 extends IDispatch {
    static IID := "{3050F809-98B5-11CF-BB82-00AA00BDCE0B}"
    substringData(offset, Count, pbstrsubString)
      => ComCall(7, this.p, Int32, offset, Int32, Count, BSTR.Ptr, pbstrsubString)
    appendData(bstrstring)
      => ComCall(8, this.p, BSTR, bstrstring)
    insertData(offset, bstrstring)
      => ComCall(9, this.p, Int32, offset, BSTR, bstrstring)
    deleteData(offset, Count)
      => ComCall(10, this.p, Int32, offset, Int32, Count)
    replaceData(offset, Count, bstrstring)
      => ComCall(11, this.p, Int32, offset, Int32, Count, BSTR, bstrstring)
}
struct IHTMLDOMTextNode3 extends IDispatch {
    static IID := "{3051073E-98B5-11CF-BB82-00AA00BDCE0B}"
    substringData(offset, Count, pbstrsubString)
      => ComCall(7, this.p, Int32, offset, Int32, Count, BSTR.Ptr, pbstrsubString)
    insertData(offset, bstrstring)
      => ComCall(8, this.p, Int32, offset, BSTR, bstrstring)
    deleteData(offset, Count)
      => ComCall(9, this.p, Int32, offset, Int32, Count)
    replaceData(offset, Count, bstrstring)
      => ComCall(10, this.p, Int32, offset, Int32, Count, BSTR, bstrstring)
    splitText(offset, pRetNode)
      => ComCall(11, this.p, Int32, offset, IHTMLDOMNode.Ptr, pRetNode)
    get_wholeText(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    replaceWholeText(bstrText, ppRetNode)
      => ComCall(13, this.p, BSTR, bstrText, IHTMLDOMNode.Ptr, ppRetNode)
    hasAttributes(pfHasAttributes)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pfHasAttributes)
    normalize()
      => ComCall(15, this.p)
}
struct IHTMLDOMImplementation extends IDispatch {
    static IID := "{3050F80D-98B5-11CF-BB82-00AA00BDCE0B}"
    hasFeature(bstrfeature, version, pfHasFeature)
      => ComCall(7, this.p, BSTR, bstrfeature, VARIANT, version, VARIANT_BOOL.Ptr, pfHasFeature)
}
struct IHTMLDOMImplementation2 extends IDispatch {
    static IID := "{3051073C-98B5-11CF-BB82-00AA00BDCE0B}"
    createDocumentType(bstrQualifiedName, pvarPublicId, pvarSystemId, newDocumentType)
      => ComCall(7, this.p, BSTR, bstrQualifiedName, VARIANT.Ptr, pvarPublicId, VARIANT.Ptr, pvarSystemId, IDOMDocumentType.Ptr, newDocumentType)
    createDocument(pvarNS, pvarTagName, pDocumentType, ppnewDocument)
      => ComCall(8, this.p, VARIANT.Ptr, pvarNS, VARIANT.Ptr, pvarTagName, IDOMDocumentType, pDocumentType, IHTMLDocument7.Ptr, ppnewDocument)
    createHTMLDocument(bstrTitle, ppnewDocument)
      => ComCall(9, this.p, BSTR, bstrTitle, IHTMLDocument7.Ptr, ppnewDocument)
    hasFeature(bstrfeature, version, pfHasFeature)
      => ComCall(10, this.p, BSTR, bstrfeature, VARIANT, version, VARIANT_BOOL.Ptr, pfHasFeature)
}
struct DispHTMLDOMAttribute extends IDispatch {
    static IID := "{3050F564-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLDOMTextNode extends IDispatch {
    static IID := "{3050F565-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLDOMImplementation extends IDispatch {
    static IID := "{3050F58F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLAttributeCollection extends IDispatch {
    static IID := "{3050F4C3-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(name, pdisp)
      => ComCall(9, this.p, VARIANT.Ptr, name, IDispatch.Ptr, pdisp)
}
struct IHTMLAttributeCollection2 extends IDispatch {
    static IID := "{3050F80A-98B5-11CF-BB82-00AA00BDCE0B}"
    getNamedItem(bstrName, newretNode)
      => ComCall(7, this.p, BSTR, bstrName, IHTMLDOMAttribute.Ptr, newretNode)
    setNamedItem(ppNode, newretNode)
      => ComCall(8, this.p, IHTMLDOMAttribute, ppNode, IHTMLDOMAttribute.Ptr, newretNode)
    removeNamedItem(bstrName, newretNode)
      => ComCall(9, this.p, BSTR, bstrName, IHTMLDOMAttribute.Ptr, newretNode)
}
struct IHTMLAttributeCollection4 extends IDispatch {
    static IID := "{305106FA-98B5-11CF-BB82-00AA00BDCE0B}"
    getNamedItemNS(pvarNS, bstrName, ppNodeOut)
      => ComCall(7, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrName, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    setNamedItemNS(pNodeIn, ppNodeOut)
      => ComCall(8, this.p, IHTMLDOMAttribute2, pNodeIn, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    removeNamedItemNS(pvarNS, bstrName, ppNodeOut)
      => ComCall(9, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrName, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    getNamedItem(bstrName, ppNodeOut)
      => ComCall(10, this.p, BSTR, bstrName, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    setNamedItem(pNodeIn, ppNodeOut)
      => ComCall(11, this.p, IHTMLDOMAttribute2, pNodeIn, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    removeNamedItem(bstrName, ppNodeOut)
      => ComCall(12, this.p, BSTR, bstrName, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    item(index, ppNodeOut)
      => ComCall(13, this.p, Int32, index, IHTMLDOMAttribute2.Ptr, ppNodeOut)
    get_length(p)
      => ComCall(14, this.p, Int32.Ptr, p)
}
struct IHTMLDOMChildrenCollection extends IDispatch {
    static IID := "{3050F5AB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(index, ppItem)
      => ComCall(9, this.p, Int32, index, IDispatch.Ptr, ppItem)
}
struct IHTMLDOMChildrenCollection2 extends IDispatch {
    static IID := "{30510791-98B5-11CF-BB82-00AA00BDCE0B}"
    item(index, ppItem)
      => ComCall(7, this.p, Int32, index, IDispatch.Ptr, ppItem)
}
struct DispHTMLAttributeCollection extends IDispatch {
    static IID := "{3050F56C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispStaticNodeList extends IDispatch {
    static IID := "{3050F59B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispDOMChildrenCollection extends IDispatch {
    static IID := "{3050F577-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLElementEvents4 extends IDispatch {
    static IID := "{3051075E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLElementEvents3 extends IDispatch {
    static IID := "{3050F59F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLElementEvents2 extends IDispatch {
    static IID := "{3050F60F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLElementEvents extends IDispatch {
    static IID := "{3050F33C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IRulesAppliedCollection extends IDispatch {
    static IID := "{305104BE-98B5-11CF-BB82-00AA00BDCE0B}"
    item(index, ppRulesApplied)
      => ComCall(7, this.p, Int32, index, IRulesApplied.Ptr, ppRulesApplied)
    get_length(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_element(p)
      => ComCall(9, this.p, IHTMLElement.Ptr, p)
    propertyInheritedFrom(name, ppRulesApplied)
      => ComCall(10, this.p, BSTR, name, IRulesApplied.Ptr, ppRulesApplied)
    get_propertyCount(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    property(index, pbstrProperty)
      => ComCall(12, this.p, Int32, index, BSTR.Ptr, pbstrProperty)
    propertyInheritedTrace(name, index, ppRulesApplied)
      => ComCall(13, this.p, BSTR, name, Int32, index, IRulesApplied.Ptr, ppRulesApplied)
    propertyInheritedTraceLength(name, pLength)
      => ComCall(14, this.p, BSTR, name, Int32.Ptr, pLength)
}
struct IHTMLElement3 extends IDispatch {
    static IID := "{3050F673-98B5-11CF-BB82-00AA00BDCE0B}"
    mergeAttributes(mergeThis, pvarFlags)
      => ComCall(7, this.p, IHTMLElement, mergeThis, VARIANT.Ptr, pvarFlags)
    get_isMultiLine(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_canHaveHTML(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    put_onlayoutcomplete(v)
      => ComCall(10, this.p, VARIANT, v)
    get_onlayoutcomplete(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    put_onpage(v)
      => ComCall(12, this.p, VARIANT, v)
    get_onpage(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_inflateBlock(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_inflateBlock(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    put_onbeforedeactivate(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onbeforedeactivate(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    setActive()
      => ComCall(18, this.p)
    put_contentEditable(v)
      => ComCall(19, this.p, BSTR, v)
    get_contentEditable(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    get_isContentEditable(p)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, p)
    put_hideFocus(v)
      => ComCall(22, this.p, VARIANT_BOOL, v)
    get_hideFocus(p)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, p)
    put_disabled(v)
      => ComCall(24, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, p)
    get_isDisabled(p)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, p)
    put_onmove(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onmove(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_oncontrolselect(v)
      => ComCall(29, this.p, VARIANT, v)
    get_oncontrolselect(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    fireEvent(bstrEventName, pvarEventObject, pfCancelled)
      => ComCall(31, this.p, BSTR, bstrEventName, VARIANT.Ptr, pvarEventObject, VARIANT_BOOL.Ptr, pfCancelled)
    put_onresizestart(v)
      => ComCall(32, this.p, VARIANT, v)
    get_onresizestart(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    put_onresizeend(v)
      => ComCall(34, this.p, VARIANT, v)
    get_onresizeend(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    put_onmovestart(v)
      => ComCall(36, this.p, VARIANT, v)
    get_onmovestart(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    put_onmoveend(v)
      => ComCall(38, this.p, VARIANT, v)
    get_onmoveend(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    put_onmouseenter(v)
      => ComCall(40, this.p, VARIANT, v)
    get_onmouseenter(p)
      => ComCall(41, this.p, VARIANT.Ptr, p)
    put_onmouseleave(v)
      => ComCall(42, this.p, VARIANT, v)
    get_onmouseleave(p)
      => ComCall(43, this.p, VARIANT.Ptr, p)
    put_onactivate(v)
      => ComCall(44, this.p, VARIANT, v)
    get_onactivate(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    put_ondeactivate(v)
      => ComCall(46, this.p, VARIANT, v)
    get_ondeactivate(p)
      => ComCall(47, this.p, VARIANT.Ptr, p)
    dragDrop(pfRet)
      => ComCall(48, this.p, VARIANT_BOOL.Ptr, pfRet)
    get_glyphMode(p)
      => ComCall(49, this.p, Int32.Ptr, p)
}
struct IHTMLElement4 extends IDispatch {
    static IID := "{3050F80F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmousewheel(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmousewheel(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    normalize()
      => ComCall(9, this.p)
    getAttributeNode(bstrname, ppAttribute)
      => ComCall(10, this.p, BSTR, bstrname, IHTMLDOMAttribute.Ptr, ppAttribute)
    setAttributeNode(pattr, ppretAttribute)
      => ComCall(11, this.p, IHTMLDOMAttribute, pattr, IHTMLDOMAttribute.Ptr, ppretAttribute)
    removeAttributeNode(pattr, ppretAttribute)
      => ComCall(12, this.p, IHTMLDOMAttribute, pattr, IHTMLDOMAttribute.Ptr, ppretAttribute)
    put_onbeforeactivate(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onbeforeactivate(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onfocusin(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onfocusin(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onfocusout(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onfocusout(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
}
struct IElementSelector extends IDispatch {
    static IID := "{30510463-98B5-11CF-BB82-00AA00BDCE0B}"
    querySelector(v, pel)
      => ComCall(7, this.p, BSTR, v, IHTMLElement.Ptr, pel)
    querySelectorAll(v, pel)
      => ComCall(8, this.p, BSTR, v, IHTMLDOMChildrenCollection.Ptr, pel)
}
struct IHTMLElementRender extends IUnknown {
    static IID := "{3050F669-98B5-11CF-BB82-00AA00BDCE0B}"
    DrawToDC(hDC1)
      => ComCall(3, this.p, HDC, hDC1)
    SetDocumentPrinter(bstrPrinterName, hDC1)
      => ComCall(4, this.p, BSTR, bstrPrinterName, HDC, hDC1)
}
struct IHTMLUniqueName extends IDispatch {
    static IID := "{3050F4D0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_uniqueNumber(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_uniqueID(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLElement5 extends IDispatch {
    static IID := "{3051045D-98B5-11CF-BB82-00AA00BDCE0B}"
    getAttributeNode(bstrname, ppretAttribute)
      => ComCall(7, this.p, BSTR, bstrname, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    setAttributeNode(pattr, ppretAttribute)
      => ComCall(8, this.p, IHTMLDOMAttribute2, pattr, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    removeAttributeNode(pattr, ppretAttribute)
      => ComCall(9, this.p, IHTMLDOMAttribute2, pattr, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    hasAttribute(name, pfHasAttribute)
      => ComCall(10, this.p, BSTR, name, VARIANT_BOOL.Ptr, pfHasAttribute)
    put_role(v)
      => ComCall(11, this.p, BSTR, v)
    get_role(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_ariaBusy(v)
      => ComCall(13, this.p, BSTR, v)
    get_ariaBusy(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_ariaChecked(v)
      => ComCall(15, this.p, BSTR, v)
    get_ariaChecked(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_ariaDisabled(v)
      => ComCall(17, this.p, BSTR, v)
    get_ariaDisabled(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_ariaExpanded(v)
      => ComCall(19, this.p, BSTR, v)
    get_ariaExpanded(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_ariaHaspopup(v)
      => ComCall(21, this.p, BSTR, v)
    get_ariaHaspopup(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_ariaHidden(v)
      => ComCall(23, this.p, BSTR, v)
    get_ariaHidden(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_ariaInvalid(v)
      => ComCall(25, this.p, BSTR, v)
    get_ariaInvalid(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_ariaMultiselectable(v)
      => ComCall(27, this.p, BSTR, v)
    get_ariaMultiselectable(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_ariaPressed(v)
      => ComCall(29, this.p, BSTR, v)
    get_ariaPressed(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_ariaReadonly(v)
      => ComCall(31, this.p, BSTR, v)
    get_ariaReadonly(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_ariaRequired(v)
      => ComCall(33, this.p, BSTR, v)
    get_ariaRequired(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_ariaSecret(v)
      => ComCall(35, this.p, BSTR, v)
    get_ariaSecret(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_ariaSelected(v)
      => ComCall(37, this.p, BSTR, v)
    get_ariaSelected(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
    getAttribute(strAttributeName, AttributeValue)
      => ComCall(39, this.p, BSTR, strAttributeName, VARIANT.Ptr, AttributeValue)
    setAttribute(strAttributeName, AttributeValue)
      => ComCall(40, this.p, BSTR, strAttributeName, VARIANT, AttributeValue)
    removeAttribute(strAttributeName, pfSuccess)
      => ComCall(41, this.p, BSTR, strAttributeName, VARIANT_BOOL.Ptr, pfSuccess)
    get_attributes(p)
      => ComCall(42, this.p, IHTMLAttributeCollection3.Ptr, p)
    put_ariaValuenow(v)
      => ComCall(43, this.p, BSTR, v)
    get_ariaValuenow(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_ariaPosinset(v)
      => ComCall(45, this.p, Int16, v)
    get_ariaPosinset(p)
      => ComCall(46, this.p, Int16.Ptr, p)
    put_ariaSetsize(v)
      => ComCall(47, this.p, Int16, v)
    get_ariaSetsize(p)
      => ComCall(48, this.p, Int16.Ptr, p)
    put_ariaLevel(v)
      => ComCall(49, this.p, Int16, v)
    get_ariaLevel(p)
      => ComCall(50, this.p, Int16.Ptr, p)
    put_ariaValuemin(v)
      => ComCall(51, this.p, BSTR, v)
    get_ariaValuemin(p)
      => ComCall(52, this.p, BSTR.Ptr, p)
    put_ariaValuemax(v)
      => ComCall(53, this.p, BSTR, v)
    get_ariaValuemax(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    put_ariaControls(v)
      => ComCall(55, this.p, BSTR, v)
    get_ariaControls(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    put_ariaDescribedby(v)
      => ComCall(57, this.p, BSTR, v)
    get_ariaDescribedby(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    put_ariaFlowto(v)
      => ComCall(59, this.p, BSTR, v)
    get_ariaFlowto(p)
      => ComCall(60, this.p, BSTR.Ptr, p)
    put_ariaLabelledby(v)
      => ComCall(61, this.p, BSTR, v)
    get_ariaLabelledby(p)
      => ComCall(62, this.p, BSTR.Ptr, p)
    put_ariaActivedescendant(v)
      => ComCall(63, this.p, BSTR, v)
    get_ariaActivedescendant(p)
      => ComCall(64, this.p, BSTR.Ptr, p)
    put_ariaOwns(v)
      => ComCall(65, this.p, BSTR, v)
    get_ariaOwns(p)
      => ComCall(66, this.p, BSTR.Ptr, p)
    hasAttributes(pfHasAttributes)
      => ComCall(67, this.p, VARIANT_BOOL.Ptr, pfHasAttributes)
    put_ariaLive(v)
      => ComCall(68, this.p, BSTR, v)
    get_ariaLive(p)
      => ComCall(69, this.p, BSTR.Ptr, p)
    put_ariaRelevant(v)
      => ComCall(70, this.p, BSTR, v)
    get_ariaRelevant(p)
      => ComCall(71, this.p, BSTR.Ptr, p)
}
struct IHTMLElement6 extends IDispatch {
    static IID := "{305106F8-98B5-11CF-BB82-00AA00BDCE0B}"
    getAttributeNS(pvarNS, strAttributeName, AttributeValue)
      => ComCall(7, this.p, VARIANT.Ptr, pvarNS, BSTR, strAttributeName, VARIANT.Ptr, AttributeValue)
    setAttributeNS(pvarNS, strAttributeName, pvarAttributeValue)
      => ComCall(8, this.p, VARIANT.Ptr, pvarNS, BSTR, strAttributeName, VARIANT.Ptr, pvarAttributeValue)
    removeAttributeNS(pvarNS, strAttributeName)
      => ComCall(9, this.p, VARIANT.Ptr, pvarNS, BSTR, strAttributeName)
    getAttributeNodeNS(pvarNS, bstrname, ppretAttribute)
      => ComCall(10, this.p, VARIANT.Ptr, pvarNS, BSTR, bstrname, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    setAttributeNodeNS(pattr, ppretAttribute)
      => ComCall(11, this.p, IHTMLDOMAttribute2, pattr, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    hasAttributeNS(pvarNS, name, pfHasAttribute)
      => ComCall(12, this.p, VARIANT.Ptr, pvarNS, BSTR, name, VARIANT_BOOL.Ptr, pfHasAttribute)
    getAttribute(strAttributeName, AttributeValue)
      => ComCall(13, this.p, BSTR, strAttributeName, VARIANT.Ptr, AttributeValue)
    setAttribute(strAttributeName, pvarAttributeValue)
      => ComCall(14, this.p, BSTR, strAttributeName, VARIANT.Ptr, pvarAttributeValue)
    removeAttribute(strAttributeName)
      => ComCall(15, this.p, BSTR, strAttributeName)
    getAttributeNode(strAttributeName, ppretAttribute)
      => ComCall(16, this.p, BSTR, strAttributeName, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    setAttributeNode(pattr, ppretAttribute)
      => ComCall(17, this.p, IHTMLDOMAttribute2, pattr, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    removeAttributeNode(pattr, ppretAttribute)
      => ComCall(18, this.p, IHTMLDOMAttribute2, pattr, IHTMLDOMAttribute2.Ptr, ppretAttribute)
    hasAttribute(name, pfHasAttribute)
      => ComCall(19, this.p, BSTR, name, VARIANT_BOOL.Ptr, pfHasAttribute)
    getElementsByTagNameNS(varNS, bstrLocalName, pelColl)
      => ComCall(20, this.p, VARIANT.Ptr, varNS, BSTR, bstrLocalName, IHTMLElementCollection.Ptr, pelColl)
    get_tagName(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    get_nodeName(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    getElementsByClassName(v, pel)
      => ComCall(23, this.p, BSTR, v, IHTMLElementCollection.Ptr, pel)
    msMatchesSelector(v, pfMatches)
      => ComCall(24, this.p, BSTR, v, VARIANT_BOOL.Ptr, pfMatches)
    put_onabort(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_oncanplay(v)
      => ComCall(27, this.p, VARIANT, v)
    get_oncanplay(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_oncanplaythrough(v)
      => ComCall(29, this.p, VARIANT, v)
    get_oncanplaythrough(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onchange(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_ondurationchange(v)
      => ComCall(33, this.p, VARIANT, v)
    get_ondurationchange(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_onemptied(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onemptied(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_onended(v)
      => ComCall(37, this.p, VARIANT, v)
    get_onended(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(39, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_oninput(v)
      => ComCall(41, this.p, VARIANT, v)
    get_oninput(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(43, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    put_onloadeddata(v)
      => ComCall(45, this.p, VARIANT, v)
    get_onloadeddata(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    put_onloadedmetadata(v)
      => ComCall(47, this.p, VARIANT, v)
    get_onloadedmetadata(p)
      => ComCall(48, this.p, VARIANT.Ptr, p)
    put_onloadstart(v)
      => ComCall(49, this.p, VARIANT, v)
    get_onloadstart(p)
      => ComCall(50, this.p, VARIANT.Ptr, p)
    put_onpause(v)
      => ComCall(51, this.p, VARIANT, v)
    get_onpause(p)
      => ComCall(52, this.p, VARIANT.Ptr, p)
    put_onplay(v)
      => ComCall(53, this.p, VARIANT, v)
    get_onplay(p)
      => ComCall(54, this.p, VARIANT.Ptr, p)
    put_onplaying(v)
      => ComCall(55, this.p, VARIANT, v)
    get_onplaying(p)
      => ComCall(56, this.p, VARIANT.Ptr, p)
    put_onprogress(v)
      => ComCall(57, this.p, VARIANT, v)
    get_onprogress(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    put_onratechange(v)
      => ComCall(59, this.p, VARIANT, v)
    get_onratechange(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
    put_onreset(v)
      => ComCall(61, this.p, VARIANT, v)
    get_onreset(p)
      => ComCall(62, this.p, VARIANT.Ptr, p)
    put_onseeked(v)
      => ComCall(63, this.p, VARIANT, v)
    get_onseeked(p)
      => ComCall(64, this.p, VARIANT.Ptr, p)
    put_onseeking(v)
      => ComCall(65, this.p, VARIANT, v)
    get_onseeking(p)
      => ComCall(66, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(67, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(68, this.p, VARIANT.Ptr, p)
    put_onstalled(v)
      => ComCall(69, this.p, VARIANT, v)
    get_onstalled(p)
      => ComCall(70, this.p, VARIANT.Ptr, p)
    put_onsubmit(v)
      => ComCall(71, this.p, VARIANT, v)
    get_onsubmit(p)
      => ComCall(72, this.p, VARIANT.Ptr, p)
    put_onsuspend(v)
      => ComCall(73, this.p, VARIANT, v)
    get_onsuspend(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_ontimeupdate(v)
      => ComCall(75, this.p, VARIANT, v)
    get_ontimeupdate(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_onvolumechange(v)
      => ComCall(77, this.p, VARIANT, v)
    get_onvolumechange(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_onwaiting(v)
      => ComCall(79, this.p, VARIANT, v)
    get_onwaiting(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    hasAttributes(pfHasAttributes)
      => ComCall(81, this.p, VARIANT_BOOL.Ptr, pfHasAttributes)
}
struct IHTMLElement7 extends IDispatch {
    static IID := "{305107AA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmspointerdown(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmspointerdown(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onmspointermove(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onmspointermove(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onmspointerup(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onmspointerup(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_onmspointerover(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onmspointerover(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onmspointerout(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onmspointerout(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onmspointercancel(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onmspointercancel(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_onmspointerhover(v)
      => ComCall(19, this.p, VARIANT, v)
    get_onmspointerhover(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_onmslostpointercapture(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onmslostpointercapture(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onmsgotpointercapture(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onmsgotpointercapture(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onmsgesturestart(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onmsgesturestart(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_onmsgesturechange(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onmsgesturechange(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_onmsgestureend(v)
      => ComCall(29, this.p, VARIANT, v)
    get_onmsgestureend(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onmsgesturehold(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onmsgesturehold(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onmsgesturetap(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onmsgesturetap(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_onmsgesturedoubletap(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onmsgesturedoubletap(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_onmsinertiastart(v)
      => ComCall(37, this.p, VARIANT, v)
    get_onmsinertiastart(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    msSetPointerCapture(pointerId)
      => ComCall(39, this.p, Int32, pointerId)
    msReleasePointerCapture(pointerId)
      => ComCall(40, this.p, Int32, pointerId)
    put_onmstransitionstart(v)
      => ComCall(41, this.p, VARIANT, v)
    get_onmstransitionstart(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    put_onmstransitionend(v)
      => ComCall(43, this.p, VARIANT, v)
    get_onmstransitionend(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    put_onmsanimationstart(v)
      => ComCall(45, this.p, VARIANT, v)
    get_onmsanimationstart(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    put_onmsanimationend(v)
      => ComCall(47, this.p, VARIANT, v)
    get_onmsanimationend(p)
      => ComCall(48, this.p, VARIANT.Ptr, p)
    put_onmsanimationiteration(v)
      => ComCall(49, this.p, VARIANT, v)
    get_onmsanimationiteration(p)
      => ComCall(50, this.p, VARIANT.Ptr, p)
    put_oninvalid(v)
      => ComCall(51, this.p, VARIANT, v)
    get_oninvalid(p)
      => ComCall(52, this.p, VARIANT.Ptr, p)
    put_xmsAcceleratorKey(v)
      => ComCall(53, this.p, BSTR, v)
    get_xmsAcceleratorKey(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    put_spellcheck(v)
      => ComCall(55, this.p, VARIANT, v)
    get_spellcheck(p)
      => ComCall(56, this.p, VARIANT.Ptr, p)
    put_onmsmanipulationstatechanged(v)
      => ComCall(57, this.p, VARIANT, v)
    get_onmsmanipulationstatechanged(p)
      => ComCall(58, this.p, VARIANT.Ptr, p)
    put_oncuechange(v)
      => ComCall(59, this.p, VARIANT, v)
    get_oncuechange(p)
      => ComCall(60, this.p, VARIANT.Ptr, p)
}
struct IHTMLElementAppliedStyles extends IDispatch {
    static IID := "{305104BD-98B5-11CF-BB82-00AA00BDCE0B}"
    msGetRulesApplied(ppRulesAppliedCollection)
      => ComCall(7, this.p, IRulesAppliedCollection.Ptr, ppRulesAppliedCollection)
    msGetRulesAppliedWithAncestor(varContext, ppRulesAppliedCollection)
      => ComCall(8, this.p, VARIANT, varContext, IRulesAppliedCollection.Ptr, ppRulesAppliedCollection)
}
struct IElementTraversal extends IDispatch {
    static IID := "{30510736-98B5-11CF-BB82-00AA00BDCE0B}"
    get_firstElementChild(p)
      => ComCall(7, this.p, IHTMLElement.Ptr, p)
    get_lastElementChild(p)
      => ComCall(8, this.p, IHTMLElement.Ptr, p)
    get_previousElementSibling(p)
      => ComCall(9, this.p, IHTMLElement.Ptr, p)
    get_nextElementSibling(p)
      => ComCall(10, this.p, IHTMLElement.Ptr, p)
    get_childElementCount(p)
      => ComCall(11, this.p, Int32.Ptr, p)
}
struct IHTMLDatabinding extends IDispatch {
    static IID := "{3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}"
    put_dataFld(v)
      => ComCall(7, this.p, BSTR, v)
    get_dataFld(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_dataSrc(v)
      => ComCall(9, this.p, BSTR, v)
    get_dataSrc(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_dataFormatAs(v)
      => ComCall(11, this.p, BSTR, v)
    get_dataFormatAs(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct IHTMLDocument extends IDispatch {
    static IID := "{626FC520-A41E-11CF-A731-00A0C9082637}"
    get_Script(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
}
struct IHTMLElementDefaults extends IDispatch {
    static IID := "{3050F6C9-98B5-11CF-BB82-00AA00BDCE0B}"
    get_style(p)
      => ComCall(7, this.p, IHTMLStyle.Ptr, p)
    put_tabStop(v)
      => ComCall(8, this.p, VARIANT_BOOL, v)
    get_tabStop(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    put_viewInheritStyle(v)
      => ComCall(10, this.p, VARIANT_BOOL, v)
    get_viewInheritStyle(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    put_viewMasterTab(v)
      => ComCall(12, this.p, VARIANT_BOOL, v)
    get_viewMasterTab(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    put_scrollSegmentX(v)
      => ComCall(14, this.p, Int32, v)
    get_scrollSegmentX(p)
      => ComCall(15, this.p, Int32.Ptr, p)
    put_scrollSegmentY(v)
      => ComCall(16, this.p, Int32, v)
    get_scrollSegmentY(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    put_isMultiLine(v)
      => ComCall(18, this.p, VARIANT_BOOL, v)
    get_isMultiLine(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
    put_contentEditable(v)
      => ComCall(20, this.p, BSTR, v)
    get_contentEditable(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    put_canHaveHTML(v)
      => ComCall(22, this.p, VARIANT_BOOL, v)
    get_canHaveHTML(p)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, p)
    putref_viewLink(v)
      => ComCall(24, this.p, IHTMLDocument, v)
    get_viewLink(p)
      => ComCall(25, this.p, IHTMLDocument.Ptr, p)
    put_frozen(v)
      => ComCall(26, this.p, VARIANT_BOOL, v)
    get_frozen(p)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLDefaults extends IDispatch {
    static IID := "{3050F58C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTCDefaultDispatch extends IDispatch {
    static IID := "{3050F4FD-98B5-11CF-BB82-00AA00BDCE0B}"
    get_element(p)
      => ComCall(7, this.p, IHTMLElement.Ptr, p)
    createEventObject(eventObj)
      => ComCall(8, this.p, IHTMLEventObj.Ptr, eventObj)
    get_defaults(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_document(p)
      => ComCall(10, this.p, IDispatch.Ptr, p)
}
struct IHTCPropertyBehavior extends IDispatch {
    static IID := "{3050F5DF-98B5-11CF-BB82-00AA00BDCE0B}"
    fireChange()
      => ComCall(7, this.p)
    put_value(v)
      => ComCall(8, this.p, VARIANT, v)
    get_value(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
}
struct IHTCMethodBehavior extends IDispatch {
    static IID := "{3050F631-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTCEventBehavior extends IDispatch {
    static IID := "{3050F4FF-98B5-11CF-BB82-00AA00BDCE0B}"
    fire(pvar)
      => ComCall(7, this.p, IHTMLEventObj, pvar)
}
struct IHTCAttachBehavior extends IDispatch {
    static IID := "{3050F5F4-98B5-11CF-BB82-00AA00BDCE0B}"
    fireEvent(evt)
      => ComCall(7, this.p, IDispatch, evt)
    detachEvent()
      => ComCall(8, this.p)
}
struct IHTCAttachBehavior2 extends IDispatch {
    static IID := "{3050F7EB-98B5-11CF-BB82-00AA00BDCE0B}"
    fireEvent(evt)
      => ComCall(7, this.p, VARIANT, evt)
}
struct IHTCDescBehavior extends IDispatch {
    static IID := "{3050F5DC-98B5-11CF-BB82-00AA00BDCE0B}"
    get_urn(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_name(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTCDefaultDispatch extends IDispatch {
    static IID := "{3050F573-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTCPropertyBehavior extends IDispatch {
    static IID := "{3050F57F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTCMethodBehavior extends IDispatch {
    static IID := "{3050F587-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTCEventBehavior extends IDispatch {
    static IID := "{3050F574-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTCAttachBehavior extends IDispatch {
    static IID := "{3050F583-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTCDescBehavior extends IDispatch {
    static IID := "{3050F57E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLUrnCollection extends IDispatch {
    static IID := "{3050F5E2-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppUrn)
      => ComCall(8, this.p, Int32, index, BSTR.Ptr, ppUrn)
}
struct DispHTMLUrnCollection extends IDispatch {
    static IID := "{3050F551-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLGenericElement extends IDispatch {
    static IID := "{3050F4B7-98B5-11CF-BB82-00AA00BDCE0B}"
    get_recordset(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    namedRecordset(dataMember, hierarchy, ppRecordset)
      => ComCall(8, this.p, BSTR, dataMember, VARIANT.Ptr, hierarchy, IDispatch.Ptr, ppRecordset)
}
struct DispHTMLGenericElement extends IDispatch {
    static IID := "{3050F563-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetRuleApplied extends IDispatch {
    static IID := "{305104C1-98B5-11CF-BB82-00AA00BDCE0B}"
    get_msSpecificity(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    msGetSpecificity(index, p)
      => ComCall(8, this.p, Int32, index, Int32.Ptr, p)
}
struct IHTMLStyleSheetRule2 extends IDispatch {
    static IID := "{305106FD-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectorText(v)
      => ComCall(7, this.p, BSTR, v)
    get_selectorText(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLStyleSheetRulesCollection2 extends IDispatch {
    static IID := "{305106E8-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppHTMLCSSRule)
      => ComCall(8, this.p, Int32, index, IHTMLCSSRule.Ptr, ppHTMLCSSRule)
}
struct DispHTMLStyleSheetRule extends IDispatch {
    static IID := "{3050F50E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLStyleSheetRulesCollection extends IDispatch {
    static IID := "{3050F52F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetPage extends IDispatch {
    static IID := "{3050F7EE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_selector(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_pseudoClass(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLStyleSheetPage2 extends IDispatch {
    static IID := "{305106ED-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectorText(v)
      => ComCall(7, this.p, BSTR, v)
    get_selectorText(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_style(p)
      => ComCall(9, this.p, IHTMLRuleStyle.Ptr, p)
}
struct IHTMLStyleSheetPagesCollection extends IDispatch {
    static IID := "{3050F7F0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppHTMLStyleSheetPage)
      => ComCall(8, this.p, Int32, index, IHTMLStyleSheetPage.Ptr, ppHTMLStyleSheetPage)
}
struct DispHTMLStyleSheetPage extends IDispatch {
    static IID := "{3050F540-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLStyleSheetPagesCollection extends IDispatch {
    static IID := "{3050F543-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetsCollection extends IDispatch {
    static IID := "{3050F37E-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(pvarIndex, pvarResult)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarResult)
}
struct IHTMLStyleSheet2 extends IDispatch {
    static IID := "{3050F3D1-98B5-11CF-BB82-00AA00BDCE0B}"
    get_pages(p)
      => ComCall(7, this.p, IHTMLStyleSheetPagesCollection.Ptr, p)
    addPageRule(bstrSelector, bstrStyle, lIndex, plNewIndex)
      => ComCall(8, this.p, BSTR, bstrSelector, BSTR, bstrStyle, Int32, lIndex, Int32.Ptr, plNewIndex)
}
struct IHTMLStyleSheet3 extends IDispatch {
    static IID := "{30510496-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_isAlternate(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    get_isPrefAlternate(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLStyleSheet4 extends IDispatch {
    static IID := "{305106F4-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_href(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_title(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_ownerNode(p)
      => ComCall(10, this.p, IHTMLElement.Ptr, p)
    get_ownerRule(p)
      => ComCall(11, this.p, IHTMLCSSRule.Ptr, p)
    get_cssRules(p)
      => ComCall(12, this.p, IHTMLStyleSheetRulesCollection.Ptr, p)
    get_media(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    insertRule(bstrRule, lIndex, plNewIndex)
      => ComCall(14, this.p, BSTR, bstrRule, Int32, lIndex, Int32.Ptr, plNewIndex)
    deleteRule(lIndex)
      => ComCall(15, this.p, Int32, lIndex)
}
struct DispHTMLStyleSheet extends IDispatch {
    static IID := "{3050F58D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetsCollection2 extends IDispatch {
    static IID := "{305106E7-98B5-11CF-BB82-00AA00BDCE0B}"
    item(index, pvarResult)
      => ComCall(7, this.p, Int32, index, VARIANT.Ptr, pvarResult)
}
struct DispHTMLStyleSheetsCollection extends IDispatch {
    static IID := "{3050F547-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLLinkElementEvents2 extends IDispatch {
    static IID := "{3050F61D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLLinkElementEvents extends IDispatch {
    static IID := "{3050F3CC-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLLinkElement extends IDispatch {
    static IID := "{3050F205-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_rel(v)
      => ComCall(9, this.p, BSTR, v)
    get_rel(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_rev(v)
      => ComCall(11, this.p, BSTR, v)
    get_rev(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(13, this.p, BSTR, v)
    get_type(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    get_readyState(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(18, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(20, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    get_styleSheet(p)
      => ComCall(22, this.p, IHTMLStyleSheet.Ptr, p)
    put_disabled(v)
      => ComCall(23, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, p)
    put_media(v)
      => ComCall(25, this.p, BSTR, v)
    get_media(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
}
struct IHTMLLinkElement2 extends IDispatch {
    static IID := "{3050F4E5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_target(v)
      => ComCall(7, this.p, BSTR, v)
    get_target(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLLinkElement3 extends IDispatch {
    static IID := "{3050F81E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_charset(v)
      => ComCall(7, this.p, BSTR, v)
    get_charset(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_hreflang(v)
      => ComCall(9, this.p, BSTR, v)
    get_hreflang(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLLinkElement4 extends IDispatch {
    static IID := "{3051043A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLLinkElement5 extends IDispatch {
    static IID := "{30510726-98B5-11CF-BB82-00AA00BDCE0B}"
    get_sheet(p)
      => ComCall(7, this.p, IHTMLStyleSheet.Ptr, p)
}
struct DispHTMLLinkElement extends IDispatch {
    static IID := "{3050F524-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLTxtRange extends IDispatch {
    static IID := "{3050F220-98B5-11CF-BB82-00AA00BDCE0B}"
    get_htmlText(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_text(v)
      => ComCall(8, this.p, BSTR, v)
    get_text(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    parentElement(parent)
      => ComCall(10, this.p, IHTMLElement.Ptr, parent)
    duplicate(Duplicate)
      => ComCall(11, this.p, IHTMLTxtRange.Ptr, Duplicate)
    inRange(Range, InRange)
      => ComCall(12, this.p, IHTMLTxtRange, Range, VARIANT_BOOL.Ptr, InRange)
    isEqual(Range, IsEqual)
      => ComCall(13, this.p, IHTMLTxtRange, Range, VARIANT_BOOL.Ptr, IsEqual)
    scrollIntoView(fStart)
      => ComCall(14, this.p, VARIANT_BOOL, fStart)
    collapse(Start)
      => ComCall(15, this.p, VARIANT_BOOL, Start)
    expand(Unit, Success)
      => ComCall(16, this.p, BSTR, Unit, VARIANT_BOOL.Ptr, Success)
    move(Unit, Count, ActualCount)
      => ComCall(17, this.p, BSTR, Unit, Int32, Count, Int32.Ptr, ActualCount)
    moveStart(Unit, Count, ActualCount)
      => ComCall(18, this.p, BSTR, Unit, Int32, Count, Int32.Ptr, ActualCount)
    moveEnd(Unit, Count, ActualCount)
      => ComCall(19, this.p, BSTR, Unit, Int32, Count, Int32.Ptr, ActualCount)
    select()
      => ComCall(20, this.p)
    pasteHTML(html)
      => ComCall(21, this.p, BSTR, html)
    moveToElementText(element)
      => ComCall(22, this.p, IHTMLElement, element)
    setEndPoint(how, SourceRange)
      => ComCall(23, this.p, BSTR, how, IHTMLTxtRange, SourceRange)
    compareEndPoints(how, SourceRange, ret)
      => ComCall(24, this.p, BSTR, how, IHTMLTxtRange, SourceRange, Int32.Ptr, ret)
    findText(String, count, Flags, Success)
      => ComCall(25, this.p, BSTR, String, Int32, count, Int32, Flags, VARIANT_BOOL.Ptr, Success)
    moveToPoint(x, y)
      => ComCall(26, this.p, Int32, x, Int32, y)
    getBookmark(Boolmark)
      => ComCall(27, this.p, BSTR.Ptr, Boolmark)
    moveToBookmark(Bookmark, Success)
      => ComCall(28, this.p, BSTR, Bookmark, VARIANT_BOOL.Ptr, Success)
    queryCommandSupported(cmdID, pfRet)
      => ComCall(29, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandEnabled(cmdID, pfRet)
      => ComCall(30, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandState(cmdID, pfRet)
      => ComCall(31, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandIndeterm(cmdID, pfRet)
      => ComCall(32, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandText(cmdID, pcmdText)
      => ComCall(33, this.p, BSTR, cmdID, BSTR.Ptr, pcmdText)
    queryCommandValue(cmdID, pcmdValue)
      => ComCall(34, this.p, BSTR, cmdID, VARIANT.Ptr, pcmdValue)
    execCommand(cmdID, showUI, value, pfRet)
      => ComCall(35, this.p, BSTR, cmdID, VARIANT_BOOL, showUI, VARIANT, value, VARIANT_BOOL.Ptr, pfRet)
    execCommandShowHelp(cmdID, pfRet)
      => ComCall(36, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
}
struct IHTMLTextRangeMetrics extends IDispatch {
    static IID := "{3050F40B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_offsetTop(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_offsetLeft(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_boundingTop(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_boundingLeft(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_boundingWidth(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    get_boundingHeight(p)
      => ComCall(12, this.p, Int32.Ptr, p)
}
struct IHTMLTextRangeMetrics2 extends IDispatch {
    static IID := "{3050F4A6-98B5-11CF-BB82-00AA00BDCE0B}"
    getClientRects(pRectCol)
      => ComCall(7, this.p, IHTMLRectCollection.Ptr, pRectCol)
    getBoundingClientRect(pRect)
      => ComCall(8, this.p, IHTMLRect.Ptr, pRect)
}
struct IHTMLTxtRangeCollection extends IDispatch {
    static IID := "{3050F7ED-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(pvarIndex, pvarResult)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarResult)
}
struct IHTMLDOMRange extends IDispatch {
    static IID := "{305104AE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_startContainer(p)
      => ComCall(7, this.p, IHTMLDOMNode.Ptr, p)
    get_startOffset(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_endContainer(p)
      => ComCall(9, this.p, IHTMLDOMNode.Ptr, p)
    get_endOffset(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_collapsed(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    get_commonAncestorContainer(p)
      => ComCall(12, this.p, IHTMLDOMNode.Ptr, p)
    setStart(refNode, offset)
      => ComCall(13, this.p, IDispatch, refNode, Int32, offset)
    setEnd(refNode, offset)
      => ComCall(14, this.p, IDispatch, refNode, Int32, offset)
    setStartBefore(refNode)
      => ComCall(15, this.p, IDispatch, refNode)
    setStartAfter(refNode)
      => ComCall(16, this.p, IDispatch, refNode)
    setEndBefore(refNode)
      => ComCall(17, this.p, IDispatch, refNode)
    setEndAfter(refNode)
      => ComCall(18, this.p, IDispatch, refNode)
    collapse(toStart)
      => ComCall(19, this.p, VARIANT_BOOL, toStart)
    selectNode(refNode)
      => ComCall(20, this.p, IDispatch, refNode)
    selectNodeContents(refNode)
      => ComCall(21, this.p, IDispatch, refNode)
    compareBoundaryPoints(how, sourceRange, compareResult)
      => ComCall(22, this.p, Int16, how, IDispatch, sourceRange, Int32.Ptr, compareResult)
    deleteContents()
      => ComCall(23, this.p)
    extractContents(ppDocumentFragment)
      => ComCall(24, this.p, IDispatch.Ptr, ppDocumentFragment)
    cloneContents(ppDocumentFragment)
      => ComCall(25, this.p, IDispatch.Ptr, ppDocumentFragment)
    insertNode(newNode)
      => ComCall(26, this.p, IDispatch, newNode)
    surroundContents(newParent)
      => ComCall(27, this.p, IDispatch, newParent)
    cloneRange(ppClonedRange)
      => ComCall(28, this.p, IHTMLDOMRange.Ptr, ppClonedRange)
    toString(pRangeString)
      => ComCall(29, this.p, BSTR.Ptr, pRangeString)
    detach()
      => ComCall(30, this.p)
    getClientRects(ppRectCol)
      => ComCall(31, this.p, IHTMLRectCollection.Ptr, ppRectCol)
    getBoundingClientRect(ppRect)
      => ComCall(32, this.p, IHTMLRect.Ptr, ppRect)
}
struct DispHTMLDOMRange extends IDispatch {
    static IID := "{3050F5A3-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLFormElementEvents2 extends IDispatch {
    static IID := "{3050F614-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLFormElementEvents extends IDispatch {
    static IID := "{3050F364-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFormElement extends IDispatch {
    static IID := "{3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_action(v)
      => ComCall(7, this.p, BSTR, v)
    get_action(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_dir(v)
      => ComCall(9, this.p, BSTR, v)
    get_dir(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_encoding(v)
      => ComCall(11, this.p, BSTR, v)
    get_encoding(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_method(v)
      => ComCall(13, this.p, BSTR, v)
    get_method(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    get_elements(p)
      => ComCall(15, this.p, IDispatch.Ptr, p)
    put_target(v)
      => ComCall(16, this.p, BSTR, v)
    get_target(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(18, this.p, BSTR, v)
    get_name(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_onsubmit(v)
      => ComCall(20, this.p, VARIANT, v)
    get_onsubmit(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_onreset(v)
      => ComCall(22, this.p, VARIANT, v)
    get_onreset(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    submit()
      => ComCall(24, this.p)
    reset()
      => ComCall(25, this.p)
    put_length(v)
      => ComCall(26, this.p, Int32, v)
    get_length(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(28, this.p, IUnknown.Ptr, p)
    item(name, index, pdisp)
      => ComCall(29, this.p, VARIANT, name, VARIANT, index, IDispatch.Ptr, pdisp)
    tags(tagName, pdisp)
      => ComCall(30, this.p, VARIANT, tagName, IDispatch.Ptr, pdisp)
}
struct IHTMLFormElement2 extends IDispatch {
    static IID := "{3050F4F6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_acceptCharset(v)
      => ComCall(7, this.p, BSTR, v)
    get_acceptCharset(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    urns(urn, pdisp)
      => ComCall(9, this.p, VARIANT, urn, IDispatch.Ptr, pdisp)
}
struct IHTMLFormElement3 extends IDispatch {
    static IID := "{3050F836-98B5-11CF-BB82-00AA00BDCE0B}"
    namedItem(name, pdisp)
      => ComCall(7, this.p, BSTR, name, IDispatch.Ptr, pdisp)
}
struct IHTMLSubmitData extends IDispatch {
    static IID := "{3050F645-98B5-11CF-BB82-00AA00BDCE0B}"
    appendNameValuePair(name, value)
      => ComCall(7, this.p, BSTR, name, BSTR, value)
    appendNameFilePair(name, filename)
      => ComCall(8, this.p, BSTR, name, BSTR, filename)
    appendItemSeparator()
      => ComCall(9, this.p)
}
struct IHTMLFormElement4 extends IDispatch {
    static IID := "{3051042C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_action(v)
      => ComCall(7, this.p, BSTR, v)
    get_action(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLFormElement extends IDispatch {
    static IID := "{3050F510-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLControlElementEvents2 extends IDispatch {
    static IID := "{3050F612-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLControlElementEvents extends IDispatch {
    static IID := "{3050F4EA-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLControlElement extends IDispatch {
    static IID := "{3050F4E9-98B5-11CF-BB82-00AA00BDCE0B}"
    put_tabIndex(v)
      => ComCall(7, this.p, Int16, v)
    get_tabIndex(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    focus()
      => ComCall(9, this.p)
    put_accessKey(v)
      => ComCall(10, this.p, BSTR, v)
    get_accessKey(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_onblur(v)
      => ComCall(12, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_onfocus(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_onresize(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onresize(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    blur()
      => ComCall(18, this.p)
    addFilter(pUnk)
      => ComCall(19, this.p, IUnknown, pUnk)
    removeFilter(pUnk)
      => ComCall(20, this.p, IUnknown, pUnk)
    get_clientHeight(p)
      => ComCall(21, this.p, Int32.Ptr, p)
    get_clientWidth(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    get_clientTop(p)
      => ComCall(23, this.p, Int32.Ptr, p)
    get_clientLeft(p)
      => ComCall(24, this.p, Int32.Ptr, p)
}
struct IHTMLTextElement extends IDispatch {
    static IID := "{3050F218-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTextElement extends IDispatch {
    static IID := "{3050F537-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLTextContainerEvents2 extends IDispatch {
    static IID := "{3050F624-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLTextContainerEvents extends IDispatch {
    static IID := "{1FF6AA72-5842-11CF-A707-00AA00C0098D}"
}
struct IHTMLTextContainer extends IDispatch {
    static IID := "{3050F230-98B5-11CF-BB82-00AA00BDCE0B}"
    createControlRange(range)
      => ComCall(7, this.p, IDispatch.Ptr, range)
    get_scrollHeight(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_scrollWidth(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    put_scrollTop(v)
      => ComCall(10, this.p, Int32, v)
    get_scrollTop(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    put_scrollLeft(v)
      => ComCall(12, this.p, Int32, v)
    get_scrollLeft(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    put_onscroll(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onscroll(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
}
struct IHTMLControlRange extends IDispatch {
    static IID := "{3050F29C-98B5-11CF-BB82-00AA00BDCE0B}"
    select()
      => ComCall(7, this.p)
    add(item)
      => ComCall(8, this.p, IHTMLControlElement, item)
    remove(index)
      => ComCall(9, this.p, Int32, index)
    item(index, pdisp)
      => ComCall(10, this.p, Int32, index, IHTMLElement.Ptr, pdisp)
    scrollIntoView(varargStart)
      => ComCall(11, this.p, VARIANT, varargStart)
    queryCommandSupported(cmdID, pfRet)
      => ComCall(12, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandEnabled(cmdID, pfRet)
      => ComCall(13, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandState(cmdID, pfRet)
      => ComCall(14, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandIndeterm(cmdID, pfRet)
      => ComCall(15, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandText(cmdID, pcmdText)
      => ComCall(16, this.p, BSTR, cmdID, BSTR.Ptr, pcmdText)
    queryCommandValue(cmdID, pcmdValue)
      => ComCall(17, this.p, BSTR, cmdID, VARIANT.Ptr, pcmdValue)
    execCommand(cmdID, showUI, value, pfRet)
      => ComCall(18, this.p, BSTR, cmdID, VARIANT_BOOL, showUI, VARIANT, value, VARIANT_BOOL.Ptr, pfRet)
    execCommandShowHelp(cmdID, pfRet)
      => ComCall(19, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    commonParentElement(parent)
      => ComCall(20, this.p, IHTMLElement.Ptr, parent)
    get_length(p)
      => ComCall(21, this.p, Int32.Ptr, p)
}
struct IHTMLControlRange2 extends IDispatch {
    static IID := "{3050F65E-98B5-11CF-BB82-00AA00BDCE0B}"
    addElement(item)
      => ComCall(7, this.p, IHTMLElement, item)
}
struct HTMLImgEvents2 extends IDispatch {
    static IID := "{3050F616-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLImgEvents extends IDispatch {
    static IID := "{3050F25B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLImgElement extends IDispatch {
    static IID := "{3050F240-98B5-11CF-BB82-00AA00BDCE0B}"
    put_isMap(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_isMap(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_useMap(v)
      => ComCall(9, this.p, BSTR, v)
    get_useMap(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_mimeType(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    get_fileSize(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_fileCreatedDate(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_fileModifiedDate(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    get_fileUpdatedDate(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    get_protocol(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    get_href(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_nameProp(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(19, this.p, VARIANT, v)
    get_border(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_vspace(v)
      => ComCall(21, this.p, Int32, v)
    get_vspace(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(23, this.p, Int32, v)
    get_hspace(p)
      => ComCall(24, this.p, Int32.Ptr, p)
    put_alt(v)
      => ComCall(25, this.p, BSTR, v)
    get_alt(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_src(v)
      => ComCall(27, this.p, BSTR, v)
    get_src(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_lowsrc(v)
      => ComCall(29, this.p, BSTR, v)
    get_lowsrc(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_vrml(v)
      => ComCall(31, this.p, BSTR, v)
    get_vrml(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_dynsrc(v)
      => ComCall(33, this.p, BSTR, v)
    get_dynsrc(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    get_readyState(p)
      => ComCall(35, this.p, BSTR.Ptr, p)
    get_complete(p)
      => ComCall(36, this.p, VARIANT_BOOL.Ptr, p)
    put_loop(v)
      => ComCall(37, this.p, VARIANT, v)
    get_loop(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_align(v)
      => ComCall(39, this.p, BSTR, v)
    get_align(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    put_onload(v)
      => ComCall(41, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(42, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(43, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    put_onabort(v)
      => ComCall(45, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(46, this.p, VARIANT.Ptr, p)
    put_name(v)
      => ComCall(47, this.p, BSTR, v)
    get_name(p)
      => ComCall(48, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(49, this.p, Int32, v)
    get_width(p)
      => ComCall(50, this.p, Int32.Ptr, p)
    put_height(v)
      => ComCall(51, this.p, Int32, v)
    get_height(p)
      => ComCall(52, this.p, Int32.Ptr, p)
    put_start(v)
      => ComCall(53, this.p, BSTR, v)
    get_start(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
}
struct IHTMLImgElement2 extends IDispatch {
    static IID := "{3050F826-98B5-11CF-BB82-00AA00BDCE0B}"
    put_longDesc(v)
      => ComCall(7, this.p, BSTR, v)
    get_longDesc(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLImgElement3 extends IDispatch {
    static IID := "{30510434-98B5-11CF-BB82-00AA00BDCE0B}"
    put_longDesc(v)
      => ComCall(7, this.p, BSTR, v)
    get_longDesc(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_vrml(v)
      => ComCall(9, this.p, BSTR, v)
    get_vrml(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_lowsrc(v)
      => ComCall(11, this.p, BSTR, v)
    get_lowsrc(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_dynsrc(v)
      => ComCall(13, this.p, BSTR, v)
    get_dynsrc(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct IHTMLImgElement4 extends IDispatch {
    static IID := "{305107F6-98B5-11CF-BB82-00AA00BDCE0B}"
    get_naturalWidth(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_naturalHeight(p)
      => ComCall(8, this.p, Int32.Ptr, p)
}
struct IHTMLMSImgElement extends IDispatch {
    static IID := "{30510793-98B5-11CF-BB82-00AA00BDCE0B}"
    put_msPlayToDisabled(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_msPlayToDisabled(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_msPlayToPrimary(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_msPlayToPrimary(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLImageElementFactory extends IDispatch {
    static IID := "{3050F38E-98B5-11CF-BB82-00AA00BDCE0B}"
    create(width, height, __MIDL__IHTMLImageElementFactory0000)
      => ComCall(7, this.p, VARIANT, width, VARIANT, height, IHTMLImgElement.Ptr, __MIDL__IHTMLImageElementFactory0000)
}
struct DispHTMLImg extends IDispatch {
    static IID := "{3050F51C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBodyElement extends IDispatch {
    static IID := "{3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}"
    put_background(v)
      => ComCall(7, this.p, BSTR, v)
    get_background(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_bgProperties(v)
      => ComCall(9, this.p, BSTR, v)
    get_bgProperties(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_leftMargin(v)
      => ComCall(11, this.p, VARIANT, v)
    get_leftMargin(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_topMargin(v)
      => ComCall(13, this.p, VARIANT, v)
    get_topMargin(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_rightMargin(v)
      => ComCall(15, this.p, VARIANT, v)
    get_rightMargin(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_bottomMargin(v)
      => ComCall(17, this.p, VARIANT, v)
    get_bottomMargin(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_noWrap(v)
      => ComCall(19, this.p, VARIANT_BOOL, v)
    get_noWrap(p)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, p)
    put_bgColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_text(v)
      => ComCall(23, this.p, VARIANT, v)
    get_text(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_link(v)
      => ComCall(25, this.p, VARIANT, v)
    get_link(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_vLink(v)
      => ComCall(27, this.p, VARIANT, v)
    get_vLink(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_aLink(v)
      => ComCall(29, this.p, VARIANT, v)
    get_aLink(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onunload(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onunload(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_scroll(v)
      => ComCall(35, this.p, BSTR, v)
    get_scroll(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_onselect(v)
      => ComCall(37, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_onbeforeunload(v)
      => ComCall(39, this.p, VARIANT, v)
    get_onbeforeunload(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    createTextRange(range)
      => ComCall(41, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLBodyElement2 extends IDispatch {
    static IID := "{3050F5C5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onbeforeprint(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onbeforeprint(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onafterprint(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onafterprint(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLBodyElement3 extends IDispatch {
    static IID := "{30510422-98B5-11CF-BB82-00AA00BDCE0B}"
    put_background(v)
      => ComCall(7, this.p, BSTR, v)
    get_background(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_ononline(v)
      => ComCall(9, this.p, VARIANT, v)
    get_ononline(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onoffline(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onoffline(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_onhashchange(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onhashchange(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
}
struct IHTMLBodyElement4 extends IDispatch {
    static IID := "{30510795-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmessage(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmessage(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onstorage(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onstorage(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLBodyElement5 extends IDispatch {
    static IID := "{30510822-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onpopstate(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onpopstate(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
}
struct DispHTMLBody extends IDispatch {
    static IID := "{3050F507-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFontElement extends IDispatch {
    static IID := "{3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}"
    put_color(v)
      => ComCall(7, this.p, VARIANT, v)
    get_color(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_face(v)
      => ComCall(9, this.p, BSTR, v)
    get_face(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_size(v)
      => ComCall(11, this.p, VARIANT, v)
    get_size(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
}
struct DispHTMLFontElement extends IDispatch {
    static IID := "{3050F512-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLAnchorEvents2 extends IDispatch {
    static IID := "{3050F610-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLAnchorEvents extends IDispatch {
    static IID := "{3050F29D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLAnchorElement extends IDispatch {
    static IID := "{3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_target(v)
      => ComCall(9, this.p, BSTR, v)
    get_target(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_rel(v)
      => ComCall(11, this.p, BSTR, v)
    get_rel(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_rev(v)
      => ComCall(13, this.p, BSTR, v)
    get_rev(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_urn(v)
      => ComCall(15, this.p, BSTR, v)
    get_urn(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_Methods(v)
      => ComCall(17, this.p, BSTR, v)
    get_Methods(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(19, this.p, BSTR, v)
    get_name(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_host(v)
      => ComCall(21, this.p, BSTR, v)
    get_host(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_hostname(v)
      => ComCall(23, this.p, BSTR, v)
    get_hostname(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_pathname(v)
      => ComCall(25, this.p, BSTR, v)
    get_pathname(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_port(v)
      => ComCall(27, this.p, BSTR, v)
    get_port(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_protocol(v)
      => ComCall(29, this.p, BSTR, v)
    get_protocol(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_search(v)
      => ComCall(31, this.p, BSTR, v)
    get_search(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_hash(v)
      => ComCall(33, this.p, BSTR, v)
    get_hash(p)
      => ComCall(34, this.p, BSTR.Ptr, p)
    put_onblur(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_onfocus(v)
      => ComCall(37, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(38, this.p, VARIANT.Ptr, p)
    put_accessKey(v)
      => ComCall(39, this.p, BSTR, v)
    get_accessKey(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    get_protocolLong(p)
      => ComCall(41, this.p, BSTR.Ptr, p)
    get_mimeType(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    get_nameProp(p)
      => ComCall(43, this.p, BSTR.Ptr, p)
    put_tabIndex(v)
      => ComCall(44, this.p, Int16, v)
    get_tabIndex(p)
      => ComCall(45, this.p, Int16.Ptr, p)
    focus()
      => ComCall(46, this.p)
    blur()
      => ComCall(47, this.p)
}
struct IHTMLAnchorElement2 extends IDispatch {
    static IID := "{3050F825-98B5-11CF-BB82-00AA00BDCE0B}"
    put_charset(v)
      => ComCall(7, this.p, BSTR, v)
    get_charset(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_coords(v)
      => ComCall(9, this.p, BSTR, v)
    get_coords(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_hreflang(v)
      => ComCall(11, this.p, BSTR, v)
    get_hreflang(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_shape(v)
      => ComCall(13, this.p, BSTR, v)
    get_shape(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(15, this.p, BSTR, v)
    get_type(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
}
struct IHTMLAnchorElement3 extends IDispatch {
    static IID := "{3051041D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_shape(v)
      => ComCall(7, this.p, BSTR, v)
    get_shape(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_coords(v)
      => ComCall(9, this.p, BSTR, v)
    get_coords(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_href(v)
      => ComCall(11, this.p, BSTR, v)
    get_href(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct DispHTMLAnchorElement extends IDispatch {
    static IID := "{3050F502-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLLabelEvents2 extends IDispatch {
    static IID := "{3050F61C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLLabelEvents extends IDispatch {
    static IID := "{3050F329-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLLabelElement extends IDispatch {
    static IID := "{3050F32A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_htmlFor(v)
      => ComCall(7, this.p, BSTR, v)
    get_htmlFor(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_accessKey(v)
      => ComCall(9, this.p, BSTR, v)
    get_accessKey(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLLabelElement2 extends IDispatch {
    static IID := "{3050F832-98B5-11CF-BB82-00AA00BDCE0B}"
    get_form(p)
      => ComCall(7, this.p, IHTMLFormElement.Ptr, p)
}
struct DispHTMLLabelElement extends IDispatch {
    static IID := "{3050F522-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLListElement extends IDispatch {
    static IID := "{3050F20E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLListElement2 extends IDispatch {
    static IID := "{3050F822-98B5-11CF-BB82-00AA00BDCE0B}"
    put_compact(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_compact(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLListElement extends IDispatch {
    static IID := "{3050F525-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLUListElement extends IDispatch {
    static IID := "{3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}"
    put_compact(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_compact(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_type(v)
      => ComCall(9, this.p, BSTR, v)
    get_type(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct DispHTMLUListElement extends IDispatch {
    static IID := "{3050F538-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLOListElement extends IDispatch {
    static IID := "{3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}"
    put_compact(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_compact(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_start(v)
      => ComCall(9, this.p, Int32, v)
    get_start(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    put_type(v)
      => ComCall(11, this.p, BSTR, v)
    get_type(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct DispHTMLOListElement extends IDispatch {
    static IID := "{3050F52A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLLIElement extends IDispatch {
    static IID := "{3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, Int32, v)
    get_value(p)
      => ComCall(10, this.p, Int32.Ptr, p)
}
struct DispHTMLLIElement extends IDispatch {
    static IID := "{3050F523-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBlockElement extends IDispatch {
    static IID := "{3050F208-98B5-11CF-BB82-00AA00BDCE0B}"
    put_clear(v)
      => ComCall(7, this.p, BSTR, v)
    get_clear(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLBlockElement2 extends IDispatch {
    static IID := "{3050F823-98B5-11CF-BB82-00AA00BDCE0B}"
    put_cite(v)
      => ComCall(7, this.p, BSTR, v)
    get_cite(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(9, this.p, BSTR, v)
    get_width(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLBlockElement3 extends IDispatch {
    static IID := "{30510494-98B5-11CF-BB82-00AA00BDCE0B}"
    put_cite(v)
      => ComCall(7, this.p, BSTR, v)
    get_cite(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLBlockElement extends IDispatch {
    static IID := "{3050F506-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDivElement extends IDispatch {
    static IID := "{3050F200-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_noWrap(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_noWrap(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLDivElement extends IDispatch {
    static IID := "{3050F50C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDDElement extends IDispatch {
    static IID := "{3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}"
    put_noWrap(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_noWrap(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLDDElement extends IDispatch {
    static IID := "{3050F50B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDTElement extends IDispatch {
    static IID := "{3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_noWrap(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_noWrap(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLDTElement extends IDispatch {
    static IID := "{3050F50D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBRElement extends IDispatch {
    static IID := "{3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}"
    put_clear(v)
      => ComCall(7, this.p, BSTR, v)
    get_clear(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLBRElement extends IDispatch {
    static IID := "{3050F53A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDListElement extends IDispatch {
    static IID := "{3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}"
    put_compact(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_compact(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLDListElement extends IDispatch {
    static IID := "{3050F53B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLHRElement extends IDispatch {
    static IID := "{3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_color(v)
      => ComCall(9, this.p, VARIANT, v)
    get_color(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_noShade(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_noShade(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    put_width(v)
      => ComCall(13, this.p, VARIANT, v)
    get_width(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_size(v)
      => ComCall(15, this.p, VARIANT, v)
    get_size(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
}
struct DispHTMLHRElement extends IDispatch {
    static IID := "{3050F53D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLParaElement extends IDispatch {
    static IID := "{3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLParaElement extends IDispatch {
    static IID := "{3050F52C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLElementCollection2 extends IDispatch {
    static IID := "{3050F5EE-98B5-11CF-BB82-00AA00BDCE0B}"
    urns(urn, pdisp)
      => ComCall(7, this.p, VARIANT, urn, IDispatch.Ptr, pdisp)
}
struct IHTMLElementCollection3 extends IDispatch {
    static IID := "{3050F835-98B5-11CF-BB82-00AA00BDCE0B}"
    namedItem(name, pdisp)
      => ComCall(7, this.p, BSTR, name, IDispatch.Ptr, pdisp)
}
struct IHTMLElementCollection4 extends IDispatch {
    static IID := "{30510425-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, pNode)
      => ComCall(8, this.p, Int32, index, IHTMLElement2.Ptr, pNode)
    namedItem(name, pNode)
      => ComCall(9, this.p, BSTR, name, IHTMLElement2.Ptr, pNode)
}
struct DispHTMLElementCollection extends IDispatch {
    static IID := "{3050F56B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLHeaderElement extends IDispatch {
    static IID := "{3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLHeaderElement extends IDispatch {
    static IID := "{3050F515-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLSelectElementEvents2 extends IDispatch {
    static IID := "{3050F622-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLSelectElementEvents extends IDispatch {
    static IID := "{3050F302-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLOptionElement extends IDispatch {
    static IID := "{3050F211-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selected(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_selected(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, BSTR, v)
    get_value(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_defaultSelected(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_defaultSelected(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    put_index(v)
      => ComCall(13, this.p, Int32, v)
    get_index(p)
      => ComCall(14, this.p, Int32.Ptr, p)
    put_text(v)
      => ComCall(15, this.p, BSTR, v)
    get_text(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    get_form(p)
      => ComCall(17, this.p, IHTMLFormElement.Ptr, p)
}
struct IHTMLSelectElementEx extends IUnknown {
    static IID := "{3050F2D1-98B5-11CF-BB82-00AA00BDCE0B}"
    ShowDropdown(fShow)
      => ComCall(3, this.p, BOOL, fShow)
    SetSelectExFlags(lFlags)
      => ComCall(4, this.p, UInt32, lFlags)
    GetSelectExFlags(pFlags)
      => ComCall(5, this.p, UInt32.Ptr, pFlags)
    GetDropdownOpen(pfOpen)
      => ComCall(6, this.p, BOOL.Ptr, pfOpen)
}
struct IHTMLSelectElement extends IDispatch {
    static IID := "{3050F244-98B5-11CF-BB82-00AA00BDCE0B}"
    put_size(v)
      => ComCall(7, this.p, Int32, v)
    get_size(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_multiple(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_multiple(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    put_name(v)
      => ComCall(11, this.p, BSTR, v)
    get_name(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_options(p)
      => ComCall(13, this.p, IDispatch.Ptr, p)
    put_onchange(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_selectedIndex(v)
      => ComCall(16, this.p, Int32, v)
    get_selectedIndex(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    get_type(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(19, this.p, BSTR, v)
    get_value(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_disabled(v)
      => ComCall(21, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(23, this.p, IHTMLFormElement.Ptr, p)
    add(element, before)
      => ComCall(24, this.p, IHTMLElement, element, VARIANT, before)
    remove(index)
      => ComCall(25, this.p, Int32, index)
    put_length(v)
      => ComCall(26, this.p, Int32, v)
    get_length(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(28, this.p, IUnknown.Ptr, p)
    item(name, index, pdisp)
      => ComCall(29, this.p, VARIANT, name, VARIANT, index, IDispatch.Ptr, pdisp)
    tags(tagName, pdisp)
      => ComCall(30, this.p, VARIANT, tagName, IDispatch.Ptr, pdisp)
}
struct IHTMLSelectElement2 extends IDispatch {
    static IID := "{3050F5ED-98B5-11CF-BB82-00AA00BDCE0B}"
    urns(urn, pdisp)
      => ComCall(7, this.p, VARIANT, urn, IDispatch.Ptr, pdisp)
}
struct IHTMLSelectElement4 extends IDispatch {
    static IID := "{3050F838-98B5-11CF-BB82-00AA00BDCE0B}"
    namedItem(name, pdisp)
      => ComCall(7, this.p, BSTR, name, IDispatch.Ptr, pdisp)
}
struct IHTMLSelectElement5 extends IDispatch {
    static IID := "{3051049D-98B5-11CF-BB82-00AA00BDCE0B}"
    add(pElem, pvarBefore)
      => ComCall(7, this.p, IHTMLOptionElement, pElem, VARIANT.Ptr, pvarBefore)
}
struct IHTMLSelectElement6 extends IDispatch {
    static IID := "{30510760-98B6-11CF-BB82-00AA00BDCE0B}"
    add(pElem, pvarBefore)
      => ComCall(7, this.p, IHTMLOptionElement, pElem, VARIANT.Ptr, pvarBefore)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispHTMLSelectElement extends IDispatch {
    static IID := "{3050F531-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLWndSelectElement extends IDispatch {
    static IID := "{3050F597-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLSelectionObject extends IDispatch {
    static IID := "{3050F25A-98B5-11CF-BB82-00AA00BDCE0B}"
    createRange(range)
      => ComCall(7, this.p, IDispatch.Ptr, range)
    empty()
      => ComCall(8, this.p)
    clear()
      => ComCall(9, this.p)
    get_type(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLSelectionObject2 extends IDispatch {
    static IID := "{3050F7EC-98B5-11CF-BB82-00AA00BDCE0B}"
    createRangeCollection(rangeCollection)
      => ComCall(7, this.p, IDispatch.Ptr, rangeCollection)
    get_typeDetail(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLSelection extends IDispatch {
    static IID := "{305104B6-98B5-11CF-BB82-00AA00BDCE0B}"
    get_anchorNode(p)
      => ComCall(7, this.p, IHTMLDOMNode.Ptr, p)
    get_anchorOffset(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_focusNode(p)
      => ComCall(9, this.p, IHTMLDOMNode.Ptr, p)
    get_focusOffset(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_isCollapsed(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    collapse(parentNode, offfset)
      => ComCall(12, this.p, IDispatch, parentNode, Int32, offfset)
    collapseToStart()
      => ComCall(13, this.p)
    collapseToEnd()
      => ComCall(14, this.p)
    selectAllChildren(parentNode)
      => ComCall(15, this.p, IDispatch, parentNode)
    deleteFromDocument()
      => ComCall(16, this.p)
    get_rangeCount(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    getRangeAt(index, ppRange)
      => ComCall(18, this.p, Int32, index, IHTMLDOMRange.Ptr, ppRange)
    addRange(range)
      => ComCall(19, this.p, IDispatch, range)
    removeRange(range)
      => ComCall(20, this.p, IDispatch, range)
    removeAllRanges()
      => ComCall(21, this.p)
    toString(pSelectionString)
      => ComCall(22, this.p, BSTR.Ptr, pSelectionString)
}
struct IHTMLOptionElement3 extends IDispatch {
    static IID := "{3050F820-98B5-11CF-BB82-00AA00BDCE0B}"
    put_label(v)
      => ComCall(7, this.p, BSTR, v)
    get_label(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLOptionElement4 extends IDispatch {
    static IID := "{305107B4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_value(v)
      => ComCall(7, this.p, BSTR, v)
    get_value(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLOptionElementFactory extends IDispatch {
    static IID := "{3050F38C-98B5-11CF-BB82-00AA00BDCE0B}"
    create(text, value, defaultselected, selected, __MIDL__IHTMLOptionElementFactory0000)
      => ComCall(7, this.p, VARIANT, text, VARIANT, value, VARIANT, defaultselected, VARIANT, selected, IHTMLOptionElement.Ptr, __MIDL__IHTMLOptionElementFactory0000)
}
struct DispHTMLOptionElement extends IDispatch {
    static IID := "{3050F52B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLWndOptionElement extends IDispatch {
    static IID := "{3050F598-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLButtonElementEvents2 extends IDispatch {
    static IID := "{3050F617-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLButtonElementEvents extends IDispatch {
    static IID := "{3050F2B3-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputTextElementEvents2 extends IDispatch {
    static IID := "{3050F618-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLOptionButtonElementEvents2 extends IDispatch {
    static IID := "{3050F619-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputFileElementEvents2 extends IDispatch {
    static IID := "{3050F61A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputImageEvents2 extends IDispatch {
    static IID := "{3050F61B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputTextElementEvents extends IDispatch {
    static IID := "{3050F2A7-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLOptionButtonElementEvents extends IDispatch {
    static IID := "{3050F2BD-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputFileElementEvents extends IDispatch {
    static IID := "{3050F2AF-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLInputImageEvents extends IDispatch {
    static IID := "{3050F2C3-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLInputElement extends IDispatch {
    static IID := "{3050F5D2-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, BSTR, v)
    get_value(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(11, this.p, BSTR, v)
    get_name(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(13, this.p, VARIANT_BOOL, v)
    get_status(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    put_disabled(v)
      => ComCall(15, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(17, this.p, IHTMLFormElement.Ptr, p)
    put_size(v)
      => ComCall(18, this.p, Int32, v)
    get_size(p)
      => ComCall(19, this.p, Int32.Ptr, p)
    put_maxLength(v)
      => ComCall(20, this.p, Int32, v)
    get_maxLength(p)
      => ComCall(21, this.p, Int32.Ptr, p)
    select()
      => ComCall(22, this.p)
    put_onchange(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_defaultValue(v)
      => ComCall(27, this.p, BSTR, v)
    get_defaultValue(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_readOnly(v)
      => ComCall(29, this.p, VARIANT_BOOL, v)
    get_readOnly(p)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, p)
    createTextRange(range)
      => ComCall(31, this.p, IHTMLTxtRange.Ptr, range)
    put_indeterminate(v)
      => ComCall(32, this.p, VARIANT_BOOL, v)
    get_indeterminate(p)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, p)
    put_defaultChecked(v)
      => ComCall(34, this.p, VARIANT_BOOL, v)
    get_defaultChecked(p)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, p)
    put_checked(v)
      => ComCall(36, this.p, VARIANT_BOOL, v)
    get_checked(p)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, p)
    put_border(v)
      => ComCall(38, this.p, VARIANT, v)
    get_border(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    put_vspace(v)
      => ComCall(40, this.p, Int32, v)
    get_vspace(p)
      => ComCall(41, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(42, this.p, Int32, v)
    get_hspace(p)
      => ComCall(43, this.p, Int32.Ptr, p)
    put_alt(v)
      => ComCall(44, this.p, BSTR, v)
    get_alt(p)
      => ComCall(45, this.p, BSTR.Ptr, p)
    put_src(v)
      => ComCall(46, this.p, BSTR, v)
    get_src(p)
      => ComCall(47, this.p, BSTR.Ptr, p)
    put_lowsrc(v)
      => ComCall(48, this.p, BSTR, v)
    get_lowsrc(p)
      => ComCall(49, this.p, BSTR.Ptr, p)
    put_vrml(v)
      => ComCall(50, this.p, BSTR, v)
    get_vrml(p)
      => ComCall(51, this.p, BSTR.Ptr, p)
    put_dynsrc(v)
      => ComCall(52, this.p, BSTR, v)
    get_dynsrc(p)
      => ComCall(53, this.p, BSTR.Ptr, p)
    get_readyState(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    get_complete(p)
      => ComCall(55, this.p, VARIANT_BOOL.Ptr, p)
    put_loop(v)
      => ComCall(56, this.p, VARIANT, v)
    get_loop(p)
      => ComCall(57, this.p, VARIANT.Ptr, p)
    put_align(v)
      => ComCall(58, this.p, BSTR, v)
    get_align(p)
      => ComCall(59, this.p, BSTR.Ptr, p)
    put_onload(v)
      => ComCall(60, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(61, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(62, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(63, this.p, VARIANT.Ptr, p)
    put_onabort(v)
      => ComCall(64, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(65, this.p, VARIANT.Ptr, p)
    put_width(v)
      => ComCall(66, this.p, Int32, v)
    get_width(p)
      => ComCall(67, this.p, Int32.Ptr, p)
    put_height(v)
      => ComCall(68, this.p, Int32, v)
    get_height(p)
      => ComCall(69, this.p, Int32.Ptr, p)
    put_start(v)
      => ComCall(70, this.p, BSTR, v)
    get_start(p)
      => ComCall(71, this.p, BSTR.Ptr, p)
}
struct IHTMLInputElement2 extends IDispatch {
    static IID := "{3050F821-98B5-11CF-BB82-00AA00BDCE0B}"
    put_accept(v)
      => ComCall(7, this.p, BSTR, v)
    get_accept(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_useMap(v)
      => ComCall(9, this.p, BSTR, v)
    get_useMap(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLInputElement3 extends IDispatch {
    static IID := "{30510435-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_lowsrc(v)
      => ComCall(9, this.p, BSTR, v)
    get_lowsrc(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_vrml(v)
      => ComCall(11, this.p, BSTR, v)
    get_vrml(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_dynsrc(v)
      => ComCall(13, this.p, BSTR, v)
    get_dynsrc(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct IHTMLInputButtonElement extends IDispatch {
    static IID := "{3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, VARIANT, v)
    get_status(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(16, this.p, IHTMLFormElement.Ptr, p)
    createTextRange(range)
      => ComCall(17, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLInputHiddenElement extends IDispatch {
    static IID := "{3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, VARIANT, v)
    get_status(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(16, this.p, IHTMLFormElement.Ptr, p)
    createTextRange(range)
      => ComCall(17, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLInputTextElement extends IDispatch {
    static IID := "{3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, VARIANT, v)
    get_status(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(16, this.p, IHTMLFormElement.Ptr, p)
    put_defaultValue(v)
      => ComCall(17, this.p, BSTR, v)
    get_defaultValue(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_size(v)
      => ComCall(19, this.p, Int32, v)
    get_size(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    put_maxLength(v)
      => ComCall(21, this.p, Int32, v)
    get_maxLength(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    select()
      => ComCall(23, this.p)
    put_onchange(v)
      => ComCall(24, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(25, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(26, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_readOnly(v)
      => ComCall(28, this.p, VARIANT_BOOL, v)
    get_readOnly(p)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, p)
    createTextRange(range)
      => ComCall(30, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLInputTextElement2 extends IDispatch {
    static IID := "{3050F2D2-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectionStart(v)
      => ComCall(7, this.p, Int32, v)
    get_selectionStart(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_selectionEnd(v)
      => ComCall(9, this.p, Int32, v)
    get_selectionEnd(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    setSelectionRange(start, end)
      => ComCall(11, this.p, Int32, start, Int32, end)
}
struct IHTMLInputFileElement extends IDispatch {
    static IID := "{3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(8, this.p, BSTR, v)
    get_name(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(10, this.p, VARIANT, v)
    get_status(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(12, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(14, this.p, IHTMLFormElement.Ptr, p)
    put_size(v)
      => ComCall(15, this.p, Int32, v)
    get_size(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    put_maxLength(v)
      => ComCall(17, this.p, Int32, v)
    get_maxLength(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    select()
      => ComCall(19, this.p)
    put_onchange(v)
      => ComCall(20, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(22, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_value(v)
      => ComCall(24, this.p, BSTR, v)
    get_value(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
}
struct IHTMLOptionButtonElement extends IDispatch {
    static IID := "{3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}"
    put_value(v)
      => ComCall(7, this.p, BSTR, v)
    get_value(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_type(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_checked(v)
      => ComCall(12, this.p, VARIANT_BOOL, v)
    get_checked(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    put_defaultChecked(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_defaultChecked(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    put_onchange(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(18, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
    put_status(v)
      => ComCall(20, this.p, VARIANT_BOOL, v)
    get_status(p)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, p)
    put_indeterminate(v)
      => ComCall(22, this.p, VARIANT_BOOL, v)
    get_indeterminate(p)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(24, this.p, IHTMLFormElement.Ptr, p)
}
struct IHTMLInputImage extends IDispatch {
    static IID := "{3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_disabled(v)
      => ComCall(8, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    put_border(v)
      => ComCall(10, this.p, VARIANT, v)
    get_border(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    put_vspace(v)
      => ComCall(12, this.p, Int32, v)
    get_vspace(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(14, this.p, Int32, v)
    get_hspace(p)
      => ComCall(15, this.p, Int32.Ptr, p)
    put_alt(v)
      => ComCall(16, this.p, BSTR, v)
    get_alt(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_src(v)
      => ComCall(18, this.p, BSTR, v)
    get_src(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_lowsrc(v)
      => ComCall(20, this.p, BSTR, v)
    get_lowsrc(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    put_vrml(v)
      => ComCall(22, this.p, BSTR, v)
    get_vrml(p)
      => ComCall(23, this.p, BSTR.Ptr, p)
    put_dynsrc(v)
      => ComCall(24, this.p, BSTR, v)
    get_dynsrc(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
    get_readyState(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    get_complete(p)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, p)
    put_loop(v)
      => ComCall(28, this.p, VARIANT, v)
    get_loop(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    put_align(v)
      => ComCall(30, this.p, BSTR, v)
    get_align(p)
      => ComCall(31, this.p, BSTR.Ptr, p)
    put_onload(v)
      => ComCall(32, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(34, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    put_onabort(v)
      => ComCall(36, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    put_name(v)
      => ComCall(38, this.p, BSTR, v)
    get_name(p)
      => ComCall(39, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(40, this.p, Int32, v)
    get_width(p)
      => ComCall(41, this.p, Int32.Ptr, p)
    put_height(v)
      => ComCall(42, this.p, Int32, v)
    get_height(p)
      => ComCall(43, this.p, Int32.Ptr, p)
    put_start(v)
      => ComCall(44, this.p, BSTR, v)
    get_start(p)
      => ComCall(45, this.p, BSTR.Ptr, p)
}
struct IHTMLInputRangeElement extends IDispatch {
    static IID := "{3050F2D4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_disabled(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_type(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_alt(v)
      => ComCall(10, this.p, BSTR, v)
    get_alt(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(12, this.p, BSTR, v)
    get_name(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(14, this.p, BSTR, v)
    get_value(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_min(v)
      => ComCall(16, this.p, BSTR, v)
    get_min(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_max(v)
      => ComCall(18, this.p, BSTR, v)
    get_max(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_step(v)
      => ComCall(20, this.p, BSTR, v)
    get_step(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    put_valueAsNumber(v)
      => ComCall(22, this.p, Float64, v)
    get_valueAsNumber(p)
      => ComCall(23, this.p, Float64.Ptr, p)
    stepUp(n)
      => ComCall(24, this.p, Int32, n)
    stepDown(n)
      => ComCall(25, this.p, Int32, n)
}
struct DispHTMLInputElement extends IDispatch {
    static IID := "{3050F57D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLTextAreaElement extends IDispatch {
    static IID := "{3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, VARIANT, v)
    get_status(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(16, this.p, IHTMLFormElement.Ptr, p)
    put_defaultValue(v)
      => ComCall(17, this.p, BSTR, v)
    get_defaultValue(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    select()
      => ComCall(19, this.p)
    put_onchange(v)
      => ComCall(20, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(22, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_readOnly(v)
      => ComCall(24, this.p, VARIANT_BOOL, v)
    get_readOnly(p)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, p)
    put_rows(v)
      => ComCall(26, this.p, Int32, v)
    get_rows(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    put_cols(v)
      => ComCall(28, this.p, Int32, v)
    get_cols(p)
      => ComCall(29, this.p, Int32.Ptr, p)
    put_wrap(v)
      => ComCall(30, this.p, BSTR, v)
    get_wrap(p)
      => ComCall(31, this.p, BSTR.Ptr, p)
    createTextRange(range)
      => ComCall(32, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLTextAreaElement2 extends IDispatch {
    static IID := "{3050F2D3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectionStart(v)
      => ComCall(7, this.p, Int32, v)
    get_selectionStart(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_selectionEnd(v)
      => ComCall(9, this.p, Int32, v)
    get_selectionEnd(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    setSelectionRange(start, end)
      => ComCall(11, this.p, Int32, start, Int32, end)
}
struct DispHTMLTextAreaElement extends IDispatch {
    static IID := "{3050F521-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLRichtextElement extends IDispatch {
    static IID := "{3050F54D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLButtonElement extends IDispatch {
    static IID := "{3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(8, this.p, BSTR, v)
    get_value(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(10, this.p, BSTR, v)
    get_name(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, VARIANT, v)
    get_status(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_disabled(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_form(p)
      => ComCall(16, this.p, IHTMLFormElement.Ptr, p)
    createTextRange(range)
      => ComCall(17, this.p, IHTMLTxtRange.Ptr, range)
}
struct IHTMLButtonElement2 extends IDispatch {
    static IID := "{305106F3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLButtonElement extends IDispatch {
    static IID := "{3050F51F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLMarqueeElementEvents2 extends IDispatch {
    static IID := "{3050F61F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLMarqueeElementEvents extends IDispatch {
    static IID := "{3050F2B8-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLMarqueeElement extends IDispatch {
    static IID := "{3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_bgColor(v)
      => ComCall(7, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_scrollDelay(v)
      => ComCall(9, this.p, Int32, v)
    get_scrollDelay(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    put_direction(v)
      => ComCall(11, this.p, BSTR, v)
    get_direction(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_behavior(v)
      => ComCall(13, this.p, BSTR, v)
    get_behavior(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_scrollAmount(v)
      => ComCall(15, this.p, Int32, v)
    get_scrollAmount(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    put_loop(v)
      => ComCall(17, this.p, Int32, v)
    get_loop(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    put_vspace(v)
      => ComCall(19, this.p, Int32, v)
    get_vspace(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(21, this.p, Int32, v)
    get_hspace(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    put_onfinish(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onfinish(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onstart(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onstart(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_onbounce(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onbounce(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_width(v)
      => ComCall(29, this.p, VARIANT, v)
    get_width(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(31, this.p, VARIANT, v)
    get_height(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_trueSpeed(v)
      => ComCall(33, this.p, VARIANT_BOOL, v)
    get_trueSpeed(p)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, p)
    start()
      => ComCall(35, this.p)
    stop()
      => ComCall(36, this.p)
}
struct DispHTMLMarqueeElement extends IDispatch {
    static IID := "{3050F527-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLHtmlElement extends IDispatch {
    static IID := "{3050F81C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_version(v)
      => ComCall(7, this.p, BSTR, v)
    get_version(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLHeadElement extends IDispatch {
    static IID := "{3050F81D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_profile(v)
      => ComCall(7, this.p, BSTR, v)
    get_profile(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLHeadElement2 extends IDispatch {
    static IID := "{3051042F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_profile(v)
      => ComCall(7, this.p, BSTR, v)
    get_profile(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLTitleElement extends IDispatch {
    static IID := "{3050F322-98B5-11CF-BB82-00AA00BDCE0B}"
    put_text(v)
      => ComCall(7, this.p, BSTR, v)
    get_text(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLMetaElement extends IDispatch {
    static IID := "{3050F203-98B5-11CF-BB82-00AA00BDCE0B}"
    put_httpEquiv(v)
      => ComCall(7, this.p, BSTR, v)
    get_httpEquiv(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_content(v)
      => ComCall(9, this.p, BSTR, v)
    get_content(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(11, this.p, BSTR, v)
    get_name(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_url(v)
      => ComCall(13, this.p, BSTR, v)
    get_url(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_charset(v)
      => ComCall(15, this.p, BSTR, v)
    get_charset(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
}
struct IHTMLMetaElement2 extends IDispatch {
    static IID := "{3050F81F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_scheme(v)
      => ComCall(7, this.p, BSTR, v)
    get_scheme(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLMetaElement3 extends IDispatch {
    static IID := "{30510495-98B5-11CF-BB82-00AA00BDCE0B}"
    put_url(v)
      => ComCall(7, this.p, BSTR, v)
    get_url(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLBaseElement extends IDispatch {
    static IID := "{3050F204-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_target(v)
      => ComCall(9, this.p, BSTR, v)
    get_target(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLBaseElement2 extends IDispatch {
    static IID := "{30510420-98B5-11CF-BB82-00AA00BDCE0B}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLHtmlElement extends IDispatch {
    static IID := "{3050F560-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLHeadElement extends IDispatch {
    static IID := "{3050F561-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTitleElement extends IDispatch {
    static IID := "{3050F516-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLMetaElement extends IDispatch {
    static IID := "{3050F517-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLBaseElement extends IDispatch {
    static IID := "{3050F518-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLIsIndexElement extends IDispatch {
    static IID := "{3050F206-98B5-11CF-BB82-00AA00BDCE0B}"
    put_prompt(v)
      => ComCall(7, this.p, BSTR, v)
    get_prompt(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_action(v)
      => ComCall(9, this.p, BSTR, v)
    get_action(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLIsIndexElement2 extends IDispatch {
    static IID := "{3050F82F-98B5-11CF-BB82-00AA00BDCE0B}"
    get_form(p)
      => ComCall(7, this.p, IHTMLFormElement.Ptr, p)
}
struct IHTMLNextIdElement extends IDispatch {
    static IID := "{3050F207-98B5-11CF-BB82-00AA00BDCE0B}"
    put_n(v)
      => ComCall(7, this.p, BSTR, v)
    get_n(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLIsIndexElement extends IDispatch {
    static IID := "{3050F519-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLNextIdElement extends IDispatch {
    static IID := "{3050F51A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBaseFontElement extends IDispatch {
    static IID := "{3050F202-98B5-11CF-BB82-00AA00BDCE0B}"
    put_color(v)
      => ComCall(7, this.p, VARIANT, v)
    get_color(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_face(v)
      => ComCall(9, this.p, BSTR, v)
    get_face(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_size(v)
      => ComCall(11, this.p, Int32, v)
    get_size(p)
      => ComCall(12, this.p, Int32.Ptr, p)
}
struct DispHTMLBaseFontElement extends IDispatch {
    static IID := "{3050F504-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLUnknownElement extends IDispatch {
    static IID := "{3050F209-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLUnknownElement extends IDispatch {
    static IID := "{3050F539-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IWebGeolocation extends IDispatch {
    static IID := "{305107C5-98B5-11CF-BB82-00AA00BDCE0B}"
    getCurrentPosition(successCallback, errorCallback, options)
      => ComCall(7, this.p, IDispatch, successCallback, IDispatch, errorCallback, IDispatch, options)
    watchPosition(successCallback, errorCallback, options, watchId)
      => ComCall(8, this.p, IDispatch, successCallback, IDispatch, errorCallback, IDispatch, options, Int32.Ptr, watchId)
    clearWatch(watchId)
      => ComCall(9, this.p, Int32, watchId)
}
struct IHTMLMimeTypesCollection extends IDispatch {
    static IID := "{3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
}
struct IHTMLPluginsCollection extends IDispatch {
    static IID := "{3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    refresh(reload)
      => ComCall(8, this.p, VARIANT_BOOL, reload)
}
struct IOmHistory extends IDispatch {
    static IID := "{FECEAAA2-8405-11CF-8BA1-00AA00476DA6}"
    get_length(p)
      => ComCall(7, this.p, Int16.Ptr, p)
    back(pvargdistance)
      => ComCall(8, this.p, VARIANT.Ptr, pvargdistance)
    forward(pvargdistance)
      => ComCall(9, this.p, VARIANT.Ptr, pvargdistance)
    go(pvargdistance)
      => ComCall(10, this.p, VARIANT.Ptr, pvargdistance)
}
struct IHTMLOpsProfile extends IDispatch {
    static IID := "{3050F401-98B5-11CF-BB82-00AA00BDCE0B}"
    addRequest(name, reserved, success)
      => ComCall(7, this.p, BSTR, name, VARIANT, reserved, VARIANT_BOOL.Ptr, success)
    clearRequest()
      => ComCall(8, this.p)
    doRequest(usage, fname, domain, path, expire, reserved)
      => ComCall(9, this.p, VARIANT, usage, VARIANT, fname, VARIANT, domain, VARIANT, path, VARIANT, expire, VARIANT, reserved)
    getAttribute(name, value)
      => ComCall(10, this.p, BSTR, name, BSTR.Ptr, value)
    setAttribute(name, value, prefs, success)
      => ComCall(11, this.p, BSTR, name, BSTR, value, VARIANT, prefs, VARIANT_BOOL.Ptr, success)
    commitChanges(success)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, success)
    addReadRequest(name, reserved, success)
      => ComCall(13, this.p, BSTR, name, VARIANT, reserved, VARIANT_BOOL.Ptr, success)
    doReadRequest(usage, fname, domain, path, expire, reserved)
      => ComCall(14, this.p, VARIANT, usage, VARIANT, fname, VARIANT, domain, VARIANT, path, VARIANT, expire, VARIANT, reserved)
    doWriteRequest(success)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, success)
}
struct IOmNavigator extends IDispatch {
    static IID := "{FECEAAA5-8405-11CF-8BA1-00AA00476DA6}"
    get_appCodeName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_appName(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_appVersion(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_userAgent(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    javaEnabled(enabled)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, enabled)
    taintEnabled(enabled)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, enabled)
    get_mimeTypes(p)
      => ComCall(13, this.p, IHTMLMimeTypesCollection.Ptr, p)
    get_plugins(p)
      => ComCall(14, this.p, IHTMLPluginsCollection.Ptr, p)
    get_cookieEnabled(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
    get_opsProfile(p)
      => ComCall(16, this.p, IHTMLOpsProfile.Ptr, p)
    toString(string)
      => ComCall(17, this.p, BSTR.Ptr, string)
    get_cpuClass(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    get_systemLanguage(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    get_browserLanguage(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    get_userLanguage(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    get_platform(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    get_appMinorVersion(p)
      => ComCall(23, this.p, BSTR.Ptr, p)
    get_connectionSpeed(p)
      => ComCall(24, this.p, Int32.Ptr, p)
    get_onLine(p)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, p)
    get_userProfile(p)
      => ComCall(26, this.p, IHTMLOpsProfile.Ptr, p)
}
struct INavigatorGeolocation extends IDispatch {
    static IID := "{305107CF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_geolocation(p)
      => ComCall(7, this.p, IWebGeolocation.Ptr, p)
}
struct INavigatorDoNotTrack extends IDispatch {
    static IID := "{30510804-98B5-11CF-BB82-00AA00BDCE0B}"
    get_msDoNotTrack(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
}
struct IHTMLLocation extends IDispatch {
    static IID := "{163BB1E0-6E00-11CF-837A-48DC04C10000}"
    put_href(v)
      => ComCall(7, this.p, BSTR, v)
    get_href(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_protocol(v)
      => ComCall(9, this.p, BSTR, v)
    get_protocol(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_host(v)
      => ComCall(11, this.p, BSTR, v)
    get_host(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_hostname(v)
      => ComCall(13, this.p, BSTR, v)
    get_hostname(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_port(v)
      => ComCall(15, this.p, BSTR, v)
    get_port(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_pathname(v)
      => ComCall(17, this.p, BSTR, v)
    get_pathname(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_search(v)
      => ComCall(19, this.p, BSTR, v)
    get_search(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_hash(v)
      => ComCall(21, this.p, BSTR, v)
    get_hash(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    reload(flag)
      => ComCall(23, this.p, VARIANT_BOOL, flag)
    replace(bstr1)
      => ComCall(24, this.p, BSTR, bstr1)
    assign(bstr1)
      => ComCall(25, this.p, BSTR, bstr1)
    toString(string)
      => ComCall(26, this.p, BSTR.Ptr, string)
}
struct DispHTMLHistory extends IDispatch {
    static IID := "{3050F549-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLNavigator extends IDispatch {
    static IID := "{3050F54C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLLocation extends IDispatch {
    static IID := "{3050F54E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispCPlugins extends IDispatch {
    static IID := "{3050F54A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBookmarkCollection extends IDispatch {
    static IID := "{3050F4CE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(index, pVarBookmark)
      => ComCall(9, this.p, Int32, index, VARIANT.Ptr, pVarBookmark)
}
struct IHTMLDataTransfer extends IDispatch {
    static IID := "{3050F4B3-98B5-11CF-BB82-00AA00BDCE0B}"
    setData(format, data, pret)
      => ComCall(7, this.p, BSTR, format, VARIANT.Ptr, data, VARIANT_BOOL.Ptr, pret)
    getData(format, pvarRet)
      => ComCall(8, this.p, BSTR, format, VARIANT.Ptr, pvarRet)
    clearData(format, pret)
      => ComCall(9, this.p, BSTR, format, VARIANT_BOOL.Ptr, pret)
    put_dropEffect(v)
      => ComCall(10, this.p, BSTR, v)
    get_dropEffect(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_effectAllowed(v)
      => ComCall(12, this.p, BSTR, v)
    get_effectAllowed(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
}
struct IHTMLEventObj2 extends IDispatch {
    static IID := "{3050F48B-98B5-11CF-BB82-00AA00BDCE0B}"
    setAttribute(strAttributeName, AttributeValue, lFlags)
      => ComCall(7, this.p, BSTR, strAttributeName, VARIANT, AttributeValue, Int32, lFlags)
    getAttribute(strAttributeName, lFlags, AttributeValue)
      => ComCall(8, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT.Ptr, AttributeValue)
    removeAttribute(strAttributeName, lFlags, pfSuccess)
      => ComCall(9, this.p, BSTR, strAttributeName, Int32, lFlags, VARIANT_BOOL.Ptr, pfSuccess)
    put_propertyName(v)
      => ComCall(10, this.p, BSTR, v)
    get_propertyName(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    putref_bookmarks(v)
      => ComCall(12, this.p, IHTMLBookmarkCollection, v)
    get_bookmarks(p)
      => ComCall(13, this.p, IHTMLBookmarkCollection.Ptr, p)
    putref_recordset(v)
      => ComCall(14, this.p, IDispatch, v)
    get_recordset(p)
      => ComCall(15, this.p, IDispatch.Ptr, p)
    put_dataFld(v)
      => ComCall(16, this.p, BSTR, v)
    get_dataFld(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    putref_boundElements(v)
      => ComCall(18, this.p, IHTMLElementCollection, v)
    get_boundElements(p)
      => ComCall(19, this.p, IHTMLElementCollection.Ptr, p)
    put_repeat(v)
      => ComCall(20, this.p, VARIANT_BOOL, v)
    get_repeat(p)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, p)
    put_srcUrn(v)
      => ComCall(22, this.p, BSTR, v)
    get_srcUrn(p)
      => ComCall(23, this.p, BSTR.Ptr, p)
    putref_srcElement(v)
      => ComCall(24, this.p, IHTMLElement, v)
    get_srcElement(p)
      => ComCall(25, this.p, IHTMLElement.Ptr, p)
    put_altKey(v)
      => ComCall(26, this.p, VARIANT_BOOL, v)
    get_altKey(p)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, p)
    put_ctrlKey(v)
      => ComCall(28, this.p, VARIANT_BOOL, v)
    get_ctrlKey(p)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, p)
    put_shiftKey(v)
      => ComCall(30, this.p, VARIANT_BOOL, v)
    get_shiftKey(p)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, p)
    putref_fromElement(v)
      => ComCall(32, this.p, IHTMLElement, v)
    get_fromElement(p)
      => ComCall(33, this.p, IHTMLElement.Ptr, p)
    putref_toElement(v)
      => ComCall(34, this.p, IHTMLElement, v)
    get_toElement(p)
      => ComCall(35, this.p, IHTMLElement.Ptr, p)
    put_button(v)
      => ComCall(36, this.p, Int32, v)
    get_button(p)
      => ComCall(37, this.p, Int32.Ptr, p)
    put_type(v)
      => ComCall(38, this.p, BSTR, v)
    get_type(p)
      => ComCall(39, this.p, BSTR.Ptr, p)
    put_qualifier(v)
      => ComCall(40, this.p, BSTR, v)
    get_qualifier(p)
      => ComCall(41, this.p, BSTR.Ptr, p)
    put_reason(v)
      => ComCall(42, this.p, Int32, v)
    get_reason(p)
      => ComCall(43, this.p, Int32.Ptr, p)
    put_x(v)
      => ComCall(44, this.p, Int32, v)
    get_x(p)
      => ComCall(45, this.p, Int32.Ptr, p)
    put_y(v)
      => ComCall(46, this.p, Int32, v)
    get_y(p)
      => ComCall(47, this.p, Int32.Ptr, p)
    put_clientX(v)
      => ComCall(48, this.p, Int32, v)
    get_clientX(p)
      => ComCall(49, this.p, Int32.Ptr, p)
    put_clientY(v)
      => ComCall(50, this.p, Int32, v)
    get_clientY(p)
      => ComCall(51, this.p, Int32.Ptr, p)
    put_offsetX(v)
      => ComCall(52, this.p, Int32, v)
    get_offsetX(p)
      => ComCall(53, this.p, Int32.Ptr, p)
    put_offsetY(v)
      => ComCall(54, this.p, Int32, v)
    get_offsetY(p)
      => ComCall(55, this.p, Int32.Ptr, p)
    put_screenX(v)
      => ComCall(56, this.p, Int32, v)
    get_screenX(p)
      => ComCall(57, this.p, Int32.Ptr, p)
    put_screenY(v)
      => ComCall(58, this.p, Int32, v)
    get_screenY(p)
      => ComCall(59, this.p, Int32.Ptr, p)
    putref_srcFilter(v)
      => ComCall(60, this.p, IDispatch, v)
    get_srcFilter(p)
      => ComCall(61, this.p, IDispatch.Ptr, p)
    get_dataTransfer(p)
      => ComCall(62, this.p, IHTMLDataTransfer.Ptr, p)
}
struct IHTMLEventObj3 extends IDispatch {
    static IID := "{3050F680-98B5-11CF-BB82-00AA00BDCE0B}"
    get_contentOverflow(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    put_shiftLeft(v)
      => ComCall(8, this.p, VARIANT_BOOL, v)
    get_shiftLeft(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    put_altLeft(v)
      => ComCall(10, this.p, VARIANT_BOOL, v)
    get_altLeft(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    put_ctrlLeft(v)
      => ComCall(12, this.p, VARIANT_BOOL, v)
    get_ctrlLeft(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    get_imeCompositionChange(p)
      => ComCall(14, this.p, IntPtr.Ptr, p)
    get_imeNotifyCommand(p)
      => ComCall(15, this.p, IntPtr.Ptr, p)
    get_imeNotifyData(p)
      => ComCall(16, this.p, IntPtr.Ptr, p)
    get_imeRequest(p)
      => ComCall(17, this.p, IntPtr.Ptr, p)
    get_imeRequestData(p)
      => ComCall(18, this.p, IntPtr.Ptr, p)
    get_keyboardLayout(p)
      => ComCall(19, this.p, IntPtr.Ptr, p)
    get_behaviorCookie(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    get_behaviorPart(p)
      => ComCall(21, this.p, Int32.Ptr, p)
    get_nextPage(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
}
struct IHTMLEventObj4 extends IDispatch {
    static IID := "{3050F814-98B5-11CF-BB82-00AA00BDCE0B}"
    get_wheelDelta(p)
      => ComCall(7, this.p, Int32.Ptr, p)
}
struct IHTMLEventObj5 extends IDispatch {
    static IID := "{30510478-98B5-11CF-BB82-00AA00BDCE0B}"
    put_url(v)
      => ComCall(7, this.p, BSTR, v)
    get_url(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_data(v)
      => ComCall(9, this.p, BSTR, v)
    get_data(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_source(p)
      => ComCall(11, this.p, IDispatch.Ptr, p)
    put_origin(v)
      => ComCall(12, this.p, BSTR, v)
    get_origin(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    put_issession(v)
      => ComCall(14, this.p, VARIANT_BOOL, v)
    get_issession(p)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLEventObj6 extends IDispatch {
    static IID := "{30510734-98B5-11CF-BB82-00AA00BDCE0B}"
    get_actionURL(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_buttonID(p)
      => ComCall(8, this.p, Int32.Ptr, p)
}
struct DispCEventObj extends IDispatch {
    static IID := "{3050F558-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleMedia extends IDispatch {
    static IID := "{3051074B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    matchMedium(mediaQuery, matches)
      => ComCall(8, this.p, BSTR, mediaQuery, VARIANT_BOOL.Ptr, matches)
}
struct DispHTMLStyleMedia extends IDispatch {
    static IID := "{3059009E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFramesCollection2 extends IDispatch {
    static IID := "{332C4426-26CB-11D0-B483-00C04FD90119}"
    item(pvarIndex, pvarResult)
      => ComCall(7, this.p, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarResult)
    get_length(p)
      => ComCall(8, this.p, Int32.Ptr, p)
}
struct HTMLWindowEvents3 extends IDispatch {
    static IID := "{3050F5A1-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLWindowEvents2 extends IDispatch {
    static IID := "{3050F625-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLWindowEvents extends IDispatch {
    static IID := "{96A0A4E0-D062-11CF-94B6-00AA0060275C}"
}
struct IHTMLDocument2 extends IHTMLDocument {
    static IID := "{332C4425-26CB-11D0-B483-00C04FD90119}"
    get_all(p)
      => ComCall(8, this.p, IHTMLElementCollection.Ptr, p)
    get_body(p)
      => ComCall(9, this.p, IHTMLElement.Ptr, p)
    get_activeElement(p)
      => ComCall(10, this.p, IHTMLElement.Ptr, p)
    get_images(p)
      => ComCall(11, this.p, IHTMLElementCollection.Ptr, p)
    get_applets(p)
      => ComCall(12, this.p, IHTMLElementCollection.Ptr, p)
    get_links(p)
      => ComCall(13, this.p, IHTMLElementCollection.Ptr, p)
    get_forms(p)
      => ComCall(14, this.p, IHTMLElementCollection.Ptr, p)
    get_anchors(p)
      => ComCall(15, this.p, IHTMLElementCollection.Ptr, p)
    put_title(v)
      => ComCall(16, this.p, BSTR, v)
    get_title(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_scripts(p)
      => ComCall(18, this.p, IHTMLElementCollection.Ptr, p)
    put_designMode(v)
      => ComCall(19, this.p, BSTR, v)
    get_designMode(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    get_selection(p)
      => ComCall(21, this.p, IHTMLSelectionObject.Ptr, p)
    get_readyState(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    get_frames(p)
      => ComCall(23, this.p, IHTMLFramesCollection2.Ptr, p)
    get_embeds(p)
      => ComCall(24, this.p, IHTMLElementCollection.Ptr, p)
    get_plugins(p)
      => ComCall(25, this.p, IHTMLElementCollection.Ptr, p)
    put_alinkColor(v)
      => ComCall(26, this.p, VARIANT, v)
    get_alinkColor(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_bgColor(v)
      => ComCall(28, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    put_fgColor(v)
      => ComCall(30, this.p, VARIANT, v)
    get_fgColor(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    put_linkColor(v)
      => ComCall(32, this.p, VARIANT, v)
    get_linkColor(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    put_vlinkColor(v)
      => ComCall(34, this.p, VARIANT, v)
    get_vlinkColor(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    get_referrer(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    get_location(p)
      => ComCall(37, this.p, IHTMLLocation.Ptr, p)
    get_lastModified(p)
      => ComCall(38, this.p, BSTR.Ptr, p)
    put_URL(v)
      => ComCall(39, this.p, BSTR, v)
    get_URL(p)
      => ComCall(40, this.p, BSTR.Ptr, p)
    put_domain(v)
      => ComCall(41, this.p, BSTR, v)
    get_domain(p)
      => ComCall(42, this.p, BSTR.Ptr, p)
    put_cookie(v)
      => ComCall(43, this.p, BSTR, v)
    get_cookie(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_expando(v)
      => ComCall(45, this.p, VARIANT_BOOL, v)
    get_expando(p)
      => ComCall(46, this.p, VARIANT_BOOL.Ptr, p)
    put_charset(v)
      => ComCall(47, this.p, BSTR, v)
    get_charset(p)
      => ComCall(48, this.p, BSTR.Ptr, p)
    put_defaultCharset(v)
      => ComCall(49, this.p, BSTR, v)
    get_defaultCharset(p)
      => ComCall(50, this.p, BSTR.Ptr, p)
    get_mimeType(p)
      => ComCall(51, this.p, BSTR.Ptr, p)
    get_fileSize(p)
      => ComCall(52, this.p, BSTR.Ptr, p)
    get_fileCreatedDate(p)
      => ComCall(53, this.p, BSTR.Ptr, p)
    get_fileModifiedDate(p)
      => ComCall(54, this.p, BSTR.Ptr, p)
    get_fileUpdatedDate(p)
      => ComCall(55, this.p, BSTR.Ptr, p)
    get_security(p)
      => ComCall(56, this.p, BSTR.Ptr, p)
    get_protocol(p)
      => ComCall(57, this.p, BSTR.Ptr, p)
    get_nameProp(p)
      => ComCall(58, this.p, BSTR.Ptr, p)
    write(psarray)
      => ComCall(59, this.p, SAFEARRAY.Ptr, psarray)
    writeln(psarray)
      => ComCall(60, this.p, SAFEARRAY.Ptr, psarray)
    open(url, name, features, replace, pomWindowResult)
      => ComCall(61, this.p, BSTR, url, VARIANT, name, VARIANT, features, VARIANT, replace, IDispatch.Ptr, pomWindowResult)
    close()
      => ComCall(62, this.p)
    clear()
      => ComCall(63, this.p)
    queryCommandSupported(cmdID, pfRet)
      => ComCall(64, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandEnabled(cmdID, pfRet)
      => ComCall(65, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandState(cmdID, pfRet)
      => ComCall(66, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandIndeterm(cmdID, pfRet)
      => ComCall(67, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    queryCommandText(cmdID, pcmdText)
      => ComCall(68, this.p, BSTR, cmdID, BSTR.Ptr, pcmdText)
    queryCommandValue(cmdID, pcmdValue)
      => ComCall(69, this.p, BSTR, cmdID, VARIANT.Ptr, pcmdValue)
    execCommand(cmdID, showUI, value, pfRet)
      => ComCall(70, this.p, BSTR, cmdID, VARIANT_BOOL, showUI, VARIANT, value, VARIANT_BOOL.Ptr, pfRet)
    execCommandShowHelp(cmdID, pfRet)
      => ComCall(71, this.p, BSTR, cmdID, VARIANT_BOOL.Ptr, pfRet)
    createElement(eTag, newElem)
      => ComCall(72, this.p, BSTR, eTag, IHTMLElement.Ptr, newElem)
    put_onhelp(v)
      => ComCall(73, this.p, VARIANT, v)
    get_onhelp(p)
      => ComCall(74, this.p, VARIANT.Ptr, p)
    put_onclick(v)
      => ComCall(75, this.p, VARIANT, v)
    get_onclick(p)
      => ComCall(76, this.p, VARIANT.Ptr, p)
    put_ondblclick(v)
      => ComCall(77, this.p, VARIANT, v)
    get_ondblclick(p)
      => ComCall(78, this.p, VARIANT.Ptr, p)
    put_onkeyup(v)
      => ComCall(79, this.p, VARIANT, v)
    get_onkeyup(p)
      => ComCall(80, this.p, VARIANT.Ptr, p)
    put_onkeydown(v)
      => ComCall(81, this.p, VARIANT, v)
    get_onkeydown(p)
      => ComCall(82, this.p, VARIANT.Ptr, p)
    put_onkeypress(v)
      => ComCall(83, this.p, VARIANT, v)
    get_onkeypress(p)
      => ComCall(84, this.p, VARIANT.Ptr, p)
    put_onmouseup(v)
      => ComCall(85, this.p, VARIANT, v)
    get_onmouseup(p)
      => ComCall(86, this.p, VARIANT.Ptr, p)
    put_onmousedown(v)
      => ComCall(87, this.p, VARIANT, v)
    get_onmousedown(p)
      => ComCall(88, this.p, VARIANT.Ptr, p)
    put_onmousemove(v)
      => ComCall(89, this.p, VARIANT, v)
    get_onmousemove(p)
      => ComCall(90, this.p, VARIANT.Ptr, p)
    put_onmouseout(v)
      => ComCall(91, this.p, VARIANT, v)
    get_onmouseout(p)
      => ComCall(92, this.p, VARIANT.Ptr, p)
    put_onmouseover(v)
      => ComCall(93, this.p, VARIANT, v)
    get_onmouseover(p)
      => ComCall(94, this.p, VARIANT.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(95, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(96, this.p, VARIANT.Ptr, p)
    put_onafterupdate(v)
      => ComCall(97, this.p, VARIANT, v)
    get_onafterupdate(p)
      => ComCall(98, this.p, VARIANT.Ptr, p)
    put_onrowexit(v)
      => ComCall(99, this.p, VARIANT, v)
    get_onrowexit(p)
      => ComCall(100, this.p, VARIANT.Ptr, p)
    put_onrowenter(v)
      => ComCall(101, this.p, VARIANT, v)
    get_onrowenter(p)
      => ComCall(102, this.p, VARIANT.Ptr, p)
    put_ondragstart(v)
      => ComCall(103, this.p, VARIANT, v)
    get_ondragstart(p)
      => ComCall(104, this.p, VARIANT.Ptr, p)
    put_onselectstart(v)
      => ComCall(105, this.p, VARIANT, v)
    get_onselectstart(p)
      => ComCall(106, this.p, VARIANT.Ptr, p)
    elementFromPoint(x, y, elementHit)
      => ComCall(107, this.p, Int32, x, Int32, y, IHTMLElement.Ptr, elementHit)
    get_parentWindow(p)
      => ComCall(108, this.p, IHTMLWindow2.Ptr, p)
    get_styleSheets(p)
      => ComCall(109, this.p, IHTMLStyleSheetsCollection.Ptr, p)
    put_onbeforeupdate(v)
      => ComCall(110, this.p, VARIANT, v)
    get_onbeforeupdate(p)
      => ComCall(111, this.p, VARIANT.Ptr, p)
    put_onerrorupdate(v)
      => ComCall(112, this.p, VARIANT, v)
    get_onerrorupdate(p)
      => ComCall(113, this.p, VARIANT.Ptr, p)
    toString(String)
      => ComCall(114, this.p, BSTR.Ptr, String)
    createStyleSheet(bstrHref, lIndex, ppnewStyleSheet)
      => ComCall(115, this.p, BSTR, bstrHref, Int32, lIndex, IHTMLStyleSheet.Ptr, ppnewStyleSheet)
}
struct IHTMLWindow2 extends IHTMLFramesCollection2 {
    static IID := "{332C4427-26CB-11D0-B483-00C04FD90119}"
    get_frames(p)
      => ComCall(9, this.p, IHTMLFramesCollection2.Ptr, p)
    put_defaultStatus(v)
      => ComCall(10, this.p, BSTR, v)
    get_defaultStatus(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_status(v)
      => ComCall(12, this.p, BSTR, v)
    get_status(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    setTimeout(expression, msec, language, timerID)
      => ComCall(14, this.p, BSTR, expression, Int32, msec, VARIANT.Ptr, language, Int32.Ptr, timerID)
    clearTimeout(timerID)
      => ComCall(15, this.p, Int32, timerID)
    alert(message)
      => ComCall(16, this.p, BSTR, message)
    confirm(message, confirmed)
      => ComCall(17, this.p, BSTR, message, VARIANT_BOOL.Ptr, confirmed)
    prompt(message, defstr, textdata)
      => ComCall(18, this.p, BSTR, message, BSTR, defstr, VARIANT.Ptr, textdata)
    get_Image(p)
      => ComCall(19, this.p, IHTMLImageElementFactory.Ptr, p)
    get_location(p)
      => ComCall(20, this.p, IHTMLLocation.Ptr, p)
    get_history(p)
      => ComCall(21, this.p, IOmHistory.Ptr, p)
    close()
      => ComCall(22, this.p)
    put_opener(v)
      => ComCall(23, this.p, VARIANT, v)
    get_opener(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    get_navigator(p)
      => ComCall(25, this.p, IOmNavigator.Ptr, p)
    put_name(v)
      => ComCall(26, this.p, BSTR, v)
    get_name(p)
      => ComCall(27, this.p, BSTR.Ptr, p)
    get_parent(p)
      => ComCall(28, this.p, IHTMLWindow2.Ptr, p)
    open(url, name, features, replace, pomWindowResult)
      => ComCall(29, this.p, BSTR, url, BSTR, name, BSTR, features, VARIANT_BOOL, replace, IHTMLWindow2.Ptr, pomWindowResult)
    get_self(p)
      => ComCall(30, this.p, IHTMLWindow2.Ptr, p)
    get_top(p)
      => ComCall(31, this.p, IHTMLWindow2.Ptr, p)
    get_window(p)
      => ComCall(32, this.p, IHTMLWindow2.Ptr, p)
    navigate(url)
      => ComCall(33, this.p, BSTR, url)
    put_onfocus(v)
      => ComCall(34, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    put_onblur(v)
      => ComCall(36, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(38, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    put_onbeforeunload(v)
      => ComCall(40, this.p, VARIANT, v)
    get_onbeforeunload(p)
      => ComCall(41, this.p, VARIANT.Ptr, p)
    put_onunload(v)
      => ComCall(42, this.p, VARIANT, v)
    get_onunload(p)
      => ComCall(43, this.p, VARIANT.Ptr, p)
    put_onhelp(v)
      => ComCall(44, this.p, VARIANT, v)
    get_onhelp(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(46, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(47, this.p, VARIANT.Ptr, p)
    put_onresize(v)
      => ComCall(48, this.p, VARIANT, v)
    get_onresize(p)
      => ComCall(49, this.p, VARIANT.Ptr, p)
    put_onscroll(v)
      => ComCall(50, this.p, VARIANT, v)
    get_onscroll(p)
      => ComCall(51, this.p, VARIANT.Ptr, p)
    get_document(p)
      => ComCall(52, this.p, IHTMLDocument2.Ptr, p)
    get_event(p)
      => ComCall(53, this.p, IHTMLEventObj.Ptr, p)
    get__newEnum(p)
      => ComCall(54, this.p, IUnknown.Ptr, p)
    showModalDialog(dialog, varArgIn, varOptions, varArgOut)
      => ComCall(55, this.p, BSTR, dialog, VARIANT.Ptr, varArgIn, VARIANT.Ptr, varOptions, VARIANT.Ptr, varArgOut)
    showHelp(helpURL, helpArg, features)
      => ComCall(56, this.p, BSTR, helpURL, VARIANT, helpArg, BSTR, features)
    get_screen(p)
      => ComCall(57, this.p, IHTMLScreen.Ptr, p)
    get_Option(p)
      => ComCall(58, this.p, IHTMLOptionElementFactory.Ptr, p)
    focus()
      => ComCall(59, this.p)
    get_closed(p)
      => ComCall(60, this.p, VARIANT_BOOL.Ptr, p)
    blur()
      => ComCall(61, this.p)
    scroll(x, y)
      => ComCall(62, this.p, Int32, x, Int32, y)
    get_clientInformation(p)
      => ComCall(63, this.p, IOmNavigator.Ptr, p)
    setInterval(expression, msec, language, timerID)
      => ComCall(64, this.p, BSTR, expression, Int32, msec, VARIANT.Ptr, language, Int32.Ptr, timerID)
    clearInterval(timerID)
      => ComCall(65, this.p, Int32, timerID)
    put_offscreenBuffering(v)
      => ComCall(66, this.p, VARIANT, v)
    get_offscreenBuffering(p)
      => ComCall(67, this.p, VARIANT.Ptr, p)
    execScript(code, language, pvarRet)
      => ComCall(68, this.p, BSTR, code, BSTR, language, VARIANT.Ptr, pvarRet)
    toString(String)
      => ComCall(69, this.p, BSTR.Ptr, String)
    scrollBy(x, y)
      => ComCall(70, this.p, Int32, x, Int32, y)
    scrollTo(x, y)
      => ComCall(71, this.p, Int32, x, Int32, y)
    moveTo(x, y)
      => ComCall(72, this.p, Int32, x, Int32, y)
    moveBy(x, y)
      => ComCall(73, this.p, Int32, x, Int32, y)
    resizeTo(x, y)
      => ComCall(74, this.p, Int32, x, Int32, y)
    resizeBy(x, y)
      => ComCall(75, this.p, Int32, x, Int32, y)
    get_external(p)
      => ComCall(76, this.p, IDispatch.Ptr, p)
}
struct IHTMLWindow3 extends IDispatch {
    static IID := "{3050F4AE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_screenLeft(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_screenTop(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    attachEvent(event, pDisp, pfResult)
      => ComCall(9, this.p, BSTR, event, IDispatch, pDisp, VARIANT_BOOL.Ptr, pfResult)
    detachEvent(event, pDisp)
      => ComCall(10, this.p, BSTR, event, IDispatch, pDisp)
    setTimeout(expression, msec, language, timerID)
      => ComCall(11, this.p, VARIANT.Ptr, expression, Int32, msec, VARIANT.Ptr, language, Int32.Ptr, timerID)
    setInterval(expression, msec, language, timerID)
      => ComCall(12, this.p, VARIANT.Ptr, expression, Int32, msec, VARIANT.Ptr, language, Int32.Ptr, timerID)
    print()
      => ComCall(13, this.p)
    put_onbeforeprint(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onbeforeprint(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_onafterprint(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onafterprint(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    get_clipboardData(p)
      => ComCall(18, this.p, IHTMLDataTransfer.Ptr, p)
    showModelessDialog(url, varArgIn, options, pDialog)
      => ComCall(19, this.p, BSTR, url, VARIANT.Ptr, varArgIn, VARIANT.Ptr, options, IHTMLWindow2.Ptr, pDialog)
}
struct IHTMLFrameBase extends IDispatch {
    static IID := "{3050F311-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(9, this.p, BSTR, v)
    get_name(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(11, this.p, VARIANT, v)
    get_border(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_frameBorder(v)
      => ComCall(13, this.p, BSTR, v)
    get_frameBorder(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_frameSpacing(v)
      => ComCall(15, this.p, VARIANT, v)
    get_frameSpacing(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_marginWidth(v)
      => ComCall(17, this.p, VARIANT, v)
    get_marginWidth(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_marginHeight(v)
      => ComCall(19, this.p, VARIANT, v)
    get_marginHeight(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_noResize(v)
      => ComCall(21, this.p, VARIANT_BOOL, v)
    get_noResize(p)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, p)
    put_scrolling(v)
      => ComCall(23, this.p, BSTR, v)
    get_scrolling(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
}
struct IHTMLStorage extends IDispatch {
    static IID := "{30510474-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_remainingSpace(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    key(lIndex, __MIDL__IHTMLStorage0000)
      => ComCall(9, this.p, Int32, lIndex, BSTR.Ptr, __MIDL__IHTMLStorage0000)
    getItem(bstrKey, __MIDL__IHTMLStorage0001)
      => ComCall(10, this.p, BSTR, bstrKey, VARIANT.Ptr, __MIDL__IHTMLStorage0001)
    setItem(bstrKey, bstrValue)
      => ComCall(11, this.p, BSTR, bstrKey, BSTR, bstrValue)
    removeItem(bstrKey)
      => ComCall(12, this.p, BSTR, bstrKey)
    clear()
      => ComCall(13, this.p)
}
struct IHTMLPerformance extends IDispatch {
    static IID := "{3051074E-98B5-11CF-BB82-00AA00BDCE0B}"
    get_navigation(p)
      => ComCall(7, this.p, IHTMLPerformanceNavigation.Ptr, p)
    get_timing(p)
      => ComCall(8, this.p, IHTMLPerformanceTiming.Ptr, p)
    toString(string)
      => ComCall(9, this.p, BSTR.Ptr, string)
    toJSON(pVar)
      => ComCall(10, this.p, VARIANT.Ptr, pVar)
}
struct IHTMLApplicationCache extends IDispatch {
    static IID := "{30510828-98B5-11CF-BB82-00AA00BDCE0B}"
    get_status(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    put_onchecking(v)
      => ComCall(8, this.p, VARIANT, v)
    get_onchecking(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(10, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    put_onnoupdate(v)
      => ComCall(12, this.p, VARIANT, v)
    get_onnoupdate(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_ondownloading(v)
      => ComCall(14, this.p, VARIANT, v)
    get_ondownloading(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_onprogress(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onprogress(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    put_onupdateready(v)
      => ComCall(18, this.p, VARIANT, v)
    get_onupdateready(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    put_oncached(v)
      => ComCall(20, this.p, VARIANT, v)
    get_oncached(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_onobsolete(v)
      => ComCall(22, this.p, VARIANT, v)
    get_onobsolete(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    update()
      => ComCall(24, this.p)
    swapCache()
      => ComCall(25, this.p)
    abort()
      => ComCall(26, this.p)
}
struct IHTMLScreen extends IDispatch {
    static IID := "{3050F35C-98B5-11CF-BB82-00AA00BDCE0B}"
    get_colorDepth(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    put_bufferDepth(v)
      => ComCall(8, this.p, Int32, v)
    get_bufferDepth(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_width(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_height(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    put_updateInterval(v)
      => ComCall(12, this.p, Int32, v)
    get_updateInterval(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    get_availHeight(p)
      => ComCall(14, this.p, Int32.Ptr, p)
    get_availWidth(p)
      => ComCall(15, this.p, Int32.Ptr, p)
    get_fontSmoothingEnabled(p)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLScreen2 extends IDispatch {
    static IID := "{3050F84A-98B5-11CF-BB82-00AA00BDCE0B}"
    get_logicalXDPI(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_logicalYDPI(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_deviceXDPI(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_deviceYDPI(p)
      => ComCall(10, this.p, Int32.Ptr, p)
}
struct IHTMLScreen3 extends IDispatch {
    static IID := "{305104A1-98B5-11CF-BB82-00AA00BDCE0B}"
    get_systemXDPI(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_systemYDPI(p)
      => ComCall(8, this.p, Int32.Ptr, p)
}
struct IHTMLScreen4 extends IDispatch {
    static IID := "{3051076B-98B5-11CF-BB82-00AA00BDCE0B}"
    get_pixelDepth(p)
      => ComCall(7, this.p, Int32.Ptr, p)
}
struct IHTMLWindow4 extends IDispatch {
    static IID := "{3050F6CF-98B5-11CF-BB82-00AA00BDCE0B}"
    createPopup(varArgIn, ppPopup)
      => ComCall(7, this.p, VARIANT.Ptr, varArgIn, IDispatch.Ptr, ppPopup)
    get_frameElement(p)
      => ComCall(8, this.p, IHTMLFrameBase.Ptr, p)
}
struct IHTMLWindow5 extends IDispatch {
    static IID := "{3051040E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_XMLHttpRequest(v)
      => ComCall(7, this.p, VARIANT, v)
    get_XMLHttpRequest(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
}
struct IHTMLWindow6 extends IDispatch {
    static IID := "{30510453-98B5-11CF-BB82-00AA00BDCE0B}"
    put_XDomainRequest(v)
      => ComCall(7, this.p, VARIANT, v)
    get_XDomainRequest(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_sessionStorage(p)
      => ComCall(9, this.p, IHTMLStorage.Ptr, p)
    get_localStorage(p)
      => ComCall(10, this.p, IHTMLStorage.Ptr, p)
    put_onhashchange(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onhashchange(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    get_maxConnectionsPerServer(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    postMessage(msg, targetOrigin)
      => ComCall(14, this.p, BSTR, msg, VARIANT, targetOrigin)
    toStaticHTML(bstrHTML, pbstrStaticHTML)
      => ComCall(15, this.p, BSTR, bstrHTML, BSTR.Ptr, pbstrStaticHTML)
    put_onmessage(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onmessage(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    msWriteProfilerMark(bstrProfilerMarkName)
      => ComCall(18, this.p, BSTR, bstrProfilerMarkName)
}
struct IHTMLWindow7 extends IDispatch {
    static IID := "{305104B7-98B5-11CF-BB82-00AA00BDCE0B}"
    getSelection(ppIHTMLSelection)
      => ComCall(7, this.p, IHTMLSelection.Ptr, ppIHTMLSelection)
    getComputedStyle(varArgIn, bstrPseudoElt, ppComputedStyle)
      => ComCall(8, this.p, IHTMLDOMNode, varArgIn, BSTR, bstrPseudoElt, IHTMLCSSStyleDeclaration.Ptr, ppComputedStyle)
    get_styleMedia(p)
      => ComCall(9, this.p, IHTMLStyleMedia.Ptr, p)
    put_performance(v)
      => ComCall(10, this.p, VARIANT, v)
    get_performance(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_innerWidth(p)
      => ComCall(12, this.p, Int32.Ptr, p)
    get_innerHeight(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    get_pageXOffset(p)
      => ComCall(14, this.p, Int32.Ptr, p)
    get_pageYOffset(p)
      => ComCall(15, this.p, Int32.Ptr, p)
    get_screenX(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    get_screenY(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    get_outerWidth(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    get_outerHeight(p)
      => ComCall(19, this.p, Int32.Ptr, p)
    put_onabort(v)
      => ComCall(20, this.p, VARIANT, v)
    get_onabort(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_oncanplay(v)
      => ComCall(22, this.p, VARIANT, v)
    get_oncanplay(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_oncanplaythrough(v)
      => ComCall(24, this.p, VARIANT, v)
    get_oncanplaythrough(p)
      => ComCall(25, this.p, VARIANT.Ptr, p)
    put_onchange(v)
      => ComCall(26, this.p, VARIANT, v)
    get_onchange(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_onclick(v)
      => ComCall(28, this.p, VARIANT, v)
    get_onclick(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    put_oncontextmenu(v)
      => ComCall(30, this.p, VARIANT, v)
    get_oncontextmenu(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    put_ondblclick(v)
      => ComCall(32, this.p, VARIANT, v)
    get_ondblclick(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    put_ondrag(v)
      => ComCall(34, this.p, VARIANT, v)
    get_ondrag(p)
      => ComCall(35, this.p, VARIANT.Ptr, p)
    put_ondragend(v)
      => ComCall(36, this.p, VARIANT, v)
    get_ondragend(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
    put_ondragenter(v)
      => ComCall(38, this.p, VARIANT, v)
    get_ondragenter(p)
      => ComCall(39, this.p, VARIANT.Ptr, p)
    put_ondragleave(v)
      => ComCall(40, this.p, VARIANT, v)
    get_ondragleave(p)
      => ComCall(41, this.p, VARIANT.Ptr, p)
    put_ondragover(v)
      => ComCall(42, this.p, VARIANT, v)
    get_ondragover(p)
      => ComCall(43, this.p, VARIANT.Ptr, p)
    put_ondragstart(v)
      => ComCall(44, this.p, VARIANT, v)
    get_ondragstart(p)
      => ComCall(45, this.p, VARIANT.Ptr, p)
    put_ondrop(v)
      => ComCall(46, this.p, VARIANT, v)
    get_ondrop(p)
      => ComCall(47, this.p, VARIANT.Ptr, p)
    put_ondurationchange(v)
      => ComCall(48, this.p, VARIANT, v)
    get_ondurationchange(p)
      => ComCall(49, this.p, VARIANT.Ptr, p)
    put_onfocusin(v)
      => ComCall(50, this.p, VARIANT, v)
    get_onfocusin(p)
      => ComCall(51, this.p, VARIANT.Ptr, p)
    put_onfocusout(v)
      => ComCall(52, this.p, VARIANT, v)
    get_onfocusout(p)
      => ComCall(53, this.p, VARIANT.Ptr, p)
    put_oninput(v)
      => ComCall(54, this.p, VARIANT, v)
    get_oninput(p)
      => ComCall(55, this.p, VARIANT.Ptr, p)
    put_onemptied(v)
      => ComCall(56, this.p, VARIANT, v)
    get_onemptied(p)
      => ComCall(57, this.p, VARIANT.Ptr, p)
    put_onended(v)
      => ComCall(58, this.p, VARIANT, v)
    get_onended(p)
      => ComCall(59, this.p, VARIANT.Ptr, p)
    put_onkeydown(v)
      => ComCall(60, this.p, VARIANT, v)
    get_onkeydown(p)
      => ComCall(61, this.p, VARIANT.Ptr, p)
    put_onkeypress(v)
      => ComCall(62, this.p, VARIANT, v)
    get_onkeypress(p)
      => ComCall(63, this.p, VARIANT.Ptr, p)
    put_onkeyup(v)
      => ComCall(64, this.p, VARIANT, v)
    get_onkeyup(p)
      => ComCall(65, this.p, VARIANT.Ptr, p)
    put_onloadeddata(v)
      => ComCall(66, this.p, VARIANT, v)
    get_onloadeddata(p)
      => ComCall(67, this.p, VARIANT.Ptr, p)
    put_onloadedmetadata(v)
      => ComCall(68, this.p, VARIANT, v)
    get_onloadedmetadata(p)
      => ComCall(69, this.p, VARIANT.Ptr, p)
    put_onloadstart(v)
      => ComCall(70, this.p, VARIANT, v)
    get_onloadstart(p)
      => ComCall(71, this.p, VARIANT.Ptr, p)
    put_onmousedown(v)
      => ComCall(72, this.p, VARIANT, v)
    get_onmousedown(p)
      => ComCall(73, this.p, VARIANT.Ptr, p)
    put_onmouseenter(v)
      => ComCall(74, this.p, VARIANT, v)
    get_onmouseenter(p)
      => ComCall(75, this.p, VARIANT.Ptr, p)
    put_onmouseleave(v)
      => ComCall(76, this.p, VARIANT, v)
    get_onmouseleave(p)
      => ComCall(77, this.p, VARIANT.Ptr, p)
    put_onmousemove(v)
      => ComCall(78, this.p, VARIANT, v)
    get_onmousemove(p)
      => ComCall(79, this.p, VARIANT.Ptr, p)
    put_onmouseout(v)
      => ComCall(80, this.p, VARIANT, v)
    get_onmouseout(p)
      => ComCall(81, this.p, VARIANT.Ptr, p)
    put_onmouseover(v)
      => ComCall(82, this.p, VARIANT, v)
    get_onmouseover(p)
      => ComCall(83, this.p, VARIANT.Ptr, p)
    put_onmouseup(v)
      => ComCall(84, this.p, VARIANT, v)
    get_onmouseup(p)
      => ComCall(85, this.p, VARIANT.Ptr, p)
    put_onmousewheel(v)
      => ComCall(86, this.p, VARIANT, v)
    get_onmousewheel(p)
      => ComCall(87, this.p, VARIANT.Ptr, p)
    put_onoffline(v)
      => ComCall(88, this.p, VARIANT, v)
    get_onoffline(p)
      => ComCall(89, this.p, VARIANT.Ptr, p)
    put_ononline(v)
      => ComCall(90, this.p, VARIANT, v)
    get_ononline(p)
      => ComCall(91, this.p, VARIANT.Ptr, p)
    put_onprogress(v)
      => ComCall(92, this.p, VARIANT, v)
    get_onprogress(p)
      => ComCall(93, this.p, VARIANT.Ptr, p)
    put_onratechange(v)
      => ComCall(94, this.p, VARIANT, v)
    get_onratechange(p)
      => ComCall(95, this.p, VARIANT.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(96, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(97, this.p, VARIANT.Ptr, p)
    put_onreset(v)
      => ComCall(98, this.p, VARIANT, v)
    get_onreset(p)
      => ComCall(99, this.p, VARIANT.Ptr, p)
    put_onseeked(v)
      => ComCall(100, this.p, VARIANT, v)
    get_onseeked(p)
      => ComCall(101, this.p, VARIANT.Ptr, p)
    put_onseeking(v)
      => ComCall(102, this.p, VARIANT, v)
    get_onseeking(p)
      => ComCall(103, this.p, VARIANT.Ptr, p)
    put_onselect(v)
      => ComCall(104, this.p, VARIANT, v)
    get_onselect(p)
      => ComCall(105, this.p, VARIANT.Ptr, p)
    put_onstalled(v)
      => ComCall(106, this.p, VARIANT, v)
    get_onstalled(p)
      => ComCall(107, this.p, VARIANT.Ptr, p)
    put_onstorage(v)
      => ComCall(108, this.p, VARIANT, v)
    get_onstorage(p)
      => ComCall(109, this.p, VARIANT.Ptr, p)
    put_onsubmit(v)
      => ComCall(110, this.p, VARIANT, v)
    get_onsubmit(p)
      => ComCall(111, this.p, VARIANT.Ptr, p)
    put_onsuspend(v)
      => ComCall(112, this.p, VARIANT, v)
    get_onsuspend(p)
      => ComCall(113, this.p, VARIANT.Ptr, p)
    put_ontimeupdate(v)
      => ComCall(114, this.p, VARIANT, v)
    get_ontimeupdate(p)
      => ComCall(115, this.p, VARIANT.Ptr, p)
    put_onpause(v)
      => ComCall(116, this.p, VARIANT, v)
    get_onpause(p)
      => ComCall(117, this.p, VARIANT.Ptr, p)
    put_onplay(v)
      => ComCall(118, this.p, VARIANT, v)
    get_onplay(p)
      => ComCall(119, this.p, VARIANT.Ptr, p)
    put_onplaying(v)
      => ComCall(120, this.p, VARIANT, v)
    get_onplaying(p)
      => ComCall(121, this.p, VARIANT.Ptr, p)
    put_onvolumechange(v)
      => ComCall(122, this.p, VARIANT, v)
    get_onvolumechange(p)
      => ComCall(123, this.p, VARIANT.Ptr, p)
    put_onwaiting(v)
      => ComCall(124, this.p, VARIANT, v)
    get_onwaiting(p)
      => ComCall(125, this.p, VARIANT.Ptr, p)
}
struct IHTMLWindow8 extends IDispatch {
    static IID := "{305107AB-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmspointerdown(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmspointerdown(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onmspointermove(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onmspointermove(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onmspointerup(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onmspointerup(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_onmspointerover(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onmspointerover(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onmspointerout(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onmspointerout(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onmspointercancel(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onmspointercancel(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_onmspointerhover(v)
      => ComCall(19, this.p, VARIANT, v)
    get_onmspointerhover(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_onmsgesturestart(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onmsgesturestart(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onmsgesturechange(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onmsgesturechange(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onmsgestureend(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onmsgestureend(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_onmsgesturehold(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onmsgesturehold(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_onmsgesturetap(v)
      => ComCall(29, this.p, VARIANT, v)
    get_onmsgesturetap(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onmsgesturedoubletap(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onmsgesturedoubletap(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onmsinertiastart(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onmsinertiastart(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    get_applicationCache(p)
      => ComCall(35, this.p, IHTMLApplicationCache.Ptr, p)
    put_onpopstate(v)
      => ComCall(36, this.p, VARIANT, v)
    get_onpopstate(p)
      => ComCall(37, this.p, VARIANT.Ptr, p)
}
struct DispHTMLScreen extends IDispatch {
    static IID := "{3050F591-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLWindow2 extends IDispatch {
    static IID := "{3050F55D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLWindowProxy extends IDispatch {
    static IID := "{3050F55E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDocumentCompatibleInfo extends IDispatch {
    static IID := "{3051041A-98B5-11CF-BB82-00AA00BDCE0B}"
    get_userAgent(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_version(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLDocumentCompatibleInfoCollection extends IDispatch {
    static IID := "{30510418-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, compatibleInfo)
      => ComCall(8, this.p, Int32, index, IHTMLDocumentCompatibleInfo.Ptr, compatibleInfo)
}
struct DispHTMLDocumentCompatibleInfo extends IDispatch {
    static IID := "{3050F53E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLDocumentCompatibleInfoCollection extends IDispatch {
    static IID := "{3050F53F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLDocumentEvents4 extends IDispatch {
    static IID := "{30510737-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLDocumentEvents3 extends IDispatch {
    static IID := "{3050F5A0-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLDocumentEvents2 extends IDispatch {
    static IID := "{3050F613-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLDocumentEvents extends IDispatch {
    static IID := "{3050F260-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGSVGElement extends IDispatch {
    static IID := "{305104E7-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    put_contentScriptType(v)
      => ComCall(15, this.p, BSTR, v)
    get_contentScriptType(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_contentStyleType(v)
      => ComCall(17, this.p, BSTR, v)
    get_contentStyleType(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    putref_viewport(v)
      => ComCall(19, this.p, ISVGRect, v)
    get_viewport(p)
      => ComCall(20, this.p, ISVGRect.Ptr, p)
    put_pixelUnitToMillimeterX(v)
      => ComCall(21, this.p, Float32, v)
    get_pixelUnitToMillimeterX(p)
      => ComCall(22, this.p, Float32.Ptr, p)
    put_pixelUnitToMillimeterY(v)
      => ComCall(23, this.p, Float32, v)
    get_pixelUnitToMillimeterY(p)
      => ComCall(24, this.p, Float32.Ptr, p)
    put_screenPixelToMillimeterX(v)
      => ComCall(25, this.p, Float32, v)
    get_screenPixelToMillimeterX(p)
      => ComCall(26, this.p, Float32.Ptr, p)
    put_screenPixelToMillimeterY(v)
      => ComCall(27, this.p, Float32, v)
    get_screenPixelToMillimeterY(p)
      => ComCall(28, this.p, Float32.Ptr, p)
    put_useCurrentView(v)
      => ComCall(29, this.p, VARIANT_BOOL, v)
    get_useCurrentView(p)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, p)
    putref_currentView(v)
      => ComCall(31, this.p, ISVGViewSpec, v)
    get_currentView(p)
      => ComCall(32, this.p, ISVGViewSpec.Ptr, p)
    put_currentScale(v)
      => ComCall(33, this.p, Float32, v)
    get_currentScale(p)
      => ComCall(34, this.p, Float32.Ptr, p)
    putref_currentTranslate(v)
      => ComCall(35, this.p, ISVGPoint, v)
    get_currentTranslate(p)
      => ComCall(36, this.p, ISVGPoint.Ptr, p)
    suspendRedraw(maxWaitMilliseconds, pResult)
      => ComCall(37, this.p, UInt32, maxWaitMilliseconds, UInt32.Ptr, pResult)
    unsuspendRedraw(suspendHandeID)
      => ComCall(38, this.p, UInt32, suspendHandeID)
    unsuspendRedrawAll()
      => ComCall(39, this.p)
    forceRedraw()
      => ComCall(40, this.p)
    pauseAnimations()
      => ComCall(41, this.p)
    unpauseAnimations()
      => ComCall(42, this.p)
    animationsPaused(pResult)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pResult)
    getCurrentTime(pResult)
      => ComCall(44, this.p, Float32.Ptr, pResult)
    setCurrentTime(seconds)
      => ComCall(45, this.p, Float32, seconds)
    getIntersectionList(rect, referenceElement, pResult)
      => ComCall(46, this.p, ISVGRect, rect, ISVGElement, referenceElement, VARIANT.Ptr, pResult)
    getEnclosureList(rect, referenceElement, pResult)
      => ComCall(47, this.p, ISVGRect, rect, ISVGElement, referenceElement, VARIANT.Ptr, pResult)
    checkIntersection(element, rect, pResult)
      => ComCall(48, this.p, ISVGElement, element, ISVGRect, rect, VARIANT_BOOL.Ptr, pResult)
    checkEnclosure(element, rect, pResult)
      => ComCall(49, this.p, ISVGElement, element, ISVGRect, rect, VARIANT_BOOL.Ptr, pResult)
    deselectAll()
      => ComCall(50, this.p)
    createSVGNumber(pResult)
      => ComCall(51, this.p, ISVGNumber.Ptr, pResult)
    createSVGLength(pResult)
      => ComCall(52, this.p, ISVGLength.Ptr, pResult)
    createSVGAngle(pResult)
      => ComCall(53, this.p, ISVGAngle.Ptr, pResult)
    createSVGPoint(pResult)
      => ComCall(54, this.p, ISVGPoint.Ptr, pResult)
    createSVGMatrix(pResult)
      => ComCall(55, this.p, ISVGMatrix.Ptr, pResult)
    createSVGRect(pResult)
      => ComCall(56, this.p, ISVGRect.Ptr, pResult)
    createSVGTransform(pResult)
      => ComCall(57, this.p, ISVGTransform.Ptr, pResult)
    createSVGTransformFromMatrix(matrix, pResult)
      => ComCall(58, this.p, ISVGMatrix, matrix, ISVGTransform.Ptr, pResult)
    getElementById(elementId, pResult)
      => ComCall(59, this.p, BSTR, elementId, IHTMLElement.Ptr, pResult)
}
struct IDOMNodeIterator extends IDispatch {
    static IID := "{30510746-98B5-11CF-BB82-00AA00BDCE0B}"
    get_root(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    get_whatToShow(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    get_filter(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_expandEntityReferences(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    nextNode(ppRetNode)
      => ComCall(11, this.p, IDispatch.Ptr, ppRetNode)
    previousNode(ppRetNode)
      => ComCall(12, this.p, IDispatch.Ptr, ppRetNode)
    detach()
      => ComCall(13, this.p)
}
struct IDOMTreeWalker extends IDispatch {
    static IID := "{30510748-98B5-11CF-BB82-00AA00BDCE0B}"
    get_root(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    get_whatToShow(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    get_filter(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_expandEntityReferences(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    putref_currentNode(v)
      => ComCall(11, this.p, IDispatch, v)
    get_currentNode(p)
      => ComCall(12, this.p, IDispatch.Ptr, p)
    parentNode(ppRetNode)
      => ComCall(13, this.p, IDispatch.Ptr, ppRetNode)
    firstChild(ppRetNode)
      => ComCall(14, this.p, IDispatch.Ptr, ppRetNode)
    lastChild(ppRetNode)
      => ComCall(15, this.p, IDispatch.Ptr, ppRetNode)
    previousSibling(ppRetNode)
      => ComCall(16, this.p, IDispatch.Ptr, ppRetNode)
    nextSibling(ppRetNode)
      => ComCall(17, this.p, IDispatch.Ptr, ppRetNode)
    previousNode(ppRetNode)
      => ComCall(18, this.p, IDispatch.Ptr, ppRetNode)
    nextNode(ppRetNode)
      => ComCall(19, this.p, IDispatch.Ptr, ppRetNode)
}
struct IDOMProcessingInstruction extends IDispatch {
    static IID := "{30510742-98B5-11CF-BB82-00AA00BDCE0B}"
    get_target(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_data(v)
      => ComCall(8, this.p, BSTR, v)
    get_data(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct IHTMLDocument3 extends IDispatch {
    static IID := "{3050F485-98B5-11CF-BB82-00AA00BDCE0B}"
    releaseCapture()
      => ComCall(7, this.p)
    recalc(fForce)
      => ComCall(8, this.p, VARIANT_BOOL, fForce)
    createTextNode(text, newTextNode)
      => ComCall(9, this.p, BSTR, text, IHTMLDOMNode.Ptr, newTextNode)
    get_documentElement(p)
      => ComCall(10, this.p, IHTMLElement.Ptr, p)
    get_uniqueID(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    attachEvent(event, pDisp, pfResult)
      => ComCall(12, this.p, BSTR, event, IDispatch, pDisp, VARIANT_BOOL.Ptr, pfResult)
    detachEvent(event, pDisp)
      => ComCall(13, this.p, BSTR, event, IDispatch, pDisp)
    put_onrowsdelete(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onrowsdelete(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    put_onrowsinserted(v)
      => ComCall(16, this.p, VARIANT, v)
    get_onrowsinserted(p)
      => ComCall(17, this.p, VARIANT.Ptr, p)
    put_oncellchange(v)
      => ComCall(18, this.p, VARIANT, v)
    get_oncellchange(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    put_ondatasetchanged(v)
      => ComCall(20, this.p, VARIANT, v)
    get_ondatasetchanged(p)
      => ComCall(21, this.p, VARIANT.Ptr, p)
    put_ondataavailable(v)
      => ComCall(22, this.p, VARIANT, v)
    get_ondataavailable(p)
      => ComCall(23, this.p, VARIANT.Ptr, p)
    put_ondatasetcomplete(v)
      => ComCall(24, this.p, VARIANT, v)
    get_ondatasetcomplete(p)
      => ComCall(25, this.p, VARIANT.Ptr, p)
    put_onpropertychange(v)
      => ComCall(26, this.p, VARIANT, v)
    get_onpropertychange(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_dir(v)
      => ComCall(28, this.p, BSTR, v)
    get_dir(p)
      => ComCall(29, this.p, BSTR.Ptr, p)
    put_oncontextmenu(v)
      => ComCall(30, this.p, VARIANT, v)
    get_oncontextmenu(p)
      => ComCall(31, this.p, VARIANT.Ptr, p)
    put_onstop(v)
      => ComCall(32, this.p, VARIANT, v)
    get_onstop(p)
      => ComCall(33, this.p, VARIANT.Ptr, p)
    createDocumentFragment(pNewDoc)
      => ComCall(34, this.p, IHTMLDocument2.Ptr, pNewDoc)
    get_parentDocument(p)
      => ComCall(35, this.p, IHTMLDocument2.Ptr, p)
    put_enableDownload(v)
      => ComCall(36, this.p, VARIANT_BOOL, v)
    get_enableDownload(p)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, p)
    put_baseUrl(v)
      => ComCall(38, this.p, BSTR, v)
    get_baseUrl(p)
      => ComCall(39, this.p, BSTR.Ptr, p)
    get_childNodes(p)
      => ComCall(40, this.p, IDispatch.Ptr, p)
    put_inheritStyleSheets(v)
      => ComCall(41, this.p, VARIANT_BOOL, v)
    get_inheritStyleSheets(p)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, p)
    put_onbeforeeditfocus(v)
      => ComCall(43, this.p, VARIANT, v)
    get_onbeforeeditfocus(p)
      => ComCall(44, this.p, VARIANT.Ptr, p)
    getElementsByName(v, pelColl)
      => ComCall(45, this.p, BSTR, v, IHTMLElementCollection.Ptr, pelColl)
    getElementById(v, pel)
      => ComCall(46, this.p, BSTR, v, IHTMLElement.Ptr, pel)
    getElementsByTagName(v, pelColl)
      => ComCall(47, this.p, BSTR, v, IHTMLElementCollection.Ptr, pelColl)
}
struct IHTMLDocument4 extends IDispatch {
    static IID := "{3050F69A-98B5-11CF-BB82-00AA00BDCE0B}"
    focus()
      => ComCall(7, this.p)
    hasFocus(pfFocus)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pfFocus)
    put_onselectionchange(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onselectionchange(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    get_namespaces(p)
      => ComCall(11, this.p, IDispatch.Ptr, p)
    createDocumentFromUrl(bstrUrl, bstrOptions, newDoc)
      => ComCall(12, this.p, BSTR, bstrUrl, BSTR, bstrOptions, IHTMLDocument2.Ptr, newDoc)
    put_media(v)
      => ComCall(13, this.p, BSTR, v)
    get_media(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    createEventObject(pvarEventObject, ppEventObj)
      => ComCall(15, this.p, VARIANT.Ptr, pvarEventObject, IHTMLEventObj.Ptr, ppEventObj)
    fireEvent(bstrEventName, pvarEventObject, pfCancelled)
      => ComCall(16, this.p, BSTR, bstrEventName, VARIANT.Ptr, pvarEventObject, VARIANT_BOOL.Ptr, pfCancelled)
    createRenderStyle(v, ppIHTMLRenderStyle)
      => ComCall(17, this.p, BSTR, v, IHTMLRenderStyle.Ptr, ppIHTMLRenderStyle)
    put_oncontrolselect(v)
      => ComCall(18, this.p, VARIANT, v)
    get_oncontrolselect(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    get_URLUnencoded(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
}
struct IHTMLDocument5 extends IDispatch {
    static IID := "{3050F80C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmousewheel(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmousewheel(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_doctype(p)
      => ComCall(9, this.p, IHTMLDOMNode.Ptr, p)
    get_implementation(p)
      => ComCall(10, this.p, IHTMLDOMImplementation.Ptr, p)
    createAttribute(bstrattrName, ppattribute)
      => ComCall(11, this.p, BSTR, bstrattrName, IHTMLDOMAttribute.Ptr, ppattribute)
    createComment(bstrdata, ppRetNode)
      => ComCall(12, this.p, BSTR, bstrdata, IHTMLDOMNode.Ptr, ppRetNode)
    put_onfocusin(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onfocusin(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onfocusout(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onfocusout(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onactivate(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onactivate(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_ondeactivate(v)
      => ComCall(19, this.p, VARIANT, v)
    get_ondeactivate(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_onbeforeactivate(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onbeforeactivate(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onbeforedeactivate(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onbeforedeactivate(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    get_compatMode(p)
      => ComCall(25, this.p, BSTR.Ptr, p)
}
struct IHTMLDocument6 extends IDispatch {
    static IID := "{30510417-98B5-11CF-BB82-00AA00BDCE0B}"
    get_compatible(p)
      => ComCall(7, this.p, IHTMLDocumentCompatibleInfoCollection.Ptr, p)
    get_documentMode(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onstorage(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onstorage(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onstoragecommit(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onstoragecommit(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    getElementById(bstrId, ppRetElement)
      => ComCall(13, this.p, BSTR, bstrId, IHTMLElement2.Ptr, ppRetElement)
    updateSettings()
      => ComCall(14, this.p)
}
struct IHTMLDocument8 extends IDispatch {
    static IID := "{305107D0-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onmscontentzoom(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onmscontentzoom(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onmspointerdown(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onmspointerdown(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onmspointermove(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onmspointermove(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_onmspointerup(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onmspointerup(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onmspointerover(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onmspointerover(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onmspointerout(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onmspointerout(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_onmspointercancel(v)
      => ComCall(19, this.p, VARIANT, v)
    get_onmspointercancel(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_onmspointerhover(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onmspointerhover(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onmsgesturestart(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onmsgesturestart(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onmsgesturechange(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onmsgesturechange(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_onmsgestureend(v)
      => ComCall(27, this.p, VARIANT, v)
    get_onmsgestureend(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_onmsgesturehold(v)
      => ComCall(29, this.p, VARIANT, v)
    get_onmsgesturehold(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    put_onmsgesturetap(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onmsgesturetap(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onmsgesturedoubletap(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onmsgesturedoubletap(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_onmsinertiastart(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onmsinertiastart(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    elementsFromPoint(x, y, elementsHit)
      => ComCall(37, this.p, Float32, x, Float32, y, IHTMLDOMChildrenCollection.Ptr, elementsHit)
    elementsFromRect(left, top, width, height, elementsHit)
      => ComCall(38, this.p, Float32, left, Float32, top, Float32, width, Float32, height, IHTMLDOMChildrenCollection.Ptr, elementsHit)
    put_onmsmanipulationstatechanged(v)
      => ComCall(39, this.p, VARIANT, v)
    get_onmsmanipulationstatechanged(p)
      => ComCall(40, this.p, VARIANT.Ptr, p)
    put_msCapsLockWarningOff(v)
      => ComCall(41, this.p, VARIANT_BOOL, v)
    get_msCapsLockWarningOff(p)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, p)
}
struct IDocumentEvent extends IDispatch {
    static IID := "{305104BC-98B5-11CF-BB82-00AA00BDCE0B}"
    createEvent(eventType, ppEvent)
      => ComCall(7, this.p, BSTR, eventType, IDOMEvent.Ptr, ppEvent)
}
struct IDocumentRange extends IDispatch {
    static IID := "{305104AF-98B5-11CF-BB82-00AA00BDCE0B}"
    createRange(ppIHTMLDOMRange)
      => ComCall(7, this.p, IHTMLDOMRange.Ptr, ppIHTMLDOMRange)
}
struct IDocumentSelector extends IDispatch {
    static IID := "{30510462-98B5-11CF-BB82-00AA00BDCE0B}"
    querySelector(v, pel)
      => ComCall(7, this.p, BSTR, v, IHTMLElement.Ptr, pel)
    querySelectorAll(v, pel)
      => ComCall(8, this.p, BSTR, v, IHTMLDOMChildrenCollection.Ptr, pel)
}
struct IDocumentTraversal extends IDispatch {
    static IID := "{30510744-98B5-11CF-BB82-00AA00BDCE0B}"
    createNodeIterator(pRootNode, ulWhatToShow, pFilter, fEntityReferenceExpansion, ppNodeIterator)
      => ComCall(7, this.p, IDispatch, pRootNode, Int32, ulWhatToShow, VARIANT.Ptr, pFilter, VARIANT_BOOL, fEntityReferenceExpansion, IDOMNodeIterator.Ptr, ppNodeIterator)
    createTreeWalker(pRootNode, ulWhatToShow, pFilter, fEntityReferenceExpansion, ppTreeWalker)
      => ComCall(8, this.p, IDispatch, pRootNode, Int32, ulWhatToShow, VARIANT.Ptr, pFilter, VARIANT_BOOL, fEntityReferenceExpansion, IDOMTreeWalker.Ptr, ppTreeWalker)
}
struct DispHTMLDocument extends IDispatch {
    static IID := "{3050F55F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DWebBridgeEvents extends IDispatch {
    static IID := "{A6D897FF-0A95-11D1-B0BA-006008166E11}"
}
struct IWebBridge extends IDispatch {
    static IID := "{AE24FDAD-03C6-11D1-8B76-0080C744F389}"
    put_URL(v)
      => ComCall(7, this.p, BSTR, v)
    get_URL(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_Scrollbar(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_Scrollbar(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    put_embed(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_embed(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    get_event(p)
      => ComCall(13, this.p, IDispatch.Ptr, p)
    get_readyState(p)
      => ComCall(14, this.p, Int32.Ptr, p)
    AboutBox()
      => ComCall(15, this.p)
}
struct IWBScriptControl extends IDispatch {
    static IID := "{A5170870-0CF8-11D1-8B91-0080C744F389}"
    raiseEvent(name, eventData)
      => ComCall(7, this.p, BSTR, name, VARIANT, eventData)
    bubbleEvent()
      => ComCall(8, this.p)
    setContextMenu(menuItemPairs)
      => ComCall(9, this.p, VARIANT, menuItemPairs)
    put_selectableContent(v)
      => ComCall(10, this.p, VARIANT_BOOL, v)
    get_selectableContent(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    get_frozen(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    put_scrollbar(v)
      => ComCall(13, this.p, VARIANT_BOOL, v)
    get_scrollbar(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_version(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    get_visibility(p)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, p)
    put_onvisibilitychange(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onvisibilitychange(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
}
struct IHTMLEmbedElement extends IDispatch {
    static IID := "{3050F25F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_hidden(v)
      => ComCall(7, this.p, BSTR, v)
    get_hidden(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_palette(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_pluginspage(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_src(v)
      => ComCall(11, this.p, BSTR, v)
    get_src(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_units(v)
      => ComCall(13, this.p, BSTR, v)
    get_units(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(15, this.p, BSTR, v)
    get_name(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_width(v)
      => ComCall(17, this.p, VARIANT, v)
    get_width(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(19, this.p, VARIANT, v)
    get_height(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
}
struct IHTMLEmbedElement2 extends IDispatch {
    static IID := "{30510493-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_pluginspage(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispHTMLEmbed extends IDispatch {
    static IID := "{3050F52E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLMapEvents2 extends IDispatch {
    static IID := "{3050F61E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLMapEvents extends IDispatch {
    static IID := "{3050F3BA-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLAreasCollection extends IDispatch {
    static IID := "{3050F383-98B5-11CF-BB82-00AA00BDCE0B}"
    put_length(v)
      => ComCall(7, this.p, Int32, v)
    get_length(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(9, this.p, IUnknown.Ptr, p)
    item(name, index, pdisp)
      => ComCall(10, this.p, VARIANT, name, VARIANT, index, IDispatch.Ptr, pdisp)
    tags(tagName, pdisp)
      => ComCall(11, this.p, VARIANT, tagName, IDispatch.Ptr, pdisp)
    add(element, before)
      => ComCall(12, this.p, IHTMLElement, element, VARIANT, before)
    remove(index)
      => ComCall(13, this.p, Int32, index)
}
struct IHTMLAreasCollection2 extends IDispatch {
    static IID := "{3050F5EC-98B5-11CF-BB82-00AA00BDCE0B}"
    urns(urn, pdisp)
      => ComCall(7, this.p, VARIANT, urn, IDispatch.Ptr, pdisp)
}
struct IHTMLAreasCollection3 extends IDispatch {
    static IID := "{3050F837-98B5-11CF-BB82-00AA00BDCE0B}"
    namedItem(name, pdisp)
      => ComCall(7, this.p, BSTR, name, IDispatch.Ptr, pdisp)
}
struct IHTMLAreasCollection4 extends IDispatch {
    static IID := "{30510492-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, pNode)
      => ComCall(8, this.p, Int32, index, IHTMLElement2.Ptr, pNode)
    namedItem(name, pNode)
      => ComCall(9, this.p, BSTR, name, IHTMLElement2.Ptr, pNode)
}
struct IHTMLMapElement extends IDispatch {
    static IID := "{3050F266-98B5-11CF-BB82-00AA00BDCE0B}"
    get_areas(p)
      => ComCall(7, this.p, IHTMLAreasCollection.Ptr, p)
    put_name(v)
      => ComCall(8, this.p, BSTR, v)
    get_name(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispHTMLAreasCollection extends IDispatch {
    static IID := "{3050F56A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLMapElement extends IDispatch {
    static IID := "{3050F526-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLAreaEvents2 extends IDispatch {
    static IID := "{3050F611-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLAreaEvents extends IDispatch {
    static IID := "{3050F366-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLAreaElement extends IDispatch {
    static IID := "{3050F265-98B5-11CF-BB82-00AA00BDCE0B}"
    put_shape(v)
      => ComCall(7, this.p, BSTR, v)
    get_shape(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_coords(v)
      => ComCall(9, this.p, BSTR, v)
    get_coords(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_href(v)
      => ComCall(11, this.p, BSTR, v)
    get_href(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_target(v)
      => ComCall(13, this.p, BSTR, v)
    get_target(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_alt(v)
      => ComCall(15, this.p, BSTR, v)
    get_alt(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_noHref(v)
      => ComCall(17, this.p, VARIANT_BOOL, v)
    get_noHref(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    put_host(v)
      => ComCall(19, this.p, BSTR, v)
    get_host(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_hostname(v)
      => ComCall(21, this.p, BSTR, v)
    get_hostname(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_pathname(v)
      => ComCall(23, this.p, BSTR, v)
    get_pathname(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_port(v)
      => ComCall(25, this.p, BSTR, v)
    get_port(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_protocol(v)
      => ComCall(27, this.p, BSTR, v)
    get_protocol(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_search(v)
      => ComCall(29, this.p, BSTR, v)
    get_search(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    put_hash(v)
      => ComCall(31, this.p, BSTR, v)
    get_hash(p)
      => ComCall(32, this.p, BSTR.Ptr, p)
    put_onblur(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onblur(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_onfocus(v)
      => ComCall(35, this.p, VARIANT, v)
    get_onfocus(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_tabIndex(v)
      => ComCall(37, this.p, Int16, v)
    get_tabIndex(p)
      => ComCall(38, this.p, Int16.Ptr, p)
    focus()
      => ComCall(39, this.p)
    blur()
      => ComCall(40, this.p)
}
struct IHTMLAreaElement2 extends IDispatch {
    static IID := "{3051041F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_shape(v)
      => ComCall(7, this.p, BSTR, v)
    get_shape(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_coords(v)
      => ComCall(9, this.p, BSTR, v)
    get_coords(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_href(v)
      => ComCall(11, this.p, BSTR, v)
    get_href(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct DispHTMLAreaElement extends IDispatch {
    static IID := "{3050F503-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLTableCaption extends IDispatch {
    static IID := "{3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_vAlign(v)
      => ComCall(9, this.p, BSTR, v)
    get_vAlign(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct DispHTMLTableCaption extends IDispatch {
    static IID := "{3050F508-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLCommentElement extends IDispatch {
    static IID := "{3050F20C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_text(v)
      => ComCall(7, this.p, BSTR, v)
    get_text(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_atomic(v)
      => ComCall(9, this.p, Int32, v)
    get_atomic(p)
      => ComCall(10, this.p, Int32.Ptr, p)
}
struct IHTMLCommentElement2 extends IDispatch {
    static IID := "{3050F813-98B5-11CF-BB82-00AA00BDCE0B}"
    put_data(v)
      => ComCall(7, this.p, BSTR, v)
    get_data(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_length(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    substringData(offset, Count, pbstrsubString)
      => ComCall(10, this.p, Int32, offset, Int32, Count, BSTR.Ptr, pbstrsubString)
    appendData(bstrstring)
      => ComCall(11, this.p, BSTR, bstrstring)
    insertData(offset, bstrstring)
      => ComCall(12, this.p, Int32, offset, BSTR, bstrstring)
    deleteData(offset, Count)
      => ComCall(13, this.p, Int32, offset, Int32, Count)
    replaceData(offset, Count, bstrstring)
      => ComCall(14, this.p, Int32, offset, Int32, Count, BSTR, bstrstring)
}
struct IHTMLCommentElement3 extends IDispatch {
    static IID := "{3051073F-98B5-11CF-BB82-00AA00BDCE0B}"
    substringData(offset, Count, pbstrsubString)
      => ComCall(7, this.p, Int32, offset, Int32, Count, BSTR.Ptr, pbstrsubString)
    insertData(offset, bstrstring)
      => ComCall(8, this.p, Int32, offset, BSTR, bstrstring)
    deleteData(offset, Count)
      => ComCall(9, this.p, Int32, offset, Int32, Count)
    replaceData(offset, Count, bstrstring)
      => ComCall(10, this.p, Int32, offset, Int32, Count, BSTR, bstrstring)
}
struct DispHTMLCommentElement extends IDispatch {
    static IID := "{3050F50A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLPhraseElement extends IDispatch {
    static IID := "{3050F20A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLPhraseElement2 extends IDispatch {
    static IID := "{3050F824-98B5-11CF-BB82-00AA00BDCE0B}"
    put_cite(v)
      => ComCall(7, this.p, BSTR, v)
    get_cite(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_dateTime(v)
      => ComCall(9, this.p, BSTR, v)
    get_dateTime(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLPhraseElement3 extends IDispatch {
    static IID := "{3051043D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_cite(v)
      => ComCall(7, this.p, BSTR, v)
    get_cite(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLSpanElement extends IDispatch {
    static IID := "{3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLPhraseElement extends IDispatch {
    static IID := "{3050F52D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLSpanElement extends IDispatch {
    static IID := "{3050F548-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLTableEvents2 extends IDispatch {
    static IID := "{3050F623-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLTableEvents extends IDispatch {
    static IID := "{3050F407-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLTableSection extends IDispatch {
    static IID := "{3050F23B-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_vAlign(v)
      => ComCall(9, this.p, BSTR, v)
    get_vAlign(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_bgColor(v)
      => ComCall(11, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    get_rows(p)
      => ComCall(13, this.p, IHTMLElementCollection.Ptr, p)
    insertRow(index, row)
      => ComCall(14, this.p, Int32, index, IDispatch.Ptr, row)
    deleteRow(index)
      => ComCall(15, this.p, Int32, index)
}
struct IHTMLTable extends IDispatch {
    static IID := "{3050F21E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_cols(v)
      => ComCall(7, this.p, Int32, v)
    get_cols(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_border(v)
      => ComCall(9, this.p, VARIANT, v)
    get_border(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_frame(v)
      => ComCall(11, this.p, BSTR, v)
    get_frame(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_rules(v)
      => ComCall(13, this.p, BSTR, v)
    get_rules(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_cellSpacing(v)
      => ComCall(15, this.p, VARIANT, v)
    get_cellSpacing(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_cellPadding(v)
      => ComCall(17, this.p, VARIANT, v)
    get_cellPadding(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_background(v)
      => ComCall(19, this.p, BSTR, v)
    get_background(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_bgColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_borderColor(v)
      => ComCall(23, this.p, VARIANT, v)
    get_borderColor(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_borderColorLight(v)
      => ComCall(25, this.p, VARIANT, v)
    get_borderColorLight(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_borderColorDark(v)
      => ComCall(27, this.p, VARIANT, v)
    get_borderColorDark(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_align(v)
      => ComCall(29, this.p, BSTR, v)
    get_align(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    refresh()
      => ComCall(31, this.p)
    get_rows(p)
      => ComCall(32, this.p, IHTMLElementCollection.Ptr, p)
    put_width(v)
      => ComCall(33, this.p, VARIANT, v)
    get_width(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(35, this.p, VARIANT, v)
    get_height(p)
      => ComCall(36, this.p, VARIANT.Ptr, p)
    put_dataPageSize(v)
      => ComCall(37, this.p, Int32, v)
    get_dataPageSize(p)
      => ComCall(38, this.p, Int32.Ptr, p)
    nextPage()
      => ComCall(39, this.p)
    previousPage()
      => ComCall(40, this.p)
    get_tHead(p)
      => ComCall(41, this.p, IHTMLTableSection.Ptr, p)
    get_tFoot(p)
      => ComCall(42, this.p, IHTMLTableSection.Ptr, p)
    get_tBodies(p)
      => ComCall(43, this.p, IHTMLElementCollection.Ptr, p)
    get_caption(p)
      => ComCall(44, this.p, IHTMLTableCaption.Ptr, p)
    createTHead(head)
      => ComCall(45, this.p, IDispatch.Ptr, head)
    deleteTHead()
      => ComCall(46, this.p)
    createTFoot(foot)
      => ComCall(47, this.p, IDispatch.Ptr, foot)
    deleteTFoot()
      => ComCall(48, this.p)
    createCaption(caption)
      => ComCall(49, this.p, IHTMLTableCaption.Ptr, caption)
    deleteCaption()
      => ComCall(50, this.p)
    insertRow(index, row)
      => ComCall(51, this.p, Int32, index, IDispatch.Ptr, row)
    deleteRow(index)
      => ComCall(52, this.p, Int32, index)
    get_readyState(p)
      => ComCall(53, this.p, BSTR.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(54, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(55, this.p, VARIANT.Ptr, p)
}
struct IHTMLTable2 extends IDispatch {
    static IID := "{3050F4AD-98B5-11CF-BB82-00AA00BDCE0B}"
    firstPage()
      => ComCall(7, this.p)
    lastPage()
      => ComCall(8, this.p)
    get_cells(p)
      => ComCall(9, this.p, IHTMLElementCollection.Ptr, p)
    moveRow(indexFrom, indexTo, row)
      => ComCall(10, this.p, Int32, indexFrom, Int32, indexTo, IDispatch.Ptr, row)
}
struct IHTMLTable3 extends IDispatch {
    static IID := "{3050F829-98B5-11CF-BB82-00AA00BDCE0B}"
    put_summary(v)
      => ComCall(7, this.p, BSTR, v)
    get_summary(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLTable4 extends IDispatch {
    static IID := "{305106C2-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_tHead(v)
      => ComCall(7, this.p, IHTMLTableSection, v)
    get_tHead(p)
      => ComCall(8, this.p, IHTMLTableSection.Ptr, p)
    putref_tFoot(v)
      => ComCall(9, this.p, IHTMLTableSection, v)
    get_tFoot(p)
      => ComCall(10, this.p, IHTMLTableSection.Ptr, p)
    putref_caption(v)
      => ComCall(11, this.p, IHTMLTableCaption, v)
    get_caption(p)
      => ComCall(12, this.p, IHTMLTableCaption.Ptr, p)
    insertRow(index, row)
      => ComCall(13, this.p, Int32, index, IDispatch.Ptr, row)
    deleteRow(index)
      => ComCall(14, this.p, Int32, index)
    createTBody(tbody)
      => ComCall(15, this.p, IHTMLTableSection.Ptr, tbody)
}
struct IHTMLTableCol extends IDispatch {
    static IID := "{3050F23A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_span(v)
      => ComCall(7, this.p, Int32, v)
    get_span(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_width(v)
      => ComCall(9, this.p, VARIANT, v)
    get_width(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_align(v)
      => ComCall(11, this.p, BSTR, v)
    get_align(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_vAlign(v)
      => ComCall(13, this.p, BSTR, v)
    get_vAlign(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct IHTMLTableCol2 extends IDispatch {
    static IID := "{3050F82A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLTableCol3 extends IDispatch {
    static IID := "{305106C4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLTableSection2 extends IDispatch {
    static IID := "{3050F5C7-98B5-11CF-BB82-00AA00BDCE0B}"
    moveRow(indexFrom, indexTo, row)
      => ComCall(7, this.p, Int32, indexFrom, Int32, indexTo, IDispatch.Ptr, row)
}
struct IHTMLTableSection3 extends IDispatch {
    static IID := "{3050F82B-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLTableSection4 extends IDispatch {
    static IID := "{305106C5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    insertRow(index, row)
      => ComCall(11, this.p, Int32, index, IDispatch.Ptr, row)
    deleteRow(index)
      => ComCall(12, this.p, Int32, index)
}
struct IHTMLTableRow extends IDispatch {
    static IID := "{3050F23C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_vAlign(v)
      => ComCall(9, this.p, BSTR, v)
    get_vAlign(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_bgColor(v)
      => ComCall(11, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_borderColor(v)
      => ComCall(13, this.p, VARIANT, v)
    get_borderColor(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_borderColorLight(v)
      => ComCall(15, this.p, VARIANT, v)
    get_borderColorLight(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_borderColorDark(v)
      => ComCall(17, this.p, VARIANT, v)
    get_borderColorDark(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    get_rowIndex(p)
      => ComCall(19, this.p, Int32.Ptr, p)
    get_sectionRowIndex(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    get_cells(p)
      => ComCall(21, this.p, IHTMLElementCollection.Ptr, p)
    insertCell(index, row)
      => ComCall(22, this.p, Int32, index, IDispatch.Ptr, row)
    deleteCell(index)
      => ComCall(23, this.p, Int32, index)
}
struct IHTMLTableRow2 extends IDispatch {
    static IID := "{3050F4A1-98B5-11CF-BB82-00AA00BDCE0B}"
    put_height(v)
      => ComCall(7, this.p, VARIANT, v)
    get_height(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
}
struct IHTMLTableRow3 extends IDispatch {
    static IID := "{3050F82C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLTableRow4 extends IDispatch {
    static IID := "{305106C6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    insertCell(index, row)
      => ComCall(11, this.p, Int32, index, IDispatch.Ptr, row)
    deleteCell(index)
      => ComCall(12, this.p, Int32, index)
}
struct IHTMLTableRowMetrics extends IDispatch {
    static IID := "{3050F413-98B5-11CF-BB82-00AA00BDCE0B}"
    get_clientHeight(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_clientWidth(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_clientTop(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_clientLeft(p)
      => ComCall(10, this.p, Int32.Ptr, p)
}
struct IHTMLTableCell extends IDispatch {
    static IID := "{3050F23D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_rowSpan(v)
      => ComCall(7, this.p, Int32, v)
    get_rowSpan(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_colSpan(v)
      => ComCall(9, this.p, Int32, v)
    get_colSpan(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    put_align(v)
      => ComCall(11, this.p, BSTR, v)
    get_align(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_vAlign(v)
      => ComCall(13, this.p, BSTR, v)
    get_vAlign(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_bgColor(v)
      => ComCall(15, this.p, VARIANT, v)
    get_bgColor(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_noWrap(v)
      => ComCall(17, this.p, VARIANT_BOOL, v)
    get_noWrap(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    put_background(v)
      => ComCall(19, this.p, BSTR, v)
    get_background(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_borderColor(v)
      => ComCall(21, this.p, VARIANT, v)
    get_borderColor(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_borderColorLight(v)
      => ComCall(23, this.p, VARIANT, v)
    get_borderColorLight(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_borderColorDark(v)
      => ComCall(25, this.p, VARIANT, v)
    get_borderColorDark(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
    put_width(v)
      => ComCall(27, this.p, VARIANT, v)
    get_width(p)
      => ComCall(28, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(29, this.p, VARIANT, v)
    get_height(p)
      => ComCall(30, this.p, VARIANT.Ptr, p)
    get_cellIndex(p)
      => ComCall(31, this.p, Int32.Ptr, p)
}
struct IHTMLTableCell2 extends IDispatch {
    static IID := "{3050F82D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_abbr(v)
      => ComCall(7, this.p, BSTR, v)
    get_abbr(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_axis(v)
      => ComCall(9, this.p, BSTR, v)
    get_axis(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_ch(v)
      => ComCall(11, this.p, BSTR, v)
    get_ch(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(13, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_headers(v)
      => ComCall(15, this.p, BSTR, v)
    get_headers(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_scope(v)
      => ComCall(17, this.p, BSTR, v)
    get_scope(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
}
struct IHTMLTableCell3 extends IDispatch {
    static IID := "{305106C7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_ch(v)
      => ComCall(7, this.p, BSTR, v)
    get_ch(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_chOff(v)
      => ComCall(9, this.p, BSTR, v)
    get_chOff(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct DispHTMLTable extends IDispatch {
    static IID := "{3050F532-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTableCol extends IDispatch {
    static IID := "{3050F533-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTableSection extends IDispatch {
    static IID := "{3050F534-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTableRow extends IDispatch {
    static IID := "{3050F535-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTableCell extends IDispatch {
    static IID := "{3050F536-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLScriptEvents2 extends IDispatch {
    static IID := "{3050F621-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLScriptEvents extends IDispatch {
    static IID := "{3050F3E2-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLScriptElement extends IDispatch {
    static IID := "{3050F28B-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_htmlFor(v)
      => ComCall(9, this.p, BSTR, v)
    get_htmlFor(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_event(v)
      => ComCall(11, this.p, BSTR, v)
    get_event(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_text(v)
      => ComCall(13, this.p, BSTR, v)
    get_text(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_defer(v)
      => ComCall(15, this.p, VARIANT_BOOL, v)
    get_defer(p)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, p)
    get_readyState(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_onerror(v)
      => ComCall(18, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    put_type(v)
      => ComCall(20, this.p, BSTR, v)
    get_type(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
}
struct IHTMLScriptElement2 extends IDispatch {
    static IID := "{3050F828-98B5-11CF-BB82-00AA00BDCE0B}"
    put_charset(v)
      => ComCall(7, this.p, BSTR, v)
    get_charset(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLScriptElement3 extends IDispatch {
    static IID := "{30510447-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLScriptElement4 extends IDispatch {
    static IID := "{30510801-98B5-11CF-BB82-00AA00BDCE0B}"
    get_usedCharset(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
}
struct DispHTMLScriptElement extends IDispatch {
    static IID := "{3050F530-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLNoShowElement extends IDispatch {
    static IID := "{3050F38A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLNoShowElement extends IDispatch {
    static IID := "{3050F528-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLObjectElementEvents2 extends IDispatch {
    static IID := "{3050F620-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLObjectElementEvents extends IDispatch {
    static IID := "{3050F3C4-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLObjectElement extends IDispatch {
    static IID := "{3050F24F-98B5-11CF-BB82-00AA00BDCE0B}"
    get_object(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    get_classid(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_data(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    putref_recordset(v)
      => ComCall(10, this.p, IDispatch, v)
    get_recordset(p)
      => ComCall(11, this.p, IDispatch.Ptr, p)
    put_align(v)
      => ComCall(12, this.p, BSTR, v)
    get_align(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    put_name(v)
      => ComCall(14, this.p, BSTR, v)
    get_name(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_codeBase(v)
      => ComCall(16, this.p, BSTR, v)
    get_codeBase(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    put_codeType(v)
      => ComCall(18, this.p, BSTR, v)
    get_codeType(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    put_code(v)
      => ComCall(20, this.p, BSTR, v)
    get_code(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    get_BaseHref(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(23, this.p, BSTR, v)
    get_type(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    get_form(p)
      => ComCall(25, this.p, IHTMLFormElement.Ptr, p)
    put_width(v)
      => ComCall(26, this.p, VARIANT, v)
    get_width(p)
      => ComCall(27, this.p, VARIANT.Ptr, p)
    put_height(v)
      => ComCall(28, this.p, VARIANT, v)
    get_height(p)
      => ComCall(29, this.p, VARIANT.Ptr, p)
    get_readyState(p)
      => ComCall(30, this.p, Int32.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(31, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(32, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(33, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(34, this.p, VARIANT.Ptr, p)
    put_altHtml(v)
      => ComCall(35, this.p, BSTR, v)
    get_altHtml(p)
      => ComCall(36, this.p, BSTR.Ptr, p)
    put_vspace(v)
      => ComCall(37, this.p, Int32, v)
    get_vspace(p)
      => ComCall(38, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(39, this.p, Int32, v)
    get_hspace(p)
      => ComCall(40, this.p, Int32.Ptr, p)
}
struct IHTMLObjectElement2 extends IDispatch {
    static IID := "{3050F4CD-98B5-11CF-BB82-00AA00BDCE0B}"
    namedRecordset(dataMember, hierarchy, ppRecordset)
      => ComCall(7, this.p, BSTR, dataMember, VARIANT.Ptr, hierarchy, IDispatch.Ptr, ppRecordset)
    put_classid(v)
      => ComCall(8, this.p, BSTR, v)
    get_classid(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_data(v)
      => ComCall(10, this.p, BSTR, v)
    get_data(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
}
struct IHTMLObjectElement3 extends IDispatch {
    static IID := "{3050F827-98B5-11CF-BB82-00AA00BDCE0B}"
    put_archive(v)
      => ComCall(7, this.p, BSTR, v)
    get_archive(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_alt(v)
      => ComCall(9, this.p, BSTR, v)
    get_alt(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_declare(v)
      => ComCall(11, this.p, VARIANT_BOOL, v)
    get_declare(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    put_standby(v)
      => ComCall(13, this.p, BSTR, v)
    get_standby(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(15, this.p, VARIANT, v)
    get_border(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_useMap(v)
      => ComCall(17, this.p, BSTR, v)
    get_useMap(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
}
struct IHTMLObjectElement4 extends IDispatch {
    static IID := "{3051043E-98B5-11CF-BB82-00AA00BDCE0B}"
    get_contentDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    put_codeBase(v)
      => ComCall(8, this.p, BSTR, v)
    get_codeBase(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_data(v)
      => ComCall(10, this.p, BSTR, v)
    get_data(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
}
struct IHTMLObjectElement5 extends IDispatch {
    static IID := "{305104B5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_object(v)
      => ComCall(7, this.p, BSTR, v)
    get_object(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLParamElement extends IDispatch {
    static IID := "{3050F83D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_name(v)
      => ComCall(7, this.p, BSTR, v)
    get_name(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, BSTR, v)
    get_value(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(11, this.p, BSTR, v)
    get_type(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_valueType(v)
      => ComCall(13, this.p, BSTR, v)
    get_valueType(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct IHTMLParamElement2 extends IDispatch {
    static IID := "{30510444-98B5-11CF-BB82-00AA00BDCE0B}"
    put_name(v)
      => ComCall(7, this.p, BSTR, v)
    get_name(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(9, this.p, BSTR, v)
    get_type(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_value(v)
      => ComCall(11, this.p, BSTR, v)
    get_value(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_valueType(v)
      => ComCall(13, this.p, BSTR, v)
    get_valueType(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct DispHTMLObjectElement extends IDispatch {
    static IID := "{3050F529-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLParamElement extends IDispatch {
    static IID := "{3050F590-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLFrameSiteEvents2 extends IDispatch {
    static IID := "{3050F7FF-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLFrameSiteEvents extends IDispatch {
    static IID := "{3050F800-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFrameBase2 extends IDispatch {
    static IID := "{3050F6DB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_contentWindow(p)
      => ComCall(7, this.p, IHTMLWindow2.Ptr, p)
    put_onload(v)
      => ComCall(8, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(10, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_readyState(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_allowTransparency(v)
      => ComCall(13, this.p, VARIANT_BOOL, v)
    get_allowTransparency(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLFrameBase3 extends IDispatch {
    static IID := "{3050F82E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_longDesc(v)
      => ComCall(7, this.p, BSTR, v)
    get_longDesc(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLFrameBase extends IDispatch {
    static IID := "{3050F541-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFrameElement extends IDispatch {
    static IID := "{3050F313-98B5-11CF-BB82-00AA00BDCE0B}"
    put_borderColor(v)
      => ComCall(7, this.p, VARIANT, v)
    get_borderColor(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
}
struct IHTMLFrameElement2 extends IDispatch {
    static IID := "{3050F7F5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_height(v)
      => ComCall(7, this.p, VARIANT, v)
    get_height(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_width(v)
      => ComCall(9, this.p, VARIANT, v)
    get_width(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLFrameElement3 extends IDispatch {
    static IID := "{3051042D-98B5-11CF-BB82-00AA00BDCE0B}"
    get_contentDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    put_src(v)
      => ComCall(8, this.p, BSTR, v)
    get_src(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_longDesc(v)
      => ComCall(10, this.p, BSTR, v)
    get_longDesc(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_frameBorder(v)
      => ComCall(12, this.p, BSTR, v)
    get_frameBorder(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
}
struct DispHTMLFrameElement extends IDispatch {
    static IID := "{3050F513-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLIFrameElement extends IDispatch {
    static IID := "{3050F315-98B5-11CF-BB82-00AA00BDCE0B}"
    put_vspace(v)
      => ComCall(7, this.p, Int32, v)
    get_vspace(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_hspace(v)
      => ComCall(9, this.p, Int32, v)
    get_hspace(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    put_align(v)
      => ComCall(11, this.p, BSTR, v)
    get_align(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct IHTMLIFrameElement2 extends IDispatch {
    static IID := "{3050F4E6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_height(v)
      => ComCall(7, this.p, VARIANT, v)
    get_height(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_width(v)
      => ComCall(9, this.p, VARIANT, v)
    get_width(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLIFrameElement3 extends IDispatch {
    static IID := "{30510433-98B5-11CF-BB82-00AA00BDCE0B}"
    get_contentDocument(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    put_src(v)
      => ComCall(8, this.p, BSTR, v)
    get_src(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_longDesc(v)
      => ComCall(10, this.p, BSTR, v)
    get_longDesc(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_frameBorder(v)
      => ComCall(12, this.p, BSTR, v)
    get_frameBorder(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
}
struct DispHTMLIFrame extends IDispatch {
    static IID := "{3050F51B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLDivPosition extends IDispatch {
    static IID := "{3050F212-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLFieldSetElement extends IDispatch {
    static IID := "{3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLFieldSetElement2 extends IDispatch {
    static IID := "{3050F833-98B5-11CF-BB82-00AA00BDCE0B}"
    get_form(p)
      => ComCall(7, this.p, IHTMLFormElement.Ptr, p)
}
struct IHTMLLegendElement extends IDispatch {
    static IID := "{3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLLegendElement2 extends IDispatch {
    static IID := "{3050F834-98B5-11CF-BB82-00AA00BDCE0B}"
    get_form(p)
      => ComCall(7, this.p, IHTMLFormElement.Ptr, p)
}
struct DispHTMLDivPosition extends IDispatch {
    static IID := "{3050F50F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLFieldSetElement extends IDispatch {
    static IID := "{3050F545-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLLegendElement extends IDispatch {
    static IID := "{3050F546-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLSpanFlow extends IDispatch {
    static IID := "{3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, BSTR, v)
    get_align(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLSpanFlow extends IDispatch {
    static IID := "{3050F544-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFrameSetElement extends IDispatch {
    static IID := "{3050F319-98B5-11CF-BB82-00AA00BDCE0B}"
    put_rows(v)
      => ComCall(7, this.p, BSTR, v)
    get_rows(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_cols(v)
      => ComCall(9, this.p, BSTR, v)
    get_cols(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(11, this.p, VARIANT, v)
    get_border(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_borderColor(v)
      => ComCall(13, this.p, VARIANT, v)
    get_borderColor(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_frameBorder(v)
      => ComCall(15, this.p, BSTR, v)
    get_frameBorder(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_frameSpacing(v)
      => ComCall(17, this.p, VARIANT, v)
    get_frameSpacing(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    put_name(v)
      => ComCall(19, this.p, BSTR, v)
    get_name(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_onload(v)
      => ComCall(21, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    put_onunload(v)
      => ComCall(23, this.p, VARIANT, v)
    get_onunload(p)
      => ComCall(24, this.p, VARIANT.Ptr, p)
    put_onbeforeunload(v)
      => ComCall(25, this.p, VARIANT, v)
    get_onbeforeunload(p)
      => ComCall(26, this.p, VARIANT.Ptr, p)
}
struct IHTMLFrameSetElement2 extends IDispatch {
    static IID := "{3050F5C6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onbeforeprint(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onbeforeprint(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onafterprint(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onafterprint(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLFrameSetElement3 extends IDispatch {
    static IID := "{30510796-98B5-11CF-BB82-00AA00BDCE0B}"
    put_onhashchange(v)
      => ComCall(7, this.p, VARIANT, v)
    get_onhashchange(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_onmessage(v)
      => ComCall(9, this.p, VARIANT, v)
    get_onmessage(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onoffline(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onoffline(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_ononline(v)
      => ComCall(13, this.p, VARIANT, v)
    get_ononline(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_onstorage(v)
      => ComCall(15, this.p, VARIANT, v)
    get_onstorage(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
}
struct DispHTMLFrameSetSite extends IDispatch {
    static IID := "{3050F514-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLBGsound extends IDispatch {
    static IID := "{3050F369-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_loop(v)
      => ComCall(9, this.p, VARIANT, v)
    get_loop(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_volume(v)
      => ComCall(11, this.p, VARIANT, v)
    get_volume(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_balance(v)
      => ComCall(13, this.p, VARIANT, v)
    get_balance(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
}
struct DispHTMLBGsound extends IDispatch {
    static IID := "{3050F53C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLFontNamesCollection extends IDispatch {
    static IID := "{3050F376-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(index, pBstr)
      => ComCall(9, this.p, Int32, index, BSTR.Ptr, pBstr)
}
struct IHTMLFontSizesCollection extends IDispatch {
    static IID := "{3050F377-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    get_forFont(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    item(index, plSize)
      => ComCall(10, this.p, Int32, index, Int32.Ptr, plSize)
}
struct IHTMLOptionsHolder extends IDispatch {
    static IID := "{3050F378-98B5-11CF-BB82-00AA00BDCE0B}"
    get_document(p)
      => ComCall(7, this.p, IHTMLDocument2.Ptr, p)
    get_fonts(p)
      => ComCall(8, this.p, IHTMLFontNamesCollection.Ptr, p)
    put_execArg(v)
      => ComCall(9, this.p, VARIANT, v)
    get_execArg(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_errorLine(v)
      => ComCall(11, this.p, Int32, v)
    get_errorLine(p)
      => ComCall(12, this.p, Int32.Ptr, p)
    put_errorCharacter(v)
      => ComCall(13, this.p, Int32, v)
    get_errorCharacter(p)
      => ComCall(14, this.p, Int32.Ptr, p)
    put_errorCode(v)
      => ComCall(15, this.p, Int32, v)
    get_errorCode(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    put_errorMessage(v)
      => ComCall(17, this.p, BSTR, v)
    get_errorMessage(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_errorDebug(v)
      => ComCall(19, this.p, VARIANT_BOOL, v)
    get_errorDebug(p)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, p)
    get_unsecuredWindowOfDocument(p)
      => ComCall(21, this.p, IHTMLWindow2.Ptr, p)
    put_findText(v)
      => ComCall(22, this.p, BSTR, v)
    get_findText(p)
      => ComCall(23, this.p, BSTR.Ptr, p)
    put_anythingAfterFrameset(v)
      => ComCall(24, this.p, VARIANT_BOOL, v)
    get_anythingAfterFrameset(p)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, p)
    sizes(fontName, pSizesCollection)
      => ComCall(26, this.p, BSTR, fontName, IHTMLFontSizesCollection.Ptr, pSizesCollection)
    openfiledlg(initFile, initDir, filter, title, pathName)
      => ComCall(27, this.p, VARIANT, initFile, VARIANT, initDir, VARIANT, filter, VARIANT, title, BSTR.Ptr, pathName)
    savefiledlg(initFile, initDir, filter, title, pathName)
      => ComCall(28, this.p, VARIANT, initFile, VARIANT, initDir, VARIANT, filter, VARIANT, title, BSTR.Ptr, pathName)
    choosecolordlg(initColor, rgbColor)
      => ComCall(29, this.p, VARIANT, initColor, Int32.Ptr, rgbColor)
    showSecurityInfo()
      => ComCall(30, this.p)
    isApartmentModel(object, fApartment)
      => ComCall(31, this.p, IHTMLObjectElement, object, VARIANT_BOOL.Ptr, fApartment)
    getCharset(fontName, charset)
      => ComCall(32, this.p, BSTR, fontName, Int32.Ptr, charset)
    get_secureConnectionInfo(p)
      => ComCall(33, this.p, BSTR.Ptr, p)
}
struct HTMLStyleElementEvents2 extends IDispatch {
    static IID := "{3050F615-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLStyleElementEvents extends IDispatch {
    static IID := "{3050F3CB-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleElement extends IDispatch {
    static IID := "{3050F375-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_readyState(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(10, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(12, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(14, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    get_styleSheet(p)
      => ComCall(16, this.p, IHTMLStyleSheet.Ptr, p)
    put_disabled(v)
      => ComCall(17, this.p, VARIANT_BOOL, v)
    get_disabled(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    put_media(v)
      => ComCall(19, this.p, BSTR, v)
    get_media(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
}
struct IHTMLStyleElement2 extends IDispatch {
    static IID := "{3051072A-98B5-11CF-BB82-00AA00BDCE0B}"
    get_sheet(p)
      => ComCall(7, this.p, IHTMLStyleSheet.Ptr, p)
}
struct DispHTMLStyleElement extends IDispatch {
    static IID := "{3050F511-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleFontFace extends IDispatch {
    static IID := "{3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_fontsrc(v)
      => ComCall(7, this.p, BSTR, v)
    get_fontsrc(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IHTMLStyleFontFace2 extends IDispatch {
    static IID := "{305106EC-98B5-11CF-BB82-00AA00BDCE0B}"
    get_style(p)
      => ComCall(7, this.p, IHTMLRuleStyle.Ptr, p)
}
struct DispHTMLStyleFontFace extends IDispatch {
    static IID := "{30590081-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLXDomainRequest extends IDispatch {
    static IID := "{30510454-98B5-11CF-BB82-00AA00BDCE0B}"
    get_responseText(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_timeout(v)
      => ComCall(8, this.p, Int32, v)
    get_timeout(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_contentType(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_onprogress(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onprogress(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_onerror(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onerror(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    put_ontimeout(v)
      => ComCall(15, this.p, VARIANT, v)
    get_ontimeout(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_onload(v)
      => ComCall(17, this.p, VARIANT, v)
    get_onload(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    abort()
      => ComCall(19, this.p)
    open(bstrMethod, bstrUrl)
      => ComCall(20, this.p, BSTR, bstrMethod, BSTR, bstrUrl)
    send(varBody)
      => ComCall(21, this.p, VARIANT, varBody)
}
struct IHTMLXDomainRequestFactory extends IDispatch {
    static IID := "{30510456-98B5-11CF-BB82-00AA00BDCE0B}"
    create(__MIDL__IHTMLXDomainRequestFactory0000)
      => ComCall(7, this.p, IHTMLXDomainRequest.Ptr, __MIDL__IHTMLXDomainRequestFactory0000)
}
struct DispXDomainRequest extends IDispatch {
    static IID := "{3050F599-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStorage2 extends IDispatch {
    static IID := "{30510799-98B5-11CF-BB82-00AA00BDCE0B}"
    setItem(bstrKey, bstrValue)
      => ComCall(7, this.p, BSTR, bstrKey, BSTR, bstrValue)
}
struct DispHTMLStorage extends IDispatch {
    static IID := "{3050F59D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IEventTarget extends IDispatch {
    static IID := "{305104B9-98B5-11CF-BB82-00AA00BDCE0B}"
    addEventListener(type, listener, useCapture)
      => ComCall(7, this.p, BSTR, type, IDispatch, listener, VARIANT_BOOL, useCapture)
    removeEventListener(type, listener, useCapture)
      => ComCall(8, this.p, BSTR, type, IDispatch, listener, VARIANT_BOOL, useCapture)
    dispatchEvent(evt, pfResult)
      => ComCall(9, this.p, IDOMEvent, evt, VARIANT_BOOL.Ptr, pfResult)
}
struct DispDOMEvent extends IDispatch {
    static IID := "{3050F5A2-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMUIEvent extends IDispatch {
    static IID := "{305106CA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_view(p)
      => ComCall(7, this.p, IHTMLWindow2.Ptr, p)
    get_detail(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    initUIEvent(eventType, canBubble, cancelable, view, detail)
      => ComCall(9, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, view, Int32, detail)
}
struct DispDOMUIEvent extends IDispatch {
    static IID := "{30590072-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMouseEvent extends IDispatch {
    static IID := "{305106CE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_screenX(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_screenY(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_clientX(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_clientY(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_ctrlKey(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    get_shiftKey(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    get_altKey(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    get_metaKey(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_button(p)
      => ComCall(15, this.p, UInt16.Ptr, p)
    get_relatedTarget(p)
      => ComCall(16, this.p, IEventTarget.Ptr, p)
    initMouseEvent(eventType, canBubble, cancelable, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, ctrlKeyArg, altKeyArg, shiftKeyArg, metaKeyArg, buttonArg, relatedTargetArg)
      => ComCall(17, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, Int32, detailArg, Int32, screenXArg, Int32, screenYArg, Int32, clientXArg, Int32, clientYArg, VARIANT_BOOL, ctrlKeyArg, VARIANT_BOOL, altKeyArg, VARIANT_BOOL, shiftKeyArg, VARIANT_BOOL, metaKeyArg, UInt16, buttonArg, IEventTarget, relatedTargetArg)
    getModifierState(keyArg, activated)
      => ComCall(18, this.p, BSTR, keyArg, VARIANT_BOOL.Ptr, activated)
    get_buttons(p)
      => ComCall(19, this.p, UInt16.Ptr, p)
    get_fromElement(p)
      => ComCall(20, this.p, IHTMLElement.Ptr, p)
    get_toElement(p)
      => ComCall(21, this.p, IHTMLElement.Ptr, p)
    get_x(p)
      => ComCall(22, this.p, Int32.Ptr, p)
    get_y(p)
      => ComCall(23, this.p, Int32.Ptr, p)
    get_offsetX(p)
      => ComCall(24, this.p, Int32.Ptr, p)
    get_offsetY(p)
      => ComCall(25, this.p, Int32.Ptr, p)
    get_pageX(p)
      => ComCall(26, this.p, Int32.Ptr, p)
    get_pageY(p)
      => ComCall(27, this.p, Int32.Ptr, p)
    get_layerX(p)
      => ComCall(28, this.p, Int32.Ptr, p)
    get_layerY(p)
      => ComCall(29, this.p, Int32.Ptr, p)
    get_which(p)
      => ComCall(30, this.p, UInt16.Ptr, p)
}
struct DispDOMMouseEvent extends IDispatch {
    static IID := "{30590073-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMDragEvent extends IDispatch {
    static IID := "{30510761-98B5-11CF-BB82-00AA00BDCE0B}"
    get_dataTransfer(p)
      => ComCall(7, this.p, IHTMLDataTransfer.Ptr, p)
    initDragEvent(eventType, canBubble, cancelable, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, ctrlKeyArg, altKeyArg, shiftKeyArg, metaKeyArg, buttonArg, relatedTargetArg, dataTransferArg)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, Int32, detailArg, Int32, screenXArg, Int32, screenYArg, Int32, clientXArg, Int32, clientYArg, VARIANT_BOOL, ctrlKeyArg, VARIANT_BOOL, altKeyArg, VARIANT_BOOL, shiftKeyArg, VARIANT_BOOL, metaKeyArg, UInt16, buttonArg, IEventTarget, relatedTargetArg, IHTMLDataTransfer, dataTransferArg)
}
struct DispDOMDragEvent extends IDispatch {
    static IID := "{305900A7-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMouseWheelEvent extends IDispatch {
    static IID := "{305106D0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_wheelDelta(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    initMouseWheelEvent(eventType, canBubble, cancelable, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, buttonArg, relatedTargetArg, modifiersListArg, wheelDeltaArg)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, Int32, detailArg, Int32, screenXArg, Int32, screenYArg, Int32, clientXArg, Int32, clientYArg, UInt16, buttonArg, IEventTarget, relatedTargetArg, BSTR, modifiersListArg, Int32, wheelDeltaArg)
}
struct DispDOMMouseWheelEvent extends IDispatch {
    static IID := "{30590074-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMWheelEvent extends IDispatch {
    static IID := "{305106D2-98B5-11CF-BB82-00AA00BDCE0B}"
    get_deltaX(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_deltaY(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_deltaZ(p)
      => ComCall(9, this.p, Int32.Ptr, p)
    get_deltaMode(p)
      => ComCall(10, this.p, UInt32.Ptr, p)
    initWheelEvent(eventType, canBubble, cancelable, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, buttonArg, relatedTargetArg, modifiersListArg, deltaX, deltaY, deltaZ, deltaMode)
      => ComCall(11, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, Int32, detailArg, Int32, screenXArg, Int32, screenYArg, Int32, clientXArg, Int32, clientYArg, UInt16, buttonArg, IEventTarget, relatedTargetArg, BSTR, modifiersListArg, Int32, deltaX, Int32, deltaY, Int32, deltaZ, UInt32, deltaMode)
}
struct DispDOMWheelEvent extends IDispatch {
    static IID := "{30590075-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMTextEvent extends IDispatch {
    static IID := "{305106D4-98B5-11CF-BB82-00AA00BDCE0B}"
    get_data(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_inputMethod(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    initTextEvent(eventType, canBubble, cancelable, viewArg, dataArg, inputMethod, locale)
      => ComCall(9, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, BSTR, dataArg, UInt32, inputMethod, BSTR, locale)
    get_locale(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct DispDOMTextEvent extends IDispatch {
    static IID := "{30590076-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMKeyboardEvent extends IDispatch {
    static IID := "{305106D6-98B5-11CF-BB82-00AA00BDCE0B}"
    get_key(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_location(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    get_ctrlKey(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    get_shiftKey(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    get_altKey(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    get_metaKey(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    get_repeat(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    getModifierState(keyArg, state)
      => ComCall(14, this.p, BSTR, keyArg, VARIANT_BOOL.Ptr, state)
    initKeyboardEvent(eventType, canBubble, cancelable, viewArg, keyArg, locationArg, modifiersListArg, repeat, locale)
      => ComCall(15, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, BSTR, keyArg, UInt32, locationArg, BSTR, modifiersListArg, VARIANT_BOOL, repeat, BSTR, locale)
    get_keyCode(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    get_charCode(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    get_which(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    get_ie9_char(p)
      => ComCall(19, this.p, VARIANT.Ptr, p)
    get_locale(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
}
struct DispDOMKeyboardEvent extends IDispatch {
    static IID := "{30590077-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMCompositionEvent extends IDispatch {
    static IID := "{305106D8-98B5-11CF-BB82-00AA00BDCE0B}"
    get_data(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    initCompositionEvent(eventType, canBubble, cancelable, viewArg, data, locale)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, BSTR, data, BSTR, locale)
    get_locale(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispDOMCompositionEvent extends IDispatch {
    static IID := "{30590078-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMutationEvent extends IDispatch {
    static IID := "{305106DA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_relatedNode(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    get_prevValue(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_newValue(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_attrName(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_attrChange(p)
      => ComCall(11, this.p, UInt16.Ptr, p)
    initMutationEvent(eventType, canBubble, cancelable, relatedNodeArg, prevValueArg, newValueArg, attrNameArg, attrChangeArg)
      => ComCall(12, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IDispatch, relatedNodeArg, BSTR, prevValueArg, BSTR, newValueArg, BSTR, attrNameArg, UInt16, attrChangeArg)
}
struct DispDOMMutationEvent extends IDispatch {
    static IID := "{30590079-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMBeforeUnloadEvent extends IDispatch {
    static IID := "{30510763-98B5-11CF-BB82-00AA00BDCE0B}"
    put_returnValue(v)
      => ComCall(7, this.p, VARIANT, v)
    get_returnValue(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
}
struct DispDOMBeforeUnloadEvent extends IDispatch {
    static IID := "{305900A8-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMFocusEvent extends IDispatch {
    static IID := "{305106CC-98B5-11CF-BB82-00AA00BDCE0B}"
    get_relatedTarget(p)
      => ComCall(7, this.p, IEventTarget.Ptr, p)
    initFocusEvent(eventType, canBubble, cancelable, view, detail, relatedTargetArg)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, view, Int32, detail, IEventTarget, relatedTargetArg)
}
struct DispDOMFocusEvent extends IDispatch {
    static IID := "{30590071-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMCustomEvent extends IDispatch {
    static IID := "{305106DE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_detail(p)
      => ComCall(7, this.p, VARIANT.Ptr, p)
    initCustomEvent(eventType, canBubble, cancelable, detail)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, VARIANT.Ptr, detail)
}
struct DispDOMCustomEvent extends IDispatch {
    static IID := "{3059007C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ICanvasGradient extends IDispatch {
    static IID := "{30510714-98B5-11CF-BB82-00AA00BDCE0B}"
    addColorStop(offset, color)
      => ComCall(7, this.p, Float32, offset, BSTR, color)
}
struct ICanvasPattern extends IDispatch {
    static IID := "{30510716-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ICanvasTextMetrics extends IDispatch {
    static IID := "{30510718-98B5-11CF-BB82-00AA00BDCE0B}"
    get_width(p)
      => ComCall(7, this.p, Float32.Ptr, p)
}
struct ICanvasImageData extends IDispatch {
    static IID := "{3051071A-98B5-11CF-BB82-00AA00BDCE0B}"
    get_width(p)
      => ComCall(7, this.p, UInt32.Ptr, p)
    get_height(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    get_data(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
}
struct ICanvasPixelArray extends IDispatch {
    static IID := "{3051071C-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, UInt32.Ptr, p)
}
struct IHTMLCanvasElement extends IDispatch {
    static IID := "{305106E4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_width(v)
      => ComCall(7, this.p, Int32, v)
    get_width(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_height(v)
      => ComCall(9, this.p, Int32, v)
    get_height(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    getContext(contextId, ppContext)
      => ComCall(11, this.p, BSTR, contextId, ICanvasRenderingContext2D.Ptr, ppContext)
    toDataURL(type, jpegquality, pUrl)
      => ComCall(12, this.p, BSTR, type, VARIANT, jpegquality, BSTR.Ptr, pUrl)
}
struct ICanvasRenderingContext2D extends IDispatch {
    static IID := "{305106FF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_canvas(p)
      => ComCall(7, this.p, IHTMLCanvasElement.Ptr, p)
    restore()
      => ComCall(8, this.p)
    save()
      => ComCall(9, this.p)
    rotate(angle)
      => ComCall(10, this.p, Float32, angle)
    scale(x, y)
      => ComCall(11, this.p, Float32, x, Float32, y)
    setTransform(m11, m12, m21, m22, dx, dy)
      => ComCall(12, this.p, Float32, m11, Float32, m12, Float32, m21, Float32, m22, Float32, dx, Float32, dy)
    transform(m11, m12, m21, m22, dx, dy)
      => ComCall(13, this.p, Float32, m11, Float32, m12, Float32, m21, Float32, m22, Float32, dx, Float32, dy)
    translate(x, y)
      => ComCall(14, this.p, Float32, x, Float32, y)
    put_globalAlpha(v)
      => ComCall(15, this.p, Float32, v)
    get_globalAlpha(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_globalCompositeOperation(v)
      => ComCall(17, this.p, BSTR, v)
    get_globalCompositeOperation(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_fillStyle(v)
      => ComCall(19, this.p, VARIANT, v)
    get_fillStyle(p)
      => ComCall(20, this.p, VARIANT.Ptr, p)
    put_strokeStyle(v)
      => ComCall(21, this.p, VARIANT, v)
    get_strokeStyle(p)
      => ComCall(22, this.p, VARIANT.Ptr, p)
    createLinearGradient(x0, y0, x1, y1, ppCanvasGradient)
      => ComCall(23, this.p, Float32, x0, Float32, y0, Float32, x1, Float32, y1, ICanvasGradient.Ptr, ppCanvasGradient)
    createRadialGradient(x0, y0, r0, x1, y1, r1, ppCanvasGradient)
      => ComCall(24, this.p, Float32, x0, Float32, y0, Float32, r0, Float32, x1, Float32, y1, Float32, r1, ICanvasGradient.Ptr, ppCanvasGradient)
    createPattern(image, repetition, ppCanvasPattern)
      => ComCall(25, this.p, IDispatch, image, VARIANT, repetition, ICanvasPattern.Ptr, ppCanvasPattern)
    put_lineCap(v)
      => ComCall(26, this.p, BSTR, v)
    get_lineCap(p)
      => ComCall(27, this.p, BSTR.Ptr, p)
    put_lineJoin(v)
      => ComCall(28, this.p, BSTR, v)
    get_lineJoin(p)
      => ComCall(29, this.p, BSTR.Ptr, p)
    put_lineWidth(v)
      => ComCall(30, this.p, Float32, v)
    get_lineWidth(p)
      => ComCall(31, this.p, Float32.Ptr, p)
    put_miterLimit(v)
      => ComCall(32, this.p, Float32, v)
    get_miterLimit(p)
      => ComCall(33, this.p, Float32.Ptr, p)
    put_shadowBlur(v)
      => ComCall(34, this.p, Float32, v)
    get_shadowBlur(p)
      => ComCall(35, this.p, Float32.Ptr, p)
    put_shadowColor(v)
      => ComCall(36, this.p, BSTR, v)
    get_shadowColor(p)
      => ComCall(37, this.p, BSTR.Ptr, p)
    put_shadowOffsetX(v)
      => ComCall(38, this.p, Float32, v)
    get_shadowOffsetX(p)
      => ComCall(39, this.p, Float32.Ptr, p)
    put_shadowOffsetY(v)
      => ComCall(40, this.p, Float32, v)
    get_shadowOffsetY(p)
      => ComCall(41, this.p, Float32.Ptr, p)
    clearRect(x, y, w, h)
      => ComCall(42, this.p, Float32, x, Float32, y, Float32, w, Float32, h)
    fillRect(x, y, w, h)
      => ComCall(43, this.p, Float32, x, Float32, y, Float32, w, Float32, h)
    strokeRect(x, y, w, h)
      => ComCall(44, this.p, Float32, x, Float32, y, Float32, w, Float32, h)
    arc(x, y, radius, startAngle, endAngle, anticlockwise)
      => ComCall(45, this.p, Float32, x, Float32, y, Float32, radius, Float32, startAngle, Float32, endAngle, BOOL, anticlockwise)
    arcTo(x1, y1, x2, y2, radius)
      => ComCall(46, this.p, Float32, x1, Float32, y1, Float32, x2, Float32, y2, Float32, radius)
    beginPath()
      => ComCall(47, this.p)
    bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y)
      => ComCall(48, this.p, Float32, cp1x, Float32, cp1y, Float32, cp2x, Float32, cp2y, Float32, x, Float32, y)
    clip()
      => ComCall(49, this.p)
    closePath()
      => ComCall(50, this.p)
    fill()
      => ComCall(51, this.p)
    lineTo(x, y)
      => ComCall(52, this.p, Float32, x, Float32, y)
    moveTo(x, y)
      => ComCall(53, this.p, Float32, x, Float32, y)
    quadraticCurveTo(cpx, cpy, x, y)
      => ComCall(54, this.p, Float32, cpx, Float32, cpy, Float32, x, Float32, y)
    rect(x, y, w, h)
      => ComCall(55, this.p, Float32, x, Float32, y, Float32, w, Float32, h)
    stroke()
      => ComCall(56, this.p)
    isPointInPath(x, y, pResult)
      => ComCall(57, this.p, Float32, x, Float32, y, VARIANT_BOOL.Ptr, pResult)
    put_font(v)
      => ComCall(58, this.p, BSTR, v)
    get_font(p)
      => ComCall(59, this.p, BSTR.Ptr, p)
    put_textAlign(v)
      => ComCall(60, this.p, BSTR, v)
    get_textAlign(p)
      => ComCall(61, this.p, BSTR.Ptr, p)
    put_textBaseline(v)
      => ComCall(62, this.p, BSTR, v)
    get_textBaseline(p)
      => ComCall(63, this.p, BSTR.Ptr, p)
    fillText(text, x, y, maxWidth)
      => ComCall(64, this.p, BSTR, text, Float32, x, Float32, y, VARIANT, maxWidth)
    measureText(text, ppCanvasTextMetrics)
      => ComCall(65, this.p, BSTR, text, ICanvasTextMetrics.Ptr, ppCanvasTextMetrics)
    strokeText(text, x, y, maxWidth)
      => ComCall(66, this.p, BSTR, text, Float32, x, Float32, y, VARIANT, maxWidth)
    drawImage(pSrc, a1, a2, a3, a4, a5, a6, a7, a8)
      => ComCall(67, this.p, IDispatch, pSrc, VARIANT, a1, VARIANT, a2, VARIANT, a3, VARIANT, a4, VARIANT, a5, VARIANT, a6, VARIANT, a7, VARIANT, a8)
    createImageData(a1, a2, ppCanvasImageData)
      => ComCall(68, this.p, VARIANT, a1, VARIANT, a2, ICanvasImageData.Ptr, ppCanvasImageData)
    getImageData(sx, sy, sw, sh, ppCanvasImageData)
      => ComCall(69, this.p, Float32, sx, Float32, sy, Float32, sw, Float32, sh, ICanvasImageData.Ptr, ppCanvasImageData)
    putImageData(imagedata, dx, dy, dirtyX, dirtyY, dirtyWidth, dirtyHeight)
      => ComCall(70, this.p, ICanvasImageData, imagedata, Float32, dx, Float32, dy, VARIANT, dirtyX, VARIANT, dirtyY, VARIANT, dirtyWidth, VARIANT, dirtyHeight)
}
struct DispCanvasGradient extends IDispatch {
    static IID := "{3059008C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispCanvasPattern extends IDispatch {
    static IID := "{3059008D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispCanvasTextMetrics extends IDispatch {
    static IID := "{3059008E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispCanvasImageData extends IDispatch {
    static IID := "{3059008F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispCanvasRenderingContext2D extends IDispatch {
    static IID := "{30590082-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLCanvasElement extends IDispatch {
    static IID := "{3059007B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMProgressEvent extends IDispatch {
    static IID := "{3051071E-98B5-11CF-BB82-00AA00BDCE0B}"
    get_lengthComputable(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    get_loaded(p)
      => ComCall(8, this.p, Int64.Ptr, p)
    get_total(p)
      => ComCall(9, this.p, Int64.Ptr, p)
    initProgressEvent(eventType, canBubble, cancelable, lengthComputableArg, loadedArg, totalArg)
      => ComCall(10, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, VARIANT_BOOL, lengthComputableArg, Int64, loadedArg, Int64, totalArg)
}
struct DispDOMProgressEvent extends IDispatch {
    static IID := "{30590091-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMessageEvent extends IDispatch {
    static IID := "{30510720-98B5-11CF-BB82-00AA00BDCE0B}"
    get_data(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_origin(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_source(p)
      => ComCall(9, this.p, IHTMLWindow2.Ptr, p)
    initMessageEvent(eventType, canBubble, cancelable, data, origin, lastEventId, source)
      => ComCall(10, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, BSTR, data, BSTR, origin, BSTR, lastEventId, IHTMLWindow2, source)
}
struct DispDOMMessageEvent extends IDispatch {
    static IID := "{30590092-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMSiteModeEvent extends IDispatch {
    static IID := "{30510765-98B6-11CF-BB82-00AA00BDCE0B}"
    get_buttonID(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_actionURL(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispDOMSiteModeEvent extends IDispatch {
    static IID := "{305900A9-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMStorageEvent extends IDispatch {
    static IID := "{30510722-98B5-11CF-BB82-00AA00BDCE0B}"
    get_key(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_oldValue(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_newValue(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_url(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_storageArea(p)
      => ComCall(11, this.p, IHTMLStorage.Ptr, p)
    initStorageEvent(eventType, canBubble, cancelable, keyArg, oldValueArg, newValueArg, urlArg, storageAreaArg)
      => ComCall(12, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, BSTR, keyArg, BSTR, oldValueArg, BSTR, newValueArg, BSTR, urlArg, IHTMLStorage, storageAreaArg)
}
struct DispDOMStorageEvent extends IDispatch {
    static IID := "{30590093-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IXMLHttpRequestEventTarget extends IDispatch {
    static IID := "{30510830-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispXMLHttpRequestEventTarget extends IDispatch {
    static IID := "{305900E7-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct HTMLXMLHttpRequestEvents extends IDispatch {
    static IID := "{30510498-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLXMLHttpRequest extends IDispatch {
    static IID := "{3051040A-98B5-11CF-BB82-00AA00BDCE0B}"
    get_readyState(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_responseBody(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_responseText(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_responseXML(p)
      => ComCall(10, this.p, IDispatch.Ptr, p)
    get_status(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    get_statusText(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(13, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    abort()
      => ComCall(15, this.p)
    open(bstrMethod, bstrUrl, varAsync, varUser, varPassword)
      => ComCall(16, this.p, BSTR, bstrMethod, BSTR, bstrUrl, VARIANT, varAsync, VARIANT, varUser, VARIANT, varPassword)
    send(varBody)
      => ComCall(17, this.p, VARIANT, varBody)
    getAllResponseHeaders(__MIDL__IHTMLXMLHttpRequest0000)
      => ComCall(18, this.p, BSTR.Ptr, __MIDL__IHTMLXMLHttpRequest0000)
    getResponseHeader(bstrHeader, __MIDL__IHTMLXMLHttpRequest0001)
      => ComCall(19, this.p, BSTR, bstrHeader, BSTR.Ptr, __MIDL__IHTMLXMLHttpRequest0001)
    setRequestHeader(bstrHeader, bstrValue)
      => ComCall(20, this.p, BSTR, bstrHeader, BSTR, bstrValue)
}
struct IHTMLXMLHttpRequest2 extends IDispatch {
    static IID := "{30510482-98B5-11CF-BB82-00AA00BDCE0B}"
    put_timeout(v)
      => ComCall(7, this.p, Int32, v)
    get_timeout(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_ontimeout(v)
      => ComCall(9, this.p, VARIANT, v)
    get_ontimeout(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
}
struct IHTMLXMLHttpRequestFactory extends IDispatch {
    static IID := "{3051040C-98B5-11CF-BB82-00AA00BDCE0B}"
    create(__MIDL__IHTMLXMLHttpRequestFactory0000)
      => ComCall(7, this.p, IHTMLXMLHttpRequest.Ptr, __MIDL__IHTMLXMLHttpRequestFactory0000)
}
struct DispHTMLXMLHttpRequest extends IDispatch {
    static IID := "{3050F596-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGAngle extends IDispatch {
    static IID := "{305104D3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_unitType(v)
      => ComCall(7, this.p, Int16, v)
    get_unitType(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, Float32, v)
    get_value(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_valueInSpecifiedUnits(v)
      => ComCall(11, this.p, Float32, v)
    get_valueInSpecifiedUnits(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_valueAsString(v)
      => ComCall(13, this.p, BSTR, v)
    get_valueAsString(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    newValueSpecifiedUnits(unitType, valueInSpecifiedUnits)
      => ComCall(15, this.p, Int16, unitType, Float32, valueInSpecifiedUnits)
    convertToSpecifiedUnits(unitType)
      => ComCall(16, this.p, Int16, unitType)
}
struct ISVGElement extends IDispatch {
    static IID := "{305104C5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_xmlbase(v)
      => ComCall(7, this.p, BSTR, v)
    get_xmlbase(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    putref_ownerSVGElement(v)
      => ComCall(9, this.p, ISVGSVGElement, v)
    get_ownerSVGElement(p)
      => ComCall(10, this.p, ISVGSVGElement.Ptr, p)
    putref_viewportElement(v)
      => ComCall(11, this.p, ISVGElement, v)
    get_viewportElement(p)
      => ComCall(12, this.p, ISVGElement.Ptr, p)
    putref_focusable(v)
      => ComCall(13, this.p, ISVGAnimatedEnumeration, v)
    get_focusable(p)
      => ComCall(14, this.p, ISVGAnimatedEnumeration.Ptr, p)
}
struct ISVGRect extends IDispatch {
    static IID := "{305104D7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_width(v)
      => ComCall(11, this.p, Float32, v)
    get_width(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_height(v)
      => ComCall(13, this.p, Float32, v)
    get_height(p)
      => ComCall(14, this.p, Float32.Ptr, p)
}
struct ISVGMatrix extends IDispatch {
    static IID := "{305104F6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_a(v)
      => ComCall(7, this.p, Float32, v)
    get_a(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_b(v)
      => ComCall(9, this.p, Float32, v)
    get_b(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_c(v)
      => ComCall(11, this.p, Float32, v)
    get_c(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_d(v)
      => ComCall(13, this.p, Float32, v)
    get_d(p)
      => ComCall(14, this.p, Float32.Ptr, p)
    put_e(v)
      => ComCall(15, this.p, Float32, v)
    get_e(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_f(v)
      => ComCall(17, this.p, Float32, v)
    get_f(p)
      => ComCall(18, this.p, Float32.Ptr, p)
    multiply(secondMatrix, ppResult)
      => ComCall(19, this.p, ISVGMatrix, secondMatrix, ISVGMatrix.Ptr, ppResult)
    inverse(ppResult)
      => ComCall(20, this.p, ISVGMatrix.Ptr, ppResult)
    translate(x, y, ppResult)
      => ComCall(21, this.p, Float32, x, Float32, y, ISVGMatrix.Ptr, ppResult)
    scale(scaleFactor, ppResult)
      => ComCall(22, this.p, Float32, scaleFactor, ISVGMatrix.Ptr, ppResult)
    scaleNonUniform(scaleFactorX, scaleFactorY, ppResult)
      => ComCall(23, this.p, Float32, scaleFactorX, Float32, scaleFactorY, ISVGMatrix.Ptr, ppResult)
    rotate(angle, ppResult)
      => ComCall(24, this.p, Float32, angle, ISVGMatrix.Ptr, ppResult)
    rotateFromVector(x, y, ppResult)
      => ComCall(25, this.p, Float32, x, Float32, y, ISVGMatrix.Ptr, ppResult)
    flipX(ppResult)
      => ComCall(26, this.p, ISVGMatrix.Ptr, ppResult)
    flipY(ppResult)
      => ComCall(27, this.p, ISVGMatrix.Ptr, ppResult)
    skewX(angle, ppResult)
      => ComCall(28, this.p, Float32, angle, ISVGMatrix.Ptr, ppResult)
    skewY(angle, ppResult)
      => ComCall(29, this.p, Float32, angle, ISVGMatrix.Ptr, ppResult)
}
struct ISVGStringList extends IDispatch {
    static IID := "{305104C8-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(newItem, ppResult)
      => ComCall(10, this.p, BSTR, newItem, BSTR.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, BSTR.Ptr, ppResult)
    insertItemBefore(newItem, index, ppResult)
      => ComCall(12, this.p, BSTR, newItem, Int32, index, BSTR.Ptr, ppResult)
    replaceItem(newItem, index, ppResult)
      => ComCall(13, this.p, BSTR, newItem, Int32, index, BSTR.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, BSTR.Ptr, ppResult)
    appendItem(newItem, ppResult)
      => ComCall(15, this.p, BSTR, newItem, BSTR.Ptr, ppResult)
}
struct ISVGAnimatedRect extends IDispatch {
    static IID := "{305104D8-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGRect, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGRect.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGRect, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGRect.Ptr, p)
}
struct ISVGAnimatedString extends IDispatch {
    static IID := "{305104C7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_baseVal(v)
      => ComCall(7, this.p, BSTR, v)
    get_baseVal(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_animVal(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct ISVGAnimatedBoolean extends IDispatch {
    static IID := "{305104C6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_baseVal(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_baseVal(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_animVal(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_animVal(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct ISVGAnimatedTransformList extends IDispatch {
    static IID := "{305104F9-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGTransformList, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGTransformList.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGTransformList, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGTransformList.Ptr, p)
}
struct ISVGAnimatedPreserveAspectRatio extends IDispatch {
    static IID := "{305104FB-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGPreserveAspectRatio, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGPreserveAspectRatio.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGPreserveAspectRatio, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGPreserveAspectRatio.Ptr, p)
}
struct ISVGStylable extends IDispatch {
    static IID := "{305104DA-98B5-11CF-BB82-00AA00BDCE0B}"
    get_className(p)
      => ComCall(7, this.p, ISVGAnimatedString.Ptr, p)
}
struct ISVGLocatable extends IDispatch {
    static IID := "{305104DB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_nearestViewportElement(p)
      => ComCall(7, this.p, ISVGElement.Ptr, p)
    get_farthestViewportElement(p)
      => ComCall(8, this.p, ISVGElement.Ptr, p)
    getBBox(ppResult)
      => ComCall(9, this.p, ISVGRect.Ptr, ppResult)
    getCTM(ppResult)
      => ComCall(10, this.p, ISVGMatrix.Ptr, ppResult)
    getScreenCTM(ppResult)
      => ComCall(11, this.p, ISVGMatrix.Ptr, ppResult)
    getTransformToElement(pElement, ppResult)
      => ComCall(12, this.p, ISVGElement, pElement, ISVGMatrix.Ptr, ppResult)
}
struct ISVGTransformable extends IDispatch {
    static IID := "{305104DC-98B5-11CF-BB82-00AA00BDCE0B}"
    get_transform(p)
      => ComCall(7, this.p, ISVGAnimatedTransformList.Ptr, p)
}
struct ISVGTests extends IDispatch {
    static IID := "{305104DD-98B5-11CF-BB82-00AA00BDCE0B}"
    get_requiredFeatures(p)
      => ComCall(7, this.p, ISVGStringList.Ptr, p)
    get_requiredExtensions(p)
      => ComCall(8, this.p, ISVGStringList.Ptr, p)
    get_systemLanguage(p)
      => ComCall(9, this.p, ISVGStringList.Ptr, p)
    hasExtension(extension, pResult)
      => ComCall(10, this.p, BSTR, extension, VARIANT_BOOL.Ptr, pResult)
}
struct ISVGLangSpace extends IDispatch {
    static IID := "{305104DE-98B5-11CF-BB82-00AA00BDCE0B}"
    put_xmllang(v)
      => ComCall(7, this.p, BSTR, v)
    get_xmllang(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_xmlspace(v)
      => ComCall(9, this.p, BSTR, v)
    get_xmlspace(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct ISVGExternalResourcesRequired extends IDispatch {
    static IID := "{305104DF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_externalResourcesRequired(p)
      => ComCall(7, this.p, ISVGAnimatedBoolean.Ptr, p)
}
struct ISVGFitToViewBox extends IDispatch {
    static IID := "{305104E0-98B5-11CF-BB82-00AA00BDCE0B}"
    get_viewBox(p)
      => ComCall(7, this.p, ISVGAnimatedRect.Ptr, p)
    putref_preserveAspectRatio(v)
      => ComCall(8, this.p, ISVGAnimatedPreserveAspectRatio, v)
    get_preserveAspectRatio(p)
      => ComCall(9, this.p, ISVGAnimatedPreserveAspectRatio.Ptr, p)
}
struct ISVGZoomAndPan extends IDispatch {
    static IID := "{305104E1-98B5-11CF-BB82-00AA00BDCE0B}"
    get_zoomAndPan(p)
      => ComCall(7, this.p, Int16.Ptr, p)
}
struct ISVGURIReference extends IDispatch {
    static IID := "{305104E3-98B5-11CF-BB82-00AA00BDCE0B}"
    get_href(p)
      => ComCall(7, this.p, ISVGAnimatedString.Ptr, p)
}
struct ISVGAnimatedAngle extends IDispatch {
    static IID := "{305104D4-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGAngle, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGAngle.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGAngle, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGAngle.Ptr, p)
}
struct ISVGTransformList extends IDispatch {
    static IID := "{305104F8-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(newItem, ppResult)
      => ComCall(10, this.p, ISVGTransform, newItem, ISVGTransform.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, ISVGTransform.Ptr, ppResult)
    insertItemBefore(newItem, index, ppResult)
      => ComCall(12, this.p, ISVGTransform, newItem, Int32, index, ISVGTransform.Ptr, ppResult)
    replaceItem(newItem, index, ppResult)
      => ComCall(13, this.p, ISVGTransform, newItem, Int32, index, ISVGTransform.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, ISVGTransform.Ptr, ppResult)
    appendItem(newItem, ppResult)
      => ComCall(15, this.p, ISVGTransform, newItem, ISVGTransform.Ptr, ppResult)
    createSVGTransformFromMatrix(newItem, ppResult)
      => ComCall(16, this.p, ISVGMatrix, newItem, ISVGTransform.Ptr, ppResult)
    consolidate(ppResult)
      => ComCall(17, this.p, ISVGTransform.Ptr, ppResult)
}
struct ISVGAnimatedEnumeration extends IDispatch {
    static IID := "{305104C9-98B5-11CF-BB82-00AA00BDCE0B}"
    put_baseVal(v)
      => ComCall(7, this.p, UInt16, v)
    get_baseVal(p)
      => ComCall(8, this.p, UInt16.Ptr, p)
    put_animVal(v)
      => ComCall(9, this.p, UInt16, v)
    get_animVal(p)
      => ComCall(10, this.p, UInt16.Ptr, p)
}
struct ISVGAnimatedInteger extends IDispatch {
    static IID := "{305104CA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_baseVal(v)
      => ComCall(7, this.p, Int32, v)
    get_baseVal(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_animVal(v)
      => ComCall(9, this.p, Int32, v)
    get_animVal(p)
      => ComCall(10, this.p, Int32.Ptr, p)
}
struct ISVGLength extends IDispatch {
    static IID := "{305104CF-98B5-11CF-BB82-00AA00BDCE0B}"
    put_unitType(v)
      => ComCall(7, this.p, Int16, v)
    get_unitType(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    put_value(v)
      => ComCall(9, this.p, Float32, v)
    get_value(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_valueInSpecifiedUnits(v)
      => ComCall(11, this.p, Float32, v)
    get_valueInSpecifiedUnits(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_valueAsString(v)
      => ComCall(13, this.p, BSTR, v)
    get_valueAsString(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    newValueSpecifiedUnits(unitType, valueInSpecifiedUnits)
      => ComCall(15, this.p, Int16, unitType, Float32, valueInSpecifiedUnits)
    convertToSpecifiedUnits(unitType)
      => ComCall(16, this.p, Int16, unitType)
}
struct ISVGAnimatedLength extends IDispatch {
    static IID := "{305104D0-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGLength, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGLength.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGLength, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGLength.Ptr, p)
}
struct ISVGLengthList extends IDispatch {
    static IID := "{305104D1-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(newItem, ppResult)
      => ComCall(10, this.p, ISVGLength, newItem, ISVGLength.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, ISVGLength.Ptr, ppResult)
    insertItemBefore(newItem, index, ppResult)
      => ComCall(12, this.p, ISVGLength, newItem, Int32, index, ISVGLength.Ptr, ppResult)
    replaceItem(newItem, index, ppResult)
      => ComCall(13, this.p, ISVGLength, newItem, Int32, index, ISVGLength.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, ISVGLength.Ptr, ppResult)
    appendItem(newItem, ppResult)
      => ComCall(15, this.p, ISVGLength, newItem, ISVGLength.Ptr, ppResult)
}
struct ISVGAnimatedLengthList extends IDispatch {
    static IID := "{305104D2-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGLengthList, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGLengthList.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGLengthList, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGLengthList.Ptr, p)
}
struct ISVGNumber extends IDispatch {
    static IID := "{305104CB-98B5-11CF-BB82-00AA00BDCE0B}"
    put_value(v)
      => ComCall(7, this.p, Float32, v)
    get_value(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct ISVGAnimatedNumber extends IDispatch {
    static IID := "{305104CC-98B5-11CF-BB82-00AA00BDCE0B}"
    put_baseVal(v)
      => ComCall(7, this.p, Float32, v)
    get_baseVal(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_animVal(v)
      => ComCall(9, this.p, Float32, v)
    get_animVal(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGNumberList extends IDispatch {
    static IID := "{305104CD-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(newItem, ppResult)
      => ComCall(10, this.p, ISVGNumber, newItem, ISVGNumber.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, ISVGNumber.Ptr, ppResult)
    insertItemBefore(newItem, index, ppResult)
      => ComCall(12, this.p, ISVGNumber, newItem, Int32, index, ISVGNumber.Ptr, ppResult)
    replaceItem(newItem, index, ppResult)
      => ComCall(13, this.p, ISVGNumber, newItem, Int32, index, ISVGNumber.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, ISVGNumber.Ptr, ppResult)
    appendItem(newItem, ppResult)
      => ComCall(15, this.p, ISVGNumber, newItem, ISVGNumber.Ptr, ppResult)
}
struct ISVGAnimatedNumberList extends IDispatch {
    static IID := "{305104CE-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_baseVal(v)
      => ComCall(7, this.p, ISVGNumberList, v)
    get_baseVal(p)
      => ComCall(8, this.p, ISVGNumberList.Ptr, p)
    putref_animVal(v)
      => ComCall(9, this.p, ISVGNumberList, v)
    get_animVal(p)
      => ComCall(10, this.p, ISVGNumberList.Ptr, p)
}
struct ISVGClipPathElement extends IDispatch {
    static IID := "{3051052D-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_clipPathUnits(v)
      => ComCall(7, this.p, ISVGAnimatedEnumeration, v)
    get_clipPathUnits(p)
      => ComCall(8, this.p, ISVGAnimatedEnumeration.Ptr, p)
}
struct DispSVGClipPathElement extends IDispatch {
    static IID := "{3059003B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGDocument extends IDispatch {
    static IID := "{305104E6-98B5-11CF-BB82-00AA00BDCE0B}"
    get_rootElement(p)
      => ComCall(7, this.p, ISVGSVGElement.Ptr, p)
}
struct IGetSVGDocument extends IDispatch {
    static IID := "{305105AB-98B5-11CF-BB82-00AA00BDCE0B}"
    getSVGDocument(ppSVGDocument)
      => ComCall(7, this.p, IDispatch.Ptr, ppSVGDocument)
}
struct DispSVGElement extends IDispatch {
    static IID := "{30590000-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IICCSVGColor extends IDispatch {
    static IID := "{305104D6-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPaint extends IDispatch {
    static IID := "{30510524-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPatternElement extends IDispatch {
    static IID := "{3051052C-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_patternUnits(v)
      => ComCall(7, this.p, ISVGAnimatedEnumeration, v)
    get_patternUnits(p)
      => ComCall(8, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_patternContentUnits(v)
      => ComCall(9, this.p, ISVGAnimatedEnumeration, v)
    get_patternContentUnits(p)
      => ComCall(10, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_patternTransform(v)
      => ComCall(11, this.p, ISVGAnimatedTransformList, v)
    get_patternTransform(p)
      => ComCall(12, this.p, ISVGAnimatedTransformList.Ptr, p)
    putref_x(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(15, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(16, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(17, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(18, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(19, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(20, this.p, ISVGAnimatedLength.Ptr, p)
}
struct DispSVGPatternElement extends IDispatch {
    static IID := "{3059002C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPathSeg extends IDispatch {
    static IID := "{305104FC-98B5-11CF-BB82-00AA00BDCE0B}"
    put_pathSegType(v)
      => ComCall(7, this.p, Int16, v)
    get_pathSegType(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    get_pathSegTypeAsLetter(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct ISVGPathSegArcAbs extends IDispatch {
    static IID := "{30510506-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_r1(v)
      => ComCall(11, this.p, Float32, v)
    get_r1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_r2(v)
      => ComCall(13, this.p, Float32, v)
    get_r2(p)
      => ComCall(14, this.p, Float32.Ptr, p)
    put_angle(v)
      => ComCall(15, this.p, Float32, v)
    get_angle(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_largeArcFlag(v)
      => ComCall(17, this.p, VARIANT_BOOL, v)
    get_largeArcFlag(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    put_sweepFlag(v)
      => ComCall(19, this.p, VARIANT_BOOL, v)
    get_sweepFlag(p)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, p)
}
struct ISVGPathSegArcRel extends IDispatch {
    static IID := "{30510507-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_r1(v)
      => ComCall(11, this.p, Float32, v)
    get_r1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_r2(v)
      => ComCall(13, this.p, Float32, v)
    get_r2(p)
      => ComCall(14, this.p, Float32.Ptr, p)
    put_angle(v)
      => ComCall(15, this.p, Float32, v)
    get_angle(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_largeArcFlag(v)
      => ComCall(17, this.p, VARIANT_BOOL, v)
    get_largeArcFlag(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    put_sweepFlag(v)
      => ComCall(19, this.p, VARIANT_BOOL, v)
    get_sweepFlag(p)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, p)
}
struct ISVGPathSegClosePath extends IDispatch {
    static IID := "{305104FD-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPathSegMovetoAbs extends IDispatch {
    static IID := "{305104FE-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegMovetoRel extends IDispatch {
    static IID := "{305104FF-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoAbs extends IDispatch {
    static IID := "{30510500-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoRel extends IDispatch {
    static IID := "{30510501-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoCubicAbs extends IDispatch {
    static IID := "{30510502-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x1(v)
      => ComCall(11, this.p, Float32, v)
    get_x1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y1(v)
      => ComCall(13, this.p, Float32, v)
    get_y1(p)
      => ComCall(14, this.p, Float32.Ptr, p)
    put_x2(v)
      => ComCall(15, this.p, Float32, v)
    get_x2(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_y2(v)
      => ComCall(17, this.p, Float32, v)
    get_y2(p)
      => ComCall(18, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoCubicRel extends IDispatch {
    static IID := "{30510503-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x1(v)
      => ComCall(11, this.p, Float32, v)
    get_x1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y1(v)
      => ComCall(13, this.p, Float32, v)
    get_y1(p)
      => ComCall(14, this.p, Float32.Ptr, p)
    put_x2(v)
      => ComCall(15, this.p, Float32, v)
    get_x2(p)
      => ComCall(16, this.p, Float32.Ptr, p)
    put_y2(v)
      => ComCall(17, this.p, Float32, v)
    get_y2(p)
      => ComCall(18, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoCubicSmoothAbs extends IDispatch {
    static IID := "{3051050C-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x2(v)
      => ComCall(11, this.p, Float32, v)
    get_x2(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y2(v)
      => ComCall(13, this.p, Float32, v)
    get_y2(p)
      => ComCall(14, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoCubicSmoothRel extends IDispatch {
    static IID := "{3051050D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x2(v)
      => ComCall(11, this.p, Float32, v)
    get_x2(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y2(v)
      => ComCall(13, this.p, Float32, v)
    get_y2(p)
      => ComCall(14, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoQuadraticAbs extends IDispatch {
    static IID := "{30510504-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x1(v)
      => ComCall(11, this.p, Float32, v)
    get_x1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y1(v)
      => ComCall(13, this.p, Float32, v)
    get_y1(p)
      => ComCall(14, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoQuadraticRel extends IDispatch {
    static IID := "{30510505-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    put_x1(v)
      => ComCall(11, this.p, Float32, v)
    get_x1(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    put_y1(v)
      => ComCall(13, this.p, Float32, v)
    get_y1(p)
      => ComCall(14, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoQuadraticSmoothAbs extends IDispatch {
    static IID := "{3051050E-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegCurvetoQuadraticSmoothRel extends IDispatch {
    static IID := "{3051050F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoHorizontalAbs extends IDispatch {
    static IID := "{30510508-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoHorizontalRel extends IDispatch {
    static IID := "{30510509-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoVerticalAbs extends IDispatch {
    static IID := "{3051050A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_y(v)
      => ComCall(7, this.p, Float32, v)
    get_y(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct ISVGPathSegLinetoVerticalRel extends IDispatch {
    static IID := "{3051050B-98B5-11CF-BB82-00AA00BDCE0B}"
    put_y(v)
      => ComCall(7, this.p, Float32, v)
    get_y(p)
      => ComCall(8, this.p, Float32.Ptr, p)
}
struct DispSVGPathSegArcAbs extends IDispatch {
    static IID := "{30590013-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegArcRel extends IDispatch {
    static IID := "{30590014-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegClosePath extends IDispatch {
    static IID := "{30590015-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegMovetoAbs extends IDispatch {
    static IID := "{30590024-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegMovetoRel extends IDispatch {
    static IID := "{30590025-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoAbs extends IDispatch {
    static IID := "{3059001E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoRel extends IDispatch {
    static IID := "{30590021-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoCubicAbs extends IDispatch {
    static IID := "{30590016-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoCubicRel extends IDispatch {
    static IID := "{30590017-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoCubicSmoothAbs extends IDispatch {
    static IID := "{30590018-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoCubicSmoothRel extends IDispatch {
    static IID := "{30590019-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoQuadraticAbs extends IDispatch {
    static IID := "{3059001A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoQuadraticRel extends IDispatch {
    static IID := "{3059001B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoQuadraticSmoothAbs extends IDispatch {
    static IID := "{3059001C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegCurvetoQuadraticSmoothRel extends IDispatch {
    static IID := "{3059001D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoHorizontalAbs extends IDispatch {
    static IID := "{3059001F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoHorizontalRel extends IDispatch {
    static IID := "{30590020-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoVerticalAbs extends IDispatch {
    static IID := "{30590022-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPathSegLinetoVerticalRel extends IDispatch {
    static IID := "{30590023-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPathSegList extends IDispatch {
    static IID := "{30510510-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(newItem, ppResult)
      => ComCall(10, this.p, ISVGPathSeg, newItem, ISVGPathSeg.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, ISVGPathSeg.Ptr, ppResult)
    insertItemBefore(newItem, index, ppResult)
      => ComCall(12, this.p, ISVGPathSeg, newItem, Int32, index, ISVGPathSeg.Ptr, ppResult)
    replaceItem(newItem, index, ppResult)
      => ComCall(13, this.p, ISVGPathSeg, newItem, Int32, index, ISVGPathSeg.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, ISVGPathSeg.Ptr, ppResult)
    appendItem(newItem, ppResult)
      => ComCall(15, this.p, ISVGPathSeg, newItem, ISVGPathSeg.Ptr, ppResult)
}
struct ISVGPoint extends IDispatch {
    static IID := "{305104F4-98B5-11CF-BB82-00AA00BDCE0B}"
    put_x(v)
      => ComCall(7, this.p, Float32, v)
    get_x(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_y(v)
      => ComCall(9, this.p, Float32, v)
    get_y(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    matrixTransform(pMatrix, ppResult)
      => ComCall(11, this.p, ISVGMatrix, pMatrix, ISVGPoint.Ptr, ppResult)
}
struct ISVGPointList extends IDispatch {
    static IID := "{305104F5-98B5-11CF-BB82-00AA00BDCE0B}"
    put_numberOfItems(v)
      => ComCall(7, this.p, Int32, v)
    get_numberOfItems(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    clear()
      => ComCall(9, this.p)
    initialize(pNewItem, ppResult)
      => ComCall(10, this.p, ISVGPoint, pNewItem, ISVGPoint.Ptr, ppResult)
    getItem(index, ppResult)
      => ComCall(11, this.p, Int32, index, ISVGPoint.Ptr, ppResult)
    insertItemBefore(pNewItem, index, ppResult)
      => ComCall(12, this.p, ISVGPoint, pNewItem, Int32, index, ISVGPoint.Ptr, ppResult)
    replaceItem(pNewItem, index, ppResult)
      => ComCall(13, this.p, ISVGPoint, pNewItem, Int32, index, ISVGPoint.Ptr, ppResult)
    removeItem(index, ppResult)
      => ComCall(14, this.p, Int32, index, ISVGPoint.Ptr, ppResult)
    appendItem(pNewItem, ppResult)
      => ComCall(15, this.p, ISVGPoint, pNewItem, ISVGPoint.Ptr, ppResult)
}
struct ISVGViewSpec extends IDispatch {
    static IID := "{305104E2-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTransform extends IDispatch {
    static IID := "{305104F7-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, Int16, v)
    get_type(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    putref_matrix(v)
      => ComCall(9, this.p, ISVGMatrix, v)
    get_matrix(p)
      => ComCall(10, this.p, ISVGMatrix.Ptr, p)
    put_angle(v)
      => ComCall(11, this.p, Float32, v)
    get_angle(p)
      => ComCall(12, this.p, Float32.Ptr, p)
    setMatrix(matrix)
      => ComCall(13, this.p, ISVGMatrix, matrix)
    setTranslate(tx, ty)
      => ComCall(14, this.p, Float32, tx, Float32, ty)
    setScale(sx, sy)
      => ComCall(15, this.p, Float32, sx, Float32, sy)
    setRotate(angle, cx, cy)
      => ComCall(16, this.p, Float32, angle, Float32, cx, Float32, cy)
    setSkewX(angle)
      => ComCall(17, this.p, Float32, angle)
    setSkewY(angle)
      => ComCall(18, this.p, Float32, angle)
}
struct DispSVGSVGElement extends IDispatch {
    static IID := "{30590001-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGElementInstance extends IDispatch {
    static IID := "{305104EE-98B5-11CF-BB82-00AA00BDCE0B}"
    get_correspondingElement(p)
      => ComCall(7, this.p, ISVGElement.Ptr, p)
    get_correspondingUseElement(p)
      => ComCall(8, this.p, ISVGUseElement.Ptr, p)
    get_parentNode(p)
      => ComCall(9, this.p, ISVGElementInstance.Ptr, p)
    get_childNodes(p)
      => ComCall(10, this.p, ISVGElementInstanceList.Ptr, p)
    get_firstChild(p)
      => ComCall(11, this.p, ISVGElementInstance.Ptr, p)
    get_lastChild(p)
      => ComCall(12, this.p, ISVGElementInstance.Ptr, p)
    get_previousSibling(p)
      => ComCall(13, this.p, ISVGElementInstance.Ptr, p)
    get_nextSibling(p)
      => ComCall(14, this.p, ISVGElementInstance.Ptr, p)
}
struct ISVGUseElement extends IDispatch {
    static IID := "{305104ED-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_instanceRoot(v)
      => ComCall(15, this.p, ISVGElementInstance, v)
    get_instanceRoot(p)
      => ComCall(16, this.p, ISVGElementInstance.Ptr, p)
    putref_animatedInstanceRoot(v)
      => ComCall(17, this.p, ISVGElementInstance, v)
    get_animatedInstanceRoot(p)
      => ComCall(18, this.p, ISVGElementInstance.Ptr, p)
}
struct DispSVGUseElement extends IDispatch {
    static IID := "{30590010-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLStyleSheetRulesAppliedCollection extends IDispatch {
    static IID := "{305104C0-98B5-11CF-BB82-00AA00BDCE0B}"
    item(index, ppHTMLStyleSheetRule)
      => ComCall(7, this.p, Int32, index, IHTMLStyleSheetRule.Ptr, ppHTMLStyleSheetRule)
    get_length(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    propertyAppliedBy(name, ppRule)
      => ComCall(9, this.p, BSTR, name, IHTMLStyleSheetRule.Ptr, ppRule)
    propertyAppliedTrace(name, index, ppRule)
      => ComCall(10, this.p, BSTR, name, Int32, index, IHTMLStyleSheetRule.Ptr, ppRule)
    propertyAppliedTraceLength(name, pLength)
      => ComCall(11, this.p, BSTR, name, Int32.Ptr, pLength)
}
struct IRulesApplied extends IDispatch {
    static IID := "{305104BF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_element(p)
      => ComCall(7, this.p, IHTMLElement.Ptr, p)
    get_inlineStyles(p)
      => ComCall(8, this.p, IHTMLStyle.Ptr, p)
    get_appliedRules(p)
      => ComCall(9, this.p, IHTMLStyleSheetRulesAppliedCollection.Ptr, p)
    propertyIsInline(name, p)
      => ComCall(10, this.p, BSTR, name, VARIANT_BOOL.Ptr, p)
    propertyIsInheritable(name, p)
      => ComCall(11, this.p, BSTR, name, VARIANT_BOOL.Ptr, p)
    hasInheritableProperty(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLStyleSheetRulesAppliedCollection extends IDispatch {
    static IID := "{3050F5A6-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispRulesApplied extends IDispatch {
    static IID := "{3050F5A5-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispRulesAppliedCollection extends IDispatch {
    static IID := "{3050F5A4-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLW3CComputedStyle extends IDispatch {
    static IID := "{30590070-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGAnimatedPoints extends IDispatch {
    static IID := "{30510517-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_points(v)
      => ComCall(7, this.p, ISVGPointList, v)
    get_points(p)
      => ComCall(8, this.p, ISVGPointList.Ptr, p)
    putref_animatedPoints(v)
      => ComCall(9, this.p, ISVGPointList, v)
    get_animatedPoints(p)
      => ComCall(10, this.p, ISVGPointList.Ptr, p)
}
struct ISVGCircleElement extends IDispatch {
    static IID := "{30510514-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_cx(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_cx(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_cy(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_cy(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_r(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_r(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
}
struct ISVGEllipseElement extends IDispatch {
    static IID := "{30510515-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_cx(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_cx(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_cy(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_cy(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_rx(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_rx(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_ry(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_ry(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
}
struct ISVGLineElement extends IDispatch {
    static IID := "{30510516-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x1(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x1(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y1(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y1(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_x2(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_x2(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y2(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_y2(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
}
struct ISVGRectElement extends IDispatch {
    static IID := "{30510513-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_rx(v)
      => ComCall(15, this.p, ISVGAnimatedLength, v)
    get_rx(p)
      => ComCall(16, this.p, ISVGAnimatedLength.Ptr, p)
    putref_ry(v)
      => ComCall(17, this.p, ISVGAnimatedLength, v)
    get_ry(p)
      => ComCall(18, this.p, ISVGAnimatedLength.Ptr, p)
}
struct ISVGPolygonElement extends IDispatch {
    static IID := "{30510519-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPolylineElement extends IDispatch {
    static IID := "{30510518-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGCircleElement extends IDispatch {
    static IID := "{3059000A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGEllipseElement extends IDispatch {
    static IID := "{3059000B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGLineElement extends IDispatch {
    static IID := "{3059000C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGRectElement extends IDispatch {
    static IID := "{30590009-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPolygonElement extends IDispatch {
    static IID := "{3059000D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGPolylineElement extends IDispatch {
    static IID := "{3059000E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGGElement extends IDispatch {
    static IID := "{305104E8-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGGElement extends IDispatch {
    static IID := "{30590002-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGSymbolElement extends IDispatch {
    static IID := "{305104EC-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGSymbolElement extends IDispatch {
    static IID := "{30590004-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGDefsElement extends IDispatch {
    static IID := "{305104E9-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGDefsElement extends IDispatch {
    static IID := "{30590003-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGAnimatedPathData extends IDispatch {
    static IID := "{30510511-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_pathSegList(v)
      => ComCall(7, this.p, ISVGPathSegList, v)
    get_pathSegList(p)
      => ComCall(8, this.p, ISVGPathSegList.Ptr, p)
    putref_normalizedPathSegList(v)
      => ComCall(9, this.p, ISVGPathSegList, v)
    get_normalizedPathSegList(p)
      => ComCall(10, this.p, ISVGPathSegList.Ptr, p)
    putref_animatedPathSegList(v)
      => ComCall(11, this.p, ISVGPathSegList, v)
    get_animatedPathSegList(p)
      => ComCall(12, this.p, ISVGPathSegList.Ptr, p)
    putref_animatedNormalizedPathSegList(v)
      => ComCall(13, this.p, ISVGPathSegList, v)
    get_animatedNormalizedPathSegList(p)
      => ComCall(14, this.p, ISVGPathSegList.Ptr, p)
}
struct ISVGPathElement extends IDispatch {
    static IID := "{30510512-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_pathLength(v)
      => ComCall(7, this.p, ISVGAnimatedNumber, v)
    get_pathLength(p)
      => ComCall(8, this.p, ISVGAnimatedNumber.Ptr, p)
    getTotalLength(pfltResult)
      => ComCall(9, this.p, Float32.Ptr, pfltResult)
    getPointAtLength(fltdistance, ppPointResult)
      => ComCall(10, this.p, Float32, fltdistance, ISVGPoint.Ptr, ppPointResult)
    getPathSegAtLength(fltdistance, plResult)
      => ComCall(11, this.p, Float32, fltdistance, Int32.Ptr, plResult)
    createSVGPathSegClosePath(ppResult)
      => ComCall(12, this.p, ISVGPathSegClosePath.Ptr, ppResult)
    createSVGPathSegMovetoAbs(x, y, ppResult)
      => ComCall(13, this.p, Float32, x, Float32, y, ISVGPathSegMovetoAbs.Ptr, ppResult)
    createSVGPathSegMovetoRel(x, y, ppResult)
      => ComCall(14, this.p, Float32, x, Float32, y, ISVGPathSegMovetoRel.Ptr, ppResult)
    createSVGPathSegLinetoAbs(x, y, ppResult)
      => ComCall(15, this.p, Float32, x, Float32, y, ISVGPathSegLinetoAbs.Ptr, ppResult)
    createSVGPathSegLinetoRel(x, y, ppResult)
      => ComCall(16, this.p, Float32, x, Float32, y, ISVGPathSegLinetoRel.Ptr, ppResult)
    createSVGPathSegCurvetoCubicAbs(x, y, x1, y1, x2, y2, ppResult)
      => ComCall(17, this.p, Float32, x, Float32, y, Float32, x1, Float32, y1, Float32, x2, Float32, y2, ISVGPathSegCurvetoCubicAbs.Ptr, ppResult)
    createSVGPathSegCurvetoCubicRel(x, y, x1, y1, x2, y2, ppResult)
      => ComCall(18, this.p, Float32, x, Float32, y, Float32, x1, Float32, y1, Float32, x2, Float32, y2, ISVGPathSegCurvetoCubicRel.Ptr, ppResult)
    createSVGPathSegCurvetoQuadraticAbs(x, y, x1, y1, ppResult)
      => ComCall(19, this.p, Float32, x, Float32, y, Float32, x1, Float32, y1, ISVGPathSegCurvetoQuadraticAbs.Ptr, ppResult)
    createSVGPathSegCurvetoQuadraticRel(x, y, x1, y1, ppResult)
      => ComCall(20, this.p, Float32, x, Float32, y, Float32, x1, Float32, y1, ISVGPathSegCurvetoQuadraticRel.Ptr, ppResult)
    createSVGPathSegArcAbs(x, y, r1, r2, angle, largeArcFlag, sweepFlag, ppResult)
      => ComCall(21, this.p, Float32, x, Float32, y, Float32, r1, Float32, r2, Float32, angle, VARIANT_BOOL, largeArcFlag, VARIANT_BOOL, sweepFlag, ISVGPathSegArcAbs.Ptr, ppResult)
    createSVGPathSegArcRel(x, y, r1, r2, angle, largeArcFlag, sweepFlag, ppResult)
      => ComCall(22, this.p, Float32, x, Float32, y, Float32, r1, Float32, r2, Float32, angle, VARIANT_BOOL, largeArcFlag, VARIANT_BOOL, sweepFlag, ISVGPathSegArcRel.Ptr, ppResult)
    createSVGPathSegLinetoHorizontalAbs(x, ppResult)
      => ComCall(23, this.p, Float32, x, ISVGPathSegLinetoHorizontalAbs.Ptr, ppResult)
    createSVGPathSegLinetoHorizontalRel(x, ppResult)
      => ComCall(24, this.p, Float32, x, ISVGPathSegLinetoHorizontalRel.Ptr, ppResult)
    createSVGPathSegLinetoVerticalAbs(y, ppResult)
      => ComCall(25, this.p, Float32, y, ISVGPathSegLinetoVerticalAbs.Ptr, ppResult)
    createSVGPathSegLinetoVerticalRel(y, ppResult)
      => ComCall(26, this.p, Float32, y, ISVGPathSegLinetoVerticalRel.Ptr, ppResult)
    createSVGPathSegCurvetoCubicSmoothAbs(x, y, x2, y2, ppResult)
      => ComCall(27, this.p, Float32, x, Float32, y, Float32, x2, Float32, y2, ISVGPathSegCurvetoCubicSmoothAbs.Ptr, ppResult)
    createSVGPathSegCurvetoCubicSmoothRel(x, y, x2, y2, ppResult)
      => ComCall(28, this.p, Float32, x, Float32, y, Float32, x2, Float32, y2, ISVGPathSegCurvetoCubicSmoothRel.Ptr, ppResult)
    createSVGPathSegCurvetoQuadraticSmoothAbs(x, y, ppResult)
      => ComCall(29, this.p, Float32, x, Float32, y, ISVGPathSegCurvetoQuadraticSmoothAbs.Ptr, ppResult)
    createSVGPathSegCurvetoQuadraticSmoothRel(x, y, ppResult)
      => ComCall(30, this.p, Float32, x, Float32, y, ISVGPathSegCurvetoQuadraticSmoothRel.Ptr, ppResult)
}
struct DispSVGPathElement extends IDispatch {
    static IID := "{30590011-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGPreserveAspectRatio extends IDispatch {
    static IID := "{305104FA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_align(v)
      => ComCall(7, this.p, Int16, v)
    get_align(p)
      => ComCall(8, this.p, Int16.Ptr, p)
    put_meetOrSlice(v)
      => ComCall(9, this.p, Int16, v)
    get_meetOrSlice(p)
      => ComCall(10, this.p, Int16.Ptr, p)
}
struct ISVGTextElement extends IDispatch {
    static IID := "{3051051C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGTextElement extends IDispatch {
    static IID := "{30590037-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGImageElement extends IDispatch {
    static IID := "{305104F0-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
}
struct DispSVGImageElement extends IDispatch {
    static IID := "{30590027-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGStopElement extends IDispatch {
    static IID := "{3051052B-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_offset(v)
      => ComCall(7, this.p, ISVGAnimatedNumber, v)
    get_offset(p)
      => ComCall(8, this.p, ISVGAnimatedNumber.Ptr, p)
}
struct DispSVGStopElement extends IDispatch {
    static IID := "{3059002D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGGradientElement extends IDispatch {
    static IID := "{30510528-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_gradientUnits(v)
      => ComCall(7, this.p, ISVGAnimatedEnumeration, v)
    get_gradientUnits(p)
      => ComCall(8, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_gradientTransform(v)
      => ComCall(9, this.p, ISVGAnimatedTransformList, v)
    get_gradientTransform(p)
      => ComCall(10, this.p, ISVGAnimatedTransformList.Ptr, p)
    putref_spreadMethod(v)
      => ComCall(11, this.p, ISVGAnimatedEnumeration, v)
    get_spreadMethod(p)
      => ComCall(12, this.p, ISVGAnimatedEnumeration.Ptr, p)
}
struct DispSVGGradientElement extends IDispatch {
    static IID := "{3059002E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGLinearGradientElement extends IDispatch {
    static IID := "{30510529-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x1(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_x1(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y1(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_y1(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_x2(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_x2(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y2(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_y2(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
}
struct DispSVGLinearGradientElement extends IDispatch {
    static IID := "{3059002A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGRadialGradientElement extends IDispatch {
    static IID := "{3051052A-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_cx(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_cx(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_cy(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_cy(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_r(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_r(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_fx(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_fx(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_fy(v)
      => ComCall(15, this.p, ISVGAnimatedLength, v)
    get_fy(p)
      => ComCall(16, this.p, ISVGAnimatedLength.Ptr, p)
}
struct DispSVGRadialGradientElement extends IDispatch {
    static IID := "{3059002B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGMaskElement extends IDispatch {
    static IID := "{3051052E-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_maskUnits(v)
      => ComCall(7, this.p, ISVGAnimatedEnumeration, v)
    get_maskUnits(p)
      => ComCall(8, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_maskContentUnits(v)
      => ComCall(9, this.p, ISVGAnimatedEnumeration, v)
    get_maskContentUnits(p)
      => ComCall(10, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_x(v)
      => ComCall(11, this.p, ISVGAnimatedLength, v)
    get_x(p)
      => ComCall(12, this.p, ISVGAnimatedLength.Ptr, p)
    putref_y(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_y(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_width(v)
      => ComCall(15, this.p, ISVGAnimatedLength, v)
    get_width(p)
      => ComCall(16, this.p, ISVGAnimatedLength.Ptr, p)
    putref_height(v)
      => ComCall(17, this.p, ISVGAnimatedLength, v)
    get_height(p)
      => ComCall(18, this.p, ISVGAnimatedLength.Ptr, p)
}
struct DispSVGMaskElement extends IDispatch {
    static IID := "{3059003C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGMarkerElement extends IDispatch {
    static IID := "{30510525-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_refX(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_refX(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_refY(v)
      => ComCall(9, this.p, ISVGAnimatedLength, v)
    get_refY(p)
      => ComCall(10, this.p, ISVGAnimatedLength.Ptr, p)
    putref_markerUnits(v)
      => ComCall(11, this.p, ISVGAnimatedEnumeration, v)
    get_markerUnits(p)
      => ComCall(12, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_markerWidth(v)
      => ComCall(13, this.p, ISVGAnimatedLength, v)
    get_markerWidth(p)
      => ComCall(14, this.p, ISVGAnimatedLength.Ptr, p)
    putref_markerHeight(v)
      => ComCall(15, this.p, ISVGAnimatedLength, v)
    get_markerHeight(p)
      => ComCall(16, this.p, ISVGAnimatedLength.Ptr, p)
    putref_orientType(v)
      => ComCall(17, this.p, ISVGAnimatedEnumeration, v)
    get_orientType(p)
      => ComCall(18, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_orientAngle(v)
      => ComCall(19, this.p, ISVGAnimatedAngle, v)
    get_orientAngle(p)
      => ComCall(20, this.p, ISVGAnimatedAngle.Ptr, p)
    setOrientToAuto()
      => ComCall(21, this.p)
    setOrientToAngle(pSVGAngle)
      => ComCall(22, this.p, ISVGAngle, pSVGAngle)
}
struct DispSVGMarkerElement extends IDispatch {
    static IID := "{30590036-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGZoomEvent extends IDispatch {
    static IID := "{3051054E-98B5-11CF-BB82-00AA00BDCE0B}"
    get_zoomRectScreen(p)
      => ComCall(7, this.p, ISVGRect.Ptr, p)
    get_previousScale(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    get_previousTranslate(p)
      => ComCall(9, this.p, ISVGPoint.Ptr, p)
    get_newScale(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    get_newTranslate(p)
      => ComCall(11, this.p, ISVGPoint.Ptr, p)
}
struct DispSVGZoomEvent extends IDispatch {
    static IID := "{30590031-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGAElement extends IDispatch {
    static IID := "{3051054B-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_target(v)
      => ComCall(7, this.p, ISVGAnimatedString, v)
    get_target(p)
      => ComCall(8, this.p, ISVGAnimatedString.Ptr, p)
}
struct DispSVGAElement extends IDispatch {
    static IID := "{30590033-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGViewElement extends IDispatch {
    static IID := "{3051054C-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_viewTarget(v)
      => ComCall(7, this.p, ISVGStringList, v)
    get_viewTarget(p)
      => ComCall(8, this.p, ISVGStringList.Ptr, p)
}
struct DispSVGViewElement extends IDispatch {
    static IID := "{30590034-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLMediaError extends IDispatch {
    static IID := "{30510704-98B5-11CF-BB82-00AA00BDCE0B}"
    get_code(p)
      => ComCall(7, this.p, Int16.Ptr, p)
}
struct IHTMLTimeRanges extends IDispatch {
    static IID := "{30510705-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    start(index, startTime)
      => ComCall(8, this.p, Int32, index, Float32.Ptr, startTime)
    end(index, endTime)
      => ComCall(9, this.p, Int32, index, Float32.Ptr, endTime)
}
struct IHTMLTimeRanges2 extends IDispatch {
    static IID := "{3051080B-98B5-11CF-BB82-00AA00BDCE0B}"
    startDouble(index, startTime)
      => ComCall(7, this.p, Int32, index, Float64.Ptr, startTime)
    endDouble(index, endTime)
      => ComCall(8, this.p, Int32, index, Float64.Ptr, endTime)
}
struct IHTMLMediaElement extends IDispatch {
    static IID := "{30510706-98B5-11CF-BB82-00AA00BDCE0B}"
    get_error(p)
      => ComCall(7, this.p, IHTMLMediaError.Ptr, p)
    put_src(v)
      => ComCall(8, this.p, BSTR, v)
    get_src(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_currentSrc(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_networkState(p)
      => ComCall(11, this.p, UInt16.Ptr, p)
    put_preload(v)
      => ComCall(12, this.p, BSTR, v)
    get_preload(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_buffered(p)
      => ComCall(14, this.p, IHTMLTimeRanges.Ptr, p)
    load()
      => ComCall(15, this.p)
    canPlayType(type, canPlay)
      => ComCall(16, this.p, BSTR, type, BSTR.Ptr, canPlay)
    get_seeking(p)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, p)
    put_currentTime(v)
      => ComCall(18, this.p, Float32, v)
    get_currentTime(p)
      => ComCall(19, this.p, Float32.Ptr, p)
    get_initialTime(p)
      => ComCall(20, this.p, Float32.Ptr, p)
    get_duration(p)
      => ComCall(21, this.p, Float32.Ptr, p)
    get_paused(p)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, p)
    put_defaultPlaybackRate(v)
      => ComCall(23, this.p, Float32, v)
    get_defaultPlaybackRate(p)
      => ComCall(24, this.p, Float32.Ptr, p)
    put_playbackRate(v)
      => ComCall(25, this.p, Float32, v)
    get_playbackRate(p)
      => ComCall(26, this.p, Float32.Ptr, p)
    get_played(p)
      => ComCall(27, this.p, IHTMLTimeRanges.Ptr, p)
    get_seekable(p)
      => ComCall(28, this.p, IHTMLTimeRanges.Ptr, p)
    get_ended(p)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, p)
    put_autoplay(v)
      => ComCall(30, this.p, VARIANT_BOOL, v)
    get_autoplay(p)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, p)
    put_loop(v)
      => ComCall(32, this.p, VARIANT_BOOL, v)
    get_loop(p)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, p)
    play()
      => ComCall(34, this.p)
    pause()
      => ComCall(35, this.p)
    put_controls(v)
      => ComCall(36, this.p, VARIANT_BOOL, v)
    get_controls(p)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, p)
    put_volume(v)
      => ComCall(38, this.p, Float32, v)
    get_volume(p)
      => ComCall(39, this.p, Float32.Ptr, p)
    put_muted(v)
      => ComCall(40, this.p, VARIANT_BOOL, v)
    get_muted(p)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, p)
    put_autobuffer(v)
      => ComCall(42, this.p, VARIANT_BOOL, v)
    get_autobuffer(p)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLMediaElement2 extends IDispatch {
    static IID := "{30510809-98B5-11CF-BB82-00AA00BDCE0B}"
    put_currentTimeDouble(v)
      => ComCall(7, this.p, Float64, v)
    get_currentTimeDouble(p)
      => ComCall(8, this.p, Float64.Ptr, p)
    get_initialTimeDouble(p)
      => ComCall(9, this.p, Float64.Ptr, p)
    get_durationDouble(p)
      => ComCall(10, this.p, Float64.Ptr, p)
    put_defaultPlaybackRateDouble(v)
      => ComCall(11, this.p, Float64, v)
    get_defaultPlaybackRateDouble(p)
      => ComCall(12, this.p, Float64.Ptr, p)
    put_playbackRateDouble(v)
      => ComCall(13, this.p, Float64, v)
    get_playbackRateDouble(p)
      => ComCall(14, this.p, Float64.Ptr, p)
    put_volumeDouble(v)
      => ComCall(15, this.p, Float64, v)
    get_volumeDouble(p)
      => ComCall(16, this.p, Float64.Ptr, p)
}
struct IHTMLMSMediaElement extends IDispatch {
    static IID := "{30510792-98B5-11CF-BB82-00AA00BDCE0B}"
    put_msPlayToDisabled(v)
      => ComCall(7, this.p, VARIANT_BOOL, v)
    get_msPlayToDisabled(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    put_msPlayToPrimary(v)
      => ComCall(9, this.p, VARIANT_BOOL, v)
    get_msPlayToPrimary(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct IHTMLSourceElement extends IDispatch {
    static IID := "{30510707-98B5-11CF-BB82-00AA00BDCE0B}"
    put_src(v)
      => ComCall(7, this.p, BSTR, v)
    get_src(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_type(v)
      => ComCall(9, this.p, BSTR, v)
    get_type(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_media(v)
      => ComCall(11, this.p, BSTR, v)
    get_media(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
}
struct IHTMLAudioElement extends IDispatch {
    static IID := "{30510708-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLVideoElement extends IDispatch {
    static IID := "{30510709-98B5-11CF-BB82-00AA00BDCE0B}"
    put_width(v)
      => ComCall(7, this.p, Int32, v)
    get_width(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    put_height(v)
      => ComCall(9, this.p, Int32, v)
    get_height(p)
      => ComCall(10, this.p, Int32.Ptr, p)
    get_videoWidth(p)
      => ComCall(11, this.p, UInt32.Ptr, p)
    get_videoHeight(p)
      => ComCall(12, this.p, UInt32.Ptr, p)
    put_poster(v)
      => ComCall(13, this.p, BSTR, v)
    get_poster(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
}
struct IHTMLAudioElementFactory extends IDispatch {
    static IID := "{305107EB-98B5-11CF-BB82-00AA00BDCE0B}"
    create(src, __MIDL__IHTMLAudioElementFactory0000)
      => ComCall(7, this.p, VARIANT, src, IHTMLAudioElement.Ptr, __MIDL__IHTMLAudioElementFactory0000)
}
struct DispHTMLMediaError extends IDispatch {
    static IID := "{30590086-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLTimeRanges extends IDispatch {
    static IID := "{30590087-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLMediaElement extends IDispatch {
    static IID := "{30590088-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLSourceElement extends IDispatch {
    static IID := "{30590089-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLAudioElement extends IDispatch {
    static IID := "{3059008A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLVideoElement extends IDispatch {
    static IID := "{3059008B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGSwitchElement extends IDispatch {
    static IID := "{305104F1-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGSwitchElement extends IDispatch {
    static IID := "{30590030-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGDescElement extends IDispatch {
    static IID := "{305104EA-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGDescElement extends IDispatch {
    static IID := "{30590005-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTitleElement extends IDispatch {
    static IID := "{305104EB-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGTitleElement extends IDispatch {
    static IID := "{30590006-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGMetadataElement extends IDispatch {
    static IID := "{30510560-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGMetadataElement extends IDispatch {
    static IID := "{3059002F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGElementInstanceList extends IDispatch {
    static IID := "{305104EF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppResult)
      => ComCall(8, this.p, Int32, index, ISVGElementInstance.Ptr, ppResult)
}
struct DispSVGElementInstance extends IDispatch {
    static IID := "{30590007-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGElementInstanceList extends IDispatch {
    static IID := "{30590008-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMException extends IDispatch {
    static IID := "{3051072B-98B5-11CF-BB82-00AA00BDCE0B}"
    put_code(v)
      => ComCall(7, this.p, Int32, v)
    get_code(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_message(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispDOMException extends IDispatch {
    static IID := "{30590094-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IRangeException extends IDispatch {
    static IID := "{3051072D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_code(v)
      => ComCall(7, this.p, Int32, v)
    get_code(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_message(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispRangeException extends IDispatch {
    static IID := "{30590095-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGException extends IDispatch {
    static IID := "{3051072F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_code(v)
      => ComCall(7, this.p, Int32, v)
    get_code(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_message(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispSVGException extends IDispatch {
    static IID := "{30590096-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IEventException extends IDispatch {
    static IID := "{3051073A-98B5-11CF-BB82-00AA00BDCE0B}"
    put_code(v)
      => ComCall(7, this.p, Int32, v)
    get_code(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get_message(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
}
struct DispEventException extends IDispatch {
    static IID := "{30590099-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGScriptElement extends IDispatch {
    static IID := "{3051054D-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispSVGScriptElement extends IDispatch {
    static IID := "{30590039-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGStyleElement extends IDispatch {
    static IID := "{305104F3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_type(v)
      => ComCall(7, this.p, BSTR, v)
    get_type(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_media(v)
      => ComCall(9, this.p, BSTR, v)
    get_media(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct DispSVGStyleElement extends IDispatch {
    static IID := "{30590029-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTextContentElement extends IDispatch {
    static IID := "{3051051A-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_textLength(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_textLength(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_lengthAdjust(v)
      => ComCall(9, this.p, ISVGAnimatedEnumeration, v)
    get_lengthAdjust(p)
      => ComCall(10, this.p, ISVGAnimatedEnumeration.Ptr, p)
    getNumberOfChars(pResult)
      => ComCall(11, this.p, Int32.Ptr, pResult)
    getComputedTextLength(pResult)
      => ComCall(12, this.p, Float32.Ptr, pResult)
    getSubStringLength(charnum, nchars, pResult)
      => ComCall(13, this.p, Int32, charnum, Int32, nchars, Float32.Ptr, pResult)
    getStartPositionOfChar(charnum, ppResult)
      => ComCall(14, this.p, Int32, charnum, ISVGPoint.Ptr, ppResult)
    getEndPositionOfChar(charnum, ppResult)
      => ComCall(15, this.p, Int32, charnum, ISVGPoint.Ptr, ppResult)
    getExtentOfChar(charnum, ppResult)
      => ComCall(16, this.p, Int32, charnum, ISVGRect.Ptr, ppResult)
    getRotationOfChar(charnum, pResult)
      => ComCall(17, this.p, Int32, charnum, Float32.Ptr, pResult)
    getCharNumAtPosition(point, pResult)
      => ComCall(18, this.p, ISVGPoint, point, Int32.Ptr, pResult)
    selectSubString(charnum, nchars)
      => ComCall(19, this.p, Int32, charnum, Int32, nchars)
}
struct DispSVGTextContentElement extends IDispatch {
    static IID := "{30590035-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTextPositioningElement extends IDispatch {
    static IID := "{3051051B-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_x(v)
      => ComCall(7, this.p, ISVGAnimatedLengthList, v)
    get_x(p)
      => ComCall(8, this.p, ISVGAnimatedLengthList.Ptr, p)
    putref_y(v)
      => ComCall(9, this.p, ISVGAnimatedLengthList, v)
    get_y(p)
      => ComCall(10, this.p, ISVGAnimatedLengthList.Ptr, p)
    putref_dx(v)
      => ComCall(11, this.p, ISVGAnimatedLengthList, v)
    get_dx(p)
      => ComCall(12, this.p, ISVGAnimatedLengthList.Ptr, p)
    putref_dy(v)
      => ComCall(13, this.p, ISVGAnimatedLengthList, v)
    get_dy(p)
      => ComCall(14, this.p, ISVGAnimatedLengthList.Ptr, p)
    putref_rotate(v)
      => ComCall(15, this.p, ISVGAnimatedNumberList, v)
    get_rotate(p)
      => ComCall(16, this.p, ISVGAnimatedNumberList.Ptr, p)
}
struct DispSVGTextPositioningElement extends IDispatch {
    static IID := "{30590038-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispDOMDocumentType extends IDispatch {
    static IID := "{30590098-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispNodeIterator extends IDispatch {
    static IID := "{3059009C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispTreeWalker extends IDispatch {
    static IID := "{3059009D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispDOMProcessingInstruction extends IDispatch {
    static IID := "{3059009B-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLPerformanceNavigation extends IDispatch {
    static IID := "{30510750-98B5-11CF-BB82-00AA00BDCE0B}"
    get_type(p)
      => ComCall(7, this.p, UInt32.Ptr, p)
    get_redirectCount(p)
      => ComCall(8, this.p, UInt32.Ptr, p)
    toString(string)
      => ComCall(9, this.p, BSTR.Ptr, string)
    toJSON(pVar)
      => ComCall(10, this.p, VARIANT.Ptr, pVar)
}
struct IHTMLPerformanceTiming extends IDispatch {
    static IID := "{30510752-98B5-11CF-BB82-00AA00BDCE0B}"
    get_navigationStart(p)
      => ComCall(7, this.p, Int64.Ptr, p)
    get_unloadEventStart(p)
      => ComCall(8, this.p, Int64.Ptr, p)
    get_unloadEventEnd(p)
      => ComCall(9, this.p, Int64.Ptr, p)
    get_redirectStart(p)
      => ComCall(10, this.p, Int64.Ptr, p)
    get_redirectEnd(p)
      => ComCall(11, this.p, Int64.Ptr, p)
    get_fetchStart(p)
      => ComCall(12, this.p, Int64.Ptr, p)
    get_domainLookupStart(p)
      => ComCall(13, this.p, Int64.Ptr, p)
    get_domainLookupEnd(p)
      => ComCall(14, this.p, Int64.Ptr, p)
    get_connectStart(p)
      => ComCall(15, this.p, Int64.Ptr, p)
    get_connectEnd(p)
      => ComCall(16, this.p, Int64.Ptr, p)
    get_requestStart(p)
      => ComCall(17, this.p, Int64.Ptr, p)
    get_responseStart(p)
      => ComCall(18, this.p, Int64.Ptr, p)
    get_responseEnd(p)
      => ComCall(19, this.p, Int64.Ptr, p)
    get_domLoading(p)
      => ComCall(20, this.p, Int64.Ptr, p)
    get_domInteractive(p)
      => ComCall(21, this.p, Int64.Ptr, p)
    get_domContentLoadedEventStart(p)
      => ComCall(22, this.p, Int64.Ptr, p)
    get_domContentLoadedEventEnd(p)
      => ComCall(23, this.p, Int64.Ptr, p)
    get_domComplete(p)
      => ComCall(24, this.p, Int64.Ptr, p)
    get_loadEventStart(p)
      => ComCall(25, this.p, Int64.Ptr, p)
    get_loadEventEnd(p)
      => ComCall(26, this.p, Int64.Ptr, p)
    get_msFirstPaint(p)
      => ComCall(27, this.p, Int64.Ptr, p)
    toString(string)
      => ComCall(28, this.p, BSTR.Ptr, string)
    toJSON(pVar)
      => ComCall(29, this.p, VARIANT.Ptr, pVar)
}
struct DispHTMLPerformance extends IDispatch {
    static IID := "{3059009F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLPerformanceNavigation extends IDispatch {
    static IID := "{305900A0-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLPerformanceTiming extends IDispatch {
    static IID := "{305900A1-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTSpanElement extends IDispatch {
    static IID := "{3051051D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispSVGTSpanElement extends IDispatch {
    static IID := "{3059003A-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ITemplatePrinter extends IDispatch {
    static IID := "{3050F6B4-98B5-11CF-BB82-00AA00BDCE0B}"
    startDoc(bstrTitle, p)
      => ComCall(7, this.p, BSTR, bstrTitle, VARIANT_BOOL.Ptr, p)
    stopDoc()
      => ComCall(8, this.p)
    printBlankPage()
      => ComCall(9, this.p)
    printPage(pElemDisp)
      => ComCall(10, this.p, IDispatch, pElemDisp)
    ensurePrintDialogDefaults(p)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, p)
    showPrintDialog(p)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, p)
    showPageSetupDialog(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    printNonNative(pMarkup, p)
      => ComCall(14, this.p, IUnknown, pMarkup, VARIANT_BOOL.Ptr, p)
    printNonNativeFrames(pMarkup, fActiveFrame)
      => ComCall(15, this.p, IUnknown, pMarkup, VARIANT_BOOL, fActiveFrame)
    put_framesetDocument(v)
      => ComCall(16, this.p, VARIANT_BOOL, v)
    get_framesetDocument(p)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, p)
    put_frameActive(v)
      => ComCall(18, this.p, VARIANT_BOOL, v)
    get_frameActive(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
    put_frameAsShown(v)
      => ComCall(20, this.p, VARIANT_BOOL, v)
    get_frameAsShown(p)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, p)
    put_selection(v)
      => ComCall(22, this.p, VARIANT_BOOL, v)
    get_selection(p)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, p)
    put_selectedPages(v)
      => ComCall(24, this.p, VARIANT_BOOL, v)
    get_selectedPages(p)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, p)
    put_currentPage(v)
      => ComCall(26, this.p, VARIANT_BOOL, v)
    get_currentPage(p)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, p)
    put_currentPageAvail(v)
      => ComCall(28, this.p, VARIANT_BOOL, v)
    get_currentPageAvail(p)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, p)
    put_collate(v)
      => ComCall(30, this.p, VARIANT_BOOL, v)
    get_collate(p)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, p)
    get_duplex(p)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, p)
    put_copies(v)
      => ComCall(33, this.p, UInt16, v)
    get_copies(p)
      => ComCall(34, this.p, UInt16.Ptr, p)
    put_pageFrom(v)
      => ComCall(35, this.p, UInt16, v)
    get_pageFrom(p)
      => ComCall(36, this.p, UInt16.Ptr, p)
    put_pageTo(v)
      => ComCall(37, this.p, UInt16, v)
    get_pageTo(p)
      => ComCall(38, this.p, UInt16.Ptr, p)
    put_tableOfLinks(v)
      => ComCall(39, this.p, VARIANT_BOOL, v)
    get_tableOfLinks(p)
      => ComCall(40, this.p, VARIANT_BOOL.Ptr, p)
    put_allLinkedDocuments(v)
      => ComCall(41, this.p, VARIANT_BOOL, v)
    get_allLinkedDocuments(p)
      => ComCall(42, this.p, VARIANT_BOOL.Ptr, p)
    put_header(v)
      => ComCall(43, this.p, BSTR, v)
    get_header(p)
      => ComCall(44, this.p, BSTR.Ptr, p)
    put_footer(v)
      => ComCall(45, this.p, BSTR, v)
    get_footer(p)
      => ComCall(46, this.p, BSTR.Ptr, p)
    put_marginLeft(v)
      => ComCall(47, this.p, Int32, v)
    get_marginLeft(p)
      => ComCall(48, this.p, Int32.Ptr, p)
    put_marginRight(v)
      => ComCall(49, this.p, Int32, v)
    get_marginRight(p)
      => ComCall(50, this.p, Int32.Ptr, p)
    put_marginTop(v)
      => ComCall(51, this.p, Int32, v)
    get_marginTop(p)
      => ComCall(52, this.p, Int32.Ptr, p)
    put_marginBottom(v)
      => ComCall(53, this.p, Int32, v)
    get_marginBottom(p)
      => ComCall(54, this.p, Int32.Ptr, p)
    get_pageWidth(p)
      => ComCall(55, this.p, Int32.Ptr, p)
    get_pageHeight(p)
      => ComCall(56, this.p, Int32.Ptr, p)
    get_unprintableLeft(p)
      => ComCall(57, this.p, Int32.Ptr, p)
    get_unprintableTop(p)
      => ComCall(58, this.p, Int32.Ptr, p)
    get_unprintableRight(p)
      => ComCall(59, this.p, Int32.Ptr, p)
    get_unprintableBottom(p)
      => ComCall(60, this.p, Int32.Ptr, p)
    updatePageStatus(p)
      => ComCall(61, this.p, Int32.Ptr, p)
}
struct ITemplatePrinter2 extends ITemplatePrinter {
    static IID := "{3050F83F-98B5-11CF-BB82-00AA00BDCE0B}"
    put_selectionEnabled(v)
      => ComCall(62, this.p, VARIANT_BOOL, v)
    get_selectionEnabled(p)
      => ComCall(63, this.p, VARIANT_BOOL.Ptr, p)
    put_frameActiveEnabled(v)
      => ComCall(64, this.p, VARIANT_BOOL, v)
    get_frameActiveEnabled(p)
      => ComCall(65, this.p, VARIANT_BOOL.Ptr, p)
    put_orientation(v)
      => ComCall(66, this.p, BSTR, v)
    get_orientation(p)
      => ComCall(67, this.p, BSTR.Ptr, p)
    put_usePrinterCopyCollate(v)
      => ComCall(68, this.p, VARIANT_BOOL, v)
    get_usePrinterCopyCollate(p)
      => ComCall(69, this.p, VARIANT_BOOL.Ptr, p)
    deviceSupports(bstrProperty, pvar)
      => ComCall(70, this.p, BSTR, bstrProperty, VARIANT.Ptr, pvar)
}
struct ITemplatePrinter3 extends ITemplatePrinter2 {
    static IID := "{305104A3-98B5-11CF-BB82-00AA00BDCE0B}"
    put_headerFooterFont(v)
      => ComCall(71, this.p, BSTR, v)
    get_headerFooterFont(p)
      => ComCall(72, this.p, BSTR.Ptr, p)
    getPageMarginTop(pageRule, pageWidth, pageHeight, pMargin)
      => ComCall(73, this.p, IDispatch, pageRule, Int32, pageWidth, Int32, pageHeight, VARIANT.Ptr, pMargin)
    getPageMarginRight(pageRule, pageWidth, pageHeight, pMargin)
      => ComCall(74, this.p, IDispatch, pageRule, Int32, pageWidth, Int32, pageHeight, VARIANT.Ptr, pMargin)
    getPageMarginBottom(pageRule, pageWidth, pageHeight, pMargin)
      => ComCall(75, this.p, IDispatch, pageRule, Int32, pageWidth, Int32, pageHeight, VARIANT.Ptr, pMargin)
    getPageMarginLeft(pageRule, pageWidth, pageHeight, pMargin)
      => ComCall(76, this.p, IDispatch, pageRule, Int32, pageWidth, Int32, pageHeight, VARIANT.Ptr, pMargin)
    getPageMarginTopImportant(pageRule, pbImportant)
      => ComCall(77, this.p, IDispatch, pageRule, VARIANT_BOOL.Ptr, pbImportant)
    getPageMarginRightImportant(pageRule, pbImportant)
      => ComCall(78, this.p, IDispatch, pageRule, VARIANT_BOOL.Ptr, pbImportant)
    getPageMarginBottomImportant(pageRule, pbImportant)
      => ComCall(79, this.p, IDispatch, pageRule, VARIANT_BOOL.Ptr, pbImportant)
    getPageMarginLeftImportant(pageRule, pbImportant)
      => ComCall(80, this.p, IDispatch, pageRule, VARIANT_BOOL.Ptr, pbImportant)
}
struct IPrintManagerTemplatePrinter extends IDispatch {
    static IID := "{F633BE14-9EFF-4C4D-929E-05717B21B3E6}"
    startPrint()
      => ComCall(7, this.p)
    drawPreviewPage(pElemDisp, nPage)
      => ComCall(8, this.p, IDispatch, pElemDisp, Int32, nPage)
    setPageCount(nPage)
      => ComCall(9, this.p, Int32, nPage)
    invalidatePreview()
      => ComCall(10, this.p)
    getPrintTaskOptionValue(bstrKey, pvarin)
      => ComCall(11, this.p, BSTR, bstrKey, VARIANT.Ptr, pvarin)
    endPrint()
      => ComCall(12, this.p)
}
struct IPrintManagerTemplatePrinter2 extends IPrintManagerTemplatePrinter {
    static IID := "{C6403497-7493-4F09-8016-54B03E9BDA69}"
    get_showHeaderFooter(p)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, p)
    get_shrinkToFit(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_percentScale(p)
      => ComCall(15, this.p, Float32.Ptr, p)
}
struct DispCPrintManagerTemplatePrinter extends IDispatch {
    static IID := "{305900E9-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ISVGTextPathElement extends IDispatch {
    static IID := "{3051051F-98B5-11CF-BB82-00AA00BDCE0B}"
    putref_startOffset(v)
      => ComCall(7, this.p, ISVGAnimatedLength, v)
    get_startOffset(p)
      => ComCall(8, this.p, ISVGAnimatedLength.Ptr, p)
    putref_method(v)
      => ComCall(9, this.p, ISVGAnimatedEnumeration, v)
    get_method(p)
      => ComCall(10, this.p, ISVGAnimatedEnumeration.Ptr, p)
    putref_spacing(v)
      => ComCall(11, this.p, ISVGAnimatedEnumeration, v)
    get_spacing(p)
      => ComCall(12, this.p, ISVGAnimatedEnumeration.Ptr, p)
}
struct DispSVGTextPathElement extends IDispatch {
    static IID := "{3059003D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMXmlSerializer extends IDispatch {
    static IID := "{3051077D-98B5-11CF-BB82-00AA00BDCE0B}"
    serializeToString(pNode, pString)
      => ComCall(7, this.p, IHTMLDOMNode, pNode, BSTR.Ptr, pString)
}
struct IDOMParser extends IDispatch {
    static IID := "{30510781-98B5-11CF-BB82-00AA00BDCE0B}"
    parseFromString(xmlSource, mimeType, ppNode)
      => ComCall(7, this.p, BSTR, xmlSource, BSTR, mimeType, IHTMLDocument2.Ptr, ppNode)
}
struct DispXMLSerializer extends IDispatch {
    static IID := "{305900AD-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispDOMParser extends IDispatch {
    static IID := "{305900AE-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMXmlSerializerFactory extends IDispatch {
    static IID := "{3051077F-98B5-11CF-BB82-00AA00BDCE0B}"
    create(__MIDL__IDOMXmlSerializerFactory0000)
      => ComCall(7, this.p, IDOMXmlSerializer.Ptr, __MIDL__IDOMXmlSerializerFactory0000)
}
struct IDOMParserFactory extends IDispatch {
    static IID := "{30510783-98B5-11CF-BB82-00AA00BDCE0B}"
    create(__MIDL__IDOMParserFactory0000)
      => ComCall(7, this.p, IDOMParser.Ptr, __MIDL__IDOMParserFactory0000)
}
struct DispHTMLSemanticElement extends IDispatch {
    static IID := "{305900BA-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLProgressElement extends IDispatch {
    static IID := "{3050F2D6-98B5-11CF-BB82-00AA00BDCE0B}"
    put_value(v)
      => ComCall(7, this.p, Float32, v)
    get_value(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    put_max(v)
      => ComCall(9, this.p, Float32, v)
    get_max(p)
      => ComCall(10, this.p, Float32.Ptr, p)
    get_position(p)
      => ComCall(11, this.p, Float32.Ptr, p)
    get_form(p)
      => ComCall(12, this.p, IHTMLFormElement.Ptr, p)
}
struct DispHTMLProgressElement extends IDispatch {
    static IID := "{305900AF-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMSTransitionEvent extends IDispatch {
    static IID := "{305107B5-98B5-11CF-BB82-00AA00BDCE0B}"
    get_propertyName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_elapsedTime(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    initMSTransitionEvent(eventType, canBubble, cancelable, propertyName, elapsedTime)
      => ComCall(9, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, BSTR, propertyName, Float32, elapsedTime)
}
struct DispDOMMSTransitionEvent extends IDispatch {
    static IID := "{305900BB-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMMSAnimationEvent extends IDispatch {
    static IID := "{305107B7-98B5-11CF-BB82-00AA00BDCE0B}"
    get_animationName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_elapsedTime(p)
      => ComCall(8, this.p, Float32.Ptr, p)
    initMSAnimationEvent(eventType, canBubble, cancelable, animationName, elapsedTime)
      => ComCall(9, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, BSTR, animationName, Float32, elapsedTime)
}
struct DispDOMMSAnimationEvent extends IDispatch {
    static IID := "{305900BC-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IWebGeocoordinates extends IDispatch {
    static IID := "{305107C7-98B5-11CF-BB82-00AA00BDCE0B}"
    get_latitude(p)
      => ComCall(7, this.p, Float64.Ptr, p)
    get_longitude(p)
      => ComCall(8, this.p, Float64.Ptr, p)
    get_altitude(p)
      => ComCall(9, this.p, VARIANT.Ptr, p)
    get_accuracy(p)
      => ComCall(10, this.p, Float64.Ptr, p)
    get_altitudeAccuracy(p)
      => ComCall(11, this.p, VARIANT.Ptr, p)
    get_heading(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    get_speed(p)
      => ComCall(13, this.p, VARIANT.Ptr, p)
}
struct IWebGeopositionError extends IDispatch {
    static IID := "{305107C9-98B5-11CF-BB82-00AA00BDCE0B}"
    get_code(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_message(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct IWebGeoposition extends IDispatch {
    static IID := "{305107CD-98B5-11CF-BB82-00AA00BDCE0B}"
    get_coords(p)
      => ComCall(7, this.p, IWebGeocoordinates.Ptr, p)
    get_timestamp(p)
      => ComCall(8, this.p, Int64.Ptr, p)
}
struct DispWebGeolocation extends IDispatch {
    static IID := "{305900BD-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispWebGeocoordinates extends IDispatch {
    static IID := "{305900BE-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispWebGeopositionError extends IDispatch {
    static IID := "{305900BF-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispWebGeoposition extends IDispatch {
    static IID := "{305900C1-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IClientCaps extends IDispatch {
    static IID := "{7E8BC44D-AEFF-11D1-89C2-00C04FB6BFC4}"
    get_javaEnabled(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    get_cookieEnabled(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_cpuClass(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_systemLanguage(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_userLanguage(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    get_platform(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    get_connectionSpeed(p)
      => ComCall(13, this.p, Int32.Ptr, p)
    get_onLine(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_colorDepth(p)
      => ComCall(15, this.p, Int32.Ptr, p)
    get_bufferDepth(p)
      => ComCall(16, this.p, Int32.Ptr, p)
    get_width(p)
      => ComCall(17, this.p, Int32.Ptr, p)
    get_height(p)
      => ComCall(18, this.p, Int32.Ptr, p)
    get_availHeight(p)
      => ComCall(19, this.p, Int32.Ptr, p)
    get_availWidth(p)
      => ComCall(20, this.p, Int32.Ptr, p)
    get_connectionType(p)
      => ComCall(21, this.p, BSTR.Ptr, p)
    isComponentInstalled(bstrName, bstrUrl, bStrVer, p)
      => ComCall(22, this.p, BSTR, bstrName, BSTR, bstrUrl, BSTR, bStrVer, VARIANT_BOOL.Ptr, p)
    getComponentVersion(bstrName, bstrUrl, pbstrVer)
      => ComCall(23, this.p, BSTR, bstrName, BSTR, bstrUrl, BSTR.Ptr, pbstrVer)
    compareVersions(bstrVer1, bstrVer2, p)
      => ComCall(24, this.p, BSTR, bstrVer1, BSTR, bstrVer2, Int32.Ptr, p)
    addComponentRequest(bstrName, bstrUrl, bStrVer)
      => ComCall(25, this.p, BSTR, bstrName, BSTR, bstrUrl, BSTR, bStrVer)
    doComponentRequest(p)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, p)
    clearComponentRequest()
      => ComCall(27, this.p)
}
struct IDOMMSManipulationEvent extends IDispatch {
    static IID := "{30510816-98B5-11CF-BB82-00AA00BDCE0B}"
    get_lastState(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get_currentState(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    initMSManipulationEvent(eventType, canBubble, cancelable, viewArg, detailArg, lastState, currentState)
      => ComCall(9, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, IHTMLWindow2, viewArg, Int32, detailArg, Int32, lastState, Int32, currentState)
}
struct DispDOMMSManipulationEvent extends IDispatch {
    static IID := "{305900E1-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IDOMCloseEvent extends IDispatch {
    static IID := "{305107FF-98B5-11CF-BB82-00AA00BDCE0B}"
    get_wasClean(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    initCloseEvent(eventType, canBubble, cancelable, wasClean, code, reason)
      => ComCall(8, this.p, BSTR, eventType, VARIANT_BOOL, canBubble, VARIANT_BOOL, cancelable, VARIANT_BOOL, wasClean, Int32, code, BSTR, reason)
}
struct DispDOMCloseEvent extends IDispatch {
    static IID := "{305900DC-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispApplicationCache extends IDispatch {
    static IID := "{305900E4-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct ICSSFilterSite extends IUnknown {
    static IID := "{3050F3ED-98B5-11CF-BB82-00AA00BDCE0B}"
    GetElement(Element)
      => ComCall(3, this.p, IHTMLElement.Ptr, Element)
    FireOnFilterChangeEvent()
      => ComCall(4, this.p)
}
struct IMarkupPointer extends IUnknown {
    static IID := "{3050F49F-98B5-11CF-BB82-00AA00BDCE0B}"
    OwningDoc(ppDoc)
      => ComCall(3, this.p, IHTMLDocument2.Ptr, ppDoc)
    Gravity(pGravity)
      => ComCall(4, this.p, POINTER_GRAVITY.Ptr, pGravity)
    SetGravity(Gravity)
      => ComCall(5, this.p, POINTER_GRAVITY, Gravity)
    Cling(pfCling)
      => ComCall(6, this.p, BOOL.Ptr, pfCling)
    SetCling(fCLing)
      => ComCall(7, this.p, BOOL, fCLing)
    Unposition()
      => ComCall(8, this.p)
    IsPositioned(pfPositioned)
      => ComCall(9, this.p, BOOL.Ptr, pfPositioned)
    GetContainer(ppContainer)
      => ComCall(10, this.p, IMarkupContainer.Ptr, ppContainer)
    MoveAdjacentToElement(pElement, eAdj)
      => ComCall(11, this.p, IHTMLElement, pElement, ELEMENT_ADJACENCY, eAdj)
    MoveToPointer(pPointer)
      => ComCall(12, this.p, IMarkupPointer, pPointer)
    MoveToContainer(pContainer, fAtStart)
      => ComCall(13, this.p, IMarkupContainer, pContainer, BOOL, fAtStart)
    Left(fMove, pContext, ppElement, pchText)
      => ComCall(14, this.p, BOOL, fMove, MARKUP_CONTEXT_TYPE.Ptr, pContext, IHTMLElement.Ptr, ppElement, Int32.Ptr, pchText.Length, PWSTR, pchText)
    Right(fMove, pContext, ppElement, pchText)
      => ComCall(15, this.p, BOOL, fMove, MARKUP_CONTEXT_TYPE.Ptr, pContext, IHTMLElement.Ptr, ppElement, Int32.Ptr, pchText.Length, PWSTR, pchText)
    CurrentScope(ppElemCurrent)
      => ComCall(16, this.p, IHTMLElement.Ptr, ppElemCurrent)
    IsLeftOf(pPointerThat, pfResult)
      => ComCall(17, this.p, IMarkupPointer, pPointerThat, BOOL.Ptr, pfResult)
    IsLeftOfOrEqualTo(pPointerThat, pfResult)
      => ComCall(18, this.p, IMarkupPointer, pPointerThat, BOOL.Ptr, pfResult)
    IsRightOf(pPointerThat, pfResult)
      => ComCall(19, this.p, IMarkupPointer, pPointerThat, BOOL.Ptr, pfResult)
    IsRightOfOrEqualTo(pPointerThat, pfResult)
      => ComCall(20, this.p, IMarkupPointer, pPointerThat, BOOL.Ptr, pfResult)
    IsEqualTo(pPointerThat, pfAreEqual)
      => ComCall(21, this.p, IMarkupPointer, pPointerThat, BOOL.Ptr, pfAreEqual)
    MoveUnit(muAction)
      => ComCall(22, this.p, MOVEUNIT_ACTION, muAction)
    FindText(pchFindText, dwFlags, pIEndMatch, pIEndSearch)
      => ComCall(23, this.p, "Str", pchFindText, UInt32, dwFlags, IMarkupPointer, pIEndMatch, IMarkupPointer, pIEndSearch)
}
struct IMarkupContainer extends IUnknown {
    static IID := "{3050F5F9-98B5-11CF-BB82-00AA00BDCE0B}"
    OwningDoc(ppDoc)
      => ComCall(3, this.p, IHTMLDocument2.Ptr, ppDoc)
}
struct IMarkupContainer2 extends IMarkupContainer {
    static IID := "{3050F648-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateChangeLog(pChangeSink, ppChangeLog, fForward, fBackward)
      => ComCall(4, this.p, IHTMLChangeSink, pChangeSink, IHTMLChangeLog.Ptr, ppChangeLog, BOOL, fForward, BOOL, fBackward)
    RegisterForDirtyRange(pChangeSink, pdwCookie)
      => ComCall(5, this.p, IHTMLChangeSink, pChangeSink, UInt32.Ptr, pdwCookie)
    UnRegisterForDirtyRange(dwCookie)
      => ComCall(6, this.p, UInt32, dwCookie)
    GetAndClearDirtyRange(dwCookie, pIPointerBegin, pIPointerEnd)
      => ComCall(7, this.p, UInt32, dwCookie, IMarkupPointer, pIPointerBegin, IMarkupPointer, pIPointerEnd)
    GetVersionNumber()
      => ComCall(8, this.p, Int32)
    GetMasterElement(ppElementMaster)
      => ComCall(9, this.p, IHTMLElement.Ptr, ppElementMaster)
}
struct IHTMLChangeLog extends IUnknown {
    static IID := "{3050F649-98B5-11CF-BB82-00AA00BDCE0B}"
    GetNextChange(pbBuffer, nBufferSize, pnRecordLength)
      => ComCall(3, this.p, UInt8.Ptr, pbBuffer, Int32, nBufferSize, Int32.Ptr, pnRecordLength)
}
struct IHTMLChangeSink extends IUnknown {
    static IID := "{3050F64A-98B5-11CF-BB82-00AA00BDCE0B}"
    Notify()
      => ComCall(3, this.p)
}
struct ISegmentList extends IUnknown {
    static IID := "{3050F605-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateIterator(ppIIter)
      => ComCall(3, this.p, ISegmentListIterator.Ptr, ppIIter)
    GetType(peType)
      => ComCall(4, this.p, SELECTION_TYPE.Ptr, peType)
    IsEmpty(pfEmpty)
      => ComCall(5, this.p, BOOL.Ptr, pfEmpty)
}
struct ISegmentListIterator extends IUnknown {
    static IID := "{3050F692-98B5-11CF-BB82-00AA00BDCE0B}"
    Current(ppISegment)
      => ComCall(3, this.p, ISegment.Ptr, ppISegment)
    First()
      => ComCall(4, this.p)
    IsDone()
      => ComCall(5, this.p)
    Advance()
      => ComCall(6, this.p)
}
struct IHTMLCaret extends IUnknown {
    static IID := "{3050F604-98B5-11CF-BB82-00AA00BDCE0B}"
    MoveCaretToPointer(pDispPointer, fScrollIntoView, eDir)
      => ComCall(3, this.p, IDisplayPointer, pDispPointer, BOOL, fScrollIntoView, CARET_DIRECTION, eDir)
    MoveCaretToPointerEx(pDispPointer, fVisible, fScrollIntoView, eDir)
      => ComCall(4, this.p, IDisplayPointer, pDispPointer, BOOL, fVisible, BOOL, fScrollIntoView, CARET_DIRECTION, eDir)
    MoveMarkupPointerToCaret(pIMarkupPointer)
      => ComCall(5, this.p, IMarkupPointer, pIMarkupPointer)
    MoveDisplayPointerToCaret(pDispPointer)
      => ComCall(6, this.p, IDisplayPointer, pDispPointer)
    IsVisible(pIsVisible)
      => ComCall(7, this.p, BOOL.Ptr, pIsVisible)
    Show(fScrollIntoView)
      => ComCall(8, this.p, BOOL, fScrollIntoView)
    Hide()
      => ComCall(9, this.p)
    InsertText(pText, lLen)
      => ComCall(10, this.p, "Str", pText, Int32, lLen)
    ScrollIntoView()
      => ComCall(11, this.p)
    GetLocation(pPoint, fTranslate)
      => ComCall(12, this.p, POINT.Ptr, pPoint, BOOL, fTranslate)
    GetCaretDirection(peDir)
      => ComCall(13, this.p, CARET_DIRECTION.Ptr, peDir)
    SetCaretDirection(eDir)
      => ComCall(14, this.p, CARET_DIRECTION, eDir)
}
struct ISegment extends IUnknown {
    static IID := "{3050F683-98B5-11CF-BB82-00AA00BDCE0B}"
    GetPointers(pIStart, pIEnd)
      => ComCall(3, this.p, IMarkupPointer, pIStart, IMarkupPointer, pIEnd)
}
struct IElementSegment extends ISegment {
    static IID := "{3050F68F-98B5-11CF-BB82-00AA00BDCE0B}"
    GetElement(ppIElement)
      => ComCall(4, this.p, IHTMLElement.Ptr, ppIElement)
    SetPrimary(fPrimary)
      => ComCall(5, this.p, BOOL, fPrimary)
    IsPrimary(pfPrimary)
      => ComCall(6, this.p, BOOL.Ptr, pfPrimary)
}
struct IHighlightSegment extends ISegment {
    static IID := "{3050F690-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHighlightRenderingServices extends IUnknown {
    static IID := "{3050F606-98B5-11CF-BB82-00AA00BDCE0B}"
    AddSegment(pDispPointerStart, pDispPointerEnd, pIRenderStyle, ppISegment)
      => ComCall(3, this.p, IDisplayPointer, pDispPointerStart, IDisplayPointer, pDispPointerEnd, IHTMLRenderStyle, pIRenderStyle, IHighlightSegment.Ptr, ppISegment)
    MoveSegmentToPointers(pISegment, pDispPointerStart, pDispPointerEnd)
      => ComCall(4, this.p, IHighlightSegment, pISegment, IDisplayPointer, pDispPointerStart, IDisplayPointer, pDispPointerEnd)
    RemoveSegment(pISegment)
      => ComCall(5, this.p, IHighlightSegment, pISegment)
}
struct ILineInfo extends IUnknown {
    static IID := "{3050F7E2-98B5-11CF-BB82-00AA00BDCE0B}"
    get_x(p)
      => ComCall(3, this.p, Int32.Ptr, p)
    get_baseLine(p)
      => ComCall(4, this.p, Int32.Ptr, p)
    get_textDescent(p)
      => ComCall(5, this.p, Int32.Ptr, p)
    get_textHeight(p)
      => ComCall(6, this.p, Int32.Ptr, p)
    get_lineDirection(p)
      => ComCall(7, this.p, Int32.Ptr, p)
}
struct IDisplayPointer extends IUnknown {
    static IID := "{3050F69E-98B5-11CF-BB82-00AA00BDCE0B}"
    MoveToPoint(ptPoint, eCoordSystem, pElementContext, dwHitTestOptions, pdwHitTestResults)
      => ComCall(3, this.p, POINT, ptPoint, COORD_SYSTEM, eCoordSystem, IHTMLElement, pElementContext, UInt32, dwHitTestOptions, UInt32.Ptr, pdwHitTestResults)
    MoveUnit(eMoveUnit, lXPos)
      => ComCall(4, this.p, DISPLAY_MOVEUNIT, eMoveUnit, Int32, lXPos)
    PositionMarkupPointer(pMarkupPointer)
      => ComCall(5, this.p, IMarkupPointer, pMarkupPointer)
    MoveToPointer(pDispPointer)
      => ComCall(6, this.p, IDisplayPointer, pDispPointer)
    SetPointerGravity(eGravity)
      => ComCall(7, this.p, POINTER_GRAVITY, eGravity)
    GetPointerGravity(peGravity)
      => ComCall(8, this.p, POINTER_GRAVITY.Ptr, peGravity)
    SetDisplayGravity(eGravity)
      => ComCall(9, this.p, DISPLAY_GRAVITY, eGravity)
    GetDisplayGravity(peGravity)
      => ComCall(10, this.p, DISPLAY_GRAVITY.Ptr, peGravity)
    IsPositioned(pfPositioned)
      => ComCall(11, this.p, BOOL.Ptr, pfPositioned)
    Unposition()
      => ComCall(12, this.p)
    IsEqualTo(pDispPointer, pfIsEqual)
      => ComCall(13, this.p, IDisplayPointer, pDispPointer, BOOL.Ptr, pfIsEqual)
    IsLeftOf(pDispPointer, pfIsLeftOf)
      => ComCall(14, this.p, IDisplayPointer, pDispPointer, BOOL.Ptr, pfIsLeftOf)
    IsRightOf(pDispPointer, pfIsRightOf)
      => ComCall(15, this.p, IDisplayPointer, pDispPointer, BOOL.Ptr, pfIsRightOf)
    IsAtBOL(pfBOL)
      => ComCall(16, this.p, BOOL.Ptr, pfBOL)
    MoveToMarkupPointer(pPointer, pDispLineContext)
      => ComCall(17, this.p, IMarkupPointer, pPointer, IDisplayPointer, pDispLineContext)
    ScrollIntoView()
      => ComCall(18, this.p)
    GetLineInfo(ppLineInfo)
      => ComCall(19, this.p, ILineInfo.Ptr, ppLineInfo)
    GetFlowElement(ppLayoutElement)
      => ComCall(20, this.p, IHTMLElement.Ptr, ppLayoutElement)
    QueryBreaks(pdwBreaks)
      => ComCall(21, this.p, UInt32.Ptr, pdwBreaks)
}
struct IDisplayServices extends IUnknown {
    static IID := "{3050F69D-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateDisplayPointer(ppDispPointer)
      => ComCall(3, this.p, IDisplayPointer.Ptr, ppDispPointer)
    TransformRect(pRect, eSource, eDestination, pIElement)
      => ComCall(4, this.p, RECT.Ptr, pRect, COORD_SYSTEM, eSource, COORD_SYSTEM, eDestination, IHTMLElement, pIElement)
    TransformPoint(pPoint, eSource, eDestination, pIElement)
      => ComCall(5, this.p, POINT.Ptr, pPoint, COORD_SYSTEM, eSource, COORD_SYSTEM, eDestination, IHTMLElement, pIElement)
    GetCaret(ppCaret)
      => ComCall(6, this.p, IHTMLCaret.Ptr, ppCaret)
    GetComputedStyle(pPointer, ppComputedStyle)
      => ComCall(7, this.p, IMarkupPointer, pPointer, IHTMLComputedStyle.Ptr, ppComputedStyle)
    ScrollRectIntoView(pIElement, rect1)
      => ComCall(8, this.p, IHTMLElement, pIElement, RECT, rect1)
    HasFlowLayout(pIElement, pfHasFlowLayout)
      => ComCall(9, this.p, IHTMLElement, pIElement, BOOL.Ptr, pfHasFlowLayout)
}
struct IHtmlDlgSafeHelper extends IDispatch {
    static IID := "{3050F81A-98B5-11CF-BB82-00AA00BDCE0B}"
    choosecolordlg(initColor, rgbColor)
      => ComCall(7, this.p, VARIANT, initColor, VARIANT.Ptr, rgbColor)
    getCharset(fontName, charset)
      => ComCall(8, this.p, BSTR, fontName, VARIANT.Ptr, charset)
    get_Fonts(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_BlockFormats(p)
      => ComCall(10, this.p, IDispatch.Ptr, p)
}
struct IBlockFormats extends IDispatch {
    static IID := "{3050F830-98B5-11CF-BB82-00AA00BDCE0B}"
    get__NewEnum(p)
      => ComCall(7, this.p, IUnknown.Ptr, p)
    get_Count(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    Item(pvarIndex, pbstrBlockFormat)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, BSTR.Ptr, pbstrBlockFormat)
}
struct IFontNames extends IDispatch {
    static IID := "{3050F839-98B5-11CF-BB82-00AA00BDCE0B}"
    get__NewEnum(p)
      => ComCall(7, this.p, IUnknown.Ptr, p)
    get_Count(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    Item(pvarIndex, pbstrFontName)
      => ComCall(9, this.p, VARIANT.Ptr, pvarIndex, BSTR.Ptr, pbstrFontName)
}
struct ICSSFilter extends IUnknown {
    static IID := "{3050F3EC-98B5-11CF-BB82-00AA00BDCE0B}"
    SetSite(pSink)
      => ComCall(3, this.p, ICSSFilterSite, pSink)
    OnAmbientPropertyChange(dispid)
      => ComCall(4, this.p, Int32, dispid)
}
struct ISecureUrlHost extends IUnknown {
    static IID := "{C81984C4-74C8-11D2-BAA9-00C04FC2040E}"
    ValidateSecureUrl(pfAllow, pchUrlInQuestion, dwFlags)
      => ComCall(3, this.p, BOOL.Ptr, pfAllow, "Str", pchUrlInQuestion, UInt32, dwFlags)
}
struct IMarkupServices extends IUnknown {
    static IID := "{3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateMarkupPointer(ppPointer)
      => ComCall(3, this.p, IMarkupPointer.Ptr, ppPointer)
    CreateMarkupContainer(ppMarkupContainer)
      => ComCall(4, this.p, IMarkupContainer.Ptr, ppMarkupContainer)
    CreateElement(tagID, pchAttributes, ppElement)
      => ComCall(5, this.p, ELEMENT_TAG_ID, tagID, "Str", pchAttributes, IHTMLElement.Ptr, ppElement)
    CloneElement(pElemCloneThis, ppElementTheClone)
      => ComCall(6, this.p, IHTMLElement, pElemCloneThis, IHTMLElement.Ptr, ppElementTheClone)
    InsertElement(pElementInsert, pPointerStart, pPointerFinish)
      => ComCall(7, this.p, IHTMLElement, pElementInsert, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish)
    RemoveElement(pElementRemove)
      => ComCall(8, this.p, IHTMLElement, pElementRemove)
    Remove(pPointerStart, pPointerFinish)
      => ComCall(9, this.p, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish)
    Copy(pPointerSourceStart, pPointerSourceFinish, pPointerTarget)
      => ComCall(10, this.p, IMarkupPointer, pPointerSourceStart, IMarkupPointer, pPointerSourceFinish, IMarkupPointer, pPointerTarget)
    Move(pPointerSourceStart, pPointerSourceFinish, pPointerTarget)
      => ComCall(11, this.p, IMarkupPointer, pPointerSourceStart, IMarkupPointer, pPointerSourceFinish, IMarkupPointer, pPointerTarget)
    InsertText(pchText, cch, pPointerTarget)
      => ComCall(12, this.p, "Str", pchText, Int32, cch, IMarkupPointer, pPointerTarget)
    ParseString(pchHTML, dwFlags, ppContainerResult, ppPointerStart, ppPointerFinish)
      => ComCall(13, this.p, "Str", pchHTML, UInt32, dwFlags, IMarkupContainer.Ptr, ppContainerResult, IMarkupPointer, ppPointerStart, IMarkupPointer, ppPointerFinish)
    ParseGlobal(hglobalHTML, dwFlags, ppContainerResult, pPointerStart, pPointerFinish)
      => ComCall(14, this.p, HGLOBAL, hglobalHTML, UInt32, dwFlags, IMarkupContainer.Ptr, ppContainerResult, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish)
    IsScopedElement(pElement, pfScoped)
      => ComCall(15, this.p, IHTMLElement, pElement, BOOL.Ptr, pfScoped)
    GetElementTagId(pElement, ptagId)
      => ComCall(16, this.p, IHTMLElement, pElement, ELEMENT_TAG_ID.Ptr, ptagId)
    GetTagIDForName(bstrName, ptagId)
      => ComCall(17, this.p, BSTR, bstrName, ELEMENT_TAG_ID.Ptr, ptagId)
    GetNameForTagID(tagId, pbstrName)
      => ComCall(18, this.p, ELEMENT_TAG_ID, tagId, BSTR.Ptr, pbstrName)
    MovePointersToRange(pIRange, pPointerStart, pPointerFinish)
      => ComCall(19, this.p, IHTMLTxtRange, pIRange, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish)
    MoveRangeToPointers(pPointerStart, pPointerFinish, pIRange)
      => ComCall(20, this.p, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish, IHTMLTxtRange, pIRange)
    BeginUndoUnit(pchTitle)
      => ComCall(21, this.p, "Str", pchTitle)
    EndUndoUnit()
      => ComCall(22, this.p)
}
struct IMarkupServices2 extends IMarkupServices {
    static IID := "{3050F682-98B5-11CF-BB82-00AA00BDCE0B}"
    ParseGlobalEx(hglobalHTML, dwFlags, pContext, ppContainerResult, pPointerStart, pPointerFinish)
      => ComCall(23, this.p, HGLOBAL, hglobalHTML, UInt32, dwFlags, IMarkupContainer, pContext, IMarkupContainer.Ptr, ppContainerResult, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish)
    ValidateElements(pPointerStart, pPointerFinish, pPointerTarget, pPointerStatus, ppElemFailBottom, ppElemFailTop)
      => ComCall(24, this.p, IMarkupPointer, pPointerStart, IMarkupPointer, pPointerFinish, IMarkupPointer, pPointerTarget, IMarkupPointer, pPointerStatus, IHTMLElement.Ptr, ppElemFailBottom, IHTMLElement.Ptr, ppElemFailTop)
    SaveSegmentsToClipboard(pSegmentList, dwFlags)
      => ComCall(25, this.p, ISegmentList, pSegmentList, UInt32, dwFlags)
}
struct IHTMLChangePlayback extends IUnknown {
    static IID := "{3050F6E0-98B5-11CF-BB82-00AA00BDCE0B}"
    ExecChange(pbRecord, fForward)
      => ComCall(3, this.p, UInt8.Ptr, pbRecord, BOOL, fForward)
}
struct IMarkupPointer2 extends IMarkupPointer {
    static IID := "{3050F675-98B5-11CF-BB82-00AA00BDCE0B}"
    IsAtWordBreak(pfAtBreak)
      => ComCall(24, this.p, BOOL.Ptr, pfAtBreak)
    GetMarkupPosition(plMP)
      => ComCall(25, this.p, Int32.Ptr, plMP)
    MoveToMarkupPosition(pContainer, lMP)
      => ComCall(26, this.p, IMarkupContainer, pContainer, Int32, lMP)
    MoveUnitBounded(muAction, pIBoundary)
      => ComCall(27, this.p, MOVEUNIT_ACTION, muAction, IMarkupPointer, pIBoundary)
    IsInsideURL(pRight, pfResult)
      => ComCall(28, this.p, IMarkupPointer, pRight, BOOL.Ptr, pfResult)
    MoveToContent(pIElement, fAtStart)
      => ComCall(29, this.p, IHTMLElement, pIElement, BOOL, fAtStart)
}
struct IMarkupTextFrags extends IUnknown {
    static IID := "{3050F5FA-98B5-11CF-BB82-00AA00BDCE0B}"
    GetTextFragCount(pcFrags)
      => ComCall(3, this.p, Int32.Ptr, pcFrags)
    GetTextFrag(iFrag, pbstrFrag, pPointerFrag)
      => ComCall(4, this.p, Int32, iFrag, BSTR.Ptr, pbstrFrag, IMarkupPointer, pPointerFrag)
    RemoveTextFrag(iFrag)
      => ComCall(5, this.p, Int32, iFrag)
    InsertTextFrag(iFrag, bstrInsert, pPointerInsert)
      => ComCall(6, this.p, Int32, iFrag, BSTR, bstrInsert, IMarkupPointer, pPointerInsert)
    FindTextFragFromMarkupPointer(pPointerFind, piFrag, pfFragFound)
      => ComCall(7, this.p, IMarkupPointer, pPointerFind, Int32.Ptr, piFrag, BOOL.Ptr, pfFragFound)
}
struct IXMLGenericParse extends IUnknown {
    static IID := "{E4E23071-4D07-11D2-AE76-0080C73BC199}"
    SetGenericParse(fDoGeneric)
      => ComCall(3, this.p, VARIANT_BOOL, fDoGeneric)
}
struct IHTMLEditHost extends IUnknown {
    static IID := "{3050F6A0-98B5-11CF-BB82-00AA00BDCE0B}"
    SnapRect(pIElement, prcNew, eHandle)
      => ComCall(3, this.p, IHTMLElement, pIElement, RECT.Ptr, prcNew, ELEMENT_CORNER, eHandle)
}
struct IHTMLEditHost2 extends IHTMLEditHost {
    static IID := "{3050F848-98B5-11CF-BB82-00AA00BDCE0D}"
    PreDrag()
      => ComCall(4, this.p)
}
struct ISequenceNumber extends IUnknown {
    static IID := "{3050F6C1-98B5-11CF-BB82-00AA00BDCE0B}"
    GetSequenceNumber(nCurrent, pnNew)
      => ComCall(3, this.p, Int32, nCurrent, Int32.Ptr, pnNew)
}
struct IIMEServices extends IUnknown {
    static IID := "{3050F6CA-98B5-11CF-BB82-00AA00BDCE0B}"
    GetActiveIMM(ppActiveIMM)
      => ComCall(3, this.p, IActiveIMMApp.Ptr, ppActiveIMM)
}
struct ISelectionServicesListener extends IUnknown {
    static IID := "{3050F699-98B5-11CF-BB82-00AA00BDCE0B}"
    BeginSelectionUndo()
      => ComCall(3, this.p)
    EndSelectionUndo()
      => ComCall(4, this.p)
    OnSelectedElementExit(pIElementStart, pIElementEnd, pIElementContentStart, pIElementContentEnd)
      => ComCall(5, this.p, IMarkupPointer, pIElementStart, IMarkupPointer, pIElementEnd, IMarkupPointer, pIElementContentStart, IMarkupPointer, pIElementContentEnd)
    OnChangeType(eType, pIListener)
      => ComCall(6, this.p, SELECTION_TYPE, eType, ISelectionServicesListener, pIListener)
    GetTypeDetail(pTypeDetail)
      => ComCall(7, this.p, BSTR.Ptr, pTypeDetail)
}
struct ISelectionServices extends IUnknown {
    static IID := "{3050F684-98B5-11CF-BB82-00AA00BDCE0B}"
    SetSelectionType(eType, pIListener)
      => ComCall(3, this.p, SELECTION_TYPE, eType, ISelectionServicesListener, pIListener)
    GetMarkupContainer(ppIContainer)
      => ComCall(4, this.p, IMarkupContainer.Ptr, ppIContainer)
    AddSegment(pIStart, pIEnd, ppISegmentAdded)
      => ComCall(5, this.p, IMarkupPointer, pIStart, IMarkupPointer, pIEnd, ISegment.Ptr, ppISegmentAdded)
    AddElementSegment(pIElement, ppISegmentAdded)
      => ComCall(6, this.p, IHTMLElement, pIElement, IElementSegment.Ptr, ppISegmentAdded)
    RemoveSegment(pISegment)
      => ComCall(7, this.p, ISegment, pISegment)
    GetSelectionServicesListener(ppISelectionServicesListener)
      => ComCall(8, this.p, ISelectionServicesListener.Ptr, ppISelectionServicesListener)
}
struct IHTMLEditDesigner extends IUnknown {
    static IID := "{3050F662-98B5-11CF-BB82-00AA00BDCE0B}"
    PreHandleEvent(inEvtDispId, pIEventObj)
      => ComCall(3, this.p, Int32, inEvtDispId, IHTMLEventObj, pIEventObj)
    PostHandleEvent(inEvtDispId, pIEventObj)
      => ComCall(4, this.p, Int32, inEvtDispId, IHTMLEventObj, pIEventObj)
    TranslateAccelerator(inEvtDispId, pIEventObj)
      => ComCall(5, this.p, Int32, inEvtDispId, IHTMLEventObj, pIEventObj)
    PostEditorEventNotify(inEvtDispId, pIEventObj)
      => ComCall(6, this.p, Int32, inEvtDispId, IHTMLEventObj, pIEventObj)
}
struct IHTMLEditServices extends IUnknown {
    static IID := "{3050F663-98B5-11CF-BB82-00AA00BDCE0B}"
    AddDesigner(pIDesigner)
      => ComCall(3, this.p, IHTMLEditDesigner, pIDesigner)
    RemoveDesigner(pIDesigner)
      => ComCall(4, this.p, IHTMLEditDesigner, pIDesigner)
    GetSelectionServices(pIContainer, ppSelSvc)
      => ComCall(5, this.p, IMarkupContainer, pIContainer, ISelectionServices.Ptr, ppSelSvc)
    MoveToSelectionAnchor(pIStartAnchor)
      => ComCall(6, this.p, IMarkupPointer, pIStartAnchor)
    MoveToSelectionEnd(pIEndAnchor)
      => ComCall(7, this.p, IMarkupPointer, pIEndAnchor)
    SelectRange(pStart, pEnd, eType)
      => ComCall(8, this.p, IMarkupPointer, pStart, IMarkupPointer, pEnd, SELECTION_TYPE, eType)
}
struct IHTMLEditServices2 extends IHTMLEditServices {
    static IID := "{3050F812-98B5-11CF-BB82-00AA00BDCE0B}"
    MoveToSelectionAnchorEx(pIStartAnchor)
      => ComCall(9, this.p, IDisplayPointer, pIStartAnchor)
    MoveToSelectionEndEx(pIEndAnchor)
      => ComCall(10, this.p, IDisplayPointer, pIEndAnchor)
    FreezeVirtualCaretPos(fReCompute)
      => ComCall(11, this.p, BOOL, fReCompute)
    UnFreezeVirtualCaretPos(fReset)
      => ComCall(12, this.p, BOOL, fReset)
}
struct IHTMLComputedStyle extends IUnknown {
    static IID := "{3050F6C3-98B5-11CF-BB82-00AA00BDCE0B}"
    get_bold(p)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, p)
    get_italic(p)
      => ComCall(4, this.p, VARIANT_BOOL.Ptr, p)
    get_underline(p)
      => ComCall(5, this.p, VARIANT_BOOL.Ptr, p)
    get_overline(p)
      => ComCall(6, this.p, VARIANT_BOOL.Ptr, p)
    get_strikeOut(p)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, p)
    get_subScript(p)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, p)
    get_superScript(p)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, p)
    get_explicitFace(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
    get_fontWeight(p)
      => ComCall(11, this.p, Int32.Ptr, p)
    get_fontSize(p)
      => ComCall(12, this.p, Int32.Ptr, p)
    get_fontName(p)
      => ComCall(13, this.p, Int8.Ptr, p)
    get_hasBgColor(p)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, p)
    get_textColor(p)
      => ComCall(15, this.p, UInt32.Ptr, p)
    get_backgroundColor(p)
      => ComCall(16, this.p, UInt32.Ptr, p)
    get_preFormatted(p)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, p)
    get_direction(p)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, p)
    get_blockDirection(p)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, p)
    get_OL(p)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, p)
    IsEqual(pComputedStyle, pfEqual)
      => ComCall(21, this.p, IHTMLComputedStyle, pComputedStyle, VARIANT_BOOL.Ptr, pfEqual)
}
struct IDeveloperConsoleMessageReceiver extends IUnknown {
    static IID := "{30510808-98B5-11CF-BB82-00AA00BDCE0B}"
    Write(source, level, messageId, messageText)
      => ComCall(3, this.p, "Str", source, DEV_CONSOLE_MESSAGE_LEVEL, level, Int32, messageId, "Str", messageText)
    WriteWithUrl(source, level, messageId, messageText, fileUrl)
      => ComCall(4, this.p, "Str", source, DEV_CONSOLE_MESSAGE_LEVEL, level, Int32, messageId, "Str", messageText, "Str", fileUrl)
    WriteWithUrlAndLine(source, level, messageId, messageText, fileUrl, line)
      => ComCall(5, this.p, "Str", source, DEV_CONSOLE_MESSAGE_LEVEL, level, Int32, messageId, "Str", messageText, "Str", fileUrl, UInt32, line)
    WriteWithUrlLineAndColumn(source, level, messageId, messageText, fileUrl, line, column)
      => ComCall(6, this.p, "Str", source, DEV_CONSOLE_MESSAGE_LEVEL, level, Int32, messageId, "Str", messageText, "Str", fileUrl, UInt32, line, UInt32, column)
}
struct IScriptEventHandler extends IUnknown {
    static IID := "{3051083A-98B5-11CF-BB82-00AA00BDCE0B}"
    FunctionName(pbstrFunctionName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrFunctionName)
    DebugDocumentContext(ppDebugDocumentContext)
      => ComCall(4, this.p, IUnknown.Ptr, ppDebugDocumentContext)
    EventHandlerDispatch(ppDispHandler)
      => ComCall(5, this.p, IDispatch.Ptr, ppDispHandler)
    UsesCapture(pfUsesCapture)
      => ComCall(6, this.p, BOOL.Ptr, pfUsesCapture)
    Cookie(pullCookie)
      => ComCall(7, this.p, Int64.Ptr, pullCookie)
}
struct IDebugCallbackNotificationHandler extends IUnknown {
    static IID := "{30510842-98B5-11CF-BB82-00AA00BDCE0B}"
    RequestedCallbackTypes(pCallbackMask)
      => ComCall(3, this.p, UInt32.Ptr, pCallbackMask)
    BeforeDispatchEvent(pEvent)
      => ComCall(4, this.p, IUnknown, pEvent)
    DispatchEventComplete(pEvent, propagationStatus)
      => ComCall(5, this.p, IUnknown, pEvent, UInt32, propagationStatus)
    BeforeInvokeDomCallback(pEvent, pCallback, eStage, propagationStatus)
      => ComCall(6, this.p, IUnknown, pEvent, IScriptEventHandler, pCallback, DOM_EVENT_PHASE, eStage, UInt32, propagationStatus)
    InvokeDomCallbackComplete(pEvent, pCallback, eStage, propagationStatus)
      => ComCall(7, this.p, IUnknown, pEvent, IScriptEventHandler, pCallback, DOM_EVENT_PHASE, eStage, UInt32, propagationStatus)
    BeforeInvokeCallback(eCallbackType, callbackCookie, pDispHandler, ullHandlerCookie, functionName?, line, column, cchLength, pDebugDocumentContext?)
      => ComCall(8, this.p, SCRIPT_TIMER_TYPE, eCallbackType, UInt32, callbackCookie, IDispatch, pDispHandler, Int64, ullHandlerCookie, BSTR, functionName?, UInt32, line, UInt32, column, UInt32, cchLength, IUnknown, pDebugDocumentContext?)
    InvokeCallbackComplete(eCallbackType, callbackCookie, pDispHandler, ullHandlerCookie, functionName?, line, column, cchLength, pDebugDocumentContext?)
      => ComCall(9, this.p, SCRIPT_TIMER_TYPE, eCallbackType, UInt32, callbackCookie, IDispatch, pDispHandler, Int64, ullHandlerCookie, BSTR, functionName?, UInt32, line, UInt32, column, UInt32, cchLength, IUnknown, pDebugDocumentContext?)
}
struct IScriptEventHandlerSourceInfo extends IUnknown {
    static IID := "{30510841-98B5-11CF-BB82-00AA00BDCE0B}"
    GetSourceInfo(pbstrFunctionName, line, column, cchLength)
      => ComCall(3, this.p, BSTR.Ptr, pbstrFunctionName, UInt32.Ptr, line, UInt32.Ptr, column, UInt32.Ptr, cchLength)
}
struct IDOMEventRegistrationCallback extends IUnknown {
    static IID := "{3051083B-98B5-11CF-BB82-00AA00BDCE0B}"
    OnDOMEventListenerAdded(pszEventType, pHandler)
      => ComCall(3, this.p, "Str", pszEventType, IScriptEventHandler, pHandler)
    OnDOMEventListenerRemoved(ullCookie)
      => ComCall(4, this.p, Int64, ullCookie)
}
struct IEventTarget2 extends IUnknown {
    static IID := "{30510839-98B5-11CF-BB82-00AA00BDCE0B}"
    GetRegisteredEventTypes(ppEventTypeArray)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, ppEventTypeArray)
    GetListenersForType(pszEventType, ppEventHandlerArray)
      => ComCall(4, this.p, "Str", pszEventType, SAFEARRAY.Ptr.Ptr, ppEventHandlerArray)
    RegisterForDOMEventListeners(pCallback)
      => ComCall(5, this.p, IDOMEventRegistrationCallback, pCallback)
    UnregisterForDOMEventListeners(pCallback)
      => ComCall(6, this.p, IDOMEventRegistrationCallback, pCallback)
}
struct HTMLNamespaceEvents extends IDispatch {
    static IID := "{3050F6BD-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLNamespace extends IDispatch {
    static IID := "{3050F6BB-98B5-11CF-BB82-00AA00BDCE0B}"
    get_name(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    get_urn(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_tagNames(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_readyState(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_onreadystatechange(v)
      => ComCall(11, this.p, VARIANT, v)
    get_onreadystatechange(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    doImport(bstrImplementationUrl)
      => ComCall(13, this.p, BSTR, bstrImplementationUrl)
    attachEvent(event, pDisp, pfResult)
      => ComCall(14, this.p, BSTR, event, IDispatch, pDisp, VARIANT_BOOL.Ptr, pfResult)
    detachEvent(event, pDisp)
      => ComCall(15, this.p, BSTR, event, IDispatch, pDisp)
}
struct IHTMLNamespaceCollection extends IDispatch {
    static IID := "{3050F6B8-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    item(index, ppNamespace)
      => ComCall(8, this.p, VARIANT, index, IDispatch.Ptr, ppNamespace)
    add(bstrNamespace, bstrUrn, implementationUrl, ppNamespace)
      => ComCall(9, this.p, BSTR, bstrNamespace, BSTR, bstrUrn, VARIANT, implementationUrl, IDispatch.Ptr, ppNamespace)
}
struct DispHTMLNamespace extends IDispatch {
    static IID := "{3050F54F-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispHTMLNamespaceCollection extends IDispatch {
    static IID := "{3050F550-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLPainter extends IUnknown {
    static IID := "{3050F6A6-98B5-11CF-BB82-00AA00BDCE0B}"
    Draw(rcBounds, rcUpdate, lDrawFlags, hdc1, pvDrawObject)
      => ComCall(3, this.p, RECT, rcBounds, RECT, rcUpdate, Int32, lDrawFlags, HDC, hdc1, Struct.Ptr, pvDrawObject)
    OnResize(size1)
      => ComCall(4, this.p, SIZE, size1)
    GetPainterInfo(pInfo)
      => ComCall(5, this.p, HTML_PAINTER_INFO.Ptr, pInfo)
    HitTestPoint(pt, pbHit, plPartID)
      => ComCall(6, this.p, POINT, pt, BOOL.Ptr, pbHit, Int32.Ptr, plPartID)
}
struct IHTMLPaintSite extends IUnknown {
    static IID := "{3050F6A7-98B5-11CF-BB82-00AA00BDCE0B}"
    InvalidatePainterInfo()
      => ComCall(3, this.p)
    InvalidateRect(prcInvalid)
      => ComCall(4, this.p, RECT.Ptr, prcInvalid)
    InvalidateRegion(rgnInvalid)
      => ComCall(5, this.p, HRGN, rgnInvalid)
    GetDrawInfo(lFlags, pDrawInfo)
      => ComCall(6, this.p, Int32, lFlags, HTML_PAINT_DRAW_INFO.Ptr, pDrawInfo)
    TransformGlobalToLocal(ptGlobal, pptLocal)
      => ComCall(7, this.p, POINT, ptGlobal, POINT.Ptr, pptLocal)
    TransformLocalToGlobal(ptLocal, pptGlobal)
      => ComCall(8, this.p, POINT, ptLocal, POINT.Ptr, pptGlobal)
    GetHitTestCookie(plCookie)
      => ComCall(9, this.p, Int32.Ptr, plCookie)
}
struct IHTMLPainterEventInfo extends IUnknown {
    static IID := "{3050F6DF-98B5-11CF-BB82-00AA00BDCE0B}"
    GetEventInfoFlags(plEventInfoFlags)
      => ComCall(3, this.p, Int32.Ptr, plEventInfoFlags)
    GetEventTarget(ppElement)
      => ComCall(4, this.p, IHTMLElement.Ptr, ppElement)
    SetCursor(lPartID)
      => ComCall(5, this.p, Int32, lPartID)
    StringFromPartID(lPartID, pbstrPart)
      => ComCall(6, this.p, Int32, lPartID, BSTR.Ptr, pbstrPart)
}
struct IHTMLPainterOverlay extends IUnknown {
    static IID := "{3050F7E3-98B5-11CF-BB82-00AA00BDCE0B}"
    OnMove(rcDevice)
      => ComCall(3, this.p, RECT, rcDevice)
}
struct IHTMLIPrintCollection extends IDispatch {
    static IID := "{3050F6B5-98B5-11CF-BB82-00AA00BDCE0B}"
    get_length(p)
      => ComCall(7, this.p, Int32.Ptr, p)
    get__newEnum(p)
      => ComCall(8, this.p, IUnknown.Ptr, p)
    item(index, ppIPrint)
      => ComCall(9, this.p, Int32, index, IUnknown.Ptr, ppIPrint)
}
struct IEnumPrivacyRecords extends IUnknown {
    static IID := "{3050F844-98B5-11CF-BB82-00AA00BDCE0B}"
    Reset()
      => ComCall(3, this.p)
    GetSize(pSize)
      => ComCall(4, this.p, UInt32.Ptr, pSize)
    GetPrivacyImpacted(pState)
      => ComCall(5, this.p, BOOL.Ptr, pState)
    Next(pbstrUrl, pbstrPolicyRef, pdwReserved, pdwPrivacyFlags)
      => ComCall(6, this.p, BSTR.Ptr, pbstrUrl, BSTR.Ptr, pbstrPolicyRef, Int32.Ptr, pdwReserved, UInt32.Ptr, pdwPrivacyFlags)
}
struct IWPCBlockedUrls extends IUnknown {
    static IID := "{30510413-98B5-11CF-BB82-00AA00BDCE0B}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    GetUrl(dwIdx, pbstrUrl)
      => ComCall(4, this.p, UInt32, dwIdx, BSTR.Ptr, pbstrUrl)
}
struct IHTMLDOMConstructorCollection extends IDispatch {
    static IID := "{3051049C-98B5-11CF-BB82-00AA00BDCE0B}"
    get_Attr(p)
      => ComCall(7, this.p, IDispatch.Ptr, p)
    get_BehaviorUrnsCollection(p)
      => ComCall(8, this.p, IDispatch.Ptr, p)
    get_BookmarkCollection(p)
      => ComCall(9, this.p, IDispatch.Ptr, p)
    get_CompatibleInfo(p)
      => ComCall(10, this.p, IDispatch.Ptr, p)
    get_CompatibleInfoCollection(p)
      => ComCall(11, this.p, IDispatch.Ptr, p)
    get_ControlRangeCollection(p)
      => ComCall(12, this.p, IDispatch.Ptr, p)
    get_CSSCurrentStyleDeclaration(p)
      => ComCall(13, this.p, IDispatch.Ptr, p)
    get_CSSRuleList(p)
      => ComCall(14, this.p, IDispatch.Ptr, p)
    get_CSSRuleStyleDeclaration(p)
      => ComCall(15, this.p, IDispatch.Ptr, p)
    get_CSSStyleDeclaration(p)
      => ComCall(16, this.p, IDispatch.Ptr, p)
    get_CSSStyleRule(p)
      => ComCall(17, this.p, IDispatch.Ptr, p)
    get_CSSStyleSheet(p)
      => ComCall(18, this.p, IDispatch.Ptr, p)
    get_DataTransfer(p)
      => ComCall(19, this.p, IDispatch.Ptr, p)
    get_DOMImplementation(p)
      => ComCall(20, this.p, IDispatch.Ptr, p)
    get_Element(p)
      => ComCall(21, this.p, IDispatch.Ptr, p)
    get_Event(p)
      => ComCall(22, this.p, IDispatch.Ptr, p)
    get_History(p)
      => ComCall(23, this.p, IDispatch.Ptr, p)
    get_HTCElementBehaviorDefaults(p)
      => ComCall(24, this.p, IDispatch.Ptr, p)
    get_HTMLAnchorElement(p)
      => ComCall(25, this.p, IDispatch.Ptr, p)
    get_HTMLAreaElement(p)
      => ComCall(26, this.p, IDispatch.Ptr, p)
    get_HTMLAreasCollection(p)
      => ComCall(27, this.p, IDispatch.Ptr, p)
    get_HTMLBaseElement(p)
      => ComCall(28, this.p, IDispatch.Ptr, p)
    get_HTMLBaseFontElement(p)
      => ComCall(29, this.p, IDispatch.Ptr, p)
    get_HTMLBGSoundElement(p)
      => ComCall(30, this.p, IDispatch.Ptr, p)
    get_HTMLBlockElement(p)
      => ComCall(31, this.p, IDispatch.Ptr, p)
    get_HTMLBodyElement(p)
      => ComCall(32, this.p, IDispatch.Ptr, p)
    get_HTMLBRElement(p)
      => ComCall(33, this.p, IDispatch.Ptr, p)
    get_HTMLButtonElement(p)
      => ComCall(34, this.p, IDispatch.Ptr, p)
    get_HTMLCollection(p)
      => ComCall(35, this.p, IDispatch.Ptr, p)
    get_HTMLCommentElement(p)
      => ComCall(36, this.p, IDispatch.Ptr, p)
    get_HTMLDDElement(p)
      => ComCall(37, this.p, IDispatch.Ptr, p)
    get_HTMLDivElement(p)
      => ComCall(38, this.p, IDispatch.Ptr, p)
    get_HTMLDocument(p)
      => ComCall(39, this.p, IDispatch.Ptr, p)
    get_HTMLDListElement(p)
      => ComCall(40, this.p, IDispatch.Ptr, p)
    get_HTMLDTElement(p)
      => ComCall(41, this.p, IDispatch.Ptr, p)
    get_HTMLEmbedElement(p)
      => ComCall(42, this.p, IDispatch.Ptr, p)
    get_HTMLFieldSetElement(p)
      => ComCall(43, this.p, IDispatch.Ptr, p)
    get_HTMLFontElement(p)
      => ComCall(44, this.p, IDispatch.Ptr, p)
    get_HTMLFormElement(p)
      => ComCall(45, this.p, IDispatch.Ptr, p)
    get_HTMLFrameElement(p)
      => ComCall(46, this.p, IDispatch.Ptr, p)
    get_HTMLFrameSetElement(p)
      => ComCall(47, this.p, IDispatch.Ptr, p)
    get_HTMLGenericElement(p)
      => ComCall(48, this.p, IDispatch.Ptr, p)
    get_HTMLHeadElement(p)
      => ComCall(49, this.p, IDispatch.Ptr, p)
    get_HTMLHeadingElement(p)
      => ComCall(50, this.p, IDispatch.Ptr, p)
    get_HTMLHRElement(p)
      => ComCall(51, this.p, IDispatch.Ptr, p)
    get_HTMLHtmlElement(p)
      => ComCall(52, this.p, IDispatch.Ptr, p)
    get_HTMLIFrameElement(p)
      => ComCall(53, this.p, IDispatch.Ptr, p)
    get_HTMLImageElement(p)
      => ComCall(54, this.p, IDispatch.Ptr, p)
    get_HTMLInputElement(p)
      => ComCall(55, this.p, IDispatch.Ptr, p)
    get_HTMLIsIndexElement(p)
      => ComCall(56, this.p, IDispatch.Ptr, p)
    get_HTMLLabelElement(p)
      => ComCall(57, this.p, IDispatch.Ptr, p)
    get_HTMLLegendElement(p)
      => ComCall(58, this.p, IDispatch.Ptr, p)
    get_HTMLLIElement(p)
      => ComCall(59, this.p, IDispatch.Ptr, p)
    get_HTMLLinkElement(p)
      => ComCall(60, this.p, IDispatch.Ptr, p)
    get_HTMLMapElement(p)
      => ComCall(61, this.p, IDispatch.Ptr, p)
    get_HTMLMarqueeElement(p)
      => ComCall(62, this.p, IDispatch.Ptr, p)
    get_HTMLMetaElement(p)
      => ComCall(63, this.p, IDispatch.Ptr, p)
    get_HTMLModelessDialog(p)
      => ComCall(64, this.p, IDispatch.Ptr, p)
    get_HTMLNamespaceInfo(p)
      => ComCall(65, this.p, IDispatch.Ptr, p)
    get_HTMLNamespaceInfoCollection(p)
      => ComCall(66, this.p, IDispatch.Ptr, p)
    get_HTMLNextIdElement(p)
      => ComCall(67, this.p, IDispatch.Ptr, p)
    get_HTMLNoShowElement(p)
      => ComCall(68, this.p, IDispatch.Ptr, p)
    get_HTMLObjectElement(p)
      => ComCall(69, this.p, IDispatch.Ptr, p)
    get_HTMLOListElement(p)
      => ComCall(70, this.p, IDispatch.Ptr, p)
    get_HTMLOptionElement(p)
      => ComCall(71, this.p, IDispatch.Ptr, p)
    get_HTMLParagraphElement(p)
      => ComCall(72, this.p, IDispatch.Ptr, p)
    get_HTMLParamElement(p)
      => ComCall(73, this.p, IDispatch.Ptr, p)
    get_HTMLPhraseElement(p)
      => ComCall(74, this.p, IDispatch.Ptr, p)
    get_HTMLPluginsCollection(p)
      => ComCall(75, this.p, IDispatch.Ptr, p)
    get_HTMLPopup(p)
      => ComCall(76, this.p, IDispatch.Ptr, p)
    get_HTMLScriptElement(p)
      => ComCall(77, this.p, IDispatch.Ptr, p)
    get_HTMLSelectElement(p)
      => ComCall(78, this.p, IDispatch.Ptr, p)
    get_HTMLSpanElement(p)
      => ComCall(79, this.p, IDispatch.Ptr, p)
    get_HTMLStyleElement(p)
      => ComCall(80, this.p, IDispatch.Ptr, p)
    get_HTMLTableCaptionElement(p)
      => ComCall(81, this.p, IDispatch.Ptr, p)
    get_HTMLTableCellElement(p)
      => ComCall(82, this.p, IDispatch.Ptr, p)
    get_HTMLTableColElement(p)
      => ComCall(83, this.p, IDispatch.Ptr, p)
    get_HTMLTableElement(p)
      => ComCall(84, this.p, IDispatch.Ptr, p)
    get_HTMLTableRowElement(p)
      => ComCall(85, this.p, IDispatch.Ptr, p)
    get_HTMLTableSectionElement(p)
      => ComCall(86, this.p, IDispatch.Ptr, p)
    get_HTMLTextAreaElement(p)
      => ComCall(87, this.p, IDispatch.Ptr, p)
    get_HTMLTextElement(p)
      => ComCall(88, this.p, IDispatch.Ptr, p)
    get_HTMLTitleElement(p)
      => ComCall(89, this.p, IDispatch.Ptr, p)
    get_HTMLUListElement(p)
      => ComCall(90, this.p, IDispatch.Ptr, p)
    get_HTMLUnknownElement(p)
      => ComCall(91, this.p, IDispatch.Ptr, p)
    get_Image(p)
      => ComCall(92, this.p, IDispatch.Ptr, p)
    get_Location(p)
      => ComCall(93, this.p, IDispatch.Ptr, p)
    get_NamedNodeMap(p)
      => ComCall(94, this.p, IDispatch.Ptr, p)
    get_Navigator(p)
      => ComCall(95, this.p, IDispatch.Ptr, p)
    get_NodeList(p)
      => ComCall(96, this.p, IDispatch.Ptr, p)
    get_Option(p)
      => ComCall(97, this.p, IDispatch.Ptr, p)
    get_Screen(p)
      => ComCall(98, this.p, IDispatch.Ptr, p)
    get_Selection(p)
      => ComCall(99, this.p, IDispatch.Ptr, p)
    get_StaticNodeList(p)
      => ComCall(100, this.p, IDispatch.Ptr, p)
    get_Storage(p)
      => ComCall(101, this.p, IDispatch.Ptr, p)
    get_StyleSheetList(p)
      => ComCall(102, this.p, IDispatch.Ptr, p)
    get_StyleSheetPage(p)
      => ComCall(103, this.p, IDispatch.Ptr, p)
    get_StyleSheetPageList(p)
      => ComCall(104, this.p, IDispatch.Ptr, p)
    get_Text(p)
      => ComCall(105, this.p, IDispatch.Ptr, p)
    get_TextRange(p)
      => ComCall(106, this.p, IDispatch.Ptr, p)
    get_TextRangeCollection(p)
      => ComCall(107, this.p, IDispatch.Ptr, p)
    get_TextRectangle(p)
      => ComCall(108, this.p, IDispatch.Ptr, p)
    get_TextRectangleList(p)
      => ComCall(109, this.p, IDispatch.Ptr, p)
    get_Window(p)
      => ComCall(110, this.p, IDispatch.Ptr, p)
    get_XDomainRequest(p)
      => ComCall(111, this.p, IDispatch.Ptr, p)
    get_XMLHttpRequest(p)
      => ComCall(112, this.p, IDispatch.Ptr, p)
}
struct IHTMLDialog extends IDispatch {
    static IID := "{3050F216-98B5-11CF-BB82-00AA00BDCE0B}"
    put_dialogTop(v)
      => ComCall(7, this.p, VARIANT, v)
    get_dialogTop(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    put_dialogLeft(v)
      => ComCall(9, this.p, VARIANT, v)
    get_dialogLeft(p)
      => ComCall(10, this.p, VARIANT.Ptr, p)
    put_dialogWidth(v)
      => ComCall(11, this.p, VARIANT, v)
    get_dialogWidth(p)
      => ComCall(12, this.p, VARIANT.Ptr, p)
    put_dialogHeight(v)
      => ComCall(13, this.p, VARIANT, v)
    get_dialogHeight(p)
      => ComCall(14, this.p, VARIANT.Ptr, p)
    get_dialogArguments(p)
      => ComCall(15, this.p, VARIANT.Ptr, p)
    get_menuArguments(p)
      => ComCall(16, this.p, VARIANT.Ptr, p)
    put_returnValue(v)
      => ComCall(17, this.p, VARIANT, v)
    get_returnValue(p)
      => ComCall(18, this.p, VARIANT.Ptr, p)
    close()
      => ComCall(19, this.p)
    toString(String)
      => ComCall(20, this.p, BSTR.Ptr, String)
}
struct IHTMLDialog2 extends IDispatch {
    static IID := "{3050F5E0-98B5-11CF-BB82-00AA00BDCE0B}"
    put_status(v)
      => ComCall(7, this.p, BSTR, v)
    get_status(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_resizable(v)
      => ComCall(9, this.p, BSTR, v)
    get_resizable(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLDialog3 extends IDispatch {
    static IID := "{3050F388-98B5-11CF-BB82-00AA00BDCE0B}"
    put_unadorned(v)
      => ComCall(7, this.p, BSTR, v)
    get_unadorned(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_dialogHide(v)
      => ComCall(9, this.p, BSTR, v)
    get_dialogHide(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
}
struct IHTMLModelessInit extends IDispatch {
    static IID := "{3050F5E4-98B5-11CF-BB82-00AA00BDCE0B}"
    get_parameters(p)
      => ComCall(7, this.p, VARIANT.Ptr, p)
    get_optionString(p)
      => ComCall(8, this.p, VARIANT.Ptr, p)
    get_moniker(p)
      => ComCall(9, this.p, IUnknown.Ptr, p)
    get_document(p)
      => ComCall(10, this.p, IUnknown.Ptr, p)
}
struct IHTMLPopup extends IDispatch {
    static IID := "{3050F666-98B5-11CF-BB82-00AA00BDCE0B}"
    show(x, y, w, h, pElement)
      => ComCall(7, this.p, Int32, x, Int32, y, Int32, w, Int32, h, VARIANT.Ptr, pElement)
    hide()
      => ComCall(8, this.p)
    get_document(p)
      => ComCall(9, this.p, IHTMLDocument.Ptr, p)
    get_isOpen(p)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, p)
}
struct DispHTMLPopup extends IDispatch {
    static IID := "{3050F589-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IHTMLAppBehavior extends IDispatch {
    static IID := "{3050F5CA-98B5-11CF-BB82-00AA00BDCE0B}"
    put_applicationName(v)
      => ComCall(7, this.p, BSTR, v)
    get_applicationName(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_version(v)
      => ComCall(9, this.p, BSTR, v)
    get_version(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_icon(v)
      => ComCall(11, this.p, BSTR, v)
    get_icon(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_singleInstance(v)
      => ComCall(13, this.p, BSTR, v)
    get_singleInstance(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_minimizeButton(v)
      => ComCall(15, this.p, BSTR, v)
    get_minimizeButton(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
    put_maximizeButton(v)
      => ComCall(17, this.p, BSTR, v)
    get_maximizeButton(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    put_border(v)
      => ComCall(19, this.p, BSTR, v)
    get_border(p)
      => ComCall(20, this.p, BSTR.Ptr, p)
    put_borderStyle(v)
      => ComCall(21, this.p, BSTR, v)
    get_borderStyle(p)
      => ComCall(22, this.p, BSTR.Ptr, p)
    put_sysMenu(v)
      => ComCall(23, this.p, BSTR, v)
    get_sysMenu(p)
      => ComCall(24, this.p, BSTR.Ptr, p)
    put_caption(v)
      => ComCall(25, this.p, BSTR, v)
    get_caption(p)
      => ComCall(26, this.p, BSTR.Ptr, p)
    put_windowState(v)
      => ComCall(27, this.p, BSTR, v)
    get_windowState(p)
      => ComCall(28, this.p, BSTR.Ptr, p)
    put_showInTaskBar(v)
      => ComCall(29, this.p, BSTR, v)
    get_showInTaskBar(p)
      => ComCall(30, this.p, BSTR.Ptr, p)
    get_commandLine(p)
      => ComCall(31, this.p, BSTR.Ptr, p)
}
struct IHTMLAppBehavior2 extends IDispatch {
    static IID := "{3050F5C9-98B5-11CF-BB82-00AA00BDCE0B}"
    put_contextMenu(v)
      => ComCall(7, this.p, BSTR, v)
    get_contextMenu(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    put_innerBorder(v)
      => ComCall(9, this.p, BSTR, v)
    get_innerBorder(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    put_scroll(v)
      => ComCall(11, this.p, BSTR, v)
    get_scroll(p)
      => ComCall(12, this.p, BSTR.Ptr, p)
    put_scrollFlat(v)
      => ComCall(13, this.p, BSTR, v)
    get_scrollFlat(p)
      => ComCall(14, this.p, BSTR.Ptr, p)
    put_selection(v)
      => ComCall(15, this.p, BSTR, v)
    get_selection(p)
      => ComCall(16, this.p, BSTR.Ptr, p)
}
struct IHTMLAppBehavior3 extends IDispatch {
    static IID := "{3050F5CD-98B5-11CF-BB82-00AA00BDCE0B}"
    put_navigable(v)
      => ComCall(7, this.p, BSTR, v)
    get_navigable(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
}
struct DispHTMLAppBehavior extends IDispatch {
    static IID := "{3050F57C-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispIHTMLInputButtonElement extends IDispatch {
    static IID := "{3050F51E-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispIHTMLInputTextElement extends IDispatch {
    static IID := "{3050F520-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispIHTMLInputFileElement extends IDispatch {
    static IID := "{3050F542-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispIHTMLOptionButtonElement extends IDispatch {
    static IID := "{3050F509-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct DispIHTMLInputImage extends IDispatch {
    static IID := "{3050F51D-98B5-11CF-BB82-00AA00BDCE0B}"
}
struct IElementNamespace extends IUnknown {
    static IID := "{3050F671-98B5-11CF-BB82-00AA00BDCE0B}"
    AddTag(bstrTagName, lFlags)
      => ComCall(3, this.p, BSTR, bstrTagName, Int32, lFlags)
}
struct IElementNamespaceTable extends IUnknown {
    static IID := "{3050F670-98B5-11CF-BB82-00AA00BDCE0B}"
    AddNamespace(bstrNamespace, bstrUrn, lFlags, pvarFactory)
      => ComCall(3, this.p, BSTR, bstrNamespace, BSTR, bstrUrn, Int32, lFlags, VARIANT.Ptr, pvarFactory)
}
struct IElementNamespaceFactory extends IUnknown {
    static IID := "{3050F672-98B5-11CF-BB82-00AA00BDCE0B}"
    Create(pNamespace)
      => ComCall(3, this.p, IElementNamespace, pNamespace)
}
struct IElementNamespaceFactory2 extends IElementNamespaceFactory {
    static IID := "{3050F805-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateWithImplementation(pNamespace, bstrImplementation)
      => ComCall(4, this.p, IElementNamespace, pNamespace, BSTR, bstrImplementation)
}
struct IElementNamespaceFactoryCallback extends IUnknown {
    static IID := "{3050F7FD-98B5-11CF-BB82-00AA00BDCE0B}"
    Resolve(bstrNamespace, bstrTagName, bstrAttrs, pNamespace)
      => ComCall(3, this.p, BSTR, bstrNamespace, BSTR, bstrTagName, BSTR, bstrAttrs, IElementNamespace, pNamespace)
}
struct IElementBehaviorSiteOM2 extends IElementBehaviorSiteOM {
    static IID := "{3050F659-98B5-11CF-BB82-00AA00BDCE0B}"
    GetDefaults(ppDefaults)
      => ComCall(9, this.p, IHTMLElementDefaults.Ptr, ppDefaults)
}
struct IElementBehaviorCategory extends IUnknown {
    static IID := "{3050F4ED-98B5-11CF-BB82-00AA00BDCE0B}"
    GetCategory(ppchCategory)
      => ComCall(3, this.p, PWSTR.Ptr, ppchCategory)
}
struct IElementBehaviorSiteCategory extends IUnknown {
    static IID := "{3050F4EE-98B5-11CF-BB82-00AA00BDCE0B}"
    GetRelatedBehaviors(lDirection, pchCategory, ppEnumerator)
      => ComCall(3, this.p, Int32, lDirection, "Str", pchCategory, IEnumUnknown.Ptr, ppEnumerator)
}
struct IElementBehaviorSubmit extends IUnknown {
    static IID := "{3050F646-98B5-11CF-BB82-00AA00BDCE0B}"
    GetSubmitInfo(pSubmitData)
      => ComCall(3, this.p, IHTMLSubmitData, pSubmitData)
    Reset()
      => ComCall(4, this.p)
}
struct IElementBehaviorFocus extends IUnknown {
    static IID := "{3050F6B6-98B5-11CF-BB82-00AA00BDCE0B}"
    GetFocusRect(pRect)
      => ComCall(3, this.p, RECT.Ptr, pRect)
}
struct IElementBehaviorLayout extends IUnknown {
    static IID := "{3050F6BA-98B5-11CF-BB82-00AA00BDCE0B}"
    GetSize(dwFlags, sizeContent, pptTranslateBy, pptTopLeft, psizeProposed)
      => ComCall(3, this.p, Int32, dwFlags, SIZE, sizeContent, POINT.Ptr, pptTranslateBy, POINT.Ptr, pptTopLeft, SIZE.Ptr, psizeProposed)
    GetLayoutInfo(plLayoutInfo)
      => ComCall(4, this.p, Int32.Ptr, plLayoutInfo)
    GetPosition(lFlags, pptTopLeft)
      => ComCall(5, this.p, Int32, lFlags, POINT.Ptr, pptTopLeft)
    MapSize(psizeIn, prcOut)
      => ComCall(6, this.p, SIZE.Ptr, psizeIn, RECT.Ptr, prcOut)
}
struct IElementBehaviorLayout2 extends IUnknown {
    static IID := "{3050F846-98B5-11CF-BB82-00AA00BDCE0B}"
    GetTextDescent(plDescent)
      => ComCall(3, this.p, Int32.Ptr, plDescent)
}
struct IElementBehaviorSiteLayout extends IUnknown {
    static IID := "{3050F6B7-98B5-11CF-BB82-00AA00BDCE0B}"
    InvalidateLayoutInfo()
      => ComCall(3, this.p)
    InvalidateSize()
      => ComCall(4, this.p)
    GetMediaResolution(psizeResolution)
      => ComCall(5, this.p, SIZE.Ptr, psizeResolution)
}
struct IElementBehaviorSiteLayout2 extends IUnknown {
    static IID := "{3050F847-98B5-11CF-BB82-00AA00BDCE0B}"
    GetFontInfo(plf)
      => ComCall(3, this.p, LOGFONTW.Ptr, plf)
}
struct IHostBehaviorInit extends IUnknown {
    static IID := "{3050F842-98B5-11CF-BB82-00AA00BDCE0B}"
    PopulateNamespaceTable()
      => ComCall(3, this.p)
}
struct ISurfacePresenter extends IUnknown {
    static IID := "{305106E2-98B5-11CF-BB82-00AA00BDCE0B}"
    Present(uBuffer, pDirty)
      => ComCall(3, this.p, UInt32, uBuffer, RECT.Ptr, pDirty)
    GetBuffer(backBufferIndex, riid, ppBuffer)
      => ComCall(4, this.p, UInt32, backBufferIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppBuffer)
    IsCurrent(pIsCurrent)
      => ComCall(5, this.p, BOOL.Ptr, pIsCurrent)
}
struct IViewObjectPresentSite extends IUnknown {
    static IID := "{305106E1-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateSurfacePresenter(pDevice, width, height, backBufferCount, format, mode, ppQueue)
      => ComCall(3, this.p, IUnknown, pDevice, UInt32, width, UInt32, height, UInt32, backBufferCount, DXGI_FORMAT, format, VIEW_OBJECT_ALPHA_MODE, mode, ISurfacePresenter.Ptr, ppQueue)
    IsHardwareComposition(pIsHardwareComposition)
      => ComCall(4, this.p, BOOL.Ptr, pIsHardwareComposition)
    SetCompositionMode(mode)
      => ComCall(5, this.p, VIEW_OBJECT_COMPOSITION_MODE, mode)
}
struct ICanvasPixelArrayData extends IUnknown {
    static IID := "{305107F9-98B5-11CF-BB82-00AA00BDCE0B}"
    GetBufferPointer(ppBuffer, pBufferLength)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppBuffer, UInt32.Ptr, pBufferLength)
}
struct IViewObjectPrint extends IUnknown {
    static IID := "{305106E3-98B5-11CF-BB82-00AA00BDCE0B}"
    GetPrintBitmap(ppPrintBitmap)
      => ComCall(3, this.p, IUnknown.Ptr, ppPrintBitmap)
}
struct IViewObjectPresentNotifySite extends IViewObjectPresentSite {
    static IID := "{305107FA-98B5-11CF-BB82-00AA00BDCE0B}"
    RequestFrame()
      => ComCall(6, this.p)
}
struct IViewObjectPresentNotify extends IUnknown {
    static IID := "{305107F8-98B5-11CF-BB82-00AA00BDCE0B}"
    OnPreRender()
      => ComCall(3, this.p)
}
struct ITrackingProtection extends IUnknown {
    static IID := "{30510803-98B5-11CF-BB82-00AA00BDCE0B}"
    EvaluateUrl(bstrUrl, pfAllowed)
      => ComCall(3, this.p, BSTR, bstrUrl, BOOL.Ptr, pfAllowed)
    GetEnabled(pfEnabled)
      => ComCall(4, this.p, BOOL.Ptr, pfEnabled)
}
struct IBFCacheable extends IUnknown {
    static IID := "{30510861-98B5-11CF-BB82-00AA00BDCE0B}"
    EnterBFCache()
      => ComCall(3, this.p)
    ExitBFCache()
      => ComCall(4, this.p)
}
struct SHOWHTMLDIALOGFN extends FunctionPointer {
    static Types := [HWND, IMoniker, VARIANT.Ptr, PWSTR, VARIANT.Ptr, HRESULT]
}
struct SHOWHTMLDIALOGEXFN extends FunctionPointer {
    static Types := [HWND, IMoniker, UInt32, VARIANT.Ptr, PWSTR, VARIANT.Ptr, HRESULT]
}
struct SHOWMODELESSHTMLDIALOGFN extends FunctionPointer {
    static Types := [HWND, IMoniker, VARIANT.Ptr, VARIANT.Ptr, IHTMLWindow2.Ptr, HRESULT]
}
struct IEREGISTERXMLNSFN extends FunctionPointer {
    static Types := [PWSTR, GUID, BOOL, HRESULT]
}
struct IEISXMLNSREGISTEREDFN extends FunctionPointer {
    static Types := [PWSTR, GUID.Ptr, HRESULT]
}
struct IHostDialogHelper extends IUnknown {
    static IID := "{53DEC138-A51E-11D2-861E-00C04FA35C89}"
    ShowHTMLDialog(hwndParent, pMk, pvarArgIn, pchOptions, pvarArgOut, punkHost)
      => ComCall(3, this.p, HWND, hwndParent, IMoniker, pMk, VARIANT.Ptr, pvarArgIn, "Str", pchOptions, VARIANT.Ptr, pvarArgOut, IUnknown, punkHost)
}
struct DOCHOSTUITYPE extends Int32 {
    static DOCHOSTUITYPE_BROWSE := 0
    static DOCHOSTUITYPE_AUTHOR := 1
}
struct DOCHOSTUIDBLCLK extends Int32 {
    static DOCHOSTUIDBLCLK_DEFAULT := 0
    static DOCHOSTUIDBLCLK_SHOWPROPERTIES := 1
    static DOCHOSTUIDBLCLK_SHOWCODE := 2
}
struct DOCHOSTUIFLAG extends Int32 {
    static DOCHOSTUIFLAG_DIALOG := 1
    static DOCHOSTUIFLAG_DISABLE_HELP_MENU := 2
    static DOCHOSTUIFLAG_NO3DBORDER := 4
    static DOCHOSTUIFLAG_SCROLL_NO := 8
    static DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE := 16
    static DOCHOSTUIFLAG_OPENNEWWIN := 32
    static DOCHOSTUIFLAG_DISABLE_OFFSCREEN := 64
    static DOCHOSTUIFLAG_FLAT_SCROLLBAR := 128
    static DOCHOSTUIFLAG_DIV_BLOCKDEFAULT := 256
    static DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY := 512
    static DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY := 1024
    static DOCHOSTUIFLAG_CODEPAGELINKEDFONTS := 2048
    static DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8 := 4096
    static DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8 := 8192
    static DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE := 16384
    static DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION := 65536
    static DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION := 131072
    static DOCHOSTUIFLAG_THEME := 262144
    static DOCHOSTUIFLAG_NOTHEME := 524288
    static DOCHOSTUIFLAG_NOPICS := 1048576
    static DOCHOSTUIFLAG_NO3DOUTERBORDER := 2097152
    static DOCHOSTUIFLAG_DISABLE_EDIT_NS_FIXUP := 4194304
    static DOCHOSTUIFLAG_LOCAL_MACHINE_ACCESS_CHECK := 8388608
    static DOCHOSTUIFLAG_DISABLE_UNTRUSTEDPROTOCOL := 16777216
    static DOCHOSTUIFLAG_HOST_NAVIGATES := 33554432
    static DOCHOSTUIFLAG_ENABLE_REDIRECT_NOTIFICATION := 67108864
    static DOCHOSTUIFLAG_USE_WINDOWLESS_SELECTCONTROL := 134217728
    static DOCHOSTUIFLAG_USE_WINDOWED_SELECTCONTROL := 268435456
    static DOCHOSTUIFLAG_ENABLE_ACTIVEX_INACTIVATE_MODE := 536870912
    static DOCHOSTUIFLAG_DPI_AWARE := 1073741824
}
struct DOCHOSTUIINFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwDoubleClick : UInt32
    pchHostCss : PWSTR
    pchHostNS : PWSTR
}
struct IDocHostUIHandler extends IUnknown {
    static IID := "{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}"
    ShowContextMenu(dwID, ppt, pcmdtReserved, pdispReserved)
      => ComCall(3, this.p, UInt32, dwID, POINT.Ptr, ppt, IUnknown, pcmdtReserved, IDispatch, pdispReserved)
    GetHostInfo(pInfo)
      => ComCall(4, this.p, DOCHOSTUIINFO.Ptr, pInfo)
    ShowUI(dwID, pActiveObject, pCommandTarget, pFrame, pDoc)
      => ComCall(5, this.p, UInt32, dwID, IOleInPlaceActiveObject, pActiveObject, IOleCommandTarget, pCommandTarget, IOleInPlaceFrame, pFrame, IOleInPlaceUIWindow, pDoc)
    HideUI()
      => ComCall(6, this.p)
    UpdateUI()
      => ComCall(7, this.p)
    EnableModeless(fEnable)
      => ComCall(8, this.p, BOOL, fEnable)
    OnDocWindowActivate(fActivate)
      => ComCall(9, this.p, BOOL, fActivate)
    OnFrameWindowActivate(fActivate)
      => ComCall(10, this.p, BOOL, fActivate)
    ResizeBorder(prcBorder, pUIWindow, fRameWindow)
      => ComCall(11, this.p, RECT.Ptr, prcBorder, IOleInPlaceUIWindow, pUIWindow, BOOL, fRameWindow)
    TranslateAccelerator(lpMsg, pguidCmdGroup, nCmdID)
      => ComCall(12, this.p, MSG.Ptr, lpMsg, GUID.Ptr, pguidCmdGroup, UInt32, nCmdID)
    GetOptionKeyPath(pchKey, dw)
      => ComCall(13, this.p, PWSTR.Ptr, pchKey, UInt32, dw)
    GetDropTarget(pDropTarget, ppDropTarget)
      => ComCall(14, this.p, IDropTarget, pDropTarget, IDropTarget.Ptr, ppDropTarget)
    GetExternal(ppDispatch)
      => ComCall(15, this.p, IDispatch.Ptr, ppDispatch)
    TranslateUrl(dwTranslate, pchURLIn, ppchURLOut)
      => ComCall(16, this.p, UInt32, dwTranslate, "Str", pchURLIn, PWSTR.Ptr, ppchURLOut)
    FilterDataObject(pDO, ppDORet)
      => ComCall(17, this.p, IDataObject, pDO, IDataObject.Ptr, ppDORet)
}
struct IDocHostUIHandler2 extends IDocHostUIHandler {
    static IID := "{3050F6D0-98B5-11CF-BB82-00AA00BDCE0B}"
    GetOverrideKeyPath(pchKey, dw)
      => ComCall(18, this.p, PWSTR.Ptr, pchKey, UInt32, dw)
}
struct ICustomDoc extends IUnknown {
    static IID := "{3050F3F0-98B5-11CF-BB82-00AA00BDCE0B}"
    SetUIHandler(pUIHandler)
      => ComCall(3, this.p, IDocHostUIHandler, pUIHandler)
}
struct IDocHostShowUI extends IUnknown {
    static IID := "{C4D244B0-D43E-11CF-893B-00AA00BDCE1A}"
    ShowMessage(hwnd1, lpstrText, lpstrCaption, dwType, lpstrHelpFile, dwHelpContext, plResult)
      => ComCall(3, this.p, HWND, hwnd1, "Str", lpstrText, "Str", lpstrCaption, UInt32, dwType, "Str", lpstrHelpFile, UInt32, dwHelpContext, LRESULT.Ptr, plResult)
    ShowHelp(hwnd1, pszHelpFile, uCommand, dwData, ptMouse, pDispatchObjectHit)
      => ComCall(4, this.p, HWND, hwnd1, "Str", pszHelpFile, UInt32, uCommand, UInt32, dwData, POINT, ptMouse, IDispatch, pDispatchObjectHit)
}
struct IClassFactoryEx extends IClassFactory {
    static IID := "{342D1EA0-AE25-11D1-89C5-006008C3FBFC}"
    CreateInstanceWithContext(punkContext, punkOuter, riid, ppv)
      => ComCall(5, this.p, IUnknown, punkContext, IUnknown, punkOuter, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IHTMLOMWindowServices extends IUnknown {
    static IID := "{3050F5FC-98B5-11CF-BB82-00AA00BDCE0B}"
    moveTo(x, y)
      => ComCall(3, this.p, Int32, x, Int32, y)
    moveBy(x, y)
      => ComCall(4, this.p, Int32, x, Int32, y)
    resizeTo(x, y)
      => ComCall(5, this.p, Int32, x, Int32, y)
    resizeBy(x, y)
      => ComCall(6, this.p, Int32, x, Int32, y)
}
struct IDiagnosticsScriptEngineSite extends IUnknown {
    static IID := "{30510858-98B5-11CF-BB82-00AA00BDCE0B}"
    OnMessage(pszData)
      => ComCall(3, this.p, PWSTR.Ptr, pszData, UInt32, pszData.Length)
    OnScriptError(pScriptError)
      => ComCall(4, this.p, IActiveScriptError, pScriptError)
}
struct IDiagnosticsScriptEngine extends IUnknown {
    static IID := "{30510859-98B5-11CF-BB82-00AA00BDCE0B}"
    EvaluateScript(pszScript, pszScriptName)
      => ComCall(3, this.p, "Str", pszScript, "Str", pszScriptName)
    FireScriptMessageEvent(pszNames, pszValues)
      => ComCall(4, this.p, PWSTR.Ptr, pszNames, PWSTR.Ptr, pszValues, UInt32, pszValues.Length)
    Detach()
      => ComCall(5, this.p)
}
struct IDiagnosticsScriptEngineProvider extends IUnknown {
    static IID := "{3051085A-98B5-11CF-BB82-00AA00BDCE0B}"
    CreateDiagnosticsScriptEngine(pScriptSite?, fDebuggingEnabled, ulProcessId, ppEngine)
      => ComCall(3, this.p, IDiagnosticsScriptEngineSite, pScriptSite?, BOOL, fDebuggingEnabled, UInt32, ulProcessId, IDiagnosticsScriptEngine.Ptr, ppEngine)
}
