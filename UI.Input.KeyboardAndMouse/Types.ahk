#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HWND, PWSTR}

struct HOT_KEY_MODIFIERS extends UInt32 {
    static MOD_ALT := 1
    static MOD_CONTROL := 2
    static MOD_NOREPEAT := 16384
    static MOD_SHIFT := 4
    static MOD_WIN := 8
}
struct ACTIVATE_KEYBOARD_LAYOUT_FLAGS extends UInt32 {
    static KLF_REORDER := 8
    static KLF_RESET := 1073741824
    static KLF_SETFORPROCESS := 256
    static KLF_SHIFTLOCK := 65536
    static KLF_ACTIVATE := 1
    static KLF_NOTELLSHELL := 128
    static KLF_REPLACELANG := 16
    static KLF_SUBSTITUTE_OK := 2
}
struct GET_MOUSE_MOVE_POINTS_EX_RESOLUTION extends UInt32 {
    static GMMP_USE_DISPLAY_POINTS := 1
    static GMMP_USE_HIGH_RESOLUTION_POINTS := 2
}
struct KEYBD_EVENT_FLAGS extends UInt32 {
    static KEYEVENTF_EXTENDEDKEY := 1
    static KEYEVENTF_KEYUP := 2
    static KEYEVENTF_SCANCODE := 8
    static KEYEVENTF_UNICODE := 4
}
struct MOUSE_EVENT_FLAGS extends UInt32 {
    static MOUSEEVENTF_ABSOLUTE := 32768
    static MOUSEEVENTF_LEFTDOWN := 2
    static MOUSEEVENTF_LEFTUP := 4
    static MOUSEEVENTF_MIDDLEDOWN := 32
    static MOUSEEVENTF_MIDDLEUP := 64
    static MOUSEEVENTF_MOVE := 1
    static MOUSEEVENTF_RIGHTDOWN := 8
    static MOUSEEVENTF_RIGHTUP := 16
    static MOUSEEVENTF_WHEEL := 2048
    static MOUSEEVENTF_XDOWN := 128
    static MOUSEEVENTF_XUP := 256
    static MOUSEEVENTF_HWHEEL := 4096
    static MOUSEEVENTF_MOVE_NOCOALESCE := 8192
    static MOUSEEVENTF_VIRTUALDESK := 16384
}
struct INPUT_TYPE extends UInt32 {
    static INPUT_MOUSE := 0
    static INPUT_KEYBOARD := 1
    static INPUT_HARDWARE := 2
}
struct TRACKMOUSEEVENT_FLAGS extends UInt32 {
    static TME_CANCEL := 2147483648
    static TME_HOVER := 1
    static TME_LEAVE := 2
    static TME_NONCLIENT := 16
    static TME_QUERY := 1073741824
}
struct VIRTUAL_KEY extends UInt16 {
    static VK_0 := 48
    static VK_1 := 49
    static VK_2 := 50
    static VK_3 := 51
    static VK_4 := 52
    static VK_5 := 53
    static VK_6 := 54
    static VK_7 := 55
    static VK_8 := 56
    static VK_9 := 57
    static VK_A := 65
    static VK_B := 66
    static VK_C := 67
    static VK_D := 68
    static VK_E := 69
    static VK_F := 70
    static VK_G := 71
    static VK_H := 72
    static VK_I := 73
    static VK_J := 74
    static VK_K := 75
    static VK_L := 76
    static VK_M := 77
    static VK_N := 78
    static VK_O := 79
    static VK_P := 80
    static VK_Q := 81
    static VK_R := 82
    static VK_S := 83
    static VK_T := 84
    static VK_U := 85
    static VK_V := 86
    static VK_W := 87
    static VK_X := 88
    static VK_Y := 89
    static VK_Z := 90
    static VK_ABNT_C1 := 193
    static VK_ABNT_C2 := 194
    static VK_DBE_ALPHANUMERIC := 240
    static VK_DBE_CODEINPUT := 250
    static VK_DBE_DBCSCHAR := 244
    static VK_DBE_DETERMINESTRING := 252
    static VK_DBE_ENTERDLGCONVERSIONMODE := 253
    static VK_DBE_ENTERIMECONFIGMODE := 248
    static VK_DBE_ENTERWORDREGISTERMODE := 247
    static VK_DBE_FLUSHSTRING := 249
    static VK_DBE_HIRAGANA := 242
    static VK_DBE_KATAKANA := 241
    static VK_DBE_NOCODEINPUT := 251
    static VK_DBE_NOROMAN := 246
    static VK_DBE_ROMAN := 245
    static VK_DBE_SBCSCHAR := 243
    static VK__none_ := 255
    static VK_LBUTTON := 1
    static VK_RBUTTON := 2
    static VK_CANCEL := 3
    static VK_MBUTTON := 4
    static VK_XBUTTON1 := 5
    static VK_XBUTTON2 := 6
    static VK_BACK := 8
    static VK_TAB := 9
    static VK_CLEAR := 12
    static VK_RETURN := 13
    static VK_SHIFT := 16
    static VK_CONTROL := 17
    static VK_MENU := 18
    static VK_PAUSE := 19
    static VK_CAPITAL := 20
    static VK_KANA := 21
    static VK_HANGEUL := 21
    static VK_HANGUL := 21
    static VK_IME_ON := 22
    static VK_JUNJA := 23
    static VK_FINAL := 24
    static VK_HANJA := 25
    static VK_KANJI := 25
    static VK_IME_OFF := 26
    static VK_ESCAPE := 27
    static VK_CONVERT := 28
    static VK_NONCONVERT := 29
    static VK_ACCEPT := 30
    static VK_MODECHANGE := 31
    static VK_SPACE := 32
    static VK_PRIOR := 33
    static VK_NEXT := 34
    static VK_END := 35
    static VK_HOME := 36
    static VK_LEFT := 37
    static VK_UP := 38
    static VK_RIGHT := 39
    static VK_DOWN := 40
    static VK_SELECT := 41
    static VK_PRINT := 42
    static VK_EXECUTE := 43
    static VK_SNAPSHOT := 44
    static VK_INSERT := 45
    static VK_DELETE := 46
    static VK_HELP := 47
    static VK_LWIN := 91
    static VK_RWIN := 92
    static VK_APPS := 93
    static VK_SLEEP := 95
    static VK_NUMPAD0 := 96
    static VK_NUMPAD1 := 97
    static VK_NUMPAD2 := 98
    static VK_NUMPAD3 := 99
    static VK_NUMPAD4 := 100
    static VK_NUMPAD5 := 101
    static VK_NUMPAD6 := 102
    static VK_NUMPAD7 := 103
    static VK_NUMPAD8 := 104
    static VK_NUMPAD9 := 105
    static VK_MULTIPLY := 106
    static VK_ADD := 107
    static VK_SEPARATOR := 108
    static VK_SUBTRACT := 109
    static VK_DECIMAL := 110
    static VK_DIVIDE := 111
    static VK_F1 := 112
    static VK_F2 := 113
    static VK_F3 := 114
    static VK_F4 := 115
    static VK_F5 := 116
    static VK_F6 := 117
    static VK_F7 := 118
    static VK_F8 := 119
    static VK_F9 := 120
    static VK_F10 := 121
    static VK_F11 := 122
    static VK_F12 := 123
    static VK_F13 := 124
    static VK_F14 := 125
    static VK_F15 := 126
    static VK_F16 := 127
    static VK_F17 := 128
    static VK_F18 := 129
    static VK_F19 := 130
    static VK_F20 := 131
    static VK_F21 := 132
    static VK_F22 := 133
    static VK_F23 := 134
    static VK_F24 := 135
    static VK_NAVIGATION_VIEW := 136
    static VK_NAVIGATION_MENU := 137
    static VK_NAVIGATION_UP := 138
    static VK_NAVIGATION_DOWN := 139
    static VK_NAVIGATION_LEFT := 140
    static VK_NAVIGATION_RIGHT := 141
    static VK_NAVIGATION_ACCEPT := 142
    static VK_NAVIGATION_CANCEL := 143
    static VK_NUMLOCK := 144
    static VK_SCROLL := 145
    static VK_OEM_NEC_EQUAL := 146
    static VK_OEM_FJ_JISHO := 146
    static VK_OEM_FJ_MASSHOU := 147
    static VK_OEM_FJ_TOUROKU := 148
    static VK_OEM_FJ_LOYA := 149
    static VK_OEM_FJ_ROYA := 150
    static VK_LSHIFT := 160
    static VK_RSHIFT := 161
    static VK_LCONTROL := 162
    static VK_RCONTROL := 163
    static VK_LMENU := 164
    static VK_RMENU := 165
    static VK_BROWSER_BACK := 166
    static VK_BROWSER_FORWARD := 167
    static VK_BROWSER_REFRESH := 168
    static VK_BROWSER_STOP := 169
    static VK_BROWSER_SEARCH := 170
    static VK_BROWSER_FAVORITES := 171
    static VK_BROWSER_HOME := 172
    static VK_VOLUME_MUTE := 173
    static VK_VOLUME_DOWN := 174
    static VK_VOLUME_UP := 175
    static VK_MEDIA_NEXT_TRACK := 176
    static VK_MEDIA_PREV_TRACK := 177
    static VK_MEDIA_STOP := 178
    static VK_MEDIA_PLAY_PAUSE := 179
    static VK_LAUNCH_MAIL := 180
    static VK_LAUNCH_MEDIA_SELECT := 181
    static VK_LAUNCH_APP1 := 182
    static VK_LAUNCH_APP2 := 183
    static VK_OEM_1 := 186
    static VK_OEM_PLUS := 187
    static VK_OEM_COMMA := 188
    static VK_OEM_MINUS := 189
    static VK_OEM_PERIOD := 190
    static VK_OEM_2 := 191
    static VK_OEM_3 := 192
    static VK_GAMEPAD_A := 195
    static VK_GAMEPAD_B := 196
    static VK_GAMEPAD_X := 197
    static VK_GAMEPAD_Y := 198
    static VK_GAMEPAD_RIGHT_SHOULDER := 199
    static VK_GAMEPAD_LEFT_SHOULDER := 200
    static VK_GAMEPAD_LEFT_TRIGGER := 201
    static VK_GAMEPAD_RIGHT_TRIGGER := 202
    static VK_GAMEPAD_DPAD_UP := 203
    static VK_GAMEPAD_DPAD_DOWN := 204
    static VK_GAMEPAD_DPAD_LEFT := 205
    static VK_GAMEPAD_DPAD_RIGHT := 206
    static VK_GAMEPAD_MENU := 207
    static VK_GAMEPAD_VIEW := 208
    static VK_GAMEPAD_LEFT_THUMBSTICK_BUTTON := 209
    static VK_GAMEPAD_RIGHT_THUMBSTICK_BUTTON := 210
    static VK_GAMEPAD_LEFT_THUMBSTICK_UP := 211
    static VK_GAMEPAD_LEFT_THUMBSTICK_DOWN := 212
    static VK_GAMEPAD_LEFT_THUMBSTICK_RIGHT := 213
    static VK_GAMEPAD_LEFT_THUMBSTICK_LEFT := 214
    static VK_GAMEPAD_RIGHT_THUMBSTICK_UP := 215
    static VK_GAMEPAD_RIGHT_THUMBSTICK_DOWN := 216
    static VK_GAMEPAD_RIGHT_THUMBSTICK_RIGHT := 217
    static VK_GAMEPAD_RIGHT_THUMBSTICK_LEFT := 218
    static VK_OEM_4 := 219
    static VK_OEM_5 := 220
    static VK_OEM_6 := 221
    static VK_OEM_7 := 222
    static VK_OEM_8 := 223
    static VK_OEM_AX := 225
    static VK_OEM_102 := 226
    static VK_ICO_HELP := 227
    static VK_ICO_00 := 228
    static VK_PROCESSKEY := 229
    static VK_ICO_CLEAR := 230
    static VK_PACKET := 231
    static VK_OEM_RESET := 233
    static VK_OEM_JUMP := 234
    static VK_OEM_PA1 := 235
    static VK_OEM_PA2 := 236
    static VK_OEM_PA3 := 237
    static VK_OEM_WSCTRL := 238
    static VK_OEM_CUSEL := 239
    static VK_OEM_ATTN := 240
    static VK_OEM_FINISH := 241
    static VK_OEM_COPY := 242
    static VK_OEM_AUTO := 243
    static VK_OEM_ENLW := 244
    static VK_OEM_BACKTAB := 245
    static VK_ATTN := 246
    static VK_CRSEL := 247
    static VK_EXSEL := 248
    static VK_EREOF := 249
    static VK_PLAY := 250
    static VK_ZOOM := 251
    static VK_NONAME := 252
    static VK_PA1 := 253
    static VK_OEM_CLEAR := 254
}
struct MAP_VIRTUAL_KEY_TYPE extends UInt32 {
    static MAPVK_VK_TO_VSC := 0
    static MAPVK_VSC_TO_VK := 1
    static MAPVK_VK_TO_CHAR := 2
    static MAPVK_VSC_TO_VK_EX := 3
    static MAPVK_VK_TO_VSC_EX := 4
}
struct HKL {
    Value : IntPtr
}
struct VK_TO_BIT {
    Vk : UInt8
    ModBits : UInt8
}
struct MODIFIERS {
    pVkToBit : VK_TO_BIT.Ptr
    wMaxModBits : UInt16
    ModNumber : UInt8[1]
}
struct VSC_VK {
    Vsc : UInt8
    Vk : UInt16
}
struct VK_VSC {
    Vk : UInt8
    Vsc : UInt8
}
struct VK_TO_WCHARS1 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[1]
}
struct VK_TO_WCHARS2 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[2]
}
struct VK_TO_WCHARS3 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[3]
}
struct VK_TO_WCHARS4 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[4]
}
struct VK_TO_WCHARS5 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[5]
}
struct VK_TO_WCHARS6 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[6]
}
struct VK_TO_WCHARS7 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[7]
}
struct VK_TO_WCHARS8 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[8]
}
struct VK_TO_WCHARS9 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[9]
}
struct VK_TO_WCHARS10 {
    VirtualKey : UInt8
    Attributes : UInt8
    wch : UInt16[10]
}
struct VK_TO_WCHAR_TABLE {
    pVkToWchars : VK_TO_WCHARS1.Ptr
    nModifications : UInt8
    cbSize : UInt8 := this.Size
}
struct DEADKEY {
    dwBoth : UInt32
    wchComposed : UInt16
    uFlags : UInt16
}
struct LIGATURE1 {
    VirtualKey : UInt8
    ModificationNumber : UInt16
    wch : UInt16[1]
}
struct LIGATURE2 {
    VirtualKey : UInt8
    ModificationNumber : UInt16
    wch : UInt16[2]
}
struct LIGATURE3 {
    VirtualKey : UInt8
    ModificationNumber : UInt16
    wch : UInt16[3]
}
struct LIGATURE4 {
    VirtualKey : UInt8
    ModificationNumber : UInt16
    wch : UInt16[4]
}
struct LIGATURE5 {
    VirtualKey : UInt8
    ModificationNumber : UInt16
    wch : UInt16[5]
}
struct VSC_LPWSTR {
    vsc : UInt8
    pwsz : PWSTR
}
struct KBDTABLES {
    pCharModifiers : MODIFIERS.Ptr
    pVkToWcharTable : VK_TO_WCHAR_TABLE.Ptr
    pDeadKey : DEADKEY.Ptr
    pKeyNames : VSC_LPWSTR.Ptr
    pKeyNamesExt : VSC_LPWSTR.Ptr
    pKeyNamesDead : UInt16.Ptr.Ptr
    pusVSCtoVK : UInt16.Ptr
    bMaxVSCtoVK : UInt8
    pVSCtoVK_E0 : VSC_VK.Ptr
    pVSCtoVK_E1 : VSC_VK.Ptr
    fLocaleFlags : UInt32
    nLgMax : UInt8
    cbLgEntry : UInt8
    pLigature : LIGATURE1.Ptr
    dwType : UInt32
    dwSubType : UInt32
}
struct VK_FPARAM {
    NLSFEProcIndex : UInt8
    NLSFEProcParam : UInt32
}
struct VK_F {
    Vk : UInt8
    NLSFEProcType : UInt8
    NLSFEProcCurrent : UInt8
    NLSFEProcSwitch : UInt8
    NLSFEProc : VK_FPARAM[8]
    NLSFEProcAlt : VK_FPARAM[8]
}
struct KBDNLSTABLES {
    OEMIdentifier : UInt16
    LayoutInformation : UInt16
    NumOfVkToF : UInt32
    pVkToF : VK_F.Ptr
    NumOfMouseVKey : Int32
    pusMouseVKey : UInt16.Ptr
}
struct KBDTABLE_DESC {
    wszDllName : UInt16[32]
    dwType : UInt32
    dwSubType : UInt32
}
struct KBDTABLE_MULTI {
    nTables : UInt32
    aKbdTables : KBDTABLE_DESC[8]
}
struct KBD_TYPE_INFO {
    dwVersion : UInt32
    dwType : UInt32
    dwSubType : UInt32
}
struct MOUSEMOVEPOINT {
    x : Int32
    y : Int32
    time : UInt32
    dwExtraInfo : IntPtr
}
struct TRACKMOUSEEVENT {
    cbSize : UInt32 := this.Size
    dwFlags : TRACKMOUSEEVENT_FLAGS
    hwndTrack : HWND
    dwHoverTime : UInt32
}
struct MOUSEINPUT {
    dx : Int32
    dy : Int32
    mouseData : UInt32
    dwFlags : MOUSE_EVENT_FLAGS
    time : UInt32
    dwExtraInfo : IntPtr
}
struct KEYBDINPUT {
    wVk : VIRTUAL_KEY
    wScan : UInt16
    dwFlags : KEYBD_EVENT_FLAGS
    time : UInt32
    dwExtraInfo : IntPtr
}
struct HARDWAREINPUT {
    uMsg : UInt32
    wParamL : UInt16
    wParamH : UInt16
}
struct INPUT {
    type : INPUT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            mi : MOUSEINPUT
            ki : KEYBDINPUT
            hi : HARDWAREINPUT
        }
    }
}
struct LASTINPUTINFO {
    cbSize : UInt32 := this.Size
    dwTime : UInt32
}
