#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HWND, WPARAM}

struct RAW_INPUT_DATA_COMMAND_FLAGS extends UInt32 {
    static RID_HEADER := 268435461
    static RID_INPUT := 268435459
}
struct RAW_INPUT_DEVICE_INFO_COMMAND extends UInt32 {
    static RIDI_PREPARSEDDATA := 536870917
    static RIDI_DEVICENAME := 536870919
    static RIDI_DEVICEINFO := 536870923
}
struct RID_DEVICE_INFO_TYPE extends UInt32 {
    static RIM_TYPEMOUSE := 0
    static RIM_TYPEKEYBOARD := 1
    static RIM_TYPEHID := 2
}
struct RAWINPUTDEVICE_FLAGS extends UInt32 {
    static RIDEV_REMOVE := 1
    static RIDEV_EXCLUDE := 16
    static RIDEV_PAGEONLY := 32
    static RIDEV_NOLEGACY := 48
    static RIDEV_INPUTSINK := 256
    static RIDEV_CAPTUREMOUSE := 512
    static RIDEV_NOHOTKEYS := 512
    static RIDEV_APPKEYS := 1024
    static RIDEV_EXINPUTSINK := 4096
    static RIDEV_DEVNOTIFY := 8192
}
struct MOUSE_STATE extends UInt16 {
    static MOUSE_MOVE_RELATIVE := 0
    static MOUSE_MOVE_ABSOLUTE := 1
    static MOUSE_VIRTUAL_DESKTOP := 2
    static MOUSE_ATTRIBUTES_CHANGED := 4
    static MOUSE_MOVE_NOCOALESCE := 8
}
struct HRAWINPUT {
    Value : IntPtr
}
struct RAWINPUTHEADER {
    dwType : UInt32
    dwSize : UInt32
    hDevice : HANDLE
    wParam : WPARAM
}
struct RAWMOUSE {
    usFlags : MOUSE_STATE
    Anonymous : this._Anonymous_e__Union
    ulRawButtons : UInt32
    lLastX : Int32
    lLastY : Int32
    ulExtraInformation : UInt32
    struct _Anonymous_e__Union {
        union {
            ulButtons : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            usButtonFlags : UInt16
            usButtonData : UInt16
        }
    }
}
struct RAWKEYBOARD {
    MakeCode : UInt16
    Flags : UInt16
    Reserved : UInt16
    VKey : UInt16
    Message : UInt32
    ExtraInformation : UInt32
}
struct RAWHID {
    dwSizeHid : UInt32
    dwCount : UInt32
    bRawData : UInt8[1]
}
struct RAWINPUT {
    header : RAWINPUTHEADER
    data : this._data_e__Union
    struct _data_e__Union {
        union {
            mouse : RAWMOUSE
            keyboard : RAWKEYBOARD
            hid : RAWHID
        }
    }
}
struct RID_DEVICE_INFO_MOUSE {
    dwId : UInt32
    dwNumberOfButtons : UInt32
    dwSampleRate : UInt32
    fHasHorizontalWheel : BOOL
}
struct RID_DEVICE_INFO_KEYBOARD {
    dwType : UInt32
    dwSubType : UInt32
    dwKeyboardMode : UInt32
    dwNumberOfFunctionKeys : UInt32
    dwNumberOfIndicators : UInt32
    dwNumberOfKeysTotal : UInt32
}
struct RID_DEVICE_INFO_HID {
    dwVendorId : UInt32
    dwProductId : UInt32
    dwVersionNumber : UInt32
    usUsagePage : UInt16
    usUsage : UInt16
}
struct RID_DEVICE_INFO {
    cbSize : UInt32 := this.Size
    dwType : RID_DEVICE_INFO_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            mouse : RID_DEVICE_INFO_MOUSE
            keyboard : RID_DEVICE_INFO_KEYBOARD
            hid : RID_DEVICE_INFO_HID
        }
    }
}
struct RAWINPUTDEVICE {
    usUsagePage : UInt16
    usUsage : UInt16
    dwFlags : RAWINPUTDEVICE_FLAGS
    hwndTarget : HWND
}
struct RAWINPUTDEVICELIST {
    hDevice : HANDLE
    dwType : RID_DEVICE_INFO_TYPE
}
struct INPUT_MESSAGE_DEVICE_TYPE extends Int32 {
    static IMDT_UNAVAILABLE := 0
    static IMDT_KEYBOARD := 1
    static IMDT_MOUSE := 2
    static IMDT_TOUCH := 4
    static IMDT_PEN := 8
    static IMDT_TOUCHPAD := 16
}
struct INPUT_MESSAGE_ORIGIN_ID extends Int32 {
    static IMO_UNAVAILABLE := 0
    static IMO_HARDWARE := 1
    static IMO_INJECTED := 2
    static IMO_SYSTEM := 4
}
struct INPUT_MESSAGE_SOURCE {
    deviceType : INPUT_MESSAGE_DEVICE_TYPE
    originId : INPUT_MESSAGE_ORIGIN_ID
}
