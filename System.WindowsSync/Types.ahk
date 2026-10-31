#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct ID_PARAMETER_PAIR {
    fIsVariable : BOOL
    cbIdSize : UInt16
}
struct ID_PARAMETERS {
    dwSize : UInt32
    replicaId : ID_PARAMETER_PAIR
    itemId : ID_PARAMETER_PAIR
    changeUnitId : ID_PARAMETER_PAIR
}
struct SYNC_SESSION_STATISTICS {
    dwChangesApplied : UInt32
    dwChangesFailed : UInt32
}
struct SYNC_VERSION {
    dwLastUpdatingReplicaKey : UInt32
    ullTickCount : Int64
}
struct SYNC_RANGE {
    pbClosedLowerBound : UInt8.Ptr
    pbClosedUpperBound : UInt8.Ptr
}
struct SYNC_TIME {
    dwDate : UInt32
    dwTime : UInt32
}
struct SYNC_FILTER_CHANGE {
    fMoveIn : BOOL
    moveVersion : SYNC_VERSION
}
struct SYNC_PROVIDER_ROLE extends Int32 {
    static SPR_SOURCE := 0
    static SPR_DESTINATION := 1
}
struct CONFLICT_RESOLUTION_POLICY extends Int32 {
    static CRP_NONE := 0
    static CRP_DESTINATION_PROVIDER_WINS := 1
    static CRP_SOURCE_PROVIDER_WINS := 2
    static CRP_LAST := 3
}
struct SYNC_PROGRESS_STAGE extends Int32 {
    static SPS_CHANGE_DETECTION := 0
    static SPS_CHANGE_ENUMERATION := 1
    static SPS_CHANGE_APPLICATION := 2
}
struct SYNC_FULL_ENUMERATION_ACTION extends Int32 {
    static SFEA_FULL_ENUMERATION := 0
    static SFEA_PARTIAL_SYNC := 1
    static SFEA_ABORT := 2
}
struct SYNC_RESOLVE_ACTION extends Int32 {
    static SRA_DEFER := 0
    static SRA_ACCEPT_DESTINATION_PROVIDER := 1
    static SRA_ACCEPT_SOURCE_PROVIDER := 2
    static SRA_MERGE := 3
    static SRA_TRANSFER_AND_DEFER := 4
    static SRA_LAST := 5
}
struct SYNC_STATISTICS extends Int32 {
    static SYNC_STATISTICS_RANGE_COUNT := 0
}
struct SYNC_SERIALIZATION_VERSION extends Int32 {
    static SYNC_SERIALIZATION_VERSION_V1 := 1
    static SYNC_SERIALIZATION_VERSION_V2 := 4
    static SYNC_SERIALIZATION_VERSION_V3 := 5
}
struct FILTERING_TYPE extends Int32 {
    static FT_CURRENT_ITEMS_ONLY := 0
    static FT_CURRENT_ITEMS_AND_VERSIONS_FOR_MOVED_OUT_ITEMS := 1
}
struct SYNC_CONSTRAINT_RESOLVE_ACTION extends Int32 {
    static SCRA_DEFER := 0
    static SCRA_ACCEPT_DESTINATION_PROVIDER := 1
    static SCRA_ACCEPT_SOURCE_PROVIDER := 2
    static SCRA_TRANSFER_AND_DEFER := 3
    static SCRA_MERGE := 4
    static SCRA_RENAME_SOURCE := 5
    static SCRA_RENAME_DESTINATION := 6
}
struct CONSTRAINT_CONFLICT_REASON extends Int32 {
    static CCR_OTHER := 0
    static CCR_COLLISION := 1
    static CCR_NOPARENT := 2
    static CCR_IDENTITY := 3
}
struct KNOWLEDGE_COOKIE_COMPARISON_RESULT extends Int32 {
    static KCCR_COOKIE_KNOWLEDGE_EQUAL := 0
    static KCCR_COOKIE_KNOWLEDGE_CONTAINED := 1
    static KCCR_COOKIE_KNOWLEDGE_CONTAINS := 2
    static KCCR_COOKIE_KNOWLEDGE_NOT_COMPARABLE := 3
}
struct IClockVectorElement extends IUnknown {
    static IID := "{E71C4250-ADF8-4A07-8FAE-5669596909C1}"
    GetReplicaKey(pdwReplicaKey)
      => ComCall(3, this.p, UInt32.Ptr, pdwReplicaKey)
    GetTickCount(pullTickCount)
      => ComCall(4, this.p, Int64.Ptr, pullTickCount)
}
struct IFeedClockVectorElement extends IClockVectorElement {
    static IID := "{A40B46D2-E97B-4156-B6DA-991F501B0F05}"
    GetSyncTime(pSyncTime)
      => ComCall(5, this.p, SYNC_TIME.Ptr, pSyncTime)
    GetFlags(pbFlags)
      => ComCall(6, this.p, UInt8.Ptr, pbFlags)
}
struct IClockVector extends IUnknown {
    static IID := "{14B2274A-8698-4CC6-9333-F89BD1D47BC4}"
    GetClockVectorElements(riid, ppiEnumClockVector)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppiEnumClockVector)
    GetClockVectorElementCount(pdwCount)
      => ComCall(4, this.p, UInt32.Ptr, pdwCount)
}
struct IFeedClockVector extends IClockVector {
    static IID := "{8D1D98D1-9FB8-4EC9-A553-54DD924E0F67}"
    GetUpdateCount(pdwUpdateCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwUpdateCount)
    IsNoConflictsSpecified(pfIsNoConflictsSpecified)
      => ComCall(6, this.p, BOOL.Ptr, pfIsNoConflictsSpecified)
}
struct IEnumClockVector extends IUnknown {
    static IID := "{525844DB-2837-4799-9E80-81A66E02220C}"
    Next(cClockVectorElements, ppiClockVectorElements, pcFetched)
      => ComCall(3, this.p, UInt32, cClockVectorElements, IClockVectorElement.Ptr, ppiClockVectorElements, UInt32.Ptr, pcFetched)
    Skip(cSyncVersions)
      => ComCall(4, this.p, UInt32, cSyncVersions)
    Reset()
      => ComCall(5, this.p)
    Clone(ppiEnum)
      => ComCall(6, this.p, IEnumClockVector.Ptr, ppiEnum)
}
struct IEnumFeedClockVector extends IUnknown {
    static IID := "{550F763D-146A-48F6-ABEB-6C88C7F70514}"
    Next(cClockVectorElements, ppiClockVectorElements, pcFetched)
      => ComCall(3, this.p, UInt32, cClockVectorElements, IFeedClockVectorElement.Ptr, ppiClockVectorElements, UInt32.Ptr, pcFetched)
    Skip(cSyncVersions)
      => ComCall(4, this.p, UInt32, cSyncVersions)
    Reset()
      => ComCall(5, this.p)
    Clone(ppiEnum)
      => ComCall(6, this.p, IEnumFeedClockVector.Ptr, ppiEnum)
}
struct ICoreFragment extends IUnknown {
    static IID := "{613B2AB5-B304-47D9-9C31-CE6C54401A15}"
    NextColumn(pChangeUnitId, pChangeUnitIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pChangeUnitId, UInt32.Ptr, pChangeUnitIdSize)
    NextRange(pItemId, pItemIdSize, piClockVector)
      => ComCall(4, this.p, UInt8.Ptr, pItemId, UInt32.Ptr, pItemIdSize, IClockVector.Ptr, piClockVector)
    Reset()
      => ComCall(5, this.p)
    GetColumnCount(pColumnCount)
      => ComCall(6, this.p, UInt32.Ptr, pColumnCount)
    GetRangeCount(pRangeCount)
      => ComCall(7, this.p, UInt32.Ptr, pRangeCount)
}
struct ICoreFragmentInspector extends IUnknown {
    static IID := "{F7FCC5FD-AE26-4679-BA16-96AAC583C134}"
    NextCoreFragments(requestedCount, ppiCoreFragments, pFetchedCount)
      => ComCall(3, this.p, UInt32, requestedCount, ICoreFragment.Ptr, ppiCoreFragments, UInt32.Ptr, pFetchedCount)
    Reset()
      => ComCall(4, this.p)
}
struct IRangeException extends IUnknown {
    static IID := "{75AE8777-6848-49F7-956C-A3A92F5096E8}"
    GetClosedRangeStart(pbClosedRangeStart, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbClosedRangeStart, UInt32.Ptr, pcbIdSize)
    GetClosedRangeEnd(pbClosedRangeEnd, pcbIdSize)
      => ComCall(4, this.p, UInt8.Ptr, pbClosedRangeEnd, UInt32.Ptr, pcbIdSize)
    GetClockVector(riid, ppUnk)
      => ComCall(5, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
}
struct IEnumRangeExceptions extends IUnknown {
    static IID := "{0944439F-DDB1-4176-B703-046FF22A2386}"
    Next(cExceptions, ppRangeException, pcFetched)
      => ComCall(3, this.p, UInt32, cExceptions, IRangeException.Ptr, ppRangeException, UInt32.Ptr, pcFetched)
    Skip(cExceptions)
      => ComCall(4, this.p, UInt32, cExceptions)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumRangeExceptions.Ptr, ppEnum)
}
struct ISingleItemException extends IUnknown {
    static IID := "{892FB9B0-7C55-4A18-9316-FDF449569B64}"
    GetItemId(pbItemId, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbItemId, UInt32.Ptr, pcbIdSize)
    GetClockVector(riid, ppUnk)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
}
struct IEnumSingleItemExceptions extends IUnknown {
    static IID := "{E563381C-1B4D-4C66-9796-C86FACCDCD40}"
    Next(cExceptions, ppSingleItemException, pcFetched)
      => ComCall(3, this.p, UInt32, cExceptions, ISingleItemException.Ptr, ppSingleItemException, UInt32.Ptr, pcFetched)
    Skip(cExceptions)
      => ComCall(4, this.p, UInt32, cExceptions)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSingleItemExceptions.Ptr, ppEnum)
}
struct IChangeUnitException extends IUnknown {
    static IID := "{0CD7EE7C-FEC0-4021-99EE-F0E5348F2A5F}"
    GetItemId(pbItemId, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbItemId, UInt32.Ptr, pcbIdSize)
    GetChangeUnitId(pbChangeUnitId, pcbIdSize)
      => ComCall(4, this.p, UInt8.Ptr, pbChangeUnitId, UInt32.Ptr, pcbIdSize)
    GetClockVector(riid, ppUnk)
      => ComCall(5, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
}
struct IEnumChangeUnitExceptions extends IUnknown {
    static IID := "{3074E802-9319-4420-BE21-1022E2E21DA8}"
    Next(cExceptions, ppChangeUnitException, pcFetched)
      => ComCall(3, this.p, UInt32, cExceptions, IChangeUnitException.Ptr, ppChangeUnitException, UInt32.Ptr, pcFetched)
    Skip(cExceptions)
      => ComCall(4, this.p, UInt32, cExceptions)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumChangeUnitExceptions.Ptr, ppEnum)
}
struct IReplicaKeyMap extends IUnknown {
    static IID := "{2209F4FC-FD10-4FF0-84A8-F0A1982E440E}"
    LookupReplicaKey(pbReplicaId, pdwReplicaKey)
      => ComCall(3, this.p, UInt8.Ptr, pbReplicaId, UInt32.Ptr, pdwReplicaKey)
    LookupReplicaId(dwReplicaKey, pbReplicaId, pcbIdSize)
      => ComCall(4, this.p, UInt32, dwReplicaKey, UInt8.Ptr, pbReplicaId, UInt32.Ptr, pcbIdSize)
    Serialize(pbReplicaKeyMap, pcbReplicaKeyMap)
      => ComCall(5, this.p, UInt8.Ptr, pbReplicaKeyMap, UInt32.Ptr, pcbReplicaKeyMap)
}
struct IConstructReplicaKeyMap extends IUnknown {
    static IID := "{DED10970-EC85-4115-B52C-4405845642A5}"
    FindOrAddReplica(pbReplicaId, pdwReplicaKey)
      => ComCall(3, this.p, UInt8.Ptr, pbReplicaId, UInt32.Ptr, pdwReplicaKey)
}
struct ISyncKnowledge extends IUnknown {
    static IID := "{615BBB53-C945-4203-BF4B-2CB65919A0AA}"
    GetOwnerReplicaId(pbReplicaId, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbReplicaId, UInt32.Ptr, pcbIdSize)
    Serialize(fSerializeReplicaKeyMap, pbKnowledge, pcbKnowledge)
      => ComCall(4, this.p, BOOL, fSerializeReplicaKeyMap, UInt8.Ptr, pbKnowledge, UInt32.Ptr, pcbKnowledge)
    SetLocalTickCount(ullTickCount)
      => ComCall(5, this.p, Int64, ullTickCount)
    ContainsChange(pbVersionOwnerReplicaId, pgidItemId, pSyncVersion)
      => ComCall(6, this.p, UInt8.Ptr, pbVersionOwnerReplicaId, UInt8.Ptr, pgidItemId, SYNC_VERSION.Ptr, pSyncVersion)
    ContainsChangeUnit(pbVersionOwnerReplicaId, pbItemId, pbChangeUnitId, pSyncVersion)
      => ComCall(7, this.p, UInt8.Ptr, pbVersionOwnerReplicaId, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId, SYNC_VERSION.Ptr, pSyncVersion)
    GetScopeVector(riid, ppUnk)
      => ComCall(8, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    GetReplicaKeyMap(ppReplicaKeyMap)
      => ComCall(9, this.p, IReplicaKeyMap.Ptr, ppReplicaKeyMap)
    Clone(ppClonedKnowledge)
      => ComCall(10, this.p, ISyncKnowledge.Ptr, ppClonedKnowledge)
    ConvertVersion(pKnowledgeIn, pbCurrentOwnerId, pVersionIn, pbNewOwnerId, pcbIdSize, pVersionOut)
      => ComCall(11, this.p, ISyncKnowledge, pKnowledgeIn, UInt8.Ptr, pbCurrentOwnerId, SYNC_VERSION.Ptr, pVersionIn, UInt8.Ptr, pbNewOwnerId, UInt32.Ptr, pcbIdSize, SYNC_VERSION.Ptr, pVersionOut)
    MapRemoteToLocal(pRemoteKnowledge, ppMappedKnowledge)
      => ComCall(12, this.p, ISyncKnowledge, pRemoteKnowledge, ISyncKnowledge.Ptr, ppMappedKnowledge)
    Union(pKnowledge)
      => ComCall(13, this.p, ISyncKnowledge, pKnowledge)
    ProjectOntoItem(pbItemId, ppKnowledgeOut)
      => ComCall(14, this.p, UInt8.Ptr, pbItemId, ISyncKnowledge.Ptr, ppKnowledgeOut)
    ProjectOntoChangeUnit(pbItemId, pbChangeUnitId, ppKnowledgeOut)
      => ComCall(15, this.p, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId, ISyncKnowledge.Ptr, ppKnowledgeOut)
    ProjectOntoRange(psrngSyncRange, ppKnowledgeOut)
      => ComCall(16, this.p, SYNC_RANGE.Ptr, psrngSyncRange, ISyncKnowledge.Ptr, ppKnowledgeOut)
    ExcludeItem(pbItemId)
      => ComCall(17, this.p, UInt8.Ptr, pbItemId)
    ExcludeChangeUnit(pbItemId, pbChangeUnitId)
      => ComCall(18, this.p, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId)
    ContainsKnowledge(pKnowledge)
      => ComCall(19, this.p, ISyncKnowledge, pKnowledge)
    FindMinTickCountForReplica(pbReplicaId, pullReplicaTickCount)
      => ComCall(20, this.p, UInt8.Ptr, pbReplicaId, Int64.Ptr, pullReplicaTickCount)
    GetRangeExceptions(riid, ppUnk)
      => ComCall(21, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    GetSingleItemExceptions(riid, ppUnk)
      => ComCall(22, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    GetChangeUnitExceptions(riid, ppUnk)
      => ComCall(23, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    FindClockVectorForItem(pbItemId, riid, ppUnk)
      => ComCall(24, this.p, UInt8.Ptr, pbItemId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    FindClockVectorForChangeUnit(pbItemId, pbChangeUnitId, riid, ppUnk)
      => ComCall(25, this.p, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppUnk)
    GetVersion(pdwVersion)
      => ComCall(26, this.p, UInt32.Ptr, pdwVersion)
}
struct IForgottenKnowledge extends ISyncKnowledge {
    static IID := "{456E0F96-6036-452B-9F9D-BCC4B4A85DB2}"
    ForgetToVersion(pKnowledge, pVersion)
      => ComCall(27, this.p, ISyncKnowledge, pKnowledge, SYNC_VERSION.Ptr, pVersion)
}
struct ISyncKnowledge2 extends ISyncKnowledge {
    static IID := "{ED0ADDC0-3B4B-46A1-9A45-45661D2114C8}"
    GetIdParameters(pIdParameters)
      => ComCall(27, this.p, ID_PARAMETERS.Ptr, pIdParameters)
    ProjectOntoColumnSet(ppColumns, count, ppiKnowledgeOut)
      => ComCall(28, this.p, UInt8.Ptr.Ptr, ppColumns, UInt32, count, ISyncKnowledge2.Ptr, ppiKnowledgeOut)
    SerializeWithOptions(targetFormatVersion, dwFlags, pbBuffer, pdwSerializedSize)
      => ComCall(29, this.p, SYNC_SERIALIZATION_VERSION, targetFormatVersion, UInt32, dwFlags, UInt8.Ptr, pbBuffer, UInt32.Ptr, pdwSerializedSize)
    GetLowestUncontainedId(piSyncKnowledge, pbItemId, pcbItemIdSize)
      => ComCall(30, this.p, ISyncKnowledge2, piSyncKnowledge, UInt8.Ptr, pbItemId, UInt32.Ptr, pcbItemIdSize)
    GetInspector(riid, ppiInspector)
      => ComCall(31, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppiInspector)
    GetMinimumSupportedVersion(pVersion)
      => ComCall(32, this.p, SYNC_SERIALIZATION_VERSION.Ptr, pVersion)
    GetStatistics(which, pValue)
      => ComCall(33, this.p, SYNC_STATISTICS, which, UInt32.Ptr, pValue)
    ContainsKnowledgeForItem(pKnowledge, pbItemId)
      => ComCall(34, this.p, ISyncKnowledge, pKnowledge, UInt8.Ptr, pbItemId)
    ContainsKnowledgeForChangeUnit(pKnowledge, pbItemId, pbChangeUnitId)
      => ComCall(35, this.p, ISyncKnowledge, pKnowledge, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId)
    ProjectOntoKnowledgeWithPrerequisite(pPrerequisiteKnowledge, pTemplateKnowledge, ppProjectedKnowledge)
      => ComCall(36, this.p, ISyncKnowledge, pPrerequisiteKnowledge, ISyncKnowledge, pTemplateKnowledge, ISyncKnowledge.Ptr, ppProjectedKnowledge)
    Complement(pSyncKnowledge, ppComplementedKnowledge)
      => ComCall(37, this.p, ISyncKnowledge, pSyncKnowledge, ISyncKnowledge.Ptr, ppComplementedKnowledge)
    IntersectsWithKnowledge(pSyncKnowledge)
      => ComCall(38, this.p, ISyncKnowledge, pSyncKnowledge)
    GetKnowledgeCookie(ppKnowledgeCookie)
      => ComCall(39, this.p, IUnknown.Ptr, ppKnowledgeCookie)
    CompareToKnowledgeCookie(pKnowledgeCookie, pResult)
      => ComCall(40, this.p, IUnknown, pKnowledgeCookie, KNOWLEDGE_COOKIE_COMPARISON_RESULT.Ptr, pResult)
}
struct IRecoverableErrorData extends IUnknown {
    static IID := "{B37C4A0A-4B7D-4C2D-9711-3B00D119B1C8}"
    Initialize(pcszItemDisplayName, pcszErrorDescription)
      => ComCall(3, this.p, "Str", pcszItemDisplayName, "Str", pcszErrorDescription)
    GetItemDisplayName(pszItemDisplayName, pcchItemDisplayName)
      => ComCall(4, this.p, "Str", pszItemDisplayName, UInt32.Ptr, pcchItemDisplayName)
    GetErrorDescription(pszErrorDescription, pcchErrorDescription)
      => ComCall(5, this.p, "Str", pszErrorDescription, UInt32.Ptr, pcchErrorDescription)
}
struct IRecoverableError extends IUnknown {
    static IID := "{0F5625E8-0A7B-45EE-9637-1CE13645909E}"
    GetStage(pStage)
      => ComCall(3, this.p, SYNC_PROGRESS_STAGE.Ptr, pStage)
    GetProvider(pProviderRole)
      => ComCall(4, this.p, SYNC_PROVIDER_ROLE.Ptr, pProviderRole)
    GetChangeWithRecoverableError(ppChangeWithRecoverableError)
      => ComCall(5, this.p, ISyncChange.Ptr, ppChangeWithRecoverableError)
    GetRecoverableErrorDataForChange(phrError, ppErrorData)
      => ComCall(6, this.p, HRESULT.Ptr, phrError, IRecoverableErrorData.Ptr, ppErrorData)
    GetRecoverableErrorDataForChangeUnit(pChangeUnit, phrError, ppErrorData)
      => ComCall(7, this.p, ISyncChangeUnit, pChangeUnit, HRESULT.Ptr, phrError, IRecoverableErrorData.Ptr, ppErrorData)
}
struct IChangeConflict extends IUnknown {
    static IID := "{014EBF97-9F20-4F7A-BDD4-25979C77C002}"
    GetDestinationProviderConflictingChange(ppConflictingChange)
      => ComCall(3, this.p, ISyncChange.Ptr, ppConflictingChange)
    GetSourceProviderConflictingChange(ppConflictingChange)
      => ComCall(4, this.p, ISyncChange.Ptr, ppConflictingChange)
    GetDestinationProviderConflictingData(ppConflictingData)
      => ComCall(5, this.p, IUnknown.Ptr, ppConflictingData)
    GetSourceProviderConflictingData(ppConflictingData)
      => ComCall(6, this.p, IUnknown.Ptr, ppConflictingData)
    GetResolveActionForChange(pResolveAction)
      => ComCall(7, this.p, SYNC_RESOLVE_ACTION.Ptr, pResolveAction)
    SetResolveActionForChange(resolveAction)
      => ComCall(8, this.p, SYNC_RESOLVE_ACTION, resolveAction)
    GetResolveActionForChangeUnit(pChangeUnit, pResolveAction)
      => ComCall(9, this.p, ISyncChangeUnit, pChangeUnit, SYNC_RESOLVE_ACTION.Ptr, pResolveAction)
    SetResolveActionForChangeUnit(pChangeUnit, resolveAction)
      => ComCall(10, this.p, ISyncChangeUnit, pChangeUnit, SYNC_RESOLVE_ACTION, resolveAction)
}
struct IConstraintConflict extends IUnknown {
    static IID := "{00D2302E-1CF8-4835-B85F-B7CA4F799E0A}"
    GetDestinationProviderConflictingChange(ppConflictingChange)
      => ComCall(3, this.p, ISyncChange.Ptr, ppConflictingChange)
    GetSourceProviderConflictingChange(ppConflictingChange)
      => ComCall(4, this.p, ISyncChange.Ptr, ppConflictingChange)
    GetDestinationProviderOriginalChange(ppOriginalChange)
      => ComCall(5, this.p, ISyncChange.Ptr, ppOriginalChange)
    GetDestinationProviderConflictingData(ppConflictingData)
      => ComCall(6, this.p, IUnknown.Ptr, ppConflictingData)
    GetSourceProviderConflictingData(ppConflictingData)
      => ComCall(7, this.p, IUnknown.Ptr, ppConflictingData)
    GetDestinationProviderOriginalData(ppOriginalData)
      => ComCall(8, this.p, IUnknown.Ptr, ppOriginalData)
    GetConstraintResolveActionForChange(pConstraintResolveAction)
      => ComCall(9, this.p, SYNC_CONSTRAINT_RESOLVE_ACTION.Ptr, pConstraintResolveAction)
    SetConstraintResolveActionForChange(constraintResolveAction)
      => ComCall(10, this.p, SYNC_CONSTRAINT_RESOLVE_ACTION, constraintResolveAction)
    GetConstraintResolveActionForChangeUnit(pChangeUnit, pConstraintResolveAction)
      => ComCall(11, this.p, ISyncChangeUnit, pChangeUnit, SYNC_CONSTRAINT_RESOLVE_ACTION.Ptr, pConstraintResolveAction)
    SetConstraintResolveActionForChangeUnit(pChangeUnit, constraintResolveAction)
      => ComCall(12, this.p, ISyncChangeUnit, pChangeUnit, SYNC_CONSTRAINT_RESOLVE_ACTION, constraintResolveAction)
    GetConstraintConflictReason(pConstraintConflictReason)
      => ComCall(13, this.p, CONSTRAINT_CONFLICT_REASON.Ptr, pConstraintConflictReason)
    IsTemporary()
      => ComCall(14, this.p)
}
struct ISyncCallback extends IUnknown {
    static IID := "{0599797F-5ED9-485C-AE36-0C5D1BF2E7A5}"
    OnProgress(provider, syncStage, dwCompletedWork, dwTotalWork)
      => ComCall(3, this.p, SYNC_PROVIDER_ROLE, provider, SYNC_PROGRESS_STAGE, syncStage, UInt32, dwCompletedWork, UInt32, dwTotalWork)
    OnChange(pSyncChange)
      => ComCall(4, this.p, ISyncChange, pSyncChange)
    OnConflict(pConflict)
      => ComCall(5, this.p, IChangeConflict, pConflict)
    OnFullEnumerationNeeded(pFullEnumerationAction)
      => ComCall(6, this.p, SYNC_FULL_ENUMERATION_ACTION.Ptr, pFullEnumerationAction)
    OnRecoverableError(pRecoverableError)
      => ComCall(7, this.p, IRecoverableError, pRecoverableError)
}
struct ISyncCallback2 extends ISyncCallback {
    static IID := "{47CE84AF-7442-4EAD-8630-12015E030AD7}"
    OnChangeApplied(dwChangesApplied, dwChangesFailed)
      => ComCall(8, this.p, UInt32, dwChangesApplied, UInt32, dwChangesFailed)
    OnChangeFailed(dwChangesApplied, dwChangesFailed)
      => ComCall(9, this.p, UInt32, dwChangesApplied, UInt32, dwChangesFailed)
}
struct ISyncConstraintCallback extends IUnknown {
    static IID := "{8AF3843E-75B3-438C-BB51-6F020D70D3CB}"
    OnConstraintConflict(pConflict)
      => ComCall(3, this.p, IConstraintConflict, pConflict)
}
struct ISyncProvider extends IUnknown {
    static IID := "{8F657056-2BCE-4A17-8C68-C7BB7898B56F}"
    GetIdParameters(pIdParameters)
      => ComCall(3, this.p, ID_PARAMETERS.Ptr, pIdParameters)
}
struct ISyncSessionState extends IUnknown {
    static IID := "{B8A940FE-9F01-483B-9434-C37D361225D9}"
    IsCanceled(pfIsCanceled)
      => ComCall(3, this.p, BOOL.Ptr, pfIsCanceled)
    GetInfoForChangeApplication(pbChangeApplierInfo, pcbChangeApplierInfo)
      => ComCall(4, this.p, UInt8.Ptr, pbChangeApplierInfo, UInt32.Ptr, pcbChangeApplierInfo)
    LoadInfoFromChangeApplication(pbChangeApplierInfo, cbChangeApplierInfo)
      => ComCall(5, this.p, UInt8.Ptr, pbChangeApplierInfo, UInt32, cbChangeApplierInfo)
    GetForgottenKnowledgeRecoveryRangeStart(pbRangeStart, pcbRangeStart)
      => ComCall(6, this.p, UInt8.Ptr, pbRangeStart, UInt32.Ptr, pcbRangeStart)
    GetForgottenKnowledgeRecoveryRangeEnd(pbRangeEnd, pcbRangeEnd)
      => ComCall(7, this.p, UInt8.Ptr, pbRangeEnd, UInt32.Ptr, pcbRangeEnd)
    SetForgottenKnowledgeRecoveryRange(pRange)
      => ComCall(8, this.p, SYNC_RANGE.Ptr, pRange)
    OnProgress(provider, syncStage, dwCompletedWork, dwTotalWork)
      => ComCall(9, this.p, SYNC_PROVIDER_ROLE, provider, SYNC_PROGRESS_STAGE, syncStage, UInt32, dwCompletedWork, UInt32, dwTotalWork)
}
struct ISyncSessionExtendedErrorInfo extends IUnknown {
    static IID := "{326C6810-790A-409B-B741-6999388761EB}"
    GetSyncProviderWithError(ppProviderWithError)
      => ComCall(3, this.p, ISyncProvider.Ptr, ppProviderWithError)
}
struct ISyncSessionState2 extends ISyncSessionState {
    static IID := "{9E37CFA3-9E38-4C61-9CA3-FFE810B45CA2}"
    SetProviderWithError(fSelf)
      => ComCall(10, this.p, BOOL, fSelf)
    GetSessionErrorStatus(phrSessionError)
      => ComCall(11, this.p, HRESULT.Ptr, phrSessionError)
}
struct ISyncFilterInfo extends IUnknown {
    static IID := "{794EAAF8-3F2E-47E6-9728-17E6FCF94CB7}"
    Serialize(pbBuffer, pcbBuffer)
      => ComCall(3, this.p, UInt8.Ptr, pbBuffer, UInt32.Ptr, pcbBuffer)
}
struct ISyncFilterInfo2 extends ISyncFilterInfo {
    static IID := "{19B394BA-E3D0-468C-934D-321968B2AB34}"
    GetFlags(pdwFlags)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags)
}
struct IChangeUnitListFilterInfo extends ISyncFilterInfo {
    static IID := "{F2837671-0BDF-43FA-B502-232375FB50C2}"
    Initialize(ppbChangeUnitIds, dwChangeUnitCount)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, ppbChangeUnitIds, UInt32, dwChangeUnitCount)
    GetChangeUnitIdCount(pdwChangeUnitIdCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwChangeUnitIdCount)
    GetChangeUnitId(dwChangeUnitIdIndex, pbChangeUnitId, pcbIdSize)
      => ComCall(6, this.p, UInt32, dwChangeUnitIdIndex, UInt8.Ptr, pbChangeUnitId, UInt32.Ptr, pcbIdSize)
}
struct ISyncFilter extends IUnknown {
    static IID := "{087A3F15-0FCB-44C1-9639-53C14E2B5506}"
    IsIdentical(pSyncFilter)
      => ComCall(3, this.p, ISyncFilter, pSyncFilter)
    Serialize(pbSyncFilter, pcbSyncFilter)
      => ComCall(4, this.p, UInt8.Ptr, pbSyncFilter, UInt32.Ptr, pcbSyncFilter)
}
struct ISyncFilterDeserializer extends IUnknown {
    static IID := "{B45B7A72-E5C7-46BE-9C82-77B8B15DAB8A}"
    DeserializeSyncFilter(pbSyncFilter, dwCbSyncFilter, ppISyncFilter)
      => ComCall(3, this.p, UInt8.Ptr, pbSyncFilter, UInt32, dwCbSyncFilter, ISyncFilter.Ptr, ppISyncFilter)
}
struct ICustomFilterInfo extends ISyncFilterInfo {
    static IID := "{1D335DFF-6F88-4E4D-91A8-A3F351CFD473}"
    GetSyncFilter(pISyncFilter)
      => ComCall(4, this.p, ISyncFilter.Ptr, pISyncFilter)
}
struct FILTER_COMBINATION_TYPE extends Int32 {
    static FCT_INTERSECTION := 0
}
struct ICombinedFilterInfo extends ISyncFilterInfo {
    static IID := "{11F9DE71-2818-4779-B2AC-42D450565F45}"
    GetFilterCount(pdwFilterCount)
      => ComCall(4, this.p, UInt32.Ptr, pdwFilterCount)
    GetFilterInfo(dwFilterIndex, ppIFilterInfo)
      => ComCall(5, this.p, UInt32, dwFilterIndex, ISyncFilterInfo.Ptr, ppIFilterInfo)
    GetFilterCombinationType(pFilterCombinationType)
      => ComCall(6, this.p, FILTER_COMBINATION_TYPE.Ptr, pFilterCombinationType)
}
struct IEnumSyncChanges extends IUnknown {
    static IID := "{5F86BE4A-5E78-4E32-AC1C-C24FD223EF85}"
    Next(cChanges, ppChange, pcFetched)
      => ComCall(3, this.p, UInt32, cChanges, ISyncChange.Ptr, ppChange, UInt32.Ptr, pcFetched)
    Skip(cChanges)
      => ComCall(4, this.p, UInt32, cChanges)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSyncChanges.Ptr, ppEnum)
}
struct ISyncChangeBuilder extends IUnknown {
    static IID := "{56F14771-8677-484F-A170-E386E418A676}"
    AddChangeUnitMetadata(pbChangeUnitId, pChangeUnitVersion)
      => ComCall(3, this.p, UInt8.Ptr, pbChangeUnitId, SYNC_VERSION.Ptr, pChangeUnitVersion)
}
struct IFilterTrackingSyncChangeBuilder extends IUnknown {
    static IID := "{295024A0-70DA-4C58-883C-CE2AFB308D0B}"
    AddFilterChange(dwFilterKey, pFilterChange)
      => ComCall(3, this.p, UInt32, dwFilterKey, SYNC_FILTER_CHANGE.Ptr, pFilterChange)
    SetAllChangeUnitsPresentFlag()
      => ComCall(4, this.p)
}
struct ISyncChangeBatchBase extends IUnknown {
    static IID := "{52F6E694-6A71-4494-A184-A8311BF5D227}"
    GetChangeEnumerator(ppEnum)
      => ComCall(3, this.p, IEnumSyncChanges.Ptr, ppEnum)
    GetIsLastBatch(pfLastBatch)
      => ComCall(4, this.p, BOOL.Ptr, pfLastBatch)
    GetWorkEstimateForBatch(pdwWorkForBatch)
      => ComCall(5, this.p, UInt32.Ptr, pdwWorkForBatch)
    GetRemainingWorkEstimateForSession(pdwRemainingWorkForSession)
      => ComCall(6, this.p, UInt32.Ptr, pdwRemainingWorkForSession)
    BeginOrderedGroup(pbLowerBound)
      => ComCall(7, this.p, UInt8.Ptr, pbLowerBound)
    EndOrderedGroup(pbUpperBound, pMadeWithKnowledge)
      => ComCall(8, this.p, UInt8.Ptr, pbUpperBound, ISyncKnowledge, pMadeWithKnowledge)
    AddItemMetadataToGroup(pbOwnerReplicaId, pbItemId, pChangeVersion, pCreationVersion, dwFlags, dwWorkForChange, ppChangeBuilder)
      => ComCall(9, this.p, UInt8.Ptr, pbOwnerReplicaId, UInt8.Ptr, pbItemId, SYNC_VERSION.Ptr, pChangeVersion, SYNC_VERSION.Ptr, pCreationVersion, UInt32, dwFlags, UInt32, dwWorkForChange, ISyncChangeBuilder.Ptr, ppChangeBuilder)
    GetLearnedKnowledge(ppLearnedKnowledge)
      => ComCall(10, this.p, ISyncKnowledge.Ptr, ppLearnedKnowledge)
    GetPrerequisiteKnowledge(ppPrerequisteKnowledge)
      => ComCall(11, this.p, ISyncKnowledge.Ptr, ppPrerequisteKnowledge)
    GetSourceForgottenKnowledge(ppSourceForgottenKnowledge)
      => ComCall(12, this.p, IForgottenKnowledge.Ptr, ppSourceForgottenKnowledge)
    SetLastBatch()
      => ComCall(13, this.p)
    SetWorkEstimateForBatch(dwWorkForBatch)
      => ComCall(14, this.p, UInt32, dwWorkForBatch)
    SetRemainingWorkEstimateForSession(dwRemainingWorkForSession)
      => ComCall(15, this.p, UInt32, dwRemainingWorkForSession)
    Serialize(pbChangeBatch, pcbChangeBatch)
      => ComCall(16, this.p, UInt8.Ptr, pbChangeBatch, UInt32.Ptr, pcbChangeBatch)
}
struct ISyncChangeBatch extends ISyncChangeBatchBase {
    static IID := "{70C64DEE-380F-4C2E-8F70-31C55BD5F9B3}"
    BeginUnorderedGroup()
      => ComCall(17, this.p)
    EndUnorderedGroup(pMadeWithKnowledge, fAllChangesForKnowledge)
      => ComCall(18, this.p, ISyncKnowledge, pMadeWithKnowledge, BOOL, fAllChangesForKnowledge)
    AddLoggedConflict(pbOwnerReplicaId, pbItemId, pChangeVersion, pCreationVersion, dwFlags, dwWorkForChange, pConflictKnowledge, ppChangeBuilder)
      => ComCall(19, this.p, UInt8.Ptr, pbOwnerReplicaId, UInt8.Ptr, pbItemId, SYNC_VERSION.Ptr, pChangeVersion, SYNC_VERSION.Ptr, pCreationVersion, UInt32, dwFlags, UInt32, dwWorkForChange, ISyncKnowledge, pConflictKnowledge, ISyncChangeBuilder.Ptr, ppChangeBuilder)
}
struct ISyncFullEnumerationChangeBatch extends ISyncChangeBatchBase {
    static IID := "{EF64197D-4F44-4EA2-B355-4524713E3BED}"
    GetLearnedKnowledgeAfterRecoveryComplete(ppLearnedKnowledgeAfterRecoveryComplete)
      => ComCall(17, this.p, ISyncKnowledge.Ptr, ppLearnedKnowledgeAfterRecoveryComplete)
    GetClosedLowerBoundItemId(pbClosedLowerBoundItemId, pcbIdSize)
      => ComCall(18, this.p, UInt8.Ptr, pbClosedLowerBoundItemId, UInt32.Ptr, pcbIdSize)
    GetClosedUpperBoundItemId(pbClosedUpperBoundItemId, pcbIdSize)
      => ComCall(19, this.p, UInt8.Ptr, pbClosedUpperBoundItemId, UInt32.Ptr, pcbIdSize)
}
struct ISyncChangeBatchWithPrerequisite extends ISyncChangeBatchBase {
    static IID := "{097F13BE-5B92-4048-B3F2-7B42A2515E07}"
    SetPrerequisiteKnowledge(pPrerequisiteKnowledge)
      => ComCall(17, this.p, ISyncKnowledge, pPrerequisiteKnowledge)
    GetLearnedKnowledgeWithPrerequisite(pDestinationKnowledge, ppLearnedWithPrerequisiteKnowledge)
      => ComCall(18, this.p, ISyncKnowledge, pDestinationKnowledge, ISyncKnowledge.Ptr, ppLearnedWithPrerequisiteKnowledge)
    GetLearnedForgottenKnowledge(ppLearnedForgottenKnowledge)
      => ComCall(19, this.p, IForgottenKnowledge.Ptr, ppLearnedForgottenKnowledge)
}
struct ISyncChangeBatchBase2 extends ISyncChangeBatchBase {
    static IID := "{6FDB596A-D755-4584-BD0C-C0C23A548FBF}"
    SerializeWithOptions(targetFormatVersion, dwFlags, pbBuffer, pdwSerializedSize)
      => ComCall(17, this.p, SYNC_SERIALIZATION_VERSION, targetFormatVersion, UInt32, dwFlags, UInt8.Ptr, pbBuffer, UInt32.Ptr, pdwSerializedSize)
}
struct ISyncChangeBatchAdvanced extends IUnknown {
    static IID := "{0F1A4995-CBC8-421D-B550-5D0BEBF3E9A5}"
    GetFilterInfo(ppFilterInfo)
      => ComCall(3, this.p, ISyncFilterInfo.Ptr, ppFilterInfo)
    ConvertFullEnumerationChangeBatchToRegularChangeBatch(ppChangeBatch)
      => ComCall(4, this.p, ISyncChangeBatch.Ptr, ppChangeBatch)
    GetUpperBoundItemId(pbItemId, pcbIdSize)
      => ComCall(5, this.p, UInt8.Ptr, pbItemId, UInt32.Ptr, pcbIdSize)
    GetBatchLevelKnowledgeShouldBeApplied(pfBatchKnowledgeShouldBeApplied)
      => ComCall(6, this.p, BOOL.Ptr, pfBatchKnowledgeShouldBeApplied)
}
struct ISyncChangeBatch2 extends ISyncChangeBatch {
    static IID := "{225F4A33-F5EE-4CC7-B039-67A262B4B2AC}"
    AddMergeTombstoneMetadataToGroup(pbOwnerReplicaId, pbWinnerItemId, pbItemId, pChangeVersion, pCreationVersion, dwWorkForChange, ppChangeBuilder)
      => ComCall(20, this.p, UInt8.Ptr, pbOwnerReplicaId, UInt8.Ptr, pbWinnerItemId, UInt8.Ptr, pbItemId, SYNC_VERSION.Ptr, pChangeVersion, SYNC_VERSION.Ptr, pCreationVersion, UInt32, dwWorkForChange, ISyncChangeBuilder.Ptr, ppChangeBuilder)
    AddMergeTombstoneLoggedConflict(pbOwnerReplicaId, pbWinnerItemId, pbItemId, pChangeVersion, pCreationVersion, dwWorkForChange, pConflictKnowledge, ppChangeBuilder)
      => ComCall(21, this.p, UInt8.Ptr, pbOwnerReplicaId, UInt8.Ptr, pbWinnerItemId, UInt8.Ptr, pbItemId, SYNC_VERSION.Ptr, pChangeVersion, SYNC_VERSION.Ptr, pCreationVersion, UInt32, dwWorkForChange, ISyncKnowledge, pConflictKnowledge, ISyncChangeBuilder.Ptr, ppChangeBuilder)
}
struct ISyncFullEnumerationChangeBatch2 extends ISyncFullEnumerationChangeBatch {
    static IID := "{E06449F4-A205-4B65-9724-01B22101EEC1}"
    AddMergeTombstoneMetadataToGroup(pbOwnerReplicaId, pbWinnerItemId, pbItemId, pChangeVersion, pCreationVersion, dwWorkForChange, ppChangeBuilder)
      => ComCall(20, this.p, UInt8.Ptr, pbOwnerReplicaId, UInt8.Ptr, pbWinnerItemId, UInt8.Ptr, pbItemId, SYNC_VERSION.Ptr, pChangeVersion, SYNC_VERSION.Ptr, pCreationVersion, UInt32, dwWorkForChange, ISyncChangeBuilder.Ptr, ppChangeBuilder)
}
struct IKnowledgeSyncProvider extends ISyncProvider {
    static IID := "{43434A49-8DA4-47F2-8172-AD7B8B024978}"
    BeginSession(role, pSessionState)
      => ComCall(4, this.p, SYNC_PROVIDER_ROLE, role, ISyncSessionState, pSessionState)
    GetSyncBatchParameters(ppSyncKnowledge, pdwRequestedBatchSize)
      => ComCall(5, this.p, ISyncKnowledge.Ptr, ppSyncKnowledge, UInt32.Ptr, pdwRequestedBatchSize)
    GetChangeBatch(dwBatchSize, pSyncKnowledge, ppSyncChangeBatch, ppUnkDataRetriever)
      => ComCall(6, this.p, UInt32, dwBatchSize, ISyncKnowledge, pSyncKnowledge, ISyncChangeBatch.Ptr, ppSyncChangeBatch, IUnknown.Ptr, ppUnkDataRetriever)
    GetFullEnumerationChangeBatch(dwBatchSize, pbLowerEnumerationBound, pSyncKnowledge, ppSyncChangeBatch, ppUnkDataRetriever)
      => ComCall(7, this.p, UInt32, dwBatchSize, UInt8.Ptr, pbLowerEnumerationBound, ISyncKnowledge, pSyncKnowledge, ISyncFullEnumerationChangeBatch.Ptr, ppSyncChangeBatch, IUnknown.Ptr, ppUnkDataRetriever)
    ProcessChangeBatch(resolutionPolicy, pSourceChangeBatch, pUnkDataRetriever, pCallback, pSyncSessionStatistics)
      => ComCall(8, this.p, CONFLICT_RESOLUTION_POLICY, resolutionPolicy, ISyncChangeBatch, pSourceChangeBatch, IUnknown, pUnkDataRetriever, ISyncCallback, pCallback, SYNC_SESSION_STATISTICS.Ptr, pSyncSessionStatistics)
    ProcessFullEnumerationChangeBatch(resolutionPolicy, pSourceChangeBatch, pUnkDataRetriever, pCallback, pSyncSessionStatistics)
      => ComCall(9, this.p, CONFLICT_RESOLUTION_POLICY, resolutionPolicy, ISyncFullEnumerationChangeBatch, pSourceChangeBatch, IUnknown, pUnkDataRetriever, ISyncCallback, pCallback, SYNC_SESSION_STATISTICS.Ptr, pSyncSessionStatistics)
    EndSession(pSessionState)
      => ComCall(10, this.p, ISyncSessionState, pSessionState)
}
struct ISyncChangeUnit extends IUnknown {
    static IID := "{60EDD8CA-7341-4BB7-95CE-FAB6394B51CB}"
    GetItemChange(ppSyncChange)
      => ComCall(3, this.p, ISyncChange.Ptr, ppSyncChange)
    GetChangeUnitId(pbChangeUnitId, pcbIdSize)
      => ComCall(4, this.p, UInt8.Ptr, pbChangeUnitId, UInt32.Ptr, pcbIdSize)
    GetChangeUnitVersion(pbCurrentReplicaId, pVersion)
      => ComCall(5, this.p, UInt8.Ptr, pbCurrentReplicaId, SYNC_VERSION.Ptr, pVersion)
}
struct IEnumSyncChangeUnits extends IUnknown {
    static IID := "{346B35F1-8703-4C6D-AB1A-4DBCA2CFF97F}"
    Next(cChanges, ppChangeUnit, pcFetched)
      => ComCall(3, this.p, UInt32, cChanges, ISyncChangeUnit.Ptr, ppChangeUnit, UInt32.Ptr, pcFetched)
    Skip(cChanges)
      => ComCall(4, this.p, UInt32, cChanges)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSyncChangeUnits.Ptr, ppEnum)
}
struct ISyncChange extends IUnknown {
    static IID := "{A1952BEB-0F6B-4711-B136-01DA85B968A6}"
    GetOwnerReplicaId(pbReplicaId, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbReplicaId, UInt32.Ptr, pcbIdSize)
    GetRootItemId(pbRootItemId, pcbIdSize)
      => ComCall(4, this.p, UInt8.Ptr, pbRootItemId, UInt32.Ptr, pcbIdSize)
    GetChangeVersion(pbCurrentReplicaId, pVersion)
      => ComCall(5, this.p, UInt8.Ptr, pbCurrentReplicaId, SYNC_VERSION.Ptr, pVersion)
    GetCreationVersion(pbCurrentReplicaId, pVersion)
      => ComCall(6, this.p, UInt8.Ptr, pbCurrentReplicaId, SYNC_VERSION.Ptr, pVersion)
    GetFlags(pdwFlags)
      => ComCall(7, this.p, UInt32.Ptr, pdwFlags)
    GetWorkEstimate(pdwWork)
      => ComCall(8, this.p, UInt32.Ptr, pdwWork)
    GetChangeUnits(ppEnum)
      => ComCall(9, this.p, IEnumSyncChangeUnits.Ptr, ppEnum)
    GetMadeWithKnowledge(ppMadeWithKnowledge)
      => ComCall(10, this.p, ISyncKnowledge.Ptr, ppMadeWithKnowledge)
    GetLearnedKnowledge(ppLearnedKnowledge)
      => ComCall(11, this.p, ISyncKnowledge.Ptr, ppLearnedKnowledge)
    SetWorkEstimate(dwWork)
      => ComCall(12, this.p, UInt32, dwWork)
}
struct ISyncChangeWithPrerequisite extends IUnknown {
    static IID := "{9E38382F-1589-48C3-92E4-05ECDCB4F3F7}"
    GetPrerequisiteKnowledge(ppPrerequisiteKnowledge)
      => ComCall(3, this.p, ISyncKnowledge.Ptr, ppPrerequisiteKnowledge)
    GetLearnedKnowledgeWithPrerequisite(pDestinationKnowledge, ppLearnedKnowledgeWithPrerequisite)
      => ComCall(4, this.p, ISyncKnowledge, pDestinationKnowledge, ISyncKnowledge.Ptr, ppLearnedKnowledgeWithPrerequisite)
}
struct ISyncFullEnumerationChange extends IUnknown {
    static IID := "{9785E0BD-BDFF-40C4-98C5-B34B2F1991B3}"
    GetLearnedKnowledgeAfterRecoveryComplete(ppLearnedKnowledge)
      => ComCall(3, this.p, ISyncKnowledge.Ptr, ppLearnedKnowledge)
    GetLearnedForgottenKnowledge(ppLearnedForgottenKnowledge)
      => ComCall(4, this.p, IForgottenKnowledge.Ptr, ppLearnedForgottenKnowledge)
}
struct ISyncMergeTombstoneChange extends IUnknown {
    static IID := "{6EC62597-0903-484C-AD61-36D6E938F47B}"
    GetWinnerItemId(pbWinnerItemId, pcbIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbWinnerItemId, UInt32.Ptr, pcbIdSize)
}
struct IEnumItemIds extends IUnknown {
    static IID := "{43AA3F61-4B2E-4B60-83DF-B110D3E148F1}"
    Next(pbItemId, pcbItemIdSize)
      => ComCall(3, this.p, UInt8.Ptr, pbItemId, UInt32.Ptr, pcbItemIdSize)
}
struct IFilterKeyMap extends IUnknown {
    static IID := "{CA169652-07C6-4708-A3DA-6E4EBA8D2297}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    AddFilter(pISyncFilter, pdwFilterKey)
      => ComCall(4, this.p, ISyncFilter, pISyncFilter, UInt32.Ptr, pdwFilterKey)
    GetFilter(dwFilterKey, ppISyncFilter)
      => ComCall(5, this.p, UInt32, dwFilterKey, ISyncFilter.Ptr, ppISyncFilter)
    Serialize(pbFilterKeyMap, pcbFilterKeyMap)
      => ComCall(6, this.p, UInt8.Ptr, pbFilterKeyMap, UInt32.Ptr, pcbFilterKeyMap)
}
struct ISyncChangeWithFilterKeyMap extends IUnknown {
    static IID := "{BFE1EF00-E87D-42FD-A4E9-242D70414AEF}"
    GetFilterCount(pdwFilterCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwFilterCount)
    GetFilterChange(dwFilterKey, pFilterChange)
      => ComCall(4, this.p, UInt32, dwFilterKey, SYNC_FILTER_CHANGE.Ptr, pFilterChange)
    GetAllChangeUnitsPresentFlag(pfAllChangeUnitsPresent)
      => ComCall(5, this.p, BOOL.Ptr, pfAllChangeUnitsPresent)
    GetFilterForgottenKnowledge(dwFilterKey, ppIFilterForgottenKnowledge)
      => ComCall(6, this.p, UInt32, dwFilterKey, ISyncKnowledge.Ptr, ppIFilterForgottenKnowledge)
    GetFilteredReplicaLearnedKnowledge(pDestinationKnowledge, pNewMoveins, ppLearnedKnowledge)
      => ComCall(7, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedKnowledge)
    GetLearnedFilterForgottenKnowledge(pDestinationKnowledge, pNewMoveins, dwFilterKey, ppLearnedFilterForgottenKnowledge)
      => ComCall(8, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, UInt32, dwFilterKey, ISyncKnowledge.Ptr, ppLearnedFilterForgottenKnowledge)
    GetFilteredReplicaLearnedForgottenKnowledge(pDestinationKnowledge, pNewMoveins, ppLearnedForgottenKnowledge)
      => ComCall(9, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedForgottenKnowledge)
    GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(pDestinationKnowledge, pNewMoveins, ppLearnedForgottenKnowledge)
      => ComCall(10, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedForgottenKnowledge)
    GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(pDestinationKnowledge, pNewMoveins, dwFilterKey, ppLearnedFilterForgottenKnowledge)
      => ComCall(11, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, UInt32, dwFilterKey, ISyncKnowledge.Ptr, ppLearnedFilterForgottenKnowledge)
}
struct ISyncChangeBatchWithFilterKeyMap extends IUnknown {
    static IID := "{DE247002-566D-459A-A6ED-A5AAB3459FB7}"
    GetFilterKeyMap(ppIFilterKeyMap)
      => ComCall(3, this.p, IFilterKeyMap.Ptr, ppIFilterKeyMap)
    SetFilterKeyMap(pIFilterKeyMap)
      => ComCall(4, this.p, IFilterKeyMap, pIFilterKeyMap)
    SetFilterForgottenKnowledge(dwFilterKey, pFilterForgottenKnowledge)
      => ComCall(5, this.p, UInt32, dwFilterKey, ISyncKnowledge, pFilterForgottenKnowledge)
    GetFilteredReplicaLearnedKnowledge(pDestinationKnowledge, pNewMoveins, ppLearnedForgottenKnowledge)
      => ComCall(6, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedForgottenKnowledge)
    GetLearnedFilterForgottenKnowledge(pDestinationKnowledge, pNewMoveins, dwFilterKey, ppLearnedFilterForgottenKnowledge)
      => ComCall(7, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, UInt32, dwFilterKey, ISyncKnowledge.Ptr, ppLearnedFilterForgottenKnowledge)
    GetFilteredReplicaLearnedForgottenKnowledge(pDestinationKnowledge, pNewMoveins, ppLearnedForgottenKnowledge)
      => ComCall(8, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedForgottenKnowledge)
    GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(pDestinationKnowledge, pNewMoveins, ppLearnedForgottenKnowledge)
      => ComCall(9, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, ISyncKnowledge.Ptr, ppLearnedForgottenKnowledge)
    GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(pDestinationKnowledge, pNewMoveins, dwFilterKey, ppLearnedFilterForgottenKnowledge)
      => ComCall(10, this.p, ISyncKnowledge, pDestinationKnowledge, IEnumItemIds, pNewMoveins, UInt32, dwFilterKey, ISyncKnowledge.Ptr, ppLearnedFilterForgottenKnowledge)
}
struct IDataRetrieverCallback extends IUnknown {
    static IID := "{71B4863B-F969-4676-BBC3-3D9FDC3FB2C7}"
    LoadChangeDataComplete(pUnkData)
      => ComCall(3, this.p, IUnknown, pUnkData)
    LoadChangeDataError(hrError)
      => ComCall(4, this.p, HRESULT, hrError)
}
struct ILoadChangeContext extends IUnknown {
    static IID := "{44A4AACA-EC39-46D5-B5C9-D633C0EE67E2}"
    GetSyncChange(ppSyncChange)
      => ComCall(3, this.p, ISyncChange.Ptr, ppSyncChange)
    SetRecoverableErrorOnChange(hrError, pErrorData)
      => ComCall(4, this.p, HRESULT, hrError, IRecoverableErrorData, pErrorData)
    SetRecoverableErrorOnChangeUnit(hrError, pChangeUnit, pErrorData)
      => ComCall(5, this.p, HRESULT, hrError, ISyncChangeUnit, pChangeUnit, IRecoverableErrorData, pErrorData)
}
struct ISynchronousDataRetriever extends IUnknown {
    static IID := "{9B22F2A9-A4CD-4648-9D8E-3A510D4DA04B}"
    GetIdParameters(pIdParameters)
      => ComCall(3, this.p, ID_PARAMETERS.Ptr, pIdParameters)
    LoadChangeData(pLoadChangeContext, ppUnkData)
      => ComCall(4, this.p, ILoadChangeContext, pLoadChangeContext, IUnknown.Ptr, ppUnkData)
}
struct IAsynchronousDataRetriever extends IUnknown {
    static IID := "{9FC7E470-61EA-4A88-9BE4-DF56A27CFEF2}"
    GetIdParameters(pIdParameters)
      => ComCall(3, this.p, ID_PARAMETERS.Ptr, pIdParameters)
    RegisterCallback(pDataRetrieverCallback)
      => ComCall(4, this.p, IDataRetrieverCallback, pDataRetrieverCallback)
    RevokeCallback(pDataRetrieverCallback)
      => ComCall(5, this.p, IDataRetrieverCallback, pDataRetrieverCallback)
    LoadChangeData(pLoadChangeContext)
      => ComCall(6, this.p, ILoadChangeContext, pLoadChangeContext)
}
struct IFilterRequestCallback extends IUnknown {
    static IID := "{82DF8873-6360-463A-A8A1-EDE5E1A1594D}"
    RequestFilter(pFilter?, filteringType)
      => ComCall(3, this.p, IUnknown, pFilter?, FILTERING_TYPE, filteringType)
}
struct IRequestFilteredSync extends IUnknown {
    static IID := "{2E020184-6D18-46A7-A32A-DA4AEB06696C}"
    SpecifyFilter(pCallback?)
      => ComCall(3, this.p, IFilterRequestCallback, pCallback?)
}
struct ISupportFilteredSync extends IUnknown {
    static IID := "{3D128DED-D555-4E0D-BF4B-FB213A8A9302}"
    AddFilter(pFilter?, filteringType)
      => ComCall(3, this.p, IUnknown, pFilter?, FILTERING_TYPE, filteringType)
}
struct IFilterTrackingRequestCallback extends IUnknown {
    static IID := "{713CA7BB-C858-4674-B4B6-1122436587A9}"
    RequestTrackedFilter(pFilter?)
      => ComCall(3, this.p, ISyncFilter, pFilter?)
}
struct IFilterTrackingProvider extends IUnknown {
    static IID := "{743383C0-FC4E-45BA-AD81-D9D84C7A24F8}"
    SpecifyTrackedFilters(pCallback?)
      => ComCall(3, this.p, IFilterTrackingRequestCallback, pCallback?)
    AddTrackedFilter(pFilter?)
      => ComCall(4, this.p, ISyncFilter, pFilter?)
}
struct ISupportLastWriteTime extends IUnknown {
    static IID := "{EADF816F-D0BD-43CA-8F40-5ACDC6C06F7A}"
    GetItemChangeTime(pbItemId, pullTimestamp)
      => ComCall(3, this.p, UInt8.Ptr, pbItemId, Int64.Ptr, pullTimestamp)
    GetChangeUnitChangeTime(pbItemId, pbChangeUnitId, pullTimestamp)
      => ComCall(4, this.p, UInt8.Ptr, pbItemId, UInt8.Ptr, pbChangeUnitId, Int64.Ptr, pullTimestamp)
}
struct IProviderConverter extends IUnknown {
    static IID := "{809B7276-98CF-4957-93A5-0EBDD3DDDFFD}"
    Initialize(pISyncProvider)
      => ComCall(3, this.p, ISyncProvider, pISyncProvider)
}
struct ISyncDataConverter extends IUnknown {
    static IID := "{435D4861-68D5-44AA-A0F9-72A0B00EF9CF}"
    ConvertDataRetrieverFromProviderFormat(pUnkDataRetrieverIn, pEnumSyncChanges, ppUnkDataOut)
      => ComCall(3, this.p, IUnknown, pUnkDataRetrieverIn, IEnumSyncChanges, pEnumSyncChanges, IUnknown.Ptr, ppUnkDataOut)
    ConvertDataRetrieverToProviderFormat(pUnkDataRetrieverIn, pEnumSyncChanges, ppUnkDataOut)
      => ComCall(4, this.p, IUnknown, pUnkDataRetrieverIn, IEnumSyncChanges, pEnumSyncChanges, IUnknown.Ptr, ppUnkDataOut)
    ConvertDataFromProviderFormat(pDataContext, pUnkDataIn, ppUnkDataOut)
      => ComCall(5, this.p, ILoadChangeContext, pDataContext, IUnknown, pUnkDataIn, IUnknown.Ptr, ppUnkDataOut)
    ConvertDataToProviderFormat(pDataContext, pUnkDataOut, ppUnkDataout)
      => ComCall(6, this.p, ILoadChangeContext, pDataContext, IUnknown, pUnkDataOut, IUnknown.Ptr, ppUnkDataout)
}
struct SyncProviderConfiguration {
    dwVersion : UInt32
    guidInstanceId : GUID
    clsidProvider : GUID
    guidConfigUIInstanceId : GUID
    guidContentType : GUID
    dwCapabilities : UInt32
    dwSupportedArchitecture : UInt32
}
struct SyncProviderConfigUIConfiguration {
    dwVersion : UInt32
    guidInstanceId : GUID
    clsidConfigUI : GUID
    guidContentType : GUID
    dwCapabilities : UInt32
    dwSupportedArchitecture : UInt32
    fIsGlobal : BOOL
}
struct ISyncProviderRegistration extends IUnknown {
    static IID := "{CB45953B-7624-47BC-A472-EB8CAC6B222E}"
    CreateSyncProviderConfigUIRegistrationInstance(pConfigUIConfig, ppConfigUIInfo)
      => ComCall(3, this.p, SyncProviderConfigUIConfiguration.Ptr, pConfigUIConfig, ISyncProviderConfigUIInfo.Ptr, ppConfigUIInfo)
    UnregisterSyncProviderConfigUI(pguidInstanceId)
      => ComCall(4, this.p, GUID.Ptr, pguidInstanceId)
    EnumerateSyncProviderConfigUIs(pguidContentType?, dwSupportedArchitecture, ppEnumSyncProviderConfigUIInfos)
      => ComCall(5, this.p, GUID.Ptr, pguidContentType?, UInt32, dwSupportedArchitecture, IEnumSyncProviderConfigUIInfos.Ptr, ppEnumSyncProviderConfigUIInfos)
    CreateSyncProviderRegistrationInstance(pProviderConfiguration, ppProviderInfo)
      => ComCall(6, this.p, SyncProviderConfiguration.Ptr, pProviderConfiguration, ISyncProviderInfo.Ptr, ppProviderInfo)
    UnregisterSyncProvider(pguidInstanceId)
      => ComCall(7, this.p, GUID.Ptr, pguidInstanceId)
    GetSyncProviderConfigUIInfoforProvider(pguidProviderInstanceId, ppProviderConfigUIInfo)
      => ComCall(8, this.p, GUID.Ptr, pguidProviderInstanceId, ISyncProviderConfigUIInfo.Ptr, ppProviderConfigUIInfo)
    EnumerateSyncProviders(pguidContentType?, dwStateFlagsToFilterMask, dwStateFlagsToFilter, refProviderClsId, dwSupportedArchitecture, ppEnumSyncProviderInfos)
      => ComCall(9, this.p, GUID.Ptr, pguidContentType?, UInt32, dwStateFlagsToFilterMask, UInt32, dwStateFlagsToFilter, GUID.Ptr, refProviderClsId, UInt32, dwSupportedArchitecture, IEnumSyncProviderInfos.Ptr, ppEnumSyncProviderInfos)
    GetSyncProviderInfo(pguidInstanceId, ppProviderInfo)
      => ComCall(10, this.p, GUID.Ptr, pguidInstanceId, ISyncProviderInfo.Ptr, ppProviderInfo)
    GetSyncProviderFromInstanceId(pguidInstanceId, dwClsContext, ppSyncProvider)
      => ComCall(11, this.p, GUID.Ptr, pguidInstanceId, UInt32, dwClsContext, IRegisteredSyncProvider.Ptr, ppSyncProvider)
    GetSyncProviderConfigUIInfo(pguidInstanceId, ppConfigUIInfo)
      => ComCall(12, this.p, GUID.Ptr, pguidInstanceId, ISyncProviderConfigUIInfo.Ptr, ppConfigUIInfo)
    GetSyncProviderConfigUIFromInstanceId(pguidInstanceId, dwClsContext, ppConfigUI)
      => ComCall(13, this.p, GUID.Ptr, pguidInstanceId, UInt32, dwClsContext, ISyncProviderConfigUI.Ptr, ppConfigUI)
    GetSyncProviderState(pguidInstanceId, pdwStateFlags)
      => ComCall(14, this.p, GUID.Ptr, pguidInstanceId, UInt32.Ptr, pdwStateFlags)
    SetSyncProviderState(pguidInstanceId, dwStateFlagsMask, dwStateFlags)
      => ComCall(15, this.p, GUID.Ptr, pguidInstanceId, UInt32, dwStateFlagsMask, UInt32, dwStateFlags)
    RegisterForEvent(phEvent)
      => ComCall(16, this.p, HANDLE.Ptr, phEvent)
    RevokeEvent(hEvent)
      => ComCall(17, this.p, HANDLE, hEvent)
    GetChange(hEvent, ppChange)
      => ComCall(18, this.p, HANDLE, hEvent, ISyncRegistrationChange.Ptr, ppChange)
}
struct IEnumSyncProviderConfigUIInfos extends IUnknown {
    static IID := "{F6BE2602-17C6-4658-A2D7-68ED3330F641}"
    Next(ppSyncProviderConfigUIInfo, pcFetched)
      => ComCall(3, this.p, UInt32, ppSyncProviderConfigUIInfo.Length, ISyncProviderConfigUIInfo.Ptr, ppSyncProviderConfigUIInfo, UInt32.Ptr, pcFetched)
    Skip(cFactories)
      => ComCall(4, this.p, UInt32, cFactories)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSyncProviderConfigUIInfos.Ptr, ppEnum)
}
struct IEnumSyncProviderInfos extends IUnknown {
    static IID := "{A04BA850-5EB1-460D-A973-393FCB608A11}"
    Next(ppSyncProviderInfo, pcFetched)
      => ComCall(3, this.p, UInt32, ppSyncProviderInfo.Length, ISyncProviderInfo.Ptr, ppSyncProviderInfo, UInt32.Ptr, pcFetched)
    Skip(cInstances)
      => ComCall(4, this.p, UInt32, cInstances)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSyncProviderInfos.Ptr, ppEnum)
}
struct ISyncProviderInfo extends IPropertyStore {
    static IID := "{1EE135DE-88A4-4504-B0D0-F7920D7E5BA6}"
    GetSyncProvider(dwClsContext, ppSyncProvider)
      => ComCall(8, this.p, UInt32, dwClsContext, IRegisteredSyncProvider.Ptr, ppSyncProvider)
}
struct ISyncProviderConfigUIInfo extends IPropertyStore {
    static IID := "{214141AE-33D7-4D8D-8E37-F227E880CE50}"
    GetSyncProviderConfigUI(dwClsContext, ppSyncProviderConfigUI)
      => ComCall(8, this.p, UInt32, dwClsContext, ISyncProviderConfigUI.Ptr, ppSyncProviderConfigUI)
}
struct ISyncProviderConfigUI extends IUnknown {
    static IID := "{7B0705F6-CBCD-4071-AB05-3BDC364D4A0C}"
    Init(pguidInstanceId, pguidContentType, pConfigurationProperties?)
      => ComCall(3, this.p, GUID.Ptr, pguidInstanceId, GUID.Ptr, pguidContentType, IPropertyStore, pConfigurationProperties?)
    GetRegisteredProperties(ppConfigUIProperties)
      => ComCall(4, this.p, IPropertyStore.Ptr, ppConfigUIProperties)
    CreateAndRegisterNewSyncProvider(hwndParent?, pUnkContext?, ppProviderInfo)
      => ComCall(5, this.p, HWND, hwndParent?, IUnknown, pUnkContext?, ISyncProviderInfo.Ptr, ppProviderInfo)
    ModifySyncProvider(hwndParent?, pUnkContext?, pProviderInfo?)
      => ComCall(6, this.p, HWND, hwndParent?, IUnknown, pUnkContext?, ISyncProviderInfo, pProviderInfo?)
}
struct IRegisteredSyncProvider extends IUnknown {
    static IID := "{913BCF76-47C1-40B5-A896-5E8A9C414C14}"
    Init(pguidInstanceId, pguidContentType, pContextPropertyStore?)
      => ComCall(3, this.p, GUID.Ptr, pguidInstanceId, GUID.Ptr, pguidContentType, IPropertyStore, pContextPropertyStore?)
    GetInstanceId(pguidInstanceId)
      => ComCall(4, this.p, GUID.Ptr, pguidInstanceId)
    Reset()
      => ComCall(5, this.p)
}
struct SYNC_REGISTRATION_EVENT extends Int32 {
    static SRE_PROVIDER_ADDED := 0
    static SRE_PROVIDER_REMOVED := 1
    static SRE_PROVIDER_UPDATED := 2
    static SRE_PROVIDER_STATE_CHANGED := 3
    static SRE_CONFIGUI_ADDED := 4
    static SRE_CONFIGUI_REMOVED := 5
    static SRE_CONFIGUI_UPDATED := 6
}
struct ISyncRegistrationChange extends IUnknown {
    static IID := "{EEA0D9AE-6B29-43B4-9E70-E3AE33BB2C3B}"
    GetEvent(psreEvent)
      => ComCall(3, this.p, SYNC_REGISTRATION_EVENT.Ptr, psreEvent)
    GetInstanceId(pguidInstanceId)
      => ComCall(4, this.p, GUID.Ptr, pguidInstanceId)
}
