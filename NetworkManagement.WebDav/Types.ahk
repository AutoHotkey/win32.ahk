#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

struct DAV_CALLBACK_AUTH_BLOB {
    pBuffer : Struct.Ptr
    ulSize : UInt32
    ulType : UInt32
}
struct DAV_CALLBACK_AUTH_UNP {
    pszUserName : PWSTR
    ulUserNameLength : UInt32
    pszPassword : PWSTR
    ulPasswordLength : UInt32
}
struct DAV_CALLBACK_CRED {
    AuthBlob : DAV_CALLBACK_AUTH_BLOB
    UNPBlob : DAV_CALLBACK_AUTH_UNP
    bAuthBlobValid : BOOL
    bSave : BOOL
}
struct AUTHNEXTSTEP extends Int32 {
    static DefaultBehavior := 0
    static RetryRequest := 1
    static CancelRequest := 2
}
struct PFNDAVAUTHCALLBACK_FREECRED extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PFNDAVAUTHCALLBACK extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, UInt32, DAV_CALLBACK_CRED.Ptr, AUTHNEXTSTEP.Ptr, PFNDAVAUTHCALLBACK_FREECRED.Ptr, UInt32]
}
