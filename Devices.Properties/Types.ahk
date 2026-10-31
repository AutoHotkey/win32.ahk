#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {DEVPROPKEY, PWSTR}

struct DEVPROPTYPE extends UInt32 {
    static DEVPROP_TYPEMOD_ARRAY := 4096
    static DEVPROP_TYPEMOD_LIST := 8192
    static DEVPROP_TYPE_EMPTY := 0
    static DEVPROP_TYPE_NULL := 1
    static DEVPROP_TYPE_SBYTE := 2
    static DEVPROP_TYPE_BYTE := 3
    static DEVPROP_TYPE_INT16 := 4
    static DEVPROP_TYPE_UINT16 := 5
    static DEVPROP_TYPE_INT32 := 6
    static DEVPROP_TYPE_UINT32 := 7
    static DEVPROP_TYPE_INT64 := 8
    static DEVPROP_TYPE_UINT64 := 9
    static DEVPROP_TYPE_FLOAT := 10
    static DEVPROP_TYPE_DOUBLE := 11
    static DEVPROP_TYPE_DECIMAL := 12
    static DEVPROP_TYPE_GUID := 13
    static DEVPROP_TYPE_CURRENCY := 14
    static DEVPROP_TYPE_DATE := 15
    static DEVPROP_TYPE_FILETIME := 16
    static DEVPROP_TYPE_BOOLEAN := 17
    static DEVPROP_TYPE_STRING := 18
    static DEVPROP_TYPE_STRING_LIST := 8210
    static DEVPROP_TYPE_SECURITY_DESCRIPTOR := 19
    static DEVPROP_TYPE_SECURITY_DESCRIPTOR_STRING := 20
    static DEVPROP_TYPE_DEVPROPKEY := 21
    static DEVPROP_TYPE_DEVPROPTYPE := 22
    static DEVPROP_TYPE_BINARY := 4099
    static DEVPROP_TYPE_ERROR := 23
    static DEVPROP_TYPE_NTSTATUS := 24
    static DEVPROP_TYPE_STRING_INDIRECT := 25
}
struct DEVPROP_BOOLEAN {
    Value : UInt8
}
struct DEVPROPSTORE extends Int32 {
    static DEVPROP_STORE_SYSTEM := 0
    static DEVPROP_STORE_USER := 1
}
struct DEVPROPCOMPKEY {
    Key : DEVPROPKEY
    Store : DEVPROPSTORE
    LocaleName : PWSTR
}
struct DEVPROPERTY {
    CompKey : DEVPROPCOMPKEY
    Type : DEVPROPTYPE
    BufferSize : UInt32
    Buffer : Struct.Ptr
}
