#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HWND, POINT, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {HMONITOR}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {POINTER_INPUT_TYPE}

struct POINTER_FLAGS extends UInt32 {
    static POINTER_FLAG_NONE := 0
    static POINTER_FLAG_NEW := 1
    static POINTER_FLAG_INRANGE := 2
    static POINTER_FLAG_INCONTACT := 4
    static POINTER_FLAG_FIRSTBUTTON := 16
    static POINTER_FLAG_SECONDBUTTON := 32
    static POINTER_FLAG_THIRDBUTTON := 64
    static POINTER_FLAG_FOURTHBUTTON := 128
    static POINTER_FLAG_FIFTHBUTTON := 256
    static POINTER_FLAG_PRIMARY := 8192
    static POINTER_FLAG_CONFIDENCE := 16384
    static POINTER_FLAG_CANCELED := 32768
    static POINTER_FLAG_DOWN := 65536
    static POINTER_FLAG_UPDATE := 131072
    static POINTER_FLAG_UP := 262144
    static POINTER_FLAG_WHEEL := 524288
    static POINTER_FLAG_HWHEEL := 1048576
    static POINTER_FLAG_CAPTURECHANGED := 2097152
    static POINTER_FLAG_HASTRANSFORM := 4194304
}
struct TOUCH_FEEDBACK_MODE extends UInt32 {
    static TOUCH_FEEDBACK_DEFAULT := 1
    static TOUCH_FEEDBACK_INDIRECT := 2
    static TOUCH_FEEDBACK_NONE := 3
}
struct HSYNTHETICPOINTERDEVICE {
    Value : IntPtr
}
struct POINTER_BUTTON_CHANGE_TYPE extends Int32 {
    static POINTER_CHANGE_NONE := 0
    static POINTER_CHANGE_FIRSTBUTTON_DOWN := 1
    static POINTER_CHANGE_FIRSTBUTTON_UP := 2
    static POINTER_CHANGE_SECONDBUTTON_DOWN := 3
    static POINTER_CHANGE_SECONDBUTTON_UP := 4
    static POINTER_CHANGE_THIRDBUTTON_DOWN := 5
    static POINTER_CHANGE_THIRDBUTTON_UP := 6
    static POINTER_CHANGE_FOURTHBUTTON_DOWN := 7
    static POINTER_CHANGE_FOURTHBUTTON_UP := 8
    static POINTER_CHANGE_FIFTHBUTTON_DOWN := 9
    static POINTER_CHANGE_FIFTHBUTTON_UP := 10
}
struct POINTER_INFO {
    pointerType : POINTER_INPUT_TYPE
    pointerId : UInt32
    frameId : UInt32
    pointerFlags : POINTER_FLAGS
    sourceDevice : HANDLE
    hwndTarget : HWND
    ptPixelLocation : POINT
    ptHimetricLocation : POINT
    ptPixelLocationRaw : POINT
    ptHimetricLocationRaw : POINT
    dwTime : UInt32
    historyCount : UInt32
    InputData : Int32
    dwKeyStates : UInt32
    PerformanceCount : Int64
    ButtonChangeType : POINTER_BUTTON_CHANGE_TYPE
}
struct POINTER_TOUCH_INFO {
    pointerInfo : POINTER_INFO
    touchFlags : UInt32
    touchMask : UInt32
    rcContact : RECT
    rcContactRaw : RECT
    orientation : UInt32
    pressure : UInt32
}
struct POINTER_PEN_INFO {
    pointerInfo : POINTER_INFO
    penFlags : UInt32
    penMask : UInt32
    pressure : UInt32
    rotation : UInt32
    tiltX : Int32
    tiltY : Int32
}
struct POINTER_FEEDBACK_MODE extends Int32 {
    static POINTER_FEEDBACK_DEFAULT := 1
    static POINTER_FEEDBACK_INDIRECT := 2
    static POINTER_FEEDBACK_NONE := 3
}
struct POINTER_TYPE_INFO {
    type : POINTER_INPUT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pointerInfo : POINTER_INFO
            touchInfo : POINTER_TOUCH_INFO
            penInfo : POINTER_PEN_INFO
        }
    }
}
struct INPUT_INJECTION_VALUE {
    page : UInt16
    usage : UInt16
    value : Int32
    index : UInt16
}
struct TOUCHPAD_ACTION extends Int32 {
    static TA_3FINGER_TAP := 0
    static TA_3FINGER_PRESS := 1
    static TA_3FINGER_RELEASE := 2
    static TA_4FINGER_TAP := 3
    static TA_4FINGER_PRESS := 4
    static TA_4FINGER_RELEASE := 5
    static TA_5FINGER_TAP := 6
    static TA_5FINGER_PRESS := 7
    static TA_5FINGER_RELEASE := 8
    static TA_INERTIA_STOP := 9
    static TA_INERTIA_END := 10
}
struct INPUT_TRANSFORM {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            m : Float32[16]
        }
        struct _Anonymous_e__Struct {
            _11 : Float32
            _12 : Float32
            _13 : Float32
            _14 : Float32
            _21 : Float32
            _22 : Float32
            _23 : Float32
            _24 : Float32
            _31 : Float32
            _32 : Float32
            _33 : Float32
            _34 : Float32
            _41 : Float32
            _42 : Float32
            _43 : Float32
            _44 : Float32
        }
    }
}
struct POINTER_DEVICE_TYPE extends Int32 {
    static POINTER_DEVICE_TYPE_INTEGRATED_PEN := 1
    static POINTER_DEVICE_TYPE_EXTERNAL_PEN := 2
    static POINTER_DEVICE_TYPE_TOUCH := 3
    static POINTER_DEVICE_TYPE_TOUCH_PAD := 4
    static POINTER_DEVICE_TYPE_MAX := -1
}
struct POINTER_DEVICE_INFO {
    displayOrientation : UInt32
    device : HANDLE
    pointerDeviceType : POINTER_DEVICE_TYPE
    monitor : HMONITOR
    startingCursorId : UInt32
    maxActiveContacts : UInt16
    productString : UInt16[520]
}
struct POINTER_DEVICE_PROPERTY {
    logicalMin : Int32
    logicalMax : Int32
    physicalMin : Int32
    physicalMax : Int32
    unit : UInt32
    unitExponent : UInt32
    usagePageId : UInt16
    usageId : UInt16
}
struct POINTER_DEVICE_CURSOR_TYPE extends Int32 {
    static POINTER_DEVICE_CURSOR_TYPE_UNKNOWN := 0
    static POINTER_DEVICE_CURSOR_TYPE_TIP := 1
    static POINTER_DEVICE_CURSOR_TYPE_ERASER := 2
    static POINTER_DEVICE_CURSOR_TYPE_MAX := -1
}
struct POINTER_DEVICE_CURSOR_INFO {
    cursorId : UInt32
    cursor : POINTER_DEVICE_CURSOR_TYPE
}
