#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

struct EC_SUBSCRIPTION_PROPERTY_ID extends Int32 {
    static EcSubscriptionEnabled := 0
    static EcSubscriptionEventSources := 1
    static EcSubscriptionEventSourceAddress := 2
    static EcSubscriptionEventSourceEnabled := 3
    static EcSubscriptionEventSourceUserName := 4
    static EcSubscriptionEventSourcePassword := 5
    static EcSubscriptionDescription := 6
    static EcSubscriptionURI := 7
    static EcSubscriptionConfigurationMode := 8
    static EcSubscriptionExpires := 9
    static EcSubscriptionQuery := 10
    static EcSubscriptionTransportName := 11
    static EcSubscriptionTransportPort := 12
    static EcSubscriptionDeliveryMode := 13
    static EcSubscriptionDeliveryMaxItems := 14
    static EcSubscriptionDeliveryMaxLatencyTime := 15
    static EcSubscriptionHeartbeatInterval := 16
    static EcSubscriptionLocale := 17
    static EcSubscriptionContentFormat := 18
    static EcSubscriptionLogFile := 19
    static EcSubscriptionPublisherName := 20
    static EcSubscriptionCredentialsType := 21
    static EcSubscriptionCommonUserName := 22
    static EcSubscriptionCommonPassword := 23
    static EcSubscriptionHostName := 24
    static EcSubscriptionReadExistingEvents := 25
    static EcSubscriptionDialect := 26
    static EcSubscriptionType := 27
    static EcSubscriptionAllowedIssuerCAs := 28
    static EcSubscriptionAllowedSubjects := 29
    static EcSubscriptionDeniedSubjects := 30
    static EcSubscriptionAllowedSourceDomainComputers := 31
    static EcSubscriptionPropertyIdEND := 32
}
struct EC_SUBSCRIPTION_CREDENTIALS_TYPE extends Int32 {
    static EcSubscriptionCredDefault := 0
    static EcSubscriptionCredNegotiate := 1
    static EcSubscriptionCredDigest := 2
    static EcSubscriptionCredBasic := 3
    static EcSubscriptionCredLocalMachine := 4
}
struct EC_SUBSCRIPTION_TYPE extends Int32 {
    static EcSubscriptionTypeSourceInitiated := 0
    static EcSubscriptionTypeCollectorInitiated := 1
}
struct EC_SUBSCRIPTION_RUNTIME_STATUS_INFO_ID extends Int32 {
    static EcSubscriptionRunTimeStatusActive := 0
    static EcSubscriptionRunTimeStatusLastError := 1
    static EcSubscriptionRunTimeStatusLastErrorMessage := 2
    static EcSubscriptionRunTimeStatusLastErrorTime := 3
    static EcSubscriptionRunTimeStatusNextRetryTime := 4
    static EcSubscriptionRunTimeStatusEventSources := 5
    static EcSubscriptionRunTimeStatusLastHeartbeatTime := 6
    static EcSubscriptionRunTimeStatusInfoIdEND := 7
}
struct EC_VARIANT_TYPE extends Int32 {
    static EcVarTypeNull := 0
    static EcVarTypeBoolean := 1
    static EcVarTypeUInt32 := 2
    static EcVarTypeDateTime := 3
    static EcVarTypeString := 4
    static EcVarObjectArrayPropertyHandle := 5
}
struct EC_VARIANT {
    Anonymous : this._Anonymous_e__Union
    Count : UInt32
    Type : UInt32
    struct _Anonymous_e__Union {
        union {
            BooleanVal : BOOL
            UInt32Val : UInt32
            DateTimeVal : Int64
            StringVal : PWSTR
            BinaryVal : UInt8.Ptr
            BooleanArr : BOOL.Ptr
            Int32Arr : Int32.Ptr
            StringArr : PWSTR.Ptr
            PropertyHandleVal : IntPtr
        }
    }
}
struct EC_SUBSCRIPTION_CONFIGURATION_MODE extends Int32 {
    static EcConfigurationModeNormal := 0
    static EcConfigurationModeCustom := 1
    static EcConfigurationModeMinLatency := 2
    static EcConfigurationModeMinBandwidth := 3
}
struct EC_SUBSCRIPTION_DELIVERY_MODE extends Int32 {
    static EcDeliveryModePull := 1
    static EcDeliveryModePush := 2
}
struct EC_SUBSCRIPTION_CONTENT_FORMAT extends Int32 {
    static EcContentFormatEvents := 1
    static EcContentFormatRenderedText := 2
}
struct EC_SUBSCRIPTION_RUNTIME_STATUS_ACTIVE_STATUS extends Int32 {
    static EcRuntimeStatusActiveStatusDisabled := 1
    static EcRuntimeStatusActiveStatusActive := 2
    static EcRuntimeStatusActiveStatusInactive := 3
    static EcRuntimeStatusActiveStatusTrying := 4
}
