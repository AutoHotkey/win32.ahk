#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {FILETIME, HRESULT, HWND}

AcquireDeveloperLicense(hwndParent?, pExpiration)
  => DllCall("WSClient.dll\AcquireDeveloperLicense", HWND, hwndParent?, FILETIME.Ptr, pExpiration, "HRESULT")
CheckDeveloperLicense(pExpiration)
  => DllCall("WSClient.dll\CheckDeveloperLicense", FILETIME.Ptr, pExpiration, "HRESULT")
RemoveDeveloperLicense(hwndParent?)
  => DllCall("WSClient.dll\RemoveDeveloperLicense", HWND, hwndParent?, "HRESULT")
