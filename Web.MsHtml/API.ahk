#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PWSTR}

DoPrivacyDlg(hwndOwner?, pszUrl, pPrivacyEnum, fReportAllSites)
  => DllCall("SHDOCVW.dll\DoPrivacyDlg", HWND, hwndOwner?, "Str", pszUrl, IEnumPrivacyRecords, pPrivacyEnum, BOOL, fReportAllSites, "HRESULT")
