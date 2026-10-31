#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct LicenseProtectionStatus extends Int32 {
    static Success := 0
    static LicenseKeyNotFound := 1
    static LicenseKeyUnprotected := 2
    static LicenseKeyCorrupted := 3
    static LicenseKeyAlreadyExists := 4
}
