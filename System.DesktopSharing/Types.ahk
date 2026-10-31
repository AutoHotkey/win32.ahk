#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct CTRL_LEVEL extends Int32 {
    static CTRL_LEVEL_MIN := 0
    static CTRL_LEVEL_INVALID := 0
    static CTRL_LEVEL_NONE := 1
    static CTRL_LEVEL_VIEW := 2
    static CTRL_LEVEL_INTERACTIVE := 3
    static CTRL_LEVEL_REQCTRL_VIEW := 4
    static CTRL_LEVEL_REQCTRL_INTERACTIVE := 5
    static CTRL_LEVEL_MAX := 5
}
struct ATTENDEE_DISCONNECT_REASON extends Int32 {
    static ATTENDEE_DISCONNECT_REASON_MIN := 0
    static ATTENDEE_DISCONNECT_REASON_APP := 0
    static ATTENDEE_DISCONNECT_REASON_ERR := 1
    static ATTENDEE_DISCONNECT_REASON_CLI := 2
    static ATTENDEE_DISCONNECT_REASON_MAX := 2
}
struct CHANNEL_PRIORITY extends Int32 {
    static CHANNEL_PRIORITY_LO := 0
    static CHANNEL_PRIORITY_MED := 1
    static CHANNEL_PRIORITY_HI := 2
}
struct CHANNEL_FLAGS extends Int32 {
    static CHANNEL_FLAGS_LEGACY := 1
    static CHANNEL_FLAGS_UNCOMPRESSED := 2
    static CHANNEL_FLAGS_DYNAMIC := 4
}
struct CHANNEL_ACCESS_ENUM extends Int32 {
    static CHANNEL_ACCESS_ENUM_NONE := 0
    static CHANNEL_ACCESS_ENUM_SENDRECEIVE := 1
}
struct RDPENCOMAPI_ATTENDEE_FLAGS extends Int32 {
    static ATTENDEE_FLAGS_LOCAL := 1
}
struct RDPSRAPI_WND_FLAGS extends Int32 {
    static WND_FLAG_PRIVILEGED := 1
}
struct RDPSRAPI_APP_FLAGS extends Int32 {
    static APP_FLAG_PRIVILEGED := 1
}
struct RDPSRAPI_MOUSE_BUTTON_TYPE extends Int32 {
    static RDPSRAPI_MOUSE_BUTTON_BUTTON1 := 0
    static RDPSRAPI_MOUSE_BUTTON_BUTTON2 := 1
    static RDPSRAPI_MOUSE_BUTTON_BUTTON3 := 2
    static RDPSRAPI_MOUSE_BUTTON_XBUTTON1 := 3
    static RDPSRAPI_MOUSE_BUTTON_XBUTTON2 := 4
    static RDPSRAPI_MOUSE_BUTTON_XBUTTON3 := 5
}
struct RDPSRAPI_KBD_CODE_TYPE extends Int32 {
    static RDPSRAPI_KBD_CODE_SCANCODE := 0
    static RDPSRAPI_KBD_CODE_UNICODE := 1
}
struct RDPSRAPI_KBD_SYNC_FLAG extends Int32 {
    static RDPSRAPI_KBD_SYNC_FLAG_SCROLL_LOCK := 1
    static RDPSRAPI_KBD_SYNC_FLAG_NUM_LOCK := 2
    static RDPSRAPI_KBD_SYNC_FLAG_CAPS_LOCK := 4
    static RDPSRAPI_KBD_SYNC_FLAG_KANA_LOCK := 8
}
struct IRDPSRAPIDebug extends IUnknown {
    static IID := "{AA1E42B5-496D-4CA4-A690-348DCB2EC4AD}"
    put_CLXCmdLine(CLXCmdLine)
      => ComCall(3, this.p, BSTR, CLXCmdLine)
    get_CLXCmdLine(pCLXCmdLine)
      => ComCall(4, this.p, BSTR.Ptr, pCLXCmdLine)
}
struct IRDPSRAPIPerfCounterLogger extends IUnknown {
    static IID := "{071C2533-0FA4-4E8F-AE83-9C10B4305AB5}"
    LogValue(lValue)
      => ComCall(3, this.p, Int64, lValue)
}
struct IRDPSRAPIPerfCounterLoggingManager extends IUnknown {
    static IID := "{9A512C86-AC6E-4A8E-B1A4-FCEF363F6E64}"
    CreateLogger(bstrCounterName, ppLogger)
      => ComCall(3, this.p, BSTR, bstrCounterName, IRDPSRAPIPerfCounterLogger.Ptr, ppLogger)
}
struct IRDPSRAPIAudioStream extends IUnknown {
    static IID := "{E3E30EF9-89C6-4541-BA3B-19336AC6D31C}"
    Initialize(pnPeriodInHundredNsIntervals)
      => ComCall(3, this.p, Int64.Ptr, pnPeriodInHundredNsIntervals)
    Start()
      => ComCall(4, this.p)
    Stop()
      => ComCall(5, this.p)
    GetBuffer(ppbData, pTimestamp)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, ppbData.Length, Int64.Ptr, pTimestamp)
    FreeBuffer()
      => ComCall(7, this.p)
}
struct IRDPSRAPIClipboardUseEvents extends IUnknown {
    static IID := "{D559F59A-7A27-4138-8763-247CE5F659A8}"
    OnPasteFromClipboard(clipboardFormat, pAttendee, pRetVal)
      => ComCall(3, this.p, UInt32, clipboardFormat, IDispatch, pAttendee, VARIANT_BOOL.Ptr, pRetVal)
}
struct IRDPSRAPIWindow extends IDispatch {
    static IID := "{BEAFE0F9-C77B-4933-BA9F-A24CDDCC27CF}"
    get_Id(pRetVal)
      => ComCall(7, this.p, Int32.Ptr, pRetVal)
    get_Application(pApplication)
      => ComCall(8, this.p, IRDPSRAPIApplication.Ptr, pApplication)
    get_Shared(pRetVal)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pRetVal)
    put_Shared(NewVal)
      => ComCall(10, this.p, VARIANT_BOOL, NewVal)
    get_Name(pRetVal)
      => ComCall(11, this.p, BSTR.Ptr, pRetVal)
    Show()
      => ComCall(12, this.p)
    get_Flags(pdwFlags)
      => ComCall(13, this.p, UInt32.Ptr, pdwFlags)
}
struct IRDPSRAPIWindowList extends IDispatch {
    static IID := "{8A05CE44-715A-4116-A189-A118F30A07BD}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(item, pWindow)
      => ComCall(8, this.p, Int32, item, IRDPSRAPIWindow.Ptr, pWindow)
}
struct IRDPSRAPIApplication extends IDispatch {
    static IID := "{41E7A09D-EB7A-436E-935D-780CA2628324}"
    get_Windows(pWindowList)
      => ComCall(7, this.p, IRDPSRAPIWindowList.Ptr, pWindowList)
    get_Id(pRetVal)
      => ComCall(8, this.p, Int32.Ptr, pRetVal)
    get_Shared(pRetVal)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pRetVal)
    put_Shared(NewVal)
      => ComCall(10, this.p, VARIANT_BOOL, NewVal)
    get_Name(pRetVal)
      => ComCall(11, this.p, BSTR.Ptr, pRetVal)
    get_Flags(pdwFlags)
      => ComCall(12, this.p, UInt32.Ptr, pdwFlags)
}
struct IRDPSRAPIApplicationList extends IDispatch {
    static IID := "{D4B4AEB3-22DC-4837-B3B6-42EA2517849A}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(item, pApplication)
      => ComCall(8, this.p, Int32, item, IRDPSRAPIApplication.Ptr, pApplication)
}
struct IRDPSRAPIApplicationFilter extends IDispatch {
    static IID := "{D20F10CA-6637-4F06-B1D5-277EA7E5160D}"
    get_Applications(pApplications)
      => ComCall(7, this.p, IRDPSRAPIApplicationList.Ptr, pApplications)
    get_Windows(pWindows)
      => ComCall(8, this.p, IRDPSRAPIWindowList.Ptr, pWindows)
    get_Enabled(pRetVal)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pRetVal)
    put_Enabled(NewVal)
      => ComCall(10, this.p, VARIANT_BOOL, NewVal)
}
struct IRDPSRAPISessionProperties extends IDispatch {
    static IID := "{339B24F2-9BC0-4F16-9AAC-F165433D13D4}"
    get_Property(PropertyName, pVal)
      => ComCall(7, this.p, BSTR, PropertyName, VARIANT.Ptr, pVal)
    put_Property(PropertyName, newVal)
      => ComCall(8, this.p, BSTR, PropertyName, VARIANT, newVal)
}
struct IRDPSRAPIInvitation extends IDispatch {
    static IID := "{4FAC1D43-FC51-45BB-B1B4-2B53AA562FA3}"
    get_ConnectionString(pbstrVal)
      => ComCall(7, this.p, BSTR.Ptr, pbstrVal)
    get_GroupName(pbstrVal)
      => ComCall(8, this.p, BSTR.Ptr, pbstrVal)
    get_Password(pbstrVal)
      => ComCall(9, this.p, BSTR.Ptr, pbstrVal)
    get_AttendeeLimit(pRetVal)
      => ComCall(10, this.p, Int32.Ptr, pRetVal)
    put_AttendeeLimit(NewVal)
      => ComCall(11, this.p, Int32, NewVal)
    get_Revoked(pRetVal)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pRetVal)
    put_Revoked(NewVal)
      => ComCall(13, this.p, VARIANT_BOOL, NewVal)
}
struct IRDPSRAPIInvitationManager extends IDispatch {
    static IID := "{4722B049-92C3-4C2D-8A65-F7348F644DCF}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(item, ppInvitation)
      => ComCall(8, this.p, VARIANT, item, IRDPSRAPIInvitation.Ptr, ppInvitation)
    get_Count(pRetVal)
      => ComCall(9, this.p, Int32.Ptr, pRetVal)
    CreateInvitation(bstrAuthString, bstrGroupName, bstrPassword, AttendeeLimit, ppInvitation)
      => ComCall(10, this.p, BSTR, bstrAuthString, BSTR, bstrGroupName, BSTR, bstrPassword, Int32, AttendeeLimit, IRDPSRAPIInvitation.Ptr, ppInvitation)
}
struct IRDPSRAPITcpConnectionInfo extends IDispatch {
    static IID := "{F74049A4-3D06-4028-8193-0A8C29BC2452}"
    get_Protocol(plProtocol)
      => ComCall(7, this.p, Int32.Ptr, plProtocol)
    get_LocalPort(plPort)
      => ComCall(8, this.p, Int32.Ptr, plPort)
    get_LocalIP(pbsrLocalIP)
      => ComCall(9, this.p, BSTR.Ptr, pbsrLocalIP)
    get_PeerPort(plPort)
      => ComCall(10, this.p, Int32.Ptr, plPort)
    get_PeerIP(pbstrIP)
      => ComCall(11, this.p, BSTR.Ptr, pbstrIP)
}
struct IRDPSRAPIAttendee extends IDispatch {
    static IID := "{EC0671B3-1B78-4B80-A464-9132247543E3}"
    get_Id(pId)
      => ComCall(7, this.p, Int32.Ptr, pId)
    get_RemoteName(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_ControlLevel(pVal)
      => ComCall(9, this.p, CTRL_LEVEL.Ptr, pVal)
    put_ControlLevel(pNewVal)
      => ComCall(10, this.p, CTRL_LEVEL, pNewVal)
    get_Invitation(ppVal)
      => ComCall(11, this.p, IRDPSRAPIInvitation.Ptr, ppVal)
    TerminateConnection()
      => ComCall(12, this.p)
    get_Flags(plFlags)
      => ComCall(13, this.p, Int32.Ptr, plFlags)
    get_ConnectivityInfo(ppVal)
      => ComCall(14, this.p, IUnknown.Ptr, ppVal)
}
struct IRDPSRAPIAttendeeManager extends IDispatch {
    static IID := "{BA3A37E8-33DA-4749-8DA0-07FA34DA7944}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(id, ppItem)
      => ComCall(8, this.p, Int32, id, IRDPSRAPIAttendee.Ptr, ppItem)
}
struct IRDPSRAPIAttendeeDisconnectInfo extends IDispatch {
    static IID := "{C187689F-447C-44A1-9C14-FFFBB3B7EC17}"
    get_Attendee(retval)
      => ComCall(7, this.p, IRDPSRAPIAttendee.Ptr, retval)
    get_Reason(pReason)
      => ComCall(8, this.p, ATTENDEE_DISCONNECT_REASON.Ptr, pReason)
    get_Code(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
}
struct IRDPSRAPIVirtualChannel extends IDispatch {
    static IID := "{05E12F95-28B3-4C9A-8780-D0248574A1E0}"
    SendData(bstrData, lAttendeeId, ChannelSendFlags)
      => ComCall(7, this.p, BSTR, bstrData, Int32, lAttendeeId, UInt32, ChannelSendFlags)
    SetAccess(lAttendeeId, AccessType)
      => ComCall(8, this.p, Int32, lAttendeeId, CHANNEL_ACCESS_ENUM, AccessType)
    get_Name(pbstrName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrName)
    get_Flags(plFlags)
      => ComCall(10, this.p, Int32.Ptr, plFlags)
    get_Priority(pPriority)
      => ComCall(11, this.p, CHANNEL_PRIORITY.Ptr, pPriority)
}
struct IRDPSRAPIVirtualChannelManager extends IDispatch {
    static IID := "{0D11C661-5D0D-4EE4-89DF-2166AE1FDFED}"
    get__NewEnum(retval)
      => ComCall(7, this.p, IUnknown.Ptr, retval)
    get_Item(item, pChannel)
      => ComCall(8, this.p, VARIANT, item, IRDPSRAPIVirtualChannel.Ptr, pChannel)
    CreateVirtualChannel(bstrChannelName, Priority, ChannelFlags, ppChannel)
      => ComCall(9, this.p, BSTR, bstrChannelName, CHANNEL_PRIORITY, Priority, UInt32, ChannelFlags, IRDPSRAPIVirtualChannel.Ptr, ppChannel)
}
struct IRDPSRAPIViewer extends IDispatch {
    static IID := "{C6BFCD38-8CE9-404D-8AE8-F31D00C65CB5}"
    Connect(bstrConnectionString, bstrName, bstrPassword)
      => ComCall(7, this.p, BSTR, bstrConnectionString, BSTR, bstrName, BSTR, bstrPassword)
    Disconnect()
      => ComCall(8, this.p)
    get_Attendees(ppVal)
      => ComCall(9, this.p, IRDPSRAPIAttendeeManager.Ptr, ppVal)
    get_Invitations(ppVal)
      => ComCall(10, this.p, IRDPSRAPIInvitationManager.Ptr, ppVal)
    get_ApplicationFilter(ppVal)
      => ComCall(11, this.p, IRDPSRAPIApplicationFilter.Ptr, ppVal)
    get_VirtualChannelManager(ppVal)
      => ComCall(12, this.p, IRDPSRAPIVirtualChannelManager.Ptr, ppVal)
    put_SmartSizing(vbSmartSizing)
      => ComCall(13, this.p, VARIANT_BOOL, vbSmartSizing)
    get_SmartSizing(pvbSmartSizing)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pvbSmartSizing)
    RequestControl(CtrlLevel)
      => ComCall(15, this.p, CTRL_LEVEL, CtrlLevel)
    put_DisconnectedText(bstrDisconnectedText)
      => ComCall(16, this.p, BSTR, bstrDisconnectedText)
    get_DisconnectedText(pbstrDisconnectedText)
      => ComCall(17, this.p, BSTR.Ptr, pbstrDisconnectedText)
    RequestColorDepthChange(Bpp)
      => ComCall(18, this.p, Int32, Bpp)
    get_Properties(ppVal)
      => ComCall(19, this.p, IRDPSRAPISessionProperties.Ptr, ppVal)
    StartReverseConnectListener(bstrConnectionString, bstrUserName, bstrPassword, pbstrReverseConnectString)
      => ComCall(20, this.p, BSTR, bstrConnectionString, BSTR, bstrUserName, BSTR, bstrPassword, BSTR.Ptr, pbstrReverseConnectString)
}
struct IRDPViewerInputSink extends IUnknown {
    static IID := "{BB590853-A6C5-4A7B-8DD4-76B69EEA12D5}"
    SendMouseButtonEvent(buttonType, vbButtonDown, xPos, yPos)
      => ComCall(3, this.p, RDPSRAPI_MOUSE_BUTTON_TYPE, buttonType, VARIANT_BOOL, vbButtonDown, UInt32, xPos, UInt32, yPos)
    SendMouseMoveEvent(xPos, yPos)
      => ComCall(4, this.p, UInt32, xPos, UInt32, yPos)
    SendMouseWheelEvent(wheelRotation)
      => ComCall(5, this.p, UInt16, wheelRotation)
    SendKeyboardEvent(codeType, keycode, vbKeyUp, vbRepeat, vbExtended)
      => ComCall(6, this.p, RDPSRAPI_KBD_CODE_TYPE, codeType, UInt16, keycode, VARIANT_BOOL, vbKeyUp, VARIANT_BOOL, vbRepeat, VARIANT_BOOL, vbExtended)
    SendSyncEvent(syncFlags)
      => ComCall(7, this.p, UInt32, syncFlags)
    BeginTouchFrame()
      => ComCall(8, this.p)
    AddTouchInput(contactId, event, x, y)
      => ComCall(9, this.p, UInt32, contactId, UInt32, event, Int32, x, Int32, y)
    EndTouchFrame()
      => ComCall(10, this.p)
}
struct IRDPSRAPIFrameBuffer extends IDispatch {
    static IID := "{3D67E7D2-B27B-448E-81B3-C6110ED8B4BE}"
    get_Width(plWidth)
      => ComCall(7, this.p, Int32.Ptr, plWidth)
    get_Height(plHeight)
      => ComCall(8, this.p, Int32.Ptr, plHeight)
    get_Bpp(plBpp)
      => ComCall(9, this.p, Int32.Ptr, plBpp)
    GetFrameBufferBits(x, y, Width, Heigth, ppBits)
      => ComCall(10, this.p, Int32, x, Int32, y, Int32, Width, Int32, Heigth, SAFEARRAY.Ptr.Ptr, ppBits)
}
struct IRDPSRAPITransportStreamBuffer extends IUnknown {
    static IID := "{81C80290-5085-44B0-B460-F865C39CB4A9}"
    get_Storage(ppbStorage)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppbStorage)
    get_StorageSize(plMaxStore)
      => ComCall(4, this.p, Int32.Ptr, plMaxStore)
    get_PayloadSize(plRetVal)
      => ComCall(5, this.p, Int32.Ptr, plRetVal)
    put_PayloadSize(lVal)
      => ComCall(6, this.p, Int32, lVal)
    get_PayloadOffset(plRetVal)
      => ComCall(7, this.p, Int32.Ptr, plRetVal)
    put_PayloadOffset(lRetVal)
      => ComCall(8, this.p, Int32, lRetVal)
    get_Flags(plFlags)
      => ComCall(9, this.p, Int32.Ptr, plFlags)
    put_Flags(lFlags)
      => ComCall(10, this.p, Int32, lFlags)
    get_Context(ppContext)
      => ComCall(11, this.p, IUnknown.Ptr, ppContext)
    put_Context(pContext)
      => ComCall(12, this.p, IUnknown, pContext)
}
struct IRDPSRAPITransportStreamEvents extends IUnknown {
    static IID := "{EA81C254-F5AF-4E40-982E-3E63BB595276}"
    OnWriteCompleted(pBuffer)
      => ComCall(3, this.p, IRDPSRAPITransportStreamBuffer, pBuffer, "void")
    OnReadCompleted(pBuffer)
      => ComCall(4, this.p, IRDPSRAPITransportStreamBuffer, pBuffer, "void")
    OnStreamClosed(hrReason)
      => ComCall(5, this.p, HRESULT, hrReason, "void")
}
struct IRDPSRAPITransportStream extends IUnknown {
    static IID := "{36CFA065-43BB-4EF7-AED7-9B88A5053036}"
    AllocBuffer(maxPayload, ppBuffer)
      => ComCall(3, this.p, Int32, maxPayload, IRDPSRAPITransportStreamBuffer.Ptr, ppBuffer)
    FreeBuffer(pBuffer)
      => ComCall(4, this.p, IRDPSRAPITransportStreamBuffer, pBuffer)
    WriteBuffer(pBuffer)
      => ComCall(5, this.p, IRDPSRAPITransportStreamBuffer, pBuffer)
    ReadBuffer(pBuffer)
      => ComCall(6, this.p, IRDPSRAPITransportStreamBuffer, pBuffer)
    Open(pCallbacks)
      => ComCall(7, this.p, IRDPSRAPITransportStreamEvents, pCallbacks)
    Close()
      => ComCall(8, this.p)
}
struct IRDPSRAPISharingSession extends IDispatch {
    static IID := "{EEB20886-E470-4CF6-842B-2739C0EC5CFB}"
    Open()
      => ComCall(7, this.p)
    Close()
      => ComCall(8, this.p)
    put_ColorDepth(colorDepth)
      => ComCall(9, this.p, Int32, colorDepth)
    get_ColorDepth(pColorDepth)
      => ComCall(10, this.p, Int32.Ptr, pColorDepth)
    get_Properties(ppVal)
      => ComCall(11, this.p, IRDPSRAPISessionProperties.Ptr, ppVal)
    get_Attendees(ppVal)
      => ComCall(12, this.p, IRDPSRAPIAttendeeManager.Ptr, ppVal)
    get_Invitations(ppVal)
      => ComCall(13, this.p, IRDPSRAPIInvitationManager.Ptr, ppVal)
    get_ApplicationFilter(ppVal)
      => ComCall(14, this.p, IRDPSRAPIApplicationFilter.Ptr, ppVal)
    get_VirtualChannelManager(ppVal)
      => ComCall(15, this.p, IRDPSRAPIVirtualChannelManager.Ptr, ppVal)
    Pause()
      => ComCall(16, this.p)
    Resume()
      => ComCall(17, this.p)
    ConnectToClient(bstrConnectionString)
      => ComCall(18, this.p, BSTR, bstrConnectionString)
    SetDesktopSharedRect(left, top, right, bottom)
      => ComCall(19, this.p, Int32, left, Int32, top, Int32, right, Int32, bottom)
    GetDesktopSharedRect(pleft, ptop, pright, pbottom)
      => ComCall(20, this.p, Int32.Ptr, pleft, Int32.Ptr, ptop, Int32.Ptr, pright, Int32.Ptr, pbottom)
}
struct IRDPSRAPISharingSession2 extends IRDPSRAPISharingSession {
    static IID := "{FEE4EE57-E3E8-4205-8FB0-8FD1D0675C21}"
    ConnectUsingTransportStream(pStream, bstrGroup, bstrAuthenticatedAttendeeName)
      => ComCall(21, this.p, IRDPSRAPITransportStream, pStream, BSTR, bstrGroup, BSTR, bstrAuthenticatedAttendeeName)
    get_FrameBuffer(ppVal)
      => ComCall(22, this.p, IRDPSRAPIFrameBuffer.Ptr, ppVal)
    SendControlLevelChangeResponse(pAttendee, RequestedLevel, ReasonCode)
      => ComCall(23, this.p, IRDPSRAPIAttendee, pAttendee, CTRL_LEVEL, RequestedLevel, Int32, ReasonCode)
}
struct RDPENCOMAPI_CONSTANTS extends Int32 {
    static CONST_MAX_CHANNEL_MESSAGE_SIZE := 1024
    static CONST_MAX_CHANNEL_NAME_LEN := 8
    static CONST_MAX_LEGACY_CHANNEL_MESSAGE_SIZE := 409600
    static CONST_ATTENDEE_ID_EVERYONE := -1
    static CONST_ATTENDEE_ID_HOST := 0
    static CONST_CONN_INTERVAL := 50
    static CONST_ATTENDEE_ID_DEFAULT := -1
}
struct ReferenceRemainingTypes__ {
    __ctrlLevel__ : CTRL_LEVEL
    __attendeeDisconnectReason__ : ATTENDEE_DISCONNECT_REASON
    __channelPriority__ : CHANNEL_PRIORITY
    __channelFlags__ : CHANNEL_FLAGS
    __channelAccessEnum__ : CHANNEL_ACCESS_ENUM
    __rdpencomapiAttendeeFlags__ : RDPENCOMAPI_ATTENDEE_FLAGS
    __rdpsrapiWndFlags__ : RDPSRAPI_WND_FLAGS
    __rdpsrapiAppFlags__ : RDPSRAPI_APP_FLAGS
}
struct IRDPSessionEvents extends IDispatch {
    static IID := "{98A97042-6698-40E9-8EFD-B3200990004B}"
}
