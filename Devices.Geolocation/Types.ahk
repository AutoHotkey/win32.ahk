#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.Sensors\Types.ahk" {LOCATION_DESIRED_ACCURACY}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FILETIME, HRESULT, HWND, NTSTATUS, PROPERTYKEY, SYSTEMTIME}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}

struct LOCATION_REPORT_STATUS extends Int32 {
    static REPORT_NOT_SUPPORTED := 0
    static REPORT_ERROR := 1
    static REPORT_ACCESS_DENIED := 2
    static REPORT_INITIALIZING := 3
    static REPORT_RUNNING := 4
}
struct ILocationReport extends IUnknown {
    static IID := "{C8B7F7EE-75D0-4DB9-B62D-7A0F369CA456}"
    GetSensorID(pSensorID)
      => ComCall(3, this.p, GUID.Ptr, pSensorID)
    GetTimestamp(pCreationTime)
      => ComCall(4, this.p, SYSTEMTIME.Ptr, pCreationTime)
    GetValue(pKey, pValue)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, pKey, PROPVARIANT.Ptr, pValue)
}
struct ILatLongReport extends ILocationReport {
    static IID := "{7FED806D-0EF8-4F07-80AC-36A0BEAE3134}"
    GetLatitude(pLatitude)
      => ComCall(6, this.p, Float64.Ptr, pLatitude)
    GetLongitude(pLongitude)
      => ComCall(7, this.p, Float64.Ptr, pLongitude)
    GetErrorRadius(pErrorRadius)
      => ComCall(8, this.p, Float64.Ptr, pErrorRadius)
    GetAltitude(pAltitude)
      => ComCall(9, this.p, Float64.Ptr, pAltitude)
    GetAltitudeError(pAltitudeError)
      => ComCall(10, this.p, Float64.Ptr, pAltitudeError)
}
struct ICivicAddressReport extends ILocationReport {
    static IID := "{C0B19F70-4ADF-445D-87F2-CAD8FD711792}"
    GetAddressLine1(pbstrAddress1)
      => ComCall(6, this.p, BSTR.Ptr, pbstrAddress1)
    GetAddressLine2(pbstrAddress2)
      => ComCall(7, this.p, BSTR.Ptr, pbstrAddress2)
    GetCity(pbstrCity)
      => ComCall(8, this.p, BSTR.Ptr, pbstrCity)
    GetStateProvince(pbstrStateProvince)
      => ComCall(9, this.p, BSTR.Ptr, pbstrStateProvince)
    GetPostalCode(pbstrPostalCode)
      => ComCall(10, this.p, BSTR.Ptr, pbstrPostalCode)
    GetCountryRegion(pbstrCountryRegion)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCountryRegion)
    GetDetailLevel(pDetailLevel)
      => ComCall(12, this.p, UInt32.Ptr, pDetailLevel)
}
struct ILocation extends IUnknown {
    static IID := "{AB2ECE69-56D9-4F28-B525-DE1B0EE44237}"
    RegisterForReport(pEvents?, reportType, dwRequestedReportInterval)
      => ComCall(3, this.p, ILocationEvents, pEvents?, GUID.Ptr, reportType, UInt32, dwRequestedReportInterval)
    UnregisterForReport(reportType)
      => ComCall(4, this.p, GUID.Ptr, reportType)
    GetReport(reportType, ppLocationReport)
      => ComCall(5, this.p, GUID.Ptr, reportType, ILocationReport.Ptr, ppLocationReport)
    GetReportStatus(reportType, pStatus)
      => ComCall(6, this.p, GUID.Ptr, reportType, LOCATION_REPORT_STATUS.Ptr, pStatus)
    GetReportInterval(reportType, pMilliseconds)
      => ComCall(7, this.p, GUID.Ptr, reportType, UInt32.Ptr, pMilliseconds)
    SetReportInterval(reportType, millisecondsRequested)
      => ComCall(8, this.p, GUID.Ptr, reportType, UInt32, millisecondsRequested)
    GetDesiredAccuracy(reportType, pDesiredAccuracy)
      => ComCall(9, this.p, GUID.Ptr, reportType, LOCATION_DESIRED_ACCURACY.Ptr, pDesiredAccuracy)
    SetDesiredAccuracy(reportType, desiredAccuracy)
      => ComCall(10, this.p, GUID.Ptr, reportType, LOCATION_DESIRED_ACCURACY, desiredAccuracy)
    RequestPermissions(hParent?, pReportTypes, fModal)
      => ComCall(11, this.p, HWND, hParent?, GUID.Ptr, pReportTypes, UInt32, pReportTypes.Length, BOOL, fModal)
}
struct ILocationPower extends IUnknown {
    static IID := "{193E7729-AB6B-4B12-8617-7596E1BB191C}"
    Connect()
      => ComCall(3, this.p)
    Disconnect()
      => ComCall(4, this.p)
}
struct IDefaultLocation extends IUnknown {
    static IID := "{A65AF77E-969A-4A2E-8ACA-33BB7CBB1235}"
    SetReport(reportType, pLocationReport?)
      => ComCall(3, this.p, GUID.Ptr, reportType, ILocationReport, pLocationReport?)
    GetReport(reportType, ppLocationReport)
      => ComCall(4, this.p, GUID.Ptr, reportType, ILocationReport.Ptr, ppLocationReport)
}
struct ILocationEvents extends IUnknown {
    static IID := "{CAE02BBF-798B-4508-A207-35A7906DC73D}"
    OnLocationChanged(reportType, pLocationReport?)
      => ComCall(3, this.p, GUID.Ptr, reportType, ILocationReport, pLocationReport?)
    OnStatusChanged(reportType, newStatus)
      => ComCall(4, this.p, GUID.Ptr, reportType, LOCATION_REPORT_STATUS, newStatus)
}
struct IDispLatLongReport extends IDispatch {
    static IID := "{8AE32723-389B-4A11-9957-5BDD48FC9617}"
    get_Latitude(pVal)
      => ComCall(7, this.p, Float64.Ptr, pVal)
    get_Longitude(pVal)
      => ComCall(8, this.p, Float64.Ptr, pVal)
    get_ErrorRadius(pVal)
      => ComCall(9, this.p, Float64.Ptr, pVal)
    get_Altitude(pVal)
      => ComCall(10, this.p, Float64.Ptr, pVal)
    get_AltitudeError(pVal)
      => ComCall(11, this.p, Float64.Ptr, pVal)
    get_Timestamp(pVal)
      => ComCall(12, this.p, Float64.Ptr, pVal)
}
struct IDispCivicAddressReport extends IDispatch {
    static IID := "{16FF1A34-9E30-42C3-B44D-E22513B5767A}"
    get_AddressLine1(pAddress1)
      => ComCall(7, this.p, BSTR.Ptr, pAddress1)
    get_AddressLine2(pAddress2)
      => ComCall(8, this.p, BSTR.Ptr, pAddress2)
    get_City(pCity)
      => ComCall(9, this.p, BSTR.Ptr, pCity)
    get_StateProvince(pStateProvince)
      => ComCall(10, this.p, BSTR.Ptr, pStateProvince)
    get_PostalCode(pPostalCode)
      => ComCall(11, this.p, BSTR.Ptr, pPostalCode)
    get_CountryRegion(pCountryRegion)
      => ComCall(12, this.p, BSTR.Ptr, pCountryRegion)
    get_DetailLevel(pDetailLevel)
      => ComCall(13, this.p, UInt32.Ptr, pDetailLevel)
    get_Timestamp(pVal)
      => ComCall(14, this.p, Float64.Ptr, pVal)
}
struct ILocationReportFactory extends IDispatch {
    static IID := "{2DAEC322-90B2-47E4-BB08-0DA841935A6B}"
    ListenForReports(requestedReportInterval)
      => ComCall(7, this.p, UInt32, requestedReportInterval)
    StopListeningForReports()
      => ComCall(8, this.p)
    get_Status(pVal)
      => ComCall(9, this.p, UInt32.Ptr, pVal)
    get_ReportInterval(pMilliseconds)
      => ComCall(10, this.p, UInt32.Ptr, pMilliseconds)
    put_ReportInterval(millisecondsRequested)
      => ComCall(11, this.p, UInt32, millisecondsRequested)
    get_DesiredAccuracy(pDesiredAccuracy)
      => ComCall(12, this.p, UInt32.Ptr, pDesiredAccuracy)
    put_DesiredAccuracy(desiredAccuracy)
      => ComCall(13, this.p, UInt32, desiredAccuracy)
    RequestPermissions(hWnd)
      => ComCall(14, this.p, UInt32.Ptr, hWnd)
}
struct ILatLongReportFactory extends ILocationReportFactory {
    static IID := "{3F0804CB-B114-447D-83DD-390174EBB082}"
    get_LatLongReport(pVal)
      => ComCall(15, this.p, IDispLatLongReport.Ptr, pVal)
}
struct ICivicAddressReportFactory extends ILocationReportFactory {
    static IID := "{BF773B93-C64F-4BEE-BEB2-67C0B8DF66E0}"
    get_CivicAddressReport(pVal)
      => ComCall(15, this.p, IDispCivicAddressReport.Ptr, pVal)
}
struct ILatLongReportFactoryEvents extends IDispatch {
    static IID := "{16EE6CB7-AB3C-424B-849F-269BE551FCBC}"
}
struct ICivicAddressReportFactoryEvents extends IDispatch {
    static IID := "{C96039FF-72EC-4617-89BD-84D88BEDC722}"
}
struct GNSS_SUPL_VERSION {
    MajorVersion : UInt32
    MinorVersion : UInt32
}
struct GNSS_SUPL_VERSION_2 {
    MajorVersion : UInt32
    MinorVersion : UInt32
    ServiceIndicator : UInt32
}
struct GNSS_DEVICE_CAPABILITY {
    Size : UInt32
    Version : UInt32
    SupportMultipleFixSessions : BOOL
    SupportMultipleAppSessions : BOOL
    RequireAGnssInjection : BOOL
    AgnssFormatSupported : UInt32
    AgnssFormatPreferred : UInt32
    SupportDistanceTracking : BOOL
    SupportContinuousTracking : BOOL
    Reserved1 : UInt32
    Reserved2 : BOOL
    Reserved3 : BOOL
    Reserved4 : BOOL
    Reserved5 : BOOL
    GeofencingSupport : UInt32
    Reserved6 : BOOL
    Reserved7 : BOOL
    SupportCpLocation : BOOL
    SupportUplV2 : BOOL
    SupportSuplV1 : BOOL
    SupportSuplV2 : BOOL
    SupportedSuplVersion : GNSS_SUPL_VERSION
    MaxGeofencesSupported : UInt32
    SupportMultipleSuplRootCert : BOOL
    GnssBreadCrumbPayloadVersion : UInt32
    MaxGnssBreadCrumbFixes : UInt32
    Unused : UInt8[496]
}
struct GNSS_PLATFORM_CAPABILITY {
    Size : UInt32
    Version : UInt32
    SupportAgnssInjection : BOOL
    AgnssFormatSupported : UInt32
    Unused : UInt8[516]
}
struct GNSS_DRIVERCOMMAND_TYPE extends Int32 {
    static GNSS_SetLocationServiceEnabled := 1
    static GNSS_SetLocationNIRequestAllowed := 2
    static GNSS_ForceSatelliteSystem := 3
    static GNSS_ForceOperationMode := 4
    static GNSS_ResetEngine := 9
    static GNSS_ClearAgnssData := 10
    static GNSS_SetSuplVersion := 12
    static GNSS_SetNMEALogging := 13
    static GNSS_SetUplServerAccessInterval := 14
    static GNSS_SetNiTimeoutInterval := 15
    static GNSS_ResetGeofencesTracking := 16
    static GNSS_SetSuplVersion2 := 17
    static GNSS_CustomCommand := 256
}
struct GNSS_DRIVERCOMMAND_PARAM {
    Size : UInt32
    Version : UInt32
    CommandType : GNSS_DRIVERCOMMAND_TYPE
    Reserved : UInt32
    CommandDataSize : UInt32
    Unused : UInt8[512]
    CommandData : UInt8[1]
}
struct GNSS_FIXSESSIONTYPE extends Int32 {
    static GNSS_FixSession_SingleShot := 1
    static GNSS_FixSession_DistanceTracking := 2
    static GNSS_FixSession_ContinuousTracking := 3
    static GNSS_FixSession_LKG := 4
}
struct GNSS_SINGLESHOT_PARAM {
    Size : UInt32
    Version : UInt32
    ResponseTime : UInt32
}
struct GNSS_DISTANCETRACKING_PARAM {
    Size : UInt32
    Version : UInt32
    MovementThreshold : UInt32
}
struct GNSS_CONTINUOUSTRACKING_PARAM {
    Size : UInt32
    Version : UInt32
    PreferredInterval : UInt32
}
struct GNSS_LKGFIX_PARAM {
    Size : UInt32
    Version : UInt32
}
struct GNSS_FIXSESSION_PARAM {
    Size : UInt32
    Version : UInt32
    FixSessionID : UInt32
    SessionType : GNSS_FIXSESSIONTYPE
    HorizontalAccuracy : UInt32
    HorizontalConfidence : UInt32
    Reserved : UInt32[9]
    FixLevelOfDetails : UInt32
    Anonymous : this._Anonymous_e__Union
    Unused : UInt8[256]
    struct _Anonymous_e__Union {
        union {
            SingleShotParam : GNSS_SINGLESHOT_PARAM
            DistanceParam : GNSS_DISTANCETRACKING_PARAM
            ContinuousParam : GNSS_CONTINUOUSTRACKING_PARAM
            LkgFixParam : GNSS_LKGFIX_PARAM
            UnusedParam : UInt8[268]
        }
    }
}
struct GNSS_STOPFIXSESSION_PARAM {
    Size : UInt32
    Version : UInt32
    FixSessionID : UInt32
    Unused : UInt8[512]
}
struct GNSS_FIXDATA_BASIC {
    Size : UInt32
    Version : UInt32
    Latitude : Float64
    Longitude : Float64
    Altitude : Float64
    Speed : Float64
    Heading : Float64
}
struct GNSS_FIXDATA_BASIC_2 {
    Size : UInt32
    Version : UInt32
    Latitude : Float64
    Longitude : Float64
    Altitude : Float64
    Speed : Float64
    Heading : Float64
    AltitudeEllipsoid : Float64
}
struct GNSS_FIXDATA_ACCURACY {
    Size : UInt32
    Version : UInt32
    HorizontalAccuracy : UInt32
    HorizontalErrorMajorAxis : UInt32
    HorizontalErrorMinorAxis : UInt32
    HorizontalErrorAngle : UInt32
    HeadingAccuracy : UInt32
    AltitudeAccuracy : UInt32
    SpeedAccuracy : UInt32
    HorizontalConfidence : UInt32
    HeadingConfidence : UInt32
    AltitudeConfidence : UInt32
    SpeedConfidence : UInt32
    PositionDilutionOfPrecision : Float32
    HorizontalDilutionOfPrecision : Float32
    VerticalDilutionOfPrecision : Float32
}
struct GNSS_FIXDATA_ACCURACY_2 {
    Size : UInt32
    Version : UInt32
    HorizontalAccuracy : Float64
    HorizontalErrorMajorAxis : Float64
    HorizontalErrorMinorAxis : Float64
    HorizontalErrorAngle : Float64
    HeadingAccuracy : Float64
    AltitudeAccuracy : Float64
    SpeedAccuracy : Float64
    HorizontalConfidence : UInt32
    HeadingConfidence : UInt32
    AltitudeConfidence : UInt32
    SpeedConfidence : UInt32
    PositionDilutionOfPrecision : Float64
    HorizontalDilutionOfPrecision : Float64
    VerticalDilutionOfPrecision : Float64
    GeometricDilutionOfPrecision : Float64
    TimeDilutionOfPrecision : Float64
}
struct GNSS_SATELLITEINFO {
    SatelliteId : UInt32
    UsedInPositiong : BOOL
    Elevation : Float64
    Azimuth : Float64
    SignalToNoiseRatio : Float64
}
struct GNSS_FIXDATA_SATELLITE {
    Size : UInt32
    Version : UInt32
    SatelliteCount : UInt32
    SatelliteArray : GNSS_SATELLITEINFO[64]
}
struct GNSS_FIXDATA {
    Size : UInt32
    Version : UInt32
    FixSessionID : UInt32
    FixTimeStamp : FILETIME
    IsFinalFix : BOOL
    FixStatus : NTSTATUS
    FixLevelOfDetails : UInt32
    BasicData : GNSS_FIXDATA_BASIC
    AccuracyData : GNSS_FIXDATA_ACCURACY
    SatelliteData : GNSS_FIXDATA_SATELLITE
}
struct GNSS_FIXDATA_2 {
    Size : UInt32
    Version : UInt32
    FixSessionID : UInt32
    FixTimeStamp : FILETIME
    IsFinalFix : BOOL
    FixStatus : NTSTATUS
    FixLevelOfDetails : UInt32
    BasicData : GNSS_FIXDATA_BASIC_2
    AccuracyData : GNSS_FIXDATA_ACCURACY_2
    SatelliteData : GNSS_FIXDATA_SATELLITE
}
struct GNSS_BREADCRUMBING_PARAM {
    Size : UInt32
    Version : UInt32
    MaximumHorizontalUncertainty : UInt32
    MinDistanceBetweenFixes : UInt32
    MaximumErrorTimeoutMs : UInt32
    Unused : UInt8[512]
}
struct GNSS_BREADCRUMBING_ALERT_DATA {
    Size : UInt32
    Version : UInt32
    Unused : UInt8[512]
}
struct GNSS_BREADCRUMB_V1 {
    FixTimeStamp : FILETIME
    Latitude : Float64
    Longitude : Float64
    HorizontalAccuracy : UInt32
    Speed : UInt16
    SpeedAccuracy : UInt16
    Altitude : Int16
    AltitudeAccuracy : UInt16
    Heading : Int16
    HeadingAccuracy : UInt8
    FixSuccess : UInt8
}
struct GNSS_BREADCRUMB_LIST {
    Size : UInt32
    Version : UInt32
    NumCrumbs : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            v1 : GNSS_BREADCRUMB_V1[50]
        }
    }
}
struct GNSS_GEOREGIONTYPE extends Int32 {
    static GNSS_GeoRegion_Circle := 1
}
struct GNSS_GEOREGION_CIRCLE {
    Latitude : Float64
    Longitude : Float64
    RadiusInMeters : Float64
}
struct GNSS_GEOREGION {
    Size : UInt32
    Version : UInt32
    GeoRegionType : GNSS_GEOREGIONTYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Circle : GNSS_GEOREGION_CIRCLE
            Unused : UInt8[512]
        }
    }
}
struct GNSS_GEOFENCE_STATE extends Int32 {
    static GNSS_GeofenceState_Unknown := 0
    static GNSS_GeofenceState_Entered := 1
    static GNSS_GeofenceState_Exited := 2
}
struct GNSS_GEOFENCE_CREATE_PARAM {
    Size : UInt32
    Version : UInt32
    AlertTypes : UInt32
    InitialState : GNSS_GEOFENCE_STATE
    Boundary : GNSS_GEOREGION
    Unused : UInt8[512]
}
struct GNSS_GEOFENCE_CREATE_RESPONSE {
    Size : UInt32
    Version : UInt32
    CreationStatus : NTSTATUS
    GeofenceID : UInt32
    Unused : UInt8[512]
}
struct GNSS_GEOFENCE_DELETE_PARAM {
    Size : UInt32
    Version : UInt32
    GeofenceID : UInt32
    Unused : UInt8[512]
}
struct GNSS_GEOFENCE_ALERT_DATA {
    Size : UInt32
    Version : UInt32
    GeofenceID : UInt32
    GeofenceState : GNSS_GEOFENCE_STATE
    FixBasicData : GNSS_FIXDATA_BASIC
    FixAccuracyData : GNSS_FIXDATA_ACCURACY
    Unused : UInt8[512]
}
struct GNSS_GEOFENCES_TRACKINGSTATUS_DATA {
    Size : UInt32
    Version : UInt32
    Status : NTSTATUS
    StatusTimeStamp : FILETIME
    Unused : UInt8[512]
}
struct GNSS_EVENT_TYPE extends Int32 {
    static GNSS_Event_FixAvailable := 1
    static GNSS_Event_RequireAgnss := 2
    static GNSS_Event_Error := 3
    static GNSS_Event_NiRequest := 12
    static GNSS_Event_NmeaData := 13
    static GNSS_Event_GeofenceAlertData := 14
    static GNSS_Event_GeofencesTrackingStatus := 15
    static GNSS_Event_DriverRequest := 16
    static GNSS_Event_BreadcrumbAlertEvent := 17
    static GNSS_Event_FixAvailable_2 := 18
    static GNSS_Event_Custom := 32768
}
struct GNSS_ERRORINFO {
    Size : UInt32
    Version : UInt32
    ErrorCode : UInt32
    IsRecoverable : BOOL
    ErrorDescription : UInt16[256]
    Unused : UInt8[512]
}
struct GNSS_NMEA_DATA {
    Size : UInt32
    Version : UInt32
    NmeaSentences : CHAR[256]
}
struct GNSS_AGNSS_REQUEST_TYPE extends Int32 {
    static GNSS_AGNSS_TimeInjection := 1
    static GNSS_AGNSS_PositionInjection := 2
    static GNSS_AGNSS_BlobInjection := 3
}
struct GNSS_AGNSS_REQUEST_PARAM {
    Size : UInt32
    Version : UInt32
    RequestType : GNSS_AGNSS_REQUEST_TYPE
    BlobFormat : UInt32
}
struct GNSS_NI_PLANE_TYPE extends Int32 {
    static GNSS_NI_SUPL := 1
    static GNSS_NI_CP := 2
    static GNSS_NI_V2UPL := 3
}
struct GNSS_NI_REQUEST_TYPE extends Int32 {
    static GNSS_NI_Request_SingleShot := 1
    static GNSS_NI_Request_AreaTrigger := 2
}
struct GNSS_NI_NOTIFICATION_TYPE extends Int32 {
    static GNSS_NI_NoNotifyNoVerify := 1
    static GNSS_NI_NotifyOnly := 2
    static GNSS_NI_NotifyVerifyDefaultAllow := 3
    static GNSS_NI_NotifyVerifyDefaultNotAllow := 4
    static GNSS_NI_PrivacyOverride := 5
}
struct GNSS_SUPL_NI_INFO {
    Size : UInt32
    Version : UInt32
    RequestorId : UInt16[260]
    ClientName : UInt16[260]
    SuplNiUrl : CHAR[260]
}
struct GNSS_CP_NI_INFO {
    Size : UInt32
    Version : UInt32
    RequestorId : UInt16[260]
    NotificationText : UInt16[260]
}
struct GNSS_V2UPL_NI_INFO {
    Size : UInt32
    Version : UInt32
    RequestorId : UInt16[260]
}
struct GNSS_NI_REQUEST_PARAM {
    Size : UInt32
    Version : UInt32
    RequestId : UInt32
    RequestType : GNSS_NI_REQUEST_TYPE
    NotificationType : GNSS_NI_NOTIFICATION_TYPE
    RequestPlaneType : GNSS_NI_PLANE_TYPE
    Anonymous : this._Anonymous_e__Union
    ResponseTimeInSec : UInt32
    EmergencyLocation : BOOL
    struct _Anonymous_e__Union {
        union {
            SuplNiInfo : GNSS_SUPL_NI_INFO
            CpNiInfo : GNSS_CP_NI_INFO
            V2UplNiInfo : GNSS_V2UPL_NI_INFO
        }
    }
}
struct GNSS_DRIVER_REQUEST extends Int32 {
    static SUPL_CONFIG_DATA := 1
}
struct GNSS_DRIVER_REQUEST_DATA {
    Size : UInt32
    Version : UInt32
    Request : GNSS_DRIVER_REQUEST
    RequestFlag : UInt32
}
struct GNSS_EVENT {
    Size : UInt32
    Version : UInt32
    EventType : GNSS_EVENT_TYPE
    EventDataSize : UInt32
    Unused : UInt8[512]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FixData : GNSS_FIXDATA
            AgnssRequest : GNSS_AGNSS_REQUEST_PARAM
            NiRequest : GNSS_NI_REQUEST_PARAM
            ErrorInformation : GNSS_ERRORINFO
            NmeaData : GNSS_NMEA_DATA
            GeofenceAlertData : GNSS_GEOFENCE_ALERT_DATA
            BreadcrumbAlertData : GNSS_BREADCRUMBING_ALERT_DATA
            GeofencesTrackingStatus : GNSS_GEOFENCES_TRACKINGSTATUS_DATA
            DriverRequestData : GNSS_DRIVER_REQUEST_DATA
            CustomData : UInt8[1]
        }
    }
}
struct GNSS_EVENT_2 {
    Size : UInt32
    Version : UInt32
    EventType : GNSS_EVENT_TYPE
    EventDataSize : UInt32
    Unused : UInt8[512]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            FixData : GNSS_FIXDATA
            FixData2 : GNSS_FIXDATA_2
            AgnssRequest : GNSS_AGNSS_REQUEST_PARAM
            NiRequest : GNSS_NI_REQUEST_PARAM
            ErrorInformation : GNSS_ERRORINFO
            NmeaData : GNSS_NMEA_DATA
            GeofenceAlertData : GNSS_GEOFENCE_ALERT_DATA
            BreadcrumbAlertData : GNSS_BREADCRUMBING_ALERT_DATA
            GeofencesTrackingStatus : GNSS_GEOFENCES_TRACKINGSTATUS_DATA
            DriverRequestData : GNSS_DRIVER_REQUEST_DATA
            CustomData : UInt8[1]
        }
    }
}
struct GNSS_AGNSS_INJECTTIME {
    Size : UInt32
    Version : UInt32
    UtcTime : FILETIME
    TimeUncertainty : UInt32
}
struct GNSS_AGNSS_INJECTPOSITION {
    Size : UInt32
    Version : UInt32
    Age : UInt32
    BasicData : GNSS_FIXDATA_BASIC
    AccuracyData : GNSS_FIXDATA_ACCURACY
}
struct GNSS_AGNSS_INJECTBLOB {
    Size : UInt32
    Version : UInt32
    BlobOui : UInt32
    BlobVersion : UInt32
    AgnssFormat : UInt32
    BlobSize : UInt32
    BlobData : UInt8[1]
}
struct GNSS_AGNSS_INJECT {
    Size : UInt32
    Version : UInt32
    InjectionType : GNSS_AGNSS_REQUEST_TYPE
    InjectionStatus : NTSTATUS
    InjectionDataSize : UInt32
    Unused : UInt8[512]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Time : GNSS_AGNSS_INJECTTIME
            Position : GNSS_AGNSS_INJECTPOSITION
            BlobData : GNSS_AGNSS_INJECTBLOB
        }
    }
}
struct GNSS_SUPL_HSLP_CONFIG {
    Size : UInt32
    Version : UInt32
    SuplHslp : CHAR[260]
    SuplHslpFromImsi : CHAR[260]
    Reserved : UInt32
    Unused : UInt8[512]
}
struct GNSS_SUPL_CERT_ACTION extends Int32 {
    static GNSS_Supl_Cert_Inject := 1
    static GNSS_Supl_Cert_Delete := 2
    static GNSS_Supl_Cert_Purge := 3
}
struct GNSS_SUPL_CERT_CONFIG {
    Size : UInt32
    Version : UInt32
    CertAction : GNSS_SUPL_CERT_ACTION
    SuplCertName : CHAR[260]
    CertSize : UInt32
    Unused : UInt8[512]
    CertData : UInt8[1]
}
struct GNSS_V2UPL_CONFIG {
    Size : UInt32
    Version : UInt32
    MPC : CHAR[260]
    PDE : CHAR[260]
    ApplicationTypeIndicator_MR : UInt8
    Unused : UInt8[512]
}
struct GNSS_NI_USER_RESPONSE extends Int32 {
    static GNSS_Ni_UserResponseAccept := 1
    static GNSS_Ni_UserResponseDeny := 2
    static GNSS_Ni_UserResponseTimeout := 3
}
struct GNSS_NI_RESPONSE {
    Size : UInt32
    Version : UInt32
    RequestId : UInt32
    UserResponse : GNSS_NI_USER_RESPONSE
}
struct GNSS_CWTESTDATA {
    Size : UInt32
    Version : UInt32
    TestResultStatus : NTSTATUS
    SignalToNoiseRatio : Float64
    Frequency : Float64
    Unused : UInt8[512]
}
struct GNSS_SELFTESTCONFIG {
    Size : UInt32
    Version : UInt32
    TestType : UInt32
    Unused : UInt8[512]
    InBufLen : UInt32
    InBuffer : UInt8[1]
}
struct GNSS_SELFTESTRESULT {
    Size : UInt32
    Version : UInt32
    TestResultStatus : NTSTATUS
    Result : UInt32
    PinFailedBitMask : UInt32
    Unused : UInt8[512]
    OutBufLen : UInt32
    OutBuffer : UInt8[1]
}
struct GNSS_CHIPSETINFO {
    Size : UInt32
    Version : UInt32
    ManufacturerID : UInt16[25]
    HardwareID : UInt16[25]
    FirmwareVersion : UInt16[20]
    Unused : UInt8[512]
}
