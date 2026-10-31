#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Networking.WinSock\Types.ahk" {ADDRESS_FAMILY, DL_EUI48, IN6_ADDR, IN_ADDR, NL_DAD_STATE}

struct WNV_NOTIFICATION_TYPE extends Int32 {
    static WnvPolicyMismatchType := 0
    static WnvRedirectType := 1
    static WnvObjectChangeType := 2
    static WnvNotificationTypeMax := 3
}
struct WNV_OBJECT_TYPE extends Int32 {
    static WnvProviderAddressType := 0
    static WnvCustomerAddressType := 1
    static WnvObjectTypeMax := 2
}
struct WNV_CA_NOTIFICATION_TYPE extends Int32 {
    static WnvCustomerAddressAdded := 0
    static WnvCustomerAddressDeleted := 1
    static WnvCustomerAddressMoved := 2
    static WnvCustomerAddressMax := 3
}
struct WNV_OBJECT_HEADER {
    MajorVersion : UInt8
    MinorVersion : UInt8
    Size : UInt32
}
struct WNV_NOTIFICATION_PARAM {
    Header : WNV_OBJECT_HEADER
    NotificationType : WNV_NOTIFICATION_TYPE
    PendingNotifications : UInt32
    Buffer : UInt8.Ptr
}
struct WNV_IP_ADDRESS {
    IP : this._IP_e__Union
    struct _IP_e__Union {
        union {
            v4 : IN_ADDR
            v6 : IN6_ADDR
            Addr : UInt8[16]
        }
    }
}
struct WNV_POLICY_MISMATCH_PARAM {
    CAFamily : ADDRESS_FAMILY
    PAFamily : ADDRESS_FAMILY
    VirtualSubnetId : UInt32
    CA : WNV_IP_ADDRESS
    PA : WNV_IP_ADDRESS
}
struct WNV_PROVIDER_ADDRESS_CHANGE_PARAM {
    PAFamily : ADDRESS_FAMILY
    PA : WNV_IP_ADDRESS
    AddressState : NL_DAD_STATE
}
struct WNV_CUSTOMER_ADDRESS_CHANGE_PARAM {
    MACAddress : DL_EUI48
    CAFamily : ADDRESS_FAMILY
    CA : WNV_IP_ADDRESS
    VirtualSubnetId : UInt32
    PAFamily : ADDRESS_FAMILY
    PA : WNV_IP_ADDRESS
    NotificationReason : WNV_CA_NOTIFICATION_TYPE
}
struct WNV_OBJECT_CHANGE_PARAM {
    ObjectType : WNV_OBJECT_TYPE
    ObjectParam : this._ObjectParam_e__Union
    struct _ObjectParam_e__Union {
        union {
            ProviderAddressChange : WNV_PROVIDER_ADDRESS_CHANGE_PARAM
            CustomerAddressChange : WNV_CUSTOMER_ADDRESS_CHANGE_PARAM
        }
    }
}
struct WNV_REDIRECT_PARAM {
    CAFamily : ADDRESS_FAMILY
    PAFamily : ADDRESS_FAMILY
    NewPAFamily : ADDRESS_FAMILY
    VirtualSubnetId : UInt32
    CA : WNV_IP_ADDRESS
    PA : WNV_IP_ADDRESS
    NewPA : WNV_IP_ADDRESS
}
