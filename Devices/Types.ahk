#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct IEEE1394_VDEV_PNP_REQUEST {
    fulFlags : UInt32
    Reserved : UInt32
    InstanceId : Int64
    DeviceId : UInt8
}
struct IEEE1394_API_REQUEST {
    RequestNumber : UInt32
    Flags : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            AddVirtualDevice : IEEE1394_VDEV_PNP_REQUEST
            RemoveVirtualDevice : IEEE1394_VDEV_PNP_REQUEST
        }
    }
}
