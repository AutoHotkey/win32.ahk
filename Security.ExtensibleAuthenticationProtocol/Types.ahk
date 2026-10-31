#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {NCRYPT_KEY_HANDLE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct RAS_AUTH_ATTRIBUTE_TYPE extends Int32 {
    static raatMinimum := 0
    static raatUserName := 1
    static raatUserPassword := 2
    static raatMD5CHAPPassword := 3
    static raatNASIPAddress := 4
    static raatNASPort := 5
    static raatServiceType := 6
    static raatFramedProtocol := 7
    static raatFramedIPAddress := 8
    static raatFramedIPNetmask := 9
    static raatFramedRouting := 10
    static raatFilterId := 11
    static raatFramedMTU := 12
    static raatFramedCompression := 13
    static raatLoginIPHost := 14
    static raatLoginService := 15
    static raatLoginTCPPort := 16
    static raatUnassigned17 := 17
    static raatReplyMessage := 18
    static raatCallbackNumber := 19
    static raatCallbackId := 20
    static raatUnassigned21 := 21
    static raatFramedRoute := 22
    static raatFramedIPXNetwork := 23
    static raatState := 24
    static raatClass := 25
    static raatVendorSpecific := 26
    static raatSessionTimeout := 27
    static raatIdleTimeout := 28
    static raatTerminationAction := 29
    static raatCalledStationId := 30
    static raatCallingStationId := 31
    static raatNASIdentifier := 32
    static raatProxyState := 33
    static raatLoginLATService := 34
    static raatLoginLATNode := 35
    static raatLoginLATGroup := 36
    static raatFramedAppleTalkLink := 37
    static raatFramedAppleTalkNetwork := 38
    static raatFramedAppleTalkZone := 39
    static raatAcctStatusType := 40
    static raatAcctDelayTime := 41
    static raatAcctInputOctets := 42
    static raatAcctOutputOctets := 43
    static raatAcctSessionId := 44
    static raatAcctAuthentic := 45
    static raatAcctSessionTime := 46
    static raatAcctInputPackets := 47
    static raatAcctOutputPackets := 48
    static raatAcctTerminateCause := 49
    static raatAcctMultiSessionId := 50
    static raatAcctLinkCount := 51
    static raatAcctEventTimeStamp := 55
    static raatMD5CHAPChallenge := 60
    static raatNASPortType := 61
    static raatPortLimit := 62
    static raatLoginLATPort := 63
    static raatTunnelType := 64
    static raatTunnelMediumType := 65
    static raatTunnelClientEndpoint := 66
    static raatTunnelServerEndpoint := 67
    static raatARAPPassword := 70
    static raatARAPFeatures := 71
    static raatARAPZoneAccess := 72
    static raatARAPSecurity := 73
    static raatARAPSecurityData := 74
    static raatPasswordRetry := 75
    static raatPrompt := 76
    static raatConnectInfo := 77
    static raatConfigurationToken := 78
    static raatEAPMessage := 79
    static raatSignature := 80
    static raatARAPChallengeResponse := 84
    static raatAcctInterimInterval := 85
    static raatNASIPv6Address := 95
    static raatFramedInterfaceId := 96
    static raatFramedIPv6Prefix := 97
    static raatLoginIPv6Host := 98
    static raatFramedIPv6Route := 99
    static raatFramedIPv6Pool := 100
    static raatARAPGuestLogon := 8096
    static raatCertificateOID := 8097
    static raatEAPConfiguration := 8098
    static raatPEAPEmbeddedEAPTypeId := 8099
    static raatInnerEAPTypeId := 8099
    static raatPEAPFastRoamedSession := 8100
    static raatFastRoamedSession := 8100
    static raatEAPTLV := 8102
    static raatCredentialsChanged := 8103
    static raatCertificateThumbprint := 8250
    static raatPeerId := 9000
    static raatServerId := 9001
    static raatMethodId := 9002
    static raatEMSK := 9003
    static raatSessionId := 9004
    static raatReserved := -1
}
struct NgcTicketContext {
    wszTicket : UInt16[45]
    hKey : NCRYPT_KEY_HANDLE
    hImpersonateToken : HANDLE
}
struct RAS_AUTH_ATTRIBUTE {
    raaType : RAS_AUTH_ATTRIBUTE_TYPE
    dwLength : UInt32
    Value : Struct.Ptr
}
struct PPP_EAP_PACKET {
    Code : UInt8
    Id : UInt8
    Length : UInt8[2]
    Data : UInt8[1]
}
struct PPP_EAP_INPUT {
    dwSizeInBytes : UInt32
    fFlags : UInt32
    fAuthenticator : BOOL
    pwszIdentity : PWSTR
    pwszPassword : PWSTR
    bInitialId : UInt8
    pUserAttributes : RAS_AUTH_ATTRIBUTE.Ptr
    fAuthenticationComplete : BOOL
    dwAuthResultCode : UInt32
    hTokenImpersonateUser : HANDLE
    fSuccessPacketReceived : BOOL
    fDataReceivedFromInteractiveUI : BOOL
    pDataFromInteractiveUI : UInt8.Ptr
    dwSizeOfDataFromInteractiveUI : UInt32
    pConnectionData : UInt8.Ptr
    dwSizeOfConnectionData : UInt32
    pUserData : UInt8.Ptr
    dwSizeOfUserData : UInt32
    hReserved : HANDLE
    guidConnectionId : GUID
    isVpn : BOOL
}
struct PPP_EAP_ACTION extends Int32 {
    static EAPACTION_NoAction := 0
    static EAPACTION_Authenticate := 1
    static EAPACTION_Done := 2
    static EAPACTION_SendAndDone := 3
    static EAPACTION_Send := 4
    static EAPACTION_SendWithTimeout := 5
    static EAPACTION_SendWithTimeoutInteractive := 6
    static EAPACTION_IndicateTLV := 7
    static EAPACTION_IndicateIdentity := 8
}
struct PPP_EAP_OUTPUT {
    dwSizeInBytes : UInt32
    Action : PPP_EAP_ACTION
    dwAuthResultCode : UInt32
    pUserAttributes : RAS_AUTH_ATTRIBUTE.Ptr
    fInvokeInteractiveUI : BOOL
    pUIContextData : UInt8.Ptr
    dwSizeOfUIContextData : UInt32
    fSaveConnectionData : BOOL
    pConnectionData : UInt8.Ptr
    dwSizeOfConnectionData : UInt32
    fSaveUserData : BOOL
    pUserData : UInt8.Ptr
    dwSizeOfUserData : UInt32
    pNgcKerbTicket : NgcTicketContext.Ptr
    fSaveToCredMan : BOOL
}
struct PPP_EAP_INFO {
    dwSizeInBytes : UInt32
    dwEapTypeId : UInt32
    RasEapInitialize : IntPtr
    RasEapBegin : IntPtr
    RasEapEnd : IntPtr
    RasEapMakeMessage : IntPtr
}
struct LEGACY_IDENTITY_UI_PARAMS {
    eapType : UInt32
    dwFlags : UInt32
    dwSizeofConnectionData : UInt32
    pConnectionData : UInt8.Ptr
    dwSizeofUserData : UInt32
    pUserData : UInt8.Ptr
    dwSizeofUserDataOut : UInt32
    pUserDataOut : UInt8.Ptr
    pwszIdentity : PWSTR
    dwError : UInt32
}
struct LEGACY_INTERACTIVE_UI_PARAMS {
    eapType : UInt32
    dwSizeofContextData : UInt32
    pContextData : UInt8.Ptr
    dwSizeofInteractiveUIData : UInt32
    pInteractiveUIData : UInt8.Ptr
    dwError : UInt32
}
struct IRouterProtocolConfig extends IUnknown {
    static IID := "{66A2DB16-D706-11D0-A37B-00C04FC9DA04}"
    AddProtocol(pszMachineName, dwTransportId, dwProtocolId, hWnd1, dwFlags, pRouter, uReserved1)
      => ComCall(3, this.p, "Str", pszMachineName, UInt32, dwTransportId, UInt32, dwProtocolId, HWND, hWnd1, UInt32, dwFlags, IUnknown, pRouter, IntPtr, uReserved1)
    RemoveProtocol(pszMachineName, dwTransportId, dwProtocolId, hWnd1, dwFlags, pRouter, uReserved1)
      => ComCall(4, this.p, "Str", pszMachineName, UInt32, dwTransportId, UInt32, dwProtocolId, HWND, hWnd1, UInt32, dwFlags, IUnknown, pRouter, IntPtr, uReserved1)
}
struct IAuthenticationProviderConfig extends IUnknown {
    static IID := "{66A2DB17-D706-11D0-A37B-00C04FC9DA04}"
    Initialize(pszMachineName, puConnectionParam)
      => ComCall(3, this.p, "Str", pszMachineName, IntPtr.Ptr, puConnectionParam)
    Uninitialize(uConnectionParam)
      => ComCall(4, this.p, IntPtr, uConnectionParam)
    Configure(uConnectionParam, hWnd1, dwFlags, uReserved1, uReserved2)
      => ComCall(5, this.p, IntPtr, uConnectionParam, HWND, hWnd1, UInt32, dwFlags, IntPtr, uReserved1, IntPtr, uReserved2)
    Activate(uConnectionParam, uReserved1, uReserved2)
      => ComCall(6, this.p, IntPtr, uConnectionParam, IntPtr, uReserved1, IntPtr, uReserved2)
    Deactivate(uConnectionParam, uReserved1, uReserved2)
      => ComCall(7, this.p, IntPtr, uConnectionParam, IntPtr, uReserved1, IntPtr, uReserved2)
}
struct IAccountingProviderConfig extends IUnknown {
    static IID := "{66A2DB18-D706-11D0-A37B-00C04FC9DA04}"
    Initialize(pszMachineName, puConnectionParam)
      => ComCall(3, this.p, "Str", pszMachineName, IntPtr.Ptr, puConnectionParam)
    Uninitialize(uConnectionParam)
      => ComCall(4, this.p, IntPtr, uConnectionParam)
    Configure(uConnectionParam, hWnd1, dwFlags, uReserved1, uReserved2)
      => ComCall(5, this.p, IntPtr, uConnectionParam, HWND, hWnd1, UInt32, dwFlags, IntPtr, uReserved1, IntPtr, uReserved2)
    Activate(uConnectionParam, uReserved1, uReserved2)
      => ComCall(6, this.p, IntPtr, uConnectionParam, IntPtr, uReserved1, IntPtr, uReserved2)
    Deactivate(uConnectionParam, uReserved1, uReserved2)
      => ComCall(7, this.p, IntPtr, uConnectionParam, IntPtr, uReserved1, IntPtr, uReserved2)
}
struct IEAPProviderConfig extends IUnknown {
    static IID := "{66A2DB19-D706-11D0-A37B-00C04FC9DA04}"
    Initialize(pszMachineName, dwEapTypeId, puConnectionParam)
      => ComCall(3, this.p, "Str", pszMachineName, UInt32, dwEapTypeId, IntPtr.Ptr, puConnectionParam)
    Uninitialize(dwEapTypeId, uConnectionParam)
      => ComCall(4, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam)
    ServerInvokeConfigUI(dwEapTypeId, uConnectionParam, hWnd1, uReserved1, uReserved2)
      => ComCall(5, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam, HWND, hWnd1, IntPtr, uReserved1, IntPtr, uReserved2)
    RouterInvokeConfigUI(dwEapTypeId, uConnectionParam, hwndParent, dwFlags, pConnectionDataIn, ppConnectionDataOut)
      => ComCall(6, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam, HWND, hwndParent, UInt32, dwFlags, UInt8.Ptr, pConnectionDataIn, UInt32, pConnectionDataIn.Length, UInt8.Ptr.Ptr, ppConnectionDataOut, UInt32.Ptr, ppConnectionDataOut.Length)
    RouterInvokeCredentialsUI(dwEapTypeId, uConnectionParam, hwndParent, dwFlags, pConnectionDataIn, pUserDataIn, ppUserDataOut)
      => ComCall(7, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam, HWND, hwndParent, UInt32, dwFlags, UInt8.Ptr, pConnectionDataIn, UInt32, pConnectionDataIn.Length, UInt8.Ptr, pUserDataIn, UInt32, pUserDataIn.Length, UInt8.Ptr.Ptr, ppUserDataOut, UInt32.Ptr, ppUserDataOut.Length)
}
struct IEAPProviderConfig2 extends IEAPProviderConfig {
    static IID := "{D565917A-85C4-4466-856E-671C3742EA9A}"
    ServerInvokeConfigUI2(dwEapTypeId, uConnectionParam, hWnd1, pConfigDataIn, dwSizeOfConfigDataIn, ppConfigDataOut, pdwSizeOfConfigDataOut)
      => ComCall(8, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam, HWND, hWnd1, UInt8.Ptr, pConfigDataIn, UInt32, dwSizeOfConfigDataIn, UInt8.Ptr.Ptr, ppConfigDataOut, UInt32.Ptr, pdwSizeOfConfigDataOut)
    GetGlobalConfig(dwEapTypeId, ppConfigDataOut, pdwSizeOfConfigDataOut)
      => ComCall(9, this.p, UInt32, dwEapTypeId, UInt8.Ptr.Ptr, ppConfigDataOut, UInt32.Ptr, pdwSizeOfConfigDataOut)
}
struct IEAPProviderConfig3 extends IEAPProviderConfig2 {
    static IID := "{B78ECD12-68BB-4F86-9BF0-8438DD3BE982}"
    ServerInvokeCertificateConfigUI(dwEapTypeId, uConnectionParam, hWnd1, pConfigDataIn, dwSizeOfConfigDataIn, ppConfigDataOut, pdwSizeOfConfigDataOut, uReserved)
      => ComCall(10, this.p, UInt32, dwEapTypeId, IntPtr, uConnectionParam, HWND, hWnd1, UInt8.Ptr, pConfigDataIn, UInt32, dwSizeOfConfigDataIn, UInt8.Ptr.Ptr, ppConfigDataOut, UInt32.Ptr, pdwSizeOfConfigDataOut, IntPtr, uReserved)
}
struct EAP_TYPE {
    type : UInt8
    dwVendorId : UInt32
    dwVendorType : UInt32
}
struct EAP_METHOD_TYPE {
    eapType : EAP_TYPE
    dwAuthorId : UInt32
}
struct EAP_METHOD_INFO {
    eaptype : EAP_METHOD_TYPE
    pwszAuthorName : PWSTR
    pwszFriendlyName : PWSTR
    eapProperties : UInt32
    pInnerMethodInfo : EAP_METHOD_INFO.Ptr
}
struct EAP_METHOD_INFO_EX {
    eaptype : EAP_METHOD_TYPE
    pwszAuthorName : PWSTR
    pwszFriendlyName : PWSTR
    eapProperties : UInt32
    pInnerMethodInfoArray : EAP_METHOD_INFO_ARRAY_EX.Ptr
}
struct EAP_METHOD_INFO_ARRAY {
    dwNumberOfMethods : UInt32
    pEapMethods : EAP_METHOD_INFO.Ptr
}
struct EAP_METHOD_INFO_ARRAY_EX {
    dwNumberOfMethods : UInt32
    pEapMethods : EAP_METHOD_INFO_EX.Ptr
}
struct EAP_ERROR {
    dwWinError : UInt32
    type : EAP_METHOD_TYPE
    dwReasonCode : UInt32
    rootCauseGuid : GUID
    repairGuid : GUID
    helpLinkGuid : GUID
    pRootCauseString : PWSTR
    pRepairString : PWSTR
}
struct EAP_ATTRIBUTE_TYPE extends Int32 {
    static eatMinimum := 0
    static eatUserName := 1
    static eatUserPassword := 2
    static eatMD5CHAPPassword := 3
    static eatNASIPAddress := 4
    static eatNASPort := 5
    static eatServiceType := 6
    static eatFramedProtocol := 7
    static eatFramedIPAddress := 8
    static eatFramedIPNetmask := 9
    static eatFramedRouting := 10
    static eatFilterId := 11
    static eatFramedMTU := 12
    static eatFramedCompression := 13
    static eatLoginIPHost := 14
    static eatLoginService := 15
    static eatLoginTCPPort := 16
    static eatUnassigned17 := 17
    static eatReplyMessage := 18
    static eatCallbackNumber := 19
    static eatCallbackId := 20
    static eatUnassigned21 := 21
    static eatFramedRoute := 22
    static eatFramedIPXNetwork := 23
    static eatState := 24
    static eatClass := 25
    static eatVendorSpecific := 26
    static eatSessionTimeout := 27
    static eatIdleTimeout := 28
    static eatTerminationAction := 29
    static eatCalledStationId := 30
    static eatCallingStationId := 31
    static eatNASIdentifier := 32
    static eatProxyState := 33
    static eatLoginLATService := 34
    static eatLoginLATNode := 35
    static eatLoginLATGroup := 36
    static eatFramedAppleTalkLink := 37
    static eatFramedAppleTalkNetwork := 38
    static eatFramedAppleTalkZone := 39
    static eatAcctStatusType := 40
    static eatAcctDelayTime := 41
    static eatAcctInputOctets := 42
    static eatAcctOutputOctets := 43
    static eatAcctSessionId := 44
    static eatAcctAuthentic := 45
    static eatAcctSessionTime := 46
    static eatAcctInputPackets := 47
    static eatAcctOutputPackets := 48
    static eatAcctTerminateCause := 49
    static eatAcctMultiSessionId := 50
    static eatAcctLinkCount := 51
    static eatAcctEventTimeStamp := 55
    static eatMD5CHAPChallenge := 60
    static eatNASPortType := 61
    static eatPortLimit := 62
    static eatLoginLATPort := 63
    static eatTunnelType := 64
    static eatTunnelMediumType := 65
    static eatTunnelClientEndpoint := 66
    static eatTunnelServerEndpoint := 67
    static eatARAPPassword := 70
    static eatARAPFeatures := 71
    static eatARAPZoneAccess := 72
    static eatARAPSecurity := 73
    static eatARAPSecurityData := 74
    static eatPasswordRetry := 75
    static eatPrompt := 76
    static eatConnectInfo := 77
    static eatConfigurationToken := 78
    static eatEAPMessage := 79
    static eatSignature := 80
    static eatARAPChallengeResponse := 84
    static eatAcctInterimInterval := 85
    static eatNASIPv6Address := 95
    static eatFramedInterfaceId := 96
    static eatFramedIPv6Prefix := 97
    static eatLoginIPv6Host := 98
    static eatFramedIPv6Route := 99
    static eatFramedIPv6Pool := 100
    static eatARAPGuestLogon := 8096
    static eatCertificateOID := 8097
    static eatEAPConfiguration := 8098
    static eatPEAPEmbeddedEAPTypeId := 8099
    static eatPEAPFastRoamedSession := 8100
    static eatFastRoamedSession := 8100
    static eatEAPTLV := 8102
    static eatCredentialsChanged := 8103
    static eatInnerEapMethodType := 8104
    static eatClearTextPassword := 8107
    static eatQuarantineSoH := 8150
    static eatCertificateThumbprint := 8250
    static eatPeerId := 9000
    static eatServerId := 9001
    static eatMethodId := 9002
    static eatEMSK := 9003
    static eatSessionId := 9004
    static eatReserved := -1
}
struct EAP_ATTRIBUTE {
    eaType : EAP_ATTRIBUTE_TYPE
    dwLength : UInt32
    pValue : UInt8.Ptr
}
struct EAP_ATTRIBUTES {
    dwNumberOfAttributes : UInt32
    pAttribs : EAP_ATTRIBUTE.Ptr
}
struct EAP_CONFIG_INPUT_FIELD_TYPE extends Int32 {
    static EapConfigInputUsername := 0
    static EapConfigInputPassword := 1
    static EapConfigInputNetworkUsername := 2
    static EapConfigInputNetworkPassword := 3
    static EapConfigInputPin := 4
    static EapConfigInputPSK := 5
    static EapConfigInputEdit := 6
    static EapConfigSmartCardUsername := 7
    static EapConfigSmartCardError := 8
}
struct EAP_CONFIG_INPUT_FIELD_DATA {
    dwSize : UInt32
    Type : EAP_CONFIG_INPUT_FIELD_TYPE
    dwFlagProps : UInt32
    pwszLabel : PWSTR
    pwszData : PWSTR
    dwMinDataLength : UInt32
    dwMaxDataLength : UInt32
}
struct EAP_CONFIG_INPUT_FIELD_ARRAY {
    dwVersion : UInt32
    dwNumberOfFields : UInt32
    pFields : EAP_CONFIG_INPUT_FIELD_DATA.Ptr
}
struct EAP_INTERACTIVE_UI_DATA_TYPE extends Int32 {
    static EapCredReq := 0
    static EapCredResp := 1
    static EapCredExpiryReq := 2
    static EapCredExpiryResp := 3
    static EapCredLogonReq := 4
    static EapCredLogonResp := 5
}
struct EAP_CRED_EXPIRY_REQ {
    curCreds : EAP_CONFIG_INPUT_FIELD_ARRAY
    newCreds : EAP_CONFIG_INPUT_FIELD_ARRAY
}
struct EAP_UI_DATA_FORMAT {
    union {
        credData : EAP_CONFIG_INPUT_FIELD_ARRAY.Ptr
        credExpiryData : EAP_CRED_EXPIRY_REQ.Ptr
        credLogonData : EAP_CONFIG_INPUT_FIELD_ARRAY.Ptr
    }
}
struct EAP_INTERACTIVE_UI_DATA {
    dwVersion : UInt32
    dwSize : UInt32
    dwDataType : EAP_INTERACTIVE_UI_DATA_TYPE
    cbUiData : UInt32
    pbUiData : EAP_UI_DATA_FORMAT
}
struct EAP_METHOD_PROPERTY_TYPE extends Int32 {
    static emptPropCipherSuiteNegotiation := 0
    static emptPropMutualAuth := 1
    static emptPropIntegrity := 2
    static emptPropReplayProtection := 3
    static emptPropConfidentiality := 4
    static emptPropKeyDerivation := 5
    static emptPropKeyStrength64 := 6
    static emptPropKeyStrength128 := 7
    static emptPropKeyStrength256 := 8
    static emptPropKeyStrength512 := 9
    static emptPropKeyStrength1024 := 10
    static emptPropDictionaryAttackResistance := 11
    static emptPropFastReconnect := 12
    static emptPropCryptoBinding := 13
    static emptPropSessionIndependence := 14
    static emptPropFragmentation := 15
    static emptPropChannelBinding := 16
    static emptPropNap := 17
    static emptPropStandalone := 18
    static emptPropMppeEncryption := 19
    static emptPropTunnelMethod := 20
    static emptPropSupportsConfig := 21
    static emptPropCertifiedMethod := 22
    static emptPropHiddenMethod := 23
    static emptPropMachineAuth := 24
    static emptPropUserAuth := 25
    static emptPropIdentityPrivacy := 26
    static emptPropMethodChaining := 27
    static emptPropSharedStateEquivalence := 28
    static emptLegacyMethodPropertyFlag := 31
    static emptPropVendorSpecific := 255
}
struct EAP_METHOD_PROPERTY_VALUE_TYPE extends Int32 {
    static empvtBool := 0
    static empvtDword := 1
    static empvtString := 2
}
struct EAP_METHOD_PROPERTY_VALUE_BOOL {
    length : UInt32
    value : BOOL
}
struct EAP_METHOD_PROPERTY_VALUE_DWORD {
    length : UInt32
    value : UInt32
}
struct EAP_METHOD_PROPERTY_VALUE_STRING {
    length : UInt32
    value : UInt8.Ptr
}
struct EAP_METHOD_PROPERTY_VALUE {
    union {
        empvBool : EAP_METHOD_PROPERTY_VALUE_BOOL
        empvDword : EAP_METHOD_PROPERTY_VALUE_DWORD
        empvString : EAP_METHOD_PROPERTY_VALUE_STRING
    }
}
struct EAP_METHOD_PROPERTY {
    eapMethodPropertyType : EAP_METHOD_PROPERTY_TYPE
    eapMethodPropertyValueType : EAP_METHOD_PROPERTY_VALUE_TYPE
    eapMethodPropertyValue : EAP_METHOD_PROPERTY_VALUE
}
struct EAP_METHOD_PROPERTY_ARRAY {
    dwNumberOfProperties : UInt32
    pMethodProperty : EAP_METHOD_PROPERTY.Ptr
}
struct EAPHOST_IDENTITY_UI_PARAMS {
    eapMethodType : EAP_METHOD_TYPE
    dwFlags : UInt32
    dwSizeofConnectionData : UInt32
    pConnectionData : UInt8.Ptr
    dwSizeofUserData : UInt32
    pUserData : UInt8.Ptr
    dwSizeofUserDataOut : UInt32
    pUserDataOut : UInt8.Ptr
    pwszIdentity : PWSTR
    dwError : UInt32
    pEapError : EAP_ERROR.Ptr
}
struct EAPHOST_INTERACTIVE_UI_PARAMS {
    dwSizeofContextData : UInt32
    pContextData : UInt8.Ptr
    dwSizeofInteractiveUIData : UInt32
    pInteractiveUIData : UInt8.Ptr
    dwError : UInt32
    pEapError : EAP_ERROR.Ptr
}
struct EapCredentialType extends Int32 {
    static EAP_EMPTY_CREDENTIAL := 0
    static EAP_USERNAME_PASSWORD_CREDENTIAL := 1
    static EAP_WINLOGON_CREDENTIAL := 2
    static EAP_CERTIFICATE_CREDENTIAL := 3
    static EAP_SIM_CREDENTIAL := 4
}
struct EapUsernamePasswordCredential {
    username : PWSTR
    password : PWSTR
}
struct EapCertificateCredential {
    certHash : UInt8[20]
    password : PWSTR
}
struct EapSimCredential {
    iccID : PWSTR
}
struct EapCredentialTypeData {
    union {
        username_password : EapUsernamePasswordCredential
        certificate : EapCertificateCredential
        sim : EapSimCredential
    }
}
struct EapCredential {
    credType : EapCredentialType
    credData : EapCredentialTypeData
}
struct EapHostPeerMethodResultReason extends Int32 {
    static EapHostPeerMethodResultAltSuccessReceived := 1
    static EapHostPeerMethodResultTimeout := 2
    static EapHostPeerMethodResultFromMethod := 3
}
struct EapHostPeerResponseAction extends Int32 {
    static EapHostPeerResponseDiscard := 0
    static EapHostPeerResponseSend := 1
    static EapHostPeerResponseResult := 2
    static EapHostPeerResponseInvokeUi := 3
    static EapHostPeerResponseRespond := 4
    static EapHostPeerResponseStartAuthentication := 5
    static EapHostPeerResponseNone := 6
}
struct EapHostPeerAuthParams extends Int32 {
    static EapHostPeerAuthStatus := 1
    static EapHostPeerIdentity := 2
    static EapHostPeerIdentityExtendedInfo := 3
    static EapHostNapInfo := 4
}
struct EAPHOST_AUTH_STATUS extends Int32 {
    static EapHostInvalidSession := 0
    static EapHostAuthNotStarted := 1
    static EapHostAuthIdentityExchange := 2
    static EapHostAuthNegotiatingType := 3
    static EapHostAuthInProgress := 4
    static EapHostAuthSucceeded := 5
    static EapHostAuthFailed := 6
}
struct EAPHOST_AUTH_INFO {
    status : EAPHOST_AUTH_STATUS
    dwErrorCode : UInt32
    dwReasonCode : UInt32
}
struct ISOLATION_STATE extends Int32 {
    static ISOLATION_STATE_UNKNOWN := 0
    static ISOLATION_STATE_NOT_RESTRICTED := 1
    static ISOLATION_STATE_IN_PROBATION := 2
    static ISOLATION_STATE_RESTRICTED_ACCESS := 3
}
struct EapHostPeerMethodResult {
    fIsSuccess : BOOL
    dwFailureReasonCode : UInt32
    fSaveConnectionData : BOOL
    dwSizeofConnectionData : UInt32
    pConnectionData : UInt8.Ptr
    fSaveUserData : BOOL
    dwSizeofUserData : UInt32
    pUserData : UInt8.Ptr
    pAttribArray : EAP_ATTRIBUTES.Ptr
    isolationState : ISOLATION_STATE
    pEapMethodInfo : EAP_METHOD_INFO.Ptr
    pEapError : EAP_ERROR.Ptr
}
struct EapPacket {
    Code : UInt8
    Id : UInt8
    Length : UInt8[2]
    Data : UInt8[1]
}
struct EapCode extends Int32 {
    static EapCodeMinimum := 1
    static EapCodeRequest := 1
    static EapCodeResponse := 2
    static EapCodeSuccess := 3
    static EapCodeFailure := 4
    static EapCodeMaximum := 4
}
struct NotificationHandler extends FunctionPointer {
    static Types := [GUID, Struct.Ptr, "Void"]
}
struct EAP_METHOD_AUTHENTICATOR_RESPONSE_ACTION extends Int32 {
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_DISCARD := 0
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_SEND := 1
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_RESULT := 2
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_RESPOND := 3
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_AUTHENTICATE := 4
    static EAP_METHOD_AUTHENTICATOR_RESPONSE_HANDLE_IDENTITY := 5
}
struct EAP_METHOD_AUTHENTICATOR_RESULT {
    fIsSuccess : BOOL
    dwFailureReason : UInt32
    pAuthAttribs : EAP_ATTRIBUTES.Ptr
}
struct EapPeerMethodResponseAction extends Int32 {
    static EapPeerMethodResponseActionDiscard := 0
    static EapPeerMethodResponseActionSend := 1
    static EapPeerMethodResponseActionResult := 2
    static EapPeerMethodResponseActionInvokeUI := 3
    static EapPeerMethodResponseActionRespond := 4
    static EapPeerMethodResponseActionNone := 5
}
struct EapPeerMethodOutput {
    action : EapPeerMethodResponseAction
    fAllowNotifications : BOOL
}
struct EapPeerMethodResultReason extends Int32 {
    static EapPeerMethodResultUnknown := 1
    static EapPeerMethodResultSuccess := 2
    static EapPeerMethodResultFailure := 3
}
struct EapPeerMethodResult {
    fIsSuccess : BOOL
    dwFailureReasonCode : UInt32
    fSaveConnectionData : BOOL
    dwSizeofConnectionData : UInt32
    pConnectionData : UInt8.Ptr
    fSaveUserData : BOOL
    dwSizeofUserData : UInt32
    pUserData : UInt8.Ptr
    pAttribArray : EAP_ATTRIBUTES.Ptr
    pEapError : EAP_ERROR.Ptr
    pNgcKerbTicket : NgcTicketContext.Ptr
    fSaveToCredMan : BOOL
}
struct EAP_PEER_METHOD_ROUTINES {
    dwVersion : UInt32
    pEapType : EAP_TYPE.Ptr
    EapPeerInitialize : IntPtr
    EapPeerGetIdentity : IntPtr
    EapPeerBeginSession : IntPtr
    EapPeerSetCredentials : IntPtr
    EapPeerProcessRequestPacket : IntPtr
    EapPeerGetResponsePacket : IntPtr
    EapPeerGetResult : IntPtr
    EapPeerGetUIContext : IntPtr
    EapPeerSetUIContext : IntPtr
    EapPeerGetResponseAttributes : IntPtr
    EapPeerSetResponseAttributes : IntPtr
    EapPeerEndSession : IntPtr
    EapPeerShutdown : IntPtr
}
struct EAP_AUTHENTICATOR_SEND_TIMEOUT extends Int32 {
    static EAP_AUTHENTICATOR_SEND_TIMEOUT_NONE := 0
    static EAP_AUTHENTICATOR_SEND_TIMEOUT_BASIC := 1
    static EAP_AUTHENTICATOR_SEND_TIMEOUT_INTERACTIVE := 2
}
struct EAP_AUTHENTICATOR_METHOD_ROUTINES {
    dwSizeInBytes : UInt32
    pEapType : EAP_METHOD_TYPE.Ptr
    EapMethodAuthenticatorInitialize : IntPtr
    EapMethodAuthenticatorBeginSession : IntPtr
    EapMethodAuthenticatorUpdateInnerMethodParams : IntPtr
    EapMethodAuthenticatorReceivePacket : IntPtr
    EapMethodAuthenticatorSendPacket : IntPtr
    EapMethodAuthenticatorGetAttributes : IntPtr
    EapMethodAuthenticatorSetAttributes : IntPtr
    EapMethodAuthenticatorGetResult : IntPtr
    EapMethodAuthenticatorEndSession : IntPtr
    EapMethodAuthenticatorShutdown : IntPtr
}
