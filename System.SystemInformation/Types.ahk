#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, CHAR, PSTR, PWSTR}
#Import "..\System.SystemServices\Types.ahk" {SHARED_COMPUTE_UNIT_RELATIONSHIP}

struct VER_FLAGS extends UInt32 {
    static VER_MINORVERSION := 1
    static VER_MAJORVERSION := 2
    static VER_BUILDNUMBER := 4
    static VER_PLATFORMID := 8
    static VER_SERVICEPACKMINOR := 16
    static VER_SERVICEPACKMAJOR := 32
    static VER_SUITENAME := 64
    static VER_PRODUCT_TYPE := 128
}
struct IMAGE_FILE_MACHINE extends UInt16 {
    static IMAGE_FILE_MACHINE_AXP64 := 644
    static IMAGE_FILE_MACHINE_I386 := 332
    static IMAGE_FILE_MACHINE_IA64 := 512
    static IMAGE_FILE_MACHINE_AMD64 := 34404
    static IMAGE_FILE_MACHINE_UNKNOWN := 0
    static IMAGE_FILE_MACHINE_TARGET_HOST := 1
    static IMAGE_FILE_MACHINE_R3000 := 354
    static IMAGE_FILE_MACHINE_R4000 := 358
    static IMAGE_FILE_MACHINE_R10000 := 360
    static IMAGE_FILE_MACHINE_WCEMIPSV2 := 361
    static IMAGE_FILE_MACHINE_ALPHA := 388
    static IMAGE_FILE_MACHINE_SH3 := 418
    static IMAGE_FILE_MACHINE_SH3DSP := 419
    static IMAGE_FILE_MACHINE_SH3E := 420
    static IMAGE_FILE_MACHINE_SH4 := 422
    static IMAGE_FILE_MACHINE_SH5 := 424
    static IMAGE_FILE_MACHINE_ARM := 448
    static IMAGE_FILE_MACHINE_THUMB := 450
    static IMAGE_FILE_MACHINE_ARMNT := 452
    static IMAGE_FILE_MACHINE_AM33 := 467
    static IMAGE_FILE_MACHINE_POWERPC := 496
    static IMAGE_FILE_MACHINE_POWERPCFP := 497
    static IMAGE_FILE_MACHINE_MIPS16 := 614
    static IMAGE_FILE_MACHINE_ALPHA64 := 644
    static IMAGE_FILE_MACHINE_MIPSFPU := 870
    static IMAGE_FILE_MACHINE_MIPSFPU16 := 1126
    static IMAGE_FILE_MACHINE_TRICORE := 1312
    static IMAGE_FILE_MACHINE_CEF := 3311
    static IMAGE_FILE_MACHINE_EBC := 3772
    static IMAGE_FILE_MACHINE_M32R := 36929
    static IMAGE_FILE_MACHINE_ARM64 := 43620
    static IMAGE_FILE_MACHINE_CEE := 49390
}
struct PROCESSOR_ARCHITECTURE extends UInt16 {
    static PROCESSOR_ARCHITECTURE_INTEL := 0
    static PROCESSOR_ARCHITECTURE_MIPS := 1
    static PROCESSOR_ARCHITECTURE_ALPHA := 2
    static PROCESSOR_ARCHITECTURE_PPC := 3
    static PROCESSOR_ARCHITECTURE_SHX := 4
    static PROCESSOR_ARCHITECTURE_ARM := 5
    static PROCESSOR_ARCHITECTURE_IA64 := 6
    static PROCESSOR_ARCHITECTURE_ALPHA64 := 7
    static PROCESSOR_ARCHITECTURE_MSIL := 8
    static PROCESSOR_ARCHITECTURE_AMD64 := 9
    static PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 := 10
    static PROCESSOR_ARCHITECTURE_NEUTRAL := 11
    static PROCESSOR_ARCHITECTURE_ARM64 := 12
    static PROCESSOR_ARCHITECTURE_ARM32_ON_WIN64 := 13
    static PROCESSOR_ARCHITECTURE_IA32_ON_ARM64 := 14
    static PROCESSOR_ARCHITECTURE_UNKNOWN := 65535
}
struct FIRMWARE_TABLE_PROVIDER extends UInt32 {
    static ACPI := 1094930505
    static FIRM := 1179210317
    static RSMB := 1381190978
}
struct USER_CET_ENVIRONMENT extends UInt32 {
    static USER_CET_ENVIRONMENT_WIN32_PROCESS := 0
    static USER_CET_ENVIRONMENT_SGX2_ENCLAVE := 2
    static USER_CET_ENVIRONMENT_VBS_ENCLAVE := 16
    static USER_CET_ENVIRONMENT_VBS_BASIC_ENCLAVE := 17
}
struct OS_PRODUCT_TYPE extends UInt32 {
    static PRODUCT_UNDEFINED := 0
    static PRODUCT_ULTIMATE := 1
    static PRODUCT_HOME_BASIC := 2
    static PRODUCT_HOME_PREMIUM := 3
    static PRODUCT_ENTERPRISE := 4
    static PRODUCT_HOME_BASIC_N := 5
    static PRODUCT_BUSINESS := 6
    static PRODUCT_STANDARD_SERVER := 7
    static PRODUCT_DATACENTER_SERVER := 8
    static PRODUCT_SMALLBUSINESS_SERVER := 9
    static PRODUCT_ENTERPRISE_SERVER := 10
    static PRODUCT_STARTER := 11
    static PRODUCT_DATACENTER_SERVER_CORE := 12
    static PRODUCT_STANDARD_SERVER_CORE := 13
    static PRODUCT_ENTERPRISE_SERVER_CORE := 14
    static PRODUCT_ENTERPRISE_SERVER_IA64 := 15
    static PRODUCT_BUSINESS_N := 16
    static PRODUCT_WEB_SERVER := 17
    static PRODUCT_CLUSTER_SERVER := 18
    static PRODUCT_HOME_SERVER := 19
    static PRODUCT_STORAGE_EXPRESS_SERVER := 20
    static PRODUCT_STORAGE_STANDARD_SERVER := 21
    static PRODUCT_STORAGE_WORKGROUP_SERVER := 22
    static PRODUCT_STORAGE_ENTERPRISE_SERVER := 23
    static PRODUCT_SERVER_FOR_SMALLBUSINESS := 24
    static PRODUCT_SMALLBUSINESS_SERVER_PREMIUM := 25
    static PRODUCT_HOME_PREMIUM_N := 26
    static PRODUCT_ENTERPRISE_N := 27
    static PRODUCT_ULTIMATE_N := 28
    static PRODUCT_WEB_SERVER_CORE := 29
    static PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT := 30
    static PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY := 31
    static PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING := 32
    static PRODUCT_SERVER_FOUNDATION := 33
    static PRODUCT_HOME_PREMIUM_SERVER := 34
    static PRODUCT_SERVER_FOR_SMALLBUSINESS_V := 35
    static PRODUCT_STANDARD_SERVER_V := 36
    static PRODUCT_DATACENTER_SERVER_V := 37
    static PRODUCT_ENTERPRISE_SERVER_V := 38
    static PRODUCT_DATACENTER_SERVER_CORE_V := 39
    static PRODUCT_STANDARD_SERVER_CORE_V := 40
    static PRODUCT_ENTERPRISE_SERVER_CORE_V := 41
    static PRODUCT_HYPERV := 42
    static PRODUCT_STORAGE_EXPRESS_SERVER_CORE := 43
    static PRODUCT_STORAGE_STANDARD_SERVER_CORE := 44
    static PRODUCT_STORAGE_WORKGROUP_SERVER_CORE := 45
    static PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE := 46
    static PRODUCT_STARTER_N := 47
    static PRODUCT_PROFESSIONAL := 48
    static PRODUCT_PROFESSIONAL_N := 49
    static PRODUCT_SB_SOLUTION_SERVER := 50
    static PRODUCT_SERVER_FOR_SB_SOLUTIONS := 51
    static PRODUCT_STANDARD_SERVER_SOLUTIONS := 52
    static PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE := 53
    static PRODUCT_SB_SOLUTION_SERVER_EM := 54
    static PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM := 55
    static PRODUCT_SOLUTION_EMBEDDEDSERVER := 56
    static PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE := 57
    static PRODUCT_PROFESSIONAL_EMBEDDED := 58
    static PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT := 59
    static PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL := 60
    static PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC := 61
    static PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC := 62
    static PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE := 63
    static PRODUCT_CLUSTER_SERVER_V := 64
    static PRODUCT_EMBEDDED := 65
    static PRODUCT_STARTER_E := 66
    static PRODUCT_HOME_BASIC_E := 67
    static PRODUCT_HOME_PREMIUM_E := 68
    static PRODUCT_PROFESSIONAL_E := 69
    static PRODUCT_ENTERPRISE_E := 70
    static PRODUCT_ULTIMATE_E := 71
    static PRODUCT_ENTERPRISE_EVALUATION := 72
    static PRODUCT_MULTIPOINT_STANDARD_SERVER := 76
    static PRODUCT_MULTIPOINT_PREMIUM_SERVER := 77
    static PRODUCT_STANDARD_EVALUATION_SERVER := 79
    static PRODUCT_DATACENTER_EVALUATION_SERVER := 80
    static PRODUCT_ENTERPRISE_N_EVALUATION := 84
    static PRODUCT_EMBEDDED_AUTOMOTIVE := 85
    static PRODUCT_EMBEDDED_INDUSTRY_A := 86
    static PRODUCT_THINPC := 87
    static PRODUCT_EMBEDDED_A := 88
    static PRODUCT_EMBEDDED_INDUSTRY := 89
    static PRODUCT_EMBEDDED_E := 90
    static PRODUCT_EMBEDDED_INDUSTRY_E := 91
    static PRODUCT_EMBEDDED_INDUSTRY_A_E := 92
    static PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER := 95
    static PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER := 96
    static PRODUCT_CORE_ARM := 97
    static PRODUCT_CORE_N := 98
    static PRODUCT_CORE_COUNTRYSPECIFIC := 99
    static PRODUCT_CORE_SINGLELANGUAGE := 100
    static PRODUCT_CORE := 101
    static PRODUCT_PROFESSIONAL_WMC := 103
    static PRODUCT_EMBEDDED_INDUSTRY_EVAL := 105
    static PRODUCT_EMBEDDED_INDUSTRY_E_EVAL := 106
    static PRODUCT_EMBEDDED_EVAL := 107
    static PRODUCT_EMBEDDED_E_EVAL := 108
    static PRODUCT_NANO_SERVER := 109
    static PRODUCT_CLOUD_STORAGE_SERVER := 110
    static PRODUCT_CORE_CONNECTED := 111
    static PRODUCT_PROFESSIONAL_STUDENT := 112
    static PRODUCT_CORE_CONNECTED_N := 113
    static PRODUCT_PROFESSIONAL_STUDENT_N := 114
    static PRODUCT_CORE_CONNECTED_SINGLELANGUAGE := 115
    static PRODUCT_CORE_CONNECTED_COUNTRYSPECIFIC := 116
    static PRODUCT_CONNECTED_CAR := 117
    static PRODUCT_INDUSTRY_HANDHELD := 118
    static PRODUCT_PPI_PRO := 119
    static PRODUCT_ARM64_SERVER := 120
    static PRODUCT_EDUCATION := 121
    static PRODUCT_EDUCATION_N := 122
    static PRODUCT_IOTUAP := 123
    static PRODUCT_CLOUD_HOST_INFRASTRUCTURE_SERVER := 124
    static PRODUCT_ENTERPRISE_S := 125
    static PRODUCT_ENTERPRISE_S_N := 126
    static PRODUCT_PROFESSIONAL_S := 127
    static PRODUCT_PROFESSIONAL_S_N := 128
    static PRODUCT_ENTERPRISE_S_EVALUATION := 129
    static PRODUCT_ENTERPRISE_S_N_EVALUATION := 130
    static PRODUCT_HOLOGRAPHIC := 135
    static PRODUCT_HOLOGRAPHIC_BUSINESS := 136
    static PRODUCT_PRO_SINGLE_LANGUAGE := 138
    static PRODUCT_PRO_CHINA := 139
    static PRODUCT_ENTERPRISE_SUBSCRIPTION := 140
    static PRODUCT_ENTERPRISE_SUBSCRIPTION_N := 141
    static PRODUCT_DATACENTER_NANO_SERVER := 143
    static PRODUCT_STANDARD_NANO_SERVER := 144
    static PRODUCT_DATACENTER_A_SERVER_CORE := 145
    static PRODUCT_STANDARD_A_SERVER_CORE := 146
    static PRODUCT_DATACENTER_WS_SERVER_CORE := 147
    static PRODUCT_STANDARD_WS_SERVER_CORE := 148
    static PRODUCT_UTILITY_VM := 149
    static PRODUCT_DATACENTER_EVALUATION_SERVER_CORE := 159
    static PRODUCT_STANDARD_EVALUATION_SERVER_CORE := 160
    static PRODUCT_PRO_WORKSTATION := 161
    static PRODUCT_PRO_WORKSTATION_N := 162
    static PRODUCT_PRO_FOR_EDUCATION := 164
    static PRODUCT_PRO_FOR_EDUCATION_N := 165
    static PRODUCT_AZURE_SERVER_CORE := 168
    static PRODUCT_AZURE_NANO_SERVER := 169
    static PRODUCT_ENTERPRISEG := 171
    static PRODUCT_ENTERPRISEGN := 172
    static PRODUCT_SERVERRDSH := 175
    static PRODUCT_CLOUD := 178
    static PRODUCT_CLOUDN := 179
    static PRODUCT_HUBOS := 180
    static PRODUCT_ONECOREUPDATEOS := 182
    static PRODUCT_CLOUDE := 183
    static PRODUCT_IOTOS := 185
    static PRODUCT_CLOUDEN := 186
    static PRODUCT_IOTEDGEOS := 187
    static PRODUCT_IOTENTERPRISE := 188
    static PRODUCT_LITE := 189
    static PRODUCT_IOTENTERPRISES := 191
    static PRODUCT_XBOX_SYSTEMOS := 192
    static PRODUCT_XBOX_GAMEOS := 194
    static PRODUCT_XBOX_ERAOS := 195
    static PRODUCT_XBOX_DURANGOHOSTOS := 196
    static PRODUCT_XBOX_SCARLETTHOSTOS := 197
    static PRODUCT_XBOX_KEYSTONE := 198
    static PRODUCT_AZURE_SERVER_CLOUDHOST := 199
    static PRODUCT_AZURE_SERVER_CLOUDMOS := 200
    static PRODUCT_CLOUDEDITIONN := 202
    static PRODUCT_CLOUDEDITION := 203
    static PRODUCT_VALIDATION := 204
    static PRODUCT_IOTENTERPRISESK := 205
    static PRODUCT_IOTENTERPRISEK := 206
    static PRODUCT_IOTENTERPRISESEVAL := 207
    static PRODUCT_AZURE_SERVER_AGENTBRIDGE := 208
    static PRODUCT_AZURE_SERVER_NANOHOST := 209
    static PRODUCT_WNC := 210
    static PRODUCT_AZURESTACKHCI_SERVER_CORE := 406
    static PRODUCT_DATACENTER_SERVER_AZURE_EDITION := 407
    static PRODUCT_DATACENTER_SERVER_CORE_AZURE_EDITION := 408
    static PRODUCT_DATACENTER_WS_SERVER_CORE_AZURE_EDITION := 409
    static PRODUCT_UNLICENSED := 2882382797
}
struct DEVICEFAMILYINFOENUM extends UInt32 {
    static DEVICEFAMILYINFOENUM_UAP := 0
    static DEVICEFAMILYINFOENUM_WINDOWS_8X := 1
    static DEVICEFAMILYINFOENUM_WINDOWS_PHONE_8X := 2
    static DEVICEFAMILYINFOENUM_DESKTOP := 3
    static DEVICEFAMILYINFOENUM_MOBILE := 4
    static DEVICEFAMILYINFOENUM_XBOX := 5
    static DEVICEFAMILYINFOENUM_TEAM := 6
    static DEVICEFAMILYINFOENUM_IOT := 7
    static DEVICEFAMILYINFOENUM_IOT_HEADLESS := 8
    static DEVICEFAMILYINFOENUM_SERVER := 9
    static DEVICEFAMILYINFOENUM_HOLOGRAPHIC := 10
    static DEVICEFAMILYINFOENUM_XBOXSRA := 11
    static DEVICEFAMILYINFOENUM_XBOXERA := 12
    static DEVICEFAMILYINFOENUM_SERVER_NANO := 13
    static DEVICEFAMILYINFOENUM_8828080 := 14
    static DEVICEFAMILYINFOENUM_7067329 := 15
    static DEVICEFAMILYINFOENUM_WINDOWS_CORE := 16
    static DEVICEFAMILYINFOENUM_WINDOWS_CORE_HEADLESS := 17
    static DEVICEFAMILYINFOENUM_MAX := 17
}
struct DEVICEFAMILYDEVICEFORM extends UInt32 {
    static DEVICEFAMILYDEVICEFORM_UNKNOWN := 0
    static DEVICEFAMILYDEVICEFORM_PHONE := 1
    static DEVICEFAMILYDEVICEFORM_TABLET := 2
    static DEVICEFAMILYDEVICEFORM_DESKTOP := 3
    static DEVICEFAMILYDEVICEFORM_NOTEBOOK := 4
    static DEVICEFAMILYDEVICEFORM_CONVERTIBLE := 5
    static DEVICEFAMILYDEVICEFORM_DETACHABLE := 6
    static DEVICEFAMILYDEVICEFORM_ALLINONE := 7
    static DEVICEFAMILYDEVICEFORM_STICKPC := 8
    static DEVICEFAMILYDEVICEFORM_PUCK := 9
    static DEVICEFAMILYDEVICEFORM_LARGESCREEN := 10
    static DEVICEFAMILYDEVICEFORM_HMD := 11
    static DEVICEFAMILYDEVICEFORM_INDUSTRY_HANDHELD := 12
    static DEVICEFAMILYDEVICEFORM_INDUSTRY_TABLET := 13
    static DEVICEFAMILYDEVICEFORM_BANKING := 14
    static DEVICEFAMILYDEVICEFORM_BUILDING_AUTOMATION := 15
    static DEVICEFAMILYDEVICEFORM_DIGITAL_SIGNAGE := 16
    static DEVICEFAMILYDEVICEFORM_GAMING := 17
    static DEVICEFAMILYDEVICEFORM_HOME_AUTOMATION := 18
    static DEVICEFAMILYDEVICEFORM_INDUSTRIAL_AUTOMATION := 19
    static DEVICEFAMILYDEVICEFORM_KIOSK := 20
    static DEVICEFAMILYDEVICEFORM_MAKER_BOARD := 21
    static DEVICEFAMILYDEVICEFORM_MEDICAL := 22
    static DEVICEFAMILYDEVICEFORM_NETWORKING := 23
    static DEVICEFAMILYDEVICEFORM_POINT_OF_SERVICE := 24
    static DEVICEFAMILYDEVICEFORM_PRINTING := 25
    static DEVICEFAMILYDEVICEFORM_THIN_CLIENT := 26
    static DEVICEFAMILYDEVICEFORM_TOY := 27
    static DEVICEFAMILYDEVICEFORM_VENDING := 28
    static DEVICEFAMILYDEVICEFORM_INDUSTRY_OTHER := 29
    static DEVICEFAMILYDEVICEFORM_XBOX_ONE := 30
    static DEVICEFAMILYDEVICEFORM_XBOX_ONE_S := 31
    static DEVICEFAMILYDEVICEFORM_XBOX_ONE_X := 32
    static DEVICEFAMILYDEVICEFORM_XBOX_ONE_X_DEVKIT := 33
    static DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X := 34
    static DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X_DEVKIT := 35
    static DEVICEFAMILYDEVICEFORM_XBOX_SERIES_S := 36
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_01 := 37
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_02 := 38
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_03 := 39
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_04 := 40
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_05 := 41
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_06 := 42
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_07 := 43
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_08 := 44
    static DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_09 := 45
    static DEVICEFAMILYDEVICEFORM_GAMING_HANDHELD := 46
    static DEVICEFAMILYDEVICEFORM_GAMING_CONSOLE := 47
    static DEVICEFAMILYDEVICEFORM_MAX := 47
}
struct GROUP_AFFINITY {
    Mask : IntPtr
    Group : UInt16
    Reserved : UInt16[3]
}
struct GROUP_AFFINITY32 {
    Mask : UInt32
    Group : UInt16
    Reserved : UInt16[3]
}
struct GROUP_AFFINITY64 {
    Mask : Int64
    Group : UInt16
    Reserved : UInt16[3]
}
struct SYSTEM_INFO {
    Anonymous : this._Anonymous_e__Union
    dwPageSize : UInt32
    lpMinimumApplicationAddress : Struct.Ptr
    lpMaximumApplicationAddress : Struct.Ptr
    dwActiveProcessorMask : IntPtr
    dwNumberOfProcessors : UInt32
    dwProcessorType : UInt32
    dwAllocationGranularity : UInt32
    wProcessorLevel : UInt16
    wProcessorRevision : UInt16
    struct _Anonymous_e__Union {
        union {
            dwOemId : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            wProcessorArchitecture : PROCESSOR_ARCHITECTURE
            wReserved : UInt16
        }
    }
}
struct MEMORYSTATUSEX {
    dwLength : UInt32
    dwMemoryLoad : UInt32
    ullTotalPhys : Int64
    ullAvailPhys : Int64
    ullTotalPageFile : Int64
    ullAvailPageFile : Int64
    ullTotalVirtual : Int64
    ullAvailVirtual : Int64
    ullAvailExtendedVirtual : Int64
}
struct COMPUTER_NAME_FORMAT extends Int32 {
    static ComputerNameNetBIOS := 0
    static ComputerNameDnsHostname := 1
    static ComputerNameDnsDomain := 2
    static ComputerNameDnsFullyQualified := 3
    static ComputerNamePhysicalNetBIOS := 4
    static ComputerNamePhysicalDnsHostname := 5
    static ComputerNamePhysicalDnsDomain := 6
    static ComputerNamePhysicalDnsFullyQualified := 7
    static ComputerNameMax := 8
}
struct DEVELOPER_DRIVE_ENABLEMENT_STATE extends Int32 {
    static DeveloperDriveEnablementStateError := 0
    static DeveloperDriveEnabled := 1
    static DeveloperDriveDisabledBySystemPolicy := 2
    static DeveloperDriveDisabledByGroupPolicy := 3
}
struct FIRMWARE_TYPE extends Int32 {
    static FirmwareTypeUnknown := 0
    static FirmwareTypeBios := 1
    static FirmwareTypeUefi := 2
    static FirmwareTypeMax := 3
}
struct LOGICAL_PROCESSOR_RELATIONSHIP extends Int32 {
    static RelationProcessorCore := 0
    static RelationNumaNode := 1
    static RelationCache := 2
    static RelationProcessorPackage := 3
    static RelationGroup := 4
    static RelationProcessorDie := 5
    static RelationNumaNodeEx := 6
    static RelationProcessorModule := 7
    static RelationProcessorSharedComputeUnit := 8
    static RelationAll := 65535
}
struct PROCESSOR_CACHE_TYPE extends Int32 {
    static CacheUnified := 0
    static CacheInstruction := 1
    static CacheData := 2
    static CacheTrace := 3
    static CacheUnknown := 4
}
struct CACHE_DESCRIPTOR {
    Level : UInt8
    Associativity : UInt8
    LineSize : UInt16
    Size : UInt32
    Type : PROCESSOR_CACHE_TYPE
}
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION {
    ProcessorMask : IntPtr
    Relationship : LOGICAL_PROCESSOR_RELATIONSHIP
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ProcessorCore : this._ProcessorCore_e__Struct
            NumaNode : this._NumaNode_e__Struct
            Cache : CACHE_DESCRIPTOR
            Reserved : Int64[2]
        }
        struct _ProcessorCore_e__Struct {
            Flags : UInt8
        }
        struct _NumaNode_e__Struct {
            NodeNumber : UInt32
        }
    }
}
struct PROCESSOR_RELATIONSHIP {
    Flags : UInt8
    EfficiencyClass : UInt8
    Reserved : UInt8[20]
    GroupCount : UInt16
    GroupMask : GROUP_AFFINITY[1]
}
struct NUMA_NODE_RELATIONSHIP {
    NodeNumber : UInt32
    Reserved : UInt8[18]
    GroupCount : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            GroupMask : GROUP_AFFINITY
            GroupMasks : GROUP_AFFINITY[1]
        }
    }
}
struct CACHE_RELATIONSHIP {
    Level : UInt8
    Associativity : UInt8
    LineSize : UInt16
    CacheSize : UInt32
    Type : PROCESSOR_CACHE_TYPE
    Reserved : UInt8[18]
    GroupCount : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            GroupMask : GROUP_AFFINITY
            GroupMasks : GROUP_AFFINITY[1]
        }
    }
}
struct PROCESSOR_GROUP_INFO {
    MaximumProcessorCount : UInt8
    ActiveProcessorCount : UInt8
    Reserved : UInt8[38]
    ActiveProcessorMask : IntPtr
}
struct GROUP_RELATIONSHIP {
    MaximumGroupCount : UInt16
    ActiveGroupCount : UInt16
    Reserved : UInt8[20]
    GroupInfo : PROCESSOR_GROUP_INFO[1]
}
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX {
    Relationship : LOGICAL_PROCESSOR_RELATIONSHIP
    Size : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Processor : PROCESSOR_RELATIONSHIP
            NumaNode : NUMA_NODE_RELATIONSHIP
            Cache : CACHE_RELATIONSHIP
            Group : GROUP_RELATIONSHIP
            SharedComputeUnit : SHARED_COMPUTE_UNIT_RELATIONSHIP
        }
    }
}
struct CPU_SET_INFORMATION_TYPE extends Int32 {
    static CpuSetInformation := 0
}
struct SYSTEM_CPU_SET_INFORMATION {
    Size : UInt32
    Type : CPU_SET_INFORMATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            CpuSet : this._CpuSet_e__Struct
        }
        struct _CpuSet_e__Struct {
            Id : UInt32
            Group : UInt16
            LogicalProcessorIndex : UInt8
            CoreIndex : UInt8
            LastLevelCacheIndex : UInt8
            NumaNodeIndex : UInt8
            EfficiencyClass : UInt8
            Anonymous1 : this._Anonymous1_e__Union
            Anonymous2 : this._Anonymous2_e__Union
            AllocationTag : Int64
            struct _Anonymous1_e__Union {
                union {
                    AllFlags : UInt8
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    _bitfield : UInt8
                }
            }
            struct _Anonymous2_e__Union {
                union {
                    Reserved : UInt32
                    SchedulingClass : UInt8
                }
            }
        }
    }
}
struct SYSTEM_POOL_ZEROING_INFORMATION {
    PoolZeroingSupportPresent : BOOLEAN
}
struct SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION {
    CycleTime : Int64
}
struct SYSTEM_SUPPORTED_PROCESSOR_ARCHITECTURES_INFORMATION {
    _bitfield : UInt32
}
struct OSVERSIONINFOA {
    dwOSVersionInfoSize : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    dwPlatformId : UInt32
    szCSDVersion : CHAR[128]
}
struct OSVERSIONINFOW {
    dwOSVersionInfoSize : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    dwPlatformId : UInt32
    szCSDVersion : UInt16[128]
}
struct OSVERSIONINFOEXA {
    dwOSVersionInfoSize : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    dwPlatformId : UInt32
    szCSDVersion : CHAR[128]
    wServicePackMajor : UInt16
    wServicePackMinor : UInt16
    wSuiteMask : UInt16
    wProductType : UInt8
    wReserved : UInt8
}
struct OSVERSIONINFOEXW {
    dwOSVersionInfoSize : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    dwPlatformId : UInt32
    szCSDVersion : UInt16[128]
    wServicePackMajor : UInt16
    wServicePackMinor : UInt16
    wSuiteMask : UInt16
    wProductType : UInt8
    wReserved : UInt8
}
struct OS_DEPLOYEMENT_STATE_VALUES extends Int32 {
    static OS_DEPLOYMENT_STANDARD := 1
    static OS_DEPLOYMENT_COMPACT := 2
}
struct RTL_SYSTEM_GLOBAL_DATA_ID extends Int32 {
    static GlobalDataIdUnknown := 0
    static GlobalDataIdRngSeedVersion := 1
    static GlobalDataIdInterruptTime := 2
    static GlobalDataIdTimeZoneBias := 3
    static GlobalDataIdImageNumberLow := 4
    static GlobalDataIdImageNumberHigh := 5
    static GlobalDataIdTimeZoneId := 6
    static GlobalDataIdNtMajorVersion := 7
    static GlobalDataIdNtMinorVersion := 8
    static GlobalDataIdSystemExpirationDate := 9
    static GlobalDataIdKdDebuggerEnabled := 10
    static GlobalDataIdCyclesPerYield := 11
    static GlobalDataIdSafeBootMode := 12
    static GlobalDataIdLastSystemRITEventTickCount := 13
    static GlobalDataIdConsoleSharedDataFlags := 14
    static GlobalDataIdNtSystemRootDrive := 15
    static GlobalDataIdQpcBypassEnabled := 16
    static GlobalDataIdQpcData := 17
    static GlobalDataIdQpcBias := 18
}
struct MEMORYSTATUS {
    dwLength : UInt32
    dwMemoryLoad : UInt32
    dwTotalPhys : IntPtr
    dwAvailPhys : IntPtr
    dwTotalPageFile : IntPtr
    dwAvailPageFile : IntPtr
    dwTotalVirtual : IntPtr
    dwAvailVirtual : IntPtr
}
struct DEP_SYSTEM_POLICY_TYPE extends Int32 {
    static DEPPolicyAlwaysOff := 0
    static DEPPolicyAlwaysOn := 1
    static DEPPolicyOptIn := 2
    static DEPPolicyOptOut := 3
    static DEPTotalPolicyCount := 4
}
struct PGET_SYSTEM_WOW64_DIRECTORY_A extends FunctionPointer {
    static Types := [PSTR, UInt32, UInt32]
}
struct PGET_SYSTEM_WOW64_DIRECTORY_W extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt32]
}
