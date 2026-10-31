#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HANDLE, HMODULE, HRESULT, HWND, LPARAM, LRESULT, PWSTR, VARIANT_BOOL, WPARAM}
#Import "..\Media.Audio\Types.ahk" {WAVEFORMATEX}
#Import "..\System.Com\Types.ahk" {IDispatch, IServiceProvider, IStream, IUnknown}
#Import "..\System.Com.Urlmon\Types.ahk" {IInternetSecurityManager}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct SPSTATEHANDLE {
    Value : Struct.Ptr
}
struct SPWORDHANDLE {
    Value : Struct.Ptr
}
struct SPRULEHANDLE {
    Value : Struct.Ptr
}
struct SPGRAMMARHANDLE {
    Value : Struct.Ptr
}
struct SPRECOCONTEXTHANDLE {
    Value : Struct.Ptr
}
struct SPPHRASERULEHANDLE {
    Value : Struct.Ptr
}
struct SPPHRASEPROPERTYHANDLE {
    Value : Struct.Ptr
}
struct SPTRANSITIONID {
    Value : Struct.Ptr
}
struct SPDATAKEYLOCATION extends Int32 {
    static SPDKL_DefaultLocation := 0
    static SPDKL_CurrentUser := 1
    static SPDKL_LocalMachine := 2
    static SPDKL_CurrentConfig := 5
}
struct SPSTREAMFORMAT extends Int32 {
    static SPSF_Default := -1
    static SPSF_NoAssignedFormat := 0
    static SPSF_Text := 1
    static SPSF_NonStandardFormat := 2
    static SPSF_ExtendedAudioFormat := 3
    static SPSF_8kHz8BitMono := 4
    static SPSF_8kHz8BitStereo := 5
    static SPSF_8kHz16BitMono := 6
    static SPSF_8kHz16BitStereo := 7
    static SPSF_11kHz8BitMono := 8
    static SPSF_11kHz8BitStereo := 9
    static SPSF_11kHz16BitMono := 10
    static SPSF_11kHz16BitStereo := 11
    static SPSF_12kHz8BitMono := 12
    static SPSF_12kHz8BitStereo := 13
    static SPSF_12kHz16BitMono := 14
    static SPSF_12kHz16BitStereo := 15
    static SPSF_16kHz8BitMono := 16
    static SPSF_16kHz8BitStereo := 17
    static SPSF_16kHz16BitMono := 18
    static SPSF_16kHz16BitStereo := 19
    static SPSF_22kHz8BitMono := 20
    static SPSF_22kHz8BitStereo := 21
    static SPSF_22kHz16BitMono := 22
    static SPSF_22kHz16BitStereo := 23
    static SPSF_24kHz8BitMono := 24
    static SPSF_24kHz8BitStereo := 25
    static SPSF_24kHz16BitMono := 26
    static SPSF_24kHz16BitStereo := 27
    static SPSF_32kHz8BitMono := 28
    static SPSF_32kHz8BitStereo := 29
    static SPSF_32kHz16BitMono := 30
    static SPSF_32kHz16BitStereo := 31
    static SPSF_44kHz8BitMono := 32
    static SPSF_44kHz8BitStereo := 33
    static SPSF_44kHz16BitMono := 34
    static SPSF_44kHz16BitStereo := 35
    static SPSF_48kHz8BitMono := 36
    static SPSF_48kHz8BitStereo := 37
    static SPSF_48kHz16BitMono := 38
    static SPSF_48kHz16BitStereo := 39
    static SPSF_TrueSpeech_8kHz1BitMono := 40
    static SPSF_CCITT_ALaw_8kHzMono := 41
    static SPSF_CCITT_ALaw_8kHzStereo := 42
    static SPSF_CCITT_ALaw_11kHzMono := 43
    static SPSF_CCITT_ALaw_11kHzStereo := 44
    static SPSF_CCITT_ALaw_22kHzMono := 45
    static SPSF_CCITT_ALaw_22kHzStereo := 46
    static SPSF_CCITT_ALaw_44kHzMono := 47
    static SPSF_CCITT_ALaw_44kHzStereo := 48
    static SPSF_CCITT_uLaw_8kHzMono := 49
    static SPSF_CCITT_uLaw_8kHzStereo := 50
    static SPSF_CCITT_uLaw_11kHzMono := 51
    static SPSF_CCITT_uLaw_11kHzStereo := 52
    static SPSF_CCITT_uLaw_22kHzMono := 53
    static SPSF_CCITT_uLaw_22kHzStereo := 54
    static SPSF_CCITT_uLaw_44kHzMono := 55
    static SPSF_CCITT_uLaw_44kHzStereo := 56
    static SPSF_ADPCM_8kHzMono := 57
    static SPSF_ADPCM_8kHzStereo := 58
    static SPSF_ADPCM_11kHzMono := 59
    static SPSF_ADPCM_11kHzStereo := 60
    static SPSF_ADPCM_22kHzMono := 61
    static SPSF_ADPCM_22kHzStereo := 62
    static SPSF_ADPCM_44kHzMono := 63
    static SPSF_ADPCM_44kHzStereo := 64
    static SPSF_GSM610_8kHzMono := 65
    static SPSF_GSM610_11kHzMono := 66
    static SPSF_GSM610_22kHzMono := 67
    static SPSF_GSM610_44kHzMono := 68
    static SPSF_NUM_FORMATS := 69
}
struct ISpNotifyCallback extends InterfacePointer {
    NotifyCallback(wParam1, lParam1)
      => ComCall(0, this.p, WPARAM, wParam1, LPARAM, lParam1)
}
struct SPNOTIFYCALLBACK extends FunctionPointer {
    static Types := [WPARAM, LPARAM, "Void"]
}
struct ISpNotifySource extends IUnknown {
    static IID := "{5EFF4AEF-8487-11D2-961C-00C04F8EE628}"
    SetNotifySink(pNotifySink?)
      => ComCall(3, this.p, ISpNotifySink, pNotifySink?)
    SetNotifyWindowMessage(hWnd1, Msg, wParam1, lParam1)
      => ComCall(4, this.p, HWND, hWnd1, UInt32, Msg, WPARAM, wParam1, LPARAM, lParam1)
    SetNotifyCallbackFunction(pfnCallback, wParam1, lParam1)
      => ComCall(5, this.p, SPNOTIFYCALLBACK.Ptr, pfnCallback, WPARAM, wParam1, LPARAM, lParam1)
    SetNotifyCallbackInterface(pSpCallback, wParam1, lParam1)
      => ComCall(6, this.p, ISpNotifyCallback, pSpCallback, WPARAM, wParam1, LPARAM, lParam1)
    SetNotifyWin32Event()
      => ComCall(7, this.p)
    WaitForNotifyEvent(dwMilliseconds)
      => ComCall(8, this.p, UInt32, dwMilliseconds)
    GetNotifyEventHandle()
      => ComCall(9, this.p, HANDLE)
}
struct ISpNotifySink extends IUnknown {
    static IID := "{259684DC-37C3-11D2-9603-00C04F8EE628}"
    Notify()
      => ComCall(3, this.p)
}
struct ISpNotifyTranslator extends ISpNotifySink {
    static IID := "{ACA16614-5D3D-11D2-960E-00C04F8EE628}"
    InitWindowMessage(hWnd1, Msg, wParam1, lParam1)
      => ComCall(4, this.p, HWND, hWnd1, UInt32, Msg, WPARAM, wParam1, LPARAM, lParam1)
    InitCallback(pfnCallback, wParam1, lParam1)
      => ComCall(5, this.p, SPNOTIFYCALLBACK.Ptr, pfnCallback, WPARAM, wParam1, LPARAM, lParam1)
    InitSpNotifyCallback(pSpCallback, wParam1, lParam1)
      => ComCall(6, this.p, ISpNotifyCallback, pSpCallback, WPARAM, wParam1, LPARAM, lParam1)
    InitWin32Event(hEvent, fCloseHandleOnRelease)
      => ComCall(7, this.p, HANDLE, hEvent, BOOL, fCloseHandleOnRelease)
    Wait(dwMilliseconds)
      => ComCall(8, this.p, UInt32, dwMilliseconds)
    GetEventHandle()
      => ComCall(9, this.p, HANDLE)
}
struct ISpDataKey extends IUnknown {
    static IID := "{14056581-E16C-11D2-BB90-00C04F8EE6C0}"
    SetData(pszValueName, cbData, pData)
      => ComCall(3, this.p, "Str", pszValueName, UInt32, cbData, UInt8.Ptr, pData)
    GetData(pszValueName, pcbData, pData)
      => ComCall(4, this.p, "Str", pszValueName, UInt32.Ptr, pcbData, UInt8.Ptr, pData)
    SetStringValue(pszValueName?, pszValue)
      => ComCall(5, this.p, "Str", pszValueName?, "Str", pszValue)
    GetStringValue(pszValueName?, ppszValue)
      => ComCall(6, this.p, "Str", pszValueName?, PWSTR.Ptr, ppszValue)
    SetDWORD(pszValueName, dwValue)
      => ComCall(7, this.p, "Str", pszValueName, UInt32, dwValue)
    GetDWORD(pszValueName, pdwValue)
      => ComCall(8, this.p, "Str", pszValueName, UInt32.Ptr, pdwValue)
    OpenKey(pszSubKeyName, ppSubKey)
      => ComCall(9, this.p, "Str", pszSubKeyName, ISpDataKey.Ptr, ppSubKey)
    CreateKey(pszSubKey, ppSubKey)
      => ComCall(10, this.p, "Str", pszSubKey, ISpDataKey.Ptr, ppSubKey)
    DeleteKey(pszSubKey)
      => ComCall(11, this.p, "Str", pszSubKey)
    DeleteValue(pszValueName)
      => ComCall(12, this.p, "Str", pszValueName)
    EnumKeys(Index, ppszSubKeyName)
      => ComCall(13, this.p, UInt32, Index, PWSTR.Ptr, ppszSubKeyName)
    EnumValues(Index, ppszValueName)
      => ComCall(14, this.p, UInt32, Index, PWSTR.Ptr, ppszValueName)
}
struct ISpRegDataKey extends ISpDataKey {
    static IID := "{92A66E2B-C830-4149-83DF-6FC2BA1E7A5B}"
    SetKey(hkey1, fReadOnly)
      => ComCall(15, this.p, HKEY, hkey1, BOOL, fReadOnly)
}
struct ISpObjectTokenCategory extends ISpDataKey {
    static IID := "{2D3D3845-39AF-4850-BBF9-40B49780011D}"
    SetId(pszCategoryId, fCreateIfNotExist)
      => ComCall(15, this.p, "Str", pszCategoryId, BOOL, fCreateIfNotExist)
    GetId(ppszCoMemCategoryId)
      => ComCall(16, this.p, PWSTR.Ptr, ppszCoMemCategoryId)
    GetDataKey(spdkl, ppDataKey)
      => ComCall(17, this.p, SPDATAKEYLOCATION, spdkl, ISpDataKey.Ptr, ppDataKey)
    EnumTokens(pzsReqAttribs?, pszOptAttribs?, ppEnum)
      => ComCall(18, this.p, "Str", pzsReqAttribs?, "Str", pszOptAttribs?, IEnumSpObjectTokens.Ptr, ppEnum)
    SetDefaultTokenId(pszTokenId)
      => ComCall(19, this.p, "Str", pszTokenId)
    GetDefaultTokenId(ppszCoMemTokenId)
      => ComCall(20, this.p, PWSTR.Ptr, ppszCoMemTokenId)
}
struct ISpObjectToken extends ISpDataKey {
    static IID := "{14056589-E16C-11D2-BB90-00C04F8EE6C0}"
    SetId(pszCategoryId?, pszTokenId, fCreateIfNotExist)
      => ComCall(15, this.p, "Str", pszCategoryId?, "Str", pszTokenId, BOOL, fCreateIfNotExist)
    GetId(ppszCoMemTokenId)
      => ComCall(16, this.p, PWSTR.Ptr, ppszCoMemTokenId)
    GetCategory(ppTokenCategory)
      => ComCall(17, this.p, ISpObjectTokenCategory.Ptr, ppTokenCategory)
    CreateInstance(pUnkOuter, dwClsContext, riid, ppvObject)
      => ComCall(18, this.p, IUnknown, pUnkOuter, UInt32, dwClsContext, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    GetStorageFileName(clsidCaller, pszValueName, pszFileNameSpecifier?, nFolder, ppszFilePath)
      => ComCall(19, this.p, GUID.Ptr, clsidCaller, "Str", pszValueName, "Str", pszFileNameSpecifier?, UInt32, nFolder, PWSTR.Ptr, ppszFilePath)
    RemoveStorageFileName(clsidCaller, pszKeyName, fDeleteFile)
      => ComCall(20, this.p, GUID.Ptr, clsidCaller, "Str", pszKeyName, BOOL, fDeleteFile)
    Remove(pclsidCaller?)
      => ComCall(21, this.p, GUID.Ptr, pclsidCaller?)
    IsUISupported(pszTypeOfUI, pvExtraData, cbExtraData, punkObject, pfSupported)
      => ComCall(22, this.p, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, IUnknown, punkObject, BOOL.Ptr, pfSupported)
    DisplayUI(hwndParent, pszTitle, pszTypeOfUI, pvExtraData, cbExtraData, punkObject)
      => ComCall(23, this.p, HWND, hwndParent, "Str", pszTitle, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, IUnknown, punkObject)
    MatchesAttributes(pszAttributes, pfMatches)
      => ComCall(24, this.p, "Str", pszAttributes, BOOL.Ptr, pfMatches)
}
struct ISpObjectTokenInit extends ISpObjectToken {
    static IID := "{B8AAB0CF-346F-49D8-9499-C8B03F161D51}"
    InitFromDataKey(pszCategoryId, pszTokenId, pDataKey?)
      => ComCall(25, this.p, "Str", pszCategoryId, "Str", pszTokenId, ISpDataKey, pDataKey?)
}
struct IEnumSpObjectTokens extends IUnknown {
    static IID := "{06B64F9E-7FDA-11D2-B4F2-00C04F797396}"
    Next(celt, pelt, pceltFetched?)
      => ComCall(3, this.p, UInt32, celt, ISpObjectToken.Ptr, pelt, UInt32.Ptr, pceltFetched?)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumSpObjectTokens.Ptr, ppEnum)
    Item(Index, ppToken)
      => ComCall(7, this.p, UInt32, Index, ISpObjectToken.Ptr, ppToken)
    GetCount(pCount)
      => ComCall(8, this.p, UInt32.Ptr, pCount)
}
struct ISpObjectWithToken extends IUnknown {
    static IID := "{5B559F40-E952-11D2-BB91-00C04F8EE6C0}"
    SetObjectToken(pToken?)
      => ComCall(3, this.p, ISpObjectToken, pToken?)
    GetObjectToken(ppToken)
      => ComCall(4, this.p, ISpObjectToken.Ptr, ppToken)
}
struct ISpResourceManager extends IServiceProvider {
    static IID := "{93384E18-5014-43D5-ADBB-A78E055926BD}"
    SetObject(guidServiceId, pUnkObject?)
      => ComCall(4, this.p, GUID.Ptr, guidServiceId, IUnknown, pUnkObject?)
    GetObject(guidServiceId, ObjectCLSID, ObjectIID, fReleaseWhenLastExternalRefReleased, ppObject)
      => ComCall(5, this.p, GUID.Ptr, guidServiceId, GUID.Ptr, ObjectCLSID, GUID.Ptr, ObjectIID, BOOL, fReleaseWhenLastExternalRefReleased, Struct.Ptr.Ptr, ppObject)
}
struct SPEVENTLPARAMTYPE extends Int32 {
    static SPET_LPARAM_IS_UNDEFINED := 0
    static SPET_LPARAM_IS_TOKEN := 1
    static SPET_LPARAM_IS_OBJECT := 2
    static SPET_LPARAM_IS_POINTER := 3
    static SPET_LPARAM_IS_STRING := 4
}
struct SPEVENTENUM extends Int32 {
    static SPEI_UNDEFINED := 0
    static SPEI_START_INPUT_STREAM := 1
    static SPEI_END_INPUT_STREAM := 2
    static SPEI_VOICE_CHANGE := 3
    static SPEI_TTS_BOOKMARK := 4
    static SPEI_WORD_BOUNDARY := 5
    static SPEI_PHONEME := 6
    static SPEI_SENTENCE_BOUNDARY := 7
    static SPEI_VISEME := 8
    static SPEI_TTS_AUDIO_LEVEL := 9
    static SPEI_TTS_PRIVATE := 15
    static SPEI_MIN_TTS := 1
    static SPEI_MAX_TTS := 15
    static SPEI_END_SR_STREAM := 34
    static SPEI_SOUND_START := 35
    static SPEI_SOUND_END := 36
    static SPEI_PHRASE_START := 37
    static SPEI_RECOGNITION := 38
    static SPEI_HYPOTHESIS := 39
    static SPEI_SR_BOOKMARK := 40
    static SPEI_PROPERTY_NUM_CHANGE := 41
    static SPEI_PROPERTY_STRING_CHANGE := 42
    static SPEI_FALSE_RECOGNITION := 43
    static SPEI_INTERFERENCE := 44
    static SPEI_REQUEST_UI := 45
    static SPEI_RECO_STATE_CHANGE := 46
    static SPEI_ADAPTATION := 47
    static SPEI_START_SR_STREAM := 48
    static SPEI_RECO_OTHER_CONTEXT := 49
    static SPEI_SR_AUDIO_LEVEL := 50
    static SPEI_SR_RETAINEDAUDIO := 51
    static SPEI_SR_PRIVATE := 52
    static SPEI_RESERVED4 := 53
    static SPEI_RESERVED5 := 54
    static SPEI_RESERVED6 := 55
    static SPEI_MIN_SR := 34
    static SPEI_MAX_SR := 55
    static SPEI_RESERVED1 := 30
    static SPEI_RESERVED2 := 33
    static SPEI_RESERVED3 := 63
}
struct SPEVENT {
    _bitfield : Int32
    ulStreamNum : UInt32
    ullAudioStreamOffset : Int64
    wParam : WPARAM
    lParam : LPARAM
}
struct SPSERIALIZEDEVENT {
    _bitfield : Int32
    ulStreamNum : UInt32
    ullAudioStreamOffset : Int64
    SerializedwParam : UInt32
    SerializedlParam : Int32
}
struct SPSERIALIZEDEVENT64 {
    _bitfield : Int32
    ulStreamNum : UInt32
    ullAudioStreamOffset : Int64
    SerializedwParam : Int64
    SerializedlParam : Int64
}
struct SPEVENTEX {
    _bitfield : Int32
    ulStreamNum : UInt32
    ullAudioStreamOffset : Int64
    wParam : WPARAM
    lParam : LPARAM
    ullAudioTimeOffset : Int64
}
struct SPINTERFERENCE extends Int32 {
    static SPINTERFERENCE_NONE := 0
    static SPINTERFERENCE_NOISE := 1
    static SPINTERFERENCE_NOSIGNAL := 2
    static SPINTERFERENCE_TOOLOUD := 3
    static SPINTERFERENCE_TOOQUIET := 4
    static SPINTERFERENCE_TOOFAST := 5
    static SPINTERFERENCE_TOOSLOW := 6
    static SPINTERFERENCE_LATENCY_WARNING := 7
    static SPINTERFERENCE_LATENCY_TRUNCATE_BEGIN := 8
    static SPINTERFERENCE_LATENCY_TRUNCATE_END := 9
}
struct SPENDSRSTREAMFLAGS extends Int32 {
    static SPESF_NONE := 0
    static SPESF_STREAM_RELEASED := 1
    static SPESF_EMULATED := 2
}
struct SPVFEATURE extends Int32 {
    static SPVFEATURE_STRESSED := 1
    static SPVFEATURE_EMPHASIS := 2
}
struct SPVISEMES extends Int32 {
    static SP_VISEME_0 := 0
    static SP_VISEME_1 := 1
    static SP_VISEME_2 := 2
    static SP_VISEME_3 := 3
    static SP_VISEME_4 := 4
    static SP_VISEME_5 := 5
    static SP_VISEME_6 := 6
    static SP_VISEME_7 := 7
    static SP_VISEME_8 := 8
    static SP_VISEME_9 := 9
    static SP_VISEME_10 := 10
    static SP_VISEME_11 := 11
    static SP_VISEME_12 := 12
    static SP_VISEME_13 := 13
    static SP_VISEME_14 := 14
    static SP_VISEME_15 := 15
    static SP_VISEME_16 := 16
    static SP_VISEME_17 := 17
    static SP_VISEME_18 := 18
    static SP_VISEME_19 := 19
    static SP_VISEME_20 := 20
    static SP_VISEME_21 := 21
}
struct SPEVENTSOURCEINFO {
    ullEventInterest : Int64
    ullQueuedInterest : Int64
    ulCount : UInt32
}
struct ISpEventSource extends ISpNotifySource {
    static IID := "{BE7A9CCE-5F9E-11D2-960F-00C04F8EE628}"
    SetInterest(ullEventInterest, ullQueuedInterest)
      => ComCall(10, this.p, Int64, ullEventInterest, Int64, ullQueuedInterest)
    GetEvents(ulCount, pEventArray, pulFetched)
      => ComCall(11, this.p, UInt32, ulCount, SPEVENT.Ptr, pEventArray, UInt32.Ptr, pulFetched)
    GetInfo(pInfo)
      => ComCall(12, this.p, SPEVENTSOURCEINFO.Ptr, pInfo)
}
struct ISpEventSource2 extends ISpEventSource {
    static IID := "{2373A435-6A4B-429E-A6AC-D4231A61975B}"
    GetEventsEx(ulCount, pEventArray, pulFetched)
      => ComCall(13, this.p, UInt32, ulCount, SPEVENTEX.Ptr, pEventArray, UInt32.Ptr, pulFetched)
}
struct ISpEventSink extends IUnknown {
    static IID := "{BE7A9CC9-5F9E-11D2-960F-00C04F8EE628}"
    AddEvents(pEventArray, ulCount)
      => ComCall(3, this.p, SPEVENT.Ptr, pEventArray, UInt32, ulCount)
    GetEventInterest(pullEventInterest)
      => ComCall(4, this.p, Int64.Ptr, pullEventInterest)
}
struct ISpStreamFormat extends IStream {
    static IID := "{BED530BE-2606-4F4D-A1C0-54C5CDA5566F}"
    GetFormat(pguidFormatId, ppCoMemWaveFormatEx)
      => ComCall(14, this.p, GUID.Ptr, pguidFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemWaveFormatEx)
}
struct SPFILEMODE extends Int32 {
    static SPFM_OPEN_READONLY := 0
    static SPFM_OPEN_READWRITE := 1
    static SPFM_CREATE := 2
    static SPFM_CREATE_ALWAYS := 3
    static SPFM_NUM_MODES := 4
}
struct ISpStream extends ISpStreamFormat {
    static IID := "{12E3CCA9-7518-44C5-A5E7-BA5A79CB929E}"
    SetBaseStream(pStream, rguidFormat, pWaveFormatEx)
      => ComCall(15, this.p, IStream, pStream, GUID.Ptr, rguidFormat, WAVEFORMATEX.Ptr, pWaveFormatEx)
    GetBaseStream(ppStream)
      => ComCall(16, this.p, IStream.Ptr, ppStream)
    BindToFile(pszFileName, eMode, pFormatId?, pWaveFormatEx?, ullEventInterest)
      => ComCall(17, this.p, "Str", pszFileName, SPFILEMODE, eMode, GUID.Ptr, pFormatId?, WAVEFORMATEX.Ptr, pWaveFormatEx?, Int64, ullEventInterest)
    Close()
      => ComCall(18, this.p)
}
struct ISpStreamFormatConverter extends ISpStreamFormat {
    static IID := "{678A932C-EA71-4446-9B41-78FDA6280A29}"
    SetBaseStream(pStream?, fSetFormatToBaseStreamFormat, fWriteToBaseStream)
      => ComCall(15, this.p, ISpStreamFormat, pStream?, BOOL, fSetFormatToBaseStreamFormat, BOOL, fWriteToBaseStream)
    GetBaseStream(ppStream)
      => ComCall(16, this.p, ISpStreamFormat.Ptr, ppStream)
    SetFormat(rguidFormatIdOfConvertedStream, pWaveFormatExOfConvertedStream)
      => ComCall(17, this.p, GUID.Ptr, rguidFormatIdOfConvertedStream, WAVEFORMATEX.Ptr, pWaveFormatExOfConvertedStream)
    ResetSeekPosition()
      => ComCall(18, this.p)
    ScaleConvertedToBaseOffset(ullOffsetConvertedStream, pullOffsetBaseStream)
      => ComCall(19, this.p, Int64, ullOffsetConvertedStream, Int64.Ptr, pullOffsetBaseStream)
    ScaleBaseToConvertedOffset(ullOffsetBaseStream, pullOffsetConvertedStream)
      => ComCall(20, this.p, Int64, ullOffsetBaseStream, Int64.Ptr, pullOffsetConvertedStream)
}
struct SPAUDIOSTATE extends Int32 {
    static SPAS_CLOSED := 0
    static SPAS_STOP := 1
    static SPAS_PAUSE := 2
    static SPAS_RUN := 3
}
struct SPAUDIOSTATUS {
    cbFreeBuffSpace : Int32
    cbNonBlockingIO : UInt32
    State : SPAUDIOSTATE
    CurSeekPos : Int64
    CurDevicePos : Int64
    dwAudioLevel : UInt32
    dwReserved2 : UInt32
}
struct SPAUDIOBUFFERINFO {
    ulMsMinNotification : UInt32
    ulMsBufferSize : UInt32
    ulMsEventBias : UInt32
}
struct ISpAudio extends ISpStreamFormat {
    static IID := "{C05C768F-FAE8-4EC2-8E07-338321C12452}"
    SetState(NewState, ullReserved)
      => ComCall(15, this.p, SPAUDIOSTATE, NewState, Int64, ullReserved)
    SetFormat(rguidFmtId, pWaveFormatEx)
      => ComCall(16, this.p, GUID.Ptr, rguidFmtId, WAVEFORMATEX.Ptr, pWaveFormatEx)
    GetStatus(pStatus)
      => ComCall(17, this.p, SPAUDIOSTATUS.Ptr, pStatus)
    SetBufferInfo(pBuffInfo)
      => ComCall(18, this.p, SPAUDIOBUFFERINFO.Ptr, pBuffInfo)
    GetBufferInfo(pBuffInfo)
      => ComCall(19, this.p, SPAUDIOBUFFERINFO.Ptr, pBuffInfo)
    GetDefaultFormat(pFormatId, ppCoMemWaveFormatEx)
      => ComCall(20, this.p, GUID.Ptr, pFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemWaveFormatEx)
    EventHandle()
      => ComCall(21, this.p, HANDLE)
    GetVolumeLevel(pLevel)
      => ComCall(22, this.p, UInt32.Ptr, pLevel)
    SetVolumeLevel(Level)
      => ComCall(23, this.p, UInt32, Level)
    GetBufferNotifySize(pcbSize)
      => ComCall(24, this.p, UInt32.Ptr, pcbSize)
    SetBufferNotifySize(cbSize)
      => ComCall(25, this.p, UInt32, cbSize)
}
struct ISpMMSysAudio extends ISpAudio {
    static IID := "{15806F6E-1D70-4B48-98E6-3B1A007509AB}"
    GetDeviceId(puDeviceId)
      => ComCall(26, this.p, UInt32.Ptr, puDeviceId)
    SetDeviceId(uDeviceId)
      => ComCall(27, this.p, UInt32, uDeviceId)
    GetMMHandle(pHandle)
      => ComCall(28, this.p, Struct.Ptr.Ptr, pHandle)
    GetLineId(puLineId)
      => ComCall(29, this.p, UInt32.Ptr, puLineId)
    SetLineId(uLineId)
      => ComCall(30, this.p, UInt32, uLineId)
}
struct ISpTranscript extends IUnknown {
    static IID := "{10F63BCE-201A-11D3-AC70-00C04F8EE6C0}"
    GetTranscript(ppszTranscript)
      => ComCall(3, this.p, PWSTR.Ptr, ppszTranscript)
    AppendTranscript(pszTranscript)
      => ComCall(4, this.p, "Str", pszTranscript)
}
struct SPDISPLAYATTRIBUTES extends Int32 {
    static SPAF_ONE_TRAILING_SPACE := 2
    static SPAF_TWO_TRAILING_SPACES := 4
    static SPAF_CONSUME_LEADING_SPACES := 8
    static SPAF_BUFFER_POSITION := 16
    static SPAF_ALL := 31
    static SPAF_USER_SPECIFIED := 128
}
struct SPPHRASEELEMENT {
    ulAudioTimeOffset : UInt32
    ulAudioSizeTime : UInt32
    ulAudioStreamOffset : UInt32
    ulAudioSizeBytes : UInt32
    ulRetainedStreamOffset : UInt32
    ulRetainedSizeBytes : UInt32
    pszDisplayText : PWSTR
    pszLexicalForm : PWSTR
    pszPronunciation : UInt16.Ptr
    bDisplayAttributes : UInt8
    RequiredConfidence : Int8
    ActualConfidence : Int8
    Reserved : UInt8
    SREngineConfidence : Float32
}
struct SPPHRASERULE {
    pszName : PWSTR
    ulId : UInt32
    ulFirstElement : UInt32
    ulCountOfElements : UInt32
    pNextSibling : SPPHRASERULE.Ptr
    pFirstChild : SPPHRASERULE.Ptr
    SREngineConfidence : Float32
    Confidence : Int8
}
struct SPPHRASEPROPERTYUNIONTYPE extends Int32 {
    static SPPPUT_UNUSED := 0
    static SPPPUT_ARRAY_INDEX := 1
}
struct SPPHRASEPROPERTY {
    pszName : PWSTR
    Anonymous : this._Anonymous_e__Union
    pszValue : PWSTR
    vValue : VARIANT
    ulFirstElement : UInt32
    ulCountOfElements : UInt32
    pNextSibling : SPPHRASEPROPERTY.Ptr
    pFirstChild : SPPHRASEPROPERTY.Ptr
    SREngineConfidence : Float32
    Confidence : Int8
    struct _Anonymous_e__Union {
        union {
            ulId : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            bType : UInt8
            bReserved : UInt8
            usArrayIndex : UInt16
        }
    }
}
struct SPPHRASEREPLACEMENT {
    bDisplayAttributes : UInt8
    pszReplacementText : PWSTR
    ulFirstElement : UInt32
    ulCountOfElements : UInt32
}
struct SPSEMANTICERRORINFO {
    ulLineNumber : UInt32
    pszScriptLine : PWSTR
    pszSource : PWSTR
    pszDescription : PWSTR
    hrResultCode : HRESULT
}
struct SPSEMANTICFORMAT extends Int32 {
    static SPSMF_SAPI_PROPERTIES := 0
    static SPSMF_SRGS_SEMANTICINTERPRETATION_MS := 1
    static SPSMF_SRGS_SAPIPROPERTIES := 2
    static SPSMF_UPS := 4
    static SPSMF_SRGS_SEMANTICINTERPRETATION_W3C := 8
}
struct SPPHRASE_50 {
    cbSize : UInt32 := this.Size
    LangID : UInt16
    wHomophoneGroupId : UInt16
    ullGrammarID : Int64
    ftStartTime : Int64
    ullAudioStreamPosition : Int64
    ulAudioSizeBytes : UInt32
    ulRetainedSizeBytes : UInt32
    ulAudioSizeTime : UInt32
    Rule : SPPHRASERULE
    pProperties : SPPHRASEPROPERTY.Ptr
    pElements : SPPHRASEELEMENT.Ptr
    cReplacements : UInt32
    pReplacements : SPPHRASEREPLACEMENT.Ptr
    SREngineID : GUID
    ulSREnginePrivateDataSize : UInt32
    pSREnginePrivateData : UInt8.Ptr
}
struct SPPHRASE {
    Base : SPPHRASE_50
    pSML : PWSTR
    pSemanticErrorInfo : SPSEMANTICERRORINFO.Ptr
}
struct SPSERIALIZEDPHRASE {
    ulSerializedSize : UInt32
}
struct SPRULE {
    pszRuleName : PWSTR
    ulRuleId : UInt32
    dwAttributes : UInt32
}
struct SPVALUETYPE extends Int32 {
    static SPDF_PROPERTY := 1
    static SPDF_REPLACEMENT := 2
    static SPDF_RULE := 4
    static SPDF_DISPLAYTEXT := 8
    static SPDF_LEXICALFORM := 16
    static SPDF_PRONUNCIATION := 32
    static SPDF_AUDIO := 64
    static SPDF_ALTERNATES := 128
    static SPDF_ALL := 255
}
struct SPBINARYGRAMMAR {
    ulTotalSerializedSize : UInt32
}
struct SPPHRASERNG extends Int32 {
    static SPPR_ALL_ELEMENTS := -1
}
struct SPRECOEVENTFLAGS extends Int32 {
    static SPREF_AutoPause := 1
    static SPREF_Emulated := 2
    static SPREF_SMLTimeout := 4
    static SPREF_ExtendableParse := 8
    static SPREF_ReSent := 16
    static SPREF_Hypothesis := 32
    static SPREF_FalseRecognition := 64
}
struct SPPARTOFSPEECH extends Int32 {
    static SPPS_NotOverriden := -1
    static SPPS_Unknown := 0
    static SPPS_Noun := 4096
    static SPPS_Verb := 8192
    static SPPS_Modifier := 12288
    static SPPS_Function := 16384
    static SPPS_Interjection := 20480
    static SPPS_Noncontent := 24576
    static SPPS_LMA := 28672
    static SPPS_SuppressWord := 61440
}
struct SPLEXICONTYPE extends Int32 {
    static eLEXTYPE_USER := 1
    static eLEXTYPE_APP := 2
    static eLEXTYPE_VENDORLEXICON := 4
    static eLEXTYPE_LETTERTOSOUND := 8
    static eLEXTYPE_MORPHOLOGY := 16
    static eLEXTYPE_RESERVED4 := 32
    static eLEXTYPE_USER_SHORTCUT := 64
    static eLEXTYPE_RESERVED6 := 128
    static eLEXTYPE_RESERVED7 := 256
    static eLEXTYPE_RESERVED8 := 512
    static eLEXTYPE_RESERVED9 := 1024
    static eLEXTYPE_RESERVED10 := 2048
    static eLEXTYPE_PRIVATE1 := 4096
    static eLEXTYPE_PRIVATE2 := 8192
    static eLEXTYPE_PRIVATE3 := 16384
    static eLEXTYPE_PRIVATE4 := 32768
    static eLEXTYPE_PRIVATE5 := 65536
    static eLEXTYPE_PRIVATE6 := 131072
    static eLEXTYPE_PRIVATE7 := 262144
    static eLEXTYPE_PRIVATE8 := 524288
    static eLEXTYPE_PRIVATE9 := 1048576
    static eLEXTYPE_PRIVATE10 := 2097152
    static eLEXTYPE_PRIVATE11 := 4194304
    static eLEXTYPE_PRIVATE12 := 8388608
    static eLEXTYPE_PRIVATE13 := 16777216
    static eLEXTYPE_PRIVATE14 := 33554432
    static eLEXTYPE_PRIVATE15 := 67108864
    static eLEXTYPE_PRIVATE16 := 134217728
    static eLEXTYPE_PRIVATE17 := 268435456
    static eLEXTYPE_PRIVATE18 := 536870912
    static eLEXTYPE_PRIVATE19 := 1073741824
    static eLEXTYPE_PRIVATE20 := -2147483648
}
struct SPWORDTYPE extends Int32 {
    static eWORDTYPE_ADDED := 1
    static eWORDTYPE_DELETED := 2
}
struct SPPRONUNCIATIONFLAGS extends Int32 {
    static ePRONFLAG_USED := 1
}
struct SPWORDPRONUNCIATION {
    pNextWordPronunciation : SPWORDPRONUNCIATION.Ptr
    eLexiconType : SPLEXICONTYPE
    LangID : UInt16
    wPronunciationFlags : UInt16
    ePartOfSpeech : SPPARTOFSPEECH
    szPronunciation : UInt16[1]
}
struct SPWORDPRONUNCIATIONLIST {
    ulSize : UInt32
    pvBuffer : UInt8.Ptr
    pFirstWordPronunciation : SPWORDPRONUNCIATION.Ptr
}
struct SPWORD {
    pNextWord : SPWORD.Ptr
    LangID : UInt16
    wReserved : UInt16
    eWordType : SPWORDTYPE
    pszWord : PWSTR
    pFirstWordPronunciation : SPWORDPRONUNCIATION.Ptr
}
struct SPWORDLIST {
    ulSize : UInt32
    pvBuffer : UInt8.Ptr
    pFirstWord : SPWORD.Ptr
}
struct ISpLexicon extends IUnknown {
    static IID := "{DA41A7C2-5383-4DB2-916B-6C1719E3DB58}"
    GetPronunciations(pszWord, LangID, dwFlags, pWordPronunciationList)
      => ComCall(3, this.p, "Str", pszWord, UInt16, LangID, UInt32, dwFlags, SPWORDPRONUNCIATIONLIST.Ptr, pWordPronunciationList)
    AddPronunciation(pszWord, LangID, ePartOfSpeech, pszPronunciation?)
      => ComCall(4, this.p, "Str", pszWord, UInt16, LangID, SPPARTOFSPEECH, ePartOfSpeech, UInt16.Ptr, pszPronunciation?)
    RemovePronunciation(pszWord, LangID, ePartOfSpeech, pszPronunciation?)
      => ComCall(5, this.p, "Str", pszWord, UInt16, LangID, SPPARTOFSPEECH, ePartOfSpeech, UInt16.Ptr, pszPronunciation?)
    GetGeneration(pdwGeneration)
      => ComCall(6, this.p, UInt32.Ptr, pdwGeneration)
    GetGenerationChange(dwFlags, pdwGeneration, pWordList)
      => ComCall(7, this.p, UInt32, dwFlags, UInt32.Ptr, pdwGeneration, SPWORDLIST.Ptr, pWordList)
    GetWords(dwFlags, pdwGeneration, pdwCookie?, pWordList)
      => ComCall(8, this.p, UInt32, dwFlags, UInt32.Ptr, pdwGeneration, UInt32.Ptr, pdwCookie?, SPWORDLIST.Ptr, pWordList)
}
struct ISpContainerLexicon extends ISpLexicon {
    static IID := "{8565572F-C094-41CC-B56E-10BD9C3FF044}"
    AddLexicon(pAddLexicon?, dwFlags)
      => ComCall(9, this.p, ISpLexicon, pAddLexicon?, UInt32, dwFlags)
}
struct SPSHORTCUTTYPE extends Int32 {
    static SPSHT_NotOverriden := -1
    static SPSHT_Unknown := 0
    static SPSHT_EMAIL := 4096
    static SPSHT_OTHER := 8192
    static SPPS_RESERVED1 := 12288
    static SPPS_RESERVED2 := 16384
    static SPPS_RESERVED3 := 20480
    static SPPS_RESERVED4 := 61440
}
struct SPSHORTCUTPAIR {
    pNextSHORTCUTPAIR : SPSHORTCUTPAIR.Ptr
    LangID : UInt16
    shType : SPSHORTCUTTYPE
    pszDisplay : PWSTR
    pszSpoken : PWSTR
}
struct SPSHORTCUTPAIRLIST {
    ulSize : UInt32
    pvBuffer : UInt8.Ptr
    pFirstShortcutPair : SPSHORTCUTPAIR.Ptr
}
struct ISpShortcut extends IUnknown {
    static IID := "{3DF681E2-EA56-11D9-8BDE-F66BAD1E3F3A}"
    AddShortcut(pszDisplay, LangID, pszSpoken, shType)
      => ComCall(3, this.p, "Str", pszDisplay, UInt16, LangID, "Str", pszSpoken, SPSHORTCUTTYPE, shType)
    RemoveShortcut(pszDisplay, LangID, pszSpoken, shType)
      => ComCall(4, this.p, "Str", pszDisplay, UInt16, LangID, "Str", pszSpoken, SPSHORTCUTTYPE, shType)
    GetShortcuts(LangID, pShortcutpairList)
      => ComCall(5, this.p, UInt16, LangID, SPSHORTCUTPAIRLIST.Ptr, pShortcutpairList)
    GetGeneration(pdwGeneration)
      => ComCall(6, this.p, UInt32.Ptr, pdwGeneration)
    GetWordsFromGenerationChange(pdwGeneration, pWordList)
      => ComCall(7, this.p, UInt32.Ptr, pdwGeneration, SPWORDLIST.Ptr, pWordList)
    GetWords(pdwGeneration, pdwCookie, pWordList)
      => ComCall(8, this.p, UInt32.Ptr, pdwGeneration, UInt32.Ptr, pdwCookie, SPWORDLIST.Ptr, pWordList)
    GetShortcutsForGeneration(pdwGeneration, pdwCookie, pShortcutpairList)
      => ComCall(9, this.p, UInt32.Ptr, pdwGeneration, UInt32.Ptr, pdwCookie, SPSHORTCUTPAIRLIST.Ptr, pShortcutpairList)
    GetGenerationChange(pdwGeneration, pShortcutpairList)
      => ComCall(10, this.p, UInt32.Ptr, pdwGeneration, SPSHORTCUTPAIRLIST.Ptr, pShortcutpairList)
}
struct ISpPhoneConverter extends ISpObjectWithToken {
    static IID := "{8445C581-0CAC-4A38-ABFE-9B2CE2826455}"
    PhoneToId(pszPhone, pId)
      => ComCall(5, this.p, "Str", pszPhone, UInt16.Ptr, pId)
    IdToPhone(pId, pszPhone)
      => ComCall(6, this.p, UInt16.Ptr, pId, PWSTR, pszPhone)
}
struct ISpPhoneticAlphabetConverter extends IUnknown {
    static IID := "{133ADCD4-19B4-4020-9FDC-842E78253B17}"
    GetLangId(pLangID)
      => ComCall(3, this.p, UInt16.Ptr, pLangID)
    SetLangId(LangID)
      => ComCall(4, this.p, UInt16, LangID)
    SAPI2UPS(pszSAPIId, pszUPSId)
      => ComCall(5, this.p, UInt16.Ptr, pszSAPIId, UInt16.Ptr, pszUPSId, UInt32, pszUPSId.Length)
    UPS2SAPI(pszUPSId, pszSAPIId)
      => ComCall(6, this.p, UInt16.Ptr, pszUPSId, UInt16.Ptr, pszSAPIId, UInt32, pszSAPIId.Length)
    GetMaxConvertLength(cSrcLength, bSAPI2UPS, pcMaxDestLength)
      => ComCall(7, this.p, UInt32, cSrcLength, BOOL, bSAPI2UPS, UInt32.Ptr, pcMaxDestLength)
}
struct ISpPhoneticAlphabetSelection extends IUnknown {
    static IID := "{B2745EFD-42CE-48CA-81F1-A96E02538A90}"
    IsAlphabetUPS(pfIsUPS)
      => ComCall(3, this.p, BOOL.Ptr, pfIsUPS)
    SetAlphabetToUPS(fForceUPS)
      => ComCall(4, this.p, BOOL, fForceUPS)
}
struct SPVPITCH {
    MiddleAdj : Int32
    RangeAdj : Int32
}
struct SPVACTIONS extends Int32 {
    static SPVA_Speak := 0
    static SPVA_Silence := 1
    static SPVA_Pronounce := 2
    static SPVA_Bookmark := 3
    static SPVA_SpellOut := 4
    static SPVA_Section := 5
    static SPVA_ParseUnknownTag := 6
}
struct SPVCONTEXT {
    pCategory : PWSTR
    pBefore : PWSTR
    pAfter : PWSTR
}
struct SPVSTATE {
    eAction : SPVACTIONS
    LangID : UInt16
    wReserved : UInt16
    EmphAdj : Int32
    RateAdj : Int32
    Volume : UInt32
    PitchAdj : SPVPITCH
    SilenceMSecs : UInt32
    pPhoneIds : UInt16.Ptr
    ePartOfSpeech : SPPARTOFSPEECH
    Context : SPVCONTEXT
}
struct SPRUNSTATE extends Int32 {
    static SPRS_DONE := 1
    static SPRS_IS_SPEAKING := 2
}
struct SPVLIMITS extends Int32 {
    static SPMIN_VOLUME := 0
    static SPMAX_VOLUME := 100
    static SPMIN_RATE := -10
    static SPMAX_RATE := 10
}
struct SPVPRIORITY extends Int32 {
    static SPVPRI_NORMAL := 0
    static SPVPRI_ALERT := 1
    static SPVPRI_OVER := 2
}
struct SPVOICESTATUS {
    ulCurrentStream : UInt32
    ulLastStreamQueued : UInt32
    hrLastResult : HRESULT
    dwRunningState : UInt32
    ulInputWordPos : UInt32
    ulInputWordLen : UInt32
    ulInputSentPos : UInt32
    ulInputSentLen : UInt32
    lBookmarkId : Int32
    PhonemeId : UInt16
    VisemeId : SPVISEMES
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct SPEAKFLAGS extends Int32 {
    static SPF_DEFAULT := 0
    static SPF_ASYNC := 1
    static SPF_PURGEBEFORESPEAK := 2
    static SPF_IS_FILENAME := 4
    static SPF_IS_XML := 8
    static SPF_IS_NOT_XML := 16
    static SPF_PERSIST_XML := 32
    static SPF_NLP_SPEAK_PUNC := 64
    static SPF_PARSE_SAPI := 128
    static SPF_PARSE_SSML := 256
    static SPF_PARSE_AUTODETECT := 0
    static SPF_NLP_MASK := 64
    static SPF_PARSE_MASK := 384
    static SPF_VOICE_MASK := 511
    static SPF_UNUSED_FLAGS := -512
}
struct ISpVoice extends ISpEventSource {
    static IID := "{6C44DF74-72B9-4992-A1EC-EF996E0422D4}"
    SetOutput(pUnkOutput, fAllowFormatChanges)
      => ComCall(13, this.p, IUnknown, pUnkOutput, BOOL, fAllowFormatChanges)
    GetOutputObjectToken(ppObjectToken)
      => ComCall(14, this.p, ISpObjectToken.Ptr, ppObjectToken)
    GetOutputStream(ppStream)
      => ComCall(15, this.p, ISpStreamFormat.Ptr, ppStream)
    Pause()
      => ComCall(16, this.p)
    Resume()
      => ComCall(17, this.p)
    SetVoice(pToken)
      => ComCall(18, this.p, ISpObjectToken, pToken)
    GetVoice(ppToken)
      => ComCall(19, this.p, ISpObjectToken.Ptr, ppToken)
    Speak(pwcs?, dwFlags, pulStreamNumber?)
      => ComCall(20, this.p, "Str", pwcs?, UInt32, dwFlags, UInt32.Ptr, pulStreamNumber?)
    SpeakStream(pStream, dwFlags, pulStreamNumber?)
      => ComCall(21, this.p, IStream, pStream, UInt32, dwFlags, UInt32.Ptr, pulStreamNumber?)
    GetStatus(pStatus, ppszLastBookmark)
      => ComCall(22, this.p, SPVOICESTATUS.Ptr, pStatus, PWSTR.Ptr, ppszLastBookmark)
    Skip(pItemType, lNumItems, pulNumSkipped)
      => ComCall(23, this.p, "Str", pItemType, Int32, lNumItems, UInt32.Ptr, pulNumSkipped)
    SetPriority(ePriority)
      => ComCall(24, this.p, SPVPRIORITY, ePriority)
    GetPriority(pePriority)
      => ComCall(25, this.p, SPVPRIORITY.Ptr, pePriority)
    SetAlertBoundary(eBoundary)
      => ComCall(26, this.p, SPEVENTENUM, eBoundary)
    GetAlertBoundary(peBoundary)
      => ComCall(27, this.p, SPEVENTENUM.Ptr, peBoundary)
    SetRate(RateAdjust)
      => ComCall(28, this.p, Int32, RateAdjust)
    GetRate(pRateAdjust)
      => ComCall(29, this.p, Int32.Ptr, pRateAdjust)
    SetVolume(usVolume)
      => ComCall(30, this.p, UInt16, usVolume)
    GetVolume(pusVolume)
      => ComCall(31, this.p, UInt16.Ptr, pusVolume)
    WaitUntilDone(msTimeout)
      => ComCall(32, this.p, UInt32, msTimeout)
    SetSyncSpeakTimeout(msTimeout)
      => ComCall(33, this.p, UInt32, msTimeout)
    GetSyncSpeakTimeout(pmsTimeout)
      => ComCall(34, this.p, UInt32.Ptr, pmsTimeout)
    SpeakCompleteEvent()
      => ComCall(35, this.p, HANDLE)
    IsUISupported(pszTypeOfUI, pvExtraData, cbExtraData, pfSupported)
      => ComCall(36, this.p, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, BOOL.Ptr, pfSupported)
    DisplayUI(hwndParent, pszTitle, pszTypeOfUI, pvExtraData, cbExtraData)
      => ComCall(37, this.p, HWND, hwndParent, "Str", pszTitle, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData)
}
struct ISpPhrase extends IUnknown {
    static IID := "{1A5C0354-B621-4B5A-8791-D306ED379E53}"
    GetPhrase(ppCoMemPhrase)
      => ComCall(3, this.p, SPPHRASE.Ptr.Ptr, ppCoMemPhrase)
    GetSerializedPhrase(ppCoMemPhrase)
      => ComCall(4, this.p, SPSERIALIZEDPHRASE.Ptr.Ptr, ppCoMemPhrase)
    GetText(ulStart, ulCount, fUseTextReplacements, ppszCoMemText, pbDisplayAttributes?)
      => ComCall(5, this.p, UInt32, ulStart, UInt32, ulCount, BOOL, fUseTextReplacements, PWSTR.Ptr, ppszCoMemText, UInt8.Ptr, pbDisplayAttributes?)
    Discard(dwValueTypes)
      => ComCall(6, this.p, UInt32, dwValueTypes)
}
struct ISpPhraseAlt extends ISpPhrase {
    static IID := "{8FCEBC98-4E49-4067-9C6C-D86A0E092E3D}"
    GetAltInfo(ppParent, pulStartElementInParent, pcElementsInParent, pcElementsInAlt)
      => ComCall(7, this.p, ISpPhrase.Ptr, ppParent, UInt32.Ptr, pulStartElementInParent, UInt32.Ptr, pcElementsInParent, UInt32.Ptr, pcElementsInAlt)
    Commit()
      => ComCall(8, this.p)
}
struct SPXMLRESULTOPTIONS extends Int32 {
    static SPXRO_SML := 0
    static SPXRO_Alternates_SML := 1
}
struct ISpPhrase2 extends ISpPhrase {
    static IID := "{F264DA52-E457-4696-B856-A737B717AF79}"
    GetXMLResult(ppszCoMemXMLResult, Options)
      => ComCall(7, this.p, PWSTR.Ptr, ppszCoMemXMLResult, SPXMLRESULTOPTIONS, Options)
    GetXMLErrorInfo(pSemanticErrorInfo)
      => ComCall(8, this.p, SPSEMANTICERRORINFO.Ptr, pSemanticErrorInfo)
    GetAudio(ulStartElement, cElements, ppStream)
      => ComCall(9, this.p, UInt32, ulStartElement, UInt32, cElements, ISpStreamFormat.Ptr, ppStream)
}
struct SPRECORESULTTIMES {
    ftStreamTime : FILETIME
    ullLength : Int64
    dwTickCount : UInt32
    ullStart : Int64
}
struct SPSERIALIZEDRESULT {
    ulSerializedSize : UInt32
}
struct ISpRecoResult extends ISpPhrase {
    static IID := "{20B053BE-E235-43CD-9A2A-8D17A48B7842}"
    GetResultTimes(pTimes)
      => ComCall(7, this.p, SPRECORESULTTIMES.Ptr, pTimes)
    GetAlternates(ulStartElement, cElements, ppPhrases, pcPhrasesReturned)
      => ComCall(8, this.p, UInt32, ulStartElement, UInt32, cElements, UInt32, ppPhrases.Length, ISpPhraseAlt.Ptr, ppPhrases, UInt32.Ptr, pcPhrasesReturned)
    GetAudio(ulStartElement, cElements, ppStream)
      => ComCall(9, this.p, UInt32, ulStartElement, UInt32, cElements, ISpStreamFormat.Ptr, ppStream)
    SpeakAudio(ulStartElement, cElements, dwFlags, pulStreamNumber)
      => ComCall(10, this.p, UInt32, ulStartElement, UInt32, cElements, UInt32, dwFlags, UInt32.Ptr, pulStreamNumber)
    Serialize(ppCoMemSerializedResult)
      => ComCall(11, this.p, SPSERIALIZEDRESULT.Ptr.Ptr, ppCoMemSerializedResult)
    ScaleAudio(pAudioFormatId, pWaveFormatEx)
      => ComCall(12, this.p, GUID.Ptr, pAudioFormatId, WAVEFORMATEX.Ptr, pWaveFormatEx)
    GetRecoContext(ppRecoContext)
      => ComCall(13, this.p, ISpRecoContext.Ptr, ppRecoContext)
}
struct SPCOMMITFLAGS extends Int32 {
    static SPCF_NONE := 0
    static SPCF_ADD_TO_USER_LEXICON := 1
    static SPCF_DEFINITE_CORRECTION := 2
}
struct ISpRecoResult2 extends ISpRecoResult {
    static IID := "{27CAC6C4-88F2-41F2-8817-0C95E59F1E6E}"
    CommitAlternate(pPhraseAlt, ppNewResult)
      => ComCall(14, this.p, ISpPhraseAlt, pPhraseAlt, ISpRecoResult.Ptr, ppNewResult)
    CommitText(ulStartElement, cElements, pszCorrectedData?, eCommitFlags)
      => ComCall(15, this.p, UInt32, ulStartElement, UInt32, cElements, "Str", pszCorrectedData?, UInt32, eCommitFlags)
    SetTextFeedback(pszFeedback, fSuccessful)
      => ComCall(16, this.p, "Str", pszFeedback, BOOL, fSuccessful)
}
struct ISpXMLRecoResult extends ISpRecoResult {
    static IID := "{AE39362B-45A8-4074-9B9E-CCF49AA2D0B6}"
    GetXMLResult(ppszCoMemXMLResult, Options)
      => ComCall(14, this.p, PWSTR.Ptr, ppszCoMemXMLResult, SPXMLRESULTOPTIONS, Options)
    GetXMLErrorInfo(pSemanticErrorInfo)
      => ComCall(15, this.p, SPSEMANTICERRORINFO.Ptr, pSemanticErrorInfo)
}
struct SPTEXTSELECTIONINFO {
    ulStartActiveOffset : UInt32
    cchActiveChars : UInt32
    ulStartSelection : UInt32
    cchSelection : UInt32
}
struct SPWORDPRONOUNCEABLE extends Int32 {
    static SPWP_UNKNOWN_WORD_UNPRONOUNCEABLE := 0
    static SPWP_UNKNOWN_WORD_PRONOUNCEABLE := 1
    static SPWP_KNOWN_WORD_PRONOUNCEABLE := 2
}
struct SPGRAMMARSTATE extends Int32 {
    static SPGS_DISABLED := 0
    static SPGS_ENABLED := 1
    static SPGS_EXCLUSIVE := 3
}
struct SPCONTEXTSTATE extends Int32 {
    static SPCS_DISABLED := 0
    static SPCS_ENABLED := 1
}
struct SPRULESTATE extends Int32 {
    static SPRS_INACTIVE := 0
    static SPRS_ACTIVE := 1
    static SPRS_ACTIVE_WITH_AUTO_PAUSE := 3
    static SPRS_ACTIVE_USER_DELIMITED := 4
}
struct SPGRAMMARWORDTYPE extends Int32 {
    static SPWT_DISPLAY := 0
    static SPWT_LEXICAL := 1
    static SPWT_PRONUNCIATION := 2
    static SPWT_LEXICAL_NO_SPECIAL_CHARS := 3
}
struct SPPROPERTYINFO {
    pszName : PWSTR
    ulId : UInt32
    pszValue : PWSTR
    vValue : VARIANT
}
struct SPCFGRULEATTRIBUTES extends Int32 {
    static SPRAF_TopLevel := 1
    static SPRAF_Active := 2
    static SPRAF_Export := 4
    static SPRAF_Import := 8
    static SPRAF_Interpreter := 16
    static SPRAF_Dynamic := 32
    static SPRAF_Root := 64
    static SPRAF_AutoPause := 65536
    static SPRAF_UserDelimited := 131072
}
struct ISpGrammarBuilder extends IUnknown {
    static IID := "{8137828F-591A-4A42-BE58-49EA7EBAAC68}"
    ResetGrammar(NewLanguage)
      => ComCall(3, this.p, UInt16, NewLanguage)
    GetRule(pszRuleName, dwRuleId, dwAttributes, fCreateIfNotExist, phInitialState)
      => ComCall(4, this.p, "Str", pszRuleName, UInt32, dwRuleId, UInt32, dwAttributes, BOOL, fCreateIfNotExist, SPSTATEHANDLE.Ptr, phInitialState)
    ClearRule(hState)
      => ComCall(5, this.p, SPSTATEHANDLE, hState)
    CreateNewState(hState, phState)
      => ComCall(6, this.p, SPSTATEHANDLE, hState, SPSTATEHANDLE.Ptr, phState)
    AddWordTransition(hFromState, hToState, psz?, pszSeparators?, eWordType, Weight, pPropInfo)
      => ComCall(7, this.p, SPSTATEHANDLE, hFromState, SPSTATEHANDLE, hToState, "Str", psz?, "Str", pszSeparators?, SPGRAMMARWORDTYPE, eWordType, Float32, Weight, SPPROPERTYINFO.Ptr, pPropInfo)
    AddRuleTransition(hFromState, hToState, hRule, Weight, pPropInfo)
      => ComCall(8, this.p, SPSTATEHANDLE, hFromState, SPSTATEHANDLE, hToState, SPSTATEHANDLE, hRule, Float32, Weight, SPPROPERTYINFO.Ptr, pPropInfo)
    AddResource(hRuleState, pszResourceName, pszResourceValue?)
      => ComCall(9, this.p, SPSTATEHANDLE, hRuleState, "Str", pszResourceName, "Str", pszResourceValue?)
    Commit(dwReserved)
      => ComCall(10, this.p, UInt32, dwReserved)
}
struct SPLOADOPTIONS extends Int32 {
    static SPLO_STATIC := 0
    static SPLO_DYNAMIC := 1
}
struct ISpRecoGrammar extends ISpGrammarBuilder {
    static IID := "{2177DB29-7F45-47D0-8554-067E91C80502}"
    GetGrammarId(pullGrammarId)
      => ComCall(11, this.p, Int64.Ptr, pullGrammarId)
    GetRecoContext(ppRecoCtxt)
      => ComCall(12, this.p, ISpRecoContext.Ptr, ppRecoCtxt)
    LoadCmdFromFile(pszFileName, Options)
      => ComCall(13, this.p, "Str", pszFileName, SPLOADOPTIONS, Options)
    LoadCmdFromObject(rcid, pszGrammarName, Options)
      => ComCall(14, this.p, GUID.Ptr, rcid, "Str", pszGrammarName, SPLOADOPTIONS, Options)
    LoadCmdFromResource(hModule1, pszResourceName, pszResourceType, wLanguage, Options)
      => ComCall(15, this.p, HMODULE, hModule1, "Str", pszResourceName, "Str", pszResourceType, UInt16, wLanguage, SPLOADOPTIONS, Options)
    LoadCmdFromMemory(pGrammar, Options)
      => ComCall(16, this.p, SPBINARYGRAMMAR.Ptr, pGrammar, SPLOADOPTIONS, Options)
    LoadCmdFromProprietaryGrammar(rguidParam, pszStringParam, pvDataPrarm, cbDataSize, Options)
      => ComCall(17, this.p, GUID.Ptr, rguidParam, "Str", pszStringParam, Struct.Ptr, pvDataPrarm, UInt32, cbDataSize, SPLOADOPTIONS, Options)
    SetRuleState(pszName?, pReserved, NewState)
      => ComCall(18, this.p, "Str", pszName?, Struct.Ptr, pReserved, SPRULESTATE, NewState)
    SetRuleIdState(ulRuleId, NewState)
      => ComCall(19, this.p, UInt32, ulRuleId, SPRULESTATE, NewState)
    LoadDictation(pszTopicName?, Options)
      => ComCall(20, this.p, "Str", pszTopicName?, SPLOADOPTIONS, Options)
    UnloadDictation()
      => ComCall(21, this.p)
    SetDictationState(NewState)
      => ComCall(22, this.p, SPRULESTATE, NewState)
    SetWordSequenceData(pText?, pInfo)
      => ComCall(23, this.p, "Str", pText?, UInt32, pText?.Length ?? 0, SPTEXTSELECTIONINFO.Ptr, pInfo)
    SetTextSelection(pInfo)
      => ComCall(24, this.p, SPTEXTSELECTIONINFO.Ptr, pInfo)
    IsPronounceable(pszWord, pWordPronounceable)
      => ComCall(25, this.p, "Str", pszWord, SPWORDPRONOUNCEABLE.Ptr, pWordPronounceable)
    SetGrammarState(eGrammarState)
      => ComCall(26, this.p, SPGRAMMARSTATE, eGrammarState)
    SaveCmd(pStream, ppszCoMemErrorText?)
      => ComCall(27, this.p, IStream, pStream, PWSTR.Ptr, ppszCoMemErrorText?)
    GetGrammarState(peGrammarState)
      => ComCall(28, this.p, SPGRAMMARSTATE.Ptr, peGrammarState)
}
struct SPMATCHINGMODE extends Int32 {
    static AllWords := 0
    static Subsequence := 1
    static OrderedSubset := 3
    static SubsequenceContentRequired := 5
    static OrderedSubsetContentRequired := 7
}
struct PHONETICALPHABET extends Int32 {
    static PA_Ipa := 0
    static PA_Ups := 1
    static PA_Sapi := 2
}
struct ISpGrammarBuilder2 extends IUnknown {
    static IID := "{8AB10026-20CC-4B20-8C22-A49C9BA78F60}"
    AddTextSubset(hFromState, hToState, psz, eMatchMode)
      => ComCall(3, this.p, SPSTATEHANDLE, hFromState, SPSTATEHANDLE, hToState, "Str", psz, SPMATCHINGMODE, eMatchMode)
    SetPhoneticAlphabet(phoneticALphabet1)
      => ComCall(4, this.p, PHONETICALPHABET, phoneticALphabet1)
}
struct ISpRecoGrammar2 extends IUnknown {
    static IID := "{4B37BC9E-9ED6-44A3-93D3-18F022B79EC3}"
    GetRules(ppCoMemRules, puNumRules)
      => ComCall(3, this.p, SPRULE.Ptr.Ptr, ppCoMemRules, UInt32.Ptr, puNumRules)
    LoadCmdFromFile2(pszFileName, Options, pszSharingUri?, pszBaseUri?)
      => ComCall(4, this.p, "Str", pszFileName, SPLOADOPTIONS, Options, "Str", pszSharingUri?, "Str", pszBaseUri?)
    LoadCmdFromMemory2(pGrammar, Options, pszSharingUri?, pszBaseUri?)
      => ComCall(5, this.p, SPBINARYGRAMMAR.Ptr, pGrammar, SPLOADOPTIONS, Options, "Str", pszSharingUri?, "Str", pszBaseUri?)
    SetRulePriority(pszRuleName, ulRuleId, nRulePriority)
      => ComCall(6, this.p, "Str", pszRuleName, UInt32, ulRuleId, Int32, nRulePriority)
    SetRuleWeight(pszRuleName, ulRuleId, flWeight)
      => ComCall(7, this.p, "Str", pszRuleName, UInt32, ulRuleId, Float32, flWeight)
    SetDictationWeight(flWeight)
      => ComCall(8, this.p, Float32, flWeight)
    SetGrammarLoader(pLoader)
      => ComCall(9, this.p, ISpeechResourceLoader, pLoader)
    SetSMLSecurityManager(pSMLSecurityManager)
      => ComCall(10, this.p, IInternetSecurityManager, pSMLSecurityManager)
}
struct ISpeechResourceLoader extends IDispatch {
    static IID := "{B9AC5783-FCD0-4B21-B119-B4F8DA8FD2C3}"
    LoadResource(bstrResourceUri, fAlwaysReload, pStream, pbstrMIMEType?, pfModified, pbstrRedirectUrl?)
      => ComCall(7, this.p, BSTR, bstrResourceUri, VARIANT_BOOL, fAlwaysReload, IUnknown.Ptr, pStream, BSTR.Ptr, pbstrMIMEType?, VARIANT_BOOL.Ptr, pfModified, BSTR.Ptr, pbstrRedirectUrl?)
    GetLocalCopy(bstrResourceUri, pbstrLocalPath, pbstrMIMEType?, pbstrRedirectUrl?)
      => ComCall(8, this.p, BSTR, bstrResourceUri, BSTR.Ptr, pbstrLocalPath, BSTR.Ptr, pbstrMIMEType?, BSTR.Ptr, pbstrRedirectUrl?)
    ReleaseLocalCopy(pbstrLocalPath)
      => ComCall(9, this.p, BSTR, pbstrLocalPath)
}
struct SPRECOCONTEXTSTATUS {
    eInterference : SPINTERFERENCE
    szRequestTypeOfUI : UInt16[255]
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct SPBOOKMARKOPTIONS extends Int32 {
    static SPBO_NONE := 0
    static SPBO_PAUSE := 1
    static SPBO_AHEAD := 2
    static SPBO_TIME_UNITS := 4
}
struct SPAUDIOOPTIONS extends Int32 {
    static SPAO_NONE := 0
    static SPAO_RETAIN_AUDIO := 1
}
struct ISpRecoContext extends ISpEventSource {
    static IID := "{F740A62F-7C15-489E-8234-940A33D9272D}"
    GetRecognizer(ppRecognizer)
      => ComCall(13, this.p, ISpRecognizer.Ptr, ppRecognizer)
    CreateGrammar(ullGrammarId, ppGrammar)
      => ComCall(14, this.p, Int64, ullGrammarId, ISpRecoGrammar.Ptr, ppGrammar)
    GetStatus(pStatus)
      => ComCall(15, this.p, SPRECOCONTEXTSTATUS.Ptr, pStatus)
    GetMaxAlternates(pcAlternates)
      => ComCall(16, this.p, UInt32.Ptr, pcAlternates)
    SetMaxAlternates(cAlternates)
      => ComCall(17, this.p, UInt32, cAlternates)
    SetAudioOptions(Options, pAudioFormatId, pWaveFormatEx)
      => ComCall(18, this.p, SPAUDIOOPTIONS, Options, GUID.Ptr, pAudioFormatId, WAVEFORMATEX.Ptr, pWaveFormatEx)
    GetAudioOptions(pOptions, pAudioFormatId, ppCoMemWFEX)
      => ComCall(19, this.p, SPAUDIOOPTIONS.Ptr, pOptions, GUID.Ptr, pAudioFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemWFEX)
    DeserializeResult(pSerializedResult, ppResult)
      => ComCall(20, this.p, SPSERIALIZEDRESULT.Ptr, pSerializedResult, ISpRecoResult.Ptr, ppResult)
    Bookmark(Options, ullStreamPosition, lparamEvent)
      => ComCall(21, this.p, SPBOOKMARKOPTIONS, Options, Int64, ullStreamPosition, LPARAM, lparamEvent)
    SetAdaptationData(pAdaptationData, cch)
      => ComCall(22, this.p, "Str", pAdaptationData, UInt32, cch)
    Pause(dwReserved)
      => ComCall(23, this.p, UInt32, dwReserved)
    Resume(dwReserved)
      => ComCall(24, this.p, UInt32, dwReserved)
    SetVoice(pVoice, fAllowFormatChanges)
      => ComCall(25, this.p, ISpVoice, pVoice, BOOL, fAllowFormatChanges)
    GetVoice(ppVoice)
      => ComCall(26, this.p, ISpVoice.Ptr, ppVoice)
    SetVoicePurgeEvent(ullEventInterest)
      => ComCall(27, this.p, Int64, ullEventInterest)
    GetVoicePurgeEvent(pullEventInterest)
      => ComCall(28, this.p, Int64.Ptr, pullEventInterest)
    SetContextState(eContextState)
      => ComCall(29, this.p, SPCONTEXTSTATE, eContextState)
    GetContextState(peContextState)
      => ComCall(30, this.p, SPCONTEXTSTATE.Ptr, peContextState)
}
struct SPGRAMMAROPTIONS extends Int32 {
    static SPGO_SAPI := 1
    static SPGO_SRGS := 2
    static SPGO_UPS := 4
    static SPGO_SRGS_MS_SCRIPT := 8
    static SPGO_SRGS_W3C_SCRIPT := 256
    static SPGO_SRGS_STG_SCRIPT := 512
    static SPGO_SRGS_SCRIPT := 778
    static SPGO_FILE := 16
    static SPGO_HTTP := 32
    static SPGO_RES := 64
    static SPGO_OBJECT := 128
    static SPGO_DEFAULT := 1019
    static SPGO_ALL := 1023
}
struct SPADAPTATIONSETTINGS extends Int32 {
    static SPADS_Default := 0
    static SPADS_CurrentRecognizer := 1
    static SPADS_RecoProfile := 2
    static SPADS_Immediate := 4
    static SPADS_Reset := 8
    static SPADS_HighVolumeDataSource := 16
}
struct SPADAPTATIONRELEVANCE extends Int32 {
    static SPAR_Unknown := 0
    static SPAR_Low := 1
    static SPAR_Medium := 2
    static SPAR_High := 3
}
struct ISpRecoContext2 extends IUnknown {
    static IID := "{BEAD311C-52FF-437F-9464-6B21054CA73D}"
    SetGrammarOptions(eGrammarOptions)
      => ComCall(3, this.p, UInt32, eGrammarOptions)
    GetGrammarOptions(peGrammarOptions)
      => ComCall(4, this.p, UInt32.Ptr, peGrammarOptions)
    SetAdaptationData2(pAdaptationData, cch, pTopicName, eAdaptationSettings, eRelevance)
      => ComCall(5, this.p, "Str", pAdaptationData, UInt32, cch, "Str", pTopicName, UInt32, eAdaptationSettings, SPADAPTATIONRELEVANCE, eRelevance)
}
struct ISpProperties extends IUnknown {
    static IID := "{5B4FB971-B115-4DE1-AD97-E482E3BF6EE4}"
    SetPropertyNum(pName, lValue)
      => ComCall(3, this.p, "Str", pName, Int32, lValue)
    GetPropertyNum(pName, plValue)
      => ComCall(4, this.p, "Str", pName, Int32.Ptr, plValue)
    SetPropertyString(pName, pValue)
      => ComCall(5, this.p, "Str", pName, "Str", pValue)
    GetPropertyString(pName, ppCoMemValue)
      => ComCall(6, this.p, "Str", pName, PWSTR.Ptr, ppCoMemValue)
}
struct SPRECOGNIZERSTATUS {
    AudioStatus : SPAUDIOSTATUS
    ullRecognitionStreamPos : Int64
    ulStreamNumber : UInt32
    ulNumActive : UInt32
    clsidEngine : GUID
    cLangIDs : UInt32
    aLangID : UInt16[20]
    ullRecognitionStreamTime : Int64
}
struct SPSTREAMFORMATTYPE extends Int32 {
    static SPWF_INPUT := 0
    static SPWF_SRENGINE := 1
}
struct SPRECOSTATE extends Int32 {
    static SPRST_INACTIVE := 0
    static SPRST_ACTIVE := 1
    static SPRST_ACTIVE_ALWAYS := 2
    static SPRST_INACTIVE_WITH_PURGE := 3
    static SPRST_NUM_STATES := 4
}
struct ISpRecognizer extends ISpProperties {
    static IID := "{C2B5F241-DAA0-4507-9E16-5A1EAA2B7A5C}"
    SetRecognizer(pRecognizer)
      => ComCall(7, this.p, ISpObjectToken, pRecognizer)
    GetRecognizer(ppRecognizer)
      => ComCall(8, this.p, ISpObjectToken.Ptr, ppRecognizer)
    SetInput(pUnkInput?, fAllowFormatChanges)
      => ComCall(9, this.p, IUnknown, pUnkInput?, BOOL, fAllowFormatChanges)
    GetInputObjectToken(ppToken)
      => ComCall(10, this.p, ISpObjectToken.Ptr, ppToken)
    GetInputStream(ppStream)
      => ComCall(11, this.p, ISpStreamFormat.Ptr, ppStream)
    CreateRecoContext(ppNewCtxt)
      => ComCall(12, this.p, ISpRecoContext.Ptr, ppNewCtxt)
    GetRecoProfile(ppToken)
      => ComCall(13, this.p, ISpObjectToken.Ptr, ppToken)
    SetRecoProfile(pToken)
      => ComCall(14, this.p, ISpObjectToken, pToken)
    IsSharedInstance()
      => ComCall(15, this.p)
    GetRecoState(pState)
      => ComCall(16, this.p, SPRECOSTATE.Ptr, pState)
    SetRecoState(NewState)
      => ComCall(17, this.p, SPRECOSTATE, NewState)
    GetStatus(pStatus)
      => ComCall(18, this.p, SPRECOGNIZERSTATUS.Ptr, pStatus)
    GetFormat(WaveFormatType, pFormatId, ppCoMemWFEX)
      => ComCall(19, this.p, SPSTREAMFORMATTYPE, WaveFormatType, GUID.Ptr, pFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemWFEX)
    IsUISupported(pszTypeOfUI, pvExtraData, cbExtraData, pfSupported)
      => ComCall(20, this.p, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, BOOL.Ptr, pfSupported)
    DisplayUI(hwndParent, pszTitle?, pszTypeOfUI, pvExtraData, cbExtraData)
      => ComCall(21, this.p, HWND, hwndParent, "Str", pszTitle?, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData)
    EmulateRecognition(pPhrase)
      => ComCall(22, this.p, ISpPhrase, pPhrase)
}
struct ISpSerializeState extends IUnknown {
    static IID := "{21B501A0-0EC7-46C9-92C3-A2BC784C54B9}"
    GetSerializedState(ppbData, pulSize, dwReserved)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pulSize, UInt32, dwReserved)
    SetSerializedState(pbData, ulSize, dwReserved)
      => ComCall(4, this.p, UInt8.Ptr, pbData, UInt32, ulSize, UInt32, dwReserved)
}
struct ISpRecognizer2 extends IUnknown {
    static IID := "{8FC6D974-C81E-4098-93C5-0147F61ED4D3}"
    EmulateRecognitionEx(pPhrase, dwCompareFlags)
      => ComCall(3, this.p, ISpPhrase, pPhrase, UInt32, dwCompareFlags)
    SetTrainingState(fDoingTraining, fAdaptFromTrainingData)
      => ComCall(4, this.p, BOOL, fDoingTraining, BOOL, fAdaptFromTrainingData)
    ResetAcousticModelAdaptation()
      => ComCall(5, this.p)
}
struct SPNORMALIZATIONLIST {
    ulSize : UInt32
    ppszzNormalizedList : UInt16.Ptr.Ptr
}
struct ISpEnginePronunciation extends IUnknown {
    static IID := "{C360CE4B-76D1-4214-AD68-52657D5083DA}"
    Normalize(pszWord, pszLeftContext, pszRightContext, LangID, pNormalizationList)
      => ComCall(3, this.p, "Str", pszWord, "Str", pszLeftContext, "Str", pszRightContext, UInt16, LangID, SPNORMALIZATIONLIST.Ptr, pNormalizationList)
    GetPronunciations(pszWord, pszLeftContext, pszRightContext, LangID, pEnginePronunciationList)
      => ComCall(4, this.p, "Str", pszWord, "Str", pszLeftContext, "Str", pszRightContext, UInt16, LangID, SPWORDPRONUNCIATIONLIST.Ptr, pEnginePronunciationList)
}
struct SPDISPLAYTOKEN {
    pszLexical : PWSTR
    pszDisplay : PWSTR
    bDisplayAttributes : UInt8
}
struct SPDISPLAYPHRASE {
    ulNumTokens : UInt32
    pTokens : SPDISPLAYTOKEN.Ptr
}
struct ISpDisplayAlternates extends IUnknown {
    static IID := "{C8D7C7E2-0DDE-44B7-AFE3-B0C991FBEB5E}"
    GetDisplayAlternates(pPhrase, cRequestCount, ppCoMemPhrases, pcPhrasesReturned)
      => ComCall(3, this.p, SPDISPLAYPHRASE.Ptr, pPhrase, UInt32, cRequestCount, SPDISPLAYPHRASE.Ptr.Ptr, ppCoMemPhrases, UInt32.Ptr, pcPhrasesReturned)
    SetFullStopTrailSpace(ulTrailSpace)
      => ComCall(4, this.p, UInt32, ulTrailSpace)
}
struct DISPID_SpeechDataKey extends Int32 {
    static DISPID_SDKSetBinaryValue := 1
    static DISPID_SDKGetBinaryValue := 2
    static DISPID_SDKSetStringValue := 3
    static DISPID_SDKGetStringValue := 4
    static DISPID_SDKSetLongValue := 5
    static DISPID_SDKGetlongValue := 6
    static DISPID_SDKOpenKey := 7
    static DISPID_SDKCreateKey := 8
    static DISPID_SDKDeleteKey := 9
    static DISPID_SDKDeleteValue := 10
    static DISPID_SDKEnumKeys := 11
    static DISPID_SDKEnumValues := 12
}
struct DISPID_SpeechObjectToken extends Int32 {
    static DISPID_SOTId := 1
    static DISPID_SOTDataKey := 2
    static DISPID_SOTCategory := 3
    static DISPID_SOTGetDescription := 4
    static DISPID_SOTSetId := 5
    static DISPID_SOTGetAttribute := 6
    static DISPID_SOTCreateInstance := 7
    static DISPID_SOTRemove := 8
    static DISPID_SOTGetStorageFileName := 9
    static DISPID_SOTRemoveStorageFileName := 10
    static DISPID_SOTIsUISupported := 11
    static DISPID_SOTDisplayUI := 12
    static DISPID_SOTMatchesAttributes := 13
}
struct SpeechDataKeyLocation extends Int32 {
    static SDKLDefaultLocation := 0
    static SDKLCurrentUser := 1
    static SDKLLocalMachine := 2
    static SDKLCurrentConfig := 5
}
struct SpeechTokenContext extends UInt32 {
    static STCInprocServer := 1
    static STCInprocHandler := 2
    static STCLocalServer := 4
    static STCRemoteServer := 16
    static STCAll := 23
}
struct SpeechTokenShellFolder extends Int32 {
    static STSF_AppData := 26
    static STSF_LocalAppData := 28
    static STSF_CommonAppData := 35
    static STSF_FlagCreate := 32768
}
struct DISPID_SpeechObjectTokens extends Int32 {
    static DISPID_SOTsCount := 1
    static DISPID_SOTsItem := 0
    static DISPID_SOTs_NewEnum := -4
}
struct DISPID_SpeechObjectTokenCategory extends Int32 {
    static DISPID_SOTCId := 1
    static DISPID_SOTCDefault := 2
    static DISPID_SOTCSetId := 3
    static DISPID_SOTCGetDataKey := 4
    static DISPID_SOTCEnumerateTokens := 5
}
struct SpeechAudioFormatType extends Int32 {
    static SAFTDefault := -1
    static SAFTNoAssignedFormat := 0
    static SAFTText := 1
    static SAFTNonStandardFormat := 2
    static SAFTExtendedAudioFormat := 3
    static SAFT8kHz8BitMono := 4
    static SAFT8kHz8BitStereo := 5
    static SAFT8kHz16BitMono := 6
    static SAFT8kHz16BitStereo := 7
    static SAFT11kHz8BitMono := 8
    static SAFT11kHz8BitStereo := 9
    static SAFT11kHz16BitMono := 10
    static SAFT11kHz16BitStereo := 11
    static SAFT12kHz8BitMono := 12
    static SAFT12kHz8BitStereo := 13
    static SAFT12kHz16BitMono := 14
    static SAFT12kHz16BitStereo := 15
    static SAFT16kHz8BitMono := 16
    static SAFT16kHz8BitStereo := 17
    static SAFT16kHz16BitMono := 18
    static SAFT16kHz16BitStereo := 19
    static SAFT22kHz8BitMono := 20
    static SAFT22kHz8BitStereo := 21
    static SAFT22kHz16BitMono := 22
    static SAFT22kHz16BitStereo := 23
    static SAFT24kHz8BitMono := 24
    static SAFT24kHz8BitStereo := 25
    static SAFT24kHz16BitMono := 26
    static SAFT24kHz16BitStereo := 27
    static SAFT32kHz8BitMono := 28
    static SAFT32kHz8BitStereo := 29
    static SAFT32kHz16BitMono := 30
    static SAFT32kHz16BitStereo := 31
    static SAFT44kHz8BitMono := 32
    static SAFT44kHz8BitStereo := 33
    static SAFT44kHz16BitMono := 34
    static SAFT44kHz16BitStereo := 35
    static SAFT48kHz8BitMono := 36
    static SAFT48kHz8BitStereo := 37
    static SAFT48kHz16BitMono := 38
    static SAFT48kHz16BitStereo := 39
    static SAFTTrueSpeech_8kHz1BitMono := 40
    static SAFTCCITT_ALaw_8kHzMono := 41
    static SAFTCCITT_ALaw_8kHzStereo := 42
    static SAFTCCITT_ALaw_11kHzMono := 43
    static SAFTCCITT_ALaw_11kHzStereo := 44
    static SAFTCCITT_ALaw_22kHzMono := 45
    static SAFTCCITT_ALaw_22kHzStereo := 46
    static SAFTCCITT_ALaw_44kHzMono := 47
    static SAFTCCITT_ALaw_44kHzStereo := 48
    static SAFTCCITT_uLaw_8kHzMono := 49
    static SAFTCCITT_uLaw_8kHzStereo := 50
    static SAFTCCITT_uLaw_11kHzMono := 51
    static SAFTCCITT_uLaw_11kHzStereo := 52
    static SAFTCCITT_uLaw_22kHzMono := 53
    static SAFTCCITT_uLaw_22kHzStereo := 54
    static SAFTCCITT_uLaw_44kHzMono := 55
    static SAFTCCITT_uLaw_44kHzStereo := 56
    static SAFTADPCM_8kHzMono := 57
    static SAFTADPCM_8kHzStereo := 58
    static SAFTADPCM_11kHzMono := 59
    static SAFTADPCM_11kHzStereo := 60
    static SAFTADPCM_22kHzMono := 61
    static SAFTADPCM_22kHzStereo := 62
    static SAFTADPCM_44kHzMono := 63
    static SAFTADPCM_44kHzStereo := 64
    static SAFTGSM610_8kHzMono := 65
    static SAFTGSM610_11kHzMono := 66
    static SAFTGSM610_22kHzMono := 67
    static SAFTGSM610_44kHzMono := 68
}
struct DISPID_SpeechAudioFormat extends Int32 {
    static DISPID_SAFType := 1
    static DISPID_SAFGuid := 2
    static DISPID_SAFGetWaveFormatEx := 3
    static DISPID_SAFSetWaveFormatEx := 4
}
struct DISPID_SpeechBaseStream extends Int32 {
    static DISPID_SBSFormat := 1
    static DISPID_SBSRead := 2
    static DISPID_SBSWrite := 3
    static DISPID_SBSSeek := 4
}
struct SpeechStreamSeekPositionType extends UInt32 {
    static SSSPTRelativeToStart := 0
    static SSSPTRelativeToCurrentPosition := 1
    static SSSPTRelativeToEnd := 2
}
struct DISPID_SpeechAudio extends Int32 {
    static DISPID_SAStatus := 200
    static DISPID_SABufferInfo := 201
    static DISPID_SADefaultFormat := 202
    static DISPID_SAVolume := 203
    static DISPID_SABufferNotifySize := 204
    static DISPID_SAEventHandle := 205
    static DISPID_SASetState := 206
}
struct SpeechAudioState extends Int32 {
    static SASClosed := 0
    static SASStop := 1
    static SASPause := 2
    static SASRun := 3
}
struct DISPID_SpeechMMSysAudio extends Int32 {
    static DISPID_SMSADeviceId := 300
    static DISPID_SMSALineId := 301
    static DISPID_SMSAMMHandle := 302
}
struct DISPID_SpeechFileStream extends Int32 {
    static DISPID_SFSOpen := 100
    static DISPID_SFSClose := 101
}
struct SpeechStreamFileMode extends Int32 {
    static SSFMOpenForRead := 0
    static SSFMOpenReadWrite := 1
    static SSFMCreate := 2
    static SSFMCreateForWrite := 3
}
struct DISPID_SpeechCustomStream extends Int32 {
    static DISPID_SCSBaseStream := 100
}
struct DISPID_SpeechMemoryStream extends Int32 {
    static DISPID_SMSSetData := 100
    static DISPID_SMSGetData := 101
}
struct DISPID_SpeechAudioStatus extends Int32 {
    static DISPID_SASFreeBufferSpace := 1
    static DISPID_SASNonBlockingIO := 2
    static DISPID_SASState := 3
    static DISPID_SASCurrentSeekPosition := 4
    static DISPID_SASCurrentDevicePosition := 5
}
struct DISPID_SpeechAudioBufferInfo extends Int32 {
    static DISPID_SABIMinNotification := 1
    static DISPID_SABIBufferSize := 2
    static DISPID_SABIEventBias := 3
}
struct DISPID_SpeechWaveFormatEx extends Int32 {
    static DISPID_SWFEFormatTag := 1
    static DISPID_SWFEChannels := 2
    static DISPID_SWFESamplesPerSec := 3
    static DISPID_SWFEAvgBytesPerSec := 4
    static DISPID_SWFEBlockAlign := 5
    static DISPID_SWFEBitsPerSample := 6
    static DISPID_SWFEExtraData := 7
}
struct DISPID_SpeechVoice extends Int32 {
    static DISPID_SVStatus := 1
    static DISPID_SVVoice := 2
    static DISPID_SVAudioOutput := 3
    static DISPID_SVAudioOutputStream := 4
    static DISPID_SVRate := 5
    static DISPID_SVVolume := 6
    static DISPID_SVAllowAudioOuputFormatChangesOnNextSet := 7
    static DISPID_SVEventInterests := 8
    static DISPID_SVPriority := 9
    static DISPID_SVAlertBoundary := 10
    static DISPID_SVSyncronousSpeakTimeout := 11
    static DISPID_SVSpeak := 12
    static DISPID_SVSpeakStream := 13
    static DISPID_SVPause := 14
    static DISPID_SVResume := 15
    static DISPID_SVSkip := 16
    static DISPID_SVGetVoices := 17
    static DISPID_SVGetAudioOutputs := 18
    static DISPID_SVWaitUntilDone := 19
    static DISPID_SVSpeakCompleteEvent := 20
    static DISPID_SVIsUISupported := 21
    static DISPID_SVDisplayUI := 22
}
struct SpeechVoicePriority extends Int32 {
    static SVPNormal := 0
    static SVPAlert := 1
    static SVPOver := 2
}
struct SpeechVoiceSpeakFlags extends Int32 {
    static SVSFDefault := 0
    static SVSFlagsAsync := 1
    static SVSFPurgeBeforeSpeak := 2
    static SVSFIsFilename := 4
    static SVSFIsXML := 8
    static SVSFIsNotXML := 16
    static SVSFPersistXML := 32
    static SVSFNLPSpeakPunc := 64
    static SVSFParseSapi := 128
    static SVSFParseSsml := 256
    static SVSFParseAutodetect := 0
    static SVSFNLPMask := 64
    static SVSFParseMask := 384
    static SVSFVoiceMask := 511
    static SVSFUnusedFlags := -512
}
struct SpeechVoiceEvents extends Int32 {
    static SVEStartInputStream := 2
    static SVEEndInputStream := 4
    static SVEVoiceChange := 8
    static SVEBookmark := 16
    static SVEWordBoundary := 32
    static SVEPhoneme := 64
    static SVESentenceBoundary := 128
    static SVEViseme := 256
    static SVEAudioLevel := 512
    static SVEPrivate := 32768
    static SVEAllEvents := 33790
}
struct DISPID_SpeechVoiceStatus extends Int32 {
    static DISPID_SVSCurrentStreamNumber := 1
    static DISPID_SVSLastStreamNumberQueued := 2
    static DISPID_SVSLastResult := 3
    static DISPID_SVSRunningState := 4
    static DISPID_SVSInputWordPosition := 5
    static DISPID_SVSInputWordLength := 6
    static DISPID_SVSInputSentencePosition := 7
    static DISPID_SVSInputSentenceLength := 8
    static DISPID_SVSLastBookmark := 9
    static DISPID_SVSLastBookmarkId := 10
    static DISPID_SVSPhonemeId := 11
    static DISPID_SVSVisemeId := 12
}
struct SpeechRunState extends Int32 {
    static SRSEDone := 1
    static SRSEIsSpeaking := 2
}
struct SpeechVisemeType extends Int32 {
    static SVP_0 := 0
    static SVP_1 := 1
    static SVP_2 := 2
    static SVP_3 := 3
    static SVP_4 := 4
    static SVP_5 := 5
    static SVP_6 := 6
    static SVP_7 := 7
    static SVP_8 := 8
    static SVP_9 := 9
    static SVP_10 := 10
    static SVP_11 := 11
    static SVP_12 := 12
    static SVP_13 := 13
    static SVP_14 := 14
    static SVP_15 := 15
    static SVP_16 := 16
    static SVP_17 := 17
    static SVP_18 := 18
    static SVP_19 := 19
    static SVP_20 := 20
    static SVP_21 := 21
}
struct SpeechVisemeFeature extends Int32 {
    static SVF_None := 0
    static SVF_Stressed := 1
    static SVF_Emphasis := 2
}
struct DISPID_SpeechVoiceEvent extends Int32 {
    static DISPID_SVEStreamStart := 1
    static DISPID_SVEStreamEnd := 2
    static DISPID_SVEVoiceChange := 3
    static DISPID_SVEBookmark := 4
    static DISPID_SVEWord := 5
    static DISPID_SVEPhoneme := 6
    static DISPID_SVESentenceBoundary := 7
    static DISPID_SVEViseme := 8
    static DISPID_SVEAudioLevel := 9
    static DISPID_SVEEnginePrivate := 10
}
struct DISPID_SpeechRecognizer extends Int32 {
    static DISPID_SRRecognizer := 1
    static DISPID_SRAllowAudioInputFormatChangesOnNextSet := 2
    static DISPID_SRAudioInput := 3
    static DISPID_SRAudioInputStream := 4
    static DISPID_SRIsShared := 5
    static DISPID_SRState := 6
    static DISPID_SRStatus := 7
    static DISPID_SRProfile := 8
    static DISPID_SREmulateRecognition := 9
    static DISPID_SRCreateRecoContext := 10
    static DISPID_SRGetFormat := 11
    static DISPID_SRSetPropertyNumber := 12
    static DISPID_SRGetPropertyNumber := 13
    static DISPID_SRSetPropertyString := 14
    static DISPID_SRGetPropertyString := 15
    static DISPID_SRIsUISupported := 16
    static DISPID_SRDisplayUI := 17
    static DISPID_SRGetRecognizers := 18
    static DISPID_SVGetAudioInputs := 19
    static DISPID_SVGetProfiles := 20
}
struct SpeechRecognizerState extends Int32 {
    static SRSInactive := 0
    static SRSActive := 1
    static SRSActiveAlways := 2
    static SRSInactiveWithPurge := 3
}
struct SpeechDisplayAttributes extends Int32 {
    static SDA_No_Trailing_Space := 0
    static SDA_One_Trailing_Space := 2
    static SDA_Two_Trailing_Spaces := 4
    static SDA_Consume_Leading_Spaces := 8
}
struct SpeechFormatType extends Int32 {
    static SFTInput := 0
    static SFTSREngine := 1
}
struct SpeechEmulationCompareFlags extends Int32 {
    static SECFIgnoreCase := 1
    static SECFIgnoreKanaType := 65536
    static SECFIgnoreWidth := 131072
    static SECFNoSpecialChars := 536870912
    static SECFEmulateResult := 1073741824
    static SECFDefault := 196609
}
struct DISPID_SpeechRecognizerStatus extends Int32 {
    static DISPID_SRSAudioStatus := 1
    static DISPID_SRSCurrentStreamPosition := 2
    static DISPID_SRSCurrentStreamNumber := 3
    static DISPID_SRSNumberOfActiveRules := 4
    static DISPID_SRSClsidEngine := 5
    static DISPID_SRSSupportedLanguages := 6
}
struct DISPID_SpeechRecoContext extends Int32 {
    static DISPID_SRCRecognizer := 1
    static DISPID_SRCAudioInInterferenceStatus := 2
    static DISPID_SRCRequestedUIType := 3
    static DISPID_SRCVoice := 4
    static DISPID_SRAllowVoiceFormatMatchingOnNextSet := 5
    static DISPID_SRCVoicePurgeEvent := 6
    static DISPID_SRCEventInterests := 7
    static DISPID_SRCCmdMaxAlternates := 8
    static DISPID_SRCState := 9
    static DISPID_SRCRetainedAudio := 10
    static DISPID_SRCRetainedAudioFormat := 11
    static DISPID_SRCPause := 12
    static DISPID_SRCResume := 13
    static DISPID_SRCCreateGrammar := 14
    static DISPID_SRCCreateResultFromMemory := 15
    static DISPID_SRCBookmark := 16
    static DISPID_SRCSetAdaptationData := 17
}
struct SpeechRetainedAudioOptions extends Int32 {
    static SRAONone := 0
    static SRAORetainAudio := 1
}
struct SpeechBookmarkOptions extends Int32 {
    static SBONone := 0
    static SBOPause := 1
}
struct SpeechInterference extends Int32 {
    static SINone := 0
    static SINoise := 1
    static SINoSignal := 2
    static SITooLoud := 3
    static SITooQuiet := 4
    static SITooFast := 5
    static SITooSlow := 6
}
struct SpeechRecoEvents extends Int32 {
    static SREStreamEnd := 1
    static SRESoundStart := 2
    static SRESoundEnd := 4
    static SREPhraseStart := 8
    static SRERecognition := 16
    static SREHypothesis := 32
    static SREBookmark := 64
    static SREPropertyNumChange := 128
    static SREPropertyStringChange := 256
    static SREFalseRecognition := 512
    static SREInterference := 1024
    static SRERequestUI := 2048
    static SREStateChange := 4096
    static SREAdaptation := 8192
    static SREStreamStart := 16384
    static SRERecoOtherContext := 32768
    static SREAudioLevel := 65536
    static SREPrivate := 262144
    static SREAllEvents := 393215
}
struct SpeechRecoContextState extends Int32 {
    static SRCS_Disabled := 0
    static SRCS_Enabled := 1
}
struct DISPIDSPRG extends Int32 {
    static DISPID_SRGId := 1
    static DISPID_SRGRecoContext := 2
    static DISPID_SRGState := 3
    static DISPID_SRGRules := 4
    static DISPID_SRGReset := 5
    static DISPID_SRGCommit := 6
    static DISPID_SRGCmdLoadFromFile := 7
    static DISPID_SRGCmdLoadFromObject := 8
    static DISPID_SRGCmdLoadFromResource := 9
    static DISPID_SRGCmdLoadFromMemory := 10
    static DISPID_SRGCmdLoadFromProprietaryGrammar := 11
    static DISPID_SRGCmdSetRuleState := 12
    static DISPID_SRGCmdSetRuleIdState := 13
    static DISPID_SRGDictationLoad := 14
    static DISPID_SRGDictationUnload := 15
    static DISPID_SRGDictationSetState := 16
    static DISPID_SRGSetWordSequenceData := 17
    static DISPID_SRGSetTextSelection := 18
    static DISPID_SRGIsPronounceable := 19
}
struct SpeechLoadOption extends Int32 {
    static SLOStatic := 0
    static SLODynamic := 1
}
struct SpeechWordPronounceable extends Int32 {
    static SWPUnknownWordUnpronounceable := 0
    static SWPUnknownWordPronounceable := 1
    static SWPKnownWordPronounceable := 2
}
struct SpeechGrammarState extends Int32 {
    static SGSEnabled := 1
    static SGSDisabled := 0
    static SGSExclusive := 3
}
struct SpeechRuleState extends Int32 {
    static SGDSInactive := 0
    static SGDSActive := 1
    static SGDSActiveWithAutoPause := 3
    static SGDSActiveUserDelimited := 4
}
struct SpeechRuleAttributes extends Int32 {
    static SRATopLevel := 1
    static SRADefaultToActive := 2
    static SRAExport := 4
    static SRAImport := 8
    static SRAInterpreter := 16
    static SRADynamic := 32
    static SRARoot := 64
}
struct SpeechGrammarWordType extends Int32 {
    static SGDisplay := 0
    static SGLexical := 1
    static SGPronounciation := 2
    static SGLexicalNoSpecialChars := 3
}
struct DISPID_SpeechRecoContextEvents extends Int32 {
    static DISPID_SRCEStartStream := 1
    static DISPID_SRCEEndStream := 2
    static DISPID_SRCEBookmark := 3
    static DISPID_SRCESoundStart := 4
    static DISPID_SRCESoundEnd := 5
    static DISPID_SRCEPhraseStart := 6
    static DISPID_SRCERecognition := 7
    static DISPID_SRCEHypothesis := 8
    static DISPID_SRCEPropertyNumberChange := 9
    static DISPID_SRCEPropertyStringChange := 10
    static DISPID_SRCEFalseRecognition := 11
    static DISPID_SRCEInterference := 12
    static DISPID_SRCERequestUI := 13
    static DISPID_SRCERecognizerStateChange := 14
    static DISPID_SRCEAdaptation := 15
    static DISPID_SRCERecognitionForOtherContext := 16
    static DISPID_SRCEAudioLevel := 17
    static DISPID_SRCEEnginePrivate := 18
}
struct SpeechRecognitionType extends Int32 {
    static SRTStandard := 0
    static SRTAutopause := 1
    static SRTEmulated := 2
    static SRTSMLTimeout := 4
    static SRTExtendableParse := 8
    static SRTReSent := 16
}
struct DISPID_SpeechGrammarRule extends Int32 {
    static DISPID_SGRAttributes := 1
    static DISPID_SGRInitialState := 2
    static DISPID_SGRName := 3
    static DISPID_SGRId := 4
    static DISPID_SGRClear := 5
    static DISPID_SGRAddResource := 6
    static DISPID_SGRAddState := 7
}
struct DISPID_SpeechGrammarRules extends Int32 {
    static DISPID_SGRsCount := 1
    static DISPID_SGRsDynamic := 2
    static DISPID_SGRsAdd := 3
    static DISPID_SGRsCommit := 4
    static DISPID_SGRsCommitAndSave := 5
    static DISPID_SGRsFindRule := 6
    static DISPID_SGRsItem := 0
    static DISPID_SGRs_NewEnum := -4
}
struct DISPID_SpeechGrammarRuleState extends Int32 {
    static DISPID_SGRSRule := 1
    static DISPID_SGRSTransitions := 2
    static DISPID_SGRSAddWordTransition := 3
    static DISPID_SGRSAddRuleTransition := 4
    static DISPID_SGRSAddSpecialTransition := 5
}
struct SpeechSpecialTransitionType extends Int32 {
    static SSTTWildcard := 1
    static SSTTDictation := 2
    static SSTTTextBuffer := 3
}
struct DISPID_SpeechGrammarRuleStateTransitions extends Int32 {
    static DISPID_SGRSTsCount := 1
    static DISPID_SGRSTsItem := 0
    static DISPID_SGRSTs_NewEnum := -4
}
struct DISPID_SpeechGrammarRuleStateTransition extends Int32 {
    static DISPID_SGRSTType := 1
    static DISPID_SGRSTText := 2
    static DISPID_SGRSTRule := 3
    static DISPID_SGRSTWeight := 4
    static DISPID_SGRSTPropertyName := 5
    static DISPID_SGRSTPropertyId := 6
    static DISPID_SGRSTPropertyValue := 7
    static DISPID_SGRSTNextState := 8
}
struct SpeechGrammarRuleStateTransitionType extends Int32 {
    static SGRSTTEpsilon := 0
    static SGRSTTWord := 1
    static SGRSTTRule := 2
    static SGRSTTDictation := 3
    static SGRSTTWildcard := 4
    static SGRSTTTextBuffer := 5
}
struct DISPIDSPTSI extends Int32 {
    static DISPIDSPTSI_ActiveOffset := 1
    static DISPIDSPTSI_ActiveLength := 2
    static DISPIDSPTSI_SelectionOffset := 3
    static DISPIDSPTSI_SelectionLength := 4
}
struct DISPID_SpeechRecoResult extends Int32 {
    static DISPID_SRRRecoContext := 1
    static DISPID_SRRTimes := 2
    static DISPID_SRRAudioFormat := 3
    static DISPID_SRRPhraseInfo := 4
    static DISPID_SRRAlternates := 5
    static DISPID_SRRAudio := 6
    static DISPID_SRRSpeakAudio := 7
    static DISPID_SRRSaveToMemory := 8
    static DISPID_SRRDiscardResultInfo := 9
}
struct SpeechDiscardType extends Int32 {
    static SDTProperty := 1
    static SDTReplacement := 2
    static SDTRule := 4
    static SDTDisplayText := 8
    static SDTLexicalForm := 16
    static SDTPronunciation := 32
    static SDTAudio := 64
    static SDTAlternates := 128
    static SDTAll := 255
}
struct DISPID_SpeechXMLRecoResult extends Int32 {
    static DISPID_SRRGetXMLResult := 10
    static DISPID_SRRGetXMLErrorInfo := 11
}
struct DISPID_SpeechRecoResult2 extends Int32 {
    static DISPID_SRRSetTextFeedback := 12
}
struct DISPID_SpeechPhraseBuilder extends Int32 {
    static DISPID_SPPBRestorePhraseFromMemory := 1
}
struct DISPID_SpeechRecoResultTimes extends Int32 {
    static DISPID_SRRTStreamTime := 1
    static DISPID_SRRTLength := 2
    static DISPID_SRRTTickCount := 3
    static DISPID_SRRTOffsetFromStart := 4
}
struct DISPID_SpeechPhraseAlternate extends Int32 {
    static DISPID_SPARecoResult := 1
    static DISPID_SPAStartElementInResult := 2
    static DISPID_SPANumberOfElementsInResult := 3
    static DISPID_SPAPhraseInfo := 4
    static DISPID_SPACommit := 5
}
struct DISPID_SpeechPhraseAlternates extends Int32 {
    static DISPID_SPAsCount := 1
    static DISPID_SPAsItem := 0
    static DISPID_SPAs_NewEnum := -4
}
struct DISPID_SpeechPhraseInfo extends Int32 {
    static DISPID_SPILanguageId := 1
    static DISPID_SPIGrammarId := 2
    static DISPID_SPIStartTime := 3
    static DISPID_SPIAudioStreamPosition := 4
    static DISPID_SPIAudioSizeBytes := 5
    static DISPID_SPIRetainedSizeBytes := 6
    static DISPID_SPIAudioSizeTime := 7
    static DISPID_SPIRule := 8
    static DISPID_SPIProperties := 9
    static DISPID_SPIElements := 10
    static DISPID_SPIReplacements := 11
    static DISPID_SPIEngineId := 12
    static DISPID_SPIEnginePrivateData := 13
    static DISPID_SPISaveToMemory := 14
    static DISPID_SPIGetText := 15
    static DISPID_SPIGetDisplayAttributes := 16
}
struct DISPID_SpeechPhraseElement extends Int32 {
    static DISPID_SPEAudioTimeOffset := 1
    static DISPID_SPEAudioSizeTime := 2
    static DISPID_SPEAudioStreamOffset := 3
    static DISPID_SPEAudioSizeBytes := 4
    static DISPID_SPERetainedStreamOffset := 5
    static DISPID_SPERetainedSizeBytes := 6
    static DISPID_SPEDisplayText := 7
    static DISPID_SPELexicalForm := 8
    static DISPID_SPEPronunciation := 9
    static DISPID_SPEDisplayAttributes := 10
    static DISPID_SPERequiredConfidence := 11
    static DISPID_SPEActualConfidence := 12
    static DISPID_SPEEngineConfidence := 13
}
struct SpeechEngineConfidence extends Int32 {
    static SECLowConfidence := -1
    static SECNormalConfidence := 0
    static SECHighConfidence := 1
}
struct DISPID_SpeechPhraseElements extends Int32 {
    static DISPID_SPEsCount := 1
    static DISPID_SPEsItem := 0
    static DISPID_SPEs_NewEnum := -4
}
struct DISPID_SpeechPhraseReplacement extends Int32 {
    static DISPID_SPRDisplayAttributes := 1
    static DISPID_SPRText := 2
    static DISPID_SPRFirstElement := 3
    static DISPID_SPRNumberOfElements := 4
}
struct DISPID_SpeechPhraseReplacements extends Int32 {
    static DISPID_SPRsCount := 1
    static DISPID_SPRsItem := 0
    static DISPID_SPRs_NewEnum := -4
}
struct DISPID_SpeechPhraseProperty extends Int32 {
    static DISPID_SPPName := 1
    static DISPID_SPPId := 2
    static DISPID_SPPValue := 3
    static DISPID_SPPFirstElement := 4
    static DISPID_SPPNumberOfElements := 5
    static DISPID_SPPEngineConfidence := 6
    static DISPID_SPPConfidence := 7
    static DISPID_SPPParent := 8
    static DISPID_SPPChildren := 9
}
struct DISPID_SpeechPhraseProperties extends Int32 {
    static DISPID_SPPsCount := 1
    static DISPID_SPPsItem := 0
    static DISPID_SPPs_NewEnum := -4
}
struct DISPID_SpeechPhraseRule extends Int32 {
    static DISPID_SPRuleName := 1
    static DISPID_SPRuleId := 2
    static DISPID_SPRuleFirstElement := 3
    static DISPID_SPRuleNumberOfElements := 4
    static DISPID_SPRuleParent := 5
    static DISPID_SPRuleChildren := 6
    static DISPID_SPRuleConfidence := 7
    static DISPID_SPRuleEngineConfidence := 8
}
struct DISPID_SpeechPhraseRules extends Int32 {
    static DISPID_SPRulesCount := 1
    static DISPID_SPRulesItem := 0
    static DISPID_SPRules_NewEnum := -4
}
struct DISPID_SpeechLexicon extends Int32 {
    static DISPID_SLGenerationId := 1
    static DISPID_SLGetWords := 2
    static DISPID_SLAddPronunciation := 3
    static DISPID_SLAddPronunciationByPhoneIds := 4
    static DISPID_SLRemovePronunciation := 5
    static DISPID_SLRemovePronunciationByPhoneIds := 6
    static DISPID_SLGetPronunciations := 7
    static DISPID_SLGetGenerationChange := 8
}
struct SpeechLexiconType extends Int32 {
    static SLTUser := 1
    static SLTApp := 2
}
struct SpeechPartOfSpeech extends Int32 {
    static SPSNotOverriden := -1
    static SPSUnknown := 0
    static SPSNoun := 4096
    static SPSVerb := 8192
    static SPSModifier := 12288
    static SPSFunction := 16384
    static SPSInterjection := 20480
    static SPSLMA := 28672
    static SPSSuppressWord := 61440
}
struct DISPID_SpeechLexiconWords extends Int32 {
    static DISPID_SLWsCount := 1
    static DISPID_SLWsItem := 0
    static DISPID_SLWs_NewEnum := -4
}
struct SpeechWordType extends Int32 {
    static SWTAdded := 1
    static SWTDeleted := 2
}
struct DISPID_SpeechLexiconWord extends Int32 {
    static DISPID_SLWLangId := 1
    static DISPID_SLWType := 2
    static DISPID_SLWWord := 3
    static DISPID_SLWPronunciations := 4
}
struct DISPID_SpeechLexiconProns extends Int32 {
    static DISPID_SLPsCount := 1
    static DISPID_SLPsItem := 0
    static DISPID_SLPs_NewEnum := -4
}
struct DISPID_SpeechLexiconPronunciation extends Int32 {
    static DISPID_SLPType := 1
    static DISPID_SLPLangId := 2
    static DISPID_SLPPartOfSpeech := 3
    static DISPID_SLPPhoneIds := 4
    static DISPID_SLPSymbolic := 5
}
struct DISPID_SpeechPhoneConverter extends Int32 {
    static DISPID_SPCLangId := 1
    static DISPID_SPCPhoneToId := 2
    static DISPID_SPCIdToPhone := 3
}
struct ISpeechDataKey extends IDispatch {
    static IID := "{CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}"
    SetBinaryValue(ValueName, Value)
      => ComCall(7, this.p, BSTR, ValueName, VARIANT, Value)
    GetBinaryValue(ValueName, Value)
      => ComCall(8, this.p, BSTR, ValueName, VARIANT.Ptr, Value)
    SetStringValue(ValueName, Value)
      => ComCall(9, this.p, BSTR, ValueName, BSTR, Value)
    GetStringValue(ValueName, Value)
      => ComCall(10, this.p, BSTR, ValueName, BSTR.Ptr, Value)
    SetLongValue(ValueName, Value)
      => ComCall(11, this.p, BSTR, ValueName, Int32, Value)
    GetLongValue(ValueName, Value)
      => ComCall(12, this.p, BSTR, ValueName, Int32.Ptr, Value)
    OpenKey(SubKeyName, SubKey)
      => ComCall(13, this.p, BSTR, SubKeyName, ISpeechDataKey.Ptr, SubKey)
    CreateKey(SubKeyName, SubKey)
      => ComCall(14, this.p, BSTR, SubKeyName, ISpeechDataKey.Ptr, SubKey)
    DeleteKey(SubKeyName)
      => ComCall(15, this.p, BSTR, SubKeyName)
    DeleteValue(ValueName)
      => ComCall(16, this.p, BSTR, ValueName)
    EnumKeys(Index, SubKeyName)
      => ComCall(17, this.p, Int32, Index, BSTR.Ptr, SubKeyName)
    EnumValues(Index, ValueName)
      => ComCall(18, this.p, Int32, Index, BSTR.Ptr, ValueName)
}
struct ISpeechObjectToken extends IDispatch {
    static IID := "{C74A3ADC-B727-4500-A84A-B526721C8B8C}"
    get_Id(ObjectId)
      => ComCall(7, this.p, BSTR.Ptr, ObjectId)
    get_DataKey(DataKey)
      => ComCall(8, this.p, ISpeechDataKey.Ptr, DataKey)
    get_Category(Category)
      => ComCall(9, this.p, ISpeechObjectTokenCategory.Ptr, Category)
    GetDescription(Locale, Description)
      => ComCall(10, this.p, Int32, Locale, BSTR.Ptr, Description)
    SetId(Id, CategoryID, CreateIfNotExist)
      => ComCall(11, this.p, BSTR, Id, BSTR, CategoryID, VARIANT_BOOL, CreateIfNotExist)
    GetAttribute(AttributeName, AttributeValue)
      => ComCall(12, this.p, BSTR, AttributeName, BSTR.Ptr, AttributeValue)
    CreateInstance(pUnkOuter?, ClsContext, Object)
      => ComCall(13, this.p, IUnknown, pUnkOuter?, SpeechTokenContext, ClsContext, IUnknown.Ptr, Object)
    Remove(ObjectStorageCLSID)
      => ComCall(14, this.p, BSTR, ObjectStorageCLSID)
    GetStorageFileName(ObjectStorageCLSID, KeyName, FileName, Folder, FilePath)
      => ComCall(15, this.p, BSTR, ObjectStorageCLSID, BSTR, KeyName, BSTR, FileName, SpeechTokenShellFolder, Folder, BSTR.Ptr, FilePath)
    RemoveStorageFileName(ObjectStorageCLSID, KeyName, DeleteFile)
      => ComCall(16, this.p, BSTR, ObjectStorageCLSID, BSTR, KeyName, VARIANT_BOOL, DeleteFile)
    IsUISupported(TypeOfUI, ExtraData, Object?, Supported)
      => ComCall(17, this.p, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData, IUnknown, Object?, VARIANT_BOOL.Ptr, Supported)
    DisplayUI(hWnd, Title, TypeOfUI, ExtraData, Object?)
      => ComCall(18, this.p, Int32, hWnd, BSTR, Title, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData, IUnknown, Object?)
    MatchesAttributes(Attributes, Matches)
      => ComCall(19, this.p, BSTR, Attributes, VARIANT_BOOL.Ptr, Matches)
}
struct ISpeechObjectTokens extends IDispatch {
    static IID := "{9285B776-2E7B-4BC0-B53E-580EB6FA967F}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Token)
      => ComCall(8, this.p, Int32, Index, ISpeechObjectToken.Ptr, Token)
    get__NewEnum(ppEnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, ppEnumVARIANT)
}
struct ISpeechObjectTokenCategory extends IDispatch {
    static IID := "{CA7EAC50-2D01-4145-86D4-5AE7D70F4469}"
    get_Id(Id)
      => ComCall(7, this.p, BSTR.Ptr, Id)
    put_Default(TokenId)
      => ComCall(8, this.p, BSTR, TokenId)
    get_Default(TokenId)
      => ComCall(9, this.p, BSTR.Ptr, TokenId)
    SetId(Id, CreateIfNotExist)
      => ComCall(10, this.p, BSTR, Id, VARIANT_BOOL, CreateIfNotExist)
    GetDataKey(Location, DataKey)
      => ComCall(11, this.p, SpeechDataKeyLocation, Location, ISpeechDataKey.Ptr, DataKey)
    EnumerateTokens(RequiredAttributes, OptionalAttributes, Tokens)
      => ComCall(12, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, Tokens)
}
struct ISpeechAudioBufferInfo extends IDispatch {
    static IID := "{11B103D8-1142-4EDF-A093-82FB3915F8CC}"
    get_MinNotification(MinNotification)
      => ComCall(7, this.p, Int32.Ptr, MinNotification)
    put_MinNotification(MinNotification)
      => ComCall(8, this.p, Int32, MinNotification)
    get_BufferSize(BufferSize)
      => ComCall(9, this.p, Int32.Ptr, BufferSize)
    put_BufferSize(BufferSize)
      => ComCall(10, this.p, Int32, BufferSize)
    get_EventBias(EventBias)
      => ComCall(11, this.p, Int32.Ptr, EventBias)
    put_EventBias(EventBias)
      => ComCall(12, this.p, Int32, EventBias)
}
struct ISpeechAudioStatus extends IDispatch {
    static IID := "{C62D9C91-7458-47F6-862D-1EF86FB0B278}"
    get_FreeBufferSpace(FreeBufferSpace)
      => ComCall(7, this.p, Int32.Ptr, FreeBufferSpace)
    get_NonBlockingIO(NonBlockingIO)
      => ComCall(8, this.p, Int32.Ptr, NonBlockingIO)
    get_State(State)
      => ComCall(9, this.p, SpeechAudioState.Ptr, State)
    get_CurrentSeekPosition(CurrentSeekPosition)
      => ComCall(10, this.p, VARIANT.Ptr, CurrentSeekPosition)
    get_CurrentDevicePosition(CurrentDevicePosition)
      => ComCall(11, this.p, VARIANT.Ptr, CurrentDevicePosition)
}
struct ISpeechAudioFormat extends IDispatch {
    static IID := "{E6E9C590-3E18-40E3-8299-061F98BDE7C7}"
    get_Type(AudioFormat)
      => ComCall(7, this.p, SpeechAudioFormatType.Ptr, AudioFormat)
    put_Type(AudioFormat)
      => ComCall(8, this.p, SpeechAudioFormatType, AudioFormat)
    get_Guid(Guid)
      => ComCall(9, this.p, BSTR.Ptr, Guid)
    put_Guid(Guid)
      => ComCall(10, this.p, BSTR, Guid)
    GetWaveFormatEx(SpeechWaveFormatEx)
      => ComCall(11, this.p, ISpeechWaveFormatEx.Ptr, SpeechWaveFormatEx)
    SetWaveFormatEx(SpeechWaveFormatEx?)
      => ComCall(12, this.p, ISpeechWaveFormatEx, SpeechWaveFormatEx?)
}
struct ISpeechWaveFormatEx extends IDispatch {
    static IID := "{7A1EF0D5-1581-4741-88E4-209A49F11A10}"
    get_FormatTag(FormatTag)
      => ComCall(7, this.p, Int16.Ptr, FormatTag)
    put_FormatTag(FormatTag)
      => ComCall(8, this.p, Int16, FormatTag)
    get_Channels(Channels)
      => ComCall(9, this.p, Int16.Ptr, Channels)
    put_Channels(Channels)
      => ComCall(10, this.p, Int16, Channels)
    get_SamplesPerSec(SamplesPerSec)
      => ComCall(11, this.p, Int32.Ptr, SamplesPerSec)
    put_SamplesPerSec(SamplesPerSec)
      => ComCall(12, this.p, Int32, SamplesPerSec)
    get_AvgBytesPerSec(AvgBytesPerSec)
      => ComCall(13, this.p, Int32.Ptr, AvgBytesPerSec)
    put_AvgBytesPerSec(AvgBytesPerSec)
      => ComCall(14, this.p, Int32, AvgBytesPerSec)
    get_BlockAlign(BlockAlign)
      => ComCall(15, this.p, Int16.Ptr, BlockAlign)
    put_BlockAlign(BlockAlign)
      => ComCall(16, this.p, Int16, BlockAlign)
    get_BitsPerSample(BitsPerSample)
      => ComCall(17, this.p, Int16.Ptr, BitsPerSample)
    put_BitsPerSample(BitsPerSample)
      => ComCall(18, this.p, Int16, BitsPerSample)
    get_ExtraData(ExtraData)
      => ComCall(19, this.p, VARIANT.Ptr, ExtraData)
    put_ExtraData(ExtraData)
      => ComCall(20, this.p, VARIANT, ExtraData)
}
struct ISpeechBaseStream extends IDispatch {
    static IID := "{6450336F-7D49-4CED-8097-49D6DEE37294}"
    get_Format(AudioFormat)
      => ComCall(7, this.p, ISpeechAudioFormat.Ptr, AudioFormat)
    putref_Format(AudioFormat?)
      => ComCall(8, this.p, ISpeechAudioFormat, AudioFormat?)
    Read(Buffer, NumberOfBytes, BytesRead)
      => ComCall(9, this.p, VARIANT.Ptr, Buffer, Int32, NumberOfBytes, Int32.Ptr, BytesRead)
    Write(Buffer, BytesWritten)
      => ComCall(10, this.p, VARIANT, Buffer, Int32.Ptr, BytesWritten)
    Seek(Position, Origin, NewPosition)
      => ComCall(11, this.p, VARIANT, Position, SpeechStreamSeekPositionType, Origin, VARIANT.Ptr, NewPosition)
}
struct ISpeechFileStream extends ISpeechBaseStream {
    static IID := "{AF67F125-AB39-4E93-B4A2-CC2E66E182A7}"
    Open(FileName, FileMode, DoEvents)
      => ComCall(12, this.p, BSTR, FileName, SpeechStreamFileMode, FileMode, VARIANT_BOOL, DoEvents)
    Close()
      => ComCall(13, this.p)
}
struct ISpeechMemoryStream extends ISpeechBaseStream {
    static IID := "{EEB14B68-808B-4ABE-A5EA-B51DA7588008}"
    SetData(Data)
      => ComCall(12, this.p, VARIANT, Data)
    GetData(pData)
      => ComCall(13, this.p, VARIANT.Ptr, pData)
}
struct ISpeechCustomStream extends ISpeechBaseStream {
    static IID := "{1A9E9F4F-104F-4DB8-A115-EFD7FD0C97AE}"
    get_BaseStream(ppUnkStream)
      => ComCall(12, this.p, IUnknown.Ptr, ppUnkStream)
    putref_BaseStream(pUnkStream?)
      => ComCall(13, this.p, IUnknown, pUnkStream?)
}
struct ISpeechAudio extends ISpeechBaseStream {
    static IID := "{CFF8E175-019E-11D3-A08E-00C04F8EF9B5}"
    get_Status(Status)
      => ComCall(12, this.p, ISpeechAudioStatus.Ptr, Status)
    get_BufferInfo(BufferInfo)
      => ComCall(13, this.p, ISpeechAudioBufferInfo.Ptr, BufferInfo)
    get_DefaultFormat(StreamFormat)
      => ComCall(14, this.p, ISpeechAudioFormat.Ptr, StreamFormat)
    get_Volume(Volume)
      => ComCall(15, this.p, Int32.Ptr, Volume)
    put_Volume(Volume)
      => ComCall(16, this.p, Int32, Volume)
    get_BufferNotifySize(BufferNotifySize)
      => ComCall(17, this.p, Int32.Ptr, BufferNotifySize)
    put_BufferNotifySize(BufferNotifySize)
      => ComCall(18, this.p, Int32, BufferNotifySize)
    get_EventHandle(EventHandle)
      => ComCall(19, this.p, Int32.Ptr, EventHandle)
    SetState(State)
      => ComCall(20, this.p, SpeechAudioState, State)
}
struct ISpeechMMSysAudio extends ISpeechAudio {
    static IID := "{3C76AF6D-1FD7-4831-81D1-3B71D5A13C44}"
    get_DeviceId(DeviceId)
      => ComCall(21, this.p, Int32.Ptr, DeviceId)
    put_DeviceId(DeviceId)
      => ComCall(22, this.p, Int32, DeviceId)
    get_LineId(LineId)
      => ComCall(23, this.p, Int32.Ptr, LineId)
    put_LineId(LineId)
      => ComCall(24, this.p, Int32, LineId)
    get_MMHandle(Handle)
      => ComCall(25, this.p, Int32.Ptr, Handle)
}
struct ISpeechVoice extends IDispatch {
    static IID := "{269316D8-57BD-11D2-9EEE-00C04F797396}"
    get_Status(Status)
      => ComCall(7, this.p, ISpeechVoiceStatus.Ptr, Status)
    get_Voice(Voice)
      => ComCall(8, this.p, ISpeechObjectToken.Ptr, Voice)
    putref_Voice(Voice?)
      => ComCall(9, this.p, ISpeechObjectToken, Voice?)
    get_AudioOutput(AudioOutput)
      => ComCall(10, this.p, ISpeechObjectToken.Ptr, AudioOutput)
    putref_AudioOutput(AudioOutput?)
      => ComCall(11, this.p, ISpeechObjectToken, AudioOutput?)
    get_AudioOutputStream(AudioOutputStream)
      => ComCall(12, this.p, ISpeechBaseStream.Ptr, AudioOutputStream)
    putref_AudioOutputStream(AudioOutputStream?)
      => ComCall(13, this.p, ISpeechBaseStream, AudioOutputStream?)
    get_Rate(Rate)
      => ComCall(14, this.p, Int32.Ptr, Rate)
    put_Rate(Rate)
      => ComCall(15, this.p, Int32, Rate)
    get_Volume(Volume)
      => ComCall(16, this.p, Int32.Ptr, Volume)
    put_Volume(Volume)
      => ComCall(17, this.p, Int32, Volume)
    put_AllowAudioOutputFormatChangesOnNextSet(Allow)
      => ComCall(18, this.p, VARIANT_BOOL, Allow)
    get_AllowAudioOutputFormatChangesOnNextSet(Allow)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, Allow)
    get_EventInterests(EventInterestFlags)
      => ComCall(20, this.p, SpeechVoiceEvents.Ptr, EventInterestFlags)
    put_EventInterests(EventInterestFlags)
      => ComCall(21, this.p, SpeechVoiceEvents, EventInterestFlags)
    put_Priority(Priority)
      => ComCall(22, this.p, SpeechVoicePriority, Priority)
    get_Priority(Priority)
      => ComCall(23, this.p, SpeechVoicePriority.Ptr, Priority)
    put_AlertBoundary(Boundary)
      => ComCall(24, this.p, SpeechVoiceEvents, Boundary)
    get_AlertBoundary(Boundary)
      => ComCall(25, this.p, SpeechVoiceEvents.Ptr, Boundary)
    put_SynchronousSpeakTimeout(msTimeout)
      => ComCall(26, this.p, Int32, msTimeout)
    get_SynchronousSpeakTimeout(msTimeout)
      => ComCall(27, this.p, Int32.Ptr, msTimeout)
    Speak(Text, Flags, StreamNumber)
      => ComCall(28, this.p, BSTR, Text, SpeechVoiceSpeakFlags, Flags, Int32.Ptr, StreamNumber)
    SpeakStream(Stream?, Flags, StreamNumber)
      => ComCall(29, this.p, ISpeechBaseStream, Stream?, SpeechVoiceSpeakFlags, Flags, Int32.Ptr, StreamNumber)
    Pause()
      => ComCall(30, this.p)
    Resume()
      => ComCall(31, this.p)
    Skip(Type, NumItems, NumSkipped)
      => ComCall(32, this.p, BSTR, Type, Int32, NumItems, Int32.Ptr, NumSkipped)
    GetVoices(RequiredAttributes, OptionalAttributes, ObjectTokens)
      => ComCall(33, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, ObjectTokens)
    GetAudioOutputs(RequiredAttributes, OptionalAttributes, ObjectTokens)
      => ComCall(34, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, ObjectTokens)
    WaitUntilDone(msTimeout, Done)
      => ComCall(35, this.p, Int32, msTimeout, VARIANT_BOOL.Ptr, Done)
    SpeakCompleteEvent(Handle)
      => ComCall(36, this.p, Int32.Ptr, Handle)
    IsUISupported(TypeOfUI, ExtraData, Supported)
      => ComCall(37, this.p, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData, VARIANT_BOOL.Ptr, Supported)
    DisplayUI(hWndParent, Title, TypeOfUI, ExtraData)
      => ComCall(38, this.p, Int32, hWndParent, BSTR, Title, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData)
}
struct ISpeechVoiceStatus extends IDispatch {
    static IID := "{8BE47B07-57F6-11D2-9EEE-00C04F797396}"
    get_CurrentStreamNumber(StreamNumber)
      => ComCall(7, this.p, Int32.Ptr, StreamNumber)
    get_LastStreamNumberQueued(StreamNumber)
      => ComCall(8, this.p, Int32.Ptr, StreamNumber)
    get_LastHResult(HResult)
      => ComCall(9, this.p, Int32.Ptr, HResult)
    get_RunningState(State)
      => ComCall(10, this.p, SpeechRunState.Ptr, State)
    get_InputWordPosition(Position)
      => ComCall(11, this.p, Int32.Ptr, Position)
    get_InputWordLength(Length)
      => ComCall(12, this.p, Int32.Ptr, Length)
    get_InputSentencePosition(Position)
      => ComCall(13, this.p, Int32.Ptr, Position)
    get_InputSentenceLength(Length)
      => ComCall(14, this.p, Int32.Ptr, Length)
    get_LastBookmark(Bookmark)
      => ComCall(15, this.p, BSTR.Ptr, Bookmark)
    get_LastBookmarkId(BookmarkId)
      => ComCall(16, this.p, Int32.Ptr, BookmarkId)
    get_PhonemeId(PhoneId)
      => ComCall(17, this.p, Int16.Ptr, PhoneId)
    get_VisemeId(VisemeId)
      => ComCall(18, this.p, Int16.Ptr, VisemeId)
}
struct ISpeechVoiceEvents extends IDispatch {
    static IID := "{A372ACD1-3BEF-4BBD-8FFB-CB3E2B416AF8}"
}
struct ISpeechRecognizer extends IDispatch {
    static IID := "{2D5F1C0C-BD75-4B08-9478-3B11FEA2586C}"
    putref_Recognizer(Recognizer?)
      => ComCall(7, this.p, ISpeechObjectToken, Recognizer?)
    get_Recognizer(Recognizer)
      => ComCall(8, this.p, ISpeechObjectToken.Ptr, Recognizer)
    put_AllowAudioInputFormatChangesOnNextSet(Allow)
      => ComCall(9, this.p, VARIANT_BOOL, Allow)
    get_AllowAudioInputFormatChangesOnNextSet(Allow)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, Allow)
    putref_AudioInput(AudioInput?)
      => ComCall(11, this.p, ISpeechObjectToken, AudioInput?)
    get_AudioInput(AudioInput)
      => ComCall(12, this.p, ISpeechObjectToken.Ptr, AudioInput)
    putref_AudioInputStream(AudioInputStream?)
      => ComCall(13, this.p, ISpeechBaseStream, AudioInputStream?)
    get_AudioInputStream(AudioInputStream)
      => ComCall(14, this.p, ISpeechBaseStream.Ptr, AudioInputStream)
    get_IsShared(Shared)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, Shared)
    put_State(State)
      => ComCall(16, this.p, SpeechRecognizerState, State)
    get_State(State)
      => ComCall(17, this.p, SpeechRecognizerState.Ptr, State)
    get_Status(Status)
      => ComCall(18, this.p, ISpeechRecognizerStatus.Ptr, Status)
    putref_Profile(Profile?)
      => ComCall(19, this.p, ISpeechObjectToken, Profile?)
    get_Profile(Profile)
      => ComCall(20, this.p, ISpeechObjectToken.Ptr, Profile)
    EmulateRecognition(TextElements, ElementDisplayAttributes, LanguageId)
      => ComCall(21, this.p, VARIANT, TextElements, VARIANT.Ptr, ElementDisplayAttributes, Int32, LanguageId)
    CreateRecoContext(NewContext)
      => ComCall(22, this.p, ISpeechRecoContext.Ptr, NewContext)
    GetFormat(Type, Format)
      => ComCall(23, this.p, SpeechFormatType, Type, ISpeechAudioFormat.Ptr, Format)
    SetPropertyNumber(Name, Value, Supported)
      => ComCall(24, this.p, BSTR, Name, Int32, Value, VARIANT_BOOL.Ptr, Supported)
    GetPropertyNumber(Name, Value, Supported)
      => ComCall(25, this.p, BSTR, Name, Int32.Ptr, Value, VARIANT_BOOL.Ptr, Supported)
    SetPropertyString(Name, Value, Supported)
      => ComCall(26, this.p, BSTR, Name, BSTR, Value, VARIANT_BOOL.Ptr, Supported)
    GetPropertyString(Name, Value, Supported)
      => ComCall(27, this.p, BSTR, Name, BSTR.Ptr, Value, VARIANT_BOOL.Ptr, Supported)
    IsUISupported(TypeOfUI, ExtraData, Supported)
      => ComCall(28, this.p, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData, VARIANT_BOOL.Ptr, Supported)
    DisplayUI(hWndParent, Title, TypeOfUI, ExtraData)
      => ComCall(29, this.p, Int32, hWndParent, BSTR, Title, BSTR, TypeOfUI, VARIANT.Ptr, ExtraData)
    GetRecognizers(RequiredAttributes, OptionalAttributes, ObjectTokens)
      => ComCall(30, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, ObjectTokens)
    GetAudioInputs(RequiredAttributes, OptionalAttributes, ObjectTokens)
      => ComCall(31, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, ObjectTokens)
    GetProfiles(RequiredAttributes, OptionalAttributes, ObjectTokens)
      => ComCall(32, this.p, BSTR, RequiredAttributes, BSTR, OptionalAttributes, ISpeechObjectTokens.Ptr, ObjectTokens)
}
struct ISpeechRecognizerStatus extends IDispatch {
    static IID := "{BFF9E781-53EC-484E-BB8A-0E1B5551E35C}"
    get_AudioStatus(AudioStatus)
      => ComCall(7, this.p, ISpeechAudioStatus.Ptr, AudioStatus)
    get_CurrentStreamPosition(pCurrentStreamPos)
      => ComCall(8, this.p, VARIANT.Ptr, pCurrentStreamPos)
    get_CurrentStreamNumber(StreamNumber)
      => ComCall(9, this.p, Int32.Ptr, StreamNumber)
    get_NumberOfActiveRules(NumberOfActiveRules)
      => ComCall(10, this.p, Int32.Ptr, NumberOfActiveRules)
    get_ClsidEngine(ClsidEngine)
      => ComCall(11, this.p, BSTR.Ptr, ClsidEngine)
    get_SupportedLanguages(SupportedLanguages)
      => ComCall(12, this.p, VARIANT.Ptr, SupportedLanguages)
}
struct ISpeechRecoContext extends IDispatch {
    static IID := "{580AA49D-7E1E-4809-B8E2-57DA806104B8}"
    get_Recognizer(Recognizer)
      => ComCall(7, this.p, ISpeechRecognizer.Ptr, Recognizer)
    get_AudioInputInterferenceStatus(Interference)
      => ComCall(8, this.p, SpeechInterference.Ptr, Interference)
    get_RequestedUIType(UIType)
      => ComCall(9, this.p, BSTR.Ptr, UIType)
    putref_Voice(Voice?)
      => ComCall(10, this.p, ISpeechVoice, Voice?)
    get_Voice(Voice)
      => ComCall(11, this.p, ISpeechVoice.Ptr, Voice)
    put_AllowVoiceFormatMatchingOnNextSet(Allow)
      => ComCall(12, this.p, VARIANT_BOOL, Allow)
    get_AllowVoiceFormatMatchingOnNextSet(pAllow)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pAllow)
    put_VoicePurgeEvent(EventInterest)
      => ComCall(14, this.p, SpeechRecoEvents, EventInterest)
    get_VoicePurgeEvent(EventInterest)
      => ComCall(15, this.p, SpeechRecoEvents.Ptr, EventInterest)
    put_EventInterests(EventInterest)
      => ComCall(16, this.p, SpeechRecoEvents, EventInterest)
    get_EventInterests(EventInterest)
      => ComCall(17, this.p, SpeechRecoEvents.Ptr, EventInterest)
    put_CmdMaxAlternates(MaxAlternates)
      => ComCall(18, this.p, Int32, MaxAlternates)
    get_CmdMaxAlternates(MaxAlternates)
      => ComCall(19, this.p, Int32.Ptr, MaxAlternates)
    put_State(State)
      => ComCall(20, this.p, SpeechRecoContextState, State)
    get_State(State)
      => ComCall(21, this.p, SpeechRecoContextState.Ptr, State)
    put_RetainedAudio(Option)
      => ComCall(22, this.p, SpeechRetainedAudioOptions, Option)
    get_RetainedAudio(Option)
      => ComCall(23, this.p, SpeechRetainedAudioOptions.Ptr, Option)
    putref_RetainedAudioFormat(Format?)
      => ComCall(24, this.p, ISpeechAudioFormat, Format?)
    get_RetainedAudioFormat(Format)
      => ComCall(25, this.p, ISpeechAudioFormat.Ptr, Format)
    Pause()
      => ComCall(26, this.p)
    Resume()
      => ComCall(27, this.p)
    CreateGrammar(GrammarId, Grammar)
      => ComCall(28, this.p, VARIANT, GrammarId, ISpeechRecoGrammar.Ptr, Grammar)
    CreateResultFromMemory(ResultBlock, Result)
      => ComCall(29, this.p, VARIANT.Ptr, ResultBlock, ISpeechRecoResult.Ptr, Result)
    Bookmark(Options, StreamPos, BookmarkId)
      => ComCall(30, this.p, SpeechBookmarkOptions, Options, VARIANT, StreamPos, VARIANT, BookmarkId)
    SetAdaptationData(AdaptationString)
      => ComCall(31, this.p, BSTR, AdaptationString)
}
struct ISpeechRecoGrammar extends IDispatch {
    static IID := "{B6D6F79F-2158-4E50-B5BC-9A9CCD852A09}"
    get_Id(Id)
      => ComCall(7, this.p, VARIANT.Ptr, Id)
    get_RecoContext(RecoContext)
      => ComCall(8, this.p, ISpeechRecoContext.Ptr, RecoContext)
    put_State(State)
      => ComCall(9, this.p, SpeechGrammarState, State)
    get_State(State)
      => ComCall(10, this.p, SpeechGrammarState.Ptr, State)
    get_Rules(Rules)
      => ComCall(11, this.p, ISpeechGrammarRules.Ptr, Rules)
    Reset(NewLanguage)
      => ComCall(12, this.p, Int32, NewLanguage)
    CmdLoadFromFile(FileName, LoadOption)
      => ComCall(13, this.p, BSTR, FileName, SpeechLoadOption, LoadOption)
    CmdLoadFromObject(ClassId, GrammarName, LoadOption)
      => ComCall(14, this.p, BSTR, ClassId, BSTR, GrammarName, SpeechLoadOption, LoadOption)
    CmdLoadFromResource(hModule, ResourceName, ResourceType, LanguageId, LoadOption)
      => ComCall(15, this.p, Int32, hModule, VARIANT, ResourceName, VARIANT, ResourceType, Int32, LanguageId, SpeechLoadOption, LoadOption)
    CmdLoadFromMemory(GrammarData, LoadOption)
      => ComCall(16, this.p, VARIANT, GrammarData, SpeechLoadOption, LoadOption)
    CmdLoadFromProprietaryGrammar(ProprietaryGuid, ProprietaryString, ProprietaryData, LoadOption)
      => ComCall(17, this.p, BSTR, ProprietaryGuid, BSTR, ProprietaryString, VARIANT, ProprietaryData, SpeechLoadOption, LoadOption)
    CmdSetRuleState(Name, State)
      => ComCall(18, this.p, BSTR, Name, SpeechRuleState, State)
    CmdSetRuleIdState(RuleId, State)
      => ComCall(19, this.p, Int32, RuleId, SpeechRuleState, State)
    DictationLoad(TopicName, LoadOption)
      => ComCall(20, this.p, BSTR, TopicName, SpeechLoadOption, LoadOption)
    DictationUnload()
      => ComCall(21, this.p)
    DictationSetState(State)
      => ComCall(22, this.p, SpeechRuleState, State)
    SetWordSequenceData(Text, TextLength, Info?)
      => ComCall(23, this.p, BSTR, Text, Int32, TextLength, ISpeechTextSelectionInformation, Info?)
    SetTextSelection(Info?)
      => ComCall(24, this.p, ISpeechTextSelectionInformation, Info?)
    IsPronounceable(Word, WordPronounceable)
      => ComCall(25, this.p, BSTR, Word, SpeechWordPronounceable.Ptr, WordPronounceable)
}
struct ISpeechRecoContextEvents extends IDispatch {
    static IID := "{7B8FCB42-0E9D-4F00-A048-7B04D6179D3D}"
}
struct ISpeechGrammarRule extends IDispatch {
    static IID := "{AFE719CF-5DD1-44F2-999C-7A399F1CFCCC}"
    get_Attributes(Attributes)
      => ComCall(7, this.p, SpeechRuleAttributes.Ptr, Attributes)
    get_InitialState(State)
      => ComCall(8, this.p, ISpeechGrammarRuleState.Ptr, State)
    get_Name(Name)
      => ComCall(9, this.p, BSTR.Ptr, Name)
    get_Id(Id)
      => ComCall(10, this.p, Int32.Ptr, Id)
    Clear()
      => ComCall(11, this.p)
    AddResource(ResourceName, ResourceValue)
      => ComCall(12, this.p, BSTR, ResourceName, BSTR, ResourceValue)
    AddState(State)
      => ComCall(13, this.p, ISpeechGrammarRuleState.Ptr, State)
}
struct ISpeechGrammarRules extends IDispatch {
    static IID := "{6FFA3B44-FC2D-40D1-8AFC-32911C7F1AD1}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    FindRule(RuleNameOrId, Rule)
      => ComCall(8, this.p, VARIANT, RuleNameOrId, ISpeechGrammarRule.Ptr, Rule)
    Item(Index, Rule)
      => ComCall(9, this.p, Int32, Index, ISpeechGrammarRule.Ptr, Rule)
    get__NewEnum(EnumVARIANT)
      => ComCall(10, this.p, IUnknown.Ptr, EnumVARIANT)
    get_Dynamic(Dynamic)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, Dynamic)
    Add(RuleName, Attributes, RuleId, Rule)
      => ComCall(12, this.p, BSTR, RuleName, SpeechRuleAttributes, Attributes, Int32, RuleId, ISpeechGrammarRule.Ptr, Rule)
    Commit()
      => ComCall(13, this.p)
    CommitAndSave(ErrorText, SaveStream)
      => ComCall(14, this.p, BSTR.Ptr, ErrorText, VARIANT.Ptr, SaveStream)
}
struct ISpeechGrammarRuleState extends IDispatch {
    static IID := "{D4286F2C-EE67-45AE-B928-28D695362EDA}"
    get_Rule(Rule)
      => ComCall(7, this.p, ISpeechGrammarRule.Ptr, Rule)
    get_Transitions(Transitions)
      => ComCall(8, this.p, ISpeechGrammarRuleStateTransitions.Ptr, Transitions)
    AddWordTransition(DestState?, Words, Separators, Type, PropertyName, PropertyId, PropertyValue, Weight)
      => ComCall(9, this.p, ISpeechGrammarRuleState, DestState?, BSTR, Words, BSTR, Separators, SpeechGrammarWordType, Type, BSTR, PropertyName, Int32, PropertyId, VARIANT.Ptr, PropertyValue, Float32, Weight)
    AddRuleTransition(DestinationState?, Rule?, PropertyName, PropertyId, PropertyValue, Weight)
      => ComCall(10, this.p, ISpeechGrammarRuleState, DestinationState?, ISpeechGrammarRule, Rule?, BSTR, PropertyName, Int32, PropertyId, VARIANT.Ptr, PropertyValue, Float32, Weight)
    AddSpecialTransition(DestinationState?, Type, PropertyName, PropertyId, PropertyValue, Weight)
      => ComCall(11, this.p, ISpeechGrammarRuleState, DestinationState?, SpeechSpecialTransitionType, Type, BSTR, PropertyName, Int32, PropertyId, VARIANT.Ptr, PropertyValue, Float32, Weight)
}
struct ISpeechGrammarRuleStateTransition extends IDispatch {
    static IID := "{CAFD1DB1-41D1-4A06-9863-E2E81DA17A9A}"
    get_Type(Type)
      => ComCall(7, this.p, SpeechGrammarRuleStateTransitionType.Ptr, Type)
    get_Text(Text)
      => ComCall(8, this.p, BSTR.Ptr, Text)
    get_Rule(Rule)
      => ComCall(9, this.p, ISpeechGrammarRule.Ptr, Rule)
    get_Weight(Weight)
      => ComCall(10, this.p, VARIANT.Ptr, Weight)
    get_PropertyName(PropertyName)
      => ComCall(11, this.p, BSTR.Ptr, PropertyName)
    get_PropertyId(PropertyId)
      => ComCall(12, this.p, Int32.Ptr, PropertyId)
    get_PropertyValue(PropertyValue)
      => ComCall(13, this.p, VARIANT.Ptr, PropertyValue)
    get_NextState(NextState)
      => ComCall(14, this.p, ISpeechGrammarRuleState.Ptr, NextState)
}
struct ISpeechGrammarRuleStateTransitions extends IDispatch {
    static IID := "{EABCE657-75BC-44A2-AA7F-C56476742963}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Transition)
      => ComCall(8, this.p, Int32, Index, ISpeechGrammarRuleStateTransition.Ptr, Transition)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechTextSelectionInformation extends IDispatch {
    static IID := "{3B9C7E7A-6EEE-4DED-9092-11657279ADBE}"
    put_ActiveOffset(ActiveOffset)
      => ComCall(7, this.p, Int32, ActiveOffset)
    get_ActiveOffset(ActiveOffset)
      => ComCall(8, this.p, Int32.Ptr, ActiveOffset)
    put_ActiveLength(ActiveLength)
      => ComCall(9, this.p, Int32, ActiveLength)
    get_ActiveLength(ActiveLength)
      => ComCall(10, this.p, Int32.Ptr, ActiveLength)
    put_SelectionOffset(SelectionOffset)
      => ComCall(11, this.p, Int32, SelectionOffset)
    get_SelectionOffset(SelectionOffset)
      => ComCall(12, this.p, Int32.Ptr, SelectionOffset)
    put_SelectionLength(SelectionLength)
      => ComCall(13, this.p, Int32, SelectionLength)
    get_SelectionLength(SelectionLength)
      => ComCall(14, this.p, Int32.Ptr, SelectionLength)
}
struct ISpeechRecoResult extends IDispatch {
    static IID := "{ED2879CF-CED9-4EE6-A534-DE0191D5468D}"
    get_RecoContext(RecoContext)
      => ComCall(7, this.p, ISpeechRecoContext.Ptr, RecoContext)
    get_Times(Times)
      => ComCall(8, this.p, ISpeechRecoResultTimes.Ptr, Times)
    putref_AudioFormat(Format?)
      => ComCall(9, this.p, ISpeechAudioFormat, Format?)
    get_AudioFormat(Format)
      => ComCall(10, this.p, ISpeechAudioFormat.Ptr, Format)
    get_PhraseInfo(PhraseInfo)
      => ComCall(11, this.p, ISpeechPhraseInfo.Ptr, PhraseInfo)
    Alternates(RequestCount, StartElement, Elements, Alternates)
      => ComCall(12, this.p, Int32, RequestCount, Int32, StartElement, Int32, Elements, ISpeechPhraseAlternates.Ptr, Alternates)
    Audio(StartElement, Elements, Stream)
      => ComCall(13, this.p, Int32, StartElement, Int32, Elements, ISpeechMemoryStream.Ptr, Stream)
    SpeakAudio(StartElement, Elements, Flags, StreamNumber)
      => ComCall(14, this.p, Int32, StartElement, Int32, Elements, SpeechVoiceSpeakFlags, Flags, Int32.Ptr, StreamNumber)
    SaveToMemory(ResultBlock)
      => ComCall(15, this.p, VARIANT.Ptr, ResultBlock)
    DiscardResultInfo(ValueTypes)
      => ComCall(16, this.p, SpeechDiscardType, ValueTypes)
}
struct ISpeechRecoResult2 extends ISpeechRecoResult {
    static IID := "{8E0A246D-D3C8-45DE-8657-04290C458C3C}"
    SetTextFeedback(Feedback, WasSuccessful)
      => ComCall(17, this.p, BSTR, Feedback, VARIANT_BOOL, WasSuccessful)
}
struct ISpeechRecoResultTimes extends IDispatch {
    static IID := "{62B3B8FB-F6E7-41BE-BDCB-056B1C29EFC0}"
    get_StreamTime(Time)
      => ComCall(7, this.p, VARIANT.Ptr, Time)
    get_Length(Length)
      => ComCall(8, this.p, VARIANT.Ptr, Length)
    get_TickCount(TickCount)
      => ComCall(9, this.p, Int32.Ptr, TickCount)
    get_OffsetFromStart(OffsetFromStart)
      => ComCall(10, this.p, VARIANT.Ptr, OffsetFromStart)
}
struct ISpeechPhraseAlternate extends IDispatch {
    static IID := "{27864A2A-2B9F-4CB8-92D3-0D2722FD1E73}"
    get_RecoResult(RecoResult)
      => ComCall(7, this.p, ISpeechRecoResult.Ptr, RecoResult)
    get_StartElementInResult(StartElement)
      => ComCall(8, this.p, Int32.Ptr, StartElement)
    get_NumberOfElementsInResult(NumberOfElements)
      => ComCall(9, this.p, Int32.Ptr, NumberOfElements)
    get_PhraseInfo(PhraseInfo)
      => ComCall(10, this.p, ISpeechPhraseInfo.Ptr, PhraseInfo)
    Commit()
      => ComCall(11, this.p)
}
struct ISpeechPhraseAlternates extends IDispatch {
    static IID := "{B238B6D5-F276-4C3D-A6C1-2974801C3CC2}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, PhraseAlternate)
      => ComCall(8, this.p, Int32, Index, ISpeechPhraseAlternate.Ptr, PhraseAlternate)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechPhraseInfo extends IDispatch {
    static IID := "{961559CF-4E67-4662-8BF0-D93F1FCD61B3}"
    get_LanguageId(LanguageId)
      => ComCall(7, this.p, Int32.Ptr, LanguageId)
    get_GrammarId(GrammarId)
      => ComCall(8, this.p, VARIANT.Ptr, GrammarId)
    get_StartTime(StartTime)
      => ComCall(9, this.p, VARIANT.Ptr, StartTime)
    get_AudioStreamPosition(AudioStreamPosition)
      => ComCall(10, this.p, VARIANT.Ptr, AudioStreamPosition)
    get_AudioSizeBytes(pAudioSizeBytes)
      => ComCall(11, this.p, Int32.Ptr, pAudioSizeBytes)
    get_RetainedSizeBytes(RetainedSizeBytes)
      => ComCall(12, this.p, Int32.Ptr, RetainedSizeBytes)
    get_AudioSizeTime(AudioSizeTime)
      => ComCall(13, this.p, Int32.Ptr, AudioSizeTime)
    get_Rule(Rule)
      => ComCall(14, this.p, ISpeechPhraseRule.Ptr, Rule)
    get_Properties(Properties)
      => ComCall(15, this.p, ISpeechPhraseProperties.Ptr, Properties)
    get_Elements(Elements)
      => ComCall(16, this.p, ISpeechPhraseElements.Ptr, Elements)
    get_Replacements(Replacements)
      => ComCall(17, this.p, ISpeechPhraseReplacements.Ptr, Replacements)
    get_EngineId(EngineIdGuid)
      => ComCall(18, this.p, BSTR.Ptr, EngineIdGuid)
    get_EnginePrivateData(PrivateData)
      => ComCall(19, this.p, VARIANT.Ptr, PrivateData)
    SaveToMemory(PhraseBlock)
      => ComCall(20, this.p, VARIANT.Ptr, PhraseBlock)
    GetText(StartElement, Elements, UseReplacements, Text)
      => ComCall(21, this.p, Int32, StartElement, Int32, Elements, VARIANT_BOOL, UseReplacements, BSTR.Ptr, Text)
    GetDisplayAttributes(StartElement, Elements, UseReplacements, DisplayAttributes)
      => ComCall(22, this.p, Int32, StartElement, Int32, Elements, VARIANT_BOOL, UseReplacements, SpeechDisplayAttributes.Ptr, DisplayAttributes)
}
struct ISpeechPhraseElement extends IDispatch {
    static IID := "{E6176F96-E373-4801-B223-3B62C068C0B4}"
    get_AudioTimeOffset(AudioTimeOffset)
      => ComCall(7, this.p, Int32.Ptr, AudioTimeOffset)
    get_AudioSizeTime(AudioSizeTime)
      => ComCall(8, this.p, Int32.Ptr, AudioSizeTime)
    get_AudioStreamOffset(AudioStreamOffset)
      => ComCall(9, this.p, Int32.Ptr, AudioStreamOffset)
    get_AudioSizeBytes(AudioSizeBytes)
      => ComCall(10, this.p, Int32.Ptr, AudioSizeBytes)
    get_RetainedStreamOffset(RetainedStreamOffset)
      => ComCall(11, this.p, Int32.Ptr, RetainedStreamOffset)
    get_RetainedSizeBytes(RetainedSizeBytes)
      => ComCall(12, this.p, Int32.Ptr, RetainedSizeBytes)
    get_DisplayText(DisplayText)
      => ComCall(13, this.p, BSTR.Ptr, DisplayText)
    get_LexicalForm(LexicalForm)
      => ComCall(14, this.p, BSTR.Ptr, LexicalForm)
    get_Pronunciation(Pronunciation)
      => ComCall(15, this.p, VARIANT.Ptr, Pronunciation)
    get_DisplayAttributes(DisplayAttributes)
      => ComCall(16, this.p, SpeechDisplayAttributes.Ptr, DisplayAttributes)
    get_RequiredConfidence(RequiredConfidence)
      => ComCall(17, this.p, SpeechEngineConfidence.Ptr, RequiredConfidence)
    get_ActualConfidence(ActualConfidence)
      => ComCall(18, this.p, SpeechEngineConfidence.Ptr, ActualConfidence)
    get_EngineConfidence(EngineConfidence)
      => ComCall(19, this.p, Float32.Ptr, EngineConfidence)
}
struct ISpeechPhraseElements extends IDispatch {
    static IID := "{0626B328-3478-467D-A0B3-D0853B93DDA3}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Element)
      => ComCall(8, this.p, Int32, Index, ISpeechPhraseElement.Ptr, Element)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechPhraseReplacement extends IDispatch {
    static IID := "{2890A410-53A7-4FB5-94EC-06D4998E3D02}"
    get_DisplayAttributes(DisplayAttributes)
      => ComCall(7, this.p, SpeechDisplayAttributes.Ptr, DisplayAttributes)
    get_Text(Text)
      => ComCall(8, this.p, BSTR.Ptr, Text)
    get_FirstElement(FirstElement)
      => ComCall(9, this.p, Int32.Ptr, FirstElement)
    get_NumberOfElements(NumberOfElements)
      => ComCall(10, this.p, Int32.Ptr, NumberOfElements)
}
struct ISpeechPhraseReplacements extends IDispatch {
    static IID := "{38BC662F-2257-4525-959E-2069D2596C05}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Reps)
      => ComCall(8, this.p, Int32, Index, ISpeechPhraseReplacement.Ptr, Reps)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechPhraseProperty extends IDispatch {
    static IID := "{CE563D48-961E-4732-A2E1-378A42B430BE}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Id(Id)
      => ComCall(8, this.p, Int32.Ptr, Id)
    get_Value(Value)
      => ComCall(9, this.p, VARIANT.Ptr, Value)
    get_FirstElement(FirstElement)
      => ComCall(10, this.p, Int32.Ptr, FirstElement)
    get_NumberOfElements(NumberOfElements)
      => ComCall(11, this.p, Int32.Ptr, NumberOfElements)
    get_EngineConfidence(Confidence)
      => ComCall(12, this.p, Float32.Ptr, Confidence)
    get_Confidence(Confidence)
      => ComCall(13, this.p, SpeechEngineConfidence.Ptr, Confidence)
    get_Parent(ParentProperty)
      => ComCall(14, this.p, ISpeechPhraseProperty.Ptr, ParentProperty)
    get_Children(Children)
      => ComCall(15, this.p, ISpeechPhraseProperties.Ptr, Children)
}
struct ISpeechPhraseProperties extends IDispatch {
    static IID := "{08166B47-102E-4B23-A599-BDB98DBFD1F4}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Property)
      => ComCall(8, this.p, Int32, Index, ISpeechPhraseProperty.Ptr, Property)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechPhraseRule extends IDispatch {
    static IID := "{A7BFE112-A4A0-48D9-B602-C313843F6964}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Id(Id)
      => ComCall(8, this.p, Int32.Ptr, Id)
    get_FirstElement(FirstElement)
      => ComCall(9, this.p, Int32.Ptr, FirstElement)
    get_NumberOfElements(NumberOfElements)
      => ComCall(10, this.p, Int32.Ptr, NumberOfElements)
    get_Parent(Parent)
      => ComCall(11, this.p, ISpeechPhraseRule.Ptr, Parent)
    get_Children(Children)
      => ComCall(12, this.p, ISpeechPhraseRules.Ptr, Children)
    get_Confidence(ActualConfidence)
      => ComCall(13, this.p, SpeechEngineConfidence.Ptr, ActualConfidence)
    get_EngineConfidence(EngineConfidence)
      => ComCall(14, this.p, Float32.Ptr, EngineConfidence)
}
struct ISpeechPhraseRules extends IDispatch {
    static IID := "{9047D593-01DD-4B72-81A3-E4A0CA69F407}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Rule)
      => ComCall(8, this.p, Int32, Index, ISpeechPhraseRule.Ptr, Rule)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechLexicon extends IDispatch {
    static IID := "{3DA7627A-C7AE-4B23-8708-638C50362C25}"
    get_GenerationId(GenerationId)
      => ComCall(7, this.p, Int32.Ptr, GenerationId)
    GetWords(Flags, GenerationID, Words)
      => ComCall(8, this.p, SpeechLexiconType, Flags, Int32.Ptr, GenerationID, ISpeechLexiconWords.Ptr, Words)
    AddPronunciation(bstrWord, LangId, PartOfSpeech, bstrPronunciation)
      => ComCall(9, this.p, BSTR, bstrWord, Int32, LangId, SpeechPartOfSpeech, PartOfSpeech, BSTR, bstrPronunciation)
    AddPronunciationByPhoneIds(bstrWord, LangId, PartOfSpeech, PhoneIds)
      => ComCall(10, this.p, BSTR, bstrWord, Int32, LangId, SpeechPartOfSpeech, PartOfSpeech, VARIANT.Ptr, PhoneIds)
    RemovePronunciation(bstrWord, LangId, PartOfSpeech, bstrPronunciation)
      => ComCall(11, this.p, BSTR, bstrWord, Int32, LangId, SpeechPartOfSpeech, PartOfSpeech, BSTR, bstrPronunciation)
    RemovePronunciationByPhoneIds(bstrWord, LangId, PartOfSpeech, PhoneIds)
      => ComCall(12, this.p, BSTR, bstrWord, Int32, LangId, SpeechPartOfSpeech, PartOfSpeech, VARIANT.Ptr, PhoneIds)
    GetPronunciations(bstrWord, LangId, TypeFlags, ppPronunciations)
      => ComCall(13, this.p, BSTR, bstrWord, Int32, LangId, SpeechLexiconType, TypeFlags, ISpeechLexiconPronunciations.Ptr, ppPronunciations)
    GetGenerationChange(GenerationID, ppWords)
      => ComCall(14, this.p, Int32.Ptr, GenerationID, ISpeechLexiconWords.Ptr, ppWords)
}
struct ISpeechLexiconWords extends IDispatch {
    static IID := "{8D199862-415E-47D5-AC4F-FAA608B424E6}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Word)
      => ComCall(8, this.p, Int32, Index, ISpeechLexiconWord.Ptr, Word)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechLexiconWord extends IDispatch {
    static IID := "{4E5B933C-C9BE-48ED-8842-1EE51BB1D4FF}"
    get_LangId(LangId)
      => ComCall(7, this.p, Int32.Ptr, LangId)
    get_Type(WordType)
      => ComCall(8, this.p, SpeechWordType.Ptr, WordType)
    get_Word(Word)
      => ComCall(9, this.p, BSTR.Ptr, Word)
    get_Pronunciations(Pronunciations)
      => ComCall(10, this.p, ISpeechLexiconPronunciations.Ptr, Pronunciations)
}
struct ISpeechLexiconPronunciations extends IDispatch {
    static IID := "{72829128-5682-4704-A0D4-3E2BB6F2EAD3}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    Item(Index, Pronunciation)
      => ComCall(8, this.p, Int32, Index, ISpeechLexiconPronunciation.Ptr, Pronunciation)
    get__NewEnum(EnumVARIANT)
      => ComCall(9, this.p, IUnknown.Ptr, EnumVARIANT)
}
struct ISpeechLexiconPronunciation extends IDispatch {
    static IID := "{95252C5D-9E43-4F4A-9899-48EE73352F9F}"
    get_Type(LexiconType)
      => ComCall(7, this.p, SpeechLexiconType.Ptr, LexiconType)
    get_LangId(LangId)
      => ComCall(8, this.p, Int32.Ptr, LangId)
    get_PartOfSpeech(PartOfSpeech)
      => ComCall(9, this.p, SpeechPartOfSpeech.Ptr, PartOfSpeech)
    get_PhoneIds(PhoneIds)
      => ComCall(10, this.p, VARIANT.Ptr, PhoneIds)
    get_Symbolic(Symbolic)
      => ComCall(11, this.p, BSTR.Ptr, Symbolic)
}
struct ISpeechXMLRecoResult extends ISpeechRecoResult {
    static IID := "{AAEC54AF-8F85-4924-944D-B79D39D72E19}"
    GetXMLResult(Options, pResult)
      => ComCall(17, this.p, SPXMLRESULTOPTIONS, Options, BSTR.Ptr, pResult)
    GetXMLErrorInfo(LineNumber, ScriptLine, Source, Description, ResultCode, IsError)
      => ComCall(18, this.p, Int32.Ptr, LineNumber, BSTR.Ptr, ScriptLine, BSTR.Ptr, Source, BSTR.Ptr, Description, Int32.Ptr, ResultCode, VARIANT_BOOL.Ptr, IsError)
}
struct ISpeechRecoResultDispatch extends IDispatch {
    static IID := "{6D60EB64-ACED-40A6-BBF3-4E557F71DEE2}"
    get_RecoContext(RecoContext)
      => ComCall(7, this.p, ISpeechRecoContext.Ptr, RecoContext)
    get_Times(Times)
      => ComCall(8, this.p, ISpeechRecoResultTimes.Ptr, Times)
    putref_AudioFormat(Format?)
      => ComCall(9, this.p, ISpeechAudioFormat, Format?)
    get_AudioFormat(Format)
      => ComCall(10, this.p, ISpeechAudioFormat.Ptr, Format)
    get_PhraseInfo(PhraseInfo)
      => ComCall(11, this.p, ISpeechPhraseInfo.Ptr, PhraseInfo)
    Alternates(RequestCount, StartElement, Elements, Alternates)
      => ComCall(12, this.p, Int32, RequestCount, Int32, StartElement, Int32, Elements, ISpeechPhraseAlternates.Ptr, Alternates)
    Audio(StartElement, Elements, Stream)
      => ComCall(13, this.p, Int32, StartElement, Int32, Elements, ISpeechMemoryStream.Ptr, Stream)
    SpeakAudio(StartElement, Elements, Flags, StreamNumber)
      => ComCall(14, this.p, Int32, StartElement, Int32, Elements, SpeechVoiceSpeakFlags, Flags, Int32.Ptr, StreamNumber)
    SaveToMemory(ResultBlock)
      => ComCall(15, this.p, VARIANT.Ptr, ResultBlock)
    DiscardResultInfo(ValueTypes)
      => ComCall(16, this.p, SpeechDiscardType, ValueTypes)
    GetXMLResult(Options, pResult)
      => ComCall(17, this.p, SPXMLRESULTOPTIONS, Options, BSTR.Ptr, pResult)
    GetXMLErrorInfo(LineNumber, ScriptLine, Source, Description, ResultCode, IsError)
      => ComCall(18, this.p, Int32.Ptr, LineNumber, BSTR.Ptr, ScriptLine, BSTR.Ptr, Source, BSTR.Ptr, Description, HRESULT.Ptr, ResultCode, VARIANT_BOOL.Ptr, IsError)
    SetTextFeedback(Feedback, WasSuccessful)
      => ComCall(19, this.p, BSTR, Feedback, VARIANT_BOOL, WasSuccessful)
}
struct ISpeechPhraseInfoBuilder extends IDispatch {
    static IID := "{3B151836-DF3A-4E0A-846C-D2ADC9334333}"
    RestorePhraseFromMemory(PhraseInMemory, PhraseInfo)
      => ComCall(7, this.p, VARIANT.Ptr, PhraseInMemory, ISpeechPhraseInfo.Ptr, PhraseInfo)
}
struct ISpeechPhoneConverter extends IDispatch {
    static IID := "{C3E4F353-433F-43D6-89A1-6A62A7054C3D}"
    get_LanguageId(LanguageId)
      => ComCall(7, this.p, Int32.Ptr, LanguageId)
    put_LanguageId(LanguageId)
      => ComCall(8, this.p, Int32, LanguageId)
    PhoneToId(Phonemes, IdArray)
      => ComCall(9, this.p, BSTR, Phonemes, VARIANT.Ptr, IdArray)
    IdToPhone(IdArray, Phonemes)
      => ComCall(10, this.p, VARIANT, IdArray, BSTR.Ptr, Phonemes)
}
struct ISpTokenUI extends IUnknown {
    static IID := "{F8E690F0-39CB-4843-B8D7-C84696E1119D}"
    IsUISupported(pszTypeOfUI, pvExtraData, cbExtraData, punkObject, pfSupported)
      => ComCall(3, this.p, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, IUnknown, punkObject, BOOL.Ptr, pfSupported)
    DisplayUI(hwndParent, pszTitle?, pszTypeOfUI, pvExtraData, cbExtraData, pToken, punkObject)
      => ComCall(4, this.p, HWND, hwndParent, "Str", pszTitle?, "Str", pszTypeOfUI, Struct.Ptr, pvExtraData, UInt32, cbExtraData, ISpObjectToken, pToken, IUnknown, punkObject)
}
struct ISpObjectTokenEnumBuilder extends IEnumSpObjectTokens {
    static IID := "{06B64F9F-7FDA-11D2-B4F2-00C04F797396}"
    SetAttribs(pszReqAttribs?, pszOptAttribs?)
      => ComCall(9, this.p, "Str", pszReqAttribs?, "Str", pszOptAttribs?)
    AddTokens(cTokens, pToken)
      => ComCall(10, this.p, UInt32, cTokens, ISpObjectToken.Ptr, pToken)
    AddTokensFromDataKey(pDataKey, pszSubKey, pszCategoryId)
      => ComCall(11, this.p, ISpDataKey, pDataKey, "Str", pszSubKey, "Str", pszCategoryId)
    AddTokensFromTokenEnum(pTokenEnum)
      => ComCall(12, this.p, IEnumSpObjectTokens, pTokenEnum)
    Sort(pszTokenIdToListFirst)
      => ComCall(13, this.p, "Str", pszTokenIdToListFirst)
}
struct ISpErrorLog extends IUnknown {
    static IID := "{F4711347-E608-11D2-A086-00C04F8EF9B5}"
    AddError(lLineNumber, hr, pszDescription, pszHelpFile?, dwHelpContext)
      => ComCall(3, this.p, Int32, lLineNumber, HRESULT, hr, "Str", pszDescription, "Str", pszHelpFile?, UInt32, dwHelpContext)
}
struct ISpGrammarCompiler extends IUnknown {
    static IID := "{B1E29D58-A675-11D2-8302-00C04F8EE6C0}"
    CompileStream(pSource, pDest, pHeader?, pReserved?, pErrorLog?, dwFlags)
      => ComCall(3, this.p, IStream, pSource, IStream, pDest, IStream, pHeader?, IUnknown, pReserved?, ISpErrorLog, pErrorLog?, UInt32, dwFlags)
}
struct ISpGramCompBackend extends ISpGrammarBuilder {
    static IID := "{3DDCA27C-665C-4786-9F97-8C90C3488B61}"
    SetSaveObjects(pStream, pErrorLog)
      => ComCall(11, this.p, IStream, pStream, ISpErrorLog, pErrorLog)
    InitFromBinaryGrammar(pBinaryData)
      => ComCall(12, this.p, SPBINARYGRAMMAR.Ptr, pBinaryData)
}
struct ISpITNProcessor extends IUnknown {
    static IID := "{12D7360F-A1C9-11D3-BC90-00C04F72DF9F}"
    LoadITNGrammar(pszCLSID)
      => ComCall(3, this.p, "Str", pszCLSID)
    ITNPhrase(pPhrase)
      => ComCall(4, this.p, ISpPhraseBuilder, pPhrase)
}
struct ISpPhraseBuilder extends ISpPhrase {
    static IID := "{88A3342A-0BED-4834-922B-88D43173162F}"
    InitFromPhrase(pPhrase)
      => ComCall(7, this.p, SPPHRASE.Ptr, pPhrase)
    InitFromSerializedPhrase(pPhrase)
      => ComCall(8, this.p, SPSERIALIZEDPHRASE.Ptr, pPhrase)
    AddElements(cElements, pElement)
      => ComCall(9, this.p, UInt32, cElements, SPPHRASEELEMENT.Ptr, pElement)
    AddRules(hParent, pRule, phNewRule)
      => ComCall(10, this.p, SPPHRASERULEHANDLE, hParent, SPPHRASERULE.Ptr, pRule, SPPHRASERULEHANDLE.Ptr, phNewRule)
    AddProperties(hParent, pProperty, phNewProperty)
      => ComCall(11, this.p, SPPHRASEPROPERTYHANDLE, hParent, SPPHRASEPROPERTY.Ptr, pProperty, SPPHRASEPROPERTYHANDLE.Ptr, phNewProperty)
    AddReplacements(cReplacements, pReplacements)
      => ComCall(12, this.p, UInt32, cReplacements, SPPHRASEREPLACEMENT.Ptr, pReplacements)
}
struct ISpTask extends InterfacePointer {
    Execute(pvTaskData, pfContinueProcessing)
      => ComCall(0, this.p, Struct.Ptr, pvTaskData, Int32.Ptr, pfContinueProcessing)
}
struct ISpThreadTask extends InterfacePointer {
    InitThread(pvTaskData, hwnd1)
      => ComCall(0, this.p, Struct.Ptr, pvTaskData, HWND, hwnd1)
    ThreadProc(pvTaskData, hExitThreadEvent, hNotifyEvent, hwndWorker, pfContinueProcessing)
      => ComCall(1, this.p, Struct.Ptr, pvTaskData, HANDLE, hExitThreadEvent, HANDLE, hNotifyEvent, HWND, hwndWorker, Int32.Ptr, pfContinueProcessing)
    WindowMessage(pvTaskData, hWnd1, Msg, wParam1, lParam1)
      => ComCall(2, this.p, Struct.Ptr, pvTaskData, HWND, hWnd1, UInt32, Msg, WPARAM, wParam1, LPARAM, lParam1, LRESULT)
}
struct ISpThreadControl extends ISpNotifySink {
    static IID := "{A6BE4D73-4403-4358-B22D-0346E23B1764}"
    StartThread(dwFlags, phwnd)
      => ComCall(4, this.p, UInt32, dwFlags, HWND.Ptr, phwnd)
    WaitForThreadDone(fForceStop, phrThreadResult, msTimeOut)
      => ComCall(5, this.p, BOOL, fForceStop, HRESULT.Ptr, phrThreadResult, UInt32, msTimeOut)
    TerminateThread()
      => ComCall(6, this.p)
    ThreadHandle()
      => ComCall(7, this.p, HANDLE)
    ThreadId()
      => ComCall(8, this.p, UInt32)
    NotifyEvent()
      => ComCall(9, this.p, HANDLE)
    WindowHandle()
      => ComCall(10, this.p, HWND)
    ThreadCompleteEvent()
      => ComCall(11, this.p, HANDLE)
    ExitThreadEvent()
      => ComCall(12, this.p, HANDLE)
}
struct SPTMTHREADINFO {
    lPoolSize : Int32
    lPriority : Int32
    ulConcurrencyLimit : UInt32
    ulMaxQuickAllocThreads : UInt32
}
struct ISpTaskManager extends IUnknown {
    static IID := "{2BAEEF81-2CA3-4331-98F3-26EC5ABEFB03}"
    SetThreadPoolInfo(pPoolInfo)
      => ComCall(3, this.p, SPTMTHREADINFO.Ptr, pPoolInfo)
    GetThreadPoolInfo(pPoolInfo)
      => ComCall(4, this.p, SPTMTHREADINFO.Ptr, pPoolInfo)
    QueueTask(pTask, pvTaskData, hCompEvent, pdwGroupId, pTaskID)
      => ComCall(5, this.p, ISpTask, pTask, Struct.Ptr, pvTaskData, HANDLE, hCompEvent, UInt32.Ptr, pdwGroupId, UInt32.Ptr, pTaskID)
    CreateReoccurringTask(pTask, pvTaskData, hCompEvent, ppTaskCtrl)
      => ComCall(6, this.p, ISpTask, pTask, Struct.Ptr, pvTaskData, HANDLE, hCompEvent, ISpNotifySink.Ptr, ppTaskCtrl)
    CreateThreadControl(pTask, pvTaskData, nPriority, ppTaskCtrl)
      => ComCall(7, this.p, ISpThreadTask, pTask, Struct.Ptr, pvTaskData, Int32, nPriority, ISpThreadControl.Ptr, ppTaskCtrl)
    TerminateTask(dwTaskId, ulWaitPeriod)
      => ComCall(8, this.p, UInt32, dwTaskId, UInt32, ulWaitPeriod)
    TerminateTaskGroup(dwGroupId, ulWaitPeriod)
      => ComCall(9, this.p, UInt32, dwGroupId, UInt32, ulWaitPeriod)
}
struct SPVSKIPTYPE extends Int32 {
    static SPVST_SENTENCE := 1
}
struct SPVESACTIONS extends Int32 {
    static SPVES_CONTINUE := 0
    static SPVES_ABORT := 1
    static SPVES_SKIP := 2
    static SPVES_RATE := 4
    static SPVES_VOLUME := 8
}
struct ISpTTSEngineSite extends ISpEventSink {
    static IID := "{9880499B-CCE9-11D2-B503-00C04F797396}"
    GetActions()
      => ComCall(5, this.p, UInt32)
    Write(pBuff, cb, pcbWritten)
      => ComCall(6, this.p, Struct.Ptr, pBuff, UInt32, cb, UInt32.Ptr, pcbWritten)
    GetRate(pRateAdjust)
      => ComCall(7, this.p, Int32.Ptr, pRateAdjust)
    GetVolume(pusVolume)
      => ComCall(8, this.p, UInt16.Ptr, pusVolume)
    GetSkipInfo(peType, plNumItems)
      => ComCall(9, this.p, SPVSKIPTYPE.Ptr, peType, Int32.Ptr, plNumItems)
    CompleteSkip(ulNumSkipped)
      => ComCall(10, this.p, Int32, ulNumSkipped)
}
struct SPVTEXTFRAG {
    pNext : SPVTEXTFRAG.Ptr
    State : SPVSTATE
    pTextStart : PWSTR
    ulTextLen : UInt32
    ulTextSrcOffset : UInt32
}
struct ISpTTSEngine extends IUnknown {
    static IID := "{A74D7C8E-4CC5-4F2F-A6EB-804DEE18500E}"
    Speak(dwSpeakFlags, rguidFormatId, pWaveFormatEx, pTextFragList, pOutputSite)
      => ComCall(3, this.p, UInt32, dwSpeakFlags, GUID.Ptr, rguidFormatId, WAVEFORMATEX.Ptr, pWaveFormatEx, SPVTEXTFRAG.Ptr, pTextFragList, ISpTTSEngineSite, pOutputSite)
    GetOutputFormat(pTargetFmtId, pTargetWaveFormatEx, pOutputFormatId, ppCoMemOutputWaveFormatEx)
      => ComCall(4, this.p, GUID.Ptr, pTargetFmtId, WAVEFORMATEX.Ptr, pTargetWaveFormatEx, GUID.Ptr, pOutputFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemOutputWaveFormatEx)
}
struct SPWORDENTRY {
    hWord : SPWORDHANDLE
    LangID : UInt16
    pszDisplayText : PWSTR
    pszLexicalForm : PWSTR
    aPhoneId : UInt16.Ptr
    pvClientContext : Struct.Ptr
}
struct SPRULEENTRY {
    hRule : SPRULEHANDLE
    hInitialState : SPSTATEHANDLE
    Attributes : UInt32
    pvClientRuleContext : Struct.Ptr
    pvClientGrammarContext : Struct.Ptr
}
struct SPTRANSITIONTYPE extends Int32 {
    static SPTRANSEPSILON := 0
    static SPTRANSWORD := 1
    static SPTRANSRULE := 2
    static SPTRANSTEXTBUF := 3
    static SPTRANSWILDCARD := 4
    static SPTRANSDICTATION := 5
}
struct SPTRANSITIONENTRY {
    ID : SPTRANSITIONID
    hNextState : SPSTATEHANDLE
    Type : UInt8
    RequiredConfidence : UInt8
    Anonymous1 : this._Anonymous1_e__Struct
    Weight : Float32
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Struct {
        fHasProperty : UInt32
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
            Anonymous3 : this._Anonymous3_e__Struct
        }
        struct _Anonymous1_e__Struct {
            hRuleInitialState : SPSTATEHANDLE
            hRule : SPRULEHANDLE
            pvClientRuleContext : Struct.Ptr
        }
        struct _Anonymous2_e__Struct {
            hWord : SPWORDHANDLE
            pvClientWordContext : Struct.Ptr
        }
        struct _Anonymous3_e__Struct {
            pvGrammarCookie : Struct.Ptr
        }
    }
}
struct SPTRANSITIONPROPERTY {
    pszName : PWSTR
    ulId : UInt32
    pszValue : PWSTR
    vValue : VARIANT
}
struct SPSTATEINFO {
    cAllocatedEntries : UInt32
    pTransitions : SPTRANSITIONENTRY.Ptr
    cEpsilons : UInt32
    cRules : UInt32
    cWords : UInt32
    cSpecialTransitions : UInt32
}
struct SPPATHENTRY {
    hTransition : SPTRANSITIONID
    elem : SPPHRASEELEMENT
}
struct ISpCFGInterpreterSite extends IUnknown {
    static IID := "{6A6FFAD8-78B6-473D-B844-98152E4FB16B}"
    AddTextReplacement(pReplace)
      => ComCall(3, this.p, SPPHRASEREPLACEMENT.Ptr, pReplace)
    AddProperty(pProperty)
      => ComCall(4, this.p, SPPHRASEPROPERTY.Ptr, pProperty)
    GetResourceValue(pszResourceName, ppCoMemResource)
      => ComCall(5, this.p, "Str", pszResourceName, PWSTR.Ptr, ppCoMemResource)
}
struct ISpCFGInterpreter extends IUnknown {
    static IID := "{F3D3F926-11FC-11D3-BB97-00C04F8EE6C0}"
    InitGrammar(pszGrammarName, pvGrammarData)
      => ComCall(3, this.p, "Str", pszGrammarName, Struct.Ptr.Ptr, pvGrammarData)
    Interpret(pPhrase, ulFirstElement, ulCountOfElements, pSite)
      => ComCall(4, this.p, ISpPhraseBuilder, pPhrase, UInt32, ulFirstElement, UInt32, ulCountOfElements, ISpCFGInterpreterSite, pSite)
}
struct SPCFGNOTIFY extends Int32 {
    static SPCFGN_ADD := 0
    static SPCFGN_REMOVE := 1
    static SPCFGN_INVALIDATE := 2
    static SPCFGN_ACTIVATE := 3
    static SPCFGN_DEACTIVATE := 4
}
struct SPRESULTTYPE extends Int32 {
    static SPRT_CFG := 0
    static SPRT_SLM := 1
    static SPRT_PROPRIETARY := 2
    static SPRT_FALSE_RECOGNITION := 4
    static SPRT_TYPE_MASK := 3
    static SPRT_EMULATED := 8
    static SPRT_EXTENDABLE_PARSE := 16
}
struct SPPHRASEALT {
    pPhrase : ISpPhraseBuilder
    ulStartElementInParent : UInt32
    cElementsInParent : UInt32
    cElementsInAlternate : UInt32
    pvAltExtra : Struct.Ptr
    cbAltExtra : UInt32
}
struct SPRECORESULTINFO {
    cbSize : UInt32 := this.Size
    eResultType : SPRESULTTYPE
    fHypothesis : BOOL
    fProprietaryAutoPause : BOOL
    ullStreamPosStart : Int64
    ullStreamPosEnd : Int64
    hGrammar : SPGRAMMARHANDLE
    ulSizeEngineData : UInt32
    pvEngineData : Struct.Ptr
    pPhrase : ISpPhraseBuilder
    aPhraseAlts : SPPHRASEALT.Ptr
    ulNumAlts : UInt32
}
struct SPRECORESULTINFOEX {
    Base : SPRECORESULTINFO
    ullStreamTimeStart : Int64
    ullStreamTimeEnd : Int64
}
struct SPWORDINFOOPT extends Int32 {
    static SPWIO_NONE := 0
    static SPWIO_WANT_TEXT := 1
}
struct SPRULEINFOOPT extends Int32 {
    static SPRIO_NONE := 0
}
struct SPPARSEINFO {
    cbSize : UInt32 := this.Size
    hRule : SPRULEHANDLE
    ullAudioStreamPosition : Int64
    ulAudioSize : UInt32
    cTransitions : UInt32
    pPath : SPPATHENTRY.Ptr
    SREngineID : GUID
    ulSREnginePrivateDataSize : UInt32
    pSREnginePrivateData : UInt8.Ptr
    fHypothesis : BOOL
}
struct ISpSREngineSite extends IUnknown {
    static IID := "{3B414AEC-720C-4883-B9EF-178CD394FB3A}"
    Read(pv, cb, pcbRead)
      => ComCall(3, this.p, Struct.Ptr, pv, UInt32, cb, UInt32.Ptr, pcbRead)
    DataAvailable(pcb)
      => ComCall(4, this.p, UInt32.Ptr, pcb)
    SetBufferNotifySize(cbSize)
      => ComCall(5, this.p, UInt32, cbSize)
    ParseFromTransitions(pParseInfo, ppNewPhrase)
      => ComCall(6, this.p, SPPARSEINFO.Ptr, pParseInfo, ISpPhraseBuilder.Ptr, ppNewPhrase)
    Recognition(pResultInfo)
      => ComCall(7, this.p, SPRECORESULTINFO.Ptr, pResultInfo)
    AddEvent(pEvent, hSAPIRecoContext)
      => ComCall(8, this.p, SPEVENT.Ptr, pEvent, SPRECOCONTEXTHANDLE, hSAPIRecoContext)
    Synchronize(ullProcessedThruPos)
      => ComCall(9, this.p, Int64, ullProcessedThruPos)
    GetWordInfo(pWordEntry, Options)
      => ComCall(10, this.p, SPWORDENTRY.Ptr, pWordEntry, SPWORDINFOOPT, Options)
    SetWordClientContext(hWord, pvClientContext)
      => ComCall(11, this.p, SPWORDHANDLE, hWord, Struct.Ptr, pvClientContext)
    GetRuleInfo(pRuleEntry, Options)
      => ComCall(12, this.p, SPRULEENTRY.Ptr, pRuleEntry, SPRULEINFOOPT, Options)
    SetRuleClientContext(hRule, pvClientContext)
      => ComCall(13, this.p, SPRULEHANDLE, hRule, Struct.Ptr, pvClientContext)
    GetStateInfo(hState, pStateInfo)
      => ComCall(14, this.p, SPSTATEHANDLE, hState, SPSTATEINFO.Ptr, pStateInfo)
    GetResource(hRule, pszResourceName, ppCoMemResource)
      => ComCall(15, this.p, SPRULEHANDLE, hRule, "Str", pszResourceName, PWSTR.Ptr, ppCoMemResource)
    GetTransitionProperty(ID, ppCoMemProperty)
      => ComCall(16, this.p, SPTRANSITIONID, ID, SPTRANSITIONPROPERTY.Ptr.Ptr, ppCoMemProperty)
    IsAlternate(hRule, hAltRule)
      => ComCall(17, this.p, SPRULEHANDLE, hRule, SPRULEHANDLE, hAltRule)
    GetMaxAlternates(hRule, pulNumAlts)
      => ComCall(18, this.p, SPRULEHANDLE, hRule, UInt32.Ptr, pulNumAlts)
    GetContextMaxAlternates(hContext, pulNumAlts)
      => ComCall(19, this.p, SPRECOCONTEXTHANDLE, hContext, UInt32.Ptr, pulNumAlts)
    UpdateRecoPos(ullCurrentRecoPos)
      => ComCall(20, this.p, Int64, ullCurrentRecoPos)
}
struct ISpSREngineSite2 extends ISpSREngineSite {
    static IID := "{7BC6E012-684A-493E-BDD4-2BF5FBF48CFE}"
    AddEventEx(pEvent, hSAPIRecoContext)
      => ComCall(21, this.p, SPEVENTEX.Ptr, pEvent, SPRECOCONTEXTHANDLE, hSAPIRecoContext)
    UpdateRecoPosEx(ullCurrentRecoPos, ullCurrentRecoTime)
      => ComCall(22, this.p, Int64, ullCurrentRecoPos, Int64, ullCurrentRecoTime)
    GetRuleTransition(ulGrammarID, RuleIndex, pTrans)
      => ComCall(23, this.p, UInt32, ulGrammarID, UInt32, RuleIndex, SPTRANSITIONENTRY.Ptr, pTrans)
    RecognitionEx(pResultInfo)
      => ComCall(24, this.p, SPRECORESULTINFOEX.Ptr, pResultInfo)
}
struct SPPROPSRC extends Int32 {
    static SPPROPSRC_RECO_INST := 0
    static SPPROPSRC_RECO_CTX := 1
    static SPPROPSRC_RECO_GRAMMAR := 2
}
struct ISpSREngine extends IUnknown {
    static IID := "{2F472991-854B-4465-B613-FBAFB3AD8ED8}"
    SetSite(pSite)
      => ComCall(3, this.p, ISpSREngineSite, pSite)
    GetInputAudioFormat(pguidSourceFormatId, pSourceWaveFormatEx, pguidDesiredFormatId, ppCoMemDesiredWaveFormatEx)
      => ComCall(4, this.p, GUID.Ptr, pguidSourceFormatId, WAVEFORMATEX.Ptr, pSourceWaveFormatEx, GUID.Ptr, pguidDesiredFormatId, WAVEFORMATEX.Ptr.Ptr, ppCoMemDesiredWaveFormatEx)
    RecognizeStream(rguidFmtId, pWaveFormatEx, hRequestSync, hDataAvailable, hExit, fNewAudioStream, fRealTimeAudio, pAudioObjectToken)
      => ComCall(5, this.p, GUID.Ptr, rguidFmtId, WAVEFORMATEX.Ptr, pWaveFormatEx, HANDLE, hRequestSync, HANDLE, hDataAvailable, HANDLE, hExit, BOOL, fNewAudioStream, BOOL, fRealTimeAudio, ISpObjectToken, pAudioObjectToken)
    SetRecoProfile(pProfile)
      => ComCall(6, this.p, ISpObjectToken, pProfile)
    OnCreateGrammar(pvEngineRecoContext, hSAPIGrammar, ppvEngineGrammarContext)
      => ComCall(7, this.p, Struct.Ptr, pvEngineRecoContext, SPGRAMMARHANDLE, hSAPIGrammar, Struct.Ptr.Ptr, ppvEngineGrammarContext)
    OnDeleteGrammar(pvEngineGrammar)
      => ComCall(8, this.p, Struct.Ptr, pvEngineGrammar)
    LoadProprietaryGrammar(pvEngineGrammar, rguidParam, pszStringParam, pvDataParam, ulDataSize, Options)
      => ComCall(9, this.p, Struct.Ptr, pvEngineGrammar, GUID.Ptr, rguidParam, "Str", pszStringParam, Struct.Ptr, pvDataParam, UInt32, ulDataSize, SPLOADOPTIONS, Options)
    UnloadProprietaryGrammar(pvEngineGrammar)
      => ComCall(10, this.p, Struct.Ptr, pvEngineGrammar)
    SetProprietaryRuleState(pvEngineGrammar, pszName, pReserved, NewState, pcRulesChanged)
      => ComCall(11, this.p, Struct.Ptr, pvEngineGrammar, "Str", pszName, Struct.Ptr, pReserved, SPRULESTATE, NewState, UInt32.Ptr, pcRulesChanged)
    SetProprietaryRuleIdState(pvEngineGrammar, dwRuleId, NewState)
      => ComCall(12, this.p, Struct.Ptr, pvEngineGrammar, UInt32, dwRuleId, SPRULESTATE, NewState)
    LoadSLM(pvEngineGrammar, pszTopicName)
      => ComCall(13, this.p, Struct.Ptr, pvEngineGrammar, "Str", pszTopicName)
    UnloadSLM(pvEngineGrammar)
      => ComCall(14, this.p, Struct.Ptr, pvEngineGrammar)
    SetSLMState(pvEngineGrammar, NewState)
      => ComCall(15, this.p, Struct.Ptr, pvEngineGrammar, SPRULESTATE, NewState)
    SetWordSequenceData(pvEngineGrammar, pText, pInfo)
      => ComCall(16, this.p, Struct.Ptr, pvEngineGrammar, "Str", pText, UInt32, pText.Length, SPTEXTSELECTIONINFO.Ptr, pInfo)
    SetTextSelection(pvEngineGrammar, pInfo)
      => ComCall(17, this.p, Struct.Ptr, pvEngineGrammar, SPTEXTSELECTIONINFO.Ptr, pInfo)
    IsPronounceable(pvEngineGrammar, pszWord, pWordPronounceable)
      => ComCall(18, this.p, Struct.Ptr, pvEngineGrammar, "Str", pszWord, SPWORDPRONOUNCEABLE.Ptr, pWordPronounceable)
    OnCreateRecoContext(hSAPIRecoContext, ppvEngineContext)
      => ComCall(19, this.p, SPRECOCONTEXTHANDLE, hSAPIRecoContext, Struct.Ptr.Ptr, ppvEngineContext)
    OnDeleteRecoContext(pvEngineContext)
      => ComCall(20, this.p, Struct.Ptr, pvEngineContext)
    PrivateCall(pvEngineContext, pCallFrame, ulCallFrameSize)
      => ComCall(21, this.p, Struct.Ptr, pvEngineContext, Struct.Ptr, pCallFrame, UInt32, ulCallFrameSize)
    SetAdaptationData(pvEngineContext, pAdaptationData)
      => ComCall(22, this.p, Struct.Ptr, pvEngineContext, "Str", pAdaptationData, UInt32, pAdaptationData.Length)
    SetPropertyNum(eSrc, pvSrcObj, pName, lValue)
      => ComCall(23, this.p, SPPROPSRC, eSrc, Struct.Ptr, pvSrcObj, "Str", pName, Int32, lValue)
    GetPropertyNum(eSrc, pvSrcObj, pName, lValue)
      => ComCall(24, this.p, SPPROPSRC, eSrc, Struct.Ptr, pvSrcObj, "Str", pName, Int32.Ptr, lValue)
    SetPropertyString(eSrc, pvSrcObj, pName, pValue)
      => ComCall(25, this.p, SPPROPSRC, eSrc, Struct.Ptr, pvSrcObj, "Str", pName, "Str", pValue)
    GetPropertyString(eSrc, pvSrcObj, pName, ppCoMemValue)
      => ComCall(26, this.p, SPPROPSRC, eSrc, Struct.Ptr, pvSrcObj, "Str", pName, PWSTR.Ptr, ppCoMemValue)
    SetGrammarState(pvEngineGrammar, eGrammarState)
      => ComCall(27, this.p, Struct.Ptr, pvEngineGrammar, SPGRAMMARSTATE, eGrammarState)
    WordNotify(Action, cWords, pWords)
      => ComCall(28, this.p, SPCFGNOTIFY, Action, UInt32, cWords, SPWORDENTRY.Ptr, pWords)
    RuleNotify(Action, cRules, pRules)
      => ComCall(29, this.p, SPCFGNOTIFY, Action, UInt32, cRules, SPRULEENTRY.Ptr, pRules)
    PrivateCallEx(pvEngineContext, pInCallFrame, ulInCallFrameSize, ppvCoMemResponse, pulResponseSize)
      => ComCall(30, this.p, Struct.Ptr, pvEngineContext, Struct.Ptr, pInCallFrame, UInt32, ulInCallFrameSize, Struct.Ptr.Ptr, ppvCoMemResponse, UInt32.Ptr, pulResponseSize)
    SetContextState(pvEngineContext, eContextState)
      => ComCall(31, this.p, Struct.Ptr, pvEngineContext, SPCONTEXTSTATE, eContextState)
}
struct ISpSREngine2 extends ISpSREngine {
    static IID := "{7BA627D8-33F9-4375-90C5-9985AEE5EDE5}"
    PrivateCallImmediate(pvEngineContext, pInCallFrame, ulInCallFrameSize, ppvCoMemResponse, pulResponseSize)
      => ComCall(32, this.p, Struct.Ptr, pvEngineContext, Struct.Ptr, pInCallFrame, UInt32, ulInCallFrameSize, Struct.Ptr.Ptr, ppvCoMemResponse, UInt32.Ptr, pulResponseSize)
    SetAdaptationData2(pvEngineContext, pAdaptationData, pTopicName, eSettings, eRelevance)
      => ComCall(33, this.p, Struct.Ptr, pvEngineContext, "Str", pAdaptationData, UInt32, pAdaptationData.Length, "Str", pTopicName, SPADAPTATIONSETTINGS, eSettings, SPADAPTATIONRELEVANCE, eRelevance)
    SetGrammarPrefix(pvEngineGrammar, pszPrefix?, fIsPrefixRequired)
      => ComCall(34, this.p, Struct.Ptr, pvEngineGrammar, "Str", pszPrefix?, BOOL, fIsPrefixRequired)
    SetRulePriority(hRule, pvClientRuleContext, nRulePriority)
      => ComCall(35, this.p, SPRULEHANDLE, hRule, Struct.Ptr, pvClientRuleContext, Int32, nRulePriority)
    EmulateRecognition(pPhrase, dwCompareFlags)
      => ComCall(36, this.p, ISpPhrase, pPhrase, UInt32, dwCompareFlags)
    SetSLMWeight(pvEngineGrammar, flWeight)
      => ComCall(37, this.p, Struct.Ptr, pvEngineGrammar, Float32, flWeight)
    SetRuleWeight(hRule, pvClientRuleContext, flWeight)
      => ComCall(38, this.p, SPRULEHANDLE, hRule, Struct.Ptr, pvClientRuleContext, Float32, flWeight)
    SetTrainingState(fDoingTraining, fAdaptFromTrainingData)
      => ComCall(39, this.p, BOOL, fDoingTraining, BOOL, fAdaptFromTrainingData)
    ResetAcousticModelAdaptation()
      => ComCall(40, this.p)
    OnLoadCFG(pvEngineGrammar, pGrammarData, ulGrammarID)
      => ComCall(41, this.p, Struct.Ptr, pvEngineGrammar, SPBINARYGRAMMAR.Ptr, pGrammarData, UInt32, ulGrammarID)
    OnUnloadCFG(pvEngineGrammar, ulGrammarID)
      => ComCall(42, this.p, Struct.Ptr, pvEngineGrammar, UInt32, ulGrammarID)
}
struct SPPHRASEALTREQUEST {
    ulStartElement : UInt32
    cElements : UInt32
    ulRequestAltCount : UInt32
    pvResultExtra : Struct.Ptr
    cbResultExtra : UInt32
    pPhrase : ISpPhrase
    pRecoContext : ISpRecoContext
}
struct ISpSRAlternates extends IUnknown {
    static IID := "{FECE8294-2BE1-408F-8E68-2DE377092F0E}"
    GetAlternates(pAltRequest, ppAlts, pcAlts)
      => ComCall(3, this.p, SPPHRASEALTREQUEST.Ptr, pAltRequest, SPPHRASEALT.Ptr.Ptr, ppAlts, UInt32.Ptr, pcAlts)
    Commit(pAltRequest, pAlt, ppvResultExtra, pcbResultExtra)
      => ComCall(4, this.p, SPPHRASEALTREQUEST.Ptr, pAltRequest, SPPHRASEALT.Ptr, pAlt, Struct.Ptr.Ptr, ppvResultExtra, UInt32.Ptr, pcbResultExtra)
}
struct ISpSRAlternates2 extends ISpSRAlternates {
    static IID := "{F338F437-CB33-4020-9CAB-C71FF9CE12D3}"
    CommitText(pAltRequest, pcszNewText?, commitFlags)
      => ComCall(5, this.p, SPPHRASEALTREQUEST.Ptr, pAltRequest, "Str", pcszNewText?, SPCOMMITFLAGS, commitFlags)
}
struct ISpPrivateEngineCall extends IUnknown {
    static IID := "{8E7C791E-4467-11D3-9723-00C04F72DB08}"
    CallEngine(pCallFrame)
      => ComCall(3, this.p, Struct.Ptr, pCallFrame, UInt32, pCallFrame.Size)
    CallEngineEx(pInFrame, ppCoMemOutFrame, pulOutFrameSize)
      => ComCall(4, this.p, Struct.Ptr, pInFrame, UInt32, pInFrame.Size, Struct.Ptr.Ptr, ppCoMemOutFrame, UInt32.Ptr, pulOutFrameSize)
}
struct ISpPrivateEngineCallEx extends IUnknown {
    static IID := "{DEFD682A-FE0A-42B9-BFA1-56D3D6CECFAF}"
    CallEngineSynchronize(pInFrame, ppCoMemOutFrame, pulOutFrameSize)
      => ComCall(3, this.p, Struct.Ptr, pInFrame, UInt32, pInFrame.Size, Struct.Ptr.Ptr, ppCoMemOutFrame, UInt32.Ptr, pulOutFrameSize)
    CallEngineImmediate(pInFrame, ppCoMemOutFrame, pulOutFrameSize)
      => ComCall(4, this.p, Struct.Ptr, pInFrame, UInt32, pInFrame.Size, Struct.Ptr.Ptr, ppCoMemOutFrame, UInt32.Ptr, pulOutFrameSize)
}
