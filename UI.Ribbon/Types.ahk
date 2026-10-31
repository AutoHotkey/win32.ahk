#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HINSTANCE, HRESULT, HWND, PROPERTYKEY, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}

struct UI_CONTEXTAVAILABILITY extends Int32 {
    static UI_CONTEXTAVAILABILITY_NOTAVAILABLE := 0
    static UI_CONTEXTAVAILABILITY_AVAILABLE := 1
    static UI_CONTEXTAVAILABILITY_ACTIVE := 2
}
struct UI_FONTPROPERTIES extends Int32 {
    static UI_FONTPROPERTIES_NOTAVAILABLE := 0
    static UI_FONTPROPERTIES_NOTSET := 1
    static UI_FONTPROPERTIES_SET := 2
}
struct UI_FONTVERTICALPOSITION extends Int32 {
    static UI_FONTVERTICALPOSITION_NOTAVAILABLE := 0
    static UI_FONTVERTICALPOSITION_NOTSET := 1
    static UI_FONTVERTICALPOSITION_SUPERSCRIPT := 2
    static UI_FONTVERTICALPOSITION_SUBSCRIPT := 3
}
struct UI_FONTUNDERLINE extends Int32 {
    static UI_FONTUNDERLINE_NOTAVAILABLE := 0
    static UI_FONTUNDERLINE_NOTSET := 1
    static UI_FONTUNDERLINE_SET := 2
}
struct UI_FONTDELTASIZE extends Int32 {
    static UI_FONTDELTASIZE_GROW := 0
    static UI_FONTDELTASIZE_SHRINK := 1
}
struct UI_CONTROLDOCK extends Int32 {
    static UI_CONTROLDOCK_TOP := 1
    static UI_CONTROLDOCK_BOTTOM := 3
}
struct UI_SWATCHCOLORTYPE extends Int32 {
    static UI_SWATCHCOLORTYPE_NOCOLOR := 0
    static UI_SWATCHCOLORTYPE_AUTOMATIC := 1
    static UI_SWATCHCOLORTYPE_RGB := 2
}
struct UI_SWATCHCOLORMODE extends Int32 {
    static UI_SWATCHCOLORMODE_NORMAL := 0
    static UI_SWATCHCOLORMODE_MONOCHROME := 1
}
struct UI_EVENTTYPE extends Int32 {
    static UI_EVENTTYPE_ApplicationMenuOpened := 0
    static UI_EVENTTYPE_RibbonMinimized := 1
    static UI_EVENTTYPE_RibbonExpanded := 2
    static UI_EVENTTYPE_ApplicationModeSwitched := 3
    static UI_EVENTTYPE_TabActivated := 4
    static UI_EVENTTYPE_MenuOpened := 5
    static UI_EVENTTYPE_CommandExecuted := 6
    static UI_EVENTTYPE_TooltipShown := 7
}
struct UI_EVENTLOCATION extends Int32 {
    static UI_EVENTLOCATION_Ribbon := 0
    static UI_EVENTLOCATION_QAT := 1
    static UI_EVENTLOCATION_ApplicationMenu := 2
    static UI_EVENTLOCATION_ContextPopup := 3
}
struct IUISimplePropertySet extends IUnknown {
    static IID := "{C205BB48-5B1C-4219-A106-15BD0A5F24E2}"
    GetValue(key, value)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, value)
}
struct IUIRibbon extends IUnknown {
    static IID := "{803982AB-370A-4F7E-A9E7-8784036A6E26}"
    GetHeight(cy)
      => ComCall(3, this.p, UInt32.Ptr, cy)
    LoadSettingsFromStream(pStream)
      => ComCall(4, this.p, IStream, pStream)
    SaveSettingsToStream(pStream)
      => ComCall(5, this.p, IStream, pStream)
}
struct UI_INVALIDATIONS extends Int32 {
    static UI_INVALIDATIONS_STATE := 1
    static UI_INVALIDATIONS_VALUE := 2
    static UI_INVALIDATIONS_PROPERTY := 4
    static UI_INVALIDATIONS_ALLPROPERTIES := 8
}
struct IUIFramework extends IUnknown {
    static IID := "{F4F0385D-6872-43A8-AD09-4C339CB3F5C5}"
    Initialize(frameWnd, application)
      => ComCall(3, this.p, HWND, frameWnd, IUIApplication, application)
    Destroy()
      => ComCall(4, this.p)
    LoadUI(instance, resourceName)
      => ComCall(5, this.p, HINSTANCE, instance, "Str", resourceName)
    GetView(viewId, riid, ppv)
      => ComCall(6, this.p, UInt32, viewId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetUICommandProperty(commandId, key, value)
      => ComCall(7, this.p, UInt32, commandId, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, value)
    SetUICommandProperty(commandId, key, value)
      => ComCall(8, this.p, UInt32, commandId, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, value)
    InvalidateUICommand(commandId, flags, key?)
      => ComCall(9, this.p, UInt32, commandId, UI_INVALIDATIONS, flags, PROPERTYKEY.Ptr, key?)
    FlushPendingInvalidations()
      => ComCall(10, this.p)
    SetModes(iModes)
      => ComCall(11, this.p, Int32, iModes)
}
struct UI_EVENTPARAMS_COMMAND {
    CommandID : UInt32
    CommandName : PWSTR
    ParentCommandID : UInt32
    ParentCommandName : PWSTR
    SelectionIndex : UInt32
    Location : UI_EVENTLOCATION
}
struct UI_EVENTPARAMS {
    EventType : UI_EVENTTYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Modes : Int32
            Params : UI_EVENTPARAMS_COMMAND
        }
    }
}
struct IUIEventLogger extends IUnknown {
    static IID := "{EC3E1034-DBF4-41A1-95D5-03E0F1026E05}"
    OnUIEvent(pEventParams)
      => ComCall(3, this.p, UI_EVENTPARAMS.Ptr, pEventParams, "void")
}
struct IUIEventingManager extends IUnknown {
    static IID := "{3BE6EA7F-9A9B-4198-9368-9B0F923BD534}"
    SetEventLogger(eventLogger)
      => ComCall(3, this.p, IUIEventLogger, eventLogger)
}
struct IUIContextualUI extends IUnknown {
    static IID := "{EEA11F37-7C46-437C-8E55-B52122B29293}"
    ShowAtLocation(x, y)
      => ComCall(3, this.p, Int32, x, Int32, y)
}
struct IUICollection extends IUnknown {
    static IID := "{DF4F45BF-6F9D-4DD7-9D68-D8F9CD18C4DB}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetItem(index, item)
      => ComCall(4, this.p, UInt32, index, IUnknown.Ptr, item)
    Add(item)
      => ComCall(5, this.p, IUnknown, item)
    Insert(index, item)
      => ComCall(6, this.p, UInt32, index, IUnknown, item)
    RemoveAt(index)
      => ComCall(7, this.p, UInt32, index)
    Replace(indexReplaced, itemReplaceWith)
      => ComCall(8, this.p, UInt32, indexReplaced, IUnknown, itemReplaceWith)
    Clear()
      => ComCall(9, this.p)
}
struct UI_COLLECTIONCHANGE extends Int32 {
    static UI_COLLECTIONCHANGE_INSERT := 0
    static UI_COLLECTIONCHANGE_REMOVE := 1
    static UI_COLLECTIONCHANGE_REPLACE := 2
    static UI_COLLECTIONCHANGE_RESET := 3
}
struct IUICollectionChangedEvent extends IUnknown {
    static IID := "{6502AE91-A14D-44B5-BBD0-62AACC581D52}"
    OnChanged(action, oldIndex, oldItem?, newIndex, newItem?)
      => ComCall(3, this.p, UI_COLLECTIONCHANGE, action, UInt32, oldIndex, IUnknown, oldItem?, UInt32, newIndex, IUnknown, newItem?)
}
struct UI_EXECUTIONVERB extends Int32 {
    static UI_EXECUTIONVERB_EXECUTE := 0
    static UI_EXECUTIONVERB_PREVIEW := 1
    static UI_EXECUTIONVERB_CANCELPREVIEW := 2
}
struct IUICommandHandler extends IUnknown {
    static IID := "{75AE0A2D-DC03-4C9F-8883-069660D0BEB6}"
    Execute(commandId, verb, key?, currentValue?, commandExecutionProperties?)
      => ComCall(3, this.p, UInt32, commandId, UI_EXECUTIONVERB, verb, PROPERTYKEY.Ptr, key?, PROPVARIANT.Ptr, currentValue?, IUISimplePropertySet, commandExecutionProperties?)
    UpdateProperty(commandId, key, currentValue?, newValue)
      => ComCall(4, this.p, UInt32, commandId, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, currentValue?, PROPVARIANT.Ptr, newValue)
}
struct UI_COMMANDTYPE extends Int32 {
    static UI_COMMANDTYPE_UNKNOWN := 0
    static UI_COMMANDTYPE_GROUP := 1
    static UI_COMMANDTYPE_ACTION := 2
    static UI_COMMANDTYPE_ANCHOR := 3
    static UI_COMMANDTYPE_CONTEXT := 4
    static UI_COMMANDTYPE_COLLECTION := 5
    static UI_COMMANDTYPE_COMMANDCOLLECTION := 6
    static UI_COMMANDTYPE_DECIMAL := 7
    static UI_COMMANDTYPE_BOOLEAN := 8
    static UI_COMMANDTYPE_FONT := 9
    static UI_COMMANDTYPE_RECENTITEMS := 10
    static UI_COMMANDTYPE_COLORANCHOR := 11
    static UI_COMMANDTYPE_COLORCOLLECTION := 12
}
struct UI_VIEWTYPE extends Int32 {
    static UI_VIEWTYPE_RIBBON := 1
}
struct UI_VIEWVERB extends Int32 {
    static UI_VIEWVERB_CREATE := 0
    static UI_VIEWVERB_DESTROY := 1
    static UI_VIEWVERB_SIZE := 2
    static UI_VIEWVERB_ERROR := 3
}
struct IUIApplication extends IUnknown {
    static IID := "{D428903C-729A-491D-910D-682A08FF2522}"
    OnViewChanged(viewId, typeID, view, verb, uReasonCode)
      => ComCall(3, this.p, UInt32, viewId, UI_VIEWTYPE, typeID, IUnknown, view, UI_VIEWVERB, verb, Int32, uReasonCode)
    OnCreateUICommand(commandId, typeID, commandHandler)
      => ComCall(4, this.p, UInt32, commandId, UI_COMMANDTYPE, typeID, IUICommandHandler.Ptr, commandHandler)
    OnDestroyUICommand(commandId, typeID, commandHandler?)
      => ComCall(5, this.p, UInt32, commandId, UI_COMMANDTYPE, typeID, IUICommandHandler, commandHandler?)
}
struct IUIImage extends IUnknown {
    static IID := "{23C8C838-4DE6-436B-AB01-5554BB7C30DD}"
    GetBitmap(bitmap)
      => ComCall(3, this.p, HBITMAP.Ptr, bitmap)
}
struct UI_OWNERSHIP extends Int32 {
    static UI_OWNERSHIP_TRANSFER := 0
    static UI_OWNERSHIP_COPY := 1
}
struct IUIImageFromBitmap extends IUnknown {
    static IID := "{18ABA7F3-4C1C-4BA2-BF6C-F5C3326FA816}"
    CreateImage(bitmap, options, image)
      => ComCall(3, this.p, HBITMAP, bitmap, UI_OWNERSHIP, options, IUIImage.Ptr, image)
}
