#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct COMPRESS_ALGORITHM extends UInt32 {
    static COMPRESS_ALGORITHM_MSZIP := 2
    static COMPRESS_ALGORITHM_XPRESS := 3
    static COMPRESS_ALGORITHM_XPRESS_HUFF := 4
    static COMPRESS_ALGORITHM_LZMS := 5
}
struct COMPRESSOR_HANDLE {
    Value : Struct.Ptr
}
struct DECOMPRESSOR_HANDLE {
    Value : Struct.Ptr
}
struct PFN_COMPRESS_ALLOCATE extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Struct.Ptr]
    static Options := "C"
}
struct PFN_COMPRESS_FREE extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
    static Options := "C"
}
struct COMPRESS_ALLOCATION_ROUTINES {
    Allocate : PFN_COMPRESS_ALLOCATE
    Free : PFN_COMPRESS_FREE
    UserContext : Struct.Ptr
}
struct COMPRESS_INFORMATION_CLASS extends Int32 {
    static COMPRESS_INFORMATION_CLASS_INVALID := 0
    static COMPRESS_INFORMATION_CLASS_BLOCK_SIZE := 1
    static COMPRESS_INFORMATION_CLASS_LEVEL := 2
}
