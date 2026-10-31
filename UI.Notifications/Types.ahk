#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct NOTIFICATION_USER_INPUT_DATA {
    Key : PWSTR
    Value : PWSTR
}
struct INotificationActivationCallback extends IUnknown {
    static IID := "{53E31837-6600-4A81-9395-75CFFE746F94}"
    Activate(appUserModelId, invokedArgs, data)
      => ComCall(3, this.p, "Str", appUserModelId, "Str", invokedArgs, NOTIFICATION_USER_INPUT_DATA.Ptr, data, UInt32, data.Length)
}
