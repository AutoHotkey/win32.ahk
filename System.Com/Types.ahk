#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HANDLE, HGLOBAL, HRESULT, HWND, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP, HENHMETAFILE}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}
#Import "..\System.Ole\Types.ahk" {ARRAYDESC, PARAMDESC}
#Import "..\System.SystemServices\Types.ahk" {userHBITMAP, userHENHMETAFILE, userHGLOBAL, userHMETAFILEPICT, userHPALETTE}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}

struct LPEXCEPFINO_DEFERRED_FILLIN extends FunctionPointer {
    static Types := [EXCEPINFO.Ptr, HRESULT]
}
struct URI_CREATE_FLAGS extends UInt32 {
    static Uri_CREATE_ALLOW_RELATIVE := 1
    static Uri_CREATE_ALLOW_IMPLICIT_WILDCARD_SCHEME := 2
    static Uri_CREATE_ALLOW_IMPLICIT_FILE_SCHEME := 4
    static Uri_CREATE_NOFRAG := 8
    static Uri_CREATE_NO_CANONICALIZE := 16
    static Uri_CREATE_CANONICALIZE := 256
    static Uri_CREATE_FILE_USE_DOS_PATH := 32
    static Uri_CREATE_DECODE_EXTRA_INFO := 64
    static Uri_CREATE_NO_DECODE_EXTRA_INFO := 128
    static Uri_CREATE_CRACK_UNKNOWN_SCHEMES := 512
    static Uri_CREATE_NO_CRACK_UNKNOWN_SCHEMES := 1024
    static Uri_CREATE_PRE_PROCESS_HTML_URI := 2048
    static Uri_CREATE_NO_PRE_PROCESS_HTML_URI := 4096
    static Uri_CREATE_IE_SETTINGS := 8192
    static Uri_CREATE_NO_IE_SETTINGS := 16384
    static Uri_CREATE_NO_ENCODE_FORBIDDEN_CHARACTERS := 32768
    static Uri_CREATE_NORMALIZE_INTL_CHARACTERS := 65536
    static Uri_CREATE_CANONICALIZE_ABSOLUTE := 131072
}
struct RPC_C_AUTHN_LEVEL extends UInt32 {
    static RPC_C_AUTHN_LEVEL_DEFAULT := 0
    static RPC_C_AUTHN_LEVEL_NONE := 1
    static RPC_C_AUTHN_LEVEL_CONNECT := 2
    static RPC_C_AUTHN_LEVEL_CALL := 3
    static RPC_C_AUTHN_LEVEL_PKT := 4
    static RPC_C_AUTHN_LEVEL_PKT_INTEGRITY := 5
    static RPC_C_AUTHN_LEVEL_PKT_PRIVACY := 6
}
struct RPC_C_IMP_LEVEL extends UInt32 {
    static RPC_C_IMP_LEVEL_DEFAULT := 0
    static RPC_C_IMP_LEVEL_ANONYMOUS := 1
    static RPC_C_IMP_LEVEL_IDENTIFY := 2
    static RPC_C_IMP_LEVEL_IMPERSONATE := 3
    static RPC_C_IMP_LEVEL_DELEGATE := 4
}
struct ROT_FLAGS extends UInt32 {
    static ROTFLAGS_REGISTRATIONKEEPSALIVE := 1
    static ROTFLAGS_ALLOWANYCLIENT := 2
}
struct ADVANCED_FEATURE_FLAGS extends UInt16 {
    static FADF_AUTO := 1
    static FADF_STATIC := 2
    static FADF_EMBEDDED := 4
    static FADF_FIXEDSIZE := 16
    static FADF_RECORD := 32
    static FADF_HAVEIID := 64
    static FADF_HAVEVARTYPE := 128
    static FADF_BSTR := 256
    static FADF_UNKNOWN := 512
    static FADF_DISPATCH := 1024
    static FADF_VARIANT := 2048
    static FADF_RESERVED := 61448
}
struct IMPLTYPEFLAGS extends Int32 {
    static IMPLTYPEFLAG_FDEFAULT := 1
    static IMPLTYPEFLAG_FSOURCE := 2
    static IMPLTYPEFLAG_FRESTRICTED := 4
    static IMPLTYPEFLAG_FDEFAULTVTABLE := 8
}
struct IDLFLAGS extends UInt16 {
    static IDLFLAG_NONE := 0
    static IDLFLAG_FIN := 1
    static IDLFLAG_FOUT := 2
    static IDLFLAG_FLCID := 4
    static IDLFLAG_FRETVAL := 8
}
struct DISPATCH_FLAGS extends UInt16 {
    static DISPATCH_METHOD := 1
    static DISPATCH_PROPERTYGET := 2
    static DISPATCH_PROPERTYPUT := 4
    static DISPATCH_PROPERTYPUTREF := 8
}
struct STGM extends UInt32 {
    static STGM_DIRECT := 0
    static STGM_TRANSACTED := 65536
    static STGM_SIMPLE := 134217728
    static STGM_READ := 0
    static STGM_WRITE := 1
    static STGM_READWRITE := 2
    static STGM_SHARE_DENY_NONE := 64
    static STGM_SHARE_DENY_READ := 48
    static STGM_SHARE_DENY_WRITE := 32
    static STGM_SHARE_EXCLUSIVE := 16
    static STGM_PRIORITY := 262144
    static STGM_DELETEONRELEASE := 67108864
    static STGM_NOSCRATCH := 1048576
    static STGM_CREATE := 4096
    static STGM_CONVERT := 131072
    static STGM_FAILIFTHERE := 0
    static STGM_NOSNAPSHOT := 2097152
    static STGM_DIRECT_SWMR := 4194304
}
struct DVASPECT extends UInt32 {
    static DVASPECT_CONTENT := 1
    static DVASPECT_THUMBNAIL := 2
    static DVASPECT_ICON := 4
    static DVASPECT_DOCPRINT := 8
    static DVASPECT_OPAQUE := 16
    static DVASPECT_TRANSPARENT := 32
}
struct CO_MTA_USAGE_COOKIE {
    Value : Struct.Ptr
}
struct CO_DEVICE_CATALOG_COOKIE {
    Value : Struct.Ptr
}
struct MachineGlobalObjectTableRegistrationToken {
    Value : Struct.Ptr
}
struct STGC extends Int32 {
    static STGC_DEFAULT := 0
    static STGC_OVERWRITE := 1
    static STGC_ONLYIFCURRENT := 2
    static STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE := 4
    static STGC_CONSOLIDATE := 8
}
struct STATFLAG extends Int32 {
    static STATFLAG_DEFAULT := 0
    static STATFLAG_NONAME := 1
    static STATFLAG_NOOPEN := 2
}
struct CY {
    union {
        Anonymous : this._Anonymous_e__Struct
        int64 : Int64
    }
    struct _Anonymous_e__Struct {
        Lo : UInt32
        Hi : Int32
    }
}
struct CSPLATFORM {
    dwPlatformId : UInt32
    dwVersionHi : UInt32
    dwVersionLo : UInt32
    dwProcessorArch : UInt32
}
struct QUERYCONTEXT {
    dwContext : UInt32
    Platform : CSPLATFORM
    Locale : UInt32
    dwVersionHi : UInt32
    dwVersionLo : UInt32
}
struct TYSPEC extends Int32 {
    static TYSPEC_CLSID := 0
    static TYSPEC_FILEEXT := 1
    static TYSPEC_MIMETYPE := 2
    static TYSPEC_FILENAME := 3
    static TYSPEC_PROGID := 4
    static TYSPEC_PACKAGENAME := 5
    static TYSPEC_OBJECTID := 6
}
struct uCLSSPEC {
    tyspec : UInt32
    tagged_union : this._tagged_union_e__Struct
    struct _tagged_union_e__Struct {
        union {
            clsid : GUID
            pFileExt : PWSTR
            pMimeType : PWSTR
            pProgId : PWSTR
            pFileName : PWSTR
            ByName : this._ByName_e__Struct
            ByObjectId : this._ByObjectId_e__Struct
        }
        struct _ByName_e__Struct {
            pPackageName : PWSTR
            PolicyId : GUID
        }
        struct _ByObjectId_e__Struct {
            ObjectId : GUID
            PolicyId : GUID
        }
    }
}
struct REGCLS extends Int32 {
    static REGCLS_SINGLEUSE := 0
    static REGCLS_MULTIPLEUSE := 1
    static REGCLS_MULTI_SEPARATE := 2
    static REGCLS_SUSPENDED := 4
    static REGCLS_SURROGATE := 8
    static REGCLS_AGILE := 16
}
struct COINITBASE extends Int32 {
    static COINITBASE_MULTITHREADED := 0
}
struct COAUTHIDENTITY {
    User : UInt16.Ptr
    UserLength : UInt32
    Domain : UInt16.Ptr
    DomainLength : UInt32
    Password : UInt16.Ptr
    PasswordLength : UInt32
    Flags : UInt32
}
struct COAUTHINFO {
    dwAuthnSvc : UInt32
    dwAuthzSvc : UInt32
    pwszServerPrincName : PWSTR
    dwAuthnLevel : UInt32
    dwImpersonationLevel : UInt32
    pAuthIdentityData : COAUTHIDENTITY.Ptr
    dwCapabilities : UInt32
}
struct MEMCTX extends Int32 {
    static MEMCTX_TASK := 1
    static MEMCTX_SHARED := 2
    static MEMCTX_MACSYSTEM := 3
    static MEMCTX_UNKNOWN := -1
    static MEMCTX_SAME := -2
}
struct CLSCTX extends UInt32 {
    static CLSCTX_INPROC_SERVER := 1
    static CLSCTX_INPROC_HANDLER := 2
    static CLSCTX_LOCAL_SERVER := 4
    static CLSCTX_INPROC_SERVER16 := 8
    static CLSCTX_REMOTE_SERVER := 16
    static CLSCTX_INPROC_HANDLER16 := 32
    static CLSCTX_RESERVED1 := 64
    static CLSCTX_RESERVED2 := 128
    static CLSCTX_RESERVED3 := 256
    static CLSCTX_RESERVED4 := 512
    static CLSCTX_NO_CODE_DOWNLOAD := 1024
    static CLSCTX_RESERVED5 := 2048
    static CLSCTX_NO_CUSTOM_MARSHAL := 4096
    static CLSCTX_ENABLE_CODE_DOWNLOAD := 8192
    static CLSCTX_NO_FAILURE_LOG := 16384
    static CLSCTX_DISABLE_AAA := 32768
    static CLSCTX_ENABLE_AAA := 65536
    static CLSCTX_FROM_DEFAULT_CONTEXT := 131072
    static CLSCTX_ACTIVATE_X86_SERVER := 262144
    static CLSCTX_ACTIVATE_32_BIT_SERVER := 262144
    static CLSCTX_ACTIVATE_64_BIT_SERVER := 524288
    static CLSCTX_ENABLE_CLOAKING := 1048576
    static CLSCTX_APPCONTAINER := 4194304
    static CLSCTX_ACTIVATE_AAA_AS_IU := 8388608
    static CLSCTX_RESERVED6 := 16777216
    static CLSCTX_ACTIVATE_ARM32_SERVER := 33554432
    static CLSCTX_ALLOW_LOWER_TRUST_REGISTRATION := 67108864
    static CLSCTX_SERVER_MUST_BE_EQUAL_OR_GREATER_PRIVILEGE := 134217728
    static CLSCTX_DO_NOT_ELEVATE_SERVER := 268435456
    static CLSCTX_PS_DLL := 2147483648
    static CLSCTX_ALL := 23
    static CLSCTX_SERVER := 21
}
struct MSHLFLAGS extends Int32 {
    static MSHLFLAGS_NORMAL := 0
    static MSHLFLAGS_TABLESTRONG := 1
    static MSHLFLAGS_TABLEWEAK := 2
    static MSHLFLAGS_NOPING := 4
    static MSHLFLAGS_RESERVED1 := 8
    static MSHLFLAGS_RESERVED2 := 16
    static MSHLFLAGS_RESERVED3 := 32
    static MSHLFLAGS_RESERVED4 := 64
}
struct MSHCTX extends Int32 {
    static MSHCTX_LOCAL := 0
    static MSHCTX_NOSHAREDMEM := 1
    static MSHCTX_DIFFERENTMACHINE := 2
    static MSHCTX_INPROC := 3
    static MSHCTX_CROSSCTX := 4
    static MSHCTX_CONTAINER := 5
}
struct BYTE_BLOB {
    clSize : UInt32
    abData : UInt8[1]
}
struct WORD_BLOB {
    clSize : UInt32
    asData : UInt16[1]
}
struct DWORD_BLOB {
    clSize : UInt32
    alData : UInt32[1]
}
struct FLAGGED_BYTE_BLOB {
    fFlags : UInt32
    clSize : UInt32
    abData : UInt8[1]
}
struct FLAGGED_WORD_BLOB {
    fFlags : UInt32
    clSize : UInt32
    asData : UInt16[1]
}
struct BYTE_SIZEDARR {
    clSize : UInt32
    pData : UInt8.Ptr
}
struct WORD_SIZEDARR {
    clSize : UInt32
    pData : UInt16.Ptr
}
struct DWORD_SIZEDARR {
    clSize : UInt32
    pData : UInt32.Ptr
}
struct HYPER_SIZEDARR {
    clSize : UInt32
    pData : Int64.Ptr
}
struct BLOB {
    cbSize : UInt32
    pBlobData : UInt8.Ptr
}
#Import Export "..\IUnknown.ahk" {IUnknown}
struct AsyncIUnknown extends IUnknown {
    static IID := "{000E0000-0000-0000-C000-000000000046}"
    Begin_QueryInterface(riid)
      => ComCall(3, this.p, GUID.Ptr, riid)
    Finish_QueryInterface(ppvObject)
      => ComCall(4, this.p, Struct.Ptr.Ptr, ppvObject)
    Begin_AddRef()
      => ComCall(5, this.p)
    Finish_AddRef()
      => ComCall(6, this.p, UInt32)
    Begin_Release()
      => ComCall(7, this.p)
    Finish_Release()
      => ComCall(8, this.p, UInt32)
}
struct IClassFactory extends IUnknown {
    static IID := "{00000001-0000-0000-C000-000000000046}"
    CreateInstance(pUnkOuter?, riid, ppvObject)
      => ComCall(3, this.p, IUnknown, pUnkOuter?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    LockServer(fLock)
      => ComCall(4, this.p, BOOL, fLock)
}
struct COSERVERINFO {
    dwReserved1 : UInt32
    pwszName : PWSTR
    pAuthInfo : COAUTHINFO.Ptr
    dwReserved2 : UInt32
}
struct INoMarshal extends IUnknown {
    static IID := "{ECC8691B-C1DB-4DC0-855E-65F6C551AF49}"
}
struct IAgileObject extends IUnknown {
    static IID := "{94EA2B94-E9CC-49E0-C0FF-EE64CA8F5B90}"
}
struct IActivationFilter extends IUnknown {
    static IID := "{00000017-0000-0000-C000-000000000046}"
    HandleActivation(dwActivationType, rclsid, pReplacementClsId)
      => ComCall(3, this.p, UInt32, dwActivationType, GUID.Ptr, rclsid, GUID.Ptr, pReplacementClsId)
}
struct IMalloc extends IUnknown {
    static IID := "{00000002-0000-0000-C000-000000000046}"
    Alloc(cb)
      => ComCall(3, this.p, IntPtr, cb, Struct.Ptr)
    Realloc(pv?, cb)
      => ComCall(4, this.p, Struct.Ptr, pv?, IntPtr, cb, Struct.Ptr)
    Free(pv?)
      => ComCall(5, this.p, Struct.Ptr, pv?, "void")
    GetSize(pv?)
      => ComCall(6, this.p, Struct.Ptr, pv?, IntPtr)
    DidAlloc(pv?)
      => ComCall(7, this.p, Struct.Ptr, pv?, Int32)
    HeapMinimize()
      => ComCall(8, this.p, "void")
}
struct IStdMarshalInfo extends IUnknown {
    static IID := "{00000018-0000-0000-C000-000000000046}"
    GetClassForHandler(dwDestContext, pClsid)
      => ComCall(3, this.p, UInt32, dwDestContext, "Ptr", 0, GUID.Ptr, pClsid)
}
struct EXTCONN extends Int32 {
    static EXTCONN_STRONG := 1
    static EXTCONN_WEAK := 2
    static EXTCONN_CALLABLE := 4
}
struct IExternalConnection extends IUnknown {
    static IID := "{00000019-0000-0000-C000-000000000046}"
    AddConnection(extconn, reserved)
      => ComCall(3, this.p, UInt32, extconn, UInt32, reserved, UInt32)
    ReleaseConnection(extconn, reserved, fLastReleaseCloses)
      => ComCall(4, this.p, UInt32, extconn, UInt32, reserved, BOOL, fLastReleaseCloses, UInt32)
}
struct MULTI_QI {
    pIID : GUID.Ptr
    pItf : IUnknown
    hr : HRESULT
}
struct IMultiQI extends IUnknown {
    static IID := "{00000020-0000-0000-C000-000000000046}"
    QueryMultipleInterfaces(pMQIs)
      => ComCall(3, this.p, UInt32, pMQIs.Length, MULTI_QI.Ptr, pMQIs)
}
struct AsyncIMultiQI extends IUnknown {
    static IID := "{000E0020-0000-0000-C000-000000000046}"
    Begin_QueryMultipleInterfaces(pMQIs)
      => ComCall(3, this.p, UInt32, pMQIs.Length, MULTI_QI.Ptr, pMQIs)
    Finish_QueryMultipleInterfaces(pMQIs)
      => ComCall(4, this.p, MULTI_QI.Ptr, pMQIs)
}
struct IInternalUnknown extends IUnknown {
    static IID := "{00000021-0000-0000-C000-000000000046}"
    QueryInternalInterface(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IEnumUnknown extends IUnknown {
    static IID := "{00000100-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, IUnknown.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumUnknown.Ptr, ppenum)
}
struct IEnumString extends IUnknown {
    static IID := "{00000101-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, PWSTR.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumString.Ptr, ppenum)
}
struct ISequentialStream extends IUnknown {
    static IID := "{0C733A30-2A1C-11CE-ADE5-00AA0044773D}"
    Read(pv, pcbRead?)
      => ComCall(3, this.p, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbRead?)
    Write(pv, pcbWritten?)
      => ComCall(4, this.p, Struct.Ptr, pv, UInt32, pv.Size, UInt32.Ptr, pcbWritten?)
}
struct STATSTG {
    pwcsName : PWSTR
    type : UInt32
    cbSize : Int64 := this.Size
    mtime : FILETIME
    ctime : FILETIME
    atime : FILETIME
    grfMode : STGM
    grfLocksSupported : UInt32
    clsid : GUID
    grfStateBits : UInt32
    reserved : UInt32
}
struct STGTY extends Int32 {
    static STGTY_STORAGE := 1
    static STGTY_STREAM := 2
    static STGTY_LOCKBYTES := 3
    static STGTY_PROPERTY := 4
}
struct STREAM_SEEK extends UInt32 {
    static STREAM_SEEK_SET := 0
    static STREAM_SEEK_CUR := 1
    static STREAM_SEEK_END := 2
}
struct LOCKTYPE extends Int32 {
    static LOCK_WRITE := 1
    static LOCK_EXCLUSIVE := 2
    static LOCK_ONLYONCE := 4
}
struct IStream extends ISequentialStream {
    static IID := "{0000000C-0000-0000-C000-000000000046}"
    Seek(dlibMove, dwOrigin, plibNewPosition?)
      => ComCall(5, this.p, Int64, dlibMove, STREAM_SEEK, dwOrigin, Int64.Ptr, plibNewPosition?)
    SetSize(libNewSize)
      => ComCall(6, this.p, Int64, libNewSize)
    CopyTo(pstm, cb, pcbRead?, pcbWritten?)
      => ComCall(7, this.p, IStream, pstm, Int64, cb, Int64.Ptr, pcbRead?, Int64.Ptr, pcbWritten?)
    Commit(grfCommitFlags)
      => ComCall(8, this.p, UInt32, grfCommitFlags)
    Revert()
      => ComCall(9, this.p)
    LockRegion(libOffset, cb, dwLockType)
      => ComCall(10, this.p, Int64, libOffset, Int64, cb, UInt32, dwLockType)
    UnlockRegion(libOffset, cb, dwLockType)
      => ComCall(11, this.p, Int64, libOffset, Int64, cb, UInt32, dwLockType)
    Stat(pstatstg, grfStatFlag)
      => ComCall(12, this.p, STATSTG.Ptr, pstatstg, UInt32, grfStatFlag)
    Clone(ppstm)
      => ComCall(13, this.p, IStream.Ptr, ppstm)
}
struct RPCOLEMESSAGE {
    reserved1 : Struct.Ptr
    dataRepresentation : UInt32
    Buffer : Struct.Ptr
    cbBuffer : UInt32
    iMethod : UInt32
    reserved2 : Struct.Ptr[5]
    rpcFlags : UInt32
}
struct IRpcChannelBuffer extends IUnknown {
    static IID := "{D5F56B60-593B-101A-B569-08002B2DBF7A}"
    GetBuffer(pMessage, riid)
      => ComCall(3, this.p, RPCOLEMESSAGE.Ptr, pMessage, GUID.Ptr, riid)
    SendReceive(pMessage, pStatus?)
      => ComCall(4, this.p, RPCOLEMESSAGE.Ptr, pMessage, UInt32.Ptr, pStatus?)
    FreeBuffer(pMessage)
      => ComCall(5, this.p, RPCOLEMESSAGE.Ptr, pMessage)
    GetDestCtx(pdwDestContext, ppvDestContext)
      => ComCall(6, this.p, UInt32.Ptr, pdwDestContext, Struct.Ptr.Ptr, ppvDestContext)
    IsConnected()
      => ComCall(7, this.p)
}
struct IRpcChannelBuffer2 extends IRpcChannelBuffer {
    static IID := "{594F31D0-7F19-11D0-B194-00A0C90DC8BF}"
    GetProtocolVersion(pdwVersion)
      => ComCall(8, this.p, UInt32.Ptr, pdwVersion)
}
struct IAsyncRpcChannelBuffer extends IRpcChannelBuffer2 {
    static IID := "{A5029FB6-3C34-11D1-9C99-00C04FB998AA}"
    Send(pMsg, pSync, pulStatus)
      => ComCall(9, this.p, RPCOLEMESSAGE.Ptr, pMsg, ISynchronize, pSync, UInt32.Ptr, pulStatus)
    Receive(pMsg, pulStatus)
      => ComCall(10, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32.Ptr, pulStatus)
    GetDestCtxEx(pMsg, pdwDestContext, ppvDestContext?)
      => ComCall(11, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32.Ptr, pdwDestContext, Struct.Ptr.Ptr, ppvDestContext?)
}
struct IRpcChannelBuffer3 extends IRpcChannelBuffer2 {
    static IID := "{25B15600-0115-11D0-BF0D-00AA00B8DFD2}"
    Send(pMsg, pulStatus)
      => ComCall(9, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32.Ptr, pulStatus)
    Receive(pMsg, ulSize, pulStatus)
      => ComCall(10, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32, ulSize, UInt32.Ptr, pulStatus)
    Cancel(pMsg)
      => ComCall(11, this.p, RPCOLEMESSAGE.Ptr, pMsg)
    GetCallContext(pMsg, riid, pInterface)
      => ComCall(12, this.p, RPCOLEMESSAGE.Ptr, pMsg, GUID.Ptr, riid, Struct.Ptr.Ptr, pInterface)
    GetDestCtxEx(pMsg, pdwDestContext, ppvDestContext?)
      => ComCall(13, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32.Ptr, pdwDestContext, Struct.Ptr.Ptr, ppvDestContext?)
    GetState(pMsg, pState)
      => ComCall(14, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32.Ptr, pState)
    RegisterAsync(pMsg, pAsyncMgr)
      => ComCall(15, this.p, RPCOLEMESSAGE.Ptr, pMsg, IAsyncManager, pAsyncMgr)
}
struct IRpcSyntaxNegotiate extends IUnknown {
    static IID := "{58A08519-24C8-4935-B482-3FD823333A4F}"
    NegotiateSyntax(pMsg)
      => ComCall(3, this.p, RPCOLEMESSAGE.Ptr, pMsg)
}
struct IRpcProxyBuffer extends IUnknown {
    static IID := "{D5F56A34-593B-101A-B569-08002B2DBF7A}"
    Connect(pRpcChannelBuffer)
      => ComCall(3, this.p, IRpcChannelBuffer, pRpcChannelBuffer)
    Disconnect()
      => ComCall(4, this.p, "void")
}
struct IRpcStubBuffer extends IUnknown {
    static IID := "{D5F56AFC-593B-101A-B569-08002B2DBF7A}"
    Connect(pUnkServer)
      => ComCall(3, this.p, IUnknown, pUnkServer)
    Disconnect()
      => ComCall(4, this.p, "void")
    Invoke(_prpcmsg, _pRpcChannelBuffer)
      => ComCall(5, this.p, RPCOLEMESSAGE.Ptr, _prpcmsg, IRpcChannelBuffer, _pRpcChannelBuffer)
    IsIIDSupported(riid)
      => ComCall(6, this.p, GUID.Ptr, riid, IRpcStubBuffer)
    CountRefs()
      => ComCall(7, this.p, UInt32)
    DebugServerQueryInterface(ppv)
      => ComCall(8, this.p, Struct.Ptr.Ptr, ppv)
    DebugServerRelease(pv)
      => ComCall(9, this.p, Struct.Ptr, pv, "void")
}
struct IPSFactoryBuffer extends IUnknown {
    static IID := "{D5F569D0-593B-101A-B569-08002B2DBF7A}"
    CreateProxy(pUnkOuter, riid, ppProxy, ppv)
      => ComCall(3, this.p, IUnknown, pUnkOuter, GUID.Ptr, riid, IRpcProxyBuffer.Ptr, ppProxy, Struct.Ptr.Ptr, ppv)
    CreateStub(riid, pUnkServer?, ppStub)
      => ComCall(4, this.p, GUID.Ptr, riid, IUnknown, pUnkServer?, IRpcStubBuffer.Ptr, ppStub)
}
struct SChannelHookCallInfo {
    iid : GUID
    cbSize : UInt32 := this.Size
    uCausality : GUID
    dwServerPid : UInt32
    iMethod : UInt32
    pObject : Struct.Ptr
}
struct IChannelHook extends IUnknown {
    static IID := "{1008C4A0-7613-11CF-9AF1-0020AF6E72F4}"
    ClientGetSize(uExtent, riid, pDataSize)
      => ComCall(3, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, UInt32.Ptr, pDataSize, "void")
    ClientFillBuffer(uExtent, riid, pDataSize, pDataBuffer)
      => ComCall(4, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, UInt32.Ptr, pDataSize, Struct.Ptr, pDataBuffer, "void")
    ClientNotify(uExtent, riid, cbDataSize, pDataBuffer, lDataRep, hrFault)
      => ComCall(5, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, UInt32, cbDataSize, Struct.Ptr, pDataBuffer, UInt32, lDataRep, HRESULT, hrFault, "void")
    ServerNotify(uExtent, riid, cbDataSize, pDataBuffer, lDataRep)
      => ComCall(6, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, UInt32, cbDataSize, Struct.Ptr, pDataBuffer, UInt32, lDataRep, "void")
    ServerGetSize(uExtent, riid, hrFault, pDataSize)
      => ComCall(7, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, HRESULT, hrFault, UInt32.Ptr, pDataSize, "void")
    ServerFillBuffer(uExtent, riid, pDataSize, pDataBuffer, hrFault)
      => ComCall(8, this.p, GUID.Ptr, uExtent, GUID.Ptr, riid, UInt32.Ptr, pDataSize, Struct.Ptr, pDataBuffer, HRESULT, hrFault, "void")
}
struct SOLE_AUTHENTICATION_SERVICE {
    dwAuthnSvc : UInt32
    dwAuthzSvc : UInt32
    pPrincipalName : PWSTR
    hr : HRESULT
}
struct EOLE_AUTHENTICATION_CAPABILITIES extends Int32 {
    static EOAC_NONE := 0
    static EOAC_MUTUAL_AUTH := 1
    static EOAC_STATIC_CLOAKING := 32
    static EOAC_DYNAMIC_CLOAKING := 64
    static EOAC_ANY_AUTHORITY := 128
    static EOAC_MAKE_FULLSIC := 256
    static EOAC_DEFAULT := 2048
    static EOAC_SECURE_REFS := 2
    static EOAC_ACCESS_CONTROL := 4
    static EOAC_APPID := 8
    static EOAC_DYNAMIC := 16
    static EOAC_REQUIRE_FULLSIC := 512
    static EOAC_AUTO_IMPERSONATE := 1024
    static EOAC_DISABLE_AAA := 4096
    static EOAC_NO_CUSTOM_MARSHAL := 8192
    static EOAC_RESERVED1 := 16384
}
struct SOLE_AUTHENTICATION_INFO {
    dwAuthnSvc : UInt32
    dwAuthzSvc : UInt32
    pAuthInfo : Struct.Ptr
}
struct SOLE_AUTHENTICATION_LIST {
    cAuthInfo : UInt32
    aAuthInfo : SOLE_AUTHENTICATION_INFO.Ptr
}
struct IClientSecurity extends IUnknown {
    static IID := "{0000013D-0000-0000-C000-000000000046}"
    QueryBlanket(pProxy, pAuthnSvc, pAuthzSvc?, pServerPrincName, pAuthnLevel?, pImpLevel?, pAuthInfo, pCapabilites?)
      => ComCall(3, this.p, IUnknown, pProxy, UInt32.Ptr, pAuthnSvc, UInt32.Ptr, pAuthzSvc?, UInt16.Ptr.Ptr, pServerPrincName, RPC_C_AUTHN_LEVEL.Ptr, pAuthnLevel?, RPC_C_IMP_LEVEL.Ptr, pImpLevel?, Struct.Ptr.Ptr, pAuthInfo, UInt32.Ptr, pCapabilites?)
    SetBlanket(pProxy, dwAuthnSvc, dwAuthzSvc, pServerPrincName?, dwAuthnLevel, dwImpLevel, pAuthInfo?, dwCapabilities)
      => ComCall(4, this.p, IUnknown, pProxy, UInt32, dwAuthnSvc, UInt32, dwAuthzSvc, "Str", pServerPrincName?, RPC_C_AUTHN_LEVEL, dwAuthnLevel, RPC_C_IMP_LEVEL, dwImpLevel, Struct.Ptr, pAuthInfo?, UInt32, dwCapabilities)
    CopyProxy(pProxy, ppCopy)
      => ComCall(5, this.p, IUnknown, pProxy, IUnknown.Ptr, ppCopy)
}
struct IServerSecurity extends IUnknown {
    static IID := "{0000013E-0000-0000-C000-000000000046}"
    QueryBlanket(pAuthnSvc?, pAuthzSvc?, pServerPrincName, pAuthnLevel?, pImpLevel?, pPrivs, pCapabilities?)
      => ComCall(3, this.p, UInt32.Ptr, pAuthnSvc?, UInt32.Ptr, pAuthzSvc?, UInt16.Ptr.Ptr, pServerPrincName, UInt32.Ptr, pAuthnLevel?, UInt32.Ptr, pImpLevel?, Struct.Ptr.Ptr, pPrivs, UInt32.Ptr, pCapabilities?)
    ImpersonateClient()
      => ComCall(4, this.p)
    RevertToSelf()
      => ComCall(5, this.p)
    IsImpersonating()
      => ComCall(6, this.p, BOOL)
}
struct RPCOPT_PROPERTIES extends Int32 {
    static COMBND_RPCTIMEOUT := 1
    static COMBND_SERVER_LOCALITY := 2
    static COMBND_RESERVED1 := 4
    static COMBND_RESERVED2 := 5
    static COMBND_RESERVED3 := 8
    static COMBND_RESERVED4 := 16
}
struct RPCOPT_SERVER_LOCALITY_VALUES extends Int32 {
    static SERVER_LOCALITY_PROCESS_LOCAL := 0
    static SERVER_LOCALITY_MACHINE_LOCAL := 1
    static SERVER_LOCALITY_REMOTE := 2
}
struct IRpcOptions extends IUnknown {
    static IID := "{00000144-0000-0000-C000-000000000046}"
    Set(pPrx, dwProperty, dwValue)
      => ComCall(3, this.p, IUnknown, pPrx, RPCOPT_PROPERTIES, dwProperty, IntPtr, dwValue)
    Query(pPrx, dwProperty, pdwValue)
      => ComCall(4, this.p, IUnknown, pPrx, RPCOPT_PROPERTIES, dwProperty, IntPtr.Ptr, pdwValue)
}
struct GLOBALOPT_PROPERTIES extends Int32 {
    static COMGLB_EXCEPTION_HANDLING := 1
    static COMGLB_APPID := 2
    static COMGLB_RPC_THREADPOOL_SETTING := 3
    static COMGLB_RO_SETTINGS := 4
    static COMGLB_UNMARSHALING_POLICY := 5
    static COMGLB_PROPERTIES_RESERVED1 := 6
    static COMGLB_PROPERTIES_RESERVED2 := 7
    static COMGLB_PROPERTIES_RESERVED3 := 8
}
struct GLOBALOPT_EH_VALUES extends Int32 {
    static COMGLB_EXCEPTION_HANDLE := 0
    static COMGLB_EXCEPTION_DONOT_HANDLE_FATAL := 1
    static COMGLB_EXCEPTION_DONOT_HANDLE := 1
    static COMGLB_EXCEPTION_DONOT_HANDLE_ANY := 2
}
struct GLOBALOPT_RPCTP_VALUES extends Int32 {
    static COMGLB_RPC_THREADPOOL_SETTING_DEFAULT_POOL := 0
    static COMGLB_RPC_THREADPOOL_SETTING_PRIVATE_POOL := 1
}
struct GLOBALOPT_RO_FLAGS extends Int32 {
    static COMGLB_STA_MODALLOOP_REMOVE_TOUCH_MESSAGES := 1
    static COMGLB_STA_MODALLOOP_SHARED_QUEUE_REMOVE_INPUT_MESSAGES := 2
    static COMGLB_STA_MODALLOOP_SHARED_QUEUE_DONOT_REMOVE_INPUT_MESSAGES := 4
    static COMGLB_FAST_RUNDOWN := 8
    static COMGLB_RESERVED1 := 16
    static COMGLB_RESERVED2 := 32
    static COMGLB_RESERVED3 := 64
    static COMGLB_STA_MODALLOOP_SHARED_QUEUE_REORDER_POINTER_MESSAGES := 128
    static COMGLB_RESERVED4 := 256
    static COMGLB_RESERVED5 := 512
    static COMGLB_RESERVED6 := 1024
}
struct GLOBALOPT_UNMARSHALING_POLICY_VALUES extends Int32 {
    static COMGLB_UNMARSHALING_POLICY_NORMAL := 0
    static COMGLB_UNMARSHALING_POLICY_STRONG := 1
    static COMGLB_UNMARSHALING_POLICY_HYBRID := 2
}
struct IGlobalOptions extends IUnknown {
    static IID := "{0000015B-0000-0000-C000-000000000046}"
    Set(dwProperty, dwValue)
      => ComCall(3, this.p, GLOBALOPT_PROPERTIES, dwProperty, IntPtr, dwValue)
    Query(dwProperty, pdwValue)
      => ComCall(4, this.p, GLOBALOPT_PROPERTIES, dwProperty, IntPtr.Ptr, pdwValue)
}
struct ISurrogate extends IUnknown {
    static IID := "{00000022-0000-0000-C000-000000000046}"
    LoadDllServer(Clsid)
      => ComCall(3, this.p, GUID.Ptr, Clsid)
    FreeSurrogate()
      => ComCall(4, this.p)
}
struct IGlobalInterfaceTable extends IUnknown {
    static IID := "{00000146-0000-0000-C000-000000000046}"
    RegisterInterfaceInGlobal(pUnk, riid, pdwCookie)
      => ComCall(3, this.p, IUnknown, pUnk, GUID.Ptr, riid, UInt32.Ptr, pdwCookie)
    RevokeInterfaceFromGlobal(dwCookie)
      => ComCall(4, this.p, UInt32, dwCookie)
    GetInterfaceFromGlobal(dwCookie, riid, ppv)
      => ComCall(5, this.p, UInt32, dwCookie, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct ISynchronize extends IUnknown {
    static IID := "{00000030-0000-0000-C000-000000000046}"
    Wait(dwFlags, dwMilliseconds)
      => ComCall(3, this.p, UInt32, dwFlags, UInt32, dwMilliseconds)
    Signal()
      => ComCall(4, this.p)
    Reset()
      => ComCall(5, this.p)
}
struct ISynchronizeHandle extends IUnknown {
    static IID := "{00000031-0000-0000-C000-000000000046}"
    GetHandle(ph)
      => ComCall(3, this.p, HANDLE.Ptr, ph)
}
struct ISynchronizeEvent extends ISynchronizeHandle {
    static IID := "{00000032-0000-0000-C000-000000000046}"
    SetEventHandle(ph)
      => ComCall(4, this.p, HANDLE.Ptr, ph)
}
struct ISynchronizeContainer extends IUnknown {
    static IID := "{00000033-0000-0000-C000-000000000046}"
    AddSynchronize(pSync)
      => ComCall(3, this.p, ISynchronize, pSync)
    WaitMultiple(dwFlags, dwTimeOut, ppSync)
      => ComCall(4, this.p, UInt32, dwFlags, UInt32, dwTimeOut, ISynchronize.Ptr, ppSync)
}
struct ISynchronizeMutex extends ISynchronize {
    static IID := "{00000025-0000-0000-C000-000000000046}"
    ReleaseMutex()
      => ComCall(6, this.p)
}
struct ICancelMethodCalls extends IUnknown {
    static IID := "{00000029-0000-0000-C000-000000000046}"
    Cancel(ulSeconds)
      => ComCall(3, this.p, UInt32, ulSeconds)
    TestCancel()
      => ComCall(4, this.p)
}
struct DCOM_CALL_STATE extends Int32 {
    static DCOM_NONE := 0
    static DCOM_CALL_COMPLETE := 1
    static DCOM_CALL_CANCELED := 2
}
struct IAsyncManager extends IUnknown {
    static IID := "{0000002A-0000-0000-C000-000000000046}"
    CompleteCall(Result)
      => ComCall(3, this.p, HRESULT, Result)
    GetCallContext(riid, pInterface)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, pInterface)
    GetState(pulStateFlags)
      => ComCall(5, this.p, UInt32.Ptr, pulStateFlags)
}
struct ICallFactory extends IUnknown {
    static IID := "{1C733A30-2A1C-11CE-ADE5-00AA0044773D}"
    CreateCall(riid, pCtrlUnk?, riid2, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, IUnknown, pCtrlUnk?, GUID.Ptr, riid2, IUnknown.Ptr, ppv)
}
struct IRpcHelper extends IUnknown {
    static IID := "{00000149-0000-0000-C000-000000000046}"
    GetDCOMProtocolVersion(pComVersion)
      => ComCall(3, this.p, UInt32.Ptr, pComVersion)
    GetIIDFromOBJREF(pObjRef, piid)
      => ComCall(4, this.p, Struct.Ptr, pObjRef, GUID.Ptr.Ptr, piid)
}
struct IReleaseMarshalBuffers extends IUnknown {
    static IID := "{EB0CB9E8-7996-11D2-872E-0000F8080859}"
    ReleaseMarshalBuffer(pMsg, dwFlags, pChnl?)
      => ComCall(3, this.p, RPCOLEMESSAGE.Ptr, pMsg, UInt32, dwFlags, IUnknown, pChnl?)
}
struct IWaitMultiple extends IUnknown {
    static IID := "{0000002B-0000-0000-C000-000000000046}"
    WaitMultiple(timeout, pSync)
      => ComCall(3, this.p, UInt32, timeout, ISynchronize.Ptr, pSync)
    AddSynchronize(pSync)
      => ComCall(4, this.p, ISynchronize, pSync)
}
struct IAddrTrackingControl extends IUnknown {
    static IID := "{00000147-0000-0000-C000-000000000046}"
    EnableCOMDynamicAddrTracking()
      => ComCall(3, this.p)
    DisableCOMDynamicAddrTracking()
      => ComCall(4, this.p)
}
struct IAddrExclusionControl extends IUnknown {
    static IID := "{00000148-0000-0000-C000-000000000046}"
    GetCurrentAddrExclusionList(riid, ppEnumerator)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppEnumerator)
    UpdateAddrExclusionList(pEnumerator)
      => ComCall(4, this.p, IUnknown, pEnumerator)
}
struct IPipeByte extends IUnknown {
    static IID := "{DB2F3ACA-2F86-11D1-8E04-00C04FB9989A}"
    Pull(buf, pcReturned)
      => ComCall(3, this.p, UInt8.Ptr, buf, UInt32, buf.Length, UInt32.Ptr, pcReturned)
    Push(buf)
      => ComCall(4, this.p, UInt8.Ptr, buf, UInt32, buf.Length)
}
struct AsyncIPipeByte extends IUnknown {
    static IID := "{DB2F3ACB-2F86-11D1-8E04-00C04FB9989A}"
    Begin_Pull(cRequest)
      => ComCall(3, this.p, UInt32, cRequest)
    Finish_Pull(buf, pcReturned)
      => ComCall(4, this.p, UInt8.Ptr, buf, UInt32.Ptr, pcReturned)
    Begin_Push(buf)
      => ComCall(5, this.p, UInt8.Ptr, buf, UInt32, buf.Length)
    Finish_Push()
      => ComCall(6, this.p)
}
struct IPipeLong extends IUnknown {
    static IID := "{DB2F3ACC-2F86-11D1-8E04-00C04FB9989A}"
    Pull(buf, pcReturned)
      => ComCall(3, this.p, Int32.Ptr, buf, UInt32, buf.Length, UInt32.Ptr, pcReturned)
    Push(buf)
      => ComCall(4, this.p, Int32.Ptr, buf, UInt32, buf.Length)
}
struct AsyncIPipeLong extends IUnknown {
    static IID := "{DB2F3ACD-2F86-11D1-8E04-00C04FB9989A}"
    Begin_Pull(cRequest)
      => ComCall(3, this.p, UInt32, cRequest)
    Finish_Pull(buf, pcReturned)
      => ComCall(4, this.p, Int32.Ptr, buf, UInt32.Ptr, pcReturned)
    Begin_Push(buf)
      => ComCall(5, this.p, Int32.Ptr, buf, UInt32, buf.Length)
    Finish_Push()
      => ComCall(6, this.p)
}
struct IPipeDouble extends IUnknown {
    static IID := "{DB2F3ACE-2F86-11D1-8E04-00C04FB9989A}"
    Pull(buf, pcReturned)
      => ComCall(3, this.p, Float64.Ptr, buf, UInt32, buf.Length, UInt32.Ptr, pcReturned)
    Push(buf)
      => ComCall(4, this.p, Float64.Ptr, buf, UInt32, buf.Length)
}
struct AsyncIPipeDouble extends IUnknown {
    static IID := "{DB2F3ACF-2F86-11D1-8E04-00C04FB9989A}"
    Begin_Pull(cRequest)
      => ComCall(3, this.p, UInt32, cRequest)
    Finish_Pull(buf, pcReturned)
      => ComCall(4, this.p, Float64.Ptr, buf, UInt32.Ptr, pcReturned)
    Begin_Push(buf)
      => ComCall(5, this.p, Float64.Ptr, buf, UInt32, buf.Length)
    Finish_Push()
      => ComCall(6, this.p)
}
struct ContextProperty {
    policyId : GUID
    flags : UInt32
    pUnk : IUnknown
}
struct IEnumContextProps extends IUnknown {
    static IID := "{000001C1-0000-0000-C000-000000000046}"
    Next(pContextProperties, pceltFetched)
      => ComCall(3, this.p, UInt32, pContextProperties.Length, ContextProperty.Ptr, pContextProperties, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnumContextProps)
      => ComCall(6, this.p, IEnumContextProps.Ptr, ppEnumContextProps)
    Count(pcelt)
      => ComCall(7, this.p, UInt32.Ptr, pcelt)
}
struct IContext extends IUnknown {
    static IID := "{000001C0-0000-0000-C000-000000000046}"
    SetProperty(rpolicyId, flags, pUnk)
      => ComCall(3, this.p, GUID.Ptr, rpolicyId, UInt32, flags, IUnknown, pUnk)
    RemoveProperty(rPolicyId)
      => ComCall(4, this.p, GUID.Ptr, rPolicyId)
    GetProperty(rGuid, pFlags, ppUnk)
      => ComCall(5, this.p, GUID.Ptr, rGuid, UInt32.Ptr, pFlags, IUnknown.Ptr, ppUnk)
    EnumContextProps(ppEnumContextProps)
      => ComCall(6, this.p, IEnumContextProps.Ptr, ppEnumContextProps)
}
struct APTTYPEQUALIFIER extends Int32 {
    static APTTYPEQUALIFIER_NONE := 0
    static APTTYPEQUALIFIER_IMPLICIT_MTA := 1
    static APTTYPEQUALIFIER_NA_ON_MTA := 2
    static APTTYPEQUALIFIER_NA_ON_STA := 3
    static APTTYPEQUALIFIER_NA_ON_IMPLICIT_MTA := 4
    static APTTYPEQUALIFIER_NA_ON_MAINSTA := 5
    static APTTYPEQUALIFIER_APPLICATION_STA := 6
    static APTTYPEQUALIFIER_RESERVED_1 := 7
}
struct APTTYPE extends Int32 {
    static APTTYPE_CURRENT := -1
    static APTTYPE_STA := 0
    static APTTYPE_MTA := 1
    static APTTYPE_NA := 2
    static APTTYPE_MAINSTA := 3
}
struct THDTYPE extends Int32 {
    static THDTYPE_BLOCKMESSAGES := 0
    static THDTYPE_PROCESSMESSAGES := 1
}
struct IComThreadingInfo extends IUnknown {
    static IID := "{000001CE-0000-0000-C000-000000000046}"
    GetCurrentApartmentType(pAptType)
      => ComCall(3, this.p, APTTYPE.Ptr, pAptType)
    GetCurrentThreadType(pThreadType)
      => ComCall(4, this.p, THDTYPE.Ptr, pThreadType)
    GetCurrentLogicalThreadId(pguidLogicalThreadId)
      => ComCall(5, this.p, GUID.Ptr, pguidLogicalThreadId)
    SetCurrentLogicalThreadId(rguid)
      => ComCall(6, this.p, GUID.Ptr, rguid)
}
struct IProcessInitControl extends IUnknown {
    static IID := "{72380D55-8D2B-43A3-8513-2B6EF31434E9}"
    ResetInitializerTimeout(dwSecondsRemaining)
      => ComCall(3, this.p, UInt32, dwSecondsRemaining)
}
struct IFastRundown extends IUnknown {
    static IID := "{00000040-0000-0000-C000-000000000046}"
}
struct CO_MARSHALING_CONTEXT_ATTRIBUTES extends Int32 {
    static CO_MARSHALING_SOURCE_IS_APP_CONTAINER := 0
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_1 := -2147483648
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_2 := -2147483647
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_3 := -2147483646
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_4 := -2147483645
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_5 := -2147483644
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_6 := -2147483643
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_7 := -2147483642
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_8 := -2147483641
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_9 := -2147483640
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_10 := -2147483639
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_11 := -2147483638
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_12 := -2147483637
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_13 := -2147483636
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_14 := -2147483635
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_15 := -2147483634
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_16 := -2147483633
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_17 := -2147483632
    static CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_18 := -2147483631
}
struct IMachineGlobalObjectTable extends IUnknown {
    static IID := "{26D709AC-F70B-4421-A96F-D2878FAFB00D}"
    RegisterObject(clsid, identifier, object, token)
      => ComCall(3, this.p, GUID.Ptr, clsid, "Str", identifier, IUnknown, object, MachineGlobalObjectTableRegistrationToken.Ptr, token)
    GetObject(clsid, identifier, riid, ppv)
      => ComCall(4, this.p, GUID.Ptr, clsid, "Str", identifier, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    RevokeObject(token)
      => ComCall(5, this.p, MachineGlobalObjectTableRegistrationToken, token)
}
struct ISupportAllowLowerTrustActivation extends IUnknown {
    static IID := "{E9956EF2-3828-4B4B-8FA9-7DB61DEE4954}"
}
struct ISupportActivationFromPackage extends IUnknown {
    static IID := "{0A18AAE5-5CAA-48C5-A9F4-6E46DCD58AD5}"
}
struct ISupportCoAddComDependencyOnPackage extends IUnknown {
    static IID := "{C8059EFC-4E98-4FD0-BFC6-44190B80B823}"
}
struct ISupportServerMustBeEqualOrGreaterPrivilegeActivation extends IUnknown {
    static IID := "{5BDB3EE2-46BC-4313-B5FB-801C360BA5F9}"
}
struct ISupportDoNotElevateServerActivation extends IUnknown {
    static IID := "{40AEFE22-3FF6-43DC-8108-C8C402D57B5C}"
}
struct ISupportActivateAsActivatorPackaged extends IUnknown {
    static IID := "{765D1DF2-F0AF-4EF8-AA50-84789CA330ED}"
}
struct ISupportPackagedComRegistrationVisibility extends IUnknown {
    static IID := "{8DC3444E-C7EE-449A-9FB8-B9173988D66A}"
}
struct ISupportPackagedComElevationEnabledClasses extends IUnknown {
    static IID := "{B4219019-F712-4D4F-ADE7-F468276AF0B8}"
}
struct IPackagedComSyntaxSupport extends IUnknown {
    static IID := "{8F146474-B228-48FB-A58C-105EBB273ABC}"
    GetSupportedVersion(supportedVersion)
      => ComCall(3, this.p, UInt32.Ptr, supportedVersion)
}
struct IMallocSpy extends IUnknown {
    static IID := "{0000001D-0000-0000-C000-000000000046}"
    PreAlloc(cbRequest)
      => ComCall(3, this.p, IntPtr, cbRequest, IntPtr)
    PostAlloc(pActual)
      => ComCall(4, this.p, Struct.Ptr, pActual, Struct.Ptr)
    PreFree(pRequest, fSpyed)
      => ComCall(5, this.p, Struct.Ptr, pRequest, BOOL, fSpyed, Struct.Ptr)
    PostFree(fSpyed)
      => ComCall(6, this.p, BOOL, fSpyed, "void")
    PreRealloc(pRequest, cbRequest, ppNewRequest, fSpyed)
      => ComCall(7, this.p, Struct.Ptr, pRequest, IntPtr, cbRequest, Struct.Ptr.Ptr, ppNewRequest, BOOL, fSpyed, IntPtr)
    PostRealloc(pActual, fSpyed)
      => ComCall(8, this.p, Struct.Ptr, pActual, BOOL, fSpyed, Struct.Ptr)
    PreGetSize(pRequest, fSpyed)
      => ComCall(9, this.p, Struct.Ptr, pRequest, BOOL, fSpyed, Struct.Ptr)
    PostGetSize(cbActual, fSpyed)
      => ComCall(10, this.p, IntPtr, cbActual, BOOL, fSpyed, IntPtr)
    PreDidAlloc(pRequest, fSpyed)
      => ComCall(11, this.p, Struct.Ptr, pRequest, BOOL, fSpyed, Struct.Ptr)
    PostDidAlloc(pRequest, fSpyed, fActual)
      => ComCall(12, this.p, Struct.Ptr, pRequest, BOOL, fSpyed, Int32, fActual, Int32)
    PreHeapMinimize()
      => ComCall(13, this.p, "void")
    PostHeapMinimize()
      => ComCall(14, this.p, "void")
}
struct BIND_OPTS {
    cbStruct : UInt32
    grfFlags : UInt32
    grfMode : UInt32
    dwTickCountDeadline : UInt32
}
struct BIND_OPTS2 {
    Base : BIND_OPTS
    dwTrackFlags : UInt32
    dwClassContext : UInt32
    locale : UInt32
    pServerInfo : COSERVERINFO.Ptr
}
struct BIND_OPTS3 {
    Base : BIND_OPTS2
    hwnd : HWND
}
struct BIND_FLAGS extends Int32 {
    static BIND_MAYBOTHERUSER := 1
    static BIND_JUSTTESTEXISTENCE := 2
}
struct IBindCtx extends IUnknown {
    static IID := "{0000000E-0000-0000-C000-000000000046}"
    RegisterObjectBound(punk)
      => ComCall(3, this.p, IUnknown, punk)
    RevokeObjectBound(punk)
      => ComCall(4, this.p, IUnknown, punk)
    ReleaseBoundObjects()
      => ComCall(5, this.p)
    SetBindOptions(pbindopts)
      => ComCall(6, this.p, BIND_OPTS.Ptr, pbindopts)
    GetBindOptions(pbindopts)
      => ComCall(7, this.p, BIND_OPTS.Ptr, pbindopts)
    GetRunningObjectTable(pprot)
      => ComCall(8, this.p, IRunningObjectTable.Ptr, pprot)
    RegisterObjectParam(pszKey, punk)
      => ComCall(9, this.p, "Str", pszKey, IUnknown, punk)
    GetObjectParam(pszKey, ppunk)
      => ComCall(10, this.p, "Str", pszKey, IUnknown.Ptr, ppunk)
    EnumObjectParam(ppenum)
      => ComCall(11, this.p, IEnumString.Ptr, ppenum)
    RevokeObjectParam(pszKey)
      => ComCall(12, this.p, "Str", pszKey)
}
struct IEnumMoniker extends IUnknown {
    static IID := "{00000102-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, IMoniker.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumMoniker.Ptr, ppenum)
}
struct IRunnableObject extends IUnknown {
    static IID := "{00000126-0000-0000-C000-000000000046}"
    GetRunningClass(lpClsid)
      => ComCall(3, this.p, GUID.Ptr, lpClsid)
    Run(pbc)
      => ComCall(4, this.p, IBindCtx, pbc)
    IsRunning()
      => ComCall(5, this.p, BOOL)
    LockRunning(fLock, fLastUnlockCloses)
      => ComCall(6, this.p, BOOL, fLock, BOOL, fLastUnlockCloses)
    SetContainedObject(fContained)
      => ComCall(7, this.p, BOOL, fContained)
}
struct IRunningObjectTable extends IUnknown {
    static IID := "{00000010-0000-0000-C000-000000000046}"
    Register(grfFlags, punkObject, pmkObjectName, pdwRegister)
      => ComCall(3, this.p, ROT_FLAGS, grfFlags, IUnknown, punkObject, IMoniker, pmkObjectName, UInt32.Ptr, pdwRegister)
    Revoke(dwRegister)
      => ComCall(4, this.p, UInt32, dwRegister)
    IsRunning(pmkObjectName)
      => ComCall(5, this.p, IMoniker, pmkObjectName)
    GetObject(pmkObjectName, ppunkObject)
      => ComCall(6, this.p, IMoniker, pmkObjectName, IUnknown.Ptr, ppunkObject)
    NoteChangeTime(dwRegister, pfiletime)
      => ComCall(7, this.p, UInt32, dwRegister, FILETIME.Ptr, pfiletime)
    GetTimeOfLastChange(pmkObjectName, pfiletime)
      => ComCall(8, this.p, IMoniker, pmkObjectName, FILETIME.Ptr, pfiletime)
    EnumRunning(ppenumMoniker)
      => ComCall(9, this.p, IEnumMoniker.Ptr, ppenumMoniker)
}
struct IPersist extends IUnknown {
    static IID := "{0000010C-0000-0000-C000-000000000046}"
    GetClassID(pClassID)
      => ComCall(3, this.p, GUID.Ptr, pClassID)
}
struct IPersistStream extends IPersist {
    static IID := "{00000109-0000-0000-C000-000000000046}"
    IsDirty()
      => ComCall(4, this.p)
    Load(pStm)
      => ComCall(5, this.p, IStream, pStm)
    Save(pStm, fClearDirty)
      => ComCall(6, this.p, IStream, pStm, BOOL, fClearDirty)
    GetSizeMax(pcbSize)
      => ComCall(7, this.p, Int64.Ptr, pcbSize)
}
struct MKSYS extends Int32 {
    static MKSYS_NONE := 0
    static MKSYS_GENERICCOMPOSITE := 1
    static MKSYS_FILEMONIKER := 2
    static MKSYS_ANTIMONIKER := 3
    static MKSYS_ITEMMONIKER := 4
    static MKSYS_POINTERMONIKER := 5
    static MKSYS_CLASSMONIKER := 7
    static MKSYS_OBJREFMONIKER := 8
    static MKSYS_SESSIONMONIKER := 9
    static MKSYS_LUAMONIKER := 10
}
struct MKRREDUCE extends Int32 {
    static MKRREDUCE_ONE := 196608
    static MKRREDUCE_TOUSER := 131072
    static MKRREDUCE_THROUGHUSER := 65536
    static MKRREDUCE_ALL := 0
}
struct IMoniker extends IPersistStream {
    static IID := "{0000000F-0000-0000-C000-000000000046}"
    BindToObject(pbc, pmkToLeft?, riidResult, ppvResult)
      => ComCall(8, this.p, IBindCtx, pbc, IMoniker, pmkToLeft?, GUID.Ptr, riidResult, Struct.Ptr.Ptr, ppvResult)
    BindToStorage(pbc, pmkToLeft?, riid, ppvObj)
      => ComCall(9, this.p, IBindCtx, pbc, IMoniker, pmkToLeft?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
    Reduce(pbc, dwReduceHowFar, ppmkToLeft, ppmkReduced)
      => ComCall(10, this.p, IBindCtx, pbc, UInt32, dwReduceHowFar, IMoniker.Ptr, ppmkToLeft, IMoniker.Ptr, ppmkReduced)
    ComposeWith(pmkRight, fOnlyIfNotGeneric, ppmkComposite)
      => ComCall(11, this.p, IMoniker, pmkRight, BOOL, fOnlyIfNotGeneric, IMoniker.Ptr, ppmkComposite)
    Enum(fForward, ppenumMoniker)
      => ComCall(12, this.p, BOOL, fForward, IEnumMoniker.Ptr, ppenumMoniker)
    IsEqual(pmkOtherMoniker)
      => ComCall(13, this.p, IMoniker, pmkOtherMoniker)
    Hash(pdwHash)
      => ComCall(14, this.p, UInt32.Ptr, pdwHash)
    IsRunning(pbc, pmkToLeft, pmkNewlyRunning)
      => ComCall(15, this.p, IBindCtx, pbc, IMoniker, pmkToLeft, IMoniker, pmkNewlyRunning)
    GetTimeOfLastChange(pbc, pmkToLeft, pFileTime)
      => ComCall(16, this.p, IBindCtx, pbc, IMoniker, pmkToLeft, FILETIME.Ptr, pFileTime)
    Inverse(ppmk)
      => ComCall(17, this.p, IMoniker.Ptr, ppmk)
    CommonPrefixWith(pmkOther, ppmkPrefix)
      => ComCall(18, this.p, IMoniker, pmkOther, IMoniker.Ptr, ppmkPrefix)
    RelativePathTo(pmkOther, ppmkRelPath)
      => ComCall(19, this.p, IMoniker, pmkOther, IMoniker.Ptr, ppmkRelPath)
    GetDisplayName(pbc, pmkToLeft, ppszDisplayName)
      => ComCall(20, this.p, IBindCtx, pbc, IMoniker, pmkToLeft, PWSTR.Ptr, ppszDisplayName)
    ParseDisplayName(pbc, pmkToLeft, pszDisplayName, pchEaten, ppmkOut)
      => ComCall(21, this.p, IBindCtx, pbc, IMoniker, pmkToLeft, "Str", pszDisplayName, UInt32.Ptr, pchEaten, IMoniker.Ptr, ppmkOut)
    IsSystemMoniker(pdwMksys)
      => ComCall(22, this.p, UInt32.Ptr, pdwMksys)
}
struct IROTData extends IUnknown {
    static IID := "{F29F6BC0-5021-11CE-AA15-00006901293F}"
    GetComparisonData(pbData, pcbData)
      => ComCall(3, this.p, UInt8.Ptr, pbData, UInt32, pbData.Length, UInt32.Ptr, pcbData)
}
struct IPersistFile extends IPersist {
    static IID := "{0000010B-0000-0000-C000-000000000046}"
    IsDirty()
      => ComCall(4, this.p)
    Load(pszFileName, dwMode)
      => ComCall(5, this.p, "Str", pszFileName, STGM, dwMode)
    Save(pszFileName, fRemember)
      => ComCall(6, this.p, "Str", pszFileName, BOOL, fRemember)
    SaveCompleted(pszFileName)
      => ComCall(7, this.p, "Str", pszFileName)
    GetCurFile(ppszFileName)
      => ComCall(8, this.p, PWSTR.Ptr, ppszFileName)
}
struct DVTARGETDEVICE {
    tdSize : UInt32
    tdDriverNameOffset : UInt16
    tdDeviceNameOffset : UInt16
    tdPortNameOffset : UInt16
    tdExtDevmodeOffset : UInt16
    tdData : UInt8[1]
}
struct FORMATETC {
    cfFormat : UInt16
    ptd : DVTARGETDEVICE.Ptr
    dwAspect : UInt32
    lindex : Int32
    tymed : UInt32
}
struct IEnumFORMATETC extends IUnknown {
    static IID := "{00000103-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, FORMATETC.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumFORMATETC.Ptr, ppenum)
}
struct ADVF extends Int32 {
    static ADVF_NODATA := 1
    static ADVF_PRIMEFIRST := 2
    static ADVF_ONLYONCE := 4
    static ADVF_DATAONSTOP := 64
    static ADVFCACHE_NOHANDLER := 8
    static ADVFCACHE_FORCEBUILTIN := 16
    static ADVFCACHE_ONSAVE := 32
}
struct STATDATA {
    formatetc : FORMATETC
    advf : UInt32
    pAdvSink : IAdviseSink
    dwConnection : UInt32
}
struct IEnumSTATDATA extends IUnknown {
    static IID := "{00000105-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, STATDATA.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumSTATDATA.Ptr, ppenum)
}
struct TYMED extends Int32 {
    static TYMED_HGLOBAL := 1
    static TYMED_FILE := 2
    static TYMED_ISTREAM := 4
    static TYMED_ISTORAGE := 8
    static TYMED_GDI := 16
    static TYMED_MFPICT := 32
    static TYMED_ENHMF := 64
    static TYMED_NULL := 0
}
struct RemSTGMEDIUM {
    tymed : UInt32
    dwHandleType : UInt32
    pData : UInt32
    pUnkForRelease : UInt32
    cbData : UInt32
    data : UInt8[1]
}
struct STGMEDIUM {
    tymed : UInt32
    u : this._u_e__Union
    pUnkForRelease : IUnknown
    struct _u_e__Union {
        union {
            hBitmap : HBITMAP
            hMetaFilePict : Struct.Ptr
            hEnhMetaFile : HENHMETAFILE
            hGlobal : HGLOBAL
            lpszFileName : PWSTR
            pstm : IStream
            pstg : IStorage
        }
    }
}
struct GDI_OBJECT {
    ObjectType : UInt32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hBitmap : userHBITMAP.Ptr
            hPalette : userHPALETTE.Ptr
            hGeneric : userHGLOBAL.Ptr
        }
    }
}
struct userSTGMEDIUM {
    u : this._STGMEDIUM_UNION
    pUnkForRelease : IUnknown
    struct _STGMEDIUM_UNION {
        tymed : UInt32
        u : this._u_e__Struct
        struct _u_e__Struct {
            union {
                hMetaFilePict : userHMETAFILEPICT.Ptr
                hHEnhMetaFile : userHENHMETAFILE.Ptr
                hGdiHandle : GDI_OBJECT.Ptr
                hGlobal : userHGLOBAL.Ptr
                lpszFileName : PWSTR
                pstm : BYTE_BLOB.Ptr
                pstg : BYTE_BLOB.Ptr
            }
        }
    }
}
struct userFLAG_STGMEDIUM {
    ContextFlags : Int32
    fPassOwnership : Int32
    Stgmed : userSTGMEDIUM
}
struct FLAG_STGMEDIUM {
    ContextFlags : Int32
    fPassOwnership : Int32
    Stgmed : STGMEDIUM
}
struct IAdviseSink extends IUnknown {
    static IID := "{0000010F-0000-0000-C000-000000000046}"
    OnDataChange(pFormatetc, pStgmed)
      => ComCall(3, this.p, FORMATETC.Ptr, pFormatetc, STGMEDIUM.Ptr, pStgmed, "void")
    OnViewChange(dwAspect, lindex)
      => ComCall(4, this.p, UInt32, dwAspect, Int32, lindex, "void")
    OnRename(pmk)
      => ComCall(5, this.p, IMoniker, pmk, "void")
    OnSave()
      => ComCall(6, this.p, "void")
    OnClose()
      => ComCall(7, this.p, "void")
}
struct AsyncIAdviseSink extends IUnknown {
    static IID := "{00000150-0000-0000-C000-000000000046}"
    Begin_OnDataChange(pFormatetc, pStgmed)
      => ComCall(3, this.p, FORMATETC.Ptr, pFormatetc, STGMEDIUM.Ptr, pStgmed, "void")
    Finish_OnDataChange()
      => ComCall(4, this.p, "void")
    Begin_OnViewChange(dwAspect, lindex)
      => ComCall(5, this.p, UInt32, dwAspect, Int32, lindex, "void")
    Finish_OnViewChange()
      => ComCall(6, this.p, "void")
    Begin_OnRename(pmk)
      => ComCall(7, this.p, IMoniker, pmk, "void")
    Finish_OnRename()
      => ComCall(8, this.p, "void")
    Begin_OnSave()
      => ComCall(9, this.p, "void")
    Finish_OnSave()
      => ComCall(10, this.p, "void")
    Begin_OnClose()
      => ComCall(11, this.p, "void")
    Finish_OnClose()
      => ComCall(12, this.p, "void")
}
struct IAdviseSink2 extends IAdviseSink {
    static IID := "{00000125-0000-0000-C000-000000000046}"
    OnLinkSrcChange(pmk)
      => ComCall(8, this.p, IMoniker, pmk, "void")
}
struct AsyncIAdviseSink2 extends AsyncIAdviseSink {
    static IID := "{00000151-0000-0000-C000-000000000046}"
    Begin_OnLinkSrcChange(pmk)
      => ComCall(13, this.p, IMoniker, pmk, "void")
    Finish_OnLinkSrcChange()
      => ComCall(14, this.p, "void")
}
struct DATADIR extends Int32 {
    static DATADIR_GET := 1
    static DATADIR_SET := 2
}
struct IDataObject extends IUnknown {
    static IID := "{0000010E-0000-0000-C000-000000000046}"
    GetData(pformatetcIn, pmedium)
      => ComCall(3, this.p, FORMATETC.Ptr, pformatetcIn, STGMEDIUM.Ptr, pmedium)
    GetDataHere(pformatetc, pmedium)
      => ComCall(4, this.p, FORMATETC.Ptr, pformatetc, STGMEDIUM.Ptr, pmedium)
    QueryGetData(pformatetc)
      => ComCall(5, this.p, FORMATETC.Ptr, pformatetc)
    GetCanonicalFormatEtc(pformatectIn, pformatetcOut)
      => ComCall(6, this.p, FORMATETC.Ptr, pformatectIn, FORMATETC.Ptr, pformatetcOut)
    SetData(pformatetc, pmedium, fRelease)
      => ComCall(7, this.p, FORMATETC.Ptr, pformatetc, STGMEDIUM.Ptr, pmedium, BOOL, fRelease)
    EnumFormatEtc(dwDirection, ppenumFormatEtc)
      => ComCall(8, this.p, UInt32, dwDirection, IEnumFORMATETC.Ptr, ppenumFormatEtc)
    DAdvise(pformatetc, advf, pAdvSink, pdwConnection)
      => ComCall(9, this.p, FORMATETC.Ptr, pformatetc, UInt32, advf, IAdviseSink, pAdvSink, UInt32.Ptr, pdwConnection)
    DUnadvise(dwConnection)
      => ComCall(10, this.p, UInt32, dwConnection)
    EnumDAdvise(ppenumAdvise)
      => ComCall(11, this.p, IEnumSTATDATA.Ptr, ppenumAdvise)
}
struct IDataAdviseHolder extends IUnknown {
    static IID := "{00000110-0000-0000-C000-000000000046}"
    Advise(pDataObject?, pFetc, advf, pAdvise, pdwConnection)
      => ComCall(3, this.p, IDataObject, pDataObject?, FORMATETC.Ptr, pFetc, UInt32, advf, IAdviseSink, pAdvise, UInt32.Ptr, pdwConnection)
    Unadvise(dwConnection)
      => ComCall(4, this.p, UInt32, dwConnection)
    EnumAdvise(ppenumAdvise)
      => ComCall(5, this.p, IEnumSTATDATA.Ptr, ppenumAdvise)
    SendOnDataChange(pDataObject, advf)
      => ComCall(6, this.p, IDataObject, pDataObject, "Ptr", 0, UInt32, advf)
}
struct CALLTYPE extends Int32 {
    static CALLTYPE_TOPLEVEL := 1
    static CALLTYPE_NESTED := 2
    static CALLTYPE_ASYNC := 3
    static CALLTYPE_TOPLEVEL_CALLPENDING := 4
    static CALLTYPE_ASYNC_CALLPENDING := 5
}
struct SERVERCALL extends Int32 {
    static SERVERCALL_ISHANDLED := 0
    static SERVERCALL_REJECTED := 1
    static SERVERCALL_RETRYLATER := 2
}
struct PENDINGTYPE extends Int32 {
    static PENDINGTYPE_TOPLEVEL := 1
    static PENDINGTYPE_NESTED := 2
}
struct PENDINGMSG extends Int32 {
    static PENDINGMSG_CANCELCALL := 0
    static PENDINGMSG_WAITNOPROCESS := 1
    static PENDINGMSG_WAITDEFPROCESS := 2
}
struct INTERFACEINFO {
    pUnk : IUnknown
    iid : GUID
    wMethod : UInt16
}
struct IClassActivator extends IUnknown {
    static IID := "{00000140-0000-0000-C000-000000000046}"
    GetClassObject(rclsid, dwClassContext, locale, riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, rclsid, UInt32, dwClassContext, UInt32, locale, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IProgressNotify extends IUnknown {
    static IID := "{A9D758A0-4617-11CF-95FC-00AA00680DB4}"
    OnProgress(dwProgressCurrent, dwProgressMaximum, fAccurate, fOwner)
      => ComCall(3, this.p, UInt32, dwProgressCurrent, UInt32, dwProgressMaximum, BOOL, fAccurate, BOOL, fOwner)
}
struct StorageLayout {
    LayoutType : UInt32
    pwcsElementName : PWSTR
    cOffset : Int64
    cBytes : Int64
}
struct IBlockingLock extends IUnknown {
    static IID := "{30F3D47A-6447-11D1-8E3C-00C04FB9386D}"
    Lock(dwTimeout)
      => ComCall(3, this.p, UInt32, dwTimeout)
    Unlock()
      => ComCall(4, this.p)
}
struct ITimeAndNoticeControl extends IUnknown {
    static IID := "{BC0BF6AE-8878-11D1-83E9-00C04FC2C6D4}"
    SuppressChanges(res1, res2)
      => ComCall(3, this.p, UInt32, res1, UInt32, res2)
}
struct IOplockStorage extends IUnknown {
    static IID := "{8D19C834-8879-11D1-83E9-00C04FC2C6D4}"
    CreateStorageEx(pwcsName, grfMode, stgfmt, grfAttrs, riid, ppstgOpen)
      => ComCall(3, this.p, "Str", pwcsName, UInt32, grfMode, UInt32, stgfmt, UInt32, grfAttrs, GUID.Ptr, riid, Struct.Ptr.Ptr, ppstgOpen)
    OpenStorageEx(pwcsName, grfMode, stgfmt, grfAttrs, riid, ppstgOpen)
      => ComCall(4, this.p, "Str", pwcsName, UInt32, grfMode, UInt32, stgfmt, UInt32, grfAttrs, GUID.Ptr, riid, Struct.Ptr.Ptr, ppstgOpen)
}
struct IUrlMon extends IUnknown {
    static IID := "{00000026-0000-0000-C000-000000000046}"
    AsyncGetClassBits(rclsid, pszTYPE, pszExt, dwFileVersionMS, dwFileVersionLS, pszCodeBase, pbc, dwClassContext, riid, flags)
      => ComCall(3, this.p, GUID.Ptr, rclsid, "Str", pszTYPE, "Str", pszExt, UInt32, dwFileVersionMS, UInt32, dwFileVersionLS, "Str", pszCodeBase, IBindCtx, pbc, UInt32, dwClassContext, GUID.Ptr, riid, UInt32, flags)
}
struct IForegroundTransfer extends IUnknown {
    static IID := "{00000145-0000-0000-C000-000000000046}"
    AllowForegroundTransfer()
      => ComCall(3, this.p, "Ptr", 0)
}
struct ApplicationType extends Int32 {
    static ServerApplication := 0
    static LibraryApplication := 1
}
struct ShutdownType extends Int32 {
    static IdleShutdown := 0
    static ForcedShutdown := 1
}
struct IProcessLock extends IUnknown {
    static IID := "{000001D5-0000-0000-C000-000000000046}"
    AddRefOnProcess()
      => ComCall(3, this.p, UInt32)
    ReleaseRefOnProcess()
      => ComCall(4, this.p, UInt32)
}
struct ISurrogateService extends IUnknown {
    static IID := "{000001D4-0000-0000-C000-000000000046}"
    Init(rguidProcessID, pProcessLock, pfApplicationAware)
      => ComCall(3, this.p, GUID.Ptr, rguidProcessID, IProcessLock, pProcessLock, BOOL.Ptr, pfApplicationAware)
    ApplicationLaunch(rguidApplID, appType)
      => ComCall(4, this.p, GUID.Ptr, rguidApplID, ApplicationType, appType)
    ApplicationFree(rguidApplID)
      => ComCall(5, this.p, GUID.Ptr, rguidApplID)
    CatalogRefresh()
      => ComCall(6, this.p, "Ptr", 0)
    ProcessShutdown(shutdownType1)
      => ComCall(7, this.p, ShutdownType, shutdownType1)
}
struct IInitializeSpy extends IUnknown {
    static IID := "{00000034-0000-0000-C000-000000000046}"
    PreInitialize(dwCoInit, dwCurThreadAptRefs)
      => ComCall(3, this.p, UInt32, dwCoInit, UInt32, dwCurThreadAptRefs)
    PostInitialize(hrCoInit, dwCoInit, dwNewThreadAptRefs)
      => ComCall(4, this.p, HRESULT, hrCoInit, UInt32, dwCoInit, UInt32, dwNewThreadAptRefs)
    PreUninitialize(dwCurThreadAptRefs)
      => ComCall(5, this.p, UInt32, dwCurThreadAptRefs)
    PostUninitialize(dwNewThreadAptRefs)
      => ComCall(6, this.p, UInt32, dwNewThreadAptRefs)
}
struct COINIT extends Int32 {
    static COINIT_APARTMENTTHREADED := 2
    static COINIT_MULTITHREADED := 0
    static COINIT_DISABLE_OLE1DDE := 4
    static COINIT_SPEED_OVER_MEMORY := 8
}
struct COMSD extends Int32 {
    static SD_LAUNCHPERMISSIONS := 0
    static SD_ACCESSPERMISSIONS := 1
    static SD_LAUNCHRESTRICTIONS := 2
    static SD_ACCESSRESTRICTIONS := 3
}
struct IServiceProvider extends IUnknown {
    static IID := "{6D5140C1-7436-11CE-8034-00AA006009FA}"
    QueryService(guidService, riid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, guidService, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
}
struct COWAIT_FLAGS extends Int32 {
    static COWAIT_DEFAULT := 0
    static COWAIT_WAITALL := 1
    static COWAIT_ALERTABLE := 2
    static COWAIT_INPUTAVAILABLE := 4
    static COWAIT_DISPATCH_CALLS := 8
    static COWAIT_DISPATCH_WINDOW_MESSAGES := 16
}
struct CWMO_FLAGS extends Int32 {
    static CWMO_DEFAULT := 0
    static CWMO_DISPATCH_CALLS := 1
    static CWMO_DISPATCH_WINDOW_MESSAGES := 2
}
struct LPFNGETCLASSOBJECT extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct LPFNCANUNLOADNOW extends FunctionPointer {
    static Types := [HRESULT]
}
struct IEnumGUID extends IUnknown {
    static IID := "{0002E000-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, GUID.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumGUID.Ptr, ppenum)
}
struct CATEGORYINFO {
    catid : GUID
    lcid : UInt32
    szDescription : UInt16[128]
}
struct IEnumCATEGORYINFO extends IUnknown {
    static IID := "{0002E011-0000-0000-C000-000000000046}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, CATEGORYINFO.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumCATEGORYINFO.Ptr, ppenum)
}
struct ICatRegister extends IUnknown {
    static IID := "{0002E012-0000-0000-C000-000000000046}"
    RegisterCategories(rgCategoryInfo)
      => ComCall(3, this.p, UInt32, rgCategoryInfo.Length, CATEGORYINFO.Ptr, rgCategoryInfo)
    UnRegisterCategories(rgcatid)
      => ComCall(4, this.p, UInt32, rgcatid.Length, GUID.Ptr, rgcatid)
    RegisterClassImplCategories(rclsid, rgcatid)
      => ComCall(5, this.p, GUID.Ptr, rclsid, UInt32, rgcatid.Length, GUID.Ptr, rgcatid)
    UnRegisterClassImplCategories(rclsid, rgcatid)
      => ComCall(6, this.p, GUID.Ptr, rclsid, UInt32, rgcatid.Length, GUID.Ptr, rgcatid)
    RegisterClassReqCategories(rclsid, rgcatid)
      => ComCall(7, this.p, GUID.Ptr, rclsid, UInt32, rgcatid.Length, GUID.Ptr, rgcatid)
    UnRegisterClassReqCategories(rclsid, rgcatid)
      => ComCall(8, this.p, GUID.Ptr, rclsid, UInt32, rgcatid.Length, GUID.Ptr, rgcatid)
}
struct ICatInformation extends IUnknown {
    static IID := "{0002E013-0000-0000-C000-000000000046}"
    EnumCategories(lcid, ppenumCategoryInfo)
      => ComCall(3, this.p, UInt32, lcid, IEnumCATEGORYINFO.Ptr, ppenumCategoryInfo)
    GetCategoryDesc(rcatid, lcid, pszDesc)
      => ComCall(4, this.p, GUID.Ptr, rcatid, UInt32, lcid, PWSTR.Ptr, pszDesc)
    EnumClassesOfCategories(rgcatidImpl, rgcatidReq, ppenumClsid)
      => ComCall(5, this.p, UInt32, rgcatidImpl.Length, GUID.Ptr, rgcatidImpl, UInt32, rgcatidReq.Length, GUID.Ptr, rgcatidReq, IEnumGUID.Ptr, ppenumClsid)
    IsClassOfCategories(rclsid, rgcatidImpl, rgcatidReq)
      => ComCall(6, this.p, GUID.Ptr, rclsid, UInt32, rgcatidImpl.Length, GUID.Ptr, rgcatidImpl, UInt32, rgcatidReq.Length, GUID.Ptr, rgcatidReq)
    EnumImplCategoriesOfClass(rclsid, ppenumCatid)
      => ComCall(7, this.p, GUID.Ptr, rclsid, IEnumGUID.Ptr, ppenumCatid)
    EnumReqCategoriesOfClass(rclsid, ppenumCatid)
      => ComCall(8, this.p, GUID.Ptr, rclsid, IEnumGUID.Ptr, ppenumCatid)
}
struct ComCallData {
    dwDispid : UInt32
    dwReserved : UInt32
    pUserDefined : Struct.Ptr
}
struct PFNCONTEXTCALL extends FunctionPointer {
    static Types := [ComCallData.Ptr, HRESULT]
}
struct IContextCallback extends IUnknown {
    static IID := "{000001DA-0000-0000-C000-000000000046}"
    ContextCallback(pfnCallback, pParam, riid, iMethod, pUnk)
      => ComCall(3, this.p, PFNCONTEXTCALL, pfnCallback, ComCallData.Ptr, pParam, GUID.Ptr, riid, Int32, iMethod, IUnknown, pUnk)
}
struct IBinding extends IUnknown {
    static IID := "{79EAC9C0-BAF9-11CE-8C82-00AA004BA90B}"
    Abort()
      => ComCall(3, this.p)
    Suspend()
      => ComCall(4, this.p)
    Resume()
      => ComCall(5, this.p)
    SetPriority(nPriority)
      => ComCall(6, this.p, Int32, nPriority)
    GetPriority(pnPriority)
      => ComCall(7, this.p, Int32.Ptr, pnPriority)
    GetBindResult(pclsidProtocol, pdwResult, pszResult, pdwReserved)
      => ComCall(8, this.p, GUID.Ptr, pclsidProtocol, UInt32.Ptr, pdwResult, PWSTR.Ptr, pszResult, UInt32.Ptr, pdwReserved)
}
struct BINDINFOF extends Int32 {
    static BINDINFOF_URLENCODESTGMEDDATA := 1
    static BINDINFOF_URLENCODEDEXTRAINFO := 2
}
struct BINDINFO {
    cbSize : UInt32 := this.Size
    szExtraInfo : PWSTR
    stgmedData : STGMEDIUM
    grfBindInfoF : UInt32
    dwBindVerb : UInt32
    szCustomVerb : PWSTR
    cbstgmedData : UInt32
    dwOptions : UInt32
    dwOptionsFlags : UInt32
    dwCodePage : UInt32
    securityAttributes : SECURITY_ATTRIBUTES
    iid : GUID
    pUnk : IUnknown
    dwReserved : UInt32
}
struct IBindStatusCallback extends IUnknown {
    static IID := "{79EAC9C1-BAF9-11CE-8C82-00AA004BA90B}"
    OnStartBinding(dwReserved, pib)
      => ComCall(3, this.p, UInt32, dwReserved, IBinding, pib)
    GetPriority(pnPriority)
      => ComCall(4, this.p, Int32.Ptr, pnPriority)
    OnLowResource(reserved)
      => ComCall(5, this.p, UInt32, reserved)
    OnProgress(ulProgress, ulProgressMax, ulStatusCode, szStatusText)
      => ComCall(6, this.p, UInt32, ulProgress, UInt32, ulProgressMax, UInt32, ulStatusCode, "Str", szStatusText)
    OnStopBinding(hresult1, szError)
      => ComCall(7, this.p, HRESULT, hresult1, "Str", szError)
    GetBindInfo(grfBINDF, pbindinfo)
      => ComCall(8, this.p, UInt32.Ptr, grfBINDF, BINDINFO.Ptr, pbindinfo)
    OnDataAvailable(grfBSCF, dwSize, pformatetc, pstgmed)
      => ComCall(9, this.p, UInt32, grfBSCF, UInt32, dwSize, FORMATETC.Ptr, pformatetc, STGMEDIUM.Ptr, pstgmed)
    OnObjectAvailable(riid, punk)
      => ComCall(10, this.p, GUID.Ptr, riid, IUnknown, punk)
}
struct IBindStatusCallbackEx extends IBindStatusCallback {
    static IID := "{AAA74EF9-8EE7-4659-88D9-F8C504DA73CC}"
    GetBindInfoEx(grfBINDF, pbindinfo, grfBINDF2, pdwReserved)
      => ComCall(11, this.p, UInt32.Ptr, grfBINDF, BINDINFO.Ptr, pbindinfo, UInt32.Ptr, grfBINDF2, UInt32.Ptr, pdwReserved)
}
struct IAuthenticate extends IUnknown {
    static IID := "{79EAC9D0-BAF9-11CE-8C82-00AA004BA90B}"
    Authenticate(phwnd, pszUsername, pszPassword)
      => ComCall(3, this.p, HWND.Ptr, phwnd, PWSTR.Ptr, pszUsername, PWSTR.Ptr, pszPassword)
}
struct AUTHENTICATEINFO {
    dwFlags : UInt32
    dwReserved : UInt32
}
struct IAuthenticateEx extends IAuthenticate {
    static IID := "{2AD1EDAF-D83D-48B5-9ADF-03DBE19F53BD}"
    AuthenticateEx(phwnd, pszUsername, pszPassword, pauthinfo)
      => ComCall(4, this.p, HWND.Ptr, phwnd, PWSTR.Ptr, pszUsername, PWSTR.Ptr, pszPassword, AUTHENTICATEINFO.Ptr, pauthinfo)
}
struct Uri_PROPERTY extends Int32 {
    static Uri_PROPERTY_ABSOLUTE_URI := 0
    static Uri_PROPERTY_STRING_START := 0
    static Uri_PROPERTY_AUTHORITY := 1
    static Uri_PROPERTY_DISPLAY_URI := 2
    static Uri_PROPERTY_DOMAIN := 3
    static Uri_PROPERTY_EXTENSION := 4
    static Uri_PROPERTY_FRAGMENT := 5
    static Uri_PROPERTY_HOST := 6
    static Uri_PROPERTY_PASSWORD := 7
    static Uri_PROPERTY_PATH := 8
    static Uri_PROPERTY_PATH_AND_QUERY := 9
    static Uri_PROPERTY_QUERY := 10
    static Uri_PROPERTY_RAW_URI := 11
    static Uri_PROPERTY_SCHEME_NAME := 12
    static Uri_PROPERTY_USER_INFO := 13
    static Uri_PROPERTY_USER_NAME := 14
    static Uri_PROPERTY_STRING_LAST := 14
    static Uri_PROPERTY_HOST_TYPE := 15
    static Uri_PROPERTY_DWORD_START := 15
    static Uri_PROPERTY_PORT := 16
    static Uri_PROPERTY_SCHEME := 17
    static Uri_PROPERTY_ZONE := 18
    static Uri_PROPERTY_DWORD_LAST := 18
}
struct IUri extends IUnknown {
    static IID := "{A39EE748-6A27-4817-A6F2-13914BEF5890}"
    GetPropertyBSTR(uriProp, pbstrProperty, dwFlags)
      => ComCall(3, this.p, Uri_PROPERTY, uriProp, BSTR.Ptr, pbstrProperty, UInt32, dwFlags)
    GetPropertyLength(uriProp, pcchProperty, dwFlags)
      => ComCall(4, this.p, Uri_PROPERTY, uriProp, UInt32.Ptr, pcchProperty, UInt32, dwFlags)
    GetPropertyDWORD(uriProp, pdwProperty, dwFlags)
      => ComCall(5, this.p, Uri_PROPERTY, uriProp, UInt32.Ptr, pdwProperty, UInt32, dwFlags)
    HasProperty(uriProp, pfHasProperty)
      => ComCall(6, this.p, Uri_PROPERTY, uriProp, BOOL.Ptr, pfHasProperty)
    GetAbsoluteUri(pbstrAbsoluteUri)
      => ComCall(7, this.p, BSTR.Ptr, pbstrAbsoluteUri)
    GetAuthority(pbstrAuthority)
      => ComCall(8, this.p, BSTR.Ptr, pbstrAuthority)
    GetDisplayUri(pbstrDisplayString)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDisplayString)
    GetDomain(pbstrDomain)
      => ComCall(10, this.p, BSTR.Ptr, pbstrDomain)
    GetExtension(pbstrExtension)
      => ComCall(11, this.p, BSTR.Ptr, pbstrExtension)
    GetFragment(pbstrFragment)
      => ComCall(12, this.p, BSTR.Ptr, pbstrFragment)
    GetHost(pbstrHost)
      => ComCall(13, this.p, BSTR.Ptr, pbstrHost)
    GetPassword(pbstrPassword)
      => ComCall(14, this.p, BSTR.Ptr, pbstrPassword)
    GetPath(pbstrPath)
      => ComCall(15, this.p, BSTR.Ptr, pbstrPath)
    GetPathAndQuery(pbstrPathAndQuery)
      => ComCall(16, this.p, BSTR.Ptr, pbstrPathAndQuery)
    GetQuery(pbstrQuery)
      => ComCall(17, this.p, BSTR.Ptr, pbstrQuery)
    GetRawUri(pbstrRawUri)
      => ComCall(18, this.p, BSTR.Ptr, pbstrRawUri)
    GetSchemeName(pbstrSchemeName)
      => ComCall(19, this.p, BSTR.Ptr, pbstrSchemeName)
    GetUserInfo(pbstrUserInfo)
      => ComCall(20, this.p, BSTR.Ptr, pbstrUserInfo)
    GetUserName(pbstrUserName)
      => ComCall(21, this.p, BSTR.Ptr, pbstrUserName)
    GetHostType(pdwHostType)
      => ComCall(22, this.p, UInt32.Ptr, pdwHostType)
    GetPort(pdwPort)
      => ComCall(23, this.p, UInt32.Ptr, pdwPort)
    GetScheme(pdwScheme)
      => ComCall(24, this.p, UInt32.Ptr, pdwScheme)
    GetZone(pdwZone)
      => ComCall(25, this.p, UInt32.Ptr, pdwZone)
    GetProperties(pdwFlags)
      => ComCall(26, this.p, UInt32.Ptr, pdwFlags)
    IsEqual(pUri, pfEqual)
      => ComCall(27, this.p, IUri, pUri, BOOL.Ptr, pfEqual)
}
struct IUriBuilder extends IUnknown {
    static IID := "{4221B2E1-8955-46C0-BD5B-DE9897565DE7}"
    CreateUriSimple(dwAllowEncodingPropertyMask, dwReserved, ppIUri)
      => ComCall(3, this.p, UInt32, dwAllowEncodingPropertyMask, IntPtr, dwReserved, IUri.Ptr, ppIUri)
    CreateUri(dwCreateFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
      => ComCall(4, this.p, UInt32, dwCreateFlags, UInt32, dwAllowEncodingPropertyMask, IntPtr, dwReserved, IUri.Ptr, ppIUri)
    CreateUriWithFlags(dwCreateFlags, dwUriBuilderFlags, dwAllowEncodingPropertyMask, dwReserved, ppIUri)
      => ComCall(5, this.p, UInt32, dwCreateFlags, UInt32, dwUriBuilderFlags, UInt32, dwAllowEncodingPropertyMask, IntPtr, dwReserved, IUri.Ptr, ppIUri)
    GetIUri(ppIUri)
      => ComCall(6, this.p, IUri.Ptr, ppIUri)
    SetIUri(pIUri?)
      => ComCall(7, this.p, IUri, pIUri?)
    GetFragment(pcchFragment, ppwzFragment)
      => ComCall(8, this.p, UInt32.Ptr, pcchFragment, PWSTR.Ptr, ppwzFragment)
    GetHost(pcchHost, ppwzHost)
      => ComCall(9, this.p, UInt32.Ptr, pcchHost, PWSTR.Ptr, ppwzHost)
    GetPassword(pcchPassword, ppwzPassword)
      => ComCall(10, this.p, UInt32.Ptr, pcchPassword, PWSTR.Ptr, ppwzPassword)
    GetPath(pcchPath, ppwzPath)
      => ComCall(11, this.p, UInt32.Ptr, pcchPath, PWSTR.Ptr, ppwzPath)
    GetPort(pfHasPort, pdwPort)
      => ComCall(12, this.p, BOOL.Ptr, pfHasPort, UInt32.Ptr, pdwPort)
    GetQuery(pcchQuery, ppwzQuery)
      => ComCall(13, this.p, UInt32.Ptr, pcchQuery, PWSTR.Ptr, ppwzQuery)
    GetSchemeName(pcchSchemeName, ppwzSchemeName)
      => ComCall(14, this.p, UInt32.Ptr, pcchSchemeName, PWSTR.Ptr, ppwzSchemeName)
    GetUserName(pcchUserName, ppwzUserName)
      => ComCall(15, this.p, UInt32.Ptr, pcchUserName, PWSTR.Ptr, ppwzUserName)
    SetFragment(pwzNewValue?)
      => ComCall(16, this.p, "Str", pwzNewValue?)
    SetHost(pwzNewValue)
      => ComCall(17, this.p, "Str", pwzNewValue)
    SetPassword(pwzNewValue?)
      => ComCall(18, this.p, "Str", pwzNewValue?)
    SetPath(pwzNewValue?)
      => ComCall(19, this.p, "Str", pwzNewValue?)
    SetPort(fHasPort, dwNewValue)
      => ComCall(20, this.p, BOOL, fHasPort, UInt32, dwNewValue)
    SetQuery(pwzNewValue?)
      => ComCall(21, this.p, "Str", pwzNewValue?)
    SetSchemeName(pwzNewValue)
      => ComCall(22, this.p, "Str", pwzNewValue)
    SetUserName(pwzNewValue?)
      => ComCall(23, this.p, "Str", pwzNewValue?)
    RemoveProperties(dwPropertyMask)
      => ComCall(24, this.p, UInt32, dwPropertyMask)
    HasBeenModified(pfModified)
      => ComCall(25, this.p, BOOL.Ptr, pfModified)
}
struct IBindHost extends IUnknown {
    static IID := "{FC4801A1-2BA9-11CF-A229-00AA003D7352}"
    CreateMoniker(szName, pBC, ppmk, dwReserved)
      => ComCall(3, this.p, "Str", szName, IBindCtx, pBC, IMoniker.Ptr, ppmk, UInt32, dwReserved)
    MonikerBindToStorage(pMk, pBC, pBSC, riid, ppvObj)
      => ComCall(4, this.p, IMoniker, pMk, IBindCtx, pBC, IBindStatusCallback, pBSC, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
    MonikerBindToObject(pMk, pBC, pBSC, riid, ppvObj)
      => ComCall(5, this.p, IMoniker, pMk, IBindCtx, pBC, IBindStatusCallback, pBSC, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
}
struct SAFEARRAYBOUND {
    cElements : UInt32
    lLbound : Int32
}
struct SAFEARRAY {
    cDims : UInt16
    fFeatures : ADVANCED_FEATURE_FLAGS
    cbElements : UInt32
    cLocks : UInt32
    pvData : Struct.Ptr
    rgsabound : SAFEARRAYBOUND[1]
}
struct TYPEKIND extends Int32 {
    static TKIND_ENUM := 0
    static TKIND_RECORD := 1
    static TKIND_MODULE := 2
    static TKIND_INTERFACE := 3
    static TKIND_DISPATCH := 4
    static TKIND_COCLASS := 5
    static TKIND_ALIAS := 6
    static TKIND_UNION := 7
    static TKIND_MAX := 8
}
struct TYPEDESC {
    Anonymous : this._Anonymous_e__Union
    vt : VARENUM
    struct _Anonymous_e__Union {
        union {
            lptdesc : TYPEDESC.Ptr
            lpadesc : ARRAYDESC.Ptr
            hreftype : UInt32
        }
    }
}
struct IDLDESC {
    dwReserved : IntPtr
    wIDLFlags : IDLFLAGS
}
struct ELEMDESC {
    tdesc : TYPEDESC
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            idldesc : IDLDESC
            paramdesc : PARAMDESC
        }
    }
}
struct TYPEATTR {
    guid : GUID
    lcid : UInt32
    dwReserved : UInt32
    memidConstructor : Int32
    memidDestructor : Int32
    lpstrSchema : PWSTR
    cbSizeInstance : UInt32
    typekind : TYPEKIND
    cFuncs : UInt16
    cVars : UInt16
    cImplTypes : UInt16
    cbSizeVft : UInt16
    cbAlignment : UInt16
    wTypeFlags : UInt16
    wMajorVerNum : UInt16
    wMinorVerNum : UInt16
    tdescAlias : TYPEDESC
    idldescType : IDLDESC
}
struct DISPPARAMS {
    rgvarg : VARIANT.Ptr
    rgdispidNamedArgs : Int32.Ptr
    cArgs : UInt32
    cNamedArgs : UInt32
}
struct EXCEPINFO {
    wCode : UInt16
    wReserved : UInt16
    bstrSource : BSTR
    bstrDescription : BSTR
    bstrHelpFile : BSTR
    dwHelpContext : UInt32
    pvReserved : Struct.Ptr
    pfnDeferredFillIn : LPEXCEPFINO_DEFERRED_FILLIN
    scode : Int32
}
struct CALLCONV extends Int32 {
    static CC_FASTCALL := 0
    static CC_CDECL := 1
    static CC_MSCPASCAL := 2
    static CC_PASCAL := 2
    static CC_MACPASCAL := 3
    static CC_STDCALL := 4
    static CC_FPFASTCALL := 5
    static CC_SYSCALL := 6
    static CC_MPWCDECL := 7
    static CC_MPWPASCAL := 8
    static CC_MAX := 9
}
struct FUNCKIND extends Int32 {
    static FUNC_VIRTUAL := 0
    static FUNC_PUREVIRTUAL := 1
    static FUNC_NONVIRTUAL := 2
    static FUNC_STATIC := 3
    static FUNC_DISPATCH := 4
}
struct INVOKEKIND extends Int32 {
    static INVOKE_FUNC := 1
    static INVOKE_PROPERTYGET := 2
    static INVOKE_PROPERTYPUT := 4
    static INVOKE_PROPERTYPUTREF := 8
}
struct FUNCDESC {
    memid : Int32
    lprgscode : Int32.Ptr
    lprgelemdescParam : ELEMDESC.Ptr
    funckind : FUNCKIND
    invkind : INVOKEKIND
    callconv : CALLCONV
    cParams : Int16
    cParamsOpt : Int16
    oVft : Int16
    cScodes : Int16
    elemdescFunc : ELEMDESC
    wFuncFlags : FUNCFLAGS
}
struct VARKIND extends Int32 {
    static VAR_PERINSTANCE := 0
    static VAR_STATIC := 1
    static VAR_CONST := 2
    static VAR_DISPATCH := 3
}
struct VARDESC {
    memid : Int32
    lpstrSchema : PWSTR
    Anonymous : this._Anonymous_e__Union
    elemdescVar : ELEMDESC
    wVarFlags : VARFLAGS
    varkind : VARKIND
    struct _Anonymous_e__Union {
        union {
            oInst : UInt32
            lpvarValue : VARIANT.Ptr
        }
    }
}
struct FUNCFLAGS extends UInt16 {
    static FUNCFLAG_FRESTRICTED := 1
    static FUNCFLAG_FSOURCE := 2
    static FUNCFLAG_FBINDABLE := 4
    static FUNCFLAG_FREQUESTEDIT := 8
    static FUNCFLAG_FDISPLAYBIND := 16
    static FUNCFLAG_FDEFAULTBIND := 32
    static FUNCFLAG_FHIDDEN := 64
    static FUNCFLAG_FUSESGETLASTERROR := 128
    static FUNCFLAG_FDEFAULTCOLLELEM := 256
    static FUNCFLAG_FUIDEFAULT := 512
    static FUNCFLAG_FNONBROWSABLE := 1024
    static FUNCFLAG_FREPLACEABLE := 2048
    static FUNCFLAG_FIMMEDIATEBIND := 4096
}
struct VARFLAGS extends UInt16 {
    static VARFLAG_FREADONLY := 1
    static VARFLAG_FSOURCE := 2
    static VARFLAG_FBINDABLE := 4
    static VARFLAG_FREQUESTEDIT := 8
    static VARFLAG_FDISPLAYBIND := 16
    static VARFLAG_FDEFAULTBIND := 32
    static VARFLAG_FHIDDEN := 64
    static VARFLAG_FRESTRICTED := 128
    static VARFLAG_FDEFAULTCOLLELEM := 256
    static VARFLAG_FUIDEFAULT := 512
    static VARFLAG_FNONBROWSABLE := 1024
    static VARFLAG_FREPLACEABLE := 2048
    static VARFLAG_FIMMEDIATEBIND := 4096
}
struct CUSTDATAITEM {
    guid : GUID
    varValue : VARIANT
}
struct CUSTDATA {
    cCustData : UInt32
    prgCustData : CUSTDATAITEM.Ptr
}
struct IDispatch extends IUnknown {
    static IID := "{00020400-0000-0000-C000-000000000046}"
    GetTypeInfoCount(pctinfo)
      => ComCall(3, this.p, UInt32.Ptr, pctinfo)
    GetTypeInfo(iTInfo, lcid, ppTInfo)
      => ComCall(4, this.p, UInt32, iTInfo, UInt32, lcid, ITypeInfo.Ptr, ppTInfo)
    GetIDsOfNames(riid, rgszNames, lcid, rgDispId)
      => ComCall(5, this.p, GUID.Ptr, riid, PWSTR.Ptr, rgszNames, UInt32, rgDispId.Length, UInt32, lcid, Int32.Ptr, rgDispId)
    Invoke(dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult?, pExcepInfo?, puArgErr?)
      => ComCall(6, this.p, Int32, dispIdMember, GUID.Ptr, riid, UInt32, lcid, DISPATCH_FLAGS, wFlags, DISPPARAMS.Ptr, pDispParams, VARIANT.Ptr, pVarResult?, EXCEPINFO.Ptr, pExcepInfo?, UInt32.Ptr, puArgErr?)
}
struct DESCKIND extends Int32 {
    static DESCKIND_NONE := 0
    static DESCKIND_FUNCDESC := 1
    static DESCKIND_VARDESC := 2
    static DESCKIND_TYPECOMP := 3
    static DESCKIND_IMPLICITAPPOBJ := 4
    static DESCKIND_MAX := 5
}
struct BINDPTR {
    union {
        lpfuncdesc : FUNCDESC.Ptr
        lpvardesc : VARDESC.Ptr
        lptcomp : ITypeComp
    }
}
struct ITypeComp extends IUnknown {
    static IID := "{00020403-0000-0000-C000-000000000046}"
    Bind(szName, lHashVal, wFlags, ppTInfo, pDescKind, pBindPtr)
      => ComCall(3, this.p, "Str", szName, UInt32, lHashVal, UInt16, wFlags, ITypeInfo.Ptr, ppTInfo, DESCKIND.Ptr, pDescKind, BINDPTR.Ptr, pBindPtr)
    BindType(szName, lHashVal, ppTInfo, ppTComp)
      => ComCall(4, this.p, "Str", szName, UInt32, lHashVal, ITypeInfo.Ptr, ppTInfo, ITypeComp.Ptr, ppTComp)
}
struct ITypeInfo extends IUnknown {
    static IID := "{00020401-0000-0000-C000-000000000046}"
    GetTypeAttr(ppTypeAttr)
      => ComCall(3, this.p, TYPEATTR.Ptr.Ptr, ppTypeAttr)
    GetTypeComp(ppTComp)
      => ComCall(4, this.p, ITypeComp.Ptr, ppTComp)
    GetFuncDesc(index, ppFuncDesc)
      => ComCall(5, this.p, UInt32, index, FUNCDESC.Ptr.Ptr, ppFuncDesc)
    GetVarDesc(index, ppVarDesc)
      => ComCall(6, this.p, UInt32, index, VARDESC.Ptr.Ptr, ppVarDesc)
    GetNames(memid, rgBstrNames, pcNames)
      => ComCall(7, this.p, Int32, memid, BSTR.Ptr, rgBstrNames, UInt32, rgBstrNames.Length, UInt32.Ptr, pcNames)
    GetRefTypeOfImplType(index, pRefType)
      => ComCall(8, this.p, UInt32, index, UInt32.Ptr, pRefType)
    GetImplTypeFlags(index, pImplTypeFlags)
      => ComCall(9, this.p, UInt32, index, IMPLTYPEFLAGS.Ptr, pImplTypeFlags)
    GetIDsOfNames(rgszNames, pMemId)
      => ComCall(10, this.p, PWSTR.Ptr, rgszNames, UInt32, pMemId.Length, Int32.Ptr, pMemId)
    Invoke(pvInstance, memid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
      => ComCall(11, this.p, Struct.Ptr, pvInstance, Int32, memid, DISPATCH_FLAGS, wFlags, DISPPARAMS.Ptr, pDispParams, VARIANT.Ptr, pVarResult, EXCEPINFO.Ptr, pExcepInfo, UInt32.Ptr, puArgErr)
    GetDocumentation(memid, pBstrName?, pBstrDocString?, pdwHelpContext, pBstrHelpFile?)
      => ComCall(12, this.p, Int32, memid, BSTR.Ptr, pBstrName?, BSTR.Ptr, pBstrDocString?, UInt32.Ptr, pdwHelpContext, BSTR.Ptr, pBstrHelpFile?)
    GetDllEntry(memid, invKind, pBstrDllName?, pBstrName?, pwOrdinal)
      => ComCall(13, this.p, Int32, memid, INVOKEKIND, invKind, BSTR.Ptr, pBstrDllName?, BSTR.Ptr, pBstrName?, UInt16.Ptr, pwOrdinal)
    GetRefTypeInfo(hRefType, ppTInfo)
      => ComCall(14, this.p, UInt32, hRefType, ITypeInfo.Ptr, ppTInfo)
    AddressOfMember(memid, invKind, ppv)
      => ComCall(15, this.p, Int32, memid, INVOKEKIND, invKind, Struct.Ptr.Ptr, ppv)
    CreateInstance(pUnkOuter, riid, ppvObj)
      => ComCall(16, this.p, IUnknown, pUnkOuter, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObj)
    GetMops(memid, pBstrMops)
      => ComCall(17, this.p, Int32, memid, BSTR.Ptr, pBstrMops)
    GetContainingTypeLib(ppTLib, pIndex)
      => ComCall(18, this.p, ITypeLib.Ptr, ppTLib, UInt32.Ptr, pIndex)
    ReleaseTypeAttr(pTypeAttr)
      => ComCall(19, this.p, TYPEATTR.Ptr, pTypeAttr, "void")
    ReleaseFuncDesc(pFuncDesc)
      => ComCall(20, this.p, FUNCDESC.Ptr, pFuncDesc, "void")
    ReleaseVarDesc(pVarDesc)
      => ComCall(21, this.p, VARDESC.Ptr, pVarDesc, "void")
}
struct ITypeInfo2 extends ITypeInfo {
    static IID := "{00020412-0000-0000-C000-000000000046}"
    GetTypeKind(pTypeKind)
      => ComCall(22, this.p, TYPEKIND.Ptr, pTypeKind)
    GetTypeFlags(pTypeFlags)
      => ComCall(23, this.p, UInt32.Ptr, pTypeFlags)
    GetFuncIndexOfMemId(memid, invKind, pFuncIndex)
      => ComCall(24, this.p, Int32, memid, INVOKEKIND, invKind, UInt32.Ptr, pFuncIndex)
    GetVarIndexOfMemId(memid, pVarIndex)
      => ComCall(25, this.p, Int32, memid, UInt32.Ptr, pVarIndex)
    GetCustData(guid, pVarVal)
      => ComCall(26, this.p, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetFuncCustData(index, guid, pVarVal)
      => ComCall(27, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetParamCustData(indexFunc, indexParam, guid, pVarVal)
      => ComCall(28, this.p, UInt32, indexFunc, UInt32, indexParam, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetVarCustData(index, guid, pVarVal)
      => ComCall(29, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetImplTypeCustData(index, guid, pVarVal)
      => ComCall(30, this.p, UInt32, index, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetDocumentation2(memid, lcid, pbstrHelpString?, pdwHelpStringContext, pbstrHelpStringDll?)
      => ComCall(31, this.p, Int32, memid, UInt32, lcid, BSTR.Ptr, pbstrHelpString?, UInt32.Ptr, pdwHelpStringContext, BSTR.Ptr, pbstrHelpStringDll?)
    GetAllCustData(pCustData)
      => ComCall(32, this.p, CUSTDATA.Ptr, pCustData)
    GetAllFuncCustData(index, pCustData)
      => ComCall(33, this.p, UInt32, index, CUSTDATA.Ptr, pCustData)
    GetAllParamCustData(indexFunc, indexParam, pCustData)
      => ComCall(34, this.p, UInt32, indexFunc, UInt32, indexParam, CUSTDATA.Ptr, pCustData)
    GetAllVarCustData(index, pCustData)
      => ComCall(35, this.p, UInt32, index, CUSTDATA.Ptr, pCustData)
    GetAllImplTypeCustData(index, pCustData)
      => ComCall(36, this.p, UInt32, index, CUSTDATA.Ptr, pCustData)
}
struct SYSKIND extends Int32 {
    static SYS_WIN16 := 0
    static SYS_WIN32 := 1
    static SYS_MAC := 2
    static SYS_WIN64 := 3
}
struct TLIBATTR {
    guid : GUID
    lcid : UInt32
    syskind : SYSKIND
    wMajorVerNum : UInt16
    wMinorVerNum : UInt16
    wLibFlags : UInt16
}
struct ITypeLib extends IUnknown {
    static IID := "{00020402-0000-0000-C000-000000000046}"
    GetTypeInfoCount()
      => ComCall(3, this.p, UInt32)
    GetTypeInfo(index, ppTInfo)
      => ComCall(4, this.p, UInt32, index, ITypeInfo.Ptr, ppTInfo)
    GetTypeInfoType(index, pTKind)
      => ComCall(5, this.p, UInt32, index, TYPEKIND.Ptr, pTKind)
    GetTypeInfoOfGuid(guid, ppTinfo)
      => ComCall(6, this.p, GUID.Ptr, guid, ITypeInfo.Ptr, ppTinfo)
    GetLibAttr(ppTLibAttr)
      => ComCall(7, this.p, TLIBATTR.Ptr.Ptr, ppTLibAttr)
    GetTypeComp(ppTComp)
      => ComCall(8, this.p, ITypeComp.Ptr, ppTComp)
    GetDocumentation(index, pBstrName?, pBstrDocString?, pdwHelpContext, pBstrHelpFile?)
      => ComCall(9, this.p, Int32, index, BSTR.Ptr, pBstrName?, BSTR.Ptr, pBstrDocString?, UInt32.Ptr, pdwHelpContext, BSTR.Ptr, pBstrHelpFile?)
    IsName(szNameBuf, lHashVal, pfName)
      => ComCall(10, this.p, PWSTR, szNameBuf, UInt32, lHashVal, BOOL.Ptr, pfName)
    FindName(szNameBuf, lHashVal, ppTInfo, rgMemId)
      => ComCall(11, this.p, PWSTR, szNameBuf, UInt32, lHashVal, ITypeInfo.Ptr, ppTInfo, Int32.Ptr, rgMemId, UInt16.Ptr, rgMemId.Length)
    ReleaseTLibAttr(pTLibAttr)
      => ComCall(12, this.p, TLIBATTR.Ptr, pTLibAttr, "void")
}
struct ITypeLib2 extends ITypeLib {
    static IID := "{00020411-0000-0000-C000-000000000046}"
    GetCustData(guid, pVarVal)
      => ComCall(13, this.p, GUID.Ptr, guid, VARIANT.Ptr, pVarVal)
    GetLibStatistics(pcUniqueNames, pcchUniqueNames)
      => ComCall(14, this.p, UInt32.Ptr, pcUniqueNames, UInt32.Ptr, pcchUniqueNames)
    GetDocumentation2(index, lcid, pbstrHelpString?, pdwHelpStringContext, pbstrHelpStringDll?)
      => ComCall(15, this.p, Int32, index, UInt32, lcid, BSTR.Ptr, pbstrHelpString?, UInt32.Ptr, pdwHelpStringContext, BSTR.Ptr, pbstrHelpStringDll?)
    GetAllCustData(pCustData)
      => ComCall(16, this.p, CUSTDATA.Ptr, pCustData)
}
struct IErrorInfo extends IUnknown {
    static IID := "{1CF2B120-547D-101B-8E65-08002B2BD119}"
    GetGUID(pGUID)
      => ComCall(3, this.p, GUID.Ptr, pGUID)
    GetSource(pBstrSource)
      => ComCall(4, this.p, BSTR.Ptr, pBstrSource)
    GetDescription(pBstrDescription)
      => ComCall(5, this.p, BSTR.Ptr, pBstrDescription)
    GetHelpFile(pBstrHelpFile)
      => ComCall(6, this.p, BSTR.Ptr, pBstrHelpFile)
    GetHelpContext(pdwHelpContext)
      => ComCall(7, this.p, UInt32.Ptr, pdwHelpContext)
}
struct ISupportErrorInfo extends IUnknown {
    static IID := "{DF0B3D60-548F-101B-8E65-08002B2BD119}"
    InterfaceSupportsErrorInfo(riid)
      => ComCall(3, this.p, GUID.Ptr, riid)
}
struct IErrorLog extends IUnknown {
    static IID := "{3127CA40-446E-11CE-8135-00AA004BB851}"
    AddError(pszPropName, pExcepInfo)
      => ComCall(3, this.p, "Str", pszPropName, EXCEPINFO.Ptr, pExcepInfo)
}
struct ITypeLibRegistrationReader extends IUnknown {
    static IID := "{ED6A8A2A-B160-4E77-8F73-AA7435CD5C27}"
    EnumTypeLibRegistrations(ppEnumUnknown)
      => ComCall(3, this.p, IEnumUnknown.Ptr, ppEnumUnknown)
}
struct ITypeLibRegistration extends IUnknown {
    static IID := "{76A3E735-02DF-4A12-98EB-043AD3600AF3}"
    GetGuid(pGuid)
      => ComCall(3, this.p, GUID.Ptr, pGuid)
    GetVersion(pVersion)
      => ComCall(4, this.p, BSTR.Ptr, pVersion)
    GetLcid(pLcid)
      => ComCall(5, this.p, UInt32.Ptr, pLcid)
    GetWin32Path(pWin32Path)
      => ComCall(6, this.p, BSTR.Ptr, pWin32Path)
    GetWin64Path(pWin64Path)
      => ComCall(7, this.p, BSTR.Ptr, pWin64Path)
    GetDisplayName(pDisplayName)
      => ComCall(8, this.p, BSTR.Ptr, pDisplayName)
    GetFlags(pFlags)
      => ComCall(9, this.p, UInt32.Ptr, pFlags)
    GetHelpDir(pHelpDir)
      => ComCall(10, this.p, BSTR.Ptr, pHelpDir)
}
struct CONNECTDATA {
    pUnk : IUnknown
    dwCookie : UInt32
}
struct IEnumConnections extends IUnknown {
    static IID := "{B196B287-BAB4-101A-B69C-00AA00341D07}"
    Next(rgcd, pcFetched)
      => ComCall(3, this.p, UInt32, rgcd.Length, CONNECTDATA.Ptr, rgcd, UInt32.Ptr, pcFetched)
    Skip(cConnections)
      => ComCall(4, this.p, UInt32, cConnections)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumConnections.Ptr, ppEnum)
}
struct IConnectionPoint extends IUnknown {
    static IID := "{B196B286-BAB4-101A-B69C-00AA00341D07}"
    GetConnectionInterface(pIID)
      => ComCall(3, this.p, GUID.Ptr, pIID)
    GetConnectionPointContainer(ppCPC)
      => ComCall(4, this.p, IConnectionPointContainer.Ptr, ppCPC)
    Advise(pUnkSink, pdwCookie)
      => ComCall(5, this.p, IUnknown, pUnkSink, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(6, this.p, UInt32, dwCookie)
    EnumConnections(ppEnum)
      => ComCall(7, this.p, IEnumConnections.Ptr, ppEnum)
}
struct IEnumConnectionPoints extends IUnknown {
    static IID := "{B196B285-BAB4-101A-B69C-00AA00341D07}"
    Next(ppCP, pcFetched)
      => ComCall(3, this.p, UInt32, ppCP.Length, IConnectionPoint.Ptr, ppCP, UInt32.Ptr, pcFetched)
    Skip(cConnections)
      => ComCall(4, this.p, UInt32, cConnections)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumConnectionPoints.Ptr, ppEnum)
}
struct IConnectionPointContainer extends IUnknown {
    static IID := "{B196B284-BAB4-101A-B69C-00AA00341D07}"
    EnumConnectionPoints(ppEnum)
      => ComCall(3, this.p, IEnumConnectionPoints.Ptr, ppEnum)
    FindConnectionPoint(riid, ppCP)
      => ComCall(4, this.p, GUID.Ptr, riid, IConnectionPoint.Ptr, ppCP)
}
struct IPersistMemory extends IPersist {
    static IID := "{BD1AE5E0-A6AE-11CE-BD37-504200C10000}"
    IsDirty()
      => ComCall(4, this.p)
    Load(pMem)
      => ComCall(5, this.p, Struct.Ptr, pMem, UInt32, pMem.Length)
    Save(pMem, fClearDirty)
      => ComCall(6, this.p, Struct.Ptr, pMem, BOOL, fClearDirty, UInt32, pMem.Length)
    GetSizeMax(pCbSize)
      => ComCall(7, this.p, UInt32.Ptr, pCbSize)
    InitNew()
      => ComCall(8, this.p)
}
struct IPersistStreamInit extends IPersist {
    static IID := "{7FD52380-4E07-101B-AE2D-08002B2EC713}"
    IsDirty()
      => ComCall(4, this.p)
    Load(pStm)
      => ComCall(5, this.p, IStream, pStm)
    Save(pStm, fClearDirty)
      => ComCall(6, this.p, IStream, pStm, BOOL, fClearDirty)
    GetSizeMax(pCbSize)
      => ComCall(7, this.p, Int64.Ptr, pCbSize)
    InitNew()
      => ComCall(8, this.p)
}
