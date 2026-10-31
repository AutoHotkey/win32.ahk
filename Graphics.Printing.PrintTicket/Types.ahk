#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct HPTPROVIDER {
    Value : IntPtr
}
struct EDefaultDevmodeType extends Int32 {
    static kUserDefaultDevmode := 0
    static kPrinterDefaultDevmode := 1
}
struct EPrintTicketScope extends Int32 {
    static kPTPageScope := 0
    static kPTDocumentScope := 1
    static kPTJobScope := 2
}
