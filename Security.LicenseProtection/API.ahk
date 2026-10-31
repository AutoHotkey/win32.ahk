#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {FILETIME, HRESULT, PWSTR}

RegisterLicenseKeyWithExpiration(licenseKey, validityInDays, status)
  => DllCall("licenseprotection.dll\RegisterLicenseKeyWithExpiration", "Str", licenseKey, UInt32, validityInDays, LicenseProtectionStatus.Ptr, status, "HRESULT")
ValidateLicenseKeyProtection(licenseKey, notValidBefore, notValidAfter, status)
  => DllCall("licenseprotection.dll\ValidateLicenseKeyProtection", "Str", licenseKey, FILETIME.Ptr, notValidBefore, FILETIME.Ptr, notValidAfter, LicenseProtectionStatus.Ptr, status, "HRESULT")
