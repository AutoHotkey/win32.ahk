#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HANDLE, HRESULT, POINT, PWSTR, RECT}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}

struct WINBIO_SETTING_SOURCE extends UInt32 {
    static WINBIO_SETTING_SOURCE_INVALID := 0
    static WINBIO_SETTING_SOURCE_DEFAULT := 1
    static WINBIO_SETTING_SOURCE_LOCAL := 3
    static WINBIO_SETTING_SOURCE_POLICY := 2
}
struct WINBIO_COMPONENT extends UInt32 {
    static WINBIO_COMPONENT_SENSOR := 1
    static WINBIO_COMPONENT_ENGINE := 2
    static WINBIO_COMPONENT_STORAGE := 3
}
struct WINBIO_POOL extends UInt32 {
    static WINBIO_POOL_SYSTEM := 1
    static WINBIO_POOL_PRIVATE := 2
}
struct WINIBIO_SENSOR_CONTEXT {
    Value : IntPtr
}
struct WINIBIO_ENGINE_CONTEXT {
    Value : IntPtr
}
struct WINIBIO_STORAGE_CONTEXT {
    Value : IntPtr
}
struct WINBIO_VERSION {
    MajorVersion : UInt32
    MinorVersion : UInt32
}
struct WINBIO_IDENTITY {
    Type : UInt32
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            Null : UInt32
            Wildcard : UInt32
            TemplateGuid : GUID
            AccountSid : this._AccountSid_e__Struct
            SecureId : UInt8[32]
        }
        struct _AccountSid_e__Struct {
            Size : UInt32
            Data : UInt8[68]
        }
    }
}
struct WINBIO_SECURE_CONNECTION_PARAMS {
    PayloadSize : UInt32
    Version : UInt16
    Flags : UInt16
}
struct WINBIO_SECURE_CONNECTION_DATA {
    Size : UInt32
    Version : UInt16
    Flags : UInt16
    ModelCertificateSize : UInt32
    IntermediateCA1Size : UInt32
    IntermediateCA2Size : UInt32
}
struct WINBIO_BIR_DATA {
    Size : UInt32
    Offset : UInt32
}
struct WINBIO_BIR {
    HeaderBlock : WINBIO_BIR_DATA
    StandardDataBlock : WINBIO_BIR_DATA
    VendorDataBlock : WINBIO_BIR_DATA
    SignatureBlock : WINBIO_BIR_DATA
}
struct WINBIO_REGISTERED_FORMAT {
    Owner : UInt16
    Type : UInt16
}
struct WINBIO_BIR_HEADER {
    ValidFields : UInt16
    HeaderVersion : UInt8
    PatronHeaderVersion : UInt8
    DataFlags : UInt8
    Type : UInt32
    Subtype : UInt8
    Purpose : UInt8
    DataQuality : Int8
    CreationDate : Int64
    ValidityPeriod : this._ValidityPeriod_e__Struct
    BiometricDataFormat : WINBIO_REGISTERED_FORMAT
    ProductId : WINBIO_REGISTERED_FORMAT
    struct _ValidityPeriod_e__Struct {
        BeginDate : Int64
        EndDate : Int64
    }
}
struct WINBIO_BDB_ANSI_381_HEADER {
    RecordLength : Int64
    FormatIdentifier : UInt32
    VersionNumber : UInt32
    ProductId : WINBIO_REGISTERED_FORMAT
    CaptureDeviceId : UInt16
    ImageAcquisitionLevel : UInt16
    HorizontalScanResolution : UInt16
    VerticalScanResolution : UInt16
    HorizontalImageResolution : UInt16
    VerticalImageResolution : UInt16
    ElementCount : UInt8
    ScaleUnits : UInt8
    PixelDepth : UInt8
    ImageCompressionAlg : UInt8
    Reserved : UInt16
}
struct WINBIO_BDB_ANSI_381_RECORD {
    BlockLength : UInt32
    HorizontalLineLength : UInt16
    VerticalLineLength : UInt16
    Position : UInt8
    CountOfViews : UInt8
    ViewNumber : UInt8
    ImageQuality : UInt8
    ImpressionType : UInt8
    Reserved : UInt8
}
struct WINBIO_SECURE_BUFFER_HEADER_V1 {
    Type : UInt32
    Size : UInt32
    Flags : UInt32
    ValidationTag : Int64
}
struct WINBIO_EVENT {
    Type : UInt32
    Parameters : this._Parameters_e__Union
    struct _Parameters_e__Union {
        union {
            Unclaimed : this._Unclaimed_e__Struct
            UnclaimedIdentify : this._UnclaimedIdentify_e__Struct
            Error : this._Error_e__Struct
        }
        struct _Unclaimed_e__Struct {
            UnitId : UInt32
            RejectDetail : UInt32
        }
        struct _UnclaimedIdentify_e__Struct {
            UnitId : UInt32
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
            RejectDetail : UInt32
        }
        struct _Error_e__Struct {
            ErrorCode : HRESULT
        }
    }
}
struct WINBIO_PRESENCE_PROPERTIES {
    union {
        FacialFeatures : this._FacialFeatures_e__Struct
        Iris : this._Iris_e__Struct
    }
    struct _FacialFeatures_e__Struct {
        BoundingBox : RECT
        Distance : Int32
        OpaqueEngineData : this._OpaqueEngineData_e__Struct
        struct _OpaqueEngineData_e__Struct {
            AdapterId : GUID
            Data : UInt32[78]
        }
    }
    struct _Iris_e__Struct {
        EyeBoundingBox_1 : RECT
        EyeBoundingBox_2 : RECT
        PupilCenter_1 : POINT
        PupilCenter_2 : POINT
        Distance : Int32
    }
}
struct WINBIO_PRESENCE {
    Factor : UInt32
    SubFactor : UInt8
    Status : HRESULT
    RejectDetail : UInt32
    Identity : WINBIO_IDENTITY
    TrackingId : Int64
    Ticket : Int64
    Properties : WINBIO_PRESENCE_PROPERTIES
    Authorization : this._Authorization_e__Struct
    struct _Authorization_e__Struct {
        Size : UInt32
        Data : UInt8[32]
    }
}
struct WINBIO_BSP_SCHEMA {
    BiometricFactor : UInt32
    BspId : GUID
    Description : UInt16[256]
    Vendor : UInt16[256]
    Version : WINBIO_VERSION
}
struct WINBIO_UNIT_SCHEMA {
    UnitId : UInt32
    PoolType : UInt32
    BiometricFactor : UInt32
    SensorSubType : UInt32
    Capabilities : UInt32
    DeviceInstanceId : UInt16[256]
    Description : UInt16[256]
    Manufacturer : UInt16[256]
    Model : UInt16[256]
    SerialNumber : UInt16[256]
    FirmwareVersion : WINBIO_VERSION
}
struct WINBIO_STORAGE_SCHEMA {
    BiometricFactor : UInt32
    DatabaseId : GUID
    DataFormat : GUID
    Attributes : UInt32
    FilePath : UInt16[256]
    ConnectionString : UInt16[256]
}
struct WINBIO_EXTENDED_SENSOR_INFO {
    GenericSensorCapabilities : UInt32
    Factor : UInt32
    Specific : this._Specific_e__Union
    struct _Specific_e__Union {
        union {
            Null : UInt32
            FacialFeatures : this._FacialFeatures_e__Struct
            Fingerprint : this._Fingerprint_e__Struct
            Iris : this._Iris_e__Struct
            Voice : this._Voice_e__Struct
        }
        struct _FacialFeatures_e__Struct {
            FrameSize : RECT
            FrameOffset : POINT
            MandatoryOrientation : UInt32
            HardwareInfo : this._HardwareInfo_e__Struct
            struct _HardwareInfo_e__Struct {
                ColorSensorId : UInt16[260]
                InfraredSensorId : UInt16[260]
                InfraredSensorRotationAngle : UInt32
            }
        }
        struct _Fingerprint_e__Struct {
            Reserved : UInt32
        }
        struct _Iris_e__Struct {
            FrameSize : RECT
            FrameOffset : POINT
            MandatoryOrientation : UInt32
        }
        struct _Voice_e__Struct {
            Reserved : UInt32
        }
    }
}
struct WINBIO_EXTENDED_ENGINE_INFO {
    GenericEngineCapabilities : UInt32
    Factor : UInt32
    Specific : this._Specific_e__Union
    struct _Specific_e__Union {
        union {
            Null : UInt32
            FacialFeatures : this._FacialFeatures_e__Struct
            Fingerprint : this._Fingerprint_e__Struct
            Iris : this._Iris_e__Struct
            Voice : this._Voice_e__Struct
        }
        struct _FacialFeatures_e__Struct {
            Capabilities : UInt32
            EnrollmentRequirements : this._EnrollmentRequirements_e__Struct
            struct _EnrollmentRequirements_e__Struct {
                Null : UInt32
            }
        }
        struct _Fingerprint_e__Struct {
            Capabilities : UInt32
            EnrollmentRequirements : this._EnrollmentRequirements_e__Struct
            struct _EnrollmentRequirements_e__Struct {
                GeneralSamples : UInt32
                Center : UInt32
                TopEdge : UInt32
                BottomEdge : UInt32
                LeftEdge : UInt32
                RightEdge : UInt32
            }
        }
        struct _Iris_e__Struct {
            Capabilities : UInt32
            EnrollmentRequirements : this._EnrollmentRequirements_e__Struct
            struct _EnrollmentRequirements_e__Struct {
                Null : UInt32
            }
        }
        struct _Voice_e__Struct {
            Capabilities : UInt32
            EnrollmentRequirements : this._EnrollmentRequirements_e__Struct
            struct _EnrollmentRequirements_e__Struct {
                Null : UInt32
            }
        }
    }
}
struct WINBIO_EXTENDED_STORAGE_INFO {
    GenericStorageCapabilities : UInt32
    Factor : UInt32
    Specific : this._Specific_e__Union
    struct _Specific_e__Union {
        union {
            Null : UInt32
            FacialFeatures : this._FacialFeatures_e__Struct
            Fingerprint : this._Fingerprint_e__Struct
            Iris : this._Iris_e__Struct
            Voice : this._Voice_e__Struct
        }
        struct _FacialFeatures_e__Struct {
            Capabilities : UInt32
        }
        struct _Fingerprint_e__Struct {
            Capabilities : UInt32
        }
        struct _Iris_e__Struct {
            Capabilities : UInt32
        }
        struct _Voice_e__Struct {
            Capabilities : UInt32
        }
    }
}
struct WINBIO_EXTENDED_ENROLLMENT_STATUS {
    TemplateStatus : HRESULT
    RejectDetail : UInt32
    PercentComplete : UInt32
    Factor : UInt32
    SubFactor : UInt8
    Specific : this._Specific_e__Union
    struct _Specific_e__Union {
        union {
            Null : UInt32
            FacialFeatures : this._FacialFeatures_e__Struct
            Fingerprint : this._Fingerprint_e__Struct
            Iris : this._Iris_e__Struct
            Voice : this._Voice_e__Struct
        }
        struct _FacialFeatures_e__Struct {
            BoundingBox : RECT
            Distance : Int32
            OpaqueEngineData : this._OpaqueEngineData_e__Struct
            struct _OpaqueEngineData_e__Struct {
                AdapterId : GUID
                Data : UInt32[78]
            }
        }
        struct _Fingerprint_e__Struct {
            GeneralSamples : UInt32
            Center : UInt32
            TopEdge : UInt32
            BottomEdge : UInt32
            LeftEdge : UInt32
            RightEdge : UInt32
        }
        struct _Iris_e__Struct {
            EyeBoundingBox_1 : RECT
            EyeBoundingBox_2 : RECT
            PupilCenter_1 : POINT
            PupilCenter_2 : POINT
            Distance : Int32
            GridPointCompletionPercent : UInt32
            GridPointIndex : UInt16
            Point3D : this._Point3D_e__Struct
            StopCaptureAndShowCriticalFeedback : BOOL
            struct _Point3D_e__Struct {
                X : Float64
                Y : Float64
                Z : Float64
            }
        }
        struct _Voice_e__Struct {
            Reserved : UInt32
        }
    }
}
struct WINBIO_EXTENDED_UNIT_STATUS {
    Availability : UInt32
    ReasonCode : UInt32
}
struct WINBIO_FP_BU_STATE {
    SensorAttached : BOOL
    CreationResult : HRESULT
}
struct WINBIO_ANTI_SPOOF_POLICY_ACTION extends Int32 {
    static WINBIO_ANTI_SPOOF_DISABLE := 0
    static WINBIO_ANTI_SPOOF_ENABLE := 1
    static WINBIO_ANTI_SPOOF_REMOVE := 2
}
struct WINBIO_POLICY_SOURCE extends Int32 {
    static WINBIO_POLICY_UNKNOWN := 0
    static WINBIO_POLICY_DEFAULT := 1
    static WINBIO_POLICY_LOCAL := 2
    static WINBIO_POLICY_ADMIN := 3
}
struct WINBIO_ANTI_SPOOF_POLICY {
    Action : WINBIO_ANTI_SPOOF_POLICY_ACTION
    Source : WINBIO_POLICY_SOURCE
}
struct WINBIO_CREDENTIAL_TYPE extends Int32 {
    static WINBIO_CREDENTIAL_PASSWORD := 1
    static WINBIO_CREDENTIAL_ALL := -1
}
struct WINBIO_CREDENTIAL_FORMAT extends Int32 {
    static WINBIO_PASSWORD_GENERIC := 1
    static WINBIO_PASSWORD_PACKED := 2
    static WINBIO_PASSWORD_PROTECTED := 3
}
struct WINBIO_CREDENTIAL_STATE extends Int32 {
    static WINBIO_CREDENTIAL_NOT_SET := 1
    static WINBIO_CREDENTIAL_SET := 2
}
struct WINBIO_EXTENDED_ENROLLMENT_PARAMETERS {
    Size : IntPtr
    SubFactor : UInt8
}
struct WINBIO_ACCOUNT_POLICY {
    Identity : WINBIO_IDENTITY
    AntiSpoofBehavior : WINBIO_ANTI_SPOOF_POLICY_ACTION
}
struct WINBIO_PROTECTION_POLICY {
    Version : UInt32
    Identity : WINBIO_IDENTITY
    DatabaseId : GUID
    UserState : Int64
    PolicySize : IntPtr
    Policy : UInt8[128]
}
struct WINBIO_GESTURE_METADATA {
    Size : IntPtr
    BiometricType : UInt32
    MatchType : UInt32
    ProtectionType : UInt32
}
struct WINBIO_ESS_STATE_FLAGS extends Int32 {
    static WINBIO_ESS_REQUIRES_TPM2 := 1
    static WINBIO_ESS_REQUIRES_VBS_CAPABLE := 2
    static WINBIO_ESS_REQUIRES_NON_VBS_WINDOWS_HELLO_ABSENCE := 4
    static WINBIO_ESS_REQUIRES_VBS_WINDOWS_HELLO := 8
    static WINBIO_ESS_REQUIRES_VBS_RUNNING := 16
    static WINBIO_ESS_REQUIRES_VBS_ENCRYPTION_KEY := 32
    static WINBIO_ESS_REQUIRES_ENABLEMENT := 64
    static WINBIO_ESS_MANAGED_BY_POLICY := 128
    static WINBIO_ESS_REQUIRES_NON_VBS_BIOMETRIC_ENROLLMENT_ABSENCE := 256
    static WINBIO_ESS_REQUIRES_VBS_BIOMETRIC_ENROLLMENT := 512
    static WINBIO_ESS_REQUIRES_FACE_SENSOR := 1024
    static WINBIO_ESS_REQUIRES_FPR_SENSOR := 2048
    static WINBIO_ESS_REQUIRES_ISOLATED_PROCESS := 4096
    static WINBIO_ESS_BLOCKED_NON_ESS_FPR := 8192
    static WINBIO_ESS_BLOCKED_NON_ESS_CAMERA := 16384
    static WINBIO_ESS_SOURCE_DEFAULT := 32768
}
struct WINBIO_CONNECTED_SENSOR {
    biometricType : UInt32
    isEnhancedSignInSecurityCapable : BOOL
}
struct WINBIO_ASYNC_NOTIFICATION_METHOD extends Int32 {
    static WINBIO_ASYNC_NOTIFY_NONE := 0
    static WINBIO_ASYNC_NOTIFY_CALLBACK := 1
    static WINBIO_ASYNC_NOTIFY_MESSAGE := 2
    static WINBIO_ASYNC_NOTIFY_MAXIMUM_VALUE := 3
}
struct WINBIO_ASYNC_RESULT {
    SessionHandle : UInt32
    Operation : UInt32
    SequenceNumber : Int64
    TimeStamp : Int64
    ApiStatus : HRESULT
    UnitId : UInt32
    UserData : Struct.Ptr
    Parameters : this._Parameters_e__Union
    struct _Parameters_e__Union {
        union {
            Verify : this._Verify_e__Struct
            Identify : this._Identify_e__Struct
            EnrollBegin : this._EnrollBegin_e__Struct
            EnrollCapture : this._EnrollCapture_e__Struct
            EnrollCommit : this._EnrollCommit_e__Struct
            EnumEnrollments : this._EnumEnrollments_e__Struct
            CaptureSample : this._CaptureSample_e__Struct
            DeleteTemplate : this._DeleteTemplate_e__Struct
            GetProperty : this._GetProperty_e__Struct
            SetProperty : this._SetProperty_e__Struct
            GetEvent : this._GetEvent_e__Struct
            ControlUnit : this._ControlUnit_e__Struct
            EnumServiceProviders : this._EnumServiceProviders_e__Struct
            EnumBiometricUnits : this._EnumBiometricUnits_e__Struct
            EnumDatabases : this._EnumDatabases_e__Struct
            VerifyAndReleaseTicket : this._VerifyAndReleaseTicket_e__Struct
            IdentifyAndReleaseTicket : this._IdentifyAndReleaseTicket_e__Struct
            EnrollSelect : this._EnrollSelect_e__Struct
            MonitorPresence : this._MonitorPresence_e__Struct
            GetProtectionPolicy : this._GetProtectionPolicy_e__Struct
            NotifyUnitStatusChange : this._NotifyUnitStatusChange_e__Struct
        }
        struct _Verify_e__Struct {
            Match : BOOLEAN
            RejectDetail : UInt32
        }
        struct _Identify_e__Struct {
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
            RejectDetail : UInt32
        }
        struct _EnrollBegin_e__Struct {
            SubFactor : UInt8
        }
        struct _EnrollCapture_e__Struct {
            RejectDetail : UInt32
        }
        struct _EnrollCommit_e__Struct {
            Identity : WINBIO_IDENTITY
            IsNewTemplate : BOOLEAN
        }
        struct _EnumEnrollments_e__Struct {
            Identity : WINBIO_IDENTITY
            SubFactorCount : IntPtr
            SubFactorArray : UInt8.Ptr
        }
        struct _CaptureSample_e__Struct {
            Sample : WINBIO_BIR.Ptr
            SampleSize : IntPtr
            RejectDetail : UInt32
        }
        struct _DeleteTemplate_e__Struct {
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
        }
        struct _GetProperty_e__Struct {
            PropertyType : UInt32
            PropertyId : UInt32
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
            PropertyBufferSize : IntPtr
            PropertyBuffer : Struct.Ptr
        }
        struct _SetProperty_e__Struct {
            PropertyType : UInt32
            PropertyId : UInt32
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
            PropertyBufferSize : IntPtr
            PropertyBuffer : Struct.Ptr
        }
        struct _GetEvent_e__Struct {
            Event : WINBIO_EVENT
        }
        struct _ControlUnit_e__Struct {
            Component : WINBIO_COMPONENT
            ControlCode : UInt32
            OperationStatus : UInt32
            SendBuffer : UInt8.Ptr
            SendBufferSize : IntPtr
            ReceiveBuffer : UInt8.Ptr
            ReceiveBufferSize : IntPtr
            ReceiveDataSize : IntPtr
        }
        struct _EnumServiceProviders_e__Struct {
            BspCount : IntPtr
            BspSchemaArray : WINBIO_BSP_SCHEMA.Ptr
        }
        struct _EnumBiometricUnits_e__Struct {
            UnitCount : IntPtr
            UnitSchemaArray : WINBIO_UNIT_SCHEMA.Ptr
        }
        struct _EnumDatabases_e__Struct {
            StorageCount : IntPtr
            StorageSchemaArray : WINBIO_STORAGE_SCHEMA.Ptr
        }
        struct _VerifyAndReleaseTicket_e__Struct {
            Match : BOOLEAN
            RejectDetail : UInt32
            Ticket : Int64
        }
        struct _IdentifyAndReleaseTicket_e__Struct {
            Identity : WINBIO_IDENTITY
            SubFactor : UInt8
            RejectDetail : UInt32
            Ticket : Int64
        }
        struct _EnrollSelect_e__Struct {
            SelectorValue : Int64
        }
        struct _MonitorPresence_e__Struct {
            ChangeType : UInt32
            PresenceCount : IntPtr
            PresenceArray : WINBIO_PRESENCE.Ptr
        }
        struct _GetProtectionPolicy_e__Struct {
            Identity : WINBIO_IDENTITY
            Policy : WINBIO_PROTECTION_POLICY
        }
        struct _NotifyUnitStatusChange_e__Struct {
            ExtendedStatus : WINBIO_EXTENDED_UNIT_STATUS
        }
    }
}
struct PWINBIO_ASYNC_COMPLETION_CALLBACK extends FunctionPointer {
    static Types := [WINBIO_ASYNC_RESULT.Ptr, "Void"]
}
struct PWINBIO_VERIFY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, UInt32, BOOLEAN, UInt32, "Void"]
}
struct PWINBIO_IDENTIFY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, UInt32, WINBIO_IDENTITY.Ptr, UInt8, UInt32, "Void"]
}
struct PWINBIO_LOCATE_SENSOR_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, UInt32, "Void"]
}
struct PWINBIO_ENROLL_CAPTURE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, UInt32, "Void"]
}
struct PWINBIO_EVENT_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, WINBIO_EVENT.Ptr, "Void"]
}
struct PWINBIO_CAPTURE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT, UInt32, WINBIO_BIR.Ptr, IntPtr, UInt32, "Void"]
}
struct WINBIO_STORAGE_RECORD {
    Identity : WINBIO_IDENTITY.Ptr
    SubFactor : UInt8
    IndexVector : UInt32.Ptr
    IndexElementCount : IntPtr
    TemplateBlob : UInt8.Ptr
    TemplateBlobSize : IntPtr
    PayloadBlob : UInt8.Ptr
    PayloadBlobSize : IntPtr
}
struct WINBIO_PIPELINE {
    SensorHandle : HANDLE
    EngineHandle : HANDLE
    StorageHandle : HANDLE
    SensorInterface : WINBIO_SENSOR_INTERFACE.Ptr
    EngineInterface : WINBIO_ENGINE_INTERFACE.Ptr
    StorageInterface : WINBIO_STORAGE_INTERFACE.Ptr
    SensorContext : WINIBIO_SENSOR_CONTEXT.Ptr
    EngineContext : WINIBIO_ENGINE_CONTEXT.Ptr
    StorageContext : WINIBIO_STORAGE_CONTEXT.Ptr
    FrameworkInterface : WINBIO_FRAMEWORK_INTERFACE.Ptr
}
struct WINBIO_ADAPTER_INTERFACE_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct PIBIO_SENSOR_ATTACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_DETACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_CLEAR_CONTEXT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_QUERY_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_RESET_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_SET_MODE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, HRESULT]
}
struct PIBIO_SENSOR_SET_INDICATOR_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, HRESULT]
}
struct PIBIO_SENSOR_GET_INDICATOR_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_START_CAPTURE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8, OVERLAPPED.Ptr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_FINISH_CAPTURE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_BIR.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_CANCEL_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8, UInt8, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_CONTROL_UNIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, HRESULT]
}
struct PIBIO_SENSOR_PIPELINE_INIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_PIPELINE_CLEANUP_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_ACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_DEACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_SENSOR_INFO.Ptr, IntPtr, HRESULT]
}
struct PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, HRESULT]
}
struct PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, HRESULT]
}
struct PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID, UInt8.Ptr, IntPtr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_CONNECT_SECURE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_SECURE_CONNECTION_PARAMS.Ptr, WINBIO_SECURE_CONNECTION_DATA.Ptr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_START_CAPTURE_EX_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8, UInt8.Ptr, IntPtr, UInt8, OVERLAPPED.Ptr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_START_NOTIFY_WAKE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, OVERLAPPED.Ptr.Ptr, HRESULT]
}
struct PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct WINBIO_SENSOR_INTERFACE {
    Version : WINBIO_ADAPTER_INTERFACE_VERSION
    Type : UInt32
    Size : IntPtr
    AdapterId : GUID
    Attach : PIBIO_SENSOR_ATTACH_FN
    Detach : PIBIO_SENSOR_DETACH_FN
    ClearContext : PIBIO_SENSOR_CLEAR_CONTEXT_FN
    QueryStatus : PIBIO_SENSOR_QUERY_STATUS_FN
    Reset : PIBIO_SENSOR_RESET_FN
    SetMode : PIBIO_SENSOR_SET_MODE_FN
    SetIndicatorStatus : PIBIO_SENSOR_SET_INDICATOR_STATUS_FN
    GetIndicatorStatus : PIBIO_SENSOR_GET_INDICATOR_STATUS_FN
    StartCapture : PIBIO_SENSOR_START_CAPTURE_FN
    FinishCapture : PIBIO_SENSOR_FINISH_CAPTURE_FN
    ExportSensorData : PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN
    Cancel : PIBIO_SENSOR_CANCEL_FN
    PushDataToEngine : PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN
    ControlUnit : PIBIO_SENSOR_CONTROL_UNIT_FN
    ControlUnitPrivileged : PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN
    NotifyPowerChange : PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN
    PipelineInit : PIBIO_SENSOR_PIPELINE_INIT_FN
    PipelineCleanup : PIBIO_SENSOR_PIPELINE_CLEANUP_FN
    Activate : PIBIO_SENSOR_ACTIVATE_FN
    Deactivate : PIBIO_SENSOR_DEACTIVATE_FN
    QueryExtendedInfo : PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN
    QueryCalibrationFormats : PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN
    SetCalibrationFormat : PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN
    AcceptCalibrationData : PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN
    AsyncImportRawBuffer : PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN
    AsyncImportSecureBuffer : PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN
    QueryPrivateSensorType : PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN
    ConnectSecure : PIBIO_SENSOR_CONNECT_SECURE_FN
    StartCaptureEx : PIBIO_SENSOR_START_CAPTURE_EX_FN
    StartNotifyWake : PIBIO_SENSOR_START_NOTIFY_WAKE_FN
    FinishNotifyWake : PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN
}
struct PWINBIO_QUERY_SENSOR_INTERFACE_FN extends FunctionPointer {
    static Types := [WINBIO_SENSOR_INTERFACE.Ptr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_ATTACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_DETACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_CLEAR_CONTEXT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_REGISTERED_FORMAT.Ptr, GUID.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, IntPtr.Ptr, UInt8.Ptr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_SET_HASH_ALGORITHM_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr, UInt8.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_BIR.Ptr, IntPtr, UInt8, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8, WINBIO_BIR.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_VERIFY_FEATURE_SET_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8, BOOLEAN.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_CREATE_ENROLLMENT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_UPDATE_ENROLLMENT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8.Ptr, BOOLEAN.Ptr, HRESULT]
}
struct PIBIO_ENGINE_COMMIT_ENROLLMENT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8, UInt8.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_DISCARD_ENROLLMENT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_CONTROL_UNIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, HRESULT]
}
struct PIBIO_ENGINE_RESERVED_1_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, HRESULT]
}
struct PIBIO_ENGINE_PIPELINE_INIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_PIPELINE_CLEANUP_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_ACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_DEACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_ENGINE_INFO.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_IDENTIFY_ALL_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, WINBIO_PRESENCE.Ptr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, Int64, HRESULT]
}
struct PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_ENROLLMENT_PARAMETERS.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_ENROLLMENT_STATUS.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_REFRESH_CACHE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, IntPtr, GUID.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, BOOLEAN.Ptr, UInt8.Ptr, IntPtr.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_ACCOUNT_POLICY.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_CREATE_KEY_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, WINBIO_IDENTITY.Ptr, UInt8.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, HRESULT]
}
struct PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, WINBIO_IDENTITY.Ptr, UInt8.Ptr, UInt32.Ptr, UInt8.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct WINBIO_ENGINE_INTERFACE {
    Version : WINBIO_ADAPTER_INTERFACE_VERSION
    Type : UInt32
    Size : IntPtr
    AdapterId : GUID
    Attach : PIBIO_ENGINE_ATTACH_FN
    Detach : PIBIO_ENGINE_DETACH_FN
    ClearContext : PIBIO_ENGINE_CLEAR_CONTEXT_FN
    QueryPreferredFormat : PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN
    QueryIndexVectorSize : PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN
    QueryHashAlgorithms : PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN
    SetHashAlgorithm : PIBIO_ENGINE_SET_HASH_ALGORITHM_FN
    QuerySampleHint : PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN
    AcceptSampleData : PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN
    ExportEngineData : PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN
    VerifyFeatureSet : PIBIO_ENGINE_VERIFY_FEATURE_SET_FN
    IdentifyFeatureSet : PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN
    CreateEnrollment : PIBIO_ENGINE_CREATE_ENROLLMENT_FN
    UpdateEnrollment : PIBIO_ENGINE_UPDATE_ENROLLMENT_FN
    GetEnrollmentStatus : PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN
    GetEnrollmentHash : PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN
    CheckForDuplicate : PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN
    CommitEnrollment : PIBIO_ENGINE_COMMIT_ENROLLMENT_FN
    DiscardEnrollment : PIBIO_ENGINE_DISCARD_ENROLLMENT_FN
    ControlUnit : PIBIO_ENGINE_CONTROL_UNIT_FN
    ControlUnitPrivileged : PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN
    NotifyPowerChange : PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN
    Reserved_1 : PIBIO_ENGINE_RESERVED_1_FN
    PipelineInit : PIBIO_ENGINE_PIPELINE_INIT_FN
    PipelineCleanup : PIBIO_ENGINE_PIPELINE_CLEANUP_FN
    Activate : PIBIO_ENGINE_ACTIVATE_FN
    Deactivate : PIBIO_ENGINE_DEACTIVATE_FN
    QueryExtendedInfo : PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN
    IdentifyAll : PIBIO_ENGINE_IDENTIFY_ALL_FN
    SetEnrollmentSelector : PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN
    SetEnrollmentParameters : PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN
    QueryExtendedEnrollmentStatus : PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN
    RefreshCache : PIBIO_ENGINE_REFRESH_CACHE_FN
    SelectCalibrationFormat : PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN
    QueryCalibrationData : PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN
    SetAccountPolicy : PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN
    CreateKey : PIBIO_ENGINE_CREATE_KEY_FN
    IdentifyFeatureSetSecure : PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN
    AcceptPrivateSensorTypeInfo : PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN
    CreateEnrollmentAuthenticated : PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN
    IdentifyFeatureSetAuthenticated : PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN
}
struct PWINBIO_QUERY_ENGINE_INTERFACE_FN extends FunctionPointer {
    static Types := [WINBIO_ENGINE_INTERFACE.Ptr.Ptr, HRESULT]
}
struct PIBIO_STORAGE_ATTACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_DETACH_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_CLEAR_CONTEXT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_CREATE_DATABASE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, UInt32, GUID.Ptr, PWSTR, PWSTR, IntPtr, IntPtr, HRESULT]
}
struct PIBIO_STORAGE_ERASE_DATABASE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, PWSTR, PWSTR, HRESULT]
}
struct PIBIO_STORAGE_OPEN_DATABASE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, PWSTR, PWSTR, HRESULT]
}
struct PIBIO_STORAGE_CLOSE_DATABASE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_GET_DATA_FORMAT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID.Ptr, WINBIO_VERSION.Ptr, HRESULT]
}
struct PIBIO_STORAGE_GET_DATABASE_SIZE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_STORAGE_ADD_RECORD_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_STORAGE_RECORD.Ptr, HRESULT]
}
struct PIBIO_STORAGE_DELETE_RECORD_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8, HRESULT]
}
struct PIBIO_STORAGE_QUERY_BY_SUBJECT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8, HRESULT]
}
struct PIBIO_STORAGE_QUERY_BY_CONTENT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8, UInt32.Ptr, IntPtr, HRESULT]
}
struct PIBIO_STORAGE_GET_RECORD_COUNT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_STORAGE_FIRST_RECORD_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_NEXT_RECORD_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_GET_CURRENT_RECORD_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_STORAGE_RECORD.Ptr, HRESULT]
}
struct PIBIO_STORAGE_CONTROL_UNIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, IntPtr.Ptr, UInt32.Ptr, HRESULT]
}
struct PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, HRESULT]
}
struct PIBIO_STORAGE_PIPELINE_INIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_PIPELINE_CLEANUP_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_ACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_DEACTIVATE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_STORAGE_INFO.Ptr, IntPtr, HRESULT]
}
struct PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, BOOLEAN, HRESULT]
}
struct PIBIO_STORAGE_RESERVED_1_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, Int64.Ptr, Int64.Ptr, HRESULT]
}
struct PIBIO_STORAGE_RESERVED_2_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, HRESULT]
}
struct PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, UInt8, WINBIO_STORAGE_RECORD.Ptr, HRESULT]
}
struct PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_STORAGE_RECORD.Ptr, HRESULT]
}
struct WINBIO_STORAGE_INTERFACE {
    Version : WINBIO_ADAPTER_INTERFACE_VERSION
    Type : UInt32
    Size : IntPtr
    AdapterId : GUID
    Attach : PIBIO_STORAGE_ATTACH_FN
    Detach : PIBIO_STORAGE_DETACH_FN
    ClearContext : PIBIO_STORAGE_CLEAR_CONTEXT_FN
    CreateDatabase : PIBIO_STORAGE_CREATE_DATABASE_FN
    EraseDatabase : PIBIO_STORAGE_ERASE_DATABASE_FN
    OpenDatabase : PIBIO_STORAGE_OPEN_DATABASE_FN
    CloseDatabase : PIBIO_STORAGE_CLOSE_DATABASE_FN
    GetDataFormat : PIBIO_STORAGE_GET_DATA_FORMAT_FN
    GetDatabaseSize : PIBIO_STORAGE_GET_DATABASE_SIZE_FN
    AddRecord : PIBIO_STORAGE_ADD_RECORD_FN
    DeleteRecord : PIBIO_STORAGE_DELETE_RECORD_FN
    QueryBySubject : PIBIO_STORAGE_QUERY_BY_SUBJECT_FN
    QueryByContent : PIBIO_STORAGE_QUERY_BY_CONTENT_FN
    GetRecordCount : PIBIO_STORAGE_GET_RECORD_COUNT_FN
    FirstRecord : PIBIO_STORAGE_FIRST_RECORD_FN
    NextRecord : PIBIO_STORAGE_NEXT_RECORD_FN
    GetCurrentRecord : PIBIO_STORAGE_GET_CURRENT_RECORD_FN
    ControlUnit : PIBIO_STORAGE_CONTROL_UNIT_FN
    ControlUnitPrivileged : PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN
    NotifyPowerChange : PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN
    PipelineInit : PIBIO_STORAGE_PIPELINE_INIT_FN
    PipelineCleanup : PIBIO_STORAGE_PIPELINE_CLEANUP_FN
    Activate : PIBIO_STORAGE_ACTIVATE_FN
    Deactivate : PIBIO_STORAGE_DEACTIVATE_FN
    QueryExtendedInfo : PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN
    NotifyDatabaseChange : PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN
    Reserved1 : PIBIO_STORAGE_RESERVED_1_FN
    Reserved2 : PIBIO_STORAGE_RESERVED_2_FN
    UpdateRecordBegin : PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN
    UpdateRecordCommit : PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN
}
struct PWINBIO_QUERY_STORAGE_INTERFACE_FN extends FunctionPointer {
    static Types := [WINBIO_STORAGE_INTERFACE.Ptr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_EXTENDED_UNIT_STATUS.Ptr, IntPtr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, IntPtr, Struct.Ptr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_FREE_MEMORY_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, Struct.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_GET_PROPERTY_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt32, UInt32, WINBIO_IDENTITY.Ptr, UInt8, Struct.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID, Struct.Ptr.Ptr, IntPtr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, GUID, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, WINBIO_IDENTITY.Ptr, IntPtr.Ptr, WINBIO_IDENTITY.Ptr.Ptr, HRESULT]
}
struct PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN extends FunctionPointer {
    static Types := [WINBIO_PIPELINE.Ptr, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, UInt8.Ptr, IntPtr, HRESULT]
}
struct WINBIO_FRAMEWORK_INTERFACE {
    Version : WINBIO_ADAPTER_INTERFACE_VERSION
    Type : UInt32
    Size : IntPtr
    AdapterId : GUID
    SetUnitStatus : PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN
    VsmStorageAttach : PIBIO_STORAGE_ATTACH_FN
    VsmStorageDetach : PIBIO_STORAGE_DETACH_FN
    VsmStorageClearContext : PIBIO_STORAGE_CLEAR_CONTEXT_FN
    VsmStorageCreateDatabase : PIBIO_STORAGE_CREATE_DATABASE_FN
    VsmStorageOpenDatabase : PIBIO_STORAGE_OPEN_DATABASE_FN
    VsmStorageCloseDatabase : PIBIO_STORAGE_CLOSE_DATABASE_FN
    VsmStorageDeleteRecord : PIBIO_STORAGE_DELETE_RECORD_FN
    VsmStorageNotifyPowerChange : PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN
    VsmStoragePipelineInit : PIBIO_STORAGE_PIPELINE_INIT_FN
    VsmStoragePipelineCleanup : PIBIO_STORAGE_PIPELINE_CLEANUP_FN
    VsmStorageActivate : PIBIO_STORAGE_ACTIVATE_FN
    VsmStorageDeactivate : PIBIO_STORAGE_DEACTIVATE_FN
    VsmStorageQueryExtendedInfo : PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN
    VsmStorageCacheClear : PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN
    VsmStorageCacheImportBegin : PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN
    VsmStorageCacheImportNext : PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN
    VsmStorageCacheImportEnd : PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN
    VsmStorageCacheExportBegin : PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN
    VsmStorageCacheExportNext : PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN
    VsmStorageCacheExportEnd : PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN
    VsmSensorAttach : PIBIO_SENSOR_ATTACH_FN
    VsmSensorDetach : PIBIO_SENSOR_DETACH_FN
    VsmSensorClearContext : PIBIO_SENSOR_CLEAR_CONTEXT_FN
    VsmSensorPushDataToEngine : PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN
    VsmSensorNotifyPowerChange : PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN
    VsmSensorPipelineInit : PIBIO_SENSOR_PIPELINE_INIT_FN
    VsmSensorPipelineCleanup : PIBIO_SENSOR_PIPELINE_CLEANUP_FN
    VsmSensorActivate : PIBIO_SENSOR_ACTIVATE_FN
    VsmSensorDeactivate : PIBIO_SENSOR_DEACTIVATE_FN
    VsmSensorAsyncImportRawBuffer : PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN
    VsmSensorAsyncImportSecureBuffer : PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN
    Reserved1 : PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN
    Reserved2 : PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN
    Reserved3 : PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN
    Reserved4 : PIBIO_STORAGE_RESERVED_1_FN
    Reserved5 : PIBIO_STORAGE_RESERVED_2_FN
    AllocateMemory : PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN
    FreeMemory : PIBIO_FRAMEWORK_FREE_MEMORY_FN
    GetProperty : PIBIO_FRAMEWORK_GET_PROPERTY_FN
    LockAndValidateSecureBuffer : PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN
    ReleaseSecureBuffer : PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN
    QueryAuthorizedEnrollments : PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN
    DecryptSample : PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN
}
struct WINBIO_SENSOR_ATTRIBUTES {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    WinBioVersion : WINBIO_VERSION
    SensorType : UInt32
    SensorSubType : UInt32
    Capabilities : UInt32
    ManufacturerName : UInt16[256]
    ModelName : UInt16[256]
    SerialNumber : UInt16[256]
    FirmwareVersion : WINBIO_VERSION
    SupportedFormatEntries : UInt32
    SupportedFormat : WINBIO_REGISTERED_FORMAT[1]
}
struct WINBIO_DATA {
    Size : UInt32
    Data : UInt8[1]
}
struct WINBIO_UPDATE_FIRMWARE {
    PayloadSize : UInt32
    FirmwareData : WINBIO_DATA
}
struct WINBIO_CALIBRATION_INFO {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    CalibrationData : WINBIO_DATA
}
struct WINBIO_DIAGNOSTICS {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    SensorStatus : UInt32
    VendorDiagnostics : WINBIO_DATA
}
struct WINBIO_BLANK_PAYLOAD {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
}
struct WINBIO_CAPTURE_PARAMETERS {
    PayloadSize : UInt32
    Purpose : UInt8
    Format : WINBIO_REGISTERED_FORMAT
    VendorFormat : GUID
    Flags : UInt8
}
struct WINBIO_CAPTURE_DATA {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    SensorStatus : UInt32
    RejectDetail : UInt32
    CaptureData : WINBIO_DATA
}
struct WINBIO_SUPPORTED_ALGORITHMS {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    NumberOfAlgorithms : UInt32
    AlgorithmData : WINBIO_DATA
}
struct WINBIO_GET_INDICATOR {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    IndicatorStatus : UInt32
}
struct WINBIO_SET_INDICATOR {
    PayloadSize : UInt32
    IndicatorStatus : UInt32
}
struct WINBIO_PRIVATE_SENSOR_TYPE_INFO {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    PrivateSensorTypeInfo : WINBIO_DATA
}
struct WINBIO_ENCRYPTED_CAPTURE_PARAMS {
    PayloadSize : UInt32
    Purpose : UInt8
    Format : WINBIO_REGISTERED_FORMAT
    VendorFormat : GUID
    Flags : UInt8
    NonceSize : UInt32
}
struct WINBIO_NOTIFY_WAKE {
    PayloadSize : UInt32
    WinBioHresult : HRESULT
    Reason : UInt32
}
