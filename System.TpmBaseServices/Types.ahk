#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct TBS_COMMAND_PRIORITY extends UInt32 {
    static TBS_COMMAND_PRIORITY_LOW := 100
    static TBS_COMMAND_PRIORITY_NORMAL := 200
    static TBS_COMMAND_PRIORITY_SYSTEM := 400
    static TBS_COMMAND_PRIORITY_HIGH := 300
    static TBS_COMMAND_PRIORITY_MAX := 2147483648
}
struct TBS_COMMAND_LOCALITY extends UInt32 {
    static TBS_COMMAND_LOCALITY_ZERO := 0
    static TBS_COMMAND_LOCALITY_ONE := 1
    static TBS_COMMAND_LOCALITY_TWO := 2
    static TBS_COMMAND_LOCALITY_THREE := 3
    static TBS_COMMAND_LOCALITY_FOUR := 4
}
struct TBS_CONTEXT_PARAMS {
    version : UInt32
}
struct TBS_CONTEXT_PARAMS2 {
    version : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            asUINT32 : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct TPM_WNF_PROVISIONING {
    status : UInt32
    message : UInt8[28]
}
struct TPM_DEVICE_INFO {
    structVersion : UInt32
    tpmVersion : UInt32
    tpmInterfaceType : UInt32
    tpmImpRevision : UInt32
}
