#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HWND, LPARAM, LUID, PWSTR}
#Import "..\Security\Types.ahk" {QUOTA_LIMITS}
#Import "..\System.StationsAndDesktops\Types.ahk" {HDESK}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {DLGPROC, DLGTEMPLATE}

struct WLX_SHUTDOWN_TYPE extends UInt32 {
    static WLX_SAS_ACTION_SHUTDOWN := 5
    static WLX_SAS_ACTION_SHUTDOWN_REBOOT := 11
    static WLX_SAS_ACTION_SHUTDOWN_POWER_OFF := 10
}
struct WLX_SC_NOTIFICATION_INFO {
    pszCard : PWSTR
    pszReader : PWSTR
    pszContainer : PWSTR
    pszCryptoProvider : PWSTR
}
struct WLX_PROFILE_V1_0 {
    dwType : UInt32
    pszProfile : PWSTR
}
struct WLX_PROFILE_V2_0 {
    dwType : UInt32
    pszProfile : PWSTR
    pszPolicy : PWSTR
    pszNetworkDefaultUserProfile : PWSTR
    pszServerName : PWSTR
    pszEnvironment : PWSTR
}
struct WLX_MPR_NOTIFY_INFO {
    pszUserName : PWSTR
    pszDomain : PWSTR
    pszPassword : PWSTR
    pszOldPassword : PWSTR
}
struct WLX_TERMINAL_SERVICES_DATA {
    ProfilePath : UInt16[257]
    HomeDir : UInt16[257]
    HomeDirDrive : UInt16[4]
}
struct WLX_CLIENT_CREDENTIALS_INFO_V1_0 {
    dwType : UInt32
    pszUserName : PWSTR
    pszDomain : PWSTR
    pszPassword : PWSTR
    fPromptForPassword : BOOL
}
struct WLX_CLIENT_CREDENTIALS_INFO_V2_0 {
    dwType : UInt32
    pszUserName : PWSTR
    pszDomain : PWSTR
    pszPassword : PWSTR
    fPromptForPassword : BOOL
    fDisconnectOnLogonFailure : BOOL
}
struct WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0 {
    dwType : UInt32
    UserToken : HANDLE
    LogonId : LUID
    Quotas : QUOTA_LIMITS
    UserName : PWSTR
    Domain : PWSTR
    LogonTime : Int64
    SmartCardLogon : BOOL
    ProfileLength : UInt32
    MessageType : UInt32
    LogonCount : UInt16
    BadPasswordCount : UInt16
    ProfileLogonTime : Int64
    LogoffTime : Int64
    KickOffTime : Int64
    PasswordLastSet : Int64
    PasswordCanChange : Int64
    PasswordMustChange : Int64
    LogonScript : PWSTR
    HomeDirectory : PWSTR
    FullName : PWSTR
    ProfilePath : PWSTR
    HomeDirectoryDrive : PWSTR
    LogonServer : PWSTR
    UserFlags : UInt32
    PrivateDataLen : UInt32
    PrivateData : UInt8.Ptr
}
struct WLX_DESKTOP {
    Size : UInt32
    Flags : UInt32
    hDesktop : HDESK
    pszDesktopName : PWSTR
}
struct PWLX_USE_CTRL_ALT_DEL extends FunctionPointer {
    static Types := [HANDLE, "Void"]
}
struct PWLX_SET_CONTEXT_POINTER extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, "Void"]
}
struct PWLX_SAS_NOTIFY extends FunctionPointer {
    static Types := [HANDLE, UInt32, "Void"]
}
struct PWLX_SET_TIMEOUT extends FunctionPointer {
    static Types := [HANDLE, UInt32, BOOL]
}
struct PWLX_ASSIGN_SHELL_PROTECTION extends FunctionPointer {
    static Types := [HANDLE, HANDLE, HANDLE, HANDLE, Int32]
}
struct PWLX_MESSAGE_BOX extends FunctionPointer {
    static Types := [HANDLE, HWND, PWSTR, PWSTR, UInt32, Int32]
}
struct PWLX_DIALOG_BOX extends FunctionPointer {
    static Types := [HANDLE, HANDLE, PWSTR, HWND, DLGPROC, Int32]
}
struct PWLX_DIALOG_BOX_INDIRECT extends FunctionPointer {
    static Types := [HANDLE, HANDLE, DLGTEMPLATE.Ptr, HWND, DLGPROC, Int32]
}
struct PWLX_DIALOG_BOX_PARAM extends FunctionPointer {
    static Types := [HANDLE, HANDLE, PWSTR, HWND, DLGPROC, LPARAM, Int32]
}
struct PWLX_DIALOG_BOX_INDIRECT_PARAM extends FunctionPointer {
    static Types := [HANDLE, HANDLE, DLGTEMPLATE.Ptr, HWND, DLGPROC, LPARAM, Int32]
}
struct PWLX_SWITCH_DESKTOP_TO_USER extends FunctionPointer {
    static Types := [HANDLE, Int32]
}
struct PWLX_SWITCH_DESKTOP_TO_WINLOGON extends FunctionPointer {
    static Types := [HANDLE, Int32]
}
struct PWLX_CHANGE_PASSWORD_NOTIFY extends FunctionPointer {
    static Types := [HANDLE, WLX_MPR_NOTIFY_INFO.Ptr, UInt32, Int32]
}
struct PWLX_GET_SOURCE_DESKTOP extends FunctionPointer {
    static Types := [HANDLE, WLX_DESKTOP.Ptr.Ptr, BOOL]
}
struct PWLX_SET_RETURN_DESKTOP extends FunctionPointer {
    static Types := [HANDLE, WLX_DESKTOP.Ptr, BOOL]
}
struct PWLX_CREATE_USER_DESKTOP extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, PWSTR, WLX_DESKTOP.Ptr.Ptr, BOOL]
}
struct PWLX_CHANGE_PASSWORD_NOTIFY_EX extends FunctionPointer {
    static Types := [HANDLE, WLX_MPR_NOTIFY_INFO.Ptr, UInt32, PWSTR, Struct.Ptr, Int32]
}
struct PWLX_CLOSE_USER_DESKTOP extends FunctionPointer {
    static Types := [HANDLE, WLX_DESKTOP.Ptr, HANDLE, BOOL]
}
struct PWLX_SET_OPTION extends FunctionPointer {
    static Types := [HANDLE, UInt32, IntPtr, IntPtr.Ptr, BOOL]
}
struct PWLX_GET_OPTION extends FunctionPointer {
    static Types := [HANDLE, UInt32, IntPtr.Ptr, BOOL]
}
struct PWLX_WIN31_MIGRATE extends FunctionPointer {
    static Types := [HANDLE, "Void"]
}
struct PWLX_QUERY_CLIENT_CREDENTIALS extends FunctionPointer {
    static Types := [WLX_CLIENT_CREDENTIALS_INFO_V1_0.Ptr, BOOL]
}
struct PWLX_QUERY_IC_CREDENTIALS extends FunctionPointer {
    static Types := [WLX_CLIENT_CREDENTIALS_INFO_V1_0.Ptr, BOOL]
}
struct PWLX_QUERY_TS_LOGON_CREDENTIALS extends FunctionPointer {
    static Types := [WLX_CLIENT_CREDENTIALS_INFO_V2_0.Ptr, BOOL]
}
struct PWLX_DISCONNECT extends FunctionPointer {
    static Types := [BOOL]
}
struct PWLX_QUERY_TERMINAL_SERVICES_DATA extends FunctionPointer {
    static Types := [HANDLE, WLX_TERMINAL_SERVICES_DATA.Ptr, PWSTR, PWSTR, UInt32]
}
struct PWLX_QUERY_CONSOLESWITCH_CREDENTIALS extends FunctionPointer {
    static Types := [WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0.Ptr, UInt32]
}
struct WLX_DISPATCH_VERSION_1_0 {
    WlxUseCtrlAltDel : PWLX_USE_CTRL_ALT_DEL
    WlxSetContextPointer : PWLX_SET_CONTEXT_POINTER
    WlxSasNotify : PWLX_SAS_NOTIFY
    WlxSetTimeout : PWLX_SET_TIMEOUT
    WlxAssignShellProtection : PWLX_ASSIGN_SHELL_PROTECTION
    WlxMessageBox : PWLX_MESSAGE_BOX
    WlxDialogBox : PWLX_DIALOG_BOX
    WlxDialogBoxParam : PWLX_DIALOG_BOX_PARAM
    WlxDialogBoxIndirect : PWLX_DIALOG_BOX_INDIRECT
    WlxDialogBoxIndirectParam : PWLX_DIALOG_BOX_INDIRECT_PARAM
    WlxSwitchDesktopToUser : PWLX_SWITCH_DESKTOP_TO_USER
    WlxSwitchDesktopToWinlogon : PWLX_SWITCH_DESKTOP_TO_WINLOGON
    WlxChangePasswordNotify : PWLX_CHANGE_PASSWORD_NOTIFY
}
struct WLX_DISPATCH_VERSION_1_1 {
    WlxUseCtrlAltDel : PWLX_USE_CTRL_ALT_DEL
    WlxSetContextPointer : PWLX_SET_CONTEXT_POINTER
    WlxSasNotify : PWLX_SAS_NOTIFY
    WlxSetTimeout : PWLX_SET_TIMEOUT
    WlxAssignShellProtection : PWLX_ASSIGN_SHELL_PROTECTION
    WlxMessageBox : PWLX_MESSAGE_BOX
    WlxDialogBox : PWLX_DIALOG_BOX
    WlxDialogBoxParam : PWLX_DIALOG_BOX_PARAM
    WlxDialogBoxIndirect : PWLX_DIALOG_BOX_INDIRECT
    WlxDialogBoxIndirectParam : PWLX_DIALOG_BOX_INDIRECT_PARAM
    WlxSwitchDesktopToUser : PWLX_SWITCH_DESKTOP_TO_USER
    WlxSwitchDesktopToWinlogon : PWLX_SWITCH_DESKTOP_TO_WINLOGON
    WlxChangePasswordNotify : PWLX_CHANGE_PASSWORD_NOTIFY
    WlxGetSourceDesktop : PWLX_GET_SOURCE_DESKTOP
    WlxSetReturnDesktop : PWLX_SET_RETURN_DESKTOP
    WlxCreateUserDesktop : PWLX_CREATE_USER_DESKTOP
    WlxChangePasswordNotifyEx : PWLX_CHANGE_PASSWORD_NOTIFY_EX
}
struct WLX_DISPATCH_VERSION_1_2 {
    WlxUseCtrlAltDel : PWLX_USE_CTRL_ALT_DEL
    WlxSetContextPointer : PWLX_SET_CONTEXT_POINTER
    WlxSasNotify : PWLX_SAS_NOTIFY
    WlxSetTimeout : PWLX_SET_TIMEOUT
    WlxAssignShellProtection : PWLX_ASSIGN_SHELL_PROTECTION
    WlxMessageBox : PWLX_MESSAGE_BOX
    WlxDialogBox : PWLX_DIALOG_BOX
    WlxDialogBoxParam : PWLX_DIALOG_BOX_PARAM
    WlxDialogBoxIndirect : PWLX_DIALOG_BOX_INDIRECT
    WlxDialogBoxIndirectParam : PWLX_DIALOG_BOX_INDIRECT_PARAM
    WlxSwitchDesktopToUser : PWLX_SWITCH_DESKTOP_TO_USER
    WlxSwitchDesktopToWinlogon : PWLX_SWITCH_DESKTOP_TO_WINLOGON
    WlxChangePasswordNotify : PWLX_CHANGE_PASSWORD_NOTIFY
    WlxGetSourceDesktop : PWLX_GET_SOURCE_DESKTOP
    WlxSetReturnDesktop : PWLX_SET_RETURN_DESKTOP
    WlxCreateUserDesktop : PWLX_CREATE_USER_DESKTOP
    WlxChangePasswordNotifyEx : PWLX_CHANGE_PASSWORD_NOTIFY_EX
    WlxCloseUserDesktop : PWLX_CLOSE_USER_DESKTOP
}
struct WLX_DISPATCH_VERSION_1_3 {
    WlxUseCtrlAltDel : PWLX_USE_CTRL_ALT_DEL
    WlxSetContextPointer : PWLX_SET_CONTEXT_POINTER
    WlxSasNotify : PWLX_SAS_NOTIFY
    WlxSetTimeout : PWLX_SET_TIMEOUT
    WlxAssignShellProtection : PWLX_ASSIGN_SHELL_PROTECTION
    WlxMessageBox : PWLX_MESSAGE_BOX
    WlxDialogBox : PWLX_DIALOG_BOX
    WlxDialogBoxParam : PWLX_DIALOG_BOX_PARAM
    WlxDialogBoxIndirect : PWLX_DIALOG_BOX_INDIRECT
    WlxDialogBoxIndirectParam : PWLX_DIALOG_BOX_INDIRECT_PARAM
    WlxSwitchDesktopToUser : PWLX_SWITCH_DESKTOP_TO_USER
    WlxSwitchDesktopToWinlogon : PWLX_SWITCH_DESKTOP_TO_WINLOGON
    WlxChangePasswordNotify : PWLX_CHANGE_PASSWORD_NOTIFY
    WlxGetSourceDesktop : PWLX_GET_SOURCE_DESKTOP
    WlxSetReturnDesktop : PWLX_SET_RETURN_DESKTOP
    WlxCreateUserDesktop : PWLX_CREATE_USER_DESKTOP
    WlxChangePasswordNotifyEx : PWLX_CHANGE_PASSWORD_NOTIFY_EX
    WlxCloseUserDesktop : PWLX_CLOSE_USER_DESKTOP
    WlxSetOption : PWLX_SET_OPTION
    WlxGetOption : PWLX_GET_OPTION
    WlxWin31Migrate : PWLX_WIN31_MIGRATE
    WlxQueryClientCredentials : PWLX_QUERY_CLIENT_CREDENTIALS
    WlxQueryInetConnectorCredentials : PWLX_QUERY_IC_CREDENTIALS
    WlxDisconnect : PWLX_DISCONNECT
    WlxQueryTerminalServicesData : PWLX_QUERY_TERMINAL_SERVICES_DATA
}
struct WLX_DISPATCH_VERSION_1_4 {
    WlxUseCtrlAltDel : PWLX_USE_CTRL_ALT_DEL
    WlxSetContextPointer : PWLX_SET_CONTEXT_POINTER
    WlxSasNotify : PWLX_SAS_NOTIFY
    WlxSetTimeout : PWLX_SET_TIMEOUT
    WlxAssignShellProtection : PWLX_ASSIGN_SHELL_PROTECTION
    WlxMessageBox : PWLX_MESSAGE_BOX
    WlxDialogBox : PWLX_DIALOG_BOX
    WlxDialogBoxParam : PWLX_DIALOG_BOX_PARAM
    WlxDialogBoxIndirect : PWLX_DIALOG_BOX_INDIRECT
    WlxDialogBoxIndirectParam : PWLX_DIALOG_BOX_INDIRECT_PARAM
    WlxSwitchDesktopToUser : PWLX_SWITCH_DESKTOP_TO_USER
    WlxSwitchDesktopToWinlogon : PWLX_SWITCH_DESKTOP_TO_WINLOGON
    WlxChangePasswordNotify : PWLX_CHANGE_PASSWORD_NOTIFY
    WlxGetSourceDesktop : PWLX_GET_SOURCE_DESKTOP
    WlxSetReturnDesktop : PWLX_SET_RETURN_DESKTOP
    WlxCreateUserDesktop : PWLX_CREATE_USER_DESKTOP
    WlxChangePasswordNotifyEx : PWLX_CHANGE_PASSWORD_NOTIFY_EX
    WlxCloseUserDesktop : PWLX_CLOSE_USER_DESKTOP
    WlxSetOption : PWLX_SET_OPTION
    WlxGetOption : PWLX_GET_OPTION
    WlxWin31Migrate : PWLX_WIN31_MIGRATE
    WlxQueryClientCredentials : PWLX_QUERY_CLIENT_CREDENTIALS
    WlxQueryInetConnectorCredentials : PWLX_QUERY_IC_CREDENTIALS
    WlxDisconnect : PWLX_DISCONNECT
    WlxQueryTerminalServicesData : PWLX_QUERY_TERMINAL_SERVICES_DATA
    WlxQueryConsoleSwitchCredentials : PWLX_QUERY_CONSOLESWITCH_CREDENTIALS
    WlxQueryTsLogonCredentials : PWLX_QUERY_TS_LOGON_CREDENTIALS
}
struct PFNMSGECALLBACK extends FunctionPointer {
    static Types := [BOOL, PWSTR, UInt32]
}
struct WLX_NOTIFICATION_INFO {
    Size : UInt32
    Flags : UInt32
    UserName : PWSTR
    Domain : PWSTR
    WindowStation : PWSTR
    hToken : HANDLE
    hDesktop : HDESK
    pStatusCallback : PFNMSGECALLBACK
}
