#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HANDLE, HRESULT, HWND, PWSTR, SYSTEMTIME, VARIANT_BOOL, WPARAM}
#Import "..\Media.DirectShow\Types.ahk" {ALLOCATOR_PROPERTIES}
#Import "..\Media.MediaFoundation\Types.ahk" {AM_MEDIA_TYPE}
#Import "..\System.AddressBook\Types.ahk" {IAddrBook, IMAPITable, IMessage, SPropTagArray, SPropValue}
#Import "..\System.Com\Types.ahk" {CY, IDispatch, IEnumUnknown, IStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct HDRVCALL {
    Value : IntPtr
}
struct HDRVLINE {
    Value : IntPtr
}
struct HDRVPHONE {
    Value : IntPtr
}
struct HDRVMSPLINE {
    Value : IntPtr
}
struct HDRVDIALOGINSTANCE {
    Value : IntPtr
}
struct HTAPICALL {
    Value : IntPtr
}
struct HTAPILINE {
    Value : IntPtr
}
struct HTAPIPHONE {
    Value : IntPtr
}
struct HPROVIDER {
    Value : IntPtr
}
struct LINECALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, IntPtr, IntPtr, IntPtr, IntPtr, "Void"]
}
struct PHONECALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, IntPtr, IntPtr, IntPtr, IntPtr, "Void"]
}
struct LINEADDRESSCAPS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwLineDeviceID : UInt32
    dwAddressSize : UInt32
    dwAddressOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwAddressSharing : UInt32
    dwAddressStates : UInt32
    dwCallInfoStates : UInt32
    dwCallerIDFlags : UInt32
    dwCalledIDFlags : UInt32
    dwConnectedIDFlags : UInt32
    dwRedirectionIDFlags : UInt32
    dwRedirectingIDFlags : UInt32
    dwCallStates : UInt32
    dwDialToneModes : UInt32
    dwBusyModes : UInt32
    dwSpecialInfo : UInt32
    dwDisconnectModes : UInt32
    dwMaxNumActiveCalls : UInt32
    dwMaxNumOnHoldCalls : UInt32
    dwMaxNumOnHoldPendingCalls : UInt32
    dwMaxNumConference : UInt32
    dwMaxNumTransConf : UInt32
    dwAddrCapFlags : UInt32
    dwCallFeatures : UInt32
    dwRemoveFromConfCaps : UInt32
    dwRemoveFromConfState : UInt32
    dwTransferModes : UInt32
    dwParkModes : UInt32
    dwForwardModes : UInt32
    dwMaxForwardEntries : UInt32
    dwMaxSpecificEntries : UInt32
    dwMinFwdNumRings : UInt32
    dwMaxFwdNumRings : UInt32
    dwMaxCallCompletions : UInt32
    dwCallCompletionConds : UInt32
    dwCallCompletionModes : UInt32
    dwNumCompletionMessages : UInt32
    dwCompletionMsgTextEntrySize : UInt32
    dwCompletionMsgTextSize : UInt32
    dwCompletionMsgTextOffset : UInt32
    dwAddressFeatures : UInt32
    dwPredictiveAutoTransferStates : UInt32
    dwNumCallTreatments : UInt32
    dwCallTreatmentListSize : UInt32
    dwCallTreatmentListOffset : UInt32
    dwDeviceClassesSize : UInt32
    dwDeviceClassesOffset : UInt32
    dwMaxCallDataSize : UInt32
    dwCallFeatures2 : UInt32
    dwMaxNoAnswerTimeout : UInt32
    dwConnectedModes : UInt32
    dwOfferingModes : UInt32
    dwAvailableMediaModes : UInt32
}
struct LINEADDRESSSTATUS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumInUse : UInt32
    dwNumActiveCalls : UInt32
    dwNumOnHoldCalls : UInt32
    dwNumOnHoldPendCalls : UInt32
    dwAddressFeatures : UInt32
    dwNumRingsNoAnswer : UInt32
    dwForwardNumEntries : UInt32
    dwForwardSize : UInt32
    dwForwardOffset : UInt32
    dwTerminalModesSize : UInt32
    dwTerminalModesOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
}
struct LINEAGENTACTIVITYENTRY {
    dwID : UInt32
    dwNameSize : UInt32
    dwNameOffset : UInt32
}
struct LINEAGENTACTIVITYLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEAGENTCAPS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwAgentHandlerInfoSize : UInt32
    dwAgentHandlerInfoOffset : UInt32
    dwCapsVersion : UInt32
    dwFeatures : UInt32
    dwStates : UInt32
    dwNextStates : UInt32
    dwMaxNumGroupEntries : UInt32
    dwAgentStatusMessages : UInt32
    dwNumAgentExtensionIDs : UInt32
    dwAgentExtensionIDListSize : UInt32
    dwAgentExtensionIDListOffset : UInt32
    ProxyGUID : GUID
}
struct LINEAGENTGROUPENTRY {
    GroupID : this._GroupID_e__Struct
    dwNameSize : UInt32
    dwNameOffset : UInt32
    struct _GroupID_e__Struct {
        dwGroupID1 : UInt32
        dwGroupID2 : UInt32
        dwGroupID3 : UInt32
        dwGroupID4 : UInt32
    }
}
struct LINEAGENTGROUPLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEAGENTSTATUS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwGroupListSize : UInt32
    dwGroupListOffset : UInt32
    dwState : UInt32
    dwNextState : UInt32
    dwActivityID : UInt32
    dwActivitySize : UInt32
    dwActivityOffset : UInt32
    dwAgentFeatures : UInt32
    dwValidStates : UInt32
    dwValidNextStates : UInt32
}
struct LINEAPPINFO {
    dwMachineNameSize : UInt32
    dwMachineNameOffset : UInt32
    dwUserNameSize : UInt32
    dwUserNameOffset : UInt32
    dwModuleFilenameSize : UInt32
    dwModuleFilenameOffset : UInt32
    dwFriendlyNameSize : UInt32
    dwFriendlyNameOffset : UInt32
    dwMediaModes : UInt32
    dwAddressID : UInt32
}
struct LINEAGENTENTRY {
    hAgent : UInt32
    dwNameSize : UInt32
    dwNameOffset : UInt32
    dwIDSize : UInt32
    dwIDOffset : UInt32
    dwPINSize : UInt32
    dwPINOffset : UInt32
}
struct LINEAGENTLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEAGENTINFO {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwAgentState : UInt32
    dwNextAgentState : UInt32
    dwMeasurementPeriod : UInt32
    cyOverallCallRate : CY
    dwNumberOfACDCalls : UInt32
    dwNumberOfIncomingCalls : UInt32
    dwNumberOfOutgoingCalls : UInt32
    dwTotalACDTalkTime : UInt32
    dwTotalACDCallTime : UInt32
    dwTotalACDWrapUpTime : UInt32
}
struct LINEAGENTSESSIONENTRY {
    hAgentSession : UInt32
    hAgent : UInt32
    GroupID : GUID
    dwWorkingAddressID : UInt32
}
struct LINEAGENTSESSIONLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEAGENTSESSIONINFO {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwAgentSessionState : UInt32
    dwNextAgentSessionState : UInt32
    dateSessionStartTime : Float64
    dwSessionDuration : UInt32
    dwNumberOfCalls : UInt32
    dwTotalTalkTime : UInt32
    dwAverageTalkTime : UInt32
    dwTotalCallTime : UInt32
    dwAverageCallTime : UInt32
    dwTotalWrapUpTime : UInt32
    dwAverageWrapUpTime : UInt32
    cyACDCallRate : CY
    dwLongestTimeToAnswer : UInt32
    dwAverageTimeToAnswer : UInt32
}
struct LINEQUEUEENTRY {
    dwQueueID : UInt32
    dwNameSize : UInt32
    dwNameOffset : UInt32
}
struct LINEQUEUELIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEQUEUEINFO {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwMeasurementPeriod : UInt32
    dwTotalCallsQueued : UInt32
    dwCurrentCallsQueued : UInt32
    dwTotalCallsAbandoned : UInt32
    dwTotalCallsFlowedIn : UInt32
    dwTotalCallsFlowedOut : UInt32
    dwLongestEverWaitTime : UInt32
    dwCurrentLongestWaitTime : UInt32
    dwAverageWaitTime : UInt32
    dwFinalDisposition : UInt32
}
struct LINEPROXYREQUESTLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumEntries : UInt32
    dwListSize : UInt32
    dwListOffset : UInt32
}
struct LINEDIALPARAMS {
    dwDialPause : UInt32
    dwDialSpeed : UInt32
    dwDigitDuration : UInt32
    dwWaitForDialtone : UInt32
}
struct LINECALLINFO {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    hLine : UInt32
    dwLineDeviceID : UInt32
    dwAddressID : UInt32
    dwBearerMode : UInt32
    dwRate : UInt32
    dwMediaMode : UInt32
    dwAppSpecific : UInt32
    dwCallID : UInt32
    dwRelatedCallID : UInt32
    dwCallParamFlags : UInt32
    dwCallStates : UInt32
    dwMonitorDigitModes : UInt32
    dwMonitorMediaModes : UInt32
    DialParams : LINEDIALPARAMS
    dwOrigin : UInt32
    dwReason : UInt32
    dwCompletionID : UInt32
    dwNumOwners : UInt32
    dwNumMonitors : UInt32
    dwCountryCode : UInt32
    dwTrunk : UInt32
    dwCallerIDFlags : UInt32
    dwCallerIDSize : UInt32
    dwCallerIDOffset : UInt32
    dwCallerIDNameSize : UInt32
    dwCallerIDNameOffset : UInt32
    dwCalledIDFlags : UInt32
    dwCalledIDSize : UInt32
    dwCalledIDOffset : UInt32
    dwCalledIDNameSize : UInt32
    dwCalledIDNameOffset : UInt32
    dwConnectedIDFlags : UInt32
    dwConnectedIDSize : UInt32
    dwConnectedIDOffset : UInt32
    dwConnectedIDNameSize : UInt32
    dwConnectedIDNameOffset : UInt32
    dwRedirectionIDFlags : UInt32
    dwRedirectionIDSize : UInt32
    dwRedirectionIDOffset : UInt32
    dwRedirectionIDNameSize : UInt32
    dwRedirectionIDNameOffset : UInt32
    dwRedirectingIDFlags : UInt32
    dwRedirectingIDSize : UInt32
    dwRedirectingIDOffset : UInt32
    dwRedirectingIDNameSize : UInt32
    dwRedirectingIDNameOffset : UInt32
    dwAppNameSize : UInt32
    dwAppNameOffset : UInt32
    dwDisplayableAddressSize : UInt32
    dwDisplayableAddressOffset : UInt32
    dwCalledPartySize : UInt32
    dwCalledPartyOffset : UInt32
    dwCommentSize : UInt32
    dwCommentOffset : UInt32
    dwDisplaySize : UInt32
    dwDisplayOffset : UInt32
    dwUserUserInfoSize : UInt32
    dwUserUserInfoOffset : UInt32
    dwHighLevelCompSize : UInt32
    dwHighLevelCompOffset : UInt32
    dwLowLevelCompSize : UInt32
    dwLowLevelCompOffset : UInt32
    dwChargingInfoSize : UInt32
    dwChargingInfoOffset : UInt32
    dwTerminalModesSize : UInt32
    dwTerminalModesOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwCallTreatment : UInt32
    dwCallDataSize : UInt32
    dwCallDataOffset : UInt32
    dwSendingFlowspecSize : UInt32
    dwSendingFlowspecOffset : UInt32
    dwReceivingFlowspecSize : UInt32
    dwReceivingFlowspecOffset : UInt32
}
struct LINECALLLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwCallsNumEntries : UInt32
    dwCallsSize : UInt32
    dwCallsOffset : UInt32
}
struct LINECALLPARAMS {
    dwTotalSize : UInt32
    dwBearerMode : UInt32
    dwMinRate : UInt32
    dwMaxRate : UInt32
    dwMediaMode : UInt32
    dwCallParamFlags : UInt32
    dwAddressMode : UInt32
    dwAddressID : UInt32
    DialParams : LINEDIALPARAMS
    dwOrigAddressSize : UInt32
    dwOrigAddressOffset : UInt32
    dwDisplayableAddressSize : UInt32
    dwDisplayableAddressOffset : UInt32
    dwCalledPartySize : UInt32
    dwCalledPartyOffset : UInt32
    dwCommentSize : UInt32
    dwCommentOffset : UInt32
    dwUserUserInfoSize : UInt32
    dwUserUserInfoOffset : UInt32
    dwHighLevelCompSize : UInt32
    dwHighLevelCompOffset : UInt32
    dwLowLevelCompSize : UInt32
    dwLowLevelCompOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwPredictiveAutoTransferStates : UInt32
    dwTargetAddressSize : UInt32
    dwTargetAddressOffset : UInt32
    dwSendingFlowspecSize : UInt32
    dwSendingFlowspecOffset : UInt32
    dwReceivingFlowspecSize : UInt32
    dwReceivingFlowspecOffset : UInt32
    dwDeviceClassSize : UInt32
    dwDeviceClassOffset : UInt32
    dwDeviceConfigSize : UInt32
    dwDeviceConfigOffset : UInt32
    dwCallDataSize : UInt32
    dwCallDataOffset : UInt32
    dwNoAnswerTimeout : UInt32
    dwCallingPartyIDSize : UInt32
    dwCallingPartyIDOffset : UInt32
}
struct LINECALLSTATUS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwCallState : UInt32
    dwCallStateMode : UInt32
    dwCallPrivilege : UInt32
    dwCallFeatures : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwCallFeatures2 : UInt32
    tStateEntryTime : SYSTEMTIME
}
struct LINECALLTREATMENTENTRY {
    dwCallTreatmentID : UInt32
    dwCallTreatmentNameSize : UInt32
    dwCallTreatmentNameOffset : UInt32
}
struct LINECARDENTRY {
    dwPermanentCardID : UInt32
    dwCardNameSize : UInt32
    dwCardNameOffset : UInt32
    dwCardNumberDigits : UInt32
    dwSameAreaRuleSize : UInt32
    dwSameAreaRuleOffset : UInt32
    dwLongDistanceRuleSize : UInt32
    dwLongDistanceRuleOffset : UInt32
    dwInternationalRuleSize : UInt32
    dwInternationalRuleOffset : UInt32
    dwOptions : UInt32
}
struct LINECOUNTRYENTRY {
    dwCountryID : UInt32
    dwCountryCode : UInt32
    dwNextCountryID : UInt32
    dwCountryNameSize : UInt32
    dwCountryNameOffset : UInt32
    dwSameAreaRuleSize : UInt32
    dwSameAreaRuleOffset : UInt32
    dwLongDistanceRuleSize : UInt32
    dwLongDistanceRuleOffset : UInt32
    dwInternationalRuleSize : UInt32
    dwInternationalRuleOffset : UInt32
}
struct LINECOUNTRYLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumCountries : UInt32
    dwCountryListSize : UInt32
    dwCountryListOffset : UInt32
}
struct LINEDEVCAPS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwProviderInfoSize : UInt32
    dwProviderInfoOffset : UInt32
    dwSwitchInfoSize : UInt32
    dwSwitchInfoOffset : UInt32
    dwPermanentLineID : UInt32
    dwLineNameSize : UInt32
    dwLineNameOffset : UInt32
    dwStringFormat : UInt32
    dwAddressModes : UInt32
    dwNumAddresses : UInt32
    dwBearerModes : UInt32
    dwMaxRate : UInt32
    dwMediaModes : UInt32
    dwGenerateToneModes : UInt32
    dwGenerateToneMaxNumFreq : UInt32
    dwGenerateDigitModes : UInt32
    dwMonitorToneMaxNumFreq : UInt32
    dwMonitorToneMaxNumEntries : UInt32
    dwMonitorDigitModes : UInt32
    dwGatherDigitsMinTimeout : UInt32
    dwGatherDigitsMaxTimeout : UInt32
    dwMedCtlDigitMaxListSize : UInt32
    dwMedCtlMediaMaxListSize : UInt32
    dwMedCtlToneMaxListSize : UInt32
    dwMedCtlCallStateMaxListSize : UInt32
    dwDevCapFlags : UInt32
    dwMaxNumActiveCalls : UInt32
    dwAnswerMode : UInt32
    dwRingModes : UInt32
    dwLineStates : UInt32
    dwUUIAcceptSize : UInt32
    dwUUIAnswerSize : UInt32
    dwUUIMakeCallSize : UInt32
    dwUUIDropSize : UInt32
    dwUUISendUserUserInfoSize : UInt32
    dwUUICallInfoSize : UInt32
    MinDialParams : LINEDIALPARAMS
    MaxDialParams : LINEDIALPARAMS
    DefaultDialParams : LINEDIALPARAMS
    dwNumTerminals : UInt32
    dwTerminalCapsSize : UInt32
    dwTerminalCapsOffset : UInt32
    dwTerminalTextEntrySize : UInt32
    dwTerminalTextSize : UInt32
    dwTerminalTextOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwLineFeatures : UInt32
    dwSettableDevStatus : UInt32
    dwDeviceClassesSize : UInt32
    dwDeviceClassesOffset : UInt32
    PermanentLineGuid : GUID
}
struct LINEDEVSTATUS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumOpens : UInt32
    dwOpenMediaModes : UInt32
    dwNumActiveCalls : UInt32
    dwNumOnHoldCalls : UInt32
    dwNumOnHoldPendCalls : UInt32
    dwLineFeatures : UInt32
    dwNumCallCompletions : UInt32
    dwRingMode : UInt32
    dwSignalLevel : UInt32
    dwBatteryLevel : UInt32
    dwRoamMode : UInt32
    dwDevStatusFlags : UInt32
    dwTerminalModesSize : UInt32
    dwTerminalModesOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwAvailableMediaModes : UInt32
    dwAppInfoSize : UInt32
    dwAppInfoOffset : UInt32
}
struct LINEEXTENSIONID {
    dwExtensionID0 : UInt32
    dwExtensionID1 : UInt32
    dwExtensionID2 : UInt32
    dwExtensionID3 : UInt32
}
struct LINEFORWARD {
    dwForwardMode : UInt32
    dwCallerAddressSize : UInt32
    dwCallerAddressOffset : UInt32
    dwDestCountryCode : UInt32
    dwDestAddressSize : UInt32
    dwDestAddressOffset : UInt32
}
struct LINEFORWARDLIST {
    dwTotalSize : UInt32
    dwNumEntries : UInt32
    ForwardList : LINEFORWARD[1]
}
struct LINEGENERATETONE {
    dwFrequency : UInt32
    dwCadenceOn : UInt32
    dwCadenceOff : UInt32
    dwVolume : UInt32
}
struct LINEINITIALIZEEXPARAMS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwOptions : UInt32
    Handles : this._Handles_e__Union
    dwCompletionKey : UInt32
    struct _Handles_e__Union {
        union {
            hEvent : HANDLE
            hCompletionPort : HANDLE
        }
    }
}
struct LINELOCATIONENTRY {
    dwPermanentLocationID : UInt32
    dwLocationNameSize : UInt32
    dwLocationNameOffset : UInt32
    dwCountryCode : UInt32
    dwCityCodeSize : UInt32
    dwCityCodeOffset : UInt32
    dwPreferredCardID : UInt32
    dwLocalAccessCodeSize : UInt32
    dwLocalAccessCodeOffset : UInt32
    dwLongDistanceAccessCodeSize : UInt32
    dwLongDistanceAccessCodeOffset : UInt32
    dwTollPrefixListSize : UInt32
    dwTollPrefixListOffset : UInt32
    dwCountryID : UInt32
    dwOptions : UInt32
    dwCancelCallWaitingSize : UInt32
    dwCancelCallWaitingOffset : UInt32
}
struct LINEMEDIACONTROLCALLSTATE {
    dwCallStates : UInt32
    dwMediaControl : UInt32
}
struct LINEMEDIACONTROLDIGIT {
    dwDigit : UInt32
    dwDigitModes : UInt32
    dwMediaControl : UInt32
}
struct LINEMEDIACONTROLMEDIA {
    dwMediaModes : UInt32
    dwDuration : UInt32
    dwMediaControl : UInt32
}
struct LINEMEDIACONTROLTONE {
    dwAppSpecific : UInt32
    dwDuration : UInt32
    dwFrequency1 : UInt32
    dwFrequency2 : UInt32
    dwFrequency3 : UInt32
    dwMediaControl : UInt32
}
struct LINEMESSAGE {
    hDevice : UInt32
    dwMessageID : UInt32
    dwCallbackInstance : IntPtr
    dwParam1 : IntPtr
    dwParam2 : IntPtr
    dwParam3 : IntPtr
}
struct LINEMONITORTONE {
    dwAppSpecific : UInt32
    dwDuration : UInt32
    dwFrequency1 : UInt32
    dwFrequency2 : UInt32
    dwFrequency3 : UInt32
}
struct LINEPROVIDERENTRY {
    dwPermanentProviderID : UInt32
    dwProviderFilenameSize : UInt32
    dwProviderFilenameOffset : UInt32
}
struct LINEPROVIDERLIST {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumProviders : UInt32
    dwProviderListSize : UInt32
    dwProviderListOffset : UInt32
}
struct LINEPROXYREQUEST {
    dwSize : UInt32
    dwClientMachineNameSize : UInt32
    dwClientMachineNameOffset : UInt32
    dwClientUserNameSize : UInt32
    dwClientUserNameOffset : UInt32
    dwClientAppAPIVersion : UInt32
    dwRequestType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            SetAgentGroup : this._SetAgentGroup_e__Struct
            SetAgentState : this._SetAgentState_e__Struct
            SetAgentActivity : this._SetAgentActivity_e__Struct
            GetAgentCaps : this._GetAgentCaps_e__Struct
            GetAgentStatus : this._GetAgentStatus_e__Struct
            AgentSpecific : this._AgentSpecific_e__Struct
            GetAgentActivityList : this._GetAgentActivityList_e__Struct
            GetAgentGroupList : this._GetAgentGroupList_e__Struct
            CreateAgent : this._CreateAgent_e__Struct
            SetAgentStateEx : this._SetAgentStateEx_e__Struct
            SetAgentMeasurementPeriod : this._SetAgentMeasurementPeriod_e__Struct
            GetAgentInfo : this._GetAgentInfo_e__Struct
            CreateAgentSession : this._CreateAgentSession_e__Struct
            GetAgentSessionList : this._GetAgentSessionList_e__Struct
            GetAgentSessionInfo : this._GetAgentSessionInfo_e__Struct
            SetAgentSessionState : this._SetAgentSessionState_e__Struct
            GetQueueList : this._GetQueueList_e__Struct
            SetQueueMeasurementPeriod : this._SetQueueMeasurementPeriod_e__Struct
            GetQueueInfo : this._GetQueueInfo_e__Struct
            GetGroupList : this._GetGroupList_e__Struct
        }
        struct _SetAgentGroup_e__Struct {
            dwAddressID : UInt32
            GroupList : LINEAGENTGROUPLIST
        }
        struct _SetAgentState_e__Struct {
            dwAddressID : UInt32
            dwAgentState : UInt32
            dwNextAgentState : UInt32
        }
        struct _SetAgentActivity_e__Struct {
            dwAddressID : UInt32
            dwActivityID : UInt32
        }
        struct _GetAgentCaps_e__Struct {
            dwAddressID : UInt32
            AgentCaps : LINEAGENTCAPS
        }
        struct _GetAgentStatus_e__Struct {
            dwAddressID : UInt32
            AgentStatus : LINEAGENTSTATUS
        }
        struct _AgentSpecific_e__Struct {
            dwAddressID : UInt32
            dwAgentExtensionIDIndex : UInt32
            dwSize : UInt32
            Params : UInt8[1]
        }
        struct _GetAgentActivityList_e__Struct {
            dwAddressID : UInt32
            ActivityList : LINEAGENTACTIVITYLIST
        }
        struct _GetAgentGroupList_e__Struct {
            dwAddressID : UInt32
            GroupList : LINEAGENTGROUPLIST
        }
        struct _CreateAgent_e__Struct {
            hAgent : UInt32
            dwAgentIDSize : UInt32
            dwAgentIDOffset : UInt32
            dwAgentPINSize : UInt32
            dwAgentPINOffset : UInt32
        }
        struct _SetAgentStateEx_e__Struct {
            hAgent : UInt32
            dwAgentState : UInt32
            dwNextAgentState : UInt32
        }
        struct _SetAgentMeasurementPeriod_e__Struct {
            hAgent : UInt32
            dwMeasurementPeriod : UInt32
        }
        struct _GetAgentInfo_e__Struct {
            hAgent : UInt32
            AgentInfo : LINEAGENTINFO
        }
        struct _CreateAgentSession_e__Struct {
            hAgentSession : UInt32
            dwAgentPINSize : UInt32
            dwAgentPINOffset : UInt32
            hAgent : UInt32
            GroupID : GUID
            dwWorkingAddressID : UInt32
        }
        struct _GetAgentSessionList_e__Struct {
            hAgent : UInt32
            SessionList : LINEAGENTSESSIONLIST
        }
        struct _GetAgentSessionInfo_e__Struct {
            hAgentSession : UInt32
            SessionInfo : LINEAGENTSESSIONINFO
        }
        struct _SetAgentSessionState_e__Struct {
            hAgentSession : UInt32
            dwAgentSessionState : UInt32
            dwNextAgentSessionState : UInt32
        }
        struct _GetQueueList_e__Struct {
            GroupID : GUID
            QueueList : LINEQUEUELIST
        }
        struct _SetQueueMeasurementPeriod_e__Struct {
            dwQueueID : UInt32
            dwMeasurementPeriod : UInt32
        }
        struct _GetQueueInfo_e__Struct {
            dwQueueID : UInt32
            QueueInfo : LINEQUEUEINFO
        }
        struct _GetGroupList_e__Struct {
            GroupList : LINEAGENTGROUPLIST
        }
    }
}
struct LINEREQMAKECALL {
    szDestAddress : CHAR[80]
    szAppName : CHAR[40]
    szCalledParty : CHAR[40]
    szComment : CHAR[80]
}
struct LINEREQMAKECALLW {
    szDestAddress : UInt16[80]
    szAppName : UInt16[40]
    szCalledParty : UInt16[40]
    szComment : UInt16[80]
}
struct LINEREQMEDIACALL {
    hWnd : HWND
    wRequestID : WPARAM
    szDeviceClass : CHAR[40]
    ucDeviceID : UInt8[40]
    dwSize : UInt32
    dwSecure : UInt32
    szDestAddress : CHAR[80]
    szAppName : CHAR[40]
    szCalledParty : CHAR[40]
    szComment : CHAR[80]
}
struct LINEREQMEDIACALLW {
    hWnd : HWND
    wRequestID : WPARAM
    szDeviceClass : UInt16[40]
    ucDeviceID : UInt8[40]
    dwSize : UInt32
    dwSecure : UInt32
    szDestAddress : UInt16[80]
    szAppName : UInt16[40]
    szCalledParty : UInt16[40]
    szComment : UInt16[80]
}
struct LINETERMCAPS {
    dwTermDev : UInt32
    dwTermModes : UInt32
    dwTermSharing : UInt32
}
struct LINETRANSLATECAPS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwNumLocations : UInt32
    dwLocationListSize : UInt32
    dwLocationListOffset : UInt32
    dwCurrentLocationID : UInt32
    dwNumCards : UInt32
    dwCardListSize : UInt32
    dwCardListOffset : UInt32
    dwCurrentPreferredCardID : UInt32
}
struct LINETRANSLATEOUTPUT {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwDialableStringSize : UInt32
    dwDialableStringOffset : UInt32
    dwDisplayableStringSize : UInt32
    dwDisplayableStringOffset : UInt32
    dwCurrentCountry : UInt32
    dwDestCountry : UInt32
    dwTranslateResults : UInt32
}
struct PHONEBUTTONINFO {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwButtonMode : UInt32
    dwButtonFunction : UInt32
    dwButtonTextSize : UInt32
    dwButtonTextOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwButtonState : UInt32
}
struct PHONECAPS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwProviderInfoSize : UInt32
    dwProviderInfoOffset : UInt32
    dwPhoneInfoSize : UInt32
    dwPhoneInfoOffset : UInt32
    dwPermanentPhoneID : UInt32
    dwPhoneNameSize : UInt32
    dwPhoneNameOffset : UInt32
    dwStringFormat : UInt32
    dwPhoneStates : UInt32
    dwHookSwitchDevs : UInt32
    dwHandsetHookSwitchModes : UInt32
    dwSpeakerHookSwitchModes : UInt32
    dwHeadsetHookSwitchModes : UInt32
    dwVolumeFlags : UInt32
    dwGainFlags : UInt32
    dwDisplayNumRows : UInt32
    dwDisplayNumColumns : UInt32
    dwNumRingModes : UInt32
    dwNumButtonLamps : UInt32
    dwButtonModesSize : UInt32
    dwButtonModesOffset : UInt32
    dwButtonFunctionsSize : UInt32
    dwButtonFunctionsOffset : UInt32
    dwLampModesSize : UInt32
    dwLampModesOffset : UInt32
    dwNumSetData : UInt32
    dwSetDataSize : UInt32
    dwSetDataOffset : UInt32
    dwNumGetData : UInt32
    dwGetDataSize : UInt32
    dwGetDataOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwDeviceClassesSize : UInt32
    dwDeviceClassesOffset : UInt32
    dwPhoneFeatures : UInt32
    dwSettableHandsetHookSwitchModes : UInt32
    dwSettableSpeakerHookSwitchModes : UInt32
    dwSettableHeadsetHookSwitchModes : UInt32
    dwMonitoredHandsetHookSwitchModes : UInt32
    dwMonitoredSpeakerHookSwitchModes : UInt32
    dwMonitoredHeadsetHookSwitchModes : UInt32
    PermanentPhoneGuid : GUID
}
struct PHONEEXTENSIONID {
    dwExtensionID0 : UInt32
    dwExtensionID1 : UInt32
    dwExtensionID2 : UInt32
    dwExtensionID3 : UInt32
}
struct PHONEINITIALIZEEXPARAMS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwOptions : UInt32
    Handles : this._Handles_e__Union
    dwCompletionKey : UInt32
    struct _Handles_e__Union {
        union {
            hEvent : HANDLE
            hCompletionPort : HANDLE
        }
    }
}
struct PHONEMESSAGE {
    hDevice : UInt32
    dwMessageID : UInt32
    dwCallbackInstance : IntPtr
    dwParam1 : IntPtr
    dwParam2 : IntPtr
    dwParam3 : IntPtr
}
struct PHONESTATUS {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwStatusFlags : UInt32
    dwNumOwners : UInt32
    dwNumMonitors : UInt32
    dwRingMode : UInt32
    dwRingVolume : UInt32
    dwHandsetHookSwitchMode : UInt32
    dwHandsetVolume : UInt32
    dwHandsetGain : UInt32
    dwSpeakerHookSwitchMode : UInt32
    dwSpeakerVolume : UInt32
    dwSpeakerGain : UInt32
    dwHeadsetHookSwitchMode : UInt32
    dwHeadsetVolume : UInt32
    dwHeadsetGain : UInt32
    dwDisplaySize : UInt32
    dwDisplayOffset : UInt32
    dwLampModesSize : UInt32
    dwLampModesOffset : UInt32
    dwOwnerNameSize : UInt32
    dwOwnerNameOffset : UInt32
    dwDevSpecificSize : UInt32
    dwDevSpecificOffset : UInt32
    dwPhoneFeatures : UInt32
}
struct VARSTRING {
    dwTotalSize : UInt32
    dwNeededSize : UInt32
    dwUsedSize : UInt32
    dwStringFormat : UInt32
    dwStringSize : UInt32
    dwStringOffset : UInt32
}
struct ASYNC_COMPLETION extends FunctionPointer {
    static Types := [UInt32, Int32, "Void"]
}
struct LINEEVENT extends FunctionPointer {
    static Types := [HTAPILINE, HTAPICALL, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct PHONEEVENT extends FunctionPointer {
    static Types := [HTAPIPHONE, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct TUISPIDLLCALLBACK extends FunctionPointer {
    static Types := [IntPtr, UInt32, Struct.Ptr, UInt32, Int32]
}
struct TUISPICREATEDIALOGINSTANCEPARAMS {
    dwRequestID : UInt32
    hdDlgInst : HDRVDIALOGINSTANCE
    htDlgInst : UInt32
    lpszUIDLLName : PWSTR
    lpParams : Struct.Ptr
    dwSize : UInt32
}
struct TAPI_TONEMODE extends Int32 {
    static TTM_RINGBACK := 2
    static TTM_BUSY := 4
    static TTM_BEEP := 8
    static TTM_BILLING := 16
}
struct TAPI_GATHERTERM extends Int32 {
    static TGT_BUFFERFULL := 1
    static TGT_TERMDIGIT := 2
    static TGT_FIRSTTIMEOUT := 4
    static TGT_INTERTIMEOUT := 8
    static TGT_CANCEL := 16
}
struct TAPI_CUSTOMTONE {
    dwFrequency : UInt32
    dwCadenceOn : UInt32
    dwCadenceOff : UInt32
    dwVolume : UInt32
}
struct TAPI_DETECTTONE {
    dwAppSpecific : UInt32
    dwDuration : UInt32
    dwFrequency1 : UInt32
    dwFrequency2 : UInt32
    dwFrequency3 : UInt32
}
struct ADDRESS_EVENT extends Int32 {
    static AE_STATE := 0
    static AE_CAPSCHANGE := 1
    static AE_RINGING := 2
    static AE_CONFIGCHANGE := 3
    static AE_FORWARD := 4
    static AE_NEWTERMINAL := 5
    static AE_REMOVETERMINAL := 6
    static AE_MSGWAITON := 7
    static AE_MSGWAITOFF := 8
    static AE_LASTITEM := 8
}
struct ADDRESS_STATE extends Int32 {
    static AS_INSERVICE := 0
    static AS_OUTOFSERVICE := 1
}
struct CALL_STATE extends Int32 {
    static CS_IDLE := 0
    static CS_INPROGRESS := 1
    static CS_CONNECTED := 2
    static CS_DISCONNECTED := 3
    static CS_OFFERING := 4
    static CS_HOLD := 5
    static CS_QUEUED := 6
    static CS_LASTITEM := 6
}
struct CALL_STATE_EVENT_CAUSE extends Int32 {
    static CEC_NONE := 0
    static CEC_DISCONNECT_NORMAL := 1
    static CEC_DISCONNECT_BUSY := 2
    static CEC_DISCONNECT_BADADDRESS := 3
    static CEC_DISCONNECT_NOANSWER := 4
    static CEC_DISCONNECT_CANCELLED := 5
    static CEC_DISCONNECT_REJECTED := 6
    static CEC_DISCONNECT_FAILED := 7
    static CEC_DISCONNECT_BLOCKED := 8
}
struct CALL_MEDIA_EVENT extends Int32 {
    static CME_NEW_STREAM := 0
    static CME_STREAM_FAIL := 1
    static CME_TERMINAL_FAIL := 2
    static CME_STREAM_NOT_USED := 3
    static CME_STREAM_ACTIVE := 4
    static CME_STREAM_INACTIVE := 5
    static CME_LASTITEM := 5
}
struct CALL_MEDIA_EVENT_CAUSE extends Int32 {
    static CMC_UNKNOWN := 0
    static CMC_BAD_DEVICE := 1
    static CMC_CONNECT_FAIL := 2
    static CMC_LOCAL_REQUEST := 3
    static CMC_REMOTE_REQUEST := 4
    static CMC_MEDIA_TIMEOUT := 5
    static CMC_MEDIA_RECOVERED := 6
    static CMC_QUALITY_OF_SERVICE := 7
}
struct DISCONNECT_CODE extends Int32 {
    static DC_NORMAL := 0
    static DC_NOANSWER := 1
    static DC_REJECTED := 2
}
struct TERMINAL_STATE extends Int32 {
    static TS_INUSE := 0
    static TS_NOTINUSE := 1
}
struct TERMINAL_DIRECTION extends Int32 {
    static TD_CAPTURE := 0
    static TD_RENDER := 1
    static TD_BIDIRECTIONAL := 2
    static TD_MULTITRACK_MIXED := 3
    static TD_NONE := 4
}
struct TERMINAL_TYPE extends Int32 {
    static TT_STATIC := 0
    static TT_DYNAMIC := 1
}
struct CALL_PRIVILEGE extends Int32 {
    static CP_OWNER := 0
    static CP_MONITOR := 1
}
struct TAPI_EVENT extends Int32 {
    static TE_TAPIOBJECT := 1
    static TE_ADDRESS := 2
    static TE_CALLNOTIFICATION := 4
    static TE_CALLSTATE := 8
    static TE_CALLMEDIA := 16
    static TE_CALLHUB := 32
    static TE_CALLINFOCHANGE := 64
    static TE_PRIVATE := 128
    static TE_REQUEST := 256
    static TE_AGENT := 512
    static TE_AGENTSESSION := 1024
    static TE_QOSEVENT := 2048
    static TE_AGENTHANDLER := 4096
    static TE_ACDGROUP := 8192
    static TE_QUEUE := 16384
    static TE_DIGITEVENT := 32768
    static TE_GENERATEEVENT := 65536
    static TE_ASRTERMINAL := 131072
    static TE_TTSTERMINAL := 262144
    static TE_FILETERMINAL := 524288
    static TE_TONETERMINAL := 1048576
    static TE_PHONEEVENT := 2097152
    static TE_TONEEVENT := 4194304
    static TE_GATHERDIGITS := 8388608
    static TE_ADDRESSDEVSPECIFIC := 16777216
    static TE_PHONEDEVSPECIFIC := 33554432
}
struct CALL_NOTIFICATION_EVENT extends Int32 {
    static CNE_OWNER := 0
    static CNE_MONITOR := 1
    static CNE_LASTITEM := 1
}
struct CALLHUB_EVENT extends Int32 {
    static CHE_CALLJOIN := 0
    static CHE_CALLLEAVE := 1
    static CHE_CALLHUBNEW := 2
    static CHE_CALLHUBIDLE := 3
    static CHE_LASTITEM := 3
}
struct CALLHUB_STATE extends Int32 {
    static CHS_ACTIVE := 0
    static CHS_IDLE := 1
}
struct TAPIOBJECT_EVENT extends Int32 {
    static TE_ADDRESSCREATE := 0
    static TE_ADDRESSREMOVE := 1
    static TE_REINIT := 2
    static TE_TRANSLATECHANGE := 3
    static TE_ADDRESSCLOSE := 4
    static TE_PHONECREATE := 5
    static TE_PHONEREMOVE := 6
}
struct TAPI_OBJECT_TYPE extends Int32 {
    static TOT_NONE := 0
    static TOT_TAPI := 1
    static TOT_ADDRESS := 2
    static TOT_TERMINAL := 3
    static TOT_CALL := 4
    static TOT_CALLHUB := 5
    static TOT_PHONE := 6
}
struct QOS_SERVICE_LEVEL extends Int32 {
    static QSL_NEEDED := 1
    static QSL_IF_AVAILABLE := 2
    static QSL_BEST_EFFORT := 3
}
struct QOS_EVENT extends Int32 {
    static QE_NOQOS := 1
    static QE_ADMISSIONFAILURE := 2
    static QE_POLICYFAILURE := 3
    static QE_GENERICERROR := 4
    static QE_LASTITEM := 4
}
struct CALLINFOCHANGE_CAUSE extends Int32 {
    static CIC_OTHER := 0
    static CIC_DEVSPECIFIC := 1
    static CIC_BEARERMODE := 2
    static CIC_RATE := 3
    static CIC_APPSPECIFIC := 4
    static CIC_CALLID := 5
    static CIC_RELATEDCALLID := 6
    static CIC_ORIGIN := 7
    static CIC_REASON := 8
    static CIC_COMPLETIONID := 9
    static CIC_NUMOWNERINCR := 10
    static CIC_NUMOWNERDECR := 11
    static CIC_NUMMONITORS := 12
    static CIC_TRUNK := 13
    static CIC_CALLERID := 14
    static CIC_CALLEDID := 15
    static CIC_CONNECTEDID := 16
    static CIC_REDIRECTIONID := 17
    static CIC_REDIRECTINGID := 18
    static CIC_USERUSERINFO := 19
    static CIC_HIGHLEVELCOMP := 20
    static CIC_LOWLEVELCOMP := 21
    static CIC_CHARGINGINFO := 22
    static CIC_TREATMENT := 23
    static CIC_CALLDATA := 24
    static CIC_PRIVILEGE := 25
    static CIC_MEDIATYPE := 26
    static CIC_LASTITEM := 26
}
struct CALLINFO_LONG extends Int32 {
    static CIL_MEDIATYPESAVAILABLE := 0
    static CIL_BEARERMODE := 1
    static CIL_CALLERIDADDRESSTYPE := 2
    static CIL_CALLEDIDADDRESSTYPE := 3
    static CIL_CONNECTEDIDADDRESSTYPE := 4
    static CIL_REDIRECTIONIDADDRESSTYPE := 5
    static CIL_REDIRECTINGIDADDRESSTYPE := 6
    static CIL_ORIGIN := 7
    static CIL_REASON := 8
    static CIL_APPSPECIFIC := 9
    static CIL_CALLPARAMSFLAGS := 10
    static CIL_CALLTREATMENT := 11
    static CIL_MINRATE := 12
    static CIL_MAXRATE := 13
    static CIL_COUNTRYCODE := 14
    static CIL_CALLID := 15
    static CIL_RELATEDCALLID := 16
    static CIL_COMPLETIONID := 17
    static CIL_NUMBEROFOWNERS := 18
    static CIL_NUMBEROFMONITORS := 19
    static CIL_TRUNK := 20
    static CIL_RATE := 21
    static CIL_GENERATEDIGITDURATION := 22
    static CIL_MONITORDIGITMODES := 23
    static CIL_MONITORMEDIAMODES := 24
}
struct CALLINFO_STRING extends Int32 {
    static CIS_CALLERIDNAME := 0
    static CIS_CALLERIDNUMBER := 1
    static CIS_CALLEDIDNAME := 2
    static CIS_CALLEDIDNUMBER := 3
    static CIS_CONNECTEDIDNAME := 4
    static CIS_CONNECTEDIDNUMBER := 5
    static CIS_REDIRECTIONIDNAME := 6
    static CIS_REDIRECTIONIDNUMBER := 7
    static CIS_REDIRECTINGIDNAME := 8
    static CIS_REDIRECTINGIDNUMBER := 9
    static CIS_CALLEDPARTYFRIENDLYNAME := 10
    static CIS_COMMENT := 11
    static CIS_DISPLAYABLEADDRESS := 12
    static CIS_CALLINGPARTYID := 13
}
struct CALLINFO_BUFFER extends Int32 {
    static CIB_USERUSERINFO := 0
    static CIB_DEVSPECIFICBUFFER := 1
    static CIB_CALLDATABUFFER := 2
    static CIB_CHARGINGINFOBUFFER := 3
    static CIB_HIGHLEVELCOMPATIBILITYBUFFER := 4
    static CIB_LOWLEVELCOMPATIBILITYBUFFER := 5
}
struct ADDRESS_CAPABILITY extends Int32 {
    static AC_ADDRESSTYPES := 0
    static AC_BEARERMODES := 1
    static AC_MAXACTIVECALLS := 2
    static AC_MAXONHOLDCALLS := 3
    static AC_MAXONHOLDPENDINGCALLS := 4
    static AC_MAXNUMCONFERENCE := 5
    static AC_MAXNUMTRANSCONF := 6
    static AC_MONITORDIGITSUPPORT := 7
    static AC_GENERATEDIGITSUPPORT := 8
    static AC_GENERATETONEMODES := 9
    static AC_GENERATETONEMAXNUMFREQ := 10
    static AC_MONITORTONEMAXNUMFREQ := 11
    static AC_MONITORTONEMAXNUMENTRIES := 12
    static AC_DEVCAPFLAGS := 13
    static AC_ANSWERMODES := 14
    static AC_LINEFEATURES := 15
    static AC_SETTABLEDEVSTATUS := 16
    static AC_PARKSUPPORT := 17
    static AC_CALLERIDSUPPORT := 18
    static AC_CALLEDIDSUPPORT := 19
    static AC_CONNECTEDIDSUPPORT := 20
    static AC_REDIRECTIONIDSUPPORT := 21
    static AC_REDIRECTINGIDSUPPORT := 22
    static AC_ADDRESSCAPFLAGS := 23
    static AC_CALLFEATURES1 := 24
    static AC_CALLFEATURES2 := 25
    static AC_REMOVEFROMCONFCAPS := 26
    static AC_REMOVEFROMCONFSTATE := 27
    static AC_TRANSFERMODES := 28
    static AC_ADDRESSFEATURES := 29
    static AC_PREDICTIVEAUTOTRANSFERSTATES := 30
    static AC_MAXCALLDATASIZE := 31
    static AC_LINEID := 32
    static AC_ADDRESSID := 33
    static AC_FORWARDMODES := 34
    static AC_MAXFORWARDENTRIES := 35
    static AC_MAXSPECIFICENTRIES := 36
    static AC_MINFWDNUMRINGS := 37
    static AC_MAXFWDNUMRINGS := 38
    static AC_MAXCALLCOMPLETIONS := 39
    static AC_CALLCOMPLETIONCONDITIONS := 40
    static AC_CALLCOMPLETIONMODES := 41
    static AC_PERMANENTDEVICEID := 42
    static AC_GATHERDIGITSMINTIMEOUT := 43
    static AC_GATHERDIGITSMAXTIMEOUT := 44
    static AC_GENERATEDIGITMINDURATION := 45
    static AC_GENERATEDIGITMAXDURATION := 46
    static AC_GENERATEDIGITDEFAULTDURATION := 47
}
struct ADDRESS_CAPABILITY_STRING extends Int32 {
    static ACS_PROTOCOL := 0
    static ACS_ADDRESSDEVICESPECIFIC := 1
    static ACS_LINEDEVICESPECIFIC := 2
    static ACS_PROVIDERSPECIFIC := 3
    static ACS_SWITCHSPECIFIC := 4
    static ACS_PERMANENTDEVICEGUID := 5
}
struct FULLDUPLEX_SUPPORT extends Int32 {
    static FDS_SUPPORTED := 0
    static FDS_NOTSUPPORTED := 1
    static FDS_UNKNOWN := 2
}
struct FINISH_MODE extends Int32 {
    static FM_ASTRANSFER := 0
    static FM_ASCONFERENCE := 1
}
struct PHONE_PRIVILEGE extends Int32 {
    static PP_OWNER := 0
    static PP_MONITOR := 1
}
struct PHONE_HOOK_SWITCH_DEVICE extends Int32 {
    static PHSD_HANDSET := 1
    static PHSD_SPEAKERPHONE := 2
    static PHSD_HEADSET := 4
}
struct PHONE_HOOK_SWITCH_STATE extends Int32 {
    static PHSS_ONHOOK := 1
    static PHSS_OFFHOOK_MIC_ONLY := 2
    static PHSS_OFFHOOK_SPEAKER_ONLY := 4
    static PHSS_OFFHOOK := 8
}
struct PHONE_LAMP_MODE extends Int32 {
    static LM_DUMMY := 1
    static LM_OFF := 2
    static LM_STEADY := 4
    static LM_WINK := 8
    static LM_FLASH := 16
    static LM_FLUTTER := 32
    static LM_BROKENFLUTTER := 64
    static LM_UNKNOWN := 128
}
struct PHONECAPS_LONG extends Int32 {
    static PCL_HOOKSWITCHES := 0
    static PCL_HANDSETHOOKSWITCHMODES := 1
    static PCL_HEADSETHOOKSWITCHMODES := 2
    static PCL_SPEAKERPHONEHOOKSWITCHMODES := 3
    static PCL_DISPLAYNUMROWS := 4
    static PCL_DISPLAYNUMCOLUMNS := 5
    static PCL_NUMRINGMODES := 6
    static PCL_NUMBUTTONLAMPS := 7
    static PCL_GENERICPHONE := 8
}
struct PHONECAPS_STRING extends Int32 {
    static PCS_PHONENAME := 0
    static PCS_PHONEINFO := 1
    static PCS_PROVIDERINFO := 2
}
struct PHONECAPS_BUFFER extends Int32 {
    static PCB_DEVSPECIFICBUFFER := 0
}
struct PHONE_BUTTON_STATE extends Int32 {
    static PBS_UP := 1
    static PBS_DOWN := 2
    static PBS_UNKNOWN := 4
    static PBS_UNAVAIL := 8
}
struct PHONE_BUTTON_MODE extends Int32 {
    static PBM_DUMMY := 0
    static PBM_CALL := 1
    static PBM_FEATURE := 2
    static PBM_KEYPAD := 3
    static PBM_LOCAL := 4
    static PBM_DISPLAY := 5
}
struct PHONE_BUTTON_FUNCTION extends Int32 {
    static PBF_UNKNOWN := 0
    static PBF_CONFERENCE := 1
    static PBF_TRANSFER := 2
    static PBF_DROP := 3
    static PBF_HOLD := 4
    static PBF_RECALL := 5
    static PBF_DISCONNECT := 6
    static PBF_CONNECT := 7
    static PBF_MSGWAITON := 8
    static PBF_MSGWAITOFF := 9
    static PBF_SELECTRING := 10
    static PBF_ABBREVDIAL := 11
    static PBF_FORWARD := 12
    static PBF_PICKUP := 13
    static PBF_RINGAGAIN := 14
    static PBF_PARK := 15
    static PBF_REJECT := 16
    static PBF_REDIRECT := 17
    static PBF_MUTE := 18
    static PBF_VOLUMEUP := 19
    static PBF_VOLUMEDOWN := 20
    static PBF_SPEAKERON := 21
    static PBF_SPEAKEROFF := 22
    static PBF_FLASH := 23
    static PBF_DATAON := 24
    static PBF_DATAOFF := 25
    static PBF_DONOTDISTURB := 26
    static PBF_INTERCOM := 27
    static PBF_BRIDGEDAPP := 28
    static PBF_BUSY := 29
    static PBF_CALLAPP := 30
    static PBF_DATETIME := 31
    static PBF_DIRECTORY := 32
    static PBF_COVER := 33
    static PBF_CALLID := 34
    static PBF_LASTNUM := 35
    static PBF_NIGHTSRV := 36
    static PBF_SENDCALLS := 37
    static PBF_MSGINDICATOR := 38
    static PBF_REPDIAL := 39
    static PBF_SETREPDIAL := 40
    static PBF_SYSTEMSPEED := 41
    static PBF_STATIONSPEED := 42
    static PBF_CAMPON := 43
    static PBF_SAVEREPEAT := 44
    static PBF_QUEUECALL := 45
    static PBF_NONE := 46
    static PBF_SEND := 47
}
struct PHONE_TONE extends Int32 {
    static PT_KEYPADZERO := 0
    static PT_KEYPADONE := 1
    static PT_KEYPADTWO := 2
    static PT_KEYPADTHREE := 3
    static PT_KEYPADFOUR := 4
    static PT_KEYPADFIVE := 5
    static PT_KEYPADSIX := 6
    static PT_KEYPADSEVEN := 7
    static PT_KEYPADEIGHT := 8
    static PT_KEYPADNINE := 9
    static PT_KEYPADSTAR := 10
    static PT_KEYPADPOUND := 11
    static PT_KEYPADA := 12
    static PT_KEYPADB := 13
    static PT_KEYPADC := 14
    static PT_KEYPADD := 15
    static PT_NORMALDIALTONE := 16
    static PT_EXTERNALDIALTONE := 17
    static PT_BUSY := 18
    static PT_RINGBACK := 19
    static PT_ERRORTONE := 20
    static PT_SILENCE := 21
}
struct PHONE_EVENT extends Int32 {
    static PE_DISPLAY := 0
    static PE_LAMPMODE := 1
    static PE_RINGMODE := 2
    static PE_RINGVOLUME := 3
    static PE_HOOKSWITCH := 4
    static PE_CAPSCHANGE := 5
    static PE_BUTTON := 6
    static PE_CLOSE := 7
    static PE_NUMBERGATHERED := 8
    static PE_DIALING := 9
    static PE_ANSWER := 10
    static PE_DISCONNECT := 11
    static PE_LASTITEM := 11
}
struct ITTAPI extends IDispatch {
    static IID := "{B1EFC382-9355-11D0-835C-00AA003CCABD}"
    Initialize()
      => ComCall(7, this.p)
    Shutdown()
      => ComCall(8, this.p)
    get_Addresses(pVariant)
      => ComCall(9, this.p, VARIANT.Ptr, pVariant)
    EnumerateAddresses(ppEnumAddress)
      => ComCall(10, this.p, IEnumAddress.Ptr, ppEnumAddress)
    RegisterCallNotifications(pAddress, fMonitor, fOwner, lMediaTypes, lCallbackInstance, plRegister)
      => ComCall(11, this.p, ITAddress, pAddress, VARIANT_BOOL, fMonitor, VARIANT_BOOL, fOwner, Int32, lMediaTypes, Int32, lCallbackInstance, Int32.Ptr, plRegister)
    UnregisterNotifications(lRegister)
      => ComCall(12, this.p, Int32, lRegister)
    get_CallHubs(pVariant)
      => ComCall(13, this.p, VARIANT.Ptr, pVariant)
    EnumerateCallHubs(ppEnumCallHub)
      => ComCall(14, this.p, IEnumCallHub.Ptr, ppEnumCallHub)
    SetCallHubTracking(pAddresses, bTracking)
      => ComCall(15, this.p, VARIANT, pAddresses, VARIANT_BOOL, bTracking)
    EnumeratePrivateTAPIObjects(ppEnumUnknown)
      => ComCall(16, this.p, IEnumUnknown.Ptr, ppEnumUnknown)
    get_PrivateTAPIObjects(pVariant)
      => ComCall(17, this.p, VARIANT.Ptr, pVariant)
    RegisterRequestRecipient(lRegistrationInstance, lRequestMode, fEnable)
      => ComCall(18, this.p, Int32, lRegistrationInstance, Int32, lRequestMode, VARIANT_BOOL, fEnable)
    SetAssistedTelephonyPriority(pAppFilename, fPriority)
      => ComCall(19, this.p, BSTR, pAppFilename, VARIANT_BOOL, fPriority)
    SetApplicationPriority(pAppFilename, lMediaType, fPriority)
      => ComCall(20, this.p, BSTR, pAppFilename, Int32, lMediaType, VARIANT_BOOL, fPriority)
    put_EventFilter(lFilterMask)
      => ComCall(21, this.p, Int32, lFilterMask)
    get_EventFilter(plFilterMask)
      => ComCall(22, this.p, Int32.Ptr, plFilterMask)
}
struct ITTAPI2 extends ITTAPI {
    static IID := "{54FBDC8C-D90F-4DAD-9695-B373097F094B}"
    get_Phones(pPhones)
      => ComCall(23, this.p, VARIANT.Ptr, pPhones)
    EnumeratePhones(ppEnumPhone)
      => ComCall(24, this.p, IEnumPhone.Ptr, ppEnumPhone)
    CreateEmptyCollectionObject(ppCollection)
      => ComCall(25, this.p, ITCollection2.Ptr, ppCollection)
}
struct ITMediaSupport extends IDispatch {
    static IID := "{B1EFC384-9355-11D0-835C-00AA003CCABD}"
    get_MediaTypes(plMediaTypes)
      => ComCall(7, this.p, Int32.Ptr, plMediaTypes)
    QueryMediaType(lMediaType, pfSupport)
      => ComCall(8, this.p, Int32, lMediaType, VARIANT_BOOL.Ptr, pfSupport)
}
struct ITPluggableTerminalClassInfo extends IDispatch {
    static IID := "{41757F4A-CF09-4B34-BC96-0A79D2390076}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    get_Company(pCompany)
      => ComCall(8, this.p, BSTR.Ptr, pCompany)
    get_Version(pVersion)
      => ComCall(9, this.p, BSTR.Ptr, pVersion)
    get_TerminalClass(pTerminalClass)
      => ComCall(10, this.p, BSTR.Ptr, pTerminalClass)
    get_CLSID(pCLSID)
      => ComCall(11, this.p, BSTR.Ptr, pCLSID)
    get_Direction(pDirection)
      => ComCall(12, this.p, TERMINAL_DIRECTION.Ptr, pDirection)
    get_MediaTypes(pMediaTypes)
      => ComCall(13, this.p, Int32.Ptr, pMediaTypes)
}
struct ITPluggableTerminalSuperclassInfo extends IDispatch {
    static IID := "{6D54E42C-4625-4359-A6F7-631999107E05}"
    get_Name(pName)
      => ComCall(7, this.p, BSTR.Ptr, pName)
    get_CLSID(pCLSID)
      => ComCall(8, this.p, BSTR.Ptr, pCLSID)
}
struct ITTerminalSupport extends IDispatch {
    static IID := "{B1EFC385-9355-11D0-835C-00AA003CCABD}"
    get_StaticTerminals(pVariant)
      => ComCall(7, this.p, VARIANT.Ptr, pVariant)
    EnumerateStaticTerminals(ppTerminalEnumerator)
      => ComCall(8, this.p, IEnumTerminal.Ptr, ppTerminalEnumerator)
    get_DynamicTerminalClasses(pVariant)
      => ComCall(9, this.p, VARIANT.Ptr, pVariant)
    EnumerateDynamicTerminalClasses(ppTerminalClassEnumerator)
      => ComCall(10, this.p, IEnumTerminalClass.Ptr, ppTerminalClassEnumerator)
    CreateTerminal(pTerminalClass, lMediaType, Direction, ppTerminal)
      => ComCall(11, this.p, BSTR, pTerminalClass, Int32, lMediaType, TERMINAL_DIRECTION, Direction, ITTerminal.Ptr, ppTerminal)
    GetDefaultStaticTerminal(lMediaType, Direction, ppTerminal)
      => ComCall(12, this.p, Int32, lMediaType, TERMINAL_DIRECTION, Direction, ITTerminal.Ptr, ppTerminal)
}
struct ITTerminalSupport2 extends ITTerminalSupport {
    static IID := "{F3EB39BC-1B1F-4E99-A0C0-56305C4DD591}"
    get_PluggableSuperclasses(pVariant)
      => ComCall(13, this.p, VARIANT.Ptr, pVariant)
    EnumeratePluggableSuperclasses(ppSuperclassEnumerator)
      => ComCall(14, this.p, IEnumPluggableSuperclassInfo.Ptr, ppSuperclassEnumerator)
    get_PluggableTerminalClasses(bstrTerminalSuperclass, lMediaType, pVariant)
      => ComCall(15, this.p, BSTR, bstrTerminalSuperclass, Int32, lMediaType, VARIANT.Ptr, pVariant)
    EnumeratePluggableTerminalClasses(iidTerminalSuperclass, lMediaType, ppClassEnumerator)
      => ComCall(16, this.p, GUID, iidTerminalSuperclass, Int32, lMediaType, IEnumPluggableTerminalClassInfo.Ptr, ppClassEnumerator)
}
struct ITAddress extends IDispatch {
    static IID := "{B1EFC386-9355-11D0-835C-00AA003CCABD}"
    get_State(pAddressState)
      => ComCall(7, this.p, ADDRESS_STATE.Ptr, pAddressState)
    get_AddressName(ppName)
      => ComCall(8, this.p, BSTR.Ptr, ppName)
    get_ServiceProviderName(ppName)
      => ComCall(9, this.p, BSTR.Ptr, ppName)
    get_TAPIObject(ppTapiObject)
      => ComCall(10, this.p, ITTAPI.Ptr, ppTapiObject)
    CreateCall(pDestAddress, lAddressType, lMediaTypes, ppCall)
      => ComCall(11, this.p, BSTR, pDestAddress, Int32, lAddressType, Int32, lMediaTypes, ITBasicCallControl.Ptr, ppCall)
    get_Calls(pVariant)
      => ComCall(12, this.p, VARIANT.Ptr, pVariant)
    EnumerateCalls(ppCallEnum)
      => ComCall(13, this.p, IEnumCall.Ptr, ppCallEnum)
    get_DialableAddress(pDialableAddress)
      => ComCall(14, this.p, BSTR.Ptr, pDialableAddress)
    CreateForwardInfoObject(ppForwardInfo)
      => ComCall(15, this.p, ITForwardInformation.Ptr, ppForwardInfo)
    Forward(pForwardInfo, pCall)
      => ComCall(16, this.p, ITForwardInformation, pForwardInfo, ITBasicCallControl, pCall)
    get_CurrentForwardInfo(ppForwardInfo)
      => ComCall(17, this.p, ITForwardInformation.Ptr, ppForwardInfo)
    put_MessageWaiting(fMessageWaiting)
      => ComCall(18, this.p, VARIANT_BOOL, fMessageWaiting)
    get_MessageWaiting(pfMessageWaiting)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pfMessageWaiting)
    put_DoNotDisturb(fDoNotDisturb)
      => ComCall(20, this.p, VARIANT_BOOL, fDoNotDisturb)
    get_DoNotDisturb(pfDoNotDisturb)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pfDoNotDisturb)
}
struct ITAddress2 extends ITAddress {
    static IID := "{B0AE5D9B-BE51-46C9-B0F7-DFA8A22A8BC4}"
    get_Phones(pPhones)
      => ComCall(22, this.p, VARIANT.Ptr, pPhones)
    EnumeratePhones(ppEnumPhone)
      => ComCall(23, this.p, IEnumPhone.Ptr, ppEnumPhone)
    GetPhoneFromTerminal(pTerminal, ppPhone)
      => ComCall(24, this.p, ITTerminal, pTerminal, ITPhone.Ptr, ppPhone)
    get_PreferredPhones(pPhones)
      => ComCall(25, this.p, VARIANT.Ptr, pPhones)
    EnumeratePreferredPhones(ppEnumPhone)
      => ComCall(26, this.p, IEnumPhone.Ptr, ppEnumPhone)
    get_EventFilter(TapiEvent, lSubEvent, pEnable)
      => ComCall(27, this.p, TAPI_EVENT, TapiEvent, Int32, lSubEvent, VARIANT_BOOL.Ptr, pEnable)
    put_EventFilter(TapiEvent, lSubEvent, bEnable)
      => ComCall(28, this.p, TAPI_EVENT, TapiEvent, Int32, lSubEvent, VARIANT_BOOL, bEnable)
    DeviceSpecific(pCall, pParams, dwSize)
      => ComCall(29, this.p, ITCallInfo, pCall, UInt8.Ptr, pParams, UInt32, dwSize)
    DeviceSpecificVariant(pCall, varDevSpecificByteArray)
      => ComCall(30, this.p, ITCallInfo, pCall, VARIANT, varDevSpecificByteArray)
    NegotiateExtVersion(lLowVersion, lHighVersion, plExtVersion)
      => ComCall(31, this.p, Int32, lLowVersion, Int32, lHighVersion, Int32.Ptr, plExtVersion)
}
struct ITAddressCapabilities extends IDispatch {
    static IID := "{8DF232F5-821B-11D1-BB5C-00C04FB6809F}"
    get_AddressCapability(AddressCap, plCapability)
      => ComCall(7, this.p, ADDRESS_CAPABILITY, AddressCap, Int32.Ptr, plCapability)
    get_AddressCapabilityString(AddressCapString, ppCapabilityString)
      => ComCall(8, this.p, ADDRESS_CAPABILITY_STRING, AddressCapString, BSTR.Ptr, ppCapabilityString)
    get_CallTreatments(pVariant)
      => ComCall(9, this.p, VARIANT.Ptr, pVariant)
    EnumerateCallTreatments(ppEnumCallTreatment)
      => ComCall(10, this.p, IEnumBstr.Ptr, ppEnumCallTreatment)
    get_CompletionMessages(pVariant)
      => ComCall(11, this.p, VARIANT.Ptr, pVariant)
    EnumerateCompletionMessages(ppEnumCompletionMessage)
      => ComCall(12, this.p, IEnumBstr.Ptr, ppEnumCompletionMessage)
    get_DeviceClasses(pVariant)
      => ComCall(13, this.p, VARIANT.Ptr, pVariant)
    EnumerateDeviceClasses(ppEnumDeviceClass)
      => ComCall(14, this.p, IEnumBstr.Ptr, ppEnumDeviceClass)
}
struct ITPhone extends IDispatch {
    static IID := "{09D48DB4-10CC-4388-9DE7-A8465618975A}"
    Open(Privilege)
      => ComCall(7, this.p, PHONE_PRIVILEGE, Privilege)
    Close()
      => ComCall(8, this.p)
    get_Addresses(pAddresses)
      => ComCall(9, this.p, VARIANT.Ptr, pAddresses)
    EnumerateAddresses(ppEnumAddress)
      => ComCall(10, this.p, IEnumAddress.Ptr, ppEnumAddress)
    get_PhoneCapsLong(pclCap, plCapability)
      => ComCall(11, this.p, PHONECAPS_LONG, pclCap, Int32.Ptr, plCapability)
    get_PhoneCapsString(pcsCap, ppCapability)
      => ComCall(12, this.p, PHONECAPS_STRING, pcsCap, BSTR.Ptr, ppCapability)
    get_Terminals(pAddress, pTerminals)
      => ComCall(13, this.p, ITAddress, pAddress, VARIANT.Ptr, pTerminals)
    EnumerateTerminals(pAddress, ppEnumTerminal)
      => ComCall(14, this.p, ITAddress, pAddress, IEnumTerminal.Ptr, ppEnumTerminal)
    get_ButtonMode(lButtonID, pButtonMode)
      => ComCall(15, this.p, Int32, lButtonID, PHONE_BUTTON_MODE.Ptr, pButtonMode)
    put_ButtonMode(lButtonID, ButtonMode)
      => ComCall(16, this.p, Int32, lButtonID, PHONE_BUTTON_MODE, ButtonMode)
    get_ButtonFunction(lButtonID, pButtonFunction)
      => ComCall(17, this.p, Int32, lButtonID, PHONE_BUTTON_FUNCTION.Ptr, pButtonFunction)
    put_ButtonFunction(lButtonID, ButtonFunction)
      => ComCall(18, this.p, Int32, lButtonID, PHONE_BUTTON_FUNCTION, ButtonFunction)
    get_ButtonText(lButtonID, ppButtonText)
      => ComCall(19, this.p, Int32, lButtonID, BSTR.Ptr, ppButtonText)
    put_ButtonText(lButtonID, bstrButtonText)
      => ComCall(20, this.p, Int32, lButtonID, BSTR, bstrButtonText)
    get_ButtonState(lButtonID, pButtonState)
      => ComCall(21, this.p, Int32, lButtonID, PHONE_BUTTON_STATE.Ptr, pButtonState)
    get_HookSwitchState(HookSwitchDevice, pHookSwitchState)
      => ComCall(22, this.p, PHONE_HOOK_SWITCH_DEVICE, HookSwitchDevice, PHONE_HOOK_SWITCH_STATE.Ptr, pHookSwitchState)
    put_HookSwitchState(HookSwitchDevice, HookSwitchState)
      => ComCall(23, this.p, PHONE_HOOK_SWITCH_DEVICE, HookSwitchDevice, PHONE_HOOK_SWITCH_STATE, HookSwitchState)
    put_RingMode(lRingMode)
      => ComCall(24, this.p, Int32, lRingMode)
    get_RingMode(plRingMode)
      => ComCall(25, this.p, Int32.Ptr, plRingMode)
    put_RingVolume(lRingVolume)
      => ComCall(26, this.p, Int32, lRingVolume)
    get_RingVolume(plRingVolume)
      => ComCall(27, this.p, Int32.Ptr, plRingVolume)
    get_Privilege(pPrivilege)
      => ComCall(28, this.p, PHONE_PRIVILEGE.Ptr, pPrivilege)
    GetPhoneCapsBuffer(pcbCaps, pdwSize, ppPhoneCapsBuffer)
      => ComCall(29, this.p, PHONECAPS_BUFFER, pcbCaps, UInt32.Ptr, pdwSize, UInt8.Ptr.Ptr, ppPhoneCapsBuffer)
    get_PhoneCapsBuffer(pcbCaps, pVarBuffer)
      => ComCall(30, this.p, PHONECAPS_BUFFER, pcbCaps, VARIANT.Ptr, pVarBuffer)
    get_LampMode(lLampID, pLampMode)
      => ComCall(31, this.p, Int32, lLampID, PHONE_LAMP_MODE.Ptr, pLampMode)
    put_LampMode(lLampID, LampMode)
      => ComCall(32, this.p, Int32, lLampID, PHONE_LAMP_MODE, LampMode)
    get_Display(pbstrDisplay)
      => ComCall(33, this.p, BSTR.Ptr, pbstrDisplay)
    SetDisplay(lRow, lColumn, bstrDisplay)
      => ComCall(34, this.p, Int32, lRow, Int32, lColumn, BSTR, bstrDisplay)
    get_PreferredAddresses(pAddresses)
      => ComCall(35, this.p, VARIANT.Ptr, pAddresses)
    EnumeratePreferredAddresses(ppEnumAddress)
      => ComCall(36, this.p, IEnumAddress.Ptr, ppEnumAddress)
    DeviceSpecific(pParams, dwSize)
      => ComCall(37, this.p, UInt8.Ptr, pParams, UInt32, dwSize)
    DeviceSpecificVariant(varDevSpecificByteArray)
      => ComCall(38, this.p, VARIANT, varDevSpecificByteArray)
    NegotiateExtVersion(lLowVersion, lHighVersion, plExtVersion)
      => ComCall(39, this.p, Int32, lLowVersion, Int32, lHighVersion, Int32.Ptr, plExtVersion)
}
struct ITAutomatedPhoneControl extends IDispatch {
    static IID := "{1EE1AF0E-6159-4A61-B79B-6A4BA3FC9DFC}"
    StartTone(Tone, lDuration)
      => ComCall(7, this.p, PHONE_TONE, Tone, Int32, lDuration)
    StopTone()
      => ComCall(8, this.p)
    get_Tone(pTone)
      => ComCall(9, this.p, PHONE_TONE.Ptr, pTone)
    StartRinger(lRingMode, lDuration)
      => ComCall(10, this.p, Int32, lRingMode, Int32, lDuration)
    StopRinger()
      => ComCall(11, this.p)
    get_Ringer(pfRinging)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pfRinging)
    put_PhoneHandlingEnabled(fEnabled)
      => ComCall(13, this.p, VARIANT_BOOL, fEnabled)
    get_PhoneHandlingEnabled(pfEnabled)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_AutoEndOfNumberTimeout(lTimeout)
      => ComCall(15, this.p, Int32, lTimeout)
    get_AutoEndOfNumberTimeout(plTimeout)
      => ComCall(16, this.p, Int32.Ptr, plTimeout)
    put_AutoDialtone(fEnabled)
      => ComCall(17, this.p, VARIANT_BOOL, fEnabled)
    get_AutoDialtone(pfEnabled)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_AutoStopTonesOnOnHook(fEnabled)
      => ComCall(19, this.p, VARIANT_BOOL, fEnabled)
    get_AutoStopTonesOnOnHook(pfEnabled)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_AutoStopRingOnOffHook(fEnabled)
      => ComCall(21, this.p, VARIANT_BOOL, fEnabled)
    get_AutoStopRingOnOffHook(pfEnabled)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_AutoKeypadTones(fEnabled)
      => ComCall(23, this.p, VARIANT_BOOL, fEnabled)
    get_AutoKeypadTones(pfEnabled)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, pfEnabled)
    put_AutoKeypadTonesMinimumDuration(lDuration)
      => ComCall(25, this.p, Int32, lDuration)
    get_AutoKeypadTonesMinimumDuration(plDuration)
      => ComCall(26, this.p, Int32.Ptr, plDuration)
    put_AutoVolumeControl(fEnabled)
      => ComCall(27, this.p, VARIANT_BOOL, fEnabled)
    get_AutoVolumeControl(fEnabled)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, fEnabled)
    put_AutoVolumeControlStep(lStepSize)
      => ComCall(29, this.p, Int32, lStepSize)
    get_AutoVolumeControlStep(plStepSize)
      => ComCall(30, this.p, Int32.Ptr, plStepSize)
    put_AutoVolumeControlRepeatDelay(lDelay)
      => ComCall(31, this.p, Int32, lDelay)
    get_AutoVolumeControlRepeatDelay(plDelay)
      => ComCall(32, this.p, Int32.Ptr, plDelay)
    put_AutoVolumeControlRepeatPeriod(lPeriod)
      => ComCall(33, this.p, Int32, lPeriod)
    get_AutoVolumeControlRepeatPeriod(plPeriod)
      => ComCall(34, this.p, Int32.Ptr, plPeriod)
    SelectCall(pCall, fSelectDefaultTerminals)
      => ComCall(35, this.p, ITCallInfo, pCall, VARIANT_BOOL, fSelectDefaultTerminals)
    UnselectCall(pCall)
      => ComCall(36, this.p, ITCallInfo, pCall)
    EnumerateSelectedCalls(ppCallEnum)
      => ComCall(37, this.p, IEnumCall.Ptr, ppCallEnum)
    get_SelectedCalls(pVariant)
      => ComCall(38, this.p, VARIANT.Ptr, pVariant)
}
struct ITBasicCallControl extends IDispatch {
    static IID := "{B1EFC389-9355-11D0-835C-00AA003CCABD}"
    Connect(fSync)
      => ComCall(7, this.p, VARIANT_BOOL, fSync)
    Answer()
      => ComCall(8, this.p)
    Disconnect(code)
      => ComCall(9, this.p, DISCONNECT_CODE, code)
    Hold(fHold)
      => ComCall(10, this.p, VARIANT_BOOL, fHold)
    HandoffDirect(pApplicationName)
      => ComCall(11, this.p, BSTR, pApplicationName)
    HandoffIndirect(lMediaType)
      => ComCall(12, this.p, Int32, lMediaType)
    Conference(pCall, fSync)
      => ComCall(13, this.p, ITBasicCallControl, pCall, VARIANT_BOOL, fSync)
    Transfer(pCall, fSync)
      => ComCall(14, this.p, ITBasicCallControl, pCall, VARIANT_BOOL, fSync)
    BlindTransfer(pDestAddress)
      => ComCall(15, this.p, BSTR, pDestAddress)
    SwapHold(pCall)
      => ComCall(16, this.p, ITBasicCallControl, pCall)
    ParkDirect(pParkAddress)
      => ComCall(17, this.p, BSTR, pParkAddress)
    ParkIndirect(ppNonDirAddress)
      => ComCall(18, this.p, BSTR.Ptr, ppNonDirAddress)
    Unpark()
      => ComCall(19, this.p)
    SetQOS(lMediaType, ServiceLevel)
      => ComCall(20, this.p, Int32, lMediaType, QOS_SERVICE_LEVEL, ServiceLevel)
    Pickup(pGroupID)
      => ComCall(21, this.p, BSTR, pGroupID)
    Dial(pDestAddress)
      => ComCall(22, this.p, BSTR, pDestAddress)
    Finish(finishMode)
      => ComCall(23, this.p, FINISH_MODE, finishMode)
    RemoveFromConference()
      => ComCall(24, this.p)
}
struct ITCallInfo extends IDispatch {
    static IID := "{350F85D1-1227-11D3-83D4-00C04FB6809F}"
    get_Address(ppAddress)
      => ComCall(7, this.p, ITAddress.Ptr, ppAddress)
    get_CallState(pCallState)
      => ComCall(8, this.p, CALL_STATE.Ptr, pCallState)
    get_Privilege(pPrivilege)
      => ComCall(9, this.p, CALL_PRIVILEGE.Ptr, pPrivilege)
    get_CallHub(ppCallHub)
      => ComCall(10, this.p, ITCallHub.Ptr, ppCallHub)
    get_CallInfoLong(CallInfoLong, plCallInfoLongVal)
      => ComCall(11, this.p, CALLINFO_LONG, CallInfoLong, Int32.Ptr, plCallInfoLongVal)
    put_CallInfoLong(CallInfoLong, lCallInfoLongVal)
      => ComCall(12, this.p, CALLINFO_LONG, CallInfoLong, Int32, lCallInfoLongVal)
    get_CallInfoString(CallInfoString, ppCallInfoString)
      => ComCall(13, this.p, CALLINFO_STRING, CallInfoString, BSTR.Ptr, ppCallInfoString)
    put_CallInfoString(CallInfoString, pCallInfoString)
      => ComCall(14, this.p, CALLINFO_STRING, CallInfoString, BSTR, pCallInfoString)
    get_CallInfoBuffer(CallInfoBuffer, ppCallInfoBuffer)
      => ComCall(15, this.p, CALLINFO_BUFFER, CallInfoBuffer, VARIANT.Ptr, ppCallInfoBuffer)
    put_CallInfoBuffer(CallInfoBuffer, pCallInfoBuffer)
      => ComCall(16, this.p, CALLINFO_BUFFER, CallInfoBuffer, VARIANT, pCallInfoBuffer)
    GetCallInfoBuffer(CallInfoBuffer, ppCallInfoBuffer)
      => ComCall(17, this.p, CALLINFO_BUFFER, CallInfoBuffer, UInt32.Ptr, ppCallInfoBuffer.Length, UInt8.Ptr.Ptr, ppCallInfoBuffer)
    SetCallInfoBuffer(CallInfoBuffer, pCallInfoBuffer)
      => ComCall(18, this.p, CALLINFO_BUFFER, CallInfoBuffer, UInt32, pCallInfoBuffer.Length, UInt8.Ptr, pCallInfoBuffer)
    ReleaseUserUserInfo()
      => ComCall(19, this.p)
}
struct ITCallInfo2 extends ITCallInfo {
    static IID := "{94D70CA6-7AB0-4DAA-81CA-B8F8643FAEC1}"
    get_EventFilter(TapiEvent, lSubEvent, pEnable)
      => ComCall(20, this.p, TAPI_EVENT, TapiEvent, Int32, lSubEvent, VARIANT_BOOL.Ptr, pEnable)
    put_EventFilter(TapiEvent, lSubEvent, bEnable)
      => ComCall(21, this.p, TAPI_EVENT, TapiEvent, Int32, lSubEvent, VARIANT_BOOL, bEnable)
}
struct ITTerminal extends IDispatch {
    static IID := "{B1EFC38A-9355-11D0-835C-00AA003CCABD}"
    get_Name(ppName)
      => ComCall(7, this.p, BSTR.Ptr, ppName)
    get_State(pTerminalState)
      => ComCall(8, this.p, TERMINAL_STATE.Ptr, pTerminalState)
    get_TerminalType(pType)
      => ComCall(9, this.p, TERMINAL_TYPE.Ptr, pType)
    get_TerminalClass(ppTerminalClass)
      => ComCall(10, this.p, BSTR.Ptr, ppTerminalClass)
    get_MediaType(plMediaType)
      => ComCall(11, this.p, Int32.Ptr, plMediaType)
    get_Direction(pDirection)
      => ComCall(12, this.p, TERMINAL_DIRECTION.Ptr, pDirection)
}
struct ITMultiTrackTerminal extends IDispatch {
    static IID := "{FE040091-ADE8-4072-95C9-BF7DE8C54B44}"
    get_TrackTerminals(pVariant)
      => ComCall(7, this.p, VARIANT.Ptr, pVariant)
    EnumerateTrackTerminals(ppEnumTerminal)
      => ComCall(8, this.p, IEnumTerminal.Ptr, ppEnumTerminal)
    CreateTrackTerminal(MediaType, TerminalDirection, ppTerminal)
      => ComCall(9, this.p, Int32, MediaType, TERMINAL_DIRECTION, TerminalDirection, ITTerminal.Ptr, ppTerminal)
    get_MediaTypesInUse(plMediaTypesInUse)
      => ComCall(10, this.p, Int32.Ptr, plMediaTypesInUse)
    get_DirectionsInUse(plDirectionsInUsed)
      => ComCall(11, this.p, TERMINAL_DIRECTION.Ptr, plDirectionsInUsed)
    RemoveTrackTerminal(pTrackTerminalToRemove)
      => ComCall(12, this.p, ITTerminal, pTrackTerminalToRemove)
}
struct TERMINAL_MEDIA_STATE extends Int32 {
    static TMS_IDLE := 0
    static TMS_ACTIVE := 1
    static TMS_PAUSED := 2
    static TMS_LASTITEM := 2
}
struct FT_STATE_EVENT_CAUSE extends Int32 {
    static FTEC_NORMAL := 0
    static FTEC_END_OF_FILE := 1
    static FTEC_READ_ERROR := 2
    static FTEC_WRITE_ERROR := 3
}
struct ITFileTrack extends IDispatch {
    static IID := "{31CA6EA9-C08A-4BEA-8811-8E9C1BA3EA3A}"
    get_Format(ppmt)
      => ComCall(7, this.p, AM_MEDIA_TYPE.Ptr.Ptr, ppmt)
    put_Format(pmt)
      => ComCall(8, this.p, AM_MEDIA_TYPE.Ptr, pmt)
    get_ControllingTerminal(ppControllingTerminal)
      => ComCall(9, this.p, ITTerminal.Ptr, ppControllingTerminal)
    get_AudioFormatForScripting(ppAudioFormat)
      => ComCall(10, this.p, ITScriptableAudioFormat.Ptr, ppAudioFormat)
    put_AudioFormatForScripting(pAudioFormat)
      => ComCall(11, this.p, ITScriptableAudioFormat, pAudioFormat)
    get_EmptyAudioFormatForScripting(ppAudioFormat)
      => ComCall(12, this.p, ITScriptableAudioFormat.Ptr, ppAudioFormat)
}
struct ITMediaPlayback extends IDispatch {
    static IID := "{627E8AE6-AE4C-4A69-BB63-2AD625404B77}"
    put_PlayList(PlayListVariant)
      => ComCall(7, this.p, VARIANT, PlayListVariant)
    get_PlayList(pPlayListVariant)
      => ComCall(8, this.p, VARIANT.Ptr, pPlayListVariant)
}
struct ITMediaRecord extends IDispatch {
    static IID := "{F5DD4592-5476-4CC1-9D4D-FAD3EEFE7DB2}"
    put_FileName(bstrFileName)
      => ComCall(7, this.p, BSTR, bstrFileName)
    get_FileName(pbstrFileName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrFileName)
}
struct ITMediaControl extends IDispatch {
    static IID := "{C445DDE8-5199-4BC7-9807-5FFB92E42E09}"
    Start()
      => ComCall(7, this.p)
    Stop()
      => ComCall(8, this.p)
    Pause()
      => ComCall(9, this.p)
    get_MediaState(pTerminalMediaState)
      => ComCall(10, this.p, TERMINAL_MEDIA_STATE.Ptr, pTerminalMediaState)
}
struct ITBasicAudioTerminal extends IDispatch {
    static IID := "{B1EFC38D-9355-11D0-835C-00AA003CCABD}"
    put_Volume(lVolume)
      => ComCall(7, this.p, Int32, lVolume)
    get_Volume(plVolume)
      => ComCall(8, this.p, Int32.Ptr, plVolume)
    put_Balance(lBalance)
      => ComCall(9, this.p, Int32, lBalance)
    get_Balance(plBalance)
      => ComCall(10, this.p, Int32.Ptr, plBalance)
}
struct ITStaticAudioTerminal extends IDispatch {
    static IID := "{A86B7871-D14C-48E6-922E-A8D15F984800}"
    get_WaveId(plWaveId)
      => ComCall(7, this.p, Int32.Ptr, plWaveId)
}
struct ITCallHub extends IDispatch {
    static IID := "{A3C1544E-5B92-11D1-8F4E-00C04FB6809F}"
    Clear()
      => ComCall(7, this.p)
    EnumerateCalls(ppEnumCall)
      => ComCall(8, this.p, IEnumCall.Ptr, ppEnumCall)
    get_Calls(pCalls)
      => ComCall(9, this.p, VARIANT.Ptr, pCalls)
    get_NumCalls(plCalls)
      => ComCall(10, this.p, Int32.Ptr, plCalls)
    get_State(pState)
      => ComCall(11, this.p, CALLHUB_STATE.Ptr, pState)
}
struct ITLegacyAddressMediaControl extends IUnknown {
    static IID := "{AB493640-4C0B-11D2-A046-00C04FB6809F}"
    GetID(pDeviceClass, ppDeviceID)
      => ComCall(3, this.p, BSTR, pDeviceClass, UInt32.Ptr, ppDeviceID.Length, UInt8.Ptr.Ptr, ppDeviceID)
    GetDevConfig(pDeviceClass, ppDeviceConfig)
      => ComCall(4, this.p, BSTR, pDeviceClass, UInt32.Ptr, ppDeviceConfig.Length, UInt8.Ptr.Ptr, ppDeviceConfig)
    SetDevConfig(pDeviceClass, pDeviceConfig)
      => ComCall(5, this.p, BSTR, pDeviceClass, UInt32, pDeviceConfig.Length, UInt8.Ptr, pDeviceConfig)
}
struct ITPrivateEvent extends IDispatch {
    static IID := "{0E269CD0-10D4-4121-9C22-9C85D625650D}"
    get_Address(ppAddress)
      => ComCall(7, this.p, ITAddress.Ptr, ppAddress)
    get_Call(ppCallInfo)
      => ComCall(8, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_CallHub(ppCallHub)
      => ComCall(9, this.p, ITCallHub.Ptr, ppCallHub)
    get_EventCode(plEventCode)
      => ComCall(10, this.p, Int32.Ptr, plEventCode)
    get_EventInterface(pEventInterface)
      => ComCall(11, this.p, IDispatch.Ptr, pEventInterface)
}
struct ITLegacyAddressMediaControl2 extends ITLegacyAddressMediaControl {
    static IID := "{B0EE512B-A531-409E-9DD9-4099FE86C738}"
    ConfigDialog(hwndOwner, pDeviceClass)
      => ComCall(6, this.p, HWND, hwndOwner, BSTR, pDeviceClass)
    ConfigDialogEdit(hwndOwner, pDeviceClass, pDeviceConfigIn, ppDeviceConfigOut)
      => ComCall(7, this.p, HWND, hwndOwner, BSTR, pDeviceClass, UInt32, pDeviceConfigIn.Length, UInt8.Ptr, pDeviceConfigIn, UInt32.Ptr, ppDeviceConfigOut.Length, UInt8.Ptr.Ptr, ppDeviceConfigOut)
}
struct ITLegacyCallMediaControl extends IDispatch {
    static IID := "{D624582F-CC23-4436-B8A5-47C625C8045D}"
    DetectDigits(DigitMode)
      => ComCall(7, this.p, Int32, DigitMode)
    GenerateDigits(pDigits, DigitMode)
      => ComCall(8, this.p, BSTR, pDigits, Int32, DigitMode)
    GetID(pDeviceClass, ppDeviceID)
      => ComCall(9, this.p, BSTR, pDeviceClass, UInt32.Ptr, ppDeviceID.Length, UInt8.Ptr.Ptr, ppDeviceID)
    SetMediaType(lMediaType)
      => ComCall(10, this.p, Int32, lMediaType)
    MonitorMedia(lMediaType)
      => ComCall(11, this.p, Int32, lMediaType)
}
struct ITLegacyCallMediaControl2 extends ITLegacyCallMediaControl {
    static IID := "{57CA332D-7BC2-44F1-A60C-936FE8D7CE73}"
    GenerateDigits2(pDigits, DigitMode, lDuration)
      => ComCall(12, this.p, BSTR, pDigits, Int32, DigitMode, Int32, lDuration)
    GatherDigits(DigitMode, lNumDigits, pTerminationDigits, lFirstDigitTimeout, lInterDigitTimeout)
      => ComCall(13, this.p, Int32, DigitMode, Int32, lNumDigits, BSTR, pTerminationDigits, Int32, lFirstDigitTimeout, Int32, lInterDigitTimeout)
    DetectTones(pToneList, lNumTones)
      => ComCall(14, this.p, TAPI_DETECTTONE.Ptr, pToneList, Int32, lNumTones)
    DetectTonesByCollection(pDetectToneCollection)
      => ComCall(15, this.p, ITCollection2, pDetectToneCollection)
    GenerateTone(ToneMode, lDuration)
      => ComCall(16, this.p, TAPI_TONEMODE, ToneMode, Int32, lDuration)
    GenerateCustomTones(pToneList, lNumTones, lDuration)
      => ComCall(17, this.p, TAPI_CUSTOMTONE.Ptr, pToneList, Int32, lNumTones, Int32, lDuration)
    GenerateCustomTonesByCollection(pCustomToneCollection, lDuration)
      => ComCall(18, this.p, ITCollection2, pCustomToneCollection, Int32, lDuration)
    CreateDetectToneObject(ppDetectTone)
      => ComCall(19, this.p, ITDetectTone.Ptr, ppDetectTone)
    CreateCustomToneObject(ppCustomTone)
      => ComCall(20, this.p, ITCustomTone.Ptr, ppCustomTone)
    GetIDAsVariant(bstrDeviceClass, pVarDeviceID)
      => ComCall(21, this.p, BSTR, bstrDeviceClass, VARIANT.Ptr, pVarDeviceID)
}
struct ITDetectTone extends IDispatch {
    static IID := "{961F79BD-3097-49DF-A1D6-909B77E89CA0}"
    get_AppSpecific(plAppSpecific)
      => ComCall(7, this.p, Int32.Ptr, plAppSpecific)
    put_AppSpecific(lAppSpecific)
      => ComCall(8, this.p, Int32, lAppSpecific)
    get_Duration(plDuration)
      => ComCall(9, this.p, Int32.Ptr, plDuration)
    put_Duration(lDuration)
      => ComCall(10, this.p, Int32, lDuration)
    get_Frequency(Index, plFrequency)
      => ComCall(11, this.p, Int32, Index, Int32.Ptr, plFrequency)
    put_Frequency(Index, lFrequency)
      => ComCall(12, this.p, Int32, Index, Int32, lFrequency)
}
struct ITCustomTone extends IDispatch {
    static IID := "{357AD764-B3C6-4B2A-8FA5-0722827A9254}"
    get_Frequency(plFrequency)
      => ComCall(7, this.p, Int32.Ptr, plFrequency)
    put_Frequency(lFrequency)
      => ComCall(8, this.p, Int32, lFrequency)
    get_CadenceOn(plCadenceOn)
      => ComCall(9, this.p, Int32.Ptr, plCadenceOn)
    put_CadenceOn(CadenceOn)
      => ComCall(10, this.p, Int32, CadenceOn)
    get_CadenceOff(plCadenceOff)
      => ComCall(11, this.p, Int32.Ptr, plCadenceOff)
    put_CadenceOff(lCadenceOff)
      => ComCall(12, this.p, Int32, lCadenceOff)
    get_Volume(plVolume)
      => ComCall(13, this.p, Int32.Ptr, plVolume)
    put_Volume(lVolume)
      => ComCall(14, this.p, Int32, lVolume)
}
struct IEnumPhone extends IUnknown {
    static IID := "{F15B7669-4780-4595-8C89-FB369C8CF7AA}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITPhone.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPhone.Ptr, ppEnum)
}
struct IEnumTerminal extends IUnknown {
    static IID := "{AE269CF4-935E-11D0-835C-00AA003CCABD}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITTerminal.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumTerminal.Ptr, ppEnum)
}
struct IEnumTerminalClass extends IUnknown {
    static IID := "{AE269CF5-935E-11D0-835C-00AA003CCABD}"
    Next(pElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, pElements.Length, GUID.Ptr, pElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumTerminalClass.Ptr, ppEnum)
}
struct IEnumCall extends IUnknown {
    static IID := "{AE269CF6-935E-11D0-835C-00AA003CCABD}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITCallInfo.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumCall.Ptr, ppEnum)
}
struct IEnumAddress extends IUnknown {
    static IID := "{1666FCA1-9363-11D0-835C-00AA003CCABD}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITAddress.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumAddress.Ptr, ppEnum)
}
struct IEnumCallHub extends IUnknown {
    static IID := "{A3C15450-5B92-11D1-8F4E-00C04FB6809F}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITCallHub.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumCallHub.Ptr, ppEnum)
}
struct IEnumBstr extends IUnknown {
    static IID := "{35372049-0BC6-11D2-A033-00C04FB6809F}"
    Next(ppStrings, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppStrings.Length, BSTR.Ptr, ppStrings, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumBstr.Ptr, ppEnum)
}
struct IEnumPluggableTerminalClassInfo extends IUnknown {
    static IID := "{4567450C-DBEE-4E3F-AAF5-37BF9EBF5E29}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITPluggableTerminalClassInfo.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPluggableTerminalClassInfo.Ptr, ppEnum)
}
struct IEnumPluggableSuperclassInfo extends IUnknown {
    static IID := "{E9586A80-89E6-4CFF-931D-478D5751F4C0}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITPluggableTerminalSuperclassInfo.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPluggableSuperclassInfo.Ptr, ppEnum)
}
struct ITPhoneEvent extends IDispatch {
    static IID := "{8F942DD8-64ED-4AAF-A77D-B23DB0837EAD}"
    get_Phone(ppPhone)
      => ComCall(7, this.p, ITPhone.Ptr, ppPhone)
    get_Event(pEvent)
      => ComCall(8, this.p, PHONE_EVENT.Ptr, pEvent)
    get_ButtonState(pState)
      => ComCall(9, this.p, PHONE_BUTTON_STATE.Ptr, pState)
    get_HookSwitchState(pState)
      => ComCall(10, this.p, PHONE_HOOK_SWITCH_STATE.Ptr, pState)
    get_HookSwitchDevice(pDevice)
      => ComCall(11, this.p, PHONE_HOOK_SWITCH_DEVICE.Ptr, pDevice)
    get_RingMode(plRingMode)
      => ComCall(12, this.p, Int32.Ptr, plRingMode)
    get_ButtonLampId(plButtonLampId)
      => ComCall(13, this.p, Int32.Ptr, plButtonLampId)
    get_NumberGathered(ppNumber)
      => ComCall(14, this.p, BSTR.Ptr, ppNumber)
    get_Call(ppCallInfo)
      => ComCall(15, this.p, ITCallInfo.Ptr, ppCallInfo)
}
struct ITCallStateEvent extends IDispatch {
    static IID := "{62F47097-95C9-11D0-835D-00AA003CCABD}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_State(pCallState)
      => ComCall(8, this.p, CALL_STATE.Ptr, pCallState)
    get_Cause(pCEC)
      => ComCall(9, this.p, CALL_STATE_EVENT_CAUSE.Ptr, pCEC)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(10, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITPhoneDeviceSpecificEvent extends IDispatch {
    static IID := "{63FFB2A6-872B-4CD3-A501-326E8FB40AF7}"
    get_Phone(ppPhone)
      => ComCall(7, this.p, ITPhone.Ptr, ppPhone)
    get_lParam1(pParam1)
      => ComCall(8, this.p, Int32.Ptr, pParam1)
    get_lParam2(pParam2)
      => ComCall(9, this.p, Int32.Ptr, pParam2)
    get_lParam3(pParam3)
      => ComCall(10, this.p, Int32.Ptr, pParam3)
}
struct ITCallMediaEvent extends IDispatch {
    static IID := "{FF36B87F-EC3A-11D0-8EE4-00C04FB6809F}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_Event(pCallMediaEvent)
      => ComCall(8, this.p, CALL_MEDIA_EVENT.Ptr, pCallMediaEvent)
    get_Error(phrError)
      => ComCall(9, this.p, HRESULT.Ptr, phrError)
    get_Terminal(ppTerminal)
      => ComCall(10, this.p, ITTerminal.Ptr, ppTerminal)
    get_Stream(ppStream)
      => ComCall(11, this.p, ITStream.Ptr, ppStream)
    get_Cause(pCause)
      => ComCall(12, this.p, CALL_MEDIA_EVENT_CAUSE.Ptr, pCause)
}
struct ITDigitDetectionEvent extends IDispatch {
    static IID := "{80D3BFAC-57D9-11D2-A04A-00C04FB6809F}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_Digit(pucDigit)
      => ComCall(8, this.p, UInt8.Ptr, pucDigit)
    get_DigitMode(pDigitMode)
      => ComCall(9, this.p, Int32.Ptr, pDigitMode)
    get_TickCount(plTickCount)
      => ComCall(10, this.p, Int32.Ptr, plTickCount)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(11, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITDigitGenerationEvent extends IDispatch {
    static IID := "{80D3BFAD-57D9-11D2-A04A-00C04FB6809F}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_GenerationTermination(plGenerationTermination)
      => ComCall(8, this.p, Int32.Ptr, plGenerationTermination)
    get_TickCount(plTickCount)
      => ComCall(9, this.p, Int32.Ptr, plTickCount)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(10, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITDigitsGatheredEvent extends IDispatch {
    static IID := "{E52EC4C1-CBA3-441A-9E6A-93CB909E9724}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_Digits(ppDigits)
      => ComCall(8, this.p, BSTR.Ptr, ppDigits)
    get_GatherTermination(pGatherTermination)
      => ComCall(9, this.p, TAPI_GATHERTERM.Ptr, pGatherTermination)
    get_TickCount(plTickCount)
      => ComCall(10, this.p, Int32.Ptr, plTickCount)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(11, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITToneDetectionEvent extends IDispatch {
    static IID := "{407E0FAF-D047-4753-B0C6-8E060373FECD}"
    get_Call(ppCallInfo)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCallInfo)
    get_AppSpecific(plAppSpecific)
      => ComCall(8, this.p, Int32.Ptr, plAppSpecific)
    get_TickCount(plTickCount)
      => ComCall(9, this.p, Int32.Ptr, plTickCount)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(10, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITTAPIObjectEvent extends IDispatch {
    static IID := "{F4854D48-937A-11D1-BB58-00C04FB6809F}"
    get_TAPIObject(ppTAPIObject)
      => ComCall(7, this.p, ITTAPI.Ptr, ppTAPIObject)
    get_Event(pEvent)
      => ComCall(8, this.p, TAPIOBJECT_EVENT.Ptr, pEvent)
    get_Address(ppAddress)
      => ComCall(9, this.p, ITAddress.Ptr, ppAddress)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(10, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITTAPIObjectEvent2 extends ITTAPIObjectEvent {
    static IID := "{359DDA6E-68CE-4383-BF0B-169133C41B46}"
    get_Phone(ppPhone)
      => ComCall(11, this.p, ITPhone.Ptr, ppPhone)
}
struct ITTAPIEventNotification extends IUnknown {
    static IID := "{EDDB9426-3B91-11D1-8F30-00C04FB6809F}"
    Event(TapiEvent, pEvent)
      => ComCall(3, this.p, TAPI_EVENT, TapiEvent, IDispatch, pEvent)
}
struct ITCallHubEvent extends IDispatch {
    static IID := "{A3C15451-5B92-11D1-8F4E-00C04FB6809F}"
    get_Event(pEvent)
      => ComCall(7, this.p, CALLHUB_EVENT.Ptr, pEvent)
    get_CallHub(ppCallHub)
      => ComCall(8, this.p, ITCallHub.Ptr, ppCallHub)
    get_Call(ppCall)
      => ComCall(9, this.p, ITCallInfo.Ptr, ppCall)
}
struct ITAddressEvent extends IDispatch {
    static IID := "{831CE2D1-83B5-11D1-BB5C-00C04FB6809F}"
    get_Address(ppAddress)
      => ComCall(7, this.p, ITAddress.Ptr, ppAddress)
    get_Event(pEvent)
      => ComCall(8, this.p, ADDRESS_EVENT.Ptr, pEvent)
    get_Terminal(ppTerminal)
      => ComCall(9, this.p, ITTerminal.Ptr, ppTerminal)
}
struct ITAddressDeviceSpecificEvent extends IDispatch {
    static IID := "{3ACB216B-40BD-487A-8672-5CE77BD7E3A3}"
    get_Address(ppAddress)
      => ComCall(7, this.p, ITAddress.Ptr, ppAddress)
    get_Call(ppCall)
      => ComCall(8, this.p, ITCallInfo.Ptr, ppCall)
    get_lParam1(pParam1)
      => ComCall(9, this.p, Int32.Ptr, pParam1)
    get_lParam2(pParam2)
      => ComCall(10, this.p, Int32.Ptr, pParam2)
    get_lParam3(pParam3)
      => ComCall(11, this.p, Int32.Ptr, pParam3)
}
struct ITFileTerminalEvent extends IDispatch {
    static IID := "{E4A7FBAC-8C17-4427-9F55-9F589AC8AF00}"
    get_Terminal(ppTerminal)
      => ComCall(7, this.p, ITTerminal.Ptr, ppTerminal)
    get_Track(ppTrackTerminal)
      => ComCall(8, this.p, ITFileTrack.Ptr, ppTrackTerminal)
    get_Call(ppCall)
      => ComCall(9, this.p, ITCallInfo.Ptr, ppCall)
    get_State(pState)
      => ComCall(10, this.p, TERMINAL_MEDIA_STATE.Ptr, pState)
    get_Cause(pCause)
      => ComCall(11, this.p, FT_STATE_EVENT_CAUSE.Ptr, pCause)
    get_Error(phrErrorCode)
      => ComCall(12, this.p, HRESULT.Ptr, phrErrorCode)
}
struct ITTTSTerminalEvent extends IDispatch {
    static IID := "{D964788F-95A5-461D-AB0C-B9900A6C2713}"
    get_Terminal(ppTerminal)
      => ComCall(7, this.p, ITTerminal.Ptr, ppTerminal)
    get_Call(ppCall)
      => ComCall(8, this.p, ITCallInfo.Ptr, ppCall)
    get_Error(phrErrorCode)
      => ComCall(9, this.p, HRESULT.Ptr, phrErrorCode)
}
struct ITASRTerminalEvent extends IDispatch {
    static IID := "{EE016A02-4FA9-467C-933F-5A15B12377D7}"
    get_Terminal(ppTerminal)
      => ComCall(7, this.p, ITTerminal.Ptr, ppTerminal)
    get_Call(ppCall)
      => ComCall(8, this.p, ITCallInfo.Ptr, ppCall)
    get_Error(phrErrorCode)
      => ComCall(9, this.p, HRESULT.Ptr, phrErrorCode)
}
struct ITToneTerminalEvent extends IDispatch {
    static IID := "{E6F56009-611F-4945-BBD2-2D0CE5612056}"
    get_Terminal(ppTerminal)
      => ComCall(7, this.p, ITTerminal.Ptr, ppTerminal)
    get_Call(ppCall)
      => ComCall(8, this.p, ITCallInfo.Ptr, ppCall)
    get_Error(phrErrorCode)
      => ComCall(9, this.p, HRESULT.Ptr, phrErrorCode)
}
struct ITQOSEvent extends IDispatch {
    static IID := "{CFA3357C-AD77-11D1-BB68-00C04FB6809F}"
    get_Call(ppCall)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCall)
    get_Event(pQosEvent)
      => ComCall(8, this.p, QOS_EVENT.Ptr, pQosEvent)
    get_MediaType(plMediaType)
      => ComCall(9, this.p, Int32.Ptr, plMediaType)
}
struct ITCallInfoChangeEvent extends IDispatch {
    static IID := "{5D4B65F9-E51C-11D1-A02F-00C04FB6809F}"
    get_Call(ppCall)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCall)
    get_Cause(pCIC)
      => ComCall(8, this.p, CALLINFOCHANGE_CAUSE.Ptr, pCIC)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(9, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITRequest extends IDispatch {
    static IID := "{AC48FFDF-F8C4-11D1-A030-00C04FB6809F}"
    MakeCall(pDestAddress, pAppName, pCalledParty, pComment)
      => ComCall(7, this.p, BSTR, pDestAddress, BSTR, pAppName, BSTR, pCalledParty, BSTR, pComment)
}
struct ITRequestEvent extends IDispatch {
    static IID := "{AC48FFDE-F8C4-11D1-A030-00C04FB6809F}"
    get_RegistrationInstance(plRegistrationInstance)
      => ComCall(7, this.p, Int32.Ptr, plRegistrationInstance)
    get_RequestMode(plRequestMode)
      => ComCall(8, this.p, Int32.Ptr, plRequestMode)
    get_DestAddress(ppDestAddress)
      => ComCall(9, this.p, BSTR.Ptr, ppDestAddress)
    get_AppName(ppAppName)
      => ComCall(10, this.p, BSTR.Ptr, ppAppName)
    get_CalledParty(ppCalledParty)
      => ComCall(11, this.p, BSTR.Ptr, ppCalledParty)
    get_Comment(ppComment)
      => ComCall(12, this.p, BSTR.Ptr, ppComment)
}
struct ITCollection extends IDispatch {
    static IID := "{5EC5ACF2-9C02-11D0-8362-00AA003CCABD}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get_Item(Index, pVariant)
      => ComCall(8, this.p, Int32, Index, VARIANT.Ptr, pVariant)
    get__NewEnum(ppNewEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppNewEnum)
}
struct ITCollection2 extends ITCollection {
    static IID := "{E6DDDDA5-A6D3-48FF-8737-D32FC4D95477}"
    Add(Index, pVariant)
      => ComCall(10, this.p, Int32, Index, VARIANT.Ptr, pVariant)
    Remove(Index)
      => ComCall(11, this.p, Int32, Index)
}
struct ITForwardInformation extends IDispatch {
    static IID := "{449F659E-88A3-11D1-BB5D-00C04FB6809F}"
    put_NumRingsNoAnswer(lNumRings)
      => ComCall(7, this.p, Int32, lNumRings)
    get_NumRingsNoAnswer(plNumRings)
      => ComCall(8, this.p, Int32.Ptr, plNumRings)
    SetForwardType(ForwardType, pDestAddress, pCallerAddress)
      => ComCall(9, this.p, Int32, ForwardType, BSTR, pDestAddress, BSTR, pCallerAddress)
    get_ForwardTypeDestination(ForwardType, ppDestAddress)
      => ComCall(10, this.p, Int32, ForwardType, BSTR.Ptr, ppDestAddress)
    get_ForwardTypeCaller(Forwardtype, ppCallerAddress)
      => ComCall(11, this.p, Int32, Forwardtype, BSTR.Ptr, ppCallerAddress)
    GetForwardType(ForwardType, ppDestinationAddress, ppCallerAddress)
      => ComCall(12, this.p, Int32, ForwardType, BSTR.Ptr, ppDestinationAddress, BSTR.Ptr, ppCallerAddress)
    Clear()
      => ComCall(13, this.p)
}
struct ITForwardInformation2 extends ITForwardInformation {
    static IID := "{5229B4ED-B260-4382-8E1A-5DF3A8A4CCC0}"
    SetForwardType2(ForwardType, pDestAddress, DestAddressType, pCallerAddress, CallerAddressType)
      => ComCall(14, this.p, Int32, ForwardType, BSTR, pDestAddress, Int32, DestAddressType, BSTR, pCallerAddress, Int32, CallerAddressType)
    GetForwardType2(ForwardType, ppDestinationAddress, pDestAddressType, ppCallerAddress, pCallerAddressType)
      => ComCall(15, this.p, Int32, ForwardType, BSTR.Ptr, ppDestinationAddress, Int32.Ptr, pDestAddressType, BSTR.Ptr, ppCallerAddress, Int32.Ptr, pCallerAddressType)
    get_ForwardTypeDestinationAddressType(ForwardType, pDestAddressType)
      => ComCall(16, this.p, Int32, ForwardType, Int32.Ptr, pDestAddressType)
    get_ForwardTypeCallerAddressType(Forwardtype, pCallerAddressType)
      => ComCall(17, this.p, Int32, Forwardtype, Int32.Ptr, pCallerAddressType)
}
struct ITAddressTranslation extends IDispatch {
    static IID := "{0C4D8F03-8DDB-11D1-A09E-00805FC147D3}"
    TranslateAddress(pAddressToTranslate, lCard, lTranslateOptions, ppTranslated)
      => ComCall(7, this.p, BSTR, pAddressToTranslate, Int32, lCard, Int32, lTranslateOptions, ITAddressTranslationInfo.Ptr, ppTranslated)
    TranslateDialog(hwndOwner, pAddressIn)
      => ComCall(8, this.p, IntPtr, hwndOwner, BSTR, pAddressIn)
    EnumerateLocations(ppEnumLocation)
      => ComCall(9, this.p, IEnumLocation.Ptr, ppEnumLocation)
    get_Locations(pVariant)
      => ComCall(10, this.p, VARIANT.Ptr, pVariant)
    EnumerateCallingCards(ppEnumCallingCard)
      => ComCall(11, this.p, IEnumCallingCard.Ptr, ppEnumCallingCard)
    get_CallingCards(pVariant)
      => ComCall(12, this.p, VARIANT.Ptr, pVariant)
}
struct ITAddressTranslationInfo extends IDispatch {
    static IID := "{AFC15945-8D40-11D1-A09E-00805FC147D3}"
    get_DialableString(ppDialableString)
      => ComCall(7, this.p, BSTR.Ptr, ppDialableString)
    get_DisplayableString(ppDisplayableString)
      => ComCall(8, this.p, BSTR.Ptr, ppDisplayableString)
    get_CurrentCountryCode(CountryCode)
      => ComCall(9, this.p, Int32.Ptr, CountryCode)
    get_DestinationCountryCode(CountryCode)
      => ComCall(10, this.p, Int32.Ptr, CountryCode)
    get_TranslationResults(plResults)
      => ComCall(11, this.p, Int32.Ptr, plResults)
}
struct ITLocationInfo extends IDispatch {
    static IID := "{0C4D8EFF-8DDB-11D1-A09E-00805FC147D3}"
    get_PermanentLocationID(plLocationID)
      => ComCall(7, this.p, Int32.Ptr, plLocationID)
    get_CountryCode(plCountryCode)
      => ComCall(8, this.p, Int32.Ptr, plCountryCode)
    get_CountryID(plCountryID)
      => ComCall(9, this.p, Int32.Ptr, plCountryID)
    get_Options(plOptions)
      => ComCall(10, this.p, Int32.Ptr, plOptions)
    get_PreferredCardID(plCardID)
      => ComCall(11, this.p, Int32.Ptr, plCardID)
    get_LocationName(ppLocationName)
      => ComCall(12, this.p, BSTR.Ptr, ppLocationName)
    get_CityCode(ppCode)
      => ComCall(13, this.p, BSTR.Ptr, ppCode)
    get_LocalAccessCode(ppCode)
      => ComCall(14, this.p, BSTR.Ptr, ppCode)
    get_LongDistanceAccessCode(ppCode)
      => ComCall(15, this.p, BSTR.Ptr, ppCode)
    get_TollPrefixList(ppTollList)
      => ComCall(16, this.p, BSTR.Ptr, ppTollList)
    get_CancelCallWaitingCode(ppCode)
      => ComCall(17, this.p, BSTR.Ptr, ppCode)
}
struct IEnumLocation extends IUnknown {
    static IID := "{0C4D8F01-8DDB-11D1-A09E-00805FC147D3}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITLocationInfo.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumLocation.Ptr, ppEnum)
}
struct ITCallingCard extends IDispatch {
    static IID := "{0C4D8F00-8DDB-11D1-A09E-00805FC147D3}"
    get_PermanentCardID(plCardID)
      => ComCall(7, this.p, Int32.Ptr, plCardID)
    get_NumberOfDigits(plDigits)
      => ComCall(8, this.p, Int32.Ptr, plDigits)
    get_Options(plOptions)
      => ComCall(9, this.p, Int32.Ptr, plOptions)
    get_CardName(ppCardName)
      => ComCall(10, this.p, BSTR.Ptr, ppCardName)
    get_SameAreaDialingRule(ppRule)
      => ComCall(11, this.p, BSTR.Ptr, ppRule)
    get_LongDistanceDialingRule(ppRule)
      => ComCall(12, this.p, BSTR.Ptr, ppRule)
    get_InternationalDialingRule(ppRule)
      => ComCall(13, this.p, BSTR.Ptr, ppRule)
}
struct IEnumCallingCard extends IUnknown {
    static IID := "{0C4D8F02-8DDB-11D1-A09E-00805FC147D3}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITCallingCard.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumCallingCard.Ptr, ppEnum)
}
struct ITCallNotificationEvent extends IDispatch {
    static IID := "{895801DF-3DD6-11D1-8F30-00C04FB6809F}"
    get_Call(ppCall)
      => ComCall(7, this.p, ITCallInfo.Ptr, ppCall)
    get_Event(pCallNotificationEvent)
      => ComCall(8, this.p, CALL_NOTIFICATION_EVENT.Ptr, pCallNotificationEvent)
    get_CallbackInstance(plCallbackInstance)
      => ComCall(9, this.p, Int32.Ptr, plCallbackInstance)
}
struct ITDispatchMapper extends IDispatch {
    static IID := "{E9225295-C759-11D1-A02B-00C04FB6809F}"
    QueryDispatchInterface(pIID, pInterfaceToMap, ppReturnedInterface)
      => ComCall(7, this.p, BSTR, pIID, IDispatch, pInterfaceToMap, IDispatch.Ptr, ppReturnedInterface)
}
struct ITStreamControl extends IDispatch {
    static IID := "{EE3BD604-3868-11D2-A045-00C04FB6809F}"
    CreateStream(lMediaType, td, ppStream)
      => ComCall(7, this.p, Int32, lMediaType, TERMINAL_DIRECTION, td, ITStream.Ptr, ppStream)
    RemoveStream(pStream)
      => ComCall(8, this.p, ITStream, pStream)
    EnumerateStreams(ppEnumStream)
      => ComCall(9, this.p, IEnumStream.Ptr, ppEnumStream)
    get_Streams(pVariant)
      => ComCall(10, this.p, VARIANT.Ptr, pVariant)
}
struct ITStream extends IDispatch {
    static IID := "{EE3BD605-3868-11D2-A045-00C04FB6809F}"
    get_MediaType(plMediaType)
      => ComCall(7, this.p, Int32.Ptr, plMediaType)
    get_Direction(pTD)
      => ComCall(8, this.p, TERMINAL_DIRECTION.Ptr, pTD)
    get_Name(ppName)
      => ComCall(9, this.p, BSTR.Ptr, ppName)
    StartStream()
      => ComCall(10, this.p)
    PauseStream()
      => ComCall(11, this.p)
    StopStream()
      => ComCall(12, this.p)
    SelectTerminal(pTerminal)
      => ComCall(13, this.p, ITTerminal, pTerminal)
    UnselectTerminal(pTerminal)
      => ComCall(14, this.p, ITTerminal, pTerminal)
    EnumerateTerminals(ppEnumTerminal)
      => ComCall(15, this.p, IEnumTerminal.Ptr, ppEnumTerminal)
    get_Terminals(pTerminals)
      => ComCall(16, this.p, VARIANT.Ptr, pTerminals)
}
struct IEnumStream extends IUnknown {
    static IID := "{EE3BD606-3868-11D2-A045-00C04FB6809F}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITStream.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumStream.Ptr, ppEnum)
}
struct ITSubStreamControl extends IDispatch {
    static IID := "{EE3BD607-3868-11D2-A045-00C04FB6809F}"
    CreateSubStream(ppSubStream)
      => ComCall(7, this.p, ITSubStream.Ptr, ppSubStream)
    RemoveSubStream(pSubStream)
      => ComCall(8, this.p, ITSubStream, pSubStream)
    EnumerateSubStreams(ppEnumSubStream)
      => ComCall(9, this.p, IEnumSubStream.Ptr, ppEnumSubStream)
    get_SubStreams(pVariant)
      => ComCall(10, this.p, VARIANT.Ptr, pVariant)
}
struct ITSubStream extends IDispatch {
    static IID := "{EE3BD608-3868-11D2-A045-00C04FB6809F}"
    StartSubStream()
      => ComCall(7, this.p)
    PauseSubStream()
      => ComCall(8, this.p)
    StopSubStream()
      => ComCall(9, this.p)
    SelectTerminal(pTerminal)
      => ComCall(10, this.p, ITTerminal, pTerminal)
    UnselectTerminal(pTerminal)
      => ComCall(11, this.p, ITTerminal, pTerminal)
    EnumerateTerminals(ppEnumTerminal)
      => ComCall(12, this.p, IEnumTerminal.Ptr, ppEnumTerminal)
    get_Terminals(pTerminals)
      => ComCall(13, this.p, VARIANT.Ptr, pTerminals)
    get_Stream(ppITStream)
      => ComCall(14, this.p, ITStream.Ptr, ppITStream)
}
struct IEnumSubStream extends IUnknown {
    static IID := "{EE3BD609-3868-11D2-A045-00C04FB6809F}"
    Next(celt, ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ITSubStream.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSubStream.Ptr, ppEnum)
}
struct ITLegacyWaveSupport extends IDispatch {
    static IID := "{207823EA-E252-11D2-B77E-0080C7135381}"
    IsFullDuplex(pSupport)
      => ComCall(7, this.p, FULLDUPLEX_SUPPORT.Ptr, pSupport)
}
struct ITBasicCallControl2 extends ITBasicCallControl {
    static IID := "{161A4A56-1E99-4B3F-A46A-168F38A5EE4C}"
    RequestTerminal(bstrTerminalClassGUID, lMediaType, Direction, ppTerminal)
      => ComCall(25, this.p, BSTR, bstrTerminalClassGUID, Int32, lMediaType, TERMINAL_DIRECTION, Direction, ITTerminal.Ptr, ppTerminal)
    SelectTerminalOnCall(pTerminal)
      => ComCall(26, this.p, ITTerminal, pTerminal)
    UnselectTerminalOnCall(pTerminal)
      => ComCall(27, this.p, ITTerminal, pTerminal)
}
struct ITScriptableAudioFormat extends IDispatch {
    static IID := "{B87658BD-3C59-4F64-BE74-AEDE3E86A81E}"
    get_Channels(pVal)
      => ComCall(7, this.p, Int32.Ptr, pVal)
    put_Channels(nNewVal)
      => ComCall(8, this.p, Int32, nNewVal)
    get_SamplesPerSec(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    put_SamplesPerSec(nNewVal)
      => ComCall(10, this.p, Int32, nNewVal)
    get_AvgBytesPerSec(pVal)
      => ComCall(11, this.p, Int32.Ptr, pVal)
    put_AvgBytesPerSec(nNewVal)
      => ComCall(12, this.p, Int32, nNewVal)
    get_BlockAlign(pVal)
      => ComCall(13, this.p, Int32.Ptr, pVal)
    put_BlockAlign(nNewVal)
      => ComCall(14, this.p, Int32, nNewVal)
    get_BitsPerSample(pVal)
      => ComCall(15, this.p, Int32.Ptr, pVal)
    put_BitsPerSample(nNewVal)
      => ComCall(16, this.p, Int32, nNewVal)
    get_FormatTag(pVal)
      => ComCall(17, this.p, Int32.Ptr, pVal)
    put_FormatTag(nNewVal)
      => ComCall(18, this.p, Int32, nNewVal)
}
struct AGENT_EVENT extends Int32 {
    static AE_NOT_READY := 0
    static AE_READY := 1
    static AE_BUSY_ACD := 2
    static AE_BUSY_INCOMING := 3
    static AE_BUSY_OUTGOING := 4
    static AE_UNKNOWN := 5
}
struct AGENT_STATE extends Int32 {
    static AS_NOT_READY := 0
    static AS_READY := 1
    static AS_BUSY_ACD := 2
    static AS_BUSY_INCOMING := 3
    static AS_BUSY_OUTGOING := 4
    static AS_UNKNOWN := 5
}
struct AGENT_SESSION_EVENT extends Int32 {
    static ASE_NEW_SESSION := 0
    static ASE_NOT_READY := 1
    static ASE_READY := 2
    static ASE_BUSY := 3
    static ASE_WRAPUP := 4
    static ASE_END := 5
}
struct AGENT_SESSION_STATE extends Int32 {
    static ASST_NOT_READY := 0
    static ASST_READY := 1
    static ASST_BUSY_ON_CALL := 2
    static ASST_BUSY_WRAPUP := 3
    static ASST_SESSION_ENDED := 4
}
struct AGENTHANDLER_EVENT extends Int32 {
    static AHE_NEW_AGENTHANDLER := 0
    static AHE_AGENTHANDLER_REMOVED := 1
}
struct ACDGROUP_EVENT extends Int32 {
    static ACDGE_NEW_GROUP := 0
    static ACDGE_GROUP_REMOVED := 1
}
struct ACDQUEUE_EVENT extends Int32 {
    static ACDQE_NEW_QUEUE := 0
    static ACDQE_QUEUE_REMOVED := 1
}
struct ITAgent extends IDispatch {
    static IID := "{5770ECE5-4B27-11D1-BF80-00805FC147D3}"
    EnumerateAgentSessions(ppEnumAgentSession)
      => ComCall(7, this.p, IEnumAgentSession.Ptr, ppEnumAgentSession)
    CreateSession(pACDGroup?, pAddress?, ppAgentSession)
      => ComCall(8, this.p, ITACDGroup, pACDGroup?, ITAddress, pAddress?, ITAgentSession.Ptr, ppAgentSession)
    CreateSessionWithPIN(pACDGroup?, pAddress?, pPIN, ppAgentSession)
      => ComCall(9, this.p, ITACDGroup, pACDGroup?, ITAddress, pAddress?, BSTR, pPIN, ITAgentSession.Ptr, ppAgentSession)
    get_ID(ppID)
      => ComCall(10, this.p, BSTR.Ptr, ppID)
    get_User(ppUser)
      => ComCall(11, this.p, BSTR.Ptr, ppUser)
    put_State(AgentState)
      => ComCall(12, this.p, AGENT_STATE, AgentState)
    get_State(pAgentState)
      => ComCall(13, this.p, AGENT_STATE.Ptr, pAgentState)
    put_MeasurementPeriod(lPeriod)
      => ComCall(14, this.p, Int32, lPeriod)
    get_MeasurementPeriod(plPeriod)
      => ComCall(15, this.p, Int32.Ptr, plPeriod)
    get_OverallCallRate(pcyCallrate)
      => ComCall(16, this.p, CY.Ptr, pcyCallrate)
    get_NumberOfACDCalls(plCalls)
      => ComCall(17, this.p, Int32.Ptr, plCalls)
    get_NumberOfIncomingCalls(plCalls)
      => ComCall(18, this.p, Int32.Ptr, plCalls)
    get_NumberOfOutgoingCalls(plCalls)
      => ComCall(19, this.p, Int32.Ptr, plCalls)
    get_TotalACDTalkTime(plTalkTime)
      => ComCall(20, this.p, Int32.Ptr, plTalkTime)
    get_TotalACDCallTime(plCallTime)
      => ComCall(21, this.p, Int32.Ptr, plCallTime)
    get_TotalWrapUpTime(plWrapUpTime)
      => ComCall(22, this.p, Int32.Ptr, plWrapUpTime)
    get_AgentSessions(pVariant)
      => ComCall(23, this.p, VARIANT.Ptr, pVariant)
}
struct ITAgentSession extends IDispatch {
    static IID := "{5AFC3147-4BCC-11D1-BF80-00805FC147D3}"
    get_Agent(ppAgent)
      => ComCall(7, this.p, ITAgent.Ptr, ppAgent)
    get_Address(ppAddress)
      => ComCall(8, this.p, ITAddress.Ptr, ppAddress)
    get_ACDGroup(ppACDGroup)
      => ComCall(9, this.p, ITACDGroup.Ptr, ppACDGroup)
    put_State(SessionState)
      => ComCall(10, this.p, AGENT_SESSION_STATE, SessionState)
    get_State(pSessionState)
      => ComCall(11, this.p, AGENT_SESSION_STATE.Ptr, pSessionState)
    get_SessionStartTime(pdateSessionStart)
      => ComCall(12, this.p, Float64.Ptr, pdateSessionStart)
    get_SessionDuration(plDuration)
      => ComCall(13, this.p, Int32.Ptr, plDuration)
    get_NumberOfCalls(plCalls)
      => ComCall(14, this.p, Int32.Ptr, plCalls)
    get_TotalTalkTime(plTalkTime)
      => ComCall(15, this.p, Int32.Ptr, plTalkTime)
    get_AverageTalkTime(plTalkTime)
      => ComCall(16, this.p, Int32.Ptr, plTalkTime)
    get_TotalCallTime(plCallTime)
      => ComCall(17, this.p, Int32.Ptr, plCallTime)
    get_AverageCallTime(plCallTime)
      => ComCall(18, this.p, Int32.Ptr, plCallTime)
    get_TotalWrapUpTime(plWrapUpTime)
      => ComCall(19, this.p, Int32.Ptr, plWrapUpTime)
    get_AverageWrapUpTime(plWrapUpTime)
      => ComCall(20, this.p, Int32.Ptr, plWrapUpTime)
    get_ACDCallRate(pcyCallrate)
      => ComCall(21, this.p, CY.Ptr, pcyCallrate)
    get_LongestTimeToAnswer(plAnswerTime)
      => ComCall(22, this.p, Int32.Ptr, plAnswerTime)
    get_AverageTimeToAnswer(plAnswerTime)
      => ComCall(23, this.p, Int32.Ptr, plAnswerTime)
}
struct ITACDGroup extends IDispatch {
    static IID := "{5AFC3148-4BCC-11D1-BF80-00805FC147D3}"
    get_Name(ppName)
      => ComCall(7, this.p, BSTR.Ptr, ppName)
    EnumerateQueues(ppEnumQueue)
      => ComCall(8, this.p, IEnumQueue.Ptr, ppEnumQueue)
    get_Queues(pVariant)
      => ComCall(9, this.p, VARIANT.Ptr, pVariant)
}
struct ITQueue extends IDispatch {
    static IID := "{5AFC3149-4BCC-11D1-BF80-00805FC147D3}"
    put_MeasurementPeriod(lPeriod)
      => ComCall(7, this.p, Int32, lPeriod)
    get_MeasurementPeriod(plPeriod)
      => ComCall(8, this.p, Int32.Ptr, plPeriod)
    get_TotalCallsQueued(plCalls)
      => ComCall(9, this.p, Int32.Ptr, plCalls)
    get_CurrentCallsQueued(plCalls)
      => ComCall(10, this.p, Int32.Ptr, plCalls)
    get_TotalCallsAbandoned(plCalls)
      => ComCall(11, this.p, Int32.Ptr, plCalls)
    get_TotalCallsFlowedIn(plCalls)
      => ComCall(12, this.p, Int32.Ptr, plCalls)
    get_TotalCallsFlowedOut(plCalls)
      => ComCall(13, this.p, Int32.Ptr, plCalls)
    get_LongestEverWaitTime(plWaitTime)
      => ComCall(14, this.p, Int32.Ptr, plWaitTime)
    get_CurrentLongestWaitTime(plWaitTime)
      => ComCall(15, this.p, Int32.Ptr, plWaitTime)
    get_AverageWaitTime(plWaitTime)
      => ComCall(16, this.p, Int32.Ptr, plWaitTime)
    get_FinalDisposition(plCalls)
      => ComCall(17, this.p, Int32.Ptr, plCalls)
    get_Name(ppName)
      => ComCall(18, this.p, BSTR.Ptr, ppName)
}
struct ITAgentEvent extends IDispatch {
    static IID := "{5AFC314A-4BCC-11D1-BF80-00805FC147D3}"
    get_Agent(ppAgent)
      => ComCall(7, this.p, ITAgent.Ptr, ppAgent)
    get_Event(pEvent)
      => ComCall(8, this.p, AGENT_EVENT.Ptr, pEvent)
}
struct ITAgentSessionEvent extends IDispatch {
    static IID := "{5AFC314B-4BCC-11D1-BF80-00805FC147D3}"
    get_Session(ppSession)
      => ComCall(7, this.p, ITAgentSession.Ptr, ppSession)
    get_Event(pEvent)
      => ComCall(8, this.p, AGENT_SESSION_EVENT.Ptr, pEvent)
}
struct ITACDGroupEvent extends IDispatch {
    static IID := "{297F3032-BD11-11D1-A0A7-00805FC147D3}"
    get_Group(ppGroup)
      => ComCall(7, this.p, ITACDGroup.Ptr, ppGroup)
    get_Event(pEvent)
      => ComCall(8, this.p, ACDGROUP_EVENT.Ptr, pEvent)
}
struct ITQueueEvent extends IDispatch {
    static IID := "{297F3033-BD11-11D1-A0A7-00805FC147D3}"
    get_Queue(ppQueue)
      => ComCall(7, this.p, ITQueue.Ptr, ppQueue)
    get_Event(pEvent)
      => ComCall(8, this.p, ACDQUEUE_EVENT.Ptr, pEvent)
}
struct ITAgentHandlerEvent extends IDispatch {
    static IID := "{297F3034-BD11-11D1-A0A7-00805FC147D3}"
    get_AgentHandler(ppAgentHandler)
      => ComCall(7, this.p, ITAgentHandler.Ptr, ppAgentHandler)
    get_Event(pEvent)
      => ComCall(8, this.p, AGENTHANDLER_EVENT.Ptr, pEvent)
}
struct ITTAPICallCenter extends IDispatch {
    static IID := "{5AFC3154-4BCC-11D1-BF80-00805FC147D3}"
    EnumerateAgentHandlers(ppEnumHandler)
      => ComCall(7, this.p, IEnumAgentHandler.Ptr, ppEnumHandler)
    get_AgentHandlers(pVariant)
      => ComCall(8, this.p, VARIANT.Ptr, pVariant)
}
struct ITAgentHandler extends IDispatch {
    static IID := "{587E8C22-9802-11D1-A0A4-00805FC147D3}"
    get_Name(ppName)
      => ComCall(7, this.p, BSTR.Ptr, ppName)
    CreateAgent(ppAgent)
      => ComCall(8, this.p, ITAgent.Ptr, ppAgent)
    CreateAgentWithID(pID, pPIN, ppAgent)
      => ComCall(9, this.p, BSTR, pID, BSTR, pPIN, ITAgent.Ptr, ppAgent)
    EnumerateACDGroups(ppEnumACDGroup)
      => ComCall(10, this.p, IEnumACDGroup.Ptr, ppEnumACDGroup)
    EnumerateUsableAddresses(ppEnumAddress)
      => ComCall(11, this.p, IEnumAddress.Ptr, ppEnumAddress)
    get_ACDGroups(pVariant)
      => ComCall(12, this.p, VARIANT.Ptr, pVariant)
    get_UsableAddresses(pVariant)
      => ComCall(13, this.p, VARIANT.Ptr, pVariant)
}
struct IEnumAgent extends IUnknown {
    static IID := "{5AFC314D-4BCC-11D1-BF80-00805FC147D3}"
    Next(celt, ppElements, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, ITAgent.Ptr, ppElements, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumAgent.Ptr, ppEnum)
}
struct IEnumAgentSession extends IUnknown {
    static IID := "{5AFC314E-4BCC-11D1-BF80-00805FC147D3}"
    Next(celt, ppElements, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, ITAgentSession.Ptr, ppElements, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumAgentSession.Ptr, ppEnum)
}
struct IEnumQueue extends IUnknown {
    static IID := "{5AFC3158-4BCC-11D1-BF80-00805FC147D3}"
    Next(celt, ppElements, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, ITQueue.Ptr, ppElements, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumQueue.Ptr, ppEnum)
}
struct IEnumACDGroup extends IUnknown {
    static IID := "{5AFC3157-4BCC-11D1-BF80-00805FC147D3}"
    Next(celt, ppElements, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, ITACDGroup.Ptr, ppElements, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumACDGroup.Ptr, ppEnum)
}
struct IEnumAgentHandler extends IUnknown {
    static IID := "{587E8C28-9802-11D1-A0A4-00805FC147D3}"
    Next(celt, ppElements, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, ITAgentHandler.Ptr, ppElements, UInt32.Ptr, pceltFetched)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumAgentHandler.Ptr, ppEnum)
}
struct ITAMMediaFormat extends IUnknown {
    static IID := "{0364EB00-4A77-11D1-A671-006097C9A2E8}"
    get_MediaFormat(ppmt)
      => ComCall(3, this.p, AM_MEDIA_TYPE.Ptr.Ptr, ppmt)
    put_MediaFormat(pmt)
      => ComCall(4, this.p, AM_MEDIA_TYPE.Ptr, pmt)
}
struct ITAllocatorProperties extends IUnknown {
    static IID := "{C1BC3C90-BCFE-11D1-9745-00C04FD91AC0}"
    SetAllocatorProperties(pAllocProperties)
      => ComCall(3, this.p, ALLOCATOR_PROPERTIES.Ptr, pAllocProperties)
    GetAllocatorProperties(pAllocProperties)
      => ComCall(4, this.p, ALLOCATOR_PROPERTIES.Ptr, pAllocProperties)
    SetAllocateBuffers(bAllocBuffers)
      => ComCall(5, this.p, BOOL, bAllocBuffers)
    GetAllocateBuffers(pbAllocBuffers)
      => ComCall(6, this.p, BOOL.Ptr, pbAllocBuffers)
    SetBufferSize(BufferSize)
      => ComCall(7, this.p, UInt32, BufferSize)
    GetBufferSize(pBufferSize)
      => ComCall(8, this.p, UInt32.Ptr, pBufferSize)
}
struct MSP_ADDRESS_EVENT extends Int32 {
    static ADDRESS_TERMINAL_AVAILABLE := 0
    static ADDRESS_TERMINAL_UNAVAILABLE := 1
}
struct MSP_CALL_EVENT extends Int32 {
    static CALL_NEW_STREAM := 0
    static CALL_STREAM_FAIL := 1
    static CALL_TERMINAL_FAIL := 2
    static CALL_STREAM_NOT_USED := 3
    static CALL_STREAM_ACTIVE := 4
    static CALL_STREAM_INACTIVE := 5
}
struct MSP_CALL_EVENT_CAUSE extends Int32 {
    static CALL_CAUSE_UNKNOWN := 0
    static CALL_CAUSE_BAD_DEVICE := 1
    static CALL_CAUSE_CONNECT_FAIL := 2
    static CALL_CAUSE_LOCAL_REQUEST := 3
    static CALL_CAUSE_REMOTE_REQUEST := 4
    static CALL_CAUSE_MEDIA_TIMEOUT := 5
    static CALL_CAUSE_MEDIA_RECOVERED := 6
    static CALL_CAUSE_QUALITY_OF_SERVICE := 7
}
struct MSP_EVENT extends Int32 {
    static ME_ADDRESS_EVENT := 0
    static ME_CALL_EVENT := 1
    static ME_TSP_DATA := 2
    static ME_PRIVATE_EVENT := 3
    static ME_ASR_TERMINAL_EVENT := 4
    static ME_TTS_TERMINAL_EVENT := 5
    static ME_FILE_TERMINAL_EVENT := 6
    static ME_TONE_TERMINAL_EVENT := 7
}
struct MSP_EVENT_INFO {
    dwSize : UInt32
    Event : MSP_EVENT
    hCall : Int32.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MSP_ADDRESS_EVENT_INFO : this._MSP_ADDRESS_EVENT_INFO_e__Struct
            MSP_CALL_EVENT_INFO : this._MSP_CALL_EVENT_INFO_e__Struct
            MSP_TSP_DATA : this._MSP_TSP_DATA_e__Struct
            MSP_PRIVATE_EVENT_INFO : this._MSP_PRIVATE_EVENT_INFO_e__Struct
            MSP_FILE_TERMINAL_EVENT_INFO : this._MSP_FILE_TERMINAL_EVENT_INFO_e__Struct
            MSP_ASR_TERMINAL_EVENT_INFO : this._MSP_ASR_TERMINAL_EVENT_INFO_e__Struct
            MSP_TTS_TERMINAL_EVENT_INFO : this._MSP_TTS_TERMINAL_EVENT_INFO_e__Struct
            MSP_TONE_TERMINAL_EVENT_INFO : this._MSP_TONE_TERMINAL_EVENT_INFO_e__Struct
        }
        struct _MSP_ADDRESS_EVENT_INFO_e__Struct {
            Type : MSP_ADDRESS_EVENT
            pTerminal : ITTerminal
        }
        struct _MSP_CALL_EVENT_INFO_e__Struct {
            Type : MSP_CALL_EVENT
            Cause : MSP_CALL_EVENT_CAUSE
            pStream : ITStream
            pTerminal : ITTerminal
            hrError : HRESULT
        }
        struct _MSP_TSP_DATA_e__Struct {
            dwBufferSize : UInt32
            pBuffer : UInt8[1]
        }
        struct _MSP_PRIVATE_EVENT_INFO_e__Struct {
            pEvent : IDispatch
            lEventCode : Int32
        }
        struct _MSP_FILE_TERMINAL_EVENT_INFO_e__Struct {
            pParentFileTerminal : ITTerminal
            pFileTrack : ITFileTrack
            TerminalMediaState : TERMINAL_MEDIA_STATE
            ftecEventCause : FT_STATE_EVENT_CAUSE
            hrErrorCode : HRESULT
        }
        struct _MSP_ASR_TERMINAL_EVENT_INFO_e__Struct {
            pASRTerminal : ITTerminal
            hrErrorCode : HRESULT
        }
        struct _MSP_TTS_TERMINAL_EVENT_INFO_e__Struct {
            pTTSTerminal : ITTerminal
            hrErrorCode : HRESULT
        }
        struct _MSP_TONE_TERMINAL_EVENT_INFO_e__Struct {
            pToneTerminal : ITTerminal
            hrErrorCode : HRESULT
        }
    }
}
struct ITPluggableTerminalEventSink extends IUnknown {
    static IID := "{6E0887BE-BA1A-492E-BD10-4020EC5E33E0}"
    FireEvent(pMspEventInfo)
      => ComCall(3, this.p, MSP_EVENT_INFO.Ptr, pMspEventInfo)
}
struct ITPluggableTerminalEventSinkRegistration extends IUnknown {
    static IID := "{F7115709-A216-4957-A759-060AB32A90D1}"
    RegisterSink(pEventSink?)
      => ComCall(3, this.p, ITPluggableTerminalEventSink, pEventSink?)
    UnregisterSink()
      => ComCall(4, this.p)
}
struct ITMSPAddress extends IUnknown {
    static IID := "{EE3BD600-3868-11D2-A045-00C04FB6809F}"
    Initialize(hEvent)
      => ComCall(3, this.p, Int32.Ptr, hEvent)
    Shutdown()
      => ComCall(4, this.p)
    CreateMSPCall(hCall, dwReserved, dwMediaType, pOuterUnknown?, ppStreamControl)
      => ComCall(5, this.p, Int32.Ptr, hCall, UInt32, dwReserved, UInt32, dwMediaType, IUnknown, pOuterUnknown?, IUnknown.Ptr, ppStreamControl)
    ShutdownMSPCall(pStreamControl?)
      => ComCall(6, this.p, IUnknown, pStreamControl?)
    ReceiveTSPData(pMSPCall?, pBuffer)
      => ComCall(7, this.p, IUnknown, pMSPCall?, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length)
    GetEvent(pEventBuffer)
      => ComCall(8, this.p, UInt32.Ptr, pEventBuffer.Length, UInt8.Ptr, pEventBuffer)
}
struct ITTAPIDispatchEventNotification extends IDispatch {
    static IID := "{9F34325B-7E62-11D2-9457-00C04F8EC888}"
}
struct DIRECTORY_TYPE extends Int32 {
    static DT_NTDS := 1
    static DT_ILS := 2
}
struct DIRECTORY_OBJECT_TYPE extends Int32 {
    static OT_CONFERENCE := 1
    static OT_USER := 2
}
struct RND_ADVERTISING_SCOPE extends Int32 {
    static RAS_LOCAL := 1
    static RAS_SITE := 2
    static RAS_REGION := 3
    static RAS_WORLD := 4
}
struct ITDirectoryObjectConference extends IDispatch {
    static IID := "{F1029E5D-CB5B-11D0-8D59-00C04FD91AC0}"
    get_Protocol(ppProtocol)
      => ComCall(7, this.p, BSTR.Ptr, ppProtocol)
    get_Originator(ppOriginator)
      => ComCall(8, this.p, BSTR.Ptr, ppOriginator)
    put_Originator(pOriginator)
      => ComCall(9, this.p, BSTR, pOriginator)
    get_AdvertisingScope(pAdvertisingScope)
      => ComCall(10, this.p, RND_ADVERTISING_SCOPE.Ptr, pAdvertisingScope)
    put_AdvertisingScope(AdvertisingScope)
      => ComCall(11, this.p, RND_ADVERTISING_SCOPE, AdvertisingScope)
    get_Url(ppUrl)
      => ComCall(12, this.p, BSTR.Ptr, ppUrl)
    put_Url(pUrl)
      => ComCall(13, this.p, BSTR, pUrl)
    get_Description(ppDescription)
      => ComCall(14, this.p, BSTR.Ptr, ppDescription)
    put_Description(pDescription)
      => ComCall(15, this.p, BSTR, pDescription)
    get_IsEncrypted(pfEncrypted)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pfEncrypted)
    put_IsEncrypted(fEncrypted)
      => ComCall(17, this.p, VARIANT_BOOL, fEncrypted)
    get_StartTime(pDate)
      => ComCall(18, this.p, Float64.Ptr, pDate)
    put_StartTime(Date)
      => ComCall(19, this.p, Float64, Date)
    get_StopTime(pDate)
      => ComCall(20, this.p, Float64.Ptr, pDate)
    put_StopTime(Date)
      => ComCall(21, this.p, Float64, Date)
}
struct ITDirectoryObjectUser extends IDispatch {
    static IID := "{34621D6F-6CFF-11D1-AFF7-00C04FC31FEE}"
    get_IPPhonePrimary(ppName)
      => ComCall(7, this.p, BSTR.Ptr, ppName)
    put_IPPhonePrimary(pName)
      => ComCall(8, this.p, BSTR, pName)
}
struct IEnumDialableAddrs extends IUnknown {
    static IID := "{34621D70-6CFF-11D1-AFF7-00C04FC31FEE}"
    Next(ppElements, pcFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, BSTR.Ptr, ppElements, UInt32.Ptr, pcFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDialableAddrs.Ptr, ppEnum)
}
struct ITDirectoryObject extends IDispatch {
    static IID := "{34621D6E-6CFF-11D1-AFF7-00C04FC31FEE}"
    get_ObjectType(pObjectType)
      => ComCall(7, this.p, DIRECTORY_OBJECT_TYPE.Ptr, pObjectType)
    get_Name(ppName)
      => ComCall(8, this.p, BSTR.Ptr, ppName)
    put_Name(pName)
      => ComCall(9, this.p, BSTR, pName)
    get_DialableAddrs(dwAddressType, pVariant)
      => ComCall(10, this.p, Int32, dwAddressType, VARIANT.Ptr, pVariant)
    EnumerateDialableAddrs(dwAddressType, ppEnumDialableAddrs)
      => ComCall(11, this.p, UInt32, dwAddressType, IEnumDialableAddrs.Ptr, ppEnumDialableAddrs)
    get_SecurityDescriptor(ppSecDes)
      => ComCall(12, this.p, IDispatch.Ptr, ppSecDes)
    put_SecurityDescriptor(pSecDes)
      => ComCall(13, this.p, IDispatch, pSecDes)
}
struct IEnumDirectoryObject extends IUnknown {
    static IID := "{06C9B64A-306D-11D1-9774-00C04FD91AC0}"
    Next(pVal, pcFetched?)
      => ComCall(3, this.p, UInt32, pVal.Length, ITDirectoryObject.Ptr, pVal, UInt32.Ptr, pcFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDirectoryObject.Ptr, ppEnum)
}
struct ITILSConfig extends IDispatch {
    static IID := "{34621D72-6CFF-11D1-AFF7-00C04FC31FEE}"
    get_Port(pPort)
      => ComCall(7, this.p, Int32.Ptr, pPort)
    put_Port(Port)
      => ComCall(8, this.p, Int32, Port)
}
struct ITDirectory extends IDispatch {
    static IID := "{34621D6C-6CFF-11D1-AFF7-00C04FC31FEE}"
    get_DirectoryType(pDirectoryType)
      => ComCall(7, this.p, DIRECTORY_TYPE.Ptr, pDirectoryType)
    get_DisplayName(pName)
      => ComCall(8, this.p, BSTR.Ptr, pName)
    get_IsDynamic(pfDynamic)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pfDynamic)
    get_DefaultObjectTTL(pTTL)
      => ComCall(10, this.p, Int32.Ptr, pTTL)
    put_DefaultObjectTTL(TTL)
      => ComCall(11, this.p, Int32, TTL)
    EnableAutoRefresh(fEnable)
      => ComCall(12, this.p, VARIANT_BOOL, fEnable)
    Connect(fSecure)
      => ComCall(13, this.p, VARIANT_BOOL, fSecure)
    Bind(pDomainName, pUserName, pPassword, lFlags)
      => ComCall(14, this.p, BSTR, pDomainName, BSTR, pUserName, BSTR, pPassword, Int32, lFlags)
    AddDirectoryObject(pDirectoryObject)
      => ComCall(15, this.p, ITDirectoryObject, pDirectoryObject)
    ModifyDirectoryObject(pDirectoryObject)
      => ComCall(16, this.p, ITDirectoryObject, pDirectoryObject)
    RefreshDirectoryObject(pDirectoryObject)
      => ComCall(17, this.p, ITDirectoryObject, pDirectoryObject)
    DeleteDirectoryObject(pDirectoryObject)
      => ComCall(18, this.p, ITDirectoryObject, pDirectoryObject)
    get_DirectoryObjects(DirectoryObjectType, pName, pVariant)
      => ComCall(19, this.p, DIRECTORY_OBJECT_TYPE, DirectoryObjectType, BSTR, pName, VARIANT.Ptr, pVariant)
    EnumerateDirectoryObjects(DirectoryObjectType, pName, ppEnumObject)
      => ComCall(20, this.p, DIRECTORY_OBJECT_TYPE, DirectoryObjectType, BSTR, pName, IEnumDirectoryObject.Ptr, ppEnumObject)
}
struct IEnumDirectory extends IUnknown {
    static IID := "{34621D6D-6CFF-11D1-AFF7-00C04FC31FEE}"
    Next(ppElements, pcFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, ITDirectory.Ptr, ppElements, UInt32.Ptr, pcFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDirectory.Ptr, ppEnum)
}
struct ITRendezvous extends IDispatch {
    static IID := "{34621D6B-6CFF-11D1-AFF7-00C04FC31FEE}"
    get_DefaultDirectories(pVariant)
      => ComCall(7, this.p, VARIANT.Ptr, pVariant)
    EnumerateDefaultDirectories(ppEnumDirectory)
      => ComCall(8, this.p, IEnumDirectory.Ptr, ppEnumDirectory)
    CreateDirectory(DirectoryType, pName, ppDir)
      => ComCall(9, this.p, DIRECTORY_TYPE, DirectoryType, BSTR, pName, ITDirectory.Ptr, ppDir)
    CreateDirectoryObject(DirectoryObjectType, pName, ppDirectoryObject)
      => ComCall(10, this.p, DIRECTORY_OBJECT_TYPE, DirectoryObjectType, BSTR, pName, ITDirectoryObject.Ptr, ppDirectoryObject)
}
struct IMcastScope extends IDispatch {
    static IID := "{DF0DAEF4-A289-11D1-8697-006008B0E5D2}"
    get_ScopeID(pID)
      => ComCall(7, this.p, Int32.Ptr, pID)
    get_ServerID(pID)
      => ComCall(8, this.p, Int32.Ptr, pID)
    get_InterfaceID(pID)
      => ComCall(9, this.p, Int32.Ptr, pID)
    get_ScopeDescription(ppDescription)
      => ComCall(10, this.p, BSTR.Ptr, ppDescription)
    get_TTL(pTTL)
      => ComCall(11, this.p, Int32.Ptr, pTTL)
}
struct IMcastLeaseInfo extends IDispatch {
    static IID := "{DF0DAEFD-A289-11D1-8697-006008B0E5D2}"
    get_RequestID(ppRequestID)
      => ComCall(7, this.p, BSTR.Ptr, ppRequestID)
    get_LeaseStartTime(pTime)
      => ComCall(8, this.p, Float64.Ptr, pTime)
    put_LeaseStartTime(time)
      => ComCall(9, this.p, Float64, time)
    get_LeaseStopTime(pTime)
      => ComCall(10, this.p, Float64.Ptr, pTime)
    put_LeaseStopTime(time)
      => ComCall(11, this.p, Float64, time)
    get_AddressCount(pCount)
      => ComCall(12, this.p, Int32.Ptr, pCount)
    get_ServerAddress(ppAddress)
      => ComCall(13, this.p, BSTR.Ptr, ppAddress)
    get_TTL(pTTL)
      => ComCall(14, this.p, Int32.Ptr, pTTL)
    get_Addresses(pVariant)
      => ComCall(15, this.p, VARIANT.Ptr, pVariant)
    EnumerateAddresses(ppEnumAddresses)
      => ComCall(16, this.p, IEnumBstr.Ptr, ppEnumAddresses)
}
struct IEnumMcastScope extends IUnknown {
    static IID := "{DF0DAF09-A289-11D1-8697-006008B0E5D2}"
    Next(celt, ppScopes, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, IMcastScope.Ptr, ppScopes, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumMcastScope.Ptr, ppEnum)
}
struct IMcastAddressAllocation extends IDispatch {
    static IID := "{DF0DAEF1-A289-11D1-8697-006008B0E5D2}"
    get_Scopes(pVariant)
      => ComCall(7, this.p, VARIANT.Ptr, pVariant)
    EnumerateScopes(ppEnumMcastScope)
      => ComCall(8, this.p, IEnumMcastScope.Ptr, ppEnumMcastScope)
    RequestAddress(pScope?, LeaseStartTime, LeaseStopTime, NumAddresses, ppLeaseResponse)
      => ComCall(9, this.p, IMcastScope, pScope?, Float64, LeaseStartTime, Float64, LeaseStopTime, Int32, NumAddresses, IMcastLeaseInfo.Ptr, ppLeaseResponse)
    RenewAddress(lReserved, pRenewRequest?, ppRenewResponse)
      => ComCall(10, this.p, Int32, lReserved, IMcastLeaseInfo, pRenewRequest?, IMcastLeaseInfo.Ptr, ppRenewResponse)
    ReleaseAddress(pReleaseRequest?)
      => ComCall(11, this.p, IMcastLeaseInfo, pReleaseRequest?)
    CreateLeaseInfo(LeaseStartTime, LeaseStopTime, dwNumAddresses, ppAddresses, pRequestID, pServerAddress, ppReleaseRequest)
      => ComCall(12, this.p, Float64, LeaseStartTime, Float64, LeaseStopTime, UInt32, dwNumAddresses, PWSTR.Ptr, ppAddresses, "Str", pRequestID, "Str", pServerAddress, IMcastLeaseInfo.Ptr, ppReleaseRequest)
    CreateLeaseInfoFromVariant(LeaseStartTime, LeaseStopTime, vAddresses, pRequestID, pServerAddress, ppReleaseRequest)
      => ComCall(13, this.p, Float64, LeaseStartTime, Float64, LeaseStopTime, VARIANT, vAddresses, BSTR, pRequestID, BSTR, pServerAddress, IMcastLeaseInfo.Ptr, ppReleaseRequest)
}
struct STnefProblem {
    ulComponent : UInt32
    ulAttribute : UInt32
    ulPropTag : UInt32
    scode : Int32
}
struct STnefProblemArray {
    cProblem : UInt32
    aProblem : STnefProblem[1]
}
struct ITnef extends IUnknown {
    AddProps(ulFlags, ulElemID, lpvData, lpPropList)
      => ComCall(3, this.p, UInt32, ulFlags, UInt32, ulElemID, Struct.Ptr, lpvData, SPropTagArray.Ptr, lpPropList)
    ExtractProps(ulFlags, lpPropList, lpProblems)
      => ComCall(4, this.p, UInt32, ulFlags, SPropTagArray.Ptr, lpPropList, STnefProblemArray.Ptr.Ptr, lpProblems)
    Finish(ulFlags, lpKey, lpProblems)
      => ComCall(5, this.p, UInt32, ulFlags, UInt16.Ptr, lpKey, STnefProblemArray.Ptr.Ptr, lpProblems)
    OpenTaggedBody(lpMessage, ulFlags, lppStream)
      => ComCall(6, this.p, IMessage, lpMessage, UInt32, ulFlags, IStream.Ptr, lppStream)
    SetProps(ulFlags, ulElemID, cValues, lpProps)
      => ComCall(7, this.p, UInt32, ulFlags, UInt32, ulElemID, UInt32, cValues, SPropValue.Ptr, lpProps)
    EncodeRecips(ulFlags, lpRecipientTable)
      => ComCall(8, this.p, UInt32, ulFlags, IMAPITable, lpRecipientTable)
    FinishComponent(ulFlags, ulComponentID, lpCustomPropList, lpCustomProps, lpPropList, lpProblems)
      => ComCall(9, this.p, UInt32, ulFlags, UInt32, ulComponentID, SPropTagArray.Ptr, lpCustomPropList, SPropValue.Ptr, lpCustomProps, SPropTagArray.Ptr, lpPropList, STnefProblemArray.Ptr.Ptr, lpProblems)
}
struct LPOPENTNEFSTREAM extends FunctionPointer {
    static Types := [Struct.Ptr, IStream, Int8.Ptr, UInt32, IMessage, UInt16, ITnef.Ptr, HRESULT]
}
struct LPOPENTNEFSTREAMEX extends FunctionPointer {
    static Types := [Struct.Ptr, IStream, Int8.Ptr, UInt32, IMessage, UInt16, IAddrBook, ITnef.Ptr, HRESULT]
}
struct LPGETTNEFSTREAMCODEPAGE extends FunctionPointer {
    static Types := [IStream, UInt32.Ptr, UInt32.Ptr, HRESULT]
}
struct RENDDATA {
    atyp : UInt16
    ulPosition : UInt32
    dxWidth : UInt16
    dyHeight : UInt16
    dwFlags : UInt32
}
struct DTR {
    wYear : UInt16
    wMonth : UInt16
    wDay : UInt16
    wHour : UInt16
    wMinute : UInt16
    wSecond : UInt16
    wDayOfWeek : UInt16
}
struct TRP {
    trpid : UInt16
    cbgrtrp : UInt16
    cch : UInt16
    cbRgb : UInt16
}
struct ADDRALIAS {
    rgchName : CHAR[41]
    rgchEName : CHAR[11]
    rgchSrvr : CHAR[12]
    dibDetail : UInt32
    type : UInt16
}
struct NSID {
    dwSize : UInt32
    uchType : UInt8[16]
    xtype : UInt32
    lTime : Int32
    address : this._address_e__Union
    struct _address_e__Union {
        union {
            alias : ADDRALIAS
            rgchInterNet : CHAR[1]
        }
    }
}
