#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HANDLE, HRESULT, LPARAM, PWSTR, VARIANT_BOOL, WPARAM}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}

struct CPU_ARCHITECTURE extends UInt32 {
    static CPU_ARCHITECTURE_AMD64 := 9
    static CPU_ARCHITECTURE_IA64 := 6
    static CPU_ARCHITECTURE_INTEL := 0
}
struct PFN_WDS_CLI_CALLBACK_MESSAGE_ID extends UInt32 {
    static WDS_CLI_MSG_START := 0
    static WDS_CLI_MSG_COMPLETE := 1
    static WDS_CLI_MSG_PROGRESS := 2
    static WDS_CLI_MSG_TEXT := 3
}
struct WDS_TRANSPORTCLIENT_REQUEST_AUTH_LEVEL extends UInt32 {
    static WDS_TRANSPORTCLIENT_AUTH := 1
    static WDS_TRANSPORTCLIENT_NO_AUTH := 2
}
struct WDS_CLI_CRED {
    pwszUserName : PWSTR
    pwszDomain : PWSTR
    pwszPassword : PWSTR
}
struct PFN_WdsCliTraceFunction extends FunctionPointer {
    static Types := [PWSTR, Int8.Ptr, "Void"]
}
struct WDS_CLI_IMAGE_TYPE extends Int32 {
    static WDS_CLI_IMAGE_TYPE_UNKNOWN := 0
    static WDS_CLI_IMAGE_TYPE_WIM := 1
    static WDS_CLI_IMAGE_TYPE_VHD := 2
    static WDS_CLI_IMAGE_TYPE_VHDX := 3
}
struct WDS_CLI_FIRMWARE_TYPE extends Int32 {
    static WDS_CLI_FIRMWARE_UNKNOWN := 0
    static WDS_CLI_FIRMWARE_BIOS := 1
    static WDS_CLI_FIRMWARE_EFI := 2
}
struct WDS_CLI_IMAGE_PARAM_TYPE extends Int32 {
    static WDS_CLI_IMAGE_PARAM_UNKNOWN := 0
    static WDS_CLI_IMAGE_PARAM_SPARSE_FILE := 1
    static WDS_CLI_IMAGE_PARAM_SUPPORTED_FIRMWARES := 2
}
struct PFN_WdsCliCallback extends FunctionPointer {
    static Types := [PFN_WDS_CLI_CALLBACK_MESSAGE_ID, WPARAM, LPARAM, Struct.Ptr, "Void"]
}
struct PXE_DHCP_OPTION {
    OptionType : UInt8
    OptionLength : UInt8
    OptionValue : UInt8[1]
}
struct PXE_DHCP_MESSAGE {
    Operation : UInt8
    HardwareAddressType : UInt8
    HardwareAddressLength : UInt8
    HopCount : UInt8
    TransactionID : UInt32
    SecondsSinceBoot : UInt16
    Reserved : UInt16
    ClientIpAddress : UInt32
    YourIpAddress : UInt32
    BootstrapServerAddress : UInt32
    RelayAgentIpAddress : UInt32
    HardwareAddress : UInt8[16]
    HostName : UInt8[64]
    BootFileName : UInt8[128]
    Anonymous : this._Anonymous_e__Union
    Option : PXE_DHCP_OPTION
    struct _Anonymous_e__Union {
        union {
            bMagicCookie : UInt8[4]
            uMagicCookie : UInt32
        }
    }
}
struct PXE_DHCPV6_OPTION {
    OptionCode : UInt16
    DataLength : UInt16
    Data : UInt8[1]
}
struct PXE_DHCPV6_MESSAGE_HEADER {
    MessageType : UInt8
    Message : UInt8[1]
}
struct PXE_DHCPV6_MESSAGE {
    MessageType : UInt8
    TransactionIDByte1 : UInt8
    TransactionIDByte2 : UInt8
    TransactionIDByte3 : UInt8
    Options : PXE_DHCPV6_OPTION[1]
}
struct PXE_DHCPV6_RELAY_MESSAGE {
    MessageType : UInt8
    HopCount : UInt8
    LinkAddress : UInt8[16]
    PeerAddress : UInt8[16]
    Options : PXE_DHCPV6_OPTION[1]
}
struct PXE_PROVIDER {
    uSizeOfStruct : UInt32
    pwszName : PWSTR
    pwszFilePath : PWSTR
    bIsCritical : BOOL
    uIndex : UInt32
}
struct PXE_ADDRESS {
    uFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    uAddrLen : UInt32
    uPort : UInt16
    struct _Anonymous_e__Union {
        union {
            bAddress : UInt8[16]
            uIpAddress : UInt32
        }
    }
}
struct PXE_DHCPV6_NESTED_RELAY_MESSAGE {
    pRelayMessage : PXE_DHCPV6_RELAY_MESSAGE.Ptr
    cbRelayMessage : UInt32
    pInterfaceIdOption : Struct.Ptr
    cbInterfaceIdOption : UInt16
}
struct TRANSPORTPROVIDER_CALLBACK_ID extends Int32 {
    static WDS_TRANSPORTPROVIDER_CREATE_INSTANCE := 0
    static WDS_TRANSPORTPROVIDER_COMPARE_CONTENT := 1
    static WDS_TRANSPORTPROVIDER_OPEN_CONTENT := 2
    static WDS_TRANSPORTPROVIDER_USER_ACCESS_CHECK := 3
    static WDS_TRANSPORTPROVIDER_GET_CONTENT_SIZE := 4
    static WDS_TRANSPORTPROVIDER_READ_CONTENT := 5
    static WDS_TRANSPORTPROVIDER_CLOSE_CONTENT := 6
    static WDS_TRANSPORTPROVIDER_CLOSE_INSTANCE := 7
    static WDS_TRANSPORTPROVIDER_SHUTDOWN := 8
    static WDS_TRANSPORTPROVIDER_DUMP_STATE := 9
    static WDS_TRANSPORTPROVIDER_REFRESH_SETTINGS := 10
    static WDS_TRANSPORTPROVIDER_GET_CONTENT_METADATA := 11
    static WDS_TRANSPORTPROVIDER_MAX_CALLBACKS := 12
}
struct WDS_TRANSPORTPROVIDER_INIT_PARAMS {
    ulLength : UInt32
    ulMcServerVersion : UInt32
    hRegistryKey : HKEY
    hProvider : HANDLE
}
struct WDS_TRANSPORTPROVIDER_SETTINGS {
    ulLength : UInt32
    ulProviderVersion : UInt32
}
struct TRANSPORTCLIENT_CALLBACK_ID extends Int32 {
    static WDS_TRANSPORTCLIENT_SESSION_START := 0
    static WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS := 1
    static WDS_TRANSPORTCLIENT_SESSION_COMPLETE := 2
    static WDS_TRANSPORTCLIENT_RECEIVE_METADATA := 3
    static WDS_TRANSPORTCLIENT_SESSION_STARTEX := 4
    static WDS_TRANSPORTCLIENT_SESSION_NEGOTIATE := 5
    static WDS_TRANSPORTCLIENT_MAX_CALLBACKS := 6
}
struct TRANSPORTCLIENT_SESSION_INFO {
    ulStructureLength : UInt32
    ullFileSize : Int64
    ulBlockSize : UInt32
}
struct PFN_WdsTransportClientSessionStart extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, Int64.Ptr, "Void"]
}
struct PFN_WdsTransportClientSessionStartEx extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, TRANSPORTCLIENT_SESSION_INFO.Ptr, "Void"]
}
struct PFN_WdsTransportClientReceiveMetadata extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, Struct.Ptr, UInt32, "Void"]
}
struct PFN_WdsTransportClientReceiveContents extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, Struct.Ptr, UInt32, Int64.Ptr, "Void"]
}
struct PFN_WdsTransportClientSessionComplete extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32, "Void"]
}
struct PFN_WdsTransportClientSessionNegotiate extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, TRANSPORTCLIENT_SESSION_INFO.Ptr, HANDLE, "Void"]
}
struct WDS_TRANSPORTCLIENT_REQUEST {
    ulLength : UInt32
    ulApiVersion : UInt32
    ulAuthLevel : WDS_TRANSPORTCLIENT_REQUEST_AUTH_LEVEL
    pwszServer : PWSTR
    pwszNamespace : PWSTR
    pwszObjectName : PWSTR
    ulCacheSize : UInt32
    ulProtocol : UInt32
    pvProtocolData : Struct.Ptr
    ulProtocolDataLength : UInt32
}
struct WDS_TRANSPORTCLIENT_CALLBACKS {
    SessionStart : PFN_WdsTransportClientSessionStart
    SessionStartEx : PFN_WdsTransportClientSessionStartEx
    ReceiveContents : PFN_WdsTransportClientReceiveContents
    ReceiveMetadata : PFN_WdsTransportClientReceiveMetadata
    SessionComplete : PFN_WdsTransportClientSessionComplete
    SessionNegotiate : PFN_WdsTransportClientSessionNegotiate
}
struct WDSTRANSPORT_FEATURE_FLAGS extends Int32 {
    static WdsTptFeatureAdminPack := 1
    static WdsTptFeatureTransportServer := 2
    static WdsTptFeatureDeploymentServer := 4
}
struct WDSTRANSPORT_PROTOCOL_FLAGS extends Int32 {
    static WdsTptProtocolUnicast := 1
    static WdsTptProtocolMulticast := 2
}
struct WDSTRANSPORT_NAMESPACE_TYPE extends Int32 {
    static WdsTptNamespaceTypeUnknown := 0
    static WdsTptNamespaceTypeAutoCast := 1
    static WdsTptNamespaceTypeScheduledCastManualStart := 2
    static WdsTptNamespaceTypeScheduledCastAutoStart := 3
}
struct WDSTRANSPORT_DISCONNECT_TYPE extends Int32 {
    static WdsTptDisconnectUnknown := 0
    static WdsTptDisconnectFallback := 1
    static WdsTptDisconnectAbort := 2
}
struct WDSTRANSPORT_SERVICE_NOTIFICATION extends Int32 {
    static WdsTptServiceNotifyUnknown := 0
    static WdsTptServiceNotifyReadSettings := 1
}
struct WDSTRANSPORT_IP_ADDRESS_TYPE extends Int32 {
    static WdsTptIpAddressUnknown := 0
    static WdsTptIpAddressIpv4 := 1
    static WdsTptIpAddressIpv6 := 2
}
struct WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE extends Int32 {
    static WdsTptIpAddressSourceUnknown := 0
    static WdsTptIpAddressSourceDhcp := 1
    static WdsTptIpAddressSourceRange := 2
}
struct WDSTRANSPORT_NETWORK_PROFILE_TYPE extends Int32 {
    static WdsTptNetworkProfileUnknown := 0
    static WdsTptNetworkProfileCustom := 1
    static WdsTptNetworkProfile10Mbps := 2
    static WdsTptNetworkProfile100Mbps := 3
    static WdsTptNetworkProfile1Gbps := 4
}
struct WDSTRANSPORT_DIAGNOSTICS_COMPONENT_FLAGS extends Int32 {
    static WdsTptDiagnosticsComponentPxe := 1
    static WdsTptDiagnosticsComponentTftp := 2
    static WdsTptDiagnosticsComponentImageServer := 4
    static WdsTptDiagnosticsComponentMulticast := 8
}
struct WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE extends Int32 {
    static WdsTptSlowClientHandlingUnknown := 0
    static WdsTptSlowClientHandlingNone := 1
    static WdsTptSlowClientHandlingAutoDisconnect := 2
    static WdsTptSlowClientHandlingMultistream := 3
}
struct WDSTRANSPORT_UDP_PORT_POLICY extends Int32 {
    static WdsTptUdpPortPolicyDynamic := 0
    static WdsTptUdpPortPolicyFixed := 1
}
struct WDSTRANSPORT_TFTP_CAPABILITY extends Int32 {
    static WdsTptTftpCapMaximumBlockSize := 1
    static WdsTptTftpCapVariableWindow := 2
}
struct IWdsTransportCacheable extends IDispatch {
    static IID := "{46AD894B-0BAB-47DC-84B2-7B553F1D8F80}"
    get_Dirty(pbDirty)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbDirty)
    Discard()
      => ComCall(8, this.p)
    Refresh()
      => ComCall(9, this.p)
    Commit()
      => ComCall(10, this.p)
}
struct IWdsTransportCollection extends IDispatch {
    static IID := "{B8BA4B1A-2FF4-43AB-996C-B2B10A91A6EB}"
    get_Count(pulCount)
      => ComCall(7, this.p, UInt32.Ptr, pulCount)
    get_Item(ulIndex, ppVal)
      => ComCall(8, this.p, UInt32, ulIndex, IDispatch.Ptr, ppVal)
    get__NewEnum(ppVal)
      => ComCall(9, this.p, IUnknown.Ptr, ppVal)
}
struct IWdsTransportManager extends IDispatch {
    static IID := "{5B0D35F5-1B13-4AFD-B878-6526DC340B5D}"
    GetWdsTransportServer(bszServerName, ppWdsTransportServer)
      => ComCall(7, this.p, BSTR, bszServerName, IWdsTransportServer.Ptr, ppWdsTransportServer)
}
struct IWdsTransportServer extends IDispatch {
    static IID := "{09CCD093-830D-4344-A30A-73AE8E8FCA90}"
    get_Name(pbszName)
      => ComCall(7, this.p, BSTR.Ptr, pbszName)
    get_SetupManager(ppWdsTransportSetupManager)
      => ComCall(8, this.p, IWdsTransportSetupManager.Ptr, ppWdsTransportSetupManager)
    get_ConfigurationManager(ppWdsTransportConfigurationManager)
      => ComCall(9, this.p, IWdsTransportConfigurationManager.Ptr, ppWdsTransportConfigurationManager)
    get_NamespaceManager(ppWdsTransportNamespaceManager)
      => ComCall(10, this.p, IWdsTransportNamespaceManager.Ptr, ppWdsTransportNamespaceManager)
    DisconnectClient(ulClientId, DisconnectionType)
      => ComCall(11, this.p, UInt32, ulClientId, WDSTRANSPORT_DISCONNECT_TYPE, DisconnectionType)
}
struct IWdsTransportServer2 extends IWdsTransportServer {
    static IID := "{256E999F-6DF4-4538-81B9-857B9AB8FB47}"
    get_TftpManager(ppWdsTransportTftpManager)
      => ComCall(12, this.p, IWdsTransportTftpManager.Ptr, ppWdsTransportTftpManager)
}
struct IWdsTransportSetupManager extends IDispatch {
    static IID := "{F7238425-EFA8-40A4-AEF9-C98D969C0B75}"
    get_Version(pullVersion)
      => ComCall(7, this.p, Int64.Ptr, pullVersion)
    get_InstalledFeatures(pulInstalledFeatures)
      => ComCall(8, this.p, UInt32.Ptr, pulInstalledFeatures)
    get_Protocols(pulProtocols)
      => ComCall(9, this.p, UInt32.Ptr, pulProtocols)
    RegisterContentProvider(bszName, bszDescription, bszFilePath, bszInitializationRoutine)
      => ComCall(10, this.p, BSTR, bszName, BSTR, bszDescription, BSTR, bszFilePath, BSTR, bszInitializationRoutine)
    DeregisterContentProvider(bszName)
      => ComCall(11, this.p, BSTR, bszName)
}
struct IWdsTransportSetupManager2 extends IWdsTransportSetupManager {
    static IID := "{02BE79DA-7E9E-4366-8B6E-2AA9A91BE47F}"
    get_TftpCapabilities(pulTftpCapabilities)
      => ComCall(12, this.p, UInt32.Ptr, pulTftpCapabilities)
    get_ContentProviders(ppProviderCollection)
      => ComCall(13, this.p, IWdsTransportCollection.Ptr, ppProviderCollection)
}
struct IWdsTransportConfigurationManager extends IDispatch {
    static IID := "{84CC4779-42DD-4792-891E-1321D6D74B44}"
    get_ServicePolicy(ppWdsTransportServicePolicy)
      => ComCall(7, this.p, IWdsTransportServicePolicy.Ptr, ppWdsTransportServicePolicy)
    get_DiagnosticsPolicy(ppWdsTransportDiagnosticsPolicy)
      => ComCall(8, this.p, IWdsTransportDiagnosticsPolicy.Ptr, ppWdsTransportDiagnosticsPolicy)
    get_WdsTransportServicesRunning(bRealtimeStatus, pbServicesRunning)
      => ComCall(9, this.p, VARIANT_BOOL, bRealtimeStatus, VARIANT_BOOL.Ptr, pbServicesRunning)
    EnableWdsTransportServices()
      => ComCall(10, this.p)
    DisableWdsTransportServices()
      => ComCall(11, this.p)
    StartWdsTransportServices()
      => ComCall(12, this.p)
    StopWdsTransportServices()
      => ComCall(13, this.p)
    RestartWdsTransportServices()
      => ComCall(14, this.p)
    NotifyWdsTransportServices(ServiceNotification)
      => ComCall(15, this.p, WDSTRANSPORT_SERVICE_NOTIFICATION, ServiceNotification)
}
struct IWdsTransportConfigurationManager2 extends IWdsTransportConfigurationManager {
    static IID := "{D0D85CAF-A153-4F1D-A9DD-96F431C50717}"
    get_MulticastSessionPolicy(ppWdsTransportMulticastSessionPolicy)
      => ComCall(16, this.p, IWdsTransportMulticastSessionPolicy.Ptr, ppWdsTransportMulticastSessionPolicy)
}
struct IWdsTransportNamespaceManager extends IDispatch {
    static IID := "{3E22D9F6-3777-4D98-83E1-F98696717BA3}"
    CreateNamespace(NamespaceType, bszNamespaceName, bszContentProvider, bszConfiguration, ppWdsTransportNamespace)
      => ComCall(7, this.p, WDSTRANSPORT_NAMESPACE_TYPE, NamespaceType, BSTR, bszNamespaceName, BSTR, bszContentProvider, BSTR, bszConfiguration, IWdsTransportNamespace.Ptr, ppWdsTransportNamespace)
    RetrieveNamespace(bszNamespaceName, ppWdsTransportNamespace)
      => ComCall(8, this.p, BSTR, bszNamespaceName, IWdsTransportNamespace.Ptr, ppWdsTransportNamespace)
    RetrieveNamespaces(bszContentProvider, bszNamespaceName, bIncludeTombstones, ppWdsTransportNamespaces)
      => ComCall(9, this.p, BSTR, bszContentProvider, BSTR, bszNamespaceName, VARIANT_BOOL, bIncludeTombstones, IWdsTransportCollection.Ptr, ppWdsTransportNamespaces)
}
struct IWdsTransportTftpManager extends IDispatch {
    static IID := "{1327A7C8-AE8A-4FB3-8150-136227C37E9A}"
    RetrieveTftpClients(ppWdsTransportTftpClients)
      => ComCall(7, this.p, IWdsTransportCollection.Ptr, ppWdsTransportTftpClients)
}
struct IWdsTransportServicePolicy extends IWdsTransportCacheable {
    static IID := "{B9468578-9F2B-48CC-B27A-A60799C2750C}"
    get_IpAddressSource(AddressType, pSourceType)
      => ComCall(11, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE.Ptr, pSourceType)
    put_IpAddressSource(AddressType, SourceType)
      => ComCall(12, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE, SourceType)
    get_StartIpAddress(AddressType, pbszStartIpAddress)
      => ComCall(13, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, BSTR.Ptr, pbszStartIpAddress)
    put_StartIpAddress(AddressType, bszStartIpAddress)
      => ComCall(14, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, BSTR, bszStartIpAddress)
    get_EndIpAddress(AddressType, pbszEndIpAddress)
      => ComCall(15, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, BSTR.Ptr, pbszEndIpAddress)
    put_EndIpAddress(AddressType, bszEndIpAddress)
      => ComCall(16, this.p, WDSTRANSPORT_IP_ADDRESS_TYPE, AddressType, BSTR, bszEndIpAddress)
    get_StartPort(pulStartPort)
      => ComCall(17, this.p, UInt32.Ptr, pulStartPort)
    put_StartPort(ulStartPort)
      => ComCall(18, this.p, UInt32, ulStartPort)
    get_EndPort(pulEndPort)
      => ComCall(19, this.p, UInt32.Ptr, pulEndPort)
    put_EndPort(ulEndPort)
      => ComCall(20, this.p, UInt32, ulEndPort)
    get_NetworkProfile(pProfileType)
      => ComCall(21, this.p, WDSTRANSPORT_NETWORK_PROFILE_TYPE.Ptr, pProfileType)
    put_NetworkProfile(ProfileType)
      => ComCall(22, this.p, WDSTRANSPORT_NETWORK_PROFILE_TYPE, ProfileType)
}
struct IWdsTransportServicePolicy2 extends IWdsTransportServicePolicy {
    static IID := "{65C19E5C-AA7E-4B91-8944-91E0E5572797}"
    get_UdpPortPolicy(pUdpPortPolicy)
      => ComCall(23, this.p, WDSTRANSPORT_UDP_PORT_POLICY.Ptr, pUdpPortPolicy)
    put_UdpPortPolicy(UdpPortPolicy)
      => ComCall(24, this.p, WDSTRANSPORT_UDP_PORT_POLICY, UdpPortPolicy)
    get_TftpMaximumBlockSize(pulTftpMaximumBlockSize)
      => ComCall(25, this.p, UInt32.Ptr, pulTftpMaximumBlockSize)
    put_TftpMaximumBlockSize(ulTftpMaximumBlockSize)
      => ComCall(26, this.p, UInt32, ulTftpMaximumBlockSize)
    get_EnableTftpVariableWindowExtension(pbEnableTftpVariableWindowExtension)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, pbEnableTftpVariableWindowExtension)
    put_EnableTftpVariableWindowExtension(bEnableTftpVariableWindowExtension)
      => ComCall(28, this.p, VARIANT_BOOL, bEnableTftpVariableWindowExtension)
}
struct IWdsTransportDiagnosticsPolicy extends IWdsTransportCacheable {
    static IID := "{13B33EFC-7856-4F61-9A59-8DE67B6B87B6}"
    get_Enabled(pbEnabled)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_Enabled(bEnabled)
      => ComCall(12, this.p, VARIANT_BOOL, bEnabled)
    get_Components(pulComponents)
      => ComCall(13, this.p, UInt32.Ptr, pulComponents)
    put_Components(ulComponents)
      => ComCall(14, this.p, UInt32, ulComponents)
}
struct IWdsTransportMulticastSessionPolicy extends IWdsTransportCacheable {
    static IID := "{4E5753CF-68EC-4504-A951-4A003266606B}"
    get_SlowClientHandling(pSlowClientHandling)
      => ComCall(11, this.p, WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE.Ptr, pSlowClientHandling)
    put_SlowClientHandling(SlowClientHandling)
      => ComCall(12, this.p, WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE, SlowClientHandling)
    get_AutoDisconnectThreshold(pulThreshold)
      => ComCall(13, this.p, UInt32.Ptr, pulThreshold)
    put_AutoDisconnectThreshold(ulThreshold)
      => ComCall(14, this.p, UInt32, ulThreshold)
    get_MultistreamStreamCount(pulStreamCount)
      => ComCall(15, this.p, UInt32.Ptr, pulStreamCount)
    put_MultistreamStreamCount(ulStreamCount)
      => ComCall(16, this.p, UInt32, ulStreamCount)
    get_SlowClientFallback(pbClientFallback)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, pbClientFallback)
    put_SlowClientFallback(bClientFallback)
      => ComCall(18, this.p, VARIANT_BOOL, bClientFallback)
}
struct IWdsTransportNamespace extends IDispatch {
    static IID := "{FA561F57-FBEF-4ED3-B056-127CB1B33B84}"
    get_Type(pType)
      => ComCall(7, this.p, WDSTRANSPORT_NAMESPACE_TYPE.Ptr, pType)
    get_Id(pulId)
      => ComCall(8, this.p, UInt32.Ptr, pulId)
    get_Name(pbszName)
      => ComCall(9, this.p, BSTR.Ptr, pbszName)
    put_Name(bszName)
      => ComCall(10, this.p, BSTR, bszName)
    get_FriendlyName(pbszFriendlyName)
      => ComCall(11, this.p, BSTR.Ptr, pbszFriendlyName)
    put_FriendlyName(bszFriendlyName)
      => ComCall(12, this.p, BSTR, bszFriendlyName)
    get_Description(pbszDescription)
      => ComCall(13, this.p, BSTR.Ptr, pbszDescription)
    put_Description(bszDescription)
      => ComCall(14, this.p, BSTR, bszDescription)
    get_ContentProvider(pbszContentProvider)
      => ComCall(15, this.p, BSTR.Ptr, pbszContentProvider)
    put_ContentProvider(bszContentProvider)
      => ComCall(16, this.p, BSTR, bszContentProvider)
    get_Configuration(pbszConfiguration)
      => ComCall(17, this.p, BSTR.Ptr, pbszConfiguration)
    put_Configuration(bszConfiguration)
      => ComCall(18, this.p, BSTR, bszConfiguration)
    get_Registered(pbRegistered)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pbRegistered)
    get_Tombstoned(pbTombstoned)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, pbTombstoned)
    get_TombstoneTime(pTombstoneTime)
      => ComCall(21, this.p, Float64.Ptr, pTombstoneTime)
    get_TransmissionStarted(pbTransmissionStarted)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, pbTransmissionStarted)
    Register()
      => ComCall(23, this.p)
    Deregister(bTerminateSessions)
      => ComCall(24, this.p, VARIANT_BOOL, bTerminateSessions)
    Clone(ppWdsTransportNamespaceClone)
      => ComCall(25, this.p, IWdsTransportNamespace.Ptr, ppWdsTransportNamespaceClone)
    Refresh()
      => ComCall(26, this.p)
    RetrieveContents(ppWdsTransportContents)
      => ComCall(27, this.p, IWdsTransportCollection.Ptr, ppWdsTransportContents)
}
struct IWdsTransportNamespaceAutoCast extends IWdsTransportNamespace {
    static IID := "{AD931A72-C4BD-4C41-8FBC-59C9C748DF9E}"
}
struct IWdsTransportNamespaceScheduledCast extends IWdsTransportNamespace {
    static IID := "{3840CECF-D76C-416E-A4CC-31C741D2874B}"
    StartTransmission()
      => ComCall(28, this.p)
}
struct IWdsTransportNamespaceScheduledCastManualStart extends IWdsTransportNamespaceScheduledCast {
    static IID := "{013E6E4C-E6A7-4FB5-B7FF-D9F5DA805C31}"
}
struct IWdsTransportNamespaceScheduledCastAutoStart extends IWdsTransportNamespaceScheduledCast {
    static IID := "{D606AF3D-EA9C-4219-961E-7491D618D9B9}"
    get_MinimumClients(pulMinimumClients)
      => ComCall(29, this.p, UInt32.Ptr, pulMinimumClients)
    put_MinimumClients(ulMinimumClients)
      => ComCall(30, this.p, UInt32, ulMinimumClients)
    get_StartTime(pStartTime)
      => ComCall(31, this.p, Float64.Ptr, pStartTime)
    put_StartTime(StartTime)
      => ComCall(32, this.p, Float64, StartTime)
}
struct IWdsTransportContent extends IDispatch {
    static IID := "{D405D711-0296-4AB4-A860-AC7D32E65798}"
    get_Namespace(ppWdsTransportNamespace)
      => ComCall(7, this.p, IWdsTransportNamespace.Ptr, ppWdsTransportNamespace)
    get_Id(pulId)
      => ComCall(8, this.p, UInt32.Ptr, pulId)
    get_Name(pbszName)
      => ComCall(9, this.p, BSTR.Ptr, pbszName)
    RetrieveSessions(ppWdsTransportSessions)
      => ComCall(10, this.p, IWdsTransportCollection.Ptr, ppWdsTransportSessions)
    Terminate()
      => ComCall(11, this.p)
}
struct IWdsTransportSession extends IDispatch {
    static IID := "{F4EFEA88-65B1-4F30-A4B9-2793987796FB}"
    get_Content(ppWdsTransportContent)
      => ComCall(7, this.p, IWdsTransportContent.Ptr, ppWdsTransportContent)
    get_Id(pulId)
      => ComCall(8, this.p, UInt32.Ptr, pulId)
    get_NetworkInterfaceName(pbszNetworkInterfaceName)
      => ComCall(9, this.p, BSTR.Ptr, pbszNetworkInterfaceName)
    get_NetworkInterfaceAddress(pbszNetworkInterfaceAddress)
      => ComCall(10, this.p, BSTR.Ptr, pbszNetworkInterfaceAddress)
    get_TransferRate(pulTransferRate)
      => ComCall(11, this.p, UInt32.Ptr, pulTransferRate)
    get_MasterClientId(pulMasterClientId)
      => ComCall(12, this.p, UInt32.Ptr, pulMasterClientId)
    RetrieveClients(ppWdsTransportClients)
      => ComCall(13, this.p, IWdsTransportCollection.Ptr, ppWdsTransportClients)
    Terminate()
      => ComCall(14, this.p)
}
struct IWdsTransportClient extends IDispatch {
    static IID := "{B5DBC93A-CABE-46CA-837F-3E44E93C6545}"
    get_Session(ppWdsTransportSession)
      => ComCall(7, this.p, IWdsTransportSession.Ptr, ppWdsTransportSession)
    get_Id(pulId)
      => ComCall(8, this.p, UInt32.Ptr, pulId)
    get_Name(pbszName)
      => ComCall(9, this.p, BSTR.Ptr, pbszName)
    get_MacAddress(pbszMacAddress)
      => ComCall(10, this.p, BSTR.Ptr, pbszMacAddress)
    get_IpAddress(pbszIpAddress)
      => ComCall(11, this.p, BSTR.Ptr, pbszIpAddress)
    get_PercentCompletion(pulPercentCompletion)
      => ComCall(12, this.p, UInt32.Ptr, pulPercentCompletion)
    get_JoinDuration(pulJoinDuration)
      => ComCall(13, this.p, UInt32.Ptr, pulJoinDuration)
    get_CpuUtilization(pulCpuUtilization)
      => ComCall(14, this.p, UInt32.Ptr, pulCpuUtilization)
    get_MemoryUtilization(pulMemoryUtilization)
      => ComCall(15, this.p, UInt32.Ptr, pulMemoryUtilization)
    get_NetworkUtilization(pulNetworkUtilization)
      => ComCall(16, this.p, UInt32.Ptr, pulNetworkUtilization)
    get_UserIdentity(pbszUserIdentity)
      => ComCall(17, this.p, BSTR.Ptr, pbszUserIdentity)
    Disconnect(DisconnectionType)
      => ComCall(18, this.p, WDSTRANSPORT_DISCONNECT_TYPE, DisconnectionType)
}
struct IWdsTransportTftpClient extends IDispatch {
    static IID := "{B022D3AE-884D-4D85-B146-53320E76EF62}"
    get_FileName(pbszFileName)
      => ComCall(7, this.p, BSTR.Ptr, pbszFileName)
    get_IpAddress(pbszIpAddress)
      => ComCall(8, this.p, BSTR.Ptr, pbszIpAddress)
    get_Timeout(pulTimeout)
      => ComCall(9, this.p, UInt32.Ptr, pulTimeout)
    get_CurrentFileOffset(pul64CurrentOffset)
      => ComCall(10, this.p, Int64.Ptr, pul64CurrentOffset)
    get_FileSize(pul64FileSize)
      => ComCall(11, this.p, Int64.Ptr, pul64FileSize)
    get_BlockSize(pulBlockSize)
      => ComCall(12, this.p, UInt32.Ptr, pulBlockSize)
    get_WindowSize(pulWindowSize)
      => ComCall(13, this.p, UInt32.Ptr, pulWindowSize)
}
struct IWdsTransportContentProvider extends IDispatch {
    static IID := "{B9489F24-F219-4ACF-AAD7-265C7C08A6AE}"
    get_Name(pbszName)
      => ComCall(7, this.p, BSTR.Ptr, pbszName)
    get_Description(pbszDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbszDescription)
    get_FilePath(pbszFilePath)
      => ComCall(9, this.p, BSTR.Ptr, pbszFilePath)
    get_InitializationRoutine(pbszInitializationRoutine)
      => ComCall(10, this.p, BSTR.Ptr, pbszInitializationRoutine)
}
