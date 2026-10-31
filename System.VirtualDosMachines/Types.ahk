#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, LPARAM, PSTR}
#Import "..\System.Diagnostics.Debug\Types.ahk" {DEBUG_EVENT}
#Import "..\System.Kernel\Types.ahk" {FLOATING_SAVE_AREA}

struct VDMCONTEXT {
    ContextFlags : UInt32
    Dr0 : UInt32
    Dr1 : UInt32
    Dr2 : UInt32
    Dr3 : UInt32
    Dr6 : UInt32
    Dr7 : UInt32
    FloatSave : FLOATING_SAVE_AREA
    SegGs : UInt32
    SegFs : UInt32
    SegEs : UInt32
    SegDs : UInt32
    Edi : UInt32
    Esi : UInt32
    Ebx : UInt32
    Edx : UInt32
    Ecx : UInt32
    Eax : UInt32
    Ebp : UInt32
    Eip : UInt32
    SegCs : UInt32
    EFlags : UInt32
    Esp : UInt32
    SegSs : UInt32
    ExtendedRegisters : UInt8[512]
}
struct VDMLDT_ENTRY {
    LimitLow : UInt16
    BaseLow : UInt16
    HighWord : this._HighWord_e__Union
    struct _HighWord_e__Union {
        union {
            Bytes : this._Bytes_e__Struct
            Bits : this._Bits_e__Struct
        }
        struct _Bytes_e__Struct {
            BaseMid : UInt8
            Flags1 : UInt8
            Flags2 : UInt8
            BaseHi : UInt8
        }
        struct _Bits_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct VDMGETTHREADSELECTORENTRYPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, VDMLDT_ENTRY.Ptr, BOOL]
}
struct VDMGETCONTEXTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, VDMCONTEXT.Ptr, BOOL]
}
struct VDMSETCONTEXTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, VDMCONTEXT.Ptr, BOOL]
}
struct VDMCONTEXT_WITHOUT_XSAVE {
    ContextFlags : UInt32
    Dr0 : UInt32
    Dr1 : UInt32
    Dr2 : UInt32
    Dr3 : UInt32
    Dr6 : UInt32
    Dr7 : UInt32
    FloatSave : FLOATING_SAVE_AREA
    SegGs : UInt32
    SegFs : UInt32
    SegEs : UInt32
    SegDs : UInt32
    Edi : UInt32
    Esi : UInt32
    Ebx : UInt32
    Edx : UInt32
    Ecx : UInt32
    Eax : UInt32
    Ebp : UInt32
    Eip : UInt32
    SegCs : UInt32
    EFlags : UInt32
    Esp : UInt32
    SegSs : UInt32
}
struct SEGMENT_NOTE {
    Selector1 : UInt16
    Selector2 : UInt16
    Segment : UInt16
    Module : CHAR[10]
    FileName : CHAR[256]
    Type : UInt16
    Length : UInt32
}
struct IMAGE_NOTE {
    Module : CHAR[10]
    FileName : CHAR[256]
    hModule : UInt16
    hTask : UInt16
}
struct MODULEENTRY {
    dwSize : UInt32
    szModule : CHAR[10]
    hModule : HANDLE
    wcUsage : UInt16
    szExePath : CHAR[256]
    wNext : UInt16
}
struct TEMP_BP_NOTE {
    Seg : UInt16
    Offset : UInt32
    bPM : BOOL
}
struct VDM_SEGINFO {
    Selector : UInt16
    SegNumber : UInt16
    Length : UInt32
    Type : UInt16
    ModuleName : CHAR[9]
    FileName : CHAR[255]
}
struct GLOBALENTRY {
    dwSize : UInt32
    dwAddress : UInt32
    dwBlockSize : UInt32
    hBlock : HANDLE
    wcLock : UInt16
    wcPageLock : UInt16
    wFlags : UInt16
    wHeapPresent : BOOL
    hOwner : HANDLE
    wType : UInt16
    wData : UInt16
    dwNext : UInt32
    dwNextAlt : UInt32
}
struct DEBUGEVENTPROC extends FunctionPointer {
    static Types := [DEBUG_EVENT.Ptr, Struct.Ptr, UInt32]
}
struct PROCESSENUMPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, LPARAM, BOOL]
}
struct TASKENUMPROC extends FunctionPointer {
    static Types := [UInt32, UInt16, UInt16, LPARAM, BOOL]
}
struct TASKENUMPROCEX extends FunctionPointer {
    static Types := [UInt32, UInt16, UInt16, Int8.Ptr, Int8.Ptr, LPARAM, BOOL]
}
struct VDMPROCESSEXCEPTIONPROC extends FunctionPointer {
    static Types := [DEBUG_EVENT.Ptr, BOOL]
}
struct VDMGETPOINTERPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt16, UInt32, BOOL, UInt32]
}
struct VDMKILLWOWPROC extends FunctionPointer {
    static Types := [BOOL]
}
struct VDMDETECTWOWPROC extends FunctionPointer {
    static Types := [BOOL]
}
struct VDMBREAKTHREADPROC extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct VDMGETSELECTORMODULEPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt16, UInt32.Ptr, PSTR, UInt32, PSTR, UInt32, BOOL]
}
struct VDMGETMODULESELECTORPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, PSTR, UInt16.Ptr, BOOL]
}
struct VDMMODULEFIRSTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, MODULEENTRY.Ptr, DEBUGEVENTPROC, Struct.Ptr, BOOL]
}
struct VDMMODULENEXTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, MODULEENTRY.Ptr, DEBUGEVENTPROC, Struct.Ptr, BOOL]
}
struct VDMGLOBALFIRSTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, GLOBALENTRY.Ptr, UInt16, DEBUGEVENTPROC, Struct.Ptr, BOOL]
}
struct VDMGLOBALNEXTPROC extends FunctionPointer {
    static Types := [HANDLE, HANDLE, GLOBALENTRY.Ptr, UInt16, DEBUGEVENTPROC, Struct.Ptr, BOOL]
}
struct VDMENUMPROCESSWOWPROC extends FunctionPointer {
    static Types := [PROCESSENUMPROC, LPARAM, Int32]
}
struct VDMENUMTASKWOWPROC extends FunctionPointer {
    static Types := [UInt32, TASKENUMPROC, LPARAM, Int32]
}
struct VDMENUMTASKWOWEXPROC extends FunctionPointer {
    static Types := [UInt32, TASKENUMPROCEX, LPARAM, Int32]
}
struct VDMTERMINATETASKINWOWPROC extends FunctionPointer {
    static Types := [UInt32, UInt16, BOOL]
}
struct VDMSTARTTASKINWOWPROC extends FunctionPointer {
    static Types := [UInt32, PSTR, UInt16, BOOL]
}
struct VDMGETDBGFLAGSPROC extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct VDMSETDBGFLAGSPROC extends FunctionPointer {
    static Types := [HANDLE, UInt32, BOOL]
}
struct VDMISMODULELOADEDPROC extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct VDMGETSEGMENTINFOPROC extends FunctionPointer {
    static Types := [UInt16, UInt32, BOOL, VDM_SEGINFO, BOOL]
}
struct VDMGETSYMBOLPROC extends FunctionPointer {
    static Types := [PSTR, UInt16, UInt32, BOOL, BOOL, PSTR, UInt32.Ptr, BOOL]
}
struct VDMGETADDREXPRESSIONPROC extends FunctionPointer {
    static Types := [PSTR, PSTR, UInt16.Ptr, UInt32.Ptr, UInt16.Ptr, BOOL]
}
