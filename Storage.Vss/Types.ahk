#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMDocument}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, PWSTR}
#Import "..\Storage.VirtualDiskService\Types.ahk" {VDS_LUN_INFORMATION}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct VSS_OBJECT_TYPE extends Int32 {
    static VSS_OBJECT_UNKNOWN := 0
    static VSS_OBJECT_NONE := 1
    static VSS_OBJECT_SNAPSHOT_SET := 2
    static VSS_OBJECT_SNAPSHOT := 3
    static VSS_OBJECT_PROVIDER := 4
    static VSS_OBJECT_TYPE_COUNT := 5
}
struct VSS_SNAPSHOT_STATE extends Int32 {
    static VSS_SS_UNKNOWN := 0
    static VSS_SS_PREPARING := 1
    static VSS_SS_PROCESSING_PREPARE := 2
    static VSS_SS_PREPARED := 3
    static VSS_SS_PROCESSING_PRECOMMIT := 4
    static VSS_SS_PRECOMMITTED := 5
    static VSS_SS_PROCESSING_COMMIT := 6
    static VSS_SS_COMMITTED := 7
    static VSS_SS_PROCESSING_POSTCOMMIT := 8
    static VSS_SS_PROCESSING_PREFINALCOMMIT := 9
    static VSS_SS_PREFINALCOMMITTED := 10
    static VSS_SS_PROCESSING_POSTFINALCOMMIT := 11
    static VSS_SS_CREATED := 12
    static VSS_SS_ABORTED := 13
    static VSS_SS_DELETED := 14
    static VSS_SS_POSTCOMMITTED := 15
    static VSS_SS_COUNT := 16
}
struct VSS_VOLUME_SNAPSHOT_ATTRIBUTES extends Int32 {
    static VSS_VOLSNAP_ATTR_PERSISTENT := 1
    static VSS_VOLSNAP_ATTR_NO_AUTORECOVERY := 2
    static VSS_VOLSNAP_ATTR_CLIENT_ACCESSIBLE := 4
    static VSS_VOLSNAP_ATTR_NO_AUTO_RELEASE := 8
    static VSS_VOLSNAP_ATTR_NO_WRITERS := 16
    static VSS_VOLSNAP_ATTR_TRANSPORTABLE := 32
    static VSS_VOLSNAP_ATTR_NOT_SURFACED := 64
    static VSS_VOLSNAP_ATTR_NOT_TRANSACTED := 128
    static VSS_VOLSNAP_ATTR_HARDWARE_ASSISTED := 65536
    static VSS_VOLSNAP_ATTR_DIFFERENTIAL := 131072
    static VSS_VOLSNAP_ATTR_PLEX := 262144
    static VSS_VOLSNAP_ATTR_IMPORTED := 524288
    static VSS_VOLSNAP_ATTR_EXPOSED_LOCALLY := 1048576
    static VSS_VOLSNAP_ATTR_EXPOSED_REMOTELY := 2097152
    static VSS_VOLSNAP_ATTR_AUTORECOVER := 4194304
    static VSS_VOLSNAP_ATTR_ROLLBACK_RECOVERY := 8388608
    static VSS_VOLSNAP_ATTR_DELAYED_POSTSNAPSHOT := 16777216
    static VSS_VOLSNAP_ATTR_TXF_RECOVERY := 33554432
    static VSS_VOLSNAP_ATTR_FILE_SHARE := 67108864
}
struct VSS_SNAPSHOT_CONTEXT extends Int32 {
    static VSS_CTX_BACKUP := 0
    static VSS_CTX_FILE_SHARE_BACKUP := 16
    static VSS_CTX_NAS_ROLLBACK := 25
    static VSS_CTX_APP_ROLLBACK := 9
    static VSS_CTX_CLIENT_ACCESSIBLE := 29
    static VSS_CTX_CLIENT_ACCESSIBLE_WRITERS := 13
    static VSS_CTX_ALL := -1
}
struct VSS_PROVIDER_CAPABILITIES extends Int32 {
    static VSS_PRV_CAPABILITY_LEGACY := 1
    static VSS_PRV_CAPABILITY_COMPLIANT := 2
    static VSS_PRV_CAPABILITY_LUN_REPOINT := 4
    static VSS_PRV_CAPABILITY_LUN_RESYNC := 8
    static VSS_PRV_CAPABILITY_OFFLINE_CREATION := 16
    static VSS_PRV_CAPABILITY_MULTIPLE_IMPORT := 32
    static VSS_PRV_CAPABILITY_RECYCLING := 64
    static VSS_PRV_CAPABILITY_PLEX := 128
    static VSS_PRV_CAPABILITY_DIFFERENTIAL := 256
    static VSS_PRV_CAPABILITY_CLUSTERED := 512
}
struct VSS_HARDWARE_OPTIONS extends Int32 {
    static VSS_BREAKEX_FLAG_MASK_LUNS := 1
    static VSS_BREAKEX_FLAG_MAKE_READ_WRITE := 2
    static VSS_BREAKEX_FLAG_REVERT_IDENTITY_ALL := 4
    static VSS_BREAKEX_FLAG_REVERT_IDENTITY_NONE := 8
    static VSS_ONLUNSTATECHANGE_NOTIFY_READ_WRITE := 256
    static VSS_ONLUNSTATECHANGE_NOTIFY_LUN_PRE_RECOVERY := 512
    static VSS_ONLUNSTATECHANGE_NOTIFY_LUN_POST_RECOVERY := 1024
    static VSS_ONLUNSTATECHANGE_DO_MASK_LUNS := 2048
}
struct VSS_RECOVERY_OPTIONS extends Int32 {
    static VSS_RECOVERY_REVERT_IDENTITY_ALL := 256
    static VSS_RECOVERY_NO_VOLUME_CHECK := 512
}
struct VSS_WRITER_STATE extends Int32 {
    static VSS_WS_UNKNOWN := 0
    static VSS_WS_STABLE := 1
    static VSS_WS_WAITING_FOR_FREEZE := 2
    static VSS_WS_WAITING_FOR_THAW := 3
    static VSS_WS_WAITING_FOR_POST_SNAPSHOT := 4
    static VSS_WS_WAITING_FOR_BACKUP_COMPLETE := 5
    static VSS_WS_FAILED_AT_IDENTIFY := 6
    static VSS_WS_FAILED_AT_PREPARE_BACKUP := 7
    static VSS_WS_FAILED_AT_PREPARE_SNAPSHOT := 8
    static VSS_WS_FAILED_AT_FREEZE := 9
    static VSS_WS_FAILED_AT_THAW := 10
    static VSS_WS_FAILED_AT_POST_SNAPSHOT := 11
    static VSS_WS_FAILED_AT_BACKUP_COMPLETE := 12
    static VSS_WS_FAILED_AT_PRE_RESTORE := 13
    static VSS_WS_FAILED_AT_POST_RESTORE := 14
    static VSS_WS_FAILED_AT_BACKUPSHUTDOWN := 15
    static VSS_WS_COUNT := 16
}
struct VSS_BACKUP_TYPE extends Int32 {
    static VSS_BT_UNDEFINED := 0
    static VSS_BT_FULL := 1
    static VSS_BT_INCREMENTAL := 2
    static VSS_BT_DIFFERENTIAL := 3
    static VSS_BT_LOG := 4
    static VSS_BT_COPY := 5
    static VSS_BT_OTHER := 6
}
struct VSS_RESTORE_TYPE extends Int32 {
    static VSS_RTYPE_UNDEFINED := 0
    static VSS_RTYPE_BY_COPY := 1
    static VSS_RTYPE_IMPORT := 2
    static VSS_RTYPE_OTHER := 3
}
struct VSS_ROLLFORWARD_TYPE extends Int32 {
    static VSS_RF_UNDEFINED := 0
    static VSS_RF_NONE := 1
    static VSS_RF_ALL := 2
    static VSS_RF_PARTIAL := 3
}
struct VSS_PROVIDER_TYPE extends Int32 {
    static VSS_PROV_UNKNOWN := 0
    static VSS_PROV_SYSTEM := 1
    static VSS_PROV_SOFTWARE := 2
    static VSS_PROV_HARDWARE := 3
    static VSS_PROV_FILESHARE := 4
}
struct VSS_APPLICATION_LEVEL extends Int32 {
    static VSS_APP_UNKNOWN := 0
    static VSS_APP_SYSTEM := 1
    static VSS_APP_BACK_END := 2
    static VSS_APP_FRONT_END := 3
    static VSS_APP_SYSTEM_RM := 4
    static VSS_APP_AUTO := -1
}
struct VSS_SNAPSHOT_COMPATIBILITY extends Int32 {
    static VSS_SC_DISABLE_DEFRAG := 1
    static VSS_SC_DISABLE_CONTENTINDEX := 2
}
struct VSS_SNAPSHOT_PROPERTY_ID extends Int32 {
    static VSS_SPROPID_UNKNOWN := 0
    static VSS_SPROPID_SNAPSHOT_ID := 1
    static VSS_SPROPID_SNAPSHOT_SET_ID := 2
    static VSS_SPROPID_SNAPSHOTS_COUNT := 3
    static VSS_SPROPID_SNAPSHOT_DEVICE := 4
    static VSS_SPROPID_ORIGINAL_VOLUME := 5
    static VSS_SPROPID_ORIGINATING_MACHINE := 6
    static VSS_SPROPID_SERVICE_MACHINE := 7
    static VSS_SPROPID_EXPOSED_NAME := 8
    static VSS_SPROPID_EXPOSED_PATH := 9
    static VSS_SPROPID_PROVIDER_ID := 10
    static VSS_SPROPID_SNAPSHOT_ATTRIBUTES := 11
    static VSS_SPROPID_CREATION_TIMESTAMP := 12
    static VSS_SPROPID_STATUS := 13
}
struct VSS_FILE_SPEC_BACKUP_TYPE extends Int32 {
    static VSS_FSBT_FULL_BACKUP_REQUIRED := 1
    static VSS_FSBT_DIFFERENTIAL_BACKUP_REQUIRED := 2
    static VSS_FSBT_INCREMENTAL_BACKUP_REQUIRED := 4
    static VSS_FSBT_LOG_BACKUP_REQUIRED := 8
    static VSS_FSBT_FULL_SNAPSHOT_REQUIRED := 256
    static VSS_FSBT_DIFFERENTIAL_SNAPSHOT_REQUIRED := 512
    static VSS_FSBT_INCREMENTAL_SNAPSHOT_REQUIRED := 1024
    static VSS_FSBT_LOG_SNAPSHOT_REQUIRED := 2048
    static VSS_FSBT_CREATED_DURING_BACKUP := 65536
    static VSS_FSBT_ALL_BACKUP_REQUIRED := 15
    static VSS_FSBT_ALL_SNAPSHOT_REQUIRED := 3840
}
struct VSS_BACKUP_SCHEMA extends Int32 {
    static VSS_BS_UNDEFINED := 0
    static VSS_BS_DIFFERENTIAL := 1
    static VSS_BS_INCREMENTAL := 2
    static VSS_BS_EXCLUSIVE_INCREMENTAL_DIFFERENTIAL := 4
    static VSS_BS_LOG := 8
    static VSS_BS_COPY := 16
    static VSS_BS_TIMESTAMPED := 32
    static VSS_BS_LAST_MODIFY := 64
    static VSS_BS_LSN := 128
    static VSS_BS_WRITER_SUPPORTS_NEW_TARGET := 256
    static VSS_BS_WRITER_SUPPORTS_RESTORE_WITH_MOVE := 512
    static VSS_BS_INDEPENDENT_SYSTEM_STATE := 1024
    static VSS_BS_ROLLFORWARD_RESTORE := 4096
    static VSS_BS_RESTORE_RENAME := 8192
    static VSS_BS_AUTHORITATIVE_RESTORE := 16384
    static VSS_BS_WRITER_SUPPORTS_PARALLEL_RESTORES := 32768
}
struct VSS_SNAPSHOT_PROP {
    m_SnapshotId : GUID
    m_SnapshotSetId : GUID
    m_lSnapshotsCount : Int32
    m_pwszSnapshotDeviceObject : UInt16.Ptr
    m_pwszOriginalVolumeName : UInt16.Ptr
    m_pwszOriginatingMachine : UInt16.Ptr
    m_pwszServiceMachine : UInt16.Ptr
    m_pwszExposedName : UInt16.Ptr
    m_pwszExposedPath : UInt16.Ptr
    m_ProviderId : GUID
    m_lSnapshotAttributes : Int32
    m_tsCreationTimestamp : Int64
    m_eStatus : VSS_SNAPSHOT_STATE
}
struct VSS_PROVIDER_PROP {
    m_ProviderId : GUID
    m_pwszProviderName : UInt16.Ptr
    m_eProviderType : VSS_PROVIDER_TYPE
    m_pwszProviderVersion : UInt16.Ptr
    m_ProviderVersionId : GUID
    m_ClassId : GUID
}
struct VSS_OBJECT_UNION {
    union {
        Snap : VSS_SNAPSHOT_PROP
        Prov : VSS_PROVIDER_PROP
    }
}
struct VSS_OBJECT_PROP {
    Type : VSS_OBJECT_TYPE
    Obj : VSS_OBJECT_UNION
}
struct IVssEnumObject extends IUnknown {
    static IID := "{AE1C7110-2F60-11D3-8A39-00C04F72D8E3}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, VSS_OBJECT_PROP.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IVssEnumObject.Ptr, ppenum)
}
struct IVssAsync extends IUnknown {
    static IID := "{507C37B4-CF5B-4E95-B0AF-14EB9767467E}"
    Cancel()
      => ComCall(3, this.p)
    Wait(dwMilliseconds)
      => ComCall(4, this.p, UInt32, dwMilliseconds)
    QueryStatus(pHrResult, pReserved)
      => ComCall(5, this.p, HRESULT.Ptr, pHrResult, Int32.Ptr, pReserved)
}
struct VSS_USAGE_TYPE extends Int32 {
    static VSS_UT_UNDEFINED := 0
    static VSS_UT_BOOTABLESYSTEMSTATE := 1
    static VSS_UT_SYSTEMSERVICE := 2
    static VSS_UT_USERDATA := 3
    static VSS_UT_OTHER := 4
}
struct VSS_SOURCE_TYPE extends Int32 {
    static VSS_ST_UNDEFINED := 0
    static VSS_ST_TRANSACTEDDB := 1
    static VSS_ST_NONTRANSACTEDDB := 2
    static VSS_ST_OTHER := 3
}
struct VSS_RESTOREMETHOD_ENUM extends Int32 {
    static VSS_RME_UNDEFINED := 0
    static VSS_RME_RESTORE_IF_NOT_THERE := 1
    static VSS_RME_RESTORE_IF_CAN_REPLACE := 2
    static VSS_RME_STOP_RESTORE_START := 3
    static VSS_RME_RESTORE_TO_ALTERNATE_LOCATION := 4
    static VSS_RME_RESTORE_AT_REBOOT := 5
    static VSS_RME_RESTORE_AT_REBOOT_IF_CANNOT_REPLACE := 6
    static VSS_RME_CUSTOM := 7
    static VSS_RME_RESTORE_STOP_START := 8
}
struct VSS_WRITERRESTORE_ENUM extends Int32 {
    static VSS_WRE_UNDEFINED := 0
    static VSS_WRE_NEVER := 1
    static VSS_WRE_IF_REPLACE_FAILS := 2
    static VSS_WRE_ALWAYS := 3
}
struct VSS_COMPONENT_TYPE extends Int32 {
    static VSS_CT_UNDEFINED := 0
    static VSS_CT_DATABASE := 1
    static VSS_CT_FILEGROUP := 2
}
struct VSS_ALTERNATE_WRITER_STATE extends Int32 {
    static VSS_AWS_UNDEFINED := 0
    static VSS_AWS_NO_ALTERNATE_WRITER := 1
    static VSS_AWS_ALTERNATE_WRITER_EXISTS := 2
    static VSS_AWS_THIS_IS_ALTERNATE_WRITER := 3
}
struct VSS_SUBSCRIBE_MASK extends Int32 {
    static VSS_SM_POST_SNAPSHOT_FLAG := 1
    static VSS_SM_BACKUP_EVENTS_FLAG := 2
    static VSS_SM_RESTORE_EVENTS_FLAG := 4
    static VSS_SM_IO_THROTTLING_FLAG := 8
    static VSS_SM_ALL_FLAGS := -1
}
struct VSS_RESTORE_TARGET extends Int32 {
    static VSS_RT_UNDEFINED := 0
    static VSS_RT_ORIGINAL := 1
    static VSS_RT_ALTERNATE := 2
    static VSS_RT_DIRECTED := 3
    static VSS_RT_ORIGINAL_LOCATION := 4
}
struct VSS_FILE_RESTORE_STATUS extends Int32 {
    static VSS_RS_UNDEFINED := 0
    static VSS_RS_NONE := 1
    static VSS_RS_ALL := 2
    static VSS_RS_FAILED := 3
}
struct VSS_COMPONENT_FLAGS extends Int32 {
    static VSS_CF_BACKUP_RECOVERY := 1
    static VSS_CF_APP_ROLLBACK_RECOVERY := 2
    static VSS_CF_NOT_SYSTEM_STATE := 4
}
struct IVssWMFiledesc extends IUnknown {
    GetPath(pbstrPath)
      => ComCall(3, this.p, BSTR.Ptr, pbstrPath)
    GetFilespec(pbstrFilespec)
      => ComCall(4, this.p, BSTR.Ptr, pbstrFilespec)
    GetRecursive(pbRecursive)
      => ComCall(5, this.p, Boolean8.Ptr, pbRecursive)
    GetAlternateLocation(pbstrAlternateLocation)
      => ComCall(6, this.p, BSTR.Ptr, pbstrAlternateLocation)
    GetBackupTypeMask(pdwTypeMask)
      => ComCall(7, this.p, UInt32.Ptr, pdwTypeMask)
}
struct IVssWMDependency extends IUnknown {
    GetWriterId(pWriterId)
      => ComCall(3, this.p, GUID.Ptr, pWriterId)
    GetLogicalPath(pbstrLogicalPath)
      => ComCall(4, this.p, BSTR.Ptr, pbstrLogicalPath)
    GetComponentName(pbstrComponentName)
      => ComCall(5, this.p, BSTR.Ptr, pbstrComponentName)
}
struct IVssComponent extends IUnknown {
    static IID := "{D2C72C96-C121-4518-B627-E5A93D010EAD}"
    GetLogicalPath(pbstrPath)
      => ComCall(3, this.p, BSTR.Ptr, pbstrPath)
    GetComponentType(pct)
      => ComCall(4, this.p, VSS_COMPONENT_TYPE.Ptr, pct)
    GetComponentName(pbstrName)
      => ComCall(5, this.p, BSTR.Ptr, pbstrName)
    GetBackupSucceeded(pbSucceeded)
      => ComCall(6, this.p, Boolean8.Ptr, pbSucceeded)
    GetAlternateLocationMappingCount(pcMappings)
      => ComCall(7, this.p, UInt32.Ptr, pcMappings)
    GetAlternateLocationMapping(iMapping, ppFiledesc)
      => ComCall(8, this.p, UInt32, iMapping, IVssWMFiledesc.Ptr, ppFiledesc)
    SetBackupMetadata(wszData)
      => ComCall(9, this.p, "Str", wszData)
    GetBackupMetadata(pbstrData)
      => ComCall(10, this.p, BSTR.Ptr, pbstrData)
    AddPartialFile(wszPath, wszFilename, wszRanges, wszMetadata)
      => ComCall(11, this.p, "Str", wszPath, "Str", wszFilename, "Str", wszRanges, "Str", wszMetadata)
    GetPartialFileCount(pcPartialFiles)
      => ComCall(12, this.p, UInt32.Ptr, pcPartialFiles)
    GetPartialFile(iPartialFile, pbstrPath, pbstrFilename, pbstrRange, pbstrMetadata)
      => ComCall(13, this.p, UInt32, iPartialFile, BSTR.Ptr, pbstrPath, BSTR.Ptr, pbstrFilename, BSTR.Ptr, pbstrRange, BSTR.Ptr, pbstrMetadata)
    IsSelectedForRestore(pbSelectedForRestore)
      => ComCall(14, this.p, Boolean8.Ptr, pbSelectedForRestore)
    GetAdditionalRestores(pbAdditionalRestores)
      => ComCall(15, this.p, Boolean8.Ptr, pbAdditionalRestores)
    GetNewTargetCount(pcNewTarget)
      => ComCall(16, this.p, UInt32.Ptr, pcNewTarget)
    GetNewTarget(iNewTarget, ppFiledesc)
      => ComCall(17, this.p, UInt32, iNewTarget, IVssWMFiledesc.Ptr, ppFiledesc)
    AddDirectedTarget(wszSourcePath, wszSourceFilename, wszSourceRangeList, wszDestinationPath, wszDestinationFilename, wszDestinationRangeList)
      => ComCall(18, this.p, "Str", wszSourcePath, "Str", wszSourceFilename, "Str", wszSourceRangeList, "Str", wszDestinationPath, "Str", wszDestinationFilename, "Str", wszDestinationRangeList)
    GetDirectedTargetCount(pcDirectedTarget)
      => ComCall(19, this.p, UInt32.Ptr, pcDirectedTarget)
    GetDirectedTarget(iDirectedTarget, pbstrSourcePath, pbstrSourceFileName, pbstrSourceRangeList, pbstrDestinationPath, pbstrDestinationFilename, pbstrDestinationRangeList)
      => ComCall(20, this.p, UInt32, iDirectedTarget, BSTR.Ptr, pbstrSourcePath, BSTR.Ptr, pbstrSourceFileName, BSTR.Ptr, pbstrSourceRangeList, BSTR.Ptr, pbstrDestinationPath, BSTR.Ptr, pbstrDestinationFilename, BSTR.Ptr, pbstrDestinationRangeList)
    SetRestoreMetadata(wszRestoreMetadata)
      => ComCall(21, this.p, "Str", wszRestoreMetadata)
    GetRestoreMetadata(pbstrRestoreMetadata)
      => ComCall(22, this.p, BSTR.Ptr, pbstrRestoreMetadata)
    SetRestoreTarget(target)
      => ComCall(23, this.p, VSS_RESTORE_TARGET, target)
    GetRestoreTarget(pTarget)
      => ComCall(24, this.p, VSS_RESTORE_TARGET.Ptr, pTarget)
    SetPreRestoreFailureMsg(wszPreRestoreFailureMsg)
      => ComCall(25, this.p, "Str", wszPreRestoreFailureMsg)
    GetPreRestoreFailureMsg(pbstrPreRestoreFailureMsg)
      => ComCall(26, this.p, BSTR.Ptr, pbstrPreRestoreFailureMsg)
    SetPostRestoreFailureMsg(wszPostRestoreFailureMsg)
      => ComCall(27, this.p, "Str", wszPostRestoreFailureMsg)
    GetPostRestoreFailureMsg(pbstrPostRestoreFailureMsg)
      => ComCall(28, this.p, BSTR.Ptr, pbstrPostRestoreFailureMsg)
    SetBackupStamp(wszBackupStamp)
      => ComCall(29, this.p, "Str", wszBackupStamp)
    GetBackupStamp(pbstrBackupStamp)
      => ComCall(30, this.p, BSTR.Ptr, pbstrBackupStamp)
    GetPreviousBackupStamp(pbstrBackupStamp)
      => ComCall(31, this.p, BSTR.Ptr, pbstrBackupStamp)
    GetBackupOptions(pbstrBackupOptions)
      => ComCall(32, this.p, BSTR.Ptr, pbstrBackupOptions)
    GetRestoreOptions(pbstrRestoreOptions)
      => ComCall(33, this.p, BSTR.Ptr, pbstrRestoreOptions)
    GetRestoreSubcomponentCount(pcRestoreSubcomponent)
      => ComCall(34, this.p, UInt32.Ptr, pcRestoreSubcomponent)
    GetRestoreSubcomponent(iComponent, pbstrLogicalPath, pbstrComponentName, pbRepair)
      => ComCall(35, this.p, UInt32, iComponent, BSTR.Ptr, pbstrLogicalPath, BSTR.Ptr, pbstrComponentName, Boolean8.Ptr, pbRepair)
    GetFileRestoreStatus(pStatus)
      => ComCall(36, this.p, VSS_FILE_RESTORE_STATUS.Ptr, pStatus)
    AddDifferencedFilesByLastModifyTime(wszPath, wszFilespec, bRecursive, ftLastModifyTime)
      => ComCall(37, this.p, "Str", wszPath, "Str", wszFilespec, BOOL, bRecursive, FILETIME, ftLastModifyTime)
    AddDifferencedFilesByLastModifyLSN(wszPath, wszFilespec, bRecursive, bstrLsnString)
      => ComCall(38, this.p, "Str", wszPath, "Str", wszFilespec, BOOL, bRecursive, BSTR, bstrLsnString)
    GetDifferencedFilesCount(pcDifferencedFiles)
      => ComCall(39, this.p, UInt32.Ptr, pcDifferencedFiles)
    GetDifferencedFile(iDifferencedFile, pbstrPath, pbstrFilespec, pbRecursive, pbstrLsnString, pftLastModifyTime)
      => ComCall(40, this.p, UInt32, iDifferencedFile, BSTR.Ptr, pbstrPath, BSTR.Ptr, pbstrFilespec, BOOL.Ptr, pbRecursive, BSTR.Ptr, pbstrLsnString, FILETIME.Ptr, pftLastModifyTime)
}
struct IVssWriterComponents extends InterfacePointer {
    GetComponentCount(pcComponents)
      => ComCall(0, this.p, UInt32.Ptr, pcComponents)
    GetWriterInfo(pidInstance, pidWriter)
      => ComCall(1, this.p, GUID.Ptr, pidInstance, GUID.Ptr, pidWriter)
    GetComponent(iComponent, ppComponent)
      => ComCall(2, this.p, UInt32, iComponent, IVssComponent.Ptr, ppComponent)
}
struct IVssComponentEx extends IVssComponent {
    static IID := "{156C8B5E-F131-4BD7-9C97-D1923BE7E1FA}"
    SetPrepareForBackupFailureMsg(wszFailureMsg)
      => ComCall(41, this.p, "Str", wszFailureMsg)
    SetPostSnapshotFailureMsg(wszFailureMsg)
      => ComCall(42, this.p, "Str", wszFailureMsg)
    GetPrepareForBackupFailureMsg(pbstrFailureMsg)
      => ComCall(43, this.p, BSTR.Ptr, pbstrFailureMsg)
    GetPostSnapshotFailureMsg(pbstrFailureMsg)
      => ComCall(44, this.p, BSTR.Ptr, pbstrFailureMsg)
    GetAuthoritativeRestore(pbAuth)
      => ComCall(45, this.p, Boolean8.Ptr, pbAuth)
    GetRollForward(pRollType, pbstrPoint)
      => ComCall(46, this.p, VSS_ROLLFORWARD_TYPE.Ptr, pRollType, BSTR.Ptr, pbstrPoint)
    GetRestoreName(pbstrName)
      => ComCall(47, this.p, BSTR.Ptr, pbstrName)
}
struct IVssComponentEx2 extends IVssComponentEx {
    static IID := "{3B5BE0F2-07A9-4E4B-BDD3-CFDC8E2C0D2D}"
    SetFailure(hr, hrApplication, wszApplicationMessage?, dwReserved)
      => ComCall(48, this.p, HRESULT, hr, HRESULT, hrApplication, "Str", wszApplicationMessage?, UInt32, dwReserved)
    GetFailure(phr, phrApplication, pbstrApplicationMessage, pdwReserved)
      => ComCall(49, this.p, HRESULT.Ptr, phr, HRESULT.Ptr, phrApplication, BSTR.Ptr, pbstrApplicationMessage, UInt32.Ptr, pdwReserved)
}
struct IVssCreateWriterMetadata extends InterfacePointer {
    AddIncludeFiles(wszPath, wszFilespec, bRecursive, wszAlternateLocation)
      => ComCall(0, this.p, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive, "Str", wszAlternateLocation)
    AddExcludeFiles(wszPath, wszFilespec, bRecursive)
      => ComCall(1, this.p, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive)
    AddComponent(ct, wszLogicalPath, wszComponentName, wszCaption, pbIcon, cbIcon, bRestoreMetadata, bNotifyOnBackupComplete, bSelectable, bSelectableForRestore, dwComponentFlags)
      => ComCall(2, this.p, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszCaption, UInt8.Ptr, pbIcon, UInt32, cbIcon, UInt8, bRestoreMetadata, UInt8, bNotifyOnBackupComplete, UInt8, bSelectable, UInt8, bSelectableForRestore, UInt32, dwComponentFlags)
    AddDatabaseFiles(wszLogicalPath, wszDatabaseName, wszPath, wszFilespec, dwBackupTypeMask)
      => ComCall(3, this.p, "Str", wszLogicalPath, "Str", wszDatabaseName, "Str", wszPath, "Str", wszFilespec, UInt32, dwBackupTypeMask)
    AddDatabaseLogFiles(wszLogicalPath, wszDatabaseName, wszPath, wszFilespec, dwBackupTypeMask)
      => ComCall(4, this.p, "Str", wszLogicalPath, "Str", wszDatabaseName, "Str", wszPath, "Str", wszFilespec, UInt32, dwBackupTypeMask)
    AddFilesToFileGroup(wszLogicalPath, wszGroupName, wszPath, wszFilespec, bRecursive, wszAlternateLocation, dwBackupTypeMask)
      => ComCall(5, this.p, "Str", wszLogicalPath, "Str", wszGroupName, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive, "Str", wszAlternateLocation, UInt32, dwBackupTypeMask)
    SetRestoreMethod(method, wszService, wszUserProcedure, writerRestore, bRebootRequired)
      => ComCall(6, this.p, VSS_RESTOREMETHOD_ENUM, method, "Str", wszService, "Str", wszUserProcedure, VSS_WRITERRESTORE_ENUM, writerRestore, UInt8, bRebootRequired)
    AddAlternateLocationMapping(wszSourcePath, wszSourceFilespec, bRecursive, wszDestination)
      => ComCall(7, this.p, "Str", wszSourcePath, "Str", wszSourceFilespec, UInt8, bRecursive, "Str", wszDestination)
    AddComponentDependency(wszForLogicalPath, wszForComponentName, onWriterId, wszOnLogicalPath, wszOnComponentName)
      => ComCall(8, this.p, "Str", wszForLogicalPath, "Str", wszForComponentName, GUID, onWriterId, "Str", wszOnLogicalPath, "Str", wszOnComponentName)
    SetBackupSchema(dwSchemaMask)
      => ComCall(9, this.p, UInt32, dwSchemaMask)
    GetDocument(pDoc)
      => ComCall(10, this.p, IXMLDOMDocument.Ptr, pDoc)
    SaveAsXML(pbstrXML)
      => ComCall(11, this.p, BSTR.Ptr, pbstrXML)
}
struct IVssCreateExpressWriterMetadata extends IUnknown {
    static IID := "{9C772E77-B26E-427F-92DD-C996F41EA5E3}"
    AddExcludeFiles(wszPath, wszFilespec, bRecursive)
      => ComCall(3, this.p, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive)
    AddComponent(ct, wszLogicalPath, wszComponentName, wszCaption, pbIcon, cbIcon, bRestoreMetadata, bNotifyOnBackupComplete, bSelectable, bSelectableForRestore, dwComponentFlags)
      => ComCall(4, this.p, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszCaption, UInt8.Ptr, pbIcon, UInt32, cbIcon, UInt8, bRestoreMetadata, UInt8, bNotifyOnBackupComplete, UInt8, bSelectable, UInt8, bSelectableForRestore, UInt32, dwComponentFlags)
    AddFilesToFileGroup(wszLogicalPath, wszGroupName, wszPath, wszFilespec, bRecursive, wszAlternateLocation, dwBackupTypeMask)
      => ComCall(5, this.p, "Str", wszLogicalPath, "Str", wszGroupName, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive, "Str", wszAlternateLocation, UInt32, dwBackupTypeMask)
    SetRestoreMethod(method, wszService, wszUserProcedure, writerRestore, bRebootRequired)
      => ComCall(6, this.p, VSS_RESTOREMETHOD_ENUM, method, "Str", wszService, "Str", wszUserProcedure, VSS_WRITERRESTORE_ENUM, writerRestore, UInt8, bRebootRequired)
    AddComponentDependency(wszForLogicalPath, wszForComponentName, onWriterId, wszOnLogicalPath, wszOnComponentName)
      => ComCall(7, this.p, "Str", wszForLogicalPath, "Str", wszForComponentName, GUID, onWriterId, "Str", wszOnLogicalPath, "Str", wszOnComponentName)
    SetBackupSchema(dwSchemaMask)
      => ComCall(8, this.p, UInt32, dwSchemaMask)
    SaveAsXML(pbstrXML)
      => ComCall(9, this.p, BSTR.Ptr, pbstrXML)
}
struct IVssExpressWriter extends IUnknown {
    static IID := "{E33AFFDC-59C7-47B1-97D5-4266598F6235}"
    CreateMetadata(writerId, writerName, usageType, versionMajor, versionMinor, reserved, ppMetadata)
      => ComCall(3, this.p, GUID, writerId, "Str", writerName, VSS_USAGE_TYPE, usageType, UInt32, versionMajor, UInt32, versionMinor, UInt32, reserved, IVssCreateExpressWriterMetadata.Ptr, ppMetadata)
    LoadMetadata(metadata, reserved)
      => ComCall(4, this.p, "Str", metadata, UInt32, reserved)
    Register()
      => ComCall(5, this.p)
    Unregister(writerId)
      => ComCall(6, this.p, GUID, writerId)
}
struct VSS_MGMT_OBJECT_TYPE extends Int32 {
    static VSS_MGMT_OBJECT_UNKNOWN := 0
    static VSS_MGMT_OBJECT_VOLUME := 1
    static VSS_MGMT_OBJECT_DIFF_VOLUME := 2
    static VSS_MGMT_OBJECT_DIFF_AREA := 3
}
struct VSS_VOLUME_PROP {
    m_pwszVolumeName : UInt16.Ptr
    m_pwszVolumeDisplayName : UInt16.Ptr
}
struct VSS_DIFF_VOLUME_PROP {
    m_pwszVolumeName : UInt16.Ptr
    m_pwszVolumeDisplayName : UInt16.Ptr
    m_llVolumeFreeSpace : Int64
    m_llVolumeTotalSpace : Int64
}
struct VSS_DIFF_AREA_PROP {
    m_pwszVolumeName : UInt16.Ptr
    m_pwszDiffAreaVolumeName : UInt16.Ptr
    m_llMaximumDiffSpace : Int64
    m_llAllocatedDiffSpace : Int64
    m_llUsedDiffSpace : Int64
}
struct VSS_MGMT_OBJECT_UNION {
    union {
        Vol : VSS_VOLUME_PROP
        DiffVol : VSS_DIFF_VOLUME_PROP
        DiffArea : VSS_DIFF_AREA_PROP
    }
}
struct VSS_MGMT_OBJECT_PROP {
    Type : VSS_MGMT_OBJECT_TYPE
    Obj : VSS_MGMT_OBJECT_UNION
}
struct VSS_PROTECTION_LEVEL extends Int32 {
    static VSS_PROTECTION_LEVEL_ORIGINAL_VOLUME := 0
    static VSS_PROTECTION_LEVEL_SNAPSHOT := 1
}
struct VSS_PROTECTION_FAULT extends Int32 {
    static VSS_PROTECTION_FAULT_NONE := 0
    static VSS_PROTECTION_FAULT_DIFF_AREA_MISSING := 1
    static VSS_PROTECTION_FAULT_IO_FAILURE_DURING_ONLINE := 2
    static VSS_PROTECTION_FAULT_META_DATA_CORRUPTION := 3
    static VSS_PROTECTION_FAULT_MEMORY_ALLOCATION_FAILURE := 4
    static VSS_PROTECTION_FAULT_MAPPED_MEMORY_FAILURE := 5
    static VSS_PROTECTION_FAULT_COW_READ_FAILURE := 6
    static VSS_PROTECTION_FAULT_COW_WRITE_FAILURE := 7
    static VSS_PROTECTION_FAULT_DIFF_AREA_FULL := 8
    static VSS_PROTECTION_FAULT_GROW_TOO_SLOW := 9
    static VSS_PROTECTION_FAULT_GROW_FAILED := 10
    static VSS_PROTECTION_FAULT_DESTROY_ALL_SNAPSHOTS := 11
    static VSS_PROTECTION_FAULT_FILE_SYSTEM_FAILURE := 12
    static VSS_PROTECTION_FAULT_IO_FAILURE := 13
    static VSS_PROTECTION_FAULT_DIFF_AREA_REMOVED := 14
    static VSS_PROTECTION_FAULT_EXTERNAL_WRITER_TO_DIFF_AREA := 15
    static VSS_PROTECTION_FAULT_MOUNT_DURING_CLUSTER_OFFLINE := 16
}
struct VSS_VOLUME_PROTECTION_INFO {
    m_protectionLevel : VSS_PROTECTION_LEVEL
    m_volumeIsOfflineForProtection : BOOL
    m_protectionFault : VSS_PROTECTION_FAULT
    m_failureStatus : Int32
    m_volumeHasUnusedDiffArea : BOOL
    m_reserved : UInt32
}
struct IVssSnapshotMgmt extends IUnknown {
    static IID := "{FA7DF749-66E7-4986-A27F-E2F04AE53772}"
    GetProviderMgmtInterface(ProviderId, InterfaceId, ppItf)
      => ComCall(3, this.p, GUID, ProviderId, GUID.Ptr, InterfaceId, IUnknown.Ptr, ppItf)
    QueryVolumesSupportedForSnapshots(ProviderId, lContext, ppEnum)
      => ComCall(4, this.p, GUID, ProviderId, Int32, lContext, IVssEnumMgmtObject.Ptr, ppEnum)
    QuerySnapshotsByVolume(pwszVolumeName, ProviderId, ppEnum)
      => ComCall(5, this.p, UInt16.Ptr, pwszVolumeName, GUID, ProviderId, IVssEnumObject.Ptr, ppEnum)
}
struct IVssSnapshotMgmt2 extends IUnknown {
    static IID := "{0F61EC39-FE82-45F2-A3F0-768B5D427102}"
    GetMinDiffAreaSize(pllMinDiffAreaSize)
      => ComCall(3, this.p, Int64.Ptr, pllMinDiffAreaSize)
}
struct IVssDifferentialSoftwareSnapshotMgmt extends IUnknown {
    static IID := "{214A0F28-B737-4026-B847-4F9E37D79529}"
    AddDiffArea(pwszVolumeName, pwszDiffAreaVolumeName, llMaximumDiffSpace)
      => ComCall(3, this.p, UInt16.Ptr, pwszVolumeName, UInt16.Ptr, pwszDiffAreaVolumeName, Int64, llMaximumDiffSpace)
    ChangeDiffAreaMaximumSize(pwszVolumeName, pwszDiffAreaVolumeName, llMaximumDiffSpace)
      => ComCall(4, this.p, UInt16.Ptr, pwszVolumeName, UInt16.Ptr, pwszDiffAreaVolumeName, Int64, llMaximumDiffSpace)
    QueryVolumesSupportedForDiffAreas(pwszOriginalVolumeName, ppEnum)
      => ComCall(5, this.p, UInt16.Ptr, pwszOriginalVolumeName, IVssEnumMgmtObject.Ptr, ppEnum)
    QueryDiffAreasForVolume(pwszVolumeName, ppEnum)
      => ComCall(6, this.p, UInt16.Ptr, pwszVolumeName, IVssEnumMgmtObject.Ptr, ppEnum)
    QueryDiffAreasOnVolume(pwszVolumeName, ppEnum)
      => ComCall(7, this.p, UInt16.Ptr, pwszVolumeName, IVssEnumMgmtObject.Ptr, ppEnum)
    QueryDiffAreasForSnapshot(SnapshotId, ppEnum)
      => ComCall(8, this.p, GUID, SnapshotId, IVssEnumMgmtObject.Ptr, ppEnum)
}
struct IVssDifferentialSoftwareSnapshotMgmt2 extends IVssDifferentialSoftwareSnapshotMgmt {
    static IID := "{949D7353-675F-4275-8969-F044C6277815}"
    ChangeDiffAreaMaximumSizeEx(pwszVolumeName, pwszDiffAreaVolumeName, llMaximumDiffSpace, bVolatile)
      => ComCall(9, this.p, UInt16.Ptr, pwszVolumeName, UInt16.Ptr, pwszDiffAreaVolumeName, Int64, llMaximumDiffSpace, BOOL, bVolatile)
    MigrateDiffAreas(pwszVolumeName, pwszDiffAreaVolumeName, pwszNewDiffAreaVolumeName)
      => ComCall(10, this.p, UInt16.Ptr, pwszVolumeName, UInt16.Ptr, pwszDiffAreaVolumeName, UInt16.Ptr, pwszNewDiffAreaVolumeName)
    QueryMigrationStatus(pwszVolumeName, pwszDiffAreaVolumeName, ppAsync)
      => ComCall(11, this.p, UInt16.Ptr, pwszVolumeName, UInt16.Ptr, pwszDiffAreaVolumeName, IVssAsync.Ptr, ppAsync)
    SetSnapshotPriority(idSnapshot, priority)
      => ComCall(12, this.p, GUID, idSnapshot, UInt8, priority)
}
struct IVssDifferentialSoftwareSnapshotMgmt3 extends IVssDifferentialSoftwareSnapshotMgmt2 {
    static IID := "{383F7E71-A4C5-401F-B27F-F826289F8458}"
    SetVolumeProtectLevel(pwszVolumeName, protectionLevel)
      => ComCall(13, this.p, UInt16.Ptr, pwszVolumeName, VSS_PROTECTION_LEVEL, protectionLevel)
    GetVolumeProtectLevel(pwszVolumeName, protectionLevel)
      => ComCall(14, this.p, UInt16.Ptr, pwszVolumeName, VSS_VOLUME_PROTECTION_INFO.Ptr, protectionLevel)
    ClearVolumeProtectFault(pwszVolumeName)
      => ComCall(15, this.p, UInt16.Ptr, pwszVolumeName)
    DeleteUnusedDiffAreas(pwszDiffAreaVolumeName)
      => ComCall(16, this.p, UInt16.Ptr, pwszDiffAreaVolumeName)
    QuerySnapshotDeltaBitmap(idSnapshotOlder, idSnapshotYounger, pcBlockSizePerBit, ppbBitmap)
      => ComCall(17, this.p, GUID, idSnapshotOlder, GUID, idSnapshotYounger, UInt32.Ptr, pcBlockSizePerBit, UInt32.Ptr, ppbBitmap.Length, UInt8.Ptr.Ptr, ppbBitmap)
}
struct IVssEnumMgmtObject extends IUnknown {
    static IID := "{01954E6B-9254-4E6E-808C-C9E05D007696}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, VSS_MGMT_OBJECT_PROP.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IVssEnumMgmtObject.Ptr, ppenum)
}
struct VSS_COMPONENTINFO {
    type : VSS_COMPONENT_TYPE
    bstrLogicalPath : BSTR
    bstrComponentName : BSTR
    bstrCaption : BSTR
    pbIcon : UInt8.Ptr
    cbIcon : UInt32
    bRestoreMetadata : UInt8
    bNotifyOnBackupComplete : UInt8
    bSelectable : UInt8
    bSelectableForRestore : UInt8
    dwComponentFlags : UInt32
    cFileCount : UInt32
    cDatabases : UInt32
    cLogFiles : UInt32
    cDependencies : UInt32
}
struct IVssWMComponent extends IUnknown {
    GetComponentInfo(ppInfo)
      => ComCall(3, this.p, VSS_COMPONENTINFO.Ptr.Ptr, ppInfo)
    FreeComponentInfo(pInfo)
      => ComCall(4, this.p, VSS_COMPONENTINFO.Ptr, pInfo)
    GetFile(iFile, ppFiledesc)
      => ComCall(5, this.p, UInt32, iFile, IVssWMFiledesc.Ptr, ppFiledesc)
    GetDatabaseFile(iDBFile, ppFiledesc)
      => ComCall(6, this.p, UInt32, iDBFile, IVssWMFiledesc.Ptr, ppFiledesc)
    GetDatabaseLogFile(iDbLogFile, ppFiledesc)
      => ComCall(7, this.p, UInt32, iDbLogFile, IVssWMFiledesc.Ptr, ppFiledesc)
    GetDependency(iDependency, ppDependency)
      => ComCall(8, this.p, UInt32, iDependency, IVssWMDependency.Ptr, ppDependency)
}
struct IVssExamineWriterMetadata extends IUnknown {
    static IID := "{902FCF7F-B7FD-42F8-81F1-B2E400B1E5BD}"
    GetIdentity(pidInstance, pidWriter, pbstrWriterName, pUsage, pSource)
      => ComCall(3, this.p, GUID.Ptr, pidInstance, GUID.Ptr, pidWriter, BSTR.Ptr, pbstrWriterName, VSS_USAGE_TYPE.Ptr, pUsage, VSS_SOURCE_TYPE.Ptr, pSource)
    GetFileCounts(pcIncludeFiles, pcExcludeFiles, pcComponents)
      => ComCall(4, this.p, UInt32.Ptr, pcIncludeFiles, UInt32.Ptr, pcExcludeFiles, UInt32.Ptr, pcComponents)
    GetIncludeFile(iFile, ppFiledesc)
      => ComCall(5, this.p, UInt32, iFile, IVssWMFiledesc.Ptr, ppFiledesc)
    GetExcludeFile(iFile, ppFiledesc)
      => ComCall(6, this.p, UInt32, iFile, IVssWMFiledesc.Ptr, ppFiledesc)
    GetComponent(iComponent, ppComponent)
      => ComCall(7, this.p, UInt32, iComponent, IVssWMComponent.Ptr, ppComponent)
    GetRestoreMethod(pMethod, pbstrService, pbstrUserProcedure, pwriterRestore, pbRebootRequired, pcMappings)
      => ComCall(8, this.p, VSS_RESTOREMETHOD_ENUM.Ptr, pMethod, BSTR.Ptr, pbstrService, BSTR.Ptr, pbstrUserProcedure, VSS_WRITERRESTORE_ENUM.Ptr, pwriterRestore, Boolean8.Ptr, pbRebootRequired, UInt32.Ptr, pcMappings)
    GetAlternateLocationMapping(iMapping, ppFiledesc)
      => ComCall(9, this.p, UInt32, iMapping, IVssWMFiledesc.Ptr, ppFiledesc)
    GetBackupSchema(pdwSchemaMask)
      => ComCall(10, this.p, UInt32.Ptr, pdwSchemaMask)
    GetDocument(pDoc)
      => ComCall(11, this.p, IXMLDOMDocument.Ptr, pDoc)
    SaveAsXML(pbstrXML)
      => ComCall(12, this.p, BSTR.Ptr, pbstrXML)
    LoadFromXML(bstrXML)
      => ComCall(13, this.p, BSTR, bstrXML)
}
struct IVssExamineWriterMetadataEx extends IVssExamineWriterMetadata {
    static IID := "{0C0E5EC0-CA44-472B-B702-E652DB1C0451}"
    GetIdentityEx(pidInstance, pidWriter, pbstrWriterName, pbstrInstanceName, pUsage, pSource)
      => ComCall(14, this.p, GUID.Ptr, pidInstance, GUID.Ptr, pidWriter, BSTR.Ptr, pbstrWriterName, BSTR.Ptr, pbstrInstanceName, VSS_USAGE_TYPE.Ptr, pUsage, VSS_SOURCE_TYPE.Ptr, pSource)
}
struct IVssExamineWriterMetadataEx2 extends IVssExamineWriterMetadataEx {
    static IID := "{CE115780-A611-431B-B57F-C38303AB6AEE}"
    GetVersion(pdwMajorVersion, pdwMinorVersion)
      => ComCall(15, this.p, UInt32.Ptr, pdwMajorVersion, UInt32.Ptr, pdwMinorVersion)
    GetExcludeFromSnapshotCount(pcExcludedFromSnapshot)
      => ComCall(16, this.p, UInt32.Ptr, pcExcludedFromSnapshot)
    GetExcludeFromSnapshotFile(iFile, ppFiledesc)
      => ComCall(17, this.p, UInt32, iFile, IVssWMFiledesc.Ptr, ppFiledesc)
}
struct IVssWriterComponentsExt extends IUnknown {
}
struct IVssBackupComponents extends IUnknown {
    static IID := "{665C1D5F-C218-414D-A05D-7FEF5F9D5C86}"
    GetWriterComponentsCount(pcComponents)
      => ComCall(3, this.p, UInt32.Ptr, pcComponents)
    GetWriterComponents(iWriter, ppWriter)
      => ComCall(4, this.p, UInt32, iWriter, IVssWriterComponentsExt.Ptr, ppWriter)
    InitializeForBackup(bstrXML?)
      => ComCall(5, this.p, BSTR, bstrXML?)
    SetBackupState(bSelectComponents, bBackupBootableSystemState, backupType, bPartialFileSupport)
      => ComCall(6, this.p, UInt8, bSelectComponents, UInt8, bBackupBootableSystemState, VSS_BACKUP_TYPE, backupType, UInt8, bPartialFileSupport)
    InitializeForRestore(bstrXML)
      => ComCall(7, this.p, BSTR, bstrXML)
    SetRestoreState(restoreType)
      => ComCall(8, this.p, VSS_RESTORE_TYPE, restoreType)
    GatherWriterMetadata(pAsync)
      => ComCall(9, this.p, IVssAsync.Ptr, pAsync)
    GetWriterMetadataCount(pcWriters)
      => ComCall(10, this.p, UInt32.Ptr, pcWriters)
    GetWriterMetadata(iWriter, pidInstance, ppMetadata)
      => ComCall(11, this.p, UInt32, iWriter, GUID.Ptr, pidInstance, IVssExamineWriterMetadata.Ptr, ppMetadata)
    FreeWriterMetadata()
      => ComCall(12, this.p)
    AddComponent(instanceId, writerId, ct, wszLogicalPath, wszComponentName)
      => ComCall(13, this.p, GUID, instanceId, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName)
    PrepareForBackup(ppAsync)
      => ComCall(14, this.p, IVssAsync.Ptr, ppAsync)
    AbortBackup()
      => ComCall(15, this.p)
    GatherWriterStatus(pAsync)
      => ComCall(16, this.p, IVssAsync.Ptr, pAsync)
    GetWriterStatusCount(pcWriters)
      => ComCall(17, this.p, UInt32.Ptr, pcWriters)
    FreeWriterStatus()
      => ComCall(18, this.p)
    GetWriterStatus(iWriter, pidInstance, pidWriter, pbstrWriter, pnStatus, phResultFailure)
      => ComCall(19, this.p, UInt32, iWriter, GUID.Ptr, pidInstance, GUID.Ptr, pidWriter, BSTR.Ptr, pbstrWriter, VSS_WRITER_STATE.Ptr, pnStatus, HRESULT.Ptr, phResultFailure)
    SetBackupSucceeded(instanceId, writerId, ct, wszLogicalPath, wszComponentName, bSucceded)
      => ComCall(20, this.p, GUID, instanceId, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt8, bSucceded)
    SetBackupOptions(writerId, ct, wszLogicalPath, wszComponentName, wszBackupOptions)
      => ComCall(21, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszBackupOptions)
    SetSelectedForRestore(writerId, ct, wszLogicalPath, wszComponentName, bSelectedForRestore)
      => ComCall(22, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt8, bSelectedForRestore)
    SetRestoreOptions(writerId, ct, wszLogicalPath, wszComponentName, wszRestoreOptions)
      => ComCall(23, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszRestoreOptions)
    SetAdditionalRestores(writerId, ct, wszLogicalPath, wszComponentName, bAdditionalRestores)
      => ComCall(24, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt8, bAdditionalRestores)
    SetPreviousBackupStamp(writerId, ct, wszLogicalPath, wszComponentName, wszPreviousBackupStamp)
      => ComCall(25, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszPreviousBackupStamp)
    SaveAsXML(pbstrXML)
      => ComCall(26, this.p, BSTR.Ptr, pbstrXML)
    BackupComplete(ppAsync)
      => ComCall(27, this.p, IVssAsync.Ptr, ppAsync)
    AddAlternativeLocationMapping(writerId, componentType, wszLogicalPath, wszComponentName, wszPath, wszFilespec, bRecursive, wszDestination)
      => ComCall(28, this.p, GUID, writerId, VSS_COMPONENT_TYPE, componentType, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszPath, "Str", wszFilespec, UInt8, bRecursive, "Str", wszDestination)
    AddRestoreSubcomponent(writerId, componentType, wszLogicalPath, wszComponentName, wszSubComponentLogicalPath, wszSubComponentName, bRepair)
      => ComCall(29, this.p, GUID, writerId, VSS_COMPONENT_TYPE, componentType, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszSubComponentLogicalPath, "Str", wszSubComponentName, UInt8, bRepair)
    SetFileRestoreStatus(writerId, ct, wszLogicalPath, wszComponentName, status)
      => ComCall(30, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, VSS_FILE_RESTORE_STATUS, status)
    AddNewTarget(writerId, ct, wszLogicalPath, wszComponentName, wszPath, wszFileName, bRecursive, wszAlternatePath)
      => ComCall(31, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszPath, "Str", wszFileName, UInt8, bRecursive, "Str", wszAlternatePath)
    SetRangesFilePath(writerId, ct, wszLogicalPath, wszComponentName, iPartialFile, wszRangesFile)
      => ComCall(32, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt32, iPartialFile, "Str", wszRangesFile)
    PreRestore(ppAsync)
      => ComCall(33, this.p, IVssAsync.Ptr, ppAsync)
    PostRestore(ppAsync)
      => ComCall(34, this.p, IVssAsync.Ptr, ppAsync)
    SetContext(lContext)
      => ComCall(35, this.p, Int32, lContext)
    StartSnapshotSet(pSnapshotSetId)
      => ComCall(36, this.p, GUID.Ptr, pSnapshotSetId)
    AddToSnapshotSet(pwszVolumeName, ProviderId, pidSnapshot)
      => ComCall(37, this.p, UInt16.Ptr, pwszVolumeName, GUID, ProviderId, GUID.Ptr, pidSnapshot)
    DoSnapshotSet(ppAsync)
      => ComCall(38, this.p, IVssAsync.Ptr, ppAsync)
    DeleteSnapshots(SourceObjectId, eSourceObjectType, bForceDelete, plDeletedSnapshots, pNondeletedSnapshotID)
      => ComCall(39, this.p, GUID, SourceObjectId, VSS_OBJECT_TYPE, eSourceObjectType, BOOL, bForceDelete, Int32.Ptr, plDeletedSnapshots, GUID.Ptr, pNondeletedSnapshotID)
    ImportSnapshots(ppAsync)
      => ComCall(40, this.p, IVssAsync.Ptr, ppAsync)
    BreakSnapshotSet(SnapshotSetId)
      => ComCall(41, this.p, GUID, SnapshotSetId)
    GetSnapshotProperties(SnapshotId, pProp)
      => ComCall(42, this.p, GUID, SnapshotId, VSS_SNAPSHOT_PROP.Ptr, pProp)
    Query(QueriedObjectId, eQueriedObjectType, eReturnedObjectsType, ppEnum)
      => ComCall(43, this.p, GUID, QueriedObjectId, VSS_OBJECT_TYPE, eQueriedObjectType, VSS_OBJECT_TYPE, eReturnedObjectsType, IVssEnumObject.Ptr, ppEnum)
    IsVolumeSupported(ProviderId, pwszVolumeName, pbSupportedByThisProvider)
      => ComCall(44, this.p, GUID, ProviderId, UInt16.Ptr, pwszVolumeName, BOOL.Ptr, pbSupportedByThisProvider)
    DisableWriterClasses(rgWriterClassId, cClassId)
      => ComCall(45, this.p, GUID.Ptr, rgWriterClassId, UInt32, cClassId)
    EnableWriterClasses(rgWriterClassId, cClassId)
      => ComCall(46, this.p, GUID.Ptr, rgWriterClassId, UInt32, cClassId)
    DisableWriterInstances(rgWriterInstanceId, cInstanceId)
      => ComCall(47, this.p, GUID.Ptr, rgWriterInstanceId, UInt32, cInstanceId)
    ExposeSnapshot(SnapshotId, wszPathFromRoot, lAttributes, wszExpose, pwszExposed)
      => ComCall(48, this.p, GUID, SnapshotId, UInt16.Ptr, wszPathFromRoot, Int32, lAttributes, UInt16.Ptr, wszExpose, UInt16.Ptr.Ptr, pwszExposed)
    RevertToSnapshot(SnapshotId, bForceDismount)
      => ComCall(49, this.p, GUID, SnapshotId, BOOL, bForceDismount)
    QueryRevertStatus(pwszVolume, ppAsync)
      => ComCall(50, this.p, UInt16.Ptr, pwszVolume, IVssAsync.Ptr, ppAsync)
}
struct IVssBackupComponentsEx extends IVssBackupComponents {
    static IID := "{963F03AD-9E4C-4A34-AC15-E4B6174E5036}"
    GetWriterMetadataEx(iWriter, pidInstance, ppMetadata)
      => ComCall(51, this.p, UInt32, iWriter, GUID.Ptr, pidInstance, IVssExamineWriterMetadataEx.Ptr, ppMetadata)
    SetSelectedForRestoreEx(writerId, ct, wszLogicalPath, wszComponentName, bSelectedForRestore, instanceId)
      => ComCall(52, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt8, bSelectedForRestore, GUID, instanceId)
}
struct IVssBackupComponentsEx2 extends IVssBackupComponentsEx {
    static IID := "{ACFE2B3A-22C9-4EF8-BD03-2F9CA230084E}"
    UnexposeSnapshot(snapshotId)
      => ComCall(53, this.p, GUID, snapshotId)
    SetAuthoritativeRestore(writerId, ct, wszLogicalPath, wszComponentName, bAuth)
      => ComCall(54, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, UInt8, bAuth)
    SetRollForward(writerId, ct, wszLogicalPath, wszComponentName, rollType, wszRollForwardPoint)
      => ComCall(55, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, VSS_ROLLFORWARD_TYPE, rollType, "Str", wszRollForwardPoint)
    SetRestoreName(writerId, ct, wszLogicalPath, wszComponentName, wszRestoreName)
      => ComCall(56, this.p, GUID, writerId, VSS_COMPONENT_TYPE, ct, "Str", wszLogicalPath, "Str", wszComponentName, "Str", wszRestoreName)
    BreakSnapshotSetEx(SnapshotSetID, dwBreakFlags, ppAsync)
      => ComCall(57, this.p, GUID, SnapshotSetID, UInt32, dwBreakFlags, IVssAsync.Ptr, ppAsync)
    PreFastRecovery(SnapshotSetID, dwPreFastRecoveryFlags, ppAsync)
      => ComCall(58, this.p, GUID, SnapshotSetID, UInt32, dwPreFastRecoveryFlags, IVssAsync.Ptr, ppAsync)
    FastRecovery(SnapshotSetID, dwFastRecoveryFlags, ppAsync)
      => ComCall(59, this.p, GUID, SnapshotSetID, UInt32, dwFastRecoveryFlags, IVssAsync.Ptr, ppAsync)
}
struct IVssBackupComponentsEx3 extends IVssBackupComponentsEx2 {
    static IID := "{C191BFBC-B602-4675-8BD1-67D642F529D5}"
    GetWriterStatusEx(iWriter, pidInstance, pidWriter, pbstrWriter, pnStatus, phrFailureWriter, phrApplication?, pbstrApplicationMessage?)
      => ComCall(60, this.p, UInt32, iWriter, GUID.Ptr, pidInstance, GUID.Ptr, pidWriter, BSTR.Ptr, pbstrWriter, VSS_WRITER_STATE.Ptr, pnStatus, HRESULT.Ptr, phrFailureWriter, HRESULT.Ptr, phrApplication?, BSTR.Ptr, pbstrApplicationMessage?)
    AddSnapshotToRecoverySet(snapshotId, dwFlags, pwszDestinationVolume?)
      => ComCall(61, this.p, GUID, snapshotId, UInt32, dwFlags, UInt16.Ptr, pwszDestinationVolume?)
    RecoverSet(dwFlags, ppAsync)
      => ComCall(62, this.p, UInt32, dwFlags, IVssAsync.Ptr, ppAsync)
    GetSessionId(idSession)
      => ComCall(63, this.p, GUID.Ptr, idSession)
}
struct IVssBackupComponentsEx4 extends IVssBackupComponentsEx3 {
    static IID := "{F434C2FD-B553-4961-A9F9-A8E90B673E53}"
    GetRootAndLogicalPrefixPaths(pwszFilePath, ppwszRootPath, ppwszLogicalPrefix, bNormalizeFQDNforRootPath?)
      => ComCall(64, this.p, UInt16.Ptr, pwszFilePath, UInt16.Ptr.Ptr, ppwszRootPath, UInt16.Ptr.Ptr, ppwszLogicalPrefix, BOOL, bNormalizeFQDNforRootPath?)
}
struct IVssAdmin extends IUnknown {
    static IID := "{77ED5996-2F63-11D3-8A39-00C04F72D8E3}"
    RegisterProvider(pProviderId, ClassId, pwszProviderName, eProviderType, pwszProviderVersion, ProviderVersionId)
      => ComCall(3, this.p, GUID, pProviderId, GUID, ClassId, UInt16.Ptr, pwszProviderName, VSS_PROVIDER_TYPE, eProviderType, UInt16.Ptr, pwszProviderVersion, GUID, ProviderVersionId)
    UnregisterProvider(ProviderId)
      => ComCall(4, this.p, GUID, ProviderId)
    QueryProviders(ppEnum)
      => ComCall(5, this.p, IVssEnumObject.Ptr, ppEnum)
    AbortAllSnapshotsInProgress()
      => ComCall(6, this.p)
}
struct IVssAdminEx extends IVssAdmin {
    static IID := "{7858A9F8-B1FA-41A6-964F-B9B36B8CD8D8}"
    GetProviderCapability(pProviderId, pllOriginalCapabilityMask)
      => ComCall(7, this.p, GUID, pProviderId, Int64.Ptr, pllOriginalCapabilityMask)
    GetProviderContext(ProviderId, plContext)
      => ComCall(8, this.p, GUID, ProviderId, Int32.Ptr, plContext)
    SetProviderContext(ProviderId, lContext)
      => ComCall(9, this.p, GUID, ProviderId, Int32, lContext)
}
struct IVssSoftwareSnapshotProvider extends IUnknown {
    static IID := "{609E123E-2C5A-44D3-8F01-0B1D9A47D1FF}"
    SetContext(lContext)
      => ComCall(3, this.p, Int32, lContext)
    GetSnapshotProperties(SnapshotId, pProp)
      => ComCall(4, this.p, GUID, SnapshotId, VSS_SNAPSHOT_PROP.Ptr, pProp)
    Query(QueriedObjectId, eQueriedObjectType, eReturnedObjectsType, ppEnum)
      => ComCall(5, this.p, GUID, QueriedObjectId, VSS_OBJECT_TYPE, eQueriedObjectType, VSS_OBJECT_TYPE, eReturnedObjectsType, IVssEnumObject.Ptr, ppEnum)
    DeleteSnapshots(SourceObjectId, eSourceObjectType, bForceDelete, plDeletedSnapshots, pNondeletedSnapshotID)
      => ComCall(6, this.p, GUID, SourceObjectId, VSS_OBJECT_TYPE, eSourceObjectType, BOOL, bForceDelete, Int32.Ptr, plDeletedSnapshots, GUID.Ptr, pNondeletedSnapshotID)
    BeginPrepareSnapshot(SnapshotSetId, SnapshotId, pwszVolumeName, lNewContext)
      => ComCall(7, this.p, GUID, SnapshotSetId, GUID, SnapshotId, UInt16.Ptr, pwszVolumeName, Int32, lNewContext)
    IsVolumeSupported(pwszVolumeName, pbSupportedByThisProvider)
      => ComCall(8, this.p, UInt16.Ptr, pwszVolumeName, BOOL.Ptr, pbSupportedByThisProvider)
    IsVolumeSnapshotted(pwszVolumeName, pbSnapshotsPresent, plSnapshotCompatibility)
      => ComCall(9, this.p, UInt16.Ptr, pwszVolumeName, BOOL.Ptr, pbSnapshotsPresent, Int32.Ptr, plSnapshotCompatibility)
    SetSnapshotProperty(SnapshotId, eSnapshotPropertyId, vProperty)
      => ComCall(10, this.p, GUID, SnapshotId, VSS_SNAPSHOT_PROPERTY_ID, eSnapshotPropertyId, VARIANT, vProperty)
    RevertToSnapshot(SnapshotId)
      => ComCall(11, this.p, GUID, SnapshotId)
    QueryRevertStatus(pwszVolume, ppAsync)
      => ComCall(12, this.p, UInt16.Ptr, pwszVolume, IVssAsync.Ptr, ppAsync)
}
struct IVssProviderCreateSnapshotSet extends IUnknown {
    static IID := "{5F894E5B-1E39-4778-8E23-9ABAD9F0E08C}"
    EndPrepareSnapshots(SnapshotSetId)
      => ComCall(3, this.p, GUID, SnapshotSetId)
    PreCommitSnapshots(SnapshotSetId)
      => ComCall(4, this.p, GUID, SnapshotSetId)
    CommitSnapshots(SnapshotSetId)
      => ComCall(5, this.p, GUID, SnapshotSetId)
    PostCommitSnapshots(SnapshotSetId, lSnapshotsCount)
      => ComCall(6, this.p, GUID, SnapshotSetId, Int32, lSnapshotsCount)
    PreFinalCommitSnapshots(SnapshotSetId)
      => ComCall(7, this.p, GUID, SnapshotSetId)
    PostFinalCommitSnapshots(SnapshotSetId)
      => ComCall(8, this.p, GUID, SnapshotSetId)
    AbortSnapshots(SnapshotSetId)
      => ComCall(9, this.p, GUID, SnapshotSetId)
}
struct IVssProviderNotifications extends IUnknown {
    static IID := "{E561901F-03A5-4AFE-86D0-72BAEECE7004}"
    OnLoad(pCallback)
      => ComCall(3, this.p, IUnknown, pCallback)
    OnUnload(bForceUnload)
      => ComCall(4, this.p, BOOL, bForceUnload)
}
struct IVssHardwareSnapshotProvider extends IUnknown {
    static IID := "{9593A157-44E9-4344-BBEB-44FBF9B06B10}"
    AreLunsSupported(lContext, rgwszDevices, pLunInformation, pbIsSupported)
      => ComCall(3, this.p, Int32, pLunInformation.Length, Int32, lContext, UInt16.Ptr.Ptr, rgwszDevices, VDS_LUN_INFORMATION.Ptr, pLunInformation, BOOL.Ptr, pbIsSupported)
    FillInLunInfo(wszDeviceName, pLunInfo, pbIsSupported)
      => ComCall(4, this.p, UInt16.Ptr, wszDeviceName, VDS_LUN_INFORMATION.Ptr, pLunInfo, BOOL.Ptr, pbIsSupported)
    BeginPrepareSnapshot(SnapshotSetId, SnapshotId, lContext, rgDeviceNames, rgLunInformation)
      => ComCall(5, this.p, GUID, SnapshotSetId, GUID, SnapshotId, Int32, lContext, Int32, rgLunInformation.Length, UInt16.Ptr.Ptr, rgDeviceNames, VDS_LUN_INFORMATION.Ptr, rgLunInformation)
    GetTargetLuns(rgDeviceNames, rgSourceLuns, rgDestinationLuns)
      => ComCall(6, this.p, Int32, rgDestinationLuns.Length, UInt16.Ptr.Ptr, rgDeviceNames, VDS_LUN_INFORMATION.Ptr, rgSourceLuns, VDS_LUN_INFORMATION.Ptr, rgDestinationLuns)
    LocateLuns(rgSourceLuns)
      => ComCall(7, this.p, Int32, rgSourceLuns.Length, VDS_LUN_INFORMATION.Ptr, rgSourceLuns)
    OnLunEmpty(wszDeviceName, pInformation)
      => ComCall(8, this.p, UInt16.Ptr, wszDeviceName, VDS_LUN_INFORMATION.Ptr, pInformation)
}
struct IVssHardwareSnapshotProviderEx extends IVssHardwareSnapshotProvider {
    static IID := "{7F5BA925-CDB1-4D11-A71F-339EB7E709FD}"
    GetProviderCapabilities(pllOriginalCapabilityMask)
      => ComCall(9, this.p, Int64.Ptr, pllOriginalCapabilityMask)
    OnLunStateChange(pSnapshotLuns, pOriginalLuns, dwFlags)
      => ComCall(10, this.p, VDS_LUN_INFORMATION.Ptr, pSnapshotLuns, VDS_LUN_INFORMATION.Ptr, pOriginalLuns, UInt32, pOriginalLuns.Length, UInt32, dwFlags)
    ResyncLuns(pSourceLuns, pTargetLuns, ppAsync)
      => ComCall(11, this.p, VDS_LUN_INFORMATION.Ptr, pSourceLuns, VDS_LUN_INFORMATION.Ptr, pTargetLuns, UInt32, pTargetLuns.Length, IVssAsync.Ptr, ppAsync)
    OnReuseLuns(pSnapshotLuns, pOriginalLuns)
      => ComCall(12, this.p, VDS_LUN_INFORMATION.Ptr, pSnapshotLuns, VDS_LUN_INFORMATION.Ptr, pOriginalLuns, UInt32, pOriginalLuns.Length)
}
struct IVssFileShareSnapshotProvider extends IUnknown {
    static IID := "{C8636060-7C2E-11DF-8C4A-0800200C9A66}"
    SetContext(lContext)
      => ComCall(3, this.p, Int32, lContext)
    GetSnapshotProperties(SnapshotId, pProp)
      => ComCall(4, this.p, GUID, SnapshotId, VSS_SNAPSHOT_PROP.Ptr, pProp)
    Query(QueriedObjectId, eQueriedObjectType, eReturnedObjectsType, ppEnum)
      => ComCall(5, this.p, GUID, QueriedObjectId, VSS_OBJECT_TYPE, eQueriedObjectType, VSS_OBJECT_TYPE, eReturnedObjectsType, IVssEnumObject.Ptr, ppEnum)
    DeleteSnapshots(SourceObjectId, eSourceObjectType, bForceDelete, plDeletedSnapshots, pNondeletedSnapshotID)
      => ComCall(6, this.p, GUID, SourceObjectId, VSS_OBJECT_TYPE, eSourceObjectType, BOOL, bForceDelete, Int32.Ptr, plDeletedSnapshots, GUID.Ptr, pNondeletedSnapshotID)
    BeginPrepareSnapshot(SnapshotSetId, SnapshotId, pwszSharePath, lNewContext, ProviderId)
      => ComCall(7, this.p, GUID, SnapshotSetId, GUID, SnapshotId, UInt16.Ptr, pwszSharePath, Int32, lNewContext, GUID, ProviderId)
    IsPathSupported(pwszSharePath, pbSupportedByThisProvider)
      => ComCall(8, this.p, UInt16.Ptr, pwszSharePath, BOOL.Ptr, pbSupportedByThisProvider)
    IsPathSnapshotted(pwszSharePath, pbSnapshotsPresent, plSnapshotCompatibility)
      => ComCall(9, this.p, UInt16.Ptr, pwszSharePath, BOOL.Ptr, pbSnapshotsPresent, Int32.Ptr, plSnapshotCompatibility)
    SetSnapshotProperty(SnapshotId, eSnapshotPropertyId, vProperty)
      => ComCall(10, this.p, GUID, SnapshotId, VSS_SNAPSHOT_PROPERTY_ID, eSnapshotPropertyId, VARIANT, vProperty)
}
