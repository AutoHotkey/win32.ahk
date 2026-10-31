#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, FILETIME, HANDLE, HRESULT, NTSTATUS, PWSTR, SYSTEMTIME}
#Import "..\Graphics.Gdi\Types.ahk" {HFONT}
#Import "..\Security\Types.ahk" {PSECURITY_DESCRIPTOR, SECURITY_ATTRIBUTES, SECURITY_DESCRIPTOR_RELATIVE}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Services\Types.ahk" {SC_HANDLE}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct CLUSPROP_RESOURCE_CLASS_INFO {
    Base : CLUSPROP_VALUE
    Base2 : CLUS_RESOURCE_CLASS_INFO
}
struct CLUSTER_SHARED_VOLUME_RENAME_INPUT {
    Base : CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME
    Base2 : CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME
}
struct CLUSTER_SHARED_VOLUME_RENAME_GUID_INPUT {
    Base : CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME
    Base2 : CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME
}
struct CLUSPROP_PARTITION_INFO {
    Base : CLUSPROP_VALUE
    Base2 : CLUS_PARTITION_INFO
}
struct CLUSPROP_PARTITION_INFO_EX {
    Base : CLUSPROP_VALUE
    Base2 : CLUS_PARTITION_INFO_EX
}
struct CLUSPROP_PARTITION_INFO_EX2 {
    Base : CLUSPROP_PARTITION_INFO_EX
    Base2 : CLUS_PARTITION_INFO_EX2
}
struct CLUSPROP_FTSET_INFO {
    Base : CLUSPROP_VALUE
    Base2 : CLUS_FTSET_INFO
}
struct CLUSPROP_SCSI_ADDRESS {
    Base : CLUSPROP_VALUE
    Base2 : CLUS_SCSI_ADDRESS
}
struct HCHANGE {
    Value : IntPtr
}
struct HCLUSCRYPTPROVIDER {
    Value : IntPtr
}
struct HCLUSENUM {
    Value : IntPtr
}
struct HCLUSENUMEX {
    Value : IntPtr
}
struct HCLUSTER {
    Value : IntPtr
}
struct HGROUP {
    Value : IntPtr
}
struct HGROUPENUM {
    Value : IntPtr
}
struct HGROUPENUMEX {
    Value : IntPtr
}
struct HGROUPSET {
    Value : IntPtr
}
struct HGROUPSETENUM {
    Value : IntPtr
}
struct HNETINTERFACE {
    Value : IntPtr
}
struct HNETINTERFACEENUM {
    Value : IntPtr
}
struct HNETWORK {
    Value : IntPtr
}
struct HNETWORKENUM {
    Value : IntPtr
}
struct HNODE {
    Value : IntPtr
}
struct HNODEENUM {
    Value : IntPtr
}
struct HNODEENUMEX {
    Value : IntPtr
}
struct HREGBATCH {
    Value : IntPtr
}
struct HREGBATCHNOTIFICATION {
    Value : IntPtr
}
struct HREGBATCHPORT {
    Value : IntPtr
}
struct HREGREADBATCH {
    Value : IntPtr
}
struct HREGREADBATCHREPLY {
    Value : IntPtr
}
struct HRESENUM {
    Value : IntPtr
}
struct HRESENUMEX {
    Value : IntPtr
}
struct HRESOURCE {
    Value : IntPtr
}
struct HRESTYPEENUM {
    Value : IntPtr
}
struct CLUSTER_QUORUM_TYPE extends Int32 {
    static OperationalQuorum := 0
    static ModifyQuorum := 1
}
struct CLUSTERVERSIONINFO_NT4 {
    dwVersionInfoSize : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    BuildNumber : UInt16
    szVendorId : UInt16[64]
    szCSDVersion : UInt16[64]
}
struct CLUSTERVERSIONINFO {
    dwVersionInfoSize : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    BuildNumber : UInt16
    szVendorId : UInt16[64]
    szCSDVersion : UInt16[64]
    dwClusterHighestVersion : UInt32
    dwClusterLowestVersion : UInt32
    dwFlags : UInt32
    dwReserved : UInt32
}
struct CLUS_STARTING_PARAMS {
    dwSize : UInt32
    bForm : BOOL
    bFirst : BOOL
}
struct NODE_CLUSTER_STATE extends Int32 {
    static ClusterStateNotInstalled := 0
    static ClusterStateNotConfigured := 1
    static ClusterStateNotRunning := 3
    static ClusterStateRunning := 19
}
struct CLUSTER_RESOURCE_STATE_CHANGE_REASON extends Int32 {
    static eResourceStateChangeReasonUnknown := 0
    static eResourceStateChangeReasonMove := 1
    static eResourceStateChangeReasonFailover := 2
    static eResourceStateChangeReasonFailedMove := 3
    static eResourceStateChangeReasonShutdown := 4
    static eResourceStateChangeReasonRundown := 5
}
struct CLUSTER_REG_COMMAND extends Int32 {
    static CLUSREG_COMMAND_NONE := 0
    static CLUSREG_SET_VALUE := 1
    static CLUSREG_CREATE_KEY := 2
    static CLUSREG_DELETE_KEY := 3
    static CLUSREG_DELETE_VALUE := 4
    static CLUSREG_SET_KEY_SECURITY := 5
    static CLUSREG_VALUE_DELETED := 6
    static CLUSREG_READ_KEY := 7
    static CLUSREG_READ_VALUE := 8
    static CLUSREG_READ_ERROR := 9
    static CLUSREG_CONTROL_COMMAND := 10
    static CLUSREG_CONDITION_EXISTS := 11
    static CLUSREG_CONDITION_NOT_EXISTS := 12
    static CLUSREG_CONDITION_IS_EQUAL := 13
    static CLUSREG_CONDITION_IS_NOT_EQUAL := 14
    static CLUSREG_CONDITION_IS_GREATER_THAN := 15
    static CLUSREG_CONDITION_IS_LESS_THAN := 16
    static CLUSREG_CONDITION_KEY_EXISTS := 17
    static CLUSREG_CONDITION_KEY_NOT_EXISTS := 18
    static CLUSREG_LAST_COMMAND := 19
}
struct CLUSCTL_RESOURCE_STATE_CHANGE_REASON_STRUCT {
    dwSize : UInt32
    dwVersion : UInt32
    eReason : CLUSTER_RESOURCE_STATE_CHANGE_REASON
}
struct CLUSTER_BATCH_COMMAND {
    Command : CLUSTER_REG_COMMAND
    dwOptions : UInt32
    wzName : PWSTR
    lpData : UInt8.Ptr
    cbData : UInt32
}
struct CLUSTER_READ_BATCH_COMMAND {
    Command : CLUSTER_REG_COMMAND
    dwOptions : UInt32
    wzSubkeyName : PWSTR
    wzValueName : PWSTR
    lpData : UInt8.Ptr
    cbData : UInt32
}
struct CLUSTER_ENUM_ITEM {
    dwVersion : UInt32
    dwType : UInt32
    cbId : UInt32
    lpszId : PWSTR
    cbName : UInt32
    lpszName : PWSTR
}
struct CLUSGROUP_TYPE extends Int32 {
    static ClusGroupTypeCoreCluster := 1
    static ClusGroupTypeAvailableStorage := 2
    static ClusGroupTypeTemporary := 3
    static ClusGroupTypeSharedVolume := 4
    static ClusGroupTypeStoragePool := 5
    static ClusGroupTypeFileServer := 100
    static ClusGroupTypePrintServer := 101
    static ClusGroupTypeDhcpServer := 102
    static ClusGroupTypeDtc := 103
    static ClusGroupTypeMsmq := 104
    static ClusGroupTypeWins := 105
    static ClusGroupTypeStandAloneDfs := 106
    static ClusGroupTypeGenericApplication := 107
    static ClusGroupTypeGenericService := 108
    static ClusGroupTypeGenericScript := 109
    static ClusGroupTypeIScsiNameService := 110
    static ClusGroupTypeVirtualMachine := 111
    static ClusGroupTypeTsSessionBroker := 112
    static ClusGroupTypeIScsiTarget := 113
    static ClusGroupTypeScaleoutFileServer := 114
    static ClusGroupTypeVMReplicaBroker := 115
    static ClusGroupTypeTaskScheduler := 116
    static ClusGroupTypeClusterUpdateAgent := 117
    static ClusGroupTypeScaleoutCluster := 118
    static ClusGroupTypeStorageReplica := 119
    static ClusGroupTypeVMReplicaCoordinator := 120
    static ClusGroupTypeCrossClusterOrchestrator := 121
    static ClusGroupTypeInfrastructureFileServer := 122
    static ClusGroupTypeCoreSddc := 123
    static ClusGroupTypeUserManager := 124
    static ClusGroupTypeKeyValueStoreManager := 125
    static ClusGroupTypeHcsVirtualMachine := 126
    static ClusGroupTypeMetaVirtualMachine := 127
    static ClusGroupTypeUnknown := 9999
}
struct CLUSTER_CREATE_GROUP_INFO {
    dwVersion : UInt32
    groupType : CLUSGROUP_TYPE
}
struct CLUSTER_MGMT_POINT_TYPE extends Int32 {
    static CLUSTER_MGMT_POINT_TYPE_NONE := 0
    static CLUSTER_MGMT_POINT_TYPE_CNO := 1
    static CLUSTER_MGMT_POINT_TYPE_DNS_ONLY := 2
    static CLUSTER_MGMT_POINT_TYPE_CNO_ONLY := 3
}
struct CLUSTER_MGMT_POINT_RESTYPE extends Int32 {
    static CLUSTER_MGMT_POINT_RESTYPE_AUTO := 0
    static CLUSTER_MGMT_POINT_RESTYPE_SNN := 1
    static CLUSTER_MGMT_POINT_RESTYPE_DNN := 2
}
struct CLUSTER_CLOUD_TYPE extends Int32 {
    static CLUSTER_CLOUD_TYPE_NONE := 0
    static CLUSTER_CLOUD_TYPE_AZURE := 1
    static CLUSTER_CLOUD_TYPE_MIXED := 128
    static CLUSTER_CLOUD_TYPE_UNKNOWN := -1
}
struct CLUS_GROUP_START_SETTING extends Int32 {
    static CLUS_GROUP_START_ALWAYS := 0
    static CLUS_GROUP_DO_NOT_START := 1
    static CLUS_GROUP_START_ALLOWED := 2
}
struct CLUS_AFFINITY_RULE_TYPE extends Int32 {
    static CLUS_AFFINITY_RULE_NONE := 0
    static CLUS_AFFINITY_RULE_SAME_FAULT_DOMAIN := 1
    static CLUS_AFFINITY_RULE_SAME_NODE := 2
    static CLUS_AFFINITY_RULE_DIFFERENT_FAULT_DOMAIN := 3
    static CLUS_AFFINITY_RULE_DIFFERENT_NODE := 4
    static CLUS_AFFINITY_RULE_MIN := 0
    static CLUS_AFFINITY_RULE_MAX := 4
}
struct CLUS_ADAPTER_EXCLUSION_TYPE extends Int32 {
    static CLUS_ADAPTER_EXCLUSION_TYPE_IPPREFIX := 0
    static CLUS_ADAPTER_EXCLUSION_TYPE_DESCRIPTION := 1
    static CLUS_ADAPTER_EXCLUSION_TYPE_FRIENDLYNAME := 2
}
struct CLUSTER_QUORUM_VALUE extends Int32 {
    static CLUSTER_QUORUM_MAINTAINED := 0
    static CLUSTER_QUORUM_LOST := 1
}
struct CLUSTER_VALIDATE_PATH {
    szPath : UInt16[1]
}
struct CLUSTER_VALIDATE_DIRECTORY {
    szPath : UInt16[1]
}
struct CLUSTER_VALIDATE_NETNAME {
    szNetworkName : UInt16[1]
}
struct CLUSTER_VALIDATE_CSV_FILENAME {
    szFileName : UInt16[1]
}
struct CLUSTER_SET_PASSWORD_STATUS {
    NodeId : UInt32
    SetAttempted : BOOLEAN
    ReturnStatus : UInt32
}
struct CLUSTER_IP_ENTRY {
    lpszIpAddress : PWSTR
    dwPrefixLength : UInt32
}
struct CREATE_CLUSTER_CONFIG {
    dwVersion : UInt32
    lpszClusterName : PWSTR
    cNodes : UInt32
    ppszNodeNames : PWSTR.Ptr
    cIpEntries : UInt32
    pIpEntries : CLUSTER_IP_ENTRY.Ptr
    fEmptyCluster : BOOLEAN
    managementPointType : CLUSTER_MGMT_POINT_TYPE
    managementPointResType : CLUSTER_MGMT_POINT_RESTYPE
    pszUserName : PWSTR
    pszPassword : PWSTR
    pszDomain : PWSTR
}
struct CREATE_CLUSTER_NAME_ACCOUNT {
    dwVersion : UInt32
    lpszClusterName : PWSTR
    dwFlags : UInt32
    pszUserName : PWSTR
    pszPassword : PWSTR
    pszDomain : PWSTR
    managementPointType : CLUSTER_MGMT_POINT_TYPE
    managementPointResType : CLUSTER_MGMT_POINT_RESTYPE
    bUpgradeVCOs : BOOLEAN
}
struct REPAIR_CLUSTER_NAME_ACCOUNT_CONFIG {
    dwVersion : UInt32
    dwFlags : UInt32
    pszUserName : PWSTR
    pszPassword : PWSTR
    pszDomain : PWSTR
}
struct PCLUSAPI_PFN_REASON_HANDLER extends FunctionPointer {
    static Types := [Struct.Ptr, HCLUSTER, PWSTR, UInt32.Ptr, BOOL]
}
struct CLUSAPI_REASON_HANDLER {
    lpParameter : Struct.Ptr
    pfnHandler : PCLUSAPI_PFN_REASON_HANDLER
}
struct PCLUSAPI_SET_REASON_HANDLER extends FunctionPointer {
    static Types := [CLUSAPI_REASON_HANDLER.Ptr, CLUSAPI_REASON_HANDLER.Ptr]
}
struct PCLUSAPI_GET_NODE_CLUSTER_STATE extends FunctionPointer {
    static Types := [PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_OPEN_CLUSTER extends FunctionPointer {
    static Types := [PWSTR, HCLUSTER]
}
struct PCLUSAPI_OPEN_CLUSTER_EX extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32.Ptr, HCLUSTER]
}
struct PCLUSAPI_CLOSE_CLUSTER extends FunctionPointer {
    static Types := [HCLUSTER, BOOL]
}
struct PCLUSAPI_SetClusterName extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_NAME_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_INFORMATION extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32.Ptr, CLUSTERVERSIONINFO.Ptr, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_QUORUM_RESOURCE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_QUORUM_RESOURCE_EX extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32, PWSTR, UInt32]
}
struct PCLUSAPI_BACKUP_CLUSTER_DATABASE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32]
}
struct PCLUSAPI_RESTORE_CLUSTER_DATABASE extends FunctionPointer {
    static Types := [PWSTR, BOOL, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_NETWORK_PRIORITY_ORDER extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, HNETWORK.Ptr, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_SERVICE_ACCOUNT_PASSWORD extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, CLUSTER_SET_PASSWORD_STATUS.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_CONTROL extends FunctionPointer {
    static Types := [HCLUSTER, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_CONTROL_EX extends FunctionPointer {
    static Types := [HCLUSTER, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct CLUSTER_UPGRADE_PHASE extends Int32 {
    static ClusterUpgradePhaseInitialize := 1
    static ClusterUpgradePhaseValidatingUpgrade := 2
    static ClusterUpgradePhaseUpgradingComponents := 3
    static ClusterUpgradePhaseInstallingNewComponents := 4
    static ClusterUpgradePhaseUpgradeComplete := 5
}
struct PCLUSTER_UPGRADE_PROGRESS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, CLUSTER_UPGRADE_PHASE, BOOL]
}
struct PCLUSAPI_CLUSTER_UPGRADE extends FunctionPointer {
    static Types := [HCLUSTER, BOOL, PCLUSTER_UPGRADE_PROGRESS_CALLBACK, Struct.Ptr, UInt32]
}
struct CLUSTER_CHANGE extends Int32 {
    static CLUSTER_CHANGE_NODE_STATE := 1
    static CLUSTER_CHANGE_NODE_DELETED := 2
    static CLUSTER_CHANGE_NODE_ADDED := 4
    static CLUSTER_CHANGE_NODE_PROPERTY := 8
    static CLUSTER_CHANGE_REGISTRY_NAME := 16
    static CLUSTER_CHANGE_REGISTRY_ATTRIBUTES := 32
    static CLUSTER_CHANGE_REGISTRY_VALUE := 64
    static CLUSTER_CHANGE_REGISTRY_SUBTREE := 128
    static CLUSTER_CHANGE_RESOURCE_STATE := 256
    static CLUSTER_CHANGE_RESOURCE_DELETED := 512
    static CLUSTER_CHANGE_RESOURCE_ADDED := 1024
    static CLUSTER_CHANGE_RESOURCE_PROPERTY := 2048
    static CLUSTER_CHANGE_GROUP_STATE := 4096
    static CLUSTER_CHANGE_GROUP_DELETED := 8192
    static CLUSTER_CHANGE_GROUP_ADDED := 16384
    static CLUSTER_CHANGE_GROUP_PROPERTY := 32768
    static CLUSTER_CHANGE_RESOURCE_TYPE_DELETED := 65536
    static CLUSTER_CHANGE_RESOURCE_TYPE_ADDED := 131072
    static CLUSTER_CHANGE_RESOURCE_TYPE_PROPERTY := 262144
    static CLUSTER_CHANGE_CLUSTER_RECONNECT := 524288
    static CLUSTER_CHANGE_NETWORK_STATE := 1048576
    static CLUSTER_CHANGE_NETWORK_DELETED := 2097152
    static CLUSTER_CHANGE_NETWORK_ADDED := 4194304
    static CLUSTER_CHANGE_NETWORK_PROPERTY := 8388608
    static CLUSTER_CHANGE_NETINTERFACE_STATE := 16777216
    static CLUSTER_CHANGE_NETINTERFACE_DELETED := 33554432
    static CLUSTER_CHANGE_NETINTERFACE_ADDED := 67108864
    static CLUSTER_CHANGE_NETINTERFACE_PROPERTY := 134217728
    static CLUSTER_CHANGE_QUORUM_STATE := 268435456
    static CLUSTER_CHANGE_CLUSTER_STATE := 536870912
    static CLUSTER_CHANGE_CLUSTER_PROPERTY := 1073741824
    static CLUSTER_CHANGE_HANDLE_CLOSE := -2147483648
    static CLUSTER_CHANGE_ALL := -1
}
struct CLUSTER_NOTIFICATIONS_VERSION extends Int32 {
    static CLUSTER_NOTIFICATIONS_V1 := 1
    static CLUSTER_NOTIFICATIONS_V2 := 2
}
struct CLUSTER_CHANGE_CLUSTER_V2 extends Int32 {
    static CLUSTER_CHANGE_CLUSTER_RECONNECT_V2 := 1
    static CLUSTER_CHANGE_CLUSTER_STATE_V2 := 2
    static CLUSTER_CHANGE_CLUSTER_GROUP_ADDED_V2 := 4
    static CLUSTER_CHANGE_CLUSTER_HANDLE_CLOSE_V2 := 8
    static CLUSTER_CHANGE_CLUSTER_NETWORK_ADDED_V2 := 16
    static CLUSTER_CHANGE_CLUSTER_NODE_ADDED_V2 := 32
    static CLUSTER_CHANGE_CLUSTER_RESOURCE_TYPE_ADDED_V2 := 64
    static CLUSTER_CHANGE_CLUSTER_COMMON_PROPERTY_V2 := 128
    static CLUSTER_CHANGE_CLUSTER_PRIVATE_PROPERTY_V2 := 256
    static CLUSTER_CHANGE_CLUSTER_LOST_NOTIFICATIONS_V2 := 512
    static CLUSTER_CHANGE_CLUSTER_RENAME_V2 := 1024
    static CLUSTER_CHANGE_CLUSTER_MEMBERSHIP_V2 := 2048
    static CLUSTER_CHANGE_CLUSTER_UPGRADED_V2 := 4096
    static CLUSTER_CHANGE_CLUSTER_ALL_V2 := 8191
}
struct CLUSTER_CHANGE_GROUP_V2 extends Int32 {
    static CLUSTER_CHANGE_GROUP_DELETED_V2 := 1
    static CLUSTER_CHANGE_GROUP_COMMON_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_GROUP_PRIVATE_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_GROUP_STATE_V2 := 8
    static CLUSTER_CHANGE_GROUP_OWNER_NODE_V2 := 16
    static CLUSTER_CHANGE_GROUP_PREFERRED_OWNERS_V2 := 32
    static CLUSTER_CHANGE_GROUP_RESOURCE_ADDED_V2 := 64
    static CLUSTER_CHANGE_GROUP_RESOURCE_GAINED_V2 := 128
    static CLUSTER_CHANGE_GROUP_RESOURCE_LOST_V2 := 256
    static CLUSTER_CHANGE_GROUP_HANDLE_CLOSE_V2 := 512
    static CLUSTER_CHANGE_GROUP_ALL_V2 := 1023
}
struct CLUSTER_CHANGE_GROUPSET_V2 extends Int32 {
    static CLUSTER_CHANGE_GROUPSET_DELETED_v2 := 1
    static CLUSTER_CHANGE_GROUPSET_COMMON_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_GROUPSET_PRIVATE_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_GROUPSET_STATE_V2 := 8
    static CLUSTER_CHANGE_GROUPSET_GROUP_ADDED := 16
    static CLUSTER_CHANGE_GROUPSET_GROUP_REMOVED := 32
    static CLUSTER_CHANGE_GROUPSET_DEPENDENCIES_V2 := 64
    static CLUSTER_CHANGE_GROUPSET_DEPENDENTS_V2 := 128
    static CLUSTER_CHANGE_GROUPSET_HANDLE_CLOSE_v2 := 256
    static CLUSTER_CHANGE_GROUPSET_ALL_V2 := 511
}
struct CLUSTER_CHANGE_RESOURCE_V2 extends Int32 {
    static CLUSTER_CHANGE_RESOURCE_COMMON_PROPERTY_V2 := 1
    static CLUSTER_CHANGE_RESOURCE_PRIVATE_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_RESOURCE_STATE_V2 := 4
    static CLUSTER_CHANGE_RESOURCE_OWNER_GROUP_V2 := 8
    static CLUSTER_CHANGE_RESOURCE_DEPENDENCIES_V2 := 16
    static CLUSTER_CHANGE_RESOURCE_DEPENDENTS_V2 := 32
    static CLUSTER_CHANGE_RESOURCE_POSSIBLE_OWNERS_V2 := 64
    static CLUSTER_CHANGE_RESOURCE_DELETED_V2 := 128
    static CLUSTER_CHANGE_RESOURCE_DLL_UPGRADED_V2 := 256
    static CLUSTER_CHANGE_RESOURCE_HANDLE_CLOSE_V2 := 512
    static CLUSTER_CHANGE_RESOURCE_TERMINAL_STATE_V2 := 1024
    static CLUSTER_CHANGE_RESOURCE_ALL_V2 := 2047
}
struct CLUSTER_CHANGE_RESOURCE_TYPE_V2 extends Int32 {
    static CLUSTER_CHANGE_RESOURCE_TYPE_DELETED_V2 := 1
    static CLUSTER_CHANGE_RESOURCE_TYPE_COMMON_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_RESOURCE_TYPE_PRIVATE_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_RESOURCE_TYPE_POSSIBLE_OWNERS_V2 := 8
    static CLUSTER_CHANGE_RESOURCE_TYPE_DLL_UPGRADED_V2 := 16
    static CLUSTER_RESOURCE_TYPE_SPECIFIC_V2 := 32
    static CLUSTER_CHANGE_RESOURCE_TYPE_ALL_V2 := 63
}
struct CLUSTER_CHANGE_NETINTERFACE_V2 extends Int32 {
    static CLUSTER_CHANGE_NETINTERFACE_DELETED_V2 := 1
    static CLUSTER_CHANGE_NETINTERFACE_COMMON_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_NETINTERFACE_PRIVATE_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_NETINTERFACE_STATE_V2 := 8
    static CLUSTER_CHANGE_NETINTERFACE_HANDLE_CLOSE_V2 := 16
    static CLUSTER_CHANGE_NETINTERFACE_ALL_V2 := 31
}
struct CLUSTER_CHANGE_NETWORK_V2 extends Int32 {
    static CLUSTER_CHANGE_NETWORK_DELETED_V2 := 1
    static CLUSTER_CHANGE_NETWORK_COMMON_PROPERTY_V2 := 2
    static CLUSTER_CHANGE_NETWORK_PRIVATE_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_NETWORK_STATE_V2 := 8
    static CLUSTER_CHANGE_NETWORK_HANDLE_CLOSE_V2 := 16
    static CLUSTER_CHANGE_NETWORK_ALL_V2 := 31
}
struct CLUSTER_CHANGE_NODE_V2 extends Int32 {
    static CLUSTER_CHANGE_NODE_NETINTERFACE_ADDED_V2 := 1
    static CLUSTER_CHANGE_NODE_DELETED_V2 := 2
    static CLUSTER_CHANGE_NODE_COMMON_PROPERTY_V2 := 4
    static CLUSTER_CHANGE_NODE_PRIVATE_PROPERTY_V2 := 8
    static CLUSTER_CHANGE_NODE_STATE_V2 := 16
    static CLUSTER_CHANGE_NODE_GROUP_GAINED_V2 := 32
    static CLUSTER_CHANGE_NODE_GROUP_LOST_V2 := 64
    static CLUSTER_CHANGE_NODE_HANDLE_CLOSE_V2 := 128
    static CLUSTER_CHANGE_NODE_ALL_V2 := 255
}
struct CLUSTER_CHANGE_REGISTRY_V2 extends Int32 {
    static CLUSTER_CHANGE_REGISTRY_ATTRIBUTES_V2 := 1
    static CLUSTER_CHANGE_REGISTRY_NAME_V2 := 2
    static CLUSTER_CHANGE_REGISTRY_SUBTREE_V2 := 4
    static CLUSTER_CHANGE_REGISTRY_VALUE_V2 := 8
    static CLUSTER_CHANGE_REGISTRY_HANDLE_CLOSE_V2 := 16
    static CLUSTER_CHANGE_REGISTRY_ALL_V2 := 31
}
struct CLUSTER_CHANGE_QUORUM_V2 extends Int32 {
    static CLUSTER_CHANGE_QUORUM_STATE_V2 := 1
    static CLUSTER_CHANGE_QUORUM_ALL_V2 := 1
}
struct CLUSTER_CHANGE_SHARED_VOLUME_V2 extends Int32 {
    static CLUSTER_CHANGE_SHARED_VOLUME_STATE_V2 := 1
    static CLUSTER_CHANGE_SHARED_VOLUME_ADDED_V2 := 2
    static CLUSTER_CHANGE_SHARED_VOLUME_REMOVED_V2 := 4
    static CLUSTER_CHANGE_SHARED_VOLUME_ALL_V2 := 7
}
struct CLUSTER_CHANGE_SPACEPORT_V2 extends Int32 {
    static CLUSTER_CHANGE_SPACEPORT_CUSTOM_PNP_V2 := 1
}
struct CLUSTER_CHANGE_NODE_UPGRADE_PHASE_V2 extends Int32 {
    static CLUSTER_CHANGE_UPGRADE_NODE_PREPARE := 1
    static CLUSTER_CHANGE_UPGRADE_NODE_COMMIT := 2
    static CLUSTER_CHANGE_UPGRADE_NODE_POSTCOMMIT := 4
    static CLUSTER_CHANGE_UPGRADE_ALL := 7
}
struct CLUSTER_OBJECT_TYPE extends Int32 {
    static CLUSTER_OBJECT_TYPE_NONE := 0
    static CLUSTER_OBJECT_TYPE_CLUSTER := 1
    static CLUSTER_OBJECT_TYPE_GROUP := 2
    static CLUSTER_OBJECT_TYPE_RESOURCE := 3
    static CLUSTER_OBJECT_TYPE_RESOURCE_TYPE := 4
    static CLUSTER_OBJECT_TYPE_NETWORK_INTERFACE := 5
    static CLUSTER_OBJECT_TYPE_NETWORK := 6
    static CLUSTER_OBJECT_TYPE_NODE := 7
    static CLUSTER_OBJECT_TYPE_REGISTRY := 8
    static CLUSTER_OBJECT_TYPE_QUORUM := 9
    static CLUSTER_OBJECT_TYPE_SHARED_VOLUME := 10
    static CLUSTER_OBJECT_TYPE_GROUPSET := 13
    static CLUSTER_OBJECT_TYPE_AFFINITYRULE := 16
    static CLUSTER_OBJECT_TYPE_FAULTDOMAIN := 17
}
struct CLUSTERSET_OBJECT_TYPE extends Int32 {
    static CLUSTERSET_OBJECT_TYPE_NONE := 0
    static CLUSTERSET_OBJECT_TYPE_MEMBER := 1
    static CLUSTERSET_OBJECT_TYPE_WORKLOAD := 2
    static CLUSTERSET_OBJECT_TYPE_DATABASE := 3
}
struct NOTIFY_FILTER_AND_TYPE {
    dwObjectType : UInt32
    FilterFlags : Int64
}
struct CLUSTER_MEMBERSHIP_INFO {
    HasQuorum : BOOL
    UpnodesSize : UInt32
    Upnodes : UInt8[1]
}
struct PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT_V2 extends FunctionPointer {
    static Types := [HCHANGE, HCLUSTER, NOTIFY_FILTER_AND_TYPE.Ptr, UInt32, IntPtr, HCHANGE]
}
struct PCLUSAPI_REGISTER_CLUSTER_NOTIFY_V2 extends FunctionPointer {
    static Types := [HCHANGE, NOTIFY_FILTER_AND_TYPE, HANDLE, IntPtr, UInt32]
}
struct PCLUSAPI_GET_NOTIFY_EVENT_HANDLE_V2 extends FunctionPointer {
    static Types := [HCHANGE, HANDLE.Ptr, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_NOTIFY_V2 extends FunctionPointer {
    static Types := [HCHANGE, IntPtr.Ptr, NOTIFY_FILTER_AND_TYPE.Ptr, UInt8.Ptr, UInt32.Ptr, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32, UInt32]
}
struct PCLUSAPI_CREATE_CLUSTER_NOTIFY_PORT extends FunctionPointer {
    static Types := [HCHANGE, HCLUSTER, UInt32, IntPtr, HCHANGE]
}
struct PCLUSAPI_REGISTER_CLUSTER_NOTIFY extends FunctionPointer {
    static Types := [HCHANGE, UInt32, HANDLE, IntPtr, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_NOTIFY extends FunctionPointer {
    static Types := [HCHANGE, IntPtr.Ptr, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32, UInt32]
}
struct PCLUSAPI_CLOSE_CLUSTER_NOTIFY_PORT extends FunctionPointer {
    static Types := [HCHANGE, BOOL]
}
struct CLUSTER_ENUM extends Int32 {
    static CLUSTER_ENUM_NODE := 1
    static CLUSTER_ENUM_RESTYPE := 2
    static CLUSTER_ENUM_RESOURCE := 4
    static CLUSTER_ENUM_GROUP := 8
    static CLUSTER_ENUM_NETWORK := 16
    static CLUSTER_ENUM_NETINTERFACE := 32
    static CLUSTER_ENUM_CAPACITY_NODE := 268435456
    static CLUSTER_ENUM_SHARED_VOLUME_GROUP := 536870912
    static CLUSTER_ENUM_SHARED_VOLUME_RESOURCE := 1073741824
    static CLUSTER_ENUM_INTERNAL_NETWORK := -2147483648
    static CLUSTER_ENUM_ALL := 63
}
struct PCLUSAPI_CLUSTER_OPEN_ENUM extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, HCLUSENUM]
}
struct PCLUSAPI_CLUSTER_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HCLUSENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_ENUM extends FunctionPointer {
    static Types := [HCLUSENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_CLOSE_ENUM extends FunctionPointer {
    static Types := [HCLUSENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_OPEN_ENUM_EX extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, Struct.Ptr, HCLUSENUMEX]
}
struct PCLUSAPI_CLUSTER_GET_ENUM_COUNT_EX extends FunctionPointer {
    static Types := [HCLUSENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_ENUM_EX extends FunctionPointer {
    static Types := [HCLUSENUMEX, UInt32, CLUSTER_ENUM_ITEM.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_CLOSE_ENUM_EX extends FunctionPointer {
    static Types := [HCLUSENUMEX, UInt32]
}
struct PCLUSAPI_CREATE_CLUSTER_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUPSET]
}
struct PCLUSAPI_OPEN_CLUSTER_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUPSET]
}
struct PCLUSAPI_CLOSE_CLUSTER_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HGROUPSET, BOOL]
}
struct PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HGROUPSET, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_GROUP_GROUPSET_EX extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HGROUPSET, HGROUP, UInt32]
}
struct PCLUSAPI_CLUSTER_ADD_GROUP_TO_GROUPSET_WITH_DOMAINS_EX extends FunctionPointer {
    static Types := [HGROUPSET, HGROUP, UInt32, UInt32, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUPSET extends FunctionPointer {
    static Types := [HGROUPSET, UInt32]
}
struct PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_GROUPSET_EX extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL extends FunctionPointer {
    static Types := [HGROUPSET, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_GROUPSET_CONTROL_EX extends FunctionPointer {
    static Types := [HGROUPSET, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUP, HGROUP, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUP, HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION extends FunctionPointer {
    static Types := [HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_SET_GROUP_DEPENDENCY_EXPRESSION_EX extends FunctionPointer {
    static Types := [HGROUP, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUP, HGROUP, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUP, HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUPSET, HGROUPSET, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUPSET, HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EXPRESSION_EX extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUPSET, HGROUPSET, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_GROUPSET_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUPSET, HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUP, HGROUPSET, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUP, HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUP, HGROUPSET, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_GROUP_TO_GROUP_GROUPSET_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HGROUP, HGROUPSET, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_FROM_GROUP_GROUPSET extends FunctionPointer {
    static Types := [HGROUPSET, HCLUSTER]
}
struct PCLUSAPI_ADD_CROSS_CLUSTER_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CROSS_CLUSTER_GROUPSET_DEPENDENCY extends FunctionPointer {
    static Types := [HGROUPSET, PWSTR, PWSTR, UInt32]
}
struct CLUSTER_AVAILABILITY_SET_CONFIG {
    dwVersion : UInt32
    dwUpdateDomains : UInt32
    dwFaultDomains : UInt32
    bReserveSpareNode : BOOL
}
struct PCLUSAPI_CREATE_CLUSTER_AVAILABILITY_SET extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, CLUSTER_AVAILABILITY_SET_CONFIG.Ptr, HGROUPSET]
}
struct PCLUSAPI_CLUSTER_CREATE_AFFINITY_RULE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, CLUS_AFFINITY_RULE_TYPE, UInt32]
}
struct PCLUSAPI_CLUSTER_REMOVE_AFFINITY_RULE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_ADD_GROUP_TO_AFFINITY_RULE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUP, UInt32]
}
struct PCLUSAPI_CLUSTER_REMOVE_GROUP_FROM_AFFINITY_RULE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUP, UInt32]
}
struct PCLUSAPI_CLUSTER_AFFINITY_RULE_CONTROL extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct CLUSTER_NODE_ENUM extends Int32 {
    static CLUSTER_NODE_ENUM_NETINTERFACES := 1
    static CLUSTER_NODE_ENUM_GROUPS := 2
    static CLUSTER_NODE_ENUM_PREFERRED_GROUPS := 4
    static CLUSTER_NODE_ENUM_ALL := 3
}
struct CLUSTER_NODE_STATE extends Int32 {
    static ClusterNodeStateUnknown := -1
    static ClusterNodeUp := 0
    static ClusterNodeDown := 1
    static ClusterNodePaused := 2
    static ClusterNodeJoining := 3
}
struct CLUSTER_STORAGENODE_STATE extends Int32 {
    static ClusterStorageNodeStateUnknown := 0
    static ClusterStorageNodeUp := 1
    static ClusterStorageNodeDown := 2
    static ClusterStorageNodePaused := 3
    static ClusterStorageNodeStarting := 4
    static ClusterStorageNodeStopping := 5
}
struct CLUSTER_NODE_DRAIN_STATUS extends Int32 {
    static NodeDrainStatusNotInitiated := 0
    static NodeDrainStatusInProgress := 1
    static NodeDrainStatusCompleted := 2
    static NodeDrainStatusFailed := 3
    static ClusterNodeDrainStatusCount := 4
}
struct CLUSTER_NODE_STATUS extends Int32 {
    static NodeStatusNormal := 0
    static NodeStatusIsolated := 1
    static NodeStatusQuarantined := 2
    static NodeStatusDrainInProgress := 4
    static NodeStatusDrainCompleted := 8
    static NodeStatusDrainFailed := 16
    static NodeStatusAvoidPlacement := 32
    static NodeStatusMax := 51
}
struct CLUSTER_NODE_FAILBACK_STATUS extends Int32 {
    static NodeFailbackStatusNotInitiated := 0
    static NodeFailbackStatusInProgress := 1
    static NodeFailbackStatusCompleted := 2
    static NodeFailbackStatusFailed := 3
    static ClusterNodeFailbackStatusCount := 4
}
struct PCLUSAPI_OPEN_CLUSTER_NODE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNODE]
}
struct PCLUSAPI_OPEN_CLUSTER_NODE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32.Ptr, HNODE]
}
struct PCLUSAPI_OPEN_NODE_BY_ID extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, HNODE]
}
struct PCLUSAPI_CLOSE_CLUSTER_NODE extends FunctionPointer {
    static Types := [HNODE, BOOL]
}
struct PCLUSAPI_GET_CLUSTER_NODE_STATE extends FunctionPointer {
    static Types := [HNODE, CLUSTER_NODE_STATE]
}
struct PCLUSAPI_GET_CLUSTER_NODE_ID extends FunctionPointer {
    static Types := [HNODE, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_FROM_NODE extends FunctionPointer {
    static Types := [HNODE, HCLUSTER]
}
struct PCLUSAPI_PAUSE_CLUSTER_NODE extends FunctionPointer {
    static Types := [HNODE, UInt32]
}
struct PCLUSAPI_RESUME_CLUSTER_NODE extends FunctionPointer {
    static Types := [HNODE, UInt32]
}
struct PCLUSAPI_EVICT_CLUSTER_NODE extends FunctionPointer {
    static Types := [HNODE, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_OPEN_ENUM extends FunctionPointer {
    static Types := [HNODE, UInt32, HNODEENUM]
}
struct PCLUSAPI_CLUSTER_NODE_OPEN_ENUM_EX extends FunctionPointer {
    static Types := [HNODE, UInt32, Struct.Ptr, HNODEENUMEX]
}
struct PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT_EX extends FunctionPointer {
    static Types := [HNODEENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_ENUM_EX extends FunctionPointer {
    static Types := [HNODEENUMEX, UInt32, CLUSTER_ENUM_ITEM.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM_EX extends FunctionPointer {
    static Types := [HNODEENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HNODEENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_CLOSE_ENUM extends FunctionPointer {
    static Types := [HNODEENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_ENUM extends FunctionPointer {
    static Types := [HNODEENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_EVICT_CLUSTER_NODE_EX extends FunctionPointer {
    static Types := [HNODE, UInt32, HRESULT.Ptr, UInt32]
}
struct PCLUSAPI_EVICT_CLUSTER_NODE_EX2 extends FunctionPointer {
    static Types := [HNODE, UInt32, HRESULT.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_RESOURCE_TYPE_KEY extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, HKEY]
}
struct CLUSTER_GROUP_ENUM extends Int32 {
    static CLUSTER_GROUP_ENUM_CONTAINS := 1
    static CLUSTER_GROUP_ENUM_NODES := 2
    static CLUSTER_GROUP_ENUM_ALL := 3
}
struct CLUSTER_GROUP_STATE extends Int32 {
    static ClusterGroupStateUnknown := -1
    static ClusterGroupOnline := 0
    static ClusterGroupOffline := 1
    static ClusterGroupFailed := 2
    static ClusterGroupPartialOnline := 3
    static ClusterGroupPending := 4
}
struct CLUSTER_GROUP_PRIORITY extends Int32 {
    static PriorityDisabled := 0
    static PriorityLow := 1000
    static PriorityMedium := 2000
    static PriorityHigh := 3000
}
struct CLUSTER_GROUP_AUTOFAILBACK_TYPE extends Int32 {
    static ClusterGroupPreventFailback := 0
    static ClusterGroupAllowFailback := 1
    static ClusterGroupFailbackTypeCount := 2
}
struct CLUSTER_GROUP_ENUM_ITEM {
    dwVersion : UInt32
    cbId : UInt32
    lpszId : PWSTR
    cbName : UInt32
    lpszName : PWSTR
    state : CLUSTER_GROUP_STATE
    cbOwnerNode : UInt32
    lpszOwnerNode : PWSTR
    dwFlags : UInt32
    cbProperties : UInt32
    pProperties : Struct.Ptr
    cbRoProperties : UInt32
    pRoProperties : Struct.Ptr
}
struct CLUSTER_RESOURCE_ENUM_ITEM {
    dwVersion : UInt32
    cbId : UInt32
    lpszId : PWSTR
    cbName : UInt32
    lpszName : PWSTR
    cbOwnerGroupName : UInt32
    lpszOwnerGroupName : PWSTR
    cbOwnerGroupId : UInt32
    lpszOwnerGroupId : PWSTR
    cbProperties : UInt32
    pProperties : Struct.Ptr
    cbRoProperties : UInt32
    pRoProperties : Struct.Ptr
}
struct PCLUSAPI_CREATE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUP]
}
struct PCLUSAPI_OPEN_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HGROUP]
}
struct PCLUSAPI_OPEN_CLUSTER_GROUP_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32.Ptr, HGROUP]
}
struct PCLUSAPI_PAUSE_CLUSTER_NODE_EX extends FunctionPointer {
    static Types := [HNODE, BOOL, UInt32, HNODE, UInt32]
}
struct PCLUSAPI_PAUSE_CLUSTER_NODE_EX2 extends FunctionPointer {
    static Types := [HNODE, BOOL, UInt32, HNODE, PWSTR, UInt32]
}
struct CLUSTER_NODE_RESUME_FAILBACK_TYPE extends Int32 {
    static DoNotFailbackGroups := 0
    static FailbackGroupsImmediately := 1
    static FailbackGroupsPerPolicy := 2
    static ClusterNodeResumeFailbackTypeCount := 3
}
struct PCLUSAPI_RESUME_CLUSTER_NODE_EX extends FunctionPointer {
    static Types := [HNODE, CLUSTER_NODE_RESUME_FAILBACK_TYPE, UInt32, UInt32]
}
struct PCLUSAPI_RESUME_CLUSTER_NODE_EX2 extends FunctionPointer {
    static Types := [HNODE, CLUSTER_NODE_RESUME_FAILBACK_TYPE, UInt32, PWSTR, UInt32]
}
struct PCLUSAPI_CREATE_CLUSTER_GROUPEX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, CLUSTER_CREATE_GROUP_INFO.Ptr, HGROUP]
}
struct PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, PWSTR, UInt32, UInt32, HGROUPENUMEX]
}
struct PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT_EX extends FunctionPointer {
    static Types := [HGROUPENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_ENUM_EX extends FunctionPointer {
    static Types := [HGROUPENUMEX, UInt32, CLUSTER_GROUP_ENUM_ITEM.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM_EX extends FunctionPointer {
    static Types := [HGROUPENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, PWSTR, UInt32, UInt32, HRESENUMEX]
}
struct PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT_EX extends FunctionPointer {
    static Types := [HRESENUMEX, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_ENUM_EX extends FunctionPointer {
    static Types := [HRESENUMEX, UInt32, CLUSTER_RESOURCE_ENUM_ITEM.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM_EX extends FunctionPointer {
    static Types := [HRESENUMEX, UInt32]
}
struct PCLUSAPI_RESTART_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, UInt32, UInt32]
}
struct PCLUSAPI_RESTART_CLUSTER_RESOURCE_EX extends FunctionPointer {
    static Types := [HRESOURCE, UInt32, UInt32]
}
struct PCLUSAPI_CLOSE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, BOOL]
}
struct PCLUSAPI_GET_CLUSTER_FROM_GROUP extends FunctionPointer {
    static Types := [HGROUP, HCLUSTER]
}
struct PCLUSAPI_GET_CLUSTER_GROUP_STATE extends FunctionPointer {
    static Types := [HGROUP, PWSTR, UInt32.Ptr, CLUSTER_GROUP_STATE]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_NAME extends FunctionPointer {
    static Types := [HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST extends FunctionPointer {
    static Types := [HGROUP, UInt32, HNODE.Ptr, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_NAME_EX extends FunctionPointer {
    static Types := [HGROUP, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_GROUP_NODE_LIST_EX extends FunctionPointer {
    static Types := [HGROUP, UInt32, HNODE.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_ONLINE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, HNODE, UInt32]
}
struct PCLUSAPI_MOVE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, HNODE, UInt32]
}
struct PCLUSAPI_OFFLINE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, UInt32]
}
struct PCLUSAPI_DESTROY_CLUSTER_GROUP extends FunctionPointer {
    static Types := [HGROUP, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_GROUP_EX extends FunctionPointer {
    static Types := [HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_DESTROY_CLUSTER_GROUP_EX extends FunctionPointer {
    static Types := [HGROUP, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_OPEN_ENUM extends FunctionPointer {
    static Types := [HGROUP, UInt32, HGROUPENUM]
}
struct PCLUSAPI_CLUSTER_GROUP_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HGROUPENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_ENUM extends FunctionPointer {
    static Types := [HGROUPENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_CLOSE_ENUM extends FunctionPointer {
    static Types := [HGROUPENUM, UInt32]
}
struct CLUSTER_RESOURCE_STATE extends Int32 {
    static ClusterResourceStateUnknown := -1
    static ClusterResourceInherited := 0
    static ClusterResourceInitializing := 1
    static ClusterResourceOnline := 2
    static ClusterResourceOffline := 3
    static ClusterResourceFailed := 4
    static ClusterResourcePending := 128
    static ClusterResourceOnlinePending := 129
    static ClusterResourceOfflinePending := 130
}
struct CLUSTER_RESOURCE_RESTART_ACTION extends Int32 {
    static ClusterResourceDontRestart := 0
    static ClusterResourceRestartNoNotify := 1
    static ClusterResourceRestartNotify := 2
    static ClusterResourceRestartActionCount := 3
}
struct CLUSTER_RESOURCE_EMBEDDED_FAILURE_ACTION extends Int32 {
    static ClusterResourceEmbeddedFailureActionNone := 0
    static ClusterResourceEmbeddedFailureActionLogOnly := 1
    static ClusterResourceEmbeddedFailureActionRecover := 2
}
struct CLUSTER_RESOURCE_CREATE_FLAGS extends Int32 {
    static CLUSTER_RESOURCE_DEFAULT_MONITOR := 0
    static CLUSTER_RESOURCE_SEPARATE_MONITOR := 1
    static CLUSTER_RESOURCE_VALID_FLAGS := 1
}
struct CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE extends Int32 {
    static ClusterSharedVolumeSnapshotStateUnknown := 0
    static ClusterSharedVolumePrepareForHWSnapshot := 1
    static ClusterSharedVolumeHWSnapshotCompleted := 2
    static ClusterSharedVolumePrepareForFreeze := 3
}
struct PCLUSAPI_CREATE_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HGROUP, PWSTR, PWSTR, UInt32, HRESOURCE]
}
struct PCLUSAPI_CREATE_CLUSTER_RESOURCE_EX extends FunctionPointer {
    static Types := [HGROUP, PWSTR, PWSTR, UInt32, PWSTR, HRESOURCE]
}
struct PCLUSAPI_OPEN_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HRESOURCE]
}
struct PCLUSAPI_OPEN_CLUSTER_RESOURCE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32.Ptr, HRESOURCE]
}
struct PCLUSAPI_CLOSE_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, BOOL]
}
struct PCLUSAPI_GET_CLUSTER_FROM_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, HCLUSTER]
}
struct PCLUSAPI_DELETE_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_RESOURCE_EX extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_RESOURCE_STATE extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, CLUSTER_RESOURCE_STATE]
}
struct PCLUSAPI_SET_CLUSTER_RESOURCE_NAME extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_RESOURCE_NAME_EX extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_FAIL_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_FAIL_CLUSTER_RESOURCE_EX extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_ONLINE_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_OFFLINE_CLUSTER_RESOURCE extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP extends FunctionPointer {
    static Types := [HRESOURCE, HGROUP, UInt32]
}
struct PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX extends FunctionPointer {
    static Types := [HRESOURCE, HGROUP, Int64, UInt32]
}
struct PCLUSAPI_CHANGE_CLUSTER_RESOURCE_GROUP_EX2 extends FunctionPointer {
    static Types := [HRESOURCE, HGROUP, Int64, PWSTR, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_RESOURCE_NODE_EX extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_RESOURCE_NODE_EX extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, PWSTR, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_RESOURCE_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_RESOURCE_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_RESOURCE_DEPENDENCY_EXPRESSION extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_ADD_RESOURCE_TO_CLUSTER_SHARED_VOLUMES extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_REMOVE_RESOURCE_FROM_CLUSTER_SHARED_VOLUMES extends FunctionPointer {
    static Types := [HRESOURCE, UInt32]
}
struct PCLUSAPI_IS_FILE_ON_CLUSTER_SHARED_VOLUME extends FunctionPointer {
    static Types := [PWSTR, BOOL.Ptr, UInt32]
}
struct PCLUSAPI_SHARED_VOLUME_SET_SNAPSHOT_STATE extends FunctionPointer {
    static Types := [GUID, PWSTR, CLUSTER_SHARED_VOLUME_SNAPSHOT_STATE, UInt32]
}
struct PCLUSAPI_CAN_RESOURCE_BE_DEPENDENT extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, BOOL]
}
struct PCLUSAPI_CLUSTER_RESOURCE_CONTROL extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_CONTROL extends FunctionPointer {
    static Types := [HGROUP, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_CONTROL_EX extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_CONTROL_AS_USER_EX extends FunctionPointer {
    static Types := [HRESOURCE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_CONTROL_AS_USER_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_GROUP_CONTROL_EX extends FunctionPointer {
    static Types := [HGROUP, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_CONTROL extends FunctionPointer {
    static Types := [HNODE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NODE_CONTROL_EX extends FunctionPointer {
    static Types := [HNODE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_RESOURCE_NETWORK_NAME extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32.Ptr, BOOL]
}
struct CLUSTER_PROPERTY_TYPE extends Int32 {
    static CLUSPROP_TYPE_UNKNOWN := -1
    static CLUSPROP_TYPE_ENDMARK := 0
    static CLUSPROP_TYPE_LIST_VALUE := 1
    static CLUSPROP_TYPE_RESCLASS := 2
    static CLUSPROP_TYPE_RESERVED1 := 3
    static CLUSPROP_TYPE_NAME := 4
    static CLUSPROP_TYPE_SIGNATURE := 5
    static CLUSPROP_TYPE_SCSI_ADDRESS := 6
    static CLUSPROP_TYPE_DISK_NUMBER := 7
    static CLUSPROP_TYPE_PARTITION_INFO := 8
    static CLUSPROP_TYPE_FTSET_INFO := 9
    static CLUSPROP_TYPE_DISK_SERIALNUMBER := 10
    static CLUSPROP_TYPE_DISK_GUID := 11
    static CLUSPROP_TYPE_DISK_SIZE := 12
    static CLUSPROP_TYPE_PARTITION_INFO_EX := 13
    static CLUSPROP_TYPE_PARTITION_INFO_EX2 := 14
    static CLUSPROP_TYPE_STORAGE_DEVICE_ID_DESCRIPTOR := 15
    static CLUSPROP_TYPE_USER := 32768
}
struct CLUSTER_PROPERTY_FORMAT extends Int32 {
    static CLUSPROP_FORMAT_UNKNOWN := 0
    static CLUSPROP_FORMAT_BINARY := 1
    static CLUSPROP_FORMAT_DWORD := 2
    static CLUSPROP_FORMAT_SZ := 3
    static CLUSPROP_FORMAT_EXPAND_SZ := 4
    static CLUSPROP_FORMAT_MULTI_SZ := 5
    static CLUSPROP_FORMAT_ULARGE_INTEGER := 6
    static CLUSPROP_FORMAT_LONG := 7
    static CLUSPROP_FORMAT_EXPANDED_SZ := 8
    static CLUSPROP_FORMAT_SECURITY_DESCRIPTOR := 9
    static CLUSPROP_FORMAT_LARGE_INTEGER := 10
    static CLUSPROP_FORMAT_WORD := 11
    static CLUSPROP_FORMAT_FILETIME := 12
    static CLUSPROP_FORMAT_VALUE_LIST := 13
    static CLUSPROP_FORMAT_PROPERTY_LIST := 14
    static CLUSPROP_FORMAT_USER := 32768
}
struct CLUSTER_PROPERTY_SYNTAX extends UInt32 {
    static CLUSPROP_SYNTAX_ENDMARK := 0
    static CLUSPROP_SYNTAX_NAME := 262147
    static CLUSPROP_SYNTAX_RESCLASS := 131074
    static CLUSPROP_SYNTAX_LIST_VALUE_SZ := 65539
    static CLUSPROP_SYNTAX_LIST_VALUE_EXPAND_SZ := 65540
    static CLUSPROP_SYNTAX_LIST_VALUE_DWORD := 65538
    static CLUSPROP_SYNTAX_LIST_VALUE_BINARY := 65537
    static CLUSPROP_SYNTAX_LIST_VALUE_MULTI_SZ := 65541
    static CLUSPROP_SYNTAX_LIST_VALUE_LONG := 65543
    static CLUSPROP_SYNTAX_LIST_VALUE_EXPANDED_SZ := 65544
    static CLUSPROP_SYNTAX_LIST_VALUE_SECURITY_DESCRIPTOR := 65545
    static CLUSPROP_SYNTAX_LIST_VALUE_LARGE_INTEGER := 65546
    static CLUSPROP_SYNTAX_LIST_VALUE_ULARGE_INTEGER := 65542
    static CLUSPROP_SYNTAX_LIST_VALUE_WORD := 65547
    static CLUSPROP_SYNTAX_LIST_VALUE_PROPERTY_LIST := 65550
    static CLUSPROP_SYNTAX_LIST_VALUE_FILETIME := 65548
    static CLUSPROP_SYNTAX_DISK_SIGNATURE := 327682
    static CLUSPROP_SYNTAX_SCSI_ADDRESS := 393218
    static CLUSPROP_SYNTAX_DISK_NUMBER := 458754
    static CLUSPROP_SYNTAX_PARTITION_INFO := 524289
    static CLUSPROP_SYNTAX_FTSET_INFO := 589825
    static CLUSPROP_SYNTAX_DISK_SERIALNUMBER := 655363
    static CLUSPROP_SYNTAX_DISK_GUID := 720899
    static CLUSPROP_SYNTAX_DISK_SIZE := 786438
    static CLUSPROP_SYNTAX_PARTITION_INFO_EX := 851969
    static CLUSPROP_SYNTAX_PARTITION_INFO_EX2 := 917505
    static CLUSPROP_SYNTAX_STORAGE_DEVICE_ID_DESCRIPTOR := 983041
}
struct GROUP_FAILURE_INFO {
    dwFailoverAttemptsRemaining : UInt32
    dwFailoverPeriodRemaining : UInt32
}
struct GROUP_FAILURE_INFO_BUFFER {
    dwVersion : UInt32
    Info : GROUP_FAILURE_INFO
}
struct RESOURCE_FAILURE_INFO {
    dwRestartAttemptsRemaining : UInt32
    dwRestartPeriodRemaining : UInt32
}
struct RESOURCE_FAILURE_INFO_BUFFER {
    dwVersion : UInt32
    Info : RESOURCE_FAILURE_INFO
}
struct RESOURCE_TERMINAL_FAILURE_INFO_BUFFER {
    isTerminalFailure : BOOL
    restartPeriodRemaining : UInt32
}
struct CLUSTER_CONTROL_OBJECT extends Int32 {
    static CLUS_OBJECT_INVALID := 0
    static CLUS_OBJECT_RESOURCE := 1
    static CLUS_OBJECT_RESOURCE_TYPE := 2
    static CLUS_OBJECT_GROUP := 3
    static CLUS_OBJECT_NODE := 4
    static CLUS_OBJECT_NETWORK := 5
    static CLUS_OBJECT_NETINTERFACE := 6
    static CLUS_OBJECT_CLUSTER := 7
    static CLUS_OBJECT_GROUPSET := 8
    static CLUS_OBJECT_AFFINITYRULE := 9
    static CLUS_OBJECT_USER := 128
}
struct CLCTL_CODES extends Int32 {
    static CLCTL_UNKNOWN := 0
    static CLCTL_GET_CHARACTERISTICS := 5
    static CLCTL_GET_FLAGS := 9
    static CLCTL_GET_CLASS_INFO := 13
    static CLCTL_GET_REQUIRED_DEPENDENCIES := 17
    static CLCTL_GET_ARB_TIMEOUT := 21
    static CLCTL_GET_FAILURE_INFO := 25
    static CLCTL_GET_NAME := 41
    static CLCTL_GET_RESOURCE_TYPE := 45
    static CLCTL_GET_NODE := 49
    static CLCTL_GET_NETWORK := 53
    static CLCTL_GET_ID := 57
    static CLCTL_GET_FQDN := 61
    static CLCTL_GET_CLUSTER_SERVICE_ACCOUNT_NAME := 65
    static CLCTL_CHECK_VOTER_EVICT := 69
    static CLCTL_CHECK_VOTER_DOWN := 73
    static CLCTL_SHUTDOWN := 77
    static CLCTL_ENUM_COMMON_PROPERTIES := 81
    static CLCTL_GET_RO_COMMON_PROPERTIES := 85
    static CLCTL_GET_COMMON_PROPERTIES := 89
    static CLCTL_SET_COMMON_PROPERTIES := 4194398
    static CLCTL_VALIDATE_COMMON_PROPERTIES := 97
    static CLCTL_GET_COMMON_PROPERTY_FMTS := 101
    static CLCTL_GET_COMMON_RESOURCE_PROPERTY_FMTS := 105
    static CLCTL_CHECK_VOTER_EVICT_WITNESS := 109
    static CLCTL_CHECK_VOTER_DOWN_WITNESS := 113
    static CLCTL_ENUM_PRIVATE_PROPERTIES := 121
    static CLCTL_GET_RO_PRIVATE_PROPERTIES := 125
    static CLCTL_GET_PRIVATE_PROPERTIES := 129
    static CLCTL_SET_PRIVATE_PROPERTIES := 4194438
    static CLCTL_VALIDATE_PRIVATE_PROPERTIES := 137
    static CLCTL_GET_PRIVATE_PROPERTY_FMTS := 141
    static CLCTL_GET_PRIVATE_RESOURCE_PROPERTY_FMTS := 145
    static CLCTL_ADD_REGISTRY_CHECKPOINT := 4194466
    static CLCTL_DELETE_REGISTRY_CHECKPOINT := 4194470
    static CLCTL_GET_REGISTRY_CHECKPOINTS := 169
    static CLCTL_ADD_CRYPTO_CHECKPOINT := 4194478
    static CLCTL_DELETE_CRYPTO_CHECKPOINT := 4194482
    static CLCTL_GET_CRYPTO_CHECKPOINTS := 181
    static CLCTL_RESOURCE_UPGRADE_DLL := 4194490
    static CLCTL_ADD_REGISTRY_CHECKPOINT_64BIT := 4194494
    static CLCTL_ADD_REGISTRY_CHECKPOINT_32BIT := 4194498
    static CLCTL_GET_LOADBAL_PROCESS_LIST := 201
    static CLCTL_SET_ACCOUNT_ACCESS := 4194546
    static CLCTL_GET_NETWORK_NAME := 361
    static CLCTL_NETNAME_GET_VIRTUAL_SERVER_TOKEN := 365
    static CLCTL_NETNAME_REGISTER_DNS_RECORDS := 370
    static CLCTL_GET_DNS_NAME := 373
    static CLCTL_NETNAME_SET_PWD_INFO := 378
    static CLCTL_NETNAME_DELETE_CO := 382
    static CLCTL_NETNAME_VALIDATE_VCO := 385
    static CLCTL_NETNAME_RESET_VCO := 389
    static CLCTL_NETNAME_REPAIR_VCO := 397
    static CLCTL_STORAGE_GET_DISK_INFO := 401
    static CLCTL_STORAGE_GET_AVAILABLE_DISKS := 405
    static CLCTL_STORAGE_IS_PATH_VALID := 409
    static CLCTL_STORAGE_SYNC_CLUSDISK_DB := 4194718
    static CLCTL_STORAGE_GET_DISK_NUMBER_INFO := 417
    static CLCTL_QUERY_DELETE := 441
    static CLCTL_IPADDRESS_RENEW_LEASE := 4194750
    static CLCTL_IPADDRESS_RELEASE_LEASE := 4194754
    static CLCTL_QUERY_MAINTENANCE_MODE := 481
    static CLCTL_SET_MAINTENANCE_MODE := 4194790
    static CLCTL_STORAGE_SET_DRIVELETTER := 4194794
    static CLCTL_STORAGE_GET_DRIVELETTERS := 493
    static CLCTL_STORAGE_GET_DISK_INFO_EX := 497
    static CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX := 501
    static CLCTL_STORAGE_GET_DISK_INFO_EX2 := 505
    static CLCTL_STORAGE_GET_CLUSPORT_DISK_COUNT := 509
    static CLCTL_STORAGE_REMAP_DRIVELETTER := 513
    static CLCTL_STORAGE_GET_DISKID := 517
    static CLCTL_STORAGE_IS_CLUSTERABLE := 521
    static CLCTL_STORAGE_REMOVE_VM_OWNERSHIP := 4194830
    static CLCTL_STORAGE_GET_MOUNTPOINTS := 529
    static CLCTL_STORAGE_GET_DIRTY := 537
    static CLCTL_STORAGE_GET_SHARED_VOLUME_INFO := 549
    static CLCTL_STORAGE_IS_CSV_FILE := 553
    static CLCTL_STORAGE_GET_RESOURCEID := 557
    static CLCTL_VALIDATE_PATH := 561
    static CLCTL_VALIDATE_NETNAME := 565
    static CLCTL_VALIDATE_DIRECTORY := 569
    static CLCTL_BATCH_BLOCK_KEY := 574
    static CLCTL_BATCH_UNBLOCK_KEY := 577
    static CLCTL_FILESERVER_SHARE_ADD := 4194886
    static CLCTL_FILESERVER_SHARE_DEL := 4194890
    static CLCTL_FILESERVER_SHARE_MODIFY := 4194894
    static CLCTL_FILESERVER_SHARE_REPORT := 593
    static CLCTL_NETNAME_GET_OU_FOR_VCO := 4194926
    static CLCTL_ENABLE_SHARED_VOLUME_DIRECTIO := 4194954
    static CLCTL_DISABLE_SHARED_VOLUME_DIRECTIO := 4194958
    static CLCTL_GET_SHARED_VOLUME_ID := 657
    static CLCTL_SET_CSV_MAINTENANCE_MODE := 4194966
    static CLCTL_SET_SHARED_VOLUME_BACKUP_MODE := 4194970
    static CLCTL_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES := 669
    static CLCTL_STORAGE_GET_SHARED_VOLUME_STATES := 4194978
    static CLCTL_STORAGE_IS_SHARED_VOLUME := 677
    static CLCTL_GET_CLUSDB_TIMESTAMP := 681
    static CLCTL_RW_MODIFY_NOOP := 4194990
    static CLCTL_IS_QUORUM_BLOCKED := 689
    static CLCTL_POOL_GET_DRIVE_INFO := 693
    static CLCTL_GET_GUM_LOCK_OWNER := 697
    static CLCTL_GET_STUCK_NODES := 701
    static CLCTL_INJECT_GEM_FAULT := 705
    static CLCTL_INTRODUCE_GEM_REPAIR_DELAY := 709
    static CLCTL_SEND_DUMMY_GEM_MESSAGES := 713
    static CLCTL_BLOCK_GEM_SEND_RECV := 717
    static CLCTL_GET_GEMID_VECTOR := 721
    static CLCTL_ADD_CRYPTO_CHECKPOINT_EX := 4195030
    static CLCTL_GROUP_GET_LAST_MOVE_TIME := 729
    static CLCTL_SET_STORAGE_CONFIGURATION := 4195042
    static CLCTL_GET_STORAGE_CONFIGURATION := 741
    static CLCTL_GET_STORAGE_CONFIG_ATTRIBUTES := 745
    static CLCTL_REMOVE_NODE := 4195054
    static CLCTL_IS_FEATURE_INSTALLED := 753
    static CLCTL_IS_S2D_FEATURE_SUPPORTED := 757
    static CLCTL_STORAGE_GET_PHYSICAL_DISK_INFO := 761
    static CLCTL_STORAGE_GET_CLUSBFLT_PATHS := 765
    static CLCTL_STORAGE_GET_CLUSBFLT_PATHINFO := 769
    static CLCTL_CLEAR_NODE_CONNECTION_INFO := 4195078
    static CLCTL_SET_DNS_DOMAIN := 4195082
    static CTCTL_GET_ROUTESTATUS_BASIC := 781
    static CTCTL_GET_ROUTESTATUS_EXTENDED := 785
    static CTCTL_GET_FAULT_DOMAIN_STATE := 789
    static CLCTL_NETNAME_SET_PWD_INFOEX := 794
    static CLCTL_GET_NODE_NETWORK_CONNECTIVITY := 797
    static CLCTL_RLUA_GET_PWD := 802
    static CLCTL_STORAGE_GET_AVAILABLE_DISKS_EX2_INT := 8161
    static CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS := 8417
    static CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN := 4202726
    static CLCTL_RESOURCE_PREPARE_UPGRADE := 4202730
    static CLCTL_RESOURCE_UPGRADE_COMPLETED := 4202734
    static CLCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY := 8433
    static CLCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY := 4202742
    static CLCTL_REPLICATION_ADD_REPLICATION_GROUP := 8514
    static CLCTL_REPLICATION_GET_LOG_INFO := 8517
    static CLCTL_REPLICATION_GET_ELIGIBLE_LOGDISKS := 8521
    static CLCTL_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS := 8525
    static CLCTL_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS := 8529
    static CLCTL_REPLICATION_GET_REPLICATED_DISKS := 8533
    static CLCTL_REPLICATION_GET_REPLICA_VOLUMES := 8537
    static CLCTL_REPLICATION_GET_LOG_VOLUME := 8541
    static CLCTL_REPLICATION_GET_RESOURCE_GROUP := 8545
    static CLCTL_REPLICATION_GET_REPLICATED_PARTITION_INFO := 8549
    static CLCTL_GET_STATE_CHANGE_TIME := 11613
    static CLCTL_SET_CLUSTER_S2D_ENABLED := 4205922
    static CLCTL_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES := 4205934
    static CLCTL_GROUPSET_GET_GROUPS := 11633
    static CLCTL_GROUPSET_GET_PROVIDER_GROUPS := 11637
    static CLCTL_GROUPSET_GET_PROVIDER_GROUPSETS := 11641
    static CLCTL_GROUP_GET_PROVIDER_GROUPS := 11645
    static CLCTL_GROUP_GET_PROVIDER_GROUPSETS := 11649
    static CLCTL_GROUP_SET_CCF_FROM_MASTER := 4205958
    static CLCTL_GET_INFRASTRUCTURE_SOFS_BUFFER := 11657
    static CLCTL_SET_INFRASTRUCTURE_SOFS_BUFFER := 4205966
    static CLCTL_NOTIFY_INFRASTRUCTURE_SOFS_CHANGED := 4205970
    static CLCTL_SCALEOUT_COMMAND := 4205974
    static CLCTL_SCALEOUT_CONTROL := 4205978
    static CLCTL_SCALEOUT_GET_CLUSTERS := 4205981
    static CLCTL_RELOAD_AUTOLOGGER_CONFIG := 11730
    static CLCTL_STORAGE_RENAME_SHARED_VOLUME := 11734
    static CLCTL_STORAGE_RENAME_SHARED_VOLUME_GUID := 11738
    static CLCTL_ENUM_AFFINITY_RULE_NAMES := 11741
    static CLCTL_GET_NODES_IN_FD := 11745
    static CLCTL_FORCE_DB_FLUSH := 4206054
    static CLCTL_DELETE := 5242886
    static CLCTL_INSTALL_NODE := 5242890
    static CLCTL_EVICT_NODE := 5242894
    static CLCTL_ADD_DEPENDENCY := 5242898
    static CLCTL_REMOVE_DEPENDENCY := 5242902
    static CLCTL_ADD_OWNER := 5242906
    static CLCTL_REMOVE_OWNER := 5242910
    static CLCTL_SET_NAME := 5242918
    static CLCTL_CLUSTER_NAME_CHANGED := 5242922
    static CLCTL_CLUSTER_VERSION_CHANGED := 5242926
    static CLCTL_FIXUP_ON_UPGRADE := 5242930
    static CLCTL_STARTING_PHASE1 := 5242934
    static CLCTL_STARTING_PHASE2 := 5242938
    static CLCTL_HOLD_IO := 5242942
    static CLCTL_RESUME_IO := 5242946
    static CLCTL_FORCE_QUORUM := 5242950
    static CLCTL_INITIALIZE := 5242954
    static CLCTL_STATE_CHANGE_REASON := 5242958
    static CLCTL_PROVIDER_STATE_CHANGE := 5242962
    static CLCTL_LEAVING_GROUP := 5242966
    static CLCTL_JOINING_GROUP := 5242970
    static CLCTL_FSWITNESS_GET_EPOCH_INFO := 1048669
    static CLCTL_FSWITNESS_SET_EPOCH_INFO := 5242978
    static CLCTL_FSWITNESS_RELEASE_LOCK := 5242982
    static CLCTL_NETNAME_CREDS_NOTIFYCAM := 5242986
    static CLCTL_NOTIFY_QUORUM_STATUS := 5243006
    static CLCTL_NOTIFY_MONITOR_SHUTTING_DOWN := 1048705
    static CLCTL_UNDELETE := 5243014
    static CLCTL_GET_OPERATION_CONTEXT := 1057001
    static CLCTL_NOTIFY_OWNER_CHANGE := 5251362
    static CLCTL_VALIDATE_CHANGE_GROUP := 1057061
    static CLCTL_CHECK_DRAIN_VETO := 1057069
    static CLCTL_NOTIFY_DRAIN_COMPLETE := 1057073
}
struct CLUSCTL_RESOURCE_CODES extends Int32 {
    static CLUSCTL_RESOURCE_UNKNOWN := 16777216
    static CLUSCTL_RESOURCE_GET_CHARACTERISTICS := 16777221
    static CLUSCTL_RESOURCE_GET_FLAGS := 16777225
    static CLUSCTL_RESOURCE_GET_CLASS_INFO := 16777229
    static CLUSCTL_RESOURCE_GET_REQUIRED_DEPENDENCIES := 16777233
    static CLUSCTL_RESOURCE_GET_NAME := 16777257
    static CLUSCTL_RESOURCE_GET_ID := 16777273
    static CLUSCTL_RESOURCE_GET_RESOURCE_TYPE := 16777261
    static CLUSCTL_RESOURCE_ENUM_COMMON_PROPERTIES := 16777297
    static CLUSCTL_RESOURCE_GET_RO_COMMON_PROPERTIES := 16777301
    static CLUSCTL_RESOURCE_GET_COMMON_PROPERTIES := 16777305
    static CLUSCTL_RESOURCE_SET_COMMON_PROPERTIES := 20971614
    static CLUSCTL_RESOURCE_VALIDATE_COMMON_PROPERTIES := 16777313
    static CLUSCTL_RESOURCE_GET_COMMON_PROPERTY_FMTS := 16777317
    static CLUSCTL_RESOURCE_ENUM_PRIVATE_PROPERTIES := 16777337
    static CLUSCTL_RESOURCE_GET_RO_PRIVATE_PROPERTIES := 16777341
    static CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTIES := 16777345
    static CLUSCTL_RESOURCE_SET_PRIVATE_PROPERTIES := 20971654
    static CLUSCTL_RESOURCE_VALIDATE_PRIVATE_PROPERTIES := 16777353
    static CLUSCTL_RESOURCE_GET_PRIVATE_PROPERTY_FMTS := 16777357
    static CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT := 20971682
    static CLUSCTL_RESOURCE_DELETE_REGISTRY_CHECKPOINT := 20971686
    static CLUSCTL_RESOURCE_GET_REGISTRY_CHECKPOINTS := 16777385
    static CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT := 20971694
    static CLUSCTL_RESOURCE_DELETE_CRYPTO_CHECKPOINT := 20971698
    static CLUSCTL_RESOURCE_ADD_CRYPTO_CHECKPOINT_EX := 20972246
    static CLUSCTL_RESOURCE_GET_CRYPTO_CHECKPOINTS := 16777397
    static CLUSCTL_RESOURCE_GET_LOADBAL_PROCESS_LIST := 16777417
    static CLUSCTL_RESOURCE_GET_NETWORK_NAME := 16777577
    static CLUSCTL_RESOURCE_NETNAME_GET_VIRTUAL_SERVER_TOKEN := 16777581
    static CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFO := 16777594
    static CLUSCTL_RESOURCE_NETNAME_SET_PWD_INFOEX := 16778010
    static CLUSCTL_RESOURCE_NETNAME_DELETE_CO := 16777598
    static CLUSCTL_RESOURCE_NETNAME_VALIDATE_VCO := 16777601
    static CLUSCTL_RESOURCE_NETNAME_RESET_VCO := 16777605
    static CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO := 16777613
    static CLUSCTL_RESOURCE_NETNAME_REGISTER_DNS_RECORDS := 16777586
    static CLUSCTL_RESOURCE_GET_DNS_NAME := 16777589
    static CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO := 16777617
    static CLUSCTL_RESOURCE_STORAGE_GET_DISK_NUMBER_INFO := 16777633
    static CLUSCTL_RESOURCE_STORAGE_IS_PATH_VALID := 16777625
    static CLUSCTL_RESOURCE_QUERY_DELETE := 16777657
    static CLUSCTL_RESOURCE_UPGRADE_DLL := 20971706
    static CLUSCTL_RESOURCE_IPADDRESS_RENEW_LEASE := 20971966
    static CLUSCTL_RESOURCE_IPADDRESS_RELEASE_LEASE := 20971970
    static CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_64BIT := 20971710
    static CLUSCTL_RESOURCE_ADD_REGISTRY_CHECKPOINT_32BIT := 20971714
    static CLUSCTL_RESOURCE_QUERY_MAINTENANCE_MODE := 16777697
    static CLUSCTL_RESOURCE_SET_MAINTENANCE_MODE := 20972006
    static CLUSCTL_RESOURCE_STORAGE_SET_DRIVELETTER := 20972010
    static CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX := 16777713
    static CLUSCTL_RESOURCE_STORAGE_GET_DISK_INFO_EX2 := 16777721
    static CLUSCTL_RESOURCE_STORAGE_GET_MOUNTPOINTS := 16777745
    static CLUSCTL_RESOURCE_STORAGE_GET_DIRTY := 16777753
    static CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_INFO := 16777765
    static CLUSCTL_RESOURCE_SET_CSV_MAINTENANCE_MODE := 20972182
    static CLUSCTL_RESOURCE_ENABLE_SHARED_VOLUME_DIRECTIO := 20972170
    static CLUSCTL_RESOURCE_DISABLE_SHARED_VOLUME_DIRECTIO := 20972174
    static CLUSCTL_RESOURCE_SET_SHARED_VOLUME_BACKUP_MODE := 20972186
    static CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_PARTITION_NAMES := 16777885
    static CLUSCTL_RESOURCE_GET_FAILURE_INFO := 16777241
    static CLUSCTL_RESOURCE_STORAGE_GET_DISKID := 16777733
    static CLUSCTL_RESOURCE_STORAGE_GET_SHARED_VOLUME_STATES := 20972194
    static CLUSCTL_RESOURCE_STORAGE_IS_SHARED_VOLUME := 16777893
    static CLUSCTL_RESOURCE_IS_QUORUM_BLOCKED := 16777905
    static CLUSCTL_RESOURCE_POOL_GET_DRIVE_INFO := 16777909
    static CLUSCTL_RESOURCE_RLUA_GET_VIRTUAL_SERVER_TOKEN := 16777581
    static CLUSCTL_RESOURCE_RLUA_SET_PWD_INFO := 16777594
    static CLUSCTL_RESOURCE_RLUA_SET_PWD_INFOEX := 16778010
    static CLUSCTL_RESOURCE_RLUA_GET_PWD := 16778018
    static CLUSCTL_RESOURCE_DELETE := 22020102
    static CLUSCTL_RESOURCE_UNDELETE := 22020230
    static CLUSCTL_RESOURCE_INSTALL_NODE := 22020106
    static CLUSCTL_RESOURCE_EVICT_NODE := 22020110
    static CLUSCTL_RESOURCE_ADD_DEPENDENCY := 22020114
    static CLUSCTL_RESOURCE_REMOVE_DEPENDENCY := 22020118
    static CLUSCTL_RESOURCE_ADD_OWNER := 22020122
    static CLUSCTL_RESOURCE_REMOVE_OWNER := 22020126
    static CLUSCTL_RESOURCE_SET_NAME := 22020134
    static CLUSCTL_RESOURCE_CLUSTER_NAME_CHANGED := 22020138
    static CLUSCTL_RESOURCE_CLUSTER_VERSION_CHANGED := 22020142
    static CLUSCTL_RESOURCE_FORCE_QUORUM := 22020166
    static CLUSCTL_RESOURCE_INITIALIZE := 22020170
    static CLUSCTL_RESOURCE_STATE_CHANGE_REASON := 22020174
    static CLUSCTL_RESOURCE_PROVIDER_STATE_CHANGE := 22020178
    static CLUSCTL_RESOURCE_LEAVING_GROUP := 22020182
    static CLUSCTL_RESOURCE_JOINING_GROUP := 22020186
    static CLUSCTL_RESOURCE_FSWITNESS_GET_EPOCH_INFO := 17825885
    static CLUSCTL_RESOURCE_FSWITNESS_SET_EPOCH_INFO := 22020194
    static CLUSCTL_RESOURCE_FSWITNESS_RELEASE_LOCK := 22020198
    static CLUSCTL_RESOURCE_NETNAME_CREDS_NOTIFYCAM := 22020202
    static CLUSCTL_RESOURCE_GET_OPERATION_CONTEXT := 17834217
    static CLUSCTL_RESOURCE_RW_MODIFY_NOOP := 20972206
    static CLUSCTL_RESOURCE_NOTIFY_QUORUM_STATUS := 22020222
    static CLUSCTL_RESOURCE_NOTIFY_OWNER_CHANGE := 22028578
    static CLUSCTL_RESOURCE_VALIDATE_CHANGE_GROUP := 17834277
    static CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME := 16788950
    static CLUSCTL_RESOURCE_STORAGE_RENAME_SHARED_VOLUME_GUID := 16788954
    static CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_TOKEN := 20979942
    static CLUSCTL_CLOUD_WITNESS_RESOURCE_UPDATE_KEY := 20979958
    static CLUSCTL_RESOURCE_PREPARE_UPGRADE := 20979946
    static CLUSCTL_RESOURCE_UPGRADE_COMPLETED := 20979950
    static CLUSCTL_RESOURCE_GET_STATE_CHANGE_TIME := 16788829
    static CLUSCTL_RESOURCE_GET_INFRASTRUCTURE_SOFS_BUFFER := 16788873
    static CLUSCTL_RESOURCE_SET_INFRASTRUCTURE_SOFS_BUFFER := 20983182
    static CLUSCTL_RESOURCE_SCALEOUT_COMMAND := 20983190
    static CLUSCTL_RESOURCE_SCALEOUT_CONTROL := 20983194
    static CLUSCTL_RESOURCE_SCALEOUT_GET_CLUSTERS := 20983197
    static CLUSCTL_RESOURCE_CHECK_DRAIN_VETO := 17834285
    static CLUSCTL_RESOURCE_NOTIFY_DRAIN_COMPLETE := 17834289
    static CLUSCTL_RESOURCE_GET_NODES_IN_FD := 16788961
}
struct CLUSCTL_RESOURCE_TYPE_CODES extends Int32 {
    static CLUSCTL_RESOURCE_TYPE_UNKNOWN := 33554432
    static CLUSCTL_RESOURCE_TYPE_GET_CHARACTERISTICS := 33554437
    static CLUSCTL_RESOURCE_TYPE_GET_FLAGS := 33554441
    static CLUSCTL_RESOURCE_TYPE_GET_CLASS_INFO := 33554445
    static CLUSCTL_RESOURCE_TYPE_GET_REQUIRED_DEPENDENCIES := 33554449
    static CLUSCTL_RESOURCE_TYPE_GET_ARB_TIMEOUT := 33554453
    static CLUSCTL_RESOURCE_TYPE_ENUM_COMMON_PROPERTIES := 33554513
    static CLUSCTL_RESOURCE_TYPE_GET_RO_COMMON_PROPERTIES := 33554517
    static CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTIES := 33554521
    static CLUSCTL_RESOURCE_TYPE_VALIDATE_COMMON_PROPERTIES := 33554529
    static CLUSCTL_RESOURCE_TYPE_SET_COMMON_PROPERTIES := 37748830
    static CLUSCTL_RESOURCE_TYPE_GET_COMMON_PROPERTY_FMTS := 33554533
    static CLUSCTL_RESOURCE_TYPE_GET_COMMON_RESOURCE_PROPERTY_FMTS := 33554537
    static CLUSCTL_RESOURCE_TYPE_ENUM_PRIVATE_PROPERTIES := 33554553
    static CLUSCTL_RESOURCE_TYPE_GET_RO_PRIVATE_PROPERTIES := 33554557
    static CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTIES := 33554561
    static CLUSCTL_RESOURCE_TYPE_SET_PRIVATE_PROPERTIES := 37748870
    static CLUSCTL_RESOURCE_TYPE_VALIDATE_PRIVATE_PROPERTIES := 33554569
    static CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_PROPERTY_FMTS := 33554573
    static CLUSCTL_RESOURCE_TYPE_GET_PRIVATE_RESOURCE_PROPERTY_FMTS := 33554577
    static CLUSCTL_RESOURCE_TYPE_GET_REGISTRY_CHECKPOINTS := 33554601
    static CLUSCTL_RESOURCE_TYPE_GET_CRYPTO_CHECKPOINTS := 33554613
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS := 33554837
    static CLUSCTL_RESOURCE_TYPE_STORAGE_SYNC_CLUSDISK_DB := 37749150
    static CLUSCTL_RESOURCE_TYPE_NETNAME_VALIDATE_NETNAME := 33554997
    static CLUSCTL_RESOURCE_TYPE_NETNAME_GET_OU_FOR_VCO := 37749358
    static CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_PATH := 33554993
    static CLUSCTL_RESOURCE_TYPE_GEN_APP_VALIDATE_DIRECTORY := 33555001
    static CLUSCTL_RESOURCE_TYPE_GEN_SCRIPT_VALIDATE_PATH := 33554993
    static CLUSCTL_RESOURCE_TYPE_QUERY_DELETE := 33554873
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DRIVELETTERS := 33554925
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX := 33554933
    static CLUSCTL_RESOURCE_TYPE_STORAGE_REMAP_DRIVELETTER := 33554945
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_DISKID := 33554949
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_RESOURCEID := 33554989
    static CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CLUSTERABLE := 33554953
    static CLUSCTL_RESOURCE_TYPE_STORAGE_REMOVE_VM_OWNERSHIP := 37749262
    static CLUSCTL_RESOURCE_TYPE_STORAGE_IS_CSV_FILE := 16777769
    static CLUSCTL_RESOURCE_TYPE_WITNESS_VALIDATE_PATH := 33554993
    static CLUSCTL_RESOURCE_TYPE_INSTALL_NODE := 38797322
    static CLUSCTL_RESOURCE_TYPE_EVICT_NODE := 38797326
    static CLUSCTL_RESOURCE_TYPE_CLUSTER_VERSION_CHANGED := 38797358
    static CLUSCTL_RESOURCE_TYPE_FIXUP_ON_UPGRADE := 38797362
    static CLUSCTL_RESOURCE_TYPE_STARTING_PHASE1 := 38797366
    static CLUSCTL_RESOURCE_TYPE_STARTING_PHASE2 := 38797370
    static CLUSCTL_RESOURCE_TYPE_HOLD_IO := 38797374
    static CLUSCTL_RESOURCE_TYPE_RESUME_IO := 38797378
    static CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INT := 33562593
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_LOGDISKS := 33562953
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_TARGET_DATADISKS := 33562957
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_ELIGIBLE_SOURCE_DATADISKS := 33562961
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_DISKS := 33562965
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICA_VOLUMES := 33562969
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_VOLUME := 33562973
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_RESOURCE_GROUP := 33562977
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_REPLICATED_PARTITION_INFO := 33562981
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_GET_LOG_INFO := 33562949
    static CLUSCTL_RESOURCE_TYPE_REPLICATION_ADD_REPLICATION_GROUP := 33562946
    static CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS := 33562849
    static CLUSCTL_CLOUD_WITNESS_RESOURCE_TYPE_VALIDATE_CREDENTIALS_WITH_KEY := 33562865
    static CLUSCTL_RESOURCE_TYPE_PREPARE_UPGRADE := 37757162
    static CLUSCTL_RESOURCE_TYPE_UPGRADE_COMPLETED := 37757166
    static CLUSCTL_RESOURCE_TYPE_NOTIFY_MONITOR_SHUTTING_DOWN := 34603137
    static CLUSCTL_RESOURCE_TYPE_CHECK_DRAIN_VETO := 34611501
    static CLUSCTL_RESOURCE_TYPE_NOTIFY_DRAIN_COMPLETE := 34611505
}
struct NodeSriovInfo {
    VFTotal : UInt32
    VFUsed : UInt32
    QPTotal : UInt32
    QPUsed : UInt32
}
struct CLUSCTL_GROUP_CODES extends Int32 {
    static CLUSCTL_GROUP_UNKNOWN := 50331648
    static CLUSCTL_GROUP_GET_CHARACTERISTICS := 50331653
    static CLUSCTL_GROUP_GET_FLAGS := 50331657
    static CLUSCTL_GROUP_GET_NAME := 50331689
    static CLUSCTL_GROUP_GET_ID := 50331705
    static CLUSCTL_GROUP_ENUM_COMMON_PROPERTIES := 50331729
    static CLUSCTL_GROUP_GET_RO_COMMON_PROPERTIES := 50331733
    static CLUSCTL_GROUP_GET_COMMON_PROPERTIES := 50331737
    static CLUSCTL_GROUP_SET_COMMON_PROPERTIES := 54526046
    static CLUSCTL_GROUP_VALIDATE_COMMON_PROPERTIES := 50331745
    static CLUSCTL_GROUP_ENUM_PRIVATE_PROPERTIES := 50331769
    static CLUSCTL_GROUP_GET_RO_PRIVATE_PROPERTIES := 50331773
    static CLUSCTL_GROUP_GET_PRIVATE_PROPERTIES := 50331777
    static CLUSCTL_GROUP_SET_PRIVATE_PROPERTIES := 54526086
    static CLUSCTL_GROUP_VALIDATE_PRIVATE_PROPERTIES := 50331785
    static CLUSCTL_GROUP_QUERY_DELETE := 50332089
    static CLUSCTL_GROUP_GET_COMMON_PROPERTY_FMTS := 50331749
    static CLUSCTL_GROUP_GET_PRIVATE_PROPERTY_FMTS := 50331789
    static CLUSCTL_GROUP_GET_FAILURE_INFO := 50331673
    static CLUSCTL_GROUP_GET_LAST_MOVE_TIME := 50332377
    static CLUSCTL_GROUP_SET_CCF_FROM_MASTER := 54537606
}
struct CLUSCTL_NODE_CODES extends Int32 {
    static CLUSCTL_NODE_UNKNOWN := 67108864
    static CLUSCTL_NODE_GET_CHARACTERISTICS := 67108869
    static CLUSCTL_NODE_GET_FLAGS := 67108873
    static CLUSCTL_NODE_GET_NAME := 67108905
    static CLUSCTL_NODE_GET_ID := 67108921
    static CLUSCTL_NODE_ENUM_COMMON_PROPERTIES := 67108945
    static CLUSCTL_NODE_GET_RO_COMMON_PROPERTIES := 67108949
    static CLUSCTL_NODE_GET_COMMON_PROPERTIES := 67108953
    static CLUSCTL_NODE_SET_COMMON_PROPERTIES := 71303262
    static CLUSCTL_NODE_VALIDATE_COMMON_PROPERTIES := 67108961
    static CLUSCTL_NODE_ENUM_PRIVATE_PROPERTIES := 67108985
    static CLUSCTL_NODE_GET_RO_PRIVATE_PROPERTIES := 67108989
    static CLUSCTL_NODE_GET_PRIVATE_PROPERTIES := 67108993
    static CLUSCTL_NODE_SET_PRIVATE_PROPERTIES := 71303302
    static CLUSCTL_NODE_VALIDATE_PRIVATE_PROPERTIES := 67109001
    static CLUSCTL_NODE_GET_COMMON_PROPERTY_FMTS := 67108965
    static CLUSCTL_NODE_GET_PRIVATE_PROPERTY_FMTS := 67109005
    static CLUSCTL_NODE_GET_CLUSTER_SERVICE_ACCOUNT_NAME := 67108929
    static CLUSCTL_NODE_GET_STUCK_NODES := 67109565
    static CLUSCTL_NODE_INJECT_GEM_FAULT := 67109569
    static CLUSCTL_NODE_INTRODUCE_GEM_REPAIR_DELAY := 67109573
    static CLUSCTL_NODE_SEND_DUMMY_GEM_MESSAGES := 67109577
    static CLUSCTL_NODE_BLOCK_GEM_SEND_RECV := 67109581
    static CLUSCTL_NODE_GET_GEMID_VECTOR := 67109585
}
struct CLUSCTL_NETWORK_CODES extends Int32 {
    static CLUSCTL_NETWORK_UNKNOWN := 83886080
    static CLUSCTL_NETWORK_GET_CHARACTERISTICS := 83886085
    static CLUSCTL_NETWORK_GET_FLAGS := 83886089
    static CLUSCTL_NETWORK_GET_NAME := 83886121
    static CLUSCTL_NETWORK_GET_ID := 83886137
    static CLUSCTL_NETWORK_ENUM_COMMON_PROPERTIES := 83886161
    static CLUSCTL_NETWORK_GET_RO_COMMON_PROPERTIES := 83886165
    static CLUSCTL_NETWORK_GET_COMMON_PROPERTIES := 83886169
    static CLUSCTL_NETWORK_SET_COMMON_PROPERTIES := 88080478
    static CLUSCTL_NETWORK_VALIDATE_COMMON_PROPERTIES := 83886177
    static CLUSCTL_NETWORK_ENUM_PRIVATE_PROPERTIES := 83886201
    static CLUSCTL_NETWORK_GET_RO_PRIVATE_PROPERTIES := 83886205
    static CLUSCTL_NETWORK_GET_PRIVATE_PROPERTIES := 83886209
    static CLUSCTL_NETWORK_SET_PRIVATE_PROPERTIES := 88080518
    static CLUSCTL_NETWORK_VALIDATE_PRIVATE_PROPERTIES := 83886217
    static CLUSCTL_NETWORK_GET_COMMON_PROPERTY_FMTS := 83886181
    static CLUSCTL_NETWORK_GET_PRIVATE_PROPERTY_FMTS := 83886221
}
struct CLUSCTL_NETINTERFACE_CODES extends Int32 {
    static CLUSCTL_NETINTERFACE_UNKNOWN := 100663296
    static CLUSCTL_NETINTERFACE_GET_CHARACTERISTICS := 100663301
    static CLUSCTL_NETINTERFACE_GET_FLAGS := 100663305
    static CLUSCTL_NETINTERFACE_GET_NAME := 100663337
    static CLUSCTL_NETINTERFACE_GET_ID := 100663353
    static CLUSCTL_NETINTERFACE_GET_NODE := 100663345
    static CLUSCTL_NETINTERFACE_GET_NETWORK := 100663349
    static CLUSCTL_NETINTERFACE_ENUM_COMMON_PROPERTIES := 100663377
    static CLUSCTL_NETINTERFACE_GET_RO_COMMON_PROPERTIES := 100663381
    static CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTIES := 100663385
    static CLUSCTL_NETINTERFACE_SET_COMMON_PROPERTIES := 104857694
    static CLUSCTL_NETINTERFACE_VALIDATE_COMMON_PROPERTIES := 100663393
    static CLUSCTL_NETINTERFACE_ENUM_PRIVATE_PROPERTIES := 100663417
    static CLUSCTL_NETINTERFACE_GET_RO_PRIVATE_PROPERTIES := 100663421
    static CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTIES := 100663425
    static CLUSCTL_NETINTERFACE_SET_PRIVATE_PROPERTIES := 104857734
    static CLUSCTL_NETINTERFACE_VALIDATE_PRIVATE_PROPERTIES := 100663433
    static CLUSCTL_NETINTERFACE_GET_COMMON_PROPERTY_FMTS := 100663397
    static CLUSCTL_NETINTERFACE_GET_PRIVATE_PROPERTY_FMTS := 100663437
}
struct CLUSCTL_CLUSTER_CODES extends Int32 {
    static CLUSCTL_CLUSTER_UNKNOWN := 117440512
    static CLUSCTL_CLUSTER_GET_FQDN := 117440573
    static CLUSCTL_CLUSTER_SET_STORAGE_CONFIGURATION := 121635554
    static CLUSCTL_CLUSTER_GET_STORAGE_CONFIGURATION := 117441253
    static CLUSCTL_CLUSTER_GET_STORAGE_CONFIG_ATTRIBUTES := 117441257
    static CLUSCTL_CLUSTER_ENUM_COMMON_PROPERTIES := 117440593
    static CLUSCTL_CLUSTER_GET_RO_COMMON_PROPERTIES := 117440597
    static CLUSCTL_CLUSTER_GET_COMMON_PROPERTIES := 117440601
    static CLUSCTL_CLUSTER_SET_COMMON_PROPERTIES := 121634910
    static CLUSCTL_CLUSTER_VALIDATE_COMMON_PROPERTIES := 117440609
    static CLUSCTL_CLUSTER_ENUM_PRIVATE_PROPERTIES := 117440633
    static CLUSCTL_CLUSTER_GET_RO_PRIVATE_PROPERTIES := 117440637
    static CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTIES := 117440641
    static CLUSCTL_CLUSTER_SET_PRIVATE_PROPERTIES := 121634950
    static CLUSCTL_CLUSTER_VALIDATE_PRIVATE_PROPERTIES := 117440649
    static CLUSCTL_CLUSTER_GET_COMMON_PROPERTY_FMTS := 117440613
    static CLUSCTL_CLUSTER_GET_PRIVATE_PROPERTY_FMTS := 117440653
    static CLUSCTL_CLUSTER_CHECK_VOTER_EVICT := 117440581
    static CLUSCTL_CLUSTER_CHECK_VOTER_DOWN := 117440585
    static CLUSCTL_CLUSTER_SHUTDOWN := 117440589
    static CLUSCTL_CLUSTER_BATCH_BLOCK_KEY := 117441086
    static CLUSCTL_CLUSTER_BATCH_UNBLOCK_KEY := 117441089
    static CLUSCTL_CLUSTER_GET_SHARED_VOLUME_ID := 117441169
    static CLUSCTL_CLUSTER_GET_CLUSDB_TIMESTAMP := 117441193
    static CLUSCTL_CLUSTER_GET_GUM_LOCK_OWNER := 117441209
    static CLUSCTL_CLUSTER_REMOVE_NODE := 121635566
    static CLUSCTL_CLUSTER_SET_ACCOUNT_ACCESS := 121635058
    static CLUSCTL_CLUSTER_CLEAR_NODE_CONNECTION_INFO := 121635590
    static CLUSCTL_CLUSTER_SET_DNS_DOMAIN := 121635594
    static CLUSCTL_CLUSTER_SET_CLUSTER_S2D_ENABLED := 121646434
    static CLUSCTL_CLUSTER_SET_CLUSTER_S2D_CACHE_METADATA_RESERVE_BYTES := 121646446
    static CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME := 117452246
    static CLUSCTL_CLUSTER_STORAGE_RENAME_SHARED_VOLUME_GUID := 117452250
    static CLUSCTL_CLUSTER_RELOAD_AUTOLOGGER_CONFIG := 117452242
    static CLUSCTL_CLUSTER_ENUM_AFFINITY_RULE_NAMES := 117452253
    static CLUSCTL_CLUSTER_GET_NODES_IN_FD := 117452257
    static CLUSCTL_CLUSTER_FORCE_FLUSH_DB := 121646566
    static CLUSCTL_CLUSTER_GET_CLMUSR_TOKEN := 117440877
    static CLUSCTL_CLUSTER_CHECK_VOTER_EVICT_WITNESS := 117440621
    static CLUSCTL_CLUSTER_CHECK_VOTER_DOWN_WITNESS := 117440625
}
struct CLUSCTL_GROUPSET_CODES extends Int32 {
    static CLUSCTL_GROUPSET_GET_COMMON_PROPERTIES := 134217817
    static CLUSCTL_GROUPSET_GET_RO_COMMON_PROPERTIES := 134217813
    static CLUSCTL_GROUPSET_SET_COMMON_PROPERTIES := 138412126
    static CLUSCTL_GROUPSET_GET_GROUPS := 134229361
    static CLUSCTL_GROUPSET_GET_PROVIDER_GROUPS := 134229365
    static CLUSCTL_GROUPSET_GET_PROVIDER_GROUPSETS := 134229369
    static CLUSCTL_GROUP_GET_PROVIDER_GROUPS := 134229373
    static CLUSCTL_GROUP_GET_PROVIDER_GROUPSETS := 134229377
    static CLUSCTL_GROUPSET_GET_ID := 134217785
}
struct CLUSCTL_AFFINITYRULE_CODES extends Int32 {
    static CLUSCTL_AFFINITYRULE_GET_COMMON_PROPERTIES := 150995033
    static CLUSCTL_AFFINITYRULE_GET_RO_COMMON_PROPERTIES := 150995029
    static CLUSCTL_AFFINITYRULE_SET_COMMON_PROPERTIES := 155189342
    static CLUSCTL_AFFINITYRULE_GET_ID := 150995001
    static CLUSCTL_AFFINITYRULE_GET_GROUPNAMES := 151006577
}
struct CLUSTER_RESOURCE_CLASS extends Int32 {
    static CLUS_RESCLASS_UNKNOWN := 0
    static CLUS_RESCLASS_STORAGE := 1
    static CLUS_RESCLASS_NETWORK := 2
    static CLUS_RESCLASS_USER := 32768
}
struct CLUS_RESSUBCLASS extends Int32 {
    static CLUS_RESSUBCLASS_SHARED := -2147483648
}
struct CLUS_RESSUBCLASS_STORAGE extends Int32 {
    static CLUS_RESSUBCLASS_STORAGE_SHARED_BUS := -2147483648
    static CLUS_RESSUBCLASS_STORAGE_DISK := 1073741824
    static CLUS_RESSUBCLASS_STORAGE_REPLICATION := 268435456
}
struct CLUS_RESSUBCLASS_NETWORK extends Int32 {
    static CLUS_RESSUBCLASS_NETWORK_INTERNET_PROTOCOL := -2147483648
}
struct CLUS_CHARACTERISTICS extends Int32 {
    static CLUS_CHAR_UNKNOWN := 0
    static CLUS_CHAR_QUORUM := 1
    static CLUS_CHAR_DELETE_REQUIRES_ALL_NODES := 2
    static CLUS_CHAR_LOCAL_QUORUM := 4
    static CLUS_CHAR_LOCAL_QUORUM_DEBUG := 8
    static CLUS_CHAR_REQUIRES_STATE_CHANGE_REASON := 16
    static CLUS_CHAR_BROADCAST_DELETE := 32
    static CLUS_CHAR_SINGLE_CLUSTER_INSTANCE := 64
    static CLUS_CHAR_SINGLE_GROUP_INSTANCE := 128
    static CLUS_CHAR_COEXIST_IN_SHARED_VOLUME_GROUP := 256
    static CLUS_CHAR_PLACEMENT_DATA := 512
    static CLUS_CHAR_MONITOR_DETACH := 1024
    static CLUS_CHAR_MONITOR_REATTACH := 2048
    static CLUS_CHAR_OPERATION_CONTEXT := 4096
    static CLUS_CHAR_CLONES := 8192
    static CLUS_CHAR_NOT_PREEMPTABLE := 16384
    static CLUS_CHAR_NOTIFY_NEW_OWNER := 32768
    static CLUS_CHAR_SUPPORTS_UNMONITORED_STATE := 65536
    static CLUS_CHAR_INFRASTRUCTURE := 131072
    static CLUS_CHAR_VETO_DRAIN := 262144
    static CLUS_CHAR_DRAIN_LOCAL_OFFLINE := 524288
}
struct CLUS_FLAGS extends Int32 {
    static CLUS_FLAG_CORE := 1
}
struct CLUSPROP_SYNTAX {
    union {
        dw : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        wFormat : UInt16
        wType : UInt16
    }
}
struct CLUSPROP_VALUE {
    Syntax : CLUSPROP_SYNTAX
    cbLength : UInt32
}
struct CLUSPROP_BINARY {
    Base : CLUSPROP_VALUE
    rgb : UInt8[1]
}
struct CLUSPROP_WORD {
    Base : CLUSPROP_VALUE
    w : UInt16
}
struct CLUSPROP_DWORD {
    Base : CLUSPROP_VALUE
    dw : UInt32
}
struct CLUSPROP_LONG {
    Base : CLUSPROP_VALUE
    l : Int32
}
struct CLUSPROP_SZ {
    Base : CLUSPROP_VALUE
    sz : UInt16[1]
}
struct CLUSPROP_ULARGE_INTEGER {
    Base : CLUSPROP_VALUE
    li : Int64
}
struct CLUSPROP_LARGE_INTEGER {
    Base : CLUSPROP_VALUE
    li : Int64
}
struct CLUSPROP_SECURITY_DESCRIPTOR {
    Base : CLUSPROP_VALUE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            sd : SECURITY_DESCRIPTOR_RELATIVE
            rgbSecurityDescriptor : UInt8[1]
        }
    }
}
struct CLUSPROP_FILETIME {
    Base : CLUSPROP_VALUE
    ft : FILETIME
}
struct CLUS_RESOURCE_CLASS_INFO {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            li : Int64
        }
        struct _Anonymous_e__Struct {
            Anonymous : this._Anonymous_e__Union
            SubClass : UInt32
            struct _Anonymous_e__Union {
                union {
                    dw : UInt32
                    rc : CLUSTER_RESOURCE_CLASS
                }
            }
        }
    }
}
struct CLUSPROP_RESOURCE_CLASS {
    Base : CLUSPROP_VALUE
    rc : CLUSTER_RESOURCE_CLASS
}
struct CLUSPROP_REQUIRED_DEPENDENCY {
    union {
        Value : CLUSPROP_VALUE
        ResClass : CLUSPROP_RESOURCE_CLASS
        ResTypeName : CLUSPROP_SZ
    }
}
struct CLUSPROP_PIFLAGS extends Int32 {
    static CLUSPROP_PIFLAG_STICKY := 1
    static CLUSPROP_PIFLAG_REMOVABLE := 2
    static CLUSPROP_PIFLAG_USABLE := 4
    static CLUSPROP_PIFLAG_DEFAULT_QUORUM := 8
    static CLUSPROP_PIFLAG_USABLE_FOR_CSV := 16
    static CLUSPROP_PIFLAG_ENCRYPTION_ENABLED := 32
    static CLUSPROP_PIFLAG_RAW := 64
    static CLUSPROP_PIFLAG_UNKNOWN := -2147483648
}
struct CLUS_FORCE_QUORUM_INFO {
    dwSize : UInt32
    dwNodeBitMask : UInt32
    dwMaxNumberofNodes : UInt32
    multiszNodeList : UInt16[1]
}
struct CLUS_PARTITION_INFO {
    dwFlags : UInt32
    szDeviceName : UInt16[260]
    szVolumeLabel : UInt16[260]
    dwSerialNumber : UInt32
    rgdwMaximumComponentLength : UInt32
    dwFileSystemFlags : UInt32
    szFileSystem : UInt16[32]
}
struct CLUS_PARTITION_INFO_EX {
    dwFlags : UInt32
    szDeviceName : UInt16[260]
    szVolumeLabel : UInt16[260]
    dwSerialNumber : UInt32
    rgdwMaximumComponentLength : UInt32
    dwFileSystemFlags : UInt32
    szFileSystem : UInt16[32]
    TotalSizeInBytes : Int64
    FreeSizeInBytes : Int64
    DeviceNumber : UInt32
    PartitionNumber : UInt32
    VolumeGuid : GUID
}
struct CLUS_PARTITION_INFO_EX2 {
    GptPartitionId : GUID
    szPartitionName : UInt16[260]
    EncryptionFlags : UInt32
}
struct CLUSTER_CSV_VOLUME_FAULT_STATE extends Int32 {
    static VolumeStateNoFaults := 0
    static VolumeStateNoDirectIO := 1
    static VolumeStateNoAccess := 2
    static VolumeStateInMaintenance := 4
    static VolumeStateDismounted := 8
}
struct CLUSTER_SHARED_VOLUME_BACKUP_STATE extends Int32 {
    static VolumeBackupNone := 0
    static VolumeBackupInProgress := 1
}
struct CLUS_CSV_VOLUME_INFO {
    VolumeOffset : Int64
    PartitionNumber : UInt32
    FaultState : CLUSTER_CSV_VOLUME_FAULT_STATE
    BackupState : CLUSTER_SHARED_VOLUME_BACKUP_STATE
    szVolumeFriendlyName : UInt16[260]
    szVolumeName : UInt16[50]
}
struct CLUS_CSV_VOLUME_NAME {
    VolumeOffset : Int64
    szVolumeName : UInt16[260]
    szRootPath : UInt16[263]
}
struct CLUSTER_SHARED_VOLUME_STATE extends Int32 {
    static SharedVolumeStateUnavailable := 0
    static SharedVolumeStatePaused := 1
    static SharedVolumeStateActive := 2
    static SharedVolumeStateActiveRedirected := 3
    static SharedVolumeStateActiveVolumeRedirected := 4
}
struct CLUSTER_SHARED_VOLUME_STATE_INFO {
    szVolumeName : UInt16[260]
    szNodeName : UInt16[260]
    VolumeState : CLUSTER_SHARED_VOLUME_STATE
}
struct CLUSTER_SHARED_VOLUME_STATE_INFO_EX {
    szVolumeName : UInt16[260]
    szNodeName : UInt16[260]
    VolumeState : CLUSTER_SHARED_VOLUME_STATE
    szVolumeFriendlyName : UInt16[260]
    RedirectedIOReason : Int64
    VolumeRedirectedIOReason : Int64
}
struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE extends Int32 {
    static ClusterSharedVolumeRenameInputTypeNone := 0
    static ClusterSharedVolumeRenameInputTypeVolumeOffset := 1
    static ClusterSharedVolumeRenameInputTypeVolumeId := 2
    static ClusterSharedVolumeRenameInputTypeVolumeName := 3
    static ClusterSharedVolumeRenameInputTypeVolumeGuid := 4
}
struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_VOLUME {
    InputType : CLUSTER_SHARED_VOLUME_RENAME_INPUT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            VolumeOffset : Int64
            VolumeId : UInt16[260]
            VolumeName : UInt16[260]
            VolumeGuid : UInt16[50]
        }
    }
}
struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_NAME {
    NewVolumeName : UInt16[260]
}
struct CLUSTER_SHARED_VOLUME_RENAME_INPUT_GUID_NAME {
    NewVolumeName : UInt16[260]
    NewVolumeGuid : UInt16[50]
}
struct CLUS_CHKDSK_INFO {
    PartitionNumber : UInt32
    ChkdskState : UInt32
    FileIdCount : UInt32
    FileIdList : Int64[1]
}
struct CLUS_DISK_NUMBER_INFO {
    DiskNumber : UInt32
    BytesPerSector : UInt32
}
struct CLUS_SHARED_VOLUME_BACKUP_MODE {
    BackupState : CLUSTER_SHARED_VOLUME_BACKUP_STATE
    DelayTimerInSecs : UInt32
    VolumeName : UInt16[260]
}
struct CLUS_FTSET_INFO {
    dwRootSignature : UInt32
    dwFtType : UInt32
}
struct CLUS_SCSI_ADDRESS {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            dw : UInt32
        }
        struct _Anonymous_e__Struct {
            PortNumber : UInt8
            PathId : UInt8
            TargetId : UInt8
            Lun : UInt8
        }
    }
}
struct CLUS_NETNAME_VS_TOKEN_INFO {
    ProcessID : UInt32
    DesiredAccess : UInt32
    InheritHandle : BOOL
}
struct CLUS_NETNAME_PWD_INFO {
    Flags : UInt32
    Password : UInt16[16]
    CreatingDC : UInt16[258]
    ObjectGuid : UInt16[64]
}
struct CLUS_NETNAME_PWD_INFOEX {
    Flags : UInt32
    Password : UInt16[128]
    CreatingDC : UInt16[258]
    ObjectGuid : UInt16[64]
}
struct CLUS_DNN_LEADER_STATUS {
    IsOnline : BOOL
    IsFileServerPresent : BOOL
}
struct CLUS_DNN_SODAFS_CLONE_STATUS {
    NodeId : UInt32
    Status : CLUSTER_RESOURCE_STATE
}
struct CLUS_NETNAME_IP_INFO_ENTRY {
    NodeId : UInt32
    AddressSize : UInt32
    Address : UInt8[1]
}
struct CLUS_NETNAME_IP_INFO_FOR_MULTICHANNEL {
    szName : UInt16[64]
    NumEntries : UInt32
    IpInfo : CLUS_NETNAME_IP_INFO_ENTRY[1]
}
struct CLUS_MAINTENANCE_MODE_INFO {
    InMaintenance : BOOL
}
struct CLUS_CSV_MAINTENANCE_MODE_INFO {
    InMaintenance : BOOL
    VolumeName : UInt16[260]
}
struct MAINTENANCE_MODE_TYPE_ENUM extends Int32 {
    static MaintenanceModeTypeDisableIsAliveCheck := 1
    static MaintenanceModeTypeOfflineResource := 2
    static MaintenanceModeTypeUnclusterResource := 3
}
struct CLUS_MAINTENANCE_MODE_INFOEX {
    InMaintenance : BOOL
    MaintainenceModeType : MAINTENANCE_MODE_TYPE_ENUM
    InternalState : CLUSTER_RESOURCE_STATE
    Signature : UInt32
}
struct CLUS_SET_MAINTENANCE_MODE_INPUT {
    InMaintenance : BOOL
    ExtraParameterSize : UInt32
    ExtraParameter : UInt8[1]
}
struct CLUS_STORAGE_SET_DRIVELETTER {
    PartitionNumber : UInt32
    DriveLetterMask : UInt32
}
struct CLUS_STORAGE_GET_AVAILABLE_DRIVELETTERS {
    AvailDrivelettersMask : UInt32
}
struct CLUS_STORAGE_REMAP_DRIVELETTER {
    CurrentDriveLetterMask : UInt32
    TargetDriveLetterMask : UInt32
}
struct CLUS_PROVIDER_STATE_CHANGE_INFO {
    dwSize : UInt32
    resourceState : CLUSTER_RESOURCE_STATE
    szProviderId : UInt16[1]
}
struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_INPUT {
    FileServerName : UInt16[16]
}
struct CLUS_CREATE_INFRASTRUCTURE_FILESERVER_OUTPUT {
    FileServerName : UInt16[260]
}
struct CLUSPROP_LIST {
    nPropertyCount : UInt32
    PropertyName : CLUSPROP_SZ
}
struct CLUSPROP_IPADDR_ENABLENETBIOS extends Int32 {
    static CLUSPROP_IPADDR_ENABLENETBIOS_DISABLED := 0
    static CLUSPROP_IPADDR_ENABLENETBIOS_ENABLED := 1
    static CLUSPROP_IPADDR_ENABLENETBIOS_TRACK_NIC := 2
}
struct FILESHARE_CHANGE_ENUM extends Int32 {
    static FILESHARE_CHANGE_NONE := 0
    static FILESHARE_CHANGE_ADD := 1
    static FILESHARE_CHANGE_DEL := 2
    static FILESHARE_CHANGE_MODIFY := 3
}
struct FILESHARE_CHANGE {
    Change : FILESHARE_CHANGE_ENUM
    ShareName : UInt16[84]
}
struct FILESHARE_CHANGE_LIST {
    NumEntries : UInt32
    ChangeEntry : FILESHARE_CHANGE[1]
}
struct CLUSCTL_GROUP_GET_LAST_MOVE_TIME_OUTPUT {
    GetTickCount64 : Int64
    GetSystemTime : SYSTEMTIME
    NodeId : UInt32
}
struct CLUSPROP_BUFFER_HELPER {
    union {
        pb : UInt8.Ptr
        pw : UInt16.Ptr
        pdw : UInt32.Ptr
        pl : Int32.Ptr
        psz : PWSTR
        pList : CLUSPROP_LIST.Ptr
        pSyntax : CLUSPROP_SYNTAX.Ptr
        pName : CLUSPROP_SZ.Ptr
        pValue : CLUSPROP_VALUE.Ptr
        pBinaryValue : CLUSPROP_BINARY.Ptr
        pWordValue : CLUSPROP_WORD.Ptr
        pDwordValue : CLUSPROP_DWORD.Ptr
        pLongValue : CLUSPROP_LONG.Ptr
        pULargeIntegerValue : CLUSPROP_ULARGE_INTEGER.Ptr
        pLargeIntegerValue : CLUSPROP_LARGE_INTEGER.Ptr
        pStringValue : CLUSPROP_SZ.Ptr
        pMultiSzValue : CLUSPROP_SZ.Ptr
        pSecurityDescriptor : CLUSPROP_SECURITY_DESCRIPTOR.Ptr
        pResourceClassValue : CLUSPROP_RESOURCE_CLASS.Ptr
        pResourceClassInfoValue : CLUSPROP_RESOURCE_CLASS_INFO.Ptr
        pDiskSignatureValue : CLUSPROP_DWORD.Ptr
        pScsiAddressValue : CLUSPROP_SCSI_ADDRESS.Ptr
        pDiskNumberValue : CLUSPROP_DWORD.Ptr
        pPartitionInfoValue : CLUSPROP_PARTITION_INFO.Ptr
        pRequiredDependencyValue : CLUSPROP_REQUIRED_DEPENDENCY.Ptr
        pPartitionInfoValueEx : CLUSPROP_PARTITION_INFO_EX.Ptr
        pPartitionInfoValueEx2 : CLUSPROP_PARTITION_INFO_EX2.Ptr
        pFileTimeValue : CLUSPROP_FILETIME.Ptr
    }
}
struct CLUSTER_RESOURCE_ENUM extends Int32 {
    static CLUSTER_RESOURCE_ENUM_DEPENDS := 1
    static CLUSTER_RESOURCE_ENUM_PROVIDES := 2
    static CLUSTER_RESOURCE_ENUM_NODES := 4
    static CLUSTER_RESOURCE_ENUM_ALL := 7
}
struct CLUSTER_RESOURCE_TYPE_ENUM extends Int32 {
    static CLUSTER_RESOURCE_TYPE_ENUM_NODES := 1
    static CLUSTER_RESOURCE_TYPE_ENUM_RESOURCES := 2
    static CLUSTER_RESOURCE_TYPE_ENUM_ALL := 3
}
struct PCLUSAPI_CLUSTER_RESOURCE_OPEN_ENUM extends FunctionPointer {
    static Types := [HRESOURCE, UInt32, HRESENUM]
}
struct PCLUSAPI_CLUSTER_RESOURCE_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HRESENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_ENUM extends FunctionPointer {
    static Types := [HRESENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_CLOSE_ENUM extends FunctionPointer {
    static Types := [HRESENUM, UInt32]
}
struct PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PWSTR, PWSTR, UInt32, UInt32, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32]
}
struct PCLUSAPI_CREATE_CLUSTER_RESOURCE_TYPE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PWSTR, PWSTR, UInt32, UInt32, PWSTR, UInt32]
}
struct PCLUSAPI_DELETE_CLUSTER_RESOURCE_TYPE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_OPEN_ENUM extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, HRESTYPEENUM]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HRESTYPEENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_ENUM extends FunctionPointer {
    static Types := [HRESTYPEENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_RESOURCE_TYPE_CLOSE_ENUM extends FunctionPointer {
    static Types := [HRESTYPEENUM, UInt32]
}
struct CLUSTER_NETWORK_ENUM extends Int32 {
    static CLUSTER_NETWORK_ENUM_NETINTERFACES := 1
    static CLUSTER_NETWORK_ENUM_ALL := 1
}
struct CLUSTER_NETWORK_STATE extends Int32 {
    static ClusterNetworkStateUnknown := -1
    static ClusterNetworkUnavailable := 0
    static ClusterNetworkDown := 1
    static ClusterNetworkPartitioned := 2
    static ClusterNetworkUp := 3
}
struct CLUSTER_NETWORK_ROLE extends Int32 {
    static ClusterNetworkRoleNone := 0
    static ClusterNetworkRoleInternalUse := 1
    static ClusterNetworkRoleClientAccess := 2
    static ClusterNetworkRoleInternalAndClient := 3
}
struct PCLUSAPI_OPEN_CLUSTER_NETWORK extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNETWORK]
}
struct PCLUSAPI_OPEN_CLUSTER_NETWORK_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32.Ptr, HNETWORK]
}
struct PCLUSAPI_CLOSE_CLUSTER_NETWORK extends FunctionPointer {
    static Types := [HNETWORK, BOOL]
}
struct PCLUSAPI_GET_CLUSTER_FROM_NETWORK extends FunctionPointer {
    static Types := [HNETWORK, HCLUSTER]
}
struct PCLUSAPI_CLUSTER_NETWORK_OPEN_ENUM extends FunctionPointer {
    static Types := [HNETWORK, UInt32, HNETWORKENUM]
}
struct PCLUSAPI_CLUSTER_NETWORK_GET_ENUM_COUNT extends FunctionPointer {
    static Types := [HNETWORKENUM, UInt32]
}
struct PCLUSAPI_CLUSTER_NETWORK_ENUM extends FunctionPointer {
    static Types := [HNETWORKENUM, UInt32, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NETWORK_CLOSE_ENUM extends FunctionPointer {
    static Types := [HNETWORKENUM, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_NETWORK_STATE extends FunctionPointer {
    static Types := [HNETWORK, CLUSTER_NETWORK_STATE]
}
struct PCLUSAPI_SET_CLUSTER_NETWORK_NAME extends FunctionPointer {
    static Types := [HNETWORK, PWSTR, UInt32]
}
struct PCLUSAPI_SET_CLUSTER_NETWORK_NAME_EX extends FunctionPointer {
    static Types := [HNETWORK, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_NETWORK_ID extends FunctionPointer {
    static Types := [HNETWORK, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NETWORK_CONTROL extends FunctionPointer {
    static Types := [HNETWORK, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NETWORK_CONTROL_EX extends FunctionPointer {
    static Types := [HNETWORK, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct CLUSTER_NETINTERFACE_STATE extends Int32 {
    static ClusterNetInterfaceStateUnknown := -1
    static ClusterNetInterfaceUnavailable := 0
    static ClusterNetInterfaceFailed := 1
    static ClusterNetInterfaceUnreachable := 2
    static ClusterNetInterfaceUp := 3
}
struct PCLUSAPI_OPEN_CLUSTER_NET_INTERFACE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, HNETINTERFACE]
}
struct PCLUSAPI_OPEN_CLUSTER_NETINTERFACE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32.Ptr, HNETINTERFACE]
}
struct PCLUSAPI_GET_CLUSTER_NET_INTERFACE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PWSTR, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLOSE_CLUSTER_NET_INTERFACE extends FunctionPointer {
    static Types := [HNETINTERFACE, BOOL]
}
struct PCLUSAPI_GET_CLUSTER_FROM_NET_INTERFACE extends FunctionPointer {
    static Types := [HNETINTERFACE, HCLUSTER]
}
struct PCLUSAPI_GET_CLUSTER_NET_INTERFACE_STATE extends FunctionPointer {
    static Types := [HNETINTERFACE, CLUSTER_NETINTERFACE_STATE]
}
struct PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL extends FunctionPointer {
    static Types := [HNETINTERFACE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_NET_INTERFACE_CONTROL_EX extends FunctionPointer {
    static Types := [HNETINTERFACE, HNODE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, PWSTR, UInt32]
}
struct PCLUSAPI_GET_CLUSTER_KEY extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, HKEY]
}
struct PCLUSAPI_GET_CLUSTER_GROUP_KEY extends FunctionPointer {
    static Types := [HGROUP, UInt32, HKEY]
}
struct PCLUSAPI_GET_CLUSTER_RESOURCE_KEY extends FunctionPointer {
    static Types := [HRESOURCE, UInt32, HKEY]
}
struct PCLUSAPI_GET_CLUSTER_NODE_KEY extends FunctionPointer {
    static Types := [HNODE, UInt32, HKEY]
}
struct PCLUSAPI_GET_CLUSTER_NETWORK_KEY extends FunctionPointer {
    static Types := [HNETWORK, UInt32, HKEY]
}
struct PCLUSAPI_GET_CLUSTER_NET_INTERFACE_KEY extends FunctionPointer {
    static Types := [HNETINTERFACE, UInt32, HKEY]
}
struct PCLUSAPI_CLUSTER_REG_CREATE_KEY extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt32, SECURITY_ATTRIBUTES.Ptr, HKEY.Ptr, UInt32.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_CREATE_KEY_EX extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt32, SECURITY_ATTRIBUTES.Ptr, HKEY.Ptr, UInt32.Ptr, PWSTR, Int32]
}
struct PCLUSAPI_CLUSTER_REG_OPEN_KEY extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, HKEY.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_DELETE_KEY extends FunctionPointer {
    static Types := [HKEY, PWSTR, Int32]
}
struct PCLUSAPI_CLUSTER_REG_DELETE_KEY_EX extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR, Int32]
}
struct PCLUSAPI_CLUSTER_REG_CLOSE_KEY extends FunctionPointer {
    static Types := [HKEY, Int32]
}
struct PCLUSAPI_CLUSTER_REG_ENUM_KEY extends FunctionPointer {
    static Types := [HKEY, UInt32, PWSTR, UInt32.Ptr, FILETIME.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_SET_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt8.Ptr, UInt32, UInt32]
}
struct PCLUSAPI_CLUSTER_REG_DELETE_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_REG_SET_VALUE_EX extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt8.Ptr, UInt32, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_REG_DELETE_VALUE_EX extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR, UInt32]
}
struct PCLUSAPI_CLUSTER_REG_QUERY_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32.Ptr, UInt8.Ptr, UInt32.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_ENUM_VALUE extends FunctionPointer {
    static Types := [HKEY, UInt32, PWSTR, UInt32.Ptr, UInt32.Ptr, UInt8.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSAPI_CLUSTER_REG_QUERY_INFO_KEY extends FunctionPointer {
    static Types := [HKEY, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, FILETIME.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_GET_KEY_SECURITY extends FunctionPointer {
    static Types := [HKEY, UInt32, PSECURITY_DESCRIPTOR, UInt32.Ptr, Int32]
}
struct PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY extends FunctionPointer {
    static Types := [HKEY, UInt32, PSECURITY_DESCRIPTOR, Int32]
}
struct PCLUSAPI_CLUSTER_REG_SET_KEY_SECURITY_EX extends FunctionPointer {
    static Types := [HKEY, UInt32, PSECURITY_DESCRIPTOR, PWSTR, Int32]
}
struct PCLUSAPI_CLUSTER_REG_SYNC_DATABASE extends FunctionPointer {
    static Types := [HCLUSTER, UInt32, Int32]
}
struct PCLUSAPI_CLUSTER_REG_CREATE_BATCH extends FunctionPointer {
    static Types := [HKEY, HREGBATCH.Ptr, Int32]
}
struct PCLUSTER_REG_BATCH_ADD_COMMAND extends FunctionPointer {
    static Types := [HREGBATCH, CLUSTER_REG_COMMAND, PWSTR, UInt32, Struct.Ptr, UInt32, Int32]
}
struct PCLUSTER_REG_CLOSE_BATCH extends FunctionPointer {
    static Types := [HREGBATCH, BOOL, Int32.Ptr, Int32]
}
struct PCLUSTER_REG_BATCH_READ_COMMAND extends FunctionPointer {
    static Types := [HREGBATCHNOTIFICATION, CLUSTER_BATCH_COMMAND.Ptr, Int32]
}
struct PCLUSTER_REG_BATCH_CLOSE_NOTIFICATION extends FunctionPointer {
    static Types := [HREGBATCHNOTIFICATION, Int32]
}
struct PCLUSTER_REG_CREATE_BATCH_NOTIFY_PORT extends FunctionPointer {
    static Types := [HKEY, HREGBATCHPORT.Ptr, Int32]
}
struct PCLUSTER_REG_CLOSE_BATCH_NOTIFY_PORT extends FunctionPointer {
    static Types := [HREGBATCHPORT, Int32]
}
struct PCLUSTER_REG_GET_BATCH_NOTIFICATION extends FunctionPointer {
    static Types := [HREGBATCHPORT, HREGBATCHNOTIFICATION.Ptr, Int32]
}
struct PCLUSTER_REG_CREATE_READ_BATCH extends FunctionPointer {
    static Types := [HKEY, HREGREADBATCH.Ptr, Int32]
}
struct PCLUSTER_REG_READ_BATCH_ADD_COMMAND extends FunctionPointer {
    static Types := [HREGREADBATCH, PWSTR, PWSTR, Int32]
}
struct PCLUSTER_REG_CLOSE_READ_BATCH extends FunctionPointer {
    static Types := [HREGREADBATCH, HREGREADBATCHREPLY.Ptr, Int32]
}
struct PCLUSTER_REG_CLOSE_READ_BATCH_EX extends FunctionPointer {
    static Types := [HREGREADBATCH, UInt32, HREGREADBATCHREPLY.Ptr, Int32]
}
struct PCLUSTER_REG_READ_BATCH_REPLY_NEXT_COMMAND extends FunctionPointer {
    static Types := [HREGREADBATCHREPLY, CLUSTER_READ_BATCH_COMMAND.Ptr, Int32]
}
struct PCLUSTER_REG_CLOSE_READ_BATCH_REPLY extends FunctionPointer {
    static Types := [HREGREADBATCHREPLY, Int32]
}
struct PCLUSTER_SET_ACCOUNT_ACCESS extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, UInt32, UInt32]
}
struct CLUSTER_SETUP_PHASE extends Int32 {
    static ClusterSetupPhaseInitialize := 1
    static ClusterSetupPhaseValidateNodeState := 100
    static ClusterSetupPhaseValidateNetft := 102
    static ClusterSetupPhaseValidateClusDisk := 103
    static ClusterSetupPhaseConfigureClusSvc := 104
    static ClusterSetupPhaseStartingClusSvc := 105
    static ClusterSetupPhaseQueryClusterNameAccount := 106
    static ClusterSetupPhaseValidateClusterNameAccount := 107
    static ClusterSetupPhaseCreateClusterAccount := 108
    static ClusterSetupPhaseConfigureClusterAccount := 109
    static ClusterSetupPhaseFormingCluster := 200
    static ClusterSetupPhaseAddClusterProperties := 201
    static ClusterSetupPhaseCreateResourceTypes := 202
    static ClusterSetupPhaseCreateGroups := 203
    static ClusterSetupPhaseCreateIPAddressResources := 204
    static ClusterSetupPhaseCreateNetworkName := 205
    static ClusterSetupPhaseClusterGroupOnline := 206
    static ClusterSetupPhaseGettingCurrentMembership := 300
    static ClusterSetupPhaseAddNodeToCluster := 301
    static ClusterSetupPhaseNodeUp := 302
    static ClusterSetupPhaseApplyNetworkATCIntents := 303
    static ClusterSetupPhaseMoveGroup := 400
    static ClusterSetupPhaseDeleteGroup := 401
    static ClusterSetupPhaseCleanupCOs := 402
    static ClusterSetupPhaseOfflineGroup := 403
    static ClusterSetupPhaseEvictNode := 404
    static ClusterSetupPhaseCleanupNode := 405
    static ClusterSetupPhaseCoreGroupCleanup := 406
    static ClusterSetupPhaseRepairCNOAccount := 500
    static ClusterSetupPhaseRepairDNSPermissions := 501
    static ClusterSetupPhaseFailureCleanup := 999
}
struct CLUSTER_SETUP_PHASE_TYPE extends Int32 {
    static ClusterSetupPhaseStart := 1
    static ClusterSetupPhaseContinue := 2
    static ClusterSetupPhaseEnd := 3
    static ClusterSetupPhaseReport := 4
}
struct CLUSTER_SETUP_PHASE_SEVERITY extends Int32 {
    static ClusterSetupPhaseInformational := 1
    static ClusterSetupPhaseWarning := 2
    static ClusterSetupPhaseFatal := 3
}
struct PCLUSTER_SETUP_PROGRESS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, CLUSTER_SETUP_PHASE, CLUSTER_SETUP_PHASE_TYPE, CLUSTER_SETUP_PHASE_SEVERITY, UInt32, PWSTR, UInt32, BOOL]
}
struct PCLUSAPI_CREATE_CLUSTER extends FunctionPointer {
    static Types := [CREATE_CLUSTER_CONFIG.Ptr, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, HCLUSTER]
}
struct PCLUSAPI_CREATE_CLUSTER_CNOLESS extends FunctionPointer {
    static Types := [CREATE_CLUSTER_CONFIG.Ptr, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, HCLUSTER]
}
struct PCLUSAPI_CREATE_CLUSTER_NAME_ACCOUNT extends FunctionPointer {
    static Types := [HCLUSTER, CREATE_CLUSTER_NAME_ACCOUNT.Ptr, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, UInt32]
}
struct PCLUSAPI_REPAIR_CLUSTER_NAME_ACCOUNT extends FunctionPointer {
    static Types := [HCLUSTER, UInt32]
}
struct PCLUSAPI_REMOVE_CLUSTER_NAME_ACCOUNT extends FunctionPointer {
    static Types := [HCLUSTER, UInt32]
}
struct PCLUSAPI_ADD_CLUSTER_NODE extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, HNODE]
}
struct PCLUSAPI_ADD_CLUSTER_NODE_EX extends FunctionPointer {
    static Types := [HCLUSTER, PWSTR, UInt32, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, HNODE]
}
struct PCLUSAPI_DESTROY_CLUSTER extends FunctionPointer {
    static Types := [HCLUSTER, PCLUSTER_SETUP_PROGRESS_CALLBACK, Struct.Ptr, BOOL, UInt32]
}
struct PLACEMENT_OPTIONS extends Int32 {
    static PLACEMENT_OPTIONS_MIN_VALUE := 0
    static PLACEMENT_OPTIONS_DEFAULT_PLACEMENT_OPTIONS := 0
    static PLACEMENT_OPTIONS_DISABLE_CSV_VM_DEPENDENCY := 1
    static PLACEMENT_OPTIONS_CONSIDER_OFFLINE_VMS := 2
    static PLACEMENT_OPTIONS_DONT_USE_MEMORY := 4
    static PLACEMENT_OPTIONS_DONT_USE_CPU := 8
    static PLACEMENT_OPTIONS_DONT_USE_LOCAL_TEMP_DISK := 16
    static PLACEMENT_OPTIONS_DONT_RESUME_VMS_WITH_EXISTING_TEMP_DISK := 32
    static PLACEMENT_OPTIONS_SAVE_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE := 64
    static PLACEMENT_OPTIONS_DONT_RESUME_AVAILABILTY_SET_VMS_WITH_EXISTING_TEMP_DISK := 128
    static PLACEMENT_OPTIONS_SAVE_AVAILABILTY_SET_VMS_WITH_LOCAL_DISK_ON_DRAIN_OVERWRITE := 256
    static PLACEMENT_OPTIONS_AVAILABILITY_SET_DOMAIN_AFFINITY := 512
    static PLACEMENT_OPTIONS_ALL := 1023
}
struct GRP_PLACEMENT_OPTIONS extends Int32 {
    static GRP_PLACEMENT_OPTIONS_MIN_VALUE := 0
    static GRP_PLACEMENT_OPTIONS_DEFAULT := 0
    static GRP_PLACEMENT_OPTIONS_DISABLE_AUTOBALANCING := 1
    static GRP_PLACEMENT_OPTIONS_ALL := 1
}
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO {
    PartitionOffset : Int64
    Capabilities : UInt32
}
struct SR_RESOURCE_TYPE_REPLICATED_PARTITION_ARRAY {
    Count : UInt32
    PartitionArray : SR_RESOURCE_TYPE_REPLICATED_PARTITION_INFO[1]
}
struct SR_REPLICATED_DISK_TYPE extends Int32 {
    static SrReplicatedDiskTypeNone := 0
    static SrReplicatedDiskTypeSource := 1
    static SrReplicatedDiskTypeLogSource := 2
    static SrReplicatedDiskTypeDestination := 3
    static SrReplicatedDiskTypeLogDestination := 4
    static SrReplicatedDiskTypeNotInParthership := 5
    static SrReplicatedDiskTypeLogNotInParthership := 6
    static SrReplicatedDiskTypeOther := 7
}
struct SR_DISK_REPLICATION_ELIGIBLE extends Int32 {
    static SrDiskReplicationEligibleNone := 0
    static SrDiskReplicationEligibleYes := 1
    static SrDiskReplicationEligibleOffline := 2
    static SrDiskReplicationEligibleNotGpt := 3
    static SrDiskReplicationEligiblePartitionLayoutMismatch := 4
    static SrDiskReplicationEligibleInsufficientFreeSpace := 5
    static SrDiskReplicationEligibleNotInSameSite := 6
    static SrDiskReplicationEligibleInSameSite := 7
    static SrDiskReplicationEligibleFileSystemNotSupported := 8
    static SrDiskReplicationEligibleAlreadyInReplication := 9
    static SrDiskReplicationEligibleSameAsSpecifiedDisk := 10
    static SrDiskReplicationEligibleOther := 9999
}
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_LOGDISKS {
    DataDiskGuid : GUID
    IncludeOfflineDisks : BOOLEAN
}
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_TARGET_DATADISKS {
    SourceDataDiskGuid : GUID
    TargetReplicationGroupGuid : GUID
    SkipConnectivityCheck : BOOLEAN
    IncludeOfflineDisks : BOOLEAN
}
struct SR_RESOURCE_TYPE_QUERY_ELIGIBLE_SOURCE_DATADISKS {
    DataDiskGuid : GUID
    IncludeAvailableStoargeDisks : BOOLEAN
}
struct SR_RESOURCE_TYPE_DISK_INFO {
    Reason : SR_DISK_REPLICATION_ELIGIBLE
    DiskGuid : GUID
}
struct SR_RESOURCE_TYPE_ELIGIBLE_DISKS_RESULT {
    Count : UInt16
    DiskInfo : SR_RESOURCE_TYPE_DISK_INFO[1]
}
struct SR_RESOURCE_TYPE_REPLICATED_DISK {
    Type : SR_REPLICATED_DISK_TYPE
    ClusterDiskResourceGuid : GUID
    ReplicationGroupId : GUID
    ReplicationGroupName : UInt16[260]
}
struct SR_RESOURCE_TYPE_REPLICATED_DISKS_RESULT {
    Count : UInt16
    ReplicatedDisks : SR_RESOURCE_TYPE_REPLICATED_DISK[1]
}
struct SR_RESOURCE_TYPE_ADD_REPLICATION_GROUP {
    ReplicationGroupName : UInt16[260]
    Description : UInt16[260]
    LogPath : UInt16[260]
    MaxLogSizeInBytes : Int64
    LogType : UInt16
    ReplicationMode : UInt32
    MinimumPartnersInSync : UInt32
    EnableWriteConsistency : BOOLEAN
    EnableEncryption : BOOLEAN
    EnableCompression : BOOLEAN
    CertificateThumbprint : UInt16[260]
    VolumeNameCount : UInt32
    VolumeNames : UInt16[260]
}
struct SR_RESOURCE_TYPE_ADD_REPLICATION_GROUP_RESULT {
    Result : UInt32
    ErrorString : UInt16[260]
}
struct CLUSCTL_RESOURCE_TYPE_STORAGE_GET_AVAILABLE_DISKS_EX2_INPUT {
    dwFlags : UInt32
    guidPoolFilter : GUID
}
struct RESOURCE_STATUS {
    ResourceState : CLUSTER_RESOURCE_STATE
    CheckPoint : UInt32
    WaitHint : UInt32
    EventHandle : HANDLE
}
struct NodeUtilizationInfoElement {
    Id : Int64
    AvailableMemory : Int64
    AvailableMemoryAfterReclamation : Int64
}
struct ResourceUtilizationInfoElement {
    PhysicalNumaId : Int64
    CurrentMemory : Int64
}
struct VM_RESDLL_CONTEXT extends Int32 {
    static VmResdllContextTurnOff := 0
    static VmResdllContextSave := 1
    static VmResdllContextShutdown := 2
    static VmResdllContextShutdownForce := 3
    static VmResdllContextLiveMigration := 4
}
struct RESDLL_CONTEXT_OPERATION_TYPE extends Int32 {
    static ResdllContextOperationTypeFailback := 0
    static ResdllContextOperationTypeDrain := 1
    static ResdllContextOperationTypeDrainFailure := 2
    static ResdllContextOperationTypeEmbeddedFailure := 3
    static ResdllContextOperationTypePreemption := 4
    static ResdllContextOperationTypeNetworkDisconnect := 5
    static ResdllContextOperationTypeNetworkDisconnectMoveRetry := 6
}
struct GET_OPERATION_CONTEXT_PARAMS {
    Size : UInt32
    Version : UInt32
    Type : RESDLL_CONTEXT_OPERATION_TYPE
    Priority : UInt32
}
struct RESOURCE_STATUS_EX {
    ResourceState : CLUSTER_RESOURCE_STATE
    CheckPoint : UInt32
    EventHandle : HANDLE
    ApplicationSpecificErrorCode : UInt32
    Flags : UInt32
    WaitHint : UInt32
}
struct PSET_RESOURCE_STATUS_ROUTINE_EX extends FunctionPointer {
    static Types := [IntPtr, RESOURCE_STATUS_EX.Ptr, UInt32]
}
struct PSET_RESOURCE_STATUS_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, RESOURCE_STATUS.Ptr, UInt32]
}
struct PQUORUM_RESOURCE_LOST extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct LOG_LEVEL extends Int32 {
    static LOG_INFORMATION := 0
    static LOG_WARNING := 1
    static LOG_ERROR := 2
    static LOG_SEVERE := 3
}
struct PLOG_EVENT_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, LOG_LEVEL, PWSTR, "Void"]
    static Options := "C"
}
struct POPEN_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, HKEY, IntPtr, Struct.Ptr]
}
struct PCLOSE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PONLINE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, HANDLE.Ptr, UInt32]
}
struct POFFLINE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PTERMINATE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PIS_ALIVE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL]
}
struct PLOOKS_ALIVE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL]
}
struct PARBITRATE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, PQUORUM_RESOURCE_LOST, UInt32]
}
struct PRELEASE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PRESOURCE_CONTROL_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PRESOURCE_TYPE_CONTROL_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct POPEN_V2_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, HKEY, IntPtr, UInt32, Struct.Ptr]
}
struct PONLINE_V2_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, HANDLE.Ptr, UInt32, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct POFFLINE_V2_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, PWSTR, UInt32, UInt8.Ptr, UInt32, UInt32, UInt32]
}
struct PCANCEL_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32]
}
struct PBEGIN_RESCALL_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, Int64, BOOL.Ptr, UInt32]
}
struct PBEGIN_RESTYPECALL_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, Int64, BOOL.Ptr, UInt32]
}
struct RESOURCE_EXIT_STATE extends Int32 {
    static ResourceExitStateContinue := 0
    static ResourceExitStateTerminate := 1
    static ResourceExitStateMax := 2
}
struct PBEGIN_RESCALL_AS_USER_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, HANDLE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, Int64, BOOL.Ptr, UInt32]
}
struct PBEGIN_RESTYPECALL_AS_USER_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, HANDLE, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, Int64, BOOL.Ptr, UInt32]
}
struct CLRES_V1_FUNCTIONS {
    Open : POPEN_ROUTINE
    Close : PCLOSE_ROUTINE
    Online : PONLINE_ROUTINE
    Offline : POFFLINE_ROUTINE
    Terminate : PTERMINATE_ROUTINE
    LooksAlive : PLOOKS_ALIVE_ROUTINE
    IsAlive : PIS_ALIVE_ROUTINE
    Arbitrate : PARBITRATE_ROUTINE
    Release : PRELEASE_ROUTINE
    ResourceControl : PRESOURCE_CONTROL_ROUTINE
    ResourceTypeControl : PRESOURCE_TYPE_CONTROL_ROUTINE
}
struct CLRES_V2_FUNCTIONS {
    Open : POPEN_V2_ROUTINE
    Close : PCLOSE_ROUTINE
    Online : PONLINE_V2_ROUTINE
    Offline : POFFLINE_V2_ROUTINE
    Terminate : PTERMINATE_ROUTINE
    LooksAlive : PLOOKS_ALIVE_ROUTINE
    IsAlive : PIS_ALIVE_ROUTINE
    Arbitrate : PARBITRATE_ROUTINE
    Release : PRELEASE_ROUTINE
    ResourceControl : PRESOURCE_CONTROL_ROUTINE
    ResourceTypeControl : PRESOURCE_TYPE_CONTROL_ROUTINE
    Cancel : PCANCEL_ROUTINE
}
struct CLRES_V3_FUNCTIONS {
    Open : POPEN_V2_ROUTINE
    Close : PCLOSE_ROUTINE
    Online : PONLINE_V2_ROUTINE
    Offline : POFFLINE_V2_ROUTINE
    Terminate : PTERMINATE_ROUTINE
    LooksAlive : PLOOKS_ALIVE_ROUTINE
    IsAlive : PIS_ALIVE_ROUTINE
    Arbitrate : PARBITRATE_ROUTINE
    Release : PRELEASE_ROUTINE
    BeginResourceControl : PBEGIN_RESCALL_ROUTINE
    BeginResourceTypeControl : PBEGIN_RESTYPECALL_ROUTINE
    Cancel : PCANCEL_ROUTINE
}
struct CLRES_V4_FUNCTIONS {
    Open : POPEN_V2_ROUTINE
    Close : PCLOSE_ROUTINE
    Online : PONLINE_V2_ROUTINE
    Offline : POFFLINE_V2_ROUTINE
    Terminate : PTERMINATE_ROUTINE
    LooksAlive : PLOOKS_ALIVE_ROUTINE
    IsAlive : PIS_ALIVE_ROUTINE
    Arbitrate : PARBITRATE_ROUTINE
    Release : PRELEASE_ROUTINE
    BeginResourceControl : PBEGIN_RESCALL_ROUTINE
    BeginResourceTypeControl : PBEGIN_RESTYPECALL_ROUTINE
    Cancel : PCANCEL_ROUTINE
    BeginResourceControlAsUser : PBEGIN_RESCALL_AS_USER_ROUTINE
    BeginResourceTypeControlAsUser : PBEGIN_RESTYPECALL_AS_USER_ROUTINE
}
struct CLRES_FUNCTION_TABLE {
    TableSize : UInt32
    Version : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            V1Functions : CLRES_V1_FUNCTIONS
            V2Functions : CLRES_V2_FUNCTIONS
            V3Functions : CLRES_V3_FUNCTIONS
            V4Functions : CLRES_V4_FUNCTIONS
        }
    }
}
struct RESUTIL_LARGEINT_DATA {
    Default : Int64
    Minimum : Int64
    Maximum : Int64
}
struct RESUTIL_ULARGEINT_DATA {
    Default : Int64
    Minimum : Int64
    Maximum : Int64
}
struct RESUTIL_FILETIME_DATA {
    Default : FILETIME
    Minimum : FILETIME
    Maximum : FILETIME
}
struct RESUTIL_PROPERTY_ITEM {
    Name : PWSTR
    KeyName : PWSTR
    Format : UInt32
    Anonymous : this._Anonymous_e__Union
    Minimum : UInt32
    Maximum : UInt32
    Flags : UInt32
    Offset : UInt32
    struct _Anonymous_e__Union {
        union {
            DefaultPtr : IntPtr
            Default : UInt32
            lpDefault : Struct.Ptr
            LargeIntData : RESUTIL_LARGEINT_DATA.Ptr
            ULargeIntData : RESUTIL_ULARGEINT_DATA.Ptr
            FileTimeData : RESUTIL_FILETIME_DATA.Ptr
        }
    }
}
struct PSTARTUP_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32, PSET_RESOURCE_STATUS_ROUTINE, PLOG_EVENT_ROUTINE, CLRES_FUNCTION_TABLE.Ptr.Ptr, UInt32]
}
struct FAILURE_TYPE extends Int32 {
    static FAILURE_TYPE_GENERAL := 0
    static FAILURE_TYPE_EMBEDDED := 1
    static FAILURE_TYPE_NETWORK_LOSS := 2
}
struct CLUSTER_RESOURCE_APPLICATION_STATE extends Int32 {
    static ClusterResourceApplicationStateUnknown := 1
    static ClusterResourceApplicationOSHeartBeat := 2
    static ClusterResourceApplicationReady := 3
}
struct PSET_RESOURCE_LOCKED_MODE_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, BOOL, UInt32, UInt32]
}
struct PSIGNAL_FAILURE_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, FAILURE_TYPE, UInt32, UInt32]
}
struct PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, UInt8.Ptr, UInt32, UInt32]
}
struct PEND_CONTROL_CALL extends FunctionPointer {
    static Types := [Int64, UInt32, UInt32]
}
struct PEND_TYPE_CONTROL_CALL extends FunctionPointer {
    static Types := [Int64, UInt32, UInt32]
}
struct PEXTEND_RES_CONTROL_CALL extends FunctionPointer {
    static Types := [Int64, UInt32, UInt32]
}
struct PEXTEND_RES_TYPE_CONTROL_CALL extends FunctionPointer {
    static Types := [Int64, UInt32, UInt32]
}
struct PRAISE_RES_TYPE_NOTIFICATION extends FunctionPointer {
    static Types := [PWSTR, UInt8.Ptr, UInt32, UInt32]
}
struct PCHANGE_RESOURCE_PROCESS_FOR_DUMPS extends FunctionPointer {
    static Types := [IntPtr, PWSTR, UInt32, BOOL, UInt32]
}
struct PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, BOOL, UInt32]
}
struct PSET_INTERNAL_STATE extends FunctionPointer {
    static Types := [IntPtr, CLUSTER_RESOURCE_APPLICATION_STATE, BOOL, UInt32]
}
struct PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, BOOL, UInt32, UInt32, UInt32]
}
struct PREQUEST_DUMP_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, BOOL, UInt32, UInt32]
}
struct PSET_RESOURCE_WPR_POLICY_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, UInt32, UInt32]
}
struct PARM_WPR_WATCHDOG_FOR_CURRENT_RESOURCE_CALL_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, Int64, UInt32]
}
struct CLRES_CALLBACK_FUNCTION_TABLE {
    LogEvent : PLOG_EVENT_ROUTINE
    SetResourceStatusEx : PSET_RESOURCE_STATUS_ROUTINE_EX
    SetResourceLockedMode : PSET_RESOURCE_LOCKED_MODE_ROUTINE
    SignalFailure : PSIGNAL_FAILURE_ROUTINE
    SetResourceInMemoryNodeLocalProperties : PSET_RESOURCE_INMEMORY_NODELOCAL_PROPERTIES_ROUTINE
    EndControlCall : PEND_CONTROL_CALL
    EndTypeControlCall : PEND_TYPE_CONTROL_CALL
    ExtendControlCall : PEXTEND_RES_CONTROL_CALL
    ExtendTypeControlCall : PEXTEND_RES_TYPE_CONTROL_CALL
    RaiseResTypeNotification : PRAISE_RES_TYPE_NOTIFICATION
    ChangeResourceProcessForDumps : PCHANGE_RESOURCE_PROCESS_FOR_DUMPS
    ChangeResTypeProcessForDumps : PCHANGE_RES_TYPE_PROCESS_FOR_DUMPS
    SetInternalState : PSET_INTERNAL_STATE
    SetResourceLockedModeEx : PSET_RESOURCE_LOCKED_MODE_EX_ROUTINE
    RequestDump : PREQUEST_DUMP_ROUTINE
    SetResourceWprPolicy : PSET_RESOURCE_WPR_POLICY_ROUTINE
    ArmWprWatchdogForCurrentResourceCall : PARM_WPR_WATCHDOG_FOR_CURRENT_RESOURCE_CALL_ROUTINE
}
struct PSTARTUP_EX_ROUTINE extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32, CLRES_CALLBACK_FUNCTION_TABLE.Ptr, CLRES_FUNCTION_TABLE.Ptr.Ptr, UInt32]
}
struct RESOURCE_MONITOR_STATE extends Int32 {
    static RmonInitializing := 0
    static RmonIdle := 1
    static RmonStartingResource := 2
    static RmonInitializingResource := 3
    static RmonOnlineResource := 4
    static RmonOfflineResource := 5
    static RmonShutdownResource := 6
    static RmonDeletingResource := 7
    static RmonIsAlivePoll := 8
    static RmonLooksAlivePoll := 9
    static RmonArbitrateResource := 10
    static RmonReleaseResource := 11
    static RmonResourceControl := 12
    static RmonResourceTypeControl := 13
    static RmonTerminateResource := 14
    static RmonDeadlocked := 15
}
struct MONITOR_STATE {
    LastUpdate : Int64
    State : RESOURCE_MONITOR_STATE
    ActiveResource : HANDLE
    ResmonStop : BOOL
}
struct POST_UPGRADE_VERSION_INFO {
    newMajorVersion : UInt32
    newUpgradeVersion : UInt32
    oldMajorVersion : UInt32
    oldUpgradeVersion : UInt32
    reserved : UInt32
}
struct CLUSTER_HEALTH_FAULT {
    Id : PWSTR
    ErrorType : UInt32
    ErrorCode : UInt32
    Description : PWSTR
    Provider : PWSTR
    Flags : UInt32
    Reserved : UInt32
}
struct CLUSTER_HEALTH_FAULT_ARRAY {
    numFaults : UInt32
    faults : CLUSTER_HEALTH_FAULT.Ptr
}
struct PRESUTIL_START_RESOURCE_SERVICE extends FunctionPointer {
    static Types := [PWSTR, SC_HANDLE.Ptr, UInt32]
}
struct PRESUTIL_VERIFY_RESOURCE_SERVICE extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PRESUTIL_STOP_RESOURCE_SERVICE extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PRESUTIL_VERIFY_SERVICE extends FunctionPointer {
    static Types := [SC_HANDLE, UInt32]
}
struct PRESUTIL_STOP_SERVICE extends FunctionPointer {
    static Types := [SC_HANDLE, UInt32]
}
struct PRESUTIL_CREATE_DIRECTORY_TREE extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PRESUTIL_IS_PATH_VALID extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct PRESUTIL_ENUM_PROPERTIES extends FunctionPointer {
    static Types := [RESUTIL_PROPERTY_ITEM.Ptr, PWSTR, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_ENUM_PRIVATE_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_ALL_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_PRIVATE_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_PROPERTY_SIZE extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_PROPERTY extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_VERIFY_PROPERTY_TABLE extends FunctionPointer {
    static Types := [RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, BOOL, Struct.Ptr, UInt32, UInt8.Ptr, UInt32]
}
struct PRESUTIL_SET_PROPERTY_TABLE extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, BOOL, Struct.Ptr, UInt32, UInt8.Ptr, UInt32]
}
struct PRESUTIL_SET_PROPERTY_TABLE_EX extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, BOOL, Struct.Ptr, UInt32, BOOL, UInt8.Ptr, UInt32]
}
struct PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt8.Ptr, Struct.Ptr, UInt32, UInt8.Ptr, UInt32]
}
struct PRESUTIL_SET_PROPERTY_PARAMETER_BLOCK_EX extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt8.Ptr, Struct.Ptr, UInt32, BOOL, UInt8.Ptr, UInt32]
}
struct PRESUTIL_SET_UNKNOWN_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32, UInt32]
}
struct PRESUTIL_GET_PROPERTIES_TO_PARAMETER_BLOCK extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, UInt8.Ptr, BOOL, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_PROPERTY_LIST_FROM_PARAMETER_BLOCK extends FunctionPointer {
    static Types := [RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32.Ptr, UInt8.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_DUP_PARAMETER_BLOCK extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt8.Ptr, RESUTIL_PROPERTY_ITEM.Ptr, UInt32]
}
struct PRESUTIL_FREE_PARAMETER_BLOCK extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt8.Ptr, RESUTIL_PROPERTY_ITEM.Ptr, "Void"]
}
struct PRESUTIL_ADD_UNKNOWN_PROPERTIES extends FunctionPointer {
    static Types := [HKEY, RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_SET_PRIVATE_PROPERTY_LIST extends FunctionPointer {
    static Types := [HKEY, Struct.Ptr, UInt32, UInt32]
}
struct PRESUTIL_VERIFY_PRIVATE_PROPERTY_LIST extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32]
}
struct PRESUTIL_DUP_STRING extends FunctionPointer {
    static Types := [PWSTR, PWSTR]
}
struct PRESUTIL_GET_BINARY_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_SZ_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR]
}
struct PRESUTIL_GET_EXPAND_SZ_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, BOOL, PWSTR]
}
struct PRESUTIL_GET_DWORD_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32.Ptr, UInt32, UInt32]
}
struct PRESUTIL_GET_QWORD_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, Int64.Ptr, Int64, UInt32]
}
struct PRESUTIL_SET_BINARY_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_SET_SZ_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_SET_EXPAND_SZ_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_SET_MULTI_SZ_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, PWSTR, UInt32, PWSTR.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_SET_DWORD_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, UInt32, UInt32.Ptr, UInt32]
}
struct PRESUTIL_SET_QWORD_VALUE extends FunctionPointer {
    static Types := [HKEY, PWSTR, Int64, Int64.Ptr, UInt32]
}
struct PRESUTIL_GET_BINARY_PROPERTY extends FunctionPointer {
    static Types := [UInt8.Ptr.Ptr, UInt32.Ptr, CLUSPROP_BINARY.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_SZ_PROPERTY extends FunctionPointer {
    static Types := [PWSTR.Ptr, CLUSPROP_SZ.Ptr, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_MULTI_SZ_PROPERTY extends FunctionPointer {
    static Types := [PWSTR.Ptr, UInt32.Ptr, CLUSPROP_SZ.Ptr, PWSTR, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_DWORD_PROPERTY extends FunctionPointer {
    static Types := [UInt32.Ptr, CLUSPROP_DWORD.Ptr, UInt32, UInt32, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_LONG_PROPERTY extends FunctionPointer {
    static Types := [Int32.Ptr, CLUSPROP_LONG.Ptr, Int32, Int32, Int32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_FILETIME_PROPERTY extends FunctionPointer {
    static Types := [FILETIME.Ptr, CLUSPROP_FILETIME.Ptr, FILETIME, FILETIME, FILETIME, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_ENVIRONMENT_WITH_NET_NAME extends FunctionPointer {
    static Types := [HRESOURCE, Struct.Ptr]
}
struct PRESUTIL_FREE_ENVIRONMENT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PRESUTIL_EXPAND_ENVIRONMENT_STRINGS extends FunctionPointer {
    static Types := [PWSTR, PWSTR]
}
struct PRESUTIL_SET_RESOURCE_SERVICE_ENVIRONMENT extends FunctionPointer {
    static Types := [PWSTR, HRESOURCE, PLOG_EVENT_ROUTINE, IntPtr, UInt32]
}
struct PRESUTIL_REMOVE_RESOURCE_SERVICE_ENVIRONMENT extends FunctionPointer {
    static Types := [PWSTR, PLOG_EVENT_ROUTINE, IntPtr, UInt32]
}
struct PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS extends FunctionPointer {
    static Types := [PWSTR, SC_HANDLE, SC_HANDLE.Ptr, PLOG_EVENT_ROUTINE, IntPtr, UInt32]
}
struct PRESUTIL_FIND_SZ_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_FIND_EXPAND_SZ_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_FIND_EXPANDED_SZ_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, PWSTR.Ptr, UInt32]
}
struct PRESUTIL_FIND_DWORD_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, UInt32.Ptr, UInt32]
}
struct PRESUTIL_FIND_BINARY_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_FIND_MULTI_SZ_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, PWSTR.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_FIND_LONG_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, Int32.Ptr, UInt32]
}
struct PRESUTIL_FIND_ULARGEINTEGER_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, Int64.Ptr, UInt32]
}
struct PRESUTIL_FIND_FILETIME_PROPERTY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, FILETIME.Ptr, UInt32]
}
struct CLUS_WORKER {
    hThread : HANDLE
    Terminate : BOOL
}
struct PWORKER_START_ROUTINE extends FunctionPointer {
    static Types := [CLUS_WORKER.Ptr, Struct.Ptr, UInt32]
}
struct PCLUSAPI_CLUS_WORKER_CREATE extends FunctionPointer {
    static Types := [CLUS_WORKER.Ptr, PWORKER_START_ROUTINE, Struct.Ptr, UInt32]
}
struct PCLUSAPIClusWorkerCheckTerminate extends FunctionPointer {
    static Types := [CLUS_WORKER.Ptr, BOOL]
}
struct PCLUSAPI_CLUS_WORKER_TERMINATE extends FunctionPointer {
    static Types := [CLUS_WORKER.Ptr, "Void"]
}
struct LPRESOURCE_CALLBACK extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, Struct.Ptr, UInt32]
}
struct LPRESOURCE_CALLBACK_EX extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE, HRESOURCE, Struct.Ptr, UInt32]
}
struct LPGROUP_CALLBACK_EX extends FunctionPointer {
    static Types := [HCLUSTER, HGROUP, HGROUP, Struct.Ptr, UInt32]
}
struct LPNODE_CALLBACK extends FunctionPointer {
    static Types := [HCLUSTER, HNODE, CLUSTER_NODE_STATE, Struct.Ptr, UInt32]
}
struct PRESUTIL_RESOURCES_EQUAL extends FunctionPointer {
    static Types := [HRESOURCE, HRESOURCE, BOOL]
}
struct PRESUTIL_RESOURCE_TYPES_EQUAL extends FunctionPointer {
    static Types := [PWSTR, HRESOURCE, BOOL]
}
struct PRESUTIL_IS_RESOURCE_CLASS_EQUAL extends FunctionPointer {
    static Types := [CLUS_RESOURCE_CLASS_INFO.Ptr, HRESOURCE, BOOL]
}
struct PRESUTIL_ENUM_RESOURCES extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, LPRESOURCE_CALLBACK, Struct.Ptr, UInt32]
}
struct PRESUTIL_ENUM_RESOURCES_EX extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE, PWSTR, LPRESOURCE_CALLBACK_EX, Struct.Ptr, UInt32]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY extends FunctionPointer {
    static Types := [HANDLE, PWSTR, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME extends FunctionPointer {
    static Types := [HCLUSTER, HANDLE, PWSTR, BOOL, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS extends FunctionPointer {
    static Types := [HCLUSTER, HANDLE, CLUS_RESOURCE_CLASS_INFO.Ptr, BOOL, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY extends FunctionPointer {
    static Types := [PWSTR, PWSTR, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENTIP_ADDRESS_PROPS extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PRESUTIL_FIND_DEPENDENT_DISK_RESOURCE_DRIVE_LETTER extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE, PWSTR, UInt32.Ptr, UInt32]
}
struct PRESUTIL_TERMINATE_SERVICE_PROCESS_FROM_RES_DLL extends FunctionPointer {
    static Types := [UInt32, BOOL, UInt32.Ptr, PLOG_EVENT_ROUTINE, IntPtr, UInt32]
}
struct PRESUTIL_GET_PROPERTY_FORMATS extends FunctionPointer {
    static Types := [RESUTIL_PROPERTY_ITEM.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PRESUTIL_GET_CORE_CLUSTER_RESOURCES extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE.Ptr, HRESOURCE.Ptr, HRESOURCE.Ptr, UInt32]
}
struct PRESUTIL_GET_RESOURCE_NAME extends FunctionPointer {
    static Types := [HRESOURCE, PWSTR, UInt32.Ptr, UInt32]
}
struct CLUSTER_ROLE extends Int32 {
    static ClusterRoleDHCP := 0
    static ClusterRoleDTC := 1
    static ClusterRoleFileServer := 2
    static ClusterRoleGenericApplication := 3
    static ClusterRoleGenericScript := 4
    static ClusterRoleGenericService := 5
    static ClusterRoleISCSINameServer := 6
    static ClusterRoleMSMQ := 7
    static ClusterRoleNFS := 8
    static ClusterRolePrintServer := 9
    static ClusterRoleStandAloneNamespaceServer := 10
    static ClusterRoleVolumeShadowCopyServiceTask := 11
    static ClusterRoleWINS := 12
    static ClusterRoleTaskScheduler := 13
    static ClusterRoleNetworkFileSystem := 14
    static ClusterRoleDFSReplicatedFolder := 15
    static ClusterRoleDistributedFileSystem := 16
    static ClusterRoleDistributedNetworkName := 17
    static ClusterRoleFileShare := 18
    static ClusterRoleFileShareWitness := 19
    static ClusterRoleHardDisk := 20
    static ClusterRoleIPAddress := 21
    static ClusterRoleIPV6Address := 22
    static ClusterRoleIPV6TunnelAddress := 23
    static ClusterRoleISCSITargetServer := 24
    static ClusterRoleNetworkName := 25
    static ClusterRolePhysicalDisk := 26
    static ClusterRoleSODAFileServer := 27
    static ClusterRoleStoragePool := 28
    static ClusterRoleVirtualMachine := 29
    static ClusterRoleVirtualMachineConfiguration := 30
    static ClusterRoleVirtualMachineReplicaBroker := 31
    static ClusterRoleKeyValueStore := 32
}
struct CLUSTER_ROLE_STATE extends Int32 {
    static ClusterRoleUnknown := -1
    static ClusterRoleClustered := 0
    static ClusterRoleUnclustered := 1
}
struct PCLUSTER_IS_PATH_ON_SHARED_VOLUME extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct PCLUSTER_GET_VOLUME_PATH_NAME extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, BOOL]
}
struct PCLUSTER_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, BOOL]
}
struct PCLUSTER_PREPARE_SHARED_VOLUME_FOR_BACKUP extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32.Ptr, PWSTR, UInt32.Ptr, UInt32]
}
struct PCLUSTER_CLEAR_BACKUP_STATE_FOR_SHARED_VOLUME extends FunctionPointer {
    static Types := [PWSTR, UInt32]
}
struct PRESUTIL_SET_RESOURCE_SERVICE_START_PARAMETERS_EX extends FunctionPointer {
    static Types := [PWSTR, SC_HANDLE, SC_HANDLE.Ptr, UInt32, PLOG_EVENT_ROUTINE, IntPtr, UInt32]
}
struct PRESUTIL_ENUM_RESOURCES_EX2 extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE, PWSTR, LPRESOURCE_CALLBACK_EX, Struct.Ptr, UInt32, UInt32]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY_EX extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_NAME_EX extends FunctionPointer {
    static Types := [HCLUSTER, HANDLE, PWSTR, BOOL, UInt32, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_DEPENDENCY_BY_CLASS_EX extends FunctionPointer {
    static Types := [HCLUSTER, HANDLE, CLUS_RESOURCE_CLASS_INFO.Ptr, BOOL, UInt32, HRESOURCE]
}
struct PRESUTIL_GET_RESOURCE_NAME_DEPENDENCY_EX extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, HRESOURCE]
}
struct PRESUTIL_GET_CORE_CLUSTER_RESOURCES_EX extends FunctionPointer {
    static Types := [HCLUSTER, HRESOURCE.Ptr, HRESOURCE.Ptr, HRESOURCE.Ptr, UInt32, UInt32]
}
struct POPEN_CLUSTER_CRYPT_PROVIDER extends FunctionPointer {
    static Types := [PWSTR, Int8.Ptr, UInt32, UInt32, HCLUSCRYPTPROVIDER]
}
struct POPEN_CLUSTER_CRYPT_PROVIDEREX extends FunctionPointer {
    static Types := [PWSTR, PWSTR, Int8.Ptr, UInt32, UInt32, HCLUSCRYPTPROVIDER]
}
struct PCLOSE_CLUSTER_CRYPT_PROVIDER extends FunctionPointer {
    static Types := [HCLUSCRYPTPROVIDER, UInt32]
}
struct PCLUSTER_ENCRYPT extends FunctionPointer {
    static Types := [HCLUSCRYPTPROVIDER, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PCLUSTER_DECRYPT extends FunctionPointer {
    static Types := [HCLUSCRYPTPROVIDER, UInt8.Ptr, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFREE_CLUSTER_CRYPT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PRES_UTIL_VERIFY_SHUTDOWN_SAFE extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32.Ptr, UInt32]
}
struct PaxosTagCStruct {
    __padding__PaxosTagVtable : Int64
    __padding__NextEpochVtable : Int64
    __padding__NextEpoch_DateTimeVtable : Int64
    NextEpoch_DateTime_ticks : Int64
    NextEpoch_Value : Int32
    __padding__BoundryNextEpoch : UInt32
    __padding__EpochVtable : Int64
    __padding__Epoch_DateTimeVtable : Int64
    Epoch_DateTime_ticks : Int64
    Epoch_Value : Int32
    __padding__BoundryEpoch : UInt32
    Sequence : Int32
    __padding__BoundrySequence : UInt32
}
struct WitnessTagUpdateHelper {
    Version : Int32
    paxosToSet : PaxosTagCStruct
    paxosToValidate : PaxosTagCStruct
}
struct WitnessTagHelper {
    Version : Int32
    paxosToValidate : PaxosTagCStruct
}
struct PREGISTER_APPINSTANCE extends FunctionPointer {
    static Types := [HANDLE, GUID.Ptr, BOOL, UInt32]
}
struct PREGISTER_APPINSTANCE_VERSION extends FunctionPointer {
    static Types := [GUID.Ptr, Int64, Int64, UInt32]
}
struct PQUERY_APPINSTANCE_VERSION extends FunctionPointer {
    static Types := [GUID.Ptr, Int64.Ptr, Int64.Ptr, NTSTATUS.Ptr, UInt32]
}
struct PRESET_ALL_APPINSTANCE_VERSIONS extends FunctionPointer {
    static Types := [UInt32]
}
struct SET_APP_INSTANCE_CSV_FLAGS extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, UInt32]
}
struct CLUADMEX_OBJECT_TYPE extends Int32 {
    static CLUADMEX_OT_NONE := 0
    static CLUADMEX_OT_CLUSTER := 1
    static CLUADMEX_OT_NODE := 2
    static CLUADMEX_OT_GROUP := 3
    static CLUADMEX_OT_RESOURCE := 4
    static CLUADMEX_OT_RESOURCETYPE := 5
    static CLUADMEX_OT_NETWORK := 6
    static CLUADMEX_OT_NETINTERFACE := 7
}
struct IGetClusterUIInfo extends IUnknown {
    static IID := "{97DEDE50-FC6B-11CF-B5F5-00A0C90AB505}"
    GetClusterName(lpszName, pcchName)
      => ComCall(3, this.p, BSTR, lpszName, Int32.Ptr, pcchName)
    GetLocale()
      => ComCall(4, this.p, UInt32)
    GetFont()
      => ComCall(5, this.p, HFONT)
    GetIcon()
      => ComCall(6, this.p, HICON)
}
struct IGetClusterDataInfo extends IUnknown {
    static IID := "{97DEDE51-FC6B-11CF-B5F5-00A0C90AB505}"
    GetClusterName(lpszName, pcchName)
      => ComCall(3, this.p, BSTR, lpszName, Int32.Ptr, pcchName)
    GetClusterHandle()
      => ComCall(4, this.p, HCLUSTER)
    GetObjectCount()
      => ComCall(5, this.p, Int32)
}
struct IGetClusterObjectInfo extends IUnknown {
    static IID := "{97DEDE52-FC6B-11CF-B5F5-00A0C90AB505}"
    GetObjectName(lObjIndex, lpszName, pcchName)
      => ComCall(3, this.p, Int32, lObjIndex, BSTR, lpszName, Int32.Ptr, pcchName)
    GetObjectType(lObjIndex)
      => ComCall(4, this.p, Int32, lObjIndex, CLUADMEX_OBJECT_TYPE)
}
struct IGetClusterNodeInfo extends IUnknown {
    static IID := "{97DEDE53-FC6B-11CF-B5F5-00A0C90AB505}"
    GetNodeHandle(lObjIndex)
      => ComCall(3, this.p, Int32, lObjIndex, HNODE)
}
struct IGetClusterGroupInfo extends IUnknown {
    static IID := "{97DEDE54-FC6B-11CF-B5F5-00A0C90AB505}"
    GetGroupHandle(lObjIndex)
      => ComCall(3, this.p, Int32, lObjIndex, HGROUP)
}
struct IGetClusterResourceInfo extends IUnknown {
    static IID := "{97DEDE55-FC6B-11CF-B5F5-00A0C90AB505}"
    GetResourceHandle(lObjIndex)
      => ComCall(3, this.p, Int32, lObjIndex, HRESOURCE)
    GetResourceTypeName(lObjIndex, lpszResTypeName, pcchResTypeName)
      => ComCall(4, this.p, Int32, lObjIndex, BSTR, lpszResTypeName, Int32.Ptr, pcchResTypeName)
    GetResourceNetworkName(lObjIndex, lpszNetName, pcchNetName)
      => ComCall(5, this.p, Int32, lObjIndex, BSTR, lpszNetName, UInt32.Ptr, pcchNetName, BOOL)
}
struct IGetClusterNetworkInfo extends IUnknown {
    static IID := "{97DEDE56-FC6B-11CF-B5F5-00A0C90AB505}"
    GetNetworkHandle(lObjIndex)
      => ComCall(3, this.p, Int32, lObjIndex, HNETWORK)
}
struct IGetClusterNetInterfaceInfo extends IUnknown {
    static IID := "{97DEDE57-FC6B-11CF-B5F5-00A0C90AB505}"
    GetNetInterfaceHandle(lObjIndex)
      => ComCall(3, this.p, Int32, lObjIndex, HNETINTERFACE)
}
struct IWCPropertySheetCallback extends IUnknown {
    static IID := "{97DEDE60-FC6B-11CF-B5F5-00A0C90AB505}"
    AddPropertySheetPage(hpage)
      => ComCall(3, this.p, Int32.Ptr, hpage)
}
struct IWEExtendPropertySheet extends IUnknown {
    static IID := "{97DEDE61-FC6B-11CF-B5F5-00A0C90AB505}"
    CreatePropertySheetPages(piData, piCallback)
      => ComCall(3, this.p, IUnknown, piData, IWCPropertySheetCallback, piCallback)
}
struct IWCWizardCallback extends IUnknown {
    static IID := "{97DEDE62-FC6B-11CF-B5F5-00A0C90AB505}"
    AddWizardPage(hpage)
      => ComCall(3, this.p, Int32.Ptr, hpage)
    EnableNext(hpage, bEnable)
      => ComCall(4, this.p, Int32.Ptr, hpage, BOOL, bEnable)
}
struct IWEExtendWizard extends IUnknown {
    static IID := "{97DEDE63-FC6B-11CF-B5F5-00A0C90AB505}"
    CreateWizardPages(piData, piCallback)
      => ComCall(3, this.p, IUnknown, piData, IWCWizardCallback, piCallback)
}
struct IWCContextMenuCallback extends IUnknown {
    static IID := "{97DEDE64-FC6B-11CF-B5F5-00A0C90AB505}"
    AddExtensionMenuItem(lpszName, lpszStatusBarText, nCommandID, nSubmenuCommandID, uFlags)
      => ComCall(3, this.p, BSTR, lpszName, BSTR, lpszStatusBarText, UInt32, nCommandID, UInt32, nSubmenuCommandID, UInt32, uFlags)
}
struct IWEExtendContextMenu extends IUnknown {
    static IID := "{97DEDE65-FC6B-11CF-B5F5-00A0C90AB505}"
    AddContextMenuItems(piData, piCallback)
      => ComCall(3, this.p, IUnknown, piData, IWCContextMenuCallback, piCallback)
}
struct IWEInvokeCommand extends IUnknown {
    static IID := "{97DEDE66-FC6B-11CF-B5F5-00A0C90AB505}"
    InvokeCommand(nCommandID, piData)
      => ComCall(3, this.p, UInt32, nCommandID, IUnknown, piData)
}
struct IWCWizard97Callback extends IUnknown {
    static IID := "{97DEDE67-FC6B-11CF-B5F5-00A0C90AB505}"
    AddWizard97Page(hpage)
      => ComCall(3, this.p, Int32.Ptr, hpage)
    EnableNext(hpage, bEnable)
      => ComCall(4, this.p, Int32.Ptr, hpage, BOOL, bEnable)
}
struct IWEExtendWizard97 extends IUnknown {
    static IID := "{97DEDE68-FC6B-11CF-B5F5-00A0C90AB505}"
    CreateWizard97Pages(piData, piCallback)
      => ComCall(3, this.p, IUnknown, piData, IWCWizard97Callback, piCallback)
}
struct ISClusApplication extends IDispatch {
    static IID := "{F2E606E6-2631-11D1-89F1-00A0C90D061E}"
    get_DomainNames(ppDomains)
      => ComCall(7, this.p, ISDomainNames.Ptr, ppDomains)
    get_ClusterNames(bstrDomainName, ppClusters)
      => ComCall(8, this.p, BSTR, bstrDomainName, ISClusterNames.Ptr, ppClusters)
    OpenCluster(bstrClusterName, pCluster)
      => ComCall(9, this.p, BSTR, bstrClusterName, ISCluster.Ptr, pCluster)
}
struct ISDomainNames extends IDispatch {
    static IID := "{F2E606E2-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, pbstrDomainName)
      => ComCall(10, this.p, VARIANT, varIndex, BSTR.Ptr, pbstrDomainName)
}
struct ISClusterNames extends IDispatch {
    static IID := "{F2E606EC-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, pbstrClusterName)
      => ComCall(10, this.p, VARIANT, varIndex, BSTR.Ptr, pbstrClusterName)
    get_DomainName(pbstrDomainName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrDomainName)
}
struct ISClusRefObject extends IDispatch {
    static IID := "{F2E60702-2631-11D1-89F1-00A0C90D061E}"
    get_Handle(phandle)
      => ComCall(7, this.p, IntPtr.Ptr, phandle)
}
struct ISClusVersion extends IDispatch {
    static IID := "{F2E60716-2631-11D1-89F1-00A0C90D061E}"
    get_Name(pbstrClusterName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrClusterName)
    get_MajorVersion(pnMajorVersion)
      => ComCall(8, this.p, Int32.Ptr, pnMajorVersion)
    get_MinorVersion(pnMinorVersion)
      => ComCall(9, this.p, Int32.Ptr, pnMinorVersion)
    get_BuildNumber(pnBuildNumber)
      => ComCall(10, this.p, Int16.Ptr, pnBuildNumber)
    get_VendorId(pbstrVendorId)
      => ComCall(11, this.p, BSTR.Ptr, pbstrVendorId)
    get_CSDVersion(pbstrCSDVersion)
      => ComCall(12, this.p, BSTR.Ptr, pbstrCSDVersion)
    get_ClusterHighestVersion(pnClusterHighestVersion)
      => ComCall(13, this.p, Int32.Ptr, pnClusterHighestVersion)
    get_ClusterLowestVersion(pnClusterLowestVersion)
      => ComCall(14, this.p, Int32.Ptr, pnClusterLowestVersion)
    get_Flags(pnFlags)
      => ComCall(15, this.p, Int32.Ptr, pnFlags)
    get_MixedVersion(pvarMixedVersion)
      => ComCall(16, this.p, VARIANT.Ptr, pvarMixedVersion)
}
struct ISCluster extends IDispatch {
    static IID := "{F2E606E4-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Handle(phandle)
      => ComCall(11, this.p, IntPtr.Ptr, phandle)
    Open(bstrClusterName)
      => ComCall(12, this.p, BSTR, bstrClusterName)
    get_Name(pbstrName)
      => ComCall(13, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrClusterName)
      => ComCall(14, this.p, BSTR, bstrClusterName)
    get_Version(ppClusVersion)
      => ComCall(15, this.p, ISClusVersion.Ptr, ppClusVersion)
    put_QuorumResource(pClusterResource)
      => ComCall(16, this.p, ISClusResource, pClusterResource)
    get_QuorumResource(pClusterResource)
      => ComCall(17, this.p, ISClusResource.Ptr, pClusterResource)
    get_QuorumLogSize(pnLogSize)
      => ComCall(18, this.p, Int32.Ptr, pnLogSize)
    put_QuorumLogSize(nLogSize)
      => ComCall(19, this.p, Int32, nLogSize)
    get_QuorumPath(ppPath)
      => ComCall(20, this.p, BSTR.Ptr, ppPath)
    put_QuorumPath(pPath)
      => ComCall(21, this.p, BSTR, pPath)
    get_Nodes(ppNodes)
      => ComCall(22, this.p, ISClusNodes.Ptr, ppNodes)
    get_ResourceGroups(ppClusterResourceGroups)
      => ComCall(23, this.p, ISClusResGroups.Ptr, ppClusterResourceGroups)
    get_Resources(ppClusterResources)
      => ComCall(24, this.p, ISClusResources.Ptr, ppClusterResources)
    get_ResourceTypes(ppResourceTypes)
      => ComCall(25, this.p, ISClusResTypes.Ptr, ppResourceTypes)
    get_Networks(ppNetworks)
      => ComCall(26, this.p, ISClusNetworks.Ptr, ppNetworks)
    get_NetInterfaces(ppNetInterfaces)
      => ComCall(27, this.p, ISClusNetInterfaces.Ptr, ppNetInterfaces)
}
struct ISClusNode extends IDispatch {
    static IID := "{F2E606F8-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Name(pbstrName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrName)
    get_Handle(phandle)
      => ComCall(12, this.p, IntPtr.Ptr, phandle)
    get_NodeID(pbstrNodeID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrNodeID)
    get_State(dwState)
      => ComCall(14, this.p, CLUSTER_NODE_STATE.Ptr, dwState)
    Pause()
      => ComCall(15, this.p)
    Resume()
      => ComCall(16, this.p)
    Evict()
      => ComCall(17, this.p)
    get_ResourceGroups(ppResourceGroups)
      => ComCall(18, this.p, ISClusResGroups.Ptr, ppResourceGroups)
    get_Cluster(ppCluster)
      => ComCall(19, this.p, ISCluster.Ptr, ppCluster)
    get_NetInterfaces(ppClusNetInterfaces)
      => ComCall(20, this.p, ISClusNodeNetInterfaces.Ptr, ppClusNetInterfaces)
}
struct ISClusNodes extends IDispatch {
    static IID := "{F2E606FA-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppNode)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNode.Ptr, ppNode)
}
struct ISClusNetwork extends IDispatch {
    static IID := "{F2E606F2-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Handle(phandle)
      => ComCall(11, this.p, IntPtr.Ptr, phandle)
    get_Name(pbstrName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrNetworkName)
      => ComCall(13, this.p, BSTR, bstrNetworkName)
    get_NetworkID(pbstrNetworkID)
      => ComCall(14, this.p, BSTR.Ptr, pbstrNetworkID)
    get_State(dwState)
      => ComCall(15, this.p, CLUSTER_NETWORK_STATE.Ptr, dwState)
    get_NetInterfaces(ppClusNetInterfaces)
      => ComCall(16, this.p, ISClusNetworkNetInterfaces.Ptr, ppClusNetInterfaces)
    get_Cluster(ppCluster)
      => ComCall(17, this.p, ISCluster.Ptr, ppCluster)
}
struct ISClusNetworks extends IDispatch {
    static IID := "{F2E606F4-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusNetwork)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNetwork.Ptr, ppClusNetwork)
}
struct ISClusNetInterface extends IDispatch {
    static IID := "{F2E606EE-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Name(pbstrName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrName)
    get_Handle(phandle)
      => ComCall(12, this.p, IntPtr.Ptr, phandle)
    get_State(dwState)
      => ComCall(13, this.p, CLUSTER_NETINTERFACE_STATE.Ptr, dwState)
    get_Cluster(ppCluster)
      => ComCall(14, this.p, ISCluster.Ptr, ppCluster)
}
struct ISClusNetInterfaces extends IDispatch {
    static IID := "{F2E606F0-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusNetInterface)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNetInterface.Ptr, ppClusNetInterface)
}
struct ISClusNodeNetInterfaces extends IDispatch {
    static IID := "{F2E606FC-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusNetInterface)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNetInterface.Ptr, ppClusNetInterface)
}
struct ISClusNetworkNetInterfaces extends IDispatch {
    static IID := "{F2E606F6-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusNetInterface)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNetInterface.Ptr, ppClusNetInterface)
}
struct ISClusResGroup extends IDispatch {
    static IID := "{F2E60706-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Handle(phandle)
      => ComCall(11, this.p, IntPtr.Ptr, phandle)
    get_Name(pbstrName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrGroupName)
      => ComCall(13, this.p, BSTR, bstrGroupName)
    get_State(dwState)
      => ComCall(14, this.p, CLUSTER_GROUP_STATE.Ptr, dwState)
    get_OwnerNode(ppOwnerNode)
      => ComCall(15, this.p, ISClusNode.Ptr, ppOwnerNode)
    get_Resources(ppClusterGroupResources)
      => ComCall(16, this.p, ISClusResGroupResources.Ptr, ppClusterGroupResources)
    get_PreferredOwnerNodes(ppOwnerNodes)
      => ComCall(17, this.p, ISClusResGroupPreferredOwnerNodes.Ptr, ppOwnerNodes)
    Delete()
      => ComCall(18, this.p)
    Online(varTimeout, varNode, pvarPending)
      => ComCall(19, this.p, VARIANT, varTimeout, VARIANT, varNode, VARIANT.Ptr, pvarPending)
    Move(varTimeout, varNode, pvarPending)
      => ComCall(20, this.p, VARIANT, varTimeout, VARIANT, varNode, VARIANT.Ptr, pvarPending)
    Offline(varTimeout, pvarPending)
      => ComCall(21, this.p, VARIANT, varTimeout, VARIANT.Ptr, pvarPending)
    get_Cluster(ppCluster)
      => ComCall(22, this.p, ISCluster.Ptr, ppCluster)
}
struct ISClusResGroups extends IDispatch {
    static IID := "{F2E60708-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResGroup)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResGroup.Ptr, ppClusResGroup)
    CreateItem(bstrResourceGroupName, ppResourceGroup)
      => ComCall(11, this.p, BSTR, bstrResourceGroupName, ISClusResGroup.Ptr, ppResourceGroup)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusResource extends IDispatch {
    static IID := "{F2E6070A-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Handle(phandle)
      => ComCall(11, this.p, IntPtr.Ptr, phandle)
    get_Name(pbstrName)
      => ComCall(12, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrResourceName)
      => ComCall(13, this.p, BSTR, bstrResourceName)
    get_State(dwState)
      => ComCall(14, this.p, CLUSTER_RESOURCE_STATE.Ptr, dwState)
    get_CoreFlag(dwCoreFlag)
      => ComCall(15, this.p, CLUS_FLAGS.Ptr, dwCoreFlag)
    BecomeQuorumResource(bstrDevicePath, lMaxLogSize)
      => ComCall(16, this.p, BSTR, bstrDevicePath, Int32, lMaxLogSize)
    Delete()
      => ComCall(17, this.p)
    Fail()
      => ComCall(18, this.p)
    Online(nTimeout, pvarPending)
      => ComCall(19, this.p, Int32, nTimeout, VARIANT.Ptr, pvarPending)
    Offline(nTimeout, pvarPending)
      => ComCall(20, this.p, Int32, nTimeout, VARIANT.Ptr, pvarPending)
    ChangeResourceGroup(pResourceGroup)
      => ComCall(21, this.p, ISClusResGroup, pResourceGroup)
    AddResourceNode(pNode)
      => ComCall(22, this.p, ISClusNode, pNode)
    RemoveResourceNode(pNode)
      => ComCall(23, this.p, ISClusNode, pNode)
    CanResourceBeDependent(pResource, pvarDependent)
      => ComCall(24, this.p, ISClusResource, pResource, VARIANT.Ptr, pvarDependent)
    get_PossibleOwnerNodes(ppOwnerNodes)
      => ComCall(25, this.p, ISClusResPossibleOwnerNodes.Ptr, ppOwnerNodes)
    get_Dependencies(ppResDependencies)
      => ComCall(26, this.p, ISClusResDependencies.Ptr, ppResDependencies)
    get_Dependents(ppResDependents)
      => ComCall(27, this.p, ISClusResDependents.Ptr, ppResDependents)
    get_Group(ppResGroup)
      => ComCall(28, this.p, ISClusResGroup.Ptr, ppResGroup)
    get_OwnerNode(ppOwnerNode)
      => ComCall(29, this.p, ISClusNode.Ptr, ppOwnerNode)
    get_Cluster(ppCluster)
      => ComCall(30, this.p, ISCluster.Ptr, ppCluster)
    get_ClassInfo(prcClassInfo)
      => ComCall(31, this.p, CLUSTER_RESOURCE_CLASS.Ptr, prcClassInfo)
    get_Disk(ppDisk)
      => ComCall(32, this.p, ISClusDisk.Ptr, ppDisk)
    get_RegistryKeys(ppRegistryKeys)
      => ComCall(33, this.p, ISClusRegistryKeys.Ptr, ppRegistryKeys)
    get_CryptoKeys(ppCryptoKeys)
      => ComCall(34, this.p, ISClusCryptoKeys.Ptr, ppCryptoKeys)
    get_TypeName(pbstrTypeName)
      => ComCall(35, this.p, BSTR.Ptr, pbstrTypeName)
    get_Type(ppResourceType)
      => ComCall(36, this.p, ISClusResType.Ptr, ppResourceType)
    get_MaintenanceMode(pbMaintenanceMode)
      => ComCall(37, this.p, BOOL.Ptr, pbMaintenanceMode)
    put_MaintenanceMode(bMaintenanceMode)
      => ComCall(38, this.p, BOOL, bMaintenanceMode)
}
struct ISClusResDependencies extends IDispatch {
    static IID := "{F2E60704-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResource)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResource.Ptr, ppClusResource)
    CreateItem(bstrResourceName, bstrResourceType, dwFlags, ppClusterResource)
      => ComCall(11, this.p, BSTR, bstrResourceName, BSTR, bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS, dwFlags, ISClusResource.Ptr, ppClusterResource)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
    AddItem(pResource)
      => ComCall(13, this.p, ISClusResource, pResource)
    RemoveItem(varIndex)
      => ComCall(14, this.p, VARIANT, varIndex)
}
struct ISClusResGroupResources extends IDispatch {
    static IID := "{F2E606EA-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResource)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResource.Ptr, ppClusResource)
    CreateItem(bstrResourceName, bstrResourceType, dwFlags, ppClusterResource)
      => ComCall(11, this.p, BSTR, bstrResourceName, BSTR, bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS, dwFlags, ISClusResource.Ptr, ppClusterResource)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusResTypeResources extends IDispatch {
    static IID := "{F2E60714-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResource)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResource.Ptr, ppClusResource)
    CreateItem(bstrResourceName, bstrGroupName, dwFlags, ppClusterResource)
      => ComCall(11, this.p, BSTR, bstrResourceName, BSTR, bstrGroupName, CLUSTER_RESOURCE_CREATE_FLAGS, dwFlags, ISClusResource.Ptr, ppClusterResource)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusResources extends IDispatch {
    static IID := "{F2E6070C-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResource)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResource.Ptr, ppClusResource)
    CreateItem(bstrResourceName, bstrResourceType, bstrGroupName, dwFlags, ppClusterResource)
      => ComCall(11, this.p, BSTR, bstrResourceName, BSTR, bstrResourceType, BSTR, bstrGroupName, CLUSTER_RESOURCE_CREATE_FLAGS, dwFlags, ISClusResource.Ptr, ppClusterResource)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusResGroupPreferredOwnerNodes extends IDispatch {
    static IID := "{F2E606E8-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppNode)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNode.Ptr, ppNode)
    InsertItem(pNode, nPosition)
      => ComCall(11, this.p, ISClusNode, pNode, Int32, nPosition)
    RemoveItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
    get_Modified(pvarModified)
      => ComCall(13, this.p, VARIANT.Ptr, pvarModified)
    SaveChanges()
      => ComCall(14, this.p)
    AddItem(pNode)
      => ComCall(15, this.p, ISClusNode, pNode)
}
struct ISClusResPossibleOwnerNodes extends IDispatch {
    static IID := "{F2E6070E-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppNode)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNode.Ptr, ppNode)
    AddItem(pNode)
      => ComCall(11, this.p, ISClusNode, pNode)
    RemoveItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
    get_Modified(pvarModified)
      => ComCall(13, this.p, VARIANT.Ptr, pvarModified)
}
struct ISClusResTypePossibleOwnerNodes extends IDispatch {
    static IID := "{F2E60718-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppNode)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusNode.Ptr, ppNode)
}
struct ISClusResType extends IDispatch {
    static IID := "{F2E60710-2631-11D1-89F1-00A0C90D061E}"
    get_CommonProperties(ppProperties)
      => ComCall(7, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateProperties(ppProperties)
      => ComCall(8, this.p, ISClusProperties.Ptr, ppProperties)
    get_CommonROProperties(ppProperties)
      => ComCall(9, this.p, ISClusProperties.Ptr, ppProperties)
    get_PrivateROProperties(ppProperties)
      => ComCall(10, this.p, ISClusProperties.Ptr, ppProperties)
    get_Name(pbstrName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrName)
    Delete()
      => ComCall(12, this.p)
    get_Cluster(ppCluster)
      => ComCall(13, this.p, ISCluster.Ptr, ppCluster)
    get_Resources(ppClusterResTypeResources)
      => ComCall(14, this.p, ISClusResTypeResources.Ptr, ppClusterResTypeResources)
    get_PossibleOwnerNodes(ppOwnerNodes)
      => ComCall(15, this.p, ISClusResTypePossibleOwnerNodes.Ptr, ppOwnerNodes)
    get_AvailableDisks(ppAvailableDisks)
      => ComCall(16, this.p, ISClusDisks.Ptr, ppAvailableDisks)
}
struct ISClusResTypes extends IDispatch {
    static IID := "{F2E60712-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResType)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResType.Ptr, ppClusResType)
    CreateItem(bstrResourceTypeName, bstrDisplayName, bstrResourceTypeDll, dwLooksAlivePollInterval, dwIsAlivePollInterval, ppResourceType)
      => ComCall(11, this.p, BSTR, bstrResourceTypeName, BSTR, bstrDisplayName, BSTR, bstrResourceTypeDll, Int32, dwLooksAlivePollInterval, Int32, dwIsAlivePollInterval, ISClusResType.Ptr, ppResourceType)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusProperty extends IDispatch {
    static IID := "{F2E606FE-2631-11D1-89F1-00A0C90D061E}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    get_Length(pLength)
      => ComCall(8, this.p, Int32.Ptr, pLength)
    get_ValueCount(pCount)
      => ComCall(9, this.p, Int32.Ptr, pCount)
    get_Values(ppClusterPropertyValues)
      => ComCall(10, this.p, ISClusPropertyValues.Ptr, ppClusterPropertyValues)
    get_Value(pvarValue)
      => ComCall(11, this.p, VARIANT.Ptr, pvarValue)
    put_Value(varValue)
      => ComCall(12, this.p, VARIANT, varValue)
    get_Type(pType)
      => ComCall(13, this.p, CLUSTER_PROPERTY_TYPE.Ptr, pType)
    put_Type(Type)
      => ComCall(14, this.p, CLUSTER_PROPERTY_TYPE, Type)
    get_Format(pFormat)
      => ComCall(15, this.p, CLUSTER_PROPERTY_FORMAT.Ptr, pFormat)
    put_Format(Format)
      => ComCall(16, this.p, CLUSTER_PROPERTY_FORMAT, Format)
    get_ReadOnly(pvarReadOnly)
      => ComCall(17, this.p, VARIANT.Ptr, pvarReadOnly)
    get_Private(pvarPrivate)
      => ComCall(18, this.p, VARIANT.Ptr, pvarPrivate)
    get_Common(pvarCommon)
      => ComCall(19, this.p, VARIANT.Ptr, pvarCommon)
    get_Modified(pvarModified)
      => ComCall(20, this.p, VARIANT.Ptr, pvarModified)
    UseDefaultValue()
      => ComCall(21, this.p)
}
struct ISClusPropertyValue extends IDispatch {
    static IID := "{F2E6071A-2631-11D1-89F1-00A0C90D061E}"
    get_Value(pvarValue)
      => ComCall(7, this.p, VARIANT.Ptr, pvarValue)
    put_Value(varValue)
      => ComCall(8, this.p, VARIANT, varValue)
    get_Type(pType)
      => ComCall(9, this.p, CLUSTER_PROPERTY_TYPE.Ptr, pType)
    put_Type(Type)
      => ComCall(10, this.p, CLUSTER_PROPERTY_TYPE, Type)
    get_Format(pFormat)
      => ComCall(11, this.p, CLUSTER_PROPERTY_FORMAT.Ptr, pFormat)
    put_Format(Format)
      => ComCall(12, this.p, CLUSTER_PROPERTY_FORMAT, Format)
    get_Length(pLength)
      => ComCall(13, this.p, Int32.Ptr, pLength)
    get_DataCount(pCount)
      => ComCall(14, this.p, Int32.Ptr, pCount)
    get_Data(ppClusterPropertyValueData)
      => ComCall(15, this.p, ISClusPropertyValueData.Ptr, ppClusterPropertyValueData)
}
struct ISClusPropertyValues extends IDispatch {
    static IID := "{F2E6071C-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Item(varIndex, ppPropertyValue)
      => ComCall(9, this.p, VARIANT, varIndex, ISClusPropertyValue.Ptr, ppPropertyValue)
    CreateItem(bstrName, varValue, ppPropertyValue)
      => ComCall(10, this.p, BSTR, bstrName, VARIANT, varValue, ISClusPropertyValue.Ptr, ppPropertyValue)
    RemoveItem(varIndex)
      => ComCall(11, this.p, VARIANT, varIndex)
}
struct ISClusProperties extends IDispatch {
    static IID := "{F2E60700-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusProperty)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusProperty.Ptr, ppClusProperty)
    CreateItem(bstrName, varValue, pProperty)
      => ComCall(11, this.p, BSTR, bstrName, VARIANT, varValue, ISClusProperty.Ptr, pProperty)
    UseDefaultValue(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
    SaveChanges(pvarStatusCode)
      => ComCall(13, this.p, VARIANT.Ptr, pvarStatusCode)
    get_ReadOnly(pvarReadOnly)
      => ComCall(14, this.p, VARIANT.Ptr, pvarReadOnly)
    get_Private(pvarPrivate)
      => ComCall(15, this.p, VARIANT.Ptr, pvarPrivate)
    get_Common(pvarCommon)
      => ComCall(16, this.p, VARIANT.Ptr, pvarCommon)
    get_Modified(pvarModified)
      => ComCall(17, this.p, VARIANT.Ptr, pvarModified)
}
struct ISClusPropertyValueData extends IDispatch {
    static IID := "{F2E6071E-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Item(varIndex, pvarValue)
      => ComCall(9, this.p, VARIANT, varIndex, VARIANT.Ptr, pvarValue)
    CreateItem(varValue, pvarData)
      => ComCall(10, this.p, VARIANT, varValue, VARIANT.Ptr, pvarData)
    RemoveItem(varIndex)
      => ComCall(11, this.p, VARIANT, varIndex)
}
struct ISClusPartition extends IDispatch {
    static IID := "{F2E60720-2631-11D1-89F1-00A0C90D061E}"
    get_Flags(plFlags)
      => ComCall(7, this.p, Int32.Ptr, plFlags)
    get_DeviceName(pbstrDeviceName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDeviceName)
    get_VolumeLabel(pbstrVolumeLabel)
      => ComCall(9, this.p, BSTR.Ptr, pbstrVolumeLabel)
    get_SerialNumber(plSerialNumber)
      => ComCall(10, this.p, Int32.Ptr, plSerialNumber)
    get_MaximumComponentLength(plMaximumComponentLength)
      => ComCall(11, this.p, Int32.Ptr, plMaximumComponentLength)
    get_FileSystemFlags(plFileSystemFlags)
      => ComCall(12, this.p, Int32.Ptr, plFileSystemFlags)
    get_FileSystem(pbstrFileSystem)
      => ComCall(13, this.p, BSTR.Ptr, pbstrFileSystem)
}
struct ISClusPartitionEx extends ISClusPartition {
    static IID := "{8802D4FE-B32E-4AD1-9DBD-64F18E1166CE}"
    get_TotalSize(plTotalSize)
      => ComCall(14, this.p, Int32.Ptr, plTotalSize)
    get_FreeSpace(plFreeSpace)
      => ComCall(15, this.p, Int32.Ptr, plFreeSpace)
    get_DeviceNumber(plDeviceNumber)
      => ComCall(16, this.p, Int32.Ptr, plDeviceNumber)
    get_PartitionNumber(plPartitionNumber)
      => ComCall(17, this.p, Int32.Ptr, plPartitionNumber)
    get_VolumeGuid(pbstrVolumeGuid)
      => ComCall(18, this.p, BSTR.Ptr, pbstrVolumeGuid)
}
struct ISClusPartitions extends IDispatch {
    static IID := "{F2E60722-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Item(varIndex, ppPartition)
      => ComCall(9, this.p, VARIANT, varIndex, ISClusPartition.Ptr, ppPartition)
}
struct ISClusDisk extends IDispatch {
    static IID := "{F2E60724-2631-11D1-89F1-00A0C90D061E}"
    get_Signature(plSignature)
      => ComCall(7, this.p, Int32.Ptr, plSignature)
    get_ScsiAddress(ppScsiAddress)
      => ComCall(8, this.p, ISClusScsiAddress.Ptr, ppScsiAddress)
    get_DiskNumber(plDiskNumber)
      => ComCall(9, this.p, Int32.Ptr, plDiskNumber)
    get_Partitions(ppPartitions)
      => ComCall(10, this.p, ISClusPartitions.Ptr, ppPartitions)
}
struct ISClusDisks extends IDispatch {
    static IID := "{F2E60726-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    get_Item(varIndex, ppDisk)
      => ComCall(9, this.p, VARIANT, varIndex, ISClusDisk.Ptr, ppDisk)
}
struct ISClusScsiAddress extends IDispatch {
    static IID := "{F2E60728-2631-11D1-89F1-00A0C90D061E}"
    get_PortNumber(pvarPortNumber)
      => ComCall(7, this.p, VARIANT.Ptr, pvarPortNumber)
    get_PathId(pvarPathId)
      => ComCall(8, this.p, VARIANT.Ptr, pvarPathId)
    get_TargetId(pvarTargetId)
      => ComCall(9, this.p, VARIANT.Ptr, pvarTargetId)
    get_Lun(pvarLun)
      => ComCall(10, this.p, VARIANT.Ptr, pvarLun)
}
struct ISClusRegistryKeys extends IDispatch {
    static IID := "{F2E6072A-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, pbstrRegistryKey)
      => ComCall(10, this.p, VARIANT, varIndex, BSTR.Ptr, pbstrRegistryKey)
    AddItem(bstrRegistryKey)
      => ComCall(11, this.p, BSTR, bstrRegistryKey)
    RemoveItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusCryptoKeys extends IDispatch {
    static IID := "{F2E6072C-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, pbstrCyrptoKey)
      => ComCall(10, this.p, VARIANT, varIndex, BSTR.Ptr, pbstrCyrptoKey)
    AddItem(bstrCryptoKey)
      => ComCall(11, this.p, BSTR, bstrCryptoKey)
    RemoveItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
}
struct ISClusResDependents extends IDispatch {
    static IID := "{F2E6072E-2631-11D1-89F1-00A0C90D061E}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(retval)
      => ComCall(8, this.p, IUnknown.Ptr, retval)
    Refresh()
      => ComCall(9, this.p)
    get_Item(varIndex, ppClusResource)
      => ComCall(10, this.p, VARIANT, varIndex, ISClusResource.Ptr, ppClusResource)
    CreateItem(bstrResourceName, bstrResourceType, dwFlags, ppClusterResource)
      => ComCall(11, this.p, BSTR, bstrResourceName, BSTR, bstrResourceType, CLUSTER_RESOURCE_CREATE_FLAGS, dwFlags, ISClusResource.Ptr, ppClusterResource)
    DeleteItem(varIndex)
      => ComCall(12, this.p, VARIANT, varIndex)
    AddItem(pResource)
      => ComCall(13, this.p, ISClusResource, pResource)
    RemoveItem(varIndex)
      => ComCall(14, this.p, VARIANT, varIndex)
}
