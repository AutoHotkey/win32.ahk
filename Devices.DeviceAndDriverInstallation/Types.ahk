#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, FILETIME, HANDLE, HWND, LPARAM, PSTR, PWSTR}
#Import "..\System.Diagnostics.Debug\Types.ahk" {VER_PLATFORM}
#Import "..\System.SystemInformation\Types.ahk" {PROCESSOR_ARCHITECTURE}
#Import "..\UI.Controls\Types.ahk" {HIMAGELIST, HPROPSHEETPAGE}

struct SP_COPY_STYLE extends UInt32 {
    static SP_COPY_DELETESOURCE := 1
    static SP_COPY_REPLACEONLY := 2
    static SP_COPY_NEWER := 4
    static SP_COPY_NEWER_OR_SAME := 4
    static SP_COPY_NOOVERWRITE := 8
    static SP_COPY_NODECOMP := 16
    static SP_COPY_LANGUAGEAWARE := 32
    static SP_COPY_SOURCE_ABSOLUTE := 64
    static SP_COPY_SOURCEPATH_ABSOLUTE := 128
    static SP_COPY_IN_USE_NEEDS_REBOOT := 256
    static SP_COPY_FORCE_IN_USE := 512
    static SP_COPY_NOSKIP := 1024
    static SP_COPY_FORCE_NOOVERWRITE := 4096
    static SP_COPY_FORCE_NEWER := 8192
    static SP_COPY_WARNIFSKIP := 16384
    static SP_COPY_NOBROWSE := 32768
    static SP_COPY_NEWER_ONLY := 65536
    static SP_COPY_RESERVED := 131072
    static SP_COPY_OEMINF_CATALOG_ONLY := 262144
    static SP_COPY_REPLACE_BOOT_FILE := 524288
    static SP_COPY_NOPRUNE := 1048576
    static SP_COPY_OEM_F6_INF := 2097152
    static SP_COPY_ALREADYDECOMP := 4194304
    static SP_COPY_WINDOWS_SIGNED := 16777216
    static SP_COPY_PNPLOCKED := 33554432
    static SP_COPY_IN_USE_TRY_RENAME := 67108864
    static SP_COPY_INBOX_INF := 134217728
    static SP_COPY_HARDLINK := 268435456
}
struct SETUP_FILE_OPERATION extends UInt32 {
    static FILEOP_DELETE := 2
    static FILEOP_COPY := 0
}
struct OEM_SOURCE_MEDIA_TYPE extends UInt32 {
    static SPOST_NONE := 0
    static SPOST_PATH := 1
    static SPOST_URL := 2
}
struct SETUP_DI_DRIVER_TYPE extends UInt32 {
    static SPDIT_CLASSDRIVER := 1
    static SPDIT_COMPATDRIVER := 2
}
struct DIINSTALLDEVICE_FLAGS extends UInt32 {
    static DIIDFLAG_SHOWSEARCHUI := 1
    static DIIDFLAG_NOFINISHINSTALLUI := 2
    static DIIDFLAG_INSTALLNULLDRIVER := 4
    static DIIDFLAG_INSTALLCOPYINFDRIVERS := 8
    static DIIDFLAG_BITS := 15
}
struct DIINSTALLDRIVER_FLAGS extends UInt32 {
    static DIIRFLAG_BITS := 106
    static DIIRFLAG_SYSTEM_BITS := 127
    static DIIRFLAG_INF_ALREADY_COPIED := 1
    static DIIRFLAG_FORCE_INF := 2
    static DIIRFLAG_HW_USING_THE_INF := 4
    static DIIRFLAG_HOTPATCH := 8
    static DIIRFLAG_NOBACKUP := 16
    static DIIRFLAG_PRE_CONFIGURE_INF := 32
    static DIIRFLAG_INSTALL_AS_SET := 64
}
struct DIUNINSTALLDRIVER_FLAGS extends UInt32 {
    static DIURFLAG_VALID := 3
    static DIURFLAG_NO_REMOVE_INF := 1
    static DIURFLAG_RESERVED := 2
}
struct DIROLLBACKDRIVER_FLAGS extends UInt32 {
    static ROLLBACK_FLAG_NO_UI := 1
    static ROLLBACK_BITS := 1
}
struct UPDATEDRIVERFORPLUGANDPLAYDEVICES_FLAGS extends UInt32 {
    static INSTALLFLAG_FORCE := 1
    static INSTALLFLAG_READONLY := 2
    static INSTALLFLAG_NONINTERACTIVE := 4
    static INSTALLFLAG_BITS := 7
}
struct CM_RESTYPE extends UInt32 {
    static ResType_All := 0
    static ResType_None := 0
    static ResType_Mem := 1
    static ResType_IO := 2
    static ResType_DMA := 3
    static ResType_IRQ := 4
    static ResType_DoNotUse := 5
    static ResType_BusNumber := 6
    static ResType_MemLarge := 7
    static ResType_MAX := 7
    static ResType_Ignored_Bit := 32768
    static ResType_ClassSpecific := 65535
    static ResType_Reserved := 32768
    static ResType_DevicePrivate := 32769
    static ResType_PcCardConfig := 32770
    static ResType_MfCardConfig := 32771
    static ResType_Connection := 32772
}
struct CM_GET_DEVICE_INTERFACE_LIST_FLAGS extends UInt32 {
    static CM_GET_DEVICE_INTERFACE_LIST_PRESENT := 0
    static CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES := 1
    static CM_GET_DEVICE_INTERFACE_LIST_BITS := 1
}
struct CM_LOCATE_DEVNODE_FLAGS extends UInt32 {
    static CM_LOCATE_DEVNODE_NORMAL := 0
    static CM_LOCATE_DEVNODE_PHANTOM := 1
    static CM_LOCATE_DEVNODE_CANCELREMOVE := 2
    static CM_LOCATE_DEVNODE_NOVALIDATION := 4
    static CM_LOCATE_DEVNODE_BITS := 7
}
struct CM_REENUMERATE_FLAGS extends UInt32 {
    static CM_REENUMERATE_NORMAL := 0
    static CM_REENUMERATE_SYNCHRONOUS := 1
    static CM_REENUMERATE_RETRY_INSTALLATION := 2
    static CM_REENUMERATE_ASYNCHRONOUS := 4
    static CM_REENUMERATE_BITS := 7
}
struct CM_ENUMERATE_FLAGS extends UInt32 {
    static CM_ENUMERATE_CLASSES_INSTALLER := 0
    static CM_ENUMERATE_CLASSES_INTERFACE := 1
    static CM_ENUMERATE_CLASSES_BITS := 1
}
struct INF_STYLE extends UInt32 {
    static INF_STYLE_NONE := 0
    static INF_STYLE_OLDNT := 1
    static INF_STYLE_WIN4 := 2
    static INF_STYLE_CACHE_ENABLE := 16
    static INF_STYLE_CACHE_DISABLE := 32
    static INF_STYLE_CACHE_IGNORE := 64
}
struct SETUPSCANFILEQUEUE_FLAGS extends UInt32 {
    static SPQ_SCAN_FILE_PRESENCE := 1
    static SPQ_SCAN_FILE_VALIDITY := 2
    static SPQ_SCAN_USE_CALLBACK := 4
    static SPQ_SCAN_USE_CALLBACKEX := 8
    static SPQ_SCAN_INFORM_USER := 16
    static SPQ_SCAN_PRUNE_COPY_QUEUE := 32
    static SPQ_SCAN_USE_CALLBACK_SIGNERINFO := 64
    static SPQ_SCAN_PRUNE_DELREN := 128
    static SPQ_SCAN_FILE_PRESENCE_WITHOUT_SOURCE := 256
    static SPQ_SCAN_FILE_COMPARISON := 512
    static SPQ_SCAN_ACTIVATE_DRP := 1024
    static SPQ_SCAN_USE_OEM_CATALOGS := 2048
}
struct CM_LOG_CONF extends UInt32 {
    static BASIC_LOG_CONF := 0
    static FILTERED_LOG_CONF := 1
    static ALLOC_LOG_CONF := 2
    static BOOT_LOG_CONF := 3
    static FORCED_LOG_CONF := 4
    static OVERRIDE_LOG_CONF := 5
    static NUM_LOG_CONF := 6
}
struct CM_DEVNODE_STATUS_FLAGS extends UInt32 {
    static DN_CHANGEABLE_FLAGS := 1639670464
    static DN_ROOT_ENUMERATED := 1
    static DN_DRIVER_LOADED := 2
    static DN_ENUM_LOADED := 4
    static DN_STARTED := 8
    static DN_MANUAL := 16
    static DN_NEED_TO_ENUM := 32
    static DN_NOT_FIRST_TIME := 64
    static DN_HARDWARE_ENUM := 128
    static DN_LIAR := 256
    static DN_HAS_MARK := 512
    static DN_HAS_PROBLEM := 1024
    static DN_FILTERED := 2048
    static DN_MOVED := 4096
    static DN_DISABLEABLE := 8192
    static DN_REMOVABLE := 16384
    static DN_PRIVATE_PROBLEM := 32768
    static DN_MF_PARENT := 65536
    static DN_MF_CHILD := 131072
    static DN_WILL_BE_REMOVED := 262144
    static DN_NOT_FIRST_TIMEE := 524288
    static DN_STOP_FREE_RES := 1048576
    static DN_REBAL_CANDIDATE := 2097152
    static DN_BAD_PARTIAL := 4194304
    static DN_NT_ENUMERATOR := 8388608
    static DN_NT_DRIVER := 16777216
    static DN_NEEDS_LOCKING := 33554432
    static DN_ARM_WAKEUP := 67108864
    static DN_APM_ENUMERATOR := 134217728
    static DN_APM_DRIVER := 268435456
    static DN_SILENT_INSTALL := 536870912
    static DN_NO_SHOW_IN_DM := 1073741824
    static DN_BOOT_LOG_PROB := 2147483648
    static DN_NEED_RESTART := 256
    static DN_DRIVER_BLOCKED := 64
    static DN_LEGACY_DRIVER := 4096
    static DN_CHILD_WITH_INVALID_ID := 512
    static DN_DEVICE_DISCONNECTED := 33554432
    static DN_QUERY_REMOVE_PENDING := 65536
    static DN_QUERY_REMOVE_ACTIVE := 131072
}
struct CM_PROB extends UInt32 {
    static CM_PROB_NOT_CONFIGURED := 1
    static CM_PROB_DEVLOADER_FAILED := 2
    static CM_PROB_OUT_OF_MEMORY := 3
    static CM_PROB_ENTRY_IS_WRONG_TYPE := 4
    static CM_PROB_LACKED_ARBITRATOR := 5
    static CM_PROB_BOOT_CONFIG_CONFLICT := 6
    static CM_PROB_FAILED_FILTER := 7
    static CM_PROB_DEVLOADER_NOT_FOUND := 8
    static CM_PROB_INVALID_DATA := 9
    static CM_PROB_FAILED_START := 10
    static CM_PROB_LIAR := 11
    static CM_PROB_NORMAL_CONFLICT := 12
    static CM_PROB_NOT_VERIFIED := 13
    static CM_PROB_NEED_RESTART := 14
    static CM_PROB_REENUMERATION := 15
    static CM_PROB_PARTIAL_LOG_CONF := 16
    static CM_PROB_UNKNOWN_RESOURCE := 17
    static CM_PROB_REINSTALL := 18
    static CM_PROB_REGISTRY := 19
    static CM_PROB_VXDLDR := 20
    static CM_PROB_WILL_BE_REMOVED := 21
    static CM_PROB_DISABLED := 22
    static CM_PROB_DEVLOADER_NOT_READY := 23
    static CM_PROB_DEVICE_NOT_THERE := 24
    static CM_PROB_MOVED := 25
    static CM_PROB_TOO_EARLY := 26
    static CM_PROB_NO_VALID_LOG_CONF := 27
    static CM_PROB_FAILED_INSTALL := 28
    static CM_PROB_HARDWARE_DISABLED := 29
    static CM_PROB_CANT_SHARE_IRQ := 30
    static CM_PROB_FAILED_ADD := 31
    static CM_PROB_DISABLED_SERVICE := 32
    static CM_PROB_TRANSLATION_FAILED := 33
    static CM_PROB_NO_SOFTCONFIG := 34
    static CM_PROB_BIOS_TABLE := 35
    static CM_PROB_IRQ_TRANSLATION_FAILED := 36
    static CM_PROB_FAILED_DRIVER_ENTRY := 37
    static CM_PROB_DRIVER_FAILED_PRIOR_UNLOAD := 38
    static CM_PROB_DRIVER_FAILED_LOAD := 39
    static CM_PROB_DRIVER_SERVICE_KEY_INVALID := 40
    static CM_PROB_LEGACY_SERVICE_NO_DEVICES := 41
    static CM_PROB_DUPLICATE_DEVICE := 42
    static CM_PROB_FAILED_POST_START := 43
    static CM_PROB_HALTED := 44
    static CM_PROB_PHANTOM := 45
    static CM_PROB_SYSTEM_SHUTDOWN := 46
    static CM_PROB_HELD_FOR_EJECT := 47
    static CM_PROB_DRIVER_BLOCKED := 48
    static CM_PROB_REGISTRY_TOO_LARGE := 49
    static CM_PROB_SETPROPERTIES_FAILED := 50
    static CM_PROB_WAITING_ON_DEPENDENCY := 51
    static CM_PROB_UNSIGNED_DRIVER := 52
    static CM_PROB_USED_BY_DEBUGGER := 53
    static CM_PROB_DEVICE_RESET := 54
    static CM_PROB_CONSOLE_LOCKED := 55
    static CM_PROB_NEED_CLASS_CONFIG := 56
    static CM_PROB_GUEST_ASSIGNMENT_FAILED := 57
}
struct SPSVCINST_FLAGS extends UInt32 {
    static SPSVCINST_TAGTOFRONT := 1
    static SPSVCINST_ASSOCSERVICE := 2
    static SPSVCINST_DELETEEVENTLOGENTRY := 4
    static SPSVCINST_NOCLOBBER_DISPLAYNAME := 8
    static SPSVCINST_NOCLOBBER_STARTTYPE := 16
    static SPSVCINST_NOCLOBBER_ERRORCONTROL := 32
    static SPSVCINST_NOCLOBBER_LOADORDERGROUP := 64
    static SPSVCINST_NOCLOBBER_DEPENDENCIES := 128
    static SPSVCINST_NOCLOBBER_DESCRIPTION := 256
    static SPSVCINST_STOPSERVICE := 512
    static SPSVCINST_CLOBBER_SECURITY := 1024
    static SPSVCINST_STARTSERVICE := 2048
    static SPSVCINST_NOCLOBBER_REQUIREDPRIVILEGES := 4096
    static SPSVCINST_NOCLOBBER_TRIGGERS := 8192
    static SPSVCINST_NOCLOBBER_SERVICESIDTYPE := 16384
    static SPSVCINST_NOCLOBBER_DELAYEDAUTOSTART := 32768
    static SPSVCINST_UNIQUE_NAME := 65536
    static SPSVCINST_NOCLOBBER_FAILUREACTIONS := 131072
    static SPSVCINST_NOCLOBBER_BOOTFLAGS := 262144
}
struct CM_CDMASK extends UInt32 {
    static CM_CDMASK_DEVINST := 1
    static CM_CDMASK_RESDES := 2
    static CM_CDMASK_FLAGS := 4
    static CM_CDMASK_DESCRIPTION := 8
    static CM_CDMASK_VALID := 15
}
struct CM_CDFLAGS extends UInt32 {
    static CM_CDFLAGS_DRIVER := 1
    static CM_CDFLAGS_ROOT_OWNED := 2
    static CM_CDFLAGS_RESERVED := 4
}
struct CM_REMOVAL_POLICY extends UInt32 {
    static CM_REMOVAL_POLICY_EXPECT_NO_REMOVAL := 1
    static CM_REMOVAL_POLICY_EXPECT_ORDERLY_REMOVAL := 2
    static CM_REMOVAL_POLICY_EXPECT_SURPRISE_REMOVAL := 3
}
struct CM_INSTALL_STATE extends UInt32 {
    static CM_INSTALL_STATE_INSTALLED := 0
    static CM_INSTALL_STATE_NEEDS_REINSTALL := 1
    static CM_INSTALL_STATE_FAILED_INSTALL := 2
    static CM_INSTALL_STATE_FINISH_INSTALL := 3
}
struct CM_DEVCAP extends UInt32 {
    static CM_DEVCAP_LOCKSUPPORTED := 1
    static CM_DEVCAP_EJECTSUPPORTED := 2
    static CM_DEVCAP_REMOVABLE := 4
    static CM_DEVCAP_DOCKDEVICE := 8
    static CM_DEVCAP_UNIQUEID := 16
    static CM_DEVCAP_SILENTINSTALL := 32
    static CM_DEVCAP_RAWDEVICEOK := 64
    static CM_DEVCAP_SURPRISEREMOVALOK := 128
    static CM_DEVCAP_HARDWAREDISABLED := 256
    static CM_DEVCAP_NONDYNAMIC := 512
    static CM_DEVCAP_SECUREDEVICE := 1024
}
struct DD_FLAGS extends UInt32 {
    static mDD_Width := 3
    static fDD_BYTE := 0
    static fDD_WORD := 1
    static fDD_DWORD := 2
    static fDD_BYTE_AND_WORD := 3
    static mDD_BusMaster := 4
    static fDD_NoBusMaster := 0
    static fDD_BusMaster := 4
    static mDD_Type := 24
    static fDD_TypeStandard := 0
    static fDD_TypeA := 8
    static fDD_TypeB := 16
    static fDD_TypeF := 24
}
struct IOD_DESFLAGS extends UInt32 {
    static fIOD_PortType := 1
    static fIOD_Memory := 0
    static fIOD_IO := 1
    static fIOD_DECODE := 252
    static fIOD_10_BIT_DECODE := 4
    static fIOD_12_BIT_DECODE := 8
    static fIOD_16_BIT_DECODE := 16
    static fIOD_POSITIVE_DECODE := 32
    static fIOD_PASSIVE_DECODE := 64
    static fIOD_WINDOW_DECODE := 128
    static fIOD_PORT_BAR := 256
}
struct IRQD_FLAGS extends UInt32 {
    static mIRQD_Share := 1
    static fIRQD_Exclusive := 0
    static fIRQD_Share := 1
    static fIRQD_Share_Bit := 0
    static fIRQD_Level_Bit := 1
    static mIRQD_Edge_Level := 2
    static fIRQD_Level := 0
    static fIRQD_Edge := 2
}
struct MD_FLAGS extends UInt32 {
    static mMD_MemoryType := 1
    static fMD_MemoryType := 1
    static fMD_ROM := 0
    static fMD_RAM := 1
    static mMD_32_24 := 2
    static fMD_32_24 := 2
    static fMD_24 := 0
    static fMD_32 := 2
    static mMD_Prefetchable := 4
    static fMD_Prefetchable := 4
    static fMD_Pref := 4
    static fMD_PrefetchDisallowed := 0
    static fMD_PrefetchAllowed := 4
    static mMD_Readable := 8
    static fMD_Readable := 8
    static fMD_ReadAllowed := 0
    static fMD_ReadDisallowed := 8
    static mMD_CombinedWrite := 16
    static fMD_CombinedWrite := 16
    static fMD_CombinedWriteDisallowed := 0
    static fMD_CombinedWriteAllowed := 16
    static mMD_Cacheable := 32
    static fMD_NonCacheable := 0
    static fMD_Cacheable := 32
    static fMD_WINDOW_DECODE := 64
    static fMD_MEMORY_BAR := 128
}
struct PMF_FLAGS extends UInt32 {
    static fPMF_AUDIO_ENABLE := 8
}
struct PCD_FLAGS extends UInt32 {
    static mPCD_IO_8_16 := 1
    static fPCD_IO_8 := 0
    static fPCD_IO_16 := 1
    static mPCD_MEM_8_16 := 2
    static fPCD_MEM_8 := 0
    static fPCD_MEM_16 := 2
    static mPCD_MEM_A_C := 12
    static fPCD_MEM1_A := 4
    static fPCD_MEM2_A := 8
    static fPCD_IO_ZW_8 := 16
    static fPCD_IO_SRC_16 := 32
    static fPCD_IO_WS_16 := 64
    static mPCD_MEM_WS := 768
    static fPCD_MEM_WS_ONE := 256
    static fPCD_MEM_WS_TWO := 512
    static fPCD_MEM_WS_THREE := 768
    static fPCD_MEM_A := 4
    static fPCD_ATTRIBUTES_PER_WINDOW := 32768
    static fPCD_IO1_16 := 65536
    static fPCD_IO1_ZW_8 := 131072
    static fPCD_IO1_SRC_16 := 262144
    static fPCD_IO1_WS_16 := 524288
    static fPCD_IO2_16 := 1048576
    static fPCD_IO2_ZW_8 := 2097152
    static fPCD_IO2_SRC_16 := 4194304
    static fPCD_IO2_WS_16 := 8388608
    static mPCD_MEM1_WS := 50331648
    static fPCD_MEM1_WS_ONE := 16777216
    static fPCD_MEM1_WS_TWO := 33554432
    static fPCD_MEM1_WS_THREE := 50331648
    static fPCD_MEM1_16 := 67108864
    static mPCD_MEM2_WS := 805306368
    static fPCD_MEM2_WS_ONE := 268435456
    static fPCD_MEM2_WS_TWO := 536870912
    static fPCD_MEM2_WS_THREE := 805306368
    static fPCD_MEM2_16 := 1073741824
}
struct SETUP_DI_REGISTRY_PROPERTY extends UInt32 {
    static SPDRP_DEVICEDESC := 0
    static SPDRP_HARDWAREID := 1
    static SPDRP_COMPATIBLEIDS := 2
    static SPDRP_UNUSED0 := 3
    static SPDRP_SERVICE := 4
    static SPDRP_UNUSED1 := 5
    static SPDRP_UNUSED2 := 6
    static SPDRP_CLASS := 7
    static SPDRP_CLASSGUID := 8
    static SPDRP_DRIVER := 9
    static SPDRP_CONFIGFLAGS := 10
    static SPDRP_MFG := 11
    static SPDRP_FRIENDLYNAME := 12
    static SPDRP_LOCATION_INFORMATION := 13
    static SPDRP_PHYSICAL_DEVICE_OBJECT_NAME := 14
    static SPDRP_CAPABILITIES := 15
    static SPDRP_UI_NUMBER := 16
    static SPDRP_UPPERFILTERS := 17
    static SPDRP_LOWERFILTERS := 18
    static SPDRP_BUSTYPEGUID := 19
    static SPDRP_LEGACYBUSTYPE := 20
    static SPDRP_BUSNUMBER := 21
    static SPDRP_ENUMERATOR_NAME := 22
    static SPDRP_SECURITY := 23
    static SPDRP_SECURITY_SDS := 24
    static SPDRP_DEVTYPE := 25
    static SPDRP_EXCLUSIVE := 26
    static SPDRP_CHARACTERISTICS := 27
    static SPDRP_ADDRESS := 28
    static SPDRP_UI_NUMBER_DESC_FORMAT := 29
    static SPDRP_DEVICE_POWER_DATA := 30
    static SPDRP_REMOVAL_POLICY := 31
    static SPDRP_REMOVAL_POLICY_HW_DEFAULT := 32
    static SPDRP_REMOVAL_POLICY_OVERRIDE := 33
    static SPDRP_INSTALL_STATE := 34
    static SPDRP_LOCATION_PATHS := 35
    static SPDRP_BASE_CONTAINERID := 36
    static SPDRP_MAXIMUM_PROPERTY := 37
}
struct SETUP_DI_DEVICE_CREATION_FLAGS extends UInt32 {
    static DICD_GENERATE_ID := 1
    static DICD_INHERIT_CLASSDRVS := 2
}
struct SETUP_DI_DRIVER_INSTALL_FLAGS extends UInt32 {
    static DNF_DUPDESC := 1
    static DNF_OLDDRIVER := 2
    static DNF_EXCLUDEFROMLIST := 4
    static DNF_NODRIVER := 8
    static DNF_LEGACYINF := 16
    static DNF_CLASS_DRIVER := 32
    static DNF_COMPATIBLE_DRIVER := 64
    static DNF_INET_DRIVER := 128
    static DNF_UNUSED1 := 256
    static DNF_UNUSED2 := 512
    static DNF_OLD_INET_DRIVER := 1024
    static DNF_BAD_DRIVER := 2048
    static DNF_DUPPROVIDER := 4096
    static DNF_INF_IS_SIGNED := 8192
    static DNF_OEM_F6_INF := 16384
    static DNF_DUPDRIVERVER := 32768
    static DNF_BASIC_DRIVER := 65536
    static DNF_AUTHENTICODE_SIGNED := 131072
    static DNF_INSTALLEDDRIVER := 262144
    static DNF_ALWAYSEXCLUDEFROMLIST := 524288
    static DNF_INBOX_DRIVER := 1048576
    static DNF_REQUESTADDITIONALSOFTWARE := 2097152
    static DNF_UNUSED_22 := 4194304
    static DNF_UNUSED_23 := 8388608
    static DNF_UNUSED_24 := 16777216
    static DNF_UNUSED_25 := 33554432
    static DNF_UNUSED_26 := 67108864
    static DNF_UNUSED_27 := 134217728
    static DNF_UNUSED_28 := 268435456
    static DNF_UNUSED_29 := 536870912
    static DNF_UNUSED_30 := 1073741824
    static DNF_UNUSED_31 := 2147483648
}
struct SETUP_DI_STATE_CHANGE extends UInt32 {
    static DICS_ENABLE := 1
    static DICS_DISABLE := 2
    static DICS_PROPCHANGE := 3
    static DICS_START := 4
    static DICS_STOP := 5
}
struct SETUP_DI_PROPERTY_CHANGE_SCOPE extends UInt32 {
    static DICS_FLAG_GLOBAL := 1
    static DICS_FLAG_CONFIGSPECIFIC := 2
    static DICS_FLAG_CONFIGGENERAL := 4
}
struct SETUP_DI_REMOVE_DEVICE_SCOPE extends UInt32 {
    static DI_REMOVEDEVICE_GLOBAL := 1
    static DI_REMOVEDEVICE_CONFIGSPECIFIC := 2
}
struct SETUP_DI_GET_CLASS_DEVS_FLAGS extends UInt32 {
    static DIGCF_DEFAULT := 1
    static DIGCF_PRESENT := 2
    static DIGCF_ALLCLASSES := 4
    static DIGCF_PROFILE := 8
    static DIGCF_DEVICEINTERFACE := 16
    static DIGCF_INTERFACEDEVICE := 16
}
struct DI_FUNCTION extends UInt32 {
    static DIF_SELECTDEVICE := 1
    static DIF_INSTALLDEVICE := 2
    static DIF_ASSIGNRESOURCES := 3
    static DIF_PROPERTIES := 4
    static DIF_REMOVE := 5
    static DIF_FIRSTTIMESETUP := 6
    static DIF_FOUNDDEVICE := 7
    static DIF_SELECTCLASSDRIVERS := 8
    static DIF_VALIDATECLASSDRIVERS := 9
    static DIF_INSTALLCLASSDRIVERS := 10
    static DIF_CALCDISKSPACE := 11
    static DIF_DESTROYPRIVATEDATA := 12
    static DIF_VALIDATEDRIVER := 13
    static DIF_DETECT := 15
    static DIF_INSTALLWIZARD := 16
    static DIF_DESTROYWIZARDDATA := 17
    static DIF_PROPERTYCHANGE := 18
    static DIF_ENABLECLASS := 19
    static DIF_DETECTVERIFY := 20
    static DIF_INSTALLDEVICEFILES := 21
    static DIF_UNREMOVE := 22
    static DIF_SELECTBESTCOMPATDRV := 23
    static DIF_ALLOW_INSTALL := 24
    static DIF_REGISTERDEVICE := 25
    static DIF_NEWDEVICEWIZARD_PRESELECT := 26
    static DIF_NEWDEVICEWIZARD_SELECT := 27
    static DIF_NEWDEVICEWIZARD_PREANALYZE := 28
    static DIF_NEWDEVICEWIZARD_POSTANALYZE := 29
    static DIF_NEWDEVICEWIZARD_FINISHINSTALL := 30
    static DIF_UNUSED1 := 31
    static DIF_INSTALLINTERFACES := 32
    static DIF_DETECTCANCEL := 33
    static DIF_REGISTER_COINSTALLERS := 34
    static DIF_ADDPROPERTYPAGE_ADVANCED := 35
    static DIF_ADDPROPERTYPAGE_BASIC := 36
    static DIF_RESERVED1 := 37
    static DIF_TROUBLESHOOTER := 38
    static DIF_POWERMESSAGEWAKE := 39
    static DIF_ADDREMOTEPROPERTYPAGE_ADVANCED := 40
    static DIF_UPDATEDRIVER_UI := 41
    static DIF_FINISHINSTALL_ACTION := 42
    static DIF_RESERVED2 := 48
    static DIF_MOVEDEVICE := 14
}
struct SETUP_DI_DEVICE_INSTALL_FLAGS extends UInt32 {
    static DI_SHOWOEM := 1
    static DI_SHOWCOMPAT := 2
    static DI_SHOWCLASS := 4
    static DI_SHOWALL := 7
    static DI_NOVCP := 8
    static DI_DIDCOMPAT := 16
    static DI_DIDCLASS := 32
    static DI_AUTOASSIGNRES := 64
    static DI_NEEDRESTART := 128
    static DI_NEEDREBOOT := 256
    static DI_NOBROWSE := 512
    static DI_MULTMFGS := 1024
    static DI_DISABLED := 2048
    static DI_GENERALPAGE_ADDED := 4096
    static DI_RESOURCEPAGE_ADDED := 8192
    static DI_PROPERTIES_CHANGE := 16384
    static DI_INF_IS_SORTED := 32768
    static DI_ENUMSINGLEINF := 65536
    static DI_DONOTCALLCONFIGMG := 131072
    static DI_INSTALLDISABLED := 262144
    static DI_COMPAT_FROM_CLASS := 524288
    static DI_CLASSINSTALLPARAMS := 1048576
    static DI_NODI_DEFAULTACTION := 2097152
    static DI_QUIETINSTALL := 8388608
    static DI_NOFILECOPY := 16777216
    static DI_FORCECOPY := 33554432
    static DI_DRIVERPAGE_ADDED := 67108864
    static DI_USECI_SELECTSTRINGS := 134217728
    static DI_OVERRIDE_INFFLAGS := 268435456
    static DI_PROPS_NOCHANGEUSAGE := 536870912
    static DI_NOSELECTICONS := 1073741824
    static DI_NOWRITE_IDS := 2147483648
    static DI_UNREMOVEDEVICE_CONFIGSPECIFIC := 2
}
struct SETUP_DI_DEVICE_INSTALL_FLAGS_EX extends UInt32 {
    static DI_FLAGSEX_RESERVED2 := 1
    static DI_FLAGSEX_RESERVED3 := 2
    static DI_FLAGSEX_CI_FAILED := 4
    static DI_FLAGSEX_FINISHINSTALL_ACTION := 8
    static DI_FLAGSEX_DIDINFOLIST := 16
    static DI_FLAGSEX_DIDCOMPATINFO := 32
    static DI_FLAGSEX_FILTERCLASSES := 64
    static DI_FLAGSEX_SETFAILEDINSTALL := 128
    static DI_FLAGSEX_DEVICECHANGE := 256
    static DI_FLAGSEX_ALWAYSWRITEIDS := 512
    static DI_FLAGSEX_PROPCHANGE_PENDING := 1024
    static DI_FLAGSEX_ALLOWEXCLUDEDDRVS := 2048
    static DI_FLAGSEX_NOUIONQUERYREMOVE := 4096
    static DI_FLAGSEX_USECLASSFORCOMPAT := 8192
    static DI_FLAGSEX_RESERVED4 := 16384
    static DI_FLAGSEX_NO_DRVREG_MODIFY := 32768
    static DI_FLAGSEX_IN_SYSTEM_SETUP := 65536
    static DI_FLAGSEX_INET_DRIVER := 131072
    static DI_FLAGSEX_APPENDDRIVERLIST := 262144
    static DI_FLAGSEX_PREINSTALLBACKUP := 524288
    static DI_FLAGSEX_BACKUPONREPLACE := 1048576
    static DI_FLAGSEX_DRIVERLIST_FROM_URL := 2097152
    static DI_FLAGSEX_RESERVED1 := 4194304
    static DI_FLAGSEX_EXCLUDE_OLD_INET_DRIVERS := 8388608
    static DI_FLAGSEX_POWERPAGE_ADDED := 16777216
    static DI_FLAGSEX_FILTERSIMILARDRIVERS := 33554432
    static DI_FLAGSEX_INSTALLEDDRIVER := 67108864
    static DI_FLAGSEX_NO_CLASSLIST_NODE_MERGE := 134217728
    static DI_FLAGSEX_ALTPLATFORM_DRVSEARCH := 268435456
    static DI_FLAGSEX_RESTART_DEVICE_ONLY := 536870912
    static DI_FLAGSEX_RECURSIVESEARCH := 1073741824
    static DI_FLAGSEX_SEARCH_PUBLISHED_INFS := 2147483648
}
struct SETUP_DI_DEVICE_CONFIGURATION_FLAGS extends UInt32 {
    static CONFIGFLAG_DISABLED := 1
    static CONFIGFLAG_REMOVED := 2
    static CONFIGFLAG_MANUAL_INSTALL := 4
    static CONFIGFLAG_IGNORE_BOOT_LC := 8
    static CONFIGFLAG_NET_BOOT := 16
    static CONFIGFLAG_REINSTALL := 32
    static CONFIGFLAG_FAILEDINSTALL := 64
    static CONFIGFLAG_CANTSTOPACHILD := 128
    static CONFIGFLAG_OKREMOVEROM := 256
    static CONFIGFLAG_NOREMOVEEXIT := 512
    static CONFIGFLAG_FINISH_INSTALL := 1024
    static CONFIGFLAG_NEEDS_FORCED_CONFIG := 2048
    static CONFIGFLAG_NETBOOT_CARD := 4096
    static CONFIGFLAG_PARTIAL_LOG_CONF := 8192
    static CONFIGFLAG_SUPPRESS_SURPRISE := 16384
    static CONFIGFLAG_VERIFY_HARDWARE := 32768
    static CONFIGFLAG_FINISHINSTALL_UI := 65536
    static CONFIGFLAG_FINISHINSTALL_ACTION := 131072
    static CONFIGFLAG_BOOT_DEVICE := 262144
    static CONFIGFLAG_NEEDS_CLASS_CONFIG := 524288
}
struct FILE_COMPRESSION_TYPE extends UInt32 {
    static FILE_COMPRESSION_NONE := 0
    static FILE_COMPRESSION_WINLZA := 1
    static FILE_COMPRESSION_MSZIP := 2
    static FILE_COMPRESSION_NTCAB := 3
}
struct CONFIGRET extends UInt32 {
    static CR_SUCCESS := 0
    static CR_DEFAULT := 1
    static CR_OUT_OF_MEMORY := 2
    static CR_INVALID_POINTER := 3
    static CR_INVALID_FLAG := 4
    static CR_INVALID_DEVNODE := 5
    static CR_INVALID_DEVINST := 5
    static CR_INVALID_RES_DES := 6
    static CR_INVALID_LOG_CONF := 7
    static CR_INVALID_ARBITRATOR := 8
    static CR_INVALID_NODELIST := 9
    static CR_DEVNODE_HAS_REQS := 10
    static CR_DEVINST_HAS_REQS := 10
    static CR_INVALID_RESOURCEID := 11
    static CR_DLVXD_NOT_FOUND := 12
    static CR_NO_SUCH_DEVNODE := 13
    static CR_NO_SUCH_DEVINST := 13
    static CR_NO_MORE_LOG_CONF := 14
    static CR_NO_MORE_RES_DES := 15
    static CR_ALREADY_SUCH_DEVNODE := 16
    static CR_ALREADY_SUCH_DEVINST := 16
    static CR_INVALID_RANGE_LIST := 17
    static CR_INVALID_RANGE := 18
    static CR_FAILURE := 19
    static CR_NO_SUCH_LOGICAL_DEV := 20
    static CR_CREATE_BLOCKED := 21
    static CR_NOT_SYSTEM_VM := 22
    static CR_REMOVE_VETOED := 23
    static CR_APM_VETOED := 24
    static CR_INVALID_LOAD_TYPE := 25
    static CR_BUFFER_SMALL := 26
    static CR_NO_ARBITRATOR := 27
    static CR_NO_REGISTRY_HANDLE := 28
    static CR_REGISTRY_ERROR := 29
    static CR_INVALID_DEVICE_ID := 30
    static CR_INVALID_DATA := 31
    static CR_INVALID_API := 32
    static CR_DEVLOADER_NOT_READY := 33
    static CR_NEED_RESTART := 34
    static CR_NO_MORE_HW_PROFILES := 35
    static CR_DEVICE_NOT_THERE := 36
    static CR_NO_SUCH_VALUE := 37
    static CR_WRONG_TYPE := 38
    static CR_INVALID_PRIORITY := 39
    static CR_NOT_DISABLEABLE := 40
    static CR_FREE_RESOURCES := 41
    static CR_QUERY_VETOED := 42
    static CR_CANT_SHARE_IRQ := 43
    static CR_NO_DEPENDENT := 44
    static CR_SAME_RESOURCES := 45
    static CR_NO_SUCH_REGISTRY_KEY := 46
    static CR_INVALID_MACHINENAME := 47
    static CR_REMOTE_COMM_FAILURE := 48
    static CR_MACHINE_UNAVAILABLE := 49
    static CR_NO_CM_SERVICES := 50
    static CR_ACCESS_DENIED := 51
    static CR_CALL_NOT_IMPLEMENTED := 52
    static CR_INVALID_PROPERTY := 53
    static CR_DEVICE_INTERFACE_ACTIVE := 54
    static CR_NO_SUCH_DEVICE_INTERFACE := 55
    static CR_INVALID_REFERENCE_STRING := 56
    static CR_INVALID_CONFLICT_LIST := 57
    static CR_INVALID_INDEX := 58
    static CR_INVALID_STRUCTURE_SIZE := 59
    static NUM_CR_RESULTS := 60
}
struct HDEVINFO {
    Value : IntPtr
}
struct HCMNOTIFICATION {
    Value : IntPtr
}
struct INFCONTEXT {
    Inf : Struct.Ptr
    CurrentInf : Struct.Ptr
    Section : UInt32
    Line : UInt32
}
struct SP_INF_INFORMATION {
    InfStyle : INF_STYLE
    InfCount : UInt32
    VersionData : UInt8[1]
}
struct SP_ALTPLATFORM_INFO_V3 {
    cbSize : UInt32 := this.Size
    Platform : UInt32
    MajorVersion : UInt32
    MinorVersion : UInt32
    ProcessorArchitecture : UInt16
    Anonymous : this._Anonymous_e__Union
    FirstValidatedMajorVersion : UInt32
    FirstValidatedMinorVersion : UInt32
    ProductType : UInt8
    SuiteMask : UInt16
    BuildNumber : UInt32
    struct _Anonymous_e__Union {
        union {
            Reserved : UInt16
            Flags : UInt16
        }
    }
}
struct SP_ALTPLATFORM_INFO_V2 {
    cbSize : UInt32 := this.Size
    Platform : VER_PLATFORM
    MajorVersion : UInt32
    MinorVersion : UInt32
    ProcessorArchitecture : PROCESSOR_ARCHITECTURE
    Anonymous : this._Anonymous_e__Union
    FirstValidatedMajorVersion : UInt32
    FirstValidatedMinorVersion : UInt32
    struct _Anonymous_e__Union {
        union {
            Reserved : UInt16
            Flags : UInt16
        }
    }
}
struct SP_ALTPLATFORM_INFO_V1 {
    cbSize : UInt32 := this.Size
    Platform : VER_PLATFORM
    MajorVersion : UInt32
    MinorVersion : UInt32
    ProcessorArchitecture : UInt16
    Reserved : UInt16
}
struct SP_ORIGINAL_FILE_INFO_A {
    cbSize : UInt32 := this.Size
    OriginalInfName : CHAR[260]
    OriginalCatalogName : CHAR[260]
}
struct SP_ORIGINAL_FILE_INFO_W {
    cbSize : UInt32 := this.Size
    OriginalInfName : UInt16[260]
    OriginalCatalogName : UInt16[260]
}
struct FILEPATHS_A {
    Target : PSTR
    Source : PSTR
    Win32Error : UInt32
    Flags : UInt32
}
struct FILEPATHS_W {
    Target : PWSTR
    Source : PWSTR
    Win32Error : UInt32
    Flags : UInt32
}
struct FILEPATHS_SIGNERINFO_A {
    Target : PSTR
    Source : PSTR
    Win32Error : UInt32
    Flags : UInt32
    DigitalSigner : PSTR
    Version : PSTR
    CatalogFile : PSTR
}
struct FILEPATHS_SIGNERINFO_W {
    Target : PWSTR
    Source : PWSTR
    Win32Error : UInt32
    Flags : UInt32
    DigitalSigner : PWSTR
    Version : PWSTR
    CatalogFile : PWSTR
}
struct SOURCE_MEDIA_A {
    Reserved : PSTR
    Tagfile : PSTR
    Description : PSTR
    SourcePath : PSTR
    SourceFile : PSTR
    Flags : UInt32
}
struct SOURCE_MEDIA_W {
    Reserved : PWSTR
    Tagfile : PWSTR
    Description : PWSTR
    SourcePath : PWSTR
    SourceFile : PWSTR
    Flags : UInt32
}
struct CABINET_INFO_A {
    CabinetPath : PSTR
    CabinetFile : PSTR
    DiskName : PSTR
    SetId : UInt16
    CabinetNumber : UInt16
}
struct CABINET_INFO_W {
    CabinetPath : PWSTR
    CabinetFile : PWSTR
    DiskName : PWSTR
    SetId : UInt16
    CabinetNumber : UInt16
}
struct FILE_IN_CABINET_INFO_A {
    NameInCabinet : PSTR
    FileSize : UInt32
    Win32Error : UInt32
    DosDate : UInt16
    DosTime : UInt16
    DosAttribs : UInt16
    FullTargetName : CHAR[260]
}
struct FILE_IN_CABINET_INFO_W {
    NameInCabinet : PWSTR
    FileSize : UInt32
    Win32Error : UInt32
    DosDate : UInt16
    DosTime : UInt16
    DosAttribs : UInt16
    FullTargetName : UInt16[260]
}
struct SP_REGISTER_CONTROL_STATUSA {
    cbSize : UInt32 := this.Size
    FileName : PSTR
    Win32Error : UInt32
    FailureCode : UInt32
}
struct SP_REGISTER_CONTROL_STATUSW {
    cbSize : UInt32 := this.Size
    FileName : PWSTR
    Win32Error : UInt32
    FailureCode : UInt32
}
struct SP_FILE_COPY_PARAMS_A {
    cbSize : UInt32 := this.Size
    QueueHandle : Struct.Ptr
    SourceRootPath : PSTR
    SourcePath : PSTR
    SourceFilename : PSTR
    SourceDescription : PSTR
    SourceTagfile : PSTR
    TargetDirectory : PSTR
    TargetFilename : PSTR
    CopyStyle : UInt32
    LayoutInf : Struct.Ptr
    SecurityDescriptor : PSTR
}
struct SP_FILE_COPY_PARAMS_W {
    cbSize : UInt32 := this.Size
    QueueHandle : Struct.Ptr
    SourceRootPath : PWSTR
    SourcePath : PWSTR
    SourceFilename : PWSTR
    SourceDescription : PWSTR
    SourceTagfile : PWSTR
    TargetDirectory : PWSTR
    TargetFilename : PWSTR
    CopyStyle : UInt32
    LayoutInf : Struct.Ptr
    SecurityDescriptor : PWSTR
}
struct SP_DEVINFO_DATA {
    cbSize : UInt32 := this.Size
    ClassGuid : GUID
    DevInst : UInt32
    Reserved : IntPtr
}
struct SP_DEVICE_INTERFACE_DATA {
    cbSize : UInt32 := this.Size
    InterfaceClassGuid : GUID
    Flags : UInt32
    Reserved : IntPtr
}
struct SP_DEVICE_INTERFACE_DETAIL_DATA_A {
    cbSize : UInt32 := this.Size
    DevicePath : CHAR[1]
}
struct SP_DEVICE_INTERFACE_DETAIL_DATA_W {
    cbSize : UInt32 := this.Size
    DevicePath : UInt16[1]
}
struct SP_DEVINFO_LIST_DETAIL_DATA_A {
    cbSize : UInt32 := this.Size
    ClassGuid : GUID
    RemoteMachineHandle : HANDLE
    RemoteMachineName : CHAR[263]
}
struct SP_DEVINFO_LIST_DETAIL_DATA_W {
    cbSize : UInt32 := this.Size
    ClassGuid : GUID
    RemoteMachineHandle : HANDLE
    RemoteMachineName : UInt16[263]
}
struct SP_DEVINSTALL_PARAMS_A {
    cbSize : UInt32 := this.Size
    Flags : SETUP_DI_DEVICE_INSTALL_FLAGS
    FlagsEx : SETUP_DI_DEVICE_INSTALL_FLAGS_EX
    hwndParent : HWND
    InstallMsgHandler : PSP_FILE_CALLBACK_A
    InstallMsgHandlerContext : Struct.Ptr
    FileQueue : Struct.Ptr
    ClassInstallReserved : IntPtr
    Reserved : UInt32
    DriverPath : CHAR[260]
}
struct SP_DEVINSTALL_PARAMS_W {
    cbSize : UInt32 := this.Size
    Flags : SETUP_DI_DEVICE_INSTALL_FLAGS
    FlagsEx : SETUP_DI_DEVICE_INSTALL_FLAGS_EX
    hwndParent : HWND
    InstallMsgHandler : PSP_FILE_CALLBACK_W
    InstallMsgHandlerContext : Struct.Ptr
    FileQueue : Struct.Ptr
    ClassInstallReserved : IntPtr
    Reserved : UInt32
    DriverPath : UInt16[260]
}
struct SP_CLASSINSTALL_HEADER {
    cbSize : UInt32 := this.Size
    InstallFunction : DI_FUNCTION
}
struct SP_ENABLECLASS_PARAMS {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    ClassGuid : GUID
    EnableMessage : UInt32
}
struct SP_PROPCHANGE_PARAMS {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    StateChange : SETUP_DI_STATE_CHANGE
    Scope : SETUP_DI_PROPERTY_CHANGE_SCOPE
    HwProfile : UInt32
}
struct SP_REMOVEDEVICE_PARAMS {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Scope : SETUP_DI_REMOVE_DEVICE_SCOPE
    HwProfile : UInt32
}
struct SP_UNREMOVEDEVICE_PARAMS {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Scope : UInt32
    HwProfile : UInt32
}
struct SP_SELECTDEVICE_PARAMS_W {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Title : UInt16[60]
    Instructions : UInt16[256]
    ListLabel : UInt16[30]
    SubTitle : UInt16[256]
}
struct SP_DETECTDEVICE_PARAMS {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    DetectProgressNotify : PDETECT_PROGRESS_NOTIFY
    ProgressNotifyParam : Struct.Ptr
}
struct SP_INSTALLWIZARD_DATA {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Flags : UInt32
    DynamicPages : HPROPSHEETPAGE[20]
    NumDynamicPages : UInt32
    DynamicPageFlags : UInt32
    PrivateFlags : UInt32
    PrivateData : LPARAM
    hwndWizardDlg : HWND
}
struct SP_NEWDEVICEWIZARD_DATA {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Flags : UInt32
    DynamicPages : HPROPSHEETPAGE[20]
    NumDynamicPages : UInt32
    hwndWizardDlg : HWND
}
struct SP_TROUBLESHOOTER_PARAMS_W {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    ChmFile : UInt16[260]
    HtmlTroubleShooter : UInt16[260]
}
struct SP_POWERMESSAGEWAKE_PARAMS_W {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    PowerMessageWake : UInt16[512]
}
struct SP_DRVINFO_DATA_V2_A {
    cbSize : UInt32 := this.Size
    DriverType : UInt32
    Reserved : IntPtr
    Description : CHAR[256]
    MfgName : CHAR[256]
    ProviderName : CHAR[256]
    DriverDate : FILETIME
    DriverVersion : Int64
}
struct SP_DRVINFO_DATA_V2_W {
    cbSize : UInt32 := this.Size
    DriverType : UInt32
    Reserved : IntPtr
    Description : UInt16[256]
    MfgName : UInt16[256]
    ProviderName : UInt16[256]
    DriverDate : FILETIME
    DriverVersion : Int64
}
struct SP_DRVINFO_DATA_V1_A {
    cbSize : UInt32 := this.Size
    DriverType : UInt32
    Reserved : IntPtr
    Description : CHAR[256]
    MfgName : CHAR[256]
    ProviderName : CHAR[256]
}
struct SP_DRVINFO_DATA_V1_W {
    cbSize : UInt32 := this.Size
    DriverType : UInt32
    Reserved : IntPtr
    Description : UInt16[256]
    MfgName : UInt16[256]
    ProviderName : UInt16[256]
}
struct SP_DRVINFO_DETAIL_DATA_A {
    cbSize : UInt32 := this.Size
    InfDate : FILETIME
    CompatIDsOffset : UInt32
    CompatIDsLength : UInt32
    Reserved : IntPtr
    SectionName : CHAR[256]
    InfFileName : CHAR[260]
    DrvDescription : CHAR[256]
    HardwareID : CHAR[1]
}
struct SP_DRVINFO_DETAIL_DATA_W {
    cbSize : UInt32 := this.Size
    InfDate : FILETIME
    CompatIDsOffset : UInt32
    CompatIDsLength : UInt32
    Reserved : IntPtr
    SectionName : UInt16[256]
    InfFileName : UInt16[260]
    DrvDescription : UInt16[256]
    HardwareID : UInt16[1]
}
struct SP_DRVINSTALL_PARAMS {
    cbSize : UInt32 := this.Size
    Rank : UInt32
    Flags : SETUP_DI_DRIVER_INSTALL_FLAGS
    PrivateData : IntPtr
    Reserved : UInt32
}
struct COINSTALLER_CONTEXT_DATA {
    PostProcessing : BOOL
    InstallResult : UInt32
    PrivateData : Struct.Ptr
}
struct SP_CLASSIMAGELIST_DATA {
    cbSize : UInt32 := this.Size
    ImageList : HIMAGELIST
    Reserved : IntPtr
}
struct SP_PROPSHEETPAGE_REQUEST {
    cbSize : UInt32 := this.Size
    PageRequested : UInt32
    DeviceInfoSet : HDEVINFO
    DeviceInfoData : SP_DEVINFO_DATA.Ptr
}
struct SP_BACKUP_QUEUE_PARAMS_V2_A {
    cbSize : UInt32 := this.Size
    FullInfPath : CHAR[260]
    FilenameOffset : Int32
    ReinstallInstance : CHAR[260]
}
struct SP_BACKUP_QUEUE_PARAMS_V2_W {
    cbSize : UInt32 := this.Size
    FullInfPath : UInt16[260]
    FilenameOffset : Int32
    ReinstallInstance : UInt16[260]
}
struct SP_BACKUP_QUEUE_PARAMS_V1_A {
    cbSize : UInt32 := this.Size
    FullInfPath : CHAR[260]
    FilenameOffset : Int32
}
struct SP_BACKUP_QUEUE_PARAMS_V1_W {
    cbSize : UInt32 := this.Size
    FullInfPath : UInt16[260]
    FilenameOffset : Int32
}
struct SP_INF_SIGNER_INFO_V1_A {
    cbSize : UInt32 := this.Size
    CatalogFile : CHAR[260]
    DigitalSigner : CHAR[260]
    DigitalSignerVersion : CHAR[260]
}
struct SP_INF_SIGNER_INFO_V1_W {
    cbSize : UInt32 := this.Size
    CatalogFile : UInt16[260]
    DigitalSigner : UInt16[260]
    DigitalSignerVersion : UInt16[260]
}
struct SP_INF_SIGNER_INFO_V2_A {
    cbSize : UInt32 := this.Size
    CatalogFile : CHAR[260]
    DigitalSigner : CHAR[260]
    DigitalSignerVersion : CHAR[260]
    SignerScore : UInt32
}
struct SP_INF_SIGNER_INFO_V2_W {
    cbSize : UInt32 := this.Size
    CatalogFile : UInt16[260]
    DigitalSigner : UInt16[260]
    DigitalSignerVersion : UInt16[260]
    SignerScore : UInt32
}
struct PSP_FILE_CALLBACK_A extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, IntPtr, IntPtr, UInt32]
}
struct PSP_FILE_CALLBACK_W extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, IntPtr, IntPtr, UInt32]
}
struct SP_SELECTDEVICE_PARAMS_A {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    Title : CHAR[60]
    Instructions : CHAR[256]
    ListLabel : CHAR[30]
    SubTitle : CHAR[256]
    Reserved : UInt8[2]
}
struct PDETECT_PROGRESS_NOTIFY extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, BOOL]
}
struct SP_TROUBLESHOOTER_PARAMS_A {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    ChmFile : CHAR[260]
    HtmlTroubleShooter : CHAR[260]
}
struct SP_POWERMESSAGEWAKE_PARAMS_A {
    ClassInstallHeader : SP_CLASSINSTALL_HEADER
    PowerMessageWake : CHAR[512]
}
struct PSP_DETSIG_CMPPROC extends FunctionPointer {
    static Types := [HDEVINFO, SP_DEVINFO_DATA.Ptr, SP_DEVINFO_DATA.Ptr, Struct.Ptr, UInt32]
}
struct SetupFileLogInfo extends Int32 {
    static SetupFileLogSourceFilename := 0
    static SetupFileLogChecksum := 1
    static SetupFileLogDiskTagfile := 2
    static SetupFileLogDiskDescription := 3
    static SetupFileLogOtherInfo := 4
    static SetupFileLogMax := 5
}
struct PNP_VETO_TYPE extends Int32 {
    static PNP_VetoTypeUnknown := 0
    static PNP_VetoLegacyDevice := 1
    static PNP_VetoPendingClose := 2
    static PNP_VetoWindowsApp := 3
    static PNP_VetoWindowsService := 4
    static PNP_VetoOutstandingOpen := 5
    static PNP_VetoDevice := 6
    static PNP_VetoDriver := 7
    static PNP_VetoIllegalDeviceRequest := 8
    static PNP_VetoInsufficientPower := 9
    static PNP_VetoNonDisableable := 10
    static PNP_VetoLegacyDriver := 11
    static PNP_VetoInsufficientRights := 12
    static PNP_VetoAlreadyRemoved := 13
}
struct CONFLICT_DETAILS_A {
    CD_ulSize : UInt32
    CD_ulMask : CM_CDMASK
    CD_dnDevInst : UInt32
    CD_rdResDes : IntPtr
    CD_ulFlags : CM_CDFLAGS
    CD_szDescription : CHAR[260]
}
struct CONFLICT_DETAILS_W {
    CD_ulSize : UInt32
    CD_ulMask : CM_CDMASK
    CD_dnDevInst : UInt32
    CD_rdResDes : IntPtr
    CD_ulFlags : CM_CDFLAGS
    CD_szDescription : UInt16[260]
}
struct MEM_RANGE {
    MR_Align : Int64
    MR_nBytes : UInt32
    MR_Min : Int64
    MR_Max : Int64
    MR_Flags : MD_FLAGS
    MR_Reserved : UInt32
}
struct MEM_DES {
    MD_Count : UInt32
    MD_Type : UInt32
    MD_Alloc_Base : Int64
    MD_Alloc_End : Int64
    MD_Flags : MD_FLAGS
    MD_Reserved : UInt32
}
struct MEM_RESOURCE {
    MEM_Header : MEM_DES
    MEM_Data : MEM_RANGE[1]
}
struct MEM_LARGE_RANGE {
    MLR_Align : Int64
    MLR_nBytes : Int64
    MLR_Min : Int64
    MLR_Max : Int64
    MLR_Flags : UInt32
    MLR_Reserved : UInt32
}
struct MEM_LARGE_DES {
    MLD_Count : UInt32
    MLD_Type : UInt32
    MLD_Alloc_Base : Int64
    MLD_Alloc_End : Int64
    MLD_Flags : UInt32
    MLD_Reserved : UInt32
}
struct MEM_LARGE_RESOURCE {
    MEM_LARGE_Header : MEM_LARGE_DES
    MEM_LARGE_Data : MEM_LARGE_RANGE[1]
}
struct IO_RANGE {
    IOR_Align : Int64
    IOR_nPorts : UInt32
    IOR_Min : Int64
    IOR_Max : Int64
    IOR_RangeFlags : IOD_DESFLAGS
    IOR_Alias : Int64
}
struct IO_DES {
    IOD_Count : UInt32
    IOD_Type : UInt32
    IOD_Alloc_Base : Int64
    IOD_Alloc_End : Int64
    IOD_DesFlags : IOD_DESFLAGS
}
struct IO_RESOURCE {
    IO_Header : IO_DES
    IO_Data : IO_RANGE[1]
}
struct DMA_RANGE {
    DR_Min : UInt32
    DR_Max : UInt32
    DR_Flags : DD_FLAGS
}
struct DMA_DES {
    DD_Count : UInt32
    DD_Type : UInt32
    DD_Flags : DD_FLAGS
    DD_Alloc_Chan : UInt32
}
struct DMA_RESOURCE {
    DMA_Header : DMA_DES
    DMA_Data : DMA_RANGE[1]
}
struct IRQ_RANGE {
    IRQR_Min : UInt32
    IRQR_Max : UInt32
    IRQR_Flags : IRQD_FLAGS
}
struct IRQ_DES_32 {
    IRQD_Count : UInt32
    IRQD_Type : UInt32
    IRQD_Flags : IRQD_FLAGS
    IRQD_Alloc_Num : UInt32
    IRQD_Affinity : UInt32
}
struct IRQ_DES_64 {
    IRQD_Count : UInt32
    IRQD_Type : UInt32
    IRQD_Flags : IRQD_FLAGS
    IRQD_Alloc_Num : UInt32
    IRQD_Affinity : Int64
}
struct IRQ_RESOURCE_32 {
    IRQ_Header : IRQ_DES_32
    IRQ_Data : IRQ_RANGE[1]
}
struct IRQ_RESOURCE_64 {
    IRQ_Header : IRQ_DES_64
    IRQ_Data : IRQ_RANGE[1]
}
struct DEVPRIVATE_RANGE {
    PR_Data1 : UInt32
    PR_Data2 : UInt32
    PR_Data3 : UInt32
}
struct DEVPRIVATE_DES {
    PD_Count : UInt32
    PD_Type : UInt32
    PD_Data1 : UInt32
    PD_Data2 : UInt32
    PD_Data3 : UInt32
    PD_Flags : UInt32
}
struct DEVPRIVATE_RESOURCE {
    PRV_Header : DEVPRIVATE_DES
    PRV_Data : DEVPRIVATE_RANGE[1]
}
struct CS_DES {
    CSD_SignatureLength : UInt32
    CSD_LegacyDataOffset : UInt32
    CSD_LegacyDataSize : UInt32
    CSD_Flags : UInt32
    CSD_ClassGuid : GUID
    CSD_Signature : UInt8[1]
}
struct CS_RESOURCE {
    CS_Header : CS_DES
}
struct PCCARD_DES {
    PCD_Count : UInt32
    PCD_Type : UInt32
    PCD_Flags : PCD_FLAGS
    PCD_ConfigIndex : UInt8
    PCD_Reserved : UInt8[3]
    PCD_MemoryCardBase1 : UInt32
    PCD_MemoryCardBase2 : UInt32
    PCD_MemoryCardBase : UInt32[2]
    PCD_MemoryFlags : UInt16[2]
    PCD_IoFlags : UInt8[2]
}
struct PCCARD_RESOURCE {
    PcCard_Header : PCCARD_DES
}
struct MFCARD_DES {
    PMF_Count : UInt32
    PMF_Type : UInt32
    PMF_Flags : PMF_FLAGS
    PMF_ConfigOptions : UInt8
    PMF_IoResourceIndex : UInt8
    PMF_Reserved : UInt8[2]
    PMF_ConfigRegisterBase : UInt32
}
struct MFCARD_RESOURCE {
    MfCard_Header : MFCARD_DES
}
struct BUSNUMBER_RANGE {
    BUSR_Min : UInt32
    BUSR_Max : UInt32
    BUSR_nBusNumbers : UInt32
    BUSR_Flags : UInt32
}
struct BUSNUMBER_DES {
    BUSD_Count : UInt32
    BUSD_Type : UInt32
    BUSD_Flags : UInt32
    BUSD_Alloc_Base : UInt32
    BUSD_Alloc_End : UInt32
}
struct BUSNUMBER_RESOURCE {
    BusNumber_Header : BUSNUMBER_DES
    BusNumber_Data : BUSNUMBER_RANGE[1]
}
struct CONNECTION_DES {
    COND_Type : UInt32
    COND_Flags : UInt32
    COND_Class : UInt8
    COND_ClassType : UInt8
    COND_Reserved1 : UInt8
    COND_Reserved2 : UInt8
    COND_Id : Int64
}
struct CONNECTION_RESOURCE {
    Connection_Header : CONNECTION_DES
}
struct HWPROFILEINFO_A {
    HWPI_ulHWProfile : UInt32
    HWPI_szFriendlyName : CHAR[80]
    HWPI_dwFlags : UInt32
}
struct HWPROFILEINFO_W {
    HWPI_ulHWProfile : UInt32
    HWPI_szFriendlyName : UInt16[80]
    HWPI_dwFlags : UInt32
}
struct CM_NOTIFY_FILTER_TYPE extends Int32 {
    static CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE := 0
    static CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE := 1
    static CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE := 2
    static CM_NOTIFY_FILTER_TYPE_MAX := 3
}
struct CM_NOTIFY_FILTER {
    cbSize : UInt32 := this.Size
    Flags : UInt32
    FilterType : CM_NOTIFY_FILTER_TYPE
    Reserved : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            DeviceInterface : this._DeviceInterface_e__Struct
            DeviceHandle : this._DeviceHandle_e__Struct
            DeviceInstance : this._DeviceInstance_e__Struct
        }
        struct _DeviceInterface_e__Struct {
            ClassGuid : GUID
        }
        struct _DeviceHandle_e__Struct {
            hTarget : HANDLE
        }
        struct _DeviceInstance_e__Struct {
            InstanceId : UInt16[200]
        }
    }
}
struct CM_NOTIFY_ACTION extends Int32 {
    static CM_NOTIFY_ACTION_DEVICEINTERFACEARRIVAL := 0
    static CM_NOTIFY_ACTION_DEVICEINTERFACEREMOVAL := 1
    static CM_NOTIFY_ACTION_DEVICEQUERYREMOVE := 2
    static CM_NOTIFY_ACTION_DEVICEQUERYREMOVEFAILED := 3
    static CM_NOTIFY_ACTION_DEVICEREMOVEPENDING := 4
    static CM_NOTIFY_ACTION_DEVICEREMOVECOMPLETE := 5
    static CM_NOTIFY_ACTION_DEVICECUSTOMEVENT := 6
    static CM_NOTIFY_ACTION_DEVICEINSTANCEENUMERATED := 7
    static CM_NOTIFY_ACTION_DEVICEINSTANCESTARTED := 8
    static CM_NOTIFY_ACTION_DEVICEINSTANCEREMOVED := 9
    static CM_NOTIFY_ACTION_MAX := 10
}
struct CM_NOTIFY_EVENT_DATA {
    FilterType : CM_NOTIFY_FILTER_TYPE
    Reserved : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            DeviceInterface : this._DeviceInterface_e__Struct
            DeviceHandle : this._DeviceHandle_e__Struct
            DeviceInstance : this._DeviceInstance_e__Struct
        }
        struct _DeviceInterface_e__Struct {
            ClassGuid : GUID
            SymbolicLink : UInt16[1]
        }
        struct _DeviceHandle_e__Struct {
            EventGuid : GUID
            NameOffset : Int32
            DataSize : UInt32
            Data : UInt8[1]
        }
        struct _DeviceInstance_e__Struct {
            InstanceId : UInt16[1]
        }
    }
}
struct PCM_NOTIFY_CALLBACK extends FunctionPointer {
    static Types := [HCMNOTIFICATION, Struct.Ptr, CM_NOTIFY_ACTION, CM_NOTIFY_EVENT_DATA.Ptr, UInt32, UInt32]
}
