#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, LRESULT, POINT, PSTR, PWSTR, RECT, WPARAM}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HMENU}

struct STICKYKEYS_FLAGS extends UInt32 {
    static SKF_STICKYKEYSON := 1
    static SKF_AVAILABLE := 2
    static SKF_HOTKEYACTIVE := 4
    static SKF_CONFIRMHOTKEY := 8
    static SKF_HOTKEYSOUND := 16
    static SKF_INDICATOR := 32
    static SKF_AUDIBLEFEEDBACK := 64
    static SKF_TRISTATE := 128
    static SKF_TWOKEYSOFF := 256
    static SKF_LALTLATCHED := 268435456
    static SKF_LCTLLATCHED := 67108864
    static SKF_LSHIFTLATCHED := 16777216
    static SKF_RALTLATCHED := 536870912
    static SKF_RCTLLATCHED := 134217728
    static SKF_RSHIFTLATCHED := 33554432
    static SKF_LWINLATCHED := 1073741824
    static SKF_RWINLATCHED := 2147483648
    static SKF_LALTLOCKED := 1048576
    static SKF_LCTLLOCKED := 262144
    static SKF_LSHIFTLOCKED := 65536
    static SKF_RALTLOCKED := 2097152
    static SKF_RCTLLOCKED := 524288
    static SKF_RSHIFTLOCKED := 131072
    static SKF_LWINLOCKED := 4194304
    static SKF_RWINLOCKED := 8388608
}
struct SOUNDSENTRY_FLAGS extends UInt32 {
    static SSF_SOUNDSENTRYON := 1
    static SSF_AVAILABLE := 2
    static SSF_INDICATOR := 4
}
struct ACC_UTILITY_STATE_FLAGS extends UInt32 {
    static ANRUS_ON_SCREEN_KEYBOARD_ACTIVE := 1
    static ANRUS_TOUCH_MODIFICATION_ACTIVE := 2
    static ANRUS_PRIORITY_AUDIO_ACTIVE := 4
    static ANRUS_PRIORITY_AUDIO_ACTIVE_NODUCK := 8
}
struct SOUND_SENTRY_GRAPHICS_EFFECT extends UInt32 {
    static SSGF_DISPLAY := 3
    static SSGF_NONE := 0
}
struct SERIALKEYS_FLAGS extends UInt32 {
    static SERKF_AVAILABLE := 2
    static SERKF_INDICATOR := 4
    static SERKF_SERIALKEYSON := 1
}
struct HIGHCONTRASTW_FLAGS extends UInt32 {
    static HCF_HIGHCONTRASTON := 1
    static HCF_AVAILABLE := 2
    static HCF_HOTKEYACTIVE := 4
    static HCF_CONFIRMHOTKEY := 8
    static HCF_HOTKEYSOUND := 16
    static HCF_INDICATOR := 32
    static HCF_HOTKEYAVAILABLE := 64
    static HCF_OPTION_NOTHEMECHANGE := 4096
}
struct SOUNDSENTRY_TEXT_EFFECT extends UInt32 {
    static SSTF_BORDER := 2
    static SSTF_CHARS := 1
    static SSTF_DISPLAY := 3
    static SSTF_NONE := 0
}
struct SOUNDSENTRY_WINDOWS_EFFECT extends UInt32 {
    static SSWF_CUSTOM := 4
    static SSWF_DISPLAY := 3
    static SSWF_NONE := 0
    static SSWF_TITLE := 1
    static SSWF_WINDOW := 2
}
struct UIA_PATTERN_ID extends Int32 {
    static UIA_InvokePatternId := 10000
    static UIA_SelectionPatternId := 10001
    static UIA_ValuePatternId := 10002
    static UIA_RangeValuePatternId := 10003
    static UIA_ScrollPatternId := 10004
    static UIA_ExpandCollapsePatternId := 10005
    static UIA_GridPatternId := 10006
    static UIA_GridItemPatternId := 10007
    static UIA_MultipleViewPatternId := 10008
    static UIA_WindowPatternId := 10009
    static UIA_SelectionItemPatternId := 10010
    static UIA_DockPatternId := 10011
    static UIA_TablePatternId := 10012
    static UIA_TableItemPatternId := 10013
    static UIA_TextPatternId := 10014
    static UIA_TogglePatternId := 10015
    static UIA_TransformPatternId := 10016
    static UIA_ScrollItemPatternId := 10017
    static UIA_LegacyIAccessiblePatternId := 10018
    static UIA_ItemContainerPatternId := 10019
    static UIA_VirtualizedItemPatternId := 10020
    static UIA_SynchronizedInputPatternId := 10021
    static UIA_ObjectModelPatternId := 10022
    static UIA_AnnotationPatternId := 10023
    static UIA_TextPattern2Id := 10024
    static UIA_StylesPatternId := 10025
    static UIA_SpreadsheetPatternId := 10026
    static UIA_SpreadsheetItemPatternId := 10027
    static UIA_TransformPattern2Id := 10028
    static UIA_TextChildPatternId := 10029
    static UIA_DragPatternId := 10030
    static UIA_DropTargetPatternId := 10031
    static UIA_TextEditPatternId := 10032
    static UIA_CustomNavigationPatternId := 10033
    static UIA_SelectionPattern2Id := 10034
}
struct UIA_EVENT_ID extends Int32 {
    static UIA_ToolTipOpenedEventId := 20000
    static UIA_ToolTipClosedEventId := 20001
    static UIA_StructureChangedEventId := 20002
    static UIA_MenuOpenedEventId := 20003
    static UIA_AutomationPropertyChangedEventId := 20004
    static UIA_AutomationFocusChangedEventId := 20005
    static UIA_AsyncContentLoadedEventId := 20006
    static UIA_MenuClosedEventId := 20007
    static UIA_LayoutInvalidatedEventId := 20008
    static UIA_Invoke_InvokedEventId := 20009
    static UIA_SelectionItem_ElementAddedToSelectionEventId := 20010
    static UIA_SelectionItem_ElementRemovedFromSelectionEventId := 20011
    static UIA_SelectionItem_ElementSelectedEventId := 20012
    static UIA_Selection_InvalidatedEventId := 20013
    static UIA_Text_TextSelectionChangedEventId := 20014
    static UIA_Text_TextChangedEventId := 20015
    static UIA_Window_WindowOpenedEventId := 20016
    static UIA_Window_WindowClosedEventId := 20017
    static UIA_MenuModeStartEventId := 20018
    static UIA_MenuModeEndEventId := 20019
    static UIA_InputReachedTargetEventId := 20020
    static UIA_InputReachedOtherElementEventId := 20021
    static UIA_InputDiscardedEventId := 20022
    static UIA_SystemAlertEventId := 20023
    static UIA_LiveRegionChangedEventId := 20024
    static UIA_HostedFragmentRootsInvalidatedEventId := 20025
    static UIA_Drag_DragStartEventId := 20026
    static UIA_Drag_DragCancelEventId := 20027
    static UIA_Drag_DragCompleteEventId := 20028
    static UIA_DropTarget_DragEnterEventId := 20029
    static UIA_DropTarget_DragLeaveEventId := 20030
    static UIA_DropTarget_DroppedEventId := 20031
    static UIA_TextEdit_TextChangedEventId := 20032
    static UIA_TextEdit_ConversionTargetChangedEventId := 20033
    static UIA_ChangesEventId := 20034
    static UIA_NotificationEventId := 20035
    static UIA_ActiveTextPositionChangedEventId := 20036
}
struct UIA_PROPERTY_ID extends Int32 {
    static UIA_RuntimeIdPropertyId := 30000
    static UIA_BoundingRectanglePropertyId := 30001
    static UIA_ProcessIdPropertyId := 30002
    static UIA_ControlTypePropertyId := 30003
    static UIA_LocalizedControlTypePropertyId := 30004
    static UIA_NamePropertyId := 30005
    static UIA_AcceleratorKeyPropertyId := 30006
    static UIA_AccessKeyPropertyId := 30007
    static UIA_HasKeyboardFocusPropertyId := 30008
    static UIA_IsKeyboardFocusablePropertyId := 30009
    static UIA_IsEnabledPropertyId := 30010
    static UIA_AutomationIdPropertyId := 30011
    static UIA_ClassNamePropertyId := 30012
    static UIA_HelpTextPropertyId := 30013
    static UIA_ClickablePointPropertyId := 30014
    static UIA_CulturePropertyId := 30015
    static UIA_IsControlElementPropertyId := 30016
    static UIA_IsContentElementPropertyId := 30017
    static UIA_LabeledByPropertyId := 30018
    static UIA_IsPasswordPropertyId := 30019
    static UIA_NativeWindowHandlePropertyId := 30020
    static UIA_ItemTypePropertyId := 30021
    static UIA_IsOffscreenPropertyId := 30022
    static UIA_OrientationPropertyId := 30023
    static UIA_FrameworkIdPropertyId := 30024
    static UIA_IsRequiredForFormPropertyId := 30025
    static UIA_ItemStatusPropertyId := 30026
    static UIA_IsDockPatternAvailablePropertyId := 30027
    static UIA_IsExpandCollapsePatternAvailablePropertyId := 30028
    static UIA_IsGridItemPatternAvailablePropertyId := 30029
    static UIA_IsGridPatternAvailablePropertyId := 30030
    static UIA_IsInvokePatternAvailablePropertyId := 30031
    static UIA_IsMultipleViewPatternAvailablePropertyId := 30032
    static UIA_IsRangeValuePatternAvailablePropertyId := 30033
    static UIA_IsScrollPatternAvailablePropertyId := 30034
    static UIA_IsScrollItemPatternAvailablePropertyId := 30035
    static UIA_IsSelectionItemPatternAvailablePropertyId := 30036
    static UIA_IsSelectionPatternAvailablePropertyId := 30037
    static UIA_IsTablePatternAvailablePropertyId := 30038
    static UIA_IsTableItemPatternAvailablePropertyId := 30039
    static UIA_IsTextPatternAvailablePropertyId := 30040
    static UIA_IsTogglePatternAvailablePropertyId := 30041
    static UIA_IsTransformPatternAvailablePropertyId := 30042
    static UIA_IsValuePatternAvailablePropertyId := 30043
    static UIA_IsWindowPatternAvailablePropertyId := 30044
    static UIA_ValueValuePropertyId := 30045
    static UIA_ValueIsReadOnlyPropertyId := 30046
    static UIA_RangeValueValuePropertyId := 30047
    static UIA_RangeValueIsReadOnlyPropertyId := 30048
    static UIA_RangeValueMinimumPropertyId := 30049
    static UIA_RangeValueMaximumPropertyId := 30050
    static UIA_RangeValueLargeChangePropertyId := 30051
    static UIA_RangeValueSmallChangePropertyId := 30052
    static UIA_ScrollHorizontalScrollPercentPropertyId := 30053
    static UIA_ScrollHorizontalViewSizePropertyId := 30054
    static UIA_ScrollVerticalScrollPercentPropertyId := 30055
    static UIA_ScrollVerticalViewSizePropertyId := 30056
    static UIA_ScrollHorizontallyScrollablePropertyId := 30057
    static UIA_ScrollVerticallyScrollablePropertyId := 30058
    static UIA_SelectionSelectionPropertyId := 30059
    static UIA_SelectionCanSelectMultiplePropertyId := 30060
    static UIA_SelectionIsSelectionRequiredPropertyId := 30061
    static UIA_GridRowCountPropertyId := 30062
    static UIA_GridColumnCountPropertyId := 30063
    static UIA_GridItemRowPropertyId := 30064
    static UIA_GridItemColumnPropertyId := 30065
    static UIA_GridItemRowSpanPropertyId := 30066
    static UIA_GridItemColumnSpanPropertyId := 30067
    static UIA_GridItemContainingGridPropertyId := 30068
    static UIA_DockDockPositionPropertyId := 30069
    static UIA_ExpandCollapseExpandCollapseStatePropertyId := 30070
    static UIA_MultipleViewCurrentViewPropertyId := 30071
    static UIA_MultipleViewSupportedViewsPropertyId := 30072
    static UIA_WindowCanMaximizePropertyId := 30073
    static UIA_WindowCanMinimizePropertyId := 30074
    static UIA_WindowWindowVisualStatePropertyId := 30075
    static UIA_WindowWindowInteractionStatePropertyId := 30076
    static UIA_WindowIsModalPropertyId := 30077
    static UIA_WindowIsTopmostPropertyId := 30078
    static UIA_SelectionItemIsSelectedPropertyId := 30079
    static UIA_SelectionItemSelectionContainerPropertyId := 30080
    static UIA_TableRowHeadersPropertyId := 30081
    static UIA_TableColumnHeadersPropertyId := 30082
    static UIA_TableRowOrColumnMajorPropertyId := 30083
    static UIA_TableItemRowHeaderItemsPropertyId := 30084
    static UIA_TableItemColumnHeaderItemsPropertyId := 30085
    static UIA_ToggleToggleStatePropertyId := 30086
    static UIA_TransformCanMovePropertyId := 30087
    static UIA_TransformCanResizePropertyId := 30088
    static UIA_TransformCanRotatePropertyId := 30089
    static UIA_IsLegacyIAccessiblePatternAvailablePropertyId := 30090
    static UIA_LegacyIAccessibleChildIdPropertyId := 30091
    static UIA_LegacyIAccessibleNamePropertyId := 30092
    static UIA_LegacyIAccessibleValuePropertyId := 30093
    static UIA_LegacyIAccessibleDescriptionPropertyId := 30094
    static UIA_LegacyIAccessibleRolePropertyId := 30095
    static UIA_LegacyIAccessibleStatePropertyId := 30096
    static UIA_LegacyIAccessibleHelpPropertyId := 30097
    static UIA_LegacyIAccessibleKeyboardShortcutPropertyId := 30098
    static UIA_LegacyIAccessibleSelectionPropertyId := 30099
    static UIA_LegacyIAccessibleDefaultActionPropertyId := 30100
    static UIA_AriaRolePropertyId := 30101
    static UIA_AriaPropertiesPropertyId := 30102
    static UIA_IsDataValidForFormPropertyId := 30103
    static UIA_ControllerForPropertyId := 30104
    static UIA_DescribedByPropertyId := 30105
    static UIA_FlowsToPropertyId := 30106
    static UIA_ProviderDescriptionPropertyId := 30107
    static UIA_IsItemContainerPatternAvailablePropertyId := 30108
    static UIA_IsVirtualizedItemPatternAvailablePropertyId := 30109
    static UIA_IsSynchronizedInputPatternAvailablePropertyId := 30110
    static UIA_OptimizeForVisualContentPropertyId := 30111
    static UIA_IsObjectModelPatternAvailablePropertyId := 30112
    static UIA_AnnotationAnnotationTypeIdPropertyId := 30113
    static UIA_AnnotationAnnotationTypeNamePropertyId := 30114
    static UIA_AnnotationAuthorPropertyId := 30115
    static UIA_AnnotationDateTimePropertyId := 30116
    static UIA_AnnotationTargetPropertyId := 30117
    static UIA_IsAnnotationPatternAvailablePropertyId := 30118
    static UIA_IsTextPattern2AvailablePropertyId := 30119
    static UIA_StylesStyleIdPropertyId := 30120
    static UIA_StylesStyleNamePropertyId := 30121
    static UIA_StylesFillColorPropertyId := 30122
    static UIA_StylesFillPatternStylePropertyId := 30123
    static UIA_StylesShapePropertyId := 30124
    static UIA_StylesFillPatternColorPropertyId := 30125
    static UIA_StylesExtendedPropertiesPropertyId := 30126
    static UIA_IsStylesPatternAvailablePropertyId := 30127
    static UIA_IsSpreadsheetPatternAvailablePropertyId := 30128
    static UIA_SpreadsheetItemFormulaPropertyId := 30129
    static UIA_SpreadsheetItemAnnotationObjectsPropertyId := 30130
    static UIA_SpreadsheetItemAnnotationTypesPropertyId := 30131
    static UIA_IsSpreadsheetItemPatternAvailablePropertyId := 30132
    static UIA_Transform2CanZoomPropertyId := 30133
    static UIA_IsTransformPattern2AvailablePropertyId := 30134
    static UIA_LiveSettingPropertyId := 30135
    static UIA_IsTextChildPatternAvailablePropertyId := 30136
    static UIA_IsDragPatternAvailablePropertyId := 30137
    static UIA_DragIsGrabbedPropertyId := 30138
    static UIA_DragDropEffectPropertyId := 30139
    static UIA_DragDropEffectsPropertyId := 30140
    static UIA_IsDropTargetPatternAvailablePropertyId := 30141
    static UIA_DropTargetDropTargetEffectPropertyId := 30142
    static UIA_DropTargetDropTargetEffectsPropertyId := 30143
    static UIA_DragGrabbedItemsPropertyId := 30144
    static UIA_Transform2ZoomLevelPropertyId := 30145
    static UIA_Transform2ZoomMinimumPropertyId := 30146
    static UIA_Transform2ZoomMaximumPropertyId := 30147
    static UIA_FlowsFromPropertyId := 30148
    static UIA_IsTextEditPatternAvailablePropertyId := 30149
    static UIA_IsPeripheralPropertyId := 30150
    static UIA_IsCustomNavigationPatternAvailablePropertyId := 30151
    static UIA_PositionInSetPropertyId := 30152
    static UIA_SizeOfSetPropertyId := 30153
    static UIA_LevelPropertyId := 30154
    static UIA_AnnotationTypesPropertyId := 30155
    static UIA_AnnotationObjectsPropertyId := 30156
    static UIA_LandmarkTypePropertyId := 30157
    static UIA_LocalizedLandmarkTypePropertyId := 30158
    static UIA_FullDescriptionPropertyId := 30159
    static UIA_FillColorPropertyId := 30160
    static UIA_OutlineColorPropertyId := 30161
    static UIA_FillTypePropertyId := 30162
    static UIA_VisualEffectsPropertyId := 30163
    static UIA_OutlineThicknessPropertyId := 30164
    static UIA_CenterPointPropertyId := 30165
    static UIA_RotationPropertyId := 30166
    static UIA_SizePropertyId := 30167
    static UIA_IsSelectionPattern2AvailablePropertyId := 30168
    static UIA_Selection2FirstSelectedItemPropertyId := 30169
    static UIA_Selection2LastSelectedItemPropertyId := 30170
    static UIA_Selection2CurrentSelectedItemPropertyId := 30171
    static UIA_Selection2ItemCountPropertyId := 30172
    static UIA_HeadingLevelPropertyId := 30173
    static UIA_IsDialogPropertyId := 30174
}
struct UIA_TEXTATTRIBUTE_ID extends Int32 {
    static UIA_AnimationStyleAttributeId := 40000
    static UIA_BackgroundColorAttributeId := 40001
    static UIA_BulletStyleAttributeId := 40002
    static UIA_CapStyleAttributeId := 40003
    static UIA_CultureAttributeId := 40004
    static UIA_FontNameAttributeId := 40005
    static UIA_FontSizeAttributeId := 40006
    static UIA_FontWeightAttributeId := 40007
    static UIA_ForegroundColorAttributeId := 40008
    static UIA_HorizontalTextAlignmentAttributeId := 40009
    static UIA_IndentationFirstLineAttributeId := 40010
    static UIA_IndentationLeadingAttributeId := 40011
    static UIA_IndentationTrailingAttributeId := 40012
    static UIA_IsHiddenAttributeId := 40013
    static UIA_IsItalicAttributeId := 40014
    static UIA_IsReadOnlyAttributeId := 40015
    static UIA_IsSubscriptAttributeId := 40016
    static UIA_IsSuperscriptAttributeId := 40017
    static UIA_MarginBottomAttributeId := 40018
    static UIA_MarginLeadingAttributeId := 40019
    static UIA_MarginTopAttributeId := 40020
    static UIA_MarginTrailingAttributeId := 40021
    static UIA_OutlineStylesAttributeId := 40022
    static UIA_OverlineColorAttributeId := 40023
    static UIA_OverlineStyleAttributeId := 40024
    static UIA_StrikethroughColorAttributeId := 40025
    static UIA_StrikethroughStyleAttributeId := 40026
    static UIA_TabsAttributeId := 40027
    static UIA_TextFlowDirectionsAttributeId := 40028
    static UIA_UnderlineColorAttributeId := 40029
    static UIA_UnderlineStyleAttributeId := 40030
    static UIA_AnnotationTypesAttributeId := 40031
    static UIA_AnnotationObjectsAttributeId := 40032
    static UIA_StyleNameAttributeId := 40033
    static UIA_StyleIdAttributeId := 40034
    static UIA_LinkAttributeId := 40035
    static UIA_IsActiveAttributeId := 40036
    static UIA_SelectionActiveEndAttributeId := 40037
    static UIA_CaretPositionAttributeId := 40038
    static UIA_CaretBidiModeAttributeId := 40039
    static UIA_LineSpacingAttributeId := 40040
    static UIA_BeforeParagraphSpacingAttributeId := 40041
    static UIA_AfterParagraphSpacingAttributeId := 40042
    static UIA_SayAsInterpretAsAttributeId := 40043
}
struct UIA_CONTROLTYPE_ID extends Int32 {
    static UIA_ButtonControlTypeId := 50000
    static UIA_CalendarControlTypeId := 50001
    static UIA_CheckBoxControlTypeId := 50002
    static UIA_ComboBoxControlTypeId := 50003
    static UIA_EditControlTypeId := 50004
    static UIA_HyperlinkControlTypeId := 50005
    static UIA_ImageControlTypeId := 50006
    static UIA_ListItemControlTypeId := 50007
    static UIA_ListControlTypeId := 50008
    static UIA_MenuControlTypeId := 50009
    static UIA_MenuBarControlTypeId := 50010
    static UIA_MenuItemControlTypeId := 50011
    static UIA_ProgressBarControlTypeId := 50012
    static UIA_RadioButtonControlTypeId := 50013
    static UIA_ScrollBarControlTypeId := 50014
    static UIA_SliderControlTypeId := 50015
    static UIA_SpinnerControlTypeId := 50016
    static UIA_StatusBarControlTypeId := 50017
    static UIA_TabControlTypeId := 50018
    static UIA_TabItemControlTypeId := 50019
    static UIA_TextControlTypeId := 50020
    static UIA_ToolBarControlTypeId := 50021
    static UIA_ToolTipControlTypeId := 50022
    static UIA_TreeControlTypeId := 50023
    static UIA_TreeItemControlTypeId := 50024
    static UIA_CustomControlTypeId := 50025
    static UIA_GroupControlTypeId := 50026
    static UIA_ThumbControlTypeId := 50027
    static UIA_DataGridControlTypeId := 50028
    static UIA_DataItemControlTypeId := 50029
    static UIA_DocumentControlTypeId := 50030
    static UIA_SplitButtonControlTypeId := 50031
    static UIA_WindowControlTypeId := 50032
    static UIA_PaneControlTypeId := 50033
    static UIA_HeaderControlTypeId := 50034
    static UIA_HeaderItemControlTypeId := 50035
    static UIA_TableControlTypeId := 50036
    static UIA_TitleBarControlTypeId := 50037
    static UIA_SeparatorControlTypeId := 50038
    static UIA_SemanticZoomControlTypeId := 50039
    static UIA_AppBarControlTypeId := 50040
}
struct UIA_ANNOTATIONTYPE extends Int32 {
    static AnnotationType_Unknown := 60000
    static AnnotationType_SpellingError := 60001
    static AnnotationType_GrammarError := 60002
    static AnnotationType_Comment := 60003
    static AnnotationType_FormulaError := 60004
    static AnnotationType_TrackChanges := 60005
    static AnnotationType_Header := 60006
    static AnnotationType_Footer := 60007
    static AnnotationType_Highlighted := 60008
    static AnnotationType_Endnote := 60009
    static AnnotationType_Footnote := 60010
    static AnnotationType_InsertionChange := 60011
    static AnnotationType_DeletionChange := 60012
    static AnnotationType_MoveChange := 60013
    static AnnotationType_FormatChange := 60014
    static AnnotationType_UnsyncedChange := 60015
    static AnnotationType_EditingLockedChange := 60016
    static AnnotationType_ExternalChange := 60017
    static AnnotationType_ConflictingChange := 60018
    static AnnotationType_Author := 60019
    static AnnotationType_AdvancedProofingIssue := 60020
    static AnnotationType_DataValidationError := 60021
    static AnnotationType_CircularReferenceError := 60022
    static AnnotationType_Mathematics := 60023
    static AnnotationType_Sensitive := 60024
}
struct UIA_STYLE_ID extends Int32 {
    static StyleId_Custom := 70000
    static StyleId_Heading1 := 70001
    static StyleId_Heading2 := 70002
    static StyleId_Heading3 := 70003
    static StyleId_Heading4 := 70004
    static StyleId_Heading5 := 70005
    static StyleId_Heading6 := 70006
    static StyleId_Heading7 := 70007
    static StyleId_Heading8 := 70008
    static StyleId_Heading9 := 70009
    static StyleId_Title := 70010
    static StyleId_Subtitle := 70011
    static StyleId_Normal := 70012
    static StyleId_Emphasis := 70013
    static StyleId_Quote := 70014
    static StyleId_BulletedList := 70015
    static StyleId_NumberedList := 70016
}
struct UIA_LANDMARKTYPE_ID extends Int32 {
    static UIA_CustomLandmarkTypeId := 80000
    static UIA_FormLandmarkTypeId := 80001
    static UIA_MainLandmarkTypeId := 80002
    static UIA_NavigationLandmarkTypeId := 80003
    static UIA_SearchLandmarkTypeId := 80004
}
struct UIA_HEADINGLEVEL_ID extends Int32 {
    static HeadingLevel_None := 80050
    static HeadingLevel1 := 80051
    static HeadingLevel2 := 80052
    static HeadingLevel3 := 80053
    static HeadingLevel4 := 80054
    static HeadingLevel5 := 80055
    static HeadingLevel6 := 80056
    static HeadingLevel7 := 80057
    static HeadingLevel8 := 80058
    static HeadingLevel9 := 80059
}
struct UIA_CHANGE_ID extends Int32 {
    static UIA_SummaryChangeId := 90000
}
struct UIA_METADATA_ID extends Int32 {
    static UIA_SayAsInterpretAsMetadataId := 100000
}
struct HWINEVENTHOOK {
    Value : IntPtr
}
struct HUIANODE {
    Value : IntPtr
}
struct HUIAPATTERNOBJECT {
    Value : IntPtr
}
struct HUIATEXTRANGE {
    Value : IntPtr
}
struct HUIAEVENT {
    Value : IntPtr
}
struct LPFNLRESULTFROMOBJECT extends FunctionPointer {
    static Types := [GUID.Ptr, WPARAM, IUnknown, LRESULT]
}
struct LPFNOBJECTFROMLRESULT extends FunctionPointer {
    static Types := [LRESULT, GUID.Ptr, WPARAM, Struct.Ptr.Ptr, HRESULT]
}
struct LPFNACCESSIBLEOBJECTFROMWINDOW extends FunctionPointer {
    static Types := [HWND, UInt32, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct LPFNACCESSIBLEOBJECTFROMPOINT extends FunctionPointer {
    static Types := [POINT, IAccessible.Ptr, VARIANT.Ptr, HRESULT]
}
struct LPFNCREATESTDACCESSIBLEOBJECT extends FunctionPointer {
    static Types := [HWND, Int32, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct LPFNACCESSIBLECHILDREN extends FunctionPointer {
    static Types := [IAccessible, Int32, Int32, VARIANT.Ptr, Int32.Ptr, HRESULT]
}
struct MSAAMENUINFO {
    dwMSAASignature : UInt32
    cchWText : UInt32
    pszWText : PWSTR
}
struct IAccessible extends IDispatch {
    static IID := "{618736E0-3C3D-11CF-810C-00AA00389B71}"
    get_accParent(ppdispParent)
      => ComCall(7, this.p, IDispatch.Ptr, ppdispParent)
    get_accChildCount(pcountChildren)
      => ComCall(8, this.p, Int32.Ptr, pcountChildren)
    get_accChild(varChild, ppdispChild)
      => ComCall(9, this.p, VARIANT, varChild, IDispatch.Ptr, ppdispChild)
    get_accName(varChild, pszName)
      => ComCall(10, this.p, VARIANT, varChild, BSTR.Ptr, pszName)
    get_accValue(varChild, pszValue)
      => ComCall(11, this.p, VARIANT, varChild, BSTR.Ptr, pszValue)
    get_accDescription(varChild, pszDescription)
      => ComCall(12, this.p, VARIANT, varChild, BSTR.Ptr, pszDescription)
    get_accRole(varChild, pvarRole)
      => ComCall(13, this.p, VARIANT, varChild, VARIANT.Ptr, pvarRole)
    get_accState(varChild, pvarState)
      => ComCall(14, this.p, VARIANT, varChild, VARIANT.Ptr, pvarState)
    get_accHelp(varChild, pszHelp)
      => ComCall(15, this.p, VARIANT, varChild, BSTR.Ptr, pszHelp)
    get_accHelpTopic(pszHelpFile, varChild, pidTopic)
      => ComCall(16, this.p, BSTR.Ptr, pszHelpFile, VARIANT, varChild, Int32.Ptr, pidTopic)
    get_accKeyboardShortcut(varChild, pszKeyboardShortcut)
      => ComCall(17, this.p, VARIANT, varChild, BSTR.Ptr, pszKeyboardShortcut)
    get_accFocus(pvarChild)
      => ComCall(18, this.p, VARIANT.Ptr, pvarChild)
    get_accSelection(pvarChildren)
      => ComCall(19, this.p, VARIANT.Ptr, pvarChildren)
    get_accDefaultAction(varChild, pszDefaultAction)
      => ComCall(20, this.p, VARIANT, varChild, BSTR.Ptr, pszDefaultAction)
    accSelect(flagsSelect, varChild)
      => ComCall(21, this.p, Int32, flagsSelect, VARIANT, varChild)
    accLocation(pxLeft, pyTop, pcxWidth, pcyHeight, varChild)
      => ComCall(22, this.p, Int32.Ptr, pxLeft, Int32.Ptr, pyTop, Int32.Ptr, pcxWidth, Int32.Ptr, pcyHeight, VARIANT, varChild)
    accNavigate(navDir, varStart, pvarEndUpAt)
      => ComCall(23, this.p, Int32, navDir, VARIANT, varStart, VARIANT.Ptr, pvarEndUpAt)
    accHitTest(xLeft, yTop, pvarChild)
      => ComCall(24, this.p, Int32, xLeft, Int32, yTop, VARIANT.Ptr, pvarChild)
    accDoDefaultAction(varChild)
      => ComCall(25, this.p, VARIANT, varChild)
    put_accName(varChild, szName)
      => ComCall(26, this.p, VARIANT, varChild, BSTR, szName)
    put_accValue(varChild, szValue)
      => ComCall(27, this.p, VARIANT, varChild, BSTR, szValue)
}
struct IAccessibleHandler extends IUnknown {
    static IID := "{03022430-ABC4-11D0-BDE2-00AA001A1953}"
    AccessibleObjectFromID(hwnd, lObjectID, pIAccessible)
      => ComCall(3, this.p, Int32, hwnd, Int32, lObjectID, IAccessible.Ptr, pIAccessible)
}
struct IAccessibleWindowlessSite extends IUnknown {
    static IID := "{BF3ABD9C-76DA-4389-9EB6-1427D25ABAB7}"
    AcquireObjectIdRange(rangeSize, pRangeOwner, pRangeBase)
      => ComCall(3, this.p, Int32, rangeSize, IAccessibleHandler, pRangeOwner, Int32.Ptr, pRangeBase)
    ReleaseObjectIdRange(rangeBase, pRangeOwner)
      => ComCall(4, this.p, Int32, rangeBase, IAccessibleHandler, pRangeOwner)
    QueryObjectIdRanges(pRangesOwner, psaRanges)
      => ComCall(5, this.p, IAccessibleHandler, pRangesOwner, SAFEARRAY.Ptr.Ptr, psaRanges)
    GetParentAccessible(ppParent)
      => ComCall(6, this.p, IAccessible.Ptr, ppParent)
}
struct AnnoScope extends Int32 {
    static ANNO_THIS := 0
    static ANNO_CONTAINER := 1
}
struct IAccIdentity extends IUnknown {
    static IID := "{7852B78D-1CFD-41C1-A615-9C0C85960B5F}"
    GetIdentityString(dwIDChild, ppIDString)
      => ComCall(3, this.p, UInt32, dwIDChild, UInt8.Ptr.Ptr, ppIDString, UInt32.Ptr, ppIDString.Length)
}
struct IAccPropServer extends IUnknown {
    static IID := "{76C0DBBB-15E0-4E7B-B61B-20EEEA2001E0}"
    GetPropValue(pIDString, idProp, pvarValue, pfHasProp)
      => ComCall(3, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, GUID, idProp, VARIANT.Ptr, pvarValue, BOOL.Ptr, pfHasProp)
}
struct IAccPropServices extends IUnknown {
    static IID := "{6E26E776-04F0-495D-80E4-3330352E3169}"
    SetPropValue(pIDString, idProp, var)
      => ComCall(3, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, GUID, idProp, VARIANT, var)
    SetPropServer(pIDString, paProps, pServer, annoScope1)
      => ComCall(4, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, GUID.Ptr, paProps, Int32, paProps.Length, IAccPropServer, pServer, AnnoScope, annoScope1)
    ClearProps(pIDString, paProps)
      => ComCall(5, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, GUID.Ptr, paProps, Int32, paProps.Length)
    SetHwndProp(hwnd1, idObject, idChild, idProp, var)
      => ComCall(6, this.p, HWND, hwnd1, UInt32, idObject, UInt32, idChild, GUID, idProp, VARIANT, var)
    SetHwndPropStr(hwnd1, idObject, idChild, idProp, str)
      => ComCall(7, this.p, HWND, hwnd1, UInt32, idObject, UInt32, idChild, GUID, idProp, "Str", str)
    SetHwndPropServer(hwnd1, idObject, idChild, paProps, pServer, annoScope1)
      => ComCall(8, this.p, HWND, hwnd1, UInt32, idObject, UInt32, idChild, GUID.Ptr, paProps, Int32, paProps.Length, IAccPropServer, pServer, AnnoScope, annoScope1)
    ClearHwndProps(hwnd1, idObject, idChild, paProps)
      => ComCall(9, this.p, HWND, hwnd1, UInt32, idObject, UInt32, idChild, GUID.Ptr, paProps, Int32, paProps.Length)
    ComposeHwndIdentityString(hwnd1, idObject, idChild, ppIDString)
      => ComCall(10, this.p, HWND, hwnd1, UInt32, idObject, UInt32, idChild, UInt8.Ptr.Ptr, ppIDString, UInt32.Ptr, ppIDString.Length)
    DecomposeHwndIdentityString(pIDString, phwnd, pidObject, pidChild)
      => ComCall(11, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, HWND.Ptr, phwnd, UInt32.Ptr, pidObject, UInt32.Ptr, pidChild)
    SetHmenuProp(hmenu1, idChild, idProp, var)
      => ComCall(12, this.p, HMENU, hmenu1, UInt32, idChild, GUID, idProp, VARIANT, var)
    SetHmenuPropStr(hmenu1, idChild, idProp, str)
      => ComCall(13, this.p, HMENU, hmenu1, UInt32, idChild, GUID, idProp, "Str", str)
    SetHmenuPropServer(hmenu1, idChild, paProps, pServer, annoScope1)
      => ComCall(14, this.p, HMENU, hmenu1, UInt32, idChild, GUID.Ptr, paProps, Int32, paProps.Length, IAccPropServer, pServer, AnnoScope, annoScope1)
    ClearHmenuProps(hmenu1, idChild, paProps)
      => ComCall(15, this.p, HMENU, hmenu1, UInt32, idChild, GUID.Ptr, paProps, Int32, paProps.Length)
    ComposeHmenuIdentityString(hmenu1, idChild, ppIDString)
      => ComCall(16, this.p, HMENU, hmenu1, UInt32, idChild, UInt8.Ptr.Ptr, ppIDString, UInt32.Ptr, ppIDString.Length)
    DecomposeHmenuIdentityString(pIDString, phmenu, pidChild)
      => ComCall(17, this.p, UInt8.Ptr, pIDString, UInt32, pIDString.Length, HMENU.Ptr, phmenu, UInt32.Ptr, pidChild)
}
struct NavigateDirection extends Int32 {
    static NavigateDirection_Parent := 0
    static NavigateDirection_NextSibling := 1
    static NavigateDirection_PreviousSibling := 2
    static NavigateDirection_FirstChild := 3
    static NavigateDirection_LastChild := 4
}
struct ProviderOptions extends Int32 {
    static ProviderOptions_ClientSideProvider := 1
    static ProviderOptions_ServerSideProvider := 2
    static ProviderOptions_NonClientAreaProvider := 4
    static ProviderOptions_OverrideProvider := 8
    static ProviderOptions_ProviderOwnsSetFocus := 16
    static ProviderOptions_UseComThreading := 32
    static ProviderOptions_RefuseNonClientSupport := 64
    static ProviderOptions_HasNativeIAccessible := 128
    static ProviderOptions_UseClientCoordinates := 256
}
struct StructureChangeType extends Int32 {
    static StructureChangeType_ChildAdded := 0
    static StructureChangeType_ChildRemoved := 1
    static StructureChangeType_ChildrenInvalidated := 2
    static StructureChangeType_ChildrenBulkAdded := 3
    static StructureChangeType_ChildrenBulkRemoved := 4
    static StructureChangeType_ChildrenReordered := 5
}
struct TextEditChangeType extends Int32 {
    static TextEditChangeType_None := 0
    static TextEditChangeType_AutoCorrect := 1
    static TextEditChangeType_Composition := 2
    static TextEditChangeType_CompositionFinalized := 3
    static TextEditChangeType_AutoComplete := 4
}
struct OrientationType extends Int32 {
    static OrientationType_None := 0
    static OrientationType_Horizontal := 1
    static OrientationType_Vertical := 2
}
struct DockPosition extends Int32 {
    static DockPosition_Top := 0
    static DockPosition_Left := 1
    static DockPosition_Bottom := 2
    static DockPosition_Right := 3
    static DockPosition_Fill := 4
    static DockPosition_None := 5
}
struct ExpandCollapseState extends Int32 {
    static ExpandCollapseState_Collapsed := 0
    static ExpandCollapseState_Expanded := 1
    static ExpandCollapseState_PartiallyExpanded := 2
    static ExpandCollapseState_LeafNode := 3
}
struct ScrollAmount extends Int32 {
    static ScrollAmount_LargeDecrement := 0
    static ScrollAmount_SmallDecrement := 1
    static ScrollAmount_NoAmount := 2
    static ScrollAmount_LargeIncrement := 3
    static ScrollAmount_SmallIncrement := 4
}
struct RowOrColumnMajor extends Int32 {
    static RowOrColumnMajor_RowMajor := 0
    static RowOrColumnMajor_ColumnMajor := 1
    static RowOrColumnMajor_Indeterminate := 2
}
struct ToggleState extends Int32 {
    static ToggleState_Off := 0
    static ToggleState_On := 1
    static ToggleState_Indeterminate := 2
}
struct WindowVisualState extends Int32 {
    static WindowVisualState_Normal := 0
    static WindowVisualState_Maximized := 1
    static WindowVisualState_Minimized := 2
}
struct SynchronizedInputType extends Int32 {
    static SynchronizedInputType_KeyUp := 1
    static SynchronizedInputType_KeyDown := 2
    static SynchronizedInputType_LeftMouseUp := 4
    static SynchronizedInputType_LeftMouseDown := 8
    static SynchronizedInputType_RightMouseUp := 16
    static SynchronizedInputType_RightMouseDown := 32
}
struct WindowInteractionState extends Int32 {
    static WindowInteractionState_Running := 0
    static WindowInteractionState_Closing := 1
    static WindowInteractionState_ReadyForUserInteraction := 2
    static WindowInteractionState_BlockedByModalWindow := 3
    static WindowInteractionState_NotResponding := 4
}
struct SayAsInterpretAs extends Int32 {
    static SayAsInterpretAs_None := 0
    static SayAsInterpretAs_Spell := 1
    static SayAsInterpretAs_Cardinal := 2
    static SayAsInterpretAs_Ordinal := 3
    static SayAsInterpretAs_Number := 4
    static SayAsInterpretAs_Date := 5
    static SayAsInterpretAs_Time := 6
    static SayAsInterpretAs_Telephone := 7
    static SayAsInterpretAs_Currency := 8
    static SayAsInterpretAs_Net := 9
    static SayAsInterpretAs_Url := 10
    static SayAsInterpretAs_Address := 11
    static SayAsInterpretAs_Alphanumeric := 12
    static SayAsInterpretAs_Name := 13
    static SayAsInterpretAs_Media := 14
    static SayAsInterpretAs_Date_MonthDayYear := 15
    static SayAsInterpretAs_Date_DayMonthYear := 16
    static SayAsInterpretAs_Date_YearMonthDay := 17
    static SayAsInterpretAs_Date_YearMonth := 18
    static SayAsInterpretAs_Date_MonthYear := 19
    static SayAsInterpretAs_Date_DayMonth := 20
    static SayAsInterpretAs_Date_MonthDay := 21
    static SayAsInterpretAs_Date_Year := 22
    static SayAsInterpretAs_Time_HoursMinutesSeconds12 := 23
    static SayAsInterpretAs_Time_HoursMinutes12 := 24
    static SayAsInterpretAs_Time_HoursMinutesSeconds24 := 25
    static SayAsInterpretAs_Time_HoursMinutes24 := 26
}
struct TextUnit extends Int32 {
    static TextUnit_Character := 0
    static TextUnit_Format := 1
    static TextUnit_Word := 2
    static TextUnit_Line := 3
    static TextUnit_Paragraph := 4
    static TextUnit_Page := 5
    static TextUnit_Document := 6
}
struct TextPatternRangeEndpoint extends Int32 {
    static TextPatternRangeEndpoint_Start := 0
    static TextPatternRangeEndpoint_End := 1
}
struct SupportedTextSelection extends Int32 {
    static SupportedTextSelection_None := 0
    static SupportedTextSelection_Single := 1
    static SupportedTextSelection_Multiple := 2
}
struct LiveSetting extends Int32 {
    static Off := 0
    static Polite := 1
    static Assertive := 2
}
struct ActiveEnd extends Int32 {
    static ActiveEnd_None := 0
    static ActiveEnd_Start := 1
    static ActiveEnd_End := 2
}
struct CaretPosition extends Int32 {
    static CaretPosition_Unknown := 0
    static CaretPosition_EndOfLine := 1
    static CaretPosition_BeginningOfLine := 2
}
struct CaretBidiMode extends Int32 {
    static CaretBidiMode_LTR := 0
    static CaretBidiMode_RTL := 1
}
struct ZoomUnit extends Int32 {
    static ZoomUnit_NoAmount := 0
    static ZoomUnit_LargeDecrement := 1
    static ZoomUnit_SmallDecrement := 2
    static ZoomUnit_LargeIncrement := 3
    static ZoomUnit_SmallIncrement := 4
}
struct AnimationStyle extends Int32 {
    static AnimationStyle_None := 0
    static AnimationStyle_LasVegasLights := 1
    static AnimationStyle_BlinkingBackground := 2
    static AnimationStyle_SparkleText := 3
    static AnimationStyle_MarchingBlackAnts := 4
    static AnimationStyle_MarchingRedAnts := 5
    static AnimationStyle_Shimmer := 6
    static AnimationStyle_Other := -1
}
struct BulletStyle extends Int32 {
    static BulletStyle_None := 0
    static BulletStyle_HollowRoundBullet := 1
    static BulletStyle_FilledRoundBullet := 2
    static BulletStyle_HollowSquareBullet := 3
    static BulletStyle_FilledSquareBullet := 4
    static BulletStyle_DashBullet := 5
    static BulletStyle_Other := -1
}
struct CapStyle extends Int32 {
    static CapStyle_None := 0
    static CapStyle_SmallCap := 1
    static CapStyle_AllCap := 2
    static CapStyle_AllPetiteCaps := 3
    static CapStyle_PetiteCaps := 4
    static CapStyle_Unicase := 5
    static CapStyle_Titling := 6
    static CapStyle_Other := -1
}
struct FillType extends Int32 {
    static FillType_None := 0
    static FillType_Color := 1
    static FillType_Gradient := 2
    static FillType_Picture := 3
    static FillType_Pattern := 4
}
struct FlowDirections extends Int32 {
    static FlowDirections_Default := 0
    static FlowDirections_RightToLeft := 1
    static FlowDirections_BottomToTop := 2
    static FlowDirections_Vertical := 4
}
struct HorizontalTextAlignment extends Int32 {
    static HorizontalTextAlignment_Left := 0
    static HorizontalTextAlignment_Centered := 1
    static HorizontalTextAlignment_Right := 2
    static HorizontalTextAlignment_Justified := 3
}
struct OutlineStyles extends Int32 {
    static OutlineStyles_None := 0
    static OutlineStyles_Outline := 1
    static OutlineStyles_Shadow := 2
    static OutlineStyles_Engraved := 4
    static OutlineStyles_Embossed := 8
}
struct TextDecorationLineStyle extends Int32 {
    static TextDecorationLineStyle_None := 0
    static TextDecorationLineStyle_Single := 1
    static TextDecorationLineStyle_WordsOnly := 2
    static TextDecorationLineStyle_Double := 3
    static TextDecorationLineStyle_Dot := 4
    static TextDecorationLineStyle_Dash := 5
    static TextDecorationLineStyle_DashDot := 6
    static TextDecorationLineStyle_DashDotDot := 7
    static TextDecorationLineStyle_Wavy := 8
    static TextDecorationLineStyle_ThickSingle := 9
    static TextDecorationLineStyle_DoubleWavy := 11
    static TextDecorationLineStyle_ThickWavy := 12
    static TextDecorationLineStyle_LongDash := 13
    static TextDecorationLineStyle_ThickDash := 14
    static TextDecorationLineStyle_ThickDashDot := 15
    static TextDecorationLineStyle_ThickDashDotDot := 16
    static TextDecorationLineStyle_ThickDot := 17
    static TextDecorationLineStyle_ThickLongDash := 18
    static TextDecorationLineStyle_Other := -1
}
struct VisualEffects extends Int32 {
    static VisualEffects_None := 0
    static VisualEffects_Shadow := 1
    static VisualEffects_Reflection := 2
    static VisualEffects_Glow := 4
    static VisualEffects_SoftEdges := 8
    static VisualEffects_Bevel := 16
}
struct NotificationProcessing extends Int32 {
    static NotificationProcessing_ImportantAll := 0
    static NotificationProcessing_ImportantMostRecent := 1
    static NotificationProcessing_All := 2
    static NotificationProcessing_MostRecent := 3
    static NotificationProcessing_CurrentThenMostRecent := 4
    static NotificationProcessing_ImportantCurrentThenMostRecent := 5
}
struct NotificationKind extends Int32 {
    static NotificationKind_ItemAdded := 0
    static NotificationKind_ItemRemoved := 1
    static NotificationKind_ActionCompleted := 2
    static NotificationKind_ActionAborted := 3
    static NotificationKind_Other := 4
}
struct UiaRect {
    left : Float64
    top : Float64
    width : Float64
    height : Float64
}
struct UiaPoint {
    x : Float64
    y : Float64
}
struct UiaChangeInfo {
    uiaId : Int32
    payload : VARIANT
    extraInfo : VARIANT
}
struct UIAutomationType extends Int32 {
    static UIAutomationType_Int := 1
    static UIAutomationType_Bool := 2
    static UIAutomationType_String := 3
    static UIAutomationType_Double := 4
    static UIAutomationType_Point := 5
    static UIAutomationType_Rect := 6
    static UIAutomationType_Element := 7
    static UIAutomationType_Array := 65536
    static UIAutomationType_Out := 131072
    static UIAutomationType_IntArray := 65537
    static UIAutomationType_BoolArray := 65538
    static UIAutomationType_StringArray := 65539
    static UIAutomationType_DoubleArray := 65540
    static UIAutomationType_PointArray := 65541
    static UIAutomationType_RectArray := 65542
    static UIAutomationType_ElementArray := 65543
    static UIAutomationType_OutInt := 131073
    static UIAutomationType_OutBool := 131074
    static UIAutomationType_OutString := 131075
    static UIAutomationType_OutDouble := 131076
    static UIAutomationType_OutPoint := 131077
    static UIAutomationType_OutRect := 131078
    static UIAutomationType_OutElement := 131079
    static UIAutomationType_OutIntArray := 196609
    static UIAutomationType_OutBoolArray := 196610
    static UIAutomationType_OutStringArray := 196611
    static UIAutomationType_OutDoubleArray := 196612
    static UIAutomationType_OutPointArray := 196613
    static UIAutomationType_OutRectArray := 196614
    static UIAutomationType_OutElementArray := 196615
}
struct UIAutomationParameter {
    type : UIAutomationType
    pData : Struct.Ptr
}
struct UIAutomationPropertyInfo {
    guid : GUID
    pProgrammaticName : PWSTR
    type : UIAutomationType
}
struct UIAutomationEventInfo {
    guid : GUID
    pProgrammaticName : PWSTR
}
struct UIAutomationMethodInfo {
    pProgrammaticName : PWSTR
    doSetFocus : BOOL
    cInParameters : UInt32
    cOutParameters : UInt32
    pParameterTypes : UIAutomationType.Ptr
    pParameterNames : PWSTR.Ptr
}
struct UIAutomationPatternInfo {
    guid : GUID
    pProgrammaticName : PWSTR
    providerInterfaceId : GUID
    clientInterfaceId : GUID
    cProperties : UInt32
    pProperties : UIAutomationPropertyInfo.Ptr
    cMethods : UInt32
    pMethods : UIAutomationMethodInfo.Ptr
    cEvents : UInt32
    pEvents : UIAutomationEventInfo.Ptr
    pPatternHandler : IUIAutomationPatternHandler
}
struct IRawElementProviderSimple extends IUnknown {
    static IID := "{D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}"
    get_ProviderOptions(pRetVal)
      => ComCall(3, this.p, ProviderOptions.Ptr, pRetVal)
    GetPatternProvider(patternId, pRetVal)
      => ComCall(4, this.p, UIA_PATTERN_ID, patternId, IUnknown.Ptr, pRetVal)
    GetPropertyValue(propertyId, pRetVal)
      => ComCall(5, this.p, UIA_PROPERTY_ID, propertyId, VARIANT.Ptr, pRetVal)
    get_HostRawElementProvider(pRetVal)
      => ComCall(6, this.p, IRawElementProviderSimple.Ptr, pRetVal)
}
struct IAccessibleEx extends IUnknown {
    static IID := "{F8B80ADA-2C44-48D0-89BE-5FF23C9CD875}"
    GetObjectForChild(idChild, pRetVal)
      => ComCall(3, this.p, Int32, idChild, IAccessibleEx.Ptr, pRetVal)
    GetIAccessiblePair(ppAcc, pidChild)
      => ComCall(4, this.p, IAccessible.Ptr, ppAcc, Int32.Ptr, pidChild)
    GetRuntimeId(pRetVal)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    ConvertReturnedElement(pIn, ppRetValOut)
      => ComCall(6, this.p, IRawElementProviderSimple, pIn, IAccessibleEx.Ptr, ppRetValOut)
}
struct IRawElementProviderSimple2 extends IRawElementProviderSimple {
    static IID := "{A0A839A9-8DA1-4A82-806A-8E0D44E79F56}"
    ShowContextMenu()
      => ComCall(7, this.p)
}
struct IRawElementProviderSimple3 extends IRawElementProviderSimple2 {
    static IID := "{FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}"
    GetMetadataValue(targetId, metadataId, returnVal)
      => ComCall(8, this.p, Int32, targetId, UIA_METADATA_ID, metadataId, VARIANT.Ptr, returnVal)
}
struct IRawElementProviderFragmentRoot extends IUnknown {
    static IID := "{620CE2A5-AB8F-40A9-86CB-DE3C75599B58}"
    ElementProviderFromPoint(x, y, pRetVal)
      => ComCall(3, this.p, Float64, x, Float64, y, IRawElementProviderFragment.Ptr, pRetVal)
    GetFocus(pRetVal)
      => ComCall(4, this.p, IRawElementProviderFragment.Ptr, pRetVal)
}
struct IRawElementProviderFragment extends IUnknown {
    static IID := "{F7063DA8-8359-439C-9297-BBC5299A7D87}"
    Navigate(direction, pRetVal)
      => ComCall(3, this.p, NavigateDirection, direction, IRawElementProviderFragment.Ptr, pRetVal)
    GetRuntimeId(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    get_BoundingRectangle(pRetVal)
      => ComCall(5, this.p, UiaRect.Ptr, pRetVal)
    GetEmbeddedFragmentRoots(pRetVal)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    SetFocus()
      => ComCall(7, this.p)
    get_FragmentRoot(pRetVal)
      => ComCall(8, this.p, IRawElementProviderFragmentRoot.Ptr, pRetVal)
}
struct IRawElementProviderAdviseEvents extends IUnknown {
    static IID := "{A407B27B-0F6D-4427-9292-473C7BF93258}"
    AdviseEventAdded(eventId, propertyIDs)
      => ComCall(3, this.p, UIA_EVENT_ID, eventId, SAFEARRAY.Ptr, propertyIDs)
    AdviseEventRemoved(eventId, propertyIDs)
      => ComCall(4, this.p, UIA_EVENT_ID, eventId, SAFEARRAY.Ptr, propertyIDs)
}
struct IRawElementProviderHwndOverride extends IUnknown {
    static IID := "{1D5DF27C-8947-4425-B8D9-79787BB460B8}"
    GetOverrideProviderForHwnd(hwnd1, pRetVal)
      => ComCall(3, this.p, HWND, hwnd1, IRawElementProviderSimple.Ptr, pRetVal)
}
struct IProxyProviderWinEventSink extends IUnknown {
    static IID := "{4FD82B78-A43E-46AC-9803-0A6969C7C183}"
    AddAutomationPropertyChangedEvent(pProvider, id, newValue)
      => ComCall(3, this.p, IRawElementProviderSimple, pProvider, UIA_PROPERTY_ID, id, VARIANT, newValue)
    AddAutomationEvent(pProvider, id)
      => ComCall(4, this.p, IRawElementProviderSimple, pProvider, UIA_EVENT_ID, id)
    AddStructureChangedEvent(pProvider, structureChangeType1, runtimeId)
      => ComCall(5, this.p, IRawElementProviderSimple, pProvider, StructureChangeType, structureChangeType1, SAFEARRAY.Ptr, runtimeId)
}
struct IProxyProviderWinEventHandler extends IUnknown {
    static IID := "{89592AD4-F4E0-43D5-A3B6-BAD7E111B435}"
    RespondToWinEvent(idWinEvent, hwnd1, idObject, idChild, pSink)
      => ComCall(3, this.p, UInt32, idWinEvent, HWND, hwnd1, Int32, idObject, Int32, idChild, IProxyProviderWinEventSink, pSink)
}
struct IRawElementProviderWindowlessSite extends IUnknown {
    static IID := "{0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}"
    GetAdjacentFragment(direction, ppParent)
      => ComCall(3, this.p, NavigateDirection, direction, IRawElementProviderFragment.Ptr, ppParent)
    GetRuntimeIdPrefix(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct IAccessibleHostingElementProviders extends IUnknown {
    static IID := "{33AC331B-943E-4020-B295-DB37784974A3}"
    GetEmbeddedFragmentRoots(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetObjectIdForProvider(pProvider, pidObject)
      => ComCall(4, this.p, IRawElementProviderSimple, pProvider, Int32.Ptr, pidObject)
}
struct IRawElementProviderHostingAccessibles extends IUnknown {
    static IID := "{24BE0B07-D37D-487A-98CF-A13ED465E9B3}"
    GetEmbeddedAccessibles(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct IDockProvider extends IUnknown {
    static IID := "{159BC72C-4AD3-485E-9637-D7052EDF0146}"
    SetDockPosition(dockPosition1)
      => ComCall(3, this.p, DockPosition, dockPosition1)
    get_DockPosition(pRetVal)
      => ComCall(4, this.p, DockPosition.Ptr, pRetVal)
}
struct IExpandCollapseProvider extends IUnknown {
    static IID := "{D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}"
    Expand()
      => ComCall(3, this.p)
    Collapse()
      => ComCall(4, this.p)
    get_ExpandCollapseState(pRetVal)
      => ComCall(5, this.p, ExpandCollapseState.Ptr, pRetVal)
}
struct IGridProvider extends IUnknown {
    static IID := "{B17D6187-0907-464B-A168-0EF17A1572B1}"
    GetItem(row, column, pRetVal)
      => ComCall(3, this.p, Int32, row, Int32, column, IRawElementProviderSimple.Ptr, pRetVal)
    get_RowCount(pRetVal)
      => ComCall(4, this.p, Int32.Ptr, pRetVal)
    get_ColumnCount(pRetVal)
      => ComCall(5, this.p, Int32.Ptr, pRetVal)
}
struct IGridItemProvider extends IUnknown {
    static IID := "{D02541F1-FB81-4D64-AE32-F520F8A6DBD1}"
    get_Row(pRetVal)
      => ComCall(3, this.p, Int32.Ptr, pRetVal)
    get_Column(pRetVal)
      => ComCall(4, this.p, Int32.Ptr, pRetVal)
    get_RowSpan(pRetVal)
      => ComCall(5, this.p, Int32.Ptr, pRetVal)
    get_ColumnSpan(pRetVal)
      => ComCall(6, this.p, Int32.Ptr, pRetVal)
    get_ContainingGrid(pRetVal)
      => ComCall(7, this.p, IRawElementProviderSimple.Ptr, pRetVal)
}
struct IInvokeProvider extends IUnknown {
    static IID := "{54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}"
    Invoke()
      => ComCall(3, this.p)
}
struct IMultipleViewProvider extends IUnknown {
    static IID := "{6278CAB1-B556-4A1A-B4E0-418ACC523201}"
    GetViewName(viewId, pRetVal)
      => ComCall(3, this.p, Int32, viewId, BSTR.Ptr, pRetVal)
    SetCurrentView(viewId)
      => ComCall(4, this.p, Int32, viewId)
    get_CurrentView(pRetVal)
      => ComCall(5, this.p, Int32.Ptr, pRetVal)
    GetSupportedViews(pRetVal)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct IRangeValueProvider extends IUnknown {
    static IID := "{36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}"
    SetValue(val)
      => ComCall(3, this.p, Float64, val)
    get_Value(pRetVal)
      => ComCall(4, this.p, Float64.Ptr, pRetVal)
    get_IsReadOnly(pRetVal)
      => ComCall(5, this.p, BOOL.Ptr, pRetVal)
    get_Maximum(pRetVal)
      => ComCall(6, this.p, Float64.Ptr, pRetVal)
    get_Minimum(pRetVal)
      => ComCall(7, this.p, Float64.Ptr, pRetVal)
    get_LargeChange(pRetVal)
      => ComCall(8, this.p, Float64.Ptr, pRetVal)
    get_SmallChange(pRetVal)
      => ComCall(9, this.p, Float64.Ptr, pRetVal)
}
struct IScrollItemProvider extends IUnknown {
    static IID := "{2360C714-4BF1-4B26-BA65-9B21316127EB}"
    ScrollIntoView()
      => ComCall(3, this.p)
}
struct ISelectionProvider extends IUnknown {
    static IID := "{FB8B03AF-3BDF-48D4-BD36-1A65793BE168}"
    GetSelection(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    get_CanSelectMultiple(pRetVal)
      => ComCall(4, this.p, BOOL.Ptr, pRetVal)
    get_IsSelectionRequired(pRetVal)
      => ComCall(5, this.p, BOOL.Ptr, pRetVal)
}
struct ISelectionProvider2 extends ISelectionProvider {
    static IID := "{14F68475-EE1C-44F6-A869-D239381F0FE7}"
    get_FirstSelectedItem(retVal)
      => ComCall(6, this.p, IRawElementProviderSimple.Ptr, retVal)
    get_LastSelectedItem(retVal)
      => ComCall(7, this.p, IRawElementProviderSimple.Ptr, retVal)
    get_CurrentSelectedItem(retVal)
      => ComCall(8, this.p, IRawElementProviderSimple.Ptr, retVal)
    get_ItemCount(retVal)
      => ComCall(9, this.p, Int32.Ptr, retVal)
}
struct IScrollProvider extends IUnknown {
    static IID := "{B38B8077-1FC3-42A5-8CAE-D40C2215055A}"
    Scroll(horizontalAmount, verticalAmount)
      => ComCall(3, this.p, ScrollAmount, horizontalAmount, ScrollAmount, verticalAmount)
    SetScrollPercent(horizontalPercent, verticalPercent)
      => ComCall(4, this.p, Float64, horizontalPercent, Float64, verticalPercent)
    get_HorizontalScrollPercent(pRetVal)
      => ComCall(5, this.p, Float64.Ptr, pRetVal)
    get_VerticalScrollPercent(pRetVal)
      => ComCall(6, this.p, Float64.Ptr, pRetVal)
    get_HorizontalViewSize(pRetVal)
      => ComCall(7, this.p, Float64.Ptr, pRetVal)
    get_VerticalViewSize(pRetVal)
      => ComCall(8, this.p, Float64.Ptr, pRetVal)
    get_HorizontallyScrollable(pRetVal)
      => ComCall(9, this.p, BOOL.Ptr, pRetVal)
    get_VerticallyScrollable(pRetVal)
      => ComCall(10, this.p, BOOL.Ptr, pRetVal)
}
struct ISelectionItemProvider extends IUnknown {
    static IID := "{2ACAD808-B2D4-452D-A407-91FF1AD167B2}"
    Select()
      => ComCall(3, this.p)
    AddToSelection()
      => ComCall(4, this.p)
    RemoveFromSelection()
      => ComCall(5, this.p)
    get_IsSelected(pRetVal)
      => ComCall(6, this.p, BOOL.Ptr, pRetVal)
    get_SelectionContainer(pRetVal)
      => ComCall(7, this.p, IRawElementProviderSimple.Ptr, pRetVal)
}
struct ISynchronizedInputProvider extends IUnknown {
    static IID := "{29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}"
    StartListening(inputType)
      => ComCall(3, this.p, SynchronizedInputType, inputType)
    Cancel()
      => ComCall(4, this.p)
}
struct ITableProvider extends IUnknown {
    static IID := "{9C860395-97B3-490A-B52A-858CC22AF166}"
    GetRowHeaders(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetColumnHeaders(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    get_RowOrColumnMajor(pRetVal)
      => ComCall(5, this.p, RowOrColumnMajor.Ptr, pRetVal)
}
struct ITableItemProvider extends IUnknown {
    static IID := "{B9734FA6-771F-4D78-9C90-2517999349CD}"
    GetRowHeaderItems(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetColumnHeaderItems(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct IToggleProvider extends IUnknown {
    static IID := "{56D00BD0-C4F4-433C-A836-1A52A57E0892}"
    Toggle()
      => ComCall(3, this.p)
    get_ToggleState(pRetVal)
      => ComCall(4, this.p, ToggleState.Ptr, pRetVal)
}
struct ITransformProvider extends IUnknown {
    static IID := "{6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}"
    Move(x, y)
      => ComCall(3, this.p, Float64, x, Float64, y)
    Resize(width, height)
      => ComCall(4, this.p, Float64, width, Float64, height)
    Rotate(degrees)
      => ComCall(5, this.p, Float64, degrees)
    get_CanMove(pRetVal)
      => ComCall(6, this.p, BOOL.Ptr, pRetVal)
    get_CanResize(pRetVal)
      => ComCall(7, this.p, BOOL.Ptr, pRetVal)
    get_CanRotate(pRetVal)
      => ComCall(8, this.p, BOOL.Ptr, pRetVal)
}
struct IValueProvider extends IUnknown {
    static IID := "{C7935180-6FB3-4201-B174-7DF73ADBF64A}"
    SetValue(val)
      => ComCall(3, this.p, "Str", val)
    get_Value(pRetVal)
      => ComCall(4, this.p, BSTR.Ptr, pRetVal)
    get_IsReadOnly(pRetVal)
      => ComCall(5, this.p, BOOL.Ptr, pRetVal)
}
struct IWindowProvider extends IUnknown {
    static IID := "{987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}"
    SetVisualState(state)
      => ComCall(3, this.p, WindowVisualState, state)
    Close()
      => ComCall(4, this.p)
    WaitForInputIdle(milliseconds, pRetVal)
      => ComCall(5, this.p, Int32, milliseconds, BOOL.Ptr, pRetVal)
    get_CanMaximize(pRetVal)
      => ComCall(6, this.p, BOOL.Ptr, pRetVal)
    get_CanMinimize(pRetVal)
      => ComCall(7, this.p, BOOL.Ptr, pRetVal)
    get_IsModal(pRetVal)
      => ComCall(8, this.p, BOOL.Ptr, pRetVal)
    get_WindowVisualState(pRetVal)
      => ComCall(9, this.p, WindowVisualState.Ptr, pRetVal)
    get_WindowInteractionState(pRetVal)
      => ComCall(10, this.p, WindowInteractionState.Ptr, pRetVal)
    get_IsTopmost(pRetVal)
      => ComCall(11, this.p, BOOL.Ptr, pRetVal)
}
struct ILegacyIAccessibleProvider extends IUnknown {
    static IID := "{E44C3566-915D-4070-99C6-047BFF5A08F5}"
    Select(flagsSelect)
      => ComCall(3, this.p, Int32, flagsSelect)
    DoDefaultAction()
      => ComCall(4, this.p)
    SetValue(szValue)
      => ComCall(5, this.p, "Str", szValue)
    GetIAccessible(ppAccessible)
      => ComCall(6, this.p, IAccessible.Ptr, ppAccessible)
    get_ChildId(pRetVal)
      => ComCall(7, this.p, Int32.Ptr, pRetVal)
    get_Name(pszName)
      => ComCall(8, this.p, BSTR.Ptr, pszName)
    get_Value(pszValue)
      => ComCall(9, this.p, BSTR.Ptr, pszValue)
    get_Description(pszDescription)
      => ComCall(10, this.p, BSTR.Ptr, pszDescription)
    get_Role(pdwRole)
      => ComCall(11, this.p, UInt32.Ptr, pdwRole)
    get_State(pdwState)
      => ComCall(12, this.p, UInt32.Ptr, pdwState)
    get_Help(pszHelp)
      => ComCall(13, this.p, BSTR.Ptr, pszHelp)
    get_KeyboardShortcut(pszKeyboardShortcut)
      => ComCall(14, this.p, BSTR.Ptr, pszKeyboardShortcut)
    GetSelection(pvarSelectedChildren)
      => ComCall(15, this.p, SAFEARRAY.Ptr.Ptr, pvarSelectedChildren)
    get_DefaultAction(pszDefaultAction)
      => ComCall(16, this.p, BSTR.Ptr, pszDefaultAction)
}
struct IItemContainerProvider extends IUnknown {
    static IID := "{E747770B-39CE-4382-AB30-D8FB3F336F24}"
    FindItemByProperty(pStartAfter, propertyId, value, pFound)
      => ComCall(3, this.p, IRawElementProviderSimple, pStartAfter, UIA_PROPERTY_ID, propertyId, VARIANT, value, IRawElementProviderSimple.Ptr, pFound)
}
struct IVirtualizedItemProvider extends IUnknown {
    static IID := "{CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}"
    Realize()
      => ComCall(3, this.p)
}
struct IObjectModelProvider extends IUnknown {
    static IID := "{3AD86EBD-F5EF-483D-BB18-B1042A475D64}"
    GetUnderlyingObjectModel(ppUnknown)
      => ComCall(3, this.p, IUnknown.Ptr, ppUnknown)
}
struct IAnnotationProvider extends IUnknown {
    static IID := "{F95C7E80-BD63-4601-9782-445EBFF011FC}"
    get_AnnotationTypeId(retVal)
      => ComCall(3, this.p, UIA_ANNOTATIONTYPE.Ptr, retVal)
    get_AnnotationTypeName(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_Author(retVal)
      => ComCall(5, this.p, BSTR.Ptr, retVal)
    get_DateTime(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_Target(retVal)
      => ComCall(7, this.p, IRawElementProviderSimple.Ptr, retVal)
}
struct IStylesProvider extends IUnknown {
    static IID := "{19B6B649-F5D7-4A6D-BDCB-129252BE588A}"
    get_StyleId(retVal)
      => ComCall(3, this.p, UIA_STYLE_ID.Ptr, retVal)
    get_StyleName(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_FillColor(retVal)
      => ComCall(5, this.p, Int32.Ptr, retVal)
    get_FillPatternStyle(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_Shape(retVal)
      => ComCall(7, this.p, BSTR.Ptr, retVal)
    get_FillPatternColor(retVal)
      => ComCall(8, this.p, Int32.Ptr, retVal)
    get_ExtendedProperties(retVal)
      => ComCall(9, this.p, BSTR.Ptr, retVal)
}
struct ISpreadsheetProvider extends IUnknown {
    static IID := "{6F6B5D35-5525-4F80-B758-85473832FFC7}"
    GetItemByName(name, pRetVal)
      => ComCall(3, this.p, "Str", name, IRawElementProviderSimple.Ptr, pRetVal)
}
struct ISpreadsheetItemProvider extends IUnknown {
    static IID := "{EAED4660-7B3D-4879-A2E6-365CE603F3D0}"
    get_Formula(pRetVal)
      => ComCall(3, this.p, BSTR.Ptr, pRetVal)
    GetAnnotationObjects(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetAnnotationTypes(pRetVal)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct ITransformProvider2 extends ITransformProvider {
    static IID := "{4758742F-7AC2-460C-BC48-09FC09308A93}"
    Zoom(zoom)
      => ComCall(9, this.p, Float64, zoom)
    get_CanZoom(pRetVal)
      => ComCall(10, this.p, BOOL.Ptr, pRetVal)
    get_ZoomLevel(pRetVal)
      => ComCall(11, this.p, Float64.Ptr, pRetVal)
    get_ZoomMinimum(pRetVal)
      => ComCall(12, this.p, Float64.Ptr, pRetVal)
    get_ZoomMaximum(pRetVal)
      => ComCall(13, this.p, Float64.Ptr, pRetVal)
    ZoomByUnit(zoomUnit1)
      => ComCall(14, this.p, ZoomUnit, zoomUnit1)
}
struct IDragProvider extends IUnknown {
    static IID := "{6AA7BBBB-7FF9-497D-904F-D20B897929D8}"
    get_IsGrabbed(pRetVal)
      => ComCall(3, this.p, BOOL.Ptr, pRetVal)
    get_DropEffect(pRetVal)
      => ComCall(4, this.p, BSTR.Ptr, pRetVal)
    get_DropEffects(pRetVal)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetGrabbedItems(pRetVal)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct IDropTargetProvider extends IUnknown {
    static IID := "{BAE82BFD-358A-481C-85A0-D8B4D90A5D61}"
    get_DropTargetEffect(pRetVal)
      => ComCall(3, this.p, BSTR.Ptr, pRetVal)
    get_DropTargetEffects(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct ITextRangeProvider extends IUnknown {
    static IID := "{5347AD7B-C355-46F8-AFF5-909033582F63}"
    Clone(pRetVal)
      => ComCall(3, this.p, ITextRangeProvider.Ptr, pRetVal)
    Compare(range, pRetVal)
      => ComCall(4, this.p, ITextRangeProvider, range, BOOL.Ptr, pRetVal)
    CompareEndpoints(endpoint, targetRange, targetEndpoint, pRetVal)
      => ComCall(5, this.p, TextPatternRangeEndpoint, endpoint, ITextRangeProvider, targetRange, TextPatternRangeEndpoint, targetEndpoint, Int32.Ptr, pRetVal)
    ExpandToEnclosingUnit(unit)
      => ComCall(6, this.p, TextUnit, unit)
    FindAttribute(attributeId, val, backward, pRetVal)
      => ComCall(7, this.p, UIA_TEXTATTRIBUTE_ID, attributeId, VARIANT, val, BOOL, backward, ITextRangeProvider.Ptr, pRetVal)
    FindText(text, backward, ignoreCase, pRetVal)
      => ComCall(8, this.p, BSTR, text, BOOL, backward, BOOL, ignoreCase, ITextRangeProvider.Ptr, pRetVal)
    GetAttributeValue(attributeId, pRetVal)
      => ComCall(9, this.p, UIA_TEXTATTRIBUTE_ID, attributeId, VARIANT.Ptr, pRetVal)
    GetBoundingRectangles(pRetVal)
      => ComCall(10, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetEnclosingElement(pRetVal)
      => ComCall(11, this.p, IRawElementProviderSimple.Ptr, pRetVal)
    GetText(maxLength, pRetVal)
      => ComCall(12, this.p, Int32, maxLength, BSTR.Ptr, pRetVal)
    Move(unit, count, pRetVal)
      => ComCall(13, this.p, TextUnit, unit, Int32, count, Int32.Ptr, pRetVal)
    MoveEndpointByUnit(endpoint, unit, count, pRetVal)
      => ComCall(14, this.p, TextPatternRangeEndpoint, endpoint, TextUnit, unit, Int32, count, Int32.Ptr, pRetVal)
    MoveEndpointByRange(endpoint, targetRange, targetEndpoint)
      => ComCall(15, this.p, TextPatternRangeEndpoint, endpoint, ITextRangeProvider, targetRange, TextPatternRangeEndpoint, targetEndpoint)
    Select()
      => ComCall(16, this.p)
    AddToSelection()
      => ComCall(17, this.p)
    RemoveFromSelection()
      => ComCall(18, this.p)
    ScrollIntoView(alignToTop)
      => ComCall(19, this.p, BOOL, alignToTop)
    GetChildren(pRetVal)
      => ComCall(20, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
}
struct ITextProvider extends IUnknown {
    static IID := "{3589C92C-63F3-4367-99BB-ADA653B77CF2}"
    GetSelection(pRetVal)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    GetVisibleRanges(pRetVal)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, pRetVal)
    RangeFromChild(childElement, pRetVal)
      => ComCall(5, this.p, IRawElementProviderSimple, childElement, ITextRangeProvider.Ptr, pRetVal)
    RangeFromPoint(point, pRetVal)
      => ComCall(6, this.p, UiaPoint, point, ITextRangeProvider.Ptr, pRetVal)
    get_DocumentRange(pRetVal)
      => ComCall(7, this.p, ITextRangeProvider.Ptr, pRetVal)
    get_SupportedTextSelection(pRetVal)
      => ComCall(8, this.p, SupportedTextSelection.Ptr, pRetVal)
}
struct ITextProvider2 extends ITextProvider {
    static IID := "{0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}"
    RangeFromAnnotation(annotationElement, pRetVal)
      => ComCall(9, this.p, IRawElementProviderSimple, annotationElement, ITextRangeProvider.Ptr, pRetVal)
    GetCaretRange(isActive, pRetVal)
      => ComCall(10, this.p, BOOL.Ptr, isActive, ITextRangeProvider.Ptr, pRetVal)
}
struct ITextEditProvider extends ITextProvider {
    static IID := "{EA3605B4-3A05-400E-B5F9-4E91B40F6176}"
    GetActiveComposition(pRetVal)
      => ComCall(9, this.p, ITextRangeProvider.Ptr, pRetVal)
    GetConversionTarget(pRetVal)
      => ComCall(10, this.p, ITextRangeProvider.Ptr, pRetVal)
}
struct ITextRangeProvider2 extends ITextRangeProvider {
    static IID := "{9BBCE42C-1921-4F18-89CA-DBA1910A0386}"
    ShowContextMenu()
      => ComCall(21, this.p)
}
struct ITextChildProvider extends IUnknown {
    static IID := "{4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}"
    get_TextContainer(pRetVal)
      => ComCall(3, this.p, IRawElementProviderSimple.Ptr, pRetVal)
    get_TextRange(pRetVal)
      => ComCall(4, this.p, ITextRangeProvider.Ptr, pRetVal)
}
struct ICustomNavigationProvider extends IUnknown {
    static IID := "{2062A28A-8C07-4B94-8E12-7037C622AEB8}"
    Navigate(direction, pRetVal)
      => ComCall(3, this.p, NavigateDirection, direction, IRawElementProviderSimple.Ptr, pRetVal)
}
struct IUIAutomationPatternInstance extends IUnknown {
    static IID := "{C03A7FE4-9431-409F-BED8-AE7C2299BC8D}"
    GetProperty(index, cached, type, pPtr)
      => ComCall(3, this.p, UInt32, index, BOOL, cached, UIAutomationType, type, Struct.Ptr, pPtr)
    CallMethod(index, pParams, cParams)
      => ComCall(4, this.p, UInt32, index, UIAutomationParameter.Ptr, pParams, UInt32, cParams)
}
struct IUIAutomationPatternHandler extends IUnknown {
    static IID := "{D97022F3-A947-465E-8B2A-AC4315FA54E8}"
    CreateClientWrapper(pPatternInstance, pClientWrapper)
      => ComCall(3, this.p, IUIAutomationPatternInstance, pPatternInstance, IUnknown.Ptr, pClientWrapper)
    Dispatch(pTarget, index, pParams, cParams)
      => ComCall(4, this.p, IUnknown, pTarget, UInt32, index, UIAutomationParameter.Ptr, pParams, UInt32, cParams)
}
struct IUIAutomationRegistrar extends IUnknown {
    static IID := "{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}"
    RegisterProperty(property, propertyId)
      => ComCall(3, this.p, UIAutomationPropertyInfo.Ptr, property, Int32.Ptr, propertyId)
    RegisterEvent(event, eventId)
      => ComCall(4, this.p, UIAutomationEventInfo.Ptr, event, Int32.Ptr, eventId)
    RegisterPattern(pattern, pPatternId, pPatternAvailablePropertyId, pPropertyIds, pEventIds)
      => ComCall(5, this.p, UIAutomationPatternInfo.Ptr, pattern, Int32.Ptr, pPatternId, Int32.Ptr, pPatternAvailablePropertyId, UInt32, pPropertyIds.Length, Int32.Ptr, pPropertyIds, UInt32, pEventIds.Length, Int32.Ptr, pEventIds)
}
struct IUIAutomationClientInfo extends IUnknown {
    static IID := "{B2E8A3F1-4C5D-4E7A-8F6B-3D2E1C9A0B8F}"
    get_ProcessId(processId)
      => ComCall(3, this.p, UInt32.Ptr, processId)
    get_ProcessName(processName)
      => ComCall(4, this.p, BSTR.Ptr, processName)
}
struct IUIAutomationClientConnectionCallback extends IUnknown {
    static IID := "{5B8E8F2A-9C7D-4F3E-A1B2-8D6E9F4C0A1B}"
    OnConnected(clientInfo)
      => ComCall(3, this.p, IUIAutomationClientInfo, clientInfo)
    OnDisconnected(clientInfo)
      => ComCall(4, this.p, IUIAutomationClientInfo, clientInfo)
}
struct IUIAutomationClientInfoSource extends IUnknown {
    static IID := "{F4B8A2E1-9C3D-4A7E-8F6B-2D5E4C1A9B8F}"
    RegisterClientConnectionCallback(callback, handle)
      => ComCall(3, this.p, IUIAutomationClientConnectionCallback, callback, Int64.Ptr, handle)
    UnregisterClientConnectionCallback(handle)
      => ComCall(4, this.p, Int64, handle)
    GetConnectedClients(clients)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, clients)
}
struct TreeScope extends Int32 {
    static TreeScope_None := 0
    static TreeScope_Element := 1
    static TreeScope_Children := 2
    static TreeScope_Descendants := 4
    static TreeScope_Parent := 8
    static TreeScope_Ancestors := 16
    static TreeScope_Subtree := 7
}
struct PropertyConditionFlags extends Int32 {
    static PropertyConditionFlags_None := 0
    static PropertyConditionFlags_IgnoreCase := 1
    static PropertyConditionFlags_MatchSubstring := 2
}
struct AutomationElementMode extends Int32 {
    static AutomationElementMode_None := 0
    static AutomationElementMode_Full := 1
}
struct TreeTraversalOptions extends Int32 {
    static TreeTraversalOptions_Default := 0
    static TreeTraversalOptions_PostOrder := 1
    static TreeTraversalOptions_LastToFirstOrder := 2
}
struct ConnectionRecoveryBehaviorOptions extends Int32 {
    static ConnectionRecoveryBehaviorOptions_Disabled := 0
    static ConnectionRecoveryBehaviorOptions_Enabled := 1
}
struct CoalesceEventsOptions extends Int32 {
    static CoalesceEventsOptions_Disabled := 0
    static CoalesceEventsOptions_Enabled := 1
}
struct ExtendedProperty {
    PropertyName : BSTR
    PropertyValue : BSTR
}
struct IUIAutomationElement extends IUnknown {
    static IID := "{D22108AA-8AC5-49A5-837B-37BBB3D7591E}"
    SetFocus()
      => ComCall(3, this.p)
    GetRuntimeId(runtimeId)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, runtimeId)
    FindFirst(scope, condition, found)
      => ComCall(5, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationElement.Ptr, found)
    FindAll(scope, condition, found)
      => ComCall(6, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationElementArray.Ptr, found)
    FindFirstBuildCache(scope, condition, cacheRequest, found)
      => ComCall(7, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, found)
    FindAllBuildCache(scope, condition, cacheRequest, found)
      => ComCall(8, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElementArray.Ptr, found)
    BuildUpdatedCache(cacheRequest, updatedElement)
      => ComCall(9, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, updatedElement)
    GetCurrentPropertyValue(propertyId, retVal)
      => ComCall(10, this.p, UIA_PROPERTY_ID, propertyId, VARIANT.Ptr, retVal)
    GetCurrentPropertyValueEx(propertyId, ignoreDefaultValue, retVal)
      => ComCall(11, this.p, UIA_PROPERTY_ID, propertyId, BOOL, ignoreDefaultValue, VARIANT.Ptr, retVal)
    GetCachedPropertyValue(propertyId, retVal)
      => ComCall(12, this.p, UIA_PROPERTY_ID, propertyId, VARIANT.Ptr, retVal)
    GetCachedPropertyValueEx(propertyId, ignoreDefaultValue, retVal)
      => ComCall(13, this.p, UIA_PROPERTY_ID, propertyId, BOOL, ignoreDefaultValue, VARIANT.Ptr, retVal)
    GetCurrentPatternAs(patternId, riid, patternObject)
      => ComCall(14, this.p, UIA_PATTERN_ID, patternId, GUID.Ptr, riid, Struct.Ptr.Ptr, patternObject)
    GetCachedPatternAs(patternId, riid, patternObject)
      => ComCall(15, this.p, UIA_PATTERN_ID, patternId, GUID.Ptr, riid, Struct.Ptr.Ptr, patternObject)
    GetCurrentPattern(patternId, patternObject)
      => ComCall(16, this.p, UIA_PATTERN_ID, patternId, IUnknown.Ptr, patternObject)
    GetCachedPattern(patternId, patternObject)
      => ComCall(17, this.p, UIA_PATTERN_ID, patternId, IUnknown.Ptr, patternObject)
    GetCachedParent(parent)
      => ComCall(18, this.p, IUIAutomationElement.Ptr, parent)
    GetCachedChildren(children)
      => ComCall(19, this.p, IUIAutomationElementArray.Ptr, children)
    get_CurrentProcessId(retVal)
      => ComCall(20, this.p, Int32.Ptr, retVal)
    get_CurrentControlType(retVal)
      => ComCall(21, this.p, UIA_CONTROLTYPE_ID.Ptr, retVal)
    get_CurrentLocalizedControlType(retVal)
      => ComCall(22, this.p, BSTR.Ptr, retVal)
    get_CurrentName(retVal)
      => ComCall(23, this.p, BSTR.Ptr, retVal)
    get_CurrentAcceleratorKey(retVal)
      => ComCall(24, this.p, BSTR.Ptr, retVal)
    get_CurrentAccessKey(retVal)
      => ComCall(25, this.p, BSTR.Ptr, retVal)
    get_CurrentHasKeyboardFocus(retVal)
      => ComCall(26, this.p, BOOL.Ptr, retVal)
    get_CurrentIsKeyboardFocusable(retVal)
      => ComCall(27, this.p, BOOL.Ptr, retVal)
    get_CurrentIsEnabled(retVal)
      => ComCall(28, this.p, BOOL.Ptr, retVal)
    get_CurrentAutomationId(retVal)
      => ComCall(29, this.p, BSTR.Ptr, retVal)
    get_CurrentClassName(retVal)
      => ComCall(30, this.p, BSTR.Ptr, retVal)
    get_CurrentHelpText(retVal)
      => ComCall(31, this.p, BSTR.Ptr, retVal)
    get_CurrentCulture(retVal)
      => ComCall(32, this.p, Int32.Ptr, retVal)
    get_CurrentIsControlElement(retVal)
      => ComCall(33, this.p, BOOL.Ptr, retVal)
    get_CurrentIsContentElement(retVal)
      => ComCall(34, this.p, BOOL.Ptr, retVal)
    get_CurrentIsPassword(retVal)
      => ComCall(35, this.p, BOOL.Ptr, retVal)
    get_CurrentNativeWindowHandle(retVal)
      => ComCall(36, this.p, HWND.Ptr, retVal)
    get_CurrentItemType(retVal)
      => ComCall(37, this.p, BSTR.Ptr, retVal)
    get_CurrentIsOffscreen(retVal)
      => ComCall(38, this.p, BOOL.Ptr, retVal)
    get_CurrentOrientation(retVal)
      => ComCall(39, this.p, OrientationType.Ptr, retVal)
    get_CurrentFrameworkId(retVal)
      => ComCall(40, this.p, BSTR.Ptr, retVal)
    get_CurrentIsRequiredForForm(retVal)
      => ComCall(41, this.p, BOOL.Ptr, retVal)
    get_CurrentItemStatus(retVal)
      => ComCall(42, this.p, BSTR.Ptr, retVal)
    get_CurrentBoundingRectangle(retVal)
      => ComCall(43, this.p, RECT.Ptr, retVal)
    get_CurrentLabeledBy(retVal)
      => ComCall(44, this.p, IUIAutomationElement.Ptr, retVal)
    get_CurrentAriaRole(retVal)
      => ComCall(45, this.p, BSTR.Ptr, retVal)
    get_CurrentAriaProperties(retVal)
      => ComCall(46, this.p, BSTR.Ptr, retVal)
    get_CurrentIsDataValidForForm(retVal)
      => ComCall(47, this.p, BOOL.Ptr, retVal)
    get_CurrentControllerFor(retVal)
      => ComCall(48, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CurrentDescribedBy(retVal)
      => ComCall(49, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CurrentFlowsTo(retVal)
      => ComCall(50, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CurrentProviderDescription(retVal)
      => ComCall(51, this.p, BSTR.Ptr, retVal)
    get_CachedProcessId(retVal)
      => ComCall(52, this.p, Int32.Ptr, retVal)
    get_CachedControlType(retVal)
      => ComCall(53, this.p, UIA_CONTROLTYPE_ID.Ptr, retVal)
    get_CachedLocalizedControlType(retVal)
      => ComCall(54, this.p, BSTR.Ptr, retVal)
    get_CachedName(retVal)
      => ComCall(55, this.p, BSTR.Ptr, retVal)
    get_CachedAcceleratorKey(retVal)
      => ComCall(56, this.p, BSTR.Ptr, retVal)
    get_CachedAccessKey(retVal)
      => ComCall(57, this.p, BSTR.Ptr, retVal)
    get_CachedHasKeyboardFocus(retVal)
      => ComCall(58, this.p, BOOL.Ptr, retVal)
    get_CachedIsKeyboardFocusable(retVal)
      => ComCall(59, this.p, BOOL.Ptr, retVal)
    get_CachedIsEnabled(retVal)
      => ComCall(60, this.p, BOOL.Ptr, retVal)
    get_CachedAutomationId(retVal)
      => ComCall(61, this.p, BSTR.Ptr, retVal)
    get_CachedClassName(retVal)
      => ComCall(62, this.p, BSTR.Ptr, retVal)
    get_CachedHelpText(retVal)
      => ComCall(63, this.p, BSTR.Ptr, retVal)
    get_CachedCulture(retVal)
      => ComCall(64, this.p, Int32.Ptr, retVal)
    get_CachedIsControlElement(retVal)
      => ComCall(65, this.p, BOOL.Ptr, retVal)
    get_CachedIsContentElement(retVal)
      => ComCall(66, this.p, BOOL.Ptr, retVal)
    get_CachedIsPassword(retVal)
      => ComCall(67, this.p, BOOL.Ptr, retVal)
    get_CachedNativeWindowHandle(retVal)
      => ComCall(68, this.p, HWND.Ptr, retVal)
    get_CachedItemType(retVal)
      => ComCall(69, this.p, BSTR.Ptr, retVal)
    get_CachedIsOffscreen(retVal)
      => ComCall(70, this.p, BOOL.Ptr, retVal)
    get_CachedOrientation(retVal)
      => ComCall(71, this.p, OrientationType.Ptr, retVal)
    get_CachedFrameworkId(retVal)
      => ComCall(72, this.p, BSTR.Ptr, retVal)
    get_CachedIsRequiredForForm(retVal)
      => ComCall(73, this.p, BOOL.Ptr, retVal)
    get_CachedItemStatus(retVal)
      => ComCall(74, this.p, BSTR.Ptr, retVal)
    get_CachedBoundingRectangle(retVal)
      => ComCall(75, this.p, RECT.Ptr, retVal)
    get_CachedLabeledBy(retVal)
      => ComCall(76, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedAriaRole(retVal)
      => ComCall(77, this.p, BSTR.Ptr, retVal)
    get_CachedAriaProperties(retVal)
      => ComCall(78, this.p, BSTR.Ptr, retVal)
    get_CachedIsDataValidForForm(retVal)
      => ComCall(79, this.p, BOOL.Ptr, retVal)
    get_CachedControllerFor(retVal)
      => ComCall(80, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedDescribedBy(retVal)
      => ComCall(81, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedFlowsTo(retVal)
      => ComCall(82, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedProviderDescription(retVal)
      => ComCall(83, this.p, BSTR.Ptr, retVal)
    GetClickablePoint(clickable, gotClickable)
      => ComCall(84, this.p, POINT.Ptr, clickable, BOOL.Ptr, gotClickable)
}
struct IUIAutomationElementArray extends IUnknown {
    static IID := "{14314595-B4BC-4055-95F2-58F2E42C9855}"
    get_Length(length)
      => ComCall(3, this.p, Int32.Ptr, length)
    GetElement(index, element)
      => ComCall(4, this.p, Int32, index, IUIAutomationElement.Ptr, element)
}
struct IUIAutomationCondition extends IUnknown {
    static IID := "{352FFBA8-0973-437C-A61F-F64CAFD81DF9}"
}
struct IUIAutomationBoolCondition extends IUIAutomationCondition {
    static IID := "{1B4E1F2E-75EB-4D0B-8952-5A69988E2307}"
    get_BooleanValue(boolVal)
      => ComCall(3, this.p, BOOL.Ptr, boolVal)
}
struct IUIAutomationPropertyCondition extends IUIAutomationCondition {
    static IID := "{99EBF2CB-5578-4267-9AD4-AFD6EA77E94B}"
    get_PropertyId(propertyId)
      => ComCall(3, this.p, UIA_PROPERTY_ID.Ptr, propertyId)
    get_PropertyValue(propertyValue)
      => ComCall(4, this.p, VARIANT.Ptr, propertyValue)
    get_PropertyConditionFlags(flags)
      => ComCall(5, this.p, PropertyConditionFlags.Ptr, flags)
}
struct IUIAutomationAndCondition extends IUIAutomationCondition {
    static IID := "{A7D0AF36-B912-45FE-9855-091DDC174AEC}"
    get_ChildCount(childCount)
      => ComCall(3, this.p, Int32.Ptr, childCount)
    GetChildrenAsNativeArray(childArray)
      => ComCall(4, this.p, IUIAutomationCondition.Ptr.Ptr, childArray, Int32.Ptr, childArray.Length)
    GetChildren(childArray)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, childArray)
}
struct IUIAutomationOrCondition extends IUIAutomationCondition {
    static IID := "{8753F032-3DB1-47B5-A1FC-6E34A266C712}"
    get_ChildCount(childCount)
      => ComCall(3, this.p, Int32.Ptr, childCount)
    GetChildrenAsNativeArray(childArray)
      => ComCall(4, this.p, IUIAutomationCondition.Ptr.Ptr, childArray, Int32.Ptr, childArray.Length)
    GetChildren(childArray)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, childArray)
}
struct IUIAutomationNotCondition extends IUIAutomationCondition {
    static IID := "{F528B657-847B-498C-8896-D52B565407A1}"
    GetChild(condition)
      => ComCall(3, this.p, IUIAutomationCondition.Ptr, condition)
}
struct IUIAutomationCacheRequest extends IUnknown {
    static IID := "{B32A92B5-BC25-4078-9C08-D7EE95C48E03}"
    AddProperty(propertyId)
      => ComCall(3, this.p, UIA_PROPERTY_ID, propertyId)
    AddPattern(patternId)
      => ComCall(4, this.p, UIA_PATTERN_ID, patternId)
    Clone(clonedRequest)
      => ComCall(5, this.p, IUIAutomationCacheRequest.Ptr, clonedRequest)
    get_TreeScope(scope)
      => ComCall(6, this.p, TreeScope.Ptr, scope)
    put_TreeScope(scope)
      => ComCall(7, this.p, TreeScope, scope)
    get_TreeFilter(filter)
      => ComCall(8, this.p, IUIAutomationCondition.Ptr, filter)
    put_TreeFilter(filter)
      => ComCall(9, this.p, IUIAutomationCondition, filter)
    get_AutomationElementMode(mode)
      => ComCall(10, this.p, AutomationElementMode.Ptr, mode)
    put_AutomationElementMode(mode)
      => ComCall(11, this.p, AutomationElementMode, mode)
}
struct IUIAutomationTreeWalker extends IUnknown {
    static IID := "{4042C624-389C-4AFC-A630-9DF854A541FC}"
    GetParentElement(element, parent)
      => ComCall(3, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, parent)
    GetFirstChildElement(element, first)
      => ComCall(4, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, first)
    GetLastChildElement(element, last)
      => ComCall(5, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, last)
    GetNextSiblingElement(element, next)
      => ComCall(6, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, next)
    GetPreviousSiblingElement(element, previous)
      => ComCall(7, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, previous)
    NormalizeElement(element, normalized)
      => ComCall(8, this.p, IUIAutomationElement, element, IUIAutomationElement.Ptr, normalized)
    GetParentElementBuildCache(element, cacheRequest, parent)
      => ComCall(9, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, parent)
    GetFirstChildElementBuildCache(element, cacheRequest, first)
      => ComCall(10, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, first)
    GetLastChildElementBuildCache(element, cacheRequest, last)
      => ComCall(11, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, last)
    GetNextSiblingElementBuildCache(element, cacheRequest, next)
      => ComCall(12, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, next)
    GetPreviousSiblingElementBuildCache(element, cacheRequest, previous)
      => ComCall(13, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, previous)
    NormalizeElementBuildCache(element, cacheRequest, normalized)
      => ComCall(14, this.p, IUIAutomationElement, element, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, normalized)
    get_Condition(condition)
      => ComCall(15, this.p, IUIAutomationCondition.Ptr, condition)
}
struct IUIAutomationEventHandler extends IUnknown {
    static IID := "{146C3C17-F12E-4E22-8C27-F894B9B79C69}"
    HandleAutomationEvent(sender, eventId)
      => ComCall(3, this.p, IUIAutomationElement, sender, UIA_EVENT_ID, eventId)
}
struct IUIAutomationPropertyChangedEventHandler extends IUnknown {
    static IID := "{40CD37D4-C756-4B0C-8C6F-BDDFEEB13B50}"
    HandlePropertyChangedEvent(sender, propertyId, newValue)
      => ComCall(3, this.p, IUIAutomationElement, sender, UIA_PROPERTY_ID, propertyId, VARIANT, newValue)
}
struct IUIAutomationStructureChangedEventHandler extends IUnknown {
    static IID := "{E81D1B4E-11C5-42F8-9754-E7036C79F054}"
    HandleStructureChangedEvent(sender, changeType, runtimeId)
      => ComCall(3, this.p, IUIAutomationElement, sender, StructureChangeType, changeType, SAFEARRAY.Ptr, runtimeId)
}
struct IUIAutomationFocusChangedEventHandler extends IUnknown {
    static IID := "{C270F6B5-5C69-4290-9745-7A7F97169468}"
    HandleFocusChangedEvent(sender)
      => ComCall(3, this.p, IUIAutomationElement, sender)
}
struct IUIAutomationTextEditTextChangedEventHandler extends IUnknown {
    static IID := "{92FAA680-E704-4156-931A-E32D5BB38F3F}"
    HandleTextEditTextChangedEvent(sender, textEditChangeType1, eventStrings)
      => ComCall(3, this.p, IUIAutomationElement, sender, TextEditChangeType, textEditChangeType1, SAFEARRAY.Ptr, eventStrings)
}
struct IUIAutomationChangesEventHandler extends IUnknown {
    static IID := "{58EDCA55-2C3E-4980-B1B9-56C17F27A2A0}"
    HandleChangesEvent(sender, uiaChanges)
      => ComCall(3, this.p, IUIAutomationElement, sender, UiaChangeInfo.Ptr, uiaChanges, Int32, uiaChanges.Length)
}
struct IUIAutomationNotificationEventHandler extends IUnknown {
    static IID := "{C7CB2637-E6C2-4D0C-85DE-4948C02175C7}"
    HandleNotificationEvent(sender, notificationKind1, notificationProcessing1, displayString, activityId)
      => ComCall(3, this.p, IUIAutomationElement, sender, NotificationKind, notificationKind1, NotificationProcessing, notificationProcessing1, BSTR, displayString, BSTR, activityId)
}
struct IUIAutomationInvokePattern extends IUnknown {
    static IID := "{FB377FBE-8EA6-46D5-9C73-6499642D3059}"
    Invoke()
      => ComCall(3, this.p)
}
struct IUIAutomationDockPattern extends IUnknown {
    static IID := "{FDE5EF97-1464-48F6-90BF-43D0948E86EC}"
    SetDockPosition(dockPos)
      => ComCall(3, this.p, DockPosition, dockPos)
    get_CurrentDockPosition(retVal)
      => ComCall(4, this.p, DockPosition.Ptr, retVal)
    get_CachedDockPosition(retVal)
      => ComCall(5, this.p, DockPosition.Ptr, retVal)
}
struct IUIAutomationExpandCollapsePattern extends IUnknown {
    static IID := "{619BE086-1F4E-4EE4-BAFA-210128738730}"
    Expand()
      => ComCall(3, this.p)
    Collapse()
      => ComCall(4, this.p)
    get_CurrentExpandCollapseState(retVal)
      => ComCall(5, this.p, ExpandCollapseState.Ptr, retVal)
    get_CachedExpandCollapseState(retVal)
      => ComCall(6, this.p, ExpandCollapseState.Ptr, retVal)
}
struct IUIAutomationGridPattern extends IUnknown {
    static IID := "{414C3CDC-856B-4F5B-8538-3131C6302550}"
    GetItem(row, column, element)
      => ComCall(3, this.p, Int32, row, Int32, column, IUIAutomationElement.Ptr, element)
    get_CurrentRowCount(retVal)
      => ComCall(4, this.p, Int32.Ptr, retVal)
    get_CurrentColumnCount(retVal)
      => ComCall(5, this.p, Int32.Ptr, retVal)
    get_CachedRowCount(retVal)
      => ComCall(6, this.p, Int32.Ptr, retVal)
    get_CachedColumnCount(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
}
struct IUIAutomationGridItemPattern extends IUnknown {
    static IID := "{78F8EF57-66C3-4E09-BD7C-E79B2004894D}"
    get_CurrentContainingGrid(retVal)
      => ComCall(3, this.p, IUIAutomationElement.Ptr, retVal)
    get_CurrentRow(retVal)
      => ComCall(4, this.p, Int32.Ptr, retVal)
    get_CurrentColumn(retVal)
      => ComCall(5, this.p, Int32.Ptr, retVal)
    get_CurrentRowSpan(retVal)
      => ComCall(6, this.p, Int32.Ptr, retVal)
    get_CurrentColumnSpan(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    get_CachedContainingGrid(retVal)
      => ComCall(8, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedRow(retVal)
      => ComCall(9, this.p, Int32.Ptr, retVal)
    get_CachedColumn(retVal)
      => ComCall(10, this.p, Int32.Ptr, retVal)
    get_CachedRowSpan(retVal)
      => ComCall(11, this.p, Int32.Ptr, retVal)
    get_CachedColumnSpan(retVal)
      => ComCall(12, this.p, Int32.Ptr, retVal)
}
struct IUIAutomationMultipleViewPattern extends IUnknown {
    static IID := "{8D253C91-1DC5-4BB5-B18F-ADE16FA495E8}"
    GetViewName(view, name)
      => ComCall(3, this.p, Int32, view, BSTR.Ptr, name)
    SetCurrentView(view)
      => ComCall(4, this.p, Int32, view)
    get_CurrentCurrentView(retVal)
      => ComCall(5, this.p, Int32.Ptr, retVal)
    GetCurrentSupportedViews(retVal)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CachedCurrentView(retVal)
      => ComCall(7, this.p, Int32.Ptr, retVal)
    GetCachedSupportedViews(retVal)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, retVal)
}
struct IUIAutomationObjectModelPattern extends IUnknown {
    static IID := "{71C284B3-C14D-4D14-981E-19751B0D756D}"
    GetUnderlyingObjectModel(retVal)
      => ComCall(3, this.p, IUnknown.Ptr, retVal)
}
struct IUIAutomationRangeValuePattern extends IUnknown {
    static IID := "{59213F4F-7346-49E5-B120-80555987A148}"
    SetValue(val)
      => ComCall(3, this.p, Float64, val)
    get_CurrentValue(retVal)
      => ComCall(4, this.p, Float64.Ptr, retVal)
    get_CurrentIsReadOnly(retVal)
      => ComCall(5, this.p, BOOL.Ptr, retVal)
    get_CurrentMaximum(retVal)
      => ComCall(6, this.p, Float64.Ptr, retVal)
    get_CurrentMinimum(retVal)
      => ComCall(7, this.p, Float64.Ptr, retVal)
    get_CurrentLargeChange(retVal)
      => ComCall(8, this.p, Float64.Ptr, retVal)
    get_CurrentSmallChange(retVal)
      => ComCall(9, this.p, Float64.Ptr, retVal)
    get_CachedValue(retVal)
      => ComCall(10, this.p, Float64.Ptr, retVal)
    get_CachedIsReadOnly(retVal)
      => ComCall(11, this.p, BOOL.Ptr, retVal)
    get_CachedMaximum(retVal)
      => ComCall(12, this.p, Float64.Ptr, retVal)
    get_CachedMinimum(retVal)
      => ComCall(13, this.p, Float64.Ptr, retVal)
    get_CachedLargeChange(retVal)
      => ComCall(14, this.p, Float64.Ptr, retVal)
    get_CachedSmallChange(retVal)
      => ComCall(15, this.p, Float64.Ptr, retVal)
}
struct IUIAutomationScrollPattern extends IUnknown {
    static IID := "{88F4D42A-E881-459D-A77C-73BBBB7E02DC}"
    Scroll(horizontalAmount, verticalAmount)
      => ComCall(3, this.p, ScrollAmount, horizontalAmount, ScrollAmount, verticalAmount)
    SetScrollPercent(horizontalPercent, verticalPercent)
      => ComCall(4, this.p, Float64, horizontalPercent, Float64, verticalPercent)
    get_CurrentHorizontalScrollPercent(retVal)
      => ComCall(5, this.p, Float64.Ptr, retVal)
    get_CurrentVerticalScrollPercent(retVal)
      => ComCall(6, this.p, Float64.Ptr, retVal)
    get_CurrentHorizontalViewSize(retVal)
      => ComCall(7, this.p, Float64.Ptr, retVal)
    get_CurrentVerticalViewSize(retVal)
      => ComCall(8, this.p, Float64.Ptr, retVal)
    get_CurrentHorizontallyScrollable(retVal)
      => ComCall(9, this.p, BOOL.Ptr, retVal)
    get_CurrentVerticallyScrollable(retVal)
      => ComCall(10, this.p, BOOL.Ptr, retVal)
    get_CachedHorizontalScrollPercent(retVal)
      => ComCall(11, this.p, Float64.Ptr, retVal)
    get_CachedVerticalScrollPercent(retVal)
      => ComCall(12, this.p, Float64.Ptr, retVal)
    get_CachedHorizontalViewSize(retVal)
      => ComCall(13, this.p, Float64.Ptr, retVal)
    get_CachedVerticalViewSize(retVal)
      => ComCall(14, this.p, Float64.Ptr, retVal)
    get_CachedHorizontallyScrollable(retVal)
      => ComCall(15, this.p, BOOL.Ptr, retVal)
    get_CachedVerticallyScrollable(retVal)
      => ComCall(16, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationScrollItemPattern extends IUnknown {
    static IID := "{B488300F-D015-4F19-9C29-BB595E3645EF}"
    ScrollIntoView()
      => ComCall(3, this.p)
}
struct IUIAutomationSelectionPattern extends IUnknown {
    static IID := "{5ED5202E-B2AC-47A6-B638-4B0BF140D78E}"
    GetCurrentSelection(retVal)
      => ComCall(3, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CurrentCanSelectMultiple(retVal)
      => ComCall(4, this.p, BOOL.Ptr, retVal)
    get_CurrentIsSelectionRequired(retVal)
      => ComCall(5, this.p, BOOL.Ptr, retVal)
    GetCachedSelection(retVal)
      => ComCall(6, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedCanSelectMultiple(retVal)
      => ComCall(7, this.p, BOOL.Ptr, retVal)
    get_CachedIsSelectionRequired(retVal)
      => ComCall(8, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationSelectionPattern2 extends IUIAutomationSelectionPattern {
    static IID := "{0532BFAE-C011-4E32-A343-6D642D798555}"
    get_CurrentFirstSelectedItem(retVal)
      => ComCall(9, this.p, IUIAutomationElement.Ptr, retVal)
    get_CurrentLastSelectedItem(retVal)
      => ComCall(10, this.p, IUIAutomationElement.Ptr, retVal)
    get_CurrentCurrentSelectedItem(retVal)
      => ComCall(11, this.p, IUIAutomationElement.Ptr, retVal)
    get_CurrentItemCount(retVal)
      => ComCall(12, this.p, Int32.Ptr, retVal)
    get_CachedFirstSelectedItem(retVal)
      => ComCall(13, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedLastSelectedItem(retVal)
      => ComCall(14, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedCurrentSelectedItem(retVal)
      => ComCall(15, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedItemCount(retVal)
      => ComCall(16, this.p, Int32.Ptr, retVal)
}
struct IUIAutomationSelectionItemPattern extends IUnknown {
    static IID := "{A8EFA66A-0FDA-421A-9194-38021F3578EA}"
    Select()
      => ComCall(3, this.p)
    AddToSelection()
      => ComCall(4, this.p)
    RemoveFromSelection()
      => ComCall(5, this.p)
    get_CurrentIsSelected(retVal)
      => ComCall(6, this.p, BOOL.Ptr, retVal)
    get_CurrentSelectionContainer(retVal)
      => ComCall(7, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedIsSelected(retVal)
      => ComCall(8, this.p, BOOL.Ptr, retVal)
    get_CachedSelectionContainer(retVal)
      => ComCall(9, this.p, IUIAutomationElement.Ptr, retVal)
}
struct IUIAutomationSynchronizedInputPattern extends IUnknown {
    static IID := "{2233BE0B-AFB7-448B-9FDA-3B378AA5EAE1}"
    StartListening(inputType)
      => ComCall(3, this.p, SynchronizedInputType, inputType)
    Cancel()
      => ComCall(4, this.p)
}
struct IUIAutomationTablePattern extends IUnknown {
    static IID := "{620E691C-EA96-4710-A850-754B24CE2417}"
    GetCurrentRowHeaders(retVal)
      => ComCall(3, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCurrentColumnHeaders(retVal)
      => ComCall(4, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CurrentRowOrColumnMajor(retVal)
      => ComCall(5, this.p, RowOrColumnMajor.Ptr, retVal)
    GetCachedRowHeaders(retVal)
      => ComCall(6, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCachedColumnHeaders(retVal)
      => ComCall(7, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedRowOrColumnMajor(retVal)
      => ComCall(8, this.p, RowOrColumnMajor.Ptr, retVal)
}
struct IUIAutomationTableItemPattern extends IUnknown {
    static IID := "{0B964EB3-EF2E-4464-9C79-61D61737A27E}"
    GetCurrentRowHeaderItems(retVal)
      => ComCall(3, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCurrentColumnHeaderItems(retVal)
      => ComCall(4, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCachedRowHeaderItems(retVal)
      => ComCall(5, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCachedColumnHeaderItems(retVal)
      => ComCall(6, this.p, IUIAutomationElementArray.Ptr, retVal)
}
struct IUIAutomationTogglePattern extends IUnknown {
    static IID := "{94CF8058-9B8D-4AB9-8BFD-4CD0A33C8C70}"
    Toggle()
      => ComCall(3, this.p)
    get_CurrentToggleState(retVal)
      => ComCall(4, this.p, ToggleState.Ptr, retVal)
    get_CachedToggleState(retVal)
      => ComCall(5, this.p, ToggleState.Ptr, retVal)
}
struct IUIAutomationTransformPattern extends IUnknown {
    static IID := "{A9B55844-A55D-4EF0-926D-569C16FF89BB}"
    Move(x, y)
      => ComCall(3, this.p, Float64, x, Float64, y)
    Resize(width, height)
      => ComCall(4, this.p, Float64, width, Float64, height)
    Rotate(degrees)
      => ComCall(5, this.p, Float64, degrees)
    get_CurrentCanMove(retVal)
      => ComCall(6, this.p, BOOL.Ptr, retVal)
    get_CurrentCanResize(retVal)
      => ComCall(7, this.p, BOOL.Ptr, retVal)
    get_CurrentCanRotate(retVal)
      => ComCall(8, this.p, BOOL.Ptr, retVal)
    get_CachedCanMove(retVal)
      => ComCall(9, this.p, BOOL.Ptr, retVal)
    get_CachedCanResize(retVal)
      => ComCall(10, this.p, BOOL.Ptr, retVal)
    get_CachedCanRotate(retVal)
      => ComCall(11, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationValuePattern extends IUnknown {
    static IID := "{A94CD8B1-0844-4CD6-9D2D-640537AB39E9}"
    SetValue(val)
      => ComCall(3, this.p, BSTR, val)
    get_CurrentValue(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_CurrentIsReadOnly(retVal)
      => ComCall(5, this.p, BOOL.Ptr, retVal)
    get_CachedValue(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_CachedIsReadOnly(retVal)
      => ComCall(7, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationWindowPattern extends IUnknown {
    static IID := "{0FAEF453-9208-43EF-BBB2-3B485177864F}"
    Close()
      => ComCall(3, this.p)
    WaitForInputIdle(milliseconds, success)
      => ComCall(4, this.p, Int32, milliseconds, BOOL.Ptr, success)
    SetWindowVisualState(state)
      => ComCall(5, this.p, WindowVisualState, state)
    get_CurrentCanMaximize(retVal)
      => ComCall(6, this.p, BOOL.Ptr, retVal)
    get_CurrentCanMinimize(retVal)
      => ComCall(7, this.p, BOOL.Ptr, retVal)
    get_CurrentIsModal(retVal)
      => ComCall(8, this.p, BOOL.Ptr, retVal)
    get_CurrentIsTopmost(retVal)
      => ComCall(9, this.p, BOOL.Ptr, retVal)
    get_CurrentWindowVisualState(retVal)
      => ComCall(10, this.p, WindowVisualState.Ptr, retVal)
    get_CurrentWindowInteractionState(retVal)
      => ComCall(11, this.p, WindowInteractionState.Ptr, retVal)
    get_CachedCanMaximize(retVal)
      => ComCall(12, this.p, BOOL.Ptr, retVal)
    get_CachedCanMinimize(retVal)
      => ComCall(13, this.p, BOOL.Ptr, retVal)
    get_CachedIsModal(retVal)
      => ComCall(14, this.p, BOOL.Ptr, retVal)
    get_CachedIsTopmost(retVal)
      => ComCall(15, this.p, BOOL.Ptr, retVal)
    get_CachedWindowVisualState(retVal)
      => ComCall(16, this.p, WindowVisualState.Ptr, retVal)
    get_CachedWindowInteractionState(retVal)
      => ComCall(17, this.p, WindowInteractionState.Ptr, retVal)
}
struct IUIAutomationTextRange extends IUnknown {
    static IID := "{A543CC6A-F4AE-494B-8239-C814481187A8}"
    Clone(clonedRange)
      => ComCall(3, this.p, IUIAutomationTextRange.Ptr, clonedRange)
    Compare(range, areSame)
      => ComCall(4, this.p, IUIAutomationTextRange, range, BOOL.Ptr, areSame)
    CompareEndpoints(srcEndPoint, range, targetEndPoint, compValue)
      => ComCall(5, this.p, TextPatternRangeEndpoint, srcEndPoint, IUIAutomationTextRange, range, TextPatternRangeEndpoint, targetEndPoint, Int32.Ptr, compValue)
    ExpandToEnclosingUnit(textUnit1)
      => ComCall(6, this.p, TextUnit, textUnit1)
    FindAttribute(attr, val, backward, found)
      => ComCall(7, this.p, UIA_TEXTATTRIBUTE_ID, attr, VARIANT, val, BOOL, backward, IUIAutomationTextRange.Ptr, found)
    FindText(text, backward, ignoreCase, found)
      => ComCall(8, this.p, BSTR, text, BOOL, backward, BOOL, ignoreCase, IUIAutomationTextRange.Ptr, found)
    GetAttributeValue(attr, value)
      => ComCall(9, this.p, UIA_TEXTATTRIBUTE_ID, attr, VARIANT.Ptr, value)
    GetBoundingRectangles(boundingRects)
      => ComCall(10, this.p, SAFEARRAY.Ptr.Ptr, boundingRects)
    GetEnclosingElement(enclosingElement)
      => ComCall(11, this.p, IUIAutomationElement.Ptr, enclosingElement)
    GetText(maxLength, text)
      => ComCall(12, this.p, Int32, maxLength, BSTR.Ptr, text)
    Move(unit, count, moved)
      => ComCall(13, this.p, TextUnit, unit, Int32, count, Int32.Ptr, moved)
    MoveEndpointByUnit(endpoint, unit, count, moved)
      => ComCall(14, this.p, TextPatternRangeEndpoint, endpoint, TextUnit, unit, Int32, count, Int32.Ptr, moved)
    MoveEndpointByRange(srcEndPoint, range, targetEndPoint)
      => ComCall(15, this.p, TextPatternRangeEndpoint, srcEndPoint, IUIAutomationTextRange, range, TextPatternRangeEndpoint, targetEndPoint)
    Select()
      => ComCall(16, this.p)
    AddToSelection()
      => ComCall(17, this.p)
    RemoveFromSelection()
      => ComCall(18, this.p)
    ScrollIntoView(alignToTop)
      => ComCall(19, this.p, BOOL, alignToTop)
    GetChildren(children)
      => ComCall(20, this.p, IUIAutomationElementArray.Ptr, children)
}
struct IUIAutomationTextRange2 extends IUIAutomationTextRange {
    static IID := "{BB9B40E0-5E04-46BD-9BE0-4B601B9AFAD4}"
    ShowContextMenu()
      => ComCall(21, this.p)
}
struct IUIAutomationTextRange3 extends IUIAutomationTextRange2 {
    static IID := "{6A315D69-5512-4C2E-85F0-53FCE6DD4BC2}"
    GetEnclosingElementBuildCache(cacheRequest, enclosingElement)
      => ComCall(22, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, enclosingElement)
    GetChildrenBuildCache(cacheRequest, children)
      => ComCall(23, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElementArray.Ptr, children)
    GetAttributeValues(attributeIds, attributeValues)
      => ComCall(24, this.p, UIA_TEXTATTRIBUTE_ID.Ptr, attributeIds, Int32, attributeIds.Length, SAFEARRAY.Ptr.Ptr, attributeValues)
}
struct IUIAutomationTextRangeArray extends IUnknown {
    static IID := "{CE4AE76A-E717-4C98-81EA-47371D028EB6}"
    get_Length(length)
      => ComCall(3, this.p, Int32.Ptr, length)
    GetElement(index, element)
      => ComCall(4, this.p, Int32, index, IUIAutomationTextRange.Ptr, element)
}
struct IUIAutomationTextPattern extends IUnknown {
    static IID := "{32EBA289-3583-42C9-9C59-3B6D9A1E9B6A}"
    RangeFromPoint(pt, range)
      => ComCall(3, this.p, POINT, pt, IUIAutomationTextRange.Ptr, range)
    RangeFromChild(child, range)
      => ComCall(4, this.p, IUIAutomationElement, child, IUIAutomationTextRange.Ptr, range)
    GetSelection(ranges)
      => ComCall(5, this.p, IUIAutomationTextRangeArray.Ptr, ranges)
    GetVisibleRanges(ranges)
      => ComCall(6, this.p, IUIAutomationTextRangeArray.Ptr, ranges)
    get_DocumentRange(range)
      => ComCall(7, this.p, IUIAutomationTextRange.Ptr, range)
    get_SupportedTextSelection(supportedTextSelection)
      => ComCall(8, this.p, SupportedTextSelection.Ptr, supportedTextSelection)
}
struct IUIAutomationTextPattern2 extends IUIAutomationTextPattern {
    static IID := "{506A921A-FCC9-409F-B23B-37EB74106872}"
    RangeFromAnnotation(annotation, range)
      => ComCall(9, this.p, IUIAutomationElement, annotation, IUIAutomationTextRange.Ptr, range)
    GetCaretRange(isActive, range)
      => ComCall(10, this.p, BOOL.Ptr, isActive, IUIAutomationTextRange.Ptr, range)
}
struct IUIAutomationTextEditPattern extends IUIAutomationTextPattern {
    static IID := "{17E21576-996C-4870-99D9-BFF323380C06}"
    GetActiveComposition(range)
      => ComCall(9, this.p, IUIAutomationTextRange.Ptr, range)
    GetConversionTarget(range)
      => ComCall(10, this.p, IUIAutomationTextRange.Ptr, range)
}
struct IUIAutomationCustomNavigationPattern extends IUnknown {
    static IID := "{01EA217A-1766-47ED-A6CC-ACF492854B1F}"
    Navigate(direction, pRetVal)
      => ComCall(3, this.p, NavigateDirection, direction, IUIAutomationElement.Ptr, pRetVal)
}
struct IUIAutomationActiveTextPositionChangedEventHandler extends IUnknown {
    static IID := "{F97933B0-8DAE-4496-8997-5BA015FE0D82}"
    HandleActiveTextPositionChangedEvent(sender, range)
      => ComCall(3, this.p, IUIAutomationElement, sender, IUIAutomationTextRange, range)
}
struct IUIAutomationLegacyIAccessiblePattern extends IUnknown {
    static IID := "{828055AD-355B-4435-86D5-3B51C14A9B1B}"
    Select(flagsSelect)
      => ComCall(3, this.p, Int32, flagsSelect)
    DoDefaultAction()
      => ComCall(4, this.p)
    SetValue(szValue)
      => ComCall(5, this.p, "Str", szValue)
    get_CurrentChildId(pRetVal)
      => ComCall(6, this.p, Int32.Ptr, pRetVal)
    get_CurrentName(pszName)
      => ComCall(7, this.p, BSTR.Ptr, pszName)
    get_CurrentValue(pszValue)
      => ComCall(8, this.p, BSTR.Ptr, pszValue)
    get_CurrentDescription(pszDescription)
      => ComCall(9, this.p, BSTR.Ptr, pszDescription)
    get_CurrentRole(pdwRole)
      => ComCall(10, this.p, UInt32.Ptr, pdwRole)
    get_CurrentState(pdwState)
      => ComCall(11, this.p, UInt32.Ptr, pdwState)
    get_CurrentHelp(pszHelp)
      => ComCall(12, this.p, BSTR.Ptr, pszHelp)
    get_CurrentKeyboardShortcut(pszKeyboardShortcut)
      => ComCall(13, this.p, BSTR.Ptr, pszKeyboardShortcut)
    GetCurrentSelection(pvarSelectedChildren)
      => ComCall(14, this.p, IUIAutomationElementArray.Ptr, pvarSelectedChildren)
    get_CurrentDefaultAction(pszDefaultAction)
      => ComCall(15, this.p, BSTR.Ptr, pszDefaultAction)
    get_CachedChildId(pRetVal)
      => ComCall(16, this.p, Int32.Ptr, pRetVal)
    get_CachedName(pszName)
      => ComCall(17, this.p, BSTR.Ptr, pszName)
    get_CachedValue(pszValue)
      => ComCall(18, this.p, BSTR.Ptr, pszValue)
    get_CachedDescription(pszDescription)
      => ComCall(19, this.p, BSTR.Ptr, pszDescription)
    get_CachedRole(pdwRole)
      => ComCall(20, this.p, UInt32.Ptr, pdwRole)
    get_CachedState(pdwState)
      => ComCall(21, this.p, UInt32.Ptr, pdwState)
    get_CachedHelp(pszHelp)
      => ComCall(22, this.p, BSTR.Ptr, pszHelp)
    get_CachedKeyboardShortcut(pszKeyboardShortcut)
      => ComCall(23, this.p, BSTR.Ptr, pszKeyboardShortcut)
    GetCachedSelection(pvarSelectedChildren)
      => ComCall(24, this.p, IUIAutomationElementArray.Ptr, pvarSelectedChildren)
    get_CachedDefaultAction(pszDefaultAction)
      => ComCall(25, this.p, BSTR.Ptr, pszDefaultAction)
    GetIAccessible(ppAccessible)
      => ComCall(26, this.p, IAccessible.Ptr, ppAccessible)
}
struct IUIAutomationItemContainerPattern extends IUnknown {
    static IID := "{C690FDB2-27A8-423C-812D-429773C9084E}"
    FindItemByProperty(pStartAfter, propertyId, value, pFound)
      => ComCall(3, this.p, IUIAutomationElement, pStartAfter, UIA_PROPERTY_ID, propertyId, VARIANT, value, IUIAutomationElement.Ptr, pFound)
}
struct IUIAutomationVirtualizedItemPattern extends IUnknown {
    static IID := "{6BA3D7A6-04CF-4F11-8793-A8D1CDE9969F}"
    Realize()
      => ComCall(3, this.p)
}
struct IUIAutomationAnnotationPattern extends IUnknown {
    static IID := "{9A175B21-339E-41B1-8E8B-623F6B681098}"
    get_CurrentAnnotationTypeId(retVal)
      => ComCall(3, this.p, UIA_ANNOTATIONTYPE.Ptr, retVal)
    get_CurrentAnnotationTypeName(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_CurrentAuthor(retVal)
      => ComCall(5, this.p, BSTR.Ptr, retVal)
    get_CurrentDateTime(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_CurrentTarget(retVal)
      => ComCall(7, this.p, IUIAutomationElement.Ptr, retVal)
    get_CachedAnnotationTypeId(retVal)
      => ComCall(8, this.p, UIA_ANNOTATIONTYPE.Ptr, retVal)
    get_CachedAnnotationTypeName(retVal)
      => ComCall(9, this.p, BSTR.Ptr, retVal)
    get_CachedAuthor(retVal)
      => ComCall(10, this.p, BSTR.Ptr, retVal)
    get_CachedDateTime(retVal)
      => ComCall(11, this.p, BSTR.Ptr, retVal)
    get_CachedTarget(retVal)
      => ComCall(12, this.p, IUIAutomationElement.Ptr, retVal)
}
struct IUIAutomationStylesPattern extends IUnknown {
    static IID := "{85B5F0A2-BD79-484A-AD2B-388C9838D5FB}"
    get_CurrentStyleId(retVal)
      => ComCall(3, this.p, UIA_STYLE_ID.Ptr, retVal)
    get_CurrentStyleName(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_CurrentFillColor(retVal)
      => ComCall(5, this.p, Int32.Ptr, retVal)
    get_CurrentFillPatternStyle(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_CurrentShape(retVal)
      => ComCall(7, this.p, BSTR.Ptr, retVal)
    get_CurrentFillPatternColor(retVal)
      => ComCall(8, this.p, Int32.Ptr, retVal)
    get_CurrentExtendedProperties(retVal)
      => ComCall(9, this.p, BSTR.Ptr, retVal)
    GetCurrentExtendedPropertiesAsArray(propertyArray, propertyCount)
      => ComCall(10, this.p, ExtendedProperty.Ptr.Ptr, propertyArray, Int32.Ptr, propertyCount)
    get_CachedStyleId(retVal)
      => ComCall(11, this.p, UIA_STYLE_ID.Ptr, retVal)
    get_CachedStyleName(retVal)
      => ComCall(12, this.p, BSTR.Ptr, retVal)
    get_CachedFillColor(retVal)
      => ComCall(13, this.p, Int32.Ptr, retVal)
    get_CachedFillPatternStyle(retVal)
      => ComCall(14, this.p, BSTR.Ptr, retVal)
    get_CachedShape(retVal)
      => ComCall(15, this.p, BSTR.Ptr, retVal)
    get_CachedFillPatternColor(retVal)
      => ComCall(16, this.p, Int32.Ptr, retVal)
    get_CachedExtendedProperties(retVal)
      => ComCall(17, this.p, BSTR.Ptr, retVal)
    GetCachedExtendedPropertiesAsArray(propertyArray, propertyCount)
      => ComCall(18, this.p, ExtendedProperty.Ptr.Ptr, propertyArray, Int32.Ptr, propertyCount)
}
struct IUIAutomationSpreadsheetPattern extends IUnknown {
    static IID := "{7517A7C8-FAAE-4DE9-9F08-29B91E8595C1}"
    GetItemByName(name, element)
      => ComCall(3, this.p, BSTR, name, IUIAutomationElement.Ptr, element)
}
struct IUIAutomationSpreadsheetItemPattern extends IUnknown {
    static IID := "{7D4FB86C-8D34-40E1-8E83-62C15204E335}"
    get_CurrentFormula(retVal)
      => ComCall(3, this.p, BSTR.Ptr, retVal)
    GetCurrentAnnotationObjects(retVal)
      => ComCall(4, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCurrentAnnotationTypes(retVal)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CachedFormula(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    GetCachedAnnotationObjects(retVal)
      => ComCall(7, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCachedAnnotationTypes(retVal)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, retVal)
}
struct IUIAutomationTransformPattern2 extends IUIAutomationTransformPattern {
    static IID := "{6D74D017-6ECB-4381-B38B-3C17A48FF1C2}"
    Zoom(zoomValue)
      => ComCall(12, this.p, Float64, zoomValue)
    ZoomByUnit(zoomUnit1)
      => ComCall(13, this.p, ZoomUnit, zoomUnit1)
    get_CurrentCanZoom(retVal)
      => ComCall(14, this.p, BOOL.Ptr, retVal)
    get_CachedCanZoom(retVal)
      => ComCall(15, this.p, BOOL.Ptr, retVal)
    get_CurrentZoomLevel(retVal)
      => ComCall(16, this.p, Float64.Ptr, retVal)
    get_CachedZoomLevel(retVal)
      => ComCall(17, this.p, Float64.Ptr, retVal)
    get_CurrentZoomMinimum(retVal)
      => ComCall(18, this.p, Float64.Ptr, retVal)
    get_CachedZoomMinimum(retVal)
      => ComCall(19, this.p, Float64.Ptr, retVal)
    get_CurrentZoomMaximum(retVal)
      => ComCall(20, this.p, Float64.Ptr, retVal)
    get_CachedZoomMaximum(retVal)
      => ComCall(21, this.p, Float64.Ptr, retVal)
}
struct IUIAutomationTextChildPattern extends IUnknown {
    static IID := "{6552B038-AE05-40C8-ABFD-AA08352AAB86}"
    get_TextContainer(container)
      => ComCall(3, this.p, IUIAutomationElement.Ptr, container)
    get_TextRange(range)
      => ComCall(4, this.p, IUIAutomationTextRange.Ptr, range)
}
struct IUIAutomationDragPattern extends IUnknown {
    static IID := "{1DC7B570-1F54-4BAD-BCDA-D36A722FB7BD}"
    get_CurrentIsGrabbed(retVal)
      => ComCall(3, this.p, BOOL.Ptr, retVal)
    get_CachedIsGrabbed(retVal)
      => ComCall(4, this.p, BOOL.Ptr, retVal)
    get_CurrentDropEffect(retVal)
      => ComCall(5, this.p, BSTR.Ptr, retVal)
    get_CachedDropEffect(retVal)
      => ComCall(6, this.p, BSTR.Ptr, retVal)
    get_CurrentDropEffects(retVal)
      => ComCall(7, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CachedDropEffects(retVal)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    GetCurrentGrabbedItems(retVal)
      => ComCall(9, this.p, IUIAutomationElementArray.Ptr, retVal)
    GetCachedGrabbedItems(retVal)
      => ComCall(10, this.p, IUIAutomationElementArray.Ptr, retVal)
}
struct IUIAutomationDropTargetPattern extends IUnknown {
    static IID := "{69A095F7-EEE4-430E-A46B-FB73B1AE39A5}"
    get_CurrentDropTargetEffect(retVal)
      => ComCall(3, this.p, BSTR.Ptr, retVal)
    get_CachedDropTargetEffect(retVal)
      => ComCall(4, this.p, BSTR.Ptr, retVal)
    get_CurrentDropTargetEffects(retVal)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CachedDropTargetEffects(retVal)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, retVal)
}
struct IUIAutomationElement2 extends IUIAutomationElement {
    static IID := "{6749C683-F70D-4487-A698-5F79D55290D6}"
    get_CurrentOptimizeForVisualContent(retVal)
      => ComCall(85, this.p, BOOL.Ptr, retVal)
    get_CachedOptimizeForVisualContent(retVal)
      => ComCall(86, this.p, BOOL.Ptr, retVal)
    get_CurrentLiveSetting(retVal)
      => ComCall(87, this.p, LiveSetting.Ptr, retVal)
    get_CachedLiveSetting(retVal)
      => ComCall(88, this.p, LiveSetting.Ptr, retVal)
    get_CurrentFlowsFrom(retVal)
      => ComCall(89, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedFlowsFrom(retVal)
      => ComCall(90, this.p, IUIAutomationElementArray.Ptr, retVal)
}
struct IUIAutomationElement3 extends IUIAutomationElement2 {
    static IID := "{8471DF34-AEE0-4A01-A7DE-7DB9AF12C296}"
    ShowContextMenu()
      => ComCall(91, this.p)
    get_CurrentIsPeripheral(retVal)
      => ComCall(92, this.p, BOOL.Ptr, retVal)
    get_CachedIsPeripheral(retVal)
      => ComCall(93, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationElement4 extends IUIAutomationElement3 {
    static IID := "{3B6E233C-52FB-4063-A4C9-77C075C2A06B}"
    get_CurrentPositionInSet(retVal)
      => ComCall(94, this.p, Int32.Ptr, retVal)
    get_CurrentSizeOfSet(retVal)
      => ComCall(95, this.p, Int32.Ptr, retVal)
    get_CurrentLevel(retVal)
      => ComCall(96, this.p, Int32.Ptr, retVal)
    get_CurrentAnnotationTypes(retVal)
      => ComCall(97, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CurrentAnnotationObjects(retVal)
      => ComCall(98, this.p, IUIAutomationElementArray.Ptr, retVal)
    get_CachedPositionInSet(retVal)
      => ComCall(99, this.p, Int32.Ptr, retVal)
    get_CachedSizeOfSet(retVal)
      => ComCall(100, this.p, Int32.Ptr, retVal)
    get_CachedLevel(retVal)
      => ComCall(101, this.p, Int32.Ptr, retVal)
    get_CachedAnnotationTypes(retVal)
      => ComCall(102, this.p, SAFEARRAY.Ptr.Ptr, retVal)
    get_CachedAnnotationObjects(retVal)
      => ComCall(103, this.p, IUIAutomationElementArray.Ptr, retVal)
}
struct IUIAutomationElement5 extends IUIAutomationElement4 {
    static IID := "{98141C1D-0D0E-4175-BBE2-6BFF455842A7}"
    get_CurrentLandmarkType(retVal)
      => ComCall(104, this.p, UIA_LANDMARKTYPE_ID.Ptr, retVal)
    get_CurrentLocalizedLandmarkType(retVal)
      => ComCall(105, this.p, BSTR.Ptr, retVal)
    get_CachedLandmarkType(retVal)
      => ComCall(106, this.p, UIA_LANDMARKTYPE_ID.Ptr, retVal)
    get_CachedLocalizedLandmarkType(retVal)
      => ComCall(107, this.p, BSTR.Ptr, retVal)
}
struct IUIAutomationElement6 extends IUIAutomationElement5 {
    static IID := "{4780D450-8BCA-4977-AFA5-A4A517F555E3}"
    get_CurrentFullDescription(retVal)
      => ComCall(108, this.p, BSTR.Ptr, retVal)
    get_CachedFullDescription(retVal)
      => ComCall(109, this.p, BSTR.Ptr, retVal)
}
struct IUIAutomationElement7 extends IUIAutomationElement6 {
    static IID := "{204E8572-CFC3-4C11-B0C8-7DA7420750B7}"
    FindFirstWithOptions(scope, condition, traversalOptions, root, found)
      => ComCall(110, this.p, TreeScope, scope, IUIAutomationCondition, condition, TreeTraversalOptions, traversalOptions, IUIAutomationElement, root, IUIAutomationElement.Ptr, found)
    FindAllWithOptions(scope, condition, traversalOptions, root, found)
      => ComCall(111, this.p, TreeScope, scope, IUIAutomationCondition, condition, TreeTraversalOptions, traversalOptions, IUIAutomationElement, root, IUIAutomationElementArray.Ptr, found)
    FindFirstWithOptionsBuildCache(scope, condition, cacheRequest, traversalOptions, root, found)
      => ComCall(112, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationCacheRequest, cacheRequest, TreeTraversalOptions, traversalOptions, IUIAutomationElement, root, IUIAutomationElement.Ptr, found)
    FindAllWithOptionsBuildCache(scope, condition, cacheRequest, traversalOptions, root, found)
      => ComCall(113, this.p, TreeScope, scope, IUIAutomationCondition, condition, IUIAutomationCacheRequest, cacheRequest, TreeTraversalOptions, traversalOptions, IUIAutomationElement, root, IUIAutomationElementArray.Ptr, found)
    GetCurrentMetadataValue(targetId, metadataId, returnVal)
      => ComCall(114, this.p, Int32, targetId, UIA_METADATA_ID, metadataId, VARIANT.Ptr, returnVal)
}
struct IUIAutomationElement8 extends IUIAutomationElement7 {
    static IID := "{8C60217D-5411-4CDE-BCC0-1CEDA223830C}"
    get_CurrentHeadingLevel(retVal)
      => ComCall(115, this.p, UIA_HEADINGLEVEL_ID.Ptr, retVal)
    get_CachedHeadingLevel(retVal)
      => ComCall(116, this.p, UIA_HEADINGLEVEL_ID.Ptr, retVal)
}
struct IUIAutomationElement9 extends IUIAutomationElement8 {
    static IID := "{39325FAC-039D-440E-A3A3-5EB81A5CECC3}"
    get_CurrentIsDialog(retVal)
      => ComCall(117, this.p, BOOL.Ptr, retVal)
    get_CachedIsDialog(retVal)
      => ComCall(118, this.p, BOOL.Ptr, retVal)
}
struct IUIAutomationProxyFactory extends IUnknown {
    static IID := "{85B94ECD-849D-42B6-B94D-D6DB23FDF5A4}"
    CreateProvider(hwnd1, idObject, idChild, provider)
      => ComCall(3, this.p, HWND, hwnd1, Int32, idObject, Int32, idChild, IRawElementProviderSimple.Ptr, provider)
    get_ProxyFactoryId(factoryId)
      => ComCall(4, this.p, BSTR.Ptr, factoryId)
}
struct IUIAutomationProxyFactoryEntry extends IUnknown {
    static IID := "{D50E472E-B64B-490C-BCA1-D30696F9F289}"
    get_ProxyFactory(factory)
      => ComCall(3, this.p, IUIAutomationProxyFactory.Ptr, factory)
    get_ClassName(className)
      => ComCall(4, this.p, BSTR.Ptr, className)
    get_ImageName(imageName)
      => ComCall(5, this.p, BSTR.Ptr, imageName)
    get_AllowSubstringMatch(allowSubstringMatch)
      => ComCall(6, this.p, BOOL.Ptr, allowSubstringMatch)
    get_CanCheckBaseClass(canCheckBaseClass)
      => ComCall(7, this.p, BOOL.Ptr, canCheckBaseClass)
    get_NeedsAdviseEvents(adviseEvents)
      => ComCall(8, this.p, BOOL.Ptr, adviseEvents)
    put_ClassName(className)
      => ComCall(9, this.p, "Str", className)
    put_ImageName(imageName)
      => ComCall(10, this.p, "Str", imageName)
    put_AllowSubstringMatch(allowSubstringMatch)
      => ComCall(11, this.p, BOOL, allowSubstringMatch)
    put_CanCheckBaseClass(canCheckBaseClass)
      => ComCall(12, this.p, BOOL, canCheckBaseClass)
    put_NeedsAdviseEvents(adviseEvents)
      => ComCall(13, this.p, BOOL, adviseEvents)
    SetWinEventsForAutomationEvent(eventId, propertyId, winEvents)
      => ComCall(14, this.p, UIA_EVENT_ID, eventId, UIA_PROPERTY_ID, propertyId, SAFEARRAY.Ptr, winEvents)
    GetWinEventsForAutomationEvent(eventId, propertyId, winEvents)
      => ComCall(15, this.p, UIA_EVENT_ID, eventId, UIA_PROPERTY_ID, propertyId, SAFEARRAY.Ptr.Ptr, winEvents)
}
struct IUIAutomationProxyFactoryMapping extends IUnknown {
    static IID := "{09E31E18-872D-4873-93D1-1E541EC133FD}"
    get_Count(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetTable(table)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, table)
    GetEntry(index, entry)
      => ComCall(5, this.p, UInt32, index, IUIAutomationProxyFactoryEntry.Ptr, entry)
    SetTable(factoryList)
      => ComCall(6, this.p, SAFEARRAY.Ptr, factoryList)
    InsertEntries(before, factoryList)
      => ComCall(7, this.p, UInt32, before, SAFEARRAY.Ptr, factoryList)
    InsertEntry(before, factory)
      => ComCall(8, this.p, UInt32, before, IUIAutomationProxyFactoryEntry, factory)
    RemoveEntry(index)
      => ComCall(9, this.p, UInt32, index)
    ClearTable()
      => ComCall(10, this.p)
    RestoreDefaultTable()
      => ComCall(11, this.p)
}
struct IUIAutomationEventHandlerGroup extends IUnknown {
    static IID := "{C9EE12F2-C13B-4408-997C-639914377F4E}"
    AddActiveTextPositionChangedEventHandler(scope, cacheRequest, handler)
      => ComCall(3, this.p, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationActiveTextPositionChangedEventHandler, handler)
    AddAutomationEventHandler(eventId, scope, cacheRequest, handler)
      => ComCall(4, this.p, UIA_EVENT_ID, eventId, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationEventHandler, handler)
    AddChangesEventHandler(scope, changeTypes, cacheRequest, handler)
      => ComCall(5, this.p, TreeScope, scope, Int32.Ptr, changeTypes, Int32, changeTypes.Length, IUIAutomationCacheRequest, cacheRequest, IUIAutomationChangesEventHandler, handler)
    AddNotificationEventHandler(scope, cacheRequest, handler)
      => ComCall(6, this.p, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationNotificationEventHandler, handler)
    AddPropertyChangedEventHandler(scope, cacheRequest, handler, propertyArray)
      => ComCall(7, this.p, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationPropertyChangedEventHandler, handler, UIA_PROPERTY_ID.Ptr, propertyArray, Int32, propertyArray.Length)
    AddStructureChangedEventHandler(scope, cacheRequest, handler)
      => ComCall(8, this.p, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationStructureChangedEventHandler, handler)
    AddTextEditTextChangedEventHandler(scope, textEditChangeType1, cacheRequest, handler)
      => ComCall(9, this.p, TreeScope, scope, TextEditChangeType, textEditChangeType1, IUIAutomationCacheRequest, cacheRequest, IUIAutomationTextEditTextChangedEventHandler, handler)
}
struct IUIAutomation extends IUnknown {
    static IID := "{30CBE57D-D9D0-452A-AB13-7AC5AC4825EE}"
    CompareElements(el1, el2, areSame)
      => ComCall(3, this.p, IUIAutomationElement, el1, IUIAutomationElement, el2, BOOL.Ptr, areSame)
    CompareRuntimeIds(runtimeId1, runtimeId2, areSame)
      => ComCall(4, this.p, SAFEARRAY.Ptr, runtimeId1, SAFEARRAY.Ptr, runtimeId2, BOOL.Ptr, areSame)
    GetRootElement(root)
      => ComCall(5, this.p, IUIAutomationElement.Ptr, root)
    ElementFromHandle(hwnd1, element)
      => ComCall(6, this.p, HWND, hwnd1, IUIAutomationElement.Ptr, element)
    ElementFromPoint(pt, element)
      => ComCall(7, this.p, POINT, pt, IUIAutomationElement.Ptr, element)
    GetFocusedElement(element)
      => ComCall(8, this.p, IUIAutomationElement.Ptr, element)
    GetRootElementBuildCache(cacheRequest, root)
      => ComCall(9, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, root)
    ElementFromHandleBuildCache(hwnd1, cacheRequest, element)
      => ComCall(10, this.p, HWND, hwnd1, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, element)
    ElementFromPointBuildCache(pt, cacheRequest, element)
      => ComCall(11, this.p, POINT, pt, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, element)
    GetFocusedElementBuildCache(cacheRequest, element)
      => ComCall(12, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, element)
    CreateTreeWalker(pCondition, walker)
      => ComCall(13, this.p, IUIAutomationCondition, pCondition, IUIAutomationTreeWalker.Ptr, walker)
    get_ControlViewWalker(walker)
      => ComCall(14, this.p, IUIAutomationTreeWalker.Ptr, walker)
    get_ContentViewWalker(walker)
      => ComCall(15, this.p, IUIAutomationTreeWalker.Ptr, walker)
    get_RawViewWalker(walker)
      => ComCall(16, this.p, IUIAutomationTreeWalker.Ptr, walker)
    get_RawViewCondition(condition)
      => ComCall(17, this.p, IUIAutomationCondition.Ptr, condition)
    get_ControlViewCondition(condition)
      => ComCall(18, this.p, IUIAutomationCondition.Ptr, condition)
    get_ContentViewCondition(condition)
      => ComCall(19, this.p, IUIAutomationCondition.Ptr, condition)
    CreateCacheRequest(cacheRequest)
      => ComCall(20, this.p, IUIAutomationCacheRequest.Ptr, cacheRequest)
    CreateTrueCondition(newCondition)
      => ComCall(21, this.p, IUIAutomationCondition.Ptr, newCondition)
    CreateFalseCondition(newCondition)
      => ComCall(22, this.p, IUIAutomationCondition.Ptr, newCondition)
    CreatePropertyCondition(propertyId, value, newCondition)
      => ComCall(23, this.p, UIA_PROPERTY_ID, propertyId, VARIANT, value, IUIAutomationCondition.Ptr, newCondition)
    CreatePropertyConditionEx(propertyId, value, flags, newCondition)
      => ComCall(24, this.p, UIA_PROPERTY_ID, propertyId, VARIANT, value, PropertyConditionFlags, flags, IUIAutomationCondition.Ptr, newCondition)
    CreateAndCondition(condition1, condition2, newCondition)
      => ComCall(25, this.p, IUIAutomationCondition, condition1, IUIAutomationCondition, condition2, IUIAutomationCondition.Ptr, newCondition)
    CreateAndConditionFromArray(conditions, newCondition)
      => ComCall(26, this.p, SAFEARRAY.Ptr, conditions, IUIAutomationCondition.Ptr, newCondition)
    CreateAndConditionFromNativeArray(conditions, newCondition)
      => ComCall(27, this.p, IUIAutomationCondition.Ptr, conditions, Int32, conditions.Length, IUIAutomationCondition.Ptr, newCondition)
    CreateOrCondition(condition1, condition2, newCondition)
      => ComCall(28, this.p, IUIAutomationCondition, condition1, IUIAutomationCondition, condition2, IUIAutomationCondition.Ptr, newCondition)
    CreateOrConditionFromArray(conditions, newCondition)
      => ComCall(29, this.p, SAFEARRAY.Ptr, conditions, IUIAutomationCondition.Ptr, newCondition)
    CreateOrConditionFromNativeArray(conditions, newCondition)
      => ComCall(30, this.p, IUIAutomationCondition.Ptr, conditions, Int32, conditions.Length, IUIAutomationCondition.Ptr, newCondition)
    CreateNotCondition(condition, newCondition)
      => ComCall(31, this.p, IUIAutomationCondition, condition, IUIAutomationCondition.Ptr, newCondition)
    AddAutomationEventHandler(eventId, element, scope, cacheRequest, handler)
      => ComCall(32, this.p, UIA_EVENT_ID, eventId, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationEventHandler, handler)
    RemoveAutomationEventHandler(eventId, element, handler)
      => ComCall(33, this.p, UIA_EVENT_ID, eventId, IUIAutomationElement, element, IUIAutomationEventHandler, handler)
    AddPropertyChangedEventHandlerNativeArray(element, scope, cacheRequest, handler, propertyArray)
      => ComCall(34, this.p, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationPropertyChangedEventHandler, handler, UIA_PROPERTY_ID.Ptr, propertyArray, Int32, propertyArray.Length)
    AddPropertyChangedEventHandler(element, scope, cacheRequest, handler, propertyArray)
      => ComCall(35, this.p, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationPropertyChangedEventHandler, handler, SAFEARRAY.Ptr, propertyArray)
    RemovePropertyChangedEventHandler(element, handler)
      => ComCall(36, this.p, IUIAutomationElement, element, IUIAutomationPropertyChangedEventHandler, handler)
    AddStructureChangedEventHandler(element, scope, cacheRequest, handler)
      => ComCall(37, this.p, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationStructureChangedEventHandler, handler)
    RemoveStructureChangedEventHandler(element, handler)
      => ComCall(38, this.p, IUIAutomationElement, element, IUIAutomationStructureChangedEventHandler, handler)
    AddFocusChangedEventHandler(cacheRequest, handler)
      => ComCall(39, this.p, IUIAutomationCacheRequest, cacheRequest, IUIAutomationFocusChangedEventHandler, handler)
    RemoveFocusChangedEventHandler(handler)
      => ComCall(40, this.p, IUIAutomationFocusChangedEventHandler, handler)
    RemoveAllEventHandlers()
      => ComCall(41, this.p)
    IntNativeArrayToSafeArray(array, safeArray)
      => ComCall(42, this.p, Int32.Ptr, array, Int32, array.Length, SAFEARRAY.Ptr.Ptr, safeArray)
    IntSafeArrayToNativeArray(intArray, array)
      => ComCall(43, this.p, SAFEARRAY.Ptr, intArray, Int32.Ptr.Ptr, array, Int32.Ptr, array.Length)
    RectToVariant(rc, var)
      => ComCall(44, this.p, RECT, rc, VARIANT.Ptr, var)
    VariantToRect(var, rc)
      => ComCall(45, this.p, VARIANT, var, RECT.Ptr, rc)
    SafeArrayToRectNativeArray(rects, rectArray)
      => ComCall(46, this.p, SAFEARRAY.Ptr, rects, RECT.Ptr.Ptr, rectArray, Int32.Ptr, rectArray.Length)
    CreateProxyFactoryEntry(factory, factoryEntry)
      => ComCall(47, this.p, IUIAutomationProxyFactory, factory, IUIAutomationProxyFactoryEntry.Ptr, factoryEntry)
    get_ProxyFactoryMapping(factoryMapping)
      => ComCall(48, this.p, IUIAutomationProxyFactoryMapping.Ptr, factoryMapping)
    GetPropertyProgrammaticName(property, name)
      => ComCall(49, this.p, UIA_PROPERTY_ID, property, BSTR.Ptr, name)
    GetPatternProgrammaticName(pattern, name)
      => ComCall(50, this.p, UIA_PATTERN_ID, pattern, BSTR.Ptr, name)
    PollForPotentialSupportedPatterns(pElement, patternIds, patternNames)
      => ComCall(51, this.p, IUIAutomationElement, pElement, SAFEARRAY.Ptr.Ptr, patternIds, SAFEARRAY.Ptr.Ptr, patternNames)
    PollForPotentialSupportedProperties(pElement, propertyIds, propertyNames)
      => ComCall(52, this.p, IUIAutomationElement, pElement, SAFEARRAY.Ptr.Ptr, propertyIds, SAFEARRAY.Ptr.Ptr, propertyNames)
    CheckNotSupported(value, isNotSupported)
      => ComCall(53, this.p, VARIANT, value, BOOL.Ptr, isNotSupported)
    get_ReservedNotSupportedValue(notSupportedValue)
      => ComCall(54, this.p, IUnknown.Ptr, notSupportedValue)
    get_ReservedMixedAttributeValue(mixedAttributeValue)
      => ComCall(55, this.p, IUnknown.Ptr, mixedAttributeValue)
    ElementFromIAccessible(accessible, childId, element)
      => ComCall(56, this.p, IAccessible, accessible, Int32, childId, IUIAutomationElement.Ptr, element)
    ElementFromIAccessibleBuildCache(accessible, childId, cacheRequest, element)
      => ComCall(57, this.p, IAccessible, accessible, Int32, childId, IUIAutomationCacheRequest, cacheRequest, IUIAutomationElement.Ptr, element)
}
struct IUIAutomation2 extends IUIAutomation {
    static IID := "{34723AFF-0C9D-49D0-9896-7AB52DF8CD8A}"
    get_AutoSetFocus(autoSetFocus)
      => ComCall(58, this.p, BOOL.Ptr, autoSetFocus)
    put_AutoSetFocus(autoSetFocus)
      => ComCall(59, this.p, BOOL, autoSetFocus)
    get_ConnectionTimeout(timeout)
      => ComCall(60, this.p, UInt32.Ptr, timeout)
    put_ConnectionTimeout(timeout)
      => ComCall(61, this.p, UInt32, timeout)
    get_TransactionTimeout(timeout)
      => ComCall(62, this.p, UInt32.Ptr, timeout)
    put_TransactionTimeout(timeout)
      => ComCall(63, this.p, UInt32, timeout)
}
struct IUIAutomation3 extends IUIAutomation2 {
    static IID := "{73D768DA-9B51-4B89-936E-C209290973E7}"
    AddTextEditTextChangedEventHandler(element, scope, textEditChangeType1, cacheRequest, handler)
      => ComCall(64, this.p, IUIAutomationElement, element, TreeScope, scope, TextEditChangeType, textEditChangeType1, IUIAutomationCacheRequest, cacheRequest, IUIAutomationTextEditTextChangedEventHandler, handler)
    RemoveTextEditTextChangedEventHandler(element, handler)
      => ComCall(65, this.p, IUIAutomationElement, element, IUIAutomationTextEditTextChangedEventHandler, handler)
}
struct IUIAutomation4 extends IUIAutomation3 {
    static IID := "{1189C02A-05F8-4319-8E21-E817E3DB2860}"
    AddChangesEventHandler(element, scope, changeTypes, pCacheRequest, handler)
      => ComCall(66, this.p, IUIAutomationElement, element, TreeScope, scope, Int32.Ptr, changeTypes, Int32, changeTypes.Length, IUIAutomationCacheRequest, pCacheRequest, IUIAutomationChangesEventHandler, handler)
    RemoveChangesEventHandler(element, handler)
      => ComCall(67, this.p, IUIAutomationElement, element, IUIAutomationChangesEventHandler, handler)
}
struct IUIAutomation5 extends IUIAutomation4 {
    static IID := "{25F700C8-D816-4057-A9DC-3CBDEE77E256}"
    AddNotificationEventHandler(element, scope, cacheRequest, handler)
      => ComCall(68, this.p, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationNotificationEventHandler, handler)
    RemoveNotificationEventHandler(element, handler)
      => ComCall(69, this.p, IUIAutomationElement, element, IUIAutomationNotificationEventHandler, handler)
}
struct IUIAutomation6 extends IUIAutomation5 {
    static IID := "{AAE072DA-29E3-413D-87A7-192DBF81ED10}"
    CreateEventHandlerGroup(handlerGroup)
      => ComCall(70, this.p, IUIAutomationEventHandlerGroup.Ptr, handlerGroup)
    AddEventHandlerGroup(element, handlerGroup)
      => ComCall(71, this.p, IUIAutomationElement, element, IUIAutomationEventHandlerGroup, handlerGroup)
    RemoveEventHandlerGroup(element, handlerGroup)
      => ComCall(72, this.p, IUIAutomationElement, element, IUIAutomationEventHandlerGroup, handlerGroup)
    get_ConnectionRecoveryBehavior(connectionRecoveryBehaviorOptions)
      => ComCall(73, this.p, ConnectionRecoveryBehaviorOptions.Ptr, connectionRecoveryBehaviorOptions)
    put_ConnectionRecoveryBehavior(connectionRecoveryBehaviorOptions1)
      => ComCall(74, this.p, ConnectionRecoveryBehaviorOptions, connectionRecoveryBehaviorOptions1)
    get_CoalesceEvents(coalesceEventsOptions)
      => ComCall(75, this.p, CoalesceEventsOptions.Ptr, coalesceEventsOptions)
    put_CoalesceEvents(coalesceEventsOptions1)
      => ComCall(76, this.p, CoalesceEventsOptions, coalesceEventsOptions1)
    AddActiveTextPositionChangedEventHandler(element, scope, cacheRequest, handler)
      => ComCall(77, this.p, IUIAutomationElement, element, TreeScope, scope, IUIAutomationCacheRequest, cacheRequest, IUIAutomationActiveTextPositionChangedEventHandler, handler)
    RemoveActiveTextPositionChangedEventHandler(element, handler)
      => ComCall(78, this.p, IUIAutomationElement, element, IUIAutomationActiveTextPositionChangedEventHandler, handler)
}
struct ConditionType extends Int32 {
    static ConditionType_True := 0
    static ConditionType_False := 1
    static ConditionType_Property := 2
    static ConditionType_And := 3
    static ConditionType_Or := 4
    static ConditionType_Not := 5
}
struct UiaCondition {
    ConditionType : ConditionType
}
struct UiaPropertyCondition {
    ConditionType : ConditionType
    PropertyId : UIA_PROPERTY_ID
    Value : VARIANT
    Flags : PropertyConditionFlags
}
struct UiaAndOrCondition {
    ConditionType : ConditionType
    ppConditions : UiaCondition.Ptr.Ptr
    cConditions : Int32
}
struct UiaNotCondition {
    ConditionType : ConditionType
    pCondition : UiaCondition.Ptr
}
struct UiaCacheRequest {
    pViewCondition : UiaCondition.Ptr
    Scope : TreeScope
    pProperties : Int32.Ptr
    cProperties : Int32
    pPatterns : Int32.Ptr
    cPatterns : Int32
    automationElementMode : AutomationElementMode
}
struct NormalizeState extends Int32 {
    static NormalizeState_None := 0
    static NormalizeState_View := 1
    static NormalizeState_Custom := 2
}
struct UiaFindParams {
    MaxDepth : Int32
    FindFirst : BOOL
    ExcludeRoot : BOOL
    pFindCondition : UiaCondition.Ptr
}
struct ProviderType extends Int32 {
    static ProviderType_BaseHwnd := 0
    static ProviderType_Proxy := 1
    static ProviderType_NonClientArea := 2
}
struct UiaProviderCallback extends FunctionPointer {
    static Types := [HWND, ProviderType, SAFEARRAY.Ptr]
}
struct AutomationIdentifierType extends Int32 {
    static AutomationIdentifierType_Property := 0
    static AutomationIdentifierType_Pattern := 1
    static AutomationIdentifierType_Event := 2
    static AutomationIdentifierType_ControlType := 3
    static AutomationIdentifierType_TextAttribute := 4
    static AutomationIdentifierType_LandmarkType := 5
    static AutomationIdentifierType_Annotation := 6
    static AutomationIdentifierType_Changes := 7
    static AutomationIdentifierType_Style := 8
}
struct EventArgsType extends Int32 {
    static EventArgsType_Simple := 0
    static EventArgsType_PropertyChanged := 1
    static EventArgsType_StructureChanged := 2
    static EventArgsType_AsyncContentLoaded := 3
    static EventArgsType_WindowClosed := 4
    static EventArgsType_TextEditTextChanged := 5
    static EventArgsType_Changes := 6
    static EventArgsType_Notification := 7
    static EventArgsType_ActiveTextPositionChanged := 8
    static EventArgsType_StructuredMarkup := 9
}
struct AsyncContentLoadedState extends Int32 {
    static AsyncContentLoadedState_Beginning := 0
    static AsyncContentLoadedState_Progress := 1
    static AsyncContentLoadedState_Completed := 2
}
struct UiaEventArgs {
    Type : EventArgsType
    EventId : Int32
}
struct UiaPropertyChangedEventArgs {
    Type : EventArgsType
    EventId : UIA_EVENT_ID
    PropertyId : Int32
    OldValue : VARIANT
    NewValue : VARIANT
}
struct UiaStructureChangedEventArgs {
    Type : EventArgsType
    EventId : Int32
    StructureChangeType : StructureChangeType
    pRuntimeId : Int32.Ptr
    cRuntimeIdLen : Int32
}
struct UiaTextEditTextChangedEventArgs {
    Type : EventArgsType
    EventId : Int32
    TextEditChangeType : TextEditChangeType
    pTextChange : SAFEARRAY.Ptr
}
struct UiaChangesEventArgs {
    Type : EventArgsType
    EventId : Int32
    EventIdCount : Int32
    pUiaChanges : UiaChangeInfo.Ptr
}
struct UiaAsyncContentLoadedEventArgs {
    Type : EventArgsType
    EventId : Int32
    AsyncContentLoadedState : AsyncContentLoadedState
    PercentComplete : Float64
}
struct UiaWindowClosedEventArgs {
    Type : EventArgsType
    EventId : Int32
    pRuntimeId : Int32.Ptr
    cRuntimeIdLen : Int32
}
struct UiaEventCallback extends FunctionPointer {
    static Types := [UiaEventArgs.Ptr, SAFEARRAY.Ptr, BSTR, "Void"]
}
struct IRicheditWindowlessAccessibility extends IUnknown {
    static IID := "{983E572D-20CD-460B-9104-83111592DD10}"
    CreateProvider(pSite, ppProvider)
      => ComCall(3, this.p, IRawElementProviderWindowlessSite, pSite, IRawElementProviderSimple.Ptr, ppProvider)
}
struct IRichEditUiaInformation extends IUnknown {
    static IID := "{23969A9D-8546-4032-A1BB-73750CBF3333}"
    GetBoundaryRectangle(pUiaRect)
      => ComCall(3, this.p, UiaRect.Ptr, pUiaRect)
    IsVisible()
      => ComCall(4, this.p)
}
struct SERIALKEYSA {
    cbSize : UInt32 := this.Size
    dwFlags : SERIALKEYS_FLAGS
    lpszActivePort : PSTR
    lpszPort : PSTR
    iBaudRate : UInt32
    iPortState : UInt32
    iActive : UInt32
}
struct SERIALKEYSW {
    cbSize : UInt32 := this.Size
    dwFlags : SERIALKEYS_FLAGS
    lpszActivePort : PWSTR
    lpszPort : PWSTR
    iBaudRate : UInt32
    iPortState : UInt32
    iActive : UInt32
}
struct HIGHCONTRASTA {
    cbSize : UInt32 := this.Size
    dwFlags : HIGHCONTRASTW_FLAGS
    lpszDefaultScheme : PSTR
}
struct HIGHCONTRASTW {
    cbSize : UInt32 := this.Size
    dwFlags : HIGHCONTRASTW_FLAGS
    lpszDefaultScheme : PWSTR
}
struct FILTERKEYS {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    iWaitMSec : UInt32
    iDelayMSec : UInt32
    iRepeatMSec : UInt32
    iBounceMSec : UInt32
}
struct STICKYKEYS {
    cbSize : UInt32 := this.Size
    dwFlags : STICKYKEYS_FLAGS
}
struct MOUSEKEYS {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    iMaxSpeed : UInt32
    iTimeToMaxSpeed : UInt32
    iCtrlSpeed : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct ACCESSTIMEOUT {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    iTimeOutMSec : UInt32
}
struct SOUNDSENTRYA {
    cbSize : UInt32 := this.Size
    dwFlags : SOUNDSENTRY_FLAGS
    iFSTextEffect : SOUNDSENTRY_TEXT_EFFECT
    iFSTextEffectMSec : UInt32
    iFSTextEffectColorBits : UInt32
    iFSGrafEffect : SOUND_SENTRY_GRAPHICS_EFFECT
    iFSGrafEffectMSec : UInt32
    iFSGrafEffectColor : UInt32
    iWindowsEffect : SOUNDSENTRY_WINDOWS_EFFECT
    iWindowsEffectMSec : UInt32
    lpszWindowsEffectDLL : PSTR
    iWindowsEffectOrdinal : UInt32
}
struct SOUNDSENTRYW {
    cbSize : UInt32 := this.Size
    dwFlags : SOUNDSENTRY_FLAGS
    iFSTextEffect : SOUNDSENTRY_TEXT_EFFECT
    iFSTextEffectMSec : UInt32
    iFSTextEffectColorBits : UInt32
    iFSGrafEffect : SOUND_SENTRY_GRAPHICS_EFFECT
    iFSGrafEffectMSec : UInt32
    iFSGrafEffectColor : UInt32
    iWindowsEffect : SOUNDSENTRY_WINDOWS_EFFECT
    iWindowsEffectMSec : UInt32
    lpszWindowsEffectDLL : PWSTR
    iWindowsEffectOrdinal : UInt32
}
struct TOGGLEKEYS {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
}
struct WINEVENTPROC extends FunctionPointer {
    static Types := [HWINEVENTHOOK, UInt32, HWND, Int32, Int32, UInt32, UInt32, "Void"]
}
