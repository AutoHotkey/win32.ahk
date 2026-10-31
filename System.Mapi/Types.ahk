#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PSTR, PWSTR}

struct MapiFileDesc {
    ulReserved : UInt32
    flFlags : UInt32
    nPosition : UInt32
    lpszPathName : PSTR
    lpszFileName : PSTR
    lpFileType : Struct.Ptr
}
struct MapiFileDescW {
    ulReserved : UInt32
    flFlags : UInt32
    nPosition : UInt32
    lpszPathName : PWSTR
    lpszFileName : PWSTR
    lpFileType : Struct.Ptr
}
struct MapiFileTagExt {
    ulReserved : UInt32
    cbTag : UInt32
    lpTag : UInt8.Ptr
    cbEncoding : UInt32
    lpEncoding : UInt8.Ptr
}
struct MapiRecipDesc {
    ulReserved : UInt32
    ulRecipClass : UInt32
    lpszName : PSTR
    lpszAddress : PSTR
    ulEIDSize : UInt32
    lpEntryID : Struct.Ptr
}
struct MapiRecipDescW {
    ulReserved : UInt32
    ulRecipClass : UInt32
    lpszName : PWSTR
    lpszAddress : PWSTR
    ulEIDSize : UInt32
    lpEntryID : Struct.Ptr
}
struct MapiMessage {
    ulReserved : UInt32
    lpszSubject : PSTR
    lpszNoteText : PSTR
    lpszMessageType : PSTR
    lpszDateReceived : PSTR
    lpszConversationID : PSTR
    flFlags : UInt32
    lpOriginator : MapiRecipDesc.Ptr
    nRecipCount : UInt32
    lpRecips : MapiRecipDesc.Ptr
    nFileCount : UInt32
    lpFiles : MapiFileDesc.Ptr
}
struct MapiMessageW {
    ulReserved : UInt32
    lpszSubject : PWSTR
    lpszNoteText : PWSTR
    lpszMessageType : PWSTR
    lpszDateReceived : PWSTR
    lpszConversationID : PWSTR
    flFlags : UInt32
    lpOriginator : MapiRecipDescW.Ptr
    nRecipCount : UInt32
    lpRecips : MapiRecipDescW.Ptr
    nFileCount : UInt32
    lpFiles : MapiFileDescW.Ptr
}
struct LPMAPILOGON extends FunctionPointer {
    static Types := [IntPtr, PSTR, PSTR, UInt32, UInt32, IntPtr.Ptr, UInt32]
}
struct LPMAPILOGOFF extends FunctionPointer {
    static Types := [IntPtr, IntPtr, UInt32, UInt32, UInt32]
}
struct LPMAPISENDMAIL extends FunctionPointer {
    static Types := [IntPtr, IntPtr, MapiMessage.Ptr, UInt32, UInt32, UInt32]
}
struct LPMAPISENDMAILW extends FunctionPointer {
    static Types := [IntPtr, IntPtr, MapiMessageW.Ptr, UInt32, UInt32, UInt32]
}
struct LPMAPISENDDOCUMENTS extends FunctionPointer {
    static Types := [IntPtr, PSTR, PSTR, PSTR, UInt32, UInt32]
}
struct LPMAPIFINDNEXT extends FunctionPointer {
    static Types := [IntPtr, IntPtr, PSTR, PSTR, UInt32, UInt32, PSTR, UInt32]
}
struct LPMAPIREADMAIL extends FunctionPointer {
    static Types := [IntPtr, IntPtr, PSTR, UInt32, UInt32, MapiMessage.Ptr.Ptr, UInt32]
}
struct LPMAPISAVEMAIL extends FunctionPointer {
    static Types := [IntPtr, IntPtr, MapiMessage.Ptr, UInt32, UInt32, PSTR, UInt32]
}
struct LPMAPIDELETEMAIL extends FunctionPointer {
    static Types := [IntPtr, IntPtr, PSTR, UInt32, UInt32, UInt32]
}
struct LPMAPIFREEBUFFER extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct LPMAPIADDRESS extends FunctionPointer {
    static Types := [IntPtr, IntPtr, PSTR, UInt32, PSTR, UInt32, MapiRecipDesc.Ptr, UInt32, UInt32, UInt32.Ptr, MapiRecipDesc.Ptr.Ptr, UInt32]
}
struct LPMAPIDETAILS extends FunctionPointer {
    static Types := [IntPtr, IntPtr, MapiRecipDesc.Ptr, UInt32, UInt32, UInt32]
}
struct LPMAPIRESOLVENAME extends FunctionPointer {
    static Types := [IntPtr, IntPtr, PSTR, UInt32, UInt32, MapiRecipDesc.Ptr.Ptr, UInt32]
}
