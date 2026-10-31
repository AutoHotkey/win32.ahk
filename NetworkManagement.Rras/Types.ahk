#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, FILETIME, HANDLE, HINSTANCE, HWND, LUID, PSTR, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {IN6_ADDR, IN_ADDR}
#Import "..\Security.Cryptography\Types.ahk" {CRYPT_INTEGER_BLOB}

struct MPR_INTERFACE_DIAL_MODE extends UInt32 {
    static MPRDM_DialFirst := 0
    static MPRDM_DialAll := 1
    static MPRDM_DialAsNeeded := 2
}
struct RASENTRY_DIAL_MODE extends UInt32 {
    static RASEDM_DialAll := 1
    static RASEDM_DialAsNeeded := 2
}
struct RAS_FLAGS extends UInt32 {
    static RAS_FLAGS_PPP_CONNECTION := 1
    static RAS_FLAGS_MESSENGER_PRESENT := 2
    static RAS_FLAGS_QUARANTINE_PRESENT := 8
    static RAS_FLAGS_ARAP_CONNECTION := 16
    static RAS_FLAGS_IKEV2_CONNECTION := 16
    static RAS_FLAGS_DORMANT := 32
}
struct MPR_ET extends UInt32 {
    static MPR_ET_None := 0
    static MPR_ET_Require := 1
    static MPR_ET_RequireMax := 2
    static MPR_ET_Optional := 3
}
struct RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA extends UInt32 {
    static RASLCPAD_CHAP_MD5 := 5
    static RASLCPAD_CHAP_MS := 128
    static RASLCPAD_CHAP_MSV2 := 129
}
struct PPP_LCP extends UInt32 {
    static PPP_LCP_PAP := 49187
    static PPP_LCP_CHAP := 49699
    static PPP_LCP_EAP := 49703
    static PPP_LCP_SPAP := 49191
}
struct RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL extends UInt32 {
    static RASLCPAP_PAP := 49187
    static RASLCPAP_SPAP := 49191
    static RASLCPAP_CHAP := 49699
    static RASLCPAP_EAP := 49703
}
struct PPP_LCP_INFO_AUTH_DATA extends UInt32 {
    static PPP_LCP_CHAP_MD5 := 5
    static PPP_LCP_CHAP_MS := 128
    static PPP_LCP_CHAP_MSV2 := 129
}
struct RASIKEV_PROJECTION_INFO_FLAGS extends UInt32 {
    static RASIKEv2_FLAGS_MOBIKESUPPORTED := 1
    static RASIKEv2_FLAGS_BEHIND_NAT := 2
    static RASIKEv2_FLAGS_SERVERBEHIND_NAT := 4
}
struct MPR_VS extends UInt32 {
    static MPR_VS_Default := 0
    static MPR_VS_PptpOnly := 1
    static MPR_VS_PptpFirst := 2
    static MPR_VS_L2tpOnly := 3
    static MPR_VS_L2tpFirst := 4
}
struct SECURITY_MESSAGE_MSG_ID extends UInt32 {
    static SECURITYMSG_SUCCESS := 1
    static SECURITYMSG_FAILURE := 2
    static SECURITYMSG_ERROR := 3
}
struct HRASCONN {
    Value : IntPtr
}
struct RASCONNW {
    dwSize : UInt32
    hrasconn : HRASCONN
    szEntryName : UInt16[257]
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szPhonebook : UInt16[260]
    dwSubEntry : UInt32
    guidEntry : GUID
    dwFlags : UInt32
    luid : LUID
    guidCorrelationId : GUID
}
struct RASCONNA {
    dwSize : UInt32
    hrasconn : HRASCONN
    szEntryName : CHAR[257]
    szDeviceType : CHAR[17]
    szDeviceName : CHAR[129]
    szPhonebook : CHAR[260]
    dwSubEntry : UInt32
    guidEntry : GUID
    dwFlags : UInt32
    luid : LUID
    guidCorrelationId : GUID
}
struct RASDIALPARAMSW {
    dwSize : UInt32
    szEntryName : UInt16[257]
    szPhoneNumber : UInt16[129]
    szCallbackNumber : UInt16[129]
    szUserName : UInt16[257]
    szPassword : UInt16[257]
    szDomain : UInt16[16]
    dwSubEntry : UInt32
    dwCallbackId : IntPtr
    dwIfIndex : UInt32
    szEncPassword : PWSTR
}
struct RASDIALPARAMSA {
    dwSize : UInt32
    szEntryName : CHAR[257]
    szPhoneNumber : CHAR[129]
    szCallbackNumber : CHAR[129]
    szUserName : CHAR[257]
    szPassword : CHAR[257]
    szDomain : CHAR[16]
    dwSubEntry : UInt32
    dwCallbackId : IntPtr
    dwIfIndex : UInt32
    szEncPassword : PSTR
}
struct RASDEVSPECIFICINFO {
    dwSize : UInt32
    pbDevSpecificInfo : UInt8.Ptr
}
struct RASIKEV2_PROJECTION_INFO {
    dwIPv4NegotiationError : UInt32
    ipv4Address : IN_ADDR
    ipv4ServerAddress : IN_ADDR
    dwIPv6NegotiationError : UInt32
    ipv6Address : IN6_ADDR
    ipv6ServerAddress : IN6_ADDR
    dwPrefixLength : UInt32
    dwAuthenticationProtocol : UInt32
    dwEapTypeId : UInt32
    dwFlags : RASIKEV_PROJECTION_INFO_FLAGS
    dwEncryptionMethod : UInt32
    numIPv4ServerAddresses : UInt32
    ipv4ServerAddresses : IN_ADDR.Ptr
    numIPv6ServerAddresses : UInt32
    ipv6ServerAddresses : IN6_ADDR.Ptr
}
struct RASPBDLGW {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
    dwCallbackId : IntPtr
    pCallback : RASPBDLGFUNCW
    dwError : UInt32
    reserved : IntPtr
    reserved2 : IntPtr
}
struct RASPBDLGA {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
    dwCallbackId : IntPtr
    pCallback : RASPBDLGFUNCA
    dwError : UInt32
    reserved : IntPtr
    reserved2 : IntPtr
}
struct RASENTRYDLGW {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
    szEntry : UInt16[257]
    dwError : UInt32
    reserved : IntPtr
    reserved2 : IntPtr
}
struct RASENTRYDLGA {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
    szEntry : CHAR[257]
    dwError : UInt32
    reserved : IntPtr
    reserved2 : IntPtr
}
struct RASAPIVERSION extends Int32 {
    static RASAPIVERSION_500 := 1
    static RASAPIVERSION_501 := 2
    static RASAPIVERSION_600 := 3
    static RASAPIVERSION_601 := 4
}
struct RASIPADDR {
    a : UInt8
    b : UInt8
    c : UInt8
    d : UInt8
}
struct RASTUNNELENDPOINT {
    dwType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ipv4 : IN_ADDR
            ipv6 : IN6_ADDR
        }
    }
}
struct RASCONNSTATE extends Int32 {
    static RASCS_OpenPort := 0
    static RASCS_PortOpened := 1
    static RASCS_ConnectDevice := 2
    static RASCS_DeviceConnected := 3
    static RASCS_AllDevicesConnected := 4
    static RASCS_Authenticate := 5
    static RASCS_AuthNotify := 6
    static RASCS_AuthRetry := 7
    static RASCS_AuthCallback := 8
    static RASCS_AuthChangePassword := 9
    static RASCS_AuthProject := 10
    static RASCS_AuthLinkSpeed := 11
    static RASCS_AuthAck := 12
    static RASCS_ReAuthenticate := 13
    static RASCS_Authenticated := 14
    static RASCS_PrepareForCallback := 15
    static RASCS_WaitForModemReset := 16
    static RASCS_WaitForCallback := 17
    static RASCS_Projected := 18
    static RASCS_StartAuthentication := 19
    static RASCS_CallbackComplete := 20
    static RASCS_LogonNetwork := 21
    static RASCS_SubEntryConnected := 22
    static RASCS_SubEntryDisconnected := 23
    static RASCS_ApplySettings := 24
    static RASCS_Interactive := 4096
    static RASCS_RetryAuthentication := 4097
    static RASCS_CallbackSetByCaller := 4098
    static RASCS_PasswordExpired := 4099
    static RASCS_InvokeEapUI := 4100
    static RASCS_Connected := 8192
    static RASCS_Disconnected := 8193
}
struct RASCONNSUBSTATE extends Int32 {
    static RASCSS_None := 0
    static RASCSS_Dormant := 1
    static RASCSS_Reconnecting := 2
    static RASCSS_Reconnected := 8192
}
struct RASCONNSTATUSW {
    dwSize : UInt32
    rasconnstate : RASCONNSTATE
    dwError : UInt32
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szPhoneNumber : UInt16[129]
    localEndPoint : RASTUNNELENDPOINT
    remoteEndPoint : RASTUNNELENDPOINT
    rasconnsubstate : RASCONNSUBSTATE
}
struct RASCONNSTATUSA {
    dwSize : UInt32
    rasconnstate : RASCONNSTATE
    dwError : UInt32
    szDeviceType : CHAR[17]
    szDeviceName : CHAR[129]
    szPhoneNumber : CHAR[129]
    localEndPoint : RASTUNNELENDPOINT
    remoteEndPoint : RASTUNNELENDPOINT
    rasconnsubstate : RASCONNSUBSTATE
}
struct RASEAPINFO {
    dwSizeofEapInfo : UInt32
    pbEapInfo : UInt8.Ptr
}
struct RASDIALEXTENSIONS {
    dwSize : UInt32
    dwfOptions : UInt32
    hwndParent : HWND
    reserved : IntPtr
    reserved1 : IntPtr
    RasEapInfo : RASEAPINFO
    fSkipPppAuth : BOOL
    RasDevSpecificInfo : RASDEVSPECIFICINFO
}
struct RASENTRYNAMEW {
    dwSize : UInt32
    szEntryName : UInt16[257]
    dwFlags : UInt32
    szPhonebookPath : UInt16[261]
}
struct RASENTRYNAMEA {
    dwSize : UInt32
    szEntryName : CHAR[257]
    dwFlags : UInt32
    szPhonebookPath : CHAR[261]
}
struct RASPROJECTION extends Int32 {
    static RASP_Amb := 65536
    static RASP_PppNbf := 32831
    static RASP_PppIpx := 32811
    static RASP_PppIp := 32801
    static RASP_PppCcp := 33021
    static RASP_PppLcp := 49185
    static RASP_PppIpv6 := 32855
}
struct RASAMBW {
    dwSize : UInt32
    dwError : UInt32
    szNetBiosError : UInt16[17]
    bLana : UInt8
}
struct RASAMBA {
    dwSize : UInt32
    dwError : UInt32
    szNetBiosError : CHAR[17]
    bLana : UInt8
}
struct RASPPPNBFW {
    dwSize : UInt32
    dwError : UInt32
    dwNetBiosError : UInt32
    szNetBiosError : UInt16[17]
    szWorkstationName : UInt16[17]
    bLana : UInt8
}
struct RASPPPNBFA {
    dwSize : UInt32
    dwError : UInt32
    dwNetBiosError : UInt32
    szNetBiosError : CHAR[17]
    szWorkstationName : CHAR[17]
    bLana : UInt8
}
struct RASIPXW {
    dwSize : UInt32
    dwError : UInt32
    szIpxAddress : UInt16[22]
}
struct RASPPPIPXA {
    dwSize : UInt32
    dwError : UInt32
    szIpxAddress : CHAR[22]
}
struct RASPPPIPW {
    dwSize : UInt32
    dwError : UInt32
    szIpAddress : UInt16[16]
    szServerIpAddress : UInt16[16]
    dwOptions : UInt32
    dwServerOptions : UInt32
}
struct RASPPPIPA {
    dwSize : UInt32
    dwError : UInt32
    szIpAddress : CHAR[16]
    szServerIpAddress : CHAR[16]
    dwOptions : UInt32
    dwServerOptions : UInt32
}
struct RASPPPIPV6 {
    dwSize : UInt32
    dwError : UInt32
    bLocalInterfaceIdentifier : UInt8[8]
    bPeerInterfaceIdentifier : UInt8[8]
    bLocalCompressionProtocol : UInt8[2]
    bPeerCompressionProtocol : UInt8[2]
}
struct RASPPPLCPW {
    dwSize : UInt32
    fBundled : BOOL
    dwError : UInt32
    dwAuthenticationProtocol : UInt32
    dwAuthenticationData : UInt32
    dwEapTypeId : UInt32
    dwServerAuthenticationProtocol : UInt32
    dwServerAuthenticationData : UInt32
    dwServerEapTypeId : UInt32
    fMultilink : BOOL
    dwTerminateReason : UInt32
    dwServerTerminateReason : UInt32
    szReplyMessage : UInt16[1024]
    dwOptions : UInt32
    dwServerOptions : UInt32
}
struct RASPPPLCPA {
    dwSize : UInt32
    fBundled : BOOL
    dwError : UInt32
    dwAuthenticationProtocol : UInt32
    dwAuthenticationData : UInt32
    dwEapTypeId : UInt32
    dwServerAuthenticationProtocol : UInt32
    dwServerAuthenticationData : UInt32
    dwServerEapTypeId : UInt32
    fMultilink : BOOL
    dwTerminateReason : UInt32
    dwServerTerminateReason : UInt32
    szReplyMessage : CHAR[1024]
    dwOptions : UInt32
    dwServerOptions : UInt32
}
struct RASPPPCCP {
    dwSize : UInt32
    dwError : UInt32
    dwCompressionAlgorithm : UInt32
    dwOptions : UInt32
    dwServerCompressionAlgorithm : UInt32
    dwServerOptions : UInt32
}
struct RASPPP_PROJECTION_INFO {
    dwIPv4NegotiationError : UInt32
    ipv4Address : IN_ADDR
    ipv4ServerAddress : IN_ADDR
    dwIPv4Options : UInt32
    dwIPv4ServerOptions : UInt32
    dwIPv6NegotiationError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bServerInterfaceIdentifier : UInt8[8]
    fBundled : BOOL
    fMultilink : BOOL
    dwAuthenticationProtocol : RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL
    dwAuthenticationData : RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA
    dwServerAuthenticationProtocol : RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL
    dwServerAuthenticationData : RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA
    dwEapTypeId : UInt32
    dwServerEapTypeId : UInt32
    dwLcpOptions : UInt32
    dwLcpServerOptions : UInt32
    dwCcpError : UInt32
    dwCcpCompressionAlgorithm : UInt32
    dwCcpServerCompressionAlgorithm : UInt32
    dwCcpOptions : UInt32
    dwCcpServerOptions : UInt32
}
struct RASPROJECTION_INFO_TYPE extends Int32 {
    static PROJECTION_INFO_TYPE_PPP := 1
    static PROJECTION_INFO_TYPE_IKEv2 := 2
}
struct IKEV2_ID_PAYLOAD_TYPE extends Int32 {
    static IKEV2_ID_PAYLOAD_TYPE_INVALID := 0
    static IKEV2_ID_PAYLOAD_TYPE_IPV4_ADDR := 1
    static IKEV2_ID_PAYLOAD_TYPE_FQDN := 2
    static IKEV2_ID_PAYLOAD_TYPE_RFC822_ADDR := 3
    static IKEV2_ID_PAYLOAD_TYPE_RESERVED1 := 4
    static IKEV2_ID_PAYLOAD_TYPE_ID_IPV6_ADDR := 5
    static IKEV2_ID_PAYLOAD_TYPE_RESERVED2 := 6
    static IKEV2_ID_PAYLOAD_TYPE_RESERVED3 := 7
    static IKEV2_ID_PAYLOAD_TYPE_RESERVED4 := 8
    static IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_DN := 9
    static IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_GN := 10
    static IKEV2_ID_PAYLOAD_TYPE_KEY_ID := 11
    static IKEV2_ID_PAYLOAD_TYPE_MAX := 12
}
struct RAS_PROJECTION_INFO {
    version : RASAPIVERSION
    type : RASPROJECTION_INFO_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ppp : RASPPP_PROJECTION_INFO
            ikev2 : RASIKEV2_PROJECTION_INFO
        }
    }
}
struct RASDIALFUNC extends FunctionPointer {
    static Types := [UInt32, RASCONNSTATE, UInt32, "Void"]
}
struct RASDIALFUNC1 extends FunctionPointer {
    static Types := [HRASCONN, UInt32, RASCONNSTATE, UInt32, UInt32, "Void"]
}
struct RASDIALFUNC2 extends FunctionPointer {
    static Types := [IntPtr, UInt32, HRASCONN, UInt32, RASCONNSTATE, UInt32, UInt32, UInt32]
}
struct RASDEVINFOW {
    dwSize : UInt32
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
}
struct RASDEVINFOA {
    dwSize : UInt32
    szDeviceType : CHAR[17]
    szDeviceName : CHAR[129]
}
struct RASCTRYINFO {
    dwSize : UInt32
    dwCountryID : UInt32
    dwNextCountryID : UInt32
    dwCountryCode : UInt32
    dwCountryNameOffset : UInt32
}
struct RASENTRYA {
    dwSize : UInt32
    dwfOptions : UInt32
    dwCountryID : UInt32
    dwCountryCode : UInt32
    szAreaCode : CHAR[11]
    szLocalPhoneNumber : CHAR[129]
    dwAlternateOffset : UInt32
    ipaddr : RASIPADDR
    ipaddrDns : RASIPADDR
    ipaddrDnsAlt : RASIPADDR
    ipaddrWins : RASIPADDR
    ipaddrWinsAlt : RASIPADDR
    dwFrameSize : UInt32
    dwfNetProtocols : UInt32
    dwFramingProtocol : UInt32
    szScript : CHAR[260]
    szAutodialDll : CHAR[260]
    szAutodialFunc : CHAR[260]
    szDeviceType : CHAR[17]
    szDeviceName : CHAR[129]
    szX25PadType : CHAR[33]
    szX25Address : CHAR[201]
    szX25Facilities : CHAR[201]
    szX25UserData : CHAR[201]
    dwChannels : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwSubEntries : UInt32
    dwDialMode : RASENTRY_DIAL_MODE
    dwDialExtraPercent : UInt32
    dwDialExtraSampleSeconds : UInt32
    dwHangUpExtraPercent : UInt32
    dwHangUpExtraSampleSeconds : UInt32
    dwIdleDisconnectSeconds : UInt32
    dwType : UInt32
    dwEncryptionType : UInt32
    dwCustomAuthKey : UInt32
    guidId : GUID
    szCustomDialDll : CHAR[260]
    dwVpnStrategy : UInt32
    dwfOptions2 : UInt32
    dwfOptions3 : UInt32
    szDnsSuffix : CHAR[256]
    dwTcpWindowSize : UInt32
    szPrerequisitePbk : CHAR[260]
    szPrerequisiteEntry : CHAR[257]
    dwRedialCount : UInt32
    dwRedialPause : UInt32
    ipv6addrDns : IN6_ADDR
    ipv6addrDnsAlt : IN6_ADDR
    dwIPv4InterfaceMetric : UInt32
    dwIPv6InterfaceMetric : UInt32
    ipv6addr : IN6_ADDR
    dwIPv6PrefixLength : UInt32
    dwNetworkOutageTime : UInt32
    szIDi : CHAR[257]
    szIDr : CHAR[257]
    fIsImsConfig : BOOL
    IdiType : IKEV2_ID_PAYLOAD_TYPE
    IdrType : IKEV2_ID_PAYLOAD_TYPE
    fDisableIKEv2Fragmentation : BOOL
}
struct RASENTRYW {
    dwSize : UInt32
    dwfOptions : UInt32
    dwCountryID : UInt32
    dwCountryCode : UInt32
    szAreaCode : UInt16[11]
    szLocalPhoneNumber : UInt16[129]
    dwAlternateOffset : UInt32
    ipaddr : RASIPADDR
    ipaddrDns : RASIPADDR
    ipaddrDnsAlt : RASIPADDR
    ipaddrWins : RASIPADDR
    ipaddrWinsAlt : RASIPADDR
    dwFrameSize : UInt32
    dwfNetProtocols : UInt32
    dwFramingProtocol : UInt32
    szScript : UInt16[260]
    szAutodialDll : UInt16[260]
    szAutodialFunc : UInt16[260]
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szX25PadType : UInt16[33]
    szX25Address : UInt16[201]
    szX25Facilities : UInt16[201]
    szX25UserData : UInt16[201]
    dwChannels : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwSubEntries : UInt32
    dwDialMode : RASENTRY_DIAL_MODE
    dwDialExtraPercent : UInt32
    dwDialExtraSampleSeconds : UInt32
    dwHangUpExtraPercent : UInt32
    dwHangUpExtraSampleSeconds : UInt32
    dwIdleDisconnectSeconds : UInt32
    dwType : UInt32
    dwEncryptionType : UInt32
    dwCustomAuthKey : UInt32
    guidId : GUID
    szCustomDialDll : UInt16[260]
    dwVpnStrategy : UInt32
    dwfOptions2 : UInt32
    dwfOptions3 : UInt32
    szDnsSuffix : UInt16[256]
    dwTcpWindowSize : UInt32
    szPrerequisitePbk : UInt16[260]
    szPrerequisiteEntry : UInt16[257]
    dwRedialCount : UInt32
    dwRedialPause : UInt32
    ipv6addrDns : IN6_ADDR
    ipv6addrDnsAlt : IN6_ADDR
    dwIPv4InterfaceMetric : UInt32
    dwIPv6InterfaceMetric : UInt32
    ipv6addr : IN6_ADDR
    dwIPv6PrefixLength : UInt32
    dwNetworkOutageTime : UInt32
    szIDi : UInt16[257]
    szIDr : UInt16[257]
    fIsImsConfig : BOOL
    IdiType : IKEV2_ID_PAYLOAD_TYPE
    IdrType : IKEV2_ID_PAYLOAD_TYPE
    fDisableIKEv2Fragmentation : BOOL
}
struct ORASADFUNC extends FunctionPointer {
    static Types := [HWND, PSTR, UInt32, UInt32.Ptr, BOOL]
}
struct RASADPARAMS {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
}
struct RASADFUNCA extends FunctionPointer {
    static Types := [PSTR, PSTR, RASADPARAMS.Ptr, UInt32.Ptr, BOOL]
}
struct RASADFUNCW extends FunctionPointer {
    static Types := [PWSTR, PWSTR, RASADPARAMS.Ptr, UInt32.Ptr, BOOL]
}
struct RASSUBENTRYA {
    dwSize : UInt32
    dwfFlags : UInt32
    szDeviceType : CHAR[17]
    szDeviceName : CHAR[129]
    szLocalPhoneNumber : CHAR[129]
    dwAlternateOffset : UInt32
}
struct RASSUBENTRYW {
    dwSize : UInt32
    dwfFlags : UInt32
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szLocalPhoneNumber : UInt16[129]
    dwAlternateOffset : UInt32
}
struct RASCREDENTIALSA {
    dwSize : UInt32
    dwMask : UInt32
    szUserName : CHAR[257]
    szPassword : CHAR[257]
    szDomain : CHAR[16]
}
struct RASCREDENTIALSW {
    dwSize : UInt32
    dwMask : UInt32
    szUserName : UInt16[257]
    szPassword : UInt16[257]
    szDomain : UInt16[16]
}
struct RASAUTODIALENTRYA {
    dwSize : UInt32
    dwFlags : UInt32
    dwDialingLocation : UInt32
    szEntry : CHAR[257]
}
struct RASAUTODIALENTRYW {
    dwSize : UInt32
    dwFlags : UInt32
    dwDialingLocation : UInt32
    szEntry : UInt16[257]
}
struct RASEAPUSERIDENTITYA {
    szUserName : CHAR[257]
    dwSizeofEapInfo : UInt32
    pbEapInfo : UInt8[1]
}
struct RASEAPUSERIDENTITYW {
    szUserName : UInt16[257]
    dwSizeofEapInfo : UInt32
    pbEapInfo : UInt8[1]
}
struct PFNRASGETBUFFER extends FunctionPointer {
    static Types := [UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFNRASFREEBUFFER extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32]
}
struct PFNRASSENDBUFFER extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32, UInt32]
}
struct PFNRASRECEIVEBUFFER extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32.Ptr, UInt32, HANDLE, UInt32]
}
struct PFNRASRETRIEVEBUFFER extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr, UInt32.Ptr, UInt32]
}
struct RasCustomScriptExecuteFn extends FunctionPointer {
    static Types := [HANDLE, PWSTR, PWSTR, PFNRASGETBUFFER, PFNRASFREEBUFFER, PFNRASSENDBUFFER, PFNRASRECEIVEBUFFER, PFNRASRETRIEVEBUFFER, HWND, RASDIALPARAMSA.Ptr, Struct.Ptr, UInt32]
}
struct RASCOMMSETTINGS {
    dwSize : UInt32
    bParity : UInt8
    bStop : UInt8
    bByteSize : UInt8
    bAlign : UInt8
}
struct PFNRASSETCOMMSETTINGS extends FunctionPointer {
    static Types := [HANDLE, RASCOMMSETTINGS.Ptr, Struct.Ptr, UInt32]
}
struct RASCUSTOMSCRIPTEXTENSIONS {
    dwSize : UInt32
    pfnRasSetCommSettings : PFNRASSETCOMMSETTINGS
}
struct RAS_STATS {
    dwSize : UInt32
    dwBytesXmited : UInt32
    dwBytesRcved : UInt32
    dwFramesXmited : UInt32
    dwFramesRcved : UInt32
    dwCrcErr : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
    dwBps : UInt32
    dwConnectDuration : UInt32
}
struct RasCustomHangUpFn extends FunctionPointer {
    static Types := [HRASCONN, UInt32]
}
struct RasCustomDialFn extends FunctionPointer {
    static Types := [HINSTANCE, RASDIALEXTENSIONS.Ptr, PWSTR, RASDIALPARAMSA.Ptr, UInt32, Struct.Ptr, HRASCONN.Ptr, UInt32, UInt32]
}
struct RasCustomDeleteEntryNotifyFn extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, UInt32]
}
struct RASUPDATECONN {
    version : RASAPIVERSION
    dwSize : UInt32
    dwFlags : UInt32
    dwIfIndex : UInt32
    localEndPoint : RASTUNNELENDPOINT
    remoteEndPoint : RASTUNNELENDPOINT
}
struct RASPBDLGFUNCW extends FunctionPointer {
    static Types := [IntPtr, UInt32, PWSTR, Struct.Ptr, "Void"]
}
struct RASPBDLGFUNCA extends FunctionPointer {
    static Types := [IntPtr, UInt32, PSTR, Struct.Ptr, "Void"]
}
struct RASNOUSERW {
    dwSize : UInt32
    dwFlags : UInt32
    dwTimeoutMs : UInt32
    szUserName : UInt16[257]
    szPassword : UInt16[257]
    szDomain : UInt16[16]
}
struct RASNOUSERA {
    dwSize : UInt32
    dwFlags : UInt32
    dwTimeoutMs : UInt32
    szUserName : CHAR[257]
    szPassword : CHAR[257]
    szDomain : CHAR[16]
}
struct RASDIALDLG {
    dwSize : UInt32
    hwndOwner : HWND
    dwFlags : UInt32
    xDlg : Int32
    yDlg : Int32
    dwSubEntry : UInt32
    dwError : UInt32
    reserved : IntPtr
    reserved2 : IntPtr
}
struct RasCustomDialDlgFn extends FunctionPointer {
    static Types := [HINSTANCE, UInt32, PWSTR, PWSTR, PWSTR, RASDIALDLG.Ptr, Struct.Ptr, BOOL]
}
struct RasCustomEntryDlgFn extends FunctionPointer {
    static Types := [HINSTANCE, PWSTR, PWSTR, RASENTRYDLGA.Ptr, UInt32, BOOL]
}
struct ROUTER_INTERFACE_TYPE extends Int32 {
    static ROUTER_IF_TYPE_CLIENT := 0
    static ROUTER_IF_TYPE_HOME_ROUTER := 1
    static ROUTER_IF_TYPE_FULL_ROUTER := 2
    static ROUTER_IF_TYPE_DEDICATED := 3
    static ROUTER_IF_TYPE_INTERNAL := 4
    static ROUTER_IF_TYPE_LOOPBACK := 5
    static ROUTER_IF_TYPE_TUNNEL1 := 6
    static ROUTER_IF_TYPE_DIALOUT := 7
    static ROUTER_IF_TYPE_MAX := 8
}
struct ROUTER_CONNECTION_STATE extends Int32 {
    static ROUTER_IF_STATE_UNREACHABLE := 0
    static ROUTER_IF_STATE_DISCONNECTED := 1
    static ROUTER_IF_STATE_CONNECTING := 2
    static ROUTER_IF_STATE_CONNECTED := 3
}
struct MPR_INTERFACE_0 {
    wszInterfaceName : UInt16[257]
    hInterface : HANDLE
    fEnabled : BOOL
    dwIfType : ROUTER_INTERFACE_TYPE
    dwConnectionState : ROUTER_CONNECTION_STATE
    fUnReachabilityReasons : UInt32
    dwLastError : UInt32
}
struct MPR_IPINIP_INTERFACE_0 {
    wszFriendlyName : UInt16[257]
    Guid : GUID
}
struct MPR_INTERFACE_1 {
    wszInterfaceName : UInt16[257]
    hInterface : HANDLE
    fEnabled : BOOL
    dwIfType : ROUTER_INTERFACE_TYPE
    dwConnectionState : ROUTER_CONNECTION_STATE
    fUnReachabilityReasons : UInt32
    dwLastError : UInt32
    lpwsDialoutHoursRestriction : PWSTR
}
struct MPR_INTERFACE_2 {
    wszInterfaceName : UInt16[257]
    hInterface : HANDLE
    fEnabled : BOOL
    dwIfType : ROUTER_INTERFACE_TYPE
    dwConnectionState : ROUTER_CONNECTION_STATE
    fUnReachabilityReasons : UInt32
    dwLastError : UInt32
    dwfOptions : UInt32
    szLocalPhoneNumber : UInt16[129]
    szAlternates : PWSTR
    ipaddr : UInt32
    ipaddrDns : UInt32
    ipaddrDnsAlt : UInt32
    ipaddrWins : UInt32
    ipaddrWinsAlt : UInt32
    dwfNetProtocols : UInt32
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szX25PadType : UInt16[33]
    szX25Address : UInt16[201]
    szX25Facilities : UInt16[201]
    szX25UserData : UInt16[201]
    dwChannels : UInt32
    dwSubEntries : UInt32
    dwDialMode : MPR_INTERFACE_DIAL_MODE
    dwDialExtraPercent : UInt32
    dwDialExtraSampleSeconds : UInt32
    dwHangUpExtraPercent : UInt32
    dwHangUpExtraSampleSeconds : UInt32
    dwIdleDisconnectSeconds : UInt32
    dwType : UInt32
    dwEncryptionType : MPR_ET
    dwCustomAuthKey : UInt32
    dwCustomAuthDataSize : UInt32
    lpbCustomAuthData : UInt8.Ptr
    guidId : GUID
    dwVpnStrategy : MPR_VS
}
struct MPR_INTERFACE_3 {
    wszInterfaceName : UInt16[257]
    hInterface : HANDLE
    fEnabled : BOOL
    dwIfType : ROUTER_INTERFACE_TYPE
    dwConnectionState : ROUTER_CONNECTION_STATE
    fUnReachabilityReasons : UInt32
    dwLastError : UInt32
    dwfOptions : UInt32
    szLocalPhoneNumber : UInt16[129]
    szAlternates : PWSTR
    ipaddr : UInt32
    ipaddrDns : UInt32
    ipaddrDnsAlt : UInt32
    ipaddrWins : UInt32
    ipaddrWinsAlt : UInt32
    dwfNetProtocols : UInt32
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szX25PadType : UInt16[33]
    szX25Address : UInt16[201]
    szX25Facilities : UInt16[201]
    szX25UserData : UInt16[201]
    dwChannels : UInt32
    dwSubEntries : UInt32
    dwDialMode : MPR_INTERFACE_DIAL_MODE
    dwDialExtraPercent : UInt32
    dwDialExtraSampleSeconds : UInt32
    dwHangUpExtraPercent : UInt32
    dwHangUpExtraSampleSeconds : UInt32
    dwIdleDisconnectSeconds : UInt32
    dwType : UInt32
    dwEncryptionType : MPR_ET
    dwCustomAuthKey : UInt32
    dwCustomAuthDataSize : UInt32
    lpbCustomAuthData : UInt8.Ptr
    guidId : GUID
    dwVpnStrategy : MPR_VS
    AddressCount : UInt32
    ipv6addrDns : IN6_ADDR
    ipv6addrDnsAlt : IN6_ADDR
    ipv6addr : IN6_ADDR.Ptr
}
struct MPR_DEVICE_0 {
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
}
struct MPR_DEVICE_1 {
    szDeviceType : UInt16[17]
    szDeviceName : UInt16[129]
    szLocalPhoneNumber : UInt16[129]
    szAlternates : PWSTR
}
struct MPR_CREDENTIALSEX_0 {
    dwSize : UInt32
    lpbCredentialsInfo : UInt8.Ptr
}
struct MPR_CREDENTIALSEX_1 {
    dwSize : UInt32
    lpbCredentialsInfo : UInt8.Ptr
}
struct MPR_TRANSPORT_0 {
    dwTransportId : UInt32
    hTransport : HANDLE
    wszTransportName : UInt16[41]
}
struct MPR_IFTRANSPORT_0 {
    dwTransportId : UInt32
    hIfTransport : HANDLE
    wszIfTransportName : UInt16[41]
}
struct MPR_SERVER_0 {
    fLanOnlyMode : BOOL
    dwUpTime : UInt32
    dwTotalPorts : UInt32
    dwPortsInUse : UInt32
}
struct MPR_SERVER_1 {
    dwNumPptpPorts : UInt32
    dwPptpPortFlags : UInt32
    dwNumL2tpPorts : UInt32
    dwL2tpPortFlags : UInt32
}
struct MPR_SERVER_2 {
    dwNumPptpPorts : UInt32
    dwPptpPortFlags : UInt32
    dwNumL2tpPorts : UInt32
    dwL2tpPortFlags : UInt32
    dwNumSstpPorts : UInt32
    dwSstpPortFlags : UInt32
}
struct RAS_PORT_CONDITION extends Int32 {
    static RAS_PORT_NON_OPERATIONAL := 0
    static RAS_PORT_DISCONNECTED := 1
    static RAS_PORT_CALLING_BACK := 2
    static RAS_PORT_LISTENING := 3
    static RAS_PORT_AUTHENTICATING := 4
    static RAS_PORT_AUTHENTICATED := 5
    static RAS_PORT_INITIALIZING := 6
}
struct RAS_HARDWARE_CONDITION extends Int32 {
    static RAS_HARDWARE_OPERATIONAL := 0
    static RAS_HARDWARE_FAILURE := 1
}
struct RAS_PORT_0 {
    hPort : HANDLE
    hConnection : HANDLE
    dwPortCondition : RAS_PORT_CONDITION
    dwTotalNumberOfCalls : UInt32
    dwConnectDuration : UInt32
    wszPortName : UInt16[17]
    wszMediaName : UInt16[17]
    wszDeviceName : UInt16[129]
    wszDeviceType : UInt16[17]
}
struct RAS_PORT_1 {
    hPort : HANDLE
    hConnection : HANDLE
    dwHardwareCondition : RAS_HARDWARE_CONDITION
    dwLineSpeed : UInt32
    dwBytesXmited : UInt32
    dwBytesRcved : UInt32
    dwFramesXmited : UInt32
    dwFramesRcved : UInt32
    dwCrcErr : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
}
struct RAS_PORT_2 {
    hPort : HANDLE
    hConnection : HANDLE
    dwConn_State : UInt32
    wszPortName : UInt16[17]
    wszMediaName : UInt16[17]
    wszDeviceName : UInt16[129]
    wszDeviceType : UInt16[17]
    dwHardwareCondition : RAS_HARDWARE_CONDITION
    dwLineSpeed : UInt32
    dwCrcErr : UInt32
    dwSerialOverRunErrs : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
    dwTotalErrors : UInt32
    ullBytesXmited : Int64
    ullBytesRcved : Int64
    ullFramesXmited : Int64
    ullFramesRcved : Int64
    ullBytesTxUncompressed : Int64
    ullBytesTxCompressed : Int64
    ullBytesRcvUncompressed : Int64
    ullBytesRcvCompressed : Int64
}
struct PPP_NBFCP_INFO {
    dwError : UInt32
    wszWksta : UInt16[17]
}
struct PPP_IPCP_INFO {
    dwError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
}
struct PPP_IPCP_INFO2 {
    dwError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
    dwOptions : UInt32
    dwRemoteOptions : UInt32
}
struct PPP_IPXCP_INFO {
    dwError : UInt32
    wszAddress : UInt16[23]
}
struct PPP_ATCP_INFO {
    dwError : UInt32
    wszAddress : UInt16[33]
}
struct PPP_IPV6_CP_INFO {
    dwVersion : UInt32
    dwSize : UInt32
    dwError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bRemoteInterfaceIdentifier : UInt8[8]
    dwOptions : UInt32
    dwRemoteOptions : UInt32
    bPrefix : UInt8[8]
    dwPrefixLength : UInt32
}
struct PPP_INFO {
    nbf : PPP_NBFCP_INFO
    ip : PPP_IPCP_INFO
    ipx : PPP_IPXCP_INFO
    at : PPP_ATCP_INFO
}
struct PPP_CCP_INFO {
    dwError : UInt32
    dwCompressionAlgorithm : UInt32
    dwOptions : UInt32
    dwRemoteCompressionAlgorithm : UInt32
    dwRemoteOptions : UInt32
}
struct PPP_LCP_INFO {
    dwError : UInt32
    dwAuthenticationProtocol : PPP_LCP
    dwAuthenticationData : PPP_LCP_INFO_AUTH_DATA
    dwRemoteAuthenticationProtocol : UInt32
    dwRemoteAuthenticationData : UInt32
    dwTerminateReason : UInt32
    dwRemoteTerminateReason : UInt32
    dwOptions : UInt32
    dwRemoteOptions : UInt32
    dwEapTypeId : UInt32
    dwRemoteEapTypeId : UInt32
}
struct PPP_INFO_2 {
    nbf : PPP_NBFCP_INFO
    ip : PPP_IPCP_INFO2
    ipx : PPP_IPXCP_INFO
    at : PPP_ATCP_INFO
    ccp : PPP_CCP_INFO
    lcp : PPP_LCP_INFO
}
struct PPP_INFO_3 {
    nbf : PPP_NBFCP_INFO
    ip : PPP_IPCP_INFO2
    ipv6 : PPP_IPV6_CP_INFO
    ccp : PPP_CCP_INFO
    lcp : PPP_LCP_INFO
}
struct RAS_CONNECTION_0 {
    hConnection : HANDLE
    hInterface : HANDLE
    dwConnectDuration : UInt32
    dwInterfaceType : ROUTER_INTERFACE_TYPE
    dwConnectionFlags : RAS_FLAGS
    wszInterfaceName : UInt16[257]
    wszUserName : UInt16[257]
    wszLogonDomain : UInt16[16]
    wszRemoteComputer : UInt16[17]
}
struct RAS_CONNECTION_1 {
    hConnection : HANDLE
    hInterface : HANDLE
    PppInfo : PPP_INFO
    dwBytesXmited : UInt32
    dwBytesRcved : UInt32
    dwFramesXmited : UInt32
    dwFramesRcved : UInt32
    dwCrcErr : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
}
struct RAS_CONNECTION_2 {
    hConnection : HANDLE
    wszUserName : UInt16[257]
    dwInterfaceType : ROUTER_INTERFACE_TYPE
    guid : GUID
    PppInfo2 : PPP_INFO_2
}
struct RAS_QUARANTINE_STATE extends Int32 {
    static RAS_QUAR_STATE_NORMAL := 0
    static RAS_QUAR_STATE_QUARANTINE := 1
    static RAS_QUAR_STATE_PROBATION := 2
    static RAS_QUAR_STATE_NOT_CAPABLE := 3
}
struct RAS_CONNECTION_3 {
    dwVersion : UInt32
    dwSize : UInt32
    hConnection : HANDLE
    wszUserName : UInt16[257]
    dwInterfaceType : ROUTER_INTERFACE_TYPE
    guid : GUID
    PppInfo3 : PPP_INFO_3
    rasQuarState : RAS_QUARANTINE_STATE
    timer : FILETIME
}
struct RAS_USER_0 {
    bfPrivilege : UInt8
    wszPhoneNumber : UInt16[129]
}
struct RAS_USER_1 {
    bfPrivilege : UInt8
    wszPhoneNumber : UInt16[129]
    bfPrivilege2 : UInt8
}
struct MPR_FILTER_0 {
    fEnable : BOOL
}
struct MPRAPI_OBJECT_HEADER {
    revision : UInt8
    type : UInt8
    size : UInt16
}
struct MPRAPI_OBJECT_TYPE extends Int32 {
    static MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT := 1
    static MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT := 2
    static MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT := 3
    static MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT := 4
    static MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT := 5
    static MPRAPI_OBJECT_TYPE_IF_CUSTOM_CONFIG_OBJECT := 6
}
struct PPP_PROJECTION_INFO {
    dwIPv4NegotiationError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
    dwIPv4Options : UInt32
    dwIPv4RemoteOptions : UInt32
    IPv4SubInterfaceIndex : Int64
    dwIPv6NegotiationError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bRemoteInterfaceIdentifier : UInt8[8]
    bPrefix : UInt8[8]
    dwPrefixLength : UInt32
    IPv6SubInterfaceIndex : Int64
    dwLcpError : UInt32
    dwAuthenticationProtocol : PPP_LCP
    dwAuthenticationData : PPP_LCP_INFO_AUTH_DATA
    dwRemoteAuthenticationProtocol : PPP_LCP
    dwRemoteAuthenticationData : PPP_LCP_INFO_AUTH_DATA
    dwLcpTerminateReason : UInt32
    dwLcpRemoteTerminateReason : UInt32
    dwLcpOptions : UInt32
    dwLcpRemoteOptions : UInt32
    dwEapTypeId : UInt32
    dwRemoteEapTypeId : UInt32
    dwCcpError : UInt32
    dwCompressionAlgorithm : UInt32
    dwCcpOptions : UInt32
    dwRemoteCompressionAlgorithm : UInt32
    dwCcpRemoteOptions : UInt32
}
struct PPP_PROJECTION_INFO2 {
    dwIPv4NegotiationError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
    dwIPv4Options : UInt32
    dwIPv4RemoteOptions : UInt32
    IPv4SubInterfaceIndex : Int64
    dwIPv6NegotiationError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bRemoteInterfaceIdentifier : UInt8[8]
    bPrefix : UInt8[8]
    dwPrefixLength : UInt32
    IPv6SubInterfaceIndex : Int64
    dwLcpError : UInt32
    dwAuthenticationProtocol : PPP_LCP
    dwAuthenticationData : PPP_LCP_INFO_AUTH_DATA
    dwRemoteAuthenticationProtocol : PPP_LCP
    dwRemoteAuthenticationData : PPP_LCP_INFO_AUTH_DATA
    dwLcpTerminateReason : UInt32
    dwLcpRemoteTerminateReason : UInt32
    dwLcpOptions : UInt32
    dwLcpRemoteOptions : UInt32
    dwEapTypeId : UInt32
    dwEmbeddedEAPTypeId : UInt32
    dwRemoteEapTypeId : UInt32
    dwCcpError : UInt32
    dwCompressionAlgorithm : UInt32
    dwCcpOptions : UInt32
    dwRemoteCompressionAlgorithm : UInt32
    dwCcpRemoteOptions : UInt32
}
struct IKEV2_PROJECTION_INFO {
    dwIPv4NegotiationError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
    IPv4SubInterfaceIndex : Int64
    dwIPv6NegotiationError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bRemoteInterfaceIdentifier : UInt8[8]
    bPrefix : UInt8[8]
    dwPrefixLength : UInt32
    IPv6SubInterfaceIndex : Int64
    dwOptions : UInt32
    dwAuthenticationProtocol : UInt32
    dwEapTypeId : UInt32
    dwCompressionAlgorithm : UInt32
    dwEncryptionMethod : UInt32
}
struct IKEV2_PROJECTION_INFO2 {
    dwIPv4NegotiationError : UInt32
    wszAddress : UInt16[16]
    wszRemoteAddress : UInt16[16]
    IPv4SubInterfaceIndex : Int64
    dwIPv6NegotiationError : UInt32
    bInterfaceIdentifier : UInt8[8]
    bRemoteInterfaceIdentifier : UInt8[8]
    bPrefix : UInt8[8]
    dwPrefixLength : UInt32
    IPv6SubInterfaceIndex : Int64
    dwOptions : UInt32
    dwAuthenticationProtocol : UInt32
    dwEapTypeId : UInt32
    dwEmbeddedEAPTypeId : UInt32
    dwCompressionAlgorithm : UInt32
    dwEncryptionMethod : UInt32
}
struct PROJECTION_INFO {
    projectionInfoType : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            PppProjectionInfo : PPP_PROJECTION_INFO
            Ikev2ProjectionInfo : IKEV2_PROJECTION_INFO
        }
    }
}
struct PROJECTION_INFO2 {
    projectionInfoType : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            PppProjectionInfo : PPP_PROJECTION_INFO2
            Ikev2ProjectionInfo : IKEV2_PROJECTION_INFO2
        }
    }
}
struct RAS_CONNECTION_EX {
    Header : MPRAPI_OBJECT_HEADER
    dwConnectDuration : UInt32
    dwInterfaceType : ROUTER_INTERFACE_TYPE
    dwConnectionFlags : RAS_FLAGS
    wszInterfaceName : UInt16[257]
    wszUserName : UInt16[257]
    wszLogonDomain : UInt16[16]
    wszRemoteComputer : UInt16[17]
    guid : GUID
    rasQuarState : RAS_QUARANTINE_STATE
    probationTime : FILETIME
    dwBytesXmited : UInt32
    dwBytesRcved : UInt32
    dwFramesXmited : UInt32
    dwFramesRcved : UInt32
    dwCrcErr : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
    dwNumSwitchOvers : UInt32
    wszRemoteEndpointAddress : UInt16[65]
    wszLocalEndpointAddress : UInt16[65]
    ProjectionInfo : PROJECTION_INFO
    hConnection : HANDLE
    hInterface : HANDLE
}
struct RAS_CONNECTION_4 {
    dwConnectDuration : UInt32
    dwInterfaceType : ROUTER_INTERFACE_TYPE
    dwConnectionFlags : RAS_FLAGS
    wszInterfaceName : UInt16[257]
    wszUserName : UInt16[257]
    wszLogonDomain : UInt16[16]
    wszRemoteComputer : UInt16[17]
    guid : GUID
    rasQuarState : RAS_QUARANTINE_STATE
    probationTime : FILETIME
    connectionStartTime : FILETIME
    ullBytesXmited : Int64
    ullBytesRcved : Int64
    dwFramesXmited : UInt32
    dwFramesRcved : UInt32
    dwCrcErr : UInt32
    dwTimeoutErr : UInt32
    dwAlignmentErr : UInt32
    dwHardwareOverrunErr : UInt32
    dwFramingErr : UInt32
    dwBufferOverrunErr : UInt32
    dwCompressionRatioIn : UInt32
    dwCompressionRatioOut : UInt32
    dwNumSwitchOvers : UInt32
    wszRemoteEndpointAddress : UInt16[65]
    wszLocalEndpointAddress : UInt16[65]
    ProjectionInfo : PROJECTION_INFO2
    hConnection : HANDLE
    hInterface : HANDLE
    dwDeviceType : UInt32
}
struct ROUTER_CUSTOM_IKEv2_POLICY0 {
    dwIntegrityMethod : UInt32
    dwEncryptionMethod : UInt32
    dwCipherTransformConstant : UInt32
    dwAuthTransformConstant : UInt32
    dwPfsGroup : UInt32
    dwDhGroup : UInt32
}
struct ROUTER_IKEv2_IF_CUSTOM_CONFIG0 {
    dwSaLifeTime : UInt32
    dwSaDataSize : UInt32
    certificateName : CRYPT_INTEGER_BLOB
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
}
struct MPR_IF_CUSTOMINFOEX0 {
    Header : MPRAPI_OBJECT_HEADER
    dwFlags : UInt32
    customIkev2Config : ROUTER_IKEv2_IF_CUSTOM_CONFIG0
}
struct MPR_CERT_EKU {
    dwSize : UInt32
    IsEKUOID : BOOL
    pwszEKU : PWSTR
}
struct VPN_TS_IP_ADDRESS {
    Type : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            v4 : IN_ADDR
            v6 : IN6_ADDR
        }
    }
}
struct MPR_VPN_TS_TYPE extends Int32 {
    static MPR_VPN_TS_IPv4_ADDR_RANGE := 7
    static MPR_VPN_TS_IPv6_ADDR_RANGE := 8
}
struct MPR_VPN_TRAFFIC_SELECTOR {
    type : MPR_VPN_TS_TYPE
    protocolId : UInt8
    portStart : UInt16
    portEnd : UInt16
    tsPayloadId : UInt16
    addrStart : VPN_TS_IP_ADDRESS
    addrEnd : VPN_TS_IP_ADDRESS
}
struct MPR_VPN_TRAFFIC_SELECTORS {
    numTsi : UInt32
    numTsr : UInt32
    tsI : MPR_VPN_TRAFFIC_SELECTOR.Ptr
    tsR : MPR_VPN_TRAFFIC_SELECTOR.Ptr
}
struct ROUTER_IKEv2_IF_CUSTOM_CONFIG2 {
    dwSaLifeTime : UInt32
    dwSaDataSize : UInt32
    certificateName : CRYPT_INTEGER_BLOB
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
    certificateHash : CRYPT_INTEGER_BLOB
    dwMmSaLifeTime : UInt32
    vpnTrafficSelectors : MPR_VPN_TRAFFIC_SELECTORS
}
struct MPR_IF_CUSTOMINFOEX2 {
    Header : MPRAPI_OBJECT_HEADER
    dwFlags : UInt32
    customIkev2Config : ROUTER_IKEv2_IF_CUSTOM_CONFIG2
}
struct IKEV2_TUNNEL_CONFIG_PARAMS4 {
    dwIdleTimeout : UInt32
    dwNetworkBlackoutTime : UInt32
    dwSaLifeTime : UInt32
    dwSaDataSizeForRenegotiation : UInt32
    dwConfigOptions : UInt32
    dwTotalCertificates : UInt32
    certificateNames : CRYPT_INTEGER_BLOB.Ptr
    machineCertificateName : CRYPT_INTEGER_BLOB
    dwEncryptionType : UInt32
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
    dwTotalEkus : UInt32
    certificateEKUs : MPR_CERT_EKU.Ptr
    machineCertificateHash : CRYPT_INTEGER_BLOB
    dwMmSaLifeTime : UInt32
}
struct ROUTER_IKEv2_IF_CUSTOM_CONFIG1 {
    dwSaLifeTime : UInt32
    dwSaDataSize : UInt32
    certificateName : CRYPT_INTEGER_BLOB
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
    certificateHash : CRYPT_INTEGER_BLOB
}
struct MPR_IF_CUSTOMINFOEX1 {
    Header : MPRAPI_OBJECT_HEADER
    dwFlags : UInt32
    customIkev2Config : ROUTER_IKEv2_IF_CUSTOM_CONFIG1
}
struct IKEV2_TUNNEL_CONFIG_PARAMS3 {
    dwIdleTimeout : UInt32
    dwNetworkBlackoutTime : UInt32
    dwSaLifeTime : UInt32
    dwSaDataSizeForRenegotiation : UInt32
    dwConfigOptions : UInt32
    dwTotalCertificates : UInt32
    certificateNames : CRYPT_INTEGER_BLOB.Ptr
    machineCertificateName : CRYPT_INTEGER_BLOB
    dwEncryptionType : UInt32
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
    dwTotalEkus : UInt32
    certificateEKUs : MPR_CERT_EKU.Ptr
    machineCertificateHash : CRYPT_INTEGER_BLOB
}
struct IKEV2_TUNNEL_CONFIG_PARAMS2 {
    dwIdleTimeout : UInt32
    dwNetworkBlackoutTime : UInt32
    dwSaLifeTime : UInt32
    dwSaDataSizeForRenegotiation : UInt32
    dwConfigOptions : UInt32
    dwTotalCertificates : UInt32
    certificateNames : CRYPT_INTEGER_BLOB.Ptr
    machineCertificateName : CRYPT_INTEGER_BLOB
    dwEncryptionType : UInt32
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
}
struct L2TP_TUNNEL_CONFIG_PARAMS2 {
    dwIdleTimeout : UInt32
    dwEncryptionType : UInt32
    dwSaLifeTime : UInt32
    dwSaDataSizeForRenegotiation : UInt32
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
    dwMmSaLifeTime : UInt32
}
struct L2TP_TUNNEL_CONFIG_PARAMS1 {
    dwIdleTimeout : UInt32
    dwEncryptionType : UInt32
    dwSaLifeTime : UInt32
    dwSaDataSizeForRenegotiation : UInt32
    customPolicy : ROUTER_CUSTOM_IKEv2_POLICY0.Ptr
}
struct IKEV2_CONFIG_PARAMS {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
    dwTunnelConfigParamFlags : UInt32
    TunnelConfigParams : IKEV2_TUNNEL_CONFIG_PARAMS4
}
struct PPTP_CONFIG_PARAMS {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
}
struct L2TP_CONFIG_PARAMS1 {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
    dwTunnelConfigParamFlags : UInt32
    TunnelConfigParams : L2TP_TUNNEL_CONFIG_PARAMS2
}
struct GRE_CONFIG_PARAMS0 {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
}
struct L2TP_CONFIG_PARAMS0 {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
}
struct SSTP_CERT_INFO {
    isDefault : BOOL
    certBlob : CRYPT_INTEGER_BLOB
}
struct SSTP_CONFIG_PARAMS {
    dwNumPorts : UInt32
    dwPortFlags : UInt32
    isUseHttps : BOOL
    certAlgorithm : UInt32
    sstpCertDetails : SSTP_CERT_INFO
}
struct MPRAPI_TUNNEL_CONFIG_PARAMS0 {
    IkeConfigParams : IKEV2_CONFIG_PARAMS
    PptpConfigParams : PPTP_CONFIG_PARAMS
    L2tpConfigParams : L2TP_CONFIG_PARAMS1
    SstpConfigParams : SSTP_CONFIG_PARAMS
}
struct MPRAPI_TUNNEL_CONFIG_PARAMS1 {
    IkeConfigParams : IKEV2_CONFIG_PARAMS
    PptpConfigParams : PPTP_CONFIG_PARAMS
    L2tpConfigParams : L2TP_CONFIG_PARAMS1
    SstpConfigParams : SSTP_CONFIG_PARAMS
    GREConfigParams : GRE_CONFIG_PARAMS0
}
struct MPR_SERVER_EX0 {
    Header : MPRAPI_OBJECT_HEADER
    fLanOnlyMode : UInt32
    dwUpTime : UInt32
    dwTotalPorts : UInt32
    dwPortsInUse : UInt32
    Reserved : UInt32
    ConfigParams : MPRAPI_TUNNEL_CONFIG_PARAMS0
}
struct MPR_SERVER_EX1 {
    Header : MPRAPI_OBJECT_HEADER
    fLanOnlyMode : UInt32
    dwUpTime : UInt32
    dwTotalPorts : UInt32
    dwPortsInUse : UInt32
    Reserved : UInt32
    ConfigParams : MPRAPI_TUNNEL_CONFIG_PARAMS1
}
struct MPR_SERVER_SET_CONFIG_EX0 {
    Header : MPRAPI_OBJECT_HEADER
    setConfigForProtocols : UInt32
    ConfigParams : MPRAPI_TUNNEL_CONFIG_PARAMS0
}
struct MPR_SERVER_SET_CONFIG_EX1 {
    Header : MPRAPI_OBJECT_HEADER
    setConfigForProtocols : UInt32
    ConfigParams : MPRAPI_TUNNEL_CONFIG_PARAMS1
}
struct AUTH_VALIDATION_EX {
    Header : MPRAPI_OBJECT_HEADER
    hRasConnection : HANDLE
    wszUserName : UInt16[257]
    wszLogonDomain : UInt16[16]
    AuthInfoSize : UInt32
    AuthInfo : UInt8[1]
}
struct RAS_UPDATE_CONNECTION {
    Header : MPRAPI_OBJECT_HEADER
    dwIfIndex : UInt32
    wszLocalEndpointAddress : UInt16[65]
    wszRemoteEndpointAddress : UInt16[65]
}
struct PMPRADMINGETIPADDRESSFORUSER extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, BOOL.Ptr, UInt32]
}
struct PMPRADMINRELEASEIPADRESS extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, "Void"]
}
struct PMPRADMINGETIPV6ADDRESSFORUSER extends FunctionPointer {
    static Types := [PWSTR, PWSTR, IN6_ADDR.Ptr, BOOL.Ptr, UInt32]
}
struct PMPRADMINRELEASEIPV6ADDRESSFORUSER extends FunctionPointer {
    static Types := [PWSTR, PWSTR, IN6_ADDR.Ptr, "Void"]
}
struct PMPRADMINACCEPTNEWCONNECTION extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, BOOL]
}
struct PMPRADMINACCEPTNEWCONNECTION2 extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, RAS_CONNECTION_2.Ptr, BOOL]
}
struct PMPRADMINACCEPTNEWCONNECTION3 extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, RAS_CONNECTION_2.Ptr, RAS_CONNECTION_3.Ptr, BOOL]
}
struct PMPRADMINACCEPTNEWLINK extends FunctionPointer {
    static Types := [RAS_PORT_0.Ptr, RAS_PORT_1.Ptr, BOOL]
}
struct PMPRADMINCONNECTIONHANGUPNOTIFICATION extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, "Void"]
}
struct PMPRADMINCONNECTIONHANGUPNOTIFICATION2 extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, RAS_CONNECTION_2.Ptr, "Void"]
}
struct PMPRADMINCONNECTIONHANGUPNOTIFICATION3 extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, RAS_CONNECTION_2.Ptr, RAS_CONNECTION_3.Ptr, "Void"]
}
struct PMPRADMINLINKHANGUPNOTIFICATION extends FunctionPointer {
    static Types := [RAS_PORT_0.Ptr, RAS_PORT_1.Ptr, "Void"]
}
struct PMPRADMINTERMINATEDLL extends FunctionPointer {
    static Types := [UInt32]
}
struct PMPRADMINACCEPTREAUTHENTICATION extends FunctionPointer {
    static Types := [RAS_CONNECTION_0.Ptr, RAS_CONNECTION_1.Ptr, RAS_CONNECTION_2.Ptr, RAS_CONNECTION_3.Ptr, BOOL]
}
struct PMPRADMINACCEPTNEWCONNECTIONEX extends FunctionPointer {
    static Types := [RAS_CONNECTION_EX.Ptr, BOOL]
}
struct PMPRADMINACCEPTREAUTHENTICATIONEX extends FunctionPointer {
    static Types := [RAS_CONNECTION_EX.Ptr, BOOL]
}
struct PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX extends FunctionPointer {
    static Types := [RAS_CONNECTION_EX.Ptr, BOOL]
}
struct PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX extends FunctionPointer {
    static Types := [RAS_CONNECTION_EX.Ptr, "Void"]
}
struct PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX extends FunctionPointer {
    static Types := [AUTH_VALIDATION_EX.Ptr, UInt32]
}
struct MPRAPI_ADMIN_DLL_CALLBACKS {
    revision : UInt8
    lpfnMprAdminGetIpAddressForUser : PMPRADMINGETIPADDRESSFORUSER
    lpfnMprAdminReleaseIpAddress : PMPRADMINRELEASEIPADRESS
    lpfnMprAdminGetIpv6AddressForUser : PMPRADMINGETIPV6ADDRESSFORUSER
    lpfnMprAdminReleaseIpV6AddressForUser : PMPRADMINRELEASEIPV6ADDRESSFORUSER
    lpfnRasAdminAcceptNewLink : PMPRADMINACCEPTNEWLINK
    lpfnRasAdminLinkHangupNotification : PMPRADMINLINKHANGUPNOTIFICATION
    lpfnRasAdminTerminateDll : PMPRADMINTERMINATEDLL
    lpfnRasAdminAcceptNewConnectionEx : PMPRADMINACCEPTNEWCONNECTIONEX
    lpfnRasAdminAcceptEndpointChangeEx : PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX
    lpfnRasAdminAcceptReauthenticationEx : PMPRADMINACCEPTREAUTHENTICATIONEX
    lpfnRasAdminConnectionHangupNotificationEx : PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX
    lpfnRASValidatePreAuthenticatedConnectionEx : PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX
}
struct SECURITY_MESSAGE {
    dwMsgId : SECURITY_MESSAGE_MSG_ID
    hPort : IntPtr
    dwError : UInt32
    UserName : CHAR[257]
    Domain : CHAR[16]
}
struct RAS_SECURITY_INFO {
    LastError : UInt32
    BytesReceived : UInt32
    DeviceName : CHAR[129]
}
struct RASSECURITYPROC extends FunctionPointer {
    static Types := [UInt32]
}
struct MGM_IF_ENTRY {
    dwIfIndex : UInt32
    dwIfNextHopAddr : UInt32
    bIGMP : BOOL
    bIsEnabled : BOOL
}
struct PMGM_RPF_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32, UInt8.Ptr, UInt8.Ptr, UInt32]
}
struct PMGM_CREATION_ALERT_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, MGM_IF_ENTRY.Ptr, UInt32]
}
struct PMGM_PRUNE_ALERT_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, BOOL, UInt32.Ptr, UInt32]
}
struct PMGM_JOIN_ALERT_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, BOOL, UInt32]
}
struct PMGM_WRONG_IF_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32, UInt8.Ptr, UInt32]
}
struct PMGM_LOCAL_JOIN_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32]
}
struct PMGM_LOCAL_LEAVE_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32]
}
struct PMGM_DISABLE_IGMP_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32]
}
struct PMGM_ENABLE_IGMP_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32]
}
struct ROUTING_PROTOCOL_CONFIG {
    dwCallbackFlags : UInt32
    pfnRpfCallback : PMGM_RPF_CALLBACK
    pfnCreationAlertCallback : PMGM_CREATION_ALERT_CALLBACK
    pfnPruneAlertCallback : PMGM_PRUNE_ALERT_CALLBACK
    pfnJoinAlertCallback : PMGM_JOIN_ALERT_CALLBACK
    pfnWrongIfCallback : PMGM_WRONG_IF_CALLBACK
    pfnLocalJoinCallback : PMGM_LOCAL_JOIN_CALLBACK
    pfnLocalLeaveCallback : PMGM_LOCAL_LEAVE_CALLBACK
    pfnDisableIgmpCallback : PMGM_DISABLE_IGMP_CALLBACK
    pfnEnableIgmpCallback : PMGM_ENABLE_IGMP_CALLBACK
}
struct MGM_ENUM_TYPES extends Int32 {
    static ANY_SOURCE := 0
    static ALL_SOURCES := 1
}
struct SOURCE_GROUP_ENTRY {
    dwSourceAddr : UInt32
    dwSourceMask : UInt32
    dwGroupAddr : UInt32
    dwGroupMask : UInt32
}
struct RTM_REGN_PROFILE {
    MaxNextHopsInRoute : UInt32
    MaxHandlesInEnum : UInt32
    ViewsSupported : UInt32
    NumberOfViews : UInt32
}
struct RTM_NET_ADDRESS {
    AddressFamily : UInt16
    NumBits : UInt16
    AddrBits : UInt8[16]
}
struct RTM_PREF_INFO {
    Metric : UInt32
    Preference : UInt32
}
struct RTM_NEXTHOP_LIST {
    NumNextHops : UInt16
    NextHops : IntPtr[1]
}
struct RTM_DEST_INFO {
    DestHandle : IntPtr
    DestAddress : RTM_NET_ADDRESS
    LastChanged : FILETIME
    BelongsToViews : UInt32
    NumberOfViews : UInt32
    ViewInfo : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        ViewId : Int32
        NumRoutes : UInt32
        Route : IntPtr
        Owner : IntPtr
        DestFlags : UInt32
        HoldRoute : IntPtr
    }
}
struct RTM_ROUTE_INFO {
    DestHandle : IntPtr
    RouteOwner : IntPtr
    Neighbour : IntPtr
    State : UInt8
    Flags1 : UInt8
    Flags : UInt16
    PrefInfo : RTM_PREF_INFO
    BelongsToViews : UInt32
    EntitySpecificInfo : Struct.Ptr
    NextHopsList : RTM_NEXTHOP_LIST
}
struct RTM_NEXTHOP_INFO {
    NextHopAddress : RTM_NET_ADDRESS
    NextHopOwner : IntPtr
    InterfaceIndex : UInt32
    State : UInt16
    Flags : UInt16
    EntitySpecificInfo : Struct.Ptr
    RemoteNextHop : IntPtr
}
struct RTM_ENTITY_ID {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            EntityId : Int64
        }
        struct _Anonymous_e__Struct {
            EntityProtocolId : UInt32
            EntityInstanceId : UInt32
        }
    }
}
struct RTM_ENTITY_INFO {
    RtmInstanceId : UInt16
    AddressFamily : UInt16
    EntityId : RTM_ENTITY_ID
}
struct RTM_EVENT_TYPE extends Int32 {
    static RTM_ENTITY_REGISTERED := 0
    static RTM_ENTITY_DEREGISTERED := 1
    static RTM_ROUTE_EXPIRED := 2
    static RTM_CHANGE_NOTIFICATION := 3
}
struct RTM_EVENT_CALLBACK extends FunctionPointer {
    static Types := [IntPtr, RTM_EVENT_TYPE, Struct.Ptr, Struct.Ptr, UInt32]
}
struct RTM_ENTITY_METHOD_INPUT {
    MethodType : UInt32
    InputSize : UInt32
    InputData : UInt8[1]
}
struct RTM_ENTITY_METHOD_OUTPUT {
    MethodType : UInt32
    MethodStatus : UInt32
    OutputSize : UInt32
    OutputData : UInt8[1]
}
struct RTM_ENTITY_EXPORT_METHOD extends FunctionPointer {
    static Types := [IntPtr, IntPtr, RTM_ENTITY_METHOD_INPUT.Ptr, RTM_ENTITY_METHOD_OUTPUT.Ptr, "Void"]
}
struct RTM_ENTITY_EXPORT_METHODS {
    NumMethods : UInt32
    Methods : RTM_ENTITY_EXPORT_METHOD[1]
}
