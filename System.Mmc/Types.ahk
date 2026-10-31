#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, COLORREF, HRESULT, HWND, LPARAM, LRESULT, PWSTR, VARIANT_BOOL}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HPALETTE}
#Import "..\System.Com\Types.ahk" {IDataObject, IDispatch, IEnumString, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct MMC_PROPERTY_ACTION extends Int32 {
    static MMC_PROPACT_DELETING := 1
    static MMC_PROPACT_CHANGING := 2
    static MMC_PROPACT_INITIALIZED := 3
}
struct MMC_SNAPIN_PROPERTY {
    pszPropName : PWSTR
    varValue : VARIANT
    eAction : MMC_PROPERTY_ACTION
}
struct ISnapinProperties extends IUnknown {
    static IID := "{F7889DA9-4A02-4837-BF89-1A6F2A021010}"
    Initialize(pProperties)
      => ComCall(3, this.p, Properties, pProperties)
    QueryPropertyNames(pCallback)
      => ComCall(4, this.p, ISnapinPropertiesCallback, pCallback)
    PropertiesChanged(pProperties)
      => ComCall(5, this.p, Int32, pProperties.Length, MMC_SNAPIN_PROPERTY.Ptr, pProperties)
}
struct ISnapinPropertiesCallback extends IUnknown {
    static IID := "{A50FA2E5-7E61-45EB-A8D4-9A07B3E851A8}"
    AddPropertyName(pszPropName, dwFlags)
      => ComCall(3, this.p, "Str", pszPropName, UInt32, dwFlags)
}
struct DocumentMode extends Int32 {
    static DocumentMode_Author := 0
    static DocumentMode_User := 1
    static DocumentMode_User_MDI := 2
    static DocumentMode_User_SDI := 3
}
struct ListViewMode extends Int32 {
    static ListMode_Small_Icons := 0
    static ListMode_Large_Icons := 1
    static ListMode_List := 2
    static ListMode_Detail := 3
    static ListMode_Filtered := 4
}
struct ViewOptions extends Int32 {
    static ViewOption_Default := 0
    static ViewOption_ScopeTreeHidden := 1
    static ViewOption_NoToolBars := 2
    static ViewOption_NotPersistable := 4
    static ViewOption_ActionPaneHidden := 8
}
struct ExportListOptions extends Int32 {
    static ExportListOptions_Default := 0
    static ExportListOptions_Unicode := 1
    static ExportListOptions_TabDelimited := 2
    static ExportListOptions_SelectedItemsOnly := 4
}
struct Application extends IDispatch {
    static IID := "{A3AFB9CC-B653-4741-86AB-F0470EC1384C}"
    Help()
      => ComCall(7, this.p, "void")
    Quit()
      => ComCall(8, this.p, "void")
    get_Document(Document)
      => ComCall(9, this.p, Document.Ptr, Document)
    Load(Filename)
      => ComCall(10, this.p, BSTR, Filename)
    get_Frame(Frame)
      => ComCall(11, this.p, Frame.Ptr, Frame)
    get_Visible(Visible)
      => ComCall(12, this.p, BOOL.Ptr, Visible)
    Show()
      => ComCall(13, this.p)
    Hide()
      => ComCall(14, this.p)
    get_UserControl(UserControl)
      => ComCall(15, this.p, BOOL.Ptr, UserControl)
    put_UserControl(UserControl)
      => ComCall(16, this.p, BOOL, UserControl)
    get_VersionMajor(VersionMajor)
      => ComCall(17, this.p, Int32.Ptr, VersionMajor)
    get_VersionMinor(VersionMinor)
      => ComCall(18, this.p, Int32.Ptr, VersionMinor)
}
struct _AppEvents extends IDispatch {
    static IID := "{DE46CBDD-53F5-4635-AF54-4FE71E923D3F}"
    OnQuit(Application1)
      => ComCall(7, this.p, Application, Application1)
    OnDocumentOpen(Document1, New)
      => ComCall(8, this.p, Document, Document1, BOOL, New)
    OnDocumentClose(Document1)
      => ComCall(9, this.p, Document, Document1)
    OnSnapInAdded(Document1, SnapIn1)
      => ComCall(10, this.p, Document, Document1, SnapIn, SnapIn1)
    OnSnapInRemoved(Document1, SnapIn1)
      => ComCall(11, this.p, Document, Document1, SnapIn, SnapIn1)
    OnNewView(View1)
      => ComCall(12, this.p, View, View1)
    OnViewClose(View1)
      => ComCall(13, this.p, View, View1)
    OnViewChange(View1, NewOwnerNode)
      => ComCall(14, this.p, View, View1, Node, NewOwnerNode)
    OnSelectionChange(View1, NewNodes)
      => ComCall(15, this.p, View, View1, Nodes, NewNodes)
    OnContextMenuExecuted(MenuItem1)
      => ComCall(16, this.p, MenuItem, MenuItem1)
    OnToolbarButtonClicked()
      => ComCall(17, this.p)
    OnListUpdated(View1)
      => ComCall(18, this.p, View, View1)
}
struct AppEvents extends IDispatch {
    static IID := "{FC7A4252-78AC-4532-8C5A-563CFE138863}"
}
struct EventConnector extends IDispatch {
    static IID := "{C0BCCD30-DE44-4528-8403-A05A6A1CC8EA}"
    ConnectTo(Application1)
      => ComCall(7, this.p, Application, Application1)
    Disconnect()
      => ComCall(8, this.p)
}
struct Frame extends IDispatch {
    static IID := "{E5E2D970-5BB3-4306-8804-B0968A31C8E6}"
    Maximize()
      => ComCall(7, this.p)
    Minimize()
      => ComCall(8, this.p)
    Restore()
      => ComCall(9, this.p)
    get_Top(Top)
      => ComCall(10, this.p, Int32.Ptr, Top)
    put_Top(top)
      => ComCall(11, this.p, Int32, top)
    get_Bottom(Bottom)
      => ComCall(12, this.p, Int32.Ptr, Bottom)
    put_Bottom(bottom)
      => ComCall(13, this.p, Int32, bottom)
    get_Left(Left)
      => ComCall(14, this.p, Int32.Ptr, Left)
    put_Left(left)
      => ComCall(15, this.p, Int32, left)
    get_Right(Right)
      => ComCall(16, this.p, Int32.Ptr, Right)
    put_Right(right)
      => ComCall(17, this.p, Int32, right)
}
struct Node extends IDispatch {
    static IID := "{F81ED800-7839-4447-945D-8E15DA59CA55}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Property(PropertyName, PropertyValue)
      => ComCall(8, this.p, BSTR, PropertyName, BSTR.Ptr, PropertyValue)
    get_Bookmark(Bookmark)
      => ComCall(9, this.p, BSTR.Ptr, Bookmark)
    IsScopeNode(IsScopeNode)
      => ComCall(10, this.p, BOOL.Ptr, IsScopeNode)
    get_Nodetype(Nodetype)
      => ComCall(11, this.p, BSTR.Ptr, Nodetype)
}
struct ScopeNamespace extends IDispatch {
    static IID := "{EBBB48DC-1A3B-4D86-B786-C21B28389012}"
    GetParent(Node1, Parent)
      => ComCall(7, this.p, Node, Node1, Node.Ptr, Parent)
    GetChild(Node1, Child)
      => ComCall(8, this.p, Node, Node1, Node.Ptr, Child)
    GetNext(Node1, Next)
      => ComCall(9, this.p, Node, Node1, Node.Ptr, Next)
    GetRoot(Root)
      => ComCall(10, this.p, Node.Ptr, Root)
    Expand(Node1)
      => ComCall(11, this.p, Node, Node1)
}
struct Document extends IDispatch {
    static IID := "{225120D6-1E0F-40A3-93FE-1079E6A8017B}"
    Save()
      => ComCall(7, this.p)
    SaveAs(Filename)
      => ComCall(8, this.p, BSTR, Filename)
    Close(SaveChanges)
      => ComCall(9, this.p, BOOL, SaveChanges)
    get_Views(Views)
      => ComCall(10, this.p, Views.Ptr, Views)
    get_SnapIns(SnapIns)
      => ComCall(11, this.p, SnapIns.Ptr, SnapIns)
    get_ActiveView(View)
      => ComCall(12, this.p, View.Ptr, View)
    get_Name(Name)
      => ComCall(13, this.p, BSTR.Ptr, Name)
    put_Name(Name)
      => ComCall(14, this.p, BSTR, Name)
    get_Location(Location)
      => ComCall(15, this.p, BSTR.Ptr, Location)
    get_IsSaved(IsSaved)
      => ComCall(16, this.p, BOOL.Ptr, IsSaved)
    get_Mode(Mode)
      => ComCall(17, this.p, DocumentMode.Ptr, Mode)
    put_Mode(Mode)
      => ComCall(18, this.p, DocumentMode, Mode)
    get_RootNode(Node)
      => ComCall(19, this.p, Node.Ptr, Node)
    get_ScopeNamespace(ScopeNamespace)
      => ComCall(20, this.p, ScopeNamespace.Ptr, ScopeNamespace)
    CreateProperties(Properties)
      => ComCall(21, this.p, Properties.Ptr, Properties)
    get_Application(Application)
      => ComCall(22, this.p, Application.Ptr, Application)
}
struct SnapIn extends IDispatch {
    static IID := "{3BE910F6-3459-49C6-A1BB-41E6BE9DF3EA}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Vendor(Vendor)
      => ComCall(8, this.p, BSTR.Ptr, Vendor)
    get_Version(Version)
      => ComCall(9, this.p, BSTR.Ptr, Version)
    get_Extensions(Extensions)
      => ComCall(10, this.p, Extensions.Ptr, Extensions)
    get_SnapinCLSID(SnapinCLSID)
      => ComCall(11, this.p, BSTR.Ptr, SnapinCLSID)
    get_Properties(Properties)
      => ComCall(12, this.p, Properties.Ptr, Properties)
    EnableAllExtensions(Enable)
      => ComCall(13, this.p, BOOL, Enable)
}
struct SnapIns extends IDispatch {
    static IID := "{2EF3DE1D-B12A-49D1-92C5-0B00798768F1}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    Item(Index, SnapIn)
      => ComCall(8, this.p, Int32, Index, SnapIn.Ptr, SnapIn)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
    Add(SnapinNameOrCLSID, ParentSnapin, Properties, SnapIn)
      => ComCall(10, this.p, BSTR, SnapinNameOrCLSID, VARIANT, ParentSnapin, VARIANT, Properties, SnapIn.Ptr, SnapIn)
    Remove(SnapIn1)
      => ComCall(11, this.p, SnapIn, SnapIn1)
}
struct Extension extends IDispatch {
    static IID := "{AD4D6CA6-912F-409B-A26E-7FD234AEF542}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Vendor(Vendor)
      => ComCall(8, this.p, BSTR.Ptr, Vendor)
    get_Version(Version)
      => ComCall(9, this.p, BSTR.Ptr, Version)
    get_Extensions(Extensions)
      => ComCall(10, this.p, Extensions.Ptr, Extensions)
    get_SnapinCLSID(SnapinCLSID)
      => ComCall(11, this.p, BSTR.Ptr, SnapinCLSID)
    EnableAllExtensions(Enable)
      => ComCall(12, this.p, BOOL, Enable)
    Enable(Enable)
      => ComCall(13, this.p, BOOL, Enable)
}
struct Extensions extends IDispatch {
    static IID := "{82DBEA43-8CA4-44BC-A2CA-D18741059EC8}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    Item(Index, Extension)
      => ComCall(8, this.p, Int32, Index, Extension.Ptr, Extension)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
}
struct Columns extends IDispatch {
    static IID := "{383D4D97-FC44-478B-B139-6323DC48611C}"
    Item(Index, Column)
      => ComCall(7, this.p, Int32, Index, Column.Ptr, Column)
    get_Count(Count)
      => ComCall(8, this.p, Int32.Ptr, Count)
    get__NewEnum(retval)
      => ComCall(9, this.p, IUnknown.Ptr, retval)
}
struct ColumnSortOrder extends Int32 {
    static SortOrder_Ascending := 0
    static SortOrder_Descending := 1
}
struct Column extends IDispatch {
    static IID := "{FD1C5F63-2B16-4D06-9AB3-F45350B940AB}"
    Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Width(Width)
      => ComCall(8, this.p, Int32.Ptr, Width)
    put_Width(Width)
      => ComCall(9, this.p, Int32, Width)
    get_DisplayPosition(DisplayPosition)
      => ComCall(10, this.p, Int32.Ptr, DisplayPosition)
    put_DisplayPosition(Index)
      => ComCall(11, this.p, Int32, Index)
    get_Hidden(Hidden)
      => ComCall(12, this.p, BOOL.Ptr, Hidden)
    put_Hidden(Hidden)
      => ComCall(13, this.p, BOOL, Hidden)
    SetAsSortColumn(SortOrder)
      => ComCall(14, this.p, ColumnSortOrder, SortOrder)
    IsSortColumn(IsSortColumn)
      => ComCall(15, this.p, BOOL.Ptr, IsSortColumn)
}
struct Views extends IDispatch {
    static IID := "{D6B8C29D-A1FF-4D72-AAB0-E381E9B9338D}"
    Item(Index, View)
      => ComCall(7, this.p, Int32, Index, View.Ptr, View)
    get_Count(Count)
      => ComCall(8, this.p, Int32.Ptr, Count)
    Add(Node1, viewOptions1)
      => ComCall(9, this.p, Node, Node1, ViewOptions, viewOptions1)
    get__NewEnum(retval)
      => ComCall(10, this.p, IUnknown.Ptr, retval)
}
struct View extends IDispatch {
    static IID := "{6EFC2DA2-B38C-457E-9ABB-ED2D189B8C38}"
    get_ActiveScopeNode(Node)
      => ComCall(7, this.p, Node.Ptr, Node)
    put_ActiveScopeNode(Node1)
      => ComCall(8, this.p, Node, Node1)
    get_Selection(Nodes)
      => ComCall(9, this.p, Nodes.Ptr, Nodes)
    get_ListItems(Nodes)
      => ComCall(10, this.p, Nodes.Ptr, Nodes)
    SnapinScopeObject(ScopeNode, ScopeNodeObject)
      => ComCall(11, this.p, VARIANT, ScopeNode, IDispatch.Ptr, ScopeNodeObject)
    SnapinSelectionObject(SelectionObject)
      => ComCall(12, this.p, IDispatch.Ptr, SelectionObject)
    Is(View1, TheSame)
      => ComCall(13, this.p, View, View1, VARIANT_BOOL.Ptr, TheSame)
    get_Document(Document)
      => ComCall(14, this.p, Document.Ptr, Document)
    SelectAll()
      => ComCall(15, this.p)
    Select(Node1)
      => ComCall(16, this.p, Node, Node1)
    Deselect(Node1)
      => ComCall(17, this.p, Node, Node1)
    IsSelected(Node1, IsSelected)
      => ComCall(18, this.p, Node, Node1, BOOL.Ptr, IsSelected)
    DisplayScopeNodePropertySheet(ScopeNode)
      => ComCall(19, this.p, VARIANT, ScopeNode)
    DisplaySelectionPropertySheet()
      => ComCall(20, this.p)
    CopyScopeNode(ScopeNode)
      => ComCall(21, this.p, VARIANT, ScopeNode)
    CopySelection()
      => ComCall(22, this.p)
    DeleteScopeNode(ScopeNode)
      => ComCall(23, this.p, VARIANT, ScopeNode)
    DeleteSelection()
      => ComCall(24, this.p)
    RenameScopeNode(NewName, ScopeNode)
      => ComCall(25, this.p, BSTR, NewName, VARIANT, ScopeNode)
    RenameSelectedItem(NewName)
      => ComCall(26, this.p, BSTR, NewName)
    get_ScopeNodeContextMenu(ScopeNode, ContextMenu)
      => ComCall(27, this.p, VARIANT, ScopeNode, ContextMenu.Ptr, ContextMenu)
    get_SelectionContextMenu(ContextMenu)
      => ComCall(28, this.p, ContextMenu.Ptr, ContextMenu)
    RefreshScopeNode(ScopeNode)
      => ComCall(29, this.p, VARIANT, ScopeNode)
    RefreshSelection()
      => ComCall(30, this.p)
    ExecuteSelectionMenuItem(MenuItemPath)
      => ComCall(31, this.p, BSTR, MenuItemPath)
    ExecuteScopeNodeMenuItem(MenuItemPath, ScopeNode)
      => ComCall(32, this.p, BSTR, MenuItemPath, VARIANT, ScopeNode)
    ExecuteShellCommand(Command, Directory, Parameters, WindowState)
      => ComCall(33, this.p, BSTR, Command, BSTR, Directory, BSTR, Parameters, BSTR, WindowState)
    get_Frame(Frame)
      => ComCall(34, this.p, Frame.Ptr, Frame)
    Close()
      => ComCall(35, this.p)
    get_ScopeTreeVisible(Visible)
      => ComCall(36, this.p, BOOL.Ptr, Visible)
    put_ScopeTreeVisible(Visible)
      => ComCall(37, this.p, BOOL, Visible)
    Back()
      => ComCall(38, this.p)
    Forward()
      => ComCall(39, this.p)
    put_StatusBarText(StatusBarText)
      => ComCall(40, this.p, BSTR, StatusBarText)
    get_Memento(Memento)
      => ComCall(41, this.p, BSTR.Ptr, Memento)
    ViewMemento(Memento)
      => ComCall(42, this.p, BSTR, Memento)
    get_Columns(Columns)
      => ComCall(43, this.p, Columns.Ptr, Columns)
    get_CellContents(Node1, Column, CellContents)
      => ComCall(44, this.p, Node, Node1, Int32, Column, BSTR.Ptr, CellContents)
    ExportList(File, exportoptions)
      => ComCall(45, this.p, BSTR, File, ExportListOptions, exportoptions)
    get_ListViewMode(Mode)
      => ComCall(46, this.p, ListViewMode.Ptr, Mode)
    put_ListViewMode(mode)
      => ComCall(47, this.p, ListViewMode, mode)
    get_ControlObject(Control)
      => ComCall(48, this.p, IDispatch.Ptr, Control)
}
struct Nodes extends IDispatch {
    static IID := "{313B01DF-B22F-4D42-B1B8-483CDCF51D35}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    Item(Index, Node)
      => ComCall(8, this.p, Int32, Index, Node.Ptr, Node)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
}
struct ContextMenu extends IDispatch {
    static IID := "{DAB39CE0-25E6-4E07-8362-BA9C95706545}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(IndexOrPath, MenuItem)
      => ComCall(8, this.p, VARIANT, IndexOrPath, MenuItem.Ptr, MenuItem)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
}
struct MenuItem extends IDispatch {
    static IID := "{0178FAD1-B361-4B27-96AD-67C57EBF2E1D}"
    get_DisplayName(DisplayName)
      => ComCall(7, this.p, BSTR.Ptr, DisplayName)
    get_LanguageIndependentName(LanguageIndependentName)
      => ComCall(8, this.p, BSTR.Ptr, LanguageIndependentName)
    get_Path(Path)
      => ComCall(9, this.p, BSTR.Ptr, Path)
    get_LanguageIndependentPath(LanguageIndependentPath)
      => ComCall(10, this.p, BSTR.Ptr, LanguageIndependentPath)
    Execute()
      => ComCall(11, this.p)
    get_Enabled(Enabled)
      => ComCall(12, this.p, BOOL.Ptr, Enabled)
}
struct Properties extends IDispatch {
    static IID := "{2886ABC2-A425-42B2-91C6-E25C0E04581C}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    Item(Name, Property)
      => ComCall(8, this.p, BSTR, Name, Property.Ptr, Property)
    get_Count(Count)
      => ComCall(9, this.p, Int32.Ptr, Count)
    Remove(Name)
      => ComCall(10, this.p, BSTR, Name)
}
struct Property extends IDispatch {
    static IID := "{4600C3A5-E301-41D8-B6D0-EF2E4212E0CA}"
    get_Value(Value)
      => ComCall(7, this.p, VARIANT.Ptr, Value)
    put_Value(Value)
      => ComCall(8, this.p, VARIANT, Value)
    get_Name(Name)
      => ComCall(9, this.p, BSTR.Ptr, Name)
}
struct MMC_RESULT_VIEW_STYLE extends Int32 {
    static MMC_SINGLESEL := 1
    static MMC_SHOWSELALWAYS := 2
    static MMC_NOSORTHEADER := 4
    static MMC_ENSUREFOCUSVISIBLE := 8
}
struct MMC_CONTROL_TYPE extends Int32 {
    static TOOLBAR := 0
    static MENUBUTTON := 1
    static COMBOBOXBAR := 2
}
struct MMC_CONSOLE_VERB extends Int32 {
    static MMC_VERB_NONE := 0
    static MMC_VERB_OPEN := 32768
    static MMC_VERB_COPY := 32769
    static MMC_VERB_PASTE := 32770
    static MMC_VERB_DELETE := 32771
    static MMC_VERB_PROPERTIES := 32772
    static MMC_VERB_RENAME := 32773
    static MMC_VERB_REFRESH := 32774
    static MMC_VERB_PRINT := 32775
    static MMC_VERB_CUT := 32776
    static MMC_VERB_MAX := 32777
    static MMC_VERB_FIRST := 32768
    static MMC_VERB_LAST := 32776
}
struct MMCBUTTON {
    nBitmap : Int32
    idCommand : Int32
    fsState : UInt8
    fsType : UInt8
    lpButtonText : PWSTR
    lpTooltipText : PWSTR
}
struct MMC_BUTTON_STATE extends Int32 {
    static ENABLED := 1
    static CHECKED := 2
    static HIDDEN := 4
    static INDETERMINATE := 8
    static BUTTONPRESSED := 16
}
struct RESULTDATAITEM {
    mask : UInt32
    bScopeItem : BOOL
    itemID : IntPtr
    nIndex : Int32
    nCol : Int32
    str : PWSTR
    nImage : Int32
    nState : UInt32
    lParam : LPARAM
    iIndent : Int32
}
struct RESULTFINDINFO {
    psz : PWSTR
    nStart : Int32
    dwOptions : UInt32
}
struct SCOPEDATAITEM {
    mask : UInt32
    displayname : PWSTR
    nImage : Int32
    nOpenImage : Int32
    nState : UInt32
    cChildren : Int32
    lParam : LPARAM
    relativeID : IntPtr
    ID : IntPtr
}
struct MMC_SCOPE_ITEM_STATE extends Int32 {
    static MMC_SCOPE_ITEM_STATE_NORMAL := 1
    static MMC_SCOPE_ITEM_STATE_BOLD := 2
    static MMC_SCOPE_ITEM_STATE_EXPANDEDONCE := 3
}
struct CONTEXTMENUITEM {
    strName : PWSTR
    strStatusBarText : PWSTR
    lCommandID : Int32
    lInsertionPointID : Int32
    fFlags : Int32
    fSpecialFlags : Int32
}
struct MMC_MENU_COMMAND_IDS extends Int32 {
    static MMCC_STANDARD_VIEW_SELECT := -1
}
struct MENUBUTTONDATA {
    idCommand : Int32
    x : Int32
    y : Int32
}
struct MMC_FILTER_TYPE extends Int32 {
    static MMC_STRING_FILTER := 0
    static MMC_INT_FILTER := 1
    static MMC_FILTER_NOVALUE := 32768
}
struct MMC_FILTERDATA {
    pszText : PWSTR
    cchTextMax : Int32
    lValue : Int32
}
struct MMC_FILTER_CHANGE_CODE extends Int32 {
    static MFCC_DISABLE := 0
    static MFCC_ENABLE := 1
    static MFCC_VALUE_CHANGE := 2
}
struct MMC_RESTORE_VIEW {
    dwSize : UInt32
    cookie : IntPtr
    pViewType : PWSTR
    lViewOptions : Int32
}
struct MMC_EXPANDSYNC_STRUCT {
    bHandled : BOOL
    bExpanding : BOOL
    hItem : IntPtr
}
struct MMC_VISIBLE_COLUMNS {
    nVisibleColumns : Int32
    rgVisibleCols : Int32[1]
}
struct MMC_NOTIFY_TYPE extends Int32 {
    static MMCN_ACTIVATE := 32769
    static MMCN_ADD_IMAGES := 32770
    static MMCN_BTN_CLICK := 32771
    static MMCN_CLICK := 32772
    static MMCN_COLUMN_CLICK := 32773
    static MMCN_CONTEXTMENU := 32774
    static MMCN_CUTORMOVE := 32775
    static MMCN_DBLCLICK := 32776
    static MMCN_DELETE := 32777
    static MMCN_DESELECT_ALL := 32778
    static MMCN_EXPAND := 32779
    static MMCN_HELP := 32780
    static MMCN_MENU_BTNCLICK := 32781
    static MMCN_MINIMIZED := 32782
    static MMCN_PASTE := 32783
    static MMCN_PROPERTY_CHANGE := 32784
    static MMCN_QUERY_PASTE := 32785
    static MMCN_REFRESH := 32786
    static MMCN_REMOVE_CHILDREN := 32787
    static MMCN_RENAME := 32788
    static MMCN_SELECT := 32789
    static MMCN_SHOW := 32790
    static MMCN_VIEW_CHANGE := 32791
    static MMCN_SNAPINHELP := 32792
    static MMCN_CONTEXTHELP := 32793
    static MMCN_INITOCX := 32794
    static MMCN_FILTER_CHANGE := 32795
    static MMCN_FILTERBTN_CLICK := 32796
    static MMCN_RESTORE_VIEW := 32797
    static MMCN_PRINT := 32798
    static MMCN_PRELOAD := 32799
    static MMCN_LISTPAD := 32800
    static MMCN_EXPANDSYNC := 32801
    static MMCN_COLUMNS_CHANGED := 32802
    static MMCN_CANPASTE_OUTOFPROC := 32803
}
struct DATA_OBJECT_TYPES extends Int32 {
    static CCT_SCOPE := 32768
    static CCT_RESULT := 32769
    static CCT_SNAPIN_MANAGER := 32770
    static CCT_UNINITIALIZED := 65535
}
struct SMMCDataObjects {
    count : UInt32
    lpDataObject : IDataObject[1]
}
struct SMMCObjectTypes {
    count : UInt32
    guid : GUID[1]
}
struct SNodeID {
    cBytes : UInt32
    id : UInt8[1]
}
struct SNodeID2 {
    dwFlags : UInt32
    cBytes : UInt32
    id : UInt8[1]
}
struct SColumnSetID {
    dwFlags : UInt32
    cBytes : UInt32
    id : UInt8[1]
}
struct IComponentData extends IUnknown {
    static IID := "{955AB28A-5218-11D0-A985-00C04FD8D565}"
    Initialize(pUnknown)
      => ComCall(3, this.p, IUnknown, pUnknown)
    CreateComponent(ppComponent)
      => ComCall(4, this.p, IComponent.Ptr, ppComponent)
    Notify(lpDataObject, event, arg, param3)
      => ComCall(5, this.p, IDataObject, lpDataObject, MMC_NOTIFY_TYPE, event, LPARAM, arg, LPARAM, param3)
    Destroy()
      => ComCall(6, this.p)
    QueryDataObject(cookie, type, ppDataObject)
      => ComCall(7, this.p, IntPtr, cookie, DATA_OBJECT_TYPES, type, IDataObject.Ptr, ppDataObject)
    GetDisplayInfo(pScopeDataItem)
      => ComCall(8, this.p, SCOPEDATAITEM.Ptr, pScopeDataItem)
    CompareObjects(lpDataObjectA, lpDataObjectB)
      => ComCall(9, this.p, IDataObject, lpDataObjectA, IDataObject, lpDataObjectB)
}
struct IComponent extends IUnknown {
    static IID := "{43136EB2-D36C-11CF-ADBC-00AA00A80033}"
    Initialize(lpConsole)
      => ComCall(3, this.p, IConsole, lpConsole)
    Notify(lpDataObject, event, arg, param3)
      => ComCall(4, this.p, IDataObject, lpDataObject, MMC_NOTIFY_TYPE, event, LPARAM, arg, LPARAM, param3)
    Destroy(cookie)
      => ComCall(5, this.p, IntPtr, cookie)
    QueryDataObject(cookie, type, ppDataObject)
      => ComCall(6, this.p, IntPtr, cookie, DATA_OBJECT_TYPES, type, IDataObject.Ptr, ppDataObject)
    GetResultViewType(cookie, ppViewType, pViewOptions)
      => ComCall(7, this.p, IntPtr, cookie, PWSTR.Ptr, ppViewType, Int32.Ptr, pViewOptions)
    GetDisplayInfo(pResultDataItem)
      => ComCall(8, this.p, RESULTDATAITEM.Ptr, pResultDataItem)
    CompareObjects(lpDataObjectA, lpDataObjectB)
      => ComCall(9, this.p, IDataObject, lpDataObjectA, IDataObject, lpDataObjectB)
}
struct IResultDataCompare extends IUnknown {
    static IID := "{E8315A52-7A1A-11D0-A2D2-00C04FD909DD}"
    Compare(lUserParam, cookieA, cookieB, pnResult)
      => ComCall(3, this.p, LPARAM, lUserParam, IntPtr, cookieA, IntPtr, cookieB, Int32.Ptr, pnResult)
}
struct IResultOwnerData extends IUnknown {
    static IID := "{9CB396D8-EA83-11D0-AEF1-00C04FB6DD2C}"
    FindItem(pFindInfo, pnFoundIndex)
      => ComCall(3, this.p, RESULTFINDINFO.Ptr, pFindInfo, Int32.Ptr, pnFoundIndex)
    CacheHint(nStartIndex, nEndIndex)
      => ComCall(4, this.p, Int32, nStartIndex, Int32, nEndIndex)
    SortItems(nColumn, dwSortOptions, lUserParam)
      => ComCall(5, this.p, Int32, nColumn, UInt32, dwSortOptions, LPARAM, lUserParam)
}
struct IConsole extends IUnknown {
    static IID := "{43136EB1-D36C-11CF-ADBC-00AA00A80033}"
    SetHeader(pHeader)
      => ComCall(3, this.p, IHeaderCtrl, pHeader)
    SetToolbar(pToolbar)
      => ComCall(4, this.p, IToolbar, pToolbar)
    QueryResultView(pUnknown)
      => ComCall(5, this.p, IUnknown.Ptr, pUnknown)
    QueryScopeImageList(ppImageList)
      => ComCall(6, this.p, IImageList.Ptr, ppImageList)
    QueryResultImageList(ppImageList)
      => ComCall(7, this.p, IImageList.Ptr, ppImageList)
    UpdateAllViews(lpDataObject, data, hint)
      => ComCall(8, this.p, IDataObject, lpDataObject, LPARAM, data, IntPtr, hint)
    MessageBox(lpszText, lpszTitle, fuStyle, piRetval)
      => ComCall(9, this.p, "Str", lpszText, "Str", lpszTitle, UInt32, fuStyle, Int32.Ptr, piRetval)
    QueryConsoleVerb(ppConsoleVerb)
      => ComCall(10, this.p, IConsoleVerb.Ptr, ppConsoleVerb)
    SelectScopeItem(hScopeItem)
      => ComCall(11, this.p, IntPtr, hScopeItem)
    GetMainWindow(phwnd)
      => ComCall(12, this.p, HWND.Ptr, phwnd)
    NewWindow(hScopeItem, lOptions)
      => ComCall(13, this.p, IntPtr, hScopeItem, UInt32, lOptions)
}
struct IHeaderCtrl extends IUnknown {
    static IID := "{43136EB3-D36C-11CF-ADBC-00AA00A80033}"
    InsertColumn(nCol, title, nFormat, nWidth)
      => ComCall(3, this.p, Int32, nCol, "Str", title, Int32, nFormat, Int32, nWidth)
    DeleteColumn(nCol)
      => ComCall(4, this.p, Int32, nCol)
    SetColumnText(nCol, title)
      => ComCall(5, this.p, Int32, nCol, "Str", title)
    GetColumnText(nCol, pText)
      => ComCall(6, this.p, Int32, nCol, PWSTR.Ptr, pText)
    SetColumnWidth(nCol, nWidth)
      => ComCall(7, this.p, Int32, nCol, Int32, nWidth)
    GetColumnWidth(nCol, pWidth)
      => ComCall(8, this.p, Int32, nCol, Int32.Ptr, pWidth)
}
struct CCM_INSERTIONPOINTID extends Int32 {
    static CCM_INSERTIONPOINTID_MASK_SPECIAL := -65536
    static CCM_INSERTIONPOINTID_MASK_SHARED := -2147483648
    static CCM_INSERTIONPOINTID_MASK_CREATE_PRIMARY := 1073741824
    static CCM_INSERTIONPOINTID_MASK_ADD_PRIMARY := 536870912
    static CCM_INSERTIONPOINTID_MASK_ADD_3RDPARTY := 268435456
    static CCM_INSERTIONPOINTID_MASK_RESERVED := 268369920
    static CCM_INSERTIONPOINTID_MASK_FLAGINDEX := 31
    static CCM_INSERTIONPOINTID_PRIMARY_TOP := -1610612736
    static CCM_INSERTIONPOINTID_PRIMARY_NEW := -1610612735
    static CCM_INSERTIONPOINTID_PRIMARY_TASK := -1610612734
    static CCM_INSERTIONPOINTID_PRIMARY_VIEW := -1610612733
    static CCM_INSERTIONPOINTID_PRIMARY_HELP := -1610612732
    static CCM_INSERTIONPOINTID_3RDPARTY_NEW := -1879048191
    static CCM_INSERTIONPOINTID_3RDPARTY_TASK := -1879048190
    static CCM_INSERTIONPOINTID_ROOT_MENU := -2147483648
}
struct CCM_INSERTIONALLOWED extends Int32 {
    static CCM_INSERTIONALLOWED_TOP := 1
    static CCM_INSERTIONALLOWED_NEW := 2
    static CCM_INSERTIONALLOWED_TASK := 4
    static CCM_INSERTIONALLOWED_VIEW := 8
}
struct CCM_COMMANDID_MASK_CONSTANTS extends UInt32 {
    static CCM_COMMANDID_MASK_RESERVED := 4294901760
}
struct CCM_SPECIAL extends Int32 {
    static CCM_SPECIAL_SEPARATOR := 1
    static CCM_SPECIAL_SUBMENU := 2
    static CCM_SPECIAL_DEFAULT_ITEM := 4
    static CCM_SPECIAL_INSERTION_POINT := 8
    static CCM_SPECIAL_TESTONLY := 16
    static CCM_SPECIAL_ELEVATION_ICON := 32
}
struct IContextMenuCallback extends IUnknown {
    static IID := "{43136EB7-D36C-11CF-ADBC-00AA00A80033}"
    AddItem(pItem)
      => ComCall(3, this.p, CONTEXTMENUITEM.Ptr, pItem)
}
struct IContextMenuProvider extends IContextMenuCallback {
    static IID := "{43136EB6-D36C-11CF-ADBC-00AA00A80033}"
    EmptyMenuList()
      => ComCall(4, this.p)
    AddPrimaryExtensionItems(piExtension, piDataObject)
      => ComCall(5, this.p, IUnknown, piExtension, IDataObject, piDataObject)
    AddThirdPartyExtensionItems(piDataObject)
      => ComCall(6, this.p, IDataObject, piDataObject)
    ShowContextMenu(hwndParent, xPos, yPos, plSelected)
      => ComCall(7, this.p, HWND, hwndParent, Int32, xPos, Int32, yPos, Int32.Ptr, plSelected)
}
struct IExtendContextMenu extends IUnknown {
    static IID := "{4F3B7A4F-CFAC-11CF-B8E3-00C04FD8D5B0}"
    AddMenuItems(piDataObject, piCallback, pInsertionAllowed)
      => ComCall(3, this.p, IDataObject, piDataObject, IContextMenuCallback, piCallback, Int32.Ptr, pInsertionAllowed)
    Command(lCommandID, piDataObject)
      => ComCall(4, this.p, Int32, lCommandID, IDataObject, piDataObject)
}
struct IImageList extends IUnknown {
    static IID := "{43136EB8-D36C-11CF-ADBC-00AA00A80033}"
    ImageListSetIcon(pIcon, nLoc)
      => ComCall(3, this.p, IntPtr.Ptr, pIcon, Int32, nLoc)
    ImageListSetStrip(pBMapSm, pBMapLg, nStartLoc, cMask)
      => ComCall(4, this.p, IntPtr.Ptr, pBMapSm, IntPtr.Ptr, pBMapLg, Int32, nStartLoc, COLORREF, cMask)
}
struct IResultData extends IUnknown {
    static IID := "{31DA5FA0-E0EB-11CF-9F21-00AA003CA9F6}"
    InsertItem(item)
      => ComCall(3, this.p, RESULTDATAITEM.Ptr, item)
    DeleteItem(itemID, nCol)
      => ComCall(4, this.p, IntPtr, itemID, Int32, nCol)
    FindItemByLParam(lParam1, pItemID)
      => ComCall(5, this.p, LPARAM, lParam1, IntPtr.Ptr, pItemID)
    DeleteAllRsltItems()
      => ComCall(6, this.p)
    SetItem(item)
      => ComCall(7, this.p, RESULTDATAITEM.Ptr, item)
    GetItem(item)
      => ComCall(8, this.p, RESULTDATAITEM.Ptr, item)
    GetNextItem(item)
      => ComCall(9, this.p, RESULTDATAITEM.Ptr, item)
    ModifyItemState(nIndex, itemID, uAdd, uRemove)
      => ComCall(10, this.p, Int32, nIndex, IntPtr, itemID, UInt32, uAdd, UInt32, uRemove)
    ModifyViewStyle(add, remove)
      => ComCall(11, this.p, MMC_RESULT_VIEW_STYLE, add, MMC_RESULT_VIEW_STYLE, remove)
    SetViewMode(lViewMode)
      => ComCall(12, this.p, Int32, lViewMode)
    GetViewMode(lViewMode)
      => ComCall(13, this.p, Int32.Ptr, lViewMode)
    UpdateItem(itemID)
      => ComCall(14, this.p, IntPtr, itemID)
    Sort(nColumn, dwSortOptions, lUserParam)
      => ComCall(15, this.p, Int32, nColumn, UInt32, dwSortOptions, LPARAM, lUserParam)
    SetDescBarText(DescText)
      => ComCall(16, this.p, "Str", DescText)
    SetItemCount(nItemCount, dwOptions)
      => ComCall(17, this.p, Int32, nItemCount, UInt32, dwOptions)
}
struct IConsoleNameSpace extends IUnknown {
    static IID := "{BEDEB620-F24D-11CF-8AFC-00AA003CA9F6}"
    InsertItem(item)
      => ComCall(3, this.p, SCOPEDATAITEM.Ptr, item)
    DeleteItem(hItem, fDeleteThis)
      => ComCall(4, this.p, IntPtr, hItem, Int32, fDeleteThis)
    SetItem(item)
      => ComCall(5, this.p, SCOPEDATAITEM.Ptr, item)
    GetItem(item)
      => ComCall(6, this.p, SCOPEDATAITEM.Ptr, item)
    GetChildItem(item, pItemChild, pCookie)
      => ComCall(7, this.p, IntPtr, item, IntPtr.Ptr, pItemChild, IntPtr.Ptr, pCookie)
    GetNextItem(item, pItemNext, pCookie)
      => ComCall(8, this.p, IntPtr, item, IntPtr.Ptr, pItemNext, IntPtr.Ptr, pCookie)
    GetParentItem(item, pItemParent, pCookie)
      => ComCall(9, this.p, IntPtr, item, IntPtr.Ptr, pItemParent, IntPtr.Ptr, pCookie)
}
struct IConsoleNameSpace2 extends IConsoleNameSpace {
    static IID := "{255F18CC-65DB-11D1-A7DC-00C04FD8D565}"
    Expand(hItem)
      => ComCall(10, this.p, IntPtr, hItem)
    AddExtension(hItem, lpClsid)
      => ComCall(11, this.p, IntPtr, hItem, GUID.Ptr, lpClsid)
}
struct IPropertySheetCallback extends IUnknown {
    static IID := "{85DE64DD-EF21-11CF-A285-00C04FD8DBE6}"
    AddPage(hPage)
      => ComCall(3, this.p, HPROPSHEETPAGE, hPage)
    RemovePage(hPage)
      => ComCall(4, this.p, HPROPSHEETPAGE, hPage)
}
struct IPropertySheetProvider extends IUnknown {
    static IID := "{85DE64DE-EF21-11CF-A285-00C04FD8DBE6}"
    CreatePropertySheet(title, type, cookie, pIDataObjectm, dwOptions)
      => ComCall(3, this.p, "Str", title, UInt8, type, IntPtr, cookie, IDataObject, pIDataObjectm, UInt32, dwOptions)
    FindPropertySheet(hItem, lpComponent, lpDataObject)
      => ComCall(4, this.p, IntPtr, hItem, IComponent, lpComponent, IDataObject, lpDataObject)
    AddPrimaryPages(lpUnknown?, bCreateHandle, hNotifyWindow, bScopePane)
      => ComCall(5, this.p, IUnknown, lpUnknown?, BOOL, bCreateHandle, HWND, hNotifyWindow, BOOL, bScopePane)
    AddExtensionPages()
      => ComCall(6, this.p)
    Show(window, page)
      => ComCall(7, this.p, IntPtr, window, Int32, page)
}
struct IExtendPropertySheet extends IUnknown {
    static IID := "{85DE64DC-EF21-11CF-A285-00C04FD8DBE6}"
    CreatePropertyPages(lpProvider, handle, lpIDataObject)
      => ComCall(3, this.p, IPropertySheetCallback, lpProvider, IntPtr, handle, IDataObject, lpIDataObject)
    QueryPagesFor(lpDataObject)
      => ComCall(4, this.p, IDataObject, lpDataObject)
}
struct IControlbar extends IUnknown {
    static IID := "{69FB811E-6C1C-11D0-A2CB-00C04FD909DD}"
    Create(nType, pExtendControlbar, ppUnknown)
      => ComCall(3, this.p, MMC_CONTROL_TYPE, nType, IExtendControlbar, pExtendControlbar, IUnknown.Ptr, ppUnknown)
    Attach(nType, lpUnknown)
      => ComCall(4, this.p, MMC_CONTROL_TYPE, nType, IUnknown, lpUnknown)
    Detach(lpUnknown)
      => ComCall(5, this.p, IUnknown, lpUnknown)
}
struct IExtendControlbar extends IUnknown {
    static IID := "{49506520-6F40-11D0-A98B-00C04FD8D565}"
    SetControlbar(pControlbar)
      => ComCall(3, this.p, IControlbar, pControlbar)
    ControlbarNotify(event, arg, param2)
      => ComCall(4, this.p, MMC_NOTIFY_TYPE, event, LPARAM, arg, LPARAM, param2)
}
struct IToolbar extends IUnknown {
    static IID := "{43136EB9-D36C-11CF-ADBC-00AA00A80033}"
    AddBitmap(nImages, hbmp, cxSize, cySize, crMask)
      => ComCall(3, this.p, Int32, nImages, HBITMAP, hbmp, Int32, cxSize, Int32, cySize, COLORREF, crMask)
    AddButtons(nButtons, lpButtons)
      => ComCall(4, this.p, Int32, nButtons, MMCBUTTON.Ptr, lpButtons)
    InsertButton(nIndex, lpButton)
      => ComCall(5, this.p, Int32, nIndex, MMCBUTTON.Ptr, lpButton)
    DeleteButton(nIndex)
      => ComCall(6, this.p, Int32, nIndex)
    GetButtonState(idCommand, nState, pState)
      => ComCall(7, this.p, Int32, idCommand, MMC_BUTTON_STATE, nState, BOOL.Ptr, pState)
    SetButtonState(idCommand, nState, bState)
      => ComCall(8, this.p, Int32, idCommand, MMC_BUTTON_STATE, nState, BOOL, bState)
}
struct IConsoleVerb extends IUnknown {
    static IID := "{E49F7A60-74AF-11D0-A286-00C04FD8FE93}"
    GetVerbState(eCmdID, nState, pState)
      => ComCall(3, this.p, MMC_CONSOLE_VERB, eCmdID, MMC_BUTTON_STATE, nState, BOOL.Ptr, pState)
    SetVerbState(eCmdID, nState, bState)
      => ComCall(4, this.p, MMC_CONSOLE_VERB, eCmdID, MMC_BUTTON_STATE, nState, BOOL, bState)
    SetDefaultVerb(eCmdID)
      => ComCall(5, this.p, MMC_CONSOLE_VERB, eCmdID)
    GetDefaultVerb(peCmdID)
      => ComCall(6, this.p, MMC_CONSOLE_VERB.Ptr, peCmdID)
}
struct ISnapinAbout extends IUnknown {
    static IID := "{1245208C-A151-11D0-A7D7-00C04FD909DD}"
    GetSnapinDescription(lpDescription)
      => ComCall(3, this.p, PWSTR.Ptr, lpDescription)
    GetProvider(lpName)
      => ComCall(4, this.p, PWSTR.Ptr, lpName)
    GetSnapinVersion(lpVersion)
      => ComCall(5, this.p, PWSTR.Ptr, lpVersion)
    GetSnapinImage(hAppIcon)
      => ComCall(6, this.p, HICON.Ptr, hAppIcon)
    GetStaticFolderImage(hSmallImage, hSmallImageOpen, hLargeImage, cMask)
      => ComCall(7, this.p, HBITMAP.Ptr, hSmallImage, HBITMAP.Ptr, hSmallImageOpen, HBITMAP.Ptr, hLargeImage, COLORREF.Ptr, cMask)
}
struct IMenuButton extends IUnknown {
    static IID := "{951ED750-D080-11D0-B197-000000000000}"
    AddButton(idCommand, lpButtonText, lpTooltipText)
      => ComCall(3, this.p, Int32, idCommand, "Str", lpButtonText, "Str", lpTooltipText)
    SetButton(idCommand, lpButtonText, lpTooltipText)
      => ComCall(4, this.p, Int32, idCommand, "Str", lpButtonText, "Str", lpTooltipText)
    SetButtonState(idCommand, nState, bState)
      => ComCall(5, this.p, Int32, idCommand, MMC_BUTTON_STATE, nState, BOOL, bState)
}
struct ISnapinHelp extends IUnknown {
    static IID := "{A6B15ACE-DF59-11D0-A7DD-00C04FD909DD}"
    GetHelpTopic(lpCompiledHelpFile)
      => ComCall(3, this.p, PWSTR.Ptr, lpCompiledHelpFile)
}
struct IExtendPropertySheet2 extends IExtendPropertySheet {
    static IID := "{B7A87232-4A51-11D1-A7EA-00C04FD909DD}"
    GetWatermarks(lpIDataObject, lphWatermark, lphHeader, lphPalette, bStretch)
      => ComCall(5, this.p, IDataObject, lpIDataObject, HBITMAP.Ptr, lphWatermark, HBITMAP.Ptr, lphHeader, HPALETTE.Ptr, lphPalette, BOOL.Ptr, bStretch)
}
struct IHeaderCtrl2 extends IHeaderCtrl {
    static IID := "{9757ABB8-1B32-11D1-A7CE-00C04FD8D565}"
    SetChangeTimeOut(uTimeout)
      => ComCall(9, this.p, UInt32, uTimeout)
    SetColumnFilter(nColumn, dwType, pFilterData)
      => ComCall(10, this.p, UInt32, nColumn, UInt32, dwType, MMC_FILTERDATA.Ptr, pFilterData)
    GetColumnFilter(nColumn, pdwType, pFilterData)
      => ComCall(11, this.p, UInt32, nColumn, UInt32.Ptr, pdwType, MMC_FILTERDATA.Ptr, pFilterData)
}
struct ISnapinHelp2 extends ISnapinHelp {
    static IID := "{4861A010-20F9-11D2-A510-00C04FB6DD2C}"
    GetLinkedTopics(lpCompiledHelpFiles)
      => ComCall(4, this.p, PWSTR.Ptr, lpCompiledHelpFiles)
}
struct MMC_TASK_DISPLAY_TYPE extends Int32 {
    static MMC_TASK_DISPLAY_UNINITIALIZED := 0
    static MMC_TASK_DISPLAY_TYPE_SYMBOL := 1
    static MMC_TASK_DISPLAY_TYPE_VANILLA_GIF := 2
    static MMC_TASK_DISPLAY_TYPE_CHOCOLATE_GIF := 3
    static MMC_TASK_DISPLAY_TYPE_BITMAP := 4
}
struct MMC_TASK_DISPLAY_SYMBOL {
    szFontFamilyName : PWSTR
    szURLtoEOT : PWSTR
    szSymbolString : PWSTR
}
struct MMC_TASK_DISPLAY_BITMAP {
    szMouseOverBitmap : PWSTR
    szMouseOffBitmap : PWSTR
}
struct MMC_TASK_DISPLAY_OBJECT {
    eDisplayType : MMC_TASK_DISPLAY_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            uBitmap : MMC_TASK_DISPLAY_BITMAP
            uSymbol : MMC_TASK_DISPLAY_SYMBOL
        }
    }
}
struct MMC_ACTION_TYPE extends Int32 {
    static MMC_ACTION_UNINITIALIZED := -1
    static MMC_ACTION_ID := 0
    static MMC_ACTION_LINK := 1
    static MMC_ACTION_SCRIPT := 2
}
struct MMC_TASK {
    sDisplayObject : MMC_TASK_DISPLAY_OBJECT
    szText : PWSTR
    szHelpString : PWSTR
    eActionType : MMC_ACTION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            nCommandID : IntPtr
            szActionURL : PWSTR
            szScript : PWSTR
        }
    }
}
struct MMC_LISTPAD_INFO {
    szTitle : PWSTR
    szButtonText : PWSTR
    nCommandID : IntPtr
}
struct IEnumTASK extends IUnknown {
    static IID := "{338698B1-5A02-11D1-9FEC-00600832DB4A}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, MMC_TASK.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumTASK.Ptr, ppenum)
}
struct IExtendTaskPad extends IUnknown {
    static IID := "{8DEE6511-554D-11D1-9FEA-00600832DB4A}"
    TaskNotify(pdo, arg, param2)
      => ComCall(3, this.p, IDataObject, pdo, VARIANT.Ptr, arg, VARIANT.Ptr, param2)
    EnumTasks(pdo, szTaskGroup, ppEnumTASK)
      => ComCall(4, this.p, IDataObject, pdo, "Str", szTaskGroup, IEnumTASK.Ptr, ppEnumTASK)
    GetTitle(pszGroup, pszTitle)
      => ComCall(5, this.p, "Str", pszGroup, PWSTR.Ptr, pszTitle)
    GetDescriptiveText(pszGroup, pszDescriptiveText)
      => ComCall(6, this.p, "Str", pszGroup, PWSTR.Ptr, pszDescriptiveText)
    GetBackground(pszGroup, pTDO)
      => ComCall(7, this.p, "Str", pszGroup, MMC_TASK_DISPLAY_OBJECT.Ptr, pTDO)
    GetListPadInfo(pszGroup, lpListPadInfo)
      => ComCall(8, this.p, "Str", pszGroup, MMC_LISTPAD_INFO.Ptr, lpListPadInfo)
}
struct IConsole2 extends IConsole {
    static IID := "{103D842A-AA63-11D1-A7E1-00C04FD8D565}"
    Expand(hItem, bExpand)
      => ComCall(14, this.p, IntPtr, hItem, BOOL, bExpand)
    IsTaskpadViewPreferred()
      => ComCall(15, this.p)
    SetStatusText(pszStatusText)
      => ComCall(16, this.p, "Str", pszStatusText)
}
struct IDisplayHelp extends IUnknown {
    static IID := "{CC593830-B926-11D1-8063-0000F875A9CE}"
    ShowTopic(pszHelpTopic)
      => ComCall(3, this.p, "Str", pszHelpTopic)
}
struct IRequiredExtensions extends IUnknown {
    static IID := "{72782D7A-A4A0-11D1-AF0F-00C04FB6DD2C}"
    EnableAllExtensions()
      => ComCall(3, this.p)
    GetFirstExtension(pExtCLSID)
      => ComCall(4, this.p, GUID.Ptr, pExtCLSID)
    GetNextExtension(pExtCLSID)
      => ComCall(5, this.p, GUID.Ptr, pExtCLSID)
}
struct IStringTable extends IUnknown {
    static IID := "{DE40B7A4-0F65-11D2-8E25-00C04F8ECD78}"
    AddString(pszAdd, pStringID)
      => ComCall(3, this.p, "Str", pszAdd, UInt32.Ptr, pStringID)
    GetString(StringID, lpBuffer, pcchOut)
      => ComCall(4, this.p, UInt32, StringID, UInt32, lpBuffer.Length, PWSTR, lpBuffer, UInt32.Ptr, pcchOut)
    GetStringLength(StringID, pcchString)
      => ComCall(5, this.p, UInt32, StringID, UInt32.Ptr, pcchString)
    DeleteString(StringID)
      => ComCall(6, this.p, UInt32, StringID)
    DeleteAllStrings()
      => ComCall(7, this.p)
    FindString(pszFind, pStringID)
      => ComCall(8, this.p, "Str", pszFind, UInt32.Ptr, pStringID)
    Enumerate(ppEnum)
      => ComCall(9, this.p, IEnumString.Ptr, ppEnum)
}
struct MMC_COLUMN_DATA {
    nColIndex : Int32
    dwFlags : UInt32
    nWidth : Int32
    ulReserved : IntPtr
}
struct MMC_COLUMN_SET_DATA {
    cbSize : Int32 := this.Size
    nNumCols : Int32
    pColData : MMC_COLUMN_DATA.Ptr
}
struct MMC_SORT_DATA {
    nColIndex : Int32
    dwSortOptions : UInt32
    ulReserved : IntPtr
}
struct MMC_SORT_SET_DATA {
    cbSize : Int32 := this.Size
    nNumItems : Int32
    pSortData : MMC_SORT_DATA.Ptr
}
struct IColumnData extends IUnknown {
    static IID := "{547C1354-024D-11D3-A707-00C04F8EF4CB}"
    SetColumnConfigData(pColID, pColSetData)
      => ComCall(3, this.p, SColumnSetID.Ptr, pColID, MMC_COLUMN_SET_DATA.Ptr, pColSetData)
    GetColumnConfigData(pColID, ppColSetData)
      => ComCall(4, this.p, SColumnSetID.Ptr, pColID, MMC_COLUMN_SET_DATA.Ptr.Ptr, ppColSetData)
    SetColumnSortData(pColID, pColSortData)
      => ComCall(5, this.p, SColumnSetID.Ptr, pColID, MMC_SORT_SET_DATA.Ptr, pColSortData)
    GetColumnSortData(pColID, ppColSortData)
      => ComCall(6, this.p, SColumnSetID.Ptr, pColID, MMC_SORT_SET_DATA.Ptr.Ptr, ppColSortData)
}
struct IconIdentifier extends Int32 {
    static Icon_None := 0
    static Icon_Error := 32513
    static Icon_Question := 32514
    static Icon_Warning := 32515
    static Icon_Information := 32516
    static Icon_First := 32513
    static Icon_Last := 32516
}
struct IMessageView extends IUnknown {
    static IID := "{80F94174-FCCC-11D2-B991-00C04F8ECD78}"
    SetTitleText(pszTitleText)
      => ComCall(3, this.p, "Str", pszTitleText)
    SetBodyText(pszBodyText)
      => ComCall(4, this.p, "Str", pszBodyText)
    SetIcon(id)
      => ComCall(5, this.p, IconIdentifier, id)
    Clear()
      => ComCall(6, this.p)
}
struct RDITEMHDR {
    dwFlags : UInt32
    cookie : IntPtr
    lpReserved : LPARAM
}
struct RDCOMPARE {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    nColumn : Int32
    lUserParam : LPARAM
    prdch1 : RDITEMHDR.Ptr
    prdch2 : RDITEMHDR.Ptr
}
struct IResultDataCompareEx extends IUnknown {
    static IID := "{96933476-0251-11D3-AEB0-00C04F8ECD78}"
    Compare(prdc, pnResult)
      => ComCall(3, this.p, RDCOMPARE.Ptr, prdc, Int32.Ptr, pnResult)
}
struct MMC_VIEW_TYPE extends Int32 {
    static MMC_VIEW_TYPE_LIST := 0
    static MMC_VIEW_TYPE_HTML := 1
    static MMC_VIEW_TYPE_OCX := 2
}
struct RESULT_VIEW_TYPE_INFO {
    pstrPersistableViewDescription : PWSTR
    eViewType : MMC_VIEW_TYPE
    dwMiscOptions : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwListOptions : UInt32
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            dwHTMLOptions : UInt32
            pstrURL : PWSTR
        }
        struct _Anonymous2_e__Struct {
            dwOCXOptions : UInt32
            pUnkControl : IUnknown
        }
    }
}
struct CONTEXTMENUITEM2 {
    strName : PWSTR
    strStatusBarText : PWSTR
    lCommandID : Int32
    lInsertionPointID : Int32
    fFlags : Int32
    fSpecialFlags : Int32
    strLanguageIndependentName : PWSTR
}
struct MMC_EXT_VIEW_DATA {
    viewID : GUID
    pszURL : PWSTR
    pszViewTitle : PWSTR
    pszTooltipText : PWSTR
    bReplacesDefaultView : BOOL
}
struct IComponentData2 extends IComponentData {
    static IID := "{CCA0F2D2-82DE-41B5-BF47-3B2076273D5C}"
    QueryDispatch(cookie, type, ppDispatch)
      => ComCall(10, this.p, IntPtr, cookie, DATA_OBJECT_TYPES, type, IDispatch.Ptr, ppDispatch)
}
struct IComponent2 extends IComponent {
    static IID := "{79A2D615-4A10-4ED4-8C65-8633F9335095}"
    QueryDispatch(cookie, type, ppDispatch)
      => ComCall(10, this.p, IntPtr, cookie, DATA_OBJECT_TYPES, type, IDispatch.Ptr, ppDispatch)
    GetResultViewType2(cookie, pResultViewType)
      => ComCall(11, this.p, IntPtr, cookie, RESULT_VIEW_TYPE_INFO.Ptr, pResultViewType)
    RestoreResultView(cookie, pResultViewType)
      => ComCall(12, this.p, IntPtr, cookie, RESULT_VIEW_TYPE_INFO.Ptr, pResultViewType)
}
struct IContextMenuCallback2 extends IUnknown {
    static IID := "{E178BC0E-2ED0-4B5E-8097-42C9087E8B33}"
    AddItem(pItem)
      => ComCall(3, this.p, CONTEXTMENUITEM2.Ptr, pItem)
}
struct IMMCVersionInfo extends IUnknown {
    static IID := "{A8D2C5FE-CDCB-4B9D-BDE5-A27343FF54BC}"
    GetMMCVersion(pVersionMajor, pVersionMinor)
      => ComCall(3, this.p, Int32.Ptr, pVersionMajor, Int32.Ptr, pVersionMinor)
}
struct IExtendView extends IUnknown {
    static IID := "{89995CEE-D2ED-4C0E-AE5E-DF7E76F3FA53}"
    GetViews(pDataObject, pViewExtensionCallback)
      => ComCall(3, this.p, IDataObject, pDataObject, IViewExtensionCallback, pViewExtensionCallback)
}
struct IViewExtensionCallback extends IUnknown {
    static IID := "{34DD928A-7599-41E5-9F5E-D6BC3062C2DA}"
    AddView(pExtViewData)
      => ComCall(3, this.p, MMC_EXT_VIEW_DATA.Ptr, pExtViewData)
}
struct IConsolePower extends IUnknown {
    static IID := "{1CFBDD0E-62CA-49CE-A3AF-DBB2DE61B068}"
    SetExecutionState(dwAdd, dwRemove)
      => ComCall(3, this.p, UInt32, dwAdd, UInt32, dwRemove)
    ResetIdleTimer(dwFlags)
      => ComCall(4, this.p, UInt32, dwFlags)
}
struct IConsolePowerSink extends IUnknown {
    static IID := "{3333759F-FE4F-4975-B143-FEC0A5DD6D65}"
    OnPowerBroadcast(nEvent, lParam1, plReturn)
      => ComCall(3, this.p, UInt32, nEvent, LPARAM, lParam1, LRESULT.Ptr, plReturn)
}
struct INodeProperties extends IUnknown {
    static IID := "{15BC4D24-A522-4406-AA55-0749537A6865}"
    GetProperty(pDataObject, szPropertyName, pbstrProperty)
      => ComCall(3, this.p, IDataObject, pDataObject, BSTR, szPropertyName, BSTR.Ptr, pbstrProperty)
}
struct IConsole3 extends IConsole2 {
    static IID := "{4F85EFDB-D0E1-498C-8D4A-D010DFDD404F}"
    RenameScopeItem(hScopeItem)
      => ComCall(17, this.p, IntPtr, hScopeItem)
}
struct IResultData2 extends IResultData {
    static IID := "{0F36E0EB-A7F1-4A81-BE5A-9247F7DE4B1B}"
    RenameResultItem(itemID)
      => ComCall(18, this.p, IntPtr, itemID)
}
