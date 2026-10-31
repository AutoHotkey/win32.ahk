#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, DECIMAL, FILETIME, HGLOBAL, HINSTANCE, HRESULT, HRSRC, HTASK, HWND, LPARAM, LRESULT, POINT, POINTL, PSTR, PWSTR, RECT, RECTL, SIZE, SYSTEMTIME, VARIANT_BOOL, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HDC, HENHMETAFILE, HFONT, HMETAFILE, HPALETTE, HRGN, LOGPALETTE, TEXTMETRICW}
#Import "..\System.Com\Types.ahk" {BYTE_SIZEDARR, CALLCONV, CY, DISPPARAMS, DVASPECT, DVTARGETDEVICE, DWORD_SIZEDARR, EXCEPINFO, FLAGGED_WORD_BLOB, FORMATETC, FUNCDESC, HYPER_SIZEDARR, IAdviseSink, IBindCtx, IBindHost, IClassFactory, IDLDESC, IDataObject, IDispatch, IEnumSTATDATA, IEnumUnknown, IErrorLog, IMPLTYPEFLAGS, IMoniker, INVOKEKIND, IPersist, IServiceProvider, IStream, ITypeInfo, IUnknown, SAFEARRAYBOUND, STGMEDIUM, TYPEDESC, TYPEKIND, VARDESC, WORD_SIZEDARR}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag, IPropertyBag2, IStorage}
#Import "..\System.SystemServices\Types.ahk" {MODIFIERKEYS_FLAGS}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}
#Import "..\UI.Controls\Types.ahk" {PROPSHEETHEADERA_V2, PROPSHEETHEADERW_V2}
#Import "..\UI.Controls.Dialogs\Types.ahk" {OPENFILENAMEA, OPENFILENAMEW}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HACCEL, HICON, HMENU, MENU_ITEM_FLAGS, MSG}

struct CLIPBOARD_FORMAT extends UInt16 {
    static CF_TEXT := 1
    static CF_BITMAP := 2
    static CF_METAFILEPICT := 3
    static CF_SYLK := 4
    static CF_DIF := 5
    static CF_TIFF := 6
    static CF_OEMTEXT := 7
    static CF_DIB := 8
    static CF_PALETTE := 9
    static CF_PENDATA := 10
    static CF_RIFF := 11
    static CF_WAVE := 12
    static CF_UNICODETEXT := 13
    static CF_ENHMETAFILE := 14
    static CF_HDROP := 15
    static CF_LOCALE := 16
    static CF_DIBV5 := 17
    static CF_MAX := 18
    static CF_OWNERDISPLAY := 128
    static CF_DSPTEXT := 129
    static CF_DSPBITMAP := 130
    static CF_DSPMETAFILEPICT := 131
    static CF_DSPENHMETAFILE := 142
    static CF_PRIVATEFIRST := 512
    static CF_PRIVATELAST := 767
    static CF_GDIOBJFIRST := 768
    static CF_GDIOBJLAST := 1023
}
struct OLEIVERB extends Int32 {
    static OLEIVERB_PRIMARY := 0
    static OLEIVERB_SHOW := -1
    static OLEIVERB_OPEN := -2
    static OLEIVERB_HIDE := -3
    static OLEIVERB_UIACTIVATE := -4
    static OLEIVERB_INPLACEACTIVATE := -5
    static OLEIVERB_DISCARDUNDOSTATE := -6
}
struct UPDFCACHE_FLAGS extends UInt32 {
    static UPDFCACHE_ALL := 2147483647
    static UPDFCACHE_ALLBUTNODATACACHE := 2147483646
    static UPDFCACHE_NORMALCACHE := 8
    static UPDFCACHE_IFBLANK := 16
    static UPDFCACHE_ONLYIFBLANK := 2147483648
    static UPDFCACHE_NODATACACHE := 1
    static UPDFCACHE_ONSAVECACHE := 2
    static UPDFCACHE_ONSTOPCACHE := 4
    static UPDFCACHE_IFBLANKORONSAVECACHE := 18
}
struct ENUM_CONTROLS_WHICH_FLAGS extends UInt32 {
    static GCW_WCH_SIBLING := 1
    static GC_WCH_CONTAINER := 2
    static GC_WCH_CONTAINED := 3
    static GC_WCH_ALL := 4
    static GC_WCH_FREVERSEDIR := 134217728
    static GC_WCH_FONLYAFTER := 268435456
    static GC_WCH_FONLYBEFORE := 536870912
    static GC_WCH_FSELECTED := 1073741824
}
struct MULTICLASSINFO_FLAGS extends UInt32 {
    static MULTICLASSINFO_GETTYPEINFO := 1
    static MULTICLASSINFO_GETNUMRESERVEDDISPIDS := 2
    static MULTICLASSINFO_GETIIDPRIMARY := 4
    static MULTICLASSINFO_GETIIDSOURCE := 8
}
struct DROPEFFECT extends UInt32 {
    static DROPEFFECT_NONE := 0
    static DROPEFFECT_COPY := 1
    static DROPEFFECT_MOVE := 2
    static DROPEFFECT_LINK := 4
    static DROPEFFECT_SCROLL := 2147483648
}
struct KEYMODIFIERS extends UInt32 {
    static KEYMOD_SHIFT := 1
    static KEYMOD_CONTROL := 2
    static KEYMOD_ALT := 4
}
struct ACTIVEOBJECT_FLAGS extends UInt32 {
    static ACTIVEOBJECT_STRONG := 0
    static ACTIVEOBJECT_WEAK := 1
}
struct BUSY_DIALOG_FLAGS extends UInt32 {
    static BZ_DISABLECANCELBUTTON := 1
    static BZ_DISABLESWITCHTOBUTTON := 2
    static BZ_DISABLERETRYBUTTON := 4
    static BZ_NOTRESPONDINGDIALOG := 8
}
struct UI_CONVERT_FLAGS extends UInt32 {
    static CF_SHOWHELPBUTTON := 1
    static CF_SETCONVERTDEFAULT := 2
    static CF_SETACTIVATEDEFAULT := 4
    static CF_SELECTCONVERTTO := 8
    static CF_SELECTACTIVATEAS := 16
    static CF_DISABLEDISPLAYASICON := 32
    static CF_DISABLEACTIVATEAS := 64
    static CF_HIDECHANGEICON := 128
    static CF_CONVERTONLY := 256
}
struct CHANGE_ICON_FLAGS extends UInt32 {
    static CIF_SHOWHELP := 1
    static CIF_SELECTCURRENT := 2
    static CIF_SELECTDEFAULT := 4
    static CIF_SELECTFROMFILE := 8
    static CIF_USEICONEXE := 16
}
struct CHANGE_SOURCE_FLAGS extends UInt32 {
    static CSF_SHOWHELP := 1
    static CSF_VALIDSOURCE := 2
    static CSF_ONLYGETSOURCE := 4
    static CSF_EXPLORER := 8
}
struct EDIT_LINKS_FLAGS extends UInt32 {
    static ELF_SHOWHELP := 1
    static ELF_DISABLEUPDATENOW := 2
    static ELF_DISABLEOPENSOURCE := 4
    static ELF_DISABLECHANGESOURCE := 8
    static ELF_DISABLECANCELLINK := 16
}
struct INSERT_OBJECT_FLAGS extends UInt32 {
    static IOF_SHOWHELP := 1
    static IOF_SELECTCREATENEW := 2
    static IOF_SELECTCREATEFROMFILE := 4
    static IOF_CHECKLINK := 8
    static IOF_CHECKDISPLAYASICON := 16
    static IOF_CREATENEWOBJECT := 32
    static IOF_CREATEFILEOBJECT := 64
    static IOF_CREATELINKOBJECT := 128
    static IOF_DISABLELINK := 256
    static IOF_VERIFYSERVERSEXIST := 512
    static IOF_DISABLEDISPLAYASICON := 1024
    static IOF_HIDECHANGEICON := 2048
    static IOF_SHOWINSERTCONTROL := 4096
    static IOF_SELECTCREATECONTROL := 8192
}
struct OBJECT_PROPERTIES_FLAGS extends UInt32 {
    static OPF_OBJECTISLINK := 1
    static OPF_NOFILLDEFAULT := 2
    static OPF_SHOWHELP := 4
    static OPF_DISABLECONVERT := 8
}
struct VIEW_OBJECT_PROPERTIES_FLAGS extends UInt32 {
    static VPF_SELECTRELATIVE := 1
    static VPF_DISABLERELATIVE := 2
    static VPF_DISABLESCALE := 4
}
struct PARAMFLAGS extends UInt16 {
    static PARAMFLAG_NONE := 0
    static PARAMFLAG_FIN := 1
    static PARAMFLAG_FOUT := 2
    static PARAMFLAG_FLCID := 4
    static PARAMFLAG_FRETVAL := 8
    static PARAMFLAG_FOPT := 16
    static PARAMFLAG_FHASDEFAULT := 32
    static PARAMFLAG_FHASCUSTDATA := 64
}
struct NUMPARSE_FLAGS extends UInt32 {
    static NUMPRS_LEADING_WHITE := 1
    static NUMPRS_TRAILING_WHITE := 2
    static NUMPRS_LEADING_PLUS := 4
    static NUMPRS_TRAILING_PLUS := 8
    static NUMPRS_LEADING_MINUS := 16
    static NUMPRS_TRAILING_MINUS := 32
    static NUMPRS_HEX_OCT := 64
    static NUMPRS_PARENS := 128
    static NUMPRS_DECIMAL := 256
    static NUMPRS_THOUSANDS := 512
    static NUMPRS_CURRENCY := 1024
    static NUMPRS_EXPONENT := 2048
    static NUMPRS_USE_ALL := 4096
    static NUMPRS_STD := 8191
    static NUMPRS_NEG := 65536
    static NUMPRS_INEXACT := 131072
}
struct PICTYPE extends Int16 {
    static PICTYPE_UNINITIALIZED := -1
    static PICTYPE_NONE := 0
    static PICTYPE_BITMAP := 1
    static PICTYPE_METAFILE := 2
    static PICTYPE_ICON := 3
    static PICTYPE_ENHMETAFILE := 4
}
struct VARCMP extends UInt32 {
    static VARCMP_LT := 0
    static VARCMP_EQ := 1
    static VARCMP_GT := 2
    static VARCMP_NULL := 3
}
struct PASTE_SPECIAL_FLAGS extends UInt32 {
    static PSF_SHOWHELP := 1
    static PSF_SELECTPASTE := 2
    static PSF_SELECTPASTELINK := 4
    static PSF_CHECKDISPLAYASICON := 8
    static PSF_DISABLEDISPLAYASICON := 16
    static PSF_HIDECHANGEICON := 32
    static PSF_STAYONCLIPBOARDCHANGE := 64
    static PSF_NOREFRESHDATAOBJECT := 128
}
struct EMBDHLP_FLAGS extends UInt32 {
    static EMBDHLP_INPROC_HANDLER := 0
    static EMBDHLP_INPROC_SERVER := 1
    static EMBDHLP_CREATENOW := 0
    static EMBDHLP_DELAYCREATE := 65536
}
struct FDEX_PROP_FLAGS extends UInt32 {
    static fdexPropCanGet := 1
    static fdexPropCannotGet := 2
    static fdexPropCanPut := 4
    static fdexPropCannotPut := 8
    static fdexPropCanPutRef := 16
    static fdexPropCannotPutRef := 32
    static fdexPropNoSideEffects := 64
    static fdexPropDynamicType := 128
    static fdexPropCanCall := 256
    static fdexPropCannotCall := 512
    static fdexPropCanConstruct := 1024
    static fdexPropCannotConstruct := 2048
    static fdexPropCanSourceEvents := 4096
    static fdexPropCannotSourceEvents := 8192
}
struct LOAD_PICTURE_FLAGS extends UInt32 {
    static LP_DEFAULT := 0
    static LP_MONOCHROME := 1
    static LP_VGACOLOR := 2
    static LP_COLOR := 4
}
struct OLECREATE extends UInt32 {
    static OLECREATE_ZERO := 0
    static OLECREATE_LEAVERUNNING := 1
}
struct VARFORMAT_FIRST_DAY extends Int32 {
    static VARFORMAT_FIRST_DAY_SYSTEMDEFAULT := 0
    static VARFORMAT_FIRST_DAY_MONDAY := 1
    static VARFORMAT_FIRST_DAY_TUESDAY := 2
    static VARFORMAT_FIRST_DAY_WEDNESDAY := 3
    static VARFORMAT_FIRST_DAY_THURSDAY := 4
    static VARFORMAT_FIRST_DAY_FRIDAY := 5
    static VARFORMAT_FIRST_DAY_SATURDAY := 6
    static VARFORMAT_FIRST_DAY_SUNDAY := 7
}
struct VARFORMAT_FIRST_WEEK extends Int32 {
    static VARFORMAT_FIRST_WEEK_SYSTEMDEFAULT := 0
    static VARFORMAT_FIRST_WEEK_CONTAINS_JANUARY_FIRST := 1
    static VARFORMAT_FIRST_WEEK_LARGER_HALF_IN_CURRENT_YEAR := 2
    static VARFORMAT_FIRST_WEEK_HAS_SEVEN_DAYS := 3
}
struct VARFORMAT_NAMED_FORMAT extends Int32 {
    static VARFORMAT_NAMED_FORMAT_GENERALDATE := 0
    static VARFORMAT_NAMED_FORMAT_LONGDATE := 1
    static VARFORMAT_NAMED_FORMAT_SHORTDATE := 2
    static VARFORMAT_NAMED_FORMAT_LONGTIME := 3
    static VARFORMAT_NAMED_FORMAT_SHORTTIME := 4
}
struct VARFORMAT_LEADING_DIGIT extends Int32 {
    static VARFORMAT_LEADING_DIGIT_SYSTEMDEFAULT := -2
    static VARFORMAT_LEADING_DIGIT_INCLUDED := -1
    static VARFORMAT_LEADING_DIGIT_NOTINCLUDED := 0
}
struct VARFORMAT_PARENTHESES extends Int32 {
    static VARFORMAT_PARENTHESES_SYSTEMDEFAULT := -2
    static VARFORMAT_PARENTHESES_USED := -1
    static VARFORMAT_PARENTHESES_NOTUSED := 0
}
struct VARFORMAT_GROUP extends Int32 {
    static VARFORMAT_GROUP_SYSTEMDEFAULT := -2
    static VARFORMAT_GROUP_THOUSANDS := -1
    static VARFORMAT_GROUP_NOTTHOUSANDS := 0
}
struct OLE_HANDLE {
    Value : UInt32
}
struct SAFEARR_BSTR {
    Size : UInt32
    aBstr : FLAGGED_WORD_BLOB.Ptr.Ptr
}
struct SAFEARR_UNKNOWN {
    Size : UInt32
    apUnknown : IUnknown.Ptr
}
struct SAFEARR_DISPATCH {
    Size : UInt32
    apDispatch : IDispatch.Ptr
}
struct SAFEARR_VARIANT {
    Size : UInt32
    aVariant : wireVARIANT.Ptr.Ptr
}
struct SAFEARR_BRECORD {
    Size : UInt32
    aRecord : wireBRECORD.Ptr.Ptr
}
struct SAFEARR_HAVEIID {
    Size : UInt32
    apUnknown : IUnknown.Ptr
    iid : GUID
}
struct SF_TYPE extends Int32 {
    static SF_ERROR := 10
    static SF_I1 := 16
    static SF_I2 := 2
    static SF_I4 := 3
    static SF_I8 := 20
    static SF_BSTR := 8
    static SF_UNKNOWN := 13
    static SF_DISPATCH := 9
    static SF_VARIANT := 12
    static SF_RECORD := 36
    static SF_HAVEIID := 32781
}
struct SAFEARRAYUNION {
    sfType : UInt32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            BstrStr : SAFEARR_BSTR
            UnknownStr : SAFEARR_UNKNOWN
            DispatchStr : SAFEARR_DISPATCH
            VariantStr : SAFEARR_VARIANT
            RecordStr : SAFEARR_BRECORD
            HaveIidStr : SAFEARR_HAVEIID
            ByteStr : BYTE_SIZEDARR
            WordStr : WORD_SIZEDARR
            LongStr : DWORD_SIZEDARR
            HyperStr : HYPER_SIZEDARR
        }
    }
}
struct wireSAFEARRAY {
    cDims : UInt16
    fFeatures : UInt16
    cbElements : UInt32
    cLocks : UInt32
    uArrayStructs : SAFEARRAYUNION
    rgsabound : SAFEARRAYBOUND[1]
}
struct wireBRECORD {
    fFlags : UInt32
    clSize : UInt32
    pRecInfo : IRecordInfo
    pRecord : UInt8.Ptr
}
struct wireVARIANT {
    clSize : UInt32
    rpcReserved : UInt32
    vt : UInt16
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
            scode : Int32
            cyVal : CY
            date : Float64
            bstrVal : FLAGGED_WORD_BLOB.Ptr
            punkVal : IUnknown
            pdispVal : IDispatch
            parray : wireSAFEARRAY.Ptr.Ptr
            brecVal : wireBRECORD.Ptr
            pbVal : UInt8.Ptr
            piVal : Int16.Ptr
            plVal : Int32.Ptr
            pllVal : Int64.Ptr
            pfltVal : Float32.Ptr
            pdblVal : Float64.Ptr
            pboolVal : VARIANT_BOOL.Ptr
            pscode : Int32.Ptr
            pcyVal : CY.Ptr
            pdate : Float64.Ptr
            pbstrVal : FLAGGED_WORD_BLOB.Ptr.Ptr
            ppunkVal : IUnknown.Ptr
            ppdispVal : IDispatch.Ptr
            pparray : wireSAFEARRAY.Ptr.Ptr.Ptr
            pvarVal : wireVARIANT.Ptr.Ptr
            cVal : CHAR
            uiVal : UInt16
            ulVal : UInt32
            ullVal : Int64
            intVal : Int32
            uintVal : UInt32
            decVal : DECIMAL
            pdecVal : DECIMAL.Ptr
            pcVal : PSTR
            puiVal : UInt16.Ptr
            pulVal : UInt32.Ptr
            pullVal : Int64.Ptr
            pintVal : Int32.Ptr
            puintVal : UInt32.Ptr
        }
    }
}
struct ARRAYDESC {
    tdescElem : TYPEDESC
    cDims : UInt16
    rgbounds : SAFEARRAYBOUND[1]
}
struct PARAMDESCEX {
    cBytes : UInt32
    varDefaultValue : VARIANT
}
struct PARAMDESC {
    pparamdescex : PARAMDESCEX.Ptr
    wParamFlags : PARAMFLAGS
}
struct TYPEFLAGS extends Int32 {
    static TYPEFLAG_FAPPOBJECT := 1
    static TYPEFLAG_FCANCREATE := 2
    static TYPEFLAG_FLICENSED := 4
    static TYPEFLAG_FPREDECLID := 8
    static TYPEFLAG_FHIDDEN := 16
    static TYPEFLAG_FCONTROL := 32
    static TYPEFLAG_FDUAL := 64
    static TYPEFLAG_FNONEXTENSIBLE := 128
    static TYPEFLAG_FOLEAUTOMATION := 256
    static TYPEFLAG_FRESTRICTED := 512
    static TYPEFLAG_FAGGREGATABLE := 1024
    static TYPEFLAG_FREPLACEABLE := 2048
    static TYPEFLAG_FDISPATCHABLE := 4096
    static TYPEFLAG_FREVERSEBIND := 8192
    static TYPEFLAG_FPROXY := 16384
}
struct CLEANLOCALSTORAGE {
    pInterface : IUnknown
    pStorage : Struct.Ptr
    flags : UInt32
}
struct ICreateTypeInfo extends IUnknown {
    static IID := "{00020405-0000-0000-C000-000000000046}"
    SetGuid(guid)
      => ComCall(3, this.p, GUID.Ptr, guid)
    SetTypeFlags(uTypeFlags)
      => ComCall(4, this.p, UInt32, uTypeFlags)
    SetDocString(pStrDoc)
      => ComCall(5, this.p, "Str", pStrDoc)
    SetHelpContext(dwHelpContext)
      => ComCall(6, this.p, UInt32, dwHelpContext)
    SetVersion(wMajorVerNum, wMinorVerNum)
      => ComCall(7, this.p, UInt16, wMajorVerNum, UInt16, wMinorVerNum)
    AddRefTypeInfo(pTInfo, phRefType)
      => ComCall(8, this.p, ITypeInfo, pTInfo, UInt32.Ptr, phRefType)
    AddFuncDesc(index, pFuncDesc)
      => ComCall(9, this.p, UInt32, index, FUNCDESC.Ptr, pFuncDesc)
    AddImplType(index, hRefType)
      => ComCall(10, this.p, UInt32, index, UInt32, hRefType)
    SetImplTypeFlags(index, implTypeFlags1)
      => ComCall(11, this.p, UInt32, index, IMPLTYPEFLAGS, implTypeFlags1)
    SetAlignment(cbAlignment)
      => ComCall(12, this.p, UInt16, cbAlignment)
    SetSchema(pStrSchema)
      => ComCall(13, this.p, "Str", pStrSchema)
    AddVarDesc(index, pVarDesc)
      => ComCall(14, this.p, UInt32, index, VARDESC.Ptr, pVarDesc)
    SetFuncAndParamNames(index, rgszNames)
      => ComCall(15, this.p, UInt32, index, PWSTR.Ptr, rgszNames, UInt32, rgszNames.Length)
    SetVarName(index, szName)
      => ComCall(16, this.p, UInt32, index, "Str", szName)
    SetTypeDescAlias(pTDescAlias)
      => ComCall(17, this.p, TYPEDESC.Ptr, pTDescAlias)
    DefineFuncAsDllEntry(index, szDllName, szProcName)
      => ComCall(18, this.p, UInt32, index, "Str", szDllName, "Str", szProcName)
    SetFuncDocString(index, szDocString)
      => ComCall(19, this.p, UInt32, index, "Str", szDocString)
    SetVarDocString(index, szDocString)
      => ComCall(20, this.p, UInt32, index, "Str", szDocString)
    SetFuncHelpContext(index, dwHelpContext)
      => ComCall(21, this.p, UInt32, index, UInt32, dwHelpContext)
    SetVarHelpContext(index, dwHelpContext)
      => ComCall(22, this.p, UInt32, index, UInt32, dwHelpContext)
    SetMops(index, bstrMops)
      => ComCall(23, this.p, UInt32, index, BSTR, bstrMops)
    SetTypeIdldesc(pIdlDesc)
      => ComCall(24, this.p, IDLDESC.Ptr, pIdlDesc)
    LayOut()
      => ComCall(25, this.p)
}
struct ICreateTypeInfo2 extends ICreateTypeInfo {
    static IID := "{0002040E-0000-0000-C000-000000000046}"
    DeleteFuncDesc(index)
      => ComCall(26, this.p, UInt32, index)
    DeleteFuncDescByMemId(memid, invKind)
      => ComCall(27, this.p, Int32, memid, INVOKEKIND, invKind)
    DeleteVarDesc(index)
      => ComCall(28, this.p, UInt32, index)
    DeleteVarDescByMemId(memid)
      => ComCall(29, this.p, Int32, memid)
    DeleteImplType(index)
      => ComCall(30, this.p, UInt32, index)
    SetCustData(guid, pVarVal)
      => ComCall(31, this.p, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetFuncCustData(index, guid, pVarVal)
      => ComCall(32, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetParamCustData(indexFunc, indexParam, guid, pVarVal)
      => ComCall(33, this.p, UInt32, indexFunc, UInt32, indexParam, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetVarCustData(index, guid, pVarVal)
      => ComCall(34, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetImplTypeCustData(index, guid, pVarVal)
      => ComCall(35, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetHelpStringContext(dwHelpStringContext)
      => ComCall(36, this.p, UInt32, dwHelpStringContext)
    SetFuncHelpStringContext(index, dwHelpStringContext)
      => ComCall(37, this.p, UInt32, index, UInt32, dwHelpStringContext)
    SetVarHelpStringContext(index, dwHelpStringContext)
      => ComCall(38, this.p, UInt32, index, UInt32, dwHelpStringContext)
    Invalidate()
      => ComCall(39, this.p)
    SetName(szName)
      => ComCall(40, this.p, "Str", szName)
}
struct ICreateTypeLib extends IUnknown {
    static IID := "{00020406-0000-0000-C000-000000000046}"
    CreateTypeInfo(szName, tkind, ppCTInfo)
      => ComCall(3, this.p, "Str", szName, TYPEKIND, tkind, ICreateTypeInfo.Ptr, ppCTInfo)
    SetName(szName)
      => ComCall(4, this.p, "Str", szName)
    SetVersion(wMajorVerNum, wMinorVerNum)
      => ComCall(5, this.p, UInt16, wMajorVerNum, UInt16, wMinorVerNum)
    SetGuid(guid)
      => ComCall(6, this.p, GUID.Ptr, guid)
    SetDocString(szDoc)
      => ComCall(7, this.p, "Str", szDoc)
    SetHelpFileName(szHelpFileName)
      => ComCall(8, this.p, "Str", szHelpFileName)
    SetHelpContext(dwHelpContext)
      => ComCall(9, this.p, UInt32, dwHelpContext)
    SetLcid(lcid)
      => ComCall(10, this.p, UInt32, lcid)
    SetLibFlags(uLibFlags)
      => ComCall(11, this.p, UInt32, uLibFlags)
    SaveAllChanges()
      => ComCall(12, this.p)
}
struct ICreateTypeLib2 extends ICreateTypeLib {
    static IID := "{0002040F-0000-0000-C000-000000000046}"
    DeleteTypeInfo(szName)
      => ComCall(13, this.p, "Str", szName)
    SetCustData(guid, pVarVal)
      => ComCall(14, this.p, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    SetHelpStringContext(dwHelpStringContext)
      => ComCall(15, this.p, UInt32, dwHelpStringContext)
    SetHelpStringDll(szFileName)
      => ComCall(16, this.p, "Str", szFileName)
}
struct IEnumVARIANT extends IUnknown {
    static IID := "{00020404-0000-0000-C000-000000000046}"
    Next(rgVar, pCeltFetched)
      => ComCall(3, this.p, UInt32, rgVar.Length, VARIANT.Ptr, rgVar, UInt32.Ptr, pCeltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumVARIANT.Ptr, ppEnum)
}
struct LIBFLAGS extends Int32 {
    static LIBFLAG_FRESTRICTED := 1
    static LIBFLAG_FCONTROL := 2
    static LIBFLAG_FHIDDEN := 4
    static LIBFLAG_FHASDISKIMAGE := 8
}
struct CHANGEKIND extends Int32 {
    static CHANGEKIND_ADDMEMBER := 0
    static CHANGEKIND_DELETEMEMBER := 1
    static CHANGEKIND_SETNAMES := 2
    static CHANGEKIND_SETDOCUMENTATION := 3
    static CHANGEKIND_GENERAL := 4
    static CHANGEKIND_INVALIDATE := 5
    static CHANGEKIND_CHANGEFAILED := 6
    static CHANGEKIND_MAX := 7
}
struct ITypeChangeEvents extends IUnknown {
    static IID := "{00020410-0000-0000-C000-000000000046}"
    RequestTypeChange(changeKind1, pTInfoBefore, pStrName, pfCancel)
      => ComCall(3, this.p, CHANGEKIND, changeKind1, ITypeInfo, pTInfoBefore, "Str", pStrName, Int32.Ptr, pfCancel)
    AfterTypeChange(changeKind1, pTInfoAfter, pStrName)
      => ComCall(4, this.p, CHANGEKIND, changeKind1, ITypeInfo, pTInfoAfter, "Str", pStrName)
}
struct ICreateErrorInfo extends IUnknown {
    static IID := "{22F03340-547D-101B-8E65-08002B2BD119}"
    SetGUID(rguid)
      => ComCall(3, this.p, GUID.Ptr, rguid)
    SetSource(szSource)
      => ComCall(4, this.p, "Str", szSource)
    SetDescription(szDescription)
      => ComCall(5, this.p, "Str", szDescription)
    SetHelpFile(szHelpFile)
      => ComCall(6, this.p, "Str", szHelpFile)
    SetHelpContext(dwHelpContext)
      => ComCall(7, this.p, UInt32, dwHelpContext)
}
struct ITypeFactory extends IUnknown {
    static IID := "{0000002E-0000-0000-C000-000000000046}"
    CreateFromTypeInfo(pTypeInfo, riid, ppv)
      => ComCall(3, this.p, ITypeInfo, pTypeInfo, GUID.Ptr, riid, IUnknown.Ptr, ppv)
}
struct ITypeMarshal extends IUnknown {
    static IID := "{0000002D-0000-0000-C000-000000000046}"
    Size(pvType, dwDestContext, pvDestContext, pSize)
      => ComCall(3, this.p, Struct.Ptr, pvType, UInt32, dwDestContext, Struct.Ptr, pvDestContext, UInt32.Ptr, pSize)
    Marshal(pvType, dwDestContext, pvDestContext, pBuffer, pcbWritten)
      => ComCall(4, this.p, Struct.Ptr, pvType, UInt32, dwDestContext, Struct.Ptr, pvDestContext, UInt32, pBuffer.Size, UInt8.Ptr, pBuffer, UInt32.Ptr, pcbWritten)
    Unmarshal(pvType, dwFlags, pBuffer, pcbRead)
      => ComCall(5, this.p, Struct.Ptr, pvType, UInt32, dwFlags, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer, UInt32.Ptr, pcbRead)
    Free(pvType)
      => ComCall(6, this.p, Struct.Ptr, pvType)
}
struct IRecordInfo extends IUnknown {
    static IID := "{0000002F-0000-0000-C000-000000000046}"
    RecordInit(pvNew)
      => ComCall(3, this.p, Struct.Ptr, pvNew)
    RecordClear(pvExisting)
      => ComCall(4, this.p, Struct.Ptr, pvExisting)
    RecordCopy(pvExisting, pvNew)
      => ComCall(5, this.p, Struct.Ptr, pvExisting, Struct.Ptr, pvNew)
    GetGuid(pguid)
      => ComCall(6, this.p, GUID.Ptr, pguid)
    GetName(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    GetSize(pcbSize)
      => ComCall(8, this.p, UInt32.Ptr, pcbSize)
    GetTypeInfo(ppTypeInfo)
      => ComCall(9, this.p, ITypeInfo.Ptr, ppTypeInfo)
    GetField(pvData, szFieldName, pvarField)
      => ComCall(10, this.p, Struct.Ptr, pvData, "Str", szFieldName, VARIANT.Ptr, pvarField)
    GetFieldNoCopy(pvData, szFieldName, pvarField, ppvDataCArray)
      => ComCall(11, this.p, Struct.Ptr, pvData, "Str", szFieldName, VARIANT.Ptr, pvarField, Struct.Ptr.Ptr, ppvDataCArray)
    PutField(wFlags, pvData, szFieldName, pvarField)
      => ComCall(12, this.p, UInt32, wFlags, Struct.Ptr, pvData, "Str", szFieldName, VARIANT.Ptr, pvarField)
    PutFieldNoCopy(wFlags, pvData, szFieldName, pvarField)
      => ComCall(13, this.p, UInt32, wFlags, Struct.Ptr, pvData, "Str", szFieldName, VARIANT.Ptr, pvarField)
    GetFieldNames(rgBstrNames)
      => ComCall(14, this.p, UInt32.Ptr, rgBstrNames.Length, BSTR.Ptr, rgBstrNames)
    IsMatchingType(pRecordInfo)
      => ComCall(15, this.p, IRecordInfo, pRecordInfo, BOOL)
    RecordCreate()
      => ComCall(16, this.p, Struct.Ptr)
    RecordCreateCopy(pvSource, ppvDest)
      => ComCall(17, this.p, Struct.Ptr, pvSource, Struct.Ptr.Ptr, ppvDest)
    RecordDestroy(pvRecord)
      => ComCall(18, this.p, Struct.Ptr, pvRecord)
}
struct IOleAdviseHolder extends IUnknown {
    static IID := "{00000111-0000-0000-C000-000000000046}"
    Advise(pAdvise, pdwConnection)
      => ComCall(3, this.p, IAdviseSink, pAdvise, UInt32.Ptr, pdwConnection)
    Unadvise(dwConnection)
      => ComCall(4, this.p, UInt32, dwConnection)
    EnumAdvise(ppenumAdvise)
      => ComCall(5, this.p, IEnumSTATDATA.Ptr, ppenumAdvise)
    SendOnRename(pmk)
      => ComCall(6, this.p, IMoniker, pmk)
    SendOnSave()
      => ComCall(7, this.p)
    SendOnClose()
      => ComCall(8, this.p)
}
struct IOleCache extends IUnknown {
    static IID := "{0000011E-0000-0000-C000-000000000046}"
    Cache(pformatetc, advf, pdwConnection)
      => ComCall(3, this.p, FORMATETC.Ptr, pformatetc, UInt32, advf, UInt32.Ptr, pdwConnection)
    Uncache(dwConnection)
      => ComCall(4, this.p, UInt32, dwConnection)
    EnumCache(ppenumSTATDATA)
      => ComCall(5, this.p, IEnumSTATDATA.Ptr, ppenumSTATDATA)
    InitCache(pDataObject)
      => ComCall(6, this.p, IDataObject, pDataObject)
    SetData(pformatetc, pmedium, fRelease)
      => ComCall(7, this.p, FORMATETC.Ptr, pformatetc, STGMEDIUM.Ptr, pmedium, BOOL, fRelease)
}
struct DISCARDCACHE extends Int32 {
    static DISCARDCACHE_SAVEIFDIRTY := 0
    static DISCARDCACHE_NOSAVE := 1
}
struct IOleCache2 extends IOleCache {
    static IID := "{00000128-0000-0000-C000-000000000046}"
    UpdateCache(pDataObject, grfUpdf)
      => ComCall(8, this.p, IDataObject, pDataObject, UPDFCACHE_FLAGS, grfUpdf, "Ptr", 0)
    DiscardCache(dwDiscardOptions)
      => ComCall(9, this.p, UInt32, dwDiscardOptions)
}
struct IOleCacheControl extends IUnknown {
    static IID := "{00000129-0000-0000-C000-000000000046}"
    OnRun(pDataObject?)
      => ComCall(3, this.p, IDataObject, pDataObject?)
    OnStop()
      => ComCall(4, this.p)
}
struct IParseDisplayName extends IUnknown {
    static IID := "{0000011A-0000-0000-C000-000000000046}"
    ParseDisplayName(pbc, pszDisplayName, pchEaten, ppmkOut)
      => ComCall(3, this.p, IBindCtx, pbc, "Str", pszDisplayName, UInt32.Ptr, pchEaten, IMoniker.Ptr, ppmkOut)
}
struct IOleContainer extends IParseDisplayName {
    static IID := "{0000011B-0000-0000-C000-000000000046}"
    EnumObjects(grfFlags, ppenum)
      => ComCall(4, this.p, UInt32, grfFlags, IEnumUnknown.Ptr, ppenum)
    LockContainer(fLock)
      => ComCall(5, this.p, BOOL, fLock)
}
struct IOleClientSite extends IUnknown {
    static IID := "{00000118-0000-0000-C000-000000000046}"
    SaveObject()
      => ComCall(3, this.p)
    GetMoniker(dwAssign, dwWhichMoniker, ppmk)
      => ComCall(4, this.p, UInt32, dwAssign, UInt32, dwWhichMoniker, IMoniker.Ptr, ppmk)
    GetContainer(ppContainer)
      => ComCall(5, this.p, IOleContainer.Ptr, ppContainer)
    ShowObject()
      => ComCall(6, this.p)
    OnShowWindow(fShow)
      => ComCall(7, this.p, BOOL, fShow)
    RequestNewObjectLayout()
      => ComCall(8, this.p)
}
struct OLEGETMONIKER extends Int32 {
    static OLEGETMONIKER_ONLYIFTHERE := 1
    static OLEGETMONIKER_FORCEASSIGN := 2
    static OLEGETMONIKER_UNASSIGN := 3
    static OLEGETMONIKER_TEMPFORUSER := 4
}
struct OLEWHICHMK extends Int32 {
    static OLEWHICHMK_CONTAINER := 1
    static OLEWHICHMK_OBJREL := 2
    static OLEWHICHMK_OBJFULL := 3
}
struct USERCLASSTYPE extends Int32 {
    static USERCLASSTYPE_FULL := 1
    static USERCLASSTYPE_SHORT := 2
    static USERCLASSTYPE_APPNAME := 3
}
struct OLEMISC extends Int32 {
    static OLEMISC_RECOMPOSEONRESIZE := 1
    static OLEMISC_ONLYICONIC := 2
    static OLEMISC_INSERTNOTREPLACE := 4
    static OLEMISC_STATIC := 8
    static OLEMISC_CANTLINKINSIDE := 16
    static OLEMISC_CANLINKBYOLE1 := 32
    static OLEMISC_ISLINKOBJECT := 64
    static OLEMISC_INSIDEOUT := 128
    static OLEMISC_ACTIVATEWHENVISIBLE := 256
    static OLEMISC_RENDERINGISDEVICEINDEPENDENT := 512
    static OLEMISC_INVISIBLEATRUNTIME := 1024
    static OLEMISC_ALWAYSRUN := 2048
    static OLEMISC_ACTSLIKEBUTTON := 4096
    static OLEMISC_ACTSLIKELABEL := 8192
    static OLEMISC_NOUIACTIVATE := 16384
    static OLEMISC_ALIGNABLE := 32768
    static OLEMISC_SIMPLEFRAME := 65536
    static OLEMISC_SETCLIENTSITEFIRST := 131072
    static OLEMISC_IMEMODE := 262144
    static OLEMISC_IGNOREACTIVATEWHENVISIBLE := 524288
    static OLEMISC_WANTSTOMENUMERGE := 1048576
    static OLEMISC_SUPPORTSMULTILEVELUNDO := 2097152
}
struct OLECLOSE extends Int32 {
    static OLECLOSE_SAVEIFDIRTY := 0
    static OLECLOSE_NOSAVE := 1
    static OLECLOSE_PROMPTSAVE := 2
}
struct IOleObject extends IUnknown {
    static IID := "{00000112-0000-0000-C000-000000000046}"
    SetClientSite(pClientSite)
      => ComCall(3, this.p, IOleClientSite, pClientSite)
    GetClientSite(ppClientSite)
      => ComCall(4, this.p, IOleClientSite.Ptr, ppClientSite)
    SetHostNames(szContainerApp, szContainerObj)
      => ComCall(5, this.p, "Str", szContainerApp, "Str", szContainerObj)
    Close(dwSaveOption)
      => ComCall(6, this.p, UInt32, dwSaveOption)
    SetMoniker(dwWhichMoniker, pmk)
      => ComCall(7, this.p, UInt32, dwWhichMoniker, IMoniker, pmk)
    GetMoniker(dwAssign, dwWhichMoniker, ppmk)
      => ComCall(8, this.p, UInt32, dwAssign, UInt32, dwWhichMoniker, IMoniker.Ptr, ppmk)
    InitFromData(pDataObject, fCreation, dwReserved)
      => ComCall(9, this.p, IDataObject, pDataObject, BOOL, fCreation, UInt32, dwReserved)
    GetClipboardData(dwReserved, ppDataObject)
      => ComCall(10, this.p, UInt32, dwReserved, IDataObject.Ptr, ppDataObject)
    DoVerb(iVerb, lpmsg, pActiveSite, lindex, hwndParent, lprcPosRect)
      => ComCall(11, this.p, Int32, iVerb, MSG.Ptr, lpmsg, IOleClientSite, pActiveSite, Int32, lindex, HWND, hwndParent, RECT.Ptr, lprcPosRect)
    EnumVerbs(ppEnumOleVerb)
      => ComCall(12, this.p, IEnumOLEVERB.Ptr, ppEnumOleVerb)
    Update()
      => ComCall(13, this.p)
    IsUpToDate()
      => ComCall(14, this.p)
    GetUserClassID(pClsid)
      => ComCall(15, this.p, GUID.Ptr, pClsid)
    GetUserType(dwFormOfType, pszUserType)
      => ComCall(16, this.p, UInt32, dwFormOfType, PWSTR.Ptr, pszUserType)
    SetExtent(dwDrawAspect, psizel)
      => ComCall(17, this.p, DVASPECT, dwDrawAspect, SIZE.Ptr, psizel)
    GetExtent(dwDrawAspect, psizel)
      => ComCall(18, this.p, DVASPECT, dwDrawAspect, SIZE.Ptr, psizel)
    Advise(pAdvSink, pdwConnection)
      => ComCall(19, this.p, IAdviseSink, pAdvSink, UInt32.Ptr, pdwConnection)
    Unadvise(dwConnection)
      => ComCall(20, this.p, UInt32, dwConnection)
    EnumAdvise(ppenumAdvise)
      => ComCall(21, this.p, IEnumSTATDATA.Ptr, ppenumAdvise)
    GetMiscStatus(dwAspect, pdwStatus)
      => ComCall(22, this.p, DVASPECT, dwAspect, OLEMISC.Ptr, pdwStatus)
    SetColorScheme(pLogpal)
      => ComCall(23, this.p, LOGPALETTE.Ptr, pLogpal)
}
struct OLERENDER extends Int32 {
    static OLERENDER_NONE := 0
    static OLERENDER_DRAW := 1
    static OLERENDER_FORMAT := 2
    static OLERENDER_ASIS := 3
}
struct OBJECTDESCRIPTOR {
    cbSize : UInt32 := this.Size
    clsid : GUID
    dwDrawAspect : UInt32
    sizel : SIZE
    pointl : POINTL
    dwStatus : UInt32
    dwFullUserTypeName : UInt32
    dwSrcOfCopy : UInt32
}
struct IOleWindow extends IUnknown {
    static IID := "{00000114-0000-0000-C000-000000000046}"
    GetWindow(phwnd)
      => ComCall(3, this.p, HWND.Ptr, phwnd)
    ContextSensitiveHelp(fEnterMode)
      => ComCall(4, this.p, BOOL, fEnterMode)
}
struct OLEUPDATE extends Int32 {
    static OLEUPDATE_ALWAYS := 1
    static OLEUPDATE_ONCALL := 3
}
struct OLELINKBIND extends Int32 {
    static OLELINKBIND_EVENIFCLASSDIFF := 1
}
struct IOleLink extends IUnknown {
    static IID := "{0000011D-0000-0000-C000-000000000046}"
    SetUpdateOptions(dwUpdateOpt)
      => ComCall(3, this.p, UInt32, dwUpdateOpt)
    GetUpdateOptions(pdwUpdateOpt)
      => ComCall(4, this.p, UInt32.Ptr, pdwUpdateOpt)
    SetSourceMoniker(pmk, rclsid)
      => ComCall(5, this.p, IMoniker, pmk, GUID.Ptr, rclsid)
    GetSourceMoniker(ppmk)
      => ComCall(6, this.p, IMoniker.Ptr, ppmk)
    SetSourceDisplayName(pszStatusText)
      => ComCall(7, this.p, "Str", pszStatusText)
    GetSourceDisplayName(ppszDisplayName)
      => ComCall(8, this.p, PWSTR.Ptr, ppszDisplayName)
    BindToSource(bindflags, pbc)
      => ComCall(9, this.p, UInt32, bindflags, IBindCtx, pbc)
    BindIfRunning()
      => ComCall(10, this.p)
    GetBoundSource(ppunk)
      => ComCall(11, this.p, IUnknown.Ptr, ppunk)
    UnbindSource()
      => ComCall(12, this.p)
    Update(pbc)
      => ComCall(13, this.p, IBindCtx, pbc)
}
struct BINDSPEED extends Int32 {
    static BINDSPEED_INDEFINITE := 1
    static BINDSPEED_MODERATE := 2
    static BINDSPEED_IMMEDIATE := 3
}
struct OLECONTF extends Int32 {
    static OLECONTF_EMBEDDINGS := 1
    static OLECONTF_LINKS := 2
    static OLECONTF_OTHERS := 4
    static OLECONTF_ONLYUSER := 8
    static OLECONTF_ONLYIFRUNNING := 16
}
struct IOleItemContainer extends IOleContainer {
    static IID := "{0000011C-0000-0000-C000-000000000046}"
    GetObject(pszItem, dwSpeedNeeded, pbc, riid, ppvObject)
      => ComCall(6, this.p, "Str", pszItem, UInt32, dwSpeedNeeded, IBindCtx, pbc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetObjectStorage(pszItem, pbc, riid, ppvStorage)
      => ComCall(7, this.p, "Str", pszItem, IBindCtx, pbc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvStorage)
    IsRunning(pszItem)
      => ComCall(8, this.p, "Str", pszItem)
}
struct IOleInPlaceUIWindow extends IOleWindow {
    static IID := "{00000115-0000-0000-C000-000000000046}"
    GetBorder(lprectBorder)
      => ComCall(5, this.p, RECT.Ptr, lprectBorder)
    RequestBorderSpace(pborderwidths)
      => ComCall(6, this.p, RECT.Ptr, pborderwidths)
    SetBorderSpace(pborderwidths)
      => ComCall(7, this.p, RECT.Ptr, pborderwidths)
    SetActiveObject(pActiveObject, pszObjName)
      => ComCall(8, this.p, IOleInPlaceActiveObject, pActiveObject, "Str", pszObjName)
}
struct IOleInPlaceActiveObject extends IOleWindow {
    static IID := "{00000117-0000-0000-C000-000000000046}"
    TranslateAccelerator(lpmsg?)
      => ComCall(5, this.p, MSG.Ptr, lpmsg?)
    OnFrameWindowActivate(fActivate)
      => ComCall(6, this.p, BOOL, fActivate)
    OnDocWindowActivate(fActivate)
      => ComCall(7, this.p, BOOL, fActivate)
    ResizeBorder(prcBorder, pUIWindow, fFrameWindow)
      => ComCall(8, this.p, RECT.Ptr, prcBorder, IOleInPlaceUIWindow, pUIWindow, BOOL, fFrameWindow)
    EnableModeless(fEnable)
      => ComCall(9, this.p, BOOL, fEnable)
}
struct OLEINPLACEFRAMEINFO {
    cb : UInt32
    fMDIApp : BOOL
    hwndFrame : HWND
    haccel : HACCEL
    cAccelEntries : UInt32
}
struct OLEMENUGROUPWIDTHS {
    width : Int32[6]
}
struct IOleInPlaceFrame extends IOleInPlaceUIWindow {
    static IID := "{00000116-0000-0000-C000-000000000046}"
    InsertMenus(hmenuShared, lpMenuWidths)
      => ComCall(9, this.p, HMENU, hmenuShared, OLEMENUGROUPWIDTHS.Ptr, lpMenuWidths)
    SetMenu(hmenuShared, holemenu, hwndActiveObject)
      => ComCall(10, this.p, HMENU, hmenuShared, IntPtr, holemenu, HWND, hwndActiveObject)
    RemoveMenus(hmenuShared)
      => ComCall(11, this.p, HMENU, hmenuShared)
    SetStatusText(pszStatusText)
      => ComCall(12, this.p, "Str", pszStatusText)
    EnableModeless(fEnable)
      => ComCall(13, this.p, BOOL, fEnable)
    TranslateAccelerator(lpmsg, wID)
      => ComCall(14, this.p, MSG.Ptr, lpmsg, UInt16, wID)
}
struct IOleInPlaceObject extends IOleWindow {
    static IID := "{00000113-0000-0000-C000-000000000046}"
    InPlaceDeactivate()
      => ComCall(5, this.p)
    UIDeactivate()
      => ComCall(6, this.p)
    SetObjectRects(lprcPosRect, lprcClipRect)
      => ComCall(7, this.p, RECT.Ptr, lprcPosRect, RECT.Ptr, lprcClipRect)
    ReactivateAndUndo()
      => ComCall(8, this.p)
}
struct IOleInPlaceSite extends IOleWindow {
    static IID := "{00000119-0000-0000-C000-000000000046}"
    CanInPlaceActivate()
      => ComCall(5, this.p)
    OnInPlaceActivate()
      => ComCall(6, this.p)
    OnUIActivate()
      => ComCall(7, this.p)
    GetWindowContext(ppFrame, ppDoc, lprcPosRect, lprcClipRect, lpFrameInfo)
      => ComCall(8, this.p, IOleInPlaceFrame.Ptr, ppFrame, IOleInPlaceUIWindow.Ptr, ppDoc, RECT.Ptr, lprcPosRect, RECT.Ptr, lprcClipRect, OLEINPLACEFRAMEINFO.Ptr, lpFrameInfo)
    Scroll(scrollExtant)
      => ComCall(9, this.p, SIZE, scrollExtant)
    OnUIDeactivate(fUndoable)
      => ComCall(10, this.p, BOOL, fUndoable)
    OnInPlaceDeactivate()
      => ComCall(11, this.p)
    DiscardUndoState()
      => ComCall(12, this.p)
    DeactivateAndUndo()
      => ComCall(13, this.p)
    OnPosRectChange(lprcPosRect)
      => ComCall(14, this.p, RECT.Ptr, lprcPosRect)
}
struct IContinue extends IUnknown {
    static IID := "{0000012A-0000-0000-C000-000000000046}"
    FContinue()
      => ComCall(3, this.p)
}
struct IViewObject extends IUnknown {
    static IID := "{0000010D-0000-0000-C000-000000000046}"
    Draw(dwDrawAspect, lindex, pvAspect, ptd?, hdcTargetDev?, hdcDraw, lprcBounds?, lprcWBounds?, pfnContinue?, dwContinue)
      => ComCall(3, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, DVTARGETDEVICE.Ptr, ptd?, HDC, hdcTargetDev?, HDC, hdcDraw, RECTL.Ptr, lprcBounds?, RECTL.Ptr, lprcWBounds?, IntPtr, pfnContinue?, IntPtr, dwContinue)
    GetColorSet(dwDrawAspect, lindex, pvAspect, ptd?, hicTargetDev?, ppColorSet)
      => ComCall(4, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, DVTARGETDEVICE.Ptr, ptd?, HDC, hicTargetDev?, LOGPALETTE.Ptr.Ptr, ppColorSet)
    Freeze(dwDrawAspect, lindex, pvAspect, pdwFreeze)
      => ComCall(5, this.p, DVASPECT, dwDrawAspect, Int32, lindex, Struct.Ptr, pvAspect, UInt32.Ptr, pdwFreeze)
    Unfreeze(dwFreeze)
      => ComCall(6, this.p, UInt32, dwFreeze)
    SetAdvise(aspects, advf, pAdvSink)
      => ComCall(7, this.p, DVASPECT, aspects, UInt32, advf, IAdviseSink, pAdvSink)
    GetAdvise(pAspects?, pAdvf?, ppAdvSink)
      => ComCall(8, this.p, UInt32.Ptr, pAspects?, UInt32.Ptr, pAdvf?, IAdviseSink.Ptr, ppAdvSink)
}
struct IViewObject2 extends IViewObject {
    static IID := "{00000127-0000-0000-C000-000000000046}"
    GetExtent(dwDrawAspect, lindex, ptd, lpsizel)
      => ComCall(9, this.p, DVASPECT, dwDrawAspect, Int32, lindex, DVTARGETDEVICE.Ptr, ptd, SIZE.Ptr, lpsizel)
}
struct IDropSource extends IUnknown {
    static IID := "{00000121-0000-0000-C000-000000000046}"
    QueryContinueDrag(fEscapePressed, grfKeyState)
      => ComCall(3, this.p, BOOL, fEscapePressed, MODIFIERKEYS_FLAGS, grfKeyState)
    GiveFeedback(dwEffect)
      => ComCall(4, this.p, DROPEFFECT, dwEffect)
}
struct IDropTarget extends IUnknown {
    static IID := "{00000122-0000-0000-C000-000000000046}"
    DragEnter(pDataObj, grfKeyState, pt, pdwEffect)
      => ComCall(3, this.p, IDataObject, pDataObj, MODIFIERKEYS_FLAGS, grfKeyState, POINTL, pt, DROPEFFECT.Ptr, pdwEffect)
    DragOver(grfKeyState, pt, pdwEffect)
      => ComCall(4, this.p, MODIFIERKEYS_FLAGS, grfKeyState, POINTL, pt, DROPEFFECT.Ptr, pdwEffect)
    DragLeave()
      => ComCall(5, this.p)
    Drop(pDataObj, grfKeyState, pt, pdwEffect)
      => ComCall(6, this.p, IDataObject, pDataObj, MODIFIERKEYS_FLAGS, grfKeyState, POINTL, pt, DROPEFFECT.Ptr, pdwEffect)
}
struct IDropSourceNotify extends IUnknown {
    static IID := "{0000012B-0000-0000-C000-000000000046}"
    DragEnterTarget(hwndTarget)
      => ComCall(3, this.p, HWND, hwndTarget)
    DragLeaveTarget()
      => ComCall(4, this.p)
}
struct IEnterpriseDropTarget extends IUnknown {
    static IID := "{390E3878-FD55-4E18-819D-4682081C0CFD}"
    SetDropSourceEnterpriseId(identity)
      => ComCall(3, this.p, "Str", identity)
    IsEvaluatingEdpPolicy(value)
      => ComCall(4, this.p, BOOL.Ptr, value)
}
struct OLEVERB {
    lVerb : OLEIVERB
    lpszVerbName : PWSTR
    fuFlags : MENU_ITEM_FLAGS
    grfAttribs : UInt32
}
struct OLEVERBATTRIB extends Int32 {
    static OLEVERBATTRIB_NEVERDIRTIES := 1
    static OLEVERBATTRIB_ONCONTAINERMENU := 2
}
struct IEnumOLEVERB extends IUnknown {
    static IID := "{00000104-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, OLEVERB.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumOLEVERB.Ptr, ppenum)
}
struct NUMPARSE {
    cDig : Int32
    dwInFlags : NUMPARSE_FLAGS
    dwOutFlags : NUMPARSE_FLAGS
    cchUsed : Int32
    nBaseShift : Int32
    nPwr10 : Int32
}
struct UDATE {
    st : SYSTEMTIME
    wDayOfYear : UInt16
}
struct REGKIND extends Int32 {
    static REGKIND_DEFAULT := 0
    static REGKIND_REGISTER := 1
    static REGKIND_NONE := 2
}
struct PARAMDATA {
    szName : PWSTR
    vt : VARENUM
}
struct METHODDATA {
    szName : PWSTR
    ppdata : PARAMDATA.Ptr
    dispid : Int32
    iMeth : UInt32
    cc : CALLCONV
    cArgs : UInt32
    wFlags : UInt16
    vtReturn : VARENUM
}
struct INTERFACEDATA {
    pmethdata : METHODDATA.Ptr
    cMembers : UInt32
}
struct OLESTREAMQUERYCONVERTOLELINKCALLBACK extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, PWSTR, PWSTR, PWSTR, UInt32, Struct.Ptr, HRESULT]
}
struct UASFLAGS extends Int32 {
    static UAS_NORMAL := 0
    static UAS_BLOCKED := 1
    static UAS_NOPARENTENABLE := 2
    static UAS_MASK := 3
}
struct READYSTATE extends Int32 {
    static READYSTATE_UNINITIALIZED := 0
    static READYSTATE_LOADING := 1
    static READYSTATE_LOADED := 2
    static READYSTATE_INTERACTIVE := 3
    static READYSTATE_COMPLETE := 4
}
struct LICINFO {
    cbLicInfo : Int32
    fRuntimeKeyAvail : BOOL
    fLicVerified : BOOL
}
struct IClassFactory2 extends IClassFactory {
    static IID := "{B196B28F-BAB4-101A-B69C-00AA00341D07}"
    GetLicInfo(pLicInfo)
      => ComCall(5, this.p, LICINFO.Ptr, pLicInfo)
    RequestLicKey(dwReserved, pBstrKey)
      => ComCall(6, this.p, UInt32, dwReserved, BSTR.Ptr, pBstrKey)
    CreateInstanceLic(pUnkOuter?, riid, bstrKey, ppvObj)
      => ComCall(7, this.p, IUnknown, pUnkOuter?, "Ptr", 0, GUID.Ptr, riid, BSTR, bstrKey, Struct.Ptr.Ptr, ppvObj)
}
struct IProvideClassInfo extends IUnknown {
    static IID := "{B196B283-BAB4-101A-B69C-00AA00341D07}"
    GetClassInfo(ppTI)
      => ComCall(3, this.p, ITypeInfo.Ptr, ppTI)
}
struct GUIDKIND extends Int32 {
    static GUIDKIND_DEFAULT_SOURCE_DISP_IID := 1
}
struct IProvideClassInfo2 extends IProvideClassInfo {
    static IID := "{A6BC3AC0-DBAA-11CE-9DE3-00AA004BB851}"
    GetGUID(dwGuidKind, pGUID)
      => ComCall(4, this.p, UInt32, dwGuidKind, GUID.Ptr, pGUID)
}
struct IProvideMultipleClassInfo extends IProvideClassInfo2 {
    static IID := "{A7ABA9C1-8983-11CF-8F20-00805F2CD064}"
    GetMultiTypeInfoCount(pcti)
      => ComCall(5, this.p, UInt32.Ptr, pcti)
    GetInfoOfIndex(iti, dwFlags, pptiCoClass, pdwTIFlags, pcdispidReserved, piidPrimary, piidSource)
      => ComCall(6, this.p, UInt32, iti, MULTICLASSINFO_FLAGS, dwFlags, ITypeInfo.Ptr, pptiCoClass, UInt32.Ptr, pdwTIFlags, UInt32.Ptr, pcdispidReserved, GUID.Ptr, piidPrimary, GUID.Ptr, piidSource)
}
struct CONTROLINFO {
    cb : UInt32
    hAccel : HACCEL
    cAccel : UInt16
    dwFlags : UInt32
}
struct CTRLINFO extends Int32 {
    static CTRLINFO_EATS_RETURN := 1
    static CTRLINFO_EATS_ESCAPE := 2
}
struct IOleControl extends IUnknown {
    static IID := "{B196B288-BAB4-101A-B69C-00AA00341D07}"
    GetControlInfo(pCI)
      => ComCall(3, this.p, CONTROLINFO.Ptr, pCI)
    OnMnemonic(pMsg)
      => ComCall(4, this.p, MSG.Ptr, pMsg)
    OnAmbientPropertyChange(dispID)
      => ComCall(5, this.p, Int32, dispID)
    FreezeEvents(bFreeze)
      => ComCall(6, this.p, BOOL, bFreeze)
}
struct POINTF {
    x : Float32
    y : Float32
}
struct XFORMCOORDS extends Int32 {
    static XFORMCOORDS_POSITION := 1
    static XFORMCOORDS_SIZE := 2
    static XFORMCOORDS_HIMETRICTOCONTAINER := 4
    static XFORMCOORDS_CONTAINERTOHIMETRIC := 8
    static XFORMCOORDS_EVENTCOMPAT := 16
}
struct IOleControlSite extends IUnknown {
    static IID := "{B196B289-BAB4-101A-B69C-00AA00341D07}"
    OnControlInfoChanged()
      => ComCall(3, this.p)
    LockInPlaceActive(fLock)
      => ComCall(4, this.p, BOOL, fLock)
    GetExtendedControl(ppDisp)
      => ComCall(5, this.p, IDispatch.Ptr, ppDisp)
    TransformCoords(pPtlHimetric, pPtfContainer, dwFlags)
      => ComCall(6, this.p, POINTL.Ptr, pPtlHimetric, POINTF.Ptr, pPtfContainer, UInt32, dwFlags)
    TranslateAccelerator(pMsg, grfModifiers)
      => ComCall(7, this.p, MSG.Ptr, pMsg, KEYMODIFIERS, grfModifiers)
    OnFocus(fGotFocus)
      => ComCall(8, this.p, BOOL, fGotFocus)
    ShowPropertyFrame()
      => ComCall(9, this.p)
}
struct PROPPAGEINFO {
    cb : UInt32
    pszTitle : PWSTR
    size : SIZE
    pszDocString : PWSTR
    pszHelpFile : PWSTR
    dwHelpContext : UInt32
}
struct IPropertyPage extends IUnknown {
    static IID := "{B196B28D-BAB4-101A-B69C-00AA00341D07}"
    SetPageSite(pPageSite)
      => ComCall(3, this.p, IPropertyPageSite, pPageSite)
    Activate(hWndParent, pRect, bModal)
      => ComCall(4, this.p, HWND, hWndParent, RECT.Ptr, pRect, BOOL, bModal)
    Deactivate()
      => ComCall(5, this.p)
    GetPageInfo(pPageInfo)
      => ComCall(6, this.p, PROPPAGEINFO.Ptr, pPageInfo)
    SetObjects(ppUnk)
      => ComCall(7, this.p, UInt32, ppUnk.Length, IUnknown.Ptr, ppUnk)
    Show(nCmdShow)
      => ComCall(8, this.p, UInt32, nCmdShow)
    Move(pRect)
      => ComCall(9, this.p, RECT.Ptr, pRect)
    IsPageDirty()
      => ComCall(10, this.p)
    Apply()
      => ComCall(11, this.p)
    Help(pszHelpDir)
      => ComCall(12, this.p, "Str", pszHelpDir)
    TranslateAccelerator(pMsg)
      => ComCall(13, this.p, MSG.Ptr, pMsg)
}
struct IPropertyPage2 extends IPropertyPage {
    static IID := "{01E44665-24AC-101B-84ED-08002B2EC713}"
    EditProperty(dispID)
      => ComCall(14, this.p, Int32, dispID)
}
struct PROPPAGESTATUS extends Int32 {
    static PROPPAGESTATUS_DIRTY := 1
    static PROPPAGESTATUS_VALIDATE := 2
    static PROPPAGESTATUS_CLEAN := 4
}
struct IPropertyPageSite extends IUnknown {
    static IID := "{B196B28C-BAB4-101A-B69C-00AA00341D07}"
    OnStatusChange(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
    GetLocaleID(pLocaleID)
      => ComCall(4, this.p, UInt32.Ptr, pLocaleID)
    GetPageContainer(ppUnk)
      => ComCall(5, this.p, IUnknown.Ptr, ppUnk)
    TranslateAccelerator(pMsg)
      => ComCall(6, this.p, MSG.Ptr, pMsg)
}
struct IPropertyNotifySink extends IUnknown {
    static IID := "{9BFBBC02-EFF1-101A-84ED-00AA00341D07}"
    OnChanged(dispID)
      => ComCall(3, this.p, Int32, dispID)
    OnRequestEdit(dispID)
      => ComCall(4, this.p, Int32, dispID)
}
struct CAUUID {
    cElems : UInt32
    pElems : GUID.Ptr
}
struct ISpecifyPropertyPages extends IUnknown {
    static IID := "{B196B28B-BAB4-101A-B69C-00AA00341D07}"
    GetPages(pPages)
      => ComCall(3, this.p, CAUUID.Ptr, pPages)
}
struct IPersistPropertyBag extends IPersist {
    static IID := "{37D84F60-42CB-11CE-8135-00AA004BB851}"
    InitNew()
      => ComCall(4, this.p)
    Load(pPropBag, pErrorLog)
      => ComCall(5, this.p, IPropertyBag, pPropBag, IErrorLog, pErrorLog)
    Save(pPropBag, fClearDirty, fSaveAllProperties)
      => ComCall(6, this.p, IPropertyBag, pPropBag, BOOL, fClearDirty, BOOL, fSaveAllProperties)
}
struct ISimpleFrameSite extends IUnknown {
    static IID := "{742B0E01-14E6-101B-914E-00AA00300CAB}"
    PreMessageFilter(hWnd1, msg, wp, lp, plResult, pdwCookie)
      => ComCall(3, this.p, HWND, hWnd1, UInt32, msg, WPARAM, wp, LPARAM, lp, LRESULT.Ptr, plResult, UInt32.Ptr, pdwCookie)
    PostMessageFilter(hWnd1, msg, wp, lp, plResult, dwCookie)
      => ComCall(4, this.p, HWND, hWnd1, UInt32, msg, WPARAM, wp, LPARAM, lp, LRESULT.Ptr, plResult, UInt32, dwCookie)
}
struct IFont extends IUnknown {
    static IID := "{BEF6E002-A874-101A-8BBA-00AA00300CAB}"
    get_Name(pName)
      => ComCall(3, this.p, BSTR.Ptr, pName)
    put_Name(name)
      => ComCall(4, this.p, BSTR, name)
    get_Size(pSize)
      => ComCall(5, this.p, CY.Ptr, pSize)
    put_Size(size)
      => ComCall(6, this.p, CY, size)
    get_Bold(pBold)
      => ComCall(7, this.p, BOOL.Ptr, pBold)
    put_Bold(bold)
      => ComCall(8, this.p, BOOL, bold)
    get_Italic(pItalic)
      => ComCall(9, this.p, BOOL.Ptr, pItalic)
    put_Italic(italic)
      => ComCall(10, this.p, BOOL, italic)
    get_Underline(pUnderline)
      => ComCall(11, this.p, BOOL.Ptr, pUnderline)
    put_Underline(underline)
      => ComCall(12, this.p, BOOL, underline)
    get_Strikethrough(pStrikethrough)
      => ComCall(13, this.p, BOOL.Ptr, pStrikethrough)
    put_Strikethrough(strikethrough)
      => ComCall(14, this.p, BOOL, strikethrough)
    get_Weight(pWeight)
      => ComCall(15, this.p, Int16.Ptr, pWeight)
    put_Weight(weight)
      => ComCall(16, this.p, Int16, weight)
    get_Charset(pCharset)
      => ComCall(17, this.p, Int16.Ptr, pCharset)
    put_Charset(charset)
      => ComCall(18, this.p, Int16, charset)
    get_hFont(phFont)
      => ComCall(19, this.p, HFONT.Ptr, phFont)
    Clone(ppFont)
      => ComCall(20, this.p, IFont.Ptr, ppFont)
    IsEqual(pFontOther)
      => ComCall(21, this.p, IFont, pFontOther)
    SetRatio(cyLogical, cyHimetric)
      => ComCall(22, this.p, Int32, cyLogical, Int32, cyHimetric)
    QueryTextMetrics(pTM)
      => ComCall(23, this.p, TEXTMETRICW.Ptr, pTM)
    AddRefHfont(hFont1)
      => ComCall(24, this.p, HFONT, hFont1)
    ReleaseHfont(hFont1)
      => ComCall(25, this.p, HFONT, hFont1)
    SetHdc(hDC1)
      => ComCall(26, this.p, HDC, hDC1)
}
struct PICTUREATTRIBUTES extends Int32 {
    static PICTURE_SCALABLE := 1
    static PICTURE_TRANSPARENT := 2
}
struct IPicture extends IUnknown {
    static IID := "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
    get_Handle(pHandle)
      => ComCall(3, this.p, OLE_HANDLE.Ptr, pHandle)
    get_hPal(phPal)
      => ComCall(4, this.p, OLE_HANDLE.Ptr, phPal)
    get_Type(pType)
      => ComCall(5, this.p, PICTYPE.Ptr, pType)
    get_Width(pWidth)
      => ComCall(6, this.p, Int32.Ptr, pWidth)
    get_Height(pHeight)
      => ComCall(7, this.p, Int32.Ptr, pHeight)
    Render(hDC1, x, y, cx, cy, xSrc, ySrc, cxSrc, cySrc, pRcWBounds)
      => ComCall(8, this.p, HDC, hDC1, Int32, x, Int32, y, Int32, cx, Int32, cy, Int32, xSrc, Int32, ySrc, Int32, cxSrc, Int32, cySrc, RECT.Ptr, pRcWBounds)
    set_hPal(hPal)
      => ComCall(9, this.p, OLE_HANDLE, hPal)
    get_CurDC(phDC)
      => ComCall(10, this.p, HDC.Ptr, phDC)
    SelectPicture(hDCIn, phDCOut, phBmpOut)
      => ComCall(11, this.p, HDC, hDCIn, HDC.Ptr, phDCOut, OLE_HANDLE.Ptr, phBmpOut)
    get_KeepOriginalFormat(pKeep)
      => ComCall(12, this.p, BOOL.Ptr, pKeep)
    put_KeepOriginalFormat(keep)
      => ComCall(13, this.p, BOOL, keep)
    PictureChanged()
      => ComCall(14, this.p)
    SaveAsFile(pStream, fSaveMemCopy, pCbSize)
      => ComCall(15, this.p, IStream, pStream, BOOL, fSaveMemCopy, Int32.Ptr, pCbSize)
    get_Attributes(pDwAttr)
      => ComCall(16, this.p, UInt32.Ptr, pDwAttr)
}
struct IPicture2 extends IUnknown {
    static IID := "{F5185DD8-2012-4B0B-AAD9-F052C6BD482B}"
    get_Handle(pHandle)
      => ComCall(3, this.p, IntPtr.Ptr, pHandle)
    get_hPal(phPal)
      => ComCall(4, this.p, IntPtr.Ptr, phPal)
    get_Type(pType)
      => ComCall(5, this.p, Int16.Ptr, pType)
    get_Width(pWidth)
      => ComCall(6, this.p, Int32.Ptr, pWidth)
    get_Height(pHeight)
      => ComCall(7, this.p, Int32.Ptr, pHeight)
    Render(hDC1, x, y, cx, cy, xSrc, ySrc, cxSrc, cySrc, pRcWBounds)
      => ComCall(8, this.p, HDC, hDC1, Int32, x, Int32, y, Int32, cx, Int32, cy, Int32, xSrc, Int32, ySrc, Int32, cxSrc, Int32, cySrc, RECT.Ptr, pRcWBounds)
    set_hPal(hPal)
      => ComCall(9, this.p, IntPtr, hPal)
    get_CurDC(phDC)
      => ComCall(10, this.p, HDC.Ptr, phDC)
    SelectPicture(hDCIn, phDCOut, phBmpOut)
      => ComCall(11, this.p, HDC, hDCIn, HDC.Ptr, phDCOut, IntPtr.Ptr, phBmpOut)
    get_KeepOriginalFormat(pKeep)
      => ComCall(12, this.p, BOOL.Ptr, pKeep)
    put_KeepOriginalFormat(keep)
      => ComCall(13, this.p, BOOL, keep)
    PictureChanged()
      => ComCall(14, this.p)
    SaveAsFile(pStream, fSaveMemCopy, pCbSize)
      => ComCall(15, this.p, IStream, pStream, BOOL, fSaveMemCopy, Int32.Ptr, pCbSize)
    get_Attributes(pDwAttr)
      => ComCall(16, this.p, UInt32.Ptr, pDwAttr)
}
struct IFontEventsDisp extends IDispatch {
    static IID := "{4EF6100A-AF88-11D0-9846-00C04FC29993}"
}
struct IFontDisp extends IDispatch {
    static IID := "{BEF6E003-A874-101A-8BBA-00AA00300CAB}"
}
struct IPictureDisp extends IDispatch {
    static IID := "{7BF80981-BF32-101A-8BBB-00AA00300CAB}"
}
struct IOleInPlaceObjectWindowless extends IOleInPlaceObject {
    static IID := "{1C2056CC-5EF4-101B-8BC8-00AA003E3B29}"
    OnWindowMessage(msg, wParam1, lParam1, plResult)
      => ComCall(9, this.p, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
    GetDropTarget(ppDropTarget)
      => ComCall(10, this.p, IDropTarget.Ptr, ppDropTarget)
}
struct ACTIVATEFLAGS extends Int32 {
    static ACTIVATE_WINDOWLESS := 1
}
struct IOleInPlaceSiteEx extends IOleInPlaceSite {
    static IID := "{9C2CAD80-3424-11CF-B670-00AA004CD6D8}"
    OnInPlaceActivateEx(pfNoRedraw, dwFlags)
      => ComCall(15, this.p, BOOL.Ptr, pfNoRedraw, UInt32, dwFlags)
    OnInPlaceDeactivateEx(fNoRedraw)
      => ComCall(16, this.p, BOOL, fNoRedraw)
    RequestUIActivate()
      => ComCall(17, this.p)
}
struct OLEDCFLAGS extends Int32 {
    static OLEDC_NODRAW := 1
    static OLEDC_PAINTBKGND := 2
    static OLEDC_OFFSCREEN := 4
}
struct IOleInPlaceSiteWindowless extends IOleInPlaceSiteEx {
    static IID := "{922EADA0-3424-11CF-B670-00AA004CD6D8}"
    CanWindowlessActivate()
      => ComCall(18, this.p)
    GetCapture()
      => ComCall(19, this.p)
    SetCapture(fCapture)
      => ComCall(20, this.p, BOOL, fCapture)
    GetFocus()
      => ComCall(21, this.p)
    SetFocus(fFocus)
      => ComCall(22, this.p, BOOL, fFocus)
    GetDC(pRect, grfFlags, phDC)
      => ComCall(23, this.p, RECT.Ptr, pRect, UInt32, grfFlags, HDC.Ptr, phDC)
    ReleaseDC(hDC1)
      => ComCall(24, this.p, HDC, hDC1)
    InvalidateRect(pRect, fErase)
      => ComCall(25, this.p, RECT.Ptr, pRect, BOOL, fErase)
    InvalidateRgn(hRGN1, fErase)
      => ComCall(26, this.p, HRGN, hRGN1, BOOL, fErase)
    ScrollRect(dx, dy, pRectScroll, pRectClip)
      => ComCall(27, this.p, Int32, dx, Int32, dy, RECT.Ptr, pRectScroll, RECT.Ptr, pRectClip)
    AdjustRect(prc)
      => ComCall(28, this.p, RECT.Ptr, prc)
    OnDefWindowMessage(msg, wParam1, lParam1, plResult)
      => ComCall(29, this.p, UInt32, msg, WPARAM, wParam1, LPARAM, lParam1, LRESULT.Ptr, plResult)
}
struct VIEWSTATUS extends Int32 {
    static VIEWSTATUS_OPAQUE := 1
    static VIEWSTATUS_SOLIDBKGND := 2
    static VIEWSTATUS_DVASPECTOPAQUE := 4
    static VIEWSTATUS_DVASPECTTRANSPARENT := 8
    static VIEWSTATUS_SURFACE := 16
    static VIEWSTATUS_3DSURFACE := 32
}
struct HITRESULT extends Int32 {
    static HITRESULT_OUTSIDE := 0
    static HITRESULT_TRANSPARENT := 1
    static HITRESULT_CLOSE := 2
    static HITRESULT_HIT := 3
}
struct DVEXTENTINFO {
    cb : UInt32
    dwExtentMode : UInt32
    sizelProposed : SIZE
}
struct DVEXTENTMODE extends Int32 {
    static DVEXTENT_CONTENT := 0
    static DVEXTENT_INTEGRAL := 1
}
struct DVASPECTINFOFLAG extends Int32 {
    static DVASPECTINFOFLAG_CANOPTIMIZE := 1
}
struct DVASPECTINFO {
    cb : UInt32
    dwFlags : UInt32
}
struct IViewObjectEx extends IViewObject2 {
    static IID := "{3AF24292-0C96-11CE-A0CF-00AA00600AB8}"
    GetRect(dwAspect, pRect)
      => ComCall(10, this.p, UInt32, dwAspect, RECTL.Ptr, pRect)
    GetViewStatus(pdwStatus)
      => ComCall(11, this.p, UInt32.Ptr, pdwStatus)
    QueryHitPoint(dwAspect, pRectBounds, ptlLoc, lCloseHint, pHitResult)
      => ComCall(12, this.p, UInt32, dwAspect, RECT.Ptr, pRectBounds, POINT, ptlLoc, Int32, lCloseHint, UInt32.Ptr, pHitResult)
    QueryHitRect(dwAspect, pRectBounds, pRectLoc, lCloseHint, pHitResult)
      => ComCall(13, this.p, UInt32, dwAspect, RECT.Ptr, pRectBounds, RECT.Ptr, pRectLoc, Int32, lCloseHint, UInt32.Ptr, pHitResult)
    GetNaturalExtent(dwAspect, lindex, ptd, hicTargetDev, pExtentInfo, pSizel)
      => ComCall(14, this.p, DVASPECT, dwAspect, Int32, lindex, DVTARGETDEVICE.Ptr, ptd, HDC, hicTargetDev, DVEXTENTINFO.Ptr, pExtentInfo, SIZE.Ptr, pSizel)
}
struct IOleUndoUnit extends IUnknown {
    static IID := "{894AD3B0-EF97-11CE-9BC9-00AA00608E01}"
    Do(pUndoManager)
      => ComCall(3, this.p, IOleUndoManager, pUndoManager)
    GetDescription(pBstr)
      => ComCall(4, this.p, BSTR.Ptr, pBstr)
    GetUnitType(pClsid, plID)
      => ComCall(5, this.p, GUID.Ptr, pClsid, Int32.Ptr, plID)
    OnNextAdd()
      => ComCall(6, this.p)
}
struct IOleParentUndoUnit extends IOleUndoUnit {
    static IID := "{A1FAF330-EF97-11CE-9BC9-00AA00608E01}"
    Open(pPUU)
      => ComCall(7, this.p, IOleParentUndoUnit, pPUU)
    Close(pPUU, fCommit)
      => ComCall(8, this.p, IOleParentUndoUnit, pPUU, BOOL, fCommit)
    Add(pUU)
      => ComCall(9, this.p, IOleUndoUnit, pUU)
    FindUnit(pUU)
      => ComCall(10, this.p, IOleUndoUnit, pUU)
    GetParentState(pdwState)
      => ComCall(11, this.p, UInt32.Ptr, pdwState)
}
struct IEnumOleUndoUnits extends IUnknown {
    static IID := "{B3E7C340-EF97-11CE-9BC9-00AA00608E01}"
    Next(rgElt, pcEltFetched)
      => ComCall(3, this.p, UInt32, rgElt.Length, IOleUndoUnit.Ptr, rgElt, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumOleUndoUnits.Ptr, ppEnum)
}
struct IOleUndoManager extends IUnknown {
    static IID := "{D001F200-EF97-11CE-9BC9-00AA00608E01}"
    Open(pPUU)
      => ComCall(3, this.p, IOleParentUndoUnit, pPUU)
    Close(pPUU, fCommit)
      => ComCall(4, this.p, IOleParentUndoUnit, pPUU, BOOL, fCommit)
    Add(pUU)
      => ComCall(5, this.p, IOleUndoUnit, pUU)
    GetOpenParentState(pdwState)
      => ComCall(6, this.p, UInt32.Ptr, pdwState)
    DiscardFrom(pUU)
      => ComCall(7, this.p, IOleUndoUnit, pUU)
    UndoTo(pUU)
      => ComCall(8, this.p, IOleUndoUnit, pUU)
    RedoTo(pUU)
      => ComCall(9, this.p, IOleUndoUnit, pUU)
    EnumUndoable(ppEnum)
      => ComCall(10, this.p, IEnumOleUndoUnits.Ptr, ppEnum)
    EnumRedoable(ppEnum)
      => ComCall(11, this.p, IEnumOleUndoUnits.Ptr, ppEnum)
    GetLastUndoDescription(pBstr)
      => ComCall(12, this.p, BSTR.Ptr, pBstr)
    GetLastRedoDescription(pBstr)
      => ComCall(13, this.p, BSTR.Ptr, pBstr)
    Enable(fEnable)
      => ComCall(14, this.p, BOOL, fEnable)
}
struct POINTERINACTIVE extends Int32 {
    static POINTERINACTIVE_ACTIVATEONENTRY := 1
    static POINTERINACTIVE_DEACTIVATEONLEAVE := 2
    static POINTERINACTIVE_ACTIVATEONDRAG := 4
}
struct IPointerInactive extends IUnknown {
    static IID := "{55980BA0-35AA-11CF-B671-00AA004CD6D8}"
    GetActivationPolicy(pdwPolicy)
      => ComCall(3, this.p, POINTERINACTIVE.Ptr, pdwPolicy)
    OnInactiveMouseMove(pRectBounds, x, y, grfKeyState)
      => ComCall(4, this.p, RECT.Ptr, pRectBounds, Int32, x, Int32, y, UInt32, grfKeyState)
    OnInactiveSetCursor(pRectBounds, x, y, dwMouseMsg, fSetAlways)
      => ComCall(5, this.p, RECT.Ptr, pRectBounds, Int32, x, Int32, y, UInt32, dwMouseMsg, BOOL, fSetAlways)
}
struct IObjectWithSite extends IUnknown {
    static IID := "{FC4801A3-2BA9-11CF-A229-00AA003D7352}"
    SetSite(pUnkSite)
      => ComCall(3, this.p, IUnknown, pUnkSite)
    GetSite(riid, ppvSite)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvSite)
}
struct CALPOLESTR {
    cElems : UInt32
    pElems : PWSTR.Ptr
}
struct CADWORD {
    cElems : UInt32
    pElems : UInt32.Ptr
}
struct IPerPropertyBrowsing extends IUnknown {
    static IID := "{376BD3AA-3845-101B-84ED-08002B2EC713}"
    GetDisplayString(dispID, pBstr)
      => ComCall(3, this.p, Int32, dispID, BSTR.Ptr, pBstr)
    MapPropertyToPage(dispID, pClsid)
      => ComCall(4, this.p, Int32, dispID, GUID.Ptr, pClsid)
    GetPredefinedStrings(dispID, pCaStringsOut, pCaCookiesOut)
      => ComCall(5, this.p, Int32, dispID, CALPOLESTR.Ptr, pCaStringsOut, CADWORD.Ptr, pCaCookiesOut)
    GetPredefinedValue(dispID, dwCookie, pVarOut)
      => ComCall(6, this.p, Int32, dispID, UInt32, dwCookie, VARIANT.Ptr, pVarOut)
}
struct PROPBAG2_TYPE extends Int32 {
    static PROPBAG2_TYPE_UNDEFINED := 0
    static PROPBAG2_TYPE_DATA := 1
    static PROPBAG2_TYPE_URL := 2
    static PROPBAG2_TYPE_OBJECT := 3
    static PROPBAG2_TYPE_STREAM := 4
    static PROPBAG2_TYPE_STORAGE := 5
    static PROPBAG2_TYPE_MONIKER := 6
}
struct IPersistPropertyBag2 extends IPersist {
    static IID := "{22F55881-280B-11D0-A8A9-00A0C90C2004}"
    InitNew()
      => ComCall(4, this.p)
    Load(pPropBag, pErrLog)
      => ComCall(5, this.p, IPropertyBag2, pPropBag, IErrorLog, pErrLog)
    Save(pPropBag, fClearDirty, fSaveAllProperties)
      => ComCall(6, this.p, IPropertyBag2, pPropBag, BOOL, fClearDirty, BOOL, fSaveAllProperties)
    IsDirty()
      => ComCall(7, this.p)
}
struct IAdviseSinkEx extends IAdviseSink {
    static IID := "{3AF24290-0C96-11CE-A0CF-00AA00600AB8}"
    OnViewStatusChange(dwViewStatus)
      => ComCall(8, this.p, UInt32, dwViewStatus, "void")
}
struct QACONTAINERFLAGS extends Int32 {
    static QACONTAINER_SHOWHATCHING := 1
    static QACONTAINER_SHOWGRABHANDLES := 2
    static QACONTAINER_USERMODE := 4
    static QACONTAINER_DISPLAYASDEFAULT := 8
    static QACONTAINER_UIDEAD := 16
    static QACONTAINER_AUTOCLIP := 32
    static QACONTAINER_MESSAGEREFLECT := 64
    static QACONTAINER_SUPPORTSMNEMONICS := 128
}
struct QACONTAINER {
    cbSize : UInt32 := this.Size
    pClientSite : IOleClientSite
    pAdviseSink : IAdviseSinkEx
    pPropertyNotifySink : IPropertyNotifySink
    pUnkEventSink : IUnknown
    dwAmbientFlags : UInt32
    colorFore : UInt32
    colorBack : UInt32
    pFont : IFont
    pUndoMgr : IOleUndoManager
    dwAppearance : UInt32
    lcid : Int32
    hpal : HPALETTE
    pBindHost : IBindHost
    pOleControlSite : IOleControlSite
    pServiceProvider : IServiceProvider
}
struct QACONTROL {
    cbSize : UInt32 := this.Size
    dwMiscStatus : UInt32
    dwViewStatus : UInt32
    dwEventCookie : UInt32
    dwPropNotifyCookie : UInt32
    dwPointerActivationPolicy : UInt32
}
struct IQuickActivate extends IUnknown {
    static IID := "{CF51ED10-62FE-11CF-BF86-00A0C9034836}"
    QuickActivate(pQaContainer, pQaControl)
      => ComCall(3, this.p, QACONTAINER.Ptr, pQaContainer, QACONTROL.Ptr, pQaControl)
    SetContentExtent(pSizel)
      => ComCall(4, this.p, SIZE.Ptr, pSizel)
    GetContentExtent(pSizel)
      => ComCall(5, this.p, SIZE.Ptr, pSizel)
}
struct OCPFIPARAMS {
    cbStructSize : UInt32
    hWndOwner : HWND
    x : Int32
    y : Int32
    lpszCaption : PWSTR
    cObjects : UInt32
    lplpUnk : IUnknown.Ptr
    cPages : UInt32
    lpPages : GUID.Ptr
    lcid : UInt32
    dispidInitialProperty : Int32
}
struct FONTDESC {
    cbSizeofstruct : UInt32
    lpstrName : PWSTR
    cySize : CY
    sWeight : Int16
    sCharset : Int16
    fItalic : BOOL
    fUnderline : BOOL
    fStrikethrough : BOOL
}
struct PICTDESC {
    cbSizeofstruct : UInt32
    picType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bmp : this._bmp_e__Struct
            wmf : this._wmf_e__Struct
            icon : this._icon_e__Struct
            emf : this._emf_e__Struct
        }
        struct _bmp_e__Struct {
            hbitmap : HBITMAP
            hpal : HPALETTE
        }
        struct _wmf_e__Struct {
            hmeta : HMETAFILE
            xExt : Int32
            yExt : Int32
        }
        struct _icon_e__Struct {
            hicon : HICON
        }
        struct _emf_e__Struct {
            hemf : HENHMETAFILE
        }
    }
}
struct OLE_TRISTATE extends Int32 {
    static triUnchecked := 0
    static triChecked := 1
    static triGray := 2
}
struct IVBGetControl extends IUnknown {
    static IID := "{40A050A0-3C31-101B-A82E-08002B2B2337}"
    EnumControls(dwOleContF, dwWhich, ppenumUnk)
      => ComCall(3, this.p, UInt32, dwOleContF, ENUM_CONTROLS_WHICH_FLAGS, dwWhich, IEnumUnknown.Ptr, ppenumUnk)
}
struct IGetOleObject extends IUnknown {
    static IID := "{8A701DA0-4FEB-101B-A82E-08002B2B2337}"
    GetOleObject(riid, ppvObj)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
}
struct IVBFormat extends IUnknown {
    static IID := "{9849FD60-3768-101B-8D72-AE6164FFE3CF}"
    Format(vData, bstrFormat, lpBuffer, cb, lcid, sFirstDayOfWeek, sFirstWeekOfYear, rcb)
      => ComCall(3, this.p, VARIANT.Ptr, vData, BSTR, bstrFormat, Struct.Ptr, lpBuffer, UInt16, cb, Int32, lcid, Int16, sFirstDayOfWeek, UInt16, sFirstWeekOfYear, UInt16.Ptr, rcb)
}
struct IGetVBAObject extends IUnknown {
    static IID := "{91733A60-3F4C-101B-A3F6-00AA0034E4E9}"
    GetObject(riid, ppvObj, dwReserved)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj, UInt32, dwReserved)
}
struct DOCMISC extends Int32 {
    static DOCMISC_CANCREATEMULTIPLEVIEWS := 1
    static DOCMISC_SUPPORTCOMPLEXRECTANGLES := 2
    static DOCMISC_CANTOPENEDIT := 4
    static DOCMISC_NOFILESUPPORT := 8
}
struct IOleDocument extends IUnknown {
    static IID := "{B722BCC5-4E68-101B-A2BC-00AA00404770}"
    CreateView(pIPSite, pstm, dwReserved, ppView)
      => ComCall(3, this.p, IOleInPlaceSite, pIPSite, IStream, pstm, UInt32, dwReserved, IOleDocumentView.Ptr, ppView)
    GetDocMiscStatus(pdwStatus)
      => ComCall(4, this.p, UInt32.Ptr, pdwStatus)
    EnumViews(ppEnum, ppView)
      => ComCall(5, this.p, IEnumOleDocumentViews.Ptr, ppEnum, IOleDocumentView.Ptr, ppView)
}
struct IOleDocumentSite extends IUnknown {
    static IID := "{B722BCC7-4E68-101B-A2BC-00AA00404770}"
    ActivateMe(pViewToActivate)
      => ComCall(3, this.p, IOleDocumentView, pViewToActivate)
}
struct IOleDocumentView extends IUnknown {
    static IID := "{B722BCC6-4E68-101B-A2BC-00AA00404770}"
    SetInPlaceSite(pIPSite)
      => ComCall(3, this.p, IOleInPlaceSite, pIPSite)
    GetInPlaceSite(ppIPSite)
      => ComCall(4, this.p, IOleInPlaceSite.Ptr, ppIPSite)
    GetDocument(ppunk)
      => ComCall(5, this.p, IUnknown.Ptr, ppunk)
    SetRect(prcView)
      => ComCall(6, this.p, RECT.Ptr, prcView)
    GetRect(prcView)
      => ComCall(7, this.p, RECT.Ptr, prcView)
    SetRectComplex(prcView, prcHScroll, prcVScroll, prcSizeBox)
      => ComCall(8, this.p, RECT.Ptr, prcView, RECT.Ptr, prcHScroll, RECT.Ptr, prcVScroll, RECT.Ptr, prcSizeBox)
    Show(fShow)
      => ComCall(9, this.p, BOOL, fShow)
    UIActivate(fUIActivate)
      => ComCall(10, this.p, BOOL, fUIActivate)
    Open()
      => ComCall(11, this.p)
    CloseView(dwReserved)
      => ComCall(12, this.p, UInt32, dwReserved)
    SaveViewState(pstm)
      => ComCall(13, this.p, IStream, pstm)
    ApplyViewState(pstm)
      => ComCall(14, this.p, IStream, pstm)
    Clone(pIPSiteNew, ppViewNew)
      => ComCall(15, this.p, IOleInPlaceSite, pIPSiteNew, IOleDocumentView.Ptr, ppViewNew)
}
struct IEnumOleDocumentViews extends IUnknown {
    static IID := "{B722BCC8-4E68-101B-A2BC-00AA00404770}"
    Next(cViews, rgpView, pcFetched)
      => ComCall(3, this.p, UInt32, cViews, IOleDocumentView.Ptr, rgpView, UInt32.Ptr, pcFetched)
    Skip(cViews)
      => ComCall(4, this.p, UInt32, cViews)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumOleDocumentViews.Ptr, ppEnum)
}
struct IContinueCallback extends IUnknown {
    static IID := "{B722BCCA-4E68-101B-A2BC-00AA00404770}"
    FContinue()
      => ComCall(3, this.p)
    FContinuePrinting(nCntPrinted, nCurPage, pwszPrintStatus)
      => ComCall(4, this.p, Int32, nCntPrinted, Int32, nCurPage, "Str", pwszPrintStatus)
}
struct PRINTFLAG extends Int32 {
    static PRINTFLAG_MAYBOTHERUSER := 1
    static PRINTFLAG_PROMPTUSER := 2
    static PRINTFLAG_USERMAYCHANGEPRINTER := 4
    static PRINTFLAG_RECOMPOSETODEVICE := 8
    static PRINTFLAG_DONTACTUALLYPRINT := 16
    static PRINTFLAG_FORCEPROPERTIES := 32
    static PRINTFLAG_PRINTTOFILE := 64
}
struct PAGERANGE {
    nFromPage : Int32
    nToPage : Int32
}
struct PAGESET {
    cbStruct : UInt32
    fOddPages : BOOL
    fEvenPages : BOOL
    cPageRange : UInt32
    rgPages : PAGERANGE[1]
}
struct IPrint extends IUnknown {
    static IID := "{B722BCC9-4E68-101B-A2BC-00AA00404770}"
    SetInitialPageNum(nFirstPage)
      => ComCall(3, this.p, Int32, nFirstPage)
    GetPageInfo(pnFirstPage, pcPages)
      => ComCall(4, this.p, Int32.Ptr, pnFirstPage, Int32.Ptr, pcPages)
    Print(grfFlags, pptd, ppPageSet, pstgmOptions, pcallback, nFirstPage, pcPagesPrinted, pnLastPage)
      => ComCall(5, this.p, UInt32, grfFlags, DVTARGETDEVICE.Ptr.Ptr, pptd, PAGESET.Ptr.Ptr, ppPageSet, STGMEDIUM.Ptr, pstgmOptions, IContinueCallback, pcallback, Int32, nFirstPage, Int32.Ptr, pcPagesPrinted, Int32.Ptr, pnLastPage)
}
struct OLECMDF extends Int32 {
    static OLECMDF_SUPPORTED := 1
    static OLECMDF_ENABLED := 2
    static OLECMDF_LATCHED := 4
    static OLECMDF_NINCHED := 8
    static OLECMDF_INVISIBLE := 16
    static OLECMDF_DEFHIDEONCTXTMENU := 32
}
struct OLECMD {
    cmdID : UInt32
    cmdf : UInt32
}
struct OLECMDTEXT {
    cmdtextf : UInt32
    cwActual : UInt32
    cwBuf : UInt32
    rgwz : UInt16[1]
}
struct OLECMDTEXTF extends Int32 {
    static OLECMDTEXTF_NONE := 0
    static OLECMDTEXTF_NAME := 1
    static OLECMDTEXTF_STATUS := 2
}
struct OLECMDEXECOPT extends Int32 {
    static OLECMDEXECOPT_DODEFAULT := 0
    static OLECMDEXECOPT_PROMPTUSER := 1
    static OLECMDEXECOPT_DONTPROMPTUSER := 2
    static OLECMDEXECOPT_SHOWHELP := 3
}
struct OLECMDID extends Int32 {
    static OLECMDID_OPEN := 1
    static OLECMDID_NEW := 2
    static OLECMDID_SAVE := 3
    static OLECMDID_SAVEAS := 4
    static OLECMDID_SAVECOPYAS := 5
    static OLECMDID_PRINT := 6
    static OLECMDID_PRINTPREVIEW := 7
    static OLECMDID_PAGESETUP := 8
    static OLECMDID_SPELL := 9
    static OLECMDID_PROPERTIES := 10
    static OLECMDID_CUT := 11
    static OLECMDID_COPY := 12
    static OLECMDID_PASTE := 13
    static OLECMDID_PASTESPECIAL := 14
    static OLECMDID_UNDO := 15
    static OLECMDID_REDO := 16
    static OLECMDID_SELECTALL := 17
    static OLECMDID_CLEARSELECTION := 18
    static OLECMDID_ZOOM := 19
    static OLECMDID_GETZOOMRANGE := 20
    static OLECMDID_UPDATECOMMANDS := 21
    static OLECMDID_REFRESH := 22
    static OLECMDID_STOP := 23
    static OLECMDID_HIDETOOLBARS := 24
    static OLECMDID_SETPROGRESSMAX := 25
    static OLECMDID_SETPROGRESSPOS := 26
    static OLECMDID_SETPROGRESSTEXT := 27
    static OLECMDID_SETTITLE := 28
    static OLECMDID_SETDOWNLOADSTATE := 29
    static OLECMDID_STOPDOWNLOAD := 30
    static OLECMDID_ONTOOLBARACTIVATED := 31
    static OLECMDID_FIND := 32
    static OLECMDID_DELETE := 33
    static OLECMDID_HTTPEQUIV := 34
    static OLECMDID_HTTPEQUIV_DONE := 35
    static OLECMDID_ENABLE_INTERACTION := 36
    static OLECMDID_ONUNLOAD := 37
    static OLECMDID_PROPERTYBAG2 := 38
    static OLECMDID_PREREFRESH := 39
    static OLECMDID_SHOWSCRIPTERROR := 40
    static OLECMDID_SHOWMESSAGE := 41
    static OLECMDID_SHOWFIND := 42
    static OLECMDID_SHOWPAGESETUP := 43
    static OLECMDID_SHOWPRINT := 44
    static OLECMDID_CLOSE := 45
    static OLECMDID_ALLOWUILESSSAVEAS := 46
    static OLECMDID_DONTDOWNLOADCSS := 47
    static OLECMDID_UPDATEPAGESTATUS := 48
    static OLECMDID_PRINT2 := 49
    static OLECMDID_PRINTPREVIEW2 := 50
    static OLECMDID_SETPRINTTEMPLATE := 51
    static OLECMDID_GETPRINTTEMPLATE := 52
    static OLECMDID_PAGEACTIONBLOCKED := 55
    static OLECMDID_PAGEACTIONUIQUERY := 56
    static OLECMDID_FOCUSVIEWCONTROLS := 57
    static OLECMDID_FOCUSVIEWCONTROLSQUERY := 58
    static OLECMDID_SHOWPAGEACTIONMENU := 59
    static OLECMDID_ADDTRAVELENTRY := 60
    static OLECMDID_UPDATETRAVELENTRY := 61
    static OLECMDID_UPDATEBACKFORWARDSTATE := 62
    static OLECMDID_OPTICAL_ZOOM := 63
    static OLECMDID_OPTICAL_GETZOOMRANGE := 64
    static OLECMDID_WINDOWSTATECHANGED := 65
    static OLECMDID_ACTIVEXINSTALLSCOPE := 66
    static OLECMDID_UPDATETRAVELENTRY_DATARECOVERY := 67
    static OLECMDID_SHOWTASKDLG := 68
    static OLECMDID_POPSTATEEVENT := 69
    static OLECMDID_VIEWPORT_MODE := 70
    static OLECMDID_LAYOUT_VIEWPORT_WIDTH := 71
    static OLECMDID_VISUAL_VIEWPORT_EXCLUDE_BOTTOM := 72
    static OLECMDID_USER_OPTICAL_ZOOM := 73
    static OLECMDID_PAGEAVAILABLE := 74
    static OLECMDID_GETUSERSCALABLE := 75
    static OLECMDID_UPDATE_CARET := 76
    static OLECMDID_ENABLE_VISIBILITY := 77
    static OLECMDID_MEDIA_PLAYBACK := 78
    static OLECMDID_SETFAVICON := 79
    static OLECMDID_SET_HOST_FULLSCREENMODE := 80
    static OLECMDID_EXITFULLSCREEN := 81
    static OLECMDID_SCROLLCOMPLETE := 82
    static OLECMDID_ONBEFOREUNLOAD := 83
    static OLECMDID_SHOWMESSAGE_BLOCKABLE := 84
    static OLECMDID_SHOWTASKDLG_BLOCKABLE := 85
}
struct MEDIAPLAYBACK_STATE extends Int32 {
    static MEDIAPLAYBACK_RESUME := 0
    static MEDIAPLAYBACK_PAUSE := 1
    static MEDIAPLAYBACK_PAUSE_AND_SUSPEND := 2
    static MEDIAPLAYBACK_RESUME_FROM_SUSPEND := 3
}
struct IGNOREMIME extends Int32 {
    static IGNOREMIME_PROMPT := 1
    static IGNOREMIME_TEXT := 2
}
struct WPCSETTING extends Int32 {
    static WPCSETTING_LOGGING_ENABLED := 1
    static WPCSETTING_FILEDOWNLOAD_BLOCKED := 2
}
struct IOleCommandTarget extends IUnknown {
    static IID := "{B722BCCB-4E68-101B-A2BC-00AA00404770}"
    QueryStatus(pguidCmdGroup, cCmds, prgCmds, pCmdText)
      => ComCall(3, this.p, GUID.Ptr, pguidCmdGroup, UInt32, cCmds, OLECMD.Ptr, prgCmds, OLECMDTEXT.Ptr, pCmdText)
    Exec(pguidCmdGroup, nCmdID, nCmdexecopt, pvaIn, pvaOut)
      => ComCall(4, this.p, GUID.Ptr, pguidCmdGroup, UInt32, nCmdID, UInt32, nCmdexecopt, VARIANT.Ptr, pvaIn, VARIANT.Ptr, pvaOut)
}
struct OLECMDID_REFRESHFLAG extends Int32 {
    static OLECMDIDF_REFRESH_NORMAL := 0
    static OLECMDIDF_REFRESH_IFEXPIRED := 1
    static OLECMDIDF_REFRESH_CONTINUE := 2
    static OLECMDIDF_REFRESH_COMPLETELY := 3
    static OLECMDIDF_REFRESH_NO_CACHE := 4
    static OLECMDIDF_REFRESH_RELOAD := 5
    static OLECMDIDF_REFRESH_LEVELMASK := 255
    static OLECMDIDF_REFRESH_CLEARUSERINPUT := 4096
    static OLECMDIDF_REFRESH_PROMPTIFOFFLINE := 8192
    static OLECMDIDF_REFRESH_THROUGHSCRIPT := 16384
    static OLECMDIDF_REFRESH_SKIPBEFOREUNLOADEVENT := 32768
    static OLECMDIDF_REFRESH_PAGEACTION_ACTIVEXINSTALL := 65536
    static OLECMDIDF_REFRESH_PAGEACTION_FILEDOWNLOAD := 131072
    static OLECMDIDF_REFRESH_PAGEACTION_LOCALMACHINE := 262144
    static OLECMDIDF_REFRESH_PAGEACTION_POPUPWINDOW := 524288
    static OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNLOCALMACHINE := 1048576
    static OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNTRUSTED := 2097152
    static OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTRANET := 4194304
    static OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTERNET := 8388608
    static OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNRESTRICTED := 16777216
    static OLECMDIDF_REFRESH_PAGEACTION_MIXEDCONTENT := 33554432
    static OLECMDIDF_REFRESH_PAGEACTION_INVALID_CERT := 67108864
    static OLECMDIDF_REFRESH_PAGEACTION_ALLOW_VERSION := 134217728
}
struct OLECMDID_PAGEACTIONFLAG extends Int32 {
    static OLECMDIDF_PAGEACTION_FILEDOWNLOAD := 1
    static OLECMDIDF_PAGEACTION_ACTIVEXINSTALL := 2
    static OLECMDIDF_PAGEACTION_ACTIVEXTRUSTFAIL := 4
    static OLECMDIDF_PAGEACTION_ACTIVEXUSERDISABLE := 8
    static OLECMDIDF_PAGEACTION_ACTIVEXDISALLOW := 16
    static OLECMDIDF_PAGEACTION_ACTIVEXUNSAFE := 32
    static OLECMDIDF_PAGEACTION_POPUPWINDOW := 64
    static OLECMDIDF_PAGEACTION_LOCALMACHINE := 128
    static OLECMDIDF_PAGEACTION_MIMETEXTPLAIN := 256
    static OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE := 512
    static OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXINSTALL := 512
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNLOCALMACHINE := 1024
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNTRUSTED := 2048
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTRANET := 4096
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTERNET := 8192
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNRESTRICTED := 16384
    static OLECMDIDF_PAGEACTION_PROTLOCKDOWNDENY := 32768
    static OLECMDIDF_PAGEACTION_POPUPALLOWED := 65536
    static OLECMDIDF_PAGEACTION_SCRIPTPROMPT := 131072
    static OLECMDIDF_PAGEACTION_ACTIVEXUSERAPPROVAL := 262144
    static OLECMDIDF_PAGEACTION_MIXEDCONTENT := 524288
    static OLECMDIDF_PAGEACTION_INVALID_CERT := 1048576
    static OLECMDIDF_PAGEACTION_INTRANETZONEREQUEST := 2097152
    static OLECMDIDF_PAGEACTION_XSSFILTERED := 4194304
    static OLECMDIDF_PAGEACTION_SPOOFABLEIDNHOST := 8388608
    static OLECMDIDF_PAGEACTION_ACTIVEX_EPM_INCOMPATIBLE := 16777216
    static OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXUSERAPPROVAL := 33554432
    static OLECMDIDF_PAGEACTION_WPCBLOCKED := 67108864
    static OLECMDIDF_PAGEACTION_WPCBLOCKED_ACTIVEX := 134217728
    static OLECMDIDF_PAGEACTION_EXTENSION_COMPAT_BLOCKED := 268435456
    static OLECMDIDF_PAGEACTION_NORESETACTIVEX := 536870912
    static OLECMDIDF_PAGEACTION_GENERIC_STATE := 1073741824
    static OLECMDIDF_PAGEACTION_RESET := -2147483648
}
struct OLECMDID_BROWSERSTATEFLAG extends Int32 {
    static OLECMDIDF_BROWSERSTATE_EXTENSIONSOFF := 1
    static OLECMDIDF_BROWSERSTATE_IESECURITY := 2
    static OLECMDIDF_BROWSERSTATE_PROTECTEDMODE_OFF := 4
    static OLECMDIDF_BROWSERSTATE_RESET := 8
    static OLECMDIDF_BROWSERSTATE_REQUIRESACTIVEX := 16
    static OLECMDIDF_BROWSERSTATE_DESKTOPHTMLDIALOG := 32
    static OLECMDIDF_BROWSERSTATE_BLOCKEDVERSION := 64
}
struct OLECMDID_OPTICAL_ZOOMFLAG extends Int32 {
    static OLECMDIDF_OPTICAL_ZOOM_NOPERSIST := 1
    static OLECMDIDF_OPTICAL_ZOOM_NOLAYOUT := 16
    static OLECMDIDF_OPTICAL_ZOOM_NOTRANSIENT := 32
    static OLECMDIDF_OPTICAL_ZOOM_RELOADFORNEWTAB := 64
}
struct PAGEACTION_UI extends Int32 {
    static PAGEACTION_UI_DEFAULT := 0
    static PAGEACTION_UI_MODAL := 1
    static PAGEACTION_UI_MODELESS := 2
    static PAGEACTION_UI_SILENT := 3
}
struct OLECMDID_WINDOWSTATE_FLAG extends Int32 {
    static OLECMDIDF_WINDOWSTATE_USERVISIBLE := 1
    static OLECMDIDF_WINDOWSTATE_ENABLED := 2
    static OLECMDIDF_WINDOWSTATE_USERVISIBLE_VALID := 65536
    static OLECMDIDF_WINDOWSTATE_ENABLED_VALID := 131072
}
struct OLECMDID_VIEWPORT_MODE_FLAG extends Int32 {
    static OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH := 1
    static OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM := 2
    static OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH_VALID := 65536
    static OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM_VALID := 131072
}
struct IZoomEvents extends IUnknown {
    static IID := "{41B68150-904C-4E17-A0BA-A438182E359D}"
    OnZoomPercentChanged(ulZoomPercent)
      => ComCall(3, this.p, UInt32, ulZoomPercent)
}
struct IProtectFocus extends IUnknown {
    static IID := "{D81F90A3-8156-44F7-AD28-5ABB87003274}"
    AllowFocusChange(pfAllow)
      => ComCall(3, this.p, BOOL.Ptr, pfAllow)
}
struct IProtectedModeMenuServices extends IUnknown {
    static IID := "{73C105EE-9DFF-4A07-B83C-7EFF290C266E}"
    CreateMenu(phMenu)
      => ComCall(3, this.p, HMENU.Ptr, phMenu)
    LoadMenu(pszModuleName, pszMenuName, phMenu)
      => ComCall(4, this.p, "Str", pszModuleName, "Str", pszMenuName, HMENU.Ptr, phMenu)
    LoadMenuID(pszModuleName, wResourceID, phMenu)
      => ComCall(5, this.p, "Str", pszModuleName, UInt16, wResourceID, HMENU.Ptr, phMenu)
}
struct LPFNOLEUIHOOK extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct OLEUIINSERTOBJECTW {
    cbStruct : UInt32
    dwFlags : INSERT_OBJECT_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    clsid : GUID
    lpszFile : PWSTR
    cchFile : UInt32
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
    iid : GUID
    oleRender : UInt32
    lpFormatEtc : FORMATETC.Ptr
    lpIOleClientSite : IOleClientSite
    lpIStorage : IStorage
    ppvObj : Struct.Ptr.Ptr
    sc : Int32
    hMetaPict : HGLOBAL
}
struct OLEUIINSERTOBJECTA {
    cbStruct : UInt32
    dwFlags : INSERT_OBJECT_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    clsid : GUID
    lpszFile : PSTR
    cchFile : UInt32
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
    iid : GUID
    oleRender : UInt32
    lpFormatEtc : FORMATETC.Ptr
    lpIOleClientSite : IOleClientSite
    lpIStorage : IStorage
    ppvObj : Struct.Ptr.Ptr
    sc : Int32
    hMetaPict : HGLOBAL
}
struct OLEUIPASTEFLAG extends Int32 {
    static OLEUIPASTE_ENABLEICON := 2048
    static OLEUIPASTE_PASTEONLY := 0
    static OLEUIPASTE_PASTE := 512
    static OLEUIPASTE_LINKANYTYPE := 1024
    static OLEUIPASTE_LINKTYPE1 := 1
    static OLEUIPASTE_LINKTYPE2 := 2
    static OLEUIPASTE_LINKTYPE3 := 4
    static OLEUIPASTE_LINKTYPE4 := 8
    static OLEUIPASTE_LINKTYPE5 := 16
    static OLEUIPASTE_LINKTYPE6 := 32
    static OLEUIPASTE_LINKTYPE7 := 64
    static OLEUIPASTE_LINKTYPE8 := 128
}
struct OLEUIPASTEENTRYW {
    fmtetc : FORMATETC
    lpstrFormatName : PWSTR
    lpstrResultText : PWSTR
    dwFlags : UInt32
    dwScratchSpace : UInt32
}
struct OLEUIPASTEENTRYA {
    fmtetc : FORMATETC
    lpstrFormatName : PSTR
    lpstrResultText : PSTR
    dwFlags : UInt32
    dwScratchSpace : UInt32
}
struct OLEUIPASTESPECIALW {
    cbStruct : UInt32
    dwFlags : PASTE_SPECIAL_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    lpSrcDataObj : IDataObject
    arrPasteEntries : OLEUIPASTEENTRYW.Ptr
    cPasteEntries : Int32
    arrLinkTypes : UInt32.Ptr
    cLinkTypes : Int32
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
    nSelectedIndex : Int32
    fLink : BOOL
    hMetaPict : HGLOBAL
    sizel : SIZE
}
struct OLEUIPASTESPECIALA {
    cbStruct : UInt32
    dwFlags : PASTE_SPECIAL_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    lpSrcDataObj : IDataObject
    arrPasteEntries : OLEUIPASTEENTRYA.Ptr
    cPasteEntries : Int32
    arrLinkTypes : UInt32.Ptr
    cLinkTypes : Int32
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
    nSelectedIndex : Int32
    fLink : BOOL
    hMetaPict : HGLOBAL
    sizel : SIZE
}
struct IOleUILinkContainerW extends IUnknown {
    GetNextLink(dwLink)
      => ComCall(3, this.p, UInt32, dwLink, UInt32)
    SetLinkUpdateOptions(dwLink, dwUpdateOpt)
      => ComCall(4, this.p, UInt32, dwLink, UInt32, dwUpdateOpt)
    GetLinkUpdateOptions(dwLink, lpdwUpdateOpt)
      => ComCall(5, this.p, UInt32, dwLink, UInt32.Ptr, lpdwUpdateOpt)
    SetLinkSource(dwLink, lpszDisplayName, lenFileName, pchEaten, fValidateSource)
      => ComCall(6, this.p, UInt32, dwLink, "Str", lpszDisplayName, UInt32, lenFileName, UInt32.Ptr, pchEaten, BOOL, fValidateSource)
    GetLinkSource(dwLink, lplpszDisplayName?, lplenFileName, lplpszFullLinkType?, lplpszShortLinkType?, lpfSourceAvailable, lpfIsSelected)
      => ComCall(7, this.p, UInt32, dwLink, PWSTR.Ptr, lplpszDisplayName?, UInt32.Ptr, lplenFileName, PWSTR.Ptr, lplpszFullLinkType?, PWSTR.Ptr, lplpszShortLinkType?, BOOL.Ptr, lpfSourceAvailable, BOOL.Ptr, lpfIsSelected)
    OpenLinkSource(dwLink)
      => ComCall(8, this.p, UInt32, dwLink)
    UpdateLink(dwLink, fErrorMessage, fReserved)
      => ComCall(9, this.p, UInt32, dwLink, BOOL, fErrorMessage, BOOL, fReserved)
    CancelLink(dwLink)
      => ComCall(10, this.p, UInt32, dwLink)
}
struct IOleUILinkContainerA extends IUnknown {
    GetNextLink(dwLink)
      => ComCall(3, this.p, UInt32, dwLink, UInt32)
    SetLinkUpdateOptions(dwLink, dwUpdateOpt)
      => ComCall(4, this.p, UInt32, dwLink, UInt32, dwUpdateOpt)
    GetLinkUpdateOptions(dwLink, lpdwUpdateOpt)
      => ComCall(5, this.p, UInt32, dwLink, UInt32.Ptr, lpdwUpdateOpt)
    SetLinkSource(dwLink, lpszDisplayName, lenFileName, pchEaten, fValidateSource)
      => ComCall(6, this.p, UInt32, dwLink, PSTR, lpszDisplayName, UInt32, lenFileName, UInt32.Ptr, pchEaten, BOOL, fValidateSource)
    GetLinkSource(dwLink, lplpszDisplayName?, lplenFileName, lplpszFullLinkType?, lplpszShortLinkType?, lpfSourceAvailable, lpfIsSelected)
      => ComCall(7, this.p, UInt32, dwLink, PSTR.Ptr, lplpszDisplayName?, UInt32.Ptr, lplenFileName, PSTR.Ptr, lplpszFullLinkType?, PSTR.Ptr, lplpszShortLinkType?, BOOL.Ptr, lpfSourceAvailable, BOOL.Ptr, lpfIsSelected)
    OpenLinkSource(dwLink)
      => ComCall(8, this.p, UInt32, dwLink)
    UpdateLink(dwLink, fErrorMessage, fReserved)
      => ComCall(9, this.p, UInt32, dwLink, BOOL, fErrorMessage, BOOL, fReserved)
    CancelLink(dwLink)
      => ComCall(10, this.p, UInt32, dwLink)
}
struct OLEUIEDITLINKSW {
    cbStruct : UInt32
    dwFlags : EDIT_LINKS_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    lpOleUILinkContainer : IOleUILinkContainerW
}
struct OLEUIEDITLINKSA {
    cbStruct : UInt32
    dwFlags : EDIT_LINKS_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    lpOleUILinkContainer : IOleUILinkContainerA
}
struct OLEUICHANGEICONW {
    cbStruct : UInt32
    dwFlags : CHANGE_ICON_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    hMetaPict : HGLOBAL
    clsid : GUID
    szIconExe : UInt16[260]
    cchIconExe : Int32
}
struct OLEUICHANGEICONA {
    cbStruct : UInt32
    dwFlags : CHANGE_ICON_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    hMetaPict : HGLOBAL
    clsid : GUID
    szIconExe : CHAR[260]
    cchIconExe : Int32
}
struct OLEUICONVERTW {
    cbStruct : UInt32
    dwFlags : UI_CONVERT_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    clsid : GUID
    clsidConvertDefault : GUID
    clsidActivateDefault : GUID
    clsidNew : GUID
    dvAspect : UInt32
    wFormat : UInt16
    fIsLinkedObject : BOOL
    hMetaPict : HGLOBAL
    lpszUserType : PWSTR
    fObjectsIconChanged : BOOL
    lpszDefLabel : PWSTR
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
}
struct OLEUICONVERTA {
    cbStruct : UInt32
    dwFlags : UI_CONVERT_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    clsid : GUID
    clsidConvertDefault : GUID
    clsidActivateDefault : GUID
    clsidNew : GUID
    dvAspect : UInt32
    wFormat : UInt16
    fIsLinkedObject : BOOL
    hMetaPict : HGLOBAL
    lpszUserType : PSTR
    fObjectsIconChanged : BOOL
    lpszDefLabel : PSTR
    cClsidExclude : UInt32
    lpClsidExclude : GUID.Ptr
}
struct OLEUIBUSYW {
    cbStruct : UInt32
    dwFlags : BUSY_DIALOG_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    hTask : HTASK
    lphWndDialog : HWND.Ptr
}
struct OLEUIBUSYA {
    cbStruct : UInt32
    dwFlags : BUSY_DIALOG_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    hTask : HTASK
    lphWndDialog : HWND.Ptr
}
struct OLEUICHANGESOURCEW {
    cbStruct : UInt32
    dwFlags : CHANGE_SOURCE_FLAGS
    hWndOwner : HWND
    lpszCaption : PWSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PWSTR
    hResource : HRSRC
    lpOFN : OPENFILENAMEW.Ptr
    dwReserved1 : UInt32[4]
    lpOleUILinkContainer : IOleUILinkContainerW
    dwLink : UInt32
    lpszDisplayName : PWSTR
    nFileLength : UInt32
    lpszFrom : PWSTR
    lpszTo : PWSTR
}
struct OLEUICHANGESOURCEA {
    cbStruct : UInt32
    dwFlags : CHANGE_SOURCE_FLAGS
    hWndOwner : HWND
    lpszCaption : PSTR
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    hInstance : HINSTANCE
    lpszTemplate : PSTR
    hResource : HRSRC
    lpOFN : OPENFILENAMEA.Ptr
    dwReserved1 : UInt32[4]
    lpOleUILinkContainer : IOleUILinkContainerA
    dwLink : UInt32
    lpszDisplayName : PSTR
    nFileLength : UInt32
    lpszFrom : PSTR
    lpszTo : PSTR
}
struct IOleUIObjInfoW extends IUnknown {
    GetObjectInfo(dwObject, lpdwObjSize, lplpszLabel?, lplpszType?, lplpszShortType?, lplpszLocation?)
      => ComCall(3, this.p, UInt32, dwObject, UInt32.Ptr, lpdwObjSize, PWSTR.Ptr, lplpszLabel?, PWSTR.Ptr, lplpszType?, PWSTR.Ptr, lplpszShortType?, PWSTR.Ptr, lplpszLocation?)
    GetConvertInfo(dwObject, lpClassID, lpwFormat, lpConvertDefaultClassID, lplpClsidExclude, lpcClsidExclude?)
      => ComCall(4, this.p, UInt32, dwObject, GUID.Ptr, lpClassID, UInt16.Ptr, lpwFormat, GUID.Ptr, lpConvertDefaultClassID, GUID.Ptr.Ptr, lplpClsidExclude, UInt32.Ptr, lpcClsidExclude?)
    ConvertObject(dwObject, clsidNew)
      => ComCall(5, this.p, UInt32, dwObject, GUID.Ptr, clsidNew)
    GetViewInfo(dwObject, phMetaPict?, pdvAspect?, pnCurrentScale?)
      => ComCall(6, this.p, UInt32, dwObject, HGLOBAL.Ptr, phMetaPict?, UInt32.Ptr, pdvAspect?, Int32.Ptr, pnCurrentScale?)
    SetViewInfo(dwObject, hMetaPict, dvAspect, nCurrentScale, bRelativeToOrig)
      => ComCall(7, this.p, UInt32, dwObject, HGLOBAL, hMetaPict, UInt32, dvAspect, Int32, nCurrentScale, BOOL, bRelativeToOrig)
}
struct IOleUIObjInfoA extends IUnknown {
    GetObjectInfo(dwObject, lpdwObjSize, lplpszLabel?, lplpszType?, lplpszShortType?, lplpszLocation?)
      => ComCall(3, this.p, UInt32, dwObject, UInt32.Ptr, lpdwObjSize, PSTR.Ptr, lplpszLabel?, PSTR.Ptr, lplpszType?, PSTR.Ptr, lplpszShortType?, PSTR.Ptr, lplpszLocation?)
    GetConvertInfo(dwObject, lpClassID, lpwFormat, lpConvertDefaultClassID, lplpClsidExclude, lpcClsidExclude?)
      => ComCall(4, this.p, UInt32, dwObject, GUID.Ptr, lpClassID, UInt16.Ptr, lpwFormat, GUID.Ptr, lpConvertDefaultClassID, GUID.Ptr.Ptr, lplpClsidExclude, UInt32.Ptr, lpcClsidExclude?)
    ConvertObject(dwObject, clsidNew)
      => ComCall(5, this.p, UInt32, dwObject, GUID.Ptr, clsidNew)
    GetViewInfo(dwObject, phMetaPict?, pdvAspect?, pnCurrentScale?)
      => ComCall(6, this.p, UInt32, dwObject, HGLOBAL.Ptr, phMetaPict?, UInt32.Ptr, pdvAspect?, Int32.Ptr, pnCurrentScale?)
    SetViewInfo(dwObject, hMetaPict, dvAspect, nCurrentScale, bRelativeToOrig)
      => ComCall(7, this.p, UInt32, dwObject, HGLOBAL, hMetaPict, UInt32, dvAspect, Int32, nCurrentScale, BOOL, bRelativeToOrig)
}
struct IOleUILinkInfoW extends IOleUILinkContainerW {
    GetLastUpdate(dwLink, lpLastUpdate)
      => ComCall(11, this.p, UInt32, dwLink, FILETIME.Ptr, lpLastUpdate)
}
struct IOleUILinkInfoA extends IOleUILinkContainerA {
    GetLastUpdate(dwLink, lpLastUpdate)
      => ComCall(11, this.p, UInt32, dwLink, FILETIME.Ptr, lpLastUpdate)
}
struct OLEUIGNRLPROPSW {
    cbStruct : UInt32
    dwFlags : UInt32
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSW.Ptr
}
struct OLEUIGNRLPROPSA {
    cbStruct : UInt32
    dwFlags : UInt32
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSA.Ptr
}
struct OLEUIVIEWPROPSW {
    cbStruct : UInt32
    dwFlags : VIEW_OBJECT_PROPERTIES_FLAGS
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSW.Ptr
    nScaleMin : Int32
    nScaleMax : Int32
}
struct OLEUIVIEWPROPSA {
    cbStruct : UInt32
    dwFlags : VIEW_OBJECT_PROPERTIES_FLAGS
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSA.Ptr
    nScaleMin : Int32
    nScaleMax : Int32
}
struct OLEUILINKPROPSW {
    cbStruct : UInt32
    dwFlags : UInt32
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSW.Ptr
}
struct OLEUILINKPROPSA {
    cbStruct : UInt32
    dwFlags : UInt32
    dwReserved1 : UInt32[2]
    lpfnHook : LPFNOLEUIHOOK
    lCustData : LPARAM
    dwReserved2 : UInt32[3]
    lpOP : OLEUIOBJECTPROPSA.Ptr
}
struct OLEUIOBJECTPROPSW {
    cbStruct : UInt32
    dwFlags : OBJECT_PROPERTIES_FLAGS
    lpPS : PROPSHEETHEADERW_V2.Ptr
    dwObject : UInt32
    lpObjInfo : IOleUIObjInfoW
    dwLink : UInt32
    lpLinkInfo : IOleUILinkInfoW
    lpGP : OLEUIGNRLPROPSW.Ptr
    lpVP : OLEUIVIEWPROPSW.Ptr
    lpLP : OLEUILINKPROPSW.Ptr
}
struct OLEUIOBJECTPROPSA {
    cbStruct : UInt32
    dwFlags : OBJECT_PROPERTIES_FLAGS
    lpPS : PROPSHEETHEADERA_V2.Ptr
    dwObject : UInt32
    lpObjInfo : IOleUIObjInfoA
    dwLink : UInt32
    lpLinkInfo : IOleUILinkInfoA
    lpGP : OLEUIGNRLPROPSA.Ptr
    lpVP : OLEUIVIEWPROPSA.Ptr
    lpLP : OLEUILINKPROPSA.Ptr
}
struct IDispatchEx extends IDispatch {
    static IID := "{A6EF9860-C720-11D0-9337-00A0C90DCAA9}"
    GetDispID(bstrName, grfdex, pid)
      => ComCall(7, this.p, BSTR, bstrName, UInt32, grfdex, Int32.Ptr, pid)
    InvokeEx(id, lcid, wFlags, pdp, pvarRes?, pei?, pspCaller?)
      => ComCall(8, this.p, Int32, id, UInt32, lcid, UInt16, wFlags, DISPPARAMS.Ptr, pdp, VARIANT.Ptr, pvarRes?, EXCEPINFO.Ptr, pei?, IServiceProvider, pspCaller?)
    DeleteMemberByName(bstrName, grfdex)
      => ComCall(9, this.p, BSTR, bstrName, UInt32, grfdex)
    DeleteMemberByDispID(id)
      => ComCall(10, this.p, Int32, id)
    GetMemberProperties(id, grfdexFetch, pgrfdex)
      => ComCall(11, this.p, Int32, id, UInt32, grfdexFetch, FDEX_PROP_FLAGS.Ptr, pgrfdex)
    GetMemberName(id, pbstrName)
      => ComCall(12, this.p, Int32, id, BSTR.Ptr, pbstrName)
    GetNextDispID(grfdex, id, pid)
      => ComCall(13, this.p, UInt32, grfdex, Int32, id, Int32.Ptr, pid)
    GetNameSpaceParent(ppunk)
      => ComCall(14, this.p, IUnknown.Ptr, ppunk)
}
struct IDispError extends IUnknown {
    static IID := "{A6EF9861-C720-11D0-9337-00A0C90DCAA9}"
    QueryErrorInfo(guidErrorType, ppde)
      => ComCall(3, this.p, GUID, guidErrorType, IDispError.Ptr, ppde)
    GetNext(ppde)
      => ComCall(4, this.p, IDispError.Ptr, ppde)
    GetHresult(phr)
      => ComCall(5, this.p, HRESULT.Ptr, phr)
    GetSource(pbstrSource)
      => ComCall(6, this.p, BSTR.Ptr, pbstrSource)
    GetHelpInfo(pbstrFileName, pdwContext)
      => ComCall(7, this.p, BSTR.Ptr, pbstrFileName, UInt32.Ptr, pdwContext)
    GetDescription(pbstrDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDescription)
}
struct IVariantChangeType extends IUnknown {
    static IID := "{A6EF9862-C720-11D0-9337-00A0C90DCAA9}"
    ChangeType(pvarDst, pvarSrc, lcid, vtNew)
      => ComCall(3, this.p, VARIANT.Ptr, pvarDst, VARIANT.Ptr, pvarSrc, UInt32, lcid, VARENUM, vtNew)
}
struct IObjectIdentity extends IUnknown {
    static IID := "{CA04B7E6-0D21-11D1-8CC5-00C04FC2B085}"
    IsEqualObject(punk)
      => ComCall(3, this.p, IUnknown, punk)
}
struct ICanHandleException extends IUnknown {
    static IID := "{C5598E60-B307-11D1-B27D-006008C3FBFB}"
    CanHandleException(pExcepInfo, pvar)
      => ComCall(3, this.p, EXCEPINFO.Ptr, pExcepInfo, VARIANT.Ptr, pvar)
}
struct IProvideRuntimeContext extends IUnknown {
    static IID := "{10E2414A-EC59-49D2-BC51-5ADD2C36FEBC}"
    GetCurrentSourceContext(pdwContext, pfExecutingGlobalCode)
      => ComCall(3, this.p, IntPtr.Ptr, pdwContext, VARIANT_BOOL.Ptr, pfExecutingGlobalCode)
}
