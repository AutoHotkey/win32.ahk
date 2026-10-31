#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

McastApiCleanup()
  => DllCall("dhcpcsvc.dll\McastApiCleanup", "void")
McastApiStartup(Version)
  => DllCall("dhcpcsvc.dll\McastApiStartup", UInt32.Ptr, Version, UInt32)
McastEnumerateScopes(AddrFamily, ReQuery, pScopeList, pScopeLen, pScopeCount)
  => DllCall("dhcpcsvc.dll\McastEnumerateScopes", UInt16, AddrFamily, BOOL, ReQuery, MCAST_SCOPE_ENTRY.Ptr, pScopeList, UInt32.Ptr, pScopeLen, UInt32.Ptr, pScopeCount, UInt32)
McastGenUID(pRequestID)
  => DllCall("dhcpcsvc.dll\McastGenUID", MCAST_CLIENT_UID.Ptr, pRequestID, UInt32)
McastReleaseAddress(AddrFamily, pRequestID, pReleaseRequest)
  => DllCall("dhcpcsvc.dll\McastReleaseAddress", UInt16, AddrFamily, MCAST_CLIENT_UID.Ptr, pRequestID, MCAST_LEASE_REQUEST.Ptr, pReleaseRequest, UInt32)
McastRenewAddress(AddrFamily, pRequestID, pRenewRequest, pRenewResponse)
  => DllCall("dhcpcsvc.dll\McastRenewAddress", UInt16, AddrFamily, MCAST_CLIENT_UID.Ptr, pRequestID, MCAST_LEASE_REQUEST.Ptr, pRenewRequest, MCAST_LEASE_RESPONSE.Ptr, pRenewResponse, UInt32)
McastRequestAddress(AddrFamily, pRequestID, pScopeCtx, pAddrRequest, pAddrResponse)
  => DllCall("dhcpcsvc.dll\McastRequestAddress", UInt16, AddrFamily, MCAST_CLIENT_UID.Ptr, pRequestID, MCAST_SCOPE_CTX.Ptr, pScopeCtx, MCAST_LEASE_REQUEST.Ptr, pAddrRequest, MCAST_LEASE_RESPONSE.Ptr, pAddrResponse, UInt32)
