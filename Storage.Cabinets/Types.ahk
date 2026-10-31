#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, PSTR}

struct FDICREATE_CPU_TYPE extends Int32 {
    static cpuUNKNOWN := -1
    static cpu80286 := 0
    static cpu80386 := 1
}
struct FDISPILLFILE {
    ach : CHAR[2]
    cbFile : Int32
}
struct ERF {
    erfOper : Int32
    erfType : Int32
    fError : BOOL
}
struct FCIERROR extends Int32 {
    static FCIERR_NONE := 0
    static FCIERR_OPEN_SRC := 1
    static FCIERR_READ_SRC := 2
    static FCIERR_ALLOC_FAIL := 3
    static FCIERR_TEMP_FILE := 4
    static FCIERR_BAD_COMPR_TYPE := 5
    static FCIERR_CAB_FILE := 6
    static FCIERR_USER_ABORT := 7
    static FCIERR_MCI_FAIL := 8
    static FCIERR_CAB_FORMAT_LIMIT := 9
}
struct CCAB {
    cb : UInt32
    cbFolderThresh : UInt32
    cbReserveCFHeader : UInt32
    cbReserveCFFolder : UInt32
    cbReserveCFData : UInt32
    iCab : Int32
    iDisk : Int32
    fFailOnIncompressible : Int32
    setID : UInt16
    szDisk : CHAR[256]
    szCab : CHAR[256]
    szCabPath : CHAR[256]
}
struct PFNFCIALLOC extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
    static Options := "C"
}
struct PFNFCIFREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
    static Options := "C"
}
struct PFNFCIOPEN extends FunctionPointer {
    static Types := [PSTR, Int32, Int32, Int32.Ptr, Struct.Ptr, IntPtr]
    static Options := "C"
}
struct PFNFCIREAD extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, Int32.Ptr, Struct.Ptr, UInt32]
    static Options := "C"
}
struct PFNFCIWRITE extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, Int32.Ptr, Struct.Ptr, UInt32]
    static Options := "C"
}
struct PFNFCICLOSE extends FunctionPointer {
    static Types := [IntPtr, Int32.Ptr, Struct.Ptr, Int32]
    static Options := "C"
}
struct PFNFCISEEK extends FunctionPointer {
    static Types := [IntPtr, Int32, Int32, Int32.Ptr, Struct.Ptr, Int32]
    static Options := "C"
}
struct PFNFCIDELETE extends FunctionPointer {
    static Types := [PSTR, Int32.Ptr, Struct.Ptr, Int32]
    static Options := "C"
}
struct PFNFCIGETNEXTCABINET extends FunctionPointer {
    static Types := [CCAB.Ptr, UInt32, Struct.Ptr, BOOL]
    static Options := "C"
}
struct PFNFCIFILEPLACED extends FunctionPointer {
    static Types := [CCAB.Ptr, PSTR, Int32, BOOL, Struct.Ptr, Int32]
    static Options := "C"
}
struct PFNFCIGETOPENINFO extends FunctionPointer {
    static Types := [PSTR, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, Int32.Ptr, Struct.Ptr, IntPtr]
    static Options := "C"
}
struct PFNFCISTATUS extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, Struct.Ptr, Int32]
    static Options := "C"
}
struct PFNFCIGETTEMPFILE extends FunctionPointer {
    static Types := [PSTR, Int32, Struct.Ptr, BOOL]
    static Options := "C"
}
struct FDIERROR extends Int32 {
    static FDIERROR_NONE := 0
    static FDIERROR_CABINET_NOT_FOUND := 1
    static FDIERROR_NOT_A_CABINET := 2
    static FDIERROR_UNKNOWN_CABINET_VERSION := 3
    static FDIERROR_CORRUPT_CABINET := 4
    static FDIERROR_ALLOC_FAIL := 5
    static FDIERROR_BAD_COMPR_TYPE := 6
    static FDIERROR_MDI_FAIL := 7
    static FDIERROR_TARGET_FILE := 8
    static FDIERROR_RESERVE_MISMATCH := 9
    static FDIERROR_WRONG_CABINET := 10
    static FDIERROR_USER_ABORT := 11
    static FDIERROR_EOF := 12
}
struct FDICABINETINFO {
    cbCabinet : Int32
    cFolders : UInt16
    cFiles : UInt16
    setID : UInt16
    iCabinet : UInt16
    fReserve : BOOL
    hasprev : BOOL
    hasnext : BOOL
}
struct FDIDECRYPTTYPE extends Int32 {
    static fdidtNEW_CABINET := 0
    static fdidtNEW_FOLDER := 1
    static fdidtDECRYPT := 2
}
struct FDIDECRYPT {
    fdidt : FDIDECRYPTTYPE
    pvUser : Struct.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            cabinet : this._cabinet_e__Struct
            folder : this._folder_e__Struct
            decrypt : this._decrypt_e__Struct
        }
        struct _cabinet_e__Struct {
            pHeaderReserve : Struct.Ptr
            cbHeaderReserve : UInt16
            setID : UInt16
            iCabinet : Int32
        }
        struct _folder_e__Struct {
            pFolderReserve : Struct.Ptr
            cbFolderReserve : UInt16
            iFolder : UInt16
        }
        struct _decrypt_e__Struct {
            pDataReserve : Struct.Ptr
            cbDataReserve : UInt16
            pbData : Struct.Ptr
            cbData : UInt16
            fSplit : BOOL
            cbPartial : UInt16
        }
    }
}
struct PFNALLOC extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr]
    static Options := "C"
}
struct PFNFREE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
    static Options := "C"
}
struct PFNOPEN extends FunctionPointer {
    static Types := [PSTR, Int32, Int32, IntPtr]
    static Options := "C"
}
struct PFNREAD extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct PFNWRITE extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct PFNCLOSE extends FunctionPointer {
    static Types := [IntPtr, Int32]
    static Options := "C"
}
struct PFNSEEK extends FunctionPointer {
    static Types := [IntPtr, Int32, Int32, Int32]
    static Options := "C"
}
struct PFNFDIDECRYPT extends FunctionPointer {
    static Types := [FDIDECRYPT.Ptr, Int32]
    static Options := "C"
}
struct FDINOTIFICATION {
    cb : Int32
    psz1 : PSTR
    psz2 : PSTR
    psz3 : PSTR
    pv : Struct.Ptr
    hf : IntPtr
    date : UInt16
    time : UInt16
    attribs : UInt16
    setID : UInt16
    iCabinet : UInt16
    iFolder : UInt16
    fdie : FDIERROR
}
struct FDINOTIFICATIONTYPE extends Int32 {
    static fdintCABINET_INFO := 0
    static fdintPARTIAL_FILE := 1
    static fdintCOPY_FILE := 2
    static fdintCLOSE_FILE_INFO := 3
    static fdintNEXT_CABINET := 4
    static fdintENUMERATE := 5
}
struct PFNFDINOTIFY extends FunctionPointer {
    static Types := [FDINOTIFICATIONTYPE, FDINOTIFICATION.Ptr, IntPtr]
    static Options := "C"
}
