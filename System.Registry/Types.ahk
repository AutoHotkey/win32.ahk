#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PSTR, PWSTR}

struct REG_VALUE_TYPE extends UInt32 {
    static REG_NONE := 0
    static REG_SZ := 1
    static REG_EXPAND_SZ := 2
    static REG_BINARY := 3
    static REG_DWORD := 4
    static REG_DWORD_LITTLE_ENDIAN := 4
    static REG_DWORD_BIG_ENDIAN := 5
    static REG_LINK := 6
    static REG_MULTI_SZ := 7
    static REG_RESOURCE_LIST := 8
    static REG_FULL_RESOURCE_DESCRIPTOR := 9
    static REG_RESOURCE_REQUIREMENTS_LIST := 10
    static REG_QWORD := 11
    static REG_QWORD_LITTLE_ENDIAN := 11
}
struct REG_SAM_FLAGS extends UInt32 {
    static KEY_QUERY_VALUE := 1
    static KEY_SET_VALUE := 2
    static KEY_CREATE_SUB_KEY := 4
    static KEY_ENUMERATE_SUB_KEYS := 8
    static KEY_NOTIFY := 16
    static KEY_CREATE_LINK := 32
    static KEY_WOW64_32KEY := 512
    static KEY_WOW64_64KEY := 256
    static KEY_WOW64_RES := 768
    static KEY_READ := 131097
    static KEY_WRITE := 131078
    static KEY_EXECUTE := 131097
    static KEY_ALL_ACCESS := 983103
}
struct REG_OPEN_CREATE_OPTIONS extends UInt32 {
    static REG_OPTION_RESERVED := 0
    static REG_OPTION_NON_VOLATILE := 0
    static REG_OPTION_VOLATILE := 1
    static REG_OPTION_CREATE_LINK := 2
    static REG_OPTION_BACKUP_RESTORE := 4
    static REG_OPTION_OPEN_LINK := 8
    static REG_OPTION_DONT_VIRTUALIZE := 16
}
struct REG_CREATE_KEY_DISPOSITION extends UInt32 {
    static REG_CREATED_NEW_KEY := 1
    static REG_OPENED_EXISTING_KEY := 2
}
struct REG_SAVE_FORMAT extends UInt32 {
    static REG_STANDARD_FORMAT := 1
    static REG_LATEST_FORMAT := 2
    static REG_NO_COMPRESSION := 4
}
struct REG_RESTORE_KEY_FLAGS extends Int32 {
    static REG_FORCE_RESTORE := 8
    static REG_WHOLE_HIVE_VOLATILE := 1
}
struct REG_NOTIFY_FILTER extends UInt32 {
    static REG_NOTIFY_CHANGE_NAME := 1
    static REG_NOTIFY_CHANGE_ATTRIBUTES := 2
    static REG_NOTIFY_CHANGE_LAST_SET := 4
    static REG_NOTIFY_CHANGE_SECURITY := 8
    static REG_NOTIFY_THREAD_AGNOSTIC := 268435456
}
struct REG_ROUTINE_FLAGS extends UInt32 {
    static RRF_RT_DWORD := 24
    static RRF_RT_QWORD := 72
    static RRF_RT_REG_NONE := 1
    static RRF_RT_REG_SZ := 2
    static RRF_RT_REG_EXPAND_SZ := 4
    static RRF_RT_REG_BINARY := 8
    static RRF_RT_REG_DWORD := 16
    static RRF_RT_REG_MULTI_SZ := 32
    static RRF_RT_REG_QWORD := 64
    static RRF_RT_ANY := 65535
    static RRF_SUBKEY_WOW6464KEY := 65536
    static RRF_SUBKEY_WOW6432KEY := 131072
    static RRF_WOW64_MASK := 196608
    static RRF_NOEXPAND := 268435456
    static RRF_ZEROONFAILURE := 536870912
}
struct HKEY {
    Value : IntPtr
}
struct val_context {
    valuelen : Int32
    value_context : Struct.Ptr
    val_buff_ptr : Struct.Ptr
}
struct PVALUEA {
    pv_valuename : PSTR
    pv_valuelen : Int32
    pv_value_context : Struct.Ptr
    pv_type : UInt32
}
struct PVALUEW {
    pv_valuename : PWSTR
    pv_valuelen : Int32
    pv_value_context : Struct.Ptr
    pv_type : UInt32
}
struct PQUERYHANDLER extends FunctionPointer {
    static Types := [Struct.Ptr, val_context.Ptr, UInt32, Struct.Ptr, UInt32.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct REG_PROVIDER {
    pi_R0_1val : PQUERYHANDLER
    pi_R0_allvals : PQUERYHANDLER
    pi_R3_1val : PQUERYHANDLER
    pi_R3_allvals : PQUERYHANDLER
    pi_flags : UInt32
    pi_key_context : Struct.Ptr
}
struct VALENTA {
    ve_valuename : PSTR
    ve_valuelen : UInt32
    ve_valueptr : IntPtr
    ve_type : REG_VALUE_TYPE
}
struct VALENTW {
    ve_valuename : PWSTR
    ve_valuelen : UInt32
    ve_valueptr : IntPtr
    ve_type : REG_VALUE_TYPE
}
struct DSKTLSYSTEMTIME {
    wYear : UInt16
    wMonth : UInt16
    wDayOfWeek : UInt16
    wDay : UInt16
    wHour : UInt16
    wMinute : UInt16
    wSecond : UInt16
    wMilliseconds : UInt16
    wResult : UInt16
}
