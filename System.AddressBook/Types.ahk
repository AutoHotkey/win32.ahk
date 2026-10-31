#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HRESULT, HWND, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {CY, IStream, IUnknown}

struct LPWABACTIONITEM {
    Value : IntPtr
}
struct ENTRYID {
    abFlags : UInt8[4]
    ab : UInt8[1]
}
struct MAPIUID {
    ab : UInt8[16]
}
struct SPropTagArray {
    cValues : UInt32
    aulPropTag : UInt32[1]
}
struct SBinary {
    cb : UInt32
    lpb : UInt8.Ptr
}
struct SShortArray {
    cValues : UInt32
    lpi : Int16.Ptr
}
struct SGuidArray {
    cValues : UInt32
    lpguid : GUID.Ptr
}
struct SRealArray {
    cValues : UInt32
    lpflt : Float32.Ptr
}
struct SLongArray {
    cValues : UInt32
    lpl : Int32.Ptr
}
struct SLargeIntegerArray {
    cValues : UInt32
    lpli : Int64.Ptr
}
struct SDateTimeArray {
    cValues : UInt32
    lpft : FILETIME.Ptr
}
struct SAppTimeArray {
    cValues : UInt32
    lpat : Float64.Ptr
}
struct SCurrencyArray {
    cValues : UInt32
    lpcur : CY.Ptr
}
struct SBinaryArray {
    cValues : UInt32
    lpbin : SBinary.Ptr
}
struct SDoubleArray {
    cValues : UInt32
    lpdbl : Float64.Ptr
}
struct SWStringArray {
    cValues : UInt32
    lppszW : PWSTR.Ptr
}
struct SLPSTRArray {
    cValues : UInt32
    lppszA : PSTR.Ptr
}
struct UPV {
    union {
        i : Int16
        l : Int32
        ul : UInt32
        flt : Float32
        dbl : Float64
        b : UInt16
        cur : CY
        at : Float64
        ft : FILETIME
        lpszA : PSTR
        bin : SBinary
        lpszW : PWSTR
        lpguid : GUID.Ptr
        li : Int64
        MVi : SShortArray
        MVl : SLongArray
        MVflt : SRealArray
        MVdbl : SDoubleArray
        MVcur : SCurrencyArray
        MVat : SAppTimeArray
        MVft : SDateTimeArray
        MVbin : SBinaryArray
        MVszA : SLPSTRArray
        MVszW : SWStringArray
        MVguid : SGuidArray
        MVli : SLargeIntegerArray
        err : Int32
        x : Int32
    }
}
struct SPropValue {
    ulPropTag : UInt32
    dwAlignPad : UInt32
    Value : UPV
}
struct SPropProblem {
    ulIndex : UInt32
    ulPropTag : UInt32
    scode : Int32
}
struct SPropProblemArray {
    cProblem : UInt32
    aProblem : SPropProblem[1]
}
struct FLATENTRY {
    cb : UInt32
    abEntry : UInt8[1]
}
struct FLATENTRYLIST {
    cEntries : UInt32
    cbEntries : UInt32
    abEntries : UInt8[1]
}
struct MTSID {
    cb : UInt32
    ab : UInt8[1]
}
struct FLATMTSIDLIST {
    cMTSIDs : UInt32
    cbMTSIDs : UInt32
    abMTSIDs : UInt8[1]
}
struct ADRENTRY {
    ulReserved1 : UInt32
    cValues : UInt32
    rgPropVals : SPropValue.Ptr
}
struct ADRLIST {
    cEntries : UInt32
    aEntries : ADRENTRY[1]
}
struct SRow {
    ulAdrEntryPad : UInt32
    cValues : UInt32
    lpProps : SPropValue.Ptr
}
struct SRowSet {
    cRows : UInt32
    aRow : SRow[1]
}
struct LPALLOCATEBUFFER extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr.Ptr, Int32]
}
struct LPALLOCATEMORE extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, Struct.Ptr.Ptr, Int32]
}
struct LPFREEBUFFER extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct MAPIERROR {
    ulVersion : UInt32
    lpszError : Int8.Ptr
    lpszComponent : Int8.Ptr
    ulLowLevelError : UInt32
    ulContext : UInt32
}
struct ERROR_NOTIFICATION {
    cbEntryID : UInt32
    lpEntryID : ENTRYID.Ptr
    scode : Int32
    ulFlags : UInt32
    lpMAPIError : MAPIERROR.Ptr
}
struct NEWMAIL_NOTIFICATION {
    cbEntryID : UInt32
    lpEntryID : ENTRYID.Ptr
    cbParentID : UInt32
    lpParentID : ENTRYID.Ptr
    ulFlags : UInt32
    lpszMessageClass : Int8.Ptr
    ulMessageFlags : UInt32
}
struct OBJECT_NOTIFICATION {
    cbEntryID : UInt32
    lpEntryID : ENTRYID.Ptr
    ulObjType : UInt32
    cbParentID : UInt32
    lpParentID : ENTRYID.Ptr
    cbOldID : UInt32
    lpOldID : ENTRYID.Ptr
    cbOldParentID : UInt32
    lpOldParentID : ENTRYID.Ptr
    lpPropTagArray : SPropTagArray.Ptr
}
struct TABLE_NOTIFICATION {
    ulTableEvent : UInt32
    hResult : HRESULT
    propIndex : SPropValue
    propPrior : SPropValue
    row : SRow
    ulPad : UInt32
}
struct EXTENDED_NOTIFICATION {
    ulEvent : UInt32
    cb : UInt32
    pbEventParameters : UInt8.Ptr
}
struct STATUS_OBJECT_NOTIFICATION {
    cbEntryID : UInt32
    lpEntryID : ENTRYID.Ptr
    cValues : UInt32
    lpPropVals : SPropValue.Ptr
}
struct NOTIFICATION {
    ulEventType : UInt32
    ulAlignPad : UInt32
    info : this._info_e__Union
    struct _info_e__Union {
        union {
            err : ERROR_NOTIFICATION
            newmail : NEWMAIL_NOTIFICATION
            obj : OBJECT_NOTIFICATION
            tab : TABLE_NOTIFICATION
            ext : EXTENDED_NOTIFICATION
            statobj : STATUS_OBJECT_NOTIFICATION
        }
    }
}
struct IMAPIAdviseSink extends IUnknown {
    OnNotify(cNotif, lpNotifications)
      => ComCall(3, this.p, UInt32, cNotif, NOTIFICATION.Ptr, lpNotifications, UInt32)
}
struct LPNOTIFCALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, NOTIFICATION.Ptr, Int32]
}
struct IMAPIProgress extends IUnknown {
    Progress(ulValue, ulCount, ulTotal)
      => ComCall(3, this.p, UInt32, ulValue, UInt32, ulCount, UInt32, ulTotal)
    GetFlags(lpulFlags)
      => ComCall(4, this.p, UInt32.Ptr, lpulFlags)
    GetMax(lpulMax)
      => ComCall(5, this.p, UInt32.Ptr, lpulMax)
    GetMin(lpulMin)
      => ComCall(6, this.p, UInt32.Ptr, lpulMin)
    SetLimits(lpulMin, lpulMax, lpulFlags)
      => ComCall(7, this.p, UInt32.Ptr, lpulMin, UInt32.Ptr, lpulMax, UInt32.Ptr, lpulFlags)
}
struct MAPINAMEID {
    lpguid : GUID.Ptr
    ulKind : UInt32
    Kind : this._Kind_e__Union
    struct _Kind_e__Union {
        union {
            lID : Int32
            lpwstrName : PWSTR
        }
    }
}
struct IMAPIProp extends IUnknown {
    GetLastError(hResult1, ulFlags, lppMAPIError)
      => ComCall(3, this.p, HRESULT, hResult1, UInt32, ulFlags, MAPIERROR.Ptr.Ptr, lppMAPIError)
    SaveChanges(ulFlags)
      => ComCall(4, this.p, UInt32, ulFlags)
    GetProps(lpPropTagArray, ulFlags, lpcValues, lppPropArray)
      => ComCall(5, this.p, SPropTagArray.Ptr, lpPropTagArray, UInt32, ulFlags, UInt32.Ptr, lpcValues, SPropValue.Ptr.Ptr, lppPropArray)
    GetPropList(ulFlags, lppPropTagArray)
      => ComCall(6, this.p, UInt32, ulFlags, SPropTagArray.Ptr.Ptr, lppPropTagArray)
    OpenProperty(ulPropTag, lpiid, ulInterfaceOptions, ulFlags, lppUnk)
      => ComCall(7, this.p, UInt32, ulPropTag, GUID.Ptr, lpiid, UInt32, ulInterfaceOptions, UInt32, ulFlags, IUnknown.Ptr, lppUnk)
    SetProps(cValues, lpPropArray, lppProblems)
      => ComCall(8, this.p, UInt32, cValues, SPropValue.Ptr, lpPropArray, SPropProblemArray.Ptr.Ptr, lppProblems)
    DeleteProps(lpPropTagArray, lppProblems)
      => ComCall(9, this.p, SPropTagArray.Ptr, lpPropTagArray, SPropProblemArray.Ptr.Ptr, lppProblems)
    CopyTo(ciidExclude, rgiidExclude, lpExcludeProps, ulUIParam, lpProgress, lpInterface, lpDestObj, ulFlags, lppProblems)
      => ComCall(10, this.p, UInt32, ciidExclude, GUID.Ptr, rgiidExclude, SPropTagArray.Ptr, lpExcludeProps, IntPtr, ulUIParam, IMAPIProgress, lpProgress, GUID.Ptr, lpInterface, Struct.Ptr, lpDestObj, UInt32, ulFlags, SPropProblemArray.Ptr.Ptr, lppProblems)
    CopyProps(lpIncludeProps, ulUIParam, lpProgress, lpInterface, lpDestObj, ulFlags, lppProblems)
      => ComCall(11, this.p, SPropTagArray.Ptr, lpIncludeProps, IntPtr, ulUIParam, IMAPIProgress, lpProgress, GUID.Ptr, lpInterface, Struct.Ptr, lpDestObj, UInt32, ulFlags, SPropProblemArray.Ptr.Ptr, lppProblems)
    GetNamesFromIDs(lppPropTags, lpPropSetGuid, ulFlags, lpcPropNames, lpppPropNames)
      => ComCall(12, this.p, SPropTagArray.Ptr.Ptr, lppPropTags, GUID.Ptr, lpPropSetGuid, UInt32, ulFlags, UInt32.Ptr, lpcPropNames, MAPINAMEID.Ptr.Ptr.Ptr, lpppPropNames)
    GetIDsFromNames(cPropNames, lppPropNames, ulFlags, lppPropTags)
      => ComCall(13, this.p, UInt32, cPropNames, MAPINAMEID.Ptr.Ptr, lppPropNames, UInt32, ulFlags, SPropTagArray.Ptr.Ptr, lppPropTags)
}
struct SSortOrder {
    ulPropTag : UInt32
    ulOrder : UInt32
}
struct SSortOrderSet {
    cSorts : UInt32
    cCategories : UInt32
    cExpanded : UInt32
    aSort : SSortOrder[1]
}
struct SAndRestriction {
    cRes : UInt32
    lpRes : SRestriction.Ptr
}
struct SOrRestriction {
    cRes : UInt32
    lpRes : SRestriction.Ptr
}
struct SNotRestriction {
    ulReserved : UInt32
    lpRes : SRestriction.Ptr
}
struct SContentRestriction {
    ulFuzzyLevel : UInt32
    ulPropTag : UInt32
    lpProp : SPropValue.Ptr
}
struct SBitMaskRestriction {
    relBMR : UInt32
    ulPropTag : UInt32
    ulMask : UInt32
}
struct SPropertyRestriction {
    relop : UInt32
    ulPropTag : UInt32
    lpProp : SPropValue.Ptr
}
struct SComparePropsRestriction {
    relop : UInt32
    ulPropTag1 : UInt32
    ulPropTag2 : UInt32
}
struct SSizeRestriction {
    relop : UInt32
    ulPropTag : UInt32
    cb : UInt32
}
struct SExistRestriction {
    ulReserved1 : UInt32
    ulPropTag : UInt32
    ulReserved2 : UInt32
}
struct SSubRestriction {
    ulSubObject : UInt32
    lpRes : SRestriction.Ptr
}
struct SCommentRestriction {
    cValues : UInt32
    lpRes : SRestriction.Ptr
    lpProp : SPropValue.Ptr
}
struct SRestriction {
    rt : UInt32
    res : this._res_e__Union
    struct _res_e__Union {
        union {
            resCompareProps : SComparePropsRestriction
            resAnd : SAndRestriction
            resOr : SOrRestriction
            resNot : SNotRestriction
            resContent : SContentRestriction
            resProperty : SPropertyRestriction
            resBitMask : SBitMaskRestriction
            resSize : SSizeRestriction
            resExist : SExistRestriction
            resSub : SSubRestriction
            resComment : SCommentRestriction
        }
    }
}
struct IMAPITable extends IUnknown {
    GetLastError(hResult1, ulFlags, lppMAPIError)
      => ComCall(3, this.p, HRESULT, hResult1, UInt32, ulFlags, MAPIERROR.Ptr.Ptr, lppMAPIError)
    Advise(ulEventMask, lpAdviseSink, lpulConnection)
      => ComCall(4, this.p, UInt32, ulEventMask, IMAPIAdviseSink, lpAdviseSink, UInt32.Ptr, lpulConnection)
    Unadvise(ulConnection)
      => ComCall(5, this.p, UInt32, ulConnection)
    GetStatus(lpulTableStatus, lpulTableType)
      => ComCall(6, this.p, UInt32.Ptr, lpulTableStatus, UInt32.Ptr, lpulTableType)
    SetColumns(lpPropTagArray, ulFlags)
      => ComCall(7, this.p, SPropTagArray.Ptr, lpPropTagArray, UInt32, ulFlags)
    QueryColumns(ulFlags, lpPropTagArray)
      => ComCall(8, this.p, UInt32, ulFlags, SPropTagArray.Ptr.Ptr, lpPropTagArray)
    GetRowCount(ulFlags, lpulCount)
      => ComCall(9, this.p, UInt32, ulFlags, UInt32.Ptr, lpulCount)
    SeekRow(bkOrigin, lRowCount, lplRowsSought)
      => ComCall(10, this.p, UInt32, bkOrigin, Int32, lRowCount, Int32.Ptr, lplRowsSought)
    SeekRowApprox(ulNumerator, ulDenominator)
      => ComCall(11, this.p, UInt32, ulNumerator, UInt32, ulDenominator)
    QueryPosition(lpulRow, lpulNumerator, lpulDenominator)
      => ComCall(12, this.p, UInt32.Ptr, lpulRow, UInt32.Ptr, lpulNumerator, UInt32.Ptr, lpulDenominator)
    FindRow(lpRestriction, bkOrigin, ulFlags)
      => ComCall(13, this.p, SRestriction.Ptr, lpRestriction, UInt32, bkOrigin, UInt32, ulFlags)
    Restrict(lpRestriction, ulFlags)
      => ComCall(14, this.p, SRestriction.Ptr, lpRestriction, UInt32, ulFlags)
    CreateBookmark(lpbkPosition)
      => ComCall(15, this.p, UInt32.Ptr, lpbkPosition)
    FreeBookmark(bkPosition)
      => ComCall(16, this.p, UInt32, bkPosition)
    SortTable(lpSortCriteria, ulFlags)
      => ComCall(17, this.p, SSortOrderSet.Ptr, lpSortCriteria, UInt32, ulFlags)
    QuerySortOrder(lppSortCriteria)
      => ComCall(18, this.p, SSortOrderSet.Ptr.Ptr, lppSortCriteria)
    QueryRows(lRowCount, ulFlags, lppRows)
      => ComCall(19, this.p, Int32, lRowCount, UInt32, ulFlags, SRowSet.Ptr.Ptr, lppRows)
    Abort()
      => ComCall(20, this.p)
    ExpandRow(cbInstanceKey, pbInstanceKey, ulRowCount, ulFlags, lppRows, lpulMoreRows)
      => ComCall(21, this.p, UInt32, cbInstanceKey, UInt8.Ptr, pbInstanceKey, UInt32, ulRowCount, UInt32, ulFlags, SRowSet.Ptr.Ptr, lppRows, UInt32.Ptr, lpulMoreRows)
    CollapseRow(cbInstanceKey, pbInstanceKey, ulFlags, lpulRowCount)
      => ComCall(22, this.p, UInt32, cbInstanceKey, UInt8.Ptr, pbInstanceKey, UInt32, ulFlags, UInt32.Ptr, lpulRowCount)
    WaitForCompletion(ulFlags, ulTimeout, lpulTableStatus)
      => ComCall(23, this.p, UInt32, ulFlags, UInt32, ulTimeout, UInt32.Ptr, lpulTableStatus)
    GetCollapseState(ulFlags, cbInstanceKey, lpbInstanceKey, lpcbCollapseState, lppbCollapseState)
      => ComCall(24, this.p, UInt32, ulFlags, UInt32, cbInstanceKey, UInt8.Ptr, lpbInstanceKey, UInt32.Ptr, lpcbCollapseState, UInt8.Ptr.Ptr, lppbCollapseState)
    SetCollapseState(ulFlags, cbCollapseState, pbCollapseState, lpbkLocation)
      => ComCall(25, this.p, UInt32, ulFlags, UInt32, cbCollapseState, UInt8.Ptr, pbCollapseState, UInt32.Ptr, lpbkLocation)
}
struct IProfSect extends IMAPIProp {
}
struct IMAPIStatus extends IMAPIProp {
    ValidateState(ulUIParam?, ulFlags)
      => ComCall(14, this.p, IntPtr, ulUIParam?, UInt32, ulFlags)
    SettingsDialog(ulUIParam?, ulFlags)
      => ComCall(15, this.p, IntPtr, ulUIParam?, UInt32, ulFlags)
    ChangePassword(lpOldPass, lpNewPass, ulFlags)
      => ComCall(16, this.p, Int8.Ptr, lpOldPass, Int8.Ptr, lpNewPass, UInt32, ulFlags)
    FlushQueues(ulUIParam?, lpTargetTransport?, ulFlags)
      => ComCall(17, this.p, IntPtr, ulUIParam?, UInt32, lpTargetTransport?.Length ?? 0, ENTRYID.Ptr, lpTargetTransport?, UInt32, ulFlags)
}
struct IMAPIContainer extends IMAPIProp {
    GetContentsTable(ulFlags, lppTable)
      => ComCall(14, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    GetHierarchyTable(ulFlags, lppTable)
      => ComCall(15, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    OpenEntry(lpEntryID, lpInterface, ulFlags, lpulObjType, lppUnk)
      => ComCall(16, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, GUID.Ptr, lpInterface, UInt32, ulFlags, UInt32.Ptr, lpulObjType, IUnknown.Ptr, lppUnk)
    SetSearchCriteria(lpRestriction?, lpContainerList?, ulSearchFlags)
      => ComCall(17, this.p, SRestriction.Ptr, lpRestriction?, SBinaryArray.Ptr, lpContainerList?, UInt32, ulSearchFlags)
    GetSearchCriteria(ulFlags, lppRestriction, lppContainerList, lpulSearchState?)
      => ComCall(18, this.p, UInt32, ulFlags, SRestriction.Ptr.Ptr, lppRestriction, SBinaryArray.Ptr.Ptr, lppContainerList, UInt32.Ptr, lpulSearchState?)
}
struct FlagList {
    cFlags : UInt32
    ulFlag : UInt32[1]
}
struct IABContainer extends IMAPIContainer {
    CreateEntry(lpEntryID, ulCreateFlags, lppMAPIPropEntry)
      => ComCall(19, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, UInt32, ulCreateFlags, IMAPIProp.Ptr, lppMAPIPropEntry)
    CopyEntries(lpEntries, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(20, this.p, SBinaryArray.Ptr, lpEntries, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    DeleteEntries(lpEntries, ulFlags)
      => ComCall(21, this.p, SBinaryArray.Ptr, lpEntries, UInt32, ulFlags)
    ResolveNames(lpPropTagArray?, ulFlags, lpAdrList, lpFlagList)
      => ComCall(22, this.p, SPropTagArray.Ptr, lpPropTagArray?, UInt32, ulFlags, ADRLIST.Ptr, lpAdrList, FlagList.Ptr, lpFlagList)
}
struct IMailUser extends IMAPIProp {
}
struct IDistList extends IMAPIContainer {
    CreateEntry(lpEntryID, ulCreateFlags, lppMAPIPropEntry)
      => ComCall(19, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, UInt32, ulCreateFlags, IMAPIProp.Ptr, lppMAPIPropEntry)
    CopyEntries(lpEntries, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(20, this.p, SBinaryArray.Ptr, lpEntries, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    DeleteEntries(lpEntries, ulFlags)
      => ComCall(21, this.p, SBinaryArray.Ptr, lpEntries, UInt32, ulFlags)
    ResolveNames(lpPropTagArray?, ulFlags, lpAdrList, lpFlagList)
      => ComCall(22, this.p, SPropTagArray.Ptr, lpPropTagArray?, UInt32, ulFlags, ADRLIST.Ptr, lpAdrList, FlagList.Ptr, lpFlagList)
}
struct IMAPIFolder extends IMAPIContainer {
    CreateMessage(lpInterface, ulFlags, lppMessage)
      => ComCall(19, this.p, GUID.Ptr, lpInterface, UInt32, ulFlags, IMessage.Ptr, lppMessage)
    CopyMessages(lpMsgList, lpInterface?, lpDestFolder, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(20, this.p, SBinaryArray.Ptr, lpMsgList, GUID.Ptr, lpInterface?, Struct.Ptr, lpDestFolder, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    DeleteMessages(lpMsgList, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(21, this.p, SBinaryArray.Ptr, lpMsgList, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    CreateFolder(ulFolderType, lpszFolderName, lpszFolderComment?, lpInterface?, ulFlags, lppFolder)
      => ComCall(22, this.p, UInt32, ulFolderType, Int8.Ptr, lpszFolderName, Int8.Ptr, lpszFolderComment?, GUID.Ptr, lpInterface?, UInt32, ulFlags, IMAPIFolder.Ptr, lppFolder)
    CopyFolder(lpEntryID, lpInterface?, lpDestFolder, lpszNewFolderName, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(23, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, GUID.Ptr, lpInterface?, Struct.Ptr, lpDestFolder, Int8.Ptr, lpszNewFolderName, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    DeleteFolder(lpEntryID, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(24, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    SetReadFlags(lpMsgList, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(25, this.p, SBinaryArray.Ptr, lpMsgList, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    GetMessageStatus(lpEntryID, ulFlags, lpulMessageStatus)
      => ComCall(26, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, UInt32, ulFlags, UInt32.Ptr, lpulMessageStatus)
    SetMessageStatus(lpEntryID, ulNewStatus, ulNewStatusMask, lpulOldStatus)
      => ComCall(27, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, UInt32, ulNewStatus, UInt32, ulNewStatusMask, UInt32.Ptr, lpulOldStatus)
    SaveContentsSort(lpSortCriteria, ulFlags)
      => ComCall(28, this.p, SSortOrderSet.Ptr, lpSortCriteria, UInt32, ulFlags)
    EmptyFolder(ulUIParam?, lpProgress?, ulFlags)
      => ComCall(29, this.p, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
}
struct IMsgStore extends IMAPIProp {
    Advise(lpEntryID?, ulEventMask, lpAdviseSink, lpulConnection)
      => ComCall(14, this.p, UInt32, lpEntryID?.Size ?? 0, ENTRYID.Ptr, lpEntryID?, UInt32, ulEventMask, IMAPIAdviseSink, lpAdviseSink, UInt32.Ptr, lpulConnection)
    Unadvise(ulConnection)
      => ComCall(15, this.p, UInt32, ulConnection)
    CompareEntryIDs(lpEntryID1, lpEntryID2, ulFlags, lpulResult)
      => ComCall(16, this.p, UInt32, lpEntryID1.Size, ENTRYID.Ptr, lpEntryID1, UInt32, lpEntryID2.Size, ENTRYID.Ptr, lpEntryID2, UInt32, ulFlags, UInt32.Ptr, lpulResult)
    OpenEntry(lpEntryID, lpInterface?, ulFlags, lpulObjType, ppUnk)
      => ComCall(17, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, GUID.Ptr, lpInterface?, UInt32, ulFlags, UInt32.Ptr, lpulObjType, IUnknown.Ptr, ppUnk)
    SetReceiveFolder(lpszMessageClass?, ulFlags, lpEntryID)
      => ComCall(18, this.p, Int8.Ptr, lpszMessageClass?, UInt32, ulFlags, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID)
    GetReceiveFolder(lpszMessageClass?, ulFlags, lpcbEntryID, lppEntryID, lppszExplicitClass)
      => ComCall(19, this.p, Int8.Ptr, lpszMessageClass?, UInt32, ulFlags, UInt32.Ptr, lpcbEntryID, ENTRYID.Ptr.Ptr, lppEntryID, Int8.Ptr.Ptr, lppszExplicitClass)
    GetReceiveFolderTable(ulFlags, lppTable)
      => ComCall(20, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    StoreLogoff(lpulFlags)
      => ComCall(21, this.p, UInt32.Ptr, lpulFlags)
    AbortSubmit(lpEntryID, ulFlags)
      => ComCall(22, this.p, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID, UInt32, ulFlags)
    GetOutgoingQueue(ulFlags, lppTable)
      => ComCall(23, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    SetLockState(lpMessage, ulLockState)
      => ComCall(24, this.p, IMessage, lpMessage, UInt32, ulLockState)
    FinishedMsg(ulFlags, lpEntryID)
      => ComCall(25, this.p, UInt32, ulFlags, UInt32, lpEntryID.Size, ENTRYID.Ptr, lpEntryID)
    NotifyNewMail(lpNotification)
      => ComCall(26, this.p, NOTIFICATION.Ptr, lpNotification)
}
struct IMessage extends IMAPIProp {
    GetAttachmentTable(ulFlags, lppTable)
      => ComCall(14, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    OpenAttach(ulAttachmentNum, lpInterface?, ulFlags, lppAttach)
      => ComCall(15, this.p, UInt32, ulAttachmentNum, GUID.Ptr, lpInterface?, UInt32, ulFlags, IAttach.Ptr, lppAttach)
    CreateAttach(lpInterface?, ulFlags, lpulAttachmentNum, lppAttach)
      => ComCall(16, this.p, GUID.Ptr, lpInterface?, UInt32, ulFlags, UInt32.Ptr, lpulAttachmentNum, IAttach.Ptr, lppAttach)
    DeleteAttach(ulAttachmentNum, ulUIParam?, lpProgress?, ulFlags)
      => ComCall(17, this.p, UInt32, ulAttachmentNum, IntPtr, ulUIParam?, IMAPIProgress, lpProgress?, UInt32, ulFlags)
    GetRecipientTable(ulFlags, lppTable)
      => ComCall(18, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    ModifyRecipients(ulFlags, lpMods)
      => ComCall(19, this.p, UInt32, ulFlags, ADRLIST.Ptr, lpMods)
    SubmitMessage(ulFlags)
      => ComCall(20, this.p, UInt32, ulFlags)
    SetReadFlag(ulFlags)
      => ComCall(21, this.p, UInt32, ulFlags)
}
struct IAttach extends IMAPIProp {
}
struct LPFNABSDI extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, BOOL]
}
struct LPFNDISMISS extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, "Void"]
}
struct LPFNBUTTON extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, ENTRYID.Ptr, UInt32, Int32]
}
struct ADRPARM {
    cbABContEntryID : UInt32
    lpABContEntryID : ENTRYID.Ptr
    ulFlags : UInt32
    lpReserved : Struct.Ptr
    ulHelpContext : UInt32
    lpszHelpFileName : Int8.Ptr
    lpfnABSDI : LPFNABSDI
    lpfnDismiss : LPFNDISMISS
    lpvDismissContext : Struct.Ptr
    lpszCaption : Int8.Ptr
    lpszNewEntryTitle : Int8.Ptr
    lpszDestWellsTitle : Int8.Ptr
    cDestFields : UInt32
    nDestFieldFocus : UInt32
    lppszDestTitles : Int8.Ptr.Ptr
    lpulDestComps : UInt32.Ptr
    lpContRestriction : SRestriction.Ptr
    lpHierRestriction : SRestriction.Ptr
}
struct IMAPIControl extends IUnknown {
    GetLastError(hResult1, ulFlags, lppMAPIError)
      => ComCall(3, this.p, HRESULT, hResult1, UInt32, ulFlags, MAPIERROR.Ptr.Ptr, lppMAPIError)
    Activate(ulFlags, ulUIParam?)
      => ComCall(4, this.p, UInt32, ulFlags, IntPtr, ulUIParam?)
    GetState(ulFlags, lpulState)
      => ComCall(5, this.p, UInt32, ulFlags, UInt32.Ptr, lpulState)
}
struct DTBLLABEL {
    ulbLpszLabelName : UInt32
    ulFlags : UInt32
}
struct DTBLEDIT {
    ulbLpszCharsAllowed : UInt32
    ulFlags : UInt32
    ulNumCharsAllowed : UInt32
    ulPropTag : UInt32
}
struct DTBLLBX {
    ulFlags : UInt32
    ulPRSetProperty : UInt32
    ulPRTableName : UInt32
}
struct DTBLCOMBOBOX {
    ulbLpszCharsAllowed : UInt32
    ulFlags : UInt32
    ulNumCharsAllowed : UInt32
    ulPRPropertyName : UInt32
    ulPRTableName : UInt32
}
struct DTBLDDLBX {
    ulFlags : UInt32
    ulPRDisplayProperty : UInt32
    ulPRSetProperty : UInt32
    ulPRTableName : UInt32
}
struct DTBLCHECKBOX {
    ulbLpszLabel : UInt32
    ulFlags : UInt32
    ulPRPropertyName : UInt32
}
struct DTBLGROUPBOX {
    ulbLpszLabel : UInt32
    ulFlags : UInt32
}
struct DTBLBUTTON {
    ulbLpszLabel : UInt32
    ulFlags : UInt32
    ulPRControl : UInt32
}
struct DTBLPAGE {
    ulbLpszLabel : UInt32
    ulFlags : UInt32
    ulbLpszComponent : UInt32
    ulContext : UInt32
}
struct DTBLRADIOBUTTON {
    ulbLpszLabel : UInt32
    ulFlags : UInt32
    ulcButtons : UInt32
    ulPropTag : UInt32
    lReturnValue : Int32
}
struct DTBLMVLISTBOX {
    ulFlags : UInt32
    ulMVPropTag : UInt32
}
struct DTBLMVDDLBX {
    ulFlags : UInt32
    ulMVPropTag : UInt32
}
struct IProviderAdmin extends IUnknown {
    GetLastError(hResult1, ulFlags, lppMAPIError)
      => ComCall(3, this.p, HRESULT, hResult1, UInt32, ulFlags, MAPIERROR.Ptr.Ptr, lppMAPIError)
    GetProviderTable(ulFlags, lppTable)
      => ComCall(4, this.p, UInt32, ulFlags, IMAPITable.Ptr, lppTable)
    CreateProvider(lpszProvider, lpProps, ulUIParam?, ulFlags, lpUID)
      => ComCall(5, this.p, Int8.Ptr, lpszProvider, UInt32, lpProps.Length, SPropValue.Ptr, lpProps, IntPtr, ulUIParam?, UInt32, ulFlags, MAPIUID.Ptr, lpUID)
    DeleteProvider(lpUID)
      => ComCall(6, this.p, MAPIUID.Ptr, lpUID)
    OpenProfileSection(lpUID?, lpInterface?, ulFlags, lppProfSect)
      => ComCall(7, this.p, MAPIUID.Ptr, lpUID?, GUID.Ptr, lpInterface?, UInt32, ulFlags, IProfSect.Ptr, lppProfSect)
}
struct Gender extends Int32 {
    static genderUnspecified := 0
    static genderFemale := 1
    static genderMale := 2
}
struct CALLERRELEASE extends FunctionPointer {
    static Types := [UInt32, ITableData, IMAPITable, "Void"]
}
struct ITableData extends IUnknown {
    HrGetView(lpSSortOrderSet, lpfCallerRelease, ulCallerData, lppMAPITable)
      => ComCall(3, this.p, SSortOrderSet.Ptr, lpSSortOrderSet, CALLERRELEASE.Ptr, lpfCallerRelease, UInt32, ulCallerData, IMAPITable.Ptr, lppMAPITable)
    HrModifyRow(param0)
      => ComCall(4, this.p, SRow.Ptr, param0)
    HrDeleteRow(lpSPropValue)
      => ComCall(5, this.p, SPropValue.Ptr, lpSPropValue)
    HrQueryRow(lpsPropValue, lppSRow, lpuliRow)
      => ComCall(6, this.p, SPropValue.Ptr, lpsPropValue, SRow.Ptr.Ptr, lppSRow, UInt32.Ptr, lpuliRow)
    HrEnumRow(ulRowNumber, lppSRow)
      => ComCall(7, this.p, UInt32, ulRowNumber, SRow.Ptr.Ptr, lppSRow)
    HrNotify(ulFlags, cValues, lpSPropValue)
      => ComCall(8, this.p, UInt32, ulFlags, UInt32, cValues, SPropValue.Ptr, lpSPropValue)
    HrInsertRow(uliRow, lpSRow)
      => ComCall(9, this.p, UInt32, uliRow, SRow.Ptr, lpSRow)
    HrModifyRows(ulFlags, lpSRowSet)
      => ComCall(10, this.p, UInt32, ulFlags, SRowSet.Ptr, lpSRowSet)
    HrDeleteRows(ulFlags, lprowsetToDelete, cRowsDeleted)
      => ComCall(11, this.p, UInt32, ulFlags, SRowSet.Ptr, lprowsetToDelete, UInt32.Ptr, cRowsDeleted)
}
struct IPropData extends IMAPIProp {
    HrSetObjAccess(ulAccess)
      => ComCall(14, this.p, UInt32, ulAccess)
    HrSetPropAccess(lpPropTagArray, rgulAccess)
      => ComCall(15, this.p, SPropTagArray.Ptr, lpPropTagArray, UInt32.Ptr, rgulAccess)
    HrGetPropAccess(lppPropTagArray, lprgulAccess)
      => ComCall(16, this.p, SPropTagArray.Ptr.Ptr, lppPropTagArray, UInt32.Ptr.Ptr, lprgulAccess)
    HrAddObjProps(lppPropTagArray, lprgulAccess)
      => ComCall(17, this.p, SPropTagArray.Ptr, lppPropTagArray, SPropProblemArray.Ptr.Ptr, lprgulAccess)
}
struct PFNIDLE extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL]
}
struct LPOPENSTREAMONFILE extends FunctionPointer {
    static Types := [LPALLOCATEBUFFER, LPFREEBUFFER, UInt32, Int8.Ptr, Int8.Ptr, IStream.Ptr, HRESULT]
}
struct DTCTL {
    ulCtlType : UInt32
    ulCtlFlags : UInt32
    lpbNotif : UInt8.Ptr
    cbNotif : UInt32
    lpszFilter : Int8.Ptr
    ulItemID : UInt32
    ctl : this._ctl_e__Union
    struct _ctl_e__Union {
        union {
            lpv : Struct.Ptr
            lplabel : DTBLLABEL.Ptr
            lpedit : DTBLEDIT.Ptr
            lplbx : DTBLLBX.Ptr
            lpcombobox : DTBLCOMBOBOX.Ptr
            lpddlbx : DTBLDDLBX.Ptr
            lpcheckbox : DTBLCHECKBOX.Ptr
            lpgroupbox : DTBLGROUPBOX.Ptr
            lpbutton : DTBLBUTTON.Ptr
            lpradiobutton : DTBLRADIOBUTTON.Ptr
            lpmvlbx : DTBLMVLISTBOX.Ptr
            lpmvddlbx : DTBLMVDDLBX.Ptr
            lppage : DTBLPAGE.Ptr
        }
    }
}
struct DTPAGE {
    cctl : UInt32
    lpszResourceName : Int8.Ptr
    Anonymous : this._Anonymous_e__Union
    lpctl : DTCTL.Ptr
    struct _Anonymous_e__Union {
        union {
            lpszComponent : Int8.Ptr
            ulItemID : UInt32
        }
    }
}
struct LPDISPATCHNOTIFICATIONS extends FunctionPointer {
    static Types := [UInt32, HRESULT]
}
struct LPCREATECONVERSATIONINDEX extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, Int32]
}
struct IAddrBook extends IMAPIProp {
    OpenEntry(cbEntryID, lpEntryID, lpInterface, ulFlags, lpulObjType, lppUnk)
      => ComCall(14, this.p, UInt32, cbEntryID, ENTRYID.Ptr, lpEntryID, GUID.Ptr, lpInterface, UInt32, ulFlags, UInt32.Ptr, lpulObjType, IUnknown.Ptr, lppUnk)
    CompareEntryIDs(cbEntryID1, lpEntryID1, cbEntryID2, lpEntryID2, ulFlags, lpulResult)
      => ComCall(15, this.p, UInt32, cbEntryID1, ENTRYID.Ptr, lpEntryID1, UInt32, cbEntryID2, ENTRYID.Ptr, lpEntryID2, UInt32, ulFlags, UInt32.Ptr, lpulResult)
    Advise(cbEntryID, lpEntryID, ulEventMask, lpAdviseSink, lpulConnection)
      => ComCall(16, this.p, UInt32, cbEntryID, ENTRYID.Ptr, lpEntryID, UInt32, ulEventMask, IMAPIAdviseSink, lpAdviseSink, UInt32.Ptr, lpulConnection)
    Unadvise(ulConnection)
      => ComCall(17, this.p, UInt32, ulConnection)
    CreateOneOff(lpszName, lpszAdrType, lpszAddress, ulFlags, lpcbEntryID, lppEntryID)
      => ComCall(18, this.p, Int8.Ptr, lpszName, Int8.Ptr, lpszAdrType, Int8.Ptr, lpszAddress, UInt32, ulFlags, UInt32.Ptr, lpcbEntryID, ENTRYID.Ptr.Ptr, lppEntryID)
    NewEntry(ulUIParam, ulFlags, cbEIDContainer, lpEIDContainer, cbEIDNewEntryTpl, lpEIDNewEntryTpl, lpcbEIDNewEntry, lppEIDNewEntry)
      => ComCall(19, this.p, UInt32, ulUIParam, UInt32, ulFlags, UInt32, cbEIDContainer, ENTRYID.Ptr, lpEIDContainer, UInt32, cbEIDNewEntryTpl, ENTRYID.Ptr, lpEIDNewEntryTpl, UInt32.Ptr, lpcbEIDNewEntry, ENTRYID.Ptr.Ptr, lppEIDNewEntry)
    ResolveName(ulUIParam, ulFlags, lpszNewEntryTitle, lpAdrList)
      => ComCall(20, this.p, IntPtr, ulUIParam, UInt32, ulFlags, Int8.Ptr, lpszNewEntryTitle, ADRLIST.Ptr, lpAdrList)
    Address(lpulUIParam, lpAdrParms, lppAdrList)
      => ComCall(21, this.p, UInt32.Ptr, lpulUIParam, ADRPARM.Ptr, lpAdrParms, ADRLIST.Ptr.Ptr, lppAdrList)
    Details(lpulUIParam, lpfnDismiss1, lpvDismissContext, cbEntryID, lpEntryID, lpfButtonCallback, lpvButtonContext, lpszButtonText, ulFlags)
      => ComCall(22, this.p, IntPtr.Ptr, lpulUIParam, LPFNDISMISS, lpfnDismiss1, Struct.Ptr, lpvDismissContext, UInt32, cbEntryID, ENTRYID.Ptr, lpEntryID, LPFNBUTTON, lpfButtonCallback, Struct.Ptr, lpvButtonContext, Int8.Ptr, lpszButtonText, UInt32, ulFlags)
    RecipOptions(ulUIParam, ulFlags, lpRecip)
      => ComCall(23, this.p, UInt32, ulUIParam, UInt32, ulFlags, ADRENTRY.Ptr, lpRecip)
    QueryDefaultRecipOpt(lpszAdrType, ulFlags, lpcValues, lppOptions)
      => ComCall(24, this.p, Int8.Ptr, lpszAdrType, UInt32, ulFlags, UInt32.Ptr, lpcValues, SPropValue.Ptr.Ptr, lppOptions)
    GetPAB(lpcbEntryID, lppEntryID)
      => ComCall(25, this.p, UInt32.Ptr, lpcbEntryID, ENTRYID.Ptr.Ptr, lppEntryID)
    SetPAB(cbEntryID, lpEntryID)
      => ComCall(26, this.p, UInt32, cbEntryID, ENTRYID.Ptr, lpEntryID)
    GetDefaultDir(lpcbEntryID, lppEntryID)
      => ComCall(27, this.p, UInt32.Ptr, lpcbEntryID, ENTRYID.Ptr.Ptr, lppEntryID)
    SetDefaultDir(cbEntryID, lpEntryID)
      => ComCall(28, this.p, UInt32, cbEntryID, ENTRYID.Ptr, lpEntryID)
    GetSearchPath(ulFlags, lppSearchPath)
      => ComCall(29, this.p, UInt32, ulFlags, SRowSet.Ptr.Ptr, lppSearchPath)
    SetSearchPath(ulFlags, lpSearchPath)
      => ComCall(30, this.p, UInt32, ulFlags, SRowSet.Ptr, lpSearchPath)
    PrepareRecips(ulFlags, lpPropTagArray, lpRecipList)
      => ComCall(31, this.p, UInt32, ulFlags, SPropTagArray.Ptr, lpPropTagArray, ADRLIST.Ptr, lpRecipList)
}
struct IWABObject extends IUnknown {
    GetLastError(hResult1, ulFlags, lppMAPIError)
      => ComCall(3, this.p, HRESULT, hResult1, UInt32, ulFlags, MAPIERROR.Ptr.Ptr, lppMAPIError)
    AllocateBuffer(cbSize, lppBuffer)
      => ComCall(4, this.p, UInt32, cbSize, Struct.Ptr.Ptr, lppBuffer)
    AllocateMore(cbSize, lpObject, lppBuffer)
      => ComCall(5, this.p, UInt32, cbSize, Struct.Ptr, lpObject, Struct.Ptr.Ptr, lppBuffer)
    FreeBuffer(lpBuffer)
      => ComCall(6, this.p, Struct.Ptr, lpBuffer)
    Backup(lpFileName)
      => ComCall(7, this.p, PSTR, lpFileName)
    Import(lpWIP)
      => ComCall(8, this.p, PSTR, lpWIP)
    Find(lpIAB, hWnd1?)
      => ComCall(9, this.p, IAddrBook, lpIAB, HWND, hWnd1?)
    VCardDisplay(lpIAB, hWnd1?, lpszFileName)
      => ComCall(10, this.p, IAddrBook, lpIAB, HWND, hWnd1?, PSTR, lpszFileName)
    LDAPUrl(lpIAB, hWnd1?, ulFlags, lpszURL, lppMailUser)
      => ComCall(11, this.p, IAddrBook, lpIAB, HWND, hWnd1?, UInt32, ulFlags, PSTR, lpszURL, IMailUser.Ptr, lppMailUser)
    VCardCreate(lpIAB, ulFlags, lpszVCard, lpMailUser)
      => ComCall(12, this.p, IAddrBook, lpIAB, UInt32, ulFlags, PSTR, lpszVCard, IMailUser, lpMailUser)
    VCardRetrieve(lpIAB, ulFlags, lpszVCard, lppMailUser)
      => ComCall(13, this.p, IAddrBook, lpIAB, UInt32, ulFlags, PSTR, lpszVCard, IMailUser.Ptr, lppMailUser)
    GetMe(lpIAB, ulFlags, lpdwAction, lpsbEID, hwnd1?)
      => ComCall(14, this.p, IAddrBook, lpIAB, UInt32, ulFlags, UInt32.Ptr, lpdwAction, SBinary.Ptr, lpsbEID, HWND, hwnd1?)
    SetMe(lpIAB, ulFlags, sbEID, hwnd1?)
      => ComCall(15, this.p, IAddrBook, lpIAB, UInt32, ulFlags, SBinary, sbEID, HWND, hwnd1?)
}
struct WAB_PARAM {
    cbSize : UInt32 := this.Size
    hwnd : HWND
    szFileName : PSTR
    ulFlags : UInt32
    guidPSExt : GUID
}
struct LPWABOPEN extends FunctionPointer {
    static Types := [IAddrBook.Ptr, IWABObject.Ptr, WAB_PARAM.Ptr, UInt32, HRESULT]
}
struct LPWABOPENEX extends FunctionPointer {
    static Types := [IAddrBook.Ptr, IWABObject.Ptr, WAB_PARAM.Ptr, UInt32, LPALLOCATEBUFFER, LPALLOCATEMORE, LPFREEBUFFER, HRESULT]
}
struct WABIMPORTPARAM {
    cbSize : UInt32 := this.Size
    lpAdrBook : IAddrBook
    hWnd : HWND
    ulFlags : UInt32
    lpszFileName : PSTR
}
struct WABEXTDISPLAY {
    cbSize : UInt32 := this.Size
    lpWABObject : IWABObject
    lpAdrBook : IAddrBook
    lpPropObj : IMAPIProp
    fReadOnly : BOOL
    fDataChanged : BOOL
    ulFlags : UInt32
    lpv : Struct.Ptr
    lpsz : Int8.Ptr
}
struct IWABExtInit extends IUnknown {
    static IID := "{EA22EBF0-87A4-11D1-9ACF-00A0C91F9C8B}"
    Initialize(lpWABExtDisplay)
      => ComCall(3, this.p, WABEXTDISPLAY.Ptr, lpWABExtDisplay)
}
struct LPWABALLOCATEBUFFER extends FunctionPointer {
    static Types := [IWABObject, UInt32, Struct.Ptr.Ptr, Int32]
}
struct LPWABALLOCATEMORE extends FunctionPointer {
    static Types := [IWABObject, UInt32, Struct.Ptr, Struct.Ptr.Ptr, Int32]
}
struct LPWABFREEBUFFER extends FunctionPointer {
    static Types := [IWABObject, Struct.Ptr, UInt32]
}
struct NOTIFKEY {
    cb : UInt32
    ab : UInt8[1]
}
