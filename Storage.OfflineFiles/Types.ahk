#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {BYTE_BLOB, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct OFFLINEFILES_ITEM_TYPE extends Int32 {
    static OFFLINEFILES_ITEM_TYPE_FILE := 0
    static OFFLINEFILES_ITEM_TYPE_DIRECTORY := 1
    static OFFLINEFILES_ITEM_TYPE_SHARE := 2
    static OFFLINEFILES_ITEM_TYPE_SERVER := 3
}
struct OFFLINEFILES_ITEM_COPY extends Int32 {
    static OFFLINEFILES_ITEM_COPY_LOCAL := 0
    static OFFLINEFILES_ITEM_COPY_REMOTE := 1
    static OFFLINEFILES_ITEM_COPY_ORIGINAL := 2
}
struct OFFLINEFILES_CONNECT_STATE extends Int32 {
    static OFFLINEFILES_CONNECT_STATE_UNKNOWN := 0
    static OFFLINEFILES_CONNECT_STATE_OFFLINE := 1
    static OFFLINEFILES_CONNECT_STATE_ONLINE := 2
    static OFFLINEFILES_CONNECT_STATE_TRANSPARENTLY_CACHED := 3
    static OFFLINEFILES_CONNECT_STATE_PARTLY_TRANSPARENTLY_CACHED := 4
}
struct OFFLINEFILES_OFFLINE_REASON extends Int32 {
    static OFFLINEFILES_OFFLINE_REASON_UNKNOWN := 0
    static OFFLINEFILES_OFFLINE_REASON_NOT_APPLICABLE := 1
    static OFFLINEFILES_OFFLINE_REASON_CONNECTION_FORCED := 2
    static OFFLINEFILES_OFFLINE_REASON_CONNECTION_SLOW := 3
    static OFFLINEFILES_OFFLINE_REASON_CONNECTION_ERROR := 4
    static OFFLINEFILES_OFFLINE_REASON_ITEM_VERSION_CONFLICT := 5
    static OFFLINEFILES_OFFLINE_REASON_ITEM_SUSPENDED := 6
}
struct OFFLINEFILES_CACHING_MODE extends Int32 {
    static OFFLINEFILES_CACHING_MODE_NONE := 0
    static OFFLINEFILES_CACHING_MODE_NOCACHING := 1
    static OFFLINEFILES_CACHING_MODE_MANUAL := 2
    static OFFLINEFILES_CACHING_MODE_AUTO_DOC := 3
    static OFFLINEFILES_CACHING_MODE_AUTO_PROGANDDOC := 4
}
struct OFFLINEFILES_OP_RESPONSE extends Int32 {
    static OFFLINEFILES_OP_CONTINUE := 0
    static OFFLINEFILES_OP_RETRY := 1
    static OFFLINEFILES_OP_ABORT := 2
}
struct OFFLINEFILES_EVENTS extends Int32 {
    static OFFLINEFILES_EVENT_CACHEMOVED := 0
    static OFFLINEFILES_EVENT_CACHEISFULL := 1
    static OFFLINEFILES_EVENT_CACHEISCORRUPTED := 2
    static OFFLINEFILES_EVENT_ENABLED := 3
    static OFFLINEFILES_EVENT_ENCRYPTIONCHANGED := 4
    static OFFLINEFILES_EVENT_SYNCBEGIN := 5
    static OFFLINEFILES_EVENT_SYNCFILERESULT := 6
    static OFFLINEFILES_EVENT_SYNCCONFLICTRECADDED := 7
    static OFFLINEFILES_EVENT_SYNCCONFLICTRECUPDATED := 8
    static OFFLINEFILES_EVENT_SYNCCONFLICTRECREMOVED := 9
    static OFFLINEFILES_EVENT_SYNCEND := 10
    static OFFLINEFILES_EVENT_BACKGROUNDSYNCBEGIN := 11
    static OFFLINEFILES_EVENT_BACKGROUNDSYNCEND := 12
    static OFFLINEFILES_EVENT_NETTRANSPORTARRIVED := 13
    static OFFLINEFILES_EVENT_NONETTRANSPORTS := 14
    static OFFLINEFILES_EVENT_ITEMDISCONNECTED := 15
    static OFFLINEFILES_EVENT_ITEMRECONNECTED := 16
    static OFFLINEFILES_EVENT_ITEMAVAILABLEOFFLINE := 17
    static OFFLINEFILES_EVENT_ITEMNOTAVAILABLEOFFLINE := 18
    static OFFLINEFILES_EVENT_ITEMPINNED := 19
    static OFFLINEFILES_EVENT_ITEMNOTPINNED := 20
    static OFFLINEFILES_EVENT_ITEMMODIFIED := 21
    static OFFLINEFILES_EVENT_ITEMADDEDTOCACHE := 22
    static OFFLINEFILES_EVENT_ITEMDELETEDFROMCACHE := 23
    static OFFLINEFILES_EVENT_ITEMRENAMED := 24
    static OFFLINEFILES_EVENT_DATALOST := 25
    static OFFLINEFILES_EVENT_PING := 26
    static OFFLINEFILES_EVENT_ITEMRECONNECTBEGIN := 27
    static OFFLINEFILES_EVENT_ITEMRECONNECTEND := 28
    static OFFLINEFILES_EVENT_CACHEEVICTBEGIN := 29
    static OFFLINEFILES_EVENT_CACHEEVICTEND := 30
    static OFFLINEFILES_EVENT_POLICYCHANGEDETECTED := 31
    static OFFLINEFILES_EVENT_PREFERENCECHANGEDETECTED := 32
    static OFFLINEFILES_EVENT_SETTINGSCHANGESAPPLIED := 33
    static OFFLINEFILES_EVENT_TRANSPARENTCACHEITEMNOTIFY := 34
    static OFFLINEFILES_EVENT_PREFETCHFILEBEGIN := 35
    static OFFLINEFILES_EVENT_PREFETCHFILEEND := 36
    static OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEBEGIN := 37
    static OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEEND := 38
    static OFFLINEFILES_NUM_EVENTS := 39
}
struct OFFLINEFILES_PATHFILTER_MATCH extends Int32 {
    static OFFLINEFILES_PATHFILTER_SELF := 0
    static OFFLINEFILES_PATHFILTER_CHILD := 1
    static OFFLINEFILES_PATHFILTER_DESCENDENT := 2
    static OFFLINEFILES_PATHFILTER_SELFORCHILD := 3
    static OFFLINEFILES_PATHFILTER_SELFORDESCENDENT := 4
}
struct OFFLINEFILES_SYNC_CONFLICT_RESOLVE extends Int32 {
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NONE := 0
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLOCAL := 1
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPREMOTE := 2
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES := 3
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST := 4
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_LOG := 5
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_SKIP := 6
    static OFFLINEFILES_SYNC_CONFLICT_ABORT := 7
    static OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NUMCODES := 8
}
struct OFFLINEFILES_ITEM_TIME extends Int32 {
    static OFFLINEFILES_ITEM_TIME_CREATION := 0
    static OFFLINEFILES_ITEM_TIME_LASTACCESS := 1
    static OFFLINEFILES_ITEM_TIME_LASTWRITE := 2
}
struct OFFLINEFILES_COMPARE extends Int32 {
    static OFFLINEFILES_COMPARE_EQ := 0
    static OFFLINEFILES_COMPARE_NEQ := 1
    static OFFLINEFILES_COMPARE_LT := 2
    static OFFLINEFILES_COMPARE_GT := 3
    static OFFLINEFILES_COMPARE_LTE := 4
    static OFFLINEFILES_COMPARE_GTE := 5
}
struct OFFLINEFILES_SETTING_VALUE_TYPE extends Int32 {
    static OFFLINEFILES_SETTING_VALUE_UI4 := 0
    static OFFLINEFILES_SETTING_VALUE_BSTR := 1
    static OFFLINEFILES_SETTING_VALUE_BSTR_DBLNULTERM := 2
    static OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_UI4 := 3
    static OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_BSTR := 4
}
struct OFFLINEFILES_SYNC_OPERATION extends Int32 {
    static OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_SERVER := 0
    static OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_CLIENT := 1
    static OFFLINEFILES_SYNC_OPERATION_SYNC_TO_SERVER := 2
    static OFFLINEFILES_SYNC_OPERATION_SYNC_TO_CLIENT := 3
    static OFFLINEFILES_SYNC_OPERATION_DELETE_SERVER_COPY := 4
    static OFFLINEFILES_SYNC_OPERATION_DELETE_CLIENT_COPY := 5
    static OFFLINEFILES_SYNC_OPERATION_PIN := 6
    static OFFLINEFILES_SYNC_OPERATION_PREPARE := 7
}
struct OFFLINEFILES_SYNC_STATE extends Int32 {
    static OFFLINEFILES_SYNC_STATE_Stable := 0
    static OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer := 1
    static OFFLINEFILES_SYNC_STATE_FileOnClient_NoServerCopy := 2
    static OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer := 3
    static OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer := 4
    static OFFLINEFILES_SYNC_STATE_DirOnClient_NoServerCopy := 5
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_NoServerCopy := 6
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer := 7
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer := 8
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer := 9
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer := 10
    static OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DeletedOnServer := 11
    static OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer := 12
    static OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer := 13
    static OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer := 14
    static OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DeletedOnServer := 15
    static OFFLINEFILES_SYNC_STATE_FileSparseOnClient_ChangedOnServer := 16
    static OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DeletedOnServer := 17
    static OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirOnServer := 18
    static OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirChangedOnServer := 19
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_NoServerCopy := 20
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirOnServer := 21
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer := 22
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer := 23
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirChangedOnServer := 24
    static OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DeletedOnServer := 25
    static OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer := 26
    static OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer := 27
    static OFFLINEFILES_SYNC_STATE_DirChangedOnClient_ChangedOnServer := 28
    static OFFLINEFILES_SYNC_STATE_DirChangedOnClient_DeletedOnServer := 29
    static OFFLINEFILES_SYNC_STATE_NoClientCopy_FileOnServer := 30
    static OFFLINEFILES_SYNC_STATE_NoClientCopy_DirOnServer := 31
    static OFFLINEFILES_SYNC_STATE_NoClientCopy_FileChangedOnServer := 32
    static OFFLINEFILES_SYNC_STATE_NoClientCopy_DirChangedOnServer := 33
    static OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileOnServer := 34
    static OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirOnServer := 35
    static OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileChangedOnServer := 36
    static OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirChangedOnServer := 37
    static OFFLINEFILES_SYNC_STATE_FileSparseOnClient := 38
    static OFFLINEFILES_SYNC_STATE_FileChangedOnClient := 39
    static OFFLINEFILES_SYNC_STATE_FileRenamedOnClient := 40
    static OFFLINEFILES_SYNC_STATE_DirSparseOnClient := 41
    static OFFLINEFILES_SYNC_STATE_DirChangedOnClient := 42
    static OFFLINEFILES_SYNC_STATE_DirRenamedOnClient := 43
    static OFFLINEFILES_SYNC_STATE_FileChangedOnServer := 44
    static OFFLINEFILES_SYNC_STATE_FileRenamedOnServer := 45
    static OFFLINEFILES_SYNC_STATE_FileDeletedOnServer := 46
    static OFFLINEFILES_SYNC_STATE_DirChangedOnServer := 47
    static OFFLINEFILES_SYNC_STATE_DirRenamedOnServer := 48
    static OFFLINEFILES_SYNC_STATE_DirDeletedOnServer := 49
    static OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileOnServer := 50
    static OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileChangedOnServer := 51
    static OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirOnServer := 52
    static OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirChangedOnServer := 53
    static OFFLINEFILES_SYNC_STATE_NUMSTATES := 54
}
struct IOfflineFilesEvents extends IUnknown {
    static IID := "{E25585C1-0CAA-4EB1-873B-1CAE5B77C314}"
    CacheMoved(pszOldPath, pszNewPath)
      => ComCall(3, this.p, "Str", pszOldPath, "Str", pszNewPath)
    CacheIsFull()
      => ComCall(4, this.p)
    CacheIsCorrupted()
      => ComCall(5, this.p)
    Enabled(bEnabled)
      => ComCall(6, this.p, BOOL, bEnabled)
    EncryptionChanged(bWasEncrypted, bWasPartial, bIsEncrypted, bIsPartial)
      => ComCall(7, this.p, BOOL, bWasEncrypted, BOOL, bWasPartial, BOOL, bIsEncrypted, BOOL, bIsPartial)
    SyncBegin(rSyncId)
      => ComCall(8, this.p, GUID.Ptr, rSyncId)
    SyncFileResult(rSyncId, pszFile, hrResult)
      => ComCall(9, this.p, GUID.Ptr, rSyncId, "Str", pszFile, HRESULT, hrResult)
    SyncConflictRecAdded(pszConflictPath, pftConflictDateTime, ConflictSyncState)
      => ComCall(10, this.p, "Str", pszConflictPath, FILETIME.Ptr, pftConflictDateTime, OFFLINEFILES_SYNC_STATE, ConflictSyncState)
    SyncConflictRecUpdated(pszConflictPath, pftConflictDateTime, ConflictSyncState)
      => ComCall(11, this.p, "Str", pszConflictPath, FILETIME.Ptr, pftConflictDateTime, OFFLINEFILES_SYNC_STATE, ConflictSyncState)
    SyncConflictRecRemoved(pszConflictPath, pftConflictDateTime, ConflictSyncState)
      => ComCall(12, this.p, "Str", pszConflictPath, FILETIME.Ptr, pftConflictDateTime, OFFLINEFILES_SYNC_STATE, ConflictSyncState)
    SyncEnd(rSyncId, hrResult)
      => ComCall(13, this.p, GUID.Ptr, rSyncId, HRESULT, hrResult)
    NetTransportArrived()
      => ComCall(14, this.p)
    NoNetTransports()
      => ComCall(15, this.p)
    ItemDisconnected(pszPath, ItemType)
      => ComCall(16, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemReconnected(pszPath, ItemType)
      => ComCall(17, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemAvailableOffline(pszPath, ItemType)
      => ComCall(18, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemNotAvailableOffline(pszPath, ItemType)
      => ComCall(19, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemPinned(pszPath, ItemType)
      => ComCall(20, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemNotPinned(pszPath, ItemType)
      => ComCall(21, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemModified(pszPath, ItemType, bModifiedData, bModifiedAttributes)
      => ComCall(22, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType, BOOL, bModifiedData, BOOL, bModifiedAttributes)
    ItemAddedToCache(pszPath, ItemType)
      => ComCall(23, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemDeletedFromCache(pszPath, ItemType)
      => ComCall(24, this.p, "Str", pszPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    ItemRenamed(pszOldPath, pszNewPath, ItemType)
      => ComCall(25, this.p, "Str", pszOldPath, "Str", pszNewPath, OFFLINEFILES_ITEM_TYPE, ItemType)
    DataLost()
      => ComCall(26, this.p)
    Ping()
      => ComCall(27, this.p)
}
struct IOfflineFilesEvents2 extends IOfflineFilesEvents {
    static IID := "{1EAD8F56-FF76-4FAA-A795-6F6EF792498B}"
    ItemReconnectBegin()
      => ComCall(28, this.p)
    ItemReconnectEnd()
      => ComCall(29, this.p)
    CacheEvictBegin()
      => ComCall(30, this.p)
    CacheEvictEnd()
      => ComCall(31, this.p)
    BackgroundSyncBegin(dwSyncControlFlags)
      => ComCall(32, this.p, UInt32, dwSyncControlFlags)
    BackgroundSyncEnd(dwSyncControlFlags)
      => ComCall(33, this.p, UInt32, dwSyncControlFlags)
    PolicyChangeDetected()
      => ComCall(34, this.p)
    PreferenceChangeDetected()
      => ComCall(35, this.p)
    SettingsChangesApplied()
      => ComCall(36, this.p)
}
struct IOfflineFilesEvents3 extends IOfflineFilesEvents2 {
    static IID := "{9BA04A45-EE69-42F0-9AB1-7DB5C8805808}"
    TransparentCacheItemNotify(pszPath, EventType, ItemType, bModifiedData, bModifiedAttributes, pzsOldPath)
      => ComCall(37, this.p, "Str", pszPath, OFFLINEFILES_EVENTS, EventType, OFFLINEFILES_ITEM_TYPE, ItemType, BOOL, bModifiedData, BOOL, bModifiedAttributes, "Str", pzsOldPath)
    PrefetchFileBegin(pszPath)
      => ComCall(38, this.p, "Str", pszPath)
    PrefetchFileEnd(pszPath, hrResult)
      => ComCall(39, this.p, "Str", pszPath, HRESULT, hrResult)
}
struct IOfflineFilesEvents4 extends IOfflineFilesEvents3 {
    static IID := "{DBD69B1E-C7D2-473E-B35F-9D8C24C0C484}"
    PrefetchCloseHandleBegin()
      => ComCall(40, this.p)
    PrefetchCloseHandleEnd(dwClosedHandleCount, dwOpenHandleCount, hrResult)
      => ComCall(41, this.p, UInt32, dwClosedHandleCount, UInt32, dwOpenHandleCount, HRESULT, hrResult)
}
struct IOfflineFilesEventsFilter extends IUnknown {
    static IID := "{33FC4E1B-0716-40FA-BA65-6E62A84A846F}"
    GetPathFilter(ppszFilter, pMatch)
      => ComCall(3, this.p, PWSTR.Ptr, ppszFilter, OFFLINEFILES_PATHFILTER_MATCH.Ptr, pMatch)
    GetIncludedEvents(prgEvents, pcEvents)
      => ComCall(4, this.p, UInt32, prgEvents.Length, OFFLINEFILES_EVENTS.Ptr, prgEvents, UInt32.Ptr, pcEvents)
    GetExcludedEvents(prgEvents, pcEvents)
      => ComCall(5, this.p, UInt32, prgEvents.Length, OFFLINEFILES_EVENTS.Ptr, prgEvents, UInt32.Ptr, pcEvents)
}
struct IOfflineFilesErrorInfo extends IUnknown {
    static IID := "{7112FA5F-7571-435A-8EB7-195C7C1429BC}"
    GetRawData(ppBlob)
      => ComCall(3, this.p, BYTE_BLOB.Ptr.Ptr, ppBlob)
    GetDescription(ppszDescription)
      => ComCall(4, this.p, PWSTR.Ptr, ppszDescription)
}
struct IOfflineFilesSyncErrorItemInfo extends IUnknown {
    static IID := "{ECDBAF0D-6A18-4D55-8017-108F7660BA44}"
    GetFileAttributes(pdwAttributes)
      => ComCall(3, this.p, UInt32.Ptr, pdwAttributes)
    GetFileTimes(pftLastWrite, pftChange)
      => ComCall(4, this.p, FILETIME.Ptr, pftLastWrite, FILETIME.Ptr, pftChange)
    GetFileSize(pSize)
      => ComCall(5, this.p, Int64.Ptr, pSize)
}
struct IOfflineFilesSyncErrorInfo extends IOfflineFilesErrorInfo {
    static IID := "{59F95E46-EB54-49D1-BE76-DE95458D01B0}"
    GetSyncOperation(pSyncOp)
      => ComCall(5, this.p, OFFLINEFILES_SYNC_OPERATION.Ptr, pSyncOp)
    GetItemChangeFlags(pdwItemChangeFlags)
      => ComCall(6, this.p, UInt32.Ptr, pdwItemChangeFlags)
    InfoEnumerated(pbLocalEnumerated, pbRemoteEnumerated, pbOriginalEnumerated)
      => ComCall(7, this.p, BOOL.Ptr, pbLocalEnumerated, BOOL.Ptr, pbRemoteEnumerated, BOOL.Ptr, pbOriginalEnumerated)
    InfoAvailable(pbLocalInfo, pbRemoteInfo, pbOriginalInfo)
      => ComCall(8, this.p, BOOL.Ptr, pbLocalInfo, BOOL.Ptr, pbRemoteInfo, BOOL.Ptr, pbOriginalInfo)
    GetLocalInfo(ppInfo)
      => ComCall(9, this.p, IOfflineFilesSyncErrorItemInfo.Ptr, ppInfo)
    GetRemoteInfo(ppInfo)
      => ComCall(10, this.p, IOfflineFilesSyncErrorItemInfo.Ptr, ppInfo)
    GetOriginalInfo(ppInfo)
      => ComCall(11, this.p, IOfflineFilesSyncErrorItemInfo.Ptr, ppInfo)
}
struct IOfflineFilesProgress extends IUnknown {
    static IID := "{FAD63237-C55B-4911-9850-BCF96D4C979E}"
    Begin(pbAbort)
      => ComCall(3, this.p, BOOL.Ptr, pbAbort)
    QueryAbort(pbAbort)
      => ComCall(4, this.p, BOOL.Ptr, pbAbort)
    End(hrResult)
      => ComCall(5, this.p, HRESULT, hrResult)
}
struct IOfflineFilesSimpleProgress extends IOfflineFilesProgress {
    static IID := "{C34F7F9B-C43D-4F9D-A776-C0EB6DE5D401}"
    ItemBegin(pszFile, pResponse)
      => ComCall(6, this.p, "Str", pszFile, OFFLINEFILES_OP_RESPONSE.Ptr, pResponse)
    ItemResult(pszFile, hrResult, pResponse)
      => ComCall(7, this.p, "Str", pszFile, HRESULT, hrResult, OFFLINEFILES_OP_RESPONSE.Ptr, pResponse)
}
struct IOfflineFilesSyncProgress extends IOfflineFilesProgress {
    static IID := "{6931F49A-6FC7-4C1B-B265-56793FC451B7}"
    SyncItemBegin(pszFile, pResponse)
      => ComCall(6, this.p, "Str", pszFile, OFFLINEFILES_OP_RESPONSE.Ptr, pResponse)
    SyncItemResult(pszFile, hrResult, pErrorInfo?, pResponse)
      => ComCall(7, this.p, "Str", pszFile, HRESULT, hrResult, IOfflineFilesSyncErrorInfo, pErrorInfo?, OFFLINEFILES_OP_RESPONSE.Ptr, pResponse)
}
struct IOfflineFilesSyncConflictHandler extends IUnknown {
    static IID := "{B6DD5092-C65C-46B6-97B8-FADD08E7E1BE}"
    ResolveConflict(pszPath, fStateKnown, state, fChangeDetails, pConflictResolution, ppszNewName)
      => ComCall(3, this.p, "Str", pszPath, UInt32, fStateKnown, OFFLINEFILES_SYNC_STATE, state, UInt32, fChangeDetails, OFFLINEFILES_SYNC_CONFLICT_RESOLVE.Ptr, pConflictResolution, PWSTR.Ptr, ppszNewName)
}
struct IOfflineFilesItemFilter extends IUnknown {
    static IID := "{F4B5A26C-DC05-4F20-ADA4-551F1077BE5C}"
    GetFilterFlags(pullFlags, pullMask)
      => ComCall(3, this.p, Int64.Ptr, pullFlags, Int64.Ptr, pullMask)
    GetTimeFilter(pftTime, pbEvalTimeOfDay, pTimeType, pCompare)
      => ComCall(4, this.p, FILETIME.Ptr, pftTime, BOOL.Ptr, pbEvalTimeOfDay, OFFLINEFILES_ITEM_TIME.Ptr, pTimeType, OFFLINEFILES_COMPARE.Ptr, pCompare)
    GetPatternFilter(pszPattern)
      => ComCall(5, this.p, PWSTR, pszPattern, UInt32, pszPattern.Length)
}
struct IOfflineFilesItem extends IUnknown {
    static IID := "{4A753DA6-E044-4F12-A718-5D14D079A906}"
    GetItemType(pItemType)
      => ComCall(3, this.p, OFFLINEFILES_ITEM_TYPE.Ptr, pItemType)
    GetPath(ppszPath)
      => ComCall(4, this.p, PWSTR.Ptr, ppszPath)
    GetParentItem(ppItem)
      => ComCall(5, this.p, IOfflineFilesItem.Ptr, ppItem)
    Refresh(dwQueryFlags)
      => ComCall(6, this.p, UInt32, dwQueryFlags)
    IsMarkedForDeletion(pbMarkedForDeletion)
      => ComCall(7, this.p, BOOL.Ptr, pbMarkedForDeletion)
}
struct IOfflineFilesServerItem extends IOfflineFilesItem {
    static IID := "{9B1C9576-A92B-4151-8E9E-7C7B3EC2E016}"
}
struct IOfflineFilesShareItem extends IOfflineFilesItem {
    static IID := "{BAB7E48D-4804-41B5-A44D-0F199B06B145}"
}
struct IOfflineFilesDirectoryItem extends IOfflineFilesItem {
    static IID := "{2273597A-A08C-4A00-A37A-C1AE4E9A1CFD}"
}
struct IOfflineFilesFileItem extends IOfflineFilesItem {
    static IID := "{8DFADEAD-26C2-4EFF-8A72-6B50723D9A00}"
    IsSparse(pbIsSparse)
      => ComCall(8, this.p, BOOL.Ptr, pbIsSparse)
    IsEncrypted(pbIsEncrypted)
      => ComCall(9, this.p, BOOL.Ptr, pbIsEncrypted)
}
struct IEnumOfflineFilesItems extends IUnknown {
    static IID := "{DA70E815-C361-4407-BC0B-0D7046E5F2CD}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IOfflineFilesItem.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumOfflineFilesItems.Ptr, ppenum)
}
struct IOfflineFilesItemContainer extends IUnknown {
    static IID := "{3836F049-9413-45DD-BF46-B5AAA82DC310}"
    EnumItems(dwQueryFlags, ppenum)
      => ComCall(3, this.p, UInt32, dwQueryFlags, IEnumOfflineFilesItems.Ptr, ppenum)
    EnumItemsEx(pIncludeFileFilter?, pIncludeDirFilter?, pExcludeFileFilter?, pExcludeDirFilter?, dwEnumFlags, dwQueryFlags, ppenum)
      => ComCall(4, this.p, IOfflineFilesItemFilter, pIncludeFileFilter?, IOfflineFilesItemFilter, pIncludeDirFilter?, IOfflineFilesItemFilter, pExcludeFileFilter?, IOfflineFilesItemFilter, pExcludeDirFilter?, UInt32, dwEnumFlags, UInt32, dwQueryFlags, IEnumOfflineFilesItems.Ptr, ppenum)
}
struct IOfflineFilesChangeInfo extends IUnknown {
    static IID := "{A96E6FA4-E0D1-4C29-960B-EE508FE68C72}"
    IsDirty(pbDirty)
      => ComCall(3, this.p, BOOL.Ptr, pbDirty)
    IsDeletedOffline(pbDeletedOffline)
      => ComCall(4, this.p, BOOL.Ptr, pbDeletedOffline)
    IsCreatedOffline(pbCreatedOffline)
      => ComCall(5, this.p, BOOL.Ptr, pbCreatedOffline)
    IsLocallyModifiedData(pbLocallyModifiedData)
      => ComCall(6, this.p, BOOL.Ptr, pbLocallyModifiedData)
    IsLocallyModifiedAttributes(pbLocallyModifiedAttributes)
      => ComCall(7, this.p, BOOL.Ptr, pbLocallyModifiedAttributes)
    IsLocallyModifiedTime(pbLocallyModifiedTime)
      => ComCall(8, this.p, BOOL.Ptr, pbLocallyModifiedTime)
}
struct IOfflineFilesDirtyInfo extends IUnknown {
    static IID := "{0F50CE33-BAC9-4EAA-A11D-DA0E527D047D}"
    LocalDirtyByteCount(pDirtyByteCount)
      => ComCall(3, this.p, Int64.Ptr, pDirtyByteCount)
    RemoteDirtyByteCount(pDirtyByteCount)
      => ComCall(4, this.p, Int64.Ptr, pDirtyByteCount)
}
struct IOfflineFilesFileSysInfo extends IUnknown {
    static IID := "{BC1A163F-7BFD-4D88-9C66-96EA9A6A3D6B}"
    GetAttributes(copy, pdwAttributes)
      => ComCall(3, this.p, OFFLINEFILES_ITEM_COPY, copy, UInt32.Ptr, pdwAttributes)
    GetTimes(copy, pftCreationTime, pftLastWriteTime, pftChangeTime, pftLastAccessTime)
      => ComCall(4, this.p, OFFLINEFILES_ITEM_COPY, copy, FILETIME.Ptr, pftCreationTime, FILETIME.Ptr, pftLastWriteTime, FILETIME.Ptr, pftChangeTime, FILETIME.Ptr, pftLastAccessTime)
    GetFileSize(copy, pSize)
      => ComCall(5, this.p, OFFLINEFILES_ITEM_COPY, copy, Int64.Ptr, pSize)
}
struct IOfflineFilesPinInfo extends IUnknown {
    static IID := "{5B2B0655-B3FD-497D-ADEB-BD156BC8355B}"
    IsPinned(pbPinned)
      => ComCall(3, this.p, BOOL.Ptr, pbPinned)
    IsPinnedForUser(pbPinnedForUser, pbInherit)
      => ComCall(4, this.p, BOOL.Ptr, pbPinnedForUser, BOOL.Ptr, pbInherit)
    IsPinnedForUserByPolicy(pbPinnedForUser, pbInherit)
      => ComCall(5, this.p, BOOL.Ptr, pbPinnedForUser, BOOL.Ptr, pbInherit)
    IsPinnedForComputer(pbPinnedForComputer, pbInherit)
      => ComCall(6, this.p, BOOL.Ptr, pbPinnedForComputer, BOOL.Ptr, pbInherit)
    IsPinnedForFolderRedirection(pbPinnedForFolderRedirection, pbInherit)
      => ComCall(7, this.p, BOOL.Ptr, pbPinnedForFolderRedirection, BOOL.Ptr, pbInherit)
}
struct IOfflineFilesPinInfo2 extends IOfflineFilesPinInfo {
    static IID := "{623C58A2-42ED-4AD7-B69A-0F1B30A72D0D}"
    IsPartlyPinned(pbPartlyPinned)
      => ComCall(8, this.p, BOOL.Ptr, pbPartlyPinned)
}
struct IOfflineFilesTransparentCacheInfo extends IUnknown {
    static IID := "{BCAF4A01-5B68-4B56-A6A1-8D2786EDE8E3}"
    IsTransparentlyCached(pbTransparentlyCached)
      => ComCall(3, this.p, BOOL.Ptr, pbTransparentlyCached)
}
struct IOfflineFilesGhostInfo extends IUnknown {
    static IID := "{2B09D48C-8AB5-464F-A755-A59D92F99429}"
    IsGhosted(pbGhosted)
      => ComCall(3, this.p, BOOL.Ptr, pbGhosted)
}
struct IOfflineFilesConnectionInfo extends IUnknown {
    static IID := "{EFB23A09-A867-4BE8-83A6-86969A7D0856}"
    GetConnectState(pConnectState, pOfflineReason)
      => ComCall(3, this.p, OFFLINEFILES_CONNECT_STATE.Ptr, pConnectState, OFFLINEFILES_OFFLINE_REASON.Ptr, pOfflineReason)
    SetConnectState(hwndParent?, dwFlags, ConnectState)
      => ComCall(4, this.p, HWND, hwndParent?, UInt32, dwFlags, OFFLINEFILES_CONNECT_STATE, ConnectState)
    TransitionOnline(hwndParent?, dwFlags)
      => ComCall(5, this.p, HWND, hwndParent?, UInt32, dwFlags)
    TransitionOffline(hwndParent?, dwFlags, bForceOpenFilesClosed, pbOpenFilesPreventedTransition)
      => ComCall(6, this.p, HWND, hwndParent?, UInt32, dwFlags, BOOL, bForceOpenFilesClosed, BOOL.Ptr, pbOpenFilesPreventedTransition)
}
struct IOfflineFilesShareInfo extends IUnknown {
    static IID := "{7BCC43E7-31CE-4CA4-8CCD-1CFF2DC494DA}"
    GetShareItem(ppShareItem)
      => ComCall(3, this.p, IOfflineFilesShareItem.Ptr, ppShareItem)
    GetShareCachingMode(pCachingMode)
      => ComCall(4, this.p, OFFLINEFILES_CACHING_MODE.Ptr, pCachingMode)
    IsShareDfsJunction(pbIsDfsJunction)
      => ComCall(5, this.p, BOOL.Ptr, pbIsDfsJunction)
}
struct IOfflineFilesSuspend extends IUnknown {
    static IID := "{62C4560F-BC0B-48CA-AD9D-34CB528D99A9}"
    SuspendRoot(bSuspend)
      => ComCall(3, this.p, BOOL, bSuspend)
}
struct IOfflineFilesSuspendInfo extends IUnknown {
    static IID := "{A457C25B-4E9C-4B04-85AF-8932CCD97889}"
    IsSuspended(pbSuspended, pbSuspendedRoot)
      => ComCall(3, this.p, BOOL.Ptr, pbSuspended, BOOL.Ptr, pbSuspendedRoot)
}
struct IOfflineFilesSetting extends IUnknown {
    static IID := "{D871D3F7-F613-48A1-827E-7A34E560FFF6}"
    GetName(ppszName)
      => ComCall(3, this.p, PWSTR.Ptr, ppszName)
    GetValueType(pType)
      => ComCall(4, this.p, OFFLINEFILES_SETTING_VALUE_TYPE.Ptr, pType)
    GetPreference(pvarValue, dwScope)
      => ComCall(5, this.p, VARIANT.Ptr, pvarValue, UInt32, dwScope)
    GetPreferenceScope(pdwScope)
      => ComCall(6, this.p, UInt32.Ptr, pdwScope)
    SetPreference(pvarValue, dwScope)
      => ComCall(7, this.p, VARIANT.Ptr, pvarValue, UInt32, dwScope)
    DeletePreference(dwScope)
      => ComCall(8, this.p, UInt32, dwScope)
    GetPolicy(pvarValue, dwScope)
      => ComCall(9, this.p, VARIANT.Ptr, pvarValue, UInt32, dwScope)
    GetPolicyScope(pdwScope)
      => ComCall(10, this.p, UInt32.Ptr, pdwScope)
    GetValue(pvarValue, pbSetByPolicy)
      => ComCall(11, this.p, VARIANT.Ptr, pvarValue, BOOL.Ptr, pbSetByPolicy)
}
struct IEnumOfflineFilesSettings extends IUnknown {
    static IID := "{729680C4-1A38-47BC-9E5C-02C51562AC30}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IOfflineFilesSetting.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumOfflineFilesSettings.Ptr, ppenum)
}
struct IOfflineFilesCache extends IUnknown {
    static IID := "{855D6203-7914-48B9-8D40-4C56F5ACFFC5}"
    Synchronize(hwndParent?, rgpszPaths, bAsync, dwSyncControl, pISyncConflictHandler?, pIProgress?, pSyncId?)
      => ComCall(3, this.p, HWND, hwndParent?, PWSTR.Ptr, rgpszPaths, UInt32, rgpszPaths.Length, BOOL, bAsync, UInt32, dwSyncControl, IOfflineFilesSyncConflictHandler, pISyncConflictHandler?, IOfflineFilesSyncProgress, pIProgress?, GUID.Ptr, pSyncId?)
    DeleteItems(rgpszPaths, dwFlags, bAsync, pIProgress?)
      => ComCall(4, this.p, PWSTR.Ptr, rgpszPaths, UInt32, rgpszPaths.Length, UInt32, dwFlags, BOOL, bAsync, IOfflineFilesSimpleProgress, pIProgress?)
    DeleteItemsForUser(pszUser, rgpszPaths, dwFlags, bAsync, pIProgress?)
      => ComCall(5, this.p, "Str", pszUser, PWSTR.Ptr, rgpszPaths, UInt32, rgpszPaths.Length, UInt32, dwFlags, BOOL, bAsync, IOfflineFilesSimpleProgress, pIProgress?)
    Pin(hwndParent?, rgpszPaths, bDeep, bAsync, dwPinControlFlags, pIProgress?)
      => ComCall(6, this.p, HWND, hwndParent?, PWSTR.Ptr, rgpszPaths, UInt32, rgpszPaths.Length, BOOL, bDeep, BOOL, bAsync, UInt32, dwPinControlFlags, IOfflineFilesSyncProgress, pIProgress?)
    Unpin(hwndParent?, rgpszPaths, bDeep, bAsync, dwPinControlFlags, pIProgress?)
      => ComCall(7, this.p, HWND, hwndParent?, PWSTR.Ptr, rgpszPaths, UInt32, rgpszPaths.Length, BOOL, bDeep, BOOL, bAsync, UInt32, dwPinControlFlags, IOfflineFilesSyncProgress, pIProgress?)
    GetEncryptionStatus(pbEncrypted, pbPartial)
      => ComCall(8, this.p, BOOL.Ptr, pbEncrypted, BOOL.Ptr, pbPartial)
    Encrypt(hwndParent?, bEncrypt, dwEncryptionControlFlags, bAsync, pIProgress?)
      => ComCall(9, this.p, HWND, hwndParent?, BOOL, bEncrypt, UInt32, dwEncryptionControlFlags, BOOL, bAsync, IOfflineFilesSyncProgress, pIProgress?)
    FindItem(pszPath, dwQueryFlags, ppItem)
      => ComCall(10, this.p, "Str", pszPath, UInt32, dwQueryFlags, IOfflineFilesItem.Ptr, ppItem)
    FindItemEx(pszPath, pIncludeFileFilter?, pIncludeDirFilter?, pExcludeFileFilter?, pExcludeDirFilter?, dwQueryFlags, ppItem)
      => ComCall(11, this.p, "Str", pszPath, IOfflineFilesItemFilter, pIncludeFileFilter?, IOfflineFilesItemFilter, pIncludeDirFilter?, IOfflineFilesItemFilter, pExcludeFileFilter?, IOfflineFilesItemFilter, pExcludeDirFilter?, UInt32, dwQueryFlags, IOfflineFilesItem.Ptr, ppItem)
    RenameItem(pszPathOriginal, pszPathNew, bReplaceIfExists)
      => ComCall(12, this.p, "Str", pszPathOriginal, "Str", pszPathNew, BOOL, bReplaceIfExists)
    GetLocation(ppszPath)
      => ComCall(13, this.p, PWSTR.Ptr, ppszPath)
    GetDiskSpaceInformation(pcbVolumeTotal, pcbLimit, pcbUsed, pcbUnpinnedLimit, pcbUnpinnedUsed)
      => ComCall(14, this.p, Int64.Ptr, pcbVolumeTotal, Int64.Ptr, pcbLimit, Int64.Ptr, pcbUsed, Int64.Ptr, pcbUnpinnedLimit, Int64.Ptr, pcbUnpinnedUsed)
    SetDiskSpaceLimits(cbLimit, cbUnpinnedLimit)
      => ComCall(15, this.p, Int64, cbLimit, Int64, cbUnpinnedLimit)
    ProcessAdminPinPolicy(pPinProgress?, pUnpinProgress?)
      => ComCall(16, this.p, IOfflineFilesSyncProgress, pPinProgress?, IOfflineFilesSyncProgress, pUnpinProgress?)
    GetSettingObject(pszSettingName, ppSetting)
      => ComCall(17, this.p, "Str", pszSettingName, IOfflineFilesSetting.Ptr, ppSetting)
    EnumSettingObjects(ppEnum)
      => ComCall(18, this.p, IEnumOfflineFilesSettings.Ptr, ppEnum)
    IsPathCacheable(pszPath, pbCacheable, pShareCachingMode)
      => ComCall(19, this.p, "Str", pszPath, BOOL.Ptr, pbCacheable, OFFLINEFILES_CACHING_MODE.Ptr, pShareCachingMode)
}
struct IOfflineFilesCache2 extends IOfflineFilesCache {
    static IID := "{8C075039-1551-4ED9-8781-56705C04D3C0}"
    RenameItemEx(pszPathOriginal, pszPathNew, bReplaceIfExists)
      => ComCall(20, this.p, "Str", pszPathOriginal, "Str", pszPathNew, BOOL, bReplaceIfExists)
}
