#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HRESULT, HWND, PSTR, PWSTR}
#Import "..\Media\Types.ahk" {IReferenceClock}
#Import "..\Media.Audio\Types.ahk" {HMIDI, WAVEFORMATEX}
#Import "..\Media.Audio.DirectSound\Types.ahk" {IDirectSound, IDirectSoundBuffer}
#Import "..\Media.Multimedia\Types.ahk" {MIDIOPENSTRMID}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}

struct DLSID {
    ulData1 : UInt32
    usData2 : UInt16
    usData3 : UInt16
    abData4 : UInt8[8]
}
struct DLSVERSION {
    dwVersionMS : UInt32
    dwVersionLS : UInt32
}
struct CONNECTION {
    usSource : UInt16
    usControl : UInt16
    usDestination : UInt16
    usTransform : UInt16
    lScale : Int32
}
struct CONNECTIONLIST {
    cbSize : UInt32 := this.Size
    cConnections : UInt32
}
struct RGNRANGE {
    usLow : UInt16
    usHigh : UInt16
}
struct MIDILOCALE {
    ulBank : UInt32
    ulInstrument : UInt32
}
struct RGNHEADER {
    RangeKey : RGNRANGE
    RangeVelocity : RGNRANGE
    fusOptions : UInt16
    usKeyGroup : UInt16
}
struct INSTHEADER {
    cRegions : UInt32
    Locale : MIDILOCALE
}
struct DLSHEADER {
    cInstruments : UInt32
}
struct WAVELINK {
    fusOptions : UInt16
    usPhaseGroup : UInt16
    ulChannel : UInt32
    ulTableIndex : UInt32
}
struct POOLCUE {
    ulOffset : UInt32
}
struct POOLTABLE {
    cbSize : UInt32 := this.Size
    cCues : UInt32
}
struct WSMPL {
    cbSize : UInt32 := this.Size
    usUnityNote : UInt16
    sFineTune : Int16
    lAttenuation : Int32
    fulOptions : UInt32
    cSampleLoops : UInt32
}
struct WLOOP {
    cbSize : UInt32 := this.Size
    ulType : UInt32
    ulStart : UInt32
    ulLength : UInt32
}
struct DMUS_DOWNLOADINFO {
    dwDLType : UInt32
    dwDLId : UInt32
    dwNumOffsetTableEntries : UInt32
    cbSize : UInt32 := this.Size
}
struct DMUS_OFFSETTABLE {
    ulOffsetTable : UInt32[1]
}
struct DMUS_INSTRUMENT {
    ulPatch : UInt32
    ulFirstRegionIdx : UInt32
    ulGlobalArtIdx : UInt32
    ulFirstExtCkIdx : UInt32
    ulCopyrightIdx : UInt32
    ulFlags : UInt32
}
struct DMUS_REGION {
    RangeKey : RGNRANGE
    RangeVelocity : RGNRANGE
    fusOptions : UInt16
    usKeyGroup : UInt16
    ulRegionArtIdx : UInt32
    ulNextRegionIdx : UInt32
    ulFirstExtCkIdx : UInt32
    WaveLink : WAVELINK
    WSMP : WSMPL
    WLOOP : WLOOP[1]
}
struct DMUS_LFOPARAMS {
    pcFrequency : Int32
    tcDelay : Int32
    gcVolumeScale : Int32
    pcPitchScale : Int32
    gcMWToVolume : Int32
    pcMWToPitch : Int32
}
struct DMUS_VEGPARAMS {
    tcAttack : Int32
    tcDecay : Int32
    ptSustain : Int32
    tcRelease : Int32
    tcVel2Attack : Int32
    tcKey2Decay : Int32
}
struct DMUS_PEGPARAMS {
    tcAttack : Int32
    tcDecay : Int32
    ptSustain : Int32
    tcRelease : Int32
    tcVel2Attack : Int32
    tcKey2Decay : Int32
    pcRange : Int32
}
struct DMUS_MSCPARAMS {
    ptDefaultPan : Int32
}
struct DMUS_ARTICPARAMS {
    LFO : DMUS_LFOPARAMS
    VolEG : DMUS_VEGPARAMS
    PitchEG : DMUS_PEGPARAMS
    Misc : DMUS_MSCPARAMS
}
struct DMUS_ARTICULATION {
    ulArt1Idx : UInt32
    ulFirstExtCkIdx : UInt32
}
struct DMUS_ARTICULATION2 {
    ulArtIdx : UInt32
    ulFirstExtCkIdx : UInt32
    ulNextArtIdx : UInt32
}
struct DMUS_EXTENSIONCHUNK {
    cbSize : UInt32 := this.Size
    ulNextExtCkIdx : UInt32
    ExtCkID : UInt32
    byExtCk : UInt8[4]
}
struct DMUS_COPYRIGHT {
    cbSize : UInt32 := this.Size
    byCopyright : UInt8[4]
}
struct DMUS_WAVEDATA {
    cbSize : UInt32 := this.Size
    byData : UInt8[4]
}
struct DMUS_WAVE {
    ulFirstExtCkIdx : UInt32
    ulCopyrightIdx : UInt32
    ulWaveDataIdx : UInt32
    WaveformatEx : WAVEFORMATEX
}
struct DMUS_NOTERANGE {
    dwLowNote : UInt32
    dwHighNote : UInt32
}
struct DMUS_WAVEARTDL {
    ulDownloadIdIdx : UInt32
    ulBus : UInt32
    ulBuffers : UInt32
    ulMasterDLId : UInt32
    usOptions : UInt16
}
struct DMUS_WAVEDL {
    cbWaveData : UInt32
}
struct DMUS_EVENTHEADER {
    cbEvent : UInt32
    dwChannelGroup : UInt32
    rtDelta : Int64
    dwFlags : UInt32
}
struct DMUS_BUFFERDESC {
    dwSize : UInt32
    dwFlags : UInt32
    guidBufferFormat : GUID
    cbBuffer : UInt32
}
struct DMUS_PORTCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    guidPort : GUID
    dwClass : UInt32
    dwType : UInt32
    dwMemorySize : UInt32
    dwMaxChannelGroups : UInt32
    dwMaxVoices : UInt32
    dwMaxAudioChannels : UInt32
    dwEffectFlags : UInt32
    wszDescription : UInt16[128]
}
struct DMUS_PORTPARAMS7 {
    dwSize : UInt32
    dwValidParams : UInt32
    dwVoices : UInt32
    dwChannelGroups : UInt32
    dwAudioChannels : UInt32
    dwSampleRate : UInt32
    dwEffectFlags : UInt32
    fShare : BOOL
}
struct DMUS_PORTPARAMS8 {
    dwSize : UInt32
    dwValidParams : UInt32
    dwVoices : UInt32
    dwChannelGroups : UInt32
    dwAudioChannels : UInt32
    dwSampleRate : UInt32
    dwEffectFlags : UInt32
    fShare : BOOL
    dwFeatures : UInt32
}
struct DMUS_SYNTHSTATS {
    dwSize : UInt32
    dwValidStats : UInt32
    dwVoices : UInt32
    dwTotalCPU : UInt32
    dwCPUPerVoice : UInt32
    dwLostNotes : UInt32
    dwFreeMemory : UInt32
    lPeakVolume : Int32
}
struct DMUS_SYNTHSTATS8 {
    dwSize : UInt32
    dwValidStats : UInt32
    dwVoices : UInt32
    dwTotalCPU : UInt32
    dwCPUPerVoice : UInt32
    dwLostNotes : UInt32
    dwFreeMemory : UInt32
    lPeakVolume : Int32
    dwSynthMemUse : UInt32
}
struct DMUS_WAVES_REVERB_PARAMS {
    fInGain : Float32
    fReverbMix : Float32
    fReverbTime : Float32
    fHighFreqRTRatio : Float32
}
struct DMUS_CLOCKTYPE extends Int32 {
    static DMUS_CLOCK_SYSTEM := 0
    static DMUS_CLOCK_WAVE := 1
}
struct DMUS_CLOCKINFO7 {
    dwSize : UInt32
    ctType : DMUS_CLOCKTYPE
    guidClock : GUID
    wszDescription : UInt16[128]
}
struct DMUS_CLOCKINFO8 {
    dwSize : UInt32
    ctType : DMUS_CLOCKTYPE
    guidClock : GUID
    wszDescription : UInt16[128]
    dwFlags : UInt32
}
struct IDirectMusic extends IUnknown {
    static IID := "{6536115A-7B2D-11D2-BA18-0000F875AC12}"
    EnumPort(dwIndex, pPortCaps)
      => ComCall(3, this.p, UInt32, dwIndex, DMUS_PORTCAPS.Ptr, pPortCaps)
    CreateMusicBuffer(pBufferDesc, ppBuffer, pUnkOuter)
      => ComCall(4, this.p, DMUS_BUFFERDESC.Ptr, pBufferDesc, IDirectMusicBuffer.Ptr, ppBuffer, IUnknown, pUnkOuter)
    CreatePort(rclsidPort, pPortParams, ppPort, pUnkOuter)
      => ComCall(5, this.p, GUID.Ptr, rclsidPort, DMUS_PORTPARAMS8.Ptr, pPortParams, IDirectMusicPort.Ptr, ppPort, IUnknown, pUnkOuter)
    EnumMasterClock(dwIndex, lpClockInfo)
      => ComCall(6, this.p, UInt32, dwIndex, DMUS_CLOCKINFO8.Ptr, lpClockInfo)
    GetMasterClock(pguidClock, ppReferenceClock)
      => ComCall(7, this.p, GUID.Ptr, pguidClock, IReferenceClock.Ptr, ppReferenceClock)
    SetMasterClock(rguidClock)
      => ComCall(8, this.p, GUID.Ptr, rguidClock)
    Activate(fEnable)
      => ComCall(9, this.p, BOOL, fEnable)
    GetDefaultPort(pguidPort)
      => ComCall(10, this.p, GUID.Ptr, pguidPort)
    SetDirectSound(pDirectSound, hWnd1)
      => ComCall(11, this.p, IDirectSound, pDirectSound, HWND, hWnd1)
}
struct IDirectMusic8 extends IDirectMusic {
    static IID := "{2D3629F7-813D-4939-8508-F05C6B75FD97}"
    SetExternalMasterClock(pClock)
      => ComCall(12, this.p, IReferenceClock, pClock)
}
struct IDirectMusicBuffer extends IUnknown {
    static IID := "{D2AC2878-B39B-11D1-8704-00600893B1BD}"
    Flush()
      => ComCall(3, this.p)
    TotalTime(prtTime)
      => ComCall(4, this.p, Int64.Ptr, prtTime)
    PackStructured(rt, dwChannelGroup, dwChannelMessage)
      => ComCall(5, this.p, Int64, rt, UInt32, dwChannelGroup, UInt32, dwChannelMessage)
    PackUnstructured(rt, dwChannelGroup, cb, lpb)
      => ComCall(6, this.p, Int64, rt, UInt32, dwChannelGroup, UInt32, cb, UInt8.Ptr, lpb)
    ResetReadPtr()
      => ComCall(7, this.p)
    GetNextEvent(prt, pdwChannelGroup, pdwLength, ppData)
      => ComCall(8, this.p, Int64.Ptr, prt, UInt32.Ptr, pdwChannelGroup, UInt32.Ptr, pdwLength, UInt8.Ptr.Ptr, ppData)
    GetRawBufferPtr(ppData)
      => ComCall(9, this.p, UInt8.Ptr.Ptr, ppData)
    GetStartTime(prt)
      => ComCall(10, this.p, Int64.Ptr, prt)
    GetUsedBytes(pcb)
      => ComCall(11, this.p, UInt32.Ptr, pcb)
    GetMaxBytes(pcb)
      => ComCall(12, this.p, UInt32.Ptr, pcb)
    GetBufferFormat(pGuidFormat)
      => ComCall(13, this.p, GUID.Ptr, pGuidFormat)
    SetStartTime(rt)
      => ComCall(14, this.p, Int64, rt)
    SetUsedBytes(cb)
      => ComCall(15, this.p, UInt32, cb)
}
struct IDirectMusicInstrument extends IUnknown {
    static IID := "{D2AC287D-B39B-11D1-8704-00600893B1BD}"
    GetPatch(pdwPatch)
      => ComCall(3, this.p, UInt32.Ptr, pdwPatch)
    SetPatch(dwPatch)
      => ComCall(4, this.p, UInt32, dwPatch)
}
struct IDirectMusicDownloadedInstrument extends IUnknown {
    static IID := "{D2AC287E-B39B-11D1-8704-00600893B1BD}"
}
struct IDirectMusicCollection extends IUnknown {
    static IID := "{D2AC287C-B39B-11D1-8704-00600893B1BD}"
    GetInstrument(dwPatch, ppInstrument)
      => ComCall(3, this.p, UInt32, dwPatch, IDirectMusicInstrument.Ptr, ppInstrument)
    EnumInstrument(dwIndex, pdwPatch, pwszName, dwNameLen)
      => ComCall(4, this.p, UInt32, dwIndex, UInt32.Ptr, pdwPatch, "Str", pwszName, UInt32, dwNameLen)
}
struct IDirectMusicDownload extends IUnknown {
    static IID := "{D2AC287B-B39B-11D1-8704-00600893B1BD}"
    GetBuffer(ppvBuffer, pdwSize)
      => ComCall(3, this.p, Struct.Ptr.Ptr, ppvBuffer, UInt32.Ptr, pdwSize)
}
struct IDirectMusicPortDownload extends IUnknown {
    static IID := "{D2AC287A-B39B-11D1-8704-00600893B1BD}"
    GetBuffer(dwDLId, ppIDMDownload)
      => ComCall(3, this.p, UInt32, dwDLId, IDirectMusicDownload.Ptr, ppIDMDownload)
    AllocateBuffer(dwSize, ppIDMDownload)
      => ComCall(4, this.p, UInt32, dwSize, IDirectMusicDownload.Ptr, ppIDMDownload)
    GetDLId(pdwStartDLId, dwCount)
      => ComCall(5, this.p, UInt32.Ptr, pdwStartDLId, UInt32, dwCount)
    GetAppend(pdwAppend)
      => ComCall(6, this.p, UInt32.Ptr, pdwAppend)
    Download(pIDMDownload)
      => ComCall(7, this.p, IDirectMusicDownload, pIDMDownload)
    Unload(pIDMDownload)
      => ComCall(8, this.p, IDirectMusicDownload, pIDMDownload)
}
struct IDirectMusicPort extends IUnknown {
    static IID := "{08F2D8C9-37C2-11D2-B9F9-0000F875AC12}"
    PlayBuffer(pBuffer)
      => ComCall(3, this.p, IDirectMusicBuffer, pBuffer)
    SetReadNotificationHandle(hEvent)
      => ComCall(4, this.p, HANDLE, hEvent)
    Read(pBuffer)
      => ComCall(5, this.p, IDirectMusicBuffer, pBuffer)
    DownloadInstrument(pInstrument, ppDownloadedInstrument, pNoteRanges, dwNumNoteRanges)
      => ComCall(6, this.p, IDirectMusicInstrument, pInstrument, IDirectMusicDownloadedInstrument.Ptr, ppDownloadedInstrument, DMUS_NOTERANGE.Ptr, pNoteRanges, UInt32, dwNumNoteRanges)
    UnloadInstrument(pDownloadedInstrument)
      => ComCall(7, this.p, IDirectMusicDownloadedInstrument, pDownloadedInstrument)
    GetLatencyClock(ppClock)
      => ComCall(8, this.p, IReferenceClock.Ptr, ppClock)
    GetRunningStats(pStats)
      => ComCall(9, this.p, DMUS_SYNTHSTATS.Ptr, pStats)
    Compact()
      => ComCall(10, this.p)
    GetCaps(pPortCaps)
      => ComCall(11, this.p, DMUS_PORTCAPS.Ptr, pPortCaps)
    DeviceIoControl(dwIoControlCode, lpInBuffer, nInBufferSize, lpOutBuffer, nOutBufferSize, lpBytesReturned, lpOverlapped)
      => ComCall(12, this.p, UInt32, dwIoControlCode, Struct.Ptr, lpInBuffer, UInt32, nInBufferSize, Struct.Ptr, lpOutBuffer, UInt32, nOutBufferSize, UInt32.Ptr, lpBytesReturned, OVERLAPPED.Ptr, lpOverlapped)
    SetNumChannelGroups(dwChannelGroups)
      => ComCall(13, this.p, UInt32, dwChannelGroups)
    GetNumChannelGroups(pdwChannelGroups)
      => ComCall(14, this.p, UInt32.Ptr, pdwChannelGroups)
    Activate(fActive)
      => ComCall(15, this.p, BOOL, fActive)
    SetChannelPriority(dwChannelGroup, dwChannel, dwPriority)
      => ComCall(16, this.p, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32, dwPriority)
    GetChannelPriority(dwChannelGroup, dwChannel, pdwPriority)
      => ComCall(17, this.p, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32.Ptr, pdwPriority)
    SetDirectSound(pDirectSound, pDirectSoundBuffer)
      => ComCall(18, this.p, IDirectSound, pDirectSound, IDirectSoundBuffer, pDirectSoundBuffer)
    GetFormat(pWaveFormatEx, pdwWaveFormatExSize, pdwBufferSize)
      => ComCall(19, this.p, WAVEFORMATEX.Ptr, pWaveFormatEx, UInt32.Ptr, pdwWaveFormatExSize, UInt32.Ptr, pdwBufferSize)
}
struct IDirectMusicThru extends IUnknown {
    static IID := "{CED153E7-3606-11D2-B9F9-0000F875AC12}"
    ThruChannel(dwSourceChannelGroup, dwSourceChannel, dwDestinationChannelGroup, dwDestinationChannel, pDestinationPort)
      => ComCall(3, this.p, UInt32, dwSourceChannelGroup, UInt32, dwSourceChannel, UInt32, dwDestinationChannelGroup, UInt32, dwDestinationChannel, IDirectMusicPort, pDestinationPort)
}
struct DMUS_VOICE_STATE {
    bExists : BOOL
    spPosition : Int64
}
struct IDirectMusicSynth extends IUnknown {
    static IID := "{09823661-5C85-11D2-AFA6-00AA0024D8B6}"
    Open(pPortParams)
      => ComCall(3, this.p, DMUS_PORTPARAMS8.Ptr, pPortParams)
    Close()
      => ComCall(4, this.p)
    SetNumChannelGroups(dwGroups)
      => ComCall(5, this.p, UInt32, dwGroups)
    Download(phDownload, pvData, pbFree)
      => ComCall(6, this.p, HANDLE.Ptr, phDownload, Struct.Ptr, pvData, BOOL.Ptr, pbFree)
    Unload(hDownload, lpFreeHandle, hUserData)
      => ComCall(7, this.p, HANDLE, hDownload, IntPtr, lpFreeHandle, HANDLE, hUserData)
    PlayBuffer(rt, pbBuffer, cbBuffer)
      => ComCall(8, this.p, Int64, rt, UInt8.Ptr, pbBuffer, UInt32, cbBuffer)
    GetRunningStats(pStats)
      => ComCall(9, this.p, DMUS_SYNTHSTATS.Ptr, pStats)
    GetPortCaps(pCaps)
      => ComCall(10, this.p, DMUS_PORTCAPS.Ptr, pCaps)
    SetMasterClock(pClock)
      => ComCall(11, this.p, IReferenceClock, pClock)
    GetLatencyClock(ppClock)
      => ComCall(12, this.p, IReferenceClock.Ptr, ppClock)
    Activate(fEnable)
      => ComCall(13, this.p, BOOL, fEnable)
    SetSynthSink(pSynthSink)
      => ComCall(14, this.p, IDirectMusicSynthSink, pSynthSink)
    Render(pBuffer, dwLength, llPosition)
      => ComCall(15, this.p, Int16.Ptr, pBuffer, UInt32, dwLength, Int64, llPosition)
    SetChannelPriority(dwChannelGroup, dwChannel, dwPriority)
      => ComCall(16, this.p, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32, dwPriority)
    GetChannelPriority(dwChannelGroup, dwChannel, pdwPriority)
      => ComCall(17, this.p, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32.Ptr, pdwPriority)
    GetFormat(pWaveFormatEx, pdwWaveFormatExSize)
      => ComCall(18, this.p, WAVEFORMATEX.Ptr, pWaveFormatEx, UInt32.Ptr, pdwWaveFormatExSize)
    GetAppend(pdwAppend)
      => ComCall(19, this.p, UInt32.Ptr, pdwAppend)
}
struct IDirectMusicSynth8 extends IDirectMusicSynth {
    static IID := "{53CAB625-2711-4C9F-9DE7-1B7F925F6FC8}"
    PlayVoice(rt, dwVoiceId, dwChannelGroup, dwChannel, dwDLId, prPitch, vrVolume, stVoiceStart, stLoopStart, stLoopEnd)
      => ComCall(20, this.p, Int64, rt, UInt32, dwVoiceId, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32, dwDLId, Int32, prPitch, Int32, vrVolume, Int64, stVoiceStart, Int64, stLoopStart, Int64, stLoopEnd)
    StopVoice(rt, dwVoiceId)
      => ComCall(21, this.p, Int64, rt, UInt32, dwVoiceId)
    GetVoiceState(dwVoice, cbVoice, dwVoiceState)
      => ComCall(22, this.p, UInt32.Ptr, dwVoice, UInt32, cbVoice, DMUS_VOICE_STATE.Ptr, dwVoiceState)
    Refresh(dwDownloadID, dwFlags)
      => ComCall(23, this.p, UInt32, dwDownloadID, UInt32, dwFlags)
    AssignChannelToBuses(dwChannelGroup, dwChannel, pdwBuses, cBuses)
      => ComCall(24, this.p, UInt32, dwChannelGroup, UInt32, dwChannel, UInt32.Ptr, pdwBuses, UInt32, cBuses)
}
struct IDirectMusicSynthSink extends IUnknown {
    static IID := "{09823663-5C85-11D2-AFA6-00AA0024D8B6}"
    Init(pSynth)
      => ComCall(3, this.p, IDirectMusicSynth, pSynth)
    SetMasterClock(pClock)
      => ComCall(4, this.p, IReferenceClock, pClock)
    GetLatencyClock(ppClock)
      => ComCall(5, this.p, IReferenceClock.Ptr, ppClock)
    Activate(fEnable)
      => ComCall(6, this.p, BOOL, fEnable)
    SampleToRefTime(llSampleTime, prfTime)
      => ComCall(7, this.p, Int64, llSampleTime, Int64.Ptr, prfTime)
    RefTimeToSample(rfTime, pllSampleTime)
      => ComCall(8, this.p, Int64, rfTime, Int64.Ptr, pllSampleTime)
    SetDirectSound(pDirectSound, pDirectSoundBuffer)
      => ComCall(9, this.p, IDirectSound, pDirectSound, IDirectSoundBuffer, pDirectSoundBuffer)
    GetDesiredBufferSize(pdwBufferSizeInSamples)
      => ComCall(10, this.p, UInt32.Ptr, pdwBufferSizeInSamples)
}
struct DSPROPERTY_DIRECTSOUNDDEVICE extends Int32 {
    static DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_A := 1
    static DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1 := 2
    static DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_1 := 3
    static DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_W := 4
    static DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A := 5
    static DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W := 6
    static DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_A := 7
    static DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_W := 8
}
struct DIRECTSOUNDDEVICE_TYPE extends Int32 {
    static DIRECTSOUNDDEVICE_TYPE_EMULATED := 0
    static DIRECTSOUNDDEVICE_TYPE_VXD := 1
    static DIRECTSOUNDDEVICE_TYPE_WDM := 2
}
struct DIRECTSOUNDDEVICE_DATAFLOW extends Int32 {
    static DIRECTSOUNDDEVICE_DATAFLOW_RENDER := 0
    static DIRECTSOUNDDEVICE_DATAFLOW_CAPTURE := 1
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_A_DATA {
    DeviceName : PSTR
    DataFlow : DIRECTSOUNDDEVICE_DATAFLOW
    DeviceId : GUID
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_W_DATA {
    DeviceName : PWSTR
    DataFlow : DIRECTSOUNDDEVICE_DATAFLOW
    DeviceId : GUID
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1_DATA {
    DeviceId : GUID
    DescriptionA : CHAR[256]
    DescriptionW : UInt16[256]
    ModuleA : CHAR[260]
    ModuleW : UInt16[260]
    Type : DIRECTSOUNDDEVICE_TYPE
    DataFlow : DIRECTSOUNDDEVICE_DATAFLOW
    WaveDeviceId : UInt32
    Devnode : UInt32
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A_DATA {
    Type : DIRECTSOUNDDEVICE_TYPE
    DataFlow : DIRECTSOUNDDEVICE_DATAFLOW
    DeviceId : GUID
    Description : PSTR
    Module : PSTR
    Interface : PSTR
    WaveDeviceId : UInt32
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W_DATA {
    Type : DIRECTSOUNDDEVICE_TYPE
    DataFlow : DIRECTSOUNDDEVICE_DATAFLOW
    DeviceId : GUID
    Description : PWSTR
    Module : PWSTR
    Interface : PWSTR
    WaveDeviceId : UInt32
}
struct LPFNDIRECTSOUNDDEVICEENUMERATECALLBACK1 extends FunctionPointer {
    static Types := [DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1_DATA.Ptr, Struct.Ptr, BOOL]
}
struct LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKA extends FunctionPointer {
    static Types := [DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A_DATA.Ptr, Struct.Ptr, BOOL]
}
struct LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKW extends FunctionPointer {
    static Types := [DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W_DATA.Ptr, Struct.Ptr, BOOL]
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_1_DATA {
    Callback : LPFNDIRECTSOUNDDEVICEENUMERATECALLBACK1
    Context : Struct.Ptr
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_A_DATA {
    Callback : LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKA
    Context : Struct.Ptr
}
struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_W_DATA {
    Callback : LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKW
    Context : Struct.Ptr
}
struct DVAudInfo {
    bAudStyle : UInt8[2]
    bAudQu : UInt8[2]
    bNumAudPin : UInt8
    wAvgSamplesPerPinPerFrm : UInt16[2]
    wBlkMode : UInt16
    wDIFMode : UInt16
    wBlkDiv : UInt16
}
struct MDEVICECAPSEX {
    cbSize : UInt32 := this.Size
    pCaps : Struct.Ptr
}
struct MIDIOPENDESC {
    hMidi : HMIDI
    dwCallback : IntPtr
    dwInstance : IntPtr
    dnDevNode : IntPtr
    cIds : UInt32
    rgIds : MIDIOPENSTRMID[1]
}
