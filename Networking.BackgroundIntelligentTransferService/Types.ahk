#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct BG_TOKEN extends UInt32 {
    static BG_TOKEN_LOCAL_FILE := 1
    static BG_TOKEN_NETWORK := 2
}
struct BG_FILE_PROGRESS {
    BytesTotal : Int64
    BytesTransferred : Int64
    Completed : BOOL
}
struct IBackgroundCopyFile extends IUnknown {
    static IID := "{01B7BD23-FB88-4A77-8490-5891D3E4653A}"
    GetRemoteName(pVal)
      => ComCall(3, this.p, PWSTR.Ptr, pVal)
    GetLocalName(pVal)
      => ComCall(4, this.p, PWSTR.Ptr, pVal)
    GetProgress(pVal)
      => ComCall(5, this.p, BG_FILE_PROGRESS.Ptr, pVal)
}
struct IEnumBackgroundCopyFiles extends IUnknown {
    static IID := "{CA51E165-C365-424C-8D41-24AAA4FF3C40}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IBackgroundCopyFile.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBackgroundCopyFiles.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct BG_ERROR_CONTEXT extends Int32 {
    static BG_ERROR_CONTEXT_NONE := 0
    static BG_ERROR_CONTEXT_UNKNOWN := 1
    static BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER := 2
    static BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION := 3
    static BG_ERROR_CONTEXT_LOCAL_FILE := 4
    static BG_ERROR_CONTEXT_REMOTE_FILE := 5
    static BG_ERROR_CONTEXT_GENERAL_TRANSPORT := 6
    static BG_ERROR_CONTEXT_REMOTE_APPLICATION := 7
    static BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK := 8
}
struct IBackgroundCopyError extends IUnknown {
    static IID := "{19C613A0-FCB8-4F28-81AE-897C3D078F81}"
    GetError(pContext, pCode)
      => ComCall(3, this.p, BG_ERROR_CONTEXT.Ptr, pContext, HRESULT.Ptr, pCode)
    GetFile(pVal)
      => ComCall(4, this.p, IBackgroundCopyFile.Ptr, pVal)
    GetErrorDescription(LanguageId, pErrorDescription)
      => ComCall(5, this.p, UInt32, LanguageId, PWSTR.Ptr, pErrorDescription)
    GetErrorContextDescription(LanguageId, pContextDescription)
      => ComCall(6, this.p, UInt32, LanguageId, PWSTR.Ptr, pContextDescription)
    GetProtocol(pProtocol)
      => ComCall(7, this.p, PWSTR.Ptr, pProtocol)
}
struct BG_FILE_INFO {
    RemoteName : PWSTR
    LocalName : PWSTR
}
struct BG_JOB_PROGRESS {
    BytesTotal : Int64
    BytesTransferred : Int64
    FilesTotal : UInt32
    FilesTransferred : UInt32
}
struct BG_JOB_TIMES {
    CreationTime : FILETIME
    ModificationTime : FILETIME
    TransferCompletionTime : FILETIME
}
struct BG_JOB_PRIORITY extends Int32 {
    static BG_JOB_PRIORITY_FOREGROUND := 0
    static BG_JOB_PRIORITY_HIGH := 1
    static BG_JOB_PRIORITY_NORMAL := 2
    static BG_JOB_PRIORITY_LOW := 3
}
struct BG_JOB_STATE extends Int32 {
    static BG_JOB_STATE_QUEUED := 0
    static BG_JOB_STATE_CONNECTING := 1
    static BG_JOB_STATE_TRANSFERRING := 2
    static BG_JOB_STATE_SUSPENDED := 3
    static BG_JOB_STATE_ERROR := 4
    static BG_JOB_STATE_TRANSIENT_ERROR := 5
    static BG_JOB_STATE_TRANSFERRED := 6
    static BG_JOB_STATE_ACKNOWLEDGED := 7
    static BG_JOB_STATE_CANCELLED := 8
}
struct BG_JOB_TYPE extends Int32 {
    static BG_JOB_TYPE_DOWNLOAD := 0
    static BG_JOB_TYPE_UPLOAD := 1
    static BG_JOB_TYPE_UPLOAD_REPLY := 2
}
struct BG_JOB_PROXY_USAGE extends Int32 {
    static BG_JOB_PROXY_USAGE_PRECONFIG := 0
    static BG_JOB_PROXY_USAGE_NO_PROXY := 1
    static BG_JOB_PROXY_USAGE_OVERRIDE := 2
    static BG_JOB_PROXY_USAGE_AUTODETECT := 3
}
struct IBackgroundCopyJob extends IUnknown {
    static IID := "{37668D37-507E-4160-9316-26306D150B12}"
    AddFileSet(pFileSet)
      => ComCall(3, this.p, UInt32, pFileSet.Length, BG_FILE_INFO.Ptr, pFileSet)
    AddFile(RemoteUrl, LocalName)
      => ComCall(4, this.p, "Str", RemoteUrl, "Str", LocalName)
    EnumFiles(pEnum)
      => ComCall(5, this.p, IEnumBackgroundCopyFiles.Ptr, pEnum)
    Suspend()
      => ComCall(6, this.p)
    Resume()
      => ComCall(7, this.p)
    Cancel()
      => ComCall(8, this.p)
    Complete()
      => ComCall(9, this.p)
    GetId(pVal)
      => ComCall(10, this.p, GUID.Ptr, pVal)
    GetType(pVal)
      => ComCall(11, this.p, BG_JOB_TYPE.Ptr, pVal)
    GetProgress(pVal)
      => ComCall(12, this.p, BG_JOB_PROGRESS.Ptr, pVal)
    GetTimes(pVal)
      => ComCall(13, this.p, BG_JOB_TIMES.Ptr, pVal)
    GetState(pVal)
      => ComCall(14, this.p, BG_JOB_STATE.Ptr, pVal)
    GetError(ppError)
      => ComCall(15, this.p, IBackgroundCopyError.Ptr, ppError)
    GetOwner(pVal)
      => ComCall(16, this.p, PWSTR.Ptr, pVal)
    SetDisplayName(Val)
      => ComCall(17, this.p, "Str", Val)
    GetDisplayName(pVal)
      => ComCall(18, this.p, PWSTR.Ptr, pVal)
    SetDescription(Val)
      => ComCall(19, this.p, "Str", Val)
    GetDescription(pVal)
      => ComCall(20, this.p, PWSTR.Ptr, pVal)
    SetPriority(Val)
      => ComCall(21, this.p, BG_JOB_PRIORITY, Val)
    GetPriority(pVal)
      => ComCall(22, this.p, BG_JOB_PRIORITY.Ptr, pVal)
    SetNotifyFlags(Val)
      => ComCall(23, this.p, UInt32, Val)
    GetNotifyFlags(pVal)
      => ComCall(24, this.p, UInt32.Ptr, pVal)
    SetNotifyInterface(Val)
      => ComCall(25, this.p, IUnknown, Val)
    GetNotifyInterface(pVal)
      => ComCall(26, this.p, IUnknown.Ptr, pVal)
    SetMinimumRetryDelay(Seconds)
      => ComCall(27, this.p, UInt32, Seconds)
    GetMinimumRetryDelay(Seconds)
      => ComCall(28, this.p, UInt32.Ptr, Seconds)
    SetNoProgressTimeout(Seconds)
      => ComCall(29, this.p, UInt32, Seconds)
    GetNoProgressTimeout(Seconds)
      => ComCall(30, this.p, UInt32.Ptr, Seconds)
    GetErrorCount(Errors)
      => ComCall(31, this.p, UInt32.Ptr, Errors)
    SetProxySettings(ProxyUsage, ProxyList, ProxyBypassList)
      => ComCall(32, this.p, BG_JOB_PROXY_USAGE, ProxyUsage, "Str", ProxyList, "Str", ProxyBypassList)
    GetProxySettings(pProxyUsage, pProxyList, pProxyBypassList)
      => ComCall(33, this.p, BG_JOB_PROXY_USAGE.Ptr, pProxyUsage, PWSTR.Ptr, pProxyList, PWSTR.Ptr, pProxyBypassList)
    TakeOwnership()
      => ComCall(34, this.p)
}
struct IEnumBackgroundCopyJobs extends IUnknown {
    static IID := "{1AF4F612-3B71-466F-8F58-7B6F73AC57AD}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IBackgroundCopyJob.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBackgroundCopyJobs.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct IBackgroundCopyCallback extends IUnknown {
    static IID := "{97EA99C7-0186-4AD4-8DF9-C5B4E0ED6B22}"
    JobTransferred(pJob)
      => ComCall(3, this.p, IBackgroundCopyJob, pJob)
    JobError(pJob, pError)
      => ComCall(4, this.p, IBackgroundCopyJob, pJob, IBackgroundCopyError, pError)
    JobModification(pJob, dwReserved)
      => ComCall(5, this.p, IBackgroundCopyJob, pJob, UInt32, dwReserved)
}
struct AsyncIBackgroundCopyCallback extends IUnknown {
    static IID := "{CA29D251-B4BB-4679-A3D9-AE8006119D54}"
    Begin_JobTransferred(pJob)
      => ComCall(3, this.p, IBackgroundCopyJob, pJob)
    Finish_JobTransferred()
      => ComCall(4, this.p)
    Begin_JobError(pJob, pError)
      => ComCall(5, this.p, IBackgroundCopyJob, pJob, IBackgroundCopyError, pError)
    Finish_JobError()
      => ComCall(6, this.p)
    Begin_JobModification(pJob, dwReserved)
      => ComCall(7, this.p, IBackgroundCopyJob, pJob, UInt32, dwReserved)
    Finish_JobModification()
      => ComCall(8, this.p)
}
struct IBackgroundCopyManager extends IUnknown {
    static IID := "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
    CreateJob(DisplayName, Type, pJobId, ppJob)
      => ComCall(3, this.p, "Str", DisplayName, BG_JOB_TYPE, Type, GUID.Ptr, pJobId, IBackgroundCopyJob.Ptr, ppJob)
    GetJob(jobID, ppJob)
      => ComCall(4, this.p, GUID.Ptr, jobID, IBackgroundCopyJob.Ptr, ppJob)
    EnumJobs(dwFlags, ppEnum)
      => ComCall(5, this.p, UInt32, dwFlags, IEnumBackgroundCopyJobs.Ptr, ppEnum)
    GetErrorDescription(hResult1, LanguageId, pErrorDescription)
      => ComCall(6, this.p, HRESULT, hResult1, UInt32, LanguageId, PWSTR.Ptr, pErrorDescription)
}
struct BG_JOB_REPLY_PROGRESS {
    BytesTotal : Int64
    BytesTransferred : Int64
}
struct BG_AUTH_TARGET extends Int32 {
    static BG_AUTH_TARGET_SERVER := 1
    static BG_AUTH_TARGET_PROXY := 2
}
struct BG_AUTH_SCHEME extends Int32 {
    static BG_AUTH_SCHEME_BASIC := 1
    static BG_AUTH_SCHEME_DIGEST := 2
    static BG_AUTH_SCHEME_NTLM := 3
    static BG_AUTH_SCHEME_NEGOTIATE := 4
    static BG_AUTH_SCHEME_PASSPORT := 5
}
struct BG_BASIC_CREDENTIALS {
    UserName : PWSTR
    Password : PWSTR
}
struct BG_AUTH_CREDENTIALS_UNION {
    union {
        Basic : BG_BASIC_CREDENTIALS
    }
}
struct BG_AUTH_CREDENTIALS {
    Target : BG_AUTH_TARGET
    Scheme : BG_AUTH_SCHEME
    Credentials : BG_AUTH_CREDENTIALS_UNION
}
struct IBackgroundCopyJob2 extends IBackgroundCopyJob {
    static IID := "{54B50739-686F-45EB-9DFF-D6A9A0FAA9AF}"
    SetNotifyCmdLine(Program, Parameters)
      => ComCall(35, this.p, "Str", Program, "Str", Parameters)
    GetNotifyCmdLine(pProgram, pParameters)
      => ComCall(36, this.p, PWSTR.Ptr, pProgram, PWSTR.Ptr, pParameters)
    GetReplyProgress(pProgress)
      => ComCall(37, this.p, BG_JOB_REPLY_PROGRESS.Ptr, pProgress)
    GetReplyData(ppBuffer, pLength)
      => ComCall(38, this.p, UInt8.Ptr.Ptr, ppBuffer, Int64.Ptr, pLength)
    SetReplyFileName(ReplyFileName)
      => ComCall(39, this.p, "Str", ReplyFileName)
    GetReplyFileName(pReplyFileName)
      => ComCall(40, this.p, PWSTR.Ptr, pReplyFileName)
    SetCredentials(credentials)
      => ComCall(41, this.p, BG_AUTH_CREDENTIALS.Ptr, credentials)
    RemoveCredentials(Target, Scheme)
      => ComCall(42, this.p, BG_AUTH_TARGET, Target, BG_AUTH_SCHEME, Scheme)
}
struct BG_FILE_RANGE {
    InitialOffset : Int64
    Length : Int64
}
struct IBackgroundCopyJob3 extends IBackgroundCopyJob2 {
    static IID := "{443C8934-90FF-48ED-BCDE-26F5C7450042}"
    ReplaceRemotePrefix(OldPrefix, NewPrefix)
      => ComCall(43, this.p, "Str", OldPrefix, "Str", NewPrefix)
    AddFileWithRanges(RemoteUrl, LocalName, Ranges)
      => ComCall(44, this.p, "Str", RemoteUrl, "Str", LocalName, UInt32, Ranges.Length, BG_FILE_RANGE.Ptr, Ranges)
    SetFileACLFlags(Flags)
      => ComCall(45, this.p, UInt32, Flags)
    GetFileACLFlags(Flags)
      => ComCall(46, this.p, UInt32.Ptr, Flags)
}
struct IBackgroundCopyFile2 extends IBackgroundCopyFile {
    static IID := "{83E81B93-0873-474D-8A8C-F2018B1A939C}"
    GetFileRanges(Ranges)
      => ComCall(6, this.p, UInt32.Ptr, Ranges.Length, BG_FILE_RANGE.Ptr.Ptr, Ranges)
    SetRemoteName(Val)
      => ComCall(7, this.p, "Str", Val)
}
struct BG_CERT_STORE_LOCATION extends Int32 {
    static BG_CERT_STORE_LOCATION_CURRENT_USER := 0
    static BG_CERT_STORE_LOCATION_LOCAL_MACHINE := 1
    static BG_CERT_STORE_LOCATION_CURRENT_SERVICE := 2
    static BG_CERT_STORE_LOCATION_SERVICES := 3
    static BG_CERT_STORE_LOCATION_USERS := 4
    static BG_CERT_STORE_LOCATION_CURRENT_USER_GROUP_POLICY := 5
    static BG_CERT_STORE_LOCATION_LOCAL_MACHINE_GROUP_POLICY := 6
    static BG_CERT_STORE_LOCATION_LOCAL_MACHINE_ENTERPRISE := 7
}
struct IBackgroundCopyJobHttpOptions extends IUnknown {
    static IID := "{F1BD1079-9F01-4BDC-8036-F09B70095066}"
    SetClientCertificateByID(StoreLocation, StoreName, pCertHashBlob)
      => ComCall(3, this.p, BG_CERT_STORE_LOCATION, StoreLocation, "Str", StoreName, UInt8.Ptr, pCertHashBlob)
    SetClientCertificateByName(StoreLocation, StoreName, SubjectName)
      => ComCall(4, this.p, BG_CERT_STORE_LOCATION, StoreLocation, "Str", StoreName, "Str", SubjectName)
    RemoveClientCertificate()
      => ComCall(5, this.p)
    GetClientCertificate(pStoreLocation, pStoreName, ppCertHashBlob, pSubjectName)
      => ComCall(6, this.p, BG_CERT_STORE_LOCATION.Ptr, pStoreLocation, PWSTR.Ptr, pStoreName, UInt8.Ptr.Ptr, ppCertHashBlob, PWSTR.Ptr, pSubjectName)
    SetCustomHeaders(RequestHeaders)
      => ComCall(7, this.p, "Str", RequestHeaders)
    GetCustomHeaders(pRequestHeaders)
      => ComCall(8, this.p, PWSTR.Ptr, pRequestHeaders)
    SetSecurityFlags(Flags)
      => ComCall(9, this.p, UInt32, Flags)
    GetSecurityFlags(pFlags)
      => ComCall(10, this.p, UInt32.Ptr, pFlags)
}
struct IBitsPeerCacheRecord extends IUnknown {
    static IID := "{659CDEAF-489E-11D9-A9CD-000D56965251}"
    GetId(pVal)
      => ComCall(3, this.p, GUID.Ptr, pVal)
    GetOriginUrl(pVal)
      => ComCall(4, this.p, PWSTR.Ptr, pVal)
    GetFileSize(pVal)
      => ComCall(5, this.p, Int64.Ptr, pVal)
    GetFileModificationTime(pVal)
      => ComCall(6, this.p, FILETIME.Ptr, pVal)
    GetLastAccessTime(pVal)
      => ComCall(7, this.p, FILETIME.Ptr, pVal)
    IsFileValidated()
      => ComCall(8, this.p)
    GetFileRanges(ppRanges)
      => ComCall(9, this.p, UInt32.Ptr, ppRanges.Length, BG_FILE_RANGE.Ptr.Ptr, ppRanges)
}
struct IEnumBitsPeerCacheRecords extends IUnknown {
    static IID := "{659CDEA4-489E-11D9-A9CD-000D56965251}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IBitsPeerCacheRecord.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBitsPeerCacheRecords.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct IBitsPeer extends IUnknown {
    static IID := "{659CDEA2-489E-11D9-A9CD-000D56965251}"
    GetPeerName(pName)
      => ComCall(3, this.p, PWSTR.Ptr, pName)
    IsAuthenticated(pAuth)
      => ComCall(4, this.p, BOOL.Ptr, pAuth)
    IsAvailable(pOnline)
      => ComCall(5, this.p, BOOL.Ptr, pOnline)
}
struct IEnumBitsPeers extends IUnknown {
    static IID := "{659CDEA5-489E-11D9-A9CD-000D56965251}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IBitsPeer.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBitsPeers.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct IBitsPeerCacheAdministration extends IUnknown {
    static IID := "{659CDEAD-489E-11D9-A9CD-000D56965251}"
    GetMaximumCacheSize(pBytes)
      => ComCall(3, this.p, UInt32.Ptr, pBytes)
    SetMaximumCacheSize(Bytes)
      => ComCall(4, this.p, UInt32, Bytes)
    GetMaximumContentAge(pSeconds)
      => ComCall(5, this.p, UInt32.Ptr, pSeconds)
    SetMaximumContentAge(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetConfigurationFlags(pFlags)
      => ComCall(7, this.p, UInt32.Ptr, pFlags)
    SetConfigurationFlags(Flags)
      => ComCall(8, this.p, UInt32, Flags)
    EnumRecords(ppEnum)
      => ComCall(9, this.p, IEnumBitsPeerCacheRecords.Ptr, ppEnum)
    GetRecord(id, ppRecord)
      => ComCall(10, this.p, GUID.Ptr, id, IBitsPeerCacheRecord.Ptr, ppRecord)
    ClearRecords()
      => ComCall(11, this.p)
    DeleteRecord(id)
      => ComCall(12, this.p, GUID.Ptr, id)
    DeleteUrl(url)
      => ComCall(13, this.p, "Str", url)
    EnumPeers(ppEnum)
      => ComCall(14, this.p, IEnumBitsPeers.Ptr, ppEnum)
    ClearPeers()
      => ComCall(15, this.p)
    DiscoverPeers()
      => ComCall(16, this.p)
}
struct IBackgroundCopyJob4 extends IBackgroundCopyJob3 {
    static IID := "{659CDEAE-489E-11D9-A9CD-000D56965251}"
    SetPeerCachingFlags(Flags)
      => ComCall(47, this.p, UInt32, Flags)
    GetPeerCachingFlags(pFlags)
      => ComCall(48, this.p, UInt32.Ptr, pFlags)
    GetOwnerIntegrityLevel(pLevel)
      => ComCall(49, this.p, UInt32.Ptr, pLevel)
    GetOwnerElevationState(pElevated)
      => ComCall(50, this.p, BOOL.Ptr, pElevated)
    SetMaximumDownloadTime(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    GetMaximumDownloadTime(pTimeout)
      => ComCall(52, this.p, UInt32.Ptr, pTimeout)
}
struct IBackgroundCopyFile3 extends IBackgroundCopyFile2 {
    static IID := "{659CDEAA-489E-11D9-A9CD-000D56965251}"
    GetTemporaryName(pFilename)
      => ComCall(8, this.p, PWSTR.Ptr, pFilename)
    SetValidationState(state)
      => ComCall(9, this.p, BOOL, state)
    GetValidationState(pState)
      => ComCall(10, this.p, BOOL.Ptr, pState)
    IsDownloadedFromPeer(pVal)
      => ComCall(11, this.p, BOOL.Ptr, pVal)
}
struct IBackgroundCopyCallback2 extends IBackgroundCopyCallback {
    static IID := "{659CDEAC-489E-11D9-A9CD-000D56965251}"
    FileTransferred(pJob, pFile)
      => ComCall(6, this.p, IBackgroundCopyJob, pJob, IBackgroundCopyFile, pFile)
}
struct IBitsTokenOptions extends IUnknown {
    static IID := "{9A2584C3-F7D2-457A-9A5E-22B67BFFC7D2}"
    SetHelperTokenFlags(UsageFlags)
      => ComCall(3, this.p, BG_TOKEN, UsageFlags)
    GetHelperTokenFlags(pFlags)
      => ComCall(4, this.p, BG_TOKEN.Ptr, pFlags)
    SetHelperToken()
      => ComCall(5, this.p)
    ClearHelperToken()
      => ComCall(6, this.p)
    GetHelperTokenSid(pSid)
      => ComCall(7, this.p, PWSTR.Ptr, pSid)
}
struct IBackgroundCopyFile4 extends IBackgroundCopyFile3 {
    static IID := "{EF7E0655-7888-4960-B0E5-730846E03492}"
    GetPeerDownloadStats(pFromOrigin, pFromPeers)
      => ComCall(12, this.p, Int64.Ptr, pFromOrigin, Int64.Ptr, pFromPeers)
}
struct BITS_JOB_TRANSFER_POLICY extends Int32 {
    static BITS_JOB_TRANSFER_POLICY_ALWAYS := -2147483393
    static BITS_JOB_TRANSFER_POLICY_NOT_ROAMING := -2147483521
    static BITS_JOB_TRANSFER_POLICY_NO_SURCHARGE := -2147483537
    static BITS_JOB_TRANSFER_POLICY_STANDARD := -2147483545
    static BITS_JOB_TRANSFER_POLICY_UNRESTRICTED := -2147483615
}
struct BITS_JOB_PROPERTY_ID extends Int32 {
    static BITS_JOB_PROPERTY_ID_COST_FLAGS := 1
    static BITS_JOB_PROPERTY_NOTIFICATION_CLSID := 2
    static BITS_JOB_PROPERTY_DYNAMIC_CONTENT := 3
    static BITS_JOB_PROPERTY_HIGH_PERFORMANCE := 4
    static BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE := 5
    static BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS := 7
    static BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS := 9
    static BITS_JOB_PROPERTY_ON_DEMAND_MODE := 10
}
struct BITS_JOB_PROPERTY_VALUE {
    union {
        Dword : UInt32
        ClsID : GUID
        Enable : BOOL
        Uint64 : Int64
        Target : BG_AUTH_TARGET
    }
}
struct BITS_FILE_PROPERTY_ID extends Int32 {
    static BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS := 1
}
struct BITS_FILE_PROPERTY_VALUE {
    union {
        String : PWSTR
    }
}
struct IBackgroundCopyJob5 extends IBackgroundCopyJob4 {
    static IID := "{E847030C-BBBA-4657-AF6D-484AA42BF1FE}"
    SetProperty(PropertyId, PropertyValue)
      => ComCall(53, this.p, BITS_JOB_PROPERTY_ID, PropertyId, BITS_JOB_PROPERTY_VALUE, PropertyValue)
    GetProperty(PropertyId, PropertyValue)
      => ComCall(54, this.p, BITS_JOB_PROPERTY_ID, PropertyId, BITS_JOB_PROPERTY_VALUE.Ptr, PropertyValue)
}
struct IBackgroundCopyFile5 extends IBackgroundCopyFile4 {
    static IID := "{85C1657F-DAFC-40E8-8834-DF18EA25717E}"
    SetProperty(PropertyId, PropertyValue)
      => ComCall(13, this.p, BITS_FILE_PROPERTY_ID, PropertyId, BITS_FILE_PROPERTY_VALUE, PropertyValue)
    GetProperty(PropertyId, PropertyValue)
      => ComCall(14, this.p, BITS_FILE_PROPERTY_ID, PropertyId, BITS_FILE_PROPERTY_VALUE.Ptr, PropertyValue)
}
struct IBackgroundCopyCallback3 extends IBackgroundCopyCallback2 {
    static IID := "{98C97BD2-E32B-4AD8-A528-95FD8B16BD42}"
    FileRangesTransferred(job, file, ranges)
      => ComCall(7, this.p, IBackgroundCopyJob, job, IBackgroundCopyFile, file, UInt32, ranges.Length, BG_FILE_RANGE.Ptr, ranges)
}
struct IBackgroundCopyFile6 extends IBackgroundCopyFile5 {
    static IID := "{CF6784F7-D677-49FD-9368-CB47AEE9D1AD}"
    UpdateDownloadPosition(offset)
      => ComCall(15, this.p, Int64, offset)
    RequestFileRanges(ranges)
      => ComCall(16, this.p, UInt32, ranges.Length, BG_FILE_RANGE.Ptr, ranges)
    GetFilledFileRanges(ranges)
      => ComCall(17, this.p, UInt32.Ptr, ranges.Length, BG_FILE_RANGE.Ptr.Ptr, ranges)
}
struct IBackgroundCopyJobHttpOptions2 extends IBackgroundCopyJobHttpOptions {
    static IID := "{B591A192-A405-4FC3-8323-4C5C542578FC}"
    SetHttpMethod(method)
      => ComCall(11, this.p, "Str", method)
    GetHttpMethod(method)
      => ComCall(12, this.p, PWSTR.Ptr, method)
}
struct IBackgroundCopyServerCertificateValidationCallback extends IUnknown {
    static IID := "{4CEC0D02-DEF7-4158-813A-C32A46945FF7}"
    ValidateServerCertificate(job, file, certData, certEncodingType, certStoreData)
      => ComCall(3, this.p, IBackgroundCopyJob, job, IBackgroundCopyFile, file, UInt32, certData.Length, UInt8.Ptr, certData, UInt32, certEncodingType, UInt32, certStoreData.Length, UInt8.Ptr, certStoreData)
}
struct IBackgroundCopyJobHttpOptions3 extends IBackgroundCopyJobHttpOptions2 {
    static IID := "{8A9263D3-FD4C-4EDA-9B28-30132A4D4E3C}"
    SetServerCertificateValidationInterface(certValidationCallback)
      => ComCall(13, this.p, IUnknown, certValidationCallback)
    MakeCustomHeadersWriteOnly()
      => ComCall(14, this.p)
}
struct IBITSExtensionSetup extends IDispatch {
    static IID := "{29CFBBF7-09E4-4B97-B0BC-F2287E3D8EB3}"
    EnableBITSUploads()
      => ComCall(7, this.p)
    DisableBITSUploads()
      => ComCall(8, this.p)
    GetCleanupTaskName(pTaskName)
      => ComCall(9, this.p, BSTR.Ptr, pTaskName)
    GetCleanupTask(riid, ppUnk)
      => ComCall(10, this.p, GUID.Ptr, riid, IUnknown.Ptr, ppUnk)
}
struct IBITSExtensionSetupFactory extends IDispatch {
    static IID := "{D5D2D542-5503-4E64-8B48-72EF91A32EE1}"
    GetObject(Path, ppExtensionSetup)
      => ComCall(7, this.p, BSTR, Path, IBITSExtensionSetup.Ptr, ppExtensionSetup)
}
struct FILESETINFO {
    bstrRemoteFile : BSTR
    bstrLocalFile : BSTR
    dwSizeHint : UInt32
}
struct IBackgroundCopyJob1 extends IUnknown {
    static IID := "{59F5553C-2031-4629-BB18-2645A6970947}"
    CancelJob()
      => ComCall(3, this.p)
    GetProgress(dwFlags, pdwProgress)
      => ComCall(4, this.p, UInt32, dwFlags, UInt32.Ptr, pdwProgress)
    GetStatus(pdwStatus, pdwWin32Result, pdwTransportResult, pdwNumOfRetries)
      => ComCall(5, this.p, UInt32.Ptr, pdwStatus, UInt32.Ptr, pdwWin32Result, UInt32.Ptr, pdwTransportResult, UInt32.Ptr, pdwNumOfRetries)
    AddFiles(ppFileSet)
      => ComCall(6, this.p, UInt32, ppFileSet.Length, FILESETINFO.Ptr.Ptr, ppFileSet)
    GetFile(cFileIndex, pFileInfo)
      => ComCall(7, this.p, UInt32, cFileIndex, FILESETINFO.Ptr, pFileInfo)
    GetFileCount(pdwFileCount)
      => ComCall(8, this.p, UInt32.Ptr, pdwFileCount)
    SwitchToForeground()
      => ComCall(9, this.p)
    get_JobID(pguidJobID)
      => ComCall(10, this.p, GUID.Ptr, pguidJobID)
}
struct IEnumBackgroundCopyJobs1 extends IUnknown {
    static IID := "{8BAEBA9D-8F1C-42C4-B82C-09AE79980D25}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, GUID.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBackgroundCopyJobs1.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct GROUPPROP extends Int32 {
    static GROUPPROP_PRIORITY := 0
    static GROUPPROP_REMOTEUSERID := 1
    static GROUPPROP_REMOTEUSERPWD := 2
    static GROUPPROP_LOCALUSERID := 3
    static GROUPPROP_LOCALUSERPWD := 4
    static GROUPPROP_PROTOCOLFLAGS := 5
    static GROUPPROP_NOTIFYFLAGS := 6
    static GROUPPROP_NOTIFYCLSID := 7
    static GROUPPROP_PROGRESSSIZE := 8
    static GROUPPROP_PROGRESSPERCENT := 9
    static GROUPPROP_PROGRESSTIME := 10
    static GROUPPROP_DISPLAYNAME := 11
    static GROUPPROP_DESCRIPTION := 12
}
struct IBackgroundCopyGroup extends IUnknown {
    static IID := "{1DED80A7-53EA-424F-8A04-17FEA9ADC4F5}"
    GetProp(propID, pvarVal)
      => ComCall(3, this.p, GROUPPROP, propID, VARIANT.Ptr, pvarVal)
    SetProp(propID, pvarVal)
      => ComCall(4, this.p, GROUPPROP, propID, VARIANT.Ptr, pvarVal)
    GetProgress(dwFlags, pdwProgress)
      => ComCall(5, this.p, UInt32, dwFlags, UInt32.Ptr, pdwProgress)
    GetStatus(pdwStatus, pdwJobIndex)
      => ComCall(6, this.p, UInt32.Ptr, pdwStatus, UInt32.Ptr, pdwJobIndex)
    GetJob(jobID, ppJob)
      => ComCall(7, this.p, GUID, jobID, IBackgroundCopyJob1.Ptr, ppJob)
    SuspendGroup()
      => ComCall(8, this.p)
    ResumeGroup()
      => ComCall(9, this.p)
    CancelGroup()
      => ComCall(10, this.p)
    get_Size(pdwSize)
      => ComCall(11, this.p, UInt32.Ptr, pdwSize)
    get_GroupID(pguidGroupID)
      => ComCall(12, this.p, GUID.Ptr, pguidGroupID)
    CreateJob(guidJobID, ppJob)
      => ComCall(13, this.p, GUID, guidJobID, IBackgroundCopyJob1.Ptr, ppJob)
    EnumJobs(dwFlags, ppEnumJobs)
      => ComCall(14, this.p, UInt32, dwFlags, IEnumBackgroundCopyJobs1.Ptr, ppEnumJobs)
    SwitchToForeground()
      => ComCall(15, this.p)
    QueryNewJobInterface(iid, pUnk)
      => ComCall(16, this.p, GUID.Ptr, iid, IUnknown.Ptr, pUnk)
    SetNotificationPointer(iid, pUnk)
      => ComCall(17, this.p, GUID.Ptr, iid, IUnknown, pUnk)
}
struct IEnumBackgroundCopyGroups extends IUnknown {
    static IID := "{D993E603-4AA4-47C5-8665-C20D39C2BA4F}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, GUID.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumBackgroundCopyGroups.Ptr, ppenum)
    GetCount(puCount)
      => ComCall(7, this.p, UInt32.Ptr, puCount)
}
struct IBackgroundCopyCallback1 extends IUnknown {
    static IID := "{084F6593-3800-4E08-9B59-99FA59ADDF82}"
    OnStatus(pGroup, pJob, dwFileIndex, dwStatus, dwNumOfRetries, dwWin32Result, dwTransportResult)
      => ComCall(3, this.p, IBackgroundCopyGroup, pGroup, IBackgroundCopyJob1, pJob, UInt32, dwFileIndex, UInt32, dwStatus, UInt32, dwNumOfRetries, UInt32, dwWin32Result, UInt32, dwTransportResult)
    OnProgress(ProgressType, pGroup, pJob, dwFileIndex, dwProgressValue)
      => ComCall(4, this.p, UInt32, ProgressType, IBackgroundCopyGroup, pGroup, IBackgroundCopyJob1, pJob, UInt32, dwFileIndex, UInt32, dwProgressValue)
    OnProgressEx(ProgressType, pGroup, pJob, dwFileIndex, dwProgressValue, pByte)
      => ComCall(5, this.p, UInt32, ProgressType, IBackgroundCopyGroup, pGroup, IBackgroundCopyJob1, pJob, UInt32, dwFileIndex, UInt32, dwProgressValue, UInt32, pByte.Length, UInt8.Ptr, pByte)
}
struct IBackgroundCopyQMgr extends IUnknown {
    static IID := "{16F41C69-09F5-41D2-8CD8-3C08C47BC8A8}"
    CreateGroup(guidGroupID, ppGroup)
      => ComCall(3, this.p, GUID, guidGroupID, IBackgroundCopyGroup.Ptr, ppGroup)
    GetGroup(groupID, ppGroup)
      => ComCall(4, this.p, GUID, groupID, IBackgroundCopyGroup.Ptr, ppGroup)
    EnumGroups(dwFlags, ppEnumGroups)
      => ComCall(5, this.p, UInt32, dwFlags, IEnumBackgroundCopyGroups.Ptr, ppEnumGroups)
}
