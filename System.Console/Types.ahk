#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, COLORREF, HANDLE, HWND, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {BITMAPINFO}

struct CONSOLE_MODE extends UInt32 {
    static ENABLE_PROCESSED_INPUT := 1
    static ENABLE_LINE_INPUT := 2
    static ENABLE_ECHO_INPUT := 4
    static ENABLE_WINDOW_INPUT := 8
    static ENABLE_MOUSE_INPUT := 16
    static ENABLE_INSERT_MODE := 32
    static ENABLE_QUICK_EDIT_MODE := 64
    static ENABLE_EXTENDED_FLAGS := 128
    static ENABLE_AUTO_POSITION := 256
    static ENABLE_VIRTUAL_TERMINAL_INPUT := 512
    static ENABLE_PROCESSED_OUTPUT := 1
    static ENABLE_WRAP_AT_EOL_OUTPUT := 2
    static ENABLE_VIRTUAL_TERMINAL_PROCESSING := 4
    static DISABLE_NEWLINE_AUTO_RETURN := 8
    static ENABLE_LVB_GRID_WORLDWIDE := 16
}
struct STD_HANDLE extends UInt32 {
    static STD_INPUT_HANDLE := 4294967286
    static STD_OUTPUT_HANDLE := 4294967285
    static STD_ERROR_HANDLE := 4294967284
}
struct CONSOLE_CHARACTER_ATTRIBUTES extends UInt16 {
    static FOREGROUND_BLUE := 1
    static FOREGROUND_GREEN := 2
    static FOREGROUND_RED := 4
    static FOREGROUND_INTENSITY := 8
    static BACKGROUND_BLUE := 16
    static BACKGROUND_GREEN := 32
    static BACKGROUND_RED := 64
    static BACKGROUND_INTENSITY := 128
    static COMMON_LVB_LEADING_BYTE := 256
    static COMMON_LVB_TRAILING_BYTE := 512
    static COMMON_LVB_GRID_HORIZONTAL := 1024
    static COMMON_LVB_GRID_LVERTICAL := 2048
    static COMMON_LVB_GRID_RVERTICAL := 4096
    static COMMON_LVB_REVERSE_VIDEO := 16384
    static COMMON_LVB_UNDERSCORE := 32768
    static COMMON_LVB_SBCSDBCS := 768
}
struct HPCON {
    Value : IntPtr
}
struct COORD {
    X : Int16
    Y : Int16
}
struct SMALL_RECT {
    Left : Int16
    Top : Int16
    Right : Int16
    Bottom : Int16
}
struct KEY_EVENT_RECORD {
    bKeyDown : BOOL
    wRepeatCount : UInt16
    wVirtualKeyCode : UInt16
    wVirtualScanCode : UInt16
    uChar : this._uChar_e__Union
    dwControlKeyState : UInt32
    struct _uChar_e__Union {
        union {
            UnicodeChar : UInt16
            AsciiChar : CHAR
        }
    }
}
struct MOUSE_EVENT_RECORD {
    dwMousePosition : COORD
    dwButtonState : UInt32
    dwControlKeyState : UInt32
    dwEventFlags : UInt32
}
struct WINDOW_BUFFER_SIZE_RECORD {
    dwSize : COORD
}
struct MENU_EVENT_RECORD {
    dwCommandId : UInt32
}
struct FOCUS_EVENT_RECORD {
    bSetFocus : BOOL
}
struct INPUT_RECORD {
    EventType : UInt16
    Event : this._Event_e__Union
    struct _Event_e__Union {
        union {
            KeyEvent : KEY_EVENT_RECORD
            MouseEvent : MOUSE_EVENT_RECORD
            WindowBufferSizeEvent : WINDOW_BUFFER_SIZE_RECORD
            MenuEvent : MENU_EVENT_RECORD
            FocusEvent : FOCUS_EVENT_RECORD
        }
    }
}
struct CHAR_INFO {
    Char : this._Char_e__Union
    Attributes : UInt16
    struct _Char_e__Union {
        union {
            UnicodeChar : UInt16
            AsciiChar : CHAR
        }
    }
}
struct CONSOLE_FONT_INFO {
    nFont : UInt32
    dwFontSize : COORD
}
struct ALLOC_CONSOLE_MODE extends Int32 {
    static ALLOC_CONSOLE_MODE_DEFAULT := 0
    static ALLOC_CONSOLE_MODE_NEW_WINDOW := 1
    static ALLOC_CONSOLE_MODE_NO_WINDOW := 2
}
struct ALLOC_CONSOLE_OPTIONS {
    mode : ALLOC_CONSOLE_MODE
    useShowWindow : BOOL
    showWindow : UInt16
}
struct ALLOC_CONSOLE_RESULT extends Int32 {
    static ALLOC_CONSOLE_RESULT_NO_CONSOLE := 0
    static ALLOC_CONSOLE_RESULT_NEW_CONSOLE := 1
    static ALLOC_CONSOLE_RESULT_EXISTING_CONSOLE := 2
}
struct CONSOLE_READCONSOLE_CONTROL {
    nLength : UInt32
    nInitialChars : UInt32
    dwCtrlWakeupMask : UInt32
    dwControlKeyState : UInt32
}
struct PHANDLER_ROUTINE extends FunctionPointer {
    static Types := [UInt32, BOOL]
}
struct CONSOLE_CURSOR_INFO {
    dwSize : UInt32
    bVisible : BOOL
}
struct CONSOLE_SCREEN_BUFFER_INFO {
    dwSize : COORD
    dwCursorPosition : COORD
    wAttributes : CONSOLE_CHARACTER_ATTRIBUTES
    srWindow : SMALL_RECT
    dwMaximumWindowSize : COORD
}
struct CONSOLE_SCREEN_BUFFER_INFOEX {
    cbSize : UInt32 := this.Size
    dwSize : COORD
    dwCursorPosition : COORD
    wAttributes : CONSOLE_CHARACTER_ATTRIBUTES
    srWindow : SMALL_RECT
    dwMaximumWindowSize : COORD
    wPopupAttributes : UInt16
    bFullscreenSupported : BOOL
    ColorTable : COLORREF[16]
}
struct CONSOLE_FONT_INFOEX {
    cbSize : UInt32 := this.Size
    nFont : UInt32
    dwFontSize : COORD
    FontFamily : UInt32
    FontWeight : UInt32
    FaceName : UInt16[32]
}
struct CONSOLE_SELECTION_INFO {
    dwFlags : UInt32
    dwSelectionAnchor : COORD
    srSelection : SMALL_RECT
}
struct CONSOLE_HISTORY_INFO {
    cbSize : UInt32 := this.Size
    HistoryBufferSize : UInt32
    NumberOfHistoryBuffers : UInt32
    dwFlags : UInt32
}
struct CONSOLE_GRAPHICS_BUFFER_INFO {
    dwBitMapInfoLength : UInt32
    lpBitMapInfo : BITMAPINFO.Ptr
    dwUsage : UInt32
    hMutex : HANDLE
    lpBitMap : Struct.Ptr
}
struct APPKEY {
    Modifier : UInt16
    ScanCode : UInt16
}
struct ExtKeySubst {
    wMod : UInt16
    wVirKey : UInt16
    wUnicodeChar : UInt16
}
struct ExtKeyDef {
    keys : ExtKeySubst[3]
}
struct ExtKeyDefBuf {
    dwVersion : UInt32
    dwCheckSum : UInt32
    table : ExtKeyDef[26]
}
struct CONSOLECONTROL extends Int32 {
    static Reserved1 := 0
    static ConsoleNotifyConsoleApplication := 1
    static Reserved2 := 2
    static ConsoleSetCaretInfo := 3
    static Reserved3 := 4
    static ConsoleSetForeground := 5
    static ConsoleSetWindowOwner := 6
    static ConsoleEndTask := 7
}
struct CONSOLEENDTASK {
    ProcessId : HANDLE
    hwnd : HWND
    ConsoleEventCode : UInt32
    ConsoleFlags : UInt32
}
struct CONSOLEWINDOWOWNER {
    hwnd : HWND
    ProcessId : UInt32
    ThreadId : UInt32
}
struct CONSOLESETFOREGROUND {
    hProcess : HANDLE
    bForeground : BOOL
}
struct CONSOLE_PROCESS_INFO {
    dwProcessID : UInt32
    dwFlags : UInt32
}
struct CONSOLE_CARET_INFO {
    hwnd : HWND
    rc : RECT
}
