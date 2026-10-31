#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, HANDLE, HWND, PWSTR, SYSTEMTIME}

struct HBLUETOOTH_DEVICE_FIND {
    Value : IntPtr
}
struct HBLUETOOTH_RADIO_FIND {
    Value : IntPtr
}
struct HANDLE_SDP_TYPE {
    Value : Int64
}
struct SDP_LARGE_INTEGER_16 {
    LowPart : Int64
    HighPart : Int64
}
struct SDP_ULARGE_INTEGER_16 {
    LowPart : Int64
    HighPart : Int64
}
struct NodeContainerType extends Int32 {
    static NodeContainerTypeSequence := 0
    static NodeContainerTypeAlternative := 1
}
struct SDP_TYPE extends Int32 {
    static SDP_TYPE_NIL := 0
    static SDP_TYPE_UINT := 1
    static SDP_TYPE_INT := 2
    static SDP_TYPE_UUID := 3
    static SDP_TYPE_STRING := 4
    static SDP_TYPE_BOOLEAN := 5
    static SDP_TYPE_SEQUENCE := 6
    static SDP_TYPE_ALTERNATIVE := 7
    static SDP_TYPE_URL := 8
    static SDP_TYPE_CONTAINER := 32
}
struct SDP_SPECIFICTYPE extends Int32 {
    static SDP_ST_NONE := 0
    static SDP_ST_UINT8 := 16
    static SDP_ST_UINT16 := 272
    static SDP_ST_UINT32 := 528
    static SDP_ST_UINT64 := 784
    static SDP_ST_UINT128 := 1040
    static SDP_ST_INT8 := 32
    static SDP_ST_INT16 := 288
    static SDP_ST_INT32 := 544
    static SDP_ST_INT64 := 800
    static SDP_ST_INT128 := 1056
    static SDP_ST_UUID16 := 304
    static SDP_ST_UUID32 := 544
    static SDP_ST_UUID128 := 1072
}
struct SdpAttributeRange {
    minAttribute : UInt16
    maxAttribute : UInt16
}
struct SdpQueryUuidUnion {
    union {
        uuid128 : GUID
        uuid32 : UInt32
        uuid16 : UInt16
    }
}
struct SdpQueryUuid {
    u : SdpQueryUuidUnion
    uuidType : UInt16
}
struct BTH_DEVICE_INFO {
    flags : UInt32
    address : Int64
    classOfDevice : UInt32
    name : CHAR[248]
}
struct BTH_RADIO_IN_RANGE {
    deviceInfo : BTH_DEVICE_INFO
    previousDeviceFlags : UInt32
}
struct BTH_L2CAP_EVENT_INFO {
    bthAddress : Int64
    psm : UInt16
    connected : UInt8
    initiated : UInt8
}
struct BTH_HCI_EVENT_INFO {
    bthAddress : Int64
    connectionType : UInt8
    connected : UInt8
}
struct IO_CAPABILITY extends Int32 {
    static IoCaps_DisplayOnly := 0
    static IoCaps_DisplayYesNo := 1
    static IoCaps_KeyboardOnly := 2
    static IoCaps_NoInputNoOutput := 3
    static IoCaps_Undefined := 255
}
struct AUTHENTICATION_REQUIREMENTS extends Int32 {
    static MITMProtectionNotRequired := 0
    static MITMProtectionRequired := 1
    static MITMProtectionNotRequiredBonding := 2
    static MITMProtectionRequiredBonding := 3
    static MITMProtectionNotRequiredGeneralBonding := 4
    static MITMProtectionRequiredGeneralBonding := 5
    static MITMProtectionNotDefined := 255
}
struct BLUETOOTH_ADDRESS {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ullLong : Int64
            rgBytes : UInt8[6]
        }
    }
}
struct BLUETOOTH_LOCAL_SERVICE_INFO {
    Enabled : BOOL
    btAddr : BLUETOOTH_ADDRESS
    szName : UInt16[256]
    szDeviceString : UInt16[256]
}
struct BLUETOOTH_FIND_RADIO_PARAMS {
    dwSize : UInt32
}
struct BLUETOOTH_RADIO_INFO {
    dwSize : UInt32
    address : BLUETOOTH_ADDRESS
    szName : UInt16[248]
    ulClassofDevice : UInt32
    lmpSubversion : UInt16
    manufacturer : UInt16
}
struct BLUETOOTH_DEVICE_INFO {
    dwSize : UInt32
    Address : BLUETOOTH_ADDRESS
    ulClassofDevice : UInt32
    fConnected : BOOL
    fRemembered : BOOL
    fAuthenticated : BOOL
    stLastSeen : SYSTEMTIME
    stLastUsed : SYSTEMTIME
    szName : UInt16[248]
}
struct BLUETOOTH_AUTHENTICATION_METHOD extends Int32 {
    static BLUETOOTH_AUTHENTICATION_METHOD_LEGACY := 1
    static BLUETOOTH_AUTHENTICATION_METHOD_OOB := 2
    static BLUETOOTH_AUTHENTICATION_METHOD_NUMERIC_COMPARISON := 3
    static BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY_NOTIFICATION := 4
    static BLUETOOTH_AUTHENTICATION_METHOD_PASSKEY := 5
}
struct BLUETOOTH_IO_CAPABILITY extends Int32 {
    static BLUETOOTH_IO_CAPABILITY_DISPLAYONLY := 0
    static BLUETOOTH_IO_CAPABILITY_DISPLAYYESNO := 1
    static BLUETOOTH_IO_CAPABILITY_KEYBOARDONLY := 2
    static BLUETOOTH_IO_CAPABILITY_NOINPUTNOOUTPUT := 3
    static BLUETOOTH_IO_CAPABILITY_UNDEFINED := 255
}
struct BLUETOOTH_AUTHENTICATION_REQUIREMENTS extends Int32 {
    static BLUETOOTH_MITM_ProtectionNotRequired := 0
    static BLUETOOTH_MITM_ProtectionRequired := 1
    static BLUETOOTH_MITM_ProtectionNotRequiredBonding := 2
    static BLUETOOTH_MITM_ProtectionRequiredBonding := 3
    static BLUETOOTH_MITM_ProtectionNotRequiredGeneralBonding := 4
    static BLUETOOTH_MITM_ProtectionRequiredGeneralBonding := 5
    static BLUETOOTH_MITM_ProtectionNotDefined := 255
}
struct BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS {
    deviceInfo : BLUETOOTH_DEVICE_INFO
    authenticationMethod : BLUETOOTH_AUTHENTICATION_METHOD
    ioCapability : BLUETOOTH_IO_CAPABILITY
    authenticationRequirements : BLUETOOTH_AUTHENTICATION_REQUIREMENTS
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Numeric_Value : UInt32
            Passkey : UInt32
        }
    }
}
struct BLUETOOTH_DEVICE_SEARCH_PARAMS {
    dwSize : UInt32
    fReturnAuthenticated : BOOL
    fReturnRemembered : BOOL
    fReturnUnknown : BOOL
    fReturnConnected : BOOL
    fIssueInquiry : BOOL
    cTimeoutMultiplier : UInt8
    hRadio : HANDLE
}
struct BLUETOOTH_COD_PAIRS {
    ulCODMask : UInt32
    pcszDescription : PWSTR
}
struct PFN_DEVICE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, BLUETOOTH_DEVICE_INFO.Ptr, BOOL]
}
struct BLUETOOTH_SELECT_DEVICE_PARAMS {
    dwSize : UInt32
    cNumOfClasses : UInt32
    prgClassOfDevices : BLUETOOTH_COD_PAIRS.Ptr
    pszInfo : PWSTR
    hwndParent : HWND
    fForceAuthentication : BOOL
    fShowAuthenticated : BOOL
    fShowRemembered : BOOL
    fShowUnknown : BOOL
    fAddNewDeviceWizard : BOOL
    fSkipServicesPage : BOOL
    pfnDeviceCallback : PFN_DEVICE_CALLBACK
    pvParam : Struct.Ptr
    cNumDevices : UInt32
    pDevices : BLUETOOTH_DEVICE_INFO.Ptr
}
struct BLUETOOTH_PIN_INFO {
    pin : UInt8[16]
    pinLength : UInt8
}
struct BLUETOOTH_OOB_DATA_INFO {
    C : UInt8[16]
    R : UInt8[16]
}
struct BLUETOOTH_NUMERIC_COMPARISON_INFO {
    NumericValue : UInt32
}
struct BLUETOOTH_PASSKEY_INFO {
    passkey : UInt32
}
struct PFN_AUTHENTICATION_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, BLUETOOTH_DEVICE_INFO.Ptr, BOOL]
}
struct PFN_AUTHENTICATION_CALLBACK_EX extends FunctionPointer {
    static Types := [Struct.Ptr, BLUETOOTH_AUTHENTICATION_CALLBACK_PARAMS.Ptr, BOOL]
}
struct BLUETOOTH_AUTHENTICATE_RESPONSE {
    bthAddressRemote : BLUETOOTH_ADDRESS
    authMethod : BLUETOOTH_AUTHENTICATION_METHOD
    Anonymous : this._Anonymous_e__Union
    negativeResponse : UInt8
    struct _Anonymous_e__Union {
        union {
            pinInfo : BLUETOOTH_PIN_INFO
            oobInfo : BLUETOOTH_OOB_DATA_INFO
            numericCompInfo : BLUETOOTH_NUMERIC_COMPARISON_INFO
            passkeyInfo : BLUETOOTH_PASSKEY_INFO
        }
    }
}
struct SDP_ELEMENT_DATA {
    type : SDP_TYPE
    specificType : SDP_SPECIFICTYPE
    data : this._data_e__Union
    struct _data_e__Union {
        union {
            int128 : SDP_LARGE_INTEGER_16
            int64 : Int64
            int32 : Int32
            int16 : Int16
            int8 : CHAR
            uint128 : SDP_ULARGE_INTEGER_16
            uint64 : Int64
            uint32 : UInt32
            uint16 : UInt16
            uint8 : UInt8
            booleanVal : UInt8
            uuid128 : GUID
            uuid32 : UInt32
            uuid16 : UInt16
            string : this._string_e__Struct
            url : this._url_e__Struct
            sequence : this._sequence_e__Struct
            alternative : this._alternative_e__Struct
        }
        struct _string_e__Struct {
            value : UInt8.Ptr
            length : UInt32
        }
        struct _url_e__Struct {
            value : UInt8.Ptr
            length : UInt32
        }
        struct _sequence_e__Struct {
            value : UInt8.Ptr
            length : UInt32
        }
        struct _alternative_e__Struct {
            value : UInt8.Ptr
            length : UInt32
        }
    }
}
struct SDP_STRING_TYPE_DATA {
    encoding : UInt16
    mibeNum : UInt16
    attributeId : UInt16
}
struct PFN_BLUETOOTH_ENUM_ATTRIBUTES_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt8.Ptr, UInt32, Struct.Ptr, BOOL]
}
struct BTH_LE_UUID {
    IsShortUuid : BOOLEAN
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            ShortUuid : UInt16
            LongUuid : GUID
        }
    }
}
struct BTH_LE_GATT_SERVICE {
    ServiceUuid : BTH_LE_UUID
    AttributeHandle : UInt16
}
struct BTH_LE_GATT_DESCRIPTOR_TYPE extends Int32 {
    static CharacteristicExtendedProperties := 0
    static CharacteristicUserDescription := 1
    static ClientCharacteristicConfiguration := 2
    static ServerCharacteristicConfiguration := 3
    static CharacteristicFormat := 4
    static CharacteristicAggregateFormat := 5
    static CustomDescriptor := 6
}
struct BTH_LE_GATT_CHARACTERISTIC {
    ServiceHandle : UInt16
    CharacteristicUuid : BTH_LE_UUID
    AttributeHandle : UInt16
    CharacteristicValueHandle : UInt16
    IsBroadcastable : BOOLEAN
    IsReadable : BOOLEAN
    IsWritable : BOOLEAN
    IsWritableWithoutResponse : BOOLEAN
    IsSignedWritable : BOOLEAN
    IsNotifiable : BOOLEAN
    IsIndicatable : BOOLEAN
    HasExtendedProperties : BOOLEAN
}
struct BTH_LE_GATT_CHARACTERISTIC_VALUE {
    DataSize : UInt32
    Data : UInt8[1]
}
struct BTH_LE_GATT_DESCRIPTOR {
    ServiceHandle : UInt16
    CharacteristicHandle : UInt16
    DescriptorType : BTH_LE_GATT_DESCRIPTOR_TYPE
    DescriptorUuid : BTH_LE_UUID
    AttributeHandle : UInt16
}
struct BTH_LE_GATT_DESCRIPTOR_VALUE {
    DescriptorType : BTH_LE_GATT_DESCRIPTOR_TYPE
    DescriptorUuid : BTH_LE_UUID
    Anonymous : this._Anonymous_e__Union
    DataSize : UInt32
    Data : UInt8[1]
    struct _Anonymous_e__Union {
        union {
            CharacteristicExtendedProperties : this._CharacteristicExtendedProperties_e__Struct
            ClientCharacteristicConfiguration : this._ClientCharacteristicConfiguration_e__Struct
            ServerCharacteristicConfiguration : this._ServerCharacteristicConfiguration_e__Struct
            CharacteristicFormat : this._CharacteristicFormat_e__Struct
        }
        struct _CharacteristicExtendedProperties_e__Struct {
            IsReliableWriteEnabled : BOOLEAN
            IsAuxiliariesWritable : BOOLEAN
        }
        struct _ClientCharacteristicConfiguration_e__Struct {
            IsSubscribeToNotification : BOOLEAN
            IsSubscribeToIndication : BOOLEAN
        }
        struct _ServerCharacteristicConfiguration_e__Struct {
            IsBroadcast : BOOLEAN
        }
        struct _CharacteristicFormat_e__Struct {
            Format : UInt8
            Exponent : UInt8
            Unit : BTH_LE_UUID
            NameSpace : UInt8
            Description : BTH_LE_UUID
        }
    }
}
struct BTH_LE_GATT_EVENT_TYPE extends Int32 {
    static CharacteristicValueChangedEvent := 0
}
struct PFNBLUETOOTH_GATT_EVENT_CALLBACK extends FunctionPointer {
    static Types := [BTH_LE_GATT_EVENT_TYPE, Struct.Ptr, Struct.Ptr, "Void"]
}
struct BLUETOOTH_GATT_VALUE_CHANGED_EVENT_REGISTRATION {
    NumCharacteristics : UInt16
    Characteristics : BTH_LE_GATT_CHARACTERISTIC[1]
}
struct BLUETOOTH_GATT_VALUE_CHANGED_EVENT {
    ChangedAttributeHandle : UInt16
    CharacteristicValueDataSize : IntPtr
    CharacteristicValue : BTH_LE_GATT_CHARACTERISTIC_VALUE.Ptr
}
struct SOCKADDR_BTH {
    addressFamily : UInt16
    btAddr : Int64
    serviceClassId : GUID
    port : UInt32
}
struct BTH_SET_SERVICE {
    pSdpVersion : UInt32.Ptr
    pRecordHandle : HANDLE.Ptr
    fCodService : UInt32
    Reserved : UInt32[5]
    ulRecordLength : UInt32
    pRecord : UInt8[1]
}
struct BTH_QUERY_DEVICE {
    LAP : UInt32
    length : UInt8
}
struct BTH_QUERY_SERVICE {
    type : UInt32
    serviceHandle : UInt32
    uuids : SdpQueryUuid[12]
    numRange : UInt32
    pRange : SdpAttributeRange[1]
}
struct RFCOMM_MSC_DATA {
    Signals : UInt8
    Break : UInt8
}
struct RFCOMM_RLS_DATA {
    LineStatus : UInt8
}
struct RFCOMM_RPN_DATA {
    Baud : UInt8
    Data : UInt8
    FlowControl : UInt8
    XonChar : UInt8
    XoffChar : UInt8
    ParameterMask1 : UInt8
    ParameterMask2 : UInt8
}
struct RFCOMM_COMMAND {
    CmdType : UInt32
    Data : this._Data_e__Union
    struct _Data_e__Union {
        union {
            MSC : RFCOMM_MSC_DATA
            RLS : RFCOMM_RLS_DATA
            RPN : RFCOMM_RPN_DATA
        }
    }
}
struct BTH_PING_REQ {
    btAddr : Int64
    dataLen : UInt8
    data : UInt8[44]
}
struct BTH_PING_RSP {
    dataLen : UInt8
    data : UInt8[44]
}
struct BTH_INFO_REQ {
    btAddr : Int64
    infoType : UInt16
}
struct BTH_INFO_RSP {
    result : UInt16
    dataLen : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            connectionlessMTU : UInt16
            data : UInt8[44]
        }
    }
}
