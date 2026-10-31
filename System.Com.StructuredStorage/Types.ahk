#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, DECIMAL, FILETIME, HRESULT, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {BLOB, CY, IDispatch, IErrorLog, IPersist, IStream, IUnknown, SAFEARRAY, STATSTG, STGM, StorageLayout}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}

struct PROPSPEC_KIND extends UInt32 {
    static PRSPEC_LPWSTR := 0
    static PRSPEC_PROPID := 1
}
struct STGFMT extends UInt32 {
    static STGFMT_STORAGE := 0
    static STGFMT_NATIVE := 1
    static STGFMT_FILE := 3
    static STGFMT_ANY := 4
    static STGFMT_DOCFILE := 5
    static STGFMT_DOCUMENT := 0
}
struct STGMOVE extends Int32 {
    static STGMOVE_MOVE := 0
    static STGMOVE_COPY := 1
    static STGMOVE_SHALLOWCOPY := 2
}
struct BSTRBLOB {
    cbSize : UInt32
    pData : UInt8.Ptr
}
struct CLIPDATA {
    cbSize : UInt32 := this.Size
    ulClipFmt : Int32
    pClipData : UInt8.Ptr
}
struct IEnumSTATSTG extends IUnknown {
    static IID := "{0000000D-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, STATSTG.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSTATSTG.Ptr, ppenum)
}
struct RemSNB {
    ulCntStr : UInt32
    ulCntChar : UInt32
    rgString : UInt16[1]
}
struct IStorage extends IUnknown {
    static IID := "{0000000B-0000-0000-C000-000000000046}"
    CreateStream(pwcsName, grfMode, reserved1, reserved2, ppstm)
      => ComCall(3, this.p, "Str", pwcsName, STGM, grfMode, UInt32, reserved1, UInt32, reserved2, IStream.Ptr, ppstm)
    OpenStream(pwcsName, grfMode, reserved2, ppstm)
      => ComCall(4, this.p, "Str", pwcsName, "Ptr", 0, STGM, grfMode, UInt32, reserved2, IStream.Ptr, ppstm)
    CreateStorage(pwcsName, grfMode, reserved1, reserved2, ppstg)
      => ComCall(5, this.p, "Str", pwcsName, STGM, grfMode, UInt32, reserved1, UInt32, reserved2, IStorage.Ptr, ppstg)
    OpenStorage(pwcsName, pstgPriority, grfMode, snbExclude, reserved, ppstg)
      => ComCall(6, this.p, "Str", pwcsName, IStorage, pstgPriority, STGM, grfMode, UInt16.Ptr.Ptr, snbExclude, UInt32, reserved, IStorage.Ptr, ppstg)
    CopyTo(rgiidExclude?, snbExclude?, pstgDest)
      => ComCall(7, this.p, UInt32, rgiidExclude?.Length ?? 0, GUID.Ptr, rgiidExclude?, UInt16.Ptr.Ptr, snbExclude?, IStorage, pstgDest)
    MoveElementTo(pwcsName, pstgDest, pwcsNewName, grfFlags)
      => ComCall(8, this.p, "Str", pwcsName, IStorage, pstgDest, "Str", pwcsNewName, UInt32, grfFlags)
    Commit(grfCommitFlags)
      => ComCall(9, this.p, UInt32, grfCommitFlags)
    Revert()
      => ComCall(10, this.p)
    EnumElements(ppenum)
      => ComCall(11, this.p, "Ptr", 0, "Ptr", 0, "Ptr", 0, IEnumSTATSTG.Ptr, ppenum)
    DestroyElement(pwcsName)
      => ComCall(12, this.p, "Str", pwcsName)
    RenameElement(pwcsOldName, pwcsNewName)
      => ComCall(13, this.p, "Str", pwcsOldName, "Str", pwcsNewName)
    SetElementTimes(pwcsName, pctime, patime, pmtime)
      => ComCall(14, this.p, "Str", pwcsName, FILETIME.Ptr, pctime, FILETIME.Ptr, patime, FILETIME.Ptr, pmtime)
    SetClass(clsid)
      => ComCall(15, this.p, GUID.Ptr, clsid)
    SetStateBits(grfStateBits, grfMask)
      => ComCall(16, this.p, UInt32, grfStateBits, UInt32, grfMask)
    Stat(pstatstg, grfStatFlag)
      => ComCall(17, this.p, STATSTG.Ptr, pstatstg, UInt32, grfStatFlag)
}
struct IPersistStorage extends IPersist {
    static IID := "{0000010A-0000-0000-C000-000000000046}"
    IsDirty()
      => ComCall(4, this.p)
    InitNew(pStg)
      => ComCall(5, this.p, IStorage, pStg)
    Load(pStg)
      => ComCall(6, this.p, IStorage, pStg)
    Save(pStgSave, fSameAsLoad)
      => ComCall(7, this.p, IStorage, pStgSave, BOOL, fSameAsLoad)
    SaveCompleted(pStgNew)
      => ComCall(8, this.p, IStorage, pStgNew)
    HandsOffStorage()
      => ComCall(9, this.p)
}
struct ILockBytes extends IUnknown {
    static IID := "{0000000A-0000-0000-C000-000000000046}"
    ReadAt(ulOffset, pv, pcbRead?)
      => ComCall(3, this.p, Int64, ulOffset, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbRead?)
    WriteAt(ulOffset, pv, pcbWritten?)
      => ComCall(4, this.p, Int64, ulOffset, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbWritten?)
    Flush()
      => ComCall(5, this.p)
    SetSize(cb)
      => ComCall(6, this.p, Int64, cb)
    LockRegion(libOffset, cb, dwLockType)
      => ComCall(7, this.p, Int64, libOffset, Int64, cb, UInt32, dwLockType)
    UnlockRegion(libOffset, cb, dwLockType)
      => ComCall(8, this.p, Int64, libOffset, Int64, cb, UInt32, dwLockType)
    Stat(pstatstg, grfStatFlag)
      => ComCall(9, this.p, STATSTG.Ptr, pstatstg, UInt32, grfStatFlag)
}
struct IRootStorage extends IUnknown {
    static IID := "{00000012-0000-0000-C000-000000000046}"
    SwitchToFile(pszFile)
      => ComCall(3, this.p, "Str", pszFile)
}
struct IFillLockBytes extends IUnknown {
    static IID := "{99CAF010-415E-11CF-8814-00AA00B569F5}"
    FillAppend(pv, pcbWritten)
      => ComCall(3, this.p, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbWritten)
    FillAt(ulOffset, pv, pcbWritten)
      => ComCall(4, this.p, Int64, ulOffset, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbWritten)
    SetFillSize(ulSize)
      => ComCall(5, this.p, Int64, ulSize)
    Terminate(bCanceled)
      => ComCall(6, this.p, BOOL, bCanceled)
}
struct ILayoutStorage extends IUnknown {
    static IID := "{0E6D4D90-6738-11CF-9608-00AA00680DB4}"
    LayoutScript(pStorageLayout)
      => ComCall(3, this.p, StorageLayout.Ptr, pStorageLayout, UInt32, pStorageLayout.Length, "Ptr", 0)
    BeginMonitor()
      => ComCall(4, this.p)
    EndMonitor()
      => ComCall(5, this.p)
    ReLayoutDocfile(pwcsNewDfName)
      => ComCall(6, this.p, "Str", pwcsNewDfName)
    ReLayoutDocfileOnILockBytes(pILockBytes)
      => ComCall(7, this.p, ILockBytes, pILockBytes)
}
struct IDirectWriterLock extends IUnknown {
    static IID := "{0E6D4D92-6738-11CF-9608-00AA00680DB4}"
    WaitForWriteAccess(dwTimeout)
      => ComCall(3, this.p, UInt32, dwTimeout)
    ReleaseWriteAccess()
      => ComCall(4, this.p)
    HaveWriteAccess()
      => ComCall(5, this.p)
}
struct VERSIONEDSTREAM {
    guidVersion : GUID
    pStream : IStream
}
struct CAC {
    cElems : UInt32
    pElems : PSTR
}
struct CAUB {
    cElems : UInt32
    pElems : UInt8.Ptr
}
struct CAI {
    cElems : UInt32
    pElems : Int16.Ptr
}
struct CAUI {
    cElems : UInt32
    pElems : UInt16.Ptr
}
struct CAL {
    cElems : UInt32
    pElems : Int32.Ptr
}
struct CAUL {
    cElems : UInt32
    pElems : UInt32.Ptr
}
struct CAFLT {
    cElems : UInt32
    pElems : Float32.Ptr
}
struct CADBL {
    cElems : UInt32
    pElems : Float64.Ptr
}
struct CACY {
    cElems : UInt32
    pElems : CY.Ptr
}
struct CADATE {
    cElems : UInt32
    pElems : Float64.Ptr
}
struct CABSTR {
    cElems : UInt32
    pElems : BSTR.Ptr
}
struct CABSTRBLOB {
    cElems : UInt32
    pElems : BSTRBLOB.Ptr
}
struct CABOOL {
    cElems : UInt32
    pElems : VARIANT_BOOL.Ptr
}
struct CASCODE {
    cElems : UInt32
    pElems : Int32.Ptr
}
struct CAPROPVARIANT {
    cElems : UInt32
    pElems : PROPVARIANT.Ptr
}
struct CAH {
    cElems : UInt32
    pElems : Int64.Ptr
}
struct CAUH {
    cElems : UInt32
    pElems : Int64.Ptr
}
struct CALPSTR {
    cElems : UInt32
    pElems : PSTR.Ptr
}
struct CALPWSTR {
    cElems : UInt32
    pElems : PWSTR.Ptr
}
struct CAFILETIME {
    cElems : UInt32
    pElems : FILETIME.Ptr
}
struct CACLIPDATA {
    cElems : UInt32
    pElems : CLIPDATA.Ptr
}
struct CACLSID {
    cElems : UInt32
    pElems : GUID.Ptr
}
struct PROPVARIANT {
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
                    cVal : CHAR
                    bVal : UInt8
                    iVal : Int16
                    uiVal : UInt16
                    lVal : Int32
                    ulVal : UInt32
                    intVal : Int32
                    uintVal : UInt32
                    hVal : Int64
                    uhVal : Int64
                    fltVal : Float32
                    dblVal : Float64
                    boolVal : VARIANT_BOOL
                    __OBSOLETE__VARIANT_BOOL : VARIANT_BOOL
                    scode : Int32
                    cyVal : CY
                    date : Float64
                    filetime : FILETIME
                    puuid : GUID.Ptr
                    pclipdata : CLIPDATA.Ptr
                    bstrVal : BSTR
                    bstrblobVal : BSTRBLOB
                    blob : BLOB
                    pszVal : PSTR
                    pwszVal : PWSTR
                    punkVal : IUnknown
                    pdispVal : IDispatch
                    pStream : IStream
                    pStorage : IStorage
                    pVersionedStream : VERSIONEDSTREAM.Ptr
                    parray : SAFEARRAY.Ptr
                    cac : CAC
                    caub : CAUB
                    cai : CAI
                    caui : CAUI
                    cal : CAL
                    caul : CAUL
                    cah : CAH
                    cauh : CAUH
                    caflt : CAFLT
                    cadbl : CADBL
                    cabool : CABOOL
                    cascode : CASCODE
                    cacy : CACY
                    cadate : CADATE
                    cafiletime : CAFILETIME
                    cauuid : CACLSID
                    caclipdata : CACLIPDATA
                    cabstr : CABSTR
                    cabstrblob : CABSTRBLOB
                    calpstr : CALPSTR
                    calpwstr : CALPWSTR
                    capropvar : CAPROPVARIANT
                    pcVal : PSTR
                    pbVal : UInt8.Ptr
                    piVal : Int16.Ptr
                    puiVal : UInt16.Ptr
                    plVal : Int32.Ptr
                    pulVal : UInt32.Ptr
                    pintVal : Int32.Ptr
                    puintVal : UInt32.Ptr
                    pfltVal : Float32.Ptr
                    pdblVal : Float64.Ptr
                    pboolVal : VARIANT_BOOL.Ptr
                    pdecVal : DECIMAL.Ptr
                    pscode : Int32.Ptr
                    pcyVal : CY.Ptr
                    pdate : Float64.Ptr
                    pbstrVal : BSTR.Ptr
                    ppunkVal : IUnknown.Ptr
                    ppdispVal : IDispatch.Ptr
                    pparray : SAFEARRAY.Ptr.Ptr
                    pvarVal : PROPVARIANT.Ptr
                }
            }
        }
    }
}
struct PROPSPEC {
    ulKind : PROPSPEC_KIND
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            propid : UInt32
            lpwstr : PWSTR
        }
    }
}
struct STATPROPSTG {
    lpwstrName : PWSTR
    propid : UInt32
    vt : VARENUM
}
struct STATPROPSETSTG {
    fmtid : GUID
    clsid : GUID
    grfFlags : UInt32
    mtime : FILETIME
    ctime : FILETIME
    atime : FILETIME
    dwOSVersion : UInt32
}
struct IPropertyStorage extends IUnknown {
    static IID := "{00000138-0000-0000-C000-000000000046}"
    ReadMultiple(rgpspec, rgpropvar)
      => ComCall(3, this.p, UInt32, rgpropvar.Length, PROPSPEC.Ptr, rgpspec, PROPVARIANT.Ptr, rgpropvar)
    WriteMultiple(rgpspec, rgpropvar, propidNameFirst)
      => ComCall(4, this.p, UInt32, rgpropvar.Length, PROPSPEC.Ptr, rgpspec, PROPVARIANT.Ptr, rgpropvar, UInt32, propidNameFirst)
    DeleteMultiple(rgpspec)
      => ComCall(5, this.p, UInt32, rgpspec.Length, PROPSPEC.Ptr, rgpspec)
    ReadPropertyNames(rgpropid, rglpwstrName)
      => ComCall(6, this.p, UInt32, rglpwstrName.Length, UInt32.Ptr, rgpropid, PWSTR.Ptr, rglpwstrName)
    WritePropertyNames(rgpropid, rglpwstrName)
      => ComCall(7, this.p, UInt32, rglpwstrName.Length, UInt32.Ptr, rgpropid, PWSTR.Ptr, rglpwstrName)
    DeletePropertyNames(rgpropid)
      => ComCall(8, this.p, UInt32, rgpropid.Length, UInt32.Ptr, rgpropid)
    Commit(grfCommitFlags)
      => ComCall(9, this.p, UInt32, grfCommitFlags)
    Revert()
      => ComCall(10, this.p)
    Enum(ppenum)
      => ComCall(11, this.p, IEnumSTATPROPSTG.Ptr, ppenum)
    SetTimes(pctime, patime, pmtime)
      => ComCall(12, this.p, FILETIME.Ptr, pctime, FILETIME.Ptr, patime, FILETIME.Ptr, pmtime)
    SetClass(clsid)
      => ComCall(13, this.p, GUID.Ptr, clsid)
    Stat(pstatpsstg)
      => ComCall(14, this.p, STATPROPSETSTG.Ptr, pstatpsstg)
}
struct IPropertySetStorage extends IUnknown {
    static IID := "{0000013A-0000-0000-C000-000000000046}"
    Create(rfmtid, pclsid, grfFlags, grfMode, ppprstg)
      => ComCall(3, this.p, GUID.Ptr, rfmtid, GUID.Ptr, pclsid, UInt32, grfFlags, UInt32, grfMode, IPropertyStorage.Ptr, ppprstg)
    Open(rfmtid, grfMode, ppprstg)
      => ComCall(4, this.p, GUID.Ptr, rfmtid, UInt32, grfMode, IPropertyStorage.Ptr, ppprstg)
    Delete(rfmtid)
      => ComCall(5, this.p, GUID.Ptr, rfmtid)
    Enum(ppenum)
      => ComCall(6, this.p, IEnumSTATPROPSETSTG.Ptr, ppenum)
}
struct IEnumSTATPROPSTG extends IUnknown {
    static IID := "{00000139-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, STATPROPSTG.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSTATPROPSTG.Ptr, ppenum)
}
struct IEnumSTATPROPSETSTG extends IUnknown {
    static IID := "{0000013B-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, STATPROPSETSTG.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSTATPROPSETSTG.Ptr, ppenum)
}
struct STGOPTIONS {
    usVersion : UInt16
    reserved : UInt16
    ulSectorSize : UInt32
    pwcsTemplateFile : PWSTR
}
struct PIDMSI_STATUS_VALUE extends Int32 {
    static PIDMSI_STATUS_NORMAL := 0
    static PIDMSI_STATUS_NEW := 1
    static PIDMSI_STATUS_PRELIM := 2
    static PIDMSI_STATUS_DRAFT := 3
    static PIDMSI_STATUS_INPROGRESS := 4
    static PIDMSI_STATUS_EDIT := 5
    static PIDMSI_STATUS_REVIEW := 6
    static PIDMSI_STATUS_PROOF := 7
    static PIDMSI_STATUS_FINAL := 8
    static PIDMSI_STATUS_OTHER := 32767
}
struct SERIALIZEDPROPERTYVALUE {
    dwType : UInt32
    rgb : UInt8[1]
}
struct IMemoryAllocator extends InterfacePointer {
    Allocate(cbSize)
      => ComCall(0, this.p, UInt32, cbSize, Struct.Ptr)
    Free(pv)
      => ComCall(1, this.p, Struct.Ptr, pv, "void")
}
struct IPropertyBag extends IUnknown {
    static IID := "{55272A00-42CB-11CE-8135-00AA004BB851}"
    Read(pszPropName, pVar, pErrorLog)
      => ComCall(3, this.p, "Str", pszPropName, VARIANT.Ptr, pVar, IErrorLog, pErrorLog)
    Write(pszPropName, pVar)
      => ComCall(4, this.p, "Str", pszPropName, VARIANT.Ptr, pVar)
}
struct OLESTREAMVTBL {
    Get : IntPtr
    Put : IntPtr
}
struct OLESTREAM {
    lpstbl : OLESTREAMVTBL.Ptr
}
struct PROPBAG2 {
    dwType : UInt32
    vt : VARENUM
    cfType : UInt16
    dwHint : UInt32
    pstrName : PWSTR
    clsid : GUID
}
struct IPropertyBag2 extends IUnknown {
    static IID := "{22F55882-280B-11D0-A8A9-00A0C90C2004}"
    Read(pPropBag, pErrLog, pvarValue, phrError)
      => ComCall(3, this.p, UInt32, phrError.Length, PROPBAG2.Ptr, pPropBag, IErrorLog, pErrLog, VARIANT.Ptr, pvarValue, HRESULT.Ptr, phrError)
    Write(pPropBag, pvarValue)
      => ComCall(4, this.p, UInt32, pvarValue.Length, PROPBAG2.Ptr, pPropBag, VARIANT.Ptr, pvarValue)
    CountProperties(pcProperties)
      => ComCall(5, this.p, UInt32.Ptr, pcProperties)
    GetPropertyInfo(iProperty, pPropBag, pcProperties)
      => ComCall(6, this.p, UInt32, iProperty, UInt32, pPropBag.Length, PROPBAG2.Ptr, pPropBag, UInt32.Ptr, pcProperties)
    LoadObject(pstrName, dwHint, pUnkObject, pErrLog)
      => ComCall(7, this.p, "Str", pstrName, UInt32, dwHint, IUnknown, pUnkObject, IErrorLog, pErrLog)
}
struct PROPVAR_COMPARE_UNIT extends Int32 {
    static PVCU_DEFAULT := 0
    static PVCU_SECOND := 1
    static PVCU_MINUTE := 2
    static PVCU_HOUR := 3
    static PVCU_DAY := 4
    static PVCU_MONTH := 5
    static PVCU_YEAR := 6
}
struct PROPVAR_COMPARE_FLAGS extends Int32 {
    static PVCF_DEFAULT := 0
    static PVCF_TREATEMPTYASGREATERTHAN := 1
    static PVCF_USESTRCMP := 2
    static PVCF_USESTRCMPC := 4
    static PVCF_USESTRCMPI := 8
    static PVCF_USESTRCMPIC := 16
    static PVCF_DIGITSASNUMBERS_CASESENSITIVE := 32
}
struct PROPVAR_CHANGE_FLAGS extends Int32 {
    static PVCHF_DEFAULT := 0
    static PVCHF_NOVALUEPROP := 1
    static PVCHF_ALPHABOOL := 2
    static PVCHF_NOUSEROVERRIDE := 4
    static PVCHF_LOCALBOOL := 8
    static PVCHF_NOHEXSTRING := 16
}
