#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

CreateSecurityPage(psi)
  => DllCall("ACLUI.dll\CreateSecurityPage", ISecurityInformation, psi, HPROPSHEETPAGE)
EditSecurity(hwndOwner, psi)
  => DllCall("ACLUI.dll\EditSecurity", HWND, hwndOwner, ISecurityInformation, psi, BOOL)
EditSecurityAdvanced(hwndOwner, psi, uSIPage)
  => DllCall("ACLUI.dll\EditSecurityAdvanced", HWND, hwndOwner, ISecurityInformation, psi, SI_PAGE_TYPE, uSIPage, "HRESULT")
