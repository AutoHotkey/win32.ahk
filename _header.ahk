#import "Core.ahk" {
    Boolean8,
    FunctionPointer,
    GUID,
    InterfacePointer,
    ; IUnknown,
    UnsupportedType
}

{   ; Don't "eager initialize" classes in these modules when the module initializes,
    ; because they might need to let classes in other modules initialize first, and
    ; they can't do that if those classes are already executing __Init.
    return
}