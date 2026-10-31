#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HINSTANCE, HRESULT, HTASK, HWND, LPARAM, LRESULT, PROPERTYKEY, PSTR, PWSTR, WPARAM}
#Import "..\Media.Multimedia\Types.ahk" {HDRVR}
#Import "..\System.Com\Types.ahk" {CLSCTX, INTERFACEINFO, IUnknown, STGM}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct LPWAVECALLBACK extends FunctionPointer {
    static Types := [HDRVR, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct LPMIDICALLBACK extends FunctionPointer {
    static Types := [HDRVR, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct MIDI_WAVE_OPEN_TYPE extends UInt32 {
    static CALLBACK_TYPEMASK := 458752
    static CALLBACK_NULL := 0
    static CALLBACK_WINDOW := 65536
    static CALLBACK_TASK := 131072
    static CALLBACK_FUNCTION := 196608
    static CALLBACK_THREAD := 131072
    static CALLBACK_EVENT := 327680
    static WAVE_FORMAT_QUERY := 1
    static WAVE_ALLOWSYNC := 2
    static WAVE_MAPPED := 4
    static WAVE_FORMAT_DIRECT := 8
    static WAVE_FORMAT_DIRECT_QUERY := 9
    static WAVE_MAPPED_DEFAULT_COMMUNICATION_DEVICE := 16
    static MIDI_IO_STATUS := 32
}
struct SND_FLAGS extends UInt32 {
    static SND_APPLICATION := 128
    static SND_ALIAS := 65536
    static SND_ALIAS_ID := 1114112
    static SND_FILENAME := 131072
    static SND_RESOURCE := 262148
    static SND_ASYNC := 1
    static SND_NODEFAULT := 2
    static SND_LOOP := 8
    static SND_MEMORY := 4
    static SND_NOSTOP := 16
    static SND_NOWAIT := 8192
    static SND_PURGE := 64
    static SND_SENTRY := 524288
    static SND_SYNC := 0
    static SND_SYSTEM := 2097152
}
struct MIXERLINE_COMPONENTTYPE extends UInt32 {
    static MIXERLINE_COMPONENTTYPE_DST_DIGITAL := 1
    static MIXERLINE_COMPONENTTYPE_DST_HEADPHONES := 5
    static MIXERLINE_COMPONENTTYPE_DST_LINE := 2
    static MIXERLINE_COMPONENTTYPE_DST_MONITOR := 3
    static MIXERLINE_COMPONENTTYPE_DST_SPEAKERS := 4
    static MIXERLINE_COMPONENTTYPE_DST_TELEPHONE := 6
    static MIXERLINE_COMPONENTTYPE_DST_UNDEFINED := 0
    static MIXERLINE_COMPONENTTYPE_DST_VOICEIN := 8
    static MIXERLINE_COMPONENTTYPE_DST_WAVEIN := 7
    static MIXERLINE_COMPONENTTYPE_SRC_ANALOG := 4106
    static MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY := 4105
    static MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC := 4101
    static MIXERLINE_COMPONENTTYPE_SRC_DIGITAL := 4097
    static MIXERLINE_COMPONENTTYPE_SRC_LINE := 4098
    static MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE := 4099
    static MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER := 4103
    static MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER := 4100
    static MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE := 4102
    static MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED := 4096
    static MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT := 4104
}
struct DEVICE_STATE extends UInt32 {
    static DEVICE_STATE_ACTIVE := 1
    static DEVICE_STATE_DISABLED := 2
    static DEVICE_STATE_NOTPRESENT := 4
    static DEVICE_STATE_UNPLUGGED := 8
}
struct AUDIO_VOLUME_NOTIFICATION_DATA {
    guidEventContext : GUID
    bMuted : BOOL
    fMasterVolume : Float32
    nChannels : UInt32
    afChannelVolumes : Float32[1]
}
struct HMIDI {
    Value : IntPtr
}
struct HMIDIIN {
    Value : IntPtr
}
struct HMIDIOUT {
    Value : IntPtr
}
struct HMIDISTRM {
    Value : IntPtr
}
struct HMIXER {
    Value : IntPtr
}
struct HMIXEROBJ {
    Value : IntPtr
}
struct HWAVE {
    Value : IntPtr
}
struct HWAVEOUT {
    Value : IntPtr
}
struct HWAVEIN {
    Value : IntPtr
}
struct HACMDRIVERID {
    Value : IntPtr
}
struct HACMDRIVER {
    Value : IntPtr
}
struct HACMSTREAM {
    Value : IntPtr
}
struct HACMOBJ {
    Value : IntPtr
}
struct IMessageFilter extends IUnknown {
    static IID := "{00000016-0000-0000-C000-000000000046}"
    HandleInComingCall(dwCallType, htaskCaller, dwTickCount, lpInterfaceInfo?)
      => ComCall(3, this.p, UInt32, dwCallType, HTASK, htaskCaller, UInt32, dwTickCount, INTERFACEINFO.Ptr, lpInterfaceInfo?, UInt32)
    RetryRejectedCall(htaskCallee, dwTickCount, dwRejectType)
      => ComCall(4, this.p, HTASK, htaskCallee, UInt32, dwTickCount, UInt32, dwRejectType, UInt32)
    MessagePending(htaskCallee, dwTickCount, dwPendingType)
      => ComCall(5, this.p, HTASK, htaskCallee, UInt32, dwTickCount, UInt32, dwPendingType, UInt32)
}
struct WAVEFORMATEXTENSIBLE {
    Format : WAVEFORMATEX
    Samples : this._Samples_e__Union
    dwChannelMask : UInt32
    SubFormat : GUID
    struct _Samples_e__Union {
        union {
            wValidBitsPerSample : UInt16
            wSamplesPerBlock : UInt16
            wReserved : UInt16
        }
    }
}
struct WAVEFILTER {
    cbStruct : UInt32
    dwFilterTag : UInt32
    fdwFilter : UInt32
    dwReserved : UInt32[5]
}
struct VOLUMEWAVEFILTER {
    wfltr : WAVEFILTER
    dwVolume : UInt32
}
struct ECHOWAVEFILTER {
    wfltr : WAVEFILTER
    dwVolume : UInt32
    dwDelay : UInt32
}
struct ACMSTREAMHEADER {
    cbStruct : UInt32
    fdwStatus : UInt32
    dwUser : IntPtr
    pbSrc : UInt8.Ptr
    cbSrcLength : UInt32
    cbSrcLengthUsed : UInt32
    dwSrcUser : IntPtr
    pbDst : UInt8.Ptr
    cbDstLength : UInt32
    cbDstLengthUsed : UInt32
    dwDstUser : IntPtr
    dwReservedDriver : UInt32[15]
}
struct WAVEHDR {
    lpData : PSTR
    dwBufferLength : UInt32
    dwBytesRecorded : UInt32
    dwUser : IntPtr
    dwFlags : UInt32
    dwLoops : UInt32
    lpNext : WAVEHDR.Ptr
    reserved : IntPtr
}
struct WAVEOUTCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
}
struct WAVEOUTCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
}
struct WAVEOUTCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct WAVEOUTCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct WAVEINCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
}
struct WAVEINCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
}
struct WAVEINCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct WAVEINCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwFormats : UInt32
    wChannels : UInt16
    wReserved1 : UInt16
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct WAVEFORMAT {
    wFormatTag : UInt16
    nChannels : UInt16
    nSamplesPerSec : UInt32
    nAvgBytesPerSec : UInt32
    nBlockAlign : UInt16
}
struct PCMWAVEFORMAT {
    wf : WAVEFORMAT
    wBitsPerSample : UInt16
}
struct WAVEFORMATEX {
    wFormatTag : UInt16
    nChannels : UInt16
    nSamplesPerSec : UInt32
    nAvgBytesPerSec : UInt32
    nBlockAlign : UInt16
    wBitsPerSample : UInt16
    cbSize : UInt16 := this.Size
}
struct MIDIOUTCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    wTechnology : UInt16
    wVoices : UInt16
    wNotes : UInt16
    wChannelMask : UInt16
    dwSupport : UInt32
}
struct MIDIOUTCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    wTechnology : UInt16
    wVoices : UInt16
    wNotes : UInt16
    wChannelMask : UInt16
    dwSupport : UInt32
}
struct MIDIOUTCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    wTechnology : UInt16
    wVoices : UInt16
    wNotes : UInt16
    wChannelMask : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIDIOUTCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    wTechnology : UInt16
    wVoices : UInt16
    wNotes : UInt16
    wChannelMask : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIDIINCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwSupport : UInt32
}
struct MIDIINCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwSupport : UInt32
}
struct MIDIINCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIDIINCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIDIHDR {
    lpData : PSTR
    dwBufferLength : UInt32
    dwBytesRecorded : UInt32
    dwUser : IntPtr
    dwFlags : UInt32
    lpNext : MIDIHDR.Ptr
    reserved : IntPtr
    dwOffset : UInt32
    dwReserved : IntPtr[8]
}
struct MIDIEVENT {
    dwDeltaTime : UInt32
    dwStreamID : UInt32
    dwEvent : UInt32
    dwParms : UInt32[1]
}
struct MIDISTRMBUFFVER {
    dwVersion : UInt32
    dwMid : UInt32
    dwOEMVersion : UInt32
}
struct MIDIPROPTIMEDIV {
    cbStruct : UInt32
    dwTimeDiv : UInt32
}
struct MIDIPROPTEMPO {
    cbStruct : UInt32
    dwTempo : UInt32
}
struct AUXCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    wTechnology : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
}
struct AUXCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    wTechnology : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
}
struct AUXCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    wTechnology : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct AUXCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    wTechnology : UInt16
    wReserved1 : UInt16
    dwSupport : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIXERCAPSA {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    fdwSupport : UInt32
    cDestinations : UInt32
}
struct MIXERCAPSW {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    fdwSupport : UInt32
    cDestinations : UInt32
}
struct MIXERCAPS2A {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : CHAR[32]
    fdwSupport : UInt32
    cDestinations : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIXERCAPS2W {
    wMid : UInt16
    wPid : UInt16
    vDriverVersion : UInt32
    szPname : UInt16[32]
    fdwSupport : UInt32
    cDestinations : UInt32
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct MIXERLINEA {
    cbStruct : UInt32
    dwDestination : UInt32
    dwSource : UInt32
    dwLineID : UInt32
    fdwLine : UInt32
    dwUser : IntPtr
    dwComponentType : MIXERLINE_COMPONENTTYPE
    cChannels : UInt32
    cConnections : UInt32
    cControls : UInt32
    szShortName : CHAR[16]
    szName : CHAR[64]
    Target : this._Target_e__Struct
    struct _Target_e__Struct {
        dwType : UInt32
        dwDeviceID : UInt32
        wMid : UInt16
        wPid : UInt16
        vDriverVersion : UInt32
        szPname : CHAR[32]
    }
}
struct MIXERLINEW {
    cbStruct : UInt32
    dwDestination : UInt32
    dwSource : UInt32
    dwLineID : UInt32
    fdwLine : UInt32
    dwUser : IntPtr
    dwComponentType : MIXERLINE_COMPONENTTYPE
    cChannels : UInt32
    cConnections : UInt32
    cControls : UInt32
    szShortName : UInt16[16]
    szName : UInt16[64]
    Target : this._Target_e__Struct
    struct _Target_e__Struct {
        dwType : UInt32
        dwDeviceID : UInt32
        wMid : UInt16
        wPid : UInt16
        vDriverVersion : UInt32
        szPname : UInt16[32]
    }
}
struct MIXERCONTROLA {
    cbStruct : UInt32
    dwControlID : UInt32
    dwControlType : UInt32
    fdwControl : UInt32
    cMultipleItems : UInt32
    szShortName : CHAR[16]
    szName : CHAR[64]
    Bounds : this._Bounds_e__Union
    Metrics : this._Metrics_e__Union
    struct _Bounds_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            dwReserved : UInt32[6]
        }
        struct _Anonymous1_e__Struct {
            lMinimum : Int32
            lMaximum : Int32
        }
        struct _Anonymous2_e__Struct {
            dwMinimum : UInt32
            dwMaximum : UInt32
        }
    }
    struct _Metrics_e__Union {
        union {
            cSteps : UInt32
            cbCustomData : UInt32
            dwReserved : UInt32[6]
        }
    }
}
struct MIXERCONTROLW {
    cbStruct : UInt32
    dwControlID : UInt32
    dwControlType : UInt32
    fdwControl : UInt32
    cMultipleItems : UInt32
    szShortName : UInt16[16]
    szName : UInt16[64]
    Bounds : this._Bounds_e__Union
    Metrics : this._Metrics_e__Union
    struct _Bounds_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            dwReserved : UInt32[6]
        }
        struct _Anonymous1_e__Struct {
            lMinimum : Int32
            lMaximum : Int32
        }
        struct _Anonymous2_e__Struct {
            dwMinimum : UInt32
            dwMaximum : UInt32
        }
    }
    struct _Metrics_e__Union {
        union {
            cSteps : UInt32
            cbCustomData : UInt32
            dwReserved : UInt32[6]
        }
    }
}
struct MIXERLINECONTROLSA {
    cbStruct : UInt32
    dwLineID : UInt32
    Anonymous : this._Anonymous_e__Union
    cControls : UInt32
    cbmxctrl : UInt32
    pamxctrl : MIXERCONTROLA.Ptr
    struct _Anonymous_e__Union {
        union {
            dwControlID : UInt32
            dwControlType : UInt32
        }
    }
}
struct MIXERLINECONTROLSW {
    cbStruct : UInt32
    dwLineID : UInt32
    Anonymous : this._Anonymous_e__Union
    cControls : UInt32
    cbmxctrl : UInt32
    pamxctrl : MIXERCONTROLW.Ptr
    struct _Anonymous_e__Union {
        union {
            dwControlID : UInt32
            dwControlType : UInt32
        }
    }
}
struct MIXERCONTROLDETAILS {
    cbStruct : UInt32
    dwControlID : UInt32
    cChannels : UInt32
    Anonymous : this._Anonymous_e__Union
    cbDetails : UInt32
    paDetails : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            hwndOwner : HWND
            cMultipleItems : UInt32
        }
    }
}
struct MIXERCONTROLDETAILS_LISTTEXTA {
    dwParam1 : UInt32
    dwParam2 : UInt32
    szName : CHAR[64]
}
struct MIXERCONTROLDETAILS_LISTTEXTW {
    dwParam1 : UInt32
    dwParam2 : UInt32
    szName : UInt16[64]
}
struct MIXERCONTROLDETAILS_BOOLEAN {
    fValue : Int32
}
struct MIXERCONTROLDETAILS_SIGNED {
    lValue : Int32
}
struct MIXERCONTROLDETAILS_UNSIGNED {
    dwValue : UInt32
}
struct AUDCLNT_SHAREMODE extends Int32 {
    static AUDCLNT_SHAREMODE_SHARED := 0
    static AUDCLNT_SHAREMODE_EXCLUSIVE := 1
}
struct AUDIO_STREAM_CATEGORY extends Int32 {
    static AudioCategory_Other := 0
    static AudioCategory_ForegroundOnlyMedia := 1
    static AudioCategory_Communications := 3
    static AudioCategory_Alerts := 4
    static AudioCategory_SoundEffects := 5
    static AudioCategory_GameEffects := 6
    static AudioCategory_GameMedia := 7
    static AudioCategory_GameChat := 8
    static AudioCategory_Speech := 9
    static AudioCategory_Movie := 10
    static AudioCategory_Media := 11
    static AudioCategory_FarFieldSpeech := 12
    static AudioCategory_UniformSpeech := 13
    static AudioCategory_VoiceTyping := 14
}
struct AudioSessionState extends Int32 {
    static AudioSessionStateInactive := 0
    static AudioSessionStateActive := 1
    static AudioSessionStateExpired := 2
}
struct AUDCLNT_BUFFERFLAGS extends Int32 {
    static AUDCLNT_BUFFERFLAGS_DATA_DISCONTINUITY := 1
    static AUDCLNT_BUFFERFLAGS_SILENT := 2
    static AUDCLNT_BUFFERFLAGS_TIMESTAMP_ERROR := 4
}
struct AUDCLNT_STREAMOPTIONS extends Int32 {
    static AUDCLNT_STREAMOPTIONS_NONE := 0
    static AUDCLNT_STREAMOPTIONS_RAW := 1
    static AUDCLNT_STREAMOPTIONS_MATCH_FORMAT := 2
    static AUDCLNT_STREAMOPTIONS_AMBISONICS := 4
    static AUDCLNT_STREAMOPTIONS_POST_VOLUME_LOOPBACK := 8
}
struct AudioClientProperties {
    cbSize : UInt32 := this.Size
    bIsOffload : BOOL
    eCategory : AUDIO_STREAM_CATEGORY
    Options : AUDCLNT_STREAMOPTIONS
}
struct IAudioClient extends IUnknown {
    static IID := "{1CB9AD4C-DBFA-4C32-B178-C2F568A703B2}"
    Initialize(ShareMode, StreamFlags, hnsBufferDuration, hnsPeriodicity, pFormat, AudioSessionGuid?)
      => ComCall(3, this.p, AUDCLNT_SHAREMODE, ShareMode, UInt32, StreamFlags, Int64, hnsBufferDuration, Int64, hnsPeriodicity, WAVEFORMATEX.Ptr, pFormat, GUID.Ptr, AudioSessionGuid?)
    GetBufferSize(pNumBufferFrames)
      => ComCall(4, this.p, UInt32.Ptr, pNumBufferFrames)
    GetStreamLatency(phnsLatency)
      => ComCall(5, this.p, Int64.Ptr, phnsLatency)
    GetCurrentPadding(pNumPaddingFrames)
      => ComCall(6, this.p, UInt32.Ptr, pNumPaddingFrames)
    IsFormatSupported(ShareMode, pFormat, ppClosestMatch?)
      => ComCall(7, this.p, AUDCLNT_SHAREMODE, ShareMode, WAVEFORMATEX.Ptr, pFormat, WAVEFORMATEX.Ptr.Ptr, ppClosestMatch?)
    GetMixFormat(ppDeviceFormat)
      => ComCall(8, this.p, WAVEFORMATEX.Ptr.Ptr, ppDeviceFormat)
    GetDevicePeriod(phnsDefaultDevicePeriod?, phnsMinimumDevicePeriod?)
      => ComCall(9, this.p, Int64.Ptr, phnsDefaultDevicePeriod?, Int64.Ptr, phnsMinimumDevicePeriod?)
    Start()
      => ComCall(10, this.p)
    Stop()
      => ComCall(11, this.p)
    Reset()
      => ComCall(12, this.p)
    SetEventHandle(eventHandle)
      => ComCall(13, this.p, HANDLE, eventHandle)
    GetService(riid, ppv)
      => ComCall(14, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IAudioClient2 extends IAudioClient {
    static IID := "{726778CD-F60A-4EDA-82DE-E47610CD78AA}"
    IsOffloadCapable(Category, pbOffloadCapable)
      => ComCall(15, this.p, AUDIO_STREAM_CATEGORY, Category, BOOL.Ptr, pbOffloadCapable)
    SetClientProperties(pProperties)
      => ComCall(16, this.p, AudioClientProperties.Ptr, pProperties)
    GetBufferSizeLimits(pFormat, bEventDriven, phnsMinBufferDuration, phnsMaxBufferDuration)
      => ComCall(17, this.p, WAVEFORMATEX.Ptr, pFormat, BOOL, bEventDriven, Int64.Ptr, phnsMinBufferDuration, Int64.Ptr, phnsMaxBufferDuration)
}
struct AudioClient3ActivationParams {
    tracingContextId : GUID
}
struct IAudioClient3 extends IAudioClient2 {
    static IID := "{7ED4EE07-8E67-4CD4-8C1A-2B7A5987AD42}"
    GetSharedModeEnginePeriod(pFormat, pDefaultPeriodInFrames, pFundamentalPeriodInFrames, pMinPeriodInFrames, pMaxPeriodInFrames)
      => ComCall(18, this.p, WAVEFORMATEX.Ptr, pFormat, UInt32.Ptr, pDefaultPeriodInFrames, UInt32.Ptr, pFundamentalPeriodInFrames, UInt32.Ptr, pMinPeriodInFrames, UInt32.Ptr, pMaxPeriodInFrames)
    GetCurrentSharedModeEnginePeriod(ppFormat, pCurrentPeriodInFrames)
      => ComCall(19, this.p, WAVEFORMATEX.Ptr.Ptr, ppFormat, UInt32.Ptr, pCurrentPeriodInFrames)
    InitializeSharedAudioStream(StreamFlags, PeriodInFrames, pFormat, AudioSessionGuid?)
      => ComCall(20, this.p, UInt32, StreamFlags, UInt32, PeriodInFrames, WAVEFORMATEX.Ptr, pFormat, GUID.Ptr, AudioSessionGuid?)
}
struct IAudioRenderClient extends IUnknown {
    static IID := "{F294ACFC-3146-4483-A7BF-ADDCA7C260E2}"
    GetBuffer(NumFramesRequested, ppData)
      => ComCall(3, this.p, UInt32, NumFramesRequested, UInt8.Ptr.Ptr, ppData)
    ReleaseBuffer(NumFramesWritten, dwFlags)
      => ComCall(4, this.p, UInt32, NumFramesWritten, UInt32, dwFlags)
}
struct IAudioCaptureClient extends IUnknown {
    static IID := "{C8ADBD64-E71E-48A0-A4DE-185C395CD317}"
    GetBuffer(ppData, pNumFramesToRead, pdwFlags, pu64DevicePosition?, pu64QPCPosition?)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppData, UInt32.Ptr, pNumFramesToRead, UInt32.Ptr, pdwFlags, Int64.Ptr, pu64DevicePosition?, Int64.Ptr, pu64QPCPosition?)
    ReleaseBuffer(NumFramesRead)
      => ComCall(4, this.p, UInt32, NumFramesRead)
    GetNextPacketSize(pNumFramesInNextPacket)
      => ComCall(5, this.p, UInt32.Ptr, pNumFramesInNextPacket)
}
struct IAudioClock extends IUnknown {
    static IID := "{CD63314F-3FBA-4A1B-812C-EF96358728E7}"
    GetFrequency(pu64Frequency)
      => ComCall(3, this.p, Int64.Ptr, pu64Frequency)
    GetPosition(pu64Position, pu64QPCPosition?)
      => ComCall(4, this.p, Int64.Ptr, pu64Position, Int64.Ptr, pu64QPCPosition?)
    GetCharacteristics(pdwCharacteristics)
      => ComCall(5, this.p, UInt32.Ptr, pdwCharacteristics)
}
struct IAudioClock2 extends IUnknown {
    static IID := "{6F49FF73-6727-49AC-A008-D98CF5E70048}"
    GetDevicePosition(DevicePosition, QPCPosition?)
      => ComCall(3, this.p, Int64.Ptr, DevicePosition, Int64.Ptr, QPCPosition?)
}
struct IAudioClockAdjustment extends IUnknown {
    static IID := "{F6E4C0A0-46D9-4FB8-BE21-57A3EF2B626C}"
    SetSampleRate(flSampleRate)
      => ComCall(3, this.p, Float32, flSampleRate)
}
struct ISimpleAudioVolume extends IUnknown {
    static IID := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"
    SetMasterVolume(fLevel, EventContext)
      => ComCall(3, this.p, Float32, fLevel, GUID.Ptr, EventContext)
    GetMasterVolume(pfLevel)
      => ComCall(4, this.p, Float32.Ptr, pfLevel)
    SetMute(bMute, EventContext)
      => ComCall(5, this.p, BOOL, bMute, GUID.Ptr, EventContext)
    GetMute(pbMute)
      => ComCall(6, this.p, BOOL.Ptr, pbMute)
}
struct AUDIO_DUCKING_OPTIONS extends Int32 {
    static AUDIO_DUCKING_OPTIONS_DEFAULT := 0
    static AUDIO_DUCKING_OPTIONS_DO_NOT_DUCK_OTHER_STREAMS := 1
}
struct IAudioClientDuckingControl extends IUnknown {
    static IID := "{C789D381-A28C-4168-B28F-D3A837924DC3}"
    SetDuckingOptionsForCurrentStream(options)
      => ComCall(3, this.p, AUDIO_DUCKING_OPTIONS, options)
}
struct IAudioViewManagerService extends IUnknown {
    static IID := "{A7A7EF10-1F49-45E0-AD35-612057CC8F74}"
    SetAudioStreamWindow(hwnd1)
      => ComCall(3, this.p, HWND, hwnd1)
}
struct AUDIO_EFFECT_STATE extends Int32 {
    static AUDIO_EFFECT_STATE_OFF := 0
    static AUDIO_EFFECT_STATE_ON := 1
}
struct AUDIO_EFFECT {
    id : GUID
    canSetState : BOOL
    state : AUDIO_EFFECT_STATE
}
struct IAudioEffectsChangedNotificationClient extends IUnknown {
    static IID := "{A5DED44F-3C5D-4B2B-BD1E-5DC1EE20BBF6}"
    OnAudioEffectsChanged()
      => ComCall(3, this.p)
}
struct IAudioEffectsManager extends IUnknown {
    static IID := "{4460B3AE-4B44-4527-8676-7548A8ACD260}"
    RegisterAudioEffectsChangedNotificationCallback(client)
      => ComCall(3, this.p, IAudioEffectsChangedNotificationClient, client)
    UnregisterAudioEffectsChangedNotificationCallback(client)
      => ComCall(4, this.p, IAudioEffectsChangedNotificationClient, client)
    GetAudioEffects(effects, numEffects)
      => ComCall(5, this.p, AUDIO_EFFECT.Ptr.Ptr, effects, UInt32.Ptr, numEffects)
    SetAudioEffectState(effectId, state)
      => ComCall(6, this.p, GUID, effectId, AUDIO_EFFECT_STATE, state)
}
struct IAudioStreamVolume extends IUnknown {
    static IID := "{93014887-242D-4068-8A15-CF5E93B90FE3}"
    GetChannelCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    SetChannelVolume(dwIndex, fLevel)
      => ComCall(4, this.p, UInt32, dwIndex, Float32, fLevel)
    GetChannelVolume(dwIndex, pfLevel)
      => ComCall(5, this.p, UInt32, dwIndex, Float32.Ptr, pfLevel)
    SetAllVolumes(pfVolumes)
      => ComCall(6, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes)
    GetAllVolumes(pfVolumes)
      => ComCall(7, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes)
}
struct AMBISONICS_TYPE extends Int32 {
    static AMBISONICS_TYPE_FULL3D := 0
}
struct AMBISONICS_CHANNEL_ORDERING extends Int32 {
    static AMBISONICS_CHANNEL_ORDERING_ACN := 0
}
struct AMBISONICS_NORMALIZATION extends Int32 {
    static AMBISONICS_NORMALIZATION_SN3D := 0
    static AMBISONICS_NORMALIZATION_N3D := 1
}
struct AMBISONICS_PARAMS {
    u32Size : UInt32
    u32Version : UInt32
    u32Type : AMBISONICS_TYPE
    u32ChannelOrdering : AMBISONICS_CHANNEL_ORDERING
    u32Normalization : AMBISONICS_NORMALIZATION
    u32Order : UInt32
    u32NumChannels : UInt32
    pu32ChannelMap : UInt32.Ptr
}
struct IAudioAmbisonicsControl extends IUnknown {
    static IID := "{28724C91-DF35-4856-9F76-D6A26413F3DF}"
    SetData(pAmbisonicsParams)
      => ComCall(3, this.p, AMBISONICS_PARAMS.Ptr, pAmbisonicsParams, UInt32, pAmbisonicsParams.Length)
    SetHeadTracking(bEnableHeadTracking)
      => ComCall(4, this.p, BOOL, bEnableHeadTracking)
    GetHeadTracking(pbEnableHeadTracking)
      => ComCall(5, this.p, BOOL.Ptr, pbEnableHeadTracking)
    SetRotation(X, Y, Z, W)
      => ComCall(6, this.p, Float32, X, Float32, Y, Float32, Z, Float32, W)
}
struct IChannelAudioVolume extends IUnknown {
    static IID := "{1C158861-B533-4B30-B1CF-E853E51C59B8}"
    GetChannelCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    SetChannelVolume(dwIndex, fLevel, EventContext)
      => ComCall(4, this.p, UInt32, dwIndex, Float32, fLevel, GUID.Ptr, EventContext)
    GetChannelVolume(dwIndex, pfLevel)
      => ComCall(5, this.p, UInt32, dwIndex, Float32.Ptr, pfLevel)
    SetAllVolumes(pfVolumes, EventContext)
      => ComCall(6, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes, GUID.Ptr, EventContext)
    GetAllVolumes(pfVolumes)
      => ComCall(7, this.p, UInt32, pfVolumes.Length, Float32.Ptr, pfVolumes)
}
struct IAcousticEchoCancellationControl extends IUnknown {
    static IID := "{F4AE25B5-AAA3-437D-B6B3-DBBE2D0E9549}"
    SetEchoCancellationRenderEndpoint(endpointId)
      => ComCall(3, this.p, "Str", endpointId)
}
struct AudioObjectType extends Int32 {
    static AudioObjectType_None := 0
    static AudioObjectType_Dynamic := 1
    static AudioObjectType_FrontLeft := 2
    static AudioObjectType_FrontRight := 4
    static AudioObjectType_FrontCenter := 8
    static AudioObjectType_LowFrequency := 16
    static AudioObjectType_SideLeft := 32
    static AudioObjectType_SideRight := 64
    static AudioObjectType_BackLeft := 128
    static AudioObjectType_BackRight := 256
    static AudioObjectType_TopFrontLeft := 512
    static AudioObjectType_TopFrontRight := 1024
    static AudioObjectType_TopBackLeft := 2048
    static AudioObjectType_TopBackRight := 4096
    static AudioObjectType_BottomFrontLeft := 8192
    static AudioObjectType_BottomFrontRight := 16384
    static AudioObjectType_BottomBackLeft := 32768
    static AudioObjectType_BottomBackRight := 65536
    static AudioObjectType_BackCenter := 131072
    static AudioObjectType_StereoLeft := 262144
    static AudioObjectType_StereoRight := 524288
}
struct SPATIAL_AUDIO_STREAM_OPTIONS extends Int32 {
    static SPATIAL_AUDIO_STREAM_OPTIONS_NONE := 0
    static SPATIAL_AUDIO_STREAM_OPTIONS_OFFLOAD := 1
}
struct SpatialAudioObjectRenderStreamActivationParams {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
}
struct SpatialAudioObjectRenderStreamActivationParams2 {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
    Options : SPATIAL_AUDIO_STREAM_OPTIONS
}
struct IAudioFormatEnumerator extends IUnknown {
    static IID := "{DCDAA858-895A-4A22-A5EB-67BDA506096D}"
    GetCount(count)
      => ComCall(3, this.p, UInt32.Ptr, count)
    GetFormat(index, format)
      => ComCall(4, this.p, UInt32, index, WAVEFORMATEX.Ptr.Ptr, format)
}
struct ISpatialAudioObjectBase extends IUnknown {
    static IID := "{CCE0B8F2-8D4D-4EFB-A8CF-3D6ECF1C30E0}"
    GetBuffer(buffer, bufferLength)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, buffer, UInt32.Ptr, bufferLength)
    SetEndOfStream(frameCount)
      => ComCall(4, this.p, UInt32, frameCount)
    IsActive(isActive)
      => ComCall(5, this.p, BOOL.Ptr, isActive)
    GetAudioObjectType(audioObjectType)
      => ComCall(6, this.p, AudioObjectType.Ptr, audioObjectType)
}
struct ISpatialAudioObject extends ISpatialAudioObjectBase {
    static IID := "{DDE28967-521B-46E5-8F00-BD6F2BC8AB1D}"
    SetPosition(x, y, z)
      => ComCall(7, this.p, Float32, x, Float32, y, Float32, z)
    SetVolume(volume)
      => ComCall(8, this.p, Float32, volume)
}
struct ISpatialAudioObjectRenderStreamBase extends IUnknown {
    static IID := "{FEAAF403-C1D8-450D-AA05-E0CCEE7502A8}"
    GetAvailableDynamicObjectCount(value)
      => ComCall(3, this.p, UInt32.Ptr, value)
    GetService(riid, service)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, service)
    Start()
      => ComCall(5, this.p)
    Stop()
      => ComCall(6, this.p)
    Reset()
      => ComCall(7, this.p)
    BeginUpdatingAudioObjects(availableDynamicObjectCount, frameCountPerBuffer)
      => ComCall(8, this.p, UInt32.Ptr, availableDynamicObjectCount, UInt32.Ptr, frameCountPerBuffer)
    EndUpdatingAudioObjects()
      => ComCall(9, this.p)
}
struct ISpatialAudioObjectRenderStream extends ISpatialAudioObjectRenderStreamBase {
    static IID := "{BAB5F473-B423-477B-85F5-B5A332A04153}"
    ActivateSpatialAudioObject(type, audioObject)
      => ComCall(10, this.p, AudioObjectType, type, ISpatialAudioObject.Ptr, audioObject)
}
struct ISpatialAudioObjectRenderStreamNotify extends IUnknown {
    static IID := "{DDDF83E6-68D7-4C70-883F-A1836AFB4A50}"
    OnAvailableDynamicObjectCountChange(sender, hnsComplianceDeadlineTime, availableDynamicObjectCountChange)
      => ComCall(3, this.p, ISpatialAudioObjectRenderStreamBase, sender, Int64, hnsComplianceDeadlineTime, UInt32, availableDynamicObjectCountChange)
}
struct ISpatialAudioClient extends IUnknown {
    static IID := "{BBF8E066-AAAA-49BE-9A4D-FD2A858EA27F}"
    GetStaticObjectPosition(type, x, y, z)
      => ComCall(3, this.p, AudioObjectType, type, Float32.Ptr, x, Float32.Ptr, y, Float32.Ptr, z)
    GetNativeStaticObjectTypeMask(mask)
      => ComCall(4, this.p, AudioObjectType.Ptr, mask)
    GetMaxDynamicObjectCount(value)
      => ComCall(5, this.p, UInt32.Ptr, value)
    GetSupportedAudioObjectFormatEnumerator(enumerator)
      => ComCall(6, this.p, IAudioFormatEnumerator.Ptr, enumerator)
    GetMaxFrameCount(objectFormat, frameCountPerBuffer)
      => ComCall(7, this.p, WAVEFORMATEX.Ptr, objectFormat, UInt32.Ptr, frameCountPerBuffer)
    IsAudioObjectFormatSupported(objectFormat)
      => ComCall(8, this.p, WAVEFORMATEX.Ptr, objectFormat)
    IsSpatialAudioStreamAvailable(streamUuid, auxiliaryInfo?)
      => ComCall(9, this.p, GUID.Ptr, streamUuid, PROPVARIANT.Ptr, auxiliaryInfo?)
    ActivateSpatialAudioStream(activationParams, riid, stream)
      => ComCall(10, this.p, PROPVARIANT.Ptr, activationParams, GUID.Ptr, riid, Struct.Ptr.Ptr, stream)
}
struct ISpatialAudioClient2 extends ISpatialAudioClient {
    static IID := "{CAABE452-A66A-4BEE-A93E-E320463F6A53}"
    IsOffloadCapable(category, isOffloadCapable)
      => ComCall(11, this.p, AUDIO_STREAM_CATEGORY, category, BOOL.Ptr, isOffloadCapable)
    GetMaxFrameCountForCategory(category, offloadEnabled, objectFormat, frameCountPerBuffer)
      => ComCall(12, this.p, AUDIO_STREAM_CATEGORY, category, BOOL, offloadEnabled, WAVEFORMATEX.Ptr, objectFormat, UInt32.Ptr, frameCountPerBuffer)
}
struct SpatialAudioClientActivationParams {
    tracingContextId : GUID
    appId : GUID
    majorVersion : Int32
    minorVersion1 : Int32
    minorVersion2 : Int32
    minorVersion3 : Int32
}
struct SpatialAudioHrtfDirectivityType extends Int32 {
    static SpatialAudioHrtfDirectivity_OmniDirectional := 0
    static SpatialAudioHrtfDirectivity_Cardioid := 1
    static SpatialAudioHrtfDirectivity_Cone := 2
}
struct SpatialAudioHrtfEnvironmentType extends Int32 {
    static SpatialAudioHrtfEnvironment_Small := 0
    static SpatialAudioHrtfEnvironment_Medium := 1
    static SpatialAudioHrtfEnvironment_Large := 2
    static SpatialAudioHrtfEnvironment_Outdoors := 3
    static SpatialAudioHrtfEnvironment_Average := 4
}
struct SpatialAudioHrtfDistanceDecayType extends Int32 {
    static SpatialAudioHrtfDistanceDecay_NaturalDecay := 0
    static SpatialAudioHrtfDistanceDecay_CustomDecay := 1
}
struct SpatialAudioHrtfDirectivity {
    Type : SpatialAudioHrtfDirectivityType
    Scaling : Float32
}
struct SpatialAudioHrtfDirectivityCardioid {
    directivity : SpatialAudioHrtfDirectivity
    Order : Float32
}
struct SpatialAudioHrtfDirectivityCone {
    directivity : SpatialAudioHrtfDirectivity
    InnerAngle : Float32
    OuterAngle : Float32
}
struct SpatialAudioHrtfDirectivityUnion {
    union {
        Cone : SpatialAudioHrtfDirectivityCone
        Cardiod : SpatialAudioHrtfDirectivityCardioid
        Omni : SpatialAudioHrtfDirectivity
    }
}
struct SpatialAudioHrtfDistanceDecay {
    Type : SpatialAudioHrtfDistanceDecayType
    MaxGain : Float32
    MinGain : Float32
    UnityGainDistance : Float32
    CutoffDistance : Float32
}
struct SpatialAudioHrtfActivationParams {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
    DistanceDecay : SpatialAudioHrtfDistanceDecay.Ptr
    Directivity : SpatialAudioHrtfDirectivityUnion.Ptr
    Environment : SpatialAudioHrtfEnvironmentType.Ptr
    Orientation : Float32.Ptr
}
struct SpatialAudioHrtfActivationParams2 {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
    DistanceDecay : SpatialAudioHrtfDistanceDecay.Ptr
    Directivity : SpatialAudioHrtfDirectivityUnion.Ptr
    Environment : SpatialAudioHrtfEnvironmentType.Ptr
    Orientation : Float32.Ptr
    Options : SPATIAL_AUDIO_STREAM_OPTIONS
}
struct ISpatialAudioObjectForHrtf extends ISpatialAudioObjectBase {
    static IID := "{D7436ADE-1978-4E14-ABA0-555BD8EB83B4}"
    SetPosition(x, y, z)
      => ComCall(7, this.p, Float32, x, Float32, y, Float32, z)
    SetGain(gain)
      => ComCall(8, this.p, Float32, gain)
    SetOrientation(orientation)
      => ComCall(9, this.p, Float32.Ptr.Ptr, orientation)
    SetEnvironment(environment)
      => ComCall(10, this.p, SpatialAudioHrtfEnvironmentType, environment)
    SetDistanceDecay(distanceDecay)
      => ComCall(11, this.p, SpatialAudioHrtfDistanceDecay.Ptr, distanceDecay)
    SetDirectivity(directivity)
      => ComCall(12, this.p, SpatialAudioHrtfDirectivityUnion.Ptr, directivity)
}
struct ISpatialAudioObjectRenderStreamForHrtf extends ISpatialAudioObjectRenderStreamBase {
    static IID := "{E08DEEF9-5363-406E-9FDC-080EE247BBE0}"
    ActivateSpatialAudioObjectForHrtf(type, audioObject)
      => ComCall(10, this.p, AudioObjectType, type, ISpatialAudioObjectForHrtf.Ptr, audioObject)
}
struct DIRECTX_AUDIO_ACTIVATION_PARAMS {
    cbDirectXAudioActivationParams : UInt32
    guidAudioSession : GUID
    dwAudioStreamFlags : UInt32
}
struct EDataFlow extends Int32 {
    static eRender := 0
    static eCapture := 1
    static eAll := 2
    static EDataFlow_enum_count := 3
}
struct ERole extends Int32 {
    static eConsole := 0
    static eMultimedia := 1
    static eCommunications := 2
    static ERole_enum_count := 3
}
struct EndpointFormFactor extends Int32 {
    static RemoteNetworkDevice := 0
    static Speakers := 1
    static LineLevel := 2
    static Headphones := 3
    static Microphone := 4
    static Headset := 5
    static Handset := 6
    static UnknownDigitalPassthrough := 7
    static SPDIF := 8
    static DigitalAudioDisplayDevice := 9
    static UnknownFormFactor := 10
    static EndpointFormFactor_enum_count := 11
}
struct IMMNotificationClient extends IUnknown {
    static IID := "{7991EEC9-7E89-4D85-8390-6C703CEC60C0}"
    OnDeviceStateChanged(pwstrDeviceId, dwNewState)
      => ComCall(3, this.p, "Str", pwstrDeviceId, DEVICE_STATE, dwNewState)
    OnDeviceAdded(pwstrDeviceId)
      => ComCall(4, this.p, "Str", pwstrDeviceId)
    OnDeviceRemoved(pwstrDeviceId)
      => ComCall(5, this.p, "Str", pwstrDeviceId)
    OnDefaultDeviceChanged(flow, role, pwstrDefaultDeviceId?)
      => ComCall(6, this.p, EDataFlow, flow, ERole, role, "Str", pwstrDefaultDeviceId?)
    OnPropertyValueChanged(pwstrDeviceId, key)
      => ComCall(7, this.p, "Str", pwstrDeviceId, PROPERTYKEY, key)
}
struct IMMDevice extends IUnknown {
    static IID := "{D666063F-1587-4E43-81F1-B948E807363F}"
    Activate(iid, dwClsCtx, pActivationParams?, ppInterface)
      => ComCall(3, this.p, GUID.Ptr, iid, CLSCTX, dwClsCtx, PROPVARIANT.Ptr, pActivationParams?, Struct.Ptr.Ptr, ppInterface)
    OpenPropertyStore(stgmAccess, ppProperties)
      => ComCall(4, this.p, STGM, stgmAccess, IPropertyStore.Ptr, ppProperties)
    GetId(ppstrId)
      => ComCall(5, this.p, PWSTR.Ptr, ppstrId)
    GetState(pdwState)
      => ComCall(6, this.p, DEVICE_STATE.Ptr, pdwState)
}
struct IMMDeviceCollection extends IUnknown {
    static IID := "{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}"
    GetCount(pcDevices)
      => ComCall(3, this.p, UInt32.Ptr, pcDevices)
    Item(nDevice, ppDevice)
      => ComCall(4, this.p, UInt32, nDevice, IMMDevice.Ptr, ppDevice)
}
struct IMMEndpoint extends IUnknown {
    static IID := "{1BE09788-6894-4089-8586-9A2A6C265AC5}"
    GetDataFlow(pDataFlow)
      => ComCall(3, this.p, EDataFlow.Ptr, pDataFlow)
}
struct IMMDeviceEnumerator extends IUnknown {
    static IID := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
    EnumAudioEndpoints(dataFlow, dwStateMask, ppDevices)
      => ComCall(3, this.p, EDataFlow, dataFlow, DEVICE_STATE, dwStateMask, IMMDeviceCollection.Ptr, ppDevices)
    GetDefaultAudioEndpoint(dataFlow, role, ppEndpoint)
      => ComCall(4, this.p, EDataFlow, dataFlow, ERole, role, IMMDevice.Ptr, ppEndpoint)
    GetDevice(pwstrId, ppDevice)
      => ComCall(5, this.p, "Str", pwstrId, IMMDevice.Ptr, ppDevice)
    RegisterEndpointNotificationCallback(pClient)
      => ComCall(6, this.p, IMMNotificationClient, pClient)
    UnregisterEndpointNotificationCallback(pClient)
      => ComCall(7, this.p, IMMNotificationClient, pClient)
}
struct IMMDeviceActivator extends IUnknown {
    static IID := "{3B0D0EA4-D0A9-4B0E-935B-09516746FAC0}"
    Activate(iid, pDevice, pActivationParams?, ppInterface)
      => ComCall(3, this.p, GUID.Ptr, iid, IMMDevice, pDevice, PROPVARIANT.Ptr, pActivationParams?, Struct.Ptr.Ptr, ppInterface)
}
struct IActivateAudioInterfaceCompletionHandler extends IUnknown {
    static IID := "{41D949AB-9862-444A-80F6-C261334DA5EB}"
    ActivateCompleted(activateOperation)
      => ComCall(3, this.p, IActivateAudioInterfaceAsyncOperation, activateOperation)
}
struct IActivateAudioInterfaceAsyncOperation extends IUnknown {
    static IID := "{72A22D78-CDE4-431D-B8CC-843A71199B6D}"
    GetActivateResult(activateResult, activatedInterface)
      => ComCall(3, this.p, HRESULT.Ptr, activateResult, IUnknown.Ptr, activatedInterface)
}
struct AudioExtensionParams {
    AddPageParam : LPARAM
    pEndpoint : IMMDevice
    pPnpInterface : IMMDevice
    pPnpDevnode : IMMDevice
}
struct AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE extends Int32 {
    static AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_DEFAULT := 0
    static AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_USER := 1
    static AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_VOLATILE := 2
    static AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE_ENUM_COUNT := 3
}
struct IAudioSystemEffectsPropertyChangeNotificationClient extends IUnknown {
    static IID := "{20049D40-56D5-400E-A2EF-385599FEED49}"
    OnPropertyChanged(type, key)
      => ComCall(3, this.p, AUDIO_SYSTEMEFFECTS_PROPERTYSTORE_TYPE, type, PROPERTYKEY, key)
}
struct IAudioSystemEffectsPropertyStore extends IUnknown {
    static IID := "{302AE7F9-D7E0-43E4-971B-1F8293613D2A}"
    OpenDefaultPropertyStore(stgmAccess, propStore)
      => ComCall(3, this.p, UInt32, stgmAccess, IPropertyStore.Ptr, propStore)
    OpenUserPropertyStore(stgmAccess, propStore)
      => ComCall(4, this.p, UInt32, stgmAccess, IPropertyStore.Ptr, propStore)
    OpenVolatilePropertyStore(stgmAccess, propStore)
      => ComCall(5, this.p, UInt32, stgmAccess, IPropertyStore.Ptr, propStore)
    ResetUserPropertyStore()
      => ComCall(6, this.p)
    ResetVolatilePropertyStore()
      => ComCall(7, this.p)
    RegisterPropertyChangeNotification(callback)
      => ComCall(8, this.p, IAudioSystemEffectsPropertyChangeNotificationClient, callback)
    UnregisterPropertyChangeNotification(callback)
      => ComCall(9, this.p, IAudioSystemEffectsPropertyChangeNotificationClient, callback)
}
struct DataFlow extends Int32 {
    static In := 0
    static Out := 1
}
struct PartType extends Int32 {
    static Connector := 0
    static Subunit := 1
}
struct ConnectorType extends Int32 {
    static Unknown_Connector := 0
    static Physical_Internal := 1
    static Physical_External := 2
    static Software_IO := 3
    static Software_Fixed := 4
    static Network := 5
}
struct IPerChannelDbLevel extends IUnknown {
    static IID := "{C2F8E001-F205-4BC9-99BC-C13B1E048CCB}"
    GetChannelCount(pcChannels)
      => ComCall(3, this.p, UInt32.Ptr, pcChannels)
    GetLevelRange(nChannel, pfMinLevelDB, pfMaxLevelDB, pfStepping)
      => ComCall(4, this.p, UInt32, nChannel, Float32.Ptr, pfMinLevelDB, Float32.Ptr, pfMaxLevelDB, Float32.Ptr, pfStepping)
    GetLevel(nChannel, pfLevelDB)
      => ComCall(5, this.p, UInt32, nChannel, Float32.Ptr, pfLevelDB)
    SetLevel(nChannel, fLevelDB, pguidEventContext?)
      => ComCall(6, this.p, UInt32, nChannel, Float32, fLevelDB, GUID.Ptr, pguidEventContext?)
    SetLevelUniform(fLevelDB, pguidEventContext?)
      => ComCall(7, this.p, Float32, fLevelDB, GUID.Ptr, pguidEventContext?)
    SetLevelAllChannels(aLevelsDB, pguidEventContext?)
      => ComCall(8, this.p, Float32.Ptr, aLevelsDB, UInt32, aLevelsDB.Length, GUID.Ptr, pguidEventContext?)
}
struct IAudioVolumeLevel extends IPerChannelDbLevel {
    static IID := "{7FB7B48F-531D-44A2-BCB3-5AD5A134B3DC}"
}
struct IAudioChannelConfig extends IUnknown {
    static IID := "{BB11C46F-EC28-493C-B88A-5DB88062CE98}"
    SetChannelConfig(dwConfig, pguidEventContext?)
      => ComCall(3, this.p, UInt32, dwConfig, GUID.Ptr, pguidEventContext?)
    GetChannelConfig(pdwConfig)
      => ComCall(4, this.p, UInt32.Ptr, pdwConfig)
}
struct IAudioLoudness extends IUnknown {
    static IID := "{7D8B1437-DD53-4350-9C1B-1EE2890BD938}"
    GetEnabled(pbEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pbEnabled)
    SetEnabled(bEnable, pguidEventContext?)
      => ComCall(4, this.p, BOOL, bEnable, GUID.Ptr, pguidEventContext?)
}
struct IAudioInputSelector extends IUnknown {
    static IID := "{4F03DC02-5E6E-4653-8F72-A030C123D598}"
    GetSelection(pnIdSelected)
      => ComCall(3, this.p, UInt32.Ptr, pnIdSelected)
    SetSelection(nIdSelect, pguidEventContext?)
      => ComCall(4, this.p, UInt32, nIdSelect, GUID.Ptr, pguidEventContext?)
}
struct IAudioOutputSelector extends IUnknown {
    static IID := "{BB515F69-94A7-429E-8B9C-271B3F11A3AB}"
    GetSelection(pnIdSelected)
      => ComCall(3, this.p, UInt32.Ptr, pnIdSelected)
    SetSelection(nIdSelect, pguidEventContext?)
      => ComCall(4, this.p, UInt32, nIdSelect, GUID.Ptr, pguidEventContext?)
}
struct IAudioMute extends IUnknown {
    static IID := "{DF45AEEA-B74A-4B6B-AFAD-2366B6AA012E}"
    SetMute(bMuted, pguidEventContext?)
      => ComCall(3, this.p, BOOL, bMuted, GUID.Ptr, pguidEventContext?)
    GetMute(pbMuted)
      => ComCall(4, this.p, BOOL.Ptr, pbMuted)
}
struct IAudioBass extends IPerChannelDbLevel {
    static IID := "{A2B1A1D9-4DB3-425D-A2B2-BD335CB3E2E5}"
}
struct IAudioMidrange extends IPerChannelDbLevel {
    static IID := "{5E54B6D7-B44B-40D9-9A9E-E691D9CE6EDF}"
}
struct IAudioTreble extends IPerChannelDbLevel {
    static IID := "{0A717812-694E-4907-B74B-BAFA5CFDCA7B}"
}
struct IAudioAutoGainControl extends IUnknown {
    static IID := "{85401FD4-6DE4-4B9D-9869-2D6753A82F3C}"
    GetEnabled(pbEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pbEnabled)
    SetEnabled(bEnable, pguidEventContext?)
      => ComCall(4, this.p, BOOL, bEnable, GUID.Ptr, pguidEventContext?)
}
struct IAudioPeakMeter extends IUnknown {
    static IID := "{DD79923C-0599-45E0-B8B6-C8DF7DB6E796}"
    GetChannelCount(pcChannels)
      => ComCall(3, this.p, UInt32.Ptr, pcChannels)
    GetLevel(nChannel, pfLevel)
      => ComCall(4, this.p, UInt32, nChannel, Float32.Ptr, pfLevel)
}
struct IDeviceSpecificProperty extends IUnknown {
    static IID := "{3B22BCBF-2586-4AF0-8583-205D391B807C}"
    GetType(pVType)
      => ComCall(3, this.p, UInt16.Ptr, pVType)
    GetValue(pvValue, pcbValue)
      => ComCall(4, this.p, Struct.Ptr, pvValue, UInt32.Ptr, pcbValue)
    SetValue(pvValue, cbValue, pguidEventContext?)
      => ComCall(5, this.p, Struct.Ptr, pvValue, UInt32, cbValue, GUID.Ptr, pguidEventContext?)
    Get4BRange(plMin, plMax, plStepping)
      => ComCall(6, this.p, Int32.Ptr, plMin, Int32.Ptr, plMax, Int32.Ptr, plStepping)
}
struct IPartsList extends IUnknown {
    static IID := "{6DAA848C-5EB0-45CC-AEA5-998A2CDA1FFB}"
    GetCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetPart(nIndex, ppPart)
      => ComCall(4, this.p, UInt32, nIndex, IPart.Ptr, ppPart)
}
struct IPart extends IUnknown {
    static IID := "{AE2DE0E4-5BCA-4F2D-AA46-5D13F8FDB3A9}"
    GetName(ppwstrName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwstrName)
    GetLocalId(pnId)
      => ComCall(4, this.p, UInt32.Ptr, pnId)
    GetGlobalId(ppwstrGlobalId)
      => ComCall(5, this.p, PWSTR.Ptr, ppwstrGlobalId)
    GetPartType(pPartType)
      => ComCall(6, this.p, PartType.Ptr, pPartType)
    GetSubType(pSubType)
      => ComCall(7, this.p, GUID.Ptr, pSubType)
    GetControlInterfaceCount(pCount)
      => ComCall(8, this.p, UInt32.Ptr, pCount)
    GetControlInterface(nIndex, ppInterfaceDesc)
      => ComCall(9, this.p, UInt32, nIndex, IControlInterface.Ptr, ppInterfaceDesc)
    EnumPartsIncoming(ppParts)
      => ComCall(10, this.p, IPartsList.Ptr, ppParts)
    EnumPartsOutgoing(ppParts)
      => ComCall(11, this.p, IPartsList.Ptr, ppParts)
    GetTopologyObject(ppTopology)
      => ComCall(12, this.p, IDeviceTopology.Ptr, ppTopology)
    Activate(dwClsContext, refiid, ppvObject?)
      => ComCall(13, this.p, UInt32, dwClsContext, GUID.Ptr, refiid, Struct.Ptr.Ptr, ppvObject?)
    RegisterControlChangeCallback(riid, pNotify)
      => ComCall(14, this.p, GUID.Ptr, riid, IControlChangeNotify, pNotify)
    UnregisterControlChangeCallback(pNotify)
      => ComCall(15, this.p, IControlChangeNotify, pNotify)
}
struct IConnector extends IUnknown {
    static IID := "{9C2C4058-23F5-41DE-877A-DF3AF236A09E}"
    GetType(pType)
      => ComCall(3, this.p, ConnectorType.Ptr, pType)
    GetDataFlow(pFlow)
      => ComCall(4, this.p, DataFlow.Ptr, pFlow)
    ConnectTo(pConnectTo)
      => ComCall(5, this.p, IConnector, pConnectTo)
    Disconnect()
      => ComCall(6, this.p)
    IsConnected(pbConnected)
      => ComCall(7, this.p, BOOL.Ptr, pbConnected)
    GetConnectedTo(ppConTo)
      => ComCall(8, this.p, IConnector.Ptr, ppConTo)
    GetConnectorIdConnectedTo(ppwstrConnectorId)
      => ComCall(9, this.p, PWSTR.Ptr, ppwstrConnectorId)
    GetDeviceIdConnectedTo(ppwstrDeviceId)
      => ComCall(10, this.p, PWSTR.Ptr, ppwstrDeviceId)
}
struct ISubunit extends IUnknown {
    static IID := "{82149A85-DBA6-4487-86BB-EA8F7FEFCC71}"
}
struct IControlInterface extends IUnknown {
    static IID := "{45D37C3F-5140-444A-AE24-400789F3CBF3}"
    GetName(ppwstrName)
      => ComCall(3, this.p, PWSTR.Ptr, ppwstrName)
    GetIID(pIID)
      => ComCall(4, this.p, GUID.Ptr, pIID)
}
struct IControlChangeNotify extends IUnknown {
    static IID := "{A09513ED-C709-4D21-BD7B-5F34C47F3947}"
    OnNotify(dwSenderProcessId, pguidEventContext?)
      => ComCall(3, this.p, UInt32, dwSenderProcessId, GUID.Ptr, pguidEventContext?)
}
struct IDeviceTopology extends IUnknown {
    static IID := "{2A07407E-6497-4A18-9787-32F79BD0D98F}"
    GetConnectorCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetConnector(nIndex, ppConnector)
      => ComCall(4, this.p, UInt32, nIndex, IConnector.Ptr, ppConnector)
    GetSubunitCount(pCount)
      => ComCall(5, this.p, UInt32.Ptr, pCount)
    GetSubunit(nIndex, ppSubunit)
      => ComCall(6, this.p, UInt32, nIndex, ISubunit.Ptr, ppSubunit)
    GetPartById(nId, ppPart)
      => ComCall(7, this.p, UInt32, nId, IPart.Ptr, ppPart)
    GetDeviceId(ppwstrDeviceId)
      => ComCall(8, this.p, PWSTR.Ptr, ppwstrDeviceId)
    GetSignalPath(pIPartFrom, pIPartTo, bRejectMixedPaths, ppParts)
      => ComCall(9, this.p, IPart, pIPartFrom, IPart, pIPartTo, BOOL, bRejectMixedPaths, IPartsList.Ptr, ppParts)
}
struct AudioSessionDisconnectReason extends Int32 {
    static DisconnectReasonDeviceRemoval := 0
    static DisconnectReasonServerShutdown := 1
    static DisconnectReasonFormatChanged := 2
    static DisconnectReasonSessionLogoff := 3
    static DisconnectReasonSessionDisconnected := 4
    static DisconnectReasonExclusiveModeOverride := 5
}
struct IAudioSessionEvents extends IUnknown {
    static IID := "{24918ACC-64B3-37C1-8CA9-74A66E9957A8}"
    OnDisplayNameChanged(NewDisplayName, EventContext)
      => ComCall(3, this.p, "Str", NewDisplayName, GUID.Ptr, EventContext)
    OnIconPathChanged(NewIconPath, EventContext)
      => ComCall(4, this.p, "Str", NewIconPath, GUID.Ptr, EventContext)
    OnSimpleVolumeChanged(NewVolume, NewMute, EventContext)
      => ComCall(5, this.p, Float32, NewVolume, BOOL, NewMute, GUID.Ptr, EventContext)
    OnChannelVolumeChanged(NewChannelVolumeArray, ChangedChannel, EventContext)
      => ComCall(6, this.p, UInt32, NewChannelVolumeArray.Length, Float32.Ptr, NewChannelVolumeArray, UInt32, ChangedChannel, GUID.Ptr, EventContext)
    OnGroupingParamChanged(NewGroupingParam, EventContext)
      => ComCall(7, this.p, GUID.Ptr, NewGroupingParam, GUID.Ptr, EventContext)
    OnStateChanged(NewState)
      => ComCall(8, this.p, AudioSessionState, NewState)
    OnSessionDisconnected(DisconnectReason)
      => ComCall(9, this.p, AudioSessionDisconnectReason, DisconnectReason)
}
struct IAudioSessionControl extends IUnknown {
    static IID := "{F4B1A599-7266-4319-A8CA-E70ACB11E8CD}"
    GetState(pRetVal)
      => ComCall(3, this.p, AudioSessionState.Ptr, pRetVal)
    GetDisplayName(pRetVal)
      => ComCall(4, this.p, PWSTR.Ptr, pRetVal)
    SetDisplayName(Value, EventContext)
      => ComCall(5, this.p, "Str", Value, GUID.Ptr, EventContext)
    GetIconPath(pRetVal)
      => ComCall(6, this.p, PWSTR.Ptr, pRetVal)
    SetIconPath(Value, EventContext)
      => ComCall(7, this.p, "Str", Value, GUID.Ptr, EventContext)
    GetGroupingParam(pRetVal)
      => ComCall(8, this.p, GUID.Ptr, pRetVal)
    SetGroupingParam(Override, EventContext)
      => ComCall(9, this.p, GUID.Ptr, Override, GUID.Ptr, EventContext)
    RegisterAudioSessionNotification(NewNotifications)
      => ComCall(10, this.p, IAudioSessionEvents, NewNotifications)
    UnregisterAudioSessionNotification(NewNotifications)
      => ComCall(11, this.p, IAudioSessionEvents, NewNotifications)
}
struct IAudioSessionControl2 extends IAudioSessionControl {
    static IID := "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}"
    GetSessionIdentifier(pRetVal)
      => ComCall(12, this.p, PWSTR.Ptr, pRetVal)
    GetSessionInstanceIdentifier(pRetVal)
      => ComCall(13, this.p, PWSTR.Ptr, pRetVal)
    GetProcessId(pRetVal)
      => ComCall(14, this.p, UInt32.Ptr, pRetVal)
    IsSystemSoundsSession()
      => ComCall(15, this.p)
    SetDuckingPreference(optOut)
      => ComCall(16, this.p, BOOL, optOut)
}
struct IAudioSessionManager extends IUnknown {
    static IID := "{BFA971F1-4D5E-40BB-935E-967039BFBEE4}"
    GetAudioSessionControl(AudioSessionGuid?, StreamFlags, SessionControl)
      => ComCall(3, this.p, GUID.Ptr, AudioSessionGuid?, UInt32, StreamFlags, IAudioSessionControl.Ptr, SessionControl)
    GetSimpleAudioVolume(AudioSessionGuid?, StreamFlags, AudioVolume)
      => ComCall(4, this.p, GUID.Ptr, AudioSessionGuid?, UInt32, StreamFlags, ISimpleAudioVolume.Ptr, AudioVolume)
}
struct IAudioVolumeDuckNotification extends IUnknown {
    static IID := "{C3B284D4-6D39-4359-B3CF-B56DDB3BB39C}"
    OnVolumeDuckNotification(sessionID, countCommunicationSessions)
      => ComCall(3, this.p, "Str", sessionID, UInt32, countCommunicationSessions)
    OnVolumeUnduckNotification(sessionID)
      => ComCall(4, this.p, "Str", sessionID)
}
struct IAudioSessionNotification extends IUnknown {
    static IID := "{641DD20B-4D41-49CC-ABA3-174B9477BB08}"
    OnSessionCreated(NewSession)
      => ComCall(3, this.p, IAudioSessionControl, NewSession)
}
struct IAudioSessionEnumerator extends IUnknown {
    static IID := "{E2F5BB11-0570-40CA-ACDD-3AA01277DEE8}"
    GetCount(SessionCount)
      => ComCall(3, this.p, Int32.Ptr, SessionCount)
    GetSession(SessionCount, Session)
      => ComCall(4, this.p, Int32, SessionCount, IAudioSessionControl.Ptr, Session)
}
struct IAudioSessionManager2 extends IAudioSessionManager {
    static IID := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
    GetSessionEnumerator(SessionEnum)
      => ComCall(5, this.p, IAudioSessionEnumerator.Ptr, SessionEnum)
    RegisterSessionNotification(SessionNotification)
      => ComCall(6, this.p, IAudioSessionNotification, SessionNotification)
    UnregisterSessionNotification(SessionNotification)
      => ComCall(7, this.p, IAudioSessionNotification, SessionNotification)
    RegisterDuckNotification(sessionID, duckNotification)
      => ComCall(8, this.p, "Str", sessionID, IAudioVolumeDuckNotification, duckNotification)
    UnregisterDuckNotification(duckNotification)
      => ComCall(9, this.p, IAudioVolumeDuckNotification, duckNotification)
}
struct SpatialAudioMetadataWriterOverflowMode extends Int32 {
    static SpatialAudioMetadataWriterOverflow_Fail := 0
    static SpatialAudioMetadataWriterOverflow_MergeWithNew := 1
    static SpatialAudioMetadataWriterOverflow_MergeWithLast := 2
}
struct SpatialAudioMetadataCopyMode extends Int32 {
    static SpatialAudioMetadataCopy_Overwrite := 0
    static SpatialAudioMetadataCopy_Append := 1
    static SpatialAudioMetadataCopy_AppendMergeWithLast := 2
    static SpatialAudioMetadataCopy_AppendMergeWithFirst := 3
}
struct SpatialAudioMetadataItemsInfo {
    FrameCount : UInt16
    ItemCount : UInt16
    MaxItemCount : UInt16
    MaxValueBufferLength : UInt32
}
struct SpatialAudioObjectRenderStreamForMetadataActivationParams {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    MetadataFormatId : GUID
    MaxMetadataItemCount : UInt16
    MetadataActivationParams : PROPVARIANT.Ptr
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
}
struct SpatialAudioObjectRenderStreamForMetadataActivationParams2 {
    ObjectFormat : WAVEFORMATEX.Ptr
    StaticObjectTypeMask : AudioObjectType
    MinDynamicObjectCount : UInt32
    MaxDynamicObjectCount : UInt32
    Category : AUDIO_STREAM_CATEGORY
    EventHandle : HANDLE
    MetadataFormatId : GUID
    MaxMetadataItemCount : UInt32
    MetadataActivationParams : PROPVARIANT.Ptr
    NotifyObject : ISpatialAudioObjectRenderStreamNotify
    Options : SPATIAL_AUDIO_STREAM_OPTIONS
}
struct ISpatialAudioMetadataItems extends IUnknown {
    static IID := "{BCD7C78F-3098-4F22-B547-A2F25A381269}"
    GetFrameCount(frameCount)
      => ComCall(3, this.p, UInt16.Ptr, frameCount)
    GetItemCount(itemCount)
      => ComCall(4, this.p, UInt16.Ptr, itemCount)
    GetMaxItemCount(maxItemCount)
      => ComCall(5, this.p, UInt16.Ptr, maxItemCount)
    GetMaxValueBufferLength(maxValueBufferLength)
      => ComCall(6, this.p, UInt32.Ptr, maxValueBufferLength)
    GetInfo(info)
      => ComCall(7, this.p, SpatialAudioMetadataItemsInfo.Ptr, info)
}
struct ISpatialAudioMetadataWriter extends IUnknown {
    static IID := "{1B17CA01-2955-444D-A430-537DC589A844}"
    Open(metadataItems)
      => ComCall(3, this.p, ISpatialAudioMetadataItems, metadataItems)
    WriteNextItem(frameOffset)
      => ComCall(4, this.p, UInt16, frameOffset)
    WriteNextItemCommand(commandID, valueBuffer?)
      => ComCall(5, this.p, UInt8, commandID, Struct.Ptr, valueBuffer?, UInt32, valueBuffer?.Size ?? 0)
    Close()
      => ComCall(6, this.p)
}
struct ISpatialAudioMetadataReader extends IUnknown {
    static IID := "{B78E86A2-31D9-4C32-94D2-7DF40FC7EBEC}"
    Open(metadataItems)
      => ComCall(3, this.p, ISpatialAudioMetadataItems, metadataItems)
    ReadNextItem(commandCount, frameOffset)
      => ComCall(4, this.p, UInt8.Ptr, commandCount, UInt16.Ptr, frameOffset)
    ReadNextItemCommand(commandID, valueBuffer, valueBufferLength)
      => ComCall(5, this.p, UInt8.Ptr, commandID, Struct.Ptr, valueBuffer, UInt32, valueBuffer.Size, UInt32.Ptr, valueBufferLength)
    Close()
      => ComCall(6, this.p)
}
struct ISpatialAudioMetadataCopier extends IUnknown {
    static IID := "{D224B233-E251-4FD0-9CA2-D5ECF9A68404}"
    Open(metadataItems)
      => ComCall(3, this.p, ISpatialAudioMetadataItems, metadataItems)
    CopyMetadataForFrames(copyFrameCount, copyMode, dstMetadataItems, itemsCopied)
      => ComCall(4, this.p, UInt16, copyFrameCount, SpatialAudioMetadataCopyMode, copyMode, ISpatialAudioMetadataItems, dstMetadataItems, UInt16.Ptr, itemsCopied)
    Close()
      => ComCall(5, this.p)
}
struct ISpatialAudioMetadataItemsBuffer extends IUnknown {
    static IID := "{42640A16-E1BD-42D9-9FF6-031AB71A2DBA}"
    AttachToBuffer(buffer)
      => ComCall(3, this.p, UInt8.Ptr, buffer, UInt32, buffer.Size)
    AttachToPopulatedBuffer(buffer)
      => ComCall(4, this.p, UInt8.Ptr, buffer, UInt32, buffer.Size)
    DetachBuffer()
      => ComCall(5, this.p)
}
struct ISpatialAudioMetadataClient extends IUnknown {
    static IID := "{777D4A3B-F6FF-4A26-85DC-68D7CDEDA1D4}"
    ActivateSpatialAudioMetadataItems(maxItemCount, frameCount, metadataItemsBuffer?, metadataItems)
      => ComCall(3, this.p, UInt16, maxItemCount, UInt16, frameCount, ISpatialAudioMetadataItemsBuffer.Ptr, metadataItemsBuffer?, ISpatialAudioMetadataItems.Ptr, metadataItems)
    GetSpatialAudioMetadataItemsBufferLength(maxItemCount, bufferLength)
      => ComCall(4, this.p, UInt16, maxItemCount, UInt32.Ptr, bufferLength)
    ActivateSpatialAudioMetadataWriter(overflowMode, metadataWriter)
      => ComCall(5, this.p, SpatialAudioMetadataWriterOverflowMode, overflowMode, ISpatialAudioMetadataWriter.Ptr, metadataWriter)
    ActivateSpatialAudioMetadataCopier(metadataCopier)
      => ComCall(6, this.p, ISpatialAudioMetadataCopier.Ptr, metadataCopier)
    ActivateSpatialAudioMetadataReader(metadataReader)
      => ComCall(7, this.p, ISpatialAudioMetadataReader.Ptr, metadataReader)
}
struct ISpatialAudioObjectForMetadataCommands extends ISpatialAudioObjectBase {
    static IID := "{0DF2C94B-F5F9-472D-AF6B-C46E0AC9CD05}"
    WriteNextMetadataCommand(commandID, valueBuffer?)
      => ComCall(7, this.p, UInt8, commandID, Struct.Ptr, valueBuffer?, UInt32, valueBuffer?.Size ?? 0)
}
struct ISpatialAudioObjectForMetadataItems extends ISpatialAudioObjectBase {
    static IID := "{DDEA49FF-3BC0-4377-8AAD-9FBCFD808566}"
    GetSpatialAudioMetadataItems(metadataItems)
      => ComCall(7, this.p, ISpatialAudioMetadataItems.Ptr, metadataItems)
}
struct ISpatialAudioObjectRenderStreamForMetadata extends ISpatialAudioObjectRenderStreamBase {
    static IID := "{BBC9C907-48D5-4A2E-A0C7-F7F0D67C1FB1}"
    ActivateSpatialAudioObjectForMetadataCommands(type, audioObject)
      => ComCall(10, this.p, AudioObjectType, type, ISpatialAudioObjectForMetadataCommands.Ptr, audioObject)
    ActivateSpatialAudioObjectForMetadataItems(type, audioObject)
      => ComCall(11, this.p, AudioObjectType, type, ISpatialAudioObjectForMetadataItems.Ptr, audioObject)
}
struct PROCESS_LOOPBACK_MODE extends Int32 {
    static PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE := 0
    static PROCESS_LOOPBACK_MODE_EXCLUDE_TARGET_PROCESS_TREE := 1
}
struct AUDIOCLIENT_PROCESS_LOOPBACK_PARAMS {
    TargetProcessId : UInt32
    ProcessLoopbackMode : PROCESS_LOOPBACK_MODE
}
struct AUDIOCLIENT_ACTIVATION_TYPE extends Int32 {
    static AUDIOCLIENT_ACTIVATION_TYPE_DEFAULT := 0
    static AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK := 1
}
struct AUDIOCLIENT_ACTIVATION_PARAMS {
    ActivationType : AUDIOCLIENT_ACTIVATION_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ProcessLoopbackParams : AUDIOCLIENT_PROCESS_LOOPBACK_PARAMS
        }
    }
}
struct PAudioStateMonitorCallback extends FunctionPointer {
    static Types := [IAudioStateMonitor, Struct.Ptr, "Void"]
}
struct AudioStateMonitorSoundLevel extends Int32 {
    static Muted := 0
    static Low := 1
    static Full := 2
}
struct IAudioStateMonitor extends IUnknown {
    static IID := "{63BD8738-E30D-4C77-BF5C-834E87C657E2}"
    RegisterCallback(callback, context?, registration)
      => ComCall(3, this.p, PAudioStateMonitorCallback, callback, Struct.Ptr, context?, Int64.Ptr, registration)
    UnregisterCallback(registration)
      => ComCall(4, this.p, Int64, registration, "void")
    GetSoundLevel()
      => ComCall(5, this.p, AudioStateMonitorSoundLevel)
}
struct ACMDRIVERENUMCB extends FunctionPointer {
    static Types := [HACMDRIVERID, IntPtr, UInt32, BOOL]
}
struct LPACMDRIVERPROC extends FunctionPointer {
    static Types := [IntPtr, HACMDRIVERID, UInt32, LPARAM, LPARAM, LRESULT]
}
struct ACMDRIVERDETAILSA {
    cbStruct : UInt32
    fccType : UInt32
    fccComp : UInt32
    wMid : UInt16
    wPid : UInt16
    vdwACM : UInt32
    vdwDriver : UInt32
    fdwSupport : UInt32
    cFormatTags : UInt32
    cFilterTags : UInt32
    hicon : HICON
    szShortName : CHAR[32]
    szLongName : CHAR[128]
    szCopyright : CHAR[80]
    szLicensing : CHAR[128]
    szFeatures : CHAR[512]
}
struct ACMDRIVERDETAILSW {
    cbStruct : UInt32
    fccType : UInt32
    fccComp : UInt32
    wMid : UInt16
    wPid : UInt16
    vdwACM : UInt32
    vdwDriver : UInt32
    fdwSupport : UInt32
    cFormatTags : UInt32
    cFilterTags : UInt32
    hicon : HICON
    szShortName : UInt16[32]
    szLongName : UInt16[128]
    szCopyright : UInt16[80]
    szLicensing : UInt16[128]
    szFeatures : UInt16[512]
}
struct ACMFORMATTAGDETAILSA {
    cbStruct : UInt32
    dwFormatTagIndex : UInt32
    dwFormatTag : UInt32
    cbFormatSize : UInt32
    fdwSupport : UInt32
    cStandardFormats : UInt32
    szFormatTag : CHAR[48]
}
struct ACMFORMATTAGDETAILSW {
    cbStruct : UInt32
    dwFormatTagIndex : UInt32
    dwFormatTag : UInt32
    cbFormatSize : UInt32
    fdwSupport : UInt32
    cStandardFormats : UInt32
    szFormatTag : UInt16[48]
}
struct ACMFORMATTAGENUMCBA extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFORMATTAGDETAILSA.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFORMATTAGENUMCBW extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFORMATTAGDETAILSW.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFORMATDETAILSA {
    cbStruct : UInt32
    dwFormatIndex : UInt32
    dwFormatTag : UInt32
    fdwSupport : UInt32
    pwfx : WAVEFORMATEX.Ptr
    cbwfx : UInt32
    szFormat : CHAR[128]
}
struct tACMFORMATDETAILSW {
    cbStruct : UInt32
    dwFormatIndex : UInt32
    dwFormatTag : UInt32
    fdwSupport : UInt32
    pwfx : WAVEFORMATEX.Ptr
    cbwfx : UInt32
    szFormat : UInt16[128]
}
struct ACMFORMATENUMCBA extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFORMATDETAILSA.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFORMATENUMCBW extends FunctionPointer {
    static Types := [HACMDRIVERID, tACMFORMATDETAILSW.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFORMATCHOOSEHOOKPROCA extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct ACMFORMATCHOOSEHOOKPROCW extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct ACMFORMATCHOOSEA {
    cbStruct : UInt32
    fdwStyle : UInt32
    hwndOwner : HWND
    pwfx : WAVEFORMATEX.Ptr
    cbwfx : UInt32
    pszTitle : PSTR
    szFormatTag : CHAR[48]
    szFormat : CHAR[128]
    pszName : PSTR
    cchName : UInt32
    fdwEnum : UInt32
    pwfxEnum : WAVEFORMATEX.Ptr
    hInstance : HINSTANCE
    pszTemplateName : PSTR
    lCustData : LPARAM
    pfnHook : ACMFORMATCHOOSEHOOKPROCA
}
struct ACMFORMATCHOOSEW {
    cbStruct : UInt32
    fdwStyle : UInt32
    hwndOwner : HWND
    pwfx : WAVEFORMATEX.Ptr
    cbwfx : UInt32
    pszTitle : PWSTR
    szFormatTag : UInt16[48]
    szFormat : UInt16[128]
    pszName : PWSTR
    cchName : UInt32
    fdwEnum : UInt32
    pwfxEnum : WAVEFORMATEX.Ptr
    hInstance : HINSTANCE
    pszTemplateName : PWSTR
    lCustData : LPARAM
    pfnHook : ACMFORMATCHOOSEHOOKPROCW
}
struct ACMFILTERTAGDETAILSA {
    cbStruct : UInt32
    dwFilterTagIndex : UInt32
    dwFilterTag : UInt32
    cbFilterSize : UInt32
    fdwSupport : UInt32
    cStandardFilters : UInt32
    szFilterTag : CHAR[48]
}
struct ACMFILTERTAGDETAILSW {
    cbStruct : UInt32
    dwFilterTagIndex : UInt32
    dwFilterTag : UInt32
    cbFilterSize : UInt32
    fdwSupport : UInt32
    cStandardFilters : UInt32
    szFilterTag : UInt16[48]
}
struct ACMFILTERTAGENUMCBA extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFILTERTAGDETAILSA.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFILTERTAGENUMCBW extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFILTERTAGDETAILSW.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFILTERDETAILSA {
    cbStruct : UInt32
    dwFilterIndex : UInt32
    dwFilterTag : UInt32
    fdwSupport : UInt32
    pwfltr : WAVEFILTER.Ptr
    cbwfltr : UInt32
    szFilter : CHAR[128]
}
struct ACMFILTERDETAILSW {
    cbStruct : UInt32
    dwFilterIndex : UInt32
    dwFilterTag : UInt32
    fdwSupport : UInt32
    pwfltr : WAVEFILTER.Ptr
    cbwfltr : UInt32
    szFilter : UInt16[128]
}
struct ACMFILTERENUMCBA extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFILTERDETAILSA.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFILTERENUMCBW extends FunctionPointer {
    static Types := [HACMDRIVERID, ACMFILTERDETAILSW.Ptr, IntPtr, UInt32, BOOL]
}
struct ACMFILTERCHOOSEHOOKPROCA extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct ACMFILTERCHOOSEHOOKPROCW extends FunctionPointer {
    static Types := [HWND, UInt32, WPARAM, LPARAM, UInt32]
}
struct ACMFILTERCHOOSEA {
    cbStruct : UInt32
    fdwStyle : UInt32
    hwndOwner : HWND
    pwfltr : WAVEFILTER.Ptr
    cbwfltr : UInt32
    pszTitle : PSTR
    szFilterTag : CHAR[48]
    szFilter : CHAR[128]
    pszName : PSTR
    cchName : UInt32
    fdwEnum : UInt32
    pwfltrEnum : WAVEFILTER.Ptr
    hInstance : HINSTANCE
    pszTemplateName : PSTR
    lCustData : LPARAM
    pfnHook : ACMFILTERCHOOSEHOOKPROCA
}
struct ACMFILTERCHOOSEW {
    cbStruct : UInt32
    fdwStyle : UInt32
    hwndOwner : HWND
    pwfltr : WAVEFILTER.Ptr
    cbwfltr : UInt32
    pszTitle : PWSTR
    szFilterTag : UInt16[48]
    szFilter : UInt16[128]
    pszName : PWSTR
    cchName : UInt32
    fdwEnum : UInt32
    pwfltrEnum : WAVEFILTER.Ptr
    hInstance : HINSTANCE
    pszTemplateName : PWSTR
    lCustData : LPARAM
    pfnHook : ACMFILTERCHOOSEHOOKPROCW
}
struct ACMDRVOPENDESCA {
    cbStruct : UInt32
    fccType : UInt32
    fccComp : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    dwError : UInt32
    pszSectionName : PSTR
    pszAliasName : PSTR
    dnDevNode : UInt32
}
struct ACMDRVOPENDESCW {
    cbStruct : UInt32
    fccType : UInt32
    fccComp : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    dwError : UInt32
    pszSectionName : PWSTR
    pszAliasName : PWSTR
    dnDevNode : UInt32
}
struct ACMDRVSTREAMINSTANCE {
    cbStruct : UInt32
    pwfxSrc : WAVEFORMATEX.Ptr
    pwfxDst : WAVEFORMATEX.Ptr
    pwfltr : WAVEFILTER.Ptr
    dwCallback : IntPtr
    dwInstance : IntPtr
    fdwOpen : UInt32
    fdwDriver : UInt32
    dwDriver : IntPtr
    has : HACMSTREAM
}
struct ACMDRVSTREAMHEADER {
    cbStruct : UInt32
    fdwStatus : UInt32
    dwUser : IntPtr
    pbSrc : UInt8.Ptr
    cbSrcLength : UInt32
    cbSrcLengthUsed : UInt32
    dwSrcUser : IntPtr
    pbDst : UInt8.Ptr
    cbDstLength : UInt32
    cbDstLengthUsed : UInt32
    dwDstUser : IntPtr
    fdwConvert : UInt32
    padshNext : ACMDRVSTREAMHEADER.Ptr
    fdwDriver : UInt32
    dwDriver : IntPtr
    fdwPrepared : UInt32
    dwPrepared : IntPtr
    pbPreparedSrc : UInt8.Ptr
    cbPreparedSrcLength : UInt32
    pbPreparedDst : UInt8.Ptr
    cbPreparedDstLength : UInt32
}
struct ACMDRVSTREAMSIZE {
    cbStruct : UInt32
    fdwSize : UInt32
    cbSrcLength : UInt32
    cbDstLength : UInt32
}
struct ACMDRVFORMATSUGGEST {
    cbStruct : UInt32
    fdwSuggest : UInt32
    pwfxSrc : WAVEFORMATEX.Ptr
    cbwfxSrc : UInt32
    pwfxDst : WAVEFORMATEX.Ptr
    cbwfxDst : UInt32
}
