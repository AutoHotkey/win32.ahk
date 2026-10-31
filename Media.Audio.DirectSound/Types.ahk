#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, PSTR, PWSTR}
#Import "..\Graphics.Direct3D\Types.ahk" {D3DVECTOR}
#Import "..\Media.Audio\Types.ahk" {WAVEFORMATEX}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DSCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwMinSecondarySampleRate : UInt32
    dwMaxSecondarySampleRate : UInt32
    dwPrimaryBuffers : UInt32
    dwMaxHwMixingAllBuffers : UInt32
    dwMaxHwMixingStaticBuffers : UInt32
    dwMaxHwMixingStreamingBuffers : UInt32
    dwFreeHwMixingAllBuffers : UInt32
    dwFreeHwMixingStaticBuffers : UInt32
    dwFreeHwMixingStreamingBuffers : UInt32
    dwMaxHw3DAllBuffers : UInt32
    dwMaxHw3DStaticBuffers : UInt32
    dwMaxHw3DStreamingBuffers : UInt32
    dwFreeHw3DAllBuffers : UInt32
    dwFreeHw3DStaticBuffers : UInt32
    dwFreeHw3DStreamingBuffers : UInt32
    dwTotalHwMemBytes : UInt32
    dwFreeHwMemBytes : UInt32
    dwMaxContigFreeHwMemBytes : UInt32
    dwUnlockTransferRateHwBuffers : UInt32
    dwPlayCpuOverheadSwBuffers : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct DSBCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwUnlockTransferRate : UInt32
    dwPlayCpuOverhead : UInt32
}
struct DSEFFECTDESC {
    dwSize : UInt32
    dwFlags : UInt32
    guidDSFXClass : GUID
    dwReserved1 : IntPtr
    dwReserved2 : IntPtr
}
struct DSCEFFECTDESC {
    dwSize : UInt32
    dwFlags : UInt32
    guidDSCFXClass : GUID
    guidDSCFXInstance : GUID
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct DSBUFFERDESC {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwReserved : UInt32
    lpwfxFormat : WAVEFORMATEX.Ptr
    guid3DAlgorithm : GUID
}
struct DSBUFFERDESC1 {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwReserved : UInt32
    lpwfxFormat : WAVEFORMATEX.Ptr
}
struct DS3DBUFFER {
    dwSize : UInt32
    vPosition : D3DVECTOR
    vVelocity : D3DVECTOR
    dwInsideConeAngle : UInt32
    dwOutsideConeAngle : UInt32
    vConeOrientation : D3DVECTOR
    lConeOutsideVolume : Int32
    flMinDistance : Float32
    flMaxDistance : Float32
    dwMode : UInt32
}
struct DS3DLISTENER {
    dwSize : UInt32
    vPosition : D3DVECTOR
    vVelocity : D3DVECTOR
    vOrientFront : D3DVECTOR
    vOrientTop : D3DVECTOR
    flDistanceFactor : Float32
    flRolloffFactor : Float32
    flDopplerFactor : Float32
}
struct DSCCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwFormats : UInt32
    dwChannels : UInt32
}
struct DSCBUFFERDESC1 {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwReserved : UInt32
    lpwfxFormat : WAVEFORMATEX.Ptr
}
struct DSCBUFFERDESC {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwReserved : UInt32
    lpwfxFormat : WAVEFORMATEX.Ptr
    dwFXCount : UInt32
    lpDSCFXDesc : DSCEFFECTDESC.Ptr
}
struct DSCBCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwBufferBytes : UInt32
    dwReserved : UInt32
}
struct DSBPOSITIONNOTIFY {
    dwOffset : UInt32
    hEventNotify : HANDLE
}
struct LPDSENUMCALLBACKA extends FunctionPointer {
    static Types := [GUID.Ptr, PSTR, PSTR, Struct.Ptr, BOOL]
}
struct LPDSENUMCALLBACKW extends FunctionPointer {
    static Types := [GUID.Ptr, PWSTR, PWSTR, Struct.Ptr, BOOL]
}
struct IDirectSound extends IUnknown {
    static IID := "{279AFA83-4981-11CE-A521-0020AF0BE560}"
    CreateSoundBuffer(pcDSBufferDesc, ppDSBuffer, pUnkOuter?)
      => ComCall(3, this.p, DSBUFFERDESC.Ptr, pcDSBufferDesc, IDirectSoundBuffer.Ptr, ppDSBuffer, IUnknown, pUnkOuter?)
    GetCaps(pDSCaps)
      => ComCall(4, this.p, DSCAPS.Ptr, pDSCaps)
    DuplicateSoundBuffer(pDSBufferOriginal, ppDSBufferDuplicate)
      => ComCall(5, this.p, IDirectSoundBuffer, pDSBufferOriginal, IDirectSoundBuffer.Ptr, ppDSBufferDuplicate)
    SetCooperativeLevel(hwnd1, dwLevel)
      => ComCall(6, this.p, HWND, hwnd1, UInt32, dwLevel)
    Compact()
      => ComCall(7, this.p)
    GetSpeakerConfig(pdwSpeakerConfig)
      => ComCall(8, this.p, UInt32.Ptr, pdwSpeakerConfig)
    SetSpeakerConfig(dwSpeakerConfig)
      => ComCall(9, this.p, UInt32, dwSpeakerConfig)
    Initialize(pcGuidDevice?)
      => ComCall(10, this.p, GUID.Ptr, pcGuidDevice?)
}
struct IDirectSound8 extends IDirectSound {
    static IID := "{C50A7E93-F395-4834-9EF6-7FA99DE50966}"
    VerifyCertification(pdwCertified)
      => ComCall(11, this.p, UInt32.Ptr, pdwCertified)
}
struct IDirectSoundBuffer extends IUnknown {
    static IID := "{279AFA85-4981-11CE-A521-0020AF0BE560}"
    GetCaps(pDSBufferCaps)
      => ComCall(3, this.p, DSBCAPS.Ptr, pDSBufferCaps)
    GetCurrentPosition(pdwCurrentPlayCursor?, pdwCurrentWriteCursor?)
      => ComCall(4, this.p, UInt32.Ptr, pdwCurrentPlayCursor?, UInt32.Ptr, pdwCurrentWriteCursor?)
    GetFormat(pwfxFormat?, pdwSizeWritten?)
      => ComCall(5, this.p, WAVEFORMATEX.Ptr, pwfxFormat?, UInt32, pwfxFormat?.Size ?? 0, UInt32.Ptr, pdwSizeWritten?)
    GetVolume(plVolume)
      => ComCall(6, this.p, Int32.Ptr, plVolume)
    GetPan(plPan)
      => ComCall(7, this.p, Int32.Ptr, plPan)
    GetFrequency(pdwFrequency)
      => ComCall(8, this.p, UInt32.Ptr, pdwFrequency)
    GetStatus(pdwStatus)
      => ComCall(9, this.p, UInt32.Ptr, pdwStatus)
    Initialize(pDirectSound, pcDSBufferDesc)
      => ComCall(10, this.p, IDirectSound, pDirectSound, DSBUFFERDESC.Ptr, pcDSBufferDesc)
    Lock(dwOffset, dwBytes, ppvAudioPtr1, pdwAudioBytes1, ppvAudioPtr2?, pdwAudioBytes2?, dwFlags)
      => ComCall(11, this.p, UInt32, dwOffset, UInt32, dwBytes, Struct.Ptr.Ptr, ppvAudioPtr1, UInt32.Ptr, pdwAudioBytes1, Struct.Ptr.Ptr, ppvAudioPtr2?, UInt32.Ptr, pdwAudioBytes2?, UInt32, dwFlags)
    Play(dwReserved1, dwPriority, dwFlags)
      => ComCall(12, this.p, UInt32, dwReserved1, UInt32, dwPriority, UInt32, dwFlags)
    SetCurrentPosition(dwNewPosition)
      => ComCall(13, this.p, UInt32, dwNewPosition)
    SetFormat(pcfxFormat)
      => ComCall(14, this.p, WAVEFORMATEX.Ptr, pcfxFormat)
    SetVolume(lVolume)
      => ComCall(15, this.p, Int32, lVolume)
    SetPan(lPan)
      => ComCall(16, this.p, Int32, lPan)
    SetFrequency(dwFrequency)
      => ComCall(17, this.p, UInt32, dwFrequency)
    Stop()
      => ComCall(18, this.p)
    Unlock(pvAudioPtr1, pvAudioPtr2?)
      => ComCall(19, this.p, Struct.Ptr, pvAudioPtr1, UInt32, pvAudioPtr1.Size, Struct.Ptr, pvAudioPtr2?, UInt32, pvAudioPtr2?.Size ?? 0)
    Restore()
      => ComCall(20, this.p)
}
struct IDirectSoundBuffer8 extends IDirectSoundBuffer {
    static IID := "{6825A449-7524-4D82-920F-50E36AB3AB1E}"
    SetFX(pDSFXDesc?, pdwResultCodes?)
      => ComCall(21, this.p, UInt32, pdwResultCodes?.Length ?? 0, DSEFFECTDESC.Ptr, pDSFXDesc?, UInt32.Ptr, pdwResultCodes?)
    AcquireResources(dwFlags, pdwResultCodes)
      => ComCall(22, this.p, UInt32, dwFlags, UInt32, pdwResultCodes.Length, UInt32.Ptr, pdwResultCodes)
    GetObjectInPath(rguidObject, dwIndex, rguidInterface, ppObject)
      => ComCall(23, this.p, GUID.Ptr, rguidObject, UInt32, dwIndex, GUID.Ptr, rguidInterface, Struct.Ptr.Ptr, ppObject)
}
struct IDirectSound3DListener extends IUnknown {
    static IID := "{279AFA84-4981-11CE-A521-0020AF0BE560}"
    GetAllParameters(pListener)
      => ComCall(3, this.p, DS3DLISTENER.Ptr, pListener)
    GetDistanceFactor(pflDistanceFactor)
      => ComCall(4, this.p, Float32.Ptr, pflDistanceFactor)
    GetDopplerFactor(pflDopplerFactor)
      => ComCall(5, this.p, Float32.Ptr, pflDopplerFactor)
    GetOrientation(pvOrientFront, pvOrientTop)
      => ComCall(6, this.p, D3DVECTOR.Ptr, pvOrientFront, D3DVECTOR.Ptr, pvOrientTop)
    GetPosition(pvPosition)
      => ComCall(7, this.p, D3DVECTOR.Ptr, pvPosition)
    GetRolloffFactor(pflRolloffFactor)
      => ComCall(8, this.p, Float32.Ptr, pflRolloffFactor)
    GetVelocity(pvVelocity)
      => ComCall(9, this.p, D3DVECTOR.Ptr, pvVelocity)
    SetAllParameters(pcListener, dwApply)
      => ComCall(10, this.p, DS3DLISTENER.Ptr, pcListener, UInt32, dwApply)
    SetDistanceFactor(flDistanceFactor, dwApply)
      => ComCall(11, this.p, Float32, flDistanceFactor, UInt32, dwApply)
    SetDopplerFactor(flDopplerFactor, dwApply)
      => ComCall(12, this.p, Float32, flDopplerFactor, UInt32, dwApply)
    SetOrientation(xFront, yFront, zFront, xTop, yTop, zTop, dwApply)
      => ComCall(13, this.p, Float32, xFront, Float32, yFront, Float32, zFront, Float32, xTop, Float32, yTop, Float32, zTop, UInt32, dwApply)
    SetPosition(x, y, z, dwApply)
      => ComCall(14, this.p, Float32, x, Float32, y, Float32, z, UInt32, dwApply)
    SetRolloffFactor(flRolloffFactor, dwApply)
      => ComCall(15, this.p, Float32, flRolloffFactor, UInt32, dwApply)
    SetVelocity(x, y, z, dwApply)
      => ComCall(16, this.p, Float32, x, Float32, y, Float32, z, UInt32, dwApply)
    CommitDeferredSettings()
      => ComCall(17, this.p)
}
struct IDirectSound3DBuffer extends IUnknown {
    static IID := "{279AFA86-4981-11CE-A521-0020AF0BE560}"
    GetAllParameters(pDs3dBuffer)
      => ComCall(3, this.p, DS3DBUFFER.Ptr, pDs3dBuffer)
    GetConeAngles(pdwInsideConeAngle, pdwOutsideConeAngle)
      => ComCall(4, this.p, UInt32.Ptr, pdwInsideConeAngle, UInt32.Ptr, pdwOutsideConeAngle)
    GetConeOrientation(pvOrientation)
      => ComCall(5, this.p, D3DVECTOR.Ptr, pvOrientation)
    GetConeOutsideVolume(plConeOutsideVolume)
      => ComCall(6, this.p, Int32.Ptr, plConeOutsideVolume)
    GetMaxDistance(pflMaxDistance)
      => ComCall(7, this.p, Float32.Ptr, pflMaxDistance)
    GetMinDistance(pflMinDistance)
      => ComCall(8, this.p, Float32.Ptr, pflMinDistance)
    GetMode(pdwMode)
      => ComCall(9, this.p, UInt32.Ptr, pdwMode)
    GetPosition(pvPosition)
      => ComCall(10, this.p, D3DVECTOR.Ptr, pvPosition)
    GetVelocity(pvVelocity)
      => ComCall(11, this.p, D3DVECTOR.Ptr, pvVelocity)
    SetAllParameters(pcDs3dBuffer, dwApply)
      => ComCall(12, this.p, DS3DBUFFER.Ptr, pcDs3dBuffer, UInt32, dwApply)
    SetConeAngles(dwInsideConeAngle, dwOutsideConeAngle, dwApply)
      => ComCall(13, this.p, UInt32, dwInsideConeAngle, UInt32, dwOutsideConeAngle, UInt32, dwApply)
    SetConeOrientation(x, y, z, dwApply)
      => ComCall(14, this.p, Float32, x, Float32, y, Float32, z, UInt32, dwApply)
    SetConeOutsideVolume(lConeOutsideVolume, dwApply)
      => ComCall(15, this.p, Int32, lConeOutsideVolume, UInt32, dwApply)
    SetMaxDistance(flMaxDistance, dwApply)
      => ComCall(16, this.p, Float32, flMaxDistance, UInt32, dwApply)
    SetMinDistance(flMinDistance, dwApply)
      => ComCall(17, this.p, Float32, flMinDistance, UInt32, dwApply)
    SetMode(dwMode, dwApply)
      => ComCall(18, this.p, UInt32, dwMode, UInt32, dwApply)
    SetPosition(x, y, z, dwApply)
      => ComCall(19, this.p, Float32, x, Float32, y, Float32, z, UInt32, dwApply)
    SetVelocity(x, y, z, dwApply)
      => ComCall(20, this.p, Float32, x, Float32, y, Float32, z, UInt32, dwApply)
}
struct IDirectSoundCapture extends IUnknown {
    static IID := "{B0210781-89CD-11D0-AF08-00A0C925CD16}"
    CreateCaptureBuffer(pcDSCBufferDesc, ppDSCBuffer, pUnkOuter?)
      => ComCall(3, this.p, DSCBUFFERDESC.Ptr, pcDSCBufferDesc, IDirectSoundCaptureBuffer.Ptr, ppDSCBuffer, IUnknown, pUnkOuter?)
    GetCaps(pDSCCaps)
      => ComCall(4, this.p, DSCCAPS.Ptr, pDSCCaps)
    Initialize(pcGuidDevice?)
      => ComCall(5, this.p, GUID.Ptr, pcGuidDevice?)
}
struct IDirectSoundCaptureBuffer extends IUnknown {
    static IID := "{B0210782-89CD-11D0-AF08-00A0C925CD16}"
    GetCaps(pDSCBCaps)
      => ComCall(3, this.p, DSCBCAPS.Ptr, pDSCBCaps)
    GetCurrentPosition(pdwCapturePosition?, pdwReadPosition?)
      => ComCall(4, this.p, UInt32.Ptr, pdwCapturePosition?, UInt32.Ptr, pdwReadPosition?)
    GetFormat(pwfxFormat?, pdwSizeWritten?)
      => ComCall(5, this.p, WAVEFORMATEX.Ptr, pwfxFormat?, UInt32, pwfxFormat?.Size ?? 0, UInt32.Ptr, pdwSizeWritten?)
    GetStatus(pdwStatus)
      => ComCall(6, this.p, UInt32.Ptr, pdwStatus)
    Initialize(pDirectSoundCapture, pcDSCBufferDesc)
      => ComCall(7, this.p, IDirectSoundCapture, pDirectSoundCapture, DSCBUFFERDESC.Ptr, pcDSCBufferDesc)
    Lock(dwOffset, dwBytes, ppvAudioPtr1, pdwAudioBytes1, ppvAudioPtr2?, pdwAudioBytes2?, dwFlags)
      => ComCall(8, this.p, UInt32, dwOffset, UInt32, dwBytes, Struct.Ptr.Ptr, ppvAudioPtr1, UInt32.Ptr, pdwAudioBytes1, Struct.Ptr.Ptr, ppvAudioPtr2?, UInt32.Ptr, pdwAudioBytes2?, UInt32, dwFlags)
    Start(dwFlags)
      => ComCall(9, this.p, UInt32, dwFlags)
    Stop()
      => ComCall(10, this.p)
    Unlock(pvAudioPtr1, pvAudioPtr2?)
      => ComCall(11, this.p, Struct.Ptr, pvAudioPtr1, UInt32, pvAudioPtr1.Size, Struct.Ptr, pvAudioPtr2?, UInt32, pvAudioPtr2?.Size ?? 0)
}
struct IDirectSoundCaptureBuffer8 extends IDirectSoundCaptureBuffer {
    static IID := "{00990DF4-0DBB-4872-833E-6D303E80AEB6}"
    GetObjectInPath(rguidObject, dwIndex, rguidInterface, ppObject)
      => ComCall(12, this.p, GUID.Ptr, rguidObject, UInt32, dwIndex, GUID.Ptr, rguidInterface, Struct.Ptr.Ptr, ppObject)
    GetFXStatus(pdwFXStatus)
      => ComCall(13, this.p, UInt32, pdwFXStatus.Length, UInt32.Ptr, pdwFXStatus)
}
struct IDirectSoundNotify extends IUnknown {
    static IID := "{B0210783-89CD-11D0-AF08-00A0C925CD16}"
    SetNotificationPositions(pcPositionNotifies)
      => ComCall(3, this.p, UInt32, pcPositionNotifies.Length, DSBPOSITIONNOTIFY.Ptr, pcPositionNotifies)
}
struct DSFXGargle {
    dwRateHz : UInt32
    dwWaveShape : UInt32
}
struct IDirectSoundFXGargle extends IUnknown {
    static IID := "{D616F352-D622-11CE-AAC5-0020AF0B99A3}"
    SetAllParameters(pcDsFxGargle)
      => ComCall(3, this.p, DSFXGargle.Ptr, pcDsFxGargle)
    GetAllParameters(pDsFxGargle)
      => ComCall(4, this.p, DSFXGargle.Ptr, pDsFxGargle)
}
struct DSFXChorus {
    fWetDryMix : Float32
    fDepth : Float32
    fFeedback : Float32
    fFrequency : Float32
    lWaveform : Int32
    fDelay : Float32
    lPhase : Int32
}
struct IDirectSoundFXChorus extends IUnknown {
    static IID := "{880842E3-145F-43E6-A934-A71806E50547}"
    SetAllParameters(pcDsFxChorus)
      => ComCall(3, this.p, DSFXChorus.Ptr, pcDsFxChorus)
    GetAllParameters(pDsFxChorus)
      => ComCall(4, this.p, DSFXChorus.Ptr, pDsFxChorus)
}
struct DSFXFlanger {
    fWetDryMix : Float32
    fDepth : Float32
    fFeedback : Float32
    fFrequency : Float32
    lWaveform : Int32
    fDelay : Float32
    lPhase : Int32
}
struct IDirectSoundFXFlanger extends IUnknown {
    static IID := "{903E9878-2C92-4072-9B2C-EA68F5396783}"
    SetAllParameters(pcDsFxFlanger)
      => ComCall(3, this.p, DSFXFlanger.Ptr, pcDsFxFlanger)
    GetAllParameters(pDsFxFlanger)
      => ComCall(4, this.p, DSFXFlanger.Ptr, pDsFxFlanger)
}
struct DSFXEcho {
    fWetDryMix : Float32
    fFeedback : Float32
    fLeftDelay : Float32
    fRightDelay : Float32
    lPanDelay : Int32
}
struct IDirectSoundFXEcho extends IUnknown {
    static IID := "{8BD28EDF-50DB-4E92-A2BD-445488D1ED42}"
    SetAllParameters(pcDsFxEcho)
      => ComCall(3, this.p, DSFXEcho.Ptr, pcDsFxEcho)
    GetAllParameters(pDsFxEcho)
      => ComCall(4, this.p, DSFXEcho.Ptr, pDsFxEcho)
}
struct DSFXDistortion {
    fGain : Float32
    fEdge : Float32
    fPostEQCenterFrequency : Float32
    fPostEQBandwidth : Float32
    fPreLowpassCutoff : Float32
}
struct IDirectSoundFXDistortion extends IUnknown {
    static IID := "{8ECF4326-455F-4D8B-BDA9-8D5D3E9E3E0B}"
    SetAllParameters(pcDsFxDistortion)
      => ComCall(3, this.p, DSFXDistortion.Ptr, pcDsFxDistortion)
    GetAllParameters(pDsFxDistortion)
      => ComCall(4, this.p, DSFXDistortion.Ptr, pDsFxDistortion)
}
struct DSFXCompressor {
    fGain : Float32
    fAttack : Float32
    fRelease : Float32
    fThreshold : Float32
    fRatio : Float32
    fPredelay : Float32
}
struct IDirectSoundFXCompressor extends IUnknown {
    static IID := "{4BBD1154-62F6-4E2C-A15C-D3B6C417F7A0}"
    SetAllParameters(pcDsFxCompressor)
      => ComCall(3, this.p, DSFXCompressor.Ptr, pcDsFxCompressor)
    GetAllParameters(pDsFxCompressor)
      => ComCall(4, this.p, DSFXCompressor.Ptr, pDsFxCompressor)
}
struct DSFXParamEq {
    fCenter : Float32
    fBandwidth : Float32
    fGain : Float32
}
struct IDirectSoundFXParamEq extends IUnknown {
    static IID := "{C03CA9FE-FE90-4204-8078-82334CD177DA}"
    SetAllParameters(pcDsFxParamEq)
      => ComCall(3, this.p, DSFXParamEq.Ptr, pcDsFxParamEq)
    GetAllParameters(pDsFxParamEq)
      => ComCall(4, this.p, DSFXParamEq.Ptr, pDsFxParamEq)
}
struct DSFXI3DL2Reverb {
    lRoom : Int32
    lRoomHF : Int32
    flRoomRolloffFactor : Float32
    flDecayTime : Float32
    flDecayHFRatio : Float32
    lReflections : Int32
    flReflectionsDelay : Float32
    lReverb : Int32
    flReverbDelay : Float32
    flDiffusion : Float32
    flDensity : Float32
    flHFReference : Float32
}
struct IDirectSoundFXI3DL2Reverb extends IUnknown {
    static IID := "{4B166A6A-0D66-43F3-80E3-EE6280DEE1A4}"
    SetAllParameters(pcDsFxI3DL2Reverb)
      => ComCall(3, this.p, DSFXI3DL2Reverb.Ptr, pcDsFxI3DL2Reverb)
    GetAllParameters(pDsFxI3DL2Reverb)
      => ComCall(4, this.p, DSFXI3DL2Reverb.Ptr, pDsFxI3DL2Reverb)
    SetPreset(dwPreset)
      => ComCall(5, this.p, UInt32, dwPreset)
    GetPreset(pdwPreset)
      => ComCall(6, this.p, UInt32.Ptr, pdwPreset)
    SetQuality(lQuality)
      => ComCall(7, this.p, Int32, lQuality)
    GetQuality(plQuality)
      => ComCall(8, this.p, Int32.Ptr, plQuality)
}
struct DSFXWavesReverb {
    fInGain : Float32
    fReverbMix : Float32
    fReverbTime : Float32
    fHighFreqRTRatio : Float32
}
struct IDirectSoundFXWavesReverb extends IUnknown {
    static IID := "{46858C3A-0DC6-45E3-B760-D4EEF16CB325}"
    SetAllParameters(pcDsFxWavesReverb)
      => ComCall(3, this.p, DSFXWavesReverb.Ptr, pcDsFxWavesReverb)
    GetAllParameters(pDsFxWavesReverb)
      => ComCall(4, this.p, DSFXWavesReverb.Ptr, pDsFxWavesReverb)
}
struct DSCFXAec {
    fEnable : BOOL
    fNoiseFill : BOOL
    dwMode : UInt32
}
struct IDirectSoundCaptureFXAec extends IUnknown {
    static IID := "{AD74143D-903D-4AB7-8066-28D363036D65}"
    SetAllParameters(pDscFxAec)
      => ComCall(3, this.p, DSCFXAec.Ptr, pDscFxAec)
    GetAllParameters(pDscFxAec)
      => ComCall(4, this.p, DSCFXAec.Ptr, pDscFxAec)
    GetStatus(pdwStatus)
      => ComCall(5, this.p, UInt32.Ptr, pdwStatus)
    Reset()
      => ComCall(6, this.p)
}
struct DSCFXNoiseSuppress {
    fEnable : BOOL
}
struct IDirectSoundCaptureFXNoiseSuppress extends IUnknown {
    static IID := "{ED311E41-FBAE-4175-9625-CD0854F693CA}"
    SetAllParameters(pcDscFxNoiseSuppress)
      => ComCall(3, this.p, DSCFXNoiseSuppress.Ptr, pcDscFxNoiseSuppress)
    GetAllParameters(pDscFxNoiseSuppress)
      => ComCall(4, this.p, DSCFXNoiseSuppress.Ptr, pDscFxNoiseSuppress)
    Reset()
      => ComCall(5, this.p)
}
struct IDirectSoundFullDuplex extends IUnknown {
    static IID := "{EDCB4C7A-DAAB-4216-A42E-6C50596DDC1D}"
    Initialize(pCaptureGuid, pRenderGuid, lpDscBufferDesc, lpDsBufferDesc, hWnd1, dwLevel, lplpDirectSoundCaptureBuffer8, lplpDirectSoundBuffer8)
      => ComCall(3, this.p, GUID.Ptr, pCaptureGuid, GUID.Ptr, pRenderGuid, DSCBUFFERDESC.Ptr, lpDscBufferDesc, DSBUFFERDESC.Ptr, lpDsBufferDesc, HWND, hWnd1, UInt32, dwLevel, IDirectSoundCaptureBuffer8.Ptr, lplpDirectSoundCaptureBuffer8, IDirectSoundBuffer8.Ptr, lplpDirectSoundBuffer8)
}
