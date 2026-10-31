#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND, LPARAM, PWSTR}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR}
#Import "..\Security.Authorization.UI\Types.ahk" {ISecurityInformation}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

struct PFNREADOBJECTSECURITY extends FunctionPointer {
    static Types := [PWSTR, UInt32, PSECURITY_DESCRIPTOR.Ptr, LPARAM, HRESULT]
}
struct PFNWRITEOBJECTSECURITY extends FunctionPointer {
    static Types := [PWSTR, UInt32, PSECURITY_DESCRIPTOR, LPARAM, HRESULT]
}
struct PFNDSCREATEISECINFO extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, ISecurityInformation.Ptr, PFNREADOBJECTSECURITY, PFNWRITEOBJECTSECURITY, LPARAM, HRESULT]
}
struct PFNDSCREATEISECINFOEX extends FunctionPointer {
    static Types := [PWSTR, PWSTR, PWSTR, PWSTR, PWSTR, UInt32, ISecurityInformation.Ptr, PFNREADOBJECTSECURITY, PFNWRITEOBJECTSECURITY, LPARAM, HRESULT]
}
struct PFNDSCREATESECPAGE extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, HPROPSHEETPAGE.Ptr, PFNREADOBJECTSECURITY, PFNWRITEOBJECTSECURITY, LPARAM, HRESULT]
}
struct PFNDSEDITSECURITY extends FunctionPointer {
    static Types := [HWND, PWSTR, PWSTR, UInt32, PWSTR, PFNREADOBJECTSECURITY, PFNWRITEOBJECTSECURITY, LPARAM, HRESULT]
}
