#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HANDLE, PWSTR}

struct WCM_PROPERTY extends Int32 {
    static wcm_global_property_domain_policy := 0
    static wcm_global_property_minimize_policy := 1
    static wcm_global_property_roaming_policy := 2
    static wcm_global_property_powermanagement_policy := 3
    static wcm_intf_property_connection_cost := 4
    static wcm_intf_property_dataplan_status := 5
    static wcm_intf_property_hotspot_profile := 6
}
struct WCM_MEDIA_TYPE extends Int32 {
    static wcm_media_unknown := 0
    static wcm_media_ethernet := 1
    static wcm_media_wlan := 2
    static wcm_media_mbn := 3
    static wcm_media_invalid := 4
    static wcm_media_max := 5
}
struct WCM_POLICY_VALUE {
    fValue : BOOL
    fIsGroupPolicy : BOOL
}
struct WCM_PROFILE_INFO {
    strProfileName : UInt16[256]
    AdapterGUID : GUID
    Media : WCM_MEDIA_TYPE
}
struct WCM_PROFILE_INFO_LIST {
    dwNumberOfItems : UInt32
    ProfileInfo : WCM_PROFILE_INFO[1]
}
struct WCM_CONNECTION_COST extends Int32 {
    static WCM_CONNECTION_COST_UNKNOWN := 0
    static WCM_CONNECTION_COST_UNRESTRICTED := 1
    static WCM_CONNECTION_COST_FIXED := 2
    static WCM_CONNECTION_COST_VARIABLE := 4
    static WCM_CONNECTION_COST_OVERDATALIMIT := 65536
    static WCM_CONNECTION_COST_CONGESTED := 131072
    static WCM_CONNECTION_COST_ROAMING := 262144
    static WCM_CONNECTION_COST_APPROACHINGDATALIMIT := 524288
}
struct WCM_CONNECTION_COST_SOURCE extends Int32 {
    static WCM_CONNECTION_COST_SOURCE_DEFAULT := 0
    static WCM_CONNECTION_COST_SOURCE_GP := 1
    static WCM_CONNECTION_COST_SOURCE_USER := 2
    static WCM_CONNECTION_COST_SOURCE_OPERATOR := 3
}
struct WCM_CONNECTION_COST_DATA {
    ConnectionCost : UInt32
    CostSource : WCM_CONNECTION_COST_SOURCE
}
struct WCM_TIME_INTERVAL {
    wYear : UInt16
    wMonth : UInt16
    wDay : UInt16
    wHour : UInt16
    wMinute : UInt16
    wSecond : UInt16
    wMilliseconds : UInt16
}
struct WCM_USAGE_DATA {
    UsageInMegabytes : UInt32
    LastSyncTime : FILETIME
}
struct WCM_BILLING_CYCLE_INFO {
    StartDate : FILETIME
    Duration : WCM_TIME_INTERVAL
    Reset : BOOL
}
struct WCM_DATAPLAN_STATUS {
    UsageData : WCM_USAGE_DATA
    DataLimitInMegabytes : UInt32
    InboundBandwidthInKbps : UInt32
    OutboundBandwidthInKbps : UInt32
    BillingCycle : WCM_BILLING_CYCLE_INFO
    MaxTransferSizeInMegabytes : UInt32
    Reserved : UInt32
}
struct ONDEMAND_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct NET_INTERFACE_CONTEXT {
    InterfaceIndex : UInt32
    ConfigurationName : PWSTR
}
struct NET_INTERFACE_CONTEXT_TABLE {
    InterfaceContextHandle : HANDLE
    NumberOfEntries : UInt32
    InterfaceContextArray : NET_INTERFACE_CONTEXT.Ptr
}
