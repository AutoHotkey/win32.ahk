#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {IMoniker, IUnknown}

struct DTC_STATUS_ extends Int32 {
    static DTC_STATUS_UNKNOWN := 0
    static DTC_STATUS_STARTING := 1
    static DTC_STATUS_STARTED := 2
    static DTC_STATUS_PAUSING := 3
    static DTC_STATUS_PAUSED := 4
    static DTC_STATUS_CONTINUING := 5
    static DTC_STATUS_STOPPING := 6
    static DTC_STATUS_STOPPED := 7
    static DTC_STATUS_E_CANTCONTROL := 8
    static DTC_STATUS_FAILED := 9
}
struct DTC_GET_TRANSACTION_MANAGER extends FunctionPointer {
    static Types := [PSTR, PSTR, GUID.Ptr, UInt32, UInt16, Struct.Ptr, Struct.Ptr.Ptr, HRESULT]
    static Options := "C"
}
struct DTC_GET_TRANSACTION_MANAGER_EX_A extends FunctionPointer {
    static Types := [PSTR, PSTR, GUID.Ptr, UInt32, Struct.Ptr, Struct.Ptr.Ptr, HRESULT]
    static Options := "C"
}
struct DTC_GET_TRANSACTION_MANAGER_EX_W extends FunctionPointer {
    static Types := [PWSTR, PWSTR, GUID.Ptr, UInt32, Struct.Ptr, Struct.Ptr.Ptr, HRESULT]
    static Options := "C"
}
struct DTC_INSTALL_CLIENT extends FunctionPointer {
    static Types := [Int8.Ptr, UInt32, UInt32, HRESULT]
}
struct BOID {
    rgb : UInt8[16]
}
struct TX_MISC_CONSTANTS extends Int32 {
    static MAX_TRAN_DESC := 40
}
struct ISOLATIONLEVEL extends Int32 {
    static ISOLATIONLEVEL_UNSPECIFIED := -1
    static ISOLATIONLEVEL_CHAOS := 16
    static ISOLATIONLEVEL_READUNCOMMITTED := 256
    static ISOLATIONLEVEL_BROWSE := 256
    static ISOLATIONLEVEL_CURSORSTABILITY := 4096
    static ISOLATIONLEVEL_READCOMMITTED := 4096
    static ISOLATIONLEVEL_REPEATABLEREAD := 65536
    static ISOLATIONLEVEL_SERIALIZABLE := 1048576
    static ISOLATIONLEVEL_ISOLATED := 1048576
}
struct XACTTRANSINFO {
    uow : BOID
    isoLevel : Int32
    isoFlags : UInt32
    grfTCSupported : UInt32
    grfRMSupported : UInt32
    grfTCSupportedRetaining : UInt32
    grfRMSupportedRetaining : UInt32
}
struct XACTSTATS {
    cOpen : UInt32
    cCommitting : UInt32
    cCommitted : UInt32
    cAborting : UInt32
    cAborted : UInt32
    cInDoubt : UInt32
    cHeuristicDecision : UInt32
    timeTransactionsUp : FILETIME
}
struct ISOFLAG extends Int32 {
    static ISOFLAG_RETAIN_COMMIT_DC := 1
    static ISOFLAG_RETAIN_COMMIT := 2
    static ISOFLAG_RETAIN_COMMIT_NO := 3
    static ISOFLAG_RETAIN_ABORT_DC := 4
    static ISOFLAG_RETAIN_ABORT := 8
    static ISOFLAG_RETAIN_ABORT_NO := 12
    static ISOFLAG_RETAIN_DONTCARE := 5
    static ISOFLAG_RETAIN_BOTH := 10
    static ISOFLAG_RETAIN_NONE := 15
    static ISOFLAG_OPTIMISTIC := 16
    static ISOFLAG_READONLY := 32
}
struct XACTTC extends Int32 {
    static XACTTC_NONE := 0
    static XACTTC_SYNC_PHASEONE := 1
    static XACTTC_SYNC_PHASETWO := 2
    static XACTTC_SYNC := 2
    static XACTTC_ASYNC_PHASEONE := 4
    static XACTTC_ASYNC := 4
}
struct XACTRM extends Int32 {
    static XACTRM_OPTIMISTICLASTWINS := 1
    static XACTRM_NOREADONLYPREPARES := 2
}
struct XACTCONST extends Int32 {
    static XACTCONST_TIMEOUTINFINITE := 0
}
struct XACTHEURISTIC extends Int32 {
    static XACTHEURISTIC_ABORT := 1
    static XACTHEURISTIC_COMMIT := 2
    static XACTHEURISTIC_DAMAGE := 3
    static XACTHEURISTIC_DANGER := 4
}
struct XACTSTAT extends Int32 {
    static XACTSTAT_NONE := 0
    static XACTSTAT_OPENNORMAL := 1
    static XACTSTAT_OPENREFUSED := 2
    static XACTSTAT_PREPARING := 4
    static XACTSTAT_PREPARED := 8
    static XACTSTAT_PREPARERETAINING := 16
    static XACTSTAT_PREPARERETAINED := 32
    static XACTSTAT_COMMITTING := 64
    static XACTSTAT_COMMITRETAINING := 128
    static XACTSTAT_ABORTING := 256
    static XACTSTAT_ABORTED := 512
    static XACTSTAT_COMMITTED := 1024
    static XACTSTAT_HEURISTIC_ABORT := 2048
    static XACTSTAT_HEURISTIC_COMMIT := 4096
    static XACTSTAT_HEURISTIC_DAMAGE := 8192
    static XACTSTAT_HEURISTIC_DANGER := 16384
    static XACTSTAT_FORCED_ABORT := 32768
    static XACTSTAT_FORCED_COMMIT := 65536
    static XACTSTAT_INDOUBT := 131072
    static XACTSTAT_CLOSED := 262144
    static XACTSTAT_OPEN := 3
    static XACTSTAT_NOTPREPARED := 524227
    static XACTSTAT_ALL := 524287
}
struct XACTOPT {
    ulTimeout : UInt32
    szDescription : UInt8[40]
}
struct ITransaction extends IUnknown {
    static IID := "{0FB15084-AF41-11CE-BD2B-204C4F4F5020}"
    Commit(fRetaining, grfTC, grfRM)
      => ComCall(3, this.p, BOOL, fRetaining, UInt32, grfTC, UInt32, grfRM)
    Abort(pboidReason, fRetaining, fAsync)
      => ComCall(4, this.p, BOID.Ptr, pboidReason, BOOL, fRetaining, BOOL, fAsync)
    GetTransactionInfo(pinfo)
      => ComCall(5, this.p, XACTTRANSINFO.Ptr, pinfo)
}
struct ITransactionCloner extends ITransaction {
    static IID := "{02656950-2152-11D0-944C-00A0C905416E}"
    CloneWithCommitDisabled(ppITransaction)
      => ComCall(6, this.p, ITransaction.Ptr, ppITransaction)
}
struct ITransaction2 extends ITransactionCloner {
    static IID := "{34021548-0065-11D3-BAC1-00C04F797BE2}"
    GetTransactionInfo2(pinfo)
      => ComCall(7, this.p, XACTTRANSINFO.Ptr, pinfo)
}
struct ITransactionDispenser extends IUnknown {
    static IID := "{3A6AD9E1-23B9-11CF-AD60-00AA00A74CCD}"
    GetOptionsObject(ppOptions)
      => ComCall(3, this.p, ITransactionOptions.Ptr, ppOptions)
    BeginTransaction(punkOuter, isoLevel, isoFlags, pOptions, ppTransaction)
      => ComCall(4, this.p, IUnknown, punkOuter, Int32, isoLevel, UInt32, isoFlags, ITransactionOptions, pOptions, ITransaction.Ptr, ppTransaction)
}
struct ITransactionOptions extends IUnknown {
    static IID := "{3A6AD9E0-23B9-11CF-AD60-00AA00A74CCD}"
    SetOptions(pOptions)
      => ComCall(3, this.p, XACTOPT.Ptr, pOptions)
    GetOptions(pOptions)
      => ComCall(4, this.p, XACTOPT.Ptr, pOptions)
}
struct ITransactionOutcomeEvents extends IUnknown {
    static IID := "{3A6AD9E2-23B9-11CF-AD60-00AA00A74CCD}"
    Committed(fRetaining, pNewUOW, hr)
      => ComCall(3, this.p, BOOL, fRetaining, BOID.Ptr, pNewUOW, HRESULT, hr)
    Aborted(pboidReason, fRetaining, pNewUOW, hr)
      => ComCall(4, this.p, BOID.Ptr, pboidReason, BOOL, fRetaining, BOID.Ptr, pNewUOW, HRESULT, hr)
    HeuristicDecision(dwDecision, pboidReason, hr)
      => ComCall(5, this.p, UInt32, dwDecision, BOID.Ptr, pboidReason, HRESULT, hr)
    Indoubt()
      => ComCall(6, this.p)
}
struct ITmNodeName extends IUnknown {
    static IID := "{30274F88-6EE4-474E-9B95-7807BC9EF8CF}"
    GetNodeNameSize(pcbNodeNameSize)
      => ComCall(3, this.p, UInt32.Ptr, pcbNodeNameSize)
    GetNodeName(cbNodeNameBufferSize, pNodeNameBuffer)
      => ComCall(4, this.p, UInt32, cbNodeNameBufferSize, PWSTR, pNodeNameBuffer)
}
struct IKernelTransaction extends IUnknown {
    static IID := "{79427A2B-F895-40E0-BE79-B57DC82ED231}"
    GetHandle(pHandle)
      => ComCall(3, this.p, HANDLE.Ptr, pHandle)
}
struct ITransactionResourceAsync extends IUnknown {
    static IID := "{69E971F0-23CE-11CF-AD60-00AA00A74CCD}"
    PrepareRequest(fRetaining, grfRM, fWantMoniker, fSinglePhase)
      => ComCall(3, this.p, BOOL, fRetaining, UInt32, grfRM, BOOL, fWantMoniker, BOOL, fSinglePhase)
    CommitRequest(grfRM, pNewUOW)
      => ComCall(4, this.p, UInt32, grfRM, BOID.Ptr, pNewUOW)
    AbortRequest(pboidReason, fRetaining, pNewUOW)
      => ComCall(5, this.p, BOID.Ptr, pboidReason, BOOL, fRetaining, BOID.Ptr, pNewUOW)
    TMDown()
      => ComCall(6, this.p)
}
struct ITransactionLastResourceAsync extends IUnknown {
    static IID := "{C82BD532-5B30-11D3-8A91-00C04F79EB6D}"
    DelegateCommit(grfRM)
      => ComCall(3, this.p, UInt32, grfRM)
    ForgetRequest(pNewUOW)
      => ComCall(4, this.p, BOID.Ptr, pNewUOW)
}
struct ITransactionResource extends IUnknown {
    static IID := "{EE5FF7B3-4572-11D0-9452-00A0C905416E}"
    PrepareRequest(fRetaining, grfRM, fWantMoniker, fSinglePhase)
      => ComCall(3, this.p, BOOL, fRetaining, UInt32, grfRM, BOOL, fWantMoniker, BOOL, fSinglePhase)
    CommitRequest(grfRM, pNewUOW)
      => ComCall(4, this.p, UInt32, grfRM, BOID.Ptr, pNewUOW)
    AbortRequest(pboidReason, fRetaining, pNewUOW)
      => ComCall(5, this.p, BOID.Ptr, pboidReason, BOOL, fRetaining, BOID.Ptr, pNewUOW)
    TMDown()
      => ComCall(6, this.p)
}
struct ITransactionEnlistmentAsync extends IUnknown {
    static IID := "{0FB15081-AF41-11CE-BD2B-204C4F4F5020}"
    PrepareRequestDone(hr, pmk, pboidReason)
      => ComCall(3, this.p, HRESULT, hr, IMoniker, pmk, BOID.Ptr, pboidReason)
    CommitRequestDone(hr)
      => ComCall(4, this.p, HRESULT, hr)
    AbortRequestDone(hr)
      => ComCall(5, this.p, HRESULT, hr)
}
struct ITransactionLastEnlistmentAsync extends IUnknown {
    static IID := "{C82BD533-5B30-11D3-8A91-00C04F79EB6D}"
    TransactionOutcome(XactStat1, pboidReason)
      => ComCall(3, this.p, XACTSTAT, XactStat1, BOID.Ptr, pboidReason)
}
struct ITransactionExportFactory extends IUnknown {
    static IID := "{E1CF9B53-8745-11CE-A9BA-00AA006C3706}"
    GetRemoteClassId(pclsid)
      => ComCall(3, this.p, GUID.Ptr, pclsid)
    Create(rgbWhereabouts, ppExport)
      => ComCall(4, this.p, UInt32, rgbWhereabouts.Length, UInt8.Ptr, rgbWhereabouts, ITransactionExport.Ptr, ppExport)
}
struct ITransactionImportWhereabouts extends IUnknown {
    static IID := "{0141FDA4-8FC0-11CE-BD18-204C4F4F5020}"
    GetWhereaboutsSize(pcbWhereabouts)
      => ComCall(3, this.p, UInt32.Ptr, pcbWhereabouts)
    GetWhereabouts(rgbWhereabouts, pcbUsed)
      => ComCall(4, this.p, UInt32, rgbWhereabouts.Length, UInt8.Ptr, rgbWhereabouts, UInt32.Ptr, pcbUsed)
}
struct ITransactionExport extends IUnknown {
    static IID := "{0141FDA5-8FC0-11CE-BD18-204C4F4F5020}"
    Export(punkTransaction, pcbTransactionCookie)
      => ComCall(3, this.p, IUnknown, punkTransaction, UInt32.Ptr, pcbTransactionCookie)
    GetTransactionCookie(punkTransaction, rgbTransactionCookie, pcbUsed)
      => ComCall(4, this.p, IUnknown, punkTransaction, UInt32, rgbTransactionCookie.Length, UInt8.Ptr, rgbTransactionCookie, UInt32.Ptr, pcbUsed)
}
struct ITransactionImport extends IUnknown {
    static IID := "{E1CF9B5A-8745-11CE-A9BA-00AA006C3706}"
    Import(rgbTransactionCookie, piid, ppvTransaction)
      => ComCall(3, this.p, UInt32, rgbTransactionCookie.Length, UInt8.Ptr, rgbTransactionCookie, GUID.Ptr, piid, Struct.Ptr.Ptr, ppvTransaction)
}
struct ITipTransaction extends IUnknown {
    static IID := "{17CF72D0-BAC5-11D1-B1BF-00C04FC2F3EF}"
    Push(i_pszRemoteTmUrl, o_ppszRemoteTxUrl)
      => ComCall(3, this.p, UInt8.Ptr, i_pszRemoteTmUrl, PSTR.Ptr, o_ppszRemoteTxUrl)
    GetTransactionUrl(o_ppszLocalTxUrl)
      => ComCall(4, this.p, PSTR.Ptr, o_ppszLocalTxUrl)
}
struct ITipHelper extends IUnknown {
    static IID := "{17CF72D1-BAC5-11D1-B1BF-00C04FC2F3EF}"
    Pull(i_pszTxUrl, o_ppITransaction)
      => ComCall(3, this.p, UInt8.Ptr, i_pszTxUrl, ITransaction.Ptr, o_ppITransaction)
    PullAsync(i_pszTxUrl, i_pTipPullSink, o_ppITransaction)
      => ComCall(4, this.p, UInt8.Ptr, i_pszTxUrl, ITipPullSink, i_pTipPullSink, ITransaction.Ptr, o_ppITransaction)
    GetLocalTmUrl(o_ppszLocalTmUrl)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, o_ppszLocalTmUrl)
}
struct ITipPullSink extends IUnknown {
    static IID := "{17CF72D2-BAC5-11D1-B1BF-00C04FC2F3EF}"
    PullComplete(i_hrPull)
      => ComCall(3, this.p, HRESULT, i_hrPull)
}
struct IDtcNetworkAccessConfig extends IUnknown {
    static IID := "{9797C15D-A428-4291-87B6-0995031A678D}"
    GetAnyNetworkAccess(pbAnyNetworkAccess)
      => ComCall(3, this.p, BOOL.Ptr, pbAnyNetworkAccess)
    SetAnyNetworkAccess(bAnyNetworkAccess)
      => ComCall(4, this.p, BOOL, bAnyNetworkAccess)
    GetNetworkAdministrationAccess(pbNetworkAdministrationAccess)
      => ComCall(5, this.p, BOOL.Ptr, pbNetworkAdministrationAccess)
    SetNetworkAdministrationAccess(bNetworkAdministrationAccess)
      => ComCall(6, this.p, BOOL, bNetworkAdministrationAccess)
    GetNetworkTransactionAccess(pbNetworkTransactionAccess)
      => ComCall(7, this.p, BOOL.Ptr, pbNetworkTransactionAccess)
    SetNetworkTransactionAccess(bNetworkTransactionAccess)
      => ComCall(8, this.p, BOOL, bNetworkTransactionAccess)
    GetNetworkClientAccess(pbNetworkClientAccess)
      => ComCall(9, this.p, BOOL.Ptr, pbNetworkClientAccess)
    SetNetworkClientAccess(bNetworkClientAccess)
      => ComCall(10, this.p, BOOL, bNetworkClientAccess)
    GetNetworkTIPAccess(pbNetworkTIPAccess)
      => ComCall(11, this.p, BOOL.Ptr, pbNetworkTIPAccess)
    SetNetworkTIPAccess(bNetworkTIPAccess)
      => ComCall(12, this.p, BOOL, bNetworkTIPAccess)
    GetXAAccess(pbXAAccess)
      => ComCall(13, this.p, BOOL.Ptr, pbXAAccess)
    SetXAAccess(bXAAccess)
      => ComCall(14, this.p, BOOL, bXAAccess)
    RestartDtcService()
      => ComCall(15, this.p)
}
struct AUTHENTICATION_LEVEL extends Int32 {
    static NO_AUTHENTICATION_REQUIRED := 0
    static INCOMING_AUTHENTICATION_REQUIRED := 1
    static MUTUAL_AUTHENTICATION_REQUIRED := 2
}
struct IDtcNetworkAccessConfig2 extends IDtcNetworkAccessConfig {
    static IID := "{A7AA013B-EB7D-4F42-B41C-B2DEC09AE034}"
    GetNetworkInboundAccess(pbInbound)
      => ComCall(16, this.p, BOOL.Ptr, pbInbound)
    GetNetworkOutboundAccess(pbOutbound)
      => ComCall(17, this.p, BOOL.Ptr, pbOutbound)
    SetNetworkInboundAccess(bInbound)
      => ComCall(18, this.p, BOOL, bInbound)
    SetNetworkOutboundAccess(bOutbound)
      => ComCall(19, this.p, BOOL, bOutbound)
    GetAuthenticationLevel(pAuthLevel)
      => ComCall(20, this.p, AUTHENTICATION_LEVEL.Ptr, pAuthLevel)
    SetAuthenticationLevel(AuthLevel)
      => ComCall(21, this.p, AUTHENTICATION_LEVEL, AuthLevel)
}
struct IDtcNetworkAccessConfig3 extends IDtcNetworkAccessConfig2 {
    static IID := "{76E4B4F3-2CA5-466B-89D5-FD218EE75B49}"
    GetLUAccess(pbLUAccess)
      => ComCall(22, this.p, BOOL.Ptr, pbLUAccess)
    SetLUAccess(bLUAccess)
      => ComCall(23, this.p, BOOL, bLUAccess)
}
struct XID {
    formatID : Int32
    gtrid_length : Int32
    bqual_length : Int32
    data : CHAR[128]
}
struct xa_switch_t {
    name : CHAR[32]
    flags : Int32
    version : Int32
    xa_open_entry : IntPtr
    xa_close_entry : IntPtr
    xa_start_entry : IntPtr
    xa_end_entry : IntPtr
    xa_rollback_entry : IntPtr
    xa_prepare_entry : IntPtr
    xa_commit_entry : IntPtr
    xa_recover_entry : IntPtr
    xa_forget_entry : IntPtr
    xa_complete_entry : IntPtr
}
struct XA_OPEN_EPT extends FunctionPointer {
    static Types := [PSTR, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_CLOSE_EPT extends FunctionPointer {
    static Types := [PSTR, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_START_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_END_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_ROLLBACK_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_PREPARE_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_COMMIT_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_RECOVER_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_FORGET_EPT extends FunctionPointer {
    static Types := [XID.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct XA_COMPLETE_EPT extends FunctionPointer {
    static Types := [Int32.Ptr, Int32.Ptr, Int32, Int32, Int32]
    static Options := "C"
}
struct IDtcToXaMapper extends IUnknown {
    static IID := "{64FFABE0-7CE9-11D0-8CE6-00C04FDC877E}"
    RequestNewResourceManager(pszDSN, pszClientDllName, pdwRMCookie)
      => ComCall(3, this.p, PSTR, pszDSN, PSTR, pszClientDllName, UInt32.Ptr, pdwRMCookie)
    TranslateTridToXid(pdwITransaction, dwRMCookie, pXid)
      => ComCall(4, this.p, UInt32.Ptr, pdwITransaction, UInt32, dwRMCookie, XID.Ptr, pXid)
    EnlistResourceManager(dwRMCookie, pdwITransaction)
      => ComCall(5, this.p, UInt32, dwRMCookie, UInt32.Ptr, pdwITransaction)
    ReleaseResourceManager(dwRMCookie)
      => ComCall(6, this.p, UInt32, dwRMCookie)
}
struct IDtcToXaHelperFactory extends IUnknown {
    static IID := "{A9861610-304A-11D1-9813-00A0C905416E}"
    Create(pszDSN, pszClientDllName, pguidRm, ppXaHelper)
      => ComCall(3, this.p, PSTR, pszDSN, PSTR, pszClientDllName, GUID.Ptr, pguidRm, IDtcToXaHelper.Ptr, ppXaHelper)
}
struct IDtcToXaHelper extends IUnknown {
    static IID := "{A9861611-304A-11D1-9813-00A0C905416E}"
    Close(i_fDoRecovery)
      => ComCall(3, this.p, BOOL, i_fDoRecovery)
    TranslateTridToXid(pITransaction?, pguidBqual, pXid)
      => ComCall(4, this.p, ITransaction, pITransaction?, GUID.Ptr, pguidBqual, XID.Ptr, pXid)
}
struct IDtcToXaHelperSinglePipe extends IUnknown {
    static IID := "{47ED4971-53B3-11D1-BBB9-00C04FD658F6}"
    XARMCreate(pszDSN, pszClientDll, pdwRMCookie)
      => ComCall(3, this.p, PSTR, pszDSN, PSTR, pszClientDll, UInt32.Ptr, pdwRMCookie)
    ConvertTridToXID(pdwITrans, dwRMCookie, pxid)
      => ComCall(4, this.p, UInt32.Ptr, pdwITrans, UInt32, dwRMCookie, XID.Ptr, pxid)
    EnlistWithRM(dwRMCookie, i_pITransaction, i_pITransRes, o_ppITransEnslitment)
      => ComCall(5, this.p, UInt32, dwRMCookie, ITransaction, i_pITransaction, ITransactionResourceAsync, i_pITransRes, ITransactionEnlistmentAsync.Ptr, o_ppITransEnslitment)
    ReleaseRMCookie(i_dwRMCookie, i_fNormal)
      => ComCall(6, this.p, UInt32, i_dwRMCookie, BOOL, i_fNormal, "void")
}
struct APPLICATIONTYPE extends Int32 {
    static LOCAL_APPLICATIONTYPE := 0
    static CLUSTERRESOURCE_APPLICATIONTYPE := 1
}
struct OLE_TM_CONFIG_PARAMS_V1 {
    dwVersion : UInt32
    dwcConcurrencyHint : UInt32
}
struct OLE_TM_CONFIG_PARAMS_V2 {
    dwVersion : UInt32
    dwcConcurrencyHint : UInt32
    applicationType : APPLICATIONTYPE
    clusterResourceId : GUID
}
struct XACT_DTC_CONSTANTS extends Int32 {
    static XACT_E_CONNECTION_REQUEST_DENIED := -2147168000
    static XACT_E_TOOMANY_ENLISTMENTS := -2147167999
    static XACT_E_DUPLICATE_GUID := -2147167998
    static XACT_E_NOTSINGLEPHASE := -2147167997
    static XACT_E_RECOVERYALREADYDONE := -2147167996
    static XACT_E_PROTOCOL := -2147167995
    static XACT_E_RM_FAILURE := -2147167994
    static XACT_E_RECOVERY_FAILED := -2147167993
    static XACT_E_LU_NOT_FOUND := -2147167992
    static XACT_E_DUPLICATE_LU := -2147167991
    static XACT_E_LU_NOT_CONNECTED := -2147167990
    static XACT_E_DUPLICATE_TRANSID := -2147167989
    static XACT_E_LU_BUSY := -2147167988
    static XACT_E_LU_NO_RECOVERY_PROCESS := -2147167987
    static XACT_E_LU_DOWN := -2147167986
    static XACT_E_LU_RECOVERING := -2147167985
    static XACT_E_LU_RECOVERY_MISMATCH := -2147167984
    static XACT_E_RM_UNAVAILABLE := -2147167983
    static XACT_E_LRMRECOVERYALREADYDONE := -2147167982
    static XACT_E_NOLASTRESOURCEINTERFACE := -2147167981
    static XACT_S_NONOTIFY := 315648
    static XACT_OK_NONOTIFY := 315649
    static dwUSER_MS_SQLSERVER := 65535
}
struct IXATransLookup extends IUnknown {
    static IID := "{F3B1F131-EEDA-11CE-AED4-00AA0051E2C4}"
    Lookup(ppTransaction)
      => ComCall(3, this.p, ITransaction.Ptr, ppTransaction)
}
struct IXATransLookup2 extends IUnknown {
    static IID := "{BF193C85-0D1A-4290-B88F-D2CB8873D1E7}"
    Lookup(pXID, ppTransaction)
      => ComCall(3, this.p, XID.Ptr, pXID, ITransaction.Ptr, ppTransaction)
}
struct IResourceManagerSink extends IUnknown {
    static IID := "{0D563181-DEFB-11CE-AED1-00AA0051E2C4}"
    TMDown()
      => ComCall(3, this.p)
}
struct IResourceManager extends IUnknown {
    static IID := "{13741D21-87EB-11CE-8081-0080C758527E}"
    Enlist(pTransaction?, pRes?, pUOW, pisoLevel, ppEnlist)
      => ComCall(3, this.p, ITransaction, pTransaction?, ITransactionResourceAsync, pRes?, BOID.Ptr, pUOW, Int32.Ptr, pisoLevel, ITransactionEnlistmentAsync.Ptr, ppEnlist)
    Reenlist(pPrepInfo, lTimeout, pXactStat)
      => ComCall(4, this.p, UInt8.Ptr, pPrepInfo, UInt32, pPrepInfo.Length, UInt32, lTimeout, XACTSTAT.Ptr, pXactStat)
    ReenlistmentComplete()
      => ComCall(5, this.p)
    GetDistributedTransactionManager(iid, ppvObject)
      => ComCall(6, this.p, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject)
}
struct ILastResourceManager extends IUnknown {
    static IID := "{4D964AD4-5B33-11D3-8A91-00C04F79EB6D}"
    TransactionCommitted(pPrepInfo)
      => ComCall(3, this.p, UInt8.Ptr, pPrepInfo, UInt32, pPrepInfo.Length)
    RecoveryDone()
      => ComCall(4, this.p)
}
struct IResourceManager2 extends IResourceManager {
    static IID := "{D136C69A-F749-11D1-8F47-00C04F8EE57D}"
    Enlist2(pTransaction?, pResAsync?, pUOW, pisoLevel, pXid, ppEnlist)
      => ComCall(7, this.p, ITransaction, pTransaction?, ITransactionResourceAsync, pResAsync?, BOID.Ptr, pUOW, Int32.Ptr, pisoLevel, XID.Ptr, pXid, ITransactionEnlistmentAsync.Ptr, ppEnlist)
    Reenlist2(pXid, dwTimeout, pXactStat)
      => ComCall(8, this.p, XID.Ptr, pXid, UInt32, dwTimeout, XACTSTAT.Ptr, pXactStat)
}
struct IResourceManagerRejoinable extends IResourceManager2 {
    static IID := "{6F6DE620-B5DF-4F3E-9CFA-C8AEBD05172B}"
    Rejoin(pPrepInfo, lTimeout, pXactStat)
      => ComCall(9, this.p, UInt8.Ptr, pPrepInfo, UInt32, pPrepInfo.Length, UInt32, lTimeout, XACTSTAT.Ptr, pXactStat)
}
struct IXAConfig extends IUnknown {
    static IID := "{C8A6E3A1-9A8C-11CF-A308-00A0C905416E}"
    Initialize(clsidHelperDll)
      => ComCall(3, this.p, GUID, clsidHelperDll)
    Terminate()
      => ComCall(4, this.p)
}
struct IRMHelper extends IUnknown {
    static IID := "{E793F6D1-F53D-11CF-A60D-00A0C905416E}"
    RMCount(dwcTotalNumberOfRMs)
      => ComCall(3, this.p, UInt32, dwcTotalNumberOfRMs)
    RMInfo(pXa_Switch, fCDeclCallingConv, pszOpenString, pszCloseString, guidRMRecovery)
      => ComCall(4, this.p, xa_switch_t.Ptr, pXa_Switch, BOOL, fCDeclCallingConv, PSTR, pszOpenString, PSTR, pszCloseString, GUID, guidRMRecovery)
}
struct IXAObtainRMInfo extends IUnknown {
    static IID := "{E793F6D2-F53D-11CF-A60D-00A0C905416E}"
    ObtainRMInfo(pIRMHelper?)
      => ComCall(3, this.p, IRMHelper, pIRMHelper?)
}
struct IResourceManagerFactory extends IUnknown {
    static IID := "{13741D20-87EB-11CE-8081-0080C758527E}"
    Create(pguidRM, pszRMName, pIResMgrSink?, ppResMgr)
      => ComCall(3, this.p, GUID.Ptr, pguidRM, PSTR, pszRMName, IResourceManagerSink, pIResMgrSink?, IResourceManager.Ptr, ppResMgr)
}
struct IResourceManagerFactory2 extends IResourceManagerFactory {
    static IID := "{6B369C21-FBD2-11D1-8F47-00C04F8EE57D}"
    CreateEx(pguidRM, pszRMName, pIResMgrSink?, riidRequested, ppvResMgr)
      => ComCall(4, this.p, GUID.Ptr, pguidRM, PSTR, pszRMName, IResourceManagerSink, pIResMgrSink?, GUID.Ptr, riidRequested, Struct.Ptr.Ptr, ppvResMgr)
}
struct IPrepareInfo extends IUnknown {
    static IID := "{80C7BFD0-87EE-11CE-8081-0080C758527E}"
    GetPrepareInfoSize(pcbPrepInfo)
      => ComCall(3, this.p, UInt32.Ptr, pcbPrepInfo)
    GetPrepareInfo(pPrepInfo)
      => ComCall(4, this.p, UInt8.Ptr, pPrepInfo)
}
struct IPrepareInfo2 extends IUnknown {
    static IID := "{5FAB2547-9779-11D1-B886-00C04FB9618A}"
    GetPrepareInfoSize(pcbPrepInfo)
      => ComCall(3, this.p, UInt32.Ptr, pcbPrepInfo)
    GetPrepareInfo(pPrepInfo)
      => ComCall(4, this.p, UInt32, pPrepInfo.Length, UInt8.Ptr, pPrepInfo)
}
struct IGetDispenser extends IUnknown {
    static IID := "{C23CC370-87EF-11CE-8081-0080C758527E}"
    GetDispenser(iid, ppvObject)
      => ComCall(3, this.p, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject)
}
struct ITransactionVoterBallotAsync2 extends IUnknown {
    static IID := "{5433376C-414D-11D3-B206-00C04FC2F3EF}"
    VoteRequestDone(hr, pboidReason?)
      => ComCall(3, this.p, HRESULT, hr, BOID.Ptr, pboidReason?)
}
struct ITransactionVoterNotifyAsync2 extends ITransactionOutcomeEvents {
    static IID := "{5433376B-414D-11D3-B206-00C04FC2F3EF}"
    VoteRequest()
      => ComCall(7, this.p)
}
struct ITransactionVoterFactory2 extends IUnknown {
    static IID := "{5433376A-414D-11D3-B206-00C04FC2F3EF}"
    Create(pTransaction?, pVoterNotify?, ppVoterBallot)
      => ComCall(3, this.p, ITransaction, pTransaction?, ITransactionVoterNotifyAsync2, pVoterNotify?, ITransactionVoterBallotAsync2.Ptr, ppVoterBallot)
}
struct ITransactionPhase0EnlistmentAsync extends IUnknown {
    static IID := "{82DC88E1-A954-11D1-8F88-00600895E7D5}"
    Enable()
      => ComCall(3, this.p)
    WaitForEnlistment()
      => ComCall(4, this.p)
    Phase0Done()
      => ComCall(5, this.p)
    Unenlist()
      => ComCall(6, this.p)
    GetTransaction(ppITransaction)
      => ComCall(7, this.p, ITransaction.Ptr, ppITransaction)
}
struct ITransactionPhase0NotifyAsync extends IUnknown {
    static IID := "{EF081809-0C76-11D2-87A6-00C04F990F34}"
    Phase0Request(fAbortingHint)
      => ComCall(3, this.p, BOOL, fAbortingHint)
    EnlistCompleted(status)
      => ComCall(4, this.p, HRESULT, status)
}
struct ITransactionPhase0Factory extends IUnknown {
    static IID := "{82DC88E0-A954-11D1-8F88-00600895E7D5}"
    Create(pPhase0Notify?, ppPhase0Enlistment)
      => ComCall(3, this.p, ITransactionPhase0NotifyAsync, pPhase0Notify?, ITransactionPhase0EnlistmentAsync.Ptr, ppPhase0Enlistment)
}
struct ITransactionTransmitter extends IUnknown {
    static IID := "{59313E01-B36C-11CF-A539-00AA006887C3}"
    Set(pTransaction?)
      => ComCall(3, this.p, ITransaction, pTransaction?)
    GetPropagationTokenSize(pcbToken)
      => ComCall(4, this.p, UInt32.Ptr, pcbToken)
    MarshalPropagationToken(rgbToken, pcbUsed)
      => ComCall(5, this.p, UInt32, rgbToken.Length, UInt8.Ptr, rgbToken, UInt32.Ptr, pcbUsed)
    UnmarshalReturnToken(rgbReturnToken)
      => ComCall(6, this.p, UInt32, rgbReturnToken.Length, UInt8.Ptr, rgbReturnToken)
    Reset()
      => ComCall(7, this.p)
}
struct ITransactionTransmitterFactory extends IUnknown {
    static IID := "{59313E00-B36C-11CF-A539-00AA006887C3}"
    Create(ppTransmitter)
      => ComCall(3, this.p, ITransactionTransmitter.Ptr, ppTransmitter)
}
struct ITransactionReceiver extends IUnknown {
    static IID := "{59313E03-B36C-11CF-A539-00AA006887C3}"
    UnmarshalPropagationToken(rgbToken, ppTransaction)
      => ComCall(3, this.p, UInt32, rgbToken.Length, UInt8.Ptr, rgbToken, ITransaction.Ptr, ppTransaction)
    GetReturnTokenSize(pcbReturnToken)
      => ComCall(4, this.p, UInt32.Ptr, pcbReturnToken)
    MarshalReturnToken(rgbReturnToken, pcbUsed)
      => ComCall(5, this.p, UInt32, rgbReturnToken.Length, UInt8.Ptr, rgbReturnToken, UInt32.Ptr, pcbUsed)
    Reset()
      => ComCall(6, this.p)
}
struct ITransactionReceiverFactory extends IUnknown {
    static IID := "{59313E02-B36C-11CF-A539-00AA006887C3}"
    Create(ppReceiver)
      => ComCall(3, this.p, ITransactionReceiver.Ptr, ppReceiver)
}
struct PROXY_CONFIG_PARAMS {
    wcThreadsMax : UInt16
}
struct IDtcLuConfigure extends IUnknown {
    static IID := "{4131E760-1AEA-11D0-944B-00A0C905416E}"
    Add(pucLuPair)
      => ComCall(3, this.p, UInt8.Ptr, pucLuPair, UInt32, pucLuPair.Length)
    Delete(pucLuPair)
      => ComCall(4, this.p, UInt8.Ptr, pucLuPair, UInt32, pucLuPair.Length)
}
struct IDtcLuRecovery extends IUnknown {
    static IID := "{AC2B8AD2-D6F0-11D0-B386-00A0C9083365}"
}
struct IDtcLuRecoveryFactory extends IUnknown {
    static IID := "{4131E762-1AEA-11D0-944B-00A0C905416E}"
    Create(pucLuPair, ppRecovery)
      => ComCall(3, this.p, UInt8.Ptr, pucLuPair, UInt32, pucLuPair.Length, IDtcLuRecovery.Ptr, ppRecovery)
}
struct DTCINITIATEDRECOVERYWORK extends Int32 {
    static DTCINITIATEDRECOVERYWORK_CHECKLUSTATUS := 1
    static DTCINITIATEDRECOVERYWORK_TRANS := 2
    static DTCINITIATEDRECOVERYWORK_TMDOWN := 3
}
struct DTCLUXLN extends Int32 {
    static DTCLUXLN_COLD := 1
    static DTCLUXLN_WARM := 2
}
struct DTCLUXLNCONFIRMATION extends Int32 {
    static DTCLUXLNCONFIRMATION_CONFIRM := 1
    static DTCLUXLNCONFIRMATION_LOGNAMEMISMATCH := 2
    static DTCLUXLNCONFIRMATION_COLDWARMMISMATCH := 3
    static DTCLUXLNCONFIRMATION_OBSOLETE := 4
}
struct DTCLUXLNRESPONSE extends Int32 {
    static DTCLUXLNRESPONSE_OK_SENDOURXLNBACK := 1
    static DTCLUXLNRESPONSE_OK_SENDCONFIRMATION := 2
    static DTCLUXLNRESPONSE_LOGNAMEMISMATCH := 3
    static DTCLUXLNRESPONSE_COLDWARMMISMATCH := 4
}
struct DTCLUXLNERROR extends Int32 {
    static DTCLUXLNERROR_PROTOCOL := 1
    static DTCLUXLNERROR_LOGNAMEMISMATCH := 2
    static DTCLUXLNERROR_COLDWARMMISMATCH := 3
}
struct DTCLUCOMPARESTATE extends Int32 {
    static DTCLUCOMPARESTATE_COMMITTED := 1
    static DTCLUCOMPARESTATE_HEURISTICCOMMITTED := 2
    static DTCLUCOMPARESTATE_HEURISTICMIXED := 3
    static DTCLUCOMPARESTATE_HEURISTICRESET := 4
    static DTCLUCOMPARESTATE_INDOUBT := 5
    static DTCLUCOMPARESTATE_RESET := 6
}
struct DTCLUCOMPARESTATESCONFIRMATION extends Int32 {
    static DTCLUCOMPARESTATESCONFIRMATION_CONFIRM := 1
    static DTCLUCOMPARESTATESCONFIRMATION_PROTOCOL := 2
}
struct DTCLUCOMPARESTATESERROR extends Int32 {
    static DTCLUCOMPARESTATESERROR_PROTOCOL := 1
}
struct DTCLUCOMPARESTATESRESPONSE extends Int32 {
    static DTCLUCOMPARESTATESRESPONSE_OK := 1
    static DTCLUCOMPARESTATESRESPONSE_PROTOCOL := 2
}
struct IDtcLuRecoveryInitiatedByDtcTransWork extends IUnknown {
    static IID := "{4131E765-1AEA-11D0-944B-00A0C905416E}"
    GetLogNameSizes(pcbOurLogName, pcbRemoteLogName)
      => ComCall(3, this.p, UInt32.Ptr, pcbOurLogName, UInt32.Ptr, pcbRemoteLogName)
    GetOurXln(pXln, pOurLogName, pRemoteLogName, pdwProtocol)
      => ComCall(4, this.p, DTCLUXLN.Ptr, pXln, UInt8.Ptr, pOurLogName, UInt8.Ptr, pRemoteLogName, UInt32.Ptr, pdwProtocol)
    HandleConfirmationFromOurXln(Confirmation)
      => ComCall(5, this.p, DTCLUXLNCONFIRMATION, Confirmation)
    HandleTheirXlnResponse(Xln, pRemoteLogName, cbRemoteLogName, dwProtocol, pConfirmation)
      => ComCall(6, this.p, DTCLUXLN, Xln, UInt8.Ptr, pRemoteLogName, UInt32, cbRemoteLogName, UInt32, dwProtocol, DTCLUXLNCONFIRMATION.Ptr, pConfirmation)
    HandleErrorFromOurXln(Error)
      => ComCall(7, this.p, DTCLUXLNERROR, Error)
    CheckForCompareStates(fCompareStates)
      => ComCall(8, this.p, BOOL.Ptr, fCompareStates)
    GetOurTransIdSize(pcbOurTransId)
      => ComCall(9, this.p, UInt32.Ptr, pcbOurTransId)
    GetOurCompareStates(pOurTransId, pCompareState)
      => ComCall(10, this.p, UInt8.Ptr, pOurTransId, DTCLUCOMPARESTATE.Ptr, pCompareState)
    HandleTheirCompareStatesResponse(CompareState, pConfirmation)
      => ComCall(11, this.p, DTCLUCOMPARESTATE, CompareState, DTCLUCOMPARESTATESCONFIRMATION.Ptr, pConfirmation)
    HandleErrorFromOurCompareStates(Error)
      => ComCall(12, this.p, DTCLUCOMPARESTATESERROR, Error)
    ConversationLost()
      => ComCall(13, this.p)
    GetRecoverySeqNum(plRecoverySeqNum)
      => ComCall(14, this.p, Int32.Ptr, plRecoverySeqNum)
    ObsoleteRecoverySeqNum(lNewRecoverySeqNum)
      => ComCall(15, this.p, Int32, lNewRecoverySeqNum)
}
struct IDtcLuRecoveryInitiatedByDtcStatusWork extends IUnknown {
    static IID := "{4131E766-1AEA-11D0-944B-00A0C905416E}"
    HandleCheckLuStatus(lRecoverySeqNum)
      => ComCall(3, this.p, Int32, lRecoverySeqNum)
}
struct IDtcLuRecoveryInitiatedByDtc extends IUnknown {
    static IID := "{4131E764-1AEA-11D0-944B-00A0C905416E}"
    GetWork(pWork, ppv)
      => ComCall(3, this.p, DTCINITIATEDRECOVERYWORK.Ptr, pWork, Struct.Ptr.Ptr, ppv)
}
struct IDtcLuRecoveryInitiatedByLuWork extends IUnknown {
    static IID := "{AC2B8AD1-D6F0-11D0-B386-00A0C9083365}"
    HandleTheirXln(lRecoverySeqNum, Xln, pRemoteLogName, cbRemoteLogName, pOurLogName, cbOurLogName, dwProtocol, pResponse)
      => ComCall(3, this.p, Int32, lRecoverySeqNum, DTCLUXLN, Xln, UInt8.Ptr, pRemoteLogName, UInt32, cbRemoteLogName, UInt8.Ptr, pOurLogName, UInt32, cbOurLogName, UInt32, dwProtocol, DTCLUXLNRESPONSE.Ptr, pResponse)
    GetOurLogNameSize(pcbOurLogName)
      => ComCall(4, this.p, UInt32.Ptr, pcbOurLogName)
    GetOurXln(pXln, pOurLogName, pdwProtocol)
      => ComCall(5, this.p, DTCLUXLN.Ptr, pXln, UInt8.Ptr, pOurLogName, UInt32.Ptr, pdwProtocol)
    HandleConfirmationOfOurXln(Confirmation)
      => ComCall(6, this.p, DTCLUXLNCONFIRMATION, Confirmation)
    HandleTheirCompareStates(pRemoteTransId, cbRemoteTransId, CompareState, pResponse, pCompareState)
      => ComCall(7, this.p, UInt8.Ptr, pRemoteTransId, UInt32, cbRemoteTransId, DTCLUCOMPARESTATE, CompareState, DTCLUCOMPARESTATESRESPONSE.Ptr, pResponse, DTCLUCOMPARESTATE.Ptr, pCompareState)
    HandleConfirmationOfOurCompareStates(Confirmation)
      => ComCall(8, this.p, DTCLUCOMPARESTATESCONFIRMATION, Confirmation)
    HandleErrorFromOurCompareStates(Error)
      => ComCall(9, this.p, DTCLUCOMPARESTATESERROR, Error)
    ConversationLost()
      => ComCall(10, this.p)
}
struct IDtcLuRecoveryInitiatedByLu extends IUnknown {
    static IID := "{4131E768-1AEA-11D0-944B-00A0C905416E}"
    GetObjectToHandleWorkFromLu(ppWork)
      => ComCall(3, this.p, IDtcLuRecoveryInitiatedByLuWork.Ptr, ppWork)
}
struct IDtcLuRmEnlistment extends IUnknown {
    static IID := "{4131E769-1AEA-11D0-944B-00A0C905416E}"
    Unplug(fConversationLost)
      => ComCall(3, this.p, BOOL, fConversationLost)
    BackedOut()
      => ComCall(4, this.p)
    BackOut()
      => ComCall(5, this.p)
    Committed()
      => ComCall(6, this.p)
    Forget()
      => ComCall(7, this.p)
    RequestCommit()
      => ComCall(8, this.p)
}
struct IDtcLuRmEnlistmentSink extends IUnknown {
    static IID := "{4131E770-1AEA-11D0-944B-00A0C905416E}"
    AckUnplug()
      => ComCall(3, this.p)
    TmDown()
      => ComCall(4, this.p)
    SessionLost()
      => ComCall(5, this.p)
    BackedOut()
      => ComCall(6, this.p)
    BackOut()
      => ComCall(7, this.p)
    Committed()
      => ComCall(8, this.p)
    Forget()
      => ComCall(9, this.p)
    Prepare()
      => ComCall(10, this.p)
    RequestCommit()
      => ComCall(11, this.p)
}
struct IDtcLuRmEnlistmentFactory extends IUnknown {
    static IID := "{4131E771-1AEA-11D0-944B-00A0C905416E}"
    Create(pucLuPair, cbLuPair, pITransaction, pTransId, cbTransId, pRmEnlistmentSink, ppRmEnlistment)
      => ComCall(3, this.p, UInt8.Ptr, pucLuPair, UInt32, cbLuPair, ITransaction, pITransaction, UInt8.Ptr, pTransId, UInt32, cbTransId, IDtcLuRmEnlistmentSink, pRmEnlistmentSink, IDtcLuRmEnlistment.Ptr, ppRmEnlistment)
}
struct IDtcLuSubordinateDtc extends IUnknown {
    static IID := "{4131E773-1AEA-11D0-944B-00A0C905416E}"
    Unplug(fConversationLost)
      => ComCall(3, this.p, BOOL, fConversationLost)
    BackedOut()
      => ComCall(4, this.p)
    BackOut()
      => ComCall(5, this.p)
    Committed()
      => ComCall(6, this.p)
    Forget()
      => ComCall(7, this.p)
    Prepare()
      => ComCall(8, this.p)
    RequestCommit()
      => ComCall(9, this.p)
}
struct IDtcLuSubordinateDtcSink extends IUnknown {
    static IID := "{4131E774-1AEA-11D0-944B-00A0C905416E}"
    AckUnplug()
      => ComCall(3, this.p)
    TmDown()
      => ComCall(4, this.p)
    SessionLost()
      => ComCall(5, this.p)
    BackedOut()
      => ComCall(6, this.p)
    BackOut()
      => ComCall(7, this.p)
    Committed()
      => ComCall(8, this.p)
    Forget()
      => ComCall(9, this.p)
    RequestCommit()
      => ComCall(10, this.p)
}
struct IDtcLuSubordinateDtcFactory extends IUnknown {
    static IID := "{4131E775-1AEA-11D0-944B-00A0C905416E}"
    Create(pucLuPair, cbLuPair, punkTransactionOuter, isoLevel, isoFlags, pOptions, ppTransaction, pTransId, cbTransId, pSubordinateDtcSink, ppSubordinateDtc)
      => ComCall(3, this.p, UInt8.Ptr, pucLuPair, UInt32, cbLuPair, IUnknown, punkTransactionOuter, Int32, isoLevel, UInt32, isoFlags, ITransactionOptions, pOptions, ITransaction.Ptr, ppTransaction, UInt8.Ptr, pTransId, UInt32, cbTransId, IDtcLuSubordinateDtcSink, pSubordinateDtcSink, IDtcLuSubordinateDtc.Ptr, ppSubordinateDtc)
}
