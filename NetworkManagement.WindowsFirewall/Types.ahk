#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, PWSTR, VARIANT_BOOL}
#Import "..\Security\Types.ahk" {SID, SID_AND_ATTRIBUTES}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct IUPnPNAT extends IDispatch {
    static IID := "{B171C812-CC76-485A-94D8-B6B3A2794E99}"
    get_StaticPortMappingCollection(ppSPMs)
      => ComCall(7, this.p, IStaticPortMappingCollection.Ptr, ppSPMs)
    get_DynamicPortMappingCollection(ppDPMs)
      => ComCall(8, this.p, IDynamicPortMappingCollection.Ptr, ppDPMs)
    get_NATEventManager(ppNEM)
      => ComCall(9, this.p, INATEventManager.Ptr, ppNEM)
}
struct INATEventManager extends IDispatch {
    static IID := "{624BD588-9060-4109-B0B0-1ADBBCAC32DF}"
    put_ExternalIPAddressCallback(pUnk)
      => ComCall(7, this.p, IUnknown, pUnk)
    put_NumberOfEntriesCallback(pUnk)
      => ComCall(8, this.p, IUnknown, pUnk)
}
struct INATExternalIPAddressCallback extends IUnknown {
    static IID := "{9C416740-A34E-446F-BA06-ABD04C3149AE}"
    NewExternalIPAddress(bstrNewExternalIPAddress)
      => ComCall(3, this.p, BSTR, bstrNewExternalIPAddress)
}
struct INATNumberOfEntriesCallback extends IUnknown {
    static IID := "{C83A0A74-91EE-41B6-B67A-67E0F00BBD78}"
    NewNumberOfEntries(lNewNumberOfEntries)
      => ComCall(3, this.p, Int32, lNewNumberOfEntries)
}
struct IDynamicPortMappingCollection extends IDispatch {
    static IID := "{B60DE00F-156E-4E8D-9EC1-3A2342C10899}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Item(bstrRemoteHost, lExternalPort, bstrProtocol, ppDPM)
      => ComCall(8, this.p, BSTR, bstrRemoteHost, Int32, lExternalPort, BSTR, bstrProtocol, IDynamicPortMapping.Ptr, ppDPM)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    Remove(bstrRemoteHost, lExternalPort, bstrProtocol)
      => ComCall(10, this.p, BSTR, bstrRemoteHost, Int32, lExternalPort, BSTR, bstrProtocol)
    Add(bstrRemoteHost, lExternalPort, bstrProtocol, lInternalPort, bstrInternalClient, bEnabled, bstrDescription, lLeaseDuration, ppDPM)
      => ComCall(11, this.p, BSTR, bstrRemoteHost, Int32, lExternalPort, BSTR, bstrProtocol, Int32, lInternalPort, BSTR, bstrInternalClient, VARIANT_BOOL, bEnabled, BSTR, bstrDescription, Int32, lLeaseDuration, IDynamicPortMapping.Ptr, ppDPM)
}
struct IDynamicPortMapping extends IDispatch {
    static IID := "{4FC80282-23B6-4378-9A27-CD8F17C9400C}"
    get_ExternalIPAddress(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_RemoteHost(pVal)
      => ComCall(8, this.p, BSTR.Ptr, pVal)
    get_ExternalPort(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    get_Protocol(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_InternalPort(pVal)
      => ComCall(11, this.p, Int32.Ptr, pVal)
    get_InternalClient(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
    get_Enabled(pVal)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pVal)
    get_Description(pVal)
      => ComCall(14, this.p, BSTR.Ptr, pVal)
    get_LeaseDuration(pVal)
      => ComCall(15, this.p, Int32.Ptr, pVal)
    RenewLease(lLeaseDurationDesired, pLeaseDurationReturned)
      => ComCall(16, this.p, Int32, lLeaseDurationDesired, Int32.Ptr, pLeaseDurationReturned)
    EditInternalClient(bstrInternalClient)
      => ComCall(17, this.p, BSTR, bstrInternalClient)
    Enable(vb)
      => ComCall(18, this.p, VARIANT_BOOL, vb)
    EditDescription(bstrDescription)
      => ComCall(19, this.p, BSTR, bstrDescription)
    EditInternalPort(lInternalPort)
      => ComCall(20, this.p, Int32, lInternalPort)
}
struct IStaticPortMappingCollection extends IDispatch {
    static IID := "{CD1F3E77-66D6-4664-82C7-36DBB641D0F1}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Item(lExternalPort, bstrProtocol, ppSPM)
      => ComCall(8, this.p, Int32, lExternalPort, BSTR, bstrProtocol, IStaticPortMapping.Ptr, ppSPM)
    get_Count(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    Remove(lExternalPort, bstrProtocol)
      => ComCall(10, this.p, Int32, lExternalPort, BSTR, bstrProtocol)
    Add(lExternalPort, bstrProtocol, lInternalPort, bstrInternalClient, bEnabled, bstrDescription, ppSPM)
      => ComCall(11, this.p, Int32, lExternalPort, BSTR, bstrProtocol, Int32, lInternalPort, BSTR, bstrInternalClient, VARIANT_BOOL, bEnabled, BSTR, bstrDescription, IStaticPortMapping.Ptr, ppSPM)
}
struct IStaticPortMapping extends IDispatch {
    static IID := "{6F10711F-729B-41E5-93B8-F21D0F818DF1}"
    get_ExternalIPAddress(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_ExternalPort(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get_InternalPort(pVal)
      => ComCall(9, this.p, Int32.Ptr, pVal)
    get_Protocol(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_InternalClient(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    get_Enabled(pVal)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pVal)
    get_Description(pVal)
      => ComCall(13, this.p, BSTR.Ptr, pVal)
    EditInternalClient(bstrInternalClient)
      => ComCall(14, this.p, BSTR, bstrInternalClient)
    Enable(vb)
      => ComCall(15, this.p, VARIANT_BOOL, vb)
    EditDescription(bstrDescription)
      => ComCall(16, this.p, BSTR, bstrDescription)
    EditInternalPort(lInternalPort)
      => ComCall(17, this.p, Int32, lInternalPort)
}
struct IEnumNetConnection extends IUnknown {
    static IID := "{C08956A0-1CD3-11D1-B1C5-00805FC1270E}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, INetConnection.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNetConnection.Ptr, ppenum)
}
struct NETCON_CHARACTERISTIC_FLAGS extends Int32 {
    static NCCF_NONE := 0
    static NCCF_ALL_USERS := 1
    static NCCF_ALLOW_DUPLICATION := 2
    static NCCF_ALLOW_REMOVAL := 4
    static NCCF_ALLOW_RENAME := 8
    static NCCF_INCOMING_ONLY := 32
    static NCCF_OUTGOING_ONLY := 64
    static NCCF_BRANDED := 128
    static NCCF_SHARED := 256
    static NCCF_BRIDGED := 512
    static NCCF_FIREWALLED := 1024
    static NCCF_DEFAULT := 2048
    static NCCF_HOMENET_CAPABLE := 4096
    static NCCF_SHARED_PRIVATE := 8192
    static NCCF_QUARANTINED := 16384
    static NCCF_RESERVED := 32768
    static NCCF_HOSTED_NETWORK := 65536
    static NCCF_VIRTUAL_STATION := 131072
    static NCCF_WIFI_DIRECT := 262144
    static NCCF_BLUETOOTH_MASK := 983040
    static NCCF_LAN_MASK := 15728640
}
struct NETCON_STATUS extends Int32 {
    static NCS_DISCONNECTED := 0
    static NCS_CONNECTING := 1
    static NCS_CONNECTED := 2
    static NCS_DISCONNECTING := 3
    static NCS_HARDWARE_NOT_PRESENT := 4
    static NCS_HARDWARE_DISABLED := 5
    static NCS_HARDWARE_MALFUNCTION := 6
    static NCS_MEDIA_DISCONNECTED := 7
    static NCS_AUTHENTICATING := 8
    static NCS_AUTHENTICATION_SUCCEEDED := 9
    static NCS_AUTHENTICATION_FAILED := 10
    static NCS_INVALID_ADDRESS := 11
    static NCS_CREDENTIALS_REQUIRED := 12
    static NCS_ACTION_REQUIRED := 13
    static NCS_ACTION_REQUIRED_RETRY := 14
    static NCS_CONNECT_FAILED := 15
}
struct NETCON_TYPE extends Int32 {
    static NCT_DIRECT_CONNECT := 0
    static NCT_INBOUND := 1
    static NCT_INTERNET := 2
    static NCT_LAN := 3
    static NCT_PHONE := 4
    static NCT_TUNNEL := 5
    static NCT_BRIDGE := 6
}
struct NETCON_MEDIATYPE extends Int32 {
    static NCM_NONE := 0
    static NCM_DIRECT := 1
    static NCM_ISDN := 2
    static NCM_LAN := 3
    static NCM_PHONE := 4
    static NCM_TUNNEL := 5
    static NCM_PPPOE := 6
    static NCM_BRIDGE := 7
    static NCM_SHAREDACCESSHOST_LAN := 8
    static NCM_SHAREDACCESSHOST_RAS := 9
}
struct NETCON_PROPERTIES {
    guidId : GUID
    pszwName : PWSTR
    pszwDeviceName : PWSTR
    Status : NETCON_STATUS
    MediaType : NETCON_MEDIATYPE
    dwCharacter : UInt32
    clsidThisObject : GUID
    clsidUiObject : GUID
}
struct INetConnection extends IUnknown {
    static IID := "{C08956A1-1CD3-11D1-B1C5-00805FC1270E}"
    Connect()
      => ComCall(3, this.p)
    Disconnect()
      => ComCall(4, this.p)
    Delete()
      => ComCall(5, this.p)
    Duplicate(pszwDuplicateName, ppCon)
      => ComCall(6, this.p, "Str", pszwDuplicateName, INetConnection.Ptr, ppCon)
    GetProperties(ppProps)
      => ComCall(7, this.p, NETCON_PROPERTIES.Ptr.Ptr, ppProps)
    GetUiObjectClassId(pclsid)
      => ComCall(8, this.p, GUID.Ptr, pclsid)
    Rename(pszwNewName)
      => ComCall(9, this.p, "Str", pszwNewName)
}
struct NETCONMGR_ENUM_FLAGS extends Int32 {
    static NCME_DEFAULT := 0
    static NCME_HIDDEN := 1
}
struct INetConnectionManager extends IUnknown {
    static IID := "{C08956A2-1CD3-11D1-B1C5-00805FC1270E}"
    EnumConnections(Flags, ppEnum)
      => ComCall(3, this.p, NETCONMGR_ENUM_FLAGS, Flags, IEnumNetConnection.Ptr, ppEnum)
}
struct NETCONUI_CONNECT_FLAGS extends Int32 {
    static NCUC_DEFAULT := 0
    static NCUC_NO_UI := 1
    static NCUC_ENABLE_DISABLE := 2
}
struct INetConnectionConnectUi extends IUnknown {
    static IID := "{C08956A3-1CD3-11D1-B1C5-00805FC1270E}"
    SetConnection(pCon)
      => ComCall(3, this.p, INetConnection, pCon)
    Connect(hwndParent, dwFlags)
      => ComCall(4, this.p, HWND, hwndParent, UInt32, dwFlags)
    Disconnect(hwndParent, dwFlags)
      => ComCall(5, this.p, HWND, hwndParent, UInt32, dwFlags)
}
struct IEnumNetSharingPortMapping extends IUnknown {
    static IID := "{C08956B0-1CD3-11D1-B1C5-00805FC1270E}"
    Next(rgVar, pceltFetched)
      => ComCall(3, this.p, UInt32, rgVar.Length, VARIANT.Ptr, rgVar, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNetSharingPortMapping.Ptr, ppenum)
}
struct INetSharingPortMappingProps extends IDispatch {
    static IID := "{24B7E9B5-E38F-4685-851B-00892CF5F940}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    get_IPProtocol(pucIPProt)
      => ComCall(8, this.p, UInt8.Ptr, pucIPProt)
    get_ExternalPort(pusPort)
      => ComCall(9, this.p, Int32.Ptr, pusPort)
    get_InternalPort(pusPort)
      => ComCall(10, this.p, Int32.Ptr, pusPort)
    get_Options(pdwOptions)
      => ComCall(11, this.p, Int32.Ptr, pdwOptions)
    get_TargetName(pbstrTargetName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrTargetName)
    get_TargetIPAddress(pbstrTargetIPAddress)
      => ComCall(13, this.p, BSTR.Ptr, pbstrTargetIPAddress)
    get_Enabled(pbool)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pbool)
}
struct INetSharingPortMapping extends IDispatch {
    static IID := "{C08956B1-1CD3-11D1-B1C5-00805FC1270E}"
    Disable()
      => ComCall(7, this.p)
    Enable()
      => ComCall(8, this.p)
    get_Properties(ppNSPMP)
      => ComCall(9, this.p, INetSharingPortMappingProps.Ptr, ppNSPMP)
    Delete()
      => ComCall(10, this.p)
}
struct IEnumNetSharingEveryConnection extends IUnknown {
    static IID := "{C08956B8-1CD3-11D1-B1C5-00805FC1270E}"
    Next(rgVar, pceltFetched)
      => ComCall(3, this.p, UInt32, rgVar.Length, VARIANT.Ptr, rgVar, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNetSharingEveryConnection.Ptr, ppenum)
}
struct IEnumNetSharingPublicConnection extends IUnknown {
    static IID := "{C08956B4-1CD3-11D1-B1C5-00805FC1270E}"
    Next(rgVar, pceltFetched)
      => ComCall(3, this.p, UInt32, rgVar.Length, VARIANT.Ptr, rgVar, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNetSharingPublicConnection.Ptr, ppenum)
}
struct IEnumNetSharingPrivateConnection extends IUnknown {
    static IID := "{C08956B5-1CD3-11D1-B1C5-00805FC1270E}"
    Next(rgVar, pCeltFetched)
      => ComCall(3, this.p, UInt32, rgVar.Length, VARIANT.Ptr, rgVar, UInt32.Ptr, pCeltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumNetSharingPrivateConnection.Ptr, ppenum)
}
struct INetSharingPortMappingCollection extends IDispatch {
    static IID := "{02E4A2DE-DA20-4E34-89C8-AC22275A010B}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
}
struct INetConnectionProps extends IDispatch {
    static IID := "{F4277C95-CE5B-463D-8167-5662D9BCAA72}"
    get_Guid(pbstrGuid)
      => ComCall(7, this.p, BSTR.Ptr, pbstrGuid)
    get_Name(pbstrName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrName)
    get_DeviceName(pbstrDeviceName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDeviceName)
    get_Status(pStatus)
      => ComCall(10, this.p, NETCON_STATUS.Ptr, pStatus)
    get_MediaType(pMediaType)
      => ComCall(11, this.p, NETCON_MEDIATYPE.Ptr, pMediaType)
    get_Characteristics(pdwFlags)
      => ComCall(12, this.p, UInt32.Ptr, pdwFlags)
}
struct SHARINGCONNECTIONTYPE extends Int32 {
    static ICSSHARINGTYPE_PUBLIC := 0
    static ICSSHARINGTYPE_PRIVATE := 1
}
struct SHARINGCONNECTION_ENUM_FLAGS extends Int32 {
    static ICSSC_DEFAULT := 0
    static ICSSC_ENABLED := 1
}
struct ICS_TARGETTYPE extends Int32 {
    static ICSTT_NAME := 0
    static ICSTT_IPADDRESS := 1
}
struct INetSharingConfiguration extends IDispatch {
    static IID := "{C08956B6-1CD3-11D1-B1C5-00805FC1270E}"
    get_SharingEnabled(pbEnabled)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    get_SharingConnectionType(pType)
      => ComCall(8, this.p, SHARINGCONNECTIONTYPE.Ptr, pType)
    DisableSharing()
      => ComCall(9, this.p)
    EnableSharing(Type)
      => ComCall(10, this.p, SHARINGCONNECTIONTYPE, Type)
    get_InternetFirewallEnabled(pbEnabled)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    DisableInternetFirewall()
      => ComCall(12, this.p)
    EnableInternetFirewall()
      => ComCall(13, this.p)
    get_EnumPortMappings(Flags, ppColl)
      => ComCall(14, this.p, SHARINGCONNECTION_ENUM_FLAGS, Flags, INetSharingPortMappingCollection.Ptr, ppColl)
    AddPortMapping(bstrName, ucIPProtocol, usExternalPort, usInternalPort, dwOptions, bstrTargetNameOrIPAddress, eTargetType, ppMapping)
      => ComCall(15, this.p, BSTR, bstrName, UInt8, ucIPProtocol, UInt16, usExternalPort, UInt16, usInternalPort, UInt32, dwOptions, BSTR, bstrTargetNameOrIPAddress, ICS_TARGETTYPE, eTargetType, INetSharingPortMapping.Ptr, ppMapping)
    RemovePortMapping(pMapping)
      => ComCall(16, this.p, INetSharingPortMapping, pMapping)
}
struct INetSharingEveryConnectionCollection extends IDispatch {
    static IID := "{33C4643C-7811-46FA-A89A-768597BD7223}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
}
struct INetSharingPublicConnectionCollection extends IDispatch {
    static IID := "{7D7A6355-F372-4971-A149-BFC927BE762A}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
}
struct INetSharingPrivateConnectionCollection extends IDispatch {
    static IID := "{38AE69E0-4409-402A-A2CB-E965C727F840}"
    get__NewEnum(pVal)
      => ComCall(7, this.p, IUnknown.Ptr, pVal)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
}
struct INetSharingManager extends IDispatch {
    static IID := "{C08956B7-1CD3-11D1-B1C5-00805FC1270E}"
    get_SharingInstalled(pbInstalled)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbInstalled)
    get_EnumPublicConnections(Flags, ppColl)
      => ComCall(8, this.p, SHARINGCONNECTION_ENUM_FLAGS, Flags, INetSharingPublicConnectionCollection.Ptr, ppColl)
    get_EnumPrivateConnections(Flags, ppColl)
      => ComCall(9, this.p, SHARINGCONNECTION_ENUM_FLAGS, Flags, INetSharingPrivateConnectionCollection.Ptr, ppColl)
    get_INetSharingConfigurationForINetConnection(pNetConnection, ppNetSharingConfiguration)
      => ComCall(10, this.p, INetConnection, pNetConnection, INetSharingConfiguration.Ptr, ppNetSharingConfiguration)
    get_EnumEveryConnection(ppColl)
      => ComCall(11, this.p, INetSharingEveryConnectionCollection.Ptr, ppColl)
    get_NetConnectionProps(pNetConnection, ppProps)
      => ComCall(12, this.p, INetConnection, pNetConnection, INetConnectionProps.Ptr, ppProps)
}
struct NET_FW_POLICY_TYPE extends Int32 {
    static NET_FW_POLICY_GROUP := 0
    static NET_FW_POLICY_LOCAL := 1
    static NET_FW_POLICY_EFFECTIVE := 2
    static NET_FW_POLICY_TYPE_MAX := 3
}
struct NET_FW_PROFILE_TYPE extends Int32 {
    static NET_FW_PROFILE_DOMAIN := 0
    static NET_FW_PROFILE_STANDARD := 1
    static NET_FW_PROFILE_CURRENT := 2
    static NET_FW_PROFILE_TYPE_MAX := 3
}
struct NET_FW_PROFILE_TYPE2 extends Int32 {
    static NET_FW_PROFILE2_DOMAIN := 1
    static NET_FW_PROFILE2_PRIVATE := 2
    static NET_FW_PROFILE2_PUBLIC := 4
    static NET_FW_PROFILE2_ALL := 2147483647
}
struct NET_FW_IP_VERSION extends Int32 {
    static NET_FW_IP_VERSION_V4 := 0
    static NET_FW_IP_VERSION_V6 := 1
    static NET_FW_IP_VERSION_ANY := 2
    static NET_FW_IP_VERSION_MAX := 3
}
struct NET_FW_SCOPE extends Int32 {
    static NET_FW_SCOPE_ALL := 0
    static NET_FW_SCOPE_LOCAL_SUBNET := 1
    static NET_FW_SCOPE_CUSTOM := 2
    static NET_FW_SCOPE_MAX := 3
}
struct NET_FW_IP_PROTOCOL extends Int32 {
    static NET_FW_IP_PROTOCOL_TCP := 6
    static NET_FW_IP_PROTOCOL_UDP := 17
    static NET_FW_IP_PROTOCOL_ANY := 256
}
struct NET_FW_SERVICE_TYPE extends Int32 {
    static NET_FW_SERVICE_FILE_AND_PRINT := 0
    static NET_FW_SERVICE_UPNP := 1
    static NET_FW_SERVICE_REMOTE_DESKTOP := 2
    static NET_FW_SERVICE_NONE := 3
    static NET_FW_SERVICE_TYPE_MAX := 4
}
struct NET_FW_RULE_DIRECTION extends Int32 {
    static NET_FW_RULE_DIR_IN := 1
    static NET_FW_RULE_DIR_OUT := 2
    static NET_FW_RULE_DIR_MAX := 3
}
struct NET_FW_ACTION extends Int32 {
    static NET_FW_ACTION_BLOCK := 0
    static NET_FW_ACTION_ALLOW := 1
    static NET_FW_ACTION_MAX := 2
}
struct NET_FW_MODIFY_STATE extends Int32 {
    static NET_FW_MODIFY_STATE_OK := 0
    static NET_FW_MODIFY_STATE_GP_OVERRIDE := 1
    static NET_FW_MODIFY_STATE_INBOUND_BLOCKED := 2
}
struct NET_FW_RULE_CATEGORY extends Int32 {
    static NET_FW_RULE_CATEGORY_BOOT := 0
    static NET_FW_RULE_CATEGORY_STEALTH := 1
    static NET_FW_RULE_CATEGORY_FIREWALL := 2
    static NET_FW_RULE_CATEGORY_CONSEC := 3
    static NET_FW_RULE_CATEGORY_MAX := 4
}
struct NET_FW_EDGE_TRAVERSAL_TYPE extends Int32 {
    static NET_FW_EDGE_TRAVERSAL_TYPE_DENY := 0
    static NET_FW_EDGE_TRAVERSAL_TYPE_ALLOW := 1
    static NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_APP := 2
    static NET_FW_EDGE_TRAVERSAL_TYPE_DEFER_TO_USER := 3
}
struct NET_FW_AUTHENTICATE_TYPE extends Int32 {
    static NET_FW_AUTHENTICATE_NONE := 0
    static NET_FW_AUTHENTICATE_NO_ENCAPSULATION := 1
    static NET_FW_AUTHENTICATE_WITH_INTEGRITY := 2
    static NET_FW_AUTHENTICATE_AND_NEGOTIATE_ENCRYPTION := 3
    static NET_FW_AUTHENTICATE_AND_ENCRYPT := 4
}
struct NETISO_FLAG extends Int32 {
    static NETISO_FLAG_FORCE_COMPUTE_BINARIES := 1
    static NETISO_FLAG_MAX := 2
}
struct INET_FIREWALL_AC_CREATION_TYPE extends Int32 {
    static INET_FIREWALL_AC_NONE := 0
    static INET_FIREWALL_AC_PACKAGE_ID_ONLY := 1
    static INET_FIREWALL_AC_BINARY := 2
    static INET_FIREWALL_AC_MAX := 4
}
struct INET_FIREWALL_AC_CHANGE_TYPE extends Int32 {
    static INET_FIREWALL_AC_CHANGE_INVALID := 0
    static INET_FIREWALL_AC_CHANGE_CREATE := 1
    static INET_FIREWALL_AC_CHANGE_DELETE := 2
    static INET_FIREWALL_AC_CHANGE_MAX := 3
}
struct INET_FIREWALL_AC_CAPABILITIES {
    count : UInt32
    capabilities : SID_AND_ATTRIBUTES.Ptr
}
struct INET_FIREWALL_AC_BINARIES {
    count : UInt32
    binaries : PWSTR.Ptr
}
struct INET_FIREWALL_AC_CHANGE {
    changeType : INET_FIREWALL_AC_CHANGE_TYPE
    createType : INET_FIREWALL_AC_CREATION_TYPE
    appContainerSid : SID.Ptr
    userSid : SID.Ptr
    displayName : PWSTR
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            capabilities : INET_FIREWALL_AC_CAPABILITIES
            binaries : INET_FIREWALL_AC_BINARIES
        }
    }
}
struct INET_FIREWALL_APP_CONTAINER {
    appContainerSid : SID.Ptr
    userSid : SID.Ptr
    appContainerName : PWSTR
    displayName : PWSTR
    description : PWSTR
    capabilities : INET_FIREWALL_AC_CAPABILITIES
    binaries : INET_FIREWALL_AC_BINARIES
    workingDirectory : PWSTR
    packageFullName : PWSTR
}
struct PAC_CHANGES_CALLBACK_FN extends FunctionPointer {
    static Types := [Struct.Ptr, INET_FIREWALL_AC_CHANGE.Ptr, "Void"]
}
struct NETISO_ERROR_TYPE extends Int32 {
    static NETISO_ERROR_TYPE_NONE := 0
    static NETISO_ERROR_TYPE_PRIVATE_NETWORK := 1
    static NETISO_ERROR_TYPE_INTERNET_CLIENT := 2
    static NETISO_ERROR_TYPE_INTERNET_CLIENT_SERVER := 3
    static NETISO_ERROR_TYPE_MAX := 4
}
struct PNETISO_EDP_ID_CALLBACK_FN extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, "Void"]
}
struct FW_DYNAMIC_KEYWORD_ORIGIN_TYPE extends Int32 {
    static FW_DYNAMIC_KEYWORD_ORIGIN_INVALID := 0
    static FW_DYNAMIC_KEYWORD_ORIGIN_LOCAL := 1
    static FW_DYNAMIC_KEYWORD_ORIGIN_MDM := 2
}
struct FW_DYNAMIC_KEYWORD_ADDRESS0 {
    id : GUID
    keyword : PWSTR
    flags : UInt32
    addresses : PWSTR
}
struct FW_DYNAMIC_KEYWORD_ADDRESS_DATA0 {
    dynamicKeywordAddress : FW_DYNAMIC_KEYWORD_ADDRESS0
    next : FW_DYNAMIC_KEYWORD_ADDRESS_DATA0.Ptr
    schemaVersion : UInt16
    originType : FW_DYNAMIC_KEYWORD_ORIGIN_TYPE
}
struct FW_DYNAMIC_KEYWORD_ADDRESS_FLAGS extends Int32 {
    static FW_DYNAMIC_KEYWORD_ADDRESS_FLAGS_AUTO_RESOLVE := 1
}
struct FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS extends Int32 {
    static FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_AUTO_RESOLVE := 1
    static FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_NON_AUTO_RESOLVE := 2
    static FW_DYNAMIC_KEYWORD_ADDRESS_ENUM_FLAGS_ALL := 3
}
struct PFN_FWADDDYNAMICKEYWORDADDRESS0 extends FunctionPointer {
    static Types := [FW_DYNAMIC_KEYWORD_ADDRESS0.Ptr, UInt32]
}
struct PFN_FWDELETEDYNAMICKEYWORDADDRESS0 extends FunctionPointer {
    static Types := [GUID, UInt32]
}
struct PFN_FWENUMDYNAMICKEYWORDADDRESSESBYTYPE0 extends FunctionPointer {
    static Types := [UInt32, FW_DYNAMIC_KEYWORD_ADDRESS_DATA0.Ptr.Ptr, UInt32]
}
struct PFN_FWENUMDYNAMICKEYWORDADDRESSBYID0 extends FunctionPointer {
    static Types := [GUID, FW_DYNAMIC_KEYWORD_ADDRESS_DATA0.Ptr.Ptr, UInt32]
}
struct PFN_FWFREEDYNAMICKEYWORDADDRESSDATA0 extends FunctionPointer {
    static Types := [FW_DYNAMIC_KEYWORD_ADDRESS_DATA0.Ptr, UInt32]
}
struct PFN_FWUPDATEDYNAMICKEYWORDADDRESS0 extends FunctionPointer {
    static Types := [GUID, PWSTR, BOOL, UInt32]
}
struct INetFwRemoteAdminSettings extends IDispatch {
    static IID := "{D4BECDDF-6F73-4A83-B832-9C66874CD20E}"
    get_IpVersion(ipVersion)
      => ComCall(7, this.p, NET_FW_IP_VERSION.Ptr, ipVersion)
    put_IpVersion(ipVersion)
      => ComCall(8, this.p, NET_FW_IP_VERSION, ipVersion)
    get_Scope(scope)
      => ComCall(9, this.p, NET_FW_SCOPE.Ptr, scope)
    put_Scope(scope)
      => ComCall(10, this.p, NET_FW_SCOPE, scope)
    get_RemoteAddresses(remoteAddrs)
      => ComCall(11, this.p, BSTR.Ptr, remoteAddrs)
    put_RemoteAddresses(remoteAddrs)
      => ComCall(12, this.p, BSTR, remoteAddrs)
    get_Enabled(enabled)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(14, this.p, VARIANT_BOOL, enabled)
}
struct INetFwIcmpSettings extends IDispatch {
    static IID := "{A6207B2E-7CDD-426A-951E-5E1CBC5AFEAD}"
    get_AllowOutboundDestinationUnreachable(allow)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowOutboundDestinationUnreachable(allow)
      => ComCall(8, this.p, VARIANT_BOOL, allow)
    get_AllowRedirect(allow)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowRedirect(allow)
      => ComCall(10, this.p, VARIANT_BOOL, allow)
    get_AllowInboundEchoRequest(allow)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowInboundEchoRequest(allow)
      => ComCall(12, this.p, VARIANT_BOOL, allow)
    get_AllowOutboundTimeExceeded(allow)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowOutboundTimeExceeded(allow)
      => ComCall(14, this.p, VARIANT_BOOL, allow)
    get_AllowOutboundParameterProblem(allow)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowOutboundParameterProblem(allow)
      => ComCall(16, this.p, VARIANT_BOOL, allow)
    get_AllowOutboundSourceQuench(allow)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowOutboundSourceQuench(allow)
      => ComCall(18, this.p, VARIANT_BOOL, allow)
    get_AllowInboundRouterRequest(allow)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowInboundRouterRequest(allow)
      => ComCall(20, this.p, VARIANT_BOOL, allow)
    get_AllowInboundTimestampRequest(allow)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowInboundTimestampRequest(allow)
      => ComCall(22, this.p, VARIANT_BOOL, allow)
    get_AllowInboundMaskRequest(allow)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowInboundMaskRequest(allow)
      => ComCall(24, this.p, VARIANT_BOOL, allow)
    get_AllowOutboundPacketTooBig(allow)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, allow)
    put_AllowOutboundPacketTooBig(allow)
      => ComCall(26, this.p, VARIANT_BOOL, allow)
}
struct INetFwOpenPort extends IDispatch {
    static IID := "{E0483BA0-47FF-4D9C-A6D6-7741D0B195F7}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_IpVersion(ipVersion)
      => ComCall(9, this.p, NET_FW_IP_VERSION.Ptr, ipVersion)
    put_IpVersion(ipVersion)
      => ComCall(10, this.p, NET_FW_IP_VERSION, ipVersion)
    get_Protocol(ipProtocol)
      => ComCall(11, this.p, NET_FW_IP_PROTOCOL.Ptr, ipProtocol)
    put_Protocol(ipProtocol)
      => ComCall(12, this.p, NET_FW_IP_PROTOCOL, ipProtocol)
    get_Port(portNumber)
      => ComCall(13, this.p, Int32.Ptr, portNumber)
    put_Port(portNumber)
      => ComCall(14, this.p, Int32, portNumber)
    get_Scope(scope)
      => ComCall(15, this.p, NET_FW_SCOPE.Ptr, scope)
    put_Scope(scope)
      => ComCall(16, this.p, NET_FW_SCOPE, scope)
    get_RemoteAddresses(remoteAddrs)
      => ComCall(17, this.p, BSTR.Ptr, remoteAddrs)
    put_RemoteAddresses(remoteAddrs)
      => ComCall(18, this.p, BSTR, remoteAddrs)
    get_Enabled(enabled)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(20, this.p, VARIANT_BOOL, enabled)
    get_BuiltIn(builtIn)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, builtIn)
}
struct INetFwOpenPorts extends IDispatch {
    static IID := "{C0E9D7FA-E07E-430A-B19A-090CE82D92E2}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Add(port)
      => ComCall(8, this.p, INetFwOpenPort, port)
    Remove(portNumber, ipProtocol)
      => ComCall(9, this.p, Int32, portNumber, NET_FW_IP_PROTOCOL, ipProtocol)
    Item(portNumber, ipProtocol, openPort)
      => ComCall(10, this.p, Int32, portNumber, NET_FW_IP_PROTOCOL, ipProtocol, INetFwOpenPort.Ptr, openPort)
    get__NewEnum(newEnum)
      => ComCall(11, this.p, IUnknown.Ptr, newEnum)
}
struct INetFwService extends IDispatch {
    static IID := "{79FD57C8-908E-4A36-9888-D5B3F0A444CF}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_Type(type)
      => ComCall(8, this.p, NET_FW_SERVICE_TYPE.Ptr, type)
    get_Customized(customized)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, customized)
    get_IpVersion(ipVersion)
      => ComCall(10, this.p, NET_FW_IP_VERSION.Ptr, ipVersion)
    put_IpVersion(ipVersion)
      => ComCall(11, this.p, NET_FW_IP_VERSION, ipVersion)
    get_Scope(scope)
      => ComCall(12, this.p, NET_FW_SCOPE.Ptr, scope)
    put_Scope(scope)
      => ComCall(13, this.p, NET_FW_SCOPE, scope)
    get_RemoteAddresses(remoteAddrs)
      => ComCall(14, this.p, BSTR.Ptr, remoteAddrs)
    put_RemoteAddresses(remoteAddrs)
      => ComCall(15, this.p, BSTR, remoteAddrs)
    get_Enabled(enabled)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(17, this.p, VARIANT_BOOL, enabled)
    get_GloballyOpenPorts(openPorts)
      => ComCall(18, this.p, INetFwOpenPorts.Ptr, openPorts)
}
struct INetFwServices extends IDispatch {
    static IID := "{79649BB4-903E-421B-94C9-79848E79F6EE}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Item(svcType, service)
      => ComCall(8, this.p, NET_FW_SERVICE_TYPE, svcType, INetFwService.Ptr, service)
    get__NewEnum(newEnum)
      => ComCall(9, this.p, IUnknown.Ptr, newEnum)
}
struct INetFwAuthorizedApplication extends IDispatch {
    static IID := "{B5E64FFA-C2C5-444E-A301-FB5E00018050}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_ProcessImageFileName(imageFileName)
      => ComCall(9, this.p, BSTR.Ptr, imageFileName)
    put_ProcessImageFileName(imageFileName)
      => ComCall(10, this.p, BSTR, imageFileName)
    get_IpVersion(ipVersion)
      => ComCall(11, this.p, NET_FW_IP_VERSION.Ptr, ipVersion)
    put_IpVersion(ipVersion)
      => ComCall(12, this.p, NET_FW_IP_VERSION, ipVersion)
    get_Scope(scope)
      => ComCall(13, this.p, NET_FW_SCOPE.Ptr, scope)
    put_Scope(scope)
      => ComCall(14, this.p, NET_FW_SCOPE, scope)
    get_RemoteAddresses(remoteAddrs)
      => ComCall(15, this.p, BSTR.Ptr, remoteAddrs)
    put_RemoteAddresses(remoteAddrs)
      => ComCall(16, this.p, BSTR, remoteAddrs)
    get_Enabled(enabled)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(18, this.p, VARIANT_BOOL, enabled)
}
struct INetFwAuthorizedApplications extends IDispatch {
    static IID := "{644EFD52-CCF9-486C-97A2-39F352570B30}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Add(app)
      => ComCall(8, this.p, INetFwAuthorizedApplication, app)
    Remove(imageFileName)
      => ComCall(9, this.p, BSTR, imageFileName)
    Item(imageFileName, app)
      => ComCall(10, this.p, BSTR, imageFileName, INetFwAuthorizedApplication.Ptr, app)
    get__NewEnum(newEnum)
      => ComCall(11, this.p, IUnknown.Ptr, newEnum)
}
struct INetFwRule extends IDispatch {
    static IID := "{AF230D27-BABA-4E42-ACED-F524F22CFCE2}"
    get_Name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_Name(name)
      => ComCall(8, this.p, BSTR, name)
    get_Description(desc)
      => ComCall(9, this.p, BSTR.Ptr, desc)
    put_Description(desc)
      => ComCall(10, this.p, BSTR, desc)
    get_ApplicationName(imageFileName)
      => ComCall(11, this.p, BSTR.Ptr, imageFileName)
    put_ApplicationName(imageFileName)
      => ComCall(12, this.p, BSTR, imageFileName)
    get_ServiceName(serviceName)
      => ComCall(13, this.p, BSTR.Ptr, serviceName)
    put_ServiceName(serviceName)
      => ComCall(14, this.p, BSTR, serviceName)
    get_Protocol(protocol)
      => ComCall(15, this.p, Int32.Ptr, protocol)
    put_Protocol(protocol)
      => ComCall(16, this.p, Int32, protocol)
    get_LocalPorts(portNumbers)
      => ComCall(17, this.p, BSTR.Ptr, portNumbers)
    put_LocalPorts(portNumbers)
      => ComCall(18, this.p, BSTR, portNumbers)
    get_RemotePorts(portNumbers)
      => ComCall(19, this.p, BSTR.Ptr, portNumbers)
    put_RemotePorts(portNumbers)
      => ComCall(20, this.p, BSTR, portNumbers)
    get_LocalAddresses(localAddrs)
      => ComCall(21, this.p, BSTR.Ptr, localAddrs)
    put_LocalAddresses(localAddrs)
      => ComCall(22, this.p, BSTR, localAddrs)
    get_RemoteAddresses(remoteAddrs)
      => ComCall(23, this.p, BSTR.Ptr, remoteAddrs)
    put_RemoteAddresses(remoteAddrs)
      => ComCall(24, this.p, BSTR, remoteAddrs)
    get_IcmpTypesAndCodes(icmpTypesAndCodes)
      => ComCall(25, this.p, BSTR.Ptr, icmpTypesAndCodes)
    put_IcmpTypesAndCodes(icmpTypesAndCodes)
      => ComCall(26, this.p, BSTR, icmpTypesAndCodes)
    get_Direction(dir)
      => ComCall(27, this.p, NET_FW_RULE_DIRECTION.Ptr, dir)
    put_Direction(dir)
      => ComCall(28, this.p, NET_FW_RULE_DIRECTION, dir)
    get_Interfaces(interfaces)
      => ComCall(29, this.p, VARIANT.Ptr, interfaces)
    put_Interfaces(interfaces)
      => ComCall(30, this.p, VARIANT, interfaces)
    get_InterfaceTypes(interfaceTypes)
      => ComCall(31, this.p, BSTR.Ptr, interfaceTypes)
    put_InterfaceTypes(interfaceTypes)
      => ComCall(32, this.p, BSTR, interfaceTypes)
    get_Enabled(enabled)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, enabled)
    put_Enabled(enabled)
      => ComCall(34, this.p, VARIANT_BOOL, enabled)
    get_Grouping(context)
      => ComCall(35, this.p, BSTR.Ptr, context)
    put_Grouping(context)
      => ComCall(36, this.p, BSTR, context)
    get_Profiles(profileTypesBitmask)
      => ComCall(37, this.p, Int32.Ptr, profileTypesBitmask)
    put_Profiles(profileTypesBitmask)
      => ComCall(38, this.p, Int32, profileTypesBitmask)
    get_EdgeTraversal(enabled)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, enabled)
    put_EdgeTraversal(enabled)
      => ComCall(40, this.p, VARIANT_BOOL, enabled)
    get_Action(action)
      => ComCall(41, this.p, NET_FW_ACTION.Ptr, action)
    put_Action(action)
      => ComCall(42, this.p, NET_FW_ACTION, action)
}
struct INetFwRule2 extends INetFwRule {
    static IID := "{9C27C8DA-189B-4DDE-89F7-8B39A316782C}"
    get_EdgeTraversalOptions(lOptions)
      => ComCall(43, this.p, Int32.Ptr, lOptions)
    put_EdgeTraversalOptions(lOptions)
      => ComCall(44, this.p, Int32, lOptions)
}
struct INetFwRule3 extends INetFwRule2 {
    static IID := "{B21563FF-D696-4222-AB46-4E89B73AB34A}"
    get_LocalAppPackageId(wszPackageId)
      => ComCall(45, this.p, BSTR.Ptr, wszPackageId)
    put_LocalAppPackageId(wszPackageId)
      => ComCall(46, this.p, BSTR, wszPackageId)
    get_LocalUserOwner(wszUserOwner)
      => ComCall(47, this.p, BSTR.Ptr, wszUserOwner)
    put_LocalUserOwner(wszUserOwner)
      => ComCall(48, this.p, BSTR, wszUserOwner)
    get_LocalUserAuthorizedList(wszUserAuthList)
      => ComCall(49, this.p, BSTR.Ptr, wszUserAuthList)
    put_LocalUserAuthorizedList(wszUserAuthList)
      => ComCall(50, this.p, BSTR, wszUserAuthList)
    get_RemoteUserAuthorizedList(wszUserAuthList)
      => ComCall(51, this.p, BSTR.Ptr, wszUserAuthList)
    put_RemoteUserAuthorizedList(wszUserAuthList)
      => ComCall(52, this.p, BSTR, wszUserAuthList)
    get_RemoteMachineAuthorizedList(wszUserAuthList)
      => ComCall(53, this.p, BSTR.Ptr, wszUserAuthList)
    put_RemoteMachineAuthorizedList(wszUserAuthList)
      => ComCall(54, this.p, BSTR, wszUserAuthList)
    get_SecureFlags(lOptions)
      => ComCall(55, this.p, Int32.Ptr, lOptions)
    put_SecureFlags(lOptions)
      => ComCall(56, this.p, Int32, lOptions)
}
struct INetFwRules extends IDispatch {
    static IID := "{9C4C6277-5027-441E-AFAE-CA1F542DA009}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Add(rule)
      => ComCall(8, this.p, INetFwRule, rule)
    Remove(name)
      => ComCall(9, this.p, BSTR, name)
    Item(name, rule)
      => ComCall(10, this.p, BSTR, name, INetFwRule.Ptr, rule)
    get__NewEnum(newEnum)
      => ComCall(11, this.p, IUnknown.Ptr, newEnum)
}
struct INetFwServiceRestriction extends IDispatch {
    static IID := "{8267BBE3-F890-491C-B7B6-2DB1EF0E5D2B}"
    RestrictService(serviceName, appName, restrictService, serviceSidRestricted)
      => ComCall(7, this.p, BSTR, serviceName, BSTR, appName, VARIANT_BOOL, restrictService, VARIANT_BOOL, serviceSidRestricted)
    ServiceRestricted(serviceName, appName, serviceRestricted)
      => ComCall(8, this.p, BSTR, serviceName, BSTR, appName, VARIANT_BOOL.Ptr, serviceRestricted)
    get_Rules(rules)
      => ComCall(9, this.p, INetFwRules.Ptr, rules)
}
struct INetFwProfile extends IDispatch {
    static IID := "{174A0DDA-E9F9-449D-993B-21AB667CA456}"
    get_Type(type)
      => ComCall(7, this.p, NET_FW_PROFILE_TYPE.Ptr, type)
    get_FirewallEnabled(enabled)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, enabled)
    put_FirewallEnabled(enabled)
      => ComCall(9, this.p, VARIANT_BOOL, enabled)
    get_ExceptionsNotAllowed(notAllowed)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, notAllowed)
    put_ExceptionsNotAllowed(notAllowed)
      => ComCall(11, this.p, VARIANT_BOOL, notAllowed)
    get_NotificationsDisabled(disabled)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, disabled)
    put_NotificationsDisabled(disabled)
      => ComCall(13, this.p, VARIANT_BOOL, disabled)
    get_UnicastResponsesToMulticastBroadcastDisabled(disabled)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, disabled)
    put_UnicastResponsesToMulticastBroadcastDisabled(disabled)
      => ComCall(15, this.p, VARIANT_BOOL, disabled)
    get_RemoteAdminSettings(remoteAdminSettings)
      => ComCall(16, this.p, INetFwRemoteAdminSettings.Ptr, remoteAdminSettings)
    get_IcmpSettings(icmpSettings)
      => ComCall(17, this.p, INetFwIcmpSettings.Ptr, icmpSettings)
    get_GloballyOpenPorts(openPorts)
      => ComCall(18, this.p, INetFwOpenPorts.Ptr, openPorts)
    get_Services(services)
      => ComCall(19, this.p, INetFwServices.Ptr, services)
    get_AuthorizedApplications(apps)
      => ComCall(20, this.p, INetFwAuthorizedApplications.Ptr, apps)
}
struct INetFwPolicy extends IDispatch {
    static IID := "{D46D2478-9AC9-4008-9DC7-5563CE5536CC}"
    get_CurrentProfile(profile)
      => ComCall(7, this.p, INetFwProfile.Ptr, profile)
    GetProfileByType(profileType, profile)
      => ComCall(8, this.p, NET_FW_PROFILE_TYPE, profileType, INetFwProfile.Ptr, profile)
}
struct INetFwPolicy2 extends IDispatch {
    static IID := "{98325047-C671-4174-8D81-DEFCD3F03186}"
    get_CurrentProfileTypes(profileTypesBitmask)
      => ComCall(7, this.p, Int32.Ptr, profileTypesBitmask)
    get_FirewallEnabled(profileType, enabled)
      => ComCall(8, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL.Ptr, enabled)
    put_FirewallEnabled(profileType, enabled)
      => ComCall(9, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL, enabled)
    get_ExcludedInterfaces(profileType, interfaces)
      => ComCall(10, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT.Ptr, interfaces)
    put_ExcludedInterfaces(profileType, interfaces)
      => ComCall(11, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT, interfaces)
    get_BlockAllInboundTraffic(profileType, Block)
      => ComCall(12, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL.Ptr, Block)
    put_BlockAllInboundTraffic(profileType, Block)
      => ComCall(13, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL, Block)
    get_NotificationsDisabled(profileType, disabled)
      => ComCall(14, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL.Ptr, disabled)
    put_NotificationsDisabled(profileType, disabled)
      => ComCall(15, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL, disabled)
    get_UnicastResponsesToMulticastBroadcastDisabled(profileType, disabled)
      => ComCall(16, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL.Ptr, disabled)
    put_UnicastResponsesToMulticastBroadcastDisabled(profileType, disabled)
      => ComCall(17, this.p, NET_FW_PROFILE_TYPE2, profileType, VARIANT_BOOL, disabled)
    get_Rules(rules)
      => ComCall(18, this.p, INetFwRules.Ptr, rules)
    get_ServiceRestriction(ServiceRestriction)
      => ComCall(19, this.p, INetFwServiceRestriction.Ptr, ServiceRestriction)
    EnableRuleGroup(profileTypesBitmask, group, enable)
      => ComCall(20, this.p, Int32, profileTypesBitmask, BSTR, group, VARIANT_BOOL, enable)
    IsRuleGroupEnabled(profileTypesBitmask, group, enabled)
      => ComCall(21, this.p, Int32, profileTypesBitmask, BSTR, group, VARIANT_BOOL.Ptr, enabled)
    RestoreLocalFirewallDefaults()
      => ComCall(22, this.p)
    get_DefaultInboundAction(profileType, action)
      => ComCall(23, this.p, NET_FW_PROFILE_TYPE2, profileType, NET_FW_ACTION.Ptr, action)
    put_DefaultInboundAction(profileType, action)
      => ComCall(24, this.p, NET_FW_PROFILE_TYPE2, profileType, NET_FW_ACTION, action)
    get_DefaultOutboundAction(profileType, action)
      => ComCall(25, this.p, NET_FW_PROFILE_TYPE2, profileType, NET_FW_ACTION.Ptr, action)
    put_DefaultOutboundAction(profileType, action)
      => ComCall(26, this.p, NET_FW_PROFILE_TYPE2, profileType, NET_FW_ACTION, action)
    get_IsRuleGroupCurrentlyEnabled(group, enabled)
      => ComCall(27, this.p, BSTR, group, VARIANT_BOOL.Ptr, enabled)
    get_LocalPolicyModifyState(modifyState)
      => ComCall(28, this.p, NET_FW_MODIFY_STATE.Ptr, modifyState)
}
struct INetFwMgr extends IDispatch {
    static IID := "{F7898AF5-CAC4-4632-A2EC-DA06E5111AF2}"
    get_LocalPolicy(localPolicy)
      => ComCall(7, this.p, INetFwPolicy.Ptr, localPolicy)
    get_CurrentProfileType(profileType)
      => ComCall(8, this.p, NET_FW_PROFILE_TYPE.Ptr, profileType)
    RestoreDefaults()
      => ComCall(9, this.p)
    IsPortAllowed(imageFileName, ipVersion, portNumber, localAddress, ipProtocol, allowed, restricted)
      => ComCall(10, this.p, BSTR, imageFileName, NET_FW_IP_VERSION, ipVersion, Int32, portNumber, BSTR, localAddress, NET_FW_IP_PROTOCOL, ipProtocol, VARIANT.Ptr, allowed, VARIANT.Ptr, restricted)
    IsIcmpTypeAllowed(ipVersion, localAddress, type, allowed, restricted)
      => ComCall(11, this.p, NET_FW_IP_VERSION, ipVersion, BSTR, localAddress, UInt8, type, VARIANT.Ptr, allowed, VARIANT.Ptr, restricted)
}
struct INetFwProduct extends IDispatch {
    static IID := "{71881699-18F4-458B-B892-3FFCE5E07F75}"
    get_RuleCategories(ruleCategories)
      => ComCall(7, this.p, VARIANT.Ptr, ruleCategories)
    put_RuleCategories(ruleCategories)
      => ComCall(8, this.p, VARIANT, ruleCategories)
    get_DisplayName(displayName)
      => ComCall(9, this.p, BSTR.Ptr, displayName)
    put_DisplayName(displayName)
      => ComCall(10, this.p, BSTR, displayName)
    get_PathToSignedProductExe(path)
      => ComCall(11, this.p, BSTR.Ptr, path)
}
struct INetFwProducts extends IDispatch {
    static IID := "{39EB36E0-2097-40BD-8AF2-63A13B525362}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Register(product, registration)
      => ComCall(8, this.p, INetFwProduct, product, IUnknown.Ptr, registration)
    Item(index, product)
      => ComCall(9, this.p, Int32, index, INetFwProduct.Ptr, product)
    get__NewEnum(newEnum)
      => ComCall(10, this.p, IUnknown.Ptr, newEnum)
}
