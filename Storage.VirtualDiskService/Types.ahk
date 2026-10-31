#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HRESULT, PWSTR}
#Import "..\Storage.Vhd\Types.ahk" {ATTACH_VIRTUAL_DISK_FLAG, COMPACT_VIRTUAL_DISK_FLAG, CREATE_VIRTUAL_DISK_FLAG, DEPENDENT_DISK_FLAG, DETACH_VIRTUAL_DISK_FLAG, EXPAND_VIRTUAL_DISK_FLAG, MERGE_VIRTUAL_DISK_FLAG, OPEN_VIRTUAL_DISK_FLAG, VIRTUAL_DISK_ACCESS_MASK, VIRTUAL_STORAGE_TYPE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct VDS_NF_PACK extends UInt32 {
    static VDS_NF_PACK_ARRIVE := 1
    static VDS_NF_PACK_DEPART := 2
    static VDS_NF_PACK_MODIFY := 3
}
struct VDS_NF_FILE_SYSTEM extends UInt32 {
    static VDS_NF_FILE_SYSTEM_MODIFY := 203
    static VDS_NF_FILE_SYSTEM_FORMAT_PROGRESS := 204
}
struct VDS_NF_CONTROLLER extends UInt32 {
    static VDS_NF_CONTROLLER_ARRIVE := 103
    static VDS_NF_CONTROLLER_DEPART := 104
    static VDS_NF_CONTROLLER_MODIFY := 350
    static VDS_NF_CONTROLLER_REMOVED := 351
}
struct VDS_NF_DRIVE extends UInt32 {
    static VDS_NF_DRIVE_ARRIVE := 105
    static VDS_NF_DRIVE_DEPART := 106
    static VDS_NF_DRIVE_MODIFY := 107
    static VDS_NF_DRIVE_REMOVED := 354
}
struct VDS_NF_PORT extends UInt32 {
    static VDS_NF_PORT_ARRIVE := 121
    static VDS_NF_PORT_DEPART := 122
    static VDS_NF_PORT_MODIFY := 352
    static VDS_NF_PORT_REMOVED := 353
}
struct VDS_NF_LUN extends UInt32 {
    static VDS_NF_LUN_ARRIVE := 108
    static VDS_NF_LUN_DEPART := 109
    static VDS_NF_LUN_MODIFY := 110
}
struct VDS_NF_DISK extends UInt32 {
    static VDS_NF_DISK_ARRIVE := 8
    static VDS_NF_DISK_DEPART := 9
    static VDS_NF_DISK_MODIFY := 10
}
struct IVdsProviderPrivate extends IUnknown {
    static IID := "{11F3CD41-B7E8-48FF-9472-9DFF018AA292}"
    GetObject(ObjectId, type, ppObjectUnk)
      => ComCall(3, this.p, GUID, ObjectId, VDS_OBJECT_TYPE, type, IUnknown.Ptr, ppObjectUnk)
    OnLoad(pwszMachineName, pCallbackObject?)
      => ComCall(4, this.p, "Str", pwszMachineName, IUnknown, pCallbackObject?)
    OnUnload(bForceUnload)
      => ComCall(5, this.p, BOOL, bForceUnload)
}
struct IVdsHwProviderPrivate extends IUnknown {
    static IID := "{98F17BF3-9F33-4F12-8714-8B4075092C2E}"
    QueryIfCreatedLun(pwszDevicePath, pVdsLunInformation, pLunId)
      => ComCall(3, this.p, "Str", pwszDevicePath, VDS_LUN_INFORMATION.Ptr, pVdsLunInformation, GUID.Ptr, pLunId)
}
struct IVdsHwProviderPrivateMpio extends IUnknown {
    static IID := "{310A7715-AC2B-4C6F-9827-3D742F351676}"
    SetAllPathStatusesFromHbaPort(hbaPortProp, status)
      => ComCall(3, this.p, VDS_HBAPORT_PROP, hbaPortProp, VDS_PATH_STATUS, status)
}
struct IVdsAdmin extends IUnknown {
    static IID := "{D188E97D-85AA-4D33-ABC6-26299A10FFC1}"
    RegisterProvider(providerId, providerClsid, pwszName, type, pwszMachineName?, pwszVersion, guidVersionId)
      => ComCall(3, this.p, GUID, providerId, GUID, providerClsid, "Str", pwszName, VDS_PROVIDER_TYPE, type, "Str", pwszMachineName?, "Str", pwszVersion, GUID, guidVersionId)
    UnregisterProvider(providerId)
      => ComCall(4, this.p, GUID, providerId)
}
struct VDS_STORAGE_IDENTIFIER_CODE_SET extends Int32 {
    static VDSStorageIdCodeSetReserved := 0
    static VDSStorageIdCodeSetBinary := 1
    static VDSStorageIdCodeSetAscii := 2
    static VDSStorageIdCodeSetUtf8 := 3
}
struct VDS_STORAGE_IDENTIFIER_TYPE extends Int32 {
    static VDSStorageIdTypeVendorSpecific := 0
    static VDSStorageIdTypeVendorId := 1
    static VDSStorageIdTypeEUI64 := 2
    static VDSStorageIdTypeFCPHName := 3
    static VDSStorageIdTypePortRelative := 4
    static VDSStorageIdTypeTargetPortGroup := 5
    static VDSStorageIdTypeLogicalUnitGroup := 6
    static VDSStorageIdTypeMD5LogicalUnitIdentifier := 7
    static VDSStorageIdTypeScsiNameString := 8
}
struct VDS_STORAGE_BUS_TYPE extends Int32 {
    static VDSBusTypeUnknown := 0
    static VDSBusTypeScsi := 1
    static VDSBusTypeAtapi := 2
    static VDSBusTypeAta := 3
    static VDSBusType1394 := 4
    static VDSBusTypeSsa := 5
    static VDSBusTypeFibre := 6
    static VDSBusTypeUsb := 7
    static VDSBusTypeRAID := 8
    static VDSBusTypeiScsi := 9
    static VDSBusTypeSas := 10
    static VDSBusTypeSata := 11
    static VDSBusTypeSd := 12
    static VDSBusTypeMmc := 13
    static VDSBusTypeMax := 14
    static VDSBusTypeVirtual := 14
    static VDSBusTypeFileBackedVirtual := 15
    static VDSBusTypeSpaces := 16
    static VDSBusTypeNVMe := 17
    static VDSBusTypeScm := 18
    static VDSBusTypeUfs := 19
    static VDSBusTypeMaxReserved := 127
}
struct VDS_STORAGE_IDENTIFIER {
    m_CodeSet : VDS_STORAGE_IDENTIFIER_CODE_SET
    m_Type : VDS_STORAGE_IDENTIFIER_TYPE
    m_cbIdentifier : UInt32
    m_rgbIdentifier : UInt8.Ptr
}
struct VDS_STORAGE_DEVICE_ID_DESCRIPTOR {
    m_version : UInt32
    m_cIdentifiers : UInt32
    m_rgIdentifiers : VDS_STORAGE_IDENTIFIER.Ptr
}
struct VDS_INTERCONNECT_ADDRESS_TYPE extends Int32 {
    static VDS_IA_UNKNOWN := 0
    static VDS_IA_FCFS := 1
    static VDS_IA_FCPH := 2
    static VDS_IA_FCPH3 := 3
    static VDS_IA_MAC := 4
    static VDS_IA_SCSI := 5
}
struct VDS_INTERCONNECT {
    m_addressType : VDS_INTERCONNECT_ADDRESS_TYPE
    m_cbPort : UInt32
    m_pbPort : UInt8.Ptr
    m_cbAddress : UInt32
    m_pbAddress : UInt8.Ptr
}
struct VDS_LUN_INFORMATION {
    m_version : UInt32
    m_DeviceType : UInt8
    m_DeviceTypeModifier : UInt8
    m_bCommandQueueing : BOOL
    m_BusType : VDS_STORAGE_BUS_TYPE
    m_szVendorId : UInt8.Ptr
    m_szProductId : UInt8.Ptr
    m_szProductRevision : UInt8.Ptr
    m_szSerialNumber : UInt8.Ptr
    m_diskSignature : GUID
    m_deviceIdDescriptor : VDS_STORAGE_DEVICE_ID_DESCRIPTOR
    m_cInterconnects : UInt32
    m_rgInterconnects : VDS_INTERCONNECT.Ptr
}
struct VDS_OBJECT_TYPE extends Int32 {
    static VDS_OT_UNKNOWN := 0
    static VDS_OT_PROVIDER := 1
    static VDS_OT_PACK := 10
    static VDS_OT_VOLUME := 11
    static VDS_OT_VOLUME_PLEX := 12
    static VDS_OT_DISK := 13
    static VDS_OT_SUB_SYSTEM := 30
    static VDS_OT_CONTROLLER := 31
    static VDS_OT_DRIVE := 32
    static VDS_OT_LUN := 33
    static VDS_OT_LUN_PLEX := 34
    static VDS_OT_PORT := 35
    static VDS_OT_PORTAL := 36
    static VDS_OT_TARGET := 37
    static VDS_OT_PORTAL_GROUP := 38
    static VDS_OT_STORAGE_POOL := 39
    static VDS_OT_HBAPORT := 90
    static VDS_OT_INIT_ADAPTER := 91
    static VDS_OT_INIT_PORTAL := 92
    static VDS_OT_ASYNC := 100
    static VDS_OT_ENUM := 101
    static VDS_OT_VDISK := 200
    static VDS_OT_OPEN_VDISK := 201
}
struct VDS_PROVIDER_TYPE extends Int32 {
    static VDS_PT_UNKNOWN := 0
    static VDS_PT_SOFTWARE := 1
    static VDS_PT_HARDWARE := 2
    static VDS_PT_VIRTUALDISK := 3
    static VDS_PT_MAX := 4
}
struct VDS_PROVIDER_FLAG extends Int32 {
    static VDS_PF_DYNAMIC := 1
    static VDS_PF_INTERNAL_HARDWARE_PROVIDER := 2
    static VDS_PF_ONE_DISK_ONLY_PER_PACK := 4
    static VDS_PF_ONE_PACK_ONLINE_ONLY := 8
    static VDS_PF_VOLUME_SPACE_MUST_BE_CONTIGUOUS := 16
    static VDS_PF_SUPPORT_DYNAMIC := -2147483648
    static VDS_PF_SUPPORT_FAULT_TOLERANT := 1073741824
    static VDS_PF_SUPPORT_DYNAMIC_1394 := 536870912
    static VDS_PF_SUPPORT_MIRROR := 32
    static VDS_PF_SUPPORT_RAID5 := 64
}
struct VDS_RECOVER_ACTION extends Int32 {
    static VDS_RA_UNKNOWN := 0
    static VDS_RA_REFRESH := 1
    static VDS_RA_RESTART := 2
}
struct VDS_NOTIFICATION_TARGET_TYPE extends Int32 {
    static VDS_NTT_UNKNOWN := 0
    static VDS_NTT_PACK := 10
    static VDS_NTT_VOLUME := 11
    static VDS_NTT_DISK := 13
    static VDS_NTT_PARTITION := 60
    static VDS_NTT_DRIVE_LETTER := 61
    static VDS_NTT_FILE_SYSTEM := 62
    static VDS_NTT_MOUNT_POINT := 63
    static VDS_NTT_SUB_SYSTEM := 30
    static VDS_NTT_CONTROLLER := 31
    static VDS_NTT_DRIVE := 32
    static VDS_NTT_LUN := 33
    static VDS_NTT_PORT := 35
    static VDS_NTT_PORTAL := 36
    static VDS_NTT_TARGET := 37
    static VDS_NTT_PORTAL_GROUP := 38
    static VDS_NTT_SERVICE := 200
}
struct VDS_PACK_NOTIFICATION {
    ulEvent : VDS_NF_PACK
    packId : GUID
}
struct VDS_DISK_NOTIFICATION {
    ulEvent : VDS_NF_DISK
    diskId : GUID
}
struct VDS_VOLUME_NOTIFICATION {
    ulEvent : UInt32
    volumeId : GUID
    plexId : GUID
    ulPercentCompleted : UInt32
}
struct VDS_PARTITION_NOTIFICATION {
    ulEvent : UInt32
    diskId : GUID
    ullOffset : Int64
}
struct VDS_SERVICE_NOTIFICATION {
    ulEvent : UInt32
    action : VDS_RECOVER_ACTION
}
struct VDS_DRIVE_LETTER_NOTIFICATION {
    ulEvent : UInt32
    wcLetter : UInt16
    volumeId : GUID
}
struct VDS_FILE_SYSTEM_NOTIFICATION {
    ulEvent : VDS_NF_FILE_SYSTEM
    volumeId : GUID
    dwPercentCompleted : UInt32
}
struct VDS_MOUNT_POINT_NOTIFICATION {
    ulEvent : UInt32
    volumeId : GUID
}
struct VDS_SUB_SYSTEM_NOTIFICATION {
    ulEvent : UInt32
    subSystemId : GUID
}
struct VDS_CONTROLLER_NOTIFICATION {
    ulEvent : VDS_NF_CONTROLLER
    controllerId : GUID
}
struct VDS_DRIVE_NOTIFICATION {
    ulEvent : VDS_NF_DRIVE
    driveId : GUID
}
struct VDS_LUN_NOTIFICATION {
    ulEvent : VDS_NF_LUN
    LunId : GUID
}
struct VDS_PORT_NOTIFICATION {
    ulEvent : VDS_NF_PORT
    portId : GUID
}
struct VDS_PORTAL_NOTIFICATION {
    ulEvent : UInt32
    portalId : GUID
}
struct VDS_TARGET_NOTIFICATION {
    ulEvent : UInt32
    targetId : GUID
}
struct VDS_PORTAL_GROUP_NOTIFICATION {
    ulEvent : UInt32
    portalGroupId : GUID
}
struct VDS_NOTIFICATION {
    objectType : VDS_NOTIFICATION_TARGET_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Pack : VDS_PACK_NOTIFICATION
            Disk : VDS_DISK_NOTIFICATION
            Volume : VDS_VOLUME_NOTIFICATION
            Partition : VDS_PARTITION_NOTIFICATION
            Letter : VDS_DRIVE_LETTER_NOTIFICATION
            FileSystem : VDS_FILE_SYSTEM_NOTIFICATION
            MountPoint : VDS_MOUNT_POINT_NOTIFICATION
            SubSystem : VDS_SUB_SYSTEM_NOTIFICATION
            Controller : VDS_CONTROLLER_NOTIFICATION
            Drive : VDS_DRIVE_NOTIFICATION
            Lun : VDS_LUN_NOTIFICATION
            Port : VDS_PORT_NOTIFICATION
            Portal : VDS_PORTAL_NOTIFICATION
            Target : VDS_TARGET_NOTIFICATION
            PortalGroup : VDS_PORTAL_GROUP_NOTIFICATION
            Service : VDS_SERVICE_NOTIFICATION
        }
    }
}
struct VDS_ASYNC_OUTPUT_TYPE extends Int32 {
    static VDS_ASYNCOUT_UNKNOWN := 0
    static VDS_ASYNCOUT_CREATEVOLUME := 1
    static VDS_ASYNCOUT_EXTENDVOLUME := 2
    static VDS_ASYNCOUT_SHRINKVOLUME := 3
    static VDS_ASYNCOUT_ADDVOLUMEPLEX := 4
    static VDS_ASYNCOUT_BREAKVOLUMEPLEX := 5
    static VDS_ASYNCOUT_REMOVEVOLUMEPLEX := 6
    static VDS_ASYNCOUT_REPAIRVOLUMEPLEX := 7
    static VDS_ASYNCOUT_RECOVERPACK := 8
    static VDS_ASYNCOUT_REPLACEDISK := 9
    static VDS_ASYNCOUT_CREATEPARTITION := 10
    static VDS_ASYNCOUT_CLEAN := 11
    static VDS_ASYNCOUT_CREATELUN := 50
    static VDS_ASYNCOUT_ADDLUNPLEX := 52
    static VDS_ASYNCOUT_REMOVELUNPLEX := 53
    static VDS_ASYNCOUT_EXTENDLUN := 54
    static VDS_ASYNCOUT_SHRINKLUN := 55
    static VDS_ASYNCOUT_RECOVERLUN := 56
    static VDS_ASYNCOUT_LOGINTOTARGET := 60
    static VDS_ASYNCOUT_LOGOUTFROMTARGET := 61
    static VDS_ASYNCOUT_CREATETARGET := 62
    static VDS_ASYNCOUT_CREATEPORTALGROUP := 63
    static VDS_ASYNCOUT_DELETETARGET := 64
    static VDS_ASYNCOUT_ADDPORTAL := 65
    static VDS_ASYNCOUT_REMOVEPORTAL := 66
    static VDS_ASYNCOUT_DELETEPORTALGROUP := 67
    static VDS_ASYNCOUT_FORMAT := 101
    static VDS_ASYNCOUT_CREATE_VDISK := 200
    static VDS_ASYNCOUT_ATTACH_VDISK := 201
    static VDS_ASYNCOUT_COMPACT_VDISK := 202
    static VDS_ASYNCOUT_MERGE_VDISK := 203
    static VDS_ASYNCOUT_EXPAND_VDISK := 204
}
struct VDS_ASYNC_OUTPUT {
    type : VDS_ASYNC_OUTPUT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            cp : this._cp
            cv : this._cv
            bvp : this._bvp
            sv : this._sv
            cl : this._cl
            ct : this._ct
            cpg : this._cpg
            cvd : this._cvd
        }
        struct _cp {
            ullOffset : Int64
            volumeId : GUID
        }
        struct _cv {
            pVolumeUnk : IUnknown
        }
        struct _bvp {
            pVolumeUnk : IUnknown
        }
        struct _sv {
            ullReclaimedBytes : Int64
        }
        struct _cl {
            pLunUnk : IUnknown
        }
        struct _ct {
            pTargetUnk : IUnknown
        }
        struct _cpg {
            pPortalGroupUnk : IUnknown
        }
        struct _cvd {
            pVDiskUnk : IUnknown
        }
    }
}
struct VDS_IPADDRESS_TYPE extends Int32 {
    static VDS_IPT_TEXT := 0
    static VDS_IPT_IPV4 := 1
    static VDS_IPT_IPV6 := 2
    static VDS_IPT_EMPTY := 3
}
struct VDS_HEALTH extends Int32 {
    static VDS_H_UNKNOWN := 0
    static VDS_H_HEALTHY := 1
    static VDS_H_REBUILDING := 2
    static VDS_H_STALE := 3
    static VDS_H_FAILING := 4
    static VDS_H_FAILING_REDUNDANCY := 5
    static VDS_H_FAILED_REDUNDANCY := 6
    static VDS_H_FAILED_REDUNDANCY_FAILING := 7
    static VDS_H_FAILED := 8
    static VDS_H_REPLACED := 9
    static VDS_H_PENDING_FAILURE := 10
    static VDS_H_DEGRADED := 11
}
struct VDS_TRANSITION_STATE extends Int32 {
    static VDS_TS_UNKNOWN := 0
    static VDS_TS_STABLE := 1
    static VDS_TS_EXTENDING := 2
    static VDS_TS_SHRINKING := 3
    static VDS_TS_RECONFIGING := 4
    static VDS_TS_RESTRIPING := 5
}
struct VDS_FILE_SYSTEM_TYPE extends Int32 {
    static VDS_FST_UNKNOWN := 0
    static VDS_FST_RAW := 1
    static VDS_FST_FAT := 2
    static VDS_FST_FAT32 := 3
    static VDS_FST_NTFS := 4
    static VDS_FST_CDFS := 5
    static VDS_FST_UDF := 6
    static VDS_FST_EXFAT := 7
    static VDS_FST_CSVFS := 8
    static VDS_FST_REFS := 9
}
struct VDS_HBAPORT_TYPE extends Int32 {
    static VDS_HPT_UNKNOWN := 1
    static VDS_HPT_OTHER := 2
    static VDS_HPT_NOTPRESENT := 3
    static VDS_HPT_NPORT := 5
    static VDS_HPT_NLPORT := 6
    static VDS_HPT_FLPORT := 7
    static VDS_HPT_FPORT := 8
    static VDS_HPT_EPORT := 9
    static VDS_HPT_GPORT := 10
    static VDS_HPT_LPORT := 20
    static VDS_HPT_PTP := 21
}
struct VDS_HBAPORT_STATUS extends Int32 {
    static VDS_HPS_UNKNOWN := 1
    static VDS_HPS_ONLINE := 2
    static VDS_HPS_OFFLINE := 3
    static VDS_HPS_BYPASSED := 4
    static VDS_HPS_DIAGNOSTICS := 5
    static VDS_HPS_LINKDOWN := 6
    static VDS_HPS_ERROR := 7
    static VDS_HPS_LOOPBACK := 8
}
struct VDS_HBAPORT_SPEED_FLAG extends Int32 {
    static VDS_HSF_UNKNOWN := 0
    static VDS_HSF_1GBIT := 1
    static VDS_HSF_2GBIT := 2
    static VDS_HSF_10GBIT := 4
    static VDS_HSF_4GBIT := 8
    static VDS_HSF_NOT_NEGOTIATED := 32768
}
struct VDS_PATH_STATUS extends Int32 {
    static VDS_MPS_UNKNOWN := 0
    static VDS_MPS_ONLINE := 1
    static VDS_MPS_FAILED := 5
    static VDS_MPS_STANDBY := 7
}
struct VDS_LOADBALANCE_POLICY_ENUM extends Int32 {
    static VDS_LBP_UNKNOWN := 0
    static VDS_LBP_FAILOVER := 1
    static VDS_LBP_ROUND_ROBIN := 2
    static VDS_LBP_ROUND_ROBIN_WITH_SUBSET := 3
    static VDS_LBP_DYN_LEAST_QUEUE_DEPTH := 4
    static VDS_LBP_WEIGHTED_PATHS := 5
    static VDS_LBP_LEAST_BLOCKS := 6
    static VDS_LBP_VENDOR_SPECIFIC := 7
}
struct VDS_PROVIDER_LBSUPPORT_FLAG extends Int32 {
    static VDS_LBF_FAILOVER := 1
    static VDS_LBF_ROUND_ROBIN := 2
    static VDS_LBF_ROUND_ROBIN_WITH_SUBSET := 4
    static VDS_LBF_DYN_LEAST_QUEUE_DEPTH := 8
    static VDS_LBF_WEIGHTED_PATHS := 16
    static VDS_LBF_LEAST_BLOCKS := 32
    static VDS_LBF_VENDOR_SPECIFIC := 64
}
struct VDS_VERSION_SUPPORT_FLAG extends Int32 {
    static VDS_VSF_1_0 := 1
    static VDS_VSF_1_1 := 2
    static VDS_VSF_2_0 := 4
    static VDS_VSF_2_1 := 8
    static VDS_VSF_3_0 := 16
}
struct VDS_HWPROVIDER_TYPE extends Int32 {
    static VDS_HWT_UNKNOWN := 0
    static VDS_HWT_PCI_RAID := 1
    static VDS_HWT_FIBRE_CHANNEL := 2
    static VDS_HWT_ISCSI := 3
    static VDS_HWT_SAS := 4
    static VDS_HWT_HYBRID := 5
}
struct VDS_ISCSI_LOGIN_TYPE extends Int32 {
    static VDS_ILT_MANUAL := 0
    static VDS_ILT_PERSISTENT := 1
    static VDS_ILT_BOOT := 2
}
struct VDS_ISCSI_AUTH_TYPE extends Int32 {
    static VDS_IAT_NONE := 0
    static VDS_IAT_CHAP := 1
    static VDS_IAT_MUTUAL_CHAP := 2
}
struct VDS_ISCSI_IPSEC_FLAG extends Int32 {
    static VDS_IIF_VALID := 1
    static VDS_IIF_IKE := 2
    static VDS_IIF_MAIN_MODE := 4
    static VDS_IIF_AGGRESSIVE_MODE := 8
    static VDS_IIF_PFS_ENABLE := 16
    static VDS_IIF_TRANSPORT_MODE_PREFERRED := 32
    static VDS_IIF_TUNNEL_MODE_PREFERRED := 64
}
struct VDS_ISCSI_LOGIN_FLAG extends Int32 {
    static VDS_ILF_REQUIRE_IPSEC := 1
    static VDS_ILF_MULTIPATH_ENABLED := 2
}
struct VDS_PATH_ID {
    ullSourceId : Int64
    ullPathId : Int64
}
struct VDS_WWN {
    rguchWwn : UInt8[8]
}
struct VDS_IPADDRESS {
    type : VDS_IPADDRESS_TYPE
    ipv4Address : UInt32
    ipv6Address : UInt8[16]
    ulIpv6FlowInfo : UInt32
    ulIpv6ScopeId : UInt32
    wszTextAddress : UInt16[257]
    ulPort : UInt32
}
struct VDS_ISCSI_IPSEC_KEY {
    pKey : UInt8.Ptr
    ulKeySize : UInt32
}
struct VDS_ISCSI_SHARED_SECRET {
    pSharedSecret : UInt8.Ptr
    ulSharedSecretSize : UInt32
}
struct VDS_HBAPORT_PROP {
    id : GUID
    wwnNode : VDS_WWN
    wwnPort : VDS_WWN
    type : VDS_HBAPORT_TYPE
    status : VDS_HBAPORT_STATUS
    ulPortSpeed : UInt32
    ulSupportedPortSpeed : UInt32
}
struct VDS_ISCSI_INITIATOR_ADAPTER_PROP {
    id : GUID
    pwszName : PWSTR
}
struct VDS_ISCSI_INITIATOR_PORTAL_PROP {
    id : GUID
    address : VDS_IPADDRESS
    ulPortIndex : UInt32
}
struct VDS_PROVIDER_PROP {
    id : GUID
    pwszName : PWSTR
    guidVersionId : GUID
    pwszVersion : PWSTR
    type : VDS_PROVIDER_TYPE
    ulFlags : UInt32
    ulStripeSizeFlags : UInt32
    sRebuildPriority : Int16
}
struct VDS_PATH_INFO {
    pathId : VDS_PATH_ID
    type : VDS_HWPROVIDER_TYPE
    status : VDS_PATH_STATUS
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            controllerPortId : GUID
            targetPortalId : GUID
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hbaPortId : GUID
            initiatorAdapterId : GUID
        }
    }
    struct _Anonymous3_e__Union {
        union {
            pHbaPortProp : VDS_HBAPORT_PROP.Ptr
            pInitiatorPortalIpAddr : VDS_IPADDRESS.Ptr
        }
    }
}
struct VDS_PATH_POLICY {
    pathId : VDS_PATH_ID
    bPrimaryPath : BOOL
    ulWeight : UInt32
}
struct IEnumVdsObject extends IUnknown {
    static IID := "{118610B7-8D94-4030-B5B8-500889788E4E}"
    Next(ppObjectArray, pcFetched)
      => ComCall(3, this.p, UInt32, ppObjectArray.Length, IUnknown.Ptr, ppObjectArray, UInt32.Ptr, pcFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsAsync extends IUnknown {
    static IID := "{D5D23B6D-5A55-4492-9889-397A3C2D2DBC}"
    Cancel()
      => ComCall(3, this.p)
    Wait(pHrResult, pAsyncOut)
      => ComCall(4, this.p, HRESULT.Ptr, pHrResult, VDS_ASYNC_OUTPUT.Ptr, pAsyncOut)
    QueryStatus(pHrResult, pulPercentCompleted)
      => ComCall(5, this.p, HRESULT.Ptr, pHrResult, UInt32.Ptr, pulPercentCompleted)
}
struct IVdsAdviseSink extends IUnknown {
    static IID := "{8326CD1D-CF59-4936-B786-5EFC08798E25}"
    OnNotify(pNotificationArray)
      => ComCall(3, this.p, Int32, pNotificationArray.Length, VDS_NOTIFICATION.Ptr, pNotificationArray)
}
struct IVdsProvider extends IUnknown {
    static IID := "{10C5E575-7984-4E81-A56B-431F5F92AE42}"
    GetProperties(pProviderProp)
      => ComCall(3, this.p, VDS_PROVIDER_PROP.Ptr, pProviderProp)
}
struct IVdsProviderSupport extends IUnknown {
    static IID := "{1732BE13-E8F9-4A03-BFBC-5F616AA66CE1}"
    GetVersionSupport(ulVersionSupport)
      => ComCall(3, this.p, UInt32.Ptr, ulVersionSupport)
}
struct VDS_PACK_STATUS extends Int32 {
    static VDS_PS_UNKNOWN := 0
    static VDS_PS_ONLINE := 1
    static VDS_PS_OFFLINE := 4
}
struct VDS_PACK_FLAG extends Int32 {
    static VDS_PKF_FOREIGN := 1
    static VDS_PKF_NOQUORUM := 2
    static VDS_PKF_POLICY := 4
    static VDS_PKF_CORRUPTED := 8
    static VDS_PKF_ONLINE_ERROR := 16
}
struct VDS_DISK_STATUS extends Int32 {
    static VDS_DS_UNKNOWN := 0
    static VDS_DS_ONLINE := 1
    static VDS_DS_NOT_READY := 2
    static VDS_DS_NO_MEDIA := 3
    static VDS_DS_FAILED := 5
    static VDS_DS_MISSING := 6
    static VDS_DS_OFFLINE := 4
}
struct VDS_PARTITION_STYLE extends Int32 {
    static VDS_PST_UNKNOWN := 0
    static VDS_PST_MBR := 1
    static VDS_PST_GPT := 2
}
struct VDS_DISK_FLAG extends Int32 {
    static VDS_DF_AUDIO_CD := 1
    static VDS_DF_HOTSPARE := 2
    static VDS_DF_RESERVE_CAPABLE := 4
    static VDS_DF_MASKED := 8
    static VDS_DF_STYLE_CONVERTIBLE := 16
    static VDS_DF_CLUSTERED := 32
    static VDS_DF_READ_ONLY := 64
    static VDS_DF_SYSTEM_DISK := 128
    static VDS_DF_BOOT_DISK := 256
    static VDS_DF_PAGEFILE_DISK := 512
    static VDS_DF_HIBERNATIONFILE_DISK := 1024
    static VDS_DF_CRASHDUMP_DISK := 2048
    static VDS_DF_HAS_ARC_PATH := 4096
    static VDS_DF_DYNAMIC := 8192
    static VDS_DF_BOOT_FROM_DISK := 16384
    static VDS_DF_CURRENT_READ_ONLY := 32768
    static VDS_DF_REFS_NOT_SUPPORTED := 65536
}
struct VDS_PARTITION_FLAG extends Int32 {
    static VDS_PTF_SYSTEM := 1
}
struct VDS_LUN_RESERVE_MODE extends Int32 {
    static VDS_LRM_NONE := 0
    static VDS_LRM_EXCLUSIVE_RW := 1
    static VDS_LRM_EXCLUSIVE_RO := 2
    static VDS_LRM_SHARED_RO := 3
    static VDS_LRM_SHARED_RW := 4
}
struct VDS_VOLUME_STATUS extends Int32 {
    static VDS_VS_UNKNOWN := 0
    static VDS_VS_ONLINE := 1
    static VDS_VS_NO_MEDIA := 3
    static VDS_VS_FAILED := 5
    static VDS_VS_OFFLINE := 4
}
struct VDS_VOLUME_TYPE extends Int32 {
    static VDS_VT_UNKNOWN := 0
    static VDS_VT_SIMPLE := 10
    static VDS_VT_SPAN := 11
    static VDS_VT_STRIPE := 12
    static VDS_VT_MIRROR := 13
    static VDS_VT_PARITY := 14
}
struct VDS_VOLUME_FLAG extends Int32 {
    static VDS_VF_SYSTEM_VOLUME := 1
    static VDS_VF_BOOT_VOLUME := 2
    static VDS_VF_ACTIVE := 4
    static VDS_VF_READONLY := 8
    static VDS_VF_HIDDEN := 16
    static VDS_VF_CAN_EXTEND := 32
    static VDS_VF_CAN_SHRINK := 64
    static VDS_VF_PAGEFILE := 128
    static VDS_VF_HIBERNATION := 256
    static VDS_VF_CRASHDUMP := 512
    static VDS_VF_INSTALLABLE := 1024
    static VDS_VF_LBN_REMAP_ENABLED := 2048
    static VDS_VF_FORMATTING := 4096
    static VDS_VF_NOT_FORMATTABLE := 8192
    static VDS_VF_NTFS_NOT_SUPPORTED := 16384
    static VDS_VF_FAT32_NOT_SUPPORTED := 32768
    static VDS_VF_FAT_NOT_SUPPORTED := 65536
    static VDS_VF_NO_DEFAULT_DRIVE_LETTER := 131072
    static VDS_VF_PERMANENTLY_DISMOUNTED := 262144
    static VDS_VF_PERMANENT_DISMOUNT_SUPPORTED := 524288
    static VDS_VF_SHADOW_COPY := 1048576
    static VDS_VF_FVE_ENABLED := 2097152
    static VDS_VF_DIRTY := 4194304
    static VDS_VF_REFS_NOT_SUPPORTED := 8388608
    static VDS_VF_BACKS_BOOT_VOLUME := 16777216
    static VDS_VF_BACKED_BY_WIM_IMAGE := 33554432
}
struct VDS_VOLUME_PLEX_TYPE extends Int32 {
    static VDS_VPT_UNKNOWN := 0
    static VDS_VPT_SIMPLE := 10
    static VDS_VPT_SPAN := 11
    static VDS_VPT_STRIPE := 12
    static VDS_VPT_PARITY := 14
}
struct VDS_VOLUME_PLEX_STATUS extends Int32 {
    static VDS_VPS_UNKNOWN := 0
    static VDS_VPS_ONLINE := 1
    static VDS_VPS_NO_MEDIA := 3
    static VDS_VPS_FAILED := 5
}
struct VDS_DISK_EXTENT_TYPE extends Int32 {
    static VDS_DET_UNKNOWN := 0
    static VDS_DET_FREE := 1
    static VDS_DET_DATA := 2
    static VDS_DET_OEM := 3
    static VDS_DET_ESP := 4
    static VDS_DET_MSR := 5
    static VDS_DET_LDM := 6
    static VDS_DET_CLUSTER := 7
    static VDS_DET_UNUSABLE := 32767
}
struct VDS_PACK_PROP {
    id : GUID
    pwszName : PWSTR
    status : VDS_PACK_STATUS
    ulFlags : UInt32
}
struct VDS_DISK_PROP {
    id : GUID
    status : VDS_DISK_STATUS
    ReserveMode : VDS_LUN_RESERVE_MODE
    health : VDS_HEALTH
    dwDeviceType : UInt32
    dwMediaType : UInt32
    ullSize : Int64
    ulBytesPerSector : UInt32
    ulSectorsPerTrack : UInt32
    ulTracksPerCylinder : UInt32
    ulFlags : UInt32
    BusType : VDS_STORAGE_BUS_TYPE
    PartitionStyle : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    pwszDiskAddress : PWSTR
    pwszName : PWSTR
    pwszFriendlyName : PWSTR
    pwszAdaptorName : PWSTR
    pwszDevicePath : PWSTR
    struct _Anonymous_e__Union {
        union {
            dwSignature : UInt32
            DiskGuid : GUID
        }
    }
}
struct VDS_DISK_OFFLINE_REASON extends Int32 {
    static VDSDiskOfflineReasonNone := 0
    static VDSDiskOfflineReasonPolicy := 1
    static VDSDiskOfflineReasonRedundantPath := 2
    static VDSDiskOfflineReasonSnapshot := 3
    static VDSDiskOfflineReasonCollision := 4
    static VDSDiskOfflineReasonResourceExhaustion := 5
    static VDSDiskOfflineReasonWriteFailure := 6
    static VDSDiskOfflineReasonDIScan := 7
    static VDSDiskOfflineReasonLostDataPersistence := 8
}
struct VDS_DISK_PROP2 {
    id : GUID
    status : VDS_DISK_STATUS
    OfflineReason : VDS_DISK_OFFLINE_REASON
    ReserveMode : VDS_LUN_RESERVE_MODE
    health : VDS_HEALTH
    dwDeviceType : UInt32
    dwMediaType : UInt32
    ullSize : Int64
    ulBytesPerSector : UInt32
    ulSectorsPerTrack : UInt32
    ulTracksPerCylinder : UInt32
    ulFlags : UInt32
    BusType : VDS_STORAGE_BUS_TYPE
    PartitionStyle : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    pwszDiskAddress : PWSTR
    pwszName : PWSTR
    pwszFriendlyName : PWSTR
    pwszAdaptorName : PWSTR
    pwszDevicePath : PWSTR
    pwszLocationPath : PWSTR
    struct _Anonymous_e__Union {
        union {
            dwSignature : UInt32
            DiskGuid : GUID
        }
    }
}
struct VDS_ADVANCEDDISK_PROP {
    pwszId : PWSTR
    pwszPathname : PWSTR
    pwszLocation : PWSTR
    pwszFriendlyName : PWSTR
    pswzIdentifier : PWSTR
    usIdentifierFormat : UInt16
    ulNumber : UInt32
    pwszSerialNumber : PWSTR
    pwszFirmwareVersion : PWSTR
    pwszManufacturer : PWSTR
    pwszModel : PWSTR
    ullTotalSize : Int64
    ullAllocatedSize : Int64
    ulLogicalSectorSize : UInt32
    ulPhysicalSectorSize : UInt32
    ulPartitionCount : UInt32
    status : VDS_DISK_STATUS
    health : VDS_HEALTH
    BusType : VDS_STORAGE_BUS_TYPE
    PartitionStyle : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    ulFlags : UInt32
    dwDeviceType : UInt32
    struct _Anonymous_e__Union {
        union {
            dwSignature : UInt32
            DiskGuid : GUID
        }
    }
}
struct VDS_VOLUME_PROP {
    id : GUID
    type : VDS_VOLUME_TYPE
    status : VDS_VOLUME_STATUS
    health : VDS_HEALTH
    TransitionState : VDS_TRANSITION_STATE
    ullSize : Int64
    ulFlags : UInt32
    RecommendedFileSystemType : VDS_FILE_SYSTEM_TYPE
    pwszName : PWSTR
}
struct VDS_VOLUME_PROP2 {
    id : GUID
    type : VDS_VOLUME_TYPE
    status : VDS_VOLUME_STATUS
    health : VDS_HEALTH
    TransitionState : VDS_TRANSITION_STATE
    ullSize : Int64
    ulFlags : UInt32
    RecommendedFileSystemType : VDS_FILE_SYSTEM_TYPE
    cbUniqueId : UInt32
    pwszName : PWSTR
    pUniqueId : UInt8.Ptr
}
struct VDS_VOLUME_PLEX_PROP {
    id : GUID
    type : VDS_VOLUME_PLEX_TYPE
    status : VDS_VOLUME_PLEX_STATUS
    health : VDS_HEALTH
    TransitionState : VDS_TRANSITION_STATE
    ullSize : Int64
    ulStripeSize : UInt32
    ulNumberOfMembers : UInt32
}
struct VDS_DISK_EXTENT {
    diskId : GUID
    type : VDS_DISK_EXTENT_TYPE
    ullOffset : Int64
    ullSize : Int64
    volumeId : GUID
    plexId : GUID
    memberIdx : UInt32
}
struct VDS_DISK_FREE_EXTENT {
    diskId : GUID
    ullOffset : Int64
    ullSize : Int64
}
struct VDS_INPUT_DISK {
    diskId : GUID
    ullSize : Int64
    plexId : GUID
    memberIdx : UInt32
}
struct VDS_PARTITION_INFO_GPT {
    partitionType : GUID
    partitionId : GUID
    attributes : Int64
    name : UInt16[36]
}
struct VDS_PARTITION_INFO_MBR {
    partitionType : UInt8
    bootIndicator : BOOLEAN
    recognizedPartition : BOOLEAN
    hiddenSectors : UInt32
}
struct VDS_PARTITION_PROP {
    PartitionStyle : VDS_PARTITION_STYLE
    ulFlags : UInt32
    ulPartitionNumber : UInt32
    ullOffset : Int64
    ullSize : Int64
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : VDS_PARTITION_INFO_MBR
            Gpt : VDS_PARTITION_INFO_GPT
        }
    }
}
struct __VDS_PARTITION_STYLE extends Int32 {
    static VDS_PARTITION_STYLE_MBR := 0
    static VDS_PARTITION_STYLE_GPT := 1
    static VDS_PARTITION_STYLE_RAW := 2
}
struct VDS_PARTITION_INFORMATION_EX {
    dwPartitionStyle : __VDS_PARTITION_STYLE
    ullStartingOffset : Int64
    ullPartitionLength : Int64
    dwPartitionNumber : UInt32
    bRewritePartition : BOOLEAN
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Mbr : VDS_PARTITION_INFO_MBR
            Gpt : VDS_PARTITION_INFO_GPT
        }
    }
}
struct CREATE_PARTITION_PARAMETERS {
    style : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MbrPartInfo : this._MbrPartInfo_e__Struct
            GptPartInfo : this._GptPartInfo_e__Struct
        }
        struct _MbrPartInfo_e__Struct {
            partitionType : UInt8
            bootIndicator : BOOLEAN
        }
        struct _GptPartInfo_e__Struct {
            partitionType : GUID
            partitionId : GUID
            attributes : Int64
            name : UInt16[36]
        }
    }
}
struct CHANGE_ATTRIBUTES_PARAMETERS {
    style : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MbrPartInfo : this._MbrPartInfo_e__Struct
            GptPartInfo : this._GptPartInfo_e__Struct
        }
        struct _MbrPartInfo_e__Struct {
            bootIndicator : BOOLEAN
        }
        struct _GptPartInfo_e__Struct {
            attributes : Int64
        }
    }
}
struct CHANGE_PARTITION_TYPE_PARAMETERS {
    style : VDS_PARTITION_STYLE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MbrPartInfo : this._MbrPartInfo_e__Struct
            GptPartInfo : this._GptPartInfo_e__Struct
        }
        struct _MbrPartInfo_e__Struct {
            partitionType : UInt8
        }
        struct _GptPartInfo_e__Struct {
            partitionType : GUID
        }
    }
}
struct IVdsSwProvider extends IUnknown {
    static IID := "{9AA58360-CE33-4F92-B658-ED24B14425B8}"
    QueryPacks(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
    CreatePack(ppPack)
      => ComCall(4, this.p, IVdsPack.Ptr, ppPack)
}
struct IVdsPack extends IUnknown {
    static IID := "{3B69D7F5-9D94-4648-91CA-79939BA263BF}"
    GetProperties(pPackProp)
      => ComCall(3, this.p, VDS_PACK_PROP.Ptr, pPackProp)
    GetProvider(ppProvider)
      => ComCall(4, this.p, IVdsProvider.Ptr, ppProvider)
    QueryVolumes(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryDisks(ppEnum)
      => ComCall(6, this.p, IEnumVdsObject.Ptr, ppEnum)
    CreateVolume(type, pInputDiskArray, ulStripeSize, ppAsync)
      => ComCall(7, this.p, VDS_VOLUME_TYPE, type, VDS_INPUT_DISK.Ptr, pInputDiskArray, Int32, pInputDiskArray.Length, UInt32, ulStripeSize, IVdsAsync.Ptr, ppAsync)
    AddDisk(DiskId, PartitionStyle, bAsHotSpare)
      => ComCall(8, this.p, GUID, DiskId, VDS_PARTITION_STYLE, PartitionStyle, BOOL, bAsHotSpare)
    MigrateDisks(pDiskArray, TargetPack, bForce, bQueryOnly, pResults, pbRebootNeeded)
      => ComCall(9, this.p, GUID.Ptr, pDiskArray, Int32, pResults.Length, GUID, TargetPack, BOOL, bForce, BOOL, bQueryOnly, HRESULT.Ptr, pResults, BOOL.Ptr, pbRebootNeeded)
    ReplaceDisk(OldDiskId, NewDiskId, ppAsync)
      => ComCall(10, this.p, GUID, OldDiskId, GUID, NewDiskId, IVdsAsync.Ptr, ppAsync)
    RemoveMissingDisk(DiskId)
      => ComCall(11, this.p, GUID, DiskId)
    Recover(ppAsync)
      => ComCall(12, this.p, IVdsAsync.Ptr, ppAsync)
}
struct IVdsPack2 extends IUnknown {
    static IID := "{13B50BFF-290A-47DD-8558-B7C58DB1A71A}"
    CreateVolume2(type, pInputDiskArray, ulStripeSize, ulAlign, ppAsync)
      => ComCall(3, this.p, VDS_VOLUME_TYPE, type, VDS_INPUT_DISK.Ptr, pInputDiskArray, Int32, pInputDiskArray.Length, UInt32, ulStripeSize, UInt32, ulAlign, IVdsAsync.Ptr, ppAsync)
}
struct IVdsDisk extends IUnknown {
    static IID := "{07E5C822-F00C-47A1-8FCE-B244DA56FD06}"
    GetProperties(pDiskProperties)
      => ComCall(3, this.p, VDS_DISK_PROP.Ptr, pDiskProperties)
    GetPack(ppPack)
      => ComCall(4, this.p, IVdsPack.Ptr, ppPack)
    GetIdentificationData(pLunInfo)
      => ComCall(5, this.p, VDS_LUN_INFORMATION.Ptr, pLunInfo)
    QueryExtents(ppExtentArray)
      => ComCall(6, this.p, VDS_DISK_EXTENT.Ptr.Ptr, ppExtentArray, Int32.Ptr, ppExtentArray.Length)
    ConvertStyle(NewStyle)
      => ComCall(7, this.p, VDS_PARTITION_STYLE, NewStyle)
    SetFlags(ulFlags)
      => ComCall(8, this.p, UInt32, ulFlags)
    ClearFlags(ulFlags)
      => ComCall(9, this.p, UInt32, ulFlags)
}
struct IVdsDisk2 extends IUnknown {
    static IID := "{40F73C8B-687D-4A13-8D96-3D7F2E683936}"
    SetSANMode(bEnable)
      => ComCall(3, this.p, BOOL, bEnable)
}
struct IVdsDiskOnline extends IUnknown {
    static IID := "{90681B1D-6A7F-48E8-9061-31B7AA125322}"
    Online()
      => ComCall(3, this.p)
    Offline()
      => ComCall(4, this.p)
}
struct IVdsAdvancedDisk extends IUnknown {
    static IID := "{6E6F6B40-977C-4069-BDDD-AC710059F8C0}"
    GetPartitionProperties(ullOffset, pPartitionProp)
      => ComCall(3, this.p, Int64, ullOffset, VDS_PARTITION_PROP.Ptr, pPartitionProp)
    QueryPartitions(ppPartitionPropArray)
      => ComCall(4, this.p, VDS_PARTITION_PROP.Ptr.Ptr, ppPartitionPropArray, Int32.Ptr, ppPartitionPropArray.Length)
    CreatePartition(ullOffset, ullSize, para, ppAsync)
      => ComCall(5, this.p, Int64, ullOffset, Int64, ullSize, CREATE_PARTITION_PARAMETERS.Ptr, para, IVdsAsync.Ptr, ppAsync)
    DeletePartition(ullOffset, bForce, bForceProtected)
      => ComCall(6, this.p, Int64, ullOffset, BOOL, bForce, BOOL, bForceProtected)
    ChangeAttributes(ullOffset, para)
      => ComCall(7, this.p, Int64, ullOffset, CHANGE_ATTRIBUTES_PARAMETERS.Ptr, para)
    AssignDriveLetter(ullOffset, wcLetter)
      => ComCall(8, this.p, Int64, ullOffset, UInt16, wcLetter)
    DeleteDriveLetter(ullOffset, wcLetter)
      => ComCall(9, this.p, Int64, ullOffset, UInt16, wcLetter)
    GetDriveLetter(ullOffset, pwcLetter)
      => ComCall(10, this.p, Int64, ullOffset, PWSTR, pwcLetter)
    FormatPartition(ullOffset, type, pwszLabel, dwUnitAllocationSize, bForce, bQuickFormat, bEnableCompression, ppAsync)
      => ComCall(11, this.p, Int64, ullOffset, VDS_FILE_SYSTEM_TYPE, type, "Str", pwszLabel, UInt32, dwUnitAllocationSize, BOOL, bForce, BOOL, bQuickFormat, BOOL, bEnableCompression, IVdsAsync.Ptr, ppAsync)
    Clean(bForce, bForceOEM, bFullClean, ppAsync)
      => ComCall(12, this.p, BOOL, bForce, BOOL, bForceOEM, BOOL, bFullClean, IVdsAsync.Ptr, ppAsync)
}
struct IVdsAdvancedDisk2 extends IUnknown {
    static IID := "{9723F420-9355-42DE-AB66-E31BB15BEEAC}"
    ChangePartitionType(ullOffset, bForce, para)
      => ComCall(3, this.p, Int64, ullOffset, BOOL, bForce, CHANGE_PARTITION_TYPE_PARAMETERS.Ptr, para)
}
struct IVdsAdvancedDisk3 extends IUnknown {
    static IID := "{3858C0D5-0F35-4BF5-9714-69874963BC36}"
    GetProperties(pAdvDiskProp)
      => ComCall(3, this.p, VDS_ADVANCEDDISK_PROP.Ptr, pAdvDiskProp)
    GetUniqueId(ppwszId)
      => ComCall(4, this.p, PWSTR.Ptr, ppwszId)
}
struct IVdsCreatePartitionEx extends IUnknown {
    static IID := "{9882F547-CFC3-420B-9750-00DFBEC50662}"
    CreatePartitionEx(ullOffset, ullSize, ulAlign, para, ppAsync)
      => ComCall(3, this.p, Int64, ullOffset, Int64, ullSize, UInt32, ulAlign, CREATE_PARTITION_PARAMETERS.Ptr, para, IVdsAsync.Ptr, ppAsync)
}
struct IVdsRemovable extends IUnknown {
    static IID := "{0316560B-5DB4-4ED9-BBB5-213436DDC0D9}"
    QueryMedia()
      => ComCall(3, this.p)
    Eject()
      => ComCall(4, this.p)
}
struct IVdsVolume extends IUnknown {
    static IID := "{88306BB2-E71F-478C-86A2-79DA200A0F11}"
    GetProperties(pVolumeProperties)
      => ComCall(3, this.p, VDS_VOLUME_PROP.Ptr, pVolumeProperties)
    GetPack(ppPack)
      => ComCall(4, this.p, IVdsPack.Ptr, ppPack)
    QueryPlexes(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    Extend(pInputDiskArray, ppAsync)
      => ComCall(6, this.p, VDS_INPUT_DISK.Ptr, pInputDiskArray, Int32, pInputDiskArray.Length, IVdsAsync.Ptr, ppAsync)
    Shrink(ullNumberOfBytesToRemove, ppAsync)
      => ComCall(7, this.p, Int64, ullNumberOfBytesToRemove, IVdsAsync.Ptr, ppAsync)
    AddPlex(VolumeId, ppAsync)
      => ComCall(8, this.p, GUID, VolumeId, IVdsAsync.Ptr, ppAsync)
    BreakPlex(plexId, ppAsync)
      => ComCall(9, this.p, GUID, plexId, IVdsAsync.Ptr, ppAsync)
    RemovePlex(plexId, ppAsync)
      => ComCall(10, this.p, GUID, plexId, IVdsAsync.Ptr, ppAsync)
    Delete(bForce)
      => ComCall(11, this.p, BOOL, bForce)
    SetFlags(ulFlags, bRevertOnClose)
      => ComCall(12, this.p, UInt32, ulFlags, BOOL, bRevertOnClose)
    ClearFlags(ulFlags)
      => ComCall(13, this.p, UInt32, ulFlags)
}
struct IVdsVolume2 extends IUnknown {
    static IID := "{72AE6713-DCBB-4A03-B36B-371F6AC6B53D}"
    GetProperties2(pVolumeProperties)
      => ComCall(3, this.p, VDS_VOLUME_PROP2.Ptr, pVolumeProperties)
}
struct IVdsVolumeOnline extends IUnknown {
    static IID := "{1BE2275A-B315-4F70-9E44-879B3A2A53F2}"
    Online()
      => ComCall(3, this.p)
}
struct IVdsVolumePlex extends IUnknown {
    static IID := "{4DAA0135-E1D1-40F1-AAA5-3CC1E53221C3}"
    GetProperties(pPlexProperties)
      => ComCall(3, this.p, VDS_VOLUME_PLEX_PROP.Ptr, pPlexProperties)
    GetVolume(ppVolume)
      => ComCall(4, this.p, IVdsVolume.Ptr, ppVolume)
    QueryExtents(ppExtentArray)
      => ComCall(5, this.p, VDS_DISK_EXTENT.Ptr.Ptr, ppExtentArray, Int32.Ptr, ppExtentArray.Length)
    Repair(pInputDiskArray, ppAsync)
      => ComCall(6, this.p, VDS_INPUT_DISK.Ptr, pInputDiskArray, Int32, pInputDiskArray.Length, IVdsAsync.Ptr, ppAsync)
}
struct IVdsDisk3 extends IUnknown {
    static IID := "{8F4B2F5D-EC15-4357-992F-473EF10975B9}"
    GetProperties2(pDiskProperties)
      => ComCall(3, this.p, VDS_DISK_PROP2.Ptr, pDiskProperties)
    QueryFreeExtents(ulAlign, ppFreeExtentArray)
      => ComCall(4, this.p, UInt32, ulAlign, VDS_DISK_FREE_EXTENT.Ptr.Ptr, ppFreeExtentArray, Int32.Ptr, ppFreeExtentArray.Length)
}
struct VDS_SUB_SYSTEM_STATUS extends Int32 {
    static VDS_SSS_UNKNOWN := 0
    static VDS_SSS_ONLINE := 1
    static VDS_SSS_NOT_READY := 2
    static VDS_SSS_OFFLINE := 4
    static VDS_SSS_FAILED := 5
    static VDS_SSS_PARTIALLY_MANAGED := 9
}
struct VDS_SUB_SYSTEM_FLAG extends Int32 {
    static VDS_SF_LUN_MASKING_CAPABLE := 1
    static VDS_SF_LUN_PLEXING_CAPABLE := 2
    static VDS_SF_LUN_REMAPPING_CAPABLE := 4
    static VDS_SF_DRIVE_EXTENT_CAPABLE := 8
    static VDS_SF_HARDWARE_CHECKSUM_CAPABLE := 16
    static VDS_SF_RADIUS_CAPABLE := 32
    static VDS_SF_READ_BACK_VERIFY_CAPABLE := 64
    static VDS_SF_WRITE_THROUGH_CACHING_CAPABLE := 128
    static VDS_SF_SUPPORTS_FAULT_TOLERANT_LUNS := 512
    static VDS_SF_SUPPORTS_NON_FAULT_TOLERANT_LUNS := 1024
    static VDS_SF_SUPPORTS_SIMPLE_LUNS := 2048
    static VDS_SF_SUPPORTS_SPAN_LUNS := 4096
    static VDS_SF_SUPPORTS_STRIPE_LUNS := 8192
    static VDS_SF_SUPPORTS_MIRROR_LUNS := 16384
    static VDS_SF_SUPPORTS_PARITY_LUNS := 32768
    static VDS_SF_SUPPORTS_AUTH_CHAP := 65536
    static VDS_SF_SUPPORTS_AUTH_MUTUAL_CHAP := 131072
    static VDS_SF_SUPPORTS_SIMPLE_TARGET_CONFIG := 262144
    static VDS_SF_SUPPORTS_LUN_NUMBER := 524288
    static VDS_SF_SUPPORTS_MIRRORED_CACHE := 1048576
    static VDS_SF_READ_CACHING_CAPABLE := 2097152
    static VDS_SF_WRITE_CACHING_CAPABLE := 4194304
    static VDS_SF_MEDIA_SCAN_CAPABLE := 8388608
    static VDS_SF_CONSISTENCY_CHECK_CAPABLE := 16777216
}
struct VDS_SUB_SYSTEM_SUPPORTED_RAID_TYPE_FLAG extends Int32 {
    static VDS_SF_SUPPORTS_RAID2_LUNS := 1
    static VDS_SF_SUPPORTS_RAID3_LUNS := 2
    static VDS_SF_SUPPORTS_RAID4_LUNS := 4
    static VDS_SF_SUPPORTS_RAID5_LUNS := 8
    static VDS_SF_SUPPORTS_RAID6_LUNS := 16
    static VDS_SF_SUPPORTS_RAID01_LUNS := 32
    static VDS_SF_SUPPORTS_RAID03_LUNS := 64
    static VDS_SF_SUPPORTS_RAID05_LUNS := 128
    static VDS_SF_SUPPORTS_RAID10_LUNS := 256
    static VDS_SF_SUPPORTS_RAID15_LUNS := 512
    static VDS_SF_SUPPORTS_RAID30_LUNS := 1024
    static VDS_SF_SUPPORTS_RAID50_LUNS := 2048
    static VDS_SF_SUPPORTS_RAID51_LUNS := 4096
    static VDS_SF_SUPPORTS_RAID53_LUNS := 8192
    static VDS_SF_SUPPORTS_RAID60_LUNS := 16384
    static VDS_SF_SUPPORTS_RAID61_LUNS := 32768
}
struct VDS_INTERCONNECT_FLAG extends Int32 {
    static VDS_ITF_PCI_RAID := 1
    static VDS_ITF_FIBRE_CHANNEL := 2
    static VDS_ITF_ISCSI := 4
    static VDS_ITF_SAS := 8
}
struct VDS_CONTROLLER_STATUS extends Int32 {
    static VDS_CS_UNKNOWN := 0
    static VDS_CS_ONLINE := 1
    static VDS_CS_NOT_READY := 2
    static VDS_CS_OFFLINE := 4
    static VDS_CS_FAILED := 5
    static VDS_CS_REMOVED := 8
}
struct VDS_PORT_STATUS extends Int32 {
    static VDS_PRS_UNKNOWN := 0
    static VDS_PRS_ONLINE := 1
    static VDS_PRS_NOT_READY := 2
    static VDS_PRS_OFFLINE := 4
    static VDS_PRS_FAILED := 5
    static VDS_PRS_REMOVED := 8
}
struct VDS_DRIVE_STATUS extends Int32 {
    static VDS_DRS_UNKNOWN := 0
    static VDS_DRS_ONLINE := 1
    static VDS_DRS_NOT_READY := 2
    static VDS_DRS_OFFLINE := 4
    static VDS_DRS_FAILED := 5
    static VDS_DRS_REMOVED := 8
}
struct VDS_DRIVE_FLAG extends Int32 {
    static VDS_DRF_HOTSPARE := 1
    static VDS_DRF_ASSIGNED := 2
    static VDS_DRF_UNASSIGNED := 4
    static VDS_DRF_HOTSPARE_IN_USE := 8
    static VDS_DRF_HOTSPARE_STANDBY := 16
}
struct VDS_LUN_TYPE extends Int32 {
    static VDS_LT_UNKNOWN := 0
    static VDS_LT_DEFAULT := 1
    static VDS_LT_FAULT_TOLERANT := 2
    static VDS_LT_NON_FAULT_TOLERANT := 3
    static VDS_LT_SIMPLE := 10
    static VDS_LT_SPAN := 11
    static VDS_LT_STRIPE := 12
    static VDS_LT_MIRROR := 13
    static VDS_LT_PARITY := 14
    static VDS_LT_RAID2 := 15
    static VDS_LT_RAID3 := 16
    static VDS_LT_RAID4 := 17
    static VDS_LT_RAID5 := 18
    static VDS_LT_RAID6 := 19
    static VDS_LT_RAID01 := 20
    static VDS_LT_RAID03 := 21
    static VDS_LT_RAID05 := 22
    static VDS_LT_RAID10 := 23
    static VDS_LT_RAID15 := 24
    static VDS_LT_RAID30 := 25
    static VDS_LT_RAID50 := 26
    static VDS_LT_RAID51 := 27
    static VDS_LT_RAID53 := 28
    static VDS_LT_RAID60 := 29
    static VDS_LT_RAID61 := 30
}
struct VDS_LUN_STATUS extends Int32 {
    static VDS_LS_UNKNOWN := 0
    static VDS_LS_ONLINE := 1
    static VDS_LS_NOT_READY := 2
    static VDS_LS_OFFLINE := 4
    static VDS_LS_FAILED := 5
}
struct VDS_LUN_FLAG extends Int32 {
    static VDS_LF_LBN_REMAP_ENABLED := 1
    static VDS_LF_READ_BACK_VERIFY_ENABLED := 2
    static VDS_LF_WRITE_THROUGH_CACHING_ENABLED := 4
    static VDS_LF_HARDWARE_CHECKSUM_ENABLED := 8
    static VDS_LF_READ_CACHE_ENABLED := 16
    static VDS_LF_WRITE_CACHE_ENABLED := 32
    static VDS_LF_MEDIA_SCAN_ENABLED := 64
    static VDS_LF_CONSISTENCY_CHECK_ENABLED := 128
    static VDS_LF_SNAPSHOT := 256
}
struct VDS_LUN_PLEX_TYPE extends Int32 {
    static VDS_LPT_UNKNOWN := 0
    static VDS_LPT_SIMPLE := 10
    static VDS_LPT_SPAN := 11
    static VDS_LPT_STRIPE := 12
    static VDS_LPT_PARITY := 14
    static VDS_LPT_RAID2 := 15
    static VDS_LPT_RAID3 := 16
    static VDS_LPT_RAID4 := 17
    static VDS_LPT_RAID5 := 18
    static VDS_LPT_RAID6 := 19
    static VDS_LPT_RAID03 := 21
    static VDS_LPT_RAID05 := 22
    static VDS_LPT_RAID10 := 23
    static VDS_LPT_RAID15 := 24
    static VDS_LPT_RAID30 := 25
    static VDS_LPT_RAID50 := 26
    static VDS_LPT_RAID53 := 28
    static VDS_LPT_RAID60 := 29
}
struct VDS_LUN_PLEX_STATUS extends Int32 {
    static VDS_LPS_UNKNOWN := 0
    static VDS_LPS_ONLINE := 1
    static VDS_LPS_NOT_READY := 2
    static VDS_LPS_OFFLINE := 4
    static VDS_LPS_FAILED := 5
}
struct VDS_LUN_PLEX_FLAG extends Int32 {
    static VDS_LPF_LBN_REMAP_ENABLED := 1
}
struct VDS_ISCSI_PORTAL_STATUS extends Int32 {
    static VDS_IPS_UNKNOWN := 0
    static VDS_IPS_ONLINE := 1
    static VDS_IPS_NOT_READY := 2
    static VDS_IPS_OFFLINE := 4
    static VDS_IPS_FAILED := 5
}
struct VDS_STORAGE_POOL_STATUS extends Int32 {
    static VDS_SPS_UNKNOWN := 0
    static VDS_SPS_ONLINE := 1
    static VDS_SPS_NOT_READY := 2
    static VDS_SPS_OFFLINE := 4
}
struct VDS_STORAGE_POOL_TYPE extends Int32 {
    static VDS_SPT_UNKNOWN := 0
    static VDS_SPT_PRIMORDIAL := 1
    static VDS_SPT_CONCRETE := 2
}
struct VDS_MAINTENANCE_OPERATION extends Int32 {
    static BlinkLight := 1
    static BeepAlarm := 2
    static SpinDown := 3
    static SpinUp := 4
    static Ping := 5
}
struct VDS_HINTS {
    ullHintMask : Int64
    ullExpectedMaximumSize : Int64
    ulOptimalReadSize : UInt32
    ulOptimalReadAlignment : UInt32
    ulOptimalWriteSize : UInt32
    ulOptimalWriteAlignment : UInt32
    ulMaximumDriveCount : UInt32
    ulStripeSize : UInt32
    bFastCrashRecoveryRequired : BOOL
    bMostlyReads : BOOL
    bOptimizeForSequentialReads : BOOL
    bOptimizeForSequentialWrites : BOOL
    bRemapEnabled : BOOL
    bReadBackVerifyEnabled : BOOL
    bWriteThroughCachingEnabled : BOOL
    bHardwareChecksumEnabled : BOOL
    bIsYankable : BOOL
    sRebuildPriority : Int16
}
struct VDS_HINTS2 {
    ullHintMask : Int64
    ullExpectedMaximumSize : Int64
    ulOptimalReadSize : UInt32
    ulOptimalReadAlignment : UInt32
    ulOptimalWriteSize : UInt32
    ulOptimalWriteAlignment : UInt32
    ulMaximumDriveCount : UInt32
    ulStripeSize : UInt32
    ulReserved1 : UInt32
    ulReserved2 : UInt32
    ulReserved3 : UInt32
    bFastCrashRecoveryRequired : BOOL
    bMostlyReads : BOOL
    bOptimizeForSequentialReads : BOOL
    bOptimizeForSequentialWrites : BOOL
    bRemapEnabled : BOOL
    bReadBackVerifyEnabled : BOOL
    bWriteThroughCachingEnabled : BOOL
    bHardwareChecksumEnabled : BOOL
    bIsYankable : BOOL
    bAllocateHotSpare : BOOL
    bUseMirroredCache : BOOL
    bReadCachingEnabled : BOOL
    bWriteCachingEnabled : BOOL
    bMediaScanEnabled : BOOL
    bConsistencyCheckEnabled : BOOL
    BusType : VDS_STORAGE_BUS_TYPE
    bReserved1 : BOOL
    bReserved2 : BOOL
    bReserved3 : BOOL
    sRebuildPriority : Int16
}
struct VDS_SUB_SYSTEM_PROP {
    id : GUID
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    ulFlags : UInt32
    ulStripeSizeFlags : UInt32
    status : VDS_SUB_SYSTEM_STATUS
    health : VDS_HEALTH
    sNumberOfInternalBuses : Int16
    sMaxNumberOfSlotsEachBus : Int16
    sMaxNumberOfControllers : Int16
    sRebuildPriority : Int16
}
struct VDS_SUB_SYSTEM_PROP2 {
    id : GUID
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    ulFlags : UInt32
    ulStripeSizeFlags : UInt32
    ulSupportedRaidTypeFlags : UInt32
    status : VDS_SUB_SYSTEM_STATUS
    health : VDS_HEALTH
    sNumberOfInternalBuses : Int16
    sMaxNumberOfSlotsEachBus : Int16
    sMaxNumberOfControllers : Int16
    sRebuildPriority : Int16
    ulNumberOfEnclosures : UInt32
}
struct VDS_CONTROLLER_PROP {
    id : GUID
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    status : VDS_CONTROLLER_STATUS
    health : VDS_HEALTH
    sNumberOfPorts : Int16
}
struct VDS_DRIVE_PROP {
    id : GUID
    ullSize : Int64
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    ulFlags : UInt32
    status : VDS_DRIVE_STATUS
    health : VDS_HEALTH
    sInternalBusNumber : Int16
    sSlotNumber : Int16
}
struct VDS_DRIVE_PROP2 {
    id : GUID
    ullSize : Int64
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    ulFlags : UInt32
    status : VDS_DRIVE_STATUS
    health : VDS_HEALTH
    sInternalBusNumber : Int16
    sSlotNumber : Int16
    ulEnclosureNumber : UInt32
    busType : VDS_STORAGE_BUS_TYPE
    ulSpindleSpeed : UInt32
}
struct VDS_DRIVE_EXTENT {
    id : GUID
    LunId : GUID
    ullSize : Int64
    bUsed : BOOL
}
struct VDS_LUN_PROP {
    id : GUID
    ullSize : Int64
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    pwszUnmaskingList : PWSTR
    ulFlags : UInt32
    type : VDS_LUN_TYPE
    status : VDS_LUN_STATUS
    health : VDS_HEALTH
    TransitionState : VDS_TRANSITION_STATE
    sRebuildPriority : Int16
}
struct VDS_LUN_PLEX_PROP {
    id : GUID
    ullSize : Int64
    type : VDS_LUN_PLEX_TYPE
    status : VDS_LUN_PLEX_STATUS
    health : VDS_HEALTH
    TransitionState : VDS_TRANSITION_STATE
    ulFlags : UInt32
    ulStripeSize : UInt32
    sRebuildPriority : Int16
}
struct VDS_PORT_PROP {
    id : GUID
    pwszFriendlyName : PWSTR
    pwszIdentification : PWSTR
    status : VDS_PORT_STATUS
}
struct VDS_ISCSI_PORTAL_PROP {
    id : GUID
    address : VDS_IPADDRESS
    status : VDS_ISCSI_PORTAL_STATUS
}
struct VDS_ISCSI_TARGET_PROP {
    id : GUID
    pwszIscsiName : PWSTR
    pwszFriendlyName : PWSTR
    bChapEnabled : BOOL
}
struct VDS_ISCSI_PORTALGROUP_PROP {
    id : GUID
    tag : UInt16
}
struct VDS_RAID_TYPE extends Int32 {
    static VDS_RT_UNKNOWN := 0
    static VDS_RT_RAID0 := 10
    static VDS_RT_RAID1 := 11
    static VDS_RT_RAID2 := 12
    static VDS_RT_RAID3 := 13
    static VDS_RT_RAID4 := 14
    static VDS_RT_RAID5 := 15
    static VDS_RT_RAID6 := 16
    static VDS_RT_RAID01 := 17
    static VDS_RT_RAID03 := 18
    static VDS_RT_RAID05 := 19
    static VDS_RT_RAID10 := 20
    static VDS_RT_RAID15 := 21
    static VDS_RT_RAID30 := 22
    static VDS_RT_RAID50 := 23
    static VDS_RT_RAID51 := 24
    static VDS_RT_RAID53 := 25
    static VDS_RT_RAID60 := 26
    static VDS_RT_RAID61 := 27
}
struct VDS_POOL_CUSTOM_ATTRIBUTES {
    pwszName : PWSTR
    pwszValue : PWSTR
}
struct VDS_POOL_ATTRIBUTES {
    ullAttributeMask : Int64
    raidType : VDS_RAID_TYPE
    busType : VDS_STORAGE_BUS_TYPE
    pwszIntendedUsage : PWSTR
    bSpinDown : BOOL
    bIsThinProvisioned : BOOL
    ullProvisionedSpace : Int64
    bNoSinglePointOfFailure : BOOL
    ulDataRedundancyMax : UInt32
    ulDataRedundancyMin : UInt32
    ulDataRedundancyDefault : UInt32
    ulPackageRedundancyMax : UInt32
    ulPackageRedundancyMin : UInt32
    ulPackageRedundancyDefault : UInt32
    ulStripeSize : UInt32
    ulStripeSizeMax : UInt32
    ulStripeSizeMin : UInt32
    ulDefaultStripeSize : UInt32
    ulNumberOfColumns : UInt32
    ulNumberOfColumnsMax : UInt32
    ulNumberOfColumnsMin : UInt32
    ulDefaultNumberofColumns : UInt32
    ulDataAvailabilityHint : UInt32
    ulAccessRandomnessHint : UInt32
    ulAccessDirectionHint : UInt32
    ulAccessSizeHint : UInt32
    ulAccessLatencyHint : UInt32
    ulAccessBandwidthWeightHint : UInt32
    ulStorageCostHint : UInt32
    ulStorageEfficiencyHint : UInt32
    ulNumOfCustomAttributes : UInt32
    pPoolCustomAttributes : VDS_POOL_CUSTOM_ATTRIBUTES.Ptr
    bReserved1 : BOOL
    bReserved2 : BOOL
    ulReserved1 : UInt32
    ulReserved2 : UInt32
    ullReserved1 : Int64
    ullReserved2 : Int64
}
struct VDS_STORAGE_POOL_PROP {
    id : GUID
    status : VDS_STORAGE_POOL_STATUS
    health : VDS_HEALTH
    type : VDS_STORAGE_POOL_TYPE
    pwszName : PWSTR
    pwszDescription : PWSTR
    ullTotalConsumedSpace : Int64
    ullTotalManagedSpace : Int64
    ullRemainingFreeSpace : Int64
}
struct VDS_STORAGE_POOL_DRIVE_EXTENT {
    id : GUID
    ullSize : Int64
    bUsed : BOOL
}
struct IVdsHwProvider extends IUnknown {
    static IID := "{D99BDAAE-B13A-4178-9FDB-E27F16B4603E}"
    QuerySubSystems(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
    Reenumerate()
      => ComCall(4, this.p)
    Refresh()
      => ComCall(5, this.p)
}
struct IVdsHwProviderType extends IUnknown {
    static IID := "{3E0F5166-542D-4FC6-947A-012174240B7E}"
    GetProviderType(pType)
      => ComCall(3, this.p, VDS_HWPROVIDER_TYPE.Ptr, pType)
}
struct IVdsHwProviderType2 extends IUnknown {
    static IID := "{8190236F-C4D0-4E81-8011-D69512FCC984}"
    GetProviderType2(pType)
      => ComCall(3, this.p, VDS_HWPROVIDER_TYPE.Ptr, pType)
}
struct IVdsHwProviderStoragePools extends IUnknown {
    static IID := "{D5B5937A-F188-4C79-B86C-11C920AD11B8}"
    QueryStoragePools(ulFlags, ullRemainingFreeSpace, pPoolAttributes, ppEnum)
      => ComCall(3, this.p, UInt32, ulFlags, Int64, ullRemainingFreeSpace, VDS_POOL_ATTRIBUTES.Ptr, pPoolAttributes, IEnumVdsObject.Ptr, ppEnum)
    CreateLunInStoragePool(type, ullSizeInBytes, StoragePoolId, pwszUnmaskingList, pHints2, ppAsync)
      => ComCall(4, this.p, VDS_LUN_TYPE, type, Int64, ullSizeInBytes, GUID, StoragePoolId, "Str", pwszUnmaskingList, VDS_HINTS2.Ptr, pHints2, IVdsAsync.Ptr, ppAsync)
    QueryMaxLunCreateSizeInStoragePool(type, StoragePoolId, pHints2, pullMaxLunSize)
      => ComCall(5, this.p, VDS_LUN_TYPE, type, GUID, StoragePoolId, VDS_HINTS2.Ptr, pHints2, Int64.Ptr, pullMaxLunSize)
}
struct IVdsSubSystem extends IUnknown {
    static IID := "{6FCEE2D3-6D90-4F91-80E2-A5C7CAACA9D8}"
    GetProperties(pSubSystemProp)
      => ComCall(3, this.p, VDS_SUB_SYSTEM_PROP.Ptr, pSubSystemProp)
    GetProvider(ppProvider)
      => ComCall(4, this.p, IVdsProvider.Ptr, ppProvider)
    QueryControllers(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryLuns(ppEnum)
      => ComCall(6, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryDrives(ppEnum)
      => ComCall(7, this.p, IEnumVdsObject.Ptr, ppEnum)
    GetDrive(sBusNumber, sSlotNumber, ppDrive)
      => ComCall(8, this.p, Int16, sBusNumber, Int16, sSlotNumber, IVdsDrive.Ptr, ppDrive)
    Reenumerate()
      => ComCall(9, this.p)
    SetControllerStatus(pOnlineControllerIdArray, pOfflineControllerIdArray)
      => ComCall(10, this.p, GUID.Ptr, pOnlineControllerIdArray, Int32, pOnlineControllerIdArray.Length, GUID.Ptr, pOfflineControllerIdArray, Int32, pOfflineControllerIdArray.Length)
    CreateLun(type, ullSizeInBytes, pDriveIdArray, pwszUnmaskingList, pHints, ppAsync)
      => ComCall(11, this.p, VDS_LUN_TYPE, type, Int64, ullSizeInBytes, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, "Str", pwszUnmaskingList, VDS_HINTS.Ptr, pHints, IVdsAsync.Ptr, ppAsync)
    ReplaceDrive(DriveToBeReplaced, ReplacementDrive)
      => ComCall(12, this.p, GUID, DriveToBeReplaced, GUID, ReplacementDrive)
    SetStatus(status)
      => ComCall(13, this.p, VDS_SUB_SYSTEM_STATUS, status)
    QueryMaxLunCreateSize(type, pDriveIdArray, pHints, pullMaxLunSize)
      => ComCall(14, this.p, VDS_LUN_TYPE, type, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, VDS_HINTS.Ptr, pHints, Int64.Ptr, pullMaxLunSize)
}
struct IVdsSubSystem2 extends IUnknown {
    static IID := "{BE666735-7800-4A77-9D9C-40F85B87E292}"
    GetProperties2(pSubSystemProp2)
      => ComCall(3, this.p, VDS_SUB_SYSTEM_PROP2.Ptr, pSubSystemProp2)
    GetDrive2(sBusNumber, sSlotNumber, ulEnclosureNumber, ppDrive)
      => ComCall(4, this.p, Int16, sBusNumber, Int16, sSlotNumber, UInt32, ulEnclosureNumber, IVdsDrive.Ptr, ppDrive)
    CreateLun2(type, ullSizeInBytes, pDriveIdArray, pwszUnmaskingList, pHints2, ppAsync)
      => ComCall(5, this.p, VDS_LUN_TYPE, type, Int64, ullSizeInBytes, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, "Str", pwszUnmaskingList, VDS_HINTS2.Ptr, pHints2, IVdsAsync.Ptr, ppAsync)
    QueryMaxLunCreateSize2(type, pDriveIdArray, pHints2, pullMaxLunSize)
      => ComCall(6, this.p, VDS_LUN_TYPE, type, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, VDS_HINTS2.Ptr, pHints2, Int64.Ptr, pullMaxLunSize)
}
struct IVdsSubSystemNaming extends IUnknown {
    static IID := "{0D70FAA3-9CD4-4900-AA20-6981B6AAFC75}"
    SetFriendlyName(pwszFriendlyName)
      => ComCall(3, this.p, "Str", pwszFriendlyName)
}
struct IVdsSubSystemIscsi extends IUnknown {
    static IID := "{0027346F-40D0-4B45-8CEC-5906DC0380C8}"
    QueryTargets(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryPortals(ppEnum)
      => ComCall(4, this.p, IEnumVdsObject.Ptr, ppEnum)
    CreateTarget(pwszIscsiName, pwszFriendlyName, ppAsync)
      => ComCall(5, this.p, "Str", pwszIscsiName, "Str", pwszFriendlyName, IVdsAsync.Ptr, ppAsync)
    SetIpsecGroupPresharedKey(pIpsecKey)
      => ComCall(6, this.p, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
}
struct IVdsSubSystemInterconnect extends IUnknown {
    static IID := "{9E6FA560-C141-477B-83BA-0B6C38F7FEBF}"
    GetSupportedInterconnects(pulSupportedInterconnectsFlag)
      => ComCall(3, this.p, UInt32.Ptr, pulSupportedInterconnectsFlag)
}
struct IVdsControllerPort extends IUnknown {
    static IID := "{18691D0D-4E7F-43E8-92E4-CF44BEEED11C}"
    GetProperties(pPortProp)
      => ComCall(3, this.p, VDS_PORT_PROP.Ptr, pPortProp)
    GetController(ppController)
      => ComCall(4, this.p, IVdsController.Ptr, ppController)
    QueryAssociatedLuns(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    Reset()
      => ComCall(6, this.p)
    SetStatus(status)
      => ComCall(7, this.p, VDS_PORT_STATUS, status)
}
struct IVdsController extends IUnknown {
    static IID := "{CB53D96E-DFFB-474A-A078-790D1E2BC082}"
    GetProperties(pControllerProp)
      => ComCall(3, this.p, VDS_CONTROLLER_PROP.Ptr, pControllerProp)
    GetSubSystem(ppSubSystem)
      => ComCall(4, this.p, IVdsSubSystem.Ptr, ppSubSystem)
    GetPortProperties(sPortNumber, pPortProp)
      => ComCall(5, this.p, Int16, sPortNumber, VDS_PORT_PROP.Ptr, pPortProp)
    FlushCache()
      => ComCall(6, this.p)
    InvalidateCache()
      => ComCall(7, this.p)
    Reset()
      => ComCall(8, this.p)
    QueryAssociatedLuns(ppEnum)
      => ComCall(9, this.p, IEnumVdsObject.Ptr, ppEnum)
    SetStatus(status)
      => ComCall(10, this.p, VDS_CONTROLLER_STATUS, status)
}
struct IVdsControllerControllerPort extends IUnknown {
    static IID := "{CA5D735F-6BAE-42C0-B30E-F2666045CE71}"
    QueryControllerPorts(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsDrive extends IUnknown {
    static IID := "{FF24EFA4-AADE-4B6B-898B-EAA6A20887C7}"
    GetProperties(pDriveProp)
      => ComCall(3, this.p, VDS_DRIVE_PROP.Ptr, pDriveProp)
    GetSubSystem(ppSubSystem)
      => ComCall(4, this.p, IVdsSubSystem.Ptr, ppSubSystem)
    QueryExtents(ppExtentArray)
      => ComCall(5, this.p, VDS_DRIVE_EXTENT.Ptr.Ptr, ppExtentArray, Int32.Ptr, ppExtentArray.Length)
    SetFlags(ulFlags)
      => ComCall(6, this.p, UInt32, ulFlags)
    ClearFlags(ulFlags)
      => ComCall(7, this.p, UInt32, ulFlags)
    SetStatus(status)
      => ComCall(8, this.p, VDS_DRIVE_STATUS, status)
}
struct IVdsDrive2 extends IUnknown {
    static IID := "{60B5A730-ADDF-4436-8CA7-5769E2D1FFA4}"
    GetProperties2(pDriveProp2)
      => ComCall(3, this.p, VDS_DRIVE_PROP2.Ptr, pDriveProp2)
}
struct IVdsLun extends IUnknown {
    static IID := "{3540A9C7-E60F-4111-A840-8BBA6C2C83D8}"
    GetProperties(pLunProp)
      => ComCall(3, this.p, VDS_LUN_PROP.Ptr, pLunProp)
    GetSubSystem(ppSubSystem)
      => ComCall(4, this.p, IVdsSubSystem.Ptr, ppSubSystem)
    GetIdentificationData(pLunInfo)
      => ComCall(5, this.p, VDS_LUN_INFORMATION.Ptr, pLunInfo)
    QueryActiveControllers(ppEnum)
      => ComCall(6, this.p, IEnumVdsObject.Ptr, ppEnum)
    Extend(ullNumberOfBytesToAdd, pDriveIdArray, ppAsync)
      => ComCall(7, this.p, Int64, ullNumberOfBytesToAdd, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, IVdsAsync.Ptr, ppAsync)
    Shrink(ullNumberOfBytesToRemove, ppAsync)
      => ComCall(8, this.p, Int64, ullNumberOfBytesToRemove, IVdsAsync.Ptr, ppAsync)
    QueryPlexes(ppEnum)
      => ComCall(9, this.p, IEnumVdsObject.Ptr, ppEnum)
    AddPlex(lunId, ppAsync)
      => ComCall(10, this.p, GUID, lunId, IVdsAsync.Ptr, ppAsync)
    RemovePlex(plexId, ppAsync)
      => ComCall(11, this.p, GUID, plexId, IVdsAsync.Ptr, ppAsync)
    Recover(ppAsync)
      => ComCall(12, this.p, IVdsAsync.Ptr, ppAsync)
    SetMask(pwszUnmaskingList)
      => ComCall(13, this.p, "Str", pwszUnmaskingList)
    Delete()
      => ComCall(14, this.p)
    AssociateControllers(pActiveControllerIdArray, pInactiveControllerIdArray)
      => ComCall(15, this.p, GUID.Ptr, pActiveControllerIdArray, Int32, pActiveControllerIdArray.Length, GUID.Ptr, pInactiveControllerIdArray, Int32, pInactiveControllerIdArray.Length)
    QueryHints(pHints)
      => ComCall(16, this.p, VDS_HINTS.Ptr, pHints)
    ApplyHints(pHints)
      => ComCall(17, this.p, VDS_HINTS.Ptr, pHints)
    SetStatus(status)
      => ComCall(18, this.p, VDS_LUN_STATUS, status)
    QueryMaxLunExtendSize(pDriveIdArray, pullMaxBytesToBeAdded)
      => ComCall(19, this.p, GUID.Ptr, pDriveIdArray, Int32, pDriveIdArray.Length, Int64.Ptr, pullMaxBytesToBeAdded)
}
struct IVdsLun2 extends IUnknown {
    static IID := "{E5B3A735-9EFB-499A-8071-4394D9EE6FCB}"
    QueryHints2(pHints2)
      => ComCall(3, this.p, VDS_HINTS2.Ptr, pHints2)
    ApplyHints2(pHints2)
      => ComCall(4, this.p, VDS_HINTS2.Ptr, pHints2)
}
struct IVdsLunNaming extends IUnknown {
    static IID := "{907504CB-6B4E-4D88-A34D-17BA661FBB06}"
    SetFriendlyName(pwszFriendlyName)
      => ComCall(3, this.p, "Str", pwszFriendlyName)
}
struct IVdsLunNumber extends IUnknown {
    static IID := "{D3F95E46-54B3-41F9-B678-0F1871443A08}"
    GetLunNumber(pulLunNumber)
      => ComCall(3, this.p, UInt32.Ptr, pulLunNumber)
}
struct IVdsLunControllerPorts extends IUnknown {
    static IID := "{451FE266-DA6D-406A-BB60-82E534F85AEB}"
    AssociateControllerPorts(pActiveControllerPortIdArray, pInactiveControllerPortIdArray)
      => ComCall(3, this.p, GUID.Ptr, pActiveControllerPortIdArray, Int32, pActiveControllerPortIdArray.Length, GUID.Ptr, pInactiveControllerPortIdArray, Int32, pInactiveControllerPortIdArray.Length)
    QueryActiveControllerPorts(ppEnum)
      => ComCall(4, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsLunMpio extends IUnknown {
    static IID := "{7C5FBAE3-333A-48A1-A982-33C15788CDE3}"
    GetPathInfo(ppPaths)
      => ComCall(3, this.p, VDS_PATH_INFO.Ptr.Ptr, ppPaths, Int32.Ptr, ppPaths.Length)
    GetLoadBalancePolicy(pPolicy, ppPaths)
      => ComCall(4, this.p, VDS_LOADBALANCE_POLICY_ENUM.Ptr, pPolicy, VDS_PATH_POLICY.Ptr.Ptr, ppPaths, Int32.Ptr, ppPaths.Length)
    SetLoadBalancePolicy(policy, pPaths)
      => ComCall(5, this.p, VDS_LOADBALANCE_POLICY_ENUM, policy, VDS_PATH_POLICY.Ptr, pPaths, Int32, pPaths.Length)
    GetSupportedLbPolicies(pulLbFlags)
      => ComCall(6, this.p, UInt32.Ptr, pulLbFlags)
}
struct IVdsLunIscsi extends IUnknown {
    static IID := "{0D7C1E64-B59B-45AE-B86A-2C2CC6A42067}"
    AssociateTargets(pTargetIdArray)
      => ComCall(3, this.p, GUID.Ptr, pTargetIdArray, Int32, pTargetIdArray.Length)
    QueryAssociatedTargets(ppEnum)
      => ComCall(4, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsLunPlex extends IUnknown {
    static IID := "{0EE1A790-5D2E-4ABB-8C99-C481E8BE2138}"
    GetProperties(pPlexProp)
      => ComCall(3, this.p, VDS_LUN_PLEX_PROP.Ptr, pPlexProp)
    GetLun(ppLun)
      => ComCall(4, this.p, IVdsLun.Ptr, ppLun)
    QueryExtents(ppExtentArray)
      => ComCall(5, this.p, VDS_DRIVE_EXTENT.Ptr.Ptr, ppExtentArray, Int32.Ptr, ppExtentArray.Length)
    QueryHints(pHints)
      => ComCall(6, this.p, VDS_HINTS.Ptr, pHints)
    ApplyHints(pHints)
      => ComCall(7, this.p, VDS_HINTS.Ptr, pHints)
}
struct IVdsIscsiPortal extends IUnknown {
    static IID := "{7FA1499D-EC85-4A8A-A47B-FF69201FCD34}"
    GetProperties(pPortalProp)
      => ComCall(3, this.p, VDS_ISCSI_PORTAL_PROP.Ptr, pPortalProp)
    GetSubSystem(ppSubSystem)
      => ComCall(4, this.p, IVdsSubSystem.Ptr, ppSubSystem)
    QueryAssociatedPortalGroups(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    SetStatus(status)
      => ComCall(6, this.p, VDS_ISCSI_PORTAL_STATUS, status)
    SetIpsecTunnelAddress(pTunnelAddress, pDestinationAddress)
      => ComCall(7, this.p, VDS_IPADDRESS.Ptr, pTunnelAddress, VDS_IPADDRESS.Ptr, pDestinationAddress)
    GetIpsecSecurity(pInitiatorPortalAddress, pullSecurityFlags)
      => ComCall(8, this.p, VDS_IPADDRESS.Ptr, pInitiatorPortalAddress, Int64.Ptr, pullSecurityFlags)
    SetIpsecSecurity(pInitiatorPortalAddress, ullSecurityFlags, pIpsecKey)
      => ComCall(9, this.p, VDS_IPADDRESS.Ptr, pInitiatorPortalAddress, Int64, ullSecurityFlags, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
}
struct IVdsIscsiTarget extends IUnknown {
    static IID := "{AA8F5055-83E5-4BCC-AA73-19851A36A849}"
    GetProperties(pTargetProp)
      => ComCall(3, this.p, VDS_ISCSI_TARGET_PROP.Ptr, pTargetProp)
    GetSubSystem(ppSubSystem)
      => ComCall(4, this.p, IVdsSubSystem.Ptr, ppSubSystem)
    QueryPortalGroups(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryAssociatedLuns(ppEnum)
      => ComCall(6, this.p, IEnumVdsObject.Ptr, ppEnum)
    CreatePortalGroup(ppAsync)
      => ComCall(7, this.p, IVdsAsync.Ptr, ppAsync)
    Delete(ppAsync)
      => ComCall(8, this.p, IVdsAsync.Ptr, ppAsync)
    SetFriendlyName(pwszFriendlyName)
      => ComCall(9, this.p, "Str", pwszFriendlyName)
    SetSharedSecret(pTargetSharedSecret, pwszInitiatorName)
      => ComCall(10, this.p, VDS_ISCSI_SHARED_SECRET.Ptr, pTargetSharedSecret, "Str", pwszInitiatorName)
    RememberInitiatorSharedSecret(pwszInitiatorName, pInitiatorSharedSecret)
      => ComCall(11, this.p, "Str", pwszInitiatorName, VDS_ISCSI_SHARED_SECRET.Ptr, pInitiatorSharedSecret)
    GetConnectedInitiators(pppwszInitiatorList)
      => ComCall(12, this.p, PWSTR.Ptr.Ptr, pppwszInitiatorList, Int32.Ptr, pppwszInitiatorList.Length)
}
struct IVdsIscsiPortalGroup extends IUnknown {
    static IID := "{FEF5F89D-A3DD-4B36-BF28-E7DDE045C593}"
    GetProperties(pPortalGroupProp)
      => ComCall(3, this.p, VDS_ISCSI_PORTALGROUP_PROP.Ptr, pPortalGroupProp)
    GetTarget(ppTarget)
      => ComCall(4, this.p, IVdsIscsiTarget.Ptr, ppTarget)
    QueryAssociatedPortals(ppEnum)
      => ComCall(5, this.p, IEnumVdsObject.Ptr, ppEnum)
    AddPortal(portalId, ppAsync)
      => ComCall(6, this.p, GUID, portalId, IVdsAsync.Ptr, ppAsync)
    RemovePortal(portalId, ppAsync)
      => ComCall(7, this.p, GUID, portalId, IVdsAsync.Ptr, ppAsync)
    Delete(ppAsync)
      => ComCall(8, this.p, IVdsAsync.Ptr, ppAsync)
}
struct IVdsStoragePool extends IUnknown {
    static IID := "{932CA8CF-0EB3-4BA8-9620-22665D7F8450}"
    GetProvider(ppProvider)
      => ComCall(3, this.p, IVdsProvider.Ptr, ppProvider)
    GetProperties(pStoragePoolProp)
      => ComCall(4, this.p, VDS_STORAGE_POOL_PROP.Ptr, pStoragePoolProp)
    GetAttributes(pStoragePoolAttributes)
      => ComCall(5, this.p, VDS_POOL_ATTRIBUTES.Ptr, pStoragePoolAttributes)
    QueryDriveExtents(ppExtentArray)
      => ComCall(6, this.p, VDS_STORAGE_POOL_DRIVE_EXTENT.Ptr.Ptr, ppExtentArray, Int32.Ptr, ppExtentArray.Length)
    QueryAllocatedLuns(ppEnum)
      => ComCall(7, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryAllocatedStoragePools(ppEnum)
      => ComCall(8, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsMaintenance extends IUnknown {
    static IID := "{DAEBEEF3-8523-47ED-A2B9-05CECCE2A1AE}"
    StartMaintenance(operation)
      => ComCall(3, this.p, VDS_MAINTENANCE_OPERATION, operation)
    StopMaintenance(operation)
      => ComCall(4, this.p, VDS_MAINTENANCE_OPERATION, operation)
    PulseMaintenance(operation, ulCount)
      => ComCall(5, this.p, VDS_MAINTENANCE_OPERATION, operation, UInt32, ulCount)
}
struct VDS_CREATE_VDISK_PARAMETERS {
    UniqueId : GUID
    MaximumSize : Int64
    BlockSizeInBytes : UInt32
    SectorSizeInBytes : UInt32
    pParentPath : PWSTR
    pSourcePath : PWSTR
}
struct IVdsVdProvider extends IUnknown {
    static IID := "{B481498C-8354-45F9-84A0-0BDD2832A91F}"
    QueryVDisks(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
    CreateVDisk(VirtualDeviceType, pPath, pStringSecurityDescriptor, Flags, ProviderSpecificFlags, Reserved, pCreateDiskParameters, ppAsync)
      => ComCall(4, this.p, VIRTUAL_STORAGE_TYPE.Ptr, VirtualDeviceType, "Str", pPath, "Str", pStringSecurityDescriptor, CREATE_VIRTUAL_DISK_FLAG, Flags, UInt32, ProviderSpecificFlags, UInt32, Reserved, VDS_CREATE_VDISK_PARAMETERS.Ptr, pCreateDiskParameters, IVdsAsync.Ptr, ppAsync)
    AddVDisk(VirtualDeviceType, pPath, ppVDisk)
      => ComCall(5, this.p, VIRTUAL_STORAGE_TYPE.Ptr, VirtualDeviceType, "Str", pPath, IVdsVDisk.Ptr, ppVDisk)
    GetDiskFromVDisk(pVDisk, ppDisk)
      => ComCall(6, this.p, IVdsVDisk, pVDisk, IVdsDisk.Ptr, ppDisk)
    GetVDiskFromDisk(pDisk, ppVDisk)
      => ComCall(7, this.p, IVdsDisk, pDisk, IVdsVDisk.Ptr, ppVDisk)
}
struct VDS_VDISK_STATE extends Int32 {
    static VDS_VST_UNKNOWN := 0
    static VDS_VST_ADDED := 1
    static VDS_VST_OPEN := 2
    static VDS_VST_ATTACH_PENDING := 3
    static VDS_VST_ATTACHED_NOT_OPEN := 4
    static VDS_VST_ATTACHED := 5
    static VDS_VST_DETACH_PENDING := 6
    static VDS_VST_COMPACTING := 7
    static VDS_VST_MERGING := 8
    static VDS_VST_EXPANDING := 9
    static VDS_VST_DELETED := 10
    static VDS_VST_MAX := 11
}
struct VDS_VDISK_PROPERTIES {
    Id : GUID
    State : VDS_VDISK_STATE
    VirtualDeviceType : VIRTUAL_STORAGE_TYPE
    VirtualSize : Int64
    PhysicalSize : Int64
    pPath : PWSTR
    pDeviceName : PWSTR
    DiskFlag : DEPENDENT_DISK_FLAG
    bIsChild : BOOL
    pParentPath : PWSTR
}
struct IVdsVDisk extends IUnknown {
    static IID := "{1E062B84-E5E6-4B4B-8A25-67B81E8F13E8}"
    Open(AccessMask, Flags, ReadWriteDepth, ppOpenVDisk)
      => ComCall(3, this.p, VIRTUAL_DISK_ACCESS_MASK, AccessMask, OPEN_VIRTUAL_DISK_FLAG, Flags, UInt32, ReadWriteDepth, IVdsOpenVDisk.Ptr, ppOpenVDisk)
    GetProperties(pDiskProperties)
      => ComCall(4, this.p, VDS_VDISK_PROPERTIES.Ptr, pDiskProperties)
    GetHostVolume(ppVolume)
      => ComCall(5, this.p, IVdsVolume.Ptr, ppVolume)
    GetDeviceName(ppDeviceName)
      => ComCall(6, this.p, PWSTR.Ptr, ppDeviceName)
}
struct IVdsOpenVDisk extends IUnknown {
    static IID := "{75C8F324-F715-4FE3-A28E-F9011B61A4A1}"
    Attach(pStringSecurityDescriptor, Flags, ProviderSpecificFlags, TimeoutInMs, ppAsync)
      => ComCall(3, this.p, "Str", pStringSecurityDescriptor, ATTACH_VIRTUAL_DISK_FLAG, Flags, UInt32, ProviderSpecificFlags, UInt32, TimeoutInMs, IVdsAsync.Ptr, ppAsync)
    Detach(Flags, ProviderSpecificFlags)
      => ComCall(4, this.p, DETACH_VIRTUAL_DISK_FLAG, Flags, UInt32, ProviderSpecificFlags)
    DetachAndDelete(Flags, ProviderSpecificFlags)
      => ComCall(5, this.p, DETACH_VIRTUAL_DISK_FLAG, Flags, UInt32, ProviderSpecificFlags)
    Compact(Flags, Reserved, ppAsync)
      => ComCall(6, this.p, COMPACT_VIRTUAL_DISK_FLAG, Flags, UInt32, Reserved, IVdsAsync.Ptr, ppAsync)
    Merge(Flags, MergeDepth, ppAsync)
      => ComCall(7, this.p, MERGE_VIRTUAL_DISK_FLAG, Flags, UInt32, MergeDepth, IVdsAsync.Ptr, ppAsync)
    Expand(Flags, NewSize, ppAsync)
      => ComCall(8, this.p, EXPAND_VIRTUAL_DISK_FLAG, Flags, Int64, NewSize, IVdsAsync.Ptr, ppAsync)
}
struct VDS_SERVICE_FLAG extends Int32 {
    static VDS_SVF_SUPPORT_DYNAMIC := 1
    static VDS_SVF_SUPPORT_FAULT_TOLERANT := 2
    static VDS_SVF_SUPPORT_GPT := 4
    static VDS_SVF_SUPPORT_DYNAMIC_1394 := 8
    static VDS_SVF_CLUSTER_SERVICE_CONFIGURED := 16
    static VDS_SVF_AUTO_MOUNT_OFF := 32
    static VDS_SVF_OS_UNINSTALL_VALID := 64
    static VDS_SVF_EFI := 128
    static VDS_SVF_SUPPORT_MIRROR := 256
    static VDS_SVF_SUPPORT_RAID5 := 512
    static VDS_SVF_SUPPORT_REFS := 1024
}
struct VDS_SERVICE_PROP {
    pwszVersion : PWSTR
    ulFlags : UInt32
}
struct VDS_SAN_POLICY extends Int32 {
    static VDS_SP_UNKNOWN := 0
    static VDS_SP_ONLINE := 1
    static VDS_SP_OFFLINE_SHARED := 2
    static VDS_SP_OFFLINE := 3
    static VDS_SP_OFFLINE_INTERNAL := 4
    static VDS_SP_MAX := 5
}
struct VDS_REPARSE_POINT_PROP {
    SourceVolumeId : GUID
    pwszPath : PWSTR
}
struct VDS_DRIVE_LETTER_FLAG extends Int32 {
    static VDS_DLF_NON_PERSISTENT := 1
}
struct VDS_DRIVE_LETTER_PROP {
    wcLetter : UInt16
    volumeId : GUID
    ulFlags : UInt32
    bUsed : BOOL
}
struct VDS_FILE_SYSTEM_FLAG extends Int32 {
    static VDS_FSF_SUPPORT_FORMAT := 1
    static VDS_FSF_SUPPORT_QUICK_FORMAT := 2
    static VDS_FSF_SUPPORT_COMPRESS := 4
    static VDS_FSF_SUPPORT_SPECIFY_LABEL := 8
    static VDS_FSF_SUPPORT_MOUNT_POINT := 16
    static VDS_FSF_SUPPORT_REMOVABLE_MEDIA := 32
    static VDS_FSF_SUPPORT_EXTEND := 64
    static VDS_FSF_ALLOCATION_UNIT_512 := 65536
    static VDS_FSF_ALLOCATION_UNIT_1K := 131072
    static VDS_FSF_ALLOCATION_UNIT_2K := 262144
    static VDS_FSF_ALLOCATION_UNIT_4K := 524288
    static VDS_FSF_ALLOCATION_UNIT_8K := 1048576
    static VDS_FSF_ALLOCATION_UNIT_16K := 2097152
    static VDS_FSF_ALLOCATION_UNIT_32K := 4194304
    static VDS_FSF_ALLOCATION_UNIT_64K := 8388608
    static VDS_FSF_ALLOCATION_UNIT_128K := 16777216
    static VDS_FSF_ALLOCATION_UNIT_256K := 33554432
}
struct VDS_FILE_SYSTEM_TYPE_PROP {
    type : VDS_FILE_SYSTEM_TYPE
    wszName : UInt16[8]
    ulFlags : UInt32
    ulCompressionFlags : UInt32
    ulMaxLableLength : UInt32
    pwszIllegalLabelCharSet : PWSTR
}
struct VDS_FILE_SYSTEM_FORMAT_SUPPORT_FLAG extends Int32 {
    static VDS_FSS_DEFAULT := 1
    static VDS_FSS_PREVIOUS_REVISION := 2
    static VDS_FSS_RECOMMENDED := 4
}
struct VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP {
    ulFlags : UInt32
    usRevision : UInt16
    ulDefaultUnitAllocationSize : UInt32
    rgulAllowedUnitAllocationSizes : UInt32[32]
    wszName : UInt16[32]
}
struct VDS_FILE_SYSTEM_PROP_FLAG extends Int32 {
    static VDS_FPF_COMPRESSED := 1
}
struct VDS_FORMAT_OPTION_FLAGS extends Int32 {
    static VDS_FSOF_NONE := 0
    static VDS_FSOF_FORCE := 1
    static VDS_FSOF_QUICK := 2
    static VDS_FSOF_COMPRESSION := 4
    static VDS_FSOF_DUPLICATE_METADATA := 8
}
struct VDS_FILE_SYSTEM_PROP {
    type : VDS_FILE_SYSTEM_TYPE
    volumeId : GUID
    ulFlags : UInt32
    ullTotalAllocationUnits : Int64
    ullAvailableAllocationUnits : Int64
    ulAllocationUnitSize : UInt32
    pwszLabel : PWSTR
}
struct VDS_QUERY_PROVIDER_FLAG extends Int32 {
    static VDS_QUERY_SOFTWARE_PROVIDERS := 1
    static VDS_QUERY_HARDWARE_PROVIDERS := 2
    static VDS_QUERY_VIRTUALDISK_PROVIDERS := 4
}
struct IVdsServiceLoader extends IUnknown {
    static IID := "{E0393303-90D4-4A97-AB71-E9B671EE2729}"
    LoadService(pwszMachineName, ppService)
      => ComCall(3, this.p, "Str", pwszMachineName, IVdsService.Ptr, ppService)
}
struct IVdsService extends IUnknown {
    static IID := "{0818A8EF-9BA9-40D8-A6F9-E22833CC771E}"
    IsServiceReady()
      => ComCall(3, this.p)
    WaitForServiceReady()
      => ComCall(4, this.p)
    GetProperties(pServiceProp)
      => ComCall(5, this.p, VDS_SERVICE_PROP.Ptr, pServiceProp)
    QueryProviders(masks, ppEnum)
      => ComCall(6, this.p, UInt32, masks, IEnumVdsObject.Ptr, ppEnum)
    QueryMaskedDisks(ppEnum)
      => ComCall(7, this.p, IEnumVdsObject.Ptr, ppEnum)
    QueryUnallocatedDisks(ppEnum)
      => ComCall(8, this.p, IEnumVdsObject.Ptr, ppEnum)
    GetObject(ObjectId, type, ppObjectUnk)
      => ComCall(9, this.p, GUID, ObjectId, VDS_OBJECT_TYPE, type, IUnknown.Ptr, ppObjectUnk)
    QueryDriveLetters(wcFirstLetter, pDriveLetterPropArray)
      => ComCall(10, this.p, UInt16, wcFirstLetter, UInt32, pDriveLetterPropArray.Length, VDS_DRIVE_LETTER_PROP.Ptr, pDriveLetterPropArray)
    QueryFileSystemTypes(ppFileSystemTypeProps)
      => ComCall(11, this.p, VDS_FILE_SYSTEM_TYPE_PROP.Ptr.Ptr, ppFileSystemTypeProps, Int32.Ptr, ppFileSystemTypeProps.Length)
    Reenumerate()
      => ComCall(12, this.p)
    Refresh()
      => ComCall(13, this.p)
    CleanupObsoleteMountPoints()
      => ComCall(14, this.p)
    Advise(pSink, pdwCookie)
      => ComCall(15, this.p, IVdsAdviseSink, pSink, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(16, this.p, UInt32, dwCookie)
    Reboot()
      => ComCall(17, this.p)
    SetFlags(ulFlags)
      => ComCall(18, this.p, UInt32, ulFlags)
    ClearFlags(ulFlags)
      => ComCall(19, this.p, UInt32, ulFlags)
}
struct IVdsServiceUninstallDisk extends IUnknown {
    static IID := "{B6B22DA8-F903-4BE7-B492-C09D875AC9DA}"
    GetDiskIdFromLunInfo(pLunInfo, pDiskId)
      => ComCall(3, this.p, VDS_LUN_INFORMATION.Ptr, pLunInfo, GUID.Ptr, pDiskId)
    UninstallDisks(pDiskIdArray, bForce, pbReboot, pResults)
      => ComCall(4, this.p, GUID.Ptr, pDiskIdArray, UInt32, pResults.Length, BOOLEAN, bForce, UInt8.Ptr, pbReboot, HRESULT.Ptr, pResults)
}
struct IVdsServiceHba extends IUnknown {
    static IID := "{0AC13689-3134-47C6-A17C-4669216801BE}"
    QueryHbaPorts(ppEnum)
      => ComCall(3, this.p, IEnumVdsObject.Ptr, ppEnum)
}
struct IVdsServiceIscsi extends IUnknown {
    static IID := "{14FBE036-3ED7-4E10-90E9-A5FF991AFF01}"
    GetInitiatorName(ppwszIscsiName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszIscsiName)
    QueryInitiatorAdapters(ppEnum)
      => ComCall(4, this.p, IEnumVdsObject.Ptr, ppEnum)
    SetIpsecGroupPresharedKey(pIpsecKey)
      => ComCall(5, this.p, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
    SetAllIpsecTunnelAddresses(pTunnelAddress, pDestinationAddress)
      => ComCall(6, this.p, VDS_IPADDRESS.Ptr, pTunnelAddress, VDS_IPADDRESS.Ptr, pDestinationAddress)
    SetAllIpsecSecurity(targetPortalId, ullSecurityFlags, pIpsecKey)
      => ComCall(7, this.p, GUID, targetPortalId, Int64, ullSecurityFlags, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
    SetInitiatorSharedSecret(pInitiatorSharedSecret, targetId)
      => ComCall(8, this.p, VDS_ISCSI_SHARED_SECRET.Ptr, pInitiatorSharedSecret, GUID, targetId)
    RememberTargetSharedSecret(targetId, pTargetSharedSecret)
      => ComCall(9, this.p, GUID, targetId, VDS_ISCSI_SHARED_SECRET.Ptr, pTargetSharedSecret)
}
struct IVdsServiceInitialization extends IUnknown {
    static IID := "{4AFC3636-DB01-4052-80C3-03BBCB8D3C69}"
    Initialize(pwszMachineName)
      => ComCall(3, this.p, "Str", pwszMachineName)
}
struct IVdsHbaPort extends IUnknown {
    static IID := "{2ABD757F-2851-4997-9A13-47D2A885D6CA}"
    GetProperties(pHbaPortProp)
      => ComCall(3, this.p, VDS_HBAPORT_PROP.Ptr, pHbaPortProp)
    SetAllPathStatuses(status)
      => ComCall(4, this.p, VDS_PATH_STATUS, status)
}
struct IVdsIscsiInitiatorAdapter extends IUnknown {
    static IID := "{B07FEDD4-1682-4440-9189-A39B55194DC5}"
    GetProperties(pInitiatorAdapterProp)
      => ComCall(3, this.p, VDS_ISCSI_INITIATOR_ADAPTER_PROP.Ptr, pInitiatorAdapterProp)
    QueryInitiatorPortals(ppEnum)
      => ComCall(4, this.p, IEnumVdsObject.Ptr, ppEnum)
    LoginToTarget(loginType, targetId, targetPortalId, initiatorPortalId, ulLoginFlags, bHeaderDigest, bDataDigest, authType, ppAsync)
      => ComCall(5, this.p, VDS_ISCSI_LOGIN_TYPE, loginType, GUID, targetId, GUID, targetPortalId, GUID, initiatorPortalId, UInt32, ulLoginFlags, BOOL, bHeaderDigest, BOOL, bDataDigest, VDS_ISCSI_AUTH_TYPE, authType, IVdsAsync.Ptr, ppAsync)
    LogoutFromTarget(targetId, ppAsync)
      => ComCall(6, this.p, GUID, targetId, IVdsAsync.Ptr, ppAsync)
}
struct IVdsIscsiInitiatorPortal extends IUnknown {
    static IID := "{38A0A9AB-7CC8-4693-AC07-1F28BD03C3DA}"
    GetProperties(pInitiatorPortalProp)
      => ComCall(3, this.p, VDS_ISCSI_INITIATOR_PORTAL_PROP.Ptr, pInitiatorPortalProp)
    GetInitiatorAdapter(ppInitiatorAdapter)
      => ComCall(4, this.p, IVdsIscsiInitiatorAdapter.Ptr, ppInitiatorAdapter)
    SetIpsecTunnelAddress(pTunnelAddress, pDestinationAddress)
      => ComCall(5, this.p, VDS_IPADDRESS.Ptr, pTunnelAddress, VDS_IPADDRESS.Ptr, pDestinationAddress)
    GetIpsecSecurity(targetPortalId, pullSecurityFlags)
      => ComCall(6, this.p, GUID, targetPortalId, Int64.Ptr, pullSecurityFlags)
    SetIpsecSecurity(targetPortalId, ullSecurityFlags, pIpsecKey)
      => ComCall(7, this.p, GUID, targetPortalId, Int64, ullSecurityFlags, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
}
struct IVdsDiskPartitionMF extends IUnknown {
    static IID := "{538684E0-BA3D-4BC0-ACA9-164AFF85C2A9}"
    GetPartitionFileSystemProperties(ullOffset, pFileSystemProp)
      => ComCall(3, this.p, Int64, ullOffset, VDS_FILE_SYSTEM_PROP.Ptr, pFileSystemProp)
    GetPartitionFileSystemTypeName(ullOffset, ppwszFileSystemTypeName)
      => ComCall(4, this.p, Int64, ullOffset, PWSTR.Ptr, ppwszFileSystemTypeName)
    QueryPartitionFileSystemFormatSupport(ullOffset, ppFileSystemSupportProps)
      => ComCall(5, this.p, Int64, ullOffset, VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP.Ptr.Ptr, ppFileSystemSupportProps, Int32.Ptr, ppFileSystemSupportProps.Length)
    FormatPartitionEx(ullOffset, pwszFileSystemTypeName, usFileSystemRevision, ulDesiredUnitAllocationSize, pwszLabel, bForce, bQuickFormat, bEnableCompression, ppAsync)
      => ComCall(6, this.p, Int64, ullOffset, "Str", pwszFileSystemTypeName, UInt16, usFileSystemRevision, UInt32, ulDesiredUnitAllocationSize, "Str", pwszLabel, BOOL, bForce, BOOL, bQuickFormat, BOOL, bEnableCompression, IVdsAsync.Ptr, ppAsync)
}
struct IVdsVolumeMF extends IUnknown {
    static IID := "{EE2D5DED-6236-4169-931D-B9778CE03DC6}"
    GetFileSystemProperties(pFileSystemProp)
      => ComCall(3, this.p, VDS_FILE_SYSTEM_PROP.Ptr, pFileSystemProp)
    Format(type, pwszLabel, dwUnitAllocationSize, bForce, bQuickFormat, bEnableCompression, ppAsync)
      => ComCall(4, this.p, VDS_FILE_SYSTEM_TYPE, type, "Str", pwszLabel, UInt32, dwUnitAllocationSize, BOOL, bForce, BOOL, bQuickFormat, BOOL, bEnableCompression, IVdsAsync.Ptr, ppAsync)
    AddAccessPath(pwszPath)
      => ComCall(5, this.p, "Str", pwszPath)
    QueryAccessPaths(pwszPathArray)
      => ComCall(6, this.p, PWSTR.Ptr.Ptr, pwszPathArray, Int32.Ptr, pwszPathArray.Length)
    QueryReparsePoints(ppReparsePointProps)
      => ComCall(7, this.p, VDS_REPARSE_POINT_PROP.Ptr.Ptr, ppReparsePointProps, Int32.Ptr, ppReparsePointProps.Length)
    DeleteAccessPath(pwszPath, bForce)
      => ComCall(8, this.p, "Str", pwszPath, BOOL, bForce)
    Mount()
      => ComCall(9, this.p)
    Dismount(bForce, bPermanent)
      => ComCall(10, this.p, BOOL, bForce, BOOL, bPermanent)
    SetFileSystemFlags(ulFlags)
      => ComCall(11, this.p, UInt32, ulFlags)
    ClearFileSystemFlags(ulFlags)
      => ComCall(12, this.p, UInt32, ulFlags)
}
struct IVdsVolumeMF2 extends IUnknown {
    static IID := "{4DBCEE9A-6343-4651-B85F-5E75D74D983C}"
    GetFileSystemTypeName(ppwszFileSystemTypeName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszFileSystemTypeName)
    QueryFileSystemFormatSupport(ppFileSystemSupportProps)
      => ComCall(4, this.p, VDS_FILE_SYSTEM_FORMAT_SUPPORT_PROP.Ptr.Ptr, ppFileSystemSupportProps, Int32.Ptr, ppFileSystemSupportProps.Length)
    FormatEx(pwszFileSystemTypeName, usFileSystemRevision, ulDesiredUnitAllocationSize, pwszLabel, bForce, bQuickFormat, bEnableCompression, ppAsync)
      => ComCall(5, this.p, "Str", pwszFileSystemTypeName, UInt16, usFileSystemRevision, UInt32, ulDesiredUnitAllocationSize, "Str", pwszLabel, BOOL, bForce, BOOL, bQuickFormat, BOOL, bEnableCompression, IVdsAsync.Ptr, ppAsync)
}
struct IVdsVolumeShrink extends IUnknown {
    static IID := "{D68168C9-82A2-4F85-B6E9-74707C49A58F}"
    QueryMaxReclaimableBytes(pullMaxNumberOfReclaimableBytes)
      => ComCall(3, this.p, Int64.Ptr, pullMaxNumberOfReclaimableBytes)
    Shrink(ullDesiredNumberOfReclaimableBytes, ullMinNumberOfReclaimableBytes, ppAsync)
      => ComCall(4, this.p, Int64, ullDesiredNumberOfReclaimableBytes, Int64, ullMinNumberOfReclaimableBytes, IVdsAsync.Ptr, ppAsync)
}
struct IVdsSubSystemImportTarget extends IUnknown {
    static IID := "{83BFB87F-43FB-4903-BAA6-127F01029EEC}"
    GetImportTarget(ppwszIscsiName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszIscsiName)
    SetImportTarget(pwszIscsiName)
      => ComCall(4, this.p, "Str", pwszIscsiName)
}
struct IVdsIscsiPortalLocal extends IUnknown {
    static IID := "{AD837C28-52C1-421D-BF04-FAE7DA665396}"
    SetIpsecSecurityLocal(ullSecurityFlags, pIpsecKey)
      => ComCall(3, this.p, Int64, ullSecurityFlags, VDS_ISCSI_IPSEC_KEY.Ptr, pIpsecKey)
}
struct IVdsServiceSAN extends IUnknown {
    static IID := "{FC5D23E8-A88B-41A5-8DE0-2D2F73C5A630}"
    GetSANPolicy(pSanPolicy)
      => ComCall(3, this.p, VDS_SAN_POLICY.Ptr, pSanPolicy)
    SetSANPolicy(SanPolicy)
      => ComCall(4, this.p, VDS_SAN_POLICY, SanPolicy)
}
struct IVdsVolumeMF3 extends IUnknown {
    static IID := "{6788FAF9-214E-4B85-BA59-266953616E09}"
    QueryVolumeGuidPathnames(pwszPathArray)
      => ComCall(3, this.p, PWSTR.Ptr.Ptr, pwszPathArray, UInt32.Ptr, pwszPathArray.Length)
    FormatEx2(pwszFileSystemTypeName, usFileSystemRevision, ulDesiredUnitAllocationSize, pwszLabel, Options, ppAsync)
      => ComCall(4, this.p, "Str", pwszFileSystemTypeName, UInt16, usFileSystemRevision, UInt32, ulDesiredUnitAllocationSize, "Str", pwszLabel, UInt32, Options, IVdsAsync.Ptr, ppAsync)
    OfflineVolume()
      => ComCall(5, this.p)
}
struct IVdsDiskPartitionMF2 extends IUnknown {
    static IID := "{9CBE50CA-F2D2-4BF4-ACE1-96896B729625}"
    FormatPartitionEx2(ullOffset, pwszFileSystemTypeName, usFileSystemRevision, ulDesiredUnitAllocationSize, pwszLabel, Options, ppAsync)
      => ComCall(3, this.p, Int64, ullOffset, "Str", pwszFileSystemTypeName, UInt16, usFileSystemRevision, UInt32, ulDesiredUnitAllocationSize, "Str", pwszLabel, UInt32, Options, IVdsAsync.Ptr, ppAsync)
}
struct IVdsServiceSw extends IUnknown {
    static IID := "{15FC031C-0652-4306-B2C3-F558B8F837E2}"
    GetDiskObject(pwszDeviceID, ppDiskUnk)
      => ComCall(3, this.p, "Str", pwszDeviceID, IUnknown.Ptr, ppDiskUnk)
}
