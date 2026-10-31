#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Devices.PortableDevices\Types.ahk" {IPortableDeviceKeyCollection, IPortableDeviceValues}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, PROPERTYKEY, SYSTEMTIME, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}

struct SensorState extends Int32 {
    static SENSOR_STATE_MIN := 0
    static SENSOR_STATE_READY := 0
    static SENSOR_STATE_NOT_AVAILABLE := 1
    static SENSOR_STATE_NO_DATA := 2
    static SENSOR_STATE_INITIALIZING := 3
    static SENSOR_STATE_ACCESS_DENIED := 4
    static SENSOR_STATE_ERROR := 5
    static SENSOR_STATE_MAX := 5
}
struct SensorConnectionType extends Int32 {
    static SENSOR_CONNECTION_TYPE_PC_INTEGRATED := 0
    static SENSOR_CONNECTION_TYPE_PC_ATTACHED := 1
    static SENSOR_CONNECTION_TYPE_PC_EXTERNAL := 2
}
struct LOCATION_DESIRED_ACCURACY extends Int32 {
    static LOCATION_DESIRED_ACCURACY_DEFAULT := 0
    static LOCATION_DESIRED_ACCURACY_HIGH := 1
}
struct LOCATION_POSITION_SOURCE extends Int32 {
    static LOCATION_POSITION_SOURCE_CELLULAR := 0
    static LOCATION_POSITION_SOURCE_SATELLITE := 1
    static LOCATION_POSITION_SOURCE_WIFI := 2
    static LOCATION_POSITION_SOURCE_IPADDRESS := 3
    static LOCATION_POSITION_SOURCE_UNKNOWN := 4
}
struct SimpleDeviceOrientation extends Int32 {
    static SIMPLE_DEVICE_ORIENTATION_NOT_ROTATED := 0
    static SIMPLE_DEVICE_ORIENTATION_ROTATED_90 := 1
    static SIMPLE_DEVICE_ORIENTATION_ROTATED_180 := 2
    static SIMPLE_DEVICE_ORIENTATION_ROTATED_270 := 3
    static SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_UP := 4
    static SIMPLE_DEVICE_ORIENTATION_ROTATED_FACE_DOWN := 5
}
struct MagnetometerAccuracy extends Int32 {
    static MAGNETOMETER_ACCURACY_UNKNOWN := 0
    static MAGNETOMETER_ACCURACY_UNRELIABLE := 1
    static MAGNETOMETER_ACCURACY_APPROXIMATE := 2
    static MAGNETOMETER_ACCURACY_HIGH := 3
}
struct ISensorManager extends IUnknown {
    static IID := "{BD77DB67-45A8-42DC-8D00-6DCF15F8377A}"
    GetSensorsByCategory(sensorCategory, ppSensorsFound)
      => ComCall(3, this.p, GUID.Ptr, sensorCategory, ISensorCollection.Ptr, ppSensorsFound)
    GetSensorsByType(sensorType, ppSensorsFound)
      => ComCall(4, this.p, GUID.Ptr, sensorType, ISensorCollection.Ptr, ppSensorsFound)
    GetSensorByID(sensorID, ppSensor)
      => ComCall(5, this.p, GUID.Ptr, sensorID, ISensor.Ptr, ppSensor)
    SetEventSink(pEvents?)
      => ComCall(6, this.p, ISensorManagerEvents, pEvents?)
    RequestPermissions(hParent, pSensors?, fModal)
      => ComCall(7, this.p, HWND, hParent, ISensorCollection, pSensors?, BOOL, fModal)
}
struct ILocationPermissions extends IUnknown {
    static IID := "{D5FB0A7F-E74E-44F5-8E02-4806863A274F}"
    GetGlobalLocationPermission(pfEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pfEnabled)
    CheckLocationCapability(dwClientThreadId)
      => ComCall(4, this.p, UInt32, dwClientThreadId)
}
struct ISensorCollection extends IUnknown {
    static IID := "{23571E11-E545-4DD8-A337-B89BF44B10DF}"
    GetAt(ulIndex, ppSensor)
      => ComCall(3, this.p, UInt32, ulIndex, ISensor.Ptr, ppSensor)
    GetCount(pCount)
      => ComCall(4, this.p, UInt32.Ptr, pCount)
    Add(pSensor?)
      => ComCall(5, this.p, ISensor, pSensor?)
    Remove(pSensor?)
      => ComCall(6, this.p, ISensor, pSensor?)
    RemoveByID(sensorID)
      => ComCall(7, this.p, GUID.Ptr, sensorID)
    Clear()
      => ComCall(8, this.p)
}
struct ISensor extends IUnknown {
    static IID := "{5FA08F80-2657-458E-AF75-46F73FA6AC5C}"
    GetID(pID)
      => ComCall(3, this.p, GUID.Ptr, pID)
    GetCategory(pSensorCategory)
      => ComCall(4, this.p, GUID.Ptr, pSensorCategory)
    GetType(pSensorType)
      => ComCall(5, this.p, GUID.Ptr, pSensorType)
    GetFriendlyName(pFriendlyName)
      => ComCall(6, this.p, BSTR.Ptr, pFriendlyName)
    GetProperty(key, pProperty)
      => ComCall(7, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pProperty)
    GetProperties(pKeys?, ppProperties)
      => ComCall(8, this.p, IPortableDeviceKeyCollection, pKeys?, IPortableDeviceValues.Ptr, ppProperties)
    GetSupportedDataFields(ppDataFields)
      => ComCall(9, this.p, IPortableDeviceKeyCollection.Ptr, ppDataFields)
    SetProperties(pProperties?, ppResults)
      => ComCall(10, this.p, IPortableDeviceValues, pProperties?, IPortableDeviceValues.Ptr, ppResults)
    SupportsDataField(key, pIsSupported)
      => ComCall(11, this.p, PROPERTYKEY.Ptr, key, VARIANT_BOOL.Ptr, pIsSupported)
    GetState(pState)
      => ComCall(12, this.p, SensorState.Ptr, pState)
    GetData(ppDataReport)
      => ComCall(13, this.p, ISensorDataReport.Ptr, ppDataReport)
    SupportsEvent(eventGuid, pIsSupported)
      => ComCall(14, this.p, GUID.Ptr, eventGuid, VARIANT_BOOL.Ptr, pIsSupported)
    GetEventInterest(ppValues, pCount)
      => ComCall(15, this.p, GUID.Ptr.Ptr, ppValues, UInt32.Ptr, pCount)
    SetEventInterest(pValues?)
      => ComCall(16, this.p, GUID.Ptr, pValues?, UInt32, pValues?.Length ?? 0)
    SetEventSink(pEvents?)
      => ComCall(17, this.p, ISensorEvents, pEvents?)
}
struct ISensorDataReport extends IUnknown {
    static IID := "{0AB9DF9B-C4B5-4796-8898-0470706A2E1D}"
    GetTimestamp(pTimeStamp)
      => ComCall(3, this.p, SYSTEMTIME.Ptr, pTimeStamp)
    GetSensorValue(pKey, pValue)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, pKey, PROPVARIANT.Ptr, pValue)
    GetSensorValues(pKeys?, ppValues)
      => ComCall(5, this.p, IPortableDeviceKeyCollection, pKeys?, IPortableDeviceValues.Ptr, ppValues)
}
struct ISensorManagerEvents extends IUnknown {
    static IID := "{9B3B0B86-266A-4AAD-B21F-FDE5501001B7}"
    OnSensorEnter(pSensor?, state)
      => ComCall(3, this.p, ISensor, pSensor?, SensorState, state)
}
struct ISensorEvents extends IUnknown {
    static IID := "{5D8DCC91-4641-47E7-B7C3-B74F48A6C391}"
    OnStateChanged(pSensor?, state)
      => ComCall(3, this.p, ISensor, pSensor?, SensorState, state)
    OnDataUpdated(pSensor?, pNewData?)
      => ComCall(4, this.p, ISensor, pSensor?, ISensorDataReport, pNewData?)
    OnEvent(pSensor?, eventID, pEventData?)
      => ComCall(5, this.p, ISensor, pSensor?, GUID.Ptr, eventID, IPortableDeviceValues, pEventData?)
    OnLeave(ID)
      => ComCall(6, this.p, GUID.Ptr, ID)
}
struct ACTIVITY_STATE_COUNT extends Int32 {
    static ActivityStateCount := 8
}
struct ACTIVITY_STATE extends Int32 {
    static ActivityState_Unknown := 1
    static ActivityState_Stationary := 2
    static ActivityState_Fidgeting := 4
    static ActivityState_Walking := 8
    static ActivityState_Running := 16
    static ActivityState_InVehicle := 32
    static ActivityState_Biking := 64
    static ActivityState_Idle := 128
    static ActivityState_Max := 256
    static ActivityState_Force_Dword := -1
}
struct ELEVATION_CHANGE_MODE extends Int32 {
    static ElevationChangeMode_Unknown := 0
    static ElevationChangeMode_Elevator := 1
    static ElevationChangeMode_Stepping := 2
    static ElevationChangeMode_Max := 3
    static ElevationChangeMode_Force_Dword := -1
}
struct MAGNETOMETER_ACCURACY extends Int32 {
    static MagnetometerAccuracy_Unknown := 0
    static MagnetometerAccuracy_Unreliable := 1
    static MagnetometerAccuracy_Approximate := 2
    static MagnetometerAccuracy_High := 3
}
struct PEDOMETER_STEP_TYPE_COUNT extends Int32 {
    static PedometerStepTypeCount := 3
}
struct PEDOMETER_STEP_TYPE extends Int32 {
    static PedometerStepType_Unknown := 1
    static PedometerStepType_Walking := 2
    static PedometerStepType_Running := 4
    static PedometerStepType_Max := 8
    static PedometerStepType_Force_Dword := -1
}
struct PROXIMITY_TYPE extends Int32 {
    static ProximityType_ObjectProximity := 0
    static ProximityType_HumanProximity := 1
    static ProximityType_Force_Dword := -1
}
struct HUMAN_PRESENCE_DETECTION_TYPE_COUNT extends Int32 {
    static HumanPresenceDetectionTypeCount := 4
}
struct HUMAN_PRESENCE_DETECTION_TYPE extends Int32 {
    static HumanPresenceDetectionType_Undefined := 0
    static HumanPresenceDetectionType_VendorDefinedNonBiometric := 1
    static HumanPresenceDetectionType_VendorDefinedBiometric := 2
    static HumanPresenceDetectionType_FacialBiometric := 4
    static HumanPresenceDetectionType_AudioBiometric := 8
    static HumanPresenceDetectionType_Force_Dword := -1
}
struct PROXIMITY_SENSOR_CAPABILITIES extends Int32 {
    static Proximity_Sensor_Human_Presence_Capable := 1
    static Proximity_Sensor_Human_Engagement_Capable := 2
    static Proximity_Sensor_Human_Head_Azimuth_Capable := 4
    static Proximity_Sensor_Human_Head_Altitude_Capable := 8
    static Proximity_Sensor_Human_Head_Roll_Capable := 16
    static Proximity_Sensor_Human_Head_Pitch_Capable := 32
    static Proximity_Sensor_Human_Head_Yaw_Capable := 64
    static Proximity_Sensor_Human_Identification_Capable := 128
    static Proximity_Sensor_Multi_Person_Detection_Capable := 256
    static Proximity_Sensor_Supported_Capabilities := 511
}
struct SIMPLE_DEVICE_ORIENTATION extends Int32 {
    static SimpleDeviceOrientation_NotRotated := 0
    static SimpleDeviceOrientation_Rotated90DegreesCounterclockwise := 1
    static SimpleDeviceOrientation_Rotated180DegreesCounterclockwise := 2
    static SimpleDeviceOrientation_Rotated270DegreesCounterclockwise := 3
    static SimpleDeviceOrientation_Faceup := 4
    static SimpleDeviceOrientation_Facedown := 5
}
struct SENSOR_STATE extends Int32 {
    static SensorState_Initializing := 0
    static SensorState_Idle := 1
    static SensorState_Active := 2
    static SensorState_Error := 3
}
struct SENSOR_CONNECTION_TYPES extends Int32 {
    static SensorConnectionType_Integrated := 0
    static SensorConnectionType_Attached := 1
    static SensorConnectionType_External := 2
}
struct SENSOR_VALUE_PAIR {
    Key : PROPERTYKEY
    Value : PROPVARIANT
}
struct SENSOR_COLLECTION_LIST {
    AllocatedSizeInBytes : UInt32
    Count : UInt32
    List : SENSOR_VALUE_PAIR[1]
}
struct SENSOR_PROPERTY_LIST {
    AllocatedSizeInBytes : UInt32
    Count : UInt32
    List : PROPERTYKEY[1]
}
struct VEC3D {
    X : Float32
    Y : Float32
    Z : Float32
}
struct MATRIX3X3 {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            M : Float32[9]
        }
        struct _Anonymous1_e__Struct {
            A11 : Float32
            A12 : Float32
            A13 : Float32
            A21 : Float32
            A22 : Float32
            A23 : Float32
            A31 : Float32
            A32 : Float32
            A33 : Float32
        }
        struct _Anonymous2_e__Struct {
            V1 : VEC3D
            V2 : VEC3D
            V3 : VEC3D
        }
    }
}
struct QUATERNION {
    X : Float32
    Y : Float32
    Z : Float32
    W : Float32
}
struct AXIS extends Int32 {
    static AXIS_X := 0
    static AXIS_Y := 1
    static AXIS_Z := 2
    static AXIS_MAX := 3
}
