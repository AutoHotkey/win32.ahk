#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, LPARAM, PROPERTYKEY, PWSTR}
#Import "..\Media.Audio\Types.ahk" {AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE, AUDIO_VOLUME_NOTIFICATION_DATA, IMMDevice, IMMDeviceCollection, WAVEFORMATEX}
#Import "..\System.Com\Types.ahk" {IServiceProvider, IUnknown}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct UNCOMPRESSEDAUDIOFORMAT {
    guidFormatType : GUID
    dwSamplesPerFrame : UInt32
    dwBytesPerSampleContainer : UInt32
    dwValidBitsPerSample : UInt32
    fFramesPerSecond : Float32
    dwChannelMask : UInt32
}
struct IAudioMediaType extends IUnknown {
    static IID := "{4E997F73-B71F-4798-873B-ED7DFCF15B4D}"
    IsCompressedFormat(pfCompressed)
      => ComCall(3, this.p, BOOL.Ptr, pfCompressed)
    IsEqual(pIAudioType, pdwFlags)
      => ComCall(4, this.p, IAudioMediaType, pIAudioType, UInt32.Ptr, pdwFlags)
    GetAudioFormat()
      => ComCall(5, this.p, WAVEFORMATEX.Ptr)
    GetUncompressedAudioFormat(pUncompressedAudioFormat)
      => ComCall(6, this.p, UNCOMPRESSEDAUDIOFORMAT.Ptr, pUncompressedAudioFormat)
}
struct APO_BUFFER_FLAGS extends Int32 {
    static BUFFER_INVALID := 0
    static BUFFER_VALID := 1
    static BUFFER_SILENT := 2
}
struct APO_CONNECTION_PROPERTY {
    pBuffer : IntPtr
    u32ValidFrameCount : UInt32
    u32BufferFlags : APO_BUFFER_FLAGS
    u32Signature : UInt32
}
struct APO_CONNECTION_PROPERTY_V2 {
    property : APO_CONNECTION_PROPERTY
    u64QPCTime : Int64
}
struct APO_CONNECTION_BUFFER_TYPE extends Int32 {
    static APO_CONNECTION_BUFFER_TYPE_ALLOCATED := 0
    static APO_CONNECTION_BUFFER_TYPE_EXTERNAL := 1
    static APO_CONNECTION_BUFFER_TYPE_DEPENDANT := 2
}
struct APO_CONNECTION_DESCRIPTOR {
    Type : APO_CONNECTION_BUFFER_TYPE
    pBuffer : IntPtr
    u32MaxFrameCount : UInt32
    pFormat : IAudioMediaType
    u32Signature : UInt32
}
struct APO_FLAG extends Int32 {
    static APO_FLAG_NONE := 0
    static APO_FLAG_INPLACE := 1
    static APO_FLAG_SAMPLESPERFRAME_MUST_MATCH := 2
    static APO_FLAG_FRAMESPERSECOND_MUST_MATCH := 4
    static APO_FLAG_BITSPERSAMPLE_MUST_MATCH := 8
    static APO_FLAG_MIXER := 16
    static APO_FLAG_DEFAULT := 14
}
struct APO_REG_PROPERTIES {
    clsid : GUID
    Flags : APO_FLAG
    szFriendlyName : UInt16[256]
    szCopyrightInfo : UInt16[256]
    u32MajorVersion : UInt32
    u32MinorVersion : UInt32
    u32MinInputConnections : UInt32
    u32MaxInputConnections : UInt32
    u32MinOutputConnections : UInt32
    u32MaxOutputConnections : UInt32
    u32MaxInstances : UInt32
    u32NumAPOInterfaces : UInt32
    iidAPOInterfaceList : GUID[1]
}
struct APOInitBaseStruct {
    cbSize : UInt32 := this.Size
    clsid : GUID
}
struct AUDIO_FLOW_TYPE extends Int32 {
    static AUDIO_FLOW_PULL := 0
    static AUDIO_FLOW_PUSH := 1
}
struct EAudioConstriction extends Int32 {
    static eAudioConstrictionOff := 0
    static eAudioConstriction48_16 := 1
    static eAudioConstriction44_16 := 2
    static eAudioConstriction14_14 := 3
    static eAudioConstrictionMute := 4
}
struct IAudioProcessingObjectRT extends IUnknown {
    static IID := "{9E1D6A6D-DDBC-4E95-A4C7-AD64BA37846C}"
    APOProcess(u32NumInputConnections, ppInputConnections, u32NumOutputConnections, ppOutputConnections)
      => ComCall(3, this.p, UInt32, u32NumInputConnections, APO_CONNECTION_PROPERTY.Ptr.Ptr, ppInputConnections, UInt32, u32NumOutputConnections, APO_CONNECTION_PROPERTY.Ptr.Ptr, ppOutputConnections, "void")
    CalcInputFrames(u32OutputFrameCount)
      => ComCall(4, this.p, UInt32, u32OutputFrameCount, UInt32)
    CalcOutputFrames(u32InputFrameCount)
      => ComCall(5, this.p, UInt32, u32InputFrameCount, UInt32)
}
struct IAudioProcessingObjectVBR extends IUnknown {
    static IID := "{7BA1DB8F-78AD-49CD-9591-F79D80A17C81}"
    CalcMaxInputFrames(u32MaxOutputFrameCount, pu32InputFrameCount)
      => ComCall(3, this.p, UInt32, u32MaxOutputFrameCount, UInt32.Ptr, pu32InputFrameCount)
    CalcMaxOutputFrames(u32MaxInputFrameCount, pu32OutputFrameCount)
      => ComCall(4, this.p, UInt32, u32MaxInputFrameCount, UInt32.Ptr, pu32OutputFrameCount)
}
struct IAudioProcessingObjectConfiguration extends IUnknown {
    static IID := "{0E5ED805-ABA6-49C3-8F9A-2B8C889C4FA8}"
    LockForProcess(ppInputConnections, ppOutputConnections)
      => ComCall(3, this.p, UInt32, ppInputConnections.Length, APO_CONNECTION_DESCRIPTOR.Ptr.Ptr, ppInputConnections, UInt32, ppOutputConnections.Length, APO_CONNECTION_DESCRIPTOR.Ptr.Ptr, ppOutputConnections)
    UnlockForProcess()
      => ComCall(4, this.p)
}
struct IAudioProcessingObject extends IUnknown {
    static IID := "{FD7F2B29-24D0-4B5C-B177-592C39F9CA10}"
    Reset()
      => ComCall(3, this.p)
    GetLatency(pTime)
      => ComCall(4, this.p, Int64.Ptr, pTime)
    GetRegistrationProperties(ppRegProps)
      => ComCall(5, this.p, APO_REG_PROPERTIES.Ptr.Ptr, ppRegProps)
    Initialize(pbyData)
      => ComCall(6, this.p, UInt32, pbyData.Length, UInt8.Ptr, pbyData)
    IsInputFormatSupported(pOppositeFormat, pRequestedInputFormat, ppSupportedInputFormat)
      => ComCall(7, this.p, IAudioMediaType, pOppositeFormat, IAudioMediaType, pRequestedInputFormat, IAudioMediaType.Ptr, ppSupportedInputFormat)
    IsOutputFormatSupported(pOppositeFormat, pRequestedOutputFormat, ppSupportedOutputFormat)
      => ComCall(8, this.p, IAudioMediaType, pOppositeFormat, IAudioMediaType, pRequestedOutputFormat, IAudioMediaType.Ptr, ppSupportedOutputFormat)
    GetInputChannelCount(pu32ChannelCount)
      => ComCall(9, this.p, UInt32.Ptr, pu32ChannelCount)
}
struct IAudioDeviceModulesClient extends IUnknown {
    static IID := "{98F37DAC-D0B6-49F5-896A-AA4D169A4C48}"
    SetAudioDeviceModulesManager(pAudioDeviceModulesManager)
      => ComCall(3, this.p, IUnknown, pAudioDeviceModulesManager)
}
struct FNAPONOTIFICATIONCALLBACK extends FunctionPointer {
    static Types := [APO_REG_PROPERTIES.Ptr, Struct.Ptr, HRESULT]
}
struct IAudioSystemEffects extends IUnknown {
    static IID := "{5FA00F27-ADD6-499A-8A9D-6B98521FA75B}"
}
struct IAudioSystemEffects2 extends IAudioSystemEffects {
    static IID := "{BAFE99D2-7436-44CE-9E0E-4D89AFBFFF56}"
    GetEffectsList(ppEffectsIds, pcEffects, Event)
      => ComCall(3, this.p, GUID.Ptr.Ptr, ppEffectsIds, UInt32.Ptr, pcEffects, HANDLE, Event)
}
struct IAudioSystemEffectsCustomFormats extends IUnknown {
    static IID := "{B1176E34-BB7F-4F05-BEBD-1B18A534E097}"
    GetFormatCount(pcFormats)
      => ComCall(3, this.p, UInt32.Ptr, pcFormats)
    GetFormat(nFormat, ppFormat)
      => ComCall(4, this.p, UInt32, nFormat, IAudioMediaType.Ptr, ppFormat)
    GetFormatRepresentation(nFormat, ppwstrFormatRep)
      => ComCall(5, this.p, UInt32, nFormat, PWSTR.Ptr, ppwstrFormatRep)
}
struct IApoAuxiliaryInputConfiguration extends IUnknown {
    static IID := "{4CEB0AAB-FA19-48ED-A857-87771AE1B768}"
    AddAuxiliaryInput(dwInputId, pbyData, pInputConnection)
      => ComCall(3, this.p, UInt32, dwInputId, UInt32, pbyData.Length, UInt8.Ptr, pbyData, APO_CONNECTION_DESCRIPTOR.Ptr, pInputConnection)
    RemoveAuxiliaryInput(dwInputId)
      => ComCall(4, this.p, UInt32, dwInputId)
    IsInputFormatSupported(pRequestedInputFormat, ppSupportedInputFormat)
      => ComCall(5, this.p, IAudioMediaType, pRequestedInputFormat, IAudioMediaType.Ptr, ppSupportedInputFormat)
}
struct IApoAuxiliaryInputRT extends IUnknown {
    static IID := "{F851809C-C177-49A0-B1B2-B66F017943AB}"
    AcceptInput(dwInputId, pInputConnection)
      => ComCall(3, this.p, UInt32, dwInputId, APO_CONNECTION_PROPERTY.Ptr, pInputConnection, "void")
}
struct IApoAcousticEchoCancellation extends IUnknown {
    static IID := "{25385759-3236-4101-A943-25693DFB5D2D}"
}
struct APO_REFERENCE_STREAM_PROPERTIES extends Int32 {
    static APO_REFERENCE_STREAM_PROPERTIES_NONE := 0
    static APO_REFERENCE_STREAM_PROPERTIES_POST_VOLUME_LOOPBACK := 1
}
struct IApoAcousticEchoCancellation2 extends IApoAcousticEchoCancellation {
    static IID := "{F235855F-F06D-45B3-A63F-EE4B71509DC2}"
    GetDesiredReferenceStreamProperties(pProperties)
      => ComCall(3, this.p, APO_REFERENCE_STREAM_PROPERTIES.Ptr, pProperties)
}
struct APOInitSystemEffects {
    APOInit : APOInitBaseStruct
    pAPOEndpointProperties : IPropertyStore
    pAPOSystemEffectsProperties : IPropertyStore
    pReserved : Struct.Ptr
    pDeviceCollection : IMMDeviceCollection
}
struct APOInitSystemEffects2 {
    APOInit : APOInitBaseStruct
    pAPOEndpointProperties : IPropertyStore
    pAPOSystemEffectsProperties : IPropertyStore
    pReserved : Struct.Ptr
    pDeviceCollection : IMMDeviceCollection
    nSoftwareIoDeviceInCollection : UInt32
    nSoftwareIoConnectorIndex : UInt32
    AudioProcessingMode : GUID
    InitializeForDiscoveryOnly : BOOL
}
struct AudioFXExtensionParams {
    AddPageParam : LPARAM
    pwstrEndpointID : PWSTR
    pFxProperties : IPropertyStore
}
struct AUDIO_SYSTEMEFFECT_STATE extends Int32 {
    static AUDIO_SYSTEMEFFECT_STATE_OFF := 0
    static AUDIO_SYSTEMEFFECT_STATE_ON := 1
}
struct AUDIO_SYSTEMEFFECT {
    id : GUID
    canSetState : BOOL
    state : AUDIO_SYSTEMEFFECT_STATE
}
struct IAudioSystemEffects3 extends IAudioSystemEffects2 {
    static IID := "{C58B31CD-FC6A-4255-BC1F-AD29BB0A4A17}"
    GetControllableSystemEffectsList(effects, numEffects, event?)
      => ComCall(4, this.p, AUDIO_SYSTEMEFFECT.Ptr.Ptr, effects, UInt32.Ptr, numEffects, HANDLE, event?)
    SetAudioSystemEffectState(effectId, state)
      => ComCall(5, this.p, GUID, effectId, AUDIO_SYSTEMEFFECT_STATE, state)
}
struct APOInitSystemEffects3 {
    APOInit : APOInitBaseStruct
    pAPOEndpointProperties : IPropertyStore
    pServiceProvider : IServiceProvider
    pDeviceCollection : IMMDeviceCollection
    nSoftwareIoDeviceInCollection : UInt32
    nSoftwareIoConnectorIndex : UInt32
    AudioProcessingMode : GUID
    InitializeForDiscoveryOnly : BOOL
}
struct AcousticEchoCanceller_Reference_Input {
    apoInitSystemEffects : APOInitSystemEffects3
    streamProperties : APO_REFERENCE_STREAM_PROPERTIES
}
struct IAudioProcessingObjectRTQueueService extends IUnknown {
    static IID := "{ACD65E2F-955B-4B57-B9BF-AC297BB752C9}"
    GetRealTimeWorkQueue(workQueueId)
      => ComCall(3, this.p, UInt32.Ptr, workQueueId)
}
struct APO_LOG_LEVEL extends Int32 {
    static APO_LOG_LEVEL_ALWAYS := 0
    static APO_LOG_LEVEL_CRITICAL := 1
    static APO_LOG_LEVEL_ERROR := 2
    static APO_LOG_LEVEL_WARNING := 3
    static APO_LOG_LEVEL_INFO := 4
    static APO_LOG_LEVEL_VERBOSE := 5
}
struct IAudioProcessingObjectLoggingService extends IUnknown {
    static IID := "{698F0107-1745-4708-95A5-D84478A62A65}"
    ApoLog(level, format)
      => ComCall(3, this.p, APO_LOG_LEVEL, level, "Str", format, "void")
}
struct APO_NOTIFICATION_TYPE extends Int32 {
    static APO_NOTIFICATION_TYPE_NONE := 0
    static APO_NOTIFICATION_TYPE_ENDPOINT_VOLUME := 1
    static APO_NOTIFICATION_TYPE_ENDPOINT_PROPERTY_CHANGE := 2
    static APO_NOTIFICATION_TYPE_SYSTEM_EFFECTS_PROPERTY_CHANGE := 3
    static APO_NOTIFICATION_TYPE_ENDPOINT_VOLUME2 := 4
    static APO_NOTIFICATION_TYPE_DEVICE_ORIENTATION := 5
    static APO_NOTIFICATION_TYPE_MICROPHONE_BOOST := 6
    static APO_NOTIFICATION_TYPE_AUDIO_ENVIRONMENT_STATE_CHANGE := 7
}
struct AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION {
    endpoint : IMMDevice
    volume : AUDIO_VOLUME_NOTIFICATION_DATA.Ptr
}
struct AUDIO_ENDPOINT_PROPERTY_CHANGE_NOTIFICATION {
    endpoint : IMMDevice
    propertyStore : IPropertyStore
    propertyKey : PROPERTYKEY
}
struct AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_NOTIFICATION {
    endpoint : IMMDevice
    propertyStoreContext : GUID
    propertyStoreType : AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE
    propertyStore : IPropertyStore
    propertyKey : PROPERTYKEY
}
struct AUDIO_VOLUME_NOTIFICATION_DATA2 {
    notificationData : AUDIO_VOLUME_NOTIFICATION_DATA.Ptr
    masterVolumeInDb : Float32
    volumeMinInDb : Float32
    volumeMaxInDb : Float32
    volumeIncrementInDb : Float32
    step : UInt32
    stepCount : UInt32
    channelVolumesInDb : Float32[1]
}
struct AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION2 {
    endpoint : IMMDevice
    volume : AUDIO_VOLUME_NOTIFICATION_DATA2.Ptr
}
struct DEVICE_ORIENTATION_TYPE extends Int32 {
    static DEVICE_NOT_ROTATED := 0
    static DEVICE_ROTATED_90_DEGREES_CLOCKWISE := 1
    static DEVICE_ROTATED_180_DEGREES_CLOCKWISE := 2
    static DEVICE_ROTATED_270_DEGREES_CLOCKWISE := 3
}
struct AUDIO_MICROPHONE_BOOST_NOTIFICATION {
    endpoint : IMMDevice
    eventContext : GUID
    microphoneBoostEnabled : BOOL
    levelInDb : Float32
    levelMinInDb : Float32
    levelMaxInDb : Float32
    levelStepInDb : Float32
    muteSupported : BOOL
    mute : BOOL
}
struct AUDIO_ENVIRONMENT_STATE_CHANGE_NOTIFICATION {
    propertyStore : IPropertyStore
    propertyKey : PROPERTYKEY
}
struct APO_NOTIFICATION {
    type : APO_NOTIFICATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            audioEndpointVolumeChange : AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION
            audioEndpointPropertyChange : AUDIO_ENDPOINT_PROPERTY_CHANGE_NOTIFICATION
            audioSystemEffectsPropertyChange : AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_NOTIFICATION
            audioEndpointVolumeChange2 : AUDIO_ENDPOINT_VOLUME_CHANGE_NOTIFICATION2
            deviceOrientation : DEVICE_ORIENTATION_TYPE
            audioMicrophoneBoostChange : AUDIO_MICROPHONE_BOOST_NOTIFICATION
            audioEnvironmentChange : AUDIO_ENVIRONMENT_STATE_CHANGE_NOTIFICATION
        }
    }
}
struct AUDIO_ENDPOINT_VOLUME_APO_NOTIFICATION_DESCRIPTOR {
    device : IMMDevice
}
struct AUDIO_ENDPOINT_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR {
    device : IMMDevice
}
struct AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR {
    device : IMMDevice
    propertyStoreContext : GUID
}
struct AUDIO_MICROPHONE_BOOST_APO_NOTIFICATION_DESCRIPTOR {
    device : IMMDevice
}
struct APO_NOTIFICATION_DESCRIPTOR {
    type : APO_NOTIFICATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            audioEndpointVolume : AUDIO_ENDPOINT_VOLUME_APO_NOTIFICATION_DESCRIPTOR
            audioEndpointPropertyChange : AUDIO_ENDPOINT_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR
            audioSystemEffectsPropertyChange : AUDIO_SYSTEMEFFECTS_PROPERTY_CHANGE_APO_NOTIFICATION_DESCRIPTOR
            audioMicrophoneBoost : AUDIO_MICROPHONE_BOOST_APO_NOTIFICATION_DESCRIPTOR
        }
    }
}
struct IAudioProcessingObjectPreferredFormatSupport extends IUnknown {
    static IID := "{51CBD3C4-F1F3-4D2F-A0E1-7E9C4DD0FEB3}"
    GetPreferredInputFormat(outputFormat, preferredFormat)
      => ComCall(3, this.p, IAudioMediaType, outputFormat, IAudioMediaType.Ptr, preferredFormat)
    GetPreferredOutputFormat(inputFormat, preferredFormat)
      => ComCall(4, this.p, IAudioMediaType, inputFormat, IAudioMediaType.Ptr, preferredFormat)
}
struct IAudioProcessingObjectNotifications extends IUnknown {
    static IID := "{56B0C76F-02FD-4B21-A52E-9F8219FC86E4}"
    GetApoNotificationRegistrationInfo(apoNotifications)
      => ComCall(3, this.p, APO_NOTIFICATION_DESCRIPTOR.Ptr.Ptr, apoNotifications, UInt32.Ptr, apoNotifications.Length)
    HandleNotification(apoNotification)
      => ComCall(4, this.p, APO_NOTIFICATION.Ptr, apoNotification, "void")
}
struct IAudioProcessingObjectNotifications2 extends IAudioProcessingObjectNotifications {
    static IID := "{CA2CFBDE-A9D6-4EB0-BC95-C4D026B380F0}"
    GetApoNotificationRegistrationInfo2(maxApoNotificationTypeSupported, apoNotifications)
      => ComCall(5, this.p, APO_NOTIFICATION_TYPE, maxApoNotificationTypeSupported, APO_NOTIFICATION_DESCRIPTOR.Ptr.Ptr, apoNotifications, UInt32.Ptr, apoNotifications.Length)
}
