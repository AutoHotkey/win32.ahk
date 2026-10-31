#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, CHAR, DECIMAL, PSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {CY, IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Ole\Types.ahk" {IRecordInfo}

struct VAR_CHANGE_FLAGS extends UInt16 {
    static VARIANT_NOVALUEPROP := 1
    static VARIANT_ALPHABOOL := 2
    static VARIANT_NOUSEROVERRIDE := 4
    static VARIANT_CALENDAR_HIJRI := 8
    static VARIANT_LOCALBOOL := 16
    static VARIANT_CALENDAR_THAI := 32
    static VARIANT_CALENDAR_GREGORIAN := 64
    static VARIANT_USE_NLS := 128
}
struct VARENUM extends UInt16 {
    static VT_EMPTY := 0
    static VT_NULL := 1
    static VT_I2 := 2
    static VT_I4 := 3
    static VT_R4 := 4
    static VT_R8 := 5
    static VT_CY := 6
    static VT_DATE := 7
    static VT_BSTR := 8
    static VT_DISPATCH := 9
    static VT_ERROR := 10
    static VT_BOOL := 11
    static VT_VARIANT := 12
    static VT_UNKNOWN := 13
    static VT_DECIMAL := 14
    static VT_I1 := 16
    static VT_UI1 := 17
    static VT_UI2 := 18
    static VT_UI4 := 19
    static VT_I8 := 20
    static VT_UI8 := 21
    static VT_INT := 22
    static VT_UINT := 23
    static VT_VOID := 24
    static VT_HRESULT := 25
    static VT_PTR := 26
    static VT_SAFEARRAY := 27
    static VT_CARRAY := 28
    static VT_USERDEFINED := 29
    static VT_LPSTR := 30
    static VT_LPWSTR := 31
    static VT_RECORD := 36
    static VT_INT_PTR := 37
    static VT_UINT_PTR := 38
    static VT_FILETIME := 64
    static VT_BLOB := 65
    static VT_STREAM := 66
    static VT_STORAGE := 67
    static VT_STREAMED_OBJECT := 68
    static VT_STORED_OBJECT := 69
    static VT_BLOB_OBJECT := 70
    static VT_CF := 71
    static VT_CLSID := 72
    static VT_VERSIONED_STREAM := 73
    static VT_BSTR_BLOB := 4095
    static VT_VECTOR := 4096
    static VT_ARRAY := 8192
    static VT_BYREF := 16384
    static VT_RESERVED := 32768
    static VT_ILLEGAL := 65535
    static VT_ILLEGALMASKED := 4095
    static VT_TYPEMASK := 4095
}
struct VARIANT {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            decVal : DECIMAL
        }
        struct _Anonymous_e__Struct {
            vt : VARENUM
            wReserved1 : UInt16
            wReserved2 : UInt16
            wReserved3 : UInt16
            Anonymous : this._Anonymous_e__Union
            struct _Anonymous_e__Union {
                union {
                    llVal : Int64
                    lVal : Int32
                    bVal : UInt8
                    iVal : Int16
                    fltVal : Float32
                    dblVal : Float64
                    boolVal : VARIANT_BOOL
                    __OBSOLETE__VARIANT_BOOL : VARIANT_BOOL
                    scode : Int32
                    cyVal : CY
                    date : Float64
                    bstrVal : BSTR
                    punkVal : IUnknown
                    pdispVal : IDispatch
                    parray : SAFEARRAY.Ptr
                    pbVal : UInt8.Ptr
                    piVal : Int16.Ptr
                    plVal : Int32.Ptr
                    pllVal : Int64.Ptr
                    pfltVal : Float32.Ptr
                    pdblVal : Float64.Ptr
                    pboolVal : VARIANT_BOOL.Ptr
                    __OBSOLETE__VARIANT_PBOOL : VARIANT_BOOL.Ptr
                    pscode : Int32.Ptr
                    pcyVal : CY.Ptr
                    pdate : Float64.Ptr
                    pbstrVal : BSTR.Ptr
                    ppunkVal : IUnknown.Ptr
                    ppdispVal : IDispatch.Ptr
                    pparray : SAFEARRAY.Ptr.Ptr
                    pvarVal : VARIANT.Ptr
                    byref : Struct.Ptr
                    cVal : CHAR
                    uiVal : UInt16
                    ulVal : UInt32
                    ullVal : Int64
                    intVal : Int32
                    uintVal : UInt32
                    pdecVal : DECIMAL.Ptr
                    pcVal : PSTR
                    puiVal : UInt16.Ptr
                    pulVal : UInt32.Ptr
                    pullVal : Int64.Ptr
                    pintVal : Int32.Ptr
                    puintVal : UInt32.Ptr
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    pvRecord : Struct.Ptr
                    pRecInfo : IRecordInfo
                }
            }
        }
    }
}
struct PSTIME_FLAGS extends Int32 {
    static PSTF_UTC := 0
    static PSTF_LOCAL := 1
}
struct DRAWPROGRESSFLAGS extends Int32 {
    static DPF_NONE := 0
    static DPF_MARQUEE := 1
    static DPF_MARQUEE_COMPLETE := 2
    static DPF_ERROR := 4
    static DPF_WARNING := 8
    static DPF_STOPPED := 16
}
