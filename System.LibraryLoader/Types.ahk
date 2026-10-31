#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HMODULE, PSTR, PWSTR}

struct LOAD_LIBRARY_FLAGS extends UInt32 {
    static DONT_RESOLVE_DLL_REFERENCES := 1
    static LOAD_LIBRARY_AS_DATAFILE := 2
    static LOAD_WITH_ALTERED_SEARCH_PATH := 8
    static LOAD_IGNORE_CODE_AUTHZ_LEVEL := 16
    static LOAD_LIBRARY_AS_IMAGE_RESOURCE := 32
    static LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE := 64
    static LOAD_LIBRARY_REQUIRE_SIGNED_TARGET := 128
    static LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR := 256
    static LOAD_LIBRARY_SEARCH_APPLICATION_DIR := 512
    static LOAD_LIBRARY_SEARCH_USER_DIRS := 1024
    static LOAD_LIBRARY_SEARCH_SYSTEM32 := 2048
    static LOAD_LIBRARY_SEARCH_DEFAULT_DIRS := 4096
    static LOAD_LIBRARY_SAFE_CURRENT_DIRS := 8192
    static LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER := 16384
}
struct ENUMUILANG {
    NumOfEnumUILang : UInt32
    SizeOfEnumUIBuffer : UInt32
    pEnumUIBuffer : UInt16.Ptr
}
struct ENUMRESLANGPROCA extends FunctionPointer {
    static Types := [HMODULE, PSTR, PSTR, UInt16, IntPtr, BOOL]
}
struct ENUMRESLANGPROCW extends FunctionPointer {
    static Types := [HMODULE, PWSTR, PWSTR, UInt16, IntPtr, BOOL]
}
struct ENUMRESNAMEPROCA extends FunctionPointer {
    static Types := [HMODULE, PSTR, PSTR, IntPtr, BOOL]
}
struct ENUMRESNAMEPROCW extends FunctionPointer {
    static Types := [HMODULE, PWSTR, PWSTR, IntPtr, BOOL]
}
struct ENUMRESTYPEPROCA extends FunctionPointer {
    static Types := [HMODULE, PSTR, IntPtr, BOOL]
}
struct ENUMRESTYPEPROCW extends FunctionPointer {
    static Types := [HMODULE, PWSTR, IntPtr, BOOL]
}
struct PGET_MODULE_HANDLE_EXA extends FunctionPointer {
    static Types := [UInt32, PSTR, HMODULE.Ptr, BOOL]
}
struct PGET_MODULE_HANDLE_EXW extends FunctionPointer {
    static Types := [UInt32, PWSTR, HMODULE.Ptr, BOOL]
}
struct REDIRECTION_FUNCTION_DESCRIPTOR {
    DllName : PSTR
    FunctionName : PSTR
    RedirectionTarget : Struct.Ptr
}
struct REDIRECTION_DESCRIPTOR {
    Version : UInt32
    FunctionCount : UInt32
    Redirections : REDIRECTION_FUNCTION_DESCRIPTOR.Ptr
}
