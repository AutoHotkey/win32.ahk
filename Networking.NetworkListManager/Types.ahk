#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT}

struct NLM_CONNECTION_COST extends Int32 {
    static NLM_CONNECTION_COST_UNKNOWN := 0
    static NLM_CONNECTION_COST_UNRESTRICTED := 1
    static NLM_CONNECTION_COST_FIXED := 2
    static NLM_CONNECTION_COST_VARIABLE := 4
    static NLM_CONNECTION_COST_OVERDATALIMIT := 65536
    static NLM_CONNECTION_COST_CONGESTED := 131072
    static NLM_CONNECTION_COST_ROAMING := 262144
    static NLM_CONNECTION_COST_APPROACHINGDATALIMIT := 524288
}
struct NLM_USAGE_DATA {
    UsageInMegabytes : UInt32
    LastSyncTime : FILETIME
}
struct NLM_DATAPLAN_STATUS {
    InterfaceGuid : GUID
    UsageData : NLM_USAGE_DATA
    DataLimitInMegabytes : UInt32
    InboundBandwidthInKbps : UInt32
    OutboundBandwidthInKbps : UInt32
    NextBillingCycle : FILETIME
    MaxTransferSizeInMegabytes : UInt32
    Reserved : UInt32
}
struct NLM_SOCKADDR {
    data : UInt8[128]
}
struct NLM_NETWORK_CLASS extends Int32 {
    static NLM_NETWORK_IDENTIFYING := 1
    static NLM_NETWORK_IDENTIFIED := 2
    static NLM_NETWORK_UNIDENTIFIED := 3
}
struct NLM_SIMULATED_PROFILE_INFO {
    ProfileName : UInt16[256]
    cost : NLM_CONNECTION_COST
    UsageInMegabytes : UInt32
    DataLimitInMegabytes : UInt32
}
struct NLM_INTERNET_CONNECTIVITY extends Int32 {
    static NLM_INTERNET_CONNECTIVITY_WEBHIJACK := 1
    static NLM_INTERNET_CONNECTIVITY_PROXIED := 2
    static NLM_INTERNET_CONNECTIVITY_CORPORATE := 4
}
struct NLM_CONNECTIVITY extends Int32 {
    static NLM_CONNECTIVITY_DISCONNECTED := 0
    static NLM_CONNECTIVITY_IPV4_NOTRAFFIC := 1
    static NLM_CONNECTIVITY_IPV6_NOTRAFFIC := 2
    static NLM_CONNECTIVITY_IPV4_SUBNET := 16
    static NLM_CONNECTIVITY_IPV4_LOCALNETWORK := 32
    static NLM_CONNECTIVITY_IPV4_INTERNET := 64
    static NLM_CONNECTIVITY_IPV6_SUBNET := 256
    static NLM_CONNECTIVITY_IPV6_LOCALNETWORK := 512
    static NLM_CONNECTIVITY_IPV6_INTERNET := 1024
}
struct NLM_DOMAIN_TYPE extends Int32 {
    static NLM_DOMAIN_TYPE_NON_DOMAIN_NETWORK := 0
    static NLM_DOMAIN_TYPE_DOMAIN_NETWORK := 1
    static NLM_DOMAIN_TYPE_DOMAIN_AUTHENTICATED := 2
}
struct NLM_DOMAIN_AUTHENTICATION_KIND extends Int32 {
    static NLM_DOMAIN_AUTHENTICATION_KIND_NONE := 0
    static NLM_DOMAIN_AUTHENTICATION_KIND_LDAP := 1
    static NLM_DOMAIN_AUTHENTICATION_KIND_TLS := 2
}
struct NLM_ENUM_NETWORK extends Int32 {
    static NLM_ENUM_NETWORK_CONNECTED := 1
    static NLM_ENUM_NETWORK_DISCONNECTED := 2
    static NLM_ENUM_NETWORK_ALL := 3
}
struct INetworkListManager extends IDispatch {
    static IID := "{DCB00000-570F-4A9B-8D69-199FDBA5723B}"
    GetNetworks(Flags, ppEnumNetwork)
      => ComCall(7, this.p, NLM_ENUM_NETWORK, Flags, IEnumNetworks.Ptr, ppEnumNetwork)
    GetNetwork(gdNetworkId, ppNetwork)
      => ComCall(8, this.p, GUID, gdNetworkId, INetwork.Ptr, ppNetwork)
    GetNetworkConnections(ppEnum)
      => ComCall(9, this.p, IEnumNetworkConnections.Ptr, ppEnum)
    GetNetworkConnection(gdNetworkConnectionId, ppNetworkConnection)
      => ComCall(10, this.p, GUID, gdNetworkConnectionId, INetworkConnection.Ptr, ppNetworkConnection)
    get_IsConnectedToInternet(pbIsConnected)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    get_IsConnected(pbIsConnected)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    GetConnectivity(pConnectivity)
      => ComCall(13, this.p, NLM_CONNECTIVITY.Ptr, pConnectivity)
    SetSimulatedProfileInfo(pSimulatedInfo)
      => ComCall(14, this.p, NLM_SIMULATED_PROFILE_INFO.Ptr, pSimulatedInfo)
    ClearSimulatedProfileInfo()
      => ComCall(15, this.p)
}
struct INetworkListManagerEvents extends IUnknown {
    static IID := "{DCB00001-570F-4A9B-8D69-199FDBA5723B}"
    ConnectivityChanged(newConnectivity)
      => ComCall(3, this.p, NLM_CONNECTIVITY, newConnectivity)
}
struct NLM_NETWORK_CATEGORY extends Int32 {
    static NLM_NETWORK_CATEGORY_PUBLIC := 0
    static NLM_NETWORK_CATEGORY_PRIVATE := 1
    static NLM_NETWORK_CATEGORY_DOMAIN_AUTHENTICATED := 2
}
struct INetwork extends IDispatch {
    static IID := "{DCB00002-570F-4A9B-8D69-199FDBA5723B}"
    GetName(pszNetworkName)
      => ComCall(7, this.p, BSTR.Ptr, pszNetworkName)
    SetName(szNetworkNewName)
      => ComCall(8, this.p, BSTR, szNetworkNewName)
    GetDescription(pszDescription)
      => ComCall(9, this.p, BSTR.Ptr, pszDescription)
    SetDescription(szDescription)
      => ComCall(10, this.p, BSTR, szDescription)
    GetNetworkId(pgdGuidNetworkId)
      => ComCall(11, this.p, GUID.Ptr, pgdGuidNetworkId)
    GetDomainType(pNetworkType)
      => ComCall(12, this.p, NLM_DOMAIN_TYPE.Ptr, pNetworkType)
    GetNetworkConnections(ppEnumNetworkConnection)
      => ComCall(13, this.p, IEnumNetworkConnections.Ptr, ppEnumNetworkConnection)
    GetTimeCreatedAndConnected(pdwLowDateTimeCreated, pdwHighDateTimeCreated, pdwLowDateTimeConnected, pdwHighDateTimeConnected)
      => ComCall(14, this.p, UInt32.Ptr, pdwLowDateTimeCreated, UInt32.Ptr, pdwHighDateTimeCreated, UInt32.Ptr, pdwLowDateTimeConnected, UInt32.Ptr, pdwHighDateTimeConnected)
    get_IsConnectedToInternet(pbIsConnected)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    get_IsConnected(pbIsConnected)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    GetConnectivity(pConnectivity)
      => ComCall(17, this.p, NLM_CONNECTIVITY.Ptr, pConnectivity)
    GetCategory(pCategory)
      => ComCall(18, this.p, NLM_NETWORK_CATEGORY.Ptr, pCategory)
    SetCategory(NewCategory)
      => ComCall(19, this.p, NLM_NETWORK_CATEGORY, NewCategory)
}
struct INetwork2 extends INetwork {
    static IID := "{B5550ABB-3391-4310-804F-25DCC325ED81}"
    IsDomainAuthenticatedBy(domainAuthenticationKind, pValue)
      => ComCall(20, this.p, NLM_DOMAIN_AUTHENTICATION_KIND, domainAuthenticationKind, BOOL.Ptr, pValue)
}
struct IEnumNetworks extends IDispatch {
    static IID := "{DCB00003-570F-4A9B-8D69-199FDBA5723B}"
    get__NewEnum(ppEnumVar)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, ppEnumVar)
    Next(rgelt, pceltFetched?)
      => ComCall(8, this.p, UInt32, rgelt.Length, INetwork.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(9, this.p, UInt32, celt)
    Reset()
      => ComCall(10, this.p)
    Clone(ppEnumNetwork)
      => ComCall(11, this.p, IEnumNetworks.Ptr, ppEnumNetwork)
}
struct NLM_NETWORK_PROPERTY_CHANGE extends Int32 {
    static NLM_NETWORK_PROPERTY_CHANGE_CONNECTION := 1
    static NLM_NETWORK_PROPERTY_CHANGE_DESCRIPTION := 2
    static NLM_NETWORK_PROPERTY_CHANGE_NAME := 4
    static NLM_NETWORK_PROPERTY_CHANGE_ICON := 8
    static NLM_NETWORK_PROPERTY_CHANGE_CATEGORY_VALUE := 16
}
struct INetworkEvents extends IUnknown {
    static IID := "{DCB00004-570F-4A9B-8D69-199FDBA5723B}"
    NetworkAdded(networkId)
      => ComCall(3, this.p, GUID, networkId)
    NetworkDeleted(networkId)
      => ComCall(4, this.p, GUID, networkId)
    NetworkConnectivityChanged(networkId, newConnectivity)
      => ComCall(5, this.p, GUID, networkId, NLM_CONNECTIVITY, newConnectivity)
    NetworkPropertyChanged(networkId, flags)
      => ComCall(6, this.p, GUID, networkId, NLM_NETWORK_PROPERTY_CHANGE, flags)
}
struct INetworkConnection extends IDispatch {
    static IID := "{DCB00005-570F-4A9B-8D69-199FDBA5723B}"
    GetNetwork(ppNetwork)
      => ComCall(7, this.p, INetwork.Ptr, ppNetwork)
    get_IsConnectedToInternet(pbIsConnected)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    get_IsConnected(pbIsConnected)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pbIsConnected)
    GetConnectivity(pConnectivity)
      => ComCall(10, this.p, NLM_CONNECTIVITY.Ptr, pConnectivity)
    GetConnectionId(pgdConnectionId)
      => ComCall(11, this.p, GUID.Ptr, pgdConnectionId)
    GetAdapterId(pgdAdapterId)
      => ComCall(12, this.p, GUID.Ptr, pgdAdapterId)
    GetDomainType(pDomainType)
      => ComCall(13, this.p, NLM_DOMAIN_TYPE.Ptr, pDomainType)
}
struct INetworkConnection2 extends INetworkConnection {
    static IID := "{00E676ED-5A35-4738-92EB-8581738D0F0A}"
    IsDomainAuthenticatedBy(domainAuthenticationKind, pValue)
      => ComCall(14, this.p, NLM_DOMAIN_AUTHENTICATION_KIND, domainAuthenticationKind, BOOL.Ptr, pValue)
}
struct IEnumNetworkConnections extends IDispatch {
    static IID := "{DCB00006-570F-4A9B-8D69-199FDBA5723B}"
    get__NewEnum(ppEnumVar)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, ppEnumVar)
    Next(rgelt, pceltFetched?)
      => ComCall(8, this.p, UInt32, rgelt.Length, INetworkConnection.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(9, this.p, UInt32, celt)
    Reset()
      => ComCall(10, this.p)
    Clone(ppEnumNetwork)
      => ComCall(11, this.p, IEnumNetworkConnections.Ptr, ppEnumNetwork)
}
struct NLM_CONNECTION_PROPERTY_CHANGE extends Int32 {
    static NLM_CONNECTION_PROPERTY_CHANGE_AUTHENTICATION := 1
}
struct INetworkConnectionEvents extends IUnknown {
    static IID := "{DCB00007-570F-4A9B-8D69-199FDBA5723B}"
    NetworkConnectionConnectivityChanged(connectionId, newConnectivity)
      => ComCall(3, this.p, GUID, connectionId, NLM_CONNECTIVITY, newConnectivity)
    NetworkConnectionPropertyChanged(connectionId, flags)
      => ComCall(4, this.p, GUID, connectionId, NLM_CONNECTION_PROPERTY_CHANGE, flags)
}
struct INetworkCostManager extends IUnknown {
    static IID := "{DCB00008-570F-4A9B-8D69-199FDBA5723B}"
    GetCost(pCost, pDestIPAddr)
      => ComCall(3, this.p, UInt32.Ptr, pCost, NLM_SOCKADDR.Ptr, pDestIPAddr)
    GetDataPlanStatus(pDataPlanStatus, pDestIPAddr)
      => ComCall(4, this.p, NLM_DATAPLAN_STATUS.Ptr, pDataPlanStatus, NLM_SOCKADDR.Ptr, pDestIPAddr)
    SetDestinationAddresses(pDestIPAddrList, bAppend)
      => ComCall(5, this.p, UInt32, pDestIPAddrList.Length, NLM_SOCKADDR.Ptr, pDestIPAddrList, VARIANT_BOOL, bAppend)
}
struct INetworkCostManagerEvents extends IUnknown {
    static IID := "{DCB00009-570F-4A9B-8D69-199FDBA5723B}"
    CostChanged(newCost, pDestAddr)
      => ComCall(3, this.p, UInt32, newCost, NLM_SOCKADDR.Ptr, pDestAddr)
    DataPlanStatusChanged(pDestAddr)
      => ComCall(4, this.p, NLM_SOCKADDR.Ptr, pDestAddr)
}
struct INetworkConnectionCost extends IUnknown {
    static IID := "{DCB0000A-570F-4A9B-8D69-199FDBA5723B}"
    GetCost(pCost)
      => ComCall(3, this.p, UInt32.Ptr, pCost)
    GetDataPlanStatus(pDataPlanStatus)
      => ComCall(4, this.p, NLM_DATAPLAN_STATUS.Ptr, pDataPlanStatus)
}
struct INetworkConnectionCostEvents extends IUnknown {
    static IID := "{DCB0000B-570F-4A9B-8D69-199FDBA5723B}"
    ConnectionCostChanged(connectionId, newCost)
      => ComCall(3, this.p, GUID, connectionId, UInt32, newCost)
    ConnectionDataPlanStatusChanged(connectionId)
      => ComCall(4, this.p, GUID, connectionId)
}
