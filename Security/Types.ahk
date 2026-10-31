#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, LUID, NTSTATUS, PWSTR}

struct TOKEN_PRIVILEGES_ATTRIBUTES extends UInt32 {
    static SE_PRIVILEGE_ENABLED := 2
    static SE_PRIVILEGE_ENABLED_BY_DEFAULT := 1
    static SE_PRIVILEGE_REMOVED := 4
    static SE_PRIVILEGE_USED_FOR_ACCESS := 2147483648
}
struct LOGON32_PROVIDER extends UInt32 {
    static LOGON32_PROVIDER_DEFAULT := 0
    static LOGON32_PROVIDER_WINNT50 := 3
    static LOGON32_PROVIDER_WINNT40 := 2
}
struct CREATE_RESTRICTED_TOKEN_FLAGS extends UInt32 {
    static DISABLE_MAX_PRIVILEGE := 1
    static SANDBOX_INERT := 2
    static LUA_TOKEN := 4
    static WRITE_RESTRICTED := 8
}
struct LOGON32_LOGON extends UInt32 {
    static LOGON32_LOGON_BATCH := 4
    static LOGON32_LOGON_INTERACTIVE := 2
    static LOGON32_LOGON_NETWORK := 3
    static LOGON32_LOGON_NETWORK_CLEARTEXT := 8
    static LOGON32_LOGON_NEW_CREDENTIALS := 9
    static LOGON32_LOGON_SERVICE := 5
    static LOGON32_LOGON_UNLOCK := 7
}
struct ACE_FLAGS extends UInt32 {
    static CONTAINER_INHERIT_ACE := 2
    static FAILED_ACCESS_ACE_FLAG := 128
    static INHERIT_ONLY_ACE := 8
    static INHERITED_ACE := 16
    static NO_PROPAGATE_INHERIT_ACE := 4
    static OBJECT_INHERIT_ACE := 1
    static SUCCESSFUL_ACCESS_ACE_FLAG := 64
    static SUB_CONTAINERS_AND_OBJECTS_INHERIT := 3
    static SUB_CONTAINERS_ONLY_INHERIT := 2
    static SUB_OBJECTS_ONLY_INHERIT := 1
    static INHERIT_NO_PROPAGATE := 4
    static INHERIT_ONLY := 8
    static NO_INHERITANCE := 0
}
struct OBJECT_SECURITY_INFORMATION extends UInt32 {
    static ATTRIBUTE_SECURITY_INFORMATION := 32
    static BACKUP_SECURITY_INFORMATION := 65536
    static DACL_SECURITY_INFORMATION := 4
    static GROUP_SECURITY_INFORMATION := 2
    static LABEL_SECURITY_INFORMATION := 16
    static OWNER_SECURITY_INFORMATION := 1
    static PROTECTED_DACL_SECURITY_INFORMATION := 2147483648
    static PROTECTED_SACL_SECURITY_INFORMATION := 1073741824
    static SACL_SECURITY_INFORMATION := 8
    static SCOPE_SECURITY_INFORMATION := 64
    static UNPROTECTED_DACL_SECURITY_INFORMATION := 536870912
    static UNPROTECTED_SACL_SECURITY_INFORMATION := 268435456
}
struct SECURITY_AUTO_INHERIT_FLAGS extends UInt32 {
    static SEF_AVOID_OWNER_CHECK := 16
    static SEF_AVOID_OWNER_RESTRICTION := 4096
    static SEF_AVOID_PRIVILEGE_CHECK := 8
    static SEF_DACL_AUTO_INHERIT := 1
    static SEF_DEFAULT_DESCRIPTOR_FOR_OBJECT := 4
    static SEF_DEFAULT_GROUP_FROM_PARENT := 64
    static SEF_DEFAULT_OWNER_FROM_PARENT := 32
    static SEF_MACL_NO_EXECUTE_UP := 1024
    static SEF_MACL_NO_READ_UP := 512
    static SEF_MACL_NO_WRITE_UP := 256
    static SEF_SACL_AUTO_INHERIT := 2
}
struct ACE_REVISION extends UInt32 {
    static ACL_REVISION := 2
    static ACL_REVISION_DS := 4
}
struct TOKEN_MANDATORY_POLICY_ID extends UInt32 {
    static TOKEN_MANDATORY_POLICY_OFF := 0
    static TOKEN_MANDATORY_POLICY_NO_WRITE_UP := 1
    static TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN := 2
    static TOKEN_MANDATORY_POLICY_VALID_MASK := 3
}
struct SYSTEM_AUDIT_OBJECT_ACE_FLAGS extends UInt32 {
    static ACE_OBJECT_TYPE_PRESENT := 1
    static ACE_INHERITED_OBJECT_TYPE_PRESENT := 2
}
struct CLAIM_SECURITY_ATTRIBUTE_FLAGS extends UInt32 {
    static CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE := 1
    static CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE := 2
    static CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY := 4
    static CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT := 8
    static CLAIM_SECURITY_ATTRIBUTE_DISABLED := 16
    static CLAIM_SECURITY_ATTRIBUTE_MANDATORY := 32
}
struct CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE extends UInt16 {
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_INT64 := 1
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_UINT64 := 2
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_STRING := 3
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING := 16
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_FQBN := 4
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_SID := 5
    static CLAIM_SECURITY_ATTRIBUTE_TYPE_BOOLEAN := 6
}
struct SECURITY_DESCRIPTOR_CONTROL extends UInt16 {
    static SE_OWNER_DEFAULTED := 1
    static SE_GROUP_DEFAULTED := 2
    static SE_DACL_PRESENT := 4
    static SE_DACL_DEFAULTED := 8
    static SE_SACL_PRESENT := 16
    static SE_SACL_DEFAULTED := 32
    static SE_DACL_AUTO_INHERIT_REQ := 256
    static SE_SACL_AUTO_INHERIT_REQ := 512
    static SE_DACL_AUTO_INHERITED := 1024
    static SE_SACL_AUTO_INHERITED := 2048
    static SE_DACL_PROTECTED := 4096
    static SE_SACL_PROTECTED := 8192
    static SE_RM_CONTROL_VALID := 16384
    static SE_SELF_RELATIVE := 32768
}
struct PLSA_AP_CALL_PACKAGE_UNTRUSTED extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr.Ptr, UInt32.Ptr, Int32.Ptr, NTSTATUS]
}
struct SEC_THREAD_START extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct TOKEN_ACCESS_MASK extends UInt32 {
    static TOKEN_DELETE := 65536
    static TOKEN_READ_CONTROL := 131072
    static TOKEN_WRITE_DAC := 262144
    static TOKEN_WRITE_OWNER := 524288
    static TOKEN_ACCESS_SYSTEM_SECURITY := 16777216
    static TOKEN_ASSIGN_PRIMARY := 1
    static TOKEN_DUPLICATE := 2
    static TOKEN_IMPERSONATE := 4
    static TOKEN_QUERY := 8
    static TOKEN_QUERY_SOURCE := 16
    static TOKEN_ADJUST_PRIVILEGES := 32
    static TOKEN_ADJUST_GROUPS := 64
    static TOKEN_ADJUST_DEFAULT := 128
    static TOKEN_ADJUST_SESSIONID := 256
    static TOKEN_READ := 131080
    static TOKEN_WRITE := 131296
    static TOKEN_EXECUTE := 131072
    static TOKEN_TRUST_CONSTRAINT_MASK := 131096
    static TOKEN_ACCESS_PSEUDO_HANDLE_WIN8 := 24
    static TOKEN_ACCESS_PSEUDO_HANDLE := 24
    static TOKEN_ALL_ACCESS := 983551
}
struct PSID {
    Value : Struct.Ptr
}
struct NCRYPT_DESCRIPTOR_HANDLE {
    Value : Struct.Ptr
}
struct NCRYPT_STREAM_HANDLE {
    Value : Struct.Ptr
}
struct SAFER_LEVEL_HANDLE {
    Value : Struct.Ptr
}
struct PSECURITY_DESCRIPTOR {
    Value : Struct.Ptr
}
struct SECURITY_ATTRIBUTES {
    nLength : UInt32
    lpSecurityDescriptor : Struct.Ptr
    bInheritHandle : BOOL
}
struct ENUM_PERIOD extends Int32 {
    static ENUM_PERIOD_INVALID := -1
    static ENUM_PERIOD_SECONDS := 0
    static ENUM_PERIOD_MINUTES := 1
    static ENUM_PERIOD_HOURS := 2
    static ENUM_PERIOD_DAYS := 3
    static ENUM_PERIOD_WEEKS := 4
    static ENUM_PERIOD_MONTHS := 5
    static ENUM_PERIOD_YEARS := 6
}
struct LLFILETIME {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ll : Int64
            ft : FILETIME
        }
    }
}
struct GENERIC_MAPPING {
    GenericRead : UInt32
    GenericWrite : UInt32
    GenericExecute : UInt32
    GenericAll : UInt32
}
struct LUID_AND_ATTRIBUTES {
    Luid : LUID
    Attributes : TOKEN_PRIVILEGES_ATTRIBUTES
}
struct SID_IDENTIFIER_AUTHORITY {
    Value : UInt8[6]
}
struct SID {
    Revision : UInt8
    SubAuthorityCount : UInt8
    IdentifierAuthority : SID_IDENTIFIER_AUTHORITY
    SubAuthority : UInt32[1]
}
struct SE_SID {
    union {
        Sid : SID
        Buffer : UInt8[68]
    }
}
struct SID_NAME_USE extends Int32 {
    static SidTypeUser := 1
    static SidTypeGroup := 2
    static SidTypeDomain := 3
    static SidTypeAlias := 4
    static SidTypeWellKnownGroup := 5
    static SidTypeDeletedAccount := 6
    static SidTypeInvalid := 7
    static SidTypeUnknown := 8
    static SidTypeComputer := 9
    static SidTypeLabel := 10
    static SidTypeLogonSession := 11
}
struct SID_AND_ATTRIBUTES {
    Sid : PSID
    Attributes : UInt32
}
struct SID_AND_ATTRIBUTES_HASH {
    SidCount : UInt32
    SidAttr : SID_AND_ATTRIBUTES.Ptr
    Hash : IntPtr[32]
}
struct WELL_KNOWN_SID_TYPE extends Int32 {
    static WinNullSid := 0
    static WinWorldSid := 1
    static WinLocalSid := 2
    static WinCreatorOwnerSid := 3
    static WinCreatorGroupSid := 4
    static WinCreatorOwnerServerSid := 5
    static WinCreatorGroupServerSid := 6
    static WinNtAuthoritySid := 7
    static WinDialupSid := 8
    static WinNetworkSid := 9
    static WinBatchSid := 10
    static WinInteractiveSid := 11
    static WinServiceSid := 12
    static WinAnonymousSid := 13
    static WinProxySid := 14
    static WinEnterpriseControllersSid := 15
    static WinSelfSid := 16
    static WinAuthenticatedUserSid := 17
    static WinRestrictedCodeSid := 18
    static WinTerminalServerSid := 19
    static WinRemoteLogonIdSid := 20
    static WinLogonIdsSid := 21
    static WinLocalSystemSid := 22
    static WinLocalServiceSid := 23
    static WinNetworkServiceSid := 24
    static WinBuiltinDomainSid := 25
    static WinBuiltinAdministratorsSid := 26
    static WinBuiltinUsersSid := 27
    static WinBuiltinGuestsSid := 28
    static WinBuiltinPowerUsersSid := 29
    static WinBuiltinAccountOperatorsSid := 30
    static WinBuiltinSystemOperatorsSid := 31
    static WinBuiltinPrintOperatorsSid := 32
    static WinBuiltinBackupOperatorsSid := 33
    static WinBuiltinReplicatorSid := 34
    static WinBuiltinPreWindows2000CompatibleAccessSid := 35
    static WinBuiltinRemoteDesktopUsersSid := 36
    static WinBuiltinNetworkConfigurationOperatorsSid := 37
    static WinAccountAdministratorSid := 38
    static WinAccountGuestSid := 39
    static WinAccountKrbtgtSid := 40
    static WinAccountDomainAdminsSid := 41
    static WinAccountDomainUsersSid := 42
    static WinAccountDomainGuestsSid := 43
    static WinAccountComputersSid := 44
    static WinAccountControllersSid := 45
    static WinAccountCertAdminsSid := 46
    static WinAccountSchemaAdminsSid := 47
    static WinAccountEnterpriseAdminsSid := 48
    static WinAccountPolicyAdminsSid := 49
    static WinAccountRasAndIasServersSid := 50
    static WinNTLMAuthenticationSid := 51
    static WinDigestAuthenticationSid := 52
    static WinSChannelAuthenticationSid := 53
    static WinThisOrganizationSid := 54
    static WinOtherOrganizationSid := 55
    static WinBuiltinIncomingForestTrustBuildersSid := 56
    static WinBuiltinPerfMonitoringUsersSid := 57
    static WinBuiltinPerfLoggingUsersSid := 58
    static WinBuiltinAuthorizationAccessSid := 59
    static WinBuiltinTerminalServerLicenseServersSid := 60
    static WinBuiltinDCOMUsersSid := 61
    static WinBuiltinIUsersSid := 62
    static WinIUserSid := 63
    static WinBuiltinCryptoOperatorsSid := 64
    static WinUntrustedLabelSid := 65
    static WinLowLabelSid := 66
    static WinMediumLabelSid := 67
    static WinHighLabelSid := 68
    static WinSystemLabelSid := 69
    static WinWriteRestrictedCodeSid := 70
    static WinCreatorOwnerRightsSid := 71
    static WinCacheablePrincipalsGroupSid := 72
    static WinNonCacheablePrincipalsGroupSid := 73
    static WinEnterpriseReadonlyControllersSid := 74
    static WinAccountReadonlyControllersSid := 75
    static WinBuiltinEventLogReadersGroup := 76
    static WinNewEnterpriseReadonlyControllersSid := 77
    static WinBuiltinCertSvcDComAccessGroup := 78
    static WinMediumPlusLabelSid := 79
    static WinLocalLogonSid := 80
    static WinConsoleLogonSid := 81
    static WinThisOrganizationCertificateSid := 82
    static WinApplicationPackageAuthoritySid := 83
    static WinBuiltinAnyPackageSid := 84
    static WinCapabilityInternetClientSid := 85
    static WinCapabilityInternetClientServerSid := 86
    static WinCapabilityPrivateNetworkClientServerSid := 87
    static WinCapabilityPicturesLibrarySid := 88
    static WinCapabilityVideosLibrarySid := 89
    static WinCapabilityMusicLibrarySid := 90
    static WinCapabilityDocumentsLibrarySid := 91
    static WinCapabilitySharedUserCertificatesSid := 92
    static WinCapabilityEnterpriseAuthenticationSid := 93
    static WinCapabilityRemovableStorageSid := 94
    static WinBuiltinRDSRemoteAccessServersSid := 95
    static WinBuiltinRDSEndpointServersSid := 96
    static WinBuiltinRDSManagementServersSid := 97
    static WinUserModeDriversSid := 98
    static WinBuiltinHyperVAdminsSid := 99
    static WinAccountCloneableControllersSid := 100
    static WinBuiltinAccessControlAssistanceOperatorsSid := 101
    static WinBuiltinRemoteManagementUsersSid := 102
    static WinAuthenticationAuthorityAssertedSid := 103
    static WinAuthenticationServiceAssertedSid := 104
    static WinLocalAccountSid := 105
    static WinLocalAccountAndAdministratorSid := 106
    static WinAccountProtectedUsersSid := 107
    static WinCapabilityAppointmentsSid := 108
    static WinCapabilityContactsSid := 109
    static WinAccountDefaultSystemManagedSid := 110
    static WinBuiltinDefaultSystemManagedGroupSid := 111
    static WinBuiltinStorageReplicaAdminsSid := 112
    static WinAccountKeyAdminsSid := 113
    static WinAccountEnterpriseKeyAdminsSid := 114
    static WinAuthenticationKeyTrustSid := 115
    static WinAuthenticationKeyPropertyMFASid := 116
    static WinAuthenticationKeyPropertyAttestationSid := 117
    static WinAuthenticationFreshKeyAuthSid := 118
    static WinBuiltinDeviceOwnersSid := 119
    static WinBuiltinUserModeHardwareOperatorsSid := 120
    static WinBuiltinOpenSSHUsersSid := 121
    static WinBuiltinCUAUsersSid := 122
}
struct ACL {
    AclRevision : UInt8
    Sbz1 : UInt8
    AclSize : UInt16
    AceCount : UInt16
    Sbz2 : UInt16
}
struct ACE_HEADER {
    AceType : UInt8
    AceFlags : UInt8
    AceSize : UInt16
}
struct ACCESS_ALLOWED_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct ACCESS_DENIED_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_AUDIT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_ALARM_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_RESOURCE_ATTRIBUTE_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_SCOPED_POLICY_ID_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_MANDATORY_LABEL_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_PROCESS_TRUST_LABEL_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_ACCESS_FILTER_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct ACCESS_ALLOWED_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct ACCESS_DENIED_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct SYSTEM_AUDIT_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct SYSTEM_ALARM_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : UInt32
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct ACCESS_ALLOWED_CALLBACK_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct ACCESS_DENIED_CALLBACK_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_AUDIT_CALLBACK_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct SYSTEM_ALARM_CALLBACK_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    SidStart : UInt32
}
struct ACCESS_ALLOWED_CALLBACK_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct ACCESS_DENIED_CALLBACK_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct SYSTEM_AUDIT_CALLBACK_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct SYSTEM_ALARM_CALLBACK_OBJECT_ACE {
    Header : ACE_HEADER
    Mask : UInt32
    Flags : SYSTEM_AUDIT_OBJECT_ACE_FLAGS
    ObjectType : GUID
    InheritedObjectType : GUID
    SidStart : UInt32
}
struct ACL_INFORMATION_CLASS extends Int32 {
    static AclRevisionInformation := 1
    static AclSizeInformation := 2
}
struct ACL_REVISION_INFORMATION {
    AclRevision : UInt32
}
struct ACL_SIZE_INFORMATION {
    AceCount : UInt32
    AclBytesInUse : UInt32
    AclBytesFree : UInt32
}
struct SECURITY_DESCRIPTOR_RELATIVE {
    Revision : UInt8
    Sbz1 : UInt8
    Control : SECURITY_DESCRIPTOR_CONTROL
    Owner : UInt32
    Group : UInt32
    Sacl : UInt32
    Dacl : UInt32
}
struct SECURITY_DESCRIPTOR {
    Revision : UInt8
    Sbz1 : UInt8
    Control : SECURITY_DESCRIPTOR_CONTROL
    Owner : PSID
    Group : PSID
    Sacl : ACL.Ptr
    Dacl : ACL.Ptr
}
struct OBJECT_TYPE_LIST {
    Level : UInt16
    Sbz : UInt16
    ObjectType : GUID.Ptr
}
struct AUDIT_EVENT_TYPE extends Int32 {
    static AuditEventObjectAccess := 0
    static AuditEventDirectoryServiceAccess := 1
}
struct PRIVILEGE_SET {
    PrivilegeCount : UInt32
    Control : UInt32
    Privilege : LUID_AND_ATTRIBUTES[1]
}
struct ACCESS_REASONS {
    Data : UInt32[32]
}
struct SE_SECURITY_DESCRIPTOR {
    Size : UInt32
    Flags : UInt32
    SecurityDescriptor : PSECURITY_DESCRIPTOR
}
struct SE_ACCESS_REQUEST {
    Size : UInt32
    SeSecurityDescriptor : SE_SECURITY_DESCRIPTOR.Ptr
    DesiredAccess : UInt32
    PreviouslyGrantedAccess : UInt32
    PrincipalSelfSid : PSID
    GenericMapping : GENERIC_MAPPING.Ptr
    ObjectTypeListCount : UInt32
    ObjectTypeList : OBJECT_TYPE_LIST.Ptr
}
struct SE_ACCESS_REPLY {
    Size : UInt32
    ResultListCount : UInt32
    GrantedAccess : UInt32.Ptr
    AccessStatus : UInt32.Ptr
    AccessReason : ACCESS_REASONS.Ptr
    Privileges : PRIVILEGE_SET.Ptr.Ptr
}
struct SECURITY_IMPERSONATION_LEVEL extends Int32 {
    static SecurityAnonymous := 0
    static SecurityIdentification := 1
    static SecurityImpersonation := 2
    static SecurityDelegation := 3
}
struct TOKEN_TYPE extends Int32 {
    static TokenPrimary := 1
    static TokenImpersonation := 2
}
struct TOKEN_ELEVATION_TYPE extends Int32 {
    static TokenElevationTypeDefault := 1
    static TokenElevationTypeFull := 2
    static TokenElevationTypeLimited := 3
}
struct TOKEN_INFORMATION_CLASS extends Int32 {
    static TokenUser := 1
    static TokenGroups := 2
    static TokenPrivileges := 3
    static TokenOwner := 4
    static TokenPrimaryGroup := 5
    static TokenDefaultDacl := 6
    static TokenSource := 7
    static TokenType := 8
    static TokenImpersonationLevel := 9
    static TokenStatistics := 10
    static TokenRestrictedSids := 11
    static TokenSessionId := 12
    static TokenGroupsAndPrivileges := 13
    static TokenSessionReference := 14
    static TokenSandBoxInert := 15
    static TokenAuditPolicy := 16
    static TokenOrigin := 17
    static TokenElevationType := 18
    static TokenLinkedToken := 19
    static TokenElevation := 20
    static TokenHasRestrictions := 21
    static TokenAccessInformation := 22
    static TokenVirtualizationAllowed := 23
    static TokenVirtualizationEnabled := 24
    static TokenIntegrityLevel := 25
    static TokenUIAccess := 26
    static TokenMandatoryPolicy := 27
    static TokenLogonSid := 28
    static TokenIsAppContainer := 29
    static TokenCapabilities := 30
    static TokenAppContainerSid := 31
    static TokenAppContainerNumber := 32
    static TokenUserClaimAttributes := 33
    static TokenDeviceClaimAttributes := 34
    static TokenRestrictedUserClaimAttributes := 35
    static TokenRestrictedDeviceClaimAttributes := 36
    static TokenDeviceGroups := 37
    static TokenRestrictedDeviceGroups := 38
    static TokenSecurityAttributes := 39
    static TokenIsRestricted := 40
    static TokenProcessTrustLevel := 41
    static TokenPrivateNameSpace := 42
    static TokenSingletonAttributes := 43
    static TokenBnoIsolation := 44
    static TokenChildProcessFlags := 45
    static TokenIsLessPrivilegedAppContainer := 46
    static TokenIsSandboxed := 47
    static TokenIsAppSilo := 48
    static TokenLoggingInformation := 49
    static TokenLearningMode := 50
    static TokenIsSystemManagedAdmin := 51
    static TokenIsInstaller := 52
    static MaxTokenInfoClass := 53
}
struct TOKEN_USER {
    User : SID_AND_ATTRIBUTES
}
struct TOKEN_GROUPS {
    GroupCount : UInt32
    Groups : SID_AND_ATTRIBUTES[1]
}
struct TOKEN_PRIVILEGES {
    PrivilegeCount : UInt32
    Privileges : LUID_AND_ATTRIBUTES[1]
}
struct TOKEN_OWNER {
    Owner : PSID
}
struct TOKEN_PRIMARY_GROUP {
    PrimaryGroup : PSID
}
struct TOKEN_DEFAULT_DACL {
    DefaultDacl : ACL.Ptr
}
struct TOKEN_USER_CLAIMS {
    UserClaims : Struct.Ptr
}
struct TOKEN_DEVICE_CLAIMS {
    DeviceClaims : Struct.Ptr
}
struct TOKEN_GROUPS_AND_PRIVILEGES {
    SidCount : UInt32
    SidLength : UInt32
    Sids : SID_AND_ATTRIBUTES.Ptr
    RestrictedSidCount : UInt32
    RestrictedSidLength : UInt32
    RestrictedSids : SID_AND_ATTRIBUTES.Ptr
    PrivilegeCount : UInt32
    PrivilegeLength : UInt32
    Privileges : LUID_AND_ATTRIBUTES.Ptr
    AuthenticationId : LUID
}
struct TOKEN_LINKED_TOKEN {
    LinkedToken : HANDLE
}
struct TOKEN_ELEVATION {
    TokenIsElevated : UInt32
}
struct TOKEN_MANDATORY_LABEL {
    Label : SID_AND_ATTRIBUTES
}
struct TOKEN_MANDATORY_POLICY {
    Policy : TOKEN_MANDATORY_POLICY_ID
}
struct TOKEN_ACCESS_INFORMATION {
    SidHash : SID_AND_ATTRIBUTES_HASH.Ptr
    RestrictedSidHash : SID_AND_ATTRIBUTES_HASH.Ptr
    Privileges : TOKEN_PRIVILEGES.Ptr
    AuthenticationId : LUID
    TokenType : TOKEN_TYPE
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    MandatoryPolicy : TOKEN_MANDATORY_POLICY
    Flags : UInt32
    AppContainerNumber : UInt32
    PackageSid : PSID
    CapabilitiesHash : SID_AND_ATTRIBUTES_HASH.Ptr
    TrustLevelSid : PSID
    SecurityAttributes : Struct.Ptr
}
struct TOKEN_AUDIT_POLICY {
    PerUserPolicy : UInt8[31]
}
struct TOKEN_SOURCE {
    SourceName : CHAR[8]
    SourceIdentifier : LUID
}
struct TOKEN_STATISTICS {
    TokenId : LUID
    AuthenticationId : LUID
    ExpirationTime : Int64
    TokenType : TOKEN_TYPE
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    DynamicCharged : UInt32
    DynamicAvailable : UInt32
    GroupCount : UInt32
    PrivilegeCount : UInt32
    ModifiedId : LUID
}
struct TOKEN_CONTROL {
    TokenId : LUID
    AuthenticationId : LUID
    ModifiedId : LUID
    TokenSource : TOKEN_SOURCE
}
struct TOKEN_ORIGIN {
    OriginatingLogonSession : LUID
}
struct MANDATORY_LEVEL extends Int32 {
    static MandatoryLevelUntrusted := 0
    static MandatoryLevelLow := 1
    static MandatoryLevelMedium := 2
    static MandatoryLevelHigh := 3
    static MandatoryLevelSystem := 4
    static MandatoryLevelSecureProcess := 5
    static MandatoryLevelCount := 6
}
struct TOKEN_APPCONTAINER_INFORMATION {
    TokenAppContainer : PSID
}
struct CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE {
    Version : Int64
    Name : PWSTR
}
struct CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE {
    pValue : Struct.Ptr
    ValueLength : UInt32
}
struct CLAIM_SECURITY_ATTRIBUTE_V1 {
    Name : PWSTR
    ValueType : CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE
    Reserved : UInt16
    Flags : UInt32
    ValueCount : UInt32
    Values : this._Values_e__Union
    struct _Values_e__Union {
        union {
            pInt64 : Int64.Ptr
            pUint64 : Int64.Ptr
            ppString : PWSTR.Ptr
            pFqbn : CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE.Ptr
            pOctetString : CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE.Ptr
        }
    }
}
struct CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1 {
    Name : UInt32
    ValueType : CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE
    Reserved : UInt16
    Flags : CLAIM_SECURITY_ATTRIBUTE_FLAGS
    ValueCount : UInt32
    Values : this._Values_e__Union
    struct _Values_e__Union {
        union {
            pInt64 : UInt32[1]
            pUint64 : UInt32[1]
            ppString : UInt32[1]
            pFqbn : UInt32[1]
            pOctetString : UInt32[1]
        }
    }
}
struct CLAIM_SECURITY_ATTRIBUTES_INFORMATION {
    Version : UInt16
    Reserved : UInt16
    AttributeCount : UInt32
    Attribute : this._Attribute_e__Union
    struct _Attribute_e__Union {
        union {
            pAttributeV1 : CLAIM_SECURITY_ATTRIBUTE_V1.Ptr
        }
    }
}
struct SECURITY_QUALITY_OF_SERVICE {
    Length : UInt32
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    ContextTrackingMode : UInt8
    EffectiveOnly : BOOLEAN
}
struct SE_IMPERSONATION_STATE {
    Token : Struct.Ptr
    CopyOnOpen : BOOLEAN
    EffectiveOnly : BOOLEAN
    Level : SECURITY_IMPERSONATION_LEVEL
}
struct SECURITY_CAPABILITIES {
    AppContainerSid : PSID
    Capabilities : SID_AND_ATTRIBUTES.Ptr
    CapabilityCount : UInt32
    Reserved : UInt32
}
struct QUOTA_LIMITS {
    PagedPoolLimit : IntPtr
    NonPagedPoolLimit : IntPtr
    MinimumWorkingSetSize : IntPtr
    MaximumWorkingSetSize : IntPtr
    PagefileLimit : IntPtr
    TimeLimit : Int64
}
