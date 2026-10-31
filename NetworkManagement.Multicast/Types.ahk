#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {UNICODE_STRING}

struct IPNG_ADDRESS {
    union {
        IpAddrV4 : UInt32
        IpAddrV6 : UInt8[16]
    }
}
struct MCAST_CLIENT_UID {
    ClientUID : UInt8.Ptr
    ClientUIDLength : UInt32
}
struct MCAST_SCOPE_CTX {
    ScopeID : IPNG_ADDRESS
    Interface : IPNG_ADDRESS
    ServerID : IPNG_ADDRESS
}
struct MCAST_SCOPE_ENTRY {
    ScopeCtx : MCAST_SCOPE_CTX
    LastAddr : IPNG_ADDRESS
    TTL : UInt32
    ScopeDesc : UNICODE_STRING
}
struct MCAST_LEASE_REQUEST {
    LeaseStartTime : Int32
    MaxLeaseStartTime : Int32
    LeaseDuration : UInt32
    MinLeaseDuration : UInt32
    ServerAddress : IPNG_ADDRESS
    MinAddrCount : UInt16
    AddrCount : UInt16
    pAddrBuf : UInt8.Ptr
}
struct MCAST_LEASE_RESPONSE {
    LeaseStartTime : Int32
    LeaseEndTime : Int32
    ServerAddress : IPNG_ADDRESS
    AddrCount : UInt16
    pAddrBuf : UInt8.Ptr
}
