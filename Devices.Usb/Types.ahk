#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HANDLE, PWSTR}

struct WINUSB_PIPE_POLICY extends UInt32 {
    static SHORT_PACKET_TERMINATE := 1
    static AUTO_CLEAR_STALL := 2
    static PIPE_TRANSFER_TIMEOUT := 3
    static IGNORE_SHORT_PACKETS := 4
    static ALLOW_PARTIAL_READS := 5
    static AUTO_FLUSH := 6
    static RAW_IO := 7
    static MAXIMUM_TRANSFER_SIZE := 8
    static RESET_PIPE_ON_RESUME := 9
}
struct WINUSB_POWER_POLICY extends UInt32 {
    static AUTO_SUSPEND := 129
    static SUSPEND_DELAY := 131
}
struct WINUSB_INTERFACE_HANDLE {
    Value : Struct.Ptr
}
struct USB_CHANGE_REGISTRATION_HANDLE {
    Value : Struct.Ptr
}
struct USB_DEVICE_SPEED extends Int32 {
    static UsbLowSpeed := 0
    static UsbFullSpeed := 1
    static UsbHighSpeed := 2
    static UsbSuperSpeed := 3
}
struct USB_DEVICE_TYPE extends Int32 {
    static Usb11Device := 0
    static Usb20Device := 1
}
struct BM_REQUEST_TYPE {
    union {
        s : this._BM
        B : UInt8
    }
    struct _BM {
        _bitfield : UInt8
    }
}
struct USB_DEFAULT_PIPE_SETUP_PACKET {
    bmRequestType : BM_REQUEST_TYPE
    bRequest : UInt8
    wValue : this._wValue
    wIndex : this._wIndex
    wLength : UInt16
    struct _wValue {
        union {
            Anonymous : this._Anonymous_e__Struct
            W : UInt16
        }
        struct _Anonymous_e__Struct {
            LowByte : UInt8
            HiByte : UInt8
        }
    }
    struct _wIndex {
        union {
            Anonymous : this._Anonymous_e__Struct
            W : UInt16
        }
        struct _Anonymous_e__Struct {
            LowByte : UInt8
            HiByte : UInt8
        }
    }
}
struct USB_DEVICE_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_INTERFACE_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_ENDPOINT_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_COMMON_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
}
struct USB_DEVICE_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bcdUSB : UInt16
    bDeviceClass : UInt8
    bDeviceSubClass : UInt8
    bDeviceProtocol : UInt8
    bMaxPacketSize0 : UInt8
    idVendor : UInt16
    idProduct : UInt16
    bcdDevice : UInt16
    iManufacturer : UInt8
    iProduct : UInt8
    iSerialNumber : UInt8
    bNumConfigurations : UInt8
}
struct USB_DEVICE_QUALIFIER_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bcdUSB : UInt16
    bDeviceClass : UInt8
    bDeviceSubClass : UInt8
    bDeviceProtocol : UInt8
    bMaxPacketSize0 : UInt8
    bNumConfigurations : UInt8
    bReserved : UInt8
}
struct USB_BOS_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    wTotalLength : UInt16
    bNumDeviceCaps : UInt8
}
struct USB_DEVICE_CAPABILITY_USB20_EXTENSION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bmAttributes : this._bmAttributes_e__Union
    struct _bmAttributes_e__Union {
        union {
            AsUlong : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct USB_DEVICE_CAPABILITY_POWER_DELIVERY_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bReserved : UInt8
    bmAttributes : this._bmAttributes_e__Union
    bmProviderPorts : UInt16
    bmConsumerPorts : UInt16
    bcdBCVersion : UInt16
    bcdPDVersion : UInt16
    bcdUSBTypeCVersion : UInt16
    struct _bmAttributes_e__Union {
        union {
            AsUlong : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct USB_DEVICE_CAPABILITY_PD_CONSUMER_PORT_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bReserved : UInt8
    bmCapabilities : this._bmCapabilities_e__Union
    wMinVoltage : UInt16
    wMaxVoltage : UInt16
    wReserved : UInt16
    dwMaxOperatingPower : UInt32
    dwMaxPeakPower : UInt32
    dwMaxPeakPowerTime : UInt32
    struct _bmCapabilities_e__Union {
        union {
            AsUshort : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct USB_DEVICE_CAPABILITY_SUPERSPEED_USB_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bmAttributes : UInt8
    wSpeedsSupported : UInt16
    bFunctionalitySupport : UInt8
    bU1DevExitLat : UInt8
    wU2DevExitLat : UInt16
}
struct USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED {
    union {
        AsUlong32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_USB_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bReserved : UInt8
    bmAttributes : this._bmAttributes_e__Union
    wFunctionalitySupport : this._wFunctionalitySupport_e__Union
    wReserved : UInt16
    bmSublinkSpeedAttr : USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED[1]
    struct _bmAttributes_e__Union {
        union {
            AsUlong : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
    struct _wFunctionalitySupport_e__Union {
        union {
            AsUshort : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct USB_DEVICE_CAPABILITY_CONTAINER_ID_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bReserved : UInt8
    ContainerID : UInt8[16]
}
struct USB_DEVICE_CAPABILITY_PLATFORM_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bReserved : UInt8
    PlatformCapabilityUuid : GUID
    CapabililityData : UInt8[1]
}
struct USB_DEVICE_CAPABILITY_BILLBOARD_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    iAddtionalInfoURL : UInt8
    bNumberOfAlternateModes : UInt8
    bPreferredAlternateMode : UInt8
    VconnPower : this._VconnPower_e__Union
    bmConfigured : UInt8[32]
    bReserved : UInt32
    AlternateMode : this._Anonymous_e__Struct[1]
    struct _VconnPower_e__Union {
        union {
            AsUshort : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
    struct _Anonymous_e__Struct {
        wSVID : UInt16
        bAlternateMode : UInt8
        iAlternateModeSetting : UInt8
    }
}
struct USB_DEVICE_CAPABILITY_FIRMWARE_STATUS_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
    bcdDescriptorVersion : UInt8
    bmAttributes : this._bmAttributes_e__Union
    struct _bmAttributes_e__Union {
        union {
            AsUlong : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct USB_DEVICE_CAPABILITY_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bDevCapabilityType : UInt8
}
struct USB_CONFIGURATION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    wTotalLength : UInt16
    bNumInterfaces : UInt8
    bConfigurationValue : UInt8
    iConfiguration : UInt8
    bmAttributes : UInt8
    MaxPower : UInt8
}
struct USB_INTERFACE_ASSOCIATION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bFirstInterface : UInt8
    bInterfaceCount : UInt8
    bFunctionClass : UInt8
    bFunctionSubClass : UInt8
    bFunctionProtocol : UInt8
    iFunction : UInt8
}
struct USB_INTERFACE_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bInterfaceNumber : UInt8
    bAlternateSetting : UInt8
    bNumEndpoints : UInt8
    bInterfaceClass : UInt8
    bInterfaceSubClass : UInt8
    bInterfaceProtocol : UInt8
    iInterface : UInt8
}
struct USB_ENDPOINT_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bEndpointAddress : UInt8
    bmAttributes : UInt8
    wMaxPacketSize : UInt16
    bInterval : UInt8
}
struct USB_HIGH_SPEED_MAXPACKET {
    union {
        us : UInt16
    }
    struct _MP {
        _bitfield : UInt16
    }
}
struct USB_STRING_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bString : UInt16[1]
}
struct USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bMaxBurst : UInt8
    bmAttributes : this._bmAttributes_e__Union
    wBytesPerInterval : UInt16
    struct _bmAttributes_e__Union {
        union {
            AsUchar : UInt8
            Bulk : this._Bulk_e__Struct
            Isochronous : this._Isochronous_e__Struct
        }
        struct _Bulk_e__Struct {
            _bitfield : UInt8
        }
        struct _Isochronous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct USB_SUPERSPEEDPLUS_ISOCH_ENDPOINT_COMPANION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    wReserved : UInt16
    dwBytesPerInterval : UInt32
}
struct EUSB2_ISOCH_ENDPOINT_COMPANION_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    wMaxPacketSize : UInt16
    dwBytesPerInterval : UInt32
}
struct USB_HUB_DESCRIPTOR {
    bDescriptorLength : UInt8
    bDescriptorType : UInt8
    bNumberOfPorts : UInt8
    wHubCharacteristics : UInt16
    bPowerOnToPowerGood : UInt8
    bHubControlCurrent : UInt8
    bRemoveAndPowerMask : UInt8[64]
}
struct USB_30_HUB_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bNumberOfPorts : UInt8
    wHubCharacteristics : UInt16
    bPowerOnToPowerGood : UInt8
    bHubControlCurrent : UInt8
    bHubHdrDecLat : UInt8
    wHubDelay : UInt16
    DeviceRemovable : UInt16
}
struct USB_HUB_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_HUB_CHANGE {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_HUB_STATUS_AND_CHANGE {
    union {
        AsUlong32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        HubStatus : USB_HUB_STATUS
        HubChange : USB_HUB_CHANGE
    }
}
struct USB_20_PORT_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_20_PORT_CHANGE {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_30_PORT_STATUS {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_30_PORT_CHANGE {
    union {
        AsUshort16 : UInt16
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct USB_PORT_STATUS {
    union {
        AsUshort16 : UInt16
        Usb20PortStatus : USB_20_PORT_STATUS
        Usb30PortStatus : USB_30_PORT_STATUS
    }
}
struct USB_PORT_CHANGE {
    union {
        AsUshort16 : UInt16
        Usb20PortChange : USB_20_PORT_CHANGE
        Usb30PortChange : USB_30_PORT_CHANGE
    }
}
struct USB_PORT_EXT_STATUS {
    union {
        AsUlong32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_PORT_STATUS_AND_CHANGE {
    union {
        AsUlong32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        PortStatus : USB_PORT_STATUS
        PortChange : USB_PORT_CHANGE
    }
}
struct USB_PORT_EXT_STATUS_AND_CHANGE {
    union {
        AsUlong64 : Int64
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        PortStatusChange : USB_PORT_STATUS_AND_CHANGE
        PortExtStatus : USB_PORT_EXT_STATUS
    }
}
struct USB_HUB_30_PORT_REMOTE_WAKE_MASK {
    union {
        AsUchar8 : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct USB_FUNCTION_SUSPEND_OPTIONS {
    union {
        AsUchar : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct USB_CONFIGURATION_POWER_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    SelfPowerConsumedD0 : UInt8[3]
    bPowerSummaryId : UInt8
    bBusPowerSavingD1 : UInt8
    bSelfPowerSavingD1 : UInt8
    bBusPowerSavingD2 : UInt8
    bSelfPowerSavingD2 : UInt8
    bBusPowerSavingD3 : UInt8
    bSelfPowerSavingD3 : UInt8
    TransitionTimeFromD1 : UInt16
    TransitionTimeFromD2 : UInt16
    TransitionTimeFromD3 : UInt16
}
struct USB_INTERFACE_POWER_DESCRIPTOR {
    bLength : UInt8
    bDescriptorType : UInt8
    bmCapabilitiesFlags : UInt8
    bBusPowerSavingD1 : UInt8
    bSelfPowerSavingD1 : UInt8
    bBusPowerSavingD2 : UInt8
    bSelfPowerSavingD2 : UInt8
    bBusPowerSavingD3 : UInt8
    bSelfPowerSavingD3 : UInt8
    TransitionTimeFromD1 : UInt16
    TransitionTimeFromD2 : UInt16
    TransitionTimeFromD3 : UInt16
}
struct USB_CONTROLLER_FLAVOR extends Int32 {
    static USB_HcGeneric := 0
    static OHCI_Generic := 100
    static OHCI_Hydra := 101
    static OHCI_NEC := 102
    static UHCI_Generic := 200
    static UHCI_Piix4 := 201
    static UHCI_Piix3 := 202
    static UHCI_Ich2 := 203
    static UHCI_Reserved204 := 204
    static UHCI_Ich1 := 205
    static UHCI_Ich3m := 206
    static UHCI_Ich4 := 207
    static UHCI_Ich5 := 208
    static UHCI_Ich6 := 209
    static UHCI_Intel := 249
    static UHCI_VIA := 250
    static UHCI_VIA_x01 := 251
    static UHCI_VIA_x02 := 252
    static UHCI_VIA_x03 := 253
    static UHCI_VIA_x04 := 254
    static UHCI_VIA_x0E_FIFO := 264
    static EHCI_Generic := 1000
    static EHCI_NEC := 2000
    static EHCI_Lucent := 3000
    static EHCI_NVIDIA_Tegra2 := 4000
    static EHCI_NVIDIA_Tegra3 := 4001
    static EHCI_Intel_Medfield := 5001
}
struct USBD_VERSION_INFORMATION {
    USBDI_Version : UInt32
    Supported_USB_Version : UInt32
}
struct USBD_PIPE_TYPE extends Int32 {
    static UsbdPipeTypeControl := 0
    static UsbdPipeTypeIsochronous := 1
    static UsbdPipeTypeBulk := 2
    static UsbdPipeTypeInterrupt := 3
}
struct USBD_DEVICE_INFORMATION {
    OffsetNext : UInt32
    UsbdDeviceHandle : Struct.Ptr
    DeviceDescriptor : USB_DEVICE_DESCRIPTOR
}
struct USBD_PIPE_INFORMATION {
    MaximumPacketSize : UInt16
    EndpointAddress : UInt8
    Interval : UInt8
    PipeType : USBD_PIPE_TYPE
    PipeHandle : Struct.Ptr
    MaximumTransferSize : UInt32
    PipeFlags : UInt32
}
struct USBD_ENDPOINT_OFFLOAD_MODE extends Int32 {
    static UsbdEndpointOffloadModeNotSupported := 0
    static UsbdEndpointOffloadSoftwareAssisted := 1
    static UsbdEndpointOffloadHardwareAssisted := 2
}
struct USBD_ENDPOINT_OFFLOAD_INFORMATION_V1 {
    Size : UInt32
    EndpointAddress : UInt16
    ResourceId : UInt32
    Mode : USBD_ENDPOINT_OFFLOAD_MODE
    _bitfield1 : UInt32
    _bitfield2 : UInt32
    TransferSegmentLA : Int64
    TransferSegmentVA : Struct.Ptr
    TransferRingSize : IntPtr
    TransferRingInitialCycleBit : UInt32
    MessageNumber : UInt32
    EventRingSegmentLA : Int64
    EventRingSegmentVA : Struct.Ptr
    EventRingSize : IntPtr
    EventRingInitialCycleBit : UInt32
}
struct USBD_ENDPOINT_OFFLOAD_INFORMATION {
    Size : UInt32
    EndpointAddress : UInt16
    ResourceId : UInt32
    Mode : USBD_ENDPOINT_OFFLOAD_MODE
    _bitfield1 : UInt32
    _bitfield2 : UInt32
    TransferSegmentLA : Int64
    TransferSegmentVA : Struct.Ptr
    TransferRingSize : IntPtr
    TransferRingInitialCycleBit : UInt32
    MessageNumber : UInt32
    EventRingSegmentLA : Int64
    EventRingSegmentVA : Struct.Ptr
    EventRingSize : IntPtr
    EventRingInitialCycleBit : UInt32
    ClientTransferRingSegmentPAIn : Int64
    ClientTransferRingSizeIn : IntPtr
    ClientDataBufferPAIn : Int64
    ClientDataBufferSizeIn : IntPtr
    ClientDataBufferLAOut : Int64
    ClientDataBufferVAOut : Struct.Ptr
}
struct USBD_INTERFACE_INFORMATION {
    Length : UInt16
    InterfaceNumber : UInt8
    AlternateSetting : UInt8
    Class : UInt8
    SubClass : UInt8
    Protocol : UInt8
    Reserved : UInt8
    InterfaceHandle : Struct.Ptr
    NumberOfPipes : UInt32
    Pipes : USBD_PIPE_INFORMATION[1]
}
struct URB_HCD_AREA {
    Reserved8 : Struct.Ptr[8]
}
struct URB_HEADER {
    Length : UInt16
    Function : UInt16
    Status : Int32
    UsbdDeviceHandle : Struct.Ptr
    UsbdFlags : UInt32
}
struct URB_SELECT_INTERFACE {
    Hdr : URB_HEADER
    ConfigurationHandle : Struct.Ptr
    Interface : USBD_INTERFACE_INFORMATION
}
struct URB_SELECT_CONFIGURATION {
    Hdr : URB_HEADER
    ConfigurationDescriptor : USB_CONFIGURATION_DESCRIPTOR.Ptr
    ConfigurationHandle : Struct.Ptr
    Interface : USBD_INTERFACE_INFORMATION
}
struct URB_PIPE_REQUEST {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    Reserved : UInt32
}
struct URB_FRAME_LENGTH_CONTROL {
    Hdr : URB_HEADER
}
struct URB_GET_FRAME_LENGTH {
    Hdr : URB_HEADER
    FrameLength : UInt32
    FrameNumber : UInt32
}
struct URB_SET_FRAME_LENGTH {
    Hdr : URB_HEADER
    FrameLengthDelta : Int32
}
struct URB_GET_CURRENT_FRAME_NUMBER {
    Hdr : URB_HEADER
    FrameNumber : UInt32
}
struct URB_CONTROL_DESCRIPTOR_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved0 : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    Reserved1 : UInt16
    Index : UInt8
    DescriptorType : UInt8
    LanguageId : UInt16
    Reserved2 : UInt16
}
struct URB_CONTROL_GET_STATUS_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved0 : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    Reserved1 : UInt8[4]
    Index : UInt16
    Reserved2 : UInt16
}
struct URB_CONTROL_FEATURE_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved2 : UInt32
    Reserved3 : UInt32
    Reserved4 : Struct.Ptr
    Reserved5 : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    Reserved0 : UInt16
    FeatureSelector : UInt16
    Index : UInt16
    Reserved1 : UInt16
}
struct URB_CONTROL_VENDOR_OR_CLASS_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    TransferFlags : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    RequestTypeReservedBits : UInt8
    Request : UInt8
    Value : UInt16
    Index : UInt16
    Reserved1 : UInt16
}
struct URB_CONTROL_GET_INTERFACE_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved0 : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    Reserved1 : UInt8[4]
    Interface : UInt16
    Reserved2 : UInt16
}
struct URB_CONTROL_GET_CONFIGURATION_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved0 : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    Reserved1 : UInt8[8]
}
struct OS_STRING {
    bLength : UInt8
    bDescriptorType : UInt8
    MicrosoftString : UInt16[7]
    bVendorCode : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bPad : UInt8
            bFlags : UInt8
        }
    }
}
struct URB_OS_FEATURE_DESCRIPTOR_REQUEST {
    Hdr : URB_HEADER
    Reserved : Struct.Ptr
    Reserved0 : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    _bitfield : UInt8
    Reserved2 : UInt8
    InterfaceNumber : UInt8
    MS_PageIndex : UInt8
    MS_FeatureDescriptorIndex : UInt16
    Reserved3 : UInt16
}
struct URB_CONTROL_TRANSFER {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    TransferFlags : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    SetupPacket : UInt8[8]
}
struct URB_CONTROL_TRANSFER_EX {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    TransferFlags : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    Timeout : UInt32
    hca : URB_HCD_AREA
    SetupPacket : UInt8[8]
}
struct URB_BULK_OR_INTERRUPT_TRANSFER {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    TransferFlags : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
}
struct USBD_ISO_PACKET_DESCRIPTOR {
    Offset : UInt32
    Length : UInt32
    Status : Int32
}
struct URB_ISOCH_TRANSFER {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    TransferFlags : UInt32
    TransferBufferLength : UInt32
    TransferBuffer : Struct.Ptr
    TransferBufferMDL : Struct.Ptr
    UrbLink : URB.Ptr
    hca : URB_HCD_AREA
    StartFrame : UInt32
    NumberOfPackets : UInt32
    ErrorCount : UInt32
    IsoPacket : USBD_ISO_PACKET_DESCRIPTOR[1]
}
struct USBD_STREAM_INFORMATION {
    PipeHandle : Struct.Ptr
    StreamID : UInt32
    MaximumTransferSize : UInt32
    PipeFlags : UInt32
}
struct URB_OPEN_STATIC_STREAMS {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    NumberOfStreams : UInt32
    StreamInfoVersion : UInt16
    StreamInfoSize : UInt16
    Streams : USBD_STREAM_INFORMATION.Ptr
}
struct URB_GET_ISOCH_PIPE_TRANSFER_PATH_DELAYS {
    Hdr : URB_HEADER
    PipeHandle : Struct.Ptr
    MaximumSendPathDelayInMilliSeconds : UInt32
    MaximumCompletionPathDelayInMilliSeconds : UInt32
}
struct URB {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            UrbHeader : URB_HEADER
            UrbSelectInterface : URB_SELECT_INTERFACE
            UrbSelectConfiguration : URB_SELECT_CONFIGURATION
            UrbPipeRequest : URB_PIPE_REQUEST
            UrbFrameLengthControl : URB_FRAME_LENGTH_CONTROL
            UrbGetFrameLength : URB_GET_FRAME_LENGTH
            UrbSetFrameLength : URB_SET_FRAME_LENGTH
            UrbGetCurrentFrameNumber : URB_GET_CURRENT_FRAME_NUMBER
            UrbControlTransfer : URB_CONTROL_TRANSFER
            UrbControlTransferEx : URB_CONTROL_TRANSFER_EX
            UrbBulkOrInterruptTransfer : URB_BULK_OR_INTERRUPT_TRANSFER
            UrbIsochronousTransfer : URB_ISOCH_TRANSFER
            UrbControlDescriptorRequest : URB_CONTROL_DESCRIPTOR_REQUEST
            UrbControlGetStatusRequest : URB_CONTROL_GET_STATUS_REQUEST
            UrbControlFeatureRequest : URB_CONTROL_FEATURE_REQUEST
            UrbControlVendorClassRequest : URB_CONTROL_VENDOR_OR_CLASS_REQUEST
            UrbControlGetInterfaceRequest : URB_CONTROL_GET_INTERFACE_REQUEST
            UrbControlGetConfigurationRequest : URB_CONTROL_GET_CONFIGURATION_REQUEST
            UrbOSFeatureDescriptorRequest : URB_OS_FEATURE_DESCRIPTOR_REQUEST
            UrbOpenStaticStreams : URB_OPEN_STATIC_STREAMS
            UrbGetIsochPipeTransferPathDelays : URB_GET_ISOCH_PIPE_TRANSFER_PATH_DELAYS
        }
    }
}
struct USB_IDLE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct USB_IDLE_CALLBACK_INFO {
    IdleCallback : USB_IDLE_CALLBACK
    IdleContext : Struct.Ptr
}
struct USB_USER_ERROR_CODE extends Int32 {
    static UsbUserSuccess := 0
    static UsbUserNotSupported := 1
    static UsbUserInvalidRequestCode := 2
    static UsbUserFeatureDisabled := 3
    static UsbUserInvalidHeaderParameter := 4
    static UsbUserInvalidParameter := 5
    static UsbUserMiniportError := 6
    static UsbUserBufferTooSmall := 7
    static UsbUserErrorNotMapped := 8
    static UsbUserDeviceNotStarted := 9
    static UsbUserNoDeviceConnected := 10
}
struct USBUSER_REQUEST_HEADER {
    UsbUserRequest : UInt32
    UsbUserStatusCode : USB_USER_ERROR_CODE
    RequestBufferLength : UInt32
    ActualBufferLength : UInt32
}
struct PACKET_PARAMETERS {
    DeviceAddress : UInt8
    EndpointAddress : UInt8
    MaximumPacketSize : UInt16
    Timeout : UInt32
    Flags : UInt32
    DataLength : UInt32
    HubDeviceAddress : UInt16
    PortTTNumber : UInt16
    ErrorCount : UInt8
    Pad : UInt8[3]
    UsbdStatusCode : Int32
    Data : UInt8[4]
}
struct USBUSER_SEND_ONE_PACKET {
    Header : USBUSER_REQUEST_HEADER
    PacketParameters : PACKET_PARAMETERS
}
struct RAW_RESET_PORT_PARAMETERS {
    PortNumber : UInt16
    PortStatus : UInt16
}
struct USBUSER_RAW_RESET_ROOT_PORT {
    Header : USBUSER_REQUEST_HEADER
    Parameters : RAW_RESET_PORT_PARAMETERS
}
struct RAW_ROOTPORT_FEATURE {
    PortNumber : UInt16
    PortFeature : UInt16
    PortStatus : UInt16
}
struct USBUSER_ROOTPORT_FEATURE_REQUEST {
    Header : USBUSER_REQUEST_HEADER
    Parameters : RAW_ROOTPORT_FEATURE
}
struct RAW_ROOTPORT_PARAMETERS {
    PortNumber : UInt16
    PortStatus : UInt16
}
struct USBUSER_ROOTPORT_PARAMETERS {
    Header : USBUSER_REQUEST_HEADER
    Parameters : RAW_ROOTPORT_PARAMETERS
}
struct USB_CONTROLLER_INFO_0 {
    PciVendorId : UInt32
    PciDeviceId : UInt32
    PciRevision : UInt32
    NumberOfRootPorts : UInt32
    ControllerFlavor : USB_CONTROLLER_FLAVOR
    HcFeatureFlags : UInt32
}
struct USBUSER_CONTROLLER_INFO_0 {
    Header : USBUSER_REQUEST_HEADER
    Info0 : USB_CONTROLLER_INFO_0
}
struct USB_UNICODE_NAME {
    Length : UInt32
    String : UInt16[1]
}
struct USBUSER_CONTROLLER_UNICODE_NAME {
    Header : USBUSER_REQUEST_HEADER
    UnicodeName : USB_UNICODE_NAME
}
struct USB_PASS_THRU_PARAMETERS {
    FunctionGUID : GUID
    ParameterLength : UInt32
    Parameters : UInt8[4]
}
struct USBUSER_PASS_THRU_REQUEST {
    Header : USBUSER_REQUEST_HEADER
    PassThru : USB_PASS_THRU_PARAMETERS
}
struct WDMUSB_POWER_STATE extends Int32 {
    static WdmUsbPowerNotMapped := 0
    static WdmUsbPowerSystemUnspecified := 100
    static WdmUsbPowerSystemWorking := 101
    static WdmUsbPowerSystemSleeping1 := 102
    static WdmUsbPowerSystemSleeping2 := 103
    static WdmUsbPowerSystemSleeping3 := 104
    static WdmUsbPowerSystemHibernate := 105
    static WdmUsbPowerSystemShutdown := 106
    static WdmUsbPowerDeviceUnspecified := 200
    static WdmUsbPowerDeviceD0 := 201
    static WdmUsbPowerDeviceD1 := 202
    static WdmUsbPowerDeviceD2 := 203
    static WdmUsbPowerDeviceD3 := 204
}
struct USB_POWER_INFO {
    SystemState : WDMUSB_POWER_STATE
    HcDevicePowerState : WDMUSB_POWER_STATE
    HcDeviceWake : WDMUSB_POWER_STATE
    HcSystemWake : WDMUSB_POWER_STATE
    RhDevicePowerState : WDMUSB_POWER_STATE
    RhDeviceWake : WDMUSB_POWER_STATE
    RhSystemWake : WDMUSB_POWER_STATE
    LastSystemSleepState : WDMUSB_POWER_STATE
    CanWakeup : BOOLEAN
    IsPowered : BOOLEAN
}
struct USBUSER_POWER_INFO_REQUEST {
    Header : USBUSER_REQUEST_HEADER
    PowerInformation : USB_POWER_INFO
}
struct USB_OPEN_RAW_DEVICE_PARAMETERS {
    PortStatus : UInt16
    MaxPacketEp0 : UInt16
}
struct USBUSER_OPEN_RAW_DEVICE {
    Header : USBUSER_REQUEST_HEADER
    Parameters : USB_OPEN_RAW_DEVICE_PARAMETERS
}
struct USB_CLOSE_RAW_DEVICE_PARAMETERS {
    xxx : UInt32
}
struct USBUSER_CLOSE_RAW_DEVICE {
    Header : USBUSER_REQUEST_HEADER
    Parameters : USB_CLOSE_RAW_DEVICE_PARAMETERS
}
struct USB_SEND_RAW_COMMAND_PARAMETERS {
    Usb_bmRequest : UInt8
    Usb_bRequest : UInt8
    Usb_wVlaue : UInt16
    Usb_wIndex : UInt16
    Usb_wLength : UInt16
    DeviceAddress : UInt16
    MaximumPacketSize : UInt16
    Timeout : UInt32
    DataLength : UInt32
    UsbdStatusCode : Int32
    Data : UInt8[4]
}
struct USBUSER_SEND_RAW_COMMAND {
    Header : USBUSER_REQUEST_HEADER
    Parameters : USB_SEND_RAW_COMMAND_PARAMETERS
}
struct USB_BANDWIDTH_INFO {
    DeviceCount : UInt32
    TotalBusBandwidth : UInt32
    Total32secBandwidth : UInt32
    AllocedBulkAndControl : UInt32
    AllocedIso : UInt32
    AllocedInterrupt_1ms : UInt32
    AllocedInterrupt_2ms : UInt32
    AllocedInterrupt_4ms : UInt32
    AllocedInterrupt_8ms : UInt32
    AllocedInterrupt_16ms : UInt32
    AllocedInterrupt_32ms : UInt32
}
struct USBUSER_BANDWIDTH_INFO_REQUEST {
    Header : USBUSER_REQUEST_HEADER
    BandwidthInformation : USB_BANDWIDTH_INFO
}
struct USB_BUS_STATISTICS_0 {
    DeviceCount : UInt32
    CurrentSystemTime : Int64
    CurrentUsbFrame : UInt32
    BulkBytes : UInt32
    IsoBytes : UInt32
    InterruptBytes : UInt32
    ControlDataBytes : UInt32
    PciInterruptCount : UInt32
    HardResetCount : UInt32
    WorkerSignalCount : UInt32
    CommonBufferBytes : UInt32
    WorkerIdleTimeMs : UInt32
    RootHubEnabled : BOOLEAN
    RootHubDevicePowerState : UInt8
    Unused : UInt8
    NameIndex : UInt8
}
struct USBUSER_BUS_STATISTICS_0_REQUEST {
    Header : USBUSER_REQUEST_HEADER
    BusStatistics0 : USB_BUS_STATISTICS_0
}
struct USB_DRIVER_VERSION_PARAMETERS {
    DriverTrackingCode : UInt32
    USBDI_Version : UInt32
    USBUSER_Version : UInt32
    CheckedPortDriver : BOOLEAN
    CheckedMiniportDriver : BOOLEAN
    USB_Version : UInt16
}
struct USBUSER_GET_DRIVER_VERSION {
    Header : USBUSER_REQUEST_HEADER
    Parameters : USB_DRIVER_VERSION_PARAMETERS
}
struct USB_USB2HW_VERSION_PARAMETERS {
    Usb2HwRevision : UInt8
}
struct USBUSER_GET_USB2HW_VERSION {
    Header : USBUSER_REQUEST_HEADER
    Parameters : USB_USB2HW_VERSION_PARAMETERS
}
struct USBUSER_REFRESH_HCT_REG {
    Header : USBUSER_REQUEST_HEADER
    Flags : UInt32
}
struct USBFN_EVENT extends Int32 {
    static UsbfnEventMinimum := 0
    static UsbfnEventAttach := 1
    static UsbfnEventReset := 2
    static UsbfnEventDetach := 3
    static UsbfnEventSuspend := 4
    static UsbfnEventResume := 5
    static UsbfnEventSetupPacket := 6
    static UsbfnEventConfigured := 7
    static UsbfnEventUnConfigured := 8
    static UsbfnEventPortType := 9
    static UsbfnEventBusTearDown := 10
    static UsbfnEventSetInterface := 11
    static UsbfnEventMaximum := 12
}
struct USBFN_PORT_TYPE extends Int32 {
    static UsbfnUnknownPort := 0
    static UsbfnStandardDownstreamPort := 1
    static UsbfnChargingDownstreamPort := 2
    static UsbfnDedicatedChargingPort := 3
    static UsbfnInvalidDedicatedChargingPort := 4
    static UsbfnProprietaryDedicatedChargingPort := 5
    static UsbfnPortTypeMaximum := 6
}
struct USBFN_BUS_SPEED extends Int32 {
    static UsbfnBusSpeedLow := 0
    static UsbfnBusSpeedFull := 1
    static UsbfnBusSpeedHigh := 2
    static UsbfnBusSpeedSuper := 3
    static UsbfnBusSpeedMaximum := 4
}
struct USBFN_DIRECTION extends Int32 {
    static UsbfnDirectionMinimum := 0
    static UsbfnDirectionIn := 1
    static UsbfnDirectionOut := 2
    static UsbfnDirectionTx := 1
    static UsbfnDirectionRx := 2
    static UsbfnDirectionMaximum := 3
}
struct USBFN_DEVICE_STATE extends Int32 {
    static UsbfnDeviceStateMinimum := 0
    static UsbfnDeviceStateAttached := 1
    static UsbfnDeviceStateDefault := 2
    static UsbfnDeviceStateDetached := 3
    static UsbfnDeviceStateAddressed := 4
    static UsbfnDeviceStateConfigured := 5
    static UsbfnDeviceStateSuspended := 6
    static UsbfnDeviceStateStateMaximum := 7
}
struct ALTERNATE_INTERFACE {
    InterfaceNumber : UInt16
    AlternateInterfaceNumber : UInt16
}
struct USBFN_NOTIFICATION {
    Event : USBFN_EVENT
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            BusSpeed : USBFN_BUS_SPEED
            SetupPacket : USB_DEFAULT_PIPE_SETUP_PACKET
            ConfigurationValue : UInt16
            PortType : USBFN_PORT_TYPE
            AlternateInterface : ALTERNATE_INTERFACE
        }
    }
}
struct USBFN_PIPE_INFORMATION {
    EpDesc : USB_ENDPOINT_DESCRIPTOR
    PipeId : UInt32
}
struct USBFN_CLASS_INTERFACE {
    InterfaceNumber : UInt8
    PipeCount : UInt8
    PipeArr : USBFN_PIPE_INFORMATION[16]
}
struct USBFN_CLASS_INFORMATION_PACKET {
    FullSpeedClassInterface : USBFN_CLASS_INTERFACE
    HighSpeedClassInterface : USBFN_CLASS_INTERFACE
    InterfaceName : UInt16[40]
    InterfaceGuid : UInt16[39]
    HasInterfaceGuid : BOOLEAN
    SuperSpeedClassInterface : USBFN_CLASS_INTERFACE
}
struct USBFN_CLASS_INTERFACE_EX {
    BaseInterfaceNumber : UInt8
    InterfaceCount : UInt8
    PipeCount : UInt8
    PipeArr : USBFN_PIPE_INFORMATION[16]
}
struct USBFN_CLASS_INFORMATION_PACKET_EX {
    FullSpeedClassInterfaceEx : USBFN_CLASS_INTERFACE_EX
    HighSpeedClassInterfaceEx : USBFN_CLASS_INTERFACE_EX
    SuperSpeedClassInterfaceEx : USBFN_CLASS_INTERFACE_EX
    InterfaceName : UInt16[40]
    InterfaceGuid : UInt16[39]
    HasInterfaceGuid : BOOLEAN
}
struct USBFN_INTERFACE_INFO {
    InterfaceNumber : UInt8
    Speed : USBFN_BUS_SPEED
    Size : UInt16
    InterfaceDescriptorSet : UInt8[1]
}
struct USBFN_USB_STRING {
    StringIndex : UInt8
    UsbString : UInt16[255]
}
struct USBFN_BUS_CONFIGURATION_INFO {
    ConfigurationName : UInt16[40]
    IsCurrent : BOOLEAN
    IsActive : BOOLEAN
}
struct USB_TOPOLOGY_ADDRESS {
    PciBusNumber : UInt32
    PciDeviceNumber : UInt32
    PciFunctionNumber : UInt32
    Reserved : UInt32
    RootHubPortNumber : UInt16
    HubPortNumber : UInt16[5]
    Reserved2 : UInt16
}
struct USB_HUB_NODE extends Int32 {
    static UsbHub := 0
    static UsbMIParent := 1
}
struct USB_HUB_INFORMATION {
    HubDescriptor : USB_HUB_DESCRIPTOR
    HubIsBusPowered : BOOLEAN
}
struct USB_MI_PARENT_INFORMATION {
    NumberOfInterfaces : UInt32
}
struct USB_NODE_INFORMATION {
    NodeType : USB_HUB_NODE
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            HubInformation : USB_HUB_INFORMATION
            MiParentInformation : USB_MI_PARENT_INFORMATION
        }
    }
}
struct USB_PIPE_INFO {
    EndpointDescriptor : USB_ENDPOINT_DESCRIPTOR
    ScheduleOffset : UInt32
}
struct USB_CONNECTION_STATUS extends Int32 {
    static NoDeviceConnected := 0
    static DeviceConnected := 1
    static DeviceFailedEnumeration := 2
    static DeviceGeneralFailure := 3
    static DeviceCausedOvercurrent := 4
    static DeviceNotEnoughPower := 5
    static DeviceNotEnoughBandwidth := 6
    static DeviceHubNestedTooDeeply := 7
    static DeviceInLegacyHub := 8
    static DeviceEnumerating := 9
    static DeviceReset := 10
}
struct USB_NODE_CONNECTION_INFORMATION {
    ConnectionIndex : UInt32
    DeviceDescriptor : USB_DEVICE_DESCRIPTOR
    CurrentConfigurationValue : UInt8
    LowSpeed : BOOLEAN
    DeviceIsHub : BOOLEAN
    DeviceAddress : UInt16
    NumberOfOpenPipes : UInt32
    ConnectionStatus : USB_CONNECTION_STATUS
    PipeList : USB_PIPE_INFO[1]
}
struct USB_NODE_CONNECTION_DRIVERKEY_NAME {
    ConnectionIndex : UInt32
    ActualLength : UInt32
    DriverKeyName : UInt16[1]
}
struct USB_NODE_CONNECTION_NAME {
    ConnectionIndex : UInt32
    ActualLength : UInt32
    NodeName : UInt16[1]
}
struct USB_HUB_NAME {
    ActualLength : UInt32
    HubName : UInt16[1]
}
struct USB_ROOT_HUB_NAME {
    ActualLength : UInt32
    RootHubName : UInt16[1]
}
struct USB_HCD_DRIVERKEY_NAME {
    ActualLength : UInt32
    DriverKeyName : UInt16[1]
}
struct USB_DESCRIPTOR_REQUEST {
    ConnectionIndex : UInt32
    SetupPacket : this._SetupPacket_e__Struct
    Data : UInt8[1]
    struct _SetupPacket_e__Struct {
        bmRequest : UInt8
        bRequest : UInt8
        wValue : UInt16
        wIndex : UInt16
        wLength : UInt16
    }
}
struct USB_HUB_CAPABILITIES {
    _bitfield : UInt32
}
struct USB_NODE_CONNECTION_ATTRIBUTES {
    ConnectionIndex : UInt32
    ConnectionStatus : USB_CONNECTION_STATUS
    PortAttributes : UInt32
}
struct USB_NODE_CONNECTION_INFORMATION_EX {
    ConnectionIndex : UInt32
    DeviceDescriptor : USB_DEVICE_DESCRIPTOR
    CurrentConfigurationValue : UInt8
    Speed : UInt8
    DeviceIsHub : BOOLEAN
    DeviceAddress : UInt16
    NumberOfOpenPipes : UInt32
    ConnectionStatus : USB_CONNECTION_STATUS
    PipeList : USB_PIPE_INFO[1]
}
struct USB_HUB_CAP_FLAGS {
    union {
        ul : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_HUB_CAPABILITIES_EX {
    CapabilityFlags : USB_HUB_CAP_FLAGS
}
struct USB_CYCLE_PORT_PARAMS {
    ConnectionIndex : UInt32
    StatusReturned : UInt32
}
struct USB_ID_STRING {
    LanguageId : UInt16
    Pad : UInt16
    LengthInBytes : UInt32
    Buffer : PWSTR
}
struct USB_HUB_DEVICE_UXD_SETTINGS {
    Version : UInt32
    PnpGuid : GUID
    OwnerGuid : GUID
    DeleteOnShutdown : UInt32
    DeleteOnReload : UInt32
    DeleteOnDisconnect : UInt32
    Reserved : UInt32[5]
}
struct HUB_DEVICE_CONFIG_INFO {
    Version : UInt32
    Length : UInt32
    HubFlags : USB_HUB_CAP_FLAGS
    HardwareIds : USB_ID_STRING
    CompatibleIds : USB_ID_STRING
    DeviceDescription : USB_ID_STRING
    Reserved : UInt32[19]
    UxdSettings : USB_HUB_DEVICE_UXD_SETTINGS
}
struct HCD_STAT_COUNTERS {
    BytesTransferred : UInt32
    IsoMissedCount : UInt16
    DataOverrunErrorCount : UInt16
    CrcErrorCount : UInt16
    ScheduleOverrunCount : UInt16
    TimeoutErrorCount : UInt16
    InternalHcErrorCount : UInt16
    BufferOverrunErrorCount : UInt16
    SWErrorCount : UInt16
    StallPidCount : UInt16
    PortDisableCount : UInt16
}
struct HCD_ISO_STAT_COUNTERS {
    LateUrbs : UInt16
    DoubleBufferedPackets : UInt16
    TransfersCF_5ms : UInt16
    TransfersCF_2ms : UInt16
    TransfersCF_1ms : UInt16
    MaxInterruptLatency : UInt16
    BadStartFrame : UInt16
    StaleUrbs : UInt16
    IsoPacketNotAccesed : UInt16
    IsoPacketHWError : UInt16
    SmallestUrbPacketCount : UInt16
    LargestUrbPacketCount : UInt16
    IsoCRC_Error : UInt16
    IsoOVERRUN_Error : UInt16
    IsoINTERNAL_Error : UInt16
    IsoUNKNOWN_Error : UInt16
    IsoBytesTransferred : UInt32
    LateMissedCount : UInt16
    HWIsoMissedCount : UInt16
    Reserved7 : UInt32[8]
}
struct HCD_STAT_INFORMATION_1 {
    Reserved1 : UInt32
    Reserved2 : UInt32
    ResetCounters : UInt32
    TimeRead : Int64
    Counters : HCD_STAT_COUNTERS
}
struct HCD_STAT_INFORMATION_2 {
    Reserved1 : UInt32
    Reserved2 : UInt32
    ResetCounters : UInt32
    TimeRead : Int64
    LockedMemoryUsed : Int32
    Counters : HCD_STAT_COUNTERS
    IsoCounters : HCD_ISO_STAT_COUNTERS
}
struct USB_NOTIFICATION_TYPE extends Int32 {
    static EnumerationFailure := 0
    static InsufficentBandwidth := 1
    static InsufficentPower := 2
    static OverCurrent := 3
    static ResetOvercurrent := 4
    static AcquireBusInfo := 5
    static AcquireHubName := 6
    static AcquireControllerName := 7
    static HubOvercurrent := 8
    static HubPowerChange := 9
    static HubNestedTooDeeply := 10
    static ModernDeviceInLegacyHub := 11
}
struct USB_NOTIFICATION {
    NotificationType : USB_NOTIFICATION_TYPE
}
struct USB_CONNECTION_NOTIFICATION {
    NotificationType : USB_NOTIFICATION_TYPE
    ConnectionNumber : UInt32
    RequestedBandwidth : UInt32
    EnumerationFailReason : UInt32
    PowerRequested : UInt32
    HubNameLength : UInt32
}
struct USB_BUS_NOTIFICATION {
    NotificationType : USB_NOTIFICATION_TYPE
    TotalBandwidth : UInt32
    ConsumedBandwidth : UInt32
    ControllerNameLength : UInt32
}
struct USB_ACQUIRE_INFO {
    NotificationType : USB_NOTIFICATION_TYPE
    TotalSize : UInt32
    Buffer : UInt16[1]
}
struct USB_WMI_DEVICE_NODE_TYPE extends Int32 {
    static UsbDevice := 0
    static HubDevice := 1
    static CompositeDevice := 2
    static UsbController := 3
}
struct USB_DEVICE_STATE {
    _bitfield : UInt32
}
struct USB_HUB_PORT_INFORMATION {
    DeviceState : USB_DEVICE_STATE
    PortNumber : UInt16
    DeviceAddress : UInt16
    ConnectionIndex : UInt32
    ConnectionStatus : USB_CONNECTION_STATUS
}
struct USB_HUB_DEVICE_INFO {
    HubDescriptor : USB_HUB_DESCRIPTOR
    HubNumber : UInt32
    DeviceAddress : UInt16
    HubIsSelfPowered : BOOLEAN
    HubIsRootHub : BOOLEAN
    HubCapabilities : USB_HUB_CAPABILITIES
    NumberOfHubPorts : UInt32
    PortInfo : USB_HUB_PORT_INFORMATION[1]
}
struct USB_COMPOSITE_FUNCTION_INFO {
    FunctionNumber : UInt8
    BaseInterfaceNumber : UInt8
    NumberOfInterfaces : UInt8
    FunctionIsIdle : BOOLEAN
}
struct USB_COMPOSITE_DEVICE_INFO {
    DeviceDescriptor : USB_DEVICE_DESCRIPTOR
    CurrentConfigDescriptor : USB_CONFIGURATION_DESCRIPTOR
    CurrentConfigurationValue : UInt8
    NumberOfFunctions : UInt8
    FunctionInfo : USB_COMPOSITE_FUNCTION_INFO[1]
}
struct USB_CONTROLLER_DEVICE_INFO {
    PciVendorId : UInt32
    PciDeviceId : UInt32
    PciRevision : UInt32
    NumberOfRootPorts : UInt32
    HcFeatureFlags : UInt32
}
struct USB_DEVICE_INFO {
    DeviceState : USB_DEVICE_STATE
    PortNumber : UInt16
    DeviceDescriptor : USB_DEVICE_DESCRIPTOR
    CurrentConfigurationValue : UInt8
    Speed : USB_DEVICE_SPEED
    DeviceAddress : UInt16
    ConnectionIndex : UInt32
    ConnectionStatus : USB_CONNECTION_STATUS
    PnpHardwareId : UInt16[128]
    PnpCompatibleId : UInt16[128]
    SerialNumberId : UInt16[128]
    PnpDeviceDescription : UInt16[128]
    NumberOfOpenPipes : UInt32
    PipeList : USB_PIPE_INFO[1]
}
struct USB_DEVICE_NODE_INFO {
    Sig : UInt32
    LengthInBytes : UInt32
    DeviceDescription : UInt16[40]
    NodeType : USB_WMI_DEVICE_NODE_TYPE
    BusAddress : USB_TOPOLOGY_ADDRESS
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            UsbDeviceInfo : USB_DEVICE_INFO
            HubDeviceInfo : USB_HUB_DEVICE_INFO
            CompositeDeviceInfo : USB_COMPOSITE_DEVICE_INFO
            ControllerDeviceInfo : USB_CONTROLLER_DEVICE_INFO
            DeviceInformation : UInt8[4]
        }
    }
}
struct USB_DEVICE_PERFORMANCE_INFO {
    BulkBytes : UInt32
    ControlDataBytes : UInt32
    IsoBytes : UInt32
    InterruptBytes : UInt32
    BulkUrbCount : UInt32
    ControlUrbCount : UInt32
    IsoUrbCount : UInt32
    InterruptUrbCount : UInt32
    AllocedInterrupt : UInt32[6]
    AllocedIso : UInt32
    Total32secBandwidth : UInt32
    TotalTtBandwidth : UInt32
    DeviceDescription : UInt16[60]
    DeviceSpeed : USB_DEVICE_SPEED
    TotalIsoLatency : UInt32
    DroppedIsoPackets : UInt32
    TransferErrors : UInt32
    PciInterruptCount : UInt32
    HcIdleState : UInt32
    HcAsyncIdleState : UInt32
    HcAsyncCacheFlushCount : UInt32
    HcPeriodicIdleState : UInt32
    HcPeriodicCacheFlushCount : UInt32
}
struct USB_HUB_TYPE extends Int32 {
    static UsbRootHub := 1
    static Usb20Hub := 2
    static Usb30Hub := 3
}
struct USB_HUB_INFORMATION_EX {
    HubType : USB_HUB_TYPE
    HighestPortNumber : UInt16
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            UsbHubDescriptor : USB_HUB_DESCRIPTOR
            Usb30HubDescriptor : USB_30_HUB_DESCRIPTOR
        }
    }
}
struct USB_PORT_PROPERTIES {
    union {
        ul : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_PORT_CONNECTOR_PROPERTIES {
    ConnectionIndex : UInt32
    ActualLength : UInt32
    UsbPortProperties : USB_PORT_PROPERTIES
    CompanionIndex : UInt16
    CompanionPortNumber : UInt16
    CompanionHubSymbolicLinkName : UInt16[1]
}
struct USB_PROTOCOLS {
    union {
        ul : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_NODE_CONNECTION_INFORMATION_EX_V2_FLAGS {
    union {
        ul : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct USB_NODE_CONNECTION_INFORMATION_EX_V2 {
    ConnectionIndex : UInt32
    Length : UInt32
    SupportedUsbProtocols : USB_PROTOCOLS
    Flags : USB_NODE_CONNECTION_INFORMATION_EX_V2_FLAGS
}
struct USB_TRANSPORT_CHARACTERISTICS {
    Version : UInt32
    TransportCharacteristicsFlags : UInt32
    CurrentRoundtripLatencyInMilliSeconds : Int64
    MaxPotentialBandwidth : Int64
}
struct USB_TRANSPORT_CHARACTERISTICS_CHANGE_REGISTRATION {
    ChangeNotificationInputFlags : UInt32
    Handle : USB_CHANGE_REGISTRATION_HANDLE
    UsbTransportCharacteristics : USB_TRANSPORT_CHARACTERISTICS
}
struct USB_TRANSPORT_CHARACTERISTICS_CHANGE_NOTIFICATION {
    Handle : USB_CHANGE_REGISTRATION_HANDLE
    UsbTransportCharacteristics : USB_TRANSPORT_CHARACTERISTICS
}
struct USB_TRANSPORT_CHARACTERISTICS_CHANGE_UNREGISTRATION {
    Handle : USB_CHANGE_REGISTRATION_HANDLE
}
struct USB_DEVICE_CHARACTERISTICS {
    Version : UInt32
    Reserved : UInt32[2]
    UsbDeviceCharacteristicsFlags : UInt32
    MaximumSendPathDelayInMilliSeconds : UInt32
    MaximumCompletionPathDelayInMilliSeconds : UInt32
}
struct USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION {
    TimeTrackingHandle : HANDLE
    IsStartupDelayTolerable : BOOLEAN
}
struct USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION {
    TimeTrackingHandle : HANDLE
}
struct USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION {
    TimeTrackingHandle : HANDLE
    InputFrameNumber : UInt32
    InputMicroFrameNumber : UInt32
    QueryPerformanceCounterAtInputFrameOrMicroFrame : Int64
    QueryPerformanceCounterFrequency : Int64
    PredictedAccuracyInMicroSeconds : UInt32
    CurrentGenerationID : UInt32
    CurrentQueryPerformanceCounter : Int64
    CurrentHardwareFrameNumber : UInt32
    CurrentHardwareMicroFrameNumber : UInt32
    CurrentUSBFrameNumber : UInt32
}
struct USB_NODE_CONNECTION_SUPERSPEEDPLUS_INFORMATION {
    ConnectionIndex : UInt32
    Length : UInt32
    RxSuperSpeedPlus : USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED
    RxLaneCount : UInt32
    TxSuperSpeedPlus : USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED
    TxLaneCount : UInt32
}
struct USB4_CONFIG_SPACE_TYPE extends Int32 {
    static USB4PathConfigurationSpace := 0
    static USB4AdapterConfigurationSpace := 1
    static USB4RouterConfigurationSpace := 2
    static USB4CounterConfigurationSpace := 3
}
struct USB4_STATUS extends Int32 {
    static ErrConn := 0
    static ErrLink := 1
    static ErrAddr := 2
    static ErrAdp := 4
    static HpAck := 7
    static ErrEnum := 8
    static ErrNua := 9
    static ErrLen := 11
    static ErrHec := 12
    static ErrFc := 13
    static ErrPlug := 14
    static ErrLock := 15
    static DpBw := 32
    static RopCmplt := 33
    static PopCmplt := 34
    static PcieWake := 35
    static DpConChange := 36
    static DpTxDiscovery := 37
    static LinkRecovery := 38
    static AsymLink := 39
    static PollingSkipped := 252
    static PollingTimeout := 253
    static StatusSuccess := 254
    static StatusUnknown := 255
}
struct USB4_HRD_DEBUG_ROUTE_STRING {
    Depth : UInt8
    Route : UInt8[7]
}
struct USB4_HRD_DEBUG_READ_CONFIGURATION_SPACE_INPUT {
    Route : USB4_HRD_DEBUG_ROUTE_STRING
    AdapterNumber : UInt8
    ConfigurationSpaceType : USB4_CONFIG_SPACE_TYPE
    DwOffset : UInt32
    DwLength : UInt32
}
struct USB4_HRD_DEBUG_READ_CONFIGURATION_SPACE_OUTPUT {
    Usb4Status : USB4_STATUS
    Data : UInt32[60]
}
struct DRV_VERSION {
    major : UInt32
    minor : UInt32
    internal : UInt32
}
struct IO_BLOCK {
    uOffset : UInt32
    uLength : UInt32
    pbyData : UInt8.Ptr
    uIndex : UInt32
}
struct IO_BLOCK_EX {
    uOffset : UInt32
    uLength : UInt32
    pbyData : UInt8.Ptr
    uIndex : UInt32
    bRequest : UInt8
    bmRequestType : UInt8
    fTransferDirectionIn : UInt8
}
struct CHANNEL_INFO {
    EventChannelSize : UInt32
    uReadDataAlignment : UInt32
    uWriteDataAlignment : UInt32
}
struct PIPE_TYPE extends Int32 {
    static EVENT_PIPE := 0
    static READ_DATA_PIPE := 1
    static WRITE_DATA_PIPE := 2
    static ALL_PIPE := 3
}
struct USBSCAN_GET_DESCRIPTOR {
    DescriptorType : UInt8
    Index : UInt8
    LanguageId : UInt16
}
struct DEVICE_DESCRIPTOR {
    usVendorId : UInt16
    usProductId : UInt16
    usBcdDevice : UInt16
    usLanguageId : UInt16
}
struct RAW_PIPE_TYPE extends Int32 {
    static USBSCAN_PIPE_CONTROL := 0
    static USBSCAN_PIPE_ISOCHRONOUS := 1
    static USBSCAN_PIPE_BULK := 2
    static USBSCAN_PIPE_INTERRUPT := 3
}
struct USBSCAN_PIPE_INFORMATION {
    MaximumPacketSize : UInt16
    EndpointAddress : UInt8
    Interval : UInt8
    PipeType : RAW_PIPE_TYPE
}
struct USBSCAN_PIPE_CONFIGURATION {
    NumberOfPipes : UInt32
    PipeInfo : USBSCAN_PIPE_INFORMATION[8]
}
struct USBSCAN_TIMEOUT {
    TimeoutRead : UInt32
    TimeoutWrite : UInt32
    TimeoutEvent : UInt32
}
struct WINUSB_PIPE_INFORMATION {
    PipeType : USBD_PIPE_TYPE
    PipeId : UInt8
    MaximumPacketSize : UInt16
    Interval : UInt8
}
struct WINUSB_PIPE_INFORMATION_EX {
    PipeType : USBD_PIPE_TYPE
    PipeId : UInt8
    MaximumPacketSize : UInt16
    Interval : UInt8
    MaximumBytesPerInterval : UInt32
}
struct WINUSB_SETUP_PACKET {
    RequestType : UInt8
    Request : UInt8
    Value : UInt16
    Index : UInt16
    Length : UInt16
}
