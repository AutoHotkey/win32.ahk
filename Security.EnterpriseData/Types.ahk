#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, HWND}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT\Types.ahk" {HSTRING, IInspectable}

struct SRP_REQUEST {
    Value : IntPtr
}
struct IProtectionPolicyManagerInterop extends IInspectable {
    static IID := "{4652651D-C1FE-4BA1-9F0A-C0F56596F721}"
    RequestAccessForWindowAsync(appWindow, sourceIdentity, targetIdentity, riid, asyncOperation)
      => ComCall(6, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, targetIdentity, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    GetForWindow(appWindow, riid, result)
      => ComCall(7, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, result)
}
struct IProtectionPolicyManagerInterop2 extends IInspectable {
    static IID := "{157CFBE4-A78D-4156-B384-61FDAC41E686}"
    RequestAccessForAppWithWindowAsync(appWindow, sourceIdentity, appPackageFamilyName, riid, asyncOperation)
      => ComCall(6, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, appPackageFamilyName, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessWithAuditingInfoForWindowAsync(appWindow, sourceIdentity, targetIdentity, auditInfoUnk, riid, asyncOperation)
      => ComCall(7, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, targetIdentity, IUnknown, auditInfoUnk, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessWithMessageForWindowAsync(appWindow, sourceIdentity, targetIdentity, auditInfoUnk, messageFromApp, riid, asyncOperation)
      => ComCall(8, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, targetIdentity, IUnknown, auditInfoUnk, HSTRING, messageFromApp, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessForAppWithAuditingInfoForWindowAsync(appWindow, sourceIdentity, appPackageFamilyName, auditInfoUnk, riid, asyncOperation)
      => ComCall(9, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, appPackageFamilyName, IUnknown, auditInfoUnk, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessForAppWithMessageForWindowAsync(appWindow, sourceIdentity, appPackageFamilyName, auditInfoUnk, messageFromApp, riid, asyncOperation)
      => ComCall(10, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, appPackageFamilyName, IUnknown, auditInfoUnk, HSTRING, messageFromApp, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
}
struct IProtectionPolicyManagerInterop3 extends IInspectable {
    static IID := "{C1C03933-B398-4D93-B0FD-2972ADF802C2}"
    RequestAccessWithBehaviorForWindowAsync(appWindow, sourceIdentity, targetIdentity, auditInfoUnk, messageFromApp, behavior, riid, asyncOperation)
      => ComCall(6, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, targetIdentity, IUnknown, auditInfoUnk, HSTRING, messageFromApp, UInt32, behavior, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessForAppWithBehaviorForWindowAsync(appWindow, sourceIdentity, appPackageFamilyName, auditInfoUnk, messageFromApp, behavior, riid, asyncOperation)
      => ComCall(7, this.p, HWND, appWindow, HSTRING, sourceIdentity, HSTRING, appPackageFamilyName, IUnknown, auditInfoUnk, HSTRING, messageFromApp, UInt32, behavior, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessToFilesForAppForWindowAsync(appWindow, sourceItemListUnk, appPackageFamilyName, auditInfoUnk, riid, asyncOperation)
      => ComCall(8, this.p, HWND, appWindow, IUnknown, sourceItemListUnk, HSTRING, appPackageFamilyName, IUnknown, auditInfoUnk, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessToFilesForAppWithMessageAndBehaviorForWindowAsync(appWindow, sourceItemListUnk, appPackageFamilyName, auditInfoUnk, messageFromApp, behavior, riid, asyncOperation)
      => ComCall(9, this.p, HWND, appWindow, IUnknown, sourceItemListUnk, HSTRING, appPackageFamilyName, IUnknown, auditInfoUnk, HSTRING, messageFromApp, UInt32, behavior, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessToFilesForProcessForWindowAsync(appWindow, sourceItemListUnk, processId, auditInfoUnk, riid, asyncOperation)
      => ComCall(10, this.p, HWND, appWindow, IUnknown, sourceItemListUnk, UInt32, processId, IUnknown, auditInfoUnk, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
    RequestAccessToFilesForProcessWithMessageAndBehaviorForWindowAsync(appWindow, sourceItemListUnk, processId, auditInfoUnk, messageFromApp, behavior, riid, asyncOperation)
      => ComCall(11, this.p, HWND, appWindow, IUnknown, sourceItemListUnk, UInt32, processId, IUnknown, auditInfoUnk, HSTRING, messageFromApp, UInt32, behavior, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
}
struct HTHREAD_NETWORK_CONTEXT {
    ThreadId : UInt32
    ThreadContext : HANDLE
}
struct ENTERPRISE_DATA_POLICIES extends Int32 {
    static ENTERPRISE_POLICY_NONE := 0
    static ENTERPRISE_POLICY_ALLOWED := 1
    static ENTERPRISE_POLICY_ENLIGHTENED := 2
    static ENTERPRISE_POLICY_EXEMPT := 4
}
struct SRPHOSTING_TYPE extends Int32 {
    static SRPHOSTING_TYPE_NONE := 0
    static SRPHOSTING_TYPE_WINHTTP := 1
    static SRPHOSTING_TYPE_WININET := 2
}
struct SRPHOSTING_VERSION extends Int32 {
    static SRPHOSTING_VERSION1 := 1
}
struct FILE_UNPROTECT_OPTIONS {
    audit : UInt8
}
