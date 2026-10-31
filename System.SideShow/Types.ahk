#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PROPERTYKEY, PWSTR, SYSTEMTIME}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct ISideShowSession extends IUnknown {
    static IID := "{E22331EE-9E7D-4922-9FC2-AB7AA41CE491}"
    RegisterContent(in_applicationId, in_endpointId, out_ppIContent)
      => ComCall(3, this.p, GUID.Ptr, in_applicationId, GUID.Ptr, in_endpointId, ISideShowContentManager.Ptr, out_ppIContent)
    RegisterNotifications(in_applicationId, out_ppINotification)
      => ComCall(4, this.p, GUID.Ptr, in_applicationId, ISideShowNotificationManager.Ptr, out_ppINotification)
}
struct ISideShowNotificationManager extends IUnknown {
    static IID := "{63CEA909-F2B9-4302-B5E1-C68E6D9AB833}"
    Show(in_pINotification?)
      => ComCall(3, this.p, ISideShowNotification, in_pINotification?)
    Revoke(in_notificationId)
      => ComCall(4, this.p, UInt32, in_notificationId)
    RevokeAll()
      => ComCall(5, this.p)
}
struct ISideShowNotification extends IUnknown {
    static IID := "{03C93300-8AB2-41C5-9B79-46127A30E148}"
    get_NotificationId(out_pNotificationId)
      => ComCall(3, this.p, UInt32.Ptr, out_pNotificationId)
    put_NotificationId(in_notificationId)
      => ComCall(4, this.p, UInt32, in_notificationId)
    get_Title(out_ppwszTitle)
      => ComCall(5, this.p, PWSTR.Ptr, out_ppwszTitle)
    put_Title(in_pwszTitle)
      => ComCall(6, this.p, "Str", in_pwszTitle)
    get_Message(out_ppwszMessage)
      => ComCall(7, this.p, PWSTR.Ptr, out_ppwszMessage)
    put_Message(in_pwszMessage)
      => ComCall(8, this.p, "Str", in_pwszMessage)
    get_Image(out_phIcon)
      => ComCall(9, this.p, HICON.Ptr, out_phIcon)
    put_Image(in_hIcon)
      => ComCall(10, this.p, HICON, in_hIcon)
    get_ExpirationTime(out_pTime)
      => ComCall(11, this.p, SYSTEMTIME.Ptr, out_pTime)
    put_ExpirationTime(in_pTime?)
      => ComCall(12, this.p, SYSTEMTIME.Ptr, in_pTime?)
}
struct ISideShowContentManager extends IUnknown {
    static IID := "{A5D5B66B-EEF9-41DB-8D7E-E17C33AB10B0}"
    Add(in_pIContent?)
      => ComCall(3, this.p, ISideShowContent, in_pIContent?)
    Remove(in_contentId)
      => ComCall(4, this.p, UInt32, in_contentId)
    RemoveAll()
      => ComCall(5, this.p)
    SetEventSink(in_pIEvents?)
      => ComCall(6, this.p, ISideShowEvents, in_pIEvents?)
    GetDeviceCapabilities(out_ppCollection)
      => ComCall(7, this.p, ISideShowCapabilitiesCollection.Ptr, out_ppCollection)
}
struct ISideShowContent extends IUnknown {
    static IID := "{C18552ED-74FF-4FEC-BE07-4CFED29D4887}"
    GetContent(in_pICapabilities?, out_pdwSize, out_ppbData)
      => ComCall(3, this.p, ISideShowCapabilities, in_pICapabilities?, UInt32.Ptr, out_pdwSize, UInt8.Ptr.Ptr, out_ppbData)
    get_ContentId(out_pcontentId)
      => ComCall(4, this.p, UInt32.Ptr, out_pcontentId)
    get_DifferentiateContent(out_pfDifferentiateContent)
      => ComCall(5, this.p, BOOL.Ptr, out_pfDifferentiateContent)
}
struct ISideShowEvents extends IUnknown {
    static IID := "{61FECA4C-DEB4-4A7E-8D75-51F1132D615B}"
    ContentMissing(in_contentId, out_ppIContent)
      => ComCall(3, this.p, UInt32, in_contentId, ISideShowContent.Ptr, out_ppIContent)
    ApplicationEvent(in_pICapabilities?, in_dwEventId, in_pbEventData?)
      => ComCall(4, this.p, ISideShowCapabilities, in_pICapabilities?, UInt32, in_dwEventId, UInt32, in_pbEventData?.Length ?? 0, UInt8.Ptr, in_pbEventData?)
    DeviceAdded(in_pIDevice?)
      => ComCall(5, this.p, ISideShowCapabilities, in_pIDevice?)
    DeviceRemoved(in_pIDevice?)
      => ComCall(6, this.p, ISideShowCapabilities, in_pIDevice?)
}
struct ISideShowCapabilities extends IUnknown {
    static IID := "{535E1379-C09E-4A54-A511-597BAB3A72B8}"
    GetCapability(in_keyCapability, inout_pValue)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, in_keyCapability, PROPVARIANT.Ptr, inout_pValue)
}
struct ISideShowCapabilitiesCollection extends IUnknown {
    static IID := "{50305597-5E0D-4FF7-B3AF-33D0D9BD52DD}"
    GetCount(out_pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, out_pdwCount)
    GetAt(in_dwIndex, out_ppCapabilities)
      => ComCall(4, this.p, UInt32, in_dwIndex, ISideShowCapabilities.Ptr, out_ppCapabilities)
}
struct ISideShowBulkCapabilities extends ISideShowCapabilities {
    static IID := "{3A2B7FBC-3AD5-48BD-BBF1-0E6CFBD10807}"
    GetCapabilities(in_keyCollection?, inout_pValues)
      => ComCall(4, this.p, ISideShowKeyCollection, in_keyCollection?, ISideShowPropVariantCollection.Ptr, inout_pValues)
}
struct ISideShowKeyCollection extends IUnknown {
    static IID := "{045473BC-A37B-4957-B144-68105411ED8E}"
    Add(Key)
      => ComCall(3, this.p, PROPERTYKEY.Ptr, Key)
    Clear()
      => ComCall(4, this.p)
    GetAt(dwIndex, pKey)
      => ComCall(5, this.p, UInt32, dwIndex, PROPERTYKEY.Ptr, pKey)
    GetCount(pcElems)
      => ComCall(6, this.p, UInt32.Ptr, pcElems)
    RemoveAt(dwIndex)
      => ComCall(7, this.p, UInt32, dwIndex)
}
struct ISideShowPropVariantCollection extends IUnknown {
    static IID := "{2EA7A549-7BFF-4AAE-BAB0-22D43111DE49}"
    Add(pValue)
      => ComCall(3, this.p, PROPVARIANT.Ptr, pValue)
    Clear()
      => ComCall(4, this.p)
    GetAt(dwIndex, pValue)
      => ComCall(5, this.p, UInt32, dwIndex, PROPVARIANT.Ptr, pValue)
    GetCount(pcElems)
      => ComCall(6, this.p, UInt32.Ptr, pcElems)
    RemoveAt(dwIndex)
      => ComCall(7, this.p, UInt32, dwIndex)
}
struct SIDESHOW_SCREEN_TYPE extends Int32 {
    static SIDESHOW_SCREEN_TYPE_BITMAP := 0
    static SIDESHOW_SCREEN_TYPE_TEXT := 1
}
struct SIDESHOW_COLOR_TYPE extends Int32 {
    static SIDESHOW_COLOR_TYPE_COLOR := 0
    static SIDESHOW_COLOR_TYPE_GREYSCALE := 1
    static SIDESHOW_COLOR_TYPE_BLACK_AND_WHITE := 2
}
struct SCF_EVENT_IDS extends Int32 {
    static SCF_EVENT_NAVIGATION := 1
    static SCF_EVENT_MENUACTION := 2
    static SCF_EVENT_CONTEXTMENU := 3
}
struct SCF_BUTTON_IDS extends Int32 {
    static SCF_BUTTON_MENU := 1
    static SCF_BUTTON_SELECT := 2
    static SCF_BUTTON_UP := 3
    static SCF_BUTTON_DOWN := 4
    static SCF_BUTTON_LEFT := 5
    static SCF_BUTTON_RIGHT := 6
    static SCF_BUTTON_PLAY := 7
    static SCF_BUTTON_PAUSE := 8
    static SCF_BUTTON_FASTFORWARD := 9
    static SCF_BUTTON_REWIND := 10
    static SCF_BUTTON_STOP := 11
    static SCF_BUTTON_BACK := 65280
}
struct SCF_EVENT_HEADER {
    PreviousPage : UInt32
    TargetPage : UInt32
}
struct SCF_NAVIGATION_EVENT {
    PreviousPage : UInt32
    TargetPage : UInt32
    Button : UInt32
}
struct SCF_MENUACTION_EVENT {
    PreviousPage : UInt32
    TargetPage : UInt32
    Button : UInt32
    ItemId : UInt32
}
struct SCF_CONTEXTMENU_EVENT {
    PreviousPage : UInt32
    TargetPage : UInt32
    PreviousItemId : UInt32
    MenuPage : UInt32
    MenuItemId : UInt32
}
struct CONTENT_MISSING_EVENT_DATA {
    cbContentMissingEventData : UInt32
    ApplicationId : GUID
    EndpointId : GUID
    ContentId : UInt32
}
struct APPLICATION_EVENT_DATA {
    cbApplicationEventData : UInt32
    ApplicationId : GUID
    EndpointId : GUID
    dwEventId : UInt32
    cbEventData : UInt32
    bEventData : UInt8[1]
}
struct DEVICE_USER_CHANGE_EVENT_DATA {
    cbDeviceUserChangeEventData : UInt32
    wszUser : UInt16
}
struct NEW_EVENT_DATA_AVAILABLE {
    cbNewEventDataAvailable : UInt32
    dwVersion : UInt32
}
struct EVENT_DATA_HEADER {
    cbEventDataHeader : UInt32
    guidEventType : GUID
    dwVersion : UInt32
    cbEventDataSid : UInt32
}
