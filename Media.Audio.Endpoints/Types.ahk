#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\Media.Audio\Types.ahk" {AUDIO_VOLUME_NOTIFICATION_DATA, IMMDevice, WAVEFORMATEX}
#Import "..\Media.Audio.Apo\Types.ahk" {APO_CONNECTION_PROPERTY}
#Import "..\Media.KernelStreaming\Types.ahk" {AUDIO_CURVE_TYPE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IAudioEndpointFormatControl extends IUnknown {
    static IID := "{784CFD40-9F89-456E-A1A6-873B006A664E}"
    ResetToDefault(ResetFlags)
      => ComCall(3, this.p, UInt32, ResetFlags)
}
struct EndpointConnectorType extends Int32 {
    static eHostProcessConnector := 0
    static eOffloadConnector := 1
    static eLoopbackConnector := 2
    static eKeywordDetectorConnector := 3
    static eLoopbackConnectorPostVolume := 4
    static eConnectorCount := 5
}
struct AUDIO_ENDPOINT_SHARED_CREATE_PARAMS {
    u32Size : UInt32
    u32TSSessionId : UInt32
    targetEndpointConnectorType : EndpointConnectorType
    wfxDeviceFormat : WAVEFORMATEX
}
struct IAudioEndpointOffloadStreamVolume extends IUnknown {
    static IID := "{64F1DD49-71CA-4281-8672-3A9EDDD1D0B6}"
    GetVolumeChannelCount(pu32ChannelCount)
      => ComCall(3, this.p, UInt32.Ptr, pu32ChannelCount)
    SetChannelVolumes(u32ChannelCount, pf32Volumes, u32CurveType, pCurveDuration)
      => ComCall(4, this.p, UInt32, u32ChannelCount, Float32.Ptr, pf32Volumes, AUDIO_CURVE_TYPE, u32CurveType, Int64.Ptr, pCurveDuration)
    GetChannelVolumes(u32ChannelCount, pf32Volumes)
      => ComCall(5, this.p, UInt32, u32ChannelCount, Float32.Ptr, pf32Volumes)
}
struct IAudioEndpointOffloadStreamMute extends IUnknown {
    static IID := "{DFE21355-5EC2-40E0-8D6B-710AC3C00249}"
    SetMute(bMuted)
      => ComCall(3, this.p, UInt8, bMuted)
    GetMute(pbMuted)
      => ComCall(4, this.p, UInt8.Ptr, pbMuted)
}
struct IAudioEndpointOffloadStreamMeter extends IUnknown {
    static IID := "{E1546DCE-9DD1-418B-9AB2-348CED161C86}"
    GetMeterChannelCount(pu32ChannelCount)
      => ComCall(3, this.p, UInt32.Ptr, pu32ChannelCount)
    GetMeteringData(u32ChannelCount, pf32PeakValues)
      => ComCall(4, this.p, UInt32, u32ChannelCount, Float32.Ptr, pf32PeakValues)
}
struct IAudioEndpointLastBufferControl extends IUnknown {
    static IID := "{F8520DD3-8F9D-4437-9861-62F584C33DD6}"
    IsLastBufferControlSupported()
      => ComCall(3, this.p, BOOL)
    ReleaseOutputDataPointerForLastBuffer(pConnectionProperty)
      => ComCall(4, this.p, APO_CONNECTION_PROPERTY.Ptr, pConnectionProperty, "void")
}
struct IAudioLfxControl extends IUnknown {
    static IID := "{076A6922-D802-4F83-BAF6-409D9CA11BFE}"
    SetLocalEffectsState(bEnabled)
      => ComCall(3, this.p, BOOL, bEnabled)
    GetLocalEffectsState(pbEnabled)
      => ComCall(4, this.p, BOOL.Ptr, pbEnabled)
}
struct IHardwareAudioEngineBase extends IUnknown {
    static IID := "{EDDCE3E4-F3C1-453A-B461-223563CBD886}"
    GetAvailableOffloadConnectorCount(_pwstrDeviceId, _uConnectorId, _pAvailableConnectorInstanceCount)
      => ComCall(3, this.p, "Str", _pwstrDeviceId, UInt32, _uConnectorId, UInt32.Ptr, _pAvailableConnectorInstanceCount)
    GetEngineFormat(pDevice, _bRequestDeviceFormat, _ppwfxFormat)
      => ComCall(4, this.p, IMMDevice, pDevice, BOOL, _bRequestDeviceFormat, WAVEFORMATEX.Ptr.Ptr, _ppwfxFormat)
    SetEngineDeviceFormat(pDevice, _pwfxFormat)
      => ComCall(5, this.p, IMMDevice, pDevice, WAVEFORMATEX.Ptr, _pwfxFormat)
    SetGfxState(pDevice, _bEnable)
      => ComCall(6, this.p, IMMDevice, pDevice, BOOL, _bEnable)
    GetGfxState(pDevice, _pbEnable)
      => ComCall(7, this.p, IMMDevice, pDevice, BOOL.Ptr, _pbEnable)
}
struct IAudioEndpointVolumeCallback extends IUnknown {
    static IID := "{657804FA-D6AD-4496-8A60-352752AF4F89}"
    OnNotify(pNotify)
      => ComCall(3, this.p, AUDIO_VOLUME_NOTIFICATION_DATA.Ptr, pNotify)
}
struct IAudioEndpointVolume extends IUnknown {
    static IID := "{5CDF2C82-841E-4546-9722-0CF74078229A}"
    RegisterControlChangeNotify(pNotify)
      => ComCall(3, this.p, IAudioEndpointVolumeCallback, pNotify)
    UnregisterControlChangeNotify(pNotify)
      => ComCall(4, this.p, IAudioEndpointVolumeCallback, pNotify)
    GetChannelCount(pnChannelCount)
      => ComCall(5, this.p, UInt32.Ptr, pnChannelCount)
    SetMasterVolumeLevel(fLevelDB, pguidEventContext)
      => ComCall(6, this.p, Float32, fLevelDB, GUID.Ptr, pguidEventContext)
    SetMasterVolumeLevelScalar(fLevel, pguidEventContext)
      => ComCall(7, this.p, Float32, fLevel, GUID.Ptr, pguidEventContext)
    GetMasterVolumeLevel(pfLevelDB)
      => ComCall(8, this.p, Float32.Ptr, pfLevelDB)
    GetMasterVolumeLevelScalar(pfLevel)
      => ComCall(9, this.p, Float32.Ptr, pfLevel)
    SetChannelVolumeLevel(nChannel, fLevelDB, pguidEventContext)
      => ComCall(10, this.p, UInt32, nChannel, Float32, fLevelDB, GUID.Ptr, pguidEventContext)
    SetChannelVolumeLevelScalar(nChannel, fLevel, pguidEventContext)
      => ComCall(11, this.p, UInt32, nChannel, Float32, fLevel, GUID.Ptr, pguidEventContext)
    GetChannelVolumeLevel(nChannel, pfLevelDB)
      => ComCall(12, this.p, UInt32, nChannel, Float32.Ptr, pfLevelDB)
    GetChannelVolumeLevelScalar(nChannel, pfLevel)
      => ComCall(13, this.p, UInt32, nChannel, Float32.Ptr, pfLevel)
    SetMute(bMute, pguidEventContext)
      => ComCall(14, this.p, BOOL, bMute, GUID.Ptr, pguidEventContext)
    GetMute(pbMute)
      => ComCall(15, this.p, BOOL.Ptr, pbMute)
    GetVolumeStepInfo(pnStep, pnStepCount)
      => ComCall(16, this.p, UInt32.Ptr, pnStep, UInt32.Ptr, pnStepCount)
    VolumeStepUp(pguidEventContext)
      => ComCall(17, this.p, GUID.Ptr, pguidEventContext)
    VolumeStepDown(pguidEventContext)
      => ComCall(18, this.p, GUID.Ptr, pguidEventContext)
    QueryHardwareSupport(pdwHardwareSupportMask)
      => ComCall(19, this.p, UInt32.Ptr, pdwHardwareSupportMask)
    GetVolumeRange(pflVolumeMindB, pflVolumeMaxdB, pflVolumeIncrementdB)
      => ComCall(20, this.p, Float32.Ptr, pflVolumeMindB, Float32.Ptr, pflVolumeMaxdB, Float32.Ptr, pflVolumeIncrementdB)
}
struct IAudioEndpointVolumeEx extends IAudioEndpointVolume {
    static IID := "{66E11784-F695-4F28-A505-A7080081A78F}"
    GetVolumeRangeChannel(iChannel, pflVolumeMindB, pflVolumeMaxdB, pflVolumeIncrementdB)
      => ComCall(21, this.p, UInt32, iChannel, Float32.Ptr, pflVolumeMindB, Float32.Ptr, pflVolumeMaxdB, Float32.Ptr, pflVolumeIncrementdB)
}
struct IAudioMeterInformation extends IUnknown {
    static IID := "{C02216F6-8C67-4B5B-9D00-D008E73E0064}"
    GetPeakValue(pfPeak)
      => ComCall(3, this.p, Float32.Ptr, pfPeak)
    GetMeteringChannelCount(pnChannelCount)
      => ComCall(4, this.p, UInt32.Ptr, pnChannelCount)
    GetChannelsPeakValues(afPeakValues)
      => ComCall(5, this.p, UInt32, afPeakValues.Length, Float32.Ptr, afPeakValues)
    QueryHardwareSupport(pdwHardwareSupportMask)
      => ComCall(6, this.p, UInt32.Ptr, pdwHardwareSupportMask)
}
