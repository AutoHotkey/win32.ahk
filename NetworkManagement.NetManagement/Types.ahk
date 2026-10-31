#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMNodeList}
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HRESULT, HWND, PWSTR}
#Import "..\Security\Types.ahk" {PSID, SID_NAME_USE}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}

struct NET_REQUEST_PROVISION_OPTIONS extends UInt32 {
    static NETSETUP_PROVISION_ONLINE_CALLER := 1073741824
}
struct NET_JOIN_DOMAIN_JOIN_OPTIONS extends UInt32 {
    static NETSETUP_JOIN_DOMAIN := 1
    static NETSETUP_ACCT_CREATE := 2
    static NETSETUP_WIN9X_UPGRADE := 16
    static NETSETUP_DOMAIN_JOIN_IF_JOINED := 32
    static NETSETUP_JOIN_UNSECURE := 64
    static NETSETUP_MACHINE_PWD_PASSED := 128
    static NETSETUP_DEFER_SPN_SET := 256
    static NETSETUP_JOIN_DC_ACCOUNT := 512
    static NETSETUP_JOIN_WITH_NEW_NAME := 1024
    static NETSETUP_JOIN_READONLY := 2048
    static NETSETUP_AMBIGUOUS_DC := 4096
    static NETSETUP_NO_NETLOGON_CACHE := 8192
    static NETSETUP_DONT_CONTROL_SERVICES := 16384
    static NETSETUP_SET_MACHINE_NAME := 32768
    static NETSETUP_FORCE_SPN_SET := 65536
    static NETSETUP_NO_ACCT_REUSE := 131072
    static NETSETUP_IGNORE_UNSUPPORTED_FLAGS := 268435456
}
struct NET_REMOTE_COMPUTER_SUPPORTS_OPTIONS extends UInt32 {
    static SUPPORTS_REMOTE_ADMIN_PROTOCOL := 2
    static SUPPORTS_RPC := 4
    static SUPPORTS_SAM_PROTOCOL := 8
    static SUPPORTS_UNICODE := 16
    static SUPPORTS_LOCAL := 32
}
struct FORCE_LEVEL_FLAGS extends UInt32 {
    static USE_NOFORCE := 0
    static USE_FORCE := 1
    static USE_LOTS_OF_FORCE := 2
}
struct NET_SERVER_TYPE extends UInt32 {
    static SV_TYPE_WORKSTATION := 1
    static SV_TYPE_SERVER := 2
    static SV_TYPE_SQLSERVER := 4
    static SV_TYPE_DOMAIN_CTRL := 8
    static SV_TYPE_DOMAIN_BAKCTRL := 16
    static SV_TYPE_TIME_SOURCE := 32
    static SV_TYPE_AFP := 64
    static SV_TYPE_NOVELL := 128
    static SV_TYPE_DOMAIN_MEMBER := 256
    static SV_TYPE_PRINTQ_SERVER := 512
    static SV_TYPE_DIALIN_SERVER := 1024
    static SV_TYPE_XENIX_SERVER := 2048
    static SV_TYPE_SERVER_UNIX := 2048
    static SV_TYPE_NT := 4096
    static SV_TYPE_WFW := 8192
    static SV_TYPE_SERVER_MFPN := 16384
    static SV_TYPE_SERVER_NT := 32768
    static SV_TYPE_POTENTIAL_BROWSER := 65536
    static SV_TYPE_BACKUP_BROWSER := 131072
    static SV_TYPE_MASTER_BROWSER := 262144
    static SV_TYPE_DOMAIN_MASTER := 524288
    static SV_TYPE_SERVER_OSF := 1048576
    static SV_TYPE_SERVER_VMS := 2097152
    static SV_TYPE_WINDOWS := 4194304
    static SV_TYPE_DFS := 8388608
    static SV_TYPE_CLUSTER_NT := 16777216
    static SV_TYPE_TERMINALSERVER := 33554432
    static SV_TYPE_CLUSTER_VS_NT := 67108864
    static SV_TYPE_DCE := 268435456
    static SV_TYPE_ALTERNATE_XPORT := 536870912
    static SV_TYPE_LOCAL_LIST_ONLY := 1073741824
    static SV_TYPE_DOMAIN_ENUM := 2147483648
    static SV_TYPE_ALL := 4294967295
}
struct NET_USER_ENUM_FILTER_FLAGS extends UInt32 {
    static FILTER_TEMP_DUPLICATE_ACCOUNT := 1
    static FILTER_NORMAL_ACCOUNT := 2
    static FILTER_INTERDOMAIN_TRUST_ACCOUNT := 8
    static FILTER_WORKSTATION_TRUST_ACCOUNT := 16
    static FILTER_SERVER_TRUST_ACCOUNT := 32
}
struct NETSETUP_PROVISION extends UInt32 {
    static NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT := 1
    static NETSETUP_PROVISION_REUSE_ACCOUNT := 2
    static NETSETUP_PROVISION_USE_DEFAULT_PASSWORD := 4
    static NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH := 8
    static NETSETUP_PROVISION_ROOT_CA_CERTS := 16
}
struct USER_ACCOUNT_FLAGS extends UInt32 {
    static UF_SCRIPT := 1
    static UF_ACCOUNTDISABLE := 2
    static UF_HOMEDIR_REQUIRED := 8
    static UF_PASSWD_NOTREQD := 32
    static UF_PASSWD_CANT_CHANGE := 64
    static UF_LOCKOUT := 16
    static UF_DONT_EXPIRE_PASSWD := 65536
    static UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED := 128
    static UF_NOT_DELEGATED := 1048576
    static UF_SMARTCARD_REQUIRED := 262144
    static UF_USE_DES_KEY_ONLY := 2097152
    static UF_DONT_REQUIRE_PREAUTH := 4194304
    static UF_TRUSTED_FOR_DELEGATION := 524288
    static UF_PASSWORD_EXPIRED := 8388608
    static UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION := 16777216
}
struct AF_OP extends UInt32 {
    static AF_OP_PRINT := 1
    static AF_OP_COMM := 2
    static AF_OP_SERVER := 4
    static AF_OP_ACCOUNTS := 8
}
struct SERVER_INFO_SECURITY extends UInt32 {
    static SV_SHARESECURITY := 0
    static SV_USERSECURITY := 1
}
struct USER_PRIV extends UInt32 {
    static USER_PRIV_GUEST := 0
    static USER_PRIV_USER := 1
    static USER_PRIV_ADMIN := 2
}
struct USE_INFO_ASG_TYPE extends UInt32 {
    static USE_WILDCARD := 4294967295
    static USE_DISKDEV := 0
    static USE_SPOOLDEV := 1
    static USE_IPC := 3
}
struct SERVER_INFO_HIDDEN extends Int32 {
    static SV_VISIBLE := 0
    static SV_HIDDEN := 1
}
struct USER_MODALS_ROLES extends UInt32 {
    static UAS_ROLE_STANDALONE := 0
    static UAS_ROLE_MEMBER := 1
    static UAS_ROLE_BACKUP := 2
    static UAS_ROLE_PRIMARY := 3
}
struct USER_INFO_0 {
    usri0_name : PWSTR
}
struct USER_INFO_1 {
    usri1_name : PWSTR
    usri1_password : PWSTR
    usri1_password_age : UInt32
    usri1_priv : USER_PRIV
    usri1_home_dir : PWSTR
    usri1_comment : PWSTR
    usri1_flags : USER_ACCOUNT_FLAGS
    usri1_script_path : PWSTR
}
struct USER_INFO_2 {
    usri2_name : PWSTR
    usri2_password : PWSTR
    usri2_password_age : UInt32
    usri2_priv : USER_PRIV
    usri2_home_dir : PWSTR
    usri2_comment : PWSTR
    usri2_flags : USER_ACCOUNT_FLAGS
    usri2_script_path : PWSTR
    usri2_auth_flags : AF_OP
    usri2_full_name : PWSTR
    usri2_usr_comment : PWSTR
    usri2_parms : PWSTR
    usri2_workstations : PWSTR
    usri2_last_logon : UInt32
    usri2_last_logoff : UInt32
    usri2_acct_expires : UInt32
    usri2_max_storage : UInt32
    usri2_units_per_week : UInt32
    usri2_logon_hours : UInt8.Ptr
    usri2_bad_pw_count : UInt32
    usri2_num_logons : UInt32
    usri2_logon_server : PWSTR
    usri2_country_code : UInt32
    usri2_code_page : UInt32
}
struct USER_INFO_3 {
    usri3_name : PWSTR
    usri3_password : PWSTR
    usri3_password_age : UInt32
    usri3_priv : USER_PRIV
    usri3_home_dir : PWSTR
    usri3_comment : PWSTR
    usri3_flags : USER_ACCOUNT_FLAGS
    usri3_script_path : PWSTR
    usri3_auth_flags : AF_OP
    usri3_full_name : PWSTR
    usri3_usr_comment : PWSTR
    usri3_parms : PWSTR
    usri3_workstations : PWSTR
    usri3_last_logon : UInt32
    usri3_last_logoff : UInt32
    usri3_acct_expires : UInt32
    usri3_max_storage : UInt32
    usri3_units_per_week : UInt32
    usri3_logon_hours : UInt8.Ptr
    usri3_bad_pw_count : UInt32
    usri3_num_logons : UInt32
    usri3_logon_server : PWSTR
    usri3_country_code : UInt32
    usri3_code_page : UInt32
    usri3_user_id : UInt32
    usri3_primary_group_id : UInt32
    usri3_profile : PWSTR
    usri3_home_dir_drive : PWSTR
    usri3_password_expired : UInt32
}
struct USER_INFO_4 {
    usri4_name : PWSTR
    usri4_password : PWSTR
    usri4_password_age : UInt32
    usri4_priv : USER_PRIV
    usri4_home_dir : PWSTR
    usri4_comment : PWSTR
    usri4_flags : USER_ACCOUNT_FLAGS
    usri4_script_path : PWSTR
    usri4_auth_flags : AF_OP
    usri4_full_name : PWSTR
    usri4_usr_comment : PWSTR
    usri4_parms : PWSTR
    usri4_workstations : PWSTR
    usri4_last_logon : UInt32
    usri4_last_logoff : UInt32
    usri4_acct_expires : UInt32
    usri4_max_storage : UInt32
    usri4_units_per_week : UInt32
    usri4_logon_hours : UInt8.Ptr
    usri4_bad_pw_count : UInt32
    usri4_num_logons : UInt32
    usri4_logon_server : PWSTR
    usri4_country_code : UInt32
    usri4_code_page : UInt32
    usri4_user_sid : PSID
    usri4_primary_group_id : UInt32
    usri4_profile : PWSTR
    usri4_home_dir_drive : PWSTR
    usri4_password_expired : UInt32
}
struct USER_INFO_10 {
    usri10_name : PWSTR
    usri10_comment : PWSTR
    usri10_usr_comment : PWSTR
    usri10_full_name : PWSTR
}
struct USER_INFO_11 {
    usri11_name : PWSTR
    usri11_comment : PWSTR
    usri11_usr_comment : PWSTR
    usri11_full_name : PWSTR
    usri11_priv : USER_PRIV
    usri11_auth_flags : AF_OP
    usri11_password_age : UInt32
    usri11_home_dir : PWSTR
    usri11_parms : PWSTR
    usri11_last_logon : UInt32
    usri11_last_logoff : UInt32
    usri11_bad_pw_count : UInt32
    usri11_num_logons : UInt32
    usri11_logon_server : PWSTR
    usri11_country_code : UInt32
    usri11_workstations : PWSTR
    usri11_max_storage : UInt32
    usri11_units_per_week : UInt32
    usri11_logon_hours : UInt8.Ptr
    usri11_code_page : UInt32
}
struct USER_INFO_20 {
    usri20_name : PWSTR
    usri20_full_name : PWSTR
    usri20_comment : PWSTR
    usri20_flags : USER_ACCOUNT_FLAGS
    usri20_user_id : UInt32
}
struct USER_INFO_21 {
    usri21_password : UInt8[16]
}
struct USER_INFO_22 {
    usri22_name : PWSTR
    usri22_password : UInt8[16]
    usri22_password_age : UInt32
    usri22_priv : USER_PRIV
    usri22_home_dir : PWSTR
    usri22_comment : PWSTR
    usri22_flags : USER_ACCOUNT_FLAGS
    usri22_script_path : PWSTR
    usri22_auth_flags : AF_OP
    usri22_full_name : PWSTR
    usri22_usr_comment : PWSTR
    usri22_parms : PWSTR
    usri22_workstations : PWSTR
    usri22_last_logon : UInt32
    usri22_last_logoff : UInt32
    usri22_acct_expires : UInt32
    usri22_max_storage : UInt32
    usri22_units_per_week : UInt32
    usri22_logon_hours : UInt8.Ptr
    usri22_bad_pw_count : UInt32
    usri22_num_logons : UInt32
    usri22_logon_server : PWSTR
    usri22_country_code : UInt32
    usri22_code_page : UInt32
}
struct USER_INFO_23 {
    usri23_name : PWSTR
    usri23_full_name : PWSTR
    usri23_comment : PWSTR
    usri23_flags : USER_ACCOUNT_FLAGS
    usri23_user_sid : PSID
}
struct USER_INFO_24 {
    usri24_internet_identity : BOOL
    usri24_flags : UInt32
    usri24_internet_provider_name : PWSTR
    usri24_internet_principal_name : PWSTR
    usri24_user_sid : PSID
}
struct USER_INFO_1003 {
    usri1003_password : PWSTR
}
struct USER_INFO_1005 {
    usri1005_priv : USER_PRIV
}
struct USER_INFO_1006 {
    usri1006_home_dir : PWSTR
}
struct USER_INFO_1007 {
    usri1007_comment : PWSTR
}
struct USER_INFO_1008 {
    usri1008_flags : USER_ACCOUNT_FLAGS
}
struct USER_INFO_1009 {
    usri1009_script_path : PWSTR
}
struct USER_INFO_1010 {
    usri1010_auth_flags : AF_OP
}
struct USER_INFO_1011 {
    usri1011_full_name : PWSTR
}
struct USER_INFO_1012 {
    usri1012_usr_comment : PWSTR
}
struct USER_INFO_1013 {
    usri1013_parms : PWSTR
}
struct USER_INFO_1014 {
    usri1014_workstations : PWSTR
}
struct USER_INFO_1017 {
    usri1017_acct_expires : UInt32
}
struct USER_INFO_1018 {
    usri1018_max_storage : UInt32
}
struct USER_INFO_1020 {
    usri1020_units_per_week : UInt32
    usri1020_logon_hours : UInt8.Ptr
}
struct USER_INFO_1023 {
    usri1023_logon_server : PWSTR
}
struct USER_INFO_1024 {
    usri1024_country_code : UInt32
}
struct USER_INFO_1025 {
    usri1025_code_page : UInt32
}
struct USER_INFO_1051 {
    usri1051_primary_group_id : UInt32
}
struct USER_INFO_1052 {
    usri1052_profile : PWSTR
}
struct USER_INFO_1053 {
    usri1053_home_dir_drive : PWSTR
}
struct USER_MODALS_INFO_0 {
    usrmod0_min_passwd_len : UInt32
    usrmod0_max_passwd_age : UInt32
    usrmod0_min_passwd_age : UInt32
    usrmod0_force_logoff : UInt32
    usrmod0_password_hist_len : UInt32
}
struct USER_MODALS_INFO_1 {
    usrmod1_role : UInt32
    usrmod1_primary : PWSTR
}
struct USER_MODALS_INFO_2 {
    usrmod2_domain_name : PWSTR
    usrmod2_domain_id : PSID
}
struct USER_MODALS_INFO_3 {
    usrmod3_lockout_duration : UInt32
    usrmod3_lockout_observation_window : UInt32
    usrmod3_lockout_threshold : UInt32
}
struct USER_MODALS_INFO_1001 {
    usrmod1001_min_passwd_len : UInt32
}
struct USER_MODALS_INFO_1002 {
    usrmod1002_max_passwd_age : UInt32
}
struct USER_MODALS_INFO_1003 {
    usrmod1003_min_passwd_age : UInt32
}
struct USER_MODALS_INFO_1004 {
    usrmod1004_force_logoff : UInt32
}
struct USER_MODALS_INFO_1005 {
    usrmod1005_password_hist_len : UInt32
}
struct USER_MODALS_INFO_1006 {
    usrmod1006_role : USER_MODALS_ROLES
}
struct USER_MODALS_INFO_1007 {
    usrmod1007_primary : PWSTR
}
struct MSA_INFO_LEVEL extends Int32 {
    static MsaInfoLevel0 := 0
    static MsaInfoLevel1 := 1
    static MsaInfoLevelMax := 2
}
struct MSA_INFO_ACCOUNT_TYPE extends Int32 {
    static MsaAccountFalse := 0
    static StandAloneManagedServiceAccount := 1
    static GroupManagedServiceAccount := 2
    static DelegatedManagedServiceAccount := 3
}
struct MSA_INFO_STATE extends Int32 {
    static MsaInfoNotExist := 1
    static MsaInfoNotService := 2
    static MsaInfoCannotInstall := 3
    static MsaInfoCanInstall := 4
    static MsaInfoInstalled := 5
}
struct MSA_INFO_0 {
    State : MSA_INFO_STATE
}
struct MSA_INFO_1 {
    State : MSA_INFO_STATE
    AccountType : MSA_INFO_ACCOUNT_TYPE
}
struct GROUP_INFO_0 {
    grpi0_name : PWSTR
}
struct GROUP_INFO_1 {
    grpi1_name : PWSTR
    grpi1_comment : PWSTR
}
struct GROUP_INFO_2 {
    grpi2_name : PWSTR
    grpi2_comment : PWSTR
    grpi2_group_id : UInt32
    grpi2_attributes : UInt32
}
struct GROUP_INFO_3 {
    grpi3_name : PWSTR
    grpi3_comment : PWSTR
    grpi3_group_sid : PSID
    grpi3_attributes : UInt32
}
struct GROUP_INFO_1002 {
    grpi1002_comment : PWSTR
}
struct GROUP_INFO_1005 {
    grpi1005_attributes : UInt32
}
struct GROUP_USERS_INFO_0 {
    grui0_name : PWSTR
}
struct GROUP_USERS_INFO_1 {
    grui1_name : PWSTR
    grui1_attributes : UInt32
}
struct LOCALGROUP_INFO_0 {
    lgrpi0_name : PWSTR
}
struct LOCALGROUP_INFO_1 {
    lgrpi1_name : PWSTR
    lgrpi1_comment : PWSTR
}
struct LOCALGROUP_INFO_1002 {
    lgrpi1002_comment : PWSTR
}
struct LOCALGROUP_MEMBERS_INFO_0 {
    lgrmi0_sid : PSID
}
struct LOCALGROUP_MEMBERS_INFO_1 {
    lgrmi1_sid : PSID
    lgrmi1_sidusage : SID_NAME_USE
    lgrmi1_name : PWSTR
}
struct LOCALGROUP_MEMBERS_INFO_2 {
    lgrmi2_sid : PSID
    lgrmi2_sidusage : SID_NAME_USE
    lgrmi2_domainandname : PWSTR
}
struct LOCALGROUP_MEMBERS_INFO_3 {
    lgrmi3_domainandname : PWSTR
}
struct LOCALGROUP_USERS_INFO_0 {
    lgrui0_name : PWSTR
}
struct NET_DISPLAY_USER {
    usri1_name : PWSTR
    usri1_comment : PWSTR
    usri1_flags : USER_ACCOUNT_FLAGS
    usri1_full_name : PWSTR
    usri1_user_id : UInt32
    usri1_next_index : UInt32
}
struct NET_DISPLAY_MACHINE {
    usri2_name : PWSTR
    usri2_comment : PWSTR
    usri2_flags : USER_ACCOUNT_FLAGS
    usri2_user_id : UInt32
    usri2_next_index : UInt32
}
struct NET_DISPLAY_GROUP {
    grpi3_name : PWSTR
    grpi3_comment : PWSTR
    grpi3_group_id : UInt32
    grpi3_attributes : UInt32
    grpi3_next_index : UInt32
}
struct ACCESS_INFO_0 {
    acc0_resource_name : PWSTR
}
struct ACCESS_INFO_1 {
    acc1_resource_name : PWSTR
    acc1_attr : UInt32
    acc1_count : UInt32
}
struct ACCESS_INFO_1002 {
    acc1002_attr : UInt32
}
struct ACCESS_LIST {
    acl_ugname : PWSTR
    acl_access : UInt32
}
struct NET_VALIDATE_PASSWORD_TYPE extends Int32 {
    static NetValidateAuthentication := 1
    static NetValidatePasswordChange := 2
    static NetValidatePasswordReset := 3
}
struct NET_VALIDATE_PASSWORD_HASH {
    Length : UInt32
    Hash : UInt8.Ptr
}
struct NET_VALIDATE_PERSISTED_FIELDS {
    PresentFields : UInt32
    PasswordLastSet : FILETIME
    BadPasswordTime : FILETIME
    LockoutTime : FILETIME
    BadPasswordCount : UInt32
    PasswordHistoryLength : UInt32
    PasswordHistory : NET_VALIDATE_PASSWORD_HASH.Ptr
}
struct NET_VALIDATE_OUTPUT_ARG {
    ChangedPersistedFields : NET_VALIDATE_PERSISTED_FIELDS
    ValidationStatus : UInt32
}
struct NET_VALIDATE_AUTHENTICATION_INPUT_ARG {
    InputPersistedFields : NET_VALIDATE_PERSISTED_FIELDS
    PasswordMatched : BOOLEAN
}
struct NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG {
    InputPersistedFields : NET_VALIDATE_PERSISTED_FIELDS
    ClearPassword : PWSTR
    UserAccountName : PWSTR
    HashedPassword : NET_VALIDATE_PASSWORD_HASH
    PasswordMatch : BOOLEAN
}
struct NET_VALIDATE_PASSWORD_RESET_INPUT_ARG {
    InputPersistedFields : NET_VALIDATE_PERSISTED_FIELDS
    ClearPassword : PWSTR
    UserAccountName : PWSTR
    HashedPassword : NET_VALIDATE_PASSWORD_HASH
    PasswordMustChangeAtNextLogon : BOOLEAN
    ClearLockout : BOOLEAN
}
struct NETLOGON_INFO_1 {
    netlog1_flags : UInt32
    netlog1_pdc_connection_status : UInt32
}
struct NETLOGON_INFO_2 {
    netlog2_flags : UInt32
    netlog2_pdc_connection_status : UInt32
    netlog2_trusted_dc_name : PWSTR
    netlog2_tc_connection_status : UInt32
}
struct NETLOGON_INFO_3 {
    netlog3_flags : UInt32
    netlog3_logon_attempts : UInt32
    netlog3_reserved1 : UInt32
    netlog3_reserved2 : UInt32
    netlog3_reserved3 : UInt32
    netlog3_reserved4 : UInt32
    netlog3_reserved5 : UInt32
}
struct NETLOGON_INFO_4 {
    netlog4_trusted_dc_name : PWSTR
    netlog4_trusted_domain_name : PWSTR
}
struct STD_ALERT {
    alrt_timestamp : UInt32
    alrt_eventname : UInt16[17]
    alrt_servicename : UInt16[81]
}
struct ADMIN_OTHER_INFO {
    alrtad_errcode : UInt32
    alrtad_numstrings : UInt32
}
struct ERRLOG_OTHER_INFO {
    alrter_errcode : UInt32
    alrter_offset : UInt32
}
struct PRINT_OTHER_INFO {
    alrtpr_jobid : UInt32
    alrtpr_status : UInt32
    alrtpr_submitted : UInt32
    alrtpr_size : UInt32
}
struct USER_OTHER_INFO {
    alrtus_errcode : UInt32
    alrtus_numstrings : UInt32
}
struct MSG_INFO_0 {
    msgi0_name : PWSTR
}
struct MSG_INFO_1 {
    msgi1_name : PWSTR
    msgi1_forward_flag : UInt32
    msgi1_forward : PWSTR
}
struct TIME_OF_DAY_INFO {
    tod_elapsedt : UInt32
    tod_msecs : UInt32
    tod_hours : UInt32
    tod_mins : UInt32
    tod_secs : UInt32
    tod_hunds : UInt32
    tod_timezone : Int32
    tod_tinterval : UInt32
    tod_day : UInt32
    tod_month : UInt32
    tod_year : UInt32
    tod_weekday : UInt32
}
struct REPL_INFO_0 {
    rp0_role : UInt32
    rp0_exportpath : PWSTR
    rp0_exportlist : PWSTR
    rp0_importpath : PWSTR
    rp0_importlist : PWSTR
    rp0_logonusername : PWSTR
    rp0_interval : UInt32
    rp0_pulse : UInt32
    rp0_guardtime : UInt32
    rp0_random : UInt32
}
struct REPL_INFO_1000 {
    rp1000_interval : UInt32
}
struct REPL_INFO_1001 {
    rp1001_pulse : UInt32
}
struct REPL_INFO_1002 {
    rp1002_guardtime : UInt32
}
struct REPL_INFO_1003 {
    rp1003_random : UInt32
}
struct REPL_EDIR_INFO_0 {
    rped0_dirname : PWSTR
}
struct REPL_EDIR_INFO_1 {
    rped1_dirname : PWSTR
    rped1_integrity : UInt32
    rped1_extent : UInt32
}
struct REPL_EDIR_INFO_2 {
    rped2_dirname : PWSTR
    rped2_integrity : UInt32
    rped2_extent : UInt32
    rped2_lockcount : UInt32
    rped2_locktime : UInt32
}
struct REPL_EDIR_INFO_1000 {
    rped1000_integrity : UInt32
}
struct REPL_EDIR_INFO_1001 {
    rped1001_extent : UInt32
}
struct REPL_IDIR_INFO_0 {
    rpid0_dirname : PWSTR
}
struct REPL_IDIR_INFO_1 {
    rpid1_dirname : PWSTR
    rpid1_state : UInt32
    rpid1_mastername : PWSTR
    rpid1_last_update_time : UInt32
    rpid1_lockcount : UInt32
    rpid1_locktime : UInt32
}
struct SERVER_INFO_100 {
    sv100_platform_id : UInt32
    sv100_name : PWSTR
}
struct SERVER_INFO_101 {
    sv101_platform_id : UInt32
    sv101_name : PWSTR
    sv101_version_major : UInt32
    sv101_version_minor : UInt32
    sv101_type : NET_SERVER_TYPE
    sv101_comment : PWSTR
}
struct SERVER_INFO_102 {
    sv102_platform_id : UInt32
    sv102_name : PWSTR
    sv102_version_major : UInt32
    sv102_version_minor : UInt32
    sv102_type : NET_SERVER_TYPE
    sv102_comment : PWSTR
    sv102_users : UInt32
    sv102_disc : Int32
    sv102_hidden : SERVER_INFO_HIDDEN
    sv102_announce : UInt32
    sv102_anndelta : UInt32
    sv102_licenses : UInt32
    sv102_userpath : PWSTR
}
struct SERVER_INFO_103 {
    sv103_platform_id : UInt32
    sv103_name : PWSTR
    sv103_version_major : UInt32
    sv103_version_minor : UInt32
    sv103_type : UInt32
    sv103_comment : PWSTR
    sv103_users : UInt32
    sv103_disc : Int32
    sv103_hidden : BOOL
    sv103_announce : UInt32
    sv103_anndelta : UInt32
    sv103_licenses : UInt32
    sv103_userpath : PWSTR
    sv103_capabilities : UInt32
}
struct SERVER_INFO_402 {
    sv402_ulist_mtime : UInt32
    sv402_glist_mtime : UInt32
    sv402_alist_mtime : UInt32
    sv402_alerts : PWSTR
    sv402_security : SERVER_INFO_SECURITY
    sv402_numadmin : UInt32
    sv402_lanmask : UInt32
    sv402_guestacct : PWSTR
    sv402_chdevs : UInt32
    sv402_chdevq : UInt32
    sv402_chdevjobs : UInt32
    sv402_connections : UInt32
    sv402_shares : UInt32
    sv402_openfiles : UInt32
    sv402_sessopens : UInt32
    sv402_sessvcs : UInt32
    sv402_sessreqs : UInt32
    sv402_opensearch : UInt32
    sv402_activelocks : UInt32
    sv402_numreqbuf : UInt32
    sv402_sizreqbuf : UInt32
    sv402_numbigbuf : UInt32
    sv402_numfiletasks : UInt32
    sv402_alertsched : UInt32
    sv402_erroralert : UInt32
    sv402_logonalert : UInt32
    sv402_accessalert : UInt32
    sv402_diskalert : UInt32
    sv402_netioalert : UInt32
    sv402_maxauditsz : UInt32
    sv402_srvheuristics : PWSTR
}
struct SERVER_INFO_403 {
    sv403_ulist_mtime : UInt32
    sv403_glist_mtime : UInt32
    sv403_alist_mtime : UInt32
    sv403_alerts : PWSTR
    sv403_security : SERVER_INFO_SECURITY
    sv403_numadmin : UInt32
    sv403_lanmask : UInt32
    sv403_guestacct : PWSTR
    sv403_chdevs : UInt32
    sv403_chdevq : UInt32
    sv403_chdevjobs : UInt32
    sv403_connections : UInt32
    sv403_shares : UInt32
    sv403_openfiles : UInt32
    sv403_sessopens : UInt32
    sv403_sessvcs : UInt32
    sv403_sessreqs : UInt32
    sv403_opensearch : UInt32
    sv403_activelocks : UInt32
    sv403_numreqbuf : UInt32
    sv403_sizreqbuf : UInt32
    sv403_numbigbuf : UInt32
    sv403_numfiletasks : UInt32
    sv403_alertsched : UInt32
    sv403_erroralert : UInt32
    sv403_logonalert : UInt32
    sv403_accessalert : UInt32
    sv403_diskalert : UInt32
    sv403_netioalert : UInt32
    sv403_maxauditsz : UInt32
    sv403_srvheuristics : PWSTR
    sv403_auditedevents : UInt32
    sv403_autoprofile : UInt32
    sv403_autopath : PWSTR
}
struct SERVER_INFO_502 {
    sv502_sessopens : UInt32
    sv502_sessvcs : UInt32
    sv502_opensearch : UInt32
    sv502_sizreqbuf : UInt32
    sv502_initworkitems : UInt32
    sv502_maxworkitems : UInt32
    sv502_rawworkitems : UInt32
    sv502_irpstacksize : UInt32
    sv502_maxrawbuflen : UInt32
    sv502_sessusers : UInt32
    sv502_sessconns : UInt32
    sv502_maxpagedmemoryusage : UInt32
    sv502_maxnonpagedmemoryusage : UInt32
    sv502_enablesoftcompat : BOOL
    sv502_enableforcedlogoff : BOOL
    sv502_timesource : BOOL
    sv502_acceptdownlevelapis : BOOL
    sv502_lmannounce : BOOL
}
struct SERVER_INFO_503 {
    sv503_sessopens : UInt32
    sv503_sessvcs : UInt32
    sv503_opensearch : UInt32
    sv503_sizreqbuf : UInt32
    sv503_initworkitems : UInt32
    sv503_maxworkitems : UInt32
    sv503_rawworkitems : UInt32
    sv503_irpstacksize : UInt32
    sv503_maxrawbuflen : UInt32
    sv503_sessusers : UInt32
    sv503_sessconns : UInt32
    sv503_maxpagedmemoryusage : UInt32
    sv503_maxnonpagedmemoryusage : UInt32
    sv503_enablesoftcompat : BOOL
    sv503_enableforcedlogoff : BOOL
    sv503_timesource : BOOL
    sv503_acceptdownlevelapis : BOOL
    sv503_lmannounce : BOOL
    sv503_domain : PWSTR
    sv503_maxcopyreadlen : UInt32
    sv503_maxcopywritelen : UInt32
    sv503_minkeepsearch : UInt32
    sv503_maxkeepsearch : UInt32
    sv503_minkeepcomplsearch : UInt32
    sv503_maxkeepcomplsearch : UInt32
    sv503_threadcountadd : UInt32
    sv503_numblockthreads : UInt32
    sv503_scavtimeout : UInt32
    sv503_minrcvqueue : UInt32
    sv503_minfreeworkitems : UInt32
    sv503_xactmemsize : UInt32
    sv503_threadpriority : UInt32
    sv503_maxmpxct : UInt32
    sv503_oplockbreakwait : UInt32
    sv503_oplockbreakresponsewait : UInt32
    sv503_enableoplocks : BOOL
    sv503_enableoplockforceclose : BOOL
    sv503_enablefcbopens : BOOL
    sv503_enableraw : BOOL
    sv503_enablesharednetdrives : BOOL
    sv503_minfreeconnections : UInt32
    sv503_maxfreeconnections : UInt32
}
struct SERVER_INFO_599 {
    sv599_sessopens : UInt32
    sv599_sessvcs : UInt32
    sv599_opensearch : UInt32
    sv599_sizreqbuf : UInt32
    sv599_initworkitems : UInt32
    sv599_maxworkitems : UInt32
    sv599_rawworkitems : UInt32
    sv599_irpstacksize : UInt32
    sv599_maxrawbuflen : UInt32
    sv599_sessusers : UInt32
    sv599_sessconns : UInt32
    sv599_maxpagedmemoryusage : UInt32
    sv599_maxnonpagedmemoryusage : UInt32
    sv599_enablesoftcompat : BOOL
    sv599_enableforcedlogoff : BOOL
    sv599_timesource : BOOL
    sv599_acceptdownlevelapis : BOOL
    sv599_lmannounce : BOOL
    sv599_domain : PWSTR
    sv599_maxcopyreadlen : UInt32
    sv599_maxcopywritelen : UInt32
    sv599_minkeepsearch : UInt32
    sv599_maxkeepsearch : UInt32
    sv599_minkeepcomplsearch : UInt32
    sv599_maxkeepcomplsearch : UInt32
    sv599_threadcountadd : UInt32
    sv599_numblockthreads : UInt32
    sv599_scavtimeout : UInt32
    sv599_minrcvqueue : UInt32
    sv599_minfreeworkitems : UInt32
    sv599_xactmemsize : UInt32
    sv599_threadpriority : UInt32
    sv599_maxmpxct : UInt32
    sv599_oplockbreakwait : UInt32
    sv599_oplockbreakresponsewait : UInt32
    sv599_enableoplocks : BOOL
    sv599_enableoplockforceclose : BOOL
    sv599_enablefcbopens : BOOL
    sv599_enableraw : BOOL
    sv599_enablesharednetdrives : BOOL
    sv599_minfreeconnections : UInt32
    sv599_maxfreeconnections : UInt32
    sv599_initsesstable : UInt32
    sv599_initconntable : UInt32
    sv599_initfiletable : UInt32
    sv599_initsearchtable : UInt32
    sv599_alertschedule : UInt32
    sv599_errorthreshold : UInt32
    sv599_networkerrorthreshold : UInt32
    sv599_diskspacethreshold : UInt32
    sv599_reserved : UInt32
    sv599_maxlinkdelay : UInt32
    sv599_minlinkthroughput : UInt32
    sv599_linkinfovalidtime : UInt32
    sv599_scavqosinfoupdatetime : UInt32
    sv599_maxworkitemidletime : UInt32
}
struct SERVER_INFO_598 {
    sv598_maxrawworkitems : UInt32
    sv598_maxthreadsperqueue : UInt32
    sv598_producttype : UInt32
    sv598_serversize : UInt32
    sv598_connectionlessautodisc : UInt32
    sv598_sharingviolationretries : UInt32
    sv598_sharingviolationdelay : UInt32
    sv598_maxglobalopensearch : UInt32
    sv598_removeduplicatesearches : UInt32
    sv598_lockviolationoffset : UInt32
    sv598_lockviolationdelay : UInt32
    sv598_mdlreadswitchover : UInt32
    sv598_cachedopenlimit : UInt32
    sv598_otherqueueaffinity : UInt32
    sv598_restrictnullsessaccess : BOOL
    sv598_enablewfw311directipx : BOOL
    sv598_queuesamplesecs : UInt32
    sv598_balancecount : UInt32
    sv598_preferredaffinity : UInt32
    sv598_maxfreerfcbs : UInt32
    sv598_maxfreemfcbs : UInt32
    sv598_maxfreelfcbs : UInt32
    sv598_maxfreepagedpoolchunks : UInt32
    sv598_minpagedpoolchunksize : UInt32
    sv598_maxpagedpoolchunksize : UInt32
    sv598_sendsfrompreferredprocessor : BOOL
    sv598_cacheddirectorylimit : UInt32
    sv598_maxcopylength : UInt32
    sv598_enablecompression : BOOL
    sv598_autosharewks : BOOL
    sv598_autoshareserver : BOOL
    sv598_enablesecuritysignature : BOOL
    sv598_requiresecuritysignature : BOOL
    sv598_minclientbuffersize : UInt32
    sv598_serverguid : GUID
    sv598_ConnectionNoSessionsTimeout : UInt32
    sv598_IdleThreadTimeOut : UInt32
    sv598_enableW9xsecuritysignature : BOOL
    sv598_enforcekerberosreauthentication : BOOL
    sv598_disabledos : BOOL
    sv598_lowdiskspaceminimum : UInt32
    sv598_disablestrictnamechecking : BOOL
    sv598_enableauthenticateusersharing : BOOL
}
struct SERVER_INFO_1005 {
    sv1005_comment : PWSTR
}
struct SERVER_INFO_1107 {
    sv1107_users : UInt32
}
struct SERVER_INFO_1010 {
    sv1010_disc : Int32
}
struct SERVER_INFO_1016 {
    sv1016_hidden : SERVER_INFO_HIDDEN
}
struct SERVER_INFO_1017 {
    sv1017_announce : UInt32
}
struct SERVER_INFO_1018 {
    sv1018_anndelta : UInt32
}
struct SERVER_INFO_1501 {
    sv1501_sessopens : UInt32
}
struct SERVER_INFO_1502 {
    sv1502_sessvcs : UInt32
}
struct SERVER_INFO_1503 {
    sv1503_opensearch : UInt32
}
struct SERVER_INFO_1506 {
    sv1506_maxworkitems : UInt32
}
struct SERVER_INFO_1509 {
    sv1509_maxrawbuflen : UInt32
}
struct SERVER_INFO_1510 {
    sv1510_sessusers : UInt32
}
struct SERVER_INFO_1511 {
    sv1511_sessconns : UInt32
}
struct SERVER_INFO_1512 {
    sv1512_maxnonpagedmemoryusage : UInt32
}
struct SERVER_INFO_1513 {
    sv1513_maxpagedmemoryusage : UInt32
}
struct SERVER_INFO_1514 {
    sv1514_enablesoftcompat : BOOL
}
struct SERVER_INFO_1515 {
    sv1515_enableforcedlogoff : BOOL
}
struct SERVER_INFO_1516 {
    sv1516_timesource : BOOL
}
struct SERVER_INFO_1518 {
    sv1518_lmannounce : BOOL
}
struct SERVER_INFO_1520 {
    sv1520_maxcopyreadlen : UInt32
}
struct SERVER_INFO_1521 {
    sv1521_maxcopywritelen : UInt32
}
struct SERVER_INFO_1522 {
    sv1522_minkeepsearch : UInt32
}
struct SERVER_INFO_1523 {
    sv1523_maxkeepsearch : UInt32
}
struct SERVER_INFO_1524 {
    sv1524_minkeepcomplsearch : UInt32
}
struct SERVER_INFO_1525 {
    sv1525_maxkeepcomplsearch : UInt32
}
struct SERVER_INFO_1528 {
    sv1528_scavtimeout : UInt32
}
struct SERVER_INFO_1529 {
    sv1529_minrcvqueue : UInt32
}
struct SERVER_INFO_1530 {
    sv1530_minfreeworkitems : UInt32
}
struct SERVER_INFO_1533 {
    sv1533_maxmpxct : UInt32
}
struct SERVER_INFO_1534 {
    sv1534_oplockbreakwait : UInt32
}
struct SERVER_INFO_1535 {
    sv1535_oplockbreakresponsewait : UInt32
}
struct SERVER_INFO_1536 {
    sv1536_enableoplocks : BOOL
}
struct SERVER_INFO_1537 {
    sv1537_enableoplockforceclose : BOOL
}
struct SERVER_INFO_1538 {
    sv1538_enablefcbopens : BOOL
}
struct SERVER_INFO_1539 {
    sv1539_enableraw : BOOL
}
struct SERVER_INFO_1540 {
    sv1540_enablesharednetdrives : BOOL
}
struct SERVER_INFO_1541 {
    sv1541_minfreeconnections : BOOL
}
struct SERVER_INFO_1542 {
    sv1542_maxfreeconnections : BOOL
}
struct SERVER_INFO_1543 {
    sv1543_initsesstable : UInt32
}
struct SERVER_INFO_1544 {
    sv1544_initconntable : UInt32
}
struct SERVER_INFO_1545 {
    sv1545_initfiletable : UInt32
}
struct SERVER_INFO_1546 {
    sv1546_initsearchtable : UInt32
}
struct SERVER_INFO_1547 {
    sv1547_alertschedule : UInt32
}
struct SERVER_INFO_1548 {
    sv1548_errorthreshold : UInt32
}
struct SERVER_INFO_1549 {
    sv1549_networkerrorthreshold : UInt32
}
struct SERVER_INFO_1550 {
    sv1550_diskspacethreshold : UInt32
}
struct SERVER_INFO_1552 {
    sv1552_maxlinkdelay : UInt32
}
struct SERVER_INFO_1553 {
    sv1553_minlinkthroughput : UInt32
}
struct SERVER_INFO_1554 {
    sv1554_linkinfovalidtime : UInt32
}
struct SERVER_INFO_1555 {
    sv1555_scavqosinfoupdatetime : UInt32
}
struct SERVER_INFO_1556 {
    sv1556_maxworkitemidletime : UInt32
}
struct SERVER_INFO_1557 {
    sv1557_maxrawworkitems : UInt32
}
struct SERVER_INFO_1560 {
    sv1560_producttype : UInt32
}
struct SERVER_INFO_1561 {
    sv1561_serversize : UInt32
}
struct SERVER_INFO_1562 {
    sv1562_connectionlessautodisc : UInt32
}
struct SERVER_INFO_1563 {
    sv1563_sharingviolationretries : UInt32
}
struct SERVER_INFO_1564 {
    sv1564_sharingviolationdelay : UInt32
}
struct SERVER_INFO_1565 {
    sv1565_maxglobalopensearch : UInt32
}
struct SERVER_INFO_1566 {
    sv1566_removeduplicatesearches : BOOL
}
struct SERVER_INFO_1567 {
    sv1567_lockviolationretries : UInt32
}
struct SERVER_INFO_1568 {
    sv1568_lockviolationoffset : UInt32
}
struct SERVER_INFO_1569 {
    sv1569_lockviolationdelay : UInt32
}
struct SERVER_INFO_1570 {
    sv1570_mdlreadswitchover : UInt32
}
struct SERVER_INFO_1571 {
    sv1571_cachedopenlimit : UInt32
}
struct SERVER_INFO_1572 {
    sv1572_criticalthreads : UInt32
}
struct SERVER_INFO_1573 {
    sv1573_restrictnullsessaccess : UInt32
}
struct SERVER_INFO_1574 {
    sv1574_enablewfw311directipx : UInt32
}
struct SERVER_INFO_1575 {
    sv1575_otherqueueaffinity : UInt32
}
struct SERVER_INFO_1576 {
    sv1576_queuesamplesecs : UInt32
}
struct SERVER_INFO_1577 {
    sv1577_balancecount : UInt32
}
struct SERVER_INFO_1578 {
    sv1578_preferredaffinity : UInt32
}
struct SERVER_INFO_1579 {
    sv1579_maxfreerfcbs : UInt32
}
struct SERVER_INFO_1580 {
    sv1580_maxfreemfcbs : UInt32
}
struct SERVER_INFO_1581 {
    sv1581_maxfreemlcbs : UInt32
}
struct SERVER_INFO_1582 {
    sv1582_maxfreepagedpoolchunks : UInt32
}
struct SERVER_INFO_1583 {
    sv1583_minpagedpoolchunksize : UInt32
}
struct SERVER_INFO_1584 {
    sv1584_maxpagedpoolchunksize : UInt32
}
struct SERVER_INFO_1585 {
    sv1585_sendsfrompreferredprocessor : BOOL
}
struct SERVER_INFO_1586 {
    sv1586_maxthreadsperqueue : UInt32
}
struct SERVER_INFO_1587 {
    sv1587_cacheddirectorylimit : UInt32
}
struct SERVER_INFO_1588 {
    sv1588_maxcopylength : UInt32
}
struct SERVER_INFO_1590 {
    sv1590_enablecompression : UInt32
}
struct SERVER_INFO_1591 {
    sv1591_autosharewks : UInt32
}
struct SERVER_INFO_1592 {
    sv1592_autosharewks : UInt32
}
struct SERVER_INFO_1593 {
    sv1593_enablesecuritysignature : UInt32
}
struct SERVER_INFO_1594 {
    sv1594_requiresecuritysignature : UInt32
}
struct SERVER_INFO_1595 {
    sv1595_minclientbuffersize : UInt32
}
struct SERVER_INFO_1596 {
    sv1596_ConnectionNoSessionsTimeout : UInt32
}
struct SERVER_INFO_1597 {
    sv1597_IdleThreadTimeOut : UInt32
}
struct SERVER_INFO_1598 {
    sv1598_enableW9xsecuritysignature : UInt32
}
struct SERVER_INFO_1599 {
    sv1598_enforcekerberosreauthentication : BOOLEAN
}
struct SERVER_INFO_1600 {
    sv1598_disabledos : BOOLEAN
}
struct SERVER_INFO_1601 {
    sv1598_lowdiskspaceminimum : UInt32
}
struct SERVER_INFO_1602 {
    sv_1598_disablestrictnamechecking : BOOL
}
struct SERVER_TRANSPORT_INFO_0 {
    svti0_numberofvcs : UInt32
    svti0_transportname : PWSTR
    svti0_transportaddress : UInt8.Ptr
    svti0_transportaddresslength : UInt32
    svti0_networkaddress : PWSTR
}
struct SERVER_TRANSPORT_INFO_1 {
    svti1_numberofvcs : UInt32
    svti1_transportname : PWSTR
    svti1_transportaddress : UInt8.Ptr
    svti1_transportaddresslength : UInt32
    svti1_networkaddress : PWSTR
    svti1_domain : PWSTR
}
struct SERVER_TRANSPORT_INFO_2 {
    svti2_numberofvcs : UInt32
    svti2_transportname : PWSTR
    svti2_transportaddress : UInt8.Ptr
    svti2_transportaddresslength : UInt32
    svti2_networkaddress : PWSTR
    svti2_domain : PWSTR
    svti2_flags : UInt32
}
struct SERVER_TRANSPORT_INFO_3 {
    svti3_numberofvcs : UInt32
    svti3_transportname : PWSTR
    svti3_transportaddress : UInt8.Ptr
    svti3_transportaddresslength : UInt32
    svti3_networkaddress : PWSTR
    svti3_domain : PWSTR
    svti3_flags : UInt32
    svti3_passwordlength : UInt32
    svti3_password : UInt8[256]
}
struct SERVICE_INFO_0 {
    svci0_name : PWSTR
}
struct SERVICE_INFO_1 {
    svci1_name : PWSTR
    svci1_status : UInt32
    svci1_code : UInt32
    svci1_pid : UInt32
}
struct SERVICE_INFO_2 {
    svci2_name : PWSTR
    svci2_status : UInt32
    svci2_code : UInt32
    svci2_pid : UInt32
    svci2_text : PWSTR
    svci2_specific_error : UInt32
    svci2_display_name : PWSTR
}
struct USE_INFO_0 {
    ui0_local : PWSTR
    ui0_remote : PWSTR
}
struct USE_INFO_1 {
    ui1_local : PWSTR
    ui1_remote : PWSTR
    ui1_password : PWSTR
    ui1_status : UInt32
    ui1_asg_type : USE_INFO_ASG_TYPE
    ui1_refcount : UInt32
    ui1_usecount : UInt32
}
struct USE_INFO_2 {
    ui2_local : PWSTR
    ui2_remote : PWSTR
    ui2_password : PWSTR
    ui2_status : UInt32
    ui2_asg_type : USE_INFO_ASG_TYPE
    ui2_refcount : UInt32
    ui2_usecount : UInt32
    ui2_username : PWSTR
    ui2_domainname : PWSTR
}
struct USE_INFO_3 {
    ui3_ui2 : USE_INFO_2
    ui3_flags : UInt32
}
struct USE_INFO_4 {
    ui4_ui3 : USE_INFO_3
    ui4_auth_identity_length : UInt32
    ui4_auth_identity : UInt8.Ptr
}
struct USE_INFO_5 {
    ui4_ui3 : USE_INFO_3
    ui4_auth_identity_length : UInt32
    ui4_auth_identity : UInt8.Ptr
    ui5_security_descriptor_length : UInt32
    ui5_security_descriptor : UInt8.Ptr
    ui5_use_options_length : UInt32
    ui5_use_options : UInt8.Ptr
}
struct USE_OPTION_GENERIC {
    Tag : UInt32
    Length : UInt16
    Reserved : UInt16
}
struct USE_OPTION_DEFERRED_CONNECTION_PARAMETERS {
    Tag : UInt32
    Length : UInt16
    Reserved : UInt16
}
struct TRANSPORT_TYPE extends Int32 {
    static UseTransportType_None := 0
    static UseTransportType_Wsk := 1
    static UseTransportType_Quic := 2
}
struct TRANSPORT_INFO_FLAG extends Int32 {
    static NoneFlag := 0
    static TcpPortSetFlag := 1
    static QuicPortSetFlag := 2
    static RdmaPortSetFlag := 4
}
struct TRANSPORT_INFO {
    Type : TRANSPORT_TYPE
    SkipCertificateCheck : BOOLEAN
    TcpPort : UInt16
    QuicPort : UInt16
    RdmaPort : UInt16
    Flags : UInt32
}
struct USE_OPTION_TRANSPORT_PARAMETERS {
    Tag : UInt32
    Length : UInt16
    Reserved : UInt16
}
struct SMB_COMPRESSION_INFO {
    Switch : BOOLEAN
    Reserved1 : UInt8
    Reserved2 : UInt16
    Reserved3 : UInt32
}
struct SMB_USE_OPTION_COMPRESSION_PARAMETERS {
    Tag : UInt32
    Length : UInt16
    Reserved : UInt16
}
struct BLOCK_NTLM_INFO {
    BlockNTLM : BOOLEAN
    Reserved1 : UInt8
    Reserved2 : UInt16
    Reserved3 : UInt32
}
struct USE_OPTION_BLOCK_NTLM_PARAMETERS {
    Tag : UInt32
    Length : UInt16
    Reserved : UInt16
}
struct SMB_TREE_CONNECT_PARAMETERS {
    EABufferOffset : UInt32
    EABufferLen : UInt32
    CreateOptions : UInt32
    TreeConnectAttributes : UInt32
}
struct USE_OPTION_PROPERTIES {
    Tag : UInt32
    pInfo : Struct.Ptr
    Length : IntPtr
}
struct WKSTA_INFO_100 {
    wki100_platform_id : UInt32
    wki100_computername : PWSTR
    wki100_langroup : PWSTR
    wki100_ver_major : UInt32
    wki100_ver_minor : UInt32
}
struct WKSTA_INFO_101 {
    wki101_platform_id : UInt32
    wki101_computername : PWSTR
    wki101_langroup : PWSTR
    wki101_ver_major : UInt32
    wki101_ver_minor : UInt32
    wki101_lanroot : PWSTR
}
struct WKSTA_INFO_102 {
    wki102_platform_id : UInt32
    wki102_computername : PWSTR
    wki102_langroup : PWSTR
    wki102_ver_major : UInt32
    wki102_ver_minor : UInt32
    wki102_lanroot : PWSTR
    wki102_logged_on_users : UInt32
}
struct WKSTA_INFO_302 {
    wki302_char_wait : UInt32
    wki302_collection_time : UInt32
    wki302_maximum_collection_count : UInt32
    wki302_keep_conn : UInt32
    wki302_keep_search : UInt32
    wki302_max_cmds : UInt32
    wki302_num_work_buf : UInt32
    wki302_siz_work_buf : UInt32
    wki302_max_wrk_cache : UInt32
    wki302_sess_timeout : UInt32
    wki302_siz_error : UInt32
    wki302_num_alerts : UInt32
    wki302_num_services : UInt32
    wki302_errlog_sz : UInt32
    wki302_print_buf_time : UInt32
    wki302_num_char_buf : UInt32
    wki302_siz_char_buf : UInt32
    wki302_wrk_heuristics : PWSTR
    wki302_mailslots : UInt32
    wki302_num_dgram_buf : UInt32
}
struct WKSTA_INFO_402 {
    wki402_char_wait : UInt32
    wki402_collection_time : UInt32
    wki402_maximum_collection_count : UInt32
    wki402_keep_conn : UInt32
    wki402_keep_search : UInt32
    wki402_max_cmds : UInt32
    wki402_num_work_buf : UInt32
    wki402_siz_work_buf : UInt32
    wki402_max_wrk_cache : UInt32
    wki402_sess_timeout : UInt32
    wki402_siz_error : UInt32
    wki402_num_alerts : UInt32
    wki402_num_services : UInt32
    wki402_errlog_sz : UInt32
    wki402_print_buf_time : UInt32
    wki402_num_char_buf : UInt32
    wki402_siz_char_buf : UInt32
    wki402_wrk_heuristics : PWSTR
    wki402_mailslots : UInt32
    wki402_num_dgram_buf : UInt32
    wki402_max_threads : UInt32
}
struct WKSTA_INFO_502 {
    wki502_char_wait : UInt32
    wki502_collection_time : UInt32
    wki502_maximum_collection_count : UInt32
    wki502_keep_conn : UInt32
    wki502_max_cmds : UInt32
    wki502_sess_timeout : UInt32
    wki502_siz_char_buf : UInt32
    wki502_max_threads : UInt32
    wki502_lock_quota : UInt32
    wki502_lock_increment : UInt32
    wki502_lock_maximum : UInt32
    wki502_pipe_increment : UInt32
    wki502_pipe_maximum : UInt32
    wki502_cache_file_timeout : UInt32
    wki502_dormant_file_limit : UInt32
    wki502_read_ahead_throughput : UInt32
    wki502_num_mailslot_buffers : UInt32
    wki502_num_srv_announce_buffers : UInt32
    wki502_max_illegal_datagram_events : UInt32
    wki502_illegal_datagram_event_reset_frequency : UInt32
    wki502_log_election_packets : BOOL
    wki502_use_opportunistic_locking : BOOL
    wki502_use_unlock_behind : BOOL
    wki502_use_close_behind : BOOL
    wki502_buf_named_pipes : BOOL
    wki502_use_lock_read_unlock : BOOL
    wki502_utilize_nt_caching : BOOL
    wki502_use_raw_read : BOOL
    wki502_use_raw_write : BOOL
    wki502_use_write_raw_data : BOOL
    wki502_use_encryption : BOOL
    wki502_buf_files_deny_write : BOOL
    wki502_buf_read_only_files : BOOL
    wki502_force_core_create_mode : BOOL
    wki502_use_512_byte_max_transfer : BOOL
}
struct WKSTA_INFO_1010 {
    wki1010_char_wait : UInt32
}
struct WKSTA_INFO_1011 {
    wki1011_collection_time : UInt32
}
struct WKSTA_INFO_1012 {
    wki1012_maximum_collection_count : UInt32
}
struct WKSTA_INFO_1027 {
    wki1027_errlog_sz : UInt32
}
struct WKSTA_INFO_1028 {
    wki1028_print_buf_time : UInt32
}
struct WKSTA_INFO_1032 {
    wki1032_wrk_heuristics : UInt32
}
struct WKSTA_INFO_1013 {
    wki1013_keep_conn : UInt32
}
struct WKSTA_INFO_1018 {
    wki1018_sess_timeout : UInt32
}
struct WKSTA_INFO_1023 {
    wki1023_siz_char_buf : UInt32
}
struct WKSTA_INFO_1033 {
    wki1033_max_threads : UInt32
}
struct WKSTA_INFO_1041 {
    wki1041_lock_quota : UInt32
}
struct WKSTA_INFO_1042 {
    wki1042_lock_increment : UInt32
}
struct WKSTA_INFO_1043 {
    wki1043_lock_maximum : UInt32
}
struct WKSTA_INFO_1044 {
    wki1044_pipe_increment : UInt32
}
struct WKSTA_INFO_1045 {
    wki1045_pipe_maximum : UInt32
}
struct WKSTA_INFO_1046 {
    wki1046_dormant_file_limit : UInt32
}
struct WKSTA_INFO_1047 {
    wki1047_cache_file_timeout : UInt32
}
struct WKSTA_INFO_1048 {
    wki1048_use_opportunistic_locking : BOOL
}
struct WKSTA_INFO_1049 {
    wki1049_use_unlock_behind : BOOL
}
struct WKSTA_INFO_1050 {
    wki1050_use_close_behind : BOOL
}
struct WKSTA_INFO_1051 {
    wki1051_buf_named_pipes : BOOL
}
struct WKSTA_INFO_1052 {
    wki1052_use_lock_read_unlock : BOOL
}
struct WKSTA_INFO_1053 {
    wki1053_utilize_nt_caching : BOOL
}
struct WKSTA_INFO_1054 {
    wki1054_use_raw_read : BOOL
}
struct WKSTA_INFO_1055 {
    wki1055_use_raw_write : BOOL
}
struct WKSTA_INFO_1056 {
    wki1056_use_write_raw_data : BOOL
}
struct WKSTA_INFO_1057 {
    wki1057_use_encryption : BOOL
}
struct WKSTA_INFO_1058 {
    wki1058_buf_files_deny_write : BOOL
}
struct WKSTA_INFO_1059 {
    wki1059_buf_read_only_files : BOOL
}
struct WKSTA_INFO_1060 {
    wki1060_force_core_create_mode : BOOL
}
struct WKSTA_INFO_1061 {
    wki1061_use_512_byte_max_transfer : BOOL
}
struct WKSTA_INFO_1062 {
    wki1062_read_ahead_throughput : UInt32
}
struct WKSTA_USER_INFO_0 {
    wkui0_username : PWSTR
}
struct WKSTA_USER_INFO_1 {
    wkui1_username : PWSTR
    wkui1_logon_domain : PWSTR
    wkui1_oth_domains : PWSTR
    wkui1_logon_server : PWSTR
}
struct WKSTA_USER_INFO_1101 {
    wkui1101_oth_domains : PWSTR
}
struct WKSTA_TRANSPORT_INFO_0 {
    wkti0_quality_of_service : UInt32
    wkti0_number_of_vcs : UInt32
    wkti0_transport_name : PWSTR
    wkti0_transport_address : PWSTR
    wkti0_wan_ish : BOOL
}
struct ERROR_LOG {
    el_len : UInt32
    el_reserved : UInt32
    el_time : UInt32
    el_error : UInt32
    el_name : PWSTR
    el_text : PWSTR
    el_data : UInt8.Ptr
    el_data_size : UInt32
    el_nstrings : UInt32
}
struct HLOG {
    time : UInt32
    last_flags : UInt32
    offset : UInt32
    rec_offset : UInt32
}
struct CONFIG_INFO_0 {
    cfgi0_key : PWSTR
    cfgi0_data : PWSTR
}
struct AUDIT_ENTRY {
    ae_len : UInt32
    ae_reserved : UInt32
    ae_time : UInt32
    ae_type : UInt32
    ae_data_offset : UInt32
    ae_data_size : UInt32
}
struct AE_SRVSTATUS {
    ae_sv_status : UInt32
}
struct AE_SESSLOGON {
    ae_so_compname : UInt32
    ae_so_username : UInt32
    ae_so_privilege : UInt32
}
struct AE_SESSLOGOFF {
    ae_sf_compname : UInt32
    ae_sf_username : UInt32
    ae_sf_reason : UInt32
}
struct AE_SESSPWERR {
    ae_sp_compname : UInt32
    ae_sp_username : UInt32
}
struct AE_CONNSTART {
    ae_ct_compname : UInt32
    ae_ct_username : UInt32
    ae_ct_netname : UInt32
    ae_ct_connid : UInt32
}
struct AE_CONNSTOP {
    ae_cp_compname : UInt32
    ae_cp_username : UInt32
    ae_cp_netname : UInt32
    ae_cp_connid : UInt32
    ae_cp_reason : UInt32
}
struct AE_CONNREJ {
    ae_cr_compname : UInt32
    ae_cr_username : UInt32
    ae_cr_netname : UInt32
    ae_cr_reason : UInt32
}
struct AE_RESACCESS {
    ae_ra_compname : UInt32
    ae_ra_username : UInt32
    ae_ra_resname : UInt32
    ae_ra_operation : UInt32
    ae_ra_returncode : UInt32
    ae_ra_restype : UInt32
    ae_ra_fileid : UInt32
}
struct AE_RESACCESSREJ {
    ae_rr_compname : UInt32
    ae_rr_username : UInt32
    ae_rr_resname : UInt32
    ae_rr_operation : UInt32
}
struct AE_CLOSEFILE {
    ae_cf_compname : UInt32
    ae_cf_username : UInt32
    ae_cf_resname : UInt32
    ae_cf_fileid : UInt32
    ae_cf_duration : UInt32
    ae_cf_reason : UInt32
}
struct AE_SERVICESTAT {
    ae_ss_compname : UInt32
    ae_ss_username : UInt32
    ae_ss_svcname : UInt32
    ae_ss_status : UInt32
    ae_ss_code : UInt32
    ae_ss_text : UInt32
    ae_ss_returnval : UInt32
}
struct AE_ACLMOD {
    ae_am_compname : UInt32
    ae_am_username : UInt32
    ae_am_resname : UInt32
    ae_am_action : UInt32
    ae_am_datalen : UInt32
}
struct AE_UASMOD {
    ae_um_compname : UInt32
    ae_um_username : UInt32
    ae_um_resname : UInt32
    ae_um_rectype : UInt32
    ae_um_action : UInt32
    ae_um_datalen : UInt32
}
struct AE_NETLOGON {
    ae_no_compname : UInt32
    ae_no_username : UInt32
    ae_no_privilege : UInt32
    ae_no_authflags : UInt32
}
struct AE_NETLOGOFF {
    ae_nf_compname : UInt32
    ae_nf_username : UInt32
    ae_nf_reserved1 : UInt32
    ae_nf_reserved2 : UInt32
}
struct AE_ACCLIM {
    ae_al_compname : UInt32
    ae_al_username : UInt32
    ae_al_resname : UInt32
    ae_al_limit : UInt32
}
struct AE_LOCKOUT {
    ae_lk_compname : UInt32
    ae_lk_username : UInt32
    ae_lk_action : UInt32
    ae_lk_bad_pw_count : UInt32
}
struct AE_GENERIC {
    ae_ge_msgfile : UInt32
    ae_ge_msgnum : UInt32
    ae_ge_params : UInt32
    ae_ge_param1 : UInt32
    ae_ge_param2 : UInt32
    ae_ge_param3 : UInt32
    ae_ge_param4 : UInt32
    ae_ge_param5 : UInt32
    ae_ge_param6 : UInt32
    ae_ge_param7 : UInt32
    ae_ge_param8 : UInt32
    ae_ge_param9 : UInt32
}
struct NETSETUP_NAME_TYPE extends Int32 {
    static NetSetupUnknown := 0
    static NetSetupMachine := 1
    static NetSetupWorkgroup := 2
    static NetSetupDomain := 3
    static NetSetupNonExistentDomain := 4
    static NetSetupDnsMachine := 5
}
struct DSREG_JOIN_TYPE extends Int32 {
    static DSREG_UNKNOWN_JOIN := 0
    static DSREG_DEVICE_JOIN := 1
    static DSREG_WORKPLACE_JOIN := 2
}
struct DSREG_USER_INFO {
    pszUserEmail : PWSTR
    pszUserKeyId : PWSTR
    pszUserKeyName : PWSTR
}
struct DSREG_JOIN_INFO {
    joinType : DSREG_JOIN_TYPE
    pJoinCertificate : CERT_CONTEXT.Ptr
    pszDeviceId : PWSTR
    pszIdpDomain : PWSTR
    pszTenantId : PWSTR
    pszJoinUserEmail : PWSTR
    pszTenantDisplayName : PWSTR
    pszMdmEnrollmentUrl : PWSTR
    pszMdmTermsOfUseUrl : PWSTR
    pszMdmComplianceUrl : PWSTR
    pszUserSettingSyncUrl : PWSTR
    pUserInfo : DSREG_USER_INFO.Ptr
}
struct NET_COMPUTER_NAME_TYPE extends Int32 {
    static NetPrimaryComputerName := 0
    static NetAlternateComputerNames := 1
    static NetAllComputerNames := 2
    static NetComputerNameTypeMax := 3
}
struct NETSETUP_PROVISIONING_PARAMS {
    dwVersion : UInt32
    lpDomain : PWSTR
    lpHostName : PWSTR
    lpMachineAccountOU : PWSTR
    lpDcName : PWSTR
    dwProvisionOptions : NETSETUP_PROVISION
    aCertTemplateNames : PWSTR.Ptr
    cCertTemplateNames : UInt32
    aMachinePolicyNames : PWSTR.Ptr
    cMachinePolicyNames : UInt32
    aMachinePolicyPaths : PWSTR.Ptr
    cMachinePolicyPaths : UInt32
    lpNetbiosName : PWSTR
    lpSiteName : PWSTR
    lpPrimaryDNSDomain : PWSTR
}
struct NETSETUP_JOIN_STATUS extends Int32 {
    static NetSetupUnknownStatus := 0
    static NetSetupUnjoined := 1
    static NetSetupWorkgroupName := 2
    static NetSetupDomainName := 3
}
struct AT_INFO {
    JobTime : IntPtr
    DaysOfMonth : UInt32
    DaysOfWeek : UInt8
    Flags : UInt8
    Command : PWSTR
}
struct AT_ENUM {
    JobId : UInt32
    JobTime : IntPtr
    DaysOfMonth : UInt32
    DaysOfWeek : UInt8
    Flags : UInt8
    Command : PWSTR
}
struct FLAT_STRING {
    MaximumLength : Int16
    Length : Int16
    Buffer : CHAR[1]
}
struct NETWORK_NAME {
    Name : FLAT_STRING
}
struct HARDWARE_ADDRESS {
    Address : UInt8[6]
}
struct IEnumNetCfgBindingInterface extends IUnknown {
    static IID := "{C0E8AE90-306E-11D1-AACF-00805FC1270E}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, INetCfgBindingInterface.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone()
      => ComCall(6, this.p, "Ptr", 0)
}
struct IEnumNetCfgBindingPath extends IUnknown {
    static IID := "{C0E8AE91-306E-11D1-AACF-00805FC1270E}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, INetCfgBindingPath.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone()
      => ComCall(6, this.p, "Ptr", 0)
}
struct IEnumNetCfgComponent extends IUnknown {
    static IID := "{C0E8AE92-306E-11D1-AACF-00805FC1270E}"
    Next(rgelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, rgelt.Length, INetCfgComponent.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone()
      => ComCall(6, this.p, "Ptr", 0)
}
struct INetCfg extends IUnknown {
    static IID := "{C0E8AE93-306E-11D1-AACF-00805FC1270E}"
    Initialize()
      => ComCall(3, this.p, "Ptr", 0)
    Uninitialize()
      => ComCall(4, this.p)
    Apply()
      => ComCall(5, this.p)
    Cancel()
      => ComCall(6, this.p)
    EnumComponents(pguidClass, ppenumComponent?)
      => ComCall(7, this.p, GUID.Ptr, pguidClass, IEnumNetCfgComponent.Ptr, ppenumComponent?)
    FindComponent(pszwInfId, pComponent?)
      => ComCall(8, this.p, "Str", pszwInfId, INetCfgComponent.Ptr, pComponent?)
    QueryNetCfgClass(pguidClass, riid, ppvObject?)
      => ComCall(9, this.p, GUID.Ptr, pguidClass, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject?)
}
struct INetCfgLock extends IUnknown {
    static IID := "{C0E8AE9F-306E-11D1-AACF-00805FC1270E}"
    AcquireWriteLock(cmsTimeout, pszwClientDescription, ppszwClientDescription?)
      => ComCall(3, this.p, UInt32, cmsTimeout, "Str", pszwClientDescription, PWSTR.Ptr, ppszwClientDescription?)
    ReleaseWriteLock()
      => ComCall(4, this.p)
    IsWriteLocked(ppszwClientDescription?)
      => ComCall(5, this.p, PWSTR.Ptr, ppszwClientDescription?)
}
struct INetCfgBindingInterface extends IUnknown {
    static IID := "{C0E8AE94-306E-11D1-AACF-00805FC1270E}"
    GetName(ppszwInterfaceName?)
      => ComCall(3, this.p, PWSTR.Ptr, ppszwInterfaceName?)
    GetUpperComponent(ppnccItem?)
      => ComCall(4, this.p, INetCfgComponent.Ptr, ppnccItem?)
    GetLowerComponent(ppnccItem?)
      => ComCall(5, this.p, INetCfgComponent.Ptr, ppnccItem?)
}
struct INetCfgBindingPath extends IUnknown {
    static IID := "{C0E8AE96-306E-11D1-AACF-00805FC1270E}"
    IsSamePathAs(pPath)
      => ComCall(3, this.p, INetCfgBindingPath, pPath)
    IsSubPathOf(pPath)
      => ComCall(4, this.p, INetCfgBindingPath, pPath)
    IsEnabled()
      => ComCall(5, this.p)
    Enable(fEnable)
      => ComCall(6, this.p, BOOL, fEnable)
    GetPathToken(ppszwPathToken?)
      => ComCall(7, this.p, PWSTR.Ptr, ppszwPathToken?)
    GetOwner(ppComponent?)
      => ComCall(8, this.p, INetCfgComponent.Ptr, ppComponent?)
    GetDepth(pcInterfaces)
      => ComCall(9, this.p, UInt32.Ptr, pcInterfaces)
    EnumBindingInterfaces(ppenumInterface?)
      => ComCall(10, this.p, IEnumNetCfgBindingInterface.Ptr, ppenumInterface?)
}
struct INetCfgClass extends IUnknown {
    static IID := "{C0E8AE97-306E-11D1-AACF-00805FC1270E}"
    FindComponent(pszwInfId, ppnccItem?)
      => ComCall(3, this.p, "Str", pszwInfId, INetCfgComponent.Ptr, ppnccItem?)
    EnumComponents(ppenumComponent?)
      => ComCall(4, this.p, IEnumNetCfgComponent.Ptr, ppenumComponent?)
}
struct OBO_TOKEN_TYPE extends Int32 {
    static OBO_USER := 1
    static OBO_COMPONENT := 2
    static OBO_SOFTWARE := 3
}
struct OBO_TOKEN {
    Type : OBO_TOKEN_TYPE
    pncc : INetCfgComponent
    pszwManufacturer : PWSTR
    pszwProduct : PWSTR
    pszwDisplayName : PWSTR
    fRegistered : BOOL
}
struct INetCfgClassSetup extends IUnknown {
    static IID := "{C0E8AE9D-306E-11D1-AACF-00805FC1270E}"
    SelectAndInstall(hwndParent, pOboToken?, ppnccItem?)
      => ComCall(3, this.p, HWND, hwndParent, OBO_TOKEN.Ptr, pOboToken?, INetCfgComponent.Ptr, ppnccItem?)
    Install(pszwInfId, pOboToken?, dwSetupFlags?, dwUpgradeFromBuildNo?, pszwAnswerFile?, pszwAnswerSections?, ppnccItem?)
      => ComCall(4, this.p, "Str", pszwInfId, OBO_TOKEN.Ptr, pOboToken?, UInt32, dwSetupFlags?, UInt32, dwUpgradeFromBuildNo?, "Str", pszwAnswerFile?, "Str", pszwAnswerSections?, INetCfgComponent.Ptr, ppnccItem?)
    DeInstall(pComponent, pOboToken?, pmszwRefs?)
      => ComCall(5, this.p, INetCfgComponent, pComponent, OBO_TOKEN.Ptr, pOboToken?, PWSTR.Ptr, pmszwRefs?)
}
struct INetCfgClassSetup2 extends INetCfgClassSetup {
    static IID := "{C0E8AEA0-306E-11D1-AACF-00805FC1270E}"
    UpdateNonEnumeratedComponent(pIComp)
      => ComCall(6, this.p, INetCfgComponent, pIComp, "Ptr", 0, "Ptr", 0)
}
struct COMPONENT_CHARACTERISTICS extends Int32 {
    static NCF_VIRTUAL := 1
    static NCF_SOFTWARE_ENUMERATED := 2
    static NCF_PHYSICAL := 4
    static NCF_HIDDEN := 8
    static NCF_NO_SERVICE := 16
    static NCF_NOT_USER_REMOVABLE := 32
    static NCF_MULTIPORT_INSTANCED_ADAPTER := 64
    static NCF_HAS_UI := 128
    static NCF_SINGLE_INSTANCE := 256
    static NCF_FILTER := 1024
    static NCF_DONTEXPOSELOWER := 4096
    static NCF_HIDE_BINDING := 8192
    static NCF_NDIS_PROTOCOL := 16384
    static NCF_FIXED_BINDING := 131072
    static NCF_LW_FILTER := 262144
}
struct NCRP_FLAGS extends Int32 {
    static NCRP_QUERY_PROPERTY_UI := 1
    static NCRP_SHOW_PROPERTY_UI := 2
}
struct INetCfgComponent extends IUnknown {
    static IID := "{C0E8AE99-306E-11D1-AACF-00805FC1270E}"
    GetDisplayName(ppszwDisplayName?)
      => ComCall(3, this.p, PWSTR.Ptr, ppszwDisplayName?)
    SetDisplayName(pszwDisplayName)
      => ComCall(4, this.p, "Str", pszwDisplayName)
    GetHelpText(pszwHelpText?)
      => ComCall(5, this.p, PWSTR.Ptr, pszwHelpText?)
    GetId(ppszwId?)
      => ComCall(6, this.p, PWSTR.Ptr, ppszwId?)
    GetCharacteristics(pdwCharacteristics)
      => ComCall(7, this.p, UInt32.Ptr, pdwCharacteristics)
    GetInstanceGuid(pGuid?)
      => ComCall(8, this.p, GUID.Ptr, pGuid?)
    GetPnpDevNodeId(ppszwDevNodeId?)
      => ComCall(9, this.p, PWSTR.Ptr, ppszwDevNodeId?)
    GetClassGuid(pGuid?)
      => ComCall(10, this.p, GUID.Ptr, pGuid?)
    GetBindName(ppszwBindName?)
      => ComCall(11, this.p, PWSTR.Ptr, ppszwBindName?)
    GetDeviceStatus(pulStatus)
      => ComCall(12, this.p, UInt32.Ptr, pulStatus)
    OpenParamKey(phkey?)
      => ComCall(13, this.p, HKEY.Ptr, phkey?)
    RaisePropertyUi(hwndParent?, dwFlags, punkContext?)
      => ComCall(14, this.p, HWND, hwndParent?, UInt32, dwFlags, IUnknown, punkContext?)
}
struct SUPPORTS_BINDING_INTERFACE_FLAGS extends Int32 {
    static NCF_LOWER := 1
    static NCF_UPPER := 2
}
struct ENUM_BINDING_PATHS_FLAGS extends Int32 {
    static EBP_ABOVE := 1
    static EBP_BELOW := 2
}
struct INetCfgComponentBindings extends IUnknown {
    static IID := "{C0E8AE9E-306E-11D1-AACF-00805FC1270E}"
    BindTo(pnccItem)
      => ComCall(3, this.p, INetCfgComponent, pnccItem)
    UnbindFrom(pnccItem)
      => ComCall(4, this.p, INetCfgComponent, pnccItem)
    SupportsBindingInterface(dwFlags, pszwInterfaceName)
      => ComCall(5, this.p, UInt32, dwFlags, "Str", pszwInterfaceName)
    IsBoundTo(pnccItem)
      => ComCall(6, this.p, INetCfgComponent, pnccItem)
    IsBindableTo(pnccItem)
      => ComCall(7, this.p, INetCfgComponent, pnccItem)
    EnumBindingPaths(dwFlags, ppIEnum?)
      => ComCall(8, this.p, UInt32, dwFlags, IEnumNetCfgBindingPath.Ptr, ppIEnum?)
    MoveBefore(pncbItemSrc, pncbItemDest?)
      => ComCall(9, this.p, INetCfgBindingPath, pncbItemSrc, INetCfgBindingPath, pncbItemDest?)
    MoveAfter(pncbItemSrc, pncbItemDest?)
      => ComCall(10, this.p, INetCfgBindingPath, pncbItemSrc, INetCfgBindingPath, pncbItemDest?)
}
struct INetCfgSysPrep extends IUnknown {
    static IID := "{C0E8AE98-306E-11D1-AACF-00805FC1270E}"
    HrSetupSetFirstDword(pwszSection, pwszKey, dwValue)
      => ComCall(3, this.p, "Str", pwszSection, "Str", pwszKey, UInt32, dwValue)
    HrSetupSetFirstString(pwszSection, pwszKey, pwszValue)
      => ComCall(4, this.p, "Str", pwszSection, "Str", pwszKey, "Str", pwszValue)
    HrSetupSetFirstStringAsBool(pwszSection, pwszKey, fValue)
      => ComCall(5, this.p, "Str", pwszSection, "Str", pwszKey, BOOL, fValue)
    HrSetupSetFirstMultiSzField(pwszSection, pwszKey, pmszValue)
      => ComCall(6, this.p, "Str", pwszSection, "Str", pwszKey, "Str", pmszValue)
}
struct NCPNP_RECONFIG_LAYER extends Int32 {
    static NCRL_NDIS := 1
    static NCRL_TDI := 2
}
struct INetCfgPnpReconfigCallback extends IUnknown {
    static IID := "{8D84BD35-E227-11D2-B700-00A0C98A6A85}"
    SendPnpReconfig(Layer, pszwUpper, pszwLower, pvData)
      => ComCall(3, this.p, NCPNP_RECONFIG_LAYER, Layer, "Str", pszwUpper, "Str", pszwLower, Struct.Ptr, pvData, UInt32, pvData.Size)
}
struct INetCfgComponentControl extends IUnknown {
    static IID := "{932238DF-BEA1-11D0-9298-00C04FC99DCF}"
    Initialize(pIComp, pINetCfg, fInstalling)
      => ComCall(3, this.p, INetCfgComponent, pIComp, INetCfg, pINetCfg, BOOL, fInstalling)
    ApplyRegistryChanges()
      => ComCall(4, this.p)
    ApplyPnpChanges(pICallback)
      => ComCall(5, this.p, INetCfgPnpReconfigCallback, pICallback)
    CancelChanges()
      => ComCall(6, this.p)
}
struct NETWORK_INSTALL_TIME extends Int32 {
    static NSF_PRIMARYINSTALL := 1
    static NSF_POSTSYSINSTALL := 2
}
struct NETWORK_UPGRADE_TYPE extends Int32 {
    static NSF_WIN16_UPGRADE := 16
    static NSF_WIN95_UPGRADE := 32
    static NSF_WINNT_WKS_UPGRADE := 64
    static NSF_WINNT_SVR_UPGRADE := 128
    static NSF_WINNT_SBS_UPGRADE := 256
    static NSF_COMPONENT_UPDATE := 512
}
struct INetCfgComponentSetup extends IUnknown {
    static IID := "{932238E3-BEA1-11D0-9298-00C04FC99DCF}"
    Install(dwSetupFlags)
      => ComCall(3, this.p, UInt32, dwSetupFlags)
    Upgrade(dwSetupFlags, dwUpgradeFomBuildNo)
      => ComCall(4, this.p, UInt32, dwSetupFlags, UInt32, dwUpgradeFomBuildNo)
    ReadAnswerFile(pszwAnswerFile, pszwAnswerSections)
      => ComCall(5, this.p, "Str", pszwAnswerFile, "Str", pszwAnswerSections)
    Removing()
      => ComCall(6, this.p)
}
struct DEFAULT_PAGES extends Int32 {
    static DPP_ADVANCED := 1
}
struct INetCfgComponentPropertyUi extends IUnknown {
    static IID := "{932238E0-BEA1-11D0-9298-00C04FC99DCF}"
    QueryPropertyUi(pUnkReserved)
      => ComCall(3, this.p, IUnknown, pUnkReserved)
    SetContext(pUnkReserved)
      => ComCall(4, this.p, IUnknown, pUnkReserved)
    MergePropPages(pdwDefPages, pahpspPrivate, pcPages, hwndParent, pszStartPage?)
      => ComCall(5, this.p, UInt32.Ptr, pdwDefPages, UInt8.Ptr.Ptr, pahpspPrivate, UInt32.Ptr, pcPages, HWND, hwndParent, PWSTR.Ptr, pszStartPage?)
    ValidateProperties(hwndSheet)
      => ComCall(6, this.p, HWND, hwndSheet)
    ApplyProperties()
      => ComCall(7, this.p)
    CancelProperties()
      => ComCall(8, this.p)
}
struct BIND_FLAGS1 extends Int32 {
    static NCN_ADD := 1
    static NCN_REMOVE := 2
    static NCN_UPDATE := 4
    static NCN_ENABLE := 16
    static NCN_DISABLE := 32
    static NCN_BINDING_PATH := 256
    static NCN_PROPERTYCHANGE := 512
    static NCN_NET := 65536
    static NCN_NETTRANS := 131072
    static NCN_NETCLIENT := 262144
    static NCN_NETSERVICE := 524288
}
struct INetCfgComponentNotifyBinding extends IUnknown {
    static IID := "{932238E1-BEA1-11D0-9298-00C04FC99DCF}"
    QueryBindingPath(dwChangeFlag, pIPath)
      => ComCall(3, this.p, UInt32, dwChangeFlag, INetCfgBindingPath, pIPath)
    NotifyBindingPath(dwChangeFlag, pIPath)
      => ComCall(4, this.p, UInt32, dwChangeFlag, INetCfgBindingPath, pIPath)
}
struct INetCfgComponentNotifyGlobal extends IUnknown {
    static IID := "{932238E2-BEA1-11D0-9298-00C04FC99DCF}"
    GetSupportedNotifications(dwNotifications)
      => ComCall(3, this.p, UInt32.Ptr, dwNotifications)
    SysQueryBindingPath(dwChangeFlag, pIPath)
      => ComCall(4, this.p, UInt32, dwChangeFlag, INetCfgBindingPath, pIPath)
    SysNotifyBindingPath(dwChangeFlag, pIPath)
      => ComCall(5, this.p, UInt32, dwChangeFlag, INetCfgBindingPath, pIPath)
    SysNotifyComponent(dwChangeFlag, pIComp)
      => ComCall(6, this.p, UInt32, dwChangeFlag, INetCfgComponent, pIComp)
}
struct INetCfgComponentUpperEdge extends IUnknown {
    static IID := "{932238E4-BEA1-11D0-9298-00C04FC99DCF}"
    GetInterfaceIdsForAdapter(pAdapter, pdwNumInterfaces, ppguidInterfaceIds?)
      => ComCall(3, this.p, INetCfgComponent, pAdapter, UInt32.Ptr, pdwNumInterfaces, GUID.Ptr.Ptr, ppguidInterfaceIds?)
    AddInterfacesToAdapter(pAdapter, dwNumInterfaces)
      => ComCall(4, this.p, INetCfgComponent, pAdapter, UInt32, dwNumInterfaces)
    RemoveInterfacesFromAdapter(pAdapter, pguidInterfaceIds)
      => ComCall(5, this.p, INetCfgComponent, pAdapter, UInt32, pguidInterfaceIds.Length, GUID.Ptr, pguidInterfaceIds)
}
struct INetLanConnectionUiInfo extends IUnknown {
    static IID := "{C08956A6-1CD3-11D1-B1C5-00805FC1270E}"
    GetDeviceGuid(pguid)
      => ComCall(3, this.p, GUID.Ptr, pguid)
}
struct RASCON_UIINFO_FLAGS extends Int32 {
    static RCUIF_VPN := 1
    static RCUIF_DEMAND_DIAL := 2
    static RCUIF_NOT_ADMIN := 4
    static RCUIF_USE_IPv4_STATICADDRESS := 8
    static RCUIF_USE_IPv4_NAME_SERVERS := 16
    static RCUIF_USE_IPv4_REMOTE_GATEWAY := 32
    static RCUIF_USE_IPv4_EXPLICIT_METRIC := 64
    static RCUIF_USE_HEADER_COMPRESSION := 128
    static RCUIF_USE_DISABLE_REGISTER_DNS := 256
    static RCUIF_USE_PRIVATE_DNS_SUFFIX := 512
    static RCUIF_ENABLE_NBT := 1024
    static RCUIF_USE_IPv6_STATICADDRESS := 2048
    static RCUIF_USE_IPv6_NAME_SERVERS := 4096
    static RCUIF_USE_IPv6_REMOTE_GATEWAY := 8192
    static RCUIF_USE_IPv6_EXPLICIT_METRIC := 16384
    static RCUIF_DISABLE_CLASS_BASED_ROUTE := 32768
}
struct RASCON_IPUI {
    guidConnection : GUID
    fIPv6Cfg : BOOL
    dwFlags : UInt32
    pszwIpAddr : UInt16[16]
    pszwDnsAddr : UInt16[16]
    pszwDns2Addr : UInt16[16]
    pszwWinsAddr : UInt16[16]
    pszwWins2Addr : UInt16[16]
    pszwDnsSuffix : UInt16[256]
    pszwIpv6Addr : UInt16[65]
    dwIpv6PrefixLength : UInt32
    pszwIpv6DnsAddr : UInt16[65]
    pszwIpv6Dns2Addr : UInt16[65]
    dwIPv4InfMetric : UInt32
    dwIPv6InfMetric : UInt32
}
struct INetRasConnectionIpUiInfo extends IUnknown {
    static IID := "{FAEDCF58-31FE-11D1-AAD2-00805FC1270E}"
    GetUiInfo(pInfo)
      => ComCall(3, this.p, RASCON_IPUI.Ptr, pInfo)
}
struct INetCfgComponentSysPrep extends IUnknown {
    static IID := "{C0E8AE9A-306E-11D1-AACF-00805FC1270E}"
    SaveAdapterParameters(pncsp, pszwAnswerSections, pAdapterInstanceGuid)
      => ComCall(3, this.p, INetCfgSysPrep, pncsp, "Str", pszwAnswerSections, GUID.Ptr, pAdapterInstanceGuid)
    RestoreAdapterParameters(pszwAnswerFile, pszwAnswerSection, pAdapterInstanceGuid)
      => ComCall(4, this.p, "Str", pszwAnswerFile, "Str", pszwAnswerSection, GUID.Ptr, pAdapterInstanceGuid)
}
struct IProvisioningDomain extends IUnknown {
    static IID := "{C96FBD50-24DD-11D8-89FB-00904B2EA9C6}"
    Add(pszwPathToFolder)
      => ComCall(3, this.p, "Str", pszwPathToFolder)
    Query(pszwDomain, pszwLanguage, pszwXPathQuery, Nodes)
      => ComCall(4, this.p, "Str", pszwDomain, "Str", pszwLanguage, "Str", pszwXPathQuery, IXMLDOMNodeList.Ptr, Nodes)
}
struct IProvisioningProfileWireless extends IUnknown {
    static IID := "{C96FBD51-24DD-11D8-89FB-00904B2EA9C6}"
    CreateProfile(bstrXMLWirelessConfigProfile, bstrXMLConnectionConfigProfile, pAdapterInstanceGuid, pulStatus)
      => ComCall(3, this.p, BSTR, bstrXMLWirelessConfigProfile, BSTR, bstrXMLConnectionConfigProfile, GUID.Ptr, pAdapterInstanceGuid, UInt32.Ptr, pulStatus)
}
struct RTR_TOC_ENTRY {
    InfoType : UInt32
    InfoSize : UInt32
    Count : UInt32
    Offset : UInt32
}
struct RTR_INFO_BLOCK_HEADER {
    Version : UInt32
    Size : UInt32
    TocEntriesCount : UInt32
    TocEntry : RTR_TOC_ENTRY[1]
}
struct WORKERFUNCTION extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct MPR_PROTOCOL_0 {
    dwProtocolId : UInt32
    wszProtocol : UInt16[41]
    wszDLLName : UInt16[49]
}
