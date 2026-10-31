#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\Media.Audio\Types.ahk" {AUDIO_STREAM_CATEGORY, WAVEFORMATEX}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct XAPO_REGISTRATION_PROPERTIES {
    clsid : GUID
    FriendlyName : UInt16[256]
    CopyrightInfo : UInt16[256]
    MajorVersion : UInt32
    MinorVersion : UInt32
    Flags : UInt32
    MinInputBufferCount : UInt32
    MaxInputBufferCount : UInt32
    MinOutputBufferCount : UInt32
    MaxOutputBufferCount : UInt32
}
struct XAPO_LOCKFORPROCESS_PARAMETERS {
    pFormat : WAVEFORMATEX.Ptr
    MaxFrameCount : UInt32
}
struct XAPO_BUFFER_FLAGS extends Int32 {
    static XAPO_BUFFER_SILENT := 0
    static XAPO_BUFFER_VALID := 1
}
struct XAPO_PROCESS_BUFFER_PARAMETERS {
    pBuffer : Struct.Ptr
    BufferFlags : XAPO_BUFFER_FLAGS
    ValidFrameCount : UInt32
}
struct IXAPO extends IUnknown {
    static IID := "{A410B984-9839-4819-A0BE-2856AE6B3ADB}"
    GetRegistrationProperties(ppRegistrationProperties)
      => ComCall(3, this.p, XAPO_REGISTRATION_PROPERTIES.Ptr.Ptr, ppRegistrationProperties)
    IsInputFormatSupported(pOutputFormat, pRequestedInputFormat, ppSupportedInputFormat?)
      => ComCall(4, this.p, WAVEFORMATEX.Ptr, pOutputFormat, WAVEFORMATEX.Ptr, pRequestedInputFormat, WAVEFORMATEX.Ptr.Ptr, ppSupportedInputFormat?)
    IsOutputFormatSupported(pInputFormat, pRequestedOutputFormat, ppSupportedOutputFormat?)
      => ComCall(5, this.p, WAVEFORMATEX.Ptr, pInputFormat, WAVEFORMATEX.Ptr, pRequestedOutputFormat, WAVEFORMATEX.Ptr.Ptr, ppSupportedOutputFormat?)
    Initialize(pData?)
      => ComCall(6, this.p, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0)
    Reset()
      => ComCall(7, this.p, "void")
    LockForProcess(pInputLockedParameters?, pOutputLockedParameters?)
      => ComCall(8, this.p, UInt32, pInputLockedParameters?.Length ?? 0, XAPO_LOCKFORPROCESS_PARAMETERS.Ptr, pInputLockedParameters?, UInt32, pOutputLockedParameters?.Length ?? 0, XAPO_LOCKFORPROCESS_PARAMETERS.Ptr, pOutputLockedParameters?)
    UnlockForProcess()
      => ComCall(9, this.p, "void")
    Process(pInputProcessParameters?, pOutputProcessParameters?, IsEnabled)
      => ComCall(10, this.p, UInt32, pInputProcessParameters?.Length ?? 0, XAPO_PROCESS_BUFFER_PARAMETERS.Ptr, pInputProcessParameters?, UInt32, pOutputProcessParameters?.Length ?? 0, XAPO_PROCESS_BUFFER_PARAMETERS.Ptr, pOutputProcessParameters?, BOOL, IsEnabled, "void")
    CalcInputFrames(OutputFrameCount)
      => ComCall(11, this.p, UInt32, OutputFrameCount, UInt32)
    CalcOutputFrames(InputFrameCount)
      => ComCall(12, this.p, UInt32, InputFrameCount, UInt32)
}
struct IXAPOParameters extends IUnknown {
    static IID := "{26D95C66-80F2-499A-AD54-5AE7F01C6D98}"
    SetParameters(pParameters)
      => ComCall(3, this.p, Struct.Ptr, pParameters, UInt32, pParameters.Size, "void")
    GetParameters(pParameters)
      => ComCall(4, this.p, Struct.Ptr, pParameters, UInt32, pParameters.Size, "void")
}
struct FXEQ_PARAMETERS {
    FrequencyCenter0 : Float32
    Gain0 : Float32
    Bandwidth0 : Float32
    FrequencyCenter1 : Float32
    Gain1 : Float32
    Bandwidth1 : Float32
    FrequencyCenter2 : Float32
    Gain2 : Float32
    Bandwidth2 : Float32
    FrequencyCenter3 : Float32
    Gain3 : Float32
    Bandwidth3 : Float32
}
struct FXMASTERINGLIMITER_PARAMETERS {
    Release : UInt32
    Loudness : UInt32
}
struct FXREVERB_PARAMETERS {
    Diffusion : Float32
    RoomSize : Float32
}
struct FXECHO_INITDATA {
    MaxDelay : Float32
}
struct FXECHO_PARAMETERS {
    WetDryMix : Float32
    Feedback : Float32
    Delay : Float32
}
struct XAUDIO2_VOICE_DETAILS {
    CreationFlags : UInt32
    ActiveFlags : UInt32
    InputChannels : UInt32
    InputSampleRate : UInt32
}
struct XAUDIO2_SEND_DESCRIPTOR {
    Flags : UInt32
    pOutputVoice : IXAudio2Voice
}
struct XAUDIO2_VOICE_SENDS {
    SendCount : UInt32
    pSends : XAUDIO2_SEND_DESCRIPTOR.Ptr
}
struct XAUDIO2_EFFECT_DESCRIPTOR {
    pEffect : IUnknown
    InitialState : BOOL
    OutputChannels : UInt32
}
struct XAUDIO2_EFFECT_CHAIN {
    EffectCount : UInt32
    pEffectDescriptors : XAUDIO2_EFFECT_DESCRIPTOR.Ptr
}
struct XAUDIO2_FILTER_TYPE extends Int32 {
    static LowPassFilter := 0
    static BandPassFilter := 1
    static HighPassFilter := 2
    static NotchFilter := 3
    static LowPassOnePoleFilter := 4
    static HighPassOnePoleFilter := 5
}
struct XAUDIO2_FILTER_PARAMETERS {
    Type : XAUDIO2_FILTER_TYPE
    Frequency : Float32
    OneOverQ : Float32
}
struct XAUDIO2_BUFFER {
    Flags : UInt32
    AudioBytes : UInt32
    pAudioData : UInt8.Ptr
    PlayBegin : UInt32
    PlayLength : UInt32
    LoopBegin : UInt32
    LoopLength : UInt32
    LoopCount : UInt32
    pContext : Struct.Ptr
}
struct XAUDIO2_BUFFER_WMA {
    pDecodedPacketCumulativeBytes : UInt32.Ptr
    PacketCount : UInt32
}
struct XAUDIO2_VOICE_STATE {
    pCurrentBufferContext : Struct.Ptr
    BuffersQueued : UInt32
    SamplesPlayed : Int64
}
struct XAUDIO2_PERFORMANCE_DATA {
    AudioCyclesSinceLastQuery : Int64
    TotalCyclesSinceLastQuery : Int64
    MinimumCyclesPerQuantum : UInt32
    MaximumCyclesPerQuantum : UInt32
    MemoryUsageInBytes : UInt32
    CurrentLatencyInSamples : UInt32
    GlitchesSinceEngineStarted : UInt32
    ActiveSourceVoiceCount : UInt32
    TotalSourceVoiceCount : UInt32
    ActiveSubmixVoiceCount : UInt32
    ActiveResamplerCount : UInt32
    ActiveMatrixMixCount : UInt32
    ActiveXmaSourceVoices : UInt32
    ActiveXmaStreams : UInt32
}
struct XAUDIO2_DEBUG_CONFIGURATION {
    TraceMask : UInt32
    BreakMask : UInt32
    LogThreadID : BOOL
    LogFileline : BOOL
    LogFunctionName : BOOL
    LogTiming : BOOL
}
struct IXAudio2 extends IUnknown {
    static IID := "{2B02E3CF-2E0B-4EC3-BE45-1B2A3FE7210D}"
    RegisterForCallbacks(pCallback)
      => ComCall(3, this.p, IXAudio2EngineCallback, pCallback)
    UnregisterForCallbacks(pCallback)
      => ComCall(4, this.p, IXAudio2EngineCallback, pCallback, "void")
    CreateSourceVoice(ppSourceVoice, pSourceFormat, Flags, MaxFrequencyRatio, pCallback?, pSendList?, pEffectChain?)
      => ComCall(5, this.p, IXAudio2SourceVoice.Ptr, ppSourceVoice, WAVEFORMATEX.Ptr, pSourceFormat, UInt32, Flags, Float32, MaxFrequencyRatio, IXAudio2VoiceCallback, pCallback?, XAUDIO2_VOICE_SENDS.Ptr, pSendList?, XAUDIO2_EFFECT_CHAIN.Ptr, pEffectChain?)
    CreateSubmixVoice(ppSubmixVoice, InputChannels, InputSampleRate, Flags, ProcessingStage, pSendList?, pEffectChain?)
      => ComCall(6, this.p, IXAudio2SubmixVoice.Ptr, ppSubmixVoice, UInt32, InputChannels, UInt32, InputSampleRate, UInt32, Flags, UInt32, ProcessingStage, XAUDIO2_VOICE_SENDS.Ptr, pSendList?, XAUDIO2_EFFECT_CHAIN.Ptr, pEffectChain?)
    CreateMasteringVoice(ppMasteringVoice, InputChannels, InputSampleRate, Flags, szDeviceId?, pEffectChain?, StreamCategory)
      => ComCall(7, this.p, IXAudio2MasteringVoice.Ptr, ppMasteringVoice, UInt32, InputChannels, UInt32, InputSampleRate, UInt32, Flags, "Str", szDeviceId?, XAUDIO2_EFFECT_CHAIN.Ptr, pEffectChain?, AUDIO_STREAM_CATEGORY, StreamCategory)
    StartEngine()
      => ComCall(8, this.p)
    StopEngine()
      => ComCall(9, this.p, "void")
    CommitChanges(OperationSet)
      => ComCall(10, this.p, UInt32, OperationSet)
    GetPerformanceData(pPerfData)
      => ComCall(11, this.p, XAUDIO2_PERFORMANCE_DATA.Ptr, pPerfData, "void")
    SetDebugConfiguration(pDebugConfiguration?)
      => ComCall(12, this.p, XAUDIO2_DEBUG_CONFIGURATION.Ptr, pDebugConfiguration?, "Ptr", 0, "void")
}
struct IXAudio2Extension extends IUnknown {
    static IID := "{84AC29BB-D619-44D2-B197-E4ACF7DF3ED6}"
    GetProcessingQuantum(quantumNumerator, quantumDenominator)
      => ComCall(3, this.p, UInt32.Ptr, quantumNumerator, UInt32.Ptr, quantumDenominator, "void")
    GetProcessor(processor)
      => ComCall(4, this.p, UInt32.Ptr, processor, "void")
}
struct IXAudio2Voice extends InterfacePointer {
    GetVoiceDetails(pVoiceDetails)
      => ComCall(0, this.p, XAUDIO2_VOICE_DETAILS.Ptr, pVoiceDetails, "void")
    SetOutputVoices(pSendList?)
      => ComCall(1, this.p, XAUDIO2_VOICE_SENDS.Ptr, pSendList?)
    SetEffectChain(pEffectChain?)
      => ComCall(2, this.p, XAUDIO2_EFFECT_CHAIN.Ptr, pEffectChain?)
    EnableEffect(EffectIndex, OperationSet)
      => ComCall(3, this.p, UInt32, EffectIndex, UInt32, OperationSet)
    DisableEffect(EffectIndex, OperationSet)
      => ComCall(4, this.p, UInt32, EffectIndex, UInt32, OperationSet)
    GetEffectState(EffectIndex, pEnabled)
      => ComCall(5, this.p, UInt32, EffectIndex, BOOL.Ptr, pEnabled, "void")
    SetEffectParameters(EffectIndex, pParameters, OperationSet)
      => ComCall(6, this.p, UInt32, EffectIndex, Struct.Ptr, pParameters, UInt32, pParameters.Size, UInt32, OperationSet)
    GetEffectParameters(EffectIndex, pParameters)
      => ComCall(7, this.p, UInt32, EffectIndex, Struct.Ptr, pParameters, UInt32, pParameters.Size)
    SetFilterParameters(pParameters, OperationSet)
      => ComCall(8, this.p, XAUDIO2_FILTER_PARAMETERS.Ptr, pParameters, UInt32, OperationSet)
    GetFilterParameters(pParameters)
      => ComCall(9, this.p, XAUDIO2_FILTER_PARAMETERS.Ptr, pParameters, "void")
    SetOutputFilterParameters(pDestinationVoice?, pParameters, OperationSet)
      => ComCall(10, this.p, IXAudio2Voice, pDestinationVoice?, XAUDIO2_FILTER_PARAMETERS.Ptr, pParameters, UInt32, OperationSet)
    GetOutputFilterParameters(pDestinationVoice?, pParameters)
      => ComCall(11, this.p, IXAudio2Voice, pDestinationVoice?, XAUDIO2_FILTER_PARAMETERS.Ptr, pParameters, "void")
    SetVolume(Volume, OperationSet)
      => ComCall(12, this.p, Float32, Volume, UInt32, OperationSet)
    GetVolume(pVolume)
      => ComCall(13, this.p, Float32.Ptr, pVolume, "void")
    SetChannelVolumes(pVolumes, OperationSet)
      => ComCall(14, this.p, UInt32, pVolumes.Length, Float32.Ptr, pVolumes, UInt32, OperationSet)
    GetChannelVolumes(pVolumes)
      => ComCall(15, this.p, UInt32, pVolumes.Length, Float32.Ptr, pVolumes, "void")
    SetOutputMatrix(pDestinationVoice?, SourceChannels, DestinationChannels, pLevelMatrix, OperationSet)
      => ComCall(16, this.p, IXAudio2Voice, pDestinationVoice?, UInt32, SourceChannels, UInt32, DestinationChannels, Float32.Ptr, pLevelMatrix, UInt32, OperationSet)
    GetOutputMatrix(pDestinationVoice?, SourceChannels, DestinationChannels, pLevelMatrix)
      => ComCall(17, this.p, IXAudio2Voice, pDestinationVoice?, UInt32, SourceChannels, UInt32, DestinationChannels, Float32.Ptr, pLevelMatrix, "void")
    DestroyVoice()
      => ComCall(18, this.p, "void")
}
struct IXAudio2SourceVoice extends IXAudio2Voice {
    Start(Flags, OperationSet)
      => ComCall(19, this.p, UInt32, Flags, UInt32, OperationSet)
    Stop(Flags, OperationSet)
      => ComCall(20, this.p, UInt32, Flags, UInt32, OperationSet)
    SubmitSourceBuffer(pBuffer, pBufferWMA?)
      => ComCall(21, this.p, XAUDIO2_BUFFER.Ptr, pBuffer, XAUDIO2_BUFFER_WMA.Ptr, pBufferWMA?)
    FlushSourceBuffers()
      => ComCall(22, this.p)
    Discontinuity()
      => ComCall(23, this.p)
    ExitLoop(OperationSet)
      => ComCall(24, this.p, UInt32, OperationSet)
    GetState(pVoiceState, Flags)
      => ComCall(25, this.p, XAUDIO2_VOICE_STATE.Ptr, pVoiceState, UInt32, Flags, "void")
    SetFrequencyRatio(Ratio, OperationSet)
      => ComCall(26, this.p, Float32, Ratio, UInt32, OperationSet)
    GetFrequencyRatio(pRatio)
      => ComCall(27, this.p, Float32.Ptr, pRatio, "void")
    SetSourceSampleRate(NewSourceSampleRate)
      => ComCall(28, this.p, UInt32, NewSourceSampleRate)
}
struct IXAudio2SubmixVoice extends IXAudio2Voice {
}
struct IXAudio2MasteringVoice extends IXAudio2Voice {
    GetChannelMask(pChannelmask)
      => ComCall(19, this.p, UInt32.Ptr, pChannelmask)
}
struct IXAudio2EngineCallback extends InterfacePointer {
    OnProcessingPassStart()
      => ComCall(0, this.p, "void")
    OnProcessingPassEnd()
      => ComCall(1, this.p, "void")
    OnCriticalError(Error)
      => ComCall(2, this.p, HRESULT, Error, "void")
}
struct IXAudio2VoiceCallback extends InterfacePointer {
    OnVoiceProcessingPassStart(BytesRequired)
      => ComCall(0, this.p, UInt32, BytesRequired, "void")
    OnVoiceProcessingPassEnd()
      => ComCall(1, this.p, "void")
    OnStreamEnd()
      => ComCall(2, this.p, "void")
    OnBufferStart(pBufferContext)
      => ComCall(3, this.p, Struct.Ptr, pBufferContext, "void")
    OnBufferEnd(pBufferContext)
      => ComCall(4, this.p, Struct.Ptr, pBufferContext, "void")
    OnLoopEnd(pBufferContext)
      => ComCall(5, this.p, Struct.Ptr, pBufferContext, "void")
    OnVoiceError(pBufferContext, Error)
      => ComCall(6, this.p, Struct.Ptr, pBufferContext, HRESULT, Error, "void")
}
struct XAUDIO2FX_VOLUMEMETER_LEVELS {
    pPeakLevels : Float32.Ptr
    pRMSLevels : Float32.Ptr
    ChannelCount : UInt32
}
struct XAUDIO2FX_REVERB_PARAMETERS {
    WetDryMix : Float32
    ReflectionsDelay : UInt32
    ReverbDelay : UInt8
    RearDelay : UInt8
    SideDelay : UInt8
    PositionLeft : UInt8
    PositionRight : UInt8
    PositionMatrixLeft : UInt8
    PositionMatrixRight : UInt8
    EarlyDiffusion : UInt8
    LateDiffusion : UInt8
    LowEQGain : UInt8
    LowEQCutoff : UInt8
    HighEQGain : UInt8
    HighEQCutoff : UInt8
    RoomFilterFreq : Float32
    RoomFilterMain : Float32
    RoomFilterHF : Float32
    ReflectionsGain : Float32
    ReverbGain : Float32
    DecayTime : Float32
    Density : Float32
    RoomSize : Float32
    DisableLateField : BOOL
}
struct XAUDIO2FX_REVERB_I3DL2_PARAMETERS {
    WetDryMix : Float32
    Room : Int32
    RoomHF : Int32
    RoomRolloffFactor : Float32
    DecayTime : Float32
    DecayHFRatio : Float32
    Reflections : Int32
    ReflectionsDelay : Float32
    Reverb : Int32
    ReverbDelay : Float32
    Diffusion : Float32
    Density : Float32
    HFReference : Float32
}
struct HrtfPosition {
    x : Float32
    y : Float32
    z : Float32
}
struct HrtfOrientation {
    element : Float32[9]
}
struct HrtfDirectivityType extends Int32 {
    static OmniDirectional := 0
    static Cardioid := 1
    static Cone := 2
}
struct HrtfEnvironment extends Int32 {
    static Small := 0
    static Medium := 1
    static Large := 2
    static Outdoors := 3
}
struct HrtfDirectivity {
    type : HrtfDirectivityType
    scaling : Float32
}
struct HrtfDirectivityCardioid {
    directivity : HrtfDirectivity
    order : Float32
}
struct HrtfDirectivityCone {
    directivity : HrtfDirectivity
    innerAngle : Float32
    outerAngle : Float32
}
struct HrtfDistanceDecayType extends Int32 {
    static NaturalDecay := 0
    static CustomDecay := 1
}
struct HrtfDistanceDecay {
    type : HrtfDistanceDecayType
    maxGain : Float32
    minGain : Float32
    unityGainDistance : Float32
    cutoffDistance : Float32
}
struct HrtfApoInit {
    distanceDecay : HrtfDistanceDecay.Ptr
    directivity : HrtfDirectivity.Ptr
}
struct IXAPOHrtfParameters extends IUnknown {
    static IID := "{15B3CD66-E9DE-4464-B6E6-2BC3CF63D455}"
    SetSourcePosition(position)
      => ComCall(3, this.p, HrtfPosition.Ptr, position)
    SetSourceOrientation(orientation)
      => ComCall(4, this.p, HrtfOrientation.Ptr, orientation)
    SetSourceGain(gain)
      => ComCall(5, this.p, Float32, gain)
    SetEnvironment(environment)
      => ComCall(6, this.p, HrtfEnvironment, environment)
}
