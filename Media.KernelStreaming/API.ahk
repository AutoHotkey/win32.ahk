#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT}
#Import "..\Media.MediaFoundation\Types.ahk" {AM_MEDIA_TYPE}

KsCreateAllocator(ConnectionHandle, AllocatorFraming, AllocatorHandle)
  => DllCall("ksuser.dll\KsCreateAllocator", HANDLE, ConnectionHandle, KSALLOCATOR_FRAMING.Ptr, AllocatorFraming, HANDLE.Ptr, AllocatorHandle, UInt32)
KsCreateAllocator2(ConnectionHandle, AllocatorFraming, AllocatorHandle)
  => DllCall("ksuser.dll\KsCreateAllocator2", HANDLE, ConnectionHandle, KSALLOCATOR_FRAMING.Ptr, AllocatorFraming, HANDLE.Ptr, AllocatorHandle, "HRESULT")
KsCreateClock(ConnectionHandle, ClockCreate, ClockHandle)
  => DllCall("ksuser.dll\KsCreateClock", HANDLE, ConnectionHandle, KSCLOCK_CREATE.Ptr, ClockCreate, HANDLE.Ptr, ClockHandle, UInt32)
KsCreateClock2(ConnectionHandle, ClockCreate, ClockHandle)
  => DllCall("ksuser.dll\KsCreateClock2", HANDLE, ConnectionHandle, KSCLOCK_CREATE.Ptr, ClockCreate, HANDLE.Ptr, ClockHandle, "HRESULT")
KsCreatePin(FilterHandle, Connect, DesiredAccess, ConnectionHandle)
  => DllCall("ksuser.dll\KsCreatePin", HANDLE, FilterHandle, KSPIN_CONNECT.Ptr, Connect, UInt32, DesiredAccess, HANDLE.Ptr, ConnectionHandle, UInt32)
KsCreatePin2(FilterHandle, Connect, DesiredAccess, ConnectionHandle)
  => DllCall("ksuser.dll\KsCreatePin2", HANDLE, FilterHandle, KSPIN_CONNECT.Ptr, Connect, UInt32, DesiredAccess, HANDLE.Ptr, ConnectionHandle, "HRESULT")
KsCreateTopologyNode(ParentHandle, NodeCreate, DesiredAccess, NodeHandle)
  => DllCall("ksuser.dll\KsCreateTopologyNode", HANDLE, ParentHandle, KSNODE_CREATE.Ptr, NodeCreate, UInt32, DesiredAccess, HANDLE.Ptr, NodeHandle, UInt32)
KsCreateTopologyNode2(ParentHandle, NodeCreate, DesiredAccess, NodeHandle)
  => DllCall("ksuser.dll\KsCreateTopologyNode2", HANDLE, ParentHandle, KSNODE_CREATE.Ptr, NodeCreate, UInt32, DesiredAccess, HANDLE.Ptr, NodeHandle, "HRESULT")
KsGetMediaType(Position, AmMediaType, FilterHandle, PinFactoryId)
  => DllCall("ksproxy.ax\KsGetMediaType", Int32, Position, AM_MEDIA_TYPE.Ptr, AmMediaType, HANDLE, FilterHandle, UInt32, PinFactoryId, "HRESULT")
KsGetMediaTypeCount(FilterHandle, PinFactoryId, MediaTypeCount)
  => DllCall("ksproxy.ax\KsGetMediaTypeCount", HANDLE, FilterHandle, UInt32, PinFactoryId, UInt32.Ptr, MediaTypeCount, "HRESULT")
KsGetMultiplePinFactoryItems(FilterHandle, PinFactoryId, PropertyId, Items)
  => DllCall("ksproxy.ax\KsGetMultiplePinFactoryItems", HANDLE, FilterHandle, UInt32, PinFactoryId, UInt32, PropertyId, Struct.Ptr.Ptr, Items, "HRESULT")
KsOpenDefaultDevice(Category, Access, DeviceHandle)
  => DllCall("ksproxy.ax\KsOpenDefaultDevice", GUID.Ptr, Category, UInt32, Access, HANDLE.Ptr, DeviceHandle, "HRESULT")
KsResolveRequiredAttributes(DataRange, Attributes?)
  => DllCall("ksproxy.ax\KsResolveRequiredAttributes", KSDATAFORMAT.Ptr, DataRange, KSMULTIPLE_ITEM.Ptr, Attributes?, "HRESULT")
KsSynchronousDeviceControl(Handle1, IoControl, InBuffer?, OutBuffer?, BytesReturned?)
  => DllCall("ksproxy.ax\KsSynchronousDeviceControl", HANDLE, Handle1, UInt32, IoControl, Struct.Ptr, InBuffer?, UInt32, InBuffer?.Size ?? 0, Struct.Ptr, OutBuffer?, UInt32, OutBuffer?.Size ?? 0, UInt32.Ptr, BytesReturned?, "HRESULT")
