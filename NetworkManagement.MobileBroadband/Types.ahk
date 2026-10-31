#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}

struct IDummyMBNUCMExt extends IDispatch {
    static IID := "{DCBBBAB6-FFFF-4BBB-AAEE-338E368AF6FA}"
}
struct MBN_SIGNAL_CONSTANTS extends Int32 {
    static MBN_RSSI_DEFAULT := -1
    static MBN_RSSI_DISABLE := 0
    static MBN_RSSI_UNKNOWN := 99
    static MBN_ERROR_RATE_UNKNOWN := 99
}
struct MBN_CELLULAR_CLASS extends Int32 {
    static MBN_CELLULAR_CLASS_NONE := 0
    static MBN_CELLULAR_CLASS_GSM := 1
    static MBN_CELLULAR_CLASS_CDMA := 2
}
struct MBN_VOICE_CLASS extends Int32 {
    static MBN_VOICE_CLASS_NONE := 0
    static MBN_VOICE_CLASS_NO_VOICE := 1
    static MBN_VOICE_CLASS_SEPARATE_VOICE_DATA := 2
    static MBN_VOICE_CLASS_SIMULTANEOUS_VOICE_DATA := 3
}
struct MBN_PROVIDER_STATE extends Int32 {
    static MBN_PROVIDER_STATE_NONE := 0
    static MBN_PROVIDER_STATE_HOME := 1
    static MBN_PROVIDER_STATE_FORBIDDEN := 2
    static MBN_PROVIDER_STATE_PREFERRED := 4
    static MBN_PROVIDER_STATE_VISIBLE := 8
    static MBN_PROVIDER_STATE_REGISTERED := 16
    static MBN_PROVIDER_STATE_PREFERRED_MULTICARRIER := 32
}
struct MBN_PROVIDER_CONSTANTS extends Int32 {
    static MBN_PROVIDERNAME_LEN := 20
    static MBN_PROVIDERID_LEN := 6
}
struct MBN_INTERFACE_CAPS_CONSTANTS extends Int32 {
    static MBN_DEVICEID_LEN := 18
    static MBN_MANUFACTURER_LEN := 32
    static MBN_MODEL_LEN := 32
    static MBN_FIRMWARE_LEN := 32
}
struct MBN_DATA_CLASS extends Int32 {
    static MBN_DATA_CLASS_NONE := 0
    static MBN_DATA_CLASS_GPRS := 1
    static MBN_DATA_CLASS_EDGE := 2
    static MBN_DATA_CLASS_UMTS := 4
    static MBN_DATA_CLASS_HSDPA := 8
    static MBN_DATA_CLASS_HSUPA := 16
    static MBN_DATA_CLASS_LTE := 32
    static MBN_DATA_CLASS_5G_NSA := 64
    static MBN_DATA_CLASS_5G_SA := 128
    static MBN_DATA_CLASS_1XRTT := 65536
    static MBN_DATA_CLASS_1XEVDO := 131072
    static MBN_DATA_CLASS_1XEVDO_REVA := 262144
    static MBN_DATA_CLASS_1XEVDV := 524288
    static MBN_DATA_CLASS_3XRTT := 1048576
    static MBN_DATA_CLASS_1XEVDO_REVB := 2097152
    static MBN_DATA_CLASS_UMB := 4194304
    static MBN_DATA_CLASS_CUSTOM := -2147483648
}
struct MBN_CTRL_CAPS extends Int32 {
    static MBN_CTRL_CAPS_NONE := 0
    static MBN_CTRL_CAPS_REG_MANUAL := 1
    static MBN_CTRL_CAPS_HW_RADIO_SWITCH := 2
    static MBN_CTRL_CAPS_CDMA_MOBILE_IP := 4
    static MBN_CTRL_CAPS_CDMA_SIMPLE_IP := 8
    static MBN_CTRL_CAPS_PROTECT_UNIQUEID := 16
    static MBN_CTRL_CAPS_MODEL_MULTI_CARRIER := 32
    static MBN_CTRL_CAPS_USSD := 64
    static MBN_CTRL_CAPS_MULTI_MODE := 128
}
struct MBN_SMS_CAPS extends Int32 {
    static MBN_SMS_CAPS_NONE := 0
    static MBN_SMS_CAPS_PDU_RECEIVE := 1
    static MBN_SMS_CAPS_PDU_SEND := 2
    static MBN_SMS_CAPS_TEXT_RECEIVE := 4
    static MBN_SMS_CAPS_TEXT_SEND := 8
}
struct MBN_BAND_CLASS extends Int32 {
    static MBN_BAND_CLASS_NONE := 0
    static MBN_BAND_CLASS_0 := 1
    static MBN_BAND_CLASS_I := 2
    static MBN_BAND_CLASS_II := 4
    static MBN_BAND_CLASS_III := 8
    static MBN_BAND_CLASS_IV := 16
    static MBN_BAND_CLASS_V := 32
    static MBN_BAND_CLASS_VI := 64
    static MBN_BAND_CLASS_VII := 128
    static MBN_BAND_CLASS_VIII := 256
    static MBN_BAND_CLASS_IX := 512
    static MBN_BAND_CLASS_X := 1024
    static MBN_BAND_CLASS_XI := 2048
    static MBN_BAND_CLASS_XII := 4096
    static MBN_BAND_CLASS_XIII := 8192
    static MBN_BAND_CLASS_XIV := 16384
    static MBN_BAND_CLASS_XV := 32768
    static MBN_BAND_CLASS_XVI := 65536
    static MBN_BAND_CLASS_XVII := 131072
    static MBN_BAND_CLASS_CUSTOM := -2147483648
}
struct MBN_INTERFACE_CAPS {
    cellularClass : MBN_CELLULAR_CLASS
    voiceClass : MBN_VOICE_CLASS
    dataClass : UInt32
    customDataClass : BSTR
    gsmBandClass : UInt32
    cdmaBandClass : UInt32
    customBandClass : BSTR
    smsCaps : UInt32
    controlCaps : UInt32
    deviceID : BSTR
    manufacturer : BSTR
    model : BSTR
    firmwareInfo : BSTR
}
struct MBN_PROVIDER {
    providerID : BSTR
    providerState : UInt32
    providerName : BSTR
    dataClass : UInt32
}
struct MBN_PROVIDER2 {
    provider : MBN_PROVIDER
    cellularClass : MBN_CELLULAR_CLASS
    signalStrength : UInt32
    signalError : UInt32
}
struct MBN_READY_STATE extends Int32 {
    static MBN_READY_STATE_OFF := 0
    static MBN_READY_STATE_INITIALIZED := 1
    static MBN_READY_STATE_SIM_NOT_INSERTED := 2
    static MBN_READY_STATE_BAD_SIM := 3
    static MBN_READY_STATE_FAILURE := 4
    static MBN_READY_STATE_NOT_ACTIVATED := 5
    static MBN_READY_STATE_DEVICE_LOCKED := 6
    static MBN_READY_STATE_DEVICE_BLOCKED := 7
    static MBN_READY_STATE_NO_ESIM_PROFILE := 8
}
struct MBN_ACTIVATION_STATE extends Int32 {
    static MBN_ACTIVATION_STATE_NONE := 0
    static MBN_ACTIVATION_STATE_ACTIVATED := 1
    static MBN_ACTIVATION_STATE_ACTIVATING := 2
    static MBN_ACTIVATION_STATE_DEACTIVATED := 3
    static MBN_ACTIVATION_STATE_DEACTIVATING := 4
}
struct MBN_CONNECTION_MODE extends Int32 {
    static MBN_CONNECTION_MODE_PROFILE := 0
    static MBN_CONNECTION_MODE_TMP_PROFILE := 1
}
struct MBN_VOICE_CALL_STATE extends Int32 {
    static MBN_VOICE_CALL_STATE_NONE := 0
    static MBN_VOICE_CALL_STATE_IN_PROGRESS := 1
    static MBN_VOICE_CALL_STATE_HANGUP := 2
}
struct MBN_REGISTRATION_CONSTANTS extends Int32 {
    static MBN_ROAMTEXT_LEN := 64
    static MBN_CDMA_DEFAULT_PROVIDER_ID := 0
}
struct MBN_REGISTER_STATE extends Int32 {
    static MBN_REGISTER_STATE_NONE := 0
    static MBN_REGISTER_STATE_DEREGISTERED := 1
    static MBN_REGISTER_STATE_SEARCHING := 2
    static MBN_REGISTER_STATE_HOME := 3
    static MBN_REGISTER_STATE_ROAMING := 4
    static MBN_REGISTER_STATE_PARTNER := 5
    static MBN_REGISTER_STATE_DENIED := 6
}
struct MBN_REGISTER_MODE extends Int32 {
    static MBN_REGISTER_MODE_NONE := 0
    static MBN_REGISTER_MODE_AUTOMATIC := 1
    static MBN_REGISTER_MODE_MANUAL := 2
}
struct MBN_PIN_CONSTANTS extends Int32 {
    static MBN_ATTEMPTS_REMAINING_UNKNOWN := -1
    static MBN_PIN_LENGTH_UNKNOWN := -1
}
struct MBN_PIN_STATE extends Int32 {
    static MBN_PIN_STATE_NONE := 0
    static MBN_PIN_STATE_ENTER := 1
    static MBN_PIN_STATE_UNBLOCK := 2
}
struct MBN_PIN_TYPE extends Int32 {
    static MBN_PIN_TYPE_NONE := 0
    static MBN_PIN_TYPE_CUSTOM := 1
    static MBN_PIN_TYPE_PIN1 := 2
    static MBN_PIN_TYPE_PIN2 := 3
    static MBN_PIN_TYPE_DEVICE_SIM_PIN := 4
    static MBN_PIN_TYPE_DEVICE_FIRST_SIM_PIN := 5
    static MBN_PIN_TYPE_NETWORK_PIN := 6
    static MBN_PIN_TYPE_NETWORK_SUBSET_PIN := 7
    static MBN_PIN_TYPE_SVC_PROVIDER_PIN := 8
    static MBN_PIN_TYPE_CORPORATE_PIN := 9
    static MBN_PIN_TYPE_SUBSIDY_LOCK := 10
}
struct MBN_PIN_INFO {
    pinState : MBN_PIN_STATE
    pinType : MBN_PIN_TYPE
    attemptsRemaining : UInt32
}
struct MBN_PIN_MODE extends Int32 {
    static MBN_PIN_MODE_ENABLED := 1
    static MBN_PIN_MODE_DISABLED := 2
}
struct MBN_PIN_FORMAT extends Int32 {
    static MBN_PIN_FORMAT_NONE := 0
    static MBN_PIN_FORMAT_NUMERIC := 1
    static MBN_PIN_FORMAT_ALPHANUMERIC := 2
}
struct MBN_CONTEXT_CONSTANTS extends Int32 {
    static MBN_ACCESSSTRING_LEN := 100
    static MBN_USERNAME_LEN := 255
    static MBN_PASSWORD_LEN := 255
    static MBN_CONTEXT_ID_APPEND := -1
}
struct MBN_AUTH_PROTOCOL extends Int32 {
    static MBN_AUTH_PROTOCOL_NONE := 0
    static MBN_AUTH_PROTOCOL_PAP := 1
    static MBN_AUTH_PROTOCOL_CHAP := 2
    static MBN_AUTH_PROTOCOL_MSCHAPV2 := 3
}
struct MBN_COMPRESSION extends Int32 {
    static MBN_COMPRESSION_NONE := 0
    static MBN_COMPRESSION_ENABLE := 1
}
struct MBN_CONTEXT_TYPE extends Int32 {
    static MBN_CONTEXT_TYPE_NONE := 0
    static MBN_CONTEXT_TYPE_INTERNET := 1
    static MBN_CONTEXT_TYPE_VPN := 2
    static MBN_CONTEXT_TYPE_VOICE := 3
    static MBN_CONTEXT_TYPE_VIDEO_SHARE := 4
    static MBN_CONTEXT_TYPE_CUSTOM := 5
    static MBN_CONTEXT_TYPE_PURCHASE := 6
}
struct MBN_CONTEXT {
    contextID : UInt32
    contextType : MBN_CONTEXT_TYPE
    accessString : BSTR
    userName : BSTR
    password : BSTR
    compression : MBN_COMPRESSION
    authType : MBN_AUTH_PROTOCOL
}
struct WWAEXT_SMS_CONSTANTS extends Int32 {
    static MBN_MESSAGE_INDEX_NONE := 0
    static MBN_CDMA_SHORT_MSG_SIZE_UNKNOWN := 0
    static MBN_CDMA_SHORT_MSG_SIZE_MAX := 160
}
struct MBN_MSG_STATUS extends Int32 {
    static MBN_MSG_STATUS_NEW := 0
    static MBN_MSG_STATUS_OLD := 1
    static MBN_MSG_STATUS_DRAFT := 2
    static MBN_MSG_STATUS_SENT := 3
}
struct MBN_SMS_CDMA_LANG extends Int32 {
    static MBN_SMS_CDMA_LANG_NONE := 0
    static MBN_SMS_CDMA_LANG_ENGLISH := 1
    static MBN_SMS_CDMA_LANG_FRENCH := 2
    static MBN_SMS_CDMA_LANG_SPANISH := 3
    static MBN_SMS_CDMA_LANG_JAPANESE := 4
    static MBN_SMS_CDMA_LANG_KOREAN := 5
    static MBN_SMS_CDMA_LANG_CHINESE := 6
    static MBN_SMS_CDMA_LANG_HEBREW := 7
}
struct MBN_SMS_CDMA_ENCODING extends Int32 {
    static MBN_SMS_CDMA_ENCODING_OCTET := 0
    static MBN_SMS_CDMA_ENCODING_EPM := 1
    static MBN_SMS_CDMA_ENCODING_7BIT_ASCII := 2
    static MBN_SMS_CDMA_ENCODING_IA5 := 3
    static MBN_SMS_CDMA_ENCODING_UNICODE := 4
    static MBN_SMS_CDMA_ENCODING_SHIFT_JIS := 5
    static MBN_SMS_CDMA_ENCODING_KOREAN := 6
    static MBN_SMS_CDMA_ENCODING_LATIN_HEBREW := 7
    static MBN_SMS_CDMA_ENCODING_LATIN := 8
    static MBN_SMS_CDMA_ENCODING_GSM_7BIT := 9
}
struct MBN_SMS_FLAG extends Int32 {
    static MBN_SMS_FLAG_ALL := 0
    static MBN_SMS_FLAG_INDEX := 1
    static MBN_SMS_FLAG_NEW := 2
    static MBN_SMS_FLAG_OLD := 3
    static MBN_SMS_FLAG_SENT := 4
    static MBN_SMS_FLAG_DRAFT := 5
}
struct MBN_SMS_FILTER {
    flag : MBN_SMS_FLAG
    messageIndex : UInt32
}
struct MBN_SMS_STATUS_FLAG extends Int32 {
    static MBN_SMS_FLAG_NONE := 0
    static MBN_SMS_FLAG_MESSAGE_STORE_FULL := 1
    static MBN_SMS_FLAG_NEW_MESSAGE := 2
}
struct MBN_SMS_STATUS_INFO {
    flag : UInt32
    messageIndex : UInt32
}
struct MBN_SMS_FORMAT extends Int32 {
    static MBN_SMS_FORMAT_NONE := 0
    static MBN_SMS_FORMAT_PDU := 1
    static MBN_SMS_FORMAT_TEXT := 2
}
struct MBN_RADIO extends Int32 {
    static MBN_RADIO_OFF := 0
    static MBN_RADIO_ON := 1
}
struct MBN_DEVICE_SERVICE_SESSIONS_STATE extends Int32 {
    static MBN_DEVICE_SERVICE_SESSIONS_RESTORED := 0
}
struct MBN_DEVICE_SERVICE {
    deviceServiceID : BSTR
    dataWriteSupported : VARIANT_BOOL
    dataReadSupported : VARIANT_BOOL
}
struct MBN_DEVICE_SERVICES_INTERFACE_STATE extends Int32 {
    static MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_ARRIVAL := 0
    static MBN_DEVICE_SERVICES_CAPABLE_INTERFACE_REMOVAL := 1
}
struct IMbnConnection extends IUnknown {
    static IID := "{DCBBBAB6-200D-4BBB-AAEE-338E368AF6FA}"
    get_ConnectionID(ConnectionID)
      => ComCall(3, this.p, BSTR.Ptr, ConnectionID)
    get_InterfaceID(InterfaceID)
      => ComCall(4, this.p, BSTR.Ptr, InterfaceID)
    Connect(connectionMode, strProfile, requestID)
      => ComCall(5, this.p, MBN_CONNECTION_MODE, connectionMode, "Str", strProfile, UInt32.Ptr, requestID)
    Disconnect(requestID)
      => ComCall(6, this.p, UInt32.Ptr, requestID)
    GetConnectionState(ConnectionState, ProfileName)
      => ComCall(7, this.p, MBN_ACTIVATION_STATE.Ptr, ConnectionState, BSTR.Ptr, ProfileName)
    GetVoiceCallState(voiceCallState)
      => ComCall(8, this.p, MBN_VOICE_CALL_STATE.Ptr, voiceCallState)
    GetActivationNetworkError(networkError)
      => ComCall(9, this.p, UInt32.Ptr, networkError)
}
struct IMbnConnectionEvents extends IUnknown {
    static IID := "{DCBBBAB6-200E-4BBB-AAEE-338E368AF6FA}"
    OnConnectComplete(newConnection, requestID, status)
      => ComCall(3, this.p, IMbnConnection, newConnection, UInt32, requestID, HRESULT, status)
    OnDisconnectComplete(newConnection, requestID, status)
      => ComCall(4, this.p, IMbnConnection, newConnection, UInt32, requestID, HRESULT, status)
    OnConnectStateChange(newConnection)
      => ComCall(5, this.p, IMbnConnection, newConnection)
    OnVoiceCallStateChange(newConnection)
      => ComCall(6, this.p, IMbnConnection, newConnection)
}
struct IMbnInterface extends IUnknown {
    static IID := "{DCBBBAB6-2001-4BBB-AAEE-338E368AF6FA}"
    get_InterfaceID(InterfaceID)
      => ComCall(3, this.p, BSTR.Ptr, InterfaceID)
    GetInterfaceCapability(interfaceCaps)
      => ComCall(4, this.p, MBN_INTERFACE_CAPS.Ptr, interfaceCaps)
    GetSubscriberInformation(subscriberInformation)
      => ComCall(5, this.p, IMbnSubscriberInformation.Ptr, subscriberInformation)
    GetReadyState(readyState)
      => ComCall(6, this.p, MBN_READY_STATE.Ptr, readyState)
    InEmergencyMode(emergencyMode)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, emergencyMode)
    GetHomeProvider(homeProvider)
      => ComCall(8, this.p, MBN_PROVIDER.Ptr, homeProvider)
    GetPreferredProviders(preferredProviders)
      => ComCall(9, this.p, SAFEARRAY.Ptr.Ptr, preferredProviders)
    SetPreferredProviders(preferredProviders, requestID)
      => ComCall(10, this.p, SAFEARRAY.Ptr, preferredProviders, UInt32.Ptr, requestID)
    GetVisibleProviders(age, visibleProviders)
      => ComCall(11, this.p, UInt32.Ptr, age, SAFEARRAY.Ptr.Ptr, visibleProviders)
    ScanNetwork(requestID)
      => ComCall(12, this.p, UInt32.Ptr, requestID)
    GetConnection(mbnConnection)
      => ComCall(13, this.p, IMbnConnection.Ptr, mbnConnection)
}
struct IMbnInterfaceEvents extends IUnknown {
    static IID := "{DCBBBAB6-2002-4BBB-AAEE-338E368AF6FA}"
    OnInterfaceCapabilityAvailable(newInterface)
      => ComCall(3, this.p, IMbnInterface, newInterface)
    OnSubscriberInformationChange(newInterface)
      => ComCall(4, this.p, IMbnInterface, newInterface)
    OnReadyStateChange(newInterface)
      => ComCall(5, this.p, IMbnInterface, newInterface)
    OnEmergencyModeChange(newInterface)
      => ComCall(6, this.p, IMbnInterface, newInterface)
    OnHomeProviderAvailable(newInterface)
      => ComCall(7, this.p, IMbnInterface, newInterface)
    OnPreferredProvidersChange(newInterface)
      => ComCall(8, this.p, IMbnInterface, newInterface)
    OnSetPreferredProvidersComplete(newInterface, requestID, status)
      => ComCall(9, this.p, IMbnInterface, newInterface, UInt32, requestID, HRESULT, status)
    OnScanNetworkComplete(newInterface, requestID, status)
      => ComCall(10, this.p, IMbnInterface, newInterface, UInt32, requestID, HRESULT, status)
}
struct IMbnInterfaceManager extends IUnknown {
    static IID := "{DCBBBAB6-201B-4BBB-AAEE-338E368AF6FA}"
    GetInterface(interfaceID, mbnInterface)
      => ComCall(3, this.p, "Str", interfaceID, IMbnInterface.Ptr, mbnInterface)
    GetInterfaces(mbnInterfaces)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, mbnInterfaces)
}
struct IMbnInterfaceManagerEvents extends IUnknown {
    static IID := "{DCBBBAB6-201C-4BBB-AAEE-338E368AF6FA}"
    OnInterfaceArrival(newInterface)
      => ComCall(3, this.p, IMbnInterface, newInterface)
    OnInterfaceRemoval(oldInterface)
      => ComCall(4, this.p, IMbnInterface, oldInterface)
}
struct IMbnRegistration extends IUnknown {
    static IID := "{DCBBBAB6-2009-4BBB-AAEE-338E368AF6FA}"
    GetRegisterState(registerState)
      => ComCall(3, this.p, MBN_REGISTER_STATE.Ptr, registerState)
    GetRegisterMode(registerMode)
      => ComCall(4, this.p, MBN_REGISTER_MODE.Ptr, registerMode)
    GetProviderID(providerID)
      => ComCall(5, this.p, BSTR.Ptr, providerID)
    GetProviderName(providerName)
      => ComCall(6, this.p, BSTR.Ptr, providerName)
    GetRoamingText(roamingText)
      => ComCall(7, this.p, BSTR.Ptr, roamingText)
    GetAvailableDataClasses(availableDataClasses)
      => ComCall(8, this.p, UInt32.Ptr, availableDataClasses)
    GetCurrentDataClass(currentDataClass)
      => ComCall(9, this.p, UInt32.Ptr, currentDataClass)
    GetRegistrationNetworkError(registrationNetworkError)
      => ComCall(10, this.p, UInt32.Ptr, registrationNetworkError)
    GetPacketAttachNetworkError(packetAttachNetworkError)
      => ComCall(11, this.p, UInt32.Ptr, packetAttachNetworkError)
    SetRegisterMode(registerMode, providerID, dataClass, requestID)
      => ComCall(12, this.p, MBN_REGISTER_MODE, registerMode, "Str", providerID, UInt32, dataClass, UInt32.Ptr, requestID)
}
struct IMbnRegistrationEvents extends IUnknown {
    static IID := "{DCBBBAB6-200A-4BBB-AAEE-338E368AF6FA}"
    OnRegisterModeAvailable(newInterface)
      => ComCall(3, this.p, IMbnRegistration, newInterface)
    OnRegisterStateChange(newInterface)
      => ComCall(4, this.p, IMbnRegistration, newInterface)
    OnPacketServiceStateChange(newInterface)
      => ComCall(5, this.p, IMbnRegistration, newInterface)
    OnSetRegisterModeComplete(newInterface, requestID, status)
      => ComCall(6, this.p, IMbnRegistration, newInterface, UInt32, requestID, HRESULT, status)
}
struct IMbnConnectionManager extends IUnknown {
    static IID := "{DCBBBAB6-201D-4BBB-AAEE-338E368AF6FA}"
    GetConnection(connectionID, mbnConnection)
      => ComCall(3, this.p, "Str", connectionID, IMbnConnection.Ptr, mbnConnection)
    GetConnections(mbnConnections)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, mbnConnections)
}
struct IMbnConnectionManagerEvents extends IUnknown {
    static IID := "{DCBBBAB6-201E-4BBB-AAEE-338E368AF6FA}"
    OnConnectionArrival(newConnection)
      => ComCall(3, this.p, IMbnConnection, newConnection)
    OnConnectionRemoval(oldConnection)
      => ComCall(4, this.p, IMbnConnection, oldConnection)
}
struct IMbnPinManager extends IUnknown {
    static IID := "{DCBBBAB6-2005-4BBB-AAEE-338E368AF6FA}"
    GetPinList(pinList)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, pinList)
    GetPin(pinType, pin)
      => ComCall(4, this.p, MBN_PIN_TYPE, pinType, IMbnPin.Ptr, pin)
    GetPinState(requestID)
      => ComCall(5, this.p, UInt32.Ptr, requestID)
}
struct IMbnPinManagerEvents extends IUnknown {
    static IID := "{DCBBBAB6-2006-4BBB-AAEE-338E368AF6FA}"
    OnPinListAvailable(pinManager)
      => ComCall(3, this.p, IMbnPinManager, pinManager)
    OnGetPinStateComplete(pinManager, pinInfo, requestID, status)
      => ComCall(4, this.p, IMbnPinManager, pinManager, MBN_PIN_INFO, pinInfo, UInt32, requestID, HRESULT, status)
}
struct IMbnPinEvents extends IUnknown {
    static IID := "{DCBBBAB6-2008-4BBB-AAEE-338E368AF6FA}"
    OnEnableComplete(pin, pinInfo, requestID, status)
      => ComCall(3, this.p, IMbnPin, pin, MBN_PIN_INFO.Ptr, pinInfo, UInt32, requestID, HRESULT, status)
    OnDisableComplete(pin, pinInfo, requestID, status)
      => ComCall(4, this.p, IMbnPin, pin, MBN_PIN_INFO.Ptr, pinInfo, UInt32, requestID, HRESULT, status)
    OnEnterComplete(Pin, pinInfo, requestID, status)
      => ComCall(5, this.p, IMbnPin, Pin, MBN_PIN_INFO.Ptr, pinInfo, UInt32, requestID, HRESULT, status)
    OnChangeComplete(Pin, pinInfo, requestID, status)
      => ComCall(6, this.p, IMbnPin, Pin, MBN_PIN_INFO.Ptr, pinInfo, UInt32, requestID, HRESULT, status)
    OnUnblockComplete(Pin, pinInfo, requestID, status)
      => ComCall(7, this.p, IMbnPin, Pin, MBN_PIN_INFO.Ptr, pinInfo, UInt32, requestID, HRESULT, status)
}
struct IMbnSubscriberInformation extends IUnknown {
    static IID := "{459ECC43-BCF5-11DC-A8A8-001321F1405F}"
    get_SubscriberID(SubscriberID)
      => ComCall(3, this.p, BSTR.Ptr, SubscriberID)
    get_SimIccID(SimIccID)
      => ComCall(4, this.p, BSTR.Ptr, SimIccID)
    get_TelephoneNumbers(TelephoneNumbers)
      => ComCall(5, this.p, SAFEARRAY.Ptr.Ptr, TelephoneNumbers)
}
struct IMbnSignal extends IUnknown {
    static IID := "{DCBBBAB6-2003-4BBB-AAEE-338E368AF6FA}"
    GetSignalStrength(signalStrength)
      => ComCall(3, this.p, UInt32.Ptr, signalStrength)
    GetSignalError(signalError)
      => ComCall(4, this.p, UInt32.Ptr, signalError)
}
struct IMbnSignalEvents extends IUnknown {
    static IID := "{DCBBBAB6-2004-4BBB-AAEE-338E368AF6FA}"
    OnSignalStateChange(newInterface)
      => ComCall(3, this.p, IMbnSignal, newInterface)
}
struct IMbnConnectionContext extends IUnknown {
    static IID := "{DCBBBAB6-200B-4BBB-AAEE-338E368AF6FA}"
    GetProvisionedContexts(provisionedContexts)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, provisionedContexts)
    SetProvisionedContext(provisionedContexts, providerID, requestID)
      => ComCall(4, this.p, MBN_CONTEXT, provisionedContexts, "Str", providerID, UInt32.Ptr, requestID)
}
struct IMbnConnectionContextEvents extends IUnknown {
    static IID := "{DCBBBAB6-200C-4BBB-AAEE-338E368AF6FA}"
    OnProvisionedContextListChange(newInterface)
      => ComCall(3, this.p, IMbnConnectionContext, newInterface)
    OnSetProvisionedContextComplete(newInterface, requestID, status)
      => ComCall(4, this.p, IMbnConnectionContext, newInterface, UInt32, requestID, HRESULT, status)
}
struct IMbnConnectionProfileManager extends IUnknown {
    static IID := "{DCBBBAB6-200F-4BBB-AAEE-338E368AF6FA}"
    GetConnectionProfiles(mbnInterface, connectionProfiles)
      => ComCall(3, this.p, IMbnInterface, mbnInterface, SAFEARRAY.Ptr.Ptr, connectionProfiles)
    GetConnectionProfile(mbnInterface, profileName, connectionProfile)
      => ComCall(4, this.p, IMbnInterface, mbnInterface, "Str", profileName, IMbnConnectionProfile.Ptr, connectionProfile)
    CreateConnectionProfile(xmlProfile)
      => ComCall(5, this.p, "Str", xmlProfile)
}
struct IMbnConnectionProfile extends IUnknown {
    static IID := "{DCBBBAB6-2010-4BBB-AAEE-338E368AF6FA}"
    GetProfileXmlData(profileData)
      => ComCall(3, this.p, BSTR.Ptr, profileData)
    UpdateProfile(strProfile)
      => ComCall(4, this.p, "Str", strProfile)
    Delete()
      => ComCall(5, this.p)
}
struct IMbnConnectionProfileEvents extends IUnknown {
    static IID := "{DCBBBAB6-2011-4BBB-AAEE-338E368AF6FA}"
    OnProfileUpdate(newProfile)
      => ComCall(3, this.p, IMbnConnectionProfile, newProfile)
}
struct IMbnSmsConfiguration extends IUnknown {
    static IID := "{DCBBBAB6-2012-4BBB-AAEE-338E368AF6FA}"
    get_ServiceCenterAddress(scAddress)
      => ComCall(3, this.p, BSTR.Ptr, scAddress)
    put_ServiceCenterAddress(scAddress)
      => ComCall(4, this.p, "Str", scAddress)
    get_MaxMessageIndex(index)
      => ComCall(5, this.p, UInt32.Ptr, index)
    get_CdmaShortMsgSize(shortMsgSize)
      => ComCall(6, this.p, UInt32.Ptr, shortMsgSize)
    get_SmsFormat(smsFormat)
      => ComCall(7, this.p, MBN_SMS_FORMAT.Ptr, smsFormat)
    put_SmsFormat(smsFormat)
      => ComCall(8, this.p, MBN_SMS_FORMAT, smsFormat)
}
struct IMbnSmsReadMsgPdu extends IUnknown {
    static IID := "{DCBBBAB6-2013-4BBB-AAEE-338E368AF6FA}"
    get_Index(Index)
      => ComCall(3, this.p, UInt32.Ptr, Index)
    get_Status(Status)
      => ComCall(4, this.p, MBN_MSG_STATUS.Ptr, Status)
    get_PduData(PduData)
      => ComCall(5, this.p, BSTR.Ptr, PduData)
    get_Message(Message)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, Message)
}
struct IMbnSmsReadMsgTextCdma extends IUnknown {
    static IID := "{DCBBBAB6-2014-4BBB-AAEE-338E368AF6FA}"
    get_Index(Index)
      => ComCall(3, this.p, UInt32.Ptr, Index)
    get_Status(Status)
      => ComCall(4, this.p, MBN_MSG_STATUS.Ptr, Status)
    get_Address(Address)
      => ComCall(5, this.p, BSTR.Ptr, Address)
    get_Timestamp(Timestamp)
      => ComCall(6, this.p, BSTR.Ptr, Timestamp)
    get_EncodingID(EncodingID)
      => ComCall(7, this.p, MBN_SMS_CDMA_ENCODING.Ptr, EncodingID)
    get_LanguageID(LanguageID)
      => ComCall(8, this.p, MBN_SMS_CDMA_LANG.Ptr, LanguageID)
    get_SizeInCharacters(SizeInCharacters)
      => ComCall(9, this.p, UInt32.Ptr, SizeInCharacters)
    get_Message(Message)
      => ComCall(10, this.p, SAFEARRAY.Ptr.Ptr, Message)
}
struct IMbnSms extends IUnknown {
    static IID := "{DCBBBAB6-2015-4BBB-AAEE-338E368AF6FA}"
    GetSmsConfiguration(smsConfiguration)
      => ComCall(3, this.p, IMbnSmsConfiguration.Ptr, smsConfiguration)
    SetSmsConfiguration(smsConfiguration, requestID)
      => ComCall(4, this.p, IMbnSmsConfiguration, smsConfiguration, UInt32.Ptr, requestID)
    SmsSendPdu(pduData, size, requestID)
      => ComCall(5, this.p, "Str", pduData, UInt8, size, UInt32.Ptr, requestID)
    SmsSendCdma(address, encoding, language, sizeInCharacters, message, requestID)
      => ComCall(6, this.p, "Str", address, MBN_SMS_CDMA_ENCODING, encoding, MBN_SMS_CDMA_LANG, language, UInt32, sizeInCharacters, SAFEARRAY.Ptr, message, UInt32.Ptr, requestID)
    SmsSendCdmaPdu(message, requestID)
      => ComCall(7, this.p, SAFEARRAY.Ptr, message, UInt32.Ptr, requestID)
    SmsRead(smsFilter, smsFormat, requestID)
      => ComCall(8, this.p, MBN_SMS_FILTER.Ptr, smsFilter, MBN_SMS_FORMAT, smsFormat, UInt32.Ptr, requestID)
    SmsDelete(smsFilter, requestID)
      => ComCall(9, this.p, MBN_SMS_FILTER.Ptr, smsFilter, UInt32.Ptr, requestID)
    GetSmsStatus(smsStatusInfo)
      => ComCall(10, this.p, MBN_SMS_STATUS_INFO.Ptr, smsStatusInfo)
}
struct IMbnSmsEvents extends IUnknown {
    static IID := "{DCBBBAB6-2016-4BBB-AAEE-338E368AF6FA}"
    OnSmsConfigurationChange(sms)
      => ComCall(3, this.p, IMbnSms, sms)
    OnSetSmsConfigurationComplete(sms, requestID, status)
      => ComCall(4, this.p, IMbnSms, sms, UInt32, requestID, HRESULT, status)
    OnSmsSendComplete(sms, requestID, status)
      => ComCall(5, this.p, IMbnSms, sms, UInt32, requestID, HRESULT, status)
    OnSmsReadComplete(sms, smsFormat, readMsgs, moreMsgs, requestID, status)
      => ComCall(6, this.p, IMbnSms, sms, MBN_SMS_FORMAT, smsFormat, SAFEARRAY.Ptr, readMsgs, VARIANT_BOOL, moreMsgs, UInt32, requestID, HRESULT, status)
    OnSmsNewClass0Message(sms, smsFormat, readMsgs)
      => ComCall(7, this.p, IMbnSms, sms, MBN_SMS_FORMAT, smsFormat, SAFEARRAY.Ptr, readMsgs)
    OnSmsDeleteComplete(sms, requestID, status)
      => ComCall(8, this.p, IMbnSms, sms, UInt32, requestID, HRESULT, status)
    OnSmsStatusChange(sms)
      => ComCall(9, this.p, IMbnSms, sms)
}
struct IMbnServiceActivation extends IUnknown {
    static IID := "{DCBBBAB6-2017-4BBB-AAEE-338E368AF6FA}"
    Activate(vendorSpecificData, requestID)
      => ComCall(3, this.p, SAFEARRAY.Ptr, vendorSpecificData, UInt32.Ptr, requestID)
}
struct IMbnServiceActivationEvents extends IUnknown {
    static IID := "{DCBBBAB6-2018-4BBB-AAEE-338E368AF6FA}"
    OnActivationComplete(serviceActivation, vendorSpecificData, requestID, status, networkError)
      => ComCall(3, this.p, IMbnServiceActivation, serviceActivation, SAFEARRAY.Ptr, vendorSpecificData, UInt32, requestID, HRESULT, status, UInt32, networkError)
}
struct IMbnVendorSpecificOperation extends IUnknown {
    static IID := "{DCBBBAB6-2019-4BBB-AAEE-338E368AF6FA}"
    SetVendorSpecific(vendorSpecificData, requestID)
      => ComCall(3, this.p, SAFEARRAY.Ptr, vendorSpecificData, UInt32.Ptr, requestID)
}
struct IMbnVendorSpecificEvents extends IUnknown {
    static IID := "{DCBBBAB6-201A-4BBB-AAEE-338E368AF6FA}"
    OnEventNotification(vendorOperation, vendorSpecificData)
      => ComCall(3, this.p, IMbnVendorSpecificOperation, vendorOperation, SAFEARRAY.Ptr, vendorSpecificData)
    OnSetVendorSpecificComplete(vendorOperation, vendorSpecificData, requestID)
      => ComCall(4, this.p, IMbnVendorSpecificOperation, vendorOperation, SAFEARRAY.Ptr, vendorSpecificData, UInt32, requestID)
}
struct IMbnConnectionProfileManagerEvents extends IUnknown {
    static IID := "{DCBBBAB6-201F-4BBB-AAEE-338E368AF6FA}"
    OnConnectionProfileArrival(newConnectionProfile)
      => ComCall(3, this.p, IMbnConnectionProfile, newConnectionProfile)
    OnConnectionProfileRemoval(oldConnectionProfile)
      => ComCall(4, this.p, IMbnConnectionProfile, oldConnectionProfile)
}
struct IMbnRadio extends IUnknown {
    static IID := "{DCCCCAB6-201F-4BBB-AAEE-338E368AF6FA}"
    get_SoftwareRadioState(SoftwareRadioState)
      => ComCall(3, this.p, MBN_RADIO.Ptr, SoftwareRadioState)
    get_HardwareRadioState(HardwareRadioState)
      => ComCall(4, this.p, MBN_RADIO.Ptr, HardwareRadioState)
    SetSoftwareRadioState(radioState, requestID)
      => ComCall(5, this.p, MBN_RADIO, radioState, UInt32.Ptr, requestID)
}
struct IMbnRadioEvents extends IUnknown {
    static IID := "{DCDDDAB6-201F-4BBB-AAEE-338E368AF6FA}"
    OnRadioStateChange(newInterface)
      => ComCall(3, this.p, IMbnRadio, newInterface)
    OnSetSoftwareRadioStateComplete(newInterface, requestID, status)
      => ComCall(4, this.p, IMbnRadio, newInterface, UInt32, requestID, HRESULT, status)
}
struct IMbnMultiCarrier extends IUnknown {
    static IID := "{DCBBBAB6-2020-4BBB-AAEE-338E368AF6FA}"
    SetHomeProvider(homeProvider, requestID)
      => ComCall(3, this.p, MBN_PROVIDER2.Ptr, homeProvider, UInt32.Ptr, requestID)
    GetPreferredProviders(preferredMulticarrierProviders)
      => ComCall(4, this.p, SAFEARRAY.Ptr.Ptr, preferredMulticarrierProviders)
    GetVisibleProviders(age, visibleProviders)
      => ComCall(5, this.p, UInt32.Ptr, age, SAFEARRAY.Ptr.Ptr, visibleProviders)
    GetSupportedCellularClasses(cellularClasses)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, cellularClasses)
    GetCurrentCellularClass(currentCellularClass)
      => ComCall(7, this.p, MBN_CELLULAR_CLASS.Ptr, currentCellularClass)
    ScanNetwork(requestID)
      => ComCall(8, this.p, UInt32.Ptr, requestID)
}
struct IMbnMultiCarrierEvents extends IUnknown {
    static IID := "{DCDDDAB6-2021-4BBB-AAEE-338E368AF6FA}"
    OnSetHomeProviderComplete(mbnInterface, requestID, status)
      => ComCall(3, this.p, IMbnMultiCarrier, mbnInterface, UInt32, requestID, HRESULT, status)
    OnCurrentCellularClassChange(mbnInterface)
      => ComCall(4, this.p, IMbnMultiCarrier, mbnInterface)
    OnPreferredProvidersChange(mbnInterface)
      => ComCall(5, this.p, IMbnMultiCarrier, mbnInterface)
    OnScanNetworkComplete(mbnInterface, requestID, status)
      => ComCall(6, this.p, IMbnMultiCarrier, mbnInterface, UInt32, requestID, HRESULT, status)
    OnInterfaceCapabilityChange(mbnInterface)
      => ComCall(7, this.p, IMbnMultiCarrier, mbnInterface)
}
struct IMbnDeviceServiceStateEvents extends IUnknown {
    static IID := "{5D3FF196-89EE-49D8-8B60-33FFDDFFC58D}"
    OnSessionsStateChange(interfaceID, stateChange)
      => ComCall(3, this.p, BSTR, interfaceID, MBN_DEVICE_SERVICE_SESSIONS_STATE, stateChange)
}
struct IMbnDeviceServicesManager extends IUnknown {
    static IID := "{20A26258-6811-4478-AC1D-13324E45E41C}"
    GetDeviceServicesContext(networkInterfaceID, mbnDevicesContext)
      => ComCall(3, this.p, BSTR, networkInterfaceID, IMbnDeviceServicesContext.Ptr, mbnDevicesContext)
}
struct IMbnDeviceServicesContext extends IUnknown {
    static IID := "{FC5AC347-1592-4068-80BB-6A57580150D8}"
    EnumerateDeviceServices(deviceServices)
      => ComCall(3, this.p, SAFEARRAY.Ptr.Ptr, deviceServices)
    GetDeviceService(deviceServiceID, mbnDeviceService)
      => ComCall(4, this.p, BSTR, deviceServiceID, IMbnDeviceService.Ptr, mbnDeviceService)
    get_MaxCommandSize(maxCommandSize)
      => ComCall(5, this.p, UInt32.Ptr, maxCommandSize)
    get_MaxDataSize(maxDataSize)
      => ComCall(6, this.p, UInt32.Ptr, maxDataSize)
}
struct IMbnDeviceServicesEvents extends IUnknown {
    static IID := "{0A900C19-6824-4E97-B76E-CF239D0CA642}"
    OnQuerySupportedCommandsComplete(deviceService, commandIDList, status, requestID)
      => ComCall(3, this.p, IMbnDeviceService, deviceService, SAFEARRAY.Ptr, commandIDList, HRESULT, status, UInt32, requestID)
    OnOpenCommandSessionComplete(deviceService, status, requestID)
      => ComCall(4, this.p, IMbnDeviceService, deviceService, HRESULT, status, UInt32, requestID)
    OnCloseCommandSessionComplete(deviceService, status, requestID)
      => ComCall(5, this.p, IMbnDeviceService, deviceService, HRESULT, status, UInt32, requestID)
    OnSetCommandComplete(deviceService, responseID, deviceServiceData, status, requestID)
      => ComCall(6, this.p, IMbnDeviceService, deviceService, UInt32, responseID, SAFEARRAY.Ptr, deviceServiceData, HRESULT, status, UInt32, requestID)
    OnQueryCommandComplete(deviceService, responseID, deviceServiceData, status, requestID)
      => ComCall(7, this.p, IMbnDeviceService, deviceService, UInt32, responseID, SAFEARRAY.Ptr, deviceServiceData, HRESULT, status, UInt32, requestID)
    OnEventNotification(deviceService, eventID, deviceServiceData)
      => ComCall(8, this.p, IMbnDeviceService, deviceService, UInt32, eventID, SAFEARRAY.Ptr, deviceServiceData)
    OnOpenDataSessionComplete(deviceService, status, requestID)
      => ComCall(9, this.p, IMbnDeviceService, deviceService, HRESULT, status, UInt32, requestID)
    OnCloseDataSessionComplete(deviceService, status, requestID)
      => ComCall(10, this.p, IMbnDeviceService, deviceService, HRESULT, status, UInt32, requestID)
    OnWriteDataComplete(deviceService, status, requestID)
      => ComCall(11, this.p, IMbnDeviceService, deviceService, HRESULT, status, UInt32, requestID)
    OnReadData(deviceService, deviceServiceData)
      => ComCall(12, this.p, IMbnDeviceService, deviceService, SAFEARRAY.Ptr, deviceServiceData)
    OnInterfaceStateChange(interfaceID, stateChange)
      => ComCall(13, this.p, BSTR, interfaceID, MBN_DEVICE_SERVICES_INTERFACE_STATE, stateChange)
}
struct IMbnDeviceService extends IUnknown {
    static IID := "{B3BB9A71-DC70-4BE9-A4DA-7886AE8B191B}"
    QuerySupportedCommands(requestID)
      => ComCall(3, this.p, UInt32.Ptr, requestID)
    OpenCommandSession(requestID)
      => ComCall(4, this.p, UInt32.Ptr, requestID)
    CloseCommandSession(requestID)
      => ComCall(5, this.p, UInt32.Ptr, requestID)
    SetCommand(commandID, deviceServiceData, requestID)
      => ComCall(6, this.p, UInt32, commandID, SAFEARRAY.Ptr, deviceServiceData, UInt32.Ptr, requestID)
    QueryCommand(commandID, deviceServiceData, requestID)
      => ComCall(7, this.p, UInt32, commandID, SAFEARRAY.Ptr, deviceServiceData, UInt32.Ptr, requestID)
    OpenDataSession(requestID)
      => ComCall(8, this.p, UInt32.Ptr, requestID)
    CloseDataSession(requestID)
      => ComCall(9, this.p, UInt32.Ptr, requestID)
    WriteData(deviceServiceData, requestID)
      => ComCall(10, this.p, SAFEARRAY.Ptr, deviceServiceData, UInt32.Ptr, requestID)
    get_InterfaceID(InterfaceID)
      => ComCall(11, this.p, BSTR.Ptr, InterfaceID)
    get_DeviceServiceID(DeviceServiceID)
      => ComCall(12, this.p, BSTR.Ptr, DeviceServiceID)
    get_IsCommandSessionOpen(value)
      => ComCall(13, this.p, BOOL.Ptr, value)
    get_IsDataSessionOpen(value)
      => ComCall(14, this.p, BOOL.Ptr, value)
}
struct mbnapi_ReferenceRemainingTypes__ {
    bandClass : MBN_BAND_CLASS
    contextConstants : MBN_CONTEXT_CONSTANTS
    ctrlCaps : MBN_CTRL_CAPS
    dataClass : MBN_DATA_CLASS
    interfaceCapsConstants : MBN_INTERFACE_CAPS_CONSTANTS
    pinConstants : MBN_PIN_CONSTANTS
    providerConstants : MBN_PROVIDER_CONSTANTS
    providerState : MBN_PROVIDER_STATE
    registrationConstants : MBN_REGISTRATION_CONSTANTS
    signalConstants : MBN_SIGNAL_CONSTANTS
    smsCaps : MBN_SMS_CAPS
    smsConstants : WWAEXT_SMS_CONSTANTS
    wwaextSmsConstants : WWAEXT_SMS_CONSTANTS
    smsStatusFlag : MBN_SMS_STATUS_FLAG
}
struct DummyPinType__ {
    pinType : UInt32
}
struct IMbnPin extends IUnknown {
    static IID := "{DCBBBAB6-2007-4BBB-AAEE-338E368AF6FA}"
    get_PinType(PinType)
      => ComCall(3, this.p, MBN_PIN_TYPE.Ptr, PinType)
    get_PinFormat(PinFormat)
      => ComCall(4, this.p, MBN_PIN_FORMAT.Ptr, PinFormat)
    get_PinLengthMin(PinLengthMin)
      => ComCall(5, this.p, UInt32.Ptr, PinLengthMin)
    get_PinLengthMax(PinLengthMax)
      => ComCall(6, this.p, UInt32.Ptr, PinLengthMax)
    get_PinMode(PinMode)
      => ComCall(7, this.p, MBN_PIN_MODE.Ptr, PinMode)
    Enable(pin, requestID)
      => ComCall(8, this.p, "Str", pin, UInt32.Ptr, requestID)
    Disable(pin, requestID)
      => ComCall(9, this.p, "Str", pin, UInt32.Ptr, requestID)
    Enter(pin, requestID)
      => ComCall(10, this.p, "Str", pin, UInt32.Ptr, requestID)
    Change(pin, newPin, requestID)
      => ComCall(11, this.p, "Str", pin, "Str", newPin, UInt32.Ptr, requestID)
    Unblock(puk, newPin, requestID)
      => ComCall(12, this.p, "Str", puk, "Str", newPin, UInt32.Ptr, requestID)
    GetPinManager(pinManager)
      => ComCall(13, this.p, IMbnPinManager.Ptr, pinManager)
}
