#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct WCN_ATTRIBUTE_TYPE extends Int32 {
    static WCN_TYPE_AP_CHANNEL := 0
    static WCN_TYPE_ASSOCIATION_STATE := 1
    static WCN_TYPE_AUTHENTICATION_TYPE := 2
    static WCN_TYPE_AUTHENTICATION_TYPE_FLAGS := 3
    static WCN_TYPE_AUTHENTICATOR := 4
    static WCN_TYPE_CONFIG_METHODS := 5
    static WCN_TYPE_CONFIGURATION_ERROR := 6
    static WCN_TYPE_CONFIRMATION_URL4 := 7
    static WCN_TYPE_CONFIRMATION_URL6 := 8
    static WCN_TYPE_CONNECTION_TYPE := 9
    static WCN_TYPE_CONNECTION_TYPE_FLAGS := 10
    static WCN_TYPE_CREDENTIAL := 11
    static WCN_TYPE_DEVICE_NAME := 12
    static WCN_TYPE_DEVICE_PASSWORD_ID := 13
    static WCN_TYPE_E_HASH1 := 14
    static WCN_TYPE_E_HASH2 := 15
    static WCN_TYPE_E_SNONCE1 := 16
    static WCN_TYPE_E_SNONCE2 := 17
    static WCN_TYPE_ENCRYPTED_SETTINGS := 18
    static WCN_TYPE_ENCRYPTION_TYPE := 19
    static WCN_TYPE_ENCRYPTION_TYPE_FLAGS := 20
    static WCN_TYPE_ENROLLEE_NONCE := 21
    static WCN_TYPE_FEATURE_ID := 22
    static WCN_TYPE_IDENTITY := 23
    static WCN_TYPE_IDENTITY_PROOF := 24
    static WCN_TYPE_KEY_WRAP_AUTHENTICATOR := 25
    static WCN_TYPE_KEY_IDENTIFIER := 26
    static WCN_TYPE_MAC_ADDRESS := 27
    static WCN_TYPE_MANUFACTURER := 28
    static WCN_TYPE_MESSAGE_TYPE := 29
    static WCN_TYPE_MODEL_NAME := 30
    static WCN_TYPE_MODEL_NUMBER := 31
    static WCN_TYPE_NETWORK_INDEX := 32
    static WCN_TYPE_NETWORK_KEY := 33
    static WCN_TYPE_NETWORK_KEY_INDEX := 34
    static WCN_TYPE_NEW_DEVICE_NAME := 35
    static WCN_TYPE_NEW_PASSWORD := 36
    static WCN_TYPE_OOB_DEVICE_PASSWORD := 37
    static WCN_TYPE_OS_VERSION := 38
    static WCN_TYPE_POWER_LEVEL := 39
    static WCN_TYPE_PSK_CURRENT := 40
    static WCN_TYPE_PSK_MAX := 41
    static WCN_TYPE_PUBLIC_KEY := 42
    static WCN_TYPE_RADIO_ENABLED := 43
    static WCN_TYPE_REBOOT := 44
    static WCN_TYPE_REGISTRAR_CURRENT := 45
    static WCN_TYPE_REGISTRAR_ESTABLISHED := 46
    static WCN_TYPE_REGISTRAR_LIST := 47
    static WCN_TYPE_REGISTRAR_MAX := 48
    static WCN_TYPE_REGISTRAR_NONCE := 49
    static WCN_TYPE_REQUEST_TYPE := 50
    static WCN_TYPE_RESPONSE_TYPE := 51
    static WCN_TYPE_RF_BANDS := 52
    static WCN_TYPE_R_HASH1 := 53
    static WCN_TYPE_R_HASH2 := 54
    static WCN_TYPE_R_SNONCE1 := 55
    static WCN_TYPE_R_SNONCE2 := 56
    static WCN_TYPE_SELECTED_REGISTRAR := 57
    static WCN_TYPE_SERIAL_NUMBER := 58
    static WCN_TYPE_WI_FI_PROTECTED_SETUP_STATE := 59
    static WCN_TYPE_SSID := 60
    static WCN_TYPE_TOTAL_NETWORKS := 61
    static WCN_TYPE_UUID_E := 62
    static WCN_TYPE_UUID_R := 63
    static WCN_TYPE_VENDOR_EXTENSION := 64
    static WCN_TYPE_VERSION := 65
    static WCN_TYPE_X_509_CERTIFICATE_REQUEST := 66
    static WCN_TYPE_X_509_CERTIFICATE := 67
    static WCN_TYPE_EAP_IDENTITY := 68
    static WCN_TYPE_MESSAGE_COUNTER := 69
    static WCN_TYPE_PUBLIC_KEY_HASH := 70
    static WCN_TYPE_REKEY_KEY := 71
    static WCN_TYPE_KEY_LIFETIME := 72
    static WCN_TYPE_PERMITTED_CONFIG_METHODS := 73
    static WCN_TYPE_SELECTED_REGISTRAR_CONFIG_METHODS := 74
    static WCN_TYPE_PRIMARY_DEVICE_TYPE := 75
    static WCN_TYPE_SECONDARY_DEVICE_TYPE_LIST := 76
    static WCN_TYPE_PORTABLE_DEVICE := 77
    static WCN_TYPE_AP_SETUP_LOCKED := 78
    static WCN_TYPE_APPLICATION_EXTENSION := 79
    static WCN_TYPE_EAP_TYPE := 80
    static WCN_TYPE_INITIALIZATION_VECTOR := 81
    static WCN_TYPE_KEY_PROVIDED_AUTOMATICALLY := 82
    static WCN_TYPE_802_1X_ENABLED := 83
    static WCN_TYPE_APPSESSIONKEY := 84
    static WCN_TYPE_WEPTRANSMITKEY := 85
    static WCN_TYPE_UUID := 86
    static WCN_TYPE_PRIMARY_DEVICE_TYPE_CATEGORY := 87
    static WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY_OUI := 88
    static WCN_TYPE_PRIMARY_DEVICE_TYPE_SUBCATEGORY := 89
    static WCN_TYPE_CURRENT_SSID := 90
    static WCN_TYPE_BSSID := 91
    static WCN_TYPE_DOT11_MAC_ADDRESS := 92
    static WCN_TYPE_AUTHORIZED_MACS := 93
    static WCN_TYPE_NETWORK_KEY_SHAREABLE := 94
    static WCN_TYPE_REQUEST_TO_ENROLL := 95
    static WCN_TYPE_REQUESTED_DEVICE_TYPE := 96
    static WCN_TYPE_SETTINGS_DELAY_TIME := 97
    static WCN_TYPE_VERSION2 := 98
    static WCN_TYPE_VENDOR_EXTENSION_WFA := 99
    static WCN_NUM_ATTRIBUTE_TYPES := 100
}
struct WCN_VALUE_TYPE_VERSION extends Int32 {
    static WCN_VALUE_VERSION_1_0 := 16
    static WCN_VALUE_VERSION_2_0 := 32
}
struct WCN_VALUE_TYPE_BOOLEAN extends Int32 {
    static WCN_VALUE_FALSE := 0
    static WCN_VALUE_TRUE := 1
}
struct WCN_VALUE_TYPE_ASSOCIATION_STATE extends Int32 {
    static WCN_VALUE_AS_NOT_ASSOCIATED := 0
    static WCN_VALUE_AS_CONNECTION_SUCCESS := 1
    static WCN_VALUE_AS_CONFIGURATION_FAILURE := 2
    static WCN_VALUE_AS_ASSOCIATION_FAILURE := 3
    static WCN_VALUE_AS_IP_FAILURE := 4
}
struct WCN_VALUE_TYPE_AUTHENTICATION_TYPE extends Int32 {
    static WCN_VALUE_AT_OPEN := 1
    static WCN_VALUE_AT_WPAPSK := 2
    static WCN_VALUE_AT_SHARED := 4
    static WCN_VALUE_AT_WPA := 8
    static WCN_VALUE_AT_WPA2 := 16
    static WCN_VALUE_AT_WPA2PSK := 32
    static WCN_VALUE_AT_WPAWPA2PSK_MIXED := 34
}
struct WCN_VALUE_TYPE_CONFIG_METHODS extends Int32 {
    static WCN_VALUE_CM_USBA := 1
    static WCN_VALUE_CM_ETHERNET := 2
    static WCN_VALUE_CM_LABEL := 4
    static WCN_VALUE_CM_DISPLAY := 8
    static WCN_VALUE_CM_EXTERNAL_NFC := 16
    static WCN_VALUE_CM_INTEGRATED_NFC := 32
    static WCN_VALUE_CM_NFC_INTERFACE := 64
    static WCN_VALUE_CM_PUSHBUTTON := 128
    static WCN_VALUE_CM_KEYPAD := 256
    static WCN_VALUE_CM_VIRT_PUSHBUTTON := 640
    static WCN_VALUE_CM_PHYS_PUSHBUTTON := 1152
    static WCN_VALUE_CM_VIRT_DISPLAY := 8200
    static WCN_VALUE_CM_PHYS_DISPLAY := 16392
}
struct WCN_VALUE_TYPE_CONFIGURATION_ERROR extends Int32 {
    static WCN_VALUE_CE_NO_ERROR := 0
    static WCN_VALUE_CE_OOB_INTERFACE_READ_ERROR := 1
    static WCN_VALUE_CE_DECRYPTION_CRC_FAILURE := 2
    static WCN_VALUE_CE_2_4_CHANNEL_NOT_SUPPORTED := 3
    static WCN_VALUE_CE_5_0_CHANNEL_NOT_SUPPORTED := 4
    static WCN_VALUE_CE_SIGNAL_TOO_WEAK := 5
    static WCN_VALUE_CE_NETWORK_AUTHENTICATION_FAILURE := 6
    static WCN_VALUE_CE_NETWORK_ASSOCIATION_FAILURE := 7
    static WCN_VALUE_CE_NO_DHCP_RESPONSE := 8
    static WCN_VALUE_CE_FAILED_DHCP_CONFIG := 9
    static WCN_VALUE_CE_IP_ADDRESS_CONFLICT := 10
    static WCN_VALUE_CE_COULD_NOT_CONNECT_TO_REGISTRAR := 11
    static WCN_VALUE_CE_MULTIPLE_PBC_SESSIONS_DETECTED := 12
    static WCN_VALUE_CE_ROGUE_ACTIVITY_SUSPECTED := 13
    static WCN_VALUE_CE_DEVICE_BUSY := 14
    static WCN_VALUE_CE_SETUP_LOCKED := 15
    static WCN_VALUE_CE_MESSAGE_TIMEOUT := 16
    static WCN_VALUE_CE_REGISTRATION_SESSION_TIMEOUT := 17
    static WCN_VALUE_CE_DEVICE_PASSWORD_AUTH_FAILURE := 18
}
struct WCN_VALUE_TYPE_CONNECTION_TYPE extends Int32 {
    static WCN_VALUE_CT_ESS := 1
    static WCN_VALUE_CT_IBSS := 2
}
struct WCN_VALUE_TYPE_DEVICE_PASSWORD_ID extends Int32 {
    static WCN_VALUE_DP_DEFAULT := 0
    static WCN_VALUE_DP_USER_SPECIFIED := 1
    static WCN_VALUE_DP_MACHINE_SPECIFIED := 2
    static WCN_VALUE_DP_REKEY := 3
    static WCN_VALUE_DP_PUSHBUTTON := 4
    static WCN_VALUE_DP_REGISTRAR_SPECIFIED := 5
    static WCN_VALUE_DP_NFC_CONNECTION_HANDOVER := 7
    static WCN_VALUE_DP_WFD_SERVICES := 8
    static WCN_VALUE_DP_OUTOFBAND_MIN := 16
    static WCN_VALUE_DP_OUTOFBAND_MAX := 65535
}
struct WCN_VALUE_TYPE_ENCRYPTION_TYPE extends Int32 {
    static WCN_VALUE_ET_NONE := 1
    static WCN_VALUE_ET_WEP := 2
    static WCN_VALUE_ET_TKIP := 4
    static WCN_VALUE_ET_AES := 8
    static WCN_VALUE_ET_TKIP_AES_MIXED := 12
}
struct WCN_VALUE_TYPE_MESSAGE_TYPE extends Int32 {
    static WCN_VALUE_MT_BEACON := 1
    static WCN_VALUE_MT_PROBE_REQUEST := 2
    static WCN_VALUE_MT_PROBE_RESPONSE := 3
    static WCN_VALUE_MT_M1 := 4
    static WCN_VALUE_MT_M2 := 5
    static WCN_VALUE_MT_M2D := 6
    static WCN_VALUE_MT_M3 := 7
    static WCN_VALUE_MT_M4 := 8
    static WCN_VALUE_MT_M5 := 9
    static WCN_VALUE_MT_M6 := 10
    static WCN_VALUE_MT_M7 := 11
    static WCN_VALUE_MT_M8 := 12
    static WCN_VALUE_MT_ACK := 13
    static WCN_VALUE_MT_NACK := 14
    static WCN_VALUE_MT_DONE := 15
}
struct WCN_VALUE_TYPE_REQUEST_TYPE extends Int32 {
    static WCN_VALUE_ReqT_ENROLLEE_INFO := 0
    static WCN_VALUE_ReqT_ENROLLEE_OPEN_1X := 1
    static WCN_VALUE_ReqT_REGISTRAR := 2
    static WCN_VALUE_ReqT_MANAGER_REGISTRAR := 3
}
struct WCN_VALUE_TYPE_RESPONSE_TYPE extends Int32 {
    static WCN_VALUE_RspT_ENROLLEE_INFO := 0
    static WCN_VALUE_RspT_ENROLLEE_OPEN_1X := 1
    static WCN_VALUE_RspT_REGISTRAR := 2
    static WCN_VALUE_RspT_AP := 3
}
struct WCN_VALUE_TYPE_RF_BANDS extends Int32 {
    static WCN_VALUE_RB_24GHZ := 1
    static WCN_VALUE_RB_50GHZ := 2
}
struct WCN_VALUE_TYPE_WI_FI_PROTECTED_SETUP_STATE extends Int32 {
    static WCN_VALUE_SS_RESERVED00 := 0
    static WCN_VALUE_SS_NOT_CONFIGURED := 1
    static WCN_VALUE_SS_CONFIGURED := 2
}
struct WCN_VALUE_TYPE_PRIMARY_DEVICE_TYPE {
    Category : UInt16
    SubCategoryOUI : UInt32
    SubCategory : UInt16
}
struct WCN_PASSWORD_TYPE extends Int32 {
    static WCN_PASSWORD_TYPE_PUSH_BUTTON := 0
    static WCN_PASSWORD_TYPE_PIN := 1
    static WCN_PASSWORD_TYPE_PIN_REGISTRAR_SPECIFIED := 2
    static WCN_PASSWORD_TYPE_OOB_SPECIFIED := 3
    static WCN_PASSWORD_TYPE_WFDS := 4
}
struct WCN_SESSION_STATUS extends Int32 {
    static WCN_SESSION_STATUS_SUCCESS := 0
    static WCN_SESSION_STATUS_FAILURE_GENERIC := 1
    static WCN_SESSION_STATUS_FAILURE_TIMEOUT := 2
}
struct WCN_VENDOR_EXTENSION_SPEC {
    VendorId : UInt32
    SubType : UInt32
    Index : UInt32
    Flags : UInt32
}
struct IWCNDevice extends IUnknown {
    static IID := "{C100BE9C-D33A-4A4B-BF23-BBEF4663D017}"
    SetPassword(Type, pbPassword)
      => ComCall(3, this.p, WCN_PASSWORD_TYPE, Type, UInt32, pbPassword.Length, UInt8.Ptr, pbPassword)
    Connect(pNotify?)
      => ComCall(4, this.p, IWCNConnectNotify, pNotify?)
    GetAttribute(AttributeType, pbBuffer, pdwBufferUsed)
      => ComCall(5, this.p, WCN_ATTRIBUTE_TYPE, AttributeType, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer, UInt32.Ptr, pdwBufferUsed)
    GetIntegerAttribute(AttributeType, puInteger)
      => ComCall(6, this.p, WCN_ATTRIBUTE_TYPE, AttributeType, UInt32.Ptr, puInteger)
    GetStringAttribute(AttributeType, wszString)
      => ComCall(7, this.p, WCN_ATTRIBUTE_TYPE, AttributeType, UInt32, wszString.Length, PWSTR, wszString)
    GetNetworkProfile(wszProfile)
      => ComCall(8, this.p, UInt32, wszProfile.Length, PWSTR, wszProfile)
    SetNetworkProfile(pszProfileXml)
      => ComCall(9, this.p, "Str", pszProfileXml)
    GetVendorExtension(pVendorExtSpec, pbBuffer, pdwBufferUsed)
      => ComCall(10, this.p, WCN_VENDOR_EXTENSION_SPEC.Ptr, pVendorExtSpec, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer, UInt32.Ptr, pdwBufferUsed)
    SetVendorExtension(pVendorExtSpec, pbBuffer)
      => ComCall(11, this.p, WCN_VENDOR_EXTENSION_SPEC.Ptr, pVendorExtSpec, UInt32, pbBuffer.Length, UInt8.Ptr, pbBuffer)
    Unadvise()
      => ComCall(12, this.p)
    SetNFCPasswordParams(Type, dwOOBPasswordID, pbPassword?, pbRemotePublicKeyHash?, pbDHKeyBlob?)
      => ComCall(13, this.p, WCN_PASSWORD_TYPE, Type, UInt32, dwOOBPasswordID, UInt32, pbPassword?.Length ?? 0, UInt8.Ptr, pbPassword?, UInt32, pbRemotePublicKeyHash?.Length ?? 0, UInt8.Ptr, pbRemotePublicKeyHash?, UInt32, pbDHKeyBlob?.Length ?? 0, UInt8.Ptr, pbDHKeyBlob?)
}
struct IWCNConnectNotify extends IUnknown {
    static IID := "{C100BE9F-D33A-4A4B-BF23-BBEF4663D017}"
    ConnectSucceeded()
      => ComCall(3, this.p)
    ConnectFailed(hrFailure)
      => ComCall(4, this.p, HRESULT, hrFailure)
}
