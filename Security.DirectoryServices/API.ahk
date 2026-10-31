#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, HWND, LPARAM, PWSTR}
#Import "..\Security.Authorization.UI\Types.ahk" {ISecurityInformation}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

DSCreateISecurityInfoObject(pwszObjectPath, pwszObjectClass, dwFlags, ppSI, pfnReadSD?, pfnWriteSD?, lpContext)
  => DllCall("DSSEC.dll\DSCreateISecurityInfoObject", "Str", pwszObjectPath, "Str", pwszObjectClass, UInt32, dwFlags, ISecurityInformation.Ptr, ppSI, PFNREADOBJECTSECURITY, pfnReadSD?, PFNWRITEOBJECTSECURITY, pfnWriteSD?, LPARAM, lpContext, "HRESULT")
DSCreateISecurityInfoObjectEx(pwszObjectPath, pwszObjectClass, pwszServer, pwszUserName, pwszPassword, dwFlags, ppSI, pfnReadSD?, pfnWriteSD?, lpContext)
  => DllCall("DSSEC.dll\DSCreateISecurityInfoObjectEx", "Str", pwszObjectPath, "Str", pwszObjectClass, "Str", pwszServer, "Str", pwszUserName, "Str", pwszPassword, UInt32, dwFlags, ISecurityInformation.Ptr, ppSI, PFNREADOBJECTSECURITY, pfnReadSD?, PFNWRITEOBJECTSECURITY, pfnWriteSD?, LPARAM, lpContext, "HRESULT")
DSCreateSecurityPage(pwszObjectPath, pwszObjectClass, dwFlags, phPage, pfnReadSD?, pfnWriteSD?, lpContext)
  => DllCall("DSSEC.dll\DSCreateSecurityPage", "Str", pwszObjectPath, "Str", pwszObjectClass, UInt32, dwFlags, HPROPSHEETPAGE.Ptr, phPage, PFNREADOBJECTSECURITY, pfnReadSD?, PFNWRITEOBJECTSECURITY, pfnWriteSD?, LPARAM, lpContext, "HRESULT")
DSEditSecurity(hwndOwner, pwszObjectPath, pwszObjectClass, dwFlags, pwszCaption, pfnReadSD?, pfnWriteSD?, lpContext)
  => DllCall("DSSEC.dll\DSEditSecurity", HWND, hwndOwner, "Str", pwszObjectPath, "Str", pwszObjectClass, UInt32, dwFlags, "Str", pwszCaption, PFNREADOBJECTSECURITY, pfnReadSD?, PFNWRITEOBJECTSECURITY, pfnWriteSD?, LPARAM, lpContext, "HRESULT")
