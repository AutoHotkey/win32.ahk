#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.Properties\Types.ahk" {DEVPROPERTY, DEVPROPTYPE}
#Import "..\Foundation\Types.ahk" {DEVPROPKEY, PWSTR}

struct HDEVQUERY {
    Value : IntPtr
}
struct DEVPROP_OPERATOR extends UInt32 {
    static DEVPROP_OPERATOR_MODIFIER_NOT := 65536
    static DEVPROP_OPERATOR_MODIFIER_IGNORE_CASE := 131072
    static DEVPROP_OPERATOR_NONE := 0
    static DEVPROP_OPERATOR_EXISTS := 1
    static DEVPROP_OPERATOR_NOT_EXISTS := 65537
    static DEVPROP_OPERATOR_EQUALS := 2
    static DEVPROP_OPERATOR_NOT_EQUALS := 65538
    static DEVPROP_OPERATOR_GREATER_THAN := 3
    static DEVPROP_OPERATOR_LESS_THAN := 4
    static DEVPROP_OPERATOR_GREATER_THAN_EQUALS := 5
    static DEVPROP_OPERATOR_LESS_THAN_EQUALS := 6
    static DEVPROP_OPERATOR_EQUALS_IGNORE_CASE := 131074
    static DEVPROP_OPERATOR_NOT_EQUALS_IGNORE_CASE := 196610
    static DEVPROP_OPERATOR_BITWISE_AND := 7
    static DEVPROP_OPERATOR_BITWISE_OR := 8
    static DEVPROP_OPERATOR_BEGINS_WITH := 9
    static DEVPROP_OPERATOR_ENDS_WITH := 10
    static DEVPROP_OPERATOR_CONTAINS := 11
    static DEVPROP_OPERATOR_BEGINS_WITH_IGNORE_CASE := 131081
    static DEVPROP_OPERATOR_ENDS_WITH_IGNORE_CASE := 131082
    static DEVPROP_OPERATOR_CONTAINS_IGNORE_CASE := 131083
    static DEVPROP_OPERATOR_LIST_CONTAINS := 4096
    static DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH := 8192
    static DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH := 12288
    static DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS := 16384
    static DEVPROP_OPERATOR_LIST_CONTAINS_IGNORE_CASE := 135168
    static DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH_IGNORE_CASE := 139264
    static DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH_IGNORE_CASE := 143360
    static DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS_IGNORE_CASE := 147456
    static DEVPROP_OPERATOR_AND_OPEN := 1048576
    static DEVPROP_OPERATOR_AND_CLOSE := 2097152
    static DEVPROP_OPERATOR_OR_OPEN := 3145728
    static DEVPROP_OPERATOR_OR_CLOSE := 4194304
    static DEVPROP_OPERATOR_NOT_OPEN := 5242880
    static DEVPROP_OPERATOR_NOT_CLOSE := 6291456
    static DEVPROP_OPERATOR_ARRAY_CONTAINS := 268435456
    static DEVPROP_OPERATOR_MASK_EVAL := 4095
    static DEVPROP_OPERATOR_MASK_LIST := 61440
    static DEVPROP_OPERATOR_MASK_MODIFIER := 983040
    static DEVPROP_OPERATOR_MASK_NOT_LOGICAL := 4027580415
    static DEVPROP_OPERATOR_MASK_LOGICAL := 267386880
    static DEVPROP_OPERATOR_MASK_ARRAY := 4026531840
}
struct DEVPROP_FILTER_EXPRESSION {
    Operator : DEVPROP_OPERATOR
    Property : DEVPROPERTY
}
struct DEV_OBJECT_TYPE extends Int32 {
    static DevObjectTypeUnknown := 0
    static DevObjectTypeDeviceInterface := 1
    static DevObjectTypeDeviceContainer := 2
    static DevObjectTypeDevice := 3
    static DevObjectTypeDeviceInterfaceClass := 4
    static DevObjectTypeAEP := 5
    static DevObjectTypeAEPContainer := 6
    static DevObjectTypeDeviceInstallerClass := 7
    static DevObjectTypeDeviceInterfaceDisplay := 8
    static DevObjectTypeDeviceContainerDisplay := 9
    static DevObjectTypeAEPService := 10
    static DevObjectTypeDevicePanel := 11
    static DevObjectTypeAEPProtocol := 12
}
struct DEV_QUERY_FLAGS extends Int32 {
    static DevQueryFlagNone := 0
    static DevQueryFlagUpdateResults := 1
    static DevQueryFlagAllProperties := 2
    static DevQueryFlagLocalize := 4
    static DevQueryFlagAsyncClose := 8
}
struct DEV_QUERY_STATE extends Int32 {
    static DevQueryStateInitialized := 0
    static DevQueryStateEnumCompleted := 1
    static DevQueryStateAborted := 2
    static DevQueryStateClosed := 3
}
struct DEV_QUERY_RESULT_ACTION extends Int32 {
    static DevQueryResultStateChange := 0
    static DevQueryResultAdd := 1
    static DevQueryResultUpdate := 2
    static DevQueryResultRemove := 3
}
struct DEV_OBJECT {
    ObjectType : DEV_OBJECT_TYPE
    pszObjectId : PWSTR
    cPropertyCount : UInt32
    pProperties : DEVPROPERTY.Ptr
}
struct DEV_QUERY_RESULT_ACTION_DATA {
    Action : DEV_QUERY_RESULT_ACTION
    Data : this._DEV_QUERY_RESULT_UPDATE_PAYLOAD
    struct _DEV_QUERY_RESULT_UPDATE_PAYLOAD {
        union {
            State : DEV_QUERY_STATE
            DeviceObject : DEV_OBJECT
        }
    }
}
struct DEV_QUERY_PARAMETER {
    Key : DEVPROPKEY
    Type : DEVPROPTYPE
    BufferSize : UInt32
    Buffer : Struct.Ptr
}
struct PDEV_QUERY_RESULT_CALLBACK extends FunctionPointer {
    static Types := [HDEVQUERY, Struct.Ptr, DEV_QUERY_RESULT_ACTION_DATA.Ptr, "Void"]
}
