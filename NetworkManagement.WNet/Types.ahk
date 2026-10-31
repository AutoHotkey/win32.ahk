#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HWND, LUID, PSTR, PWSTR, WIN32_ERROR}

struct UNC_INFO_LEVEL extends UInt32 {
    static UNIVERSAL_NAME_INFO_LEVEL := 1
    static REMOTE_NAME_INFO_LEVEL := 2
}
struct WNPERM_DLG extends UInt32 {
    static WNPERM_DLG_PERM := 0
    static WNPERM_DLG_AUDIT := 1
    static WNPERM_DLG_OWNER := 2
}
struct WNET_OPEN_ENUM_USAGE extends UInt32 {
    static RESOURCEUSAGE_NONE := 0
    static RESOURCEUSAGE_CONNECTABLE := 1
    static RESOURCEUSAGE_CONTAINER := 2
    static RESOURCEUSAGE_ATTACHED := 16
    static RESOURCEUSAGE_ALL := 19
}
struct NET_CONNECT_FLAGS extends UInt32 {
    static CONNECT_UPDATE_PROFILE := 1
    static CONNECT_UPDATE_RECENT := 2
    static CONNECT_TEMPORARY := 4
    static CONNECT_INTERACTIVE := 8
    static CONNECT_PROMPT := 16
    static CONNECT_NEED_DRIVE := 32
    static CONNECT_REFCOUNT := 64
    static CONNECT_REDIRECT := 128
    static CONNECT_LOCALDRIVE := 256
    static CONNECT_CURRENT_MEDIA := 512
    static CONNECT_DEFERRED := 1024
    static CONNECT_RESERVED := 4278190080
    static CONNECT_COMMANDLINE := 2048
    static CONNECT_CMD_SAVECRED := 4096
    static CONNECT_CRED_RESET := 8192
    static CONNECT_REQUIRE_INTEGRITY := 16384
    static CONNECT_REQUIRE_PRIVACY := 32768
    static CONNECT_WRITE_THROUGH_SEMANTICS := 65536
    static CONNECT_GLOBAL_MAPPING := 262144
}
struct NP_PROPERTY_DIALOG_SELECTION extends UInt32 {
    static WNPS_FILE := 0
    static WNPS_DIR := 1
    static WNPS_MULT := 2
}
struct NPDIRECTORY_NOTIFY_OPERATION extends UInt32 {
    static WNDN_MKDIR := 1
    static WNDN_RMDIR := 2
    static WNDN_MVDIR := 3
}
struct NET_RESOURCE_TYPE extends UInt32 {
    static RESOURCETYPE_ANY := 0
    static RESOURCETYPE_DISK := 1
    static RESOURCETYPE_PRINT := 2
}
struct NETWORK_NAME_FORMAT_FLAGS extends UInt32 {
    static WNFMT_MULTILINE := 1
    static WNFMT_ABBREVIATED := 2
}
struct NET_RESOURCE_SCOPE extends UInt32 {
    static RESOURCE_CONNECTED := 1
    static RESOURCE_CONTEXT := 5
    static RESOURCE_GLOBALNET := 2
    static RESOURCE_REMEMBERED := 3
}
struct NETINFOSTRUCT_CHARACTERISTICS extends UInt32 {
    static NETINFO_DLL16 := 1
    static NETINFO_DISKRED := 4
    static NETINFO_PRINTERRED := 8
}
struct CONNECTDLGSTRUCT_FLAGS extends UInt32 {
    static CONNDLG_RO_PATH := 1
    static CONNDLG_CONN_POINT := 2
    static CONNDLG_USE_MRU := 4
    static CONNDLG_HIDE_BOX := 8
    static CONNDLG_PERSIST := 16
    static CONNDLG_NOT_PERSIST := 32
}
struct DISCDLGSTRUCT_FLAGS extends UInt32 {
    static DISC_UPDATE_PROFILE := 1
    static DISC_NO_FORCE := 64
}
struct NETRESOURCEA {
    dwScope : NET_RESOURCE_SCOPE
    dwType : NET_RESOURCE_TYPE
    dwDisplayType : UInt32
    dwUsage : UInt32
    lpLocalName : PSTR
    lpRemoteName : PSTR
    lpComment : PSTR
    lpProvider : PSTR
}
struct NETRESOURCEW {
    dwScope : NET_RESOURCE_SCOPE
    dwType : NET_RESOURCE_TYPE
    dwDisplayType : UInt32
    dwUsage : UInt32
    lpLocalName : PWSTR
    lpRemoteName : PWSTR
    lpComment : PWSTR
    lpProvider : PWSTR
}
struct CONNECTDLGSTRUCTA {
    cbStructure : UInt32
    hwndOwner : HWND
    lpConnRes : NETRESOURCEA.Ptr
    dwFlags : CONNECTDLGSTRUCT_FLAGS
    dwDevNum : UInt32
}
struct CONNECTDLGSTRUCTW {
    cbStructure : UInt32
    hwndOwner : HWND
    lpConnRes : NETRESOURCEW.Ptr
    dwFlags : CONNECTDLGSTRUCT_FLAGS
    dwDevNum : UInt32
}
struct DISCDLGSTRUCTA {
    cbStructure : UInt32
    hwndOwner : HWND
    lpLocalName : PSTR
    lpRemoteName : PSTR
    dwFlags : DISCDLGSTRUCT_FLAGS
}
struct DISCDLGSTRUCTW {
    cbStructure : UInt32
    hwndOwner : HWND
    lpLocalName : PWSTR
    lpRemoteName : PWSTR
    dwFlags : DISCDLGSTRUCT_FLAGS
}
struct UNIVERSAL_NAME_INFOA {
    lpUniversalName : PSTR
}
struct UNIVERSAL_NAME_INFOW {
    lpUniversalName : PWSTR
}
struct REMOTE_NAME_INFOA {
    lpUniversalName : PSTR
    lpConnectionName : PSTR
    lpRemainingPath : PSTR
}
struct REMOTE_NAME_INFOW {
    lpUniversalName : PWSTR
    lpConnectionName : PWSTR
    lpRemainingPath : PWSTR
}
struct NETINFOSTRUCT {
    cbStructure : UInt32
    dwProviderVersion : UInt32
    dwStatus : WIN32_ERROR
    dwCharacteristics : NETINFOSTRUCT_CHARACTERISTICS
    dwHandle : IntPtr
    wNetType : UInt16
    dwPrinters : UInt32
    dwDrives : UInt32
}
struct NETCONNECTINFOSTRUCT {
    cbStructure : UInt32
    dwFlags : UInt32
    dwSpeed : UInt32
    dwDelay : UInt32
    dwOptDataSize : UInt32
}
struct PF_NPAddConnection extends FunctionPointer {
    static Types := [NETRESOURCEW.Ptr, PWSTR, PWSTR, UInt32]
}
struct PF_NPAddConnection3 extends FunctionPointer {
    static Types := [HWND, NETRESOURCEW.Ptr, PWSTR, PWSTR, UInt32, UInt32]
}
struct PF_NPAddConnection4 extends FunctionPointer {
    static Types := [HWND, NETRESOURCEW.Ptr, Struct.Ptr, UInt32, UInt32, UInt8.Ptr, UInt32, UInt32]
}
struct PF_NPCancelConnection extends FunctionPointer {
    static Types := [PWSTR, BOOL, UInt32]
}
struct PF_NPCancelConnection2 extends FunctionPointer {
    static Types := [PWSTR, BOOL, UInt32, UInt32]
}
struct PF_NPGetConnection extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, UInt32]
}
struct PF_NPGetConnection3 extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct PF_NPGetUniversalName extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct PF_NPGetConnectionPerformance extends FunctionPointer {
    static Types := [PWSTR, NETCONNECTINFOSTRUCT.Ptr, UInt32]
}
struct PF_NPOpenEnum extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, NETRESOURCEW.Ptr, HANDLE.Ptr, UInt32]
}
struct PF_NPEnumResource extends FunctionPointer {
    static Types := [HANDLE, UInt32.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct PF_NPCloseEnum extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct PF_NPGetCaps extends FunctionPointer {
    static Types := [UInt32, UInt32]
}
struct PF_NPGetUser extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, UInt32]
}
struct PF_NPGetPersistentUseOptionsForConnection extends FunctionPointer {
    static Types := [PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32.Ptr, UInt32]
}
struct PF_NPDeviceMode extends FunctionPointer {
    static Types := [HWND, UInt32]
}
struct PF_NPSearchDialog extends FunctionPointer {
    static Types := [HWND, NETRESOURCEW.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PF_NPGetResourceParent extends FunctionPointer {
    static Types := [NETRESOURCEW.Ptr, Struct.Ptr, UInt32.Ptr, UInt32]
}
struct PF_NPGetResourceInformation extends FunctionPointer {
    static Types := [NETRESOURCEW.Ptr, Struct.Ptr, UInt32.Ptr, PWSTR.Ptr, UInt32]
}
struct PF_NPFormatNetworkName extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, UInt32, UInt32, UInt32]
}
struct PF_NPGetPropertyText extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, PWSTR, UInt32, UInt32, UInt32]
}
struct PF_NPPropertyDialog extends FunctionPointer {
    static Types := [HWND, UInt32, UInt32, PWSTR, UInt32, UInt32]
}
struct PF_NPGetDirectoryType extends FunctionPointer {
    static Types := [PWSTR, Int32.Ptr, BOOL, UInt32]
}
struct PF_NPDirectoryNotify extends FunctionPointer {
    static Types := [HWND, PWSTR, UInt32, UInt32]
}
struct PF_NPLogonNotify extends FunctionPointer {
    static Types := [LUID.Ptr, PWSTR, Struct.Ptr, PWSTR, Struct.Ptr, PWSTR, Struct.Ptr, PWSTR.Ptr, UInt32]
}
struct PF_NPPasswordChangeNotify extends FunctionPointer {
    static Types := [PWSTR, Struct.Ptr, PWSTR, Struct.Ptr, PWSTR, Struct.Ptr, UInt32, UInt32]
}
struct NOTIFYINFO {
    dwNotifyStatus : UInt32
    dwOperationStatus : UInt32
    lpContext : Struct.Ptr
}
struct NOTIFYADD {
    hwndOwner : HWND
    NetResource : NETRESOURCEA
    dwAddFlags : NET_CONNECT_FLAGS
}
struct NOTIFYCANCEL {
    lpName : PWSTR
    lpProvider : PWSTR
    dwFlags : UInt32
    fForce : BOOL
}
struct PF_AddConnectNotify extends FunctionPointer {
    static Types := [NOTIFYINFO.Ptr, NOTIFYADD.Ptr, UInt32]
}
struct PF_CancelConnectNotify extends FunctionPointer {
    static Types := [NOTIFYINFO.Ptr, NOTIFYCANCEL.Ptr, UInt32]
}
struct PF_NPFMXGetPermCaps extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PF_NPFMXEditPerm extends FunctionPointer {
    static Types := [PWSTR, HWND, UInt32, UInt32]
}
struct PF_NPFMXGetPermHelp extends FunctionPointer {
    static Types := [PWSTR, UInt32, BOOL, Struct.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
