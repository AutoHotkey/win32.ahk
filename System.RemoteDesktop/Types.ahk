#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HANDLE, HANDLE_PTR, HRESULT, HWND, PSTR, PWSTR, RECT, VARIANT_BOOL}
#Import "..\Media.Audio\Types.ahk" {WAVEFORMATEX}
#Import "..\Media.Audio.Apo\Types.ahk" {APO_CONNECTION_PROPERTY}
#Import "..\Security\Types.ahk" {PSID}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\System.WinRT\Types.ahk" {HSTRING}

struct WTS_SECURITY_FLAGS extends UInt32 {
    static WTS_SECURITY_CURRENT_GUEST_ACCESS := 72
    static WTS_SECURITY_USER_ACCESS := 329
    static WTS_SECURITY_CURRENT_USER_ACCESS := 590
    static WTS_SECURITY_ALL_ACCESS := 983999
    static WTS_SECURITY_QUERY_INFORMATION := 1
    static WTS_SECURITY_SET_INFORMATION := 2
    static WTS_SECURITY_RESET := 4
    static WTS_SECURITY_VIRTUAL_CHANNELS := 8
    static WTS_SECURITY_REMOTE_CONTROL := 16
    static WTS_SECURITY_LOGON := 32
    static WTS_SECURITY_LOGOFF := 64
    static WTS_SECURITY_MESSAGE := 128
    static WTS_SECURITY_CONNECT := 256
    static WTS_SECURITY_DISCONNECT := 512
    static WTS_SECURITY_GUEST_ACCESS := 32
}
struct AE_POSITION_FLAGS extends Int32 {
    static POSITION_INVALID := 0
    static POSITION_DISCONTINUOUS := 1
    static POSITION_CONTINUOUS := 2
    static POSITION_QPC_ERROR := 4
}
struct AE_CURRENT_POSITION {
    u64DevicePosition : Int64
    u64StreamPosition : Int64
    u64PaddingFrames : Int64
    hnsQPCPosition : Int64
    f32FramesPerSecond : Float32
    Flag : AE_POSITION_FLAGS
}
struct IAudioEndpoint extends IUnknown {
    static IID := "{30A99515-1527-4451-AF9F-00C5F0234DAF}"
    GetFrameFormat(ppFormat)
      => ComCall(3, this.p, WAVEFORMATEX.Ptr.Ptr, ppFormat)
    GetFramesPerPacket(pFramesPerPacket)
      => ComCall(4, this.p, UInt32.Ptr, pFramesPerPacket)
    GetLatency(pLatency)
      => ComCall(5, this.p, Int64.Ptr, pLatency)
    SetStreamFlags(streamFlags)
      => ComCall(6, this.p, UInt32, streamFlags)
    SetEventHandle(eventHandle)
      => ComCall(7, this.p, HANDLE, eventHandle)
}
struct IAudioEndpointRT extends IUnknown {
    static IID := "{DFD2005F-A6E5-4D39-A265-939ADA9FBB4D}"
    GetCurrentPadding(pPadding, pAeCurrentPosition)
      => ComCall(3, this.p, Int64.Ptr, pPadding, AE_CURRENT_POSITION.Ptr, pAeCurrentPosition, "void")
    ProcessingComplete()
      => ComCall(4, this.p, "void")
    SetPinInactive()
      => ComCall(5, this.p)
    SetPinActive()
      => ComCall(6, this.p)
}
struct IAudioInputEndpointRT extends IUnknown {
    static IID := "{8026AB61-92B2-43C1-A1DF-5C37EBD08D82}"
    GetInputDataPointer(pConnectionProperty, pAeTimeStamp)
      => ComCall(3, this.p, APO_CONNECTION_PROPERTY.Ptr, pConnectionProperty, AE_CURRENT_POSITION.Ptr, pAeTimeStamp, "void")
    ReleaseInputDataPointer(u32FrameCount, pDataPointer)
      => ComCall(4, this.p, UInt32, u32FrameCount, IntPtr, pDataPointer, "void")
    PulseEndpoint()
      => ComCall(5, this.p, "void")
}
struct IAudioOutputEndpointRT extends IUnknown {
    static IID := "{8FA906E4-C31C-4E31-932E-19A66385E9AA}"
    GetOutputDataPointer(u32FrameCount, pAeTimeStamp)
      => ComCall(3, this.p, UInt32, u32FrameCount, AE_CURRENT_POSITION.Ptr, pAeTimeStamp, IntPtr)
    ReleaseOutputDataPointer(pConnectionProperty)
      => ComCall(4, this.p, APO_CONNECTION_PROPERTY.Ptr, pConnectionProperty, "void")
    PulseEndpoint()
      => ComCall(5, this.p, "void")
}
struct IAudioDeviceEndpoint extends IUnknown {
    static IID := "{D4952F5A-A0B2-4CC4-8B82-9358488DD8AC}"
    SetBuffer(MaxPeriod, u32LatencyCoefficient)
      => ComCall(3, this.p, Int64, MaxPeriod, UInt32, u32LatencyCoefficient)
    GetRTCaps(pbIsRTCapable)
      => ComCall(4, this.p, BOOL.Ptr, pbIsRTCapable)
    GetEventDrivenCapable(pbisEventCapable)
      => ComCall(5, this.p, BOOL.Ptr, pbisEventCapable)
    WriteExclusiveModeParametersToSharedMemory(hTargetProcess, hnsPeriod, hnsBufferDuration, u32LatencyCoefficient, pu32SharedMemorySize, phSharedMemory)
      => ComCall(6, this.p, IntPtr, hTargetProcess, Int64, hnsPeriod, Int64, hnsBufferDuration, UInt32, u32LatencyCoefficient, UInt32.Ptr, pu32SharedMemorySize, IntPtr.Ptr, phSharedMemory)
}
struct IAudioEndpointControl extends IUnknown {
    static IID := "{C684B72A-6DF4-4774-BDF9-76B77509B653}"
    Start()
      => ComCall(3, this.p)
    Reset()
      => ComCall(4, this.p)
    Stop()
      => ComCall(5, this.p)
}
struct WTS_CLOUD_AUTH_HANDLE {
    Value : Struct.Ptr
}
struct IADsTSUserEx extends IDispatch {
    static IID := "{C4930E79-2989-4462-8A60-2FCF2F2955EF}"
    get_TerminalServicesProfilePath(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    put_TerminalServicesProfilePath(pNewVal)
      => ComCall(8, this.p, BSTR, pNewVal)
    get_TerminalServicesHomeDirectory(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    put_TerminalServicesHomeDirectory(pNewVal)
      => ComCall(10, this.p, BSTR, pNewVal)
    get_TerminalServicesHomeDrive(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    put_TerminalServicesHomeDrive(pNewVal)
      => ComCall(12, this.p, BSTR, pNewVal)
    get_AllowLogon(pVal)
      => ComCall(13, this.p, Int32.Ptr, pVal)
    put_AllowLogon(NewVal)
      => ComCall(14, this.p, Int32, NewVal)
    get_EnableRemoteControl(pVal)
      => ComCall(15, this.p, Int32.Ptr, pVal)
    put_EnableRemoteControl(NewVal)
      => ComCall(16, this.p, Int32, NewVal)
    get_MaxDisconnectionTime(pVal)
      => ComCall(17, this.p, Int32.Ptr, pVal)
    put_MaxDisconnectionTime(NewVal)
      => ComCall(18, this.p, Int32, NewVal)
    get_MaxConnectionTime(pVal)
      => ComCall(19, this.p, Int32.Ptr, pVal)
    put_MaxConnectionTime(NewVal)
      => ComCall(20, this.p, Int32, NewVal)
    get_MaxIdleTime(pVal)
      => ComCall(21, this.p, Int32.Ptr, pVal)
    put_MaxIdleTime(NewVal)
      => ComCall(22, this.p, Int32, NewVal)
    get_ReconnectionAction(pNewVal)
      => ComCall(23, this.p, Int32.Ptr, pNewVal)
    put_ReconnectionAction(NewVal)
      => ComCall(24, this.p, Int32, NewVal)
    get_BrokenConnectionAction(pNewVal)
      => ComCall(25, this.p, Int32.Ptr, pNewVal)
    put_BrokenConnectionAction(NewVal)
      => ComCall(26, this.p, Int32, NewVal)
    get_ConnectClientDrivesAtLogon(pNewVal)
      => ComCall(27, this.p, Int32.Ptr, pNewVal)
    put_ConnectClientDrivesAtLogon(NewVal)
      => ComCall(28, this.p, Int32, NewVal)
    get_ConnectClientPrintersAtLogon(pVal)
      => ComCall(29, this.p, Int32.Ptr, pVal)
    put_ConnectClientPrintersAtLogon(NewVal)
      => ComCall(30, this.p, Int32, NewVal)
    get_DefaultToMainPrinter(pVal)
      => ComCall(31, this.p, Int32.Ptr, pVal)
    put_DefaultToMainPrinter(NewVal)
      => ComCall(32, this.p, Int32, NewVal)
    get_TerminalServicesWorkDirectory(pVal)
      => ComCall(33, this.p, BSTR.Ptr, pVal)
    put_TerminalServicesWorkDirectory(pNewVal)
      => ComCall(34, this.p, BSTR, pNewVal)
    get_TerminalServicesInitialProgram(pVal)
      => ComCall(35, this.p, BSTR.Ptr, pVal)
    put_TerminalServicesInitialProgram(pNewVal)
      => ComCall(36, this.p, BSTR, pNewVal)
}
struct AAAuthSchemes extends Int32 {
    static AA_AUTH_MIN := 0
    static AA_AUTH_BASIC := 1
    static AA_AUTH_NTLM := 2
    static AA_AUTH_SC := 3
    static AA_AUTH_LOGGEDONCREDENTIALS := 4
    static AA_AUTH_NEGOTIATE := 5
    static AA_AUTH_ANY := 6
    static AA_AUTH_COOKIE := 7
    static AA_AUTH_DIGEST := 8
    static AA_AUTH_ORGID := 9
    static AA_AUTH_CONID := 10
    static AA_AUTH_SSPI_NTLM := 11
    static AA_AUTH_MAX := 12
}
struct AAAccountingDataType extends Int32 {
    static AA_MAIN_SESSION_CREATION := 0
    static AA_SUB_SESSION_CREATION := 1
    static AA_SUB_SESSION_CLOSED := 2
    static AA_MAIN_SESSION_CLOSED := 3
}
struct AAAccountingData {
    userName : BSTR
    clientName : BSTR
    authType : AAAuthSchemes
    resourceName : BSTR
    portNumber : Int32
    protocolName : BSTR
    numberOfBytesReceived : Int32
    numberOfBytesTransfered : Int32
    reasonForDisconnect : BSTR
    mainSessionId : GUID
    subSessionId : Int32
}
struct SESSION_TIMEOUT_ACTION_TYPE extends Int32 {
    static SESSION_TIMEOUT_ACTION_DISCONNECT := 0
    static SESSION_TIMEOUT_ACTION_SILENT_REAUTH := 1
}
struct PolicyAttributeType extends Int32 {
    static EnableAllRedirections := 0
    static DisableAllRedirections := 1
    static DriveRedirectionDisabled := 2
    static PrinterRedirectionDisabled := 3
    static PortRedirectionDisabled := 4
    static ClipboardRedirectionDisabled := 5
    static PnpRedirectionDisabled := 6
    static AllowOnlySDRServers := 7
}
struct AATrustClassID extends Int32 {
    static AA_UNTRUSTED := 0
    static AA_TRUSTEDUSER_UNTRUSTEDCLIENT := 1
    static AA_TRUSTEDUSER_TRUSTEDCLIENT := 2
}
struct ITSGAuthorizeConnectionSink extends IUnknown {
    static IID := "{C27ECE33-7781-4318-98EF-1CF2DA7B7005}"
    OnConnectionAuthorized(hrIn, mainSessionId, pbSoHResponse, idleTimeout, sessionTimeout, sessionTimeoutAction, trustClass, policyAttributes)
      => ComCall(3, this.p, HRESULT, hrIn, GUID, mainSessionId, UInt32, pbSoHResponse.Length, UInt8.Ptr, pbSoHResponse, UInt32, idleTimeout, UInt32, sessionTimeout, SESSION_TIMEOUT_ACTION_TYPE, sessionTimeoutAction, AATrustClassID, trustClass, UInt32.Ptr, policyAttributes)
}
struct ITSGAuthorizeResourceSink extends IUnknown {
    static IID := "{FEDDFCD4-FA12-4435-AE55-7AD1A9779AF7}"
    OnChannelAuthorized(hrIn, mainSessionId, subSessionId, allowedResourceNames, failedResourceNames)
      => ComCall(3, this.p, HRESULT, hrIn, GUID, mainSessionId, Int32, subSessionId, BSTR.Ptr, allowedResourceNames, UInt32, allowedResourceNames.Length, BSTR.Ptr, failedResourceNames, UInt32, failedResourceNames.Length)
}
struct ITSGPolicyEngine extends IUnknown {
    static IID := "{8BC24F08-6223-42F4-A5B4-8E37CD135BBD}"
    AuthorizeConnection(mainSessionId, username, authType, clientMachineIP, clientMachineName, sohData, cookieData, userToken, pSink)
      => ComCall(3, this.p, GUID, mainSessionId, BSTR, username, AAAuthSchemes, authType, BSTR, clientMachineIP, BSTR, clientMachineName, UInt8.Ptr, sohData, UInt32, sohData.Length, UInt8.Ptr, cookieData, UInt32, cookieData.Length, HANDLE_PTR, userToken, ITSGAuthorizeConnectionSink, pSink)
    AuthorizeResource(mainSessionId, subSessionId, username, resourceNames, alternateResourceNames, portNumber, operation, cookie, pSink)
      => ComCall(4, this.p, GUID, mainSessionId, Int32, subSessionId, BSTR, username, BSTR.Ptr, resourceNames, UInt32, resourceNames.Length, BSTR.Ptr, alternateResourceNames, UInt32, alternateResourceNames.Length, UInt32, portNumber, BSTR, operation, UInt8.Ptr, cookie, UInt32, cookie.Length, ITSGAuthorizeResourceSink, pSink)
    Refresh()
      => ComCall(5, this.p)
    IsQuarantineEnabled(quarantineEnabled)
      => ComCall(6, this.p, BOOL.Ptr, quarantineEnabled)
}
struct ITSGAccountingEngine extends IUnknown {
    static IID := "{4CE2A0C9-E874-4F1A-86F4-06BBB9115338}"
    DoAccounting(accountingDataType, accountingData)
      => ComCall(3, this.p, AAAccountingDataType, accountingDataType, AAAccountingData, accountingData)
}
struct ITSGAuthenticateUserSink extends IUnknown {
    static IID := "{2C3E2E73-A782-47F9-8DFB-77EE1ED27A03}"
    OnUserAuthenticated(userName, userDomain, context, userToken)
      => ComCall(3, this.p, BSTR, userName, BSTR, userDomain, IntPtr, context, HANDLE_PTR, userToken)
    OnUserAuthenticationFailed(context, genericErrorCode, specificErrorCode)
      => ComCall(4, this.p, IntPtr, context, HRESULT, genericErrorCode, HRESULT, specificErrorCode)
    ReauthenticateUser(context)
      => ComCall(5, this.p, IntPtr, context)
    DisconnectUser(context)
      => ComCall(6, this.p, IntPtr, context)
}
struct ITSGAuthenticationEngine extends IUnknown {
    static IID := "{9EE3E5BF-04AB-4691-998C-D7F622321A56}"
    AuthenticateUser(mainSessionId, cookieData, numCookieBytes, context, pSink)
      => ComCall(3, this.p, GUID, mainSessionId, UInt8.Ptr, cookieData, UInt32, numCookieBytes, IntPtr, context, ITSGAuthenticateUserSink, pSink)
    CancelAuthentication(mainSessionId, context)
      => ComCall(4, this.p, GUID, mainSessionId, IntPtr, context)
}
struct WTS_CONNECTSTATE_CLASS extends Int32 {
    static WTSActive := 0
    static WTSConnected := 1
    static WTSConnectQuery := 2
    static WTSShadow := 3
    static WTSDisconnected := 4
    static WTSIdle := 5
    static WTSListen := 6
    static WTSReset := 7
    static WTSDown := 8
    static WTSInit := 9
}
struct WTS_SERVER_INFOW {
    pServerName : PWSTR
}
struct WTS_SERVER_INFOA {
    pServerName : PSTR
}
struct WTS_SESSION_INFOW {
    SessionId : UInt32
    pWinStationName : PWSTR
    State : WTS_CONNECTSTATE_CLASS
}
struct WTS_SESSION_INFOA {
    SessionId : UInt32
    pWinStationName : PSTR
    State : WTS_CONNECTSTATE_CLASS
}
struct WTS_SESSION_INFO_1W {
    ExecEnvId : UInt32
    State : WTS_CONNECTSTATE_CLASS
    SessionId : UInt32
    pSessionName : PWSTR
    pHostName : PWSTR
    pUserName : PWSTR
    pDomainName : PWSTR
    pFarmName : PWSTR
}
struct WTS_SESSION_INFO_1A {
    ExecEnvId : UInt32
    State : WTS_CONNECTSTATE_CLASS
    SessionId : UInt32
    pSessionName : PSTR
    pHostName : PSTR
    pUserName : PSTR
    pDomainName : PSTR
    pFarmName : PSTR
}
struct WTS_PROCESS_INFOW {
    SessionId : UInt32
    ProcessId : UInt32
    pProcessName : PWSTR
    pUserSid : PSID
}
struct WTS_PROCESS_INFOA {
    SessionId : UInt32
    ProcessId : UInt32
    pProcessName : PSTR
    pUserSid : PSID
}
struct WTS_INFO_CLASS extends Int32 {
    static WTSInitialProgram := 0
    static WTSApplicationName := 1
    static WTSWorkingDirectory := 2
    static WTSOEMId := 3
    static WTSSessionId := 4
    static WTSUserName := 5
    static WTSWinStationName := 6
    static WTSDomainName := 7
    static WTSConnectState := 8
    static WTSClientBuildNumber := 9
    static WTSClientName := 10
    static WTSClientDirectory := 11
    static WTSClientProductId := 12
    static WTSClientHardwareId := 13
    static WTSClientAddress := 14
    static WTSClientDisplay := 15
    static WTSClientProtocolType := 16
    static WTSIdleTime := 17
    static WTSLogonTime := 18
    static WTSIncomingBytes := 19
    static WTSOutgoingBytes := 20
    static WTSIncomingFrames := 21
    static WTSOutgoingFrames := 22
    static WTSClientInfo := 23
    static WTSSessionInfo := 24
    static WTSSessionInfoEx := 25
    static WTSConfigInfo := 26
    static WTSValidationInfo := 27
    static WTSSessionAddressV4 := 28
    static WTSIsRemoteSession := 29
    static WTSSessionActivityId := 30
    static WTSCapabilityCheck := 31
}
struct WTSCONFIGINFOW {
    version : UInt32
    fConnectClientDrivesAtLogon : UInt32
    fConnectPrinterAtLogon : UInt32
    fDisablePrinterRedirection : UInt32
    fDisableDefaultMainClientPrinter : UInt32
    ShadowSettings : UInt32
    LogonUserName : UInt16[21]
    LogonDomain : UInt16[18]
    WorkDirectory : UInt16[261]
    InitialProgram : UInt16[261]
    ApplicationName : UInt16[261]
}
struct WTSCONFIGINFOA {
    version : UInt32
    fConnectClientDrivesAtLogon : UInt32
    fConnectPrinterAtLogon : UInt32
    fDisablePrinterRedirection : UInt32
    fDisableDefaultMainClientPrinter : UInt32
    ShadowSettings : UInt32
    LogonUserName : CHAR[21]
    LogonDomain : CHAR[18]
    WorkDirectory : CHAR[261]
    InitialProgram : CHAR[261]
    ApplicationName : CHAR[261]
}
struct WTSINFOW {
    State : WTS_CONNECTSTATE_CLASS
    SessionId : UInt32
    IncomingBytes : UInt32
    OutgoingBytes : UInt32
    IncomingFrames : UInt32
    OutgoingFrames : UInt32
    IncomingCompressedBytes : UInt32
    OutgoingCompressedBytes : UInt32
    WinStationName : UInt16[32]
    Domain : UInt16[17]
    UserName : UInt16[21]
    ConnectTime : Int64
    DisconnectTime : Int64
    LastInputTime : Int64
    LogonTime : Int64
    CurrentTime : Int64
}
struct WTSINFOA {
    State : WTS_CONNECTSTATE_CLASS
    SessionId : UInt32
    IncomingBytes : UInt32
    OutgoingBytes : UInt32
    IncomingFrames : UInt32
    OutgoingFrames : UInt32
    IncomingCompressedBytes : UInt32
    OutgoingCompressedBy : UInt32
    WinStationName : CHAR[32]
    Domain : CHAR[17]
    UserName : CHAR[21]
    ConnectTime : Int64
    DisconnectTime : Int64
    LastInputTime : Int64
    LogonTime : Int64
    CurrentTime : Int64
}
struct WTSINFOEX_LEVEL1_W {
    SessionId : UInt32
    SessionState : WTS_CONNECTSTATE_CLASS
    SessionFlags : Int32
    WinStationName : UInt16[33]
    UserName : UInt16[21]
    DomainName : UInt16[18]
    LogonTime : Int64
    ConnectTime : Int64
    DisconnectTime : Int64
    LastInputTime : Int64
    CurrentTime : Int64
    IncomingBytes : UInt32
    OutgoingBytes : UInt32
    IncomingFrames : UInt32
    OutgoingFrames : UInt32
    IncomingCompressedBytes : UInt32
    OutgoingCompressedBytes : UInt32
}
struct WTSINFOEX_LEVEL1_A {
    SessionId : UInt32
    SessionState : WTS_CONNECTSTATE_CLASS
    SessionFlags : Int32
    WinStationName : CHAR[33]
    UserName : CHAR[21]
    DomainName : CHAR[18]
    LogonTime : Int64
    ConnectTime : Int64
    DisconnectTime : Int64
    LastInputTime : Int64
    CurrentTime : Int64
    IncomingBytes : UInt32
    OutgoingBytes : UInt32
    IncomingFrames : UInt32
    OutgoingFrames : UInt32
    IncomingCompressedBytes : UInt32
    OutgoingCompressedBytes : UInt32
}
struct WTSINFOEX_LEVEL_W {
    union {
        WTSInfoExLevel1 : WTSINFOEX_LEVEL1_W
    }
}
struct WTSINFOEX_LEVEL_A {
    union {
        WTSInfoExLevel1 : WTSINFOEX_LEVEL1_A
    }
}
struct WTSINFOEXW {
    Level : UInt32
    Data : WTSINFOEX_LEVEL_W
}
struct WTSINFOEXA {
    Level : UInt32
    Data : WTSINFOEX_LEVEL_A
}
struct WTSCLIENTW {
    ClientName : UInt16[21]
    Domain : UInt16[18]
    UserName : UInt16[21]
    WorkDirectory : UInt16[261]
    InitialProgram : UInt16[261]
    EncryptionLevel : UInt8
    ClientAddressFamily : UInt32
    ClientAddress : UInt16[31]
    HRes : UInt16
    VRes : UInt16
    ColorDepth : UInt16
    ClientDirectory : UInt16[261]
    ClientBuildNumber : UInt32
    ClientHardwareId : UInt32
    ClientProductId : UInt16
    OutBufCountHost : UInt16
    OutBufCountClient : UInt16
    OutBufLength : UInt16
    DeviceId : UInt16[261]
}
struct WTSCLIENTA {
    ClientName : CHAR[21]
    Domain : CHAR[18]
    UserName : CHAR[21]
    WorkDirectory : CHAR[261]
    InitialProgram : CHAR[261]
    EncryptionLevel : UInt8
    ClientAddressFamily : UInt32
    ClientAddress : UInt16[31]
    HRes : UInt16
    VRes : UInt16
    ColorDepth : UInt16
    ClientDirectory : CHAR[261]
    ClientBuildNumber : UInt32
    ClientHardwareId : UInt32
    ClientProductId : UInt16
    OutBufCountHost : UInt16
    OutBufCountClient : UInt16
    OutBufLength : UInt16
    DeviceId : CHAR[261]
}
struct PRODUCT_INFOA {
    CompanyName : CHAR[256]
    ProductID : CHAR[4]
}
struct PRODUCT_INFOW {
    CompanyName : UInt16[256]
    ProductID : UInt16[4]
}
struct WTS_VALIDATION_INFORMATIONA {
    ProductInfo : PRODUCT_INFOA
    License : UInt8[16384]
    LicenseLength : UInt32
    HardwareID : UInt8[20]
    HardwareIDLength : UInt32
}
struct WTS_VALIDATION_INFORMATIONW {
    ProductInfo : PRODUCT_INFOW
    License : UInt8[16384]
    LicenseLength : UInt32
    HardwareID : UInt8[20]
    HardwareIDLength : UInt32
}
struct WTS_CLIENT_ADDRESS {
    AddressFamily : UInt32
    Address : UInt8[20]
}
struct WTS_CLIENT_DISPLAY {
    HorizontalResolution : UInt32
    VerticalResolution : UInt32
    ColorDepth : UInt32
}
struct WTS_CONFIG_CLASS extends Int32 {
    static WTSUserConfigInitialProgram := 0
    static WTSUserConfigWorkingDirectory := 1
    static WTSUserConfigfInheritInitialProgram := 2
    static WTSUserConfigfAllowLogonTerminalServer := 3
    static WTSUserConfigTimeoutSettingsConnections := 4
    static WTSUserConfigTimeoutSettingsDisconnections := 5
    static WTSUserConfigTimeoutSettingsIdle := 6
    static WTSUserConfigfDeviceClientDrives := 7
    static WTSUserConfigfDeviceClientPrinters := 8
    static WTSUserConfigfDeviceClientDefaultPrinter := 9
    static WTSUserConfigBrokenTimeoutSettings := 10
    static WTSUserConfigReconnectSettings := 11
    static WTSUserConfigModemCallbackSettings := 12
    static WTSUserConfigModemCallbackPhoneNumber := 13
    static WTSUserConfigShadowingSettings := 14
    static WTSUserConfigTerminalServerProfilePath := 15
    static WTSUserConfigTerminalServerHomeDir := 16
    static WTSUserConfigTerminalServerHomeDirDrive := 17
    static WTSUserConfigfTerminalServerRemoteHomeDir := 18
    static WTSUserConfigUser := 19
}
struct WTS_CONFIG_SOURCE extends Int32 {
    static WTSUserConfigSourceSAM := 0
}
struct WTSUSERCONFIGA {
    Source : UInt32
    InheritInitialProgram : UInt32
    AllowLogonTerminalServer : UInt32
    TimeoutSettingsConnections : UInt32
    TimeoutSettingsDisconnections : UInt32
    TimeoutSettingsIdle : UInt32
    DeviceClientDrives : UInt32
    DeviceClientPrinters : UInt32
    ClientDefaultPrinter : UInt32
    BrokenTimeoutSettings : UInt32
    ReconnectSettings : UInt32
    ShadowingSettings : UInt32
    TerminalServerRemoteHomeDir : UInt32
    InitialProgram : CHAR[261]
    WorkDirectory : CHAR[261]
    TerminalServerProfilePath : CHAR[261]
    TerminalServerHomeDir : CHAR[261]
    TerminalServerHomeDirDrive : CHAR[4]
}
struct WTSUSERCONFIGW {
    Source : UInt32
    InheritInitialProgram : UInt32
    AllowLogonTerminalServer : UInt32
    TimeoutSettingsConnections : UInt32
    TimeoutSettingsDisconnections : UInt32
    TimeoutSettingsIdle : UInt32
    DeviceClientDrives : UInt32
    DeviceClientPrinters : UInt32
    ClientDefaultPrinter : UInt32
    BrokenTimeoutSettings : UInt32
    ReconnectSettings : UInt32
    ShadowingSettings : UInt32
    TerminalServerRemoteHomeDir : UInt32
    InitialProgram : UInt16[261]
    WorkDirectory : UInt16[261]
    TerminalServerProfilePath : UInt16[261]
    TerminalServerHomeDir : UInt16[261]
    TerminalServerHomeDirDrive : UInt16[4]
}
struct WTS_VIRTUAL_CLASS extends Int32 {
    static WTSVirtualClientData := 0
    static WTSVirtualFileHandle := 1
}
struct WTS_SESSION_ADDRESS {
    AddressFamily : UInt32
    Address : UInt8[20]
}
struct WTS_PROCESS_INFO_EXW {
    SessionId : UInt32
    ProcessId : UInt32
    pProcessName : PWSTR
    pUserSid : PSID
    NumberOfThreads : UInt32
    HandleCount : UInt32
    PagefileUsage : UInt32
    PeakPagefileUsage : UInt32
    WorkingSetSize : UInt32
    PeakWorkingSetSize : UInt32
    UserTime : Int64
    KernelTime : Int64
}
struct WTS_PROCESS_INFO_EXA {
    SessionId : UInt32
    ProcessId : UInt32
    pProcessName : PSTR
    pUserSid : PSID
    NumberOfThreads : UInt32
    HandleCount : UInt32
    PagefileUsage : UInt32
    PeakPagefileUsage : UInt32
    WorkingSetSize : UInt32
    PeakWorkingSetSize : UInt32
    UserTime : Int64
    KernelTime : Int64
}
struct WTS_TYPE_CLASS extends Int32 {
    static WTSTypeProcessInfoLevel0 := 0
    static WTSTypeProcessInfoLevel1 := 1
    static WTSTypeSessionInfoLevel1 := 2
    static WTSTypeCloudAuthServerNonce := 3
    static WTSTypeSerializedUserCredential := 4
}
struct WTSLISTENERCONFIGW {
    version : UInt32
    fEnableListener : UInt32
    MaxConnectionCount : UInt32
    fPromptForPassword : UInt32
    fInheritColorDepth : UInt32
    ColorDepth : UInt32
    fInheritBrokenTimeoutSettings : UInt32
    BrokenTimeoutSettings : UInt32
    fDisablePrinterRedirection : UInt32
    fDisableDriveRedirection : UInt32
    fDisableComPortRedirection : UInt32
    fDisableLPTPortRedirection : UInt32
    fDisableClipboardRedirection : UInt32
    fDisableAudioRedirection : UInt32
    fDisablePNPRedirection : UInt32
    fDisableDefaultMainClientPrinter : UInt32
    LanAdapter : UInt32
    PortNumber : UInt32
    fInheritShadowSettings : UInt32
    ShadowSettings : UInt32
    TimeoutSettingsConnection : UInt32
    TimeoutSettingsDisconnection : UInt32
    TimeoutSettingsIdle : UInt32
    SecurityLayer : UInt32
    MinEncryptionLevel : UInt32
    UserAuthentication : UInt32
    Comment : UInt16[61]
    LogonUserName : UInt16[21]
    LogonDomain : UInt16[18]
    WorkDirectory : UInt16[261]
    InitialProgram : UInt16[261]
}
struct WTSLISTENERCONFIGA {
    version : UInt32
    fEnableListener : UInt32
    MaxConnectionCount : UInt32
    fPromptForPassword : UInt32
    fInheritColorDepth : UInt32
    ColorDepth : UInt32
    fInheritBrokenTimeoutSettings : UInt32
    BrokenTimeoutSettings : UInt32
    fDisablePrinterRedirection : UInt32
    fDisableDriveRedirection : UInt32
    fDisableComPortRedirection : UInt32
    fDisableLPTPortRedirection : UInt32
    fDisableClipboardRedirection : UInt32
    fDisableAudioRedirection : UInt32
    fDisablePNPRedirection : UInt32
    fDisableDefaultMainClientPrinter : UInt32
    LanAdapter : UInt32
    PortNumber : UInt32
    fInheritShadowSettings : UInt32
    ShadowSettings : UInt32
    TimeoutSettingsConnection : UInt32
    TimeoutSettingsDisconnection : UInt32
    TimeoutSettingsIdle : UInt32
    SecurityLayer : UInt32
    MinEncryptionLevel : UInt32
    UserAuthentication : UInt32
    Comment : CHAR[61]
    LogonUserName : CHAR[21]
    LogonDomain : CHAR[18]
    WorkDirectory : CHAR[261]
    InitialProgram : CHAR[261]
}
struct WTS_SERIALIZED_USER_CREDENTIAL {
    SerializationLength : UInt32
    Serialization : UInt8.Ptr
}
struct WTSSBX_MACHINE_DRAIN extends Int32 {
    static WTSSBX_MACHINE_DRAIN_UNSPEC := 0
    static WTSSBX_MACHINE_DRAIN_OFF := 1
    static WTSSBX_MACHINE_DRAIN_ON := 2
}
struct WTSSBX_MACHINE_SESSION_MODE extends Int32 {
    static WTSSBX_MACHINE_SESSION_MODE_UNSPEC := 0
    static WTSSBX_MACHINE_SESSION_MODE_SINGLE := 1
    static WTSSBX_MACHINE_SESSION_MODE_MULTIPLE := 2
}
struct WTSSBX_ADDRESS_FAMILY extends Int32 {
    static WTSSBX_ADDRESS_FAMILY_AF_UNSPEC := 0
    static WTSSBX_ADDRESS_FAMILY_AF_INET := 1
    static WTSSBX_ADDRESS_FAMILY_AF_INET6 := 2
    static WTSSBX_ADDRESS_FAMILY_AF_IPX := 3
    static WTSSBX_ADDRESS_FAMILY_AF_NETBIOS := 4
}
struct WTSSBX_IP_ADDRESS {
    AddressFamily : WTSSBX_ADDRESS_FAMILY
    Address : UInt8[16]
    PortNumber : UInt16
    dwScope : UInt32
}
struct WTSSBX_MACHINE_STATE extends Int32 {
    static WTSSBX_MACHINE_STATE_UNSPEC := 0
    static WTSSBX_MACHINE_STATE_READY := 1
    static WTSSBX_MACHINE_STATE_SYNCHRONIZING := 2
}
struct WTSSBX_MACHINE_CONNECT_INFO {
    wczMachineFQDN : UInt16[257]
    wczMachineNetBiosName : UInt16[17]
    dwNumOfIPAddr : UInt32
    IPaddr : WTSSBX_IP_ADDRESS[12]
}
struct WTSSBX_MACHINE_INFO {
    ClientConnectInfo : WTSSBX_MACHINE_CONNECT_INFO
    wczFarmName : UInt16[257]
    InternalIPAddress : WTSSBX_IP_ADDRESS
    dwMaxSessionsLimit : UInt32
    ServerWeight : UInt32
    SingleSessionMode : WTSSBX_MACHINE_SESSION_MODE
    InDrain : WTSSBX_MACHINE_DRAIN
    MachineState : WTSSBX_MACHINE_STATE
}
struct WTSSBX_SESSION_STATE extends Int32 {
    static WTSSBX_SESSION_STATE_UNSPEC := 0
    static WTSSBX_SESSION_STATE_ACTIVE := 1
    static WTSSBX_SESSION_STATE_DISCONNECTED := 2
}
struct WTSSBX_SESSION_INFO {
    wszUserName : UInt16[105]
    wszDomainName : UInt16[257]
    ApplicationType : UInt16[257]
    dwSessionId : UInt32
    CreateTime : FILETIME
    DisconnectTime : FILETIME
    SessionState : WTSSBX_SESSION_STATE
}
struct WTSSBX_NOTIFICATION_TYPE extends Int32 {
    static WTSSBX_NOTIFICATION_REMOVED := 1
    static WTSSBX_NOTIFICATION_CHANGED := 2
    static WTSSBX_NOTIFICATION_ADDED := 4
    static WTSSBX_NOTIFICATION_RESYNC := 8
}
struct IWTSSBPlugin extends IUnknown {
    static IID := "{DC44BE78-B18D-4399-B210-641BF67A002C}"
    Initialize(PluginCapabilities)
      => ComCall(3, this.p, UInt32.Ptr, PluginCapabilities)
    WTSSBX_MachineChangeNotification(NotificationType, MachineId, pMachineInfo)
      => ComCall(4, this.p, WTSSBX_NOTIFICATION_TYPE, NotificationType, Int32, MachineId, WTSSBX_MACHINE_INFO.Ptr, pMachineInfo)
    WTSSBX_SessionChangeNotification(NotificationType, MachineId, SessionInfo)
      => ComCall(5, this.p, WTSSBX_NOTIFICATION_TYPE, NotificationType, Int32, MachineId, UInt32, SessionInfo.Length, WTSSBX_SESSION_INFO.Ptr, SessionInfo)
    WTSSBX_GetMostSuitableServer(UserName, DomainName, ApplicationType, FarmName, pMachineId)
      => ComCall(6, this.p, "Str", UserName, "Str", DomainName, "Str", ApplicationType, "Str", FarmName, Int32.Ptr, pMachineId)
    Terminated()
      => ComCall(7, this.p)
    WTSSBX_GetUserExternalSession(UserName, DomainName, ApplicationType, RedirectorInternalIP, pSessionId, pMachineConnectInfo)
      => ComCall(8, this.p, "Str", UserName, "Str", DomainName, "Str", ApplicationType, WTSSBX_IP_ADDRESS.Ptr, RedirectorInternalIP, UInt32.Ptr, pSessionId, WTSSBX_MACHINE_CONNECT_INFO.Ptr, pMachineConnectInfo)
}
struct CHANNEL_DEF {
    name : CHAR[8]
    options : UInt32
}
struct CHANNEL_PDU_HEADER {
    length : UInt32
    flags : UInt32
}
struct PCHANNEL_INIT_EVENT_FN extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, UInt32, "Void"]
}
struct PCHANNEL_OPEN_EVENT_FN extends FunctionPointer {
    static Types := [UInt32, UInt32, Struct.Ptr, UInt32, UInt32, UInt32, "Void"]
}
struct PVIRTUALCHANNELINIT extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, CHANNEL_DEF.Ptr, Int32, UInt32, PCHANNEL_INIT_EVENT_FN, UInt32]
}
struct PVIRTUALCHANNELOPEN extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32.Ptr, PSTR, PCHANNEL_OPEN_EVENT_FN, UInt32]
}
struct PVIRTUALCHANNELCLOSE extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct PVIRTUALCHANNELWRITE extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32]
}
struct CHANNEL_ENTRY_POINTS {
    cbSize : UInt32 := this.Size
    protocolVersion : UInt32
    pVirtualChannelInit : PVIRTUALCHANNELINIT
    pVirtualChannelOpen : PVIRTUALCHANNELOPEN
    pVirtualChannelClose : PVIRTUALCHANNELCLOSE
    pVirtualChannelWrite : PVIRTUALCHANNELWRITE
}
struct PVIRTUALCHANNELENTRY extends FunctionPointer {
    static Types := [CHANNEL_ENTRY_POINTS.Ptr, BOOL]
}
struct IWorkspaceClientExt extends IUnknown {
    static IID := "{12B952F4-41CA-4F21-A829-A6D07D9A16E5}"
    GetResourceId(bstrWorkspaceId)
      => ComCall(3, this.p, BSTR.Ptr, bstrWorkspaceId)
    GetResourceDisplayName(bstrWorkspaceDisplayName)
      => ComCall(4, this.p, BSTR.Ptr, bstrWorkspaceDisplayName)
    IssueDisconnect()
      => ComCall(5, this.p)
}
struct IWorkspace extends IUnknown {
    static IID := "{B922BBB8-4C55-4FEA-8496-BEB0B44285E5}"
    GetWorkspaceNames(psaWkspNames)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, psaWkspNames)
    StartRemoteApplication(bstrWorkspaceId, psaParams)
      => ComCall(4, this.p, BSTR, bstrWorkspaceId, SAFEARRAY.Ptr, psaParams)
    GetProcessId(pulProcessId)
      => ComCall(5, this.p, UInt32.Ptr, pulProcessId)
}
struct IWorkspace2 extends IWorkspace {
    static IID := "{96D8D7CF-783E-4286-834C-EBC0E95F783C}"
    StartRemoteApplicationEx(bstrWorkspaceId, bstrRequestingAppId, bstrRequestingAppFamilyName, bLaunchIntoImmersiveClient, bstrImmersiveClientActivationContext, psaParams)
      => ComCall(6, this.p, BSTR, bstrWorkspaceId, BSTR, bstrRequestingAppId, BSTR, bstrRequestingAppFamilyName, VARIANT_BOOL, bLaunchIntoImmersiveClient, BSTR, bstrImmersiveClientActivationContext, SAFEARRAY.Ptr, psaParams)
}
struct IWorkspace3 extends IWorkspace2 {
    static IID := "{1BECBE4A-D654-423B-AFEB-BE8D532C13C6}"
    GetClaimsToken2(bstrClaimsHint, bstrUserHint, claimCookie, hwndCredUiParent, rectCredUiParent, pbstrAccessToken)
      => ComCall(7, this.p, BSTR, bstrClaimsHint, BSTR, bstrUserHint, UInt32, claimCookie, UInt32, hwndCredUiParent, RECT, rectCredUiParent, BSTR.Ptr, pbstrAccessToken)
    SetClaimsToken(bstrAccessToken, ullAccessTokenExpiration, bstrRefreshToken)
      => ComCall(8, this.p, BSTR, bstrAccessToken, Int64, ullAccessTokenExpiration, BSTR, bstrRefreshToken)
}
struct IWorkspaceRegistration extends IUnknown {
    static IID := "{B922BBB8-4C55-4FEA-8496-BEB0B44285E6}"
    AddResource(pUnk, pdwCookie)
      => ComCall(3, this.p, IWorkspaceClientExt, pUnk, UInt32.Ptr, pdwCookie)
    RemoveResource(dwCookieConnection)
      => ComCall(4, this.p, UInt32, dwCookieConnection)
}
struct IWorkspaceRegistration2 extends IWorkspaceRegistration {
    static IID := "{CF59F654-39BB-44D8-94D0-4635728957E9}"
    AddResourceEx(pUnk, bstrEventLogUploadAddress, pdwCookie, correlationId)
      => ComCall(5, this.p, IWorkspaceClientExt, pUnk, BSTR, bstrEventLogUploadAddress, UInt32.Ptr, pdwCookie, GUID, correlationId)
    RemoveResourceEx(dwCookieConnection, correlationId)
      => ComCall(6, this.p, UInt32, dwCookieConnection, GUID, correlationId)
}
struct IWorkspaceScriptable extends IDispatch {
    static IID := "{EFEA49A2-DDA5-429D-8F42-B23B92C4C347}"
    DisconnectWorkspace(bstrWorkspaceId)
      => ComCall(7, this.p, BSTR, bstrWorkspaceId)
    StartWorkspace(bstrWorkspaceId, bstrUserName, bstrPassword, bstrWorkspaceParams, lTimeout, lFlags)
      => ComCall(8, this.p, BSTR, bstrWorkspaceId, BSTR, bstrUserName, BSTR, bstrPassword, BSTR, bstrWorkspaceParams, Int32, lTimeout, Int32, lFlags)
    IsWorkspaceCredentialSpecified(bstrWorkspaceId, bCountUnauthenticatedCredentials, pbCredExist)
      => ComCall(9, this.p, BSTR, bstrWorkspaceId, VARIANT_BOOL, bCountUnauthenticatedCredentials, VARIANT_BOOL.Ptr, pbCredExist)
    IsWorkspaceSSOEnabled(pbSSOEnabled)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pbSSOEnabled)
    ClearWorkspaceCredential(bstrWorkspaceId)
      => ComCall(11, this.p, BSTR, bstrWorkspaceId)
    OnAuthenticated(bstrWorkspaceId, bstrUserName)
      => ComCall(12, this.p, BSTR, bstrWorkspaceId, BSTR, bstrUserName)
    DisconnectWorkspaceByFriendlyName(bstrWorkspaceFriendlyName)
      => ComCall(13, this.p, BSTR, bstrWorkspaceFriendlyName)
}
struct IWorkspaceScriptable2 extends IWorkspaceScriptable {
    static IID := "{EFEA49A2-DDA5-429D-8F42-B33BA2C4C348}"
    StartWorkspaceEx(bstrWorkspaceId, bstrWorkspaceFriendlyName, bstrRedirectorName, bstrUserName, bstrPassword, bstrAppContainer, bstrWorkspaceParams, lTimeout, lFlags)
      => ComCall(14, this.p, BSTR, bstrWorkspaceId, BSTR, bstrWorkspaceFriendlyName, BSTR, bstrRedirectorName, BSTR, bstrUserName, BSTR, bstrPassword, BSTR, bstrAppContainer, BSTR, bstrWorkspaceParams, Int32, lTimeout, Int32, lFlags)
    ResourceDismissed(bstrWorkspaceId, bstrWorkspaceFriendlyName)
      => ComCall(15, this.p, BSTR, bstrWorkspaceId, BSTR, bstrWorkspaceFriendlyName)
}
struct IWorkspaceScriptable3 extends IWorkspaceScriptable2 {
    static IID := "{531E6512-2CBF-4BD2-80A5-D90A71636A9A}"
    StartWorkspaceEx2(bstrWorkspaceId, bstrWorkspaceFriendlyName, bstrRedirectorName, bstrUserName, bstrPassword, bstrAppContainer, bstrWorkspaceParams, lTimeout, lFlags, bstrEventLogUploadAddress, correlationId)
      => ComCall(16, this.p, BSTR, bstrWorkspaceId, BSTR, bstrWorkspaceFriendlyName, BSTR, bstrRedirectorName, BSTR, bstrUserName, BSTR, bstrPassword, BSTR, bstrAppContainer, BSTR, bstrWorkspaceParams, Int32, lTimeout, Int32, lFlags, BSTR, bstrEventLogUploadAddress, GUID, correlationId)
}
struct IWorkspaceReportMessage extends IUnknown {
    static IID := "{A7C06739-500F-4E8C-99A8-2BD6955899EB}"
    RegisterErrorLogMessage(bstrMessage)
      => ComCall(3, this.p, BSTR, bstrMessage)
    IsErrorMessageRegistered(bstrWkspId, dwErrorType, bstrErrorMessageType, dwErrorCode, pfErrorExist)
      => ComCall(4, this.p, BSTR, bstrWkspId, UInt32, dwErrorType, BSTR, bstrErrorMessageType, UInt32, dwErrorCode, VARIANT_BOOL.Ptr, pfErrorExist)
    RegisterErrorEvent(bstrWkspId, dwErrorType, bstrErrorMessageType, dwErrorCode)
      => ComCall(5, this.p, BSTR, bstrWkspId, UInt32, dwErrorType, BSTR, bstrErrorMessageType, UInt32, dwErrorCode)
}
struct ITSWkspEvents extends IDispatch {
    static IID := "{B922BBB8-4C55-4FEA-8496-BEB0B44285E9}"
}
struct TSSD_AddrV46Type extends Int32 {
    static TSSD_ADDR_UNDEFINED := 0
    static TSSD_ADDR_IPv4 := 4
    static TSSD_ADDR_IPv6 := 6
}
struct TSSB_NOTIFICATION_TYPE extends Int32 {
    static TSSB_NOTIFY_INVALID := 0
    static TSSB_NOTIFY_TARGET_CHANGE := 1
    static TSSB_NOTIFY_SESSION_CHANGE := 2
    static TSSB_NOTIFY_CONNECTION_REQUEST_CHANGE := 4
}
struct TARGET_STATE extends Int32 {
    static TARGET_UNKNOWN := 1
    static TARGET_INITIALIZING := 2
    static TARGET_RUNNING := 3
    static TARGET_DOWN := 4
    static TARGET_HIBERNATED := 5
    static TARGET_CHECKED_OUT := 6
    static TARGET_STOPPED := 7
    static TARGET_INVALID := 8
    static TARGET_STARTING := 9
    static TARGET_STOPPING := 10
    static TARGET_MAXSTATE := 11
}
struct TARGET_CHANGE_TYPE extends Int32 {
    static TARGET_CHANGE_UNSPEC := 1
    static TARGET_EXTERNALIP_CHANGED := 2
    static TARGET_INTERNALIP_CHANGED := 4
    static TARGET_JOINED := 8
    static TARGET_REMOVED := 16
    static TARGET_STATE_CHANGED := 32
    static TARGET_IDLE := 64
    static TARGET_PENDING := 128
    static TARGET_INUSE := 256
    static TARGET_PATCH_STATE_CHANGED := 512
    static TARGET_FARM_MEMBERSHIP_CHANGED := 1024
}
struct TARGET_TYPE extends Int32 {
    static UNKNOWN := 0
    static FARM := 1
    static NONFARM := 2
}
struct TARGET_PATCH_STATE extends Int32 {
    static TARGET_PATCH_UNKNOWN := 0
    static TARGET_PATCH_NOT_STARTED := 1
    static TARGET_PATCH_IN_PROGRESS := 2
    static TARGET_PATCH_COMPLETED := 3
    static TARGET_PATCH_FAILED := 4
}
struct CLIENT_MESSAGE_TYPE extends Int32 {
    static CLIENT_MESSAGE_CONNECTION_INVALID := 0
    static CLIENT_MESSAGE_CONNECTION_STATUS := 1
    static CLIENT_MESSAGE_CONNECTION_ERROR := 2
}
struct CONNECTION_CHANGE_NOTIFICATION extends Int32 {
    static CONNECTION_REQUEST_INVALID := 0
    static CONNECTION_REQUEST_PENDING := 1
    static CONNECTION_REQUEST_FAILED := 2
    static CONNECTION_REQUEST_TIMEDOUT := 3
    static CONNECTION_REQUEST_SUCCEEDED := 4
    static CONNECTION_REQUEST_CANCELLED := 5
    static CONNECTION_REQUEST_LB_COMPLETED := 6
    static CONNECTION_REQUEST_QUERY_PL_COMPLETED := 7
    static CONNECTION_REQUEST_ORCH_COMPLETED := 8
}
struct RD_FARM_TYPE extends Int32 {
    static RD_FARM_RDSH := 0
    static RD_FARM_TEMP_VM := 1
    static RD_FARM_MANUAL_PERSONAL_VM := 2
    static RD_FARM_AUTO_PERSONAL_VM := 3
    static RD_FARM_MANUAL_PERSONAL_RDSH := 4
    static RD_FARM_AUTO_PERSONAL_RDSH := 5
    static RD_FARM_TYPE_UNKNOWN := -1
}
struct PLUGIN_TYPE extends Int32 {
    static UNKNOWN_PLUGIN := 0
    static POLICY_PLUGIN := 1
    static RESOURCE_PLUGIN := 2
    static LOAD_BALANCING_PLUGIN := 4
    static PLACEMENT_PLUGIN := 8
    static ORCHESTRATION_PLUGIN := 16
    static PROVISIONING_PLUGIN := 32
    static TASK_PLUGIN := 64
}
struct TSSESSION_STATE extends Int32 {
    static STATE_INVALID := -1
    static STATE_ACTIVE := 0
    static STATE_CONNECTED := 1
    static STATE_CONNECTQUERY := 2
    static STATE_SHADOW := 3
    static STATE_DISCONNECTED := 4
    static STATE_IDLE := 5
    static STATE_LISTEN := 6
    static STATE_RESET := 7
    static STATE_DOWN := 8
    static STATE_INIT := 9
    static STATE_MAX := 10
}
struct TARGET_OWNER extends Int32 {
    static OWNER_UNKNOWN := 0
    static OWNER_MS_TS_PLUGIN := 1
    static OWNER_MS_VM_PLUGIN := 2
}
struct CLIENT_DISPLAY {
    HorizontalResolution : UInt32
    VerticalResolution : UInt32
    ColorDepth : UInt32
}
struct TSSD_ConnectionPoint {
    ServerAddressB : UInt8[16]
    AddressType : TSSD_AddrV46Type
    PortNumber : UInt16
    AddressScope : UInt32
}
struct VM_NOTIFY_STATUS extends Int32 {
    static VM_NOTIFY_STATUS_PENDING := 0
    static VM_NOTIFY_STATUS_IN_PROGRESS := 1
    static VM_NOTIFY_STATUS_COMPLETE := 2
    static VM_NOTIFY_STATUS_FAILED := 3
    static VM_NOTIFY_STATUS_CANCELED := 4
}
struct VM_NOTIFY_ENTRY {
    VmName : UInt16[128]
    VmHost : UInt16[128]
}
struct VM_PATCH_INFO {
    dwNumEntries : UInt32
    pVmNames : PWSTR.Ptr
}
struct VM_NOTIFY_INFO {
    dwNumEntries : UInt32
    ppVmEntries : VM_NOTIFY_ENTRY.Ptr.Ptr
}
struct VM_HOST_NOTIFY_STATUS extends Int32 {
    static VM_HOST_STATUS_INIT_PENDING := 0
    static VM_HOST_STATUS_INIT_IN_PROGRESS := 1
    static VM_HOST_STATUS_INIT_COMPLETE := 2
    static VM_HOST_STATUS_INIT_FAILED := 3
}
struct RDV_TASK_STATUS extends Int32 {
    static RDV_TASK_STATUS_UNKNOWN := 0
    static RDV_TASK_STATUS_SEARCHING := 1
    static RDV_TASK_STATUS_DOWNLOADING := 2
    static RDV_TASK_STATUS_APPLYING := 3
    static RDV_TASK_STATUS_REBOOTING := 4
    static RDV_TASK_STATUS_REBOOTED := 5
    static RDV_TASK_STATUS_SUCCESS := 6
    static RDV_TASK_STATUS_FAILED := 7
    static RDV_TASK_STATUS_TIMEOUT := 8
}
struct TS_SB_SORT_BY extends Int32 {
    static TS_SB_SORT_BY_NONE := 0
    static TS_SB_SORT_BY_NAME := 1
    static TS_SB_SORT_BY_PROP := 2
}
struct ITsSbPlugin extends IUnknown {
    static IID := "{48CD7406-CAAB-465F-A5D6-BAA863B9EA4F}"
    Initialize(pProvider, pNotifySink, pPropertySet)
      => ComCall(3, this.p, ITsSbProvider, pProvider, ITsSbPluginNotifySink, pNotifySink, ITsSbPluginPropertySet, pPropertySet)
    Terminate(hr)
      => ComCall(4, this.p, HRESULT, hr)
}
struct ITsSbResourcePlugin extends ITsSbPlugin {
    static IID := "{EA8DB42C-98ED-4535-A88B-2A164F35490F}"
}
struct ITsSbServiceNotification extends IUnknown {
    static IID := "{86CB68AE-86E0-4F57-8A64-BB7406BC5550}"
    NotifyServiceFailure()
      => ComCall(3, this.p)
    NotifyServiceSuccess()
      => ComCall(4, this.p)
}
struct ITsSbLoadBalancing extends ITsSbPlugin {
    static IID := "{24329274-9EB7-11DC-AE98-F2B456D89593}"
    GetMostSuitableTarget(pConnection, pLBSink)
      => ComCall(5, this.p, ITsSbClientConnection, pConnection, ITsSbLoadBalancingNotifySink, pLBSink)
}
struct ITsSbPlacement extends ITsSbPlugin {
    static IID := "{DAADEE5F-6D32-480E-9E36-DDAB2329F06D}"
    QueryEnvironmentForTarget(pConnection, pPlacementSink)
      => ComCall(5, this.p, ITsSbClientConnection, pConnection, ITsSbPlacementNotifySink, pPlacementSink)
}
struct ITsSbOrchestration extends ITsSbPlugin {
    static IID := "{64FC1172-9EB7-11DC-8B00-3ABA56D89593}"
    PrepareTargetForConnect(pConnection, pOrchestrationNotifySink)
      => ComCall(5, this.p, ITsSbClientConnection, pConnection, ITsSbOrchestrationNotifySink, pOrchestrationNotifySink)
}
struct ITsSbEnvironment extends IUnknown {
    static IID := "{8C87F7F7-BF51-4A5C-87BF-8E94FB6E2256}"
    get_Name(pVal)
      => ComCall(3, this.p, BSTR.Ptr, pVal)
    get_ServerWeight(pVal)
      => ComCall(4, this.p, UInt32.Ptr, pVal)
    get_EnvironmentPropertySet(ppPropertySet)
      => ComCall(5, this.p, ITsSbEnvironmentPropertySet.Ptr, ppPropertySet)
    put_EnvironmentPropertySet(pVal)
      => ComCall(6, this.p, ITsSbEnvironmentPropertySet, pVal)
}
struct ITsSbLoadBalanceResult extends IUnknown {
    static IID := "{24FDB7AC-FEA6-11DC-9672-9A8956D89593}"
    get_TargetName(pVal)
      => ComCall(3, this.p, BSTR.Ptr, pVal)
}
struct ITsSbTarget extends IUnknown {
    static IID := "{16616ECC-272D-411D-B324-126893033856}"
    get_TargetName(pVal)
      => ComCall(3, this.p, BSTR.Ptr, pVal)
    put_TargetName(Val)
      => ComCall(4, this.p, BSTR, Val)
    get_FarmName(pVal)
      => ComCall(5, this.p, BSTR.Ptr, pVal)
    put_FarmName(Val)
      => ComCall(6, this.p, BSTR, Val)
    get_TargetFQDN(TargetFqdnName)
      => ComCall(7, this.p, BSTR.Ptr, TargetFqdnName)
    put_TargetFQDN(Val)
      => ComCall(8, this.p, BSTR, Val)
    get_TargetNetbios(TargetNetbiosName)
      => ComCall(9, this.p, BSTR.Ptr, TargetNetbiosName)
    put_TargetNetbios(Val)
      => ComCall(10, this.p, BSTR, Val)
    get_IpAddresses(SOCKADDR)
      => ComCall(11, this.p, TSSD_ConnectionPoint.Ptr, SOCKADDR, UInt32.Ptr, SOCKADDR.Length)
    put_IpAddresses(SOCKADDR)
      => ComCall(12, this.p, TSSD_ConnectionPoint.Ptr, SOCKADDR, UInt32, SOCKADDR.Length)
    get_TargetState(pState)
      => ComCall(13, this.p, TARGET_STATE.Ptr, pState)
    put_TargetState(State)
      => ComCall(14, this.p, TARGET_STATE, State)
    get_TargetPropertySet(ppPropertySet)
      => ComCall(15, this.p, ITsSbTargetPropertySet.Ptr, ppPropertySet)
    put_TargetPropertySet(pVal)
      => ComCall(16, this.p, ITsSbTargetPropertySet, pVal)
    get_EnvironmentName(pVal)
      => ComCall(17, this.p, BSTR.Ptr, pVal)
    put_EnvironmentName(Val)
      => ComCall(18, this.p, BSTR, Val)
    get_NumSessions(pNumSessions)
      => ComCall(19, this.p, UInt32.Ptr, pNumSessions)
    get_NumPendingConnections(pNumPendingConnections)
      => ComCall(20, this.p, UInt32.Ptr, pNumPendingConnections)
    get_TargetLoad(pTargetLoad)
      => ComCall(21, this.p, UInt32.Ptr, pTargetLoad)
}
struct ITsSbSession extends IUnknown {
    static IID := "{D453AAC7-B1D8-4C5E-BA34-9AFB4C8C5510}"
    get_SessionId(pVal)
      => ComCall(3, this.p, UInt32.Ptr, pVal)
    get_TargetName(targetName)
      => ComCall(4, this.p, BSTR.Ptr, targetName)
    put_TargetName(targetName)
      => ComCall(5, this.p, BSTR, targetName)
    get_Username(userName)
      => ComCall(6, this.p, BSTR.Ptr, userName)
    get_Domain(domain)
      => ComCall(7, this.p, BSTR.Ptr, domain)
    get_State(pState)
      => ComCall(8, this.p, TSSESSION_STATE.Ptr, pState)
    put_State(State)
      => ComCall(9, this.p, TSSESSION_STATE, State)
    get_CreateTime(pTime)
      => ComCall(10, this.p, FILETIME.Ptr, pTime)
    put_CreateTime(Time)
      => ComCall(11, this.p, FILETIME, Time)
    get_DisconnectTime(pTime)
      => ComCall(12, this.p, FILETIME.Ptr, pTime)
    put_DisconnectTime(Time)
      => ComCall(13, this.p, FILETIME, Time)
    get_InitialProgram(app)
      => ComCall(14, this.p, BSTR.Ptr, app)
    put_InitialProgram(Application)
      => ComCall(15, this.p, BSTR, Application)
    get_ClientDisplay(pClientDisplay)
      => ComCall(16, this.p, CLIENT_DISPLAY.Ptr, pClientDisplay)
    put_ClientDisplay(pClientDisplay)
      => ComCall(17, this.p, CLIENT_DISPLAY, pClientDisplay)
    get_ProtocolType(pVal)
      => ComCall(18, this.p, UInt32.Ptr, pVal)
    put_ProtocolType(Val)
      => ComCall(19, this.p, UInt32, Val)
}
struct ITsSbResourceNotification extends IUnknown {
    static IID := "{65D3E85A-C39B-11DC-B92D-3CD255D89593}"
    NotifySessionChange(changeType, pSession)
      => ComCall(3, this.p, TSSESSION_STATE, changeType, ITsSbSession, pSession)
    NotifyTargetChange(TargetChangeType, pTarget)
      => ComCall(4, this.p, UInt32, TargetChangeType, ITsSbTarget, pTarget)
    NotifyClientConnectionStateChange(ChangeType, pConnection)
      => ComCall(5, this.p, CONNECTION_CHANGE_NOTIFICATION, ChangeType, ITsSbClientConnection, pConnection)
}
struct ITsSbResourceNotificationEx extends IUnknown {
    static IID := "{A8A47FDE-CA91-44D2-B897-3AA28A43B2B7}"
    NotifySessionChangeEx(targetName, userName, domain, sessionId, sessionState)
      => ComCall(3, this.p, BSTR, targetName, BSTR, userName, BSTR, domain, UInt32, sessionId, TSSESSION_STATE, sessionState)
    NotifyTargetChangeEx(targetName, targetChangeType)
      => ComCall(4, this.p, BSTR, targetName, UInt32, targetChangeType)
    NotifyClientConnectionStateChangeEx(userName, domain, initialProgram, poolName, targetName, connectionChangeType)
      => ComCall(5, this.p, BSTR, userName, BSTR, domain, BSTR, initialProgram, BSTR, poolName, BSTR, targetName, CONNECTION_CHANGE_NOTIFICATION, connectionChangeType)
}
struct ITsSbTaskInfo extends IUnknown {
    static IID := "{523D1083-89BE-48DD-99EA-04E82FFA7265}"
    get_TargetId(pName)
      => ComCall(3, this.p, BSTR.Ptr, pName)
    get_StartTime(pStartTime)
      => ComCall(4, this.p, FILETIME.Ptr, pStartTime)
    get_EndTime(pEndTime)
      => ComCall(5, this.p, FILETIME.Ptr, pEndTime)
    get_Deadline(pDeadline)
      => ComCall(6, this.p, FILETIME.Ptr, pDeadline)
    get_Identifier(pIdentifier)
      => ComCall(7, this.p, BSTR.Ptr, pIdentifier)
    get_Label(pLabel)
      => ComCall(8, this.p, BSTR.Ptr, pLabel)
    get_Context(pContext)
      => ComCall(9, this.p, SAFEARRAY.Ptr.Ptr, pContext)
    get_Plugin(pPlugin)
      => ComCall(10, this.p, BSTR.Ptr, pPlugin)
    get_Status(pStatus)
      => ComCall(11, this.p, RDV_TASK_STATUS.Ptr, pStatus)
}
struct ITsSbTaskPlugin extends ITsSbPlugin {
    static IID := "{FA22EF0F-8705-41BE-93BC-44BDBCF1C9C4}"
    InitializeTaskPlugin(pITsSbTaskPluginNotifySink)
      => ComCall(5, this.p, ITsSbTaskPluginNotifySink, pITsSbTaskPluginNotifySink)
    SetTaskQueue(pszHostName, pITsSbTaskInfo)
      => ComCall(6, this.p, BSTR, pszHostName, UInt32, pITsSbTaskInfo.Length, ITsSbTaskInfo.Ptr, pITsSbTaskInfo)
}
struct ITsSbPropertySet extends IPropertyBag {
    static IID := "{5C025171-BB1E-4BAF-A212-6D5E9774B33B}"
}
struct ITsSbPluginPropertySet extends ITsSbPropertySet {
    static IID := "{95006E34-7EFF-4B6C-BB40-49A4FDA7CEA6}"
}
struct ITsSbClientConnectionPropertySet extends ITsSbPropertySet {
    static IID := "{E51995B0-46D6-11DD-AA21-CEDC55D89593}"
}
struct ITsSbTargetPropertySet extends ITsSbPropertySet {
    static IID := "{F7BDA5D6-994C-4E11-A079-2763B61830AC}"
}
struct ITsSbEnvironmentPropertySet extends ITsSbPropertySet {
    static IID := "{D0D1BF7E-7ACF-11DD-A243-E51156D89593}"
}
struct ITsSbBaseNotifySink extends IUnknown {
    static IID := "{808A6537-1282-4989-9E09-F43938B71722}"
    OnError(hrError)
      => ComCall(3, this.p, HRESULT, hrError)
    OnReportStatus(messageType, messageID)
      => ComCall(4, this.p, CLIENT_MESSAGE_TYPE, messageType, UInt32, messageID)
}
struct ITsSbPluginNotifySink extends ITsSbBaseNotifySink {
    static IID := "{44DFE30B-C3BE-40F5-BF82-7A95BB795ADF}"
    OnInitialized(hr)
      => ComCall(5, this.p, HRESULT, hr)
    OnTerminated()
      => ComCall(6, this.p)
}
struct ITsSbLoadBalancingNotifySink extends ITsSbBaseNotifySink {
    static IID := "{5F8A8297-3244-4E6A-958A-27C822C1E141}"
    OnGetMostSuitableTarget(pLBResult, fIsNewConnection)
      => ComCall(5, this.p, ITsSbLoadBalanceResult, pLBResult, BOOL, fIsNewConnection)
}
struct ITsSbPlacementNotifySink extends ITsSbBaseNotifySink {
    static IID := "{68A0C487-2B4F-46C2-94A1-6CE685183634}"
    OnQueryEnvironmentCompleted(pEnvironment)
      => ComCall(5, this.p, ITsSbEnvironment, pEnvironment)
}
struct ITsSbOrchestrationNotifySink extends ITsSbBaseNotifySink {
    static IID := "{36C37D61-926B-442F-BCA5-118C6D50DCF2}"
    OnReadyToConnect(pTarget)
      => ComCall(5, this.p, ITsSbTarget, pTarget)
}
struct ITsSbTaskPluginNotifySink extends ITsSbBaseNotifySink {
    static IID := "{6AAF899E-C2EC-45EE-AA37-45E60895261A}"
    OnSetTaskTime(szTargetName, TaskStartTime, TaskEndTime, TaskDeadline, szTaskLabel, szTaskIdentifier, szTaskPlugin, dwTaskStatus, saContext)
      => ComCall(5, this.p, BSTR, szTargetName, FILETIME, TaskStartTime, FILETIME, TaskEndTime, FILETIME, TaskDeadline, BSTR, szTaskLabel, BSTR, szTaskIdentifier, BSTR, szTaskPlugin, UInt32, dwTaskStatus, SAFEARRAY.Ptr, saContext)
    OnDeleteTaskTime(szTargetName, szTaskIdentifier)
      => ComCall(6, this.p, BSTR, szTargetName, BSTR, szTaskIdentifier)
    OnUpdateTaskStatus(szTargetName, TaskIdentifier, TaskStatus)
      => ComCall(7, this.p, BSTR, szTargetName, BSTR, TaskIdentifier, RDV_TASK_STATUS, TaskStatus)
    OnReportTasks(szHostName)
      => ComCall(8, this.p, BSTR, szHostName)
}
struct ITsSbClientConnection extends IUnknown {
    static IID := "{18857499-AD61-4B1B-B7DF-CBCD41FB8338}"
    get_UserName(pVal)
      => ComCall(3, this.p, BSTR.Ptr, pVal)
    get_Domain(pVal)
      => ComCall(4, this.p, BSTR.Ptr, pVal)
    get_InitialProgram(pVal)
      => ComCall(5, this.p, BSTR.Ptr, pVal)
    get_LoadBalanceResult(ppVal)
      => ComCall(6, this.p, ITsSbLoadBalanceResult.Ptr, ppVal)
    get_FarmName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    PutContext(contextId, context, existingContext?)
      => ComCall(8, this.p, BSTR, contextId, VARIANT, context, VARIANT.Ptr, existingContext?)
    GetContext(contextId, context)
      => ComCall(9, this.p, BSTR, contextId, VARIANT.Ptr, context)
    get_Environment(ppEnvironment)
      => ComCall(10, this.p, ITsSbEnvironment.Ptr, ppEnvironment)
    get_ConnectionError()
      => ComCall(11, this.p)
    get_SamUserAccount(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
    get_ClientConnectionPropertySet(ppPropertySet)
      => ComCall(13, this.p, ITsSbClientConnectionPropertySet.Ptr, ppPropertySet)
    get_IsFirstAssignment(ppVal)
      => ComCall(14, this.p, BOOL.Ptr, ppVal)
    get_RdFarmType(pRdFarmType)
      => ComCall(15, this.p, RD_FARM_TYPE.Ptr, pRdFarmType)
    get_UserSidString(pszUserSidString)
      => ComCall(16, this.p, Int8.Ptr.Ptr, pszUserSidString)
    GetDisconnectedSession(ppSession)
      => ComCall(17, this.p, ITsSbSession.Ptr, ppSession)
}
struct ITsSbProvider extends IUnknown {
    static IID := "{87A4098F-6D7B-44DD-BC17-8CE44E370D52}"
    CreateTargetObject(TargetName, EnvironmentName, ppTarget)
      => ComCall(3, this.p, BSTR, TargetName, BSTR, EnvironmentName, ITsSbTarget.Ptr, ppTarget)
    CreateLoadBalanceResultObject(TargetName, ppLBResult)
      => ComCall(4, this.p, BSTR, TargetName, ITsSbLoadBalanceResult.Ptr, ppLBResult)
    CreateSessionObject(TargetName, UserName, Domain, SessionId, ppSession)
      => ComCall(5, this.p, BSTR, TargetName, BSTR, UserName, BSTR, Domain, UInt32, SessionId, ITsSbSession.Ptr, ppSession)
    CreatePluginPropertySet(ppPropertySet)
      => ComCall(6, this.p, ITsSbPluginPropertySet.Ptr, ppPropertySet)
    CreateTargetPropertySetObject(ppPropertySet)
      => ComCall(7, this.p, ITsSbTargetPropertySet.Ptr, ppPropertySet)
    CreateEnvironmentObject(Name, ServerWeight, ppEnvironment)
      => ComCall(8, this.p, BSTR, Name, UInt32, ServerWeight, ITsSbEnvironment.Ptr, ppEnvironment)
    GetResourcePluginStore(ppStore)
      => ComCall(9, this.p, ITsSbResourcePluginStore.Ptr, ppStore)
    GetFilterPluginStore(ppStore)
      => ComCall(10, this.p, ITsSbFilterPluginStore.Ptr, ppStore)
    RegisterForNotification(notificationType, ResourceToMonitor, pPluginNotification)
      => ComCall(11, this.p, UInt32, notificationType, BSTR, ResourceToMonitor, ITsSbResourceNotification, pPluginNotification)
    UnRegisterForNotification(notificationType, ResourceToMonitor)
      => ComCall(12, this.p, UInt32, notificationType, BSTR, ResourceToMonitor)
    GetInstanceOfGlobalStore(ppGlobalStore)
      => ComCall(13, this.p, ITsSbGlobalStore.Ptr, ppGlobalStore)
    CreateEnvironmentPropertySetObject(ppPropertySet)
      => ComCall(14, this.p, ITsSbEnvironmentPropertySet.Ptr, ppPropertySet)
}
struct ITsSbResourcePluginStore extends IUnknown {
    static IID := "{5C38F65F-BCF1-4036-A6BF-9E3CCCAE0B63}"
    QueryTarget(TargetName, FarmName, ppTarget)
      => ComCall(3, this.p, BSTR, TargetName, BSTR, FarmName, ITsSbTarget.Ptr, ppTarget)
    QuerySessionBySessionId(dwSessionId, TargetName, ppSession)
      => ComCall(4, this.p, UInt32, dwSessionId, BSTR, TargetName, ITsSbSession.Ptr, ppSession)
    AddTargetToStore(pTarget)
      => ComCall(5, this.p, ITsSbTarget, pTarget)
    AddSessionToStore(pSession)
      => ComCall(6, this.p, ITsSbSession, pSession)
    AddEnvironmentToStore(pEnvironment)
      => ComCall(7, this.p, ITsSbEnvironment, pEnvironment)
    RemoveEnvironmentFromStore(EnvironmentName, bIgnoreOwner)
      => ComCall(8, this.p, BSTR, EnvironmentName, BOOL, bIgnoreOwner)
    EnumerateFarms(pdwCount, pVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwCount, SAFEARRAY.Ptr.Ptr, pVal)
    QueryEnvironment(EnvironmentName, ppEnvironment)
      => ComCall(10, this.p, BSTR, EnvironmentName, ITsSbEnvironment.Ptr, ppEnvironment)
    EnumerateEnvironments(pVal)
      => ComCall(11, this.p, UInt32.Ptr, pVal.Length, ITsSbEnvironment.Ptr.Ptr, pVal)
    SaveTarget(pTarget, bForceWrite)
      => ComCall(12, this.p, ITsSbTarget, pTarget, BOOL, bForceWrite)
    SaveEnvironment(pEnvironment, bForceWrite)
      => ComCall(13, this.p, ITsSbEnvironment, pEnvironment, BOOL, bForceWrite)
    SaveSession(pSession)
      => ComCall(14, this.p, ITsSbSession, pSession)
    SetTargetProperty(TargetName, PropertyName, pProperty)
      => ComCall(15, this.p, BSTR, TargetName, BSTR, PropertyName, VARIANT.Ptr, pProperty)
    SetEnvironmentProperty(EnvironmentName, PropertyName, pProperty)
      => ComCall(16, this.p, BSTR, EnvironmentName, BSTR, PropertyName, VARIANT.Ptr, pProperty)
    SetTargetState(targetName, newState, pOldState)
      => ComCall(17, this.p, BSTR, targetName, TARGET_STATE, newState, TARGET_STATE.Ptr, pOldState)
    SetSessionState(sbSession)
      => ComCall(18, this.p, ITsSbSession, sbSession)
    EnumerateTargets(FarmName, EnvName, sortByFieldId, sortyByPropName, pdwCount, pVal)
      => ComCall(19, this.p, BSTR, FarmName, BSTR, EnvName, TS_SB_SORT_BY, sortByFieldId, BSTR, sortyByPropName, UInt32.Ptr, pdwCount, ITsSbTarget.Ptr.Ptr, pVal)
    EnumerateSessions(targetName, userName, userDomain, poolName, initialProgram, pSessionState, pdwCount, ppVal)
      => ComCall(20, this.p, BSTR, targetName, BSTR, userName, BSTR, userDomain, BSTR, poolName, BSTR, initialProgram, TSSESSION_STATE.Ptr, pSessionState, UInt32.Ptr, pdwCount, ITsSbSession.Ptr.Ptr, ppVal)
    GetFarmProperty(farmName, propertyName, pVarValue)
      => ComCall(21, this.p, BSTR, farmName, BSTR, propertyName, VARIANT.Ptr, pVarValue)
    DeleteTarget(targetName, hostName)
      => ComCall(22, this.p, BSTR, targetName, BSTR, hostName)
    SetTargetPropertyWithVersionCheck(pTarget, PropertyName, pProperty)
      => ComCall(23, this.p, ITsSbTarget, pTarget, BSTR, PropertyName, VARIANT.Ptr, pProperty)
    SetEnvironmentPropertyWithVersionCheck(pEnvironment, PropertyName, pProperty)
      => ComCall(24, this.p, ITsSbEnvironment, pEnvironment, BSTR, PropertyName, VARIANT.Ptr, pProperty)
    AcquireTargetLock(targetName, dwTimeout, ppContext)
      => ComCall(25, this.p, BSTR, targetName, UInt32, dwTimeout, IUnknown.Ptr, ppContext)
    ReleaseTargetLock(pContext)
      => ComCall(26, this.p, IUnknown, pContext)
    TestAndSetServerState(PoolName, ServerFQDN, NewState, TestState, pInitState)
      => ComCall(27, this.p, BSTR, PoolName, BSTR, ServerFQDN, TARGET_STATE, NewState, TARGET_STATE, TestState, TARGET_STATE.Ptr, pInitState)
    SetServerWaitingToStart(PoolName, serverName)
      => ComCall(28, this.p, BSTR, PoolName, BSTR, serverName)
    GetServerState(PoolName, ServerFQDN, pState)
      => ComCall(29, this.p, BSTR, PoolName, BSTR, ServerFQDN, TARGET_STATE.Ptr, pState)
    SetServerDrainMode(ServerFQDN, DrainMode)
      => ComCall(30, this.p, BSTR, ServerFQDN, UInt32, DrainMode)
}
struct ITsSbFilterPluginStore extends IUnknown {
    static IID := "{85B44B0F-ED78-413F-9702-FA6D3B5EE755}"
    SaveProperties(pPropertySet)
      => ComCall(3, this.p, ITsSbPropertySet, pPropertySet)
    EnumerateProperties(ppPropertySet)
      => ComCall(4, this.p, ITsSbPropertySet.Ptr, ppPropertySet)
    DeleteProperties(propertyName)
      => ComCall(5, this.p, BSTR, propertyName)
}
struct ITsSbGlobalStore extends IUnknown {
    static IID := "{9AB60F7B-BD72-4D9F-8A3A-A0EA5574E635}"
    QueryTarget(ProviderName, TargetName, FarmName, ppTarget)
      => ComCall(3, this.p, BSTR, ProviderName, BSTR, TargetName, BSTR, FarmName, ITsSbTarget.Ptr, ppTarget)
    QuerySessionBySessionId(ProviderName, dwSessionId, TargetName, ppSession)
      => ComCall(4, this.p, BSTR, ProviderName, UInt32, dwSessionId, BSTR, TargetName, ITsSbSession.Ptr, ppSession)
    EnumerateFarms(ProviderName, pdwCount, pVal)
      => ComCall(5, this.p, BSTR, ProviderName, UInt32.Ptr, pdwCount, SAFEARRAY.Ptr.Ptr, pVal)
    EnumerateTargets(ProviderName, FarmName, EnvName, pVal)
      => ComCall(6, this.p, BSTR, ProviderName, BSTR, FarmName, BSTR, EnvName, UInt32.Ptr, pVal.Length, ITsSbTarget.Ptr.Ptr, pVal)
    EnumerateEnvironmentsByProvider(ProviderName, ppVal)
      => ComCall(7, this.p, BSTR, ProviderName, UInt32.Ptr, ppVal.Length, ITsSbEnvironment.Ptr.Ptr, ppVal)
    EnumerateSessions(ProviderName, targetName, userName, userDomain, poolName, initialProgram, pSessionState, ppVal)
      => ComCall(8, this.p, BSTR, ProviderName, BSTR, targetName, BSTR, userName, BSTR, userDomain, BSTR, poolName, BSTR, initialProgram, TSSESSION_STATE.Ptr, pSessionState, UInt32.Ptr, ppVal.Length, ITsSbSession.Ptr.Ptr, ppVal)
    GetFarmProperty(farmName, propertyName, pVarValue)
      => ComCall(9, this.p, BSTR, farmName, BSTR, propertyName, VARIANT.Ptr, pVarValue)
}
struct ITsSbProvisioningPluginNotifySink extends IUnknown {
    static IID := "{ACA87A8E-818B-4581-A032-49C3DFB9C701}"
    OnJobCreated(pVmNotifyInfo)
      => ComCall(3, this.p, VM_NOTIFY_INFO.Ptr, pVmNotifyInfo)
    OnVirtualMachineStatusChanged(pVmNotifyEntry, VmNotifyStatus, ErrorCode, ErrorDescr)
      => ComCall(4, this.p, VM_NOTIFY_ENTRY.Ptr, pVmNotifyEntry, VM_NOTIFY_STATUS, VmNotifyStatus, HRESULT, ErrorCode, BSTR, ErrorDescr)
    OnJobCompleted(ResultCode, ResultDescription)
      => ComCall(5, this.p, HRESULT, ResultCode, BSTR, ResultDescription)
    OnJobCancelled()
      => ComCall(6, this.p)
    LockVirtualMachine(pVmNotifyEntry)
      => ComCall(7, this.p, VM_NOTIFY_ENTRY.Ptr, pVmNotifyEntry)
    OnVirtualMachineHostStatusChanged(VmHost, VmHostNotifyStatus, ErrorCode, ErrorDescr)
      => ComCall(8, this.p, BSTR, VmHost, VM_HOST_NOTIFY_STATUS, VmHostNotifyStatus, HRESULT, ErrorCode, BSTR, ErrorDescr)
}
struct ITsSbProvisioning extends ITsSbPlugin {
    static IID := "{2F6F0DBB-9E4F-462B-9C3F-FCCC3DCB6232}"
    CreateVirtualMachines(JobXmlString, JobGuid, pSink)
      => ComCall(5, this.p, BSTR, JobXmlString, BSTR, JobGuid, ITsSbProvisioningPluginNotifySink, pSink)
    PatchVirtualMachines(JobXmlString, JobGuid, pSink, pVMPatchInfo)
      => ComCall(6, this.p, BSTR, JobXmlString, BSTR, JobGuid, ITsSbProvisioningPluginNotifySink, pSink, VM_PATCH_INFO.Ptr, pVMPatchInfo)
    DeleteVirtualMachines(JobXmlString, JobGuid, pSink)
      => ComCall(7, this.p, BSTR, JobXmlString, BSTR, JobGuid, ITsSbProvisioningPluginNotifySink, pSink)
    CancelJob(JobGuid)
      => ComCall(8, this.p, BSTR, JobGuid)
}
struct ITsSbGenericNotifySink extends IUnknown {
    static IID := "{4C4C8C4F-300B-46AD-9164-8468A7E7568C}"
    OnCompleted(Status)
      => ComCall(3, this.p, HRESULT, Status)
    GetWaitTimeout(pftTimeout)
      => ComCall(4, this.p, FILETIME.Ptr, pftTimeout)
}
struct pluginResource {
    alias : UInt16[256]
    name : UInt16[256]
    resourceFileContents : PWSTR
    fileExtension : UInt16[256]
    resourcePluginType : UInt16[256]
    isDiscoverable : UInt8
    resourceType : Int32
    pceIconSize : UInt32
    iconContents : UInt8.Ptr
    pcePluginBlobSize : UInt32
    blobContents : UInt8.Ptr
}
struct ItsPubPlugin extends IUnknown {
    static IID := "{70C04B05-F347-412B-822F-36C99C54CA45}"
    GetResourceList(userID, pceAppListSize, resourceList)
      => ComCall(3, this.p, "Str", userID, Int32.Ptr, pceAppListSize, pluginResource.Ptr.Ptr, resourceList)
    GetResource(alias, flags, resource)
      => ComCall(4, this.p, "Str", alias, Int32, flags, pluginResource.Ptr, resource)
    GetCacheLastUpdateTime(lastUpdateTime)
      => ComCall(5, this.p, Int64.Ptr, lastUpdateTime)
    get_pluginName(pVal)
      => ComCall(6, this.p, BSTR.Ptr, pVal)
    get_pluginVersion(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    ResolveResource(resourceType, resourceLocation, endPointName, userID, alias)
      => ComCall(8, this.p, UInt32.Ptr, resourceType, PWSTR, resourceLocation, PWSTR, endPointName, "Str", userID, "Str", alias)
}
struct pluginResource2FileAssociation {
    extName : UInt16[256]
    primaryHandler : UInt8
    pceIconSize : UInt32
    iconContents : UInt8.Ptr
}
struct pluginResource2 {
    resourceV1 : pluginResource
    pceFileAssocListSize : UInt32
    fileAssocList : pluginResource2FileAssociation.Ptr
    securityDescriptor : PWSTR
    pceFolderListSize : UInt32
    folderList : UInt16.Ptr.Ptr
}
struct TSPUB_PLUGIN_PD_RESOLUTION_TYPE extends Int32 {
    static TSPUB_PLUGIN_PD_QUERY_OR_CREATE := 0
    static TSPUB_PLUGIN_PD_QUERY_EXISTING := 1
}
struct TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE extends Int32 {
    static TSPUB_PLUGIN_PD_ASSIGNMENT_NEW := 0
    static TSPUB_PLUGIN_PD_ASSIGNMENT_EXISTING := 1
}
struct ItsPubPlugin2 extends ItsPubPlugin {
    static IID := "{FA4CE418-AAD7-4EC6-BAD1-0A321BA465D5}"
    GetResource2List(userID, pceAppListSize, resourceList)
      => ComCall(9, this.p, "Str", userID, Int32.Ptr, pceAppListSize, pluginResource2.Ptr.Ptr, resourceList)
    GetResource2(alias, flags, resource)
      => ComCall(10, this.p, "Str", alias, Int32, flags, pluginResource2.Ptr, resource)
    ResolvePersonalDesktop(userId, poolId, ePdResolutionType, pPdAssignmentType, endPointName)
      => ComCall(11, this.p, "Str", userId, "Str", poolId, TSPUB_PLUGIN_PD_RESOLUTION_TYPE, ePdResolutionType, TSPUB_PLUGIN_PD_ASSIGNMENT_TYPE.Ptr, pPdAssignmentType, PWSTR, endPointName)
    DeletePersonalDesktopAssignment(userId, poolId, endpointName)
      => ComCall(12, this.p, "Str", userId, "Str", poolId, "Str", endpointName)
}
struct IWorkspaceResTypeRegistry extends IDispatch {
    static IID := "{1D428C79-6E2E-4351-A361-C0401A03A0BA}"
    AddResourceType(fMachineWide, bstrFileExtension, bstrLauncher)
      => ComCall(7, this.p, VARIANT_BOOL, fMachineWide, BSTR, bstrFileExtension, BSTR, bstrLauncher)
    DeleteResourceType(fMachineWide, bstrFileExtension)
      => ComCall(8, this.p, VARIANT_BOOL, fMachineWide, BSTR, bstrFileExtension)
    GetRegisteredFileExtensions(fMachineWide, psaFileExtensions)
      => ComCall(9, this.p, VARIANT_BOOL, fMachineWide, SAFEARRAY.Ptr.Ptr, psaFileExtensions)
    GetResourceTypeInfo(fMachineWide, bstrFileExtension, pbstrLauncher)
      => ComCall(10, this.p, VARIANT_BOOL, fMachineWide, BSTR, bstrFileExtension, BSTR.Ptr, pbstrLauncher)
    ModifyResourceType(fMachineWide, bstrFileExtension, bstrLauncher)
      => ComCall(11, this.p, VARIANT_BOOL, fMachineWide, BSTR, bstrFileExtension, BSTR, bstrLauncher)
}
struct IWTSPlugin extends IUnknown {
    static IID := "{A1230201-1439-4E62-A414-190D0AC3D40E}"
    Initialize(pChannelMgr)
      => ComCall(3, this.p, IWTSVirtualChannelManager, pChannelMgr)
    Connected()
      => ComCall(4, this.p)
    Disconnected(dwDisconnectCode)
      => ComCall(5, this.p, UInt32, dwDisconnectCode)
    Terminated()
      => ComCall(6, this.p)
}
struct IWTSListener extends IUnknown {
    static IID := "{A1230206-9A39-4D58-8674-CDB4DFF4E73B}"
    GetConfiguration(ppPropertyBag)
      => ComCall(3, this.p, IPropertyBag.Ptr, ppPropertyBag)
}
struct IWTSListenerCallback extends IUnknown {
    static IID := "{A1230203-D6A7-11D8-B9FD-000BDBD1F198}"
    OnNewChannelConnection(pChannel, data?, pbAccept, ppCallback)
      => ComCall(3, this.p, IWTSVirtualChannel, pChannel, BSTR, data?, BOOL.Ptr, pbAccept, IWTSVirtualChannelCallback.Ptr, ppCallback)
}
struct IWTSVirtualChannelCallback extends IUnknown {
    static IID := "{A1230204-D6A7-11D8-B9FD-000BDBD1F198}"
    OnDataReceived(pBuffer)
      => ComCall(3, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer)
    OnClose()
      => ComCall(4, this.p)
}
struct IWTSVirtualChannelManager extends IUnknown {
    static IID := "{A1230205-D6A7-11D8-B9FD-000BDBD1F198}"
    CreateListener(pszChannelName, uFlags, pListenerCallback, ppListener)
      => ComCall(3, this.p, PSTR, pszChannelName, UInt32, uFlags, IWTSListenerCallback, pListenerCallback, IWTSListener.Ptr, ppListener)
}
struct IWTSVirtualChannel extends IUnknown {
    static IID := "{A1230207-D6A7-11D8-B9FD-000BDBD1F198}"
    Write(pBuffer, pReserved)
      => ComCall(3, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer, IUnknown, pReserved)
    Close()
      => ComCall(4, this.p)
}
struct IWTSPluginServiceProvider extends IUnknown {
    static IID := "{D3E07363-087C-476C-86A7-DBB15F46DDB4}"
    GetService(ServiceId, ppunkObject)
      => ComCall(3, this.p, GUID, ServiceId, IUnknown.Ptr, ppunkObject)
}
struct BITMAP_RENDERER_STATISTICS {
    dwFramesDelivered : UInt32
    dwFramesDropped : UInt32
}
struct IWTSBitmapRenderer extends IUnknown {
    static IID := "{5B7ACC97-F3C9-46F7-8C5B-FA685D3441B1}"
    Render(imageFormat, dwWidth, dwHeight, cbStride, pImageBuffer)
      => ComCall(3, this.p, GUID, imageFormat, UInt32, dwWidth, UInt32, dwHeight, Int32, cbStride, UInt32, pImageBuffer.Length, UInt8.Ptr, pImageBuffer)
    GetRendererStatistics(pStatistics)
      => ComCall(4, this.p, BITMAP_RENDERER_STATISTICS.Ptr, pStatistics)
    RemoveMapping()
      => ComCall(5, this.p)
}
struct IWTSBitmapRendererCallback extends IUnknown {
    static IID := "{D782928E-FE4E-4E77-AE90-9CD0B3E3B353}"
    OnTargetSizeChanged(rcNewSize)
      => ComCall(3, this.p, RECT, rcNewSize)
}
struct IWTSBitmapRenderService extends IUnknown {
    static IID := "{EA326091-05FE-40C1-B49C-3D2EF4626A0E}"
    GetMappedRenderer(mappingId, pMappedRendererCallback, ppMappedRenderer)
      => ComCall(3, this.p, Int64, mappingId, IWTSBitmapRendererCallback, pMappedRendererCallback, IWTSBitmapRenderer.Ptr, ppMappedRenderer)
}
struct RdpSessionType extends Int32 {
    static Desktop := 0
    static RemoteApp := 1
}
struct WTSWindowInfo {
    Hwnd : HWND
    Height : Int32
    Width : Int32
    ViewWidth : Int32
    ViewHeight : Int32
    ViewOffsetX : Int32
    ViewOffsetY : Int32
    Scale : Float32
}
struct IWTSWindowChangedCallback extends IUnknown {
    static IID := "{E8A47FD3-1AF6-4D7F-8E15-515CCAE1C00C}"
    WindowChanged(windowInfo)
      => ComCall(3, this.p, WTSWindowInfo.Ptr, windowInfo)
}
struct IWTSWindowInfoService extends IUnknown {
    static IID := "{2A002C7B-0120-4D04-BFB1-3C73110C8581}"
    GetWindowInfo(remoteHwnd, windowInfo)
      => ComCall(3, this.p, HWND, remoteHwnd, WTSWindowInfo.Ptr, windowInfo)
    GetRdpClientProcessId(processId)
      => ComCall(4, this.p, UInt32.Ptr, processId)
    GetRdpSessionType(sessionType)
      => ComCall(5, this.p, RdpSessionType.Ptr, sessionType)
    SubscribeWindowChanged(remoteHwnd, windowChanged)
      => ComCall(6, this.p, HWND, remoteHwnd, IWTSWindowChangedCallback, windowChanged)
    UnsubscribeWindowChanged(remoteHwnd, windowChanged)
      => ComCall(7, this.p, HWND, remoteHwnd, IWTSWindowChangedCallback, windowChanged)
}
struct IWRdsGraphicsChannelEvents extends IUnknown {
    static IID := "{67F2368C-D674-4FAE-66A5-D20628A640D2}"
    OnDataReceived(cbSize, pBuffer)
      => ComCall(3, this.p, UInt32, cbSize, UInt8.Ptr, pBuffer)
    OnClose()
      => ComCall(4, this.p)
    OnChannelOpened(OpenResult, pOpenContext)
      => ComCall(5, this.p, HRESULT, OpenResult, IUnknown, pOpenContext)
    OnDataSent(pWriteContext, bCancelled, pBuffer, cbBuffer)
      => ComCall(6, this.p, IUnknown, pWriteContext, BOOL, bCancelled, UInt8.Ptr, pBuffer, UInt32, cbBuffer)
    OnMetricsUpdate(bandwidth, RTT, lastSentByteIndex)
      => ComCall(7, this.p, UInt32, bandwidth, UInt32, RTT, Int64, lastSentByteIndex)
}
struct IWRdsGraphicsChannel extends IUnknown {
    static IID := "{684B7A0B-EDFF-43AD-D5A2-4A8D5388F401}"
    Write(cbSize, pBuffer, pContext)
      => ComCall(3, this.p, UInt32, cbSize, UInt8.Ptr, pBuffer, IUnknown, pContext)
    Close()
      => ComCall(4, this.p)
    Open(pChannelEvents, pOpenContext)
      => ComCall(5, this.p, IWRdsGraphicsChannelEvents, pChannelEvents, IUnknown, pOpenContext)
}
struct WRdsGraphicsChannelType extends Int32 {
    static WRdsGraphicsChannelType_GuaranteedDelivery := 0
    static WRdsGraphicsChannelType_BestEffortDelivery := 1
}
struct IWRdsGraphicsChannelManager extends IUnknown {
    static IID := "{0FD57159-E83E-476A-A8B9-4A7976E71E18}"
    CreateChannel(pszChannelName, channelType, ppVirtualChannel)
      => ComCall(3, this.p, UInt8.Ptr, pszChannelName, WRdsGraphicsChannelType, channelType, IWRdsGraphicsChannel.Ptr, ppVirtualChannel)
}
struct RFX_GFX_RECT {
    left : Int32
    top : Int32
    right : Int32
    bottom : Int32
}
struct RFX_GFX_MSG_HEADER {
    uMSGType : UInt16
    cbSize : UInt16 := this.Size
}
struct RFX_GFX_MONITOR_INFO {
    left : Int32
    top : Int32
    right : Int32
    bottom : Int32
    physicalWidth : UInt32
    physicalHeight : UInt32
    orientation : UInt32
    primary : BOOL
}
struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_REQUEST {
    channelHdr : RFX_GFX_MSG_HEADER
}
struct RFX_GFX_MSG_CLIENT_DESKTOP_INFO_RESPONSE {
    channelHdr : RFX_GFX_MSG_HEADER
    reserved : UInt32
    monitorCount : UInt32
    MonitorData : RFX_GFX_MONITOR_INFO[16]
    clientUniqueId : UInt16[32]
}
struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_NOTIFY {
    channelHdr : RFX_GFX_MSG_HEADER
    ulWidth : UInt32
    ulHeight : UInt32
    ulBpp : UInt32
    Reserved : UInt32
}
struct RFX_GFX_MSG_DESKTOP_CONFIG_CHANGE_CONFIRM {
    channelHdr : RFX_GFX_MSG_HEADER
}
struct RFX_GFX_MSG_DESKTOP_INPUT_RESET {
    channelHdr : RFX_GFX_MSG_HEADER
    ulWidth : UInt32
    ulHeight : UInt32
}
struct RFX_GFX_MSG_DISCONNECT_NOTIFY {
    channelHdr : RFX_GFX_MSG_HEADER
    DisconnectReason : UInt32
}
struct RFX_GFX_MSG_DESKTOP_RESEND_REQUEST {
    channelHdr : RFX_GFX_MSG_HEADER
    RedrawRect : RFX_GFX_RECT
}
struct RFX_GFX_MSG_RDP_DATA {
    channelHdr : RFX_GFX_MSG_HEADER
    rdpData : UInt8[1]
}
struct WTS_SOCKADDR {
    sin_family : UInt16
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            ipv4 : this._ipv4_e__Struct
            ipv6 : this._ipv6_e__Struct
        }
        struct _ipv4_e__Struct {
            sin_port : UInt16
            IN_ADDR : UInt32
            sin_zero : UInt8[8]
        }
        struct _ipv6_e__Struct {
            sin6_port : UInt16
            sin6_flowinfo : UInt32
            sin6_addr : UInt16[8]
            sin6_scope_id : UInt32
        }
    }
}
struct WTS_SMALL_RECT {
    Left : Int16
    Top : Int16
    Right : Int16
    Bottom : Int16
}
struct WTS_RCM_SERVICE_STATE extends Int32 {
    static WTS_SERVICE_NONE := 0
    static WTS_SERVICE_START := 1
    static WTS_SERVICE_STOP := 2
}
struct WTS_RCM_DRAIN_STATE extends Int32 {
    static WTS_DRAIN_STATE_NONE := 0
    static WTS_DRAIN_IN_DRAIN := 1
    static WTS_DRAIN_NOT_IN_DRAIN := 2
}
struct WTS_SERVICE_STATE {
    RcmServiceState : WTS_RCM_SERVICE_STATE
    RcmDrainState : WTS_RCM_DRAIN_STATE
}
struct WTS_SESSION_ID {
    SessionUniqueGuid : GUID
    SessionId : UInt32
}
struct WTS_USER_CREDENTIAL {
    UserName : UInt16[256]
    Password : UInt16[256]
    Domain : UInt16[256]
}
struct WTS_SYSTEMTIME {
    wYear : UInt16
    wMonth : UInt16
    wDayOfWeek : UInt16
    wDay : UInt16
    wHour : UInt16
    wMinute : UInt16
    wSecond : UInt16
    wMilliseconds : UInt16
}
struct WTS_TIME_ZONE_INFORMATION {
    Bias : Int32
    StandardName : UInt16[32]
    StandardDate : WTS_SYSTEMTIME
    StandardBias : Int32
    DaylightName : UInt16[32]
    DaylightDate : WTS_SYSTEMTIME
    DaylightBias : Int32
}
struct WRDS_DYNAMIC_TIME_ZONE_INFORMATION {
    Bias : Int32
    StandardName : UInt16[32]
    StandardDate : WTS_SYSTEMTIME
    StandardBias : Int32
    DaylightName : UInt16[32]
    DaylightDate : WTS_SYSTEMTIME
    DaylightBias : Int32
    TimeZoneKeyName : UInt16[128]
    DynamicDaylightTimeDisabled : UInt16
}
struct WTS_CLIENT_DATA {
    fDisableCtrlAltDel : BOOLEAN
    fDoubleClickDetect : BOOLEAN
    fEnableWindowsKey : BOOLEAN
    fHideTitleBar : BOOLEAN
    fInheritAutoLogon : BOOL
    fPromptForPassword : BOOLEAN
    fUsingSavedCreds : BOOLEAN
    Domain : UInt16[256]
    UserName : UInt16[256]
    Password : UInt16[256]
    fPasswordIsScPin : BOOLEAN
    fInheritInitialProgram : BOOL
    WorkDirectory : UInt16[257]
    InitialProgram : UInt16[257]
    fMaximizeShell : BOOLEAN
    EncryptionLevel : UInt8
    PerformanceFlags : UInt32
    ProtocolName : UInt16[9]
    ProtocolType : UInt16
    fInheritColorDepth : BOOL
    HRes : UInt16
    VRes : UInt16
    ColorDepth : UInt16
    DisplayDriverName : UInt16[9]
    DisplayDeviceName : UInt16[20]
    fMouse : BOOLEAN
    KeyboardLayout : UInt32
    KeyboardType : UInt32
    KeyboardSubType : UInt32
    KeyboardFunctionKey : UInt32
    imeFileName : UInt16[33]
    ActiveInputLocale : UInt32
    fNoAudioPlayback : BOOLEAN
    fRemoteConsoleAudio : BOOLEAN
    AudioDriverName : UInt16[9]
    ClientTimeZone : WTS_TIME_ZONE_INFORMATION
    ClientName : UInt16[21]
    SerialNumber : UInt32
    ClientAddressFamily : UInt32
    ClientAddress : UInt16[31]
    ClientSockAddress : WTS_SOCKADDR
    ClientDirectory : UInt16[257]
    ClientBuildNumber : UInt32
    ClientProductId : UInt16
    OutBufCountHost : UInt16
    OutBufCountClient : UInt16
    OutBufLength : UInt16
    ClientSessionId : UInt32
    ClientDigProductId : UInt16[33]
    fDisableCpm : BOOLEAN
    fDisableCdm : BOOLEAN
    fDisableCcm : BOOLEAN
    fDisableLPT : BOOLEAN
    fDisableClip : BOOLEAN
    fDisablePNP : BOOLEAN
}
struct WTS_USER_DATA {
    WorkDirectory : UInt16[257]
    InitialProgram : UInt16[257]
    UserTimeZone : WTS_TIME_ZONE_INFORMATION
}
struct WTS_POLICY_DATA {
    fDisableEncryption : BOOLEAN
    fDisableAutoReconnect : BOOLEAN
    ColorDepth : UInt32
    MinEncryptionLevel : UInt8
    fDisableCpm : BOOLEAN
    fDisableCdm : BOOLEAN
    fDisableCcm : BOOLEAN
    fDisableLPT : BOOLEAN
    fDisableClip : BOOLEAN
    fDisablePNPRedir : BOOLEAN
}
struct WTS_PROTOCOL_CACHE {
    CacheReads : UInt32
    CacheHits : UInt32
}
struct WTS_CACHE_STATS_UN {
    union {
        ProtocolCache : WTS_PROTOCOL_CACHE[4]
        TShareCacheStats : UInt32
        Reserved : UInt32[20]
    }
}
struct WTS_CACHE_STATS {
    Specific : UInt32
    Data : WTS_CACHE_STATS_UN
    ProtocolType : UInt16
    Length : UInt16
}
struct WTS_PROTOCOL_COUNTERS {
    WdBytes : UInt32
    WdFrames : UInt32
    WaitForOutBuf : UInt32
    Frames : UInt32
    Bytes : UInt32
    CompressedBytes : UInt32
    CompressFlushes : UInt32
    Errors : UInt32
    Timeouts : UInt32
    AsyncFramingError : UInt32
    AsyncOverrunError : UInt32
    AsyncOverflowError : UInt32
    AsyncParityError : UInt32
    TdErrors : UInt32
    ProtocolType : UInt16
    Length : UInt16
    Specific : UInt16
    Reserved : UInt32[100]
}
struct WTS_PROTOCOL_STATUS {
    Output : WTS_PROTOCOL_COUNTERS
    Input : WTS_PROTOCOL_COUNTERS
    Cache : WTS_CACHE_STATS
    AsyncSignal : UInt32
    AsyncSignalMask : UInt32
    Counters : Int64[100]
}
struct WTS_DISPLAY_IOCTL {
    pDisplayIOCtlData : UInt8[256]
    cbDisplayIOCtlData : UInt32
}
struct WTS_LOGON_ERROR_REDIRECTOR_RESPONSE extends Int32 {
    static WTS_LOGON_ERR_INVALID := 0
    static WTS_LOGON_ERR_NOT_HANDLED := 1
    static WTS_LOGON_ERR_HANDLED_SHOW := 2
    static WTS_LOGON_ERR_HANDLED_DONT_SHOW := 3
    static WTS_LOGON_ERR_HANDLED_DONT_SHOW_START_OVER := 4
}
struct WTS_PROPERTY_VALUE {
    Type : UInt16
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            ulVal : UInt32
            strVal : this._strVal_e__Struct
            bVal : this._bVal_e__Struct
            guidVal : GUID
        }
        struct _strVal_e__Struct {
            size : UInt32
            pstrVal : PWSTR
        }
        struct _bVal_e__Struct {
            size : UInt32
            pbVal : PSTR
        }
    }
}
struct WTS_CERT_TYPE extends Int32 {
    static WTS_CERT_TYPE_INVALID := 0
    static WTS_CERT_TYPE_PROPRIETORY := 1
    static WTS_CERT_TYPE_X509 := 2
}
struct WTS_LICENSE_CAPABILITIES {
    KeyExchangeAlg : UInt32
    ProtocolVer : UInt32
    fAuthenticateServer : BOOL
    CertType : WTS_CERT_TYPE
    cbClientName : UInt32
    rgbClientName : UInt8[42]
}
struct WRDS_CONNECTION_SETTING_LEVEL extends Int32 {
    static WRDS_CONNECTION_SETTING_LEVEL_INVALID := 0
    static WRDS_CONNECTION_SETTING_LEVEL_1 := 1
}
struct WRDS_LISTENER_SETTING_LEVEL extends Int32 {
    static WRDS_LISTENER_SETTING_LEVEL_INVALID := 0
    static WRDS_LISTENER_SETTING_LEVEL_1 := 1
}
struct WRDS_SETTING_TYPE extends Int32 {
    static WRDS_SETTING_TYPE_INVALID := 0
    static WRDS_SETTING_TYPE_MACHINE := 1
    static WRDS_SETTING_TYPE_USER := 2
    static WRDS_SETTING_TYPE_SAM := 3
}
struct WRDS_SETTING_STATUS extends Int32 {
    static WRDS_SETTING_STATUS_NOTAPPLICABLE := -1
    static WRDS_SETTING_STATUS_DISABLED := 0
    static WRDS_SETTING_STATUS_ENABLED := 1
    static WRDS_SETTING_STATUS_NOTCONFIGURED := 2
}
struct WRDS_SETTING_LEVEL extends Int32 {
    static WRDS_SETTING_LEVEL_INVALID := 0
    static WRDS_SETTING_LEVEL_1 := 1
}
struct WRDS_LISTENER_SETTINGS_1 {
    MaxProtocolListenerConnectionCount : UInt32
    SecurityDescriptorSize : UInt32
    pSecurityDescriptor : UInt8.Ptr
}
struct WRDS_LISTENER_SETTING {
    union {
        WRdsListenerSettings1 : WRDS_LISTENER_SETTINGS_1
    }
}
struct WRDS_LISTENER_SETTINGS {
    WRdsListenerSettingLevel : WRDS_LISTENER_SETTING_LEVEL
    WRdsListenerSetting : WRDS_LISTENER_SETTING
}
struct WRDS_CONNECTION_SETTINGS_1 {
    fInheritInitialProgram : BOOLEAN
    fInheritColorDepth : BOOLEAN
    fHideTitleBar : BOOLEAN
    fInheritAutoLogon : BOOLEAN
    fMaximizeShell : BOOLEAN
    fDisablePNP : BOOLEAN
    fPasswordIsScPin : BOOLEAN
    fPromptForPassword : BOOLEAN
    fDisableCpm : BOOLEAN
    fDisableCdm : BOOLEAN
    fDisableCcm : BOOLEAN
    fDisableLPT : BOOLEAN
    fDisableClip : BOOLEAN
    fResetBroken : BOOLEAN
    fDisableEncryption : BOOLEAN
    fDisableAutoReconnect : BOOLEAN
    fDisableCtrlAltDel : BOOLEAN
    fDoubleClickDetect : BOOLEAN
    fEnableWindowsKey : BOOLEAN
    fUsingSavedCreds : BOOLEAN
    fMouse : BOOLEAN
    fNoAudioPlayback : BOOLEAN
    fRemoteConsoleAudio : BOOLEAN
    EncryptionLevel : UInt8
    ColorDepth : UInt16
    ProtocolType : UInt16
    HRes : UInt16
    VRes : UInt16
    ClientProductId : UInt16
    OutBufCountHost : UInt16
    OutBufCountClient : UInt16
    OutBufLength : UInt16
    KeyboardLayout : UInt32
    MaxConnectionTime : UInt32
    MaxDisconnectionTime : UInt32
    MaxIdleTime : UInt32
    PerformanceFlags : UInt32
    KeyboardType : UInt32
    KeyboardSubType : UInt32
    KeyboardFunctionKey : UInt32
    ActiveInputLocale : UInt32
    SerialNumber : UInt32
    ClientAddressFamily : UInt32
    ClientBuildNumber : UInt32
    ClientSessionId : UInt32
    WorkDirectory : UInt16[257]
    InitialProgram : UInt16[257]
    UserName : UInt16[256]
    Domain : UInt16[256]
    Password : UInt16[256]
    ProtocolName : UInt16[9]
    DisplayDriverName : UInt16[9]
    DisplayDeviceName : UInt16[20]
    imeFileName : UInt16[33]
    AudioDriverName : UInt16[9]
    ClientName : UInt16[21]
    ClientAddress : UInt16[31]
    ClientDirectory : UInt16[257]
    ClientDigProductId : UInt16[33]
    ClientSockAddress : WTS_SOCKADDR
    ClientTimeZone : WTS_TIME_ZONE_INFORMATION
    WRdsListenerSettings : WRDS_LISTENER_SETTINGS
    EventLogActivityId : GUID
    ContextSize : UInt32
    ContextData : UInt8.Ptr
}
struct WRDS_SETTINGS_1 {
    WRdsDisableClipStatus : WRDS_SETTING_STATUS
    WRdsDisableClipValue : UInt32
    WRdsDisableLPTStatus : WRDS_SETTING_STATUS
    WRdsDisableLPTValue : UInt32
    WRdsDisableCcmStatus : WRDS_SETTING_STATUS
    WRdsDisableCcmValue : UInt32
    WRdsDisableCdmStatus : WRDS_SETTING_STATUS
    WRdsDisableCdmValue : UInt32
    WRdsDisableCpmStatus : WRDS_SETTING_STATUS
    WRdsDisableCpmValue : UInt32
    WRdsDisablePnpStatus : WRDS_SETTING_STATUS
    WRdsDisablePnpValue : UInt32
    WRdsEncryptionLevelStatus : WRDS_SETTING_STATUS
    WRdsEncryptionValue : UInt32
    WRdsColorDepthStatus : WRDS_SETTING_STATUS
    WRdsColorDepthValue : UInt32
    WRdsDisableAutoReconnecetStatus : WRDS_SETTING_STATUS
    WRdsDisableAutoReconnecetValue : UInt32
    WRdsDisableEncryptionStatus : WRDS_SETTING_STATUS
    WRdsDisableEncryptionValue : UInt32
    WRdsResetBrokenStatus : WRDS_SETTING_STATUS
    WRdsResetBrokenValue : UInt32
    WRdsMaxIdleTimeStatus : WRDS_SETTING_STATUS
    WRdsMaxIdleTimeValue : UInt32
    WRdsMaxDisconnectTimeStatus : WRDS_SETTING_STATUS
    WRdsMaxDisconnectTimeValue : UInt32
    WRdsMaxConnectTimeStatus : WRDS_SETTING_STATUS
    WRdsMaxConnectTimeValue : UInt32
    WRdsKeepAliveStatus : WRDS_SETTING_STATUS
    WRdsKeepAliveStartValue : BOOLEAN
    WRdsKeepAliveIntervalValue : UInt32
}
struct WRDS_CONNECTION_SETTING {
    union {
        WRdsConnectionSettings1 : WRDS_CONNECTION_SETTINGS_1
    }
}
struct WRDS_CONNECTION_SETTINGS {
    WRdsConnectionSettingLevel : WRDS_CONNECTION_SETTING_LEVEL
    WRdsConnectionSetting : WRDS_CONNECTION_SETTING
}
struct WRDS_SETTING {
    union {
        WRdsSettings1 : WRDS_SETTINGS_1
    }
}
struct WRDS_SETTINGS {
    WRdsSettingType : WRDS_SETTING_TYPE
    WRdsSettingLevel : WRDS_SETTING_LEVEL
    WRdsSetting : WRDS_SETTING
}
struct IWTSProtocolManager extends IUnknown {
    static IID := "{F9EAF6CC-ED79-4F01-821D-1F881B9F66CC}"
    CreateListener(wszListenerName, pProtocolListener)
      => ComCall(3, this.p, "Str", wszListenerName, IWTSProtocolListener.Ptr, pProtocolListener)
    NotifyServiceStateChange(pTSServiceStateChange)
      => ComCall(4, this.p, WTS_SERVICE_STATE.Ptr, pTSServiceStateChange)
    NotifySessionOfServiceStart(SessionId)
      => ComCall(5, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionOfServiceStop(SessionId)
      => ComCall(6, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionStateChange(SessionId, EventId)
      => ComCall(7, this.p, WTS_SESSION_ID.Ptr, SessionId, UInt32, EventId)
}
struct IWTSProtocolListener extends IUnknown {
    static IID := "{23083765-45F0-4394-8F69-32B2BC0EF4CA}"
    StartListen(pCallback)
      => ComCall(3, this.p, IWTSProtocolListenerCallback, pCallback)
    StopListen()
      => ComCall(4, this.p)
}
struct IWTSProtocolListenerCallback extends IUnknown {
    static IID := "{23083765-1A2D-4DE2-97DE-4A35F260F0B3}"
    OnConnected(pConnection, pCallback)
      => ComCall(3, this.p, IWTSProtocolConnection, pConnection, IWTSProtocolConnectionCallback.Ptr, pCallback)
}
struct IWTSProtocolConnection extends IUnknown {
    static IID := "{23083765-9095-4648-98BF-EF81C914032D}"
    GetLogonErrorRedirector(ppLogonErrorRedir)
      => ComCall(3, this.p, IWTSProtocolLogonErrorRedirector.Ptr, ppLogonErrorRedir)
    SendPolicyData(pPolicyData)
      => ComCall(4, this.p, WTS_POLICY_DATA.Ptr, pPolicyData)
    AcceptConnection()
      => ComCall(5, this.p)
    GetClientData(pClientData)
      => ComCall(6, this.p, WTS_CLIENT_DATA.Ptr, pClientData)
    GetUserCredentials(pUserCreds)
      => ComCall(7, this.p, WTS_USER_CREDENTIAL.Ptr, pUserCreds)
    GetLicenseConnection(ppLicenseConnection)
      => ComCall(8, this.p, IWTSProtocolLicenseConnection.Ptr, ppLicenseConnection)
    AuthenticateClientToSession(SessionId)
      => ComCall(9, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionId(SessionId)
      => ComCall(10, this.p, WTS_SESSION_ID.Ptr, SessionId)
    GetProtocolHandles(pKeyboardHandle, pMouseHandle, pBeepHandle, pVideoHandle)
      => ComCall(11, this.p, HANDLE_PTR.Ptr, pKeyboardHandle, HANDLE_PTR.Ptr, pMouseHandle, HANDLE_PTR.Ptr, pBeepHandle, HANDLE_PTR.Ptr, pVideoHandle)
    ConnectNotify(SessionId)
      => ComCall(12, this.p, UInt32, SessionId)
    IsUserAllowedToLogon(SessionId, UserToken, pDomainName, pUserName)
      => ComCall(13, this.p, UInt32, SessionId, HANDLE_PTR, UserToken, "Str", pDomainName, "Str", pUserName)
    SessionArbitrationEnumeration(hUserToken, bSingleSessionPerUserEnabled, pSessionIdArray)
      => ComCall(14, this.p, HANDLE_PTR, hUserToken, BOOL, bSingleSessionPerUserEnabled, UInt32.Ptr, pSessionIdArray, UInt32.Ptr, pSessionIdArray.Length)
    LogonNotify(hClientToken, wszUserName, wszDomainName, SessionId)
      => ComCall(15, this.p, HANDLE_PTR, hClientToken, "Str", wszUserName, "Str", wszDomainName, WTS_SESSION_ID.Ptr, SessionId)
    GetUserData(pPolicyData, pClientData)
      => ComCall(16, this.p, WTS_POLICY_DATA.Ptr, pPolicyData, WTS_USER_DATA.Ptr, pClientData)
    DisconnectNotify()
      => ComCall(17, this.p)
    Close()
      => ComCall(18, this.p)
    GetProtocolStatus(pProtocolStatus)
      => ComCall(19, this.p, WTS_PROTOCOL_STATUS.Ptr, pProtocolStatus)
    GetLastInputTime(pLastInputTime)
      => ComCall(20, this.p, Int64.Ptr, pLastInputTime)
    SetErrorInfo(ulError)
      => ComCall(21, this.p, UInt32, ulError)
    SendBeep(Frequency, Duration)
      => ComCall(22, this.p, UInt32, Frequency, UInt32, Duration)
    CreateVirtualChannel(szEndpointName, bStatic, RequestedPriority, phChannel)
      => ComCall(23, this.p, PSTR, szEndpointName, BOOL, bStatic, UInt32, RequestedPriority, IntPtr.Ptr, phChannel)
    QueryProperty(QueryType, pPropertyEntriesIn, pPropertyEntriesOut)
      => ComCall(24, this.p, GUID, QueryType, UInt32, pPropertyEntriesIn.Length, UInt32, pPropertyEntriesOut.Length, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesIn, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesOut)
    GetShadowConnection(ppShadowConnection)
      => ComCall(25, this.p, IWTSProtocolShadowConnection.Ptr, ppShadowConnection)
}
struct IWTSProtocolConnectionCallback extends IUnknown {
    static IID := "{23083765-75EB-41FE-B4FB-E086242AFA0F}"
    OnReady()
      => ComCall(3, this.p)
    BrokenConnection(Reason, Source)
      => ComCall(4, this.p, UInt32, Reason, UInt32, Source)
    StopScreenUpdates()
      => ComCall(5, this.p)
    RedrawWindow(rect)
      => ComCall(6, this.p, WTS_SMALL_RECT.Ptr, rect)
    DisplayIOCtl(DisplayIOCtl)
      => ComCall(7, this.p, WTS_DISPLAY_IOCTL.Ptr, DisplayIOCtl)
}
struct IWTSProtocolShadowConnection extends IUnknown {
    static IID := "{EE3B0C14-37FB-456B-BAB3-6D6CD51E13BF}"
    Start(pTargetServerName, TargetSessionId, HotKeyVk, HotkeyModifiers, pShadowCallback)
      => ComCall(3, this.p, "Str", pTargetServerName, UInt32, TargetSessionId, UInt8, HotKeyVk, UInt16, HotkeyModifiers, IWTSProtocolShadowCallback, pShadowCallback)
    Stop()
      => ComCall(4, this.p)
    DoTarget(pParam1, pParam2, pParam3, pParam4, pClientName)
      => ComCall(5, this.p, UInt8.Ptr, pParam1, UInt32, pParam1.Length, UInt8.Ptr, pParam2, UInt32, pParam2.Length, UInt8.Ptr, pParam3, UInt32, pParam3.Length, UInt8.Ptr, pParam4, UInt32, pParam4.Length, "Str", pClientName)
}
struct IWTSProtocolShadowCallback extends IUnknown {
    static IID := "{503A2504-AAE5-4AB1-93E0-6D1C4BC6F71A}"
    StopShadow()
      => ComCall(3, this.p)
    InvokeTargetShadow(pTargetServerName?, TargetSessionId, pParam1, pParam2, pParam3, pParam4, pClientName)
      => ComCall(4, this.p, "Str", pTargetServerName?, UInt32, TargetSessionId, UInt8.Ptr, pParam1, UInt32, pParam1.Length, UInt8.Ptr, pParam2, UInt32, pParam2.Length, UInt8.Ptr, pParam3, UInt32, pParam3.Length, UInt8.Ptr, pParam4, UInt32, pParam4.Length, "Str", pClientName)
}
struct IWTSProtocolLicenseConnection extends IUnknown {
    static IID := "{23083765-178C-4079-8E4A-FEA6496A4D70}"
    RequestLicensingCapabilities(ppLicenseCapabilities, pcbLicenseCapabilities)
      => ComCall(3, this.p, WTS_LICENSE_CAPABILITIES.Ptr, ppLicenseCapabilities, UInt32.Ptr, pcbLicenseCapabilities)
    SendClientLicense(pClientLicense)
      => ComCall(4, this.p, UInt8.Ptr, pClientLicense, UInt32, pClientLicense.Length)
    RequestClientLicense(Reserve1, ppClientLicense)
      => ComCall(5, this.p, UInt8.Ptr, Reserve1, UInt32, Reserve1.Length, UInt8.Ptr, ppClientLicense, UInt32.Ptr, ppClientLicense.Length)
    ProtocolComplete(ulComplete)
      => ComCall(6, this.p, UInt32, ulComplete)
}
struct IWTSProtocolLogonErrorRedirector extends IUnknown {
    static IID := "{FD9B61A7-2916-4627-8DEE-4328711AD6CB}"
    OnBeginPainting()
      => ComCall(3, this.p)
    RedirectStatus(pszMessage, pResponse)
      => ComCall(4, this.p, "Str", pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
    RedirectMessage(pszCaption, pszMessage, uType, pResponse)
      => ComCall(5, this.p, "Str", pszCaption, "Str", pszMessage, UInt32, uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
    RedirectLogonError(ntsStatus, ntsSubstatus, pszCaption, pszMessage, uType, pResponse)
      => ComCall(6, this.p, Int32, ntsStatus, Int32, ntsSubstatus, "Str", pszCaption, "Str", pszMessage, UInt32, uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
}
struct IWRdsProtocolSettings extends IUnknown {
    static IID := "{654A5A6A-2550-47EB-B6F7-EBD637475265}"
    GetSettings(WRdsSettingType, WRdsSettingLevel, pWRdsSettings)
      => ComCall(3, this.p, WRDS_SETTING_TYPE, WRdsSettingType, WRDS_SETTING_LEVEL, WRdsSettingLevel, WRDS_SETTINGS.Ptr, pWRdsSettings)
    MergeSettings(pWRdsSettings, WRdsConnectionSettingLevel, pWRdsConnectionSettings)
      => ComCall(4, this.p, WRDS_SETTINGS.Ptr, pWRdsSettings, WRDS_CONNECTION_SETTING_LEVEL, WRdsConnectionSettingLevel, WRDS_CONNECTION_SETTINGS.Ptr, pWRdsConnectionSettings)
}
struct IWRdsProtocolManager extends IUnknown {
    static IID := "{DC796967-3ABB-40CD-A446-105276B58950}"
    Initialize(pIWRdsSettings, pWRdsSettings)
      => ComCall(3, this.p, IWRdsProtocolSettings, pIWRdsSettings, WRDS_SETTINGS.Ptr, pWRdsSettings)
    CreateListener(wszListenerName, pProtocolListener)
      => ComCall(4, this.p, "Str", wszListenerName, IWRdsProtocolListener.Ptr, pProtocolListener)
    NotifyServiceStateChange(pTSServiceStateChange)
      => ComCall(5, this.p, WTS_SERVICE_STATE.Ptr, pTSServiceStateChange)
    NotifySessionOfServiceStart(SessionId)
      => ComCall(6, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionOfServiceStop(SessionId)
      => ComCall(7, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionStateChange(SessionId, EventId)
      => ComCall(8, this.p, WTS_SESSION_ID.Ptr, SessionId, UInt32, EventId)
    NotifySettingsChange(pWRdsSettings)
      => ComCall(9, this.p, WRDS_SETTINGS.Ptr, pWRdsSettings)
    Uninitialize()
      => ComCall(10, this.p)
}
struct IWRdsProtocolListener extends IUnknown {
    static IID := "{FCBC131B-C686-451D-A773-E279E230F540}"
    GetSettings(WRdsListenerSettingLevel, pWRdsListenerSettings)
      => ComCall(3, this.p, WRDS_LISTENER_SETTING_LEVEL, WRdsListenerSettingLevel, WRDS_LISTENER_SETTINGS.Ptr, pWRdsListenerSettings)
    StartListen(pCallback)
      => ComCall(4, this.p, IWRdsProtocolListenerCallback, pCallback)
    StopListen()
      => ComCall(5, this.p)
}
struct IWRdsProtocolListenerCallback extends IUnknown {
    static IID := "{3AB27E5B-4449-4DC1-B74A-91621D4FE984}"
    OnConnected(pConnection, pWRdsConnectionSettings, pCallback)
      => ComCall(3, this.p, IWRdsProtocolConnection, pConnection, WRDS_CONNECTION_SETTINGS.Ptr, pWRdsConnectionSettings, IWRdsProtocolConnectionCallback.Ptr, pCallback)
}
struct IWRdsProtocolConnection extends IUnknown {
    static IID := "{324ED94F-FDAF-4FF6-81A8-42ABE755830B}"
    GetLogonErrorRedirector(ppLogonErrorRedir)
      => ComCall(3, this.p, IWRdsProtocolLogonErrorRedirector.Ptr, ppLogonErrorRedir)
    AcceptConnection()
      => ComCall(4, this.p)
    GetClientData(pClientData)
      => ComCall(5, this.p, WTS_CLIENT_DATA.Ptr, pClientData)
    GetClientMonitorData(pNumMonitors, pPrimaryMonitor)
      => ComCall(6, this.p, UInt32.Ptr, pNumMonitors, UInt32.Ptr, pPrimaryMonitor)
    GetUserCredentials(pUserCreds)
      => ComCall(7, this.p, WTS_USER_CREDENTIAL.Ptr, pUserCreds)
    GetLicenseConnection(ppLicenseConnection)
      => ComCall(8, this.p, IWRdsProtocolLicenseConnection.Ptr, ppLicenseConnection)
    AuthenticateClientToSession(SessionId)
      => ComCall(9, this.p, WTS_SESSION_ID.Ptr, SessionId)
    NotifySessionId(SessionId, SessionHandle)
      => ComCall(10, this.p, WTS_SESSION_ID.Ptr, SessionId, HANDLE_PTR, SessionHandle)
    GetInputHandles(pKeyboardHandle, pMouseHandle, pBeepHandle)
      => ComCall(11, this.p, HANDLE_PTR.Ptr, pKeyboardHandle, HANDLE_PTR.Ptr, pMouseHandle, HANDLE_PTR.Ptr, pBeepHandle)
    GetVideoHandle(pVideoHandle)
      => ComCall(12, this.p, HANDLE_PTR.Ptr, pVideoHandle)
    ConnectNotify(SessionId)
      => ComCall(13, this.p, UInt32, SessionId)
    IsUserAllowedToLogon(SessionId, UserToken, pDomainName, pUserName)
      => ComCall(14, this.p, UInt32, SessionId, HANDLE_PTR, UserToken, "Str", pDomainName, "Str", pUserName)
    SessionArbitrationEnumeration(hUserToken, bSingleSessionPerUserEnabled, pSessionIdArray)
      => ComCall(15, this.p, HANDLE_PTR, hUserToken, BOOL, bSingleSessionPerUserEnabled, UInt32.Ptr, pSessionIdArray, UInt32.Ptr, pSessionIdArray.Length)
    LogonNotify(hClientToken, wszUserName, wszDomainName, SessionId, pWRdsConnectionSettings)
      => ComCall(16, this.p, HANDLE_PTR, hClientToken, "Str", wszUserName, "Str", wszDomainName, WTS_SESSION_ID.Ptr, SessionId, WRDS_CONNECTION_SETTINGS.Ptr, pWRdsConnectionSettings)
    PreDisconnect(DisconnectReason)
      => ComCall(17, this.p, UInt32, DisconnectReason)
    DisconnectNotify()
      => ComCall(18, this.p)
    Close()
      => ComCall(19, this.p)
    GetProtocolStatus(pProtocolStatus)
      => ComCall(20, this.p, WTS_PROTOCOL_STATUS.Ptr, pProtocolStatus)
    GetLastInputTime(pLastInputTime)
      => ComCall(21, this.p, Int64.Ptr, pLastInputTime)
    SetErrorInfo(ulError)
      => ComCall(22, this.p, UInt32, ulError)
    CreateVirtualChannel(szEndpointName, bStatic, RequestedPriority, phChannel)
      => ComCall(23, this.p, PSTR, szEndpointName, BOOL, bStatic, UInt32, RequestedPriority, IntPtr.Ptr, phChannel)
    QueryProperty(QueryType, pPropertyEntriesIn, pPropertyEntriesOut)
      => ComCall(24, this.p, GUID, QueryType, UInt32, pPropertyEntriesIn.Length, UInt32, pPropertyEntriesOut.Length, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesIn, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesOut)
    GetShadowConnection(ppShadowConnection)
      => ComCall(25, this.p, IWRdsProtocolShadowConnection.Ptr, ppShadowConnection)
    NotifyCommandProcessCreated(SessionId)
      => ComCall(26, this.p, UInt32, SessionId)
}
struct IWRdsProtocolConnectionCallback extends IUnknown {
    static IID := "{F1D70332-D070-4EF1-A088-78313536C2D6}"
    OnReady()
      => ComCall(3, this.p)
    BrokenConnection(Reason, Source)
      => ComCall(4, this.p, UInt32, Reason, UInt32, Source)
    StopScreenUpdates()
      => ComCall(5, this.p)
    RedrawWindow(rect)
      => ComCall(6, this.p, WTS_SMALL_RECT.Ptr, rect)
    GetConnectionId(pConnectionId)
      => ComCall(7, this.p, UInt32.Ptr, pConnectionId)
}
struct IWRdsProtocolShadowConnection extends IUnknown {
    static IID := "{9AE85CE6-CADE-4548-8FEB-99016597F60A}"
    Start(pTargetServerName, TargetSessionId, HotKeyVk, HotkeyModifiers, pShadowCallback)
      => ComCall(3, this.p, "Str", pTargetServerName, UInt32, TargetSessionId, UInt8, HotKeyVk, UInt16, HotkeyModifiers, IWRdsProtocolShadowCallback, pShadowCallback)
    Stop()
      => ComCall(4, this.p)
    DoTarget(pParam1, pParam2, pParam3, pParam4, pClientName)
      => ComCall(5, this.p, UInt8.Ptr, pParam1, UInt32, pParam1.Length, UInt8.Ptr, pParam2, UInt32, pParam2.Length, UInt8.Ptr, pParam3, UInt32, pParam3.Length, UInt8.Ptr, pParam4, UInt32, pParam4.Length, "Str", pClientName)
}
struct IWRdsProtocolShadowCallback extends IUnknown {
    static IID := "{E0667CE0-0372-40D6-ADB2-A0F3322674D6}"
    StopShadow()
      => ComCall(3, this.p)
    InvokeTargetShadow(pTargetServerName?, TargetSessionId, pParam1, pParam2, pParam3, pParam4, pClientName)
      => ComCall(4, this.p, "Str", pTargetServerName?, UInt32, TargetSessionId, UInt8.Ptr, pParam1, UInt32, pParam1.Length, UInt8.Ptr, pParam2, UInt32, pParam2.Length, UInt8.Ptr, pParam3, UInt32, pParam3.Length, UInt8.Ptr, pParam4, UInt32, pParam4.Length, "Str", pClientName)
}
struct IWRdsProtocolLicenseConnection extends IUnknown {
    static IID := "{1D6A145F-D095-4424-957A-407FAE822D84}"
    RequestLicensingCapabilities(ppLicenseCapabilities, pcbLicenseCapabilities)
      => ComCall(3, this.p, WTS_LICENSE_CAPABILITIES.Ptr, ppLicenseCapabilities, UInt32.Ptr, pcbLicenseCapabilities)
    SendClientLicense(pClientLicense)
      => ComCall(4, this.p, UInt8.Ptr, pClientLicense, UInt32, pClientLicense.Length)
    RequestClientLicense(Reserve1, ppClientLicense)
      => ComCall(5, this.p, UInt8.Ptr, Reserve1, UInt32, Reserve1.Length, UInt8.Ptr, ppClientLicense, UInt32.Ptr, ppClientLicense.Length)
    ProtocolComplete(ulComplete)
      => ComCall(6, this.p, UInt32, ulComplete)
}
struct IWRdsProtocolLogonErrorRedirector extends IUnknown {
    static IID := "{519FE83B-142A-4120-A3D5-A405D315281A}"
    OnBeginPainting()
      => ComCall(3, this.p)
    RedirectStatus(pszMessage, pResponse)
      => ComCall(4, this.p, "Str", pszMessage, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
    RedirectMessage(pszCaption, pszMessage, uType, pResponse)
      => ComCall(5, this.p, "Str", pszCaption, "Str", pszMessage, UInt32, uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
    RedirectLogonError(ntsStatus, ntsSubstatus, pszCaption, pszMessage, uType, pResponse)
      => ComCall(6, this.p, Int32, ntsStatus, Int32, ntsSubstatus, "Str", pszCaption, "Str", pszMessage, UInt32, uType, WTS_LOGON_ERROR_REDIRECTOR_RESPONSE.Ptr, pResponse)
}
struct IWRdsWddmIddProps extends IUnknown {
    static IID := "{1382DF4D-A289-43D1-A184-144726F9AF90}"
    GetHardwareId(pDisplayDriverHardwareId)
      => ComCall(3, this.p, "Str", pDisplayDriverHardwareId, UInt32, pDisplayDriverHardwareId.Length)
    OnDriverLoad(SessionId, DriverHandle)
      => ComCall(4, this.p, UInt32, SessionId, HANDLE_PTR, DriverHandle)
    OnDriverUnload(SessionId)
      => ComCall(5, this.p, UInt32, SessionId)
    EnableWddmIdd(Enabled)
      => ComCall(6, this.p, BOOL, Enabled)
}
struct IWRdsWddmIddProps1 extends IUnknown {
    static IID := "{60F71B1A-3682-4BC7-997E-4E4F02A08148}"
    GetHardwareId(pDisplayDriverHardwareId)
      => ComCall(3, this.p, "Str", pDisplayDriverHardwareId, UInt32, pDisplayDriverHardwareId.Length)
    OnDriverLoad(SessionId, DeviceInstance)
      => ComCall(4, this.p, UInt32, SessionId, "Str", DeviceInstance)
    OnDriverUnload(SessionId)
      => ComCall(5, this.p, UInt32, SessionId)
}
struct IWRdsProtocolConnectionSettings extends IUnknown {
    static IID := "{83FCF5D3-F6F4-EA94-9CD2-32F280E1E510}"
    SetConnectionSetting(PropertyID, pPropertyEntriesIn)
      => ComCall(3, this.p, GUID, PropertyID, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesIn)
    GetConnectionSetting(PropertyID, pPropertyEntriesOut)
      => ComCall(4, this.p, GUID, PropertyID, WTS_PROPERTY_VALUE.Ptr, pPropertyEntriesOut)
}
struct IWRdsEnhancedFastReconnectArbitrator extends IUnknown {
    static IID := "{5718AE9B-47F2-499F-B634-D8175BD51131}"
    GetSessionForEnhancedFastReconnect(pSessionIdArray, dwSessionCount, pResultSessionId)
      => ComCall(3, this.p, Int32.Ptr, pSessionIdArray, UInt32, dwSessionCount, Int32.Ptr, pResultSessionId)
}
struct IWRdsProtocolConnection2 extends IWRdsProtocolConnection {
    static IID := "{C2BD9B66-4A76-4701-B6A3-BFAFC1482169}"
    GetSerializedUserCredential(userCredential)
      => ComCall(27, this.p, WTS_SERIALIZED_USER_CREDENTIAL.Ptr.Ptr, userCredential)
}
struct IWRdsProtocolConnection3_Experimental extends IWRdsProtocolConnection2 {
    static IID := "{3AA87DA3-F60B-4280-B385-F1CC22AD5D9F}"
    GetSerializedUserCredentialInteractively(scenarioId, usernameHint, userCredential)
      => ComCall(28, this.p, GUID.Ptr, scenarioId, "Str", usernameHint, WTS_SERIALIZED_USER_CREDENTIAL.Ptr.Ptr, userCredential)
}
struct PasswordEncodingType extends Int32 {
    static PasswordEncodingUTF8 := 0
    static PasswordEncodingUTF16LE := 1
    static PasswordEncodingUTF16BE := 2
}
struct IRemoteDesktopClientSettings extends IDispatch {
    static IID := "{48A0F2A7-2713-431F-BBAC-6F4558E7D64D}"
    ApplySettings(rdpFileContents)
      => ComCall(7, this.p, BSTR, rdpFileContents)
    RetrieveSettings(rdpFileContents)
      => ComCall(8, this.p, BSTR.Ptr, rdpFileContents)
    GetRdpProperty(propertyName, value)
      => ComCall(9, this.p, BSTR, propertyName, VARIANT.Ptr, value)
    SetRdpProperty(propertyName, value)
      => ComCall(10, this.p, BSTR, propertyName, VARIANT, value)
}
struct RemoteActionType extends Int32 {
    static RemoteActionCharms := 0
    static RemoteActionAppbar := 1
    static RemoteActionSnap := 2
    static RemoteActionStartScreen := 3
    static RemoteActionAppSwitch := 4
}
struct SnapshotEncodingType extends Int32 {
    static SnapshotEncodingDataUri := 0
}
struct SnapshotFormatType extends Int32 {
    static SnapshotFormatPng := 0
    static SnapshotFormatJpeg := 1
    static SnapshotFormatBmp := 2
}
struct IRemoteDesktopClientActions extends IDispatch {
    static IID := "{7D54BC4E-1028-45D4-8B0A-B9B6BFFBA176}"
    SuspendScreenUpdates()
      => ComCall(7, this.p)
    ResumeScreenUpdates()
      => ComCall(8, this.p)
    ExecuteRemoteAction(remoteAction)
      => ComCall(9, this.p, RemoteActionType, remoteAction)
    GetSnapshot(snapshotEncoding, snapshotFormat, snapshotWidth, snapshotHeight, snapshotData)
      => ComCall(10, this.p, SnapshotEncodingType, snapshotEncoding, SnapshotFormatType, snapshotFormat, UInt32, snapshotWidth, UInt32, snapshotHeight, BSTR.Ptr, snapshotData)
}
struct IRemoteDesktopClientTouchPointer extends IDispatch {
    static IID := "{260EC22D-8CBC-44B5-9E88-2A37F6C93AE9}"
    put_Enabled(enabled)
      => ComCall(7, this.p, VARIANT_BOOL, enabled)
    get_Enabled(enabled)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, enabled)
    put_EventsEnabled(eventsEnabled)
      => ComCall(9, this.p, VARIANT_BOOL, eventsEnabled)
    get_EventsEnabled(eventsEnabled)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, eventsEnabled)
    put_PointerSpeed(pointerSpeed)
      => ComCall(11, this.p, UInt32, pointerSpeed)
    get_PointerSpeed(pointerSpeed)
      => ComCall(12, this.p, UInt32.Ptr, pointerSpeed)
}
struct KeyCombinationType extends Int32 {
    static KeyCombinationHome := 0
    static KeyCombinationLeft := 1
    static KeyCombinationUp := 2
    static KeyCombinationRight := 3
    static KeyCombinationDown := 4
    static KeyCombinationScroll := 5
}
struct IRemoteDesktopClient extends IDispatch {
    static IID := "{57D25668-625A-4905-BE4E-304CAA13F89C}"
    Connect()
      => ComCall(7, this.p)
    Disconnect()
      => ComCall(8, this.p)
    Reconnect(width, height)
      => ComCall(9, this.p, UInt32, width, UInt32, height)
    get_Settings(settings)
      => ComCall(10, this.p, IRemoteDesktopClientSettings.Ptr, settings)
    get_Actions(actions)
      => ComCall(11, this.p, IRemoteDesktopClientActions.Ptr, actions)
    get_TouchPointer(touchPointer)
      => ComCall(12, this.p, IRemoteDesktopClientTouchPointer.Ptr, touchPointer)
    DeleteSavedCredentials(serverName)
      => ComCall(13, this.p, BSTR, serverName)
    UpdateSessionDisplaySettings(width, height)
      => ComCall(14, this.p, UInt32, width, UInt32, height)
    attachEvent(eventName, callback?)
      => ComCall(15, this.p, BSTR, eventName, IDispatch, callback?)
    detachEvent(eventName, callback?)
      => ComCall(16, this.p, BSTR, eventName, IDispatch, callback?)
}
struct IRemoteSystemAdditionalInfoProvider extends IUnknown {
    static IID := "{EEAA3D5F-EC63-4D27-AF38-E86B1D7292CB}"
    GetAdditionalInfo(deduplicationId, riid, mapView)
      => ComCall(3, this.p, HSTRING.Ptr, deduplicationId, GUID.Ptr, riid, Struct.Ptr.Ptr, mapView)
}
struct WTSSESSION_NOTIFICATION {
    cbSize : UInt32 := this.Size
    dwSessionId : UInt32
}
