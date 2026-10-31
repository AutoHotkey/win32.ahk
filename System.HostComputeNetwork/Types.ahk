#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

struct HCN_NOTIFICATIONS extends Int32 {
    static HcnNotificationInvalid := 0
    static HcnNotificationNetworkPreCreate := 1
    static HcnNotificationNetworkCreate := 2
    static HcnNotificationNetworkPreDelete := 3
    static HcnNotificationNetworkDelete := 4
    static HcnNotificationNamespaceCreate := 5
    static HcnNotificationNamespaceDelete := 6
    static HcnNotificationGuestNetworkServiceCreate := 7
    static HcnNotificationGuestNetworkServiceDelete := 8
    static HcnNotificationNetworkEndpointAttached := 9
    static HcnNotificationNetworkEndpointDetached := 16
    static HcnNotificationGuestNetworkServiceStateChanged := 17
    static HcnNotificationGuestNetworkServiceInterfaceStateChanged := 18
    static HcnNotificationServiceDisconnect := 16777216
    static HcnNotificationFlagsReserved := -268435456
}
struct HCN_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, HRESULT, PWSTR, "Void"]
}
struct HCN_PORT_PROTOCOL extends Int32 {
    static HCN_PORT_PROTOCOL_TCP := 1
    static HCN_PORT_PROTOCOL_UDP := 2
    static HCN_PORT_PROTOCOL_BOTH := 3
}
struct HCN_PORT_ACCESS extends Int32 {
    static HCN_PORT_ACCESS_EXCLUSIVE := 1
    static HCN_PORT_ACCESS_SHARED := 2
}
struct HCN_PORT_RANGE_RESERVATION {
    startingPort : UInt16
    endingPort : UInt16
}
struct HCN_PORT_RANGE_ENTRY {
    OwningPartitionId : GUID
    TargetPartitionId : GUID
    Protocol : HCN_PORT_PROTOCOL
    Priority : Int64
    ReservationType : UInt32
    SharingFlags : UInt32
    DeliveryMode : UInt32
    StartingPort : UInt16
    EndingPort : UInt16
}
