#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, PSTR, PWSTR}

struct DHCPV6CAPI_PARAMS {
    Flags : UInt32
    OptionId : UInt32
    IsVendor : BOOL
    Data : UInt8.Ptr
    nBytesData : UInt32
}
struct DHCPV6CAPI_PARAMS_ARRAY {
    nParams : UInt32
    Params : DHCPV6CAPI_PARAMS.Ptr
}
struct DHCPV6CAPI_CLASSID {
    Flags : UInt32
    Data : UInt8.Ptr
    nBytesData : UInt32
}
struct StatusCode extends Int32 {
    static STATUS_NO_ERROR := 0
    static STATUS_UNSPECIFIED_FAILURE := 1
    static STATUS_NO_BINDING := 3
    static STATUS_NOPREFIX_AVAIL := 6
}
struct DHCPV6Prefix {
    prefix : UInt8[16]
    prefixLength : UInt32
    preferredLifeTime : UInt32
    validLifeTime : UInt32
    status : StatusCode
}
struct DHCPV6PrefixLeaseInformation {
    nPrefixes : UInt32
    prefixArray : DHCPV6Prefix.Ptr
    iaid : UInt32
    T1 : Int64
    T2 : Int64
    MaxLeaseExpirationTime : Int64
    LastRenewalTime : Int64
    status : StatusCode
    ServerId : UInt8.Ptr
    ServerIdLen : UInt32
}
struct DHCPAPI_PARAMS {
    Flags : UInt32
    OptionId : UInt32
    IsVendor : BOOL
    Data : UInt8.Ptr
    nBytesData : UInt32
}
struct DHCPCAPI_PARAMS_ARRAY {
    nParams : UInt32
    Params : DHCPAPI_PARAMS.Ptr
}
struct DHCPCAPI_CLASSID {
    Flags : UInt32
    Data : UInt8.Ptr
    nBytesData : UInt32
}
struct DHCP_SERVER_OPTIONS {
    MessageType : UInt8.Ptr
    SubnetMask : UInt32.Ptr
    RequestedAddress : UInt32.Ptr
    RequestLeaseTime : UInt32.Ptr
    OverlayFields : UInt8.Ptr
    RouterAddress : UInt32.Ptr
    Server : UInt32.Ptr
    ParameterRequestList : UInt8.Ptr
    ParameterRequestListLength : UInt32
    MachineName : PSTR
    MachineNameLength : UInt32
    ClientHardwareAddressType : UInt8
    ClientHardwareAddressLength : UInt8
    ClientHardwareAddress : UInt8.Ptr
    ClassIdentifier : PSTR
    ClassIdentifierLength : UInt32
    VendorClass : UInt8.Ptr
    VendorClassLength : UInt32
    DNSFlags : UInt32
    DNSNameLength : UInt32
    DNSName : UInt8.Ptr
    DSDomainNameRequested : BOOLEAN
    DSDomainName : PSTR
    DSDomainNameLen : UInt32
    ScopeId : UInt32.Ptr
}
struct LPDHCP_CONTROL extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32]
}
struct LPDHCP_NEWPKT extends FunctionPointer {
    static Types := [UInt8.Ptr.Ptr, UInt32.Ptr, UInt32, Struct.Ptr, Struct.Ptr.Ptr, BOOL.Ptr, UInt32]
}
struct LPDHCP_DROP_SEND extends FunctionPointer {
    static Types := [UInt8.Ptr.Ptr, UInt32.Ptr, UInt32, UInt32, Struct.Ptr, Struct.Ptr, UInt32]
}
struct LPDHCP_PROB extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, UInt32, UInt32, UInt32, Struct.Ptr, Struct.Ptr, UInt32]
}
struct LPDHCP_GIVE_ADDRESS extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, Struct.Ptr, Struct.Ptr, UInt32]
}
struct LPDHCP_HANDLE_OPTIONS extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, Struct.Ptr, Struct.Ptr, DHCP_SERVER_OPTIONS.Ptr, UInt32]
}
struct LPDHCP_DELETE_CLIENT extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, UInt32, UInt32, UInt32, UInt32]
}
struct DHCP_CALLOUT_TABLE {
    DhcpControlHook : LPDHCP_CONTROL
    DhcpNewPktHook : LPDHCP_NEWPKT
    DhcpPktDropHook : LPDHCP_DROP_SEND
    DhcpPktSendHook : LPDHCP_DROP_SEND
    DhcpAddressDelHook : LPDHCP_PROB
    DhcpAddressOfferHook : LPDHCP_GIVE_ADDRESS
    DhcpHandleOptionsHook : LPDHCP_HANDLE_OPTIONS
    DhcpDeleteClientHook : LPDHCP_DELETE_CLIENT
    DhcpExtensionHook : Struct.Ptr
    DhcpReservedHook : Struct.Ptr
}
struct LPDHCP_ENTRY_POINT_FUNC extends FunctionPointer {
    static Types := [PWSTR, UInt32, DHCP_CALLOUT_TABLE.Ptr, UInt32]
}
struct DATE_TIME {
    dwLowDateTime : UInt32
    dwHighDateTime : UInt32
}
struct DHCP_IP_RANGE {
    StartAddress : UInt32
    EndAddress : UInt32
}
struct DHCP_BINARY_DATA {
    DataLength : UInt32
    Data : UInt8.Ptr
}
struct DHCP_HOST_INFO {
    IpAddress : UInt32
    NetBiosName : PWSTR
    HostName : PWSTR
}
struct DHCP_FORCE_FLAG extends Int32 {
    static DhcpFullForce := 0
    static DhcpNoForce := 1
    static DhcpFailoverForce := 2
}
struct DWORD_DWORD {
    DWord1 : UInt32
    DWord2 : UInt32
}
struct DHCP_SUBNET_STATE extends Int32 {
    static DhcpSubnetEnabled := 0
    static DhcpSubnetDisabled := 1
    static DhcpSubnetEnabledSwitched := 2
    static DhcpSubnetDisabledSwitched := 3
    static DhcpSubnetInvalidState := 4
}
struct DHCP_SUBNET_INFO {
    SubnetAddress : UInt32
    SubnetMask : UInt32
    SubnetName : PWSTR
    SubnetComment : PWSTR
    PrimaryHost : DHCP_HOST_INFO
    SubnetState : DHCP_SUBNET_STATE
}
struct DHCP_SUBNET_INFO_VQ {
    SubnetAddress : UInt32
    SubnetMask : UInt32
    SubnetName : PWSTR
    SubnetComment : PWSTR
    PrimaryHost : DHCP_HOST_INFO
    SubnetState : DHCP_SUBNET_STATE
    QuarantineOn : UInt32
    Reserved1 : UInt32
    Reserved2 : UInt32
    Reserved3 : Int64
    Reserved4 : Int64
}
struct DHCP_IP_ARRAY {
    NumElements : UInt32
    Elements : UInt32.Ptr
}
struct DHCP_IP_CLUSTER {
    ClusterAddress : UInt32
    ClusterMask : UInt32
}
struct DHCP_IP_RESERVATION {
    ReservedIpAddress : UInt32
    ReservedForClient : DHCP_BINARY_DATA.Ptr
}
struct DHCP_SUBNET_ELEMENT_TYPE extends Int32 {
    static DhcpIpRanges := 0
    static DhcpSecondaryHosts := 1
    static DhcpReservedIps := 2
    static DhcpExcludedIpRanges := 3
    static DhcpIpUsedClusters := 4
    static DhcpIpRangesDhcpOnly := 5
    static DhcpIpRangesDhcpBootp := 6
    static DhcpIpRangesBootpOnly := 7
}
struct DHCP_SUBNET_ELEMENT_DATA {
    ElementType : DHCP_SUBNET_ELEMENT_TYPE
    Element : this.DHCP_SUBNET_ELEMENT_UNION
    struct DHCP_SUBNET_ELEMENT_UNION {
        union {
            IpRange : DHCP_IP_RANGE.Ptr
            SecondaryHost : DHCP_HOST_INFO.Ptr
            ReservedIp : DHCP_IP_RESERVATION.Ptr
            ExcludeIpRange : DHCP_IP_RANGE.Ptr
            IpUsedCluster : DHCP_IP_CLUSTER.Ptr
        }
    }
}
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY {
    NumElements : UInt32
    Elements : DHCP_SUBNET_ELEMENT_DATA.Ptr
}
struct DHCP_IPV6_ADDRESS {
    HighOrderBits : Int64
    LowOrderBits : Int64
}
struct DHCP_FILTER_LIST_TYPE extends Int32 {
    static Deny := 0
    static Allow := 1
}
struct DHCP_ADDR_PATTERN {
    MatchHWType : BOOL
    HWType : UInt8
    IsWildcard : BOOL
    Length : UInt8
    Pattern : UInt8[255]
}
struct DHCP_FILTER_ADD_INFO {
    AddrPatt : DHCP_ADDR_PATTERN
    Comment : PWSTR
    ListType : DHCP_FILTER_LIST_TYPE
}
struct DHCP_FILTER_GLOBAL_INFO {
    EnforceAllowList : BOOL
    EnforceDenyList : BOOL
}
struct DHCP_FILTER_RECORD {
    AddrPatt : DHCP_ADDR_PATTERN
    Comment : PWSTR
}
struct DHCP_FILTER_ENUM_INFO {
    NumElements : UInt32
    pEnumRecords : DHCP_FILTER_RECORD.Ptr
}
struct DHCP_OPTION_DATA_TYPE extends Int32 {
    static DhcpByteOption := 0
    static DhcpWordOption := 1
    static DhcpDWordOption := 2
    static DhcpDWordDWordOption := 3
    static DhcpIpAddressOption := 4
    static DhcpStringDataOption := 5
    static DhcpBinaryDataOption := 6
    static DhcpEncapsulatedDataOption := 7
    static DhcpIpv6AddressOption := 8
}
struct DHCP_OPTION_DATA_ELEMENT {
    OptionType : DHCP_OPTION_DATA_TYPE
    Element : this.DHCP_OPTION_ELEMENT_UNION
    struct DHCP_OPTION_ELEMENT_UNION {
        union {
            ByteOption : UInt8
            WordOption : UInt16
            DWordOption : UInt32
            DWordDWordOption : DWORD_DWORD
            IpAddressOption : UInt32
            StringDataOption : PWSTR
            BinaryDataOption : DHCP_BINARY_DATA
            EncapsulatedDataOption : DHCP_BINARY_DATA
            Ipv6AddressDataOption : PWSTR
        }
    }
}
struct DHCP_OPTION_DATA {
    NumElements : UInt32
    Elements : DHCP_OPTION_DATA_ELEMENT.Ptr
}
struct DHCP_OPTION_TYPE extends Int32 {
    static DhcpUnaryElementTypeOption := 0
    static DhcpArrayTypeOption := 1
}
struct DHCP_OPTION {
    OptionID : UInt32
    OptionName : PWSTR
    OptionComment : PWSTR
    DefaultValue : DHCP_OPTION_DATA
    OptionType : DHCP_OPTION_TYPE
}
struct DHCP_OPTION_ARRAY {
    NumElements : UInt32
    Options : DHCP_OPTION.Ptr
}
struct DHCP_OPTION_VALUE {
    OptionID : UInt32
    Value : DHCP_OPTION_DATA
}
struct DHCP_OPTION_VALUE_ARRAY {
    NumElements : UInt32
    Values : DHCP_OPTION_VALUE.Ptr
}
struct DHCP_OPTION_SCOPE_TYPE extends Int32 {
    static DhcpDefaultOptions := 0
    static DhcpGlobalOptions := 1
    static DhcpSubnetOptions := 2
    static DhcpReservedOptions := 3
    static DhcpMScopeOptions := 4
}
struct DHCP_RESERVED_SCOPE {
    ReservedIpAddress : UInt32
    ReservedIpSubnetAddress : UInt32
}
struct DHCP_OPTION_SCOPE_INFO {
    ScopeType : DHCP_OPTION_SCOPE_TYPE
    ScopeInfo : this._DHCP_OPTION_SCOPE_UNION
    struct _DHCP_OPTION_SCOPE_UNION {
        union {
            DefaultScopeInfo : Struct.Ptr
            GlobalScopeInfo : Struct.Ptr
            SubnetScopeInfo : UInt32
            ReservedScopeInfo : DHCP_RESERVED_SCOPE
            MScopeInfo : PWSTR
        }
    }
}
struct DHCP_OPTION_SCOPE_TYPE6 extends Int32 {
    static DhcpDefaultOptions6 := 0
    static DhcpScopeOptions6 := 1
    static DhcpReservedOptions6 := 2
    static DhcpGlobalOptions6 := 3
}
struct DHCP_RESERVED_SCOPE6 {
    ReservedIpAddress : DHCP_IPV6_ADDRESS
    ReservedIpSubnetAddress : DHCP_IPV6_ADDRESS
}
struct DHCP_OPTION_SCOPE_INFO6 {
    ScopeType : DHCP_OPTION_SCOPE_TYPE6
    ScopeInfo : this.DHCP_OPTION_SCOPE_UNION6
    struct DHCP_OPTION_SCOPE_UNION6 {
        union {
            DefaultScopeInfo : Struct.Ptr
            SubnetScopeInfo : DHCP_IPV6_ADDRESS
            ReservedScopeInfo : DHCP_RESERVED_SCOPE6
        }
    }
}
struct DHCP_OPTION_LIST {
    NumOptions : UInt32
    Options : DHCP_OPTION_VALUE.Ptr
}
struct DHCP_CLIENT_INFO {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
}
struct DHCP_CLIENT_INFO_ARRAY {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO.Ptr.Ptr
}
struct QuarantineStatus extends Int32 {
    static NOQUARANTINE := 0
    static RESTRICTEDACCESS := 1
    static DROPPACKET := 2
    static PROBATION := 3
    static EXEMPT := 4
    static DEFAULTQUARSETTING := 5
    static NOQUARINFO := 6
}
struct DHCP_CLIENT_INFO_VQ {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
}
struct DHCP_CLIENT_INFO_ARRAY_VQ {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_VQ.Ptr.Ptr
}
struct DHCP_CLIENT_FILTER_STATUS_INFO {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
    FilterStatus : UInt32
}
struct DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY {
    NumElements : UInt32
    Clients : DHCP_CLIENT_FILTER_STATUS_INFO.Ptr.Ptr
}
struct DHCP_CLIENT_INFO_PB {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
    FilterStatus : UInt32
    PolicyName : PWSTR
}
struct DHCP_CLIENT_INFO_PB_ARRAY {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_PB.Ptr.Ptr
}
struct DHCP_SEARCH_INFO_TYPE extends Int32 {
    static DhcpClientIpAddress := 0
    static DhcpClientHardwareAddress := 1
    static DhcpClientName := 2
}
struct DHCP_SEARCH_INFO {
    SearchType : DHCP_SEARCH_INFO_TYPE
    SearchInfo : this.DHCP_CLIENT_SEARCH_UNION
    struct DHCP_CLIENT_SEARCH_UNION {
        union {
            ClientIpAddress : UInt32
            ClientHardwareAddress : DHCP_BINARY_DATA
            ClientName : PWSTR
        }
    }
}
struct DHCP_PROPERTY_TYPE extends Int32 {
    static DhcpPropTypeByte := 0
    static DhcpPropTypeWord := 1
    static DhcpPropTypeDword := 2
    static DhcpPropTypeString := 3
    static DhcpPropTypeBinary := 4
}
struct DHCP_PROPERTY_ID extends Int32 {
    static DhcpPropIdPolicyDnsSuffix := 0
    static DhcpPropIdClientAddressStateEx := 1
}
struct DHCP_PROPERTY {
    ID : DHCP_PROPERTY_ID
    Type : DHCP_PROPERTY_TYPE
    Value : this._DHCP_PROPERTY_VALUE_UNION
    struct _DHCP_PROPERTY_VALUE_UNION {
        union {
            ByteValue : UInt8
            WordValue : UInt16
            DWordValue : UInt32
            StringValue : PWSTR
            BinaryValue : DHCP_BINARY_DATA
        }
    }
}
struct DHCP_PROPERTY_ARRAY {
    NumElements : UInt32
    Elements : DHCP_PROPERTY.Ptr
}
struct DHCP_CLIENT_INFO_EX {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
    FilterStatus : UInt32
    PolicyName : PWSTR
    Properties : DHCP_PROPERTY_ARRAY.Ptr
}
struct DHCP_CLIENT_INFO_EX_ARRAY {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_EX.Ptr.Ptr
}
struct SCOPE_MIB_INFO {
    Subnet : UInt32
    NumAddressesInuse : UInt32
    NumAddressesFree : UInt32
    NumPendingOffers : UInt32
}
struct DHCP_MIB_INFO {
    Discovers : UInt32
    Offers : UInt32
    Requests : UInt32
    Acks : UInt32
    Naks : UInt32
    Declines : UInt32
    Releases : UInt32
    ServerStartTime : DATE_TIME
    Scopes : UInt32
    ScopeInfo : SCOPE_MIB_INFO.Ptr
}
struct SCOPE_MIB_INFO_VQ {
    Subnet : UInt32
    NumAddressesInuse : UInt32
    NumAddressesFree : UInt32
    NumPendingOffers : UInt32
    QtnNumLeases : UInt32
    QtnPctQtnLeases : UInt32
    QtnProbationLeases : UInt32
    QtnNonQtnLeases : UInt32
    QtnExemptLeases : UInt32
    QtnCapableClients : UInt32
}
struct DHCP_MIB_INFO_VQ {
    Discovers : UInt32
    Offers : UInt32
    Requests : UInt32
    Acks : UInt32
    Naks : UInt32
    Declines : UInt32
    Releases : UInt32
    ServerStartTime : DATE_TIME
    QtnNumLeases : UInt32
    QtnPctQtnLeases : UInt32
    QtnProbationLeases : UInt32
    QtnNonQtnLeases : UInt32
    QtnExemptLeases : UInt32
    QtnCapableClients : UInt32
    QtnIASErrors : UInt32
    Scopes : UInt32
    ScopeInfo : SCOPE_MIB_INFO_VQ.Ptr
}
struct SCOPE_MIB_INFO_V5 {
    Subnet : UInt32
    NumAddressesInuse : UInt32
    NumAddressesFree : UInt32
    NumPendingOffers : UInt32
}
struct DHCP_MIB_INFO_V5 {
    Discovers : UInt32
    Offers : UInt32
    Requests : UInt32
    Acks : UInt32
    Naks : UInt32
    Declines : UInt32
    Releases : UInt32
    ServerStartTime : DATE_TIME
    QtnNumLeases : UInt32
    QtnPctQtnLeases : UInt32
    QtnProbationLeases : UInt32
    QtnNonQtnLeases : UInt32
    QtnExemptLeases : UInt32
    QtnCapableClients : UInt32
    QtnIASErrors : UInt32
    DelayedOffers : UInt32
    ScopesWithDelayedOffers : UInt32
    Scopes : UInt32
    ScopeInfo : SCOPE_MIB_INFO_V5.Ptr
}
struct DHCP_SERVER_CONFIG_INFO {
    APIProtocolSupport : UInt32
    DatabaseName : PWSTR
    DatabasePath : PWSTR
    BackupPath : PWSTR
    BackupInterval : UInt32
    DatabaseLoggingFlag : UInt32
    RestoreFlag : UInt32
    DatabaseCleanupInterval : UInt32
    DebugFlag : UInt32
}
struct DHCP_SCAN_FLAG extends Int32 {
    static DhcpRegistryFix := 0
    static DhcpDatabaseFix := 1
}
struct DHCP_SCAN_ITEM {
    IpAddress : UInt32
    ScanFlag : DHCP_SCAN_FLAG
}
struct DHCP_SCAN_LIST {
    NumScanItems : UInt32
    ScanItems : DHCP_SCAN_ITEM.Ptr
}
struct DHCP_CLASS_INFO {
    ClassName : PWSTR
    ClassComment : PWSTR
    ClassDataLength : UInt32
    IsVendor : BOOL
    Flags : UInt32
    ClassData : UInt8.Ptr
}
struct DHCP_CLASS_INFO_ARRAY {
    NumElements : UInt32
    Classes : DHCP_CLASS_INFO.Ptr
}
struct DHCP_CLASS_INFO_V6 {
    ClassName : PWSTR
    ClassComment : PWSTR
    ClassDataLength : UInt32
    IsVendor : BOOL
    EnterpriseNumber : UInt32
    Flags : UInt32
    ClassData : UInt8.Ptr
}
struct DHCP_CLASS_INFO_ARRAY_V6 {
    NumElements : UInt32
    Classes : DHCP_CLASS_INFO_V6.Ptr
}
struct DHCP_SERVER_SPECIFIC_STRINGS {
    DefaultVendorClassName : PWSTR
    DefaultUserClassName : PWSTR
}
struct DHCP_IP_RESERVATION_V4 {
    ReservedIpAddress : UInt32
    ReservedForClient : DHCP_BINARY_DATA.Ptr
    bAllowedClientTypes : UInt8
}
struct DHCP_IP_RESERVATION_INFO {
    ReservedIpAddress : UInt32
    ReservedForClient : DHCP_BINARY_DATA
    ReservedClientName : PWSTR
    ReservedClientDesc : PWSTR
    bAllowedClientTypes : UInt8
    fOptionsPresent : UInt8
}
struct DHCP_RESERVATION_INFO_ARRAY {
    NumElements : UInt32
    Elements : DHCP_IP_RESERVATION_INFO.Ptr.Ptr
}
struct DHCP_SUBNET_ELEMENT_DATA_V4 {
    ElementType : DHCP_SUBNET_ELEMENT_TYPE
    Element : this.DHCP_SUBNET_ELEMENT_UNION_V4
    struct DHCP_SUBNET_ELEMENT_UNION_V4 {
        union {
            IpRange : DHCP_IP_RANGE.Ptr
            SecondaryHost : DHCP_HOST_INFO.Ptr
            ReservedIp : DHCP_IP_RESERVATION_V4.Ptr
            ExcludeIpRange : DHCP_IP_RANGE.Ptr
            IpUsedCluster : DHCP_IP_CLUSTER.Ptr
        }
    }
}
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4 {
    NumElements : UInt32
    Elements : DHCP_SUBNET_ELEMENT_DATA_V4.Ptr
}
struct DHCP_CLIENT_INFO_V4 {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
}
struct DHCP_CLIENT_INFO_ARRAY_V4 {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_V4.Ptr.Ptr
}
struct DHCP_SERVER_CONFIG_INFO_V4 {
    APIProtocolSupport : UInt32
    DatabaseName : PWSTR
    DatabasePath : PWSTR
    BackupPath : PWSTR
    BackupInterval : UInt32
    DatabaseLoggingFlag : UInt32
    RestoreFlag : UInt32
    DatabaseCleanupInterval : UInt32
    DebugFlag : UInt32
    dwPingRetries : UInt32
    cbBootTableString : UInt32
    wszBootTableString : PWSTR
    fAuditLog : BOOL
}
struct DHCP_SERVER_CONFIG_INFO_VQ {
    APIProtocolSupport : UInt32
    DatabaseName : PWSTR
    DatabasePath : PWSTR
    BackupPath : PWSTR
    BackupInterval : UInt32
    DatabaseLoggingFlag : UInt32
    RestoreFlag : UInt32
    DatabaseCleanupInterval : UInt32
    DebugFlag : UInt32
    dwPingRetries : UInt32
    cbBootTableString : UInt32
    wszBootTableString : PWSTR
    fAuditLog : BOOL
    QuarantineOn : BOOL
    QuarDefFail : UInt32
    QuarRuntimeStatus : BOOL
}
struct DHCP_SERVER_CONFIG_INFO_V6 {
    UnicastFlag : BOOL
    RapidCommitFlag : BOOL
    PreferredLifetime : UInt32
    ValidLifetime : UInt32
    T1 : UInt32
    T2 : UInt32
    PreferredLifetimeIATA : UInt32
    ValidLifetimeIATA : UInt32
    fAuditLog : BOOL
}
struct DHCP_SUPER_SCOPE_TABLE_ENTRY {
    SubnetAddress : UInt32
    SuperScopeNumber : UInt32
    NextInSuperScope : UInt32
    SuperScopeName : PWSTR
}
struct DHCP_SUPER_SCOPE_TABLE {
    cEntries : UInt32
    pEntries : DHCP_SUPER_SCOPE_TABLE_ENTRY.Ptr
}
struct DHCP_CLIENT_INFO_V5 {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
}
struct DHCP_CLIENT_INFO_ARRAY_V5 {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_V5.Ptr.Ptr
}
struct DHCP_ALL_OPTIONS {
    Flags : UInt32
    NonVendorOptions : DHCP_OPTION_ARRAY.Ptr
    NumVendorOptions : UInt32
    VendorOptions : this._Anonymous_e__Struct.Ptr
    struct _Anonymous_e__Struct {
        Option : DHCP_OPTION
        VendorName : PWSTR
        ClassName : PWSTR
    }
}
struct DHCP_ALL_OPTION_VALUES {
    Flags : UInt32
    NumElements : UInt32
    Options : this._Anonymous_e__Struct.Ptr
    struct _Anonymous_e__Struct {
        ClassName : PWSTR
        VendorName : PWSTR
        IsVendor : BOOL
        OptionsArray : DHCP_OPTION_VALUE_ARRAY.Ptr
    }
}
struct DHCP_ALL_OPTION_VALUES_PB {
    Flags : UInt32
    NumElements : UInt32
    Options : this._Anonymous_e__Struct.Ptr
    struct _Anonymous_e__Struct {
        PolicyName : PWSTR
        VendorName : PWSTR
        IsVendor : BOOL
        OptionsArray : DHCP_OPTION_VALUE_ARRAY.Ptr
    }
}
struct DHCPDS_SERVER {
    Version : UInt32
    ServerName : PWSTR
    ServerAddress : UInt32
    Flags : UInt32
    State : UInt32
    DsLocation : PWSTR
    DsLocType : UInt32
}
struct DHCPDS_SERVERS {
    Flags : UInt32
    NumElements : UInt32
    Servers : DHCPDS_SERVER.Ptr
}
struct DHCP_ATTRIB {
    DhcpAttribId : UInt32
    DhcpAttribType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            DhcpAttribBool : BOOL
            DhcpAttribUlong : UInt32
        }
    }
}
struct DHCP_ATTRIB_ARRAY {
    NumElements : UInt32
    DhcpAttribs : DHCP_ATTRIB.Ptr
}
struct DHCP_BOOTP_IP_RANGE {
    StartAddress : UInt32
    EndAddress : UInt32
    BootpAllocated : UInt32
    MaxBootpAllowed : UInt32
}
struct DHCP_SUBNET_ELEMENT_DATA_V5 {
    ElementType : DHCP_SUBNET_ELEMENT_TYPE
    Element : this._DHCP_SUBNET_ELEMENT_UNION_V5
    struct _DHCP_SUBNET_ELEMENT_UNION_V5 {
        union {
            IpRange : DHCP_BOOTP_IP_RANGE.Ptr
            SecondaryHost : DHCP_HOST_INFO.Ptr
            ReservedIp : DHCP_IP_RESERVATION_V4.Ptr
            ExcludeIpRange : DHCP_IP_RANGE.Ptr
            IpUsedCluster : DHCP_IP_CLUSTER.Ptr
        }
    }
}
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5 {
    NumElements : UInt32
    Elements : DHCP_SUBNET_ELEMENT_DATA_V5.Ptr
}
struct DHCP_PERF_STATS {
    dwNumPacketsReceived : UInt32
    dwNumPacketsDuplicate : UInt32
    dwNumPacketsExpired : UInt32
    dwNumMilliSecondsProcessed : UInt32
    dwNumPacketsInActiveQueue : UInt32
    dwNumPacketsInPingQueue : UInt32
    dwNumDiscoversReceived : UInt32
    dwNumOffersSent : UInt32
    dwNumRequestsReceived : UInt32
    dwNumInformsReceived : UInt32
    dwNumAcksSent : UInt32
    dwNumNacksSent : UInt32
    dwNumDeclinesReceived : UInt32
    dwNumReleasesReceived : UInt32
    dwNumDelayedOfferInQueue : UInt32
    dwNumPacketsProcessed : UInt32
    dwNumPacketsInQuarWaitingQueue : UInt32
    dwNumPacketsInQuarReadyQueue : UInt32
    dwNumPacketsInQuarDecisionQueue : UInt32
}
struct DHCP_BIND_ELEMENT {
    Flags : UInt32
    fBoundToDHCPServer : BOOL
    AdapterPrimaryAddress : UInt32
    AdapterSubnetAddress : UInt32
    IfDescription : PWSTR
    IfIdSize : UInt32
    IfId : UInt8.Ptr
}
struct DHCP_BIND_ELEMENT_ARRAY {
    NumElements : UInt32
    Elements : DHCP_BIND_ELEMENT.Ptr
}
struct DHCPV6_BIND_ELEMENT {
    Flags : UInt32
    fBoundToDHCPServer : BOOL
    AdapterPrimaryAddress : DHCP_IPV6_ADDRESS
    AdapterSubnetAddress : DHCP_IPV6_ADDRESS
    IfDescription : PWSTR
    IpV6IfIndex : UInt32
    IfIdSize : UInt32
    IfId : UInt8.Ptr
}
struct DHCPV6_BIND_ELEMENT_ARRAY {
    NumElements : UInt32
    Elements : DHCPV6_BIND_ELEMENT.Ptr
}
struct DHCP_IP_RANGE_V6 {
    StartAddress : DHCP_IPV6_ADDRESS
    EndAddress : DHCP_IPV6_ADDRESS
}
struct DHCP_HOST_INFO_V6 {
    IpAddress : DHCP_IPV6_ADDRESS
    NetBiosName : PWSTR
    HostName : PWSTR
}
struct DHCP_SUBNET_INFO_V6 {
    SubnetAddress : DHCP_IPV6_ADDRESS
    Prefix : UInt32
    Preference : UInt16
    SubnetName : PWSTR
    SubnetComment : PWSTR
    State : UInt32
    ScopeId : UInt32
}
struct SCOPE_MIB_INFO_V6 {
    Subnet : DHCP_IPV6_ADDRESS
    NumAddressesInuse : Int64
    NumAddressesFree : Int64
    NumPendingAdvertises : Int64
}
struct DHCP_MIB_INFO_V6 {
    Solicits : UInt32
    Advertises : UInt32
    Requests : UInt32
    Renews : UInt32
    Rebinds : UInt32
    Replies : UInt32
    Confirms : UInt32
    Declines : UInt32
    Releases : UInt32
    Informs : UInt32
    ServerStartTime : DATE_TIME
    Scopes : UInt32
    ScopeInfo : SCOPE_MIB_INFO_V6.Ptr
}
struct DHCP_IP_RESERVATION_V6 {
    ReservedIpAddress : DHCP_IPV6_ADDRESS
    ReservedForClient : DHCP_BINARY_DATA.Ptr
    InterfaceId : UInt32
}
struct DHCP_SUBNET_ELEMENT_TYPE_V6 extends Int32 {
    static Dhcpv6IpRanges := 0
    static Dhcpv6ReservedIps := 1
    static Dhcpv6ExcludedIpRanges := 2
}
struct DHCP_SUBNET_ELEMENT_DATA_V6 {
    ElementType : DHCP_SUBNET_ELEMENT_TYPE_V6
    Element : this.DHCP_SUBNET_ELEMENT_UNION_V6
    struct DHCP_SUBNET_ELEMENT_UNION_V6 {
        union {
            IpRange : DHCP_IP_RANGE_V6.Ptr
            ReservedIp : DHCP_IP_RESERVATION_V6.Ptr
            ExcludeIpRange : DHCP_IP_RANGE_V6.Ptr
        }
    }
}
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6 {
    NumElements : UInt32
    Elements : DHCP_SUBNET_ELEMENT_DATA_V6.Ptr
}
struct DHCP_CLIENT_INFO_V6 {
    ClientIpAddress : DHCP_IPV6_ADDRESS
    ClientDUID : DHCP_BINARY_DATA
    AddressType : UInt32
    IAID : UInt32
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientValidLeaseExpires : DATE_TIME
    ClientPrefLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO_V6
}
struct DHCPV6_IP_ARRAY {
    NumElements : UInt32
    Elements : DHCP_IPV6_ADDRESS.Ptr
}
struct DHCP_CLIENT_INFO_ARRAY_V6 {
    NumElements : UInt32
    Clients : DHCP_CLIENT_INFO_V6.Ptr.Ptr
}
struct DHCP_SEARCH_INFO_TYPE_V6 extends Int32 {
    static Dhcpv6ClientIpAddress := 0
    static Dhcpv6ClientDUID := 1
    static Dhcpv6ClientName := 2
}
struct DHCP_SEARCH_INFO_V6 {
    SearchType : DHCP_SEARCH_INFO_TYPE_V6
    SearchInfo : this._DHCP_CLIENT_SEARCH_UNION_V6
    struct _DHCP_CLIENT_SEARCH_UNION_V6 {
        union {
            ClientIpAddress : DHCP_IPV6_ADDRESS
            ClientDUID : DHCP_BINARY_DATA
            ClientName : PWSTR
        }
    }
}
struct DHCP_POL_ATTR_TYPE extends Int32 {
    static DhcpAttrHWAddr := 0
    static DhcpAttrOption := 1
    static DhcpAttrSubOption := 2
    static DhcpAttrFqdn := 3
    static DhcpAttrFqdnSingleLabel := 4
}
struct DHCP_POL_COMPARATOR extends Int32 {
    static DhcpCompEqual := 0
    static DhcpCompNotEqual := 1
    static DhcpCompBeginsWith := 2
    static DhcpCompNotBeginWith := 3
    static DhcpCompEndsWith := 4
    static DhcpCompNotEndWith := 5
}
struct DHCP_POL_LOGIC_OPER extends Int32 {
    static DhcpLogicalOr := 0
    static DhcpLogicalAnd := 1
}
struct DHCP_POLICY_FIELDS_TO_UPDATE extends Int32 {
    static DhcpUpdatePolicyName := 1
    static DhcpUpdatePolicyOrder := 2
    static DhcpUpdatePolicyExpr := 4
    static DhcpUpdatePolicyRanges := 8
    static DhcpUpdatePolicyDescr := 16
    static DhcpUpdatePolicyStatus := 32
    static DhcpUpdatePolicyDnsSuffix := 64
}
struct DHCP_POL_COND {
    ParentExpr : UInt32
    Type : DHCP_POL_ATTR_TYPE
    OptionID : UInt32
    SubOptionID : UInt32
    VendorName : PWSTR
    Operator : DHCP_POL_COMPARATOR
    Value : UInt8.Ptr
    ValueLength : UInt32
}
struct DHCP_POL_COND_ARRAY {
    NumElements : UInt32
    Elements : DHCP_POL_COND.Ptr
}
struct DHCP_POL_EXPR {
    ParentExpr : UInt32
    Operator : DHCP_POL_LOGIC_OPER
}
struct DHCP_POL_EXPR_ARRAY {
    NumElements : UInt32
    Elements : DHCP_POL_EXPR.Ptr
}
struct DHCP_IP_RANGE_ARRAY {
    NumElements : UInt32
    Elements : DHCP_IP_RANGE.Ptr
}
struct DHCP_POLICY {
    PolicyName : PWSTR
    IsGlobalPolicy : BOOL
    Subnet : UInt32
    ProcessingOrder : UInt32
    Conditions : DHCP_POL_COND_ARRAY.Ptr
    Expressions : DHCP_POL_EXPR_ARRAY.Ptr
    Ranges : DHCP_IP_RANGE_ARRAY.Ptr
    Description : PWSTR
    Enabled : BOOL
}
struct DHCP_POLICY_ARRAY {
    NumElements : UInt32
    Elements : DHCP_POLICY.Ptr
}
struct DHCP_POLICY_EX {
    PolicyName : PWSTR
    IsGlobalPolicy : BOOL
    Subnet : UInt32
    ProcessingOrder : UInt32
    Conditions : DHCP_POL_COND_ARRAY.Ptr
    Expressions : DHCP_POL_EXPR_ARRAY.Ptr
    Ranges : DHCP_IP_RANGE_ARRAY.Ptr
    Description : PWSTR
    Enabled : BOOL
    Properties : DHCP_PROPERTY_ARRAY.Ptr
}
struct DHCP_POLICY_EX_ARRAY {
    NumElements : UInt32
    Elements : DHCP_POLICY_EX.Ptr
}
struct DHCPV6_STATELESS_PARAM_TYPE extends Int32 {
    static DhcpStatelessPurgeInterval := 1
    static DhcpStatelessStatus := 2
}
struct DHCPV6_STATELESS_PARAMS {
    Status : BOOL
    PurgeInterval : UInt32
}
struct DHCPV6_STATELESS_SCOPE_STATS {
    SubnetAddress : DHCP_IPV6_ADDRESS
    NumStatelessClientsAdded : Int64
    NumStatelessClientsRemoved : Int64
}
struct DHCPV6_STATELESS_STATS {
    NumScopes : UInt32
    ScopeStats : DHCPV6_STATELESS_SCOPE_STATS.Ptr
}
struct DHCP_FAILOVER_MODE extends Int32 {
    static LoadBalance := 0
    static HotStandby := 1
}
struct DHCP_FAILOVER_SERVER extends Int32 {
    static PrimaryServer := 0
    static SecondaryServer := 1
}
struct FSM_STATE extends Int32 {
    static NO_STATE := 0
    static INIT := 1
    static STARTUP := 2
    static NORMAL := 3
    static COMMUNICATION_INT := 4
    static PARTNER_DOWN := 5
    static POTENTIAL_CONFLICT := 6
    static CONFLICT_DONE := 7
    static RESOLUTION_INT := 8
    static RECOVER := 9
    static RECOVER_WAIT := 10
    static RECOVER_DONE := 11
    static PAUSED := 12
    static SHUTDOWN := 13
}
struct DHCP_FAILOVER_RELATIONSHIP {
    PrimaryServer : UInt32
    SecondaryServer : UInt32
    Mode : DHCP_FAILOVER_MODE
    ServerType : DHCP_FAILOVER_SERVER
    State : FSM_STATE
    PrevState : FSM_STATE
    Mclt : UInt32
    SafePeriod : UInt32
    RelationshipName : PWSTR
    PrimaryServerName : PWSTR
    SecondaryServerName : PWSTR
    pScopes : DHCP_IP_ARRAY.Ptr
    Percentage : UInt8
    SharedSecret : PWSTR
}
struct DHCP_FAILOVER_RELATIONSHIP_ARRAY {
    NumElements : UInt32
    pRelationships : DHCP_FAILOVER_RELATIONSHIP.Ptr
}
struct DHCPV4_FAILOVER_CLIENT_INFO {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
    SentPotExpTime : UInt32
    AckPotExpTime : UInt32
    RecvPotExpTime : UInt32
    StartTime : UInt32
    CltLastTransTime : UInt32
    LastBndUpdTime : UInt32
    BndMsgStatus : UInt32
    PolicyName : PWSTR
    Flags : UInt8
}
struct DHCPV4_FAILOVER_CLIENT_INFO_ARRAY {
    NumElements : UInt32
    Clients : DHCPV4_FAILOVER_CLIENT_INFO.Ptr.Ptr
}
struct DHCPV4_FAILOVER_CLIENT_INFO_EX {
    ClientIpAddress : UInt32
    SubnetMask : UInt32
    ClientHardwareAddress : DHCP_BINARY_DATA
    ClientName : PWSTR
    ClientComment : PWSTR
    ClientLeaseExpires : DATE_TIME
    OwnerHost : DHCP_HOST_INFO
    bClientType : UInt8
    AddressState : UInt8
    Status : QuarantineStatus
    ProbationEnds : DATE_TIME
    QuarantineCapable : BOOL
    SentPotExpTime : UInt32
    AckPotExpTime : UInt32
    RecvPotExpTime : UInt32
    StartTime : UInt32
    CltLastTransTime : UInt32
    LastBndUpdTime : UInt32
    BndMsgStatus : UInt32
    PolicyName : PWSTR
    Flags : UInt8
    AddressStateEx : UInt32
}
struct DHCP_FAILOVER_STATISTICS {
    NumAddr : UInt32
    AddrFree : UInt32
    AddrInUse : UInt32
    PartnerAddrFree : UInt32
    ThisAddrFree : UInt32
    PartnerAddrInUse : UInt32
    ThisAddrInUse : UInt32
}
