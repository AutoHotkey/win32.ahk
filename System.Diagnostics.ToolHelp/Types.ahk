#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {CHAR, HANDLE, HMODULE}

struct CREATE_TOOLHELP_SNAPSHOT_FLAGS extends UInt32 {
    static TH32CS_INHERIT := 2147483648
    static TH32CS_SNAPALL := 15
    static TH32CS_SNAPHEAPLIST := 1
    static TH32CS_SNAPMODULE := 8
    static TH32CS_SNAPMODULE32 := 16
    static TH32CS_SNAPPROCESS := 2
    static TH32CS_SNAPTHREAD := 4
}
struct HEAPENTRY32_FLAGS extends UInt32 {
    static LF32_FIXED := 1
    static LF32_FREE := 2
    static LF32_MOVEABLE := 4
}
struct HEAPLIST32 {
    dwSize : IntPtr
    th32ProcessID : UInt32
    th32HeapID : IntPtr
    dwFlags : UInt32
}
struct HEAPENTRY32 {
    dwSize : IntPtr
    hHandle : HANDLE
    dwAddress : IntPtr
    dwBlockSize : IntPtr
    dwFlags : HEAPENTRY32_FLAGS
    dwLockCount : UInt32
    dwResvd : UInt32
    th32ProcessID : UInt32
    th32HeapID : IntPtr
}
struct PROCESSENTRY32W {
    dwSize : UInt32
    cntUsage : UInt32
    th32ProcessID : UInt32
    th32DefaultHeapID : IntPtr
    th32ModuleID : UInt32
    cntThreads : UInt32
    th32ParentProcessID : UInt32
    pcPriClassBase : Int32
    dwFlags : UInt32
    szExeFile : UInt16[260]
}
struct PROCESSENTRY32 {
    dwSize : UInt32
    cntUsage : UInt32
    th32ProcessID : UInt32
    th32DefaultHeapID : IntPtr
    th32ModuleID : UInt32
    cntThreads : UInt32
    th32ParentProcessID : UInt32
    pcPriClassBase : Int32
    dwFlags : UInt32
    szExeFile : CHAR[260]
}
struct THREADENTRY32 {
    dwSize : UInt32
    cntUsage : UInt32
    th32ThreadID : UInt32
    th32OwnerProcessID : UInt32
    tpBasePri : Int32
    tpDeltaPri : Int32
    dwFlags : UInt32
}
struct MODULEENTRY32W {
    dwSize : UInt32
    th32ModuleID : UInt32
    th32ProcessID : UInt32
    GlblcntUsage : UInt32
    ProccntUsage : UInt32
    modBaseAddr : UInt8.Ptr
    modBaseSize : UInt32
    hModule : HMODULE
    szModule : UInt16[256]
    szExePath : UInt16[260]
}
struct MODULEENTRY32 {
    dwSize : UInt32
    th32ModuleID : UInt32
    th32ProcessID : UInt32
    GlblcntUsage : UInt32
    ProccntUsage : UInt32
    modBaseAddr : UInt8.Ptr
    modBaseSize : UInt32
    hModule : HMODULE
    szModule : CHAR[256]
    szExePath : CHAR[260]
}
