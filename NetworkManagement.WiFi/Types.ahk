#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HANDLE, HRESULT, PWSTR}
#Import "..\NetworkManagement.Ndis\Types.ahk" {NDIS_OBJECT_HEADER}
#Import "..\Security.ExtensibleAuthenticationProtocol\Types.ahk" {EAP_ATTRIBUTES, EAP_METHOD_TYPE}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.RemoteDesktop\Types.ahk" {WTSSESSION_NOTIFICATION}

struct WLAN_SET_EAPHOST_FLAGS extends UInt32 {
    static WLAN_SET_EAPHOST_DATA_ALL_USERS := 1
}
struct WLAN_CONNECTION_NOTIFICATION_FLAGS extends UInt32 {
    static WLAN_CONNECTION_NOTIFICATION_ADHOC_NETWORK_FORMED := 1
    static WLAN_CONNECTION_NOTIFICATION_CONSOLE_USER_PROFILE := 4
}
struct WLAN_NOTIFICATION_SOURCES extends UInt32 {
    static WLAN_NOTIFICATION_SOURCE_NONE := 0
    static WLAN_NOTIFICATION_SOURCE_ALL := 65535
    static WLAN_NOTIFICATION_SOURCE_ACM := 8
    static WLAN_NOTIFICATION_SOURCE_MSM := 16
    static WLAN_NOTIFICATION_SOURCE_SECURITY := 32
    static WLAN_NOTIFICATION_SOURCE_IHV := 64
    static WLAN_NOTIFICATION_SOURCE_HNWK := 128
    static WLAN_NOTIFICATION_SOURCE_ONEX := 4
    static WLAN_NOTIFICATION_SOURCE_DEVICE_SERVICE := 2048
}
struct DEVPROP_PCIROOTBUS_SECONDARYINTERFACE extends UInt32 {
    static DevProp_PciRootBus_SecondaryInterface_PciConventional := 0
    static DevProp_PciRootBus_SecondaryInterface_PciXMode1 := 1
    static DevProp_PciRootBus_SecondaryInterface_PciXMode2 := 2
    static DevProp_PciRootBus_SecondaryInterface_PciExpress := 3
}
struct DEVPROP_PCIROOTBUS_CURRENTSPEEDANDMODE extends UInt32 {
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_33Mhz := 0
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_Conventional_66Mhz := 1
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_66Mhz := 2
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_100Mhz := 3
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_133Mhz := 4
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_66Mhz := 5
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_100Mhz := 6
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_Mode1_ECC_133Mhz := 7
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_66Mhz := 8
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_100Mhz := 9
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_266_Mode2_133Mhz := 10
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_66Mhz := 11
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_100Mhz := 12
    static DevProp_PciRootBus_CurrentSpeedAndMode_Pci_X_533_Mode2_133Mhz := 13
}
struct DEVPROP_PCIROOTBUS_SUPPORTEDSPEEDSANDMODES extends UInt32 {
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_33Mhz := 1
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_Conventional_66Mhz := 2
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_66Mhz := 4
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_133Mhz := 8
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_266Mhz := 16
    static DevProp_PciRootBus_SupportedSpeedsAndModes_Pci_X_533Mhz := 32
}
struct DEVPROP_PCIROOTBUS_BUSWIDTH extends UInt32 {
    static DevProp_PciRootBus_BusWidth_32Bits := 0
    static DevProp_PciRootBus_BusWidth_64Bits := 1
}
struct DEVPROP_PCIDEVICE_DEVICEBRIDGETYPE extends UInt32 {
    static DevProp_PciDevice_DeviceType_PciConventional := 0
    static DevProp_PciDevice_DeviceType_PciX := 1
    static DevProp_PciDevice_DeviceType_PciExpressEndpoint := 2
    static DevProp_PciDevice_DeviceType_PciExpressLegacyEndpoint := 3
    static DevProp_PciDevice_DeviceType_PciExpressRootComplexIntegratedEndpoint := 4
    static DevProp_PciDevice_DeviceType_PciExpressTreatedAsPci := 5
    static DevProp_PciDevice_BridgeType_PciConventional := 6
    static DevProp_PciDevice_BridgeType_PciX := 7
    static DevProp_PciDevice_BridgeType_PciExpressRootPort := 8
    static DevProp_PciDevice_BridgeType_PciExpressUpstreamSwitchPort := 9
    static DevProp_PciDevice_BridgeType_PciExpressDownstreamSwitchPort := 10
    static DevProp_PciDevice_BridgeType_PciExpressToPciXBridge := 11
    static DevProp_PciDevice_BridgeType_PciXToExpressBridge := 12
    static DevProp_PciDevice_BridgeType_PciExpressTreatedAsPci := 13
    static DevProp_PciDevice_BridgeType_PciExpressEventCollector := 14
}
struct DEVPROP_PCIDEVICE_CURRENTSPEEDANDMODE extends UInt32 {
    static DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_33MHz := 0
    static DevProp_PciDevice_CurrentSpeedAndMode_Pci_Conventional_66MHz := 1
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode_Conventional_Pci := 0
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_66Mhz := 1
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_100Mhz := 2
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_133MHZ := 3
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_66Mhz := 5
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_100Mhz := 6
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode1_ECC_133Mhz := 7
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_66MHz := 9
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_100MHz := 10
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_266_133MHz := 11
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_66MHz := 13
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_100MHz := 14
    static DevProp_PciDevice_CurrentSpeedAndMode_PciX_Mode2_533_133MHz := 15
}
struct DEVPROP_PCIEXPRESSDEVICE_PAYLOADORREQUESTSIZE extends UInt32 {
    static DevProp_PciExpressDevice_PayloadOrRequestSize_128Bytes := 0
    static DevProp_PciExpressDevice_PayloadOrRequestSize_256Bytes := 1
    static DevProp_PciExpressDevice_PayloadOrRequestSize_512Bytes := 2
    static DevProp_PciExpressDevice_PayloadOrRequestSize_1024Bytes := 3
    static DevProp_PciExpressDevice_PayloadOrRequestSize_2048Bytes := 4
    static DevProp_PciExpressDevice_PayloadOrRequestSize_4096Bytes := 5
}
struct DEVPROP_PCIEXPRESSDEVICE_LINKSPEED extends UInt32 {
    static DevProp_PciExpressDevice_LinkSpeed_TwoAndHalf_Gbps := 1
    static DevProp_PciExpressDevice_LinkSpeed_Five_Gbps := 2
}
struct DEVPROP_PCIEXPRESSDEVICE_LINKWIDTH extends UInt32 {
    static DevProp_PciExpressDevice_LinkWidth_By_1 := 1
    static DevProp_PciExpressDevice_LinkWidth_By_2 := 2
    static DevProp_PciExpressDevice_LinkWidth_By_4 := 4
    static DevProp_PciExpressDevice_LinkWidth_By_8 := 8
    static DevProp_PciExpressDevice_LinkWidth_By_12 := 12
    static DevProp_PciExpressDevice_LinkWidth_By_16 := 16
    static DevProp_PciExpressDevice_LinkWidth_By_32 := 32
}
struct DEVPROP_PCIEXPRESSDEVICE_SPEC_VERSION extends UInt32 {
    static DevProp_PciExpressDevice_Spec_Version_10 := 1
    static DevProp_PciExpressDevice_Spec_Version_11 := 2
}
struct DEVPROP_PCIDEVICE_INTERRUPTTYPE extends UInt32 {
    static DevProp_PciDevice_InterruptType_LineBased := 1
    static DevProp_PciDevice_InterruptType_Msi := 2
    static DevProp_PciDevice_InterruptType_MsiX := 4
}
struct DEVPROP_PCIDEVICE_SRIOVSUPPORT extends UInt32 {
    static DevProp_PciDevice_SriovSupport_Ok := 0
    static DevProp_PciDevice_SriovSupport_MissingAcs := 1
    static DevProp_PciDevice_SriovSupport_MissingPfDriver := 2
    static DevProp_PciDevice_SriovSupport_NoBusResource := 3
    static DevProp_PciDevice_SriovSupport_DidntGetVfBarSpace := 4
    static DevProp_PciDevice_SriovSupport_NoSriovCap := 5
}
struct DEVPROP_PCIDEVICE_ACSSUPPORT extends UInt32 {
    static DevProp_PciDevice_AcsSupport_Present := 0
    static DevProp_PciDevice_AcsSupport_NotNeeded := 1
    static DevProp_PciDevice_AcsSupport_Missing := 2
}
struct DEVPROP_PCIDEVICE_ACSCOMPATIBLEUPHIERARCHY extends UInt32 {
    static DevProp_PciDevice_AcsCompatibleUpHierarchy_NotSupported := 0
    static DevProp_PciDevice_AcsCompatibleUpHierarchy_SingleFunctionSupported := 1
    static DevProp_PciDevice_AcsCompatibleUpHierarchy_NoP2PSupported := 2
    static DevProp_PciDevice_AcsCompatibleUpHierarchy_Supported := 3
    static DevProp_PciDevice_AcsCompatibleUpHierarchy_Enhanced := 4
}
struct DOT11_BSS_TYPE extends Int32 {
    static dot11_BSS_type_infrastructure := 1
    static dot11_BSS_type_independent := 2
    static dot11_BSS_type_any := 3
}
struct DOT11_SSID {
    uSSIDLength : UInt32
    ucSSID : UInt8[32]
}
struct DOT11_AUTH_ALGORITHM extends Int32 {
    static DOT11_AUTH_ALGO_80211_OPEN := 1
    static DOT11_AUTH_ALGO_80211_SHARED_KEY := 2
    static DOT11_AUTH_ALGO_WPA := 3
    static DOT11_AUTH_ALGO_WPA_PSK := 4
    static DOT11_AUTH_ALGO_WPA_NONE := 5
    static DOT11_AUTH_ALGO_RSNA := 6
    static DOT11_AUTH_ALGO_RSNA_PSK := 7
    static DOT11_AUTH_ALGO_WPA3 := 8
    static DOT11_AUTH_ALGO_WPA3_ENT_192 := 8
    static DOT11_AUTH_ALGO_WPA3_SAE := 9
    static DOT11_AUTH_ALGO_OWE := 10
    static DOT11_AUTH_ALGO_WPA3_ENT := 11
    static DOT11_AUTH_ALGO_IHV_START := -2147483648
    static DOT11_AUTH_ALGO_IHV_END := -1
}
struct DOT11_CIPHER_ALGORITHM extends Int32 {
    static DOT11_CIPHER_ALGO_NONE := 0
    static DOT11_CIPHER_ALGO_WEP40 := 1
    static DOT11_CIPHER_ALGO_TKIP := 2
    static DOT11_CIPHER_ALGO_CCMP := 4
    static DOT11_CIPHER_ALGO_WEP104 := 5
    static DOT11_CIPHER_ALGO_BIP := 6
    static DOT11_CIPHER_ALGO_GCMP := 8
    static DOT11_CIPHER_ALGO_GCMP_256 := 9
    static DOT11_CIPHER_ALGO_CCMP_256 := 10
    static DOT11_CIPHER_ALGO_BIP_GMAC_128 := 11
    static DOT11_CIPHER_ALGO_BIP_GMAC_256 := 12
    static DOT11_CIPHER_ALGO_BIP_CMAC_256 := 13
    static DOT11_CIPHER_ALGO_WPA_USE_GROUP := 256
    static DOT11_CIPHER_ALGO_RSN_USE_GROUP := 256
    static DOT11_CIPHER_ALGO_WEP := 257
    static DOT11_CIPHER_ALGO_IHV_START := -2147483648
    static DOT11_CIPHER_ALGO_IHV_END := -1
}
struct DOT11_AUTH_CIPHER_PAIR {
    AuthAlgoId : DOT11_AUTH_ALGORITHM
    CipherAlgoId : DOT11_CIPHER_ALGORITHM
}
struct DOT11_OI {
    OILength : UInt16
    OI : UInt8[5]
}
struct DOT11_ACCESSNETWORKOPTIONS {
    AccessNetworkType : UInt8
    Internet : UInt8
    ASRA : UInt8
    ESR : UInt8
    UESA : UInt8
}
struct DOT11_VENUEINFO {
    VenueGroup : UInt8
    VenueType : UInt8
}
struct DOT11_BSSID_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    BSSIDs : UInt8[6]
}
struct DOT11_PHY_TYPE extends Int32 {
    static dot11_phy_type_unknown := 0
    static dot11_phy_type_any := 0
    static dot11_phy_type_fhss := 1
    static dot11_phy_type_dsss := 2
    static dot11_phy_type_irbaseband := 3
    static dot11_phy_type_ofdm := 4
    static dot11_phy_type_hrdsss := 5
    static dot11_phy_type_erp := 6
    static dot11_phy_type_ht := 7
    static dot11_phy_type_vht := 8
    static dot11_phy_type_dmg := 9
    static dot11_phy_type_he := 10
    static dot11_phy_type_eht := 11
    static dot11_phy_type_IHV_start := -2147483648
    static dot11_phy_type_IHV_end := -1
}
struct RSNA_AKM_SUITE extends Int32 {
    static rsna_akm_none := 11276032
    static rsna_akm_1x := 28053248
    static rsna_akm_psk := 44830464
    static rsna_akm_ft_1x_sha256 := 61607680
    static rsna_akm_ft_psk_sha256 := 78384896
    static rsna_akm_1x_sha256 := 95162112
    static rsna_akm_psk_sha256 := 111939328
    static rsna_akm_tdls_sha256 := 128716544
    static rsna_akm_sae_pmk256 := 145493760
    static rsna_akm_ft_sae_pmk256 := 162270976
    static rsna_akm_peerkey_sha256 := 179048192
    static rsna_akm_1x_suite_b_sha256 := 195825408
    static rsna_akm_1x_suite_b_sha384 := 212602624
    static rsna_akm_ft_1x_sha384_cmp_256 := 229379840
    static rsna_akm_fils_1x_sha256 := 246157056
    static rsna_akm_fils_1x_sha384 := 262934272
    static rsna_akm_ft_fils_1x_sha256 := 279711488
    static rsna_akm_ft_fils_sha384 := 296488704
    static rsna_akm_owe := 313265920
    static rsna_akm_ft_psk_sha384 := 330043136
    static rsna_akm_psk_sha384 := 346820352
    static rsna_akm_ft_1x_sha384 := 380374784
    static rsna_akm_1x_sha384 := 397152000
    static rsna_akm_sae_pmk384 := 413929216
    static rsna_akm_ft_sae_pmk384 := 430706432
    static rsna_akm_max := 430706432
}
struct WPA_AKM_SUITE extends Int32 {
    static wpa_akm_none := 15880192
    static wpa_akm_1x := 32657408
    static wpa_akm_psk := 49434624
    static wpa_akm_max := 49434624
}
struct RSNA_CIPHER_SUITE extends Int32 {
    static rsna_cipher_group := 11276032
    static rsna_cipher_wep40 := 28053248
    static rsna_cipher_tkip := 44830464
    static rsna_cipher_reserved := 61607680
    static rsna_cipher_ccmp_128 := 78384896
    static rsna_cipher_wep104 := 95162112
    static rsna_cipher_bip_cmac_128 := 111939328
    static rsna_cipher_no_group_traffic := 128716544
    static rsna_cipher_gcmp_128 := 145493760
    static rsna_cipher_gcmp_256 := 162270976
    static rsna_cipher_ccmp_256 := 179048192
    static rsna_cipher_bip_gmac_128 := 195825408
    static rsna_cipher_bip_gmac_256 := 212602624
    static rsna_cipher_bip_cmac_256 := 229379840
    static rsna_cipher_max := 229379840
}
struct WPA_CIPHER_SUITE extends Int32 {
    static wpa_cipher_none := 15880192
    static wpa_cipher_wep40 := 32657408
    static wpa_cipher_tkip := 49434624
    static wpa_cipher_ccmp_128 := 82989056
    static wpa_cipher_wep104 := 99766272
    static wpa_cipher_bip_cmac_128 := 116543488
    static wpa_cipher_max := 116543488
}
struct RSNA_AKM_CIPHER_PAIR {
    akm : RSNA_AKM_SUITE
    cipher : RSNA_CIPHER_SUITE
}
struct DOT11_RATE_SET {
    uRateSetLength : UInt32
    ucRateSet : UInt8[126]
}
struct DOT11_AKM_CIPHER_PAIR {
    akm : RSNA_AKM_SUITE
    cipher : RSNA_CIPHER_SUITE
}
struct DOT11_WFD_SESSION_INFO {
    uSessionInfoLength : UInt16
    ucSessionInfo : UInt8[144]
}
struct DOT11_OFFLOAD_CAPABILITY {
    uReserved : UInt32
    uFlags : UInt32
    uSupportedWEPAlgorithms : UInt32
    uNumOfReplayWindows : UInt32
    uMaxWEPKeyMappingLength : UInt32
    uSupportedAuthAlgorithms : UInt32
    uMaxAuthKeyMappingLength : UInt32
}
struct DOT11_CURRENT_OFFLOAD_CAPABILITY {
    uReserved : UInt32
    uFlags : UInt32
}
struct DOT11_OFFLOAD_TYPE extends Int32 {
    static dot11_offload_type_wep := 1
    static dot11_offload_type_auth := 2
}
struct DOT11_IV48_COUNTER {
    uIV32Counter : UInt32
    usIV16Counter : UInt16
}
struct DOT11_WEP_OFFLOAD {
    uReserved : UInt32
    hOffloadContext : HANDLE
    hOffload : HANDLE
    dot11OffloadType : DOT11_OFFLOAD_TYPE
    dwAlgorithm : UInt32
    bRowIsOutbound : BOOLEAN
    bUseDefault : BOOLEAN
    uFlags : UInt32
    ucMacAddress : UInt8[6]
    uNumOfRWsOnPeer : UInt32
    uNumOfRWsOnMe : UInt32
    dot11IV48Counters : DOT11_IV48_COUNTER[16]
    usDot11RWBitMaps : UInt16[16]
    usKeyLength : UInt16
    ucKey : UInt8[1]
}
struct DOT11_WEP_UPLOAD {
    uReserved : UInt32
    dot11OffloadType : DOT11_OFFLOAD_TYPE
    hOffload : HANDLE
    uNumOfRWsUsed : UInt32
    dot11IV48Counters : DOT11_IV48_COUNTER[16]
    usDot11RWBitMaps : UInt16[16]
}
struct DOT11_KEY_DIRECTION extends Int32 {
    static dot11_key_direction_both := 1
    static dot11_key_direction_inbound := 2
    static dot11_key_direction_outbound := 3
}
struct DOT11_DEFAULT_WEP_OFFLOAD {
    uReserved : UInt32
    hOffloadContext : HANDLE
    hOffload : HANDLE
    dwIndex : UInt32
    dot11OffloadType : DOT11_OFFLOAD_TYPE
    dwAlgorithm : UInt32
    uFlags : UInt32
    dot11KeyDirection : DOT11_KEY_DIRECTION
    ucMacAddress : UInt8[6]
    uNumOfRWsOnMe : UInt32
    dot11IV48Counters : DOT11_IV48_COUNTER[16]
    usDot11RWBitMaps : UInt16[16]
    usKeyLength : UInt16
    ucKey : UInt8[1]
}
struct DOT11_DEFAULT_WEP_UPLOAD {
    uReserved : UInt32
    dot11OffloadType : DOT11_OFFLOAD_TYPE
    hOffload : HANDLE
    uNumOfRWsUsed : UInt32
    dot11IV48Counters : DOT11_IV48_COUNTER[16]
    usDot11RWBitMaps : UInt16[16]
}
struct DOT11_OPERATION_MODE_CAPABILITY {
    uReserved : UInt32
    uMajorVersion : UInt32
    uMinorVersion : UInt32
    uNumOfTXBuffers : UInt32
    uNumOfRXBuffers : UInt32
    uOpModeCapability : UInt32
}
struct DOT11_CURRENT_OPERATION_MODE {
    uReserved : UInt32
    uCurrentOpMode : UInt32
}
struct DOT11_SCAN_TYPE extends Int32 {
    static dot11_scan_type_active := 1
    static dot11_scan_type_passive := 2
    static dot11_scan_type_auto := 3
    static dot11_scan_type_forced := -2147483648
}
struct DOT11_SCAN_REQUEST {
    dot11BSSType : DOT11_BSS_TYPE
    dot11BSSID : UInt8[6]
    dot11SSID : DOT11_SSID
    dot11ScanType : DOT11_SCAN_TYPE
    bRestrictedScan : BOOLEAN
    bUseRequestIE : BOOLEAN
    uRequestIDsOffset : UInt32
    uNumOfRequestIDs : UInt32
    uPhyTypesOffset : UInt32
    uNumOfPhyTypes : UInt32
    uIEsOffset : UInt32
    uIEsLength : UInt32
    ucBuffer : UInt8[1]
}
struct CH_DESCRIPTION_TYPE extends Int32 {
    static ch_description_type_logical := 1
    static ch_description_type_center_frequency := 2
    static ch_description_type_phy_specific := 3
}
struct DOT11_PHY_TYPE_INFO {
    dot11PhyType : DOT11_PHY_TYPE
    bUseParameters : BOOLEAN
    uProbeDelay : UInt32
    uMinChannelTime : UInt32
    uMaxChannelTime : UInt32
    ChDescriptionType : CH_DESCRIPTION_TYPE
    uChannelListSize : UInt32
    ucChannelListBuffer : UInt8[1]
}
struct DOT11_SCAN_REQUEST_V2 {
    dot11BSSType : DOT11_BSS_TYPE
    dot11BSSID : UInt8[6]
    dot11ScanType : DOT11_SCAN_TYPE
    bRestrictedScan : BOOLEAN
    udot11SSIDsOffset : UInt32
    uNumOfdot11SSIDs : UInt32
    bUseRequestIE : BOOLEAN
    uRequestIDsOffset : UInt32
    uNumOfRequestIDs : UInt32
    uPhyTypeInfosOffset : UInt32
    uNumOfPhyTypeInfos : UInt32
    uIEsOffset : UInt32
    uIEsLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_PHY_TYPE_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11PhyType : DOT11_PHY_TYPE[1]
}
struct DOT11_BSS_DESCRIPTION {
    uReserved : UInt32
    dot11BSSID : UInt8[6]
    dot11BSSType : DOT11_BSS_TYPE
    usBeaconPeriod : UInt16
    ullTimestamp : Int64
    usCapabilityInformation : UInt16
    uBufferLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_JOIN_REQUEST {
    uJoinFailureTimeout : UInt32
    OperationalRateSet : DOT11_RATE_SET
    uChCenterFrequency : UInt32
    dot11BSSDescription : DOT11_BSS_DESCRIPTION
}
struct DOT11_START_REQUEST {
    uStartFailureTimeout : UInt32
    OperationalRateSet : DOT11_RATE_SET
    uChCenterFrequency : UInt32
    dot11BSSDescription : DOT11_BSS_DESCRIPTION
}
struct DOT11_UPDATE_IE_OP extends Int32 {
    static dot11_update_ie_op_create_replace := 1
    static dot11_update_ie_op_delete := 2
}
struct DOT11_UPDATE_IE {
    dot11UpdateIEOp : DOT11_UPDATE_IE_OP
    uBufferLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_RESET_TYPE extends Int32 {
    static dot11_reset_type_phy := 1
    static dot11_reset_type_mac := 2
    static dot11_reset_type_phy_and_mac := 3
}
struct DOT11_RESET_REQUEST {
    dot11ResetType : DOT11_RESET_TYPE
    dot11MacAddress : UInt8[6]
    bSetDefaultMIB : BOOLEAN
}
struct DOT11_OPTIONAL_CAPABILITY {
    uReserved : UInt32
    bDot11PCF : BOOLEAN
    bDot11PCFMPDUTransferToPC : BOOLEAN
    bStrictlyOrderedServiceClass : BOOLEAN
}
struct DOT11_CURRENT_OPTIONAL_CAPABILITY {
    uReserved : UInt32
    bDot11CFPollable : BOOLEAN
    bDot11PCF : BOOLEAN
    bDot11PCFMPDUTransferToPC : BOOLEAN
    bStrictlyOrderedServiceClass : BOOLEAN
}
struct DOT11_POWER_MODE extends Int32 {
    static dot11_power_mode_unknown := 0
    static dot11_power_mode_active := 1
    static dot11_power_mode_powersave := 2
}
struct DOT11_POWER_MGMT_MODE {
    dot11PowerMode : DOT11_POWER_MODE
    uPowerSaveLevel : UInt32
    usListenInterval : UInt16
    usAID : UInt16
    bReceiveDTIMs : BOOLEAN
}
struct DOT11_COUNTERS_ENTRY {
    uTransmittedFragmentCount : UInt32
    uMulticastTransmittedFrameCount : UInt32
    uFailedCount : UInt32
    uRetryCount : UInt32
    uMultipleRetryCount : UInt32
    uFrameDuplicateCount : UInt32
    uRTSSuccessCount : UInt32
    uRTSFailureCount : UInt32
    uACKFailureCount : UInt32
    uReceivedFragmentCount : UInt32
    uMulticastReceivedFrameCount : UInt32
    uFCSErrorCount : UInt32
    uTransmittedFrameCount : UInt32
}
struct DOT11_SUPPORTED_PHY_TYPES {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11PHYType : DOT11_PHY_TYPE[1]
}
struct DOT11_TEMP_TYPE extends Int32 {
    static dot11_temp_type_unknown := 0
    static dot11_temp_type_1 := 1
    static dot11_temp_type_2 := 2
}
struct DOT11_DIVERSITY_SUPPORT extends Int32 {
    static dot11_diversity_support_unknown := 0
    static dot11_diversity_support_fixedlist := 1
    static dot11_diversity_support_notsupported := 2
    static dot11_diversity_support_dynamic := 3
}
struct DOT11_SUPPORTED_POWER_LEVELS {
    uNumOfSupportedPowerLevels : UInt32
    uTxPowerLevelValues : UInt32[8]
}
struct DOT11_REG_DOMAIN_VALUE {
    uRegDomainsSupportIndex : UInt32
    uRegDomainsSupportValue : UInt32
}
struct DOT11_REG_DOMAINS_SUPPORT_VALUE {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11RegDomainValue : DOT11_REG_DOMAIN_VALUE[1]
}
struct DOT11_SUPPORTED_ANTENNA {
    uAntennaListIndex : UInt32
    bSupportedAntenna : BOOLEAN
}
struct DOT11_SUPPORTED_ANTENNA_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11SupportedAntenna : DOT11_SUPPORTED_ANTENNA[1]
}
struct DOT11_DIVERSITY_SELECTION_RX {
    uAntennaListIndex : UInt32
    bDiversitySelectionRX : BOOLEAN
}
struct DOT11_DIVERSITY_SELECTION_RX_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11DiversitySelectionRx : DOT11_DIVERSITY_SELECTION_RX[1]
}
struct DOT11_SUPPORTED_DATA_RATES_VALUE {
    ucSupportedTxDataRatesValue : UInt8[8]
    ucSupportedRxDataRatesValue : UInt8[8]
}
struct DOT11_SUPPORTED_DATA_RATES_VALUE_V2 {
    ucSupportedTxDataRatesValue : UInt8[255]
    ucSupportedRxDataRatesValue : UInt8[255]
}
struct DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY {
    uMultiDomainCapabilityIndex : UInt32
    uFirstChannelNumber : UInt32
    uNumberOfChannels : UInt32
    lMaximumTransmitPowerLevel : Int32
}
struct DOT11_MD_CAPABILITY_ENTRY_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11MDCapabilityEntry : DOT11_MULTI_DOMAIN_CAPABILITY_ENTRY[1]
}
struct DOT11_HOP_ALGO_ADOPTED extends Int32 {
    static dot11_hop_algo_current := 0
    static dot11_hop_algo_hop_index := 1
    static dot11_hop_algo_hcc := 2
}
struct DOT11_HOPPING_PATTERN_ENTRY {
    uHoppingPatternIndex : UInt32
    uRandomTableFieldNumber : UInt32
}
struct DOT11_HOPPING_PATTERN_ENTRY_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11HoppingPatternEntry : DOT11_HOPPING_PATTERN_ENTRY[1]
}
struct DOT11_WPA_TSC {
    uReserved : UInt32
    dot11OffloadType : DOT11_OFFLOAD_TYPE
    hOffload : HANDLE
    dot11IV48Counter : DOT11_IV48_COUNTER
}
struct DOT11_RSSI_RANGE {
    dot11PhyType : DOT11_PHY_TYPE
    uRSSIMin : UInt32
    uRSSIMax : UInt32
}
struct DOT11_NIC_SPECIFIC_EXTENSION {
    uBufferLength : UInt32
    uTotalBufferLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_AP_JOIN_REQUEST {
    uJoinFailureTimeout : UInt32
    OperationalRateSet : DOT11_RATE_SET
    uChCenterFrequency : UInt32
    dot11BSSDescription : DOT11_BSS_DESCRIPTION
}
struct DOT11_RECV_SENSITIVITY {
    ucDataRate : UInt8
    lRSSIMin : Int32
    lRSSIMax : Int32
}
struct DOT11_RECV_SENSITIVITY_LIST {
    Anonymous : this._Anonymous_e__Union
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11RecvSensitivity : DOT11_RECV_SENSITIVITY[1]
    struct _Anonymous_e__Union {
        union {
            dot11PhyType : DOT11_PHY_TYPE
            uPhyId : UInt32
        }
    }
}
struct DOT11_AC_PARAM extends Int32 {
    static dot11_AC_param_BE := 0
    static dot11_AC_param_BK := 1
    static dot11_AC_param_VI := 2
    static dot11_AC_param_VO := 3
    static dot11_AC_param_max := 4
}
struct DOT11_WME_AC_PARAMETERS {
    ucAccessCategoryIndex : UInt8
    ucAIFSN : UInt8
    ucECWmin : UInt8
    ucECWmax : UInt8
    usTXOPLimit : UInt16
}
struct DOT11_WME_AC_PARAMETERS_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11WMEACParameters : DOT11_WME_AC_PARAMETERS[1]
}
struct DOT11_WME_UPDATE_IE {
    uParamElemMinBeaconIntervals : UInt32
    uWMEInfoElemOffset : UInt32
    uWMEInfoElemLength : UInt32
    uWMEParamElemOffset : UInt32
    uWMEParamElemLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_QOS_TX_DURATION {
    uNominalMSDUSize : UInt32
    uMinPHYRate : UInt32
    uDuration : UInt32
}
struct DOT11_QOS_TX_MEDIUM_TIME {
    dot11PeerAddress : UInt8[6]
    ucQoSPriority : UInt8
    uMediumTimeAdmited : UInt32
}
struct DOT11_SUPPORTED_OFDM_FREQUENCY {
    uCenterFrequency : UInt32
}
struct DOT11_SUPPORTED_OFDM_FREQUENCY_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11SupportedOFDMFrequency : DOT11_SUPPORTED_OFDM_FREQUENCY[1]
}
struct DOT11_SUPPORTED_DSSS_CHANNEL {
    uChannel : UInt32
}
struct DOT11_SUPPORTED_DSSS_CHANNEL_LIST {
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11SupportedDSSSChannel : DOT11_SUPPORTED_DSSS_CHANNEL[1]
}
struct DOT11_BYTE_ARRAY {
    Header : NDIS_OBJECT_HEADER
    uNumOfBytes : UInt32
    uTotalNumOfBytes : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO {
    union {
        uChCenterFrequency : UInt32
        FHSS : this._FHSS_e__Struct
    }
    struct _FHSS_e__Struct {
        uHopPattern : UInt32
        uHopSet : UInt32
        uDwellTime : UInt32
    }
}
struct DOT11_BSS_ENTRY {
    uPhyId : UInt32
    PhySpecificInfo : DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO
    dot11BSSID : UInt8[6]
    dot11BSSType : DOT11_BSS_TYPE
    lRSSI : Int32
    uLinkQuality : UInt32
    bInRegDomain : BOOLEAN
    usBeaconPeriod : UInt16
    ullTimestamp : Int64
    ullHostTimestamp : Int64
    usCapabilityInformation : UInt16
    uBufferLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_SSID_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    SSIDs : DOT11_SSID[1]
}
struct DOT11_MAC_ADDRESS_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    MacAddrs : UInt8[6]
}
struct DOT11_PMKID_ENTRY {
    BSSID : UInt8[6]
    PMKID : UInt8[16]
    uFlags : UInt32
}
struct DOT11_PMKID_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    PMKIDs : DOT11_PMKID_ENTRY[1]
}
struct DOT11_PHY_FRAME_STATISTICS {
    ullTransmittedFrameCount : Int64
    ullMulticastTransmittedFrameCount : Int64
    ullFailedCount : Int64
    ullRetryCount : Int64
    ullMultipleRetryCount : Int64
    ullMaxTXLifetimeExceededCount : Int64
    ullTransmittedFragmentCount : Int64
    ullRTSSuccessCount : Int64
    ullRTSFailureCount : Int64
    ullACKFailureCount : Int64
    ullReceivedFrameCount : Int64
    ullMulticastReceivedFrameCount : Int64
    ullPromiscuousReceivedFrameCount : Int64
    ullMaxRXLifetimeExceededCount : Int64
    ullFrameDuplicateCount : Int64
    ullReceivedFragmentCount : Int64
    ullPromiscuousReceivedFragmentCount : Int64
    ullFCSErrorCount : Int64
}
struct DOT11_MAC_FRAME_STATISTICS {
    ullTransmittedFrameCount : Int64
    ullReceivedFrameCount : Int64
    ullTransmittedFailureFrameCount : Int64
    ullReceivedFailureFrameCount : Int64
    ullWEPExcludedCount : Int64
    ullTKIPLocalMICFailures : Int64
    ullTKIPReplays : Int64
    ullTKIPICVErrorCount : Int64
    ullCCMPReplays : Int64
    ullCCMPDecryptErrors : Int64
    ullWEPUndecryptableCount : Int64
    ullWEPICVErrorCount : Int64
    ullDecryptSuccessCount : Int64
    ullDecryptFailureCount : Int64
}
struct DOT11_STATISTICS {
    Header : NDIS_OBJECT_HEADER
    ullFourWayHandshakeFailures : Int64
    ullTKIPCounterMeasuresInvoked : Int64
    ullReserved : Int64
    MacUcastCounters : DOT11_MAC_FRAME_STATISTICS
    MacMcastCounters : DOT11_MAC_FRAME_STATISTICS
    PhyCounters : DOT11_PHY_FRAME_STATISTICS[1]
}
struct DOT11_PRIVACY_EXEMPTION {
    usEtherType : UInt16
    usExemptionActionType : UInt16
    usExemptionPacketType : UInt16
}
struct DOT11_PRIVACY_EXEMPTION_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    PrivacyExemptionEntries : DOT11_PRIVACY_EXEMPTION[1]
}
struct DOT11_AUTH_ALGORITHM_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    AlgorithmIds : DOT11_AUTH_ALGORITHM[1]
}
struct DOT11_AUTH_CIPHER_PAIR_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    AuthCipherPairs : DOT11_AUTH_CIPHER_PAIR[1]
}
struct DOT11_CIPHER_ALGORITHM_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    AlgorithmIds : DOT11_CIPHER_ALGORITHM[1]
}
struct DOT11_CIPHER_DEFAULT_KEY_VALUE {
    Header : NDIS_OBJECT_HEADER
    uKeyIndex : UInt32
    AlgorithmId : DOT11_CIPHER_ALGORITHM
    MacAddr : UInt8[6]
    bDelete : BOOLEAN
    bStatic : BOOLEAN
    usKeyLength : UInt16
    ucKey : UInt8[1]
}
struct DOT11_KEY_ALGO_TKIP_MIC {
    ucIV48Counter : UInt8[6]
    ulTKIPKeyLength : UInt32
    ulMICKeyLength : UInt32
    ucTKIPMICKeys : UInt8[1]
}
struct DOT11_KEY_ALGO_CCMP {
    ucIV48Counter : UInt8[6]
    ulCCMPKeyLength : UInt32
    ucCCMPKey : UInt8[1]
}
struct DOT11_KEY_ALGO_GCMP {
    ucIV48Counter : UInt8[6]
    ulGCMPKeyLength : UInt32
    ucGCMPKey : UInt8[1]
}
struct DOT11_KEY_ALGO_GCMP_256 {
    ucIV48Counter : UInt8[6]
    ulGCMP256KeyLength : UInt32
    ucGCMP256Key : UInt8[1]
}
struct DOT11_KEY_ALGO_BIP {
    ucIPN : UInt8[6]
    ulBIPKeyLength : UInt32
    ucBIPKey : UInt8[1]
}
struct DOT11_KEY_ALGO_BIP_GMAC_256 {
    ucIPN : UInt8[6]
    ulBIPGmac256KeyLength : UInt32
    ucBIPGmac256Key : UInt8[1]
}
struct DOT11_DIRECTION extends Int32 {
    static DOT11_DIR_INBOUND := 1
    static DOT11_DIR_OUTBOUND := 2
    static DOT11_DIR_BOTH := 3
}
struct DOT11_CIPHER_KEY_MAPPING_KEY_VALUE {
    PeerMacAddr : UInt8[6]
    AlgorithmId : DOT11_CIPHER_ALGORITHM
    Direction : DOT11_DIRECTION
    bDelete : BOOLEAN
    bStatic : BOOLEAN
    usKeyLength : UInt16
    ucKey : UInt8[1]
}
struct DOT11_ASSOCIATION_STATE extends Int32 {
    static dot11_assoc_state_zero := 0
    static dot11_assoc_state_unauth_unassoc := 1
    static dot11_assoc_state_auth_unassoc := 2
    static dot11_assoc_state_auth_assoc := 3
}
struct DOT11_ASSOCIATION_INFO_EX {
    PeerMacAddress : UInt8[6]
    BSSID : UInt8[6]
    usCapabilityInformation : UInt16
    usListenInterval : UInt16
    ucPeerSupportedRates : UInt8[255]
    usAssociationID : UInt16
    dot11AssociationState : DOT11_ASSOCIATION_STATE
    dot11PowerMode : DOT11_POWER_MODE
    liAssociationUpTime : Int64
    ullNumOfTxPacketSuccesses : Int64
    ullNumOfTxPacketFailures : Int64
    ullNumOfRxPacketSuccesses : Int64
    ullNumOfRxPacketFailures : Int64
}
struct DOT11_ASSOCIATION_INFO_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11AssocInfo : DOT11_ASSOCIATION_INFO_EX[1]
}
struct DOT11_PHY_ID_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    dot11PhyId : UInt32[1]
}
struct DOT11_EXTSTA_CAPABILITY {
    Header : NDIS_OBJECT_HEADER
    uScanSSIDListSize : UInt32
    uDesiredBSSIDListSize : UInt32
    uDesiredSSIDListSize : UInt32
    uExcludedMacAddressListSize : UInt32
    uPrivacyExemptionListSize : UInt32
    uKeyMappingTableSize : UInt32
    uDefaultKeyTableSize : UInt32
    uWEPKeyValueMaxLength : UInt32
    uPMKIDCacheSize : UInt32
    uMaxNumPerSTADefaultKeyTables : UInt32
}
struct DOT11_DATA_RATE_MAPPING_ENTRY {
    ucDataRateIndex : UInt8
    ucDataRateFlag : UInt8
    usDataRateValue : UInt16
}
struct DOT11_DATA_RATE_MAPPING_TABLE {
    Header : NDIS_OBJECT_HEADER
    uDataRateMappingLength : UInt32
    DataRateMappingEntries : DOT11_DATA_RATE_MAPPING_ENTRY[126]
}
struct DOT11_COUNTRY_OR_REGION_STRING_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    CountryOrRegionStrings : UInt8[3]
}
struct DOT11_PORT_STATE_NOTIFICATION {
    Header : NDIS_OBJECT_HEADER
    PeerMac : UInt8[6]
    bOpen : BOOLEAN
}
struct DOT11_IBSS_PARAMS {
    Header : NDIS_OBJECT_HEADER
    bJoinOnly : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_QOS_PARAMS {
    Header : NDIS_OBJECT_HEADER
    ucEnabledQoSProtocolFlags : UInt8
}
struct DOT11_ASSOCIATION_PARAMS {
    Header : NDIS_OBJECT_HEADER
    BSSID : UInt8[6]
    uAssocRequestIEsOffset : UInt32
    uAssocRequestIEsLength : UInt32
}
struct DOT11_FRAGMENT_DESCRIPTOR {
    uOffset : UInt32
    uLength : UInt32
}
struct DOT11_PER_MSDU_COUNTERS {
    uTransmittedFragmentCount : UInt32
    uRetryCount : UInt32
    uRTSSuccessCount : UInt32
    uRTSFailureCount : UInt32
    uACKFailureCount : UInt32
}
struct DOT11_HRDSSS_PHY_ATTRIBUTES {
    bShortPreambleOptionImplemented : BOOLEAN
    bPBCCOptionImplemented : BOOLEAN
    bChannelAgilityPresent : BOOLEAN
    uHRCCAModeSupported : UInt32
}
struct DOT11_OFDM_PHY_ATTRIBUTES {
    uFrequencyBandsSupported : UInt32
}
struct DOT11_ERP_PHY_ATTRIBUTES {
    HRDSSSAttributes : DOT11_HRDSSS_PHY_ATTRIBUTES
    bERPPBCCOptionImplemented : BOOLEAN
    bDSSSOFDMOptionImplemented : BOOLEAN
    bShortSlotTimeOptionImplemented : BOOLEAN
}
struct DOT11_PHY_ATTRIBUTES {
    Header : NDIS_OBJECT_HEADER
    PhyType : DOT11_PHY_TYPE
    bHardwarePhyState : BOOLEAN
    bSoftwarePhyState : BOOLEAN
    bCFPollable : BOOLEAN
    uMPDUMaxLength : UInt32
    TempType : DOT11_TEMP_TYPE
    DiversitySupport : DOT11_DIVERSITY_SUPPORT
    PhySpecificAttributes : this._PhySpecificAttributes_e__Union
    uNumberSupportedPowerLevels : UInt32
    TxPowerLevels : UInt32[8]
    uNumDataRateMappingEntries : UInt32
    DataRateMappingEntries : DOT11_DATA_RATE_MAPPING_ENTRY[126]
    SupportedDataRatesValue : DOT11_SUPPORTED_DATA_RATES_VALUE_V2
    struct _PhySpecificAttributes_e__Union {
        union {
            HRDSSSAttributes : DOT11_HRDSSS_PHY_ATTRIBUTES
            OFDMAttributes : DOT11_OFDM_PHY_ATTRIBUTES
            ERPAttributes : DOT11_ERP_PHY_ATTRIBUTES
        }
    }
}
struct DOT11_EXTSTA_ATTRIBUTES {
    Header : NDIS_OBJECT_HEADER
    uScanSSIDListSize : UInt32
    uDesiredBSSIDListSize : UInt32
    uDesiredSSIDListSize : UInt32
    uExcludedMacAddressListSize : UInt32
    uPrivacyExemptionListSize : UInt32
    uKeyMappingTableSize : UInt32
    uDefaultKeyTableSize : UInt32
    uWEPKeyValueMaxLength : UInt32
    uPMKIDCacheSize : UInt32
    uMaxNumPerSTADefaultKeyTables : UInt32
    bStrictlyOrderedServiceClassImplemented : BOOLEAN
    ucSupportedQoSProtocolFlags : UInt8
    bSafeModeImplemented : BOOLEAN
    uNumSupportedCountryOrRegionStrings : UInt32
    pSupportedCountryOrRegionStrings : UInt8.Ptr
    uInfraNumSupportedUcastAlgoPairs : UInt32
    pInfraSupportedUcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    uInfraNumSupportedMcastAlgoPairs : UInt32
    pInfraSupportedMcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    uAdhocNumSupportedUcastAlgoPairs : UInt32
    pAdhocSupportedUcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    uAdhocNumSupportedMcastAlgoPairs : UInt32
    pAdhocSupportedMcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    bAutoPowerSaveMode : BOOLEAN
    uMaxNetworkOffloadListSize : UInt32
    bMFPCapable : BOOLEAN
    uInfraNumSupportedMcastMgmtAlgoPairs : UInt32
    pInfraSupportedMcastMgmtAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    bNeighborReportSupported : BOOLEAN
    bAPChannelReportSupported : BOOLEAN
    bActionFramesSupported : BOOLEAN
    bANQPQueryOffloadSupported : BOOLEAN
    bHESSIDConnectionSupported : BOOLEAN
}
struct DOT11_RECV_EXTENSION_INFO {
    uVersion : UInt32
    pvReserved : Struct.Ptr
    dot11PhyType : DOT11_PHY_TYPE
    uChCenterFrequency : UInt32
    lRSSI : Int32
    lRSSIMin : Int32
    lRSSIMax : Int32
    uRSSI : UInt32
    ucPriority : UInt8
    ucDataRate : UInt8
    ucPeerMacAddress : UInt8[6]
    dwExtendedStatus : UInt32
    hWEPOffloadContext : HANDLE
    hAuthOffloadContext : HANDLE
    usWEPAppliedMask : UInt16
    usWPAMSDUPriority : UInt16
    dot11LowestIV48Counter : DOT11_IV48_COUNTER
    usDot11LeftRWBitMap : UInt16
    dot11HighestIV48Counter : DOT11_IV48_COUNTER
    usDot11RightRWBitMap : UInt16
    usNumberOfMPDUsReceived : UInt16
    usNumberOfFragments : UInt16
    pNdisPackets : Struct.Ptr[1]
}
struct DOT11_RECV_EXTENSION_INFO_V2 {
    uVersion : UInt32
    pvReserved : Struct.Ptr
    dot11PhyType : DOT11_PHY_TYPE
    uChCenterFrequency : UInt32
    lRSSI : Int32
    uRSSI : UInt32
    ucPriority : UInt8
    ucDataRate : UInt8
    ucPeerMacAddress : UInt8[6]
    dwExtendedStatus : UInt32
    hWEPOffloadContext : HANDLE
    hAuthOffloadContext : HANDLE
    usWEPAppliedMask : UInt16
    usWPAMSDUPriority : UInt16
    dot11LowestIV48Counter : DOT11_IV48_COUNTER
    usDot11LeftRWBitMap : UInt16
    dot11HighestIV48Counter : DOT11_IV48_COUNTER
    usDot11RightRWBitMap : UInt16
    usNumberOfMPDUsReceived : UInt16
    usNumberOfFragments : UInt16
    pNdisPackets : Struct.Ptr[1]
}
struct DOT11_STATUS_INDICATION {
    uStatusType : UInt32
    ndisStatus : Int32
}
struct DOT11_MPDU_MAX_LENGTH_INDICATION {
    Header : NDIS_OBJECT_HEADER
    uPhyId : UInt32
    uMPDUMaxLength : UInt32
}
struct DOT11_ASSOCIATION_START_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    MacAddr : UInt8[6]
    SSID : DOT11_SSID
    uIHVDataOffset : UInt32
    uIHVDataSize : UInt32
}
struct DOT11_ENCAP_ENTRY {
    usEtherType : UInt16
    usEncapType : UInt16
}
struct DOT11_DS_INFO extends Int32 {
    static DOT11_DS_CHANGED := 0
    static DOT11_DS_UNCHANGED := 1
    static DOT11_DS_UNKNOWN := 2
}
struct DOT11_ASSOCIATION_COMPLETION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    MacAddr : UInt8[6]
    uStatus : UInt32
    bReAssocReq : BOOLEAN
    bReAssocResp : BOOLEAN
    uAssocReqOffset : UInt32
    uAssocReqSize : UInt32
    uAssocRespOffset : UInt32
    uAssocRespSize : UInt32
    uBeaconOffset : UInt32
    uBeaconSize : UInt32
    uIHVDataOffset : UInt32
    uIHVDataSize : UInt32
    AuthAlgo : DOT11_AUTH_ALGORITHM
    UnicastCipher : DOT11_CIPHER_ALGORITHM
    MulticastCipher : DOT11_CIPHER_ALGORITHM
    uActivePhyListOffset : UInt32
    uActivePhyListSize : UInt32
    bFourAddressSupported : BOOLEAN
    bPortAuthorized : BOOLEAN
    ucActiveQoSProtocol : UInt8
    DSInfo : DOT11_DS_INFO
    uEncapTableOffset : UInt32
    uEncapTableSize : UInt32
    MulticastMgmtCipher : DOT11_CIPHER_ALGORITHM
    uAssocComebackTime : UInt32
}
struct DOT11_CONNECTION_START_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    BSSType : DOT11_BSS_TYPE
    AdhocBSSID : UInt8[6]
    AdhocSSID : DOT11_SSID
}
struct DOT11_CONNECTION_COMPLETION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uStatus : UInt32
}
struct DOT11_ROAMING_START_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    AdhocBSSID : UInt8[6]
    AdhocSSID : DOT11_SSID
    uRoamingReason : UInt32
}
struct DOT11_ROAMING_COMPLETION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uStatus : UInt32
}
struct DOT11_DISASSOCIATION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    MacAddr : UInt8[6]
    uReason : UInt32
    uIHVDataOffset : UInt32
    uIHVDataSize : UInt32
}
struct DOT11_TKIPMIC_FAILURE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    bDefaultKeyFailure : BOOLEAN
    uKeyIndex : UInt32
    PeerMac : UInt8[6]
}
struct DOT11_PMKID_CANDIDATE_LIST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uCandidateListSize : UInt32
    uCandidateListOffset : UInt32
}
struct DOT11_BSSID_CANDIDATE {
    BSSID : UInt8[6]
    uFlags : UInt32
}
struct DOT11_PHY_STATE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uPhyId : UInt32
    bHardwarePhyState : BOOLEAN
    bSoftwarePhyState : BOOLEAN
}
struct DOT11_LINK_QUALITY_ENTRY {
    PeerMacAddr : UInt8[6]
    ucLinkQuality : UInt8
}
struct DOT11_LINK_QUALITY_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uLinkQualityListSize : UInt32
    uLinkQualityListOffset : UInt32
}
struct DOT11_EXTSTA_SEND_CONTEXT {
    Header : NDIS_OBJECT_HEADER
    usExemptionActionType : UInt16
    uPhyId : UInt32
    uDelayedSleepValue : UInt32
    pvMediaSpecificInfo : Struct.Ptr
    uSendFlags : UInt32
}
struct DOT11_EXTSTA_RECV_CONTEXT {
    Header : NDIS_OBJECT_HEADER
    uReceiveFlags : UInt32
    uPhyId : UInt32
    uChCenterFrequency : UInt32
    usNumberOfMPDUsReceived : UInt16
    lRSSI : Int32
    ucDataRate : UInt8
    uSizeMediaSpecificInfo : UInt32
    pvMediaSpecificInfo : Struct.Ptr
    ullTimestamp : Int64
}
struct DOT11_EXTAP_ATTRIBUTES {
    Header : NDIS_OBJECT_HEADER
    uScanSSIDListSize : UInt32
    uDesiredSSIDListSize : UInt32
    uPrivacyExemptionListSize : UInt32
    uAssociationTableSize : UInt32
    uDefaultKeyTableSize : UInt32
    uWEPKeyValueMaxLength : UInt32
    bStrictlyOrderedServiceClassImplemented : BOOLEAN
    uNumSupportedCountryOrRegionStrings : UInt32
    pSupportedCountryOrRegionStrings : UInt8.Ptr
    uInfraNumSupportedUcastAlgoPairs : UInt32
    pInfraSupportedUcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
    uInfraNumSupportedMcastAlgoPairs : UInt32
    pInfraSupportedMcastAlgoPairs : DOT11_AUTH_CIPHER_PAIR.Ptr
}
struct DOT11_INCOMING_ASSOC_STARTED_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
}
struct DOT11_INCOMING_ASSOC_REQUEST_RECEIVED_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
    bReAssocReq : BOOLEAN
    uAssocReqOffset : UInt32
    uAssocReqSize : UInt32
}
struct DOT11_INCOMING_ASSOC_COMPLETION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
    uStatus : UInt32
    ucErrorSource : UInt8
    bReAssocReq : BOOLEAN
    bReAssocResp : BOOLEAN
    uAssocReqOffset : UInt32
    uAssocReqSize : UInt32
    uAssocRespOffset : UInt32
    uAssocRespSize : UInt32
    AuthAlgo : DOT11_AUTH_ALGORITHM
    UnicastCipher : DOT11_CIPHER_ALGORITHM
    MulticastCipher : DOT11_CIPHER_ALGORITHM
    uActivePhyListOffset : UInt32
    uActivePhyListSize : UInt32
    uBeaconOffset : UInt32
    uBeaconSize : UInt32
}
struct DOT11_STOP_AP_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ulReason : UInt32
}
struct DOT11_PHY_FREQUENCY_ADOPTED_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ulPhyId : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ulChannel : UInt32
            ulFrequency : UInt32
        }
    }
}
struct DOT11_CAN_SUSTAIN_AP_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ulReason : UInt32
}
struct DOT11_AVAILABLE_CHANNEL_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    uChannelNumber : UInt32[1]
}
struct DOT11_AVAILABLE_FREQUENCY_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    uFrequencyValue : UInt32[1]
}
struct DOT11_DISASSOCIATE_PEER_REQUEST {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
    usReason : UInt16
}
struct DOT11_INCOMING_ASSOC_DECISION {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
    bAccept : BOOLEAN
    usReasonCode : UInt16
    uAssocResponseIEsOffset : UInt32
    uAssocResponseIEsLength : UInt32
}
struct DOT11_INCOMING_ASSOC_DECISION_V2 {
    Header : NDIS_OBJECT_HEADER
    PeerMacAddr : UInt8[6]
    bAccept : BOOLEAN
    usReasonCode : UInt16
    uAssocResponseIEsOffset : UInt32
    uAssocResponseIEsLength : UInt32
    WFDStatus : UInt8
}
struct DOT11_ADDITIONAL_IE {
    Header : NDIS_OBJECT_HEADER
    uBeaconIEsOffset : UInt32
    uBeaconIEsLength : UInt32
    uResponseIEsOffset : UInt32
    uResponseIEsLength : UInt32
}
struct DOT11_PEER_STATISTICS {
    ullDecryptSuccessCount : Int64
    ullDecryptFailureCount : Int64
    ullTxPacketSuccessCount : Int64
    ullTxPacketFailureCount : Int64
    ullRxPacketSuccessCount : Int64
    ullRxPacketFailureCount : Int64
}
struct DOT11_PEER_INFO {
    MacAddress : UInt8[6]
    usCapabilityInformation : UInt16
    AuthAlgo : DOT11_AUTH_ALGORITHM
    UnicastCipherAlgo : DOT11_CIPHER_ALGORITHM
    MulticastCipherAlgo : DOT11_CIPHER_ALGORITHM
    bWpsEnabled : BOOLEAN
    usListenInterval : UInt16
    ucSupportedRates : UInt8[255]
    usAssociationID : UInt16
    AssociationState : DOT11_ASSOCIATION_STATE
    PowerMode : DOT11_POWER_MODE
    liAssociationUpTime : Int64
    Statistics : DOT11_PEER_STATISTICS
}
struct DOT11_PEER_INFO_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    PeerInfo : DOT11_PEER_INFO[1]
}
struct DOT11_VWIFI_COMBINATION {
    Header : NDIS_OBJECT_HEADER
    uNumInfrastructure : UInt32
    uNumAdhoc : UInt32
    uNumSoftAP : UInt32
}
struct DOT11_VWIFI_COMBINATION_V2 {
    Header : NDIS_OBJECT_HEADER
    uNumInfrastructure : UInt32
    uNumAdhoc : UInt32
    uNumSoftAP : UInt32
    uNumVirtualStation : UInt32
}
struct DOT11_VWIFI_COMBINATION_V3 {
    Header : NDIS_OBJECT_HEADER
    uNumInfrastructure : UInt32
    uNumAdhoc : UInt32
    uNumSoftAP : UInt32
    uNumVirtualStation : UInt32
    uNumWFDGroup : UInt32
}
struct DOT11_VWIFI_ATTRIBUTES {
    Header : NDIS_OBJECT_HEADER
    uTotalNumOfEntries : UInt32
    Combinations : DOT11_VWIFI_COMBINATION[1]
}
struct DOT11_MAC_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    uOpmodeMask : UInt32
}
struct DOT11_MAC_INFO {
    uReserved : UInt32
    uNdisPortNumber : UInt32
    MacAddr : UInt8[6]
}
struct DOT11_WFD_ATTRIBUTES {
    Header : NDIS_OBJECT_HEADER
    uNumConcurrentGORole : UInt32
    uNumConcurrentClientRole : UInt32
    WPSVersionsSupported : UInt32
    bServiceDiscoverySupported : BOOLEAN
    bClientDiscoverabilitySupported : BOOLEAN
    bInfrastructureManagementSupported : BOOLEAN
    uMaxSecondaryDeviceTypeListSize : UInt32
    DeviceAddress : UInt8[6]
    uInterfaceAddressListCount : UInt32
    pInterfaceAddressList : UInt8.Ptr
    uNumSupportedCountryOrRegionStrings : UInt32
    pSupportedCountryOrRegionStrings : UInt8.Ptr
    uDiscoveryFilterListSize : UInt32
    uGORoleClientTableSize : UInt32
}
struct DOT11_WFD_DEVICE_TYPE {
    CategoryID : UInt16
    SubCategoryID : UInt16
    OUI : UInt8[4]
}
struct DOT11_WPS_DEVICE_NAME {
    uDeviceNameLength : UInt32
    ucDeviceName : UInt8[32]
}
struct DOT11_WFD_CONFIGURATION_TIMEOUT {
    GOTimeout : UInt8
    ClientTimeout : UInt8
}
struct DOT11_WFD_GROUP_ID {
    DeviceAddress : UInt8[6]
    SSID : DOT11_SSID
}
struct DOT11_WFD_GO_INTENT {
    _bitfield : UInt8
}
struct DOT11_WFD_CHANNEL {
    CountryRegionString : UInt8[3]
    OperatingClass : UInt8
    ChannelNumber : UInt8
}
struct DOT11_WPS_CONFIG_METHOD extends Int32 {
    static DOT11_WPS_CONFIG_METHOD_NULL := 0
    static DOT11_WPS_CONFIG_METHOD_DISPLAY := 8
    static DOT11_WPS_CONFIG_METHOD_NFC_TAG := 32
    static DOT11_WPS_CONFIG_METHOD_NFC_INTERFACE := 64
    static DOT11_WPS_CONFIG_METHOD_PUSHBUTTON := 128
    static DOT11_WPS_CONFIG_METHOD_KEYPAD := 256
    static DOT11_WPS_CONFIG_METHOD_WFDS_DEFAULT := 4096
}
struct DOT11_WPS_DEVICE_PASSWORD_ID extends Int32 {
    static DOT11_WPS_PASSWORD_ID_DEFAULT := 0
    static DOT11_WPS_PASSWORD_ID_USER_SPECIFIED := 1
    static DOT11_WPS_PASSWORD_ID_MACHINE_SPECIFIED := 2
    static DOT11_WPS_PASSWORD_ID_REKEY := 3
    static DOT11_WPS_PASSWORD_ID_PUSHBUTTON := 4
    static DOT11_WPS_PASSWORD_ID_REGISTRAR_SPECIFIED := 5
    static DOT11_WPS_PASSWORD_ID_NFC_CONNECTION_HANDOVER := 7
    static DOT11_WPS_PASSWORD_ID_WFD_SERVICES := 8
    static DOT11_WPS_PASSWORD_ID_OOB_RANGE_MIN := 16
    static DOT11_WPS_PASSWORD_ID_OOB_RANGE_MAX := 65535
}
struct WFDSVC_CONNECTION_CAPABILITY {
    bNew : BOOLEAN
    bClient : BOOLEAN
    bGO : BOOLEAN
}
struct DOT11_WFD_SERVICE_HASH_LIST {
    ServiceHashCount : UInt16
    ServiceHash : UInt8[6]
}
struct DOT11_WFD_ADVERTISEMENT_ID {
    AdvertisementID : UInt32
    ServiceAddress : UInt8[6]
}
struct DOT11_WFD_SESSION_ID {
    SessionID : UInt32
    SessionAddress : UInt8[6]
}
struct DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR {
    AdvertisementID : UInt32
    ConfigMethods : UInt16
    ServiceNameLength : UInt8
    ServiceName : UInt8[255]
}
struct DOT11_WFD_ADVERTISED_SERVICE_LIST {
    ServiceCount : UInt16
    AdvertisedService : DOT11_WFD_ADVERTISED_SERVICE_DESCRIPTOR[1]
}
struct DOT11_WFD_DISCOVER_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Status : Int32
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    uListOffset : UInt32
    uListLength : UInt32
}
struct DOT11_GO_NEGOTIATION_REQUEST_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_GO_NEGOTIATION_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_GO_NEGOTIATION_RESPONSE_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_GO_NEGOTIATION_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    ResponseContext : Struct.Ptr
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_GO_NEGOTIATION_CONFIRMATION_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_GO_NEGOTIATION_CONFIRMATION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_INVITATION_REQUEST_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    ReceiverAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_INVITATION_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    TransmitterDeviceAddress : UInt8[6]
    BSSID : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_INVITATION_RESPONSE_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ReceiverDeviceAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_INVITATION_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    TransmitterDeviceAddress : UInt8[6]
    BSSID : UInt8[6]
    DialogToken : UInt8
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_PROVISION_DISCOVERY_REQUEST_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    ReceiverAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_PROVISION_DISCOVERY_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    TransmitterDeviceAddress : UInt8[6]
    BSSID : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_PROVISION_DISCOVERY_RESPONSE_SEND_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ReceiverDeviceAddress : UInt8[6]
    DialogToken : UInt8
    Status : Int32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_RECEIVED_PROVISION_DISCOVERY_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    TransmitterDeviceAddress : UInt8[6]
    BSSID : UInt8[6]
    DialogToken : UInt8
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_ANQP_QUERY_RESULT extends Int32 {
    static dot11_ANQP_query_result_success := 0
    static dot11_ANQP_query_result_failure := 1
    static dot11_ANQP_query_result_timed_out := 2
    static dot11_ANQP_query_result_resources := 3
    static dot11_ANQP_query_result_advertisement_protocol_not_supported_on_remote := 4
    static dot11_ANQP_query_result_gas_protocol_failure := 5
    static dot11_ANQP_query_result_advertisement_server_not_responding := 6
    static dot11_ANQP_query_result_access_issues := 7
}
struct DOT11_ANQP_QUERY_COMPLETE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Status : DOT11_ANQP_QUERY_RESULT
    hContext : HANDLE
    uResponseLength : UInt32
}
struct DOT11_WFD_DEVICE_CAPABILITY_CONFIG {
    Header : NDIS_OBJECT_HEADER
    bServiceDiscoveryEnabled : BOOLEAN
    bClientDiscoverabilityEnabled : BOOLEAN
    bConcurrentOperationSupported : BOOLEAN
    bInfrastructureManagementEnabled : BOOLEAN
    bDeviceLimitReached : BOOLEAN
    bInvitationProcedureEnabled : BOOLEAN
    WPSVersionsEnabled : UInt32
}
struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG {
    Header : NDIS_OBJECT_HEADER
    bPersistentGroupEnabled : BOOLEAN
    bIntraBSSDistributionSupported : BOOLEAN
    bCrossConnectionSupported : BOOLEAN
    bPersistentReconnectSupported : BOOLEAN
    bGroupFormationEnabled : BOOLEAN
    uMaximumGroupLimit : UInt32
}
struct DOT11_WFD_GROUP_OWNER_CAPABILITY_CONFIG_V2 {
    Header : NDIS_OBJECT_HEADER
    bPersistentGroupEnabled : BOOLEAN
    bIntraBSSDistributionSupported : BOOLEAN
    bCrossConnectionSupported : BOOLEAN
    bPersistentReconnectSupported : BOOLEAN
    bGroupFormationEnabled : BOOLEAN
    uMaximumGroupLimit : UInt32
    bEapolKeyIpAddressAllocationSupported : BOOLEAN
}
struct DOT11_WFD_DEVICE_INFO {
    Header : NDIS_OBJECT_HEADER
    DeviceAddress : UInt8[6]
    ConfigMethods : UInt16
    PrimaryDeviceType : DOT11_WFD_DEVICE_TYPE
    DeviceName : DOT11_WPS_DEVICE_NAME
}
struct DOT11_WFD_SECONDARY_DEVICE_TYPE_LIST {
    Header : NDIS_OBJECT_HEADER
    uNumOfEntries : UInt32
    uTotalNumOfEntries : UInt32
    SecondaryDeviceTypes : DOT11_WFD_DEVICE_TYPE[1]
}
struct DOT11_WFD_DISCOVER_TYPE extends Int32 {
    static dot11_wfd_discover_type_scan_only := 1
    static dot11_wfd_discover_type_find_only := 2
    static dot11_wfd_discover_type_auto := 3
    static dot11_wfd_discover_type_scan_social_channels := 4
    static dot11_wfd_discover_type_forced := -2147483648
}
struct DOT11_WFD_SCAN_TYPE extends Int32 {
    static dot11_wfd_scan_type_active := 1
    static dot11_wfd_scan_type_passive := 2
    static dot11_wfd_scan_type_auto := 3
}
struct DOT11_WFD_DISCOVER_DEVICE_FILTER {
    DeviceID : UInt8[6]
    ucBitmask : UInt8
    GroupSSID : DOT11_SSID
}
struct DOT11_WFD_DISCOVER_REQUEST {
    Header : NDIS_OBJECT_HEADER
    DiscoverType : DOT11_WFD_DISCOVER_TYPE
    ScanType : DOT11_WFD_SCAN_TYPE
    uDiscoverTimeout : UInt32
    uDeviceFilterListOffset : UInt32
    uNumDeviceFilters : UInt32
    uIEsOffset : UInt32
    uIEsLength : UInt32
    bForceScanLegacyNetworks : BOOLEAN
}
struct DOT11_WFD_DEVICE_ENTRY {
    uPhyId : UInt32
    PhySpecificInfo : DOT11_BSS_ENTRY_PHY_SPECIFIC_INFO
    dot11BSSID : UInt8[6]
    dot11BSSType : DOT11_BSS_TYPE
    TransmitterAddress : UInt8[6]
    lRSSI : Int32
    uLinkQuality : UInt32
    usBeaconPeriod : UInt16
    ullTimestamp : Int64
    ullBeaconHostTimestamp : Int64
    ullProbeResponseHostTimestamp : Int64
    usCapabilityInformation : UInt16
    uBeaconIEsOffset : UInt32
    uBeaconIEsLength : UInt32
    uProbeResponseIEsOffset : UInt32
    uProbeResponseIEsLength : UInt32
}
struct DOT11_WFD_ADDITIONAL_IE {
    Header : NDIS_OBJECT_HEADER
    uBeaconIEsOffset : UInt32
    uBeaconIEsLength : UInt32
    uProbeResponseIEsOffset : UInt32
    uProbeResponseIEsLength : UInt32
    uDefaultRequestIEsOffset : UInt32
    uDefaultRequestIEsLength : UInt32
}
struct DOT11_SEND_GO_NEGOTIATION_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    uSendTimeout : UInt32
    GroupOwnerIntent : DOT11_WFD_GO_INTENT
    MinimumConfigTimeout : DOT11_WFD_CONFIGURATION_TIMEOUT
    IntendedInterfaceAddress : UInt8[6]
    GroupCapability : UInt8
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_SEND_GO_NEGOTIATION_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uSendTimeout : UInt32
    Status : UInt8
    GroupOwnerIntent : DOT11_WFD_GO_INTENT
    MinimumConfigTimeout : DOT11_WFD_CONFIGURATION_TIMEOUT
    IntendedInterfaceAddress : UInt8[6]
    GroupCapability : UInt8
    GroupID : DOT11_WFD_GROUP_ID
    bUseGroupID : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_SEND_GO_NEGOTIATION_CONFIRMATION_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    PeerDeviceAddress : UInt8[6]
    DialogToken : UInt8
    ResponseContext : Struct.Ptr
    uSendTimeout : UInt32
    Status : UInt8
    GroupCapability : UInt8
    GroupID : DOT11_WFD_GROUP_ID
    bUseGroupID : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_WFD_INVITATION_FLAGS {
    _bitfield : UInt8
}
struct DOT11_SEND_INVITATION_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    DialogToken : UInt8
    PeerDeviceAddress : UInt8[6]
    uSendTimeout : UInt32
    MinimumConfigTimeout : DOT11_WFD_CONFIGURATION_TIMEOUT
    InvitationFlags : DOT11_WFD_INVITATION_FLAGS
    GroupBSSID : UInt8[6]
    bUseGroupBSSID : BOOLEAN
    OperatingChannel : DOT11_WFD_CHANNEL
    bUseSpecifiedOperatingChannel : BOOLEAN
    GroupID : DOT11_WFD_GROUP_ID
    bLocalGO : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_SEND_INVITATION_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ReceiverDeviceAddress : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uSendTimeout : UInt32
    Status : UInt8
    MinimumConfigTimeout : DOT11_WFD_CONFIGURATION_TIMEOUT
    GroupBSSID : UInt8[6]
    bUseGroupBSSID : BOOLEAN
    OperatingChannel : DOT11_WFD_CHANNEL
    bUseSpecifiedOperatingChannel : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_SEND_PROVISION_DISCOVERY_REQUEST_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    DialogToken : UInt8
    PeerDeviceAddress : UInt8[6]
    uSendTimeout : UInt32
    GroupCapability : UInt8
    GroupID : DOT11_WFD_GROUP_ID
    bUseGroupID : BOOLEAN
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_SEND_PROVISION_DISCOVERY_RESPONSE_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    ReceiverDeviceAddress : UInt8[6]
    DialogToken : UInt8
    RequestContext : Struct.Ptr
    uSendTimeout : UInt32
    uIEsOffset : UInt32
    uIEsLength : UInt32
}
struct DOT11_WFD_DEVICE_LISTEN_CHANNEL {
    Header : NDIS_OBJECT_HEADER
    ChannelNumber : UInt8
}
struct DOT11_WFD_GROUP_START_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    AdvertisedOperatingChannel : DOT11_WFD_CHANNEL
}
struct DOT11_WFD_GROUP_JOIN_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    GOOperatingChannel : DOT11_WFD_CHANNEL
    GOConfigTime : UInt32
    bInGroupFormation : BOOLEAN
    bWaitForWPSReady : BOOLEAN
}
struct DOT11_POWER_MGMT_AUTO_MODE_ENABLED_INFO {
    Header : NDIS_OBJECT_HEADER
    bEnabled : BOOLEAN
}
struct DOT11_POWER_MODE_REASON extends Int32 {
    static dot11_power_mode_reason_no_change := 0
    static dot11_power_mode_reason_noncompliant_AP := 1
    static dot11_power_mode_reason_legacy_WFD_device := 2
    static dot11_power_mode_reason_compliant_AP := 3
    static dot11_power_mode_reason_compliant_WFD_device := 4
    static dot11_power_mode_reason_others := 5
}
struct DOT11_POWER_MGMT_MODE_STATUS_INFO {
    Header : NDIS_OBJECT_HEADER
    PowerSaveMode : DOT11_POWER_MODE
    uPowerSaveLevel : UInt32
    Reason : DOT11_POWER_MODE_REASON
}
struct DOT11_CHANNEL_HINT {
    Dot11PhyType : DOT11_PHY_TYPE
    uChannelNumber : UInt32
}
struct DOT11_OFFLOAD_NETWORK {
    Ssid : DOT11_SSID
    UnicastCipher : DOT11_CIPHER_ALGORITHM
    AuthAlgo : DOT11_AUTH_ALGORITHM
    Dot11ChannelHints : DOT11_CHANNEL_HINT[4]
}
struct DOT11_OFFLOAD_NETWORK_LIST_INFO {
    Header : NDIS_OBJECT_HEADER
    ulFlags : UInt32
    FastScanPeriod : UInt32
    FastScanIterations : UInt32
    SlowScanPeriod : UInt32
    uNumOfEntries : UInt32
    offloadNetworkList : DOT11_OFFLOAD_NETWORK[1]
}
struct DOT11_OFFLOAD_NETWORK_STATUS_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    Status : Int32
}
struct DOT11_MANUFACTURING_TEST_TYPE extends Int32 {
    static dot11_manufacturing_test_unknown := 0
    static dot11_manufacturing_test_self_start := 1
    static dot11_manufacturing_test_self_query_result := 2
    static dot11_manufacturing_test_rx := 3
    static dot11_manufacturing_test_tx := 4
    static dot11_manufacturing_test_query_adc := 5
    static dot11_manufacturing_test_set_data := 6
    static dot11_manufacturing_test_query_data := 7
    static dot11_manufacturing_test_sleep := 8
    static dot11_manufacturing_test_awake := 9
    static dot11_manufacturing_test_IHV_start := -2147483648
    static dot11_manufacturing_test_IHV_end := -1
}
struct DOT11_MANUFACTURING_TEST {
    dot11ManufacturingTestType : DOT11_MANUFACTURING_TEST_TYPE
    uBufferLength : UInt32
    ucBuffer : UInt8[1]
}
struct DOT11_MANUFACTURING_SELF_TEST_TYPE extends Int32 {
    static DOT11_MANUFACTURING_SELF_TEST_TYPE_INTERFACE := 1
    static DOT11_MANUFACTURING_SELF_TEST_TYPE_RF_INTERFACE := 2
    static DOT11_MANUFACTURING_SELF_TEST_TYPE_BT_COEXISTENCE := 3
}
struct DOT11_MANUFACTURING_SELF_TEST_SET_PARAMS {
    SelfTestType : DOT11_MANUFACTURING_SELF_TEST_TYPE
    uTestID : UInt32
    uPinBitMask : UInt32
    pvContext : Struct.Ptr
    uBufferLength : UInt32
    ucBufferIn : UInt8[1]
}
struct DOT11_MANUFACTURING_SELF_TEST_QUERY_RESULTS {
    SelfTestType : DOT11_MANUFACTURING_SELF_TEST_TYPE
    uTestID : UInt32
    bResult : BOOLEAN
    uPinFailedBitMask : UInt32
    pvContext : Struct.Ptr
    uBytesWrittenOut : UInt32
    ucBufferOut : UInt8[1]
}
struct DOT11_BAND extends Int32 {
    static dot11_band_2p4g := 1
    static dot11_band_4p9g := 2
    static dot11_band_5g := 3
}
struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_RX {
    bEnabled : BOOLEAN
    Dot11Band : DOT11_BAND
    uChannel : UInt32
    PowerLevel : Int32
}
struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_TX {
    bEnable : BOOLEAN
    bOpenLoop : BOOLEAN
    Dot11Band : DOT11_BAND
    uChannel : UInt32
    uSetPowerLevel : UInt32
    ADCPowerLevel : Int32
}
struct DOT11_MANUFACTURING_FUNCTIONAL_TEST_QUERY_ADC {
    Dot11Band : DOT11_BAND
    uChannel : UInt32
    ADCPowerLevel : Int32
}
struct DOT11_MANUFACTURING_TEST_SET_DATA {
    uKey : UInt32
    uOffset : UInt32
    uBufferLength : UInt32
    ucBufferIn : UInt8[1]
}
struct DOT11_MANUFACTURING_TEST_QUERY_DATA {
    uKey : UInt32
    uOffset : UInt32
    uBufferLength : UInt32
    uBytesRead : UInt32
    ucBufferOut : UInt8[1]
}
struct DOT11_MANUFACTURING_TEST_SLEEP {
    uSleepTime : UInt32
    pvContext : Struct.Ptr
}
struct DOT11_MANUFACTURING_CALLBACK_TYPE extends Int32 {
    static dot11_manufacturing_callback_unknown := 0
    static dot11_manufacturing_callback_self_test_complete := 1
    static dot11_manufacturing_callback_sleep_complete := 2
    static dot11_manufacturing_callback_IHV_start := -2147483648
    static dot11_manufacturing_callback_IHV_end := -1
}
struct DOT11_MANUFACTURING_CALLBACK_PARAMETERS {
    Header : NDIS_OBJECT_HEADER
    dot11ManufacturingCallbackType : DOT11_MANUFACTURING_CALLBACK_TYPE
    uStatus : UInt32
    pvContext : Struct.Ptr
}
struct L2_NOTIFICATION_DATA {
    NotificationSource : WLAN_NOTIFICATION_SOURCES
    NotificationCode : UInt32
    InterfaceGuid : GUID
    dwDataSize : UInt32
    pData : Struct.Ptr
}
struct WLAN_PROFILE_INFO {
    strProfileName : UInt16[256]
    dwFlags : UInt32
}
struct DOT11_NETWORK {
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
}
struct WLAN_RAW_DATA {
    dwDataSize : UInt32
    DataBlob : UInt8[1]
}
struct WLAN_RAW_DATA_LIST {
    dwTotalSize : UInt32
    dwNumberOfItems : UInt32
    DataList : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        dwDataOffset : UInt32
        dwDataSize : UInt32
    }
}
struct WLAN_CONNECTION_MODE extends Int32 {
    static wlan_connection_mode_profile := 0
    static wlan_connection_mode_temporary_profile := 1
    static wlan_connection_mode_discovery_secure := 2
    static wlan_connection_mode_discovery_unsecure := 3
    static wlan_connection_mode_auto := 4
    static wlan_connection_mode_invalid := 5
}
struct WLAN_RATE_SET {
    uRateSetLength : UInt32
    usRateSet : UInt16[126]
}
struct WLAN_AVAILABLE_NETWORK {
    strProfileName : UInt16[256]
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
    uNumberOfBssids : UInt32
    bNetworkConnectable : BOOL
    wlanNotConnectableReason : UInt32
    uNumberOfPhyTypes : UInt32
    dot11PhyTypes : DOT11_PHY_TYPE[8]
    bMorePhyTypes : BOOL
    wlanSignalQuality : UInt32
    bSecurityEnabled : BOOL
    dot11DefaultAuthAlgorithm : DOT11_AUTH_ALGORITHM
    dot11DefaultCipherAlgorithm : DOT11_CIPHER_ALGORITHM
    dwFlags : UInt32
    dwReserved : UInt32
}
struct WLAN_AVAILABLE_NETWORK_V2 {
    strProfileName : UInt16[256]
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
    uNumberOfBssids : UInt32
    bNetworkConnectable : BOOL
    wlanNotConnectableReason : UInt32
    uNumberOfPhyTypes : UInt32
    dot11PhyTypes : DOT11_PHY_TYPE[8]
    bMorePhyTypes : BOOL
    wlanSignalQuality : UInt32
    bSecurityEnabled : BOOL
    dot11DefaultAuthAlgorithm : DOT11_AUTH_ALGORITHM
    dot11DefaultCipherAlgorithm : DOT11_CIPHER_ALGORITHM
    dwFlags : UInt32
    AccessNetworkOptions : DOT11_ACCESSNETWORKOPTIONS
    dot11HESSID : UInt8[6]
    VenueInfo : DOT11_VENUEINFO
    dwReserved : UInt32
}
struct WLAN_BSS_ENTRY {
    dot11Ssid : DOT11_SSID
    uPhyId : UInt32
    dot11Bssid : UInt8[6]
    dot11BssType : DOT11_BSS_TYPE
    dot11BssPhyType : DOT11_PHY_TYPE
    lRssi : Int32
    uLinkQuality : UInt32
    bInRegDomain : BOOLEAN
    usBeaconPeriod : UInt16
    ullTimestamp : Int64
    ullHostTimestamp : Int64
    usCapabilityInformation : UInt16
    ulChCenterFrequency : UInt32
    wlanRateSet : WLAN_RATE_SET
    ulIeOffset : UInt32
    ulIeSize : UInt32
}
struct WLAN_BSS_LIST {
    dwTotalSize : UInt32
    dwNumberOfItems : UInt32
    wlanBssEntries : WLAN_BSS_ENTRY[1]
}
struct WLAN_INTERFACE_STATE extends Int32 {
    static wlan_interface_state_not_ready := 0
    static wlan_interface_state_connected := 1
    static wlan_interface_state_ad_hoc_network_formed := 2
    static wlan_interface_state_disconnecting := 3
    static wlan_interface_state_disconnected := 4
    static wlan_interface_state_associating := 5
    static wlan_interface_state_discovering := 6
    static wlan_interface_state_authenticating := 7
}
struct WLAN_ADHOC_NETWORK_STATE extends Int32 {
    static wlan_adhoc_network_state_formed := 0
    static wlan_adhoc_network_state_connected := 1
}
struct WLAN_INTERFACE_INFO {
    InterfaceGuid : GUID
    strInterfaceDescription : UInt16[256]
    isState : WLAN_INTERFACE_STATE
}
struct WLAN_ASSOCIATION_ATTRIBUTES {
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
    dot11Bssid : UInt8[6]
    dot11PhyType : DOT11_PHY_TYPE
    uDot11PhyIndex : UInt32
    wlanSignalQuality : UInt32
    ulRxRate : UInt32
    ulTxRate : UInt32
}
struct WLAN_SECURITY_ATTRIBUTES {
    bSecurityEnabled : BOOL
    bOneXEnabled : BOOL
    dot11AuthAlgorithm : DOT11_AUTH_ALGORITHM
    dot11CipherAlgorithm : DOT11_CIPHER_ALGORITHM
}
struct WLAN_QOS_CAPABILITIES {
    bMSCSSupported : BOOL
    bDSCPToUPMappingSupported : BOOL
    bSCSSupported : BOOL
    bDSCPPolicySupported : BOOL
}
struct WLAN_CONNECTION_QOS_INFO {
    peerCapabilities : WLAN_QOS_CAPABILITIES
    bMSCSConfigured : BOOL
    bDSCPToUPMappingConfigured : BOOL
    ulNumConfiguredSCSStreams : UInt32
    ulNumConfiguredDSCPPolicies : UInt32
}
struct WLAN_QOS_INFO {
    interfaceCapabilities : WLAN_QOS_CAPABILITIES
    bConnected : BOOL
    connectionQoSInfo : WLAN_CONNECTION_QOS_INFO
}
struct WLAN_CONNECTION_ATTRIBUTES {
    isState : WLAN_INTERFACE_STATE
    wlanConnectionMode : WLAN_CONNECTION_MODE
    strProfileName : UInt16[256]
    wlanAssociationAttributes : WLAN_ASSOCIATION_ATTRIBUTES
    wlanSecurityAttributes : WLAN_SECURITY_ATTRIBUTES
}
struct WLAN_REALTIME_CONNECTION_QUALITY_LINK_INFO {
    ucLinkID : UInt8
    ulChannelCenterFrequencyMhz : UInt32
    ulBandwidth : UInt32
    lRssi : Int32
    wlanRateSet : WLAN_RATE_SET
}
struct WLAN_REALTIME_CONNECTION_QUALITY {
    dot11PhyType : DOT11_PHY_TYPE
    ulLinkQuality : UInt32
    ulRxRate : UInt32
    ulTxRate : UInt32
    bIsMLOConnection : BOOL
    ulNumLinks : UInt32
    linksInfo : WLAN_REALTIME_CONNECTION_QUALITY_LINK_INFO[1]
}
struct DOT11_RADIO_STATE extends Int32 {
    static dot11_radio_state_unknown := 0
    static dot11_radio_state_on := 1
    static dot11_radio_state_off := 2
}
struct WLAN_PHY_RADIO_STATE {
    dwPhyIndex : UInt32
    dot11SoftwareRadioState : DOT11_RADIO_STATE
    dot11HardwareRadioState : DOT11_RADIO_STATE
}
struct WLAN_RADIO_STATE {
    dwNumberOfPhys : UInt32
    PhyRadioState : WLAN_PHY_RADIO_STATE[64]
}
struct WLAN_OPERATIONAL_STATE extends Int32 {
    static wlan_operational_state_unknown := 0
    static wlan_operational_state_off := 1
    static wlan_operational_state_on := 2
    static wlan_operational_state_going_off := 3
    static wlan_operational_state_going_on := 4
}
struct WLAN_INTERFACE_TYPE extends Int32 {
    static wlan_interface_type_emulated_802_11 := 0
    static wlan_interface_type_native_802_11 := 1
    static wlan_interface_type_invalid := 2
}
struct WLAN_INTERFACE_CAPABILITY {
    interfaceType : WLAN_INTERFACE_TYPE
    bDot11DSupported : BOOL
    dwMaxDesiredSsidListSize : UInt32
    dwMaxDesiredBssidListSize : UInt32
    dwNumberOfSupportedPhys : UInt32
    dot11PhyTypes : DOT11_PHY_TYPE[64]
}
struct WLAN_AUTH_CIPHER_PAIR_LIST {
    dwNumberOfItems : UInt32
    pAuthCipherPairList : DOT11_AUTH_CIPHER_PAIR[1]
}
struct WLAN_COUNTRY_OR_REGION_STRING_LIST {
    dwNumberOfItems : UInt32
    pCountryOrRegionStringList : UInt8[3]
}
struct WLAN_PROFILE_INFO_LIST {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    ProfileInfo : WLAN_PROFILE_INFO[1]
}
struct WLAN_AVAILABLE_NETWORK_LIST {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    Network : WLAN_AVAILABLE_NETWORK[1]
}
struct WLAN_AVAILABLE_NETWORK_LIST_V2 {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    Network : WLAN_AVAILABLE_NETWORK_V2[1]
}
struct WLAN_INTERFACE_INFO_LIST {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    InterfaceInfo : WLAN_INTERFACE_INFO[1]
}
struct DOT11_NETWORK_LIST {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    Network : DOT11_NETWORK[1]
}
struct WLAN_POWER_SETTING extends Int32 {
    static wlan_power_setting_no_saving := 0
    static wlan_power_setting_low_saving := 1
    static wlan_power_setting_medium_saving := 2
    static wlan_power_setting_maximum_saving := 3
    static wlan_power_setting_invalid := 4
}
struct WLAN_CONNECTION_PARAMETERS {
    wlanConnectionMode : WLAN_CONNECTION_MODE
    strProfile : PWSTR
    pDot11Ssid : DOT11_SSID.Ptr
    pDesiredBssidList : DOT11_BSSID_LIST.Ptr
    dot11BssType : DOT11_BSS_TYPE
    dwFlags : UInt32
}
struct WLAN_CONNECTION_PARAMETERS_V2 {
    wlanConnectionMode : WLAN_CONNECTION_MODE
    strProfile : PWSTR
    pDot11Ssid : DOT11_SSID.Ptr
    pDot11Hessid : UInt8.Ptr
    pDesiredBssidList : DOT11_BSSID_LIST.Ptr
    dot11BssType : DOT11_BSS_TYPE
    dwFlags : UInt32
    pDot11AccessNetworkOptions : DOT11_ACCESSNETWORKOPTIONS.Ptr
}
struct WLAN_MSM_NOTIFICATION_DATA {
    wlanConnectionMode : WLAN_CONNECTION_MODE
    strProfileName : UInt16[256]
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
    dot11MacAddr : UInt8[6]
    bSecurityEnabled : BOOL
    bFirstPeer : BOOL
    bLastPeer : BOOL
    wlanReasonCode : UInt32
}
struct WLAN_CONNECTION_NOTIFICATION_DATA {
    wlanConnectionMode : WLAN_CONNECTION_MODE
    strProfileName : UInt16[256]
    dot11Ssid : DOT11_SSID
    dot11BssType : DOT11_BSS_TYPE
    bSecurityEnabled : BOOL
    wlanReasonCode : UInt32
    dwFlags : WLAN_CONNECTION_NOTIFICATION_FLAGS
    strProfileXml : UInt16[1]
}
struct WLAN_DEVICE_SERVICE_NOTIFICATION_DATA {
    DeviceService : GUID
    dwOpCode : UInt32
    dwDataSize : UInt32
    DataBlob : UInt8[1]
}
struct WLAN_NOTIFICATION_ACM extends Int32 {
    static wlan_notification_acm_start := 0
    static wlan_notification_acm_autoconf_enabled := 1
    static wlan_notification_acm_autoconf_disabled := 2
    static wlan_notification_acm_background_scan_enabled := 3
    static wlan_notification_acm_background_scan_disabled := 4
    static wlan_notification_acm_bss_type_change := 5
    static wlan_notification_acm_power_setting_change := 6
    static wlan_notification_acm_scan_complete := 7
    static wlan_notification_acm_scan_fail := 8
    static wlan_notification_acm_connection_start := 9
    static wlan_notification_acm_connection_complete := 10
    static wlan_notification_acm_connection_attempt_fail := 11
    static wlan_notification_acm_filter_list_change := 12
    static wlan_notification_acm_interface_arrival := 13
    static wlan_notification_acm_interface_removal := 14
    static wlan_notification_acm_profile_change := 15
    static wlan_notification_acm_profile_name_change := 16
    static wlan_notification_acm_profiles_exhausted := 17
    static wlan_notification_acm_network_not_available := 18
    static wlan_notification_acm_network_available := 19
    static wlan_notification_acm_disconnecting := 20
    static wlan_notification_acm_disconnected := 21
    static wlan_notification_acm_adhoc_network_state_change := 22
    static wlan_notification_acm_profile_unblocked := 23
    static wlan_notification_acm_screen_power_change := 24
    static wlan_notification_acm_profile_blocked := 25
    static wlan_notification_acm_scan_list_refresh := 26
    static wlan_notification_acm_operational_state_change := 27
    static wlan_notification_acm_end := 28
}
struct WLAN_NOTIFICATION_MSM extends Int32 {
    static wlan_notification_msm_start := 0
    static wlan_notification_msm_associating := 1
    static wlan_notification_msm_associated := 2
    static wlan_notification_msm_authenticating := 3
    static wlan_notification_msm_connected := 4
    static wlan_notification_msm_roaming_start := 5
    static wlan_notification_msm_roaming_end := 6
    static wlan_notification_msm_radio_state_change := 7
    static wlan_notification_msm_signal_quality_change := 8
    static wlan_notification_msm_disassociating := 9
    static wlan_notification_msm_disconnected := 10
    static wlan_notification_msm_peer_join := 11
    static wlan_notification_msm_peer_leave := 12
    static wlan_notification_msm_adapter_removal := 13
    static wlan_notification_msm_adapter_operation_mode_change := 14
    static wlan_notification_msm_link_degraded := 15
    static wlan_notification_msm_link_improved := 16
    static wlan_notification_msm_end := 17
}
struct WLAN_NOTIFICATION_SECURITY extends Int32 {
    static wlan_notification_security_start := 0
    static wlan_notification_security_end := 1
}
struct WLAN_NOTIFICATION_CALLBACK extends FunctionPointer {
    static Types := [L2_NOTIFICATION_DATA.Ptr, Struct.Ptr, "Void"]
}
struct WLAN_OPCODE_VALUE_TYPE extends Int32 {
    static wlan_opcode_value_type_query_only := 0
    static wlan_opcode_value_type_set_by_group_policy := 1
    static wlan_opcode_value_type_set_by_user := 2
    static wlan_opcode_value_type_invalid := 3
}
struct WLAN_INTF_OPCODE extends Int32 {
    static wlan_intf_opcode_autoconf_start := 0
    static wlan_intf_opcode_autoconf_enabled := 1
    static wlan_intf_opcode_background_scan_enabled := 2
    static wlan_intf_opcode_media_streaming_mode := 3
    static wlan_intf_opcode_radio_state := 4
    static wlan_intf_opcode_bss_type := 5
    static wlan_intf_opcode_interface_state := 6
    static wlan_intf_opcode_current_connection := 7
    static wlan_intf_opcode_channel_number := 8
    static wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs := 9
    static wlan_intf_opcode_supported_adhoc_auth_cipher_pairs := 10
    static wlan_intf_opcode_supported_country_or_region_string_list := 11
    static wlan_intf_opcode_current_operation_mode := 12
    static wlan_intf_opcode_supported_safe_mode := 13
    static wlan_intf_opcode_certified_safe_mode := 14
    static wlan_intf_opcode_hosted_network_capable := 15
    static wlan_intf_opcode_management_frame_protection_capable := 16
    static wlan_intf_opcode_secondary_sta_interfaces := 17
    static wlan_intf_opcode_secondary_sta_synchronized_connections := 18
    static wlan_intf_opcode_realtime_connection_quality := 19
    static wlan_intf_opcode_qos_info := 20
    static wlan_intf_opcode_autoconf_end := 268435455
    static wlan_intf_opcode_msm_start := 268435712
    static wlan_intf_opcode_statistics := 268435713
    static wlan_intf_opcode_rssi := 268435714
    static wlan_intf_opcode_msm_end := 536870911
    static wlan_intf_opcode_security_start := 536936448
    static wlan_intf_opcode_security_end := 805306367
    static wlan_intf_opcode_ihv_start := 805306368
    static wlan_intf_opcode_ihv_end := 1073741823
}
struct WLAN_AUTOCONF_OPCODE extends Int32 {
    static wlan_autoconf_opcode_start := 0
    static wlan_autoconf_opcode_show_denied_networks := 1
    static wlan_autoconf_opcode_power_setting := 2
    static wlan_autoconf_opcode_only_use_gp_profiles_for_allowed_networks := 3
    static wlan_autoconf_opcode_allow_explicit_creds := 4
    static wlan_autoconf_opcode_block_period := 5
    static wlan_autoconf_opcode_allow_virtual_station_extensibility := 6
    static wlan_autoconf_opcode_end := 7
}
struct WLAN_IHV_CONTROL_TYPE extends Int32 {
    static wlan_ihv_control_type_service := 0
    static wlan_ihv_control_type_driver := 1
}
struct WLAN_FILTER_LIST_TYPE extends Int32 {
    static wlan_filter_list_type_gp_permit := 0
    static wlan_filter_list_type_gp_deny := 1
    static wlan_filter_list_type_user_permit := 2
    static wlan_filter_list_type_user_deny := 3
}
struct WLAN_PHY_FRAME_STATISTICS {
    ullTransmittedFrameCount : Int64
    ullMulticastTransmittedFrameCount : Int64
    ullFailedCount : Int64
    ullRetryCount : Int64
    ullMultipleRetryCount : Int64
    ullMaxTXLifetimeExceededCount : Int64
    ullTransmittedFragmentCount : Int64
    ullRTSSuccessCount : Int64
    ullRTSFailureCount : Int64
    ullACKFailureCount : Int64
    ullReceivedFrameCount : Int64
    ullMulticastReceivedFrameCount : Int64
    ullPromiscuousReceivedFrameCount : Int64
    ullMaxRXLifetimeExceededCount : Int64
    ullFrameDuplicateCount : Int64
    ullReceivedFragmentCount : Int64
    ullPromiscuousReceivedFragmentCount : Int64
    ullFCSErrorCount : Int64
}
struct WLAN_MAC_FRAME_STATISTICS {
    ullTransmittedFrameCount : Int64
    ullReceivedFrameCount : Int64
    ullWEPExcludedCount : Int64
    ullTKIPLocalMICFailures : Int64
    ullTKIPReplays : Int64
    ullTKIPICVErrorCount : Int64
    ullCCMPReplays : Int64
    ullCCMPDecryptErrors : Int64
    ullWEPUndecryptableCount : Int64
    ullWEPICVErrorCount : Int64
    ullDecryptSuccessCount : Int64
    ullDecryptFailureCount : Int64
}
struct WLAN_STATISTICS {
    ullFourWayHandshakeFailures : Int64
    ullTKIPCounterMeasuresInvoked : Int64
    ullReserved : Int64
    MacUcastCounters : WLAN_MAC_FRAME_STATISTICS
    MacMcastCounters : WLAN_MAC_FRAME_STATISTICS
    dwNumberOfPhys : UInt32
    PhyCounters : WLAN_PHY_FRAME_STATISTICS[1]
}
struct WLAN_SECURABLE_OBJECT extends Int32 {
    static wlan_secure_permit_list := 0
    static wlan_secure_deny_list := 1
    static wlan_secure_ac_enabled := 2
    static wlan_secure_bc_scan_enabled := 3
    static wlan_secure_bss_type := 4
    static wlan_secure_show_denied := 5
    static wlan_secure_interface_properties := 6
    static wlan_secure_ihv_control := 7
    static wlan_secure_all_user_profiles_order := 8
    static wlan_secure_add_new_all_user_profiles := 9
    static wlan_secure_add_new_per_user_profiles := 10
    static wlan_secure_media_streaming_mode_enabled := 11
    static wlan_secure_current_operation_mode := 12
    static wlan_secure_get_plaintext_key := 13
    static wlan_secure_hosted_network_elevated_access := 14
    static wlan_secure_virtual_station_extensibility := 15
    static wlan_secure_wfd_elevated_access := 16
    static WLAN_SECURABLE_OBJECT_COUNT := 17
}
struct WLAN_DEVICE_SERVICE_GUID_LIST {
    dwNumberOfItems : UInt32
    dwIndex : UInt32
    DeviceService : GUID[1]
}
struct WFD_ROLE_TYPE extends Int32 {
    static WFD_ROLE_TYPE_NONE := 0
    static WFD_ROLE_TYPE_DEVICE := 1
    static WFD_ROLE_TYPE_GROUP_OWNER := 2
    static WFD_ROLE_TYPE_CLIENT := 4
    static WFD_ROLE_TYPE_MAX := 5
}
struct WFD_GROUP_ID {
    DeviceAddress : UInt8[6]
    GroupSSID : DOT11_SSID
}
struct WL_DISPLAY_PAGES extends Int32 {
    static WLConnectionPage := 0
    static WLSecurityPage := 1
    static WLAdvPage := 2
}
struct WLAN_HOSTED_NETWORK_STATE extends Int32 {
    static wlan_hosted_network_unavailable := 0
    static wlan_hosted_network_idle := 1
    static wlan_hosted_network_active := 2
}
struct WLAN_HOSTED_NETWORK_REASON extends Int32 {
    static wlan_hosted_network_reason_success := 0
    static wlan_hosted_network_reason_unspecified := 1
    static wlan_hosted_network_reason_bad_parameters := 2
    static wlan_hosted_network_reason_service_shutting_down := 3
    static wlan_hosted_network_reason_insufficient_resources := 4
    static wlan_hosted_network_reason_elevation_required := 5
    static wlan_hosted_network_reason_read_only := 6
    static wlan_hosted_network_reason_persistence_failed := 7
    static wlan_hosted_network_reason_crypt_error := 8
    static wlan_hosted_network_reason_impersonation := 9
    static wlan_hosted_network_reason_stop_before_start := 10
    static wlan_hosted_network_reason_interface_available := 11
    static wlan_hosted_network_reason_interface_unavailable := 12
    static wlan_hosted_network_reason_miniport_stopped := 13
    static wlan_hosted_network_reason_miniport_started := 14
    static wlan_hosted_network_reason_incompatible_connection_started := 15
    static wlan_hosted_network_reason_incompatible_connection_stopped := 16
    static wlan_hosted_network_reason_user_action := 17
    static wlan_hosted_network_reason_client_abort := 18
    static wlan_hosted_network_reason_ap_start_failed := 19
    static wlan_hosted_network_reason_peer_arrived := 20
    static wlan_hosted_network_reason_peer_departed := 21
    static wlan_hosted_network_reason_peer_timeout := 22
    static wlan_hosted_network_reason_gp_denied := 23
    static wlan_hosted_network_reason_service_unavailable := 24
    static wlan_hosted_network_reason_device_change := 25
    static wlan_hosted_network_reason_properties_change := 26
    static wlan_hosted_network_reason_virtual_station_blocking_use := 27
    static wlan_hosted_network_reason_service_available_on_virtual_station := 28
}
struct WLAN_HOSTED_NETWORK_PEER_AUTH_STATE extends Int32 {
    static wlan_hosted_network_peer_state_invalid := 0
    static wlan_hosted_network_peer_state_authenticated := 1
}
struct WLAN_HOSTED_NETWORK_PEER_STATE {
    PeerMacAddress : UInt8[6]
    PeerAuthState : WLAN_HOSTED_NETWORK_PEER_AUTH_STATE
}
struct WLAN_HOSTED_NETWORK_RADIO_STATE {
    dot11SoftwareRadioState : DOT11_RADIO_STATE
    dot11HardwareRadioState : DOT11_RADIO_STATE
}
struct WLAN_HOSTED_NETWORK_NOTIFICATION_CODE extends Int32 {
    static wlan_hosted_network_state_change := 4096
    static wlan_hosted_network_peer_state_change := 4097
    static wlan_hosted_network_radio_state_change := 4098
}
struct WLAN_HOSTED_NETWORK_STATE_CHANGE {
    OldState : WLAN_HOSTED_NETWORK_STATE
    NewState : WLAN_HOSTED_NETWORK_STATE
    StateChangeReason : WLAN_HOSTED_NETWORK_REASON
}
struct WLAN_HOSTED_NETWORK_DATA_PEER_STATE_CHANGE {
    OldState : WLAN_HOSTED_NETWORK_PEER_STATE
    NewState : WLAN_HOSTED_NETWORK_PEER_STATE
    PeerStateChangeReason : WLAN_HOSTED_NETWORK_REASON
}
struct WLAN_HOSTED_NETWORK_OPCODE extends Int32 {
    static wlan_hosted_network_opcode_connection_settings := 0
    static wlan_hosted_network_opcode_security_settings := 1
    static wlan_hosted_network_opcode_station_profile := 2
    static wlan_hosted_network_opcode_enable := 3
}
struct WLAN_HOSTED_NETWORK_CONNECTION_SETTINGS {
    hostedNetworkSSID : DOT11_SSID
    dwMaxNumberOfPeers : UInt32
}
struct WLAN_HOSTED_NETWORK_SECURITY_SETTINGS {
    dot11AuthAlgo : DOT11_AUTH_ALGORITHM
    dot11CipherAlgo : DOT11_CIPHER_ALGORITHM
}
struct WLAN_HOSTED_NETWORK_STATUS {
    HostedNetworkState : WLAN_HOSTED_NETWORK_STATE
    IPDeviceID : GUID
    wlanHostedNetworkBSSID : UInt8[6]
    dot11PhyType : DOT11_PHY_TYPE
    ulChannelFrequency : UInt32
    dwNumberOfPeers : UInt32
    PeerList : WLAN_HOSTED_NETWORK_PEER_STATE[1]
}
struct WFD_OPEN_SESSION_COMPLETE_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, GUID, UInt32, UInt32, "Void"]
}
struct ONEX_AUTH_IDENTITY extends Int32 {
    static OneXAuthIdentityNone := 0
    static OneXAuthIdentityMachine := 1
    static OneXAuthIdentityUser := 2
    static OneXAuthIdentityExplicitUser := 3
    static OneXAuthIdentityGuest := 4
    static OneXAuthIdentityInvalid := 5
}
struct ONEX_AUTH_STATUS extends Int32 {
    static OneXAuthNotStarted := 0
    static OneXAuthInProgress := 1
    static OneXAuthNoAuthenticatorFound := 2
    static OneXAuthSuccess := 3
    static OneXAuthFailure := 4
    static OneXAuthInvalid := 5
}
struct ONEX_REASON_CODE extends Int32 {
    static ONEX_REASON_CODE_SUCCESS := 0
    static ONEX_REASON_START := 327680
    static ONEX_UNABLE_TO_IDENTIFY_USER := 327681
    static ONEX_IDENTITY_NOT_FOUND := 327682
    static ONEX_UI_DISABLED := 327683
    static ONEX_UI_FAILURE := 327684
    static ONEX_EAP_FAILURE_RECEIVED := 327685
    static ONEX_AUTHENTICATOR_NO_LONGER_PRESENT := 327686
    static ONEX_NO_RESPONSE_TO_IDENTITY := 327687
    static ONEX_PROFILE_VERSION_NOT_SUPPORTED := 327688
    static ONEX_PROFILE_INVALID_LENGTH := 327689
    static ONEX_PROFILE_DISALLOWED_EAP_TYPE := 327690
    static ONEX_PROFILE_INVALID_EAP_TYPE_OR_FLAG := 327691
    static ONEX_PROFILE_INVALID_ONEX_FLAGS := 327692
    static ONEX_PROFILE_INVALID_TIMER_VALUE := 327693
    static ONEX_PROFILE_INVALID_SUPPLICANT_MODE := 327694
    static ONEX_PROFILE_INVALID_AUTH_MODE := 327695
    static ONEX_PROFILE_INVALID_EAP_CONNECTION_PROPERTIES := 327696
    static ONEX_UI_CANCELLED := 327697
    static ONEX_PROFILE_INVALID_EXPLICIT_CREDENTIALS := 327698
    static ONEX_PROFILE_EXPIRED_EXPLICIT_CREDENTIALS := 327699
    static ONEX_UI_NOT_PERMITTED := 327700
}
struct ONEX_NOTIFICATION_TYPE extends Int32 {
    static OneXPublicNotificationBase := 0
    static OneXNotificationTypeResultUpdate := 1
    static OneXNotificationTypeAuthRestarted := 2
    static OneXNotificationTypeEventInvalid := 3
    static OneXNumNotifications := 3
}
struct ONEX_AUTH_RESTART_REASON extends Int32 {
    static OneXRestartReasonPeerInitiated := 0
    static OneXRestartReasonMsmInitiated := 1
    static OneXRestartReasonOneXHeldStateTimeout := 2
    static OneXRestartReasonOneXAuthTimeout := 3
    static OneXRestartReasonOneXConfigurationChanged := 4
    static OneXRestartReasonOneXUserChanged := 5
    static OneXRestartReasonQuarantineStateChanged := 6
    static OneXRestartReasonAltCredsTrial := 7
    static OneXRestartReasonInvalid := 8
}
struct ONEX_VARIABLE_BLOB {
    dwSize : UInt32
    dwOffset : UInt32
}
struct ONEX_AUTH_PARAMS {
    fUpdatePending : BOOL
    oneXConnProfile : ONEX_VARIABLE_BLOB
    authIdentity : ONEX_AUTH_IDENTITY
    dwQuarantineState : UInt32
    _bitfield : UInt32
    dwSessionId : UInt32
    hUserToken : HANDLE
    OneXUserProfile : ONEX_VARIABLE_BLOB
    Identity : ONEX_VARIABLE_BLOB
    UserName : ONEX_VARIABLE_BLOB
    Domain : ONEX_VARIABLE_BLOB
}
struct ONEX_EAP_ERROR {
    dwWinError : UInt32
    type : EAP_METHOD_TYPE
    dwReasonCode : UInt32
    rootCauseGuid : GUID
    repairGuid : GUID
    helpLinkGuid : GUID
    _bitfield : UInt32
    RootCauseString : ONEX_VARIABLE_BLOB
    RepairString : ONEX_VARIABLE_BLOB
}
struct ONEX_STATUS {
    authStatus : ONEX_AUTH_STATUS
    dwReason : UInt32
    dwError : UInt32
}
struct ONEX_EAP_METHOD_BACKEND_SUPPORT extends Int32 {
    static OneXEapMethodBackendSupportUnknown := 0
    static OneXEapMethodBackendSupported := 1
    static OneXEapMethodBackendUnsupported := 2
}
struct ONEX_RESULT_UPDATE_DATA {
    oneXStatus : ONEX_STATUS
    BackendSupport : ONEX_EAP_METHOD_BACKEND_SUPPORT
    fBackendEngaged : BOOL
    _bitfield : UInt32
    authParams : ONEX_VARIABLE_BLOB
    eapError : ONEX_VARIABLE_BLOB
}
struct ONEX_USER_INFO {
    authIdentity : ONEX_AUTH_IDENTITY
    _bitfield : UInt32
    UserName : ONEX_VARIABLE_BLOB
    DomainName : ONEX_VARIABLE_BLOB
}
struct DOT11_ADHOC_CIPHER_ALGORITHM extends Int32 {
    static DOT11_ADHOC_CIPHER_ALGO_INVALID := -1
    static DOT11_ADHOC_CIPHER_ALGO_NONE := 0
    static DOT11_ADHOC_CIPHER_ALGO_CCMP := 4
    static DOT11_ADHOC_CIPHER_ALGO_WEP := 257
}
struct DOT11_ADHOC_AUTH_ALGORITHM extends Int32 {
    static DOT11_ADHOC_AUTH_ALGO_INVALID := -1
    static DOT11_ADHOC_AUTH_ALGO_80211_OPEN := 1
    static DOT11_ADHOC_AUTH_ALGO_RSNA_PSK := 7
}
struct DOT11_ADHOC_NETWORK_CONNECTION_STATUS extends Int32 {
    static DOT11_ADHOC_NETWORK_CONNECTION_STATUS_INVALID := 0
    static DOT11_ADHOC_NETWORK_CONNECTION_STATUS_DISCONNECTED := 11
    static DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTING := 12
    static DOT11_ADHOC_NETWORK_CONNECTION_STATUS_CONNECTED := 13
    static DOT11_ADHOC_NETWORK_CONNECTION_STATUS_FORMED := 14
}
struct DOT11_ADHOC_CONNECT_FAIL_REASON extends Int32 {
    static DOT11_ADHOC_CONNECT_FAIL_DOMAIN_MISMATCH := 0
    static DOT11_ADHOC_CONNECT_FAIL_PASSPHRASE_MISMATCH := 1
    static DOT11_ADHOC_CONNECT_FAIL_OTHER := 2
}
struct IDot11AdHocManager extends IUnknown {
    static IID := "{8F10CC26-CF0D-42A0-ACBE-E2DE7007384D}"
    CreateNetwork(Name, Password, GeographicalId, pInterface, pSecurity, pContextGuid, pIAdHoc)
      => ComCall(3, this.p, "Str", Name, "Str", Password, Int32, GeographicalId, IDot11AdHocInterface, pInterface, IDot11AdHocSecuritySettings, pSecurity, GUID.Ptr, pContextGuid, IDot11AdHocNetwork.Ptr, pIAdHoc)
    CommitCreatedNetwork(pIAdHoc, fSaveProfile, fMakeSavedProfileUserSpecific)
      => ComCall(4, this.p, IDot11AdHocNetwork, pIAdHoc, BOOLEAN, fSaveProfile, BOOLEAN, fMakeSavedProfileUserSpecific)
    GetIEnumDot11AdHocNetworks(pContextGuid, ppEnum)
      => ComCall(5, this.p, GUID.Ptr, pContextGuid, IEnumDot11AdHocNetworks.Ptr, ppEnum)
    GetIEnumDot11AdHocInterfaces(ppEnum)
      => ComCall(6, this.p, IEnumDot11AdHocInterfaces.Ptr, ppEnum)
    GetNetwork(NetworkSignature, pNetwork)
      => ComCall(7, this.p, GUID.Ptr, NetworkSignature, IDot11AdHocNetwork.Ptr, pNetwork)
}
struct IDot11AdHocManagerNotificationSink extends IUnknown {
    static IID := "{8F10CC27-CF0D-42A0-ACBE-E2DE7007384D}"
    OnNetworkAdd(pIAdHocNetwork)
      => ComCall(3, this.p, IDot11AdHocNetwork, pIAdHocNetwork)
    OnNetworkRemove(Signature)
      => ComCall(4, this.p, GUID.Ptr, Signature)
    OnInterfaceAdd(pIAdHocInterface)
      => ComCall(5, this.p, IDot11AdHocInterface, pIAdHocInterface)
    OnInterfaceRemove(Signature)
      => ComCall(6, this.p, GUID.Ptr, Signature)
}
struct IEnumDot11AdHocNetworks extends IUnknown {
    static IID := "{8F10CC28-CF0D-42A0-ACBE-E2DE7007384D}"
    Next(rgElt, pcEltFetched)
      => ComCall(3, this.p, UInt32, rgElt.Length, IDot11AdHocNetwork.Ptr, rgElt, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDot11AdHocNetworks.Ptr, ppEnum)
}
struct IDot11AdHocNetwork extends IUnknown {
    static IID := "{8F10CC29-CF0D-42A0-ACBE-E2DE7007384D}"
    GetStatus(eStatus)
      => ComCall(3, this.p, DOT11_ADHOC_NETWORK_CONNECTION_STATUS.Ptr, eStatus)
    GetSSID(ppszwSSID)
      => ComCall(4, this.p, PWSTR.Ptr, ppszwSSID)
    HasProfile(pf11d)
      => ComCall(5, this.p, UInt8.Ptr, pf11d)
    GetProfileName(ppszwProfileName)
      => ComCall(6, this.p, PWSTR.Ptr, ppszwProfileName)
    DeleteProfile()
      => ComCall(7, this.p)
    GetSignalQuality(puStrengthValue, puStrengthMax)
      => ComCall(8, this.p, UInt32.Ptr, puStrengthValue, UInt32.Ptr, puStrengthMax)
    GetSecuritySetting(pAdHocSecuritySetting)
      => ComCall(9, this.p, IDot11AdHocSecuritySettings.Ptr, pAdHocSecuritySetting)
    GetContextGuid(pContextGuid)
      => ComCall(10, this.p, GUID.Ptr, pContextGuid)
    GetSignature(pSignature)
      => ComCall(11, this.p, GUID.Ptr, pSignature)
    GetInterface(pAdHocInterface)
      => ComCall(12, this.p, IDot11AdHocInterface.Ptr, pAdHocInterface)
    Connect(Passphrase, GeographicalId, fSaveProfile, fMakeSavedProfileUserSpecific)
      => ComCall(13, this.p, "Str", Passphrase, Int32, GeographicalId, BOOLEAN, fSaveProfile, BOOLEAN, fMakeSavedProfileUserSpecific)
    Disconnect()
      => ComCall(14, this.p)
}
struct IDot11AdHocNetworkNotificationSink extends IUnknown {
    static IID := "{8F10CC2A-CF0D-42A0-ACBE-E2DE7007384D}"
    OnStatusChange(eStatus)
      => ComCall(3, this.p, DOT11_ADHOC_NETWORK_CONNECTION_STATUS, eStatus)
    OnConnectFail(eFailReason)
      => ComCall(4, this.p, DOT11_ADHOC_CONNECT_FAIL_REASON, eFailReason)
}
struct IDot11AdHocInterface extends IUnknown {
    static IID := "{8F10CC2B-CF0D-42A0-ACBE-E2DE7007384D}"
    GetDeviceSignature(pSignature)
      => ComCall(3, this.p, GUID.Ptr, pSignature)
    GetFriendlyName(ppszName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszName)
    IsDot11d(pf11d)
      => ComCall(5, this.p, UInt8.Ptr, pf11d)
    IsAdHocCapable(pfAdHocCapable)
      => ComCall(6, this.p, UInt8.Ptr, pfAdHocCapable)
    IsRadioOn(pfIsRadioOn)
      => ComCall(7, this.p, UInt8.Ptr, pfIsRadioOn)
    GetActiveNetwork(ppNetwork)
      => ComCall(8, this.p, IDot11AdHocNetwork.Ptr, ppNetwork)
    GetIEnumSecuritySettings(ppEnum)
      => ComCall(9, this.p, IEnumDot11AdHocSecuritySettings.Ptr, ppEnum)
    GetIEnumDot11AdHocNetworks(pFilterGuid, ppEnum)
      => ComCall(10, this.p, GUID.Ptr, pFilterGuid, IEnumDot11AdHocNetworks.Ptr, ppEnum)
    GetStatus(pState)
      => ComCall(11, this.p, DOT11_ADHOC_NETWORK_CONNECTION_STATUS.Ptr, pState)
}
struct IEnumDot11AdHocInterfaces extends IUnknown {
    static IID := "{8F10CC2C-CF0D-42A0-ACBE-E2DE7007384D}"
    Next(rgElt, pcEltFetched)
      => ComCall(3, this.p, UInt32, rgElt.Length, IDot11AdHocInterface.Ptr, rgElt, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDot11AdHocInterfaces.Ptr, ppEnum)
}
struct IEnumDot11AdHocSecuritySettings extends IUnknown {
    static IID := "{8F10CC2D-CF0D-42A0-ACBE-E2DE7007384D}"
    Next(rgElt, pcEltFetched)
      => ComCall(3, this.p, UInt32, rgElt.Length, IDot11AdHocSecuritySettings.Ptr, rgElt, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDot11AdHocSecuritySettings.Ptr, ppEnum)
}
struct IDot11AdHocSecuritySettings extends IUnknown {
    static IID := "{8F10CC2E-CF0D-42A0-ACBE-E2DE7007384D}"
    GetDot11AuthAlgorithm(pAuth)
      => ComCall(3, this.p, DOT11_ADHOC_AUTH_ALGORITHM.Ptr, pAuth)
    GetDot11CipherAlgorithm(pCipher)
      => ComCall(4, this.p, DOT11_ADHOC_CIPHER_ALGORITHM.Ptr, pCipher)
}
struct IDot11AdHocInterfaceNotificationSink extends IUnknown {
    static IID := "{8F10CC2F-CF0D-42A0-ACBE-E2DE7007384D}"
    OnConnectionStatusChange(eStatus)
      => ComCall(3, this.p, DOT11_ADHOC_NETWORK_CONNECTION_STATUS, eStatus)
}
struct DOT11_ADAPTER {
    gAdapterId : GUID
    pszDescription : PWSTR
    Dot11CurrentOpMode : DOT11_CURRENT_OPERATION_MODE
}
struct DOT11_BSS_LIST {
    uNumOfBytes : UInt32
    pucBuffer : UInt8.Ptr
}
struct DOT11_PORT_STATE {
    PeerMacAddress : UInt8[6]
    uSessionId : UInt32
    bPortControlled : BOOL
    bPortAuthorized : BOOL
}
struct DOT11_SECURITY_PACKET_HEADER {
    PeerMac : UInt8[6]
    usEtherType : UInt16
    Data : UInt8[1]
}
struct DOT11_MSSECURITY_SETTINGS {
    dot11AuthAlgorithm : DOT11_AUTH_ALGORITHM
    dot11CipherAlgorithm : DOT11_CIPHER_ALGORITHM
    fOneXEnabled : BOOL
    eapMethodType : EAP_METHOD_TYPE
    dwEapConnectionDataLen : UInt32
    pEapConnectionData : UInt8.Ptr
}
struct DOT11EXT_IHV_SSID_LIST {
    ulCount : UInt32
    SSIDs : DOT11_SSID[1]
}
struct DOT11EXT_IHV_PROFILE_PARAMS {
    pSsidList : DOT11EXT_IHV_SSID_LIST.Ptr
    BssType : DOT11_BSS_TYPE
    pMSSecuritySettings : DOT11_MSSECURITY_SETTINGS.Ptr
}
struct DOT11EXT_IHV_PARAMS {
    dot11ExtIhvProfileParams : DOT11EXT_IHV_PROFILE_PARAMS
    wstrProfileName : UInt16[256]
    dwProfileTypeFlags : UInt32
    interfaceGuid : GUID
}
struct DOT11_IHV_VERSION_INFO {
    dwVerMin : UInt32
    dwVerMax : UInt32
}
struct DOT11EXT_IHV_CONNECTION_PHASE extends Int32 {
    static connection_phase_any := 0
    static connection_phase_initial_connection := 1
    static connection_phase_post_l3_connection := 2
}
struct DOT11EXT_IHV_UI_REQUEST {
    dwSessionId : UInt32
    guidUIRequest : GUID
    UIPageClsid : GUID
    dwByteCount : UInt32
    pvUIRequest : UInt8.Ptr
}
struct DOT11_MSONEX_RESULT extends Int32 {
    static DOT11_MSONEX_SUCCESS := 0
    static DOT11_MSONEX_FAILURE := 1
    static DOT11_MSONEX_IN_PROGRESS := 2
}
struct DOT11_EAP_RESULT {
    dwFailureReasonCode : UInt32
    pAttribArray : EAP_ATTRIBUTES.Ptr
}
struct DOT11_MSONEX_RESULT_PARAMS {
    Dot11OnexAuthStatus : ONEX_AUTH_STATUS
    Dot11OneXReasonCode : ONEX_REASON_CODE
    pbMPPESendKey : UInt8.Ptr
    dwMPPESendKeyLen : UInt32
    pbMPPERecvKey : UInt8.Ptr
    dwMPPERecvKeyLen : UInt32
    pDot11EapResult : DOT11_EAP_RESULT.Ptr
}
struct DOT11EXT_IHV_CONNECTIVITY_PROFILE {
    pszXmlFragmentIhvConnectivity : PWSTR
}
struct DOT11EXT_IHV_SECURITY_PROFILE {
    pszXmlFragmentIhvSecurity : PWSTR
    bUseMSOnex : BOOL
}
struct DOT11EXT_IHV_DISCOVERY_PROFILE {
    IhvConnectivityProfile : DOT11EXT_IHV_CONNECTIVITY_PROFILE
    IhvSecurityProfile : DOT11EXT_IHV_SECURITY_PROFILE
}
struct DOT11EXT_IHV_DISCOVERY_PROFILE_LIST {
    dwCount : UInt32
    pIhvDiscoveryProfiles : DOT11EXT_IHV_DISCOVERY_PROFILE.Ptr
}
struct DOT11EXT_IHV_INDICATION_TYPE extends Int32 {
    static IndicationTypeNicSpecificNotification := 0
    static IndicationTypePmkidCandidateList := 1
    static IndicationTypeTkipMicFailure := 2
    static IndicationTypePhyStateChange := 3
    static IndicationTypeLinkQuality := 4
}
struct DOT11EXT_VIRTUAL_STATION_AP_PROPERTY {
    dot11SSID : DOT11_SSID
    dot11AuthAlgo : DOT11_AUTH_ALGORITHM
    dot11CipherAlgo : DOT11_CIPHER_ALGORITHM
    bIsPassPhrase : BOOL
    dwKeyLength : UInt32
    ucKeyData : UInt8[64]
}
struct WDIAG_IHV_WLAN_ID {
    strProfileName : UInt16[256]
    Ssid : DOT11_SSID
    BssType : DOT11_BSS_TYPE
    dwFlags : UInt32
    dwReasonCode : UInt32
}
struct DOT11EXT_ALLOCATE_BUFFER extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr.Ptr, UInt32]
}
struct DOT11EXT_FREE_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct DOT11EXT_SET_PROFILE_CUSTOM_USER_DATA extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32, Struct.Ptr, UInt32]
}
struct DOT11EXT_GET_PROFILE_CUSTOM_USER_DATA extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32.Ptr, Struct.Ptr.Ptr, UInt32]
}
struct DOT11EXT_SET_CURRENT_PROFILE extends FunctionPointer {
    static Types := [HANDLE, HANDLE, DOT11EXT_IHV_CONNECTIVITY_PROFILE.Ptr, DOT11EXT_IHV_SECURITY_PROFILE.Ptr, UInt32]
}
struct DOT11EXT_SEND_UI_REQUEST extends FunctionPointer {
    static Types := [HANDLE, DOT11EXT_IHV_UI_REQUEST.Ptr, UInt32]
}
struct DOT11EXT_PRE_ASSOCIATE_COMPLETION extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32, UInt32]
}
struct DOT11EXT_POST_ASSOCIATE_COMPLETION extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt8.Ptr.Ptr, UInt32, UInt32, UInt32]
}
struct DOT11EXT_SEND_NOTIFICATION extends FunctionPointer {
    static Types := [HANDLE, L2_NOTIFICATION_DATA.Ptr, UInt32]
}
struct DOT11EXT_SEND_PACKET extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, HANDLE, UInt32]
}
struct DOT11EXT_SET_ETHERTYPE_HANDLING extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, DOT11_PRIVACY_EXEMPTION.Ptr, UInt32, UInt16.Ptr, UInt32]
}
struct DOT11EXT_SET_AUTH_ALGORITHM extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32]
}
struct DOT11EXT_SET_UNICAST_CIPHER_ALGORITHM extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32]
}
struct DOT11EXT_SET_MULTICAST_CIPHER_ALGORITHM extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32]
}
struct DOT11EXT_SET_DEFAULT_KEY extends FunctionPointer {
    static Types := [HANDLE, DOT11_CIPHER_DEFAULT_KEY_VALUE.Ptr, DOT11_DIRECTION, UInt32]
}
struct DOT11EXT_SET_KEY_MAPPING_KEY extends FunctionPointer {
    static Types := [HANDLE, DOT11_CIPHER_KEY_MAPPING_KEY_VALUE.Ptr, UInt32]
}
struct DOT11EXT_SET_DEFAULT_KEY_ID extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32]
}
struct DOT11EXT_SET_EXCLUDE_UNENCRYPTED extends FunctionPointer {
    static Types := [HANDLE, BOOL, UInt32]
}
struct DOT11EXT_NIC_SPECIFIC_EXTENSION extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, UInt32.Ptr, Struct.Ptr, UInt32]
}
struct DOT11EXT_ONEX_START extends FunctionPointer {
    static Types := [HANDLE, EAP_ATTRIBUTES.Ptr, UInt32]
}
struct DOT11EXT_ONEX_STOP extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct DOT11EXT_PROCESS_ONEX_PACKET extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, UInt32]
}
struct DOT11EXT_REQUEST_VIRTUAL_STATION extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32]
}
struct DOT11EXT_RELEASE_VIRTUAL_STATION extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32]
}
struct DOT11EXT_QUERY_VIRTUAL_STATION_PROPERTIES extends FunctionPointer {
    static Types := [HANDLE, BOOL.Ptr, GUID.Ptr, Struct.Ptr, UInt32]
}
struct DOT11EXT_SET_VIRTUAL_STATION_AP_PROPERTIES extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, DOT11EXT_VIRTUAL_STATION_AP_PROPERTY.Ptr, Struct.Ptr, UInt32]
}
struct DOT11EXTIHV_GET_VERSION_INFO extends FunctionPointer {
    static Types := [DOT11_IHV_VERSION_INFO.Ptr, UInt32]
}
struct DOT11EXTIHV_INIT_SERVICE extends FunctionPointer {
    static Types := [UInt32, DOT11EXT_APIS.Ptr, Struct.Ptr, DOT11EXT_IHV_HANDLERS.Ptr, UInt32]
}
struct DOT11EXTIHV_INIT_VIRTUAL_STATION extends FunctionPointer {
    static Types := [DOT11EXT_VIRTUAL_STATION_APIS.Ptr, Struct.Ptr, UInt32]
}
struct DOT11EXTIHV_DEINIT_SERVICE extends FunctionPointer {
    static Types := ["Void"]
}
struct DOT11EXTIHV_INIT_ADAPTER extends FunctionPointer {
    static Types := [DOT11_ADAPTER.Ptr, HANDLE, HANDLE.Ptr, UInt32]
}
struct DOT11EXTIHV_DEINIT_ADAPTER extends FunctionPointer {
    static Types := [HANDLE, "Void"]
}
struct DOT11EXTIHV_PERFORM_PRE_ASSOCIATE extends FunctionPointer {
    static Types := [HANDLE, HANDLE, DOT11EXT_IHV_PROFILE_PARAMS.Ptr, DOT11EXT_IHV_CONNECTIVITY_PROFILE.Ptr, DOT11EXT_IHV_SECURITY_PROFILE.Ptr, DOT11_BSS_LIST.Ptr, UInt32.Ptr, UInt32]
}
struct DOT11EXTIHV_ADAPTER_RESET extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct DOT11EXTIHV_PERFORM_POST_ASSOCIATE extends FunctionPointer {
    static Types := [HANDLE, HANDLE, DOT11_PORT_STATE.Ptr, UInt32, DOT11_ASSOCIATION_COMPLETION_PARAMETERS.Ptr, UInt32]
}
struct DOT11EXTIHV_STOP_POST_ASSOCIATE extends FunctionPointer {
    static Types := [HANDLE, UInt8.Ptr.Ptr, UInt32, UInt32]
}
struct DOT11EXTIHV_VALIDATE_PROFILE extends FunctionPointer {
    static Types := [HANDLE, DOT11EXT_IHV_PROFILE_PARAMS.Ptr, DOT11EXT_IHV_CONNECTIVITY_PROFILE.Ptr, DOT11EXT_IHV_SECURITY_PROFILE.Ptr, UInt32.Ptr, UInt32]
}
struct DOT11EXTIHV_PERFORM_CAPABILITY_MATCH extends FunctionPointer {
    static Types := [HANDLE, DOT11EXT_IHV_PROFILE_PARAMS.Ptr, DOT11EXT_IHV_CONNECTIVITY_PROFILE.Ptr, DOT11EXT_IHV_SECURITY_PROFILE.Ptr, DOT11_BSS_LIST.Ptr, UInt32.Ptr, UInt32]
}
struct DOT11EXTIHV_CREATE_DISCOVERY_PROFILES extends FunctionPointer {
    static Types := [HANDLE, BOOL, DOT11EXT_IHV_PROFILE_PARAMS.Ptr, DOT11_BSS_LIST.Ptr, DOT11EXT_IHV_DISCOVERY_PROFILE_LIST.Ptr, UInt32.Ptr, UInt32]
}
struct DOT11EXTIHV_PROCESS_SESSION_CHANGE extends FunctionPointer {
    static Types := [UInt32, WTSSESSION_NOTIFICATION.Ptr, UInt32]
}
struct DOT11EXTIHV_RECEIVE_INDICATION extends FunctionPointer {
    static Types := [HANDLE, DOT11EXT_IHV_INDICATION_TYPE, UInt32, Struct.Ptr, UInt32]
}
struct DOT11EXTIHV_RECEIVE_PACKET extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, UInt32]
}
struct DOT11EXTIHV_SEND_PACKET_COMPLETION extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct DOT11EXTIHV_IS_UI_REQUEST_PENDING extends FunctionPointer {
    static Types := [GUID, BOOL.Ptr, UInt32]
}
struct DOT11EXTIHV_PROCESS_UI_RESPONSE extends FunctionPointer {
    static Types := [GUID, UInt32, Struct.Ptr, UInt32]
}
struct DOT11EXTIHV_QUERY_UI_REQUEST extends FunctionPointer {
    static Types := [HANDLE, DOT11EXT_IHV_CONNECTION_PHASE, DOT11EXT_IHV_UI_REQUEST.Ptr.Ptr, UInt32]
}
struct DOT11EXTIHV_ONEX_INDICATE_RESULT extends FunctionPointer {
    static Types := [HANDLE, DOT11_MSONEX_RESULT, DOT11_MSONEX_RESULT_PARAMS.Ptr, UInt32]
}
struct DOT11EXTIHV_CONTROL extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32.Ptr, UInt32]
}
struct DOT11EXT_APIS {
    Dot11ExtAllocateBuffer : DOT11EXT_ALLOCATE_BUFFER
    Dot11ExtFreeBuffer : DOT11EXT_FREE_BUFFER
    Dot11ExtSetProfileCustomUserData : DOT11EXT_SET_PROFILE_CUSTOM_USER_DATA
    Dot11ExtGetProfileCustomUserData : DOT11EXT_GET_PROFILE_CUSTOM_USER_DATA
    Dot11ExtSetCurrentProfile : DOT11EXT_SET_CURRENT_PROFILE
    Dot11ExtSendUIRequest : DOT11EXT_SEND_UI_REQUEST
    Dot11ExtPreAssociateCompletion : DOT11EXT_PRE_ASSOCIATE_COMPLETION
    Dot11ExtPostAssociateCompletion : DOT11EXT_POST_ASSOCIATE_COMPLETION
    Dot11ExtSendNotification : DOT11EXT_SEND_NOTIFICATION
    Dot11ExtSendPacket : DOT11EXT_SEND_PACKET
    Dot11ExtSetEtherTypeHandling : DOT11EXT_SET_ETHERTYPE_HANDLING
    Dot11ExtSetAuthAlgorithm : DOT11EXT_SET_AUTH_ALGORITHM
    Dot11ExtSetUnicastCipherAlgorithm : DOT11EXT_SET_UNICAST_CIPHER_ALGORITHM
    Dot11ExtSetMulticastCipherAlgorithm : DOT11EXT_SET_MULTICAST_CIPHER_ALGORITHM
    Dot11ExtSetDefaultKey : DOT11EXT_SET_DEFAULT_KEY
    Dot11ExtSetKeyMappingKey : DOT11EXT_SET_KEY_MAPPING_KEY
    Dot11ExtSetDefaultKeyId : DOT11EXT_SET_DEFAULT_KEY_ID
    Dot11ExtNicSpecificExtension : DOT11EXT_NIC_SPECIFIC_EXTENSION
    Dot11ExtSetExcludeUnencrypted : DOT11EXT_SET_EXCLUDE_UNENCRYPTED
    Dot11ExtStartOneX : DOT11EXT_ONEX_START
    Dot11ExtStopOneX : DOT11EXT_ONEX_STOP
    Dot11ExtProcessSecurityPacket : DOT11EXT_PROCESS_ONEX_PACKET
}
struct DOT11EXT_IHV_HANDLERS {
    Dot11ExtIhvDeinitService : DOT11EXTIHV_DEINIT_SERVICE
    Dot11ExtIhvInitAdapter : DOT11EXTIHV_INIT_ADAPTER
    Dot11ExtIhvDeinitAdapter : DOT11EXTIHV_DEINIT_ADAPTER
    Dot11ExtIhvPerformPreAssociate : DOT11EXTIHV_PERFORM_PRE_ASSOCIATE
    Dot11ExtIhvAdapterReset : DOT11EXTIHV_ADAPTER_RESET
    Dot11ExtIhvPerformPostAssociate : DOT11EXTIHV_PERFORM_POST_ASSOCIATE
    Dot11ExtIhvStopPostAssociate : DOT11EXTIHV_STOP_POST_ASSOCIATE
    Dot11ExtIhvValidateProfile : DOT11EXTIHV_VALIDATE_PROFILE
    Dot11ExtIhvPerformCapabilityMatch : DOT11EXTIHV_PERFORM_CAPABILITY_MATCH
    Dot11ExtIhvCreateDiscoveryProfiles : DOT11EXTIHV_CREATE_DISCOVERY_PROFILES
    Dot11ExtIhvProcessSessionChange : DOT11EXTIHV_PROCESS_SESSION_CHANGE
    Dot11ExtIhvReceiveIndication : DOT11EXTIHV_RECEIVE_INDICATION
    Dot11ExtIhvReceivePacket : DOT11EXTIHV_RECEIVE_PACKET
    Dot11ExtIhvSendPacketCompletion : DOT11EXTIHV_SEND_PACKET_COMPLETION
    Dot11ExtIhvIsUIRequestPending : DOT11EXTIHV_IS_UI_REQUEST_PENDING
    Dot11ExtIhvProcessUIResponse : DOT11EXTIHV_PROCESS_UI_RESPONSE
    Dot11ExtIhvQueryUIRequest : DOT11EXTIHV_QUERY_UI_REQUEST
    Dot11ExtIhvOnexIndicateResult : DOT11EXTIHV_ONEX_INDICATE_RESULT
    Dot11ExtIhvControl : DOT11EXTIHV_CONTROL
}
struct DOT11EXT_VIRTUAL_STATION_APIS {
    Dot11ExtRequestVirtualStation : DOT11EXT_REQUEST_VIRTUAL_STATION
    Dot11ExtReleaseVirtualStation : DOT11EXT_RELEASE_VIRTUAL_STATION
    Dot11ExtQueryVirtualStationProperties : DOT11EXT_QUERY_VIRTUAL_STATION_PROPERTIES
    Dot11ExtSetVirtualStationAPProperties : DOT11EXT_SET_VIRTUAL_STATION_AP_PROPERTIES
}
