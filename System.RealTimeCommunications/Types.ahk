#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\Media.DirectShow\Types.ahk" {IVideoWindow}
#Import "..\Networking.WinSock\Types.ahk" {TRANSPORT_SETTING_ID}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct RTC_AUDIO_DEVICE extends Int32 {
    static RTCAD_SPEAKER := 0
    static RTCAD_MICROPHONE := 1
}
struct RTC_VIDEO_DEVICE extends Int32 {
    static RTCVD_RECEIVE := 0
    static RTCVD_PREVIEW := 1
}
struct RTC_EVENT extends Int32 {
    static RTCE_CLIENT := 0
    static RTCE_REGISTRATION_STATE_CHANGE := 1
    static RTCE_SESSION_STATE_CHANGE := 2
    static RTCE_SESSION_OPERATION_COMPLETE := 3
    static RTCE_PARTICIPANT_STATE_CHANGE := 4
    static RTCE_MEDIA := 5
    static RTCE_INTENSITY := 6
    static RTCE_MESSAGING := 7
    static RTCE_BUDDY := 8
    static RTCE_WATCHER := 9
    static RTCE_PROFILE := 10
    static RTCE_USERSEARCH := 11
    static RTCE_INFO := 12
    static RTCE_GROUP := 13
    static RTCE_MEDIA_REQUEST := 14
    static RTCE_ROAMING := 15
    static RTCE_PRESENCE_PROPERTY := 16
    static RTCE_PRESENCE_DATA := 17
    static RTCE_PRESENCE_STATUS := 18
    static RTCE_SESSION_REFER_STATUS := 19
    static RTCE_SESSION_REFERRED := 20
    static RTCE_REINVITE := 21
}
struct RTC_LISTEN_MODE extends Int32 {
    static RTCLM_NONE := 0
    static RTCLM_DYNAMIC := 1
    static RTCLM_BOTH := 2
}
struct RTC_CLIENT_EVENT_TYPE extends Int32 {
    static RTCCET_VOLUME_CHANGE := 0
    static RTCCET_DEVICE_CHANGE := 1
    static RTCCET_NETWORK_QUALITY_CHANGE := 2
    static RTCCET_ASYNC_CLEANUP_DONE := 3
}
struct RTC_BUDDY_EVENT_TYPE extends Int32 {
    static RTCBET_BUDDY_ADD := 0
    static RTCBET_BUDDY_REMOVE := 1
    static RTCBET_BUDDY_UPDATE := 2
    static RTCBET_BUDDY_STATE_CHANGE := 3
    static RTCBET_BUDDY_ROAMED := 4
    static RTCBET_BUDDY_SUBSCRIBED := 5
}
struct RTC_WATCHER_EVENT_TYPE extends Int32 {
    static RTCWET_WATCHER_ADD := 0
    static RTCWET_WATCHER_REMOVE := 1
    static RTCWET_WATCHER_UPDATE := 2
    static RTCWET_WATCHER_OFFERING := 3
    static RTCWET_WATCHER_ROAMED := 4
}
struct RTC_GROUP_EVENT_TYPE extends Int32 {
    static RTCGET_GROUP_ADD := 0
    static RTCGET_GROUP_REMOVE := 1
    static RTCGET_GROUP_UPDATE := 2
    static RTCGET_GROUP_BUDDY_ADD := 3
    static RTCGET_GROUP_BUDDY_REMOVE := 4
    static RTCGET_GROUP_ROAMED := 5
}
struct RTC_TERMINATE_REASON extends Int32 {
    static RTCTR_NORMAL := 0
    static RTCTR_DND := 1
    static RTCTR_BUSY := 2
    static RTCTR_REJECT := 3
    static RTCTR_TIMEOUT := 4
    static RTCTR_SHUTDOWN := 5
    static RTCTR_INSUFFICIENT_SECURITY_LEVEL := 6
    static RTCTR_NOT_SUPPORTED := 7
}
struct RTC_REGISTRATION_STATE extends Int32 {
    static RTCRS_NOT_REGISTERED := 0
    static RTCRS_REGISTERING := 1
    static RTCRS_REGISTERED := 2
    static RTCRS_REJECTED := 3
    static RTCRS_UNREGISTERING := 4
    static RTCRS_ERROR := 5
    static RTCRS_LOGGED_OFF := 6
    static RTCRS_LOCAL_PA_LOGGED_OFF := 7
    static RTCRS_REMOTE_PA_LOGGED_OFF := 8
}
struct RTC_SESSION_STATE extends Int32 {
    static RTCSS_IDLE := 0
    static RTCSS_INCOMING := 1
    static RTCSS_ANSWERING := 2
    static RTCSS_INPROGRESS := 3
    static RTCSS_CONNECTED := 4
    static RTCSS_DISCONNECTED := 5
    static RTCSS_HOLD := 6
    static RTCSS_REFER := 7
}
struct RTC_PARTICIPANT_STATE extends Int32 {
    static RTCPS_IDLE := 0
    static RTCPS_PENDING := 1
    static RTCPS_INCOMING := 2
    static RTCPS_ANSWERING := 3
    static RTCPS_INPROGRESS := 4
    static RTCPS_ALERTING := 5
    static RTCPS_CONNECTED := 6
    static RTCPS_DISCONNECTING := 7
    static RTCPS_DISCONNECTED := 8
}
struct RTC_WATCHER_STATE extends Int32 {
    static RTCWS_UNKNOWN := 0
    static RTCWS_OFFERING := 1
    static RTCWS_ALLOWED := 2
    static RTCWS_BLOCKED := 3
    static RTCWS_DENIED := 4
    static RTCWS_PROMPT := 5
}
struct RTC_ACE_SCOPE extends Int32 {
    static RTCAS_SCOPE_USER := 0
    static RTCAS_SCOPE_DOMAIN := 1
    static RTCAS_SCOPE_ALL := 2
}
struct RTC_OFFER_WATCHER_MODE extends Int32 {
    static RTCOWM_OFFER_WATCHER_EVENT := 0
    static RTCOWM_AUTOMATICALLY_ADD_WATCHER := 1
}
struct RTC_WATCHER_MATCH_MODE extends Int32 {
    static RTCWMM_EXACT_MATCH := 0
    static RTCWMM_BEST_ACE_MATCH := 1
}
struct RTC_PRIVACY_MODE extends Int32 {
    static RTCPM_BLOCK_LIST_EXCLUDED := 0
    static RTCPM_ALLOW_LIST_ONLY := 1
}
struct RTC_SESSION_TYPE extends Int32 {
    static RTCST_PC_TO_PC := 0
    static RTCST_PC_TO_PHONE := 1
    static RTCST_PHONE_TO_PHONE := 2
    static RTCST_IM := 3
    static RTCST_MULTIPARTY_IM := 4
    static RTCST_APPLICATION := 5
}
struct RTC_PRESENCE_STATUS extends Int32 {
    static RTCXS_PRESENCE_OFFLINE := 0
    static RTCXS_PRESENCE_ONLINE := 1
    static RTCXS_PRESENCE_AWAY := 2
    static RTCXS_PRESENCE_IDLE := 3
    static RTCXS_PRESENCE_BUSY := 4
    static RTCXS_PRESENCE_BE_RIGHT_BACK := 5
    static RTCXS_PRESENCE_ON_THE_PHONE := 6
    static RTCXS_PRESENCE_OUT_TO_LUNCH := 7
}
struct RTC_BUDDY_SUBSCRIPTION_TYPE extends Int32 {
    static RTCBT_SUBSCRIBED := 0
    static RTCBT_ALWAYS_OFFLINE := 1
    static RTCBT_ALWAYS_ONLINE := 2
    static RTCBT_POLL := 3
}
struct RTC_MEDIA_EVENT_TYPE extends Int32 {
    static RTCMET_STOPPED := 0
    static RTCMET_STARTED := 1
    static RTCMET_FAILED := 2
}
struct RTC_MEDIA_EVENT_REASON extends Int32 {
    static RTCMER_NORMAL := 0
    static RTCMER_HOLD := 1
    static RTCMER_TIMEOUT := 2
    static RTCMER_BAD_DEVICE := 3
    static RTCMER_NO_PORT := 4
    static RTCMER_PORT_MAPPING_FAILED := 5
    static RTCMER_REMOTE_REQUEST := 6
}
struct RTC_MESSAGING_EVENT_TYPE extends Int32 {
    static RTCMSET_MESSAGE := 0
    static RTCMSET_STATUS := 1
}
struct RTC_MESSAGING_USER_STATUS extends Int32 {
    static RTCMUS_IDLE := 0
    static RTCMUS_TYPING := 1
}
struct RTC_DTMF extends Int32 {
    static RTC_DTMF_0 := 0
    static RTC_DTMF_1 := 1
    static RTC_DTMF_2 := 2
    static RTC_DTMF_3 := 3
    static RTC_DTMF_4 := 4
    static RTC_DTMF_5 := 5
    static RTC_DTMF_6 := 6
    static RTC_DTMF_7 := 7
    static RTC_DTMF_8 := 8
    static RTC_DTMF_9 := 9
    static RTC_DTMF_STAR := 10
    static RTC_DTMF_POUND := 11
    static RTC_DTMF_A := 12
    static RTC_DTMF_B := 13
    static RTC_DTMF_C := 14
    static RTC_DTMF_D := 15
    static RTC_DTMF_FLASH := 16
}
struct RTC_PROVIDER_URI extends Int32 {
    static RTCPU_URIHOMEPAGE := 0
    static RTCPU_URIHELPDESK := 1
    static RTCPU_URIPERSONALACCOUNT := 2
    static RTCPU_URIDISPLAYDURINGCALL := 3
    static RTCPU_URIDISPLAYDURINGIDLE := 4
}
struct RTC_RING_TYPE extends Int32 {
    static RTCRT_PHONE := 0
    static RTCRT_MESSAGE := 1
    static RTCRT_RINGBACK := 2
}
struct RTC_T120_APPLET extends Int32 {
    static RTCTA_WHITEBOARD := 0
    static RTCTA_APPSHARING := 1
}
struct RTC_PORT_TYPE extends Int32 {
    static RTCPT_AUDIO_RTP := 0
    static RTCPT_AUDIO_RTCP := 1
    static RTCPT_VIDEO_RTP := 2
    static RTCPT_VIDEO_RTCP := 3
    static RTCPT_SIP := 4
}
struct RTC_USER_SEARCH_COLUMN extends Int32 {
    static RTCUSC_URI := 0
    static RTCUSC_DISPLAYNAME := 1
    static RTCUSC_TITLE := 2
    static RTCUSC_OFFICE := 3
    static RTCUSC_PHONE := 4
    static RTCUSC_COMPANY := 5
    static RTCUSC_CITY := 6
    static RTCUSC_STATE := 7
    static RTCUSC_COUNTRY := 8
    static RTCUSC_EMAIL := 9
}
struct RTC_USER_SEARCH_PREFERENCE extends Int32 {
    static RTCUSP_MAX_MATCHES := 0
    static RTCUSP_TIME_LIMIT := 1
}
struct RTC_ROAMING_EVENT_TYPE extends Int32 {
    static RTCRET_BUDDY_ROAMING := 0
    static RTCRET_WATCHER_ROAMING := 1
    static RTCRET_PRESENCE_ROAMING := 2
    static RTCRET_PROFILE_ROAMING := 3
    static RTCRET_WPENDING_ROAMING := 4
}
struct RTC_PROFILE_EVENT_TYPE extends Int32 {
    static RTCPFET_PROFILE_GET := 0
    static RTCPFET_PROFILE_UPDATE := 1
}
struct RTC_ANSWER_MODE extends Int32 {
    static RTCAM_OFFER_SESSION_EVENT := 0
    static RTCAM_AUTOMATICALLY_ACCEPT := 1
    static RTCAM_AUTOMATICALLY_REJECT := 2
    static RTCAM_NOT_SUPPORTED := 3
}
struct RTC_SESSION_REFER_STATUS extends Int32 {
    static RTCSRS_REFERRING := 0
    static RTCSRS_ACCEPTED := 1
    static RTCSRS_ERROR := 2
    static RTCSRS_REJECTED := 3
    static RTCSRS_DROPPED := 4
    static RTCSRS_DONE := 5
}
struct RTC_PRESENCE_PROPERTY extends Int32 {
    static RTCPP_PHONENUMBER := 0
    static RTCPP_DISPLAYNAME := 1
    static RTCPP_EMAIL := 2
    static RTCPP_DEVICE_NAME := 3
    static RTCPP_MULTIPLE := 4
}
struct RTC_SECURITY_TYPE extends Int32 {
    static RTCSECT_AUDIO_VIDEO_MEDIA_ENCRYPTION := 0
    static RTCSECT_T120_MEDIA_ENCRYPTION := 1
}
struct RTC_SECURITY_LEVEL extends Int32 {
    static RTCSECL_UNSUPPORTED := 1
    static RTCSECL_SUPPORTED := 2
    static RTCSECL_REQUIRED := 3
}
struct RTC_REINVITE_STATE extends Int32 {
    static RTCRIN_INCOMING := 0
    static RTCRIN_SUCCEEDED := 1
    static RTCRIN_FAIL := 2
}
struct IRTCClient extends IUnknown {
    static IID := "{07829E45-9A34-408E-A011-BDDF13487CD1}"
    Initialize()
      => ComCall(3, this.p)
    Shutdown()
      => ComCall(4, this.p)
    PrepareForShutdown()
      => ComCall(5, this.p)
    put_EventFilter(lFilter)
      => ComCall(6, this.p, Int32, lFilter)
    get_EventFilter(plFilter)
      => ComCall(7, this.p, Int32.Ptr, plFilter)
    SetPreferredMediaTypes(lMediaTypes, fPersistent)
      => ComCall(8, this.p, Int32, lMediaTypes, VARIANT_BOOL, fPersistent)
    get_PreferredMediaTypes(plMediaTypes)
      => ComCall(9, this.p, Int32.Ptr, plMediaTypes)
    get_MediaCapabilities(plMediaTypes)
      => ComCall(10, this.p, Int32.Ptr, plMediaTypes)
    CreateSession(enType, bstrLocalPhoneURI, pProfile, lFlags, ppSession)
      => ComCall(11, this.p, RTC_SESSION_TYPE, enType, BSTR, bstrLocalPhoneURI, IRTCProfile, pProfile, Int32, lFlags, IRTCSession.Ptr, ppSession)
    put_ListenForIncomingSessions(enListen)
      => ComCall(12, this.p, RTC_LISTEN_MODE, enListen)
    get_ListenForIncomingSessions(penListen)
      => ComCall(13, this.p, RTC_LISTEN_MODE.Ptr, penListen)
    get_NetworkAddresses(fTCP, fExternal, pvAddresses)
      => ComCall(14, this.p, VARIANT_BOOL, fTCP, VARIANT_BOOL, fExternal, VARIANT.Ptr, pvAddresses)
    put_Volume(enDevice, lVolume)
      => ComCall(15, this.p, RTC_AUDIO_DEVICE, enDevice, Int32, lVolume)
    get_Volume(enDevice, plVolume)
      => ComCall(16, this.p, RTC_AUDIO_DEVICE, enDevice, Int32.Ptr, plVolume)
    put_AudioMuted(enDevice, fMuted)
      => ComCall(17, this.p, RTC_AUDIO_DEVICE, enDevice, VARIANT_BOOL, fMuted)
    get_AudioMuted(enDevice, pfMuted)
      => ComCall(18, this.p, RTC_AUDIO_DEVICE, enDevice, VARIANT_BOOL.Ptr, pfMuted)
    get_IVideoWindow(enDevice, ppIVideoWindow)
      => ComCall(19, this.p, RTC_VIDEO_DEVICE, enDevice, IVideoWindow.Ptr, ppIVideoWindow)
    put_PreferredAudioDevice(enDevice, bstrDeviceName)
      => ComCall(20, this.p, RTC_AUDIO_DEVICE, enDevice, BSTR, bstrDeviceName)
    get_PreferredAudioDevice(enDevice, pbstrDeviceName)
      => ComCall(21, this.p, RTC_AUDIO_DEVICE, enDevice, BSTR.Ptr, pbstrDeviceName)
    put_PreferredVolume(enDevice, lVolume)
      => ComCall(22, this.p, RTC_AUDIO_DEVICE, enDevice, Int32, lVolume)
    get_PreferredVolume(enDevice, plVolume)
      => ComCall(23, this.p, RTC_AUDIO_DEVICE, enDevice, Int32.Ptr, plVolume)
    put_PreferredAEC(bEnable)
      => ComCall(24, this.p, VARIANT_BOOL, bEnable)
    get_PreferredAEC(pbEnabled)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_PreferredVideoDevice(bstrDeviceName)
      => ComCall(26, this.p, BSTR, bstrDeviceName)
    get_PreferredVideoDevice(pbstrDeviceName)
      => ComCall(27, this.p, BSTR.Ptr, pbstrDeviceName)
    get_ActiveMedia(plMediaType)
      => ComCall(28, this.p, Int32.Ptr, plMediaType)
    put_MaxBitrate(lMaxBitrate)
      => ComCall(29, this.p, Int32, lMaxBitrate)
    get_MaxBitrate(plMaxBitrate)
      => ComCall(30, this.p, Int32.Ptr, plMaxBitrate)
    put_TemporalSpatialTradeOff(lValue)
      => ComCall(31, this.p, Int32, lValue)
    get_TemporalSpatialTradeOff(plValue)
      => ComCall(32, this.p, Int32.Ptr, plValue)
    get_NetworkQuality(plNetworkQuality)
      => ComCall(33, this.p, Int32.Ptr, plNetworkQuality)
    StartT120Applet(enApplet)
      => ComCall(34, this.p, RTC_T120_APPLET, enApplet)
    StopT120Applets()
      => ComCall(35, this.p)
    get_IsT120AppletRunning(enApplet, pfRunning)
      => ComCall(36, this.p, RTC_T120_APPLET, enApplet, VARIANT_BOOL.Ptr, pfRunning)
    get_LocalUserURI(pbstrUserURI)
      => ComCall(37, this.p, BSTR.Ptr, pbstrUserURI)
    put_LocalUserURI(bstrUserURI)
      => ComCall(38, this.p, BSTR, bstrUserURI)
    get_LocalUserName(pbstrUserName)
      => ComCall(39, this.p, BSTR.Ptr, pbstrUserName)
    put_LocalUserName(bstrUserName)
      => ComCall(40, this.p, BSTR, bstrUserName)
    PlayRing(enType, bPlay)
      => ComCall(41, this.p, RTC_RING_TYPE, enType, VARIANT_BOOL, bPlay)
    SendDTMF(enDTMF)
      => ComCall(42, this.p, RTC_DTMF, enDTMF)
    InvokeTuningWizard(hwndParent)
      => ComCall(43, this.p, IntPtr, hwndParent)
    get_IsTuned(pfTuned)
      => ComCall(44, this.p, VARIANT_BOOL.Ptr, pfTuned)
}
struct IRTCClient2 extends IRTCClient {
    static IID := "{0C91D71D-1064-42DA-BFA5-572BEB8EEA84}"
    put_AnswerMode(enType, enMode)
      => ComCall(45, this.p, RTC_SESSION_TYPE, enType, RTC_ANSWER_MODE, enMode)
    get_AnswerMode(enType, penMode)
      => ComCall(46, this.p, RTC_SESSION_TYPE, enType, RTC_ANSWER_MODE.Ptr, penMode)
    InvokeTuningWizardEx(hwndParent, fAllowAudio, fAllowVideo)
      => ComCall(47, this.p, IntPtr, hwndParent, VARIANT_BOOL, fAllowAudio, VARIANT_BOOL, fAllowVideo)
    get_Version(plVersion)
      => ComCall(48, this.p, Int32.Ptr, plVersion)
    put_ClientName(bstrClientName)
      => ComCall(49, this.p, BSTR, bstrClientName)
    put_ClientCurVer(bstrClientCurVer)
      => ComCall(50, this.p, BSTR, bstrClientCurVer)
    InitializeEx(lFlags)
      => ComCall(51, this.p, Int32, lFlags)
    CreateSessionWithDescription(bstrContentType, bstrSessionDescription, pProfile, lFlags, ppSession2)
      => ComCall(52, this.p, BSTR, bstrContentType, BSTR, bstrSessionDescription, IRTCProfile, pProfile, Int32, lFlags, IRTCSession2.Ptr, ppSession2)
    SetSessionDescriptionManager(pSessionDescriptionManager)
      => ComCall(53, this.p, IRTCSessionDescriptionManager, pSessionDescriptionManager)
    put_PreferredSecurityLevel(enSecurityType, enSecurityLevel)
      => ComCall(54, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL, enSecurityLevel)
    get_PreferredSecurityLevel(enSecurityType, penSecurityLevel)
      => ComCall(55, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL.Ptr, penSecurityLevel)
    put_AllowedPorts(lTransport, enListenMode)
      => ComCall(56, this.p, Int32, lTransport, RTC_LISTEN_MODE, enListenMode)
    get_AllowedPorts(lTransport, penListenMode)
      => ComCall(57, this.p, Int32, lTransport, RTC_LISTEN_MODE.Ptr, penListenMode)
}
struct IRTCClientPresence extends IUnknown {
    static IID := "{11C3CBCC-0744-42D1-968A-51AA1BB274C6}"
    EnablePresence(fUseStorage, varStorage)
      => ComCall(3, this.p, VARIANT_BOOL, fUseStorage, VARIANT, varStorage)
    Export(varStorage)
      => ComCall(4, this.p, VARIANT, varStorage)
    Import(varStorage, fReplaceAll)
      => ComCall(5, this.p, VARIANT, varStorage, VARIANT_BOOL, fReplaceAll)
    EnumerateBuddies(ppEnum)
      => ComCall(6, this.p, IRTCEnumBuddies.Ptr, ppEnum)
    get_Buddies(ppCollection)
      => ComCall(7, this.p, IRTCCollection.Ptr, ppCollection)
    get_Buddy(bstrPresentityURI, ppBuddy)
      => ComCall(8, this.p, BSTR, bstrPresentityURI, IRTCBuddy.Ptr, ppBuddy)
    AddBuddy(bstrPresentityURI, bstrUserName, bstrData, fPersistent, pProfile, lFlags, ppBuddy)
      => ComCall(9, this.p, BSTR, bstrPresentityURI, BSTR, bstrUserName, BSTR, bstrData, VARIANT_BOOL, fPersistent, IRTCProfile, pProfile, Int32, lFlags, IRTCBuddy.Ptr, ppBuddy)
    RemoveBuddy(pBuddy)
      => ComCall(10, this.p, IRTCBuddy, pBuddy)
    EnumerateWatchers(ppEnum)
      => ComCall(11, this.p, IRTCEnumWatchers.Ptr, ppEnum)
    get_Watchers(ppCollection)
      => ComCall(12, this.p, IRTCCollection.Ptr, ppCollection)
    get_Watcher(bstrPresentityURI, ppWatcher)
      => ComCall(13, this.p, BSTR, bstrPresentityURI, IRTCWatcher.Ptr, ppWatcher)
    AddWatcher(bstrPresentityURI, bstrUserName, bstrData, fBlocked, fPersistent, ppWatcher)
      => ComCall(14, this.p, BSTR, bstrPresentityURI, BSTR, bstrUserName, BSTR, bstrData, VARIANT_BOOL, fBlocked, VARIANT_BOOL, fPersistent, IRTCWatcher.Ptr, ppWatcher)
    RemoveWatcher(pWatcher)
      => ComCall(15, this.p, IRTCWatcher, pWatcher)
    SetLocalPresenceInfo(enStatus, bstrNotes)
      => ComCall(16, this.p, RTC_PRESENCE_STATUS, enStatus, BSTR, bstrNotes)
    get_OfferWatcherMode(penMode)
      => ComCall(17, this.p, RTC_OFFER_WATCHER_MODE.Ptr, penMode)
    put_OfferWatcherMode(enMode)
      => ComCall(18, this.p, RTC_OFFER_WATCHER_MODE, enMode)
    get_PrivacyMode(penMode)
      => ComCall(19, this.p, RTC_PRIVACY_MODE.Ptr, penMode)
    put_PrivacyMode(enMode)
      => ComCall(20, this.p, RTC_PRIVACY_MODE, enMode)
}
struct IRTCClientPresence2 extends IRTCClientPresence {
    static IID := "{AD1809E8-62F7-4783-909A-29C9D2CB1D34}"
    EnablePresenceEx(pProfile, varStorage, lFlags)
      => ComCall(21, this.p, IRTCProfile, pProfile, VARIANT, varStorage, Int32, lFlags)
    DisablePresence()
      => ComCall(22, this.p)
    AddGroup(bstrGroupName, bstrData, pProfile, lFlags, ppGroup)
      => ComCall(23, this.p, BSTR, bstrGroupName, BSTR, bstrData, IRTCProfile, pProfile, Int32, lFlags, IRTCBuddyGroup.Ptr, ppGroup)
    RemoveGroup(pGroup)
      => ComCall(24, this.p, IRTCBuddyGroup, pGroup)
    EnumerateGroups(ppEnum)
      => ComCall(25, this.p, IRTCEnumGroups.Ptr, ppEnum)
    get_Groups(ppCollection)
      => ComCall(26, this.p, IRTCCollection.Ptr, ppCollection)
    get_Group(bstrGroupName, ppGroup)
      => ComCall(27, this.p, BSTR, bstrGroupName, IRTCBuddyGroup.Ptr, ppGroup)
    AddWatcherEx(bstrPresentityURI, bstrUserName, bstrData, enState, fPersistent, enScope, pProfile, lFlags, ppWatcher)
      => ComCall(28, this.p, BSTR, bstrPresentityURI, BSTR, bstrUserName, BSTR, bstrData, RTC_WATCHER_STATE, enState, VARIANT_BOOL, fPersistent, RTC_ACE_SCOPE, enScope, IRTCProfile, pProfile, Int32, lFlags, IRTCWatcher2.Ptr, ppWatcher)
    get_WatcherEx(enMode, bstrPresentityURI, ppWatcher)
      => ComCall(29, this.p, RTC_WATCHER_MATCH_MODE, enMode, BSTR, bstrPresentityURI, IRTCWatcher2.Ptr, ppWatcher)
    put_PresenceProperty(enProperty, bstrProperty)
      => ComCall(30, this.p, RTC_PRESENCE_PROPERTY, enProperty, BSTR, bstrProperty)
    get_PresenceProperty(enProperty, pbstrProperty)
      => ComCall(31, this.p, RTC_PRESENCE_PROPERTY, enProperty, BSTR.Ptr, pbstrProperty)
    SetPresenceData(bstrNamespace, bstrData)
      => ComCall(32, this.p, BSTR, bstrNamespace, BSTR, bstrData)
    GetPresenceData(pbstrNamespace, pbstrData)
      => ComCall(33, this.p, BSTR.Ptr, pbstrNamespace, BSTR.Ptr, pbstrData)
    GetLocalPresenceInfo(penStatus, pbstrNotes)
      => ComCall(34, this.p, RTC_PRESENCE_STATUS.Ptr, penStatus, BSTR.Ptr, pbstrNotes)
    AddBuddyEx(bstrPresentityURI, bstrUserName, bstrData, fPersistent, enSubscriptionType, pProfile, lFlags, ppBuddy)
      => ComCall(35, this.p, BSTR, bstrPresentityURI, BSTR, bstrUserName, BSTR, bstrData, VARIANT_BOOL, fPersistent, RTC_BUDDY_SUBSCRIPTION_TYPE, enSubscriptionType, IRTCProfile, pProfile, Int32, lFlags, IRTCBuddy2.Ptr, ppBuddy)
}
struct IRTCClientProvisioning extends IUnknown {
    static IID := "{B9F5CF06-65B9-4A80-A0E6-73CAE3EF3822}"
    CreateProfile(bstrProfileXML, ppProfile)
      => ComCall(3, this.p, BSTR, bstrProfileXML, IRTCProfile.Ptr, ppProfile)
    EnableProfile(pProfile, lRegisterFlags)
      => ComCall(4, this.p, IRTCProfile, pProfile, Int32, lRegisterFlags)
    DisableProfile(pProfile)
      => ComCall(5, this.p, IRTCProfile, pProfile)
    EnumerateProfiles(ppEnum)
      => ComCall(6, this.p, IRTCEnumProfiles.Ptr, ppEnum)
    get_Profiles(ppCollection)
      => ComCall(7, this.p, IRTCCollection.Ptr, ppCollection)
    GetProfile(bstrUserAccount, bstrUserPassword, bstrUserURI, bstrServer, lTransport, lCookie)
      => ComCall(8, this.p, BSTR, bstrUserAccount, BSTR, bstrUserPassword, BSTR, bstrUserURI, BSTR, bstrServer, Int32, lTransport, IntPtr, lCookie)
    get_SessionCapabilities(plSupportedSessions)
      => ComCall(9, this.p, Int32.Ptr, plSupportedSessions)
}
struct IRTCClientProvisioning2 extends IRTCClientProvisioning {
    static IID := "{A70909B5-F40E-4587-BB75-E6BC0845023E}"
    EnableProfileEx(pProfile, lRegisterFlags, lRoamingFlags)
      => ComCall(10, this.p, IRTCProfile, pProfile, Int32, lRegisterFlags, Int32, lRoamingFlags)
}
struct IRTCProfile extends IUnknown {
    static IID := "{D07ECA9E-4062-4DD4-9E7D-722A49BA7303}"
    get_Key(pbstrKey)
      => ComCall(3, this.p, BSTR.Ptr, pbstrKey)
    get_Name(pbstrName)
      => ComCall(4, this.p, BSTR.Ptr, pbstrName)
    get_XML(pbstrXML)
      => ComCall(5, this.p, BSTR.Ptr, pbstrXML)
    get_ProviderName(pbstrName)
      => ComCall(6, this.p, BSTR.Ptr, pbstrName)
    get_ProviderURI(enURI, pbstrURI)
      => ComCall(7, this.p, RTC_PROVIDER_URI, enURI, BSTR.Ptr, pbstrURI)
    get_ProviderData(pbstrData)
      => ComCall(8, this.p, BSTR.Ptr, pbstrData)
    get_ClientName(pbstrName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrName)
    get_ClientBanner(pfBanner)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pfBanner)
    get_ClientMinVer(pbstrMinVer)
      => ComCall(11, this.p, BSTR.Ptr, pbstrMinVer)
    get_ClientCurVer(pbstrCurVer)
      => ComCall(12, this.p, BSTR.Ptr, pbstrCurVer)
    get_ClientUpdateURI(pbstrUpdateURI)
      => ComCall(13, this.p, BSTR.Ptr, pbstrUpdateURI)
    get_ClientData(pbstrData)
      => ComCall(14, this.p, BSTR.Ptr, pbstrData)
    get_UserURI(pbstrUserURI)
      => ComCall(15, this.p, BSTR.Ptr, pbstrUserURI)
    get_UserName(pbstrUserName)
      => ComCall(16, this.p, BSTR.Ptr, pbstrUserName)
    get_UserAccount(pbstrUserAccount)
      => ComCall(17, this.p, BSTR.Ptr, pbstrUserAccount)
    SetCredentials(bstrUserURI, bstrUserAccount, bstrPassword)
      => ComCall(18, this.p, BSTR, bstrUserURI, BSTR, bstrUserAccount, BSTR, bstrPassword)
    get_SessionCapabilities(plSupportedSessions)
      => ComCall(19, this.p, Int32.Ptr, plSupportedSessions)
    get_State(penState)
      => ComCall(20, this.p, RTC_REGISTRATION_STATE.Ptr, penState)
}
struct IRTCProfile2 extends IRTCProfile {
    static IID := "{4B81F84E-BDC7-4184-9154-3CB2DD7917FB}"
    get_Realm(pbstrRealm)
      => ComCall(21, this.p, BSTR.Ptr, pbstrRealm)
    put_Realm(bstrRealm)
      => ComCall(22, this.p, BSTR, bstrRealm)
    get_AllowedAuth(plAllowedAuth)
      => ComCall(23, this.p, Int32.Ptr, plAllowedAuth)
    put_AllowedAuth(lAllowedAuth)
      => ComCall(24, this.p, Int32, lAllowedAuth)
}
struct IRTCSession extends IUnknown {
    static IID := "{387C8086-99BE-42FB-9973-7C0FC0CA9FA8}"
    get_Client(ppClient)
      => ComCall(3, this.p, IRTCClient.Ptr, ppClient)
    get_State(penState)
      => ComCall(4, this.p, RTC_SESSION_STATE.Ptr, penState)
    get_Type(penType)
      => ComCall(5, this.p, RTC_SESSION_TYPE.Ptr, penType)
    get_Profile(ppProfile)
      => ComCall(6, this.p, IRTCProfile.Ptr, ppProfile)
    get_Participants(ppCollection)
      => ComCall(7, this.p, IRTCCollection.Ptr, ppCollection)
    Answer()
      => ComCall(8, this.p)
    Terminate(enReason)
      => ComCall(9, this.p, RTC_TERMINATE_REASON, enReason)
    Redirect(enType, bstrLocalPhoneURI, pProfile, lFlags)
      => ComCall(10, this.p, RTC_SESSION_TYPE, enType, BSTR, bstrLocalPhoneURI, IRTCProfile, pProfile, Int32, lFlags)
    AddParticipant(bstrAddress, bstrName, ppParticipant)
      => ComCall(11, this.p, BSTR, bstrAddress, BSTR, bstrName, IRTCParticipant.Ptr, ppParticipant)
    RemoveParticipant(pParticipant)
      => ComCall(12, this.p, IRTCParticipant, pParticipant)
    EnumerateParticipants(ppEnum)
      => ComCall(13, this.p, IRTCEnumParticipants.Ptr, ppEnum)
    get_CanAddParticipants(pfCanAdd)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pfCanAdd)
    get_RedirectedUserURI(pbstrUserURI)
      => ComCall(15, this.p, BSTR.Ptr, pbstrUserURI)
    get_RedirectedUserName(pbstrUserName)
      => ComCall(16, this.p, BSTR.Ptr, pbstrUserName)
    NextRedirectedUser()
      => ComCall(17, this.p)
    SendMessage(bstrMessageHeader, bstrMessage, lCookie)
      => ComCall(18, this.p, BSTR, bstrMessageHeader, BSTR, bstrMessage, IntPtr, lCookie)
    SendMessageStatus(enUserStatus, lCookie)
      => ComCall(19, this.p, RTC_MESSAGING_USER_STATUS, enUserStatus, IntPtr, lCookie)
    AddStream(lMediaType, lCookie)
      => ComCall(20, this.p, Int32, lMediaType, IntPtr, lCookie)
    RemoveStream(lMediaType, lCookie)
      => ComCall(21, this.p, Int32, lMediaType, IntPtr, lCookie)
    put_EncryptionKey(lMediaType, EncryptionKey)
      => ComCall(22, this.p, Int32, lMediaType, BSTR, EncryptionKey)
}
struct IRTCSession2 extends IRTCSession {
    static IID := "{17D7CDFC-B007-484C-99D2-86A8A820991D}"
    SendInfo(bstrInfoHeader, bstrInfo, lCookie)
      => ComCall(23, this.p, BSTR, bstrInfoHeader, BSTR, bstrInfo, IntPtr, lCookie)
    put_PreferredSecurityLevel(enSecurityType, enSecurityLevel)
      => ComCall(24, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL, enSecurityLevel)
    get_PreferredSecurityLevel(enSecurityType, penSecurityLevel)
      => ComCall(25, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL.Ptr, penSecurityLevel)
    IsSecurityEnabled(enSecurityType, pfSecurityEnabled)
      => ComCall(26, this.p, RTC_SECURITY_TYPE, enSecurityType, VARIANT_BOOL.Ptr, pfSecurityEnabled)
    AnswerWithSessionDescription(bstrContentType, bstrSessionDescription)
      => ComCall(27, this.p, BSTR, bstrContentType, BSTR, bstrSessionDescription)
    ReInviteWithSessionDescription(bstrContentType, bstrSessionDescription, lCookie)
      => ComCall(28, this.p, BSTR, bstrContentType, BSTR, bstrSessionDescription, IntPtr, lCookie)
}
struct IRTCSessionCallControl extends IUnknown {
    static IID := "{E9A50D94-190B-4F82-9530-3B8EBF60758A}"
    Hold(lCookie)
      => ComCall(3, this.p, IntPtr, lCookie)
    UnHold(lCookie)
      => ComCall(4, this.p, IntPtr, lCookie)
    Forward(bstrForwardToURI)
      => ComCall(5, this.p, BSTR, bstrForwardToURI)
    Refer(bstrReferToURI, bstrReferCookie)
      => ComCall(6, this.p, BSTR, bstrReferToURI, BSTR, bstrReferCookie)
    put_ReferredByURI(bstrReferredByURI)
      => ComCall(7, this.p, BSTR, bstrReferredByURI)
    get_ReferredByURI(pbstrReferredByURI)
      => ComCall(8, this.p, BSTR.Ptr, pbstrReferredByURI)
    put_ReferCookie(bstrReferCookie)
      => ComCall(9, this.p, BSTR, bstrReferCookie)
    get_ReferCookie(pbstrReferCookie)
      => ComCall(10, this.p, BSTR.Ptr, pbstrReferCookie)
    get_IsReferred(pfIsReferred)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pfIsReferred)
}
struct IRTCParticipant extends IUnknown {
    static IID := "{AE86ADD5-26B1-4414-AF1D-B94CD938D739}"
    get_UserURI(pbstrUserURI)
      => ComCall(3, this.p, BSTR.Ptr, pbstrUserURI)
    get_Name(pbstrName)
      => ComCall(4, this.p, BSTR.Ptr, pbstrName)
    get_Removable(pfRemovable)
      => ComCall(5, this.p, VARIANT_BOOL.Ptr, pfRemovable)
    get_State(penState)
      => ComCall(6, this.p, RTC_PARTICIPANT_STATE.Ptr, penState)
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession.Ptr, ppSession)
}
struct IRTCRoamingEvent extends IDispatch {
    static IID := "{79960A6B-0CB1-4DC8-A805-7318E99902E8}"
    get_EventType(pEventType)
      => ComCall(7, this.p, RTC_ROAMING_EVENT_TYPE.Ptr, pEventType)
    get_Profile(ppProfile)
      => ComCall(8, this.p, IRTCProfile2.Ptr, ppProfile)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCProfileEvent extends IDispatch {
    static IID := "{D6D5AB3B-770E-43E8-800A-79B062395FCA}"
    get_Profile(ppProfile)
      => ComCall(7, this.p, IRTCProfile.Ptr, ppProfile)
    get_Cookie(plCookie)
      => ComCall(8, this.p, IntPtr.Ptr, plCookie)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
}
struct IRTCProfileEvent2 extends IRTCProfileEvent {
    static IID := "{62E56EDC-03FA-4121-94FB-23493FD0AE64}"
    get_EventType(pEventType)
      => ComCall(10, this.p, RTC_PROFILE_EVENT_TYPE.Ptr, pEventType)
}
struct IRTCClientEvent extends IDispatch {
    static IID := "{2B493B7A-3CBA-4170-9C8B-76A9DACDD644}"
    get_EventType(penEventType)
      => ComCall(7, this.p, RTC_CLIENT_EVENT_TYPE.Ptr, penEventType)
    get_Client(ppClient)
      => ComCall(8, this.p, IRTCClient.Ptr, ppClient)
}
struct IRTCRegistrationStateChangeEvent extends IDispatch {
    static IID := "{62D0991B-50AB-4F02-B948-CA94F26F8F95}"
    get_Profile(ppProfile)
      => ComCall(7, this.p, IRTCProfile.Ptr, ppProfile)
    get_State(penState)
      => ComCall(8, this.p, RTC_REGISTRATION_STATE.Ptr, penState)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCSessionStateChangeEvent extends IDispatch {
    static IID := "{B5BAD703-5952-48B3-9321-7F4500521506}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession.Ptr, ppSession)
    get_State(penState)
      => ComCall(8, this.p, RTC_SESSION_STATE.Ptr, penState)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCSessionStateChangeEvent2 extends IRTCSessionStateChangeEvent {
    static IID := "{4F933171-6F95-4880-80D9-2EC8D495D261}"
    get_MediaTypes(pMediaTypes)
      => ComCall(11, this.p, Int32.Ptr, pMediaTypes)
    get_RemotePreferredSecurityLevel(enSecurityType, penSecurityLevel)
      => ComCall(12, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL.Ptr, penSecurityLevel)
    get_IsForked(pfIsForked)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pfIsForked)
    GetRemoteSessionDescription(pbstrContentType, pbstrSessionDescription)
      => ComCall(14, this.p, BSTR.Ptr, pbstrContentType, BSTR.Ptr, pbstrSessionDescription)
}
struct IRTCSessionOperationCompleteEvent extends IDispatch {
    static IID := "{A6BFF4C0-F7C8-4D3C-9A41-3550F78A95B0}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession.Ptr, ppSession)
    get_Cookie(plCookie)
      => ComCall(8, this.p, IntPtr.Ptr, plCookie)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCSessionOperationCompleteEvent2 extends IRTCSessionOperationCompleteEvent {
    static IID := "{F6FC2A9B-D5BC-4241-B436-1B8460C13832}"
    get_Participant(ppParticipant)
      => ComCall(11, this.p, IRTCParticipant.Ptr, ppParticipant)
    GetRemoteSessionDescription(pbstrContentType, pbstrSessionDescription)
      => ComCall(12, this.p, BSTR.Ptr, pbstrContentType, BSTR.Ptr, pbstrSessionDescription)
}
struct IRTCParticipantStateChangeEvent extends IDispatch {
    static IID := "{09BCB597-F0FA-48F9-B420-468CEA7FDE04}"
    get_Participant(ppParticipant)
      => ComCall(7, this.p, IRTCParticipant.Ptr, ppParticipant)
    get_State(penState)
      => ComCall(8, this.p, RTC_PARTICIPANT_STATE.Ptr, penState)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
}
struct IRTCMediaEvent extends IDispatch {
    static IID := "{099944FB-BCDA-453E-8C41-E13DA2ADF7F3}"
    get_MediaType(pMediaType)
      => ComCall(7, this.p, Int32.Ptr, pMediaType)
    get_EventType(penEventType)
      => ComCall(8, this.p, RTC_MEDIA_EVENT_TYPE.Ptr, penEventType)
    get_EventReason(penEventReason)
      => ComCall(9, this.p, RTC_MEDIA_EVENT_REASON.Ptr, penEventReason)
}
struct IRTCIntensityEvent extends IDispatch {
    static IID := "{4C23BF51-390C-4992-A41D-41EEC05B2A4B}"
    get_Level(plLevel)
      => ComCall(7, this.p, Int32.Ptr, plLevel)
    get_Min(plMin)
      => ComCall(8, this.p, Int32.Ptr, plMin)
    get_Max(plMax)
      => ComCall(9, this.p, Int32.Ptr, plMax)
    get_Direction(penDirection)
      => ComCall(10, this.p, RTC_AUDIO_DEVICE.Ptr, penDirection)
}
struct IRTCMessagingEvent extends IDispatch {
    static IID := "{D3609541-1B29-4DE5-A4AD-5AEBAF319512}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession.Ptr, ppSession)
    get_Participant(ppParticipant)
      => ComCall(8, this.p, IRTCParticipant.Ptr, ppParticipant)
    get_EventType(penEventType)
      => ComCall(9, this.p, RTC_MESSAGING_EVENT_TYPE.Ptr, penEventType)
    get_Message(pbstrMessage)
      => ComCall(10, this.p, BSTR.Ptr, pbstrMessage)
    get_MessageHeader(pbstrMessageHeader)
      => ComCall(11, this.p, BSTR.Ptr, pbstrMessageHeader)
    get_UserStatus(penUserStatus)
      => ComCall(12, this.p, RTC_MESSAGING_USER_STATUS.Ptr, penUserStatus)
}
struct IRTCBuddyEvent extends IDispatch {
    static IID := "{F36D755D-17E6-404E-954F-0FC07574C78D}"
    get_Buddy(ppBuddy)
      => ComCall(7, this.p, IRTCBuddy.Ptr, ppBuddy)
}
struct IRTCBuddyEvent2 extends IRTCBuddyEvent {
    static IID := "{484A7F1E-73F0-4990-BFC2-60BC3978A720}"
    get_EventType(pEventType)
      => ComCall(8, this.p, RTC_BUDDY_EVENT_TYPE.Ptr, pEventType)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCWatcherEvent extends IDispatch {
    static IID := "{F30D7261-587A-424F-822C-312788F43548}"
    get_Watcher(ppWatcher)
      => ComCall(7, this.p, IRTCWatcher.Ptr, ppWatcher)
}
struct IRTCWatcherEvent2 extends IRTCWatcherEvent {
    static IID := "{E52891E8-188C-49AF-B005-98ED13F83F9C}"
    get_EventType(pEventType)
      => ComCall(8, this.p, RTC_WATCHER_EVENT_TYPE.Ptr, pEventType)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
}
struct IRTCBuddyGroupEvent extends IDispatch {
    static IID := "{3A79E1D1-B736-4414-96F8-BBC7F08863E4}"
    get_EventType(pEventType)
      => ComCall(7, this.p, RTC_GROUP_EVENT_TYPE.Ptr, pEventType)
    get_Group(ppGroup)
      => ComCall(8, this.p, IRTCBuddyGroup.Ptr, ppGroup)
    get_Buddy(ppBuddy)
      => ComCall(9, this.p, IRTCBuddy2.Ptr, ppBuddy)
    get_StatusCode(plStatusCode)
      => ComCall(10, this.p, Int32.Ptr, plStatusCode)
}
struct IRTCInfoEvent extends IDispatch {
    static IID := "{4E1D68AE-1912-4F49-B2C3-594FADFD425F}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession2.Ptr, ppSession)
    get_Participant(ppParticipant)
      => ComCall(8, this.p, IRTCParticipant.Ptr, ppParticipant)
    get_Info(pbstrInfo)
      => ComCall(9, this.p, BSTR.Ptr, pbstrInfo)
    get_InfoHeader(pbstrInfoHeader)
      => ComCall(10, this.p, BSTR.Ptr, pbstrInfoHeader)
}
struct IRTCMediaRequestEvent extends IDispatch {
    static IID := "{52572D15-148C-4D97-A36C-2DA55C289D63}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession2.Ptr, ppSession)
    get_ProposedMedia(plMediaTypes)
      => ComCall(8, this.p, Int32.Ptr, plMediaTypes)
    get_CurrentMedia(plMediaTypes)
      => ComCall(9, this.p, Int32.Ptr, plMediaTypes)
    Accept(lMediaTypes)
      => ComCall(10, this.p, Int32, lMediaTypes)
    get_RemotePreferredSecurityLevel(enSecurityType, penSecurityLevel)
      => ComCall(11, this.p, RTC_SECURITY_TYPE, enSecurityType, RTC_SECURITY_LEVEL.Ptr, penSecurityLevel)
    Reject()
      => ComCall(12, this.p)
    get_State(pState)
      => ComCall(13, this.p, RTC_REINVITE_STATE.Ptr, pState)
}
struct IRTCReInviteEvent extends IDispatch {
    static IID := "{11558D84-204C-43E7-99B0-2034E9417F7D}"
    get_Session(ppSession2)
      => ComCall(7, this.p, IRTCSession2.Ptr, ppSession2)
    Accept(bstrContentType, bstrSessionDescription)
      => ComCall(8, this.p, BSTR, bstrContentType, BSTR, bstrSessionDescription)
    Reject()
      => ComCall(9, this.p)
    get_State(pState)
      => ComCall(10, this.p, RTC_REINVITE_STATE.Ptr, pState)
    GetRemoteSessionDescription(pbstrContentType, pbstrSessionDescription)
      => ComCall(11, this.p, BSTR.Ptr, pbstrContentType, BSTR.Ptr, pbstrSessionDescription)
}
struct IRTCPresencePropertyEvent extends IDispatch {
    static IID := "{F777F570-A820-49D5-86BD-E099493F1518}"
    get_StatusCode(plStatusCode)
      => ComCall(7, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(8, this.p, BSTR.Ptr, pbstrStatusText)
    get_PresenceProperty(penPresProp)
      => ComCall(9, this.p, RTC_PRESENCE_PROPERTY.Ptr, penPresProp)
    get_Value(pbstrValue)
      => ComCall(10, this.p, BSTR.Ptr, pbstrValue)
}
struct IRTCPresenceDataEvent extends IDispatch {
    static IID := "{38F0E78C-8B87-4C04-A82D-AEDD83C909BB}"
    get_StatusCode(plStatusCode)
      => ComCall(7, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(8, this.p, BSTR.Ptr, pbstrStatusText)
    GetPresenceData(pbstrNamespace, pbstrData)
      => ComCall(9, this.p, BSTR.Ptr, pbstrNamespace, BSTR.Ptr, pbstrData)
}
struct IRTCPresenceStatusEvent extends IDispatch {
    static IID := "{78673F32-4A0F-462C-89AA-EE7706707678}"
    get_StatusCode(plStatusCode)
      => ComCall(7, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(8, this.p, BSTR.Ptr, pbstrStatusText)
    GetLocalPresenceInfo(penStatus, pbstrNotes)
      => ComCall(9, this.p, RTC_PRESENCE_STATUS.Ptr, penStatus, BSTR.Ptr, pbstrNotes)
}
struct IRTCCollection extends IDispatch {
    static IID := "{EC7C8096-B918-4044-94F1-E4FBA0361D5C}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get_Item(Index, pVariant)
      => ComCall(8, this.p, Int32, Index, VARIANT.Ptr, pVariant)
    get__NewEnum(ppNewEnum)
      => ComCall(9, this.p, IUnknown.Ptr, ppNewEnum)
}
struct IRTCEnumParticipants extends IUnknown {
    static IID := "{FCD56F29-4A4F-41B2-BA5C-F5BCCC060BF6}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCParticipant.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumParticipants.Ptr, ppEnum)
}
struct IRTCEnumProfiles extends IUnknown {
    static IID := "{29B7C41C-ED82-4BCA-84AD-39D5101B58E3}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCProfile.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumProfiles.Ptr, ppEnum)
}
struct IRTCEnumBuddies extends IUnknown {
    static IID := "{F7296917-5569-4B3B-B3AF-98D1144B2B87}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCBuddy.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumBuddies.Ptr, ppEnum)
}
struct IRTCEnumWatchers extends IUnknown {
    static IID := "{A87D55D7-DB74-4ED1-9CA4-77A0E41B413E}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCWatcher.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumWatchers.Ptr, ppEnum)
}
struct IRTCEnumGroups extends IUnknown {
    static IID := "{742378D6-A141-4415-8F27-35D99076CF5D}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCBuddyGroup.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumGroups.Ptr, ppEnum)
}
struct IRTCPresenceContact extends IUnknown {
    static IID := "{8B22F92C-CD90-42DB-A733-212205C3E3DF}"
    get_PresentityURI(pbstrPresentityURI)
      => ComCall(3, this.p, BSTR.Ptr, pbstrPresentityURI)
    put_PresentityURI(bstrPresentityURI)
      => ComCall(4, this.p, BSTR, bstrPresentityURI)
    get_Name(pbstrName)
      => ComCall(5, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(6, this.p, BSTR, bstrName)
    get_Data(pbstrData)
      => ComCall(7, this.p, BSTR.Ptr, pbstrData)
    put_Data(bstrData)
      => ComCall(8, this.p, BSTR, bstrData)
    get_Persistent(pfPersistent)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pfPersistent)
    put_Persistent(fPersistent)
      => ComCall(10, this.p, VARIANT_BOOL, fPersistent)
}
struct IRTCBuddy extends IRTCPresenceContact {
    static IID := "{FCB136C8-7B90-4E0C-BEFE-56EDF0BA6F1C}"
    get_Status(penStatus)
      => ComCall(11, this.p, RTC_PRESENCE_STATUS.Ptr, penStatus)
    get_Notes(pbstrNotes)
      => ComCall(12, this.p, BSTR.Ptr, pbstrNotes)
}
struct IRTCBuddy2 extends IRTCBuddy {
    static IID := "{102F9588-23E7-40E3-954D-CD7A1D5C0361}"
    get_Profile(ppProfile)
      => ComCall(13, this.p, IRTCProfile2.Ptr, ppProfile)
    Refresh()
      => ComCall(14, this.p)
    EnumerateGroups(ppEnum)
      => ComCall(15, this.p, IRTCEnumGroups.Ptr, ppEnum)
    get_Groups(ppCollection)
      => ComCall(16, this.p, IRTCCollection.Ptr, ppCollection)
    get_PresenceProperty(enProperty, pbstrProperty)
      => ComCall(17, this.p, RTC_PRESENCE_PROPERTY, enProperty, BSTR.Ptr, pbstrProperty)
    EnumeratePresenceDevices(ppEnumDevices)
      => ComCall(18, this.p, IRTCEnumPresenceDevices.Ptr, ppEnumDevices)
    get_PresenceDevices(ppDevicesCollection)
      => ComCall(19, this.p, IRTCCollection.Ptr, ppDevicesCollection)
    get_SubscriptionType(penSubscriptionType)
      => ComCall(20, this.p, RTC_BUDDY_SUBSCRIPTION_TYPE.Ptr, penSubscriptionType)
}
struct IRTCWatcher extends IRTCPresenceContact {
    static IID := "{C7CEDAD8-346B-4D1B-AC02-A2088DF9BE4F}"
    get_State(penState)
      => ComCall(11, this.p, RTC_WATCHER_STATE.Ptr, penState)
    put_State(enState)
      => ComCall(12, this.p, RTC_WATCHER_STATE, enState)
}
struct IRTCWatcher2 extends IRTCWatcher {
    static IID := "{D4D9967F-D011-4B1D-91E3-ABA78F96393D}"
    get_Profile(ppProfile)
      => ComCall(13, this.p, IRTCProfile2.Ptr, ppProfile)
    get_Scope(penScope)
      => ComCall(14, this.p, RTC_ACE_SCOPE.Ptr, penScope)
}
struct IRTCBuddyGroup extends IUnknown {
    static IID := "{60361E68-9164-4389-A4C6-D0B3925BDA5E}"
    get_Name(pbstrGroupName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrGroupName)
    put_Name(bstrGroupName)
      => ComCall(4, this.p, BSTR, bstrGroupName)
    AddBuddy(pBuddy)
      => ComCall(5, this.p, IRTCBuddy, pBuddy)
    RemoveBuddy(pBuddy)
      => ComCall(6, this.p, IRTCBuddy, pBuddy)
    EnumerateBuddies(ppEnum)
      => ComCall(7, this.p, IRTCEnumBuddies.Ptr, ppEnum)
    get_Buddies(ppCollection)
      => ComCall(8, this.p, IRTCCollection.Ptr, ppCollection)
    get_Data(pbstrData)
      => ComCall(9, this.p, BSTR.Ptr, pbstrData)
    put_Data(bstrData)
      => ComCall(10, this.p, BSTR, bstrData)
    get_Profile(ppProfile)
      => ComCall(11, this.p, IRTCProfile2.Ptr, ppProfile)
}
struct IRTCEventNotification extends IUnknown {
    static IID := "{13FA24C7-5748-4B21-91F5-7397609CE747}"
    Event(RTCEvent, pEvent)
      => ComCall(3, this.p, RTC_EVENT, RTCEvent, IDispatch, pEvent)
}
struct IRTCPortManager extends IUnknown {
    static IID := "{DA77C14B-6208-43CA-8DDF-5B60A0A69FAC}"
    GetMapping(bstrRemoteAddress, enPortType, pbstrInternalLocalAddress, plInternalLocalPort, pbstrExternalLocalAddress, plExternalLocalPort)
      => ComCall(3, this.p, BSTR, bstrRemoteAddress, RTC_PORT_TYPE, enPortType, BSTR.Ptr, pbstrInternalLocalAddress, Int32.Ptr, plInternalLocalPort, BSTR.Ptr, pbstrExternalLocalAddress, Int32.Ptr, plExternalLocalPort)
    UpdateRemoteAddress(bstrRemoteAddress, bstrInternalLocalAddress, lInternalLocalPort, bstrExternalLocalAddress, lExternalLocalPort)
      => ComCall(4, this.p, BSTR, bstrRemoteAddress, BSTR, bstrInternalLocalAddress, Int32, lInternalLocalPort, BSTR, bstrExternalLocalAddress, Int32, lExternalLocalPort)
    ReleaseMapping(bstrInternalLocalAddress, lInternalLocalPort, bstrExternalLocalAddress, lExternalLocalAddress)
      => ComCall(5, this.p, BSTR, bstrInternalLocalAddress, Int32, lInternalLocalPort, BSTR, bstrExternalLocalAddress, Int32, lExternalLocalAddress)
}
struct IRTCSessionPortManagement extends IUnknown {
    static IID := "{A072F1D6-0286-4E1F-85F2-17A2948456EC}"
    SetPortManager(pPortManager)
      => ComCall(3, this.p, IRTCPortManager, pPortManager)
}
struct IRTCClientPortManagement extends IUnknown {
    static IID := "{D5DF3F03-4BDE-4417-AEFE-71177BDAEA66}"
    StartListenAddressAndPort(bstrInternalLocalAddress, lInternalLocalPort)
      => ComCall(3, this.p, BSTR, bstrInternalLocalAddress, Int32, lInternalLocalPort)
    StopListenAddressAndPort(bstrInternalLocalAddress, lInternalLocalPort)
      => ComCall(4, this.p, BSTR, bstrInternalLocalAddress, Int32, lInternalLocalPort)
    GetPortRange(enPortType, plMinValue, plMaxValue)
      => ComCall(5, this.p, RTC_PORT_TYPE, enPortType, Int32.Ptr, plMinValue, Int32.Ptr, plMaxValue)
}
struct IRTCUserSearch extends IUnknown {
    static IID := "{B619882B-860C-4DB4-BE1B-693B6505BBE5}"
    CreateQuery(ppQuery)
      => ComCall(3, this.p, IRTCUserSearchQuery.Ptr, ppQuery)
    ExecuteSearch(pQuery, pProfile, lCookie)
      => ComCall(4, this.p, IRTCUserSearchQuery, pQuery, IRTCProfile, pProfile, IntPtr, lCookie)
}
struct IRTCUserSearchQuery extends IUnknown {
    static IID := "{288300F5-D23A-4365-9A73-9985C98C2881}"
    put_SearchTerm(bstrName, bstrValue)
      => ComCall(3, this.p, BSTR, bstrName, BSTR, bstrValue)
    get_SearchTerm(bstrName, pbstrValue)
      => ComCall(4, this.p, BSTR, bstrName, BSTR.Ptr, pbstrValue)
    get_SearchTerms(pbstrNames)
      => ComCall(5, this.p, BSTR.Ptr, pbstrNames)
    put_SearchPreference(enPreference, lValue)
      => ComCall(6, this.p, RTC_USER_SEARCH_PREFERENCE, enPreference, Int32, lValue)
    get_SearchPreference(enPreference, plValue)
      => ComCall(7, this.p, RTC_USER_SEARCH_PREFERENCE, enPreference, Int32.Ptr, plValue)
    put_SearchDomain(bstrDomain)
      => ComCall(8, this.p, BSTR, bstrDomain)
    get_SearchDomain(pbstrDomain)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDomain)
}
struct IRTCUserSearchResult extends IUnknown {
    static IID := "{851278B2-9592-480F-8DB5-2DE86B26B54D}"
    get_Value(enColumn, pbstrValue)
      => ComCall(3, this.p, RTC_USER_SEARCH_COLUMN, enColumn, BSTR.Ptr, pbstrValue)
}
struct IRTCEnumUserSearchResults extends IUnknown {
    static IID := "{83D4D877-AA5D-4A5B-8D0E-002A8067E0E8}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCUserSearchResult.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumUserSearchResults.Ptr, ppEnum)
}
struct IRTCUserSearchResultsEvent extends IDispatch {
    static IID := "{D8C8C3CD-7FAC-4088-81C5-C24CBC0938E3}"
    EnumerateResults(ppEnum)
      => ComCall(7, this.p, IRTCEnumUserSearchResults.Ptr, ppEnum)
    get_Results(ppCollection)
      => ComCall(8, this.p, IRTCCollection.Ptr, ppCollection)
    get_Profile(ppProfile)
      => ComCall(9, this.p, IRTCProfile2.Ptr, ppProfile)
    get_Query(ppQuery)
      => ComCall(10, this.p, IRTCUserSearchQuery.Ptr, ppQuery)
    get_Cookie(plCookie)
      => ComCall(11, this.p, IntPtr.Ptr, plCookie)
    get_StatusCode(plStatusCode)
      => ComCall(12, this.p, Int32.Ptr, plStatusCode)
    get_MoreAvailable(pfMoreAvailable)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pfMoreAvailable)
}
struct IRTCSessionReferStatusEvent extends IDispatch {
    static IID := "{3D8FC2CD-5D76-44AB-BB68-2A80353B34A2}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession2.Ptr, ppSession)
    get_ReferStatus(penReferStatus)
      => ComCall(8, this.p, RTC_SESSION_REFER_STATUS.Ptr, penReferStatus)
    get_StatusCode(plStatusCode)
      => ComCall(9, this.p, Int32.Ptr, plStatusCode)
    get_StatusText(pbstrStatusText)
      => ComCall(10, this.p, BSTR.Ptr, pbstrStatusText)
}
struct IRTCSessionReferredEvent extends IDispatch {
    static IID := "{176A6828-4FCC-4F28-A862-04597A6CF1C4}"
    get_Session(ppSession)
      => ComCall(7, this.p, IRTCSession2.Ptr, ppSession)
    get_ReferredByURI(pbstrReferredByURI)
      => ComCall(8, this.p, BSTR.Ptr, pbstrReferredByURI)
    get_ReferToURI(pbstrReferoURI)
      => ComCall(9, this.p, BSTR.Ptr, pbstrReferoURI)
    get_ReferCookie(pbstrReferCookie)
      => ComCall(10, this.p, BSTR.Ptr, pbstrReferCookie)
    Accept()
      => ComCall(11, this.p)
    Reject()
      => ComCall(12, this.p)
    SetReferredSessionState(enState)
      => ComCall(13, this.p, RTC_SESSION_STATE, enState)
}
struct IRTCSessionDescriptionManager extends IUnknown {
    static IID := "{BA7F518E-D336-4070-93A6-865395C843F9}"
    EvaluateSessionDescription(bstrContentType, bstrSessionDescription, pfApplicationSession)
      => ComCall(3, this.p, BSTR, bstrContentType, BSTR, bstrSessionDescription, VARIANT_BOOL.Ptr, pfApplicationSession)
}
struct IRTCEnumPresenceDevices extends IUnknown {
    static IID := "{708C2AB7-8BF8-42F8-8C7D-635197AD5539}"
    Next(ppElements, pceltFetched?)
      => ComCall(3, this.p, UInt32, ppElements.Length, IRTCPresenceDevice.Ptr, ppElements, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(4, this.p)
    Skip(celt)
      => ComCall(5, this.p, UInt32, celt)
    Clone(ppEnum)
      => ComCall(6, this.p, IRTCEnumPresenceDevices.Ptr, ppEnum)
}
struct IRTCPresenceDevice extends IUnknown {
    static IID := "{BC6A90DD-AD9A-48DA-9B0C-2515E38521AD}"
    get_Status(penStatus)
      => ComCall(3, this.p, RTC_PRESENCE_STATUS.Ptr, penStatus)
    get_Notes(pbstrNotes)
      => ComCall(4, this.p, BSTR.Ptr, pbstrNotes)
    get_PresenceProperty(enProperty, pbstrProperty)
      => ComCall(5, this.p, RTC_PRESENCE_PROPERTY, enProperty, BSTR.Ptr, pbstrProperty)
    GetPresenceData(pbstrNamespace, pbstrData)
      => ComCall(6, this.p, BSTR.Ptr, pbstrNamespace, BSTR.Ptr, pbstrData)
}
struct IRTCDispatchEventNotification extends IDispatch {
    static IID := "{176DDFBE-FEC0-4D55-BC87-84CFF1EF7F91}"
}
struct TRANSPORT_SETTING {
    SettingId : TRANSPORT_SETTING_ID
    Length : UInt32.Ptr
    Value : UInt8.Ptr
}
struct ITransportSettingsInternal extends IUnknown {
    static IID := "{5123E076-29E3-4BFD-84FE-0192D411E3E8}"
    ApplySetting(Setting)
      => ComCall(3, this.p, TRANSPORT_SETTING.Ptr, Setting)
    QuerySetting(Setting)
      => ComCall(4, this.p, TRANSPORT_SETTING.Ptr, Setting)
}
struct INetworkTransportSettings extends IUnknown {
    static IID := "{5E7ABB2C-F2C1-4A61-BD35-DEB7A08AB0F1}"
    ApplySetting(SettingId, ValueIn, ValueOut)
      => ComCall(3, this.p, TRANSPORT_SETTING_ID.Ptr, SettingId, UInt32, ValueIn.Length, UInt8.Ptr, ValueIn, UInt32.Ptr, ValueOut.Length, UInt8.Ptr.Ptr, ValueOut)
    QuerySetting(SettingId, ValueIn, ValueOut)
      => ComCall(4, this.p, TRANSPORT_SETTING_ID.Ptr, SettingId, UInt32, ValueIn.Length, UInt8.Ptr, ValueIn, UInt32.Ptr, ValueOut.Length, UInt8.Ptr.Ptr, ValueOut)
}
struct INotificationTransportSync extends IUnknown {
    static IID := "{79EB1402-0AB8-49C0-9E14-A1AE4BA93058}"
    CompleteDelivery()
      => ComCall(3, this.p)
    Flush()
      => ComCall(4, this.p)
}
